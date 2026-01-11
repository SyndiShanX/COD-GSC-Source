/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_hud.gsc
*****************************************************/

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
  if(level.console) {
    level.fontHeight = 12;
  } else {
    level.fontHeight = 12;
  }
}