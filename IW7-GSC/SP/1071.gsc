/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1071.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_0944::main());
  self attach("head_bg_var_head_bg_female_04_head_hero_tigris_captain", "", 1);
  self.headmodel = "head_bg_var_head_bg_female_04_head_hero_tigris_captain";
  self.hatmodel = "head_bg_female_04_hair_a_blonde";
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
  scripts\code\character::precachemodelarray(_id_0944::main());
  precachemodel("head_bg_var_head_bg_female_04_head_hero_tigris_captain");
  precachemodel("head_bg_female_04_hair_a_blonde");
}