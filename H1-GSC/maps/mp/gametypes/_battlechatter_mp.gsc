/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_battlechatter_mp.gsc
***************************************************/

init() {
  if(level.multiteambased) {
    foreach(var_1 in level.teamnamelist) {
      level.isteamspeaking[var_1] = 0;
      level.speakers[var_1] = [];
    }
  } else {
    level.isteamspeaking["allies"] = 0;
    level.isteamspeaking["axis"] = 0;
    level.speakers["allies"] = [];
    level.speakers["axis"] = [];
  }

  level.bcsounds = [];
  level.bcsounds["reload"] = "inform_reloading_generic";
  level.bcsounds["frag_out"] = "inform_attack_grenade";
  level.bcsounds["flash_out"] = "inform_attack_flashbang";
  level.bcsounds["smoke_out"] = "inform_attack_smoke";
  level.bcsounds["conc_out"] = "inform_attack_stun";
  level.bcsounds["c4_plant"] = "inform_attack_thwc4";
  level.bcsounds["claymore_plant"] = "inform_plant_claymore";
  level.bcsounds["kill"] = "inform_killfirm_infantry";
  level.bcinfo = [];

  foreach(var_5, var_4 in level.speakers) {
    level.voice_count[var_5]["m"] = 0;
    level.voice_count[var_5]["fe"] = 0;
  }

  var_6 = getdvar("g_gametype");
  level.istactical = 1;

  if(var_6 == "war" || var_6 == "conf" || var_6 == "dom")
    level.istactical = 0;

  level thread onplayerconnect();
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for (;;) {
    self waittill("spawned_player");

    if(maps\mp\_utility::is_true(level.virtuallobbyactive)) {
      continue;
    }
    self.bcinfo = [];
    var_0 = maps\mp\gametypes\_teams::getteamvoiceprefix(self.team);

    if(!isdefined(self.pers["voiceIndex"])) {
      var_1 = 4;
      var_2 = 4;
      var_3 = "m";

      if(!isagent(self) && self hasfemalecustomizationmodel())
        var_3 = "fe";

      self.pers["voiceNum"] = level.voice_count[self.team][var_3] + 1;

      if(var_3 == "fe")
        level.voice_count[self.team][var_3] = (level.voice_count[self.team][var_3] + 1) % var_2;
      else
        level.voice_count[self.team][var_3] = (level.voice_count[self.team][var_3] + 1) % var_1;

      self.pers["voicePrefix"] = var_0 + self.pers["voiceNum"] + var_3 + "_";
    }

    if(level.splitscreen) {
      continue;
    }
    if(!level.teambased) {
      continue;
    }
    thread reloadtracking();
    thread grenadetracking();
    thread claymoretracking();
  }
}

reloadtracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for (;;) {
    self waittill("reload_start");
    level thread saylocalsound(self, "reload", 0);
  }
}

grenadetracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for (;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "h1_fraggrenade_mp") {
      level thread saylocalsound(self, "frag_out", 0);
      continue;
    }

    if(var_1 == "h1_flashgrenade_mp") {
      level thread saylocalsound(self, "flash_out", 0);
      continue;
    }

    if(var_1 == "h1_concussiongrenade_mp") {
      level thread saylocalsound(self, "conc_out", 0);
      continue;
    }

    if(var_1 == "h1_smokegrenade_mp") {
      level thread saylocalsound(self, "smoke_out", 0);
      continue;
    }

    if(var_1 == "h1_c4_mp")
      level thread saylocalsound(self, "c4_plant", 0);
  }
}

claymoretracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for (;;) {
    self waittill("begin_firing");
    var_0 = self getcurrentweapon();

    if(var_0 == "h1_claymore_mp")
      level thread saylocalsound(self, "claymore_plant", 0);
  }
}

saylocalsounddelayed(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_0 endon("disconnect");
  wait(var_2);

  if(!isdefined(var_3) && isdefined(0))
    var_3 = 0;

  saylocalsound(var_0, var_1, var_3, var_4);
}

saylocalsound(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(isdefined(level.chatterdisabled) && level.chatterdisabled) {
    return;
  }
  if(isdefined(var_0.bcdisabled) && var_0.bcdisabled == 1) {
    return;
  }
  if(isspeakerinrange(var_0)) {
    return;
  }
  if(var_0.team != "spectator") {
    var_4 = var_0.pers["voicePrefix"];

    if(isdefined(level.bcsounds[var_1])) {
      var_5 = var_4 + level.bcsounds[var_1];

      switch (var_1) {
        case "callout_overclock":
        case "callout_cloak":
        case "callout_shield":
        case "callout_hover":
        case "callout_sniper":
          var_1 = "callout_generic";
          break;
      }
    } else {
      location_add_last_callout_time(var_1);
      var_5 = var_4 + "co_loc_" + var_1;
      var_0 thread dothreatcalloutresponse(var_5, var_1);
      var_1 = "callout_location";
    }

    var_0 updatechatter(var_1);
    var_0 thread dosound(var_5, var_2, var_3);
  }
}

dosound(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 0;

  var_3 = self.pers["team"];
  level addspeaker(self, var_3);

  if(var_2 && (!level.istactical || !maps\mp\_utility::_hasperk("specialty_coldblooded") && (isagent(self) || self issighted()))) {
    if(isagent(self) || level.alivecount[var_3] > 3)
      thread dosounddistant(var_0, var_3);
  }

  if(!soundexists(var_0)) {
    level removespeaker(self, var_3);
    return;
  }

  if(isagent(self) || isdefined(var_1) && var_1)
    self playsoundtoteam(var_0, var_3);
  else
    self playsoundtoteam(var_0, var_3, self);

  thread timehack(var_0);
  common_scripts\utility::waittill_any(var_0, "death", "disconnect");
  level removespeaker(self, var_3);
}

dosounddistant(var_0, var_1) {
  if(soundexists(var_0)) {
    foreach(var_3 in level.teamnamelist) {
      if(var_3 != var_1)
        self playsoundtoteam(var_0, var_3);
    }
  }
}

dothreatcalloutresponse(var_0, var_1) {
  var_2 = common_scripts\utility::waittill_any_return(var_0, "death", "disconnect");

  if(var_2 == var_0) {
    var_3 = self.team;

    if(!isagent(self))
      var_4 = self hasfemalecustomizationmodel();
    else
      var_4 = 0;

    var_5 = self.pers["voiceNum"];
    var_6 = self.origin;
    wait 0.5;

    foreach(var_8 in level.participants) {
      if(!isdefined(var_8)) {
        continue;
      }
      if(var_8 == self) {
        continue;
      }
      if(!maps\mp\_utility::isreallyalive(var_8)) {
        continue;
      }
      if(var_8.team != var_3) {
        continue;
      }
      if(!isagent(var_8))
        var_9 = var_8 hasfemalecustomizationmodel();
      else
        var_9 = 0;

      if((var_5 != var_8.pers["voiceNum"] || var_4 != var_9) && distancesquared(var_6, var_8.origin) <= 262144 && !isspeakerinrange(var_8)) {
        var_10 = var_8.pers["voicePrefix"];
        var_11 = var_10 + "co_loc_" + var_1 + "_echo";

        if(common_scripts\utility::cointoss() && soundexists(var_11))
          var_12 = var_11;
        else
          var_12 = var_10 + level.bcsounds["callout_response_generic"];

        var_8 thread dosound(var_12, 0, 0);
        break;
      }
    }
  }
}

timehack(var_0) {
  self endon("death");
  self endon("disconnect");
  wait 2.0;
  self notify(var_0);
}

isspeakerinrange(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!isdefined(var_1))
    var_1 = 1000;

  var_2 = var_1 * var_1;

  if(isdefined(var_0) && isdefined(var_0.team) && var_0.team != "spectator") {
    for (var_3 = 0; var_3 < level.speakers[var_0.team].size; var_3++) {
      var_4 = level.speakers[var_0.team][var_3];

      if(var_4 == var_0)
        return 1;

      if(!isdefined(var_4)) {
        continue;
      }
      if(distancesquared(var_4.origin, var_0.origin) < var_2)
        return 1;
    }
  }

  return 0;
}

addspeaker(var_0, var_1) {
  level.speakers[var_1][level.speakers[var_1].size] = var_0;
}

removespeaker(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < level.speakers[var_1].size; var_3++) {
    if(level.speakers[var_1][var_3] == var_0) {
      continue;
    }
    var_2[var_2.size] = level.speakers[var_1][var_3];
  }

  level.speakers[var_1] = var_2;
}

disablebattlechatter(var_0) {
  var_0.bcdisabled = 1;
}

enablebattlechatter(var_0) {
  var_0.bcdisabled = undefined;
}

updatechatter(var_0) {
  var_1 = self.pers["team"];
  self.bcinfo["last_say_time"][var_0] = gettime();
  level.bcinfo["last_say_time"][var_1][var_0] = gettime();
  level.bcinfo["last_say_pos"][var_1][var_0] = self.origin;
}

getlocation() {
  var_0 = get_all_my_locations();
  var_0 = common_scripts\utility::array_randomize(var_0);

  if(var_0.size) {
    foreach(var_2 in var_0) {
      if(!location_called_out_ever(var_2))
        return var_2;
    }

    foreach(var_2 in var_0) {
      if(!location_called_out_recently(var_2))
        return var_2;
    }
  }

  return undefined;
}

getvalidlocation(var_0) {
  var_1 = get_all_my_locations();
  var_1 = common_scripts\utility::array_randomize(var_1);

  if(var_1.size) {
    foreach(var_3 in var_1) {
      if(!location_called_out_ever(var_3) && var_0 cancalloutlocation(var_3))
        return var_3;
    }

    foreach(var_3 in var_1) {
      if(!location_called_out_recently(var_3) && var_0 cancalloutlocation(var_3))
        return var_3;
    }
  }

  return undefined;
}

get_all_my_locations() {
  var_0 = anim.bcs_locations;
  var_1 = self getistouchingentities(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isdefined(var_4.locationaliases))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

update_bcs_locations() {
  if(isdefined(anim.bcs_locations))
    anim.bcs_locations = common_scripts\utility::array_removeundefined(anim.bcs_locations);
}

is_in_callable_location() {
  var_0 = get_all_my_locations();

  foreach(var_2 in var_0) {
    if(!location_called_out_recently(var_2))
      return 1;
  }

  return 0;
}

location_called_out_ever(var_0) {
  var_1 = location_get_last_callout_time(var_0.locationaliases[0]);

  if(!isdefined(var_1))
    return 0;

  return 1;
}

location_called_out_recently(var_0) {
  var_1 = location_get_last_callout_time(var_0.locationaliases[0]);

  if(!isdefined(var_1))
    return 0;

  var_2 = var_1 + 25000;

  if(gettime() < var_2)
    return 1;

  return 0;
}

location_add_last_callout_time(var_0) {
  anim.locationlastcallouttimes[var_0] = gettime();
}

location_get_last_callout_time(var_0) {
  if(isdefined(anim.locationlastcallouttimes[var_0]))
    return anim.locationlastcallouttimes[var_0];

  return undefined;
}

cancalloutlocation(var_0) {
  foreach(var_2 in var_0.locationaliases) {
    var_3 = getloccalloutalias("co_loc_" + var_2);
    var_4 = getqacalloutalias(var_2, 0);
    var_5 = getloccalloutalias("concat_loc_" + var_2);
    var_6 = soundexists(var_3) || soundexists(var_4) || soundexists(var_5);

    if(var_6)
      return var_6;
  }

  return 0;
}

canconcat(var_0) {
  var_1 = var_0.locationaliases;

  foreach(var_3 in var_1) {
    if(iscallouttypeconcat(var_3, self))
      return 1;
  }

  return 0;
}

getcannedresponse(var_0) {
  var_1 = undefined;
  var_2 = self.locationaliases;

  foreach(var_4 in var_2) {
    if(iscallouttypeqa(var_4, var_0) && !isdefined(self.qafinished)) {
      var_1 = var_4;
      break;
    }

    if(iscallouttypereport(var_4))
      var_1 = var_4;
  }

  return var_1;
}

iscallouttypereport(var_0) {
  return issubstr(var_0, "_report");
}

iscallouttypeconcat(var_0, var_1) {
  var_2 = var_1 getloccalloutalias("concat_loc_" + var_0);

  if(soundexists(var_2))
    return 1;

  return 0;
}

iscallouttypeqa(var_0, var_1) {
  if(issubstr(var_0, "_qa") && soundexists(var_0))
    return 1;

  var_2 = var_1 getqacalloutalias(var_0, 0);

  if(soundexists(var_2))
    return 1;

  return 0;
}

getloccalloutalias(var_0) {
  var_1 = self.pers["voicePrefix"] + var_0;
  return var_1;
}

getqacalloutalias(var_0, var_1) {
  var_2 = getloccalloutalias(var_0);
  var_2 = var_2 + ("_qa" + var_1);
  return var_2;
}

battlechatter_canprint() {
  return 0;
}

battlechatter_canprintdump() {
  return 0;
}

battlechatter_print(var_0) {}

battlechatter_printdump(var_0) {}

battlechatter_debugprint(var_0) {}

getaliastypefromsoundalias(var_0) {}

battlechatter_printdumpline(var_0, var_1, var_2) {}

friendly_nearby(var_0) {
  if(!isdefined(var_0))
    var_0 = 262144;

  foreach(var_2 in level.players) {
    if(var_2.team == self.pers["team"]) {
      if(var_2 != self && distancesquared(var_2.origin, self.origin) <= var_0)
        return 1;
    }
  }

  return 0;
}