/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entidades.Galeria;
import entidades.Usuario;
import java.util.List;

/**
 *
 * @author João
 */
public class DaoGaleria extends Dao {

    public DaoGaleria(Class classe) {
        super(classe);
    }
    public List<Galeria> listGaleriaByUser(int id){
        return Dao.getEm().createQuery("SELECT p  FROM Galeria p WHERE p.usuario.id = "+id).getResultList();
    }
    
}
