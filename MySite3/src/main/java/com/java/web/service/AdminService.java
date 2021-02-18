package com.java.web.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.java.web.bean.RecordBean;
import com.java.web.dao.AdminDao;

@Service
public class AdminService {

	@Resource(name="adminDao")
	AdminDao aDao;
	
	private int flag;
	private HashMap<String, Object> map, result;
	
	public HashMap<String, Object> select() {
		map = new HashMap<String, Object>();
		map.put("list", aDao.select());
		return map;
	}
	
	public HashMap<String, Object> insert_rec(RecordBean rBean, HttpServletRequest request, MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		result = new HashMap<String, Object>();
		map = new HashMap<String, Object>();
		
		flag = aDao.insert_rec(rBean);
		if (flag == 1) {
			mRequest = (MultipartHttpServletRequest) request;
			MultipartFile img = mRequest.getFile("file");
			
//			String contextPath = request.getSession().getServletContext().getRealPath("resources/img/");
			String workspace = "C:\\Users\\PC110\\Desktop\\PrivateProject\\MySite3\\src\\main\\webapp\\resources\\img\\";
			if(img.getSize() == 1 && img.getOriginalFilename().equals("")){
				
			}else {
				//���Ƿ� ����Ǵ� �����̸�
				String imgRename = UUID.randomUUID().toString();
				//ó�� ���� �̸�
				String imgName = img.getOriginalFilename();
				//Ȯ����
				String extension = imgName.substring(imgName.lastIndexOf("."), imgName.length());
				//����� �����̸�+Ȯ����
				String saveImgName = imgRename + extension;
				//������ ���� ���
//				String savePath = contextPath + "\\" +saveImgName;
				//������Ʈ ������ ������ ���
				String savePath = workspace + saveImgName;
//				int fileSize = (int) img.getSize();
				
				map.put("imgUrl", savePath);
				map.put("imgName", imgName);
				map.put("imgRename", saveImgName);
				map.put("rec_name", rBean.getRec_name());
				System.out.println(map);
				result.put("flag", aDao.insert_img(map));
				img.transferTo(new File(savePath));
				
			}
		}
		return result;
	}
	
	public HashMap<String, Object> insert_tra(HashMap<String, Object> map) {
		result = new HashMap<String, Object>();
		result.put("insert_tra", aDao.insert_tra(map));
		return map;
	}
	
	public HashMap<String, Object> member() {
		result = new HashMap<String, Object>();
		result.put("member", aDao.member());
		return result;
	}
	
	public HashMap<String, Object> up_mem(HashMap<String, Object> map) {
		result = new HashMap<String, Object>();
		result.put("up_mem", aDao.up_mem(map));
		return result;
	}
}
