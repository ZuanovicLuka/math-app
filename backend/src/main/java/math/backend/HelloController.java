package math.backend;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/")
    public String index(){
        return "Hello World";
    }

    @GetMapping("/bok")
    public String bok(@RequestParam(value = "ime", defaultValue = "ti") String name) {
        return "Bok, " + name + "!";
    }
}
