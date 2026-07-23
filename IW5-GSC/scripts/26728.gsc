/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\26728.gsc
**************************************/

main() {
  self setModel("body_hero_sandman_seal_udt_b");
  self attach("head_seal_udt_e_iw5", "", 1);
  self.headmodel = "head_seal_udt_e_iw5";
  self.voice = "delta";
}

precache() {
  precachemodel("body_hero_sandman_seal_udt_b");
  precachemodel("head_seal_udt_e_iw5");
}