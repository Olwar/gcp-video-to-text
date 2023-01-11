import os
import openai

# Set your API key in an environment variable called "OPENAI_API_KEY"
openai.api_key = os.getenv("OPENAI_API_KEY")

# Sending prompt to openAI-API and returning response
def openai_prompt(gpt_prompt):
  response = openai.Completion.create(
    engine="text-davinci-003",
    prompt=gpt_prompt,
    temperature=0.5,
    max_tokens=256,
    top_p=1.0,
    frequency_penalty=0.0,
    presence_penalty=0.0
  )
  return response

def main():
  f = open("transcript.txt", "r")
  text = f.read()
  gpt_prompt = f"Correct grammar mistakes, typos and wrong words: \n{text}\n"
  new_f = open("corrected_text.txt", "w")
  print("writing to corrected_text.txt")
  response = openai_prompt(gpt_prompt)
  new_f.write(response['choices'][0]['text'])
  new_f.close()
  print("finished writing")

if __name__ == "__main__":
  main()
