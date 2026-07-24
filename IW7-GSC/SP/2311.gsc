/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2311.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_flight_deck_a_director");
  self attach("head_bg_var_head_male_bc_02_head_sc_male_16", "", 1);
  self.headmodel = "head_bg_var_head_male_bc_02_head_sc_male_16";
  self.hatmodel = "body_un_crew_flight_deck_helmet_director";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_salter";
  self.voice = "unitednationsfemale";
  self _meth_82C6("cloth");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_crew_flight_deck_a_director");
  precachemodel("head_bg_var_head_male_bc_02_head_sc_male_16");
  precachemodel("body_un_crew_flight_deck_helmet_director");
}