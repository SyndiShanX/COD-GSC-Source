/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2094.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_hero_sipes");
  self attach("head_hero_sipes", "", 1);
  self.headmodel = "head_hero_sipes";
  self.hatmodel = "helmet_head_hero_sipes";
  self attach(self.hatmodel);
  self._id_A489 = "pack_un_jackal_pilots_zerog";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_sipes";
  self.voice = "unitednationshelmet";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_hero_sipes");
  precachemodel("head_hero_sipes");
  precachemodel("helmet_head_hero_sipes");
  precachemodel("pack_un_jackal_pilots_zerog");
}