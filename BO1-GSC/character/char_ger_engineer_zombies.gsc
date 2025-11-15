/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\char_ger_engineer_zombies.gsc
***************************************************/

main() {
  self setModel("char_ger_zombeng_body1_1");
  self.voice = "german";
  self.skeleton = "base";
}

precache() {
  precacheModel("char_ger_zombeng_body1_1");
}