--===============================
--Proyecto: Retail Sales Analyst 
--Base de Datos: SQLite
--Autora: Jennifer Merida
--===============================


--1. Facturación total
SELECT SUM(precio_actual) 
from boutique;

----------------------------------------------

--2. Ticket promedio
SELECT AVG(precio_actual) 
from boutique

----------------------------------------------

--3. Ingreso total generado por los descuentos 		  
SELECT sum(precio_actual) AS ingresos_C/descuento
from boutique		
where porcentaje_descuento is not 0.0 ;

----------------------------------------------

--4. Ingreso total generado sin los descuentos 		  
SELECT sum(precio_actual) AS ingresos_s/descuento
from boutique		
where porcentaje_descuento is 0.0;

----------------------------------------------

--5. Motivos de devoluciones
SELECT motivo_devolucion 
from boutique
where motivo_devolucion is not null
group by motivo_devolucion;

----------------------------------------------

--6. Cantidad de prendas por talla
SELECT talla, count(*) AS cantidad
FROM boutique
group by talla;
---------------------------------------------

--7. Cantidad de devoluciones
SELECT motivo_devolucion, count(*) AS cantidad
from boutique
where motivo_devolucion is not null
group by motivo_devolucion 
order by cantidad DESC;

----------------------------------------------

--8. Cantidad vendida por categoría
SELECT categoria, count(*) AS cantidad
from boutique
group by categoria;

----------------------------------------------

--9. Categoría más vendida por marca
SELECT marca, categoria, cantidad
from (SELECT marca, categoria, count(*) AS cantidad,
             row_number() OVER (
   	         PARTITION BY marca
	      	 order by count(*) DESC
			 ) AS cp
	   from boutique
	   group by marca
	   )
where cp = 1;

----------------------------------------------

--10. valor porcentual de cada marca por sobre el total
SELECT marca, round(SUM(precio_actual)*100/(SELECT SUM(precio_actual) from boutique), 2) AS porcentaje 
from boutique
group by marca
order by porcentaje DESC;

----------------------------------------------

--11. Temporada más vendida por marca
SELECT marca, temporada
from (SELECT marca, temporada, count(*) AS cantidad,
             row_number() OVER (
			 PARTITION BY marca
			 order by count(*) DESC
			 ) AS cp
	    from boutique
	    group by marca
	    )
where cp = 1;

----------------------------------------------

--12. Cantidad vendida sin descuento
SELECT count(porcentaje_descuento) AS cantidad
from boutique
where porcentaje_descuento is 0.0;

----------------------------------------------

--13. Evolución anual y mensual de la facturación
SELECT strftime('%Y-%m', fecha_compra) AS mes,
       SUM(precio_actual) AS ingresos
from boutique
group by mes
order by mes;



