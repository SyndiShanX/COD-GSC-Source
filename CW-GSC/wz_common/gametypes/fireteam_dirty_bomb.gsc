/*******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\gametypes\fireteam_dirty_bomb.gsc
*******************************************************/

#using script_167b322dbacbc3f5;
#using script_26187575f84f8d07;
#using script_335d0650ed05d36d;
#using script_46192c58ea066d7f;
#using script_4e6bcfa8856b2a96;
#using script_b9a55edd207e4ca;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\laststand;
#using scripts\mp_common\player\player_utils;
#using scripts\wz_common\wz_rat;
#namespace fireteam_dirty_bomb;

function private autoexec __init__system__() {
  system::register(#"hash_16dead24d6def3d5", &function_62730899, undefined, undefined, #"territory");
}

function event_handler[gametype_init] main(eventstruct) {
  if(!namespace_681edb36::function_23dd41e7()) {
    return;
  }

  setDvar(#"scr_maxinventory_scorestreaks", 1);
  level.var_e2636f91 = 0;
  namespace_2938acdc::init();
  namespace_234f0efc::init();
  spawning::addsupportedspawnpointtype("tdm");
  level.onstartgametype = &onstartgametype;
  callback::on_spawned(&onplayerspawned);
  callback::on_player_killed(&on_player_killed);
  level callback::add_callback(#"hash_259e3bcba73a2f14", &function_c0e544cc);
  laststand_mp::function_367cfa1b(&function_95002a59);
  player::function_3c5cc656(&function_610d3790);
  clientfield::register("toplayer", "using_bomb", 1, 2, "int");
  clientfield::register_clientuimodel("hudItems.uraniumCarryCount", 1, 4, "int");
  clientfield::register_clientuimodel("hudItems.uraniumMaxCarry", 1, 4, "int");
  clientfield::register_clientuimodel("hudItems.uraniumFullCarry", 1, 1, "int");
  clientfield::register("allplayers", "carryingUranium", 1, 1, "int");
  clientfield::register("scriptmover", "bombsound", 1, 1, "int");
  clientfield::function_5b7d846d("hud_items_dirty_bomb.bomb_respawn_disabled", 1, 1, "int");
  laststand_mp::function_eb8c0e47(&onplayerrevived);
  level.var_574cc797 = &namespace_234f0efc::function_588a586d;
  level.can_revive = &function_45a85e5b;
  level.dirtybombusebar = dirtybomb_usebar::register();
  level.var_b7821ed9 = &function_b7821ed9;
  level.var_82b353bf = &function_82b353bf;
  level.var_34842a14 = 1;
  level.var_ce802423 = 1;
  level.var_38743886 = &function_d7cf81e;
  level.var_2064692e = isDefined(getgametypesetting(#"hash_2c23b61a946618e5", 0)) ? getgametypesetting(#"hash_2c23b61a946618e5", 0) : 0;
  level.var_96cdb906 = isDefined(getgametypesetting(#"hash_78b20ae470a01292")) ? getgametypesetting(#"hash_78b20ae470a01292") : 0;
  level.var_73871ea9 = isDefined(getgametypesetting(#"hash_5e81c41c0b8501db")) ? getgametypesetting(#"hash_5e81c41c0b8501db") : 0;
  level.var_12ff620b = isDefined(getgametypesetting(#"hash_5427188d61d31f49")) ? getgametypesetting(#"hash_5427188d61d31f49") : 0;
  level.var_26c7635a = isDefined(getgametypesetting(#"hash_2eae1dd81a5d55d6")) ? getgametypesetting(#"hash_2eae1dd81a5d55d6") : 0;
  level.var_5a7ddc70 = isDefined(getgametypesetting(#"hash_6b7a67833a5d1ece")) ? getgametypesetting(#"hash_6b7a67833a5d1ece") : 0;
  level.var_3990ce92 = isDefined(getgametypesetting(#"hash_3ca893637b9e53ce")) ? getgametypesetting(#"hash_3ca893637b9e53ce") : 0;
  level.var_932f538d = isDefined(getgametypesetting(#"hash_2298689819f46c81")) ? getgametypesetting(#"hash_2298689819f46c81") : 0;
  level.var_e39b6425 = isDefined(getgametypesetting(#"hash_5e96d382e9e9c267")) ? getgametypesetting(#"hash_5e96d382e9e9c267") : 0;
  level.var_4e3c4685 = isDefined(getgametypesetting(#"hash_2115537cc1f85d3c")) ? getgametypesetting(#"hash_2115537cc1f85d3c") : 0;
  level.var_b06a1891 = isDefined(getgametypesetting(#"hash_448f94b2a3abdbb9")) ? getgametypesetting(#"hash_448f94b2a3abdbb9") : 0;
  level.var_f4a1440c = isDefined(getgametypesetting(#"hash_f9fc752cf48653")) ? getgametypesetting(#"hash_f9fc752cf48653") : 0;
  level.var_46f2c796 = isDefined(getgametypesetting(#"hash_982be25d9d36fcb")) ? getgametypesetting(#"hash_982be25d9d36fcb") : 0;
  level.var_451f847f = isDefined(getgametypesetting(#"hash_26632e4a6a693312")) ? getgametypesetting(#"hash_26632e4a6a693312") : 0;
  level.var_d86d5820 = isDefined(getgametypesetting(#"hash_78f99a9c357836ba")) ? getgametypesetting(#"hash_78f99a9c357836ba") : 0;
  level.var_60693fca = (isDefined(getgametypesetting(#"hash_37aefeabeef0ec6c")) ? getgametypesetting(#"hash_37aefeabeef0ec6c") : 0) * 100;
  level.var_60e3f99c = 99999;
  level.var_77720414 = isDefined(getgametypesetting(#"hash_2778e754fc66aac")) ? getgametypesetting(#"hash_2778e754fc66aac") : 0;
  level.var_e65e9422 = isDefined(getgametypesetting(#"hash_540ba194e715168b")) ? getgametypesetting(#"hash_540ba194e715168b") : 0;
  level.var_5f31e806 = isDefined(getgametypesetting(#"hash_3c99ef02f267efaf")) ? getgametypesetting(#"hash_3c99ef02f267efaf") : 1;
  level.var_c836026 = isDefined(getgametypesetting(#"hash_3c7edd02f2510961")) ? getgametypesetting(#"hash_3c7edd02f2510961") : 5;
  level.var_3a9e7236 = is_true(getgametypesetting(#"hash_301e41804f45eb50"));
  level.var_696298a2 = getweapon(#"hash_46cc133cf4065ae0");
  level.var_b9f31e66 = isDefined(getgametypesetting(#"hash_3eeecb0a77c21db1")) ? getgametypesetting(#"hash_3eeecb0a77c21db1") : 100;
  level.var_8c05a764 = isDefined(getgametypesetting(#"hash_2e824e2ee213574d")) ? getgametypesetting(#"hash_2e824e2ee213574d") : 10;
  level.var_89a6bd00 = isDefined(getgametypesetting(#"hash_7b5af9a43263b4a9")) ? getgametypesetting(#"hash_7b5af9a43263b4a9") : 15;
  level.var_65a0fe4d = isDefined(getgametypesetting(#"hash_7b3feba4324cd527")) ? getgametypesetting(#"hash_7b3feba4324cd527") : 30;
  level thread namespace_234f0efc::function_8d066de9(level.var_b9f31e66, level.var_89a6bd00, level.var_65a0fe4d, level.var_8c05a764);
  namespace_b77e8eb1::init(&function_277ec378, &function_334e317);
  namespace_681edb36::function_dd83b835();
  item_world::function_861f348d(#"gamemode_pickup", &function_18f58ab2);
  level.var_d539e0dd = &function_3f63e44f;
  level.var_2632202d = &function_5feabd33;
  level.var_11f2d0c5 = &function_2017a28e;
  level.var_c3a003ad = &namespace_234f0efc::function_aecae28d;
  level.var_df8a7ea7 = &function_e3c3aba5;
  level.var_2f418a15 = [];
  level.var_910f361c = [];
  level.var_d8fd137b = [];
  level.var_d8fd137b[0] = # "hash_2854f6c09dd9a316";
  level.var_d8fd137b[1] = # "hash_2854f5c09dd9a163";
  level.var_d8fd137b[2] = # "hash_2854f4c09dd99fb0";
  level.var_d8fd137b[3] = # "hash_2854fbc09dd9ab95";
  level.var_d8fd137b[4] = # "hash_2854fac09dd9a9e2";

  if(getdvarint(#"hash_74074ce39d0658e7", 0)) {
    level.var_12ff620b = 0;
    level.var_26c7635a = 3;
    level.var_3990ce92 = 1;
    level.var_932f538d = 1;
    level.var_e39b6425 = 3;
    level.var_b06a1891 = 5;
    level.var_f4a1440c = 5;
    level.var_46f2c796 = 3;
    level.var_7108bd31 = 15;
    level.var_c0839e43 = 1;
    level.var_de7aa071 = 5;
  }
}

function private function_d7cf81e(targetplayer, &points) {
  if(level.var_2f418a15.size <= 0) {
    return points;
  }

  if(points.size <= 0) {
    return points;
  }

  var_dcb6be80 = sqr(level.var_60693fca);
  var_f0c5590a = sqr(level.var_60693fca + 7500);
  var_3e6f2c1b = [];
  validpoints = [];
  var_4f2a097f = 0;
  var_f74183d3 = points[0];

  foreach(bomb in level.var_2f418a15) {
    if(bomb.state !== 5) {
      continue;
    }

    if(distance2dsquared(targetplayer.origin, bomb.origin) > var_f0c5590a) {
      continue;
    }

    var_3e6f2c1b[var_3e6f2c1b.size] = bomb.origin;
  }

  if(var_3e6f2c1b.size <= 0) {
    return points;
  }

  for(index = 0; index < points.size; index++) {
    point = points[index];

    foreach(bomborigin in var_3e6f2c1b) {
      var_b334ce28 = distance2dsquared(point, bomborigin);

      if(var_b334ce28 > var_4f2a097f) {
        var_4f2a097f = var_b334ce28;
        var_f74183d3 = point;
      }

      if(var_b334ce28 > var_dcb6be80) {
        validpoints[validpoints.size] = point;
      }
    }
  }

  if(validpoints.size <= 0) {
    assert(isvec(var_f74183d3));
    validpoints[validpoints.size] = var_f74183d3;
  }

  return validpoints;
}

function private onplayerrevived(revivee, reviver) {
  if(isPlayer(reviver)) {
    reviver.var_c83d0859 = undefined;
    reviver.var_1eaa0d81 = undefined;
  }
}

function private function_ec3e7325(player) {
  assert(isPlayer(player));
  return player clientfield::get_player_uimodel("hudItems.uraniumMaxCarry");
}

function private function_cc2c46fd(player) {
  assert(isPlayer(player));
  return player clientfield::get_player_uimodel("hudItems.uraniumMaxCarry") == 10;
}

function private function_523bd02(canpickup) {
  assert(isPlayer(self));

  if(!isPlayer(self)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  if(canpickup) {
    self clientfield::set_player_uimodel("hudItems.uraniumFullCarry", 0);
    return;
  }

  if(isDefined(self.var_48c5e502) && self.var_48c5e502 > gettime()) {
    return;
  }

  self.var_48c5e502 = gettime() + int(4 * 1000);
  self clientfield::set_player_uimodel("hudItems.uraniumFullCarry", 1);
  wait 2;

  if(isPlayer(self)) {
    self clientfield::set_player_uimodel("hudItems.uraniumFullCarry", 0);
  }
}

function private function_3f63e44f(item) {
  assert(isDefined(item));
  assert(isDefined(item.itementry));

  if(item.itementry.itemtype == # "generic") {
    switch (item.itementry.name) {
      case # "uranium_item_t9":
        var_e3483afe = self clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
        canpickup = function_ec3e7325(self) > var_e3483afe;
        self thread function_523bd02(canpickup);
        return canpickup;
      case # "uranium_pouch_item_t9":
        return !function_cc2c46fd(self);
      case # "armor_pouch_item_t9":
        return !namespace_234f0efc::function_d912fa6e(self);
      case # "hash_583f1687cefbd3f3":
        return !namespace_234f0efc::function_36b9f4fe(self);
      default:
        return 0;
    }
  } else if(item.itementry.itemtype == # "scorestreak") {
    if(is_true(self.selectinglocation)) {
      return 0;
    }

    weapons = self getweaponslist();

    foreach(weapon in weapons) {
      var_16f12c31 = item_world_util::function_3531b9ba(weapon.name);

      if(isDefined(var_16f12c31) && self getweaponammostock(weapon) > 0) {
        return 0;
      }
    }

    return 1;
  } else if(item.itementry.itemtype == # "armor_shard") {
    return (self.var_c52363ab > self.armorplatecount);
  }

  return 0;
}

function private function_18f58ab2(item, player, networkid, itemid, itemcount, var_aec6fa7f, slot) {
  pickup = 0;

  switch (item.itementry.name) {
    case # "uranium_item_t9":
      pickup = function_bf46e093(item, player, networkid, itemid, itemcount, var_aec6fa7f, slot);
      break;
    case # "uranium_pouch_item_t9":
      pickup = function_fa78e80b(item, player, networkid, itemid, itemcount, var_aec6fa7f, slot);
      break;
    case # "armor_pouch_item_t9":
      pickup = namespace_234f0efc::function_dd8cb464(item, player, networkid, itemid, itemcount, var_aec6fa7f, slot);
      break;
    case # "hash_583f1687cefbd3f3":
      pickup = namespace_234f0efc::function_98942433(item, player, networkid, itemid, itemcount, var_aec6fa7f, slot);
      break;
  }

  return itemcount - pickup;
}

function private function_bf46e093(item, player, networkid, itemid, itemcount, var_aec6fa7f, slot) {
  var_e3483afe = var_aec6fa7f clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
  pickup = int(min(function_ec3e7325(var_aec6fa7f) - var_e3483afe, slot));
  var_aec6fa7f clientfield::set_player_uimodel("hudItems.uraniumCarryCount", var_e3483afe + pickup);

  if(var_e3483afe + pickup > 0) {
    var_aec6fa7f clientfield::set("carryingUranium", 1);
    var_aec6fa7f function_53d7badf(1);
  }

  if(pickup > 0) {
    var_aec6fa7f playSound("fly_uranium_pickup");

    if(!isDefined(itemcount.var_d25a1503) || itemcount.var_d25a1503 != var_aec6fa7f.team) {
      scoreevents::processscoreevent(#"hash_64121166dc49f54a", var_aec6fa7f);
      var_aec6fa7f contracts::increment_contract(#"hash_56ebf21401c9782c");
    }
  }

  if(var_e3483afe + pickup >= function_ec3e7325(var_aec6fa7f) || !is_true(var_aec6fa7f.var_2faaa10)) {
    var_aec6fa7f globallogic_audio::leader_dialog_on_player("dirtyBombUraniumMaxHold");
    var_aec6fa7f.var_2faaa10 = 1;
  }

  if(!isDefined(var_aec6fa7f.var_96c3af63)) {
    var_aec6fa7f luinotifyevent(#"hash_6b67aa04e378d681", 1, 14);
    var_aec6fa7f.var_96c3af63 = 1;
  }

  return pickup;
}

function private function_fa78e80b(item, player, networkid, itemid, itemcount, var_aec6fa7f, slot) {
  if(!function_cc2c46fd(slot)) {
    slot clientfield::set_player_uimodel("hudItems.uraniumMaxCarry", 10);
    return true;
  }

  return false;
}

function private function_62730899() {
  if(level.basegametype != "fireteam_dirty_bomb") {
    return;
  }

  if(isDefined(level.territory) && level.territory.name != "zoo") {
    namespace_2938acdc::function_4212369d();
    namespace_2938acdc::function_20d09030();
  }
}

function onstartgametype() {
  if(level.var_2064692e == 2) {
    function_38080aeb();
    function_ceb4a5e9();
    level thread function_59d5c0b2();
  } else if(level.var_96cdb906 != 0) {
    level thread function_8e2fb040();
  }

  level thread function_65f0fe7f();
  level thread function_8249279b();
  namespace_b77e8eb1::onstartgametype();
}

function onplayerspawned() {
  self.var_4ad2bfd3 = 0;
  self.var_cfc4949c = 1;
  self.var_6dc4d968 = 0;
  self.var_c83d0859 = undefined;
  self.var_1eaa0d81 = undefined;
  self.pers[# "killstreaks"] = [];
  self namespace_234f0efc::function_b0000c15();
  self clientfield::set_player_uimodel("hudItems.uraniumCarryCount", 0);
  self clientfield::set_player_uimodel("hudItems.uraniumMaxCarry", 5);
  self clientfield::set_player_uimodel("hudItems.uraniumFullCarry", 0);
  self clientfield::set("carryingUranium", 0);
  self function_53d7badf(0);
}

function on_player_killed(params) {
  aliveplayers = function_a1cff525(self.squad);

  if(aliveplayers.size == 0) {
    if(params.eattacker util::isenemyplayer(self)) {
      params.eattacker globallogic_audio::leader_dialog_on_player("dirtyBombFireteamWiped");
    }
  } else if(aliveplayers.size == 1) {
    if(!isDefined(level.var_e2384c19) && !aliveplayers[0] laststand::player_is_in_laststand()) {
      aliveplayers[0] globallogic_audio::leader_dialog_on_player("dirtyBombFireteamWipedFriendly");
    }
  }

  if(params.eattacker util::isenemyplayer(self)) {
    if(is_true(self.var_c83d0859)) {
      scoreevents::processscoreevent(#"hash_b15e641945148d4", params.eattacker, self, params.weapon);
    } else if(is_true(self.var_1eaa0d81)) {
      scoreevents::processscoreevent(#"hash_5d532825a2d0023", params.eattacker, self, params.weapon);
    }

    if(self clientfield::get_player_uimodel("hudItems.uraniumCarryCount") >= 5) {
      scoreevents::processscoreevent(#"hash_e9913b29988d98d", params.eattacker, self, params.weapon);
    }
  }

  self function_80d6d39b();
  self.var_9dc65a85 = 0;
  self.var_c83d0859 = undefined;
  self.var_1eaa0d81 = undefined;

  if(!getdvarint(#"hash_766c487cde5735c8", 0)) {
    var_4c42f7cf = 0;
    var_4c42f7cf = self namespace_234f0efc::function_d5766919(var_4c42f7cf);
    var_4c42f7cf = self function_d67bd905(var_4c42f7cf + 1);
    var_4c42f7cf = self namespace_234f0efc::function_b31f892b(var_4c42f7cf + 1);
    var_4c42f7cf = self namespace_234f0efc::function_e50b5cec(var_4c42f7cf + 1);
    var_4c42f7cf = self function_15d1af86(var_4c42f7cf + 1);
    var_4c42f7cf = self namespace_234f0efc::drop_armor(var_4c42f7cf + 1);
  }

  self namespace_234f0efc::function_b0000c15();

  if(!isDefined(level.var_e2384c19)) {
    self.var_6dc4d968 = 1;
  }

  level function_28039abb();
}

function function_bf88f2fd(player1, player2) {
  foreach(bomb in level.var_2f418a15) {
    if(!isDefined(bomb) || !isDefined(bomb.state) || !isDefined(bomb.trigger)) {
      continue;
    }

    if(isDefined(player1) && distancesquared(bomb.origin, player1.origin) <= 40000) {
      return true;
    }

    if(isDefined(player2) && distancesquared(bomb.origin, player2.origin) <= 40000) {
      return true;
    }
  }

  return false;
}

function function_610d3790(einflictor, victim, idamage, weapon) {
  var_d9e4d6db = is_true(weapon.var_c83d0859) || is_true(weapon.var_1eaa0d81) || is_true(self.var_c83d0859) || is_true(self.var_1eaa0d81);
  var_531e2363 = isDefined(weapon.laststandparams.var_60cb0c39) && weapon.laststandparams.var_60cb0c39;

  if(var_d9e4d6db || var_531e2363 || function_bf88f2fd(self, weapon)) {
    if(isDefined(weapon.var_1318544a)) {
      weapon.var_1318544a.var_60cb0c39 = 1;
    }

    self.pers[# "objectiveekia"]++;
    self.objectiveekia = self.pers[# "objectiveekia"];
    [[level.var_37d62931]](self, 1);
    self globallogic_score::incpersstat(#"objectivescore", 1, 0, 1);
  }
}

function function_82b353bf(attacker) {
  if(isDefined(attacker) && (is_true(attacker.var_c83d0859) || is_true(attacker.var_1eaa0d81))) {
    return true;
  }

  if(is_true(self.var_c83d0859) || is_true(self.var_1eaa0d81)) {
    return true;
  }

  if(function_bf88f2fd(self, attacker)) {
    return true;
  }

  return false;
}

function private function_95002a59(attacker, victim, inflictor, weapon, meansofdeath) {
  if(meansofdeath == self) {
    return;
  }

  if(isDefined(meansofdeath)) {
    meansofdeath.pers[# "downs"] = (isDefined(meansofdeath.pers[# "downs"]) ? meansofdeath.pers[# "downs"] : 0) + 1;
    meansofdeath.downs = meansofdeath.pers[# "downs"];
  }
}

function private function_a997e9c5(index, id, origin, angles, var_fd3ba46d = 0) {
  self endon(#"disconnect");
  dropitem = level item_drop::drop_item(index, undefined, 1, 0, id, origin, angles, 2);

  if(var_fd3ba46d && isPlayer(self) && isDefined(dropitem)) {
    dropitem hidefromplayer(self);
    self waittill(#"death_delay_finished");

    if(isPlayer(self) && isDefined(dropitem)) {
      dropitem showtoplayer(self);
    }
  }
}

function private function_15d1af86(var_4c42f7cf) {
  if(!isPlayer(self)) {
    assert(0);
    return;
  }

  var_e3483afe = self clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
  var_468a16f = 1;

  if(isDefined(self.laststandparams) && isDefined(self.laststandparams.attacker) && isPlayer(self.laststandparams.attacker) && self.laststandparams.attacker == self) {
    var_468a16f = 0;
  }

  var_e3483afe += var_468a16f;
  self clientfield::set_player_uimodel("hudItems.uraniumCarryCount", 0);
  self clientfield::set("carryingUranium", 0);
  self function_53d7badf(0);
  itempoint = function_4ba8fde(#"uranium_item_t9");

  for(index = 0; index < var_e3483afe; index++) {
    self thread function_a997e9c5(var_4c42f7cf + index, itempoint.id, self.origin, (0, randomintrange(0, 360), 0), index == var_e3483afe - 1);
  }

  return var_4c42f7cf + index;
}

function private function_d67bd905(var_4c42f7cf) {
  assert(isPlayer(self));
  index = 0;

  if(function_cc2c46fd(self)) {
    itempoint = function_4ba8fde("uranium_pouch_item_t9");
    level thread item_drop::function_7910964d(var_4c42f7cf + index, undefined, 1, 0, itempoint.id, self.origin, (0, randomintrange(0, 360), 0), 2);
    index++;
    self clientfield::set_player_uimodel("hudItems.uraniumMaxCarry", 5);
  }

  return var_4c42f7cf + index;
}

function playerrespawndelay() {
  var_d34d1e15 = 0;

  if(is_true(level.waverespawndelay)) {
    var_d34d1e15 = self globallogic_spawn::timeuntilwavespawn(level.playerrespawndelay);
  } else {
    var_d34d1e15 = level.playerrespawndelay;
  }

  if(isDefined(level.var_e2384c19) && !is_true(self.var_6dc4d968)) {
    var_18947c8c = level.var_e2384c19 - float(gettime()) / 1000;

    if(var_18947c8c > var_d34d1e15) {
      return var_18947c8c;
    }
  }

  return var_d34d1e15;
}

function function_5feabd33() {
  var_cc03b04e = self clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
  return level.var_81a49fc0 * var_cc03b04e;
}

function function_2017a28e() {
  var_cc03b04e = self clientfield::get_player_uimodel("hudItems.uraniumCarryCount");
  return level.var_a22f8001 * var_cc03b04e;
}

function function_e3c3aba5() {
  self globallogic_audio::leader_dialog_on_player("dirtyBombRadStage" + self.radiation.var_32adf91d);
}

function private function_65f0fe7f() {
  level endon(#"game_ended");

  while(true) {
    foreach(player in getplayers()) {
      if(!isalive(player) || player inlaststand()) {
        continue;
      }

      isbuttonpressed = player function_28655ef2() || player actionslottwobuttonPressed();

      if(!isbuttonpressed || is_false(player.var_c60ad697)) {
        player.var_c60ad697 = !isbuttonpressed;
        continue;
      }

      player.var_c60ad697 = 0;
      player function_f917644c();
    }

    waitframe(1);
  }
}

function private function_8249279b() {
  level endon(#"game_ended");

  while(true) {
    players = getplayers();
    var_cf0783b8 = [];

    foreach(player in getplayers()) {
      var_cf0783b8[player getentitynumber()] = player;
    }

    foreach(bomb in level.var_2f418a15) {
      if(!isDefined(bomb) || !isDefined(bomb.state) || !isDefined(bomb.trigger)) {
        continue;
      }

      if(bomb.state != 4) {
        continue;
      }

      playersinradius = getplayers(undefined, bomb.origin, 120);

      foreach(player in playersinradius) {
        if(player istouching(bomb.trigger)) {
          player val::set(#"fireteam_dirty_bomb", "disable_weapon_pickup", 1);
          var_cf0783b8[player getentitynumber()] = undefined;
        }
      }
    }

    arrayremovevalue(var_cf0783b8, undefined, 1);

    foreach(player in var_cf0783b8) {
      player val::set(#"fireteam_dirty_bomb", "disable_weapon_pickup", 0);
    }

    wait 0.5;
  }
}

function function_f917644c() {
  var_cc03b04e = self clientfield::get_player_uimodel("hudItems.uraniumCarryCount");

  if(var_cc03b04e == 0) {
    return;
  }

  itempoint = function_4ba8fde(#"uranium_item_t9");
  originoffset = (0, 0, 6);
  dropangles = self.angles + (0, randomintrange(-30, 30), 0);
  forward = anglesToForward(dropangles);
  droporigin = self.origin + originoffset + forward * (randomfloatrange(10, 30) + 18);
  traceresults = physicstraceex(self.origin + originoffset, droporigin, (0, 0, 0), (0, 0, 0), self, 1);

  if(traceresults[# "fraction"] < 1) {
    droporigin = traceresults[# "position"] - forward * 18;
  } else {
    droporigin -= forward * 18;
  }

  waitframe(1);

  if(!isDefined(self)) {
    return;
  }

  dropitem = self item_drop::drop_item(0, undefined, 1, 1, itempoint.id, droporigin, dropangles, 2);

  if(!isDefined(dropitem)) {
    return;
  }

  dropitem item_drop::function_801fcc9e(int(2 * 1000));
  dropitem.var_d25a1503 = self.team;
  self clientfield::set_player_uimodel("hudItems.uraniumCarryCount", var_cc03b04e - 1);
  self.var_4ad2bfd3 = gettime();
  self function_58b29f4f();
  var_cc03b04e = self clientfield::get_player_uimodel("hudItems.uraniumCarryCount");

  if(var_cc03b04e <= 0) {
    function_53d7badf(0);
    self clientfield::set("carryingUranium", 0);
  }
}

function function_277ec378(var_c18a13b5) {
  globallogic_audio::function_61e17de0("dirtyBombRadExpand", getplayers(undefined, var_c18a13b5, 4500));
}

function function_334e317(var_c18a13b5) {
  globallogic_audio::function_61e17de0("dirtyBombRadRecede", getplayers(undefined, var_c18a13b5, 4500));
}

function function_8e2fb040() {
  level endon(#"game_ended");
  function_38080aeb();
  function_693f50f5();
  level flag::wait_till(#"insertion_begin_completed");

  while(true) {
    function_c5d8437d();

    if(level.var_4e3c4685 != 0) {
      wait level.var_4e3c4685;
      function_a05584ae();
    } else {
      while(true) {
        var_d8b86297 = 0;

        for(i = 0; i < level.var_2f418a15.size; i++) {
          if(level.var_2f418a15[i].state != 0) {
            var_d8b86297 = 1;
            break;
          }
        }

        if(!var_d8b86297) {
          break;
        }

        waitframe(1);
      }

      if(isDefined(level.var_320e6819)) {
        level.var_320e6819 = undefined;
      }
    }

    function_693f50f5();

    if(level.var_26c7635a != 0) {
      luinotifyevent(#"hash_2977456e1832eba6");
      clientfield::set_world_uimodel("hud_items_dirty_bomb.bomb_respawn_disabled", 1);

      foreach(player in level.players) {
        if(!isalive(player)) {
          player notify(#"hash_33713849648e651d");
        }
      }

      if(level.var_12ff620b < level.var_26c7635a) {
        wait level.var_12ff620b;
        function_1c3c84b4();
        wait level.var_26c7635a - level.var_12ff620b;
      } else {
        wait level.var_26c7635a;
      }

      clientfield::set_world_uimodel("hud_items_dirty_bomb.bomb_respawn_disabled", 0);
    }
  }
}

function function_38080aeb() {
  level.dirtybombs = struct::get_array("fireteam_dirty_bomb", "variantname");

  if(level.dirtybombs.size == 0) {
    return;
  }

  function_87b2107c(level.dirtybombs);

  foreach(bomb in level.dirtybombs) {
    bomb.state = 0;
  }
}

function function_59d5c0b2() {
  level endon(#"game_ended");
  level flag::wait_till(#"insertion_begin_completed");
  function_c5d8437d();
}

function function_87b2107c(&structs) {
  var_e8a4ae59 = 64;
  var_a3c01952 = 1024;

  foreach(struct in structs) {
    startorigin = struct.origin + (0, 0, var_e8a4ae59);
    endorigin = startorigin - (0, 0, var_a3c01952);
    trace = physicstraceex(startorigin, endorigin, (-0.5, -0.5, -0.5), (0.5, 0.5, 0.5), undefined, 1);
    struct.origin = trace[# "position"];
  }
}

function function_693f50f5() {
  if(level.var_2064692e == 0) {
    function_ceb4a5e9();
    return;
  }

  if(level.var_2064692e == 1) {
    function_5757c66f();
  }
}

function function_ceb4a5e9() {
  if(level.dirtybombs.size < level.var_96cdb906) {
    level.dirtybombs = struct::get_array("fireteam_dirty_bomb", "variantname");
  }

  for(i = 0; i < level.var_96cdb906; i++) {
    bombindex = randomint(level.dirtybombs.size);
    var_26bc1595 = 0;
    attempts = 0;

    do {
      var_26bc1595 = 0;

      foreach(bomb in level.var_2f418a15) {
        if(bomb == level.dirtybombs[bombindex]) {
          var_26bc1595 = 1;
          attempts++;
          break;
        }

        if(distancesquared(bomb.origin, level.dirtybombs[bombindex].origin) < 4000000) {
          var_26bc1595 = 1;
          attempts++;
          break;
        }
      }

      if(var_26bc1595) {
        bombindex = randomint(level.dirtybombs.size);
      }
    }
    while(var_26bc1595 && attempts < 30);

    level.var_2f418a15[level.var_2f418a15.size] = level.dirtybombs[bombindex];
    level.dirtybombs[bombindex] = level.dirtybombs[level.dirtybombs.size - 1];
    level.dirtybombs[level.dirtybombs.size - 1] = undefined;
  }
}

function function_5757c66f() {
  if(!isDefined(level.var_d83e193a) || level.var_d83e193a.size <= 0) {
    function_18b08e66();
  }

  if(level.var_d83e193a.size == 0) {
    assertmsg("<dev string:x38>");
    function_ceb4a5e9();
    return;
  }

  var_704364cb = getarraykeys(level.var_d83e193a);
  setindex = randomint(var_704364cb.size);
  var_2a0f16b1 = var_704364cb[setindex];
  level.var_d83e193a[var_2a0f16b1] = undefined;
  var_2e89cb0a = 0;

  foreach(bomb in level.dirtybombs) {
    if(bomb.state != 0) {
      continue;
    }

    if(bomb.var_6956912d == var_2a0f16b1) {
      level.var_2f418a15[level.var_2f418a15.size] = bomb;
      var_2e89cb0a++;
    }

    if(var_2e89cb0a >= level.var_96cdb906) {
      break;
    }
  }
}

function function_cca53f41(objectiveid, objindex) {
  if(level.dirtybombs.size == 0) {
    level.dirtybombs = struct::get_array("fireteam_dirty_bomb", "variantname");
  }

  bombindex = randomint(level.dirtybombs.size);
  var_26bc1595 = 0;
  attempts = 0;

  do {
    var_26bc1595 = 0;

    foreach(bomb in level.var_2f418a15) {
      if(bomb == level.dirtybombs[bombindex]) {
        var_26bc1595 = 1;
        attempts++;
        break;
      }

      if(distancesquared(bomb.origin, level.dirtybombs[bombindex].origin) < 4000000) {
        var_26bc1595 = 1;
        attempts++;
        break;
      }
    }

    if(var_26bc1595) {
      bombindex = randomint(level.dirtybombs.size);
    }
  }
  while(var_26bc1595 && attempts < 30);

  bomb = level.dirtybombs[bombindex];
  level.var_2f418a15[level.var_2f418a15.size] = bomb;
  level.dirtybombs[bombindex] = level.dirtybombs[level.dirtybombs.size - 1];
  level.dirtybombs[level.dirtybombs.size - 1] = undefined;

  if(isDefined(objectiveid)) {
    objective_delete(objectiveid);
    gameobjects::release_obj_id(objectiveid);
  }

  bomb.objindex = objindex;
  bomb function_f37d284();
  bomb function_b801b00c();
  bomb function_fb51b5a4();
  objective_setgamemodeflags(bomb.objectiveid, 2);
  bomb.var_cc03b04e = 0;
  bomb.state = 2;
}

function function_18b08e66() {
  if(!isDefined(level.var_d83e193a)) {
    level.var_d83e193a = [];
  }

  foreach(bomb in level.dirtybombs) {
    if(!isDefined(level.var_d83e193a[bomb.var_6956912d])) {
      level.var_d83e193a[bomb.var_6956912d] = bomb.var_6956912d;
    }
  }
}

function function_a9d8729c(dialogkey, origin, radius) {
  var_4b3fe4a6 = [];
  nearbyplayers = getplayers(undefined, origin, radius);

  foreach(player in nearbyplayers) {
    if(!array::contains(var_4b3fe4a6, player.team)) {
      var_4b3fe4a6[var_4b3fe4a6.size] = player.team;
      globallogic_audio::leader_dialog(dialogkey, player.team);
    }
  }
}

function function_93098bd9(dialogkey, team, origin, radius) {
  if(!isDefined(dialogkey)) {
    assert(0);
    return;
  }

  if(!isDefined(team)) {
    assert(0);
    return;
  }

  players = getplayers(team, origin, radius);

  if(players.size > 0) {
    globallogic_audio::function_61e17de0(dialogkey, players);
  }
}

function function_e43bca0f(dialogkey, skipteam, origin, radius) {
  if(!isDefined(dialogkey)) {
    assert(0);
    return;
  }

  if(!isDefined(skipteam)) {
    assert(0);
    return;
  }

  foreach(team, _ in level.teams) {
    if(team != skipteam) {
      function_93098bd9(dialogkey, team, origin, radius);
    }
  }
}

function function_c5d8437d() {
  function_cd2bee53();

  for(i = 0; i < level.var_2f418a15.size; i++) {
    bomb = level.var_2f418a15[i];

    if(!isDefined(bomb.state) || bomb.state == 0) {
      bomb.objindex = i % 5;
      bomb function_f37d284();
      bomb function_b801b00c();
    } else if(isDefined(bomb.state) && bomb.state != 1) {
      continue;
    }

    bomb function_fb51b5a4();
    objective_setgamemodeflags(bomb.objectiveid, 2);
    bomb.var_cc03b04e = 0;
    bomb.state = 2;
  }

  if(!is_true(level.var_169e6bcb)) {
    globallogic_audio::function_61e17de0("dirtyBombOnline", getplayers());
    level.var_169e6bcb = 1;
    return;
  }

  if(level.var_96cdb906 > 1) {
    globallogic_audio::function_61e17de0("dirtyBombActive" + level.var_2f418a15.size, getplayers());
    globallogic_audio::function_61e17de0("dirtyBombRespawnEnabled", getplayers());
  }
}

function function_1c3c84b4() {
  function_cd2bee53();

  for(i = 0; i < level.var_2f418a15.size; i++) {
    bomb = level.var_2f418a15[i];

    if(isDefined(bomb.state) && bomb.state != 0) {
      continue;
    }

    bomb.objindex = i % 5;
    bomb function_f37d284();
    bomb function_b801b00c();
    objective_setgamemodeflags(bomb.objectiveid, 5);
    bomb.state = 1;
  }
}

function function_cd2bee53() {
  if(level.var_910f361c.size == 0) {
    return;
  }

  foreach(objid in level.var_910f361c) {
    objective_delete(objid);
    gameobjects::release_obj_id(objid);
  }

  level.var_910f361c = [];
}

function private function_f37d284() {
  self.model = spawn("script_model", self.origin + (0, 0, 0));
  self.model.angles = self.angles;
  self.model setModel("p9_wz_dirty_bomb_01");
  self.model function_619a5c20();
  self.model.killcament = spawn("script_model", self.model.origin + (0, 0, 40));
  self.model.killcament setModel(#"tag_origin");
  self.model.killcament.angles = (0, 0, 0);
  self.model.killcament setweapon(level.weaponnone);
}

function private function_b801b00c() {
  self.objectiveid = gameobjects::get_next_obj_id();
  objective = level.var_d8fd137b[self.objindex];
  objective_add(self.objectiveid, "active", self.model, objective);
  function_9a8950ee(self.objectiveid, 1);
}

function private function_fb51b5a4() {
  self.trigger = spawn("trigger_radius", self.origin + (0, 0, 45), 0, 120, 90, 1);
  self.trigger triggerignoreteam();
  self.trigger triggerenable(1);
  self.trigger callback::on_trigger(&function_fcc87504);
  self.trigger setinvisibletoall();

  foreach(player in getplayers()) {
    if(player clientfield::get_player_uimodel("hudItems.uraniumCarryCount") > 0) {
      self.trigger setinvisibletoplayer(player, 0);
    }
  }

  self.trigger.bomb = self;
}

function private function_fcc87504(triggerstruct) {
  if(is_true(level.gameended)) {
    return;
  }

  activator = triggerstruct.activator;

  if(is_true(activator.var_9dc65a85)) {
    return;
  }

  bomb = self.bomb;

  if(!function_a4521a9b(activator)) {
    return;
  }

  if(!function_ad9de896(activator, bomb)) {
    return;
  }

  activator playLoopSound(#"hash_444112674e0eba78");
  activator.var_c83d0859 = 1;

  for(success = activator function_99898a2d(bomb); is_true(success) && bomb.state == 2; success = activator function_99898a2d(bomb)) {
    if(!isDefined(activator)) {
      return;
    }

    if(!function_a4521a9b(activator)) {
      break;
    }

    if(!function_ad9de896(activator, bomb)) {
      break;
    }

    if(game.state != # "playing") {
      break;
    }

    self triggerenable(1);
  }

  if(!isDefined(activator)) {
    return;
  }

  activator stoploopsound();

  if(isalive(activator) && !activator inlaststand()) {
    activator.var_c83d0859 = undefined;
  }

  var_a5d31314 = activator clientfield::get_player_uimodel("hudItems.uraniumCarryCount");

  if(bomb.state == 2 && var_a5d31314 <= 0) {
    bomb.model playsoundtoplayer(#"hash_1cc6a788d45a7d48", activator);
  }

  activator function_80d6d39b();
  activator function_a7af3a2a();
}

function private function_99898a2d(bomb) {
  self endon(#"disconnect");
  trigger = bomb.trigger;
  success = 0;

  if(isDefined(bomb)) {
    prevtime = gettime();
    var_e18791f4 = int(level.var_932f538d * 1000);
    totalprogress = 0;
    bomb thread function_704fdca0(self);

    while(self function_ce8f2021(bomb)) {
      progress = gettime() - prevtime;
      totalprogress += progress;
      prevtime = gettime();

      if(totalprogress >= var_e18791f4) {
        success = 1;
        bomb thread function_3b72c4b2(self);
        break;
      }

      if(totalprogress > 0) {
        self function_9db99d2f(totalprogress / var_e18791f4);
      }

      waitframe(1);
    }

    if(!success) {
      bomb thread function_ea25bba7(self);
    }
  }

  self function_80d6d39b();
  return success;
}

function private function_45a85e5b(revivee) {
  if(!isDefined(self) || !isDefined(revivee)) {
    return false;
  }

  return self.var_1eaa0d81 !== 1;
}

function function_ad9de896(player, bomb) {
  if(!isPlayer(player)) {
    assert(0);
    return false;
  }

  if(!isDefined(bomb)) {
    assert(0);
    return false;
  }

  if(!isDefined(bomb.model)) {
    return false;
  }

  var_14448f85 = (0, 0, 24);
  camerapos = player getplayercamerapos();
  traceresult = bulletTrace(camerapos, bomb.origin + var_14448f85, 0, player, 0, 0);

  if(traceresult[# "entity"] !== bomb.model) {
    return false;
  }

  return true;
}

function function_a4521a9b(player) {
  if(player isinvehicle()) {
    return false;
  }

  var_cc03b04e = player clientfield::get_player_uimodel("hudItems.uraniumCarryCount");

  if(var_cc03b04e > 0) {
    return true;
  }

  return false;
}

function function_ce8f2021(bomb) {
  if(bomb.state != 2) {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  if(self inlaststand()) {
    return false;
  }

  if(!isDefined(bomb.trigger)) {
    return false;
  }

  if(!bomb.trigger istriggerenabled()) {
    return false;
  }

  if(!self istouching(bomb.trigger)) {
    return false;
  }

  if(game.state != # "playing") {
    return false;
  }

  return true;
}

function function_3b72c4b2(player) {
  player function_80d6d39b();

  if(game.state != # "playing") {
    return;
  }

  if(self.state != 2) {
    return;
  }

  player.var_9dc65a85 = 0;
  objective_clearplayerusing(self.objectiveid, player);
  var_cc03b04e = player clientfield::get_player_uimodel("hudItems.uraniumCarryCount");

  if(var_cc03b04e <= 0) {
    return;
  }

  if(!isDefined(self.var_cc03b04e)) {
    self.var_cc03b04e = 0;
  }

  self.var_cc03b04e++;
  objective_setprogress(self.objectiveid, self.var_cc03b04e / level.var_3990ce92);

  if(level.var_e65e9422) {
    player globallogic_score::giveteamscoreforobjective(player.team, level.var_e65e9422);
    function_e2d09d87(player.team);
  }

  scoreevents::processscoreevent(#"hash_405ccdd657f10e0e", player);
  player contracts::increment_contract(#"hash_6339095ae9a767d6");
  player clientfield::set_player_uimodel("hudItems.uraniumCarryCount", var_cc03b04e - 1);
  [[level.var_37d62931]](player, 1);
  player.pers[# "dirty_bomb_deposits"] = (isDefined(player.pers[# "dirty_bomb_deposits"]) ? player.pers[# "dirty_bomb_deposits"] : 0) + 1;
  player.dirty_bomb_deposits = player.pers[# "dirty_bomb_deposits"];
  player globallogic_score::incpersstat(#"objectivescore", 1, 0, 1);
  player stats::function_bb7eedf0(#"dirty_bomb_deposits", 1);

  if(game.state != # "playing") {
    return;
  }

  level function_28039abb();

  if(var_cc03b04e - 1 <= 0) {
    player clientfield::set("carryingUranium", 0);
    player function_53d7badf(0);
  }

  if(self.var_cc03b04e >= level.var_3990ce92) {
    self function_5c84cd7c();

    if(isDefined(player)) {
      function_93098bd9("dirtyBombPrimedFriendly", player.team, self.origin, 4500);
      function_e43bca0f("dirtyBombPrimedEnemy", player.team, self.origin, 4500);
      players = getplayers(player.team);

      foreach(var_7b66d20c in players) {
        if(!isDefined(var_7b66d20c.var_b0a8d09c) && isalive(var_7b66d20c)) {
          var_7b66d20c luinotifyevent(#"hash_6b67aa04e378d681", 1, 15);
          var_7b66d20c.var_b0a8d09c = 1;
        }
      }
    }

    self thread function_4b31d6ba();
  }
}

function function_704fdca0(player) {
  self endon(#"disconnect");

  if(self.state == 2) {
    player function_3bf6db8b(#"defaultstate", self.trigger);
    player clientfield::set_to_player("using_bomb", 1);
  } else if(self.state == 4) {
    self.trigger function_6e23e4cb(player);
    player function_3bf6db8b(#"detonating", self.trigger);
    player clientfield::set_to_player("using_bomb", 2);
  }

  player.var_9dc65a85 = 1;
  objective_setplayerusing(self.objectiveid, player);
}

function private function_63909e4a() {
  if(!isPlayer(self)) {
    return;
  }

  if(isalive(self) && !self inlaststand()) {
    self.var_1eaa0d81 = undefined;
  }
}

function function_ea25bba7(player) {
  if(!isPlayer(player)) {
    return;
  }

  player function_80d6d39b();

  if(self.state == 2) {
    player.var_c83d0859 = undefined;
  } else if(self.state == 4) {
    self.trigger function_6e23e4cb();
    player function_63909e4a();

    if(!getdvarint(#"hash_6d01658e46435b76", 0)) {
      player enableweaponcycling();
      player enableoffhandweapons();
      player enableweaponswitchhero();
      player thread take_use_weapon(level.var_696298a2);

      if(player getcurrentweapon() === level.var_696298a2) {
        player killstreaks::switch_to_last_non_killstreak_weapon();
      }
    } else {
      player setlowready(0);
    }
  }

  player.var_9dc65a85 = 0;

  if(isDefined(self.objectiveid)) {
    objective_clearplayerusing(self.objectiveid, player);
  }
}

function take_use_weapon(useweapon) {
  self endon(#"use_hold", #"death", #"disconnect");
  level endon(#"game_ended");

  while(self getcurrentweapon() == useweapon && !self.throwinggrenade) {
    waitframe(1);
  }

  if(is_true(useweapon.var_d2751f9d)) {
    self val::reset(#"gameobject_use", "disable_gestures");
  }

  self takeweapon(useweapon);
}

function function_a05584ae() {
  var_a737309d = 0;

  for(i = 0; i < level.var_2f418a15.size; i++) {
    if(level.var_2f418a15[i].state == 2) {
      level.var_2f418a15[i] function_b43466d5();
      level.var_2f418a15[i] = level.var_2f418a15[level.var_2f418a15.size - 1];
      level.var_2f418a15[level.var_2f418a15.size - 1] = undefined;
      i--;
      var_a737309d++;
    }
  }

  if(var_a737309d == 1) {
    globallogic_audio::function_61e17de0("dirtyBombOffline", getplayers());
  } else if(var_a737309d > 1) {
    globallogic_audio::function_61e17de0("dirtyBombOfflineMult", getplayers());
  }

  globallogic_audio::function_61e17de0("dirtyBombRespawnDisabled", getplayers());
}

function function_b43466d5() {
  self.model.killcament delete();
  self.model delete();
  objective_delete(self.objectiveid);
  gameobjects::release_obj_id(self.objectiveid);
  self.var_cc03b04e = undefined;
  self.state = 0;
}

function function_5c84cd7c() {
  self.state = 3;
  objective_setgamemodeflags(self.objectiveid, 5);
  self.model playSound(#"hash_2013c3b9f7d5a632");
  self.trigger delete();
}

function function_4b31d6ba() {
  level endon(#"game_ended");

  if(level.var_e39b6425 != 0) {
    self.model playSound(#"hash_4835397d4779d016");
    wait level.var_e39b6425;
    self.model stopsound(#"hash_4835397d4779d016");
    self.model playSound(#"hash_1e349183ce55d6ff");
  }

  self function_99c4c4e5();
  self thread function_dc70ca08();
}

function function_99c4c4e5() {
  self.state = 4;
  function_6da98133(self.objectiveid);
  objective_setgamemodeflags(self.objectiveid, 3);
  objective_setprogress(self.objectiveid, 0);
  self function_6a9ca122();
  self.trigger thread function_f9f4b255();

  if(level.var_2f418a15.size == 1) {
    self thread function_2eeb579c();
  }
}

function private function_6a9ca122() {
  self.trigger = spawn("trigger_radius_use", self.origin + (0, 0, 45), 0, 120, 90, 1);
  self.trigger triggerignoreteam();
  self.trigger setcursorhint("HINT_NOICON");
  self.trigger triggerenable(1);
  self.trigger usetriggerignoreuseholdtime();
  self.trigger sethintstring("MENU/PROMPT_DIRTY_BOMB_DETONATE");
  self.trigger callback::on_trigger(&function_2f5dd98c);
  self.trigger.bomb = self;
  self.var_dac45cd5 = spawn("trigger_radius", self.origin + (0, 0, 45), 0, 120, 90, 1);
  self.var_dac45cd5 triggerignoreteam();
  self.var_dac45cd5 triggerenable(0);
  self.var_dac45cd5 callback::on_trigger(&function_43bfe93d);
  self.var_dac45cd5 setinvisibletoall();
  self.var_dac45cd5.bomb = self;
}

function private function_2f5dd98c(triggerstruct) {
  if(is_true(level.gameended)) {
    return;
  }

  activator = triggerstruct.activator;

  if(is_true(activator.var_9dc65a85)) {
    return;
  }

  bomb = self.bomb;

  if(bomb.state != 4) {
    return;
  }

  if(isDefined(bomb.trigger.activator)) {
    return;
  }

  activator function_84cb44bc(bomb);
}

function private function_84cb44bc(bomb) {
  self endon(#"disconnect");

  if(bomb.state == 4) {
    if(!getdvarint(#"hash_6d01658e46435b76", 0)) {
      if(self isswitchingweapons()) {
        return;
      }

      useweapon = level.var_696298a2;

      if(is_true(useweapon.var_d2751f9d)) {
        self val::set(#"gameobject_use", "disable_gestures");
      }

      if(!self hasweapon(useweapon)) {
        self giveweapon(useweapon);
      }

      self setweaponammostock(useweapon, 0);
      self setweaponammoclip(useweapon, 0);
      self switchtoweapon(useweapon);
      self disableweaponcycling();
      self disableoffhandweapons();
      self disableweaponswitchhero();
    } else {
      self setlowready(1);
    }

    bomb.trigger setinvisibletoall();
    bomb.trigger setvisibletoplayer(self);
    bomb.var_dac45cd5 triggerenable(1);
    bomb.var_dac45cd5 setvisibletoteam(self.team);
    bomb.var_dac45cd5 setinvisibletoplayer(self);
    self.var_1eaa0d81 = 1;
    bomb thread function_704fdca0(self);
    bomb.trigger.activator = self;
  }
}

function private function_43bfe93d(triggerstruct) {
  if(is_true(level.gameended)) {
    return;
  }

  activator = triggerstruct.activator;

  if(is_true(activator.var_9dc65a85) || activator inlaststand()) {
    return;
  }

  bomb = self.bomb;

  if(bomb.state != 4) {
    return;
  }

  if(!isDefined(bomb.trigger.activator) || bomb.trigger.activator.team != activator.team) {
    return;
  }

  activator function_f79653f(bomb);
}

function private function_f79653f(bomb) {
  self endon(#"disconnect");

  if(bomb.state == 4) {
    if(!isDefined(bomb.trigger.assists)) {
      bomb.trigger.assists = [];
    }

    bomb.trigger.assists[bomb.trigger.assists.size] = self;
    bomb thread function_704fdca0(self);
  }
}

function private function_f9f4b255() {
  self endon(#"death");
  self.assists = [];
  prevtime = gettime();
  var_e18791f4 = int(level.var_b06a1891 * 1000);
  totalprogress = 0;
  var_b1c451bf = int(level.var_f4a1440c / 0.05 * 1000);
  bomb = self.bomb;

  while(isDefined(bomb) && bomb.state == 4) {
    if(isDefined(self.activator)) {
      bomb.model playLoopSound(#"hash_5093c3a0e7047aa", 0.5);
      var_39c4d694 = !self.activator function_8e1791eb(bomb);

      if(var_39c4d694) {
        bomb thread function_ea25bba7(self.activator);
        bomb.var_dac45cd5 triggerenable(0);
        bomb.var_dac45cd5 setinvisibletoall();
        bomb.trigger setvisibletoall();
        self.activator function_63909e4a();
      }

      for(i = 0; i < self.assists.size; i++) {
        player = self.assists[i];

        if(var_39c4d694) {
          bomb thread function_ea25bba7(player);
          continue;
        }

        if(!player function_75a48e71(bomb)) {
          bomb thread function_ea25bba7(player);

          for(j = i; j < self.assists.size; j++) {
            if(j + 1 >= self.assists.size) {
              self.assists[j] = undefined;
              continue;
            }

            self.assists[j] = self.assists[j + 1];
          }

          i--;
        }
      }

      if(var_39c4d694) {
        self.assists = [];
      }

      currtime = gettime();

      if(isDefined(level.var_320e6819)) {
        var_60f07198 = float(currtime - level.var_320e6819) / 1000 / level.var_d86d5820;
        var_233ab686 = (level.var_b06a1891 - level.var_f4a1440c) * var_60f07198;
        var_e18791f4 = int((level.var_b06a1891 - var_233ab686) * 1000);
      }

      deltatime = currtime - prevtime;
      progress = deltatime * (1 + self.assists.size);
      progress = min(progress, var_b1c451bf);
      totalprogress += progress;

      if(totalprogress >= var_e18791f4) {
        bomb thread function_5c0f763b(self.activator);
        break;
      }

      if(totalprogress > 0) {
        if(isDefined(bomb.objectiveid)) {
          objective_setprogress(bomb.objectiveid, totalprogress / var_e18791f4);
        }

        self.activator function_9db99d2f(totalprogress / var_e18791f4);
        self.activator function_45c10c43(self.assists.size + 1);

        foreach(player in self.assists) {
          player function_9db99d2f(totalprogress / var_e18791f4);
          player function_45c10c43(self.assists.size + 1);
        }
      }

      if(var_39c4d694) {
        self.activator = undefined;
      }
    } else if(!level.var_3a9e7236) {
      totalprogress = 0;

      if(isDefined(bomb.objectiveid)) {
        objective_setprogress(bomb.objectiveid, 0);
      }
    }

    if(!isDefined(self.activator)) {
      bomb.model stoploopsound(0.25);
    }

    prevtime = gettime();
    wait 0.05;
  }

  if(isDefined(bomb) && isDefined(bomb.model)) {
    bomb.model stoploopsound(0.25);
  }
}

function function_8e1791eb(bomb) {
  if(game.state != # "playing") {
    return false;
  }

  if(bomb.state != 4) {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  if(self inlaststand()) {
    return false;
  }

  if(!self useButtonPressed()) {
    return false;
  }

  if(!isDefined(bomb.trigger)) {
    return false;
  }

  if(!bomb.trigger istriggerenabled()) {
    return false;
  }

  if(self isinexecutionattack() || self isinexecutionvictim()) {
    return false;
  }

  if(!self istouching(bomb.trigger)) {
    return false;
  }

  if(self getcurrentweapon() === level.var_8ef8b9e8) {
    return false;
  }

  if(!isDefined(bomb.var_fe46e837)) {
    bomb.var_fe46e837 = [];
  }

  playerentnum = self getentitynumber();

  if(!isDefined(bomb.var_fe46e837[playerentnum]) || bomb.var_fe46e837[playerentnum] < gettime()) {
    bomb.var_fe46e837[playerentnum] = gettime() + 1;

    if(!function_ad9de896(self, bomb)) {
      return false;
    }
  }

  return true;
}

function function_75a48e71(bomb) {
  if(bomb.state != 4) {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  if(self inlaststand()) {
    return false;
  }

  if(!isDefined(bomb.trigger)) {
    return false;
  }

  if(!bomb.var_dac45cd5 istriggerenabled()) {
    return false;
  }

  if(!self istouching(bomb.var_dac45cd5)) {
    return false;
  }

  return true;
}

function function_dc70ca08() {
  self endon(#"hash_51134d620e14f47b");
  level endon(#"game_ended");

  if(level.var_451f847f == 0) {
    return;
  }

  wait level.var_451f847f;

  while(isDefined(self.trigger.activator)) {
    waitframe(1);
  }

  waitframe(1);
  self function_1283ff24(undefined);
}

function function_2eeb579c() {
  self endon(#"hash_51134d620e14f47b");
  level endon(#"game_ended");

  if(level.var_d86d5820 == 0) {
    return;
  }

  level.var_320e6819 = gettime();

  if(isDefined(self.model)) {
    self.model clientfield::set("bombsound", 1);
  }

  wait level.var_d86d5820;
  level.var_320e6819 = undefined;

  while(isDefined(self.trigger.activator)) {
    waitframe(1);
  }

  waitframe(1);
  self function_1283ff24(undefined);
}

function function_ad44b97e(player) {
  var_2dd00398 = [];
  player stats::function_dad108fa(#"hash_730e8686137b90ed", 1);
  var_2dd00398[player getentitynumber()] = 1;

  if(isDefined(self.trigger.assists) && isDefined(player.team)) {
    foreach(var_1bb634c7 in self.trigger.assists) {
      if(!isPlayer(var_1bb634c7)) {
        continue;
      }

      if(var_1bb634c7.team !== player.team) {
        continue;
      }

      if(var_2dd00398[var_1bb634c7 getentitynumber()] === 1) {
        continue;
      }

      player stats::function_dad108fa(#"hash_730e8686137b90ed", 1);
      var_2dd00398[var_1bb634c7 getentitynumber()] = 1;
    }
  }

  if(isDefined(player.team) && isDefined(self.origin)) {
    var_57fa318b = getplayers(player.team, self.origin, 600);

    foreach(var_bcf15b4 in var_57fa318b) {
      if(!isPlayer(var_bcf15b4)) {
        continue;
      }

      if(var_2dd00398[var_bcf15b4 getentitynumber()] === 1) {
        continue;
      }

      var_bcf15b4 stats::function_dad108fa(#"hash_730e8686137b90ed", 1);
      var_2dd00398[var_bcf15b4 getentitynumber()] = 1;
    }
  }
}

function function_5c0f763b(player) {
  if(!isDefined(player)) {
    return;
  }

  self notify(#"hash_51134d620e14f47b");
  level function_28039abb();
  scoreevents::processscoreevent(#"hash_179603173879ec50", player);
  player contracts::increment_contract(#"hash_3864353f04a134d8");
  player stats::function_cc215323(#"hash_75c5c00847117bfb", 1);

  if(isDefined(player.var_e2e8198f) && player.var_e2e8198f >= gettime() - int(3 * 1000)) {
    scoreevents::processscoreevent(#"hash_54db302236ce9572", player);
  }

  self function_ad44b97e(player);
  [[level.var_37d62931]](player, 1);
  player.pers[# "dirty_bomb_detonates"] = (isDefined(player.pers[# "dirty_bomb_detonates"]) ? player.pers[# "dirty_bomb_detonates"] : 0) + 1;
  player.dirty_bomb_detonates = player.pers[# "dirty_bomb_detonates"];
  player globallogic_score::incpersstat(#"objectivescore", 1, 0, 1);
  player stats::function_bb7eedf0(#"dirty_bomb_detonates", 1);
  player function_80d6d39b();

  if(!getdvarint(#"hash_6d01658e46435b76", 0)) {
    player enableweaponcycling();
    player enableoffhandweapons();
    player enableweaponswitchhero();
    player thread take_use_weapon(level.var_696298a2);

    if(player getcurrentweapon() === level.var_696298a2) {
      player killstreaks::switch_to_last_non_killstreak_weapon();
    }
  } else {
    player setlowready(0);
  }

  player.var_9dc65a85 = 0;
  player function_63909e4a();

  if(isDefined(self.objectiveid)) {
    objective_clearplayerusing(self.objectiveid, player);
  }

  for(i = 0; i < self.trigger.assists.size; i++) {
    self thread function_ea25bba7(self.trigger.assists[i]);
  }

  self function_1283ff24(player);
}

function function_1a29cdb0(winningteam) {
  if(!isDefined(level.var_edac6118)) {
    level.var_edac6118 = 0;
  }

  if(!level.var_edac6118) {
    foreach(losingteam, _ in level.teams) {
      if(losingteam != winningteam) {
        globallogic_audio::function_61e17de0("objLosing", getplayers(losingteam));
      }
    }

    level.var_edac6118 = 1;
  }
}

function function_e2d09d87(team) {
  if(!isDefined(level.dirtyBombScore50)) {
    level.dirtyBombScore50 = [];
  }

  if(!isDefined(level.dirtyBombScore75)) {
    level.dirtyBombScore75 = [];
  }

  if(!isDefined(team)) {
    return;
  }

  scorelimit = level.scorelimit < 0 ? 1 : level.scorelimit;
  scorepercentage = getteamscore(team) / scorelimit;

  if(scorepercentage >= 0.75) {
    if(!isDefined(level.dirtyBombScore75[team])) {
      globallogic_audio::function_61e17de0("dirtyBombScore75", getplayers(team));
    }

    level.dirtyBombScore75[team] = 1;
    function_1a29cdb0(team);
    return;
  }

  if(scorepercentage >= 0.5) {
    if(!isDefined(level.dirtyBombScore50[team])) {
      globallogic_audio::function_61e17de0("dirtyBombScore50", getplayers(team));
    }

    level.dirtyBombScore50[team] = 1;
  }
}

function function_28039abb(var_aaba141c) {
  var_aaba141c = function_7fc57bc9();

  if(var_aaba141c < 0.75) {
    return;
  }

  if(var_aaba141c >= 0.85) {
    if(var_aaba141c >= 0.925) {
      var_9c1ed9ea = "ftdb_endgame_high";
    } else {
      var_9c1ed9ea = "ftdb_endgame_med";
    }
  } else {
    var_9c1ed9ea = "ftdb_endgame_low";
  }

  if(level.var_7392007f !== var_9c1ed9ea) {
    level thread globallogic_audio::function_6fbfba95(var_9c1ed9ea);
    level.var_7392007f = var_9c1ed9ea;

    if(!is_true(level.var_acf54eb7)) {
      level.var_acf54eb7 = 1;
      clientfield::set("sndDeactivateSquadSpawnMusic", 1);
    }
  }
}

function function_7fc57bc9() {
  if(!isDefined(level.teams)) {
    return 0;
  }

  bestteamscore = 0;

  foreach(team in level.teams) {
    teamscore = getteamscore(team);

    if(teamscore > bestteamscore) {
      bestteamscore = teamscore;
    }
  }

  return bestteamscore / (level.scorelimit < 0 ? 1 : level.scorelimit);
}

function function_1283ff24(player) {
  if(game.state != # "playing") {
    return;
  }

  if(isDefined(self.objectiveid)) {
    objective_setgamemodeflags(self.objectiveid, 1);
    objective_setteam(self.objectiveid, isDefined(player.team) ? player.team : # "hash_34db99d80fb3607f");
    objective_setprogress(self.objectiveid, 0);
  }

  self.state = 5;
  self.trigger delete();
  self.var_dac45cd5 delete();

  if(isDefined(self.model)) {
    self.model namespace_b77e8eb1::function_1cb7e339();
    self.model clientfield::set("bombsound", 0);
  }

  self thread bombcountdown(player);
}

function bombcountdown(player) {
  level endon(#"game_ended");
  team = undefined;

  if(isDefined(player)) {
    team = player.team;
    function_93098bd9("dirtyBombArmedFriendly", player.team, self.origin, 4500);
    function_e43bca0f("dirtyBombArmedEnemy", player.team, self.origin, 4500);
  }

  if(level.var_46f2c796 != 0) {
    self.model playLoopSound(#"hash_78cdfb1438b360bf", 1);
    wait level.var_46f2c796;

    if(isDefined(self.model)) {
      self.model stoploopsound(0.5);
    }
  }

  self function_91c39737(player, team);
}

function function_91c39737(player, team) {
  origin = self.origin;
  damage = level.var_60e3f99c;
  playsoundatposition("exp_dirty_bomb_explo", origin + (0, 0, 60));

  if(isDefined(player)) {
    function_93098bd9("dirtyBombDetonatedFriendly", player.team, self.origin, 4500);
    function_e43bca0f("dirtyBombDetonatedEnemy", player.team, self.origin, 4500);
  } else {
    globallogic_audio::function_61e17de0("dirtyBombDetonatedEnemy", getplayers(undefined, self.origin, 4500));
  }

  if(level.var_77720414 && isDefined(team)) {
    globallogic_score::giveteamscoreforobjective(team, level.var_77720414);
    function_e2d09d87(team);
  }

  entities = getdamageableentarray(origin, level.var_60693fca, 1);

  foreach(entity in entities) {
    if(!isalive(entity)) {
      continue;
    }

    if(isPlayer(entity)) {
      entity.var_f5dc0dbf = 1;

      if(isDefined(player.team) && isDefined(entity.team) && entity.team == player.team) {
        entity dodamage(damage, origin, entity, self.model, undefined, "MOD_EXPLOSIVE");
        continue;
      }
    }

    entity.killcamkilledbyent = self.model.killcament;
    entity.killcament = self.model.killcament;
    entity dodamage(damage, origin, player, self.model, undefined, "MOD_EXPLOSIVE");
  }

  fwd = (0, 0, 1);
  right = (0, -1, 0);
  playFX("wz/fx9_dirtybomb_exp", origin, fwd, right);

  if(isentity(self.model)) {
    self.model.killcament delete();
    self.model delete();
  }

  if(isDefined(self.objectiveid)) {
    objectiveid = self.objectiveid;
    objective_setgamemodeflags(self.objectiveid, 4);
    level.var_910f361c[level.var_910f361c.size] = self.objectiveid;
    objective_setinvisibletoall(self.objectiveid);
    self.objectiveid = undefined;
  }

  var_f1db48c8 = level.var_2f418a15.size;

  for(i = 0; i < level.var_2f418a15.size; i++) {
    if(level.var_2f418a15[i] == self) {
      level.var_2f418a15[i] = level.var_2f418a15[level.var_2f418a15.size - 1];
      level.var_2f418a15[level.var_2f418a15.size - 1] = undefined;
      break;
    }
  }

  self.state = 0;

  if(level.var_2f418a15.size == 1 && level.var_2f418a15[0].state == 4) {
    level.var_2f418a15[0] thread function_2eeb579c();
  }

  if(level.var_2c9f7c6b) {
    self namespace_b77e8eb1::function_a5caaee0();
  }

  if(level.var_2064692e == 2) {
    level function_cca53f41(objectiveid, self.objindex);
  }
}

function private function_53d7badf(visible) {
  foreach(bomb in level.var_2f418a15) {
    if(!isDefined(bomb.state) || bomb.state != 2) {
      continue;
    }

    bomb.trigger setinvisibletoplayer(self, !visible);
  }
}

function private function_6e23e4cb(var_f87ac426 = undefined) {
  if(isDefined(var_f87ac426)) {
    self setinvisibletoall();

    foreach(player in getplayers()) {
      if(player != var_f87ac426 && player.team == var_f87ac426.team) {
        self setvisibletoplayer(player);
      }
    }

    return;
  }

  self setvisibletoall();
}

function private function_3bf6db8b(state, usetrigger) {
  if(!level.dirtybombusebar dirtybomb_usebar::is_open(self)) {
    level.dirtybombusebar dirtybomb_usebar::open(self, 4);
  }

  level.dirtybombusebar dirtybomb_usebar::set_state(self, state);
  level.dirtybombusebar dirtybomb_usebar::function_f0df5702(self, 0);

  if(isarray(usetrigger.assists)) {
    level.dirtybombusebar dirtybomb_usebar::function_4aa46834(self, usetrigger.assists.size + 1);
  }

  usetrigger setinvisibletoplayer(self, 1);
  self.var_814cca3f = usetrigger;
}

function private function_80d6d39b() {
  if(!isPlayer(self)) {
    return;
  }

  self clientfield::set_to_player("using_bomb", 0);

  if(level.dirtybombusebar dirtybomb_usebar::is_open(self)) {
    level.dirtybombusebar dirtybomb_usebar::close(self);
  }

  if(isDefined(self.var_814cca3f)) {
    self.var_814cca3f setinvisibletoplayer(self, 0);
    self.var_814cca3f = undefined;
  }
}

function private function_9db99d2f(frac) {
  if(level.dirtybombusebar dirtybomb_usebar::is_open(self)) {
    level.dirtybombusebar dirtybomb_usebar::function_f0df5702(self, frac);
  }
}

function private function_45c10c43(count) {
  if(level.dirtybombusebar dirtybomb_usebar::is_open(self)) {
    level.dirtybombusebar dirtybomb_usebar::function_4aa46834(self, count);
  }
}

function function_c0e544cc(params) {
  player = params.player;
  player endon(#"death", #"disconnect");

  while(true) {
    if(player isonground()) {
      break;
    }

    wait 1;
  }

  player luinotifyevent(#"hash_6b67aa04e378d681", 1, 13);
}

function function_b7821ed9(var_b77770ba) {
  if(isDefined(var_b77770ba) && var_b77770ba % 2 == 0) {
    return;
  }

  if(!isDefined(level.var_2f418a15) || level.var_2f418a15.size <= 0) {
    return;
  }

  bomborigin = level.var_2f418a15[randomintrange(0, level.var_2f418a15.size)].origin;

  if(!isDefined(bomborigin)) {
    return;
  }

  for(index = 0; index < 10; index++) {
    radius = randomfloatrange(0, 1);
    var_bd74a98c = sqrt(radius) * 3000;
    degree = randomintrange(0, 360);
    x = var_bd74a98c * cos(degree);
    y = var_bd74a98c * sin(degree);
    droppoint = (bomborigin[0] + x, bomborigin[1] + y, bomborigin[2]);

    if(!oob::chr_party(droppoint)) {
      result = function_9cc082d2(droppoint, 15000);

      if(isDefined(result) && isDefined(result[# "materialflags"]) && ~(result[# "materialflags"] & 2)) {
        return droppoint;
      }
    }
  }
}