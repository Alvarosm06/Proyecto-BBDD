use mydb;

-- obtener tareas de un empleado

delimiter &&
drop procedure if exists empleado_gettareasporid &&
create procedure empleado_tareasporid(in p_idempleado int)
begin
    select t.idtarea, t.descripción, t.estado_pedido
    from tareas t
    join tareas_has_empleado the on t.idtarea = the.idtarea
    where the.empleado_idempleado = p_idempleado;
end &&
delimiter ;

call empleado_tareasporid(312);

-- obtener proyectos empezados en un año

delimiter &&
drop procedure if exists proyectosporfecha &&
create procedure proyectosporfecha(in p_fecha int)
begin
    select p.idproyecto, tema, fecha_inicio
    from proyecto p
    where year(fecha_inicio) = p_fecha;
end &&
delimiter ;

call proyectosporfecha(2022);

-- obtener nº de tareas completadas ('lista') por un id de un empleado

delimiter &&
drop procedure if exists contar_tareas_completadas &&
create procedure contar_tareas_completadas(in idempleado int, out numtareas int)
begin
    select count(*) into numtareas
    from tareas t
    inner join tareas_has_empleado the 
    on t.idtarea = the.idtarea
    where the.empleado_idempleado = idempleado 
    and t.estado_pedido = 'lista';
end &&

delimiter ;

call contar_tareas_completadas(12, @resultado);

select @resultado as tareascompletadas;
