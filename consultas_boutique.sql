--===============================
--Proyecto: Retail Sales Analyst 
--Base de Datos: SQLite
--Autora: Jennifer Merida
--===============================

--1. Facturación total
--select SUM(precio_actual) 
--from boutique

----------------------------------------------

--2. Ingreso total generado por los descuentos 		  
--SELECT sum(precio_actual) AS ingresos_descuento
--from boutique		
--where porcentaje_descuento is not 0.0 

----------------------------------------------

--3. Ingreso total generado sin los descuentos 		  
--SELECT sum(precio_actual) AS ingresos_sin_descuento
--from boutique		
--where porcentaje_descuento is 0.0 

----------------------------------------------

--4. Motivos de devoluciones
--select motivo_devolucion 
--from boutique
--where motivo_devolucion is not null
--group by motivo_devolucion

----------------------------------------------

--5. Cantidad de prendas por talla
--SELECT talla, count(*) AS cantidad
--FROM boutique
--group by talla

----------------------------------------------

--6. Cantidad de devoluciones
--SELECT motivo_devolucion, count(*) AS cantidad
--from boutique
--where motivo_devolucion is not null
--group by motivo_devolucion 
--order by cantidad DESC

----------------------------------------------

--7. Cantidad vendida por categoría
--SELECT categoria, count(*) AS cantidad
--from boutique
--group by categoria

----------------------------------------------

--8. Categoría más vendida por marca
--SELECT marca, categoria, cantidad
--from (SELECT marca, categoria, count(*) AS cantidad,
--             row_number() OVER (
--	         PARTITION BY marca
--			 order by count(*) DESC
--			 ) AS cp
--	  from boutique
--	  group by marca
--	  )
--where cp = 1

----------------------------------------------

--9. alor porcentual de cada marca por sobre el total
--SELECT marca, round(SUM(precio_actual)*100/(SELECT SUM(precio_actual) from boutique), 2) AS porcentaje 
--from boutique
--group by marca
--order by porcentaje DESC

----------------------------------------------

--10. Temporada más vendida por marca
--SELECT marca, temporada
--from (SELECT marca, temporada, count(*) AS cantidad,
--             row_number() OVER (
--			 PARTITION BY marca
--			 order by count(*) DESC
--			 ) AS cp
--	  from boutique
--	  group by marca
--	  )
--where cp = 1		     

----------------------------------------------

--11. Cantidad vendida sin descuento
--select count(porcentaje_descuento) AS cantidad
--from boutique
--where porcentaje_descuento is 0.0		

----------------------------------------------

--12. Evolución anual y mensual de la facturación
--SELECT strftime('%Y-%m', fecha_compra) AS mes,
--       SUM(precio_actual) AS ingresos
--from boutique
--group by mes
--order by mes
