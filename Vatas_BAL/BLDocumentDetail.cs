using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Vatas_Common;
using Vatas_DAL;

namespace Vatas_BAL
{
    public sealed class BLDocumentDetail
    {
        private static readonly BLDocumentDetail _instance;
        private static AdminEntities _admin;
        static BLDocumentDetail()
        {
            _instance = new BLDocumentDetail();
        }

        private BLDocumentDetail()
        {

        }

        /// <summary>
        /// creates object of the class
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public static BLDocumentDetail Instance(AdminEntities context)
        {
            _admin = context;
            return _instance;
        }

        public bool SaveDocumentFiles(long ServiceId, List<FileUploadCL> documentFiles)
        {
            bool result = false;
            try
            {
                DataTable dtDocumentFiles = new DataTable("tbl_UserDocumentDetails");
                //creating columns for DataTable  
                dtDocumentFiles.Columns.Add(new DataColumn("DocumentTableId", typeof(long)));
                dtDocumentFiles.Columns.Add(new DataColumn("FileName", typeof(string)));
                dtDocumentFiles.Columns.Add(new DataColumn("FolderPath", typeof(string)));
                dtDocumentFiles.Columns.Add(new DataColumn("DisplayAs", typeof(string)));
                dtDocumentFiles.Columns.Add(new DataColumn("IsValid", typeof(Boolean)));
                dtDocumentFiles.Columns.Add(new DataColumn("DateAdded", typeof(DateTime)));
                foreach (var item in documentFiles)
                {
                    DataRow dr = dtDocumentFiles.NewRow();
                    dr["DocumentTableId"] = ServiceId;
                    dr["IsValid"] = false;
                    dr["FileName"] = item.fileName;
                    dr["DisplayAs"] = item.displayAs;
                    dr["FolderPath"] = item.folderpath;
                    dr["DateAdded"] = DateTime.Now;
                    dtDocumentFiles.Rows.Add(dr);
                }
                dtDocumentFiles.AcceptChanges();
                var ConnStr = _admin.Database.Connection.ConnectionString;
                using (SqlConnection con = new SqlConnection(ConnStr))
                {
                    if (con.State != ConnectionState.Open)
                        con.Open();
                    using (SqlBulkCopy objbulk = new SqlBulkCopy(ConnStr, SqlBulkCopyOptions.KeepIdentity))
                    {
                        //assigning Destination table name  
                        objbulk.DestinationTableName = "tbl_UserDocumentDetails";
                        //Mapping Table column  
                        objbulk.ColumnMappings.Add("DocumentTableId", "DocumentTableId");
                        objbulk.ColumnMappings.Add("FileName", "FileName");
                        objbulk.ColumnMappings.Add("FolderPath", "FolderPath");
                        objbulk.ColumnMappings.Add("DisplayAs", "DisplayAs");
                        objbulk.ColumnMappings.Add("IsValid", "IsValid");
                        objbulk.ColumnMappings.Add("DateAdded", "DateAdded");
                        //inserting bulk Records into DataBase   
                        objbulk.WriteToServer(dtDocumentFiles);
                    }
                    if (con.State != ConnectionState.Closed)
                        con.Close();
                }
                result = true;
            }
            catch (Exception ex)
            {
                var err = ex;
            }
            return result;
        }

        public UserDocumentDetailCL GetUserDocumentDetail(long DocumentId)
        {
            UserDocumentDetailCL result = new UserDocumentDetailCL();
            try
            {
                string Query = "EXEC proc_GetDocumentDetailById @Id = '"+DocumentId+"'";
                var resultSet = _admin
                .MultipleResults(Query)
                .With<UserDocumentDetailCL>()
                .Execute();
                result = (resultSet[0] as List<UserDocumentDetailCL>).FirstOrDefault();
            }
            catch (Exception ex)
            {
                var err = ex;
                result = null;
            }
            return result;  
        }
    }
}
