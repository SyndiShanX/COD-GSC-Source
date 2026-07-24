/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2274.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_ship_female_a_comms");
  self attach("head_sc_comms_officer_head", "", 1);
  self.headmodel = "head_sc_comms_officer_head";
  self.hatmodel = "head_sc_comms_officer_bg_hair_female_mask_c_black";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_crew_ship_female_a_comms");
  precachemodel("head_sc_comms_officer_head");
  precachemodel("head_sc_comms_officer_bg_hair_female_mask_c_black");
}