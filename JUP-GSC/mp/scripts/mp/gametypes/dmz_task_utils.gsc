/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_task_utils.gsc
***************************************************/

#using script_64acb6ce534155b7;
#using script_b7a9ce0a2282b79;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace dmz_task_utils;

function task_create(activity) {
  task = spawnStruct();
  task.teams = [];
  task.mission = activity;
  task.activity = activity;
  task.funcs = [];
  task.index = 0;
  return task;
}

function function_325390edb051cd5d(circleid, locations, size) {
  if(!isDefined(self.questcircles)) {
    self.questcircles = [];
  }

  foreach(location in locations) {
    index = self.questcircles.size;
    self.questcircles[index] = spawnStruct();
    self.questcircles[index] function_6b6b6273f8180522(circleid, location, size);
  }
}

function function_8cd2ac82037f025c(circleid, location, size) {
  if(!isDefined(self.questcircles)) {
    self.questcircles = [];
  }

  index = self.questcircles.size;
  self.questcircles[index] = spawnStruct();
  self.questcircles[index] function_6b6b6273f8180522(circleid, location, size);
}

function function_1851e9cfb7687f68(player) {
  if(isDefined(self.questcircles)) {
    foreach(circle in self.questcircles) {
      if(isDefined(circle)) {
        circle function_cfd53c8f6878014f(player);
      }
    }
  }
}

function function_556fb3a465f0e978(player) {
  if(isDefined(self.questcircles)) {
    foreach(circle in self.questcircles) {
      if(isDefined(circle)) {
        circle function_d7d113d56ef0ef5b(player);
      }
    }
  }
}

function function_e54df8560bf7dc64(team) {
  if(isDefined(self.questcircles)) {
    foreach(circle in self.questcircles) {
      if(isDefined(circle)) {
        circle function_739560269bc164cf(team);
      }
    }
  }
}

function function_89951899f85b3465(team, circleindex) {
  if(!isDefined(self.questcircles)) {
    return;
  }

  if(!isDefined(self.questcircles[circleindex])) {
    return;
  }

  self.questcircles[circleindex] function_739560269bc164cf(team);
}

function function_2476daefa3384c5e() {
  if(isDefined(self.questcircles)) {
    foreach(circle in self.questcircles) {
      if(isDefined(circle)) {
        circle function_af5604ce591768e1();
      }
    }
  }
}

function function_4e927bfe9b585059(index) {
  if(isDefined(self.questcircles)) {
    self.questcircles[index] function_af5604ce591768e1();
    self.questcircles[index] = undefined;
  }
}

function function_ab50f62a3a730400(origin, radius) {
  return origin + function_d553466cf817a4da() * radius;
}

function function_e68b37e06549547e(neworigin, newradius, circleindex) {
  if(!isDefined(circleindex)) {
    circleindex = 0;
  }

  if(!isDefined(neworigin)) {
    neworigin = self.questcircles[circleindex].mapcircle.origin;
  }

  if(!isDefined(newradius)) {
    newradius = self.questcircles[circleindex].mapcircle.origin[2];
  }

  self.questcircles[circleindex].mapcircle.origin = (neworigin[0], neworigin[1], newradius);
}

function function_a764b87cdf6d8ac4(points, height) {
  minx = points[0][0];
  maxx = points[0][0];
  miny = points[0][1];
  maxy = points[0][1];

  foreach(point in points) {
    if(minx > point[0]) {
      minx = point[0];
    }

    if(maxx < point[0]) {
      maxx = point[0];
    }

    if(miny > point[1]) {
      miny = point[1];
    }

    if(maxy < point[1]) {
      maxy = point[1];
    }
  }

  center = ((maxx + minx) / 2, (maxy + miny) / 2, height);
  radiussq = 0;

  foreach(point in points) {
    distsq = distance2dsquared(center, point);

    if(radiussq <= distsq) {
      radiussq = distsq;
    }
  }

  return [center, sqrt(radiussq)];
}

function function_9e357e07833a0d1a(team) {
  level endon("game_ended");
  self endon("task_ended");
  wait 3;

  while(true) {
    if(!isDefined(self.questcircles) || self.questcircles.size == 0 || !isDefined(self.icon)) {
      return;
    }

    players = getteamdata(team, "players");

    foreach(player in players) {
      showicon = 1;

      foreach(circle in self.questcircles) {
        if(!isDefined(circle.mapcircle)) {
          continue;
        }

        dist = distance2dsquared(player.origin, circle.mapcircle.origin);

        if(dist <= circle.mapcircle.origin[2] * circle.mapcircle.origin[2]) {
          showicon = 0;
          break;
        }
      }

      if(showicon) {
        function_fbf23ae15945ee5a(player);
        continue;
      }

      function_401535e3fa9e171c(player);
    }

    wait 1;
  }
}

function function_995813ad75b83c53(team, circleindex) {
  level endon("game_ended");
  self endon("task_ended");
  wait 3;

  while(true) {
    if(!isDefined(self.questcircles) || self.questcircles.size == 0 || !isDefined(self.icon)) {
      return;
    }

    players = getteamdata(team, "players");

    foreach(player in players) {
      showicon = 1;
      circle = self.questcircles[circleindex];

      if(isDefined(circle.mapcircle)) {
        dist = distance2dsquared(player.origin, circle.mapcircle.origin);

        if(dist <= circle.mapcircle.origin[2] * circle.mapcircle.origin[2]) {
          showicon = 0;
          break;
        }
      }

      if(showicon) {
        function_fbf23ae15945ee5a(player);
        continue;
      }

      function_401535e3fa9e171c(player);
    }

    wait 1;
  }
}

function function_a9f8002e49a69313(dialog, teamname) {
  soundname = game["dialog"][dialog];
  assertex(isDefined(soundname), "<dev string:x1c>" + dialog);

  foreach(teammember in getteamdata(teamname, "players")) {
    teammember queuedialogforplayer(soundname, dialog, 2);
  }
}

function function_4ed64ae8fc231a27(icon, teamname, location, zoffset, waittime, objectivestate) {
  level endon("game_ended");
  self endon("RemoveIcon");

  if(isDefined(waittime)) {
    wait waittime;
  } else {
    waitframe();
  }

  function_e88784387008bd2(icon, teamname, location, zoffset, objectivestate);
}

function function_5a2f918c5578514(icon, teamname, entity, zoffset, objectivestate) {
  function_e88784387008bd2(icon, teamname, entity.origin, zoffset, objectivestate);
  update_objective_onentity(self.objidnum, entity);

  if(isDefined(zoffset)) {
    update_objective_setzoffset(self.objidnum, zoffset);
  }
}

function function_e88784387008bd2(icon, teamname, location, zoffset, objectivestate) {
  if(!isDefined(zoffset)) {
    zoffset = 0;
  }

  self.curorigin = location;
  self.offset3d = (0, 0, zoffset);
  scripts\mp\gameobjects::requestid(1, 1, undefined, 1);
  update_objective_icon(self.objidnum, icon);

  if(isDefined(teamname)) {
    objective_teammask_single(self.objidnum, teamname);
  } else {
    objective_removeallfrommask(self.objidnum);
  }

  update_objective_state(self.objidnum, ter_op(isDefined(objectivestate), objectivestate, "invisible"));
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.objidnum, 4);
}

function function_188bf2b5951a0060(newentity) {
  self.trackingentity = newentity;
  scripts\mp\objidpoolmanager::update_objective_onentity(self.objidnum, newentity);
}

function function_30c89ac91cfae119(teamname) {
  if(isDefined(teamname) && isDefined(self.objidnum)) {
    objective_teammask_single(self.objidnum, teamname);
  }
}

function function_e8d8df3da4392f0f(teamname) {
  if(isDefined(teamname) && isDefined(self.objidnum)) {
    objective_removeteamfrommask(self.objidnum, teamname);
    objective_showtoplayersinmask(self.objidnum);
  }
}

function function_d062142f367ed7b2() {
  self notify("RemoveIcon");

  if(isDefined(self) && isDefined(self.objidnum)) {
    scripts\mp\gameobjects::releaseid();
  }
}

function function_f76241db305fb78f(entity, zoffset) {
  if(!isDefined(zoffset)) {
    zoffset = 50;
  }

  function_c847bfd52c064289(entity.origin);

  if(isDefined(self.icon)) {
    objective_onentity(self.icon, entity);
    objective_setzoffset(self.icon, zoffset);
  }
}

function function_c847bfd52c064289(origin, type) {
  if(!isDefined(type)) {
    type = self.activity.type;
  }

  self.icon = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(!isDefined(self.icon) || self.icon == -1) {
    self.icon = undefined;
    return;
  }

  self.iconorigin = origin;
  objective_delete(self.icon);
  objective_icon(self.icon, function_56f8d3e2552878be(type));
  objective_setbackground(self.icon, 4);
  objective_position(self.icon, origin);
  objective_setplayintro(self.icon, 1);
  objective_setdescription(self.icon, &"MP_DMZ_MISSIONS/CONTRACT_ICON_LABEL");
  objective_state(self.icon, "current");
  function_98ba077848896a3(self.icon, 0);
  objective_sethideelevation(self.icon, 1);
  function_9427cb5974c925d9(self.icon, 1);
  function_a13e72e0427ecad2(self.icon, function_58fb674a1dd27075());
  objective_addalltomask(self.icon);
  objective_hidefromplayersinmask(self.icon);
}

function private function_56f8d3e2552878be(type) {
  icon = undefined;

  switch (type) {
    case #"hash_9e02cd4a0f3ca981":
      icon = "ui_map_icon_obj_assassin";
      break;
    case #"hash_9617cc9a55eccdd4":
      icon = "ui_map_icon_obj_scavenger";
      break;
    case #"hash_7e9cf92ed0a526f1":
      icon = "ui_map_icon_obj_sh_bomb_defuse";
      break;
    case #"hash_5f39d019572500bb":
      icon = "ui_map_icon_obj_recover";
      break;
    case #"hash_ec086b911c1011ec":
      icon = "ui_map_icon_obj_rescue";
      break;
    case #"hash_58f6d6cc1dc3e295":
      icon = "ui_map_icon_obj_bomb_collect";
      break;
    case #"hash_37bb23543c319104":
      icon = "ui_map_icon_obj_hunt";
      break;
    case #"hash_9db32d30f2603c35":
      icon = "ui_map_icon_obj_cargo_delivery";
      break;
    case #"hash_1e754eb11fa62651":
      icon = "ui_map_icon_obj_cargo_ship";
      break;
    case #"hash_2e6b7be09d7fd568":
      icon = "ui_map_icon_obj_geiger_search";
      break;
    case #"hash_bf5597954aaed3d7":
      icon = "ui_map_icon_obj_intel_dmz";
      break;
    case #"hash_82ea0e6e4f123b62":
      icon = "ui_map_icon_obj_trap";
      break;
    case #"hash_4f62da1c4ed6f790":
      icon = "ui_map_icon_obj_most_wanted";
      break;
    case #"hash_be386dc37be6968e":
      icon = "ui_map_icon_obj_dmz_supply";
      break;
    case #"hash_218ddcea32fa5fbc":
      icon = "ui_map_icon_obj_hacker";
      break;
    case #"hash_4aae0f3e58abb932":
      icon = "ui_map_icon_elite_geiger_search";
      break;
    default:
      icon = "ui_map_icon_obj_scavenger";
      break;
  }

  return icon;
}

function function_fbf23ae15945ee5a(player) {
  if(isDefined(self.icon)) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.icon, player);
  }
}

function function_a92867e16c21da22(team) {
  if(!isDefined(self.icon)) {
    return;
  }

  foreach(player in getteamdata(team, "players")) {
    function_fbf23ae15945ee5a(player);
  }
}

function function_401535e3fa9e171c(player) {
  if(isDefined(self.icon)) {
    objective_playermask_hidefrom(self.icon, player);
  }
}

function function_743033b2e6c2d930(team) {
  foreach(player in getteamdata(team, "players")) {
    function_401535e3fa9e171c(player);
  }
}

function function_629ed367d1393020() {
  if(isDefined(self.icon)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.icon);
    self.icon = -1;
  }
}

function function_cef2ed613a8338be(location) {
  if(isDefined(self.icon)) {
    self.iconorigin = location;
    objective_position(self.icon, location);
  }
}

function function_b3c1ba9fbd1dd01e(entity, zoffset) {
  if(!isDefined(zoffset)) {
    zoffset = 50;
  }

  if(isDefined(self.icon)) {
    objective_onentity(self.icon, entity);

    if(isDefined(zoffset)) {
      objective_setzoffset(self.icon, zoffset);
    }
  }
}

function function_9be29ad72a155ee1(weaponnameoverride, var_9c40af0f61186602) {
  self endon("death");
  weaponname = "intel_pickup_phone";

  if(isDefined(weaponnameoverride)) {
    weaponname = weaponnameoverride;
  }

  if(istrue(self.insertingarmorplate)) {
    self notify("try_armor_cancel");

    while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "iw9_armor_plate_deploy_mp") {
      waitframe();
    }

    waitframe();
  }

  self notify("cancel_all_killstreak_deployments");

  while(scripts\cp_mp\utility\killstreak_utility::iskillstreakdeployweapon(self getcurrentweapon())) {
    waitframe();
  }

  omnvar = function_32e9314deaf4c7be(weaponname);

  if(isDefined(var_9c40af0f61186602)) {
    omnvar = var_9c40af0f61186602;
  }

  val::set("show_intel", "weapon_switch", 0);
  val::set("show_intel", "mantle", 0);
  val::set("show_intel", "prone", 0);
  val::set("show_intel", "melee", 0);
  val::set("show_intel", "offhand_weapons", 0);
  val::set("show_intel", "weapon_pickup", 0);
  val::set("show_intel", "usability", 0);
  val::set("show_intel", "vehicle_use", 0);
  currentweapon = self getcurrentweapon();
  animatedweapon = makeweapon(weaponname);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(animatedweapon);
  self switchtoweapon(animatedweapon);
  self setclientomnvar("ui_tablet_usb", omnvar);
  thread function_1ef3aef709c7007c();
  wait function_2d0d55d0d1148c4d(weaponname);
  self takeweapon(animatedweapon);

  if(isDefined(self.throwingknifemelee) && isweapon(self.throwingknifemelee) && currentweapon == self.throwingknifemelee) {
    if(isDefined(self.primaryweapon)) {
      currentweapon = self.primaryweapon;
    } else {
      currentweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("iw9_me_fists_mp");
    }
  }

  if(istrue(self.inlaststand)) {
    if(isDefined(level.var_8b2457623e1802dc)) {
      currentweapon = self[[level.var_8b2457623e1802dc]]();
    } else {
      currentweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("iw9_me_fists_mp");
    }
  }

  self switchtoweapon(currentweapon);
  val::reset_all("show_intel");
  self setclientomnvar("ui_tablet_usb", 0);
  self notify("ui_tablet_reset");
}

function private function_32e9314deaf4c7be(weap_name) {
  switch (weap_name) {
    case #"hash_6971a5b6d5b4c43f":
    case #"hash_83bf32566065a90b":
      return 1;
    case #"hash_1f46dae464ca1c4f":
      return 2;
    case #"hash_c77f7e706b6640ab":
      return 3;
    case #"hash_52ebc6fd88a136a5":
      return 8;
    default:
      return 0;
  }
}

function private function_2d0d55d0d1148c4d(weap_name) {
  switch (weap_name) {
    case #"hash_6971a5b6d5b4c43f":
    case #"hash_83bf32566065a90b":
      return 4;
    case #"hash_1f46dae464ca1c4f":
      return 3;
    case #"hash_c77f7e706b6640ab":
      return 4.5;
    case #"hash_52ebc6fd88a136a5":
      return 4;
    case #"hash_280f1b82c041035a":
      return 8;
  }

  return 5;
}

function function_1ef3aef709c7007c() {
  self endon("ui_tablet_reset");
  level endon("game_ended");
  self waittill("death_or_disconnect");
  self setclientomnvar("ui_tablet_usb", 0);
}

function function_da38be107ae836ff(teammates, cash) {
  teamsize = float(getdvarint(@ "hash_398b5abef8d572fa", teammates.size));
  return ter_op(teamsize, cash / teamsize, 0);
}

function function_8c5476a01afab741(player, cash) {
  var_13d34a5606594fab = default_to(namespace_a38a2e1fe7519183::getupgradecount(player, 19), 0);
  cashmultiplier = 1 + 0.05 * var_13d34a5606594fab;
  return cash * cashmultiplier;
}

function function_cd4f277cf0d6a560(teamname, cash) {
  teammates = getteamdata(teamname, "players");

  if(!isDefined(teammates) || !isarray(teammates) || teammates.size == 0) {
    return;
  }

  if(!isDefined(cash)) {
    cash = self.activity.cashreward;
  }

  var_dce14f374c0bcd61 = function_da38be107ae836ff(teammates, cash);

  foreach(player in teammates) {
    multipliedcash = function_8c5476a01afab741(player, var_dce14f374c0bcd61);
    var_c65df5ef44dd0aa1 = int(ceil(multipliedcash));
    player scripts\mp\gametypes\br_plunder::playerplunderpickup(var_c65df5ef44dd0aa1);
  }
}

function function_9c6ab63c4b6bd08b(teamname, cash) {
  totalcash = 0;
  teammates = getteamdata(teamname, "players");

  if(!isDefined(teammates) || !isarray(teammates) || teammates.size == 0) {
    return;
  }

  if(!isDefined(cash)) {
    cash = self.activity.cashreward;
  }

  var_dce14f374c0bcd61 = function_da38be107ae836ff(teammates, cash);

  foreach(player in teammates) {
    multipliedcash = function_8c5476a01afab741(player, var_dce14f374c0bcd61);
    totalcash += multipliedcash;
  }

  return int(ceil(totalcash));
}

function task_ended(var_5e671fc71e72d5e8, var_644a33d86d8514bf) {
  if(isDefined(var_5e671fc71e72d5e8)) {
    players = getteamdata(var_5e671fc71e72d5e8, "players");

    if(isDefined(players)) {
      foreach(player in players) {
        level thread scripts\mp\gametypes\br_gametype_dmz::function_1be19e52e991d817(player);
      }
    }
  }

  self.activity function_18d4e8025ec24a0(self, var_5e671fc71e72d5e8, var_644a33d86d8514bf);
}

function function_6f6f83ab76483811(instance, player) {
  if(!isDefined(instance) || !isDefined(instance.task)) {
    return;
  }

  task = instance.task;

  if(array_contains(task.teams, player.team)) {
    task task_ended(player.team);
  }
}

function function_8158903a6e2f32fd(task, player) {
  return isDefined(task) && isDefined(task.teams) && isDefined(player) && isDefined(player.team) && array_contains(task.teams, player.team);
}

function function_65a2513d3692ea1a(teamname) {
  assert(isDefined(self.activity.type), "<dev string:x6a>");
  function_1759acfd39bb5edf("dmz_generic_" + self.activity.type + "_mission_assigned", teamname);
}

function function_a1738a95d7aa8094(splash, contractref, cashreward, teamname) {
  contractindex = level.var_1b7407dffe81e6e8.spawndatamap[contractref].index;
  params = namespace_1eb3c4e0e28fac71::packsplashparambits(contractindex, cashreward);
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash(splash, getteamdata(teamname, "players"), undefined, params);
}

function function_1759acfd39bb5edf(splash, teamname) {
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash(splash, getteamdata(teamname, "players"), self.node.poi);
}

function function_3a1b792c4eab210f(splash) {
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash(splash, level.players);
}

function function_c9f97baa0d7f59bf(splash, teamname) {
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash(splash, array_remove_array(level.players, getteamdata(teamname, "players")), self.node.poi);
}

function function_137d718c82ac0947(teamname) {
  if(!isDefined(level.radiation) || !istrue(level.radiation.spreading)) {
    wait 5;

    if(!istrue(level.var_644a33d86d8514bf)) {
      scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_contract_reminder", getteamdata(teamname, "players"));
    }
  }
}

function function_1458f4e9320a8ae1(point) {
  radius = 0;

  if(point.spawnflags & 4) {
    radius = 256;
  } else if(point.spawnflags & 2) {
    radius = 128;
  } else if(point.spawnflags & 1) {
    radius = 168;
  }

  return radius;
}

function function_70313f3b61e1aeef() {
  if(isDefined(level.var_fe29a5bf2f96b5d3) && level.var_fe29a5bf2f96b5d3.size > 1) {
    return level.var_fe29a5bf2f96b5d3;
  }

  return [];
}

function function_739560269bc164cf(teamname) {
  foreach(player in getteamdata(teamname, "players")) {
    function_cfd53c8f6878014f(player);
  }
}

function function_9688f0dc7dfd3d53(teamname) {
  foreach(player in getteamdata(teamname, "players")) {
    function_d7d113d56ef0ef5b(player);
  }
}

function function_42718c89b38e260b(objidnum, teams) {
  foreach(team in teams) {
    function_6dad7e4d170de4ba(objidnum, team);
  }
}

function function_6dad7e4d170de4ba(objidnum, team) {
  foreach(player in getteamdata(team, "players")) {
    scripts\mp\objidpoolmanager::objective_unpin_player(objidnum, player);
    scripts\mp\objidpoolmanager::function_7299a742781a5030(0, player);
  }
}

function function_83dd17f313ffdec0(inorigin, var_5b9c864b21207ff6, task) {
  cache = spawnscriptable("br_loot_cache", inorigin, var_5b9c864b21207ff6);
  cache setscriptablepartstate("body", "open_usable");
  function_c573d8a23f7faf06(cache, []);
  cache.task = task;
  task.cache = cache;
  return cache;
}

function function_c573d8a23f7faf06(cache, teams) {
  validplayers = [];

  foreach(team in teams) {
    validplayers = array_combine(validplayers, getteamdata(team, "players"));
  }

  foreach(player in level.players) {
    if(array_contains(validplayers, player)) {
      cache enablescriptableplayeruse(player);
      continue;
    }

    cache disablescriptableplayeruse(player);
  }
}

function function_f8cd22fb229f4138(cash) {
  if(!isDefined(cash) || cash == 0) {
    return 1;
  }

  return int(cash / 25 - 1);
}

function function_b43e9536b7e60884(player, index) {
  player namespace_1eb3c4e0e28fac71::setquestindexomnvar(index);
}

function function_b7bbe29ed551ee90(index, tier, teamname) {
  foreach(player in getteamdata(teamname, "players")) {
    function_b43e9536b7e60884(player, index);
  }

  if(!isDefined(tier)) {
    tier = 1;
  }

  namespace_1eb3c4e0e28fac71::setquestrewardtier(teamname, tier);
}

function function_6d93be335873296e(player) {
  player namespace_1eb3c4e0e28fac71::setquestindexomnvar(0);
}

function function_83d7eb52598be0b3(teamname) {
  foreach(player in getteamdata(teamname, "players")) {
    function_6d93be335873296e(player);
  }
}

function function_5314298e777e5688(ref) {
  self.ref = ref;
  self.refindex = namespace_1eb3c4e0e28fac71::getquesttableindex(self.ref);
  tier = 1;

  if(isDefined(self.activity)) {
    cashreward = self.activity.cashreward;
    tier = function_f8cd22fb229f4138(cashreward);
  }

  foreach(team in self.teams) {
    function_b7bbe29ed551ee90(self.refindex, tier, team);
  }
}

function function_dffcbce998c9ee50(teamname) {
  key = self.activitykey;
  players = getteamdata(teamname, "players");

  foreach(player in players) {
    player.activitykey = key;
  }
}

function function_45bd3184ff146b46(teamname) {
  if(isDefined(teamname)) {
    players = getteamdata(teamname, "players");

    foreach(player in players) {
      player.activitykey = undefined;
    }
  }
}

function function_d86771edadba8b4a(instance, task, player) {
  task endon("bomb_planted");
  task endon("bomb_defused");
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  player endon("enter_live_ragdoll");
  player notifyonplayercommand("cancel", "+weapnext");
  instance.cancel = 0;
  player waittill("cancel");
  instance.cancel = 1;
}