package uts.wsd.dao;

import uts.wsd.dto.Users;

/**
 *
 * @author Hongming
 */
public interface UsersDAO {
    
    /**
     *
     * @return
     */
    public Users loadUsers();

    /**
     *
     * @param users
     * @return
     */
    public boolean saveUsers(Users users);
}
