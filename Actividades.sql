create table tb_a(id number(5), nombre_p varchar(35), tipo varchar(35), costo number(4));
create table tb_b(descripcion varchar2(90), fecha date, hora TIMESTAMP);

insert into tb_a values('001','donitas','pan','20');
insert into tb_a values('002','rebanada','pan','10');
insert into tb_a values('003','mantecadas','pan','25');
insert into tb_a values('004','nito','pan','15');
insert into tb_a values('005','buñuelos','pan','20');
insert into tb_a values('021','doritos','botana','15');
insert into tb_a values('022','paketaxo','botana','56');
insert into tb_a values('023','sabritas adobadas','botana','35');
insert into tb_a values('024','crujitos','botana','15');
insert into tb_a values('025','sabritones','botana','50');
insert into tb_a values('051','pulparindo','dulce','8');
insert into tb_a values('052','picafresa','dulce','2');
insert into tb_a values('053','mazapan','dulce','8');
insert into tb_a values('054','panditas','dulce','18');
insert into tb_a values('055','dragoncito','dulce','3');

--2
create or replace trigger tri_acciones
after update or insert or delete
on tb_a

begin

if inserting then
insert into tb_b (descripcion) values('Se a insertado nuevos datos');
end if;
if updating then
insert into tb_b (descripcion) values('Se a actualizado el dato');
end if;
if deleting then
insert into tb_b (descripcion) values('Se a eliminado datos');
end if;

end tri_acciones;

--acciones nuevas
insert into tb_a values('061','sacapuntas','papeleria','6');
delete from tb_a where id ='003';
update tb_a set costo= '20' where nombre_p='nito';

select * from tb_a; 
select * from tb_b;

--3
create or replace trigger tri_insert_letrad

after insert
on tb_a 
for each row

begin
if :new.nombre_p like 'd%'then
insert into tb_b values ('Se a agregado un producto con la letra d', SYSDATE, SYSTIMESTAMP);
end if;

end tri_insert_letrad;

insert into tb_a values('062','domino','juegos','35'); 

select * from tb_b;
select * from tb_a;
 
--4
create or replace trigger tri_eliminar_p

after delete
on tb_a 
for each row

begin
if :old.costo <=12 then
insert into tb_b  (descripcion) values ('Se a eliminado un producto humilde que queria comprar con lo de mi pasaje :c');
end if;

end tri_eliminar_p;

delete from tb_a where costo <=12;

select * from tb_b;
select * from tb_a;

--eliminar
drop trigger tri_insert_letrad;
drop trigger tri_acciones;
drop trigger tri_eliminar_p;
drop table tb_b;
drop table tb_a;