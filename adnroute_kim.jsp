<%@page contentType="text/plain" import="java.io.FileWriter,java.io.File,java.text.SimpleDateFormat,java.util.Calendar" pageEncoding="UTF-8"%>
<%!
    Calendar cal=Calendar.getInstance();
    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    SimpleDateFormat sdfDate=new SimpleDateFormat("yyyyMMddHHmm");
	String logFolder="/opt/adncdr/rcvconfirm/";
    String fileName="routed.";

 //String[] routingUrls={"http://ad.alpasrame.com/adserver/click?pid=56&campaignid=256&clickid=<CLICKID>&pubid="};
// String[] routingUrls={"http://becanium.com/portent/netbios/acl/1-19292-888a9ca13eb7c699468f5c5a7a8f73db?tvu=test&click_id=<CLICKID>&ext1="};
 String[] routingUrls={"http://wichjoinq.com/portent/netbios/acl/1-19292-c083f29d2ee08e04a8908d8752f911af?tvu=WW_SL_MS&click_id=<CLICKID>&ext1="};
 http://becanium.com/portent/netbios/acl/1-19292-888a9ca13eb7c699468f5c5a7a8f73db?tvu=test&click_id={REPLACE}&ext1={YOUR subpublid}
    int[] routingPercent={100};
    
%>
<%
    int rcnt=(int)(routingUrls.length*Math.random());
        if(rcnt>=routingUrls.length) rcnt--;
            
            checkDir(logFolder);
            String clickid=request.getParameter("cid");
            String sourceName=request.getParameter("source");
            String remoteIp=request.getRemoteAddr();
            cal.setTimeInMillis(System.currentTimeMillis());
            String timeStr=sdf.format(cal.getTime());
            String routingUrl=routingUrls[rcnt];
            routingUrl=routingUrl.replaceAll("<CLICKID>", clickid);
            StringBuilder sb=new StringBuilder();
            sb.append(timeStr).append("|source=").append(sourceName).append("|sourceIp=").append(remoteIp).
                    append("|clickId=").append(clickid).append("|dest=").append(routingUrl);
                    String newFileName=fileName+"."+sdfDate.format(cal.getTime())+".cdr";
			createLog(newFileName,clickid,sourceName,sb.toString());
                    response.sendRedirect(routingUrl);
                    %>
                    <%!
                    public void createLog(String newFileName,String clickId,String sourceName,String logStr){
                    try{
                    FileWriter fw=new FileWriter(logFolder+sourceName+"_"+newFileName,true);
                    fw.write("\n"+logStr);
                    fw.flush();
                    fw.close();
                    fw=null;
                    }catch(Exception e){}
                    }
                    public void checkDir(String folder){
                    try{
                    File f=new File(folder);
                    if(f.exists()==false || !f.isDirectory())
                    f.mkdirs();
                    f=null;
                    }catch(Exception e){}
                    }

                    %>

