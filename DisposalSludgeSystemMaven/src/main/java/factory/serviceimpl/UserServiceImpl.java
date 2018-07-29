package factory.serviceimpl;

import factory.dao.CarDao;
import factory.dao.UserDao;
import factory.entity.User;
import factory.exception.AuditIngException;
import factory.exception.DataNoneException;
import factory.exception.LoginInfoErrorException;
import factory.exception.RefuseLoginException;
import factory.service.UserService;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;

	@Autowired
	private CarDao carDao;

	private static Log log = LogFactory.getLog(UserServiceImpl.class);

	@Override
	public User queryUserByUsername(String username) {
		return userDao.queryUserByUsername(username);
	}

	/**
	 * ע���û�
	 */
	@Override
	public void registerUser(User user) {
		userDao.registerUser(user);

	}

	/**
	 * ��ѯ����˾��
	 */
	@Override
	public List<User> quertAllDriver() {

		return userDao.queryAllDriver();
	}

	/**
	 * ͨ����ʵ������ѯ�û�
	 */
	@Override
	public User queryUserByRealName(String realname) {
		// TODO Auto-generated method stub
		return userDao.queryUserByRealName(realname);
	}

	@Override
	public void deleteUser(Map<String, Integer> deleteUserInfo) {
		int sensorId = deleteUserInfo.get("userId");
		System.out.println(sensorId);
		userDao.delectUser(sensorId);
	}

	@Override
	public List<User> queryDriverServeOneFactory(int siteId) {
		List<User> drivers = new ArrayList<User>();
		drivers.addAll(userDao.queryDriverServeOneFactory(siteId));
		return drivers;
	}

	// �ж��û��Ƿ����
	public boolean isUserExist(String username) {
		if (userDao.queryUserByUsername(username) == null) {
			return false;
		} else {
			return true;
		}
	}

	// �����ṩ���û���������
	public String getPasswordByUsername(String username) {
		return userDao.queryUserByUsername(username).getPassword();
	}

	@Override
	public Map<String, String> modifyPasswordByUsername(Map<String, Object> userMap) {
		Map<String, String> result = new HashMap<String, String>();
		int userId = (int) userMap.get("userId");
		String originPwd = String.valueOf(userMap.get("originPwd"));
		String newPwd = String.valueOf(userMap.get("newPwd"));
		User user = userDao.queryUserByUserId(userId);
		System.out.print("ԭʼ�û�����" + user.getPassword());
		if (user.getPassword().equals(originPwd)) {
			user.setPassword(newPwd);
			userDao.modifyPasswordByUsername(user);
			result.put("msg", "success");
		} else {
			result.put("msg", "error");
		}

		System.out.print(result);
		return result;
	}

	@Override
	public List<User> queryAllManager() {
		// TODO Auto-generated method stub
		return userDao.queryAllManager();
	}

	@Override
	public void updateUserInfo(User user) {
		userDao.updateUserInfo(user);

	}

	@Override
	public User queryUserByUserId(int userId) {
		// TODO Auto-generated method stub
		return userDao.queryUserByUserId(userId);
	}

	@Override
	public List<User> queryAllUser() {
		return userDao.queryAllUser();
	}

	@Override
	public List<User> fuzzyQueryUser(String queryStr) {
		System.out.println("query str is:" + queryStr);
		return userDao.fuzzyQueryUser(queryStr);
	}

	@Override
	public void deleteUserByUserId(int userId) {
		// TODO Auto-generated method stub
		userDao.deleteUserByUserId(userId);
	}

	@Override
	public void editUserByUserId(Map<String, Integer> userInfo) {
		// TODO Auto-generated method stub
		User user = new User();
		int userId = userInfo.get("userId");
		int roleId = userInfo.get("roleId");
		int siteId = userInfo.get("siteId");
		int carId = userInfo.get("carId");
		if (roleId == 2) {// ����
			user.setId(userId);
			user.setSiteId(siteId);
			userDao.editUserByUserId(user);
		} else if (roleId == 3) { // ˾��
			if (carId != 0) {
				carDao.setDriverIdToNUll(userId);//�Ȱ�֮ǰ����ĳ���˾����ΪNULL
				carDao.updateDriverId(carId, userId);
			}
			else{ //Ϊ0˵����Ϊ˾�����䳵��
				carDao.setDriverIdToNUll(userId);
			}
		}
	}

	@Override
	public void checkUserByUserId(int userId) {
		userDao.checkUserByUserId(userId);
	}

	@Override
	public void checkNUserByUserId(int userId) {
		userDao.checkNUserByUserId(userId);
	}

	@Override
	public int addUser(Map<String, String> userInfo) {
		// TODO Auto-generated method stub
		String username = userInfo.get("username");
		String password = userInfo.get("password");
		if (username == null || username.equals("") || password == null || password.equals("")) {
			throw new DataNoneException("�û�����ϢΪ�գ�");
		}
		User user = new User();
		user.setRealname(userInfo.get("realname"));
		user.setUsername(username);
		user.setPassword(password);
		user.setEmail(userInfo.get("email"));
		user.setTelephone(userInfo.get("telephone"));
		user.setRoleId(Integer.valueOf(userInfo.get("roleId")));
		user.setCheckStatus(1);// ����Ա�����û�Ĭ�����ͨ��

		userDao.addUser(user);
		return user.getId();
	}

	@Override
	public List<User> queryUserByCheckStutas(int checkStatus) {
		List<User> users = new ArrayList<User>();
		users.addAll(userDao.queryUserByCheckStutas(checkStatus));
		return users;
	}

	@Override
	public List<User> queryNoCarAssignedDriver() {
		List<User> users = new ArrayList<User>();
		users.addAll(userDao.queryNoCarAssignedDriver());
		return users;
	}

	@Override
	public List<User> queryCarAssignedDriver() {
		List<User> drivers = new ArrayList<User>();
		drivers.addAll(userDao.queryCarAssignedDriver());
		return drivers;
	}

	@Override
	public void register(User user) {
		if (user.getUsername() == null || user.getUsername().length() == 0 || user.getPassword() == null
				|| user.getPassword().length() == 0) {
			throw new DataNoneException("ע���û���Ϣ��ȫ");

		}
		User recpUser = userDao.queryUserByUsername(user.getUsername());
		if (recpUser != null) {
			throw new DuplicateKeyException("�Ѿ���ע��");
		} else {
			if (user.getRoleId() == 3) { // �������˾��
				user.setSiteId(0);
			}
			user.setTelephone(user.getUsername());// �ֻ���������û���
			userDao.registerUser(user);
		}

	}

	@Override
	public User loginValidation(User user) {
		// TODO Auto-generated method stub
		log.info(user.getUsername() + " " + user.getPassword());
		String username = user.getUsername();
		String password = user.getPassword();
		if (username == null || username.equals("") || password == null || password.equals("")) {
			throw new DataNoneException("��½��Ϣ������");
		}
		User loginUser = userDao.queryUserByUsername(username);
		if (loginUser != null) {
			System.out.println(loginUser.getUsername());
			if (password.equals(loginUser.getPassword())) {
				if (loginUser.getCheckStatus() == 0) {
					throw new RefuseLoginException("��˲�ͨ��,��ֹ��½��");
				} else if (loginUser.getCheckStatus() == 2) { // �����
					throw new AuditIngException("�����,�ݲ��ܵ�½");
				} else {
					return loginUser;
				}
			} else {
				throw new LoginInfoErrorException("�������");
			}
		} else {
			throw new LoginInfoErrorException("�û�������");
		}

	}

	@Override
	public void resetPassWordByUserId(int userId) {
		userDao.resetPassWordByUserId(userId);
		
	}

	@Override
	public List<User> queryUserByRoleId(int roleId) {
		List<User> users=new ArrayList<User>();
		users.addAll(userDao.queryUserByRoleId(roleId));
		return users;
	}

	@Override
	public List<User> queryDriverUnassign() {
		List<User> drivers=new ArrayList<User>();
		drivers.addAll(userDao.queryDriverUnassign());
		for(User user:drivers){
			System.out.println(user.getRealname());
		}
		return drivers;
	}
	
}
