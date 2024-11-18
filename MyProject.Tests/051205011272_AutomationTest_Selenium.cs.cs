using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Support.UI;
using System;
using WebDriverManager;
using WebDriverManager.DriverConfigs.Impl;

namespace MyProject.Tests
{
    public class CalculationTests : IDisposable
    {
        private readonly IWebDriver _driver;

        public CalculationTests()
        {
            new WebDriverManager.DriverManager().SetUpDriver(new ChromeConfig());

            _driver = new ChromeDriver();
        }

        [Fact]
        public void Test_ValidInputs_CalculateFate()
        {
            _driver.Navigate().GoToUrl("http://localhost:5173/calculation");

            var dateOfBirth = _driver.FindElement(By.Id("userForm_YOB"));
            dateOfBirth.SendKeys("1990-01-01");

            var genderMale = _driver.FindElement(By.XPath("//input[@value='Male']"));
            genderMale.Click();

            var calculateButton = _driver.FindElement(By.ClassName("calculate-button"));
            calculateButton.Click();

            Thread.Sleep(2000);

            var fateElement = _driver.FindElement(By.XPath("//h3[contains(text(), 'Mệnh của bạn là')]"));
            Assert.NotNull(fateElement);
            Assert.Contains("Mệnh của bạn là", fateElement.Text);
        }

        [Fact]
        public void Test_EmptyInputs_ShowErrorMessage()
        {
            _driver.Navigate().GoToUrl("http://localhost:5173/calculation");

            var calculateButton = _driver.FindElement(By.ClassName("calculate-button"));
            calculateButton.Click();

            Thread.Sleep(2000);

            var errorMessage = _driver.FindElement(By.ClassName("ant-form-item-explain"));
            Assert.NotNull(errorMessage);
            Assert.Contains("Hãy chọn ngày sinh của bạn!", errorMessage.Text);
        }

        [Fact]
        public void Test_MissingDateOfBirth_ShowErrorMessage()
        {
            _driver.Navigate().GoToUrl("http://localhost:5173/calculation");

            // Chọn giới tính mà không nhập ngày tháng năm sinh
            var genderMale = _driver.FindElement(By.XPath("//input[@value='Male']"));
            genderMale.Click();

            var calculateButton = _driver.FindElement(By.ClassName("calculate-button"));
            calculateButton.Click();

            Thread.Sleep(2000);

            // Kiểm tra thông báo lỗi yêu cầu nhập ngày tháng năm sinh
            var errorMessage = _driver.FindElement(By.ClassName("ant-form-item-explain"));
            Assert.NotNull(errorMessage);
            Assert.Contains("Hãy chọn ngày sinh của bạn!", errorMessage.Text);
        }

        [Fact]
        public void Test_MissingGender_ShowErrorMessage()
        {
            _driver.Navigate().GoToUrl("http://localhost:5173/calculation");

            var dateOfBirth = _driver.FindElement(By.Id("userForm_YOB"));
            dateOfBirth.SendKeys("1990-01-01");

            var calculateButton = _driver.FindElement(By.ClassName("calculate-button"));
            calculateButton.Click();

            Thread.Sleep(2000);

            var errorMessage = _driver.FindElement(By.ClassName("ant-form-item-explain"));
            Assert.NotNull(errorMessage);
            Assert.Contains("Hãy chọn giới tính của bạn!", errorMessage.Text);
        }

        public void Dispose()
        {
            _driver.Quit();
        }
    }
}