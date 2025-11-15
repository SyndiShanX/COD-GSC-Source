/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2767.gsc
***************************************/

init() {
  level.func_B3DA["smoke"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.func_B3DA["tracer"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.func_B3DA["explosion"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.func_B3E6["mortar"] = ::func_5915;
  level.func_B3E6["smoke"] = ::func_5AAF;
  level.func_B3E6["airstrike"] = ::func_57DD;
  level.func_B3E6["pavelow"] = ::func_5A5C;
}

onplayerconnect() {
  if(level.prematchperiod > 0 && level.teambased) {
    level.func_9918 = [];
    thread func_FAC7("allies");
    thread func_FAC7("axis");

    for(;;) {
      level waittill("connected", var_00);
      var_00 thread onplayerspawned();
    }
  }
}

onplayerspawned() {
  self endon("disconnect");
  level endon("prematch_over");
  self waittill("spawned_player");
  func_BBF2(self);
}

func_7F8A() {
  if(isDefined(level.mapcenter))
    return level.mapcenter;

  var_00 = getspawnarray("mp_tdm_spawn_allies_start");
  var_01 = getspawnarray("mp_tdm_spawn_axis_start");

  if(isDefined(var_00) && isDefined(var_0[0]) && isDefined(var_01) && isDefined(var_1[0])) {
    var_02 = distance(var_0[0].origin, var_1[0].origin) / 2;
    var_03 = vectortoangles(var_0[0].origin - var_1[0].origin);
    var_03 = vectornormalize(var_03);
    return var_0[0].origin + var_03 * var_02;
  }

  return (0, 0, 0);
}

_meth_8168() {
  var_00 = getspawnarray("mp_tdm_spawn_allies_start");
  var_01 = getspawnarray("mp_tdm_spawn_axis_start");

  if(isDefined(var_00) && isDefined(var_0[0]) && isDefined(var_01) && isDefined(var_1[0])) {
    var_02 = [];
    var_2["axis"] = var_01;
    var_2["allies"] = var_00;
    return var_02;
  } else
    return undefined;
}

func_BBF2(var_00) {
  var_01 = var_0.team;
  var_02 = level.func_9918[var_01];

  if(isDefined(var_02) && !var_2.func_5D3C && level.prematchperiod > 0) {
    var_03 = var_2.func_AD31.size % 6;
    var_04 = "tag_ride" + var_03;
    var_05 = var_02 gettagorigin(var_04);
    var_00 setorigin(var_05);

    if(var_03 < 3)
      var_00 setstance("crouch");

    var_00 setplayerangles(var_02 gettagangles(var_04));
    var_00 getweightedchanceroll(var_02, var_04, 1.0, 90, 90, 30, 60, 0);
    var_2.func_AD31[var_2.func_AD31.size] = var_00;
    var_00 playgestureviewmodel("ges_hold");
  }
}

func_56A7(var_00) {
  var_00 stopgestureviewmodel();
  var_00 unlink();
}

func_FAC7(var_00, var_01, var_02) {
  var_03 = undefined;

  for(;;) {
    level waittill("player_spawned", var_04);

    if(scripts\mp\utility\game::gameflag("prematch_done")) {
      return;
    }
    if(var_4.team == var_00) {
      var_03 = var_04;
      break;
    }
  }

  var_05 = _meth_8168();
  var_06 = 1200;
  var_07 = 1200;
  var_08 = 1000;
  var_09 = var_5[var_00][0];
  var_10 = undefined;

  if(!isDefined(var_02)) {
    var_11 = anglesToForward(var_9.angles);
    var_12 = anglestoup(var_9.angles);
    var_13 = anglestoright(var_9.angles);
    var_10 = 300 * var_11 + var_06 * var_12 + 3200 * var_13;
    var_02 = var_9.origin + var_10;
  } else
    var_10 = var_09 - var_02;

  if(!isDefined(var_01))
    var_01 = "veh_mil_air_ca_dropship_mp";

  var_14 = spawnhelicopter(var_03, var_02, vectortoangles(var_10), "veh_jackal_mp", var_01);

  if(!isDefined(var_14)) {
    return;
  }
  level.func_9918[var_00] = var_14;
  var_14.func_5D3C = 0;
  var_14.func_AD31 = [];
  var_14 vehicle_setspeed(50, 15);
  var_14 setvehgoalpos(var_9.origin + (0, 0, var_07 / 2), 1);
  var_14 waittill("goal");
  var_14 setyawspeed(0, 1, 1);
  var_14 setvehgoalpos(var_9.origin + (0, 0, var_07 / 8), 1);
  var_14 waittill("goal");
  var_14.func_5D3C = 1;

  foreach(var_04 in var_14.func_AD31)
  func_56A7(var_04);

  wait 2;
  var_14 setyawspeed(60, 40, 40, 0.3);
  var_14 setvehgoalpos(var_9.origin + (0, 0, var_07), 1);
  var_14 waittill("goal");
  var_14 vehicle_setspeed(80, 60);
  var_14 setvehgoalpos(var_9.origin + (0, 0, var_08) + var_10, 1);
  var_14 waittill("goal");
  var_14 vehicle_setspeed(120, 120);
  var_14 setvehgoalpos(var_9.origin + 2 * var_10, 1);
  var_14 waittill("goal");
  var_14 delete();
}

func_5915() {
  var_00 = func_7F8A();
  var_01 = 1;

  for(var_02 = 0; var_02 < 5; var_2++) {
    var_03 = var_00 + (randomintrange(100, 600) * var_01, randomintrange(100, 600) * var_01, 0);
    var_04 = bulletTrace(var_03 + (0, 0, 500), var_03 - (0, 0, 500), 0);

    if(isDefined(var_4["position"])) {
      playFX(level.func_B3DA["tracer"], var_03);
      thread scripts\mp\utility\game::playsoundinspace("fast_artillery_round", var_03);
      wait(randomfloatrange(0.5, 1.5));
      playFX(level.func_B3DA["explosion"], var_03);
      playrumbleonentity("grenade_rumble", var_03);
      earthquake(1.0, 0.6, var_03, 2000);
      thread scripts\mp\utility\game::playsoundinspace("exp_suitcase_bomb_main", var_03);
      physicsexplosionsphere(var_03 + (0, 0, 30), 250, 125, 2);
      var_01 = var_01 * -1;
    }
  }
}

func_5AAF() {
  var_00 = func_7F8A();
  var_01 = 1;

  for(var_02 = 0; var_02 < 3; var_2++) {
    var_03 = var_00 + (randomintrange(100, 600) * var_01, randomintrange(100, 600) * var_01, 0);
    playFX(level.func_B3DA["smoke"], var_03);
    var_01 = var_01 * -1;
    wait 2;
  }
}

func_57DD() {
  level endon("game_ended");
  var_00 = 1;
  var_01 = func_7F8A();

  for(var_02 = 0; var_02 < 3; var_2++) {
    var_03 = var_01 + (randomintrange(100, 600) * var_00, randomintrange(100, 600) * var_00, 0);
    var_04 = bulletTrace(var_03 + (0, 0, 500), var_03 - (0, 0, 500), 0);

    if(isDefined(var_4["position"])) {
      thread func_57DE(var_4["position"]);
      var_00 = var_00 * -1;
      wait(randomintrange(2, 4));
    }
  }
}

func_57DE(var_00) {
  var_01 = randomint(level.spawnpoints.size - 1);
  var_02 = level.spawnpoints[var_01].origin * (1, 1, 0);
  var_03 = 8000;
  var_04 = 8000;
  var_05 = getent("airstrikeheight", "targetname");
  var_06 = (0, 0, var_5.origin[2] + randomintrange(-100, 600));
  var_07 = anglesToForward((0, randomint(45), 0));
  var_08 = var_02 + var_06 + var_07 * var_03 * -1;
  var_09 = var_02 + var_06 + var_07 * var_04;
  var_10 = var_08 + (randomintrange(400, 500), randomintrange(400, 500), randomintrange(200, 300));
  var_11 = var_09 + (randomintrange(400, 500), randomintrange(400, 500), randomintrange(200, 300));
  var_12 = spawnplane(self, "script_model", var_08);
  var_13 = spawnplane(self, "script_model", var_10);

  if(scripts\engine\utility::cointoss()) {
    var_12 setModel("vehicle_av8b_harrier_jet_mp");
    var_13 setModel("vehicle_av8b_harrier_jet_mp");
  } else {
    var_12 setModel("vehicle_av8b_harrier_jet_opfor_mp");
    var_13 setModel("vehicle_av8b_harrier_jet_opfor_mp");
  }

  var_12.angles = vectortoangles(var_09 - var_08);
  var_12 playLoopSound("veh_mig29_dist_loop");
  var_12 thread playplanefx();
  var_13.angles = vectortoangles(var_09 - var_10);
  var_13 playLoopSound("veh_mig29_dist_loop");
  var_13 thread playplanefx();
  var_14 = distance(var_08, var_09);
  var_12 moveto(var_09 * 2, var_14 / 2000, 0, 0);
  wait(randomfloatrange(0.25, 0.5));
  var_13 moveto(var_11 * 2, var_14 / 2000, 0, 0);
  wait(var_14 / 2000);
  var_12 delete();
  var_13 delete();
}

playplanefx() {
  self endon("death");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_right");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
}

func_5A5C() {
  var_00 = func_7F8A();
  var_01 = bulletTrace(var_00 + (0, 0, 500), var_00 - (0, 0, 500), 0);

  if(isDefined(var_1["position"])) {
    if(scripts\engine\utility::cointoss())
      var_02 = "vehicle_pavelow";
    else
      var_02 = "vehicle_pavelow_opfor";

    var_03 = spawnhelicopter(self, var_1["position"] + (0, 0, 1000), (0, 0, 0), "pavelow_mp", var_02);

    if(!isDefined(var_03)) {
      return;
    }
    var_3.team = self.pers["team"];
    var_3.func_8DA0 = level.func_8DA1[var_02];
    var_03 thread[[level.lightfxfunc[level.func_8DA1[var_02]]]]();
    var_3.zoffset = (0, 0, var_03 gettagorigin("tag_origin")[2] - var_03 gettagorigin("tag_ground")[2]);
    wait 1;
    playFXOnTag(level.chopper_fx["damage"]["on_fire"], var_03, "tag_engine_left");
    var_03 thread scripts\mp\killstreaks\helicopter::heli_crash();
  }
}

func_5A59() {
  var_00 = _meth_8168();

  if(isDefined(var_00)) {
    var_01 = 200;
    var_02 = 200;
    var_03 = 1000;
    var_04 = anglesToForward(var_0["allies"][0].angles) * 300;
    var_05 = anglestoup(var_0["allies"][0].angles) * var_01;
    var_06 = var_0["allies"][0].origin + var_04 + var_05;
    var_07 = spawnhelicopter(self, var_06, var_0["allies"][0].angles, "osprey_minigun_mp", "vehicle_v22_osprey_body_mp");

    if(!isDefined(var_07)) {
      return;
    }
    var_08 = anglesToForward(var_0["axis"][0].angles) * 300;
    var_09 = anglestoup(var_0["axis"][0].angles) * var_01;
    var_10 = var_0["axis"][0].origin + var_08 + var_09;
    var_11 = spawnhelicopter(self, var_10, var_0["axis"][0].angles, "osprey_minigun_mp", "vehicle_v22_osprey_body_mp");

    if(!isDefined(var_11)) {
      var_07 delete();
      return;
    }

    var_07 thread scripts\mp\killstreaks\escort_airdrop::func_1AEE();
    var_11 thread scripts\mp\killstreaks\escort_airdrop::func_1AEE();
    var_07 thread scripts\mp\killstreaks\escort_airdrop::func_1AEB();
    var_11 thread scripts\mp\killstreaks\escort_airdrop::func_1AEB();
    var_07 vehicle_setspeed(20, 10);
    var_07 setyawspeed(3, 3, 3, 0.3);
    var_07 setvehgoalpos(var_06 + (0, 0, var_02), 1);
    var_11 vehicle_setspeed(20, 10);
    var_11 setyawspeed(3, 3, 3, 0.3);
    var_11 setvehgoalpos(var_10 + (0, 0, var_02), 1);
    var_07 waittill("goal");
    var_07 thread scripts\mp\killstreaks\escort_airdrop::func_1AEC();
    var_11 thread scripts\mp\killstreaks\escort_airdrop::func_1AEC();
    wait 2;
    var_07 vehicle_setspeed(80, 60);
    var_07 setyawspeed(30, 15, 15, 0.3);
    var_07 setvehgoalpos(var_06 + (0, 0, var_03), 1);
    var_11 vehicle_setspeed(80, 60);
    var_11 setyawspeed(30, 15, 15, 0.3);
    var_11 setvehgoalpos(var_10 + (0, 0, var_03), 1);
    var_07 waittill("goal");
    var_07 thread scripts\mp\killstreaks\escort_airdrop::func_1AED();
    var_11 thread scripts\mp\killstreaks\escort_airdrop::func_1AED();
    var_07 vehicle_setspeed(120, 120);
    var_07 setyawspeed(100, 100, 40, 0.3);
    var_07 setvehgoalpos(var_06 + (0, 0, var_03) + var_04 * -20, 1);
    var_11 vehicle_setspeed(120, 120);
    var_11 setyawspeed(100, 100, 40, 0.3);
    var_11 setvehgoalpos(var_10 + (0, 0, var_03) + var_08 * -20, 1);
    var_07 waittill("goal");
    var_07 delete();
    var_11 delete();
  }
}