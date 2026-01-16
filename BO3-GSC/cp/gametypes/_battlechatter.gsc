/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_battlechatter.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\gametypes\_globallogic;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace battlechatter;

function autoexec __init__sytem__() {
  system::register("battlechatter", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype( & init);
  aispawnerarray = getactorspawnerarray();
  callback::on_ai_spawned( & on_joined_ai);
}

function init() {
  callback::on_spawned( & on_player_spawned);
  level.battlechatter_init = 1;
  level.allowbattlechatter = [];
  level.allowbattlechatter["bc"] = 1;
  level thread sndvehiclehijackwatcher();
}

function sndvehiclehijackwatcher() {
  while (true) {
    level waittill("clonedentity", clone, vehentnum);
    if(isdefined(clone) && isdefined(clone.archetype)) {
      vehiclename = clone.archetype;
      if(vehiclename == "wasp") {
        alias = "hijack_wasps";
      } else {
        if(vehiclename == "raps") {
          alias = "hijack_raps";
        } else {
          if(vehiclename == "quadtank") {
            alias = "hijack_quad";
          } else {
            alias = undefined;
          }
        }
      }
      nearbyenemy = get_closest_ai_to_object("axis", clone);
      if(isdefined(nearbyenemy) && isdefined(alias)) {
        level thread bc_makeline(nearbyenemy, alias);
      }
    }
  }
}

function on_joined_ai() {
  self endon("disconnect");
  if(isdefined(level.deadops) && level.deadops) {
    return;
  }
  if(isvehicle(self)) {
    return;
  }
  if(isdefined(self.archetype) && self.archetype == "zombie") {
    return;
  }
  if(isdefined(self.archetype) && self.archetype == "direwolf") {
    return;
  }
  if(!isdefined(self.voiceprefix)) {
    self.voiceprefix = "vox_ax";
  }
  if(isdefined(self.voiceprefix) && (self.voiceprefix == "vox_hend" || self.voiceprefix == "vox_khal" || self.voiceprefix == "vox_kane" || self.voiceprefix == "vox_hall" || self.voiceprefix == "vox_mare" || self.voiceprefix == "vox_diaz")) {
    self.bcvoicenumber = "";
  } else {
    if(self.voiceprefix == "vox_term") {
      self.bcvoicenumber = randomintrange(0, 3);
    } else {
      self.bcvoicenumber = randomintrange(0, 4);
    }
  }
  if(isdefined(self.archetype) && self.archetype == "warlord") {
    self thread function_c8397d24();
  }
  self.isspeaking = 0;
  self.soundmod = "player";
  self thread bc_ainotifyconvert();
  self thread bc_grenadewatcher();
  self thread bc_stickygrenadewatcher();
  if(!(isdefined(self.archetype) && self.archetype == "robot")) {
    self thread bc_death();
    self thread bc_scriptedline();
    if(isdefined(self.voiceprefix) && getsubstr(self.voiceprefix, 7) == "f") {
      self.bcvoicenumber = randomintrange(0, 2);
    }
  } else {
    self thread function_897d1130();
  }
}

function function_c8397d24() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while (true) {
    wait(randomintrange(6, 14));
    if(isdefined(self)) {
      linearray = array("action_peek", "action_moving", "enemy_contact");
      line = linearray[randomintrange(0, linearray.size)];
      level thread bc_makeline(self, line);
    }
  }
}

function bc_ainotifyconvert() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while (true) {
    self waittill("bhtn_action_notify", notify_string);
    switch (notify_string) {
      case "pain": {
        if(!(isdefined(self.archetype) && self.archetype == "robot")) {
          level thread bc_makeline(self, "exert_pain");
        }
        break;
      }
      case "concussiveReact": {
        if(!(isdefined(self.archetype) && self.archetype == "robot")) {
          level thread bc_makeline(self, "exert_cough", undefined, undefined, 1);
        }
        break;
      }
      case "enemyKill": {
        if(!(isdefined(self.archetype) && self.archetype == "robot") && (!(isdefined(self.voiceprefix) && (self.voiceprefix == "vox_germ" || self.voiceprefix == "vox_usa")))) {
          if(randomintrange(0, 100) <= 50) {
            level thread bc_makeline(self, "enemy_kill");
          }
        }
        break;
      }
      case "meleeKill": {
        if(!(isdefined(self.archetype) && self.archetype == "robot") && (!(isdefined(self.voiceprefix) && (self.voiceprefix == "vox_germ" || self.voiceprefix == "vox_usa")))) {
          if(randomintrange(0, 100) <= 50) {
            level thread bc_makeline(self, "melee_kill");
          }
        }
        break;
      }
      case "asp_incoming":
      case "hounds_incoming":
      case "manticore_incoming":
      case "orthrus_incoming":
      case "raps_incoming":
      case "robots_incoming":
      case "talon_incoming":
      case "technical_incoming": {
        if(!(isdefined(self.archetype) && self.archetype == "robot") && (!(isdefined(self.voiceprefix) && (self.voiceprefix == "vox_germ" || self.voiceprefix == "vox_usa")))) {
          level thread bc_makeline(self, notify_string);
        }
        break;
      }
      case "electrocute":
      case "pukeStart": {
        if(!(isdefined(self.archetype) && self.archetype == "robot")) {
          level thread bc_makeline(self, "exert_electrocution", undefined, undefined, 1);
        }
        break;
      }
      case "puke": {
        if(!(isdefined(self.archetype) && self.archetype == "robot")) {
          level thread bc_makeline(self, "exert_sonic", undefined, undefined, 1);
        }
        break;
      }
      case "scream": {
        if(!(isdefined(self.archetype) && self.archetype == "robot")) {
          level thread bc_makeline(self, "exert_scream");
        }
        break;
      }
      case "scriptedRobotvox": {
        if(isdefined(self.archetype) && self.archetype == "robot") {
          level thread bc_makeline(self, "action_intocover");
        }
        break;
      }
      case "reload": {
        if(randomintrange(0, 100) <= 20) {
          level thread bc_makeline(self, "action_reloading", 1);
        }
        break;
      }
      case "enemycontact": {
        self thread bc_enemycontact();
        break;
      }
      case "cover_shoot": {
        if(randomintrange(0, 100) <= 10) {
          level thread bc_makeline(self, "enemy_contact");
        }
        break;
      }
      case "cover_stance": {
        if(randomintrange(0, 100) <= 45) {
          level thread bc_makeline(self, "action_intocover");
        }
        break;
      }
      case "charge": {
        if(!(isdefined(self.archetype) && self.archetype == "robot")) {
          if(!(isdefined(self.voiceprefix) && (self.voiceprefix == "vox_hend" || self.voiceprefix == "vox_khal" || self.voiceprefix == "vox_kane" || self.voiceprefix == "vox_hall" || self.voiceprefix == "vox_mare" || self.voiceprefix == "vox_diaz"))) {
            soundalias = "vox_generic_exert_charge_male";
            if(isdefined(self.voiceprefix) && getsubstr(self.voiceprefix, 7) == "f") {
              soundalias = "vox_generic_exert_charge_female";
            }
            self thread do_sound(soundalias, 1);
          } else {
            level thread bc_makeline(self, "exert_charge");
          }
        }
        break;
      }
      case "attack_melee": {
        if(!(isdefined(self.archetype) && self.archetype == "robot")) {
          if(!(isdefined(self.voiceprefix) && (self.voiceprefix == "vox_hend" || self.voiceprefix == "vox_khal" || self.voiceprefix == "vox_kane" || self.voiceprefix == "vox_hall" || self.voiceprefix == "vox_mare" || self.voiceprefix == "vox_diaz"))) {
            soundalias = "vox_generic_exert_melee_male";
            if(isdefined(self.voiceprefix) && getsubstr(self.voiceprefix, 7) == "f") {
              soundalias = "vox_generic_exert_melee_female";
            }
            self thread do_sound(soundalias, 1);
          } else {
            level thread bc_makeline(self, "exert_melee");
          }
        }
        break;
      }
      case "blindfire": {
        level thread bc_makeline(self, "action_blindfire");
        break;
      }
      case "flanked": {
        level thread bc_makeline(self, "action_flanked");
        break;
      }
      case "peek":
      case "scan": {
        if(randomintrange(0, 100) <= 25) {
          level thread bc_makeline(self, "action_peek");
        }
        break;
      }
      case "exposed": {
        level thread bc_makeline(self, "action_exposed");
        break;
      }
      case "taking_cover": {
        if(randomintrange(0, 100) <= 75) {
          level thread bc_makeline(self, "action_intocover");
        }
        break;
      }
      case "moving_up": {
        if(randomintrange(0, 100) <= 6) {
          level thread bc_makeline(self, "action_moving");
        }
        break;
      }
      case "rbCharge":
      case "rbCrawler":
      case "rbPhalanx":
      case "rbTakeover": {
        level thread bc_makeline(self, "action_exposed");
        break;
      }
      case "rbJuke": {
        if(randomintrange(0, 100) <= 30) {
          level thread bc_makeline(self, "action_moving");
        }
        break;
      }
      case "firefly_swarm": {
        if(randomintrange(0, 100) <= 50) {
          level thread bc_makeline(self, "firefly_response");
        }
        if(randomintrange(0, 100) <= 50) {
          alliesguy = get_closest_ai_to_object("allies", self);
          if(isdefined(alliesguy)) {
            level util::delay(1, undefined, & bc_makeline, alliesguy, "firefly_response");
          }
        }
        break;
      }
      case "firefly_explode": {
        if(randomintrange(0, 100) <= 50) {
          teammate = get_closest_ai_on_sameteam(self);
          if(isdefined(teammate)) {
            level thread bc_makeline(teammate, "firefly_explode");
          }
        }
        break;
      }
      case "fireflyAttack": {
        level thread bc_makeline(self, "exert_firefly", undefined, undefined, 1);
        break;
      }
      case "fireflyAttackUpg": {
        level thread bc_makeline(self, "exert_firefly_burning", undefined, undefined, 1);
        break;
      }
      case "rapidstrike": {
        level thread bc_makeline(self, "rapidstrike_response");
        break;
      }
      case "warlord_angry":
      case "warlord_juke": {
        linearray = array("action_peek", "action_moving", "enemy_contact");
        line = linearray[randomintrange(0, linearray.size)];
        level thread bc_makeline(self, line);
        break;
      }
      case "reactImmolation": {
        level thread bc_makeline(self, "exert_immolation", undefined, undefined, 1);
        break;
      }
      case "reactImmolationLong": {
        level thread bc_makeline(self, "exert_immolation", undefined, undefined, 1);
        break;
      }
      case "reactSensory": {
        level thread bc_makeline(self, "exert_screaming", undefined, undefined, 1);
        break;
      }
      case "weaponmalfunction": {
        level thread bc_makeline(self, "exert_malfunction", undefined, undefined, 1);
        break;
      }
      case "reactExosuit": {
        level thread bc_makeline(self, "exert_breakdown", undefined, undefined, 1);
        break;
      }
      case "reactMisdirection": {
        break;
      }
      case "reactBodyBlow": {
        level thread bc_makeline(self, "exert_body_blow", undefined, undefined, 1);
        break;
      }
      default: {
        break;
      }
    }
  }
}

function bc_scriptedline() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while (true) {
    self waittill("scriptedbc", alias_suffix);
    level thread bc_makeline(self, alias_suffix);
  }
}

function bc_enemycontact() {
  self endon("death");
  self endon("disconnect");
  if(randomintrange(0, 100) <= 35) {
    if(!(isdefined(level.bc_enemycontact) && level.bc_enemycontact)) {
      level thread bc_makeline(self, "enemy_contact");
      level thread bc_enemycontact_wait();
    }
  }
}

function bc_enemycontact_wait() {
  level.bc_enemycontact = 1;
  wait(15);
  level.bc_enemycontact = 0;
}

function bc_grenadewatcher() {
  self endon("death");
  self endon("disconnect");
  while (true) {
    self waittill("grenade_fire", grenade, weapon);
    if(weapon.name == "frag_grenade" || weapon.name == "frag_grenade_invisible") {
      if(randomintrange(0, 100) <= 80 && !isplayer(self)) {
        level thread bc_makeline(self, "grenade_toss");
      }
      level thread bc_incominggrenadewatcher(self, grenade);
    }
  }
}

function bc_incominggrenadewatcher(thrower, grenade) {
  if(randomintrange(0, 100) <= 95) {
    wait(1);
    if(!isdefined(thrower) || !isdefined(grenade)) {
      return;
    }
    team = "axis";
    if(isdefined(thrower.team) && team == thrower.team) {
      team = "allies";
    }
    ai = get_closest_ai_to_object(team, grenade);
    if(isdefined(ai)) {
      level thread bc_makeline(ai, "grenade_incoming", 1);
    }
  }
}

function bc_stickygrenadewatcher() {
  self endon("death");
  self endon("disconnect");
  self endon("sticky_explode");
  while (true) {
    self waittill("grenade_stuck", grenade);
    if(isdefined(grenade)) {
      grenade.stucktoplayer = self;
    }
    if(isalive(self)) {
      level thread bc_makeline(self, "grenade_sticky");
    }
    break;
  }
}

function function_897d1130() {
  self endon("disconnect");
  self waittill("death", attacker, meansofdeath);
  if(isdefined(attacker) && !isplayer(attacker)) {
    if(meansofdeath == "MOD_MELEE") {
      attacker notify("bhtn_action_notify", "meleeKill");
    } else {
      attacker notify("bhtn_action_notify", "enemyKill");
    }
  }
}

function bc_death() {
  self endon("disconnect");
  self waittill("death", attacker, meansofdeath);
  if(isdefined(self)) {
    meleeassassinate = isdefined(meansofdeath) && meansofdeath == "MOD_MELEE_ASSASSINATE";
    if(isdefined(self.archetype) && self.archetype == "warlord") {
      self playsound("chr_warlord_death");
    }
    if(!(isdefined(self.quiet_death) && self.quiet_death) && !meleeassassinate && isdefined(attacker)) {
      if(meansofdeath == "MOD_ELECTROCUTED") {
        soundalias = ((self.voiceprefix + self.bcvoicenumber) + "_") + "exert_electrocution";
      } else {
        if(meansofdeath == "MOD_BURNED") {
          soundalias = ((self.voiceprefix + self.bcvoicenumber) + "_") + "exert_firefly_burning";
        } else {
          soundalias = ((self.voiceprefix + self.bcvoicenumber) + "_") + "exert_death";
        }
      }
      self thread do_sound(soundalias, 1);
    }
    if(isdefined(self.sndissniper) && self.sndissniper && isdefined(attacker) && !isplayer(attacker)) {
      level thread bc_makeline(attacker, "sniper_kill");
      return;
    }
    if(isdefined(attacker) && !isplayer(attacker)) {
      if(meansofdeath == "MOD_MELEE") {
        attacker notify("bhtn_action_notify", "meleeKill");
      } else {
        attacker notify("bhtn_action_notify", "enemyKill");
      }
    }
    sniper = isdefined(attacker) && isdefined(attacker.scoretype) && attacker.scoretype == "_sniper";
    if(!meleeassassinate && (sniper || randomintrange(0, 100) <= 35)) {
      close_ai = get_closest_ai_on_sameteam(self);
      if(isdefined(close_ai) && (!(isdefined(close_ai.quiet_death) && close_ai.quiet_death))) {
        if(sniper) {
          attacker.sndissniper = 1;
          level thread bc_makeline(close_ai, "sniper_threat");
        } else {
          level thread bc_makeline(close_ai, "friendly_down");
        }
      }
    }
  }
}

function bc_ainearexplodable(object, type) {
  wait(randomfloatrange(0.1, 0.4));
  ai = get_closest_ai_to_object("both", object, 500);
  if(isdefined(ai)) {
    if(type == "car") {
      level thread bc_makeline(ai, "destructible_car");
    } else {
      level thread bc_makeline(ai, "destructible_barrel");
    }
  }
}

function bc_robotbehindvox() {
  level endon("unloaded");
  self endon("death_or_disconnect");
  self endon("hash_f8c5dd60");
  if(!isdefined(level._bc_robotbehindvoxtime)) {
    level._bc_robotbehindvoxtime = 0;
    enemies = getaiteamarray("axis", "team3");
    level._bc_robotbehindarray = array();
    foreach(enemy in enemies) {
      if(isdefined(enemy.archetype) && enemy.archetype == "robot") {
        array::add(level._bc_robotbehindarray, enemy, 0);
      }
    }
  }
  while (true) {
    wait(1);
    t = gettime();
    if(t > (level._bc_robotbehindvoxtime + 1000)) {
      level._bc_robotbehindvoxtime = t;
      enemies = getaiteamarray("axis", "team3");
      array::remove_dead(level._bc_robotbehindarray);
      array::remove_undefined(level._bc_robotbehindarray);
      foreach(enemy in enemies) {
        if(isdefined(enemy.archetype) && enemy.archetype == "robot") {
          array::add(level._bc_robotbehindarray, enemy, 0);
        }
      }
    }
    if(level._bc_robotbehindarray.size <= 0) {
      continue;
    }
    played_sound = 0;
    foreach(robot in level._bc_robotbehindarray) {
      if(!isdefined(robot)) {
        continue;
      }
      if(distancesquared(robot.origin, self.origin) < 90000) {
        if(isdefined(robot.current_scene)) {
          continue;
        }
        if(isdefined(robot.health) && robot.health <= 0) {
          continue;
        }
        if(isdefined(level.scenes) && level.scenes.size >= 1) {
          continue;
        }
        yaw = self getyawtospot(robot.origin);
        diff = self.origin[2] - robot.origin[2];
        if(yaw < -95 || yaw > 95 && abs(diff) < 200) {
          robot playsound("chr_robot_behind");
          played_sound = 1;
          break;
        }
      }
    }
    if(played_sound) {
      wait(5);
    }
  }
}

function getyawtospot(spot) {
  pos = spot;
  yaw = self.angles[1] - getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

function getyaw(org) {
  angles = vectortoangles(org - self.origin);
  return angles[1];
}

function bc_makeline(ai, line, causeresponse, category, alwaysplay) {
  if(!isdefined(ai)) {
    return;
  }
  ai endon("death");
  ai endon("disconnect");
  response = undefined;
  if(isdefined(causeresponse)) {
    response = line + "_response";
  }
  if(!isdefined(ai.voiceprefix) || !isdefined(ai.bcvoicenumber)) {
    return;
  }
  if(isdefined(ai.archetype) && ai.archetype == "robot") {
    soundalias = ((ai.voiceprefix + ai.bcvoicenumber) + "_") + "chatter";
  } else {
    soundalias = ((ai.voiceprefix + ai.bcvoicenumber) + "_") + line;
  }
  ai thread do_sound(soundalias, alwaysplay, response, category);
}

function do_sound(soundalias, alwaysplay, response, category) {
  if(!isdefined(soundalias)) {
    return;
  }
  if(!isdefined(alwaysplay)) {
    alwaysplay = 0;
  }
  if(self bc_allowed(category) && (!(isdefined(self.isspeaking) && self.isspeaking) || alwaysplay)) {
    if(!isdefined(self.enemy) && !alwaysplay) {
      return;
    }
    function_20dcacc5();
    if(!isdefined(self)) {
      return;
    }
    if(isdefined(self.istalking) && self.istalking) {
      return;
    }
    if(isdefined(self.isspeaking) && self.isspeaking) {
      self notify("bc_interrupt");
    }
    if(isalive(self)) {
      self playsoundontag(soundalias, "J_neck");
    } else {
      self playsound(soundalias);
    }
    self thread wait_playback_time(soundalias);
    result = self util::waittill_any_return(soundalias, "death", "disconnect", "bc_interrupt");
    if(result == soundalias) {
      if(isdefined(response)) {
        ai = get_closest_ai_on_sameteam(self);
        if(isdefined(ai)) {
          level thread bc_makeline(ai, response);
        }
      }
    } else if(isdefined(self)) {
      self stopsound(soundalias);
    }
  }
}

function function_20dcacc5() {
  if(!isdefined(level.var_769cc2b1)) {
    level thread function_1af43712();
  }
  while (level.var_769cc2b1 != 0) {
    util::wait_network_frame();
  }
  level.var_769cc2b1++;
}

function function_1af43712() {
  while (true) {
    level.var_769cc2b1 = 0;
    util::wait_network_frame();
  }
}

function bc_allowed(str_category = "bc") {
  if(isdefined(level.allowbattlechatter) && (!(isdefined(level.allowbattlechatter[str_category]) && level.allowbattlechatter[str_category]))) {
    return false;
  }
  if(isdefined(self.allowbattlechatter) && (!(isdefined(self.allowbattlechatter[str_category]) && self.allowbattlechatter[str_category]))) {
    return false;
  }
  return true;
}

function on_player_spawned() {
  self endon("disconnect");
  self.soundmod = "player";
  self.voxshouldgasp = 0;
  self.voxshouldgasploop = 1;
  self.isspeaking = 0;
  self thread pain_vox();
  self thread bc_grenadewatcher();
  self thread bc_robotbehindvox();
  self thread bc_plrnotifyconvert();
  self thread cybercoremeleewatcher();
}

function bc_plrnotifyconvert() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while (true) {
    self waittill("bhtn_action_notify", notify_string);
    switch (notify_string) {
      case "firefly_deploy": {
        break;
      }
      case "firefly_end": {
        break;
      }
      default: {
        break;
      }
    }
  }
}

function bc_doplayervox(suffix) {
  soundalias = "vox_plyr_" + suffix;
  if(self bc_allowed() && (!(isdefined(self.istalking) && self.istalking)) && (!(isdefined(self.isspeaking) && self.isspeaking))) {
    self playsoundtoplayer(soundalias, self);
    self thread wait_playback_time(soundalias);
  }
}

function pain_vox() {
  self endon("death");
  self endon("disconnect");
  while (true) {
    self waittill("snd_pain_player", meansofdeath);
    if(randomintrange(0, 100) <= 100) {
      if(isalive(self)) {
        if(meansofdeath == "MOD_DROWN") {
          soundalias = "chr_swimming_drown";
          self.voxshouldgasp = 1;
          if(self.voxshouldgasploop) {
            self thread water_gasp();
          }
        }
        soundalias = "vox_plyr_exert_pain";
        self thread do_sound(soundalias, 1);
      }
    }
    wait(0.5);
  }
}

function water_gasp() {
  self endon("death");
  self endon("disconnect");
  self endon("snd_gasp");
  level endon("game_ended");
  self.voxshouldgasploop = 0;
  while (true) {
    if(!self isplayerunderwater() && self.voxshouldgasp) {
      self.voxshouldgasp = 0;
      self.voxshouldgasploop = 1;
      self thread do_sound("vox_pm1_gas_gasp", 1);
      self notify("snd_gasp");
    }
    wait(0.5);
  }
}

function cybercoremeleewatcher() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while (true) {
    self waittill("melee_cybercom");
    self thread sndcybercoremeleeresponse();
  }
}

function sndcybercoremeleeresponse() {
  self endon("melee_cybercom");
  wait(2);
  if(isdefined(self)) {
    ai = level get_closest_ai_to_object("axis", self, 700);
    if(isdefined(ai)) {
      ai notify("bhtn_action_notify", "rapidstrike");
    }
  }
}

function wait_playback_time(soundalias, timeout) {
  self endon("death");
  self endon("disconnect");
  playbacktime = soundgetplaybacktime(soundalias);
  self.isspeaking = 1;
  if(playbacktime >= 0) {
    waittime = playbacktime * 0.001;
    wait(waittime);
  } else {
    wait(1);
  }
  self notify(soundalias);
  self.isspeaking = 0;
}

function get_closest_ai_on_sameteam(some_ai, maxdist) {
  if(isdefined(some_ai)) {
    aiarray = getaiteamarray(some_ai.team);
    aiarray = arraysort(aiarray, some_ai.origin);
    if(!isdefined(maxdist)) {
      maxdist = 1000;
    }
    foreach(dude in aiarray) {
      if(!isdefined(some_ai)) {
        return undefined;
      }
      if(!isdefined(dude) || !isalive(dude) || !isdefined(dude.bcvoicenumber)) {
        continue;
      }
      if(dude == some_ai) {
        continue;
      }
      if(isvehicle(dude)) {
        continue;
      }
      if(isdefined(dude.archetype) && dude.archetype == "robot") {
        continue;
      }
      if(!(isdefined(dude.voiceprefix) && (dude.voiceprefix == "vox_hend" || dude.voiceprefix == "vox_khal" || dude.voiceprefix == "vox_kane" || dude.voiceprefix == "vox_hall" || dude.voiceprefix == "vox_mare" || dude.voiceprefix == "vox_diaz")) && (!(isdefined(some_ai.voiceprefix) && (some_ai.voiceprefix == "vox_hend" || some_ai.voiceprefix == "vox_khal" || some_ai.voiceprefix == "vox_kane" || some_ai.voiceprefix == "vox_hall" || some_ai.voiceprefix == "vox_mare" || some_ai.voiceprefix == "vox_diaz")))) {
        if(dude.bcvoicenumber == some_ai.bcvoicenumber) {
          continue;
        }
      }
      if(distance(some_ai.origin, dude.origin) > maxdist) {
        continue;
      }
      return dude;
    }
  }
  return undefined;
}

function get_closest_ai_to_object(team, object, maxdist) {
  if(!isdefined(object)) {
    return;
  }
  if(team == "both") {
    aiarray = getaiteamarray("axis", "allies");
  } else {
    aiarray = getaiteamarray(team);
  }
  aiarray = arraysort(aiarray, object.origin);
  if(!isdefined(maxdist)) {
    maxdist = 1000;
  }
  foreach(dude in aiarray) {
    if(!isdefined(dude) || !isalive(dude)) {
      continue;
    }
    if(isvehicle(dude)) {
      continue;
    }
    if(isdefined(dude.archetype) && dude.archetype == "robot") {
      continue;
    }
    if(!isdefined(dude.voiceprefix) || !isdefined(dude.bcvoicenumber)) {
      continue;
    }
    if(distance(dude.origin, object.origin) > maxdist) {
      continue;
    }
    return dude;
  }
  return undefined;
}

function function_d9f49fba(b_allow, str_category = "bc") {
  assert(isdefined(b_allow), "");
  level.allowbattlechatter[str_category] = b_allow;
}