package kr.co.pegsystem.common.vo;

import java.util.HashMap;

import org.apache.ibatis.type.Alias;
import org.springframework.jdbc.support.JdbcUtils;

@SuppressWarnings("serial")
@Alias("pegMap")
public class PegMap extends HashMap<String, Object>{
	
	@Override
	public Object put(String key, Object value) {
		return super.put(JdbcUtils.convertUnderscoreNameToPropertyName(key), value);//Map CamelCase 적용 
	}
	
}
