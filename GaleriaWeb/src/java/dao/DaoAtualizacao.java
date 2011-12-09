/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entidades.Atualizacao;
import java.util.List;

/**
 *
 * @author João
 */
public class DaoAtualizacao extends Dao {

    public DaoAtualizacao(Class classe) {
        super(classe);
    }
    
    public List<Atualizacao> listAttFromUser(int id){
        return Dao.getEm().createQuery("SELECT p FROM Atualizacao p WHERE p.destinatario.id = "+id).getResultList();
    }
    
    public int removeAll(int id){
        Dao.getEm().getTransaction().begin();
        int number = Dao.getEm().createQuery("DELETE FROM Atualizacao p WHERE p.destinatario.id = "+id).executeUpdate();
        Dao.getEm().getTransaction().commit();
        return number;
    }
    
    
}
