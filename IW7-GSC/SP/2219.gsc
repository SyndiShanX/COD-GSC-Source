/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2219.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_0941::main());
  scripts\code\character::attachhead("heads_un_marines_male_bloody", _id_09F7::main());
  self.hatmodel = "helmet_un_marines_noglass";
  self attach(self.hatmodel);
  self._id_A489 = "pack_un_jackal_pilots";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "marine";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self._id_8E1A = level._id_7649["iw7/core/human/helmet_un_marines_broken"];
  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_0941::main());
  scripts\code\character::precachemodelarray(_id_09F7::main());
  precachemodel("helmet_un_marines_noglass");
  precachemodel("pack_un_jackal_pilots");
  level._id_7649["iw7/core/human/helmet_un_marines_broken"] = loadfx("vfx/iw7/core/human/helmet_un_marines_broken.vfx");
}