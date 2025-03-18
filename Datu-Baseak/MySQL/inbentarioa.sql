CREATE DATABASE Inbentarioa;
USE Inbentarioa;

CREATE TABLE Mintegiak (
    ID_Mintegia INT PRIMARY KEY,
    Izena VARCHAR(20) NOT NULL,
    Kokapena VARCHAR(20) NOT NULL
);

CREATE TABLE Gailuak (
    ID_Gailuak INT PRIMARY KEY,
    ID_Mintegia INT,
    Marka VARCHAR(20) NOT NULL,
    Izena VARCHAR(20) NOT NULL,
    Erosketa_data DATETIME NOT NULL,  -- YYYY-MM-DD
    Egoera BOOL NOT NULL, -- Apurtuta = Bai/Ez
    FOREIGN KEY (ID_Mintegia) REFERENCES Mintegiak(ID_Mintegia)
);

CREATE TABLE Ordenagailuak (
    ID_Gailuak INT PRIMARY KEY,
    Memoria_RAM INT NOT NULL,
    TxartelGrafikoa VARCHAR(20) NOT NULL,
    USB_Portuak INT NOT NULL,
    Kolorea VARCHAR(20) NOT NULL,
    Egoera BOOL NOT NULL,
    Marka VARCHAR(20) NOT NULL,
    Izena VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Gailuak) REFERENCES Gailuak(ID_Gailuak)
);

CREATE TABLE Imprimagailuak (
    ID_Gailuak INT PRIMARY KEY,
    Kolorea VARCHAR(20) NOT NULL,
    Egoera BOOL NOT NULL,
    FOREIGN KEY (ID_Gailuak) REFERENCES Gailuak(ID_Gailuak)
);

CREATE TABLE Erabiltzaileak (
    ID_Erabiltzaileak INT PRIMARY KEY,
    Izena VARCHAR(20) NOT NULL,
    Errola VARCHAR(20) NOT NULL
);

CREATE TABLE EzabatutakoGailuak (
    ID_Gailuak INT PRIMARY KEY,
    Data_Ezabatu DATE NOT NULL,
    Izena VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Gailuak) REFERENCES Gailuak(ID_Gailuak)
);
