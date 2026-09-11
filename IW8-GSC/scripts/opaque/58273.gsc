/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58273.gsc
***********************************************/

function stopusingbomb() {
  level._effect["airstrike_tracer"] = loadfx("vfx/iw8_mp/killstreak/vfx_a10_tracer_sep.vfx");
  level._effect["cluster_optimzed"] = loadfx("vfx/iw8_mp/killstreak/vfx_contain_cluster_exp.vfx");
  level._effect["105_optimzed"] = loadfx("vfx/iw8_mp/killstreak/vfx_contain_ac130_105mm_imp.vfx");
  game["dialog"]["ebr_alert_missile_10"] = "ebr_alert_missile_10";
  game["dialog"]["ebr_alert_missile_20"] = "ebr_alert_missile_20";
  game["dialog"]["ebr_alert_missile_30"] = "ebr_alert_missile_30";
  level.create_agent_definition = 0;
  level.create_ai_type_override = (0, 0, 0);
  level.ref_13b46 = getdvarfloat("scr_threat_max_radius_strikes_around_player", 3000);
  level.ref_13b47 = getdvarfloat("scr_threat_min_radius_strikes_around_player", 1500);
  level.ref_13b45 = getdvarint("scr_threat_explosion_per_strikes", 10);
  level.ref_13b48 = getdvarfloat("scr_threat_thickness_radius_strikes_around_player", 400);
  level.ref_13b43 = getdvarfloat("scr_threat_delay_between_strikes", 0.15);
  level.ref_13b44 = getdvarint("scr_threat_explosion_damage", 10);
  var_0 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var_0) {
    case "mp_br_mechanics":
      ref_1322a();
      break;
    case "mp_don3":
    case "mp_don4":
      ref_1322b();
      break;
    default:
      ref_1322b();
      break;
  }
}

function ref_1322b() {
  level.create_exfil_animstruct = [];
  level.create_exfil_animstruct[0] = spawnStruct();
  level.create_exfil_animstruct[0].locname = "Vodianoy";
  level.create_exfil_animstruct[0].refname = "ship_tac";
  level.create_exfil_animstruct[0].ref_119a7 = (39696, -42616, -556);
  level.create_exfil_animstruct[0].ref_119a8 = 4000;
  level.create_exfil_animstruct[1] = spawnStruct();
  level.create_exfil_animstruct[1].locname = "Gulag";
  level.create_exfil_animstruct[1].refname = "gulag_tac";
  level.create_exfil_animstruct[1].ref_119a7 = (51072, -39208, 1351);
  level.create_exfil_animstruct[1].ref_119a8 = 4000;
  level.create_exfil_animstruct[2] = spawnStruct();
  level.create_exfil_animstruct[2].locname = "Hospital";
  level.create_exfil_animstruct[2].refname = "hospital_tac";
  level.create_exfil_animstruct[2].ref_119a7 = (9072, -10984, -280);
  level.create_exfil_animstruct[2].ref_119a8 = 3000;
  level.create_exfil_animstruct[3] = spawnStruct();
  level.create_exfil_animstruct[3].locname = "Stadium";
  level.create_exfil_animstruct[3].refname = "stadium_tac";
  level.create_exfil_animstruct[3].ref_119a7 = (28720, 2272, -816);
  level.create_exfil_animstruct[3].ref_119a8 = 6000;
  level.create_exfil_animstruct[4] = spawnStruct();
  level.create_exfil_animstruct[4].locname = "TV Station";
  level.create_exfil_animstruct[4].refname = "tvstation_tac";
  level.create_exfil_animstruct[4].ref_119a7 = (15024, 18216, 152);
  level.create_exfil_animstruct[4].ref_119a8 = 2000;
  level.create_exfil_animstruct[5] = spawnStruct();
  level.create_exfil_animstruct[5].locname = "Super";
  level.create_exfil_animstruct[5].refname = "super_tac";
  level.create_exfil_animstruct[5].ref_119a7 = (-12792, 7912, -392);
  level.create_exfil_animstruct[5].ref_119a8 = 4000;
  level.create_exfil_animstruct[6] = spawnStruct();
  level.create_exfil_animstruct[6].locname = "Dam";
  level.create_exfil_animstruct[6].refname = "dam_tac";
  level.create_exfil_animstruct[6].ref_119a7 = (-22080, 46160, -364);
  level.create_exfil_animstruct[6].ref_119a8 = 6000;
  level.create_exfil_animstruct[7] = spawnStruct();
  level.create_exfil_animstruct[7].locname = "Bank";
  level.create_exfil_animstruct[7].refname = "bank_tac";
  level.create_exfil_animstruct[7].ref_119a7 = (22688, -19272, 48);
  level.create_exfil_animstruct[7].ref_119a8 = 2000;
}

function ref_1322a() {
  level.create_exfil_animstruct = [];
  level.create_exfil_animstruct[0] = spawnStruct();
  level.create_exfil_animstruct[0].locname = "Zombie Test Ground";
  level.create_exfil_animstruct[0].refname = "ship_tac";
  level.create_exfil_animstruct[0].ref_119a7 = (-3890, -6375, 100);
  level.create_exfil_animstruct[0].ref_119a8 = 1500;
  level.create_exfil_animstruct[1] = spawnStruct();
  level.create_exfil_animstruct[1].locname = "Gulag Mechanics";
  level.create_exfil_animstruct[1].refname = "gulag_tac";
  level.create_exfil_animstruct[1].ref_119a7 = (1800, -6400, 100);
  level.create_exfil_animstruct[1].ref_119a8 = 4000;
  level.create_exfil_animstruct[2] = spawnStruct();
  level.create_exfil_animstruct[2].locname = "Mountan1";
  level.create_exfil_animstruct[2].refname = "hospital_tac";
  level.create_exfil_animstruct[2].ref_119a7 = (-8245, 17400, 1000);
  level.create_exfil_animstruct[2].ref_119a8 = 3000;
  level.create_exfil_animstruct[3] = spawnStruct();
  level.create_exfil_animstruct[3].locname = "Jump Ramp";
  level.create_exfil_animstruct[3].refname = "stadium_tac";
  level.create_exfil_animstruct[3].ref_119a7 = (-2300, 1640, 600);
  level.create_exfil_animstruct[3].ref_119a8 = 2000;
  level.create_exfil_animstruct[4] = spawnStruct();
  level.create_exfil_animstruct[4].locname = "Loot Pile";
  level.create_exfil_animstruct[4].refname = "tvstation_tac";
  level.create_exfil_animstruct[4].ref_119a7 = (2400, 0, 100);
  level.create_exfil_animstruct[4].ref_119a8 = 5000;
  level.create_exfil_animstruct[5] = spawnStruct();
  level.create_exfil_animstruct[5].locname = "Mountan2";
  level.create_exfil_animstruct[5].refname = "super_tac";
  level.create_exfil_animstruct[5].ref_119a7 = (-18200, 9800, 800);
  level.create_exfil_animstruct[5].ref_119a8 = 4000;
  level.create_exfil_animstruct[6] = spawnStruct();
  level.create_exfil_animstruct[6].locname = "End of runway";
  level.create_exfil_animstruct[6].refname = "dam_tac";
  level.create_exfil_animstruct[6].ref_119a7 = (-9300, -11150, 100);
  level.create_exfil_animstruct[6].ref_119a8 = 6000;
  level.create_exfil_animstruct[7] = spawnStruct();
  level.create_exfil_animstruct[7].locname = "Bank";
  level.create_exfil_animstruct[7].refname = "bank_tac";
  level.create_exfil_animstruct[7].ref_119a7 = (-3900, -2000, 480);
  level.create_exfil_animstruct[7].ref_119a8 = 2000;
}

function changing_loadout(var_0) {
  var_1 = 20;
  var_2 = getdvarfloat("scr_bombardment_duration", var_1);
  var_3 = 3000;
  var_4 = getdvarfloat("scr_bombardment_radius", var_3);
  var_5 = (level.br_circle.safecircleent.origin[0], level.br_circle.safecircleent.origin[1], 0);
  var_6 = var_5;
  return changetimertoovertimetimer(level, var_6, var_0, var_2, var_4);
}

function changetimertoovertimetimer(var_0, var_1, var_2, var_3) {
  if(getdvarint("scr_bombardment_killswitch", 0)) {
    return false;
  }

  if(istrue(level.create_agent_definition)) {
    return false;
  }

  thread clear_three_room_screens(level, var_0, var_1, var_2);
  return true;
}

function chase(var_0, var_1, var_2) {
  level endon("game_ended");

  if(istrue(level.create_agent_definition)) {
    level notify("stop_bomb");
    waitframe();
  }

  level.create_apc_vehicle_interaction = var_2;
  thread clear_trap_console_activation(level, var_0);
}

function clear_three_room_screens(var_0, var_1, var_2, var_3) {
  level.create_agent_definition = 1;

  if(!isDefined(level.ref_12d05)) {
    ref_11eca(var_0, var_3, var_1);
  }

  var_4 = getdvarfloat("scr_bombardment_delay_before_start", 8);

  if(getdvarint("scr_bombardment_show_zone_debug", 0)) {
    thread ref_11aa8(level, var_0, var_2 + var_4);
  }

  wait var_4;
  thread create_debug_model_for_spawnpoint(level, var_0, var_1, var_2);
}

function create_debug_model_for_spawnpoint(var_0, var_1, var_2, var_3) {
  var_4 = gettime() + var_2 * 1000;
  var_5 = "free";

  if(isDefined(var_1)) {
    var_5 = var_1.team;
  }

  thread create_execution_devgui(level, var_0, var_4);

  while(gettime() < var_4) {
    var_6 = scripts\mp\utility\player::getplayersinradius(var_0, var_3);
    var_7 = [];
    var_8 = [];

    foreach(var_10 in var_6) {
      if(updatemlgspectatorinfo(var_10) && scripts\mp\utility\player::isreallyalive(var_10) && !scripts\mp\utility\player::unset_relic_trex(var_10)) {
        var_8 = var_10;
        continue;
      }

      var_7 = var_10;
      LOC_000000bb:
    }

    if(var_8.size != 0) {
      foreach(var_10 in var_8) {
        thread ref_13816(level, var_10.origin);
        wait 1;
      }

      continue;
    }

    if(var_7.size != 0) {
      foreach(var_10 in var_7) {
        thread ref_13816(level, var_10.origin);
        wait 1;
      }

      continue;
    }

    var_16 = scripts\mp\gametypes\br_circle::getrandompointincircle(var_0, var_3, 0.2, 0.9, 1, 0);
    thread ref_13816(level, var_16);
    wait 1.5;
  }

  level.create_agent_definition = 0;
}

function create_execution_devgui(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 0;
  var_3 = scripts\engine\utility::getfx("cranked_explode");
  var_3 = scripts\engine\utility::getfx("cluster_optimzed");
  var_3 = scripts\engine\utility::getfx("cluster_optimzed");
  var_3 = scripts\engine\utility::getfx("cluster_optimzed");
  var_3 = scripts\engine\utility::getfx("105_optimzed");
  var_5 = [];
  var_6 = getdvarfloat("scr_debug_bomb_point_dist", 800);
  var_7 = [];
  var_8 = var_2 * 2 / var_6;
  var_9 = var_0 - (var_2, var_2, 0);

  for(var_10 = 0; var_10 < var_8; var_10++) {
    for(var_11 = 0; var_11 < var_8; var_11++) {
      var_12 = (var_9[0] + var_10 * var_6, var_9[1] + var_11 * var_6, var_0[2]);

      if(distance2dsquared(var_0, var_12) < var_2 * var_2) {
        var_5 = scripts\engine\utility::drop_to_ground(var_12);
      }
    }

    waitframe();
  }

  var_5 = scripts\engine\utility::array_randomize(var_5);
  var_13 = getdvarfloat("scr_debug_bombardment_fx_per_interval", 5);
  var_14 = getdvarfloat("scr_debug_bombardment_fx_interval_time", 0.35);

  while(gettime() < var_1) {
    for(var_10 = 0; var_10 < var_13; var_10++) {
      playFX(var_3[var_4 % var_3.size], var_5[var_4 % var_5.size]);
      var_4++;
    }

    wait var_14;
  }
}

function ref_11aa8(var_0, var_1, var_2) {
  var_3 = ref_11a9b(var_0, var_2);
  wait var_1;
  var_3 delete();
}

function ref_11eca(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5 scripts\mp\gametypes\br_public::isplayeringulag() || !var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isDefined(var_2) && var_5.team == var_2.team) {
      var_3 = var_5;
      button(var_5, var_2);
      continue;
    }

    if(length2dsquared(var_5.origin - var_0) < var_1 * var_1) {
      button_sequence(var_5);
      var_3 = var_5;
      continue;
    }

    if(istrue(level.delete_airlock_ents)) {
      buttonmashcount(var_5);
    }
  }

  var_7 = ["ebr_alert_missile_10", "ebr_alert_missile_20", "ebr_alert_missile_30"];
  scripts\mp\gametypes\br_public::brleaderdialog(var_7[randomintrange(0, 3)], 1, var_3);
}

function button(var_0, var_1) {
  var_0 scripts\mp\hud_message::showsplash("br_reveal_bombardment_launch", undefined, var_1);
}

function button_sequence(var_0) {
  var_0 scripts\mp\hud_message::showsplash("br_reveal_bombardment_incoming");
}

function buttonmashcount(var_0) {
  var_0 scripts\mp\hud_message::showsplash("br_reveal_bombardment_launch_enemy");
}

function updatemlgspectatorinfo() {
  var_0 = self;
  var_1 = var_0.origin;
  var_2 = var_1 + (0, 0, 3000);

  if(var_2[2] <= var_1[2]) {
    return 0;
  }

  var_3 = scripts\engine\trace::_bullet_trace_passed(var_1, var_2, 0, var_0);
  return var_3;
}

function ref_11a9b(var_0, var_1) {
  var_2 = getmaxobjectivecount(var_0[0], var_0[1], var_1);
  var_2 setmapcirclecolorindex(12);
  var_2 setmapcircleiconindex(3);
  var_2 setmapcirclestyleindex(1);
  return var_2;
}

function ref_13816(var_0, var_1) {
  if(!isDefined(level.ref_13922)) {
    level.ref_13922 = 0;
  }

  level.ref_13922++;

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    ref_12e22(var_0, undefined);
    return;
  }

  if(level.ref_13922 % 3 == 0) {
    ref_12e22(var_0, var_1);
    return;
  }

  if(level.ref_13922 % 3 == 1) {
    ref_12e25(var_0, var_1);
    return;
  }

  ref_12e24(var_0, var_1);
}

function ref_12e22(var_0, var_1) {
  var_2 = 16;
  var_3 = [(0.33, 0.33, 0), (0.33, 0.66, 0), (0.66, 0.33, 0), (0.66, 0.66, 0), (-0.33, 0.33, 0), (-0.33, 0.66, 0), (-0.66, 0.33, 0), (-0.66, 0.66, 0), (0.33, -0.33, 0), (0.33, -0.66, 0), (0.66, -0.33, 0), (0.66, -0.66, 0), (-0.33, -0.33, 0), (-0.33, -0.66, 0), (-0.66, -0.33, 0), (-0.66, -0.66, 0)];
  var_4 = getdvarfloat("scr_bombardment_strike_radius", 514);
  var_5 = scripts\engine\utility::randomvectorrange(var_4 * -0.25, var_4 * 0.25);

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_3 = var_0 + var_5 + (var_3[var_6][0] * var_4, var_3[var_6][1] * var_4, 5000);
  }

  var_3 = scripts\engine\utility::array_randomize(var_3);
  var_7 = spawn("script_model", var_0);
  var_7 setModel("ks_airstrike_target_mp");

  if(isDefined(var_1)) {
    var_7 setentityowner(var_1);
  }

  var_7.weapon_name = "artillery_mp";
  var_7.angles = (0, 0, 0);
  var_7 dontinterpolate();

  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_8 = var_3[var_6];
    var_9 = var_3[var_6] - (randomfloatrange(-10, 10), randomfloatrange(-10, 10), 30000);
    var_10 = scripts\engine\trace::ray_trace(var_8, var_9, undefined, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
    var_11 = var_10["position"];
    var_12 = var_10["normal"];
    var_13 = var_11 + var_12 * 10;
    var_14 = vectorNormalize(var_11 - var_8);

    if(var_14 == (0, 0, 1)) {
      var_15 = (0, 1, 0);
    } else {
      var_15 = vectorcross(var_14, (0, 0, 1));
    }

    var_16 = vectorcross(var_15, var_14);
    thread callstrike_playmultitracerfx(scripts\engine\utility::getfx("airstrike_tracer"), var_13, var_14, var_16);
    thread moveanddamagepoint(var_7, var_6 + 1);
    wait 0.05;
  }

  wait 2;
  var_7 delete();
}

function ref_12e25(var_0, var_1) {
  var_2 = var_0 + scripts\engine\utility::randomvectorrange(-1000, 1000) + (0, 0, 3000);
  var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("iw8_la_kgolf_mp"), var_2, var_0, var_1);
  wait 4;

  if(isDefined(var_3)) {
    var_3 delete();
    return;
  }
}

function ref_12e24(var_0, var_1) {
  var_2 = var_0 + scripts\engine\utility::randomvectorrange(-1000, 1000) + (0, 0, 5000);
  var_3 = [(300, 300, 0), (-300, 300, 0), (-300, -300, 0), (300, -300, 0)];
  var_4 = getcompleteweaponname("ac130_40mm_mp");

  foreach(var_6 in var_3) {
    thread set_up_chopper_boss(var_1, var_4, var_2);
    wait 0.1;
  }

  wait 0.1;
  thread set_up_chopper_boss(var_1, getcompleteweaponname("ac130_105mm_mp"), var_2);
}

function set_up_chopper_boss(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(var_0, var_1, var_2, self);
  var_3 waittill("missile_stuck", var_4, var_5, var_6, var_7, var_8, var_9);
  var_10 = 0.5;
  var_11 = 100;

  switch (var_0.basename) {
    case "ac130_105mm_mp":
      var_10 = 1.5;
      var_11 = 500;
      break;
    case "ac130_40mm_mp":
      var_10 = 1;
      var_11 = 300;
      break;
  }

  var_12 = spawn("script_model", var_3.origin);
  var_12 setModel("ks_ac130_target_mp");
  var_12.angles = vectortoangles(var_9);
  var_12 linkTo(var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_13 = "on";
  var_12 setscriptablepartstate(var_0.basename, var_13, 0);

  if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_3.origin, var_11, var_11, self.team, var_10, self, 1);
    }

    var_12 setotherent(self);
    var_3 detonate();
  } else {
    var_3 delete();
  }

  var_14 = var_12.origin;
  var_15 = 0.75;

  if(var_0.basename == "ac130_105mm_mp") {
    var_16 = 0.75;
    var_17 = 2000;
  } else {
    var_16 = 0.5;
    var_17 = 1300;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "artillery_earthQuake")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "artillery_earthQuake")]](var_16, var_16, var_17, var_17);
  }

  wait 5;
  var_14 delete();
}

function ref_12e21(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = randomfloat(360);
  var_4 = vectortoangles((cos(var_3), sin(var_3), 0));
  var_0 = scripts\engine\utility::drop_to_ground(var_0);

  if(isDefined(level.ref_13b41)) {
    var_5 = level.ref_13b41;
  } else {
    var_5 = "vfx_br_x2_bomber_exp";
  }

  if(istrue(level.create_apc_vehicle_interaction)) {
    var_6 = spawn("script_model", var_1);
    var_6 setModel(var_5);
    var_6.angles = var_5;
    waitframe();
  } else {
    var_6 = easepower(var_6, var_2, var_5);
  }

  if(!isDefined(var_6)) {
    return;
  }

  var_6 setscriptablepartstate("base", "active", 0);

  if(isDefined(var_4)) {
    radiusdamage(var_2, 300, var_3, var_3, var_4, "MOD_EXPLOSIVE", "artillery_mp");
  }

  thread calculatehelitimetoflysec(var_2);

  if(istrue(level.create_apc_vehicle_interaction)) {
    thread playerpositivereinforcement(var_6, 1);
    return;
  }

  thread playerpowerscleanup(var_6, 1);
}

function calculatehelitimetoflysec(var_0) {
  self endon("death");
  self endon("missile_dest_failed");
  level endon("game_ended");

  if(istrue(level.delete_starting_boxes)) {
    var_1 = scripts\mp\utility\player::getplayersinradius(var_0, level.delete_track);

    foreach(var_3 in var_1) {
      if(!istrue(var_3 scripts\mp\gametypes\br_public::isplayeringulag())) {
        var_3 scripts\mp\weapons::setplayerstunned();
        var_3 thread scripts\mp\weapons::cleanupconcussionstun(level.delete_trapfunc);
        var_3 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
        var_3 scripts\cp_mp\utility\shellshock_utility::_shellshock("concussion_grenade_mp", "bottom", level.delete_trapfunc, 1);
      }
    }

    return;
  }
}

function playerpowerscleanup(var_0, var_1) {
  level.create_disconnectplayer++;
  wait var_1;
  var_0 freescriptable();
  level.create_disconnectplayer--;
}

function playerpositivereinforcement(var_0, var_1) {
  wait var_1;
  var_0 delete();
}

function moveanddamagepoint(var_0, var_1) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.18);
  self.origin = var_1;
  self setscriptablepartstate("explode" + var_0, "active", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self setscriptablepartstate("explode" + var_0, "neutral", 0);
}

function callstrike_playmultitracerfx(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = 3;

  while(var_4 < var_5) {
    var_6 = randomintrange(25, 50);
    var_7 = randomintrange(25, 50);
    playFX(var_0, var_1 + (var_6, var_7, 0), var_2, var_3);
    var_4++;
    wait 0.05;
  }
}

function clear_trap_console_activation(var_0, var_1) {
  level endon("bombardment_finished");
  level.create_agent_definition = 1;
  thread ref_11ab2();
  thread ref_11ab1();
  thread ref_13b40(var_0, var_1);
}

function ref_11ab1() {
  level endon("game_ended");
  level endon("bombardment_finished");
  level waittill("stop_bomb");
  level.create_agent_definition = 0;
  level notify("bombardment_finished");
}

function ref_11ab2() {
  self endon("bombardment_finished");

  while(level.create_agent_definition) {
    level.create_ambient_vehicle = undefined;

    foreach(var_1 in level.players) {
      if(isDefined(var_1) && scripts\mp\utility\player::isreallyalive(var_1)) {
        level.create_ambient_vehicle = var_1;
      }
    }

    if(isDefined(level.create_ambient_vehicle)) {
      level.create_ambient_vehicle waittill("disconnect");
      continue;
    }

    return;
  }
}

function ref_13b40(var_0, var_1) {
  level endon("game_ended");
  level notify("bomb_started");
  level endon("stop_bomb");
  var_2 = gettime() + var_0 * 1000;
  var_3 = "free";

  if(!isDefined(level.create_disconnectplayer)) {
    level.create_disconnectplayer = 0;
  }

  var_4 = [];

  if(isDefined(var_1)) {
    GscBinSkip0(0x2e, 0, var_1);
  }

  var_4 = level.players;
  var_6 = level.ref_13b46;
  var_7 = level.ref_13b45;
  var_8 = 0;

  if(isDefined(level.ref_13b49)) {
    var_8 = level.ref_13b49;
  }

  var_9 = level.ref_13b43 + randomfloat(var_8);
  var_10 = level.ref_13b44;
  var_11 = 0;

  while(gettime() < var_2) {
    foreach(var_1 in var_4) {
      var_13 = undefined;

      if(isPlayer(var_1)) {
        if(!scripts\mp\utility\player::isreallyalive(var_1)) {
          continue;
        } else {
          var_13 = var_1.origin;
        }
      } else if(isvector(var_1)) {
        var_13 = var_1;
      }

      if(!isDefined(var_13)) {
        continue;
      }

      var_14 = ref_13b3c(var_0, var_2);
      var_15 = scripts\mp\gametypes\br_circle::getrandompointincircle(var_13, var_6, var_14.ref_11c42, var_14.ref_11b70, 1, 0);
      ref_12e21(var_15, var_10, level.create_ambient_vehicle);
      var_11++;
      var_11 %= var_7;

      if(var_11 == 0) {
        wait var_9;
      }
    }

    wait 0.1;
  }

  level.create_agent_definition = 0;
  level notify("bombardment_finished");
}

function ref_13b3d(var_0, var_1, var_2, var_3) {
  var_4 = getmaxobjectivecount(var_0[0], var_0[1], var_2);
  var_4 setmapcirclecolorindex(var_3);
  var_4 setmapcircleiconindex(1);
  var_4 setmapcirclestyleindex(1);
  wait var_1;
  var_4 delete();
}

function ref_13b3e(var_0, var_1, var_2) {
  level endon("bombardment_finished");
  var_0 endon("disconnect");
  var_3 = 0.1;
  var_4 = getdvarfloat("scr_threat_max_radius_strikes_around_player", 3000);

  while(gettime() < var_2) {
    if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
      break;
    }

    var_5 = ref_13b3c(var_1, var_2);
    thread ref_13b3d(level, var_0.origin, var_3, var_4 * var_5.ref_11c42);
    thread ref_13b3d(level, var_0.origin, var_3, var_4 * var_5.ref_11b70);
    wait var_3;
  }

  var_0.issnipersemi = 0;
}

function ref_13b3c(var_0, var_1) {
  var_2 = level.ref_13b46;
  var_3 = level.ref_13b47;
  var_4 = level.ref_13b48;
  var_5 = var_3 / var_2;
  var_6 = var_4 / var_2;
  var_7 = var_1 - gettime();
  var_8 = var_7 / var_0 * 1000;
  var_9 = clamp(var_8 + 0.2, 0, 1);

  if(var_9 - var_5 < var_6) {
    var_9 = var_5 + var_6;
  }

  var_10 = spawnStruct();
  var_10.ref_11c42 = clamp(var_6, 0, 1);
  var_10.ref_11b70 = clamp(var_9, 0, 1);
  return var_10;
}

function ref_13b3f(var_0) {
  setDvar("scr_threat_min_radius_strikes_around_player", var_0);
}