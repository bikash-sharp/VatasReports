using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using Vatas_Common;
using Vatas_DAL;

namespace Vatas_BAL
{
    public sealed class BLPath : BLCommon
    {
        private static readonly BLPath _instance;
        private static AdminEntities _context;

        static BLPath()
        {
            _instance = new BLPath();
        }

        private BLPath()
        {

        }

        public static BLPath Instance(AdminEntities context)
        {
            _context = context;
            return _instance;
        }

        public List<PathCL> GetAllPath()
        {
            List<PathCL> paths = new List<PathCL>();
            try
            {
                paths = _context.tbl_Path.ToList().Select(p =>
                           new PathCL
                           {
                               PathID = p.Path_ID,
                               PathName = p.Path_Name,
                               Host = p.Host,
                               Path = p.Path,
                               PathProject = p.Path_Project
                           }).ToList();
                return paths;
            }
            catch (Exception ex)
            {
                return paths;
            }
        }

        public bool IsPathAlreadyExist(PathCL Path)
        {
            try
            {
                return false;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool AddUpdatePath(PathCL path)
        {
            try
            {
                _context.proc_AddUpdatePathByPathId(path.PathID, path.PathName, path.Host, path.Path, path.PathProject);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public List<DropDownCL> GetAllProject()
        {
            List<DropDownCL> result = new List<DropDownCL>();
            try
            {
                result = _context.tbl_Project.ToList().Select(p => new DropDownCL
                {
                    DataText = p.Project_Name + "",
                    DataValue = p.Project_ID + ""
                }).ToList();
            }
            catch (Exception ex)
            {
                var error = ex.Message;
            }
            return result;
        }

        public bool IsProjectAlreadyExist(string projectName)
        {
            try
            {
                var result = _context.tbl_Project.Where(s => s.Project_Name == projectName).FirstOrDefault();
                if (result != null)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool AddUpdateProject(int projectId, string projectName)
        {
            try
            {
                _context.proc_AddUpdateProjectByProjectId(projectId, projectName);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

    }
}
