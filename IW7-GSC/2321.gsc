/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2321.gsc
***************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_hero_xo_dustable");
  self attach("head_hero_xo_dirty_dustable", "", 1);
  self.headmodel = "head_hero_xo_dirty_dustable";
  self.func_1FEC = "generic_human";
  self.func_1FA8 = "hero_salter";
  self.voice = "unitednations";
  self give_explosive_touch_on_revived("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  self glinton(#animtree);
}

precache() {
  precachemodel("body_hero_xo_dustable");
  precachemodel("head_hero_xo_dirty_dustable");
}