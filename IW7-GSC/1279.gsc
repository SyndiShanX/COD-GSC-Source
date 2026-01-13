/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1279.gsc
*********************************************/

main() {
  self setModel("body_sdf_army_light_1");
  scripts\code\character::attachhead("alias_heads_sdf_army", lib_09C1::main());
  self.hatmodel = "helmet_sdf_army_light_1";
  self attach(self.hatmodel);
  self.var_A489 = "sdf_army_boost_pack_zerog";
  self attach(self.var_A489);
  self.var_1FEC = "generic_human";
  self.var_1FA8 = "soldier";
  self.voice = "setdef";
  self give_explosive_touch_on_revived("vestlight");
  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  self.var_8E1A = level.var_7649["iw7\core\human\helmet_sdf_army_broken"];
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
  precachemodel("body_sdf_army_light_1");
  scripts\code\character::precachemodelarray(lib_09C1::main());
  precachemodel("helmet_sdf_army_light_1");
  precachemodel("sdf_army_boost_pack_zerog");
  level.var_7649["iw7\core\human\helmet_sdf_army_broken"] = loadfx("vfx\iw7\core\human\helmet_sdf_army_broken.vfx");
}