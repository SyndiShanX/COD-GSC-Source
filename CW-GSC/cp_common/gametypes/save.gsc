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

  level.var_9d48137b = &function_81534803;
  level.var_8fe8980a = &function_9797184c;
  missionid = function_8136eb5a();

  if(!isDefined(world.mapdata[missionid][# "persistent"])) {
    world.mapdata[missionid][# "persistent"] = spawnStruct();
  }

  if(!isDefined(world.mapdata[missionid][# "transient"])) {
    world.mapdata[missionid][# "transient"] = spawnStruct();
  }

  var_316f308b = savegame_getsavedmap();

  if(!isDefined(var_316f308b) || var_316f308b.size == 0 || getrootmapname(missionid) !== getrootmapname(var_316f308b)) {
    set_player_data("previous_mission", "");
    set_player_data("previous_safehouse", "");
  }

  sv_savegameskipto = getDvar(#"sv_savegameskipto", "");

  if(!isDefined(sv_savegameskipto) || sv_savegameskipto.size == 0 || sv_savegameskipto == skipto::function_5011fee2(missionid)) {
    function_81534803(#"transient");
  }

  foreach(trig in trigger::get_all()) {
    if(is_true(trig.script_checkpoint)) {
      trig thread checkpoint_trigger();
    }
  }

  level.var_a1cfeb5a = [];
}

function save(var_116ab377, var_296c7056) {
  if(!function_7642d0c9()) {
    return;
  }

  if(!isDefined(var_116ab377)) {
    var_116ab377 = function_8136eb5a();
  }

  var_2466c81f = getmaporder() < 0;

  if(var_2466c81f) {
    return;
  }

  mapbundle = function_2717b55f(var_116ab377);

  if(!isDefined(var_296c7056) && isDefined(mapbundle) && is_true(mapbundle.issafehouse)) {
    transient = function_6440b06b(#"transient");

    if(is_true(transient.var_16e4161b)) {
      var_296c7056 = skipto::function_547ca7d2(var_116ab377);
    }
  }

  savegame_create(var_116ab377, var_296c7056);
  player = getplayers()[0];

  if(!isDefined(player)) {
    return;
  }

  missiondata = function_6440b06b(#"persistent", var_116ab377);
  missiondata.unlocked = 1;
  player stats::set_stat(#"mapdata", var_116ab377, #"unlocked", 1);
  var_116ab377 = function_8136eb5a();
  player stats::set_stat(#"hash_19d9ddd673699368", hash(var_116ab377));
  currentutctime = getutc();
  player stats::set_stat(#"hash_6addb0d6ea1de644", currentutctime);
  uploadstats(player);
}

function function_ac15668a(missionname) {
  missiondata = function_6440b06b(#"persistent", missionname);
  return is_true(missiondata.complete);
}

function function_1b212e67(missionname) {
  missiondata = function_6440b06b(#"persistent", missionname);
  return is_true(missiondata.unlocked);
}

function function_fa31c391() {
  level.var_593cdbb5 = 1;
  function_8d95e71c();
  function_a620739b();
}

function function_87dafd45(name) {
  if(isDefined(level.var_3a8f95b4) && level.var_3a8f95b4 != name && level.script != "cp_ger_hub") {
    errormsg("<dev string:x38>" + level.var_3a8f95b4 + "<dev string:x61>" + name + "<dev string:x69>");
  }

  level.var_3a8f95b4 = name;
}

function function_8136eb5a() {
  if(!isDefined(level.var_3a8f95b4)) {
    function_87dafd45(level.script);
  }

  return level.var_3a8f95b4;
}

function function_6440b06b(dataname = # "transient", missionname = function_8136eb5a()) {
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

function function_81534803(dataname, missionname = function_8136eb5a()) {
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
  missionname = function_8136eb5a();
  level.var_d6bcee66 = [];

  if(isDefined(world.mapdata[missionname])) {
    foreach(dataname, value in world.mapdata[missionname]) {
      level.var_d6bcee66[dataname] = structcopy(world.mapdata[missionname][dataname], 1);
    }
  }
}

function function_9797184c() {
  missionname = function_8136eb5a();

  if(isDefined(level.var_d6bcee66)) {
    foreach(dataname, value in level.var_d6bcee66) {
      world.mapdata[missionname][dataname] = structcopy(level.var_d6bcee66[dataname], 1);
    }
  }
}

function function_379f84b3() {
  missionid = function_8136eb5a();
  world.mapdata[missionid][# "transient"].var_2e7c022f = [];
  player = getplayers()[0];
  a_weapon_list = player getweaponslist();
  current_weapon = player getcurrentweapon();
  world.mapdata[missionid][# "transient"].var_37017d9 = current_weapon.name;

  foreach(weapon in a_weapon_list) {
    if(isDefined(weapon.name)) {
      if(!isDefined(world.mapdata[missionid][# "transient"].var_2e7c022f)) {
        world.mapdata[missionid][# "transient"].var_2e7c022f = [];
      } else if(!isarray(world.mapdata[missionid][# "transient"].var_2e7c022f)) {
        world.mapdata[missionid][# "transient"].var_2e7c022f = array(world.mapdata[missionid][# "transient"].var_2e7c022f);
      }

      world.mapdata[missionid][# "transient"].var_2e7c022f[world.mapdata[missionid][# "transient"].var_2e7c022f.size] = weapon.name;

      if(isDefined(weapon.attachments) && weapon.attachments.size > 0) {
        world.mapdata[missionid][# "transient"].var_ba4d1bad[weapon.name] = [];

        foreach(attachment in weapon.attachments) {
          if(!isDefined(world.mapdata[missionid][# "transient"].var_ba4d1bad[weapon.name])) {
            world.mapdata[missionid][# "transient"].var_ba4d1bad[weapon.name] = [];
          } else if(!isarray(world.mapdata[missionid][# "transient"].var_ba4d1bad[weapon.name])) {
            world.mapdata[missionid][# "transient"].var_ba4d1bad[weapon.name] = array(world.mapdata[missionid][# "transient"].var_ba4d1bad[weapon.name]);
          }

          world.mapdata[missionid][# "transient"].var_ba4d1bad[weapon.name][world.mapdata[missionid][# "transient"].var_ba4d1bad[weapon.name].size] = attachment;
        }
      }
    }
  }
}

function function_7396472d() {
  missionid = function_8136eb5a();
  player = getplayers()[0];

  if(isDefined(world.mapdata[missionid][# "transient"].var_2e7c022f)) {
    player takeallweapons();

    foreach(weapon_name in world.mapdata[missionid][# "transient"].var_2e7c022f) {
      if(isDefined(weapon_name)) {
        if(isDefined(world.mapdata[missionid][# "transient"].var_ba4d1bad[weapon_name])) {
          weapon = getweapon(weapon_name, world.mapdata[missionid][# "transient"].var_ba4d1bad[weapon_name]);
        } else {
          weapon = getweapon(weapon_name);
        }

        if(isDefined(weapon)) {
          player giveweapon(weapon);
        }
      }
    }

    if(isDefined(world.mapdata[missionid][# "transient"].var_37017d9)) {
      current_weapon = player getcurrentweapon();
      var_fc1c4650 = getweapon(world.mapdata[missionid][# "transient"].var_37017d9);

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

function function_2ee66e93(name, defval) {
  campaignmode = "CP";

  if(isDefined(world.playerdata[campaignmode][name])) {
    return world.playerdata[campaignmode][name];
  }

  return defval;
}

function function_8d95e71c() {
  campaignmode = "CP";

  if(isDefined(world.playerdata) && isDefined(world.playerdata[campaignmode])) {
    world.playerdata[campaignmode] = [];
  }
}

function function_7642d0c9() {
  return getdvarint(#"ui_blocksaves", 1) == 0 && !is_true(level.gameended) && !is_true(level.var_593cdbb5);
}

function function_7790f03(var_62a2ec8e = 0) {
  if(is_true(level.var_815395f5) || getdvarint(#"hash_3a4333abc7abc233", 0)) {
    return;
  }

  level thread function_396464b(var_62a2ec8e);
}

function private function_396464b(var_62a2ec8e = 0) {
  level notify(#"checkpoint_save");
  level endon(#"checkpoint_save", #"save_restore");
  level notify(#"kill_save");
  player = getplayers()[0];

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
  level thread function_655f1326(var_62a2ec8e, var_a8976c31, stealth_check);
}

function private function_304c08c5() {
  if(function_7642d0c9()) {
    var_56528c9b = isDefined(skipto::function_5a61e21a()[0]) ? skipto::function_5a61e21a()[0] : "";
    var_1461c013 = isDefined(function_2ee66e93("last_saved_skipto")) ? function_2ee66e93("last_saved_skipto") : "";
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
      player set_player_data("savegame_score", player.pers[# "score"]);
      player set_player_data("savegame_kills", player.pers[# "kills"]);
      player set_player_data("savegame_assists", player.pers[# "assists"]);
      player set_player_data("savegame_incaps", player.pers[# "incaps"]);
      player set_player_data("savegame_revives", player.pers[# "revives"]);
    }

    save();
    wait delay;
    var_56528c9b = skipto::function_5a61e21a()[0];
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

function private function_655f1326(var_62a2ec8e, var_a8976c31, stealth_check) {
  level notify(#"hash_7608fe484d0bea80");
  level endon(#"hash_7608fe484d0bea80", #"kill_save", #"save_restore");
  wait 0.1;

  while(true) {
    if(function_51c242e9(var_a8976c31, stealth_check)) {
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

function function_51c242e9(var_a8976c31 = 0, stealth_check = 1) {
  if(!var_a8976c31) {
    if(is_true(level.var_815395f5)) {
      return false;
    }

    if(getdvarint(#"hash_3a4333abc7abc233", 0)) {
      return false;
    }
  }

  if(is_true(level.missionfailed)) {
    return false;
  }

  var_e46695c4 = 0;

  foreach(player in level.players) {
    if(isDefined(player) && player function_172f4daa(var_a8976c31)) {
      var_e46695c4++;
    }
  }

  var_a9a7b3a2 = level.players.size;

  if(var_e46695c4 < var_a9a7b3a2) {
    return false;
  }

  if(!function_2ceb3570()) {
    return false;
  }

  if(!function_6dadecb9()) {
    return false;
  }

  if(isDefined(level.var_a1cfeb5a) && !var_a8976c31) {
    foreach(func in level.var_a1cfeb5a) {
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

function private function_172f4daa(var_a8976c31 = 0) {
  var_e81ab8f5 = 1;

  if(isDefined(self.health) && isDefined(self.maxhealth) && self.maxhealth > 0) {
    var_e81ab8f5 = self.health / self.maxhealth;
  }

  if(self util::function_a1d6293()) {
    return 0;
  }

  if(var_e81ab8f5 < 0.7 && !var_a8976c31) {
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
  if(!getdvarint(#"hash_3c20efa8bd1aa30", 1)) {
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

    var_1d8aaace = ai function_838fa3a9();

    if(var_1d8aaace <= 80) {
      return false;
    }
  }

  return true;
}

function private function_6f9ec10b() {
  if(!isDefined(self.enemy)) {
    return true;
  }

  if(!isPlayer(self.enemy)) {
    return true;
  }

  if(isDefined(self.melee) && isDefined(self.melee.target) && isPlayer(self.melee.target)) {
    return false;
  }

  var_1d8aaace = self function_838fa3a9();

  if(var_1d8aaace < 500) {
    return false;
  } else if(var_1d8aaace > 1000 || var_1d8aaace < 0) {
    return true;
  } else if(isactor(self) && self cansee(self.enemy) && self canshootenemy()) {
    return false;
  }

  return true;
}

function function_838fa3a9() {
  mindist = -1;

  foreach(player in function_a1ef346b()) {
    dist = distance(player.origin, self.origin);

    if(dist < mindist || mindist < 0) {
      mindist = dist;
    }
  }

  return mindist;
}

function private function_2ceb3570() {
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