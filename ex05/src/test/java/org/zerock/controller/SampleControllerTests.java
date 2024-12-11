package org.zerock.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.zerock.domain.Ticket;

import com.google.gson.Gson;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)

// Test for Controller
@WebAppConfiguration

@ContextConfiguration({
    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
    "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
// Java Config
//@ContextConfiguration(classes = {
//    org.zerock.config.RootConfig.class,
//    org.zerock.config.ServletConfig.class
//})
@Log4j
public class SampleControllerTests {

    @Setter(onMethod_ = @Autowired)
    private WebApplicationContext ctx;

    private MockMvc mockMvc;

    @Before
    public void setup() {
    	// Spring MVC 애플리케이션 컨텍스트를 사용하여 가상 서버를 구성
        this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
    }

    @Test
    public void testConvert() throws Exception {
        Ticket ticket = new Ticket();
        ticket.setTno(123);
        ticket.setOwner("Admin");
        ticket.setGrade("AAA");

        String jsonStr = new Gson().toJson(ticket); // Ticket 객체를 JSON 문자열로 변환

        log.info(jsonStr);

        // /sample/ticket 경로로 JSON 데이터를 POST 요청으로 보낸다.
        mockMvc.perform(post("/sample/ticket")
                .contentType(MediaType.APPLICATION_JSON) // JSON 형식으로 전송
                .content(jsonStr)) // JSON 데이터를 요청 본문에 포함
                .andExpect(status().is(200)); // 상태 코드가 200 OK인지 확인
    }
}
