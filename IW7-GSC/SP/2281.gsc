/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2281.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("fullbody_hero_eth3n");
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_eth3n";
  self.voice = "unitednations";
  self _meth_82C6("c6iservo");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("fullbody_hero_eth3n");
}