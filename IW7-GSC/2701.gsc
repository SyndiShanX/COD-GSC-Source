/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2701.gsc
**************************************/

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

  setupselfvo();
  level.bcsounds = [];
  level.bcsounds["reload"] = "inform_reloading_generic";
  level.bcsounds["frag_out"] = "inform_attack_grenade";
  level.bcsounds["flash_out"] = "inform_attack_flashbang";
  level.bcsounds["smoke_out"] = "inform_attack_smoke";
  level.bcsounds["conc_out"] = "inform_attack_stun";
  level.bcsounds["c4_plant"] = "inform_attack_thwc4";
  level.bcsounds["claymore_plant"] = "inform_plant_claymore";
  level.bcsounds["semtex_out"] = "semtex_use";
  level.bcsounds["kill"] = "inform_killfirm_infantry";
  level.bcsounds["casualty"] = "reaction_casualty_generic";
  level.bcsounds["suppressing_fire"] = "cmd_suppressfire";
  level.bcsounds["moving"] = "order_move_combat";
  level.bcsounds["callout_generic"] = "threat_infantry_generic";
  level.bcsounds["callout_response_generic"] = "response_ack_yes";
  level.bcsounds["damage"] = "inform_taking_fire";
  level.bcsounds["semtex_incoming"] = "semtex_incoming";
  level.bcsounds["c4_incoming"] = "c4_incoming";
  level.bcsounds["flash_incoming"] = "flash_incoming";
  level.bcsounds["stun_incoming"] = "stun_incoming";
  level.bcsounds["grenade_incoming"] = "grenade_incoming";
  level.bcsounds["rpg_incoming"] = "rpg_incoming";
  level.bcsounds = [];
  level.bcsounds["timeout"]["suppressing_fire"] = 5000;
  level.bcsounds["timeout"]["moving"] = 45000;
  level.bcsounds["timeout"]["callout_generic"] = 15000;
  level.bcsounds["timeout"]["callout_location"] = 3000;
  level.bcsounds["timeout_player"]["suppressing_fire"] = 10000;
  level.bcsounds["timeout_player"]["moving"] = 120000;
  level.bcsounds["timeout_player"]["callout_generic"] = 5000;
  level.bcsounds["timeout_player"]["callout_location"] = 5000;

  foreach(var_5, var_4 in level.speakers) {
    level.bcsounds["last_say_time"][var_5]["suppressing_fire"] = -99999;
    level.bcsounds["last_say_time"][var_5]["moving"] = -99999;
    level.bcsounds["last_say_time"][var_5]["callout_generic"] = -99999;
    level.bcsounds["last_say_time"][var_5]["callout_location"] = -99999;
    level.bcsounds["last_say_pos"][var_5]["suppressing_fire"] = (0, 0, -9000);
    level.bcsounds["last_say_pos"][var_5]["moving"] = (0, 0, -9000);
    level.bcsounds["last_say_pos"][var_5]["callout_generic"] = (0, 0, -9000);
    level.bcsounds["last_say_pos"][var_5]["callout_location"] = (0, 0, -9000);
    level.var_13526[var_5][""] = 0;
    level.var_13526[var_5]["w"] = 0;
  }

  scripts\common\bcs_location_trigs::bcs_location_trigs_init();
  scripts\mp\bcs_location_trigs::bcs_location_trigs_init();
  var_6 = getdvar("g_gametype");
  level.istactical = 1;

  if(var_6 == "war" || var_6 == "kc" || var_6 == "dom") {
    level.istactical = 0;
  }

  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_1 = var_0 getrankedplayerdata("common", "gender");

    if(var_1) {
      var_0.gender = "female";
    } else {
      var_0.gender = "male";
    }

    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    self.bcsounds = [];
    self.bcsounds["last_say_time"]["suppressing_fire"] = -99999;
    self.bcsounds["last_say_time"]["moving"] = -99999;
    self.bcsounds["last_say_time"]["callout_generic"] = -99999;
    self.bcsounds["last_say_time"]["callout_location"] = -99999;

    if(scripts\mp\utility\game::func_9D48("archetype_heavy")) {
      var_0 = "HV_";
    } else if(scripts\mp\utility\game::func_9D48("archetype_scout")) {
      var_0 = "SN_";
    } else if(scripts\mp\utility\game::func_9D48("archetype_assassin")) {
      var_0 = "FT_";
    } else if(scripts\mp\utility\game::func_9D48("archetype_engineer")) {
      var_0 = "N6_";
    } else if(scripts\mp\utility\game::func_9D48("archetype_sniper")) {
      var_0 = "GH_";
    } else if(scripts\mp\utility\game::func_9D48("archetype_assault")) {
      var_0 = "AS_";
    } else {
      var_0 = "AS_";
    }

    var_1 = scripts\mp\teams::getcustomization();

    if(isDefined(var_1)) {
      var_2 = var_1["body"];

      if(isDefined(var_2)) {
        switch (var_2) {
          case "mp_ftl_hero_valley_girl_body":
            var_0 = "N6_";
            break;
          case "body_mp_ghost_zombies":
            var_0 = "N6_";
            break;
        }
      }
    }

    var_3 = !isagent(self) && !scripts\mp\utility\game::isfemale();
    self.pers["voicePrefix"] = var_0 + var_3 + "_";

    if(level.splitscreen) {
      continue;
    }
    if(!level.teambased) {
      continue;
    }
    if(scripts\mp\utility\game::isanymlgmatch()) {
      self.bcdisabled = 1;
      continue;
    }

    thread claymoretracking();
    thread func_DF5F();
    thread func_85E5();
    thread func_85D1();
    thread suppressingfiretracking();
    thread func_3B20();
    thread func_4D73();
    thread sprinttracking();
    thread func_117E1();
  }
}

func_85D1() {
  self endon("disconnect");
  self endon("death");
  var_0 = self.origin;
  var_1 = 147456;

  for(;;) {
    var_2 = scripts\engine\utility::ter_op(isDefined(level.grenades), level.grenades, []);
    var_3 = scripts\engine\utility::ter_op(isDefined(level.missiles), level.missiles, []);

    if(var_2.size + var_3.size < 1 || !scripts\mp\utility\game::isreallyalive(self)) {
      wait 0.05;
      continue;
    }

    var_2 = scripts\engine\utility::array_combine(var_2, var_3);

    foreach(var_5 in var_2) {
      wait 0.05;

      if(!isDefined(var_5)) {
        continue;
      }
      if(isDefined(var_5.weapon_name)) {
        switch (var_5.weapon_name) {
          case "mobile_radar_mp":
          case "motion_sensor_mp":
          case "proximity_explosive_mp":
          case "throwingreaper_mp":
          case "throwingknifesmokewall_mp":
          case "throwingknifeteleport_mp":
          case "trophy_mp":
          case "smoke_grenade_mp":
          case "throwingknife_mp":
          case "blackhole_grenade_mp":
          case "throwingknifec4_mp":
            continue;
        }

        if(weaponinventorytype(var_5.weapon_name) != "offhand" && weaponclass(var_5.weapon_name) == "grenade") {
          continue;
        }
        if(!isDefined(var_5.owner)) {
          var_5.owner = getmissileowner(var_5);
        }

        if(isDefined(var_5.owner) && level.teambased && var_5.owner.team == self.team) {
          continue;
        }
        var_6 = distancesquared(var_5.origin, self.origin);

        if(var_6 < var_1) {
          if(scripts\engine\utility::cointoss()) {
            wait 5;
            continue;
          }

          if(bullettracepassed(var_5.origin, self.origin, 0, self)) {
            if(var_5.weapon_name == "concussion_grenade_mp" || var_5.weapon_name == "sensor_grenade_mp") {
              level thread saylocalsound(self, "stun_incoming");
              wait 5;
              continue;
            }

            if(var_5.weapon_name == "flash_grenade_mp") {
              level thread saylocalsound(self, "flash_incoming");
              wait 5;
              continue;
            }

            if(weaponclass(var_5.weapon_name) == "rocketlauncher") {
              level thread saylocalsound(self, "rpg_incoming");
              wait 5;
              continue;
            }

            if(var_5.weapon_name == "c4_mp") {
              level thread saylocalsound(self, "c4_incoming");
              wait 5;
              continue;
            }

            if(var_5.weapon_name == "semtex_mp") {
              level thread saylocalsound(self, "semtex_incoming");
              wait 5;
              continue;
            }

            level thread saylocalsound(self, "grenade_incoming");
            wait 5;
          }
        }
      }
    }
  }
}

suppressingfiretracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = undefined;

  for(;;) {
    self waittill("begin_firing");
    thread suppresswaiter();
    thread suppresstimeout();
    self waittill("stoppedFiring");
  }
}

suppresstimeout() {
  thread waitsuppresstimeout();
  self endon("begin_firing");
  self waittill("end_firing");
  wait 0.3;
  self notify("stoppedFiring");
}

waitsuppresstimeout() {
  self endon("stoppedFiring");
  self waittill("begin_firing");
  thread suppresstimeout();
}

suppresswaiter() {
  self notify("suppressWaiter");
  self endon("suppressWaiter");
  self endon("death");
  self endon("disconnect");
  self endon("stoppedFiring");
  wait 1;

  if(cansay("suppressing_fire")) {
    level thread saylocalsound(self, "suppressing_fire");
  }
}

claymoretracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("begin_firing");
    var_0 = self getcurrentweapon();

    if(var_0 == "claymore_mp") {
      level thread saylocalsound(self, "claymore_plant");
    }
  }
}

func_DF5F() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("reload_start");
    level thread saylocalsound(self, "reload");
  }
}

func_85E5() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "frag_grenade_mp") {
      level thread saylocalsound(self, "frag_out");
      continue;
    }

    if(var_1 == "semtex_mp") {
      level thread saylocalsound(self, "semtex_out");
      continue;
    }

    if(var_1 == "cluster_grenade_mp") {
      level thread saylocalsound(self, "frag_out");
      continue;
    }

    if(var_1 == "flash_grenade_mp") {
      level thread saylocalsound(self, "flash_out");
      continue;
    }

    if(var_1 == "concussion_grenade_mp" || var_1 == "sensor_grenade_mp") {
      level thread saylocalsound(self, "conc_out");
      continue;
    }

    if(var_1 == "smoke_grenade_mp" || var_1 == "gas_grenade_mp") {
      level thread saylocalsound(self, "smoke_out");
      continue;
    }

    if(var_1 == "c4_mp") {
      level thread saylocalsound(self, "c4_plant");
    }
  }
}

sprinttracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("sprint_begin");

    if(cansay("moving")) {
      level thread saylocalsound(self, "moving", 0, 0);
    }
  }
}

func_4D73() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(!isDefined(var_1.classname)) {
      continue;
    }
    if(var_1 != self && var_1.classname != "worldspawn") {
      wait 1.5;
      level thread saylocalsound(self, "damage");
      wait 3;
    }
  }
}

func_3B20() {
  self endon("disconnect");
  self endon("faux_spawn");
  self waittill("death");

  foreach(var_1 in level.participants) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 == self) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_1)) {
      continue;
    }
    if(!isDefined(self.team)) {
      continue;
    }
    if(var_1.team != self.team) {
      continue;
    }
    if(isagent(var_1)) {
      continue;
    }
    if(distancesquared(self.origin, var_1.origin) <= 262144) {
      level thread saylocalsounddelayed(var_1, "casualty", 0.75);
      break;
    }
  }
}

func_117E1() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("enemy_sighted");

    if(getomnvar("ui_prematch_period")) {
      level waittill("prematch_over");
      continue;
    }

    if(!cansay("callout_location") && !cansay("callout_generic")) {
      continue;
    }
    var_0 = self getsightedplayers();

    if(!isDefined(var_0)) {
      continue;
    }
    var_1 = 0;
    var_2 = 4000000;

    if(self playerads() > 0.7) {
      var_2 = 6250000;
    }

    foreach(var_4 in var_0) {
      if(isDefined(var_4) && scripts\mp\utility\game::isreallyalive(var_4) && !var_4 scripts\mp\utility\game::_hasperk("specialty_coldblooded") && distancesquared(self.origin, var_4.origin) < var_2) {
        var_5 = var_4 getvalidlocation(self);
        var_1 = 1;

        if(isDefined(var_5) && cansay("callout_location") && friendly_nearby(4840000)) {
          if(scripts\mp\utility\game::_hasperk("specialty_quieter") || !friendly_nearby(262144)) {
            level thread saylocalsound(self, var_5.locationaliases[0], 0);
          } else {
            level thread saylocalsound(self, var_5.locationaliases[0], 1);
          }

          break;
        }
      }
    }

    if(var_1 && cansay("callout_generic")) {
      level thread saylocalsound(self, "callout_generic");
      level thread saytoself(self, "plr_target_generic", undefined, 0.75);
    }
  }
}

saylocalsounddelayed(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_0 endon("disconnect");
  wait(var_2);
  saylocalsound(var_0, var_1, var_3, var_4);
}

saylocalsound(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(scripts\mp\utility\game::istrue(var_0.bcdisabled)) {
    return;
  }
  if(isspeakerinrange(var_0)) {
    return;
  }
  if(var_0.team != "spectator") {
    var_4 = var_0.pers["voicePrefix"];

    if(isDefined(level.bcsounds[var_1])) {
      var_5 = var_4 + level.bcsounds[var_1];
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
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = self.pers["team"];
  level addspawnviewer(self, var_3);
  var_4 = !level.istactical || !scripts\mp\utility\game::_hasperk("specialty_coldblooded") && (isagent(self) || self issighted());

  if(var_2 && var_4) {
    if(isagent(self) || level.alivecount[var_3] > 3) {
      thread func_5AB1(var_0, var_3);
    }
  }

  if(isagent(self) || isDefined(var_1) && var_1) {
    self playsoundtoteam(var_0, var_3);
  } else {
    self playsoundtoteam(var_0, var_3, self);
  }

  thread timehack(var_0);
  scripts\engine\utility::waittill_any(var_0, "death", "disconnect");
  level removespeaker(self, var_3);
}

func_5AB1(var_0, var_1) {
  var_2 = spawn("script_origin", self.origin + (0, 0, 256));
  var_3 = var_0 + "_n";

  if(soundexists(var_3)) {
    foreach(var_5 in level.teamnamelist) {
      if(var_5 != var_1) {
        var_2 playsoundtoteam(var_3, var_5);
      }
    }
  }

  wait 3;
  var_2 delete();
}

dothreatcalloutresponse(var_0, var_1) {
  var_2 = scripts\engine\utility::waittill_any_return(var_0, "death", "disconnect");

  if(var_2 == var_0) {
    var_3 = self.team;
    var_4 = self.pers["voicePrefix"];
    var_5 = self.origin;
    wait 0.5;

    foreach(var_7 in level.participants) {
      if(!isDefined(var_7)) {
        continue;
      }
      if(var_7 == self) {
        continue;
      }
      if(!scripts\mp\utility\game::isreallyalive(var_7)) {
        continue;
      }
      if(var_7.team != var_3) {
        continue;
      }
      var_8 = var_7.pers["voicePrefix"];

      if(!isDefined(var_8)) {
        continue;
      }
      if(var_8 != var_4 && distancesquared(var_5, var_7.origin) <= 262144 && !isspeakerinrange(var_7)) {
        var_9 = var_8 + "co_loc_" + var_1 + "_echo";

        if(soundexists(var_9) && scripts\engine\utility::cointoss()) {
          var_10 = var_9;
        } else {
          var_10 = var_8 + level.bcsounds["callout_response_generic"];
        }

        var_7 thread dosound(var_10, 0, 1);
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

  if(!isDefined(var_1)) {
    var_1 = 1000;
  }

  var_2 = var_1 * var_1;

  if(isDefined(var_0) && isDefined(var_0.team) && var_0.team != "spectator") {
    for(var_3 = 0; var_3 < level.speakers[var_0.team].size; var_3++) {
      var_4 = level.speakers[var_0.team][var_3];

      if(var_4 == var_0) {
        return 1;
      }

      if(!isDefined(var_4)) {
        continue;
      }
      if(distancesquared(var_4.origin, var_0.origin) < var_2) {
        return 1;
      }
    }
  }

  return 0;
}

addspawnviewer(var_0, var_1) {
  level.speakers[var_1][level.speakers[var_1].size] = var_0;
}

removespeaker(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.speakers[var_1].size; var_3++) {
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

cansay(var_0) {
  var_1 = self.pers["team"];

  if(var_1 == "spectator") {
    return 0;
  }

  var_2 = level.bcsounds["timeout_player"][var_0];
  var_3 = gettime() - self.bcsounds["last_say_time"][var_0];

  if(var_2 > var_3) {
    return 0;
  }

  var_2 = level.bcsounds["timeout"][var_0];
  var_3 = gettime() - level.bcsounds["last_say_time"][var_1][var_0];

  if(var_2 < var_3) {
    return 1;
  }

  return 0;
}

updatechatter(var_0) {
  var_1 = self.pers["team"];
  self.bcsounds["last_say_time"][var_0] = gettime();
  level.bcsounds["last_say_time"][var_1][var_0] = gettime();
  level.bcsounds["last_say_pos"][var_1][var_0] = self.origin;
}

func_12EC1(var_0) {}

getlocation() {
  var_0 = get_all_my_locations();
  var_0 = scripts\engine\utility::array_randomize(var_0);

  if(var_0.size) {
    foreach(var_2 in var_0) {
      if(!location_called_out_ever(var_2)) {
        return var_2;
      }
    }

    foreach(var_2 in var_0) {
      if(!location_called_out_recently(var_2)) {
        return var_2;
      }
    }
  }

  return undefined;
}

getvalidlocation(var_0) {
  var_1 = get_all_my_locations();
  var_1 = scripts\engine\utility::array_randomize(var_1);

  if(var_1.size) {
    foreach(var_3 in var_1) {
      if(!location_called_out_ever(var_3) && var_0 cancalloutlocation(var_3)) {
        return var_3;
      }
    }

    foreach(var_3 in var_1) {
      if(!location_called_out_recently(var_3) && var_0 cancalloutlocation(var_3)) {
        return var_3;
      }
    }
  }

  return undefined;
}

get_all_my_locations() {
  var_0 = anim.bcs_locations;
  var_1 = self getistouchingentities(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.locationaliases)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

update_bcs_locations() {
  if(isDefined(anim.bcs_locations)) {
    anim.bcs_locations = scripts\engine\utility::array_removeundefined(anim.bcs_locations);
  }
}

is_in_callable_location() {
  var_0 = get_all_my_locations();

  foreach(var_2 in var_0) {
    if(!location_called_out_recently(var_2)) {
      return 1;
    }
  }

  return 0;
}

location_called_out_ever(var_0) {
  var_1 = location_get_last_callout_time(var_0.locationaliases[0]);

  if(!isDefined(var_1)) {
    return 0;
  }

  return 1;
}

location_called_out_recently(var_0) {
  var_1 = location_get_last_callout_time(var_0.locationaliases[0]);

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = var_1 + 25000;

  if(gettime() < var_2) {
    return 1;
  }

  return 0;
}

location_add_last_callout_time(var_0) {
  anim.locationlastcallouttimes[var_0] = gettime();
}

location_get_last_callout_time(var_0) {
  if(isDefined(anim.locationlastcallouttimes[var_0])) {
    return anim.locationlastcallouttimes[var_0];
  }

  return undefined;
}

cancalloutlocation(var_0) {
  foreach(var_2 in var_0.locationaliases) {
    var_3 = getloccalloutalias("co_loc_" + var_2);
    var_4 = getqacalloutalias(var_2, 0);
    var_5 = getloccalloutalias("concat_loc_" + var_2);
    var_6 = soundexists(var_3) || soundexists(var_4) || soundexists(var_5);

    if(var_6) {
      return var_6;
    }
  }

  return 0;
}

canconcat(var_0) {
  var_1 = var_0.locationaliases;

  foreach(var_3 in var_1) {
    if(iscallouttypeconcat(var_3, self)) {
      return 1;
    }
  }

  return 0;
}

getcannedresponse(var_0) {
  var_1 = undefined;
  var_2 = self.locationaliases;

  foreach(var_4 in var_2) {
    if(iscallouttypeqa(var_4, var_0) && !isDefined(self.qafinished)) {
      var_1 = var_4;
      break;
    }

    if(iscallouttypereport(var_4)) {
      var_1 = var_4;
    }
  }

  return var_1;
}

iscallouttypereport(var_0) {
  return issubstr(var_0, "_report");
}

iscallouttypeconcat(var_0, var_1) {
  var_2 = var_1 getloccalloutalias("concat_loc_" + var_0);

  if(soundexists(var_2)) {
    return 1;
  }

  return 0;
}

iscallouttypeqa(var_0, var_1) {
  if(issubstr(var_0, "_qa") && soundexists(var_0)) {
    return 1;
  }

  var_2 = var_1 getqacalloutalias(var_0, 0);

  if(soundexists(var_2)) {
    return 1;
  }

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
  if(!isDefined(var_0)) {
    var_0 = 262144;
  }

  foreach(var_2 in level.players) {
    if(var_2.team == self.pers["team"]) {
      if(var_2 != self && distancesquared(var_2.origin, self.origin) <= var_0) {
        return 1;
      }
    }
  }

  return 0;
}

setupselfvo() {
  level.selfvomap = [];
  level.selfvomap["plr_killfirm_c6"] = "kill_rig";
  level.selfvomap["plr_killfirm_ftl"] = "kill_rig";
  level.selfvomap["plr_killfirm_ghost"] = "kill_rig";
  level.selfvomap["plr_killfirm_merc"] = "kill_rig";
  level.selfvomap["plr_killfirm_stryker"] = "kill_rig";
  level.selfvomap["plr_killfirm_warfighter"] = "kill_rig";
  level.selfvomap["plr_killfirm_generic"] = "kill_gen";
  level.selfvomap["plr_killfirm_amf"] = "kill_amf";
  level.selfvomap["plr_killfirm_headshot"] = "kill_headshot";
  level.selfvomap["plr_killfirm_grenade"] = "kill_grenade";
  level.selfvomap["plr_killfirm_rival"] = "kill_rival";
  level.selfvomap["plr_killfirm_semtex"] = "kill_semtex";
  level.selfvomap["plr_killfirm_multi"] = "kill_multi";
  level.selfvomap["plr_killfirm_twofer"] = "kill_twofer";
  level.selfvomap["plr_killfirm_threefer"] = "kill_threefer";
  level.selfvomap["plr_killfirm_killstreak"] = "kill_ss";
  level.selfvomap["plr_killstreak_destroy"] = "kill_other_ss";
  level.selfvomap["plr_killstreak_target"] = "targeted_by_ss";
  level.selfvomap["plr_hit_back"] = "dmg_back";
  level.selfvomap["plr_damaged_light"] = "dmg_light";
  level.selfvomap["plr_damaged_heavy"] = "dmg_heavy";
  level.selfvomap["plr_damaged_emp"] = "dmg_emp";
  level.selfvomap["plr_healing"] = "healing";
  level.selfvomap["plr_kd_high"] = "kd_high";
  level.selfvomap["plr_firefight"] = "firefight";
  level.selfvomap["plr_target_generic"] = "enemy_sighted";
  level.selfvomap["plr_perk_super"] = "super_activate";
  level.selfvomap["plr_perk_trophy"] = "super_activate";
  level.selfvomap["plr_perk_turret"] = "super_activate";
  level.selfvomap["plr_perk_amplify"] = "super_activate";
  level.selfvomap["plr_perk_overdrive"] = "super_activate";
  level.selfvomap["plr_perk_ftl"] = "super_activate";
  level.selfvomap["plr_perk_pulse"] = "super_activate";
  level.selfvomap["plr_perk_rewind"] = "super_activate";
  level.selfvomap["plr_perk_super_kill"] = "super_kill";
  level.selfvomap["plr_perk_trophy_block"] = "super_kill";
  level.selfvomap["plr_perk_turret_kill"] = "super_kill";
  level.selfvomap["plr_killfirm_shift"] = "super_kill";
  level.selfvomap["plr_perk_railgun"] = "super_kill";
  level.selfvomap["plr_perk_stealth"] = "super_kill";
  level.selfvomap["plr_perk_armor"] = "super_kill";
  level.selfvomap["plr_perk_charge"] = "super_kill";
  level.selfvomap["plr_perk_dragon"] = "super_kill";
  level.selfvomap["plr_perk_pound"] = "super_kill";
  level.selfvomap["plr_perk_reaper"] = "super_kill";
  level.selfvoinfo = [];
  setselfvoinfo("kill_rig", 15, 0.3, 0.25);
  setselfvoinfo("kill_gen", 30, 0.1, 0.25);
  setselfvoinfo("kill_amf", 15, 0.5, 0.5);
  setselfvoinfo("kill_headshot", 15, 0.7, 0.25);
  setselfvoinfo("kill_grenade", 15, 0.5, 0.25);
  setselfvoinfo("kill_rival", 15, 0.7, 0.25);
  setselfvoinfo("kill_semtex", 15, 0.5, 0.25);
  setselfvoinfo("kill_multi", 20, 0.6, 0.25);
  setselfvoinfo("kill_twofer", 10, 0.7, 0.75);
  setselfvoinfo("kill_threefer", 10, 0.8, 0.75);
  setselfvoinfo("kill_ss", 10, 0.5, 0.2);
  setselfvoinfo("kill_other_ss", 10, 0.7, 0.75);
  setselfvoinfo("targeted_by_ss", 10, 0.4, 0.33);
  setselfvoinfo("dmg_back", 20, 0.5, 0.5);
  setselfvoinfo("dmg_light", 20, 0.4, 0.1);
  setselfvoinfo("dmg_heavy", 20, 0.5, 0.2);
  setselfvoinfo("healing", 10, 0.3, 0.1);
  setselfvoinfo("kd_high", 20, 0.7, 0.8);
  setselfvoinfo("enemy_sighted", 20, 0.2, 0.25);
  setselfvoinfo("firefight", 10, 0.4, 0.33);
  setselfvoinfo("super_activate", 10, 1.0, 1.0);
  setselfvoinfo("super_kill", 10, 0.9, 0.66);
}

setselfvoinfo(var_0, var_1, var_2, var_3) {
  level.selfvoinfo[var_0]["timeout"] = var_1;
  level.selfvoinfo[var_0]["priority"] = var_2;
  level.selfvoinfo[var_0]["chance"] = var_3;
}

saytoself(var_0, var_1, var_2, var_3) {
  if(isagent(var_0) || !isplayer(var_0)) {
    return;
  }
  if(scripts\mp\utility\game::istrue(var_0.bcdisabled)) {
    return;
  }
  var_4 = var_0.pers["voicePrefix"] + var_1;

  if(!isDefined(var_1) || !soundexists(var_4)) {
    if(!isDefined(var_2)) {
      return;
    }
    var_1 = var_2;
    var_4 = var_0.pers["voicePrefix"] + var_1;

    if(!soundexists(var_4)) {
      return;
    }
  }

  if(!isDefined(var_0.selfvohistory)) {
    var_0.selfvohistory = [];
    var_0.playingselfvo = 0;
    var_0.queuedvo = "none";
  }

  if(isDefined(var_0.selfvohistory[level.selfvomap[var_1]]) && var_0.selfvohistory[level.selfvomap[var_1]] > 0) {
    return;
  }
  if(!isDefined(var_0.pers["selfVOBonusChance"])) {
    var_0 thread updateselfvobonuschance();
  }

  if(randomfloat(1.0) > level.selfvoinfo[level.selfvomap[var_1]]["chance"] + var_0.pers["selfVOBonusChance"]) {
    return;
  }
  var_0 thread trysetqueuedselfvo(var_1, var_3);
}

updateselfvobonuschance() {
  self endon("disconnect");
  level endon("game_ended");
  self.pers["selfVOBonusChance"] = 0;

  for(;;) {
    self.pers["selfVOBonusChance"] = self.pers["selfVOBonusChance"] + 0.1;
    wait 3.0;
  }
}

trysetqueuedselfvo(var_0, var_1) {
  self endon("death");
  self endon("disconnect");

  if(self.queuedvo == var_0) {
    return;
  }
  if(self.queuedvo == "none" || level.selfvoinfo[level.selfvomap[self.queuedvo]]["priority"] < level.selfvoinfo[level.selfvomap[var_0]]["priority"] || level.selfvoinfo[level.selfvomap[self.queuedvo]]["priority"] == level.selfvoinfo[level.selfvomap[var_0]]["priority"] && scripts\engine\utility::cointoss()) {
    self.queuedvo = var_0;
  } else {
    return;
  }

  self notify("addToSelfVOQueue");
  self endon("addToSelfVOQueue");
  self.selfvodelaycomplete = 1;

  if(isDefined(var_1)) {
    thread selfvodelay(var_1);
  }

  var_2 = getprioritywaittime(var_0);
  var_3 = gettime();

  while(self.playingselfvo || !self.selfvodelaycomplete || var_2 > gettime()) {
    if(gettime() > var_3 + 2000) {
      self.queuedvo = "none";
      return;
    }

    wait 0.05;
  }

  scripts\engine\utility::waitframe();
  thread playselfvo(var_0);
}

getprioritywaittime(var_0) {
  if(!isDefined(self.lastselfvotime)) {
    self.lastselfvotime = 0;
  }

  return self.lastselfvotime + 2000 + 10000 * (1.0 - level.selfvoinfo[level.selfvomap[var_0]]["priority"]);
}

selfvodelay(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("addToSelfVOQueue");
  self.selfvodelaycomplete = 0;
  wait(var_0);
  self.selfvodelaycomplete = 1;
}

playselfvo(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = self.pers["voicePrefix"] + var_0;
  self.pers["selfVOBonusChance"] = 0;
  self.queuedvo = "none";
  var_2 = lookupsoundlength(var_1) / 1000;
  self.lastselfvotime = gettime();
  thread playingselfvotracking(var_2);
  thread updateselfvohistory(var_0);
  self playsoundtoplayer(var_1, self);
}

playingselfvotracking(var_0) {
  self endon("disconnect");
  self.playingselfvo = 1;
  wait(var_0);
  self.playingselfvo = 0;
}

updateselfvohistory(var_0) {
  self endon("disconnect");
  self.selfvohistory[level.selfvomap[var_0]] = gettime();
  wait(level.selfvoinfo[level.selfvomap[var_0]]["timeout"]);
  self.selfvohistory[level.selfvomap[var_0]] = 0;
}