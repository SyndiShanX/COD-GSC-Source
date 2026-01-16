/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_hud.gsc
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

  if(level.console)
    level.fontheight = 12;
  else
    level.fontheight = 12;
}