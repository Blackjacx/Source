Pod::Spec.new do |s|
  s.name             = 'Source'
  s.version          = '0.0.12'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.summary          = 'The generic data source implementation for all your view controllers.'
  s.description      = <<-DESC
Tired of implementing the data sources over and over again? Want to use a lightweight solution that does not mess up your view controllers? Then this is for you! The generic data source implementation for all your view controllers, that supports UITableView, UICollectionView and NSFetchedResultsController.
                       DESC
  s.homepage         = 'https://github.com/Blackjacx/Source'
  s.social_media_url = 'https://twitter.com/Blackjacxxx'
  s.author           = { 'Stefan Herold' => 'stefan.herold@gmail.com' }
  s.source           = { :git => 'https://github.com/Blackjacx/Source.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.3'

  s.source_files = 'Source/**/*'
end
