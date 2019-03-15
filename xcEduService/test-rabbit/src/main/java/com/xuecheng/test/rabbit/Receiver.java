package com.xuecheng.test.rabbit;

import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Date;

/**
 * <p>
 *     消息消费者
 * </p>
 *
 * @author LYQ
 * @since 2019/01/24 15:34
 */
@Component
@RabbitListener(queues = "hello")
public class Receiver {
    @RabbitHandler
    public void process(String hello){

        System.err.println("-----------进来啦-----------");
        System.err.println("Receiver : "+ hello);
    }
}
