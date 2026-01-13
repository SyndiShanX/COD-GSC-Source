/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 981.gsc
*********************************************/

main() {
  self setModel("body_civ_facility_worker_lt");
  self attach("head_male_bc_02_bloody", "", 1);
  self.headmodel = "head_male_bc_02_bloody";
  self.hatmodel = "head_male_bc_02_bg_hair_male_a_brown";
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
  precachemodel("body_civ_facility_worker_lt");
  precachemodel("head_male_bc_02_bloody");
  precachemodel("head_male_bc_02_bg_hair_male_a_brown");
}