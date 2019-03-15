package com.xuecheng.framework.log;

import java.lang.annotation.*;

/**
 * 日志注解
 *
 * @author lyq
 *
 */
@Target({ ElementType.PARAMETER, ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface LogAnnotation {
	/**
	 * 操作内容
	 */
	String value() default "";
}
