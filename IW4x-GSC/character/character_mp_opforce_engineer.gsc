/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_mp_opforce_engineer.gsc
*******************************************************/

main() {
  self setModel("body_mp_opforce_eningeer");
  self attach("head_mp_opforce_gasmask", "", true);
  self.headModel = "head_mp_opforce_gasmask";
  self setViewmodel("viewhands_op_force");
  self.voice = "russian";
}

precache() {
  precacheModel("body_mp_opforce_eningeer");
  precacheModel("head_mp_opforce_gasmask");
  precacheModel("viewhands_op_force");
}