/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2284.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("fullbody_hero_eth3n");
  self._id_A489 = "pack_eth3n_zerog";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "zero_gravity_space";
  self.voice = "unitednations";
  self _meth_82C6("c6iservo");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("fullbody_hero_eth3n");
  precachemodel("pack_eth3n_zerog");
}