use mydb;

-- 1º View
create view tareas_por_hacer_2025 as
select e.idempleado, e.nombre, the.idTarea, t.estado_pedido
from empleado e inner join tareas_has_empleado the 
on e.idempleado = the.empleado_idempleado
inner join tareas t
on the.idTarea = t.idTarea
where t.estado_pedido like 'to do' and t.fecha > '2025-01-01';

-- 2º View
create view proyectos_más_duraderos as
select p.idproyecto, p.tema, sum(the.num_horas_reales) as duracion_horas
from proyecto p 
inner join empleado_has_proyecto ehp 
on p.idproyecto = ehp.proyecto_idproyecto
inner join empleado e 
on ehp.empleado_idempleado = e.idempleado
inner join tareas_has_empleado the 
on e.idempleado = the.empleado_idempleado 
group by 1
having sum(the.num_horas_reales) > (
	select avg(the.num_horas_reales) as horas_totales
	from proyecto p 
	inner join empleado_has_proyecto ehp 
	on p.idproyecto = ehp.proyecto_idproyecto
	inner join empleado e 
	on ehp.empleado_idempleado = e.idempleado
	inner join tareas_has_empleado the 
	on e.idempleado = the.empleado_idempleado
)
order by 3 desc;
