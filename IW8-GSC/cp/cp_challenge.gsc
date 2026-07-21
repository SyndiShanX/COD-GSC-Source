/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_challenge.gsc
***********************************************/

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");

main() {
  self setModel("_encstr_846B16C6D749E9D1DE41EDF11B80892319B0FD3789676121");
  self.bhasthighholster = 0;
  self.animtree = "_encstr_A5AD0EDA0198272AF00797B83388B643";
  self.animationarchetype = "_encstr_ACF80B97CFB24530E51A66F982";
  self.voice = "_encstr_964A08F5B3EE7B335128";
  self setclothtype("_encstr_BEE00A93594E2BE548C7786C");

  if(issentient(self))
    self sethitlocdamagetable("_encstr_96861358B47D63ED8D43D2E8F532AD76D10B893656");

  self useanimtree(#animtree);
}

precache() {
  precachemodel("_encstr_846B16C6D749E9D1DE41EDF11B80892319B0FD3789676121");
}

main_mp() {
  self.animationarchetype = "_encstr_ACF80B97CFB24530E51A66F982";
  self.voice = "_encstr_964A08F5B3EE7B335128";
  self setModel("_encstr_846B16C6D749E9D1DE41EDF11B80892319B0FD3789676121");
}

precache_mp(var_0) {
  level.agent_definition[var_0]["_encstr_A6F10A61AAEFF1582559D7CF"] = "_encstr_ACF80B97CFB24530E51A66F982";
}