/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2095.gsc
*********************************************/

main() {
  self setModel("body_hero_t");
  self attach("head_hero_t", "", 1);
  self.headmodel = "head_hero_t";
  self.hatmodel = "head_hero_t_helmet";
  self attach(self.hatmodel);
  self.var_A489 = "pack_un_jackal_pilots_zerog";
  self attach(self.var_A489);
  self.var_1FEC = "generic_human";
  self.var_1FA8 = "hero_t";
  self.voice = "unitednationshelmet";
  self give_explosive_touch_on_revived("vestlight");
  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  self glinton(#animtree);
}

precache() {
  precachemodel("body_hero_t");
  precachemodel("head_hero_t");
  precachemodel("head_hero_t_helmet");
  precachemodel("pack_un_jackal_pilots_zerog");
}