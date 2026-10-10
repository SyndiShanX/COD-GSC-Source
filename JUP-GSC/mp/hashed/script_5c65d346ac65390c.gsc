/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5c65d346ac65390c.gsc
*************************************************/

#using script_5c65d346ac65390c;
#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_heli_reinforce;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace namespace_80d9f81787d5f007;

function function_7d47bded29ed7882(timetoarrive, heliheight, waittime, minwaittime, var_1a7e969d835799f2, exitheight, var_abe738473a42706b, helihealth, var_1869ac124be0cc0b) {
  if(!isDefined(level.chopperexfil)) {
    level.chopperexfil = spawnStruct();
  }

  level.chopperexfil.timetoarrive = timetoarrive;
  level.chopperexfil.heliheight = heliheight;
  level.chopperexfil.heliwaittime = waittime;
  level.chopperexfil.heliminwaittime = minwaittime;
  level.chopperexfil.var_1a7e969d835799f2 = var_1a7e969d835799f2;
  level.chopperexfil.exitheight = exitheight;
  level.chopperexfil.var_abe738473a42706b = var_abe738473a42706b;
  level.chopperexfil.helihealth = helihealth;
  level.chopperexfil.var_1869ac124be0cc0b = var_1869ac124be0cc0b;
  level.chopperexfil.hoverradius = getdvarfloat(@ "hash_ce7f3e9f2382e943", 2);
}

function function_3c673414d075ebfc(callbackkey, func) {
  if(isDefined(level.chopperexfil)) {
    scripts\engine\utility::registersharedfunc("chopper_exfil", callbackkey, func);
    return;
  }

  assertmsg("<dev string:x1c>");
}

function function_ed11ae9fe1abdeb(ent, endpos) {
  if(!isDefined(ent)) {
    return undefined;
  }

  if(!isDefined(level.chopperexfil.exfilpaths)) {
    level.chopperexfil.exfilpaths = [];
  }

  if(isent(ent) && isDefined(level.chopperexfil.exfilpaths[ent getentitynumber()])) {
    return level.chopperexfil.exfilpaths[ent getentitynumber()];
  }

  targetloc = function_8fb6efc069bf4ef8(ent, level.chopperexfil.heliheight, 1);
  exitvec = targetloc - ent.origin;
  exitvec = vectorNormalize((exitvec[0], exitvec[1], 0));
  exitangles = vectortoangles(exitvec * -1);
  startstruct = spawnStruct();
  startstruct.angles = ent.angles;

  if(isDefined(ent.info.helitargetorigin)) {
    endpos = ent.info.helitargetorigin;
    startstruct.angles = ent.info.helitargetangles;
  }

  startstruct.origin = endpos + (0, 0, level.chopperexfil.exitheight);
  startstruct.radius = 500;
  startstruct.speed = 10;

  if(isent(ent)) {
    startstruct.targetname = "exfil" + ent getentitynumber();
  }

  startstruct.script_anglevehicle = "1";

  if(istrue(ent.info.land)) {
    startstruct.script_land = "1";
  }

  struct1 = function_38e2d21d6f6e393b(startstruct.origin + exitvec * 100 + (0, 0, level.chopperexfil.heliheight), startstruct, startstruct.targetname, 10, 1, ent.angles);
  struct2 = function_38e2d21d6f6e393b(struct1.origin + exitvec * 5000, struct1, startstruct.targetname, 20, 2, exitangles);
  struct3 = function_38e2d21d6f6e393b(struct1.origin + exitvec * 10000, struct2, startstruct.targetname, 85, 3, exitangles);

  if(getdvarint(@ "hash_57fea5b439641c39", 0) == 1) {
    level thread scripts\mp\utility\debug::drawsphere(startstruct.origin, 64, 25, (0, 0, 60));
    level thread scripts\mp\utility\debug::drawline(startstruct.origin, anglesToForward(startstruct.angles) * 100 + startstruct.origin, 25, (0, 0, 60));
    level thread scripts\mp\utility\debug::drawsphere(struct1.origin, 64, 25, (0, 0, 60));
    level thread scripts\mp\utility\debug::drawline(struct1.origin, anglesToForward(struct1.angles) * 100 + struct1.origin, 25, (0, 0, 60));
    level thread scripts\mp\utility\debug::drawsphere(struct2.origin, 64, 25, (0, 0, 60));
    level thread scripts\mp\utility\debug::drawline(struct2.origin, anglesToForward(struct2.angles) * 100 + struct2.origin, 25, (0, 0, 60));
    level thread scripts\mp\utility\debug::drawsphere(struct3.origin, 64, 25, (0, 0, 60));
    level thread scripts\mp\utility\debug::drawline(struct3.origin, anglesToForward(struct3.angles) * 100 + struct3.origin, 25, (0, 0, 60));
  }

  if(isent(ent)) {
    level.chopperexfil.exfilpaths[ent getentitynumber()] = struct3;
  }

  return struct3;
}

function function_1093b8f392744e3b(ent, endpos, var_dcea0339d68fe36a, angleoverride, overridestartangles) {
  if(istrue(angleoverride)) {
    toorigin = ent.origin - level.radiation.origin;
    toangles = vectortoangles(toorigin);
    targetloc = function_8fb6efc069bf4ef8(ent, var_dcea0339d68fe36a, 0, toangles[1]);
  } else {
    targetloc = function_8fb6efc069bf4ef8(ent, var_dcea0339d68fe36a, 0);
  }

  exitvec = targetloc - endpos;
  exitvec = vectorNormalize((exitvec[0], exitvec[1], 0));
  exitangles = vectortoangles(exitvec);
  startstruct = spawnStruct();
  startstruct.origin = targetloc;
  startstruct.angles = ent.angles;
  startstruct.radius = 500;
  startstruct.speed = 80;

  if(isent(ent)) {
    startstruct.targetname = "exfilExit" + ent getentitynumber();
  }

  s3pos = endpos + (0, 0, 900);
  s2pos = s3pos + (0, 0, var_dcea0339d68fe36a);
  startangles = default_to(overridestartangles, ent.angles);
  struct0 = function_38e2d21d6f6e393b(s2pos + exitvec * 9000 + (0, 0, 9000), startstruct, startstruct.targetname, 40, 1, exitangles);
  struct1 = function_38e2d21d6f6e393b(s2pos + exitvec * 5000, struct0, startstruct.targetname, 20, 2, exitangles);
  struct2 = function_38e2d21d6f6e393b(s2pos, struct1, startstruct.targetname, 40, 3, exitangles);
  struct3 = function_38e2d21d6f6e393b(s2pos - (0, 0, 300), struct2, startstruct.targetname, 10, 4, startangles);
  struct4 = function_38e2d21d6f6e393b(s3pos, struct3, startstruct.targetname, 10, 5, startangles);
  return struct4;
}

function function_8fb6efc069bf4ef8(startnode, heliheight, reverse, angleoverride) {
  if(!isDefined(reverse)) {
    reverse = 0;
  }

  var_3fb4a86293ed25a6 = 10;
  contents = create_contents(0, 1, 1, 1, 1, 0, 1, 1, 0);
  startpos = startnode.origin + (0, 0, heliheight + 600);
  yaw = ter_op(isDefined(angleoverride), angleoverride, startnode.angles[1]);
  var_3674d96c61e2dd0d = ter_op(reverse, yaw + 180, yaw);
  ignoreents = undefined;

  if(isDefined(level.vehicle) && isDefined(level.vehicle.instances)) {
    ignoreents = level.vehicle.instances["little_bird"];
  }

  yaw = 0;

  while(yaw < 360) {
    var_3674d96c61e2dd0d += yaw;
    testangles = (0, var_3674d96c61e2dd0d, 0);
    approachstartpos = startpos;
    approachendpos = startpos + anglesToForward(testangles) * 18000;
    approachtrace = sphere_trace(approachstartpos, approachendpos, 100, ignoreents, contents, 1);

    if(approachtrace["fraction"] == 1) {
      return approachendpos;
    }

    if(yaw % 3 == 0) {
      waitframe();
    }

    yaw += var_3fb4a86293ed25a6;
  }

  return undefined;
}

function private function_38e2d21d6f6e393b(pos, prevstruct, triggername, speed, num, angleoverride) {
  struct = spawnStruct();
  struct.speed = speed;
  struct.origin = pos;
  struct.angles = ter_op(isDefined(angleoverride), angleoverride, prevstruct.angles);
  struct.radius = 500;
  struct.target = prevstruct;
  struct.script_anglevehicle = "1";
  return struct;
}

function function_d05f47d864f18196(owner, pos, angles, var_4fffc035c8679b98, var_7e6513b2ae0d5c1d, var_14cde247ac3313a4) {
  if(!isDefined(var_4fffc035c8679b98)) {
    var_4fffc035c8679b98 = 1;
  }

  if(!isDefined(var_7e6513b2ae0d5c1d)) {
    var_7e6513b2ae0d5c1d = 0;
  }

  spawndata = spawnStruct();
  spawndata.origin = pos;
  spawndata.angles = angles;
  spawndata.spawntype = "GAME_MODE";

  if(isDefined(var_14cde247ac3313a4)) {
    spawndata.var_14cde247ac3313a4 = var_14cde247ac3313a4;
  } else if(!var_4fffc035c8679b98) {
    spawndata.var_14cde247ac3313a4 = "dmzwhite";
  }

  if(istrue(level.var_291b51c7af8d1204)) {
    spawndata.team = "axis";
    spawndata.mtx = "v013";
  }

  heli = undefined;

  while(!isDefined(heli)) {
    heli = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_palfa", spawndata);

    if(!isDefined(heli)) {
      wait 1;
    }
  }

  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_preventrespawn(heli);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(heli);
  heli.var_135a33623c519457 = 1;
  heli.health = ter_op(isDefined(level.chopperexfil.helihealth), level.chopperexfil.helihealth, 1000);
  heli.maxhealth = heli.health;
  heli.var_902a7ffcff8aa65 = [];
  heli.var_75adb7f3cbe5d522 = level.chopperexfil.heliwaittime + level.chopperexfil.heliminwaittime;

  if(istrue(var_4fffc035c8679b98)) {
    heli.callingteam = owner.team;
  }

  heli.playersinside = [];
  heli.onstartriding = &function_1e04f8a9053512a4;
  heli.onendriding = &function_6519494290b58824;
  heli.var_c547488f80d3eb28 = 1;
  heli.unload_land_offset = 255;
  heli.script_disconnectpaths = 1;
  heli.var_746334c2ac85aacc = 10000;
  heli.handleeventcallback = &function_ad65ea51ce655f42;
  heli.exfilhelicopter = 1;
  heli function_264031b20e04a07c();
  heli function_247ad6a91f6a4ffe(1);

  if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "setup_gas_masks")) {
    [[scripts\engine\utility::getsharedfunc("chopper_exfil", "setup_gas_masks")]](heli);
  }

  heli scripts\engine\utility::function_f3bb4f4911a1beb2("pmc_missions", "onSpawnExfilHeli", var_7e6513b2ae0d5c1d);
  return heli;
}

function private function_264031b20e04a07c() {
  drivermodels = ["body_sp_ally_pilot_western_vm_fullbody", "body_sp_ally_pilot_western_vm_fullbody"];
  var_30f2bdd1710c71fb = ["iw9_mp_heli_palfa_seat_0_idle", "iw9_heli_palfa_seat_1_idle"];
  drivertags = ["tag_seat_0", "tag_seat_1"];
  pilot_num = 2;
  self.pilots = [];

  for(i = 0; i < pilot_num; i++) {
    fake_guy = function_8c5dd82b28a2c584(i, drivertags[i], var_30f2bdd1710c71fb[i], drivermodels[i], undefined);
    self.pilots[self.pilots.size] = fake_guy;
  }
}

function private function_8c5dd82b28a2c584(posindex, tag, animname, model, headmodel) {
  spawnorg = self gettagorigin(tag);
  spawnang = self gettagangles(tag);
  spawned = spawn("script_model", spawnorg);
  spawned.angles = spawnang;
  spawned setModel(model);
  spawnorg = spawned gettagorigin("j_spine4");
  spawnang = spawned gettagangles("j_spine4");
  spawned.linkedents = [];

  if(isDefined(headmodel)) {
    head = spawn("script_model", spawnorg);
    head.angles = spawnang;
    head setModel(headmodel);
    head linkTo(spawned, "j_spine4");
    spawned.linkedents[spawned.linkedents.size] = head;
    spawned.head = head;
  }

  spawned linkTo(self);

  if(isDefined(animname)) {
    spawned scriptmodelplayanim(animname);
  }

  return spawned;
}

function function_423f49e2512a5f53() {
  if(istrue(self.var_a09b2cb47a28054a)) {
    self.var_a09b2cb47a28054a = undefined;
  }
}

function function_1e04f8a9053512a4(player) {
  if(!array_contains_key(self.playersinside, player.guid)) {
    self.playersinside[player.guid] = player;
    scripts\mp\outofbounds::enableoobimmunity(player);

    if(!istrue(self.timerstarted) || self.var_75adb7f3cbe5d522 < 1) {
      return;
    }

    if(!isDefined(player.var_a09b2cb47a28054a)) {
      self.var_902a7ffcff8aa65[self.var_902a7ffcff8aa65.size] = player;
      player.var_a09b2cb47a28054a = 1;
      displaytime = self.var_75adb7f3cbe5d522 + level.chopperexfil.heliminwaittime;

      if(isDefined(self.minwaittimer) && isDefined(level.chopperexfil.heliminwaittime) && self.minwaittimer < level.chopperexfil.heliminwaittime) {
        displaytime = self.minwaittimer;
      }

      if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "player_exfil_timer")) {
        player thread[[scripts\engine\utility::getsharedfunc("chopper_exfil", "player_exfil_timer")]](self, displaytime, 2000);
      }
    }

    scripts\cp_mp\talking_gun::function_55b08d6d71b41402(player, "enter_exfil_heli");
  }

  playersinteam = 0;

  if(isDefined(self.callingteam) && player.team == self.callingteam) {
    if(isDefined(self.minwaittimer) && isDefined(level.chopperexfil.heliminwaittime) && self.minwaittimer < level.chopperexfil.heliminwaittime) {
      return;
    }

    players = getteamdata(self.callingteam, "players");

    foreach(teammember in players) {
      if(isreallyalive(teammember) && !isDefined(self.playersinside[teammember.guid]) && !istrue(teammember.extracted)) {
        return;
      }
    }

    foreach(player in self.var_902a7ffcff8aa65) {
      if(istrue(player.var_a09b2cb47a28054a)) {
        if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "player_exfil_timer")) {
          player thread[[scripts\engine\utility::getsharedfunc("chopper_exfil", "player_exfil_timer")]](self, level.chopperexfil.heliminwaittime, 2000);
        }
      }
    }
  } else {
    return;
  }

  if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "dialog_shortcut")) {
    player thread[[scripts\engine\utility::getsharedfunc("chopper_exfil", "dialog_shortcut")]]();
  }

  self notify("chopper_exfil_team_ready");
}

function function_6519494290b58824(player) {
  self.playersinside[player.guid] = undefined;
  player notify("exited_chopper");
  player.var_8a38603863a78b8e = undefined;

  if(isDefined(player) && isint(player.oobimmunity) && !istrue(player.extracted)) {
    scripts\mp\outofbounds::disableoobimmunity(player);
  }
}

function function_a5fc6e8f9df1ccea(heli, endpoint, ent) {
  heli endon("death");

  if(isDefined(ent)) {
    ent endon("disable");
  }

  while(distance(heli.origin, endpoint) > 2500) {
    wait 0.1;
  }

  heli setscriptablepartstate("dmz_exfil_dust_sounds", "landing");

  while(distance(heli.origin, endpoint) > 1500) {
    wait 0.1;
  }

  if(isDefined(ent)) {
    ent setscriptablepartstate("dmz_exfil_smoke", "dissipate");
  }

  heli function_247ad6a91f6a4ffe(0);

  while(distance(heli.origin, endpoint) > 800) {
    wait 0.1;
  }

  heli setscriptablepartstate("dmz_exfil_turbine_sounds", "landing");

  while(distance(heli.origin, endpoint) < 1500) {
    wait 0.1;
  }

  heli function_247ad6a91f6a4ffe(1);
}

function function_72d275d574bd23dd(heli, endpoint) {
  heli endon("death");

  while(distance2d(heli.origin, endpoint) > 500) {
    wait 0.1;
  }

  if(isDefined(self)) {
    scripts\cp_mp\calloutmarkerping::function_ffd6eed18c767472(self, heli, 6, 21, (0, 0, 72));
  }
}

function function_55d37b18154a058e(waittime) {
  self endon("chopper_exfil_team_ready");
  self.timerstarted = 1;
  exfiltimer = int(waittime);
  players = level.players;

  if(isDefined(self.callingteam)) {
    players = getteamdata(self.callingteam, "players");
  }

  if(self.playersinside.size > 0) {
    players = array_combine(players, self.playersinside);
  }

  foreach(member in players) {
    if(!isDefined(member.var_a09b2cb47a28054a) && isreallyalive(member)) {
      self.var_902a7ffcff8aa65[self.var_902a7ffcff8aa65.size] = member;
      member.var_a09b2cb47a28054a = 1;

      if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "player_exfil_timer")) {
        member thread[[scripts\engine\utility::getsharedfunc("chopper_exfil", "player_exfil_timer")]](self, exfiltimer + level.chopperexfil.heliminwaittime, undefined);
      }
    }
  }

  self.var_75adb7f3cbe5d522 = exfiltimer;
  self.minwaittimer = level.chopperexfil.heliminwaittime;

  while(self.var_75adb7f3cbe5d522 > 0) {
    self.var_75adb7f3cbe5d522--;

    if(!isDefined(self.callingteam) && self.var_75adb7f3cbe5d522 == 60 - level.chopperexfil.heliminwaittime) {
      if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "dialog_final_warning")) {
        [[scripts\engine\utility::getsharedfunc("chopper_exfil", "dialog_final_warning")]](players);
      }
    }

    wait 1;
  }
}

function function_18d68b06fa34264b(heli) {
  heli setscriptablepartstate("dmz_exfil_dust_sounds", "landing");

  if(!isDefined(heli.minwaittimer)) {
    heli.minwaittimer = level.chopperexfil.heliminwaittime;
  }

  heli function_2b68fd672b6b021();
  heli function_c05648d95863318a();
  heli setscriptablepartstate("dmz_exfil_dust_sounds", "liftoff");
}

function function_2b68fd672b6b021() {
  wait self.minwaittimer * 0.75;
  self setscriptablepartstate("dmz_exfil_turbine_sounds", "liftoff");
}

function function_c05648d95863318a() {
  while(self.minwaittimer > 0) {
    self.minwaittimer--;
    wait 1;
  }
}

function function_ed686fcbc5363b3() {
  if(isDefined(self.pilots)) {
    foreach(pilot in self.pilots) {
      foreach(ent in pilot.linkedents) {
        ent delete();
      }

      pilot delete();
    }
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_death(self);
}

function function_d1478474b036b87f(ent, part, state, player, waittime, var_4fffc035c8679b98, finalexfil, var_14cde247ac3313a4) {
  if(!isDefined(var_4fffc035c8679b98)) {
    var_4fffc035c8679b98 = 1;
  }

  if(!isDefined(ent) || istrue(ent.disabled)) {
    return;
  }

  if(isDefined(ent.heli)) {
    if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "airspace_too_crowded")) {
      [[scripts\engine\utility::getsharedfunc("chopper_exfil", "airspace_too_crowded")]](player);
      return;
    }
  }

  playersleft = 0;
  groundorg = getgroundposition(ent.origin, 1) + (0, 0, 2);
  ent.inuse = 1;
  players = level.players;
  team = undefined;

  if(!istrue(finalexfil)) {
    team = player.team;
    players = getteamdata(player.team, "players");
    exfilstruct = function_730c660d9fc6808e(players, finalexfil, 0, istrue(ent.info.personal), 0);
    ent scripts\engine\utility::function_f3bb4f4911a1beb2("pmc_missions", "onSignalExfil", player);
  }

  scripts\cp_mp\overlord::playevent("match_exfil_inbound", players);

  if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "initial_splash")) {
    [[scripts\engine\utility::getsharedfunc("chopper_exfil", "initial_splash")]](players, ent.info.poi, istrue(finalexfil));
  }

  namespace_1eb3c4e0e28fac71::utilflare_shootflare(ent.origin, "dmz_exfil");
  wait 3.75;

  if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "music_start")) {
    [[scripts\engine\utility::getsharedfunc("chopper_exfil", "music_start")]](players, finalexfil);
  }

  wait 1.25;
  waittimer = level.chopperexfil.timetoarrive;

  if(isDefined(player) && !istrue(finalexfil)) {
    upgradecount = default_to(scripts\engine\utility::function_f3bb4f4911a1beb2("instanceInventory", "getUpgradeCount", player, 27), 0);
    waittimer -= upgradecount * getdvarfloat(@ "hash_32085370522fbf3f", 30);
    waittimer = max(0, waittimer);
  }

  if(!isDefined(waittimer)) {
    waittimer = 60;
  }

  if(scripts\mp\utility\game::getsubgametype() == "dmz" && isDefined(level.var_6fc3398b5a13400) && istrue(finalexfil)) {
    remainingtime = (level.var_6fc3398b5a13400 - gettime()) / 1000;

    if(remainingtime > waittimer * 2) {
      thread scripts\engine\utility::function_f3bb4f4911a1beb2("chopper_exfil", "dialog_start_exfil", players, team, finalexfil, ent, waittimer);
      wait waittimer;
    }
  } else {
    if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "dialog_start_exfil")) {
      thread[[scripts\engine\utility::getsharedfunc("chopper_exfil", "dialog_start_exfil")]](players, team, finalexfil, ent, waittimer);
    }

    wait waittimer;
  }

  path = function_ed11ae9fe1abdeb(ent, groundorg);

  if(!isDefined(path)) {
    return;
  }

  ownerplayer = player;

  for(i = 0; i < players.size && !isDefined(ownerplayer); i++) {
    ownerplayer = players[i];
  }

  if(!isDefined(ownerplayer)) {
    return;
  }

  heli = function_d05f47d864f18196(ownerplayer, path.origin, ent.angles, var_4fffc035c8679b98, finalexfil, var_14cde247ac3313a4);
  heli.finalexfil = finalexfil;
  thread function_a5fc6e8f9df1ccea(heli, groundorg, ent);
  ent thread function_72d275d574bd23dd(heli, groundorg);
  heli scripts\common\vehicle_paths::vehicle_paths_helicopter(path);

  if(!istrue(ent.info.land)) {
    heli sethoverparams(isDefined(level.chopperexfil.hoverradius) ? level.chopperexfil.hoverradius : 2, 1, 1);
  }

  if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "dialog_handle_touchdown")) {
    thread[[scripts\engine\utility::getsharedfunc("chopper_exfil", "dialog_handle_touchdown")]](players, heli);
  }

  if(!istrue(var_4fffc035c8679b98) && isDefined(level.chopperexfil.var_1a7e969d835799f2)) {
    waittime = (level.chopperexfil.var_1a7e969d835799f2 - gettime()) / 1000 - level.chopperexfil.minwaittimer - level.chopperexfil.var_abe738473a42706b;
  }

  if(scripts\mp\utility\game::getsubgametype() == "dmz" && isDefined(level.var_6fc3398b5a13400) && istrue(finalexfil)) {
    remainingtime = (level.var_6fc3398b5a13400 - gettime()) / 1000;
    waittime = remainingtime - level.chopperexfil.heliminwaittime - 1;
    var_eea954761967701f = round(remainingtime % 1, level.framedurationseconds);

    if(var_eea954761967701f >= level.framedurationseconds) {
      waittime -= var_eea954761967701f;
      wait var_eea954761967701f;
    }
  }

  heli function_55d37b18154a058e(ter_op(isDefined(waittime), waittime, level.chopperexfil.heliwaittime));
  function_18d68b06fa34264b(heli);

  if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "music_stop")) {
    thread[[scripts\engine\utility::getsharedfunc("chopper_exfil", "music_stop")]](heli.playersinside, finalexfil);
  }

  if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "dialog_final_leaving")) {
    thread[[scripts\engine\utility::getsharedfunc("chopper_exfil", "dialog_final_leaving")]](players, finalexfil);
  }

  heli.exfilpathstarted = 1;
  heli notify("exfil_path_started");

  if(istrue(level.chopperexfil.var_1869ac124be0cc0b)) {
    heli scripts\mp\ai_heli_reinforce::function_fc805ec1e7b08264(heli.currentnode);
  } else {
    path = function_1093b8f392744e3b(ent, groundorg, level.chopperexfil.heliheight, !istrue(var_4fffc035c8679b98));
    heli thread scripts\common\vehicle_paths::vehicle_paths_helicopter(path);
    wait 10;
  }

  scripts\cp_mp\calloutmarkerping::function_c068efdf0abd5258(ent);
  wait 1.5;

  if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "music_exfil_end")) {
    thread[[scripts\engine\utility::getsharedfunc("chopper_exfil", "music_exfil_end")]](heli.playersinside);
  }

  wait 6.5;
  heli.playersexfil = [];

  foreach(player in heli.playersinside) {
    if(!isDefined(player)) {
      continue;
    }

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      player scripts\mp\gametypes\br_public::function_c2afa687bc871d71(1);
    }

    heli.playersexfil[heli.playersexfil.size] = player;
    playersleft = 1;
  }

  info = namespace_e8fceb5cf6e8cdf8::function_730c660d9fc6808e(heli.playersexfil, finalexfil, 0, istrue(ent.info.personal), 0);
  info.var_394aebba88e4e8c2 = ent.var_394aebba88e4e8c2;
  scripts\engine\utility::function_f3bb4f4911a1beb2("chopper_exfil", "exfil_players", heli.playersexfil, info);

  if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "music_reset")) {
    [[scripts\engine\utility::getsharedfunc("chopper_exfil", "music_reset")]](players);
  }

  wait 15;
  heli function_ed686fcbc5363b3();

  if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "remove_exfil")) {
    ent thread[[scripts\engine\utility::getsharedfunc("chopper_exfil", "remove_exfil")]](ent, playersleft);
  }

  if(isDefined(ent) && !istrue(ent.disabled) && isDefined(team)) {
    ent.inuse = 0;

    if(scripts\engine\utility::issharedfuncdefined("chopper_exfil", "reset_exfil")) {
      ent thread[[scripts\engine\utility::getsharedfunc("chopper_exfil", "reset_exfil")]](team);
    }
  }
}

function function_730c660d9fc6808e(players, finalexfil, hostageexfil, personalexfil, drivableexfil) {
  info = spawnStruct();
  info.players = players;
  info.finalexfil = finalexfil;
  info.hostageexfil = hostageexfil;
  info.personalexfil = personalexfil;
  info.drivableexfil = drivableexfil;
  return info;
}

function entisalivevehicle() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

function private function_ad65ea51ce655f42(vehicle, ent, position, normal, normalspeed) {
  if(self vehicle_getspeed() == 0) {
    return;
  }

  if(istrue(vehicle.var_496a5e00d32af675)) {
    return;
  }

  vehicle.var_496a5e00d32af675 = 1;
  vehicle.var_a8f4bb03b366aa80 = 1;
  vehicle thread scripts\cp_mp\vehicles\vehicle::vehicle_explode();
}