# Uncomment the next line to define a global platform for your project
platform :ios, '14.3'

target 'ValentineClub' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks! 

  # Pods for ValentineClub
  pod 'Parse'
  pod 'Toast-Swift', '~> 5.0.1'
  pod "AlamofireImage"

  target 'ValentineClubTests' do
    inherit! :search_paths
    # Pods for testing
  pod 'Parse'
  end

  target 'ValentineClubUITests' do
    # Pods for testing

  pod 'Parse'
  end

end

def fix_config(config)
  if config.build_settings['DEVELOPMENT_TEAM'].nil?
    config.build_settings['DEVELOPMENT_TEAM'] = '<YOUR TEAM ID HERE>'
  end
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.build_configurations.each do |config|
        fix_config(config)
    end
    project.targets.each do |target|
      target.build_configurations.each do |config|
        fix_config(config)
      end
    end
  end
end
