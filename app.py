from flask import Flask
from .searchfile import search_Tags

app = Flask(__name__)

@app.route('/')
def index():
    return 'Hello World'

# Make an API url handler to take in a sentence via a POST request, apply the ML model, and

if __name__ == ('__main__'):
    app.run()