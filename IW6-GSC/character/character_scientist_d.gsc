/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_scientist_d.gsc
***********************************************/

main() {
  self setModel("fullbody_scientist_d");
  self.voice = "russian";
  self setclothtype("cloth");
}

precache() {
  precachemodel("fullbody_scientist_d");
}