/*
NIVEL 1
- Ejercicio 1 
Tu tarea es diseñar y crear una tabla llamada "credit_card" que almacene detalles 
cruciales sobre las tarjetas de crédito. La nueva tabla debe ser capaz de 
identificar de forma única cada tarjeta y establecer una relación adecuada 
con las otras dos tablas ("transaction" y "company"). Después de crear la 
tabla será necesario que ingreses la información del documento denominado 
"datos_introducir_credit". Recuerda mostrar el diagrama y realizar una breve descripción del mismo.
*/

CREATE TABLE IF NOT EXISTS credit_card (
    id VARCHAR(100) PRIMARY KEY,
    iban VARCHAR(50) NOT NULL,
    pan VARCHAR(100),
    pin INT,
    cvv SMALLINT,
    expiring_date VARCHAR(10)
    );
 
 
ALTER TABLE transaction
ADD CONSTRAINT fk_credit_card_id
FOREIGN KEY (credit_card_id)
REFERENCES credit_card(id);


/*
- Ejercicio 2 

El departamento de Recursos Humanos ha identificado un error en el 
número de cuenta del usuario con ID CcU-2938. La información 
que debe mostrarse para este registro es: R323456312213576817699999. 
Recuerda mostrar que el cambio se realizó.
*/

SELECT * FROM CREDIT_CARD
WHERE ID = 'CcU-2938';

UPDATE CREDIT_CARD #actualizar 'tabla'
SET iban = 'R323456312213576817699999'
WHERE ID = 'CcU-2938';

SELECT * FROM CREDIT_CARD
WHERE ID = 'CcU-2938';

/*
- Ejercicio 3 
En la tabla "transaction" ingresa un nuevo usuario con la siguiente información: 
Id 108B1D1D-5B23-A76C-55EF-C568E49A99DD 
credit_card_id CcU-9999 
company_id b-9999 
user_id 9999 
late 829.999 
longitud -117.999 
amount 111.11 
declined 0 
*/

INSERT INTO CREDIT_CARD VALUE ('CcU-9999', 'x', 'x', '0', '0', 'x');

INSERT INTO COMPANY VALUE ('b-9999', 'x', 'x', 'x', 'x', 'x');

INSERT INTO USER VALUE ('9999', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x');  

INSERT INTO TRANSACTION(id, credit_card_id, company_id, user_id, lat, longitude, timestamp, amount, declined)
VALUE ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', '9999', 82.999, -117.999, '2024-07-22 14:30:00', 111.11, 0);
SELECT * FROM TRANSACTION
WHERE CREDIT_CARD_ID = 'CcU-9999';


/*
- Ejercicio 4 
Desde recursos humanos te solicitan eliminar la columna "pan" de la tabla credit_card. Recuerda mostrar el cambio realizado.
*/
SELECT * FROM CREDIT_CARD;
ALTER TABLE CREDIT_CARD DROP COLUMN pan;

/*
Ejercicio 1 

Elimina de la tabla transacción el registro con ID 02C6201E-D90A-1859-B4EE-88D2986D3B02 de la base de datos. 
*/

DELETE FROM TRANSACTION
WHERE ID = '02C6201E-D90A-1859-B4EE-88D2986D3B02';
SELECT * FROM TRANSACTION
WHERE ID = '02C6201E-D90A-1859-B4EE-88D2986D3B02';

CREATE VIEW transaction_view AS
SELECT * FROM TRANSACTION
WHERE CREDIT_CARD_ID = 'ccu-2966';

/*
Ejercicio 2 
La sección de marketing desea tener acceso a información específica para realizar análisis y estrategias efectivas. 
Se ha solicitado crear una vista que proporcione detalles clave sobre las compañías y sus transacciones. 
Será necesaria que crees una vista llamada VistaMarketing que contenga la siguiente información: Nombre de la compañía. 
Teléfono de contacto. País de residencia. Media de compra realizado por cada compañía. Presenta la vista creada, 
ordenando los datos de mayor a menor promedio de compra.
*/

drop view vistamarketing;
CREATE VIEW VistaMarketing AS
SELECT COMPANY_NAME as Nombre_de_la_compañia, PHONE as Telefono_de_contacto, COUNTRY as Pais_de_residencia, avg(amount) as Media_de_compra
FROM COMPANY
JOIN TRANSACTION
on company.id = transaction.company_id
GROUP BY Nombre_de_la_compañia, Telefono_de_contacto,Pais_de_residencia;

SELECT * 
FROM VistaMarketing
ORDER BY Media_de_compra DESC;


/*
Ejercicio 3
Filtra la vista VistaMarketing para mostrar sólo las compañías que tienen su país de residencia en "Germany"
*/
SELECT * FROM VistaMarketing
WHERE Pais_de_residencia = 'germany';


