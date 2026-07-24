/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\load_code.gsc
**************************************/

_id_83D5() {
  setsaveddvar("cg_fovScale", "1");
  setsaveddvar("sv_saveOnStartMap", !isDefined(level._id_4A3A));
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 4);
  setsaveddvar("sm_spotUpdateLimit", 4);
  setsaveddvar("cg_hud_outline_colors_0", "0.000 0.000 0.000 0.000");
  setsaveddvar("cg_hud_outline_colors_1", "0.882 0.882 0.882 1.000");
  setsaveddvar("cg_hud_outline_colors_2", "0.804 0.157 0.157 1.000");
  setsaveddvar("cg_hud_outline_colors_3", "0.431 0.745 0.235 1.000");
  setsaveddvar("cg_hud_outline_colors_4", "0.157 0.784 0.784 1.000");
  setsaveddvar("cg_hud_outline_colors_5", "0.784 0.490 0.157 1.000");
  setsaveddvar("cg_hud_outline_colors_6", "0.804 0.804 0.035 1.000");
  setsaveddvar("cg_hud_outline_colors_7", "0.000 0.000 0.000 0.000");
}

_id_83DB() {
  precacheshader("black");
  precacheshader("white");
  precachemodel("fx");
  precachemodel("tag_origin");
  precachemodel("tag_laser");
  precachemodel("tag_ik_target_left");
  precachemodel("tag_ik_target_right");
  precacheshellshock("default_nosound");
  precacheshellshock("victoryscreen");
  precacheshellshock("flashbang");
  precacheshellshock("deafened");
  precacherumble("damage_heavy");
  precacherumble("damage_light");
  precacherumble("grenade_rumble");
  precacherumble("artillery_rumble");
  precacherumble("slide_start");
  precacherumble("slide_loop");
  precacherumble("leap_end");
  precacheitem("defaultweapon");
  precacheitem("fraggrenade");
}

_id_83DD() {
  level._id_241D = 1;
  scripts\sp\utility::_id_F44E(1);
  level._id_1307 = 1;

  if(!isDefined(level._id_7649)) {
    level._id_7649 = [];
  }

  thread _id_579A();
}

_id_B3CD() {
  thread scripts\sp\mgturret::_id_263B();
  thread scripts\sp\mgturret::_id_EB7D();
  thread scripts\sp\colors::_id_957E();
}

_id_F7C2() {
  var_0 = "1.0 1.0 1.0";
  var_1 = "0.9 0.9 0.9";
  var_2 = "0.85 0.85 0.85";
  setsaveddvar("con_typewriterColorBase", var_0);
}

_id_579A() {
  level.first_frame = 1;
  wait 0.05;
  level.first_frame = -1;
}

_id_E810() {
  scripts\engine\utility::flag_set("load_finished");

  if(isDefined(level._id_D6D8)) {
    foreach(var_1 in level._id_D6D8)[[var_1]]();
  }
}

_id_51C4() {
  scripts\sp\utility::_id_228A(getEntArray("delete_on_load", "targetname"));
  scripts\engine\utility::delaythread(0.05, scripts\sp\utility::_id_228A, getEntArray("delete_on_firstframeend", "targetname"));

  if(!scripts\sp\utility::_id_93A6()) {
    scripts\sp\utility::_id_51D5("helmet_pickup", "script_noteworthy");
    scripts\sp\utility::_id_51D5("nanoshot_pickup", "script_noteworthy");
    var_0 = getEntArray("specialist_mode_only", "targetname");

    if(isDefined(var_0) && isarray(var_0) && var_0.size > 0) {
      scripts\sp\utility::_id_228A(var_0);
    }
  }
}