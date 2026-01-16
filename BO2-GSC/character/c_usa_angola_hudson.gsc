/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_angola_hudson.gsc
*********************************************/

main() {
  self setmodel("c_usa_angola_hudson_fb");
  self.hatmodel = "c_usa_angola_hudson_glasses";
  self attach(self.hatmodel);
  self.gearmodel = "c_usa_angola_hudson_hat";
  self attach(self.gearmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_angola_hudson_fb");
  precachemodel("c_usa_angola_hudson_glasses");
  precachemodel("c_usa_angola_hudson_hat");
}