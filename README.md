# gcp-video-to-text
Uploading a video and exporting the speech into a text file with Google's ML API and correcting the grammar with openAI api. 

<img src="https://i.imgur.com/rHmQXr1.png" alt="flowchart of the project" width=300 height=300>

If you want to run this locally:
1. Set Up a Google Cloud Account: https://console.cloud.google.com/freetrial
2. Create a new Google Cloud Project:  
    Go to the Cloud Console.  
    Click the project selector in the upper-left corner and select New Project.  
    Give the project a name and click Create.  
    Click the project selector again and select your new project.  

3. What you need on your local machine:  
    Google Cloud SDK i.e. gcloud command-line tool: https://cloud.google.com/sdk/docs/install  
    Python3
    ffmpeg `sudo apt install ffmpeg`  
    OpenAI account and an API-key: https://beta.openai.com/account/api-keys  
        Store the api-key in to an environment variable: `export OPENAI_API_KEY="your-api-key"`  

4. Copy the video you want to get speech out of into the root directory

5. Run install.sh to install all the dependencies and prepare your google cloud account for this project.
    Answer all the prompts.

    `bash install.sh`

8. Then run the project

    `bash run.sh`
