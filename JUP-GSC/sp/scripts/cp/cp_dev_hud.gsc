/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_dev_hud.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace cp_dev_hud;

function init_dev_hud() {
  if(istrue(level.dev_debug_menus)) {
    return;
  }

  level.dev_debug_menus = 1;
  level.hudelems = [];
  level.hudelem_count = 16;
  stroffsetx = [];
  stroffsety = [];
  stroffsetx[0] = 0;
  stroffsety[0] = 0;
  stroffsetx[1] = 1;
  stroffsety[1] = 1;
  stroffsetx[2] = -2;
  stroffsety[2] = 1;
  stroffsetx[3] = 1;
  stroffsety[3] = -1;
  stroffsetx[4] = -2;
  stroffsety[4] = -1;
  level.cleartextmarker = newhudelem();
  level.cleartextmarker.alpha = 0;
  level.cleartextmarker.archived = 0;

  level.cleartextmarker setdevtext("<dev string:x1c>");

  for(i = 0; i < level.hudelem_count; i++) {
    newstrarray = [];

    for(p = 0; p < 1; p++) {
      newstr = newhudelem();
      newstr.alignx = "left";
      newstr.aligny = "middle";
      newstr.archived = 0;
      newstr.location = 0;
      newstr.foreground = 1;
      newstr.fontscale = 0.75;
      newstr.sort = 20 - p;
      newstr.alpha = 1;
      newstr.x = -70 + stroffsetx[p];
      newstr.y = 30 + stroffsety[p] + i * 10;

      if(p > 0) {
        newstr.color = (0, 0, 0);
      }

      newstrarray[newstrarray.size] = newstr;
    }

    level.hudelems[i] = newstrarray;
  }

  hud = newhudelem();
  hud.archived = 0;
  hud.alignx = "center";
  hud.location = 0;
  hud.foreground = 1;
  hud.fontscale = 1.4;
  hud.sort = 20;
  hud.alpha = 1;
  hud.x = 320;
  hud.y = 40;
  level.centerprint = hud;
}

function highlight_current_selection(player, array) {
  player notify("highlight_current_selection");
  player endon("highlight_current_selection");
  player endon("disconnect");
  level endon("game_ended");

  if(!isDefined(level.slot)) {
    level.slot = 0;
  }

  if(!isDefined(level.slot_cap)) {
    level.slot_cap = 14;
  }

  setDvar(@ "hash_6c42f3a33b28799a", "");
  player notifyonplayercommand("B", "+stance");
  player notifyonplayercommand("LT", "+speed_throw");
  player notifyonplayercommand("A", "+goStand");
  player notifyonplayercommand("X", "+usereload");
  player notifyonplayercommand("X", "+activate");
  player notifyonplayercommand("RS", "+melee_zoom");
  player notifyonplayercommand("LS", "+breath_sprint");
  player notifyonplayercommand("RT", "+attack");
  player notifyonplayercommand("RB", "+frag");
  player notifyonplayercommand("LB", "+smoke");
  player notifyonplayercommand("Y", "+weapnext");
  player notifyonplayercommand("UP", "+actionslot 1");
  player notifyonplayercommand("DOWN", "+actionslot 2");
  player notifyonplayercommand("LEFT", "+actionslot 3");
  player notifyonplayercommand("RIGHT", "+actionslot 4");
  player notifyonplayercommand("BACK", "+focus");
  player notifyonplayercommand("START", "pause");
  level thread show_selection_menu(level.slot, array);

  while(true) {
    result = player waittill_any_in_array_return(["A", "B", "Y", "X", "LB", "RB", "RT", "LT", "RS", "LS", "UP", "DOWN", "LEFT", "RIGHT", "BACK"]);

    if(!isDefined(result)) {
      continue;
    }

    switch (result) {
      case #"hash_311062bc01bdbb25":
      case #"hash_311077bc01bddc34":
        clear_hud_elements();
        return;
      case #"hash_31105fbc01bdb66c":
        clear_hud_elements();
        return level.menu_current_selection;
      case #"hash_1e6e35d002e26a35":
        level.slot++;
        level.slot = math::wrap(0, array.size - 1, level.slot);
        thread show_selection_menu(level.slot, array);
        break;
      case #"hash_faa298f6bdc36b00":
        level.slot--;
        level.slot = math::wrap(0, array.size - 1, level.slot);
        thread show_selection_menu(level.slot, array);
        break;
      case #"hash_a946b3072fef3225":
        break;
      case #"hash_10db13ff19b27ed0":
        break;
    }
  }
}

function show_selection_menu(slot, array) {
  clear_hud_elements();
  temp_array = [];
  end = clamp(array.size, 0, level.slot_cap);
  array_size = array.size - 1;
  slot_index = math::wrap(0, array_size, slot);
  main_string = array[slot_index];
  cap = min(level.slot_cap, array.size);
  starting_index = int(cap / 2);
  current_index = slot - starting_index;
  current_index = math::wrap(0, array_size, current_index);

  for(i = 0; i < cap; i++) {
    if(!isDefined(array[current_index])) {
      continue;
    }

    temp_array[temp_array.size] = array[current_index];
    current_index++;
    current_index = math::wrap(0, array_size, current_index);
  }

  for(i = 0; i < temp_array.size; i++) {
    menu_string = temp_array[i];

    if(i == starting_index) {
      level.menu_current_selection = menu_string;
      menu_string = "->" + menu_string;
      color = (1, 1, 0);
    } else {
      color = (1, 1, 1);
    }

    set_hud_element(menu_string, color);
  }
}

function set_hud_element(text, color) {
  for(p = 0; p < 1; p++) {
    level.hudelems[level.placementhudelements][p] setdevtext(text);

    if(isDefined(color)) {
      level.hudelems[level.placementhudelements][p].color = color;
    }
  }

  level.placementhudelements++;
  assert(level.placementhudelements <= level.hudelem_count);
}

function clear_hud_elements() {
  level.cleartextmarker clearalltextafterhudelem();

  for(i = 0; i < level.hudelem_count; i++) {
    for(p = 0; p < 1; p++) {
      level.hudelems[i][p] setdevtext("<dev string:x23>");

      level.hudelems[i][p].color = (1, 1, 1);
    }
  }

  level.placementhudelements = 0;
}