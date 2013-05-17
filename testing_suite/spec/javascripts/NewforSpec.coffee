describe 'Newfor', ->
  beforeEach ->
    app = new Newfor()

  it 'should parse current sub text as block', ->
    d = getJSONFixture('newfor_fixture_one_line.json')
    expect(Newfor.currentTextAsBlock(d.data.subt.rows)).toEqual("stayed up... And incomes of")

  it 'should parse current sub text as block 2 lines', ->
    d = getJSONFixture('newfor_fixture_two_line.json')
    expect(Newfor.currentTextAsBlock(d.data.subt.rows)).toEqual("months and it is expected to keep<br>on")

  it 'should put the text into the correct line divs', ->
    loadFixtures('suite_fixture.html')
    d = getJSONFixture('newfor_fixture_two_line.json')
    Newfor.twoTineScroll(d.data.subt.rows)
    expect($('#line1')).toHaveText('months and it is expected to keep')
    expect($('#line0')).toHaveText('on')

  it 'should clear out all text from childrens divs', ->
    loadFixtures('suite_fixture.html')
    Newfor.clearScroll()
    expect($('#line1')).toHaveText('')
    expect($('#line0')).toHaveText('')

  it 'should add current-txt to main text', ->
    loadFixtures('suite_fixture.html')
    Newfor.appendCurrentTxtToMain()
    expect($('#current-text-as-block')).toHaveHtml('some text...<span id="current-txt"> some more text</span>')


