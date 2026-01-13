/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\matchevents.gsc
*********************************************/

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
      level waittill("connected", var_0);
      var_0 thread onplayerspawned();
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

  var_0 = getspawnarray("mp_tdm_spawn_allies_start");
  var_1 = getspawnarray("mp_tdm_spawn_axis_start");
  if(isDefined(var_0) && isDefined(var_0[0]) && isDefined(var_1) && isDefined(var_1[0])) {
    var_2 = distance(var_0[0].origin, var_1[0].origin) / 2;
    var_3 = vectortoangles(var_0[0].origin - var_1[0].origin);
    var_3 = vectornormalize(var_3);
    return var_0[0].origin + var_3 * var_2;
  }

  return (0, 0, 0);
}

func_8168() {
  var_0 = getspawnarray("mp_tdm_spawn_allies_start");
  var_1 = getspawnarray("mp_tdm_spawn_axis_start");
  if(isDefined(var_0) && isDefined(var_0[0]) && isDefined(var_1) && isDefined(var_1[0])) {
    var_2 = [];
    var_2["axis"] = var_1;
    var_2["allies"] = var_0;
    return var_2;
  }

  return undefined;
}

func_BBF2(var_0) {
  var_1 = var_0.team;
  var_2 = level.var_9918[var_1];
  if(isDefined(var_2) && !var_2.var_5D3C && level.prematchperiod > 0) {
    var_3 = var_2.var_AD31.size % 6;
    var_4 = "tag_ride" + var_3;
    var_5 = var_2 gettagorigin(var_4);
    var_0 setorigin(var_5);
    if(var_3 < 3) {
      var_0 setstance("crouch");
    }

    var_0 setplayerangles(var_2 gettagangles(var_4));
    var_0 playerlinktodelta(var_2, var_4, 1, 90, 90, 30, 60, 0);
    var_2.var_AD31[var_2.var_AD31.size] = var_0;
    var_0 playgestureviewmodel("ges_hold");
  }
}

func_56A7(var_0) {
  var_0 stopgestureviewmodel();
  var_0 unlink();
}

func_FAC7(var_0, var_1, var_2) {
  var_3 = undefined;
  for(;;) {
    level waittill("player_spawned", var_4);
    if(scripts\mp\utility::gameflag("prematch_done")) {
      return;
    }

    if(var_4.team == var_0) {
      var_3 = var_4;
      break;
    }
  }

  var_5 = func_8168();
  var_6 = 1200;
  var_7 = 1200;
  var_8 = 1000;
  var_9 = var_5[var_0][0];
  var_0A = undefined;
  if(!isDefined(var_2)) {
    var_0B = anglesToForward(var_9.angles);
    var_0C = anglestoup(var_9.angles);
    var_0D = anglestoright(var_9.angles);
    var_0A = 300 * var_0B + var_6 * var_0C + 3200 * var_0D;
    var_2 = var_9.origin + var_0A;
  } else {
    var_0A = var_9 - var_2;
  }

  if(!isDefined(var_1)) {
    var_1 = "veh_mil_air_ca_dropship_mp";
  }

  var_0E = spawnhelicopter(var_3, var_2, vectortoangles(var_0A), "veh_jackal_mp", var_1);
  if(!isDefined(var_0E)) {
    return;
  }

  level.var_9918[var_0] = var_0E;
  var_0E.var_5D3C = 0;
  var_0E.var_AD31 = [];
  var_0E vehicle_setspeed(50, 15);
  var_0E setvehgoalpos(var_9.origin + (0, 0, var_7 / 2), 1);
  var_0E waittill("goal");
  var_0E givelastonteamwarning(0, 1, 1);
  var_0E setvehgoalpos(var_9.origin + (0, 0, var_7 / 8), 1);
  var_0E waittill("goal");
  var_0E.var_5D3C = 1;
  foreach(var_4 in var_0E.var_AD31) {
    func_56A7(var_4);
  }

  wait(2);
  var_0E givelastonteamwarning(60, 40, 40, 0.3);
  var_0E setvehgoalpos(var_9.origin + (0, 0, var_7), 1);
  var_0E waittill("goal");
  var_0E vehicle_setspeed(80, 60);
  var_0E setvehgoalpos(var_9.origin + (0, 0, var_8) + var_0A, 1);
  var_0E waittill("goal");
  var_0E vehicle_setspeed(120, 120);
  var_0E setvehgoalpos(var_9.origin + 2 * var_0A, 1);
  var_0E waittill("goal");
  var_0E delete();
}

func_5915() {
  var_0 = func_7F8A();
  var_1 = 1;
  for(var_2 = 0; var_2 < 5; var_2++) {
    var_3 = var_0 + (randomintrange(100, 600) * var_1, randomintrange(100, 600) * var_1, 0);
    var_4 = bulletTrace(var_3 + (0, 0, 500), var_3 - (0, 0, 500), 0);
    if(isDefined(var_4["position"])) {
      playFX(level.var_B3DA["tracer"], var_3);
      thread scripts\mp\utility::playsoundinspace("fast_artillery_round", var_3);
      wait(randomfloatrange(0.5, 1.5));
      playFX(level.var_B3DA["explosion"], var_3);
      playrumbleonposition("grenade_rumble", var_3);
      earthquake(1, 0.6, var_3, 2000);
      thread scripts\mp\utility::playsoundinspace("exp_suitcase_bomb_main", var_3);
      physicsexplosionsphere(var_3 + (0, 0, 30), 250, 125, 2);
      var_1 = var_1 * -1;
    }
  }
}

func_5AAF() {
  var_0 = func_7F8A();
  var_1 = 1;
  for(var_2 = 0; var_2 < 3; var_2++) {
    var_3 = var_0 + (randomintrange(100, 600) * var_1, randomintrange(100, 600) * var_1, 0);
    playFX(level.var_B3DA["smoke"], var_3);
    var_1 = var_1 * -1;
    wait(2);
  }
}

func_57DD() {
  level endon("game_ended");
  var_0 = 1;
  var_1 = func_7F8A();
  for(var_2 = 0; var_2 < 3; var_2++) {
    var_3 = var_1 + (randomintrange(100, 600) * var_0, randomintrange(100, 600) * var_0, 0);
    var_4 = bulletTrace(var_3 + (0, 0, 500), var_3 - (0, 0, 500), 0);
    if(isDefined(var_4["position"])) {
      thread func_57DE(var_4["position"]);
      var_0 = var_0 * -1;
      wait(randomintrange(2, 4));
    }
  }
}

func_57DE(var_0) {
  var_1 = randomint(level.spawnpoints.size - 1);
  var_2 = level.spawnpoints[var_1].origin * (1, 1, 0);
  var_3 = 8000;
  var_4 = 8000;
  var_5 = getent("airstrikeheight", "targetname");
  var_6 = (0, 0, var_5.origin[2] + randomintrange(-100, 600));
  var_7 = anglesToForward((0, randomint(45), 0));
  var_8 = var_2 + var_6 + var_7 * var_3 * -1;
  var_9 = var_2 + var_6 + var_7 * var_4;
  var_0A = var_8 + (randomintrange(400, 500), randomintrange(400, 500), randomintrange(200, 300));
  var_0B = var_9 + (randomintrange(400, 500), randomintrange(400, 500), randomintrange(200, 300));
  var_0C = spawnplane(self, "script_model", var_8);
  var_0D = spawnplane(self, "script_model", var_0A);
  if(scripts\engine\utility::cointoss()) {
    var_0C setModel("vehicle_av8b_harrier_jet_mp");
    var_0D setModel("vehicle_av8b_harrier_jet_mp");
  } else {
    var_0C setModel("vehicle_av8b_harrier_jet_opfor_mp");
    var_0D setModel("vehicle_av8b_harrier_jet_opfor_mp");
  }

  var_0C.angles = vectortoangles(var_9 - var_8);
  var_0C playLoopSound("veh_mig29_dist_loop");
  var_0C thread playplanefx();
  var_0D.angles = vectortoangles(var_9 - var_0A);
  var_0D playLoopSound("veh_mig29_dist_loop");
  var_0D thread playplanefx();
  var_0E = distance(var_8, var_9);
  var_0C moveto(var_9 * 2, var_0E / 2000, 0, 0);
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
  var_0 = func_7F8A();
  var_1 = bulletTrace(var_0 + (0, 0, 500), var_0 - (0, 0, 500), 0);
  if(isDefined(var_1["position"])) {
    if(scripts\engine\utility::cointoss()) {
      var_2 = "vehicle_pavelow";
    } else {
      var_2 = "vehicle_pavelow_opfor";
    }

    var_3 = spawnhelicopter(self, var_1["position"] + (0, 0, 1000), (0, 0, 0), "pavelow_mp", var_2);
    if(!isDefined(var_3)) {
      return;
    }

    var_3.team = self.pers["team"];
    var_3.var_8DA0 = level.var_8DA1[var_2];
    var_3 thread[[level.lightfxfunc[level.var_8DA1[var_2]]]]();
    var_3.zoffset = (0, 0, var_3 gettagorigin("tag_origin")[2] - var_3 gettagorigin("tag_ground")[2]);
    wait(1);
    playFXOnTag(level.chopper_fx["damage"]["on_fire"], var_3, "tag_engine_left");
    var_3 thread scripts\mp\killstreaks\_helicopter::heli_crash();
  }
}

func_5A59() {
  var_0 = func_8168();
  if(isDefined(var_0)) {
    var_1 = 200;
    var_2 = 200;
    var_3 = 1000;
    var_4 = anglesToForward(var_0["allies"][0].angles) * 300;
    var_5 = anglestoup(var_0["allies"][0].angles) * var_1;
    var_6 = var_0["allies"][0].origin + var_4 + var_5;
    var_7 = spawnhelicopter(self, var_6, var_0["allies"][0].angles, "osprey_minigun_mp", "vehicle_v22_osprey_body_mp");
    if(!isDefined(var_7)) {
      return;
    }

    var_8 = anglesToForward(var_0["axis"][0].angles) * 300;
    var_9 = anglestoup(var_0["axis"][0].angles) * var_1;
    var_0A = var_0["axis"][0].origin + var_8 + var_9;
    var_0B = spawnhelicopter(self, var_0A, var_0["axis"][0].angles, "osprey_minigun_mp", "vehicle_v22_osprey_body_mp");
    if(!isDefined(var_0B)) {
      var_7 delete();
      return;
    }

    var_7 thread scripts\mp\killstreaks\_escortairdrop::func_1AEE();
    var_0B thread scripts\mp\killstreaks\_escortairdrop::func_1AEE();
    var_7 thread scripts\mp\killstreaks\_escortairdrop::func_1AEB();
    var_0B thread scripts\mp\killstreaks\_escortairdrop::func_1AEB();
    var_7 vehicle_setspeed(20, 10);
    var_7 givelastonteamwarning(3, 3, 3, 0.3);
    var_7 setvehgoalpos(var_6 + (0, 0, var_2), 1);
    var_0B vehicle_setspeed(20, 10);
    var_0B givelastonteamwarning(3, 3, 3, 0.3);
    var_0B setvehgoalpos(var_0A + (0, 0, var_2), 1);
    var_7 waittill("goal");
    var_7 thread scripts\mp\killstreaks\_escortairdrop::func_1AEC();
    var_0B thread scripts\mp\killstreaks\_escortairdrop::func_1AEC();
    wait(2);
    var_7 vehicle_setspeed(80, 60);
    var_7 givelastonteamwarning(30, 15, 15, 0.3);
    var_7 setvehgoalpos(var_6 + (0, 0, var_3), 1);
    var_0B vehicle_setspeed(80, 60);
    var_0B givelastonteamwarning(30, 15, 15, 0.3);
    var_0B setvehgoalpos(var_0A + (0, 0, var_3), 1);
    var_7 waittill("goal");
    var_7 thread scripts\mp\killstreaks\_escortairdrop::func_1AED();
    var_0B thread scripts\mp\killstreaks\_escortairdrop::func_1AED();
    var_7 vehicle_setspeed(120, 120);
    var_7 givelastonteamwarning(100, 100, 40, 0.3);
    var_7 setvehgoalpos(var_6 + (0, 0, var_3) + var_4 * -20, 1);
    var_0B vehicle_setspeed(120, 120);
    var_0B givelastonteamwarning(100, 100, 40, 0.3);
    var_0B setvehgoalpos(var_0A + (0, 0, var_3) + var_8 * -20, 1);
    var_7 waittill("goal");
    var_7 delete();
    var_0B delete();
  }
}