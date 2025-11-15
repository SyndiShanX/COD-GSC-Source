/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_shadow_co_eyes.gsc
********************************************************/

main() {
  self setModel("body_shadow_co_smg");
  self attach("head_shadow_co_c", "", true);
  self.headModel = "head_shadow_co_c";
  self.voice = "shadowcompany";
}

precache() {
  precacheModel("body_shadow_co_smg");
  precacheModel("head_shadow_co_c");
}