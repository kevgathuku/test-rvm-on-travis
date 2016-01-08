Test RVM on Travis
==================

This repository shows how to config Travis CI using `.travis.yml` to build your
project against the latest patch version of Ruby.

You can see the working configuration in [`.travis.yml`](.travis.yml#L6-L19).

Problem
-------

* Setting the Ruby version using partial string (such as `2.1` for latest patch
  version of Ruby 2.1) resulted in getting Ruby 2.1.0 instead.
* RVM is _very_ behind on Travis CI, resulting in outdated latest patch version.
* It's impossible to install Ruby 2.3.0 on Travis CI.

This table also explains the current problem:

| Requested Ruby version | Expected Ruby version | Actual Ruby version |
|------------------------|-----------------------|---------------------|
| 1.9.3                  | 1.9.3-p551            | 1.9.3-p551          |
| 2.0                    | 2.0.0-p648            | _2.0.0-p598_        |
| 2.1                    | 2.1.8                 | _2.1.5_             |
| 2.2                    | 2.2.4                 | _2.2.0_             |
| 2.3                    | 2.3.0                 | _Build Errored_     |

How to Fix
----------

* Remove `travis-ruby` URL override, which stored in `$rvm_path/user/db`.
  This file no longer necessary as RVM already has `travis-ruby` in its source.
  This fixes Ruby 2.3.0 installation issue.
  ([travis-ci/travis-build#588](https://github.com/travis-ci/travis-build/pull/588))
* Remove outdated aliases in RVM that was set by Travis CI. These aliases were
  configured so that `2.0` would point to `2.0.0-p648`, which is unnecessary.
  This makes RVM correctly install latest patch versions.
* Update RVM to the latest version. However, since Travis CI does not have a
  `before_rvm` hook, I had to let Travis CI fallback to default Ruby then
  perform the upgrade in `before_install` block. This updates RVM's known Ruby
  list.
* To make Travis CI fallback to default Ruby, I had to stop using `rvm`
  directive and set Ruby version in `RUBY` environment variable instead.
  This fixes Ruby 2.3.0 installation issue, as the build was errored out before
  any script could run.

You can look at the successfull build with example matrix on
[Travis CI](https://travis-ci.org/sikachu/test-rvm-on-travis/builds/101165761).

Contributions
-------------

We love contributions from everyone. By participating in this project, you
agree to abide by this
[code of conduct](https://thoughtbot.com/open-source-code-of-conduct).

Please feel free to open new issues or submit pull requests if you found any
issue with these code.

License
-------

The MIT License (MIT)

Copyright (c) 2016 Prem Sichanugrist

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
