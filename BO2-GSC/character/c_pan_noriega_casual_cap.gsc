/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_pan_noriega_casual_cap.gsc
**************************************************/

main() {
  self setmodel("c_pan_noriega_body1");
  self.headmodel = "c_pan_noriega_head";
  self attach(self.headmodel, "", 1);
  self.hatmodel = "c_pan_noriega_cap";
  self attach(self.hatmodel);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_pan_noriega_body1");
  precachemodel("c_pan_noriega_head");
  precachemodel("c_pan_noriega_cap");
}