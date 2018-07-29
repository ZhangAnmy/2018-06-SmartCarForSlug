package test;

import factory.dao.ChargeDao;
import factory.entity.Charge;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.nio.charset.Charset;
import java.util.List;

public class ChargeTest extends BaseTest{
	@Autowired
	private ChargeDao chargeDao;
	private static List<Charge> chargeList;
	
	@Test
	public void test(){
		chargeList=chargeDao.queryAllCharge();
		System.out.println("the size is:"+chargeList.size());
		for(Charge charge:chargeList)
		{
			System.out.println(charge.getId());
			System.out.println("site name is:"+charge.getRecord().getSite().getSiteName());
		}
	}
	
	@Test
	public void quertRecordBySiteName(){
		chargeList=chargeDao.queryChargeBySiteName("湖南通莱科技公司");
		System.out.println(chargeList.size());
		for(Charge charge:chargeList)
		{
			System.out.println(charge.getRecord().getSite().getSiteName());
		}
	}

	@Test
	public void queryRecordByDate(){
		chargeList=chargeDao.queryChargeByDate("2017-12-12", "2018-12-13");
		System.out.println(chargeList.size());
		for(Charge charge:chargeList)
			System.out.println(charge.getWeight());
		}
}
