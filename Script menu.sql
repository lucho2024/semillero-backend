
declare @w_id_menu 		int,
		@w_id_producto 	int,
		@w_id_url		varchar(300),
		@w_id_rol		int


--Asignamos la url del memu--
select @w_id_url = 'views/JCAME/FRMLR/T_JCAMEXJKZLZXZ_265/1.0.0/VC_VIDEO23AMO_406265_TASK.html?mode=2'
-----------------------------


/******************************** ROL ********************************/
--Calculamos el id--
select @w_id_menu = max(me_id) 
	from cew_menu
	
select @w_id_menu = @w_id_menu + 1
---------------------

--Recuperamos el rol del menu--
select @w_id_rol = ro_rol 
	FROM ad_rol
	where ro_descripcion = 'SEMILLERO'
-------------------------------

--Borramos si existe para evitar repetidos--	 
if exists(select 1 from cew_menu_role where mro_id_menu = @w_id_menu and mro_id_role = @w_id_rol)
	begin
		print 'Borrando...'
		delete from cew_menu_role where mro_id_menu = @w_id_menu and mro_id_role = @w_id_rol  
	end
---------------------------------------------
/*********************************************************************/



--Borramos si existe para evitar repetidos y errores--

/*
declare @w_id_url	varchar(300)
select @w_id_url = 'views/JCAME/FRMLR/T_JCAMEPNEVZZXQ_503/1.0.0/VC_CALIFICAIC_734503_TASK.html'
select * from cew_menu where me_url = @w_id_url
*/

if exists(select 1 from cew_menu where me_url = @w_id_url)
	begin
		print 'Borrando...'
		delete from cew_menu where me_url = @w_id_url
	end
------------------------------------------------------



--Recuperamos el id_producto--
select @w_id_producto = pd_producto 
	from cl_producto 
	where pd_descripcion = 'CLIENTES'
-------------------------------

--Imprimimos para ver los valores--
print 'id_menu: ' + convert(varchar(10), @w_id_menu)
print 'id_producto: ' + convert(varchar(10), @w_id_producto)
-----------------------------------

	
--2552 Menu padre del Semillero

--Insertamos--
INSERT INTO dbo.cew_menu (
me_id, 				me_id_parent,			me_name, 				me_visible,
me_url, 			
me_order, 			me_id_cobis_product, 	me_option,				
me_description,				me_version,				me_container)
VALUES (
@w_id_menu, 		2739, 				'MNU_JCAM_GRID', 		1, 
@w_id_url,
1, 					@w_id_producto,		0,

'VC_VIDEO23AMO_406265_TASK.html', 	NULL, 				'CWC')
-------------------

--2739


--Insertamos el rol del menu--
INSERT INTO dbo.cew_menu_role (
	mro_id_menu, 	mro_id_role)
VALUES (
	@w_id_menu,   	@w_id_rol)
------------------------------




--select * from cew_menu WHERE me_url = 'views/JCAME/FRMLR/T_JCAMEPNEVZZXQ_503/1.0.0/VC_NOTASUSIAJ_529672_TASK.html'
--select * from cew_menu_role

/*
INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (2552, NULL, 'MNU_SMCMC', 1, NULL, 1, 172, 0, 'Semillero', NULL, 'CWC')
GO
*/