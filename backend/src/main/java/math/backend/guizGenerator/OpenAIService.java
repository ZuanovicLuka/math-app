package math.backend.guizGenerator;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

@Service
public class OpenAIService {

    private final LessonCatalog lessonCatalog;
    private final RestTemplate restTemplate;

    @Value("${openai.api.key}")
    private String apiKey;

    @Value("${openai.api.url}")
    private String apiUrl;

    public OpenAIService(LessonCatalog lessonCatalog, RestTemplate restTemplate) {
        this.lessonCatalog = lessonCatalog;
        this.restTemplate = restTemplate;
    }

    public String generateQuestions(String schoolLevel, String grade) {
        List<String> lessons = lessonCatalog.getLessonsFor(schoolLevel, grade);

        String lessonText = lessons.isEmpty()
                ? "bez ograničenja tema"
                : "samo iz sljedećih tema: " + String.join(", ", lessons);

        String levelName = schoolLevel.equals("Osnovna škola") ? "osnovne škole" : "srednje škole";

        String prompt = String.format("""
            Ti si iskusni profesor matematike. Generiraj točno 10 matematičkih pitanja za %s. razred %s.
            Pitanja moraju biti %s.
            
            VAŽNE SPECIFIKACIJE:
            1. Pitanja moraju biti prilagođena uzrastu učenika
            2. Težina pitanja mora odgovarati razredu
            3. Svako pitanje mora imati TOČNO JEDAN točan odgovor
            4. Točan odgovor ne smije uvijek biti na istoj poziciji
            5. Odgovori moraju biti jasno različiti i nedvosmisleni
            6. Izbjegavati pitanja gdje bi više odgovora moglo biti točno
            
            FORMAT PITANJA:
            - Tekst pitanja (jasno i konkretno, max 2 rečenice)
            - 4 ponuđena odgovora (samo jedan točan)
            - Točan odgovor označen indexom (0-3)
            
            Vrati SAMO JSON array u točno ovom formatu :
            [
              {
                "text": "Koliko je 7 + 8?",
                "options": ["13", "14", "15", "16"],
                "correctAnswerIndex": 2
              },
              ...
            ]
            
            VAŽNO: Vrati SAMO JSON array, bez ikakvih dodatnih znakova, komentara ili markdown oznaka.
            JSON array mora biti valjan i moći će se parsirati direktno.
            """, grade, levelName, lessonText);

        return callOpenAIAPI(prompt);
    }

    private String callOpenAIAPI(String prompt) {
        try {
            // Priprema zahtjeva
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setBearerAuth(apiKey);

            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("model", "gpt-4o");
            requestBody.put("messages", List.of(
                    Map.of("role", "user", "content", prompt)
            ));
            requestBody.put("temperature", 0.5);
            requestBody.put("max_tokens", 1000);

            HttpEntity<Map<String, Object>> request = new HttpEntity<>(requestBody, headers);

            // Slanje zahtjeva
            ResponseEntity<Map> response = restTemplate.exchange(
                    apiUrl,
                    HttpMethod.POST,
                    request,
                    Map.class
            );

            // Obrada odgovora
            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                Map<String, Object> responseBody = response.getBody();
                List<Map<String, Object>> choices = (List<Map<String, Object>>) responseBody.get("choices");

                if (choices != null && !choices.isEmpty()) {
                    Map<String, Object> firstChoice = choices.get(0);
                    Map<String, Object> message = (Map<String, Object>) firstChoice.get("message");
                    return (String) message.get("content");
                }
            }

            throw new RuntimeException("OpenAI API nije vratio očekivani odgovor");

        } catch (Exception e) {
            throw new RuntimeException("Greška pri pozivu OpenAI API-ja: " + e.getMessage(), e);
        }
    }
}