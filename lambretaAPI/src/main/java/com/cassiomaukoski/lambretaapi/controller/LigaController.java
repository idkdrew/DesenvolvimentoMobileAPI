package com.cassiomaukoski.lambretaapi.controller;

import com.cassiomaukoski.lambretaapi.model.Liga;
import com.cassiomaukoski.lambretaapi.service.LigaService;
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
@RequestMapping("/liga")
public class LigaController {

    @Autowired
    private LigaService ligaService;

    @GetMapping("/{id}")
    public ResponseEntity<Liga> localizar(@PathVariable int id){
        return ResponseEntity.ok(ligaService.localizar(id));
    }

    @GetMapping("/pesquisar")
    public ResponseEntity<List<Liga>> pesquisar(){
        return ResponseEntity.ok(ligaService.pesquisar());
    }

    @GetMapping("/{id}/imagem")
    public ResponseEntity<Resource> localizarImagem(@PathVariable int id){
        Resource resource = ligaService.localizarImagem(id);
        return ResponseEntity.ok()
                .contentType(MediaType.IMAGE_PNG)
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + resource.getFilename() + "\"")
                .body(resource);
    }
}
