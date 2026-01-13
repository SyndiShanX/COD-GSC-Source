/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2092.gsc
*********************************************/

main() {
  self setModel("body_un_jackal_pilots");
  scripts\code\character::attachhead("alias_heads_un_jackal_pilots_pt2", lib_09CB::main());
  self.hatmodel = "helmet_un_jackal_pilots_generic";
  self attach(self.hatmodel);
  self.var_A489 = "pack_un_jackal_pilots";
  self attach(self.var_A489);
  self.var_1FEC = "generic_human";
  self.var_1FA8 = "soldier";
  self.voice = "unitednationshelmet";
  self give_explosive_touch_on_revived("vestlight");
  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  self glinton(#animtree);
}

precache() {
  precachemodel("body_un_jackal_pilots");
  scripts\code\character::precachemodelarray(lib_09CB::main());
  precachemodel("helmet_un_jackal_pilots_generic");
  precachemodel("pack_un_jackal_pilots");
}