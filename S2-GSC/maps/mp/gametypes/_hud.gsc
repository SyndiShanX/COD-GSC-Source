/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hud.gsc
*********************************************/

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
  level.var_4F52["allies"] = spawnStruct();
  level.var_4F52["axis"] = spawnStruct();
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
  level.lowetextyalign = "BOTTOM";
  level.var_5F2E = -90;
  level.lowertextfontsize = 1.6;
}

func_3DDA(param_00) {
  self.basefontscale = self.fontscale;
  if(isDefined(param_00)) {
    self.var_6085 = min(param_00, 6.3);
  } else {
    self.var_6085 = min(self.fontscale * 2, 6.3);
  }

  self.var_5136 = 2;
  self.var_6C71 = 4;
}

func_3DD9(param_00) {
  self notify("fontPulse");
  self endon("fontPulse");
  self endon("death");
  param_00 endon("disconnect");
  param_00 endon("joined_team");
  param_00 endon("joined_spectators");
  self changefontscaleovertime(self.var_5136 * 0.05);
  self.fontscale = self.var_6085;
  wait(self.var_5136 * 0.05);
  self changefontscaleovertime(self.var_6C71 * 0.05);
  self.fontscale = self.basefontscale;
}