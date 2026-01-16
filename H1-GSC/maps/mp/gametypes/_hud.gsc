/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hud.gsc
********************************/

init() {
  level.uiparent = spawnstruct();
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
  level.hud["allies"] = spawnstruct();
  level.hud["axis"] = spawnstruct();
  level.primaryprogressbary = -61;
  level.primaryprogressbarx = 0;
  level.primaryprogressbarheight = 9;
  level.primaryprogressbarwidth = 120;
  level.primaryprogressbartexty = -75;
  level.primaryprogressbartextx = 0;
  level.primaryprogressbarfontsize = 0.6;
  level.teamprogressbary = 32;
  level.teamprogressbarheight = 14;
  level.teamprogressbarwidth = 192;
  level.teamprogressbartexty = 8;
  level.teamprogressbarfontsize = 1.65;
  level.lowertextyalign = "BOTTOM";
  level.lowertexty = -90;
  level.lowertextfontsize = 1.0;
}

fontpulseinit(var_0) {
  self.basefontscale = self.fontscale;

  if(isdefined(var_0))
    self.maxfontscale = min(var_0, 6.3);
  else
    self.maxfontscale = min(self.fontscale * 2, 6.3);

  self.inframes = 2;
  self.outframes = 4;
}

fontpulse(var_0) {
  self notify("fontPulse");
  self endon("fontPulse");
  self endon("death");
  var_0 endon("disconnect");
  var_0 endon("joined_team");
  var_0 endon("joined_spectators");
  self changefontscaleovertime(self.inframes * 0.05);
  self.fontscale = self.maxfontscale;
  wait(self.inframes * 0.05);
  self changefontscaleovertime(self.outframes * 0.05);
  self.fontscale = self.basefontscale;
}