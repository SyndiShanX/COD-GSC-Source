/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_deer_b.gsc
******************************************/

main() {
  self setModel("fullbody_deer_b");
  self.voice = "american";
  self setclothtype("none");
}

precache() {
  precachemodel("fullbody_deer_b");
}