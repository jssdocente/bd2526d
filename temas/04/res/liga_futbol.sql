DROP DATABASE IF EXISTS LigaFutbol;
CREATE DATABASE LigaFutbol CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE LigaFutbol;

-- 1. Estadio
CREATE TABLE Estadio (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    capacidad INT UNSIGNED NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    añoInauguracion YEAR,
    tieneCespedNatural BOOLEAN DEFAULT TRUE
);

-- 2. Equipo
CREATE TABLE Equipo (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    añoFundacion INT,
    presupuesto DECIMAL(15, 2) CHECK (presupuesto >= 0),
    webOficial TEXT,
    estadioID INT UNSIGNED UNIQUE NOT NULL,
    FOREIGN KEY (estadioID) REFERENCES Estadio(id)
);

-- 3. Entrenador
CREATE TABLE Entrenador (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    salario DOUBLE,
    fechaNacimiento DATE,
    equipoID INT UNSIGNED UNIQUE NOT NULL,
    FOREIGN KEY (equipoID) REFERENCES Equipo(id)
);

-- 4. Jugador
-- Relación reflexiva: mentorID
CREATE TABLE Jugador (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numeroLicencia VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dorsal INT UNSIGNED,
    posicion ENUM('Portero', 'Defensa', 'Centrocampista', 'Delantero') NOT NULL,
    fechaNacimiento DATE NOT NULL,
    altura FLOAT,
    peso DOUBLE,
    equipoID INT UNSIGNED NOT NULL,
    mentorID INT UNSIGNED,
    FOREIGN KEY (equipoID) REFERENCES Equipo(id),
    FOREIGN KEY (mentorID) REFERENCES Jugador(id)
);

-- 5. Arbitro
-- experienciaAnios es calculado (virtual via Generated Column)
CREATE TABLE Arbitro (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numeroColegiado INT UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fechaInicioArbitraje DATE NOT NULL,
    experienciaAños INT GENERATED ALWAYS AS (TIMESTAMPDIFF(YEAR, fechaInicioArbitraje, CURDATE())) VIRTUAL,
    categoria VARCHAR(50)
);

-- 6. Temporada
CREATE TABLE Temporada (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL, -- Ej: "2024-2025"
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    esActiva BOOLEAN DEFAULT TRUE
);

-- 7. Jornada
CREATE TABLE Jornada (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numero INT NOT NULL,
    fechaInicio DATE,
    temporadaID INT UNSIGNED NOT NULL,
    FOREIGN KEY (temporadaID) REFERENCES Temporada(id)
);

-- 8. Partido
-- Relaciona Equipos (Local/Visitante), Arbitro, Jornada, Estadio
CREATE TABLE Partido (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    fechaHora DATETIME NOT NULL,
    clima VARCHAR(50),
    asistencia INT UNSIGNED,
    equipoLocalID INT UNSIGNED NOT NULL,
    equipoVisitanteID INT UNSIGNED NOT NULL,
    arbitroID INT UNSIGNED NOT NULL,
    jornadaID INT UNSIGNED NOT NULL,
    estadioID INT UNSIGNED NOT NULL,
    FOREIGN KEY (equipoLocalID) REFERENCES Equipo(id),
    FOREIGN KEY (equipoVisitanteID) REFERENCES Equipo(id),
    FOREIGN KEY (arbitroID) REFERENCES Arbitro(id),
    FOREIGN KEY (jornadaID) REFERENCES Jornada(id),
    FOREIGN KEY (estadioID) REFERENCES Estadio(id),
    CHECK (equipoLocalID <> equipoVisitanteID)
);

-- 9. EstadisticaPartido
-- Relación M:N entre Jugador y Partido con atributos
CREATE TABLE EstadisticaPartido (
    jugadorID INT UNSIGNED NOT NULL,
    partidoID INT UNSIGNED NOT NULL,
    minutosJugados INT DEFAULT 0,
    goles INT DEFAULT 0,
    asistencias INT DEFAULT 0,
    tarjetasAmarilla INT DEFAULT 0,
    tarjetasRoja INT DEFAULT 0,
    PRIMARY KEY (jugadorID, partidoID),
    FOREIGN KEY (jugadorID) REFERENCES Jugador(id),
    FOREIGN KEY (partidoID) REFERENCES Partido(id)
);

-- 10. Patrocinador
CREATE TABLE Patrocinador (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombreEmpresa VARCHAR(100) NOT NULL,
    sector VARCHAR(50),
    tipoContrato VARCHAR(50),
    emailContacto VARCHAR(150)
);

-- 11. ContratoPatrocinio
-- Relación M:N entre Equipo y Patrocinador
CREATE TABLE ContratoPatrocinio (
    equipoID INT UNSIGNED NOT NULL,
    patrocinadorID INT UNSIGNED NOT NULL,
    fechaFirma DATE NOT NULL,
    duracionMeses INT NOT NULL,
    montoTotal DECIMAL(15, 2) NOT NULL,
    ubicacionLogo VARCHAR(100),
    PRIMARY KEY (equipoID, patrocinadorID),
    FOREIGN KEY (equipoID) REFERENCES Equipo(id),
    FOREIGN KEY (patrocinadorID) REFERENCES Patrocinador(id)
);

-- 12. HistorialTraspaso
CREATE TABLE HistorialTraspaso (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    jugadorID INT UNSIGNED NOT NULL,
    equipoOrigenID INT UNSIGNED NOT NULL,
    equipoDestinoID INT UNSIGNED NOT NULL,
    fechaTraspaso DATE NOT NULL,
    costo DECIMAL(15, 2),
    FOREIGN KEY (jugadorID) REFERENCES Jugador(id),
    FOREIGN KEY (equipoOrigenID) REFERENCES Equipo(id),
    FOREIGN KEY (equipoDestinoID) REFERENCES Equipo(id)
);
