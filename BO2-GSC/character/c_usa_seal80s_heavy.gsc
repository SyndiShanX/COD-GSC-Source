/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_seal80s_heavy.gsc
*********************************************/

main() {
  self setmodel("c_usa_seal80s_body_gloves");
  self.headmodel = "c_usa_seal80s_head2";
  self attach(self.headmodel, "", 1);
  self.gearmodel = "c_usa_seal80s_gear_heavy";
  self attach(self.gearmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_seal80s_body_gloves");
  precachemodel("c_usa_seal80s_head2");
  precachemodel("c_usa_seal80s_gear_heavy");
}