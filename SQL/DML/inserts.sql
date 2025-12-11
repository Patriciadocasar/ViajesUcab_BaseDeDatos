

INSERT INTO Estatus (Est_Descripcion)
VALUES ('Pendiente');

INSERT INTO Estatus (Est_Descripcion)
VALUES ('Listo');

INSERT INTO Estatus (Est_Descripcion)
VALUES ('Pendiente');

INSERT INTO Estatus (Est_Descripcion)
VALUES ('Listo');

INSERT INTO Estatus (Est_Descripcion)
VALUES ('Pendiente');

INSERT INTO Estatus (Est_Descripcion)
VALUES ('Listo');

INSERT INTO Estatus (Est_Descripcion)
VALUES ('Pendiente');

INSERT INTO Estatus (Est_Descripcion)
VALUES ('Listo');

INSERT INTO Estatus (Est_Descripcion)
VALUES ('Pendiente');

INSERT INTO Estatus (Est_Descripcion)
VALUES ('Listo');


INSERT INTO Privilegio (Pri_tipo, Pri_Tabla, Pri_Operacion)
VALUES ('Lectura','Cliente','SELECT');

INSERT INTO Privilegio (Pri_tipo, Pri_Tabla, Pri_Operacion)
VALUES ('Escritura','Cliente','INSERT');

INSERT INTO Privilegio (Pri_tipo, Pri_Tabla, Pri_Operacion)
VALUES ('Actualización','Cliente','UPDATE');

INSERT INTO Privilegio (Pri_tipo, Pri_Tabla, Pri_Operacion)
VALUES ('Eliminación','Cliente','DELETE');

INSERT INTO Privilegio (Pri_tipo, Pri_Tabla, Pri_Operacion)
VALUES ('Lectura','Reserva','SELECT');

INSERT INTO Privilegio (Pri_tipo, Pri_Tabla, Pri_Operacion)
VALUES ('Escritura','Reserva','INSERT');

INSERT INTO Privilegio (Pri_tipo, Pri_Tabla, Pri_Operacion)
VALUES ('Actualización','Reserva','UPDATE');

INSERT INTO Privilegio (Pri_tipo, Pri_Tabla, Pri_Operacion)
VALUES ('Eliminación','Reserva','DELETE');

INSERT INTO Privilegio (Pri_tipo, Pri_Tabla, Pri_Operacion)
VALUES ('Lectura','Itinerario','SELECT');

INSERT INTO Privilegio (Pri_tipo, Pri_Tabla, Pri_Operacion)
VALUES ('Escritura','Itinerario','INSERT');



INSERT INTO Rol (Rol_tipo)
VALUES ('Administrador');

INSERT INTO Rol (Rol_tipo)
VALUES ('Proveedor');

INSERT INTO Rol (Rol_tipo)
VALUES ('Cliente');

INSERT INTO Rol (Rol_tipo)
VALUES ('Empleado');

INSERT INTO Rol (Rol_tipo)
VALUES ('Gerente');

INSERT INTO Rol (Rol_tipo)
VALUES ('Supervisor');

INSERT INTO Rol (Rol_tipo)
VALUES ('Analista');

INSERT INTO Rol (Rol_tipo)
VALUES ('Auditor');

INSERT INTO Rol (Rol_tipo)
VALUES ('Soporte');

INSERT INTO Rol (Rol_tipo)
VALUES ('Invitado');

INSERT INTO Tipo_Documento (TP_Nombre)
VALUES ('Pasaporte');

INSERT INTO Tipo_Documento (TP_Nombre)
VALUES ('Cédula de Identidad');

INSERT INTO Tipo_Documento (TP_Nombre)
VALUES ('Visa');

INSERT INTO Tipo_Documento (TP_Nombre)
VALUES ('Carnet de Conducir');

INSERT INTO Tipo_Documento (TP_Nombre)
VALUES ('Permiso de Viaje para Menores');

INSERT INTO Tipo_Documento (TP_Nombre)
VALUES ('Certificado de Vacunación');

INSERT INTO Tipo_Documento (TP_Nombre)
VALUES ('Carnet de Estudiante');

INSERT INTO Tipo_Documento (TP_Nombre)
VALUES ('Constancia de Trabajo');

INSERT INTO Tipo_Documento (TP_Nombre)
VALUES ('Documento Nacional de Identidad Extranjero');

INSERT INTO Tipo_Documento (TP_Nombre)
VALUES ('Carnet Diplomático');




INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla) VALUES ('Europa', 'Continente', 500);   -- Lug_COD = 1
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla) VALUES ('America', 'Continente', 450);  -- Lug_COD = 2
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla) VALUES ('Asia', 'Continente', 360);     -- Lug_COD = 3
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla) VALUES ('Africa', 'Continente', 420);   -- Lug_COD = 4
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla) VALUES ('Oceania', 'Continente', 600);  -- Lug_COD = 5


INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Francia', 'Pais', 700, 1);        -- Lug_COD = 6 (Europa)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Brasil', 'Pais', 650, 2);         -- Lug_COD = 7 (America)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Venezuela', 'Pais', 650, 2);      -- Lug_COD = 8 (America)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Japón', 'Pais', 800, 3);          -- Lug_COD = 9 (Asia)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Sudáfrica', 'Pais', 600, 4);      -- Lug_COD = 10 (Africa)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Australia', 'Pais', 900, 5);      -- Lug_COD = 11 (Oceania)


INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Amazonas', 'Region', 400, 8);         -- 12
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Anzoátegui', 'Region', 350, 8);       -- 13
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Apure', 'Region', 300, 8);            -- 14
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Aragua', 'Region', 250, 8);           -- 15
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Barinas', 'Region', 280, 8);          -- 16
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Bolívar', 'Region', 500, 8);          -- 17
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Carabobo', 'Region', 260, 8);         -- 18
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Cojedes', 'Region', 220, 8);          -- 19
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Delta Amacuro', 'Region', 420, 8);    -- 20
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Falcón', 'Region', 370, 8);           -- 21
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Guárico', 'Region', 310, 8);          -- 22
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Lara', 'Region', 330, 8);             -- 23
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Mérida', 'Region', 450, 8);           -- 24
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Miranda', 'Region', 240, 8);          -- 25
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Monagas', 'Region', 320, 8);          -- 26
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Nueva Esparta', 'Region', 460, 8);    -- 27
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Portuguesa', 'Region', 280, 8);       -- 28
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Sucre', 'Region', 340, 8);            -- 29
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Táchira', 'Region', 410, 8);          -- 30
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Trujillo', 'Region', 290, 8);         -- 31
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('La Guaira', 'Region', 270, 8);        -- 32  (Vargas → La Guaira)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Yaracuy', 'Region', 230, 8);          -- 33
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Zulia', 'Region', 480, 8);            -- 34
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Distrito Capital', 'Region', 250, 8); -- 35



INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('París', 'Ciudad', 750, 6);               -- Francia
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Río de Janeiro', 'Ciudad', 680, 7);       -- Brasil
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Caracas', 'Ciudad', 650, 8);              -- Venezuela
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Tokio', 'Ciudad', 820, 9);                -- Japón
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Ciudad del Cabo', 'Ciudad', 620, 10);     -- Sudáfrica
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Sídney', 'Ciudad', 920, 11);             -- Australia
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Puerto Ayacucho', 'Ciudad', 420, 12);      -- Amazonas
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Barcelona', 'Ciudad', 360, 13);            -- Anzoátegui
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Fernando de Apure', 'Ciudad', 310, 14);-- Apure
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Maracay', 'Ciudad', 260, 15);              -- Aragua
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Barinas', 'Ciudad', 290, 16);              -- Barinas
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Ciudad Bolívar', 'Ciudad', 520, 17);       -- Bolívar
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Valencia', 'Ciudad', 270, 18);             -- Carabobo
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Carlos', 'Ciudad', 230, 19);           -- Cojedes
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Tucupita', 'Ciudad', 430, 20);             -- Delta Amacuro
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Coro', 'Ciudad', 380, 21);                 -- Falcón
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Juan de los Morros', 'Ciudad', 320, 22);-- Guárico
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Barquisimeto', 'Ciudad', 340, 23);         -- Lara
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Mérida', 'Ciudad', 470, 24);               -- Mérida
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Los Teques', 'Ciudad', 250, 25);           -- Miranda
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Maturín', 'Ciudad', 330, 26);              -- Monagas
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('La Asunción', 'Ciudad', 480, 27);          -- Nueva Esparta
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Guanare', 'Ciudad', 300, 28);              -- Portuguesa
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Cumaná', 'Ciudad', 350, 29);               -- Sucre
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Cristóbal', 'Ciudad', 430, 30);        -- Táchira
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Trujillo', 'Ciudad', 310, 31);             -- Trujillo
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('La Guaira', 'Ciudad', 280, 32);            -- La Guaira
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Felipe', 'Ciudad', 240, 33);           -- Yaracuy
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Maracaibo', 'Ciudad', 500, 34);            -- Zulia
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Caracas', 'Ciudad', 260, 35);              -- Distrito Capital


-- MUNICIPIOS DEL ESTADO AMAZONAS (Estado Lug_COD = 12)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Alto Orinoco','Municipio',95, 12);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Atabapo','Municipio',100, 12);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Atures','Municipio',105, 12);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Autana','Municipio',110, 12);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Manapiare','Municipio',115, 12);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Maroa','Municipio',120, 12);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Río Negro','Municipio',95, 12);


-- MUNICIPIOS DEL ESTADO ANZOÁTEGUI (Estado Lug_COD = 13)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Anaco','Municipio',100, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Aragua','Municipio',105, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Bolívar','Municipio',110, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Bruzual','Municipio',115, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Carvajal','Municipio',120, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cajigal','Municipio',95, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Diego Bautista Urbaneja','Municipio',100, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Freites','Municipio',105, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Guanipa','Municipio',110, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Guanta','Municipio',115, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Independencia','Municipio',120, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Libertad','Municipio',95, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Miranda','Municipio',100, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Monagas','Municipio',105, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Peñalver','Municipio',110, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Píritu','Municipio',115, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San José de Guanipa','Municipio',120, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Juan de Capistrano','Municipio',95, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Ana','Municipio',100, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Sotillo','Municipio',105, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Simón Rodríguez','Municipio',110, 13);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Sir Arthur McGregor','Municipio',115, 13);

-- MUNICIPIOS DEL ESTADO APURE (Estado Lug_COD = 14)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Achaguas','Municipio',95, 14);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Biruaca','Municipio',100, 14);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Bloque Capanaparo','Municipio',105, 14);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Libertad','Municipio',110, 14);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Muñoz','Municipio',115, 14);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Páez','Municipio',120, 14);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Pedro Camejo','Municipio',95, 14);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Rómulo Gallegos','Municipio',100, 14);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Fernando','Municipio',105, 14);


-- MUNICIPIOS DEL ESTADO ARAGUA (Estado Lug_COD = 15)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Bolívar','Municipio',110, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Camatagua','Municipio',115, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Francisco Linares Alcántara','Municipio',120, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Girardot','Municipio',95, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('José Ángel Lamas','Municipio',100, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('José Félix Ribas','Municipio',105, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('José Rafael Revenga','Municipio',110, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Libertador','Municipio',115, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Mario Briceño Iragorry','Municipio',120, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Ocumare de la Costa de Oro','Municipio',95, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Casimiro','Municipio',100, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Sebastián','Municipio',105, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Santiago Mariño','Municipio',110, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Santos Michelena','Municipio',115, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Sucre','Municipio',120, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Tovar','Municipio',95, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Urdaneta','Municipio',100, 15);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Zamora','Municipio',105, 15);


-- MUNICIPIOS DEL ESTADO BARINAS (Estado Lug_COD = 16)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Alberto Arvelo Torrealba','Municipio',95, 16);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Andrés Eloy Blanco','Municipio',100, 16);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Antonio José de Sucre','Municipio',105, 16);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Arismendi','Municipio',110, 16);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Barinas','Municipio',115, 16);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Bolívar','Municipio',120, 16);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Cruz Paredes','Municipio',95, 16);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Ezequiel Zamora','Municipio',100, 16);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Obispos','Municipio',105, 16);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Pedraza','Municipio',110, 16);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Rojas','Municipio',115, 16);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Sosa','Municipio',120, 16);


-- MUNICIPIOS DEL ESTADO BOLÍVAR (Estado Lug_COD = 17)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Angostura','Municipio',95, 17);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Caroní','Municipio',100, 17);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cedeño','Municipio',105, 17);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Callao','Municipio',110, 17);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Gran Sabana','Municipio',115, 17);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Herés','Municipio',120, 17);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Independencia','Municipio',95, 17);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Piar','Municipio',100, 17);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Roscio','Municipio',105, 17);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Sifontes','Municipio',110, 17);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Sucre','Municipio',115, 17);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Padre Pedro Chien','Municipio',120, 17);

-- MUNICIPIOS DEL ESTADO CARABOBO (Estado Lug_COD = 18)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Bejuma','Municipio',95, 18);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Carlos Arvelo','Municipio',100, 18);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Diego Ibarra','Municipio',105, 18);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Guacara','Municipio',110, 18);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Juan José Mora','Municipio',115, 18);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Libertador','Municipio',120, 18);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Los Guayos','Municipio',95, 18);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Miranda','Municipio',100, 18);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Montalbán','Municipio',105, 18);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Naguanagua','Municipio',110, 18);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Puerto Cabello','Municipio',115, 18);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Diego','Municipio',120, 18);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Joaquín','Municipio',95, 18);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Valencia','Municipio',100, 18);

-- MUNICIPIOS DEL ESTADO COJEDES (Estado Lug_COD = 19)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Anzoátegui','Municipio',105, 19);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Tinaquillo','Municipio',110, 19);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Girardot','Municipio',115, 19);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Lima Blanco','Municipio',120, 19);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Pao de San Juan Bautista','Municipio',95, 19);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Ricaurte','Municipio',100, 19);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Rómulo Gallegos','Municipio',105, 19);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Carlos','Municipio',110, 19);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Tinaco','Municipio',115, 19);

-- MUNICIPIOS DEL ESTADO DELTA AMACURO (Estado Lug_COD = 20)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Antonio Díaz','Municipio',95, 20);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Casacoima','Municipio',100, 20);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Pedernales','Municipio',105, 20);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Tucupita','Municipio',110, 20);

-- MUNICIPIOS DEL ESTADO FALCÓN (Estado Lug_COD = 21)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Acosta','Municipio',115, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Bolívar','Municipio',120, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Buchivacoa','Municipio',95, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Cacique Manaure','Municipio',100, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Colina','Municipio',105, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Dabajuro','Municipio',110, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Democracia','Municipio',115, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Falcón','Municipio',120, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Federación','Municipio',95, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Iturriza','Municipio',100, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Jacura','Municipio',105, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Los Taques','Municipio',110, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Mauroa','Municipio',115, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Miranda','Municipio',120, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Monseñor Iturriza','Municipio',95, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Palmasola','Municipio',100, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Petit','Municipio',105, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Píritu','Municipio',110, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Francisco','Municipio',115, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Sucre','Municipio',120, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Tocópero','Municipio',95, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Unión','Municipio',100, 21);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Zamora','Municipio',105, 21);

-- MUNICIPIOS DEL ESTADO GUÁRICO (Estado Lug_COD = 22)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Camaguán','Municipio',95, 22);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Chaguaramas','Municipio',100, 22);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('El Socorro','Municipio',105, 22);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Francisco de Miranda','Municipio',110, 22);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('José Félix Ribas','Municipio',115, 22);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('José Tadeo Monagas','Municipio',120, 22);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Juan Germán Roscio','Municipio',95, 22);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Julián Mellado','Municipio',100, 22);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Las Mercedes','Municipio',105, 22);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Leonardo Infante','Municipio',110, 22);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Ortiz','Municipio',115, 22);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Pedro Zaraza','Municipio',120, 22);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Gerónimo de Guayabal','Municipio',95, 22);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San José de Guaribe','Municipio',100, 22);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Santa María de Ipire','Municipio',105, 22);

-- MUNICIPIOS DEL ESTADO LARA (Estado Lug_COD = 23)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Andrés Eloy Blanco','Municipio',110, 23);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Crespo','Municipio',115, 23);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Iribarren','Municipio',120, 23);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Jiménez','Municipio',95, 23);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Morán','Municipio',100, 23);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Palavecino','Municipio',105, 23);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Simón Planas','Municipio',110, 23);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Torres','Municipio',115, 23);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Urdaneta','Municipio',120, 23);

-- MUNICIPIOS DEL ESTADO MÉRIDA (Estado Lug_COD = 24)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Alberto Adriani','Municipio',95, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Andrés Bello','Municipio',100, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Antonio Pinto Salinas','Municipio',105, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Aricagua','Municipio',110, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Arzobispo Chacón','Municipio',115, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Campo Elías','Municipio',120, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Caracciolo Parra Olmedo','Municipio',95, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Cardenal Quintero','Municipio',100, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Guaraque','Municipio',105, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Julio César Salas','Municipio',110, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Justo Briceño','Municipio',115, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Libertador','Municipio',120, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Miranda','Municipio',95, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Obispo Ramos de Lora','Municipio',100, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Padre Noguera','Municipio',105, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Pueblo Llano','Municipio',110, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Rangel','Municipio',115, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Rivas Dávila','Municipio',120, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Santos Marquina','Municipio',95, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Sucre','Municipio',100, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Tovar','Municipio',105, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Tulio Febres Cordero','Municipio',110, 24);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Zea','Municipio',115, 24);

-- MUNICIPIOS DEL ESTADO MIRANDA (Estado Lug_COD = 25)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Acevedo','Municipio',120, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Andrés Bello','Municipio',95, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Baruta','Municipio',100, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Brión','Municipio',105, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Buroz','Municipio',110, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Carrizal','Municipio',115, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Chacao','Municipio',120, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Cristóbal Rojas','Municipio',95, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('El Hatillo','Municipio',100, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Guaicaipuro','Municipio',105, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Independencia','Municipio',110, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Lander','Municipio',115, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Los Salias','Municipio',120, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Páez','Municipio',95, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Paz Castillo','Municipio',100, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Pedro Gual','Municipio',105, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Plaza','Municipio',110, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Simón Bolívar','Municipio',115, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Sucre','Municipio',120, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Urdaneta','Municipio',95, 25);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Zamora','Municipio',100, 25);

-- MUNICIPIOS DEL ESTADO MONAGAS (Estado Lug_COD = 26)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Acosta','Municipio',95, 26);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Aguasay','Municipio',100, 26);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Bolívar','Municipio',105, 26);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Caripe','Municipio',110, 26);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Cedeño','Municipio',115, 26);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Ezequiel Zamora','Municipio',120, 26);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Libertador','Municipio',95, 26);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Maturín','Municipio',100, 26);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Piar','Municipio',105, 26);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Punceres','Municipio',110, 26);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Santa Bárbara','Municipio',115, 26);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Sotillo','Municipio',120, 26);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Uracoa','Municipio',95, 26);

-- MUNICIPIOS DEL ESTADO NUEVA ESPARTA (Estado Lug_COD = 27)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Antolín del Campo','Municipio',100, 27);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Arismendi','Municipio',105, 27);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Díaz','Municipio',110, 27);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('García','Municipio',115, 27);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Gómez','Municipio',120, 27);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Maneiro','Municipio',95, 27);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Mariño','Municipio',100, 27);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Península de Macanao','Municipio',105, 27);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Tubores','Municipio',110, 27);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Villalba','Municipio',115, 27);

-- MUNICIPIOS DEL ESTADO PORTUGUESA (Estado Lug_COD = 28)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Agua Blanca','Municipio',95, 28);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Araure','Municipio',100, 28);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Esteller','Municipio',105, 28);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Guanare','Municipio',110, 28);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Guanarito','Municipio',115, 28);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Monseñor José Vicente de Unda','Municipio',120, 28);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Ospino','Municipio',95, 28);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Páez','Municipio',100, 28);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Papelón','Municipio',105, 28);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Genaro de Boconoíto','Municipio',110, 28);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Rafael de Onoto','Municipio',115, 28);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Santa Rosalía','Municipio',120, 28);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Sucre','Municipio',95, 28);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Turén','Municipio',100, 28);

-- MUNICIPIOS DEL ESTADO SUCRE (Estado Lug_COD = 29)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Andrés Eloy Blanco','Municipio',105, 29);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Andrés Mata','Municipio',110, 29);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Arismendi','Municipio',115, 29);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Benítez','Municipio',120, 29);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Bermúdez','Municipio',95, 29);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Bolívar','Municipio',100, 29);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Cajigal','Municipio',105, 29);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Cruz Salmerón Acosta','Municipio',110, 29);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Libertador','Municipio',115, 29);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Mariño','Municipio',120, 29);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Mejía','Municipio',95, 29);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Montes','Municipio',100, 29);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Ribero','Municipio',105, 29);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Sucre','Municipio',110, 29);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Valdez','Municipio',115, 29);

-- MUNICIPIOS DEL ESTADO TÁCHIRA (Estado Lug_COD = 30)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Andrés Bello','Municipio',95, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Antonio Rómulo Costa','Municipio',100, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Ayacucho','Municipio',105, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Bolívar','Municipio',110, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Cárdenas','Municipio',115, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Córdoba','Municipio',120, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Fernández Feo','Municipio',95, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Francisco de Miranda','Municipio',100, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('García de Hevia','Municipio',105, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Guásimos','Municipio',110, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Independencia','Municipio',115, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Jáuregui','Municipio',120, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Junín','Municipio',95, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Libertad','Municipio',100, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Libertador','Municipio',105, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Panamericano','Municipio',110, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Pedro María Ureña','Municipio',115, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Samuel Darío Maldonado','Municipio',120, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Cristóbal','Municipio',95, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Seboruco','Municipio',100, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Simón Rodríguez','Municipio',105, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Sucre','Municipio',110, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Torbes','Municipio',115, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Uribante','Municipio',120, 30);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Judas Tadeo','Municipio',95, 30);

-- MUNICIPIOS DEL ESTADO TRUJILLO (Estado Lug_COD = 31)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Andrés Bello','Municipio',95, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Boconó','Municipio',100, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Bolívar','Municipio',105, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Candelaria','Municipio',110, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Carache','Municipio',115, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Escuque','Municipio',120, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('José Felipe Márquez Cañizales','Municipio',95, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('La Ceiba','Municipio',100, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Miranda','Municipio',105, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Monte Carmelo','Municipio',110, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Motatán','Municipio',115, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Pampán','Municipio',120, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Pampanito','Municipio',95, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Rafael Rangel','Municipio',100, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Rafael de Carvajal','Municipio',105, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Sucre','Municipio',110, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Trujillo','Municipio',115, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Urdaneta','Municipio',120, 31);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Valera','Municipio',95, 31);

-- MUNICIPIOS DEL ESTADO LA GUAIRA (Estado Lug_COD = 32)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Vargas','Municipio',100, 32);

-- MUNICIPIOS DEL ESTADO YARACUY (Estado Lug_COD = 33)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Arístides Bastidas','Municipio',95, 33);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Bolívar','Municipio',100, 33);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Bruzual','Municipio',105, 33);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Cocorote','Municipio',110, 33);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Independencia','Municipio',115, 33);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('José Antonio Páez','Municipio',120, 33);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('La Trinidad','Municipio',95, 33);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Manuel Monge','Municipio',100, 33);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Nirgua','Municipio',105, 33);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Peña','Municipio',110, 33);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Felipe','Municipio',115, 33);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Sucre','Municipio',120, 33);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Urachiche','Municipio',95, 33);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Veroes','Municipio',100, 33);

-- MUNICIPIOS DEL ESTADO ZULIA (Estado Lug_COD = 34)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Almirante Padilla','Municipio',95, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Baralt','Municipio',100, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Cabimas','Municipio',105, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Catatumbo','Municipio',110, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Colón','Municipio',115, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Francisco Javier Pulgar','Municipio',120, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Jesús Enrique Lossada','Municipio',95, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Jesús María Semprún','Municipio',100, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('La Cañada de Urdaneta','Municipio',105, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Lagunillas','Municipio',110, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Machiques de Perijá','Municipio',115, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Mara','Municipio',120, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Maracaibo','Municipio',95, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Miranda','Municipio',100, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Páez','Municipio',105, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Rosario de Perijá','Municipio',110, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('San Francisco','Municipio',115, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Santa Rita','Municipio',120, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Simón Bolívar','Municipio',95, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Sucre','Municipio',100, 34);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Valmore Rodríguez','Municipio',105, 34);

-- MUNICIPIOS DEL DISTRITO CAPITAL (Estado Lug_COD = 35)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES ('Libertador','Municipio',95, 35);


-- PARROQUIAS DEL MUNICIPIO ALTO ORINOCO (Municipio Lug_COD = 36)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Esmeralda','Parroquia',50, 36);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Huachamacare','Parroquia',55, 36);

-- PARROQUIAS DEL MUNICIPIO ATABAPO (Municipio Lug_COD = 37)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Fernando de Atabapo','Parroquia',60, 37);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Ucata','Parroquia',65, 37);

-- PARROQUIAS DEL MUNICIPIO ATURES (Municipio Lug_COD = 38)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Puerto Ayacucho','Parroquia',70, 38);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Samariapo','Parroquia',75, 38);

-- PARROQUIAS DEL MUNICIPIO AUTANA (Municipio Lug_COD = 39)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Isla Ratón','Parroquia',80, 39);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Munduapo','Parroquia',85, 39);

-- PARROQUIAS DEL MUNICIPIO MANAPIARE (Municipio Lug_COD = 40)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Juan de Manapiare','Parroquia',90, 40);

-- PARROQUIAS DEL MUNICIPIO MAROA (Municipio Lug_COD = 41)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Maroa','Parroquia',95, 41);

-- PARROQUIAS DEL MUNICIPIO RÍO NEGRO (Municipio Lug_COD = 42)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Carlos de Río Negro','Parroquia',100, 42);


-- PARROQUIAS DEL MUNICIPIO ANACO (Municipio Lug_COD = 43)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Anaco','Parroquia',50, 43);

-- PARROQUIAS DEL MUNICIPIO ARAGUA (Municipio Lug_COD = 44)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Aragua de Barcelona','Parroquia',55, 44);

-- PARROQUIAS DEL MUNICIPIO BOLÍVAR (Municipio Lug_COD = 45)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Barcelona','Parroquia',60, 45);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Carmen','Parroquia',65, 45);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Cristóbal','Parroquia',70, 45);

-- PARROQUIAS DEL MUNICIPIO BRUZUAL (Municipio Lug_COD = 46)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Clarines','Parroquia',75, 46);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Guanape','Parroquia',80, 46);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Sabana de Uchire','Parroquia',85, 46);

-- PARROQUIAS DEL MUNICIPIO CARVAJAL (Municipio Lug_COD = 47)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Valle de Guanape','Parroquia',90, 47);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Bárbara','Parroquia',95, 47);

-- PARROQUIAS DEL MUNICIPIO CAJIGAL (Municipio Lug_COD = 48)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Onoto','Parroquia',50, 48);

-- PARROQUIAS DEL MUNICIPIO DIEGO BAUTISTA URBANEJA (Municipio Lug_COD = 49)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Lechería','Parroquia',55, 49);

-- PARROQUIAS DEL MUNICIPIO FREITES (Municipio Lug_COD = 50)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cantaura','Parroquia',60, 50);

-- PARROQUIAS DEL MUNICIPIO GUANIPA (Municipio Lug_COD = 51)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San José de Guanipa','Parroquia',65, 51);

-- PARROQUIAS DEL MUNICIPIO GUANTA (Municipio Lug_COD = 52)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Guanta','Parroquia',70, 52);

-- PARROQUIAS DEL MUNICIPIO INDEPENDENCIA (Municipio Lug_COD = 53)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Soledad','Parroquia',75, 53);

-- PARROQUIAS DEL MUNICIPIO LIBERTAD (Municipio Lug_COD = 54)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Mateo','Parroquia',80, 54);

-- PARROQUIAS DEL MUNICIPIO MIRANDA (Municipio Lug_COD = 55)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Pariaguán','Parroquia',85, 55);

-- PARROQUIAS DEL MUNICIPIO MONAGAS (Municipio Lug_COD = 56)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Mapire','Parroquia',90, 56);

-- PARROQUIAS DEL MUNICIPIO PEÑALVER (Municipio Lug_COD = 57)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Puerto Píritu','Parroquia',95, 57);

-- PARROQUIAS DEL MUNICIPIO PÍRITU (Municipio Lug_COD = 58)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Píritu','Parroquia',100, 58);

-- PARROQUIAS DEL MUNICIPIO SAN JUAN DE CAPISTRANO (Municipio Lug_COD = 60)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Boca de Chávez','Parroquia',105, 60);

-- PARROQUIAS DEL MUNICIPIO SANTA ANA (Municipio Lug_COD = 61)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Ana','Parroquia',110, 61);

-- PARROQUIAS DEL MUNICIPIO SOTILLO (Municipio Lug_COD = 62)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Puerto La Cruz','Parroquia',115, 62);

-- PARROQUIAS DEL MUNICIPIO SIMÓN RODRÍGUEZ (Municipio Lug_COD = 63)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Tigre','Parroquia',120, 63);

-- PARROQUIAS DEL MUNICIPIO SIR ARTHUR MC GREGOR (Municipio Lug_COD = 64)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Chaparro','Parroquia',95, 64);



-- PARROQUIAS DEL MUNICIPIO ACHAGUAS (Municipio Lug_COD = 65)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Achaguas','Parroquia',50, 65);

-- PARROQUIAS DEL MUNICIPIO BIRUACA (Municipio Lug_COD = 66)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Biruaca','Parroquia',55, 66);

-- PARROQUIAS DEL MUNICIPIO BLOQUE CAPANAPARO (Municipio Lug_COD = 67)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Capanaparo','Parroquia',60, 67);

-- PARROQUIAS DEL MUNICIPIO LIBERTAD (Municipio Lug_COD = 68)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Yagual','Parroquia',65, 68);

-- PARROQUIAS DEL MUNICIPIO MUÑOZ (Municipio Lug_COD = 69)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Mantecal','Parroquia',70, 69);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Quintero','Parroquia',75, 69);

-- PARROQUIAS DEL MUNICIPIO PÁEZ (Municipio Lug_COD = 70)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Guasdualito','Parroquia',80, 70);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Aramendi','Parroquia',85, 70);

-- PARROQUIAS DEL MUNICIPIO PEDRO CAMEJO (Municipio Lug_COD = 71)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Juan de Payara','Parroquia',90, 71);

-- PARROQUIAS DEL MUNICIPIO RÓMULO GALLEGOS (Municipio Lug_COD = 72)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Elorza','Parroquia',95, 72);

-- PARROQUIAS DEL MUNICIPIO SAN FERNANDO (Municipio Lug_COD = 73)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Fernando','Parroquia',100, 73);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Recreo','Parroquia',105, 73);


-- PARROQUIAS DEL MUNICIPIO BOLÍVAR (Municipio Lug_COD = 74)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Mateo','Parroquia',50, 74);

-- PARROQUIAS DEL MUNICIPIO CAMATAGUA (Municipio Lug_COD = 75)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Camatagua','Parroquia',55, 75);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Carmen de Cura','Parroquia',60, 75);

-- PARROQUIAS DEL MUNICIPIO FRANCISCO LINARES ALCÁNTARA (Municipio Lug_COD = 76)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Rita','Parroquia',65, 76);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Francisco de Miranda','Parroquia',70, 76);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Monseñor Feliciano González','Parroquia',75, 76);

-- PARROQUIAS DEL MUNICIPIO GIRARDOT (Municipio Lug_COD = 77)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Las Delicias','Parroquia',80, 77);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Madre María de San José','Parroquia',85, 77);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Pedro José Ovalles','Parroquia',90, 77);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Joaquín Crespo','Parroquia',95, 77);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('José Casanova Godoy','Parroquia',100, 77);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Los Tacarigua','Parroquia',105, 77);

-- PARROQUIAS DEL MUNICIPIO JOSÉ ÁNGEL LAMAS (Municipio Lug_COD = 78)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Cruz','Parroquia',110, 78);

-- PARROQUIAS DEL MUNICIPIO JOSÉ FÉLIX RIBAS (Municipio Lug_COD = 79)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Victoria','Parroquia',115, 79);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Zuata','Parroquia',120, 79);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Pao de Zárate','Parroquia',95, 79);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Las Guacamayas','Parroquia',100, 79);

-- PARROQUIAS DEL MUNICIPIO JOSÉ RAFAEL REVENGA (Municipio Lug_COD = 80)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Consejo','Parroquia',105, 80);

-- PARROQUIAS DEL MUNICIPIO LIBERTADOR (Municipio Lug_COD = 81)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Palo Negro','Parroquia',110, 81);

-- PARROQUIAS DEL MUNICIPIO MARIO BRICEÑO IRAGORRY (Municipio Lug_COD = 82)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Limón','Parroquia',115, 82);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Caña de Azúcar','Parroquia',120, 82);

-- PARROQUIAS DEL MUNICIPIO OCUMARE DE LA COSTA DE ORO (Municipio Lug_COD = 83)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Ocumare de la Costa','Parroquia',95, 83);

-- PARROQUIAS DEL MUNICIPIO SAN CASIMIRO (Municipio Lug_COD = 84)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Casimiro','Parroquia',100, 84);

-- PARROQUIAS DEL MUNICIPIO SAN SEBASTIÁN (Municipio Lug_COD = 85)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Sebastián','Parroquia',105, 85);

-- PARROQUIAS DEL MUNICIPIO SANTIAGO MARIÑO (Municipio Lug_COD = 86)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Turmero','Parroquia',110, 86);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Arevalo Aponte','Parroquia',115, 86);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Chuao','Parroquia',120, 86);

-- PARROQUIAS DEL MUNICIPIO SANTOS MICHELENA (Municipio Lug_COD = 87)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Las Tejerías','Parroquia',95, 87);

-- PARROQUIAS DEL MUNICIPIO SUCRE (Municipio Lug_COD = 88)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cagua','Parroquia',100, 88);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Bella Vista','Parroquia',105, 88);

-- PARROQUIAS DEL MUNICIPIO TOVAR (Municipio Lug_COD = 89)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Colonia Tovar','Parroquia',110, 89);

-- PARROQUIAS DEL MUNICIPIO URDANETA (Municipio Lug_COD = 90)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Barbacoas','Parroquia',110, 90);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Las Peñitas','Parroquia',115, 90);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Francisco de Cara','Parroquia',120, 90);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Taguay','Parroquia',95, 90);

-- PARROQUIAS DEL MUNICIPIO ZAMORA (Municipio Lug_COD = 91)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Villa de Cura','Parroquia',115, 91);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Magdaleno','Parroquia',120, 91);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Francisco de Asís','Parroquia',95, 91);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Valles de Tucutunemo','Parroquia',100, 91);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Augusto Mijares','Parroquia',105, 91);


-- PARROQUIAS DEL MUNICIPIO ALBERTO ARVELO TORREALBA (Municipio Lug_COD = 92)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Sabaneta','Parroquia',50, 92);

-- PARROQUIAS DEL MUNICIPIO ANDRÉS ELOY BLANCO (Municipio Lug_COD = 93)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Cantón','Parroquia',55, 93);

-- PARROQUIAS DEL MUNICIPIO ANTONIO JOSÉ DE SUCRE (Municipio Lug_COD = 94)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Socopó','Parroquia',60, 94);

-- PARROQUIAS DEL MUNICIPIO ARISMENDI (Municipio Lug_COD = 95)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Arismendi','Parroquia',65, 95);

-- PARROQUIAS DEL MUNICIPIO BARINAS (Municipio Lug_COD = 96)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Barinas','Parroquia',70, 96);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Alto Barinas','Parroquia',75, 96);

-- PARROQUIAS DEL MUNICIPIO BOLÍVAR (Municipio Lug_COD = 97)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Barinitas','Parroquia',80, 97);

-- PARROQUIAS DEL MUNICIPIO CRUZ PAREDES (Municipio Lug_COD = 98)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Barrancas','Parroquia',85, 98);

-- PARROQUIAS DEL MUNICIPIO EZEQUIEL ZAMORA (Municipio Lug_COD = 99)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Bárbara','Parroquia',90, 99);

-- PARROQUIAS DEL MUNICIPIO OBISPOS (Municipio Lug_COD = 100)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Obispos','Parroquia',95, 100);

-- PARROQUIAS DEL MUNICIPIO PEDRAZA (Municipio Lug_COD = 101)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Ciudad Bolivia','Parroquia',100, 101);

-- PARROQUIAS DEL MUNICIPIO ROJAS (Municipio Lug_COD = 102)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Libertad','Parroquia',105, 102);

-- PARROQUIAS DEL MUNICIPIO SOSA (Municipio Lug_COD = 103)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Ciudad de Nutrias','Parroquia',110, 103);


-- PARROQUIAS DEL MUNICIPIO CARONÍ (Municipio Lug_COD = 104)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Unare','Parroquia',50, 104);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Vista al Sol','Parroquia',55, 104);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Chirica','Parroquia',60, 104);

-- PARROQUIAS DEL MUNICIPIO CEDEÑO (Municipio Lug_COD = 105)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Caicara del Orinoco','Parroquia',65, 105);

-- PARROQUIAS DEL MUNICIPIO EL CALLAO (Municipio Lug_COD = 106)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Callao','Parroquia',70, 106);

-- PARROQUIAS DEL MUNICIPIO GRAN SABANA (Municipio Lug_COD = 107)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Elena de Uairén','Parroquia',75, 107);

-- PARROQUIAS DEL MUNICIPIO HERES (Municipio Lug_COD = 108)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Catedral','Parroquia',80, 108);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Agua Salada','Parroquia',85, 108);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Marhuanta','Parroquia',90, 108);

-- PARROQUIAS DEL MUNICIPIO PIAR (Municipio Lug_COD = 109)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Upata','Parroquia',95, 109);

-- PARROQUIAS DEL MUNICIPIO ROSCIO (Municipio Lug_COD = 110)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Guasipati','Parroquia',100, 110);

-- PARROQUIAS DEL MUNICIPIO SIFONTES (Municipio Lug_COD = 111)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Tumeremo','Parroquia',105, 111);

-- PARROQUIAS DEL MUNICIPIO SUCRE (Municipio Lug_COD = 112)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Maripa','Parroquia',110, 112);

-- PARROQUIAS DEL MUNICIPIO PADRE PEDRO CHIEN (Municipio Lug_COD = 113)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Palmar','Parroquia',115, 113);


-- PARROQUIAS DEL MUNICIPIO BEJUMA (Municipio Lug_COD = 114)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Bejuma','Parroquia',50, 114);

-- PARROQUIAS DEL MUNICIPIO CARLOS ARVELO (Municipio Lug_COD = 115)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Güigüe','Parroquia',55, 115);

-- PARROQUIAS DEL MUNICIPIO DIEGO IBARRA (Municipio Lug_COD = 116)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Mariara','Parroquia',60, 116);

-- PARROQUIAS DEL MUNICIPIO GUACARA (Municipio Lug_COD = 117)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Guacara','Parroquia',65, 117);

-- PARROQUIAS DEL MUNICIPIO JUAN JOSÉ MORA (Municipio Lug_COD = 118)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Morón','Parroquia',70, 118);

-- PARROQUIAS DEL MUNICIPIO LIBERTADOR (Municipio Lug_COD = 119)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Tocuyito','Parroquia',75, 119);

-- PARROQUIAS DEL MUNICIPIO LOS GUAYOS (Municipio Lug_COD = 120)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Los Guayos','Parroquia',80, 120);

-- PARROQUIAS DEL MUNICIPIO MIRANDA (Municipio Lug_COD = 121)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Miranda','Parroquia',85, 121);

-- PARROQUIAS DEL MUNICIPIO MONTALBÁN (Municipio Lug_COD = 122)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Montalbán','Parroquia',90, 122);

-- PARROQUIAS DEL MUNICIPIO NAGUANAGUA (Municipio Lug_COD = 123)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Naguanagua','Parroquia',95, 123);

-- PARROQUIAS DEL MUNICIPIO PUERTO CABELLO (Municipio Lug_COD = 124)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Bartolomé Salom','Parroquia',100, 124);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Unión','Parroquia',105, 124);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Fraternidad','Parroquia',110, 124);

-- PARROQUIAS DEL MUNICIPIO SAN DIEGO (Municipio Lug_COD = 125)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Diego','Parroquia',115, 125);

-- PARROQUIAS DEL MUNICIPIO SAN JOAQUÍN (Municipio Lug_COD = 126)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Joaquín','Parroquia',120, 126);

-- PARROQUIAS DEL MUNICIPIO VALENCIA (Municipio Lug_COD = 127)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Candelaria','Parroquia',95, 127);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Blas','Parroquia',100, 127);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Rosa','Parroquia',105, 127);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Miguel Peña','Parroquia',110, 127);


-- PARROQUIAS DEL MUNICIPIO ANZOÁTEGUI (Municipio Lug_COD = 128)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cojedes','Parroquia',50, 128);

-- PARROQUIAS DEL MUNICIPIO TINAQUILLO (Municipio Lug_COD = 129)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Tinaquillo','Parroquia',55, 129);

-- PARROQUIAS DEL MUNICIPIO GIRARDOT (Municipio Lug_COD = 130)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Baúl','Parroquia',60, 130);

-- PARROQUIAS DEL MUNICIPIO LIMA BLANCO (Municipio Lug_COD = 131)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Macapo','Parroquia',65, 131);

-- PARROQUIAS DEL MUNICIPIO PAO DE SAN JUAN BAUTISTA (Municipio Lug_COD = 132)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Pao','Parroquia',70, 132);

-- PARROQUIAS DEL MUNICIPIO RICAURTE (Municipio Lug_COD = 133)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Libertad de Cojedes','Parroquia',75, 133);

-- PARROQUIAS DEL MUNICIPIO RÓMULO GALLEGOS (Municipio Lug_COD = 134)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Las Vegas','Parroquia',80, 134);

-- PARROQUIAS DEL MUNICIPIO SAN CARLOS (Municipio Lug_COD = 135)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Carlos de Austria','Parroquia',85, 135);

-- PARROQUIAS DEL MUNICIPIO TINACO (Municipio Lug_COD = 136)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Tinaco','Parroquia',90, 136);


-- PARROQUIAS DEL MUNICIPIO ANTONIO DÍAZ (Municipio Lug_COD = 137)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Curiapo','Parroquia',50, 137);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Almirante Luis Brión','Parroquia',55, 137);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Manuel Renaud','Parroquia',60, 137);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Padre Barral','Parroquia',65, 137);

-- PARROQUIAS DEL MUNICIPIO CASACOIMA (Municipio Lug_COD = 138)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Casacoima','Parroquia',70, 138);

-- PARROQUIAS DEL MUNICIPIO PEDERNALES (Municipio Lug_COD = 139)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Pedernales','Parroquia',75, 139);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Luis Beltrán Prieto Figueroa','Parroquia',80, 139);

-- PARROQUIAS DEL MUNICIPIO TUCUPITA (Municipio Lug_COD = 140)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San José','Parroquia',85, 140);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Virgen del Valle','Parroquia',90, 140);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Leonardo Ruiz Pineda','Parroquia',95, 140);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Monseñor Argimiro García','Parroquia',100, 140);


-- PARROQUIAS DEL MUNICIPIO ACOSTA (Municipio Lug_COD = 141)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Juan de los Cayos','Parroquia',50, 141);

-- PARROQUIAS DEL MUNICIPIO BOLÍVAR (Municipio Lug_COD = 142)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Luis','Parroquia',55, 142);

-- PARROQUIAS DEL MUNICIPIO BUCHIVACOA (Municipio Lug_COD = 143)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Capatárida','Parroquia',60, 143);

-- PARROQUIAS DEL MUNICIPIO CACIQUE MANAURE (Municipio Lug_COD = 144)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Yaracal','Parroquia',65, 144);

-- PARROQUIAS DEL MUNICIPIO CARIRUBANA (Municipio Lug_COD = 145)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Punto Fijo','Parroquia',70, 145);

-- PARROQUIAS DEL MUNICIPIO COLINA (Municipio Lug_COD = 146)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Vela de Coro','Parroquia',75, 146);

-- PARROQUIAS DEL MUNICIPIO DABAJURO (Municipio Lug_COD = 147)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Dabajuro','Parroquia',80, 147);

-- PARROQUIAS DEL MUNICIPIO DEMOCRACIA (Municipio Lug_COD = 148)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Pedregal','Parroquia',85, 148);

-- PARROQUIAS DEL MUNICIPIO FALCÓN (Municipio Lug_COD = 149)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Pueblo Nuevo','Parroquia',90, 149);

-- PARROQUIAS DEL MUNICIPIO FEDERACIÓN (Municipio Lug_COD = 150)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Churuguara','Parroquia',95, 150);

-- PARROQUIAS DEL MUNICIPIO JACURA (Municipio Lug_COD = 151)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Jacura','Parroquia',100, 151);

-- PARROQUIAS DEL MUNICIPIO LOS TAQUES (Municipio Lug_COD = 152)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Los Taques','Parroquia',105, 152);

-- PARROQUIAS DEL MUNICIPIO MAUROA (Municipio Lug_COD = 153)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Mauroa','Parroquia',110, 153);

-- PARROQUIAS DEL MUNICIPIO MIRANDA (Municipio Lug_COD = 154)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Coro','Parroquia',115, 154);

-- PARROQUIAS DEL MUNICIPIO MONSEÑOR ITURRIZA (Municipio Lug_COD = 155)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Chichiriviche','Parroquia',120, 155);

-- PARROQUIAS DEL MUNICIPIO PALMASOLA (Municipio Lug_COD = 156)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Palmasola','Parroquia',95, 156);

-- PARROQUIAS DEL MUNICIPIO PETIT (Municipio Lug_COD = 157)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cabure','Parroquia',100, 157);

-- PARROQUIAS DEL MUNICIPIO PÍRITU (Municipio Lug_COD = 158)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Píritu','Parroquia',105, 158);

-- PARROQUIAS DEL MUNICIPIO SAN FRANCISCO (Municipio Lug_COD = 159)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Mirimire','Parroquia',110, 159);

-- PARROQUIAS DEL MUNICIPIO SILVA (Municipio Lug_COD = 160)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Tucacas','Parroquia',115, 160);

-- PARROQUIAS DEL MUNICIPIO SUCRE (Municipio Lug_COD = 161)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Cruz de Taratara','Parroquia',120, 161);

-- PARROQUIAS DEL MUNICIPIO TOCÓPERO (Municipio Lug_COD = 162)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Tocópero','Parroquia',95, 162);

-- PARROQUIAS DEL MUNICIPIO UNIÓN (Municipio Lug_COD = 163)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Cruz de Bucaral','Parroquia',100, 163);

-- PARROQUIAS DEL MUNICIPIO URUMACO (Municipio Lug_COD = 164)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Urumaco','Parroquia',105, 164);

-- PARROQUIAS DEL MUNICIPIO ZAMORA (Municipio Lug_COD = 165)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Puerto Cumarebo','Parroquia',110, 165);


-- PARROQUIAS DEL MUNICIPIO CAMAGUÁN (Municipio Lug_COD = 166)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Camaguán','Parroquia',50, 166);

-- PARROQUIAS DEL MUNICIPIO CHAGUARAMAS (Municipio Lug_COD = 167)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Chaguaramas','Parroquia',55, 167);

-- PARROQUIAS DEL MUNICIPIO EL SOCORRO (Municipio Lug_COD = 168)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Socorro','Parroquia',60, 168);

-- PARROQUIAS DEL MUNICIPIO SAN GERÓNIMO DE GUAYABAL (Municipio Lug_COD = 169)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Gerónimo de Guayabal','Parroquia',65, 169);

-- PARROQUIAS DEL MUNICIPIO LEONARDO INFANTE (Municipio Lug_COD = 170)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Valle de la Pascua','Parroquia',70, 170);

-- PARROQUIAS DEL MUNICIPIO LAS MERCEDES (Municipio Lug_COD = 171)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Las Mercedes','Parroquia',75, 171);

-- PARROQUIAS DEL MUNICIPIO JULIÁN MELLADO (Municipio Lug_COD = 172)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Sombrero','Parroquia',80, 172);

-- PARROQUIAS DEL MUNICIPIO FRANCISCO DE MIRANDA (Municipio Lug_COD = 173)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Calabozo','Parroquia',85, 173);

-- PARROQUIAS DEL MUNICIPIO JOSÉ TADEO MONAGAS (Municipio Lug_COD = 174)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Altagracia de Orituco','Parroquia',90, 174);

-- PARROQUIAS DEL MUNICIPIO ORTIZ (Municipio Lug_COD = 175)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Ortiz','Parroquia',95, 175);

-- PARROQUIAS DEL MUNICIPIO SAN JOSÉ DE GUARIBE (Municipio Lug_COD = 176)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San José de Guaribe','Parroquia',100, 176);

-- PARROQUIAS DEL MUNICIPIO SANTA MARÍA DE IPIRE (Municipio Lug_COD = 177)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa María de Ipire','Parroquia',105, 177);

-- PARROQUIAS DEL MUNICIPIO ZARAZA (Municipio Lug_COD = 178)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Zaraza','Parroquia',110, 178);

-- PARROQUIAS DEL MUNICIPIO ANDRÉS ELOY BLANCO (Municipio Lug_COD = 179)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Sanare','Parroquia',50, 179);

-- PARROQUIAS DEL MUNICIPIO CRESPO (Municipio Lug_COD = 180)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Duaca','Parroquia',55, 180);

-- PARROQUIAS DEL MUNICIPIO IRIBARREN (Municipio Lug_COD = 181)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Catedral','Parroquia',60, 181);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Concepción','Parroquia',65, 181);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Juárez','Parroquia',70, 181);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Rosa','Parroquia',75, 181);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Tamaca','Parroquia',80, 181);

-- PARROQUIAS DEL MUNICIPIO JIMÉNEZ (Municipio Lug_COD = 182)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Quíbor','Parroquia',85, 182);

-- PARROQUIAS DEL MUNICIPIO MORÁN (Municipio Lug_COD = 183)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Tocuyo','Parroquia',90, 183);

-- PARROQUIAS DEL MUNICIPIO PALAVECINO (Municipio Lug_COD = 184)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cabudare','Parroquia',95, 184);

-- PARROQUIAS DEL MUNICIPIO SIMÓN PLANAS (Municipio Lug_COD = 185)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Sarare','Parroquia',100, 185);

-- PARROQUIAS DEL MUNICIPIO TORRES (Municipio Lug_COD = 186)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Carora','Parroquia',105, 186);

-- PARROQUIAS DEL MUNICIPIO URDANETA (Municipio Lug_COD = 187)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Siquisique','Parroquia',110, 187);


-- PARROQUIAS DEL MUNICIPIO ALBERTO ADRIANI (Municipio Lug_COD = 188)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Vigía','Parroquia',50, 188);

-- PARROQUIAS DEL MUNICIPIO ANDRÉS BELLO (Municipio Lug_COD = 189)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Azulita','Parroquia',55, 189);

-- PARROQUIAS DEL MUNICIPIO ANTONIO PINTO SALINAS (Municipio Lug_COD = 190)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Cruz de Mora','Parroquia',60, 190);

-- PARROQUIAS DEL MUNICIPIO ARICAGUA (Municipio Lug_COD = 191)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Aricagua','Parroquia',65, 191);

-- PARROQUIAS DEL MUNICIPIO ARZOBISPO CHACÓN (Municipio Lug_COD = 192)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Canaguá','Parroquia',70, 192);

-- PARROQUIAS DEL MUNICIPIO CAMPO ELÍAS (Municipio Lug_COD = 193)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Ejido','Parroquia',75, 193);

-- PARROQUIAS DEL MUNICIPIO CARACCIOLO PARRA OLMEDO (Municipio Lug_COD = 194)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Tucaní','Parroquia',80, 194);

-- PARROQUIAS DEL MUNICIPIO CARDENAL QUINTERO (Municipio Lug_COD = 195)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santo Domingo','Parroquia',85, 195);

-- PARROQUIAS DEL MUNICIPIO GUARAQUE (Municipio Lug_COD = 196)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Guaraque','Parroquia',90, 196);

-- PARROQUIAS DEL MUNICIPIO JULIO CÉSAR SALAS (Municipio Lug_COD = 197)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Arapuey','Parroquia',95, 197);

-- PARROQUIAS DEL MUNICIPIO JUSTO BRICEÑO (Municipio Lug_COD = 198)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Torondoy','Parroquia',100, 198);

-- PARROQUIAS DEL MUNICIPIO LIBERTADOR (Municipio Lug_COD = 199)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Mérida','Parroquia',105, 199);

-- PARROQUIAS DEL MUNICIPIO MIRANDA (Municipio Lug_COD = 200)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Timotes','Parroquia',110, 200);

-- PARROQUIAS DEL MUNICIPIO OBISPO RAMOS DE LORA (Municipio Lug_COD = 201)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Elena de Arenales','Parroquia',115, 201);

-- PARROQUIAS DEL MUNICIPIO PADRE NOGUERA (Municipio Lug_COD = 202)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa María de Caparo','Parroquia',120, 202);

-- PARROQUIAS DEL MUNICIPIO PUEBLO LLANO (Municipio Lug_COD = 203)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Pueblo Llano','Parroquia',95, 203);

-- PARROQUIAS DEL MUNICIPIO RANGEL (Municipio Lug_COD = 204)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Mucuchíes','Parroquia',100, 204);

-- PARROQUIAS DEL MUNICIPIO RIVAS DÁVILA (Municipio Lug_COD = 205)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Bailadores','Parroquia',105, 205);

-- PARROQUIAS DEL MUNICIPIO SANTOS MARQUINA (Municipio Lug_COD = 206)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Tabay','Parroquia',110, 206);

-- PARROQUIAS DEL MUNICIPIO SUCRE (Municipio Lug_COD = 207)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Lagunillas','Parroquia',115, 207);

-- PARROQUIAS DEL MUNICIPIO TOVAR (Municipio Lug_COD = 208)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Tovar','Parroquia',120, 208);

-- PARROQUIAS DEL MUNICIPIO TULIO FEBRES CORDERO (Municipio Lug_COD = 209)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Nueva Bolivia','Parroquia',95, 209);

-- PARROQUIAS DEL MUNICIPIO ZEA (Municipio Lug_COD = 210)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Zea','Parroquia',100, 210);


-- PARROQUIAS DEL MUNICIPIO ACEVEDO (Municipio Lug_COD = 211)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Caucagua','Parroquia',50, 211);

-- PARROQUIAS DEL MUNICIPIO ANDRÉS BELLO (Municipio Lug_COD = 212)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San José de Barlovento','Parroquia',55, 212);

-- PARROQUIAS DEL MUNICIPIO BARUTA (Municipio Lug_COD = 213)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Baruta','Parroquia',60, 213);

-- PARROQUIAS DEL MUNICIPIO BRIÓN (Municipio Lug_COD = 214)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Higuerote','Parroquia',65, 214);

-- PARROQUIAS DEL MUNICIPIO BUROZ (Municipio Lug_COD = 215)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Mamporal','Parroquia',70, 215);

-- PARROQUIAS DEL MUNICIPIO CARRIZAL (Municipio Lug_COD = 216)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Carrizal','Parroquia',75, 216);

-- PARROQUIAS DEL MUNICIPIO CHACAO (Municipio Lug_COD = 217)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Chacao','Parroquia',80, 217);

-- PARROQUIAS DEL MUNICIPIO CRISTÓBAL ROJAS (Municipio Lug_COD = 218)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Charallave','Parroquia',85, 218);

-- PARROQUIAS DEL MUNICIPIO EL HATILLO (Municipio Lug_COD = 219)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Hatillo','Parroquia',90, 219);

-- PARROQUIAS DEL MUNICIPIO GUAICAIPURO (Municipio Lug_COD = 220)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Los Teques','Parroquia',95, 220);

-- PARROQUIAS DEL MUNICIPIO INDEPENDENCIA (Municipio Lug_COD = 221)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Teresa del Tuy','Parroquia',100, 221);

-- PARROQUIAS DEL MUNICIPIO LANDER (Municipio Lug_COD = 222)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Ocumare del Tuy','Parroquia',105, 222);

-- PARROQUIAS DEL MUNICIPIO LOS SALIAS (Municipio Lug_COD = 223)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Antonio de los Altos','Parroquia',110, 223);

-- PARROQUIAS DEL MUNICIPIO PAZ CASTILLO (Municipio Lug_COD = 224)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Lucía','Parroquia',115, 224);

-- PARROQUIAS DEL MUNICIPIO PEDRO GUAL (Municipio Lug_COD = 225)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cúpira','Parroquia',120, 225);

-- PARROQUIAS DEL MUNICIPIO PLAZA (Municipio Lug_COD = 226)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Guarenas','Parroquia',95, 226);

-- PARROQUIAS DEL MUNICIPIO SIMÓN BOLÍVAR (Municipio Lug_COD = 227)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Francisco de Yare','Parroquia',100, 227);

-- PARROQUIAS DEL MUNICIPIO SUCRE (Municipio Lug_COD = 228)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Petare','Parroquia',105, 228);

-- PARROQUIAS DEL MUNICIPIO URDANETA (Municipio Lug_COD = 229)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cúa','Parroquia',110, 229);

-- PARROQUIAS DEL MUNICIPIO ZAMORA (Municipio Lug_COD = 230)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Guatire','Parroquia',115, 230);



-- PARROQUIAS DEL MUNICIPIO ACOSTA (Municipio Lug_COD = 231)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Antonio de Capayacuar','Parroquia',50, 231);

-- PARROQUIAS DEL MUNICIPIO AGUASAY (Municipio Lug_COD = 232)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Aguasay','Parroquia',55, 232);

-- PARROQUIAS DEL MUNICIPIO BOLÍVAR (Municipio Lug_COD = 233)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Caripito','Parroquia',60, 233);

-- PARROQUIAS DEL MUNICIPIO CARIPE (Municipio Lug_COD = 234)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Caripe','Parroquia',65, 234);

-- PARROQUIAS DEL MUNICIPIO CEDEÑO (Municipio Lug_COD = 235)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Caicara de Maturín','Parroquia',70, 235);

-- PARROQUIAS DEL MUNICIPIO EZEQUIEL ZAMORA (Municipio Lug_COD = 236)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Punta de Mata','Parroquia',75, 236);

-- PARROQUIAS DEL MUNICIPIO LIBERTADOR (Municipio Lug_COD = 237)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Temblador','Parroquia',80, 237);

-- PARROQUIAS DEL MUNICIPIO MATURÍN (Municipio Lug_COD = 238)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Simón','Parroquia',85, 238);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Boquerón','Parroquia',90, 238);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Las Cocuizas','Parroquia',95, 238);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Cruz','Parroquia',100, 238);

-- PARROQUIAS DEL MUNICIPIO PIAR (Municipio Lug_COD = 239)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Aragua de Maturín','Parroquia',105, 239);

-- PARROQUIAS DEL MUNICIPIO PUNCERES (Municipio Lug_COD = 240)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Quiriquire','Parroquia',110, 240);

-- PARROQUIAS DEL MUNICIPIO SANTA BÁRBARA (Municipio Lug_COD = 241)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Bárbara','Parroquia',115, 241);

-- PARROQUIAS DEL MUNICIPIO SOTILLO (Municipio Lug_COD = 242)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Barrancas','Parroquia',120, 242);

-- PARROQUIAS DEL MUNICIPIO URACOA (Municipio Lug_COD = 243)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Uracoa','Parroquia',95, 243);



-- PARROQUIAS DEL MUNICIPIO ANTOLÍN DEL CAMPO (Municipio Lug_COD = 244)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Plaza de Paraguachí','Parroquia',50, 244);

-- PARROQUIAS DEL MUNICIPIO ARISMENDI (Municipio Lug_COD = 245)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Asunción','Parroquia',55, 245);

-- PARROQUIAS DEL MUNICIPIO DÍAZ (Municipio Lug_COD = 246)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Juan Bautista','Parroquia',60, 246);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Zabala','Parroquia',65, 246);

-- PARROQUIAS DEL MUNICIPIO GARCÍA (Municipio Lug_COD = 247)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Valle del Espíritu Santo','Parroquia',70, 247);

-- PARROQUIAS DEL MUNICIPIO GÓMEZ (Municipio Lug_COD = 248)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Ana','Parroquia',75, 248);

-- PARROQUIAS DEL MUNICIPIO MANEIRO (Municipio Lug_COD = 249)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Pampatar','Parroquia',80, 249);

-- PARROQUIAS DEL MUNICIPIO MARCANO (Municipio Lug_COD = 250)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Juan Griego','Parroquia',85, 250);

-- PARROQUIAS DEL MUNICIPIO MARIÑO (Municipio Lug_COD = 251)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Porlamar','Parroquia',90, 251);

-- PARROQUIAS DEL MUNICIPIO PENÍNSULA DE MACANAO (Municipio Lug_COD = 252)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Boca del Río','Parroquia',95, 252);

-- PARROQUIAS DEL MUNICIPIO TUBORES (Municipio Lug_COD = 253)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Punta de Piedras','Parroquia',100, 253);

-- PARROQUIAS DEL MUNICIPIO VILLALBA (Municipio Lug_COD = 254)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Pedro de Coche','Parroquia',105, 254);

-- PARROQUIAS DEL MUNICIPIO AGUA BLANCA (Municipio Lug_COD = 255)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Agua Blanca','Parroquia',50, 255);

-- PARROQUIAS DEL MUNICIPIO ARAURE (Municipio Lug_COD = 256)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Araure','Parroquia',55, 256);

-- PARROQUIAS DEL MUNICIPIO ESTELLER (Municipio Lug_COD = 257)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Píritu','Parroquia',60, 257);

-- PARROQUIAS DEL MUNICIPIO GUANARE (Municipio Lug_COD = 258)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Guanare','Parroquia',65, 258);

-- PARROQUIAS DEL MUNICIPIO GUANARITO (Municipio Lug_COD = 259)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Guanarito','Parroquia',70, 259);

-- PARROQUIAS DEL MUNICIPIO MONSEÑOR JOSÉ VICENTE DE UNDA (Municipio Lug_COD = 260)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Chabasquén','Parroquia',75, 260);

-- PARROQUIAS DEL MUNICIPIO OSPINO (Municipio Lug_COD = 261)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Ospino','Parroquia',80, 261);

-- PARROQUIAS DEL MUNICIPIO PÁEZ (Municipio Lug_COD = 262)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Acarigua','Parroquia',85, 262);

-- PARROQUIAS DEL MUNICIPIO PAPELÓN (Municipio Lug_COD = 263)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Papelón','Parroquia',90, 263);

-- PARROQUIAS DEL MUNICIPIO SAN GENARO DE BOCONOITO (Municipio Lug_COD = 264)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Boconoito','Parroquia',95, 264);

-- PARROQUIAS DEL MUNICIPIO SAN RAFAEL DE ONOTO (Municipio Lug_COD = 265)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Rafael de Onoto','Parroquia',100, 265);

-- PARROQUIAS DEL MUNICIPIO SANTA ROSALÍA (Municipio Lug_COD = 266)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Playón','Parroquia',105, 266);

-- PARROQUIAS DEL MUNICIPIO ANDRÉS ELOY BLANCO (Municipio Lug_COD = 267)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Casanay','Parroquia',50, 267);

-- PARROQUIAS DEL MUNICIPIO ANDRÉS MATA (Municipio Lug_COD = 268)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San José de Aerocuar','Parroquia',55, 268);

-- PARROQUIAS DEL MUNICIPIO ARISMENDI (Municipio Lug_COD = 269)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Río Caribe','Parroquia',60, 269);

-- PARROQUIAS DEL MUNICIPIO BENÍTEZ (Municipio Lug_COD = 270)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Pilar','Parroquia',65, 270);

-- PARROQUIAS DEL MUNICIPIO BERMÚDEZ (Municipio Lug_COD = 271)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Carúpano','Parroquia',70, 271);

-- PARROQUIAS DEL MUNICIPIO BOLÍVAR (Municipio Lug_COD = 272)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Marigüitar','Parroquia',75, 272);

-- PARROQUIAS DEL MUNICIPIO CAJIGAL (Municipio Lug_COD = 273)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Yaguaraparo','Parroquia',80, 273);

-- PARROQUIAS DEL MUNICIPIO CRUZ SALMERÓN ACOSTA (Municipio Lug_COD = 274)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Araya','Parroquia',85, 274);

-- PARROQUIAS DEL MUNICIPIO LIBERTADOR (Municipio Lug_COD = 275)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Tunapuy','Parroquia',90, 275);

-- PARROQUIAS DEL MUNICIPIO MARIÑO (Municipio Lug_COD = 276)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Irapa','Parroquia',95, 276);

-- PARROQUIAS DEL MUNICIPIO MEJÍA (Municipio Lug_COD = 277)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Antonio de Capayacuar','Parroquia',100, 277);

-- PARROQUIAS DEL MUNICIPIO MONTES (Municipio Lug_COD = 278)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cumanacoa','Parroquia',105, 278);

-- PARROQUIAS DEL MUNICIPIO RIBERO (Municipio Lug_COD = 279)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cariaco','Parroquia',110, 279);

-- PARROQUIAS DEL MUNICIPIO SUCRE (Municipio Lug_COD = 280)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cumaná','Parroquia',115, 280);

-- PARROQUIAS DEL MUNICIPIO VALDEZ (Municipio Lug_COD = 281)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Güiria','Parroquia',120, 281);

-- PARROQUIAS DEL MUNICIPIO VILLARROEL (Municipio Lug_COD = 282)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Punta de Piedras','Parroquia',95, 282);

-- PARROQUIAS DEL MUNICIPIO BOLÍVAR (Municipio Lug_COD = 283)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Marigüitar','Parroquia',100, 283);

-- PARROQUIAS DEL MUNICIPIO RAÚL LEONI (Municipio Lug_COD = 284)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Tumeremo','Parroquia',105, 284);

-- PARROQUIAS DEL MUNICIPIO CRISTÓBAL COLÓN (Municipio Lug_COD = 285)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cristóbal Colón','Parroquia',110, 285);

-- PARROQUIAS DEL MUNICIPIO FRANCISCO DE MIRANDA (Municipio Lug_COD = 286)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Francisco de Miranda','Parroquia',115, 286);


-- PARROQUIAS DEL MUNICIPIO ANDRÉS BELLO (Municipio Lug_COD = 287)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cordero','Parroquia',50, 287);

-- PARROQUIAS DEL MUNICIPIO ANTONIO RÓMULO COSTA (Municipio Lug_COD = 288)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Las Mesas','Parroquia',55, 288);

-- PARROQUIAS DEL MUNICIPIO AYACUCHO (Municipio Lug_COD = 289)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Colón','Parroquia',60, 289);

-- PARROQUIAS DEL MUNICIPIO BOLÍVAR (Municipio Lug_COD = 290)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Antonio del Táchira','Parroquia',65, 290);

-- PARROQUIAS DEL MUNICIPIO CÁRDENAS (Municipio Lug_COD = 291)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Táriba','Parroquia',70, 291);

-- PARROQUIAS DEL MUNICIPIO CÓRDOBA (Municipio Lug_COD = 292)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Ana del Táchira','Parroquia',75, 292);

-- PARROQUIAS DEL MUNICIPIO FERNÁNDEZ FEO (Municipio Lug_COD = 293)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Rafael del Piñal','Parroquia',80, 293);

-- PARROQUIAS DEL MUNICIPIO FRANCISCO DE MIRANDA (Municipio Lug_COD = 294)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San José de Bolívar','Parroquia',85, 294);

-- PARROQUIAS DEL MUNICIPIO GARCÍA DE HEVIA (Municipio Lug_COD = 295)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Fría','Parroquia',90, 295);

-- PARROQUIAS DEL MUNICIPIO GUÁSIMOS (Municipio Lug_COD = 296)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Palmira','Parroquia',95, 296);

-- PARROQUIAS DEL MUNICIPIO INDEPENDENCIA (Municipio Lug_COD = 297)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Capacho Nuevo','Parroquia',100, 297);

-- PARROQUIAS DEL MUNICIPIO JÁUREGUI (Municipio Lug_COD = 298)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Grita','Parroquia',105, 298);

-- PARROQUIAS DEL MUNICIPIO JOSÉ MARÍA VARGAS (Municipio Lug_COD = 299)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Cobre','Parroquia',110, 299);

-- PARROQUIAS DEL MUNICIPIO JUNÍN (Municipio Lug_COD = 300)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Rubio','Parroquia',115, 300);

-- PARROQUIAS DEL MUNICIPIO LIBERTAD (Municipio Lug_COD = 301)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Capacho Viejo','Parroquia',120, 301);

-- PARROQUIAS DEL MUNICIPIO LIBERTADOR (Municipio Lug_COD = 302)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Abejales','Parroquia',95, 302);

-- PARROQUIAS DEL MUNICIPIO PANAMERICANO (Municipio Lug_COD = 303)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Coloncito','Parroquia',100, 303);

-- PARROQUIAS DEL MUNICIPIO PEDRO MARÍA UREÑA (Municipio Lug_COD = 304)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Ureña','Parroquia',105, 304);

-- PARROQUIAS DEL MUNICIPIO RAFAEL URDANETA (Municipio Lug_COD = 305)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Delicias','Parroquia',110, 305);

-- PARROQUIAS DEL MUNICIPIO SAMUEL DARÍO MALDONADO (Municipio Lug_COD = 306)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Tendida','Parroquia',115, 306);

-- PARROQUIAS DEL MUNICIPIO SAN CRISTÓBAL (Municipio Lug_COD = 307)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Cristóbal','Parroquia',120, 307);


-- ESTADO TRUJILLO (L_ID del estado: 31)

-- MUNICIPIO ANDRÉS BELLO (Lug_COD = 308)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Isabel','Parroquia',120,308);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Araguaney','Parroquia',95,308);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Jaguito','Parroquia',135,308);

-- MUNICIPIO BOCONÓ (Lug_COD = 309)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Boconó','Parroquia',140,309);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Carmen','Parroquia',110,309);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Mosquey','Parroquia',125,309);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Miguel','Parroquia',85,309);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Rafael','Parroquia',130,309);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Buranda','Parroquia',100,309);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('General Rivas','Parroquia',145,309);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Guaramacal','Parroquia',90,309);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Vega de Guaramacal','Parroquia',115,309);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Monseñor Jáuregui','Parroquia',105,309);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Rafael Rangel','Parroquia',150,309);

-- MUNICIPIO BOLÍVAR (Lug_COD = 310)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Sabana Grande','Parroquia',125,310);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cheregüé','Parroquia',95,310);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Granados','Parroquia',135,310);

-- MUNICIPIO CANDELARIA (Lug_COD = 311)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Chejendé','Parroquia',140,311);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Arnoldo Gabaldón','Parroquia',100,311);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Carrillo','Parroquia',115,311);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Mesa de Esnujaque','Parroquia',130,311);

-- MUNICIPIO CARACHE (Lug_COD = 312)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Carache','Parroquia',90,312);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Concepción','Parroquia',125,312);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Panamericana','Parroquia',105,312);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Cruz','Parroquia',145,312);

-- MUNICIPIO ESCUQUE (Lug_COD = 313)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Escuque','Parroquia',115,313);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Unión','Parroquia',135,313);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Genaro','Parroquia',100,313);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Rita','Parroquia',140,313);

-- MUNICIPIO JOSÉ FELIPE MÁRQUEZ CAÑIZALES (Lug_COD = 314)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Paradero','Parroquia',120,314);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Regreso','Parroquia',95,314);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Los Caprichos','Parroquia',130,314);

-- MUNICIPIO JUAN VICENTE CAMPO ELÍAS (Lug_COD = 315)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Campo Elías','Parroquia',110,315);

-- MUNICIPIO LA CEIBA (Lug_COD = 316)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Apolonia','Parroquia',125,316);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Ceiba','Parroquia',90,316);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Progreso','Parroquia',135,316);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Tres de Febrero','Parroquia',105,316);

-- MUNICIPIO MIRANDA (Lug_COD = 317)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Dividive','Parroquia',140,317);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Agua Santa','Parroquia',115,317);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Agua Caliente','Parroquia',95,317);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Cenizo','Parroquia',130,317);

-- MUNICIPIO MONTE CARMELO (Lug_COD = 318)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Monte Carmelo','Parroquia',100,318);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Buena Vista','Parroquia',145,318);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa María del Horcón','Parroquia',120,318);

-- MUNICIPIO MOTATÁN (Lug_COD = 319)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Motatán','Parroquia',135,319);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Baño','Parroquia',90,319);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Jalisco','Parroquia',125,319);

-- MUNICIPIO PAMPÁN (Lug_COD = 320)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Pampán','Parroquia',115,320);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Flor de Patria','Parroquia',140,320);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Paz','Parroquia',100,320);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Ana','Parroquia',130,320);

-- MUNICIPIO PAMPANITO (Lug_COD = 321)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Pampanito','Parroquia',95,321);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Pampanito II','Parroquia',125,321);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Concepción','Parroquia',110,321);

-- MUNICIPIO RAFAEL RANGEL (Lug_COD = 322)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Betijoque','Parroquia',135,322);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('José Gregorio Hernández','Parroquia',105,322);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Pueblita','Parroquia',120,322);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Los Cedros','Parroquia',145,322);

-- MUNICIPIO SAN RAFAEL DE CARVAJAL (Lug_COD = 323)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Carvajal','Parroquia',100,323);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Carache','Parroquia',115,323);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Campo Alegre','Parroquia',140,323);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Antonio Nicolás Briceño','Parroquia',95,323);

-- MUNICIPIO SUCRE (Lug_COD = 324)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Sabana de Mendoza','Parroquia',130,324);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Junín','Parroquia',105,324);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Valmore Rodríguez','Parroquia',120,324);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Panamericana','Parroquia',145,324);

-- MUNICIPIO TRUJILLO (Lug_COD = 325)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Trujillo','Parroquia',115,325);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Andrés Eloy Blanco','Parroquia',135,325);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cristóbal Mendoza','Parroquia',100,325);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Cruz Carrillo','Parroquia',125,325);

-- MUNICIPIO URDANETA (Lug_COD = 326)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Quebrada','Parroquia',140,326);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Jajó','Parroquia',95,326);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santiago','Parroquia',120,326);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Tuñame','Parroquia',105,326);

-- MUNICIPIO VALERA (Lug_COD = 327)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Mercedes Díaz','Parroquia',132,327);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Luis','Parroquia',118,327);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Juan Ignacio Montilla','Parroquia',94,327);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Puerta','Parroquia',147,327);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Mendoza del Valle de Momboy','Parroquia',103,327);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Carvajal','Parroquia',125,327);




-- MUNICIPIO VARGAS (Lug_COD = 328)

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Caraballeda','Parroquia',115,328);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Carayaca','Parroquia',140,328);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Carlos Soublette','Parroquia',95,328);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Caruao','Parroquia',125,328);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Catia La Mar','Parroquia',110,328);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Junko','Parroquia',135,328);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Guaira','Parroquia',100,328);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Macuto','Parroquia',145,328);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Maiquetía','Parroquia',120,328);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Naiguatá','Parroquia',90,328);
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Urimare','Parroquia',130,328);



-- ESTADO YARACUY (L_ID del estado: 34)

-- MUNICIPIO ARÍSTIDES BASTIDAS (Lug_COD = 329)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('San Pablo','Parroquia',115,329);

-- MUNICIPIO BOLÍVAR (Lug_COD = 330)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Aroa','Parroquia',140,330);

-- MUNICIPIO BRUZUAL (Lug_COD = 331)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Chivacoa','Parroquia',95,331);

-- MUNICIPIO COCOROTE (Lug_COD = 332)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Cocorote','Parroquia',125,332);

-- MUNICIPIO INDEPENDENCIA (Lug_COD = 333)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Independencia','Parroquia',110,333);

-- MUNICIPIO JOSÉ ANTONIO PÁEZ (Lug_COD = 334)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Sabana de Parra','Parroquia',135,334);

-- MUNICIPIO LA TRINIDAD (Lug_COD = 335)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Boraure','Parroquia',100,335);

-- MUNICIPIO MANUEL MONGE (Lug_COD = 336)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Yumare','Parroquia',145,336);

-- MUNICIPIO NIRGUA (Lug_COD = 337)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Nirgua','Parroquia',120,337);

-- MUNICIPIO PEÑA (Lug_COD = 338)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Yaritagua','Parroquia',90,338);

-- MUNICIPIO SAN FELIPE (Lug_COD = 339)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('San Felipe','Parroquia',130,339);

-- MUNICIPIO SUCRE (Lug_COD = 340)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Guama','Parroquia',105,340);

-- MUNICIPIO URACHICHE (Lug_COD = 341)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Urachiche','Parroquia',125,341);




-- ESTADO ZULIA (L_ID del estado: 35)

-- MUNICIPIO ALMIRANTE PADILLA (Lug_COD = 342)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('El Toro','Parroquia',115,342),
('Isla de Toas','Parroquia',140,342);

-- MUNICIPIO BARALT (Lug_COD = 343)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('San Timoteo','Parroquia',95,343),
('General Urdaneta','Parroquia',125,343),
('Libertador','Parroquia',110,343);

-- MUNICIPIO CABIMAS (Lug_COD = 344)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Ambrosio','Parroquia',135,344),
('Carmen Herrera','Parroquia',100,344),
('La Rosa','Parroquia',145,344);

-- MUNICIPIO CATATUMBO (Lug_COD = 345)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Encontrados','Parroquia',120,345);

-- MUNICIPIO COLÓN (Lug_COD = 346)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('San Carlos del Zulia','Parroquia',90,346);

-- MUNICIPIO FRANCISCO JAVIER PULGAR (Lug_COD = 347)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Carlos Quevedo','Parroquia',130,347);

-- MUNICIPIO JESÚS ENRIQUE LOSSADA (Lug_COD = 348)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('La Concepción','Parroquia',105,348);

-- MUNICIPIO JESÚS MARÍA SEMPRÚN (Lug_COD = 349)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Casigua El Cubo','Parroquia',125,349);

-- MUNICIPIO LA CAÑADA DE URDANETA (Lug_COD = 350)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('La Cañada','Parroquia',115,350);

-- MUNICIPIO LAGUNILLAS (Lug_COD = 351)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Ciudad Ojeda','Parroquia',140,351);

-- MUNICIPIO MACHÍQUES DE PERIJÁ (Lug_COD = 352)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Machiques','Parroquia',100,352);

-- MUNICIPIO MARA (Lug_COD = 353)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('San Rafael','Parroquia',135,353);

-- MUNICIPIO MARACAIBO (Lug_COD = 354)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Bolívar','Parroquia',95,354),
('Chiquinquirá','Parroquia',125,354),
('Coquivacoa','Parroquia',110,354),
('Idelfonso Vásquez','Parroquia',145,354),
('Juana de Ávila','Parroquia',120,354),
('Olegario Villalobos','Parroquia',100,354),
('Santa Lucía','Parroquia',130,354);

-- MUNICIPIO MIRANDA (Lug_COD = 355)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Los Puertos de Altagracia','Parroquia',115,355);

-- MUNICIPIO PAÉZ (Lug_COD = 356)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Sinamaica','Parroquia',140,356);

-- MUNICIPIO ROSARIO DE PERIJÁ (Lug_COD = 357)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('La Villa del Rosario','Parroquia',105,357);

-- MUNICIPIO SAN FRANCISCO (Lug_COD = 358)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('San Francisco','Parroquia',125,358);

-- MUNICIPIO SANTA RITA (Lug_COD = 359)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Santa Rita','Parroquia',90,359);

-- MUNICIPIO SIMÓN BOLÍVAR (Lug_COD = 360)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Tía Juana','Parroquia',135,360);

-- MUNICIPIO SUCRE (Lug_COD = 361)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Bobures','Parroquia',100,361);

-- MUNICIPIO VALMORE RODRÍGUEZ (Lug_COD = 362)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Bachaquero','Parroquia',145,362);

-- MUNICIPIO PADILLA (Lug_COD = 363)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('Isla de Toas','Parroquia',115,363);

-- MUNICIPIO JESÚS ENRIQUE LOSSADA (Lug_COD = 364)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD) VALUES
('La Concepción','Parroquia',120,364);



-- DISTRITO CAPITAL (L_ID del estado: 36)

-- MUNICIPIO LIBERTADOR (Lug_COD = 367)
INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Altagracia','Parroquia',115,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Candelaria','Parroquia',140,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Catedral','Parroquia',95,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Pastora','Parroquia',125,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Agustín','Parroquia',110,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San José','Parroquia',135,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Juan','Parroquia',100,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Rosalía','Parroquia',145,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Santa Teresa','Parroquia',120,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Sucre','Parroquia',90,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('23 de Enero','Parroquia',130,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Recreo','Parroquia',105,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Valle','Parroquia',125,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Coche','Parroquia',115,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Macarao','Parroquia',140,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Caricuao','Parroquia',100,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('Antímano','Parroquia',135,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('La Vega','Parroquia',95,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('San Pedro','Parroquia',120,367);

INSERT INTO Lugar (Lug_Nombre, Lug_Tipo, Lug_Cant_Milla, Lugar_Lug_COD)
VALUES ('El Paraíso','Parroquia',145,367);



-- Amazonas (12)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Luis','Alberto','Ramírez','Torres',TO_DATE('12 05 1990','DD MM YYYY'),'Casado',800,12);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('María','José','Fernández','Rivas',TO_DATE('23 07 1988','DD MM YYYY'),'Soltero',950,12);

-- Anzoátegui (13)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Pedro','Enrique','González','Martínez',TO_DATE('05 11 1982','DD MM YYYY'),'Casado',1100,13);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Ana','Carolina','Suárez','López',TO_DATE('17 02 1995','DD MM YYYY'),'Soltero',700,13);

-- Apure (14)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('José','Manuel','Castro','Morales',TO_DATE('09 09 1980','DD MM YYYY'),'Divorciado',600,14);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Laura','Beatriz','Hernández','Pérez',TO_DATE('21 01 1992','DD MM YYYY'),'Casado',850,14);

-- Aragua (15)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Carlos','Andrés','Pérez','Gómez',TO_DATE('15 03 1985','DD MM YYYY'),'Soltero',1200,15);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Sofía','Mariana','López','Rodríguez',TO_DATE('08 06 1993','DD MM YYYY'),'Casado',900,15);

-- Barinas (16)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Miguel','Ángel','Torres','Ramírez',TO_DATE('19 04 1987','DD MM YYYY'),'Soltero',750,16);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Valentina','Isabel','Martínez','Fernández',TO_DATE('30 08 1991','DD MM YYYY'),'Divorciado',880,16);

-- Bolívar (17)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Andrés','Felipe','Morales','Castro',TO_DATE('02 12 1984','DD MM YYYY'),'Casado',1000,17);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Gabriela','Alejandra','Rivas','Suárez',TO_DATE('25 10 1990','DD MM YYYY'),'Soltero',950,17);

-- Carabobo (18)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Jorge','Luis','Gómez','Pérez',TO_DATE('14 07 1983','DD MM YYYY'),'Divorciado',720,18);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Daniela','María','Rodríguez','Torres',TO_DATE('11 11 1994','DD MM YYYY'),'Casado',860,18);

-- Cojedes (19)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Ricardo','Antonio','Fernández','López',TO_DATE('06 01 1986','DD MM YYYY'),'Soltero',780,19);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Camila','Beatriz','Suárez','Martínez',TO_DATE('22 09 1992','DD MM YYYY'),'Casado',910,19);

-- Delta Amacuro (20)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Francisco','José','Ramírez','González',TO_DATE('03 03 1981','DD MM YYYY'),'Casado',970,20);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Paola','Andrea','Torres','Morales',TO_DATE('29 05 1989','DD MM YYYY'),'Soltero',890,20);

-- Falcón (21)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Héctor','Manuel','Castro','Rivas',TO_DATE('18 02 1988','DD MM YYYY'),'Soltero',760,21);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Natalia','Carolina','Pérez','Suárez',TO_DATE('07 07 1993','DD MM YYYY'),'Casado',930,21);

-- Guárico (22)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Samuel','Andrés','López','Fernández',TO_DATE('12 12 1985','DD MM YYYY'),'Divorciado',640,22);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Andrea','María','Rodríguez','Gómez',TO_DATE('04 04 1991','DD MM YYYY'),'Soltero',870,22);

-- Lara (23)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Manuel','Alejandro','Torres','Ramírez',TO_DATE('16 06 1982','DD MM YYYY'),'Casado',980,23);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Carolina','Isabel','Martínez','Suárez',TO_DATE('20 10 1990','DD MM YYYY'),'Soltero',940,23);

-- Mérida (24)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Felipe','José','Rivas','Castro',TO_DATE('09 09 1987','DD MM YYYY'),'Soltero',800,24);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Lucía','Beatriz','González','Pérez',TO_DATE('27 03 1992','DD MM YYYY'),'Casado',920,24);

-- Miranda (25)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Diego','Antonio','Morales','Torres',TO_DATE('01 01 1984','DD MM YYYY'),'Casado',1050,25);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Isabella','Mariana','Suárez','Ramírez',TO_DATE('15 05 1993','DD MM YYYY'),'Soltero',880,25);

-- Monagas (26)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Oscar','Luis','Fernández','Martínez',TO_DATE('22 08 1986','DD MM YYYY'),'Soltero',770,26);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Patricia','Alejandra','Pérez','Gómez',TO_DATE('19 12 1991','DD MM YYYY'),'Casado',910,26);

-- Nueva Esparta (27)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Eduardo','José','Rodríguez','Suárez',TO_DATE('05 05 1983','DD MM YYYY'),'Divorciado',690,27);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Mariana','Isabel','Torres','Fernández',TO_DATE('13 09 1990','DD MM YYYY'),'Soltero',850,27);

-- Portuguesa (28)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Alejandro','Manuel','Ramírez','Castro',TO_DATE('28 02 1985','DD MM YYYY'),'Casado',960,28);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Verónica','Carolina','López','Pérez',TO_DATE('17 07 1992','DD MM YYYY'),'Soltero',890,28);

-- Sucre (29)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Fernando','Luis','Martínez','Rivas',TO_DATE('11 11 1981','DD MM YYYY'),'Soltero',750,29);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Claudia','María','González','Torres',TO_DATE('25 04 1989','DD MM YYYY'),'Casado',920,29);

-- Táchira (30)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Rafael','José','Suárez','Morales',TO_DATE('07 07 1984','DD MM YYYY'),'Casado',1000,30);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Elena','Beatriz','Pérez','Ramírez',TO_DATE('30 10 1991','DD MM YYYY'),'Soltero',870,30);

-- Trujillo (31)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Martín','Andrés','Fernández','Castro',TO_DATE('14 02 1986','DD MM YYYY'),'Divorciado',680,31);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Gabriela','Alejandra','López','Suárez',TO_DATE('09 09 1993','DD MM YYYY'),'Soltero',910,31);

-- La Guaira (32)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Adrián','Antonio','Rodríguez','Martínez',TO_DATE('21 06 1985','DD MM YYYY'),'Soltero',780,32);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Paula','Isabel','Torres','Gómez',TO_DATE('02 12 1990','DD MM YYYY'),'Casado',940,32);

-- Yaracuy (33)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Esteban','Luis','Ramírez','Rivas',TO_DATE('08 08 1983','DD MM YYYY'),'Casado',970,33);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Daniela','María','Suárez','Fernández',TO_DATE('19 03 1992','DD MM YYYY'),'Soltero',860,33);

-- Zulia (34)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Hernán','José','Pérez','Castro',TO_DATE('27 07 1984','DD MM YYYY'),'Divorciado',700,34);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Camila','Alejandra','González','Ramírez',TO_DATE('15 11 1991','DD MM YYYY'),'Soltero',930,34);

-- Distrito Capital (35)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Alberto','Manuel','López','Suárez',TO_DATE('12 12 1982','DD MM YYYY'),'Casado',990,35);

INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
                     Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('María','Isabel','Fernández','Torres',TO_DATE('03 05 1990','DD MM YYYY'),'Soltero',880,35);






INSERT INTO Empleado (Emp_Primer_Nombre, Emp_Segundo_Nombre, Emp_Primer_Apellido, Emp_Segundo_Apellido)
VALUES ('Carlos','Andrés','Pérez','González');

INSERT INTO Empleado (Emp_Primer_Nombre, Emp_Segundo_Nombre, Emp_Primer_Apellido, Emp_Segundo_Apellido)
VALUES ('María','Isabel','Rodríguez','Torres');

INSERT INTO Empleado (Emp_Primer_Nombre, Emp_Segundo_Nombre, Emp_Primer_Apellido, Emp_Segundo_Apellido)
VALUES ('José','Antonio','Fernández','Suárez');

INSERT INTO Empleado (Emp_Primer_Nombre, Emp_Segundo_Nombre, Emp_Primer_Apellido, Emp_Segundo_Apellido)
VALUES ('Ana','Carolina','Gómez','Martínez');

INSERT INTO Empleado (Emp_Primer_Nombre, Emp_Segundo_Nombre, Emp_Primer_Apellido, Emp_Segundo_Apellido)
VALUES ('Luis','Alberto','Ramírez','Rivas');

INSERT INTO Empleado (Emp_Primer_Nombre, Emp_Segundo_Nombre, Emp_Primer_Apellido, Emp_Segundo_Apellido)
VALUES ('Sofía','Mariana','López','Morales');

INSERT INTO Empleado (Emp_Primer_Nombre, Emp_Segundo_Nombre, Emp_Primer_Apellido, Emp_Segundo_Apellido)
VALUES ('Miguel','Ángel','Castillo','Ortega');

INSERT INTO Empleado (Emp_Primer_Nombre, Emp_Segundo_Nombre, Emp_Primer_Apellido, Emp_Segundo_Apellido)
VALUES ('Patricia','Alejandra','Mejías','Vargas');

INSERT INTO Empleado (Emp_Primer_Nombre, Emp_Segundo_Nombre, Emp_Primer_Apellido, Emp_Segundo_Apellido)
VALUES ('Jorge','Luis','Salazar','Pacheco');

INSERT INTO Empleado (Emp_Primer_Nombre, Emp_Segundo_Nombre, Emp_Primer_Apellido, Emp_Segundo_Apellido)
VALUES ('Gabriela','Beatriz','Hernández','Domínguez');





INSERT INTO Promocion (Prom_Tipo, Prom_Fecha_Inicio, Prom_Fecha_Fin, Prom_Porcentaje)
VALUES ('Temporada Alta', TO_DATE('01 12 2025','DD MM YYYY'), TO_DATE('15 01 2026','DD MM YYYY'), 15.00);

INSERT INTO Promocion (Prom_Tipo, Prom_Fecha_Inicio, Prom_Fecha_Fin, Prom_Porcentaje)
VALUES ('Navidad', TO_DATE('20 12 2025','DD MM YYYY'), TO_DATE('27 12 2025','DD MM YYYY'), 20.00);

INSERT INTO Promocion (Prom_Tipo, Prom_Fecha_Inicio, Prom_Fecha_Fin, Prom_Porcentaje)
VALUES ('Año Nuevo', TO_DATE('28 12 2025','DD MM YYYY'), TO_DATE('05 01 2026','DD MM YYYY'), 25.00);

INSERT INTO Promocion (Prom_Tipo, Prom_Fecha_Inicio, Prom_Fecha_Fin, Prom_Porcentaje)
VALUES ('Carnaval', TO_DATE('10 02 2026','DD MM YYYY'), TO_DATE('15 02 2026','DD MM YYYY'), 18.00);

INSERT INTO Promocion (Prom_Tipo, Prom_Fecha_Inicio, Prom_Fecha_Fin, Prom_Porcentaje)
VALUES ('Semana Santa', TO_DATE('30 03 2026','DD MM YYYY'), TO_DATE('05 04 2026','DD MM YYYY'), 22.00);

INSERT INTO Promocion (Prom_Tipo, Prom_Fecha_Inicio, Prom_Fecha_Fin, Prom_Porcentaje)
VALUES ('Verano', TO_DATE('01 07 2026','DD MM YYYY'), TO_DATE('31 08 2026','DD MM YYYY'), 10.00);

INSERT INTO Promocion (Prom_Tipo, Prom_Fecha_Inicio, Prom_Fecha_Fin, Prom_Porcentaje)
VALUES ('Black Friday', TO_DATE('27 11 2026','DD MM YYYY'), TO_DATE('30 11 2026','DD MM YYYY'), 30.00);

INSERT INTO Promocion (Prom_Tipo, Prom_Fecha_Inicio, Prom_Fecha_Fin, Prom_Porcentaje)
VALUES ('Cyber Monday', TO_DATE('01 12 2026','DD MM YYYY'), TO_DATE('02 12 2026','DD MM YYYY'), 25.00);

INSERT INTO Promocion (Prom_Tipo, Prom_Fecha_Inicio, Prom_Fecha_Fin, Prom_Porcentaje)
VALUES ('Fiestas Patrias', TO_DATE('05 07 2026','DD MM YYYY'), TO_DATE('10 07 2026','DD MM YYYY'), 12.00);

INSERT INTO Promocion (Prom_Tipo, Prom_Fecha_Inicio, Prom_Fecha_Fin, Prom_Porcentaje)
VALUES ('Halloween', TO_DATE('28 10 2026','DD MM YYYY'), TO_DATE('31 10 2026','DD MM YYYY'), 17.00);





INSERT INTO Comida (Com_tipo, Com_Costo)
VALUES ('Desayuno Continental', 12.50);

INSERT INTO Comida (Com_tipo, Com_Costo)
VALUES ('Almuerzo Ejecutivo', 25.00);

INSERT INTO Comida (Com_tipo, Com_Costo)
VALUES ('Cena Gourmet', 40.00);

INSERT INTO Comida (Com_tipo, Com_Costo)
VALUES ('Buffet Internacional', 35.00);

INSERT INTO Comida (Com_tipo, Com_Costo)
VALUES ('Snack Ligero', 8.75);

INSERT INTO Comida (Com_tipo, Com_Costo)
VALUES ('Menú Infantil', 15.00);

INSERT INTO Comida (Com_tipo, Com_Costo)
VALUES ('Comida Vegetariana', 22.00);

INSERT INTO Comida (Com_tipo, Com_Costo)
VALUES ('Comida Vegana', 24.50);

INSERT INTO Comida (Com_tipo, Com_Costo)
VALUES ('Mariscos Especiales', 38.00);

INSERT INTO Comida (Com_tipo, Com_Costo)
VALUES ('Postre Gourmet', 10.00);



INSERT INTO Documento (Doc_Nombre, Doc_Numero_Identificacion, Doc_Fecha_Emision, Doc_Fecha_Vencimiento, Tipo_Documento_TP_COD)
VALUES ('Pasaporte Venezolano', 'A1234567', TO_DATE('01 01 2020','DD MM YYYY'), TO_DATE('01 01 2030','DD MM YYYY'), 1);

INSERT INTO Documento (Doc_Nombre, Doc_Numero_Identificacion, Doc_Fecha_Emision, Doc_Fecha_Vencimiento, Tipo_Documento_TP_COD)
VALUES ('Cédula de Identidad', 'V9876543', TO_DATE('15 03 2015','DD MM YYYY'), TO_DATE('15 03 2025','DD MM YYYY'), 2);

INSERT INTO Documento (Doc_Nombre, Doc_Numero_Identificacion, Doc_Fecha_Emision, Doc_Fecha_Vencimiento, Tipo_Documento_TP_COD)
VALUES ('Visa Turística USA', 'US543210', TO_DATE('10 06 2022','DD MM YYYY'), TO_DATE('10 06 2027','DD MM YYYY'), 3);

INSERT INTO Documento (Doc_Nombre, Doc_Numero_Identificacion, Doc_Fecha_Emision, Doc_Fecha_Vencimiento, Tipo_Documento_TP_COD)
VALUES ('Carnet de Conducir', 'C1122334', TO_DATE('20 08 2018','DD MM YYYY'), TO_DATE('20 08 2028','DD MM YYYY'), 4);

INSERT INTO Documento (Doc_Nombre, Doc_Numero_Identificacion, Doc_Fecha_Emision, Doc_Fecha_Vencimiento, Tipo_Documento_TP_COD)
VALUES ('Permiso de Viaje Menor', 'PM445566', TO_DATE('05 07 2023','DD MM YYYY'), TO_DATE('05 07 2024','DD MM YYYY'), 5);

INSERT INTO Documento (Doc_Nombre, Doc_Numero_Identificacion, Doc_Fecha_Emision, Doc_Fecha_Vencimiento, Tipo_Documento_TP_COD)
VALUES ('Certificado de Vacunación', 'CV778899', TO_DATE('12 09 2021','DD MM YYYY'), TO_DATE('12 09 2031','DD MM YYYY'), 6);

INSERT INTO Documento (Doc_Nombre, Doc_Numero_Identificacion, Doc_Fecha_Emision, Doc_Fecha_Vencimiento, Tipo_Documento_TP_COD)
VALUES ('Carnet de Estudiante', 'E5566778', TO_DATE('01 10 2022','DD MM YYYY'), TO_DATE('01 10 2026','DD MM YYYY'), 7);

INSERT INTO Documento (Doc_Nombre, Doc_Numero_Identificacion, Doc_Fecha_Emision, Doc_Fecha_Vencimiento, Tipo_Documento_TP_COD)
VALUES ('Constancia de Trabajo', 'CT334455', TO_DATE('15 01 2023','DD MM YYYY'), TO_DATE('15 01 2025','DD MM YYYY'), 8);

INSERT INTO Documento (Doc_Nombre, Doc_Numero_Identificacion, Doc_Fecha_Emision, Doc_Fecha_Vencimiento, Tipo_Documento_TP_COD)
VALUES ('Carnet Diplomático', 'D9988776', TO_DATE('20 11 2019','DD MM YYYY'), TO_DATE('20 11 2029','DD MM YYYY'), 9);

INSERT INTO Documento (Doc_Nombre, Doc_Numero_Identificacion, Doc_Fecha_Emision, Doc_Fecha_Vencimiento, Tipo_Documento_TP_COD)
VALUES ('Documento Nacional Extranjero', 'NE223344', TO_DATE('02 02 2017','DD MM YYYY'), TO_DATE('02 02 2027','DD MM YYYY'), 10);



-- Francia (Lug_COD = 6)
INSERT INTO Compania_Crucero (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, CC_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Mediterranean Cruise Line', 'Port de Marseille, Francia', 33014567890, 'info@medcruiseline.fr', TO_DATE('12 06 1985','DD MM YYYY'), 6);

-- Brasil (Lug_COD = 7)
INSERT INTO Compania_Crucero (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, CC_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Amazon River Cruises', 'Av. Beira Rio, Manaus, Brasil', 55092133445, 'reservas@amazonrivercruises.com.br', TO_DATE('20 08 1992','DD MM YYYY'), 7);

-- Venezuela (Lug_COD = 8)
INSERT INTO Compania_Crucero (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, CC_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Caribe Cruises', 'Av. Principal de La Castellana, Caracas', 58212555123, 'contacto@caribecruises.com.ve', TO_DATE('15 03 1995','DD MM YYYY'), 8);

-- Japón (Lug_COD = 9)
INSERT INTO Compania_Crucero (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, CC_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Pacific Sunrise Cruises', 'Yokohama Port, Japón', 81356789012, 'contact@pacificsunrise.jp', TO_DATE('05 05 2000','DD MM YYYY'), 9);

-- Sudáfrica (Lug_COD = 10)
INSERT INTO Compania_Crucero (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, CC_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Cape Horizon Cruises', 'Victoria & Alfred Waterfront, Ciudad del Cabo, Sudáfrica', 27021456789, 'ventas@capehorizon.co.za', TO_DATE('18 11 1998','DD MM YYYY'), 10);

-- Australia (Lug_COD = 11)
INSERT INTO Compania_Crucero (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, CC_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Coral Reef Cruises', 'Circular Quay, Sydney, Australia', 61029876543, 'service@coralreefcruises.com.au', TO_DATE('01 02 1990','DD MM YYYY'), 11);

OPERADOR TURÍSTICO

-- Francia (6)
INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Paris Travel Experts', 'Rue de Rivoli 123, París', 33014567890, 'contact@paristravelexperts.fr', 6);

INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Loire Valley Tours', 'Av. des Châteaux, Tours', 33024567891, 'info@loirevalleytours.fr', 6);

-- Brasil (7)
INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Rio Adventure', 'Av. Atlântica 456, Copacabana, Río de Janeiro', 55092133445, 'reservas@rioadventure.com.br', 7);

INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Amazon Explorer', 'Rua Manaus 789, Manaus', 55092133446, 'contact@amazonexplorer.com.br', 7);

-- Venezuela (8)
INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Caracas Travel', 'Av. Libertador 321, Caracas', 58212555123, 'info@caracastravel.com.ve', 8);

INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Los Roques Tours', 'Calle Principal, Gran Roque', 58212555124, 'reservas@losroquestours.com.ve', 8);

-- Japón (9)
INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Tokyo Experience', 'Shinjuku, Tokyo', 81356789012, 'service@tokyoexperience.jp', 9);

INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Kyoto Heritage Tours', 'Gion District, Kyoto', 81356789013, 'contact@kyotoheritage.jp', 9);

-- Sudáfrica (10)
INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Cape Safari', 'Waterfront, Ciudad del Cabo', 27021456789, 'info@capesafari.co.za', 10);

-- Australia (11)
INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Sydney Coastal Tours', 'Circular Quay, Sydney', 61029876543, 'contact@sydneycoastaltours.com.au', 11);

-- Francia (6)
INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Normandy Tours', 'Rue Jeanne d’Arc, Rouen', 33054567894, 'info@normandytours.fr', 6);

INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Bordeaux Wine Travel', 'Cours de l’Intendance, Bordeaux', 33064567895, 'contact@bordeauxwinetravel.fr', 6);

-- Brasil (7)
INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Pantanal Explorer', 'Av. Mato Grosso, Cuiabá', 55092133449, 'info@pantanalexplorer.com.br', 7);

INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Bahia Sun Tours', 'Av. Sete de Setembro, Salvador', 55092133450, 'reservas@bahiasuntours.com.br', 7);

-- Venezuela (8)
INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Margarita Island Travel', 'Av. Santiago Mariño, Porlamar', 58212555127, 'info@margaritatravel.com.ve', 8);

INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Andes Adventure', 'Av. Las Américas, Mérida', 58212555128, 'contact@andesadventure.com.ve', 8);

-- Japón (9)
INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Mount Fuji Tours', 'Kawaguchiko, Yamanashi', 81356789016, 'info@mountfujitours.jp', 9);

INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Nara Heritage Travel', 'Nara Park, Nara', 81356789017, 'contact@naraheritage.jp', 9);

-- Sudáfrica (10)
INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Kruger Safari Tours', 'Kruger National Park, Mpumalanga', 27021456793, 'info@krugersafari.co.za', 10);

-- Australia (11)
INSERT INTO Operador_Turistico (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Great Barrier Reef Travel', 'Cairns Marina, Queensland', 61029876551, 'service@greatbarrierreeftravel.com.au', 11);



-- Francia (6) → 4 aerolíneas
INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Air France', '45 Rue de Paris, París', 33014567890, 'contact@airfrance.fr', TO_DATE('07 10 1933','DD MM YYYY'), 6);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Paris Airlines', 'Av. Charles de Gaulle, París', 33024567891, 'info@parisairlines.fr', TO_DATE('15 05 1980','DD MM YYYY'), 6);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Riviera Air', 'Promenade des Anglais, Niza', 33034567892, 'service@rivieraair.fr', TO_DATE('20 03 1995','DD MM YYYY'), 6);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Lyon Connect', 'Rue Bellecour, Lyon', 33044567893, 'contact@lyonconnect.fr', TO_DATE('01 01 2005','DD MM YYYY'), 6);

-- Brasil (7) → 4 aerolíneas
INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('LATAM Brasil', 'Av. Paulista 1000, São Paulo', 55092133445, 'reservas@latam.com.br', TO_DATE('01 01 1976','DD MM YYYY'), 7);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Rio Airlines', 'Av. Atlântica 456, Río de Janeiro', 55092133446, 'contact@rioairlines.com.br', TO_DATE('20 08 1990','DD MM YYYY'), 7);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Amazonas Air', 'Rua Manaus 789, Manaus', 55092133447, 'info@amazonasair.com.br', TO_DATE('10 10 2005','DD MM YYYY'), 7);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Gol Linhas Aéreas', 'Av. Paulista, São Paulo', 55092133448, 'contact@gol.com.br', TO_DATE('15 01 2001','DD MM YYYY'), 7);

-- Venezuela (8) → 4 aerolíneas
INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Conviasa', 'Av. Francisco de Miranda, Caracas', 58212555123, 'info@conviasa.com.ve', TO_DATE('30 11 2004','DD MM YYYY'), 8);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Avior Airlines', 'Av. Intercomunal, Barcelona', 58212555124, 'contact@avior.com.ve', TO_DATE('10 12 1994','DD MM YYYY'), 8);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Laser Airlines', 'Av. Libertador, Caracas', 58212555125, 'ventas@laserairlines.com.ve', TO_DATE('11 09 1993','DD MM YYYY'), 8);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Rutaca Airlines', 'Av. Bolívar, Ciudad Bolívar', 58212555126, 'service@rutaca.com.ve', TO_DATE('01 01 1974','DD MM YYYY'), 8);

-- Japón (9) → 4 aerolíneas
INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Japan Airlines', 'Shinjuku, Tokyo', 81356789012, 'info@jal.co.jp', TO_DATE('01 08 1951','DD MM YYYY'), 9);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('All Nippon Airways', 'Minato, Tokyo', 81356789013, 'contact@ana.co.jp', TO_DATE('27 12 1952','DD MM YYYY'), 9);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Skymark Airlines', 'Haneda Airport, Tokyo', 81356789014, 'info@skymark.jp', TO_DATE('12 09 1996','DD MM YYYY'), 9);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Tokyo Connect', 'Shibuya, Tokyo', 81356789015, 'service@tokyoconnect.jp', TO_DATE('01 01 2010','DD MM YYYY'), 9);

-- Sudáfrica (10) → 4 aerolíneas
INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('South African Airways', 'O.R. Tambo Airport, Johannesburgo', 27021456789, 'info@flysaa.co.za', TO_DATE('01 02 1934','DD MM YYYY'), 10);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Cape Air', 'Victoria & Alfred Waterfront, Ciudad del Cabo', 27021456790, 'contact@capeair.co.za', TO_DATE('15 06 1985','DD MM YYYY'), 10);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Safari Airlines', 'Durban Airport, Durban', 27021456791, 'service@safariair.co.za', TO_DATE('05 05 2001','DD MM YYYY'), 10);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Johannesburg Express', 'Sandton, Johannesburgo', 27021456792, 'contact@joburgexpress.co.za', TO_DATE('12 12 2008','DD MM YYYY'), 10);

-- Australia (11) → 4 aerolíneas
INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Qantas Airways', 'George Street, Sydney', 61029876543, 'info@qantas.com.au', TO_DATE('16 11 1920','DD MM YYYY'), 11);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Virgin Australia', 'Collins Street, Melbourne', 61029876544, 'contact@virginaustralia.com.au', TO_DATE('31 08 2000','DD MM YYYY'), 11);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Coral Coast Airlines', 'Cairns Airport, Queensland', 61029876549, 'info@coralcoastair.com.au', TO_DATE('05 09 2012','DD MM YYYY'), 11);

INSERT INTO Aerolinea (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
VALUES ('Sydney Connect Airways', 'Circular Quay, Sydney', 61029876550, 'service@sydneyconnect.com.au', TO_DATE('22 11 2008','DD MM YYYY'), 11);




-- Francia (6) → 4 compañías
INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Paris Bus Lines', 'Rue de Rivoli 123, París', 33014567890, 'info@parisbus.fr', 6);

INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Lyon Metro Transport', 'Place Bellecour, Lyon', 33024567891, 'contact@lyonmetro.fr', 6);

INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Riviera Coaches', 'Promenade des Anglais, Niza', 33034567892, 'service@rivieracoaches.fr', 6);

INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Marseille Transit', 'Port de Marseille, Francia', 33044567893, 'reservas@marseilletransit.fr', 6);

-- Brasil (7) → 4 compañías
INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Rio Bus Company', 'Av. Atlântica 456, Río de Janeiro', 55092133445, 'info@riobus.com.br', 7);

INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('São Paulo Metro', 'Av. Paulista 1000, São Paulo', 55092133446, 'contact@spmetro.com.br', 7);

INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Amazonas Transportes', 'Rua Manaus 789, Manaus', 55092133447, 'service@amazonastransp.com.br', 7);

INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Nordeste Coaches', 'Av. Beira Mar, Fortaleza', 55092133448, 'ventas@nordestecoaches.com.br', 7);

-- Venezuela (8) → 4 compañías
INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Caracas Metro', 'Av. Libertador, Caracas', 58212555123, 'info@metrocaracas.com.ve', 8);

INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Expresos Occidente', 'Av. Bolívar, Barquisimeto', 58212555124, 'contact@expresosoccidente.com.ve', 8);

INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Rodovías de Venezuela', 'Av. Urdaneta, Caracas', 58212555125, 'service@rodovias.com.ve', 8);

INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Los Llanos Transport', 'Av. Apure, San Fernando', 58212555126, 'ventas@llanostransport.com.ve', 8);

-- Japón (9) → 4 compañías
INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Tokyo Metro', 'Shinjuku, Tokyo', 81356789012, 'info@tokyometro.jp', 9);

INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Kyoto Bus Service', 'Gion District, Kyoto', 81356789013, 'contact@kyotobus.jp', 9);

INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Osaka Transit', 'Namba, Osaka', 81356789014, 'service@osakatransit.jp', 9);

INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Hokkaido Coaches', 'Sapporo Station, Hokkaido', 81356789015, 'ventas@hokkaidocoaches.jp', 9);

-- Sudáfrica (10) → 2 compañías
INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Cape Town Transit', 'Waterfront, Ciudad del Cabo', 27021456789, 'info@capetowntransit.co.za', 10);

INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Johannesburg Metro', 'Sandton, Johannesburgo', 27021456790, 'contact@joburgmetro.co.za', 10);

-- Australia (11) → 2 compañías
INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Sydney Metro', 'George Street, Sydney', 61029876543, 'info@sydneymetro.com.au', 11);

INSERT INTO Compania_Transporte_Terrestre (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Melbourne Transit', 'Collins Street, Melbourne', 61029876544, 'contact@melbournetransit.com.au', 11);



-- Francia (6)
INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Hotel Paris Central', 'Rue de Rivoli 123, París', 33014567890, 'info@hotelpariscentral.fr', 6);

INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Lyon Palace Hotel', 'Place Bellecour, Lyon', 33024567891, 'contact@lyonpalace.fr', 6);

-- Brasil (7)
INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Rio Beach Resort', 'Av. Atlântica 456, Río de Janeiro', 55092133445, 'reservas@riobeachresort.com.br', 7);

INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('São Paulo Grand Hotel', 'Av. Paulista 1000, São Paulo', 55092133446, 'info@spgrandhotel.com.br', 7);

-- Venezuela (8)
INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Hotel Caracas Plaza', 'Av. Libertador, Caracas', 58212555123, 'contact@hotelcaracasplaza.com.ve', 8);

INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Hotel Margarita Suites', 'Av. Santiago Mariño, Porlamar', 58212555124, 'info@margaritasuites.com.ve', 8);

-- Japón (9)
INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Tokyo Imperial Hotel', 'Shinjuku, Tokyo', 81356789012, 'service@tokyoimperial.jp', 9);

INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Kyoto Garden Hotel', 'Gion District, Kyoto', 81356789013, 'contact@kyotogarden.jp', 9);

-- Sudáfrica (10)
INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Cape Town Ocean View', 'Waterfront, Ciudad del Cabo', 27021456789, 'info@capetownoceanview.co.za', 10);

INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Johannesburg City Hotel', 'Sandton, Johannesburgo', 27021456790, 'contact@joburgcityhotel.co.za', 10);

-- Sudáfrica (10)
INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Durban Beach Hotel', 'Durban Station, Durban', 27021456791, 'info@durbanbeachhotel.co.za', 10);

INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Pretoria Central Hotel', 'Church Street, Pretoria', 27021456792, 'contact@pretoriacentral.co.za', 10);

-- Australia (11)
INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Sydney Harbour Hotel', 'Circular Quay, Sydney', 61029876547, 'info@sydneyharbourhotel.com.au', 11);

INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Melbourne City Hotel', 'Collins Street, Melbourne', 61029876548, 'contact@melbournecityhotel.com.au', 11);

INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Brisbane River Hotel', 'Brisbane Central Station, Brisbane', 61029876549, 'service@brisbaneriverhotel.com.au', 11);

INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Perth Grand Hotel', 'Perth Station, Perth', 61029876550, 'ventas@perthgrandhotel.com.au', 11);

-- Francia (6) adicionales
INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Nice Seaside Hotel', 'Promenade des Anglais, Niza', 33054567894, 'info@niceseaside.fr', 6);

-- Brasil (7) adicionales
INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Fortaleza Beach Hotel', 'Av. Beira Mar, Fortaleza', 55092133449, 'contact@fortalezabeachhotel.com.br', 7);

-- Venezuela (8) adicionales
INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Hotel Andes Plaza', 'Av. Las Américas, Mérida', 58212555127, 'info@andesplaza.com.ve', 8);

-- Japón (9) adicionales
INSERT INTO Hotel (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, Lugar_Lug_COD)
VALUES ('Osaka Bay Hotel', 'Namba, Osaka', 81356789016, 'contact@osakabayhotel.jp', 9);



-- Usuario Cliente con Rol Cliente (Cliente 1)
INSERT INTO Usuario (Usu_Correo, Usu_Contrasena, Usu_Primer_Nombre, Usu_Segundo_Nombre, Usu_Primer_Apellido, Usu_Segundo_Apellido,
                     Cliente_Cli_COD, Compania_Crucero, Operador_Turistico, Aerolinea, Transporte_Terrestre, Hotel, Empleado_Emp_COD, Rol_Rol_COD)
VALUES ('cliente1@mail.com', 'cli12345', 'Luis', 'Alberto', 'Ramírez', 'Torres',
        1, NULL, NULL, NULL, NULL, NULL, NULL, 2);

-- Usuario Cliente con Rol Cliente (Cliente 2)
INSERT INTO Usuario (Usu_Correo, Usu_Contrasena, Usu_Primer_Nombre, Usu_Segundo_Nombre, Usu_Primer_Apellido, Usu_Segundo_Apellido,
                     Cliente_Cli_COD, Compania_Crucero, Operador_Turistico, Aerolinea, Transporte_Terrestre, Hotel, Empleado_Emp_COD, Rol_Rol_COD)
VALUES ('cliente2@mail.com', 'cli67890', 'María', 'José', 'Fernández', 'Rivas',
        2, NULL, NULL, NULL, NULL, NULL, NULL, 2);

-- Usuario vinculado a Compañía de Crucero con Rol Proveedor
INSERT INTO Usuario (Usu_Correo, Usu_Contrasena, Usu_Primer_Nombre, Usu_Segundo_Nombre, Usu_Primer_Apellido, Usu_Segundo_Apellido,
                     Cliente_Cli_COD, Compania_Crucero, Operador_Turistico, Aerolinea, Transporte_Terrestre, Hotel, Empleado_Emp_COD, Rol_Rol_COD)
VALUES ('crucero1@mail.com', 'cruise123', 'Carlos', 'Andrés', 'Suárez', 'Mendoza',
        NULL, 1, NULL, NULL, NULL, NULL, 1, 4);

-- Usuario vinculado a Aerolínea con Rol Proveedor
INSERT INTO Usuario (Usu_Correo, Usu_Contrasena, Usu_Primer_Nombre, Usu_Segundo_Nombre, Usu_Primer_Apellido, Usu_Segundo_Apellido,
                     Cliente_Cli_COD, Compania_Crucero, Operador_Turistico, Aerolinea, Transporte_Terrestre, Hotel, Empleado_Emp_COD, Rol_Rol_COD)
VALUES ('airline1@mail.com', 'fly12345', 'Ana', 'Lucía', 'Gómez', 'Pérez',
        NULL, NULL, NULL, 1, NULL, NULL, 2, 4);

-- Usuario vinculado a Transporte Terrestre con Rol Proveedor
INSERT INTO Usuario (Usu_Correo, Usu_Contrasena, Usu_Primer_Nombre, Usu_Segundo_Nombre, Usu_Primer_Apellido, Usu_Segundo_Apellido,
                     Cliente_Cli_COD, Compania_Crucero, Operador_Turistico, Aerolinea, Transporte_Terrestre, Hotel, Empleado_Emp_COD, Rol_Rol_COD)
VALUES ('bus1@mail.com', 'bus12345', 'José', 'Manuel', 'Martínez', 'López',
        NULL, NULL, NULL, NULL, 1, NULL, 3, 4);

-- Usuario vinculado a Operador Turístico con Rol Proveedor
INSERT INTO Usuario (Usu_Correo, Usu_Contrasena, Usu_Primer_Nombre, Usu_Segundo_Nombre, Usu_Primer_Apellido, Usu_Segundo_Apellido,
                     Cliente_Cli_COD, Compania_Crucero, Operador_Turistico, Aerolinea, Transporte_Terrestre, Hotel, Empleado_Emp_COD, Rol_Rol_COD)
VALUES ('tour1@mail.com', 'tour1234', 'Miguel', 'Ángel', 'Rodríguez', 'Castro',
        NULL, NULL, 1, NULL, NULL, NULL, 4, 4);

-- Usuario vinculado a Hotel con Rol Proveedor
INSERT INTO Usuario (Usu_Correo, Usu_Contrasena, Usu_Primer_Nombre, Usu_Segundo_Nombre, Usu_Primer_Apellido, Usu_Segundo_Apellido,
                     Cliente_Cli_COD, Compania_Crucero, Operador_Turistico, Aerolinea, Transporte_Terrestre, Hotel, Empleado_Emp_COD, Rol_Rol_COD)
VALUES ('hotel1@mail.com', 'hotel123', 'Sofía', 'Beatriz', 'Morales', 'Jiménez',
        NULL, NULL, NULL, NULL, NULL, 1, 5, 4);

-- Usuario Empleado con Rol Administrador
INSERT INTO Usuario (Usu_Correo, Usu_Contrasena, Usu_Primer_Nombre, Usu_Segundo_Nombre, Usu_Primer_Apellido, Usu_Segundo_Apellido,
                     Cliente_Cli_COD, Compania_Crucero, Operador_Turistico, Aerolinea, Transporte_Terrestre, Hotel, Empleado_Emp_COD, Rol_Rol_COD)
VALUES ('admin1@mail.com', 'admin123', 'Pedro', 'Luis', 'Hernández', 'Salazar',
        NULL, NULL, NULL, NULL, NULL, NULL, 6, 1);

-- Usuario Empleado con Rol Gerente
INSERT INTO Usuario (Usu_Correo, Usu_Contrasena, Usu_Primer_Nombre, Usu_Segundo_Nombre, Usu_Primer_Apellido, Usu_Segundo_Apellido,
                     Cliente_Cli_COD, Compania_Crucero, Operador_Turistico, Aerolinea, Transporte_Terrestre, Hotel, Empleado_Emp_COD, Rol_Rol_COD)
VALUES ('gerente1@mail.com', 'geren123', 'Laura', 'Isabel', 'Paredes', 'García',
        NULL, NULL, NULL, NULL, NULL, NULL, 7, 5);

-- Usuario Empleado con Rol Supervisor
INSERT INTO Usuario (Usu_Correo, Usu_Contrasena, Usu_Primer_Nombre, Usu_Segundo_Nombre, Usu_Primer_Apellido, Usu_Segundo_Apellido,
                     Cliente_Cli_COD, Compania_Crucero, Operador_Turistico, Aerolinea, Transporte_Terrestre, Hotel, Empleado_Emp_COD, Rol_Rol_COD)
VALUES ('super1@mail.com', 'super123', 'Andrés', 'Felipe', 'Cordero', 'Ramírez',
        NULL, NULL, NULL, NULL, NULL, NULL, 8, 6);




-- Aviones para Air France (Aerolinea Pro_COD = 1)
INSERT INTO Avion (Avi_Tipo, Avi_Capacidad, Aerolinea_Pro_COD)
VALUES ('Airbus A320', 180, 1);

INSERT INTO Avion (Avi_Tipo, Avi_Capacidad, Aerolinea_Pro_COD)
VALUES ('Boeing 777-300ER', 396, 1);

-- Aviones para LATAM Brasil (Aerolinea Pro_COD = 5)
INSERT INTO Avion (Avi_Tipo, Avi_Capacidad, Aerolinea_Pro_COD)
VALUES ('Airbus A321', 220, 5);

INSERT INTO Avion (Avi_Tipo, Avi_Capacidad, Aerolinea_Pro_COD)
VALUES ('Boeing 767-300', 270, 5);

-- Aviones para Conviasa (Aerolinea Pro_COD = 9)
INSERT INTO Avion (Avi_Tipo, Avi_Capacidad, Aerolinea_Pro_COD)
VALUES ('Embraer E190', 114, 9);

INSERT INTO Avion (Avi_Tipo, Avi_Capacidad, Aerolinea_Pro_COD)
VALUES ('Boeing 737-300', 148, 9);

-- Aviones para Japan Airlines (Aerolinea Pro_COD = 13)
INSERT INTO Avion (Avi_Tipo, Avi_Capacidad, Aerolinea_Pro_COD)
VALUES ('Boeing 787-9 Dreamliner', 290, 13);

INSERT INTO Avion (Avi_Tipo, Avi_Capacidad, Aerolinea_Pro_COD)
VALUES ('Airbus A350-900', 300, 13);

-- Aviones para Qantas Airways (Aerolinea Pro_COD = 17)
INSERT INTO Avion (Avi_Tipo, Avi_Capacidad, Aerolinea_Pro_COD)
VALUES ('Boeing 747-400', 416, 17);

INSERT INTO Avion (Avi_Tipo, Avi_Capacidad, Aerolinea_Pro_COD)
VALUES ('Airbus A380-800', 525, 17);


-- Mediterranean Cruise Line (Pro_COD = 1)
INSERT INTO Barco (Bar_Nombre, Bar_Capacidad, Compania_Crucero_Pro_COD)
VALUES ('Mediterranean Star', 2500, 1);

INSERT INTO Barco (Bar_Nombre, Bar_Capacidad, Compania_Crucero_Pro_COD)
VALUES ('Blue Horizon', 2200, 1);

-- Amazon River Cruises (Pro_COD = 2)
INSERT INTO Barco (Bar_Nombre, Bar_Capacidad, Compania_Crucero_Pro_COD)
VALUES ('Amazon Explorer', 800, 2);

INSERT INTO Barco (Bar_Nombre, Bar_Capacidad, Compania_Crucero_Pro_COD)
VALUES ('Rainforest Spirit', 950, 2);

-- Caribe Cruises (Pro_COD = 3)
INSERT INTO Barco (Bar_Nombre, Bar_Capacidad, Compania_Crucero_Pro_COD)
VALUES ('Caribbean Dream', 2700, 3);

INSERT INTO Barco (Bar_Nombre, Bar_Capacidad, Compania_Crucero_Pro_COD)
VALUES ('Island Majesty', 2400, 3);

-- Pacific Sunrise Cruises (Pro_COD = 4)
INSERT INTO Barco (Bar_Nombre, Bar_Capacidad, Compania_Crucero_Pro_COD)
VALUES ('Pacific Sunrise I', 3000, 4);

INSERT INTO Barco (Bar_Nombre, Bar_Capacidad, Compania_Crucero_Pro_COD)
VALUES ('Oriental Pearl', 2800, 4);

-- Cape Horizon Cruises (Pro_COD = 5)
INSERT INTO Barco (Bar_Nombre, Bar_Capacidad, Compania_Crucero_Pro_COD)
VALUES ('Cape Voyager', 2600, 5);

INSERT INTO Barco (Bar_Nombre, Bar_Capacidad, Compania_Crucero_Pro_COD)
VALUES ('Southern Breeze', 2300, 5);



-- Vehículos para Paris Bus Lines (Francia, Pro_COD = 1)
INSERT INTO Vehiculo (Veh_Capacidad, Compania_Transporte_Terrestre_Pro_COD)
VALUES (50, 1);

INSERT INTO Vehiculo (Veh_Capacidad, Compania_Transporte_Terrestre_Pro_COD)
VALUES (45, 1);

-- Vehículos para Lyon Metro Transport (Francia, Pro_COD = 2)
INSERT INTO Vehiculo (Veh_Capacidad, Compania_Transporte_Terrestre_Pro_COD)
VALUES (30, 2);

INSERT INTO Vehiculo (Veh_Capacidad, Compania_Transporte_Terrestre_Pro_COD)
VALUES (55, 2);

-- Vehículos para Riviera Coaches (Francia, Pro_COD = 3)
INSERT INTO Vehiculo (Veh_Capacidad, Compania_Transporte_Terrestre_Pro_COD)
VALUES (40, 3);

INSERT INTO Vehiculo (Veh_Capacidad, Compania_Transporte_Terrestre_Pro_COD)
VALUES (60, 3);

-- Vehículos para Marseille Transit (Francia, Pro_COD = 4)
INSERT INTO Vehiculo (Veh_Capacidad, Compania_Transporte_Terrestre_Pro_COD)
VALUES (25, 4);

INSERT INTO Vehiculo (Veh_Capacidad, Compania_Transporte_Terrestre_Pro_COD)
VALUES (50, 4);

-- Vehículos para Rio Bus Company (Brasil, Pro_COD = 5)
INSERT INTO Vehiculo (Veh_Capacidad, Compania_Transporte_Terrestre_Pro_COD)
VALUES (35, 5);

INSERT INTO Vehiculo (Veh_Capacidad, Compania_Transporte_Terrestre_Pro_COD)
VALUES (45, 5);



-- Tarjeta de Crédito
INSERT INTO Metodo_de_Pago (Tipo, Num_Tarjeta, Cod_Seguridad, Emisor, Marca, Fecha_Vencimiento, Nombre_Titular, Monto)
VALUES ('Tarjeta_Credito', 4111111111111111, 123, 'Banco de Venezuela', 'Visa', '2027-05-31', 'Ana Gómez', 250.75);

-- Tarjeta de Débito
INSERT INTO Metodo_de_Pago (Tipo, Num_Tarjeta, Cod_Seguridad, Emisor, Marca, Fecha_Vencimiento, Nombre_Titular, Monto)
VALUES ('Tarjeta_Debito', 5222222222222222, 456, 'Banco Provincial', 'MasterCard', '2026-11-30', 'Luis Ramírez', 120.50);

-- Cheque
INSERT INTO Metodo_de_Pago (Tipo, Num_Cheque, Banco_Emisor, Fecha_Emision, Monto)
VALUES ('Cheque', 10000001, 'Banco Mercantil', '2025-12-01', 500.00);

-- Efectivo
INSERT INTO Metodo_de_Pago (Tipo, Tipo_Moneda, Monto)
VALUES ('Efectivo', 'USD', 80.00);

-- Efectivo
INSERT INTO Metodo_de_Pago (Tipo, Tipo_Moneda, Monto)
VALUES ('Efectivo', 'USD', 90.00);

-- Criptomonedas
INSERT INTO Metodo_de_Pago (Tipo, Id_Transaccion, Fecha_Hora, Monto, Tipo_Moneda)
VALUES ('Criptomonedas', 'BTC123456', '2025-12-09 10:30:00', 0.005, 'BTC');

-- Billetera Digital - Zelle
INSERT INTO Metodo_de_Pago (Tipo, Num_Confirmacion, Monto_Billetera, Banco, Fecha, Num_Referencia)
VALUES ('Zelle', 90000000001, 200.00, 'Bank of America', '2025-12-08', 70000000001);

-- Billetera Digital - PayPal
INSERT INTO Metodo_de_Pago (Tipo, Num_Confirmacion, Monto_Billetera, Banco, Fecha, Num_Referencia)
VALUES ('PayPal', 90000000002, 75.50, 'PayPal Holdings', '2025-12-08', 70000000002);

-- Billetera Digital - Zinli
INSERT INTO Metodo_de_Pago (Tipo, Num_Confirmacion, Monto_Billetera, Banco, Fecha, Num_Referencia)
VALUES ('Zinli', 90000000003, 40.00, 'Zinli Bank', '2025-12-08', 70000000003);

-- Billetera Digital - Pago Móvil
INSERT INTO Metodo_de_Pago (Tipo, Num_Confirmacion, Monto_Billetera, Banco, Fecha, Num_Referencia, Cod_Cuenta_Cliente)
VALUES ('Pago_Movil', 90000000004, 150.00, 'Banco de Venezuela', '2025-12-08', 70000000004, 1234567);




-- Cliente 1 - Vuelo
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (2001, 120, '2025-12-09 08:30:00', '10A', 1, 300.00, 330.00);

-- Cliente 2 - Crucero
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (2002, 250, '2025-12-09 09:00:00', 'B201', 2, 1500.00, 1650.00);

-- Cliente 3 - Transporte terrestre
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (2003, 60, '2025-12-09 09:30:00', 'T12', 3, 40.00, 45.00);

-- Cliente 4 - Vuelo
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (2004, 180, '2025-12-09 10:00:00', '15C', 4, 450.00, 495.00);

-- Cliente 5 - Crucero
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (2005, 300, '2025-12-09 10:30:00', 'C305', 5, 1200.00, 1320.00);

-- Cliente 6 - Transporte terrestre
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (2006, 45, '2025-12-09 11:00:00', 'A07', 6, 25.00, 28.00);

-- Cliente 7 - Vuelo
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (2007, 200, '2025-12-09 11:30:00', '22B', 7, 600.00, 660.00);

-- Cliente 8 - Crucero
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (2008, 280, '2025-12-09 12:00:00', 'D410', 8, 1350.00, 1485.00);

-- Cliente 9 - Transporte terrestre
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (2009, 55, '2025-12-09 12:30:00', 'B09', 9, 35.00, 39.00);

-- Cliente 10 - Vuelo
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (2010, 150, '2025-12-09 13:00:00', '18D', 10, 380.00, 418.00);

-- Cliente 11 → (Vuelo)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1027, 160, '2025-12-10 09:00:00', '11A', 11, 320.00, 350.00);

-- Cliente 12 → (Crucero)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1028, 280, '2025-12-10 09:30:00', 'C201', 12, 1000.00, 1100.00);

-- Cliente 13 → (Transporte terrestre)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1029, 55, '2025-12-10 10:00:00', 'T12', 13, 35.00, 40.00);

-- Cliente 14 → (Vuelo)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1030, 190, '2025-12-10 10:30:00', '14C', 14, 420.00, 460.00);

-- Cliente 15 → (Crucero)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1031, 310, '2025-12-10 11:00:00', 'D301', 15, 1250.00, 1380.00);

-- Cliente 16 → (Transporte terrestre)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1032, 65, '2025-12-10 11:30:00', 'B05', 16, 45.00, 50.00);

-- Cliente 17 → (Vuelo)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1033, 175, '2025-12-10 12:00:00', '16B', 17, 360.00, 395.00);

-- Cliente 18 → Reserva 34 (Crucero)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1034, 295, '2025-12-10 12:30:00', 'E401', 18, 1300.00, 1450.00);

-- Cliente 19 → Reserva 35 (Transporte terrestre)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1035, 48, '2025-12-10 13:00:00', 'C09', 19, 28.00, 32.00);

-- Cliente 20 → Reserva 36 (Vuelo)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1036, 185, '2025-12-10 13:30:00', '10D', 20, 410.00, 450.00);

-- Cliente 21 → Reserva 37 (Crucero)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1037, 305, '2025-12-10 14:00:00', 'F501', 21, 1350.00, 1500.00);

-- Cliente 22 → Reserva 38 (Transporte terrestre)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1038, 52, '2025-12-10 14:30:00', 'A07', 22, 32.00, 36.00);

-- Cliente 23 → Reserva 39 (Vuelo)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1039, 165, '2025-12-10 15:00:00', '18A', 23, 340.00, 375.00);

-- Cliente 24 → Reserva 40 (Crucero)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1040, 325, '2025-12-10 15:30:00', 'G601', 24, 1450.00, 1600.00);

-- Cliente 25 → Reserva 41 (Transporte terrestre)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1041, 58, '2025-12-10 16:00:00', 'D11', 25, 38.00, 42.00);

-- Cliente 26 → Reserva 42 (Vuelo)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1042, 195, '2025-12-10 16:30:00', '19C', 26, 430.00, 470.00);

-- Cliente 27 → Reserva 43 (Crucero)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1043, 315, '2025-12-10 17:00:00', 'H701', 27, 1400.00, 1550.00);

-- Cliente 28 → Reserva 44 (Transporte terrestre)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1044, 47, '2025-12-10 17:30:00', 'B08', 28, 27.00, 31.00);

-- Cliente 29 → Reserva 45 (Vuelo)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1045, 155, '2025-12-10 18:00:00', '20B', 29, 310.00, 345.00);

-- Cliente 30 → Reserva 46 (Crucero)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1046, 300, '2025-12-11 09:00:00', 'C301', 30, 1200.00, 1350.00);

-- Cliente 31 → Reserva 47 (Transporte terrestre)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1047, 55, '2025-12-11 09:30:00', 'T15', 31, 40.00, 45.00);

-- Cliente 32 → Reserva 48 (Vuelo)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1048, 180, '2025-12-11 10:00:00', '12C', 32, 380.00, 420.00);

-- Cliente 33 → Reserva 49 (Crucero)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1049, 310, '2025-12-11 10:30:00', 'D401', 33, 1300.00, 1450.00);

-- Cliente 34 → Reserva 50 (Transporte terrestre)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1050, 60, '2025-12-11 11:00:00', 'B10', 34, 35.00, 40.00);

-- Cliente 35 → Reserva 51 (Vuelo)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1051, 200, '2025-12-11 11:30:00', '14A', 35, 450.00, 490.00);

-- Cliente 36 → Reserva 52 (Crucero)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1052, 280, '2025-12-11 12:00:00', 'E501', 36, 1100.00, 1200.00);

-- Cliente 37 → Reserva 53 (Transporte terrestre)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1053, 45, '2025-12-11 12:30:00', 'C07', 37, 25.00, 30.00);

-- Cliente 38 → Reserva 54 (Vuelo)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1054, 170, '2025-12-11 13:00:00', '16D', 38, 360.00, 395.00);

-- Cliente 39 → Reserva 55 (Crucero)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1055, 320, '2025-12-11 13:30:00', 'F601', 39, 1400.00, 1550.00);

-- Cliente 40 → Reserva 56 (Transporte terrestre)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1056, 50, '2025-12-11 14:00:00', 'A09', 40, 30.00, 35.00);

-- Cliente 41 → Reserva 57 (Vuelo)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1057, 185, '2025-12-11 14:30:00', '18B', 41, 400.00, 440.00);

-- Cliente 42 → Reserva 58 (Crucero)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1058, 305, '2025-12-11 15:00:00', 'G701', 42, 1350.00, 1500.00);

-- Cliente 43 → Reserva 59 (Transporte terrestre)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1059, 42, '2025-12-11 15:30:00', 'D13', 43, 22.00, 26.00);

-- Cliente 44 → Reserva 60 (Vuelo)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1060, 195, '2025-12-11 16:00:00', '20C', 44, 430.00, 470.00);

-- Cliente 45 → Reserva 61 (Crucero)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1061, 315, '2025-12-11 16:30:00', 'H801', 45, 1450.00, 1600.00);

-- Cliente 46 → Reserva 62 (Transporte terrestre)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Transporte, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1062, 60, '2025-12-11 17:00:00', 'B11', 46, 40.00, 45.00);

-- Cliente 47 → Reserva 63 (Vuelo)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Asiento_Vuelo, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1063, 175, '2025-12-11 17:30:00', '22A', 47, 370.00, 405.00);

-- Cliente 48 → Reserva 64 (Crucero)
INSERT INTO Reserva (Res_Numero_Reserva, Res_Milla_Obtenida, Res_Fecha_Hora, Res_Camarote, Cliente_Cli_COD, Res_Subtotal, Res_Total)
VALUES (1064, 330, '2025-12-11 18:00:00', 'I901', 48, 1500.00, 1650.00);



-- Cliente 1 → Reserva 1
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Carlos','Andrés','Pérez','González','1990-05-12','Soltero',1,1);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('María','Isabel','Rodríguez','Torres','1992-07-20','Casado',1,1);

-- Cliente 2 → Reserva 2
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('José','Antonio','Fernández','Suárez','1985-03-15','Soltero',2,2);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Ana','Carolina','Gómez','Martínez','1988-11-25','Casado',2,2);

-- Cliente 3 → Reserva 3
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Luis','Alberto','Ramírez','Rivas','1995-01-10','Soltero',3,3);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Sofía','Mariana','López','Morales','1997-09-18','Casado',3,3);

-- Cliente 4 → Reserva 4
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Miguel','Ángel','Castillo','Ortega','1983-04-22','Divorciado',4,4);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Patricia','Alejandra','Mejías','Vargas','1986-12-05','Casado',4,4);

-- Cliente 5 → Reserva 5
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Jorge','Luis','Salazar','Pacheco','1991-02-14','Soltero',5,5);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Gabriela','Beatriz','Hernández','Domínguez','1994-06-30','Casado',5,5);

-- Cliente 6 → Reserva 6
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Ricardo','Manuel','Torres','López','1989-08-21','Soltero',6,6);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Elena','María','Suárez','García','1993-10-12','Casado',6,6);

-- Cliente 7 → Reserva 7
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Fernando','José','Martínez','Ruiz','1987-07-07','Soltero',7,7);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Claudia','Patricia','Ramírez','Torres','1990-12-19','Casado',7,7);

-- Cliente 8 → Reserva 8
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Andrés','Felipe','González','Mendoza','1984-05-03','Divorciado',8,8);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Valeria','Cristina','Morales','Pérez','1989-09-25','Casado',8,8);

-- Cliente 9 → Reserva 9
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Diego','Armando','Vargas','Soto','1996-01-17','Soltero',9,9);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Camila','Andrea','López','Fernández','1998-11-08','Casado',9,9);

-- Cliente 10 → Reserva 10
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Sebastián','David','Ortega','Ramírez','1982-03-11','Soltero',10,10);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Natalia','Verónica','Castro','Jiménez','1985-07-28','Casado',10,10);

-- Cliente 11 → Reserva 11
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Héctor','Luis','Martínez','Gómez','1992-02-14','Soltero',11,11);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Paola','Andrea','Fernández','Rivas','1994-06-30','Casado',11,11);

-- Cliente 12 → Reserva 12
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Mauricio','José','Ramírez','Torres','1988-09-12','Soltero',12,12);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Daniela','Cristina','Suárez','Morales','1991-11-25','Casado',12,12);

-- Cliente 13 → Reserva 13
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Felipe','Andrés','García','Mendoza','1985-04-18','Soltero',13,13);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Lorena','Patricia','Vargas','Pérez','1987-07-22','Casado',13,13);

-- Cliente 14 → Reserva 14
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Oscar','Manuel','Hernández','Ruiz','1990-01-05','Soltero',14,14);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Verónica','Alejandra','Castillo','Torres','1993-08-19','Casado',14,14);

-- Cliente 15 → Reserva 15
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Raúl','Antonio','Gómez','Martínez','1986-03-11','Soltero',15,15);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Mónica','Isabel','Salazar','Rivas','1989-12-02','Casado',15,15);

-- Cliente 16 → Reserva 16
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Alberto','José','Ramírez','Suárez','1984-06-14','Soltero',16,16);

INSERT INTO Pasajero (
  Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
  Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD
)
VALUES ('Mariana','Elena','Suárez','Gómez','1987-02-23','Casado',16,16);

-- Cliente 17 → Reserva 17
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Martín','Alejandro','Gómez','Pérez','1990-03-12','Soltero',17,17);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Lucía','Beatriz','Ramírez','Torres','1992-07-20','Casado',17,17);

-- Cliente 18 → Reserva 18
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Javier','Andrés','Fernández','Suárez','1985-05-15','Soltero',18,18);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Carolina','Isabel','García','Martínez','1988-11-25','Casado',18,18);

-- Cliente 19 → Reserva 19
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Diego','Manuel','López','Rivas','1995-01-10','Soltero',19,19);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Paola','Cristina','Morales','Suárez','1997-09-18','Casado',19,19);

-- Cliente 20 → Reserva 20
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Hugo','Ángel','Castillo','Ortega','1983-04-22','Divorciado',20,20);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Patricia','Alejandra','Mejías','Vargas','1986-12-05','Casado',20,20);

-- Cliente 21 → Reserva 21
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Jorge','Luis','Salazar','Pacheco','1991-02-14','Soltero',21,21);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Gabriela','Beatriz','Hernández','Domínguez','1994-06-30','Casado',21,21);

-- Cliente 22 → Reserva 22
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Ricardo','Manuel','Torres','López','1989-08-21','Soltero',22,22);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Elena','María','Suárez','García','1993-10-12','Casado',22,22);

-- Cliente 23 → Reserva 23
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Fernando','José','Martínez','Ruiz','1987-07-07','Soltero',23,23);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Claudia','Patricia','Ramírez','Torres','1990-12-19','Casado',23,23);

-- Cliente 24 → Reserva 24
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Andrés','Felipe','González','Mendoza','1984-05-03','Divorciado',24,24);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Valeria','Cristina','Morales','Pérez','1989-09-25','Casado',24,24);

-- Cliente 25 → Reserva 25
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Diego','Armando','Vargas','Soto','1996-01-17','Soltero',25,25);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Camila','Andrea','López','Fernández','1998-11-08','Casado',25,25);

-- Cliente 26 → Reserva 26
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Sebastián','David','Ortega','Ramírez','1982-03-11','Soltero',26,26);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Natalia','Verónica','Castro','Jiménez','1985-07-28','Casado',26,26);

-- Cliente 27 → Reserva 27
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Héctor','Luis','Martínez','Gómez','1992-02-14','Soltero',27,27);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Paola','Andrea','Fernández','Rivas','1994-06-30','Casado',27,27);

-- Cliente 28 → Reserva 28
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Mauricio','José','Ramírez','Torres','1988-09-12','Soltero',28,28);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Daniela','Cristina','Suárez','Morales','1991-11-25','Casado',28,28);

-- Cliente 29 → Reserva 29
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Felipe','Andrés','García','Mendoza','1985-04-18','Soltero',29,29);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Lorena','Patricia','Vargas','Pérez','1987-07-22','Casado',29,29);

-- Cliente 30 → Reserva 30
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Oscar','Manuel','Hernández','Ruiz','1990-01-05','Soltero',30,30);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Verónica','Alejandra','Castillo','Torres','1993-08-19','Casado',30,30);

-- Cliente 31 → Reserva 31
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Raúl','Antonio','Gómez','Martínez','1986-03-11','Soltero',31,31);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Mónica','Isabel','Salazar','Rivas','1989-12-02','Casado',31,31);

-- Cliente 32 → Reserva 32
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Alberto','José','Ramírez','Suárez','1984-06-14','Soltero',32,32);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Mariana','Elena','Suárez','Gómez','1987-02-23','Casado',32,32);

-- Cliente 33 → Reserva 33
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Mario','Andrés','González','Pérez','1988-04-12','Soltero',33,33);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Laura','Beatriz','Ramírez','Torres','1991-07-20','Casado',33,33);

-- Cliente 34 → Reserva 34
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Julián','Antonio','Fernández','Suárez','1985-03-15','Soltero',34,34);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Andrea','Carolina','Gómez','Martínez','1989-11-25','Casado',34,34);

-- Cliente 35 → Reserva 35
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Luis','Alberto','Ramírez','Rivas','1992-01-10','Soltero',35,35);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Sofía','Mariana','López','Morales','1994-09-18','Casado',35,35);

-- Cliente 36 → Reserva 36
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Miguel','Ángel','Castillo','Ortega','1983-04-22','Divorciado',36,36);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Patricia','Alejandra','Mejías','Vargas','1986-12-05','Casado',36,36);

-- Cliente 37 → Reserva 37
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Jorge','Luis','Salazar','Pacheco','1991-02-14','Soltero',37,37);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Gabriela','Beatriz','Hernández','Domínguez','1994-06-30','Casado',37,37);

-- Cliente 38 → Reserva 38
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Ricardo','Manuel','Torres','López','1989-08-21','Soltero',38,38);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Elena','María','Suárez','García','1993-10-12','Casado',38,38);

-- Cliente 39 → Reserva 39
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Fernando','José','Martínez','Ruiz','1987-07-07','Soltero',39,39);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Claudia','Patricia','Ramírez','Torres','1990-12-19','Casado',39,39);

-- Cliente 40 → Reserva 40
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Andrés','Felipe','González','Mendoza','1984-05-03','Divorciado',40,40);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Valeria','Cristina','Morales','Pérez','1989-09-25','Casado',40,40);

-- Cliente 41 → Reserva 41
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Diego','Armando','Vargas','Soto','1996-01-17','Soltero',41,41);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Camila','Andrea','López','Fernández','1998-11-08','Casado',41,41);

-- Cliente 42 → Reserva 42
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Sebastián','David','Ortega','Ramírez','1982-03-11','Soltero',42,42);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Natalia','Verónica','Castro','Jiménez','1985-07-28','Casado',42,42);

-- Cliente 43 → Reserva 43
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Héctor','Luis','Martínez','Gómez','1992-02-14','Soltero',43,43);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Paola','Andrea','Fernández','Rivas','1994-06-30','Casado',43,43);

-- Cliente 44 → Reserva 44
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Mauricio','José','Ramírez','Torres','1988-09-12','Soltero',44,44);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Daniela','Cristina','Suárez','Morales','1991-11-25','Casado',44,44);

-- Cliente 45 → Reserva 45
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Felipe','Andrés','García','Mendoza','1985-04-18','Soltero',45,45);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Lorena','Patricia','Vargas','Pérez','1987-07-22','Casado',45,45);

-- Cliente 46 → Reserva 46
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Oscar','Manuel','Hernández','Ruiz','1990-01-05','Soltero',46,46);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido,
Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Verónica','Alejandra','Castillo','Torres','1993-08-19','Casado',46,46);

-- Cliente 47 → Reserva 47
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, 
Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Raúl','Antonio','Gómez','Martínez','1986-03-11','Soltero',47,47);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, 
Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Mónica','Isabel','Salazar','Rivas','1989-12-02','Casado',47,47);

-- Cliente 48 → Reserva 48
INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, 
Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Alberto','José','Ramírez','Suárez','1984-06-14','Soltero',48,48);

INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, 
Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil, Cliente_Cli_COD, Reserva_Res_COD)
VALUES ('Mariana','Elena','Suárez','Gómez','1987-02-23','Casado',48,48);



-- Parque 1
INSERT INTO Servicio_Adicional (SA_Tipo, SA_Nombre, Operador_Turistico_Pro_COD, SA_Descripcion, SA_Costo, SA_Cant_Milla, SA_Fecha_Hora_Inicio, SA_Fecha_Hora_Fin)
VALUES ('Parque','Parque Nacional Canaima',1,'Excursión guiada por tepuyes y saltos de agua',250.00,50,'2025-12-15 08:00:00','2025-12-15 18:00:00');

-- Parque 2
INSERT INTO Servicio_Adicional (SA_Tipo, SA_Nombre, Operador_Turistico_Pro_COD, SA_Descripcion, SA_Costo, SA_Cant_Milla, SA_Fecha_Hora_Inicio, SA_Fecha_Hora_Fin)
VALUES ('Parque','Parque Waraira Repano',2,'Senderismo y teleférico hacia la cima del Ávila',120.00,30,'2025-12-16 09:00:00','2025-12-16 17:00:00');

-- Parque 3
INSERT INTO Servicio_Adicional (SA_Tipo, SA_Nombre, Operador_Turistico_Pro_COD, SA_Descripcion, SA_Costo, SA_Cant_Milla, SA_Fecha_Hora_Inicio, SA_Fecha_Hora_Fin)
VALUES ('Parque','Parque Morrocoy',3,'Visita a cayos y playas del parque nacional',180.00,40,'2025-12-17 08:30:00','2025-12-17 16:30:00');

-- Parque 4
INSERT INTO Servicio_Adicional (SA_Tipo, SA_Nombre, Operador_Turistico_Pro_COD, SA_Descripcion, SA_Costo, SA_Cant_Milla, SA_Fecha_Hora_Inicio, SA_Fecha_Hora_Fin)
VALUES ('Parque','Parque Sierra Nevada',4,'Recorrido por montañas y lagunas andinas',200.00,45,'2025-12-18 07:00:00','2025-12-18 15:00:00');

-- Parque 5
INSERT INTO Servicio_Adicional (SA_Tipo, SA_Nombre, Operador_Turistico_Pro_COD, SA_Descripcion, SA_Costo, SA_Cant_Milla, SA_Fecha_Hora_Inicio, SA_Fecha_Hora_Fin)
VALUES ('Parque','Parque Mochima',5,'Tour marítimo por islas y bahías',170.00,35,'2025-12-19 09:00:00','2025-12-19 17:00:00');

-- Parque 6
INSERT INTO Servicio_Adicional (SA_Tipo, SA_Nombre, Operador_Turistico_Pro_COD, SA_Descripcion, SA_Costo, SA_Cant_Milla, SA_Fecha_Hora_Inicio, SA_Fecha_Hora_Fin)
VALUES ('Parque','Parque La Llovizna',6,'Visita guiada a cascadas y miradores',90.00,20,'2025-12-20 10:00:00','2025-12-20 14:00:00');

-- Parque 7
INSERT INTO Servicio_Adicional (SA_Tipo, SA_Nombre, Operador_Turistico_Pro_COD, SA_Descripcion, SA_Costo, SA_Cant_Milla, SA_Fecha_Hora_Inicio, SA_Fecha_Hora_Fin)
VALUES ('Parque','Parque El Guácharo',7,'Excursión a la cueva y fauna local',150.00,30,'2025-12-21 08:00:00','2025-12-21 13:00:00');

-- Parque 8
INSERT INTO Servicio_Adicional (SA_Tipo, SA_Nombre, Operador_Turistico_Pro_COD, SA_Descripcion, SA_Costo, SA_Cant_Milla, SA_Fecha_Hora_Inicio, SA_Fecha_Hora_Fin)
VALUES ('Parque','Parque Yurubí',8,'Senderismo y observación de aves',80.00,15,'2025-12-22 07:30:00','2025-12-22 12:30:00');

-- Parque 9
INSERT INTO Servicio_Adicional (SA_Tipo, SA_Nombre, Operador_Turistico_Pro_COD, SA_Descripcion, SA_Costo, SA_Cant_Milla, SA_Fecha_Hora_Inicio, SA_Fecha_Hora_Fin)
VALUES ('Parque','Parque San Esteban',9,'Recorrido histórico y natural por el parque',110.00,25,'2025-12-23 09:00:00','2025-12-23 15:00:00');

-- Parque 10
INSERT INTO Servicio_Adicional (SA_Tipo, SA_Nombre, Operador_Turistico_Pro_COD, SA_Descripcion, SA_Costo, SA_Cant_Milla, SA_Fecha_Hora_Inicio, SA_Fecha_Hora_Fin)
VALUES ('Parque','Parque Laguna de Tacarigua',10,'Visita a lagunas y observación de fauna marina',130.00,28,'2025-12-24 08:00:00','2025-12-24 14:00:00');

RESTAURANTES

-- Venezuela
INSERT INTO Restaurante (Rest_Nombre, Rest_Direccion, Rest_Clasificacion, Lugar_Lug_COD, Rest_Tipo_Comida, Rest_Ambiente)
VALUES ('Arepa Gourmet','Av. Bolívar, Caracas',4,8,'Comida típica venezolana','Familiar');

INSERT INTO Restaurante (Rest_Nombre, Rest_Direccion, Rest_Clasificacion, Lugar_Lug_COD, Rest_Tipo_Comida, Rest_Ambiente)
VALUES ('Sabor Llanero','Calle Real, Valencia',5,8,'Comida criolla','Tradicional');

-- Brasil
INSERT INTO Restaurante (Rest_Nombre, Rest_Direccion, Rest_Clasificacion, Lugar_Lug_COD, Rest_Tipo_Comida, Rest_Ambiente)
VALUES ('Churrasquería do Sol','Rua das Palmeiras 123, Río de Janeiro',5,7,'Carnes a la parrilla','Elegante');

INSERT INTO Restaurante (Rest_Nombre, Rest_Direccion, Rest_Clasificacion, Lugar_Lug_COD, Rest_Tipo_Comida, Rest_Ambiente)
VALUES ('Sabores da Bahia','Av. Atlántica 456, Salvador',4,7,'Comida típica brasileña','Familiar');

-- Sudáfrica
INSERT INTO Restaurante (Rest_Nombre, Rest_Direccion, Rest_Clasificacion, Lugar_Lug_COD, Rest_Tipo_Comida, Rest_Ambiente)
VALUES ('Cape Flavors','Long Street 12, Ciudad del Cabo',5,10,'Comida sudafricana','Moderno');

INSERT INTO Restaurante (Rest_Nombre, Rest_Direccion, Rest_Clasificacion, Lugar_Lug_COD, Rest_Tipo_Comida, Rest_Ambiente)
VALUES ('Safari Taste','Nelson Mandela Ave, Johannesburgo',4,10,'Comida africana','Tradicional');

-- Francia
INSERT INTO Restaurante (Rest_Nombre, Rest_Direccion, Rest_Clasificacion, Lugar_Lug_COD, Rest_Tipo_Comida, Rest_Ambiente)
VALUES ('Le Petit Paris','Rue de Rivoli 78, París',5,6,'Comida francesa','Romántico');

INSERT INTO Restaurante (Rest_Nombre, Rest_Direccion, Rest_Clasificacion, Lugar_Lug_COD, Rest_Tipo_Comida, Rest_Ambiente)
VALUES ('Bistro Lyon','Place Bellecour, Lyon',4,6,'Comida gourmet francesa','Elegante');

-- Japón
INSERT INTO Restaurante (Rest_Nombre, Rest_Direccion, Rest_Clasificacion, Lugar_Lug_COD, Rest_Tipo_Comida, Rest_Ambiente)
VALUES ('Sakura Sushi','Shinjuku, Tokio',5,9,'Comida japonesa','Moderno');

INSERT INTO Restaurante (Rest_Nombre, Rest_Direccion, Rest_Clasificacion, Lugar_Lug_COD, Rest_Tipo_Comida, Rest_Ambiente)
VALUES ('Ramen House','Osaka Center',4,9,'Comida típica japonesa','Familiar');

-- Australia
INSERT INTO Restaurante (Rest_Nombre, Rest_Direccion, Rest_Clasificacion, Lugar_Lug_COD, Rest_Tipo_Comida, Rest_Ambiente)
VALUES ('Sydney Grill','George Street, Sídney',5,11,'Comida australiana','Moderno');

INSERT INTO Restaurante (Rest_Nombre, Rest_Direccion, Rest_Clasificacion, Lugar_Lug_COD, Rest_Tipo_Comida, Rest_Ambiente)
VALUES ('Outback Flavors','Queen Street, Brisbane',4,11,'Comida típica australiana','Campestre');




-- Moneda: EUR (Francia → Lugar_Lug_COD = 6)
INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('EUR', 380.20, 13.00, TO_DATE('05 10 2025','DD MM YYYY'), TO_DATE('10 10 2025','DD MM YYYY'), 6);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('EUR', 385.50, 12.00, TO_DATE('15 10 2025','DD MM YYYY'), TO_DATE('20 10 2025','DD MM YYYY'), 6);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('EUR', 390.00, 15.00, TO_DATE('25 10 2025','DD MM YYYY'), TO_DATE('30 10 2025','DD MM YYYY'), 6);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('EUR', 395.40, 16.00, TO_DATE('05 11 2025','DD MM YYYY'), TO_DATE('10 11 2025','DD MM YYYY'), 6);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('EUR', 397.80, 14.00, TO_DATE('20 11 2025','DD MM YYYY'), TO_DATE('25 11 2025','DD MM YYYY'), 6);

-- Moneda: BRL (Brasil → Lugar_Lug_COD = 7)
INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('BRL', 360.50, 10.00, TO_DATE('06 10 2025','DD MM YYYY'), TO_DATE('11 10 2025','DD MM YYYY'), 7);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('BRL', 364.80, 12.00, TO_DATE('16 10 2025','DD MM YYYY'), TO_DATE('21 10 2025','DD MM YYYY'), 7);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('BRL', 375.20, 14.00, TO_DATE('26 10 2025','DD MM YYYY'), TO_DATE('31 10 2025','DD MM YYYY'), 7);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('BRL', 377.60, 16.00, TO_DATE('10 11 2025','DD MM YYYY'), TO_DATE('15 11 2025','DD MM YYYY'), 7);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('BRL', 380.00, 18.00, TO_DATE('25 11 2025','DD MM YYYY'), TO_DATE('30 11 2025','DD MM YYYY'), 7);

-- Moneda: VES (Bolívar)
INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, 
TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('VES', 100.00, 10.00, TO_DATE('07 10 2025','DD MM YYYY'), TO_DATE('12 10 2025','DD MM YYYY'), 8);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, 
TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('VES', 105.05, 11.00, TO_DATE('17 10 2025','DD MM YYYY'), TO_DATE('22 10 2025','DD MM YYYY'), 8);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, 
TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('VES', 140.10, 12.00, TO_DATE('27 10 2025','DD MM YYYY'), TO_DATE('01 11 2025','DD MM YYYY'), 8);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, 
TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('VES', 120.15, 13.00, TO_DATE('12 11 2025','DD MM YYYY'), TO_DATE('17 11 2025','DD MM YYYY'), 8);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, 
TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('VES', 125.20, 14.00, TO_DATE('27 11 2025','DD MM YYYY'), TO_DATE('02 12 2025','DD MM YYYY'), 8);

-- Moneda: Milla vs VES
INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, 
TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('Milla', 0.50, 1.00, TO_DATE('01 10 2025','DD MM YYYY'), TO_DATE('05 10 2025','DD MM YYYY'), 8);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, 
TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('Milla', 0.75, 1.50, TO_DATE('10 10 2025','DD MM YYYY'), TO_DATE('15 10 2025','DD MM YYYY'), 8);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, 
TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('Milla', 1.00, 2.00, TO_DATE('20 10 2025','DD MM YYYY'), TO_DATE('25 10 2025','DD MM YYYY'), 8);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, 
TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('Milla', 1.25, 2.50, TO_DATE('05 11 2025','DD MM YYYY'), TO_DATE('10 11 2025','DD MM YYYY'), 8);

INSERT INTO Tasa_de_Cambio (TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, 
TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD)
VALUES ('Milla', 1.50, 3.00, TO_DATE('25 11 2025','DD MM YYYY'), TO_DATE('30 11 2025','DD MM YYYY'), 8);



-- Terminales Aéreos
INSERT INTO Terminal (Ter_Nombre, Ter_Tipo, Ter_Direccion, Lugar_Lug_COD2, Lugar_Lug_COD)
VALUES ('Terminal Caracas-Brasil', 'Aéreo', 'Av. Libertador, Caracas', 8, 7);

INSERT INTO Terminal (Ter_Nombre, Ter_Tipo, Ter_Direccion, Lugar_Lug_COD2, Lugar_Lug_COD)
VALUES ('Terminal Río-París', 'Aéreo', 'Rua das Flores 123, Río de Janeiro', 7, 6);

INSERT INTO Terminal (Ter_Nombre, Ter_Tipo, Ter_Direccion, Lugar_Lug_COD2, Lugar_Lug_COD)
VALUES ('Terminal París-Tokio', 'Aéreo', 'Rue de Rivoli 45, París', 6, 9);

INSERT INTO Terminal (Ter_Nombre, Ter_Tipo, Ter_Direccion, Lugar_Lug_COD2, Lugar_Lug_COD)
VALUES ('Terminal Tokio-Sídney', 'Aéreo', 'Shinjuku Center, Tokio', 9, 11);

-- Terminales Terrestres
INSERT INTO Terminal (Ter_Nombre, Ter_Tipo, Ter_Direccion, Lugar_Lug_COD2, Lugar_Lug_COD)
VALUES ('Terminal Caracas-Valencia', 'Terrestre', 'Av. Bolívar, Caracas', 8, 8);

INSERT INTO Terminal (Ter_Nombre, Ter_Tipo, Ter_Direccion, Lugar_Lug_COD2, Lugar_Lug_COD)
VALUES ('Terminal São Paulo-Río', 'Terrestre', 'Av. Paulista, São Paulo', 7, 7);

INSERT INTO Terminal (Ter_Nombre, Ter_Tipo, Ter_Direccion, Lugar_Lug_COD2, Lugar_Lug_COD)
VALUES ('Terminal Johannesburgo-Ciudad del Cabo', 'Terrestre', 'Nelson Mandela Ave, Johannesburgo', 10, 10);

-- Terminales Marítimos
INSERT INTO Terminal (Ter_Nombre, Ter_Tipo, Ter_Direccion, Lugar_Lug_COD2, Lugar_Lug_COD)
VALUES ('Puerto La Guaira-Río', 'Marítimo', 'Av. Puerto, La Guaira', 8, 7);

INSERT INTO Terminal (Ter_Nombre, Ter_Tipo, Ter_Direccion, Lugar_Lug_COD2, Lugar_Lug_COD)
VALUES ('Puerto Marsella-Ciudad del Cabo', 'Marítimo', 'Rue du Port, Marsella', 6, 10);

INSERT INTO Terminal (Ter_Nombre, Ter_Tipo, Ter_Direccion, Lugar_Lug_COD2, Lugar_Lug_COD)
VALUES ('Puerto Sídney-Tokio', 'Marítimo', 'George Street, Sídney', 11, 9);


-- Crucero 1 → Barco 1
INSERT INTO Crucero (Cru_nombre, Barco_Bar_COD, Cru_Huella_Carbono, Cru_Fecha_Hora_Salida, Cru_Fecha_Hora_Lllegada, Cru_Cant_Millas)
VALUES ('Crucero Caribeño', 1, 120, TO_TIMESTAMP('2025-12-15 10:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-20 08:00:00','YYYY-MM-DD HH24:MI:SS'), 850);

-- Crucero 2 → Barco 2
INSERT INTO Crucero (Cru_nombre, Barco_Bar_COD, Cru_Huella_Carbono, Cru_Fecha_Hora_Salida, Cru_Fecha_Hora_Lllegada, Cru_Cant_Millas)
VALUES ('Crucero Amazónico', 2, 95, TO_TIMESTAMP('2025-12-18 09:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-22 17:00:00','YYYY-MM-DD HH24:MI:SS'), 600);

-- Crucero 3 → Barco 3
INSERT INTO Crucero (Cru_nombre, Barco_Bar_COD, Cru_Huella_Carbono, Cru_Fecha_Hora_Salida, Cru_Fecha_Hora_Lllegada, Cru_Cant_Millas)
VALUES ('Crucero Mediterráneo', 3, 140, TO_TIMESTAMP('2025-12-20 12:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-27 08:00:00','YYYY-MM-DD HH24:MI:SS'), 1100);

-- Crucero 4 → Barco 4
INSERT INTO Crucero (Cru_nombre, Barco_Bar_COD, Cru_Huella_Carbono, Cru_Fecha_Hora_Salida, Cru_Fecha_Hora_Lllegada, Cru_Cant_Millas)
VALUES ('Crucero Pacífico', 4, 160, TO_TIMESTAMP('2025-12-22 14:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-28 09:00:00','YYYY-MM-DD HH24:MI:SS'), 950);

-- Crucero 5 → Barco 5
INSERT INTO Crucero (Cru_nombre, Barco_Bar_COD, Cru_Huella_Carbono, Cru_Fecha_Hora_Salida, Cru_Fecha_Hora_Lllegada, Cru_Cant_Millas)
VALUES ('Crucero Atlántico', 5, 180, TO_TIMESTAMP('2025-12-25 08:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-31 20:00:00','YYYY-MM-DD HH24:MI:SS'), 1200);

-- Crucero 6 → Barco 6
INSERT INTO Crucero (Cru_nombre, Barco_Bar_COD, Cru_Huella_Carbono, Cru_Fecha_Hora_Salida, Cru_Fecha_Hora_Lllegada, Cru_Cant_Millas)
VALUES ('Crucero Austral', 6, 130, TO_TIMESTAMP('2025-12-28 07:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-02 18:00:00','YYYY-MM-DD HH24:MI:SS'), 700);

-- Crucero 7 → Barco 7
INSERT INTO Crucero (Cru_nombre, Barco_Bar_COD, Cru_Huella_Carbono, Cru_Fecha_Hora_Salida, Cru_Fecha_Hora_Lllegada, Cru_Cant_Millas)
VALUES ('Crucero Polar', 7, 150, TO_TIMESTAMP('2025-12-30 11:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-05 09:00:00','YYYY-MM-DD HH24:MI:SS'), 900);

-- Crucero 8 → Barco 8
INSERT INTO Crucero (Cru_nombre, Barco_Bar_COD, Cru_Huella_Carbono, Cru_Fecha_Hora_Salida, Cru_Fecha_Hora_Lllegada, Cru_Cant_Millas)
VALUES ('Crucero Oriental', 8, 100, TO_TIMESTAMP('2026-01-02 10:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-07 16:00:00','YYYY-MM-DD HH24:MI:SS'), 650);

-- Crucero 9 → Barco 9
INSERT INTO Crucero (Cru_nombre, Barco_Bar_COD, Cru_Huella_Carbono, Cru_Fecha_Hora_Salida, Cru_Fecha_Hora_Lllegada, Cru_Cant_Millas)
VALUES ('Crucero Occidental', 9, 170, TO_TIMESTAMP('2026-01-05 09:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-10 20:00:00','YYYY-MM-DD HH24:MI:SS'), 800);

-- Crucero 10 → Barco 10
INSERT INTO Crucero (Cru_nombre, Barco_Bar_COD, Cru_Huella_Carbono, Cru_Fecha_Hora_Salida, Cru_Fecha_Hora_Lllegada, Cru_Cant_Millas)
VALUES ('Crucero Horizonte', 10, 155, TO_TIMESTAMP('2026-01-08 13:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-14 10:00:00','YYYY-MM-DD HH24:MI:SS'), 1000);


-- Transporte 1 → Vehículo 1
INSERT INTO Transporte_Terrestre (TT_Nombre, Vehiculo_Veh_COD, TT_Huella_Carbono, TT_Fecha_Hora_Salida, TT_Fecha_Hora_Llegada, TT_Cant_Millas)
VALUES ('Ruta Caracas-Valencia', 1, 45, TO_TIMESTAMP('2025-12-15 07:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-15 10:00:00','YYYY-MM-DD HH24:MI:SS'), 120);

-- Transporte 2 → Vehículo 2
INSERT INTO Transporte_Terrestre (TT_Nombre, Vehiculo_Veh_COD, TT_Huella_Carbono, TT_Fecha_Hora_Salida, TT_Fecha_Hora_Llegada, TT_Cant_Millas)
VALUES ('Ruta Maracay-Caracas', 2, 30, TO_TIMESTAMP('2025-12-16 08:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-16 09:30:00','YYYY-MM-DD HH24:MI:SS'), 90);

-- Transporte 3 → Vehículo 3
INSERT INTO Transporte_Terrestre (TT_Nombre, Vehiculo_Veh_COD, TT_Huella_Carbono, TT_Fecha_Hora_Salida, TT_Fecha_Hora_Llegada, TT_Cant_Millas)
VALUES ('Ruta Río-São Paulo', 3, 60, TO_TIMESTAMP('2025-12-17 06:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-17 14:00:00','YYYY-MM-DD HH24:MI:SS'), 400);

-- Transporte 4 → Vehículo 4
INSERT INTO Transporte_Terrestre (TT_Nombre, Vehiculo_Veh_COD, TT_Huella_Carbono, TT_Fecha_Hora_Salida, TT_Fecha_Hora_Llegada, TT_Cant_Millas)
VALUES ('Ruta París-Lyon', 4, 55, TO_TIMESTAMP('2025-12-18 09:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-18 13:00:00','YYYY-MM-DD HH24:MI:SS'), 250);

-- Transporte 5 → Vehículo 5
INSERT INTO Transporte_Terrestre (TT_Nombre, Vehiculo_Veh_COD, TT_Huella_Carbono, TT_Fecha_Hora_Salida, TT_Fecha_Hora_Llegada, TT_Cant_Millas)
VALUES ('Ruta Tokio-Osaka', 5, 70, TO_TIMESTAMP('2025-12-19 07:30:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-19 11:30:00','YYYY-MM-DD HH24:MI:SS'), 320);

-- Transporte 6 → Vehículo 6
INSERT INTO Transporte_Terrestre (TT_Nombre, Vehiculo_Veh_COD, TT_Huella_Carbono, TT_Fecha_Hora_Salida, TT_Fecha_Hora_Llegada, TT_Cant_Millas)
VALUES ('Ruta Johannesburgo-Pretoria', 6, 40, TO_TIMESTAMP('2025-12-20 08:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-20 09:30:00','YYYY-MM-DD HH24:MI:SS'), 100);

-- Transporte 7 → Vehículo 7
INSERT INTO Transporte_Terrestre (TT_Nombre, Vehiculo_Veh_COD, TT_Huella_Carbono, TT_Fecha_Hora_Salida, TT_Fecha_Hora_Llegada, TT_Cant_Millas)
VALUES ('Ruta Sídney-Brisbane', 7, 65, TO_TIMESTAMP('2025-12-21 06:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-21 12:00:00','YYYY-MM-DD HH24:MI:SS'), 350);

-- Transporte 8 → Vehículo 8
INSERT INTO Transporte_Terrestre (TT_Nombre, Vehiculo_Veh_COD, TT_Huella_Carbono, TT_Fecha_Hora_Salida, TT_Fecha_Hora_Llegada, TT_Cant_Millas)
VALUES ('Ruta Valencia-Maracay', 8, 35, TO_TIMESTAMP('2025-12-22 07:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-22 08:30:00','YYYY-MM-DD HH24:MI:SS'), 85);

-- Transporte 9 → Vehículo 9
INSERT INTO Transporte_Terrestre (TT_Nombre, Vehiculo_Veh_COD, TT_Huella_Carbono, TT_Fecha_Hora_Salida, TT_Fecha_Hora_Llegada, TT_Cant_Millas)
VALUES ('Ruta Marsella-París', 9, 75, TO_TIMESTAMP('2025-12-23 05:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-23 11:00:00','YYYY-MM-DD HH24:MI:SS'), 500);

-- Transporte 10 → Vehículo 10
INSERT INTO Transporte_Terrestre (TT_Nombre, Vehiculo_Veh_COD, TT_Huella_Carbono, TT_Fecha_Hora_Salida, TT_Fecha_Hora_Llegada, TT_Cant_Millas)
VALUES ('Ruta Osaka-Kioto', 10, 25, TO_TIMESTAMP('2025-12-24 09:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-24 10:30:00','YYYY-MM-DD HH24:MI:SS'), 75);



-- Vuelo 1 → Avión 1
INSERT INTO Vuelo (Avion_Avi_COD, Vue_Huella_Carbono, Vue_Fecha_Hora_Salida, Vue_Fecha_Hora_Llegada, Vue_Cant_Millas)
VALUES (1, 1.20, TO_TIMESTAMP('2025-12-15 08:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-15 16:00:00','YYYY-MM-DD HH24:MI:SS'), 4500);

-- Vuelo 2 → Avión 2
INSERT INTO Vuelo (Avion_Avi_COD, Vue_Huella_Carbono, Vue_Fecha_Hora_Salida, Vue_Fecha_Hora_Llegada, Vue_Cant_Millas)
VALUES (2, 1.10, TO_TIMESTAMP('2025-12-16 09:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-16 17:00:00','YYYY-MM-DD HH24:MI:SS'), 4200);

-- Vuelo 3 → Avión 3
INSERT INTO Vuelo (Avion_Avi_COD, Vue_Huella_Carbono, Vue_Fecha_Hora_Salida, Vue_Fecha_Hora_Llegada, Vue_Cant_Millas)
VALUES (3, 0.95, TO_TIMESTAMP('2025-12-17 07:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-17 13:00:00','YYYY-MM-DD HH24:MI:SS'), 3800);

-- Vuelo 4 → Avión 4
INSERT INTO Vuelo (Avion_Avi_COD, Vue_Huella_Carbono, Vue_Fecha_Hora_Salida, Vue_Fecha_Hora_Llegada, Vue_Cant_Millas)
VALUES (4, 1.50, TO_TIMESTAMP('2025-12-18 10:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-19 06:00:00','YYYY-MM-DD HH24:MI:SS'), 9500);

-- Vuelo 5 → Avión 5
INSERT INTO Vuelo (Avion_Avi_COD, Vue_Huella_Carbono, Vue_Fecha_Hora_Salida, Vue_Fecha_Hora_Llegada, Vue_Cant_Millas)
VALUES (5, 1.30, TO_TIMESTAMP('2025-12-19 12:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-20 05:00:00','YYYY-MM-DD HH24:MI:SS'), 7200);

-- Vuelo 6 → Avión 6
INSERT INTO Vuelo (Avion_Avi_COD, Vue_Huella_Carbono, Vue_Fecha_Hora_Salida, Vue_Fecha_Hora_Llegada, Vue_Cant_Millas)
VALUES (6, 1.70, TO_TIMESTAMP('2025-12-20 14:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-21 12:00:00','YYYY-MM-DD HH24:MI:SS'), 9800);

-- Vuelo 7 → Avión 7
INSERT INTO Vuelo (Avion_Avi_COD, Vue_Huella_Carbono, Vue_Fecha_Hora_Salida, Vue_Fecha_Hora_Llegada, Vue_Cant_Millas)
VALUES (7, 1.40, TO_TIMESTAMP('2025-12-21 09:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-21 18:00:00','YYYY-MM-DD HH24:MI:SS'), 9700);

-- Vuelo 8 → Avión 8
INSERT INTO Vuelo (Avion_Avi_COD, Vue_Huella_Carbono, Vue_Fecha_Hora_Salida, Vue_Fecha_Hora_Llegada, Vue_Cant_Millas)
VALUES (8, 1.25, TO_TIMESTAMP('2025-12-22 07:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-22 20:00:00','YYYY-MM-DD HH24:MI:SS'), 8900);

-- Vuelo 9 → Avión 9
INSERT INTO Vuelo (Avion_Avi_COD, Vue_Huella_Carbono, Vue_Fecha_Hora_Salida, Vue_Fecha_Hora_Llegada, Vue_Cant_Millas)
VALUES (9, 1.60, TO_TIMESTAMP('2025-12-23 06:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-23 22:00:00','YYYY-MM-DD HH24:MI:SS'), 9400);

-- Vuelo 10 → Avión 10
INSERT INTO Vuelo (Avion_Avi_COD, Vue_Huella_Carbono, Vue_Fecha_Hora_Salida, Vue_Fecha_Hora_Llegada, Vue_Cant_Millas)
VALUES (10, 1.55, TO_TIMESTAMP('2025-12-24 08:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-24 20:00:00','YYYY-MM-DD HH24:MI:SS'), 9100);




-- Hospedaje 1 → Hotel 1
INSERT INTO Hospedaje (Hos_Fecha_Hora_Inicio, Hos_Fecha_Hora_Fin, Hos_Costo, Hotel_Pro_COD, Hot_Cant_Milla)
VALUES (TO_TIMESTAMP('2025-12-15 14:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-20 12:00:00','YYYY-MM-DD HH24:MI:SS'), 500.00, 1, 120);

-- Hospedaje 2 → Hotel 2
INSERT INTO Hospedaje (Hos_Fecha_Hora_Inicio, Hos_Fecha_Hora_Fin, Hos_Costo, Hotel_Pro_COD, Hot_Cant_Milla)
VALUES (TO_TIMESTAMP('2025-12-16 15:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-21 11:00:00','YYYY-MM-DD HH24:MI:SS'), 650.00, 2, 150);

-- Hospedaje 3 → Hotel 3
INSERT INTO Hospedaje (Hos_Fecha_Hora_Inicio, Hos_Fecha_Hora_Fin, Hos_Costo, Hotel_Pro_COD, Hot_Cant_Milla)
VALUES (TO_TIMESTAMP('2025-12-17 13:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-22 10:00:00','YYYY-MM-DD HH24:MI:SS'), 800.00, 3, 200);

-- Hospedaje 4 → Hotel 4
INSERT INTO Hospedaje (Hos_Fecha_Hora_Inicio, Hos_Fecha_Hora_Fin, Hos_Costo, Hotel_Pro_COD, Hot_Cant_Milla)
VALUES (TO_TIMESTAMP('2025-12-18 16:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-23 09:00:00','YYYY-MM-DD HH24:MI:SS'), 950.00, 4, 250);

-- Hospedaje 5 → Hotel 5
INSERT INTO Hospedaje (Hos_Fecha_Hora_Inicio, Hos_Fecha_Hora_Fin, Hos_Costo, Hotel_Pro_COD, Hot_Cant_Milla)
VALUES (TO_TIMESTAMP('2025-12-19 12:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-24 08:00:00','YYYY-MM-DD HH24:MI:SS'), 700.00, 5, 180);

-- Hospedaje 6 → Hotel 6
INSERT INTO Hospedaje (Hos_Fecha_Hora_Inicio, Hos_Fecha_Hora_Fin, Hos_Costo, Hotel_Pro_COD, Hot_Cant_Milla)
VALUES (TO_TIMESTAMP('2025-12-20 14:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-25 11:00:00','YYYY-MM-DD HH24:MI:SS'), 880.00, 6, 220);

-- Hospedaje 7 → Hotel 7
INSERT INTO Hospedaje (Hos_Fecha_Hora_Inicio, Hos_Fecha_Hora_Fin, Hos_Costo, Hotel_Pro_COD, Hot_Cant_Milla)
VALUES (TO_TIMESTAMP('2025-12-21 13:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-26 09:00:00','YYYY-MM-DD HH24:MI:SS'), 450.00, 7, 100);

-- Hospedaje 8 → Hotel 8
INSERT INTO Hospedaje (Hos_Fecha_Hora_Inicio, Hos_Fecha_Hora_Fin, Hos_Costo, Hotel_Pro_COD, Hot_Cant_Milla)
VALUES (TO_TIMESTAMP('2025-12-22 15:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-27 10:00:00','YYYY-MM-DD HH24:MI:SS'), 600.00, 8, 160);

-- Hospedaje 9 → Hotel 9
INSERT INTO Hospedaje (Hos_Fecha_Hora_Inicio, Hos_Fecha_Hora_Fin, Hos_Costo, Hotel_Pro_COD, Hot_Cant_Milla)
VALUES (TO_TIMESTAMP('2025-12-23 16:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-28 12:00:00','YYYY-MM-DD HH24:MI:SS'), 720.00, 9, 190);

-- Hospedaje 10 → Hotel 10
INSERT INTO Hospedaje (Hos_Fecha_Hora_Inicio, Hos_Fecha_Hora_Fin, Hos_Costo, Hotel_Pro_COD, Hot_Cant_Milla)
VALUES (TO_TIMESTAMP('2025-12-24 17:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-12-29 11:00:00','YYYY-MM-DD HH24:MI:SS'), 550.00, 10, 130);



-- Financiamiento 1 → Reserva 1
INSERT INTO Financiamiento (Fin_Numero_Cuotas, Reserva_Res_COD, Fin_Monto_Financiado, Fin_Fecha)
VALUES (6, 1, 1500.00, TO_DATE('05-12-2025','DD-MM-YYYY'));

-- Financiamiento 2 → Reserva 2
INSERT INTO Financiamiento (Fin_Numero_Cuotas, Reserva_Res_COD, Fin_Monto_Financiado, Fin_Fecha)
VALUES (12, 2, 3200.00, TO_DATE('06-12-2025','DD-MM-YYYY'));

-- Financiamiento 3 → Reserva 3
INSERT INTO Financiamiento (Fin_Numero_Cuotas, Reserva_Res_COD, Fin_Monto_Financiado, Fin_Fecha)
VALUES (9, 3, 2800.00, TO_DATE('07-12-2025','DD-MM-YYYY'));

-- Financiamiento 4 → Reserva 4
INSERT INTO Financiamiento (Fin_Numero_Cuotas, Reserva_Res_COD, Fin_Monto_Financiado, Fin_Fecha)
VALUES (5, 4, 1200.00, TO_DATE('08-12-2025','DD-MM-YYYY'));

-- Financiamiento 5 → Reserva 5
INSERT INTO Financiamiento (Fin_Numero_Cuotas, Reserva_Res_COD, Fin_Monto_Financiado, Fin_Fecha)
VALUES (10, 5, 4000.00, TO_DATE('09-12-2025','DD-MM-YYYY'));

-- Financiamiento 6 → Reserva 6
INSERT INTO Financiamiento (Fin_Numero_Cuotas, Reserva_Res_COD, Fin_Monto_Financiado, Fin_Fecha)
VALUES (8, 6, 2500.00, TO_DATE('10-12-2025','DD-MM-YYYY'));

-- Financiamiento 7 → Reserva 7
INSERT INTO Financiamiento (Fin_Numero_Cuotas, Reserva_Res_COD, Fin_Monto_Financiado, Fin_Fecha)
VALUES (4, 7, 900.00, TO_DATE('11-12-2025','DD-MM-YYYY'));

-- Financiamiento 8 → Reserva 8
INSERT INTO Financiamiento (Fin_Numero_Cuotas, Reserva_Res_COD, Fin_Monto_Financiado, Fin_Fecha)
VALUES (7, 8, 2100.00, TO_DATE('12-12-2025','DD-MM-YYYY'));

-- Financiamiento 9 → Reserva 9
INSERT INTO Financiamiento (Fin_Numero_Cuotas, Reserva_Res_COD, Fin_Monto_Financiado, Fin_Fecha)
VALUES (11, 9, 3500.00, TO_DATE('13-12-2025','DD-MM-YYYY'));

-- Financiamiento 10 → Reserva 10
INSERT INTO Financiamiento (Fin_Numero_Cuotas, Reserva_Res_COD, Fin_Monto_Financiado, Fin_Fecha)
VALUES (3, 10, 750.00, TO_DATE('14-12-2025','DD-MM-YYYY'));




-- Cuota 1 → Financiamiento 1
INSERT INTO Cuota (Cuo_Monto, Cuo_Fecha_Vencimiento, Financiamiento_Fin_COD, Cuo_Fecha_Pago)
VALUES (250.00, TO_DATE('20-12-2025','DD-MM-YYYY'), 1, TO_DATE('19-12-2025','DD-MM-YYYY'));

-- Cuota 2 → Financiamiento 2
INSERT INTO Cuota (Cuo_Monto, Cuo_Fecha_Vencimiento, Financiamiento_Fin_COD, Cuo_Fecha_Pago)
VALUES (270.00, TO_DATE('21-12-2025','DD-MM-YYYY'), 2, TO_DATE('22-12-2025','DD-MM-YYYY'));

-- Cuota 3 → Financiamiento 3
INSERT INTO Cuota (Cuo_Monto, Cuo_Fecha_Vencimiento, Financiamiento_Fin_COD, Cuo_Fecha_Pago)
VALUES (310.00, TO_DATE('22-12-2025','DD-MM-YYYY'), 3, TO_DATE('22-12-2025','DD-MM-YYYY'));

-- Cuota 4 → Financiamiento 4
INSERT INTO Cuota (Cuo_Monto, Cuo_Fecha_Vencimiento, Financiamiento_Fin_COD, Cuo_Fecha_Pago)
VALUES (240.00, TO_DATE('23-12-2025','DD-MM-YYYY'), 4, TO_DATE('24-12-2025','DD-MM-YYYY'));

-- Cuota 5 → Financiamiento 5
INSERT INTO Cuota (Cuo_Monto, Cuo_Fecha_Vencimiento, Financiamiento_Fin_COD, Cuo_Fecha_Pago)
VALUES (400.00, TO_DATE('24-12-2025','DD-MM-YYYY'), 5, TO_DATE('24-12-2025','DD-MM-YYYY'));

-- Cuota 6 → Financiamiento 6
INSERT INTO Cuota (Cuo_Monto, Cuo_Fecha_Vencimiento, Financiamiento_Fin_COD, Cuo_Fecha_Pago)
VALUES (310.00, TO_DATE('25-12-2025','DD-MM-YYYY'), 6, TO_DATE('26-12-2025','DD-MM-YYYY'));

-- Cuota 7 → Financiamiento 7
INSERT INTO Cuota (Cuo_Monto, Cuo_Fecha_Vencimiento, Financiamiento_Fin_COD, Cuo_Fecha_Pago)
VALUES (225.00, TO_DATE('26-12-2025','DD-MM-YYYY'), 7, TO_DATE('27-12-2025','DD-MM-YYYY'));

-- Cuota 8 → Financiamiento 8
INSERT INTO Cuota (Cuo_Monto, Cuo_Fecha_Vencimiento, Financiamiento_Fin_COD, Cuo_Fecha_Pago)
VALUES (300.00, TO_DATE('27-12-2025','DD-MM-YYYY'), 8, TO_DATE('27-12-2025','DD-MM-YYYY'));

-- Cuota 9 → Financiamiento 9
INSERT INTO Cuota (Cuo_Monto, Cuo_Fecha_Vencimiento, Financiamiento_Fin_COD, Cuo_Fecha_Pago)
VALUES (320.00, TO_DATE('28-12-2025','DD-MM-YYYY'), 9, TO_DATE('29-12-2025','DD-MM-YYYY'));

-- Cuota 10 → Financiamiento 10
INSERT INTO Cuota (Cuo_Monto, Cuo_Fecha_Vencimiento, Financiamiento_Fin_COD, Cuo_Fecha_Pago)
VALUES (250.00, TO_DATE('29-12-2025','DD-MM-YYYY'), 10, TO_DATE('30-12-2025','DD-MM-YYYY'));




-- Auditoría 1 → Usuario 1 (Cliente)
INSERT INTO Auditoria (Aud_Fecha_Hora, Aud_Accion, Usuario_Usu_COD, Aud_Tabla_Cambiada, Aud_Descripcion, Aud_Registro_Cambiado)
VALUES (CURRENT_TIMESTAMP, 'INSERT', 1, 'Reserva', 'Cliente 1 creó una nueva reserva', 'Reserva 1');

-- Auditoría 2 → Usuario 2 (Cliente)
INSERT INTO Auditoria (Aud_Fecha_Hora, Aud_Accion, Usuario_Usu_COD, Aud_Tabla_Cambiada, Aud_Descripcion, Aud_Registro_Cambiado)
VALUES (CURRENT_TIMESTAMP, 'UPDATE', 2, 'Cliente', 'Cliente 2 actualizó sus datos personales', 'Cliente 2');

-- Auditoría 3 → Usuario 3 (Proveedor Crucero)
INSERT INTO Auditoria (Aud_Fecha_Hora, Aud_Accion, Usuario_Usu_COD, Aud_Tabla_Cambiada, Aud_Descripcion, Aud_Registro_Cambiado)
VALUES (CURRENT_TIMESTAMP, 'INSERT', 3, 'Crucero', 'Proveedor Crucero agregó un nuevo crucero', 'Crucero 1');

-- Auditoría 4 → Usuario 4 (Proveedor Aerolínea)
INSERT INTO Auditoria (Aud_Fecha_Hora, Aud_Accion, Usuario_Usu_COD, Aud_Tabla_Cambiada, Aud_Descripcion, Aud_Registro_Cambiado)
VALUES (CURRENT_TIMESTAMP, 'INSERT', 4, 'Vuelo', 'Proveedor Aerolínea registró un nuevo vuelo', 'Vuelo 1');

-- Auditoría 5 → Usuario 5 (Proveedor Transporte Terrestre)
INSERT INTO Auditoria (Aud_Fecha_Hora, Aud_Accion, Usuario_Usu_COD, Aud_Tabla_Cambiada, Aud_Descripcion, Aud_Registro_Cambiado)
VALUES (CURRENT_TIMESTAMP, 'DELETE', 5, 'Transporte_Terrestre', 'Proveedor eliminó un transporte terrestre', 'Transporte 1');

-- Auditoría 6 → Usuario 6 (Proveedor Operador Turístico)
INSERT INTO Auditoria (Aud_Fecha_Hora, Aud_Accion, Usuario_Usu_COD, Aud_Tabla_Cambiada, Aud_Descripcion, Aud_Registro_Cambiado)
VALUES (CURRENT_TIMESTAMP, 'INSERT', 6, 'Operador_Turistico', 'Proveedor operador turístico agregó un nuevo paquete', 'Operador 1');

-- Auditoría 7 → Usuario 7 (Proveedor Hotel)
INSERT INTO Auditoria (Aud_Fecha_Hora, Aud_Accion, Usuario_Usu_COD, Aud_Tabla_Cambiada, Aud_Descripcion, Aud_Registro_Cambiado)
VALUES (CURRENT_TIMESTAMP, 'UPDATE', 7, 'Hotel', 'Proveedor hotel actualizó tarifas de hospedaje', 'Hotel 1');

-- Auditoría 8 → Usuario 8 (Empleado Administrador)
INSERT INTO Auditoria (Aud_Fecha_Hora, Aud_Accion, Usuario_Usu_COD, Aud_Tabla_Cambiada, Aud_Descripcion, Aud_Registro_Cambiado)
VALUES (CURRENT_TIMESTAMP, 'LOGIN', 8, 'Usuario', 'Administrador inició sesión en el sistema', 'Usuario 8');

-- Auditoría 9 → Usuario 9 (Empleado Gerente)
INSERT INTO Auditoria (Aud_Fecha_Hora, Aud_Accion, Usuario_Usu_COD, Aud_Tabla_Cambiada, Aud_Descripcion, Aud_Registro_Cambiado)
VALUES (CURRENT_TIMESTAMP, 'UPDATE', 9, 'Financiamiento', 'Gerente aprobó modificación en financiamiento', 'Financiamiento 3');

-- Auditoría 10 → Usuario 10 (Empleado Supervisor)
INSERT INTO Auditoria (Aud_Fecha_Hora, Aud_Accion, Usuario_Usu_COD, Aud_Tabla_Cambiada, Aud_Descripcion, Aud_Registro_Cambiado)
VALUES (CURRENT_TIMESTAMP, 'INSERT', 10, 'Cuota', 'Supervisor registró una nueva cuota de financiamiento', 'Cuota 5');


-- Reembolso 1 → Reserva 1
INSERT INTO Reembolso (Rem_Monto_Devuelto, Rem_Monto_Retenido, Reserva_Res_COD)
VALUES (1200.00, 200.00, 1);

-- Reembolso 2 → Reserva 2
INSERT INTO Reembolso (Rem_Monto_Devuelto, Rem_Monto_Retenido, Reserva_Res_COD)
VALUES (1500.00, 300.00, 2);

-- Reembolso 3 → Reserva 3
INSERT INTO Reembolso (Rem_Monto_Devuelto, Rem_Monto_Retenido, Reserva_Res_COD)
VALUES (800.00, 150.00, 3);

-- Reembolso 4 → Reserva 4
INSERT INTO Reembolso (Rem_Monto_Devuelto, Rem_Monto_Retenido, Reserva_Res_COD)
VALUES (950.00, 100.00, 4);

-- Reembolso 5 → Reserva 5
INSERT INTO Reembolso (Rem_Monto_Devuelto, Rem_Monto_Retenido, Reserva_Res_COD)
VALUES (2000.00, 500.00, 5);

-- Reembolso 6 → Reserva 6
INSERT INTO Reembolso (Rem_Monto_Devuelto, Rem_Monto_Retenido, Reserva_Res_COD)
VALUES (1300.00, 250.00, 6);

-- Reembolso 7 → Reserva 7
INSERT INTO Reembolso (Rem_Monto_Devuelto, Rem_Monto_Retenido, Reserva_Res_COD)
VALUES (700.00, 120.00, 7);

-- Reembolso 8 → Reserva 8
INSERT INTO Reembolso (Rem_Monto_Devuelto, Rem_Monto_Retenido, Reserva_Res_COD)
VALUES (1100.00, 180.00, 8);

-- Reembolso 9 → Reserva 9
INSERT INTO Reembolso (Rem_Monto_Devuelto, Rem_Monto_Retenido, Reserva_Res_COD)
VALUES (1600.00, 300.00, 9);

-- Reembolso 10 → Reserva 10
INSERT INTO Reembolso (Rem_Monto_Devuelto, Rem_Monto_Retenido, Reserva_Res_COD)
VALUES (900.00, 150.00, 10);




-- Paquete 1 → Promoción 1
INSERT INTO Paquete_Turistico (PT_Nombre, PT_Descripcion, PT_Costo, PT_Costo_Millas, PT_Cant_Milla, PT_Tipo, Promocion_Promocion_ID)
VALUES ('Paquete Caribeño', 'Viaje de 7 días a playas del Caribe con todo incluido', 3500.00, 1800.00, 300, 'Especial', 1);

-- Paquete 2 → Promoción 2
INSERT INTO Paquete_Turistico (PT_Nombre, PT_Descripcion, PT_Costo, PT_Costo_Millas, PT_Cant_Milla, PT_Tipo, Promocion_Promocion_ID)
VALUES ('Paquete Amazónico', 'Exploración de la selva amazónica con guía especializado', 2800.00, 1500.00, 250, 'Regular', 2);

-- Paquete 3 → Promoción 3
INSERT INTO Paquete_Turistico (PT_Nombre, PT_Descripcion, PT_Costo, PT_Costo_Millas, PT_Cant_Milla, PT_Tipo, Promocion_Promocion_ID)
VALUES ('Paquete Mediterráneo', 'Crucero por el Mediterráneo visitando 5 países', 4200.00, 2200.00, 400, 'Especial', 3);

-- Paquete 4 → Promoción 4
INSERT INTO Paquete_Turistico (PT_Nombre, PT_Descripcion, PT_Costo, PT_Costo_Millas, PT_Cant_Milla, PT_Tipo, Promocion_Promocion_ID)
VALUES ('Paquete Pacífico', 'Tour por ciudades costeras del Pacífico', 3100.00, 1600.00, 280, 'Regular', 4);

-- Paquete 5 → Promoción 5
INSERT INTO Paquete_Turistico (PT_Nombre, PT_Descripcion, PT_Costo, PT_Costo_Millas, PT_Cant_Milla, PT_Tipo, Promocion_Promocion_ID)
VALUES ('Paquete Atlántico', 'Crucero de lujo por el Atlántico Norte', 4500.00, 2300.00, 420, 'Especial', 5);

-- Paquete 6 → Promoción 6
INSERT INTO Paquete_Turistico (PT_Nombre, PT_Descripcion, PT_Costo, PT_Costo_Millas, PT_Cant_Milla, PT_Tipo, Promocion_Promocion_ID)
VALUES ('Paquete Austral', 'Visita guiada a la Patagonia y Tierra del Fuego', 2700.00, 1400.00, 220, 'Regular', 6);

-- Paquete 7 → Promoción 7
INSERT INTO Paquete_Turistico (PT_Nombre, PT_Descripcion, PT_Costo, PT_Costo_Millas, PT_Cant_Milla, PT_Tipo, Promocion_Promocion_ID)
VALUES ('Paquete Polar', 'Expedición al círculo polar ártico', 5000.00, 2500.00, 500, 'Especial', 7);

-- Paquete 8 → Promoción 8
INSERT INTO Paquete_Turistico (PT_Nombre, PT_Descripcion, PT_Costo, PT_Costo_Millas, PT_Cant_Milla, PT_Tipo, Promocion_Promocion_ID)
VALUES ('Paquete Oriental', 'Tour cultural por Japón y Corea', 3200.00, 1700.00, 300, 'Regular', 8);

-- Paquete 9 → Promoción 9
INSERT INTO Paquete_Turistico (PT_Nombre, PT_Descripcion, PT_Costo, PT_Costo_Millas, PT_Cant_Milla, PT_Tipo, Promocion_Promocion_ID)
VALUES ('Paquete Occidental', 'Ruta histórica por ciudades europeas', 2900.00, 1500.00, 260, 'Especial', 9);

-- Paquete 10 → Promoción 10
INSERT INTO Paquete_Turistico (PT_Nombre, PT_Descripcion, PT_Costo, PT_Costo_Millas, PT_Cant_Milla, PT_Tipo, Promocion_Promocion_ID)
VALUES ('Paquete Horizonte', 'Viaje combinado de playa y montaña', 3300.00, 1600.00, 280, 'Regular', 10);



-- Restricción 1 → Paquete 1 (Caribeño)
INSERT INTO Restriccion_Paquete (RP_Tipo, RP_Descripción, Paquete_Turistico_PT_COD)
VALUES ('Edad mínima', 'El pasajero debe tener al menos 12 años para participar en el paquete Caribeño', 1);

-- Restricción 2 → Paquete 2 (Amazónico)
INSERT INTO Restriccion_Paquete (RP_Tipo, RP_Descripción, Paquete_Turistico_PT_COD)
VALUES ('Certificado médico', 'Se requiere certificado médico para excursiones en la selva amazónica', 2);

-- Restricción 3 → Paquete 3 (Mediterráneo)
INSERT INTO Restriccion_Paquete (RP_Tipo, RP_Descripción, Paquete_Turistico_PT_COD)
VALUES ('Pasaporte válido', 'Todos los pasajeros deben contar con pasaporte vigente para el crucero Mediterráneo', 3);

-- Restricción 4 → Paquete 4 (Pacífico)
INSERT INTO Restriccion_Paquete (RP_Tipo, RP_Descripción, Paquete_Turistico_PT_COD)
VALUES ('Temporada alta', 'El paquete Pacífico solo está disponible entre junio y septiembre', 4);

-- Restricción 5 → Paquete 5 (Atlántico)
INSERT INTO Restriccion_Paquete (RP_Tipo, RP_Descripción, Paquete_Turistico_PT_COD)
VALUES ('Cupo limitado', 'El crucero Atlántico tiene un máximo de 200 pasajeros por salida', 5);

-- Restricción 6 → Paquete 6 (Austral - Quinceañera)
INSERT INTO Restriccion_Paquete (RP_Tipo, RP_Descripción, Paquete_Turistico_PT_COD)
VALUES ('Edad exacta', 'El pasajero debe tener 15 años porque es un viaje de quinceañera', 6);

-- Restricción 7 → Paquete 7 (Polar)
INSERT INTO Restriccion_Paquete (RP_Tipo, RP_Descripción, Paquete_Turistico_PT_COD)
VALUES ('Condiciones climáticas', 'La expedición Polar depende de condiciones climáticas favorables', 7);

-- Restricción 8 → Paquete 8 (Oriental)
INSERT INTO Restriccion_Paquete (RP_Tipo, RP_Descripción, Paquete_Turistico_PT_COD)
VALUES ('Idioma', 'Se requiere conocimiento básico de inglés para el tour cultural por Japón y Corea', 8);

-- Restricción 9 → Paquete 9 (Occidental - Luna de miel)
INSERT INTO Restriccion_Paquete (RP_Tipo, RP_Descripción, Paquete_Turistico_PT_COD)
VALUES ('Estado civil', 'El pasajero debe estar casado porque es un paquete de luna de miel', 9);

-- Restricción 10 → Paquete 10 (Horizonte)
INSERT INTO Restriccion_Paquete (RP_Tipo, RP_Descripción, Paquete_Turistico_PT_COD)
VALUES ('Duración máxima', 'El paquete Horizonte no puede extenderse más de 10 días por pasajero', 10);


-- Itinerario 1 → Cliente 1 (Reserva 1 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (1, NULL, 600.00, 1, NULL, 1, NULL, NULL, TO_DATE('2025-12-09','YYYY-MM-DD'), TO_DATE('2025-12-12','YYYY-MM-DD'),
        1, 120, 1);

-- Itinerario 2 → Cliente 2 (Reserva 2 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (2, 1, 1650.00, NULL, 2, NULL, 1, NULL, TO_DATE('2025-12-09','YYYY-MM-DD'), TO_DATE('2025-12-15','YYYY-MM-DD'),
        2, 250, 2);

-- Itinerario 3 → Cliente 3 (Reserva 3 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (3, NULL, 45.00, NULL, 3, NULL, NULL, 1, TO_DATE('2025-12-09','YYYY-MM-DD'), TO_DATE('2025-12-10','YYYY-MM-DD'),
        3, 60, 3);

-- Itinerario 4 → Cliente 4 (Reserva 4 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (4, 2, 900.00, 2, NULL, 2, NULL, NULL, TO_DATE('2025-12-09','YYYY-MM-DD'), TO_DATE('2025-12-13','YYYY-MM-DD'),
        4, 180, 4);

-- Itinerario 5 → Cliente 5 (Reserva 5 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (5, NULL, 1320.00, 3, 3, NULL, 2, NULL, TO_DATE('2025-12-09','YYYY-MM-DD'), TO_DATE('2025-12-16','YYYY-MM-DD'),
        5, 300, 5);

-- Itinerario 6 → Cliente 6 (Reserva 6 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (6, 3, 28.00, NULL, NULL, NULL, NULL, 2, TO_DATE('2025-12-09','YYYY-MM-DD'), TO_DATE('2025-12-11','YYYY-MM-DD'),
        6, 45, 6);

-- Itinerario 7 → Cliente 7 (Reserva 7 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (7, NULL, 660.00, 4, 4, 3, NULL, NULL, TO_DATE('2025-12-09','YYYY-MM-DD'), TO_DATE('2025-12-14','YYYY-MM-DD'),
        7, 200, 7);

-- Itinerario 8 → Cliente 8 (Reserva 8 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (8, 4, 1485.00, 5, NULL, NULL, 3, NULL, TO_DATE('2025-12-09','YYYY-MM-DD'), TO_DATE('2025-12-15','YYYY-MM-DD'),
        8, 280, 8);

-- Itinerario 9 → Cliente 9 (Reserva 9 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (9, NULL, 39.00, NULL, 5, NULL, NULL, 3, TO_DATE('2025-12-09','YYYY-MM-DD'), TO_DATE('2025-12-11','YYYY-MM-DD'),
        9, 55, 9);

-- Itinerario 10 → Cliente 10 (Reserva 10 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (10, 5, 418.00, 6, NULL, 4, NULL, NULL, TO_DATE('2025-12-09','YYYY-MM-DD'), TO_DATE('2025-12-13','YYYY-MM-DD'),
        10, 150, 10);

-- Itinerario 11 → Cliente 11 (Reserva 11 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (1, NULL, 350.00, 2, NULL, 2, NULL, NULL, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-13','YYYY-MM-DD'),
        1, 160, 11);

-- Itinerario 12 → Cliente 12 (Reserva 12 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (2, 1, 1100.00, NULL, 3, NULL, 2, NULL, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-15','YYYY-MM-DD'),
        2, 280, 12);

-- Itinerario 13 → Cliente 13 (Reserva 13 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (3, NULL, 40.00, NULL, 4, NULL, NULL, 1, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-11','YYYY-MM-DD'),
        3, 55, 13);

-- Itinerario 14 → Cliente 14 (Reserva 14 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (4, 2, 460.00, 5, NULL, 3, NULL, NULL, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-14','YYYY-MM-DD'),
        4, 190, 14);

-- Itinerario 15 → Cliente 15 (Reserva 15 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (5, NULL, 1380.00, 6, 5, NULL, 3, NULL, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-16','YYYY-MM-DD'),
        5, 310, 15);

-- Itinerario 16 → Cliente 16 (Reserva 32 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (6, 3, 50.00, NULL, NULL, NULL, NULL, 2, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-11','YYYY-MM-DD'),
        6, 65, 16);

-- Itinerario 17 → Cliente 17 (Reserva 33 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (7, NULL, 395.00, 7, 6, 4, NULL, NULL, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-14','YYYY-MM-DD'),
        7, 175, 17);

-- Itinerario 18 → Cliente 18 (Reserva 34 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (8, 4, 1450.00, 8, NULL, NULL, 4, NULL, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-15','YYYY-MM-DD'),
        8, 295, 18);

-- Itinerario 19 → Cliente 19 (Reserva 35 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (9, NULL, 32.00, NULL, 7, NULL, NULL, 3, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-11','YYYY-MM-DD'),
        9, 48, 19);

-- Itinerario 20 → Cliente 20 (Reserva 36 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (10, 5, 450.00, 9, NULL, 5, NULL, NULL, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-14','YYYY-MM-DD'),
        10, 185, 20);
-- Itinerario 21 → Cliente 21 (Reserva 37 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (1, 1, 1500.00, 1, 1, NULL, 1, NULL, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-15','YYYY-MM-DD'),
        1, 305, 21);

-- Itinerario 22 → Cliente 22 (Reserva 38 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (2, 2, 36.00, NULL, 2, NULL, NULL, 2, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-11','YYYY-MM-DD'),
        2, 52, 22);

-- Itinerario 23 → Cliente 23 (Reserva 39 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (3, NULL, 375.00, 2, NULL, 2, NULL, NULL, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-13','YYYY-MM-DD'),
        3, 165, 23);

-- Itinerario 24 → Cliente 24 (Reserva 40 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (4, 3, 1600.00, 3, 3, NULL, 2, NULL, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-16','YYYY-MM-DD'),
        4, 325, 24);

-- Itinerario 25 → Cliente 25 (Reserva 41 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (5, NULL, 42.00, NULL, 4, NULL, NULL, 3, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-11','YYYY-MM-DD'),
        5, 58, 25);

-- Itinerario 26 → Cliente 26 (Reserva 42 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (6, 4, 470.00, 4, NULL, 3, NULL, NULL, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-14','YYYY-MM-DD'),
        6, 195, 26);

-- Itinerario 27 → Cliente 27 (Reserva 43 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (7, NULL, 1550.00, 5, 5, NULL, 3, NULL, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-16','YYYY-MM-DD'),
        7, 315, 27);

-- Itinerario 28 → Cliente 28 (Reserva 44 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (8, 5, 31.00, NULL, NULL, NULL, NULL, 4, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-11','YYYY-MM-DD'),
        8, 47, 28);

-- Itinerario 29 → Cliente 29 (Reserva 45 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (9, NULL, 345.00, 6, NULL, 4, NULL, NULL, TO_DATE('2025-12-10','YYYY-MM-DD'), TO_DATE('2025-12-13','YYYY-MM-DD'),
        9, 155, 29);

-- Itinerario 30 → Cliente 30 (Reserva 46 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (10, 6, 1350.00, 7, 6, NULL, 4, NULL, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-16','YYYY-MM-DD'),
        10, 300, 30);
-- Itinerario 31 → Cliente 31 (Reserva 47 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (1, NULL, 45.00, NULL, 1, NULL, NULL, 1, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-12','YYYY-MM-DD'),
        1, 55, 31);

-- Itinerario 32 → Cliente 32 (Reserva 48 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (2, 1, 420.00, 2, NULL, 2, NULL, NULL, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-14','YYYY-MM-DD'),
        2, 180, 32);

-- Itinerario 33 → Cliente 33 (Reserva 49 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (3, 2, 1450.00, 3, 2, NULL, 3, NULL, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-16','YYYY-MM-DD'),
        3, 310, 33);

-- Itinerario 34 → Cliente 34 (Reserva 50 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (4, NULL, 40.00, NULL, 3, NULL, NULL, 2, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-12','YYYY-MM-DD'),
        4, 60, 34);

-- Itinerario 35 → Cliente 35 (Reserva 51 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (5, 3, 490.00, 4, NULL, 4, NULL, NULL, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-14','YYYY-MM-DD'),
        5, 200, 35);

-- Itinerario 36 → Cliente 36 (Reserva 52 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (6, NULL, 1200.00, 5, 4, NULL, 4, NULL, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-16','YYYY-MM-DD'),
        6, 280, 36);

-- Itinerario 37 → Cliente 37 (Reserva 53 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (7, 4, 30.00, NULL, NULL, NULL, NULL, 3, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-12','YYYY-MM-DD'),
        7, 45, 37);

-- Itinerario 38 → Cliente 38 (Reserva 54 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (8, NULL, 395.00, 6, NULL, 5, NULL, NULL, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-14','YYYY-MM-DD'),
        8, 170, 38);

-- Itinerario 39 → Cliente 39 (Reserva 55 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (9, 5, 1550.00, 7, 5, NULL, 5, NULL, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-16','YYYY-MM-DD'),
        9, 320, 39);

-- Itinerario 40 → Cliente 40 (Reserva 56 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (10, NULL, 35.00, NULL, 6, NULL, NULL, 4, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-12','YYYY-MM-DD'),
        10, 50, 40);
-- Itinerario 41 → Cliente 41 (Reserva 57 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (1, 1, 440.00, 1, NULL, 6, NULL, NULL, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-14','YYYY-MM-DD'),
        1, 185, 41);

-- Itinerario 42 → Cliente 42 (Reserva 58 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (2, 2, 1500.00, 2, 2, NULL, 6, NULL, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-16','YYYY-MM-DD'),
        2, 305, 42);

-- Itinerario 43 → Cliente 43 (Reserva 59 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (3, NULL, 26.00, NULL, 3, NULL, NULL, 7, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-12','YYYY-MM-DD'),
        3, 42, 43);

-- Itinerario 44 → Cliente 44 (Reserva 60 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (4, 3, 470.00, 4, NULL, 7, NULL, NULL, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-14','YYYY-MM-DD'),
        4, 195, 44);

-- Itinerario 45 → Cliente 45 (Reserva 61 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (5, NULL, 1600.00, 5, 4, NULL, 7, NULL, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-16','YYYY-MM-DD'),
        5, 315, 45);

-- Itinerario 46 → Cliente 46 (Reserva 62 - Transporte terrestre)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (6, 4, 45.00, NULL, NULL, NULL, NULL, 8, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-12','YYYY-MM-DD'),
        6, 60, 46);

-- Itinerario 47 → Cliente 47 (Reserva 63 - Vuelo)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (7, NULL, 405.00, 6, 5, 8, NULL, NULL, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-14','YYYY-MM-DD'),
        7, 175, 47);

-- Itinerario 48 → Cliente 48 (Reserva 64 - Crucero)
INSERT INTO Itinerario (Paquete_Turistico_PT_COD, Comida_Com_COD, Iti_Costo_Total, Hospedaje_Hos_COD, Restaurante_Rest_COD,
                        Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Iti_Fecha_Inicio, Iti_Fecha_Fin,
                        Servicio_Adicional_SA_COD, Iti_Cant_Milla_Total, Reserva_Res_COD)
VALUES (8, 5, 1650.00, 7, 6, NULL, 8, NULL, TO_DATE('2025-12-11','YYYY-MM-DD'), TO_DATE('2025-12-16','YYYY-MM-DD'),
        8, 330, 48);




-- Ruta 1 → Vuelo desde Terminal 1
INSERT INTO Ruta (Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Terminal_Ter_COD,
                  Rut_Fecha_Hora_Salida, Rut_Fecha_Hora_Llegada)
VALUES (1, NULL, NULL, 1,
        TO_TIMESTAMP('2025-12-12 08:00:00','YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('2025-12-12 12:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Ruta 2 → Crucero desde Terminal 2
INSERT INTO Ruta (Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Terminal_Ter_COD,
                  Rut_Fecha_Hora_Salida, Rut_Fecha_Hora_Llegada)
VALUES (NULL, 1, NULL, 2,
        TO_TIMESTAMP('2025-12-12 09:00:00','YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('2025-12-14 18:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Ruta 3 → Transporte terrestre desde Terminal 3
INSERT INTO Ruta (Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Terminal_Ter_COD,
                  Rut_Fecha_Hora_Salida, Rut_Fecha_Hora_Llegada)
VALUES (NULL, NULL, 1, 3,
        TO_TIMESTAMP('2025-12-12 07:30:00','YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('2025-12-12 10:30:00','YYYY-MM-DD HH24:MI:SS'));

-- Ruta 4 → Vuelo desde Terminal 4
INSERT INTO Ruta (Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Terminal_Ter_COD,
                  Rut_Fecha_Hora_Salida, Rut_Fecha_Hora_Llegada)
VALUES (2, NULL, NULL, 4,
        TO_TIMESTAMP('2025-12-13 06:00:00','YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('2025-12-13 09:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Ruta 5 → Crucero desde Terminal 5
INSERT INTO Ruta (Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Terminal_Ter_COD,
                  Rut_Fecha_Hora_Salida, Rut_Fecha_Hora_Llegada)
VALUES (NULL, 2, NULL, 5,
        TO_TIMESTAMP('2025-12-13 10:00:00','YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('2025-12-15 20:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Ruta 6 → Transporte terrestre desde Terminal 6
INSERT INTO Ruta (Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Terminal_Ter_COD,
                  Rut_Fecha_Hora_Salida, Rut_Fecha_Hora_Llegada)
VALUES (NULL, NULL, 2, 6,
        TO_TIMESTAMP('2025-12-13 08:00:00','YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('2025-12-13 12:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Ruta 7 → Vuelo desde Terminal 7
INSERT INTO Ruta (Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Terminal_Ter_COD,
                  Rut_Fecha_Hora_Salida, Rut_Fecha_Hora_Llegada)
VALUES (3, NULL, NULL, 7,
        TO_TIMESTAMP('2025-12-14 07:00:00','YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('2025-12-14 11:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Ruta 8 → Crucero desde Terminal 8
INSERT INTO Ruta (Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Terminal_Ter_COD,
                  Rut_Fecha_Hora_Salida, Rut_Fecha_Hora_Llegada)
VALUES (NULL, 3, NULL, 8,
        TO_TIMESTAMP('2025-12-14 09:00:00','YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('2025-12-16 19:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Ruta 9 → Transporte terrestre desde Terminal 9
INSERT INTO Ruta (Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Terminal_Ter_COD,
                  Rut_Fecha_Hora_Salida, Rut_Fecha_Hora_Llegada)
VALUES (NULL, NULL, 3, 9,
        TO_TIMESTAMP('2025-12-14 06:30:00','YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('2025-12-14 09:30:00','YYYY-MM-DD HH24:MI:SS'));

-- Ruta 10 → Vuelo desde Terminal 10
INSERT INTO Ruta (Vuelo_Vue_COD, Crucero_Cru_COD, Transporte_Terrestre_TT_COD, Terminal_Ter_COD,
                  Rut_Fecha_Hora_Salida, Rut_Fecha_Hora_Llegada)
VALUES (4, NULL, NULL, 10,
        TO_TIMESTAMP('2025-12-15 08:00:00','YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('2025-12-15 12:00:00','YYYY-MM-DD HH24:MI:SS'));



-- Reclamo 1 → Itinerario 1
INSERT INTO Reclamo (Rec_Descripcion, Itinerario_Iti_COD)
VALUES ('Retraso en el vuelo de salida', 1);

-- Reclamo 2 → Itinerario 2
INSERT INTO Reclamo (Rec_Descripcion, Itinerario_Iti_COD)
VALUES ('Problemas con la asignación de camarote en el crucero', 2);

-- Reclamo 3 → Itinerario 3
INSERT INTO Reclamo (Rec_Descripcion, Itinerario_Iti_COD)
VALUES ('El transporte terrestre llegó con dos horas de retraso', 3);

-- Reclamo 4 → Itinerario 4
INSERT INTO Reclamo (Rec_Descripcion, Itinerario_Iti_COD)
VALUES ('El vuelo sufrió cancelación y fue reprogramado', 4);

-- Reclamo 5 → Itinerario 5
INSERT INTO Reclamo (Rec_Descripcion, Itinerario_Iti_COD)
VALUES ('El crucero no incluyó la excursión prometida', 5);

-- Reclamo 6 → Itinerario 6
INSERT INTO Reclamo (Rec_Descripcion, Itinerario_Iti_COD)
VALUES ('El transporte terrestre presentó fallas mecánicas durante el trayecto', 6);

-- Reclamo 7 → Itinerario 7
INSERT INTO Reclamo (Rec_Descripcion, Itinerario_Iti_COD)
VALUES ('El vuelo tuvo sobreventa de boletos y se reasignaron asientos', 7);

-- Reclamo 8 → Itinerario 8
INSERT INTO Reclamo (Rec_Descripcion, Itinerario_Iti_COD)
VALUES ('El crucero presentó retraso en la salida del puerto', 8);

-- Reclamo 9 → Itinerario 9
INSERT INTO Reclamo (Rec_Descripcion, Itinerario_Iti_COD)
VALUES ('El transporte terrestre no pasó por la terminal indicada', 9);

-- Reclamo 10 → Itinerario 10
INSERT INTO Reclamo (Rec_Descripcion, Itinerario_Iti_COD)
VALUES ('El vuelo no incluyó el servicio de comida contratado', 10);



-- Reseña 11 → Itinerario 11
INSERT INTO Resenas (Itinerario_Iti_COD, Rese_Descripcion)
VALUES (11, 'El vuelo fue cómodo y el hospedaje cumplió con todas las expectativas');

-- Reseña 12 → Itinerario 12
INSERT INTO Resenas (Itinerario_Iti_COD, Rese_Descripcion)
VALUES (12, 'El crucero ofreció entretenimiento variado y excelente atención en el restaurante');

-- Reseña 13 → Itinerario 13
INSERT INTO Resenas (Itinerario_Iti_COD, Rese_Descripcion)
VALUES (13, 'El transporte terrestre fue puntual y el conductor muy servicial');

-- Reseña 14 → Itinerario 14
INSERT INTO Resenas (Itinerario_Iti_COD, Rese_Descripcion)
VALUES (14, 'El vuelo salió a tiempo y el hospedaje fue muy confortable');

-- Reseña 15 → Itinerario 15
INSERT INTO Resenas (Itinerario_Iti_COD, Rese_Descripcion)
VALUES (15, 'El crucero incluyó actividades culturales y el camarote fue muy cómodo');

-- Reseña 16 → Itinerario 16
INSERT INTO Resenas (Itinerario_Iti_COD, Rese_Descripcion)
VALUES (16, 'El transporte terrestre fue seguro y el restaurante ofreció buena comida local');

-- Reseña 17 → Itinerario 17
INSERT INTO Resenas (Itinerario_Iti_COD, Rese_Descripcion)
VALUES (17, 'El vuelo fue eficiente y el servicio adicional mejoró la experiencia');

-- Reseña 18 → Itinerario 18
INSERT INTO Resenas (Itinerario_Iti_COD, Rese_Descripcion)
VALUES (18, 'El crucero tuvo un itinerario bien organizado y el hospedaje fue excelente');

-- Reseña 19 → Itinerario 19
INSERT INTO Resenas (Itinerario_Iti_COD, Rese_Descripcion)
VALUES (19, 'El transporte terrestre cumplió con los horarios y el restaurante fue agradable');

-- Reseña 20 → Itinerario 20
INSERT INTO Resenas (Itinerario_Iti_COD, Rese_Descripcion)
VALUES (20, 'El vuelo fue puntual y el hospedaje ofreció todas las comodidades necesarias');

-- Reseña 21 → Itinerario 21
INSERT INTO Resenas (Itinerario_Iti_COD, Rese_Descripcion)
VALUES (21, 'El crucero brindó un excelente servicio y el restaurante tuvo platos variados');



-- Cliente 1 usa Método de Pago 1
INSERT INTO Cli_MP (Metodo_de_Pago_MP_COD, Cliente_Cli_COD)
VALUES (1, 1);

-- Cliente 2 usa Método de Pago 2
INSERT INTO Cli_MP (Metodo_de_Pago_MP_COD, Cliente_Cli_COD)
VALUES (2, 2);

-- Cliente 3 usa Método de Pago 3
INSERT INTO Cli_MP (Metodo_de_Pago_MP_COD, Cliente_Cli_COD)
VALUES (3, 3);

-- Cliente 4 usa Método de Pago 4
INSERT INTO Cli_MP (Metodo_de_Pago_MP_COD, Cliente_Cli_COD)
VALUES (4, 4);

-- Cliente 5 usa Método de Pago 5
INSERT INTO Cli_MP (Metodo_de_Pago_MP_COD, Cliente_Cli_COD)
VALUES (5, 5);

-- Cliente 6 usa Método de Pago 6
INSERT INTO Cli_MP (Metodo_de_Pago_MP_COD, Cliente_Cli_COD)
VALUES (6, 6);

-- Cliente 7 usa Método de Pago 7
INSERT INTO Cli_MP (Metodo_de_Pago_MP_COD, Cliente_Cli_COD)
VALUES (7, 7);

-- Cliente 8 usa Método de Pago 8
INSERT INTO Cli_MP (Metodo_de_Pago_MP_COD, Cliente_Cli_COD)
VALUES (8, 8);

-- Cliente 9 usa Método de Pago 9
INSERT INTO Cli_MP (Metodo_de_Pago_MP_COD, Cliente_Cli_COD)
VALUES (9, 9);

-- Cliente 10 usa Método de Pago 10
INSERT INTO Cli_MP (Metodo_de_Pago_MP_COD, Cliente_Cli_COD)
VALUES (10, 10);



-- Pasajero 1 con Documento 1
INSERT INTO Doc_Pas (Documento_Doc_COD, Pasajero_Pas_COD)
VALUES (1, 1);

-- Pasajero 2 con Documento 2
INSERT INTO Doc_Pas (Documento_Doc_COD, Pasajero_Pas_COD)
VALUES (2, 2);

-- Pasajero 3 con Documento 3
INSERT INTO Doc_Pas (Documento_Doc_COD, Pasajero_Pas_COD)
VALUES (3, 3);

-- Pasajero 4 con Documento 4
INSERT INTO Doc_Pas (Documento_Doc_COD, Pasajero_Pas_COD)
VALUES (4, 4);

-- Pasajero 5 con Documento 5
INSERT INTO Doc_Pas (Documento_Doc_COD, Pasajero_Pas_COD)
VALUES (5, 5);

-- Pasajero 6 con Documento 6
INSERT INTO Doc_Pas (Documento_Doc_COD, Pasajero_Pas_COD)
VALUES (6, 6);

-- Pasajero 7 con Documento 7
INSERT INTO Doc_Pas (Documento_Doc_COD, Pasajero_Pas_COD)
VALUES (7, 7);

-- Pasajero 8 con Documento 8
INSERT INTO Doc_Pas (Documento_Doc_COD, Pasajero_Pas_COD)
VALUES (8, 8);

-- Pasajero 9 con Documento 9
INSERT INTO Doc_Pas (Documento_Doc_COD, Pasajero_Pas_COD)
VALUES (9, 9);

-- Pasajero 10 con Documento 10
INSERT INTO Doc_Pas (Documento_Doc_COD, Pasajero_Pas_COD)
VALUES (10, 10);



-- Pago 1 → Completo (Reserva 1)
INSERT INTO Pago (PAG_Fecha_Hora, PAG_Total, Tasa_de_Cambio_TC_COD,
                  Cli_MP_MP_COD, Cli_MP_Cli_COD, Pag_Total_Milla,
                  Cuota_Cuo_COD, Reserva_Res_COD)
VALUES (TO_TIMESTAMP('2025-12-12 09:00:00','YYYY-MM-DD HH24:MI:SS'),
        420.00, 1, 1, 1, 120, NULL, 1);

-- Pago 2 → En cuotas (Cuota 2)
INSERT INTO Pago (PAG_Fecha_Hora, PAG_Total, Tasa_de_Cambio_TC_COD,
                  Cli_MP_MP_COD, Cli_MP_Cli_COD, Pag_Total_Milla,
                  Cuota_Cuo_COD, Reserva_Res_COD)
VALUES (TO_TIMESTAMP('2025-12-12 10:00:00','YYYY-MM-DD HH24:MI:SS'),
        210.00, 2, 2, 2, 60, 2, NULL);

-- Pago 3 → Completo (Reserva 3)
INSERT INTO Pago (PAG_Fecha_Hora, PAG_Total, Tasa_de_Cambio_TC_COD,
                  Cli_MP_MP_COD, Cli_MP_Cli_COD, Pag_Total_Milla,
                  Cuota_Cuo_COD, Reserva_Res_COD)
VALUES (TO_TIMESTAMP('2025-12-12 11:00:00','YYYY-MM-DD HH24:MI:SS'),
        55.00, 3, 3, 3, 60, NULL, 3);

-- Pago 4 → En cuotas (Cuota 4)
INSERT INTO Pago (PAG_Fecha_Hora, PAG_Total, Tasa_de_Cambio_TC_COD,
                  Cli_MP_MP_COD, Cli_MP_Cli_COD, Pag_Total_Milla,
                  Cuota_Cuo_COD, Reserva_Res_COD)
VALUES (TO_TIMESTAMP('2025-12-12 12:00:00','YYYY-MM-DD HH24:MI:SS'),
        300.00, 4, 4, 4, 100, 4, NULL);

-- Pago 5 → Completo (Reserva 5)
INSERT INTO Pago (PAG_Fecha_Hora, PAG_Total, Tasa_de_Cambio_TC_COD,
                  Cli_MP_MP_COD, Cli_MP_Cli_COD, Pag_Total_Milla,
                  Cuota_Cuo_COD, Reserva_Res_COD)
VALUES (TO_TIMESTAMP('2025-12-12 13:00:00','YYYY-MM-DD HH24:MI:SS'),
        1320.00, 5, 5, 5, 300, NULL, 5);

-- Pago 6 → En cuotas (Cuota 6)
INSERT INTO Pago (PAG_Fecha_Hora, PAG_Total, Tasa_de_Cambio_TC_COD,
                  Cli_MP_MP_COD, Cli_MP_Cli_COD, Pag_Total_Milla,
                  Cuota_Cuo_COD, Reserva_Res_COD)
VALUES (TO_TIMESTAMP('2025-12-12 14:00:00','YYYY-MM-DD HH24:MI:SS'),
        28.00, 6, 6, 6, 45, 6, NULL);

-- Pago 7 → Completo (Reserva 7)
INSERT INTO Pago (PAG_Fecha_Hora, PAG_Total, Tasa_de_Cambio_TC_COD,
                  Cli_MP_MP_COD, Cli_MP_Cli_COD, Pag_Total_Milla,
                  Cuota_Cuo_COD, Reserva_Res_COD)
VALUES (TO_TIMESTAMP('2025-12-12 15:00:00','YYYY-MM-DD HH24:MI:SS'),
        660.00, 7, 7, 7, 200, NULL, 7);

-- Pago 8 → En cuotas (Cuota 8)
INSERT INTO Pago (PAG_Fecha_Hora, PAG_Total, Tasa_de_Cambio_TC_COD,
                  Cli_MP_MP_COD, Cli_MP_Cli_COD, Pag_Total_Milla,
                  Cuota_Cuo_COD, Reserva_Res_COD)
VALUES (TO_TIMESTAMP('2025-12-12 16:00:00','YYYY-MM-DD HH24:MI:SS'),
        495.00, 8, 8, 8, 95, 8, NULL);

-- Pago 9 → Completo (Reserva 9)
INSERT INTO Pago (PAG_Fecha_Hora, PAG_Total, Tasa_de_Cambio_TC_COD,
                  Cli_MP_MP_COD, Cli_MP_Cli_COD, Pag_Total_Milla,
                  Cuota_Cuo_COD, Reserva_Res_COD)
VALUES (TO_TIMESTAMP('2025-12-12 17:00:00','YYYY-MM-DD HH24:MI:SS'),
        39.00, 9, 9, 9, 55, NULL, 9);

-- Pago 10 → En cuotas (Cuota 10)
INSERT INTO Pago (PAG_Fecha_Hora, PAG_Total, Tasa_de_Cambio_TC_COD,
                  Cli_MP_MP_COD, Cli_MP_Cli_COD, Pag_Total_Milla,
                  Cuota_Cuo_COD, Reserva_Res_COD)
VALUES (TO_TIMESTAMP('2025-12-12 18:00:00','YYYY-MM-DD HH24:MI:SS'),
        150.00, 10, 10, 10, 50, 10, NULL);




-- Pago Reembolsado 1
INSERT INTO Pago_Reembolsado (Reembolso_Rem_COD, Metodo_de_Pago_MP_COD, Fecha_Hora_Reembolso,
                              Monto_Reembolso, Divisa_Utilizada, Tasa_Aplicada, Tasa_de_Cambio_TC_COD)
VALUES (1, 1, TO_TIMESTAMP('2025-12-12 09:00:00','YYYY-MM-DD HH24:MI:SS'),
        120.00, 'USD', 1.00, 1);

-- Pago Reembolsado 2
INSERT INTO Pago_Reembolsado (Reembolso_Rem_COD, Metodo_de_Pago_MP_COD, Fecha_Hora_Reembolso,
                              Monto_Reembolso, Divisa_Utilizada, Tasa_Aplicada, Tasa_de_Cambio_TC_COD)
VALUES (2, 2, TO_TIMESTAMP('2025-12-12 10:00:00','YYYY-MM-DD HH24:MI:SS'),
        250.00, 'EUR', 0.95, 2);

-- Pago Reembolsado 3
INSERT INTO Pago_Reembolsado (Reembolso_Rem_COD, Metodo_de_Pago_MP_COD, Fecha_Hora_Reembolso,
                              Monto_Reembolso, Divisa_Utilizada, Tasa_Aplicada, Tasa_de_Cambio_TC_COD)
VALUES (3, 3, TO_TIMESTAMP('2025-12-12 11:00:00','YYYY-MM-DD HH24:MI:SS'),
        75.00, 'USD', 1.02, 3);

-- Pago Reembolsado 4
INSERT INTO Pago_Reembolsado (Reembolso_Rem_COD, Metodo_de_Pago_MP_COD, Fecha_Hora_Reembolso,
                              Monto_Reembolso, Divisa_Utilizada, Tasa_Aplicada, Tasa_de_Cambio_TC_COD)
VALUES (4, 4, TO_TIMESTAMP('2025-12-12 12:00:00','YYYY-MM-DD HH24:MI:SS'),
        310.00, 'GBP', 0.80, 4);

-- Pago Reembolsado 5
INSERT INTO Pago_Reembolsado (Reembolso_Rem_COD, Metodo_de_Pago_MP_COD, Fecha_Hora_Reembolso,
                              Monto_Reembolso, Divisa_Utilizada, Tasa_Aplicada, Tasa_de_Cambio_TC_COD)
VALUES (5, 5, TO_TIMESTAMP('2025-12-12 13:00:00','YYYY-MM-DD HH24:MI:SS'),
        500.00, 'USD', 1.05, 5);

-- Pago Reembolsado 6
INSERT INTO Pago_Reembolsado (Reembolso_Rem_COD, Metodo_de_Pago_MP_COD, Fecha_Hora_Reembolso,
                              Monto_Reembolso, Divisa_Utilizada, Tasa_Aplicada, Tasa_de_Cambio_TC_COD)
VALUES (6, 6, TO_TIMESTAMP('2025-12-12 14:00:00','YYYY-MM-DD HH24:MI:SS'),
        95.00, 'EUR', 0.97, 6);

-- Pago Reembolsado 7
INSERT INTO Pago_Reembolsado (Reembolso_Rem_COD, Metodo_de_Pago_MP_COD, Fecha_Hora_Reembolso,
                              Monto_Reembolso, Divisa_Utilizada, Tasa_Aplicada, Tasa_de_Cambio_TC_COD)
VALUES (7, 7, TO_TIMESTAMP('2025-12-12 15:00:00','YYYY-MM-DD HH24:MI:SS'),
        220.00, 'USD', 1.01, 7);

-- Pago Reembolsado 8
INSERT INTO Pago_Reembolsado (Reembolso_Rem_COD, Metodo_de_Pago_MP_COD, Fecha_Hora_Reembolso,
                              Monto_Reembolso, Divisa_Utilizada, Tasa_Aplicada, Tasa_de_Cambio_TC_COD)
VALUES (8, 8, TO_TIMESTAMP('2025-12-12 16:00:00','YYYY-MM-DD HH24:MI:SS'),
        340.00, 'CAD', 1.25, 8);

-- Pago Reembolsado 9
INSERT INTO Pago_Reembolsado (Reembolso_Rem_COD, Metodo_de_Pago_MP_COD, Fecha_Hora_Reembolso,
                              Monto_Reembolso, Divisa_Utilizada, Tasa_Aplicada, Tasa_de_Cambio_TC_COD)
VALUES (9, 9, TO_TIMESTAMP('2025-12-12 17:00:00','YYYY-MM-DD HH24:MI:SS'),
        410.00, 'USD', 1.03, 9);

-- Pago Reembolsado 10
INSERT INTO Pago_Reembolsado (Reembolso_Rem_COD, Metodo_de_Pago_MP_COD, Fecha_Hora_Reembolso,
                              Monto_Reembolso, Divisa_Utilizada, Tasa_Aplicada, Tasa_de_Cambio_TC_COD)
VALUES (10, 10, TO_TIMESTAMP('2025-12-12 18:00:00','YYYY-MM-DD HH24:MI:SS'),
        275.00, 'EUR', 0.96, 10);



-- Preferencia 1 → Cliente 1 en Itinerario 1
INSERT INTO Preferencia (Itinerario_Iti_COD, Cliente_Cli_COD, Pre_Descripcion)
VALUES (1, 1, 'Prefiere asiento junto a la ventana en el vuelo');

-- Preferencia 2 → Cliente 2 en Itinerario 2
INSERT INTO Preferencia (Itinerario_Iti_COD, Cliente_Cli_COD, Pre_Descripcion)
VALUES (2, 2, 'Prefiere camarote con vista al mar en el crucero');

-- Preferencia 3 → Cliente 3 en Itinerario 3
INSERT INTO Preferencia (Itinerario_Iti_COD, Cliente_Cli_COD, Pre_Descripcion)
VALUES (3, 3, 'Prefiere transporte terrestre con aire acondicionado');

-- Preferencia 4 → Cliente 4 en Itinerario 4
INSERT INTO Preferencia (Itinerario_Iti_COD, Cliente_Cli_COD, Pre_Descripcion)
VALUES (4, 4, 'Prefiere hospedaje cercano al centro histórico');

-- Preferencia 5 → Cliente 5 en Itinerario 5
INSERT INTO Preferencia (Itinerario_Iti_COD, Cliente_Cli_COD, Pre_Descripcion)
VALUES (5, 5, 'Prefiere menú vegetariano en el restaurante');

-- Preferencia 6 → Cliente 6 en Itinerario 6
INSERT INTO Preferencia (Itinerario_Iti_COD, Cliente_Cli_COD, Pre_Descripcion)
VALUES (6, 6, 'Prefiere transporte terrestre con asientos reclinables');

-- Preferencia 7 → Cliente 7 en Itinerario 7
INSERT INTO Preferencia (Itinerario_Iti_COD, Cliente_Cli_COD, Pre_Descripcion)
VALUES (7, 7, 'Prefiere vuelo en horario nocturno');

-- Preferencia 8 → Cliente 8 en Itinerario 8
INSERT INTO Preferencia (Itinerario_Iti_COD, Cliente_Cli_COD, Pre_Descripcion)
VALUES (8, 8, 'Prefiere crucero con actividades familiares');

-- Preferencia 9 → Cliente 9 en Itinerario 9
INSERT INTO Preferencia (Itinerario_Iti_COD, Cliente_Cli_COD, Pre_Descripcion)
VALUES (9, 9, 'Prefiere hospedaje con desayuno incluido');

-- Preferencia 10 → Cliente 10 en Itinerario 10
INSERT INTO Preferencia (Itinerario_Iti_COD, Cliente_Cli_COD, Pre_Descripcion)
VALUES (10, 10, 'Prefiere restaurante con opciones de comida local');



-- Registro 1 → Asociado a Reserva (Reserva 1)
INSERT INTO Registro_Reclamos (Fecha_Inicio, Fecha_Fin, Estatus_Est_COD,
                               Reserva_Res_COD, Reclamo_Rec_COD)
VALUES (DATE '2025-12-01', DATE '2025-12-05', 1, 1, NULL);

-- Registro 2 → Asociado a Reclamo (Reclamo 1)
INSERT INTO Registro_Reclamos (Fecha_Inicio, Fecha_Fin, Estatus_Est_COD,
                               Reserva_Res_COD, Reclamo_Rec_COD)
VALUES (DATE '2025-12-02', DATE '2025-12-06', 2, NULL, 1);

-- Registro 3 → Asociado a Reserva (Reserva 2)
INSERT INTO Registro_Reclamos (Fecha_Inicio, Fecha_Fin, Estatus_Est_COD,
                               Reserva_Res_COD, Reclamo_Rec_COD)
VALUES (DATE '2025-12-03', DATE '2025-12-07', 3, 2, NULL);

-- Registro 4 → Asociado a Reclamo (Reclamo 2)
INSERT INTO Registro_Reclamos (Fecha_Inicio, Fecha_Fin, Estatus_Est_COD,
                               Reserva_Res_COD, Reclamo_Rec_COD)
VALUES (DATE '2025-12-04', DATE '2025-12-08', 1, NULL, 2);

-- Registro 5 → Asociado a Reserva (Reserva 3)
INSERT INTO Registro_Reclamos (Fecha_Inicio, Fecha_Fin, Estatus_Est_COD,
                               Reserva_Res_COD, Reclamo_Rec_COD)
VALUES (DATE '2025-12-05', DATE '2025-12-09', 2, 3, NULL);

-- Registro 6 → Asociado a Reclamo (Reclamo 3)
INSERT INTO Registro_Reclamos (Fecha_Inicio, Fecha_Fin, Estatus_Est_COD,
                               Reserva_Res_COD, Reclamo_Rec_COD)
VALUES (DATE '2025-12-06', DATE '2025-12-10', 3, NULL, 3);

-- Registro 7 → Asociado a Reserva (Reserva 4)
INSERT INTO Registro_Reclamos (Fecha_Inicio, Fecha_Fin, Estatus_Est_COD,
                               Reserva_Res_COD, Reclamo_Rec_COD)
VALUES (DATE '2025-12-07', DATE '2025-12-11', 1, 4, NULL);

-- Registro 8 → Asociado a Reclamo (Reclamo 4)
INSERT INTO Registro_Reclamos (Fecha_Inicio, Fecha_Fin, Estatus_Est_COD,
                               Reserva_Res_COD, Reclamo_Rec_COD)
VALUES (DATE '2025-12-08', DATE '2025-12-12', 2, NULL, 4);

-- Registro 9 → Asociado a Reserva (Reserva 5)
INSERT INTO Registro_Reclamos (Fecha_Inicio, Fecha_Fin, Estatus_Est_COD,
                               Reserva_Res_COD, Reclamo_Rec_COD)
VALUES (DATE '2025-12-09', DATE '2025-12-13', 3, 5, NULL);

-- Registro 10 → Asociado a Reclamo (Reclamo 5)
INSERT INTO Registro_Reclamos (Fecha_Inicio, Fecha_Fin, Estatus_Est_COD,
                               Reserva_Res_COD, Reclamo_Rec_COD)
VALUES (DATE '2025-12-10', DATE '2025-12-14', 1, NULL, 5);




-- Administrador con privilegio de Lectura en Cliente
INSERT INTO Pri_Rol (Rol_Rol_COD, Privilegio_Pri_COD)
VALUES (1, 1);

-- Administrador con privilegio de Escritura en Cliente
INSERT INTO Pri_Rol (Rol_Rol_COD, Privilegio_Pri_COD)
VALUES (1, 2);

-- Administrador con privilegio de Actualización en Cliente
INSERT INTO Pri_Rol (Rol_Rol_COD, Privilegio_Pri_COD)
VALUES (1, 3);

-- Administrador con privilegio de Eliminación en Cliente
INSERT INTO Pri_Rol (Rol_Rol_COD, Privilegio_Pri_COD)
VALUES (1, 4);

-- Cliente con privilegio de Lectura en Reserva
INSERT INTO Pri_Rol (Rol_Rol_COD, Privilegio_Pri_COD)
VALUES (2, 5);

-- Cliente con privilegio de Escritura en Reserva
INSERT INTO Pri_Rol (Rol_Rol_COD, Privilegio_Pri_COD)
VALUES (2, 6);

-- Empleado con privilegio de Actualización en Reserva
INSERT INTO Pri_Rol (Rol_Rol_COD, Privilegio_Pri_COD)
VALUES (3, 7);

-- Auditor con privilegio de Lectura en Itinerario
INSERT INTO Pri_Rol (Rol_Rol_COD, Privilegio_Pri_COD)
VALUES (8, 9);

-- Soporte con privilegio de Escritura en Itinerario
INSERT INTO Pri_Rol (Rol_Rol_COD, Privilegio_Pri_COD)
VALUES (9, 10);

-- Invitado con privilegio de Lectura en Cliente
INSERT INTO Pri_Rol (Rol_Rol_COD, Privilegio_Pri_COD)
VALUES (10, 1);



-- Wishlist 1 → Cliente 1 en Itinerario 1
INSERT INTO Wishlist (Wis_Descripcion, Cliente_Cli_COD, Itinerario_Iti_COD)
VALUES ('Desea incluir visita a un museo local', 1, 1);

-- Wishlist 2 → Cliente 2 en Itinerario 2
INSERT INTO Wishlist (Wis_Descripcion, Cliente_Cli_COD, Itinerario_Iti_COD)
VALUES ('Quiere hospedaje con vista al mar', 2, 2);

-- Wishlist 3 → Cliente 3 en Itinerario 3
INSERT INTO Wishlist (Wis_Descripcion, Cliente_Cli_COD, Itinerario_Iti_COD)
VALUES ('Prefiere transporte terrestre privado', 3, 3);

-- Wishlist 4 → Cliente 4 en Itinerario 4
INSERT INTO Wishlist (Wis_Descripcion, Cliente_Cli_COD, Itinerario_Iti_COD)
VALUES ('Desea vuelo en clase ejecutiva', 4, 4);

-- Wishlist 5 → Cliente 5 en Itinerario 5
INSERT INTO Wishlist (Wis_Descripcion, Cliente_Cli_COD, Itinerario_Iti_COD)
VALUES ('Quiere incluir cena en restaurante gourmet', 5, 5);

-- Wishlist 6 → Cliente 6 en Itinerario 6
INSERT INTO Wishlist (Wis_Descripcion, Cliente_Cli_COD, Itinerario_Iti_COD)
VALUES ('Prefiere actividades culturales en el destino', 6, 6);

-- Wishlist 7 → Cliente 7 en Itinerario 7
INSERT INTO Wishlist (Wis_Descripcion, Cliente_Cli_COD, Itinerario_Iti_COD)
VALUES ('Desea hospedaje con spa incluido', 7, 7);

-- Wishlist 8 → Cliente 8 en Itinerario 8
INSERT INTO Wishlist (Wis_Descripcion, Cliente_Cli_COD, Itinerario_Iti_COD)
VALUES ('Quiere crucero con excursiones adicionales', 8, 8);

-- Wishlist 9 → Cliente 9 en Itinerario 9
INSERT INTO Wishlist (Wis_Descripcion, Cliente_Cli_COD, Itinerario_Iti_COD)
VALUES ('Prefiere transporte terrestre con chofer bilingüe', 9, 9);

-- Wishlist 10 → Cliente 10 en Itinerario 10
INSERT INTO Wishlist (Wis_Descripcion, Cliente_Cli_COD, Itinerario_Iti_COD)
VALUES ('Desea incluir visita guiada al centro histórico', 10, 10);

