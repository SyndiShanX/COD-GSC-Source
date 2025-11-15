/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_merrick_hostage_ab.gsc
******************************************************/

main() {
  self setModel("fullbody_merrick_hostage_ab");
  self.voice = "american";
  self setclothtype("cloth");
}

precache() {
  precachemodel("fullbody_merrick_hostage_ab");
}