package com.refugees.portal.db;

import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.orm.jpa.EntityManagerFactoryBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.datasource.lookup.JndiDataSourceLookup;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;

/**
 * This class for database and JPA connection info. configuration.
 * 
 * @author Farag.Zakaria
 *
 */
@Configuration
@EnableConfigurationProperties
public class PersistenceDBConfig {

	public PersistenceDBConfig() {
		super();
	}

	@Bean
	@ConfigurationProperties(prefix = "spring.datasource")
	public JndiPropertyHolder primary() {
		return new JndiPropertyHolder();
	}

	@Bean(name = "datasource")
	@Primary
	public DataSource primaryDataSource() {
		JndiDataSourceLookup dataSourceLookup = new JndiDataSourceLookup();
		DataSource dataSource = dataSourceLookup.getDataSource(primary().getJndiName());
		return dataSource;
	}

	@Bean(name = "entityManagerFactory")
	@Primary
	public LocalContainerEntityManagerFactoryBean primaryEntityManagerFactory(EntityManagerFactoryBuilder builder,
			@Qualifier("datasource") DataSource dataSource) {
		return builder.dataSource(dataSource).packages("com.refugees.portal.db.model").build();
	}

	@Bean(name = "transactionManager")
	@Primary
	public PlatformTransactionManager primaryTransactionManager(
			@Qualifier("entityManagerFactory") EntityManagerFactory entityManagerFactory) {
		return new JpaTransactionManager(entityManagerFactory);
	}

	private static class JndiPropertyHolder {
		private String jndiName;

		public String getJndiName() {
			return jndiName;
		}

		public void setJndiName(String jndiName) {
			this.jndiName = jndiName;
		}
	}
	@Bean
	@Scope(value = ConfigurableBeanFactory.SCOPE_SINGLETON)
	public ResourceBundle getResponseMessagesBundle() {
			return PropertyResourceBundle.getBundle("questionMessages");
	}
}
