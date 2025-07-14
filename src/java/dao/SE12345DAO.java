/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import jakarta.persistence.*;
import model.User;
import java.util.List;
import model.SE12345;

/**
 *
 * @author hiepn
 */
public class SE12345DAO {
    
    private static EntityManagerFactory emf = buildEntityManagerFactory();
    
    /**
     * Khởi tạo EntityManagerFactory từ persistence unit "jpa"
     * @return EntityManagerFactory hoặc null nếu khởi tạo thất bại
     */
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
    
    /**
     * Thêm user mới vào cơ sở dữ liệu
     * @param user Đối tượng User cần thêm
     */
    public void insert(SE12345 se) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            em.persist(se);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Lỗi khi thêm user: " + e.getMessage());
            throw e;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
    
    /**
     * Cập nhật thông tin user trong cơ sở dữ liệu
     * @param user Đối tượng User với thông tin đã được cập nhật
     */
    public void update(SE12345 se) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            em.merge(se);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Lỗi khi cập nhật user: " + e.getMessage());
            throw e;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
}
