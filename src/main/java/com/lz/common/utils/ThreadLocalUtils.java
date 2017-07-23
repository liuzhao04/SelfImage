package com.lz.common.utils;

import java.util.HashMap;
import java.util.Map;

/**
 * 线程内资源缓存工具
 *
 * @author Administrator
 * @version 1.0, 2017年7月23日
 */
public class ThreadLocalUtils
{
    private static ThreadLocal<Map<String, Object>> data = new ThreadLocal<Map<String, Object>>();
    
    public static void put(String key, Object value)
    {
        if(data.get() == null) {
            data.set(new HashMap<String,Object>());
        }
        data.get().put(key, value);
    }

    public static Object get(String key)
    {
        if(data.get() == null) {
            return null;
        }
        return data.get().get(key);
    }

    public static void clear(String key)
    {
        data.get().remove(key);
    }
    
   
}
