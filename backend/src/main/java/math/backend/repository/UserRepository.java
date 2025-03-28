package math.backend.repository;

import math.backend.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

/* JpaRepository nudi vec puno gotovih metoda kao sto su:
save() - za save/update user-a
findById() - trazenje po primarnom kljucu
findAll() - za dohvat svih user-a
delete() - za brisanje user-a
*/

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    // sve su optional jer ako ne postoji to isto moze biti slucaj
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    Optional<User> findByUsernameOrEmail(String username, String email);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
}