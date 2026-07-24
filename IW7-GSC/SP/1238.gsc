/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1238.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_sdf_army_ftl_1");
  scripts\code\character::attachhead("alias_heads_sdf_army_bloody", _id_09C2::main());
  self.hatmodel = "head_sdf_army_ftl_1";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "setdef";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self._id_8E1A = level._id_7649["iw7/prop/vfx_sdf_army_ftl_helmet_split"];

  if(issentient(self)) {
    self _meth_849A();
    var_0 = [];
    var_0["helmet"] = spawnStruct();
    var_0["helmet"]._id_B4B8 = 9999;
    var_0["helmet"].partnerheli = [];
    var_0["helmet"].partnerheli["helmet"] = spawnStruct();
    var_0["helmet"].partnerheli["helmet"].maxhealth = 50;
    var_0["helmet"].partnerheli["helmet"].hitloc = "helmet";
    var_0["helmet"].partnerheli["helmet"]._id_4D6F = "j_helmet";
    self _meth_849B("helmet", 9999, "helmet", 50, "helmet", "j_helmet");
    self._id_4D5D = var_0;
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_sdf_army_ftl_1");
  scripts\code\character::precachemodelarray(_id_09C2::main());
  precachemodel("head_sdf_army_ftl_1");
  level._id_7649["iw7/prop/vfx_sdf_army_ftl_helmet_split"] = loadfx("vfx/iw7/prop/vfx_sdf_army_ftl_helmet_split.vfx");
}