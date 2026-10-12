/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\pip_util.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\pip_util;
#using scripts\sp\utility;
#namespace pip_util;

function pip_init() {
  println("<dev string:x1c>");
}

function pip_on_ent(ent, tag, fov, origin_offset, angles_offset, no_hud) {
  if(getdvarint(@ "e3")) {
    return;
  }

  if(gettime() < 500) {
    println("<dev string:x5c>");
    wait 0.5;
  }

  if(!isDefined(tag)) {
    iprintlnbold("<dev string:xac>");

    return;
  }

  if(!isDefined(level.pip)) {
    level.pip = level.player newpip();
  }

  if(pip_is_active()) {
    iprintln("<dev string:xef>");

    return;
  }

  level.pip.enableshadows = 1;
  level.pip.rendertotexture = 1;
  level.pip.clipdistance = 5000;
  level.pip.nearz = 2;
  level.pip.aspectratio = 1;
  level.pip.origin_offset = (0, 0, 0);
  level.pip.angles_offset = (0, 0, 0);
  level.pip.tag = tag;
  level.pip.fov = ter_op(isDefined(fov), fov, 30);

  if(isDefined(origin_offset)) {
    level.pip.origin_offset = origin_offset;
  }

  if(isDefined(angles_offset)) {
    level.pip.angles_offset = angles_offset;
  }

  level.pip.entity = ent;
  level.pip.enable = 1;
  level.pip.freecamera = 1;
  setomnvar("ui_pip_static", 0);
  setomnvar("ui_pip_message_text_top", "script_pip_default_top");
  setomnvar("ui_pip_message_text_bottom", "script_pip_default_bottom");
  setomnvar("ui_pip_message_type", 1);

  if(!isDefined(no_hud)) {
    setomnvar("ui_show_pip", 1);
    setomnvar("ui_jackal_hide_follow_pip", 0);
  }
}

function bink_pip(bink_name) {
  level.player playSound("ui_pip_on_hud_right");
  setomnvar("ui_pip_message_text_top", "script_pip_default_top");
  setomnvar("ui_pip_message_text_bottom", "script_pip_default_bottom");
  stopcinematicingame();
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "0");
  setsaveddvar(@ "hash_b9ff37d084074df3", "1");
  setomnvar("ui_show_pip", 1);
  wait 0.05;
  setomnvar("ui_show_pip", 0);
  wait 0.05;
  setomnvar("ui_show_pip", 1);
  cinematicingame(bink_name);

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  while(iscinematicplaying()) {
    wait 0.05;
  }

  stopcinematicingame();
  setomnvar("ui_show_pip", 0);
  level.player playSound("ui_pip_off_hud_right");
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "1");
  setsaveddvar(@ "hash_b9ff37d084074df3", "1");
}

function pip_visionset(vision) {
  level.pip.activevisionset = "naked";
  level.pip.activevisionsetduration = 0.5;
  level.pip.visionsetnaked = vision;
}

function pip_close() {
  if(getdvarint(@ "e3")) {
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

function pip_is_active() {
  return isDefined(level.pip) && isDefined(level.pip.enable) && level.pip.enable;
}

function pip_dialogue(the_line) {
  face_pip();
  smart_dialogue_generic(the_line);
  scripts\sp\pip_util::pip_close();
}

function face_pip(no_hud) {
  switch (tolower(self.unittype)) {
    case #"hash_198d036c171c0b3f":
      scripts\sp\pip_util::pip_on_ent(self, "tag_eye", 29, (18, 7, 1), (0, 200, 3), no_hud);
      break;
    case #"hash_8b0d967838e55b97":
      scripts\sp\pip_util::pip_on_ent(self, "tag_barrel", 13, (150, 0, 20), (8.5, 180, 0), no_hud);
      break;
    default:
      scripts\sp\pip_util::pip_on_ent(self, "tag_eye", 29, (18, 7, -1), (0, 200, 3), no_hud);
      level.pip.nearz = 17;
      break;
  }
}

function pip_vo() {
  face_pip();
  self waittill("close_pip");
  pip_close();
}