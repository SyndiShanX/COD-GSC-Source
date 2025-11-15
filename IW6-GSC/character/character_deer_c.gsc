/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_deer_c.gsc
******************************************/

main() {
  self setModel("fullbody_deer_c");
  self.voice = "american";
  self setclothtype("none");
}

precache() {
  precachemodel("fullbody_deer_c");
}