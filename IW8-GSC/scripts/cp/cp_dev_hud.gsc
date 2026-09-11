/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_dev_hud.gsc
***********************************************/

function init_dev_hud() {
  if(istrue(level.dev_debug_menus)) {
    return;
  }

  level.dev_debug_menus = 1;
  level.hudelems = [];
  level.hudelem_count = 16;
  var0 = [];
  var1 = [];
  var0 = 0;
  GscBinSkip0(0x2e, 0, 0);
}

function highlight_current_selection(var0, var1) {
  var0 notify("highlight_current_selection");
  var0 endon("highlight_current_selection");
  var0 endon("disconnect");
  level endon("game_ended");

  if(!isDefined(level.slot)) {
    level.slot = 0;
  }

  if(!isDefined(level.slot_cap)) {
    level.slot_cap = 14;
  }

  setDvar("scr_door_anim_override", "");
  var0 notifyonplayercommand("B", "+stance");
  var0 notifyonplayercommand("LT", "+speed_throw");
  var0 notifyonplayercommand("A", "+goStand");
  var0 notifyonplayercommand("X", "+usereload");
  var0 notifyonplayercommand("X", "+activate");
  var0 notifyonplayercommand("RS", "+melee_zoom");
  var0 notifyonplayercommand("LS", "+breath_sprint");
  var0 notifyonplayercommand("RT", "+attack");
  var0 notifyonplayercommand("RB", "+frag");
  var0 notifyonplayercommand("LB", "+smoke");
  var0 notifyonplayercommand("Y", "+weapnext");
  var0 notifyonplayercommand("UP", "+actionslot 1");
  var0 notifyonplayercommand("DOWN", "+actionslot 2");
  var0 notifyonplayercommand("LEFT", "+actionslot 3");
  var0 notifyonplayercommand("RIGHT", "+actionslot 4");
  var0 notifyonplayercommand("BACK", "+focus");
  var0 notifyonplayercommand("START", "pause");
  thread show_selection_menu(level, level.slot);

  for(;;) {
    var2 = var0 scripts\engine\utility::waittill_any_in_array_return(["A", "B", "Y", "X", "LB", "RB", "RT", "LT", "RS", "LS", "UP", "DOWN", "LEFT", "RIGHT", "BACK"]);

    switch (var2) {
      case "Y":
      case "B":
        clear_hud_elements();
        return;
      case "A":
        clear_hud_elements();
        return level.menu_current_selection;
      case "DOWN":
        level.slot++;
        level.slot = scripts\engine\math::wrap(0, var1.size - 1, level.slot);
        thread show_selection_menu(level.slot, var1);
        break;
      case "UP":
        level.slot--;
        level.slot = scripts\engine\math::wrap(0, var1.size - 1, level.slot);
        thread show_selection_menu(level.slot, var1);
        break;
      case "RIGHT":
        break;
      case "LEFT":
        break;
    }
    LOC_00000277:
  }
}

function show_selection_menu(var0, var1) {
  clear_hud_elements();
  var2 = [];
  var3 = clamp(var1.size, 0, level.slot_cap);
  var4 = var1.size - 1;
  var5 = scripts\engine\math::wrap(0, var4, var0);
  var6 = var1[var5];
  var7 = min(level.slot_cap, var1.size);
  var8 = int(var7 / 2);
  var9 = var0 - var8;
  var9 = scripts\engine\math::wrap(0, var4, var9);

  for(var10 = 0; var10 < var7; var10++) {
    if(!isDefined(var1[var9])) {
      continue;
    }

    var2 = var1[var9];
    var9++;
    var9 = scripts\engine\math::wrap(0, var4, var9);
  }

  for(var10 = 0; var10 < var2.size; var10++) {
    var11 = var2[var10];

    if(var10 == var8) {
      level.menu_current_selection = var11;
      var11 = "->" + var11;
      var12 = (1, 1, 0);
    } else {
      var12 = (1, 1, 1);
    }

    set_hud_element(var11, var12);
  }
}

function set_hud_element(var0, var1) {
  for(var2 = 0; var2 < 1; var2++) {
    if(isDefined(var1)) {
      level.hudelems[level.placementhudelements][var2].color = var1;
    }
  }

  level.placementhudelements++;
}

function clear_hud_elements() {
  level.cleartextmarker clearalltextafterhudelem();

  for(var0 = 0; var0 < level.hudelem_count; var0++) {
    for(var1 = 0; var1 < 1; var1++) {
      level.hudelems[var0][var1].color = (1, 1, 1);
    }
  }

  level.placementhudelements = 0;
}