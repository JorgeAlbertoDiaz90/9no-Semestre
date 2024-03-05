package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.boot.CommandLineRunner;

import java.util.List;
import java.util.Optional;

import org.slf4j.*;

@SpringBootApplication
public class DbExampleApplication {

	public static void main(String[] args) {
		SpringApplication.run(DbExampleApplication.class, args);
	}

	private static final Logger log = LoggerFactory.getLogger(DbExampleApplication.class);



	@Bean
	public CommandLineRunner testSomeEntity(SomeEntityRepository repository){
		return (args) ->{
			repository.save(new SomeEntity("Lapiz", "Ps sirve para escribir"));
			repository.save(new SomeEntity("Cuaderno", "Ps sirve para poder escribir"));
			repository.save(new SomeEntity("Goma", "Ps sirve para borrar"));
			repository.save(new SomeEntity("Lapicero", "Ps sirve para escribir tambien"));
			repository.save(new SomeEntity("Sacapunta", "Ps sirve para sacar punta"));
			repository.save(new SomeEntity("Regla", "Ps sirve para medir"));

			log.info("Todas las entidades");
			repository.findAll().forEach(SomeEntity ->{
				log.info(SomeEntity.toString());
			});

			log.info("Obteniendo registros por id:");
			Optional<SomeEntity> someentity = repository.findById(2L);
			log.info( someentity.isPresent() ? someentity.toString() : "No encontrado pa");

			log.info("Obteniendo registros por title:");
			List<SomeEntity> someentity2 = repository.findByTitle("Goma");
			log.info( !someentity2.isEmpty() ? someentity2.toString() : "No encontrado papasito");
		};
	}
}
