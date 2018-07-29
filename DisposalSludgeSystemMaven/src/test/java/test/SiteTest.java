package test;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import factory.dao.SiteDao;
import factory.entity.Site;

public class SiteTest extends BaseTest{
	@Autowired
	private SiteDao siteDao;
	@Test
	public void queryAllSite(){
		List<Site> sites=siteDao.queryAllSite();
		System.out.println(sites.get(1).getSiteName());
	}
	@Test
	public void querySiteBySiteName(){
		Site site=siteDao.querySiteBySiteName("hnu");
		System.out.println(site.getId());
	}

	
}
