/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_iw6_sp_enemy_dog.gsc
****************************************************/

main() {
  self setModel("fullbody_dog_cc_enemy");
  self.voice = "arab";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("fullbody_dog_cc_enemy");
}