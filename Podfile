source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/artsy/Specs.git'

platform :ios, '7.0'

# Yep.
inhibit_all_warnings!

# Artsy stuff
pod 'Artsy+UIColors'
pod 'Artsy+UILabels'
pod 'Artsy-UIButtons'

# We'll need to include travis some time.
if ENV['USER'] == "orta" || ENV['USER'] == "ash" || ENV['USER'] == "artsy" || ENV['USER'] == "Laura"
    pod 'Artsy+UIFonts', :git => 'https://github.com/artsy/Artsy-UIFonts.git', :branch => 'new-tracking'
else
    pod 'Artsy+OSSUIFonts'
end

pod 'Artsy+UILabels'
pod 'ORStackView'
pod 'FLKAutoLayout'
pod 'ISO8601DateFormatter', '0.7'
pod 'ARCollectionViewMasonryLayout', '~> 2.0.0'
pod 'SDWebImage', '~> 3.7'

pod 'HockeySDK', '3.5.4'
pod 'ARAnalytics/Mixpanel'
pod 'ARAnalytics/HockeyApp'

pod 'CardFlight'
pod 'ECPhoneNumberFormatter'
pod 'UIImageViewAligned', :git => 'https://github.com/orta/UIImageViewAligned.git'
pod 'DZNWebViewController', :git => "https://github.com/orta/DZNWebViewController.git"

target "KioskTests", :exclusive => true do
    pod 'FBSnapshotTestCase', :git => 'https://github.com/AshFurrow/ios-snapshot-test-case.git', :branch => 'renderAsLayer'
end
