CREATE DATABASE Inbentarioa;
USE Inbentarioa;

-- 1. Tablas independientes (sin claves foráneas)
CREATE TABLE Mintegiak (
    ID_Mintegia INT AUTO_INCREMENT PRIMARY KEY,
    Izena VARCHAR(20) NOT NULL,
    Kokapena VARCHAR(20) NOT NULL
);

CREATE TABLE Erabiltzaileak (
    ID_Erabiltzaileak INT AUTO_INCREMENT PRIMARY KEY,
    Izena VARCHAR(20) NOT NULL,
    Errola VARCHAR(20) NOT NULL,
    ErabiltzaileIzena VARCHAR(20) NOT NULL DEFAULT 'defaultUser'
);

-- 2. Tabla principal Gailuak (referenciada por otras)
CREATE TABLE Gailuak (
    ID_Gailuak INT PRIMARY KEY AUTO_INCREMENT,
    Gailu_Mota ENUM('Ordenagailuak', 'Imprimagailuak', 'BesteGailuak') NOT NULL,
    ID_Mintegia INT,
    Marka VARCHAR(20) NOT NULL,
    Modeloa VARCHAR(20) NOT NULL,
    Erosketa_data DATETIME NOT NULL,
    EzabatzekoMarka BOOLEAN NOT NULL DEFAULT 0,
    EgoeraGailua ENUM('Ongi', 'Apurtuta') NOT NULL DEFAULT 'Ongi',
    FOREIGN KEY (ID_Mintegia) REFERENCES Mintegiak(ID_Mintegia)
);


-- 'Kompontzen' aukerab gehtzeko opzioa
USE inbentarioa; 
ALTER TABLE Gailuak 
MODIFY COLUMN EgoeraGailua ENUM('Ongi', 'Apurtuta', 'Kompontzen') 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci 
NOT NULL DEFAULT 'Ongi';

-- 3. Tablas que dependen de Gailuak (creadas después)
CREATE TABLE EzabatutakoGailuak (
    ID_Ezabatua INT AUTO_INCREMENT PRIMARY KEY,   -- Erregistro hauen identifikatzaile bakarra
    ID_Gailuak INT,                               -- Gailu originalaren ID-a (Gailuak.ID_Gailuak)
    Data_Ezabatu DATETIME NOT NULL,               -- Noiz ezabatu den
    Marka VARCHAR(100),
    Modeloa VARCHAR(100)
);



CREATE TABLE Ordenagailuak (
    ID_Gailuak INT PRIMARY KEY,
    Memoria_RAM INT NOT NULL,
    TxartelGrafikoa VARCHAR(20) NOT NULL,
    USB_Portuak INT NOT NULL,
    Marka VARCHAR(20) NOT NULL,
    Modeloa VARCHAR(40) NOT NULL,
    Izena VARCHAR(20) NOT NULL DEFAULT 'Ordenagailuak',
    FOREIGN KEY (ID_Gailuak) REFERENCES Gailuak(ID_Gailuak) ON DELETE CASCADE,
    CHECK (Izena = 'Ordenagailuak')
);


CREATE TABLE Imprimagailuak (
    ID_Gailuak INT PRIMARY KEY,
    Izena VARCHAR(20) NOT NULL DEFAULT 'Imprimagailuak',
    Marka VARCHAR(40) NOT NULL,
    Modeloa VARCHAR(40) NOT NULL,
    FOREIGN KEY (ID_Gailuak) REFERENCES Gailuak(ID_Gailuak),
    CHECK (Izena = 'Imprimagailuak')
);

CREATE TABLE BesteGailuak (
    ID_Gailuak INT PRIMARY KEY,
    Izena VARCHAR(50) NOT NULL DEFAULT 'BesteGailuak',
    Marka VARCHAR(40) NOT NULL,
    Modeloa VARCHAR(40) NOT NULL,
    FOREIGN KEY (ID_Gailuak) REFERENCES Gailuak(ID_Gailuak),
    CHECK (Izena = 'BesteGailuak')
);


