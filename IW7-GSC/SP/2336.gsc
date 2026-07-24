/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2336.gsc
**************************************/

#using_animtree("seeker");

main() {
  self setModel("seeker_grenade_wm");
  self._id_1FEC = "seeker";
  self._id_1FA8 = "seeker";
  self.voice = "unitednations";
  self _meth_82C6("none");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("seeker_grenade_wm");
}