create database legal_firm;
use legal_firm ;
CREATE TABLE case_info(case_no int NOT NULL AUTO_INCREMENT,
		  case_title varchar(30) NOT NULL,
		  case_description varchar(100) NOT NULL,
		  case_status ENUM('open', 'closed', 'pending') NOT NULL,
		  case_type ENUM('criminal', 'civil', 'family') NOT NULL,
		  court_name varchar(20) NOT NULL,
		  filing_date date NOT NULL,
		  closing_date date NOT NULL,
		  procedure_type varchar(30) NOT NULL,
		  procedure_date date NOT NULL,
		  document_name varchar(20) NOT NULL,
		  document_file BLOB NOT NULL,
		  document_submit_date date NOT NULL,
		  court_appearance_date date NOT NULL,
		  case_assigned_to varchar(20) NOT NULL,
		  PRIMARY KEY (case_no))ENGINE=INNODB;
          
create table client_info(c_id int NOT NULL,
				 case_no int NOT NULL,
		    	 c_name varchar(30) NOT NULL,
		    	 c_contact int NOT NULL,
		    	 c_email varchar(20) NOT NULL,
		    	 c_addr varchar(50) NOT NULL,
		     	 c_proffesion varchar(20) NOT NULL,
		    	 PRIMARY KEY (c_id),
		    	 FOREIGN KEY (case_no) references case_info(case_no))ENGINE=INNODB;
               
create table client_bill(bill_no int NOT NULL,
			 c_id int NOT NULL,
			 case_no int NOT NULL,
			 bill_date date NOT NULL,
			 legal_opinion_amt double,
			 reply_notice_amt double,
			 write_petition_amt double,
			 execution_petition_amt double,
			 CJM_amt double,
			 appearance_before_highcourt_amt double,
		   	 affidevit_amt double,
			 consultation_fee double,
			 conveyance_fee double,
			 out_of_pocket_expence double,
			 total_amt double NOT NULL,
			 bank_name varchar(50) NOT NULL,
			 bank_addr varchar(100) NOT NULL,
			 bank_acc_no int NOT NULL,
			 bank_IFSC_code varchar(20) NOT NULL,
			 PAN_no varchar(20) NOT NULL,
			 signature BLOB NOT NULL,
			 PRIMARY KEY (bill_no),
			 FOREIGN KEY (c_id) references client_info(c_id),
			 FOREIGN KEY (case_no) references case_info(case_no)); 
             
create table client_payment(p_id int AUTO_INCREMENT,
							bill_no int NOT NULL,
							total_installments int NOT NULL,
							payment_date date NOT NULL,
							installment_no int,
							payment_method varchar(20) NOT NULL,
							PRIMARY KEY (p_id),
							FOREIGN KEY (bill_no) references client_bill(bill_no));
                            
create table interns_info(intern_id int NOT NULL,
						  intern_name varchar(30) NOT NULL,
						  intern_contact bigint NOT NULL,
						  intern_email varchar(30) NOT NULL,
                          intern_address varchar(100) NOT NULL,
                          intern_aadhar_no varchar(20) NOT NULL,
						  PRIMARY KEY (intern_id));             
                                                    
create table salary_expences(salary_id int AUTO_INCREMENT,
							intern_id int NOT NULL,
							intern_acc_no int NOT NULL,
							salary_date date NOT NULL,
							payment_method varchar(10) NOT NULL,
							PRIMARY KEY (salary_id),
							FOREIGN KEY (intern_id) references interns_info(intern_id));                
             
create table other_advocates(adv_id int AUTO_INCREMENT,
							adv_name varchar(30) NOT NULL,
							adv_contact int NOT NULL,
							adv_specialization varchar(50),
							adv_email varchar(30) NOT NULL,
							PRIMARY KEY (adv_id));        
                            
create table other_advocates_payments(adv_pay_id int NOT NULL AUTO_INCREMENT,
									  adv_id int NOT NULL,
									  adv_acc_no int NOT NULL,
									  adv_pay_amt double NOT NULL,
									  adv_pay_date date NOT NULL,
									  adv_pay_meth varchar(20) NOT NULL,
									  PRIMARY KEY (adv_pay_id),
									  FOREIGN KEY (adv_id) references other_advocates(adv_id));
                                      
create table rent_payment(r_id int NOT NULL AUTO_INCREMENT,
						  owner varchar(30) NOT NULL,
						  owner_acc_no int NOT NULL,
						  rent_amt double NOT NULL,
						  rent_pay_date date NOT NULL,
						  pay_meth varchar(20) NOT NULL,
						  PRIMARY KEY(r_id));                                      
                            
create table clarks(clark_id int NOT NULL AUTO_INCREMENT,
					clark_name varchar(30) NOT NULL,
					clark_contact int NOT NULL,
					clark_email varchar(30),
					PRIMARY KEY (clark_id));          
                    
create table clark_fee(clark_pay_id int NOT NULL AUTO_INCREMENT,
					   clark_id int NOT NULL,
					   clark_acc_no int NOT NULL,
					   clark_pay_date date NOT NULL,
					   clark_pay_meth varchar(20) NOT NULL,
					   PRIMARY KEY(clark_pay_id),
					   FOREIGN KEY (clark_id) references clarks(clark_id));
                       
create table office_expences(off_exp_id int NOT NULL AUTO_INCREMENT,
							 off_exp_type varchar(30),
							 off_exp_amt double NOT NULL,
							 off_exp_date date NOT NULL,
							 off_exp_pay_meth varchar(20) NOT NULL,
							 PRIMARY KEY(off_exp_id));                    
                             
create table personal_expences(p_exp_id int NOT NULL AUTO_INCREMENT,
							   p_exp_date date NOT NULL,
							   p_expence_amt double NOT NULL,
							   petrol_exp_amt double NOT NULL,
							   travel_exp_amt double NOT NULL,
							   total_p_exp double NOT NULL,
							   PRIMARY KEY(p_exp_id));        
                               
create table total_expences(exp_id int NOT NULL AUTO_INCREMENT,
							salary_id int NOT NULL,
							r_id int NOT NULL,
							adv_pay_id int NOT NULL,
							clark_pay_id int NOT NULL,
							off_exp_id int NOT NULL,
							p_exp_id int NOT NULL,
							total_exp_amt double NOT NULL,
							balance_amt double NOT NULL,
							PRIMARY KEY (exp_id),
							FOREIGN KEY (salary_id) references salary_expences(salary_id),
							FOREIGN KEY (r_id) references rent_payment(r_id),
							FOREIGN KEY (adv_pay_id) references other_advocates_payments(adv_pay_id),
							FOREIGN KEY (clark_pay_id) references clark_fee(clark_pay_id),
							FOREIGN KEY (off_exp_id) references office_expences(off_exp_id),
							FOREIGN KEY (p_exp_id) references personal_expences(p_exp_id));     
                            
insert into case_info values (1, 'abc', 'estjr trdutfoh srjh;huyt srdyiygo sryigh', 'open', 'criminal', 'mumbai court', '2017-06-15', '2017-07-15', 'fhjhgky', '2017-06-15', 'doc1', 'C:/Users/DELL/Documents/Advocate_firm_Project/basic_info/doc1.txt', '2017-06-20', '2017-08-02', 'adv.hbhdjh');
insert into case_info values (2, 'hgj', 'trdutf gubioyufr guyg gdrutfg gyih', 'pending', 'family', 'chennai court', '2020-06-18', '2020-07-22', 'vfcjhbk', '2020-06-23', 'doc2', 'C:/Users/DELL/Documents/Advocate_firm_Project/basic_info/doc2.txt', '2020-06-20', '2020-10-02', 'adv.jhjyg');
insert into case_info values (3, 'mnb', 'kkjdsfhksjd hdhf hf khdfliudhd iuhuf', 'closed', 'civil', 'banglore court', '2010-06-15', '2010-07-15', 'fhjhgky', '2010-06-15', 'doc3', 'C:/Users/DELL/Documents/Advocate_firm_Project/basic_info/doc3.txt', '2010-06-20', '2010-08-02', 'adv.hgfgd');

ALTER TABLE client_bill MODIFY bank_acc_no bigint;  
ALTER TABLE salary_expences MODIFY intern_acc_no bigint;  
ALTER TABLE other_advocates_payments MODIFY adv_acc_no bigint;  
ALTER TABLE rent_payment MODIFY owner_acc_no bigint;
ALTER TABLE clark_fee MODIFY clark_acc_no bigint;



insert into client_info values (1, 1, 'bhcd', 84562147620, 'ljhdfks@gmail.com', 'v2, jbldfm, nkjdfnl, hjdbsl', 'manager');
insert into client_info values (2, 3, 'mnhf', 94130163021, 'jytdersj@gmail.com', 'dfjsbh, khff,khsdb,hsdbfjls,hbf', 'teacher');
insert into client_info values (3, 2, 'jgfk', 73533643336, 'kjgbvdrfjh@gmail.com', '02h, kbhkjhb, jvmj, mjhvkj', 'employee');


insert into client_bill values(1, 1, 1, '2017-05-02', 600.00, 300.00, 500.00, 200.00, 800.00, 400.00, 100.00, 250.00, 600.00, 650.00, 7890.00, 'cgscgh bank', 'asjvk, jsbhdj, kjsbdh, bkjd', 1254789632, 'GH654j2515', 'Bhfjg5126JK', 'C:/Users/DELL/Documents/Advocate_firm_Project/basic_info/doc1.txt');
insert into client_bill values(2, 2, 3, '2020-05-02', 800.00, 400.00, 200.00, 200.00, 1000.00, 500.00, 100.00, 150.00, 700.00, 350.00, 4480.00, 'cgscgh bank', 'asjvk, jsbhdj, kjsbdh, bkjd', 1526456965, 'BP58256Y56', 'MGD65GHJ354', 'C:/Users/DELL/Documents/Advocate_firm_Project/basic_info/doc2.txt');
insert into client_bill values(3, 3, 2, '2010-05-02', 600.00, 0, 500.00, 200.00, 1000.00, 400.00, 0, 250.00, 600.00, 850.00, 4400.00, 'cgscgh bank', 'asjvk, jsbhdj, kjsbdh, bkjd', 14328426716, 'KL4654GHJ', 'PFH5621NK4', 'C:/Users/DELL/Documents/Advocate_firm_Project/basic_info/doc3.txt');

insert into client_payment values(1, 1, 6, '2017-08-10', 2, 'upi');
insert into client_payment values(2, 2, 4, '2020-08-10', 1, 'cash');
insert into client_payment values(3, 3, 8, '2017-08-10', 5, 'NEFT');

insert into interns_info values(1, 'abc', 9423100752, 'gvckhdf@gmail.com', '2w, bhjbdm, bdjabh bsahdb, jhsabd,', 34528846621);
insert into interns_info values(2, 'mbh', 8434304775, 'mbvjdgkeu@hotmail.com', '9bd, sbdh bjsas, hbdj mdhbj,b,jsbdhl', 62478515621);
insert into interns_info values(3, 'lkj', 7216668952, ',mnsdhbfjhbljh@yahoo.com', 'bashb, bhsdb jhbdsfjb jbhdsjfb, hbsdjs', 3321446621);

insert into salary_expences values(1, 1, 3000462156, '2021-04-03', 'upi');
insert into salary_expences values(2, 2, 4235463135, '2020-12-05', 'NEFT');
insert into salary_expences values(3, 3, 6445145541, '2022-10-03', 'NEFT');

insert into other_advocates values(1, 'dsda', 945621456, 'defence', 'kshgvdkhg@gmail.com');
insert into other_advocates values(2, 'jsvd', 8133156631, 'dhjsdbj', 'asdfsgasfs@gmail.com');
insert into other_advocates values(3, 'dfds', 9456484515, 'nkdfjlksjd', 'sdhfintfrd@gmail.com');

insert into other_advocates_payments values(1, 1, 846454321384, 1000.00, '2022-06-01', 'NEFT');
insert into other_advocates_payments values(2, 2, 100030007587, 3000.00, '2022-09-01', 'NEFT');
insert into other_advocates_payments values(3, 3, 200034820025, 1000.00, '2022-10-01', 'NEFT');

insert into rent_payment values(1, 'sfsgdg', 30054321300, 20000.00, '2010-06-01', 'UPI');
insert into rent_payment values(2, 'sfsgdg', 30054321300, 20000.00, '2010-07-01', 'UPI');
insert into rent_payment values(3, 'sfsgdg', 30054321300, 20000.00, '2010-08-01', 'UPI');

insert into clarks values(1, 'nkjhjkfv', 84100035881, 'vksdgfvhjgv@gmail.com');
insert into clarks values(2, 'mghgfttv', 72614522455, 'jyfdcregu@gmail.com');
insert into clarks values(3, 'ubyvtrcdr', 9120177852, 'ohiugyhftrdesr@gmail.com');
 
insert into clark_fee values(1, 1, 1400100035881, '2010-06-01', 'UPI');

insert into office_expences values(1, 'stationary', 500.00, '2021-02-23', 'UPI'); 
insert into office_expences values(2, 'cleaning', 800.00, '2021-04-01', 'cash'); 
insert into office_expences values(3, 'stationary', 200.00, '2021-05-20', 'UPI'); 

insert into personal_expences values(1, '2022-11-25', 500.00, 0, 200.00, 700.00); 
insert into personal_expences values(2, '2022-12-09', 0, 300.00, 100.00, 400.00); 
insert into personal_expences values(3, '2023-09-25', 500.00, 100.00, 200.00, 800.00); 

ALTER TABLE salary_expences ADD COLUMN salary_amt double NOT NULL AFTER intern_acc_no ; 

insert into total_expences values(1, 1, 1, 1, 1, 1, 1, ); 

select * from case_info;   

select * from app_user;                         
                    