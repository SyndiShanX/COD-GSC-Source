/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_merrick_udt_water_glowstick.gsc
***************************************************************/

main() {
  self setModel("fullbody_merrick_udt_water_glowstick");
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("fullbody_merrick_udt_water_glowstick");
}