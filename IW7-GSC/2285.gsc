/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2285.gsc
*********************************************/

main() {
  self setModel("body_hero_gator");
  self attach("head_hero_gator", "", 1);
  self.headmodel = "head_hero_gator";
  self.var_1FEC = "generic_human";
  self.var_1FA8 = "hero_gator";
  self.voice = "unitednations";
  self give_explosive_touch_on_revived("vestlight");
  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  self glinton(#animtree);
}

precache() {
  precachemodel("body_hero_gator");
  precachemodel("head_hero_gator");
}