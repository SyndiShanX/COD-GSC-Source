/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_61afae50a53c3917.gsc
*************************************************/

#using script_39d11000e476a42a;
#using script_3a13b8032b62a5e6;
#using script_482376d10f69832c;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\teams;
#namespace namespace_c493b0becc9ac9e3;

function function_65e52fad2bce952c(var_b8b25f4d3c3dab1d, var_18f698ac43092a07, var_e779ac7e9e65683d, var_730999d9ac61610e) {
  assert(isDefined(var_18f698ac43092a07) && isDefined(var_b8b25f4d3c3dab1d) && isDefined(var_e779ac7e9e65683d), "<dev string:x1c>");
  assert(isPlayer(var_b8b25f4d3c3dab1d), "<dev string:x6d>");
  reward_groups = [];
  a_players = var_b8b25f4d3c3dab1d scripts\cp_mp\utility\squad_utility::getsquadmembers();

  foreach(player in a_players) {
    reward_groups[reward_groups.size] = [player];

    if(istrue(var_730999d9ac61610e)) {
      if(!isDefined(player.var_f0de17708687532e)) {
        player.var_f0de17708687532e = [];
      }

      player.var_f0de17708687532e = function_6d6af8144a5131f1(player.var_f0de17708687532e, var_18f698ac43092a07);
    }
  }

  reward_placement = namespace_71ca15b739deab72::function_3ae7f99339b96499(var_e779ac7e9e65683d);
  lootfunctionargs = spawnStruct();
  lootfunctionargs.var_18f698ac43092a07 = var_18f698ac43092a07;
  level namespace_e8853d3344e33cf6::function_863be9e39e19fe2f(reward_groups, reward_placement, &function_de032cb8f1df5adc, lootfunctionargs);
}

function function_d737da36e4f0f6c2(player, var_18f698ac43092a07) {
  if(isDefined(player.var_f0de17708687532e)) {
    return array_contains(player.var_f0de17708687532e, var_18f698ac43092a07);
  }

  return 0;
}

function function_de032cb8f1df5adc(lootfunctionargs) {
  cache = spawnStruct();
  items = function_bc2f4857c90f5344(lootfunctionargs.var_18f698ac43092a07, 1);
  common_cache::function_fd95ef820bb2b980(items, cache);
  return cache.contents;
}

function function_9426e2a8c6789b97(player, var_f877158dac9d9e99, itembundlename, isdebug) {
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", player getentitynumber()];
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, var_f877158dac9d9e99, undefined, 0, 1, payload);

  if(isDefined(item) && !istrue(isdebug)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }
  }
}

function function_579b200202dd2b1b(enteringentity) {
  playerstocheck = undefined;

  if(isDefined(enteringentity)) {
    playerstocheck = [];

    if(isPlayer(enteringentity)) {
      playerstocheck[playerstocheck.size] = enteringentity;
    } else if(enteringentity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(enteringentity);

      if(isDefined(occupants)) {
        playerstocheck = occupants;
      }
    }
  }

  return playerstocheck;
}

function function_fbd6a74053f1cb9a(objectivemarkerbundlename) {
  var_ffcea9c7e03fdcba = -1;

  if(isDefined(objectivemarkerbundlename)) {
    markerid = namespace_871f41e67db0bf7a::createobjectivemarkerfrombundlexhash(objectivemarkerbundlename);

    if(isDefined(markerid) && markerid != -1) {
      var_ffcea9c7e03fdcba = markerid;
      objective_removeallfrommask(markerid);
    }
  }

  return var_ffcea9c7e03fdcba;
}

function function_1fcbe5915340280a(players, markerid) {
  if(isDefined(players) && isDefined(markerid) && isarray(players) && players.size > 0 && markerid != -1) {
    foreach(player in players) {
      objective_addclienttomask(markerid, player);
      objective_showtoplayersinmask(markerid);
    }
  }
}

function function_f535888a3f1341a4(players, markerid) {
  if(isDefined(players) && isDefined(markerid) && isarray(players) && players.size > 0 && markerid != -1) {
    foreach(player in players) {
      objective_removeclientfrommask(markerid, player);
    }
  }
}

function function_fa14863bc660a9b5(markerid) {
  if(isDefined(markerid) && markerid != -1) {
    objective_removeallfrommask(markerid);
  }
}

function function_a90a4361890d7c1d(var_a46efd0f95adb3ac, players, markerid, iconzoffset) {
  if(isDefined(players) && isDefined(var_a46efd0f95adb3ac) && isDefined(self) && isDefined(markerid) && isent(var_a46efd0f95adb3ac) && isarray(players) && players.size > 0 && markerid != -1) {
    level endon("game_ended");
    var_a46efd0f95adb3ac endon("death");
    self endon("attunement_ended");
    scripts\mp\objidpoolmanager::update_objective_setzoffset(markerid, iconzoffset);
    function_1fcbe5915340280a(players, markerid);

    foreach(player in players) {
      while(true) {
        scripts\mp\objidpoolmanager::update_objective_onentity(markerid, var_a46efd0f95adb3ac);
        waitframe();
      }
    }
  }
}