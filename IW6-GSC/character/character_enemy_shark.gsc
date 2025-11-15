/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_enemy_shark.gsc
***********************************************/

main() {
  self setModel("fullbody_tigershark");
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("fullbody_tigershark");
}