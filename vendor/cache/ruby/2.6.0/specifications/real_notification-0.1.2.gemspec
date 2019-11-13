# -*- encoding: utf-8 -*-
# stub: real_notification 0.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "real_notification".freeze
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Abhishek Kanojia".freeze]
  s.bindir = "exe".freeze
  s.date = "2018-04-29"
  s.description = " Real Notification provided push notification using action cable for rails application. ".freeze
  s.email = ["abhishek.kanojia3193@gmail.com".freeze]
  s.homepage = "https://github.com/abhikanojia/real_notification".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Real Notification provided push notification using action cable for rails application.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.16"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_runtime_dependency(%q<bootstrap-sass>.freeze, ["~> 3.3", ">= 3.3.7"])
      s.add_runtime_dependency(%q<jquery-rails>.freeze, ["~> 4.3", ">= 4.3.3"])
      s.add_runtime_dependency(%q<redis>.freeze, ["~> 4.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<bootstrap-sass>.freeze, ["~> 3.3", ">= 3.3.7"])
      s.add_dependency(%q<jquery-rails>.freeze, ["~> 4.3", ">= 4.3.3"])
      s.add_dependency(%q<redis>.freeze, ["~> 4.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<bootstrap-sass>.freeze, ["~> 3.3", ">= 3.3.7"])
    s.add_dependency(%q<jquery-rails>.freeze, ["~> 4.3", ">= 4.3.3"])
    s.add_dependency(%q<redis>.freeze, ["~> 4.0"])
  end
end
