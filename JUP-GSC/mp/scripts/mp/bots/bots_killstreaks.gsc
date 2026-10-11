/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bots\bots_killstreaks.gsc
***************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\teams;
#namespace bots_killstreaks;

function bot_killstreak_setup() {
  if(!isDefined(level.killstreak_botfunc)) {
    if(!isDefined(level.killstreak_botfunc)) {
      level.killstreak_botfunc = [];
    }

    if(!isDefined(level.killstreak_botcanuse)) {
      level.killstreak_botcanuse = [];
    }

    if(!isDefined(level.killstreak_botparm)) {
      level.killstreak_botparm = [];
    }

    if(!isDefined(level.bot_supported_killstreaks)) {
      level.bot_supported_killstreaks = [];
    }

    if(istrue(game["isLaunchChunk"])) {
      return;
    }

    bot_register_killstreak_func("uav", &bot_killstreak_simple_use);
    bot_register_killstreak_func("directional_uav", &bot_killstreak_simple_use);

    if(isDefined(level.mapcustombotkillstreakfunc)) {
      [[level.mapcustombotkillstreakfunc]]();
    }

    function_227b3e3c529f9d0();
  }
}

function bot_register_killstreak_func(name, func, can_use, optionalparam) {
  if(!isDefined(level.streakglobals.streakbundles[name])) {
    println("<dev string:x1c>" + name + "<dev string:x5d>");
    return;
  }

  level.killstreak_botfunc[name] = func;
  level.killstreak_botcanuse[name] = can_use;
  level.killstreak_botparm[name] = optionalparam;
  level.bot_supported_killstreaks[level.bot_supported_killstreaks.size] = name;
}

function function_41a8ca2dae1a1343(streak) {
  if(!function_d66de7b5a877b42c(streak)) {
    assertmsg("<dev string:x8e>" + streak + "<dev string:xb2>");
  }
}

function function_26244da889a0235a(streak, bot) {
  if(!function_49c1e963fb43ee47(streak, bot)) {
    assertmsg("<dev string:xb7>" + bot.name + "<dev string:xc0>" + streak + "<dev string:xb2>");
  }
}

function function_227b3e3c529f9d0() {
  wait 1;
  errors = [];

  foreach(streakname in level.bot_supported_killstreaks) {
    if(!function_c8ae136cc2c20507(streakname)) {
      error("<dev string:xe3>" + streakname);
      errors[errors.size] = streakname;
    }

    wait 0.05;
  }

  if(errors.size) {
    temp = level.killstreaksetups;
    level.killstreaksetups = [];

    foreach(streakname in temp) {
      if(!array_contains(errors, streakname)) {
        level.killstreaksetups[streakname] = temp[streakname];
      }
    }
  }
}

function function_c8ae136cc2c20507(streakname) {
  return bot_killstreak_is_valid_internal(streakname, "<dev string:x11b>");
}

function function_d66de7b5a877b42c(streakname) {
  return bot_killstreak_is_valid_internal(streakname, "<dev string:x125>");
}

function function_49c1e963fb43ee47(streakname, bot) {
  return bot_killstreak_is_valid_internal(streakname, "<dev string:x125>", bot);
}

function bot_killstreak_valid_for_specific_streaktype(streakname, streaktype, assertit) {
  if(bot_killstreak_is_valid_internal(streakname, "bots", undefined, streaktype)) {
    return true;
  } else if(assertit) {
    assertmsg("<dev string:x12d>" + streaktype + "<dev string:x147>" + streakname + "<dev string:xb2>");
  }

  return false;
}

function bot_killstreak_is_valid_internal(streakname, var_ca854a77f264bed6, optional_bot, var_1c9ca7dbe4790741) {
  var_c61cd683f3a90cc2 = undefined;

  if(streakname == "specialist") {
    return true;
  }

  if(!bot_killstreak_is_valid_single(streakname, var_ca854a77f264bed6)) {
    return false;
  }

  if(isDefined(var_1c9ca7dbe4790741)) {
    var_c61cd683f3a90cc2 = getsubstr(var_1c9ca7dbe4790741, 11);

    switch (var_c61cd683f3a90cc2) {
      case #"hash_d4f05e450448c3ec":
        if(!isassaultkillstreak(streakname)) {
          return false;
        }

        break;
      case #"hash_605929bc0f7f95c8":
        if(!issupportkillstreak(streakname)) {
          return false;
        }

        break;
      case #"hash_2bee0bf604b15c84":
        if(!isspecialistkillstreak(streakname)) {
          return false;
        }

        break;
    }
  }

  return true;
}

function bot_killstreak_is_valid_single(streakname, var_ca854a77f264bed6) {
  if(var_ca854a77f264bed6 == "humans") {
    return (isDefined(level.killstreaksetups[streakname]) && scripts\cp_mp\utility\killstreak_utility::getkillstreakindex(streakname) != -1);
  } else if(var_ca854a77f264bed6 == "bots") {
    return isDefined(level.killstreak_botfunc[streakname]);
  }

  assertmsg("<dev string:x168>");
}

function bot_watch_for_killstreak_use() {
  self notify("bot_watch_for_killstreak_use");
  self endon("bot_watch_for_killstreak_use");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("killstreak_use_finished");
    _switchtoweapon("none");
  }
}

function bot_is_killstreak_supported(name) {
  if(!isDefined(name)) {
    return false;
  }

  if(!isDefined(level.killstreak_botfunc[name])) {
    return false;
  }

  return true;
}

function bot_can_use_killstreak(name) {
  var_f40f83e224a240f1 = level.killstreak_botcanuse[name];

  if(!isDefined(var_f40f83e224a240f1)) {
    return false;
  }

  if(isDefined(var_f40f83e224a240f1) && !self[[var_f40f83e224a240f1]]()) {
    return false;
  }

  return true;
}

function bot_think_killstreak() {}

function bot_can_use_aa_launcher() {
  return false;
}

function bot_start_aa_launcher_tracking() {}

function bot_killstreak_never_use() {
  assertmsg("<dev string:x177>");
}

function bot_can_use_air_superiority() {
  return false;
}

function aerial_vehicle_allowed() {
  if(isairdenied()) {
    return false;
  }

  if(vehicle_would_exceed_limit()) {
    return false;
  }

  return true;
}

function vehicle_would_exceed_limit() {
  return currentactivevehiclecount() >= maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maxvehiclesallowed();
}

function bot_can_use_emp() {
  if(isDefined(level.empplayer)) {
    return false;
  }

  enemyteams = getenemyteams(self.owner.team);

  foreach(entry in enemyteams) {
    if(isDefined(level.teamemped) && !istrue(level.teamemped[entry])) {
      return true;
    }
  }

  return false;
}

function bot_can_use_ball_drone() {
  return false;
}

function bot_killstreak_simple_use(killstreak_info, killstreaks_array, canusefunc, optional_param) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait randomintrange(3, 5);

  if(!bot_allowed_to_use_killstreaks()) {
    return true;
  }

  if(isDefined(canusefunc) && !self[[canusefunc]]()) {
    return false;
  }

  bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, killstreak_info.weapon);
  return true;
}

function bot_killstreak_drop_anywhere(killstreak_info, killstreaks_array, canusefunc, optional_param) {
  bot_killstreak_drop(killstreak_info, killstreaks_array, canusefunc, optional_param, "anywhere");
}

function bot_killstreak_drop_outside(killstreak_info, killstreaks_array, canusefunc, optional_param) {
  bot_killstreak_drop(killstreak_info, killstreaks_array, canusefunc, optional_param, "outside");
}

function bot_killstreak_drop_hidden(killstreak_info, killstreaks_array, canusefunc, optional_param) {
  bot_killstreak_drop(killstreak_info, killstreaks_array, canusefunc, optional_param, "hidden");
}

function bot_killstreak_drop(killstreak_info, killstreaks_array, canusefunc, optional_param, drop_where) {
  wait randomintrange(2, 4);

  if(!isDefined(drop_where)) {
    drop_where = "anywhere";
  }

  if(!bot_allowed_to_use_killstreaks()) {
    return true;
  }

  if(isDefined(canusefunc) && !self[[canusefunc]]()) {
    return false;
  }

  ammo = self getweaponammoclip(killstreak_info.weapon) + self getweaponammostock(killstreak_info.weapon);

  if(ammo == 0) {
    foreach(streak in killstreaks_array) {
      if(isDefined(streak.streakname) && streak.streakname == killstreak_info.streakname) {
        streak.available = 0;
      }
    }

    return true;
  }

  node_target = undefined;

  if(drop_where == "outside") {
    outside_nodes = [];
    nodes_in_cone = bot_get_nodes_in_cone(0, 750, 0.6, 1);

    foreach(node in nodes_in_cone) {
      if(nodeexposedtosky(node)) {
        outside_nodes = array_add(outside_nodes, node);
      }
    }

    if(nodes_in_cone.size > 5 && outside_nodes.size > nodes_in_cone.size * 0.6) {
      var_3465221989e8dfce = get_array_of_closest(self.origin, outside_nodes, undefined, undefined, undefined, 150);

      if(var_3465221989e8dfce.size > 0) {
        node_target = random(var_3465221989e8dfce);
      } else {
        node_target = random(outside_nodes);
      }
    }
  } else if(drop_where == "hidden") {
    var_3778710dc16cfeeb = getnodesinradius(self.origin, 256, 0, 40);
    var_170e87a3a1e8af42 = self getnearestnode();

    if(isDefined(var_170e87a3a1e8af42)) {
      var_dff426cfcddb03b2 = [];

      foreach(node in var_3778710dc16cfeeb) {
        if(nodesvisible(var_170e87a3a1e8af42, node, 1)) {
          var_dff426cfcddb03b2 = array_add(var_dff426cfcddb03b2, node);
        }
      }

      node_target = self botnodepick(var_dff426cfcddb03b2, 1, "node_hide");
    }
  }

  if(isDefined(node_target) || drop_where == "anywhere") {
    self botsetflag("disable_movement", 1);

    if(isDefined(node_target)) {
      self botlookatpoint(node_target.origin, 2.45, "script_forced");
    }

    bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, killstreak_info.weapon);
    wait 2;
    self botpressbutton("attack");
    wait 1.5;
    _switchtoweapon("none");
    self botsetflag("disable_movement", 0);
  }

  return true;
}

function bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, weapon_name) {
  bot_notify_streak_used(killstreak_info, killstreaks_array);
}

function bot_notify_streak_used(killstreak_info, killstreaks_array) {
  if(isDefined(killstreak_info.isgimme) && killstreak_info.isgimme) {
    self notify("ks_action_6");
    return;
  }

  for(index = 1; index < 4; index++) {
    if(isDefined(killstreaks_array[index])) {
      if(isDefined(killstreaks_array[index].streakname)) {
        if(killstreaks_array[index].streakname == killstreak_info.streakname) {
          notifynum = index + 2;
          self notify("ks_action_" + notifynum);
          return;
        }
      }
    }
  }
}

function bot_killstreak_choose_loc_enemies(killstreak_info, killstreaks_array, canusefunc, optional_param) {
  wait randomintrange(3, 5);

  if(!bot_allowed_to_use_killstreaks()) {
    return;
  }

  var_cf12256f80ff2408 = getzonenearest(self.origin);

  if(!isDefined(var_cf12256f80ff2408)) {
    return;
  }

  self botsetflag("disable_movement", 1);
  bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, killstreak_info.weapon);
  wait 2;
  zone_count = level.zonecount;
  best_zone = -1;
  var_406b87b58c6d47fe = 0;
  possible_fallback_zones = [];
  var_a04286db27fdd0d4 = randomfloat(100) > 50;

  for(z = 0; z < zone_count; z++) {
    if(var_a04286db27fdd0d4) {
      zone = zone_count - 1 - z;
    } else {
      zone = z;
    }

    if(zone != var_cf12256f80ff2408 && botzonegetindoorpercent(zone) < 0.25) {
      enemies_in_zone = botzonegetcount(zone, self.team, "enemy_predict");

      if(enemies_in_zone > var_406b87b58c6d47fe) {
        best_zone = zone;
        var_406b87b58c6d47fe = enemies_in_zone;
      }

      possible_fallback_zones = array_add(possible_fallback_zones, zone);
    }
  }

  if(best_zone >= 0) {
    zonecenter = getzoneorigin(best_zone);
  } else if(possible_fallback_zones.size > 0) {
    zonecenter = getzoneorigin(random(possible_fallback_zones));
  } else {
    zonecenter = getzoneorigin(randomint(level.zonecount));
  }

  randomoffset = (randomfloatrange(-500, 500), randomfloatrange(-500, 500), 0);
  self notify("confirm_location", zonecenter + randomoffset, randomintrange(0, 360));
  wait 1;
  self botsetflag("disable_movement", 0);
}

function bot_think_watch_aerial_killstreak() {
  self notify("bot_think_watch_aerial_killstreak");
  self endon("bot_think_watch_aerial_killstreak");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(level.last_global_badplace_time)) {
    level.last_global_badplace_time = -10000;
  }

  level.killstreak_global_bp_exists_for["allies"] = [];
  level.killstreak_global_bp_exists_for["axis"] = [];
  currently_hiding = 0;
  var_6de804c7fc796da8 = randomfloatrange(0.05, 4);

  while(true) {
    if(getdvarint(@ "hash_c2de8ca6dc8512c1")) {
      wait 0.05;
      continue;
    }

    wait var_6de804c7fc796da8;
    var_6de804c7fc796da8 = randomfloatrange(0.05, 4);
    assert(!isDefined(level.remote_mortar));

    if(bot_is_remote_or_linked()) {
      continue;
    }

    if(self botgetdifficultysetting("strategyLevel") == 0) {
      continue;
    }

    var_fe0228cd32ee3063 = 0;

    if(isDefined(level.chopper) && level.chopper.team != self.team) {
      var_fe0228cd32ee3063 = 1;
    }

    if(isDefined(level.lbsniper) && level.lbsniper.team != self.team) {
      var_fe0228cd32ee3063 = 1;
    }

    if(!scripts\cp_mp\utility\game_utility::ismagellanmode() || level.mapname != "mp_don3_mobile") {
      if(enemy_mortar_strike_exists(self.team)) {
        var_fe0228cd32ee3063 = 1;
        try_place_global_badplace("mortar_strike", &enemy_mortar_strike_exists);
      }

      if(enemy_switchblade_exists(self.team)) {
        var_fe0228cd32ee3063 = 1;
        try_place_global_badplace("switchblade", &enemy_switchblade_exists);
      }

      if(enemy_odin_assault_exists(self.team)) {
        var_fe0228cd32ee3063 = 1;
        try_place_global_badplace("odin_assault", &enemy_odin_assault_exists);
      }
    }

    enemy_vanguard = get_enemy_vanguard();

    if(isDefined(enemy_vanguard)) {
      boteye = self getEye();

      if(within_fov(boteye, self getplayerangles(), enemy_vanguard.attackarrow.origin, self botgetfovdot())) {
        if(sighttracepassed(boteye, enemy_vanguard.attackarrow.origin, 0, self, enemy_vanguard.attackarrow)) {
          badplace_cylinder("vanguard_" + enemy_vanguard getentitynumber(), var_6de804c7fc796da8 + 0.5, enemy_vanguard.attackarrow.origin, 200, 100, self.team);
        }
      }
    }

    if(!currently_hiding && var_fe0228cd32ee3063) {
      currently_hiding = 1;
      self botsetflag("hide_indoors", 1);
    }

    if(currently_hiding && !var_fe0228cd32ee3063) {
      currently_hiding = 0;
      self botsetflag("hide_indoors", 0);
    }
  }
}

function try_place_global_badplace(var_205d69eb70594bb7, var_c5a29305adbe9b8b) {
  if(!isDefined(level.killstreak_global_bp_exists_for[self.team][var_205d69eb70594bb7])) {
    level.killstreak_global_bp_exists_for[self.team][var_205d69eb70594bb7] = 0;
  }

  if(!level.killstreak_global_bp_exists_for[self.team][var_205d69eb70594bb7]) {
    level.killstreak_global_bp_exists_for[self.team][var_205d69eb70594bb7] = 1;
    level thread monitor_enemy_dangerous_killstreak(self.team, var_205d69eb70594bb7, var_c5a29305adbe9b8b);
  }
}

function monitor_enemy_dangerous_killstreak(my_team, var_205d69eb70594bb7, var_c5a29305adbe9b8b) {
  assert(5 > 4);
  wait_time = (5 - 4) * 0.5;

  while([[var_c5a29305adbe9b8b]](my_team)) {
    if(gettime() > level.last_global_badplace_time + 4000) {
      level.last_global_badplace_time = gettime();
    }

    wait wait_time;
  }

  level.killstreak_global_bp_exists_for[my_team][var_205d69eb70594bb7] = 0;
}

function enemy_mortar_strike_exists(my_team) {
  if(isDefined(level.air_raid_active) && level.air_raid_active) {
    if(my_team != level.air_raid_team_called) {
      return true;
    }
  }

  return false;
}

function enemy_switchblade_exists(my_team) {
  if(isDefined(level.remotemissileinprogress)) {
    foreach(rocket in level.rockets) {
      if(isDefined(rocket.type) && rocket.type == "remote" && rocket.team != my_team) {
        return true;
      }
    }
  }

  return false;
}

function enemy_odin_assault_exists(my_team) {
  foreach(player in level.players) {
    if(!level.teambased || isDefined(player.team) && my_team != player.team) {
      if(isDefined(player.odin) && player.odin.odintype == "odin_assault" && gettime() - player.odin.birthtime > 3000) {
        return true;
      }
    }
  }

  return false;
}

function get_enemy_vanguard() {
  foreach(player in level.players) {
    if(!level.teambased || isDefined(player.team) && self.team != player.team) {
      if(isDefined(player.remoteuav) && player.remoteuav.helitype == "remote_uav") {
        return player.remoteuav;
      }
    }
  }

  return undefined;
}