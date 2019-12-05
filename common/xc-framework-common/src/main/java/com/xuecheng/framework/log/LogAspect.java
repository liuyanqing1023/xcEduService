package com.xuecheng.framework.log;


import com.xuecheng.framework.model.response.CommonCode;
import com.xuecheng.framework.model.response.ResponseResult;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Aspect
@Component
@Order(1)
public class LogAspect {

    private static final Logger log = LoggerFactory.getLogger(LogAspect.class);

    @Around("@annotation(com.xuecheng.framework.log.LogAnnotation)")
    public Object aroundMethod(ProceedingJoinPoint joinPoint) {
        log.info("-------------------------------------------------------------------------------------------------------------------");
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

        Object result1 = null;
        try {
            Map<String, String> m = getControllerMethodDescription(joinPoint);
            String url = request.getRequestURI();
            log.info("操作内容:" + m.get("actionName"));
            log.info("操作类名:" + m.get("className"));
            log.info("操作方法:" + joinPoint.getSignature().getName());
            log.info("操作参数:" + m.get("methodParams"));
            log.info("操作URL:" + url);
            result1 = joinPoint.proceed();
            log.info("操作结果:" + result1);
        } catch (Throwable e) {
            log.info("操作异常:", e);
            return new ResponseResult(CommonCode.FAIL);
        }
        return result1;
    }

    private Map<String, String> getControllerMethodDescription(JoinPoint joinPoint) throws Exception {
        Map<String, String> map = new HashMap<>();
        String targetName = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        Object[] arguments = joinPoint.getArgs();
        List<Object> args = Arrays.asList(arguments);
        map.put("methodParams", args.toString());
        Class<?> targetClass = Class.forName(targetName);
        map.put("className", targetClass.getName());
        Method[] methods = targetClass.getMethods();
        for (Method method : methods) {
            if (method.getName().equals(methodName)) {
                Class<?>[] clazz = method.getParameterTypes();
                if (clazz.length == arguments.length) {
                    map.put("actionName", method.getAnnotation(LogAnnotation.class).value());
                    break;
                }
            }
        }
        return map;
    }
}