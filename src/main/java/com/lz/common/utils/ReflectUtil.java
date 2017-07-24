package com.lz.common.utils;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 反射工具箱
 * 
 * @author liuz@aotian.com
 * @date 2017年7月24日 下午2:25:04
 */
public class ReflectUtil {

	public static void setValueByFieldName(Object target, String fieldName, Object value)
			throws IllegalArgumentException, IllegalAccessException, NoSuchFieldException, SecurityException {
		Field field = getFieldByName(target, fieldName);
		if (field == null) {
			throw new NoSuchFieldError(fieldName);
		}
		field.setAccessible(true);
		field.set(target, value);
	}

	public static Object getValueByFieldName(Object target, String fieldName)
			throws IllegalArgumentException, IllegalAccessException, NoSuchFieldException, SecurityException {
		Field field = getFieldByName(target, fieldName);
		if (field == null) {
			throw new NoSuchFieldError(fieldName);
		}
		field.setAccessible(true);
		return field.get(target);
	}

	private static Field getFieldByName(Object target, String fieldName) {
		List<Field> list = new ArrayList<Field>();
		getAllField(target.getClass(), list);
		for (Field field : list) {
			if (field.getName().equals(fieldName)) {
				return field;
			}
		}
		return null;
	}

	private static void getAllField(Class<?> target, List<Field> fs) {
		fs.addAll(Arrays.asList(target.getDeclaredFields()));
		Class<?> clsSup = target.getSuperclass();
		if (clsSup != null) {
			getAllField(clsSup, fs);
		}
	}
}
