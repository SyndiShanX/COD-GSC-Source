/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1309.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_sdf_kotch");
  self attach("head_sdf_chaplain", "", 1);
  self.headmodel = "head_sdf_chaplain";
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "setdef";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_sdf_kotch");
  precachemodel("head_sdf_chaplain");
}