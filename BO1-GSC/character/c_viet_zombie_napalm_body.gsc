/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_viet_zombie_napalm_body.gsc
***************************************************/

main() {
  self setModel("c_viet_zombie_napalm");
  self.headModel = "c_viet_zombie_napalm_head";
  self attach(self.headModel, "", true);
  self.voice = "vietnamese";
  self.skeleton = "base";
}

precache() {
  precacheModel("c_viet_zombie_napalm");
  precacheModel("c_viet_zombie_napalm_head");
}