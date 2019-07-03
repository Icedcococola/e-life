package com.example.demo.Repository;

import com.example.demo.Entity.Express;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ExpressRepository extends JpaRepository<Express,Integer> {
    Express findAllByPackageid(Integer packageid);

}
