from public import *


# truffle development blockchain address
blockchain_address = 'http://127.0.0.1:9545'
# Client instance to interact with the blockchain
web3 = Web3(HTTPProvider(blockchain_address))
# Set the default account (so we don't need to set the "from" for every transaction call)
web3.eth.defaultAccount = web3.eth.accounts[0]
compiled_contract_path = 'C:/Users/aksha/OneDrive/Desktop/MedicineRecommendation/MedicineRecommendation/node_modules/.bin/build/contracts/medicines.json'
# Deployed contract address (see `migrate` command output: `contract address`)
deployed_contract_address = '0x9cEa28Bb66B1e9a7483a1436A981Ae045F4ff4FF'
syspath=r"C:\Users\aksha\OneDrive\Desktop\MedicineRecommendation\MedicineRecommendation\static\\"



admin=Blueprint('admin',__name__)

@admin.route('/admin_home')
def admin_home():
	if not session.get('lid') is None:
		return render_template('admin_home.html')
	else:
		return redirect(url_for('public.login'))


@admin.route('/adminviewdistributer',methods=['get','post'])
def adminviewdistributer():
	if not session.get('lid') is None:
		data={}
		q="select * from distributor inner join login using(login_id)"
		res=select(q)
		data['diet']=res

		if 'action' in request.args:
			action=request.args['action']
			lid=request.args['lid']
		
		else:
			action=None
			
		if action=="accept":
			q="update login set usertype='distributor' where login_id='%s'"%(lid)
			update(q)
			q="select * from distributor inner join login using(login_id) where login_id='%s'"%(lid)
			res=select(q)
			with open(compiled_contract_path) as file:
				contract_json = json.load(file)  # load contract info as JSON
				contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
			contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)
			message = contract.functions.add_dis(res[0]['login_id'], res[0]['fname'],res[0]['lname'], res[0]['place'], res[0]['phone'], res[0]['email']).transact()
			
			flash('accepted successfully')
			return redirect(url_for('admin.adminviewdistributer'))

		if action=="reject":
			q="delete from login where login_id='%s'"%(lid)
			delete(q)
			q="delete from distributor where login_id='%s'"%(lid)
			delete(q)
			flash('rejected successfully')
			return redirect(url_for('admin.adminviewdistributer'))
		return render_template("adminviewdistributer.html",data=data)
	else:
		return redirect(url_for('public.login'))


@admin.route('/adminviewpharmacy',methods=['get','post'])
def adminviewpharmacy():
	if not session.get('lid') is None:
		data={}
		q="select * from pharmacy inner join login using(login_id)"
		res=select(q)
		data['diet']=res

		if 'action' in request.args:
			action=request.args['action']
			lid=request.args['lid']
		
		else:
			action=None
			
		if action=="accept":
			q="update login set usertype='pharmacy' where login_id='%s'"%(lid)
			update(q)
			q="select * from pharmacy inner join login using(login_id) where login_id='%s'"%(lid)
			res=select(q)
			with open(compiled_contract_path) as file:
				contract_json = json.load(file)  # load contract info as JSON
				contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
			contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)
			message = contract.functions.add_dis(res[0]['login_id'], res[0]['pharmacy_name'], res[0]['place'], res[0]['city'], res[0]['email'], res[0]['phone']).transact()
			flash('accepted successfully')
			return redirect(url_for('admin.adminviewpharmacy'))

		if action=="reject":
			q="delete from login where login_id='%s'"%(lid)
			delete(q)
			q="delete from pharmacy where login_id='%s'"%(lid)
			delete(q)
			flash('rejected successfully')
			return redirect(url_for('admin.adminviewpharmacy'))
		return render_template("adminviewpharmacy.html",data=data)
	else:
		return redirect(url_for('public.login'))

@admin.route('/adminviewmanufacturer',methods=['get','post'])
def adminviewmanufacturer():
	if not session.get('lid') is None:
		data={}
		q="select * from manufacture inner join login using(login_id)"
		res=select(q)
		data['diet']=res

		if 'action' in request.args:
			action=request.args['action']
			lid=request.args['lid']
		
		else:
			action=None

		if action=="accept":
			q="update login set usertype='manufacturer' where login_id='%s'"%(lid)
			update(q)
			q="select * from manufacture inner join login using(login_id) where login_id='%s'"%(lid)
			res=select(q)
			with open(compiled_contract_path) as file:
				contract_json = json.load(file)  # load contract info as JSON
				contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
			contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)
			message = contract.functions.add_man(res[0]['login_id'], res[0]['name'], res[0]['place'], res[0]['phone'], res[0]['email'],res[0]['dis'],res[0]['path']).transact()
			
			return redirect(url_for('admin.adminviewmanufacturer'))

		if action=="reject":
			q="delete from login where login_id='%s'"%(lid)
			delete(q)
			q="delete from manufacture where login_id='%s'"%(lid)
			delete(q)
			flash('rejected successfully')
			return redirect(url_for('admin.adminviewmanufacturer'))
		return render_template("adminviewmanufacturer.html",data=data)
	else:
		return redirect(url_for('public.login'))


# @admin.route('/admin_manage_medicine',methods=['get','post'])
# def admin_manage_medicine():
# 	data={}

# 	if 'add' in request.form:
# 		medicine=request.form['med']
# 		det=request.form['det']
# 		rate=request.form['rate']
# 		qua=request.form['qua']
# 		q="select * from medicine where medicine='%s' and details='%s' and rate='%s' and quantity='%s'"%(medicine,det,rate,qua)
# 		res=select(q)
# 		if res:
# 			flash("medicine is already added")
# 		else:
# 			q="INSERT INTO `medicine` VALUES(null,'%s','%s','%s','%s')"%(medicine,det,rate,qua)
# 			insert(q)
# 			flash("medicine added")
# 		return redirect(url_for('admin.admin_manage_medicine'))

# 	q="select * from medicine"
# 	res=select(q)
# 	data['med']=res


# 	if 'action' in request.args:
# 		action=request.args['action']
# 		id=request.args['id']
# 	else:
# 		action=None

# 	if action=='delete':
# 		q="delete from medicine where medicine_id='%s'"%(id)
# 		delete(q)
# 		flash("deleted.....!")
# 		return redirect(url_for('admin.admin_manage_medicine'))

# 	if action=='update':
# 		q="select * from medicine where medicine_id='%s'"%(id)
# 		data['dir']=select(q)

# 	if 'update' in request.form:
# 		medicine=request.form['med']
# 		det=request.form['det']
# 		rate=request.form['rate']
# 		qua=request.form['qua']
# 		q="update medicine set medicine='%s',details='%s',rate='%s',quantity='%s' where medicine_id='%s'"%(medicine,det,rate,qua,id)
# 		update(q)
# 		flash("updated")
# 		return redirect(url_for('admin.admin_manage_medicine'))
# 	return render_template("admin_manage_medicine.html",data=data)



@admin.route('/admin_view_feedback')
def admin_view_feedback():
	if not session.get('lid') is None:
		data={}
		q="select * from feedback"
		res=select(q)
		data['feed']=res
		return render_template('admin_view_feedback.html',data=data)
	else:
		return redirect(url_for('public.login'))