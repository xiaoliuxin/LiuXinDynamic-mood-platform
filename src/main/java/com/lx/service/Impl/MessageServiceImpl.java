package com.gph.service.Impl;

import com.gph.dao.MessageMapper;
import com.gph.model.Message;
import com.gph.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    private MessageMapper messageMapper;

    @Override
    public List<Message> selectMessByVid(Integer vid) {
        return messageMapper.selectMessByVid(vid);
    }

    @Override
    public int sendMess(Message record) {
        return messageMapper.sendMess(record);
    }

    @Override
    public int deleteMess(Integer messId) {
        return messageMapper.deleteMess(messId);
    }
}
