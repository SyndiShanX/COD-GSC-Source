/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\save.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace savegame;

function private autoexec __init__system__() {
  system::register(#"save", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!isDefined(world.loadout)) {
    world.loadout = [];
  }

  if(!isDefined(world.mapdata)) {
    world.mapdata = [];
  }

  if(!isDefined(world.playerdata)) {
    world.playerdata = [];
  }

  level.var_9d48137b = &clear_mission_data;
  level.var_8fe8980a = &function_9797184c;
  missionid = get_mission_name();

  if(!isDefined(world.mapdata[missionid][#"persistent"])) {
    world.mapdata[missionid][#"persistent"] = spawnStruct();
  }

  if(!isDefined(world.mapdata[missionid][#"transient"])) {
    world.mapdata[missionid][#"transient"] = spawnStruct();
  }

  var_316f308b = savegame_getsavedmap();

  if(!isDefined(var_316f308b) || var_316f308b.size == 0 || getrootmapname(missionid) !== getrootmapname(var_316f308b)) {
    set_player_data("previous_mission", "");
    set_player_data("previous_safehouse", "");
  }

  sv_savegameskipto = getDvar(#"sv_savegameskipto", "");

  if(!isDefined(sv_savegameskipto) || sv_savegameskipto.size == 0 || sv_savegameskipto == skipto::function_5011fee2(missionid)) {
    clear_mission_data(#"transient");
  }

  foreach(trig in trigger::get_all()) {
    if(is_true(trig.script_checkpoint)) {
      trig thread checkpoint_trigger();
    }
  }

  level._extra_save_safe_checks = [];
}

function save(var_116ab377, var_296c7056) {
  if(!function_7642d0c9()) {
    return;
  }

  if(!isDefined(var_116ab377)) {
    var_116ab377 = get_mission_name();
  }

  var_2466c81f = getmaporder() < 0;

  if(var_2466c81f) {
    return;
  }

  mapbundle = getmapscriptbundle(var_116ab377);

  if(!isDefined(var_296c7056) && isDefined(mapbundle) && is_true(mapbundle.issafehouse)) {
    transient = get_mission_data(#"transient");

    if(is_true(transient.briefing_complete)) {
      var_296c7056 = skipto::function_547ca7d2(var_116ab377);
    }
  }

  savegame_create(var_116ab377, var_296c7056);
  player = getPlayers()[0];

  if(!isDefined(player)) {
    return;
  }

  missiondata = get_mission_data(#"persistent", var_116ab377);
  missiondata.unlocked = 1;
  player stats::set_stat(#"mapdata", var_116ab377, #"unlocked", 1);
  var_116ab377 = get_mission_name();
  player stats::set_stat(#"hash_19d9ddd673699368", hash(var_116ab377));
  currentutctime = getutc();
  player stats::set_stat(#"hash_6addb0d6ea1de644", currentutctime);
  uploadstats(player);
}

function function_ac15668a(missionname) {
  missiondata = get_mission_data(#"persistent", missionname);
  return is_true(missiondata.complete);
}

function function_1b212e67(missionname) {
  missiondata = get_mission_data(#"persistent", missionname);
  return is_true(missiondata.unlocked);
}

function function_fa31c391() {
  level.var_593cdbb5 = 1;
  clear_player_data();
  function_a620739b();
}

function set_mission_name(name) {
  if(isDefined(level.savename) && level.savename != name && level.script != "cp_ger_hub") {
    errormsg("<dev string:x38>" + level.savename + "<dev string:x61>" + name + "<dev string:x69>");
  }

  level.savename = name;
}

function get_mission_name() {
  if(!isDefined(level.savename)) {
    set_mission_name(level.script);
  }

  return level.savename;
}

function get_mission_data(dataname = #"transient", missionname = get_mission_name()) {
  if(!isDefined(world.mapdata)) {
    world.mapdata = [];
  }

  if(!isDefined(world.mapdata[missionname])) {
    world.mapdata[missionname] = [];
  }

  if(!isDefined(world.mapdata[missionname][dataname])) {
    world.mapdata[missionname][dataname] = spawnStruct();
  }

  return world.mapdata[missionname][dataname];
}

function clear_mission_data(dataname, missionname = get_mission_name()) {
  if(isDefined(world.mapdata) && isDefined(world.mapdata[missionname])) {
    if(isDefined(dataname)) {
      if(isDefined(world.mapdata[missionname][dataname])) {
        world.mapdata[missionname][dataname] = spawnStruct();
      }

      return;
    }

    foreach(dataname, value in world.mapdata[missionname]) {
      world.mapdata[missionname][dataname] = spawnStruct();
    }
  }
}

function function_a620739b() {
  if(isDefined(world.mapdata)) {
    world.mapdata = [];
  }
}

function function_7e0e735b() {
  missionname = get_mission_name();
  level.var_d6bcee66 = [];

  if(isDefined(world.mapdata[missionname])) {
    foreach(dataname, value in world.mapdata[missionname]) {
      level.var_d6bcee66[dataname] = structcopy(world.mapdata[missionname][dataname], 1);
    }
  }
}

function function_9797184c() {
  missionname = get_mission_name();

  if(isDefined(level.var_d6bcee66)) {
    foreach(dataname, value in level.var_d6bcee66) {
      world.mapdata[missionname][dataname] = structcopy(level.var_d6bcee66[dataname], 1);
    }
  }
}

function function_379f84b3() {
  missionid = get_mission_name();
  world.mapdata[missionid][#"transient"].var_2e7c022f = [];
  player = getPlayers()[0];
  a_weapon_list = player getweaponslist();
  current_weapon = player getcurrentweapon();
  world.mapdata[missionid][#"transient"].var_37017d9 = current_weapon.name;

  foreach(weapon in a_weapon_list) {
    if(isDefined(weapon.name)) {
      if(!isDefined(world.mapdata[missionid][#"transient"].var_2e7c022f)) {
        world.mapdata[missionid][#"transient"].var_2e7c022f = [];
      } else if(!isarray(world.mapdata[missionid][#"transient"].var_2e7c022f)) {
        world.mapdata[missionid][#"transient"].var_2e7c022f = array(world.mapdata[missionid][#"transient"].var_2e7c022f);
      }

      world.mapdata[missionid][#"transient"].var_2e7c022f[world.mapdata[missionid][#"transient"].var_2e7c022f.size] = weapon.name;

      if(isDefined(weapon.attachments) && weapon.attachments.size > 0) {
        world.mapdata[missionid][#"transient"].var_ba4d1bad[weapon.name] = [];

        foreach(attachment in weapon.attachments) {
          if(!isDefined(world.mapdata[missionid][#"transient"].var_ba4d1bad[weapon.name])) {
            world.mapdata[missionid][#"transient"].var_ba4d1bad[weapon.name] = [];
          } else if(!isarray(world.mapdata[missionid][#"transient"].var_ba4d1bad[weapon.name])) {
            world.mapdata[missionid][#"transient"].var_ba4d1bad[weapon.name] = array(world.mapdata[missionid][#"transient"].var_ba4d1bad[weapon.name]);
          }

          world.mapdata[missionid][#"transient"].var_ba4d1bad[weapon.name][world.mapdata[missionid][#"transient"].var_ba4d1bad[weapon.name].size] = attachment;
        }
      }
    }
  }
}

function function_7396472d() {
  missionid = get_mission_name();
  player = getPlayers()[0];

  if(isDefined(world.mapdata[missionid][#"transient"].var_2e7c022f)) {
    player takeallweapons();

    foreach(weapon_name in world.mapdata[missionid][#"transient"].var_2e7c022f) {
      if(isDefined(weapon_name)) {
        if(isDefined(world.mapdata[missionid][#"transient"].var_ba4d1bad[weapon_name])) {
          weapon = getweapon(weapon_name, world.mapdata[missionid][#"transient"].var_ba4d1bad[weapon_name]);
        } else {
          weapon = getweapon(weapon_name);
        }

        if(isDefined(weapon)) {
          player giveweapon(weapon);
        }
      }
    }

    if(isDefined(world.mapdata[missionid][#"transient"].var_37017d9)) {
      current_weapon = player getcurrentweapon();
      var_fc1c4650 = getweapon(world.mapdata[missionid][#"transient"].var_37017d9);

      if(isDefined(current_weapon) && isDefined(var_fc1c4650) && current_weapon != var_fc1c4650) {
        if(player hasweapon(var_fc1c4650)) {
          player switchtoweaponimmediate(var_fc1c4650);
        }
      }
    }
  }
}

function set_player_data(name, value) {
  campaignmode = "CP";

  if(!isDefined(world.playerdata)) {
    world.playerdata = [];
  }

  if(!isDefined(world.playerdata[campaignmode])) {
    world.playerdata[campaignmode] = [];
  }

  world.playerdata[campaignmode][name] = value;
}

function get_player_data(name, defval) {
  campaignmode = "CP";

  if(isDefined(world.playerdata[campaignmode][name])) {
    return world.playerdata[campaignmode][name];
  }

  return defval;
}

function clear_player_data() {
  campaignmode = "CP";

  if(isDefined(world.playerdata) && isDefined(world.playerdata[campaignmode])) {
    world.playerdata[campaignmode] = [];
  }
}

function function_7642d0c9() {
  return getdvarint(#"ui_blocksaves", 1) == 0 && !is_true(level.gameended) && !is_true(level.var_593cdbb5);
}

function checkpoint_save_asap(var_62a2ec8e = 0) {
  if(is_true(level.no_checkpoint_save) || getdvarint(#"scr_no_checkpoints", 0)) {
    return;
  }

  level thread function_396464b(var_62a2ec8e);
}

function private function_396464b(var_62a2ec8e = 0) {
  level notify(#"checkpoint_save");
  level endon(#"checkpoint_save", #"save_restore");
  level notify(#"kill_save");
  player = getPlayers()[0];

  if(isPlayer(player) && player util::function_a1d6293()) {
    return;
  }

  checkpointcreate();
  waitframe(1);
  waitframe(1);

  if(is_true(level.var_5be43b2d)) {
    return;
  }

  checkpointcommit();
  function_40f4c631(var_62a2ec8e);
}

function checkpoint_trigger() {
  self endon(#"death");
  self waittill(#"trigger");
  checkpoint_save();
}

function checkpoint_save(var_62a2ec8e = 0, var_a8976c31, stealth_check) {
  level thread _checkpoint_save_safe(var_62a2ec8e, var_a8976c31, stealth_check);
}

function private function_304c08c5() {
  if(function_7642d0c9()) {
    var_56528c9b = isDefined(skipto::get_current_skiptos()[0]) ? skipto::get_current_skiptos()[0] : "";
    var_1461c013 = isDefined(get_player_data("last_saved_skipto")) ? get_player_data("last_saved_skipto") : "";
    return (var_56528c9b != var_1461c013);
  }

  return false;
}

function private function_40f4c631(var_62a2ec8e) {
  var_b026e720 = function_304c08c5();
  level thread function_680b78aa(var_b026e720);

  if(!var_b026e720 && is_true(var_62a2ec8e)) {
    util::function_502198f3();
  }
}

function private function_680b78aa(var_62a2ec8e = 1, delay = 1.5) {
  if(function_7642d0c9()) {
    wait 0.2;

    foreach(player in level.players) {
      player player::generate_weapon_data();
      player set_player_data("saved_weapon", player._generated_current_weapon.rootweapon.name);
      player set_player_data("saved_weapon_attachments", util::function_2146bd83(player._generated_current_weapon));
      player set_player_data("saved_weapondata", player._generated_weapons);
      player set_player_data("lives", player.lives);
      player._generated_current_weapon = undefined;
      player._generated_weapons = undefined;
    }

    player = util::gethostplayer();

    if(isDefined(player)) {
      player set_player_data("savegame_score", player.pers[#"score"]);
      player set_player_data("savegame_kills", player.pers[#"kills"]);
      player set_player_data("savegame_assists", player.pers[#"assists"]);
      player set_player_data("savegame_incaps", player.pers[#"incaps"]);
      player set_player_data("savegame_revives", player.pers[#"revives"]);
    }

    save();
    wait delay;
    var_56528c9b = skipto::get_current_skiptos()[0];
    set_player_data("last_saved_skipto", var_56528c9b);

    if(isDefined(player) && is_true(var_62a2ec8e)) {
      player util::function_b9dfcfb7();
    }
  }
}

function function_68cfab84() {
  if(is_true(level.missionfailed)) {
    return 0;
  }

  foreach(player in level.players) {
    if(!isalive(player)) {
      return 0;
    }

    if(player clientfield::get("burn")) {
      return 0;
    }

    if(player util::function_a1d6293()) {
      return 0;
    }

    if(player.sessionstate == "spectator") {
      firstspawn = isDefined(self.firstspawn) ? self.firstspawn : 1;
      return firstspawn;
    }

    if(player oob::isoutofbounds()) {
      return 0;
    }

    if(is_true(player.burning)) {
      return 0;
    }
  }

  return 1;
}

function private _checkpoint_save_safe(var_62a2ec8e, var_a8976c31, stealth_check) {
  level notify(#"_checkpoint_save_safe");
  level endon(#"_checkpoint_save_safe", #"kill_save", #"save_restore");
  wait 0.1;

  while(true) {
    if(save_safe_check(var_a8976c31, stealth_check)) {
      wait 0.1;
      checkpointcreate();
      wait 6;

      for(check_count = 0; check_count < 5; check_count++) {
        if(function_68cfab84()) {
          break;
        }

        wait 1;
      }

      if(check_count == 5) {
        continue;
      }

      if(is_true(level.var_5be43b2d)) {
        continue;
      }

      checkpointcommit();
      function_40f4c631(var_62a2ec8e);
      return;
    }

    wait 1;
  }
}

function save_safe_check(var_a8976c31 = 0, stealth_check = 1) {
  if(!var_a8976c31) {
    if(is_true(level.no_checkpoint_save)) {
      return false;
    }

    if(getdvarint(#"scr_no_checkpoints", 0)) {
      return false;
    }
  }

  if(is_true(level.missionfailed)) {
    return false;
  }

  var_e46695c4 = 0;

  foreach(player in level.players) {
    if(isDefined(player) && player _save_safe_check_player(var_a8976c31)) {
      var_e46695c4++;
    }
  }

  var_a9a7b3a2 = level.players.size;

  if(var_e46695c4 < var_a9a7b3a2) {
    return false;
  }

  if(!_save_safe_grenade_proximity()) {
    return false;
  }

  if(!function_6dadecb9()) {
    return false;
  }

  if(isDefined(level._extra_save_safe_checks) && !var_a8976c31) {
    foreach(func in level._extra_save_safe_checks) {
      if(!level[[func]]()) {
        return false;
      }
    }
  }

  if(stealth_check && isDefined(level.var_8bca2033)) {
    if(![[level.var_8bca2033]]()) {
      return false;
    }
  }

  return true;
}

function private _save_safe_check_player(var_a8976c31 = 0) {
  healthfraction = 1;

  if(isDefined(self.health) && isDefined(self.maxhealth) && self.maxhealth > 0) {
    healthfraction = self.health / self.maxhealth;
  }

  if(self util::function_a1d6293()) {
    return 0;
  }

  if(healthfraction < 0.7 && !var_a8976c31) {
    return 0;
  }

  if(isDefined(self.lastdamagetime) && self.lastdamagetime > gettime() - 1500) {
    return 0;
  }

  if(self clientfield::get("burn")) {
    return 0;
  }

  if(self ismeleeing()) {
    return 0;
  }

  if(self isthrowinggrenade()) {
    return 0;
  }

  if(self isfiring()) {
    return 0;
  }

  if(self util::isflashed()) {
    return 0;
  }

  if(self.sessionstate == "spectator") {
    firstspawn = isDefined(self.firstspawn) ? self.firstspawn : 1;
    return firstspawn;
  }

  if(self oob::isoutofbounds()) {
    return 0;
  }

  if(is_true(self.burning)) {
    return 0;
  }

  if(self flag::get(#"mobile_armory_in_use")) {
    return 0;
  }

  if(var_a8976c31) {
    return 1;
  }

  foreach(weapon in self getweaponslist()) {
    fraction = self getfractionmaxammo(weapon);

    if(fraction > 0.1) {
      return 1;
    }
  }

  return 0;
}

function private function_6dadecb9() {
  if(!getdvarint(#"tu1_savegameaiproximitycheck", 1)) {
    return true;
  }

  ais = getaiteamarray(#"axis");

  foreach(ai in ais) {
    if(!isDefined(ai)) {
      continue;
    }

    if(!isalive(ai)) {
      continue;
    }

    if(isactor(ai) && ai isinscriptedstate()) {
      continue;
    }

    if(is_true(ai.ignoreall)) {
      continue;
    }

    playerproximity = ai _save_safe_player_proximity();

    if(playerproximity <= 80) {
      return false;
    }
  }

  return true;
}

function private _save_safe_check_ai() {
  if(!isDefined(self.enemy)) {
    return true;
  }

  if(!isPlayer(self.enemy)) {
    return true;
  }

  if(isDefined(self.melee) && isDefined(self.melee.target) && isPlayer(self.melee.target)) {
    return false;
  }

  playerproximity = self _save_safe_player_proximity();

  if(playerproximity < 500) {
    return false;
  } else if(playerproximity > 1000 || playerproximity < 0) {
    return true;
  } else if(isactor(self) && self cansee(self.enemy) && self canshootenemy()) {
    return false;
  }

  return true;
}

function _save_safe_player_proximity() {
  mindist = -1;

  foreach(player in function_a1ef346b()) {
    dist = distance(player.origin, self.origin);

    if(dist < mindist || mindist < 0) {
      mindist = dist;
    }
  }

  return mindist;
}

function private _save_safe_grenade_proximity() {
  var_e1a8a025 = 0;

  foreach(grenade in getEntArray("grenade", "classname")) {
    foreach(player in function_a1ef346b()) {
      distsq = distancesquared(grenade.origin, player.origin);

      if(distsq < 90000) {
        var_e1a8a025++;
      }
    }
  }

  if(var_e1a8a025 > 0 && var_e1a8a025 >= function_a1ef346b().size) {
    return false;
  }

  return true;
}