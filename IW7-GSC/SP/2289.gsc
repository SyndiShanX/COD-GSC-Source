/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2289.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_hero_marine_1_bdu");
  self attach("head_hero_marine_1", "", 1);
  self.headmodel = "head_hero_marine_1";
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_hero_marine_1_bdu");
  precachemodel("head_hero_marine_1");
}