/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2337.gsc
***************************************/

#using_animtree("generic_human");

main() {
  self setModel("parts_flightsuit");
  self attach("head_sdf_hvt", "", 1);
  self.headmodel = "head_sdf_hvt";
  self.var_1FEC = "generic_human";
  self.var_1FA8 = "soldier";
  self.voice = "unitednations";
  self give_explosive_touch_on_revived("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  self glinton(#animtree);
}

precache() {
  precachemodel("parts_flightsuit");
  precachemodel("head_sdf_hvt");
}