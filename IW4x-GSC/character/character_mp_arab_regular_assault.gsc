/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_mp_arab_regular_assault.gsc
***********************************************************/

main() {
  self setModel("body_mp_arab_regular_assault");
  self attach("head_mp_arab_regular_suren", "", true);
  self.headModel = "head_mp_arab_regular_suren";
  self setViewmodel("viewhands_desert_opfor");
  self.voice = "arab";
}

precache() {
  precacheModel("body_mp_arab_regular_assault");
  precacheModel("head_mp_arab_regular_suren");
  precacheModel("viewhands_desert_opfor");
}