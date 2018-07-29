package factory.controller;

import factory.entity.Site;
import factory.entity.Sludge;
import factory.entity.SludgeFunction;
import factory.entity.User;
import factory.enums.Result;
import factory.service.SiteService;
import factory.service.SludgeService;
import factory.service.UserService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;



@Controller
@RequestMapping("sludge")
public class SludgeController {
	private Log log=LogFactory.getLog(SludgeController.class);
	
	@Autowired
	private SludgeService sludgeService;
	
	@Autowired
	private SiteService siteService;
	
	@Autowired
	private UserService userService;
	@RequestMapping("jumpToSludge")
	public ModelAndView querySludgeFunctionsAndJumpToSludge(ModelAndView mv){
		log.info("���ý���sludge.jsp�ķ���");
		List<User> drivers=new ArrayList<User>();
		List<Site> sites=new ArrayList<Site>();
		drivers.addAll(userService.quertAllDriver());
		sites.addAll(siteService.queryAllSite());
		mv.addObject("driverList",drivers);
		mv.addObject("siteList",sites);
		mv.setViewName("record/sludge");
		return mv;
	}
	@RequestMapping("queryAllFunc")
	@ResponseBody
	public List<SludgeFunction> queryAllFunc(){
		return sludgeService.queryAllSludgeFunction();
	}
	@RequestMapping("queryAllSludge")
	@ResponseBody
	public List<Sludge> queryAllSludge(){
		log.info("�����ѯ��������ķ���");
		List<Sludge> sludges=new ArrayList<Sludge>();
		sludges.addAll(sludgeService.queryAllSludge());
		return sludges;
	}
	
	@RequestMapping("deleteSludge")
	@ResponseBody
	public Result deleteSludge(@RequestParam("sludgeId") int sludgeId){
		log.info("ɾ�������");
		System.out.println(sludgeId);
		try {
			sludgeService.deleteSludge(sludgeId);
			return Result.SUCCESS;
		} catch (Exception e) {
			return Result.ERROR;
		}
	}
	@RequestMapping("editSludge")
	@ResponseBody
	public Result editSludge(@RequestBody Sludge sludge){
		log.info("�����޸�����鷽��");
		System.out.println(sludge.getId()+" "+sludge.getDestinationAddress()+sludge.getSludgeFunction().getFunction());
		try {
			sludgeService.editSludge(sludge);
			return Result.SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			return Result.ERROR;
		}
	}
	
	@RequestMapping("querySludgeBySiteId")
	@ResponseBody
	public  List<Sludge> querySludgeBySiteId(@RequestParam("siteId") int siteId){
		log.info("����querySludgeBySiteId");
		log.info("Ҫ��ѯ��siteId:"+siteId);
		List<Sludge> sludges=sludgeService.querySludgeBySiteId(siteId);
		return sludges;	
	}
	
	@RequestMapping("querySludgeByDriverId")
	@ResponseBody
	public List<Sludge> querySludgeByDriverId(@RequestParam("driverId") int driverId){
		log.info("����querySludgeByDriverId");
		List<Sludge> sludges=sludgeService.querySludgeByDriverId(driverId);
		return sludges;
	}
	
	@RequestMapping("querySludgeByDate")
	@ResponseBody
	public List<Sludge> querySludgeByDate(@RequestParam("startDate") String startDate,@RequestParam("endDate") String endDate){
		log.info("����querySludgeByDate");
		List<Sludge> sludges=sludgeService.querySludgeByDate(startDate, endDate);
		return sludges;
	}
	
	@RequestMapping("jumpToSludgeOfOneFactory")
	public ModelAndView querySludgeFunctionsAndJumpToSludgeOfOneFactroy(@RequestParam("siteId") int siteId,ModelAndView mv){
		log.info("���ý���sludge.jsp�ķ���");
		List<SludgeFunction> sludgeFunctions=new ArrayList<SludgeFunction>();
		List<User> drivers=new ArrayList<User>();
		sludgeFunctions.addAll(sludgeService.queryAllSludgeFunction());
		drivers.addAll(userService.queryDriverServeOneFactory(siteId));	
		mv.addObject("sludgeFunctions",sludgeFunctions);
		mv.addObject("driverList",drivers);
		mv.setViewName("factory/sludge");
		return mv;
	}
	
	@RequestMapping("queryAllSludgeOfOneFactory")
	@ResponseBody
	public List<Sludge> queryAllSludgeOfOneFactory(@RequestBody Site site){
		log.info("����queryAllSludgeOfOneFactory");
		return sludgeService.queryAllSludgeOfOneFactory(site.getId());
	}
	
	@RequestMapping("querySludgeByDriverIdOfOneFactory")
	@ResponseBody
	public  List<Sludge> querySludgeByDriverIdOfOneFactory(@RequestBody Map<String, Integer> condition){
		log.info("����querySludgeByDriverIdOfOneFactory");
		return sludgeService.querySludgeByDriverIdOfOneFacotry(condition);	
	}
	
	@RequestMapping("querySludgeByDateOfOneFactory")
	@ResponseBody
	public List<Sludge> querySludgeByDateOfOneFactory(@RequestBody Map<String,Object> condition){
		log.info("����querySludgeByDateOfOneFactory");
		for(Map.Entry<String, Object> entry:condition.entrySet()){
			System.out.print(entry.getKey()+"   "+entry.getValue());
		}
		return sludgeService.querySludegByDateOfOneFactory(condition);
	}

}
