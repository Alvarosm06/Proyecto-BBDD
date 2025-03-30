use mydb;
-- fu
delimiter &&
drop function if exists sueldo_medio_departamento &&
create function sueldo_medio_departamento(coddep int)
returns varchar(100) deterministic
begin
    -- variables
    declare sueldomediodepartamento varchar(50) default 0;
    declare sueldomedioempresa varchar(50) default 0;
    declare resultado varchar(100);

    -- sueldo medio por departamento
    select avg(e.salario) into sueldomediodepartamento
    from empleado e
    where e.departamento_iddepartamento = coddep;

    -- obtener el sueldo medio de toda la empresa
    select avg(salario) into sueldomedioempresa
    from empleado;

    -- comparar sueldos y generar mensaje
    if sueldomediodepartamento > sueldomedioempresa then 
        set resultado = concat(sueldomediodepartamento, ' € sueldo superior a la media');
    else 
        set resultado = concat(sueldomediodepartamento, ' € sueldo inferior a la media');
    end if;

    -- retornar resultado
    return resultado;
end &&
delimiter ;

select sueldo_medio_departamento(200);
select sueldo_medio_departamento(3);

-- obtener tareas en estado 'lista' por un usuario indicado

delimiter &&
drop function if exists obtener_tareas_completadas &&
create function obtener_tareas_completadas(idempleado int)
returns varchar(50) deterministic 
begin
    declare numtareas int default 0;
    declare resultado varchar(50) default null;

    -- contar tareas completadas del empleado
    select count(*) into numtareas
    from tareas t
    inner join tareas_has_empleado the 
    on t.idtarea = the.idtarea
    where the.empleado_idempleado = idempleado 
    and t.estado_pedido = 'lista';

    -- comparar sueldos y generar mensaje
    if numtareas = 0 then 
        set resultado = concat('no tiene tareas completadas');
    else
        set resultado = concat('tiene ', numtareas, ' tarea completada');
    end if;

    return resultado;
end &&

delimiter ;

select obtener_tareas_completadas(1);
select obtener_tareas_completadas(4);
