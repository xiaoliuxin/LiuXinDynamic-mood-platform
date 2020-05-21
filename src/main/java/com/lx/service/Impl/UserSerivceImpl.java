package com.gph.service.Impl;

import com.gph.dao.UserMapper;
import com.gph.model.User;

import com.gph.service.UserSerivce;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserSerivceImpl implements UserSerivce {
    @Autowired
    private UserMapper userMapper;

    @Override
    public User selectByPrimaryKey(Integer userid) {
        return userMapper.selectByPrimaryKey(userid);
    }

    @Override
    public List<User> login(String username, String password) {
        return userMapper.login(username,password);
    }

    @Override
    public User selectInfoByUserName(String username) {
        return userMapper.selectInfoByUserName(username);
    }

    @Override
    public List<User> select_user_release_videos(Integer userid) {
        return userMapper.select_user_release_videos(userid);
    }

    @Override
    public List<User> follow_list(Integer userid) {
        return userMapper.follow_list(userid);
    }

    @Override
    public List<User> fans_list(Integer follow_id) {
        return userMapper.fans_list(follow_id);
    }

    @Override
    public int register(User user) {
        return userMapper.register(user);
    }

    @Override
    public Integer updateContentById(String content,Integer uid) {
        return userMapper.updateContentById(content,uid);
    }

    @Override
    public Integer selectUserExpById(Integer userid) {
        return userMapper.selectUserExpById(userid);
    }

    @Override
    public Integer selectUserLeveLById(Integer userid) {
        return userMapper.selectUserLeveLById(userid);
    }

    @Override
    public Integer LEVEL_UP(Integer userid) {
        return userMapper.LEVEL_UP(userid);
    }

    @Override
    public int getExp(Integer userid) {
        return userMapper.getExp(userid);
    }

    @Override
    public int deduct_coin(Integer userid) {
        return userMapper.deduct_coin(userid);
    }

    @Override
    public int author_get_coin(Integer userid) {
        return userMapper.author_get_coin(userid);
    }

    @Override
    public int levelup_getCoin(Integer coinNum, Integer userid) {
        return userMapper.levelup_getCoin(coinNum,userid);
    }

    @Override
    public int update_user_info(String username, String password, String headImg, Integer userid) {
        return userMapper.update_user_info(username,password,headImg,userid);
    }


}
