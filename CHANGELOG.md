# Changelog

## Unreleased

## 3.0.0.rc1 (2021-04-16)

*   Add tests, fix some errors.
    100% coverage, yay!
*   Update version of Flame dependency to `~> 5.0`.
*   Set locale with region by locale without.
    From `Accept-Language` HTTP header.
*   Remove extra slashes in a root path with query string when redirecting (`LocaleInPath`).
*   Replace `LocaleInPath#path_witout_locale` with `#fullpath_without_locale`.
*   Take out `path_with_preferred_locale` from `redirect_to_path_with_preferred_locale`.
*   Update R18n dependency.
*   Update development dependencies, lock them better.
*   Add Travis CI, then switch to Cirrus CI.
*   Add `rubocop-performance` and `rubocop-rspec`.
    Resolve new offenses.
*   Support Ruby 3.
*   Move gem version to a separate file.
*   Add RuboCop task for CI.
*   Add `remark` task for CI.
*   Replace `rake` with `toys`.
*   Add code documentation.
*   Add more meta-information to gem specs.
*   Add badges to README.
*   Add "Development", "Contributing" and "License" sections to README.

## 2.3.1 (2017-10-13)

*   Fix the critical issue with caching 301 Location by browsers.

## 2.3.0.1 (2017-10-13)

*   Fix the critical issue with caching 301 Location by browsers.

## 2.3.0 (2017-08-23)

*   Add redefined `LocaleInPath#path_to` method.

## 2.2.1 (2017-08-10)

*   Fix an error with `LocaleInPath` module.

## 2.2.0 (2017-08-09)

*   Add `Flame::R18n::LocaleInPath` module for general methods in such case.

## 2.1.1 (2017-08-08)

*   Fix calling root `::R18n` constant.

## 2.1.0 (2017-08-08)

*   Don't use locale param if it is not in available locales.

## 2.0.0 (2017-05-17)

*   Split `Flame::R18n` to `Configuration` and `Initialization`.
    Change `prepend` to `include`s for application and controller.
*   Fix gem building.
*   Add RuboCop config.

## 1.3.0 (2016-11-11)

*   Initialize `R18n` already with `preferred_locale` instead of setting it later to `session`.

## 1.2.0 (2016-11-08)

*   Add possibility of redefining `preferred_locale`.

## 1.1.1 (2016-09-28)

*   Fix an error with non-word chars in `preferred_locale`.

## 1.1.0 (2016-05-20)

*   Set default locale to `session[:locale]` when no preferred.
    Change `include` to `prepend`.
*   Prevent `preferred_locale` duplicates in `locales`.
*   Fix issue when `locales_from_env` returns `nil`.
*   Add README file.
*   Add LICENSE file.
*   Fix gem specs file name.
*   Change homepage in gem specs from GitLab to GitHub.

## 1.0.0 (2016-01-29)

*   Initial release.
