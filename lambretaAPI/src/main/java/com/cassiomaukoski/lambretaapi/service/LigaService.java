package com.cassiomaukoski.lambretaapi.service;

import com.cassiomaukoski.lambretaapi.model.Liga;
import com.cassiomaukoski.lambretaapi.repository.LigaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Service
public class LigaService {

    @Autowired
    private LigaRepository ligaRepository;

    public Liga localizar(int id){
        return ligaRepository.findById(id).orElse(null);
    }

    public List<Liga> pesquisar(){
        return ligaRepository.findAllByOrderByNomeAsc();
    }

    public Resource localizarImagem(int id){
        try {
            Path filePath = Paths.get("/home/cassio/lambreta_imagens").resolve(id + ".png").normalize();
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
