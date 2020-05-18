package com.lx.dao;

import com.lx.model.User;
import com.lx.model.Video;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {

    int deleteByPrimaryKey(Integer userid);
    int insert(User record);
    int insertSelective(User record);
    User selectByPrimaryKey(Integer userid);
    int updateByPrimaryKeySelective(User record);
    int updateByPrimaryKey(User record);
    List<User> login(@Param("username") String username, @Param("password") String password);

    User selectInfoByUserName(String username);

    List<User> select_user_release_videos(Integer userid);

    List<User> follow_list(Integer userid);

    List<User> fans_list(Integer follow_id);

    int register(User user);
    Integer updateContentById(@Param("content") String content,@Param("uid") Integer uid);
    Integer selectUserExpById(Integer userid);
    Integer selectUserLeveLById(Integer userid);
    Integer LEVEL_UP(Integer userid);
    int getExp(Integer userid);
    int deduct_coin(Integer userid);
    int author_get_coin(Integer userid);
    int levelup_getCoin(@Param("coinNum") Integer coinNum,@Param("userid") Integer userid);
    int update_user_info(@Param("username") String username,@Param("password") String password,@Param("headImg") String headImg,@Param("userid") Integer userid);
}