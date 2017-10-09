import { AngularTriesPage } from './app.po';

describe('angular-tries App', () => {
  let page: AngularTriesPage;

  beforeEach(() => {
    page = new AngularTriesPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
