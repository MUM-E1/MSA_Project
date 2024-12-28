package com.example.swappy.controller;


import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/ping")
public class TestController {

    @GetMapping
    public ResponseEntity<?> ping() {
        return new ResponseEntity<>("pong", HttpStatus.ACCEPTED);
    }
}