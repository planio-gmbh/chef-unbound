maintainer       "Planio GmbH"
maintainer_email "support@plan.io"
license          "Apache 2.0"
description      "Manages unbound DNS resolver"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "unbound::default", "Installs unbound and sets up configuration files"

suggests 'runit'
