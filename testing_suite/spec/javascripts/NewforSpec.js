describe('Newfor', function() {
  beforeEach(function() {
    var app;
    return app = new Newfor();
  });
  it('should parse current sub text as block', function() {
    var d;
    d = getJSONFixture('newfor_fixture_one_line.json');
    return expect(Newfor.currentTextAsBlock(d.data.subt.rows)).toEqual("stayed up... And incomes of");
  });
  it('should parse current sub text as block 2 lines', function() {
    var d;
    d = getJSONFixture('newfor_fixture_two_line.json');
    return expect(Newfor.currentTextAsBlock(d.data.subt.rows)).toEqual("months and it is expected to keep<br>on");
  });
  it('should put the text into the correct line divs', function() {
    var d;
    loadFixtures('suite_fixture.html');
    d = getJSONFixture('newfor_fixture_two_line.json');
    Newfor.twoTineScroll(d.data.subt.rows);
    expect($('#line1')).toHaveText('months and it is expected to keep');
    return expect($('#line0')).toHaveText('on');
  });
  it('should clear out all text from childrens divs', function() {
    loadFixtures('suite_fixture.html');
    Newfor.clearScroll();
    expect($('#line1')).toHaveText('');
    return expect($('#line0')).toHaveText('');
  });
  return it('should add current-txt to main text', function() {
    loadFixtures('suite_fixture.html');
    Newfor.appendCurrentTxtToMain();
    return expect($('#current-text-as-block')).toHaveHtml('some text...<span id="current-txt"> some more text</span>');
  });
});