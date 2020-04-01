import os
import speech_recognition as sr
from tqdm import tqdm
#set working directory
os.chdir("")

from natsort import natsorted, ns
import time
r = sr.Recognizer()
files = natsorted(os.listdir('parts/'))


all_text = []

for f in tqdm(files):
    name = "parts/" + f
    # Load audio file
    with sr.AudioFile(name) as source:
        audio = r.record(source)
    # Transcribe audio file
    text = r.recognize_google(audio)
    all_text.append(text)
    #time.sleep(3)

transcript = ""
for i, t in enumerate(all_text):
    total_seconds = i * 15
    m, s = divmod(total_seconds, 60)
    h, m = divmod(m, 60)

    # Format time as h:m:s - 30 seconds of text
    transcript = transcript + "{:0>2d}:{:0>2d}:{:0>2d} {}\n".format(h, m, s, t)

print(transcript)

with open("transcript.txt", "w") as f:
    f.write(transcript)
