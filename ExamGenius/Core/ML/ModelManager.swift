import Foundation
import llama

@MainActor
class ModelManager: ObservableObject {
    static let shared = ModelManager()
    @Published private(set) var isModelLoaded: Bool = false
    
    private var model: OpaquePointer?
    private var context: OpaquePointer?
    private var sampler: UnsafeMutablePointer<llama_sampler>?
    
    private let contextSize: UInt32 = 2048
    
    func testModel() async -> Bool {
        if let modelPath = Bundle.main.path(forResource: "mistral-instruct-v2", ofType: "gguf") {
            print("✅ Modèle trouvé: \(modelPath)")
            
            if let cString = modelPath.cString(using: .utf8) {
                let modelParams = llama_model_default_params()
                model = llama_load_model_from_file(cString, modelParams)
                guard let model = model else {
                    print("❌ Échec chargement modèle")
                    return false
                }
                print("✅ Modèle chargé")
                
                var ctxParams = llama_context_default_params()
                ctxParams.n_ctx = contextSize
                ctxParams.n_batch = contextSize
                
                context = llama_new_context_with_model(model, ctxParams)
                guard context != nil else {
                    print("❌ Échec création contexte")
                    return false
                }
                
                let sparams = llama_sampler_chain_default_params()
                sampler = llama_sampler_chain_init(sparams)
                
                if let smpl = sampler {
                    llama_sampler_chain_add(smpl, llama_sampler_init_greedy())
                    print("📊 Paramètres du sampler initialisés")
                }
                
                print("✅ Contexte créé")
                isModelLoaded = true
                return true
            }
        }
        return false
    }
    
    func generateResponse(from input: String) async -> String {
        guard let ctx = context, let mdl = model, let smpl = sampler else {
            return "Erreur: Modèle non initialisé"
        }
        
        let prompt = "[INST] \(input) [/INST]"
        print("📝 Prompt: \(prompt)")
        
        guard let promptData = prompt.data(using: .utf8) else {
            return "Erreur d'encodage"
        }
        
        let promptBytes = Array(promptData).map { Int8(bitPattern: $0) }
        var tokens = [llama_token](repeating: 0, count: 2048)
        let numTokens = llama_tokenize(mdl, promptBytes, Int32(promptBytes.count), &tokens, 2048, true, false)
        
        guard numTokens > 0 else {
            return "Erreur de tokenization"
        }
        
        print("🔤 Nombre de tokens: \(numTokens)")
        var response = ""
        var n_past = 0
        
        // Traiter le prompt
        var batch = llama_batch_init(numTokens, 0, 1)
        defer { llama_batch_free(batch) }
        
        for i in 0..<Int(numTokens) {
            batch.token[i] = tokens[i]
            batch.pos[i] = Int32(i)
            batch.n_tokens += 1
            batch.logits[i] = i == Int(numTokens) - 1 ? 1 : 0
        }
        
        print("🔄 Décodage du prompt")
        if llama_decode(ctx, batch) == 0 {
            print("✅ Prompt décodé")
            n_past = Int(numTokens)
            
            print("🎲 Début génération")
            
            // Génération token par token
            for _ in 0..<100 {
                if let logits = llama_get_logits(ctx) {
                    let vocabSize = Int(llama_n_vocab(mdl))
                    
                    // Trouver le meilleur token
                    var maxToken: llama_token = 0
                    var maxLogit = -Float.infinity
                    
                    for j in 0..<vocabSize {
                        if logits[j] > maxLogit {
                            maxLogit = logits[j]
                            maxToken = llama_token(j)
                        }
                    }
                    
                    print("🎯 Token sélectionné: \(maxToken)")
                    
                    if llama_token_is_eog(mdl, maxToken) {
                        print("🏁 Fin de génération détectée")
                        break
                    }
                    
                    // Convertir en texte
                    var buf = [Int8](repeating: 0, count: 8)
                    let n = llama_token_to_piece(mdl, maxToken, &buf, Int32(buf.count), 0, false)
                    
                    if n > 0, let piece = String(bytes: buf.prefix(Int(n)).map({ UInt8(bitPattern: $0) }), encoding: .utf8) {
                        response += piece
                        print("💬 Texte généré: \(piece)")
                    }
                    
                    // Préparer le prochain token
                    var nextBatch = llama_batch_init(1, 0, 1)
                    nextBatch.token[0] = maxToken
                    nextBatch.pos[0] = Int32(n_past)
                    nextBatch.n_tokens = 1
                    nextBatch.logits[0] = 1
                    
                    if llama_decode(ctx, nextBatch) == 0 {
                        n_past += 1
                    } else {
                        print("⚠️ Erreur décodage")
                        break
                    }
                    
                    llama_batch_free(nextBatch)
                }
            }
        }
        
        return response.isEmpty ? "Je n'ai pas réussi à générer une réponse cohérente, désolé." : response
    }


    
    deinit {
        if let sampler = sampler {
            llama_sampler_free(sampler)
        }
        if let context = context {
            llama_free(context)
        }
        if let model = model {
            llama_free_model(model)
        }
    }
}
