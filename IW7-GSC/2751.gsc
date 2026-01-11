/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2751.gsc
***************************************/

init() {
  level.uiparent = spawnStruct();
  level.uiparent.horzalign = "left";
  level.uiparent.vertalign = "top";
  level.uiparent.alignx = "left";
  level.uiparent.aligny = "top";
  level.uiparent.x = 0;
  level.uiparent.y = 0;
  level.uiparent.width = 0;
  level.uiparent.height = 0;
  level.uiparent.children = [];
  level.fontheight = 12;
  level.func_912F["allies"] = spawnStruct();
  level.func_912F["axis"] = spawnStruct();
  level.primaryprogressbary = -61;
  level.primaryprogressbarx = 0;
  level.primaryprogressbarheight = 9;
  level.primaryprogressbarwidth = 120;
  level.primaryprogressbartexty = -75;
  level.primaryprogressbartextx = 0;
  level.primaryprogressbarfontsize = 1.2;
  level.func_115E4 = 32;
  level.func_115E1 = 14;
  level.func_115E3 = 192;
  level.func_115E2 = 8;
  level.func_115E0 = 1.65;
  level.lowertextyalign = "BOTTOM";
  level.lowertexty = -140;
  level.lowertextfontsize = 1.6;
}

fontpulseinit(var_00) {
  self.basefontscale = self.fontscale;

  if(isDefined(var_00)) {
    self.maxfontscale = min(var_00, 6.3);
  }
  else {
    self.maxfontscale = min(self.fontscale * 2, 6.3);
  }

  self.inframes = 2;
  self.outframes = 4;
}

fontpulse(var_00) {
  self notify("fontPulse");
  self endon("fontPulse");
  self endon("death");
  var_00 endon("disconnect");
  var_00 endon("joined_team");
  var_00 endon("joined_spectators");
  self changefontscaleovertime(self.inframes * 0.05);
  self.fontscale = self.maxfontscale;
  wait(self.inframes * 0.05);
  self changefontscaleovertime(self.outframes * 0.05);
  self.fontscale = self.basefontscale;
}