package test;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import factory.dao.UserDao;
import factory.entity.User;


public class UserTest extends BaseTest{
	@Autowired
	private UserDao userDao;
	
	@Test
	public  void test(){
		String username="fanxin";
		User user=userDao.queryUserByUsername(username);
		/*System.out.println(user.getUsername()+" "+user.getPassword());*/
		
	}
	
	@Test
	public void queryAllDriver(){
		List<User> drivers=userDao.queryAllDriver();
		for(User driver:drivers){
			System.out.println(driver.getUsername());
		}
	}

	@Test
	public void queryAllUser(){
		List<User> users=userDao.queryAllUser();
		for(User user:users){
			System.out.println(user.getUsername()+":"+user.getRealname()+":"+user.getRoleId());
		}
	}

//	@Test
//	public void fuzzyQueryUser(){
//		List<User> users=userDao.fuzzyQueryUser("",0);
//		for(User user:users){
//			System.out.println(user.getUsername()+":"+user.getRealname()+":"+user.getCheckStatus());
//		}
//	}

	@Test
	public void addUser()
	{
		User user = new User();
		user.setRealname("Zhang Test");
		user.setUsername("test");
		user.setPassword("1");
		user.setEmail("");
		user.setTelephone("");
		user.setRoleId(4);
		user.setCheckStatus(1);//管理员增加用户默认审核通过

		userDao.addUser(user);
		System.out.println("--add user success--");
	}
}

