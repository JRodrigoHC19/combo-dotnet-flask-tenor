from flask import Flask, render_template
import requests

app = Flask(__name__)

@app.route('/')
def index():
    return { "message": "Flask is running" }


@app.route('/<nro>')
def home(nro: int):
    response = requests.get(f"http://dotnet:8080/search?limit={nro}")
    
    print(response)
    if response.status_code == 200:
        gifs = []
        tener_data = response.json()
        count = (len(tener_data['results'])) if (len(tener_data['results'])) < 50 else 50
        gifs.append({
            "text": tener_data['results'][count - 1]['id'],
            "href": tener_data['results'][count - 1]['media'][0]['webm']['preview']
        })
        return render_template('index.html', gifs=gifs)
    else:
        return f"Error: {response.status_code}"

if __name__ == '__main__':
    app.run(debug=True)
