/*Trigger que no permita hacer reservación para un cliente si anteriormente a reservado algún tipo de tumba  y no confirmo la reserva, dándole una calificación menor o igual a 4 en mas de 3 reservaciones anteriores.
*/
/*Trigger*/
create or replace function tg_reserva() returns trigger
as
$tg_reserva$
    declare
	malas_calificaciones int;
begin
		SELECT count(*) into malas_calificaciones FROM reserva_tumba
		where reserva_tumba.cli_id = NEW.cli_id and reserva_tumba.cli_calificaccion <= 4;

        if(malas_calificaciones>=3) then
		raise exception 'No se puede realizar una reserva para el cliente porque posee una calificacion de 3 o menor';
		end if;
        return new;
end;
$tg_reserva$
language plpgsql;

create trigger tg_reserva before insert OR UPDATE
on reserva_tumba for each row
execute procedure tg_reserva();