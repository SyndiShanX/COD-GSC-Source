/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2910.gsc
**************************************/

func_CBAA() {
  return;
}

func_CBB5(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvarint("e3")) {
    return;
  }
  if(gettime() < 500) {
    wait 0.5;
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(level.var_CB9C)) {
    level.var_CB9C = level.player getweaponattachmentarray();
  }

  if(func_CBAC()) {
    return;
  }
  level.var_CB9C.enableshadows = 1;
  level.var_CB9C.rendertotexture = 1;
  level.var_CB9C.clipdistance = 5000;
  level.var_CB9C.nearz = 2;
  level.var_CB9C.aspectratio = 1;
  level.var_CB9C.origin_offset = (0, 0, 0);
  level.var_CB9C.angles_offset = (0, 0, 0);
  level.var_CB9C.tag = var_1;
  level.var_CB9C.fov = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 30);

  if(isDefined(var_3)) {
    level.var_CB9C.origin_offset = var_3;
  }

  if(isDefined(var_4)) {
    level.var_CB9C.angles_offset = var_4;
  }

  level.var_CB9C.entity = var_0;
  level.var_CB9C.enable = 1;
  level.var_CB9C.freecamera = 1;
  setomnvar("ui_pip_static", 0);
  setomnvar("ui_pip_message_text_top", "script_pip_default_top");
  setomnvar("ui_pip_message_text_bottom", "script_pip_default_bottom");
  setomnvar("ui_pip_message_type", 1);

  if(!isDefined(var_5)) {
    setomnvar("ui_show_pip", 1);

    if(isDefined(level.player func_8473())) {
      setomnvar("ui_jackal_hide_follow_pip", 1);
    } else {
      setomnvar("ui_jackal_hide_follow_pip", 0);
    }
  }
}

func_2ADF(var_0) {
  level.player playSound("ui_pip_on_hud_right");
  setomnvar("ui_pip_message_text_top", "script_pip_default_top");
  setomnvar("ui_pip_message_text_bottom", "script_pip_default_bottom");
  _stopcinematicingame();
  _setsaveddvar("bg_cinematicFullScreen", "0");
  _setsaveddvar("bg_cinematicCanPause", "1");
  setomnvar("ui_show_pip", 1);
  wait 0.05;
  setomnvar("ui_show_pip", 0);
  wait 0.05;
  setomnvar("ui_show_pip", 1);
  _cinematicingame(var_0);

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  while(iscinematicplaying()) {
    wait 0.05;
  }

  _stopcinematicingame();
  setomnvar("ui_show_pip", 0);
  level.player playSound("ui_pip_off_hud_right");
  _setsaveddvar("bg_cinematicFullScreen", "1");
  _setsaveddvar("bg_cinematicCanPause", "1");
}

func_CBC3(var_0) {
  level.var_CB9C.activevisionset = "naked";
  level.var_CB9C.activevisionsetduration = 0.5;
  level.var_CB9C.visionsetnaked = var_0;
}

func_CBA3() {
  if(getdvarint("e3")) {
    return;
  }
  if(!isDefined(level.var_CB9C)) {
    return;
  }
  setomnvar("ui_show_pip", 0);
  setomnvar("ui_jackal_hide_follow_pip", 1);
  level.var_CB9C.enable = 0;
  level notify("pip_closed");
}

func_CBAC() {
  return isDefined(level.var_CB9C) && isDefined(level.var_CB9C.enable) && level.var_CB9C.enable;
}

func_CBA5(var_0) {
  func_6A67();
  scripts\sp\utility::func_10347(var_0);
  func_CBA3();
}

func_6A67(var_0) {
  switch (tolower(self.unittype)) {
    case "c6i":
      func_CBB5(self, "tag_eye", 29, (18, 7, 1), (0, 200, 3), var_0);
      break;
    case "jackal":
      func_CBB5(self, "tag_barrel", 13, (150, 0, 20), (8.5, 180, 0), var_0);
      break;
    default:
      func_CBB5(self, "tag_eye", 29, (18, 7, -1), (0, 200, 3), var_0);
      level.var_CB9C.nearz = 17;
      break;
  }
}

func_CBC4() {
  func_6A67();
  self waittill("close_pip");
  func_CBA3();
}