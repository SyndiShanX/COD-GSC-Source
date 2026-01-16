/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hardpoints.gsc
*********************************************/

init() {
  precacheitem("radar_mp");
  precacheitem("airstrike_mp");
  precacheitem("helicopter_mp");
  precacheitem("artillery_mp");
  level.killstreaksenabled = 1;
  level.hardpointitems = [];
  level.hardpointitems["radar_mp"] = getdvarint("scr_killstreak_kills_uav", 3);
  level.hardpointitems["airstrike_mp"] = getdvarint("scr_killstreak_kills_airstrike", 5);
  level.hardpointitems["helicopter_mp"] = getdvarint("scr_killstreak_kills_heli", 7);
  level.maxkillstreakforaward = 0;

  foreach(var_2, var_1 in level.hardpointitems) {
    if(level.maxkillstreakforaward < var_1)
      level.maxkillstreakforaward = var_1;
  }

  level.hardpointhints["radar_mp"] = & "MP_EARNED_RADAR";
  level.hardpointhints["airstrike_mp"] = & "MP_EARNED_AIRSTRIKE";
  level.hardpointhints["helicopter_mp"] = & "MP_EARNED_HELICOPTER";
  level.hardpointhints["radar_mp_not_available"] = & "MP_RADAR_NOT_AVAILABLE";
  level.hardpointhints["airstrike_mp_not_available"] = & "MP_AIRSTRIKE_NOT_AVAILABLE";
  level.hardpointhints["helicopter_mp_not_available"] = & "MP_HELICOPTER_NOT_AVAILABLE";
  level.hardpointinforms["radar_mp"] = "mp_killstreak_radar";
  level.hardpointinforms["airstrike_mp"] = "mp_killstreak_jet";
  level.hardpointinforms["helicopter_mp"] = "mp_killstreak_heli";
  precachestring(level.hardpointhints["radar_mp"]);
  precachestring(level.hardpointhints["airstrike_mp"]);
  precachestring(level.hardpointhints["helicopter_mp"]);
  precachestring(level.hardpointhints["radar_mp_not_available"]);
  precachestring(level.hardpointhints["airstrike_mp_not_available"]);
  precachestring(level.hardpointhints["helicopter_mp_not_available"]);
  precachestring(&"MP_KILLSTREAK_N");
  precachelocationselector("map_artillery_selector");

  if(!isdefined(level.airstrikefx))
    level.airstrikefx = loadfx("fx\explosions\clusterbomb_mp");

  if(!isdefined(level.airstrike_close_sound))
    level.airstrike_close_sound = "h1_ks_veh_mig29_close_loop";

  level.fx_airstrike_harrier_jet = loadfx("fx\fire\jet_afterburner_harrier");
  level.fx_airstrike_afterburner = loadfx("fx\fire\jet_afterburner");
  level.fx_airstrike_contrail = loadfx("fx\smoke\jet_contrail");
  level.fx_heli_dust = loadfx("vfx\treadfx\heli_dust_default");
  level.fx_heli_water = loadfx("vfx\treadfx\heli_water_default");
  game["dialog"]["uav_online"] = "ouruavonline";
  game["dialog"]["uav_offline"] = "";
  game["dialog"]["enemy_uav_online"] = "enemyuavair";
  game["dialog"]["enemy_uav_offline"] = "";
  game["dialog"]["airstrike_inbound"] = "friendlyair";
  game["dialog"]["enemy_airstrike_inbound"] = "enemyair";
  game["dialog"]["helicopter_inbound"] = "friendlyheli";
  game["dialog"]["enemy_helicopter_inbound"] = "enemyheli";
  game["dialog"]["radar_mp"] = "uavrecon";
  game["dialog"]["airstrike_mp"] = "airstrike";
  game["dialog"]["helicopter_mp"] = "helisupport";

  if(getdvar("scr_heli_hardpoint_interval") != "")
    level.helicopterinterval = getdvarfloat("scr_heli_hardpoint_interval");
  else {
    setdvar("scr_heli_hardpoint_interval", 180);
    level.helicopterinterval = 180;
  }

  level.artillerydangermaxradius = 550;
  level.artillerydangerminradius = 300;
  level.artillerydangerforwardpush = 1.5;
  level.artillerydangerovalscale = 6.0;
  level.artillerymaprange = level.artillerydangerminradius * 0.3 + level.artillerydangermaxradius * 0.7;
  level.artillerydangermaxradiussq = level.artillerydangermaxradius * level.artillerydangermaxradius;
  level.artillerydangercenters = [];
  level.radarviewtime = 30;
  level.numhardpointreservedobjectives = 0;
  maps\mp\_helicopter::init();
  maps\mp\gametypes\_rank::registerxpeventinfo("radar_mp_earned", 100);
  maps\mp\gametypes\_rank::registerxpeventinfo("airstrike_mp_earned", 100);
  maps\mp\gametypes\_rank::registerxpeventinfo("helicopter_mp_earned", 100);
  level.killstreakwieldweapons["artillery_mp"] = "airstrike_mp";
  level.killstreakwieldweapons["cobra_ffar_mp"] = "helicopter_mp";
  level.killstreakwieldweapons["hind_ffar_mp"] = "helicopter_mp";
  level.killstreakwieldweapons["cobra_20mm_mp"] = "helicopter_mp";
  level.killstreakfuncs = [];
  level.killstreakfuncs["radar_mp"] = ::blank;
  level.killstreakfuncs["airstrike_mp"] = ::blank;
  level.killstreakfuncs["helicopter_mp"] = ::blank;

  if(level.teambased) {
    level.activeuavs["allies"] = 0;
    level.activeuavs["axis"] = 0;
    level.uavmodels["allies"] = [];
    level.uavmodels["axis"] = [];
  } else {
    level.activeuavs = [];
    level.uavmodels = [];
  }

  level.killstreakrounddelay = maps\mp\_utility::getintproperty("scr_game_killstreakdelay", 0);
  level.killcountpersistsoverrounds = maps\mp\_utility::getintproperty("scr_killcount_persists", 1);
  level thread onplayerconnect();
}

blank() {}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);

    if(!level.teambased)
      level.activeuavs[var_0.guid] = 0;
  }
}

adduavmodel() {
  if(level.teambased)
    level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
  else
    level.uavmodels[self.owner.guid + "_" + gettime()] = self;
}

removeuavmodel() {
  var_0 = [];

  if(level.teambased) {
    var_1 = self.team;

    foreach(var_3 in level.uavmodels[var_1]) {
      if(!isdefined(var_3) || var_3 == self) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }

    level.uavmodels[var_1] = var_0;
  } else {
    foreach(var_3 in level.uavmodels) {
      if(!isdefined(var_3) || var_3 == self) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }

    level.uavmodels = var_0;
  }
}

addactiveuav() {
  self.uavtype = "standard";

  if(level.teambased)
    level.activeuavs[self.team]++;
  else
    level.activeuavs[self.owner.guid]++;
}

removeactiveuav() {
  if(level.teambased)
    level.activeuavs[self.team]--;
  else if(isdefined(self.owner))
    level.activeuavs[self.owner.guid]--;
}

doartillery(var_0, var_1, var_2) {
  level.airstrikeinprogress = 1;
  var_3 = bullettrace(var_0, var_0 + (0, 0, -100000), 0, undefined, 0, 0, 0, 0, 0, 1);
  var_4 = var_3["position"];
  var_5 = level.mapcenter[2] - var_4[2];

  if(abs(var_5) > 2000)
    var_4 = (var_4[0], var_4[1], level.mapcenter[2]);

  var_6 = getbestplanedirection(var_4);

  if(level.teambased) {
    var_7 = level.players;

    if(!level.hardcoremode) {
      for (var_8 = 0; var_8 < var_7.size; var_8++) {
        if(isalive(var_7[var_8]) && isdefined(var_7[var_8].pers["team"]) && var_7[var_8].pers["team"] == var_2) {
          if(pointisinairstrikearea(var_7[var_8].origin, var_4, var_6))
            var_7[var_8] iprintlnbold(&"MP_WAR_AIRSTRIKE_INBOUND_NEAR_YOUR_POSITION");
        }
      }
    }

    maps\mp\_utility::leaderdialog("airstrike_inbound", var_2);

    for (var_8 = 0; var_8 < level.players.size; var_8++) {
      var_9 = level.players[var_8];
      var_10 = var_9.pers["team"];

      if(isdefined(var_10)) {
        if(var_10 == var_2)
          var_9 iprintln(&"MP_WAR_AIRSTRIKE_INBOUND", var_1);
      }
    }
  } else {
    var_1 maps\mp\_utility::leaderdialogonplayer("airstrike_inbound");

    if(!level.hardcoremode) {
      if(pointisinairstrikearea(var_1.origin, var_4, var_6))
        var_1 iprintlnbold(&"MP_WAR_AIRSTRIKE_INBOUND_NEAR_YOUR_POSITION");
    }
  }

  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(2);

  if(!isdefined(var_1)) {
    level.airstrikeinprogress = undefined;
    return;
  }

  var_1 notify("begin_airstrike");
  var_11 = spawnstruct();
  var_11.origin = var_4;
  var_11.forward = anglestoforward((0, var_6, 0));
  var_11.owner = var_1;
  var_11.team = var_1.team;
  level.artillerydangercenters[level.artillerydangercenters.size] = var_11;
  callstrike(var_1, var_4, var_6);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(8.5);
  var_12 = 0;
  var_13 = [];

  for (var_8 = 0; var_8 < level.artillerydangercenters.size; var_8++) {
    if(!var_12 && level.artillerydangercenters[var_8].origin == var_4) {
      var_12 = 1;
      continue;
    }

    var_13[var_13.size] = level.artillerydangercenters[var_8];
  }

  level.artillerydangercenters = var_13;
  level.airstrikeinprogress = undefined;
}

getairstrikedanger(var_0) {
  var_1 = 0;

  for (var_2 = 0; var_2 < level.artillerydangercenters.size; var_2++) {
    var_3 = level.artillerydangercenters[var_2].origin;
    var_4 = level.artillerydangercenters[var_2].forward;
    var_1 = var_1 + getsingleairstrikedanger(var_0, var_3, var_4);
  }

  return var_1;
}

getsingleairstrikedanger(var_0, var_1, var_2) {
  var_3 = var_1 + level.artillerydangerforwardpush * level.artillerydangermaxradius * var_2;
  var_4 = var_0 - var_3;
  var_4 = (var_4[0], var_4[1], 0);
  var_5 = vectordot(var_4, var_2) * var_2;
  var_6 = var_4 - var_5;
  var_7 = var_6 + var_5 / level.artillerydangerovalscale;
  var_8 = lengthsquared(var_7);

  if(var_8 > level.artillerydangermaxradius * level.artillerydangermaxradius)
    return 0;

  if(var_8 < level.artillerydangerminradius * level.artillerydangerminradius)
    return 1;

  var_9 = sqrt(var_8);
  var_10 = (var_9 - level.artillerydangerminradius) / (level.artillerydangermaxradius - level.artillerydangerminradius);
  return 1 - var_10;
}

pointisinairstrikearea(var_0, var_1, var_2) {
  return distance2d(var_0, var_1) <= level.artillerydangermaxradius * 1.25;
}

losradiusdamage(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = maps\mp\gametypes\_weapons::getdamageableents(var_0, var_1, 1);

  for (var_7 = 0; var_7 < var_6.size; var_7++) {
    if(var_6[var_7].entity == self) {
      continue;
    }
    var_8 = distance(var_0, var_6[var_7].damagecenter);

    if(var_6[var_7].isplayer) {
      var_9 = !maps\mp\gametypes\_weapons::weapondamagetracepassed(var_6[var_7].entity.origin, var_6[var_7].entity.origin + (0, 0, 130), 0, undefined);

      if(!var_9) {
        var_9 = !maps\mp\gametypes\_weapons::weapondamagetracepassed(var_6[var_7].entity.origin + (0, 0, 130), var_0 + (0, 0, 114), 0, undefined);

        if(var_9) {
          var_8 = var_8 * 4;

          if(var_8 > var_1)
            continue;
        }
      }
    }

    var_6[var_7].damage = int(var_2 + (var_3 - var_2) * var_8 / var_1);
    var_6[var_7].pos = var_0;
    var_6[var_7].damageowner = var_4;
    var_6[var_7].einflictor = var_5;
    level.airstrikedamagedents[level.airstrikedamagedentscount] = var_6[var_7];
    level.airstrikedamagedentscount++;
  }

  thread airstrikedamageentsthread();
}

airstrikedamageentsthread() {
  self notify("airstrikeDamageEntsThread");
  self endon("airstrikeDamageEntsThread");

  while (level.airstrikedamagedentsindex < level.airstrikedamagedentscount) {
    if(!isdefined(level.airstrikedamagedents[level.airstrikedamagedentsindex])) {

    } else {
      var_0 = level.airstrikedamagedents[level.airstrikedamagedentsindex];

      if(!isdefined(var_0.entity)) {

      } else if(!var_0.isplayer || isalive(var_0.entity)) {
        var_0 maps\mp\gametypes\_weapons::damageent(var_0.einflictor, var_0.damageowner, var_0.damage, "MOD_PROJECTILE_SPLASH", "artillery_mp", var_0.pos, vectornormalize(var_0.damagecenter - var_0.pos));
        level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;

        if(var_0.isplayer)
          wait 0.05;
      } else
        level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;
    }

    level.airstrikedamagedentsindex++;
  }
}

radiusartilleryshellshock(var_0, var_1, var_2, var_3) {
  var_4 = level.players;

  for (var_5 = 0; var_5 < var_4.size; var_5++) {
    if(!isalive(var_4[var_5])) {
      continue;
    }
    var_6 = var_4[var_5].origin + (0, 0, 32);
    var_7 = distance(var_0, var_6);

    if(var_7 < var_1) {
      var_8 = int(var_2 + (var_3 - var_2) * var_7 / var_1);
      var_4[var_5] thread artilleryshellshock("default", var_8);
    }
  }
}

artilleryshellshock(var_0, var_1) {
  if(isdefined(self.beingartilleryshellshocked) && self.beingartilleryshellshocked) {
    return;
  }
  self.beingartilleryshellshocked = 1;
  self shellshock(var_0, var_1);
  wait(var_1 + 1);
  self.beingartilleryshellshocked = 0;
}

doplanestrike(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isdefined(var_0)) {
    return;
  }
  var_8 = 100;
  var_9 = 150;
  var_10 = var_3 + ((randomfloat(2) - 1) * var_8, (randomfloat(2) - 1) * var_8, 0);
  var_11 = var_4 + ((randomfloat(2) - 1) * var_9, (randomfloat(2) - 1) * var_9, 0);
  var_12 = spawnplane(var_0, "script_model", var_10, "compass_objpoint_airstrike_friendly", "compass_objpoint_airstrike_busy");
  var_13 = var_0.pers["team"];

  if(var_13 == "allies") {
    var_14 = "h1_vehicle_av8b_harrier";

    if(isdefined(level.airstrike_model_allies_override))
      var_14 = level.airstrike_model_allies_override;

    var_12 setmodel(var_14);
  } else {
    var_14 = "h1_vehicle_mig29";

    if(isdefined(level.airstrike_model_axis_override))
      var_14 = level.airstrike_model_axis_override;

    var_12 setmodel(var_14);
  }

  var_12.angles = var_7;
  var_15 = anglestoforward(var_7);

  if(isdefined(level.airstrike_plane_fx_func))
    var_12 thread[[level.airstrike_plane_fx_func]](var_13);
  else
    var_12 thread playplanefx(var_13);

  var_12 moveto(var_11, var_6, 0, 0);
  thread callstrike_planesound(var_12, var_2);
  thread callstrike_bombeffect(var_12, var_11, var_6, var_5 - 1.0, var_0, var_1);
  wait(var_6);
  var_12 notify("delete");
  var_12 delete();
}

callstrike_bombeffect(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait(var_3);
  var_0 thread common_scripts\utility::play_sound_in_space("h1_ks_airstrike_jet_by");
  var_6 = anglestoforward(var_0.angles);
  var_7 = spawnbomb(var_0.origin, var_0.angles);
  var_7 movegravity(common_scripts\utility::vectorscale(anglestoforward(var_0.angles), 4666.67), 3.0);
  var_7.ownerrequireddeathcount = var_5;
  var_8 = spawn("script_model", var_0.origin + (0, 0, 100) - var_6 * 200);
  var_7.killcament = var_8;
  var_8.starttime = gettime();
  var_8 thread deleteaftertime(15.0);
  var_8.angles = var_6;
  var_8 moveto(var_1 + (0, 0, 100), var_2, 0, 0);
  wait 0.4;
  var_8 moveto(var_8.origin + var_6 * 4000, 1, 0, 0);
  wait 0.45;
  var_8 moveto(var_8.origin + (var_6 + (0, 0, -0.2)) * 3500, 2, 0, 0);
  wait 0.15;
  var_9 = spawn("script_model", var_7.origin);
  var_9 setmodel("tag_origin");
  var_9.origin = var_7.origin;
  var_9.angles = var_7.angles;
  var_7 setmodel("tag_origin");
  wait 0.1;
  var_10 = var_9.origin;
  var_11 = var_9.angles;
  playfxontag(level.airstrikefx, var_9, "tag_origin");
  wait 0.05;
  var_8 moveto(var_8.origin + (var_6 + (0, 0, -0.25)) * 2500, 2, 0, 0);
  wait 0.25;
  var_8 moveto(var_8.origin + (var_6 + (0, 0, -0.35)) * 2000, 2, 0, 0);
  wait 0.2;
  var_8 moveto(var_8.origin + (var_6 + (0, 0, -0.45)) * 1500, 2, 0, 0);
  var_12 = 12;
  var_13 = 5;
  var_14 = 55;
  var_15 = (var_14 - var_13) / var_12;
  var_16 = (0, 0, 0);

  for (var_17 = 0; var_17 < var_12; var_17++) {
    var_18 = anglestoforward(var_11 + (var_14 - var_15 * var_17, randomint(10) - 5, 0));
    var_19 = var_10 + common_scripts\utility::vectorscale(var_18, 10000);
    var_20 = bullettrace(var_10, var_19, 0, undefined);
    var_21 = var_20["position"];
    var_16 = var_16 + var_21;
    thread losradiusdamage(var_21 + (0, 0, 16), 512, 200, 30, var_4, var_7);

    if(var_17 % 3 == 0) {
      thread maps\mp\_utility::playsoundinspace("h1_ks_airstrike_exp", var_21);
      playrumbleonposition("artillery_rumble", var_21);
      earthquake(0.7, 0.75, var_21, 1000);
    }

    wait 0.05;
  }

  var_16 = var_16 / var_12 + (0, 0, 128);
  var_8 moveto(var_7.killcament.origin * 0.35 + var_16 * 0.65, 1.5, 0, 0.5);
  wait 5.0;
  var_9 delete();
  var_7 delete();
}

spawnbomb(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setmodel("projectile_cbu97_clusterbomb");
  return var_2;
}

deleteaftertime(var_0) {
  self endon("death");
  wait 10.0;
  self delete();
}

playplanefx(var_0) {
  self endon("death");

  if(var_0 == "allies") {
    playfxontag(level.fx_airstrike_harrier_jet, self, "tag_engine_right");
    playfxontag(level.fx_airstrike_harrier_jet, self, "tag_engine_right2");
    playfxontag(level.fx_airstrike_harrier_jet, self, "tag_engine_left");
    playfxontag(level.fx_airstrike_harrier_jet, self, "tag_engine_left2");
    wait 1.0;
  } else {
    playfxontag(level.fx_airstrike_afterburner, self, "tag_engine_right");
    playfxontag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  }

  playfxontag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  playfxontag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
}

getbestplanedirection(var_0) {
  if(getdvarint("scr_airstrikebestangle") != 1)
    return randomfloat(360);

  var_1 = -25;
  var_2 = 15;
  var_3 = var_0 + (0, 0, 64);
  var_4 = randomfloat(360);
  var_5 = 0;
  var_6 = [];

  for (var_7 = 0; var_7 < var_2; var_7++) {
    var_8 = (var_7 * 1.0 + randomfloat(1)) / var_2 * 360.0;
    var_9 = (var_1, var_8 + 180, 0);
    var_10 = anglestoforward(var_9);
    var_11 = var_3 + var_10 * 1500;
    var_12 = bullettrace(var_3, var_11, 0, undefined);

    if(var_12["fraction"] > var_5) {
      var_5 = var_12["fraction"];
      var_4 = var_8;

      if(var_12["fraction"] >= 1)
        var_6[var_6.size] = var_8;
    }

    if(var_7 % 3 == 0)
      wait 0.05;
  }

  if(var_6.size > 0)
    return var_6[randomint(var_6.size)];

  return var_4;
}

callstrike(var_0, var_1, var_2) {
  var_3 = (0, var_2, 0);
  var_4 = 24000;
  var_5 = 1500;
  var_6 = 850;
  var_7 = 7000;

  if(isdefined(level.airstrikeheightscale))
    var_6 = var_6 * level.airstrikeheightscale;

  var_8 = var_1 + common_scripts\utility::vectorscale(anglestoforward(var_3), -1 * var_4);
  var_8 = var_8 + (0, 0, var_6);
  var_9 = var_1 + common_scripts\utility::vectorscale(anglestoforward(var_3), var_4);
  var_9 = var_9 + (0, 0, var_6);
  var_10 = length(var_8 - var_9);
  var_11 = var_10 / var_7;
  var_10 = abs(var_10 / 2 + var_5);
  var_12 = var_10 / var_7;
  var_0 endon("disconnect");
  var_13 = var_0.deaths;
  level.airstrikedamagedents = [];
  level.airstrikedamagedentscount = 0;
  level.airstrikedamagedentsindex = 0;
  level thread doplanestrike(var_0, var_13, var_1, var_8 + (0, 0, randomint(500)), var_9 + (0, 0, randomint(500)), var_12, var_11, var_3);
  var_14 = randomfloatrange(1.5, 2.5);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_14);
  level thread doplanestrike(var_0, var_13, var_1, var_8 + (0, 0, randomint(200)), var_9 + (0, 0, randomint(200)), var_12, var_11, var_3);
  var_14 = randomfloatrange(1.5, 2.5);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_14);
  level thread doplanestrike(var_0, var_13, var_1, var_8 + (0, 0, randomint(200)), var_9 + (0, 0, randomint(200)), var_12, var_11, var_3);
}

targetisclose(var_0, var_1) {
  var_2 = targetisinfront(var_0, var_1);

  if(var_2)
    var_3 = 1;
  else
    var_3 = -1;

  var_4 = common_scripts\utility::flat_origin(var_0.origin);
  var_5 = var_4 + common_scripts\utility::vectorscale(anglestoforward(common_scripts\utility::flat_angle(var_0.angles)), var_3 * 100000);
  var_6 = pointonsegmentnearesttopoint(var_4, var_5, var_1);
  var_7 = distance(var_4, var_6);

  if(var_7 < 3000)
    return 1;
  else
    return 0;
}

targetisinfront(var_0, var_1) {
  var_2 = anglestoforward(common_scripts\utility::flat_angle(var_0.angles));
  var_3 = vectornormalize(common_scripts\utility::flat_origin(var_1) - var_0.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0)
    return 1;
  else
    return 0;
}

callstrike_planesound(var_0, var_1) {
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("h1_ks_veh_mig29_dist_loop");

  while (!targetisclose(var_0, var_1))
    wait 0.05;

  var_0 notify("stop soundh1_ks_veh_mig29_dist_loop");
  var_0 thread common_scripts\utility::play_loop_sound_on_entity(level.airstrike_close_sound);

  while (targetisinfront(var_0, var_1))
    wait 0.05;

  wait 0.5;

  while (targetisclose(var_0, var_1))
    wait 0.05;

  var_0 notify("stop sound" + level.airstrike_close_sound);
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("h1_ks_veh_mig29_dist_loop");
  var_0 waittill("delete");
  var_0 notify("stop soundh1_ks_veh_mig29_dist_loop");
}

givehardpointitemforstreak() {
  var_0 = self.pers["cur_kill_streak"];

  foreach(var_3, var_2 in level.hardpointitems) {
    if(getdvarint("scr_game_forceuav") && var_3 == "radar_mp") {
      continue;
    }
    if(var_0 == var_2) {
      thread givehardpoint(var_3, var_2);
      break;
    }
  }
}

waittilldoneusingkillstreak() {
  for (var_0 = self getcurrentprimaryweapon(); maps\mp\_utility::iskillstreakweapon(var_0) || maps\mp\_utility::is_true(self.selectinglocation); var_0 = self getcurrentprimaryweapon())
    waitframe();
}

givehardpoint(var_0, var_1) {
  self notify("giveHardpoint");
  self endon("giveHardpoint");
  self endon("disconnect");
  self endon("death");
  waittilldoneusingkillstreak();

  if(givehardpointitem(var_0))
    thread hardpointnotify(var_0, var_1);
}

hardpointnotify(var_0, var_1) {
  thread maps\mp\_events::earnedkillstreakevent(var_0, var_1);
  maps\mp\_utility::leaderdialogonplayer(var_0, "killstreak_earned", 1);
}

killstreakearned(var_0) {
  if(var_0 == "radar_mp")
    self.firstkillstreakearned = gettime();
  else if(isdefined(self.firstkillstreakearned) && var_0 == "helicopter_mp") {
    if(gettime() - self.firstkillstreakearned < 20000)
      thread maps\mp\gametypes\_missions::genericchallenge("wargasm");
  }
}

removekillstreakweapons() {
  var_0 = self getweaponslistall();

  foreach(var_2 in var_0) {
    if(maps\mp\_utility::iskillstreakweapon(var_2))
      self takeweapon(var_2);
  }
}

givehardpointitem(var_0) {
  if(level.gameended && level.gameendtime != gettime())
    return 0;

  if(!maps\mp\_utility::is_true(level.killstreaksenabled))
    return 0;

  if(getdvar("scr_game_hardpoints") != "" && getdvarint("scr_game_hardpoints") == 0)
    return 0;

  if(isdefined(self.selectinglocation))
    return 0;

  var_1 = self getcurrentprimaryweapon();

  if(maps\mp\_utility::iskillstreakweapon(var_1))
    return 0;

  if(!isdefined(level.hardpointitems[var_0]) || !level.hardpointitems[var_0])
    return 0;

  if((!isdefined(level.heli_paths) || !level.heli_paths.size) && var_0 == "helicopter_mp")
    return 0;

  if(isdefined(self.pers["hardPointItem"])) {
    if(level.hardpointitems[var_0] < level.hardpointitems[self.pers["hardPointItem"]])
      return 0;
  }

  removekillstreakweapons();
  self giveweapon(var_0);
  self givemaxammo(var_0);
  self setactionslot(4, "weapon", var_0);
  self.pers["hardPointItem"] = var_0;
  var_2 = maps\mp\_utility::getkillstreakindex(var_0);
  self setclientomnvar("ks_icon0", var_2);
  return 1;
}

giveownedhardpointitem() {
  if(isdefined(self.pers["hardPointItem"]))
    givehardpointitem(self.pers["hardPointItem"]);
}

hardpointitemwaiter() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(maps\mp\_utility::is_true(level.gameended)) {
    return;
  }
  var_0 = self getcurrentweapon();
  giveownedhardpointitem();

  for (;;) {
    self waittill("weapon_change");
    var_1 = self getcurrentweapon();

    switch (var_1) {
      case "helicopter_mp":
      case "airstrike_mp":
      case "radar_mp":
        if(triggerhardpoint(var_1)) {
          logstring("hardpoint: " + var_1);
          thread maps\mp\gametypes\_missions::usehardpoint(self.pers["hardPointItem"]);
          self thread[[level.onxpevent]]("hardpoint");
          thread playertakehardpointweapon(var_0, var_1);
          self setactionslot(4, "");
          self.pers["hardPointItem"] = undefined;
          self setclientomnvar("ks_icon0", 0);
        } else if(var_0 != "none") {
          playerwaitforweapontoanimate(var_1);
          self switchtoweapon(var_0);
        }

        break;
      case "none":
        break;
      default:
        if(!maps\mp\gametypes\_class::isperkequipment(var_1))
          var_0 = var_1;

        break;
    }
  }
}

playerwaitforweapontoanimate(var_0) {
  if(var_0 == "radar_mp" || var_0 == "helicopter_mp") {
    common_scripts\utility::_disableweaponswitch();
    var_1 = common_scripts\utility::waittill_notify_or_timeout_return("weapon_change", 0.75);
    common_scripts\utility::_enableweaponswitch();

    if(!isdefined(var_1) && !self isonladder() && !self isusingturret())
      return 0;
  }

  return 1;
}

playertakehardpointweapon(var_0, var_1) {
  self endon("death");
  self endon("disconnect");

  if(var_0 != "none") {
    var_2 = playerwaitforweapontoanimate(var_1);

    if(var_2) {
      self switchtoweapon(var_0);
      common_scripts\utility::_disableweaponswitch();
      self waittill("weapon_change");
      common_scripts\utility::_enableweaponswitch();
    }
  }

  self takeweapon(var_1);
}

triggerhardpoint(var_0) {
  if(level.killstreakrounddelay) {
    var_1 = 0;

    if(isdefined(level.prematch_done_time))
      var_1 = (gettime() - level.prematch_done_time) / 1000;

    if(var_1 < level.killstreakrounddelay) {
      var_2 = int(level.killstreakrounddelay - var_1 + 0.5);

      if(!var_2)
        var_2 = 1;

      self iprintlnbold(&"MP_UNAVAILABLE_FOR_N", var_2);
      return 0;
    }
  }

  if(var_0 == "radar_mp") {
    maps\mp\_matchdata::logkillstreakevent(var_0, self.origin);
    thread useradaritem();
  } else if(var_0 == "airstrike_mp") {
    if(isdefined(level.airstrikeinprogress)) {
      self stopsound("h1_ks_airstrike_activate_start_plr");
      self iprintlnbold(level.hardpointhints[var_0 + "_not_available"]);
      return 0;
    }

    var_3 = selectairstrikelocation(var_0);

    if(!isdefined(var_3) || !var_3)
      return 0;
  } else if(var_0 == "helicopter_mp") {
    if(isdefined(level.chopper)) {
      self iprintlnbold(level.hardpointhints[var_0 + "_not_available"]);
      return 0;
    }

    var_4 = 0;
    var_5 = randomint(level.heli_paths[var_4].size);
    var_6 = level.heli_paths[var_4][var_5];
    var_7 = self.pers["team"];
    var_8 = level.otherteam[var_7];

    if(level.teambased) {
      maps\mp\_utility::leaderdialog("helicopter_inbound", var_7);
      maps\mp\_utility::leaderdialog("enemy_helicopter_inbound", var_8);

      for (var_9 = 0; var_9 < level.players.size; var_9++) {
        var_10 = level.players[var_9];
        var_11 = var_10.pers["team"];

        if(isdefined(var_11)) {
          if(var_11 == var_7)
            var_10 iprintln(&"MP_HELICOPTER_INBOUND", self);
        }
      }
    } else {
      maps\mp\_utility::leaderdialogonplayer("helicopter_inbound");
      var_12 = [];
      var_12[0] = self;
      maps\mp\_utility::leaderdialog("enemy_helicopter_inbound", undefined, undefined, var_12);
    }

    maps\mp\_matchdata::logkillstreakevent(var_0, self.origin);
    thread maps\mp\_helicopter::heli_think(self, var_6, self.pers["team"]);
  }

  return 1;
}

uavacquiredprintandsound(var_0, var_1, var_2, var_3) {
  var_4 = game["voice"][var_0] + game["dialog"]["uav_online"];
  var_5 = game["voice"][var_1] + game["dialog"]["enemy_uav_online"];

  if(level.splitscreen) {
    for (var_6 = 0; var_6 < level.players.size; var_6++) {
      var_7 = level.players[var_6];
      var_8 = var_7.pers["team"];

      if(isdefined(var_8)) {
        if(var_8 == var_0) {
          var_7 iprintln(&"MP_WAR_RADAR_ACQUIRED", var_2, var_3);
          continue;
        }

        if(var_8 == var_1)
          var_7 iprintln(&"MP_WAR_RADAR_ACQUIRED_ENEMY", var_3);
      }
    }

    level.players[0] playlocalsound(var_4);
  } else {
    maps\mp\_utility::leaderdialog("uav_online", var_0);
    maps\mp\_utility::leaderdialog("enemy_uav_online", var_1);

    for (var_6 = 0; var_6 < level.players.size; var_6++) {
      var_7 = level.players[var_6];
      var_8 = var_7.pers["team"];

      if(isdefined(var_8)) {
        if(var_8 == var_0) {
          var_7 iprintln(&"MP_WAR_RADAR_ACQUIRED", var_2, var_3);
          continue;
        }

        if(var_8 == var_1)
          var_7 iprintln(&"MP_WAR_RADAR_ACQUIRED_ENEMY", var_3);
      }
    }
  }
}

useradaritem() {
  var_0 = self.pers["team"];
  var_1 = "axis";

  if(var_0 == "axis")
    var_1 = "allies";

  if(level.teambased) {
    uavacquiredprintandsound(var_0, var_1, self, level.radarviewtime);
    level notify("radar_timer_kill_" + var_0);
    thread useteamuav(var_0, var_1);
  } else {
    maps\mp\_utility::leaderdialogonplayer("uav_online");
    self iprintln(&"MP_WAR_RADAR_ACQUIRED", self, level.radarviewtime);
    self notify("radar_timer_kill");
    thread useplayeruav();
  }
}

waitforradartoexpireorinterrupt(var_0) {
  self endon(var_0);
  self endon("disconnect");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.radarviewtime);
  return "expire";
}

useteamuav(var_0, var_1) {
  level endon("game_ended");
  setteamradarwrapper(var_0, 1);
  var_2 = spawnstruct();
  var_2.team = var_0;
  var_2.owner = self;
  var_2.uavtype = "standard";
  var_2.origin = (0, 0, 0);
  var_2 adduavmodel();
  var_2 addactiveuav();
  var_3 = level waitforradartoexpireorinterrupt("radar_timer_kill_" + var_0);

  if(isdefined(var_3) && var_3 == "expire") {
    setteamradarwrapper(var_0, 0);
    maps\mp\_utility::printandsoundoneveryone(var_0, var_1, & "MP_WAR_RADAR_EXPIRED", & "MP_WAR_RADAR_EXPIRED_ENEMY", undefined, undefined, "");
  }

  var_2 removeactiveuav();
  var_2 removeuavmodel();
  var_2 = undefined;
}

useplayeruav(var_0, var_1) {
  level endon("game_ended");
  self.hasradar = 1;
  var_2 = spawnstruct();
  var_2.team = var_0;
  var_2.owner = self;
  var_2.uavtype = "standard";
  var_2.origin = (0, 0, 0);
  var_2 adduavmodel();
  var_2 addactiveuav();
  var_3 = waitforradartoexpireorinterrupt("radar_timer_kill");

  if(isdefined(var_3) && var_3 == "expire") {
    self.hasradar = 0;
    self iprintln(&"MP_WAR_RADAR_EXPIRED");
  }

  var_2 removeactiveuav();
  var_2 removeuavmodel();
  var_2 = undefined;
}

setteamradarwrapper(var_0, var_1) {
  setteamradar(var_0, var_1);
  var_2 = 0;

  if(var_1)
    var_2 = 1;

  level notify("radar_status_change", var_0);
}

waitforairstrikecancel() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self waittill("stop_location_selection");

  if(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone() > 0)
    self switchtoweapon(common_scripts\utility::getlastweapon());
}

selectairstrikelocation(var_0) {
  if(!isdefined(level.mapsize))
    level.mapsize = 1024;

  var_1 = level.mapsize / 6.46875;

  if(level.splitscreen)
    var_1 = var_1 * 1.5;

  maps\mp\_utility::_beginlocationselection(var_0, "map_artillery_selector", 0, var_1);
  thread waitforairstrikecancel();
  self endon("stop_location_selection");
  self endon("disconnect");
  self waittill("confirm_location", var_2);

  if(isdefined(level.airstrikeinprogress)) {
    self iprintlnbold(level.hardpointhints["airstrike_mp_not_available"]);
    thread maps\mp\_utility::stoplocationselection(0, "cancel_location");
    return 0;
  }

  maps\mp\_matchdata::logkillstreakevent(var_0, var_2);
  thread finishairstrikeusage(var_2, ::useairstrike);
  return 1;
}

finishairstrikeusage(var_0, var_1) {
  self notify("used");
  self thread[[var_1]](var_0);
  return 1;
}

useairstrike(var_0) {
  if(!isdefined(level.airstrikeheight)) {
    var_1 = bullettrace(level.mapcenter + (0, 0, 100000), level.mapcenter, 0, undefined);
    level.airstrikeheight = var_1["position"][2] - 514;
  }

  var_0 = (var_0[0], var_0[1], level.airstrikeheight);
  thread doartillery(var_0, self, self.pers["team"]);
}

killstreakhit(var_0, var_1, var_2) {
  if(isdefined(var_1) && isplayer(var_0) && isdefined(var_2.owner) && isdefined(var_2.owner.team)) {
    if((level.teambased && var_2.owner.team != var_0.team || !level.teambased) && var_0 != var_2.owner) {
      if(maps\mp\_utility::iskillstreakweapon(var_1)) {
        return;
      }
      if(!isdefined(var_0.lasthittime[var_1]))
        var_0.lasthittime[var_1] = 0;

      if(var_0.lasthittime[var_1] == gettime()) {
        return;
      }
      var_0.lasthittime[var_1] = gettime();
      var_0 thread maps\mp\gametypes\_gamelogic::threadedsetweaponstatbyname(var_1, 1, "hits");
      var_3 = var_0 maps\mp\gametypes\_persistence::statgetbuffered("totalShots");
      var_4 = var_0 maps\mp\gametypes\_persistence::statgetbuffered("hits") + 1;

      if(var_4 <= var_3) {
        var_0 maps\mp\gametypes\_persistence::statsetbuffered("hits", var_4);
        var_0 maps\mp\gametypes\_persistence::statsetbuffered("misses", int(var_3 - var_4));
        var_5 = clamp(float(var_4) / float(var_3), 0.0, 1.0) * 10000.0;
        var_0 maps\mp\gametypes\_persistence::statsetbuffered("accuracy", int(var_5));
      }
    }
  }
}

playerhasuavactive() {
  if(level.teambased) {
    if(level.activeuavs[self.team] > 0)
      return 1;
  } else if(level.activeuavs[self.guid] > 0)
    return 1;

  return 0;
}