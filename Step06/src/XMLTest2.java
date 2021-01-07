import java.io.File;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class XMLTest2 {
	
	public static void PrintNode(Node n) {
		//Node의 자식 노드들을 전부 출력하는 기능
		NodeList nl = n.getChildNodes();
		for(int i=0;i<nl.getLength();i++) {
			Node tmp = nl.item(i);
			if(tmp.getNodeType() == Node.ELEMENT_NODE) {
				if(tmp.getChildNodes().getLength() > 1) {
					PrintNode(tmp);
				}
				else {
					System.out.print(tmp.getNodeName() + " : " + tmp.getTextContent());
					/*
					 * if(tmp.hasAttributes()) { System.out.print("Attr:" +
					 * tmp.getAttributes().getNamedItem("no").getTextContent()); }
					 */
					System.out.println("\n");
				}
				
			}
		}
	}
	
	public static void main(String[] args) throws Exception {
		
		File file = new File("test.xml");
		DocumentBuilderFactory f = DocumentBuilderFactory.newDefaultInstance();
		DocumentBuilder dBuilder = f.newDocumentBuilder();
		Document doc = dBuilder.parse(file);
		doc.getDocumentElement().normalize();
		
		String root = doc.getDocumentElement().getNodeName();
		System.out.println("root :" + root);
		NodeList list = doc.getElementsByTagName(root);
		
		PrintNode(list.item(0));

		
	}
}
