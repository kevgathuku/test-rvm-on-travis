# encoding: UTF-8

RUBY_VERSIONS = %(
  1.9.3
  2.0.0
  2.1.8
  2.2.4
  2.3.0
  2.4.0
)

success = RUBY_VERSIONS.include?(RUBY_VERSION)

puts "#{RUBY_VERSION} #{success ? "✅" : "❌"}"
exit(success ? 0 : 1)
