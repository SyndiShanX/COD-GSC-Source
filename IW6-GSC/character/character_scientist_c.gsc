/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_scientist_c.gsc
***********************************************/

main() {
  self setModel("fullbody_scientist_c");
  self.voice = "russian";
  self setclothtype("cloth");
}

precache() {
  precachemodel("fullbody_scientist_c");
}