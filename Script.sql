
DECLARE @myTableVariable TABLE (nombre varchar(100), description varchar(100), ruta varchar(400))

insert into @myTableVariable values
('MNU_JCAM_GIT', 	'FormularioEstudianteJCAM', 	'views/PRYCT/PRYCT/T_PRYCTYDNQOYSI_867/1.0.0/VC_ESTUDIANJT_299867_TASK.html'),
('MNU_CSSS_GIT', 	'FormularioEstudianteCSSS', 	'views/PRYCT/PRYCT/T_PRYCTOFDGOIJL_246/1.0.0/VC_ESTUDIANSE_830246_TASK.html'),
('MNU_LHMM_GIT',	'FormularioEstudianteLHMM',		'views/PRYCT/PRYCT/T_PRYCTARZNMLLP_381/1.0.0/VC_ESTUDIANTM_573381_TASK.html'),
('nombre', 			'descripcion', 					'ruta')

DECLARE @w_nombre AS nvarchar(100)
DECLARE @w_description AS nvarchar(100)
DECLARE @w_ruta AS nvarchar(400)

DECLARE ProdInfo CURSOR FOR SELECT nombre, description, ruta FROM @myTableVariable

OPEN ProdInfo

	FETCH NEXT FROM ProdInfo INTO @w_nombre, @w_description, @w_ruta

	WHILE @@fetch_status = 0

	BEGIN

	    PRINT 'Nombre: ' + @w_nombre
    	PRINT 'Descipcion: ' + @w_description
		PRINT 'Vista' + @w_vista


		DECLARE @w_id_menu int,
				@w_id_producto int,
				@w_id_url varchar(300),
				@w_id_rol int
			
	
		
		IF EXISTS (select 1 from cew_menu where me_url = @w_ruta)
			BEGIN
				PRINT 'borrando.....' 
			
				select @w_id_menu = me_id from cew_menu where me_url = @w_ruta
			
				select @w_id_rol = ro_rol from ad_rol where ro_descripcion = 'CAPACITACION'
		
				IF EXISTS  (select 1 from cew_menu_role where mro_id_menu = @w_id_menu and mro_id_role = @w_id_rol)
				BEGIN
					print 'borrando.....' 
					delete from cew_menu_role where mro_id_menu = @w_ruta
				END
			
				delete from cew_menu where me_url = @w_ruta
			
			END
	
	
		select @w_id_menu = max(me_id) from cew_menu
	
		select @w_id_menu = @w_id_menu + 1
	
		select @w_id_producto = pd_producto from cl_producto where pd_descripcion = 'CLIENTES'
	
		PRINT 'id_menu: ' + convert(varchar(10), @w_id_menu)
	
		PRINT 'id_producto: ' + convert(varchar(10), @w_id_producto)
	
		insert into dbo.cew_menu (
			me_id, 					me_id_parent, 		me_name, 					me_visible, 
			me_url, 				me_order, 			me_id_cobis_product, 		me_option, 
			me_description, 		me_version, 		me_container)
		values (
			@w_id_menu, 			7293, 				@w_nombre, 					1, 
			@w_ruta, 				1, 					@w_id_producto, 			0, 
			@w_description, 		NULL, 				'CWC')
	
		/******************************ROL****************************************/
	
		select @w_id_rol = ro_rol from ad_rol where ro_descripcion = 'CAPACITACION'
	
		insert into cew_menu_role (mro_id_menu, mro_id_role) values (@w_id_menu, @w_id_rol)
	
		select * from cew_menu where me_name = @w_nombre
	    
	    FETCH NEXT FROM ProdInfo INTO @w_nombre, @w_description, @w_ruta

	END

CLOSE ProdInfo

DEALLOCATE ProdInfo


