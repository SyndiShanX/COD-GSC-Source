/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_buried_sloth.gsc
********************************************/

main() {
  self setModel("c_zom_buried_sloth_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_buried_sloth_fb");
}