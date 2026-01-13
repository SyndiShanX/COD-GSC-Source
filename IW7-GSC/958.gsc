/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 958.gsc
*********************************************/

main() {
  self setModel("body_civ_facility_worker_med");
  self attach("head_bg_var_head_bg_engineering_mate_head_hero_gator_blast_damage", "", 1);
  self.headmodel = "head_bg_var_head_bg_engineering_mate_head_hero_gator_blast_damage";
  self.hatmodel = "head_bg_engineering_mate_hair_b_black";
  self attach(self.hatmodel);
  self.var_1FEC = "generic_human";
  self.var_1FA8 = "civilian";
  self.voice = "unitednations";
  self give_explosive_touch_on_revived("cloth");
  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  self glinton(#animtree);
}

precache() {
  precachemodel("body_civ_facility_worker_med");
  precachemodel("head_bg_var_head_bg_engineering_mate_head_hero_gator_blast_damage");
  precachemodel("head_bg_engineering_mate_hair_b_black");
}