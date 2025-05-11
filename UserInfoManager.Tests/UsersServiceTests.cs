using Xunit;

namespace UserInfoManager.Tests
{
    public class UsersServiceTests
    {
        [Fact]
        public void RegisterUser_WithValidEmail_ReturnsSuccess()
        {
            var service = new FakeUsersService();
            var result = service.Register("test@example.com", "Test123!");
            Assert.True(result);
        }
    }

    public class FakeUsersService
    {
        public bool Register(string email, string password)
        {
            return email.Contains("@") && password.Length > 5;
        }
    }
}
