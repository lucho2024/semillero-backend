
declare @w_id_menu int,
		@w_id_producto int,
		@w_id_url varchar(300),
		@w_id_rol int
		
select @w_id_url = 'views/FCTRC/FCTRS/T_FCTRCUOUXFYYT_455/1.0.0/VC_PRODUCTOSS_351455_TASK.html'
		
if exists (select 1 from cew_menu where me_url = @w_id_url)
begin
	print 'borrando.....' 
	
	select @w_id_menu = me_id from cew_menu where me_url = @w_id_url
	
	select @w_id_rol = ro_rol from ad_rol where ro_descripcion = 'SEMILLERO'

	if exists (select 1 from cew_menu_role where mro_id_menu = @w_id_menu and mro_id_role = @w_id_rol)
	begin
		print 'borrando.....' 
		delete from cew_menu_role where mro_id_menu = @w_id_menu
	end
	
	delete from cew_menu where me_url = @w_id_url
end

select @w_id_menu = max(me_id) from cew_menu

select @w_id_menu = @w_id_menu + 1

select @w_id_producto = pd_producto from cl_producto where pd_descripcion = 'CLIENTES'

print 'id_menu: ' + convert(varchar(10), @w_id_menu)

print 'id_producto: ' + convert(varchar(10), @w_id_producto)

insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
values (@w_id_menu, 6909, 'MNU_PGG_GridProd', 1, @w_id_url, 1, @w_id_producto, 0, 'PGG Grid de Producto', NULL, 'CWC')

/**********ROL**********/

select @w_id_rol = ro_rol from ad_rol where ro_descripcion = 'SEMILLERO'

insert into cew_menu_role (mro_id_menu, mro_id_role) values (@w_id_menu, @w_id_rol)

select * from cew_menu where me_name = 'MNU_PGG_GridProd'
go

