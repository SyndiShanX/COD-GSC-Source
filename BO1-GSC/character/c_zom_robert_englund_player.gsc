/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_robert_englund_player.gsc
*****************************************************/

main() {
  self setModel("c_zom_robert_englund_fb_player");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precacheModel("c_zom_robert_englund_fb_player");
}