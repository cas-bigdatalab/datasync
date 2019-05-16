package cn.csdb.drsr.utils.sync;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class SYNCSQLUtils {

    /**
     * generate a ddl sql from tables
     */
    public static String generateDDLFromTable(Connection jdbcConnection, String catalog, String schema,
                                        String table) {
        StringBuilder sb = new StringBuilder();
        boolean portalIdExist = portalIdExist(jdbcConnection, table, "table");
        sb.append("DROP TABLE IF EXISTS " + table + "_bak ; \n");
        sb.append("CREATE TABLE " + table + "_bak (");

        try {
            DatabaseMetaData meta = jdbcConnection.getMetaData();
            ResultSet res = meta.getColumns(catalog, schema, table, null);

            while (res.next()) {
                String name = res.getString("COLUMN_NAME");
                String type = res.getString("TYPE_NAME");
                boolean nullable = "1".equals(res.getString("NULLABLE"));
                int size = res.getInt("COLUMN_SIZE");

                int chiffresApresVirgule = 0;
                if ((type.equalsIgnoreCase("NUMBER")) || (type.equalsIgnoreCase("NUMERIC"))
                        || (type.equalsIgnoreCase("DECIMAL"))) {
                    type = "NUMERIC";
                    chiffresApresVirgule = res.getInt("DECIMAL_DIGITS");
                } else if (type.equalsIgnoreCase("VARCHAR2")) {
                    type = "VARCHAR";
                } else if (type.equalsIgnoreCase("DATE")) {
                    type = "DATETIME";
                } else if (type.startsWith("TIMESTAMP")) {
                    if (!type.contains("(")) {
                        type = "TIMESTAMP(6)";
                    }

                    if (!nullable) {
                        type = type + " NOT NULL DEFAULT 0";
                        nullable = true;
                    } else {
                        type = type + " NULL DEFAULT NULL";
                    }
                }

                sb.append("\n" + name);
                if ((type.startsWith("VARCHAR")) || (type.equals("CHAR")) || (type.equals("NUMBER"))
                        || (type.equals("NUMERIC")) || (type.equals("BLOB"))) {
                    if (chiffresApresVirgule == 0)
                        sb.append(" " + type + "(" + size + ")");
                    else
                        sb.append(" " + type + "(" + size + "," + chiffresApresVirgule + ")");
                } else {
                    sb.append(" " + type);
                }

                if (!nullable) {
                    sb.append(" NOT NULL");
                }

                sb.append(",");
            }
            if(portalIdExist){
                sb.append("PORTALID VARCHAR(36) COMMENT '中心端系统ID',");
            }
        } catch (Exception e) {
            System.out.println(
                    "Error: could not retrieve column metadata for the table '" + table + "' from the backend.");
            e.printStackTrace();
            return "";
        }
        sb.append(generatePKsDdl(jdbcConnection, catalog, schema, table));
        if (sb.toString().endsWith(",")){
            sb.replace(sb.length()-1,sb.length()," ");
        }
        sb.append("\n);");
        sb.append("\n\n");
        return sb.toString();
    }

    /**
     * get the PK string
     */
    private static String generatePKsDdl(Connection jdbcConnection, String catalog, String schema, String table) {
        StringBuilder sb = new StringBuilder();
        try {
            List<String> pks = getPKs(jdbcConnection, catalog, schema, table);
            DatabaseMetaData meta = jdbcConnection.getMetaData();
            ResultSet res = meta.getColumns(catalog, schema, table, null);
            sb.append("PRIMARY KEY(");
            int n = pks.size();
            while ((n > 0) && (res.next())) {
                String name = res.getString("COLUMN_NAME");
                if (pks.contains(name)) {
                    sb.append(name);
                    n--;
                    if (n > 0) {
                        sb.append(", ");
                    }
                }
            }
            res.close();
            sb.append(")");
        } catch (Exception e) {
            System.out.println(
                    "Error: could not retrieve column PK metadata for the table '" + table + "' from the backend.");
            e.printStackTrace();
            return sb.toString();
        }
        if (sb.toString().equals("PRIMARY KEY()")){
            return "";
        }
        return sb.toString();
    }

    /**
     *  get Primary Key List
     */
    private static List<String> getPKs(Connection jdbcConnection, String catalog, String schema, String table) {
        List<String> pks = new ArrayList<String>();
        try {
            DatabaseMetaData meta = jdbcConnection.getMetaData();
            ResultSet res = meta.getPrimaryKeys(catalog, schema, table);
            while (res.next())
                pks.add(res.getString(4));
        } catch (Exception e) {
            System.out.println(
                    "Error: could not retrieve column PK metadata for the table '" + table + "' from the backend.");
            throw new RuntimeException(e);
        }
        return pks;
    }


    /**
     * get the ddl from a sql string
     */
    public static String generateDDLFromSql(Connection jdbcConnection, String sql, String logicTable) {
        StringBuilder sb = new StringBuilder();
        try {
            boolean portalIdExist = portalIdExist(jdbcConnection, sql, "sql");
            sb.append("DROP TABLE IF EXISTS " + logicTable + "_bak ;\n ");
            sb.append("CREATE TABLE " + logicTable + "_bak(");
            DatabaseMetaData meta = jdbcConnection.getMetaData();
            PreparedStatement preparedStatement = jdbcConnection.prepareStatement(sql);
            ResultSet res = preparedStatement.executeQuery();
            ResultSetMetaData metaData = res.getMetaData();

            int columnCount = metaData.getColumnCount();
            for (int index = 1; index <= columnCount; index++) {
                String columnLabel = metaData.getColumnLabel(index);
                String name = metaData.getColumnName(index);
                String tableName = metaData.getTableName(index);
                int size = metaData.getColumnDisplaySize(index);
                if (size > 2000)
                    size = 2000;
                boolean nullable = "1".equals(String.valueOf(metaData.isNullable(index)));
                String type = metaData.getColumnTypeName(index);

                int chiffresApresVirgule = 0;
                if ((type.equalsIgnoreCase("NUMBER")) || (type.equalsIgnoreCase("NUMERIC"))
                        || (type.equalsIgnoreCase("DECIMAL"))  || (type.equalsIgnoreCase("FLOAT"))   || (type.equalsIgnoreCase("DOUBLE"))    ) {
                    type = "NUMERIC";
                    chiffresApresVirgule = metaData.getScale(index);
                } else if (type.equalsIgnoreCase("VARCHAR2")) {
                    type = "VARCHAR";
                } else if (type.equalsIgnoreCase("DATE")) {
                    type = "DATETIME";
                } else if (type.startsWith("TIMESTAMP")) {
                    if (!type.contains("(")) {
                        type = "TIMESTAMP(6)";
                    }

                    if (!nullable) {
                        type = type + " NOT NULL DEFAULT 0";
                        nullable = true;
                    } else {
                        type = type + " NULL DEFAULT NULL";
                    }
                }

                //xiajl2018 去除重复列
                StringBuilder ss = new StringBuilder();
                ss.append("\n" + name);
                //sb.append("\n" + name);
                if ((type.startsWith("VARCHAR")) || (type.equals("CHAR")) || (type.equals("NUMBER"))
                        || (type.equals("NUMERIC")) || (type.equals("BLOB"))) {
                    if (chiffresApresVirgule == 0)
                        //sb.append(" " + type + "(" + size + ")");
                        ss.append(" " + type + "(" + size + ")");
                    else
                        //sb.append(" " + type + "(" + size + "," + chiffresApresVirgule + ")");
                        ss.append(" " + type + "(" + size + "," + chiffresApresVirgule + ")");
                } else {
                    //sb.append(" " + type);
                    ss.append(" " + type);
                }


                if (!nullable) {
                    //sb.append(" NOT NULL");
                    ss.append(" NOT NULL");
                }
                ss.append(",");
                //sb.append(",");
                if (sb.toString().contains(ss.toString()))
                {
                    //把列名变成 a_copy
                    String tempStr = ss.toString();
                    String result =tempStr.replace(name,name+"copy");
                    //System.out.println(ss.toString());
                    sb.append(result);
                }
                else
                {
                    sb.append(ss.toString());
                }
            }
            if (sb.toString().endsWith(",")) {
                sb.replace(sb.length()-1, sb.length(), " ");
            }
            if(portalIdExist){
                sb.append(", \nPORTALID VARCHAR(36) COMMENT '中心端系统ID'");
            }
            sb.append("\n);\n");

        } catch (Exception e) {
            e.printStackTrace();
            return sb.toString();
        }
        return sb.toString();
    }

    /**
     * generate Insert data Sql from a SQL string
     */
    public static String generateInsertSqlFromSQL(Connection jdbcConnection,  String sql, String logicTable) {
        StringBuilder result = new StringBuilder();
        try {
            boolean portalIdExist = portalIdExist(jdbcConnection, sql, "sql");
            PreparedStatement stmt = jdbcConnection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();

            while (rs.next()) {
                result.append("INSERT INTO " + logicTable + "_bak VALUES (");
                for (int i = 0; i < columnCount; i++) {
                    if (i > 0) {
                        result.append(", ");
                    }
                    Object value = rs.getObject(i + 1);
                    if (value == null) {
                        result.append("NULL");
                    } else {
                        String outputValue = value.toString();
                        outputValue = outputValue.replaceAll("'", "''");
                        result.append("'" + outputValue + "'");
                    }
                }
                if(portalIdExist){
                    String s = UUID.randomUUID().toString();
                    result.append(",'" + s + "'");
                }
                result.append(");\n");
            }


            rs.close();
            stmt.close();
            //System.out.println(result.toString());
        } catch (SQLException e) {
            System.out.println("Error: could not retrieve data for the sql '" + sql + "' from the backend.");
            e.printStackTrace();
            return "";
        }
        return result.toString();
    }


    /**
     * generate Insert Data Sql from a  table
     */
    public static String generateInsertSqlFromTable(Connection jdbcConnection, String catalog, String schema, String table) {
        StringBuilder result = new StringBuilder();
        //result.append("DELETE FROM " + table + ";");
        try {
            boolean portalIdExist = portalIdExist(jdbcConnection, table, "table");
            PreparedStatement stmt = jdbcConnection.prepareStatement("SELECT * FROM " + table);
            ResultSet rs = stmt.executeQuery();
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            while (rs.next()) {
                result.append("INSERT INTO " + table + "_bak (");
                for (int j = 1; j <= columnCount; j++) {
                    result.append(metaData.getColumnLabel(j) + ",");
                }
                if (portalIdExist) {
                    result.replace(result.length() - 1, result.length(), ",PORTALID)");
                } else {
                    result.replace(result.length() - 1, result.length(), ")");
                }
                result.append("VALUES (");
                for (int i = 0; i < columnCount; i++) {
                    if (i > 0) {
                        result.append(", ");
                    }
                    Object value = rs.getObject(i + 1);
                    if (value == null) {
                        result.append("NULL");
                    } else {
                        String outputValue = value.toString();
                        outputValue = outputValue.replaceAll("'", "''");
                        result.append("'" + outputValue + "'");
                    }
                }
                if (portalIdExist) {
                    result.append(",'" + UUID.randomUUID().toString() + "'");
                }
                result.append(");\n");
            }
            rs.close();
            stmt.close();
            //System.out.println(result.toString());
        } catch (SQLException e) {
            System.out.println("Error: could not retrieve data for the table '" + table + "' from the backend.");
            e.printStackTrace();
            return "";
        }
        return result.toString();
    }


    public static boolean generateFile(String path, String FileName, String body) {
        try {
            File f = new File(path);
            if (!f.exists()) {
                f.mkdirs();
            }
            path = path +File.separator + FileName;
            f = new File(path);
            PrintWriter out;
            out = new PrintWriter(f,"UTF-8");
            out.print(body +"\n");
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private static boolean portalIdExist(Connection jdbcConnection, String string, String type) {
        String sql = "";
        if ("table".equals(type)) {
            sql = "DESC " + string;
        } else {
            sql = string;
        }
        boolean k = true;
        try {
            PreparedStatement preparedStatement = jdbcConnection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columnCount = metaData.getColumnCount();
            for (int i = 1; i <= columnCount; i++) {
                String columnName = metaData.getColumnName(i);
                if ("PORTALID".equals(columnName)) {
                    k = false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return k;
    }
}