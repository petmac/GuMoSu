/// @desc scr_thousand_seperator(integer)
var r, i;
r = string(argument0)
for (i = string_length(r) - 2; i > 1; i -= 3) {
    r = string_insert(",", r, i)
}
return r