-- no-auto-rehash

use drh4179

drop table if exists SiteEmployees;
drop table if exists SiteCustomers;
drop table if exists SiteProducts;
drop table if exists SiteOrders;
drop table if exists SiteOdetails;
drop table if exists Addresses;


CREATE TABLE SiteProducts    (PNO varchar(6),
                       PNAME varchar(30),
					   QOH int not null, 
					   PRICE numeric(4,2),
					   LEV int not null,
                       PRIMARY KEY (PNO)) ENGINE=INNODB;
CREATE TABLE Addresses (ZIP varchar (6),
					   CITY varchar (20),
					   PRIMARY KEY (ZIP)) ENGINE=INNODB;
					   
CREATE TABLE SiteEmployees (ENO varchar(5),
                      ENAME varchar(15),
                      ZIP char(5),
					  HDATE date,
                      PRIMARY KEY(ENO),
					  FOREIGN KEY (ZIP)
                      REFERENCES Addresses(ZIP)
                      ON UPDATE CASCADE ON DELETE RESTRICT)	ENGINE=INNODB;

CREATE TABLE SiteCustomers (CNO varchar(6),
                      CNAME varchar(20),
                      STREET varchar(20),
					  ZIP varchar(6),
					  PHONE varchar(15),
                      PRIMARY KEY(CNO, CNAME),
                      FOREIGN KEY (ZIP)
                      REFERENCES Addresses(ZIP)
                      ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;
					  
CREATE TABLE SiteOrders (ONO varchar(6),
                      CNO varchar(6),
                      ENO varchar(6),
					  RECEIVED date,
					  SHIPPED date,
                      PRIMARY KEY(ONO),
                      FOREIGN KEY (CNO)
                      REFERENCES SiteCustomers(CNO)
                      ON UPDATE CASCADE ON DELETE RESTRICT,
					  FOREIGN KEY (ENO)
                      REFERENCES SiteEmployees(ENO)) ENGINE=INNODB;
					  
CREATE TABLE SiteOdetails (ONO varchar(6),
                      PNO varchar(6),
                      QTY int not null,
                      FOREIGN KEY(ONO)
					  REFERENCES SiteOrders(ONO)        
                      ON UPDATE CASCADE ON DELETE RESTRICT,
					  PRIMARY KEY(ONO),
					  FOREIGN KEY(PNO)
					  REFERENCES SiteProducts(PNO)) ENGINE=INNODB;