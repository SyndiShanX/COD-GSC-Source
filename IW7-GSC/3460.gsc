/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3460.gsc
**************************************/

init() {
  var_0 = spawnStruct();
  var_0.var_B923 = [];
  var_0.var_B923["allies"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
  var_0.var_B923["axis"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
  var_0.inboundsfx = "veh_mig29_dist_loop";
  var_0.compassiconfriendly = "compass_objpoint_airstrike_friendly";
  var_0.compassiconenemy = "compass_objpoint_airstrike_busy";
  var_0.speed = 4000;
  var_0.halfdistance = 20000;
  var_0.var_5715 = 4000;
  var_0.heightrange = 250;
  var_0.var_C23A = 3;
  var_0.outboundflightanim = "airstrike_mp_roll";
  var_0.sonicboomsfx = "veh_mig29_sonic_boom";
  var_0.onattackdelegate = ::func_24D8;
  var_0.onflybycompletedelegate = ::cleanupgamemodes;
  var_0.scorepopup = "destroyed_air_superiority";
  var_0.callout = "callout_destroyed_air_superiority";
  var_0.vodestroyed = undefined;
  var_0.killcamoffset = (-800, 0, 200);
  level.planeconfigs["air_superiority"] = var_0;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("air_superiority", ::onuse);
  level.teamairdenied["axis"] = 0;
  level.teamairdenied["allies"] = 0;
}

onuse(var_0) {
  var_1 = scripts\mp\utility\game::getotherteam(self.team);

  if(level.teambased && level.teamairdenied[var_1] || !level.teambased && isDefined(level.airdeniedplayer) && level.airdeniedplayer == self) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else {
    thread dostrike(var_0.lifeid, "air_superiority");
    scripts\mp\matchdata::logkillstreakevent("air_superiority", self.origin);
    thread scripts\mp\utility\game::teamplayercardsplash("used_air_superiority", self);
    return 1;
  }
}

dostrike(var_0, var_1) {
  var_2 = level.planeconfigs[var_1];
  var_3 = scripts\mp\killstreaks\plane::func_8069(var_2.var_5715);
  wait 1;
  var_4 = scripts\mp\utility\game::getotherteam(self.team);
  level.teamairdenied[var_4] = 1;
  level.airdeniedplayer = self;
  dooneflyby(var_1, var_0, var_3.targetpos, var_3.var_6F25, var_3.height);
  self waittill("aa_flyby_complete");
  wait 2;
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(isDefined(self)) {
    dooneflyby(var_1, var_0, var_3.targetpos, -1 * var_3.var_6F25, var_3.height);
    self waittill("aa_flyby_complete");
  }

  level.teamairdenied[var_4] = 0;
  level.airdeniedplayer = undefined;
}

dooneflyby(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.planeconfigs[var_0];
  var_6 = scripts\mp\killstreaks\plane::getflightpath(var_2, var_3, var_5.halfdistance, 1, var_4, var_5.speed, -0.5 * var_5.halfdistance, var_0);
  level thread scripts\mp\killstreaks\plane::doflyby(var_1, self, var_1, var_6["startPoint"] + (0, 0, randomint(var_5.heightrange)), var_6["endPoint"] + (0, 0, randomint(var_5.heightrange)), var_6["attackTime"], var_6["flyTime"], var_3, var_0);
}

func_24D8(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self.owner endon("killstreak_disowned");
  level endon("game_ended");
  wait(var_2);
  var_5 = func_6CAA(self.owner, self.team);
  var_6 = level.planeconfigs[var_4];
  var_7 = var_6.var_C23A;

  for(var_8 = var_5.size - 1; var_8 >= 0 && var_7 > 0; var_8--) {
    var_9 = var_5[var_8];

    if(isDefined(var_9) && isalive(var_9)) {
      fireattarget(var_9);
      var_7--;
      wait 1;
    }
  }
}

cleanupgamemodes(var_0, var_1, var_2) {
  var_0 notify("aa_flyby_complete");
}

func_6CC8(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3)) {
    foreach(var_6 in var_3) {
      if([[var_2]](var_0, var_1, var_6)) {
        var_4.targets[var_4.targets.size] = var_6;
      }
    }
  }

  return var_4;
}

func_6CAA(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.targets = [];
  var_3 = undefined;

  if(level.teambased) {
    var_3 = scripts\mp\utility\game::func_9FE7;
  } else {
    var_3 = scripts\mp\utility\game::func_9FD8;
  }

  var_4 = undefined;

  if(isDefined(var_1)) {
    var_4 = scripts\mp\utility\game::getotherteam(var_1);
  }

  func_6CC8(var_0, var_4, var_3, level.heli_pilot, var_2);

  if(isDefined(level.lbsniper)) {
    if([
        [var_3]
      ](var_0, var_4, level.lbsniper))
      var_2.targets[var_2.targets.size] = level.lbsniper;
  }

  func_6CC8(var_0, var_4, var_3, level.planes, var_2);
  func_6CC8(var_0, var_4, var_3, level.littlebirds, var_2);
  func_6CC8(var_0, var_4, var_3, level.helis, var_2);
  return var_2.targets;
}

fireattarget(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = undefined;

  if(isDefined(self.owner)) {
    var_1 = self.owner;
  }

  var_2 = 384 * anglesToForward(self.angles);
  var_3 = self gettagorigin("tag_missile_1") + var_2;
  var_4 = scripts\mp\utility\game::_magicbullet("aamissile_projectile_mp", var_3, var_3 + var_2, var_1);
  var_4.vehicle_fired_from = self;
  var_3 = self gettagorigin("tag_missile_2") + var_2;
  var_5 = scripts\mp\utility\game::_magicbullet("aamissile_projectile_mp", var_3, var_3 + var_2, var_1);
  var_5.vehicle_fired_from = self;
  var_6 = [var_4, var_5];
  var_0 notify("targeted_by_incoming_missile", var_6);
  thread func_10DC4(var_0, 0.25, var_6);
}

func_10DC4(var_0, var_1, var_2) {
  wait(var_1);

  if(isDefined(var_0)) {
    var_3 = undefined;

    if(var_0.model != "vehicle_av8b_harrier_jet_mp") {
      var_3 = var_0 gettagorigin("tag_missile_target");
    }

    if(!isDefined(var_3)) {
      var_3 = var_0 gettagorigin("tag_body");
    }

    var_4 = var_3 - var_0.origin;

    foreach(var_6 in var_2) {
      if(isvalidmissile(var_6)) {
        var_6 missile_settargetent(var_0, var_4);
        var_6 missile_setflightmodedirect();
      }
    }
  }
}

func_52CA(var_0, var_1) {
  scripts\mp\killstreaks\killstreaks::func_532A(var_0, var_1, "aamissile_projectile_mp", level.helis);
  scripts\mp\killstreaks\killstreaks::func_532A(var_0, var_1, "aamissile_projectile_mp", level.littlebirds);
  scripts\mp\killstreaks\killstreaks::func_532A(var_0, var_1, "aamissile_projectile_mp", level.heli_pilot);

  if(isDefined(level.lbsniper)) {
    var_2 = [];
    var_2[0] = level.lbsniper;
    scripts\mp\killstreaks\killstreaks::func_532A(var_0, var_1, "aamissile_projectile_mp", var_2);
  }

  scripts\mp\killstreaks\killstreaks::func_532A(var_0, var_1, "aamissile_projectile_mp", level.remote_uav);
  scripts\mp\killstreaks\killstreaks::func_532A(var_0, var_1, "aamissile_projectile_mp", level.planes);
}