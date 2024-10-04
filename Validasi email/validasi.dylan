Module: validasi

define function is-valid-email? (email :: <string>) => (valid? :: <boolean>, message :: <string>)
  let at-index = find-key(email, curry(\=, '@'));

  if (~at-index)
    values(#f, "Email tidak valid: '@' tidak ditemukan");
  elseif (find-key(copy-sequence(email, start: at-index + 1), curry(\=, '@')))
    values(#f, "Email tidak valid: lebih dari satu '@' ditemukan");
  else
    // Separate local and domain parts
    let local-part = copy-sequence(email, end: at-index);
    let domain-part = copy-sequence(email, start: at-index + 1);

    let dot-index = find-key(domain-part, curry(\=, '.'));
    if (~dot-index)
      values(#f, "Email tidak valid: tidak ada '.' setelah '@'");
    else
      let consecutive-dots? = 
        block ()
          for (i from 0 below domain-part.size - 1)
            if (domain-part[i] = '.' & domain-part[i + 1] = '.')
              #t;
            end if;
          finally
            #f;
          end for;
        end block;
      
      if (consecutive-dots?)
        values(#f, "Email tidak valid: dua titik berturut-turut ditemukan di domain");
      else
        let last-dot-index = block()
          let index = domain-part.size - 1;
          let found = #f;
          while (index >= 0)
            if (domain-part[index] = '.')
              found := index;
              break;
            end if;
            index := index - 1;
          end while;
          found;
        end block;

        if (~last-dot-index & last-dot-index > at-index)
          values(#f, "Email tidak valid: format domain salah (terlalu banyak titik)");
        else
          values(#t, "Email valid!");
        end if;
      end if;
    end if;
  end if;
end function;

define function main(name :: <string>, arguments :: <vector>)
  let email1 = "invalidemail@@example.com";
  let email2 = "no.dot@examplecom";
  let email3 = "no.dot@example.com";
  let email4 = "herovva@gmail.com";


  format-out("Validasi email pertama: %=\n", is-valid-email?(email1));
  format-out("Validasi email kedua: %=\n", is-valid-email?(email2));
  format-out("Validasi email ketiga: %=\n", is-valid-email?(email3));
  format-out("Validasi email keempat: %=\n", is-valid-email?(email4));
end function;

main(application-name(), application-arguments());