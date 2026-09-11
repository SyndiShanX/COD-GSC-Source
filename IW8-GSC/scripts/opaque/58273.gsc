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
  var0 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var0) {
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

function changing_loadout(var0) {
  var1 = 20;
  var2 = getdvarfloat("scr_bombardment_duration", var1);
  var3 = 3000;
  var4 = getdvarfloat("scr_bombardment_radius", var3);
  var5 = (level.br_circle.safecircleent.origin[0], level.br_circle.safecircleent.origin[1], 0);
  var6 = var5;
  return changetimertoovertimetimer(level, var6, var0, var2, var4);
}

function changetimertoovertimetimer(var0, var1, var2, var3) {
  if(getdvarint("scr_bombardment_killswitch", 0)) {
    return false;
  }

  if(istrue(level.create_agent_definition)) {
    return false;
  }

  thread clear_three_room_screens(level, var0, var1, var2);
  return true;
}

function chase(var0, var1, var2) {
  level endon("game_ended");

  if(istrue(level.create_agent_definition)) {
    level notify("stop_bomb");
    waitframe();
  }

  level.create_apc_vehicle_interaction = var2;
  thread clear_trap_console_activation(level, var0);
}

function clear_three_room_screens(var0, var1, var2, var3) {
  level.create_agent_definition = 1;

  if(!isDefined(level.ref_12d05)) {
    ref_11eca(var0, var3, var1);
  }

  var4 = getdvarfloat("scr_bombardment_delay_before_start", 8);

  if(getdvarint("scr_bombardment_show_zone_debug", 0)) {
    thread ref_11aa8(level, var0, var2 + var4);
  }

  wait var4;
  thread create_debug_model_for_spawnpoint(level, var0, var1, var2);
}

function create_debug_model_for_spawnpoint(var0, var1, var2, var3) {
  var4 = gettime() + var2 * 1000;
  var5 = "free";

  if(isDefined(var1)) {
    var5 = var1.team;
  }

  thread create_execution_devgui(level, var0, var4);

  while(gettime() < var4) {
    var6 = scripts\mp\utility\player::getplayersinradius(var0, var3);
    var7 = [];
    var8 = [];

    foreach(var10 in var6) {
      if(updatemlgspectatorinfo(var10) && scripts\mp\utility\player::isreallyalive(var10) && !scripts\mp\utility\player::unset_relic_trex(var10)) {
        var8 = var10;
        continue;
      }

      var7 = var10;
      LOC_000000bb:
    }

    if(var8.size != 0) {
      foreach(var10 in var8) {
        thread ref_13816(level, var10.origin);
        wait 1;
      }

      continue;
    }

    if(var7.size != 0) {
      foreach(var10 in var7) {
        thread ref_13816(level, var10.origin);
        wait 1;
      }

      continue;
    }

    var16 = scripts\mp\gametypes\br_circle::getrandompointincircle(var0, var3, 0.2, 0.9, 1, 0);
    thread ref_13816(level, var16);
    wait 1.5;
  }

  level.create_agent_definition = 0;
}

function create_execution_devgui(var0, var1, var2) {
  var3 = [];
  var4 = 0;
  var3 = scripts\engine\utility::getfx("cranked_explode");
  var3 = scripts\engine\utility::getfx("cluster_optimzed");
  var3 = scripts\engine\utility::getfx("cluster_optimzed");
  var3 = scripts\engine\utility::getfx("cluster_optimzed");
  var3 = scripts\engine\utility::getfx("105_optimzed");
  var5 = [];
  var6 = getdvarfloat("scr_debug_bomb_point_dist", 800);
  var7 = [];
  var8 = var2 * 2 / var6;
  var9 = var0 - (var2, var2, 0);

  for(var10 = 0; var10 < var8; var10++) {
    for(var11 = 0; var11 < var8; var11++) {
      var12 = (var9[0] + var10 * var6, var9[1] + var11 * var6, var0[2]);

      if(distance2dsquared(var0, var12) < var2 * var2) {
        var5 = scripts\engine\utility::drop_to_ground(var12);
      }
    }

    waitframe();
  }

  var5 = scripts\engine\utility::array_randomize(var5);
  var13 = getdvarfloat("scr_debug_bombardment_fx_per_interval", 5);
  var14 = getdvarfloat("scr_debug_bombardment_fx_interval_time", 0.35);

  while(gettime() < var1) {
    for(var10 = 0; var10 < var13; var10++) {
      playFX(var3[var4 % var3.size], var5[var4 % var5.size]);
      var4++;
    }

    wait var14;
  }
}

function ref_11aa8(var0, var1, var2) {
  var3 = ref_11a9b(var0, var2);
  wait var1;
  var3 delete();
}

function ref_11eca(var0, var1, var2) {
  var3 = [];

  foreach(var5 in level.players) {
    if(var5 scripts\mp\gametypes\br_public::isplayeringulag() || !var5 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isDefined(var2) && var5.team == var2.team) {
      var3 = var5;
      button(var5, var2);
      continue;
    }

    if(length2dsquared(var5.origin - var0) < var1 * var1) {
      button_sequence(var5);
      var3 = var5;
      continue;
    }

    if(istrue(level.delete_airlock_ents)) {
      buttonmashcount(var5);
    }
  }

  var7 = ["ebr_alert_missile_10", "ebr_alert_missile_20", "ebr_alert_missile_30"];
  scripts\mp\gametypes\br_public::brleaderdialog(var7[randomintrange(0, 3)], 1, var3);
}

function button(var0, var1) {
  var0 scripts\mp\hud_message::showsplash("br_reveal_bombardment_launch", undefined, var1);
}

function button_sequence(var0) {
  var0 scripts\mp\hud_message::showsplash("br_reveal_bombardment_incoming");
}

function buttonmashcount(var0) {
  var0 scripts\mp\hud_message::showsplash("br_reveal_bombardment_launch_enemy");
}

function updatemlgspectatorinfo() {
  var0 = self;
  var1 = var0.origin;
  var2 = var1 + (0, 0, 3000);

  if(var2[2] <= var1[2]) {
    return 0;
  }

  var3 = scripts\engine\trace::_bullet_trace_passed(var1, var2, 0, var0);
  return var3;
}

function ref_11a9b(var0, var1) {
  var2 = getmaxobjectivecount(var0[0], var0[1], var1);
  var2 setmapcirclecolorindex(12);
  var2 setmapcircleiconindex(3);
  var2 setmapcirclestyleindex(1);
  return var2;
}

function ref_13816(var0, var1) {
  if(!isDefined(level.ref_13922)) {
    level.ref_13922 = 0;
  }

  level.ref_13922++;

  if(!isDefined(var1) || !isPlayer(var1)) {
    ref_12e22(var0, undefined);
    return;
  }

  if(level.ref_13922 % 3 == 0) {
    ref_12e22(var0, var1);
    return;
  }

  if(level.ref_13922 % 3 == 1) {
    ref_12e25(var0, var1);
    return;
  }

  ref_12e24(var0, var1);
}

function ref_12e22(var0, var1) {
  var2 = 16;
  var3 = [(0.33, 0.33, 0), (0.33, 0.66, 0), (0.66, 0.33, 0), (0.66, 0.66, 0), (-0.33, 0.33, 0), (-0.33, 0.66, 0), (-0.66, 0.33, 0), (-0.66, 0.66, 0), (0.33, -0.33, 0), (0.33, -0.66, 0), (0.66, -0.33, 0), (0.66, -0.66, 0), (-0.33, -0.33, 0), (-0.33, -0.66, 0), (-0.66, -0.33, 0), (-0.66, -0.66, 0)];
  var4 = getdvarfloat("scr_bombardment_strike_radius", 514);
  var5 = scripts\engine\utility::randomvectorrange(var4 * -0.25, var4 * 0.25);

  for(var6 = 0; var6 < var2; var6++) {
    var3 = var0 + var5 + (var3[var6][0] * var4, var3[var6][1] * var4, 5000);
  }

  var3 = scripts\engine\utility::array_randomize(var3);
  var7 = spawn("script_model", var0);
  var7 setModel("ks_airstrike_target_mp");

  if(isDefined(var1)) {
    var7 setentityowner(var1);
  }

  var7.weapon_name = "artillery_mp";
  var7.angles = (0, 0, 0);
  var7 dontinterpolate();

  for(var6 = 0; var6 < var3.size; var6++) {
    var8 = var3[var6];
    var9 = var3[var6] - (randomfloatrange(-10, 10), randomfloatrange(-10, 10), 30000);
    var10 = scripts\engine\trace::ray_trace(var8, var9, undefined, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
    var11 = var10["position"];
    var12 = var10["normal"];
    var13 = var11 + var12 * 10;
    var14 = vectorNormalize(var11 - var8);

    if(var14 == (0, 0, 1)) {
      var15 = (0, 1, 0);
    } else {
      var15 = vectorcross(var14, (0, 0, 1));
    }

    var16 = vectorcross(var15, var14);
    thread callstrike_playmultitracerfx(scripts\engine\utility::getfx("airstrike_tracer"), var13, var14, var16);
    thread moveanddamagepoint(var7, var6 + 1);
    wait 0.05;
  }

  wait 2;
  var7 delete();
}

function ref_12e25(var0, var1) {
  var2 = var0 + scripts\engine\utility::randomvectorrange(-1000, 1000) + (0, 0, 3000);
  var3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("iw8_la_kgolf_mp"), var2, var0, var1);
  wait 4;

  if(isDefined(var3)) {
    var3 delete();
    return;
  }
}

function ref_12e24(var0, var1) {
  var2 = var0 + scripts\engine\utility::randomvectorrange(-1000, 1000) + (0, 0, 5000);
  var3 = [(300, 300, 0), (-300, 300, 0), (-300, -300, 0), (300, -300, 0)];
  var4 = getcompleteweaponname("ac130_40mm_mp");

  foreach(var6 in var3) {
    thread set_up_chopper_boss(var1, var4, var2);
    wait 0.1;
  }

  wait 0.1;
  thread set_up_chopper_boss(var1, getcompleteweaponname("ac130_105mm_mp"), var2);
}

function set_up_chopper_boss(var0, var1, var2) {
  level endon("game_ended");
  var3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(var0, var1, var2, self);
  var3 waittill("missile_stuck", var4, var5, var6, var7, var8, var9);
  var10 = 0.5;
  var11 = 100;

  switch (var0.basename) {
    case "ac130_105mm_mp":
      var10 = 1.5;
      var11 = 500;
      break;
    case "ac130_40mm_mp":
      var10 = 1;
      var11 = 300;
      break;
  }

  var12 = spawn("script_model", var3.origin);
  var12 setModel("ks_ac130_target_mp");
  var12.angles = vectortoangles(var9);
  var12 linkTo(var3, "tag_origin", (0, 0, 0), (0, 0, 0));
  var13 = "on";
  var12 setscriptablepartstate(var0.basename, var13, 0);

  if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var3.origin, var11, var11, self.team, var10, self, 1);
    }

    var12 setotherent(self);
    var3 detonate();
  } else {
    var3 delete();
  }

  var14 = var12.origin;
  var15 = 0.75;

  if(var0.basename == "ac130_105mm_mp") {
    var16 = 0.75;
    var17 = 2000;
  } else {
    var16 = 0.5;
    var17 = 1300;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "artillery_earthQuake")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "artillery_earthQuake")]](var16, var16, var17, var17);
  }

  wait 5;
  var14 delete();
}

function ref_12e21(var0, var1, var2) {
  level endon("game_ended");
  var3 = randomfloat(360);
  var4 = vectortoangles((cos(var3), sin(var3), 0));
  var0 = scripts\engine\utility::drop_to_ground(var0);

  if(isDefined(level.ref_13b41)) {
    var5 = level.ref_13b41;
  } else {
    var5 = "vfx_br_x2_bomber_exp";
  }

  if(istrue(level.create_apc_vehicle_interaction)) {
    var6 = spawn("script_model", var1);
    var6 setModel(var5);
    var6.angles = var5;
    waitframe();
  } else {
    var6 = easepower(var6, var2, var5);
  }

  if(!isDefined(var6)) {
    return;
  }

  var6 setscriptablepartstate("base", "active", 0);

  if(isDefined(var4)) {
    radiusdamage(var2, 300, var3, var3, var4, "MOD_EXPLOSIVE", "artillery_mp");
  }

  thread calculatehelitimetoflysec(var2);

  if(istrue(level.create_apc_vehicle_interaction)) {
    thread playerpositivereinforcement(var6, 1);
    return;
  }

  thread playerpowerscleanup(var6, 1);
}

function calculatehelitimetoflysec(var0) {
  self endon("death");
  self endon("missile_dest_failed");
  level endon("game_ended");

  if(istrue(level.delete_starting_boxes)) {
    var1 = scripts\mp\utility\player::getplayersinradius(var0, level.delete_track);

    foreach(var3 in var1) {
      if(!istrue(var3 scripts\mp\gametypes\br_public::isplayeringulag())) {
        var3 scripts\mp\weapons::setplayerstunned();
        var3 thread scripts\mp\weapons::cleanupconcussionstun(level.delete_trapfunc);
        var3 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
        var3 scripts\cp_mp\utility\shellshock_utility::_shellshock("concussion_grenade_mp", "bottom", level.delete_trapfunc, 1);
      }
    }

    return;
  }
}

function playerpowerscleanup(var0, var1) {
  level.create_disconnectplayer++;
  wait var1;
  var0 freescriptable();
  level.create_disconnectplayer--;
}

function playerpositivereinforcement(var0, var1) {
  wait var1;
  var0 delete();
}

function moveanddamagepoint(var0, var1) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.18);
  self.origin = var1;
  self setscriptablepartstate("explode" + var0, "active", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self setscriptablepartstate("explode" + var0, "neutral", 0);
}

function callstrike_playmultitracerfx(var0, var1, var2, var3) {
  var4 = 0;
  var5 = 3;

  while(var4 < var5) {
    var6 = randomintrange(25, 50);
    var7 = randomintrange(25, 50);
    playFX(var0, var1 + (var6, var7, 0), var2, var3);
    var4++;
    wait 0.05;
  }
}

function clear_trap_console_activation(var0, var1) {
  level endon("bombardment_finished");
  level.create_agent_definition = 1;
  thread ref_11ab2();
  thread ref_11ab1();
  thread ref_13b40(var0, var1);
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

    foreach(var1 in level.players) {
      if(isDefined(var1) && scripts\mp\utility\player::isreallyalive(var1)) {
        level.create_ambient_vehicle = var1;
      }
    }

    if(isDefined(level.create_ambient_vehicle)) {
      level.create_ambient_vehicle waittill("disconnect");
      continue;
    }

    return;
  }
}

function ref_13b40(var0, var1) {
  level endon("game_ended");
  level notify("bomb_started");
  level endon("stop_bomb");
  var2 = gettime() + var0 * 1000;
  var3 = "free";

  if(!isDefined(level.create_disconnectplayer)) {
    level.create_disconnectplayer = 0;
  }

  var4 = [];

  if(isDefined(var1)) {
    GscBinSkip0(0x2e, 0, var1);
  }

  var4 = level.players;
  var6 = level.ref_13b46;
  var7 = level.ref_13b45;
  var8 = 0;

  if(isDefined(level.ref_13b49)) {
    var8 = level.ref_13b49;
  }

  var9 = level.ref_13b43 + randomfloat(var8);
  var10 = level.ref_13b44;
  var11 = 0;

  while(gettime() < var2) {
    foreach(var1 in var4) {
      var13 = undefined;

      if(isPlayer(var1)) {
        if(!scripts\mp\utility\player::isreallyalive(var1)) {
          continue;
        } else {
          var13 = var1.origin;
        }
      } else if(isvector(var1)) {
        var13 = var1;
      }

      if(!isDefined(var13)) {
        continue;
      }

      var14 = ref_13b3c(var0, var2);
      var15 = scripts\mp\gametypes\br_circle::getrandompointincircle(var13, var6, var14.ref_11c42, var14.ref_11b70, 1, 0);
      ref_12e21(var15, var10, level.create_ambient_vehicle);
      var11++;
      var11 %= var7;

      if(var11 == 0) {
        wait var9;
      }
    }

    wait 0.1;
  }

  level.create_agent_definition = 0;
  level notify("bombardment_finished");
}

function ref_13b3d(var0, var1, var2, var3) {
  var4 = getmaxobjectivecount(var0[0], var0[1], var2);
  var4 setmapcirclecolorindex(var3);
  var4 setmapcircleiconindex(1);
  var4 setmapcirclestyleindex(1);
  wait var1;
  var4 delete();
}

function ref_13b3e(var0, var1, var2) {
  level endon("bombardment_finished");
  var0 endon("disconnect");
  var3 = 0.1;
  var4 = getdvarfloat("scr_threat_max_radius_strikes_around_player", 3000);

  while(gettime() < var2) {
    if(!isDefined(var0) || !scripts\mp\utility\player::isreallyalive(var0)) {
      break;
    }

    var5 = ref_13b3c(var1, var2);
    thread ref_13b3d(level, var0.origin, var3, var4 * var5.ref_11c42);
    thread ref_13b3d(level, var0.origin, var3, var4 * var5.ref_11b70);
    wait var3;
  }

  var0.issnipersemi = 0;
}

function ref_13b3c(var0, var1) {
  var2 = level.ref_13b46;
  var3 = level.ref_13b47;
  var4 = level.ref_13b48;
  var5 = var3 / var2;
  var6 = var4 / var2;
  var7 = var1 - gettime();
  var8 = var7 / var0 * 1000;
  var9 = clamp(var8 + 0.2, 0, 1);

  if(var9 - var5 < var6) {
    var9 = var5 + var6;
  }

  var10 = spawnStruct();
  var10.ref_11c42 = clamp(var6, 0, 1);
  var10.ref_11b70 = clamp(var9, 0, 1);
  return var10;
}

function ref_13b3f(var0) {
  setDvar("scr_threat_min_radius_strikes_around_player", var0);
}