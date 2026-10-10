/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_645acc6422636f9f.gsc
*************************************************/

#using script_1174abedbefe9ada;
#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_2707474774db34b;
#using script_41387eecc35b88bf;
#using script_482376d10f69832c;
#using script_4948cdf739393d2d;
#using script_54f6d121e91434f8;
#using script_7956d56c4922bd1;
#using scripts\anim\utility;
#using scripts\common\devgui;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\locksandkeys;
#using scripts\mp\poi;
#using scripts\mp\rank;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace namespace_848c7a35c6f1e038;

function function_4c10c992dc615a41() {
  function_900f562c61c6a5d6("activitystarter", &function_de0335fbc04f4627, &function_ace26cc769bb2893, &function_2ecbced517e86330, &function_6297546c34dcb084, &function_f8d26b52b2f1c4e);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("nexus_activity_joiner_phone", &function_1936902486bfb1a1);

  if(isDefined(level.var_5b7c4eafd38d35c) && !isDefined(level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38)) {
    level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38 = [];
    level.var_5b7c4eafd38d35c.var_d6d000f64c923fd6 = 1;
    level thread function_c2bc2321e8cb9c49();

    level thread function_5123ce2f281ba0da();
    level thread function_3e3b22a6655663b2();
  }
}

function function_47e23924dd56365(relevant_parameters) {
  activity_instance = relevant_parameters[0];
  var_860c4b444bc9f11d = relevant_parameters[1];

  foreach(activity_starter in var_860c4b444bc9f11d) {
    if(istrue(activity_instance.var_e726c726c6fb7dec)) {
      thread function_5f8609748985f5b0(activity_instance, activity_starter);
      continue;
    }

    activate_activity_starter(activity_instance, activity_starter);
  }
}

function function_5f8609748985f5b0(activity_instance, var_b189a678c1c3489a) {
  activity_instance waittill("activate_activity_starter");
  activate_activity_starter(activity_instance, var_b189a678c1c3489a);
}

function activate_activity_starter(activity_instance, var_b189a678c1c3489a) {
  if(isDefined(var_b189a678c1c3489a)) {
    activity_origin = var_b189a678c1c3489a.origin;
    var_b189a678c1c3489a.activity_origin = activity_origin;
    var_b189a678c1c3489a.activity_instance = activity_instance;
    activity_instance.var_b189a678c1c3489a = var_b189a678c1c3489a;
    var_b189a678c1c3489a function_80cb315b3807f968();
    activitytype = function_de53ed8e35d0ed7a(activity_instance);
    var_b189a678c1c3489a.poiindex = scripts\mp\poi::function_80cdaea4bd3ecf70(scripts\mp\poi::function_55cf921efa4cbd09(activity_origin, 0, 0));
    var_84fe3185d80d053b = [[level.var_fac39a693f085779]](namespace_68dc261109a9503f::function_8988a4c89289d7f4(activity_instance));
    scoreevent = namespace_e8853d3344e33cf6::function_9d71b982e1eb2f81(var_84fe3185d80d053b);
    var_b189a678c1c3489a.currencyreward = scripts\mp\rank::getscoreinfovalue(scoreevent);

    if(!isDefined(level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38)) {
      level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38 = [var_b189a678c1c3489a];
    } else {
      level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38[level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38.size] = var_b189a678c1c3489a;
    }

    function_8b5b2a3392fc7e2a("InstanceEnd", &function_6a5979dbe84a584a);
  }
}

function function_b4c8d27633108d43(suffix, activity_origin, var_8310af2bd45efa3, var_d068613f5e3cc8a8) {
  assert(isDefined(suffix) && isDefined(activity_origin));
  activity_instance = self;
  var_509e1fb858cfabbc = ter_op(isDefined(var_8310af2bd45efa3), squared(var_8310af2bd45efa3), 0);
  var_8951bcb97ca82a19 = ter_op(isDefined(var_d068613f5e3cc8a8), squared(var_d068613f5e3cc8a8), 0);
  var_1b395a12bbf3f5ec = [];
  var_9c21b36afb275651 = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "nexus_activity_joiner_phone");
  var_9c21b36afb275651 = function_f1df6aa7601a5411(var_9c21b36afb275651);

  foreach(starter in var_9c21b36afb275651) {
    if(suffix == getsubstr(starter.type, 24)) {
      var_1b395a12bbf3f5ec[var_1b395a12bbf3f5ec.size] = starter;
    }
  }

  activity_starter = undefined;
  best_difference = 999999999;

  foreach(starter in var_1b395a12bbf3f5ec) {
    dist = distancesquared(starter.origin, activity_origin);
    diff = abs(dist - var_8951bcb97ca82a19);

    if(diff < best_difference && dist >= var_509e1fb858cfabbc) {
      if(diff < 150) {
        activity_starter = starter;
        break;
      }

      activity_starter = starter;
      best_difference = diff;
    }
  }

  if(isDefined(activity_starter)) {
    activity_starter.activity_origin = activity_origin;
    activity_starter.activity_instance = activity_instance;
    activity_instance.activity_starter = activity_starter;
    activity_starter function_80cb315b3807f968();
    activitytype = function_de53ed8e35d0ed7a(activity_instance);
    var_84fe3185d80d053b = [[level.var_fac39a693f085779]](namespace_68dc261109a9503f::function_8988a4c89289d7f4(activity_instance));
    scoreevent = namespace_e8853d3344e33cf6::function_9d71b982e1eb2f81(var_84fe3185d80d053b);
    activity_starter.currencyreward = scripts\mp\rank::getscoreinfovalue(scoreevent);
    activity_starter.poiindex = scripts\mp\poi::function_80cdaea4bd3ecf70(scripts\mp\poi::function_55cf921efa4cbd09(activity_origin, 0, 0));

    if(!isDefined(level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38)) {
      level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38 = [activity_starter];
    } else {
      level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38[level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38.size] = activity_starter;
    }
  }

  return activity_starter;
}

function function_80cb315b3807f968() {
  if(istrue(level.var_5b7c4eafd38d35c.var_d6d000f64c923fd6)) {
    self setscriptablepartstate("nexus_activity_joiner_phone", "visible");
  } else {
    self setscriptablepartstate("nexus_activity_joiner_phone", "visible_no_icon");
  }

  self.visible = 1;
}

function function_9c2b62cf9d5bcdeb() {
  level notify("tablethide_kill_callout_" + self.origin);
  self setscriptablepartstate("nexus_activity_joiner_phone", "hidden");
  self.visible = 0;
}

function function_445346f57d5ef3ac(team, enabled) {
  foreach(player in getteamdata(team, "players")) {
    function_a410e3348511f9c0(player, enabled);
  }
}

function function_a410e3348511f9c0(player, enabled) {
  if(isDefined(player) && isDefined(level.var_5b7c4eafd38d35c) && isDefined(level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38)) {
    foreach(starter in level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38) {
      if(istrue(enabled)) {
        starter enablescriptableplayeruse(player);
        continue;
      }

      starter disablescriptableplayeruse(player);
    }
  }
}

function function_de0335fbc04f4627(item_bundle, item, auto_use) {
  return false;
}

function function_ace26cc769bb2893(item_bundle, item, auto_use, allow_swap) {
  return false;
}

function function_2ecbced517e86330(tem_bundle, item, auto_use, allow_swap) {
  return false;
}

function function_6297546c34dcb084() {
  return [undefined, 0];
}

function function_f8d26b52b2f1c4e(quantity) {
  return false;
}

function function_c2bc2321e8cb9c49() {
  level endon("game_ended");

  while(true) {
    wait 1;

    if(level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38.size == 0) {
      continue;
    }

    foreach(player in level.players) {
      var_3900d8bea91376b4 = function_5cc2fd3d10cbab56(player);

      if(isDefined(player) && isDefined(player.origin) && isDefined(player.team) && isalive(player) && function_6152021549f1836b(player) && !isDefined(var_3900d8bea91376b4.var_6346961d07f668fe)) {
        closest = sortbydistance(level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38, player.origin)[0];
        player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_dmz_activity_starter_poi_name", closest.poiindex);
      }
    }
  }
}

function function_f1df6aa7601a5411(locations) {
  scripts\mp\locksandkeys::function_1a037d5cd64dc892();
  validlocations = [];
  var_229dd59111a2fa54 = getdvarint(@ "hash_b54c660e3e9515b2", 1000);
  var_aa5a3885f8d284dc = var_229dd59111a2fa54 * var_229dd59111a2fa54;

  foreach(location in locations) {
    if(!isDefined(location.visible) && !namespace_7789f919216d38a2::function_cdcab1374db7f007(location.origin) && (!isDefined(level.poi_names) || scripts\mp\poi::function_9c93e67f90980177(location.origin)) && (!isDefined(level.uniquedoors) || level.uniquedoors.size == 0 || distance(sortbydistance(level.uniquedoors, location.origin)[0].origin, location.origin) > 350) && (validlocations.size == 0 || distancesquared(sortbydistance(validlocations, location.origin)[0].origin, location.origin) > var_aa5a3885f8d284dc) && !namespace_9823ee6035594d67::function_f0201365c368cf88(location.origin)) {
      validlocations[validlocations.size] = location;
    }
  }

  return validlocations;
}

function function_1936902486bfb1a1(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  level thread function_32b0fe545794719a(instance, player);
}

function function_32b0fe545794719a(instance, player) {
  activity_instance = instance.activity_instance;
  var_81fccd8b5f2b5309 = function_e931f3b80616c348(activity_instance);
  var_392b5fcd722198dd = namespace_8d0d5743d0799922::function_93587d5ba6247f36(var_81fccd8b5f2b5309, player);

  if(!var_392b5fcd722198dd) {
    return;
  }

  function_4e7f17d64122dd46(instance);
  player playlocalsound("mp_dmz_phone_pickup");
  player notify("ob_activity_starter_used", activity_instance);

  if(getdvarint(@ "ob_rift_run", 0) || getdvarint(@ "hash_c385fef4df4638cb", 0)) {
    player scripts\anim\utility::function_b5216a6d7bd17210("jup_ges_mrpeeks_pickup", 1);
  } else if(!getdvarint(@ "ob_s3_rift_run", 0)) {
    player scripts\mp\gametypes\dmz_task_utils::function_9be29ad72a155ee1();
  }

  if(getdvarint(@ "hash_77f6de1d536c1ca1", 1)) {
    var_84fe3185d80d053b = [[level.var_fac39a693f085779]](namespace_68dc261109a9503f::function_8988a4c89289d7f4(activity_instance));
    difficultyid = level.var_f721fc7d0d2d0f47.var_6ee86f7730b38593[var_84fe3185d80d053b];
    squad = scripts\mp\utility\teams::getsquadmates(player.team, player.sessionsquadid, 0);

    foreach(squadmember in squad) {
      if(!function_4ab1cdfd84bbd3f2(activity_instance, squadmember)) {
        squadmember scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_ob_active_contract_region_difficulty", difficultyid);
      }
    }
  }

  function_bbdcd857d0c2a65e(instance.activity_instance, player, "PlayerJoinedInteract");
}

function private function_6a5979dbe84a584a(var_6f8af5eb76deac21) {
  activity_instance = self;

  if(isDefined(activity_instance.var_b189a678c1c3489a)) {
    function_4e7f17d64122dd46(activity_instance.var_b189a678c1c3489a);
  }
}

function private function_4e7f17d64122dd46(activity_starter) {
  if(isDefined(activity_starter) && !istrue(activity_starter.var_4740350ce557fc99)) {
    level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38 = array_remove(level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38, activity_starter);
    activity_starter function_9c2b62cf9d5bcdeb();
    activity_starter.var_4740350ce557fc99 = 1;
  }
}

function private function_5123ce2f281ba0da() {
  function_6e7290c8ee4f558b("<dev string:x1c>");
  function_df648211d66cd3dd("<dev string:x44>", "<dev string:x51>");
  function_df648211d66cd3dd("<dev string:x76>", "<dev string:x8a>");
  function_df648211d66cd3dd("<dev string:xb6>", "<dev string:xcd>");
  function_fe953f000498048f();
}

function private function_3e3b22a6655663b2() {
  timer = 0;
  var_fd5a08e385a75f6c = 360;

  while(true) {
    if(getdvarint(@ "hash_d0316f72a21f836e", 0) && timer == 0) {
      foreach(starter in level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38) {
        print3d(starter.origin + (0, 0, 300), "<dev string:xfc>" + function_de53ed8e35d0ed7a(starter.activity_instance) + "<dev string:x106>" + function_a4748b32a824c79c(starter.activity_instance) + "<dev string:x114>" + function_f0f498aed6f8fa5d(starter.activity_instance), (1, 1, 1), 1, 2, var_fd5a08e385a75f6c, 1);
        line(starter.origin, starter.activity_origin, (0, 0, 1), 1, 0, var_fd5a08e385a75f6c);
        line(starter.origin, starter.origin + (0, 0, 3000), (1, 0, 1), 1, 0, var_fd5a08e385a75f6c);
      }
    }

    if(getdvarint(@ "hash_7ab902fb378bcf96", 0)) {
      setDvar(@ "hash_7ab902fb378bcf96", 0);
      level.players[0] scripts\mp\gametypes\dmz_task_utils::function_9be29ad72a155ee1();
    }

    if(getdvarint(@ "hash_a1e9c5a43f9fc548", 0)) {
      setDvar(@ "hash_a1e9c5a43f9fc548", 0);

      if(isDefined(level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38)) {
        closest = sortbydistance(level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38, level.players[0].origin);

        if(isDefined(closest)) {
          level.players[0] setOrigin(closest[0].origin + (64, 64, 64));
        }
      }
    }

    waitframe();
    timer++;

    if(timer >= var_fd5a08e385a75f6c) {
      timer = 0;
    }
  }
}

# /