--DATABASE(Veri Tabanı) oluşturma
Create dataBase sena;

create database akyol;

--DDL - DATA DEFİNİTİON LANGUAGE
--CREATE - TABLO OLUŞTURMA
--TABLO OLUSTURMA
CREATE TABLE ogrenciler2
(
ogrenci_no char(7),
isim varchar(20),
soyİsim varchar(25),
not_ort real, --Ondalıklı sayılar icin kullanilir(double gibi)
kayit_tarih date	
);

--VAROLAN TABLODAN YENİ BİR TABLO OLUŞTURMA
CREATE TABLE ogrenci_notlari
AS --Benzer tablodaki başlıklarlar ve data tipleriyle yeni bir tablo olusturmak icin
--normal tablo olustururken ki parantezler yerine AS kullanıp Select komutuyla almak istediginiz verileri alırız.
SELECT isim,soyİsim,not_ort FROM ogrenciler2;

--DML - DATA MANUPULATION LANGUAGE
--INSERT (Database'e veri ekleme)

INSERT INTO ogrenciler2 VALUES('1234567', 'Said', 'ILHAN', 85.5,now());
INSERT INTO ogrenciler2 VALUES('1234567', 'Said', 'ILHAN', 85.5,'2020-12-11');

--BIR TABLOYA PARÇALI VERİ EKLEMEK İSTERSEK

INSERT INTO ogrenciler2 (isim,soyİsim) VALUES ('Erol', 'Evren');

--DQL -DATA QUERY LANGUAGE
--SELECT

select * FROM ogrenciler2; --Burdaki * sembolü her seyi anlamindadir.
