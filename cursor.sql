/*Cursor que muestre las ganancias totales generadas por cada una de las tumbas y el tipo de tumba.
*/
/*CURSOR*/
do $$
declare
	tabla Record;
	cur_ganancia_tumba Cursor for SELECT RESERVA_TUMBA.TT_N_TUMBA,
  TUMBA.ID_DESCRIPCION_TUMBA,SUM(FACTURA.FAC_TOTAL) as total  FROM FACTURA
	INNER JOIN DETALLE_FACTURA ON DETALLE_FACTURA.FACTURA_ID = FACTURA.FACTURA_ID
	INNER JOIN RESERVA_TUMBA ON RESERVA_TUMBA.TT_ID = DETALLE_FACTURA.TT_ID
	INNER JOIN TUMBA ON TUMBA.ID_TUMBA = RESERVA_TUMBA.ID_TUMBA
	GROUP BY (RESERVA_TUMBA.TT_N_TUMBA,tumba.id_descripcion_tumba);
	begin
	for tabla in cur_ganancia_tumba loop
	Raise notice 'Nro tumba: %,Tipo: %,Ganancias Generadas: %',tabla.TT_N_TUMBA,tabla.ID_DESCRIPCION_TUMBA,tabla.total;
	end loop;
end $$
language 'plpgsql';