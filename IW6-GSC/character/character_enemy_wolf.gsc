/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_enemy_wolf.gsc
**********************************************/

main() {
  self setModel("fullbody_wolf_a");
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("fullbody_wolf_a");
}