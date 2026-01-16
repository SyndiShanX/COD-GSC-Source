/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_save.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\shared\_oob;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\load_shared;
#using scripts\shared\player_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace savegame;

function autoexec __init__sytem__() {
  system::register("save", & __init__, undefined, undefined);
}

function __init__() {
  if(!isdefined(world.loadout)) {
    world.loadout = [];
  }
  if(!isdefined(world.mapdata)) {
    world.mapdata = [];
  }
  if(!isdefined(world.playerdata)) {
    world.playerdata = [];
  }
  foreach(trig in trigger::get_all()) {
    if(isdefined(trig.var_d981bb2d) && trig.var_d981bb2d) {
      trig thread checkpoint_trigger();
    }
  }
  level.var_67e1f60e = [];
}

function save() {
  if(!isdefined(world.loadout)) {
    world.loadout = [];
  }
}

function load() {}

function set_mission_name(name) {
  if(isdefined(level.savename) && level.savename != name) {
    errormsg(((("" + level.savename) + "") + name) + "");
  }
  level.savename = name;
}

function get_mission_name() {
  if(!isdefined(level.savename)) {
    set_mission_name(level.script);
  }
  return level.savename;
}

function set_mission_data(name, value) {
  id = get_mission_name();
  if(!isdefined(world.mapdata)) {
    world.mapdata = [];
  }
  if(!isdefined(world.mapdata[id])) {
    world.mapdata[id] = [];
  }
  world.mapdata[id][name] = value;
}

function get_mission_data(name, defval) {
  id = get_mission_name();
  if(isdefined(world.mapdata) && isdefined(world.mapdata[id]) && isdefined(world.mapdata[id][name])) {
    return world.mapdata[id][name];
  }
  return defval;
}

function clear_mission_data() {
  id = get_mission_name();
  if(isdefined(world.mapdata) && isdefined(world.mapdata[id])) {
    world.mapdata[id] = [];
  }
}

function private get_player_unique_id() {
  return self.playername;
}

function set_player_data(name, value) {
  if(sessionmodeiscampaignzombiesgame()) {
    var_98e91480 = "offline";
    if(sessionmodeisonlinegame()) {
      var_98e91480 = "online";
    }
    var_c98fc56a = "CPZM" + var_98e91480;
  } else {
    var_c98fc56a = "CP";
  }
  id = self get_player_unique_id();
  if(!isdefined(world.playerdata)) {
    world.playerdata = [];
  }
  if(!isdefined(world.playerdata[var_c98fc56a])) {
    world.playerdata[var_c98fc56a] = [];
  }
  if(!isdefined(world.playerdata[var_c98fc56a][id])) {
    world.playerdata[var_c98fc56a][id] = [];
  }
  world.playerdata[var_c98fc56a][id][name] = value;
}

function get_player_data(name, defval) {
  if(sessionmodeiscampaignzombiesgame()) {
    var_98e91480 = "offline";
    if(sessionmodeisonlinegame()) {
      var_98e91480 = "online";
    }
    var_c98fc56a = "CPZM" + var_98e91480;
  } else {
    var_c98fc56a = "CP";
  }
  id = self get_player_unique_id();
  if(isdefined(world.playerdata) && isdefined(world.playerdata[var_c98fc56a]) && isdefined(world.playerdata[var_c98fc56a][id]) && isdefined(world.playerdata[var_c98fc56a][id][name])) {
    return world.playerdata[var_c98fc56a][id][name];
  }
  return defval;
}

function clear_player_data() {
  if(sessionmodeiscampaignzombiesgame()) {
    var_98e91480 = "offline";
    if(sessionmodeisonlinegame()) {
      var_98e91480 = "online";
    }
    var_c98fc56a = "CPZM" + var_98e91480;
  } else {
    var_c98fc56a = "CP";
  }
  id = self get_player_unique_id();
  if(isdefined(world.playerdata) && isdefined(world.playerdata[var_c98fc56a])) {
    world.playerdata[var_c98fc56a] = [];
  }
}

function function_37ae30c6() {
  if(sessionmodeiscampaignzombiesgame()) {
    var_98e91480 = "offline";
    if(sessionmodeisonlinegame()) {
      var_98e91480 = "online";
    }
    var_c98fc56a = "CPZM" + var_98e91480;
  } else {
    var_c98fc56a = "CP";
  }
  if(!isdefined(world.playerdata)) {
    world.playerdata = [];
  }
  if(!isdefined(world.playerdata[var_c98fc56a])) {
    world.playerdata[var_c98fc56a] = [];
  }
  keys = getarraykeys(world.playerdata[var_c98fc56a]);
  if(isdefined(keys)) {
    foreach(key in keys) {
      key_found = 0;
      foreach(player in level.players) {
        if(key === player get_player_unique_id()) {
          key_found = 1;
          break;
        }
      }
      if(!key_found) {
        arrayremoveindex(world.playerdata[var_c98fc56a], key, 1);
      }
    }
  }
}

function function_f6ab8f28() {
  return getdvarint("ui_blocksaves", 1) == 0;
}

function function_fb150717() {
  if(isdefined(level.var_cc93e6eb) && level.var_cc93e6eb || getdvarint("scr_no_checkpoints", 0)) {
    return;
  }
  level thread function_74fcb9ca();
}

function private function_74fcb9ca() {
  level notify("checkpoint_save");
  level endon("checkpoint_save");
  level endon("save_restore");
  checkpointcreate();
  wait(0.05);
  wait(0.05);
  checkpointcommit();
  show_checkpoint_reached();
  level thread function_152fdd8c(0);
}

function checkpoint_trigger() {
  self endon("death");
  self waittill("trigger");
  checkpoint_save();
}

function checkpoint_save(var_c36855a9 = 0) {
  level thread function_1add9d4a(var_c36855a9);
}

function show_checkpoint_reached() {}

function function_152fdd8c(delay) {
  if(function_f6ab8f28()) {
    wait(0.2);
    foreach(player in level.players) {
      player player::generate_weapon_data();
      player set_player_data("saved_weapon", player._generated_current_weapon.name);
      player set_player_data("saved_weapondata", player._generated_weapons);
      player set_player_data("lives", player.lives);
      player._generated_current_weapon = undefined;
      player._generated_weapons = undefined;
    }
    player = util::gethostplayer();
    if(isdefined(player)) {
      player set_player_data("savegame_score", player.pers["score"]);
      player set_player_data("savegame_kills", player.pers["kills"]);
      player set_player_data("savegame_assists", player.pers["assists"]);
      player set_player_data("savegame_incaps", player.pers["incaps"]);
      player set_player_data("savegame_revives", player.pers["revives"]);
    }
    savegame_create();
    wait(delay);
    if(isdefined(player)) {
      util::show_event_message(player, & "COOP_REACHED_SKIPTO");
    }
  }
}

function function_319d38eb() {
  if(isdefined(level.missionfailed) && level.missionfailed) {
    return false;
  }
  foreach(player in level.players) {
    if(!isalive(player)) {
      return false;
    }
    if(player clientfield::get("burn")) {
      return false;
    }
    if(player laststand::player_is_in_laststand()) {
      return false;
    }
    if(player.sessionstate == "spectator") {
      if(isdefined(self.firstspawn)) {
        return false;
      }
      return true;
    }
    if(player oob::isoutofbounds()) {
      return false;
    }
    if(isdefined(player.burning) && player.burning) {
      return false;
    }
  }
  return true;
}

function private function_1add9d4a(var_c36855a9) {
  level notify("hash_1add9d4a");
  level endon("hash_1add9d4a");
  level endon("kill_save");
  level endon("save_restore");
  wait(0.1);
  while (true) {
    if(function_147f4ca3()) {
      wait(0.1);
      checkpointcreate();
      wait(6);
      for (var_e2502f23 = 0; var_e2502f23 < 5; var_e2502f23++) {
        if(function_319d38eb()) {
          break;
        }
        wait(1);
      }
      if(var_e2502f23 == 5) {
        continue;
      }
      checkpointcommit();
      show_checkpoint_reached();
      if(var_c36855a9) {
        level thread function_152fdd8c(1.5);
      }
      return;
    }
    wait(1);
  }
}

function function_147f4ca3() {
  if(isdefined(level.var_cc93e6eb) && level.var_cc93e6eb) {
    return false;
  }
  if(getdvarint("scr_no_checkpoints", 0)) {
    return false;
  }
  if(isdefined(level.missionfailed) && level.missionfailed) {
    return false;
  }
  var_3d59bfa3 = 0;
  foreach(player in level.players) {
    if(player function_2c89c30c()) {
      var_3d59bfa3++;
    }
  }
  var_24cd4120 = level.players.size;
  if(var_3d59bfa3 < var_24cd4120) {
    return false;
  }
  if(!function_8dc86b60()) {
    return false;
  }
  if(!function_a3a9b003()) {
    return false;
  }
  if(isdefined(level.var_67e1f60e)) {
    foreach(func in level.var_67e1f60e) {
      if(!level[[func]]()) {
        return false;
      }
    }
  }
  return true;
}

function private function_2c89c30c() {
  healthfraction = 1;
  if(isdefined(self.health) && isdefined(self.maxhealth) && self.maxhealth > 0) {
    healthfraction = self.health / self.maxhealth;
  }
  if(healthfraction < 0.7) {
    return false;
  }
  if(isdefined(self.lastdamagetime) && self.lastdamagetime > (gettime() - 1500)) {
    return false;
  }
  if(self clientfield::get("burn")) {
    return false;
  }
  if(self ismeleeing()) {
    return false;
  }
  if(self isthrowinggrenade()) {
    return false;
  }
  if(self isfiring()) {
    return false;
  }
  if(self util::isflashed()) {
    return false;
  }
  if(self laststand::player_is_in_laststand()) {
    return false;
  }
  if(self.sessionstate == "spectator") {
    if(isdefined(self.firstspawn)) {
      return false;
    }
    return true;
  }
  if(self oob::isoutofbounds()) {
    return false;
  }
  if(isdefined(self.burning) && self.burning) {
    return false;
  }
  if(self flagsys::get("mobile_armory_in_use")) {
    return false;
  }
  foreach(weapon in self getweaponslist()) {
    fraction = self getfractionmaxammo(weapon);
    if(fraction > 0.1) {
      return true;
    }
  }
  return false;
}

function private function_a3a9b003() {
  if(!getdvarint("tu1_saveGameAiProximityCheck", 1)) {
    return true;
  }
  ais = getaiteamarray("axis");
  foreach(ai in ais) {
    if(!isdefined(ai)) {
      continue;
    }
    if(!isalive(ai)) {
      continue;
    }
    if(isactor(ai) && ai isinscriptedstate()) {
      continue;
    }
    if(isdefined(ai.ignoreall) && ai.ignoreall) {
      continue;
    }
    playerproximity = ai function_2808d83d();
    if(playerproximity <= 80) {
      return false;
    }
  }
  return true;
}

function private function_f70dd749() {
  if(!isdefined(self.enemy)) {
    return true;
  }
  if(!isplayer(self.enemy)) {
    return true;
  }
  if(isdefined(self.melee) && isdefined(self.melee.target) && isplayer(self.melee.target)) {
    return false;
  }
  playerproximity = self function_2808d83d();
  if(playerproximity < 500) {
    return false;
  }
  if(playerproximity > 1000 || playerproximity < 0) {
    return true;
  }
  if(isactor(self) && self cansee(self.enemy) && self canshootenemy()) {
    return false;
  }
  return true;
}

function function_2808d83d() {
  mindist = -1;
  foreach(player in level.activeplayers) {
    dist = distance(player.origin, self.origin);
    if(dist < mindist || mindist < 0) {
      mindist = dist;
    }
  }
  return mindist;
}

function private function_8dc86b60() {
  var_db6b9d9f = 0;
  foreach(grenade in getentarray("grenade", "classname")) {
    foreach(player in level.activeplayers) {
      distsq = distancesquared(grenade.origin, player.origin);
      if(distsq < 90000) {
        var_db6b9d9f++;
      }
    }
  }
  if(var_db6b9d9f > 0 && var_db6b9d9f >= level.activeplayers.size) {
    return false;
  }
  return true;
}