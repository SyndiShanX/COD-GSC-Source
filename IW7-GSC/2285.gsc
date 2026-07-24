/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2285.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_hero_gator");
  self attach("head_hero_gator", "", 1);
  self.headmodel = "head_hero_gator";
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_gator";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_hero_gator");
  precachemodel("head_hero_gator");
}