/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_panama_hudson.gsc
*********************************************/

main() {
  self setmodel("c_usa_panama_hudson_upper");
  self.headmodel = "c_usa_panama_hudson_head";
  self attach(self.headmodel, "", 1);
  self.hatmodel = "c_usa_panama_hudson_lower";
  self attach(self.hatmodel);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_panama_hudson_upper");
  precachemodel("c_usa_panama_hudson_head");
  precachemodel("c_usa_panama_hudson_lower");
}