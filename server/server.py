from flask import Flask, Blueprint, jsonify, abort, request, make_response, url_for, Response
from extensions import mysql
import json


#app = Flask(__name__, static_url_path = "")
#auth = HTTPBasicAuth()
api = Blueprint('api', __name__)

# http://localhost:5000/wakeup/api/login?user=yt&password=hello
@api.route('/login', methods = ['GET'])
def login():
    user = request.args.get('user', '')
    password = request.args.get('password', '')
    print(user)
    print(password)

    # verify user and password from mysql table
    cursor = mysql.connect().cursor()
    query = "SELECT * FROM users WHERE username=" + "'" + user + "'" + " AND password=" + "'" + password + "'"
    print(query)

    cursor.execute(query)
    data = cursor.fetchall()

    # initial json object of personal info
    res = {
        'user_id': '',
        'fullname': '',
        'email': '',
        'username': '',
        'password': '',
        'total': 0.00
    }

    colNames =['user_id','fullname', 'email','username', 'password', 'total']

    i=0
    #print(str(data)=="()")
    if (len(data) == 1):
        for item in data:
            for stuff in item:
                if colNames[i] == 'total':
                    res[colNames[i]] = float(stuff)
                else:
                    res[colNames[i]] = str(stuff)
                i=i+1

    final = {'status': 'Ok', 'data': res}
    return Response(json.dumps(final), headers={'Access-Control-Allow-Origin':'*', 'Access-Control-Allow-Methods':'POST, GET, OPTIONS','Access-Control-Allow-Headers':'Content-Type'})

# must send the amount of money owed to roommates ( user_id is the debtor)
@api.route('/paythem/<int:user_id>', methods = ['POST','GET'])
def pay(user_id):
    # the number of snoozes the person with user_id took
    amount = int(request.args.get('amount', 1))

    # get all the roommates of the perpetrator from users table
    cursor = mysql.connect().cursor()
    getRoommatesQuery = "SELECT * FROM roommates WHERE user_id=" + str(user_id)
    #print(getRoommatesQuery)
    cursor.execute(getRoommatesQuery)
    data = cursor.fetchall()

    # create array of roommate ids
    # create a string of roommateIds
    roommateIds = []
    rmid = ""
    if (len(data) == 1):
        for item in data:
            # if the roomate id is zero remove it from rmid string
            rmid = str(item).replace(", 0", "")
            for stuff in item:
                if stuff != 0:
                    roommateIds.append(stuff)

    print(roommateIds)
    print(rmid)

    # if the person lives alone dont do anything
    if len(roommateIds) == 1:
        final = {'status': 'Ok', 'data': 'This person lives alone!'}
        return Response(json.dumps(final), headers={'Access-Control-Allow-Origin':'*', 'Access-Control-Allow-Methods':'POST, GET, OPTIONS','Access-Control-Allow-Headers':'Content-Type'})


    # get  roommate balances
    roommateAmounts = []
    getBalanceQuery = "SELECT total from users WHERE user_id in " +  rmid
    print(getBalanceQuery)
    cursor.execute(getBalanceQuery)
    data = cursor.fetchall()

    if (len(data) > 1):
        for item in data:
            for stuff in item:
                roommateAmounts.append(stuff)

    # adjust the roommateAmounts
    # owed to each roommate= 2^n / (number of roommates)
    # remove the perpetrator from calculation so len(roommateIds)-1
    owed = 2**(amount) / (len(roommateIds)-1)
    roommateAmounts[0] = roommateAmounts[0] - 2**(amount)
    for i in range(1,len(roommateAmounts)):
        roommateAmounts[i] = roommateAmounts[i] + owed

    print(roommateAmounts)

    # update the rooomate amounts in mysql
    for i in range(0,len(roommateAmounts)):
        adjustBalanceQuery = "UPDATE users set total=" + str(roommateAmounts[i]) + " WHERE user_id=" + str(roommateIds[i])
        print(adjustBalanceQuery)
        cursor.execute(adjustBalanceQuery)
        cursor.connection.commit()

    final = {'status': 'Ok', 'data': 'Updated Totals'}
    return Response(json.dumps(final), headers={'Access-Control-Allow-Origin':'*', 'Access-Control-Allow-Methods':'POST, GET, OPTIONS','Access-Control-Allow-Headers':'Content-Type'})
