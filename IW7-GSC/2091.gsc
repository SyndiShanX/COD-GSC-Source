/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2091.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_jackal_pilots");
  scripts\code\character::attachhead("alias_heads_un_jackal_pilots_pt1", _id_09CA::main());
  self.hatmodel = "helmet_un_jackal_pilots_generic";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednationshelmet";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_jackal_pilots");
  scripts\code\character::precachemodelarray(_id_09CA::main());
  precachemodel("helmet_un_jackal_pilots_generic");
}