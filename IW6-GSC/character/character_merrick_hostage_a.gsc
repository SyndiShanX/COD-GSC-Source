/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_merrick_hostage_a.gsc
*****************************************************/

main() {
  self setModel("fullbody_merrick_hostage_a");
  self.voice = "american";
  self setclothtype("cloth");
}

precache() {
  precachemodel("fullbody_merrick_hostage_a");
}