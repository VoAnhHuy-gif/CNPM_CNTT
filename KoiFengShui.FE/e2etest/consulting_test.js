Feature('Consulting');

Scenario('User can access and use the consulting feature', ({ I }) => {
  I.amOnPage('/');
  I.click('Tư vấn cá và hồ theo bản mệnh');
  I.waitForElement('.datePicker', 5);
  I.fillField('.datePicker', '1990-01-01');
  I.click('Nam');
  I.click('Tính mệnh của bạn');

//   I.waitForElement('.Guest-fate', 5);
  I.see('Mệnh của bạn là:');
  I.see('Cung mệnh của bạn là:');
  I.click('Tiếp tục tư vấn');

//   I.waitForElement('.koi-cards', 5);
//   I.see('Các loại cá phù hợp');

//   I.waitForElement('.pond-shape', 5);
//   I.see('Đặc điểm hồ phù hợp');

//   I.waitForElement('.pond-direction', 5);
//   I.see('Hướng:');
});