(** FMT_TIME, FMTIME - MLI
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

(** [set_empty_string] lets you redifined if wanted the empty string displayed value (for an invalid float) *)
val set_empty_string : string -> unit

(** [RFC_2822]
    -> Date format : "Mon, 20 May 2024 11:42:13 +0200" *)
module RFC_2822 : sig
  (** [pp ppf f] pretty print float [f] into the formatter [ppf] as RFC 2822 - ex: "Mon, 20 May 2024 11:42:13 +0200" *)
  val pp : Format.formatter -> float -> unit
  val of_timestamp : float -> string
  val string : float -> string
  val pp_now : Format.formatter -> unit -> unit
  val now : unit -> string
end

(** [RFC_5424]
    -> Date format : "2024-05-20T10:21:13.000000+02:00" *)
module RFC_5424 : sig
  (** [pp ppf f] pretty print float [f] into the formatter [ppf] as RFC 5424 - ex: "2024-05-20T10:21:13.000000+02:00" *)
  val pp : Format.formatter -> float -> unit
  val of_timestamp : float -> string
  val string : float -> string
  val pp_now : Format.formatter -> unit -> unit
  val now : unit -> string
end

(** [pp ppf f] pretty print float [f] into the formatter [ppf] as RFC 5424 - ex: "2024-05-20T10:21:13.000000+02:00" *)
val pp : Format.formatter -> float -> unit
val of_timestamp : float -> string
val string : float -> string
val pp_now : Format.formatter -> unit -> unit
val now : unit -> string