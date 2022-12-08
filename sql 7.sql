--DISTINCT KULLANIMI
CREATE TABLE maas
(
id int, 
musteri_isim varchar(50),
maas int 
);

INSERT INTO maas VALUES (10, 'Ali', '5000'); 
INSERT INTO maas VALUES (10, 'Ali', '7500'); 
INSERT INTO maas VALUES (20, 'Veli', '10000'); 
INSERT INTO maas VALUES (30, 'Ayse', '9000'); 
INSERT INTO maas VALUES (20, 'Ali', '6500'); 
INSERT INTO maas VALUES (10, 'Adem', '8000'); 
INSERT INTO maas VALUES (40, 'Veli', '8500'); 
INSERT INTO maas VALUES (20, 'Elif', '5500');

select * from maas

--Musteri urun tablosundan urun isimlerini tekrarsız(grup) listeleyiniz

--GROUP BY COZUMU
SELECT urun_isim FROM musteri_urun
GROUP BY urun_isim

--DISTINCT COZUMU
SELECT DISTINCT(urun_isim) FROM musteri_urun;

--Tabloda kac farklı meyve vardır

SELECT urun_isim, count(urun_isim) FROM musteri_urun 
GROUP BY urun_isim

--FETCH NEXT () ROW ONLY / OFFSET/ LIMIT

--Musteri urun tablosundan ilk üç kaydı listeleyiniz

SELECT * FROM musteri_urun ORDER BY urun_id
FETCH NEXT 3 ROW ONLY 

--LIMIT 
SELECT * FROM musteri_urun ORDER BY urun_id
limit 3

--Musteri urun tablosundan ilk kaydı listeleyiniz
SELECT * FROM musteri_urun ORDER BY urun_id
limit 1

--Musteri urun tablosundan son uc kaydı listeleyiniz
SELECT * FROM musteri_urun ORDER BY urun_id DESC 
limit 3

--En yuksek maasi alan müsteriyi listeleyiniz
SELECT * FROM maas ORDER BY maas desc

--Maas tablosundan en yuksek ikinci maasi listeleyiniz
SELECT * FROM maas ORDER BY maas DESC offset 1 limit 1

/*
OFFSET --> Satir atlamak istedigimizde offset komutunu kullanırız */
SELECT * FROM maas ORDER BY maas desc
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY 

--Maas tablosundan en dusuk dorduncu maasi listeleyiniz
SELECT * FROM maas ORDER BY maas offset 3 limit 3

--DDL - ALTER TABLE STATEMENT
	/*				
	ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns
	islemleri icin kullanilir.
	ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.
 */
CREATE TABLE personel1 (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel1_pk PRIMARY KEY (id)
);

INSERT INTO personel1 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel1 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel1 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel1 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel1 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel1 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel1 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM personel1
--1)ADD default deger ile tabloya bir field ekleme

ALTER TABLE personel
ADD ulke varchar(30)

ALTER TABLE personel
ADD adres varchar(50) DEFAULT 'Turkiye' --DEFAULT yazarsak olusturdugumuz sütüna belirttiğimiz
--veriyi tüm satırlara girer.

--2) DROP tablodan sutun silme

ALTER TABLE personel1
DROP COLUMN zipcode

ALTER TABLE personel1
DROP adres, drop sirket --İki sutunu birden sildik

-- 3)RENAME COLUMN sutun adi degistirme

ALTER TABLE personel1
RENAME COLUMN sehir TO il

--4)RENAME tablonun ismini degistirme
ALTER TABLE personel1 
RENAME TO isci

SELECT * FROM personel1
SELECT * FROM isci

-- 5)TYPE/SET(modify) sutunlarin ozelliklerini degistirme

ALTER TABLE isci
ALTER COLUMN il TYPE varchara(30),
ALTER COLUMN maas SET NOT NULL;

--Eğer numeric data type sahip bir sütunun data türüne string bir data türü atamak istersek
--TYPE varchar(30) USING(maas::varchar(30)) bu formatı kullanırız
ALTER COLUMN maas
TYPE varchar(30) USING(maas::varchar(30))
--TRANSACTION(BEGIN-SAVEPOINT-ROLLBACK-COMMIT)
/*
Transaction başlatmak için BEGIN komutu kullanmamız gerekir ve
Transaction'ı sonlandırmak için COMMIT komutunu calıstırmalıyız */

CREATE TABLE ogrenciler16
(
id serial, --Serial data türü otomatik olarak 1den baslayarak sıralı olarak sayı ataması yapar
	       --INSERT INTO ile tabloya veri eklerken serial data türünü kullandığım veri degeri
	       --yerine DEFAULT yazarız.
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);
BEGIN;
INSERT INTO ogrenciler16 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler16 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler16 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler16 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler16 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler16 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to y;
COMMIT;

SELECT * FROM ogrenciler16
