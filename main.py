from flask import Flask, render_template, logging, request, session, redirect, flash, url_for,jsonify
from flask_login import LoginManager, UserMixin, login_user, login_required, current_user, logout_user
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime,date
from flask_mail import Mail
from werkzeug.utils import secure_filename
import json
import pymysql
import os


with open('config.json','r') as config_file:
    params = json.load(config_file)['params']#load file parmas value in params variable

app = Flask(__name__)
app.secret_key = params['secret_key_for_session']
app.config["upload_folder"] = params['upload_location']
login_manager = LoginManager() # creating instance for manageing login session of users
login_manager.init_app(app)
app.config.update(
    Mail_SERVER='smtp.gmail.com',
    Mail_PORT='465',
    Mail_USE_SSL=True,
    Mail_USERNAME=params['gmail_user'],
    Mail_password=params['gmail_password']
)
mail = Mail(app)
app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri'] #data base uri load from config.json
db = SQLAlchemy(app)

#loading user from cokkies
@login_manager.user_loader
def load_user(user_id):
    return Usertable.query.get(int(user_id))


#data base clasess start
class Usertable(db.Model,UserMixin):
    
    user_id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), unique=True, nullable=False)
    phone_no = db.Column(db.Integer, nullable=True)
    useremail = db.Column(db.String(20),unique=True,  nullable=False)
    userpassword = db.Column(db.String(160), nullable=False)
    date = db.Column(db.String(12),nullable=True)
    
    def get_id(self):
        return (self.user_id)
    
    
class Orders(db.Model):
    
    order_id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey(Usertable.user_id), nullable=False)
    user_email = db.Column(db.String(40), nullable=False)
    user_name = db.Column(db.String(20), nullable=False)
    p_name = db.Column(db.String(20), nullable=False)
    p_price =db.Column(db.Integer(), nullable=False)
    quantity= db.Column(db.Integer(), nullable=False)
    p_discription =db.Column(db.String(160), nullable=False)
    date = db.Column(db.String(12),nullable=True)
    

class Contact(db.Model):
    
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=False, nullable=False)
    email = db.Column(db.String(20), nullable=False)
    textmsg =db.Column(db.String(160), nullable=False)
    datetime = db.Column(db.String(12),nullable=True)  
    
    
class Menproduct(db.Model):
    
    p_id = db.Column(db.Integer, primary_key=True)
    p_name = db.Column(db.String(80), unique=True, nullable=False)
    p_price = db.Column(db.Integer())
    p_img = db.Column(db.String(160), unique=True, nullable=False)
    p_discription = db.Column(db.String(160), nullable=False)
    

class Kidproduct(db.Model):
    
    p_id = db.Column(db.Integer, primary_key=True)
    p_name = db.Column(db.String(80), unique=True, nullable=False)
    p_price = db.Column(db.Integer())
    p_img = db.Column(db.String(160), unique=True, nullable=False)
    p_discription = db.Column(db.String(160), nullable=False)


class Womenproduct(db.Model):
    
    p_id = db.Column(db.Integer, primary_key=True)
    p_name = db.Column(db.String(80), unique=True, nullable=False)
    p_price = db.Column(db.Integer())
    p_img = db.Column(db.String(160), unique=True, nullable=False)
    p_discription = db.Column(db.String(160), nullable=False)
# database classes end

# routes views start
@app.route('/login',  methods=['GET', 'POST'])#user__login
def login():
    """ if current user is already authencticated than redirect to index page  """
    if current_user.is_authenticated:
        return redirect(url_for('index')) 
    
    if (request.method == 'POST'):
        email = request.form.get('Email')
        password = request.form.get('password')
        check_password = Usertable.query.filter_by(userpassword = password).first()
        check_user = Usertable.query.filter_by(useremail=email,userpassword=password).first()
        if check_user == check_password and check_user != None and check_password != None:
            login_user(check_user)           
            return redirect(url_for('index'))
        else:
            msg = flash('please enter valid email and password')  
            return render_template("user_login.html")                 
    return render_template("user_login.html")


@app.route("/adminlogin", methods=['GET', 'POST'])#admin__login
def adminlogin():
    if 'user' in session and session['user'] == params['admin_user']:
        order = Orders.query.all()
        return render_template('dashboard.html', order=order)
    
    if request.method == 'POST':
        usernanme = request.form.get("adminname")
        password = request.form.get("adminpassword")
        if usernanme == params['admin_user'] and password == params['admin_password']:
            session['user'] = usernanme
            order=Orders.query.all()
            return render_template('dashboard.html', order=order)
        else:
            msg = flash('please enter valid email and password')

    return render_template('adminlogin.html', params=params)




@app.route("/logout")#logout user
def logout():
    logout_user()
    return redirect(url_for('login'))

@app.route("/adminlogout")#admin logout
def adminlogout():
    session.pop('user')
    return redirect(url_for('login'))


@app.route('/index',  methods=['GET', 'POST'])
def index():
    if current_user.is_authenticated:
        return render_template("index.html")
    else:
        return redirect(url_for('login'))
    
@app.route('/order',  methods=['GET', 'POST']) #order product
def order():
    """ if current user is already authencticated than redirect to index page """
    if current_user.is_authenticated:
        no_of_orders = Orders.query.filter_by(user_id=current_user.user_id).all()
        print(no_of_orders)
        if no_of_orders == None:
             flag_sign_for_changeing_bg_img_in_oder.html = 'True'
             return render_template('order.html', sign=flag_sign_for_changeing_bg_img_in_oder.html)
         
        if (request.method == "POST"):
            user_id = current_user.user_id
            user_email = current_user.useremail
            user_name =current_user.username
            product_name = request.form.get('name')
            product_price = request.form.get('Price')
            product_discription = request.form.get("Discription")
            product_quantity = request.form.get('quantity')
            phone = Usertable.query.filter_by(user_id=current_user.user_id).first()
            if int(product_quantity)>0:
                add_product = Orders(user_id=user_id,user_email=user_email, user_name=user_name,quantity=product_quantity, p_name=product_name, p_price=product_price,p_discription=product_discription, date=datetime.now())
                db.session.add(add_product)
                db.session.commit()
                return render_template('order.html', orders=Orders.query.filter_by(user_id=current_user.user_id).all())
            else:
                msg = str(flash('Please Atleast Buy 1 Product or fill 1 in quantity'))
                return redirect(request.referrer)
        else:
            msg = flash('Please Atleast Buy 1 Product')
            return render_template('order.html',orders=Orders.query.filter_by(user_id=current_user.user_id).all())
    else:
        return redirect(url_for('login'))

@app.route('/cancelorder/<int:u_id>/<string:name>/<int:price>/<int:quantity>') #canceling product
@login_required
def cancel(u_id,name,price,quantity):
    if current_user.is_authenticated:
            cancel_order =  Orders.query.filter_by(user_id=u_id,quantity=quantity, p_name=name, p_price=price).first()
            db.session.delete(cancel_order)
            db.session.commit()
            flash('{}Canceled'.format(name))        
            return redirect(url_for('order'))
    else:
        return redirect(url_for('order'))

@app.route('/menproduct',  methods=['GET', 'POST']) #for adding products
@login_required
def menproduct():
    if 'user' in session and session['user'] == params['admin_user']:
        if (request.method == 'POST'):
            name = request.form.get('name')
            price = request.form.get('Price')
            img = request.form.get('Image')
            discription = request.form.get("Discription")
            add_product = Menproduct(p_name=name, p_price=price, p_discription=discription, p_img=img)
            db.session.add(add_product)
            db.session.commit()
        return render_template('addproduct.html',endpoint='/menproduct') 
    else:
        products = Menproduct.query.all()
        return render_template('product.html', products=products)


@app.route('/womenproduct',  methods=['GET', 'POST']) #for adding products
def womenproduct():
    if 'user' in session and session['user'] == params['admin_user']:
        if (request.method == 'POST'):
            name = request.form.get('name')
            price = request.form.get('Price')
            img = request.form.get('Image')
            discription = request.form.get("Discription")
            add_product = Womenproduct(p_name=name, p_price=price, p_discription=discription, p_img=img)
            db.session.add(add_product)
            db.session.commit()
        return render_template('addproduct.html',endpoint='/womenproduct') 
    else:
        products = Womenproduct.query.all()
        
        return render_template('product.html', products=products)


@app.route('/kidproduct',  methods=['GET', 'POST']) #for adding products
def kidproduct():
    if 'user' in session and session['user'] == params['admin_user']:
        if (request.method == 'POST'):
            name = request.form.get('name')
            price = request.form.get('Price')
            img = request.form.get('Image')
            discription = request.form.get("Discription")
            add_product = Kidproduct(p_name=name, p_price=price, p_discription=discription, p_img=img)
            db.session.add(add_product)
            db.session.commit()
        return render_template('addproduct.html',endpoint='/kidproduct') 
    else:
        products = Kidproduct.query.all()
        return render_template('product.html', products=products)


@app.route('/createuser',  methods=['GET', 'POST'])# for registration
def createuser():
    if current_user.is_authenticated:
        return redirect(url_for('index')) 
    
    if (request.method == 'POST'):
        username = request.form.get('username')
        email = request.form.get('email')
        password = request.form.get('password')
        phone = request.form.get('phone')
        check_user = Usertable.query.filter_by(username=username).first()
        check_email = Usertable.query.filter_by(useremail=email).first()
        if check_user or check_email:
            msg = flash('plese Use diffrent Name and Email its is already being used') 
            return redirect(url_for('createuser')) 
        else:
            add = Usertable(username=username, phone_no=phone,  useremail=email, userpassword=password, date=datetime.utcnow())
            db.session.add(add)
            db.session.commit()
            msg = flash('Account created sucessfully {}'.format(username))
                
    return render_template('user_create.html')
        
        
@app.route('/contact', methods=['GET', 'POST'])#for contact us
def contact():
    if (request.method == 'POST'):
        name = request.form.get('name')
        email = request.form.get('email')
        msg = request.form.get('textmsg')
        # mail.send_message('New message from blog'+name, 
        #                  sender=email,
        #                  recipients=[params['gmail_user']],
        #                  body = msg+'\n'+name )       
        add = Contact(name=name, email=email, textmsg=msg, datetime=datetime.utcnow())
        db.session.add(add)
        db.session.commit()
        msg = flash('Msagge Sent sucessfully {}'.format(name))                       
    return render_template('contact.html')

# routes end 
app.run(debug=True)
if "__name__" == "__main__":
    pass