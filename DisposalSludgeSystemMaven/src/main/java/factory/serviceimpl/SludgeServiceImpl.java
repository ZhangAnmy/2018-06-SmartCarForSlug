package factory.serviceimpl;

import factory.dao.SludgeDao;
import factory.entity.Sludge;
import factory.entity.SludgeFunction;
import factory.service.SludgeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
@Service
public class SludgeServiceImpl implements SludgeService{
	@Autowired
	private SludgeDao sludgeDao;
	@Override
	public List<SludgeFunction> queryAllSludgeFunction() {
		return sludgeDao.queryAllSludgeFunction();
	}
	@Override
	public List<Sludge> queryAllSludge() {
		List<Sludge> sludges=new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.queryAllSludge());
		Collections.sort(sludges, new Comparator<Sludge>() {
			public int compare(Sludge arg0, Sludge arg1) {
				return arg1.getProduceTime().compareTo(arg0.getProduceTime());
			}
		});
		return sludges;
	}
	@Override
	public void deleteSludge(int sludgeId) {
		sludgeDao.deleteSludge(sludgeId);
		
	}
	@Override
	public void editSludge(Sludge sludge) {
		String function=sludge.getSludgeFunction().getFunction();
		SludgeFunction sludgeFunction=sludgeDao.querySludgeFunctionByFunction(function);
		if(sludgeFunction!=null){
			sludge.setFunctionId(sludgeFunction.getId());
		}
		else {
			SludgeFunction addSludgeFunction=new SludgeFunction();
			addSludgeFunction.setFunction(function);
			addSludgeFunction.setDescription(function);
			sludgeDao.addSludgeFunction(addSludgeFunction);
			sludge.setFunctionId(addSludgeFunction.getId());
		}
		if(sludge.getRfidString().equals("none")){
			sludge.setRfidString(null);
		}
		if(sludge.getDestinationAddress().equals("none")){
			sludge.setRfidString(null);
		}
		sludgeDao.editSludge(sludge);
	}
	@Override
	public List<Sludge> querySludgeBySiteId(int siteId) {
		// TODO Auto-generated method stub
		List<Sludge> sludges=new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludgeBySiteId(siteId));
		Collections.sort(sludges, new Comparator<Sludge>() {
			public int compare(Sludge arg0, Sludge arg1) {
				return arg1.getProduceTime().compareTo(arg0.getProduceTime());
			}
		});
		return sludges;
		
	}
	@Override
	public List<Sludge> querySludgeByDriverId(int driverId) {
		List<Sludge> sludges=new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludgeByDriverId(driverId));
		Collections.sort(sludges, new Comparator<Sludge>() {
			public int compare(Sludge arg0, Sludge arg1) {
				return arg1.getProduceTime().compareTo(arg0.getProduceTime());
			}
		});
		return sludges;
	}
	@Override
	public List<Sludge> querySludgeByDate(String startDate, String endDate) {
		List<Sludge> sludges=new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludegAssignFuncByDate(startDate, endDate));
		sludges.addAll(sludgeDao.querySludegNotAssignFuncByDate(startDate, endDate));
		Collections.sort(sludges, new Comparator<Sludge>() {
			public int compare(Sludge arg0, Sludge arg1) {
				return arg1.getProduceTime().compareTo(arg0.getProduceTime());
			}
		});
		return sludges;
		
	}
	@Override
	public List<Sludge> queryAllSludgeOfOneFactory(int siteId) {
		List<Sludge> sludges=new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludgeBySiteId(siteId));
		return sludges;
	}
	@Override
	public List<Sludge> querySludgeByDriverIdOfOneFacotry(Map<String, Integer> condition) {
		int siteId=condition.get("siteId");
		int driverId=condition.get("driverId");
		List<Sludge> sludges=new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludgeByDriverIdOfOneFacotry(driverId, siteId));
		return sludges;
	}
	@Override
	public List<Sludge> querySludegByDateOfOneFactory(Map<String, Object> condition) {
		int siteId=(int) condition.get("siteId");
		String startDate=String.valueOf(condition.get("startDate"));
		String endDate=String.valueOf(condition.get("endDate"));
		System.out.println(siteId+" "+startDate+" "+endDate);
		List<Sludge> sludges=new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludegByDateOfOneFactory(siteId, startDate, endDate));
		return sludges;
	}
	
	@Override
	public List<Sludge> querySludgeByDates(String startDate, String endDate, int siteId) {
		List<Sludge> sludges=new ArrayList<Sludge>();
		System.out.println("dates are:"+startDate+":"+endDate);
		sludges.addAll(sludgeDao.querySludgeByDates(startDate, endDate,siteId));
		return sludges;
	}

	@Override
	public List<Sludge> querySludgeBySiteName(String siteName) {
		List<Sludge> sludges=new ArrayList<Sludge>();
		sludges.addAll(sludgeDao.querySludgeBySiteName(siteName));
		return sludges;	
	}
}
