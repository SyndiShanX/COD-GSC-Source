/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_militarypolice_zombietron.gsc
*********************************************************/

main() {
  self setModel("c_usa_militarypolice_body_zt");
  self.headModel = codescripts\character::randomElement(xmodelalias\c_ger_honorguard_zomb_headalias_zt::main());
  self attach(self.headModel, "", true);
  self.voice = "american";
  self.skeleton = "base";
}
precache() {
  precacheModel("c_usa_militarypolice_body_zt");
  codescripts\character::precacheModelArray(xmodelalias\c_ger_honorguard_zomb_headalias_zt::main());
}