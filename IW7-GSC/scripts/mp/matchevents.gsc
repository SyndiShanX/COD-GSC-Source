/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\matchevents.gsc
**************************************/

init() {
  level.var_B3DA["smoke"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.var_B3DA["tracer"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.var_B3DA["explosion"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.var_B3E6["mortar"] = ::func_5915;
  level.var_B3E6["smoke"] = ::func_5AAF;
  level.var_B3E6["airstrike"] = ::func_57DD;
  level.var_B3E6["pavelow"] = ::func_5A5C;
}

onplayerconnect() {
  if(level.prematchperiod > 0 && level.teambased) {
    level.var_9918 = [];
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
  if(isDefined(level.mapcenter)) {
    return level.mapcenter;
  }

  var_00 = getspawnarray("mp_tdm_spawn_allies_start");
  var_01 = getspawnarray("mp_tdm_spawn_axis_start");
  if(isDefined(var_00) && isDefined(var_00[0]) && isDefined(var_01) && isDefined(var_01[0])) {
    var_02 = distance(var_00[0].origin, var_01[0].origin) / 2;
    var_03 = vectortoangles(var_00[0].origin - var_01[0].origin);
    var_03 = vectornormalize(var_03);
    return var_00[0].origin + var_03 * var_02;
  }

  return (0, 0, 0);
}

_meth_8168() {
  var_00 = getspawnarray("mp_tdm_spawn_allies_start");
  var_01 = getspawnarray("mp_tdm_spawn_axis_start");
  if(isDefined(var_00) && isDefined(var_00[0]) && isDefined(var_01) && isDefined(var_01[0])) {
    var_02 = [];
    var_02["axis"] = var_01;
    var_02["allies"] = var_00;
    return var_02;
  }

  return undefined;
}

func_BBF2(param_00) {
  var_01 = param_00.team;
  var_02 = level.var_9918[var_01];
  if(isDefined(var_02) && !var_02.var_5D3C && level.prematchperiod > 0) {
    var_03 = var_02.var_AD31.size % 6;
    var_04 = "tag_ride" + var_03;
    var_05 = var_02 gettagorigin(var_04);
    param_00 setorigin(var_05);
    if(var_03 < 3) {
      param_00 setstance("crouch");
    }

    param_00 setplayerangles(var_02 gettagangles(var_04));
    param_00 playerlinktodelta(var_02, var_04, 1, 90, 90, 30, 60, 0);
    var_02.var_AD31[var_02.var_AD31.size] = param_00;
    param_00 playgestureviewmodel("ges_hold");
  }
}

func_56A7(param_00) {
  param_00 stopgestureviewmodel();
  param_00 unlink();
}

func_FAC7(param_00, param_01, param_02) {
  var_03 = undefined;
  for(;;) {
    level waittill("player_spawned", var_04);
    if(scripts\mp\utility::gameflag("prematch_done")) {
      return;
    }

    if(var_04.team == param_00) {
      var_03 = var_04;
      break;
    }
  }

  var_05 = _meth_8168();
  var_06 = 1200;
  var_07 = 1200;
  var_08 = 1000;
  var_09 = var_05[param_00][0];
  var_0A = undefined;
  if(!isDefined(param_02)) {
    var_0B = anglesToForward(var_09.angles);
    var_0C = anglestoup(var_09.angles);
    var_0D = anglestoright(var_09.angles);
    var_0A = 300 * var_0B + var_06 * var_0C + 3200 * var_0D;
    param_02 = var_09.origin + var_0A;
  } else {
    var_0A = var_09 - param_02;
  }

  if(!isDefined(param_01)) {
    param_01 = "veh_mil_air_ca_dropship_mp";
  }

  var_0E = spawnhelicopter(var_03, param_02, vectortoangles(var_0A), "veh_jackal_mp", param_01);
  if(!isDefined(var_0E)) {
    return;
  }

  level.var_9918[param_00] = var_0E;
  var_0E.var_5D3C = 0;
  var_0E.var_AD31 = [];
  var_0E vehicle_setspeed(50, 15);
  var_0E setvehgoalpos(var_09.origin + (0, 0, var_07 / 2), 1);
  var_0E waittill("goal");
  var_0E givelastonteamwarning(0, 1, 1);
  var_0E setvehgoalpos(var_09.origin + (0, 0, var_07 / 8), 1);
  var_0E waittill("goal");
  var_0E.var_5D3C = 1;
  foreach(var_04 in var_0E.var_AD31) {
    func_56A7(var_04);
  }

  wait(2);
  var_0E givelastonteamwarning(60, 40, 40, 0.3);
  var_0E setvehgoalpos(var_09.origin + (0, 0, var_07), 1);
  var_0E waittill("goal");
  var_0E vehicle_setspeed(80, 60);
  var_0E setvehgoalpos(var_09.origin + (0, 0, var_08) + var_0A, 1);
  var_0E waittill("goal");
  var_0E vehicle_setspeed(120, 120);
  var_0E setvehgoalpos(var_09.origin + 2 * var_0A, 1);
  var_0E waittill("goal");
  var_0E delete();
}

func_5915() {
  var_00 = func_7F8A();
  var_01 = 1;
  for(var_02 = 0; var_02 < 5; var_02++) {
    var_03 = var_00 + (randomintrange(100, 600) * var_01, randomintrange(100, 600) * var_01, 0);
    var_04 = bulletTrace(var_03 + (0, 0, 500), var_03 - (0, 0, 500), 0);
    if(isDefined(var_04["position"])) {
      playFX(level.var_B3DA["tracer"], var_03);
      thread scripts\mp\utility::playsoundinspace("fast_artillery_round", var_03);
      wait(randomfloatrange(0.5, 1.5));
      playFX(level.var_B3DA["explosion"], var_03);
      playrumbleonposition("grenade_rumble", var_03);
      earthquake(1, 0.6, var_03, 2000);
      thread scripts\mp\utility::playsoundinspace("exp_suitcase_bomb_main", var_03);
      physicsexplosionsphere(var_03 + (0, 0, 30), 250, 125, 2);
      var_01 = var_01 * -1;
    }
  }
}

func_5AAF() {
  var_00 = func_7F8A();
  var_01 = 1;
  for(var_02 = 0; var_02 < 3; var_02++) {
    var_03 = var_00 + (randomintrange(100, 600) * var_01, randomintrange(100, 600) * var_01, 0);
    playFX(level.var_B3DA["smoke"], var_03);
    var_01 = var_01 * -1;
    wait(2);
  }
}

func_57DD() {
  level endon("game_ended");
  var_00 = 1;
  var_01 = func_7F8A();
  for(var_02 = 0; var_02 < 3; var_02++) {
    var_03 = var_01 + (randomintrange(100, 600) * var_00, randomintrange(100, 600) * var_00, 0);
    var_04 = bulletTrace(var_03 + (0, 0, 500), var_03 - (0, 0, 500), 0);
    if(isDefined(var_04["position"])) {
      thread func_57DE(var_04["position"]);
      var_00 = var_00 * -1;
      wait(randomintrange(2, 4));
    }
  }
}

func_57DE(param_00) {
  var_01 = randomint(level.spawnpoints.size - 1);
  var_02 = level.spawnpoints[var_01].origin * (1, 1, 0);
  var_03 = 8000;
  var_04 = 8000;
  var_05 = getent("airstrikeheight", "targetname");
  var_06 = (0, 0, var_05.origin[2] + randomintrange(-100, 600));
  var_07 = anglesToForward((0, randomint(45), 0));
  var_08 = var_02 + var_06 + var_07 * var_03 * -1;
  var_09 = var_02 + var_06 + var_07 * var_04;
  var_0A = var_08 + (randomintrange(400, 500), randomintrange(400, 500), randomintrange(200, 300));
  var_0B = var_09 + (randomintrange(400, 500), randomintrange(400, 500), randomintrange(200, 300));
  var_0C = spawnplane(self, "script_model", var_08);
  var_0D = spawnplane(self, "script_model", var_0A);
  if(scripts\engine\utility::cointoss()) {
    var_0C setModel("vehicle_av8b_harrier_jet_mp");
    var_0D setModel("vehicle_av8b_harrier_jet_mp");
  } else {
    var_0C setModel("vehicle_av8b_harrier_jet_opfor_mp");
    var_0D setModel("vehicle_av8b_harrier_jet_opfor_mp");
  }

  var_0C.angles = vectortoangles(var_09 - var_08);
  var_0C playLoopSound("veh_mig29_dist_loop");
  var_0C thread playplanefx();
  var_0D.angles = vectortoangles(var_09 - var_0A);
  var_0D playLoopSound("veh_mig29_dist_loop");
  var_0D thread playplanefx();
  var_0E = distance(var_08, var_09);
  var_0C moveto(var_09 * 2, var_0E / 2000, 0, 0);
  wait(randomfloatrange(0.25, 0.5));
  var_0D moveto(var_0B * 2, var_0E / 2000, 0, 0);
  wait(var_0E / 2000);
  var_0C delete();
  var_0D delete();
}

playplanefx() {
  self endon("death");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_right");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
}

func_5A5C() {
  var_00 = func_7F8A();
  var_01 = bulletTrace(var_00 + (0, 0, 500), var_00 - (0, 0, 500), 0);
  if(isDefined(var_01["position"])) {
    if(scripts\engine\utility::cointoss()) {
      var_02 = "vehicle_pavelow";
    } else {
      var_02 = "vehicle_pavelow_opfor";
    }

    var_03 = spawnhelicopter(self, var_01["position"] + (0, 0, 1000), (0, 0, 0), "pavelow_mp", var_02);
    if(!isDefined(var_03)) {
      return;
    }

    var_03.team = self.pers["team"];
    var_03.var_8DA0 = level.var_8DA1[var_02];
    var_03 thread[[level.lightfxfunc[level.var_8DA1[var_02]]]]();
    var_03.zoffset = (0, 0, var_03 gettagorigin("tag_origin")[2] - var_03 gettagorigin("tag_ground")[2]);
    wait(1);
    playFXOnTag(level.chopper_fx["damage"]["on_fire"], var_03, "tag_engine_left");
    var_03 thread scripts\mp\killstreaks\_helicopter::heli_crash();
  }
}

func_5A59() {
  var_00 = _meth_8168();
  if(isDefined(var_00)) {
    var_01 = 200;
    var_02 = 200;
    var_03 = 1000;
    var_04 = anglesToForward(var_00["allies"][0].angles) * 300;
    var_05 = anglestoup(var_00["allies"][0].angles) * var_01;
    var_06 = var_00["allies"][0].origin + var_04 + var_05;
    var_07 = spawnhelicopter(self, var_06, var_00["allies"][0].angles, "osprey_minigun_mp", "vehicle_v22_osprey_body_mp");
    if(!isDefined(var_07)) {
      return;
    }

    var_08 = anglesToForward(var_00["axis"][0].angles) * 300;
    var_09 = anglestoup(var_00["axis"][0].angles) * var_01;
    var_0A = var_00["axis"][0].origin + var_08 + var_09;
    var_0B = spawnhelicopter(self, var_0A, var_00["axis"][0].angles, "osprey_minigun_mp", "vehicle_v22_osprey_body_mp");
    if(!isDefined(var_0B)) {
      var_07 delete();
      return;
    }

    var_07 thread scripts\mp\killstreaks\_escortairdrop::func_1AEE();
    var_0B thread scripts\mp\killstreaks\_escortairdrop::func_1AEE();
    var_07 thread scripts\mp\killstreaks\_escortairdrop::func_1AEB();
    var_0B thread scripts\mp\killstreaks\_escortairdrop::func_1AEB();
    var_07 vehicle_setspeed(20, 10);
    var_07 givelastonteamwarning(3, 3, 3, 0.3);
    var_07 setvehgoalpos(var_06 + (0, 0, var_02), 1);
    var_0B vehicle_setspeed(20, 10);
    var_0B givelastonteamwarning(3, 3, 3, 0.3);
    var_0B setvehgoalpos(var_0A + (0, 0, var_02), 1);
    var_07 waittill("goal");
    var_07 thread scripts\mp\killstreaks\_escortairdrop::func_1AEC();
    var_0B thread scripts\mp\killstreaks\_escortairdrop::func_1AEC();
    wait(2);
    var_07 vehicle_setspeed(80, 60);
    var_07 givelastonteamwarning(30, 15, 15, 0.3);
    var_07 setvehgoalpos(var_06 + (0, 0, var_03), 1);
    var_0B vehicle_setspeed(80, 60);
    var_0B givelastonteamwarning(30, 15, 15, 0.3);
    var_0B setvehgoalpos(var_0A + (0, 0, var_03), 1);
    var_07 waittill("goal");
    var_07 thread scripts\mp\killstreaks\_escortairdrop::func_1AED();
    var_0B thread scripts\mp\killstreaks\_escortairdrop::func_1AED();
    var_07 vehicle_setspeed(120, 120);
    var_07 givelastonteamwarning(100, 100, 40, 0.3);
    var_07 setvehgoalpos(var_06 + (0, 0, var_03) + var_04 * -20, 1);
    var_0B vehicle_setspeed(120, 120);
    var_0B givelastonteamwarning(100, 100, 40, 0.3);
    var_0B setvehgoalpos(var_0A + (0, 0, var_03) + var_08 * -20, 1);
    var_07 waittill("goal");
    var_07 delete();
    var_0B delete();
  }
}