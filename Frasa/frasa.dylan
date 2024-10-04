Module: frasa

define function contains-phrase?(text :: <string>, phrase :: <string>) => (found? :: <boolean>)
  let text-lower = as-lowercase(text);
  let phrase-lower = as-lowercase(phrase);
  
  block (return)
    for (i from 0 below (text-lower.size - phrase-lower.size + 1))
      if (copy-sequence(text-lower, start: i, end: i + phrase-lower.size) = phrase-lower)
        return(#t);
      end if;
    end for;
    #f;
  end block;
end function;

define function main(name :: <string>, arguments :: <vector>)
  let text = "Ini adalah contoh teks yang akan kita cari. dylan adalah bahasa pemrograman yang menarik.";
  let phrases = #("dylan", "bahasa pemrograman", "tidak ada");

  format-out("Teks: %s\n\n", text);

  for (phrase in phrases)
    let result = contains-phrase?(text, phrase);
    format-out("Apakah frasa '%s' ada dalam teks? %s\n", phrase, if (result) "Ya" else "Tidak" end);
  end for;
end function;

main(application-name(), application-arguments());
