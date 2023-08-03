package com.dobby.project.ming.controller;

import com.dobby.project.ming.dao.*;
import com.dobby.project.ming.domain.*;
import com.dobby.project.ming.service.*;
import com.dobby.project.soo.SearchCondition;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.*;
import java.net.URLEncoder;
import org.springframework.ui.*;
import org.springframework.web.servlet.mvc.support.*;
import java.time.*;
import java.util.*;

@Controller
@RequestMapping("/memberPage")
public class AdminPageMemberController {
    @Autowired
    UserService userService;

    @PostMapping("/modify")
    public String modify(UserDto userDto, User user, Integer page, Integer pageSize, RedirectAttributes rattr, Model m, HttpSession session) {

        String writer = (String)session.getAttribute("MBR_ID");
        userDto.setMBR_NM(writer);

        try {
            if (userService.modify(user)!= 1)
                throw new Exception("Modify failed.");

            rattr.addAttribute("page", page);
            rattr.addAttribute("pageSize", pageSize);
            rattr.addFlashAttribute("msg", "MOD_OK");
            return "redirect:/board/list";
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute(user);
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
            m.addAttribute("msg", "MOD_ERR");
            return "board"; // 등록하려던 내용을 보여줘야 함.
        }
    }

    /*@PostMapping("/write") // insert니까 delete인 remove하고 동일
    public String write(UserDto userDto, RedirectAttributes rattr, Model m, HttpSession session) {
        String writer = (String)session.getAttribute("MBR_ID");
        userDto.setWriter(writer);

        try {
            if (userService.write(userDto) != 1)
                throw new Exception("Write failed.");

            rattr.addFlashAttribute("msg", "WRT_OK");
            return "redirect:/board/list";
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("mode", "new"); // 글쓰기 모드로
            m.addAttribute(boardDto);      // 등록하려던 내용을 보여줘야 함.
            m.addAttribute("msg", "WRT_ERR");
            return "board";
        }
    }*/

    @GetMapping("/read")
    public String read(String MBR_ID, Integer page, Integer pageSize, RedirectAttributes rattr, Model m) {
        try {
            UserDto userDto = userService.read(MBR_ID);
            m.addAttribute(userDto);
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
        } catch (Exception e) {
            e.printStackTrace();
            rattr.addAttribute("page", page);
            rattr.addAttribute("pageSize", pageSize);
            rattr.addFlashAttribute("msg", "READ_ERR");
            return "redirect:/memberPage/list";
        }

        return "/memberPage/list";
    }
    @PostMapping("/remove")
    public String remove(String MBR_ID, Integer page, Integer pageSize, RedirectAttributes rattr, HttpSession session) {
        String writer = (String)session.getAttribute("MBR_ID");
        String msg = "DEL_OK";

        try {
            if(userService.remove(MBR_ID)!=1)
                throw new Exception("Delete failed.");
        } catch (Exception e) {
            e.printStackTrace();
            msg = "DEL_ERR";
        }

        rattr.addAttribute("page", page);
        rattr.addAttribute("pageSize", pageSize);
        rattr.addFlashAttribute("msg", msg);
        return "redirect:/memberPage/list";
    }

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue ="1") Integer page,
                       @RequestParam(defaultValue = "10") Integer pageSize,Model m, HttpServletRequest request) {
        if(loginCheck(request))
            return "redirect:/login";

        try {
            int totalCnt = userService.getCount();
            m.addAttribute("totalCnt", totalCnt);

            PageHandler pageHandler = new PageHandler(totalCnt, page, pageSize);

            Map map = new HashMap();
            map.put("offset", (page-1)*pageSize);
            map.put("pageSize", pageSize);

            List<UserDto> list = userService.getPage(map);
            m.addAttribute("list", list);
            m.addAttribute("ph", pageHandler);

            Instant startOfToday = LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant();
            m.addAttribute("startOfToday", startOfToday.toEpochMilli());
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "LIST_ERR");
            m.addAttribute("totalCnt", 0);
        }
        return "ming/memberPage";
    }

    private boolean loginCheck(HttpServletRequest request) {

        HttpSession session = request.getSession();
        return session.getAttribute("MBR_ID")!=null;
    }
}

