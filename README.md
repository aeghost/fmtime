# Fmtime

Format time in OCaml, should be used with Fmt module
Exported to this github for save purpose (just in case I need it in the future)

## Usage

Use as fmt formatter - By default it uses 5424 standard

```ocaml
(* Use it as formatter *)
Fmt.pr "Now: %a@." Fmtime.RFC_5424.pp_now ()

(* RFC 2822 is available for fellow Linuxians *)
Fmt.pr "1s after the zero as a linuxian: %a@." Fmtime.RFC_2822.pp 1.

(* You can use as simple string if not confortable with Fmt *)
print_endline Fmtime.RFC_5424.(now ())
```

## Tests

Run `make tests` to see it work (its just strings).
