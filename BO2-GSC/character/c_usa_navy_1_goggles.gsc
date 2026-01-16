/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_navy_1_goggles.gsc
**********************************************/

main() {
  self setmodel("c_usa_navy_body_blk");
  self.headmodel = "c_usa_navy_head_goggles";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_navy_body_blk");
  precachemodel("c_usa_navy_head_goggles");
}