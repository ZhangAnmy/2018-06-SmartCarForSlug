package factory.serviceimpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import factory.dao.CarDao;
import factory.dao.RecordDao;
import factory.entity.Car;
import factory.entity.Record;
import factory.enums.Result;
import factory.exception.AllocateCarForRecordConflict;
import factory.service.RecordService;

@Service
public class RecordServiceImpl implements RecordService{
	@Autowired
	private RecordDao recordDao;
	
	@Autowired
	private CarDao carDao;
	
	/**
	 * ��ѯ���еĴ����¼
	 */
	@Override
	public List<Record> queryAllRecord() {
		// TODO Auto-generated method stub
		return recordDao.queryAllRecord();
	}
	/**
	 * ͨ������������ѯ�����¼
	 */
	@Override
	public List<Record> queryRecordBySiteId(int siteId) {
		// TODO Auto-generated method stub
		return recordDao.queryRecordBySiteId(siteId);
	}
	/**
	 * ͨ��������(˾��)����ѯ�����¼
	 */
	@Override
	public List<Record> queryRecordByDriverId(int driverId) {
		// TODO Auto-generated method stub
		return recordDao.queryRecordByDriverId(driverId);
	}

	/**
	 * ͨ�����ڲ�ѯ�����¼
	 */
	@Override
	public List<Record> queryRecordByDate(String startDate, String endDate) {
		// TODO Auto-generated method stub
		return recordDao.queryRecordByDate(startDate, endDate);
	}
	/**
	 * �޸Ĵ�����
	 */
	@Override
	public void updateCarId(int recordId, int carId) {
		// TODO Auto-generated method stub
		recordDao.updateCarId(recordId, carId);
		
	}
	
	/**
	 * ɾ����¼
	 */
	@Override
	public void deleteRecord(int recordId) {
		// TODO Auto-generated method stub
		recordDao.deleteRecord(recordId);
	}
	@Override
	public List<Record> queryAllRecordOfOneDriver(int driverId) {
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordDao.queryAllRecordOfOneDriver(driverId));
		return records;
		
	}
	@Override
	public List<Record> queryRecordBySiteIdOfOneDriver(Map<String, Integer> condition) {
		List<Record> records=new ArrayList<Record>();
		int driverId=condition.get("driverId");
		int siteId=condition.get("siteId");
		System.out.println(driverId+"  "+siteId);
		records.addAll(recordDao.queryRecordBySiteIdOfOneDriver(driverId, siteId));
		return records;
	}
	@Override
	public List<Record> queryRecordByDateOfOneDriver(Map<String, Object> condition) {
		int driverId=(int) condition.get("driverId");
		String startDate=String.valueOf(condition.get("startDate"));
		String endDate=String.valueOf(condition.get("endDate"));
		System.out.println(driverId+" "+startDate+" "+endDate);
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordDao.queryRecordByDateOfOneDriver(driverId, startDate, endDate));
		return records;
	}
	@Override
	public List<Record> queryAllRecordOfOneFactory(int siteId) {
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordDao.queryAllRecordOfOneFactory(siteId));
		return records;
	}
	@Override
	public List<Record> queryRecordByDriverIdOfOneFacotry(Map<String, Integer> condition) {
		List<Record> records=new ArrayList<Record>();
		int driverId=condition.get("driverId");
		int siteId=condition.get("siteId");
		System.out.println(driverId+"  "+siteId);
		records.addAll(recordDao.queryRecordByDriverIdOfOneFacotry(driverId, siteId));
		return records;		
	}
	@Override
	public List<Record> queryRecordByDateOfOneFactory(Map<String, Object> condition) {
		int siteId=(int) condition.get("siteId");
		String startDate=String.valueOf(condition.get("startDate"));
		String endDate=String.valueOf(condition.get("endDate"));
		System.out.println(siteId+" "+startDate+" "+endDate);
		List<Record> records=new ArrayList<Record>();
		records.addAll(recordDao.queryRecordByDateOfOneFactory(siteId, startDate, endDate));
		return records;
	}
	@Override
	public String editRecord(Map<String, Integer> map) {
		// TODO Auto-generated method stubCar car=carService.queryCarByDriverId(jsonMap.get("driverId"));
		int recordId=map.get("recordId");
		int driverId=map.get("driverId");
		int siteId=map.get("siteId");
		Car queryCar=carDao.queryCarByRecordId(recordId);//��ѯrecord�Ƿ��Ѿ������˴�����(��)
		if(queryCar==null){ //δ����˾��
			Car car=carDao.queryCarByDriverId(driverId);
			recordDao.updateCarId(recordId, car.getId());
			//car.status --0��ʾ���У�1��ʾ��;�У�2���3���ɵ���δ��������4���̣������꣩
			carDao.editWorkerCarStatusAndSiteId(car.getId(), 3, siteId); 
			return car.getLicense();
		}
		else{//������˾��
			if(queryCar.getStatus()==1||queryCar.getStatus()==2||queryCar.getStatus()==4){
				throw new AllocateCarForRecordConflict("�޷�����");
			}
			else{//0-����״̬��3���ɵ�״̬-�����޸�
				//Ҫ��֮ǰ�����car״̬�Ļ���
				carDao.editWorkerCarStatusAndSiteId(queryCar.getId(),0,0);//sql�ж����siteId��0����ֵsite_id=NULL
				Car newCar=carDao.queryCarByDriverId(driverId);
				recordDao.updateCarId(recordId, newCar.getId());
				carDao.editWorkerCarStatusAndSiteId(newCar.getId(), 3, siteId);
				return newCar.getLicense();
			}
		}
		
	}
	@Override
	public List<Record> queryRecordOfCarNull() {
		// TODO Auto-generated method stub
		return recordDao.queryRecordOfCarNull();
	}
	
	@Override
	public void editRecordCarIdBySiteId(int siteId, int carId) {
		// TODO Auto-generated method stub
		recordDao.editRecordCarIdBySiteId(siteId,carId);
		carDao.editWorkerCarStatusAndSiteId(carId,3,siteId);
	}
	

}
