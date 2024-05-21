(lang dune 2.8)

(generate_opam_files true)

(name fmtime)

(package
 (name fmtime)
 (version 0.2.0)
 (synopsis "A simple way to print time")
 (description "Print time using different RFCs")
 (license "MIT")
 (authors "Matthieu GOSSET matthieu.gosset.dev@outlook.com")
 (maintainers "Matthieu GOSSET matthieu.gosset.dev@outlook.com")
 (homepage "https://github.com/aeghost/fmtime")
 (source
  (github "aeghost/fmtime"))
 (bug_reports "https://github.com/aeghost/fmtime/issues")
 (depends
  (fmt
   (>= 0.9.0))))
