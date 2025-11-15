/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_deer_a.gsc
******************************************/

main() {
  self setModel("fullbody_deer_a");
  self.voice = "american";
  self setclothtype("none");
}

precache() {
  precachemodel("fullbody_deer_a");
}