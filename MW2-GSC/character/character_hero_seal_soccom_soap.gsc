/*********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_hero_seal_soccom_soap.gsc
*********************************************************/

main() {
  self setModel("body_hero_soap_socom");
  self attach("head_hero_soap_soccom_a", "", true);
  self.headModel = "head_hero_soap_soccom_a";
  self.voice = "taskforce";
}

precache() {
  precacheModel("body_hero_soap_socom");
  precacheModel("head_hero_soap_soccom_a");
}