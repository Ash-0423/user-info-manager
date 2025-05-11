using Microsoft.Data.SqlClient;
using System.Data;

namespace UserInfoManager.Data;

public class AdoNetHelper
{
    private readonly string _connectionString;

    public string ConnectionString => _connectionString;

    public AdoNetHelper(string connectionString)
    {
        _connectionString = connectionString;
    }

    // 执行查询并返回 DataTable
    public DataTable ExecuteDataTable(string sql, CommandType commandType, params SqlParameter[] parameters)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            using (SqlCommand command = new SqlCommand(sql, connection))
            {
                command.CommandType = commandType;
                if (parameters != null)
                {
                    command.Parameters.AddRange(parameters);
                }

                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return dataTable;
            }
        }
    }

    // 执行非查询命令（INSERT, UPDATE, DELETE）
    public int ExecuteNonQuery(string sql, CommandType commandType, params SqlParameter[] parameters)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            connection.Open();
            using (SqlCommand command = new SqlCommand(sql, connection))
            {
                command.CommandType = commandType;
                if (parameters != null)
                {
                    command.Parameters.AddRange(parameters);
                }

                return command.ExecuteNonQuery();
            }
        }
    }

    // 执行查询并返回单个值
    public object ExecuteScalar(string sql, CommandType commandType, params SqlParameter[] parameters)
    {
        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            connection.Open();
            using (SqlCommand command = new SqlCommand(sql, connection))
            {
                command.CommandType = commandType;
                if (parameters != null)
                {
                    command.Parameters.AddRange(parameters);
                }

                return command.ExecuteScalar();
            }
        }
    }

    // 执行查询并返回 SqlDataReader
    public SqlDataReader ExecuteReader(string sql, CommandType commandType, params SqlParameter[] parameters)
    {
        SqlConnection connection = new SqlConnection(_connectionString);
        connection.Open();
        SqlCommand command = new SqlCommand(sql, connection);
        command.CommandType = commandType;
        if (parameters != null)
        {
            command.Parameters.AddRange(parameters);
        }

        // 使用 CommandBehavior.CloseConnection 确保 DataReader 关闭时连接也关闭
        return command.ExecuteReader(CommandBehavior.CloseConnection);
    }
}
