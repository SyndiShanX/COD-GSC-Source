/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2095.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_hero_t");
  self attach("head_hero_t", "", 1);
  self.headmodel = "head_hero_t";
  self.hatmodel = "head_hero_t_helmet";
  self attach(self.hatmodel);
  self._id_A489 = "pack_un_jackal_pilots_zerog";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_t";
  self.voice = "unitednationshelmet";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_hero_t");
  precachemodel("head_hero_t");
  precachemodel("head_hero_t_helmet");
  precachemodel("pack_un_jackal_pilots_zerog");
}