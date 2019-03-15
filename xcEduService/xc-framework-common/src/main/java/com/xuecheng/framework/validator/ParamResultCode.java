package com.xuecheng.framework.validator;

import com.xuecheng.framework.model.response.ResultCode;

/**
 * <p>
 * </p>
 *
 * @author LYQ
 * @since 2019/01/22 9:42
 */
public class ParamResultCode implements ResultCode {

    /**
     * 操作是否成功
     */
    boolean success;
    /**
     * 操作代码
     */
    int code = 10031;
    /**
     * 提示信息
     */
    String message;

    public ParamResultCode(String message){
        this.message = message;
    }


    @Override
    public boolean success() {
        return false;
    }

    @Override
    public int code() {
        return 0;
    }

    @Override
    public String message() {
        return null;
    }
}
