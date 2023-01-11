#!/bin/bash
#Configure gcloud to use your new Google Cloud project:
gcloud init

#Export an environment variable with your current Google Cloud project ID:
PROJECT_ID=$(gcloud info --format='value(config.project)')

#Enable the services used in this project:
gcloud services enable speech.googleapis.com texttospeech.googleapis.com storage-component.googleapis.com

#Create a new Python 3 virtual environment:
python3 -m venv venv

#Activate the virtual environment:
source venv/bin/activate

#Install the required Python modules:
pip3 install -r requirements.txt

#Create a Service Account and JSON key
#In this section, we create a Service Account in your Google Cloud project and grant sufficient permissions to it so that it can use the AI service
#You also download a JSON key for the Service Accoun#The JSON key is used by the Python utilities to authenticate with the Cloud services.

#Create a new Service Account:
gcloud iam service-accounts create ml-dev --description="ML APIs developer access" --display-name="ML Developer Service Account"

#Grant the ML Developer role to the Service Account:
gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:ml-dev@$PROJECT_ID.iam.gserviceaccount.com --role roles/ml.developer

#Grant the Project Viewer role to the Service Account:
gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:ml-dev@$PROJECT_ID.iam.gserviceaccount.com --role roles/viewer

#Grant the Storage Object Admin role to the Service Account, so that it can upload and download objects to and from Cloud Storage:
gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:ml-dev@$PROJECT_ID.iam.gserviceaccount.com --role roles/storage.objectAdmin

#Create a JSON key for the Service Account:
gcloud iam service-accounts keys create ./ml-dev.json --iam-account ml-dev@$PROJECT_ID.iam.gserviceaccount.com

#The key file will be downloaded to the current working directory.

#Export your service account JSON key to the shell environment variables, so that the utilities can authenticate with the Cloud AI services:
export GOOGLE_APPLICATION_CREDENTIALS=ml-dev.json
