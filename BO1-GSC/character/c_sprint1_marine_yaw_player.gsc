/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_sprint1_marine_yaw_player.gsc
*****************************************************/

main() {
  self setModel("c_usa_jungmar_mp_snip_fb");
  self setViewmodel("viewmodel_usa_marine_arms");
  self.voice = "american";
  self.skeleton = "base";
}
precache() {
  precacheModel("c_usa_jungmar_mp_snip_fb");
  precacheModel("viewmodel_usa_marine_arms");
}