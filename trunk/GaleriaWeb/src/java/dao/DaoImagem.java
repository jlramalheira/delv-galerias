/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entidades.Imagem;
import java.util.List;

/**
 *
 * @author a968501
 */
public class DaoImagem extends Dao{
    
    public DaoImagem(Class classe) {
        super(classe);
    }
    
    public List<Imagem> listOneImageByGaleriaId(int id){
        return Dao.getEm().createQuery("SELECT p  FROM Imagem p WHERE p.galeria.id = "+id+" ORDER BY id LIMIT 1").getResultList();
    }
    
    public List<Imagem> listImagesByGaleriaId(int id){
        return Dao.getEm().createQuery("SELECT p FROM Imagem p WHERE p.galeria.id = "+id).getResultList();
    }
    
    
}
