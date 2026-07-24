/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2134.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_marines_bdu");
  self attach("head_sc_male_12", "", 1);
  self.headmodel = "head_sc_male_12";
  scripts\code\character::attachhat("alias_hats_marine_male_12_hair", _id_097D::main());
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_marines_bdu");
  precachemodel("head_sc_male_12");
  scripts\code\character::precachemodelarray(_id_097D::main());
}