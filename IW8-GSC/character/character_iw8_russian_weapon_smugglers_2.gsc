/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_russian_weapon_smugglers_2.gsc
******************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_russian_weapon_smugglers_2");
  self attach("head_sc_m_orlovszki_civ_tattoo", "", 1);
  self.headmodel = "head_sc_m_orlovszki_civ_tattoo";
  self.hatmodel = "hat_sc_m_orlovszki_beanie";
  self attach(self.hatmodel);
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
  precachemodel("body_russian_weapon_smugglers_2");
  precachemodel("head_sc_m_orlovszki_civ_tattoo");
  precachemodel("hat_sc_m_orlovszki_beanie");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "russian";
  self setModel("body_russian_weapon_smugglers_2");
  self attach("head_sc_m_orlovszki_civ_tattoo", "", 1);
  self.headmodel = "head_sc_m_orlovszki_civ_tattoo";
  self.hatmodel = "hat_sc_m_orlovszki_beanie";
  self attach(self.hatmodel);
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}