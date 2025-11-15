/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2224.gsc
***************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(func_093D::main());
  scripts\code\character::attachhead("heads_un_marines_female", func_09F4::main());
  self.hatmodel = "head_un_marines_female_helmet";
  self attach(self.hatmodel);
  self.func_A489 = "pack_female";
  self attach(self.func_A489);
  self.func_1FEC = "generic_human";
  self.func_1FA8 = "hero_salter";
  self.voice = "unitednationsfemale";
  self give_explosive_touch_on_revived("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");

  self.func_8E1A = level.func_7649["iw7\core\human\helmet_un_marines_broken"];
  self glinton(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(func_093D::main());
  scripts\code\character::precachemodelarray(func_09F4::main());
  precachemodel("head_un_marines_female_helmet");
  precachemodel("pack_female");
  level.func_7649["iw7\core\human\helmet_un_marines_broken"] = loadfx("vfx\iw7\core\human\helmet_un_marines_broken.vfx");
}