package spms.context;

import java.util.Hashtable;
import java.util.Map;
import java.util.Properties;

// appilcation-context.properties 파일을 읽어서 필요한 객체를 준비/저장
public class ApplicationContext {
	
	//properties 파일이 key=value 구조로 되어있기 때문에 Map을 사용한다.
	Map<String, Object> objTable = new Hashtable<String, Object>();
	
	public Object getBean(String key) {
		return objTable.get(key);
	}
	
	public ApplicationContext(String propertiesPath) throws Exception{
		Properties props = new Properties();
		props.load(new FileReader(propertiesPath));
		
		prepareObject(props);
		injectDependency();
	
}
