/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import jakarta.persistence.*;
import model.User;
import java.util.List;

/**
 * UserDAO - Lớp thao tác dữ liệu với bảng Users
 * Cung cấp các chức năng CRUD cơ bản cho entity User
 */
public class UserDAO {
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
    public void insert(User user) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
            System.out.println("Đã thêm user thành công: " + user.getName());
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
    public void update(User user) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            em.merge(user);
            em.getTransaction().commit();
            System.out.println("Đã cập nhật user thành công: " + user.getName());
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

    /**
     * Xóa user khỏi cơ sở dữ liệu theo ID
     * @param id ID của user cần xóa
     * @return true nếu xóa thành công, false nếu không tìm thấy user
     */
    public boolean delete(int id) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            
            User user = em.find(User.class, id);
            if (user != null) {
                em.remove(user);
                em.getTransaction().commit();
                System.out.println("Đã xóa user thành công: " + user.getName());
                return true;
            } else {
                em.getTransaction().rollback();
                System.out.println("Không tìm thấy user với ID: " + id);
                return false;
            }
        } catch (Exception e) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Lỗi khi xóa user: " + e.getMessage());
            throw e;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    /**
     * Lấy tất cả user từ cơ sở dữ liệu
     * @return Danh sách tất cả user
     */
    public List<User> getAll() {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            List<User> users = em.createQuery("SELECT u FROM User u", User.class).getResultList();
            System.out.println("Đã lấy " + users.size() + " user từ cơ sở dữ liệu");
            return users;
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy danh sách user: " + e.getMessage());
            throw e;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    /**
     * Tìm user theo ID
     * @param id ID của user cần tìm
     * @return User tìm thấy hoặc null nếu không tìm thấy
     */
    public User findById(int id) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            User user = em.find(User.class, id);
            if (user != null) {
                System.out.println("Tìm thấy user: " + user.getName());
            } else {
                System.out.println("Không tìm thấy user với ID: " + id);
            }
            return user;
        } catch (Exception e) {
            System.err.println("Lỗi khi tìm user theo ID: " + e.getMessage());
            throw e;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    /**
     * Tìm user theo email
     * @param email Email của user cần tìm
     * @return User tìm thấy hoặc null nếu không tìm thấy
     */
    public User findByEmail(String email) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE u.email = :email", User.class);
            query.setParameter("email", email);
            
            List<User> users = query.getResultList();
            if (!users.isEmpty()) {
                User user = users.get(0);
                System.out.println("Tìm thấy user với email: " + email);
                return user;
            } else {
                System.out.println("Không tìm thấy user với email: " + email);
                return null;
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi tìm user theo email: " + e.getMessage());
            throw e;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    /**
     * Tìm kiếm user theo tên (có thể tìm kiếm một phần)
     * @param name Tên hoặc một phần tên của user cần tìm
     * @return Danh sách user có tên chứa chuỗi tìm kiếm
     */
    public List<User> searchByName(String name) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE u.name LIKE :name", User.class);
            query.setParameter("name", "%" + name + "%");
            
            List<User> users = query.getResultList();
            System.out.println("Tìm thấy " + users.size() + " user có tên chứa: " + name);
            return users;
        } catch (Exception e) {
            System.err.println("Lỗi khi tìm kiếm user theo tên: " + e.getMessage());
            throw e;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    /**
     * Tìm kiếm user theo nhiều tiêu chí
     * @param name Tên user (có thể null)
     * @param email Email user (có thể null)
     * @return Danh sách user thỏa mãn điều kiện tìm kiếm
     */
    public List<User> search(String name, String email) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            StringBuilder jpql = new StringBuilder("SELECT u FROM User u WHERE 1=1");
            
            if (name != null && !name.trim().isEmpty()) {
                jpql.append(" AND u.name LIKE :name");
            }
            if (email != null && !email.trim().isEmpty()) {
                jpql.append(" AND u.email LIKE :email");
            }
            
            TypedQuery<User> query = em.createQuery(jpql.toString(), User.class);
            
            if (name != null && !name.trim().isEmpty()) {
                query.setParameter("name", "%" + name + "%");
            }
            if (email != null && !email.trim().isEmpty()) {
                query.setParameter("email", "%" + email + "%");
            }
            
            List<User> users = query.getResultList();
            System.out.println("Tìm thấy " + users.size() + " user theo điều kiện tìm kiếm");
            return users;
        } catch (Exception e) {
            System.err.println("Lỗi khi tìm kiếm user: " + e.getMessage());
            throw e;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    /**
     * Đóng EntityManagerFactory khi không còn sử dụng
     */
    public static void closeEntityManagerFactory() {
        if (emf != null && emf.isOpen()) {
            emf.close();
            System.out.println("Đã đóng EntityManagerFactory");
        }
    }
}
