/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_cia_combat_harper_wt_cin.gsc
***********************************************************/

main() {
  self setmodel("c_usa_cia_combat_harper_body_wt");
  self.headmodel = "c_usa_cia_combat_harper_head_wt";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_cia_combat_harper_body_wt");
  precachemodel("c_usa_cia_combat_harper_head_wt");
}