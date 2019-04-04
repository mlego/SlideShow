workspace 'SlideShow.xcworkspace'
use_frameworks!

# Common
def pod_common
    pod 'Alamofire', '~> 4.8.1'
end

def project_show_engine
    project 'ShowEngineFramework/ShowEngineFramework.xcodeproj'
end

def platform_ios
    platform :ios, '12.2'
end

def platform_macos
    platform :osx, '10.14'
end

def platform_tvos
    platform :tvos, '12.2'
end

def platform_watchos
    platform :watchos, '5.2'
end

# SlideShow targets
target 'SlideShow-iphone' do
    platform_ios
    pod_common
end

target 'SlideShow-mac' do
    platform_macos
    pod_common
end

target 'SlideShow-tv' do
    platform_tvos
    pod_common
end

target 'SlideShow-watch' do
    platform_watchos
    pod_common
end

target 'SlideShow-watch Extension' do
    platform_watchos
    pod_common
end

# ShowEngine Framework targets
target 'ShowEngine-iOS' do
    platform_ios
    project_show_engine
    pod_common
end

target 'ShowEngine-macOS' do
    platform_macos
    project_show_engine
    pod_common
end

target 'ShowEngine-tvOS' do
    platform_tvos
    project_show_engine
    pod_common
end

target 'ShowEngine-watchOS' do
    platform_watchos
    project_show_engine
    pod_common
end
