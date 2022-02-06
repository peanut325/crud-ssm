package service;


import pojo.Employee;

import java.util.List;

public interface EmployeeService {

    /**
     * 查询所有员工信息，带部门信息
     * @return
     */
    public List<Employee> selectAllEmpPage();

    /**
     * 添加员工
     * @param employee
     */
    public void saveEmp(Employee employee);

    /**
     * 校验员工信息
     * @param empName
     * @return true则是校验成功,false则是校验失败
     */
    boolean checkUser(String empName);

    /**
     * 根据empId返回员工信息
     * @param empId
     * @return
     */
    Employee selectEmpById(Integer empId);

    /**
     * 根据员工id修改员工信息
     * @param employee
     */
    void updateEmpById(Employee employee);

    /**
     * 根据id删除员工信息
     * @param empId
     */
    void deleleEmpById(Integer empId);

    /**
     * 批量删除员工信息
     * @param del_ids
     */
    void deleleEmpByIds(List<Integer> del_ids);
}
