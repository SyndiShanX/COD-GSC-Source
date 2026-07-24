/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 952.gsc
**************************************/

#using_animtree("c6");

main() {
  self setModel("robot_c6");
  self._id_1FEC = "c6";
  self._id_1FA8 = "c6";
  self.voice = "c6";
  self _meth_82C6("c6servo");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("robot_c6");
}