/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_hero_arctic_soap.gsc
********************************************************/

main() {
  self setModel("body_hero_soap_arctic");
  self attach("head_hero_soap_arctic", "", true);
  self.headModel = "head_hero_soap_arctic";
  self.voice = "british";
}

precache() {
  precacheModel("body_hero_soap_arctic");
  precacheModel("head_hero_soap_arctic");
}