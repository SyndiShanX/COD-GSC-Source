/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1455.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_hero_fire_jack");
  self attach("head_sc_fire_jack", "", 1);
  self.headmodel = "head_sc_fire_jack";
  self.hatmodel = "fire_jack_cap";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("nylon");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_hero_fire_jack");
  precachemodel("head_sc_fire_jack");
  precachemodel("fire_jack_cap");
}