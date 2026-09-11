/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_sla_rebels_female_prisoner_4.gsc
********************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_sla_rebels_female_prisoner_4");
  self attach("head_sc_f_hujbar_shaved_bg", "", 1);
  self.headmodel = "head_sc_f_hujbar_shaved_bg";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "rebel_female";
  self.voice = "fsafemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_sla_rebels_female_prisoner_4");
  precachemodel("head_sc_f_hujbar_shaved_bg");
}

function main_mp() {
  self.animationarchetype = "rebel_female";
  self.voice = "fsafemale";
  self setModel("body_sla_rebels_female_prisoner_4");
  self attach("head_sc_f_hujbar_shaved_bg", "", 1);
  self.headmodel = "head_sc_f_hujbar_shaved_bg";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "rebel_female";
}