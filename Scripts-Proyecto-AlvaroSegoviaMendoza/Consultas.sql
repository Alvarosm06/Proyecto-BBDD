use mydb;

-- en esta consulta vemos los jefes que son sus propios jefes, es decir, los jefes
-- superiores.

select nombre as jefe_superior, idempleado
from empleado e 
where e.jefe_idempleado is null;

-- esta consulta cuenta los empleados de cada departamento y hace el
-- promedio del sueldo de cada departamento agrupado

select departamento_iddepartamento , d.nombre , avg(salario) as salario_promedio, count(e.nombre) as num_empleados 
from empleado e inner join departamento d 
on e.departamento_iddepartamento = d.iddepartamento
group by departamento_iddepartamento
order by 1 asc;

-- numero de empleados, tareas, horas totales por cada proyecto, presupuesto

use mydb;

select idproyecto, p.tema , count(*) as num_empleados, sum(the.num_horas_reales) as horas_totales, p.presupuesto
from proyecto p 
inner join empleado_has_proyecto ehp 
on p.idproyecto = ehp.proyecto_idproyecto
inner join empleado e 
on ehp.empleado_idempleado = e.idempleado
inner join tareas_has_empleado the 
on e.idempleado = the.empleado_idempleado
group by 1
order by 3 desc;

-- proyectos que han durado más que la media

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
order by 3;

-- demostracion (no borrar)

select avg(the.num_horas_reales) as horas_totales_media
	from proyecto p
	inner join empleado_has_proyecto ehp 
	on p.idproyecto = ehp.proyecto_idproyecto
	inner join empleado e 
	on ehp.empleado_idempleado = e.idempleado
	inner join tareas_has_empleado the 
	on e.idempleado = the.empleado_idempleado;

-- ids empleados y nombre, id tarea, estado de tarea sea por hacer (to do) este mismo año 2025

select e.idempleado ,e.nombre , the.idTarea, t.estado_pedido, t.fecha
from empleado e inner join tareas_has_empleado the 
on e.idempleado = the.empleado_idempleado
inner join tareas t
on the.idTarea = t.idTarea
where t.estado_pedido like 'to do' and t.fecha > '2025-01-01';

