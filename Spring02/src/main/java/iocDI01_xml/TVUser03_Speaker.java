package iocDI01_xml;
//** TV 의 의존성 처리
//=> TV  는 Speaker 를 사용 
//=> 생성자 주입, setter 주입

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

//** 의존성 해결
//1) 고전적 방법 (직접 new)
//2) IOC/DI -> 생성자 주입 
//3) IOC/DI -> setter 주입
//=> setter 보다는 생성자주입을 권장함 (최초 1회 적용후 변경 불가능 하기때문)

//** IOC: 제어의 역전 (외부에서 Control)
//** DI : 주입 받음으로 해결 


class Speaker{
	public Speaker() {System.out.println("생성자");	}
	public void volumeUp() {System.out.println("speaker volumeup11");}
	public void volumeDown() {System.out.println("speaker volumedown11");}
}
//1) 고전
class SsTVs implements TV{
	private Speaker speaker = new Speaker();
	public SsTVs() {System.out.println("SsTVs 생성자");}
	public void  powerOn() { System.out.println("~~ SsTV turnOn ~~"); }
	public void  powerOff() { System.out.println("~~ SsTV turnOff ~~"); }
	public void  volumeUp() { speaker.volumeUp(); }
	public void  volumeDown() { speaker.volumeDown();}
}

class LgTVs implements TV{
	private Speaker speaker;
	private int price;
	public LgTVs() {System.out.println("LgTVs 생성자");}
	public LgTVs(Speaker speaker,int price) {
		this.speaker = speaker;
		this.price = price;
		System.out.println("Lg"+speaker+"+"+price);
	} // 생성자 이용한 setter => 생성한 이후에는 값을 set할수가 없다 .
	public void  powerOn() { System.out.println("~~ LgTV powerOn ~~"); }
	public void  powerOff() { System.out.println("~~ LgTV powerOff ~~"); }
	public void  volumeUp() { speaker.volumeUp(); }
	public void  volumeDown() { speaker.volumeDown(); }
}

class AiTVs implements TV{
	private Speaker speaker;
	private int price;
	public AiTVs() {System.out.println("AiTVs 생성자");}
	
	public void setSpeaker(Speaker speaker) {this.speaker = speaker;}
	public void setPrice(int price) {this.price = price;}
	
	public void  powerOn() { System.out.println("~~ AiTVs powerOn ~~" +price+"+"+speaker); }
	public void  powerOff() { System.out.println("~~ AiTVs powerOff ~~"); }
	public void  volumeUp() { speaker.volumeUp(); }
	public void  volumeDown() { speaker.volumeDown(); }
}


public class TVUser03_Speaker {

	public static void main(String[] args) {
		// 1. 스프링 컨테이너 구동(생성) 
	      AbstractApplicationContext sc = new 
	            GenericXmlApplicationContext("iocDI01_xml/app03.xml");
	      
	      // 2. 필요한 객체를 전달받고 서비스 실행 
	      System.out.println("**  Test1) 고전적방법 : 직접 new  **");
	      TV tvs = (TV)sc.getBean("tvs");
	      tvs.powerOn();
	      tvs.volumeUp();
	      tvs.volumeDown();
	      tvs.powerOff();
	      
	      System.out.println("**  Test2) IOC/DI : 생성자 주입  **");
	      TV tvl = (TV)sc.getBean("tvl");
	      tvl.powerOn();
	      tvl.volumeUp();
	      tvl.volumeDown();
	      tvl.powerOff();
	      
	      System.out.println("**  Test3) IOC/DI : Setter 주입  **");
	      TV tva = (TV)sc.getBean("tva");
	      tva.powerOn();
	      tva.volumeUp();
	      tva.volumeDown();
	      tva.powerOff();
	      
	      sc.close();
	}

}
