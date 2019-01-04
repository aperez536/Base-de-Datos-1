select * from cabaña;
select * from galpon;
select * from plantel;
select * from galponero;
select * from genetica;
select * from granja;
select * from cliente;
select * from producto;
select * from venta;

/*CONSULTA CANTIDAD GALLINAS MUERTAS  1*/

select sum(cantidadGaMuerta) as CANTIDADGALLINASMUERTAS, fecha_Entrada, cuil, idplantel from galponero
inner join galpon on galponero.cuil = galpon.galponero_cuil
inner join plantel on galpon.idgalpon = plantel.galpon_idgalpon
where fecha_Entrada between CAST('1990-02-01' AS DATE) AND CAST('1995-02-28' AS DATE)
group by fecha_Entrada;




/*CONSULTA POR CLIENTE O PRODUCTO 2 y 3*/

select granja_idGranja, fecha, cliente_cuit, nombre, idproducto 
	from venta inner join cliente on venta.cliente_cuit = cliente.cuit;
    
select granja_idGranja, cliente_cuit, idproducto, nombre, precio_venta 
	from venta inner join producto on venta.idproducto = producto.id_producto;
    

/*CONSULTA POR LOCALIDAD 4. Listado de ventas filtrado por localidad. 4 */

select fecha, granja_idGranja, cliente_cuit from venta
	inner join granja on venta.granja_idGranja = granja.idGranja
    inner join cabaña on granja.cabaña_cuit = cabaña.cuit
   


/*CONSULTA DE ALIMENTOS POR GALPON 5
Listado de entregas de alimento entre fechas, filtrado por galpón
*/

select fecha_Entrada, tipo_alimento, cuil from galpon 
	inner join galponero on galponero.cuil = galpon.galponero_cuil
    inner join plantel on  galpon.idgalpon = plantel.galpon_idgalpon
    where fecha_Entrada between CAST('1990-02-01' AS DATE) AND CAST('1995-02-28' AS DATE)
	order BY plantel.fecha_Entrada ;      
    
/*CONSULTA DE ALIMENTOS POR PLANTEL  6
istado de entregas de alimento entre fechas, filtrado por plantel
*/

select tipo_alimento, cuil, fecha_entrada from plantel
	inner join galpon on plantel.galpon_idgalpon = galpon.idgalpon
    inner join galponero on galpon.galponero_cuil = galponero.cuil
    where fecha_Entrada between CAST('1990-02-01' AS DATE) AND CAST('1995-02-28' AS DATE)
    order by plantel.fecha_Entrada ; 
    	
    


/*CONSULTA DE PLANTELES POR CABAÑA Y GENETICA   7 */
select idplantel, edad, genetica_gallina, fecha_Entrada, precioCompra from plantel 
	inner join genetica on plantel.genetica_gallina = genetica.idgenetica
	inner join cabaña on genetica.cabaña_cuit = cabaña.cuit;
    

create index gallinasmuertas on galponero (cantidadhuevosObtenidos,cantidadGaMuerta,cantidad,tipo_alimento,cuil);

create index clientes on venta (granja_idGranja,fecha,cliente_cuit,idproducto);

create index localidad on venta  (granja_idGranja,fecha,cliente_cuit,idproducto);

