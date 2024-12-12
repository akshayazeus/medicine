from public import *
# import qrcode

manufacturer=Blueprint('manufacturer',__name__)

@manufacturer.route('/manufacturer_home')
def manufacturer_home():
	if not session.get('lid') is None:
		return render_template('manufacturer_home.html')
	else:
		return redirect(url_for('public.login'))



@manufacturer.route('/admin_manage_medicine',methods=['get','post'])
def admin_manage_medicine():
	if not session.get('lid') is None:
		data={}
		if 'add' in request.form:
			a1=request.form['a']
			b=request.form['b']
			c=request.form['c']
			d=request.form['d']
			e1=request.form['e']
			f=request.form['f']
			g=request.form['g']
			h=request.form['h']
			# i1=request.form['i']

			q="insert into medicine values(null,'%s','%s','%s','%s','%s','%s','%s','%s','%s','1')"%(session['lid'],a1,b,c,d,e1,f,g,h)
			insert(q)
			with open(compiled_contract_path) as file:
				contract_json = json.load(file)  # load contract info as JSON
				contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
			contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)
			blocknumber = web3.eth.get_block_number()
			res = []
			c1=0
			try:
				for i in range(blocknumber, 0, -1):
					a = web3.eth.get_transaction_by_block(i, 0)
					decoded_input = contract.decode_function_input(a['input'])
					print(decoded_input)
					if str(decoded_input[0]) == "<Function add_medicine(uint256,uint256,string,string,string,string,string,string,string,string)>":
						if int(decoded_input[1]['m_id']) == int(session['lid']) and str(decoded_input[1]['name'])==a1 :
							c1=c1+1
						else:
							c1=c1

			except Exception as e:
				print("", e)

			if c1>0:
				flash("medicine is already added")
			else:
				# q="INSERT INTO `medicine` VALUES(null,'%s','%s','%s','%s','%s','%s','%s','%s','%s')"%(a,b,c,d,e,f,g,h,i)
				# insert(q)
				with open(compiled_contract_path) as file:
					contract_json = json.load(file)  # load contract info as JSON
					contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
				contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)
				id=web3.eth.get_block_number()
				message = contract.functions.add_medicine(id,session['lid'],a1,b,c,d,e1,f,g,h).transact()
				flash("medicine added")
			return redirect(url_for('manufacturer.admin_manage_medicine'))


		with open(compiled_contract_path) as file:
			contract_json = json.load(file)  # load contract info as JSON
			contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
		contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)
		blocknumber = web3.eth.get_block_number()
		res = []
		try:
			for i in range(blocknumber, 0, -1):
				a = web3.eth.get_transaction_by_block(i, 0)
				decoded_input = contract.decode_function_input(a['input'])
				print(decoded_input)
				# if str(decoded_input[0]) == "<Function add_medicine(uint256,uint256,string,string,string,string,string,string,string,string)>":
				# 		res.append(decoded_input[1])

				if str(decoded_input[0]) == "<Function add_medicine(uint256,uint256,string,string,string,string,string,string,string,string)>":
					if int(decoded_input[1]['m_id']) == int(session['lid'])  :
						res.append(decoded_input[1])
		except Exception as e:
			print("", e)

		data['med']=res

		# with open(compiled_contract_path) as file:
		# 	contract_json = json.load(file)  # load contract info as JSON
		# 	contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
		# contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)
		# blocknumber = web3.eth.get_block_number()
		# res1 = []
		# try:
		# 	for i in range(blocknumber, 0, -1):
		# 		a = web3.eth.get_transaction_by_block(i, 0)
		# 		decoded_input = contract.decode_function_input(a['input'])
		# 		print(decoded_input)
		# 		if str(decoded_input[0]) == "<Function add_medicine(uint256,uint256,string,string,string,string,string,string,string,string)>":
		# 			if int(decoded_input[1]['m_id']) == int(session['lid']):
		# 				res1.append(decoded_input[1])
		# 				# res.append(decoded_input['fn'])
		# except Exception as e:
		# 	print("", e)
		# data['med']=res1
		# print(res1)
		return render_template("admin_manage_medicine.html",data=data)
	else:
		return redirect(url_for('public.login'))


@manufacturer.route('/manufacturer_add_stock',methods=['get','post'])
def manufacturer_add_stock():
	if not session.get('lid') is None:
		print("this is the controller:::::::::::::::::::::")
		data={}
		mid=request.args['mid']
		if 'add' in request.form:
			a1=request.form['a']
			b=request.form['b']
			c=request.form['c']		
			q="INSERT INTO `stock` VALUES(null,'%s','%s','0','0','%s','%s','%s','0')"%(mid,session['lid'],a1,b,c)
			
			insert(q)
			flash('stock added successfully')
			print("before return")
			return redirect(url_for('manufacturer.manufacturer_add_stock',mid=mid))
			print("after return")
		q="select * from stock"
		data['med']=select(q)

		return render_template('manufacturer_add_stock.html',data=data)
	else:
		return redirect(url_for('public.login'))




@manufacturer.route('/manu_view_medicine_request',methods=['get','post'])
def manu_view_medicine_request():
	if not session.get('lid') is None:
		data={}
		lid=session['lid']

		q="select * from request inner join distributor on request.distributer_id=distributor.login_id where manufacture_id='%s'"%(lid)
		res=select(q)
		data['med']=res
		return render_template('manu_view_medicine_request.html',data=data)
	else:
		return redirect(url_for('public.login'))


@manufacturer.route('/manu_add_stock',methods=['get','post'])
def manu_add_stock():
	if not session.get('lid') is None:
		data={}
		lid=session['lid']
		req=request.args['req']
		ph_id=request.args['ph_id']
		dis_id=request.args['dis_id']
		mid=request.args['mid']
		qty=request.args['qty']
		data['qty']=qty

		if 'add' in request.form:
			b=request.form['b']
			c=request.form['c']	


			q="INSERT INTO `stock` VALUES(null,'%s','%s','%s','%s','%s','%s','%s','')"%(mid,session['lid'],dis_id,ph_id,qty,b,c)
			
			stockid=insert(q)
			q="update request set status='Provided' where request_id='%s'"%(req)
			update(q)

			with open(compiled_contract_path) as file:
				contract_json = json.load(file)  # load contract info as JSON
				contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions 
			contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)
			id=web3.eth.get_block_number()
			


			message=contract.functions.add_stock(id,int(mid),int(session['lid']),int(dis_id),int(ph_id),qty,b,c).transact()
			path="static/qrcode/"+str(id)+".png"
			val=qrcode.make(str(id))
			val.save(path)

			q="update stock set QR_code='%s' where stock_id='%s'"%(path,stockid)
			print(q)
			update(q)

			flash('stock added successfully')
			print("before return")
			return redirect(url_for('manufacturer.manu_view_medicine_request'))
			print("after return")	
		return render_template('manu_add_stock.html',data=data)
	else:
		return redirect(url_for('public.login'))