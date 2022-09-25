-- 	Inserção de dados SQL - Ecommerce

    use dbecommerce;
    
    show tables;
    
    -- CLIENTES:
    -- idCLiente, Fname Minit, Lname , CPF, Adress
    DESC clients;
    -- 
    insert into Clients (Fname, Minit, Lname, CPF, Address)
	values('Maria','M','Silva',12346789, 'rua silva  29, Carangola'),
		   ('Matheus','O','Pimentel',987654321, 'alemeda 289, Cidade B'),
          ('Ricardo','F','Silva',45678913, 'alemeda 1009, Cidade D'),
          ('Julia','S','França',789123456, 'laranjeiras 861, Cidade B'),
          ('Roberta','G','Assis',98745631, 'avenida koiler 19, Cidade A'),
          ('Isabela','M','Cruz',654789123, 'alemeda 28, Cidade C');
select * from clients;
-- PRODUCT
  -- idProduct, Pname, classification_kids boolean, category((enum('Eletrônico','Vestimenta','Brinquedo','Alimentos','Móveis')), avaliação, size

  DESC product;
          insert into product (Pname, classification_kids, category, avaliação, size) values
										('Fones ouvido',false,'Eletrônico','4',null),
                                        ('Barbie Elsa',true,'Brinquedo','3',null),
                                        ('Body Carters',true,'Vestimenta','5',null),
                                        ('Microfone Vedo',false,'Eletrônico','4',null),
                                        ('Sofá retrátil',false,'Móveis','3','3x57x80'),
                                        ('Farinha de arroz',false,'Alimentos','2',null),
                                        ('Fire Stick Amazon',false,'Eletrônico','3',null);
                                        
select * from product;

-- ORDERS
DESC ORDERS;
-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
							(1,default,'compra via aplicativo',null,1),
                            (2,default,'compra via aplicativo',50,0),
                            (3,'Confirmado',null,null,1),
                            (4,default,'compra via web site',150,0);
  select * from orders;                          

-- PRODUCT ORDER

DESC productOrder;
select * from productOrder;
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,5,2,default),
                         (2,5,1,default),
                         (3,6,1,default);
  select * from productOrder;   

--  PRODUCT STORAGE
insert into productStorage (storageLocation,quantity) values
						   ('Rio de Janeiro',1000),
                           ('Rio de Janeiro',500),
                           ('São Paulo',10),
                           ('São Paulo',100),
                           ('São Paulo',10),
                           ('Brasília',60);
select * from productStorage;

-- STORAGE LOCATION 

insert into storageLocation (idLproduct, idLstorage, location) values
						(1,2,'RJ'),
                        (2,6,'GO');
select * from storageLocation;

-- SUPPLIER

insert into supplier (SocialName, CNPJ, contact) values
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
                            
    select * from supplier;     
    
-- PRODUCT SUPPLIER

insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
				         (1,2,400),
                        (2,4,633),
                        (3,3,5),
                        (2,5,10);
select * from productSupplier;

-- SELLER       

insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
						('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
                        ('Botique Durgas', null,123456789456350, 123456783,'Rio de Janeiro', 219567895),
                        ('Kids World', null,456789123654485,null, 'São Paulo', 1198657484);
                        
select * from seller;


-- QUERIES 


select count(*) from clients;

select * from clients c, orders o 
	where c.idClient=idOrderClient; 

select Fname, Lname, idOrder, orderStatus from clients c, orders o 
	where c.idClient=idOrderClient; 

select concat(Fname,' ', Lname) as client, idOrder as Request , orderStatus from clients c, orders o 
	where c.idClient=idOrderClient; 
    
select concat(Fname,' ', Lname) as client, idOrder as Request , orderStatus from clients c, orders o 
	where c.idClient=idOrderClient; 

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
							(2,default,'compra via aplicativo',null,1);

select * from clients c, orders o
		where c.idClient=idOrderClient
        group by idOrder;

-- recuperação de pedido com produto associado
select * from clients c inner join orders  o
		ON c.idClient=o.idOrderClient
        inner join productOrder p on p.idPOorder=o.idOrder
        group by idClient;
        

-- Recuperar quantos pedidos foram realizados pelos clientes?
select c.idClient, Fname, count(*) as Number_of_orders from clients c
				inner join orders o ON c.idClient * o.idOrderClient
			group by idClient;	

select * from clients;

-- Clientes que moram na cidade B
select concat(Fname,' ', Lname), Address as client from clients 
	where Address like '%B';
 
-- clientes que tem o pedido em processamento
 
select Fname, Lname, idOrder, orderStatus from clients c, orders o 
	where c.idClient=idOrderClient AND orderStatus= "Em processamento";
 
 show tables;



-- Produtos em estoque com quantidade maior a 50 unidades
select  p.idProduct, p.pname, pe.quantity, pe.storageLocation from  product p, productStorage pe 
	where p.idProduct= pe.idProductStorage  
   having (pe.quantity) >50
    order by idProduct;

-- Clientes que compraram via aplicativo
select concat(c.fname, ' ', c.lname) as 'client',orderDescription
 from clients c, orders o
 where o.idOrderClient = c.idClient
 and orderDescription ='compra via aplicativo'
 group by c.fname;
 

select * from orders;
select * from product;
select * from clients;
select * from productStorage;

-- Quantidade de pedidos realizados pelos clientes
select concat(c.Fname, ' ', c.Lname) as 'Nome Completo', count(o.idOrder) as 'Quantidade de Pedidos'
 from clients c  left join orders o 
 on o.idOrderClient = c.idClient
 group by c.idClient;
    

