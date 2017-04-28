# waketfup


clone then boot the virtual environment
```
git clone https://github.com/KaranPhadnisNaik/waketfup.git
cd waketfup
source server/flask/bin/activate
```

Once the virtual environment is set up, install the required packages:
```
pip install flask
pip install Flask-HTTPAuth
pip install flask-mysql
```
Install mysql
[here](https://dev.mysql.com/doc/mysql-getting-started/en/#mysql-getting-started-installing)

Create a seed database (wakeup) and dump:
```
# to do
```

Running the server side api:
```
cd server
python server.wsgi
```

Then make a request to the specified url

App:

To do:
```
create notificaiton + actions
link APIs to the app
setup payments (?)
decide on what conditions to set up snooze timer
implement custom tones
```