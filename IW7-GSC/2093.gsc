/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2093.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_jackal_pilots");
  self attach("head_sc_kloos", "", 1);
  self.headmodel = "head_sc_kloos";
  self.hatmodel = "helmet_un_jackal_pilots_generic";
  self attach(self.hatmodel);
  self._id_A489 = "pack_un_jackal_pilots";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednationshelmet";
  self _meth_82C6("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_jackal_pilots");
  precachemodel("head_sc_kloos");
  precachemodel("helmet_un_jackal_pilots_generic");
  precachemodel("pack_un_jackal_pilots");
}