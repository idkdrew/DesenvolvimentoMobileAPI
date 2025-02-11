package com.cassiomaukoski.lambretaapi.service;

import com.cassiomaukoski.lambretaapi.model.Time;
import com.cassiomaukoski.lambretaapi.repository.TimeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Service
public class TimeService {

    @Autowired
    private TimeRepository timeRepository;

    public Time localizar(int id){
        return timeRepository.findById(id).orElse(null);
    }

    public List<Time> pesquisar(int idLiga){
        return timeRepository.findAllByIdLigaOrderByNomeAsc(idLiga);
    }

    public Resource localizarImagem(int id){
        String idLiga = Integer.toString(id).substring(0,1);
        try {
            Path filePath = Paths.get("/home/cassio/lambreta_imagens/" + idLiga).resolve(id + ".png").normalize();
            Resource resource = new UrlResource(filePath.toUri());

            if (resource.exists()) {
                return resource;
            } else {
                return null;
            }
        } catch (Exception e) {
            return null;
        }
    }


}
