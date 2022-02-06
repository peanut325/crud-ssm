<%--
  Created by IntelliJ IDEA.
  User: peanut
  Date: 2021/11/28
  Time: 12:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%--  远程引入  --%>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>SSM-CRUD</title>
</head>
<body>

<!-- 新增员工信息的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel" >添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="xxx">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="W"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="xxx@xxx.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <!--传送部门id即可-->
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!--修改员工信息的模态框-->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">修改员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="W"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="xxx@xxx.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <!--传送部门id即可-->
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>

    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>

    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_tables">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>编号</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <!-- 显示分页信息 -->
    <div class="row">
        <!--分页文字信息  -->
        <div class="col-md-6" id="page_info_area">
        </div>
        <!-- 分页条信息 -->
        <div class="col-md-6" >
            <nav aria-label="Page navigation" id="page_nav_area">
                <ul class="pagination">

                </ul>
            </nav>
        </div>
    </div>
</div>
    <script type="text/javascript">
        //定义全局变量返回最后一页和当前页码
        let totalPages,currentPage;

        //页面加载完成之后，发送ajax请求获取，获取分页数据
        //先去首页
        /**
         * 页面加载完成以后直接去首页
         */
        $(function () {
            //去首页
            to_page(1);
        });

        //跳转页面
        function to_page(pn){
            $.ajax({
                url:"emps",
                data:"pageNum="+pn,
                type:"GET",
                success:function (result) {
                    //解析并显示员工数据
                    build_emps_table(result);
                    //解析并显示分页信息
                    build_page_info(result);
                    //解析并显示分页条数据
                    build_page_nav(result);
                }
            }) ;
        }


        $(function () {
           $.ajax({
               url:"emps",
               data:"pageNum=1",
               type:"GET",
               success:function (result) {
                   //解析并显示员工数据
                   build_emps_table(result);
                   //解析并显示分页信息
                   build_page_info(result);
                   //解析并显示分页条数据
                   build_page_nav(result);
               }
           }) ;
        });

        function build_emps_table(result){
            //先进行清空
            $("#emps_tables tbody").empty();
            var emps=result.extend.pageInfo.list;
            $.each(emps,function (index,item){
                var checkBoxTd=$("<td> <input type='checkbox' class='check_item'/> </td>")
                var empIdTd=$("<td></td>").append(item.empId);
                var empNameTd=$("<td></td>").append(item.empName);
                var genderTd=$("<td></td>").append(item.gender=="M"?"男":"女");
                var emailTd=$("<td></td>").append(item.email);
                var deptNameTd=$("<td></td>").append(item.department.deptName);
                var editBtn=$("<buttton></buttton>").addClass("btn btn-success btn-sm edit_btn").
                append($("<span></span>")).addClass("glyphicon glyphicon-pencil").append("编辑");
                var delBtn=$("<buttton></buttton>").addClass("btn btn-warning btn-sm delete_btn").
                append($("<span></span>")).addClass("glyphicon glyphicon-trash").append("删除");
                //为编辑按钮添加一个自定义的属性，来表示当前员工id
                editBtn.attr("edit-id",item.empId);
                //为删除按钮添加一个自定义属性，来表示当前员工id
                delBtn.attr("del-id",item.empId);
                //删除和编辑按钮只占一列
                var bntTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
                //append方法执行完成后还是返回原来的元素
                $("<tr></tr>").
                append(checkBoxTd).
                append(empIdTd).
                append(empNameTd).
                append(genderTd).
                append(emailTd).
                append(deptNameTd).
                append(bntTd).
                appendTo("#emps_tables tbody");
            });
        }

        function  build_page_info(result){
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+ result.extend.pageInfo.pageNum+"页,总"+ result.extend.pageInfo.pages+"页,总"+ result.extend.pageInfo.total+"条记录")
            totalPages=result.extend.pageInfo.pages;
            currentPage=result.extend.pageInfo.pageNum;
        }

        function build_page_nav(result) {
            //先清空分页条数据
            $("#page_nav_area").empty();
            //添加首页和前一页
            let ul = $("<ul></ul>").addClass("pagination");
            let firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
            let prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            //如果已经是首页，则禁用首页和前一页
            if (result.extend.pageInfo.hasPreviousPage == false) {
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            } else {
                //为元素添加翻页点击事件
                firstPageLi.click(function () {
                    to_page(1);
                });
                prePageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum - 1)
                });
            }
            ul.append(firstPageLi).append(prePageLi);
            //添加页码提示
            $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
                let numLi = $("<li></li>").append($("<a></a>").append(item));
                if (result.extend.pageInfo.pageNum == item) {
                    numLi.addClass("active");
                }
                //绑定单击事件，去指定页
                numLi.click(function () {
                    to_page(item);
                });
                ul.append(numLi);
            });
            //添加下一页和末页
            let nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            let lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
            //如果已经是末页，则禁用下一页和末页
            if (result.extend.pageInfo.hasNextPage == false) {
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            } else {
                //为元素添加翻页点击事件
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum + 1);
                });
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);
                });
            }
            ul.append(nextPageLi).append(lastPageLi);
            let navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }

        //绑定增加员工单击事件
        $("#emp_add_model_btn").click(function () {
            //清除表单数据(表单内容和样式进行重置),调用DOM对象的reset方法
            reset_form("#empAddModal form");
            //发送ajax请求，查询部门信息在下拉列表中
            getDepts("#dept_add_select");
            //调用新增模块框
            $("#empAddModal").modal({
               backdrop:"static"
            });
        });

        /**
         * 重置表单的内容和样式
         */
        function reset_form(ele) {
            //拿到DOM对象，调用reset方法，清空内容
            $(ele)[0].reset();
            //清空样式
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }

        //使用ajax请求获取部门信息
        function getDepts(ele) {
            //先清空下拉列表的值，再发送请求
            $(ele).empty();
            $.ajax({
                url:"depts",
                type:"GET",
                success:function (result) {
                    $.each(result.extend.depts, function () {
                        $("<option></option>").append(this.deptName).attr("value", this.deptId).appendTo(ele);
                    });
                }
            })
        }

        //发送ajax POST请求新增员工信息
        /**
         * 新增用户数据，点击保存按钮
         */
        $("#emp_save_btn").click(function () {
            //1、前端 jQuery 校验数据格式
            if (!validate_add_form()) {
                return false;
            }

            //2.判断之前ajax用户名校验是否成功,失败则不进行下边操作
            if($(this).attr("ajax-va")=="error"){
                return false;
            }

            //3.发送ajax POST保存新增员工信息
            $.ajax({
                url:"saveEmp",
                type:"POST",
                //serialize表单序列化
                data:$("#empAddModal form").serialize(),
                success:function (result) {
                    if(result.code==100){
                        //保存成功,关闭模块框，来到最后一页
                        $("#empAddModal").modal('hide');
                        to_page(totalPages+1);
                    }else{
                        //显示失败信息,有哪个字段的错误信息就显示哪个字段的
                        if(undefined!=result.extend.errorFields.email){
                            //显示邮箱错误信息
                            show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                        }
                        if(undefined!=result.extend.errorFields.email){
                            //显示用户名错误信息
                            show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                        }
                    }
                }

            })
        });

        /**
         * 后台校验结果显示
         */
        $("#empName_add_input").change(function (){
            var empName=this.value;
           $.ajax({
               url:"checkUser",
               data:"empName="+empName,
               type:"GET",
               success(result){
                   if(result.code==100){
                       show_validate_msg("#empName_add_input", "success", "用户名可用");
                        $("#emp_save_btn").attr("ajax-va","success");
                   }else{
                       show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                       $("#emp_save_btn").attr("ajax-va","error");
                   }
               }
           }) ;
        });

        /**
         * 显示校验结果的提示信息
         */
        function show_validate_msg(ele, status, msg) {
            //清除当前元素的校验状态
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if ("success" == status) {
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            } else if ("error" == status) {
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }

        /**
         * 前端 jQuery 校验表单数据是否合法（使用正则表达式）
         */
        function validate_add_form(){
            //1.校验姓名
            var empName=$("#empName_add_input").val();
            var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;;
            if (!regName.test(empName)) {
                show_validate_msg("#empName_add_input", "error", "用户名必须是2-5位中文或者6-16位英文和数字的组合");
                return false;
            } else {
                show_validate_msg("#empName_add_input", "success", "");
            }
            //校验邮箱
            let email = $("#email_add_input").val();
            let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)) {
                show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
                return false;
            } else {
                show_validate_msg("#email_add_input", "success", "");
            }
            return true;
        }

        /**
         * 返送ajax请求返回员工信息
         */
        function getEmps(id){
            $.ajax({
                url:"emps/"+id,
                type:"GET",
                success:function (result){
                    let empData = result.extend.emp;
                    $("#empName_update_static").text(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#dept_update_select").val([empData.dId]);
                }
            });
        }

        /**
         * 点击编辑按钮，回显数据，弹出模态框
         */
        $(document).on("click", ".edit_btn", function () {
            //1、查询部门和员工的信息，回显
            getDepts("#dept_update_select");
            //2.根据id查询员工信息
            getEmps($(this).attr("edit-id"));
            //3.把员工id传递给静态框的更新按钮
            $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"))
            //4、弹出模态框
            $("#empUpdateModal").modal({
                backdrop: "static"
            })
        });

        /**
         * 点击更新按钮，更新用户信息
         */
        $("#emp_update_btn").click(function () {
            //1、校验邮箱是否合法
            let email = $("#email_update_input").val();
            let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)) {
                show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
                return false;
            } else {
                show_validate_msg("#email_update_input", "success", "");
            }
            //2、发送 Ajax 请求更新员工信息
            //2、发送 Ajax 请求更新员工信息
            $.ajax({
                url: "emps/" + $(this).attr("edit-id"),
                type: "PUT",
                data: $("#empUpdateModal form").serialize(),
                success: function (result) {
                    //关闭对话框，回到本页面
                    $("#empUpdateModal").modal('hide');
                    to_page(currentPage);
                }
            });
        });

        /**
         * 点击单个删除按钮，弹出提示框
         */
        $(document).on("click", ".delete_btn", function () {
            //1.弹出提示框
            var empName= $(this).parents("tr").find("td:eq(1)").text();
            if(confirm("确认删除【"+empName+"】吗？")){
                //2.确认则发送ajax请求
                $.ajax({
                    url:"emps/"+$(this).attr("del-id"),
                    type:"DELETE",
                    success:function (result){
                        alert(result.msg);
                        to_page(currentPage);
                    }
                })
            }
        });
        /**
         * 全选，全部选按钮
         */
        $("#check_all").click(function () {
            //dom 原生的属性用 prop 获取，自定义的属性用 attr 获取
           $(".check_item").prop("checked",$(this).prop("checked"));
        });

        /**
         * 全选效果联动
         */
        $(document).on("click",".check_item",function () {
            var flag=$(".check_item:checked").length==$(".check_item").length;
            $("#check_all").prop("checked",flag);
        })

        /**
         * 点击全部删除按钮，实现批量删除功能
         */
        $("#emp_delete_all_btn").click(function (){
            var empNames="";
            var del_idstr="";
            $.each($(".check_item:checked"),function (){
               empNames+=$(this).parents("tr").find("td:eq(2)").text()+"," ;
               //组装员工id字符串
                del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-" ;
            });
            //去除empNames多余的，
            empNames=empNames.substring(0, empNames.length - 1);
            //取出删除的id多余的-
            del_idstr=del_idstr.substring(0, del_idstr.length - 1);
            if(confirm("确认删除【"+empNames+"】吗？")){
                //发送ajax请求进行批量删除
                $.ajax({
                   url:"emps/"+del_idstr,
                    type:"DELETE",
                    success:function (result){
                        alert(result.msg);
                        //返回当前页面
                        to_page(currentPage);
                    }
                });
            }
        });
    </script>
</body>
</html>
