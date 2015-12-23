# cpplint-integration
Integrate the cpp-lint C++ style checker(open-source-google-project) into your project

* This checker is implemented based on [Google's C++ style checking tool](https://github.com/google/styleguide/tree/gh-pages/cpplint), which follows [Google's C++ style guide](http://google.github.io/styleguide/cppguide.html).

* To check the project's C++ code style, just `include lint/lint.mk` at the end of your project and run `make lint`.

* To check a single code file, run `python lint/cpplint.py filename`

* Note: `make lint` will produce some temporary files, located as `lint/.lint* and lint/lint.txt`. `make lintclean` will delete them.  And they should be added to the .gitignore file if use git.