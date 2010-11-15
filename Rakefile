begin
  require "jeweler"

  Jeweler::Tasks.new do |gem|
    gem.name = "toker"
    gem.version = "0.1"
    gem.summary = "Simple client for the new OpenTok."
    gem.description = <<-desc
      Simple client for the new OpenTok.
    desc
    gem.email = "brett@intraspirit.net"
    gem.homepage = ""
    gem.date = Time.now.strftime('%Y-%m-%d')
    gem.authors = ["Brett Buddin"]
    gem.files = %w( README.md Rakefile LICENSE )
    gem.files += Dir["*", "{lib}/**/*"]
    gem.add_dependency 'httparty'

    gem.has_rdoc = false
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
