/**********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_hero_seal_soccom_ghost.gsc
**********************************************************/

main() {
  self setModel("body_hero_ghost_socom");
  self attach("head_hero_ghost_soccom", "", true);
  self.headModel = "head_hero_ghost_soccom";
  self.voice = "taskforce";
}

precache() {
  precacheModel("body_hero_ghost_socom");
  precacheModel("head_hero_ghost_soccom");
}