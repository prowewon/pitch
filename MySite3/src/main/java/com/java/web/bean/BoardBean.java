package com.java.web.bean;

import org.apache.ibatis.type.Alias;

@Alias("bBean")
public class BoardBean {
	int boardNo;
	int menuNo;
	String boardTitle;
	String boardIndex;
	String boardDate;
	String delYn;
	String menuName;
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getMenuNo() {
		return menuNo;
	}
	public void setMenuNo(int menuNo) {
		this.menuNo = menuNo;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardIndex() {
		return boardIndex;
	}
	public void setBoardIndex(String boardIndex) {
		this.boardIndex = boardIndex;
	}
	public String getBoardDate() {
		return boardDate;
	}
	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	
	@Override
	public String toString() {
		return "BoardBean [boardNo=" + boardNo + ", menuNo=" + menuNo + ", boardTitle=" + boardTitle + ", boardIndex="
				+ boardIndex + ", boardDate=" + boardDate + ", delYn=" + delYn + ", menuName=" + menuName + "]";
	}
	
}
