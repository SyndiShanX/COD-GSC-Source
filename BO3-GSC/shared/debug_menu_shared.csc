/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\debug_menu_shared.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flagsys_shared;
#using scripts\shared\util_shared;
#namespace debug_menu;

function open(localclientnum, a_menu_items) {
  close(localclientnum);
  level flagsys::set("menu_open");
  populatescriptdebugmenu(localclientnum, a_menu_items);
  luiload("uieditor.menus.ScriptDebugMenu");
  level.scriptdebugmenu = createluimenu(localclientnum, "ScriptDebugMenu");
  openluimenu(localclientnum, level.scriptdebugmenu);
}

function close(localclientnum) {
  level flagsys::clear("menu_open");
  if(isDefined(level.scriptdebugmenu)) {
    closeluimenu(localclientnum, level.scriptdebugmenu);
    level.scriptdebugmenu = undefined;
  }
}

function set_item_text(localclientnum, index, name) {
  controllermodel = getuimodelforcontroller(localclientnum);
  parentmodel = getuimodel(controllermodel, "cscDebugMenu.listItem" + index);
  model = getuimodel(parentmodel, "name");
  setuimodelvalue(model, name);
}

function set_item_color(localclientnum, index, color) {
  controllermodel = getuimodelforcontroller(localclientnum);
  parentmodel = getuimodel(controllermodel, "cscDebugMenu.listItem" + index);
  model = getuimodel(parentmodel, "color");
  if(isvec(color)) {
    color = ((("" + (color[0] * 255)) + " ") + (color[1] * 255) + " ") + (color[2] * 255);
  }
  setuimodelvalue(model, color);
}