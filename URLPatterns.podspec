
Pod::Spec.new do |s|
  s.name             = "URLPatterns"
  s.version          = "0.1.6"
  s.summary          = "A small library to enable more idiomatic Swift pattern matching of URL path elements."

  s.description      = <<-DESC
                        URLPatterns is a small library to enable more idiomatic Swift pattern matching of URL path elements.
                    `NSURL` is extended with the method `countedPathElements()`, which converts the URL's' array of path elements
                    into a `Counted` enum. Each case in `Counted` has a different number of associated values, which makes
                    pattern-matching each element easy, including wildcard, value-binding, begins and ends patterns.
                       DESC

  s.homepage         = "https://github.com/johnpatrickmorgan/URLPatterns"
  s.license          = 'MIT'
  s.author           = { "johnmorgan" => "johnpatrickmorganuk@gmail.com" }
  s.source           = { :git => "https://github.com/johnpatrickmorgan/URLPatterns.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jpmmusic'

  s.ios.deployment_target = '8.0'

  s.source_files = 'URLPatterns/Classes/**/*'
end
