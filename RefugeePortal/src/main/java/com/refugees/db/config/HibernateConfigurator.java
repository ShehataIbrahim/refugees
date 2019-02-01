package com.refugees.db.config;

import java.sql.Connection;
import java.sql.SQLException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.engine.jdbc.connections.spi.ConnectionProvider;
import org.hibernate.service.ServiceRegistry;

import net.hitachifbbot.utils.DBUtils;

public class HibernateConfigurator {
	private static final SessionFactory sessionFactoryObj;
	static {
		// Creating Configuration Instance & Passing Hibernate Configuration File
		Configuration configObj = new Configuration();
		configObj.configure("hibernate.cfg.xml");

		// Since Hibernate Version 4.x, ServiceRegistry Is Being Used
		ServiceRegistry serviceRegistryObj = new StandardServiceRegistryBuilder().applySettings(configObj.getProperties()).build(); 

		// Creating Hibernate SessionFactory Instance
		sessionFactoryObj = configObj.buildSessionFactory(serviceRegistryObj);
	}
	public static SessionFactory getSessionFactory()
	{
		return sessionFactoryObj;
	}
    public static void shutdown() {
        // Close caches and connection pools
        getSessionFactory().close();
    }
    public static Connection getConnection()
    {
    	Connection connection =null;
    	try {
    		connection = getSessionFactory().
            getSessionFactoryOptions().getServiceRegistry().
            getService(ConnectionProvider.class).getConnection();
    	}catch(Exception e)
    	{
    		try {
				connection=DBUtils.instance.getConnection();
			} catch (SQLException e1) {
				
				e1.printStackTrace();
			}
    	}
    	return connection;
    }
}
