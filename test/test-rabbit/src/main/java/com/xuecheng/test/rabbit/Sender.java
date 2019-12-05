package com.xuecheng.test.rabbit;

import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Date;

/**
 * <p>
 *     消息发送者
 * </p>
 *
 * @author LYQ
 * @since 2019/01/24 15:34
 */
@Controller
public class Sender {
    @Autowired
    private AmqpTemplate amqpTemplate;
    @GetMapping("/send")
    public String send(){
        String context = "hello "+new Date();
        System.err.println("Send : "+context);
        this.amqpTemplate.convertAndSend("hello",context);
        return context;
    }
}
