/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hud.gsc
***********************************************/

init() {
  level.uiparent = spawnStruct();
  level.uiparent.horzalign = "_encstr_A5AD056A019C63";
  level.uiparent.vertalign = "_encstr_AC190479FF92";
  level.uiparent.alignx = "_encstr_A5AD056A019C63";
  level.uiparent.aligny = "_encstr_AC190479FF92";
  level.uiparent.x = 0;
  level.uiparent.y = 0;
  level.uiparent.width = 0;
  level.uiparent.height = 0;
  level.uiparent.children = [];
  level.fontheight = 12;
  level.hud["_encstr_9A8507BA4040188D08"] = spawnStruct();
  level.hud["_encstr_8E8405EA382B2A"] = spawnStruct();
  level.primaryprogressbary = -61;
  level.primaryprogressbarx = 0;
  level.primaryprogressbarheight = 9;
  level.primaryprogressbarwidth = 120;
  level.primaryprogressbartexty = -75;
  level.primaryprogressbartextx = 0;
  level.primaryprogressbarfontsize = 1.2;
  level.teamprogressbary = 32;
  level.teamprogressbarheight = 14;
  level.teamprogressbarwidth = 192;
  level.teamprogressbartexty = 8;
  level.teamprogressbarfontsize = 1.65;
  level.lowertextyalign = "_encstr_A146079E6DF9115CFD";
  level.lowertexty = -155;
  level.lowertextfontsize = 1.6;
}

fontpulseinit(var_0) {
  self.basefontscale = self.fontscale;

  if(isDefined(var_0))
    self.maxfontscale = min(var_0, 6.3);
  else
    self.maxfontscale = min(self.fontscale * 2, 6.3);

  self.inframes = 2;
  self.outframes = 4;
}

fontpulse(var_0) {
  self notify("_encstr_99160A5417DA4D1093196AE8");
  self endon("_encstr_99160A5417DA4D1093196AE8");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_81170C244F9CBDE72C01BB99A298");
  var_0 endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self changefontscaleovertime(self.inframes * 0.05);
  self.fontscale = self.maxfontscale;
  wait(self.inframes * 0.05);
  self changefontscaleovertime(self.outframes * 0.05);
  self.fontscale = self.basefontscale;
}