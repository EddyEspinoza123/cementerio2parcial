/*Un procedimiento almacenado que reciba como parámetro la cedula de un empleado y que devuelva las ganancias generadas por la suma total de todas sus facturas por el tipo de tumba.
*/
 /*PROCEDIMIENTO ALMACENADO*/
create or replace function obtener_ventas_totales( cedula_empleado integer)
RETURNS TABLE (empleado_nombre varchar,
	empleado_apellido varchar,
	tipo_tumba varchar,	
	ingresos_generados numeric)
as $BODY$
begin
	RETURN QUERY
	SELECT EMPLEADO.EM_NOMBRE, EMPLEADO.EM_APELLIDO, TUMBA.ID_DESCRICCION_TUMBA, 
	SUM(FACTURA.FAC_TOTAL)TOTAL_VENTAS FROM EMPLEADO
	INNER JOIN FACTURA ON FACTURA.EM_ID = EMPLEADO.EM_ID
	INNER JOIN DETALLE_FACTURA ON DETALLE_FACTURA.FACTURA_ID = FACTURA.FACTURA_ID
	INNER JOIN RESERVA_TUMBA ON RESERVA_TUMBA.TT_ID = DETALLE_FACTURA.TT_ID
	INNER JOIN TUMBA ON TUMBA.ID_TUMBA = RESERVA_TUMBA.ID_TUMBA
	WHERE EMPLEADO.EM_CEDULA = cedula_empleado
	GROUP BY(EMPLEADO.EM_NOMBRE, EMPLEADO.EM_APELLIDO, TUMBA.ID_DESCRICCION_TUMBA);
end
$BODY$ language plpgsql;