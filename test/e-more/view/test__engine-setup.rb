module EMoreTest__View__Engine
  class App < E
    map '/'

    layout :layout
    engine :Haml

    format '.xml', '.txt'

    setup '.xml' do
      engine :ERB
    end

    setup 'blah.xml' do
      engine :String
      layout false
    end

    setup 'blah.txt' do
      engine :Slim
    end

    def index
      @var = 'val'
      render
    end

    def blah
      render
    end

  end

  Spec.new App do

    get
    expect(last_response.body) == "HAML Layout/\nval\n"

    get 'index.xml'
    expect(last_response.body) == 'Hello .xml template from .xml layout!'

    get :blah
    expect(last_response.body) == "HAML Layout/\nblah.haml\n"

    It "should use :String engine with .str extension, no layout" do
      expect(get('blah.xml').body) == "blah.xml.str"
    end

    It "should use Slim engine" do
      expect { get('blah.txt').body } == 'Slim Layout|blah.txt.slim'
    end

  end
end
