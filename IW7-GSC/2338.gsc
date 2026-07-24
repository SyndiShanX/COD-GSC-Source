/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2338.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_sdf_hvt_prisoner");
  self attach("head_sdf_hvt", "", 1);
  self.headmodel = "head_sdf_hvt";
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
  precachemodel("body_sdf_hvt_prisoner");
  precachemodel("head_sdf_hvt");
}