/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\char_jap_makin_officer.gsc
*****************************************************/

main() {
  self setModel("char_jap_impinf_officer_body");
  self.headModel = "char_jap_impinf_officer_i_head";
  self attach(self.headModel, "", true);
  self.voice = "japanese";
}

precache() {
  precacheModel("char_jap_impinf_officer_body");
  precacheModel("char_jap_impinf_officer_i_head");
}