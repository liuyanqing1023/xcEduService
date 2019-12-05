package com.xuecheng.test.rabbit;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * <p>
 * </p>
 *
 * @author LYQ
 * @since 2019/01/25 11:12
 */
@SpringBootTest
@RunWith(SpringRunner.class)
public class RabbitApplicationTest {


    @Autowired
    private Sender sender;

    @Test
    public void hello() throws Exception {
        sender.send();
    };

    }
