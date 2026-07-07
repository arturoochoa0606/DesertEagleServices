import SwiftUI

@main
struct DesertEagleApp: App {
    var body: some Scene {
        WindowGroup {
            ChatView()
        }
    }
}

struct ChatView: View {
    @State private var userMessage: String = ""
    @State private var botResponse: String = "Bienvenido a Desert Eagle 🪶"

    var body: some View {
        VStack {
            Text("Desert Eagle Chatbot")
                .font(.title)
                .padding()

            ScrollView {
                Text(botResponse)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            HStack {
                TextField("Escribe tu mensaje...", text: $userMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Enviar") {
                    sendMessage()
                }
            }
            .padding()
        }
    }

    func sendMessage() {
        guard let url = URL(string: "http://localhost:8000/chat") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["user_input": userMessage]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data,
               let response = try? JSONDecoder().decode([String:String].self, from: data) {
                DispatchQueue.main.async {
                    botResponse = response["response"] ?? "Error"
                }
            }
        }.resume()
    }
}