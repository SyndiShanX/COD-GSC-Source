/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_spetsnaz_gasmask_ar_cp.gsc
**********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_al_qatala_urban_civ_3_1");
  self attach("head_sc_m_alameer_civ_bg_nohair", "", 1);
  self.headmodel = "head_sc_m_alameer_civ_bg_nohair";
  self.jetpackmodel = "al_qatala_urban_civ_bomb_vest";
  self attach(self.jetpackmodel);
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "suicidebomber_cp";
  self.voice = "alqatala";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_al_qatala_urban_civ_3_1");
  precachemodel("head_sc_m_alameer_civ_bg_nohair");
  precachemodel("al_qatala_urban_civ_bomb_vest");
}

function main_mp() {
  self.animationarchetype = "suicidebomber_cp";
  self.voice = "alqatala";
  self setModel("body_al_qatala_urban_civ_3_1");
  self attach("head_sc_m_alameer_civ_bg_nohair", "", 1);
  self.headmodel = "head_sc_m_alameer_civ_bg_nohair";
  self.jetpackmodel = "al_qatala_urban_civ_bomb_vest";
  self attach(self.jetpackmodel);
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "suicidebomber_cp";
}