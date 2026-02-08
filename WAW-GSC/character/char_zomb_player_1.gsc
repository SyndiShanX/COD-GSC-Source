/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\char_zomb_player_1.gsc
********************************************/

main() {
  self setModel("char_rus_guard_chernova_zomb");
  self.voice = "russian";
}

precache() {
  precacheModel("char_rus_guard_chernova_zomb");
}