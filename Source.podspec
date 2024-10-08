Pod::Spec.new do |s|
  s.name             = 'Source'
  s.version          = '1.12.0'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.summary          = 'The generic data source implementation for all your view controllers.'
  s.description      = <<-DESC
Tired of implementing the data sources over and over again? Want to use a lightweight solution that does not mess up your view controllers? Then this is for you! The generic data source implementation for all your view controllers, that supports UITableView, UICollectionView and NSFetchedResultsController.
                       DESC
  s.homepage         = 'https://github.com/Blackjacx/Source'
  s.social_media_url = 'https://x.com/Blackjacxxx'
  s.author           = { 'Stefan Herold' => 'stefan.herold@gmail.com' }
  s.source           = { :git => 'https://github.com/Blackjacx/Source.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '14.0'

  s.source_files = 'Source/**/*'
  s.frameworks = 'UIKit'
  s.swift_versions = ['5.10']

  # s.resource_bundles = {
  #   'Resources' => ['Source/Strings/*.lproj/*.strings']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
end
