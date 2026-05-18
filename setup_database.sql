-- =============================================================
-- Datenbankschema für Wetterdaten (OpenWeatherMap)
-- Azure SQL – Schema dbo
-- =============================================================

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'cities' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
    CREATE TABLE dbo.cities (
        id               INT          NOT NULL IDENTITY(1,1) PRIMARY KEY,
        name             NVARCHAR(64) NOT NULL,
        country          NVARCHAR(64),
        lat              FLOAT,
        lon              FLOAT,
        timezone_offset  INT,
        CONSTRAINT UQ_cities_name UNIQUE (name)
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'weather_current' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
    CREATE TABLE dbo.weather_current (
        id                  INT           NOT NULL IDENTITY(1,1) PRIMARY KEY,
        city_id             INT           NOT NULL,
        fetched_at          DATETIME2     NOT NULL,
        measured_at         DATETIME2     NOT NULL,
        temp                FLOAT,
        feels_like          FLOAT,
        temp_min            FLOAT,
        temp_max            FLOAT,
        humidity            INT,
        pressure            INT,
        weather_main        NVARCHAR(64),
        weather_description NVARCHAR(128),
        weather_icon        NVARCHAR(16),
        wind_speed          FLOAT,
        wind_deg            INT,
        clouds              INT,
        visibility          INT,
        sunrise             DATETIME2,
        sunset              DATETIME2,
        CONSTRAINT FK_weather_current_city FOREIGN KEY (city_id) REFERENCES dbo.cities(id)
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'weather_forecast' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
    CREATE TABLE dbo.weather_forecast (
        id                  INT           NOT NULL IDENTITY(1,1) PRIMARY KEY,
        city_id             INT           NOT NULL,
        fetched_at          DATETIME2     NOT NULL,
        forecast_at         DATETIME2     NOT NULL,
        temp                FLOAT,
        feels_like          FLOAT,
        temp_min            FLOAT,
        temp_max            FLOAT,
        humidity            INT,
        pressure            INT,
        weather_main        NVARCHAR(64),
        weather_description NVARCHAR(128),
        weather_icon        NVARCHAR(16),
        wind_speed          FLOAT,
        wind_deg            INT,
        clouds              INT,
        pop                 FLOAT,
        CONSTRAINT FK_weather_forecast_city FOREIGN KEY (city_id) REFERENCES dbo.cities(id)
    );
END
GO
