/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2211.gsc
***************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(func_093F::main());
  scripts\code\character::attachhead("heads_un_marines_male", func_09F6::main());
  self.hatmodel = "helmet_un_marines";
  self attach(self.hatmodel);
  self.func_A489 = "pack_un_jackal_pilots";
  self attach(self.func_A489);
  self.func_1FEC = "generic_human";
  self.func_1FA8 = "marine";
  self.voice = "unitednations";
  self give_explosive_touch_on_revived("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  self.func_8E1A = level.func_7649["iw7\core\human\helmet_un_marines_broken"];
  self glinton(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(func_093F::main());
  scripts\code\character::precachemodelarray(func_09F6::main());
  precachemodel("helmet_un_marines");
  precachemodel("pack_un_jackal_pilots");
  level.func_7649["iw7\core\human\helmet_un_marines_broken"] = loadfx("vfx\iw7\core\human\helmet_un_marines_broken.vfx");
}