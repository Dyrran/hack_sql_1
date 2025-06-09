/* H-1 */
create table countries(
  id_country serial primary key,
  name varchar(50) not null  
);

create table users(
 id_users serial primary key,
 id_country integer not null,
 email varchar(100) not null,
 name varchar (50) not null,
 foreign key (id_country) references countries (id_country)   
);

/* H-2 */

insert into countries (name) values ('argentina') , ('colombia'), ('chile');
select * from countries;

insert into users (id_country, email, name)
values (2, 'foo@foo.com', 'fooziman'), (3, 'bar@bar.com', 'barziman'),
(1, 'alpha@alpha.com', 'alpha'), (1, 'bravo@bravo.com', 'bravo');
select * from users;

delete from users where email = 'bar@bar.com';

update users set email = 'foo@foo.foo', name = 'fooz' where id_users = 1;
select * from users;

select * from users inner join countries on users.id_country = countries.id_country;

select u.id_users as id, u.email, u.name as fullname, c.name
from users u inner join  countries c on u.id_country = c.id_country;

/* H-3 */
create table priorities(
  id_priority serial primary key,
  type_name varchar(100) not null
);

create table contact_request(
  id_email serial primary key,
  id_country integer not null,
  id_priority integer not null,
  name varchar(150) not null,
  detail varchar(200) not null,
  physical_address varchar(500) not null,
  foreign key (id_country) references countries (id_country),
  foreign key (id_priority) references priorities (id_priority)
);

/* H-4 */
insert into countries (name) values ('alemania') ,
('nueva zelanda'), ('estados unidos') , ('italia') , ('francia');

select * from countries;

insert into priorities (type_name) values ('high') , ('medium') , ('low');

insert into contact_request (id_country, id_priority, name, detail, physical_address)
values (1, 1, 'Amanda Johnson', 'Product Manager', 'Oficina 312, Edf. Briize, Buenos Aires, Argentina'),
(1, 2, 'Elena Frizz', 'Product Manager', 'House B, Building C, New York, USA'),
(1, 3, 'John Eerie', 'Product Manager', 'Leu Blanc, Louvre, France');

delete from users where id_users = (select max(id_users) from users);
update users set name = 'Epsilon Alpha' where id_users = 1;

-- H-5

-- Table countries already exists

create table roles(
  id_role serial primary key,
  name varchar(100) not null
);

create table taxes(
  id_tax serial primary key,
  percentage integer not null
);

create table offers(
  id_offer serial primary key,
  status varchar(50) not null
);

create table discounts(
  id_discount serial primary key,
  status varchar(50) not null,
  percentage integer not null
);

create table payments(
  id_payment serial primary key,
  type_op varchar(100) not null
);

create table customers(
  id_customer serial primary key,
  email varchar(320) not null,
  id_country integer not null,
  id_role integer not null,
  name varchar(200) not null,
  age integer,
  password varchar(20),
  physical_address varchar(500) not null
);

create table invoice_status(
  id_invoice_status serial primary key,
  status varchar(100) not null
);

create table products(
  id_product serial primary key,
  id_discount integer not null,
  id_offer integer not null,
  id_tax integer not null,
  name varchar(200) not null,
  details varchar(500) not null,
  minimum_stock integer not null,
  maximum_stock integer not null,
  current_stock integer not null,
  price decimal(12, 2) not null,
  price_with_tax decimal(12, 2) not null,
  
  foreign key (id_discount) references discounts (id_discount),
  foreign key (id_offer) references offers (id_offer),
  foreign key (id_tax) references taxes (id_tax)
);

create table products_customers(
  id_product integer not null,
  id_customer integer not null,
  
  foreign key (id_product) references products (id_product),
  foreign key (id_customer) references customers (id_customer)
);

create table invoices(
  id_invoice serial primary key,
  id_customer integer not null,
  id_payment integer not null,
  id_invoice_status integer not null,
  date date not null,
  total_to_pay decimal(12, 2) not null,
  
  foreign key (id_customer) references customers (id_customer),
  foreign key (id_payment) references payments (id_payment),
  foreign key (id_invoice_status) references invoice_status (id_invoice_status)
);

create table orders(
  id_order serial primary key,
  id_invoice integer not null,
  id_product integer not null,
  detail varchar(500),
  amount integer not null,
  price decimal(12, 2) not null,
  
  foreign key (id_invoice) references invoices (id_invoice),
  foreign key (id_product) references products (id_product)
);

-- H-6
insert into countries (name) values ('venezuela') , ('españa') , ('suiza');

insert into users (id_country, email, name) values
(9, 'dominguezperez@example.com', 'domper'),
(8, 'viennaerika@example.com', 'erivien'),
(6, 'johnsmithson@example.com', 'jonsmi');

insert into priorities (type_name) values
('none'), ('to-assign'), ('presidential-order');

insert into contact_request (id_country, id_priority, name, detail, physical_address) values
(7, 4, 'Kevin Excellent', 'Social Media Strategist', '18th Arrondissement - Butte-Montmartre'),
(9, 1, 'Juana Rodríguez', 'CEO', 'Av. Urdaneta, Caracas'),
(10, 5, 'Julio Banderas', 'Administrator', 'Gran Vía, Madrid');

insert into roles (name) values ('guest') , ('common') , ('vip');

insert into taxes (percentage) values (16), (12), (0);

insert into offers (status) values ('available') , ('unavailable') , ('few left!');

insert into discounts (status, percentage) values
('available', 0) , ('available', 25) , ('unavailable', 40);

insert into payments (type_op) values ('cash') , ('debit card') , ('credit card');

insert into customers (email, id_country, id_role, name, age, password, physical_address) values
('annayield@example.com', 1, 2, 'Anna Yield', 26, 'ayer1234', 'Av. Aguas Blancas'),
('veromars@example.com', 4, 3, 'Veronika Marss', 41, 'entschuldigung', 'Av. Kevv'),
('julesandanza@example.com', 10, 2, 'Jules Andanza', 39, 'ohrayos123', 'Edf. Grand, Av. Ule');

insert into invoice_status (status) values
('processed') , ('in process') , ('cancelled');

insert into products (id_discount, id_offer, id_tax, name, details, minimum_stock, maximum_stock, current_stock, price, price_with_tax) values
(1, 1, 1, 'hdd-4tb-ext-sea', 'External HDD 4TB Seagate', 5, 100, 20, 100, 116),
(2, 2, 3, 'hdmi-cable-5m-gen', 'HDMI Cable 5 Meters Generic', 20, 400, 20, 10, 10),
(2, 3, 1, 'ssd-512gb-int-kin', 'SSD 512GB Kingston', 2, 50, 3, 50, 58);

insert into products_customers (id_product, id_customer) values (1, 2), (2, 1), (3, 3);

insert into invoices (id_customer, id_payment, id_invoice_status, date, total_to_pay) values
(1, 1, 2, '2025-06-05', 580.00),
(2, 2, 3, '2025-06-06', 100.00),
(3, 3, 1, '2025-06-07', 116.00);

insert into orders (id_invoice, id_product, detail, amount, price) values
(1, 1, '', 5, 116.00),
(2, 2, '', 10, 10.00),
(3, 3, '', 2, 58.00);

delete from users where id_users = (select max(id_users) from users);
delete from users where id_users = (select min(id_users) from users);

update taxes set percentage = 18 where id_tax = 1;
update taxes set percentage = 14 where id_tax = 2;
update taxes set percentage = 5 where id_tax = 3;

update products set price = 125, price_with_tax = 147.50 where id_product = 1;
update products set price = 15, price_with_tax = 15.75 where id_product = 2;
update products set price = 70, price_with_tax = 82.60 where id_product = 3;
