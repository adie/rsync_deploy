# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rsync_deploy/version"

Gem::Specification.new do |s|
  s.name        = "rsync_deploy"
  s.version     = RsyncDeploy::VERSION
  s.authors     = ["Anton Dieterle"]
  s.email       = ["antondie@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Deploy tool using rsync}
  s.description = %q{Deploy tool using rsync}

  s.rubyforge_project = "rsync_deploy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_runtime_dependency "colorize"
  s.add_runtime_dependency "shell-spinner"
end
