/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_teleport_grenade.gsc
****************************************************************/

init() {
  level._effect["teleport_equipment"] = loadfx("vfx/unique/dlc_teleport_grenade");
  level._effect["teleport_player"] = loadfx("vfx/unique/dlc_teleport_player");
  level.teleport_grenade_override_triggers = getEntArray("teleport_grenade_override_trigger", "targetname");
  level.teleport_grenade_ignore_triggers = getEntArray("trigger_underwater", "targetname");
}

onplayerspawn() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  self notify("onPlayerSpawnTeleportGrenade");
  self endon("onPlayerSpawnTeleportGrenade");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    if(var_2 != "teleport_zombies_mp" && var_2 != "teleport_throw_zombies_mp") {
      continue;
    }
    thread doteleport(var_0, var_1);
  }
}

grenadewaitformisslestuck() {
  self endon("death");
  thread grenadetimeout();
  self waittill("missile_stuck", var_0);
  return var_0;
}

grenadetimeout() {
  self endon("missile_stuck");
  self endon("death");
  wait 4;
  self notify("missile_stuck");
}

doteleport(var_0, var_1) {
  self notify("doTeleportGrenade");
  self endon("doTeleportGrenade");
  thread playerteleportgrenadecleanup(var_0);
  var_2 = var_0.origin;
  var_3 = var_0 grenadewaitformisslestuck();

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(level.zmbteleportgrenadestuckcustom)) {
    if([[level.zmbteleportgrenadestuckcustom]](var_0, var_1, self)) {
      return;
    }
  }

  var_4 = var_0.origin;
  var_5 = var_0.angles;
  var_0 delete();

  if(maps\mp\zombies\_util::gameflagexists("sq_plinko") && maps\mp\_utility::gameflag("sq_plinko") && isDefined(var_3) && isDefined(var_3.script_noteworthy) && issubstr(var_3.script_noteworthy, "gate_")) {
    return;
  } else if(isDefined(var_3) && maps\mp\zombies\_util::is_true(var_3.noteleportgrenade)) {
    return;
  }
  if(!isDefined(self) || maps\mp\zombies\_util::isplayerinlaststand(self) || !isalive(self)) {
    return;
  }
  if(isDefined(level.zmplayeraltteleport)) {
    if(self[[level.zmplayeraltteleport]](var_4, var_5, var_2)) {
      return;
    }
  }

  doteleportinstant(var_4, var_5, var_2, var_1, var_3);
}

playerteleportgrenadecleanup(var_0) {
  var_0 endon("death");
  var_0 endon("missile_stuck");
  common_scripts\utility::waittill_any("doTeleportGrenade", "disconnect");
  playFX(common_scripts\utility::getfx("teleport_equipment"), var_0.origin);
  var_0 delete();
}

playerteleport(var_0, var_1) {
  if(isDefined(var_0)) {
    givecoast2coastachievement(var_0);
    self setorigin(var_0, 1);
  }

  if(isDefined(var_1)) {
    self setangles(var_1);
  }

  thread playerteleportaudio();
  playfxontagforclients(common_scripts\utility::getfx("teleport_player"), self, "tag_origin", self);
}

doteleportinstant(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self.origin;
  playFX(common_scripts\utility::getfx("teleport_equipment"), var_0);
  var_6 = gettime();
  var_7 = findsafeposition(var_0, var_1, var_2);
  var_8 = gettime();

  if(isDefined(var_7)) {
    var_9 = (var_8 - var_6) / 1000.0;

    if(var_9 < 0.2) {
      wait(0.2 - var_9);
    }

    playerteleport(var_7);
    self playrumbleonentity("damage_heavy");
    earthquake(randomfloatrange(0.25, 0.35), 1, self.origin, 100, self);
    playertelefragzombie(var_4, var_7);
    self radiusdamage(var_7, 300, 200 * level.wavecounter, 100 * level.wavecounter, self, "MOD_EXPLOSIVE", "teleport_zombies_mp");
    thread playerteleportedvo();
    thread playerfixgoingunderwater();
  } else {
    var_10 = self getweaponammoclip(var_3);
    self setweaponammoclip(var_3, var_10 + 1);
  }
}

playerfixgoingunderwater() {
  if(isDefined(self.underwatermotiontype)) {
    self.underwater = undefined;
    self.isswimming = undefined;
    self.iswading = undefined;
    self notify("above_water");
    playFX(level._effect["water_splash_emerge"], self.origin, anglesToForward((0, self.angles[1], 0) + (270, 180, 0)));

    if(maps\mp\zombies\_util::is_true(self.isshocked)) {
      self stopshellshock();
      self.isshocked = undefined;
    }

    maps\mp\_water::playerdisableunderwater();

    if(maps\mp\_utility::isaugmentedgamemode()) {
      maps\mp\_water::enableexo();
    }
  }
}

givecoast2coastachievement(var_0) {
  if(maps\mp\_utility::getmapname() != "mp_zombie_h2o") {
    return;
  }
  var_1 = "start";
  var_2 = "zone_04";
  var_3 = self.currentzone;
  var_4 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(var_0);

  if(!isDefined(var_3) || !isDefined(var_4)) {
    return;
  }
  if(var_3 == var_1 && var_4 == var_2 || var_3 == var_2 && var_4 == var_1) {
    maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_COAST2COAST");
  }
}

playertelefragzombie(var_0, var_1) {
  if(!isDefined(var_0) || !isagent(var_0) || !isalive(var_0) || !isDefined(var_0.team) || var_0.team != level.enemyteam || !isDefined(var_0.agent_type)) {
    return;
  }
  if(var_0 maps\mp\zombies\_util::instakillimmune()) {
    return;
  }
  var_0 dodamage(var_0.health + 1, var_1, self, self, "MOD_CRUSH", "teleport_zombies_mp");
}

playerteleportaudio() {
  self playsoundtoplayer("teleport_player", self);
  self playsoundtoteam("teleport_npc", "allies", self);
}

findsafeposition(var_0, var_1, var_2) {
  if(maps\mp\zombies\_util::isplayerteleporting(self)) {
    return;
  }
  foreach(var_4 in level.teleport_grenade_override_triggers) {
    if(ispointinvolume(var_0, var_4)) {
      var_5 = common_scripts\utility::getstruct(var_4.target, "targetname");
      return var_5.origin;
    }
  }

  foreach(var_4 in level.teleport_grenade_ignore_triggers) {
    if(ispointinvolume(var_0, var_4)) {
      return;
    }
  }

  var_9 = findlastzone(var_0, var_1, var_2);

  if(!isDefined(var_9)) {
    return;
  }
  var_10 = maps\mp\zombies\_zombies_zone_manager::ispointinanyzonereturn(var_0, 1);

  if(isDefined(var_10) && var_10 == var_9) {
    var_11 = anglestoup(var_1);
    var_12 = var_11[2] > 0.8;

    if(var_12 && teleporttrace(var_0, self)) {
      return var_0;
    }
  }

  var_13 = vectornormalize(var_2 - var_0);
  var_14 = var_0 + var_13 * 30;
  var_15 = 50;
  var_16 = 0;
  var_17 = 100;
  var_18 = 50;
  var_19 = getclosestnodeteleport(var_0, var_16, var_15, var_17, var_18, 0, var_9);
  var_15 = 1500;
  var_18 = 1000;

  if(!isDefined(var_19)) {
    var_19 = getclosestnodeteleport(var_14, var_16, var_15, var_17, var_18, 1, var_9);
  }

  if(!isDefined(var_19)) {
    var_19 = getclosestnodeteleport(var_14, var_16, var_15, var_17, var_18, 0, var_9);
  }

  if(isDefined(var_19)) {
    return var_19.origin;
  }
}

findlastzone(var_0, var_1, var_2) {
  var_3 = 100;
  var_4 = 0;
  var_5 = var_2 - var_0;
  var_6 = length(var_5);
  var_7 = vectornormalize(var_5);

  if(isDefined(level.zmbteleportgrenadefindzonecustom)) {
    var_8 = [[level.zmbteleportgrenadefindzonecustom]](var_0, var_1, var_2);

    if(isDefined(var_8)) {
      return var_8;
    }
  }

  for(;;) {
    var_9 = var_0 + var_7 * var_4;
    var_10 = maps\mp\zombies\_zombies_zone_manager::ispointinanyzonereturn(var_9, 1);

    if(isDefined(var_10) && maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_10)) {
      return var_10;
    }

    if(var_4 == var_6) {
      break;
    }

    var_4 = var_4 + var_3;

    if(var_4 > var_6) {
      var_4 = var_6;
    }
  }

  var_10 = maps\mp\zombies\_zombies_zone_manager::getplayerzone();

  if(isDefined(var_10)) {
    return var_10;
  }
}

getclosestnodeteleport(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 200;
  var_8 = var_1;
  var_9 = var_1 + var_3;
  var_10 = gettime() + var_7;
  var_11 = 3;
  var_12 = 0;

  while(var_9 < var_2 || var_8 < var_2) {
    var_13 = getnodesinradius(var_0, var_9, var_8, var_4);

    if(var_13.size > 0) {
      if(var_13.size > 1) {
        var_13 = sortbydistance(var_13, var_0, undefined, 1);
      }

      foreach(var_15 in var_13) {
        if(isDefined(var_15.zombieszone) && !maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_15.zombieszone)) {
          continue;
        }
        if(isDefined(var_15.zombieszone) && var_6 != var_15.zombieszone) {
          continue;
        }
        if(var_12 >= var_11) {
          if(gettime() >= var_10) {
            return;
          }
          var_12 = 0;
          waitframe();
        }

        var_16 = 1;

        if(var_5) {
          var_17 = bulletTrace(var_0, var_15.origin, 0, self, 0, 0, 0, 0, 0, 0, 0);
          var_12++;
          var_16 = var_17["fraction"] == 1;
        }

        if(var_16) {
          if(maps\mp\zombies\_util::nodeisinspawncloset(var_15)) {
            if(var_5) {
              var_18 = findnodeoutsideofspawncloset(var_15, var_6);

              if(isDefined(var_18)) {
                return var_18;
              }
            }

            continue;
          }

          return var_15;
        }
      }
    }

    var_8 = var_8 + var_3;
    var_9 = var_9 + var_3;

    if(var_9 > var_2) {
      var_9 = var_2;
    }

    if(var_8 == var_9) {
      break;
    }
  }
}

findnodeoutsideofspawncloset(var_0, var_1) {
  var_2 = getlinkednodes(var_0);
  var_3 = [var_0];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];

    if(!maps\mp\zombies\_util::nodeisinspawncloset(var_5) && var_5.zombieszone == var_1) {
      return var_5;
    }

    var_3[var_3.size] = var_5;

    if(maps\mp\zombies\_util::nodeisinspawncloset(var_5)) {
      var_6 = getlinkednodes(var_5);

      foreach(var_8 in var_6) {
        if(common_scripts\utility::array_contains(var_3, var_8) || common_scripts\utility::array_contains(var_2, var_8)) {
          continue;
        }
        var_2[var_2.size] = var_8;
      }
    }
  }
}

teleporttrace(var_0, var_1, var_2) {
  var_3 = 30;

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  foreach(var_5 in level.orbitaldropmarkers) {
    var_6 = var_3 * 2;
    var_7 = var_6 * var_6;
    var_8 = distance2dsquared(var_5.origin, var_0);

    if(var_8 < var_7) {
      return 0;
    }
  }

  var_10 = playerphysicstraceinfo(var_0, var_0, var_1);
  return var_10["fraction"] == 1;
}

playerteleportedvo() {
  self endon("disconnect");
  wait 0.4;
  var_0 = 0;

  if(!isDefined(self.firstteleport)) {
    var_0 = 1;
    self.firstteleport = 1;
  }

  maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "teleport_use", undefined, undefined, var_0);
}