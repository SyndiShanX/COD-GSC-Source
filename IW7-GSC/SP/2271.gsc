/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2271.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_hero_boatswain");
  self attach("head_hero_boatswain_mars_hqss", "", 1);
  self.headmodel = "head_hero_boatswain_mars_hqss";
  self.hatmodel = "hero_boatswain_breathing_mask";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_boats";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_hero_boatswain");
  precachemodel("head_hero_boatswain_mars_hqss");
  precachemodel("hero_boatswain_breathing_mask");
}