/****** Script for SelectTopNRows command from SSMS  ******/
-- Limpieza de datos con consultas en SQL.

--Primero visualizamos el dataset en su totalidad.
SELECT * FROM VIVIENDAS.dbo.Nashville


-- Estandarizar formato fecha (pasar de datetime a date, ya que la hora está siempre establecida en 0, no aporta información.

SELECT SaleDate FROM VIVIENDAS.dbo.Nashville;

USE VIVIENDAS

ALTER TABLE Nashville
ADD SaleDate2 Date;

UPDATE Nashville
SET SaleDate2 = CONVERT(Date, SaleDate);

-- Poblar los campos con valores nulos en PropertyAdress (direccion del inmueble) 
-- Es necesario hacer un 'Self Join', para rellenar en base al campo ParcelId (porque si el inmueble tiene igual ParcelID tendrá igual dirección.
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Nashville a
JOIN Nashville b
ON a.ParcelID=b.ParcelID
AND a.[UniqueID ]<>b.[UniqueID ]
WHERE a.PropertyAddress is null

UPDATE a
SET a.PropertyAddress= ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Nashville a
JOIN Nashville b
ON a.ParcelID=b.ParcelID
AND a.[UniqueID ]<>b.[UniqueID ]
WHERE a.PropertyAddress is null

-- Separando la columna 'PropertyAdress' en otras tres, que contengan Direccion y Ciudad, usando la función Substring.
SELECT PropertyAddress 
FROM Nashville

SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) as City
FROM Nashville

ALTER TABLE Nashville
ADD PropertySplitAddress nvarchar(255);

UPDATE Nashville
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1);

ALTER TABLE Nashville
ADD PropertySplitCity nvarchar(255);

UPDATE Nashville
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress));

-- Se lleva una transformación similar con el campo OwnerAddress, pero sin usar substrings sino la función PARSENAME.
-- Parsename separa el string en columnas donde hay puntos, dado que en el campo OwnerAddress no hay puntos sino comas, hay que hacer un reemplazo.

Select OwnerAddress
FROM Nashville

SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) as Address,
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) as City,
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) as State
FROM Nashville

ALTER TABLE Nashville
ADD OwnerSplitAddress nvarchar(255);

UPDATE Nashville
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3);

ALTER TABLE Nashville
ADD OwnerSplitCity nvarchar(255);

UPDATE Nashville
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2);

ALTER TABLE Nashville
ADD OwnerSplitState nvarchar(255);

UPDATE Nashville
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);

-- En el campo 'SoldAsVacant' reemplazar los valores 'Y' y 'N' por 'Yes' and 'No'
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant) as cantidad
FROM Nashville
GROUP BY SoldAsVacant
ORDER BY cantidad DESC

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
     WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END
FROM Nashville

UPDATE Nashville
SET SoldAsVacant = 
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
     WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END

--Remover registros duplicados

WITH RowNumberCTE AS (
SELECT *, ROW_NUMBER() OVER (PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference ORDER BY UniqueID)  RowNumber
FROM Nashville )

DELETE FROM RowNumberCTE
WHERE RowNumber>1


-- Eliminar Columnas que no tienen uso, como OwnerAddress, cuyos datos se transfirieron a otras columnas.

ALTER TABLE Nashville
DROP COLUMN PropertyAddress, OwnerAddress, SaleDate