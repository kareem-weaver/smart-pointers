Reference Counter Utility
=========================

Overview
--------
Reference Counter offers semi-automatic counting of references to program resources
such as memory.  A user accesses the provided reference-counting capability simply
by defining a non-abstract derived type that 
1. Extends Reference Counter's `ref_reference_t` type and
2. Implements the so-inherited `free` deferred binding.
For efficient execution, the user type should be some form of lightweight proxy
for a more stateful entity stored elsewhere.  For example, the user type might 
contain a Fortran `pointer` associated with some other object or it might contain
a "shadow" object that is essentially an identifier for a larger object being a
allocated in C or C++.

For more background in the design philosophy and internal mechanics of Reference
Counter, see the papers by [Rouson, Xia & Xu (2010)] and [Rouson, Morris & Xia (2012)].
This repository's code originated from refactoring the code in those two publications
to use more descriptive and general nomenclature and more up-to-date coding conventions.
For example, this repository separates interface bodies into modules and procedure
definitions into submodules.

As compared to the original code, this repository also adds
1. A [Fortran Package Manager] build system,
2. Tests based on the [Vegetables] unit-testing software,
3. Documentation generated by [FORD] and deployed to the web via GitHub Actions, and
4. Quality control via continuous integration testing using GitHub Actions.

Compiler Status
---------------
Correct execution of the Reference Counter library code requires comprehensive
compiler support for Fortran's type finalization semantics.  The unit test suite
includes language standard-conformance tests that verify correct compiler behavior
across a few common use cases.  The table below summarizes the observes compiler
behaviors:

| _ Compiler _ | _ Test failures _ | _ Version tested _                        |
| :---         |       :---:       | :---                                      |
| NAG          |         0         | `nagfor` 7.1                              |
| GCC          |         1         | `gfortran` 11.2.0 (Homebrew GCC 11.2.0\_3)|
| Intel        |         2         | `ifort` 2021.5.0 Build 20211109\_000000   |

The current compiler tests are based on early user feedback and are therefore 
_ad hoc_ with no attempt at being exhaustive.  Please submit an issue if you
encounter unexpected behavior in a use case not covered in the test suite or
you can provide test results for additional compilers.

Downloading, Building, and Testing
----------------------------------
On Linux, macOS, or Windows Subsystem for Linux, download, build, and test with
the following shell commands:
```
git clone git@github.com:sourceryinstitute/reference-counter
cd reference-counter
```
followed by one of the commands below depending on your compiler choice.

### GCC (`gfortran`)
```
fpm test
```

### Numerical Algorithms Group (`nagfor`)
```
fpm test --compiler nagfor --flag -fpp
```

### Intel (`ifort`)
```
fpm test --compiler ifort --flag -coarray=shared
```

[Rouson, Xia & Xu (2010)]: https://doi.org/10.1016/j.procs.2010.04.166
[Rouson, Morris & Xia (2012)]: https://doi.org/10.1109/MCSE.2012.33
[Fortran Package Manager]: https://github.com/fortran-lang/fpm
[Vegetables]: https://gitlab.com/everythingfunctional/vegetables
[FORD]: https://github.com/Fortran-FOSS-Programmers/ford
