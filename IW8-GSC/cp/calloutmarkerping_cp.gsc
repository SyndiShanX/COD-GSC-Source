/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\calloutmarkerping_cp.gsc
***********************************************/

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");

main() {
  self setModel("_encstr_95AA1698DB91F2EB9B07CAD16E732C3DFA23B539D7F6C623");
  self attach("_encstr_A929120989199D8E876B1193C30629A0E9737751", "_encstr_B40101", 1);
  self.headmodel = "_encstr_A929120989199D8E876B1193C30629A0E9737751";
  self.hatmodel = "_encstr_973B200D58A3EBE607561D9B372C3DEBD0958DD656A3D7B11B7BE8A1AF2CD7CD67D9";
  self attach(self.hatmodel);
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
  precachemodel("_encstr_95AA1698DB91F2EB9B07CAD16E732C3DFA23B539D7F6C623");
  precachemodel("_encstr_A929120989199D8E876B1193C30629A0E9737751");
  precachemodel("_encstr_973B200D58A3EBE607561D9B372C3DEBD0958DD656A3D7B11B7BE8A1AF2CD7CD67D9");
}

main_mp() {
  self.animationarchetype = "_encstr_ACF80B97CFB24530E51A66F982";
  self.voice = "_encstr_964A08F5B3EE7B335128";
  self setModel("_encstr_95AA1698DB91F2EB9B07CAD16E732C3DFA23B539D7F6C623");
  self attach("_encstr_A929120989199D8E876B1193C30629A0E9737751", "_encstr_B40101", 1);
  self.headmodel = "_encstr_A929120989199D8E876B1193C30629A0E9737751";
  self.hatmodel = "_encstr_973B200D58A3EBE607561D9B372C3DEBD0958DD656A3D7B11B7BE8A1AF2CD7CD67D9";
  self attach(self.hatmodel);
}

precache_mp(var_0) {
  level.agent_definition[var_0]["_encstr_A6F10A61AAEFF1582559D7CF"] = "_encstr_ACF80B97CFB24530E51A66F982";
}