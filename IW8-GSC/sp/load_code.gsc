/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\load_code.gsc
***********************************************/

init_level() {
  scripts\sp\starts::init_starts();
  level.script = tolower(getDvar("mapname"));
  level.framedurationseconds = level.frameduration / 1000;
}

init_global_dvars() {
  setsaveddvar("NRTOOSORMS", "0");
  setsaveddvar("NSSLSNKPN", "1");
  setsaveddvar("PPKQNKNMN", !scripts\sp\utility::is_trials_level());
  setsaveddvar("MROOOROPKL", 4);
  setsaveddvar("LTQMSPKRKO", 4);
  setsaveddvar("cg_hud_outline_colors_0", "0.000 0.000 0.000 0.000");
  setsaveddvar("cg_hud_outline_colors_1", "0.882 0.882 0.882 1.000");
  setsaveddvar("cg_hud_outline_colors_2", "0.804 0.157 0.157 1.000");
  setsaveddvar("cg_hud_outline_colors_3", "0.431 0.745 0.235 1.000");
  setsaveddvar("cg_hud_outline_colors_4", "0.157 0.784 0.784 1.000");
  setsaveddvar("cg_hud_outline_colors_5", "0.784 0.490 0.157 1.000");
  setsaveddvar("cg_hud_outline_colors_6", "0.804 0.804 0.035 1.000");
  setsaveddvar("cg_hud_outline_colors_7", "0.000 0.000 0.000 0.000");
  setsaveddvar("NLKQTSPTKQ", 0);
  setdvarifuninitialized("scr_damageFeedbackDisabled", 1);
  setdvarifuninitialized("scr_damageFeedbackAudioDisabled", 0);
  setdvarifuninitialized("scr_no_hitmarker", 1);
  setdvarifuninitialized("player_died_recently", 0);
  setdvarifuninitialized("player_died_recently_count", 0);
}

init_global_omnvars() {
  setomnvar("ui_gettocover_text", "game/get_to_cover");
}

init_global_precache() {
  precacheshader("black");
  precacheshader("white");
  precacheshader("overlay_static");
  precachemodel("fx");
  precachemodel("tag_origin");
  precachemodel("tag_laser");
  precachemodel("tag_ik_target_left");
  precachemodel("tag_ik_target_right");
  precacherumble("damage_heavy");
  precacherumble("damage_light");
  precacherumble("grenade_rumble");
  precacherumble("artillery_rumble");
  precacherumble("slide_start");
  precacherumble("slide_loop");
  precacherumble("leap_end");
  precacheitem("defaultweapon");
  precachesuit("defaultsuit");
}

init_funcs() {
  scripts\engine\utility::create_func_ref("setsaveddvar", ::setsaveddvar);
  scripts\engine\utility::create_func_ref("useanimtree", ::useanimtree);
  scripts\engine\utility::create_func_ref("setanim", ::setanim);
  scripts\engine\utility::create_func_ref("setanimknob", ::setanimknob);
  scripts\engine\utility::create_func_ref("setflaggedanimknob", ::setflaggedanimknob);
  scripts\engine\utility::create_func_ref("setflaggedanimknobrestart", ::setflaggedanimknobrestart);
  scripts\engine\utility::create_func_ref("setanimlimited", ::setanimlimited);
  scripts\engine\utility::create_func_ref("setanimtime", ::setanimtime);
  scripts\engine\utility::create_func_ref("getanimtime", ::getanimtime);
  scripts\engine\utility::create_func_ref("getanimlength", ::getanimlength);
  scripts\engine\utility::create_func_ref("clearanim", ::clearanim);
  scripts\engine\utility::create_func_ref("kill", ::kill);
  scripts\engine\utility::create_func_ref("magicgrenade", ::magicgrenade);
  scripts\engine\utility::create_func_ref("connectPaths", ::connectpaths);
  scripts\engine\utility::create_func_ref("disconnectPaths", ::disconnectpaths);
  scripts\engine\utility::create_func_ref("makeEntitySentient", ::makeentitysentient);
  scripts\engine\utility::create_func_ref("laserForceOn", ::laserforceon);
  scripts\engine\utility::create_func_ref("laserForceOff", ::laserforceoff);
  scripts\engine\utility::create_func_ref("badPlaceDelete", ::badplace_delete);
  scripts\engine\utility::create_func_ref("badPlaceCylinder", ::badplace_cylinder);
  scripts\engine\utility::create_func_ref("freeEntitySentient", ::freeentitysentient);
  scripts\engine\utility::create_func_ref("stat_track_kill_func", ::laserforceoff);
  scripts\engine\utility::create_func_ref("laserForceOff", ::laserforceoff);
  scripts\engine\utility::create_func_ref("getspawner", ::getspawner);
  scripts\engine\utility::create_func_ref("ai_has_color", scripts\engine\sp\utility::has_color);
  scripts\engine\utility::create_func_ref("playsound_on_tag", scripts\engine\sp\utility::play_sound_on_tag);
  scripts\engine\utility::create_func_ref("playloopsound_on_tag", scripts\engine\sp\utility::play_loop_sound_on_tag);
  scripts\engine\utility::create_func_ref("playsound_on_entity", scripts\engine\sp\utility::play_sound_on_entity);
  scripts\engine\utility::create_func_ref("playloopsound_on_entity", scripts\engine\utility::play_loop_sound_on_entity);
  scripts\engine\utility::create_func_ref("display_hint", scripts\engine\sp\utility::display_hint);
  scripts\engine\utility::create_func_ref("add_hint_string", scripts\engine\sp\utility::add_hint_string);
  scripts\engine\utility::create_func_ref("spawn_ai", scripts\engine\sp\utility::spawn_ai);
  scripts\engine\utility::create_func_ref("spawn_failed", scripts\common\ai::spawn_failed);
  scripts\engine\utility::create_func_ref("dronespawn_bodyonly", scripts\engine\sp\utility::dronespawn_bodyonly);
  scripts\engine\utility::create_func_ref("bodyonlyspawn", scripts\engine\sp\utility::bodyonlyspawn);
  scripts\engine\sp\utility::setupglobalcallbackfunctions_sp();
  level.dopickyautosavechecks = 1;
  level.autosave_threat_check_enabled = 1;
  level.getnodefunction = ::getnode;
  level.getnodearrayfunction = ::getnodearray;
  level.addaieventlistener_func = ::addaieventlistener;
  level.getspawnerarrayfunction = ::getspawnerarray;
  level.fnbuildweapon = scripts\sp\utility::make_weapon;
  level.fnbuildweaponspecial = scripts\sp\utility::make_weapon_special;
  level.fnscriptedweaponassignment = scripts\sp\scripted_weapon_assignment::getscriptedweapon;
  scripts\common\utility::allow_init();
  scripts\common\utility::allow_add("cg_drawcrosshair", scripts\sp\utility::allow_cg_drawcrosshair);
  scripts\common\utility::allow_add("weapon_first_raise_anims", scripts\sp\utility::allow_weapon_first_raise_anims);
  scripts\common\utility::allow_add("weapon_scanning", scripts\sp\utility::allow_weapon_scanning);
  scripts\common\utility::allow_add("antigrav_float", scripts\sp\utility::allow_antigrav_float);
  scripts\common\utility::allow_add("hands", scripts\sp\utility::allow_hands);
}

init_global_variables() {
  if(!isDefined(level.missionfailed))
    level.missionfailed = 0;

  if(!isDefined(level.g_effect))
    level.g_effect = [];

  thread do_level_first_frame();
}

init_objective_colors() {
  var_0 = "1.0 1.0 1.0";
  var_1 = "0.9 0.9 0.9";
  var_2 = "0.85 0.85 0.85";
  setsaveddvar("NRQKSNRORT", var_0);
}

do_level_first_frame() {
  level.first_frame = 1;
  wait 0.05;
  level.first_frame = -1;
}

post_load_functions() {
  scripts\engine\utility::flag_set("load_finished");

  if(isDefined(level.post_load_funcs)) {
    foreach(var_1 in level.post_load_funcs)[[var_1]]();
  }
}

load_binks() {
  if(scripts\engine\sp\utility::is_default_start()) {
    var_0 = scripts\sp\endmission::getlevelindex(level.script);

    if(isDefined(var_0)) {
      if(var_0 != 0)
        setomnvar("ui_transition_movie", scripts\sp\endmission::getlevelbink(var_0));
    }
  }
}

delete_on_load() {
  scripts\engine\utility::array_delete(getEntArray("delete_on_load", "targetname"));
  scripts\engine\utility::delaythread(0.05, scripts\engine\utility::array_delete, getEntArray("delete_on_firstframeend", "targetname"));
}