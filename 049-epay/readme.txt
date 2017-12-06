

001
	1)指定工作空间字符集编码方式为UTF-8
	
	2)搭建ssm开发环境
		-拷贝相关jar包
		-配置web.xml文件
			*监听器:在web服务器启动阶段,该监听器实例会被创建
				实现了ServletContextListener,在ServletContext对象创建或者销毁的时候,会执行监听器中方法;主要作用是解析spring配置文件 
			*过滤器:解决post请求中文乱码的过滤器
			中央处理器:中央处理器:接收客户端发送的请求,交给对应的处理器进行处理,将处理器返回结果响应给相应的客户端;默认情况下,
						springmvc会去WEB-INF目录找[servlet-name]-servlet.xml这个文件进行解析,但是一般我们会通过手动指定的方式,
						指定springmvc配置文件的路径,尽量让springmvc的配置文件的形式和spring配置文件的形式一致 
			
		*配置spring相关的文件
			数据源
			sessionFactory
			事务管理器
			通知
			切入		
	
	3)ssm集成原理
		关于ssm的集成,其实只是spring和mybatis的集成,因为springMVC本身就是spring的一部分
		spring提供了IOC控制反转的功能,mybatis的sessionFactory的创建交给spring框架维护,以及对象之间关系的维护,也由程序员转给IOC容器
		spring提供了AOP的功能,mybatis的事务不需要程序员编写代码处理,只需要在配置文件中做些简单的配置即可..
		
		IOC和DI的关系
			IOC叫控制反转,是一种编程思想;DI叫依赖注入 ,是IOC的具体实现
				
002
	1)根据PDM(物理数据模型),创建权限相关的实体类
	
		
003
	1)创建权限功能中许可维护相关的dao和service
		-创建dao接口
		-编写dao接口对应的mapper文件，注意映射文件中的namespace必须指向接口
		-在mybatis主配置文件中配置别名及避免空值插入的处理
		-在spring-base配置文件中配置mapper扫描器，通过代理创建dao接口的实现类；同时指定映射文件的路径
		-创建service接口以及对应的实现类
		-创建spring专门配置service的配置文件 
	
004
	1)在PermissionServiceImpl中的getPermissionTree()方法中拼接json格式字符串，返回String类型
		
	2)关于字符串拼接的技术选型(String,StringBuilder,StringBuffer)
		-String,StringBuilder,StringBuffer底层都是char数组		
		-String是不可变的字符序列 ,任何对字符串的修改操作都会创建新的对象,所以如果在做大数据量字符串拼接的时候,不适合使用
		-StringBuilder,StringBuffer是可变的字符序列
			*默认情况下,初始化长度都是16
			*如果长度不够的话,扩容的新长度为    原长度* 2 + 2(1.7)    (原长度+1)*2(1.6)
			*底层使用扩容方式是数组的拷贝   System.arraycopy(),该方法前用native修改,属于本地方法调用JNI(Java Native Invoke),
				表示的是该方法的底层调用了其它语言编写的dll文件
			*优化:可以指定初始化长度  减少扩容次数,减少数组拷贝的次数 
			*StringBuffer  @since   JDK1.0  比较老  所有方法都用synchronized修改,表示线程同步,是线程安全的,效率低,并发性低
			*StringBuilder @since       1.5  比较新    非线程安全的   效率高,并发性好
			
	3)关于线程安全
		-多线程环境下
		-有共享数据
		-对共享数据涉及DML操作
		
		以上三个条件都满足的情况下,才需要考虑线程安全的问题
		
		栈区:一个线程一个栈,栈是线程安全的     所以局部变量不涉及线程安全问题
		堆区:被多个线程共享,所以实例变量存在线程安全问题
		方法区:被多个线程共享,所以静态变量存在线程安全问题
		
	4)一旦出现线程安全问题,如何解决
		-尽量使用局部变量
		-如果使用了实例变量,加synchronized关键字,让线程同步 
			*可以加在方法上
			*代码块(推荐)
		-如果使用了实例变量,可以让对象变成多例
		
	5)结论:
		如果加synchronized,效率低,并发性差
		如果使用多例,浪费堆内存
		所以使用局部变量的StringBuilder进行字符串的拼接
		
005
	1)对上述编写的service代码进行单元测试
		-单元测试属于白盒测试
		-单元测试一般由开发人员编写,有的时候还需要编写单元测试报告
		-单元测试为了集成测试做准备的
		-单元测试我们这里使用junit框架
			*一般测试类名    被测试的类名+Test
			*一般测试方法名  test+被测试的方法名
		-单元测试有一个断言机制  实际值和期望值的比较
		
		-spring框架提供了对单元测试的支持  	
			
006
	1)集成epay项目的页面原型
	
	2)关于页面中的路径
		-如果在本地的硬盘上,只是纯粹的html静态页面,那么页面中的路径不区分大小写
		-一旦部署到服务器上,页面中的路径严格区分大小写
		
	3)关于欢迎页面
		-(局部配置,局部优先)如果在当前项目的web.xml文件中配置了欢迎页面,那么就以这个配置为准
		-(全局配置)如果在当前的项目中,没有配置欢迎页面,那么会去web服务器config/web.xml文件中查找欢迎页面的配置
	
	4)集成jquery.ztree插件,完成菜单树的展示,完成许可树的展示
	
007
	1)将许可维护相关的html页面修改为jsp,完成页面的流转
	
	2)为了让页面中的路径更加方便的处理,引入	html的base标签
		-base标签只对页面中不以"/"开始的相对路径起作用
		-一旦引入了base标签,那么页面中的所以不以"/"开始的相对路径都会以base中的路径作为基础路径
		-一旦加上了base标签中的路径,那么相对路径也就变成了绝对路径
		-<base href="http://localhost:80/epay/">
	
	3)分析:<base href="协议名://服务器ip:端口号上下文根/">	
		-协议名		request.getScheme() 
		-服务器ip		request.getServerName() 
		-端口号		request.getServerPort() 
		-上下文根		request.getContextPath()
		
	
	4)jsp的九大内置对象
			内置对象的名称							对应的完整类名
		----------------------------------------------------------------
			pageContext					javax.servlet.jsp.PageContext
			request						javax.servlet.http.HttpServletRequest 
			session						javax.servlet.http.HttpSession
			application					javax.servlet.ServletContext	
			
			response					javax.servlet.http.HttpServletResponse
			out							javax.servlet.jsp.JspWriter
			
			exception					java.lang.Throwable
			config						javax.servlet.ServletConfig	
			
			page						this
			
			jsp的四个作用范围对象   pageContext(页面范围)<	request(请求范围)	<	session(会话范围)<   application(应用范围)
			
	5)jsp常用的语法格式
		-<% %>  jsp小脚本 	
		-<%= %> jsp表达式
		-<%@ %> jsp指令     page|taglib|include
		-<%! %> jsp声明
		-<%----%>注释
		-<jsp:forward> <jsp:include>  jsp动作 
		...
		-优化后base标签的写法:<base href="<%=request.getScheme()%>://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/">
		
	6)关于EL表达式
		-语法格式:${}
		-作用:从范围对象中获取数据,并且输出到浏览器
		-EL的内置对象
			*pageScope 从页面范围中获取数据,并且输出到浏览器客户端
			*requestScope 从请求范围中获取数据,并且输出到浏览器客户端
			*sessionScope 从会话范围中获取数据,并且输出到浏览器客户端
			*applicationScope 从应用范围中获取数据,并且输出到浏览器客户端
			*param    从请求参数中获取数据
			*initParam	 从application中获取初始化参数	
			*pageContext  和jsp的内置对象pageContext是同一个对象
			
		-最终base写法
			<base href="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/">	
			
	7)批量替换 ../   ctrl+H
	
	8)base标签在IE浏览器下存在兼容性问题
		-场景:如果在javascript代码中做资源的跳转,那么base标签在IE浏览器下不起作用
		-解决:以后只要是在js代码中做资源的跳转,那么一律使用带"/"的相对路径
		
008
	1)将许可维护相关的页面,放到WEB-INF目录下
		-安全   不能直接在地址栏中输入地址访问资源  资源受到了保护
		-强制程序员使用MVC架构进行开发   如果想跳转到视图view,必须通过控制器controller进行跳转
		
	2)创建PermissionController.java完成页面的跳转
	
	3)在spring-mvc.xml文件中配置处理器映射器,配置视图解析器,配置处理器
		
009
	1)动态建立许可树 
		-许可树的数据应该从服务器端动态获取
		
010
	1)显示许可明细
							
011
	1)新增许可 (不更新许可树)
		-跳转到新增页面
		-使用jquery对ajax提供的支持,发送异步请求,提交数据
			$.ajax()
				-$.get()
					-$.getJSON()
					-$.getScript()
				-$.post()
					
		-$.ajax({
			url:"",//请求资源的路径
			type:"",//请求方式
			async:"",//是否发送异步请求  默认true;如果设置为false,那么将发送同步请求
			data:"",//发送给服务器的数据
			cache://get请求浏览器是否缓存页面  如果设置为false,将不缓存页面 
			//在发送请求之前执行的回调函数,该函数返回boolean,如果为true,请求继续提交;如果为false,请求不再提交;比较适合做校验
			beforeSend:function(){}
			success:function(){//服务器处理成功之后执行的回调函数,该函数会接收服务器响应的数据,
				//具体接收的数据格式可以取决于response.setContentType("text|html|josn|xml...")
			}
		})
	
012
	1)新增许可(更新许可树)	
		-使用手动拼串的方式处理json数据,如果数据比较多,代码可读性差
		
013
	1)新增许可(更新许可树)
		-使用第三方组件 完成将java对象转换为json格式字符串
			*json-lib
			*jackson(我们使用的是)
			*fastjson		
	
	
014
	1)新增许可
		-使用jquery.form插件提交表单信息
			虽然是以form的方式提交数据,但是发送的还是ajax请求	
	
	
015
	1)新增许可
		-对许可代码和许可名称进行校验
		
	2)许可代码
		-非空(只需要在客户端就能完成校验)
		-只能包含字母和数字(在客户端就能完成校验 ,需要使用正则表达式)
		-不能重复(发送ajax请求和服务器交互完成校验)	
		
	3)许可名称
		-非空(只需要在客户端就能完成校验)
		-在同一个节点下不能重复,在不同的节点下,可以重复(发送ajax请求和服务器交互完成校验)
		-关于中文乱码的解决方式
			*post  request.setCharacterEncoding("UTF-8");
			*get  在server.xml文件中加URIEncoding="UTF-8"
			*万能的乱码解决方式     先解码   再编码
			
	4)校验方式
		-失去焦点后,开始进行校验,校验的信息及时显示在文本框后面
			*span	不会独占行		
			*div	独占行	
			
	5)校验特殊情况1:如果用户忽略提示信息,直接点击保存的处理
		-思路:在发送请求之前执行的回调函数中,获取所有提示信息的span,对这些span进行遍历,如果有一个span中的内容不为空,那么说明校验没通过,
			return false;请求不再提交
	
	
	6)校验特殊情况2:如果进入新增页面后,什么也不做,直接点击保存的处理
		-思路:在发送请求之前执行的回调函数中,调用blur函数,触发需要校验的项目的失去焦点事件
		
016
	1)删除许可
		-根许可不能删除
		-许可下有子许可不能删除
		-删除前提示用户
		-发送ajax请求完成删除操作
		-从树对象上删除节点
		
	2)关于真删除和伪删除
		-真删除 将数据从数据库中彻底删掉
		-伪删除  不会删除数据库中的数据,一般只是通过某一个字段做一个标记	
	
017
	1)修改许可
		-跳转到修改页面
		-使用jquery.form插件提交表单信息
		-更新许可树	
	
018
	1)重构:将epay项目由配置文件的方式修改为注解的方式
		-spring+springMVC注解
		-mybatis 配置文件
		
	2)步骤
		-注册组件扫描器
		-注册注解驱动
		-在PermissionServiceImpl.java中使用注解的方式,删除spring-service.xml
		-在PermissionController.java中使用注解的方式,引入service.		
	
019
	1)封装:
		将获取系统时间字符串的功能封装为一个单独的工具类
	
020
	1)创建PaginationVO.java类，完成数据的传递
	
	2)创建角色相关的dao以及映射文件
	
	3)创建角色相关的service接口以及实现类	
	
021
	1)集成角色维护相关的html页面,放到WEB-INF目录下,修改为jsp,创建RoleController,完成页面流转
	
	2)新增角色
		-使用jquery.form插件提交表单信息
			
022
	1)分页查询角色信息(同步的分页方式)
		-缺点:如果要想跳转到list.jsp页面,必须等到分页查询结束之后,才能跳转,影响用户体验
		
023
	1)分页查询角色信息(异步的分页方式)
		-先跳转到list.jsp页面,等页面加载完成之后,在发送ajax请求,获取分页数据,将分页数据
			动态的追加到tbody中
		-优点:在进行分页查询的时候,不影响对页面的其它操作,提高用户的体验
		
024
	1)使用jquery的翻页插件完成翻页功能
			
	2)注释掉翻页js中215代码
	
025
	1)分页中其它功能的实现
		-总记录条数的显示
		-总页数的显示
			注意:js中5/2的结果是2.5,需要使用parseInt进行取整     parseInt(2.9)结果是2
			jsonObject.total%pageSize==0?jsonObject.total/pageSize:parseInt(jsonObject.total/pageSize)+1;
		-点击回车跳转到指定页
		-用户可以自定义每页显示多少条记录
			
026
	1)删除角色前的准备工作
		-复选框的全选以及取消全选
		-获取页面中所有checkbox
			$(":checkbox")
			
		-获取页面中name='wsc'的checkbox
			$(":checkbox[name='wsc']")
			
		-获取页面中name='wsc'并且被选中的checkbox
			$(":checkbox[name='wsc']:checked")			
	
027
	1)删除角色
		-可以删除多个角色,但是不能一个也不选
		-删除前提示用户  让用户确认 
		-发送ajax请求完成角色的删除
		-删除成功后刷新页面
				
	2)关于js中字符串的截取
		-substr(startIndex,length)  从startIndex索引开始截取,截取length长度
		-substring(startIndex,endIndex) 从startIndex(包括)开始截取,到endIndex(不包括)结束
		
		-如果只给以上的两个方法传递一个参数,那么这两个方法完成的功能一致,都是从指定的位置开始截取,到最后结束
		
	3)在js中,{}是json对象,[]是数组对象,他们都属于Object数据类型
		-在js中数组等同于栈数据结构
		-
	
	4)关于js中的数据类型
		-String
		-Number
		-Object
		-Undefined
		-Null
		-Boolean
		
	5)关于js中比较特殊的数据
		-undefined   属于Undefined类型,Undefined类型只有一个值,就是undefined
		-NaN (Not a Number)  属于Number
		-infinity   无穷大     属于Number类型
		....
		
	6)如果角色描述为空的话,那么页面上不需要显示
		在Role.java中的getRemark()加remark==null?"":remark;	
		
028
	1)修改角色
		-跳转到修改页面(跳转前做校验,复选框只能选一个)
		-使用jquery.form插件提交表单
				
029
	1)给角色分配许可
		-跳转到分配许可页面(跳转前做校验,复选框只能选一个)
		-集成jquery.ui插件  完成多tab页效果的显示
		-显示角色信息		
		
030
	1)给角色分配许可
		-显示带有checkbox的许可树(不打勾)
				

031
	1)给角色分配许可
		-显示带有checkbox的许可树(打勾)
		-打勾条件:当前角色有这个许可(从角色许可关系表中可以获取数据)		
		
032
	1)给角色分配许可
		-操作的是角色许可关系表 tbl_role_permission_relation
		-思路:先将当前这个角色拥有的所有许可记录从关系表中删除掉,然后再将角色id和选中的许可id封装为
			一条关系记录,插入到关系表
		-通过发送ajax请求完成给角色分配许可的功能
	
033
	1)查看角色明细
		-跳转到查看明细页面(跳转前做校验,复选框只能选一个)
		-显示角色信息
		-显示当前角色拥有的所有许可(许可树)
		
034
	1)重构:将PermissionServiceImpl.java中生成许可树的方法进行重构
		-目前是在循环中进行角色是否有这个许可的判断,每循环一次,都要和数据库交互一次,连接过于频繁
		-目标:在循环之前,将当前这个角色拥有的所有许可id获取,放到list集合中			
		
	2)封装:将复选框只能选一个的功能封装到一个单独js文件中
			
035
	1)集成用户维护相关的html页面,放到WEB-INF目录下,修改为jsp,创建UserController完成页面流转
	
036
	1)新增用户
		-集成jquery.ui.datepicker插件,完成日历的显示  
			*日历国际化
			*年和月可以下拉选择   使用fireBug定位页面中元素
			*显示今天和关闭按钮 showButtonPanel: true
				
		-注意:jquery.ui.datepicker插件只能精确到年月日,如果要显示时分秒,需要集成jquery.ui.datepicker.timepicker插件
			*显示中文日历
			*显示秒
			*格式化日历
			
037
	1)新增用户
		-使用jquery.form插件提交表单信息			
		-密码需要进行加密 
			*使用MD5加密算法对密码进行加密,目前MD5已被破解		
		
038
	1)组合条件查询|动态参数查询用户信息(!!!!重点!!!!)
	
	2)分析查询条件
		-用户姓名是模糊查询
		-失效时间是一个范围   需要集成jquery日历插件
		-锁定状态  全选和一个也不选效果相同  都是将所有用户查询出来
			*1		启用
			*2		锁定
			*0		不加查询条件
			
	3)需要掌握的内容
		-页面上异步分页的代码
		-dao的映射文件中分页sql的写法
		
039
	1)给用户分配角色
		-跳转到分配角色页面(跳转前做校验,复选框只能选一个)
		-用户信息
		-当前用户已经分配的角色列表
		-当前用户未分配的角色列表
			
040
	1)给用户分配角色		
		-只是实现页面的移动效果
		
	2)jquery的选择器其实有两个参数
		第二个参数代表查找范围,缺省值  document
	
041
	1)给用户分配角色	
		-将左右移动的功能封装为一个单独的move函数
		-发送ajax请求,完成给用户分配角色  tbl_user_role_relation
			*正向授权	 insert    
			*负向授权	 delete
		-思路:根据用户id和角色id到用户角色关系表中查询,如果有记录,那么delete;如果没有记录,那么insert
		
042
	1)查看用户明细
		-跳转到查看明细页面(跳转前做校验,复选框只能选一个)
		-集成jquery.ui插件和jquery.ztree插件
		-显示用户信息
		-显示当前用户拥有的所有许可(许可树)
		
043
	1)关于开发原则和设计模式
		-开发原则
			*OCP原则   在程序开发的过程中,对功能的扩展开放,对代码的修改关闭
			*依赖倒转原则   面向接口编程,面向抽象编程,不要面向具体编程
			*合成聚合复用原则   能用has-a(关联)的地方,尽量少用is-a(继承)
			*里氏替换原则   只要是父类能够出现的地方子类就一定能够出现
			*接口隔离原则   接口应该尽量定义的专一一些,不要把所有的功能都放到同一个接口中
			*迪米特法则   不要和陌生人说话
			  
		-设计模式(GOF23种)
			*创建型:只要是和对象的创建有关系的都属于创建型设计模式
				>单例模式(懒汉式 ,饿汉式)
				>工厂(BeanFactory,sessionFactory)
				
			*结构型:更多的类更多的对象组合在一起,形成一个更大的结构解决问题
				>适配器(springMVC)
				>代理(spring AOP,mybatis中dao实现类)
				>装饰者设计模式(IO)
				
			*行为型:只要是和算法或者方法有关系的
				>模板方法(HttpServlet)
				>责任链(Filter)
				>观察者(监听器)
					例:ServletContextListener-->ServletContext
					观察者:Tomcat
					被观察者:ServletContext
					回调:在创建或者销毁对象的时候执行的方法
				
				>面试题:如果说MVC架构体现了观察者设计模式的话,那么谁是观察者,被观察者,以及回调
					观察者:C  	被观察者:M	回调:V
					
	2)观察者设计模式练习
		-自己定义一个监听器,完成一些数据的初始化功能
		-步骤:
			*创建一个类,SystemInitListener,实现ServletContextListener接口					
			*在web.xml文件中配置监听器
			
044
	1)封装:将分页的状态栏代码封装为一个单独的jsp文件
		
	2)关于jsp的include
		-静态include/静态包含/静态联编
			*语法:jsp指令  <%@ include file=""%>
			*a.jsp静态包含b.jsp,翻译生成一个.java文件,编译生成一个.class字节码文件,一个service方法
			*注意:a.jsp和b.jsp中不能声明同名的局部变量
			*a.jsp和b.jsp在编译阶段包含
			
		-动态include/动态包含/动态联编
			*语法:jsp动作  <jsp:include/>
			*a.jsp动态态包含b.jsp,翻译生成两个.java文件,编译生成两个.class字节码文件,两个service方法
			*注意:a.jsp和b.jsp中可以声明同名的局部变量
			*a.jsp和b.jsp在运行阶段包含
	
045
	1)认证前的准备工作
		-将main.html和changepwd.html放到WEB-INF目录下,修改为jsp,创建MainController,完成页面流转
		
		-将login.html修改为jsp
		
	2)登录认证
		-账号和密码是否正确
		-是否锁定
		-是否失效
		-是否ip受限
		
		-发送ajax请求完成登录认证,如果认证失败,我们需要将操作信息显示到页面上
			通过自定义异常的方式,将异常信息从service-->controller-->客户端
		
		-登录成功之后,将用户信息放到session中
			
		-提高用户体验的内容
			*让登陆账号文本框获取焦点
			*给整个登陆窗口注册keydown事件
046
	1)在main.jsp中显示当前用户
					
	2)初始化系统数据,一般由实施人员完成
		-SQL	
		-Excel(POI)
		-Xml
		
	3)练习对xml文件的解析
		-DOM
			原理:
				一次性将整个xml文件全部加载到内存中,在内存中生成一棵dom树,树上的任何一个节点都是一个java对象
				我们可以通过对对象的操作,完成对树的增删改查
				
			优点:
				比较灵活,解析过去的节点可以重复进行解析,因为这个节点就在内存中,就在dom树上
				
			缺点:
				如果xml文件足够大,容易导致内存溢出
				
		-SAX
			原理:
				基于事件驱动型的解析方式,按照从左到右,从上到下的顺序进行解析,在解析过程中,遇到一些特殊的节点,例如:开始节点,结束节点,会有特殊的
				事件进行处理.
				
			优点:
				不会导致内存溢出
				
			缺点:
				不够灵活,解析过去的节点,如果要重复解析的话,只能重新开始
				
	4)xml文件解析,不是java特有的内容,基本上任何一种编程语言,都支持xml文件的解析,java中对xml的解析方式
		-jdk本身自带的解析方式  遵循了w3c组织制定的规范,js在解析xml遵循了这个规范,所以会发现,它们虽然是不同的编程语言,但是
			却有相同的方法,例如:document.getElementById()
			
		-第三方组件dom4j
		
		-第三方组件jdom
	
	5)应用dom4j+xpath对xml文件进行解析
			
	6)关于tomcat和jre的类加载器
		-web应用类加载器  主要负责加载webapp/WEB-INF/classes下的字节码文件  由apache提供
			WebappClassLoader
			  context: /epay
			  delegate: false
			  repositories:
			    /WEB-INF/classes/
			----------> Parent Classloader:
			org.apache.catalina.loader.StandardClassLoader@1eb9b0d
		
		-标准类加载器  主要负责加载CATALINA_HOME/lib下的字节码文件  由apache提供
			org.apache.catalina.loader.StandardClassLoader@168cef6	
		
		-应用类加载器  主要负责加载classpath下的字节码文件     sun提供的
			sun.misc.Launcher$AppClassLoader@1704ebb	
		
		-扩展类加载器   主要负责加载JAVA_HOME/jre/lib/ext下的字节码文件   sun提供
			sun.misc.Launcher$ExtClassLoader@40d7b9
		
		-启动类加载器 主要负责加载rt.jar下的字节码文件 sun为了安全考虑,该类加载器没有名字    
			null
				
		思考:自己编写一个类,java.lang.String,问:在使用的时候,是使用自己定义的类,还是sun公司提供的java.lang.String呢?
			sun公司提供的,加载顺序   启动-->扩展-->应用
			
		这是一种叫做双亲委派的安全机制
		
047
	1)实施人员对客户进行培训
		-超级信息一般是隐藏
		
	2)登录是一个认证的过程,登录成功之后,要根据当前用户拥有的许可,动态的展示菜单树
		
048
	1)按钮的动态显示与隐藏
		-如果当前这个用户有这个许可,那么对应的按钮显示;否则,按钮隐藏
		-思路:当登录成功之后,获取当前这个用户拥有的所有许可(获取这个用户能够操作的所有url),
			放到session中,在页面上显示按钮的时候,判断这个按钮对应的操作url在不在用户能够操作的url范围之内,
			在,按钮显示;否则,按钮隐藏
			
049
	1)非法用户认证
		-用户必须登录系统之后,才能访问web站点的资源
	
	2)实现方式
		-Filter过滤器		是servlet规范的一部分
		-springMVC拦截器 Interceptor				
	
	3)关于springMVC的拦截器
		-实现HandlerInterceptor
			*preHandle
			*postHandle
			*afterCompetion
		-在spring-mvc.xml中注册拦截器
		
	4)非法用户认证思路
		-获取session
		-从session获取用户对象
		-如果能够获取,继续访问资源
		-如果没有获取用户,跳转到登陆页面
		
		
		
				
		
		
		
		
			
	
		