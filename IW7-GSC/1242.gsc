/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1242.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_sdf_army_ghost_1");
  self attach("head_bg_var_head_sc_kloos_head_sc_male_24", "", 1);
  self.headmodel = "head_bg_var_head_sc_kloos_head_sc_male_24";
  scripts\code\character::attachhat("alias_hats_sdf_crew_ship_kloos_male_24", _id_09B8::main());
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "setdef";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  if(issentient(self)) {
    self _meth_849A();
    var_0 = [];
    var_0["helmet"] = spawnStruct();
    var_0["helmet"]._id_B4B8 = 9999;
    var_0["helmet"].partnerheli = [];
    var_0["helmet"].partnerheli["helmet"] = spawnStruct();
    var_0["helmet"].partnerheli["helmet"].maxhealth = 0;
    var_0["helmet"].partnerheli["helmet"].hitloc = "helmet";
    var_0["helmet"].partnerheli["helmet"]._id_4D6F = "j_helmet";
    self _meth_849B("helmet", 9999, "helmet", 0, "helmet", "j_helmet");
    self._id_4D5D = var_0;
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_sdf_army_ghost_1");
  precachemodel("head_bg_var_head_sc_kloos_head_sc_male_24");
  scripts\code\character::precachemodelarray(_id_09B8::main());
}