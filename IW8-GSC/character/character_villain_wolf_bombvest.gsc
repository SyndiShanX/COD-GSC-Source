/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_villain_wolf_bombvest.gsc
*********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_villain_wolf_bombvest");
  self attach("head_villain_wolf", "", 1);
  self.headmodel = "head_villain_wolf";
  self.bhasthighholster = 0;
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
  precachemodel("body_villain_wolf_bombvest");
  precachemodel("head_villain_wolf");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "unitednations";
  self setModel("body_villain_wolf_bombvest");
  self attach("head_villain_wolf", "", 1);
  self.headmodel = "head_villain_wolf";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}