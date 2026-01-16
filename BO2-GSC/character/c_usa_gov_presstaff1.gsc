/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_gov_presstaff1.gsc
**********************************************/

main() {
  self setmodel("c_usa_gov_presstaff_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_gov_presstaff_fb");
}