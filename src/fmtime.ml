(** FMT_TIME, FMTIME
    @author Matthieu GOSSET
    @maintainers
      Matthieu GOSSET <matthieu.gosset.dev@outlook.com>
    @purpose
      RFC/ISO time formatter for miscs services/trackers usage
    @examples
      # Use as fmt formatter - By default it uses 5424 standard
      Fmt.pr "Now: %a@." Fmtime.RFC_5424.pp_now ()

      # RFC 2822 is available for Linuxians
      Fmt.pr "1s after the zero as a linuxian: %a@." Fmtime.RFC_2822.pp 1.

      # You can use as string
      print_endline Fmtime.RFC_5424.(now ())
*)

(** [empty_string] access to time empty string value *)
let empty_string = ref "-"

(** [set_empty_string] lets you redifined if wanted the empty string displayed value (for an invalid float) *)
let set_empty_string s = empty_string := s

(** [invalidate f] invalid the timestamp and output [empty_string] reference value *)
let invalidate f = f <= 0.0

(** [PrettyPrinter] modules to make properly the toolbox, lets you defined as much functions as you want and just export the usefull [pp] *)
module type PP = sig
  val pp : Format.formatter -> float -> unit
end

(** [Toolbox] factory making some functions from [PrettyPrinter] ones *)
module Toolbox (PP: PP) = struct
  let pp = PP.pp
  let of_timestamp f = Fmt.str "%a" PP.pp f
  let string = of_timestamp

  let pp_now ppf () = Fmt.pf ppf "%a" PP.pp Unix.(time ())
  let now () = Fmt.str "%a" pp_now ()
end

(* [PrettyPrinter] for RFC_2822 / ISO 8601
   -> Date format : "Mon, 20 May 2024 11:42:13 +0200" *)
module PP_RFC_2822 : PP = struct
  let pp_day ppf (tm: Unix.tm) = Fmt.pf ppf "%s" (
      match tm.tm_wday with
      | 1 -> "Mon"
      | 2 -> "Tue"
      | 3 -> "Wed"
      | 4 -> "Thu"
      | 5 -> "Fri"
      | 6 -> "Sat"
      | _ -> "Sun"
    )

  let pp_month ppf (tm: Unix.tm) =
    Fmt.pf ppf "%s" (
      match tm.tm_mon with
      | 1 -> "Feb"
      | 2 -> "Mar"
      | 3 -> "Apr"
      | 4 -> "May"
      | 5 -> "Jun"
      | 6 -> "Jul"
      | 7 -> "Aug"
      | 8 -> "Sep"
      | 9 -> "Oct"
      | 10 -> "Nov"
      | 11 -> "Dec"
      | _ -> "Jan"
    )

  (** [pp ppf f] pretty print float [f] into the formatter [ppf] as RFC 2822 - ex: "Mon, 20 May 2024 11:42:13 +0200" *)
  let pp ppf = function
    | f when invalidate f -> Fmt.string ppf !empty_string
    | f ->
      let tm = Unix.gmtime f in
      let date = tm.tm_mday in
      let year = tm.tm_year + 1900 in
      let hour = tm.tm_hour in
      let min = tm.tm_min in
      let sec = tm.tm_sec in

      let f1, _ = Unix.mktime tm in
      let diff = int_of_float (f -. f1) in
      let h1 = diff / 60 in
      let h = h1 / 60 in
      let m = h1 mod 60 in

      Fmt.pf ppf "%a, %02d %a %04d %02d:%02d:%02d %s%02i%02i"
        pp_day tm
        date
        pp_month tm
        year hour min sec
        (if h >= 0 then "+" else "-")
        (abs h) m
end

(* [PrettyPrinter] for RFC_5424 / ISO 3164
   -> Date format : "2024-05-20T10:21:13.000000+02:00" *)
module PP_RFC_5424 : PP = struct
  (** [pp ppf f] pretty print float [f] into the formatter [ppf] as RFC 5424 - ex: "2024-05-20T10:21:13.000000+02:00" *)
  let pp ppf = function
    | f when invalidate f -> Fmt.string ppf !empty_string
    | f ->
      let open Unix in
      let tm = gmtime f in
      let f1, _ = mktime tm in
      let year = tm.tm_year + 1900 in
      let month = tm.tm_mon + 1 in
      let us,_ = modf f in
      let us = int_of_float (us *. 1000000.0) in
      let diff = int_of_float (f -. f1) in
      let h1 = diff / 60 in
      let h = h1 / 60 in
      let m = h1 mod 60 in
      Fmt.pf ppf "%04i-%02i-%02iT%02i:%02i:%02i.%06i%s%02i:%02i"
        year month tm.tm_mday tm.tm_hour tm.tm_min tm.tm_sec us
        (if h >= 0 then "+" else "-")
        (abs h) m
end

module RFC_2822 = Toolbox(PP_RFC_2822)
module RFC_5424 = Toolbox(PP_RFC_5424)
include RFC_5424