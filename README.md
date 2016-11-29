# RalesEngine Spec Harness

This gem contains an http-based spec harness for validating
functionality on student implementations of the 
[RalesEngine](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/rails_engine.md)
project at Turing.

## Installation

To use this repository, simply clone it onto your machine and bundle:

```
git clone https://github.com/turingschool/rales_engine_spec_harness.git
cd rales_engine_spec_harness
bundle
```

## Usage

Run the tests with `rake`:

```
worace ➸ rake
/usr/local/var/rbenv/versions/2.1.1/bin/ruby -I"lib:test" -I"/usr/local/var/rbenv/versions/2.1.1/lib/ruby/gems/2.1.0/gems/rake-10.4.2/lib" "/usr/local/var/rbenv/versions/2.1.1/lib/ruby/gems/2.1.0/gems/rake-10.4.2/lib/rake/rake_test_loader.rb" "test/merchants_test.rb"
Run options: --seed 16687

# Running:

..

Finished in 0.255902s, 7.8155 runs/s, 437.6670 assertions/s.

2 runs, 112 assertions, 0 failures, 0 errors, 0 skips
```

__Configuring App Host__

By default, the specs assume your application is running locally
at `http://localhost:3000`. If you would like to test against a
server running at a different location, you can override this by
passing a `BASE_URL` environment variable:

```
BASE_URL=http://my-app-url.com rake
```
