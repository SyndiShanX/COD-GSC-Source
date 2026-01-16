/*********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_arab_regular_suren.gsc
*********************************************************/

main() {
  self setmodel("body_sp_arab_regular_suren");
  self attach("head_sp_arab_regular_suren", "", 1);
  self.headmodel = "head_sp_arab_regular_suren";
  self.voice = "arab";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_arab_regular_suren");
  precachemodel("head_sp_arab_regular_suren");
}