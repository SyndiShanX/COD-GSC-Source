/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hud.gsc
***************************************************/

init() {
  level.uiParent = spawnStruct();
  level.uiParent.horzAlign = "left";
  level.uiParent.vertAlign = "top";
  level.uiParent.alignX = "left";
  level.uiParent.alignY = "top";
  level.uiParent.x = 0;
  level.uiParent.y = 0;
  level.uiParent.width = 0;
  level.uiParent.height = 0;
  level.uiParent.children = [];

  level.fontHeight = 12;

  level.hud["allies"] = spawnStruct();
  level.hud["axis"] = spawnStruct();

  level.primaryProgressBarY = -61;
  level.primaryProgressBarX = 0;
  level.primaryProgressBarHeight = 9;
  level.primaryProgressBarWidth = 120;
  level.primaryProgressBarTextY = -75;
  level.primaryProgressBarTextX = 0;
  level.primaryProgressBarFontSize = .6;

  level.teamProgressBarY = 32;
  level.teamProgressBarHeight = 14;
  level.teamProgressBarWidth = 192;
  level.teamProgressBarTextY = 8;
  level.teamProgressBarFontSize = 1.65;

  level.lowerTextYAlign = "BOTTOM";
  level.lowerTextY = -90;
  level.lowerTextFontSize = 1.6;
}

fontPulseInit(maxFontScale) {
  self.baseFontScale = self.fontScale;
  if(isDefined(maxFontScale)) {
    self.maxFontScale = min(maxFontScale, 6.3);
  } else {
    self.maxFontScale = min(self.fontScale * 2, 6.3);
  }
  self.inFrames = 2;
  self.outFrames = 4;
}

fontPulse(player) {
  self notify("fontPulse");
  self endon("fontPulse");
  self endon("death");

  player endon("disconnect");
  player endon("joined_team");
  player endon("joined_spectators");

  self ChangeFontScaleOverTime(self.inFrames * 0.05);
  self.fontScale = self.maxFontScale;
  wait self.inFrames * 0.05;

  self ChangeFontScaleOverTime(self.outFrames * 0.05);
  self.fontScale = self.baseFontScale;
}