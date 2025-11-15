/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2336.gsc
************************/

main() {
  self setModel("seeker_grenade_wm");
  self.var_1FEC = "seeker";
  self.var_1FA8 = "seeker";
  self.voice = "unitednations";
  self give_explosive_touch_on_revived("none");
  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  self glinton(#animtree);
}

precache() {
  precachemodel("seeker_grenade_wm");
}