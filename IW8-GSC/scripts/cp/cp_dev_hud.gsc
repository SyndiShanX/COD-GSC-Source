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
  var_0 = [];
  var_1 = [];
  var_0 = 0;
  GscBinSkip0(0x2e, 0, 0);
}

function highlight_current_selection(var_0, var_1) {
  var_0 notify("highlight_current_selection");
  var_0 endon("highlight_current_selection");
  var_0 endon("disconnect");
  level endon("game_ended");

  if(!isDefined(level.slot)) {
    level.slot = 0;
  }

  if(!isDefined(level.slot_cap)) {
    level.slot_cap = 14;
  }

  setDvar("scr_door_anim_override", "");
  var_0 notifyonplayercommand("B", "+stance");
  var_0 notifyonplayercommand("LT", "+speed_throw");
  var_0 notifyonplayercommand("A", "+goStand");
  var_0 notifyonplayercommand("X", "+usereload");
  var_0 notifyonplayercommand("X", "+activate");
  var_0 notifyonplayercommand("RS", "+melee_zoom");
  var_0 notifyonplayercommand("LS", "+breath_sprint");
  var_0 notifyonplayercommand("RT", "+attack");
  var_0 notifyonplayercommand("RB", "+frag");
  var_0 notifyonplayercommand("LB", "+smoke");
  var_0 notifyonplayercommand("Y", "+weapnext");
  var_0 notifyonplayercommand("UP", "+actionslot 1");
  var_0 notifyonplayercommand("DOWN", "+actionslot 2");
  var_0 notifyonplayercommand("LEFT", "+actionslot 3");
  var_0 notifyonplayercommand("RIGHT", "+actionslot 4");
  var_0 notifyonplayercommand("BACK", "+focus");
  var_0 notifyonplayercommand("START", "pause");
  thread show_selection_menu(level, level.slot);

  for(;;) {
    var_2 = var_0 scripts\engine\utility::waittill_any_in_array_return(["A", "B", "Y", "X", "LB", "RB", "RT", "LT", "RS", "LS", "UP", "DOWN", "LEFT", "RIGHT", "BACK"]);

    switch (var_2) {
      case "Y":
      case "B":
        clear_hud_elements();
        return;
      case "A":
        clear_hud_elements();
        return level.menu_current_selection;
      case "DOWN":
        level.slot++;
        level.slot = scripts\engine\math::wrap(0, var_1.size - 1, level.slot);
        thread show_selection_menu(level.slot, var_1);
        break;
      case "UP":
        level.slot--;
        level.slot = scripts\engine\math::wrap(0, var_1.size - 1, level.slot);
        thread show_selection_menu(level.slot, var_1);
        break;
      case "RIGHT":
        break;
      case "LEFT":
        break;
    }
    LOC_00000277:
  }
}

function show_selection_menu(var_0, var_1) {
  clear_hud_elements();
  var_2 = [];
  var_3 = clamp(var_1.size, 0, level.slot_cap);
  var_4 = var_1.size - 1;
  var_5 = scripts\engine\math::wrap(0, var_4, var_0);
  var_6 = var_1[var_5];
  var_7 = min(level.slot_cap, var_1.size);
  var_8 = int(var_7 / 2);
  var_9 = var_0 - var_8;
  var_9 = scripts\engine\math::wrap(0, var_4, var_9);

  for(var_10 = 0; var_10 < var_7; var_10++) {
    if(!isDefined(var_1[var_9])) {
      continue;
    }

    var_2 = var_1[var_9];
    var_9++;
    var_9 = scripts\engine\math::wrap(0, var_4, var_9);
  }

  for(var_10 = 0; var_10 < var_2.size; var_10++) {
    var_11 = var_2[var_10];

    if(var_10 == var_8) {
      level.menu_current_selection = var_11;
      var_11 = "->" + var_11;
      var_12 = (1, 1, 0);
    } else {
      var_12 = (1, 1, 1);
    }

    set_hud_element(var_11, var_12);
  }
}

function set_hud_element(var_0, var_1) {
  for(var_2 = 0; var_2 < 1; var_2++) {
    if(isDefined(var_1)) {
      level.hudelems[level.placementhudelements][var_2].color = var_1;
    }
  }

  level.placementhudelements++;
}

function clear_hud_elements() {
  level.cleartextmarker clearalltextafterhudelem();

  for(var_0 = 0; var_0 < level.hudelem_count; var_0++) {
    for(var_1 = 0; var_1 < 1; var_1++) {
      level.hudelems[var_0][var_1].color = (1, 1, 1);
    }
  }

  level.placementhudelements = 0;
}