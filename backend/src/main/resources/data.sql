-- 5. razred, 1. lekcija SKUPOVI
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Skupovi', 'Osnovna škola', '5'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Skupovi'
    AND school_level = 'Osnovna škola'
    AND grade = '5'
);

-- Prvi zadatak
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što je skup?',
    'Nepovezane stvari@ Kolekcija različitih objekata@ Matematička operacija@ Vrsta broja',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što je skup?'
    );

-- Drugi zadatak
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako najčešće označavamo skup?',
    'Malim slovima@ Velikim slovima@ Brojevima@ Znakovima',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako najčešće označavamo skup?'
    );

-- Treći zadatak
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što je element skupa?',
    'Naziv skupa@ Jedan član skupa@ Veličina skupa@ Operacija između skupova',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što je element skupa?'
    );

-- Četvrti zadatak
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako zapisujemo da je broj 5 u skupu A?',
    '5 ⊂ A@ 5 ∈ A@ A ∈ 5@ A = 5',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako zapisujemo da je broj 5 u skupu A?'
    );

-- Peti zadatak
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što je prazan skup?',
    'Skup s jednim elementom@ Skup bez elemenata@ Skup svih brojeva@ Skup slova',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što je prazan skup?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako označavamo prazan skup?',
    '{ }@ ∅@ 0@ P',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako označavamo prazan skup?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što je konačan skup?',
    'Skup koji nema kraj@ Skup s beskonačno elemenata@ Skup s određenim brojem elemenata@ Skup bez pravila',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što je konačan skup?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji od ovih je konačan skup?',
    'Skup svih prirodnih brojeva@ Skup svih parnih brojeva@ Skup dana u tjednu@ Skup točaka na pravcu',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji od ovih je konačan skup?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što je podskup?',
    'Veći skup@ Manji skup unutar većeg@ Suprotni skup@ Skup bez elemenata',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što je podskup?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako označavamo da je A podskup od B?',
    'A ⊂ B@ A ∈ B@ B ⊂ A@ A = B',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako označavamo da je A podskup od B?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što je presjek skupova?',
    'Svi elementi iz oba skupa@ Samo zajednički elementi@ Svi osim zajedničkih@ Niti jedan element',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što je presjek skupova?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako označavamo presjek skupova A i B?',
    'A ∪ B@ A ∩ B@ A \ B@ A × B',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako označavamo presjek skupova A i B?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što je unija skupova?',
    'Samo zajednički elementi@ Svi elementi iz oba skupa@ Razlika skupova@ Prazan skup',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što je unija skupova?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako označavamo uniju skupova A i B?',
    'A ∩ B@ A ∪ B@ A \ B@ A ⊂ B',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako označavamo uniju skupova A i B?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što je razlika skupova A \ B?',
    'Elementi koji su u A, ali ne i u B@ Elementi koji su u B, ali ne i u A@ Zajednički elementi@ Svi elementi',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što je razlika skupova A \ B?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji je primjer skupa?',
    'Nasumične riječi@ Svi prirodni brojevi manji od 10@ Bilješke u bilježnici@ Vrijeme',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji je primjer skupa?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što je beskonačan skup?',
    'Skup s 10 elemenata@ Skup koji se ne može prebrojati@ Skup bez elemenata@ Skup slova',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što je beskonačan skup?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji skup je beskonačan?',
    'Skup dana u tjednu@ Skup mjeseci u godini@ Skup prirodnih brojeva@ Skup boja dugine',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji skup je beskonačan?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što je komplement skupa?',
    'Svi elementi skupa@ Elementi koji nisu u skupu@ Unija i presjek@ Prazan skup',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što je komplement skupa?'
    );

INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako označavamo komplement skupa A?',
    'Aᶜ@ A∪@ A∩@ A°',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako označavamo komplement skupa A?'
    );

-- 5. razred, 2. lekcija SKUP PRIRODNIH BROJEVA
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Skup prirodnih brojeva', 'Osnovna škola', '5'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Skup prirodnih brojeva'
    AND school_level = 'Osnovna škola'
    AND grade = '5'
);

-- Prvi zadatak - Presjek i unija skupova
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako je A = {1, 2, 3} i B = {2, 3, 4}, koliki je A ∩ B?',
    '{1, 2, 3, 4}@ {2, 3}@ {1, 4}@ { }',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako je A = {1, 2, 3} i B = {2, 3, 4}, koliki je A ∩ B?'
    );

-- Drugi zadatak - Presjek i unija skupova
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako je A = {1, 2, 3} i B = {2, 3, 4}, koliki je A ∪ B?',
    '{1, 2, 3, 4}@ {2, 3}@ {1, 4}@ { }',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako je A = {1, 2, 3} i B = {2, 3, 4}, koliki je A ∪ B?'
    );

-- Treći zadatak - Skup N0
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što označava N₀?',
    'Samo prirodni brojevi@ Prirodni brojevi s nulom@ Cijeli brojevi@ Racionalni brojevi',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što označava N₀?'
    );

-- Četvrti zadatak - Skup N0
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji broj nije u skupu N₀?',
    '0@ 1@ -1@ 10',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji broj nije u skupu N₀?'
    );

-- Peti zadatak - Brojevni pravac
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako se zove crta na kojoj su prikazani brojevi?',
    'Brojevni krug@ Brojevni pravac@ Brojevna mreža@ Brojevna spirala',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako se zove crta na kojoj su prikazani brojevi?'
    );

-- Šesti zadatak - Uspoređivanje u N0
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji je odnos između 5 i 7?',
    '5 > 7@ 5 = 7@ 5 < 7@ 5 ≥ 7',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji je odnos između 5 i 7?'
    );

-- Sedmi zadatak - Zaokruživanje u skupu N0
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako zaokružiti 47 na najbližu deseticu?',
    '40@ 45@ 50@ 47',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako zaokružiti 47 na najbližu deseticu?'
    );

-- Osmi zadatak - Zbrajanje i oduzimanje u N0 (svojstva)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koje svojstvo opisuje: a + b = b + a?',
    'Asocijativnost@ Komutativnost@ Distributivnost@ Neutralni element',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koje svojstvo opisuje: a + b = b + a?'
    );

-- Deveti zadatak - Zbrajanje i oduzimanje u N0 (problemski)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako Marko ima 15 kuna, a potroši 7 kuna, koliko mu je ostalo?',
    '7 kuna@ 8 kuna@ 15 kuna@ 22 kune',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako Marko ima 15 kuna, a potroši 7 kuna, koliko mu je ostalo?'
    );

-- Deseti zadatak - Zbrajanje i oduzimanje u N0 (jednadžbe)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Riješi jednadžbu: x + 5 = 12',
    'x = 5@ x = 7@ x = 12@ x = 17',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Riješi jednadžbu: x + 5 = 12'
    );

-- Jedanaesti zadatak - Množenje i dijeljenje u N0 (svojstva)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koje svojstvo opisuje: a × (b + c) = a×b + a×c?',
    'Asocijativnost@ Komutativnost@ Distributivnost@ Neutralni element',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koje svojstvo opisuje: a × (b + c) = a×b + a×c?'
    );

-- Dvanaesti zadatak - Množenje i dijeljenje u N0 (problemski)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako jedna kutija sadrži 6 bombona, koliko bombona ima u 4 kutije?',
    '6 bombona@ 10 bombona@ 24 bombona@ 46 bombona',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako jedna kutija sadrži 6 bombona, koliko bombona ima u 4 kutije?'
    );

-- Trinaesti zadatak - Množenje i dijeljenje u N0 (jednadžbe)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Riješi jednadžbu: x × 3 = 15',
    'x = 3@ x = 5@ x = 12@ x = 18',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Riješi jednadžbu: x × 3 = 15'
    );

-- Četrnaesti zadatak - Neutralni element
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji je neutralni element za zbrajanje?',
    '0@ 1@ 10@ Ne postoji',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji je neutralni element za zbrajanje?'
    );

-- Petnaesti zadatak - Neutralni element
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji je neutralni element za množenje?',
    '0@ 1@ 10@ Ne postoji',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji je neutralni element za množenje?'
    );

-- Šesnaesti zadatak - Brojevni pravac
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koja je točka na brojevnom pravcu između 2 i 4?',
    '1@ 3@ 5@ 6',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koja je točka na brojevnom pravcu između 2 i 4?'
    );

-- Sedamnaesti zadatak - Zaokruživanje
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako zaokružiti 23 na najbližu deseticu?',
    '20@ 23@ 25@ 30',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako zaokružiti 23 na najbližu deseticu?'
    );

-- Osamnaesti zadatak - Problemski zadatak
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako Ana ima 25 kuna, a Ivan 18 kuna, koliko više novaca ima Ana?',
    '7 kuna@ 18 kuna@ 25 kuna@ 43 kune',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako Ana ima 25 kuna, a Ivan 18 kuna, koliko više novaca ima Ana?'
    );

-- Devetnaesti zadatak - Problemski zadatak
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako u razredu ima 24 učenika podijeljenih u 3 jednake grupe, koliko učenika je u svakoj grupi?',
    '6 učenika@ 8 učenika@ 12 učenika@ 24 učenika',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako u razredu ima 24 učenika podijeljenih u 3 jednake grupe, koliko učenika je u svakoj grupi?'
    );

-- Dvadeseti zadatak - Jednadžbe
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Riješi jednadžbu: x - 8 = 12',
    'x = 4@ x = 8@ x = 12@ x = 20',
    3,
    (SELECT lection_id FROM public.lection WHERE title = 'Skup prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Riješi jednadžbu: x - 8 = 12'
    );


-- 5. razred, 3. lekcija DJELJIVOST PRIRODNIH BROJEVA
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Djeljivost prirodnih brojeva', 'Osnovna škola', '5'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Djeljivost prirodnih brojeva'
    AND school_level = 'Osnovna škola'
    AND grade = '5'
);

-- 1. Višekratnik
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji je od sljedećih brojeva višekratnik broja 4?',
    '5@ 6@ 8@ 10',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji je od sljedećih brojeva višekratnik broja 4?'
    );

-- 2. Višekratnik
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji je najmanji višekratnik brojeva 3 i 5?',
    '5@ 8@ 15@ 30',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji je najmanji višekratnik brojeva 3 i 5?'
    );

-- 3. Djeljitelj
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji je od sljedećih brojeva djeljitelj broja 12?',
    '5@ 7@ 8@ 6',
    3,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji je od sljedećih brojeva djeljitelj broja 12?'
    );

-- 4. Djeljitelj
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko djeljitelja ima prost broj?',
    '1@ 2@ 3@ 4',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko djeljitelja ima prost broj?'
    );

-- 5. Pravila djeljivosti (s 2)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji broj je djeljiv s 2?',
    '23@ 35@ 48@ 51',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji broj je djeljiv s 2?'
    );

-- 6. Pravila djeljivosti (s 3)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji broj je djeljiv s 3?',
    '44@ 55@ 66@ 77',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji broj je djeljiv s 3?'
    );

-- 7. Pravila djeljivosti (s 5)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji broj je djeljiv s 5?',
    '32@ 43@ 54@ 70',
    3,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji broj je djeljiv s 5?'
    );

-- 8. Pravila djeljivosti (s 10)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji broj je djeljiv s 10?',
    '105@ 120@ 133@ 148',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji broj je djeljiv s 10?'
    );

-- 9. Prosti brojevi
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji od sljedećih brojeva je prost?',
    '9@ 11@ 15@ 21',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji od sljedećih brojeva je prost?'
    );

-- 10. Složeni brojevi
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji od sljedećih brojeva je složen?',
    '2@ 3@ 4@ 5',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji od sljedećih brojeva je složen?'
    );

-- 11. Rastavljanje na proste faktore
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako glasi rastav broja 12 na proste faktore?',
    '2×2×3@ 3×4@ 2×6@ 1×12',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako glasi rastav broja 12 na proste faktore?'
    );

-- 12. Rastavljanje na proste faktore
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako glasi rastav broja 30 na proste faktore?',
    '2×3×5@ 5×6@ 2×15@ 1×30',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako glasi rastav broja 30 na proste faktore?'
    );

-- 13. Najveći zajednički djeljitelj (NZD)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliki je NZD brojeva 12 i 18?',
    '2@ 3@ 6@ 12',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliki je NZD brojeva 12 i 18?'
    );

-- 14. Najmanji zajednički višekratnik (NZV)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliki je NZV brojeva 4 i 6?',
    '2@ 6@ 12@ 24',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliki je NZV brojeva 4 i 6?'
    );

-- 15. Pravila djeljivosti (kombinirano)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji broj je djeljiv i s 2 i s 3?',
    '14@ 16@ 18@ 20',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji broj je djeljiv i s 2 i s 3?'
    );

-- 16. Prosti brojevi (problemi)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko prostih brojeva postoji između 10 i 20?',
    '2@ 3@ 4@ 5',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko prostih brojeva postoji između 10 i 20?'
    );

-- 17. Djeljivost (problemski)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako pakiranje sadrži 24 čokolade i želimo ih podijeliti na jednake dijelove, koliko mogućih brojeva djece (većih od 1) može dobiti jednak broj čokolada?',
    '6@ 7@ 8@ 9',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako pakiranje sadrži 24 čokolade i želimo ih podijeliti na jednake dijelove, koliko mogućih brojeva djece (većih od 1) može dobiti jednak broj čokolada?'
    );

-- 18. NZD (problemski)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Marko ima 12 jabuka, a Ana 18 jabuka. Koliki je najveći broj jednakih košarica koje mogu napraviti da imaju jednak broj jabuka u svakoj?',
    '3@ 4@ 6@ 9',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Marko ima 12 jabuka, a Ana 18 jabuka. Koliki je najveći broj jednakih košarica koje mogu napraviti da imaju jednak broj jabuka u svakoj?'
    );

-- 19. NZV (problemski)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Autobus A vozi svakih 12 minuta, autobus B svakih 18 minuta. Nakon koliko će minuta opet krenuti istovremeno?',
    '18 minuta@ 24 minute@ 36 minuta@ 72 minute',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Autobus A vozi svakih 12 minuta, autobus B svakih 18 minuta. Nakon koliko će minuta opet krenuti istovremeno?'
    );

-- 20. Rastavljanje na proste faktore (teži)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako glasi rastav broja 84 na proste faktore?',
    '2×2×3×7@ 3×4×7@ 2×6×7@ 2×3×14',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Djeljivost prirodnih brojeva' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako glasi rastav broja 84 na proste faktore?'
    );

-- 5. razred, 4. lekcija SKUPOVI TOČAKA U RAVNINI
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Skupovi točaka u ravnini', 'Osnovna škola', '5'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Skupovi točaka u ravnini'
    AND school_level = 'Osnovna škola'
    AND grade = '5'
);

-- 1. Simetrala dužine
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što je simetrala dužine?',
    'Pravac koji je paralelan s dužinom@ Pravac koji dijeli dužinu na dva jednaka dijela@ Pravac koji je okomit na dužinu@ Pravac koji prolazi samo jednim krajem dužine',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što je simetrala dužine?'
    );

-- 2. Simetrala dužine (svojstva)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koje svojstvo ima simetrala dužine?',
    'Prolazi kroz jednu točku dužine@ Dijeli dužinu na dva nejednaka dijela@ Sjecište simetrale i dužine je polovište dužine@ Nije okomita na dužinu',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koje svojstvo ima simetrala dužine?'
    );

-- 3. Susjedni kutovi
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što su susjedni kutovi?',
    'Kutovi koji imaju zajednički vrh i jednu zajedničku krak@ Kutovi koji su jednaki@ Kutovi čiji je zbroj 180°@ Kutovi koji nemaju zajedničkih karaka',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što su susjedni kutovi?'
    );

-- 4. Vrsni kutovi
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što su vrsni kutovi?',
    'Kutovi koji imaju zajednički vrh@ Kutovi nastali presjekom dvaju pravaca i suprotni su@ Kutovi čiji je zbroj 90°@ Kutovi koji su susjedni',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što su vrsni kutovi?'
    );

-- 5. Trokut
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko stranica ima trokut?',
    '2@ 3@ 4@ 5',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko stranica ima trokut?'
    );

-- 6. Trokut (vrste)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako se zove trokut kojemu su sve stranice jednake?',
    'Jednakokračan@ Jednakostraničan@ Pravokutan@ Tupokutan',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako se zove trokut kojemu su sve stranice jednake?'
    );

-- 7. Pravokutnik
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koje svojstvo ima pravokutnik?',
    'Sve stranice su mu jednake@ Susjedne stranice su mu okomite@ Nema prave kutove@ Dijagonale su mu nejednake',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koje svojstvo ima pravokutnik?'
    );

-- 8. Kvadrat
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako se zove četverokut kojemu su sve stranice jednake i svi kutovi pravi?',
    'Pravokutnik@ Romb@ Trapez@ Kvadrat',
    3,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako se zove četverokut kojemu su sve stranice jednake i svi kutovi pravi?'
    );

-- 9. Krug i kružnica
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što je kružnica?',
    'Skup svih točaka u ravnini jednako udaljenih od središta@ Dio kruga@ Unutrašnjost kruga@ Samo rub kruga',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što je kružnica?'
    );

-- 10. Krug i kružnica (elementi)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako se zove dužina koja spaja središte kružnice s bilo kojom točkom na kružnici?',
    'Promjer@ Tetiva@ Polumjer@ Luk',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako se zove dužina koja spaja središte kružnice s bilo kojom točkom na kružnici?'
    );

-- 11. Simetrala dužine (konstrukcija)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što je potrebno za konstrukciju simetrale dužine?',
    'Kutomjer i ravnalo@ Šestar i ravnalo@ Samo kutomjer@ Samo ravnalo',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što je potrebno za konstrukciju simetrale dužine?'
    );

-- 12. Susjedni kutovi (svojstva)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliki je zbroj susjednih kutova?',
    '90°@ 180°@ 270°@ 360°',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliki je zbroj susjednih kutova?'
    );

-- 13. Vrsni kutovi (svojstva)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koje svojstvo imaju vrsni kutovi?',
    'Zbroj im je 180°@ Međusobno su jednaki@ Zbroj im je 90°@ Nemaju zajednički vrh',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koje svojstvo imaju vrsni kutovi?'
    );

-- 14. Trokut (kutovi)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliki je zbroj kutova u trokutu?',
    '90°@ 180°@ 270°@ 360°',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliki je zbroj kutova u trokutu?'
    );

-- 15. Pravokutnik (dijagonale)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koje svojstvo imaju dijagonale pravokutnika?',
    'Jednake su i raspolavljaju se@ Nejendake su@ Okomite su@ Paralelne su',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koje svojstvo imaju dijagonale pravokutnika?'
    );

-- 16. Kvadrat (svojstva)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koje svojstvo nema kvadrat?',
    'Sve stranice su jednake@ Svi kutovi su pravi@ Dijagonale su mu nejednake@ Dijagonale se raspolavljaju',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koje svojstvo nema kvadrat?'
    );

-- 17. Krug i kružnica (promjer)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko polumjera čini promjer kružnice?',
    '1@ 2@ 3@ 4',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko polumjera čini promjer kružnice?'
    );

-- 18. Konstrukcije (trokut)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što je dovoljno za konstrukciju trokuta?',
    'Duljine dviju stranica@ Duljine sve tri stranice@ Samo jedan kut@ Samo dva kuta',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što je dovoljno za konstrukciju trokuta?'
    );

-- 19. Kutovi (problemski)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako su dva kuta susjedna i jedan je 45°, koliki je drugi?',
    '45°@ 90°@ 135°@ 180°',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako su dva kuta susjedna i jedan je 45°, koliki je drugi?'
    );

-- 20. Geometrijski likovi (prepoznavanje)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji lik ima sve stranice jednake, sve kutove prave, a dijagonale mu se raspolavljaju?',
    'Pravokutnik@ Romb@ Trapez@ Kvadrat',
    3,
    (SELECT lection_id FROM public.lection WHERE title = 'Skupovi točaka u ravnini' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji lik ima sve stranice jednake, sve kutove prave, a dijagonale mu se raspolavljaju?'
    );

-- 5. razred, 5. lekcija RAZLOMCI I DECIMALNI BROJEVI
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Razlomci i decimalni brojevi', 'Osnovna škola', '5'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Razlomci i decimalni brojevi'
    AND school_level = 'Osnovna škola'
    AND grade = '5'
);

-- 1. Pojam razlomka
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Što prikazuje nazivnik razlomka?',
    'Na koliko dijelova cijela stvar podijeljena@ Koliko dijelova uzimamo@ Vrijednost razlomka@ Zbroj dijelova',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Što prikazuje nazivnik razlomka?'
    );

-- 2. Prikazivanje razlomaka
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako glasi razlomak za osjenčani dio ako je cijeli krug podijeljen na 8 jednakih dijelova, a osjenčano je 3 dijela?',
    '5/8@ 3/8@ 8/3@ 3/5',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako glasi razlomak za osjenčani dio ako je cijeli krug podijeljen na 8 jednakih dijelova, a osjenčano je 3 dijela?'
    );

-- 3. Razlomci na brojevnom pravcu
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Gdje se na brojevnom pravcu nalazi točka 1/2?',
    'Između 0 i 1@ Između 1 i 2@ Između 2 i 3@ Na 0',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Gdje se na brojevnom pravcu nalazi točka 1/2?'
    );

-- 4. Nepravi razlomci
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji od navedenih je nepravi razlomak?',
    '1/2@ 3/4@ 5/4@ 2/3',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji od navedenih je nepravi razlomak?'
    );

-- 5. Mješoviti brojevi
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako glasi mješoviti broj za razlomak 7/3?',
    '3 1/3@ 2 1/3@ 7 3/1@ 1 3/7',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako glasi mješoviti broj za razlomak 7/3?'
    );

-- 6. Pretvaranje u decimalni broj
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako glasi decimalni zapis za razlomak 1/4?',
    '0.1@ 0.25@ 0.5@ 0.75',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako glasi decimalni zapis za razlomak 1/4?'
    );

-- 7. Decimalni brojevi na brojevnom pravcu
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Gdje se na brojevnom pravcu nalazi 1.5?',
    'Između 0 i 1@ Između 1 i 2@ Točno na 1@ Točno na 2',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Gdje se na brojevnom pravcu nalazi 1.5?'
    );

-- 8. Uspoređivanje decimalnih brojeva
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji je broj veći: 0.35 ili 0.4?',
    '0.35@ 0.4@ Jednaki su@ Ne može se odrediti',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji je broj veći: 0.35 ili 0.4?'
    );

-- 9. Zaokruživanje decimalnih brojeva
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako zaokružiti 3.78 na jednu decimalu?',
    '3.7@ 3.8@ 3.0@ 4.0',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako zaokružiti 3.78 na jednu decimalu?'
    );

-- 10. Pretvaranje decimalnog u razlomak
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako glasi razlomak za 0.6?',
    '1/6@ 3/5@ 6/1@ 6/10',
    3,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako glasi razlomak za 0.6?'
    );

-- 11. Ekvivalentni razlomci
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji je razlomak ekvivalentan s 2/3?',
    '4/6@ 3/2@ 1/3@ 2/6',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji je razlomak ekvivalentan s 2/3?'
    );

-- 12. Skraćivanje razlomaka
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako glasi skraćeni oblik razlomka 8/12?',
    '4/6@ 2/3@ 1/2@ 8/12',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako glasi skraćeni oblik razlomka 8/12?'
    );

-- 13. Uspoređivanje razlomaka
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koji je razlomak veći: 3/4 ili 2/3?',
    '3/4@ 2/3@ Jednaki su@ Ovisi o situaciji',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koji je razlomak veći: 3/4 ili 2/3?'
    );

-- 14. Zbrajanje razlomaka
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 1/2 + 1/4?',
    '1/6@ 2/6@ 3/4@ 5/4',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 1/2 + 1/4?'
    );

-- 15. Oduzimanje razlomaka
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 3/4 - 1/4?',
    '1/4@ 1/2@ 2/4@ 2/0',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 3/4 - 1/4?'
    );

-- 16. Uspoređivanje decimala (teže)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Poredaj brojeve od najmanjeg do najvećeg: 0.3, 0.29, 0.305',
    '0.29, 0.3, 0.305@ 0.3, 0.29, 0.305@ 0.305, 0.3, 0.29@ 0.29, 0.305, 0.3',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Poredaj brojeve od najmanjeg do najvećeg: 0.3, 0.29, 0.305'
    );

-- 17. Zaokruživanje na cijele brojeve
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako zaokružiti 4.67 na cijeli broj?',
    '4@ 4.6@ 5@ 4.7',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako zaokružiti 4.67 na cijeli broj?'
    );

-- 18. Problemski zadatak (razlomci)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako Ana poje 1/4 pizze, a Marko 1/3 pizze, koliko pizze su pojeli zajedno?',
    '1/7@ 2/7@ 7/12@ 1/12',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako Ana poje 1/4 pizze, a Marko 1/3 pizze, koliko pizze su pojeli zajedno?'
    );

-- 19. Problemski zadatak (decimalni)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako je cijena robe 12.99 kn, koliko će koštati zaokruženo na najbližu kunu?',
    '12 kn@ 13 kn@ 12.9 kn@ 13.0 kn',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako je cijena robe 12.99 kn, koliko će koštati zaokruženo na najbližu kunu?'
    );

-- 20. Mješoviti brojevi (pretvaranje)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kako glasi nepravi razlomak za 2 1/2?',
    '3/2@ 5/2@ 1/2@ 2/2',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Razlomci i decimalni brojevi' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kako glasi nepravi razlomak za 2 1/2?'
    );

-- 5. razred, 6. lekcija RAČUNANJE S DECIMALNIM BROJEVIMA
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Računanje s decimalnim brojevima', 'Osnovna škola', '5'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Računanje s decimalnim brojevima'
    AND school_level = 'Osnovna škola'
    AND grade = '5'
);

-- 1. Zbrajanje decimalnih brojeva
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 2.5 + 1.3?',
    '3.8@ 3.6@ 3.2@ 3.0',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 2.5 + 1.3?'
    );

-- 2. Oduzimanje decimalnih brojeva
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 5.7 - 2.4?',
    '3.3@ 3.5@ 3.7@ 2.3',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 5.7 - 2.4?'
    );

-- 3. Množenje decimalnih brojeva
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 0.5 × 4?',
    '0.2@ 2.0@ 20@ 0.02',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 0.5 × 4?'
    );

-- 4. Dijeljenje decimalnog broja prirodnim brojem
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 6.4 ÷ 2?',
    '3.2@ 3.0@ 3.4@ 2.4',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 6.4 ÷ 2?'
    );

-- 5. Dijeljenje decimalnog broja decimalnim brojem
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 1.5 ÷ 0.5?',
    '0.3@ 3@ 30@ 0.03',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 1.5 ÷ 0.5?'
    );

-- 6. Algebarski izrazi
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 3x + 2x ako je x = 0.5?',
    '1.5@ 2.0@ 2.5@ 3.0',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 3x + 2x ako je x = 0.5?'
    );

-- 7. Linearne jednadžbe
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Riješi jednadžbu: x + 2.5 = 4',
    '1.5@ 2.5@ 6.5@ 1.0',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Riješi jednadžbu: x + 2.5 = 4'
    );

-- 8. Problemski zadatak (zbrajanje)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ana je kupila 1.5 kg jabuka i 2.3 kg krušaka. Koliko voća je kupila ukupno?',
    '3.8 kg@ 3.6 kg@ 3.2 kg@ 4.0 kg',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ana je kupila 1.5 kg jabuka i 2.3 kg krušaka. Koliko voća je kupila ukupno?'
    );

-- 9. Problemski zadatak (oduzimanje)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Marko je imao 10.5 kn, potrošio je 3.8 kn. Koliko mu je novca ostalo?',
    '6.7 kn@ 6.5 kn@ 7.3 kn@ 7.7 kn',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Marko je imao 10.5 kn, potrošio je 3.8 kn. Koliko mu je novca ostalo?'
    );

-- 10. Problemski zadatak (množenje)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako je cijena jednog soka 4.5 kn, koliko koštaju 3 soka?',
    '12.5 kn@ 13.5 kn@ 12.0 kn@ 13.0 kn',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako je cijena jednog soka 4.5 kn, koliko koštaju 3 soka?'
    );

-- 11. Problemski zadatak (dijeljenje)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako je 6.3 m užeta podijeljeno na 3 jednaka dijela, koliko je dug svaki dio?',
    '2.1 m@ 2.3 m@ 1.9 m@ 2.5 m',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako je 6.3 m užeta podijeljeno na 3 jednaka dijela, koliko je dug svaki dio?'
    );

-- 12. Algebarski izrazi (složeniji)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 2x + 3y ako je x = 1.2 i y = 0.8?',
    '4.0@ 4.8@ 5.2@ 5.6',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 2x + 3y ako je x = 1.2 i y = 0.8?'
    );

-- 13. Linearne jednadžbe (s decimalima)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Riješi jednadžbu: 2x - 1.5 = 2.5',
    'x = 1@ x = 1.5@ x = 2@ x = 2.5',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Riješi jednadžbu: 2x - 1.5 = 2.5'
    );

-- 14. Zbrajanje (više decimala)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 3.25 + 1.75 + 0.5?',
    '5.0@ 5.5@ 6.0@ 6.5',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 3.25 + 1.75 + 0.5?'
    );

-- 15. Oduzimanje (više decimala)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 10.00 - 2.35 - 3.15?',
    '4.5@ 4.6@ 5.0@ 5.5',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 10.00 - 2.35 - 3.15?'
    );

-- 16. Množenje (više decimala)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 1.5 × 2.5?',
    '3.0@ 3.5@ 3.75@ 4.0',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 1.5 × 2.5?'
    );

-- 17. Dijeljenje (više decimala)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 4.8 ÷ 1.2?',
    '3@ 4@ 5@ 6',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 4.8 ÷ 1.2?'
    );

-- 18. Algebarski izrazi (s zagradama)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 2(x + 1.5) ako je x = 0.5?',
    '3@ 4@ 5@ 6',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 2(x + 1.5) ako je x = 0.5?'
    );

-- 19. Linearne jednadžbe (s decimalima)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Riješi jednadžbu: 0.5x + 1 = 2.5',
    'x = 1@ x = 2@ x = 3@ x = 4',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Riješi jednadžbu: 0.5x + 1 = 2.5'
    );

-- 20. Problemski zadatak (kombinirano)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako je cijena knjige 45.99 kn, a popust je 15%, koliko košta knjiga nakon popusta? (zaokruženo na najbližu kunu)',
    '38 kn@ 39 kn@ 40 kn@ 41 kn',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Računanje s decimalnim brojevima' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako je cijena knjige 45.99 kn, a popust je 15%, koliko košta knjiga nakon popusta? (zaokruženo na najbližu kunu)'
    );

-- 5. razred, 7. lekcija GEOMETRIJSKI LIKOVI I TIJELA
INSERT INTO public.lection (title, school_level, grade)
SELECT 'Geometrijski likovi i tijela', 'Osnovna škola', '5'
    WHERE NOT EXISTS (
    SELECT 1 FROM public.lection
    WHERE title = 'Geometrijski likovi i tijela'
    AND school_level = 'Osnovna škola'
    AND grade = '5'
);

-- 1. Pretvaranje mjernih jedinica (duljina)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je centimetara u 3.5 metra?',
    '35 cm@ 350 cm@ 3500 cm@ 0.35 cm',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je centimetara u 3.5 metra?'
    );

-- 2. Pretvaranje mjernih jedinica (masa)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je grama u 2.3 kilograma?',
    '23 g@ 230 g@ 2300 g@ 23000 g',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je grama u 2.3 kilograma?'
    );

-- 3. Opseg kvadrata
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliki je opseg kvadrata sa stranicom 5 cm?',
    '10 cm@ 15 cm@ 20 cm@ 25 cm',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliki je opseg kvadrata sa stranicom 5 cm?'
    );

-- 4. Opseg pravokutnika
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliki je opseg pravokutnika sa stranicama 6 cm i 4 cm?',
    '10 cm@ 20 cm@ 24 cm@ 36 cm',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliki je opseg pravokutnika sa stranicama 6 cm i 4 cm?'
    );

-- 5. Opseg trokuta
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliki je opseg trokuta sa stranicama 5 cm, 7 cm i 9 cm?',
    '15 cm@ 21 cm@ 25 cm@ 35 cm',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliki je opseg trokuta sa stranicama 5 cm, 7 cm i 9 cm?'
    );

-- 6. Površina kvadrata
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kolika je površina kvadrata sa stranicom 6 cm?',
    '12 cm²@ 24 cm²@ 36 cm²@ 48 cm²',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kolika je površina kvadrata sa stranicom 6 cm?'
    );

-- 7. Površina pravokutnika
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kolika je površina pravokutnika sa stranicama 8 cm i 5 cm?',
    '13 cm²@ 26 cm²@ 40 cm²@ 80 cm²',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kolika je površina pravokutnika sa stranicama 8 cm i 5 cm?'
    );

-- 8. Volumen kocke
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliki je volumen kocke s bridom 3 cm?',
    '9 cm³@ 18 cm³@ 27 cm³@ 36 cm³',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliki je volumen kocke s bridom 3 cm?'
    );

-- 9. Volumen kvadra
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliki je volumen kvadra s dimenzijama 4 cm, 5 cm i 6 cm?',
    '15 cm³@ 60 cm³@ 120 cm³@ 240 cm³',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliki je volumen kvadra s dimenzijama 4 cm, 5 cm i 6 cm?'
    );

-- 10. Pretvaranje jedinica (površina)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je kvadratnih centimetara u 1 m²?',
    '10 cm²@ 100 cm²@ 1000 cm²@ 10000 cm²',
    3,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je kvadratnih centimetara u 1 m²?'
    );

-- 11. Problemski zadatak (opseg)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako je opseg kvadrata 24 cm, kolika je duljina njegove stranice?',
    '4 cm@ 6 cm@ 8 cm@ 12 cm',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako je opseg kvadrata 24 cm, kolika je duljina njegove stranice?'
    );

-- 12. Problemski zadatak (površina)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kolika je površina pravokutnika ako su mu stranice 12 cm i 0.5 m?',
    '60 cm²@ 120 cm²@ 600 cm²@ 1200 cm²',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kolika je površina pravokutnika ako su mu stranice 12 cm i 0.5 m?'
    );

-- 13. Problemski zadatak (volumen)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako je volumen kocke 64 cm³, koliki je njen brid?',
    '2 cm@ 4 cm@ 6 cm@ 8 cm',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako je volumen kocke 64 cm³, koliki je njen brid?'
    );

-- 14. Pretvaranje jedinica (volumen)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je cm³ u 1 dm³?',
    '10 cm³@ 100 cm³@ 1000 cm³@ 10000 cm³',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je cm³ u 1 dm³?'
    );

-- 15. Problemski zadatak (kombinirano)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko kocki brida 2 cm stane u kutiju oblika kvadra dimenzija 10 cm × 8 cm × 6 cm?',
    '30@ 60@ 90@ 120',
    1,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko kocki brida 2 cm stane u kutiju oblika kvadra dimenzija 10 cm × 8 cm × 6 cm?'
    );

-- 16. Površina (problemski)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Ako je površina kvadrata 49 cm², koliki je njegov opseg?',
    '7 cm@ 14 cm@ 21 cm@ 28 cm',
    3,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Ako je površina kvadrata 49 cm², koliki je njegov opseg?'
    );

-- 17. Volumen (problemski)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Kolika je visina kvadra ako mu je volumen 120 cm³, duljina 10 cm i širina 3 cm?',
    '4 cm@ 5 cm@ 6 cm@ 8 cm',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Kolika je visina kvadra ako mu je volumen 120 cm³, duljina 10 cm i širina 3 cm?'
    );

-- 18. Pretvaranje jedinica (složeno)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliko je 2.5 m² u cm²?',
    '250 cm²@ 2500 cm²@ 25000 cm²@ 250000 cm²',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliko je 2.5 m² u cm²?'
    );

-- 19. Opseg (složeni lik)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliki je opseg lika sastavljenog od kvadrata stranice 4 cm i jednakostraničnog trokuta stranice 5 cm spojenih zajedničkom stranicom?',
    '21 cm@ 22 cm@ 23 cm@ 24 cm',
    0,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliki je opseg lika sastavljenog od kvadrata stranice 4 cm i jednakostraničnog trokuta stranice 5 cm spojenih zajedničkom stranicom?'
    );

-- 20. Volumen (složeno)
INSERT INTO public.task (question_text, options, correct_answer_index, lection_id)
SELECT
    'Koliki je ukupni volumen dvije kocke, jedna s bridom 3 cm i druga s bridom 4 cm?',
    '27 cm³@ 64 cm³@ 91 cm³@ 125 cm³',
    2,
    (SELECT lection_id FROM public.lection WHERE title = 'Geometrijski likovi i tijela' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.task
    WHERE question_text = 'Koliki je ukupni volumen dvije kocke, jedna s bridom 3 cm i druga s bridom 4 cm?'
    );