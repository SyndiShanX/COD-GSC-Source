/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2315.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_hero_xo");
  self attach("head_hero_noHair_xo_dirty", "", 1);
  self.headmodel = "head_hero_noHair_xo_dirty";
  self.hatmodel = "helmet_hero_xo";
  self attach(self.hatmodel);
  self._id_A489 = "pack_female";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_salter";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_hero_xo");
  precachemodel("head_hero_noHair_xo_dirty");
  precachemodel("helmet_hero_xo");
  precachemodel("pack_female");
}