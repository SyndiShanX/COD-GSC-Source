/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2302.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_marines_bdu_bloody");
  self attach("head_sc_male_12_bloody", "", 1);
  self.headmodel = "head_sc_male_12_bloody";
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_marines_bdu_bloody");
  precachemodel("head_sc_male_12_bloody");
}