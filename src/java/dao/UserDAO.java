/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import jakarta.persistence.*;
import model.User;
import java.util.List;

public class UserDAO {
    private static EntityManagerFactory emf  = buildEntityManagerFactory();;

    private static EntityManagerFactory buildEntityManagerFactory() {
        try {
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa");
            System.out.println("EMF initialized: " + emf);
            return emf;
        } catch (Throwable e) {
            System.err.println("Failed to initialize EMF:");
            e.printStackTrace();
            return null;  // để emf == null nếu fail
        }
    }
   
    
    public void insert(User user) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(user);
        em.getTransaction().commit();
        em.close();
    }

    public List<User> getAll() {
        EntityManager em = emf.createEntityManager();
        return em.createQuery("SELECT u FROM User u", User.class).getResultList();
    }
}
