/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2224.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_093D::main());
  scripts\code\character::attachhead("heads_un_marines_female", _id_09F4::main());
  self.hatmodel = "head_un_marines_female_helmet";
  self attach(self.hatmodel);
  self._id_A489 = "pack_female";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_salter";
  self.voice = "unitednationsfemale";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self._id_8E1A = level._id_7649["iw7/core/human/helmet_un_marines_broken"];
  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_093D::main());
  scripts\code\character::precachemodelarray(_id_09F4::main());
  precachemodel("head_un_marines_female_helmet");
  precachemodel("pack_female");
  level._id_7649["iw7/core/human/helmet_un_marines_broken"] = loadfx("vfx/iw7/core/human/helmet_un_marines_broken.vfx");
}