package com.cassiomaukoski.lambretaapi.repository;

import com.cassiomaukoski.lambretaapi.model.Time;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TimeRepository extends JpaRepository<Time, Integer> {
    List<Time> findAllByIdLigaOrderByNomeAsc(int idLiga);
}
