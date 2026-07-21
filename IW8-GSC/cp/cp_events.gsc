/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_events.gsc
***********************************************/

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");

main() {
  self setModel("_encstr_846B16C6D749E9D1DE41EDF11B80892319B0FD3789676121");
  self attach("_encstr_86391699DF5A7DA92B42C9E3AAEE80AA51031B1F9F023138", "_encstr_B40101", 1);
  self.headmodel = "_encstr_86391699DF5A7DA92B42C9E3AAEE80AA51031B1F9F023138";
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
  precachemodel("_encstr_846B16C6D749E9D1DE41EDF11B80892319B0FD3789676121");
  precachemodel("_encstr_86391699DF5A7DA92B42C9E3AAEE80AA51031B1F9F023138");
}

main_mp() {
  self.animationarchetype = "_encstr_82F80BEB201803D4431089B2D0";
  self.voice = "_encstr_964A08F5B3EE7B335128";
  self setModel("_encstr_846B16C6D749E9D1DE41EDF11B80892319B0FD3789676121");
  self attach("_encstr_86391699DF5A7DA92B42C9E3AAEE80AA51031B1F9F023138", "_encstr_B40101", 1);
  self.headmodel = "_encstr_86391699DF5A7DA92B42C9E3AAEE80AA51031B1F9F023138";
}

precache_mp(var_0) {
  level.agent_definition[var_0]["_encstr_A6F10A61AAEFF1582559D7CF"] = "_encstr_82F80BEB201803D4431089B2D0";
}