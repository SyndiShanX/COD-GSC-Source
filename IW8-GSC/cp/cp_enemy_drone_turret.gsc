/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_enemy_drone_turret.gsc
***********************************************/

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");

main() {
  self setModel("_encstr_9A6012C698982FBF07C3F0C1F3A541F0C1EED86B");
  scripts\code\character::attachhead("_encstr_816D1B96855E5F8B71331148A26F0BC96B6D39EFAE3F177E7602900752", xmodelalias\russian_army_heads_gasmask::main());
  self.bhasthighholster = 1;
  self.animtree = "_encstr_A5AD0EDA0198272AF00797B83388B643";
  self.animationarchetype = "_encstr_ACF80B97CFB24530E51A66F982";
  self.voice = "_encstr_964A08F5B3EE7B335128";
  self setclothtype("_encstr_BEE00A93594E2BE548C7786C");

  if(issentient(self))
    self sethitlocdamagetable("_encstr_96861358B47D63ED8D43D2E8F532AD76D10B893656");

  self useanimtree(#animtree);
}

precache() {
  precachemodel("_encstr_9A6012C698982FBF07C3F0C1F3A541F0C1EED86B");
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_heads_gasmask::main());
}

main_mp() {
  self.animationarchetype = "_encstr_ACF80B97CFB24530E51A66F982";
  self.voice = "_encstr_964A08F5B3EE7B335128";
  self setModel("_encstr_9A6012C698982FBF07C3F0C1F3A541F0C1EED86B");
  scripts\code\character::attachhead("_encstr_816D1B96855E5F8B71331148A26F0BC96B6D39EFAE3F177E7602900752", xmodelalias\russian_army_heads_gasmask::main());
}

precache_mp(var_0) {
  level.agent_definition[var_0]["_encstr_A6F10A61AAEFF1582559D7CF"] = "_encstr_ACF80B97CFB24530E51A66F982";
}