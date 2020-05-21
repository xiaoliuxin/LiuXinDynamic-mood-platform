package com.lx.service;

import com.gph.model.Message;

import java.util.List;

public interface MessageService {
    List<Message> selectMessByVid(Integer vid);
    int sendMess(Message record);
    int deleteMess(Integer messId);
}
