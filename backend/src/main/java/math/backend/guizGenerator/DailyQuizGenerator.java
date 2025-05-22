package math.backend.guizGenerator;

import math.backend.model.Quiz;
import math.backend.model.QuizQuestion;
import math.backend.repository.QuizRepository;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDate;
import java.util.List;

@Component
public class DailyQuizGenerator {
    private final QuizRepository quizRepository;

    public DailyQuizGenerator(QuizRepository quizRepository) {
        this.quizRepository = quizRepository;
    }

    @Scheduled(cron = "0 0 0 * * ?") // Pokreće se u ponoć svaki dan
    @Transactional
    public void generateDailyQuizzes() {
        LocalDate today = LocalDate.now();

        // Generiraj kviz za osnovnu školu
        generateQuizForLevel(today, "Osnovna škola");

        // Generiraj kviz za srednju školu
        generateQuizForLevel(today, "Srednja škola");
    }

    private void generateQuizForLevel(LocalDate date, String schoolLevel) {
        if (quizRepository.findByQuizDateAndSchoolLevel(date, schoolLevel).isPresent()) {
            return; // Kviz već postoji
        }

        Quiz quiz = new Quiz();
        quiz.setQuizDate(date);
        quiz.setSchoolLevel(schoolLevel);

        List<QuizQuestion> questions = generateQuestionsForLevel(schoolLevel);
        questions.forEach(q -> q.setQuiz(quiz));
        quiz.setQuestions(questions);

        quizRepository.save(quiz);
    }

    private List<QuizQuestion> generateQuestionsForLevel(String schoolLevel) {
        // Sada koristimo stringove sa opcijama odvojenim zarezom
        return List.of(
                createQuestion("Koliko je 5 + 7?", "11,12,13,14", 1),
                createQuestion("Koliko je 9 × 6?", "45,54,63,72", 1),
                createQuestion("Koliko je 24 ÷ 8?", "2,3,4,6", 1),
                createQuestion("Koji je rezultat operacije 15 - 8?", "5,6,7,8", 2),
                createQuestion("Koliko je 3 × 4 + 5?", "17,19,21,23", 0),
                createQuestion("Koji je rezultat operacije 56 ÷ 7?", "6,7,8,9", 2),
                createQuestion("Koliko je 3/4 od 100?", "25,50,75,100", 2),
                createQuestion("Koliko je 0.5 × 10?", "0.05,0.5,5,50", 2),
                createQuestion("Koji je rezultat operacije 7²?", "14,28,49,56", 2),
                createQuestion("Koliko je 1/2 + 1/4?", "1/6,1/4,3/4,1/8", 2),
                createQuestion("Koliko je 100 - 35?", "55,65,75,85", 1),
                createQuestion("Koji je rezultat operacije 12 × 5?", "50,55,60,65", 2),
                createQuestion("Koliko je 3 + 4 × 2?", "10,11,14,20", 1),
                createQuestion("Koliko je 1 sat i 15 minuta u minutama?", "60,75,90,115", 1),
                createQuestion("Koji je rezultat operacije 8 × 7 - 10?", "36,46,56,66", 1),
                createQuestion("Koliko je 25% od 200?", "25,50,75,100", 1),
                createQuestion("Koji je rezultat operacije 144 ÷ 12?", "10,11,12,13", 2),
                createQuestion("Koliko je 5 × (3 + 2)?", "10,15,20,25", 3),
                createQuestion("Koji je rezultat operacije 3.5 + 2.5?", "5,5.5,6,6.5", 2),
                createQuestion("Koliko je 1 km u metrima?", "10,100,1000,10000", 2)
        );
    }

    private QuizQuestion createQuestion(String text, String options, int correctAnswerIndex) {
        QuizQuestion question = new QuizQuestion();
        question.setText(text);
        question.setOptions(options); // Ovdje se direktno postavlja string sa opcijama
        question.setCorrectAnswerIndex(correctAnswerIndex);
        return question;
    }
}