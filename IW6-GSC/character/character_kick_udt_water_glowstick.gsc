/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_kick_udt_water_glowstick.gsc
************************************************************/

main() {
  self setModel("fullbody_kick_udt_water_glowstick");
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("fullbody_kick_udt_water_glowstick");
}