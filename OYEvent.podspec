Pod::Spec.new do |s|
  s.name                      = "OYEvent"
  s.version                   = "1.0"
  s.summary                   = "Post-Observe Event with using Notification Center"

  s.homepage                  = "https://github.com/osmanyildirim/OYEvent.git"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = { "osmanyildirim" => "github.com/osmanyildirim" }

  s.ios.deployment_target     = "11.0"
  s.swift_version             = "5.7"
  s.requires_arc              = true

  s.source                    = { git: "https://github.com/osmanyildirim/OYEvent.git", :tag => s.version }
  s.source_files              = "Sources/**/*.*"
end