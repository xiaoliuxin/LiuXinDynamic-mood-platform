lx com.gph.service;

import com.gph.model.User;


import java.util.List;

public interface UserSerivce {
    User selectByPrimaryKey(Integer userid);
    List<User> login(String username,String password);
    User selectInfoByUserName(String username);
    List<User> select_user_release_videos(Integer userid);
    List<User> follow_list(Integer userid);
    List<User> fans_list(Integer follow_id);
    int register(User user);
    Integer updateContentById(String content,Integer uid);
    Integer selectUserExpById(Integer userid);
    Integer selectUserLeveLById(Integer userid);
    Integer LEVEL_UP(Integer userid);
    int getExp(Integer userid);
    int deduct_coin(Integer userid);
    int author_get_coin(Integer userid);
    int levelup_getCoin(Integer coinNum,Integer userid);
    int update_user_info(String username,String password,String headImg,Integer userid);
}
