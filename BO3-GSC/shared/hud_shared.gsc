/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\hud_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\system_shared;
#namespace hud;

function autoexec __init__sytem__() {
  system::register("hud", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype(&init);
}

function init() {
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
  foreach(team in level.teams) {
    level.hud[team] = spawnStruct();
  }
  level.primaryprogressbary = -61;
  level.primaryprogressbarx = 0;
  level.primaryprogressbarheight = 9;
  level.primaryprogressbarwidth = 120;
  level.primaryprogressbartexty = -75;
  level.primaryprogressbartextx = 0;
  level.primaryprogressbarfontsize = 1.4;
  if(level.splitscreen) {
    level.primaryprogressbarx = 20;
    level.primaryprogressbartextx = 20;
    level.primaryprogressbary = 15;
    level.primaryprogressbartexty = 0;
    level.primaryprogressbarheight = 2;
  }
  level.secondaryprogressbary = -85;
  level.secondaryprogressbarx = 0;
  level.secondaryprogressbarheight = 9;
  level.secondaryprogressbarwidth = 120;
  level.secondaryprogressbartexty = -100;
  level.secondaryprogressbartextx = 0;
  level.secondaryprogressbarfontsize = 1.4;
  if(level.splitscreen) {
    level.secondaryprogressbarx = 20;
    level.secondaryprogressbartextx = 20;
    level.secondaryprogressbary = 15;
    level.secondaryprogressbartexty = 0;
    level.secondaryprogressbarheight = 2;
  }
  level.teamprogressbary = 32;
  level.teamprogressbarheight = 14;
  level.teamprogressbarwidth = 192;
  level.teamprogressbartexty = 8;
  level.teamprogressbarfontsize = 1.65;
  setDvar("ui_generic_status_bar", 0);
  if(level.splitscreen) {
    level.lowertextyalign = "BOTTOM";
    level.lowertexty = -42;
    level.lowertextfontsize = 1.4;
  } else {
    level.lowertextyalign = "CENTER";
    level.lowertexty = 40;
    level.lowertextfontsize = 1.4;
  }
}

function font_pulse_init() {
  self.basefontscale = self.fontscale;
  self.maxfontscale = self.fontscale * 2;
  self.inframes = 1.5;
  self.outframes = 3;
}

function font_pulse(player) {
  self notify("fontpulse");
  self endon("fontpulse");
  self endon("death");
  player endon("disconnect");
  player endon("joined_team");
  player endon("joined_spectators");
  if(self.outframes == 0) {
    self.fontscale = 0.01;
  } else {
    self.fontscale = self.fontscale;
  }
  if(self.inframes > 0) {
    self changefontscaleovertime(self.inframes * 0.05);
    self.fontscale = self.maxfontscale;
    wait(self.inframes * 0.05);
  } else {
    self.fontscale = self.maxfontscale;
    self.alpha = 0;
    self fadeovertime(self.outframes * 0.05);
    self.alpha = 1;
  }
  if(self.outframes > 0) {
    self changefontscaleovertime(self.outframes * 0.05);
    self.fontscale = self.basefontscale;
  }
}

function fade_to_black_for_x_sec(startwait, blackscreenwait, fadeintime, fadeouttime, shadername) {
  self endon("disconnect");
  wait(startwait);
  lui::screen_fade_out(fadeintime, shadername);
  wait(blackscreenwait);
  lui::screen_fade_in(fadeouttime, shadername);
}

function screen_fade_in(fadeintime) {
  lui::screen_fade_in(fadeintime);
}