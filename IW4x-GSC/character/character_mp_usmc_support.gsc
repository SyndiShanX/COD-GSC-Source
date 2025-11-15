/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_mp_usmc_support.gsc
***************************************************/

main() {
  self setModel("body_mp_usmc_support");
  self attach("head_mp_usmc_shaved_head", "", true);
  self.headModel = "head_mp_usmc_shaved_head";
  self setViewmodel("viewmodel_base_viewhands");
  self.voice = "american";
}

precache() {
  precacheModel("body_mp_usmc_support");
  precacheModel("head_mp_usmc_shaved_head");
  precacheModel("viewmodel_base_viewhands");
}