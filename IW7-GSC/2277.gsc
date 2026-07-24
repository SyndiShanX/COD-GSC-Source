/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2277.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_hero_engineer");
  self attach("head_hero_engineer_helmet", "", 1);
  self.headmodel = "head_hero_engineer_helmet";
  self._id_A489 = "pack_female";
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
  precachemodel("body_hero_engineer");
  precachemodel("head_hero_engineer_helmet");
  precachemodel("pack_female");
}