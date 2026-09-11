/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_hadir_young.gsc
****************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_hero_hadir_child");
  self attach("head_sc_m_coto", "", 1);
  self.headmodel = "head_sc_m_coto";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "hadir_yth";
  self.voice = "sas";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_hero_hadir_child");
  precachemodel("head_sc_m_coto");
}

function main_mp() {
  self.animationarchetype = "hadir_yth";
  self.voice = "sas";
  self setModel("body_hero_hadir_child");
  self attach("head_sc_m_coto", "", 1);
  self.headmodel = "head_sc_m_coto";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "hadir_yth";
}