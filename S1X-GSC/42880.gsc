/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42880.gsc
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

  level.bcsounds = [];
  level.bcsounds["reload"] = "inform_reloading_generic";
  level.bcsounds["frag_out"] = "inform_attack_grenade";
  level.bcsounds["semtex_out"] = "semtex_use";
  level.bcsounds["conc_out"] = "inform_attack_stun";
  level.bcsounds["smoke_out"] = "inform_attack_smoke";
  level.bcsounds["emp_out"] = "emp_use";
  level.bcsounds["threat_out"] = "threat_use";
  level.bcsounds["drone_out"] = "inform_drone_use";
  level.bcsounds["grenade_incoming"] = "grenade_incoming";
  level.bcsounds["semtex_incoming"] = "semtex_incoming";
  level.bcsounds["stun_incoming"] = "stun_incoming";
  level.bcsounds["emp_incoming"] = "incoming_emp";
  level.bcsounds["drone_incoming"] = "inform_drone_enemy";
  level.bcsounds["exo_cloak_use"] = "inform_cloaking_use";
  level.bcsounds["exo_overclock_use"] = "inform_overclock_use";
  level.bcsounds["exo_ping_use"] = "exo_ping";
  level.bcsounds["exo_shield_use"] = "exo_shield_use";
  level.bcsounds["callout_generic"] = "threat_infantry_generic";
  level.bcsounds["callout_sniper"] = "threat_sniper_generic";
  level.bcsounds["callout_hover"] = "enemy_hover";
  level.bcsounds["callout_shield"] = "exo_shield_enemy";
  level.bcsounds["callout_cloak"] = "inform_cloaking_enemy";
  level.bcsounds["callout_overclock"] = "inform_overclock_enemy";
  level.bcsounds["callout_response_generic"] = "response_ack_yes";
  level.bcsounds["kill"] = "inform_killfirm_infantry";
  level.bcsounds["casualty"] = "inform_casualty_generic";
  level.bcsounds["suppressing_fire"] = "cmd_suppressfire";
  level.bcsounds["moving"] = "order_move_combat";
  level.bcsounds["damage"] = "inform_taking_fire";
  level.bcinfo = [];
  level.bcinfo["timeout"]["suppressing_fire"] = 5000;
  level.bcinfo["timeout"]["moving"] = 45000;
  level.bcinfo["timeout"]["callout_generic"] = 15000;
  level.bcinfo["timeout"]["callout_location"] = 3000;
  level.bcinfo["timeout_player"]["suppressing_fire"] = 10000;
  level.bcinfo["timeout_player"]["moving"] = 120000;
  level.bcinfo["timeout_player"]["callout_generic"] = 5000;
  level.bcinfo["timeout_player"]["callout_location"] = 5000;

  foreach(var_5, var_4 in level.speakers) {
    level.bcinfo["last_say_time"][var_5]["suppressing_fire"] = -99999;
    level.bcinfo["last_say_time"][var_5]["moving"] = -99999;
    level.bcinfo["last_say_time"][var_5]["callout_generic"] = -99999;
    level.bcinfo["last_say_time"][var_5]["callout_location"] = -99999;
    level.bcinfo["last_say_pos"][var_5]["suppressing_fire"] = (0, 0, -9000);
    level.bcinfo["last_say_pos"][var_5]["moving"] = (0, 0, -9000);
    level.bcinfo["last_say_pos"][var_5]["callout_generic"] = (0, 0, -9000);
    level.bcinfo["last_say_pos"][var_5]["callout_location"] = (0, 0, -9000);
    level.voice_count[var_5][""] = 0;
    level.voice_count[var_5]["w"] = 0;
  }

  common_scripts\_bcs_location_trigs::bcs_location_trigs_init();
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
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    self.bcinfo = [];
    self.bcinfo["last_say_time"]["suppressing_fire"] = -99999;
    self.bcinfo["last_say_time"]["moving"] = -99999;
    self.bcinfo["last_say_time"]["callout_generic"] = -99999;
    self.bcinfo["last_say_time"]["callout_location"] = -99999;
    var_0 = maps\mp\gametypes\_teams::getteamvoiceprefix(self.team);

    if(level.currentgen) {
      var_1 = 5;
      var_2 = 3;
    } else {
      var_1 = 9;
      var_2 = 5;
    }

    var_3 = "";

    if(!isagent(self) && self hasfemalecustomizationmodel()) {
      var_3 = "w";
    }

    self.pers["voiceNum"] = level.voice_count[self.team][var_3];

    if(var_3 == "w") {
      level.voice_count[self.team][var_3] = (level.voice_count[self.team][var_3] + 1) % var_2;
    } else {
      level.voice_count[self.team][var_3] = (level.voice_count[self.team][var_3] + 1) % var_1;
    }

    self.pers["voicePrefix"] = var_0 + var_3 + self.pers["voiceNum"] + "_";

    if(level.splitscreen) {
      continue;
    }
    if(!level.teambased) {
      continue;
    }
    thread reloadtracking();
    thread grenadetracking();
    thread grenadeproximitytracking();
    thread exoabilitytracking();
    thread suppressingfiretracking();
    thread casualtytracking();
    thread damagetracking();
    thread sprinttracking();
    thread threatcallouttracking();
  }
}

grenadeproximitytracking() {
  self endon("disconnect");
  self endon("death");
  var_0 = self.origin;
  var_1 = 147456;

  for(;;) {
    if(common_scripts\utility::cointoss()) {
      wait 5;
      continue;
    }

    var_2 = common_scripts\utility::ter_op(isDefined(level.grenades), level.grenades, []);
    var_3 = common_scripts\utility::ter_op(isDefined(level.missiles), level.missiles, []);
    var_4 = common_scripts\utility::ter_op(isDefined(level.trackingdrones), level.trackingdrones, []);

    if(var_2.size + var_3.size + var_4.size < 1 || !maps\mp\_utility::isreallyalive(self)) {
      wait 0.05;
      continue;
    }

    var_2 = common_scripts\utility::array_combine(var_2, var_3);
    var_2 = common_scripts\utility::array_combine(var_2, var_4);

    if(var_2.size < 1) {
      wait 0.05;
      continue;
    }

    foreach(var_6 in var_2) {
      wait 0.05;

      if(!isDefined(var_6)) {
        continue;
      }
      var_7 = isDefined(var_6.type) && (var_6.type == "explosive_drone" || var_6.type == "tracking_drone");

      if(isDefined(var_6.weaponname)) {
        switch (var_6.weaponname) {
          case "gamemode_ball":
            continue;
        }

        if(weaponinventorytype(var_6.weaponname) != "offhand" && weaponclass(var_6.weaponname) == "grenade") {
          continue;
        }
      }

      if(!isDefined(var_6.owner) && !var_7) {
        var_6.owner = getmissileowner(var_6);
      }

      if(isDefined(var_6.owner) && isDefined(var_6.owner.team) && level.teambased && var_6.owner.team == self.team) {
        continue;
      }
      var_8 = distancesquared(var_6.origin, self.origin);

      if(var_8 < var_1) {
        if(bullettracepassed(var_6.origin, self.origin, 0, self)) {
          var_9 = "";

          if(var_7) {
            var_9 = "drone_incoming";
          } else if(isDefined(var_6.weaponname)) {
            switch (var_6.weaponname) {
              case "semtex_mp":
                var_9 = "semtex_incoming";
                break;
              case "stun_grenade_var_mp":
              case "stun_grenade_mp":
                var_9 = "stun_incoming";
                break;
              case "emp_grenade_var_mp":
              case "emp_grenade_mp":
                var_9 = "emp_incoming";
            }
          }

          if(var_9 == "") {
            var_9 = "grenade_incoming";
          }

          level thread saylocalsound(self, var_9);
          wait 5;
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
    self notify("stoppedFiring");
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

reloadtracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("reload_start");
    level thread saylocalsound(self, "reload");
  }
}

grenadetracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    if(var_2 == "frag_grenade_mp" || var_2 == "frag_grenade_var_mp" || var_2 == "contact_grenade_var_mp") {
      level thread saylocalsound(self, "frag_out");
      continue;
    }

    if(var_2 == "semtex_mp" || var_2 == "semtex_grenade_var_mp") {
      level thread saylocalsound(self, "semtex_out");
      continue;
    }

    if(var_2 == "explosive_drone_mp" || var_2 == "tracking_drone_mp") {
      level thread saylocalsound(self, "drone_out");
      continue;
    }

    if(var_2 == "concussion_grenade_mp" || var_2 == "stun_grenade_mp" || var_2 == "stun_grenade_var_mp") {
      level thread saylocalsound(self, "conc_out");
      continue;
    }

    if(var_2 == "smoke_grenade_mp" || var_2 == "smoke_grenade_var_mp") {
      level thread saylocalsound(self, "smoke_out");
      continue;
    }

    if(var_2 == "emp_grenade_mp" || var_2 == "emp_grenade_var_mp") {
      level thread saylocalsound(self, "emp_out");
      continue;
    }

    if(var_2 == "paint_grenade_mp" || var_2 == "paint_grenade_var_mp") {
      level thread saylocalsound(self, "threat_out");
    }
  }
}

exoabilitytracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = maps\mp\_exo_shield::get_exo_shield_weapon();
  var_1 = maps\mp\_exo_cloak::get_exo_cloak_weapon();
  var_2 = "exoping_equipment_mp";

  for(;;) {
    var_3 = common_scripts\utility::waittill_any_return_parms("grenade_pullback", "grenade_fire", "exo_adrenaline_fire");
    waitframe();

    if(var_3[0] == "grenade_pullback" && isDefined(var_3[1]) && var_3[1] == var_0 && isDefined(self.exo_shield_on) && self.exo_shield_on) {
      level thread saylocalsound(self, "exo_shield_use");
      continue;
    }

    if(var_3[0] == "grenade_fire" && isDefined(var_3[2]) && var_3[2] == var_1 && isDefined(self.exo_cloak_on) && self.exo_cloak_on) {
      level thread saylocalsound(self, "exo_cloak_use");
      continue;
    }

    if(var_3[0] == "grenade_fire" && isDefined(var_3[2]) && var_3[2] == var_2 && isDefined(self.exo_ping_on) && self.exo_ping_on) {
      level thread saylocalsound(self, "exo_ping_use");
      continue;
    }

    if(var_3[0] == "exo_adrenaline_fire" && isDefined(self.overclock_on) && self.overclock_on) {
      level thread saylocalsound(self, "exo_overclock_use");
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

damagetracking() {
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
    if(isDefined(level.ishorde) && level.ishorde && isDefined(var_1.agent_type) && var_1.agent_type == "dog") {
      continue;
    }
    if(var_1 != self && var_1.classname != "worldspawn") {
      wait 1.5;
      level thread saylocalsound(self, "damage");
      wait 3;
    }
  }
}

casualtytracking() {
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = self.team;
  self waittill("death");

  foreach(var_2 in level.participants) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(var_2 == self) {
      continue;
    }
    if(!maps\mp\_utility::isreallyalive(var_2)) {
      continue;
    }
    if(var_2.team != var_0) {
      continue;
    }
    if(isDefined(self) && distancesquared(self.origin, var_2.origin) <= 262144) {
      level thread saylocalsounddelayed(var_2, "casualty", 0.75);
      break;
    }
  }
}

threatcallouttracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("enemy_sighted");

    if(getdvarint("ui_inprematch")) {
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
    var_1 = undefined;
    var_2 = 4000000;

    if(self playerads() > 0.7) {
      var_2 = 6250000;
    }

    foreach(var_4 in var_0) {
      if(isDefined(var_4) && maps\mp\_utility::isreallyalive(var_4) && !var_4 maps\mp\_utility::_hasperk("specialty_coldblooded") && distancesquared(self.origin, var_4.origin) < var_2) {
        var_5 = var_4 getvalidlocation(self);
        var_1 = var_4;

        if(isDefined(var_5) && cansay("callout_location") && friendly_nearby(4840000)) {
          if(maps\mp\_utility::_hasperk("specialty_quieter") || !friendly_nearby(262144)) {
            level thread saylocalsound(self, var_5.locationaliases[0], 0);
          } else {
            level thread saylocalsound(self, var_5.locationaliases[0], 1);
          }

          break;
        }
      }
    }

    if(isDefined(var_1) && cansay("callout_generic")) {
      var_7 = var_1 getcurrentprimaryweapon();
      var_8 = var_1 iscloaked();
      var_9 = isDefined(var_1.exo_hover_on) && var_1.exo_hover_on;
      var_10 = isDefined(var_1.overclock_on) && var_1.overclock_on;
      var_11 = isDefined(var_1.exo_shield_on) && var_1.exo_shield_on;
      var_11 = var_11 || isDefined(self.frontshieldmodel);
      var_12 = weaponclass(var_7) == "sniper";

      if(var_8) {
        level thread saylocalsound(self, "callout_cloak");
      } else if(var_9) {
        level thread saylocalsound(self, "callout_hover");
      } else if(var_10) {
        level thread saylocalsound(self, "callout_overclock");
      } else if(var_11) {
        level thread saylocalsound(self, "callout_shield");
      } else if(var_12) {
        level thread saylocalsound(self, "callout_sniper");
      } else {
        level thread saylocalsound(self, "callout_generic");
      }
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

  if(isDefined(level.chatterdisabled) && level.chatterdisabled) {
    return;
  }
  if(isDefined(var_0.bcdisabled) && var_0.bcdisabled == 1) {
    return;
  }
  if(isspeakerinrange(var_0)) {
    return;
  }
  if(var_0 maps\mp\killstreaks\_juggernaut::get_is_in_mech()) {
    return;
  }
  if(var_0.team != "spectator") {
    var_4 = var_0.pers["voicePrefix"];

    if(isDefined(level.bcsounds[var_1])) {
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
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = self.pers["team"];
  level addspeaker(self, var_3);
  var_4 = !level.istactical || !maps\mp\_utility::_hasperk("specialty_coldblooded") && (isagent(self) || self issighted());

  if(var_2 && var_4) {
    if(isagent(self) || level.alivecount[var_3] > 3) {
      thread dosounddistant(var_0, var_3);
    }
  }

  if(!soundexists(var_0)) {
    level removespeaker(self, var_3);
    return;
  }

  if(isagent(self) || isDefined(var_1) && var_1) {
    self playsoundtoteam(var_0, var_3);
  } else {
    self playsoundtoteam(var_0, var_3, self);
  }

  thread timehack(var_0);
  common_scripts\utility::waittill_any(var_0, "death", "disconnect");
  level removespeaker(self, var_3);
}

dosounddistant(var_0, var_1) {
  if(soundexists(var_0)) {
    foreach(var_3 in level.teamnamelist) {
      if(var_3 != var_1) {
        self playsoundtoteam(var_0, var_3);
      }
    }
  }
}

dothreatcalloutresponse(var_0, var_1) {
  var_2 = common_scripts\utility::waittill_any_return(var_0, "death", "disconnect");

  if(var_2 == var_0) {
    var_3 = self.team;

    if(!isagent(self)) {
      var_4 = self hasfemalecustomizationmodel();
    } else {
      var_4 = 0;
    }

    var_5 = self.pers["voiceNum"];
    var_6 = self.origin;
    wait 0.5;

    foreach(var_8 in level.participants) {
      if(!isDefined(var_8)) {
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
      if(!isagent(var_8)) {
        var_9 = var_8 hasfemalecustomizationmodel();
      } else {
        var_9 = 0;
      }

      if((var_5 != var_8.pers["voiceNum"] || var_4 != var_9) && distancesquared(var_6, var_8.origin) <= 262144 && !isspeakerinrange(var_8)) {
        var_10 = var_8.pers["voicePrefix"];
        var_11 = var_10 + "co_loc_" + var_1 + "_echo";

        if(common_scripts\utility::cointoss() && soundexists(var_11)) {
          var_12 = var_11;
        } else {
          var_12 = var_10 + level.bcsounds["callout_response_generic"];
        }

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

addspeaker(var_0, var_1) {
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

  var_2 = level.bcinfo["timeout_player"][var_0];
  var_3 = gettime() - self.bcinfo["last_say_time"][var_0];

  if(var_2 > var_3) {
    return 0;
  }

  var_2 = level.bcinfo["timeout"][var_0];
  var_3 = gettime() - level.bcinfo["last_say_time"][var_1][var_0];

  if(var_2 < var_3) {
    return 1;
  }

  return 0;
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
  var_1 = common_scripts\utility::array_randomize(var_1);

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
    anim.bcs_locations = common_scripts\utility::array_removeundefined(anim.bcs_locations);
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