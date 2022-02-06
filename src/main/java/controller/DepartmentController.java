package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.Department;
import pojo.Msg;
import service.DepartmentService;

import java.util.List;

/**
 * 处理部门请求
 */
@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg selectDept(){
        List<Department> departmentList=departmentService.selectDept();
        return Msg.success().add("depts",departmentList);
    }
}
