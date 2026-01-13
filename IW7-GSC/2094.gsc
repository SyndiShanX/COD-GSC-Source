/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2094.gsc
*********************************************/

main() {
  self setModel("body_hero_sipes");
  self attach("head_hero_sipes", "", 1);
  self.headmodel = "head_hero_sipes";
  self.hatmodel = "helmet_head_hero_sipes";
  self attach(self.hatmodel);
  self.var_A489 = "pack_un_jackal_pilots_zerog";
  self attach(self.var_A489);
  self.var_1FEC = "generic_human";
  self.var_1FA8 = "hero_sipes";
  self.voice = "unitednationshelmet";
  self give_explosive_touch_on_revived("vestlight");
  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  self glinton(#animtree);
}

precache() {
  precachemodel("body_hero_sipes");
  precachemodel("head_hero_sipes");
  precachemodel("helmet_head_hero_sipes");
  precachemodel("pack_un_jackal_pilots_zerog");
}