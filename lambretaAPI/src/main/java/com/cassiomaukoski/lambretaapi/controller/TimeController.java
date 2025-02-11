package com.cassiomaukoski.lambretaapi.controller;

import com.cassiomaukoski.lambretaapi.model.Time;
import com.cassiomaukoski.lambretaapi.service.TimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/time")
public class TimeController {

    @Autowired
    private TimeService timeService;

    @GetMapping("/{id}")
    public ResponseEntity<Time> localizar(@PathVariable int id){
        return ResponseEntity.ok(timeService.localizar(id));
    }

    @GetMapping("/pesquisar/{idLiga}")
    public ResponseEntity<List<Time>> pesquisar(@PathVariable int idLiga){
        return ResponseEntity.ok(timeService.pesquisar(idLiga));
    }

    @GetMapping("/{id}/imagem")
    public ResponseEntity<Resource> localizarImagem(@PathVariable int id){
        Resource resource = timeService.localizarImagem(id);
        return ResponseEntity.ok()
                .contentType(MediaType.IMAGE_PNG)
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + resource.getFilename() + "\"")
                .body(resource);
    }
}
