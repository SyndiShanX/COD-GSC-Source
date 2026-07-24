/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2300.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_marines_female_medium_a");
  self attach("head_sc_nunez", "", 1);
  self.headmodel = "head_sc_nunez";
  self.hatmodel = "head_un_marines_female_helmet";
  self attach(self.hatmodel);
  self._id_A489 = "pack_un_jackal_pilots";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_salter";
  self.voice = "unitednationsfemale";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_marines_female_medium_a");
  precachemodel("head_sc_nunez");
  precachemodel("head_un_marines_female_helmet");
  precachemodel("pack_un_jackal_pilots");
}