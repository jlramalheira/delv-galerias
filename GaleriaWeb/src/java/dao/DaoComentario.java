/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entidades.Comentario;
import java.util.List;

/**
 *
 * @author João
 */
public class DaoComentario extends Dao {

    public DaoComentario(Class classe) {
        super(classe);
    }

    public List<Comentario> listComentariosPerfil(int id) {
        return Dao.getEm().createQuery("SELECT p FROM Comentario p WHERE p.imagem = null AND p.destinatinatario.id ="+id ).getResultList();
    }
}
