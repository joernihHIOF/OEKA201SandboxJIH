# Ellmer package
library(ellmer)
pq <- "2 kjente norske programmere"
# OpenAI
objc <- chat("openai/gpt-4.1")
objc$chat(pq)
# Google Gemini
objg <- chat("google_gemini/gemini-2.5-flash")
objg$chat(pq)
# Anthropic (Claude)
obja <- chat("anthropic/claude-3-5-sonnet")
obja$chat(pq)
# ChatGPT
library(chatgpt)
pq <- "2 kjente norske programmere"
chatgpt::ask_chatgpt(pq)

