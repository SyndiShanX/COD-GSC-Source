/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1038.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_0950::main());
  self attach("head_bg_var_head_bg_female_03_head_female_bc_02_blast_damage", "", 1);
  self.headmodel = "head_bg_var_head_bg_female_03_head_female_bc_02_blast_damage";
  self.hatmodel = "head_bg_female_03_hair_c_black";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "civilian_female";
  self.voice = "unitednationsfemale";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_0950::main());
  precachemodel("head_bg_var_head_bg_female_03_head_female_bc_02_blast_damage");
  precachemodel("head_bg_female_03_hair_c_black");
}