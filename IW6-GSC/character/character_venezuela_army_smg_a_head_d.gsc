/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_venezuela_army_smg_a_head_d.gsc
***************************************************************/

main() {
  self setModel("body_venezuela_army_smg_a");
  self attach("head_venezuela_army_head_d", "", 1);
  self.headmodel = "head_venezuela_army_head_d";
  self.voice = "shadowcompany";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_venezuela_army_smg_a");
  precachemodel("head_venezuela_army_head_d");
}