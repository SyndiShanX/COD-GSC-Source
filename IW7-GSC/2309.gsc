/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2309.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_hero_protagonist");
  self attach("head_hero_protagonist_helmet", "", 1);
  self.headmodel = "head_hero_protagonist_helmet";
  self.hatmodel = "helmet_hero_protagonist";
  self attach(self.hatmodel);
  self._id_A489 = "pack_un_jackal_pilots";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_hero_protagonist");
  precachemodel("head_hero_protagonist_helmet");
  precachemodel("helmet_hero_protagonist");
  precachemodel("pack_un_jackal_pilots");
}