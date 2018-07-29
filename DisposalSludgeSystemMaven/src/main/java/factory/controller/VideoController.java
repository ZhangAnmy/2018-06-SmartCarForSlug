package factory.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import factory.entity.Site;
import factory.entity.User;
import factory.entity.Video;
import factory.service.VideoService;



@Controller
@RequestMapping("monitor")
public class VideoController {
	@Autowired
	private VideoService videoService;
	private static Log log=LogFactory.getLog(VideoController.class);
	
	@RequestMapping("/jumpToVideo")
	public ModelAndView queryAllVideo(ModelAndView mv) {
		log.info("调用查询视频的方法");
		List<Video> videos = videoService.queryAllVideo();
		mv.addObject("videoList", videos);// 设置需要返回的值
		mv.setViewName("monitor/monitor"); // 跳转到指定的页面
		return mv; // 返回到staffManage.jsp页面
	}
	@RequestMapping("queryAllVideo")
	@ResponseBody
	public List<Video> queryAllVideo() {
		log.info("调用queryAllVideo");
		List<Video> video=videoService.queryAllVideo();
		return video;
	}
	
	@RequestMapping("addVideo")
	@ResponseBody
	public Map<String, String> addVideo(@RequestBody Map<String, String> videoInfo) {
		log.info("增加监控");
		Map<String, String> result = new HashMap<String, String>();
		try {
			log.info(videoInfo.toString());
			int videoId = videoService.addVideo(videoInfo);
			result.put("result", "success");
			result.put("videoId",String.valueOf(videoId));

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result.put("result", "failure");
		}
		return result;
	}
	
	@RequestMapping("editVideo")
	@ResponseBody
	public Map<String, String> editVideo(@RequestBody Map<String, String> videoInfo) {
		log.info("编辑监控");
		Map<String, String> result = new HashMap<String, String>();
		try {
			log.info(videoInfo.toString());
			videoService.editVideo(videoInfo);
			result.put("result", "success");

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result.put("result", "failure");
		}
		return result;
	}
}
