/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_shadow_co_riot.gsc
********************************************************/

main() {
  self setModel("body_riot_udt");
  self attach("head_riot_udt", "", true);
  self.headModel = "head_riot_udt";
  self.voice = "shadowcompany";
}

precache() {
  precacheModel("body_riot_udt");
  precacheModel("head_riot_udt");
}