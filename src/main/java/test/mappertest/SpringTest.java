package test.mappertest;





import dao.DepartmentMapper;
import dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import pojo.Department;
import pojo.Employee;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations ={"classpath:applicationContext.xml"})
public class SpringTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSessionTemplate sqlSessionTemplate;
    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);

        //插入几个部门
//        departmentMapper.insertSelective(new Department(null,"产品销售部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
        //插入一个员工
//        employeeMapper.insertSelective(new Employee(null,1,"liujialin","M","liujialin@qq.com"));

        //批量插入员工
        EmployeeMapper mapper = sqlSessionTemplate.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String substring = UUID.randomUUID().toString().substring(0, 5)+i;
            mapper.insertSelective(new Employee(null,1,substring,"M",substring+"@qq.com"));
        }
    }
}
