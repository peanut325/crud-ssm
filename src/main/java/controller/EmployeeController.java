package controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import pojo.Employee;
import pojo.Msg;
import service.EmployeeService;
import service.impl.EmployeeServiceImpl;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工请求
 */
@Controller
public class EmployeeController {

    @Autowired
     EmployeeService employeeService;

//    /**
//     * 查询员工数据（分页）
//     * @param pageNum
//     * @param model
//     * @return
//     */
//    @RequestMapping("/")
//    public String selectAllEmpPage(@RequestParam(value = "pageNum",defaultValue = "1") int pageNum, Model model){
//        //引入分页插件,在查询之前需要传入页数和煤业查询的数量
//        PageHelper.startPage(pageNum,5);
//        //调用employeeService进行查询,并返回list员工集合
//        List<Employee> employees = employeeService.selectAllEmpPage();
//        //将查询的结果封装为pageInfo传递到Model中，在创建时设置分页导航为5
//        PageInfo pageInfo=new PageInfo(employees,5);
//        model.addAttribute("pageInfo",pageInfo);
//        return "list";
//    }

    /**
     * 查询员工数据（返回json数据）
     * @param pageNum
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg selectAllEmpPage(@RequestParam(value = "pageNum",defaultValue = "1") int pageNum){
        //引入分页插件,在查询之前需要传入页数和煤业查询的数量
        PageHelper.startPage(pageNum,5);
        //调用employeeService进行查询,并返回list员工集合
        List<Employee> employees = employeeService.selectAllEmpPage();
        //将查询的结果封装为pageInfo传递到Model中，在创建时设置分页导航为5
        PageInfo pageInfo=new PageInfo(employees,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    /**
     * 返回首页
     * @return
     */
    @RequestMapping("/")
    public String index(){
        return "index";
    }

    /**
     * JSR 303后端校验 保存员工信息
     * @param employee
     * @return
     */
    @RequestMapping(value = "/saveEmp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //校验失败，在模块框中显示错误信息
            Map<String,Object> map=new HashMap<>();
            for(FieldError fieldError:result.getFieldErrors()){
                map.put(fieldError.getField(),fieldError.getRejectedValue());
            }
            return Msg.fail().add("errorFields",map);
        }
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    /**
     * 进行员工信息的校验
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkUser")
    public Msg checkUser(@RequestParam("empName") String empName){
        //1.后端先进行用户名是否合法校验
        String regEx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regEx)) {
            return Msg.fail().add("va_msg", "用户名必须是2-5位中文或者6-16位英文和数字的组合");
        }
        //2.进行数据库校验
        boolean b=employeeService.checkUser(empName);
        if (b==true){
            return Msg.success();
        }
        return Msg.fail().add("va_msg", "用户名不可用");
    }

    /**
     * 根据员工id返回员工信息
     * @param empId
     * @return
     */
    @RequestMapping(value = "/emps/{empId}",method = RequestMethod.GET)
    @ResponseBody
    public Msg selectEmpById(@PathVariable(value = "empId")Integer empId){
        Employee employee=employeeService.selectEmpById(empId);
        return Msg.success().add("emp",employee);
    }

    /**
     * 根据员工id修改员工信息
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emps/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmpById(Employee employee){
        System.out.println(employee);
        employeeService.updateEmpById(employee);
        return Msg.success();
    }

    @RequestMapping(value = "/emps/{empIds}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable(value = "empIds")String empIds){
        if(empIds.contains("-")){
            String[] strIds=empIds.split("-");
            //组装empids数组
            List<Integer> del_ids=new ArrayList<>();
            for(String strId:strIds){
                del_ids.add(Integer.parseInt(strId));
            }
            employeeService.deleleEmpByIds(del_ids);
        }else{
            int empId = Integer.parseInt(empIds);
            employeeService.deleleEmpById(empId);
        }
        return Msg.success();
    }
}
