Pod::Spec.new do |s|
  s.name             = 'Sourcery'
  s.version          = '0.0.1'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.summary          = 'The generic data source implementation for all your view controllers, that supports UITableView, UICollectionView and NSFetchedResultsController.'
  s.description      = <<-DESC
Tired of implementing the data sources over and over again? Want to use a lightweight solution that does not mess up your view controllers? Then this is for you! The generic data source implementation for all your view controllers, that supports UITableView, UICollectionView and NSFetchedResultsController.
                       DESC
  s.homepage         = 'https://github.com/Blackjacx/Sourcery'
  s.social_media_url = 'https://twitter.com/Blackjacxxx'
  s.author           = { 'Stefan Herold' => 'stefan.herold@gmail.com' }
  s.source           = { :git => 'https://github.com/Blackjacx/Sourcery.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.0'

  s.source_files = 'Source/**/*'
end
