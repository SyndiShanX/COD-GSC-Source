/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2286.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_hero_gator_tacvest");
  self attach("head_hero_gator", "", 1);
  self.headmodel = "head_hero_gator";
  self.hatmodel = "hero_gator_breathing_mask";
  self attach(self.hatmodel);
  self._id_A489 = "pack_un_jackal_pilots";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_gator";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_hero_gator_tacvest");
  precachemodel("head_hero_gator");
  precachemodel("hero_gator_breathing_mask");
  precachemodel("pack_un_jackal_pilots");
}