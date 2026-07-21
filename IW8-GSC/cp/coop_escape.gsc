/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\coop_escape.gsc
***********************************************/

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");

main() {
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_spetsnaz_ar::main());
  scripts\code\character::attachhead("_encstr_816D1B96855E5F8B71331148A26F0BC96B6D39EFAE3F177E7602900752", xmodelalias\russian_army_heads_gasmask::main());
  scripts\code\character::attachhat("_encstr_B8831F482B0742315F32AF892E8868F1E2DD164F70624F0B10A7121946AD8757A2", xmodelalias\russian_army_ar_1_hats_gasmask::main());
  self.bhasthighholster = 1;
  self.animtree = "_encstr_A5AD0EDA0198272AF00797B83388B643";
  self.animationarchetype = "_encstr_82F80BEB201803D4431089B2D0";
  self.voice = "_encstr_964A08F5B3EE7B335128";
  self setclothtype("_encstr_BEE00A93594E2BE548C7786C");

  if(issentient(self))
    self sethitlocdamagetable("_encstr_96861358B47D63ED8D43D2E8F532AD76D10B893656");

  self useanimtree(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(xmodelalias\bodies_spetsnaz_ar::main());
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_heads_gasmask::main());
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_ar_1_hats_gasmask::main());
}

main_mp() {
  self.animationarchetype = "_encstr_82F80BEB201803D4431089B2D0";
  self.voice = "_encstr_964A08F5B3EE7B335128";
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_spetsnaz_ar::main());
  scripts\code\character::attachhead("_encstr_816D1B96855E5F8B71331148A26F0BC96B6D39EFAE3F177E7602900752", xmodelalias\russian_army_heads_gasmask::main());
  scripts\code\character::attachhat("_encstr_B8831F482B0742315F32AF892E8868F1E2DD164F70624F0B10A7121946AD8757A2", xmodelalias\russian_army_ar_1_hats_gasmask::main());
}

precache_mp(var_0) {
  level.agent_definition[var_0]["_encstr_A6F10A61AAEFF1582559D7CF"] = "_encstr_82F80BEB201803D4431089B2D0";
}