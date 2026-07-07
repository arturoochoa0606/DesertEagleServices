from fastapi import FastAPI
from src.chatbot.core import ChatBot
from src.security.firewall import Firewall

app = FastAPI(title="Desert Eagle 🪶")

chatbot = ChatBot()
firewall = Firewall()

@app.get("/")
def home():
    return {"message": "Bienvenido a Desert Eagle 🪶"}

@app.post("/chat")
def chat(user_input: str):
    response = chatbot.respond(user_input)
    return {"response": response}

@app.get("/security/status")
def security_status():
    return firewall.status()

def main():
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)