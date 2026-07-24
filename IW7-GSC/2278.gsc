/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2278.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_hero_engineer_casual");
  self attach("head_hero_engineer", "", 1);
  self.headmodel = "head_hero_engineer";
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednationsfemale";
  self _meth_82C6("cloth");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_hero_engineer_casual");
  precachemodel("head_hero_engineer");
}