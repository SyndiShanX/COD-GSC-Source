/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_villain_enforcer_st_petersburg.gsc
******************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_villain_enforcer_st_petersburg");
  self attach("head_villain_enforcer", "", 1);
  self.headmodel = "head_villain_enforcer";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "unitednations";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_villain_enforcer_st_petersburg");
  precachemodel("head_villain_enforcer");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "unitednations";
  self setModel("body_villain_enforcer_st_petersburg");
  self attach("head_villain_enforcer", "", 1);
  self.headmodel = "head_villain_enforcer";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}