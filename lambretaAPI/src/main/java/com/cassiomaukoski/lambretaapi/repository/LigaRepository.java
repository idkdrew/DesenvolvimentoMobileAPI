package com.cassiomaukoski.lambretaapi.repository;

import com.cassiomaukoski.lambretaapi.model.Liga;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LigaRepository extends JpaRepository<Liga, Integer> {
    List<Liga> findAllByOrderByNomeAsc();
}
