-- Auditoria → Usuario
ALTER TABLE Auditoria
    ADD CONSTRAINT fk_auditoria_usuario
    FOREIGN KEY (Usuario_Usu_COD) REFERENCES Usuario(Usu_COD) ON DELETE CASCADE;

-- Avion → Aerolinea
ALTER TABLE Avion
    ADD CONSTRAINT fk_avion_aerolinea
    FOREIGN KEY (Aerolinea_Pro_COD) REFERENCES Aerolinea(Pro_COD) ON DELETE CASCADE;

-- Barco → Compania_Crucero
ALTER TABLE Barco
    ADD CONSTRAINT fk_barco_crucero
    FOREIGN KEY (Compania_Crucero_Pro_COD) REFERENCES Compania_Crucero(Pro_COD) ON DELETE CASCADE;

-- Cli_MP → Cliente
ALTER TABLE Cli_MP
    ADD CONSTRAINT fk_climp_cliente
    FOREIGN KEY (Cliente_Cli_COD) REFERENCES Cliente(Cli_COD) ON DELETE CASCADE;

-- Cli_MP → Metodo_de_Pago
ALTER TABLE Cli_MP
    ADD CONSTRAINT fk_climp_metodo
    FOREIGN KEY (Metodo_de_Pago_MP_COD) REFERENCES Metodo_de_Pago(MP_COD) ON DELETE CASCADE;

-- Crucero → Barco
ALTER TABLE Crucero
    ADD CONSTRAINT fk_crucero_barco
    FOREIGN KEY (Barco_Bar_COD) REFERENCES Barco(Bar_COD) ON DELETE CASCADE;

-- Cuota → Financiamiento
ALTER TABLE Cuota
    ADD CONSTRAINT fk_cuota_financiamiento
    FOREIGN KEY (Financiamiento_Fin_COD) REFERENCES Financiamiento(Fin_COD) ON DELETE CASCADE;

-- Doc_Pas → Documento
ALTER TABLE Doc_Pas
    ADD CONSTRAINT fk_docpas_documento
    FOREIGN KEY (Documento_Doc_COD) REFERENCES Documento(Doc_COD) ON DELETE CASCADE;

-- Doc_Pas → Pasajero
ALTER TABLE Doc_Pas
    ADD CONSTRAINT fk_docpas_pasajero
    FOREIGN KEY (Pasajero_Pas_COD) REFERENCES Pasajero(Pas_COD) ON DELETE CASCADE;

-- Documento → Tipo_Documento
ALTER TABLE Documento
    ADD CONSTRAINT fk_documento_tipodoc
    FOREIGN KEY (Tipo_Documento_TP_COD) REFERENCES Tipo_Documento(TP_COD) ON DELETE CASCADE;

-- Financiamiento → Reserva
ALTER TABLE Financiamiento
    ADD CONSTRAINT fk_financiamiento_reserva
    FOREIGN KEY (Reserva_Res_COD) REFERENCES Reserva(Res_COD) ON DELETE CASCADE;

-- Hospedaje → Hotel
ALTER TABLE Hospedaje
    ADD CONSTRAINT fk_hospedaje_hotel
    FOREIGN KEY (Hotel_Pro_COD) REFERENCES Hotel(Pro_COD) ON DELETE CASCADE;

-- Itinerario → Comida
ALTER TABLE Itinerario
    ADD CONSTRAINT fk_itinerario_comida
    FOREIGN KEY (Comida_Com_COD) REFERENCES Comida(Com_COD) ON DELETE CASCADE;

-- Itinerario → Crucero
ALTER TABLE Itinerario
    ADD CONSTRAINT fk_itinerario_crucero
    FOREIGN KEY (Crucero_Cru_COD) REFERENCES Crucero(Cru_COD) ON DELETE CASCADE;

-- Itinerario → Hospedaje
ALTER TABLE Itinerario
    ADD CONSTRAINT fk_itinerario_hospedaje
    FOREIGN KEY (Hospedaje_Hos_COD) REFERENCES Hospedaje(Hos_COD) ON DELETE CASCADE;

-- Itinerario → Paquete_Turistico
ALTER TABLE Itinerario
    ADD CONSTRAINT fk_itinerario_paquete
    FOREIGN KEY (Paquete_Turistico_PT_COD) REFERENCES Paquete_Turistico(PT_COD) ON DELETE CASCADE;

-- Itinerario → Reserva
ALTER TABLE Itinerario
    ADD CONSTRAINT fk_itinerario_reserva
    FOREIGN KEY (Reserva_Res_COD) REFERENCES Reserva(Res_COD) ON DELETE CASCADE;

-- Itinerario → Restaurante
ALTER TABLE Itinerario
    ADD CONSTRAINT fk_itinerario_restaurante
    FOREIGN KEY (Restaurante_Rest_COD) REFERENCES Restaurante(Rest_COD) ON DELETE CASCADE;

-- Itinerario → Servicio_Adicional
ALTER TABLE Itinerario
    ADD CONSTRAINT fk_itinerario_servicio
    FOREIGN KEY (Servicio_Adicional_SA_COD) REFERENCES Servicio_Adicional(SA_COD) ON DELETE CASCADE;

-- Itinerario → Transporte_Terrestre
ALTER TABLE Itinerario
    ADD CONSTRAINT fk_itinerario_transporte
    FOREIGN KEY (Transporte_Terrestre_TT_COD) REFERENCES Transporte_Terrestre(TT_COD) ON DELETE CASCADE;

-- Itinerario → Vuelo
ALTER TABLE Itinerario
    ADD CONSTRAINT fk_itinerario_vuelo
    FOREIGN KEY (Vuelo_Vue_COD) REFERENCES Vuelo(Vue_COD) ON DELETE CASCADE;

-- Lugar → Lugar (autorelación)
ALTER TABLE Lugar
    ADD CONSTRAINT fk_lugar_lugar
    FOREIGN KEY (Lugar_Lug_COD) REFERENCES Lugar(Lug_COD) ON DELETE CASCADE;

-- Pago → Cli_MP
ALTER TABLE Pago
    ADD CONSTRAINT fk_pago_climp
    FOREIGN KEY (Cli_MP_MP_COD, Cli_MP_Cli_COD)
    REFERENCES Cli_MP(Metodo_de_Pago_MP_COD, Cliente_Cli_COD) ON DELETE CASCADE;

-- Pago → Cuota
ALTER TABLE Pago
    ADD CONSTRAINT fk_pago_cuota
    FOREIGN KEY (Cuota_Cuo_COD) REFERENCES Cuota(Cuo_COD) ON DELETE CASCADE;

-- Pago → Reserva
ALTER TABLE Pago
    ADD CONSTRAINT fk_pago_reserva
    FOREIGN KEY (Reserva_Res_COD) REFERENCES Reserva(Res_COD) ON DELETE CASCADE;

-- Pago → Tasa_de_Cambio
ALTER TABLE Pago
    ADD CONSTRAINT fk_pago_tasa
    FOREIGN KEY (Tasa_de_Cambio_TC_COD) REFERENCES Tasa_de_Cambio(TC_COD) ON DELETE CASCADE;

-- Pago_Reembolsado → Metodo_de_Pago
ALTER TABLE Pago_Reembolsado
    ADD CONSTRAINT fk_pagoreemb_metodo
    FOREIGN KEY (Metodo_de_Pago_MP_COD) REFERENCES Metodo_de_Pago(MP_COD) ON DELETE CASCADE;

-- Pago_Reembolsado → Reembolso
ALTER TABLE Pago_Reembolsado
    ADD CONSTRAINT fk_pagoreemb_reembolso
    FOREIGN KEY (Reembolso_Rem_COD) REFERENCES Reembolso(Rem_COD) ON DELETE CASCADE;

-- Pago_Reembolsado → Tasa_de_Cambio
ALTER TABLE Pago_Reembolsado
    ADD CONSTRAINT fk_pagoreemb_tasa
    FOREIGN KEY (Tasa_de_Cambio_TC_COD) REFERENCES Tasa_de_Cambio(TC_COD) ON DELETE CASCADE;

-- Paquete_Turistico → Promocion
ALTER TABLE Paquete_Turistico
    ADD CONSTRAINT fk_paquete_promocion
    FOREIGN KEY (Promocion_Promocion_ID) REFERENCES Promocion(Prom_COD) ON DELETE CASCADE;

-- Pasajero → Cliente
ALTER TABLE Pasajero
    ADD CONSTRAINT fk_pasajero_cliente
    FOREIGN KEY (Cliente_Cli_COD) REFERENCES Cliente(Cli_COD) ON DELETE CASCADE;

-- Pasajero → Reserva
ALTER TABLE Pasajero
    ADD CONSTRAINT fk_pasajero_reserva
    FOREIGN KEY (Reserva_Res_COD) REFERENCES Reserva(Res_COD) ON DELETE CASCADE;

-- Preferencia → Cliente
ALTER TABLE Preferencia
    ADD CONSTRAINT fk_preferencia_cliente
    FOREIGN KEY (Cliente_Cli_COD) REFERENCES Cliente(Cli_COD) ON DELETE CASCADE;

-- Preferencia → Itinerario
ALTER TABLE Preferencia
    ADD CONSTRAINT fk_preferencia_itinerario
    FOREIGN KEY (Itinerario_Iti_COD) REFERENCES Itinerario(Iti_COD) ON DELETE CASCADE;
-- Pri_Rol → Privilegio
ALTER TABLE Pri_Rol
    ADD CONSTRAINT fk_prirol_privilegio
    FOREIGN KEY (Privilegio_Pri_COD) REFERENCES Privilegio(Pri_COD) ON DELETE CASCADE;

-- Pri_Rol → Rol
ALTER TABLE Pri_Rol
    ADD CONSTRAINT fk_prirol_rol
    FOREIGN KEY (Rol_Rol_COD) REFERENCES Rol(Rol_COD) ON DELETE CASCADE;

-- Compania_Crucero → Lugar
ALTER TABLE Compania_Crucero
    ADD CONSTRAINT fk_Compania_Crucero_lugar
    FOREIGN KEY (Lugar_Lug_COD) REFERENCES Lugar(Lug_COD) ON DELETE CASCADE;

-- Operador_Turistico → Lugar
ALTER TABLE Operador_Turistico
    ADD CONSTRAINT fk_Operador_Turistico_lugar
    FOREIGN KEY (Lugar_Lug_COD) REFERENCES Lugar(Lug_COD) ON DELETE CASCADE;

-- Aerolinea → Lugar
ALTER TABLE Aerolinea
    ADD CONSTRAINT fk_Aerolinea_lugar
    FOREIGN KEY (Lugar_Lug_COD) REFERENCES Lugar(Lug_COD) ON DELETE CASCADE;

-- Compania_Transporte_Terrestre → Lugar
ALTER TABLE Compania_Transporte_Terrestre
    ADD CONSTRAINT fk_Compania_Transporte_Terrestre_lugar
    FOREIGN KEY (Lugar_Lug_COD) REFERENCES Lugar(Lug_COD) ON DELETE CASCADE;

-- Hotel → Lugar
ALTER TABLE Hotel
    ADD CONSTRAINT fk_Hotel_lugar
    FOREIGN KEY (Lugar_Lug_COD) REFERENCES Lugar(Lug_COD) ON DELETE CASCADE;

-- Registro_Reclamos → Estatus
ALTER TABLE Registro_Reclamos
    ADD CONSTRAINT fk_registro_estatus
    FOREIGN KEY (Estatus_Est_COD) REFERENCES Estatus(Est_COD) ON DELETE CASCADE;

-- Registro_Reclamos → Reclamo
ALTER TABLE Registro_Reclamos
    ADD CONSTRAINT fk_registro_reclamo
    FOREIGN KEY (Reclamo_Rec_COD) REFERENCES Reclamo(Rec_COD) ON DELETE CASCADE;

-- Registro_Reclamos → Reserva
ALTER TABLE Registro_Reclamos
    ADD CONSTRAINT fk_registro_reserva
    FOREIGN KEY (Reserva_Res_COD) REFERENCES Reserva(Res_COD) ON DELETE CASCADE;

-- Resenas → Itinerario
ALTER TABLE Resenas
    ADD CONSTRAINT fk_resenas_itinerario
    FOREIGN KEY (Itinerario_Iti_COD) REFERENCES Itinerario(Iti_COD) ON DELETE CASCADE;

-- Reserva → Cliente
ALTER TABLE Reserva
    ADD CONSTRAINT fk_reserva_cliente
    FOREIGN KEY (Cliente_Cli_COD) REFERENCES Cliente(Cli_COD) ON DELETE CASCADE;

-- Restaurante → Lugar
ALTER TABLE Restaurante
    ADD CONSTRAINT fk_restaurante_lugar
    FOREIGN KEY (Lugar_Lug_COD) REFERENCES Lugar(Lug_COD) ON DELETE CASCADE;

-- Ruta → Crucero
ALTER TABLE Ruta
    ADD CONSTRAINT fk_ruta_crucero
    FOREIGN KEY (Crucero_Cru_COD) REFERENCES Crucero(Cru_COD) ON DELETE CASCADE;

-- Ruta → Terminal
ALTER TABLE Ruta
    ADD CONSTRAINT fk_ruta_terminal
    FOREIGN KEY (Terminal_Ter_COD) REFERENCES Terminal(Ter_COD) ON DELETE CASCADE;

-- Ruta → Transporte_Terrestre
ALTER TABLE Ruta
    ADD CONSTRAINT fk_ruta_transporte
    FOREIGN KEY (Transporte_Terrestre_TT_COD) REFERENCES Transporte_Terrestre(TT_COD) ON DELETE CASCADE;

-- Ruta → Vuelo
ALTER TABLE Ruta
    ADD CONSTRAINT fk_ruta_vuelo
    FOREIGN KEY (Vuelo_Vue_COD) REFERENCES Vuelo(Vue_COD) ON DELETE CASCADE;

-- Servicio_Adicional → Operador_Turistico
ALTER TABLE Servicio_Adicional
    ADD CONSTRAINT fk_servicio_operador
    FOREIGN KEY (Operador_Turistico_Pro_COD) REFERENCES Operador_Turistico(Pro_COD) ON DELETE CASCADE;

-- Tasa_de_Cambio → Lugar
ALTER TABLE Tasa_de_Cambio
    ADD CONSTRAINT fk_tasa_lugar
    FOREIGN KEY (Lugar_Lug_COD) REFERENCES Lugar(Lug_COD) ON DELETE CASCADE;

-- Terminal → Lugar
ALTER TABLE Terminal
    ADD CONSTRAINT fk_terminal_lugar
    FOREIGN KEY (Lugar_Lug_COD) REFERENCES Lugar(Lug_COD) ON DELETE CASCADE;

ALTER TABLE Terminal
    ADD CONSTRAINT fk_terminal_lugar2
    FOREIGN KEY (Lugar_Lug_COD2) REFERENCES Lugar(Lug_COD) ON DELETE CASCADE;

-- Transporte_Terrestre → Vehiculo
ALTER TABLE Transporte_Terrestre
    ADD CONSTRAINT fk_transporte_vehiculo
    FOREIGN KEY (Vehiculo_Veh_COD) REFERENCES Vehiculo(Veh_COD) ON DELETE CASCADE;

-- Usuario → Cliente
ALTER TABLE Usuario
    ADD CONSTRAINT fk_usuario_cliente
    FOREIGN KEY (Cliente_Cli_COD) REFERENCES Cliente(Cli_COD) ON DELETE CASCADE;

-- Usuario → Empleado
ALTER TABLE Usuario
    ADD CONSTRAINT fk_usuario_empleado
    FOREIGN KEY (Empleado_Emp_COD) REFERENCES Empleado(Emp_COD) ON DELETE CASCADE;

-- Usuario → Proveedor
ALTER TABLE Usuario
    ADD CONSTRAINT fk_usuario_Compania_Crucero
    FOREIGN KEY (Compania_Crucero) REFERENCES Compania_Crucero(Pro_COD) ON DELETE CASCADE;
ALTER TABLE Usuario
    ADD CONSTRAINT fk_usuario_Operador_Turistico
    FOREIGN KEY (Operador_Turistico) REFERENCES Operador_Turistico(Pro_COD) ON DELETE CASCADE;
ALTER TABLE Usuario
    ADD CONSTRAINT fk_usuario_Aerolinea
    FOREIGN KEY (Aerolinea) REFERENCES Aerolinea(Pro_COD) ON DELETE CASCADE;
ALTER TABLE Usuario
    ADD CONSTRAINT fk_usuario_Compania_Transporte_Terrestre
    FOREIGN KEY (Transporte_Terrestre) REFERENCES Compania_Transporte_Terrestre(Pro_COD) ON DELETE CASCADE;
ALTER TABLE Usuario
    ADD CONSTRAINT fk_usuario_Hotel
    FOREIGN KEY (Hotel) REFERENCES Hotel(Pro_COD) ON DELETE CASCADE;

-- Usuario → Rol
ALTER TABLE Usuario
    ADD CONSTRAINT fk_usuario_rol
    FOREIGN KEY (Rol_Rol_COD) REFERENCES Rol(Rol_COD) ON DELETE CASCADE;

-- Vehiculo → Compania_Transporte_Terrestre
ALTER TABLE Vehiculo
    ADD CONSTRAINT fk_vehiculo_transporte
    FOREIGN KEY (Compania_Transporte_Terrestre_Pro_COD) REFERENCES Compania_Transporte_Terrestre(Pro_COD) ON DELETE CASCADE;

-- Vuelo → Avion
ALTER TABLE Vuelo
    ADD CONSTRAINT fk_vuelo_avion
    FOREIGN KEY (Avion_Avi_COD) REFERENCES Avion(Avi_COD) ON DELETE CASCADE;

-- Wishlist → Cliente
ALTER TABLE Wishlist
    ADD CONSTRAINT fk_wishlist_cliente
    FOREIGN KEY (Cliente_Cli_COD) REFERENCES Cliente(Cli_COD) ON DELETE CASCADE;

-- Wishlist → Itinerario
ALTER TABLE Wishlist
    ADD CONSTRAINT fk_wishlist_itinerario
    FOREIGN KEY (Itinerario_Iti_COD) REFERENCES Itinerario(Iti_COD) ON DELETE CASCADE;

-- Cliente - Lugar
ALTER TABLE Cliente
   ADD CONSTRAINT fk_cliente_lugar
   FOREIGN KEY (Lugar_Lug_COD) REFERENCES Lugar (Lug_COD) ON DELETE CASCADE;

ALTER TABLE Usuario
    ADD CONSTRAINT chk_usuario_correo
    CHECK (Usu_Correo LIKE '%@%.%');

ALTER TABLE Aerolinea
    ADD CONSTRAINT chk_pro_aer_correo
    CHECK (Pro_Correo LIKE '%@%.%');

ALTER TABLE Compania_Crucero
    ADD CONSTRAINT chk_pro_comp_crucero_correo
    CHECK (Pro_Correo LIKE '%@%.%');

ALTER TABLE Compania_Transporte_Terrestre
    ADD CONSTRAINT chk_pro_comp_transporte_correo
    CHECK (Pro_Correo LIKE '%@%.%');

ALTER TABLE Operador_Turistico
    ADD CONSTRAINT chk_pro_op_turistico_correo
    CHECK (Pro_Correo LIKE '%@%.%');

ALTER TABLE Hotel
    ADD CONSTRAINT chk_pro_hotel_correo
    CHECK (Pro_Correo LIKE '%@%.%');

ALTER TABLE Paquete_Turistico
    ADD CONSTRAINT chk_paquete_tipo
    CHECK (PT_Tipo IN ('Regular', 'Especial'));

ALTER TABLE Restriccion_Paquete
    ADD CONSTRAINT fk_restriccion_paquete_turistico
    FOREIGN KEY (Paquete_Turistico_PT_COD) REFERENCES Paquete_Turistico (PT_COD) ON DELETE CASCADE;
     
ALTER TABLE Reclamo
    ADD CONSTRAINT fk_reclamo_itinerario
    FOREIGN KEY (Itinerario_Iti_COD) REFERENCES Itinerario(Iti_COD) ON DELETE CASCADE;

ALTER TABLE Pasajero
    ADD CONSTRAINT chk_pasajero_estado_civil
    CHECK (Pas_Estado_Civil IN ('Soltero', 'Casado', 'Divorciado'));

ALTER TABLE Cliente
    ADD CONSTRAINT chk_cliente_estado_civil
    CHECK (Cli_Estado_Civil IN ('Soltero', 'Casado', 'Divorciado'));

ALTER SEQUENCE Auditoria_aud_cod_seq RESTART WITH 1;
ALTER SEQUENCE Avion_avi_cod_seq RESTART WITH 1;
ALTER SEQUENCE Barco_bar_cod_seq RESTART WITH 1;
ALTER SEQUENCE Cliente_cli_cod_seq RESTART WITH 1;
ALTER SEQUENCE Comida_com_cod_seq RESTART WITH 1;
ALTER SEQUENCE Crucero_cru_cod_seq RESTART WITH 1;
ALTER SEQUENCE Cuota_cuo_cod_seq RESTART WITH 1;
ALTER SEQUENCE Documento_doc_cod_seq RESTART WITH 1;
ALTER SEQUENCE Empleado_emp_cod_seq RESTART WITH 1;
ALTER SEQUENCE Estatus_est_cod_seq RESTART WITH 1;
ALTER SEQUENCE Financiamiento_fin_cod_seq RESTART WITH 1;
ALTER SEQUENCE Hospedaje_hos_cod_seq RESTART WITH 1;
ALTER SEQUENCE Itinerario_iti_cod_seq RESTART WITH 1;
ALTER SEQUENCE Lugar_lug_cod_seq RESTART WITH 1;
ALTER SEQUENCE Metodo_de_Pago_mp_cod_seq RESTART WITH 1;
ALTER SEQUENCE Pago_pag_cod_seq RESTART WITH 1;
ALTER SEQUENCE Paquete_Turistico_pt_cod_seq RESTART WITH 1;
ALTER SEQUENCE Pasajero_pas_cod_seq RESTART WITH 1;
ALTER SEQUENCE Preferencia_pre_cod_seq RESTART WITH 1;
ALTER SEQUENCE Privilegio_pri_cod_seq RESTART WITH 1;
ALTER SEQUENCE Promocion_prom_cod_seq RESTART WITH 1;
ALTER SEQUENCE Compania_Crucero_pro_cod_seq RESTART WITH 1;
ALTER SEQUENCE Operador_Turistico_pro_cod_seq RESTART WITH 1;
ALTER SEQUENCE Aerolinea_pro_cod_seq RESTART WITH 1;
ALTER SEQUENCE Compania_Transporte_Terrestre_pro_cod_seq RESTART WITH 1;
ALTER SEQUENCE Hotel_pro_cod_seq RESTART WITH 1;
ALTER SEQUENCE Reclamo_rec_cod_seq RESTART WITH 1;
ALTER SEQUENCE Reembolso_rem_cod_seq RESTART WITH 1;
ALTER SEQUENCE Resenas_rese_cod_seq RESTART WITH 1;
ALTER SEQUENCE Restaurante_rest_cod_seq RESTART WITH 1;
ALTER SEQUENCE Restriccion_Paquete_rp_cod_seq RESTART WITH 1;
ALTER SEQUENCE Rol_rol_cod_seq RESTART WITH 1;
ALTER SEQUENCE Servicio_Adicional_sa_cod_seq RESTART WITH 1;
ALTER SEQUENCE Tasa_de_Cambio_tc_cod_seq RESTART WITH 1;
ALTER SEQUENCE Terminal_ter_cod_seq RESTART WITH 1;
ALTER SEQUENCE Tipo_Documento_tp_cod_seq RESTART WITH 1;
ALTER SEQUENCE Transporte_Terrestre_tt_cod_seq RESTART WITH 1;
ALTER SEQUENCE Usuario_usu_cod_seq RESTART WITH 1;
ALTER SEQUENCE Vehiculo_veh_cod_seq RESTART WITH 1;
ALTER SEQUENCE Vuelo_vue_cod_seq RESTART WITH 1;
ALTER SEQUENCE Wishlist_wis_cod_seq RESTART WITH 1;
ALTER SEQUENCE registro_reclamos_cod_seq RESTART WITH 1;

