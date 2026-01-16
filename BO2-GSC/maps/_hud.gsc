/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_hud.gsc
**************************************/

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
  level.primaryprogressbary = -61;
  level.primaryprogressbarx = 0;
  level.primaryprogressbarheight = 9;
  level.primaryprogressbarwidth = 120;
  level.primaryprogressbartexty = -75;
  level.primaryprogressbartextx = 0;
  level.primaryprogressbarfontsize = 1.4;
  level.secondaryprogressbary = -85;
  level.secondaryprogressbarx = 0;
  level.secondaryprogressbarheight = 9;
  level.secondaryprogressbarwidth = 120;
  level.secondaryprogressbartexty = -100;
  level.secondaryprogressbartextx = 0;
  level.secondaryprogressbarfontsize = 1.4;
  level.fontheight = 12;
}