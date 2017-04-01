# sleep


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

Running the server side api:
```
python server.py
```

Then make a request to the specified url

Note: initial commit is based on [this](https://blog.miguelgrinberg.com/post/designing-a-restful-api-with-python-and-flask) and does not belong to me
