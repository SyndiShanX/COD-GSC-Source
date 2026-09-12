/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_ww2.gsc
***********************************************/

#using_animtree("");

function ref_145EE() {
  level.defend_wave_4 = getdvarint("scr_br_enableBombers", 0);
  level.defenderflag_bflagstart = getdvarint("scr_br_enableRandomBombardment", 0);
  level.defenderflag = getdvarint("scr_br_enableFlak", 0);
  level.delete_smoke_fx = getdvarint("scr_br_randomBombardment_bombCount", 3);
  level.delete_subway_car = getdvarint("scr_br_randomBombardment_intervalMin", 45);
  level.delete_structs_on_self_death = getdvarint("scr_br_randomBombardment_intervalMax", 60);
  level.delete_starting_boxes = getdvarint("scr_br_randomBombardment_canStun", 1);
  level.delete_trapfunc = getdvarint("scr_br_randomBombardment_stunTimer", 4);
  level.delete_track = getdvarint("scr_br_randomBombardment_stunRange", 500);
  level.ref_13B46 = getdvarfloat("scr_threat_max_radius_strikes_around_player", 500);

  if(level.defend_wave_4) {
    level.scr_animtree["planeWaves"] = #animtree;
    level.scr_anim["planeWaves"]["bomber_planes"] = $veh_wz_usa_bomber_boscar17_cloud;
    level.scr_animname["planeWaves"]["bomber_planes"] = "veh_wz_usa_bomber_boscar17_cloud";
  }

  thread ref_12800();
}

function ref_12800() {
  if(level.defend_wave_4) {
    level thread scripts\mp\gametypes\br_gametype_lep::dropcircle();

    if(level.defenderflag) {
      level thread scripts\mp\gametypes\br_gametype_lep::drones_spawning();
    }
  }

  if(level.defenderflag_bflagstart) {
    thread update_ai_array();
  }

  if(level.defenderflag_bflagstart && level.defend_wave_4) {
    level thread scripts\mp\utility\sound::besttime("br_ww2_bombardment");
    thread ref_145EF();
    return;
  }
}

function update_ai_array() {
  level endon("game_ended");
  level.ref_123A7 = 1;

  for(;;) {
    jumpiftrue(isDefined(level.infilstruct)) LOC_0000001c;
    return;
  }

  level waittill("br_circle_set", var_0);
  level waittill("br_circle_set", var_0);
  level thread scripts\mp\gametypes\br_gametype_lep::dropbrselfrevivetoken(3, 2363, 45, 60);
  level waittill("br_circle_set", var_0);
  level waittill("br_circle_set", var_0);
  level waittill("br_circle_set", var_0);
  waitframe();
  level waittill("br_circle_set", var_0);
  waitframe();
  level waittill("br_circle_set", var_0);
  level.ref_123A7 = 0;
}

function ref_145EF() {
  level endon("game_ended");
  var_0 = spawn("script_model", (0, 0, 500));
  var_0 setModel("lep_sfx");
  waitframe();
  var_0 setscriptablepartstate("sfx", "attack_state_01");
  level.weapon_xp_iw8_la_rpapa7 = var_0;
  var_0 = spawn("script_model", (0, 0, 500));
  var_0 setModel("lep_sfx");
  waitframe();
  var_0 setscriptablepartstate("sfx", "base");
  level.weapon_xp_iw8_lm_kilo121 = var_0;
}