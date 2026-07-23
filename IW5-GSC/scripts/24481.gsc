/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\24481.gsc
**************************************/

main() {
  self setModel("body_hero_sandman_delta");
  self attach("head_hero_sandman_delta", "", 1);
  self.headmodel = "head_hero_sandman_delta";
  self.voice = "delta";
}

precache() {
  precachemodel("body_hero_sandman_delta");
  precachemodel("head_hero_sandman_delta");
}