/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_dev_hud.gsc
***********************************************/

init_dev_hud() {
  if(istrue(level.dev_debug_menus)) {
    return;
  }
  level.dev_debug_menus = 1;
  level.hudelems = [];
  level.hudelem_count = 16;
  _id_33D665A8348C47BD = [];
  _id_33D664A8348C458A = [];
  _id_33D665A8348C47BD[0] = 0;
  _id_33D664A8348C458A[0] = 0;
  _id_33D665A8348C47BD[1] = 1;
  _id_33D664A8348C458A[1] = 1;
  _id_33D665A8348C47BD[2] = -2;
  _id_33D664A8348C458A[2] = 1;
  _id_33D665A8348C47BD[3] = 1;
  _id_33D664A8348C458A[3] = -1;
  _id_33D665A8348C47BD[4] = -2;
  _id_33D664A8348C458A[4] = -1;
  level.cleartextmarker = newhudelem();
  level.cleartextmarker.alpha = 0;
  level.cleartextmarker.archived = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.hudelem_count; _id_AC0E594AC96AA3A8++) {
    _id_9AF634FE97C006F5 = [];

    for(_id_AC0E424AC96A7113 = 0; _id_AC0E424AC96A7113 < 1; _id_AC0E424AC96A7113++) {
      _id_7D5D0059E2ECD538 = newhudelem();
      _id_7D5D0059E2ECD538.alignx = "left";
      _id_7D5D0059E2ECD538.aligny = "middle";
      _id_7D5D0059E2ECD538.archived = 0;
      _id_7D5D0059E2ECD538.location = 0;
      _id_7D5D0059E2ECD538.foreground = 1;
      _id_7D5D0059E2ECD538.fontscale = 0.75;
      _id_7D5D0059E2ECD538.sort = 20 - _id_AC0E424AC96A7113;
      _id_7D5D0059E2ECD538.alpha = 1;
      _id_7D5D0059E2ECD538.x = -70 + _id_33D665A8348C47BD[_id_AC0E424AC96A7113];
      _id_7D5D0059E2ECD538.y = 30 + _id_33D664A8348C458A[_id_AC0E424AC96A7113] + _id_AC0E594AC96AA3A8 * 10;

      if(_id_AC0E424AC96A7113 > 0)
        _id_7D5D0059E2ECD538.color = (0, 0, 0);

      _id_9AF634FE97C006F5[_id_9AF634FE97C006F5.size] = _id_7D5D0059E2ECD538;
    }

    level.hudelems[_id_AC0E594AC96AA3A8] = _id_9AF634FE97C006F5;
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

highlight_current_selection(player, array) {
  player notify("highlight_current_selection");
  player endon("highlight_current_selection");
  player endon("disconnect");
  level endon("game_ended");

  if(!isDefined(level.slot))
    level.slot = 0;

  if(!isDefined(level.slot_cap))
    level.slot_cap = 14;

  setDvar("dvar_6C42F3A33B28799A", "");
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

  for(;;) {
    result = player scripts\engine\utility::waittill_any_in_array_return(["A", "B", "Y", "X", "LB", "RB", "RT", "LT", "RS", "LS", "UP", "DOWN", "LEFT", "RIGHT", "BACK"]);

    if(!isDefined(result)) {
      continue;
    }
    switch (result) {
      case "Y":
      case "B":
        clear_hud_elements();
        return;
      case "A":
        clear_hud_elements();
        return level.menu_current_selection;
      case "DOWN":
        level.slot++;
        level.slot = scripts\engine\math::wrap(0, array.size - 1, level.slot);
        thread show_selection_menu(level.slot, array);
        break;
      case "UP":
        level.slot--;
        level.slot = scripts\engine\math::wrap(0, array.size - 1, level.slot);
        thread show_selection_menu(level.slot, array);
        break;
      case "RIGHT":
        break;
      case "LEFT":
        break;
    }
  }
}

show_selection_menu(slot, array) {
  clear_hud_elements();
  _id_6D906809844C7CB1 = [];
  end = clamp(array.size, 0, level.slot_cap);
  _id_12485DA956667AB6 = array.size - 1;
  _id_A64F51501360F422 = scripts\engine\math::wrap(0, _id_12485DA956667AB6, slot);
  _id_6C8D6BADDAC11CCC = array[_id_A64F51501360F422];
  _id_A5407B03B3E5F39F = min(level.slot_cap, array.size);
  _id_71117B214DB6D5A2 = int(_id_A5407B03B3E5F39F / 2);
  _id_BBB45D49F4EAF799 = slot - _id_71117B214DB6D5A2;
  _id_BBB45D49F4EAF799 = scripts\engine\math::wrap(0, _id_12485DA956667AB6, _id_BBB45D49F4EAF799);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A5407B03B3E5F39F; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(array[_id_BBB45D49F4EAF799])) {
      continue;
    }
    _id_6D906809844C7CB1[_id_6D906809844C7CB1.size] = array[_id_BBB45D49F4EAF799];
    _id_BBB45D49F4EAF799++;
    _id_BBB45D49F4EAF799 = scripts\engine\math::wrap(0, _id_12485DA956667AB6, _id_BBB45D49F4EAF799);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6D906809844C7CB1.size; _id_AC0E594AC96AA3A8++) {
    _id_088DFA55BD16575E = _id_6D906809844C7CB1[_id_AC0E594AC96AA3A8];

    if(_id_AC0E594AC96AA3A8 == _id_71117B214DB6D5A2) {
      level.menu_current_selection = _id_088DFA55BD16575E;
      _id_088DFA55BD16575E = "->" + _id_088DFA55BD16575E;
      color = (1, 1, 0);
    } else
      color = (1, 1, 1);

    set_hud_element(_id_088DFA55BD16575E, color);
  }
}

set_hud_element(text, color) {
  for(_id_AC0E424AC96A7113 = 0; _id_AC0E424AC96A7113 < 1; _id_AC0E424AC96A7113++) {
    if(isDefined(color))
      level.hudelems[level.placementhudelements][_id_AC0E424AC96A7113].color = color;
  }

  level.placementhudelements++;
}

clear_hud_elements() {
  level.cleartextmarker clearalltextafterhudelem();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.hudelem_count; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E424AC96A7113 = 0; _id_AC0E424AC96A7113 < 1; _id_AC0E424AC96A7113++)
      level.hudelems[_id_AC0E594AC96AA3A8][_id_AC0E424AC96A7113].color = (1, 1, 1);
  }

  level.placementhudelements = 0;
}