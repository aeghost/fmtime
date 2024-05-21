(** TESTS
    @copyright None
    @author Matthieu GOSSET
    @maintainers
      Matthieu GOSSET <matthieu.gosset.dev@chapsvision.com>
    @purpose
      Quick testing the lib
*)

let () =
  let open Fmt in
  pr "@.START";

  let test name pp now =
    pr "@.@.%s@. 1.: %a@. Now: %s@. Invalid: %a"
      name
      pp 1.
      (now ())
      pp (-.1.)
  in

  let open Fmtime in
  test "DEFAULT" pp now;
  test "RFC_5424" RFC_5424.pp RFC_5424.now;
  test "RFC_2822" RFC_2822.pp RFC_2822.now;

  pr "@.@.DONE@."