/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_nicaragua_hudson.gsc
************************************************/

main() {
  self setmodel("c_usa_nicaragua_hudson_fb");
  self.headmodel = "c_usa_nicaragua_hudson_glasses";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_nicaragua_hudson_fb");
  precachemodel("c_usa_nicaragua_hudson_glasses");
}