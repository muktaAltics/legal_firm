from flask import Flask, render_template, request, redirect, url_for
# from dbConnection import dbConnect
# import mysql.connector
import pymysql

app = Flask(__name__,template_folder='templates')

# Dummy user data (for demonstration purposes)
# users = {
#     'user123': 'password123',
#     'admin': 'admin123'
# }
connection = pymysql.connect(host='localhost',
                             user='root',
                             password='mysqlroot@123',
                             db='legal_firm')

cur = connection.cursor()

# @app.route('/')
# def index():
#     return render_template('login.html')

@app.route('/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        uname=request.form['username'] 
        password=request.form['password'] 
        # print(uname,password)
        cur.execute( "SELECT * FROM app_user where user_name='"+uname+"' and user_password='"+password+"'" )
        result= cur.fetchall()
        print(result)
        if(result):
            print("success")
            return home()
        else:    
            error = 'Invalid Credentials. Please try again.'
            print(error)
            return render_template('login.html')
    else:
        print("data not found")
        return render_template('login.html')
    cur.commit()

# @app.route('/login', methods=['POST'])
# def login():
#     username = request.form['username']
#     password = request.form['password']

#     if username in users and users[username] == password:
#         return redirect(url_for('success'))
#     else:
#         return redirect(url_for('index'))

@app.route("/home", methods=["GET", "POST"])
def home():
    if request.method == "POST":
        return render_template('home.html')
    
    

@app.route("/register", methods=["GET", "POST"])
def register():
    cur.execute( "SELECT * FROM app_user " )
    results= cur.fetchall()
    # for result in results:
    #     print(result[0])
    #     print(result[1])
    #     print(result[2])

    if request.method == "POST":
        uname = request.form['uname']
        passw = request.form['passw']
        re_passw = request.form['re_passw']

        if (passw == re_passw):
            insertuser = """INSERT into `app_user`(`user_name`, `user_password`) VALUES (%s,%s)"""
            val = (uname, passw)
            cur.execute(insertuser,val)
            connection.commit()
            print(cur.rowcount,"records inserted")
            #cur.session.add(register)
            if cur.lastrowid:
                print('last insert id', cur.lastrowid)
            else:
                print('last insert id not found')
            if(cur.rowcount>0):
                # return ("data inserted")
                print("success")        
                return render_template("home.html")
            cur.close()
    return render_template("register.html")


@app.route('/cases', methods=["GET", "POST"])
def read_cases():
    print(".................case_info.......................")
    cur.execute("SELECT * FROM case_info")
    case_info = cur.fetchall()
    # print(case_info)
    
    return render_template('cases.html', cases=case_info)
    cur.close()
    

@app.route('/create_case', methods=["GET", "POST"])
def create_case():
    if request.method == "POST":
        title = request.form['title']
        description = request.form['description']
        status = request.form['status']
        type = request.form['type']
        court = request.form['court']
        fliling_date = request.form['filingDate']
        closing_date = request.form['closingDate']
        procedure_type = request.form['procedureType']
        procedure_date = request.form['procedureDate']
        doc_name = request.form['DocName']
        doc_upload = request.form['file']
        doc_submit_date = request.form['DocSubmitDate']
        court_appear_date =request.form['CourtAppearDate'] 
        adv_name = request.form['AdvName']   

        insertuser = """INSERT into `case_info`(`case_title`, `case_description`, `case_status`, `case_type`, `court_name`, `filing_date`, `closing_date`, `procedure_type`, `procedure_date`, `document_name`, `document_file`, `document_submit_date`, `court_appearance_date`, `case_assigned_to`) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"""
        val = (title,description,status,type,court,fliling_date,closing_date,procedure_type,procedure_date,doc_name,doc_upload,doc_submit_date,court_appear_date,adv_name)
        cur.execute(insertuser,val)
        connection.commit()
        print(cur.rowcount,"records inserted")
        #cur.session.add(register)
        if cur.lastrowid:
            print('last insert id', cur.lastrowid)
        else:
            print('last insert id not found')
        if(cur.rowcount>0):
            # return ("data inserted")
            print("success")        
            return render_template("cases.html")
        cur.close()
    return render_template("create_case.html")
    
    
@app.route('/update_case/<int:id>', methods=['GET', 'POST'])
def update_case(id):
    if request.method == 'POST':
        print(".....................UPDATE CASE...................")
        title = request.form['title']
        description = request.form['description']
        status = request.form['status']
        type = request.form['type']
        court = request.form['court']
        fliling_date = request.form['filingDate']
        closing_date = request.form['closingDate']
        procedure_type = request.form['procedureType']
        procedure_date = request.form['procedureDate']
        doc_name = request.form['DocName']
        doc_upload = request.form['file']
        doc_submit_date = request.form['DocSubmitDate']
        court_appear_date =request.form['CourtAppearDate'] 
        adv_name = request.form['AdvName'] 

        cur.execute("UPDATE case_info SET case_title='"+title+"', case_description='"+description+"', case_status='"+status+"', case_type='"+type+"', court_name='"+court+"', filing_date='"+fliling_date+"', closing_date='"+closing_date+"', procedure_type='"+procedure_type+"', procedure_date='"+procedure_date+"', document_name='"+doc_name+"', document_file='"+doc_upload+"', document_submit_date='"+doc_submit_date+"', court_appearance_date='"+court_appear_date+"', case_assigned_to='"+adv_name+"' WHERE case_no='"+id+"'")
        # val = (title,description,status,type,court,fliling_date,closing_date,procedure_type,procedure_date,doc_name,doc_upload,doc_submit_date,court_appear_date,adv_name)
        # cur.execute(insertuser,val)
        connection.commit()
        print ("data inserted")
        # print(cur.rowcount,"records inserted")
        # #cur.session.add(register)
        # if cur.lastrowid:
        #     print('last insert id', cur.lastrowid)
        # else:
        #     print('last insert id not found')
        # if(cur.rowcount>0):
        #     return ("data inserted")
        #     # print("success")
        #     # return read_cases()        
        #     return render_template("cases.html")
        cur.execute("SELECT * from case_info WHERE case_no=%s",(id))
        case_udt = cur.fetchall()
        cur.close()
        return render_template('update_case.html', id=id, case=case_udt)

@app.route('/delete_case/<int:id>', methods=['GET', 'POST'])
def delete_case(id):
    cur.execute("DELETE FROM case_info WHERE case_no= %s",(id))
    connection.commit()
    print(cur.rowcount,"records inserted")
    #cur.session.add(register)
    if cur.lastrowid:
        print('last deleted id', cur.lastrowid)
    else:
        print('last deleted id not found')
    if(cur.rowcount>0):
        # return ("data inserted")
        print("success")        
        return read_cases()
        # return render_template('update_case.html')

    cur.close()
    # return redirect('/')

    return render_template('cases.html')


@app.route('/other_advocates', methods=["GET", "POST"])
def read_advocates():
    print(".................case_info.......................")
    cur.execute("SELECT * FROM other_advocates")
    advocate_info = cur.fetchall()
    print(advocate_info)
    cur.close()
    return render_template('other_advocates.html', advocate=advocate_info)

@app.route('/add_adv', methods=["GET", "POST"])
def add_adv():
    if request.method == "POST":
        adv_name = request.form['name']
        adv_contact = request.form['contact']
        adv_special = request.form['specialization']
        adv_email = request.form['email']

        insertuser = """INSERT into `other_advocates`(`adv_name`, `adv_contact`, `adv_specialization`, `adv_email`) VALUES (%s,%s,%s,%s)"""
        val = (adv_name,adv_contact,adv_special,adv_email)
        cur.execute(insertuser,val)
        connection.commit()
        print(cur.rowcount,"records inserted")
        #cur.session.add(register)
        if cur.lastrowid:
            print('last insert id', cur.lastrowid)
        else:
            print('last insert id not found')
        if(cur.rowcount>0):
            # return ("data inserted")
            print("success")        
            return render_template("other_advocates.html")
        cur.close()
    return render_template("add_adv.html")

@app.route('/update_adv/<int:id>', methods=['GET', 'POST'])
def update_adv(id):
    if request.method == "POST":
        adv_name = request.form['name']
        adv_contact = request.form['contact']
        adv_special = request.form['specialization']
        adv_email = request.form['email']

        cur.execute("UPDATE other_advocates SET adv_name='"+adv_name+"', adv_contact='"+adv_contact+"', adv_specialization='"+adv_special+"', adv_email='"+adv_email+"' WHERE adv_id = '"+id+"' ")
        connection.commit()
        print(cur.rowcount,"records inserted")
        #cur.session.add(register)
        if cur.lastrowid:
            print('last insert id', cur.lastrowid)
        else:
            print('last insert id not found')
        if(cur.rowcount>0):
            # return ("data inserted")
            print("success")        
            return render_template('other_advocates.html')
        
    cur.execute("SELECT * from other_advocates WHERE adv_id=%s",(id))
    adv_udt = cur.fetchall()
    cur.close()
    return render_template('update_adv.html',id=id, advocate=adv_udt)
   
@app.route('/delete_adv/<int:id>', methods=['GET', 'POST'])
def delete_adv(id):
    cur.execute("DELETE FROM other_advocates WHERE adv_id= %s",(id))
    connection.commit()
    print(cur.rowcount,"records inserted")
    #cur.session.add(register)
    if cur.lastrowid:
        print('last deleted id', cur.lastrowid)
    else:
        print('last deleted id not found')
    if(cur.rowcount>0):
        # return ("data inserted")
        print("success")        
        return read_advocates()
        # return render_template('update_case.html')
    cur.close()
    return render_template('other_advocates.html')   

if __name__ == '__main__':
    app.run(debug=True)
