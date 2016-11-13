from flask import Flask

app = Flask(__name__)

from datetime import datetime

# route goes here
@app.route("/")
def hello():
    now = datetime.utcnow()
    then = datetime(1970, 1, 1)
    return ("Number of seconds since 1970: " + str((now - then).total_seconds()))


if __name__ == "__main__":
    app.run(host='0.0.0.0')
