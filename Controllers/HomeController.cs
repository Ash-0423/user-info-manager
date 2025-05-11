using Microsoft.AspNetCore.Mvc;
using UserInfoManager.Data;
using UserInfoManager.Service;

namespace UserInfoManager.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;
    private readonly UsersService _userService;
    private readonly IConfiguration _configuration;
    private readonly UserContactDataAccess _userContactDataAccess;
    public HomeController(ILogger<HomeController> logger, UsersService userService, IConfiguration configuration, UserContactDataAccess userContactDataAccess)
    {
        _logger = logger;
        _userService = userService;
        _configuration = configuration;
        _userContactDataAccess = userContactDataAccess;
    }

    public IActionResult Index()
    {
        ViewBag.ApiHost = _configuration.GetSection("Settings")["apihost"];
        return View();
    }

    public IActionResult Create()
    {
        ViewBag.ApiHost = _configuration.GetSection("Settings")["apihost"];
        return View();
    }

    public IActionResult CreateConnect()
    {
        ViewBag.ApiHost = _configuration.GetSection("Settings")["apihost"];
        return View();
    }

    public IActionResult Privacy()
    {
        ViewBag.ApiHost = _configuration.GetSection("Settings")["apihost"];
        return View();
    }

    public IActionResult Edit(int id)
    {
        ViewBag.ApiHost = _configuration.GetSection("Settings")["apihost"];
        return View();
    }

    public IActionResult EditConnect(int id)
    {
        ViewBag.ApiHost = _configuration.GetSection("Settings")["apihost"];
        return View();
    }

    /// <summary>
    /// ע��
    /// </summary>
    /// <returns></returns>
    [HttpPost]
    public async Task<IActionResult> Logout()
    {
        //// �����ǰ�û��������֤��Ϣ
        //await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

        //// ����κ�֮ǰ��¼ʱ���õ���ʱ��Ϣ
        //TempData.Clear();

        return Redirect("/accountview/login");
    }
}
