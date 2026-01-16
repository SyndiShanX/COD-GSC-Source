/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_icepick_shared.gsc
*******************************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreaks_shared;

#namespace icepick;

init_shared() {
  ability_player::register_gadget_should_notify(8, 1);
  function_2aec10d2();
  registerclientfields();
  setupcallbacks();
}

private function_2aec10d2() {
  if(!isDefined(level.icepicksettings)) {
    level.icepicksettings = spawnStruct();
  }

  if(!isDefined(level.var_ff6f539f)) {
    level.var_ff6f539f = [];
  }

  if(!isDefined(level.var_fdb0a658)) {
    level.var_fdb0a658 = 0;
  }
}

private setupcallbacks() {
  level.var_1b900c1d = &function_1b900c1d;
  level.var_14151f16 = &function_14151f16;
  level.var_f1edf93f = &function_3e3330bc;
  callback::on_player_killed_with_params(&on_player_killed);
  callback::on_connect(&onplayerconnect);
  callback::on_spawned(&onplayerspawned);
  callback::on_joined_team(&onplayerjoinedteam);
  callback::on_disconnect(&onplayerdisconnect);
  callback::add_callback(#"on_status_effect", &on_status_effect);
  ability_player::register_gadget_activation_callbacks(8, &gadget_icepick_on, &gadget_icepick_off);
}

private registerclientfields() {
  clientfield::register("toplayer", "gadget_icepick_on", 9000, 1, "int");
  clientfield::register("toplayer", "currentlyHacking", 9000, 1, "int");
  clientfield::register("toplayer", "hackedvehpostfx", 9000, 1, "int");
  clientfield::register("toplayer", "currentlybeinghackedplayer", 9000, 4, "int");
  clientfield::register_clientuimodel("IcePickInfo.hackStarted", 9000, 1, "int", 0);
  clientfield::register_clientuimodel("IcePickInfo.hackFinished", 9000, 1, "int", 0);
  clientfield::register_clientuimodel("IcePickInfo.hackEquipFinished", 9000, 1, "int", 0);
  clientfield::register_clientuimodel("IcePickInfo.hackVehicleFinished", 9000, 1, "int", 0);
  clientfield::register_clientuimodel("hudItems.hacked", 9000, 1, "int", 0);
  clientfield::register_clientuimodel("hudItems.hackedRebootProgress", 9000, 5, "float", 0);
  clientfield::register_clientuimodel("IcePickInfo.currentHackProgress", 9000, 5, "float", 0);
  clientfield::register("missile", "cant_be_hacked", 9000, 1, "int");
  clientfield::register("vehicle", "cant_be_hacked", 9000, 1, "int");
  clientfield::register("scriptmover", "cant_be_hacked", 9000, 1, "int");
  clientfield::register("scriptmover", "hackStatus", 9000, 2, "int");
  clientfield::register("missile", "hackStatus", 9000, 2, "int");
  clientfield::register("vehicle", "hackStatus", 9000, 2, "int");
  clientfield::register("allplayers", "hackStatus", 9000, 2, "int");
}

function_3e3330bc() {
  settingsbundle = function_13f4415c();
  return isDefined(settingsbundle.var_1f06f5a) ? settingsbundle.var_1f06f5a : 0;
}

event_handler[event_36cd4a90] function_9497a4f3(eventstruct) {}

private function_c18360f6(var_11a83c3a, params) {
  if(!isDefined(params)) {
    return;
  }

  if(!isDefined(params.eattacker)) {
    return;
  }

  icepickweapon = getweapon(#"gadget_icepick");

  if(isDefined(var_11a83c3a.var_e2131267) && var_11a83c3a.var_e2131267 == params.eattacker) {
    scoreevents::processscoreevent(#"hacked_kill", var_11a83c3a.var_e2131267, undefined, icepickweapon);
    params.eattacker function_be7a08a8(icepickweapon, 1);
    time = gettime();

    if(!isDefined(params.eattacker.var_7b9616d6)) {
      params.eattacker.var_7b9616d6 = time;
    }

    if(!isDefined(params.eattacker.var_bcae5314)) {
      params.eattacker.var_bcae5314 = 0;
    }

    if(params.eattacker.var_7b9616d6 + 4000 < time) {
      params.eattacker.var_bcae5314 = 0;
    }

    params.eattacker.var_bcae5314++;
    params.eattacker.var_7b9616d6 = time;

    if(params.eattacker.var_bcae5314 == 2) {
      scoreevents::processscoreevent(#"hash_e18a9f29b8e1132", var_11a83c3a.var_e2131267, undefined, icepickweapon);
      params.eattacker.var_bcae5314 = 0;
    }

    return;
  }

  if(isDefined(var_11a83c3a.var_e2131267.team) && isDefined(params.eattacker.team) && var_11a83c3a.var_e2131267.team == params.eattacker.team) {
    scoreevents::processscoreevent(#"hacked_assist", var_11a83c3a.var_e2131267, undefined, icepickweapon);
  }
}

private function_a5b83ede(hacker, var_11a83c3a) {
  if(!isDefined(hacker) || !isDefined(var_11a83c3a)) {
    return;
  }

  settingsbundle = function_13f4415c();
  var_be75e624 = isDefined(settingsbundle.var_cd8eae22) ? settingsbundle.var_cd8eae22 : 0;
  var_696beab8 = isDefined(settingsbundle.var_51593b) ? settingsbundle.var_51593b : 0;

  if(!var_be75e624 && !var_696beab8) {
    return;
  }

  if(isDefined(settingsbundle.var_4ffa4f3c) ? settingsbundle.var_4ffa4f3c : 0) {
    if(isDefined(hacker.var_c269451a) ? hacker.var_c269451a : 0) {
      return;
    }

    hacker.var_c269451a = 1;
  }

  scoreevents::processscoreevent("hacker_shutdown", var_11a83c3a, hacker);

  if(!var_696beab8 || !level.teambased) {
    thread function_27c9bfc8(var_11a83c3a, 1);
    return;
  }

  if(var_696beab8) {
    foreach(player in getplayers(var_11a83c3a.team)) {
      thread function_27c9bfc8(player, 1);
    }
  }
}

private function_5e9bb390(hacker, var_11a83c3a) {
  function_a5b83ede(hacker, var_11a83c3a);

  if(isDefined(hacker.var_e989badb)) {
    hacker.var_e989badb notify(#"hash_2476803a0d5fa572");
  }

  hacker.var_e989badb = undefined;
}

on_player_killed(params) {
  if((isDefined(self.ishacked) ? self.ishacked : 0) && isDefined(self.var_e2131267)) {
    function_c18360f6(self, params);
  }

  if(isDefined(params) && isDefined(params.eattacker) && isDefined(params.eattacker.var_e2131267)) {
    if(params.eattacker.var_e2131267 == self) {
      function_5e9bb390(self, params.eattacker);
    }
  }

  if(isDefined(self.var_c1911c44) && self.var_c1911c44) {
    if(isDefined(self.var_982faa7c) && isplayer(self.var_982faa7c)) {
      self.var_982faa7c clientfield::set_to_player("hackedvehpostfx", 0);
    }

    if(isDefined(params.eattacker)) {
      scoreevents::processscoreevent("ice_pick_shutdown", params.eattacker, self);
    }
  }
}

onplayerspawned() {
  if(isDefined(self.ishacked) ? self.ishacked : 0) {
    thread function_39026c34(self.var_e2131267, self, 0);
  }
}

onplayerconnect() {
  self thread function_c1d2f9aa();
}

function_c1d2f9aa() {
  self endon(#"death", #"disconnect");
  self flagsys::wait_till(#"loadout_given");
  self ability_player::function_c9b950e3();
}

function_1b900c1d(weapon, var_5651313e) {
  if(!isDefined(level.var_ff6f539f)) {
    level.var_ff6f539f = [];
  }

  level.var_ff6f539f[weapon.name] = var_5651313e;
}

on_status_effect(var_756fda07) {
  if(!(isDefined(self.var_1f5ab061) && self.var_1f5ab061)) {
    return;
  }

  if(!isDefined(var_756fda07)) {
    return;
  }

  switch (var_756fda07.setype) {
    case 1:
    case 5:
      function_6c031486(self);
      break;
  }
}

onplayerjoinedteam(params) {
  if(isDefined(self.ishacked) && self.ishacked) {
    if(isDefined(self.var_e2131267) && self.var_e2131267.team == self.team) {
      function_27c9bfc8(self, 0);
    }
  }

  function_ea2dfad6(self);
}

onspecialistchange(params) {
  function_ea2dfad6(self);
}

onplayerdisconnect() {
  function_ea2dfad6(self);
}

private findweapon(entity) {
  if(isDefined(entity.identifier_weapon)) {
    return entity.identifier_weapon;
  } else if(isDefined(entity.weapon)) {
    return entity.weapon;
  } else if(isDefined(entity.var_22a05c26) && isDefined(entity.var_22a05c26.ksweapon)) {
    return entity.var_22a05c26.ksweapon;
  } else if(isDefined(entity.defaultweapon)) {
    return entity.defaultweapon;
  }

  return level.weaponnone;
}

function_14151f16(entity, canhack) {
  entity clientfield::set("cant_be_hacked", !canhack);
  entity.canthack = !canhack;
}

private function_808efdee(hacker, entity) {
  entityweapon = findweapon(entity);

  if((!isDefined(entityweapon) || entityweapon == level.weaponnone) && !isplayer(entity)) {
    return false;
  }

  if(entity.team == hacker.team) {
    return false;
  }

  if(entity.team == #"spectator") {
    return false;
  }

  if(isDefined(entity.canthack) && entity.canthack) {
    return false;
  }

  if(!isplayer(entity) && !entityweapon.ishackable) {
    return false;
  }

  if(isDefined(entity.ishacked) && entity.ishacked && !isplayer(entity)) {
    return false;
  }

  return true;
}

function_8d50c205(left, right) {
  leftweapon = findweapon(left);
  rightweapon = findweapon(right);

  if(isplayer(left) || isplayer(right) || leftweapon.var_8134b209 == rightweapon.var_8134b209) {
    return (left getentitynumber() < right getentitynumber());
  }

  return leftweapon.var_8134b209 < rightweapon.var_8134b209;
}

function_ab1f58d0(entity) {
  entityweapon = findweapon(entity);

  if(isplayer(entity)) {
    settingsbundle = function_13f4415c();
    return settingsbundle.var_4d1cd723;
  } else if(isDefined(entityweapon)) {
    return entityweapon.var_19f920eb;
  }

  return 0;
}

function_39d1ce95(entity, entityweapon) {
  if(!isDefined(entityweapon.name)) {
    return;
  }

  switch (entityweapon.name) {
    case #"supplydrop":
      if(isDefined(level.cratemodelfriendly)) {
        streamermodelhint(level.cratemodelfriendly, 10);
      }

      if(isDefined(level.cratemodelenemy)) {
        streamermodelhint(level.cratemodelenemy, 10);
      }

      break;
  }
}

function_6c031486(hacker) {
  if(!isDefined(hacker)) {
    return;
  }

  icepickweapon = getweapon(#"gadget_icepick");
  hacker notify(#"hash_7b4714f415b8f49e");
  var_3e361f1a = hacker gadgetgetslot(icepickweapon);
  hacker gadgetdeactivate(var_3e361f1a, icepickweapon);
  hacker switchtoweapon();
}

function_13f4415c() {
  icepickweapon = getweapon(#"gadget_icepick");
  return getscriptbundle(icepickweapon.customsettings);
}

private function_73d5db3b(player) {
  player.var_be9a0b4b = [];
  player.var_be9a0b4b[0] = getplayers();
  function_d65b8dbe(player.var_be9a0b4b[0], &function_8d50c205);
  player.var_be9a0b4b[1] = [];
  player.var_be9a0b4b[2] = [];

  foreach(entity in getentities()) {
    entityweapon = findweapon(entity);

    if(entityweapon.var_a8bd8bb2 > 0) {
      if(!isDefined(player.var_be9a0b4b[entityweapon.var_a8bd8bb2])) {
        player.var_be9a0b4b[entityweapon.var_a8bd8bb2] = [];
      } else if(!isarray(player.var_be9a0b4b[entityweapon.var_a8bd8bb2])) {
        player.var_be9a0b4b[entityweapon.var_a8bd8bb2] = array(player.var_be9a0b4b[entityweapon.var_a8bd8bb2]);
      }

      player.var_be9a0b4b[entityweapon.var_a8bd8bb2][player.var_be9a0b4b[entityweapon.var_a8bd8bb2].size] = entity;
      function_39d1ce95(entity, entityweapon);
    }
  }

  function_f1f877e0(player.var_be9a0b4b[1], &function_8d50c205);
  sort_vehicles(player.var_be9a0b4b[2], &function_8d50c205);
}

private function_d65b8dbe(&array, sort_func) {
  array::bubble_sort(array, sort_func);
}

private function_f1f877e0(&array, sort_func) {
  array::bubble_sort(array, sort_func);
}

private sort_vehicles(&array, sort_func) {
  array::bubble_sort(array, sort_func);
}

private starthack(player) {
  player endoncallback(&function_4802ca63, #"death", #"hash_7b4714f415b8f49e");
  level.var_fdb0a658 = 1;
  player clientfield::set_player_uimodel("IcePickInfo.hackStarted", 1);
  icepickweapon = getweapon(#"gadget_icepick");
  var_3e361f1a = player gadgetgetslot(icepickweapon);
  player gadgetpowerset(var_3e361f1a, 0);
  player.var_c269451a = 0;
  player.var_86f63ff1 = 0;
  player.var_639e4be8 = 0;
  thread function_b76c8353(player);
  player clientfield::set_to_player("currentlyHacking", 1);

  if(isDefined(level.heroplaydialog)) {
    player thread[[level.heroplaydialog]]("icePickWeaponUse", 2);

    if(isDefined(level.var_9082a3b6)) {
      player thread[[level.var_9082a3b6]]("icePickWeaponUseFutz");
    }
  }

  if(level.teambased) {
    if(isDefined(level.var_57e2bc08)) {
      thread[[level.var_57e2bc08]]("hackingStarted", util::getotherteam(self.team));
    }
  } else if(isDefined(level.playleaderdialogonplayer)) {
    foreach(enemyplayer in level.players) {
      if(enemyplayer == self) {
        continue;
      }

      enemyplayer thread[[level.playleaderdialogonplayer]]("hackingStarted");
    }
  }

  player.var_c1911c44 = 1;
  thread function_d1f6e8d0(player);
  settingsbundle = function_13f4415c();
  var_891378ce = isDefined(settingsbundle.var_a65e249e) ? settingsbundle.var_a65e249e : 0;
  function_aaf0a382(player.var_be9a0b4b[1], player, var_891378ce);
  player clientfield::set_player_uimodel("IcePickInfo.hackEquipFinished", 1);
  function_aaf0a382(player.var_be9a0b4b[2], player, var_891378ce);
  player clientfield::set_player_uimodel("IcePickInfo.hackVehicleFinished", 1);
  function_aaf0a382(player.var_be9a0b4b[0], player);
  player clientfield::set_player_uimodel("IcePickInfo.hackFinished", 1);
  player clientfield::set_to_player("currentlybeinghackedplayer", -2);
  wait 0.75;

  if(!isDefined(player)) {
    return;
  }

  icepickweapon = getweapon(#"gadget_icepick");
  var_3e361f1a = player gadgetgetslot(icepickweapon);
  player gadgetdeactivate(var_3e361f1a, icepickweapon);
  player switchtoweapon();
  player.var_c1911c44 = 0;
  level.var_fdb0a658 = 0;

  if(isDefined(player.var_86f63ff1) && isDefined(level.playgadgetsuccess) && isDefined(level.var_ac6052e9)) {
    var_9194a036 = [[level.var_ac6052e9]]("icePickHackSuccessLineCount", 1);

    if(player.var_86f63ff1 >= (isDefined(var_9194a036) ? var_9194a036 : 1)) {
      player[[level.playgadgetsuccess]](icepickweapon);
    }
  }

  player.var_86f63ff1 = undefined;
  player.var_639e4be8 = undefined;
}

private function_aaf0a382(entities, player, max) {
  player endon(#"death", #"hash_7b4714f415b8f49e");
  var_e8e3cc00 = 0;

  foreach(entity in entities) {
    if(!isDefined(entity)) {
      continue;
    }

    if(!function_808efdee(player, entity)) {
      continue;
    }

    if(!isplayer(entity)) {
      entityweapon = findweapon(entity);
      var_e8e3cc00 += entityweapon.var_df381b5d;
    }

    if(isDefined(max) && var_e8e3cc00 > max) {
      break;
    }

    function_2b2ed159(entity, player);
  }
}

private function_2b2ed159(entity, attackingplayer) {
  attackingplayer endon(#"death", #"hash_7b4714f415b8f49e");
  var_87bdc7d3 = int(function_ab1f58d0(entity) * 1000);
  var_7570395 = 0;
  attackingplayer.var_e989badb = entity;

  if(isplayer(entity)) {
    entity clientfield::set("hackStatus", 1);
    attackingplayer clientfield::set_to_player("currentlybeinghackedplayer", entity getentitynumber());
  } else {
    entity clientfield::set("hackStatus", 1);
    entityweapon = findweapon(entity);

    if(!isDefined(entityweapon)) {
      return;
    }

    originalowner = entity.owner;

    if(isDefined(originalowner) && entityweapon.var_775d2aad === 1) {
      thread function_4a82368f(entity, originalowner);
      attackingplayer.var_982faa7c = originalowner;
      var_7570395 = 1;
    }
  }

  if(randomint(100) <= 50) {
    if(isDefined(level.var_e2fff792)) {
      attackingplayer[[level.var_e2fff792]]("icePickWeaponHackStart", attackingplayer);
    }
  }

  var_3d69d460 = 0;
  lasttime = gettime();
  var_9b4cc45c = gettime();

  while(var_3d69d460 < var_87bdc7d3 && var_87bdc7d3 > 0) {
    if(!isDefined(entity) || isDefined(entity.leaving) && entity.leaving) {
      if(isDefined(entity)) {
        function_14151f16(entity, 0);
      }

      break;
    }

    var_50c86c4 = var_3d69d460 / var_87bdc7d3;
    attackingplayer clientfield::set_player_uimodel("IcePickInfo.currentHackProgress", var_50c86c4);
    timediff = gettime() - lasttime;
    var_3d69d460 += timediff * (isDefined(attackingplayer.var_6704e6fa) ? attackingplayer.var_6704e6fa : 1);
    lasttime = gettime();
    waitframe(1);
  }

  hackendtime = gettime();

  if(!isDefined(entity) || !isDefined(attackingplayer) || isDefined(entity.canthack) && entity.canthack) {
    if(var_7570395) {
      if(isDefined(originalowner) && isplayer(originalowner)) {
        originalowner clientfield::set_to_player("hackedvehpostfx", 0);
      }

      attackingplayer.var_982faa7c = undefined;
    }

    return;
  }

  attackingplayer clientfield::set_player_uimodel("IcePickInfo.currentHackProgress", 1);
  entity clientfield::set("hackStatus", 2);
  attackingplayer playsoundtoplayer(#"hash_fc83e70c477029c", attackingplayer);
  entity notify(#"hash_2476803a0d5fa572");
  attackingplayer.var_982faa7c = undefined;

  if(!isDefined(attackingplayer.var_86f63ff1)) {
    attackingplayer.var_86f63ff1 = 0;
  }

  attackingplayer.var_86f63ff1++;

  if(isplayer(entity)) {
    targetname = #"player";
    playernum = entity.entnum;
    thread function_39026c34(attackingplayer, entity, 1);
  } else {
    entityweapon = findweapon(entity);

    if(isDefined(entityweapon) && isDefined(entityweapon.name) && isDefined(entity.owner) && entity.owner getentitynumber()) {
      targetname = entityweapon.name;
      playernum = entity.owner getentitynumber();
    }

    thread function_29f4ff02(attackingplayer, entity);
  }

  attackingplayer.var_e989badb = undefined;
  var_46df240b = hackendtime - var_9b4cc45c;

  if(isDefined(targetname) && isDefined(playernum)) {
    var_6c52b424 = {
      #life_id: attackingplayer getmatchrecordlifeindex(), 
      #var_a9451146: attackingplayer.var_c48b30ab, 
      #content_targeted: targetname, 
      #var_e7f6239c: playernum, 
      #duration: var_46df240b, 
      #hack_success: 1
    };
    function_92d1707f(#"hash_3c946cbb149411ad", var_6c52b424);
  }
}

function_4802ca63(str_notify) {
  if(str_notify != #"hash_7b4714f415b8f49e" || !isDefined(self) || !isplayer(self)) {
    return;
  }

  self clientfield::set_player_uimodel("IcePickInfo.hackFinished", 1);
  icepickweapon = getweapon(#"gadget_icepick");
  var_3e361f1a = self gadgetgetslot(icepickweapon);
  self gadgetdeactivate(var_3e361f1a, icepickweapon);
  self.var_c1911c44 = 0;
  level.var_fdb0a658 = 0;

  if(isDefined(self.var_982faa7c) && isplayer(self.var_982faa7c)) {
    self.var_982faa7c clientfield::set_to_player("hackedvehpostfx", 0);
    self.var_982faa7c = undefined;
  }
}

function_4a82368f(entity, owner) {
  assert(isDefined(owner));

  if(isplayer(owner)) {
    owner clientfield::set_to_player("hackedvehpostfx", 1);
  }

  entity waittill(#"death", #"remote_weapon_end", #"hash_2476803a0d5fa572");

  if(!isDefined(owner)) {
    return;
  }

  if(isplayer(owner)) {
    owner clientfield::set_to_player("hackedvehpostfx", 0);
  }
}

function_29f4ff02(attackingplayer, entity) {
  if(isplayer(entity)) {
    return;
  }

  entityweapon = findweapon(entity);

  if(!isDefined(entityweapon)) {
    return;
  }

  killstreak = killstreaks::get_from_weapon(entityweapon);

  if(isDefined(killstreak)) {
    attackingplayer.var_639e4be8++;

    if(isDefined(attackingplayer.var_639e4be8) && attackingplayer.var_639e4be8 == 3) {
      scoreevents::processscoreevent(#"hash_232128502a39219d", attackingplayer, undefined, getweapon(#"gadget_icepick"));
    }
  }

  originalowner = entity.owner;

  if(isDefined(level.var_ff6f539f[entityweapon.name])) {
    thread[[level.var_ff6f539f[entityweapon.name]]](entity, attackingplayer);
    function_d545fd0a(attackingplayer, entityweapon);
  }

  if(entityweapon.var_b8a85edd) {
    icepickweapon = getweapon(#"gadget_icepick");

    if(isentity(entity)) {
      entity kill(entity.origin, attackingplayer, self, icepickweapon);
    }

    function_d545fd0a(attackingplayer, entityweapon);
  } else {
    if(isDefined(entity.var_6f6b8de5)) {
      var_9daa805 = 1;
    }

    entity.var_6f6b8de5 = 1;
  }

  function_42bb8ac1(entityweapon, originalowner, attackingplayer, var_9daa805);
}

function_ea2dfad6(hacker) {
  if(!isDefined(hacker)) {
    return;
  }

  foreach(player in getplayers()) {
    if(!isDefined(player)) {
      continue;
    }

    if(!isDefined(player.var_e2131267) || !(isDefined(player.ishacked) && player.ishacked)) {
      continue;
    }

    if(player.var_e2131267 == hacker) {
      thread function_27c9bfc8(player, 0);
    }
  }
}

function_27c9bfc8(var_11a83c3a, announce) {
  assert(isDefined(var_11a83c3a));
  assert(isDefined(announce));
  var_11a83c3a notify(#"hack_end");
  var_11a83c3a.ishacked = 0;
  var_11a83c3a.var_be173895 = 0;
  var_11a83c3a.var_e2131267 = undefined;
  var_11a83c3a clientfield::set_player_uimodel("hudItems.hacked", 0);
  var_11a83c3a clientfield::set("hackStatus", 0);
  var_11a83c3a clientfield::set_player_uimodel("hudItems.hackedRebootProgress", 1);
  var_11a83c3a ability_player::function_c9b950e3();
  var_559f4f0a = getstatuseffect("hacked");
  var_11a83c3a status_effect::function_408158ef(var_559f4f0a.setype, var_559f4f0a.var_18d16a6b);

  if(announce) {
    var_11a83c3a thread killstreaks::play_taacom_dialog("specialistHackEnd");
  }
}

private function_aadad2c(attackingplayer, var_11a83c3a) {
  assert(isDefined(attackingplayer));
  assert(isDefined(var_11a83c3a));
  icepickweapon = getweapon(#"gadget_icepick");
  scoreevents::processscoreevent(#"hacked_enemy", attackingplayer, var_11a83c3a, icepickweapon);
  var_11a83c3a clientfield::set_player_uimodel("hudItems.hackedRebootProgress", 0);
  var_11a83c3a thread killstreaks::play_taacom_dialog("specialistHackBegin", undefined, undefined, undefined, undefined, undefined, 1);
  var_11a83c3a.var_9b4cc45c = gettime();
  var_11a83c3a.ishacked = 1;
  var_11a83c3a.var_e2131267 = attackingplayer;
  var_11a83c3a.var_20183706 = var_11a83c3a hastalent(#"talent_resistance");
  var_559f4f0a = getstatuseffect("hacked");
  duration = var_559f4f0a.seduration;

  if(var_11a83c3a.var_20183706) {
    settingsbundle = function_13f4415c();
    duration *= isDefined(settingsbundle.var_4624074e) ? settingsbundle.var_4624074e : 1;
  }

  var_11a83c3a.hackendtime = gettime() + duration;

  if(isDefined(var_11a83c3a.var_1f5ab061) ? var_11a83c3a.var_1f5ab061 : 0) {
    function_6c031486(var_11a83c3a);
  }
}

private function_a9987363(var_559f4f0a, attackingplayer, var_11a83c3a) {
  assert(isDefined(var_559f4f0a));
  assert(isDefined(attackingplayer));
  assert(isDefined(var_11a83c3a));

  if(!isDefined(var_11a83c3a.hackendtime)) {
    return;
  }

  var_575cc792 = var_11a83c3a.hackendtime - gettime();
  icepickweapon = getweapon(#"gadget_icepick");
  var_11a83c3a status_effect::status_effect_apply(var_559f4f0a, icepickweapon, attackingplayer, 0, var_575cc792);
  var_11a83c3a clientfield::set("hackStatus", 2);
  var_11a83c3a clientfield::set_player_uimodel("hudItems.hacked", 1);
  var_11a83c3a ability_player::function_116ec442();
}

private function_bf744a1e(attackingplayer, var_11a83c3a) {
  var_11a83c3a.var_e2131267 = attackingplayer;
  icepickweapon = getweapon(#"gadget_icepick");
  scoreevents::processscoreevent(#"hacked_enemy", attackingplayer, var_11a83c3a, icepickweapon);
  settingsbundle = function_13f4415c();
  var_e7af1dd4 = var_11a83c3a hastalent(#"talent_resistance") ? isDefined(settingsbundle.var_4624074e) ? settingsbundle.var_4624074e : 1 : 1;
  statuseffect = getstatuseffect("hacked");
  additionaltime = statuseffect.seduration * var_e7af1dd4 * (isDefined(settingsbundle.var_9b5b082d) ? settingsbundle.var_9b5b082d : 1);
  var_11a83c3a.hackendtime += additionaltime;
  var_11a83c3a status_effect::status_effect_apply(statuseffect, icepickweapon, attackingplayer, 0, additionaltime);
}

private function_f255c737(var_11a83c3a) {
  assert(isDefined(var_11a83c3a));
  var_11a83c3a endon(#"death", #"hack_end");
  settingsbundle = function_13f4415c();

  while(gettime() <= var_11a83c3a.hackendtime && level.gameended !== 1) {
    duration = var_11a83c3a.hackendtime - var_11a83c3a.var_9b4cc45c;
    totaltime = gettime() - var_11a83c3a.var_9b4cc45c;
    var_15ab01c8 = totaltime / duration;

    if(totaltime > (isDefined(settingsbundle.var_2f2b5447) ? settingsbundle.var_2f2b5447 : 0)) {
      var_11a83c3a clientfield::set_player_uimodel("hudItems.hackedRebootProgress", var_15ab01c8);
    }

    waitframe(1);
  }

  if(!isDefined(var_11a83c3a)) {
    return;
  }

  thread function_27c9bfc8(var_11a83c3a, 1);
}

function_39026c34(attackingplayer, var_11a83c3a, var_4f6e2cbe) {
  assert(isDefined(attackingplayer));
  assert(isDefined(var_11a83c3a));
  var_11a83c3a endon(#"death");

  if(var_4f6e2cbe) {
    if(isDefined(var_11a83c3a.ishacked) ? var_11a83c3a.ishacked : 0) {
      function_bf744a1e(attackingplayer, var_11a83c3a);
    } else {
      function_aadad2c(attackingplayer, var_11a83c3a);
    }
  }

  if(gettime() >= var_11a83c3a.hackendtime) {
    function_27c9bfc8(var_11a83c3a, 0);
    return;
  }

  function_a9987363(getstatuseffect("hacked"), attackingplayer, var_11a83c3a);
  thread function_f255c737(var_11a83c3a);
}

private function_9a1266be() {
  self endon(#"death", #"hash_2945c35e0b146804", #"hash_5e72464fef90323e");
  wait 1;
  self function_de8a54a6(0.01);
}

private gadget_icepick_on(slot, weapon) {
  self clientfield::set_to_player("gadget_icepick_on", 1);
  self clientfield::set_player_uimodel("IcePickInfo.hackStarted", 0);
  self clientfield::set_player_uimodel("IcePickInfo.hackFinished", 0);
  self clientfield::set_player_uimodel("IcePickInfo.hackEquipFinished", 0);
  self clientfield::set_player_uimodel("IcePickInfo.hackVehicleFinished", 0);
  self clientfield::set_to_player("currentlybeinghackedplayer", -1);
  function_73d5db3b(self);
  self thread function_9a1266be();
  self function_124efc19(1);
  self.var_c1911c44 = 0;
  self.var_1f5ab061 = 1;
  self.var_6704e6fa = 1;
  self.var_c48b30ab = self function_57dfc908();

  if(isbot(self)) {
    self.var_46fccfba = 1;
    self thread function_f1148c2c(self);
    return;
  }

  thread function_6b9d6894(self);
}

private function_30fe16c7() {
  self notify("<dev string:x38>");
  self endon("<dev string:x38>");

  while(isDefined(self)) {
    function_73d5db3b(self);
    waitframe(1);
  }
}

private gadget_icepick_off(slot, weapon) {
  self clientfield::set_to_player("gadget_icepick_on", 0);
  self notify(#"hash_2945c35e0b146804");
  self notify(#"hash_7b4714f415b8f49e");
  self function_124efc19(0);
  self function_de8a54a6(1);
  self.var_6704e6fa = 1;
  self.var_1f5ab061 = 0;
  self.var_c1911c44 = 0;
  self allowjump(1);
  var_559f4f0a = getstatuseffect("hacking");
  self status_effect::function_408158ef(var_559f4f0a.setype, var_559f4f0a.var_18d16a6b);
  self clientfield::set_to_player("currentlyHacking", 0);
  function_28f0bd8e(self);
}

private function_d1f6e8d0(player) {
  player endon(#"hash_2945c35e0b146804", #"death");

  if(!isDefined(player.var_46fccfba)) {
    player.var_46fccfba = 0;
  }

  var_3e6425fc = 0;
  player function_124efc19(1);
  player function_de8a54a6(1);
  var_559f4f0a = getstatuseffect("hacking");
  icepickweapon = getweapon(#"gadget_icepick");
  settingsbundle = function_13f4415c();

  while(true) {
    if(player.var_46fccfba && !var_3e6425fc) {
      player function_124efc19(0);
      player function_de8a54a6(isDefined(settingsbundle.var_3ca119bd) ? settingsbundle.var_3ca119bd : 1);
      player allowjump(0);
      player.var_6704e6fa = isDefined(settingsbundle.var_c424ffde) ? settingsbundle.var_c424ffde : 1;

      if(isDefined(var_559f4f0a)) {
        player status_effect::status_effect_apply(var_559f4f0a, icepickweapon, player, 0);
      }

      var_3e6425fc = 1;
    } else if(!player.var_46fccfba && var_3e6425fc) {
      player function_124efc19(1);
      player function_de8a54a6(1);
      player.var_6704e6fa = 1;
      var_3e6425fc = 0;
      player allowjump(1);
      player status_effect::function_408158ef(var_559f4f0a.setype, var_559f4f0a.var_18d16a6b);
    }

    waitframe(1);
  }
}

function_f1148c2c(player) {
  player endon(#"death", #"hash_7b4714f415b8f49e");
  player notify(#"hash_5e72464fef90323e");

  if(player isswitchingweapons()) {
    player waittilltimeout(1, #"weapon_change_complete");
  }

  if(isDefined(player) && isplayer(player)) {
    starthack(player);
  }
}

private function_6b9d6894(player) {
  player endon(#"hash_2945c35e0b146804", #"death", #"disconnect");

  if(!isDefined(player.var_3ca20bb9)) {
    player.var_3ca20bb9 = 0;
  }

  while(true) {
    waitresult = player waittill(#"menuresponse");

    switch (waitresult.response) {
      case #"id":
        if(!(isDefined(player.var_c1911c44) ? player.var_c1911c44 : 0) && waitresult.intpayload === 1) {
          if(isDefined(level.var_fdb0a658) && level.var_fdb0a658) {
            player iprintlnbold(#"weapon/icepick_unavailable");
            player switchtoweapon();
            return;
          }

          player thread function_f1148c2c(player);
        }

        switch (waitresult.intpayload) {
          case 1:
            player.var_46fccfba = 1;
            break;
          case 0:
            player.var_46fccfba = 0;
            break;
        }

        break;
      case #"back":
        if(waitresult.intpayload == 1) {
          player switchtoweapon();
        }

        break;
    }
  }
}

private function_28f0bd8e(hacker) {
  hacker notify(#"hash_ea5ac4d11419268");
  hacker endon(#"hash_ea5ac4d11419268");
  objectiveid = hacker.var_1d6ad02e;
  settingsbundle = function_13f4415c();
  hacker waittilltimeout(isDefined(settingsbundle.var_9baf2d44) ? settingsbundle.var_9baf2d44 : 0, #"death", #"disconnect");

  if(isDefined(objectiveid)) {
    gameobjects::release_obj_id(objectiveid);
    objective_delete(objectiveid);

    if(isDefined(hacker)) {
      hacker.var_1d6ad02e = undefined;
    }
  }
}

private function_b76c8353(hacker) {
  hacker endon(#"death", #"hash_2945c35e0b146804");
  settingsbundle = function_13f4415c();
  var_a1a18ce2 = isDefined(settingsbundle.var_679962fc) ? settingsbundle.var_679962fc : 1000;
  var_49c01cfb = gettime() + var_a1a18ce2;
  starttime = gettime();

  while(gettime() < var_49c01cfb) {
    timeelapsed = gettime() - starttime;
    var_2d62ff4b = timeelapsed / var_a1a18ce2;
    wait 0.1;
  }

  if(!isDefined(hacker.var_1d6ad02e)) {
    hacker.var_1d6ad02e = gameobjects::get_next_obj_id();
  }

  objective_add(hacker.var_1d6ad02e, "active", hacker, #"exposed_hacker");
  objective_setteam(hacker.var_1d6ad02e, hacker.team);
  function_da7940a3(hacker.var_1d6ad02e, 1);
  function_3ae6fa3(hacker.var_1d6ad02e, hacker.team, 0);
}

function_42bb8ac1(weapon, originalowner, newowner, var_53c10ed8) {
  if(!isDefined(weapon) || !isDefined(originalowner)) {
    return;
  }

  switch (weapon.name) {
    case #"gadget_spawnbeacon":
      leaderdialog = "enemySpawnBeaconHack";
      break;
    case #"cobra_20mm_comlink":
    case #"helicopter_comlink":
    case #"inventory_helicopter_comlink":
      leaderdialog = "enemyAttackChopperHack";
      break;
    case #"counteruav":
      leaderdialog = "enemyCUAVHack";
      break;
    case #"drone_squadron":
    case #"inventory_drone_squadron":
      leaderdialog = "enemyDroneSquadronHack";
      break;
    case #"supplydrop":
      leaderdialog = "enemyCarePackageHack";
      break;
    case #"uav":
      leaderdialog = "enemyUAVHack";
      break;
    case #"ultimate_turret":
    case #"inventory_ultimate_turret":
      leaderdialog = "enemySentryHack";
      break;
  }

  if(isDefined(leaderdialog) && isDefined(level.var_57e2bc08)) {
    if(level.teambased) {
      thread[[level.var_57e2bc08]](leaderdialog, originalowner.team, originalowner);
    }
  }

  if(isDefined(level.var_b42019ef)) {
    originalowner thread[[level.var_b42019ef]](weapon, newowner, var_53c10ed8);
  }
}

function_d545fd0a(player, weapon) {
  switch (weapon.name) {
    case #"supplydrop":
      var_d975dd49 = "hacked_care_package";
      break;
    case #"counteruav":
      var_d975dd49 = "hacked_cuav";
      break;
    case #"uav":
      var_d975dd49 = "hacked_uav";
      break;
    case #"gadget_spawnbeacon":
      var_d975dd49 = "hacked_spawn_beacon";
      break;
    case #"planemortar":
    case #"inventory_planemortar":
      var_d975dd49 = "hacked_planemortar";
      break;
    case #"inventory_remote_missile":
    case #"remote_missile":
      var_d975dd49 = "hacked_hellstorm";
      break;
    case #"inventory_straferun":
    case #"straferun":
      var_d975dd49 = "hacked_warthog";
      break;
    case #"dart":
    case #"inventory_dart":
      var_d975dd49 = "hacked_dart";
      break;
    case #"inventory_drone_squadron":
    case #"drone_squadron":
      var_d975dd49 = "hacked_drone_squad";
      break;
    case #"inventory_helicopter_comlink":
    case #"cobra_20mm_comlink":
    case #"helicopter_comlink":
      var_d975dd49 = "hacked_attack_chopper";
      break;
    case #"overwatch_helicopter":
    case #"inventory_overwatch_helicopter":
      var_d975dd49 = "hacked_sniper_chopper";
      break;
    case #"ac130":
    case #"inventory_ac130":
      var_d975dd49 = "hacked_ac130";
      break;
    case #"tank_robot":
    case #"inventory_tank_robot":
    case #"ai_tank_marker":
      var_d975dd49 = "hacked_mantis";
      break;
    case #"ultimate_turret":
    case #"inventory_ultimate_turret":
      var_d975dd49 = "hacked_ult_turret";
      break;
    case #"recon_car":
    case #"inventory_recon_car":
      var_d975dd49 = "hacked_rcxd";
      break;
    case #"gadget_supplypod":
      var_d975dd49 = "hacked_supplypod";
      break;
    case #"gadget_smart_cover":
    case #"ability_smart_cover":
      var_d975dd49 = "hacked_barricade";
      break;
    case #"eq_sensor":
      var_d975dd49 = "hacked_sensor_dart";
      break;
    case #"eq_seeker_mine":
      var_d975dd49 = "hacked_seeker";
      break;
    case #"trophy_system":
      var_d975dd49 = "hacked_trophy";
      break;
  }

  if(isDefined(var_d975dd49)) {
    icepickweapon = getweapon(#"gadget_icepick");
    scoreevents::processscoreevent(var_d975dd49, player, undefined, icepickweapon);
  }
}