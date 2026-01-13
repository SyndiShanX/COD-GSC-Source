/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\pip_util.gsc
*********************************************/

func_CBAA() {}

func_CBB5(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvarint("e3")) {
    return;
  }

  if(gettime() < 500) {
    wait(0.5);
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

  level.var_CB9C.isglassdestroyed = 1;
  level.var_CB9C.print = 1;
  level.var_CB9C.var_9E = 5000;
  level.var_CB9C.tablelookupistringbyrow = 2;
  level.var_CB9C.var_4C = 1;
  level.var_CB9C.origin_offset = (0, 0, 0);
  level.var_CB9C.var_42 = (0, 0, 0);
  level.var_CB9C.physics_setgravitydynentscalar = var_1;
  level.var_CB9C.missionsuccess = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 30);
  if(isDefined(var_3)) {
    level.var_CB9C.origin_offset = var_3;
  }

  if(isDefined(var_4)) {
    level.var_CB9C.var_42 = var_4;
  }

  level.var_CB9C.issplitscreen = var_0;
  level.var_CB9C.isenemyteam = 1;
  level.var_CB9C.nodesvisible = 1;
  setomnvar("ui_pip_static", 0);
  setomnvar("ui_pip_message_text_top", "script_pip_default_top");
  setomnvar("ui_pip_message_text_bottom", "script_pip_default_bottom");
  setomnvar("ui_pip_message_type", 1);
  if(!isDefined(var_5)) {
    setomnvar("ui_show_pip", 1);
    if(isDefined(level.player func_8473())) {
      setomnvar("ui_jackal_hide_follow_pip", 1);
      return;
    }

    setomnvar("ui_jackal_hide_follow_pip", 0);
  }
}

func_2ADF(var_0) {
  level.player playSound("ui_pip_on_hud_right");
  setomnvar("ui_pip_message_text_top", "script_pip_default_top");
  setomnvar("ui_pip_message_text_bottom", "script_pip_default_bottom");
  stopcinematicingame();
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  setomnvar("ui_show_pip", 1);
  wait(0.05);
  setomnvar("ui_show_pip", 0);
  wait(0.05);
  setomnvar("ui_show_pip", 1);
  cinematicingame(var_0);
  while(!iscinematicplaying()) {
    wait(0.05);
  }

  while(iscinematicplaying()) {
    wait(0.05);
  }

  stopcinematicingame();
  setomnvar("ui_show_pip", 0);
  level.player playSound("ui_pip_off_hud_right");
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
}

func_CBC3(var_0) {
  level.var_CB9C.var_1A = "naked";
  level.var_CB9C.var_1B = 0.5;
  level.var_CB9C.var_386 = var_0;
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
  level.var_CB9C.isenemyteam = 0;
  level notify("pip_closed");
}

func_CBAC() {
  return isDefined(level.var_CB9C) && isDefined(level.var_CB9C.isenemyteam) && level.var_CB9C.isenemyteam;
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
      level.var_CB9C.tablelookupistringbyrow = 17;
      break;
  }
}

func_CBC4() {
  func_6A67();
  self waittill("close_pip");
  func_CBA3();
}