package math.backend.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Service
public class MathService {

    private static final Logger logger = LoggerFactory.getLogger(MathService.class); // Logger instance
    private final WebClient webClient;

    public MathService() {
        this.webClient = WebClient.builder()
                .baseUrl("https://api-inference.huggingface.co/models/mistralai/Mistral-7B-Instruct-v0.2")
                .defaultHeader("Authorization", "Bearer tvoj_kljuc") // Zamijeni svojim ključem
                .build();
    }

    public List<String> generateMathProblems() {
        String prompt = "Create 30 different middle school level math problems. "
                + "For each problem, provide the problem statement and the correct answer. "
                + "Format each problem as: '1. Problem: What is 5 + 7? Answer: 12' "
                + "and separate problems with new lines.";

        String response = webClient.post()
                .bodyValue(Map.of("inputs", prompt))
                .retrieve()
                .bodyToMono(String.class)
                .block();

        logger.info("Generated Math Problems Response: {}", response);

        // Split the response into individual problems
        return Arrays.asList(response.split("\n"));
    }
}
