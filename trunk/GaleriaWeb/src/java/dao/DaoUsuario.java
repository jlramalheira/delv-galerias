/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entidades.Usuario;
import java.util.List;

/**
 *
 * @author aluno
 */
public class DaoUsuario extends Dao {  

    public DaoUsuario(Class classe) {
        super(classe);
    }
    
    public List<Usuario> listByLogin(String login){
        return Dao.getEm().createQuery("SELECT p FROM Usuario p WHERE p.login LIKE '%"+login+"%'").getResultList();
    }
    
    public List<Usuario> listByNome(String nome){
        return Dao.getEm().createQuery("SELECT p FROM Usuario p WHERE p.nome LIKE '%"+nome+"%'").getResultList();
    }
    
}
