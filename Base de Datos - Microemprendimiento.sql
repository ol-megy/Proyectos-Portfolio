# Base de datos de un micro-emprendimiento. Parte de la asignatura Sistemas de Información Estadística.

# Joaquin y Pedro son dos amigos que en 2018 inician un microempredimiento dedicado a la venta de camisetas 
# de futbol, llamado "TuCasaca". En los años siguientes se sumaron al mismo sus amigos Sebastián, 
#Benito y Miguel. La Base de datos diseñada contiene en tablas relacionadas los datos relativos 
#a las camisetas que ofrecen, a los pedidos y pagos que reciben, información de los clientes y 
#de los vendedores.

#Primero se crea la base de datos, llamada "TuCasaca" y las 7 tablas que integran la misma.
CREATE DATABASE TUCASACA;

CREATE TABLE tucasaca.camisetas (
camiseta_id int primary key not null unique,
equipo varchar(30),
pais varchar(30),
modelo smallint,
precio decimal(8,2) ,
ganancia decimal(8,2)
);  

CREATE TABLE tucasaca.talles (
talle_id int primary key not null unique,
talle_nombre varchar(25)
);

CREATE TABLE tucasaca.provincias (
provincia_id tinyint primary key not null unique,
provincia_nombre varchar(35)
);

CREATE TABLE tucasaca.clientes(
cliente_id int primary key not null unique,
nombre varchar(30) not null,
apellido varchar(30) not null,
mail varchar(35) not null,
provincia_id tinyint not null,
FOREIGN KEY (provincia_id) references provincias(provincia_id)
);

CREATE TABLE tucasaca.vendedores (
vendedor_id int primary key not null unique auto_increment,
nombre varchar(30) not null,
apellido varchar(30) not null,
mail varchar(40) not null,
ingreso date
); 

CREATE TABLE tucasaca.pedidos (
pedido_id int primary key not null unique auto_increment,
camiseta_id int not null, 
cliente_id int not null, 
vendedor_id int,
fecha date,
talle_id int not null,
FOREIGN KEY (camiseta_id) references camisetas(camiseta_id),
FOREIGN KEY (cliente_id) references clientes(cliente_id),
FOREIGN KEY (vendedor_id) references vendedores(vendedor_id),
FOREIGN KEY (talle_id) references talles(talle_id)
);


CREATE TABLE tucasaca.pagos (
pago_id int primary key not null unique auto_increment,
cliente_id int not null,
monto decimal(8,2) not null,
fecha_pago date not null,
pedido_id int not null,
FOREIGN KEY (cliente_id) references clientes(cliente_id),
FOREIGN KEY (pedido_id) references pedidos(pedido_id)
); 


INSERT INTO tucasaca.camisetas
VALUES(1, 'San Lorenzo', 'Argentina', 2021, 3000, 1000),
(2, 'Racing', 'Argentina', 2021, 3200, 1200),
(3, 'Independiente', 'Argentina', 2021, 3600, 1300),
(4, 'Boca Juniors', 'Argentina', 2021, 5000, 1500),
(5, 'River Plate', 'Argentina', 2021, 5000, 1500),
(6, 'Velez Sarfield', 'Argentina', 2021, 2800, 800),
(7, 'Huracan', 'Argentina', 2021, 1600, 900),
(8, 'Argentinos', 'Argentina', 2021, 1600, 800),
(9, 'Gimnasia', 'Argentina', 2021, 2400, 700),
(10, 'Platense', 'Argentina', 2021, 2100, 900),
(11, 'Lanus', 'Argentina', 2021, 2200, 600),
(12, 'Banfield', 'Argentina', 2021, 2300, 600),
(13, 'Talleres', 'Argentina', 2021, 4000, 800),
(14, 'Newells Old Boys', 'Argentina', 2021, 3800, 850),
(15, 'Rosario Central', 'Argentina', 2021, 3900, 875),
(16, 'Godoy Cruz', 'Argentina', 2021, 3600, 1100),
(17, 'Atletico Tucuman', 'Argentina', 2021, 2400, 650),
(18, 'Colon', 'Argentina', 2021, 3100, 1100),
(19, 'Real Madrid', 'España', 2021, 6500, 2000),
(20, 'Barcelona', 'España', 2021, 6200, 2100),
(21, 'Atletico de Madrid', 'España', 2021, 5000, 1500),
(22, 'Liverpool', 'Inglaterra', 2021, 6300, 2050),
(23, 'Manchester City', 'Inglaterra', 2021, 6100, 2350),
(24, 'Manchester United', 'Inglaterra', 2021, 5800, 2200),
(25, 'Chelsea', 'Inglaterra', 2021, 6300, 2050),
(26, 'Arsenal', 'Inglaterra', 2021, 5300, 1600),
(27, 'Tottenham', 'Inglaterra', 2021, 5000, 1500),
(28, 'PSG', 'Francia', 2021, 7000, 3000),
(29, 'Lyon', 'Francia', 2021, 4400, 1200),
(30, 'Juventus', 'Italia', 2021, 6000, 2100),
(31, 'Milan', 'Italia', 2021, 5400, 1600),
(32, 'Inter', 'Italia', 2021, 5200, 1400),
(33, 'Napoli', 'Italia', 2021, 4600, 1400),
(34, 'Napoli', 'Retro', 1984, 7500, 3500),
(35, 'Argentina', 'Selecciones', 2020, 7500, 3000),
(36, 'Brasil', 'Selecciones', 2020, 6500, 2000),
(37, 'Argentina', 'Retro', 1986, 5500, 1500),
(38, 'Boca Juniors', 'Retro', 1981, 5000, 1200),
(39, 'River Plate', 'Retro', 1986, 4500, 1000);

INSERT INTO tucasaca.talles
VALUES (1, 'XS - Extra Small'),
(2, 'S - Small'),
(3, 'M - Medium'),
(4, 'L - Large'),
(5, 'XL- Extra Large'),
(6,  'XXL - Extra Extra Large')
;

INSERT INTO tucasaca.provincias
VALUES (1, 'Buenos Aires'),
(2, 'Córdoba'),
(3, 'Santa Fe'),
(4, 'Mendoza'),
(5,  'Tucumán'),
(6, 'Entre Ríos'),
(7,  'Salta'),
(8,  'Misiones'),
(9,  'Chaco'),
(10,  'Corrientes'),
(11,  'Santiago del Estero'),
(12,  'San Juan'),
(13, 'Jujuy'),
(14,  'Río Negro'),
(15,  'Neuquén'),
(16,  'Formosa'),
(17,  'Chubut'),
(18,  'San Luis'),
(19,  'Catamarca'),
(20,  'La Rioja'),
(21,  'La Pampa'),
(22, 'Santa Cruz'),
(23, 'Tierra del Fuego'),
(24,  'Ciudad de Buenos Aires');

INSERT INTO tucasaca.clientes
VALUES(1, 'Esteban', 'Zavej', 'e.zavej@gmail.com', 24 ),
(2, 'German', 'Zapata', 'germanzapata@gmail.com', 24 ),
(3, 'Luciana', 'Musso', 'lu.musso@gmail.com', 24 ),
(4, 'Roberto', 'Meli', 'robert.meli@hotmail.com', 1 ),
(5, 'Cristian', 'Lampart', 'c.lampart@hotmail.com', 24 ),
(6, 'Luis', 'Bazan', 'luisb93@gmail.com', 1 ),
(7, 'Fabian', 'Tamudo', 'fabitamudo@gmail.com', 24 ),
(8, 'Ricardo', 'Ribeiro', 'richard.ribeiro@gmail.com', 1 ),
(9, 'Silvia', 'Martinelli', 's_martinelli@gmail.com', 24 ),
(10, 'Camilo', 'Osorio', 'camilo.osorio@gmail.com', 7 ),
(11, 'Emilio', 'Saladino', 'emisaladino9@gmail.com', 3 ),
(12, 'Raul', 'Ortega', 'raulortega65@gmail.com', 24 ),
(13, 'Juan Fernando', 'Quiroga', 'juan.fernando.quiroga@gmail.com', 24 ),
(14, 'Ignacio', 'Perez Alfaro', 'nachoperez93@gmail.com', 24 ),
(15, 'Gaston', 'Fuentes', 'gastifuentes@hotmail.com', 3 ),
(16, 'Hernan', 'Osorio', 'hernan.o.1979@gmail.com', 24 ),
(17, 'Gomez', 'Eva', 'eva_gomez@gmail.com', 24 ),
(18, 'Guadalupe Nadia', 'Danylyzyn', 'guada-dany@yahoo.com', 24 ),
(19, 'Lucrecia', 'Kim', 'lu.kim@gmail.com', 24 ),
(20, 'Fernando Carlos', 'Zambrano', 'fer_zambrano@gmail.com', 24 ),
(21, 'Gustavo Anibal', 'Wolf', 'gusta-wolf-54@gmail.com', 24 ),
(22, 'Alfio Raul', 'Merlo', 'alfioraulmerlo@gmail.com', 2 ),
(23, 'Reinaldo Carlos', 'Chamot', 'rei.chamot.55@gmail.com', 3 ),
(24, 'Matias Federico', 'Sosa', 'mati_sosa_99@gmail.com', 24 ),
(25, 'Francisco', 'Nardi', 'pancho_nardi97@gmail.com', 24 ),
(26, 'Laura', 'Alfano', 'laura.alfano@gmail.com', 24 ),
(27, 'Gabriel', 'Andrade', 'gabo_andrade_carp@hotmail.com', 24 ),
(28, 'Paulo Andres', 'Scott', 'paulo-scott@yahoo.com.ar', 24 ),
(29, 'Isabel', 'Queiros', 'bel.queiros@gmail.com', 24 ),
(30, 'Justino', 'Ribeiro', 'justin.ribeiro.63@gmail.com', 24 ),
(31, 'Alicia', 'Dominguez', 'ali.dominguez.65@gmail.com', 24 ),
(32, 'Fernando Alejandro', 'Tapia', 'fer.tapia.83@gmail.com', 24 ),
(33, 'Patricio Rafael', 'Gonzalez', 'patricio_rafael_gonzalez@gmail.com', 24 ),
(34, 'Severino', 'Olmedo', 'seve.olmedo@hotmail.com', 24 ),
(35, 'Felipe Tomás', 'Tomasseli', 'felipe_tomasseli@gmail.com', 24 ),
(36, 'Marcos', 'Fernandez', 'marquitos_fernandezzz@gmail.com', 24 ),
(37, 'Cristian', 'Rodriguez Gallo', 'cris.rodriguez.gallo@gmail.com', 24 ),
(38, 'Juan Pablo', 'Tabarez', 'jp.tabarez.8@gmail.com', 24 ),
(39, 'Juan Martin', 'Olivares Lopez', 'jm.olivares.lopez@gmail.com', 24 ),
(40, 'Norberto Jesus', 'Sandez', 'norberto.sandez@gmail.com', 24 ),
(41, 'Radamel Luis', 'Cuerdera', 'rada-cuerda@yahoo.com', 2 ),
(42, 'Mariela', 'Acosta', 'mari.a7765@hotmail.com', 3 ),
(43, 'Sebastian', 'Ventura', 'seba.ventura@hotmail.com', 24 ),
(44, 'Cristina Teresa', 'Ivanovic', 'cris.ivanovic@gmail.com', 3 ),
(45, 'Lucas Ezequiel', 'Sanchez', 'luquitas.ezequiel@gmail.com', 24 ),
(46, 'Susana', 'Olmedo', 'susanitaolmedo76@gmail.com', 24 ),
(47, 'Dario Braian', 'Fernandez', 'dario.fernandez8843@yahoo.com', 4 ),
(48, 'Jonathan', 'Sanchez', 'jony.sanchez22@gmail.com', 24 ),
(49, 'Carlos', 'Sosa', 'charlysosa15@hotmail.com', 24 ),
(50, 'Maximiliano', 'Torres', 'maxi_torres75@hotmail.com', 5 ),
(51, 'Ramiro', 'Diaz Ferreira', 'ramadiazferreira@hotmail.com', 24 )
;

INSERT INTO tucasaca.vendedores (nombre, apellido, mail, ingreso)
VALUES('Joaquin', 'Fernandez', 'joa.fernandez@gmail.com', '2018-07-01'),
('Pedro', 'Fernandez', 'peter.fer89@gmail.com', '2018-07-01'),
('Sebastian', 'Pintos', 'seba.pintos92@gmail.com', '2019-08-01'),
('Benito', 'Galluzzi', 'benito_galluzzi@gmail.com', '2019-08-01'),
('Miguel', 'Andrade', 'migue.andrade@gmail.com', '2020-02-01');

INSERT INTO tucasaca.pedidos (camiseta_id, cliente_id, vendedor_id, fecha, talle_id)
VALUES(35, 1, 2, '2018-07-21', 4), 
(2, 2, 1, '2018-07-25', 3), 
(35, 3, 1, '2018-07-29', 3), 
(4, 4, 2, '2018-08-05', 5), 
(3, 5, 2, '2018-08-09', 2), 
(4, 6, 1, '2018-08-15', 3), 
(4, 7, 1, '2018-08-21', 4),
(35, 8, 2, '2018-09-01', 3), 
(4, 2, 1, '2018-09-11', 2), 
(3, 6, 1, '2018-09-15', 4), 

(38, 9, 1, '2018-09-29', 4), 
(26, 10, 2, '2018-10-02', 5), 
(18, 11, 1, '2018-10-15', 4), 
(5, 12, 1, '2018-10-17', 4), 
(4, 13, 2, '2018-10-19', 2),
(28, 14, 1, '2018-10-24', 3), 
(15, 15, 1, '2018-11-01', 5), 
(4, 16, 2, '2018-11-05', 4), 
(28, 17, 2, '2018-11-14', 3),
(5, 18, 2, '2018-11-23', 2),  

(21, 3, 2, '2018-12-13', 5), 
(5, 12, 1, '2018-12-15', 4), 
(3, 5, 2, '2018-12-18', 4), 
(5, 2, 1, '2018-12-18', 3),  
(4, 4, 2, '2018-12-20', 2), 
(6, 19, 1, '2018-12-21', 1), 
(21, 12, 2, '2018-12-21', 3), 
(4, 20, 1, '2018-12-22', 1), 
(5, 16, 2, '2018-12-22', 6), 
(1, 21, 2, '2018-12-23', 1),  

(13, 22, 2, '2019-01-03', 5), 
(30, 23, 2, '2019-01-03', 2), 
(3, 14, 1, '2019-01-04', 5), 
(4, 24, 1, '2019-01-04', 4),
(1, 25, 1, '2019-01-05', 3), 
(1, 26, 2, '2019-01-05', 4),
(19, 18, 2, '2019-01-29', 3), 
(6, 27, 1, '2019-02-12', 5),
(5, 8, 2, '2019-02-23', 4), 
(4, 28, 1, '2019-03-14', 6),

(20, 29, 2, '2019-03-13', 5), 
(5, 12, 1, '2019-04-20', 3),
(6, 30, 1, '2019-04-22', 4),
(20, 31, 2, '2019-05-08', 4), 
(4, 4, 2, '2019-05-13', 2), 
(20, 32, 2, '2019-05-25', 5), 
(35, 18, 2, '2019-06-09', 3), 
(35, 33, 1, '2019-06-14', 4),
(37, 16, 2, '2019-06-23', 3), 
(19, 34, 2, '2019-06-29', 6), 

(35, 35, 2, '2019-07-13', 5),
(15, 15, 2, '2019-07-20', 2), 
(20, 12, 1, '2019-07-22', 3), 
(37, 9, 1, '2019-07-08', 4), 
(4, 8, 4, '2019-08-13', 3), 
(37, 16, 3, '2019-08-25', 5), 
(7, 36, 2, '2019-08-09', 3),
(38, 4, 4, '2019-09-14', 4), 
(2, 37, 4, '2019-09-23', 6),
(34, 23, 2, '2019-09-29', 5), 

(20, 8, 3, '2019-09-13', 2), 
(7, 38, 1, '2019-09-20', 4),
(35, 39, 4, '2019-10-22', 6),  
(37, 18, 2, '2019-10-08', 4), 
(19, 32, 4, '2019-10-13', 6), 
(5, 29, 2, '2019-10-25', 4), 
(20, 40, 2, '2019-11-09', 3),
(13, 21, 4, '2019-11-14', 4), 
(4, 41, 4, '2019-11-23', 3), 
(15, 42, 4, '2019-12-5', 2), 

(4, 5, 4, '2019-12-15', 3), 
(20, 43, 2, '2019-12-19', 1), 
(28, 4, 2, '2019-12-20', 6), 
(2, 39, 3, '2019-12-20', 1), 
(14, 44, 1, '2019-12-20', 4), 
(35, 45, 4, '2019-12-22', 3),
(4, 46, 3, '2019-12-22', 4),
(34, 21, 2, '2019-12-23', 1), 
(13, 41, 4, '2019-12-23', 4), 
(16, 47, 1, '2019-12-28', 3),

(20, 14, 3, '2020-01-02', 3), 
(2, 43, 2, '2020-01-03', 4), 
(37, 25, 1, '2020-01-04', 3), 
(5, 48, 4, '2020-01-05', 4), 
(20, 49, 3, '2020-01-05', 2),
(4, 4, 2, '2020-02-04', 2), 
(14, 44, 5, '2020-02-09', 4), 
(39, 5, 5, '2020-02-13', 4), 
(17, 50, 5, '2020-02-24', 5),
(20, 48, 2, '2020-03-08', 5), 

(1, 1, 2, '2020-05-28', 3),
(18, 11, 2, '2020-06-15', 4), 
(6, 3, 4, '2020-07-23', 5), 
(21, 14, 5, '2020-07-28', 6), 
(2, 51, 5, '2020-08-18', 2),
(22, 34, 5, '2020-09-22', 3), 
(22, 23, 2, '2020-09-09', 4),
(37, 31, 4, '2020-10-13', 3), 
(20, 29, 2, '2020-10-25', 5), 
(13, 22, 3, '2020-11-02', 3) 
;

INSERT INTO tucasaca.pagos (cliente_id, monto, fecha_pago, pedido_id)
VALUES (1, 7500, '2018-07-21', 1), 
(2, 3200 , '2018-07-28', 2), 
(3, 7500, '2018-07-30', 3), 
(4, 5000, '2018-08-05', 4), 
(5, 3600, '2018-08-09', 5), 
(6, 5000, '2018-08-19', 6),
(7, 5000, '2018-08-22', 7),
(8, 7500, '2018-09-03', 8), 
(2, 5000, '2018-09-11', 9), 
(6, 3600, '2018-09-15', 10), 

(9, 5000, '2018-09-29', 11), 
(10, 5300, '2018-10-06',12), 
(11, 3100, '2018-10-16',13), 
(12, 5000, '2018-10-17',14), 
(13, 5000, '2018-10-19',15),
(14, 7000, '2018-10-24', 16), 
(15, 3900, '2018-11-01',17), 
(16, 5000, '2018-11-08', 18), 
(17, 7000, '2018-11-14', 19),
(18, 5000, '2018-11-23', 20),  

(3, 5000, '2018-12-13', 21), 
(12, 5000, '2018-12-15', 22), 
(5, 3600, '2018-12-18', 23), 
(2, 5000, '2018-12-21', 24),  
(4, 5000, '2018-12-22', 25), 
(19, 2800, '2018-12-21', 26), 
(12, 5000, '2018-12-21', 27), 
(20, 5000, '2018-12-22', 28), 
(16, 5000, '2018-12-22', 29), 
(21, 3000, '2018-12-23', 30),  

(22, 4000, '2019-01-03', 31), 
(23, 6000, '2019-01-03', 32), 
(14, 3600, '2019-01-04', 33), 
(24, 5000, '2019-01-04', 34),
(25, 3000, '2019-01-07', 35), 
(26, 3000, '2019-01-05', 36),
(18, 6500, '2019-01-29', 37), 
(27, 2800, '2019-02-12', 38),
(8, 5000, '2019-02-23', 39), 
(28, 5000, '2019-03-14', 40),

(29, 6200, '2019-03-13', 41), 
(12, 5000, '2019-04-23', 42), 
(30, 2800, '2019-04-22', 43),
(31, 6200, '2019-05-08', 44), 
(4, 5000, '2019-05-13', 45), 
(32, 6200, '2019-05-25', 46), 
(18, 7500, '2019-06-09', 47), 
(33, 7500, '2019-06-14', 48),
(16, 5500, '2019-06-25', 49), 
(34, 6500, '2019-06-29', 50), 

(35, 7500, '2019-07-17', 51),
(15, 3900, '2019-07-20', 52), 
(12, 6200, '2019-07-24', 53), 
(9, 5500, '2019-07-08', 54), 
(8, 5000, '2019-08-13', 55), 
(16, 5500, '2019-08-25', 56), 
(36, 1600, '2019-08-09', 57),
(4, 5000, '2019-09-17', 58), 
(37, 3200, '2019-09-23', 59),
(23, 7500, '2019-09-29', 60), 

(8, 6200, '2019-09-13', 61), 
(38, 1600, '2019-09-20', 62),
(39, 7500, '2019-10-24', 63),  
(18, 5500, '2019-10-08', 64), 
(32, 6500, '2019-10-13', 65), 
(29, 5000, '2019-10-25', 66), 
(40, 6200, '2019-11-09', 67),
(21, 4000, '2019-11-16', 68), 
(41, 5000, '2019-11-23', 69), 
(42, 3900, '2019-12-8', 70), 

(5, 5000, '2019-12-15', 71), 
(43, 6200, '2019-12-19', 72), 
(4, 7000, '2019-12-20', 73), 
(39, 3200, '2019-12-20', 74), 
(44, 3800, '2019-12-22', 75), 
(45, 7500, '2019-12-22', 76),
(46, 5000, '2019-12-23', 77),
(21, 7500, '2019-12-23', 78), 
(41, 4000, '2019-12-24', 79), 
(47, 3600, '2019-12-29', 80),

(14, 6200, '2020-01-02', 81), 
(43, 3200, '2020-01-03', 82), 
(25, 5500, '2020-01-04', 83), 
(48, 5000, '2020-01-05', 84), 
(49, 6200, '2020-01-06', 85),
(4, 5000, '2020-02-07', 86), 
(44, 3800, '2020-02-11', 87), 
(5, 4500, '2020-02-13', 88), 
(50, 2400, '2020-02-26', 89),
(48, 6200, '2020-03-08', 90), 

(1, 3000, '2020-05-30', 91), 
(11, 3100, '2020-06-17', 92), 
(3, 2800, '2020-07-25', 93), 
(14, 5000, '2020-07-29', 94), 
(51, 3200, '2020-08-18', 95),
(34, 6300, '2020-09-22', 96), 
(23, 6300, '2020-09-11', 97), 
(31, 5500, '2020-10-13', 98), 
(29, 6200, '2020-10-28', 99), 
(22, 4000, '2020-11-04', 100) 
;

# Punto 3: A continuación se introducen las potenciales situaciones problemáticas traducidas en consultas.

#1) Se quiere visualizar cuáles son los equipos cuya camiseta ofrece el emprendimiento y su respectivo modelo (año).
SELECT equipo, modelo 
FROM tucasaca.camisetas
ORDER BY equipo;

#2) Se quiere visualizar cuáles son los equipos INGLESES cuya camiseta ofrece el emprendimiento y su respectivo modelo.
SELECT equipo, modelo FROM tucasaca.camisetas
WHERE pais='Inglaterra'
ORDER BY equipo;

#3.1) Se quiere analizar de qué origen son las camisetas que se ofrecen en el catálogo.
SELECT pais, COUNT(*) as cantidad 
FROM tucasaca.camisetas 
GROUP BY pais
ORDER BY cantidad DESC;

#3.2) Se necesita averiguar cuánto dinero ha ingresado al emprendimiento en el año 2019.
SELECT SUM(monto) as monto_total 
FROM tucasaca.pagos
WHERE fecha_pago between '2019-01-01' and '2019-12-31';

#3.3) Se quiere averiguar el rango de variabilidad del monto de las ventas desde el inicio del emprendimiento.
SELECT MAX(monto) - MIN(monto) as rango_variabilidad 
FROM tucasaca.pagos;

#3.4) Se quiere saber cuál es el precio promedio de las ventas realizadas.
SELECT AVG(monto) as monto_promedio 
FROM tucasaca.pagos;

#3.5) Para saber cuáles son las camisetas cuya promoción debería priorizarse quiere plasmarse en una tabla cuáles de 
# ellas generan una ganancia superior a los $2000.
SELECT camiseta_id, equipo, modelo, ganancia 
FROM tucasaca.camisetas
WHERE ganancia>2000
ORDER BY ganancia DESC;

#3.6) Como estrategia comercial se quiere ofrecer una promoción especial a los clientes que más han gastado (+$12.000),
# por lo tanto se precisa plasmar en una tabla sus nombres y sus direcciones de contacto.

SELECT cl.cliente_id, cl.nombre, cl.apellido, cl.mail,
sum(p.monto) as gasto_total
FROM tucasaca.pagos as p
LEFT JOIN tucasaca.clientes as cl
ON(cl.cliente_id=p.cliente_id)
GROUP BY cl.cliente_id
HAVING gasto_total>12000
ORDER BY gasto_total DESC ;

#4: Subconsulta: Se quiere averiguar a qué provincias se han realizado ventas.

SELECT provincia_nombre 
FROM tucasaca.provincias 
WHERE provincia_id in (SELECT provincia_id FROM tucasaca.clientes);

#5. Se quieren segmentar las camisetas del catálogo en tres categorías según la ganancia que produce la venta de cada una de ellas.

SELECT equipo, modelo, 
CASE
WHEN ganancia<1000 then 'baja'
WHEN ganancia between 1000 and 1600 then 'media'
WHEN ganancia >1600 then 'alta'
END AS ganancia
FROM tucasaca.camisetas
ORDER BY equipo;

#6.a: Van a lanzarse las nuevas camisetas de Independiente y Racing, por lo cual quiere enviarse un mail a todos los 
#clientes que hayan comprado indumentaria de dichos equipos con el fin de promocionar la pre-venta.
#Para esto es preciso una tabla que muestre los nombres de los clientes y su contacto (se hace un JOIN sobre las tablas
# clientes, pedidos y camisetas).

SELECT DISTINCT cl.cliente_id, cl.nombre, cl.apellido, cl.mail, ca.equipo
FROM tucasaca.clientes as cl
LEFT JOIN tucasaca.pedidos as p
ON(cl.cliente_id=p.cliente_id)
LEFT JOIN tucasaca.camisetas as ca
ON(p.camiseta_id=ca.camiseta_id)
WHERE ca.equipo LIKE 'Racing' OR ca.equipo LIKE 'Independiente'
ORDER BY cl.cliente_id;

#6.b. A la hora de repartir los dividendos entre los integrantes del emprendimiento se tiene en cuenta cuánto 
# ha vendido cada uno de ellos. Para esto se plasma en una tabla la ganancia total de las ventas hechas por cada uno.
#(Join de tablas: pedidos, vendedores y camisetas)

SELECT v.vendedor_id, v.nombre, v.apellido, 
sum(c.ganancia) as ganancia_generada
FROM tucasaca.pedidos as p
LEFT JOIN tucasaca.camisetas as c
ON(c.camiseta_id=p.camiseta_id)
LEFT JOIN tucasaca.vendedores as v
ON(p.vendedor_id=v.vendedor_id)
GROUP BY v.vendedor_id
ORDER BY ganancia_generada DESC ;

#6.c. Se quiere visualizar en una misma tabla los datos más relevantes sobre cada pedido (Multiples Joins)

SELECT p.pedido_id, 
c.equipo as camiseta,
t.talle_nombre as talle,
cl.nombre as nombre_comprador, 
cl.apellido as apellido_comprador, 
pr.provincia_nombre as provincia,
v.nombre as nombre_vendedor,
v.apellido as apellido_vendedor,
pa.monto as precio_pago,
pa.fecha_pago
FROM tucasaca.pedidos as p
LEFT JOIN tucasaca.camisetas as c
ON(p.camiseta_id=c.camiseta_id)
LEFT JOIN tucasaca.clientes as cl
ON(p.cliente_id=cl.cliente_id)
LEFT JOIN tucasaca.provincias as pr
ON(cl.provincia_id=pr.provincia_id)
LEFT JOIN tucasaca.talles as t
ON(p.talle_id=t.talle_id)
LEFT JOIN tucasaca.vendedores as v
ON(p.vendedor_id=v.vendedor_id)
LEFT JOIN tucasaca.pagos as pa
ON(p.pedido_id = pa.pedido_id);