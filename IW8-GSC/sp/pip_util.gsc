/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\pip_util.gsc
***********************************************/

pip_init() {
  return;
}

pip_on_ent(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvarint("e3")) {
    return;
  }
  if(gettime() < 500)
    wait 0.5;

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(level.pip))
    level.pip = level.player newpip();

  if(pip_is_active()) {
    return;
  }
  level.pip.enableshadows = 1;
  level.pip.rendertotexture = 1;
  level.pip.clipdistance = 5000;
  level.pip.nearz = 2;
  level.pip.aspectratio = 1;
  level.pip.origin_offset = (0, 0, 0);
  level.pip.angles_offset = (0, 0, 0);
  level.pip.tag = var_1;
  level.pip.fov = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 30);

  if(isDefined(var_3))
    level.pip.origin_offset = var_3;

  if(isDefined(var_4))
    level.pip.angles_offset = var_4;

  level.pip.entity = var_0;
  level.pip.enable = 1;
  level.pip.freecamera = 1;
  setomnvar("ui_pip_static", 0);
  setomnvar("ui_pip_message_text_top", "script_pip_default_top");
  setomnvar("ui_pip_message_text_bottom", "script_pip_default_bottom");
  setomnvar("ui_pip_message_type", 1);

  if(!isDefined(var_5)) {
    setomnvar("ui_show_pip", 1);
    setomnvar("ui_jackal_hide_follow_pip", 0);
  }
}

bink_pip(var_0) {
  level.player playSound("ui_pip_on_hud_right");
  setomnvar("ui_pip_message_text_top", "script_pip_default_top");
  setomnvar("ui_pip_message_text_bottom", "script_pip_default_bottom");
  stopcinematicingame();
  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("RKMNLRNS", "1");
  setomnvar("ui_show_pip", 1);
  wait 0.05;
  setomnvar("ui_show_pip", 0);
  wait 0.05;
  setomnvar("ui_show_pip", 1);
  cinematicingame(var_0);

  while(!iscinematicplaying())
    wait 0.05;

  while(iscinematicplaying())
    wait 0.05;

  stopcinematicingame();
  setomnvar("ui_show_pip", 0);
  level.player playSound("ui_pip_off_hud_right");
  setsaveddvar("MMRNLMPPLT", "1");
  setsaveddvar("RKMNLRNS", "1");
}

pip_visionset(var_0) {
  level.pip.activevisionset = "naked";
  level.pip.activevisionsetduration = 0.5;
  level.pip.visionsetnaked = var_0;
}

pip_close() {
  if(getdvarint("e3")) {
    return;
  }
  if(!isDefined(level.pip)) {
    return;
  }
  setomnvar("ui_show_pip", 0);
  setomnvar("ui_jackal_hide_follow_pip", 1);
  level.pip.enable = 0;
  level notify("pip_closed");
}

pip_is_active() {
  return isDefined(level.pip) && isDefined(level.pip.enable) && level.pip.enable;
}

pip_dialogue(var_0) {
  face_pip();
  scripts\engine\sp\utility::smart_dialogue_generic(var_0);
  pip_close();
}

face_pip(var_0) {
  switch (tolower(self.unittype)) {
    case "c6i":
      pip_on_ent(self, "tag_eye", 29, (18, 7, 1), (0, 200, 3), var_0);
      break;
    case "jackal":
      pip_on_ent(self, "tag_barrel", 13, (150, 0, 20), (8.5, 180, 0), var_0);
      break;
    default:
      pip_on_ent(self, "tag_eye", 29, (18, 7, -1), (0, 200, 3), var_0);
      level.pip.nearz = 17;
      break;
  }
}

pip_vo() {
  face_pip();
  self waittill("close_pip");
  pip_close();
}