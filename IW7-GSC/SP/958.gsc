/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 958.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_civ_facility_worker_med");
  self attach("head_bg_var_head_bg_engineering_mate_head_hero_gator_blast_damage", "", 1);
  self.headmodel = "head_bg_var_head_bg_engineering_mate_head_hero_gator_blast_damage";
  self.hatmodel = "head_bg_engineering_mate_hair_b_black";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "civilian";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_civ_facility_worker_med");
  precachemodel("head_bg_var_head_bg_engineering_mate_head_hero_gator_blast_damage");
  precachemodel("head_bg_engineering_mate_hair_b_black");
}