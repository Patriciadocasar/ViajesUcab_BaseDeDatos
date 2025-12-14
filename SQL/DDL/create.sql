CREATE TABLE Auditoria (
    Aud_COD SERIAL PRIMARY KEY,
    Aud_Fecha_Hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Aud_Accion VARCHAR(90) NOT NULL,
    Usuario_Usu_COD INTEGER,
    Aud_Tabla_Cambiada VARCHAR(70) NOT NULL,
    Aud_Descripcion TEXT NOT NULL,
    Aud_Registro_Cambiado VARCHAR(80) NOT NULL
);

CREATE TABLE Avion (
    Avi_COD SERIAL PRIMARY KEY,
    Avi_Tipo VARCHAR(80) NOT NULL,
    Avi_Capacidad INT NOT NULL,
    Aerolinea_Pro_COD INTEGER
);

CREATE TABLE Barco (
    Bar_COD SERIAL PRIMARY KEY,
    Bar_Nombre VARCHAR(80) NOT NULL,
    Bar_Capacidad INT NOT NULL,
    Compania_Crucero_Pro_COD INTEGER
);

CREATE TABLE Cli_MP (
    Metodo_de_Pago_MP_COD INTEGER,
    Cliente_Cli_COD INTEGER,
    PRIMARY KEY (Metodo_de_Pago_MP_COD, Cliente_Cli_COD)
);

CREATE TABLE Cliente (
    Cli_COD SERIAL PRIMARY KEY,
    Cli_Primer_Nombre VARCHAR(60) NOT NULL,
    Cli_Segundo_Nombre VARCHAR(80),
    Cli_Apellido VARCHAR(80) NOT NULL,
    Cli_Segundo_Apellido VARCHAR(80),
    Cli_Fecha_Nacimiento DATE NOT NULL,
    Cli_Estado_Civil VARCHAR(60) NOT NULL,
    Cli_Millas_Acum NUMERIC(6) NOT NULL,
    Lugar_Lug_COD INTEGER
);


CREATE TABLE Crucero (
    Cru_COD SERIAL PRIMARY KEY,
    Cru_nombre VARCHAR(70) NOT NULL,
    Barco_Bar_COD INTEGER,
    Cru_Huella_Carbono NUMERIC(3) NOT NULL,
    Cru_Fecha_Hora_Salida TIMESTAMP NOT NULL,
    Cru_Fecha_Hora_Lllegada TIMESTAMP NOT NULL,
    Cru_Cant_Millas NUMERIC(4) NOT NULL,
    Cru_Costo NUMERIC(8,2) NOT NULL
);

CREATE TABLE Cuota (
    Cuo_COD SERIAL PRIMARY KEY,
    Cuo_Monto NUMERIC(8,2) NOT NULL,
    Cuo_Fecha_Vencimiento DATE NOT NULL,
    Financiamiento_Fin_COD INTEGER,
    Cuo_Fecha_Pago DATE NOT NULL
);

CREATE TABLE Doc_Pas (
    Documento_Doc_COD INTEGER,
    Pasajero_Pas_COD INTEGER,
    PRIMARY KEY (Pasajero_Pas_COD, Documento_Doc_COD)
);

CREATE TABLE Documento (
    Doc_COD SERIAL PRIMARY KEY,
    Doc_Nombre VARCHAR(60) NOT NULL,
    Doc_Numero_Identificacion VARCHAR(10) NOT NULL,
    Doc_Fecha_Emision DATE NOT NULL,
    Doc_Fecha_Vencimiento DATE NOT NULL,
    Tipo_Documento_TP_COD INTEGER
);

CREATE TABLE Empleado (
    Emp_COD SERIAL PRIMARY KEY,
    Emp_Primer_Nombre VARCHAR(80) NOT NULL,
    Emp_Segundo_Nombre VARCHAR(80),
    Emp_Primer_Apellido VARCHAR(60) NOT NULL,
    Emp_Segundo_Apellido VARCHAR(80)
);

CREATE TABLE Estatus (
    Est_COD SERIAL PRIMARY KEY,
    Est_Descripcion TEXT NOT NULL
    CONSTRAINT chk_estatus_descripcion CHECK (
        Est_Descripcion IN ('Pendiente','Listo')
    )
);

CREATE TABLE Financiamiento (
    Fin_COD SERIAL PRIMARY KEY,
    Fin_Numero_Cuotas INT NOT NULL,
    Reserva_Res_COD INTEGER,
    Fin_Monto_Financiado NUMERIC(8,2) NOT NULL,
    Fin_Fecha DATE NOT NULL
);

CREATE TABLE Hospedaje (
    Hos_COD SERIAL PRIMARY KEY,
    Hos_Fecha_Hora_Inicio TIMESTAMP NOT NULL,
    Hos_Fecha_Hora_Fin TIMESTAMP NOT NULL,
    Hos_Costo NUMERIC(8,2) NOT NULL,
    Hotel_Pro_COD INTEGER,
    Hot_Cant_Milla NUMERIC(3) NOT NULL
);

CREATE TABLE Itinerario (
    Iti_COD SERIAL PRIMARY KEY,
    Paquete_Turistico_PT_COD INTEGER,
    Iti_Costo_Total NUMERIC(8,2) NOT NULL,
    Hospedaje_Hos_COD INTEGER,
    Restaurante_Rest_COD INTEGER,
    Vuelo_Vue_COD INTEGER,
    Crucero_Cru_COD INTEGER,
    Transporte_Terrestre_TT_COD INTEGER,
    Iti_Fecha_Inicio DATE NOT NULL,
    Iti_Fecha_Fin DATE NOT NULL,
    Servicio_Adicional_SA_COD INTEGER,
    Iti_Cant_Milla_Total NUMERIC(4) NOT NULL,
    Reserva_Res_COD INTEGER
);

CREATE TABLE Lugar (
    Lug_COD SERIAL PRIMARY KEY,
    Lug_Nombre VARCHAR(60) NOT NULL,
    Lug_Tipo VARCHAR(60) NOT NULL,
    Lugar_Lug_COD INTEGER,
    Lug_Cant_Milla NUMERIC(3) NOT NULL,
    CONSTRAINT chk_tipo_lugar CHECK (
        Lug_Tipo IN ('Continente','Pais','Region','Ciudad','Parroquia','Municipio')
    )
);

CREATE TABLE Metodo_de_Pago (
    MP_COD SERIAL PRIMARY KEY,
    Tipo VARCHAR(20) NOT NULL,
    Fecha_Registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    Num_Tarjeta NUMERIC(16) UNIQUE,
    Cod_Seguridad NUMERIC(3),
    Emisor VARCHAR(60),
    Marca VARCHAR(60),
    Fecha_Vencimiento DATE,
    Nombre_Titular VARCHAR(60),

    Id_Transaccion VARCHAR(70) UNIQUE,
    Fecha_Hora TIMESTAMP,
    Monto NUMERIC(10,2),

    Cod_Cuenta_Cliente NUMERIC(7),
    Num_Cheque NUMERIC(8) UNIQUE,
    Banco_Emisor VARCHAR(80),
    Fecha_Emision DATE,

    Tipo_Moneda VARCHAR(90),

    Num_Cuenta_Destino NUMERIC(30),
    Banco VARCHAR(80),
    Fecha DATE,
    Num_Referencia NUMERIC(30) UNIQUE,

    Num_Confirmacion NUMERIC(20) UNIQUE,
    Monto_Billetera NUMERIC(10,2),

    CONSTRAINT chk_tipo_metodo_pago CHECK (
        Tipo IN (
            'Tarjeta_Credito','Tarjeta_Debito','Cheque',
            'Efectivo','Milla_MP','Criptomonedas','Billetera_Digital','Zelle',
            'PayPal','Zinli','Pago_Movil','Transferencia'
        )
    )
);

CREATE TABLE Pago (
    PAG_COD SERIAL PRIMARY KEY,
    PAG_Fecha_Hora TIMESTAMP NOT NULL,
    PAG_Total NUMERIC(10,2) NOT NULL,
    Tasa_de_Cambio_TC_COD INTEGER,
    Cli_MP_MP_COD INTEGER,
    Cli_MP_Cli_COD INTEGER,
    Pag_Total_Milla NUMERIC(4),
    Cuota_Cuo_COD INTEGER,
    Reserva_Res_COD INTEGER,
    CONSTRAINT Arc_Pago CHECK (
        ((Cuota_Cuo_COD IS NULL AND Reserva_Res_COD IS NOT NULL)
        OR
        (Cuota_Cuo_COD IS NOT NULL AND Reserva_Res_COD IS NULL))
    )
);

CREATE TABLE Pago_Reembolsado (
    Reembolso_Rem_COD INTEGER,
    Metodo_de_Pago_MP_COD INTEGER,
    Fecha_Hora_Reembolso TIMESTAMP NOT NULL,
    Monto_Reembolso NUMERIC(8,2) NOT NULL,
    Divisa_Utilizada VARCHAR(80) NOT NULL,
    Tasa_Aplicada NUMERIC(8,2) NOT NULL,
    Tasa_de_Cambio_TC_COD INTEGER,
    PRIMARY KEY (Reembolso_Rem_COD, Metodo_de_Pago_MP_COD)
);

CREATE TABLE Paquete_Turistico (
    PT_COD SERIAL PRIMARY KEY,
    PT_Nombre VARCHAR(60) NOT NULL,
    PT_Descripcion TEXT NOT NULL,
    PT_Costo NUMERIC(8,2) NOT NULL,
    PT_Costo_Millas NUMERIC(8,2) NOT NULL,
    PT_Cant_Milla NUMERIC(3) NOT NULL,
    PT_Tipo VARCHAR(80) NOT NULL,
    Promocion_Promocion_ID INTEGER
);

CREATE TABLE Pasajero (
    Pas_COD SERIAL PRIMARY KEY,
    Pas_Primer_Nombre VARCHAR(60) NOT NULL,
    Pas_Segundo_Nombre VARCHAR(60),
    Pas_Primer_Apellido VARCHAR(60) NOT NULL,
    Pas_Segundo_Apellido VARCHAR(60),
    Pas_Fecha_Nacimiento DATE NOT NULL,
    Pas_Estado_Civil VARCHAR(60) NOT NULL,
    Cliente_Cli_COD INTEGER,
    Reserva_Res_COD INTEGER
);

CREATE TABLE Preferencia (
    Itinerario_Iti_COD INTEGER,
    Cliente_Cli_COD INTEGER,
    Pre_COD SERIAL,
    Pre_Descripcion TEXT NOT NULL,
    PRIMARY KEY (Itinerario_Iti_COD, Cliente_Cli_COD, Pre_COD)
);

CREATE TABLE Pri_Rol (
    Rol_Rol_COD INTEGER,
    Privilegio_Pri_COD INTEGER,
    PRIMARY KEY (Rol_Rol_COD, Privilegio_Pri_COD)
);

CREATE TABLE Privilegio (
    Pri_COD SERIAL PRIMARY KEY,
    Pri_tipo VARCHAR(60) NOT NULL,
    Pri_Tabla VARCHAR(80) NOT NULL,
    Pri_Operacion VARCHAR(80) NOT NULL
);

CREATE TABLE Promocion (
    Prom_COD SERIAL PRIMARY KEY,
    Prom_Tipo VARCHAR(60) NOT NULL,
    Prom_Fecha_Inicio DATE NOT NULL,
    Prom_Fecha_Fin DATE NOT NULL,
    Prom_Porcentaje NUMERIC(4,2)
);

CREATE TABLE Compania_Crucero (
    Pro_COD SERIAL PRIMARY KEY,
    Pro_Nombre VARCHAR(60) NOT NULL,
    Pro_Direccion TEXT NOT NULL,
    Pro_Telefono NUMERIC(18) NOT NULL,
    Pro_Correo VARCHAR(60) NOT NULL,
    CC_Fecha_Fundacion DATE NOT NULL,
    Lugar_Lug_COD INTEGER
);

CREATE TABLE Operador_Turistico (
    Pro_COD SERIAL PRIMARY KEY,
    Pro_Nombre VARCHAR(60) NOT NULL,
    Pro_Direccion TEXT NOT NULL,
    Pro_Telefono NUMERIC(18) NOT NULL,
    Pro_Correo VARCHAR(60) NOT NULL,
    Lugar_Lug_COD INTEGER
);

CREATE TABLE Aerolinea (
    Pro_COD SERIAL PRIMARY KEY,
    Pro_Nombre VARCHAR(60) NOT NULL,
    Pro_Direccion TEXT NOT NULL,
    Pro_Telefono NUMERIC(18) NOT NULL,
    Pro_Correo VARCHAR(60) NOT NULL,
    A_Fecha_Fundacion DATE NOT NULL,
    Lugar_Lug_COD INTEGER
);

CREATE TABLE Compania_Transporte_Terrestre (
    Pro_COD SERIAL PRIMARY KEY,
    Pro_Nombre VARCHAR(60) NOT NULL,
    Pro_Direccion TEXT NOT NULL,
    Pro_Telefono NUMERIC(18) NOT NULL,
    Pro_Correo VARCHAR(60) NOT NULL,
    Lugar_Lug_COD INTEGER
);

CREATE TABLE Hotel (
    Pro_COD SERIAL PRIMARY KEY,
    Pro_Nombre VARCHAR(60) NOT NULL,
    Pro_Direccion TEXT NOT NULL,
    Pro_Telefono NUMERIC(18) NOT NULL,
    Pro_Correo VARCHAR(60) NOT NULL,
    Lugar_Lug_COD INTEGER
);

CREATE TABLE Reclamo (
    Rec_COD SERIAL PRIMARY KEY,
    Rec_Descripcion TEXT NOT NULL,
    Itinerario_Iti_COD INTEGER
);

CREATE TABLE Reembolso (
    Rem_COD SERIAL PRIMARY KEY,
    Rem_Monto_Devuelto NUMERIC(8,2) NOT NULL,
    Rem_Monto_Retenido NUMERIC(8,2) NOT NULL,
    Reserva_Res_COD INTEGER
);

CREATE TABLE Registro_Reclamos (
    COD SERIAL PRIMARY KEY,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE,
    Estatus_Est_COD INTEGER,
    Reserva_Res_COD INTEGER,
    Reclamo_Rec_COD INTEGER,   
    CONSTRAINT Arc_Registro_Reclamo CHECK(((Reserva_Res_COD IS NOT NULL)AND(Reclamo_Rec_COD IS NULL))
    OR ((Reserva_Res_COD IS NULL)AND(Reclamo_Rec_COD IS NOT NULL)))
);

CREATE TABLE Resenas (
    Rese_COD SERIAL PRIMARY KEY,
    Itinerario_Iti_COD INTEGER,
    Rese_Descripcion TEXT NOT NULL
);

CREATE TABLE Reserva (
    Res_COD SERIAL PRIMARY KEY,
    Res_Numero_Reserva NUMERIC(4) NOT NULL,
    Res_Milla_Obtenida NUMERIC(30) NOT NULL,
    Res_Fecha_Hora TIMESTAMP NOT NULL,
    Res_Camarote VARCHAR(6),
    Cliente_Cli_COD INTEGER,
    Res_Subtotal NUMERIC(8,2) NOT NULL,
    Res_Total NUMERIC(8,2) NOT NULL
);

CREATE TABLE Restaurante (
    Rest_COD SERIAL PRIMARY KEY,
    Rest_Nombre VARCHAR(60) NOT NULL,
    Rest_Direccion TEXT NOT NULL,
    Rest_Clasificacion INT NOT NULL,
    Lugar_Lug_COD INTEGER,
    Rest_Tipo_Comida VARCHAR(80) NOT NULL,
    Rest_Ambiente VARCHAR(80) NOT NULL
);

CREATE TABLE Restriccion_Paquete (
    RP_COD SERIAL PRIMARY KEY,
    RP_Tipo VARCHAR(90) NOT NULL,
    RP_Descripción TEXT NOT NULL,
    Paquete_Turistico_PT_COD INTEGER
);

CREATE TABLE Rol (
    Rol_COD SERIAL PRIMARY KEY,
    Rol_tipo VARCHAR(60) NOT NULL
);

CREATE TABLE Ruta (
    Rut_COD SERIAL PRIMARY KEY,
    Vuelo_Vue_COD INTEGER,
    Crucero_Cru_COD INTEGER,
    Transporte_Terrestre_TT_COD INTEGER,
    Terminal_Ter_COD INTEGER NOT NULL,
    Rut_Fecha_Hora_Salida TIMESTAMP NOT NULL,
    Rut_Fecha_Hora_Llegada TIMESTAMP NOT NULL,
    CONSTRAINT Arc_Ruta CHECK (
        (Vuelo_Vue_COD IS NOT NULL AND Crucero_Cru_COD IS NULL AND Transporte_Terrestre_TT_COD IS NULL)
     OR (Crucero_Cru_COD IS NOT NULL AND Vuelo_Vue_COD IS NULL AND Transporte_Terrestre_TT_COD IS NULL)
     OR (Transporte_Terrestre_TT_COD IS NOT NULL AND Vuelo_Vue_COD IS NULL AND Crucero_Cru_COD IS NULL)
    )
);

CREATE TABLE Servicio_Adicional (
    SA_COD SERIAL PRIMARY KEY,
    SA_Tipo VARCHAR(60) NOT NULL,
    SA_Nombre VARCHAR(70) NOT NULL,
    Operador_Turistico_Pro_COD INTEGER,
    SA_Descripcion TEXT,
    SA_Costo NUMERIC(8,2) NOT NULL,
    SA_Cant_Milla NUMERIC(6) NOT NULL,
    SA_Fecha_Hora_Inicio TIMESTAMP NOT NULL,
    SA_Fecha_Hora_Fin TIMESTAMP NOT NULL
);

CREATE TABLE Tasa_de_Cambio (
    TC_COD SERIAL PRIMARY KEY,
    TC_Tipo_Moneda VARCHAR(60) NOT NULL,
    TC_Valor NUMERIC (8,2) NOT NULL,
    TC_Valor_Dolar NUMERIC (8,2) NOT NULL,
    TC_Cant_Milla NUMERIC (8,2) NOT NULL,
    TC_Fecha_Actualizacion DATE NOT NULL,
    TC_Fecha_Final DATE NOT NULL,
    Lugar_Lug_COD INTEGER
);

CREATE TABLE Terminal (
    Ter_COD SERIAL PRIMARY KEY,
    Ter_Nombre VARCHAR(60) NOT NULL,
    Ter_Tipo VARCHAR(60) NOT NULL,
    Ter_Direccion TEXT NOT NULL,
    Lugar_Lug_COD2 INTEGER,
    Lugar_Lug_COD INTEGER
);

CREATE TABLE Tipo_Documento (
    TP_COD SERIAL PRIMARY KEY,
    TP_Nombre VARCHAR(90) NOT NULL
);

CREATE TABLE Transporte_Terrestre (
    TT_COD SERIAL PRIMARY KEY,
    TT_Nombre VARCHAR (80) NOT NULL,
    Vehiculo_Veh_COD INTEGER,
    TT_Huella_Carbono NUMERIC(4,2) NOT NULL,
    TT_Fecha_Hora_Salida TIMESTAMP NOT NULL,
    TT_Fecha_Hora_Llegada TIMESTAMP NOT NULL,
    TT_Cant_Millas NUMERIC(4) NOT NULL,
    TT_Costo NUMERIC(8,2) NOT NULL
);

CREATE TABLE Usuario (
    Usu_COD SERIAL PRIMARY KEY,
    Usu_Primer_Nombre VARCHAR (80) NOT NULL, 
    Usu_Primer_Apellido VARCHAR (80) NOT NULL,
    Usu_Segundo_Nombre VARCHAR (80),
    Usu_Segundo_Apellido VARCHAR (80), 
    Usu_Correo VARCHAR(60) NOT NULL,
    Usu_Contrasena VARCHAR(10) NOT NULL,
    Cliente_Cli_COD INTEGER,
    Compania_Crucero INTEGER,
    Operador_Turistico INTEGER,
    Aerolinea INTEGER,
    Transporte_Terrestre INTEGER,
    Hotel INTEGER,
    Empleado_Emp_COD INTEGER,
    Rol_Rol_COD INTEGER,
 CONSTRAINT Arc_Usuario CHECK(((Cliente_Cli_COD IS NOT NULL)AND(Compania_Crucero IS NULL)AND(Aerolinea IS NULL)AND(Transporte_Terrestre IS NULL)
    AND(Operador_Turistico IS NULL)AND(Hotel IS NULL))
    OR((Cliente_Cli_COD IS NULL)AND(Compania_Crucero IS NOT NULL)AND(Aerolinea IS NULL)AND(Transporte_Terrestre IS NULL)
    AND(Operador_Turistico IS NULL)AND(Hotel IS NULL))
    OR((Cliente_Cli_COD IS NULL)AND(Compania_Crucero IS NULL)AND(Aerolinea IS NOT NULL)AND(Transporte_Terrestre IS NULL)
    AND(Operador_Turistico IS NULL)AND(Hotel IS NULL))
    OR((Cliente_Cli_COD IS NULL)AND(Compania_Crucero IS NULL)AND(Aerolinea IS NULL)AND(Transporte_Terrestre IS NOT NULL)
    AND(Operador_Turistico IS NULL)AND(Hotel IS NULL))
    OR((Cliente_Cli_COD IS NULL)AND(Compania_Crucero IS NULL)AND(Aerolinea IS NULL)AND(Transporte_Terrestre IS NULL)
    AND(Operador_Turistico IS NOT NULL)AND(Hotel IS NULL))
    OR((Cliente_Cli_COD IS NULL)AND(Compania_Crucero IS NULL)AND(Aerolinea IS NULL)AND(Transporte_Terrestre IS NULL)
    AND(Operador_Turistico IS NULL)AND(Hotel IS NOT NULL))
    OR((Cliente_Cli_COD IS NULL)AND(Compania_Crucero IS NULL)AND(Aerolinea IS NULL)AND(Transporte_Terrestre IS NULL)
    AND(Operador_Turistico IS NULL)AND(Hotel IS NULL)))

);

CREATE TABLE Vehiculo (
    Veh_COD SERIAL PRIMARY KEY,
    Veh_Capacidad INT NOT NULL,
    Compania_Transporte_Terrestre_Pro_COD INTEGER
);

CREATE TABLE Vuelo (
    Vue_COD SERIAL PRIMARY KEY,
    Avion_Avi_COD INTEGER,
    Vue_Huella_Carbono NUMERIC(4,2) NOT NULL,
    Vue_Fecha_Hora_Salida TIMESTAMP NOT NULL,
    Vue_Fecha_Hora_Llegada TIMESTAMP NOT NULL,
    Vue_Cant_Millas NUMERIC(4) NOT NULL,
    Vue_Costo NUMERIC(8,2) NOT NULL
);

CREATE TABLE Wishlist (
    Wis_COD SERIAL PRIMARY KEY,
    Wis_Descripcion TEXT NOT NULL,
    Cliente_Cli_COD INTEGER,
    Itinerario_Iti_COD INTEGER
);