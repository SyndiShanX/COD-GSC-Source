/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_pak_isi_leader_millibar.gsc
***************************************************/

main() {
  self setmodel("c_pak_isi_body_m");
  self.headmodel = "c_pak_isi_head1_m";
  self attach(self.headmodel, "", 1);
  self.gearmodel = "c_pak_isi_gear1_m";
  self attach(self.gearmodel, "", 1);
  self.voice = "isi";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_pak_isi_body_m");
  precachemodel("c_pak_isi_head1_m");
  precachemodel("c_pak_isi_gear1_m");
}