/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2304.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_hero_mco_bdu");
  self attach("head_hero_mco_dirty", "", 1);
  self.headmodel = "head_hero_mco_dirty";
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
  precachemodel("body_hero_mco_bdu");
  precachemodel("head_hero_mco_dirty");
}