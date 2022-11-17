package com.nttdata.nttdatacenters.jdbc;

import java.sql.Statement;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 * Clase principal
 * 
 * @author Manoli
 * 
 */
public class App {
	
	/** LOGGER **/
	private static final Logger LOG = LoggerFactory.getLogger(App.class);
	
	/**
	 * Método principal
	 * 
	 * @param args
	 * @throws SQLException
	 */
	public static void main(String[] args) throws SQLException {
		
		LOG.info("TRAZA DE INICIO");
		
		// Conexión a la base de datos.
		
		stablishMBDConnection();
		LOG.info("TRAZA DE FIN");
	}

	/**
	 * Método que establece la conexión con la base de datos.
	 * 
	 * @throws SQLException
	 */
	private static void stablishMBDConnection() throws SQLException {
		
		LOG.info("TRAZA DE INICIO");
		// Declaración de variables.
		Connection dbConnection = null;
		Statement sentence = null;
		ResultSet queryResult = null;

		try {
			// Se establece el driver de la conexión de la BBDD.
			Class.forName("org.mariadb.jdbc.Driver");

			// Apertura de la conexión (url, usuario, contraseña)
			dbConnection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/education", "root", "123456");
			
			LOG.info("Conexión correcta a la BBDD.");

			// Realización de la consulta.
			sentence = dbConnection.createStatement();
			final String query = "SELECT t.cod_trainer As 'Codigo formador',t.name AS Nombre, surnames AS Apellidos, c.name AS Empresa from trainer t, company c WHERE t.cod_trainer = c.cod_trainer";
			queryResult = sentence.executeQuery(query);

			// Iteración de los reultados.
			StringBuilder trainerInfo = new StringBuilder();
			while (queryResult.next()) {

				trainerInfo.append("\nCódigo formador: ");
				trainerInfo.append(queryResult.getInt("Codigo formador"));

				trainerInfo.append(" | Nombre: ");
				trainerInfo.append(queryResult.getString("Nombre"));

				trainerInfo.append(" | Apellidos: ");
				trainerInfo.append(queryResult.getString("Apellidos"));

				trainerInfo.append(" | Empresa: ");
				trainerInfo.append(queryResult.getString("Empresa"));
			}

			System.out.println(trainerInfo.toString());

		} catch (NullPointerException | SQLException | ClassNotFoundException e) {
			LOG.error("Error en la conexión:{}", e.toString());
			
		} finally {
			
			// Cierre de la conexión de la BBDD.
			closeAllConnection(dbConnection, sentence);
		}
		
		LOG.info("TRAZA FIN");
	}

	/**
	 * Método que cierra la consulta y la conexión a la BBDD.
	 * 
	 * @param dbConnection
	 * @param sentence
	 * @throws SQLException
	 */
	private static void closeAllConnection(Connection dbConnection, Statement sentence) throws SQLException {
		try {

			// Cierre de la sentencia.
			if (sentence != null)
				sentence.close();
			
			LOG.info("Consulta cerrada correctamente.");

		} catch (NullPointerException e) {
			
			LOG.error("Error al cerrar la consulta: {}", e.toString());
			
		} finally {
			
			if (dbConnection != null) {
				try {
					
					// Cierre de conexión con BBDD.
					dbConnection.close();
					
					LOG.info("Conexión a la BBDD cerrada correctamente.");
					
				} catch (SQLException e) {
					
					e.printStackTrace();
					LOG.error("Error al cerrar la BBDD");
				}
			}

		}
	}
}