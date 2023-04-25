package vo;
// notice 테이블의 한행(레고드)을 저장하는 용도
// Value Object or Data Transfer Object or Domain
// Object 는 객체이다. 객체를 생성하는것을 선언이라고한다. 예를들면 ArrayList를 쓸때 new연산자를 사용해서 객체를 생성한다라고하고 이것을 변수로 저장해줄때 객체를 선언한다한다.
public class Notice {
	public int noticeNo;
	public String noticeTitle;
	public String noticeContent;
	public String noticeWriter;
	public String createdate;
	public String updatedate;
	public String noticePw;
}
