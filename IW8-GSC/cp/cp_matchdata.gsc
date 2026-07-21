/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_matchdata.gsc
***********************************************/

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");

main() {
  self setModel("_encstr_AF601C4288558FB968ABF6D777503A1F0BA39BFA30A0976E28AB27A8174A");
  self attach("_encstr_BAFD18A1B20B19D79B1BAF6BFAB616E4D9F639D95ADCEBB1B4CE", "_encstr_B40101", 1);
  self.headmodel = "_encstr_BAFD18A1B20B19D79B1BAF6BFAB616E4D9F639D95ADCEBB1B4CE";
  self.bhasthighholster = 0;
  self.animtree = "_encstr_A5AD0EDA0198272AF00797B83388B643";
  self.animationarchetype = "_encstr_A7DA0C4F13842AD4F8813D49F908";
  self.voice = "_encstr_841804CCB9B0";
  self setclothtype("_encstr_BEE00A93594E2BE548C7786C");

  if(issentient(self))
    self sethitlocdamagetable("_encstr_96861358B47D63ED8D43D2E8F532AD76D10B893656");

  self useanimtree(#animtree);
}

precache() {
  precachemodel("_encstr_AF601C4288558FB968ABF6D777503A1F0BA39BFA30A0976E28AB27A8174A");
  precachemodel("_encstr_BAFD18A1B20B19D79B1BAF6BFAB616E4D9F639D95ADCEBB1B4CE");
}

main_mp() {
  self.animationarchetype = "_encstr_A7DA0C4F13842AD4F8813D49F908";
  self.voice = "_encstr_841804CCB9B0";
  self setModel("_encstr_AF601C4288558FB968ABF6D777503A1F0BA39BFA30A0976E28AB27A8174A");
  self attach("_encstr_BAFD18A1B20B19D79B1BAF6BFAB616E4D9F639D95ADCEBB1B4CE", "_encstr_B40101", 1);
  self.headmodel = "_encstr_BAFD18A1B20B19D79B1BAF6BFAB616E4D9F639D95ADCEBB1B4CE";
}

precache_mp(var_0) {
  level.agent_definition[var_0]["_encstr_A6F10A61AAEFF1582559D7CF"] = "_encstr_A7DA0C4F13842AD4F8813D49F908";
}