/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1238.gsc
*********************************************/

main() {
  self setModel("body_sdf_army_ftl_1");
  scripts\code\character::attachhead("alias_heads_sdf_army_bloody", lib_09C2::main());
  self.hatmodel = "head_sdf_army_ftl_1";
  self attach(self.hatmodel);
  self.var_1FEC = "generic_human";
  self.var_1FA8 = "soldier";
  self.voice = "setdef";
  self give_explosive_touch_on_revived("vestlight");
  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  self.var_8E1A = level.var_7649["iw7\prop\vfx_sdf_army_ftl_helmet_split"];
  if(issentient(self)) {
    self func_849A();
    var_0 = [];
    var_0["helmet"] = spawnStruct();
    var_0["helmet"].var_B4B8 = 9999;
    var_0["helmet"].partnerheli = [];
    var_0["helmet"].partnerheli["helmet"] = spawnStruct();
    var_0["helmet"].partnerheli["helmet"].maxhealth = 50;
    var_0["helmet"].partnerheli["helmet"].hitloc = "helmet";
    var_0["helmet"].partnerheli["helmet"].var_4D6F = "j_helmet";
    self func_849B("helmet", 9999, "helmet", 50, "helmet", "j_helmet");
    self.var_4D5D = var_0;
  }

  self glinton(#animtree);
}

precache() {
  precachemodel("body_sdf_army_ftl_1");
  scripts\code\character::precachemodelarray(lib_09C2::main());
  precachemodel("head_sdf_army_ftl_1");
  level.var_7649["iw7\prop\vfx_sdf_army_ftl_helmet_split"] = loadfx("vfx\iw7\prop\vfx_sdf_army_ftl_helmet_split.vfx");
}