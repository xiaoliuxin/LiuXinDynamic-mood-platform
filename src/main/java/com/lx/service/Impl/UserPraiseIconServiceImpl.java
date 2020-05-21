package com.gph.service.Impl;

import com.gph.dao.UserPraiseIconMapper;
import com.gph.service.UserPraiseIconService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserPraiseIconServiceImpl implements UserPraiseIconService {
    @Autowired
    UserPraiseIconMapper userPraiseIconMapper;

    @Override
    public int praised(Integer userid, Integer vid) {
        return userPraiseIconMapper.praised(userid,vid);
    }

    @Override
    public int Cancel_praised(Integer userid, Integer vid) {
        return userPraiseIconMapper.Cancel_praised(userid,vid);
    }

    @Override
    public Integer if_praised(Integer userid, Integer vid) {
        return userPraiseIconMapper.if_praised(userid,vid);
    }

    @Override
    public int add_praise_tab(Integer statePraise, Integer userid, Integer vid) {
        return userPraiseIconMapper.add_praise_tab(statePraise,userid,vid);
    }

    @Override
    public int giveCoined(Integer userid, Integer vid) {
        return userPraiseIconMapper.giveCoined(userid,vid);
    }

    @Override
    public Integer if_giveCoin(Integer userid, Integer vid) {
        return userPraiseIconMapper.if_giveCoin(userid,vid);
    }

    @Override
    public int add_Coin_tab(Integer stateIcon, Integer userid, Integer vid) {
        return userPraiseIconMapper.add_Coin_tab(stateIcon,userid,vid);
    }
}
