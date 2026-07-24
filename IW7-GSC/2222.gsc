/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2222.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_marines_drone");
  self attach("head_un_marines_drone", "", 1);
  self.headmodel = "head_un_marines_drone";
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
  precachemodel("body_un_marines_drone");
  precachemodel("head_un_marines_drone");
}