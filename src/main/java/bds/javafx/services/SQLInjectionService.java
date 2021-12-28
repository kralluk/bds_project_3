package bds.javafx.services;

import bds.javafx.api.SQLInjectionView;
import bds.javafx.data.SQLInjectionRepository;

import java.util.List;

public class SQLInjectionService {

    private SQLInjectionRepository injectionRepository;

    public SQLInjectionService(SQLInjectionRepository injectionRepository) {
        this.injectionRepository = injectionRepository;
    }

    public List<SQLInjectionView> findByIDStatement(Long id) {
        return injectionRepository.findByIDStatement(id);
    }
}
