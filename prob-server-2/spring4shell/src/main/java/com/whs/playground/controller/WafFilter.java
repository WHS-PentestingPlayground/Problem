
package com.whs.playground.controller;

import org.springframework.stereotype.Component;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class WafFilter implements Filter {

    private static final String[] BLOCKED_KEYWORDS = {"cat", "nc", "bash", "netcat", "wget", "curl"};

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        String command = httpServletRequest.getParameter("cmd");

        if (command != null) {
            for (String keyword : BLOCKED_KEYWORDS) {
                if (command.toLowerCase().contains(keyword)) {
                    ((HttpServletResponse) response).sendError(HttpServletResponse.SC_FORBIDDEN, "Malicious command detected by WAF.");
                    return; 
                }
            }
        }
        
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
