from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    with open('message.txt', 'r') as file:
        message = file.read()
    return message

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
