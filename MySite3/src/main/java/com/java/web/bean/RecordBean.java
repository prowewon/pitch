package com.java.web.bean;

import org.apache.ibatis.type.Alias;

@Alias("rBean")
public class RecordBean {
	int rec_no;
	String rec_name;
	String rec_art;
	String rec_date;
	int tra_no;
	String tra_name;
	String tra_url;
	
	public int getRec_no() {
		return rec_no;
	}
	public void setRec_no(int rec_no) {
		this.rec_no = rec_no;
	}
	public String getRec_name() {
		return rec_name;
	}
	public void setRec_name(String rec_name) {
		this.rec_name = rec_name;
	}
	public String getRec_art() {
		return rec_art;
	}
	public void setRec_art(String rec_art) {
		this.rec_art = rec_art;
	}
	public String getRec_date() {
		return rec_date;
	}
	public void setRec_date(String rec_date) {
		this.rec_date = rec_date;
	}
	public int getTra_no() {
		return tra_no;
	}
	public void setTra_no(int tra_no) {
		this.tra_no = tra_no;
	}
	public String getTra_name() {
		return tra_name;
	}
	public void setTra_name(String tra_name) {
		this.tra_name = tra_name;
	}
	public String getTra_url() {
		return tra_url;
	}
	public void setTra_url(String tra_url) {
		this.tra_url = tra_url;
	}
	
	@Override
	public String toString() {
		return "RecordBean [rec_no=" + rec_no + ", rec_name=" + rec_name + ", rec_art=" + rec_art + ", rec_date="
				+ rec_date + ", tra_no=" + tra_no + ", tra_name=" + tra_name + ", tra_url=" + tra_url + "]";
	}
}
