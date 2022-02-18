//package kr.co.pegsystem.core.config;
//
//import javax.sql.DataSource;
//
//import org.apache.ibatis.session.SqlSessionFactory;
//import org.mybatis.spring.SqlSessionFactoryBean;
//import org.mybatis.spring.SqlSessionTemplate;
//import org.mybatis.spring.annotation.MapperScan;
//import org.mybatis.spring.boot.autoconfigure.SpringBootVFS;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
//
//@Configuration
//@MapperScan(basePackages="kr.co.pegsystem.*.mapper")
//public class MyBatisConfig {
//	
//	@Bean
//	public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception{
//		SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
//		sqlSessionFactory.setVfs(SpringBootVFS.class); //Spring Boot Build 시 MyBatis Type Alias 미적용 시 추가
//		sqlSessionFactory.setDataSource(dataSource);
//		PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
//		sqlSessionFactory.setConfigLocation(resolver.getResource("mapper/config/mybatis-config.xml"));
//		sqlSessionFactory.setMapperLocations(resolver.getResources("mapper/sql/*_mapper.xml"));
//		return sqlSessionFactory.getObject();
//	}
//	
//	@Bean
//	public SqlSessionTemplate sqlSession(SqlSessionFactory sqlSessionFactory) {
//		return new SqlSessionTemplate(sqlSessionFactory);
//	}
//}
