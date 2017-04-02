import sys

from flask import Flask
from server import api
from extensions import mysql

app = Flask(__name__)
app.config.from_object(__name__)
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'wakeup'
app.config['MYSQL_DATABASE_HOST'] = '127.0.0.1'
mysql.init_app(app)

app.register_blueprint(api, url_prefix='/wakeup/api')

if __name__ == '__main__':
	app.run(host="0.0.0.0", port=5000, debug=True)
	#app.run(host='0.0.0.0', port=80)
