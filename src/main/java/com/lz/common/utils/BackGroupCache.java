package com.lz.common.utils;

import java.util.HashMap;
import java.util.Map;

/**
 * 后台缓存
 *
 * @author Administrator
 * @version 1.0, 2017年7月23日
 */
public class BackGroupCache
{
    private static Map<String, Object> data = new HashMap<String, Object>();

    public static void put(String key, Object value)
    {
        data.put(key, value);
    }

    public static Object get(String key)
    {
        return data.get(key);
    }

    public static void clear(String key)
    {
        data.remove(key);
    }
}
