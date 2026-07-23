/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_hero_seal_udt_soap.gsc
********************************************************/

main() {
  self setModel("body_hero_seal_udt_soap");
  self attach("head_hero_soap_udt", "", true);
  self.headModel = "head_hero_soap_udt";
  self.voice = "seal";
}

precache() {
  precacheModel("body_hero_seal_udt_soap");
  precacheModel("head_hero_soap_udt");
}