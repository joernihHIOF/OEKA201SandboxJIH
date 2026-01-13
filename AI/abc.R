library(ellmer)
library(chatgpt)
pq <- "2 kjente norske programmere"

# Example with library ellmer
lmod <- c("openai/gpt-4.1",
          "groq/llama3-8b-8192",
          "google_gemini/gemini-2.5-flash",
          "anthropic/claude-sonnet-4-20250514",
          "perplexity/sonar")[1]

objc <- chat(lmod)
objc$chat(pq)
# Example with library chatgpt
ask_chatgpt(pq)

