/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_russian_weapon_smugglers_4.gsc
******************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_russian_weapon_smugglers_4");
  self attach("head_sc_m_sharipov", "", 1);
  self.headmodel = "head_sc_m_sharipov";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "russian";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_russian_weapon_smugglers_4");
  precachemodel("head_sc_m_sharipov");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "russian";
  self setModel("body_russian_weapon_smugglers_4");
  self attach("head_sc_m_sharipov", "", 1);
  self.headmodel = "head_sc_m_sharipov";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}