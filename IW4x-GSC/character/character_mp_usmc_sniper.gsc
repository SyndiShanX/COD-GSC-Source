/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_mp_usmc_sniper.gsc
**************************************************/

main() {
  self setModel("body_mp_usmc_sniper");
  self attach("head_mp_usmc_tactical_baseball_cap", "", true);
  self.headModel = "head_mp_usmc_tactical_baseball_cap";
  self setViewmodel("viewmodel_base_viewhands");
  self.voice = "american";
}

precache() {
  precacheModel("body_mp_usmc_sniper");
  precacheModel("head_mp_usmc_tactical_baseball_cap");
  precacheModel("viewmodel_base_viewhands");
}