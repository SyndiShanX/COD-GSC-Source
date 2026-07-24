/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 999.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_0957::main());
  self attach("head_bg_var_head_bg_engineering_mate_head_male_bc_02_blast_damage_dustable", "", 1);
  self.headmodel = "head_bg_var_head_bg_engineering_mate_head_male_bc_02_blast_damage_dustable";
  self.hatmodel = "head_bg_engineering_mate_hair_a_brown_dustable";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "civilian";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_0957::main());
  precachemodel("head_bg_var_head_bg_engineering_mate_head_male_bc_02_blast_damage_dustable");
  precachemodel("head_bg_engineering_mate_hair_a_brown_dustable");
}