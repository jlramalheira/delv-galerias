package dao;


import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Persistence;

public class Dao<T> {
    private static EntityManager em = Persistence.createEntityManagerFactory("UP").createEntityManager();
    private Class classe;

    public Dao(Class classe) {
        this.classe = classe;
    }

    public void insert(T entidade){
        if(entidade != null){
            em.getTransaction().begin();
            em.persist(entidade);
            em.getTransaction().commit();
        }
    }

    public T get(int id){
        return (T)em.find(classe, id);
    }

    public void update(T entidade){
        em.getTransaction().begin();
        em.merge(entidade);
        em.getTransaction().commit();
    }

    public void remove(int id){
        T entidade = get(id);

        if(entidade != null){
            em.getTransaction().begin();
            em.remove(entidade);
            em.getTransaction().commit();
        }
    }
       
    public List<T> list(){
        return em.createQuery("SELECT p FROM "+classe.getSimpleName()+" p").getResultList();
    }

    public static EntityManager getEm() {
        return em;
    }    
    
}
