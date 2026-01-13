/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2282.gsc
***************************************/

#using_animtree("generic_human");

main() {
  self setModel("fullbody_hero_eth3n_dustable");
  self.var_1FEC = "generic_human";
  self.var_1FA8 = "hero_eth3n";
  self.voice = "unitednations";
  self give_explosive_touch_on_revived("c6iservo");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  self glinton(#animtree);
}

precache() {
  precachemodel("fullbody_hero_eth3n_dustable");
}