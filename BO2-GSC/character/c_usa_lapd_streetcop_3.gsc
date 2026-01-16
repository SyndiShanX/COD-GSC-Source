/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_lapd_streetcop_3.gsc
************************************************/

main() {
  self setmodel("c_usa_lapd_streetcop_body_blk");
  self.headmodel = "c_usa_lapd_streetcop_head3";
  self attach(self.headmodel, "", 1);
  self.hatmodel = "c_usa_lapd_streetcop_head3_gear";
  self attach(self.hatmodel);
  self.gearmodel = "c_usa_lapd_streetcop_gear";
  self attach(self.gearmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_lapd_streetcop_body_blk");
  precachemodel("c_usa_lapd_streetcop_head3");
  precachemodel("c_usa_lapd_streetcop_head3_gear");
  precachemodel("c_usa_lapd_streetcop_gear");
}