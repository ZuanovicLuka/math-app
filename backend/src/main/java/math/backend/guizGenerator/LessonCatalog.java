package math.backend.guizGenerator;

import org.springframework.stereotype.Component;
import java.util.List;

@Component
public class LessonCatalog {
    public List<String> getLessonsFor(String schoolLevel, String grade) {
        if (schoolLevel.equals("Osnovna škola") && grade.equals("1")) {
            return List.of(
                    "Geometrijska tijela",
                    "Geometrijska likovi",
                    "Brojevi do 5",
                    "Zbrajanje i oduzimanje do 5",
                    "Brojevi do 10",
                    "Zbrajanje i oduzimanje do 10",
                    "Brojevi do 20",
                    "Zbrajanje i oduzimanje do 20"
            );
        } else if (schoolLevel.equals("Osnovna škola") && grade.equals("2")) {
            return List.of(
                    "Brojevi do 100",
                    "Zbrajanje i oduzimanje do 100",
                    "Dužina i duljina dužine",
                    "Tablica množenja",
                    "Množenje brojem 10"
            );
        } else if (schoolLevel.equals("Osnovna škola") && grade.equals("3")) {
            return List.of(
                    "Brojevi do 1000",
                    "Zbrajanje i oduzimanje do 1000",
                    "Množenje i dijeljenje do 1000",
                    "Množenje dvoznamenkastoga broja jednoznamenkastim",
                    "Dijeljenje dvoznamenkastoga broja jednoznamenkastim",
                    "Dijeljenje troznamenkastoga broja jednoznamenkastim",
                    "Masa i volumen"
            );
        } else if (schoolLevel.equals("Osnovna škola") && grade.equals("4")) {
            return List.of(
                    "Brojevi do milijun",
                    "Zbrajanje i oduzimanje do milijun",
                    "Množenje i dijeljenje brojeva do milijun",
                    "Mjerne jedinice",
                    "Vrste trokuta",
                    "Pravokutnik i kvadrat",
                    "Kružnica"
            );
        } else if (schoolLevel.equals("Osnovna škola") && grade.equals("5")) {
            return List.of(
                    "Skupovi",
                    "Skup prirodnih brojeva",
                    "Djeljivost prirodnih brojeva",
                    "Skupovi točaka u ravnini",
                    "Razlomci i decimalni brojevi",
                    "Računanje s decimalnim brojevima",
                    "Geometrijski likovi i tijela"
            );
        } else if (schoolLevel.equals("Osnovna škola") && grade.equals("6")) {
            return List.of(
                    "Skup cijelih brojeva",
                    "Kut i trokut",
                    "Potencije baze 10",
                    "Razlomci",
                    "Računanje s razlomcima",
                    "Koordinatni sustav i prikazivanje podataka",
                    "Linearne jednadžbe s jednom nepoznanicom",
                    "Paralelogrami"
            );
        } else if (schoolLevel.equals("Osnovna škola") && grade.equals("7")) {
            return List.of(
                    "Koordinatni sustav",
                    "Proporcionalne i obrnuto proporcionalne veličine",
                    "Postoci i jednostavni kamatni račun",
                    "Vjerojatnost slučajnog događaja",
                    "Sličnost Trokuta",
                    "Mnogokuti",
                    "Kružnica i krug",
                    "Sustav dviju linearnih jednadžbi s dvije nepoznanice",
                    "Linearna funkcija"
            );
        } else if (schoolLevel.equals("Osnovna škola") && grade.equals("8")) {
            return List.of(
                    "Kvadriranje",
                    "Potencije s bazom 10",
                    "Drugi korijen",
                    "Pitagorin poučak",
                    "Realni brojevi",
                    "Prizme",
                    "Piramide",
                    "Valjak, stožac, kugla"
            );
        } else if (schoolLevel.equals("Srednja škola") && grade.equals("1")) {
            return List.of(
                    "Brojevi",
                    "Potencije",
                    "Algebarski izrazi",
                    "Uređaj na skupu realnih brojeva",
                    "Linearna funkcija",
                    "Sustavi jednadžbi",
                    "Sukladnost i sličnost",
                    "Trigonometrija pravokutnog trokuta"
            );
        } else if (schoolLevel.equals("Srednja škola") && grade.equals("2")) {
            return List.of(
                    "Kompleksni brojevi",
                    "Kvadratna jednadžba",
                    "Polinom drugog stupnja",
                    "Eksponencijalna funkcija",
                    "Logaritamska funkcija",
                    "Eksponencijalne i logaritamske jednadžbe i nejednadžbe",
                    "Poliedri",
                    "Rotacijska tijela"
            );
        } else if (schoolLevel.equals("Srednja škola") && grade.equals("3")) {
            return List.of(
                    "Potencije",
                    "Eksponencijalna i logaritamska funkcija",
                    "Trigonometrijske funkcije",
                    "Trigonometrijske jednadžbe",
                    "Vektori",
                    "Pravac",
                    "Kružnica",
                    "Kombinatorika"
            );
        } else if (schoolLevel.equals("Srednja škola") && grade.equals("4")) {
            return List.of(
                    "Kompleksni brojevi",
                    "Nizovi",
                    "Funkcije",
                    "Derivacije",
                    "Primjena derivacija",
                    "Vjerojatnost"
            );
        }

        // prazan popis ako nema definirano
        return List.of();
    }
}