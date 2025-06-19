-- Lekcija: Skup cijelih brojeva
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Skup cijelih brojeva', 'Osnovna škola', '6'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Skup cijelih brojeva'
    AND school_level = 'Osnovna škola'
    AND grade = '6'
);

-- 1. Osnovni pojmovi
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji od ovih brojeva pripada skupu cijelih brojeva?', '3.14@ -5@ 1/2@ √2', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji od ovih brojeva pripada skupu cijelih brojeva?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji skup obuhvaća sve prirodne brojeve, njihove suprotnosti i nulu?', 'Racionalni brojevi@ Cijeli brojevi@ Prirodni brojevi@ Iracionalni brojevi', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji skup obuhvaća sve prirodne brojeve, njihove suprotnosti i nulu?');

-- 2. Apsolutna vrijednost
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko iznosi |-12|?', '-12@ 12@ 0@ 1', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko iznosi |-12|?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ako je |x| = 7, koliko može biti x?', 'Samo 7@ Samo -7@ 7 ili -7@ 0', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Ako je |x| = 7, koliko može biti x?');

-- 3. Uspoređivanje cijelih brojeva
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako se pravilno piše: -5 ___ -3?', '>@ <@ =@ ≥', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako se pravilno piše: -5 ___ -3?');

-- 4. Zbrajanje i oduzimanje
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je -8 + 5?', '-13@ -3@ 3@ 13', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je -8 + 5?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Rezultat oduzimanja 4 - 9 je:', '-5@ 5@ -13@ 13', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Rezultat oduzimanja 4 - 9 je:');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je -15 + (-20)?', '-35@ -5@ 5@ 35', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je -15 + (-20)?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 7 - (-3)?', '4@ 10@ -4@ -10', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 7 - (-3)?');

-- 5. Množenje i dijeljenje
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je -6 × (-7)?', '-42@ 42@ -13@ 1', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je -6 × (-7)?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Rezultat dijeljenja -24 ÷ 3 je:', '8@ -8@ 21@ -21', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Rezultat dijeljenja -24 ÷ 3 je:');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je (-4) × 5 × (-2)?', '-40@ -20@ 20@ 40', 3,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je (-4) × 5 × (-2)?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 0 ÷ (-5)?', '-5@ 0@ 5@ Nedefinirano', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 0 ÷ (-5)?');

-- 6. Kombinirane operacije
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 3 × (-4) + 10?', '-22@ -2@ 2@ 22', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 3 × (-4) + 10?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je (8 - 12) × (-3)?', '-12@ 12@ -4@ 4', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je (8 - 12) × (-3)?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je -20 ÷ (5 - 10)?', '-4@ 4@ -15@ 15', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je -20 ÷ (5 - 10)?');

-- 7. Riječni zadaci
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Temperatura je pala s 5°C na -3°C. Za koliko je stupnjeva pala temperatura?', '2@ 3@ 5@ 8', 3,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Temperatura je pala s 5°C na -3°C. Za koliko je stupnjeva pala temperatura?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Dubrovački brod je na površini mora (0 m), a podmornica je 120 m ispod njega. Ako podmornica zaroni još 80 m, na kojoj je dubini?', '-40 m@ -80 m@ -120 m@ -200 m', 3,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text LIKE 'Dubrovački brod je na površini mora%');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Marko ima 50 kn dugovanja (-50 kn), a dobio je 80 kn džeparca. Koliko sada ima novaca?', '-130 kn@ -30 kn@ 30 kn@ 130 kn', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text LIKE 'Marko ima 50 kn dugovanja%');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'U jednoj igri za 5 pogodaka dobiješ 3 boda, a za svaki promašaj gubiš 1 bod. Ana je imala 7 pogodaka i 4 promašaja. Koliko je bodova osvojila?', '17@ 15@ 13@ 11', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Skup cijelih brojeva' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text LIKE 'U jednoj igri za 5 pogodaka%');

-- Lekcija: Kut i trokut
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Kut i trokut', 'Osnovna škola', '6'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Kut i trokut'
    AND school_level = 'Osnovna škola'
    AND grade = '6'
);

-- 1. Osnovni pojmovi o kutovima
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliki je zbroj susjednih kutova na pravcu?', '90°@ 180°@ 270°@ 360°', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliki je zbroj susjednih kutova na pravcu?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kut od 90° nazivamo:', 'Oštar kut@ Pravi kut@ Tupi kut@ Ispruženi kut', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kut od 90° nazivamo:');

-- 2. Vrste kutova
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji kut je veći od 90° a manji od 180°?', 'Oštar kut@ Pravi kut@ Tupi kut@ Ispruženi kut', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji kut je veći od 90° a manji od 180°?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko iznosi komplementni kut kutu od 35°?', '35°@ 45°@ 55°@ 145°', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko iznosi komplementni kut kutu od 35°?');

-- 3. Trokuti - osnovna svojstva
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliki je zbroj kutova u trokutu?', '90°@ 180°@ 270°@ 360°', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliki je zbroj kutova u trokutu?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako se naziva trokut kojemu su sve stranice različite duljine?', 'Jednakokračan@ Jednakostraničan@ Raznostraničan@ Pravokutan', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako se naziva trokut kojemu su sve stranice različite duljine?');

-- 4. Vrste trokuta prema kutovima
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako se naziva trokut kojemu je jedan kut veći od 90°?', 'Oštrokutan@ Pravokutan@ Tupokutan@ Jednakokračan', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako se naziva trokut kojemu je jedan kut veći od 90°?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliki je zbroj oštrih kutova u pravokutnom trokutu?', '45°@ 60°@ 90°@ 180°', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliki je zbroj oštrih kutova u pravokutnom trokutu?');

-- 5. Sukladnost trokuta
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji kriterij za sukladnost trokuta kaže da su trokuti sukladni ako imaju jednake sve tri stranice?', 'S-S-S@ S-K-S@ K-S-K@ K-K-K', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text LIKE 'Koji kriterij za sukladnost trokuta kaže');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ako su dva trokuta sukladna, što vrijedi za njihove odgovarajuće kutove?', 'Jednaki su@ Različiti su@ Zbroj im je 180°@ Ne možemo znati', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Ako su dva trokuta sukladna, što vrijedi za njihove odgovarajuće kutove?');

-- 6. Konstrukcije trokuta
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Može li se konstruirati trokut sa stranicama 5 cm, 7 cm i 15 cm?', 'Da, uvijek@ Da, ali samo pod određenim uvjetima@ Ne, nikada@ Ovisi o kutovima', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Može li se konstruirati trokut sa stranicama 5 cm, 7 cm i 15 cm?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko različitih trokuta možemo konstruirati ako su zadane sve tri stranice?', '0@ 1@ 2@ Beskonačno mnogo', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko različitih trokuta možemo konstruirati ako su zadane sve tri stranice?');

-- 7. Opseg trokuta
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliki je opseg trokuta sa stranicama 5 cm, 7 cm i 9 cm?', '15 cm@ 21 cm@ 25 cm@ 31 cm', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliki je opseg trokuta sa stranicama 5 cm, 7 cm i 9 cm?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ako je opseg jednakostraničnog trokuta 24 cm, kolika je duljina njegove stranice?', '6 cm@ 8 cm@ 12 cm@ 24 cm', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Ako je opseg jednakostraničnog trokuta 24 cm, kolika je duljina njegove stranice?');

-- 8. Površina trokuta
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kolika je površina trokuta sa osnovicom 10 cm i visinom 6 cm?', '16 cm²@ 30 cm²@ 60 cm²@ 120 cm²', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kolika je površina trokuta sa osnovicom 10 cm i visinom 6 cm?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ako je površina trokuta 42 cm², a osnovica 12 cm, kolika je visina na tu osnovicu?', '3.5 cm@ 7 cm@ 14 cm@ 21 cm', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Ako je površina trokuta 42 cm², a osnovica 12 cm, kolika je visina na tu osnovicu?');

-- 9. Primjene u geometriji
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko visina ima svaki trokut?', '1@ 2@ 3@ 4', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko visina ima svaki trokut?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'U pravokutnom trokutu, nasuprot pravog kuta je:', 'Najkraća stranica@ Srednja stranica@ Najduža stranica (hipotenuza)@ Visina', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'U pravokutnom trokutu, nasuprot pravog kuta je:');

-- 10. Riječni zadaci
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Stranice jednakokračnog trokuta su 5 cm, 5 cm i 8 cm. Koliki je njegov opseg?', '13 cm@ 15 cm@ 18 cm@ 20 cm', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text LIKE 'Stranice jednakokračnog trokuta su 5 cm');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Pravokutni trokut ima katete 6 cm i 8 cm. Kolika je njegova površina?', '14 cm²@ 24 cm²@ 48 cm²@ 96 cm²', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Kut i trokut' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Pravokutni trokut ima katete 6 cm i 8 cm. Kolika je njegova površina?');

-- Lekcija: Potencije baze 10
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Potencije baze 10', 'Osnovna škola', '6'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Potencije baze 10'
    AND school_level = 'Osnovna škola'
    AND grade = '6'
);

-- 1. Osnovni pojmovi
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako zapisujemo broj 1000 kao potenciju baze 10?', '10¹@ 10²@ 10³@ 10⁴', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako zapisujemo broj 1000 kao potenciju baze 10?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Što predstavlja eksponent u zapisu 10ⁿ?', 'Bazu@ Potenciju@ Broj nula u broju@ Broj ponavljanja množenja', 3,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Što predstavlja eksponent u zapisu 10ⁿ?');

-- 2. Pretvaranje u standardni oblik
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako zapisujemo 500 u obliku potencije baze 10?', '5 × 10¹@ 5 × 10²@ 5 × 10³@ 5 × 10⁴', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako zapisujemo 500 u obliku potencije baze 10?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako zapisujemo 0.001 koristeći potenciju baze 10?', '10³@ 10⁻³@ 10⁻²@ 10⁻¹', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako zapisujemo 0.001 koristeći potenciju baze 10?');

-- 3. Množenje potencija
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 10⁵ × 10²?', '10⁷@ 10¹⁰@ 10³@ 10²⁵', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 10⁵ × 10²?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 10³ × 10⁻²?', '10@ 10⁻⁶@ 10⁵@ 10¹', 3,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 10³ × 10⁻²?');

-- 4. Dijeljenje potencija
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 10⁸ ÷ 10⁵?', '10³@ 10¹³@ 10⁻³@ 10⁴⁰', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 10⁸ ÷ 10⁵?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 10⁻⁴ ÷ 10²?', '10⁻⁶@ 10⁻²@ 10²@ 10⁶', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 10⁻⁴ ÷ 10²?');

-- 5. Potenciranje potencija
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je (10²)³?', '10⁵@ 10⁶@ 10⁸@ 10⁹', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je (10²)³?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je (10⁻³)²?', '10⁻⁶@ 10⁻⁵@ 10⁵@ 10⁶', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je (10⁻³)²?');

-- 6. Primjene u stvarnom svijetu
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko nula ima broj 100 milijuna?', '6@ 7@ 8@ 9', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko nula ima broj 100 milijuna?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako zapisujemo 3.7 milijarde u znanstvenom zapisu?', '3.7 × 10⁶@ 3.7 × 10⁷@ 3.7 × 10⁸@ 3.7 × 10⁹', 3,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako zapisujemo 3.7 milijarde u znanstvenom zapisu?');

-- 7. Pretvaranje između oblika
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji je standardni oblik broja 4.2 × 10⁵?', '420@ 4,200@ 42,000@ 420,000', 3,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji je standardni oblik broja 4.2 × 10⁵?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji je znanstveni zapis broja 0.000072?', '7.2 × 10⁻⁴@ 7.2 × 10⁻⁵@ 7.2 × 10⁻⁶@ 7.2 × 10⁻⁷', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji je znanstveni zapis broja 0.000072?');

-- 8. Uspoređivanje veličina
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji je broj veći: 3 × 10⁴ ili 5 × 10³?', '3 × 10⁴@ 5 × 10³@ Jednaki su@ Ovisi o kontekstu', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji je broj veći: 3 × 10⁴ ili 5 × 10³?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji je broj manji: 2 × 10⁻³ ili 5 × 10⁻²?', '2 × 10⁻³@ 5 × 10⁻²@ Jednaki su@ Ovisi o kontekstu', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji je broj manji: 2 × 10⁻³ ili 5 × 10⁻²?');

-- 9. Kombinirane operacije
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je (2 × 10³) × (3 × 10⁴)?', '5 × 10⁷@ 6 × 10⁷@ 5 × 10¹²@ 6 × 10¹²', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je (2 × 10³) × (3 × 10⁴)?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je (8 × 10⁵) ÷ (2 × 10²)?', '4 × 10³@ 4 × 10⁷@ 6 × 10³@ 6 × 10⁷', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je (8 × 10⁵) ÷ (2 × 10²)?');

-- 10. Riječni zadaci
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Zemlja je udaljena od Sunca oko 150 milijuna km. Kako to zapisujemo u znanstvenom zapisu?', '1.5 × 10⁶ km@ 1.5 × 10⁷ km@ 1.5 × 10⁸ km@ 1.5 × 10⁹ km', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text LIKE 'Zemlja je udaljena od Sunca%');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Avion leti brzinom od 9 × 10² km/h. Koliko to iznosi u standardnom zapisu?', '90 km/h@ 900 km/h@ 9,000 km/h@ 90,000 km/h', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Potencije baze 10' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Avion leti brzinom od 9 × 10² km/h. Koliko to iznosi u standardnom zapisu?');

-- Lekcija: Razlomci
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Razlomci', 'Osnovna škola', '6'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Razlomci'
    AND school_level = 'Osnovna škola'
    AND grade = '6'
);

-- 1. Osnovni pojmovi
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Što predstavlja nazivnik u razlomku?', 'Broj dijelova cjeline@ Ukupan broj dijelova@ Vrijednost razlomka@ Broj ispred razlomka', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Što predstavlja nazivnik u razlomku?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji decimalni broj odgovara razlomku 3/4?', '0.25@ 0.34@ 0.5@ 0.75', 3,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji decimalni broj odgovara razlomku 3/4?');

-- 2. Vrste razlomaka
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako nazivamo razlomak čija je vrijednost veća od 1?', 'Pravi razlomak@ Nepravi razlomak@ Mješoviti broj@ Decimalni razlomak', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako nazivamo razlomak čija je vrijednost veća od 1?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako zapisujemo 2 1/3 kao nepravi razlomak?', '1/3@ 3/7@ 7/3@ 5/3', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako zapisujemo 2 1/3 kao nepravi razlomak?');

-- 3. Skraćivanje razlomaka
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako glasi skraćeni oblik razlomka 12/18?', '6/9@ 4/6@ 2/3@ 1/2', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako glasi skraćeni oblik razlomka 12/18?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji je najveći zajednički djelitelj brojeva 24 i 36?', '6@ 8@ 12@ 24', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji je najveći zajednički djelitelj brojeva 24 i 36?');

-- 4. Proširivanje razlomaka
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako glasi prošireni oblik razlomka 2/5 s nazivnikom 15?', '4/15@ 6/15@ 10/15@ 12/15', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako glasi prošireni oblik razlomka 2/5 s nazivnikom 15?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ako proširimo razlomak 3/7 s brojem 4, koliki ćemo dobiti razlomak?', '7/11@ 12/28@ 3/28@ 12/7', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Ako proširimo razlomak 3/7 s brojem 4, koliki ćemo dobiti razlomak?');

-- 5. Uspoređivanje razlomaka
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji je od ovih razlomaka najveći: 1/2, 2/3, 3/4, 5/6?', '1/2@ 2/3@ 3/4@ 5/6', 3,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text LIKE 'Koji je od ovih razlomaka najveći%');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Usporedi razlomke 3/5 i 2/3:', '3/5 > 2/3@ 3/5 < 2/3@ 3/5 = 2/3@ Nije moguće usporediti', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Usporedi razlomke 3/5 i 2/3:');

-- 6. Pretvaranje u decimalni oblik
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji decimalni broj odgovara razlomku 1/8?', '0.125@ 0.25@ 0.375@ 0.5', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji decimalni broj odgovara razlomku 1/8?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako zapisujemo 0.6 kao razlomak u najjednostavnijem obliku?', '6/10@ 3/5@ 2/3@ 60/100', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako zapisujemo 0.6 kao razlomak u najjednostavnijem obliku?');

-- 7. Recipročni razlomci
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji je recipročni vrijednost razlomka 5/7?', '7/5@ 5/7@ -5/7@ -7/5', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji je recipročni vrijednost razlomka 5/7?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko iznosi umnožak razlomka i njegove recipročne vrijednosti?', '0@ 1@ -1@ Ovisi o razlomku', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko iznosi umnožak razlomka i njegove recipročne vrijednosti?');

-- 8. Riječni zadaci
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Marko je pojeo 3/8 pizze, a Ana 1/2 pizze. Tko je pojeo više?', 'Marko@ Ana@ Jednako@ Nije moguće odrediti', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text LIKE 'Marko je pojeo 3/8 pizze%');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'U razredu od 24 učenika, 5/8 su djevojčice. Koliko je djevojčica u razredu?', '8@ 12@ 15@ 20', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'U razredu od 24 učenika, 5/8 su djevojčice. Koliko je djevojčica u razredu?');

-- 9. Kombinirane operacije
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji je rezultat izraza 1/2 + 1/3?', '2/5@ 5/6@ 3/5@ 1/6', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji je rezultat izraza 1/2 + 1/3?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 3/4 × 2/9?', '1/6@ 5/13@ 6/36@ 5/36', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Razlomci' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 3/4 × 2/9?');

-- Lekcija: Računanje s razlomcima
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Računanje s razlomcima', 'Osnovna škola', '6'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Računanje s razlomcima'
    AND school_level = 'Osnovna škola'
    AND grade = '6'
);

-- 1. Zbrajanje s istim nazivnikom
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 3/7 + 2/7?', '5/7@ 5/14@ 1@ 6/7', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 3/7 + 2/7?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 5/12 + 1/12 + 3/12?', '9/12@ 9/36@ 3/4@ 1/4', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 5/12 + 1/12 + 3/12?');

-- 2. Zbrajanje s različitim nazivnicima
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 1/3 + 1/6?', '1/9@ 1/2@ 2/9@ 2/3', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 1/3 + 1/6?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 2/5 + 3/10?', '5/15@ 7/10@ 1/2@ 6/15', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 2/5 + 3/10?');

-- 3. Oduzimanje razlomaka
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 7/8 - 3/8?', '4/0@ 1/2@ 4/8@ 10/8', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 7/8 - 3/8?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 3/4 - 1/3?', '2/1@ 5/12@ 2/7@ 4/7', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 3/4 - 1/3?');

-- 4. Množenje razlomaka
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 2/3 × 3/4?', '6/12@ 1/2@ 5/7@ 6/7', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 2/3 × 3/4?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 5 × 1/4?', '1/20@ 5/4@ 4/5@ 20', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 5 × 1/4?');

-- 5. Dijeljenje razlomaka
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 3/4 ÷ 2/5?', '6/20@ 15/8@ 8/15@ 5/6', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 3/4 ÷ 2/5?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 6 ÷ 1/3?', '2@ 3@ 18@ 1/18', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 6 ÷ 1/3?');

-- 6. Kombinirane operacije
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je (1/2 + 1/4) × 2/3?', '1/2@ 3/4@ 1/3@ 2/3', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je (1/2 + 1/4) × 2/3?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je (3/4 - 1/2) ÷ (1/8 + 1/4)?', '1/3@ 2/3@ 1@ 4/3', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je (3/4 - 1/2) ÷ (1/8 + 1/4)?');

-- 7. Postoci
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako zapisujemo 25% kao razlomak u najjednostavnijem obliku?', '25/100@ 1/4@ 2/5@ 1/25', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako zapisujemo 25% kao razlomak u najjednostavnijem obliku?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko je 20% od 150?', '15@ 20@ 30@ 75', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko je 20% od 150?');

-- 8. Riječni zadaci
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ana je pročitala 1/4 knjige prvog dana i 1/3 knjige drugog dana. Koliki dio knjige je pročitala u dva dana?', '2/7@ 5/12@ 7/12@ 2/12', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text LIKE 'Ana je pročitala 1/4 knjige%');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'U vrtu je 3/8 površine posađeno rajčicama, a 1/6 paprika. Koji je dio vrta posađen povrćem?', '4/14@ 13/24@ 1/2@ 5/24', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'U vrtu je 3/8 površine posađeno rajčicama, a 1/6 paprika. Koji je dio vrta posađen povrćem?');

-- 9. Primjene u stvarnom životu
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ako je 30% učenika u razredu djevojčice, a u razredu ima 20 učenika, koliko je djevojčica?', '6@ 10@ 12@ 15', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Ako je 30% učenika u razredu djevojčice, a u razredu ima 20 učenika, koliko je djevojčica?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Cijena majice je smanjena za 1/5 iznosa. Ako je originalna cijena bila 200 kn, kolika je nova cijena?', '40 kn@ 160 kn@ 180 kn@ 240 kn', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Računanje s razlomcima' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text LIKE 'Cijena majice je smanjena za 1/5%');


-- Lekcija: Koordinatni sustav i prikazivanje podataka
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Koordinatni sustav i prikazivanje podataka', 'Osnovna škola', '6'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Koordinatni sustav i prikazivanje podataka'
    AND school_level = 'Osnovna škola'
    AND grade = '6'
);

-- 1. Razlomci na brojevnom pravcu
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Na kojem mjestu se nalazi razlomak 3/4 na brojevnom pravcu?', 'Ispred 0@ Ispred 1/2@ Ispred 1@ Točno na 1', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Na kojem mjestu se nalazi razlomak 3/4 na brojevnom pravcu?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji razlomak se nalazi između 1/2 i 1 na brojevnom pravcu?', '1/4@ 2/4@ 3/4@ 5/5', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji razlomak se nalazi između 1/2 i 1 na brojevnom pravcu?');

-- 2. Uređeni parovi
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji je prvi broj u uređenom paru (2, 5)?', '2@ 5@ 7@ 0', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji je prvi broj u uređenom paru (2, 5)?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Što označava drugi broj u uređenom paru (x, y)?', 'Položaj na x-osi@ Broj točaka@ Položaj na y-osi@ Zbroj x i y', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Što označava drugi broj u uređenom paru (x, y)?');

-- 3. Pravokutni koordinatni sustav u ravnini
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako se zove točka (0, 0) u koordinatnom sustavu?', 'Ishodište@ Središte kruga@ Točka A@ Os x', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako se zove točka (0, 0) u koordinatnom sustavu?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji je položaj točke (3, 2)?', '3 gore, 2 lijevo@ 3 desno, 2 gore@ 3 dolje, 2 desno@ 2 desno, 3 gore', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji je položaj točke (3, 2)?');

-- 4. Prikazivanje i interpretacija podataka
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Na stupčastom dijagramu je prikazano koliko knjiga su učenici pročitali. Ako je stupac za Luku na 6, koliko je knjiga pročitao?', '3@ 5@ 6@ 8', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text LIKE 'Na stupčastom dijagramu je prikazano%Luka%');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ako je na kružnom diagramu označeno da je 1/2 kolača pojedeno, koliko je preostalo?', '1/4@ 2/4@ 1/2@ 3/4', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Ako je na kružnom diagramu označeno da je 1/2 kolača pojedeno, koliko je preostalo?');

-- 5. Razlomci na brojevnom pravcu (nastavak)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji razlomak se nalazi na polovici između 0 i 1?', '1/4@ 2/4@ 3/4@ 1/2', 3,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji razlomak se nalazi na polovici između 0 i 1?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji je razlomak točno na sredini između 1/2 i 3/4?', '5/8@ 2/3@ 3/8@ 1/4', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji je razlomak točno na sredini između 1/2 i 3/4?');

-- 6. Uređeni parovi (nastavak)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji je uređeni par ako je x = 4, a y = -2?', '(4,2)@ (4,-2)@ (-4,2)@ (-4,-2)', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji je uređeni par ako je x = 4, a y = -2?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Točka (0, 5) nalazi se na kojoj osi?', 'Na x-osi@ Na y-osi@ U ishodištu@ Nema osi', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Točka (0, 5) nalazi se na kojoj osi?');

-- 7. Pravokutni koordinatni sustav (nastavak)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji kvadrant sadrži točku (−3, 4)?', 'I. kvadrant@ II. kvadrant@ III. kvadrant@ IV. kvadrant', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji kvadrant sadrži točku (−3, 4)?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Točka (x, 0) uvijek se nalazi na kojoj osi?', 'y-osi@ x-osi@ Nema osi@ Dijagonali', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Točka (x, 0) uvijek se nalazi na kojoj osi?');

-- 8. Prikazivanje i interpretacija podataka (nastavak)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Na grafikonu je prikazano da je broj prodanih ulaznica rastao linearno. Koji oblik ima linija?', 'Zakrivljen@ Valovit@ Ravna@ Kružna', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Na grafikonu je prikazano da je broj prodanih ulaznica rastao linearno. Koji oblik ima linija?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'U kružnom dijagramu 1/3 dijela je označeno kao vrijeme provedeno u školi. Koliki dio dana je to?', '4 sata@ 6 sati@ 8 sati@ 12 sati', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'U kružnom dijagramu 1/3 dijela je označeno kao vrijeme provedeno u školi. Koliki dio dana je to?');

-- 9. Svakodnevne situacije s koordinatama i podacima
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Marko se nalazi na točki (3, 0). Kuda se mora pomaknuti da dođe do (3, 4)?', '4 lijevo@ 4 dolje@ 4 gore@ 3 desno', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Marko se nalazi na točki (3, 0). Kuda se mora pomaknuti da dođe do (3, 4)?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ako je temperatura u 8h bila 2°C, a u 12h 10°C, koliki je prosječan porast po satu?', '1°C@ 2°C@ 3°C@ 4°C', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Ako je temperatura u 8h bila 2°C, a u 12h 10°C, koliki je prosječan porast po satu?');

-- 10. Kombinirano
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Točka A ima koordinate (1/2, 1). Gdje se nalazi?', 'Ispod x-osi@ U prvom kvadrantu@ Na y-osi@ Na ishodištu', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Točka A ima koordinate (1/2, 1). Gdje se nalazi?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koordinate točke B su (−1, −3). U kojem se kvadrantu nalazi?', 'I.@ II.@ III.@ IV.', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Koordinatni sustav i prikazivanje podataka' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koordinate točke B su (−1, −3). U kojem se kvadrantu nalazi?');


--Lekcija: Linearne jednadžbe s jednom nepoznanicom
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Linearne jednadžbe s jednom nepoznanicom', 'Osnovna škola', '6'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Linearne jednadžbe s jednom nepoznanicom'
    AND school_level = 'Osnovna škola'
    AND grade = '6'
);

-- 1–5: Algebarski izrazi
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji izraz predstavlja zbroj broja x i 5?', 'x + 5@ x − 5@ 5x@ x ÷ 5', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji izraz predstavlja zbroj broja x i 5?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako zapisujemo izraz: proizvod broja x i 3?', 'x + 3@ x − 3@ 3x@ x ÷ 3', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako zapisujemo izraz: proizvod broja x i 3?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Što predstavlja izraz 2(x + 3)?', '2 puta x, pa +3@ 2 puta zbroj x i 3@ zbroj 2 i x, pa +3@ 2 + x + 3', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Što predstavlja izraz 2(x + 3)?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji izraz je pojednostavljen oblik izraza: 5x − 2x + 4?', '7x + 4@ 3x + 4@ 5x + 4@ 3x − 4', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji izraz je pojednostavljen oblik izraza: 5x − 2x + 4?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji izraz odgovara izrazu: "četiri puta broj, umanjeno za 7"?', '4x + 7@ 4x − 7@ x − 7@ 7x − 4', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji izraz odgovara izrazu: "četiri puta broj, umanjeno za 7"?');

-- 6–12: Rješavanje linearnih jednadžbi
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Riješi jednadžbu: x + 5 = 12', '5@ 7@ 17@ −7', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Riješi jednadžbu: x + 5 = 12');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Riješi jednadžbu: 3x = 15', '5@ 3@ 45@ 12', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Riješi jednadžbu: 3x = 15');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Riješi jednadžbu: 2x − 4 = 10', '6@ 7@ 8@ 10', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Riješi jednadžbu: 2x − 4 = 10');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koja je vrijednost x u jednadžbi: 5x + 3 = 18?', '2@ 3@ 4@ 5', 3,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koja je vrijednost x u jednadžbi: 5x + 3 = 18?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Riješi jednadžbu: x/2 = 6', '12@ 3@ 8@ 10', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Riješi jednadžbu: x/2 = 6');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliko iznosi x u: 7 − x = 2?', '5@ −5@ 3@ −3', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliko iznosi x u: 7 − x = 2?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Riješi jednadžbu: 4x + 2 = 2x + 10', 'x = 2@ x = 4@ x = −2@ x = 6', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Riješi jednadžbu: 4x + 2 = 2x + 10');

-- 13–20: Primjena jednadžbi
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ana i Marko zajedno imaju 30 kuna. Ana ima x kuna, a Marko ima 2x. Koliko ima Marko?', '10@ 15@ 20@ 5', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Ana i Marko zajedno imaju 30 kuna. Ana ima x kuna, a Marko ima 2x. Koliko ima Marko?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Cijena čokolade je 3 kune više od cijene bombona. Bombon košta x kuna. Čokolada košta?', 'x + 3@ x − 3@ 3x@ x ÷ 3', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Cijena čokolade je 3 kune više od cijene bombona. Bombon košta x kuna. Čokolada košta?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Za film i kokice potrošeno je ukupno 60 kn. Film je koštao 40 kn, koliko su koštale kokice?', 'x = 20@ x = 30@ x = 10@ x = 60', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Za film i kokice potrošeno je ukupno 60 kn. Film je koštao 40 kn, koliko su koštale kokice?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Auto vozi 60 km/h. Koliko vremena mu treba da prijeđe 180 km?', 'x = 2@ x = 3@ x = 4@ x = 5', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Auto vozi 60 km/h. Koliko vremena mu treba da prijeđe 180 km?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Jednadžba za obujam kvadra je: V = a²h. Ako je a = 2, h = x, a V = 16, koliko je x?', 'x = 2@ x = 4@ x = 8@ x = 1', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Jednadžba za obujam kvadra je: V = a²h. Ako je a = 2, h = x, a V = 16, koliko je x?');

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ivana ima 5 godina više nego Petar. Zajedno imaju 35 godina. Koliko ima Petar?', 'x = 15@ x = 20@ x = 25@ x = 30', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Linearne jednadžbe s jednom nepoznanicom' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Ivana ima 5 godina više nego Petar. Zajedno imaju 35 godina. Koliko ima Petar?');


--Lekcija: Paralelogrami
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Paralelogrami', 'Osnovna škola', '6'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Paralelogrami'
    AND school_level = 'Osnovna škola'
    AND grade = '6'
);

-- 1. Osnovno prepoznavanje paralelograma
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji od navedenih likova je paralelogram?', 'Trokut@ Kvadrat@ Trapez@ Krug', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji od navedenih likova je paralelogram?');

-- 2. Svojstva paralelograma
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koja tvrdnja vrijedi za paralelogram?', 'Sve stranice su jednake@ Suprotne stranice su jednake i paralelne@ Svi kutovi su pravi@ Dijagonale su jednake', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koja tvrdnja vrijedi za paralelogram?');

-- 3. Vrste paralelograma
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji od ovih likova je vrsta paralelograma?', 'Kvadrat@ Krug@ Trokut@ Trapez', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji od ovih likova je vrsta paralelograma?');

-- 4. Opseg paralelograma
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ako su stranice paralelograma 6 cm i 4 cm, koliki je njegov opseg?', '10 cm@ 12 cm@ 20 cm@ 24 cm', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Ako su stranice paralelograma 6 cm i 4 cm, koliki je njegov opseg?');

-- 5. Površina paralelograma
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kako računamo površinu paralelograma?', 'a + b@ a × b@ a × h@ a ÷ h', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kako računamo površinu paralelograma?');

-- 6. Dijagonale u paralelogramu
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Što vrijedi za dijagonale paralelograma?', 'Jednake su duljine@ Sijeku se pod pravim kutem@ Prepolavljaju jedna drugu@ Nemaju zajedničku točku', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Što vrijedi za dijagonale paralelograma?');

-- 7. Usporedba s kvadratom
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koja je razlika između kvadrata i općeg paralelograma?', 'Kvadrat nema dijagonale@ Kvadrat ima sve kutove jednake@ Kvadrat nema suprotne stranice jednake@ Kvadrat nije paralelogram', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koja je razlika između kvadrata i općeg paralelograma?');

-- 8. Primjena formule za površinu
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ako je osnovica paralelograma 10 cm, a visina 5 cm, kolika je površina?', '50 cm²@ 15 cm²@ 25 cm²@ 60 cm²', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Ako je osnovica paralelograma 10 cm, a visina 5 cm, kolika je površina?');

-- 9. Prepoznavanje jednakokrakog paralelograma
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji od sljedećih paralelograma ima sve stranice jednake?', 'Romb@ Pravokutnik@ Trapez@ Kvadrat', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji od sljedećih paralelograma ima sve stranice jednake?');

-- 10. Kutevi u paralelogramu
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ako jedan kut paralelograma ima 70°, koliki je njegov suprotni kut?', '70°@ 110°@ 90°@ 180°', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Ako jedan kut paralelograma ima 70°, koliki je njegov suprotni kut?');

-- 11. Zbroj kutova u paralelogramu
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koliki je zbroj svih kutova u paralelogramu?', '360°@ 180°@ 90°@ 720°', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koliki je zbroj svih kutova u paralelogramu?');

-- 12. Primjena opsega
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Paralelogram ima stranice duljine 8 cm i 5 cm. Koliki je opseg?', '26 cm@ 13 cm@ 40 cm@ 16 cm', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Paralelogram ima stranice duljine 8 cm i 5 cm. Koliki je opseg?');

-- 13. Dijagonale romba
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koje je svojstvo dijagonala u rombu?', 'Jednake su duljine@ Ne sijeku se@ Sijeku se pod pravim kutem@ Ne prepolavljaju se', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koje je svojstvo dijagonala u rombu?');

-- 14. Površina kvadrata kao posebnog paralelograma
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Kvadrat je paralelogram čija je površina dana formulom:', 'a × a@ a + a@ a × h@ a² × 2', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Kvadrat je paralelogram čija je površina dana formulom:');

-- 15. Visina u paralelogramu
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Visina u paralelogramu je:', 'Najduža stranica@ Dijagonala@ Okomica spuštena na osnovicu@ Bilo koja stranica', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Visina u paralelogramu je:');

-- 16. Kombinacija površine i opsega
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Ako paralelogram ima površinu 30 cm² i osnovicu 5 cm, kolika je visina?', '3 cm@ 6 cm@ 5 cm@ 7 cm', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Ako paralelogram ima površinu 30 cm² i osnovicu 5 cm, kolika je visina?');

-- 17. Prikaz paralelograma u svakodnevnom životu
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Koji od navedenih predmeta ima oblik paralelograma?', 'Ekran mobitela@ Staklo prozora@ Romboidni znak@ Kružni sat', 2,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Koji od navedenih predmeta ima oblik paralelograma?');

-- 18. Zadatak s riječima
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Paralelogram ima osnovicu 12 cm i visinu 4 cm. Kolika je njegova površina?', '48 cm²@ 16 cm²@ 24 cm²@ 60 cm²', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Paralelogram ima osnovicu 12 cm i visinu 4 cm. Kolika je njegova površina?');

-- 19. Kombinirani zadatak
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Paralelogram ima opseg 40 cm, a jedna stranica je 12 cm. Kolika je druga stranica?', '8 cm@ 14 cm@ 6 cm@ 10 cm', 0,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Paralelogram ima opseg 40 cm, a jedna stranica je 12 cm. Kolika je druga stranica?');

-- 20. Primjena u svakodnevici
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT 'Stolnjak u obliku paralelograma ima duljinu 1,2 m i visinu 0,6 m. Kolika je njegova površina?', '1,8 m²@ 0,72 m²@ 2 m²@ 1 m²', 1,
       (SELECT lection_id FROM public.lection WHERE title = 'Paralelogrami' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM public.task WHERE question_text = 'Stolnjak u obliku paralelograma ima duljinu 1,2 m i visinu 0,6 m. Kolika je njegova površina?');
