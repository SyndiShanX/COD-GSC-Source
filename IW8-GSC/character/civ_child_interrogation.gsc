/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_child_interrogation.gsc
*************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("civ_child_interrogation");
  self attach("head_sc_m_ahmed_no_subd_civ_clean", "", 1);
  self.headmodel = "head_sc_m_ahmed_no_subd_civ_clean";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian_female";
  self.voice = "unitednationsfemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("civ_child_interrogation");
  precachemodel("head_sc_m_ahmed_no_subd_civ_clean");
}

function main_mp() {
  self.animationarchetype = "civilian_female";
  self.voice = "unitednationsfemale";
  self setModel("civ_child_interrogation");
  self attach("head_sc_m_ahmed_no_subd_civ_clean", "", 1);
  self.headmodel = "head_sc_m_ahmed_no_subd_civ_clean";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian_female";
}