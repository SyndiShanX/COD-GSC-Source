/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_afr_unitas_2_burned.gsc
***********************************************/

main() {
  self setmodel("c_afr_unitas_body2_burned");
  self.headmodel = "c_afr_unitas_head1_burned";
  self attach(self.headmodel, "", 1);
  self.gearmodel = "c_afr_unitas_gear1";
  self attach(self.gearmodel, "", 1);
  self.voice = "unita";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_afr_unitas_body2_burned");
  precachemodel("c_afr_unitas_head1_burned");
  precachemodel("c_afr_unitas_gear1");
}