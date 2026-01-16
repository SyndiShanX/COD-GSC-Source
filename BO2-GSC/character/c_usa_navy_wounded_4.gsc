/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_navy_wounded_4.gsc
**********************************************/

main() {
  self setmodel("c_usa_navy_body_wnded_asn");
  self.headmodel = "c_usa_navy_head4";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_navy_body_wnded_asn");
  precachemodel("c_usa_navy_head4");
}