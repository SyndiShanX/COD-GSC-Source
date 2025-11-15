/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_rus_simianaut.gsc
*****************************************/

main() {
  self setModel("c_rus_simianaut_body");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precacheModel("c_rus_simianaut_body");
}