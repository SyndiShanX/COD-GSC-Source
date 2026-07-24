/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2325.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_hero_chaplain");
  self attach("head_sc_chaplain", "", 1);
  self.headmodel = "head_sc_chaplain";
  self.hatmodel = "head_sc_chaplain_breathing_mask";
  self attach(self.hatmodel);
  self._id_A489 = "pack_un_jackal_pilots_black";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_brooks";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_hero_chaplain");
  precachemodel("head_sc_chaplain");
  precachemodel("head_sc_chaplain_breathing_mask");
  precachemodel("pack_un_jackal_pilots_black");
}