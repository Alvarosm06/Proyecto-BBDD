use mydb;

-- para este trigger, guardaremos los antiguos salarios de los empleados en una nueva
-- tabla historial_salario ademas indicará cuando se ha hecho ese cambio.

create table historial_salario as 
select * from empleado;

alter table historial_salario
add column fecha_modificacion timestamp default current_timestamp;

delete from historial_salario;

delimiter &&
drop trigger if exists guardar_pagos &&
create trigger guardar_pagos
before update on empleado
for each row 
begin 
    insert into historial_salario
    values (
        old.idempleado, 
        old.nombre,
        old.email,
        old.salario,
        old.tipo,
        old.stack,
        old.departamento_iddepartamento,
        old.jefe_idempleado,
        current_timestamp);
end &&
delimiter ;

-- ahora cuando modifico el salario en cualquier empleado en la tabla historial_salario se guardara el salario anterior.

-- este trigger consiste en guardar las promociones realizadas a los empleados, es decir cuando el empleado no tenga asociado la id de otro
-- empleado (su jefe) en la tabla historial_promociones_jefe indicando la fecha en la que es promovido

create table historial_promociones_jefe as 
select * from empleado;

alter table historial_promociones_jefe
add column fecha_promocion timestamp default current_timestamp;

alter table mydb.historial_promociones_jefe change jefe_idempleado anterior_idjefe int null;

delete from historial_promociones_jefe;

delimiter &&
drop trigger if exists registrar_historial_jefe &&
create trigger registrar_historial_jefe
before update on empleado
for each row
begin
    -- verificar si el campo idjefe está cambiando de un valor a null
    if old.jefe_idempleado is not null then
        -- insertar el registro en la tabla historial_jefes
        insert into historial_promociones_jefe
        values (
            old.idempleado,
            old.nombre,
            old.email,
            old.salario,
            old.tipo,
            old.stack,
            old.departamento_iddepartamento,
            old.jefe_idempleado,
            current_timestamp);
    end if;
end &&
delimiter ;

-- por ejemplo borrar jefe_idempleado del empleado con id 2
