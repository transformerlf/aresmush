$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require "aresmush"

module AresMUSH

  describe LocaleLoader do

    describe :load_plugin_locales do
      it "should find all the plugin dirs" do
        LocaleLoader.should_receive(:find_plugin_dirs).with("path") { [] }
        LocaleLoader.load_plugin_locales("path")
      end
      
      it "should load the locales dir from each plugin" do
        LocaleLoader.stub(:find_plugin_dirs).with("path") { [ "a", "b" ] }
        LocaleLoader.should_receive(:load_dir).with(File.join("a", "locales"))
        LocaleLoader.should_receive(:load_dir).with(File.join("b", "locales"))
        LocaleLoader.load_plugin_locales("path")
      end
    end
    
    describe :find_plugin_dirs do
      it "should find all files in the path" do
        Dir.should_receive(:glob).with(File.join("path", "*")) { [] }
        LocaleLoader.find_plugin_dirs("path")
      end

      it "should return the files that are directories" do
        Dir.stub(:glob).with(File.join("path", "*")) { ["a", "b"] }
        File.stub(:directory?).with("a") { false }
        File.stub(:directory?).with("b") { true }
        LocaleLoader.find_plugin_dirs("path").should eq [ "b" ]
      end
    end
    
    describe :load_dir do
      it "should do nothing if the dir doesn't exist" do
        Dir.stub(:exist?).with("dir") { false }
        LocaleLoader.should_not_receive(:load_file)
        LocaleLoader.load_dir("dir")
      end
      
      it "should load each file in the dir" do
        Dir.stub(:exist?).with("dir") { true }
        Dir.stub(:foreach).with("dir").and_yield("a").and_yield("b")
        LocaleLoader.should_receive(:load_file).with(File.join("dir", "a"))
        LocaleLoader.should_receive(:load_file).with(File.join("dir", "b"))
        LocaleLoader.load_dir("dir")
      end
    end
    
    describe :load_file do
      it "should do nothing if the file is a directory" do
        File.stub(:directory?).with("f") { true }
        I18n.load_path.should_not_receive(:<<).with("f")
        LocaleLoader.load_file("f")
      end

      it "should pass along a regular file to the backend" do
        File.stub(:directory?).with("f") { false }
        I18n.load_path.should_receive(:<<).with("f")
        LocaleLoader.load_file("f")
      end
    end
  end
end
