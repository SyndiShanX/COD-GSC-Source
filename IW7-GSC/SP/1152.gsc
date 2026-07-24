/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1152.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_0959::main());
  self attach("head_bg_var_head_sc_male_19_blast_damage", "", 1);
  self.headmodel = "head_bg_var_head_sc_male_19_blast_damage";
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "civilian";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_0959::main());
  precachemodel("head_bg_var_head_sc_male_19_blast_damage");
}