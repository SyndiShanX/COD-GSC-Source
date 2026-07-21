/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_gastrap.gsc
***********************************************/

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");

main() {
  self setModel("_encstr_838F11866DF24346DB63B03047EE599DA91606");
  self attach("_encstr_B8CB11B3DBBF4A5798F3AFF38BA8B163186B53", "_encstr_B40101", 1);
  self.headmodel = "_encstr_B8CB11B3DBBF4A5798F3AFF38BA8B163186B53";
  self.bhasthighholster = 0;
  self.animtree = "_encstr_A5AD0EDA0198272AF00797B83388B643";
  self.animationarchetype = "_encstr_A5450BC280BF4B604068C33187";
  self.voice = "_encstr_964A08F5B3EE7B335128";
  self setclothtype("_encstr_BEE00A93594E2BE548C7786C");

  if(issentient(self))
    self sethitlocdamagetable("_encstr_96861358B47D63ED8D43D2E8F532AD76D10B893656");

  self useanimtree(#animtree);
}

precache() {
  precachemodel("_encstr_838F11866DF24346DB63B03047EE599DA91606");
  precachemodel("_encstr_B8CB11B3DBBF4A5798F3AFF38BA8B163186B53");
}

main_mp() {
  self.animationarchetype = "_encstr_A5450BC280BF4B604068C33187";
  self.voice = "_encstr_964A08F5B3EE7B335128";
  self setModel("_encstr_838F11866DF24346DB63B03047EE599DA91606");
  self attach("_encstr_B8CB11B3DBBF4A5798F3AFF38BA8B163186B53", "_encstr_B40101", 1);
  self.headmodel = "_encstr_B8CB11B3DBBF4A5798F3AFF38BA8B163186B53";
}

precache_mp(var_0) {
  level.agent_definition[var_0]["_encstr_A6F10A61AAEFF1582559D7CF"] = "_encstr_A5450BC280BF4B604068C33187";
}