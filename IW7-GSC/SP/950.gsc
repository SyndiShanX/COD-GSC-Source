/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 950.gsc
**************************************/

#using_animtree("c12");

main() {
  self setModel("ally_robot_c12");
  self._id_1FEC = "c12";
  self._id_1FA8 = "c12";
  self.voice = "unitednations";
  self _meth_82C6("c12servo");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("ally_robot_c12");
}