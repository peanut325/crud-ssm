package service;

import pojo.Department;

import java.util.List;

public interface DepartmentService {
    /**
     * 查询所有部门信息
     * @return
     */
    List<Department> selectDept();
}
