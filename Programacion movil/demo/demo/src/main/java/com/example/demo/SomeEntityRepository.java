package com.example.demo;
import org.springframework.data.repository.CrudRepository;
import java.util.List;
import java.util.Optional;



public interface SomeEntityRepository extends CrudRepository<SomeEntity, Long>{
    List<SomeEntity> findByTitle(String title);
    Optional<SomeEntity> findById(Long id);
    List<SomeEntity> findByDescription(String description);
}
