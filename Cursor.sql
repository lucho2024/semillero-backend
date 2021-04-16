DECLARE @myTableVariable TABLE (nombre varchar(400), descripcion varchar(100))

insert into @myTableVariable values('Roberto', 'UNO'),('Gail', 'DOS'),('Dylan','TRES')

DECLARE @Nombre AS nvarchar(400)
DECLARE @Description AS nvarchar(100)
DECLARE ProdInfo CURSOR FOR SELECT nombre, descripcion FROM @myTableVariable

OPEN ProdInfo

FETCH NEXT FROM ProdInfo INTO  @Nombre, @Description

WHILE @@fetch_status = 0

BEGIN

    PRINT 'Nombre: ' + @Nombre
    PRINT 'Descipcion: ' + @Description

    FETCH NEXT FROM ProdInfo INTO @Nombre, @Description

END

CLOSE ProdInfo

DEALLOCATE ProdInfo
