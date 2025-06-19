package math.backend.guizGenerator;

import math.backend.model.Quiz;
import math.backend.model.QuizQuestion;
import math.backend.repository.QuizRepository;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

@Component
public class DailyQuizGenerator {
    private final QuizRepository quizRepository;
    private final OpenAIService openAIService;

    public DailyQuizGenerator(QuizRepository quizRepository, OpenAIService openAIService) {
        this.quizRepository = quizRepository;
        this.openAIService = openAIService;
    }

    @Transactional
    public void generateDailyQuizzes() {
        LocalDate today = LocalDate.now();

        // Generiraj kvizove za osnovnu školu (razredi 5-8 kao Stringovi)
        for (int i = 1; i <= 8; i++) {
            generateQuizForGrade(today, "Osnovna škola", String.valueOf(i));
        }

        // Generiraj kvizove za srednju školu (razredi 1-4 kao Stringovi)
        for (int i = 1; i <= 4; i++) {
            generateQuizForGrade(today, "Srednja škola", String.valueOf(i));
        }
    }

    private void generateQuizForGrade(LocalDate date, String schoolLevel, String grade) {
        if (quizRepository.findByQuizDateAndSchoolLevelAndGrade(date, schoolLevel, grade).isPresent()) {
            return; // Kviz već postoji
        }

        try {
            String questionsJson = openAIService.generateQuestions(schoolLevel, grade);
            List<QuizQuestion> questions = parseQuestionsFromJson(questionsJson);

            Quiz quiz = new Quiz(date, schoolLevel, grade);
            questions.forEach(q -> q.setQuiz(quiz));
            quiz.setQuestions(questions);
            quizRepository.save(quiz);
        } catch (Exception e) {
            System.err.println("Greška pri generiranju kviza: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private List<QuizQuestion> parseQuestionsFromJson(String json) {
        List<QuizQuestion> questions = new ArrayList<>();
        JSONArray jsonArray = new JSONArray(json);

        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject questionJson = jsonArray.getJSONObject(i);
            QuizQuestion question = new QuizQuestion();

            question.setText(questionJson.getString("text"));

            JSONArray optionsArray = questionJson.getJSONArray("options");
            StringBuilder optionsBuilder = new StringBuilder();

            for (int j = 0; j < optionsArray.length(); j++) {
                if (j > 0) optionsBuilder.append("@");
                optionsBuilder.append(optionsArray.getString(j));
            }
            question.setOptions(optionsBuilder.toString());

            question.setCorrectAnswerIndex(questionJson.getInt("correctAnswerIndex"));
            questions.add(question);
        }

        return questions;
    }
}