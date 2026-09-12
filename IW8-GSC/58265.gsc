/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58265.gsc
***********************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("greenbay_strike", &ref_13e2a, &ongreenbaystrikekillstreakavailable);
  scripts\common\ui::lui_registercallback("ui_mv_on_new_killstreak_selected", &ref_1266a);
  super_enemy_spawning();
  super_has_targets();
  scripts\common\utility::allow_register_set("greenbay_strike_restrictions", ["usability", "weapon_switch", "weapon_pickup", "sprint", "mantle", "fire", "ads", "melee", "execution_attack", "execution_victim", "vehicle_use", "crate_use", "ascender_use"]);
}

function super_enemy_spawning() {
  level.sentry_shouldshoot = spawnStruct();
  level.sentry_shouldshoot.inuse = 0;
  level.sentry_shouldshoot.stab_blink_black_fade = 0;
  level.sentry_shouldshoot.triggers = [];
  level.sentry_shouldshoot.ref_13dc5 = 0;
  level.sentry_shouldshoot.playersintrigger = [];
  level.sentry_shouldshoot.strikeradius = getdvarint("scr_br_mxp_g_width", 2000);
  level.sentry_shouldshoot.limitzdelta = getdvarint("scr_br_mxp_g_limit_z_delta", 1);
  level.sentry_shouldshoot.maxzdelta = getdvarfloat("scr_br_mxp_g_max_z_delta", 100);
  level.sentry_shouldshoot.mindistray = getdvarfloat("scr_br_mxp_g_min_dist_attack", 2500);
  level.sentry_shouldshoot.mindistattack = level.sentry_shouldshoot.mindistray + getdvarint("scr_br_mxp_g_length", 8000) / 2;
  level.vehicle_shoulddocollisiondamagetoplayer = spawnStruct();
  level.vehicle_shoulddocollisiondamagetoplayer.inuse = 0;
  level.vehicle_shoulddocollisiondamagetoplayer.strikeradius = getdvarint("scr_br_mxp_k_radius", 4000);
  level.vehicle_shoulddocollisiondamagetoplayer.midrange = getdvarint("scr_br_mxp_k_mid_range", 10000);
  level.vehicle_shoulddocollisiondamagetoplayer.longrange = getdvarint("scr_br_mxp_k_long_range", 30000);
  level.vehicle_shoulddocollisiondamagetoplayer.longerrange = getdvarint("scr_br_mxp_k_longer_range", 50000);
  level.vehicle_shoulddocollisiondamagetoplayer.rock_gravity_mid_range = getdvarint("scr_br_mxp_k_rock_gravity_mid_range", 12000);
  level.vehicle_shoulddocollisiondamagetoplayer.rock_gravity_long_range = getdvarint("scr_br_mxp_k_rock_gravity_long_range", 9000);
  level.vehicle_shoulddocollisiondamagetoplayer.rock_gravity_longer_range = getdvarint("scr_br_mxp_k_rock_gravity_longer_range", 5000);
  level.vehicle_shoulddocollisiondamagetoplayer.rock_gravity_longest_range = getdvarint("scr_br_mxp_k_rock_gravity_longest_range", 2500);
  level.vehicle_shoulddocollisiondamagetoplayer.rock_speed_mid_range = getdvarint("scr_br_mxp_k_rock_speed_mid_range", 6000);
  level.vehicle_shoulddocollisiondamagetoplayer.rock_speed_long_range = getdvarint("scr_br_mxp_k_rock_speed_long_range", 6000);
  level.vehicle_shoulddocollisiondamagetoplayer.rock_speed_longer_range = getdvarint("scr_br_mxp_k_rock_speed_longer_range", 7000);
  level.vehicle_shoulddocollisiondamagetoplayer.rock_speed_longest_range = getdvarint("scr_br_mxp_k_rock_speed_longest_range", 9000);
}

function super_has_targets() {
  level._effect["greenbay_impact"] = loadfx("vfx/iw8_br/island/gameplay/mendota/vfx_br3_gbay_heatray_impact");
  level._effect["greenbay_impact_linger"] = loadfx("vfx/iw8_br/island/gameplay/mendota/vfx_br3_gbay_heatray_impact_linger");
  level._effect["greenbay_impact_player"] = loadfx("vfx/iw8_br/island/gameplay/mendota/vfx_br3_gbay_heatray_impact_player");
}

function ref_13e2a(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  var_1 = getcompleteweaponname("ks_remote_oshkosh_mp");
  var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, var_1, 1, &ref_14587, undefined, &playerswitchweaponback);

  if(!istrue(var_2)) {
    return false;
  }

  var_3 = undefined;

  if(!isDefined(var_0.ref_13a81)) {
    if(getdvarint("scr_br_mxp_greenbaystrike_movement_disable", 1)) {
      scripts\common\utility::allow_movement(0);
    }

    var_3 = ref_14582(var_0, var_1, undefined);

    if(getdvarint("scr_br_mxp_greenbaystrike_movement_disable", 1)) {
      scripts\common\utility::allow_movement(1);
    }

    if(!isDefined(var_3) || !istrue(var_3.success)) {
      var_0 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return false;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0.streakname, self.origin);
  }

  thread ref_1384d(var_3, var_0);

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var_0);
  }

  return true;
}

function ongreenbaystrikekillstreakavailable(var_0) {
  if(scripts\engine\utility::cointoss()) {
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("scream_device_acquired", self);
    return;
  }

  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("scream_device_acquired_desc", self);
}

function playerswitchweaponback(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("death");

  if(istrue(var_0.failed) || !isDefined(var_0.ref_13923)) {
    scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2);
  } else {
    var_3 = "ks_remote_oshkosh_greenbay_mp";

    if(var_0.ref_13923 == 1) {
      var_3 = "ks_remote_oshkosh_kenosha_mp";
    }

    var_4 = getcompleteweaponname(var_3);
    self giveweapon(var_4, 0, 0, -1, 1);
    self switchtoweaponimmediate(var_4);
    scripts\common\utility::allow_set("greenbay_strike_restrictions", 0, "greenbay_toggle_anim");
    var_5 = 4.3;
    wait var_5;
    scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2);
    scripts\common\utility::allow_set("greenbay_strike_restrictions", 1, "greenbay_toggle_anim");
    scripts\cp_mp\utility\inventory_utility::getridofweapon(var_4, 1);
  }

  var_6 = self getcurrentweapon();

  if(var_6.basename == "none") {
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    return;
  }
}

function serverroomdogtagrevive(var_0, var_1, var_2) {
  strikeatlocation(var_0, var_1, var_2, 2);
}

function greenbaystrikeatpoint(var_0, var_1, var_2) {
  strikeatlocation(var_0, var_1, var_2, 3);
}

function vehicle_spawn_cp_gamemodesupportsabandonedtimeout(var_0, var_1, var_2) {
  strikeatlocation(var_0, var_1, var_2, 1);
}

function strikeatlocation(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4.angles = var_1;
  var_4.pers = [];
  var_4.team = "neutral";
  var_4.defaultoperatorteam = "neutral";
  var_4.classname = "worldspawn";
  var_5 = var_4 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("greenbay_strike", var_4);
  var_5.owner = var_4;
  var_5.ref_13923 = var_3;
  var_5.radius = var_2;
  var_6 = spawnStruct();
  var_6.location = var_0;
  var_6.angles = var_1;
  var_6.string = "confirm_location";
  thread ref_1384d(var_4, var_6);
}

function ref_14587(var_0) {
  if(scripts\mp\gametypes\br_publicevent_fresno::isfresnoactive()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("BR_MENDOTA/FRENZY_UNAVAILABLE");
    }

    var_0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  if(sequence_interaction_activate() && vehicle_showvalidlittlebirds()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("BR_MENDOTA/TOMAH_UNAVAILABLE");
    }

    var_0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  server_triggered(var_0);
  return true;
}

function ref_14582(var_0, var_1, var_2) {
  var_3 = 2.1;
  var_4 = scripts\engine\utility::waittill_any_ents_or_timeout_return(var_3, level, "fresno_start");

  if(!isDefined(var_4)) {
    var_0.failed = 1;
    return undefined;
  } else if(var_4 == "fresno_start") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("BR_MENDOTA/FRENZY_UNAVAILABLE");
    }

    var_0.failed = 1;
    return undefined;
  }

  var_5 = seq3_warning_room_c(var_0);
  var_6 = 1;

  if(isDefined(var_0.ref_13923)) {
    var_6 = var_0.ref_13923;
  } else if(isDefined(self.ref_1300b) && self.ref_1300b != 0) {
    var_6 = self.ref_1300b;
  }

  var_0.ref_13923 = var_6;

  if(var_0.ref_13923 == 2 && sequence_interaction_activate()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("BR_MENDOTA/GREENBAY_UNAVAILABLE");
    }

    var_0 notify("killstreak_finished_with_deploy_weapon");
    var_0.failed = 1;
    return undefined;
  } else if(var_0.ref_13923 == 1 && vehicle_showvalidlittlebirds()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("BR_MENDOTA/KENOSHA_UNAVAILABLE");
    }

    var_0 notify("killstreak_finished_with_deploy_weapon");
    var_0.failed = 1;
    return undefined;
  }

  if(!isDefined(var_5) || !istrue(var_5.success)) {
    if(isDefined(var_5) && !istrue(var_5.success) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      if(var_5.string == "oob") {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/INVALID_POINT");
      } else if(var_5.string == "fresno_start") {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("BR_MENDOTA/FRENZY_UNAVAILABLE");
      }
    }

    var_0.failed = 1;
    return undefined;
  }

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
    }

    var_0.failed = 1;
    return undefined;
  }

  var_7 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    var_7 = 2;
  }

  return var_5;
}

function seq3_warning_room_c(var_0, var_1, var_2) {
  scripts\common\utility::allow_weapon_switch(0);
  self setsoundsubmix("mp_killstreak_overlay");
  var_3 = ref_125c2();

  if(!isDefined(var_3) || !istrue(var_3.success)) {
    scripts\common\utility::allow_weapon_switch(1);
    self clearsoundsubmix("mp_killstreak_overlay");
    return var_3;
  }

  scripts\common\utility::allow_weapon_switch(1);
  self clearsoundsubmix("mp_killstreak_overlay");
  return var_3;
}

function playerwaittillmapselectcomplete() {
  level endon("fresno_start");
  var_0 = scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel("confirm_location", "cancel_location", "last_stand_start");
  return var_0;
}

function ref_125c2() {
  self setclientomnvar("ui_br_show_tac_map", 1);
  self beginlocationselection(0, 0, 0, 0, 4);
  thread playerlocselectendgamecleanup();
  var_0 = playerwaittillmapselectcomplete();
  self notify("greenbay_strike_selection_done");

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.string = "fresno_start";
  }

  var_0.success = 0;
  self endlocationselection();

  if(isDefined(var_0) && var_0.string == "confirm_location") {
    if(scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_0.location, 1)) {
      var_1 = scripts\mp\gametypes\br::ref_13c34(var_0.location);
      var_2 = var_1["position"];

      if(scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_2, 1)) {
        var_0.success = 1;
      } else {
        var_0.string = "oob";
      }
    } else {
      var_0.string = "oob";
    }
  }

  self setclientomnvar("ui_br_show_tac_map", 0);
  return var_0;
}

function playerlocselectendgamecleanup() {
  var_0 = self;
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("greenbay_strike_selection_done");
  level waittill("game_ended");
  var_0 endlocationselection();
  var_0 setclientomnvar("ui_br_show_tac_map", 0);
}

function server_triggered(var_0) {
  scripts\mp\killstreaks\mapselect::startmapselectsequence(0, 0, 0);
}

function ref_1384d(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_2 = 1;

  if(isDefined(var_1.ref_13923)) {
    var_2 = var_1.ref_13923;
  }

  var_1.player = self;
  var_1.starttime = gettime();

  if(var_2 == 2) {
    thread seq3_tvnums_str(var_0, var_1);
  } else if(var_2 == 3) {
    thread greenbaystrike_attackray(var_0, var_1);
  } else {
    thread vehicle_showteamtanks(var_0, var_1);
  }

  if(isPlayer(self)) {
    self.laststriketype = var_2;
  }

  var_1 notify("killstreak_finished_with_deploy_weapon");
  scripts\cp\vehicles\vehicle_compass_cp::ref_12004("mv_event_intel_2");
  thread server_unlocked(var_1);
}

function seq3_tvnums_str(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("drone_target_placed");
  greenbaystrike_cleanupinterruptedstreak();

  if(isPlayer(self)) {
    sequence_progression(1);
  }

  var_1.ref_134e3 = scripts\mp\gametypes\br_alt_mode_mxp::sandbox_combat_area();
  greenbaystrike_setuptarget(var_0, var_1);
  var_2 = var_0.location;
  greenbaystrike_createmarker(var_2);
  greenbaystrike_preparestreakinfo(var_1, var_0);
  greenbaystrike_debugprint(var_1);
  var_3 = var_2 - var_1.ref_134e3;
  var_3 = vectorNormalize((var_3[0], var_3[1], 0));
  var_4 = -1 * var_3;
  var_5 = getdvarint("scr_br_mxp_g_length", 8000);
  var_1.startorigin = var_2 + var_4 * var_5 / 2;
  var_1.endorigin = var_2 + var_3 * var_5 / 2;
  var_1.dir = vectorNormalize(var_1.endorigin - var_1.startorigin);
  var_6 = scripts\mp\gametypes\br_public::semtex_used();
  var_1.startgroundorigin = skytracetoworld(var_1.startorigin, var_6);
  var_1.previewcircle = makepreviewimpactcircle(var_1.startorigin, var_1.origin, var_1.endorigin, var_3, var_1.change_keypad_display_digit, var_5);
  var_1.start_area_fx_end = seq3_warning_room_a(var_1.startorigin);

  if(isPlayer(self)) {
    var_1.start_area_fx_end setscriptabledamageowner(self);
    thread scripts\mp\hud_message::showsplash("br_gametype_mendota_greenbay_streak");
  }

  scripts\mp\gametypes\br_alt_mode_mxp::set_number_of_subway_cars_on_track(var_1);
}

function greenbaystrike_attackray(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("drone_target_placed");
  greenbaystrike_cleanupinterruptedstreak();
  var_1.ref_134e3 = scripts\mp\gametypes\br_alt_mode_mxp::sandbox_combat_area();
  greenbaystrike_attackray_getend(var_0, var_1);
  var_2 = greenbaystrike_setuptarget(var_0, var_1);

  if(var_2) {
    greenbaystrike_attackray_getend(var_0, var_1);
  }

  var_3 = var_0.location;
  greenbaystrike_createmarker(var_3);
  greenbaystrike_preparestreakinfo(var_1, var_0);
  greenbaystrike_debugprint(var_1);
  var_1.start_area_fx_end = seq3_warning_room_a(var_1.startorigin);
  scripts\mp\gametypes\br_alt_mode_mxp::set_number_of_subway_cars_on_track(var_1);
}

function greenbaystrike_attackray_getend(var_0, var_1) {
  var_2 = vectorNormalize(var_0.location - var_1.ref_134e3);
  var_3 = getdvarint("scr_br_mxp_g_length_ray", 200000);
  var_4 = var_1.ref_134e3;
  var_5 = var_1.ref_134e3 + var_2 * var_3;
  var_6 = scripts\engine\trace::ray_trace(var_4, var_5, undefined, scripts\engine\trace::create_world_contents());
  greenbaystrike_updateinforay(var_0, var_1, var_6, var_2);
}

function greenbaystrike_updateinforay(var_0, var_1, var_2, var_3) {
  var_4 = var_2["position"];
  var_0.location = var_4;
  var_1.startorigin = var_4;
  var_1.endorigin = var_4;
  var_1.dir = var_3;

  if(var_2["hittype"] != "hittype_none") {
    var_1.startgroundorigin = var_4;
    var_1.startgroundnormal = var_2["normal"];
    return;
  }

  var_1.startgroundorigin = undefined;
  var_1.startgroundnormal = undefined;
}

function greenbaystrike_cleanupinterruptedstreak() {
  if(!isDefined(level.ref_11e18.setincomingremovedcallback.vo_one_remain)) {
    return;
  }

  var_0 = level.ref_11e18.setincomingremovedcallback.vo_one_remain;
  level.ref_11e18.setincomingremovedcallback.vo_one_remain = undefined;
  greenbaystrike_cleanuppreviewentities(var_0);
}

function greenbaystrike_setuptarget(var_0, var_1) {
  var_2 = var_0.location;
  var_3 = level.ref_11e18.setincomingremovedcallback.origin;

  if(scripts\mp\gametypes\br_alt_mode_mxp::ginwalkingstate()) {
    var_4 = scripts\mp\gametypes\br_alt_mode_mxp::ggetnextindexorigin();
    var_5 = var_4[0];
    var_3 = var_4[1];
    var_4 = undefined;
  }

  var_6 = distance2d(var_2, var_3);
  var_7 = level.sentry_shouldshoot.mindistattack;

  if(var_1.ref_13923 == 3) {
    var_7 = level.sentry_shouldshoot.mindistray;
  }

  if(var_6 <= var_7) {
    var_8 = scripts\mp\gametypes\br_alt_mode_mxp::sandbox_combat_area(var_3);
    var_9 = var_2 - var_8;
    var_9 = vectorNormalize((var_9[0], var_9[1], 0));
    var_10 = var_8 + var_9 * var_7;
    var_1.ref_134e3 = var_8;
    var_0.location = (var_10[0], var_10[1], var_2[2]);

    if(var_1.ref_13923 == 3 && isDefined(var_1.startgroundnormal)) {
      var_11 = scripts\mp\gametypes\br_public::semtex_used();
      var_0.location = skytracetoworld(var_0.location, var_11);
    }

    return true;
  }

  return false;
}

function greenbaystrike_createmarker(var_0) {
  if(getdvarint("scr_br_mxp_ks_marker", 0) != 1) {
    return;
  }

  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID")) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);
  }

  if(!isDefined(var_1)) {
    return;
  }

  server_activate(var_1, "ui_mp_br_hud_icon_greenbay", self, var_0 + (0, 0, 50));
  thread greenbaystrike_handlemarker(level);
}

function greenbaystrike_preparestreakinfo(var_0, var_1) {
  var_0.shots_fired++;
  var_0.origin = var_1.location;

  if(isDefined(var_0.radius)) {
    var_0.change_keypad_display_digit = var_0.radius;
    return;
  }

  var_0.change_keypad_display_digit = level.sentry_shouldshoot.strikeradius;
}

function greenbaystrike_debugprint(var_0) {
  var_1 = "greenbay attack: " + var_0.ref_134e3[0] + " " + var_0.ref_134e3[1] + " " + var_0.ref_134e3[2] + " " + var_0.origin[0] + " " + var_0.origin[1] + " " + var_0.origin[2];
  logprint(var_1);
}

function seq3_warning_room_a(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("ks_greenbay_impact");
  var_1 unmarkkeyframedmover(1);
  return var_1;
}

function server_structs(var_0) {
  level endon("game_ended");
  sequence_progression(0);
  scripts\mp\gametypes\br_alt_mode_mxp::gendkillstreak();
  var_0.circleent = ref_11a9f(var_0.startorigin, var_0.change_keypad_display_digit, 0, 2);
  var_1 = greenbaystrike_getattacktime(var_0);
  var_0.start_area_fx_end setscriptablepartstate("root", "enabled");
  var_0.start_area_fx_end setscriptablepartstate("rumble", "on");
  var_0.circleent moveTo((var_0.endorigin[0], var_0.endorigin[1], var_0.change_keypad_display_digit), var_1, 0.1, 0.1);
  var_2 = var_0.owner;

  if(!isPlayer(var_2)) {
    var_2 = level.ref_11e18.setincomingremovedcallback;
  } else {
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("g_attack_used", var_2);
  }

  var_3 = greenbaystrike_continueattack(var_0, var_1, var_2);
  var_0.start_area_fx_end setscriptablepartstate("damage", "stop");
  var_0.start_area_fx_end setscriptablepartstate("root", "disabled");
  greenbaystrike_cleanuppreviewentities(var_0, 1);
  thread kiosk_spent_total(var_0.circleent, 1);

  if(isDefined(var_2) && isPlayer(var_2)) {
    var_2 notify("greenbay_strike_finished");
    var_2 scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var_0);
  }

  return var_3;
}

function greenbaystrike_getdamagestate(var_0) {
  if(var_0.change_keypad_display_digit == level.sentry_shouldshoot.strikeradius) {
    return "start_large";
  }

  return "start_small";
}

function greenbaystrike_continueattack(var_0, var_1, var_2) {
  level.ref_11e18.setincomingremovedcallback endon("gk_driven_off");
  var_3 = greenbaystrike_getdamagestate(var_0);
  var_4 = 256;
  var_5 = 128;
  var_6 = 30;

  if(isDefined(var_0.ref_13923) && var_0.ref_13923 == 3) {
    thread greenbayburn_spawnrayburn(var_0, var_4, var_0.startgroundorigin, var_0.startgroundnormal, var_5, var_2);
  }

  var_7 = gettime() + var_1 * 1000;

  while(gettime() < var_7) {
    var_8 = getnextgreenbayaimdamagepos(var_0);
    var_9 = var_8[0];
    var_10 = var_8[1];
    var_8 = undefined;
    scripts\mp\gametypes\br_alt_mode_mxp::set_maze_ai_state(var_10);
    var_0.start_area_fx_end.origin = var_10;
    var_11 = getgroundnormal(var_10);

    if(isDefined(var_11)) {
      var_12 = vectorcross(var_11, (1, 0, 0));
      var_13 = vectortoangles(var_12);
      var_0.start_area_fx_end.angles = var_13;
    }

    var_0.start_area_fx_end setscriptablepartstate("damage", var_3);
    seq3_sequence(var_0, var_4, var_10, var_0.start_area_fx_end.angles, var_5, 0, var_2, var_6);
    greenbaystrike_trylaserdamage(var_0, var_10, var_2);
    waitframe();

    if(isDefined(var_0.startgroundorigin)) {
      var_0.previousgroundorigin = var_9;
    }
  }

  return true;
}

function greenbaystrike_trylaserdamage(var_0, var_1) {
  if(!isDefined(self.nextlaserdamage)) {
    self.nextlaserdamage = gettime();
  }

  if(self.nextlaserdamage <= gettime()) {
    greenbaystrike_laserdamage(var_0, var_1);
    self.nextlaserdamage = gettime() + getdvarfloat("scr_br_mxp_g_laserDamageFreq", 0.125) * 1000;
    return;
  }
}

function greenbaystrike_laserdamage(var_0, var_1) {
  var_2 = self.change_keypad_display_digit;
  var_3 = 1000;
  isaltbunkerscriptable(var_0, var_2, var_3, var_1, "MOD_EXPLOSIVE", getcompleteweaponname("greenbay_strike"), level.ref_11e18.setincomingremovedcallback.clear_look_at_ent.origin, 1);
}

function greenbaystrike_getattacktime(var_0) {
  if(var_0.ref_13923 == 3) {
    return getdvarfloat("scr_br_mxp_g_time_ray", 6);
  }

  return getdvarfloat("scr_br_mxp_g_time", 6);
}

function greenbaystrike_cleanuppreviewentities(var_0, var_1) {
  if(isDefined(var_0.previewcircle)) {
    var_0.previewcircle delete();
  }

  thread kiosk_spent_total(var_0.start_area_fx_end, var_1);
}

function getnextgreenbayaimdamagepos(var_0) {
  var_1 = distance2d(var_0.startorigin, var_0.circleent.origin);
  var_2 = var_0.startorigin + var_0.dir * var_1;

  if(var_0.ref_13923 == 2) {
    if(isDefined(var_0.previousgroundorigin)) {
      var_2 += (0, 0, var_0.previousgroundorigin[2]);
    } else if(isDefined(var_0.startgroundorigin)) {
      var_2 += (0, 0, var_0.startgroundorigin[2]);
    }
  }

  var_3 = var_2;
  var_4 = var_2;

  if(var_0.ref_13923 == 2) {
    var_3 = skytracetoworld(var_2, getdvarint("scr_br_mxp_g_beam_z_trace", 2500));
    var_4 = snapaimpostonavmesh(var_3);

    if(istrue(level.sentry_shouldshoot.limitzdelta)) {
      var_4 = limitzdelta(var_4, var_0.previousgroundorigin, level.sentry_shouldshoot.maxzdelta);
    }

    var_4 = smoothaimposz(var_0, var_4);
  }

  if(!isDefined(var_0.aimpath)) {
    var_0.aimpath = [];
    var_0.damagepath = [];
  }

  var_0.aimpath[var_0.aimpath.size] = var_4;
  var_0.damagepath[var_0.damagepath.size] = var_3;
  return [var_3, var_4];
}

function getgroundnormal(var_0) {
  var_1 = scripts\engine\trace::create_contents(0, 1);
  var_2 = scripts\mp\gametypes\br_public::modifytriggerlocation(var_0, 100, -200, var_1);
  return var_2["normal"];
}

function skytracetoworld(var_0, var_1) {
  var_2 = scripts\engine\trace::create_contents(0, 1);
  var_3 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_0, var_1, undefined, var_2);
  return var_3;
}

function snapaimpostonavmesh(var_0) {
  if(isscriptabledefined()) {
    var_1 = getclosestpointonnavmesh(var_0);
    var_2 = distance2d(var_0, var_1);

    if(var_2 < getdvarint("scr_br_mxp_g_beam_xy_nav_offset", 500)) {
      var_3 = var_1[2] - var_0[2];

      if(var_3 < getdvarint("scr_br_mxp_g_beam_z_nav_offset", 1000)) {
        var_0 = (var_0[0], var_0[1], var_1[2]);
      }
    }
  }

  return var_0;
}

function limitzdelta(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = var_0[2] - var_1[2];

  if(abs(var_3) > var_2) {
    if(!isDefined(level.ref_11e18.largestzdelta) || level.ref_11e18.largestzdelta < abs(var_3)) {
      level.ref_11e18.largestzdelta = var_3;
    }

    var_4 = scripts\engine\utility::sign(var_3);
    return (var_1 + (0, 0, var_4 * var_2));
  }

  return var_1;
}

function smoothaimposz(var_0, var_1) {
  var_2 = 0.5;

  if(isDefined(var_0.aimpath)) {
    var_3 = var_0.aimpath[var_0.aimpath.size - 1];
    var_4 = var_1[2] - var_3[2];
    var_5 = var_4 * getdvarfloat("scr_br_mxp_g_beam_z_smooth", var_2);
    var_1 = (var_1[0], var_1[1], var_3[2] + var_5);
  }

  return var_1;
}

function kiosk_spent_total(var_0, var_1) {
  if(isDefined(var_1) && var_1 > 0) {
    wait var_1;
  }

  var_0 delete();
}

function isaltbunkerscriptable(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!istrue(var_7)) {
    radiusdamage(var_0, var_1, var_2, var_2, var_3, var_4, var_5, 0, 1, 1);
  }

  if(getdvarint("scr_br_mxp_damage_vehicles", 1)) {
    var_8 = tablesort(var_0 + (0, 0, -100), var_1, 400);

    foreach(var_10 in var_8) {
      if(isalive(var_10) && var_10.health > 1) {
        var_10 dodamage(var_10.health, var_6, var_3, var_3, var_4, var_5);
      }
    }
  }

  var_12 = float(var_1 * var_1);

  if(isDefined(level.cratedata) && isDefined(level.cratedata.crates)) {
    foreach(var_14 in level.cratedata.crates) {
      if(isDefined(var_14)) {
        var_15 = distance2dsquared(var_14.origin, var_0);

        if(var_15 < var_12) {
          if(isDefined(var_14.trial_flares)) {
            var_14 thread scripts\mp\gametypes\br_gametype_mendota::train_get_anim_ents_index();
          } else {
            thread destroycrate();
          }
        }
      }
    }
  }

  if(istrue(var_7)) {
    var_17 = scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0);
    var_18 = scripts\engine\trace::ray_trace(var_6, var_0, [var_3], var_17);

    if(isDefined(var_18["entity"])) {
      var_19 = var_18["entity"];

      if(isalive(var_19) && (isPlayer(var_19) || nuke_vault_suicidebombers(var_19))) {
        var_19 dodamage(var_2, var_6, var_3, var_3, var_4, var_5);
        return;
      }

      return;
    }

    return;
  }
}

function destroycrate() {
  if(isDefined(self.molotov_delete_oldest_trigger)) {
    self.molotov_delete_oldest_trigger delete();
  }

  playFX(level.conf_fx["vanish"], self.origin);
  scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}

function seq3_gate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  seq3_cypher_tagorigin(var_1, var_2, var_6);
  seq3_puzzle_attempts(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

function seq3_cypher_tagorigin(var_0, var_1, var_2) {
  var_3 = spawnfx(scripts\engine\utility::getfx("greenbay_impact_linger"), var_0, anglesToForward(var_1), anglestoup(var_1));
  thread seq3_crate_usable(var_3, var_2);
  return var_3;
}

function seq3_crate_usable(var_0, var_1) {
  triggerfx(var_0);
  wait var_1;
  var_0 delete();
}

function seq3_puzzle_attempts(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = seq3_keypad_init(var_0, var_1, var_2, var_3, var_4, var_5);
  thread seq3_reset_switch();
  thread seq3_russian_cypher_str();
  thread seq3_puzzle_complete(var_7);
  return var_7;
}

function seq3_keypad_init(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_5)) {
    var_5 = level.ref_11e18.setincomingremovedcallback;
  }

  var_6 = var_1 - anglestoup(var_2) * var_4;
  var_7 = spawn("trigger_radius", var_6, 0, var_0, var_3);
  var_7.angles = var_2;
  var_7.count = 0;
  var_7.attacker = var_5;
  var_7.inflictor = var_5;
  var_7 hide();
  seq3_numbers_array(var_7);
  return var_7;
}

function seq3_reset_switch() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0) || !isalive(var_0)) {
      continue;
    }

    server_interact_used_think(var_0);
    seq3_has_seen_tiers(var_0, self.attacker, self.inflictor, self.killcament, self);
  }
}

function seq3_russian_cypher_str() {
  self endon("death");

  for(;;) {
    if(self.count > 0) {
      foreach(var_1 in level.sentry_shouldshoot.playersintrigger) {
        if(!isDefined(var_1)) {
          continue;
        }

        if(!isPlayer(var_1) || !isalive(var_1)) {
          continue;
        }

        if(var_1 istouching(self)) {
          continue;
        }

        server_rack_clip(var_1);
        seq3_keyboards(var_1, self);
      }
    }

    waitframe();
  }
}

function seq3_puzzle_complete(var_0) {
  seq3_cleanup_leftovers(var_0);

  foreach(var_2 in level.sentry_shouldshoot.playersintrigger) {
    if(isDefined(var_2)) {
      server_rack_clip(var_2);
    }
  }

  thread seq3_monitor_2_spawned();
}

function seq3_has_seen_tiers(var_0, var_1, var_2, var_3) {
  seq3_computersused(var_0, var_1, var_2);
  sentry_trap_structs(var_3);
  thread seq3_sequences();
}

function seq3_keyboards(var_0) {
  seq3_emergency_lights(var_0.id);
}

function seq3_computersused(var_0, var_1, var_2) {
  if(!isDefined(self.seq3_thermitetank_settings)) {
    var_3 = spawnStruct();
    var_3.timeon = 0;
    var_3.timeoff = 0;
    var_3.timetodamage = 0;
    var_3.updatetimestamp = 0;
    var_3.firstdamagedone = 0;
    var_3.victim = self;
    var_3.sources = [];
    self.seq3_thermitetank_settings = var_3;
  }

  self.seq3_thermitetank_settings.attacker = var_0;
  self.seq3_thermitetank_settings.inflictor = var_1;
  self.seq3_thermitetank_settings.killcament = var_2;
}

function seq3_sequences() {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  level endon("game_ended");
  self notify("update_burning");
  self endon("update_burning");
  thread sentryturret_allowpickupofturret();

  if(gettime() <= self.seq3_thermitetank_settings.updatetimestamp) {
    waitframe();
  }

  var_0 = undefined;

  for(;;) {
    foreach(var_2 in self.seq3_thermitetank_settings.sources) {
      if(isDefined(var_2) && seq3_elevator_init(var_2, self)) {
        if(!isDefined(var_0) || var_2.id > var_0.id) {
          var_0 = var_2;
        }

        continue;
      }

      seq3_emergency_lights(var_3);
    }

    var_4 = seq3_spawners_intro(self);

    switch (var_4) {
      case "damage":
        seq3_sequences_correct(self, var_0);
        break;
      case "clear":
        thread seq3_computer_interaction();
        break;
      case "nothing":
      default:
        break;
    }

    wait 0.05;
  }
}

function seq3_spawners_intro(var_0) {
  var_1 = "nothing";

  if(!isDefined(var_0.seq3_thermitetank_settings)) {
    return var_1;
  }

  if(var_0.seq3_thermitetank_settings.timetodamage <= 0) {
    var_1 = "damage";
    var_0.seq3_thermitetank_settings.timetodamage = 0.25;
  } else {
    var_0.seq3_thermitetank_settings.timetodamage -= 0.05;
  }

  if(sequence_interaction_hint(var_0)) {
    var_0.seq3_thermitetank_settings.timeoff = 0;
    var_0.seq3_thermitetank_settings.timeon += 0.05;
  } else {
    var_0.seq3_thermitetank_settings.timeoff += 0.05;

    if(var_0.seq3_thermitetank_settings.timeoff >= 0.25) {
      var_1 = "clear";
    }
  }

  var_0.seq3_thermitetank_settings.updatetimestamp = gettime();
  return var_1;
}

function seq3_sequences_correct(var_0, var_1) {
  if(!isDefined(var_0.seq3_thermitetank_settings) || !isDefined(var_1)) {
    return;
  }

  var_2 = 25;
  var_3 = var_1.attacker.origin;
  var_4 = var_1.attacker;
  var_5 = var_1.attacker;
  var_0 dodamage(var_2, var_3, var_4, var_5, "MOD_EXPLOSIVE", getcompleteweaponname("greenbay_strike"));

  if(!istrue(var_0.seq3_thermitetank_settings.firstdamagedone)) {
    playfxontagforclients(scripts\engine\utility::getfx("greenbay_impact_player"), var_0, "tag_eye", var_0);
  }

  var_0.seq3_thermitetank_settings.firstdamagedone = 1;
}

function seq3_elevator_init(var_0) {
  if(!sequence_interaction_hint(var_0)) {
    return false;
  }

  if(!isDefined(var_0.seq3_thermitetank_settings.sources[self.id])) {
    return false;
  }

  return true;
}

function sentryturret_allowpickupofturret() {
  self notify("cleanup_burning");
  self endon("cleanup_burning");
  GscBinSkip4(0x35);
}

function sentryturret_canpickup() {
  self endon("disconnect");
  self endon("clear_burning");
  level endon("game_ended");
  self waittill("death");
  thread seq3_computer_interaction();
}

function sentryturret_watchgameend() {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  level waittill("game_ended");
  thread seq3_computer_interaction();
}

function seq3_cleanup_leftovers(var_0) {
  self endon("death");
  wait var_0;
}

function seq3_computer_interaction() {
  self notify("clear_burning");

  if(isDefined(self.seq3_thermitetank_settings) && isDefined(self.seq3_thermitetank_settings.sources)) {
    foreach(var_1 in self.seq3_thermitetank_settings.sources) {
      seq3_emergency_lights(var_1.id);
    }
  }

  stopfxontagforclients(scripts\engine\utility::getfx("greenbay_impact_player"), self, "tag_eye", self);
  self.seq3_thermitetank_settings = undefined;
}

function sentry_trap_structs(var_0) {
  if(!isDefined(self.seq3_thermitetank_settings)) {
    return;
  }

  self.seq3_thermitetank_settings.sources[var_0.id] = var_0;
}

function seq3_emergency_lights(var_0) {
  if(!isDefined(self.seq3_thermitetank_settings)) {
    return;
  }

  self.seq3_thermitetank_settings.sources[var_0] = undefined;
}

function seq3_digits_display_array() {
  if(!isDefined(self.seq3_thermitetank_settings)) {
    return 0;
  }

  return self.seq3_thermitetank_settings.sources.size;
}

function seq3_displaymodels(var_0) {
  return seq3_digits_display_array() == 1 && isDefined(self.seq3_thermitetank_settings.sources[var_0.id]);
}

function seq3_numbers_array() {
  self.id = seq3_warning_tier();
  self.stab_blink_black_fade = seq3_warning_room_b();
  seq3_tier(self);
}

function seq3_monitor_2_spawned() {
  sequence_interaction_init(self);
  self delete();
}

function seq3_sequence(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self.ref_13923 != 2) {
    return;
  }

  if(!isDefined(self.nextspawneffect)) {
    self.nextspawneffect = gettime();
  }

  if(!isDefined(self.nextspawntrigger)) {
    self.nextspawntrigger = gettime();
  }

  if(self.nextspawneffect <= gettime()) {
    seq3_cypher_tagorigin(var_1, var_2, var_6);
    self.nextspawneffect = gettime() + getdvarfloat("scr_br_mxp_g_burnSpotFreq_effect", 0.25) * 1000;
  }

  if(self.nextspawntrigger <= gettime()) {
    seq3_puzzle_attempts(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    self.nextspawntrigger = gettime() + getdvarfloat("scr_br_mxp_g_burnSpotFreq_trigger", 0.25) * 1000;
    return;
  }
}

function greenbayburn_spawnrayburn(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1) || !isDefined(var_2) || !isDefined(self.startgroundnormal)) {
    return;
  }

  wait 3;
  var_6 = 256;
  var_7 = 60;
  var_8 = 448;
  var_9 = anglesToForward(var_2) * var_8;
  seq3_gate(var_0, var_1, var_2, var_3, 0, var_4, var_5);

  for(var_10 = 0; var_10 < 6; var_10++) {
    var_11 = rotatepointaroundvector(self.startgroundnormal, var_9, var_7 * var_10);
    var_12 = skytracetoworld(var_1 + var_11, 250);

    if(!isDefined(var_12)) {
      continue;
    }

    var_13 = limitzdelta(var_12, var_1, var_6);

    if(var_13[2] != var_12[2]) {
      continue;
    }

    seq3_gate(var_0, var_12, var_2, var_3, 0, var_4, var_5);
  }
}

function sequence_progression(var_0) {
  level.sentry_shouldshoot.inuse = var_0;
  ref_13186("g", var_0);
}

function sequence_interaction_activate() {
  return level.sentry_shouldshoot.inuse;
}

function seq3_warning_room_b() {
  if(!isDefined(level.sentry_shouldshoot.stab_blink_black_fade)) {
    level.sentry_shouldshoot.stab_blink_black_fade = 0;
  }

  return level.sentry_shouldshoot.stab_blink_black_fade;
}

function seq3_wheelson_starts() {
  if(!isDefined(level.sentry_shouldshoot.stab_blink_black_fade)) {
    level.sentry_shouldshoot.stab_blink_black_fade = 0;
    return;
  }
}

function seq3_warning_tier() {
  var_0 = level.sentry_shouldshoot.ref_13dc5;
  level.sentry_shouldshoot.ref_13dc5++;
  return var_0;
}

function seq3_tier(var_0) {
  level.sentry_shouldshoot.triggers = scripts\engine\utility::array_add(level.sentry_shouldshoot.triggers, var_0);
}

function sequence_interaction_init(var_0) {
  level.sentry_shouldshoot.triggers = scripts\engine\utility::array_remove(level.sentry_shouldshoot.triggers, var_0);
}

function server_interact_used_think(var_0) {
  if(seq3_elevator_init(var_0)) {
    return;
  }

  self.count++;
  var_1 = var_0 getentitynumber();
  level.sentry_shouldshoot.playersintrigger[var_1] = var_0;
}

function server_rack_clip(var_0) {
  if(!seq3_elevator_init(var_0)) {
    return;
  }

  self.count--;

  if(seq3_digits_display_array(var_0) <= 0) {
    var_1 = var_0 getentitynumber();
    level.sentry_shouldshoot.playersintrigger[var_1] = undefined;
    return;
  }
}

function sequence_interaction_hint(var_0) {
  if(!isDefined(var_0.seq3_thermitetank_settings)) {
    return false;
  }

  return var_0.seq3_thermitetank_settings.sources.size > 0;
}

function nuke_vault_suicidebombers() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

function makepreviewimpactcircle(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_4 * 2;
  var_7 = 2 + int(ceil((var_5 - var_6) / var_6));
  var_8 = var_4 + getdvarint("scr_br_mxp_g_extend", 500);
  var_9 = var_5 + var_4 + var_4;
  var_10 = vectortoangles(var_3);
  var_11 = float(var_9) / var_4;

  for(var_12 = 0; var_12 < var_7 - 1; var_12++) {
    var_13 = var_0 + var_3 * var_12 * var_6;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayersInRange")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayersInRange")]](var_13, var_8, "greenbay_strike", 0);
    }

    thread gplaykillstreakincomingdialog(var_13, var_8);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayersInRange")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayersInRange")]](var_2, var_8, "greenbay_strike", 0);
  }

  thread gplaykillstreakincomingdialog(var_2, var_8);
  var_14 = ref_11a9f(var_1, var_4, 1, 6);
  var_14.angles = (var_11, var_10[1], 0);
  return var_14;
}

function ref_11a9f(var_0, var_1, var_2, var_3) {
  var_4 = getmaxobjectivecount(var_0[0], var_0[1], var_1);
  var_4 setmapcirclecolorindex(var_2);
  var_4 setmapcircleiconindex(0);
  var_4 setmapcirclestyleindex(var_3);
  return var_4;
}

function vehicle_showteamtanks(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  kenoshastrike_cleanupinterruptedstreak();

  if(isPlayer(self)) {
    vehicle_spawn_abandonedtimeoutcallback(1);
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("k_attack_used", self);
  }

  var_1.shots_fired++;
  var_2 = var_0.location;
  kenoshastrike_setuptarget(var_0, var_1);

  if(getdvarint("scr_br_mxp_ks_marker", 0) == 1) {
    var_3 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID")) {
      var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);
    }

    if(isDefined(var_3)) {
      server_activate(var_3, "ui_mp_br_hud_icon_kenosha", self, var_1.origin + (0, 0, 50));
      thread greenbaystrike_handlemarker(level);
    }
  }

  var_1.ref_134e3 = scripts\mp\gametypes\br_alt_mode_mxp::vehiclespawn_littlebirdmg();
  var_4 = var_2 - var_1.ref_134e3;
  var_4 = vectorNormalize((var_4[0], var_4[1], 0));
  var_5 = -1 * var_4;
  var_6 = getdvarint("scr_br_mxp_g_extend", 500);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayersInRange")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayersInRange")]](var_1.origin, var_1.change_fronttruck_label + var_6, "kenosha_strike", 0);
  }

  thread kplaykillstreaksentdialog(var_1.origin, var_1.change_fronttruck_label + var_6);
  var_1.startorigin = var_1.ref_134e3;
  var_1.endorigin = var_1.origin;
  var_1.start_area_fx_end = ref_11a9f(var_1.endorigin, var_1.change_fronttruck_label, 1, 5);

  if(isPlayer(self)) {
    thread scripts\mp\hud_message::showsplash("br_gametype_mendota_kenosha_streak");
  }

  scripts\mp\gametypes\br_alt_mode_mxp::waitfor_firstgroup_killedoffenough(var_1);
}

function kenoshastrike_setuptarget(var_0, var_1) {
  var_2 = var_0.location;
  var_1.origin = var_2;
  var_1.change_goal_radius_weapons_free_internal = "long";
  var_1.change_fronttruck_label = level.vehicle_shoulddocollisiondamagetoplayer.strikeradius;

  if(isDefined(var_1.radius)) {
    var_1.change_fronttruck_label = var_1.radius;
  }

  var_3 = level.ref_11e18.wait_for_next_hack_complete.origin;

  if(scripts\mp\gametypes\br_alt_mode_mxp::kinjumpstate()) {
    var_4 = scripts\mp\gametypes\br_alt_mode_mxp::kgetnextindexorigin();
    var_5 = var_4[0];
    var_3 = var_4[1];
    var_4 = undefined;
  } else {
    var_6 = scripts\mp\gametypes\br_alt_mode_mxp::khastomoveforkillstreak();
    var_7 = var_6[0];
    var_8 = var_6[1];
    var_6 = undefined;

    if(var_7) {
      var_3 = scripts\mp\gametypes\br_alt_mode_mxp::kgetindexorigin(var_8);
    }
  }

  var_9 = distance2d(var_2, var_3);

  if(var_9 <= level.vehicle_shoulddocollisiondamagetoplayer.strikeradius) {
    var_1.origin = var_3;
    var_1.change_fronttruck_label = level.vehicle_shoulddocollisiondamagetoplayer.strikeradius;
    var_1.change_goal_radius_weapons_free_internal = 2;
    return;
  }

  if(var_9 <= level.vehicle_shoulddocollisiondamagetoplayer.midrange) {
    var_1.change_goal_radius_weapons_free_internal = 1;
    return;
  }

  var_1.change_goal_radius_weapons_free_internal = 0;
}

function kenoshastrike_cleanupinterruptedstreak() {
  if(!isDefined(level.ref_11e18.wait_for_next_hack_complete.vo_one_remain)) {
    return;
  }

  var_0 = level.ref_11e18.wait_for_next_hack_complete.vo_one_remain;
  level.ref_11e18.wait_for_next_hack_complete.vo_one_remain = undefined;
  kenoshastrike_cleanuppreviewentities(var_0);
}

function vehicle_spawn_cancelpendingrespawns(var_0) {
  level endon("game_ended");
  vehicle_spawn_abandonedtimeoutcallback(0);
  scripts\mp\gametypes\br_alt_mode_mxp::kendkillstreak();
  var_1 = level.ref_11e18.wait_for_next_hack_complete;

  if(var_0.change_goal_radius_weapons_free_internal == 0 || var_0.change_goal_radius_weapons_free_internal == 1) {
    var_1 setscriptablepartstate("rumble", "light", 0);
    var_2 = var_1 gettagorigin("tag_sync");
    var_3 = spawn("script_model", var_2);
    var_3 setModel("lm_rock_boulder_02_kenosha_s3");
    var_0.rock = var_3;
    var_3 linkTo(var_1, "tag_sync", (0, 0, 0), (0, 0, 0));
    var_3 dontinterpolate();
    var_3 unmarkkeyframedmover(1);
    level.ref_11e18.wait_for_next_hack_complete scripts\engine\utility::waittill_notify_or_timeout("kenosha_throw_rock", 2.25);
    var_0.circleent = ref_11a9f(var_0.startorigin, var_0.change_fronttruck_label, 0, 2);
    var_4 = distance2d(var_0.startorigin, var_0.endorigin);
    var_5 = kcalculaterockthrowvalues(var_4);
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_5 = undefined;
    var_8 = var_4 / var_6;
    var_3 unlink();
    var_9 = -1 * var_7;
    var_10 = trajectorycalculateinitialvelocity(var_3.origin, var_0.origin, (0, 0, var_9), var_8);
    var_3 movegravity(var_10, var_8, var_7);
    var_3 setscriptablepartstate("trail", "active", 0);
    var_0.circleent moveTo((var_0.endorigin[0], var_0.endorigin[1], var_0.change_fronttruck_label), var_8, 0.1, 0.1);
    wait var_8;
    var_3 setscriptablepartstate("explode", "active", 0);
    thread vehicle_spawn_abandonedtimeout();
  }

  var_11 = var_0.owner;

  if(!isPlayer(var_11)) {
    var_11 = var_1;
  }

  isaltbunkerscriptable(var_0.origin + (0, 0, 100), var_0.change_fronttruck_label, 1000, var_11, "MOD_EXPLOSIVE", getcompleteweaponname("kenosha_strike"), var_0.ref_134e3);
  isaltbunkerscriptable(var_0.origin + (0, 0, 500), var_0.change_fronttruck_label, 1000, var_11, "MOD_EXPLOSIVE", getcompleteweaponname("kenosha_strike"), var_0.ref_134e3);
  isaltbunkerscriptable(var_0.origin + (0, 0, 1000), var_0.change_fronttruck_label, 1000, var_11, "MOD_EXPLOSIVE", getcompleteweaponname("kenosha_strike"), var_0.ref_134e3);

  if(isDefined(var_11) && isPlayer(var_11)) {
    var_11 notify("greenbay_strike_finished");
    var_11 scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var_0);
  }

  kenoshastrike_cleanuppreviewentities(var_0);

  if(var_0.change_goal_radius_weapons_free_internal == 0 || var_0.change_goal_radius_weapons_free_internal == 1) {
    wait 1;

    if(isDefined(var_0.circleent)) {
      var_0.circleent delete();
    }

    wait 1.5;

    if(isDefined(var_0.rock)) {
      var_0.rock delete();
      return;
    }

    return;
  }
}

function kcalculaterockthrowvalues(var_0) {
  var_1 = level.vehicle_shoulddocollisiondamagetoplayer.rock_speed_mid_range;
  var_2 = level.vehicle_shoulddocollisiondamagetoplayer.rock_gravity_mid_range;

  if(var_0 > level.vehicle_shoulddocollisiondamagetoplayer.longerrange) {
    var_1 = level.vehicle_shoulddocollisiondamagetoplayer.rock_speed_longest_range;
    var_2 = level.vehicle_shoulddocollisiondamagetoplayer.rock_gravity_longest_range;
  } else if(var_0 > level.vehicle_shoulddocollisiondamagetoplayer.longrange) {
    var_1 = level.vehicle_shoulddocollisiondamagetoplayer.rock_speed_longer_range;
    var_2 = level.vehicle_shoulddocollisiondamagetoplayer.rock_gravity_longer_range;
  } else if(var_0 > level.vehicle_shoulddocollisiondamagetoplayer.midrange) {
    var_1 = level.vehicle_shoulddocollisiondamagetoplayer.rock_speed_long_range;
    var_2 = level.vehicle_shoulddocollisiondamagetoplayer.rock_gravity_long_range;
  }

  return [var_1, var_2];
}

function kenoshastrike_cleanuppreviewentities(var_0) {
  var_0.start_area_fx_end delete();
}

function vehicle_spawn_abandonedtimeoutcallback(var_0) {
  level.vehicle_shoulddocollisiondamagetoplayer.inuse = var_0;
  ref_13186("k", var_0);
}

function vehicle_showvalidlittlebirds() {
  return level.vehicle_shoulddocollisiondamagetoplayer.inuse;
}

function vehicle_spawn_abandonedtimeout() {
  self endon("death");
  wait 0.05;
  self setscriptablepartstate("trail", "neutral", 0);
  self hide(1);
}

function server_activate(var_0, var_1, var_2, var_3) {
  objective_icon(var_0, var_1);
  objective_showtoplayersinmask(var_0);

  if(isPlayer(var_2)) {
    objective_addclienttomask(var_0, var_2);
  }

  objective_position(var_0, var_3);
  objective_setplayintro(var_0, 0);
  objective_setplayoutro(var_0, 0);
  objective_setbackground(var_0, 1);

  if(level.teambased || !isPlayer(var_2)) {
    objective_setownerteam(var_0, var_2.team);
  } else {
    objective_setownerclient(var_0, var_2);
  }

  objective_state(var_0, "current");
}

function greenbaystrike_handlemarker(var_0) {
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_0);
    return;
  }
}

function server_unlocked(var_0) {
  self endon("greenbay_strike_finished");
  self endon("disconnect");
  level waittill("game_ended");
  scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var_0);
}

function ref_1266a(var_0) {
  self.ref_1300b = var_0;
}

function gplaykillstreakincomingdialog(var_0, var_1) {
  var_2 = self.team != "neutral";
  var_3 = scripts\common\utility::playersincylinder(var_0, var_1);

  foreach(var_5 in var_3) {
    if(var_2 && var_5.team != self.team) {
      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("g_incoming_attack_player", var_5);
      continue;
    }

    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("g_incoming_attack", var_5);
  }
}

function kplaykillstreaksentdialog(var_0, var_1) {
  var_2 = self.team != "neutral";
  var_3 = scripts\common\utility::playersincylinder(var_0, var_1);

  foreach(var_5 in var_3) {
    if(var_2 && var_5.team != self.team) {
      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("k_incoming_attack_player", var_5);
      continue;
    }

    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("k_incoming_attack", var_5);
  }
}

function ref_13186(var_0, var_1) {
  var_2 = 0;

  if(var_0 == "k") {
    var_2 = 1;
  }

  var_3 = 0;

  if(istrue(var_1)) {
    var_3 = 1;
  }

  var_4 = 1;
  var_5 = var_2;
  var_6 = var_3 << var_5;
  var_7 = ~(1 << var_5);
  var_8 = getomnvar("ui_mendota_killstreaks");
  var_9 = var_8 &var_7;
  var_10 = var_9 + var_6;
  setomnvar("ui_mendota_killstreaks", var_10);
}