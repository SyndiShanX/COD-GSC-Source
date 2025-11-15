/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_iw6_sp_dog_c_hurt.gsc
*****************************************************/

main() {
  self setModel("fullbody_dog_c_hurt");
  self.voice = "arab";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("fullbody_dog_c_hurt");
}