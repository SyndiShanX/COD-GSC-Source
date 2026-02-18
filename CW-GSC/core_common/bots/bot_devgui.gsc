/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\bots\bot_devgui.gsc
***********************************************/

#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#namespace bot_devgui;

function private autoexec __init__system__() {
  system::register(#"bot_devgui", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(util::is_frontend_map()) {
    return;
  }

  if(isshipbuild() || currentsessionmode() == 4 || currentsessionmode() == 2) {
    return;
  }

  callback::on_connect(&on_player_connect);
  callback::on_disconnect(&on_player_disconnect);
  callback::on_spawned(&on_player_spawned);
  callback::add_callback(#"hash_6efb8cec1ca372dc", &function_ac5215a9);
  callback::add_callback(#"hash_6280ac8ed281ce3c", &function_8d1480e9);

  level thread function_d3901b82();

  level thread devgui_loop();
}

function private on_player_connect() {
  if(!isbot(self)) {
    return;
  }

  self thread add_bot_devgui_menu();
}

function private on_player_disconnect() {
  if(isDefined(self.bot)) {
    self thread clear_bot_devgui_menu();
  }
}

function private on_player_spawned() {
  if(!isbot(self)) {
    return;
  }

  if(getdvarint(#"bots_invulnerable", 0)) {
    self val::set(#"devgui", "takedamage", 0);
  }

  self function_78a14db2();
}

function private function_ac5215a9() {
  self thread add_bot_devgui_menu();
}

function private function_8d1480e9() {
  self thread clear_bot_devgui_menu();
}

function private function_40dbe923(dvarstr) {
  args = strtok(dvarstr, " ");
  host = util::gethostplayerforbots();

  switch (args[0]) {
    case # "spawn_enemy":
      level function_5aef57f5(host, #"enemy");
      break;
    case # "spawn_friendly":
      level function_5aef57f5(host, #"friendly");
      break;
    case # "add":
      level devgui_add_bots(host, args[1], int(args[2]));
      break;
    case # "remove":
      level devgui_remove_bots(host, args[1]);
      break;
    case # "kill":
      level devgui_kill_bots(host, args[1]);
      break;
    case # "invulnerable":
      level devgui_invulnerable(host, args[1], args[2]);
      break;
    case # "ignoreall":
      level devgui_ignoreall(host, args[1], int(args[2]));
      break;
    case # "force_press_button":
      level devgui_force_button(host, args[1], int(args[2]), 0);
      break;
    case # "force_toggle_button":
      level devgui_force_button(host, args[1], int(args[2]), 1);
      break;
    case # "clear_forced_buttons":
      level function_baee1142(host, args[1]);
      break;
    case # "force_offhand_primary":
      level function_8bb94cab(host, args[1], #"offhand", #"lethal grenade");
      break;
    case # "force_offhand_secondary":
      level function_8bb94cab(host, args[1], #"offhand", #"tactical grenade");
      break;
    case # "force_offhand_special":
      level function_8bb94cab(host, args[1], "ability", #"special");
      break;
    case # "force_scorestreak":
      level function_9a65e59a(host, args[1]);
      break;
    case # "tpose":
      level devgui_tpose(host, args[1]);
      break;
  }

  if(isDefined(host)) {
    switch (args[0]) {
      case # "add_fixed_spawn":
        host devgui_add_fixed_spawn_bots(args[1], args[2], args[3]);
        break;
      case # "hash_218217dc7d667f07":
        host function_57d0759d(args[1], undefined, args[2], (float(args[3]), float(args[4]), float(args[5])), float(args[6]));
        break;
      case # "set_target":
        host devgui_set_target(args[1], args[2]);
        break;
      case # "goal":
        host devgui_goal(args[1], args[2]);
        break;
      case # "force_aim_copy":
        host function_30f27f9f(args[1]);
        break;
      case # "force_aim_freeze":
        host function_b037d12d(args[1]);
        break;
      case # "force_aim_clear":
        host function_f419ffae(args[1]);
        break;
      case # "give_player_weapon":
        host function_263ca697();
        break;
      case # "warp":
        host function_fbdf36c1(args[1]);
        break;
    }
  }

  level notify(#"devgui_bot", {
    #host: host, #args: args
  });
}

function private devgui_loop() {
  while(true) {
    waitframe(1);
    dvarstr = getdvarstring(#"devgui_bot", "");

    if(dvarstr == "") {
      continue;
    }

    println(dvarstr);
    setDvar(#"devgui_bot", "");
    self thread function_40dbe923(dvarstr);
  }
}

function private function_9a819607(host, botarg) {
  if(strisnumber(botarg)) {
    ent = getentbynum(int(botarg));

    if(isbot(ent)) {
      return [ent];
    }

    return [];
  }

  if(botarg == "all") {
    return get_bots();
  }

  if(isDefined(level.teams[botarg])) {
    return function_a0f5b7f5(level.teams[botarg]);
  }

  if(isDefined(host)) {
    if(botarg == "friendly") {
      return host get_friendly_bots();
    }

    if(botarg == "enemy") {
      return host get_enemy_bots();
    }
  }

  if(botarg == "friendly") {
    return function_a0f5b7f5(#"allies");
  } else if(botarg == "enemy") {
    return function_a0f5b7f5(#"axis");
  }

  return [];
}

function get_bots() {
  players = getplayers();
  bots = [];

  foreach(player in players) {
    if(isbot(player)) {
      bots[bots.size] = player;
    }
  }

  return bots;
}

function get_friendly_bots() {
  players = getplayers(self.team);
  bots = [];

  foreach(player in players) {
    if(!isbot(player)) {
      continue;
    }

    bots[bots.size] = player;
  }

  return bots;
}

function get_enemy_bots() {
  players = getplayers();
  bots = [];

  foreach(player in players) {
    if(!isbot(player)) {
      continue;
    }

    if(util::function_fbce7263(player.team, self.team)) {
      bots[bots.size] = player;
    }
  }

  return bots;
}

function function_a0f5b7f5(team) {
  players = getplayers(team);
  bots = [];

  foreach(player in players) {
    if(!isbot(player)) {
      continue;
    }

    bots[bots.size] = player;
  }

  return bots;
}

function private function_d3901b82() {
  level endon(#"game_ended");
  sessionmode = currentsessionmode();

  if(sessionmode != 4) {
    var_48c9cde3 = getallcharacterbodies(sessionmode);

    foreach(index in var_48c9cde3) {
      if(index == 0) {
        continue;
      }

      displayname = makelocalizedstring(getcharacterdisplayname(index, sessionmode));
      assetname = function_9e72a96(function_ac0419ac(index, sessionmode));
      name = displayname + "<dev string:x38>" + assetname + "<dev string:x3e>";
      cmd = "<dev string:x43>" + name + "<dev string:x78>" + index + "<dev string:x7d>" + index + "<dev string:xac>";
      util::add_debug_command(cmd);
      cmd = "<dev string:xb1>" + name + "<dev string:x78>" + index + "<dev string:xe3>" + index + "<dev string:xac>";
      util::add_debug_command(cmd);
    }
  }
}

function private add_bot_devgui_menu() {
  self endon(#"disconnect");
  entnum = self getentitynumber();

  if(entnum >= 16) {
    return;
  }

  i = 0;
  self add_bot_devgui_cmd(entnum, "Ignore All:" + i + "/On", 0, "ignoreall", "1");
  self add_bot_devgui_cmd(entnum, "Ignore All:" + i + "/Off", 1, "ignoreall", "0");
  i++;
  self add_bot_devgui_cmd(entnum, "Set Target:" + i + "/From Crosshair", 0, "set_target", "crosshair");
  self add_bot_devgui_cmd(entnum, "Set Target:" + i + "/Attack Me", 1, "set_target", "me");
  self add_bot_devgui_cmd(entnum, "Set Target:" + i + "/Clear", 2, "set_target", "clear");
  i++;
  self add_bot_devgui_cmd(entnum, "Set Goal:" + i + "/Force", 0, "goal", "force");
  self add_bot_devgui_cmd(entnum, "Set Goal:" + i + "/Add Forced", 1, "goal", "add_forced");
  self add_bot_devgui_cmd(entnum, "Set Goal:" + i + "/Clear Forced", 2, "goal", "clear");
  self add_bot_devgui_cmd(entnum, "Set Goal:" + i + "/Radius", 3, "goal", "set");
  self add_bot_devgui_cmd(entnum, "Set Goal:" + i + "/Region", 4, "goal", "set_region");
  self add_bot_devgui_cmd(entnum, "Set Goal:" + i + "/Follow Me", 5, "goal", "me");
  i++;
  i++;

  if(!is_true(level.var_fa5cacde)) {
    self function_ade411a3(entnum, i);
    i++;
    self add_bot_devgui_cmd(entnum, "Force Aim:" + i + "/Copy Me", 0, "force_aim_copy");
    self add_bot_devgui_cmd(entnum, "Force Aim:" + i + "/Freeze ", 1, "force_aim_freeze");
    self add_bot_devgui_cmd(entnum, "Force Aim:" + i + "/Clear ", 2, "force_aim_clear");
    i++;
    self add_bot_devgui_cmd(entnum, "Force Use:" + i + "/Lethal", 0, "force_offhand_primary");
    self add_bot_devgui_cmd(entnum, "Force Use:" + i + "/Tactical", 1, "force_offhand_secondary");
    self add_bot_devgui_cmd(entnum, "Force Use:" + i + "/Field Upgrade", 2, "force_offhand_special");
    self add_bot_devgui_cmd(entnum, "Force Use:" + i + "/Inventory Scorestreak", 3, "force_scorestreak");
    i++;
  }

  self add_bot_devgui_cmd(entnum, "Invulnerable:" + i + "/On", 0, "invulnerable", "on");
  self add_bot_devgui_cmd(entnum, "Invulnerable:" + i + "/Off", 1, "invulnerable", "off");
  i++;
  self add_bot_devgui_cmd(entnum, "Warp to Crosshair", i, "warp");
  i++;
  self add_bot_devgui_cmd(entnum, "T-Pose", i, "tpose");
  i++;
  self add_bot_devgui_cmd(entnum, "Kill", i, "kill");
  i++;
  self add_bot_devgui_cmd(entnum, "Remove", i, "remove");
  i++;
}

function private add_bot_devgui_cmd(entnum, path, sortkey, devguiarg, cmdargs = "") {
  cmd = "devgui_cmd \"Bots/" + entnum + " " + self.name + ":" + entnum + "/" + path + ":" + sortkey + "\" \"set devgui_bot " + devguiarg + " " + entnum + " " + cmdargs + "\"";
  util::add_debug_command(cmd);
}

function private function_f105dc20(entnum, var_eeb5e4bd, buttonmenu, var_1e443b4, buttonbit) {
  self add_bot_devgui_cmd(entnum, "Force Button:" + var_eeb5e4bd + "/" + buttonmenu + ":" + var_1e443b4 + "/Press", 0, "force_press_button", buttonbit);
  self add_bot_devgui_cmd(entnum, "Force Button:" + var_eeb5e4bd + "/" + buttonmenu + ":" + var_1e443b4 + "/Toggle", 1, "force_toggle_button", buttonbit);
}

function private function_ade411a3(entnum, var_eeb5e4bd) {
  i = 0;
  self function_f105dc20(entnum, var_eeb5e4bd, "Fire", i, 0);
  i++;
  self function_f105dc20(entnum, var_eeb5e4bd, "Sprint", i, 1);
  i++;
  self function_f105dc20(entnum, var_eeb5e4bd, "ADS", i, 11);
  i++;
  self function_f105dc20(entnum, var_eeb5e4bd, "Jump", i, 10);
  i++;
  self function_f105dc20(entnum, var_eeb5e4bd, "Change Seat", i, 28);
  i++;
  self function_f105dc20(entnum, var_eeb5e4bd, "Reload", i, 4);
  i++;
  self function_f105dc20(entnum, var_eeb5e4bd, "Activate", i, 3);
  i++;
  self function_f105dc20(entnum, var_eeb5e4bd, "Use | Reload", i, 5);
  i++;
  self function_f105dc20(entnum, var_eeb5e4bd, "Melee", i, 2);
  i++;
  self function_f105dc20(entnum, var_eeb5e4bd, "Offhand Secondary", i, 15);
  i++;
  self function_f105dc20(entnum, var_eeb5e4bd, "Vehicle Fire", i, 34);
  i++;
  self function_f105dc20(entnum, var_eeb5e4bd, "Vehicle Fire 2", i, 35);
  i++;
  self function_f105dc20(entnum, var_eeb5e4bd, "Increment ADS Zoom Select", i, 31);
  i++;
  self function_f105dc20(entnum, var_eeb5e4bd, "Increment ADS Zoom Smooth", i, 32);
  i++;
  self function_f105dc20(entnum, var_eeb5e4bd, "Decrement ADS Zoom Smooth", i, 33);
  i++;
  self add_bot_devgui_cmd(entnum, "Force Button:" + var_eeb5e4bd + "/Clear All", 500, "clear_forced_buttons");
}

function clear_bot_devgui_menu() {
  entnum = self getentitynumber();

  if(entnum >= 16) {
    return;
  }

  cmd = "devgui_remove \"Bots/" + entnum + " " + self.name + "\"";
  util::add_debug_command(cmd);
}

function private devgui_add_bots(host, botarg, count) {
  team = function_881d3aa(host, botarg);

  if(!isDefined(team)) {
    return;
  }

  players = getplayers(team);
  max_players = player::function_d36b6597();

  if(players.size < max_players || max_players == 0) {
    level thread bot::add_bots(count, team);
  }
}

function private function_5aef57f5(host, botarg) {
  level endon(#"game_ended");
  team = function_881d3aa(host, botarg);

  if(!isDefined(team)) {
    return;
  }

  bot = bot::add_bot(team);
  bot.ignoreall = 1;
  bot.bot.var_261b9ab3 = 1;
}

function private devgui_add_fixed_spawn_bots(botarg, var_b27e53da, countarg) {
  team = function_881d3aa(self, botarg);

  if(!isDefined(team)) {
    return;
  }

  if(!isDefined(countarg)) {
    countarg = 1;
  }

  var_c6e7a9ca = max(int(countarg), 1);
  count = var_c6e7a9ca;
  players = getplayers(team);
  max_players = player::function_d36b6597();

  if(max_players > 0) {
    count = min(count, max_players - players.size);
  }

  if(count <= 0) {
    return;
  }

  if(!isDefined(var_b27e53da)) {
    var_b27e53da = -1;
  }

  roleindex = int(var_b27e53da);
  trace = self eye_trace(0, 1);
  spawndir = self.origin - trace[# "position"];
  spawnangles = vectortoangles(spawndir);
  offset = (0, 0, 5);
  origin = trace[# "position"] + offset;
  bots = function_bd48ef10(team, count, origin, spawnangles[1], roleindex);
  vehicle = trace[# "entity"];

  if(isvehicle(vehicle)) {
    pos = trace[# "position"];
    seatindex = vehicle function_eee09f16(pos);

    if(isDefined(seatindex)) {
      foreach(bot in bots) {
        bot bot::function_bcc79b86(vehicle, seatindex);
      }
    }
  }

  println("<dev string:x10f>" + botarg + "<dev string:x133>" + var_c6e7a9ca + "<dev string:x133>" + origin[0] + "<dev string:x133>" + origin[1] + "<dev string:x133>" + origin[2] + "<dev string:x133>" + spawnangles[1]);
}

function private function_57d0759d(botarg, var_b27e53da, countarg, origin, angle) {
  team = function_881d3aa(self, botarg);

  if(!isDefined(team)) {
    return;
  }

  if(!isDefined(countarg)) {
    countarg = 1;
  }

  count = max(int(countarg), 1);
  players = getplayers(team);
  max_players = player::function_d36b6597();

  if(max_players > 0) {
    count = min(count, max_players - players.size);
  }

  if(count <= 0) {
    return;
  }

  if(!isDefined(var_b27e53da)) {
    var_b27e53da = -1;
  }

  roleindex = int(var_b27e53da);
  offset = (0, 0, 5);
  origin += offset;
  bots = function_bd48ef10(team, count, origin, angle, roleindex);
}

function private function_bd48ef10(team, count, origin, yaw, roleindex) {
  bots = [];

  if(!isDefined(bots)) {
    bots = [];
  } else if(!isarray(bots)) {
    bots = array(bots);
  }

  bots[bots.size] = self bot::add_fixed_spawn_bot(team, origin, yaw, roleindex);

  spiral = dev::function_a4ccb933(origin, yaw);

  for(i = 0; i < count - 1; i++) {
    dev::function_df0b6f84(spiral);
    origin = dev::function_98c05766(spiral);
    angle = dev::function_4783f10c(spiral);

    if(!isDefined(bots)) {
      bots = [];
    } else if(!isarray(bots)) {
      bots = array(bots);
    }

    bots[bots.size] = self bot::add_fixed_spawn_bot(team, origin, angle, roleindex);
  }

  return bots;
}

function private function_881d3aa(host, botarg) {
  if(botarg == "all") {
    return # "none";
  }

  if(isDefined(level.teams[botarg])) {
    return level.teams[botarg];
  }

  friendlyteam = # "allies";

  if(isDefined(host) && host.team != # "spectator") {
    friendlyteam = host.team;
  }

  if(botarg == "friendly") {
    return friendlyteam;
  }

  return function_8dbb49c0(friendlyteam);
}

function private function_8dbb49c0(ignoreteam) {
  assert(isDefined(ignoreteam));
  maxteamplayers = player::function_d36b6597();

  foreach(team, _ in level.teams) {
    if(team == ignoreteam) {
      continue;
    }

    players = getplayers(team);

    if(maxteamplayers > 0 && players.size < maxteamplayers) {
      return team;
    }
  }

  return undefined;
}

function private devgui_remove_bots(host, botarg) {
  bots = function_9a819607(host, botarg);

  foreach(bot in bots) {
    level thread bot::remove_bot(bot);
  }
}

function private devgui_ignoreall(host, botarg, cmdarg) {
  bots = function_9a819607(host, botarg);

  foreach(bot in bots) {
    bot.ignoreall = cmdarg;
  }
}

function private devgui_set_target(botarg, cmdarg) {
  target = undefined;

  switch (cmdarg) {
    case # "crosshair":
      target = self function_59842621();
      break;
    case # "me":
      target = self;
      break;
    case # "clear":
      break;
    default:
      return;
  }

  bots = function_9a819607(self, botarg);

  foreach(bot in bots) {
    if(isDefined(target)) {
      if(target != bot) {
        bot setentitytarget(target);
        bot getperfectinfo(target, 1);
      }

      continue;
    }

    bot clearentitytarget();
  }
}

function private devgui_goal(botarg, cmdarg) {
  switch (cmdarg) {
    case # "set":
      self set_goal(botarg, 0);
      return;
    case # "set_region":
      self function_417ef9e7(botarg);
      return;
    case # "force":
      self set_goal(botarg, 1);
      return;
    case # "add_forced":
      self function_93996ae6(botarg);
      return;
    case # "me":
      self set_goal_ent(botarg, self);
      return;
    case # "clear":
      self function_be8f790e(botarg);
      return;
  }
}

function private set_goal(botarg, force = 0) {
  trace = self eye_trace(1);
  pos = trace[# "position"];

  if(force) {
    pos = getclosestpointonnavmesh(pos, 16, 16);

    if(!isDefined(pos)) {
      return;
    }
  }

  bots = function_9a819607(self, botarg);
  vehicle = isvehicle(trace[# "entity"]) ? trace[# "entity"] : undefined;

  foreach(bot in bots) {
    bot notify(#"hash_7597caa242064632");
    bot botreleasemanualcontrol();
    bot setgoal(pos, force);
    bot.goalradius = 512;

    if(bot isinvehicle()) {
      currentvehicle = bot getvehicleoccupied();

      if(vehicle === currentvehicle) {
        seatindex = vehicle function_d1409e38(pos);

        if(!vehicle isvehicleseatoccupied(seatindex)) {
          vehicle function_1090ca(bot, seatindex);
        }
      } else {
        var_c3eee21b = currentvehicle getoccupantseat(bot);
        currentvehicle usevehicle(bot, var_c3eee21b);
      }

      continue;
    }

    if(isDefined(vehicle)) {
      seatindex = vehicle function_eee09f16(pos);

      if(isDefined(seatindex)) {
        vehicle usevehicle(bot, seatindex);
      }
    }
  }
}

function private function_417ef9e7(botarg) {
  trace = self eye_trace(1);
  bots = function_9a819607(self, botarg);
  pos = trace[# "position"];
  point = getclosesttacpoint(pos);

  if(!isDefined(point)) {
    return;
  }

  foreach(bot in bots) {
    bot notify(#"hash_7597caa242064632");
    bot botreleasemanualcontrol();
    bot setgoal(point.region);
  }
}

function private set_goal_ent(botarg, ent) {
  bots = function_9a819607(self, botarg);

  foreach(bot in bots) {
    bot notify(#"hash_7597caa242064632");
    bot botreleasemanualcontrol();
    bot setgoal(ent);
    bot.goalradius = 96;

    if(bot isinvehicle()) {
      vehicle = bot getvehicleoccupied();
      seatindex = vehicle getoccupantseat(bot);
      vehicle usevehicle(bot, seatindex);
    }
  }
}

function private function_be8f790e(botarg) {
  bots = function_9a819607(self, botarg);

  foreach(bot in bots) {
    bot notify(#"hash_7597caa242064632");
    bot clearforcedgoal();
  }
}

function private function_93996ae6(botarg) {
  trace = self eye_trace(1);
  pos = trace[# "position"];
  pos = getclosestpointonnavmesh(pos, 16, 16);

  if(!isDefined(pos)) {
    return;
  }

  bots = function_9a819607(self, botarg);

  foreach(bot in bots) {
    bot botreleasemanualcontrol();
    goals = bot.bot.var_bdb21e1f;

    if(isDefined(goals)) {
      goals[goals.size] = pos;
      continue;
    }

    goals = [];
    bot.bot.var_bdb21e1f = goals;
    info = bot function_4794d6a3();

    if(info.goalforced) {
      goals[goals.size] = info.goalpos;
    }

    goals[goals.size] = pos;
    bot function_cc8c642a(goals);
  }
}

function private function_cc8c642a(&goals) {
  self endoncallback(&function_bc3bbe26, #"death", #"hash_7597caa242064632");

  for(i = 0; true; i = (i + 1) % goals.size) {
    self setgoal(goals[i], 1);

    while(goals.size <= 1) {
      waitframe(1);
    }

    self waittill(#"goal");
  }
}

function private function_bc3bbe26(notifyhash) {
  self.bot.var_bdb21e1f = undefined;
}

function private devgui_force_button(host, botarg, cmdarg, toggle) {
  bots = function_9a819607(host, botarg);

  foreach(bot in bots) {
    if(!isDefined(bot.bot.var_458ddbc0)) {
      bot.bot.var_458ddbc0 = [];
    }

    forcebits = bot.bot.var_458ddbc0;

    if(toggle) {
      forcebits[cmdarg] = is_true(forcebits[cmdarg]) ? undefined : 1;
      continue;
    }

    forcebits[cmdarg] = 2;
  }
}

function private function_baee1142(host, botarg) {
  bots = function_9a819607(host, botarg);

  foreach(bot in bots) {
    bot.bot.var_458ddbc0 = [];
  }
}

function private function_8bb94cab(host, botarg, inventorytype, offhandslot) {
  bots = function_9a819607(host, botarg);

  foreach(bot in bots) {
    weapon = bot function_b24b9a1e(inventorytype, offhandslot);

    if(isDefined(weapon)) {
      bot givemaxammo(weapon);
      bot bot_action::function_d6318084(weapon);
      bot bot_action::function_32020adf(3);
    }
  }
}

function private function_b24b9a1e(inventorytype, offhandslot) {
  weapons = self getweaponslist();

  foreach(weapon in weapons) {
    if(weapon.inventorytype == inventorytype && weapon.offhandslot == offhandslot) {
      return weapon;
    }
  }

  return undefined;
}

function private function_9a65e59a(host, botarg) {
  bots = function_9a819607(host, botarg);

  foreach(bot in bots) {
    weapon = bot function_ef14f060();

    if(isDefined(weapon)) {
      bot bot_action::function_d6318084(weapon);
      bot bot_action::function_32020adf(3);
    }
  }
}

function private function_ef14f060() {
  weapons = self getweaponslist();

  foreach(weapon in weapons) {
    if(weapon.inventorytype != # "item" || self getweaponammoclip(weapon) <= 0) {
      continue;
    }

    foreach(name in self.killstreak) {
      if(weapon.name == name) {}
    }

    foreach(killstreak in level.killstreaks) {
      if(killstreak.weapon == weapon) {
        return weapon;
      }
    }
  }

  return undefined;
}

function private function_fbdf36c1(botarg) {
  bots = function_9a819607(self, botarg);
  yaw = absangleclamp360(self.angles[1] + 180);
  angle = (0, yaw, 0);
  trace = self eye_trace(1, 1);
  pos = trace[# "position"];

  foreach(bot in bots) {
    bot dontinterpolate();
    bot setplayerangles(angle);
    bot setorigin(pos);

    if(bot function_4794d6a3().goalforced) {
      bot setgoal(pos, 1);
    }
  }
}

function private function_30f27f9f(botarg) {
  bots = function_9a819607(self, botarg);

  foreach(bot in bots) {
    bot thread function_2e08087e(self);
  }
}

function private function_b037d12d(botarg) {
  bots = function_9a819607(self, botarg);

  foreach(bot in bots) {
    bot notify(#"hash_1fc88ab5756d805");
    bot.bot.var_5efe88e4 = bot getplayerangles();
  }
}

function private function_f419ffae(botarg) {
  bots = function_9a819607(self, botarg);

  foreach(bot in bots) {
    bot notify(#"hash_1fc88ab5756d805");
    bot.bot.var_5efe88e4 = undefined;
  }
}

function private function_2e08087e(player) {
  self endon(#"death", #"disconnect", #"hash_1fc88ab5756d805", #"hash_6280ac8ed281ce3c");

  while(isDefined(player) && isalive(player)) {
    angles = player getplayerangles();
    yawoffset = getdvarint(#"hash_68c18f3309126669", 0) * 15;
    var_6cd5d6b6 = angles + (0, yawoffset, 0);
    self.bot.var_5efe88e4 = angleclamp180(var_6cd5d6b6);
    waitframe(1);
  }

  self.bot.var_5efe88e4 = undefined;
}

function devgui_tpose(host, botarg) {
  bots = function_9a819607(host, botarg);

  foreach(bot in bots) {
    setDvar(#"bg_boastenabled", 1);
    bot playboast("dev_boast_tpose");
  }
}

function private devgui_invulnerable(host, botarg, cmdarg) {
  bots = function_9a819607(host, botarg);

  foreach(bot in bots) {
    if(cmdarg == "on") {
      bot val::set(#"devgui", "takedamage", 0);
      continue;
    }

    bot val::reset(#"devgui", "takedamage");
  }
}

function private devgui_kill_bots(host, botarg) {
  bots = function_9a819607(host, botarg);

  foreach(bot in bots) {
    if(!isalive(bot)) {
      continue;
    }

    bot val::set(#"devgui_kill", "takedamage", 1);
    bot dodamage(bot.health + 1000, bot.origin);
    bot val::reset(#"devgui_kill", "takedamage");
  }
}

function private function_263ca697() {
  weapon = self getcurrentweapon();
  weaponoptions = self function_ade49959(weapon);
  var_e91aba42 = self function_8cbd254d(weapon);

  setDvar(#"bot_spawn_weapon", getweaponname(weapon.rootweapon));
  setDvar(#"hash_c6e51858c88a5ee", util::function_2146bd83(weapon));

  bots = get_bots();

  foreach(bot in bots) {
    bot function_35e77034(weapon, weaponoptions, var_e91aba42);
  }
}

function private function_78a14db2() {
  weapon = undefined;

  if(getdvarstring(#"bot_spawn_weapon", "") != "") {
    weapon = util::get_weapon_by_name(getdvarstring(#"bot_spawn_weapon"), getdvarstring(#"hash_c6e51858c88a5ee"));

    if(isDefined(weapon)) {
      self function_35e77034(weapon);
    }
  }
}

function private function_35e77034(weapon, weaponoptions, var_e91aba42) {
  if(!isDefined(weapon) || weapon == level.weaponnone) {
    return;
  }

  self function_85e7342b();
  self giveweapon(weapon, weaponoptions, var_e91aba42);
  self givemaxammo(weapon);
  self switchtoweaponimmediate(weapon);
  self setspawnweapon(weapon);
}

function private function_85e7342b() {
  weapons = self getweaponslistprimaries();

  foreach(weapon in weapons) {
    self takeweapon(weapon);
  }
}

function private eye_trace(hitents = 0, var_18daeece = 0) {
  angles = self getplayerangles();
  fwd = anglesToForward(angles);
  var_98b02a87 = self getplayerviewheight();
  eye = self.origin + (0, 0, var_98b02a87);
  end = eye + fwd * 8000;
  return bulletTrace(eye, end, hitents, self, var_18daeece);
}

function private function_59842621() {
  trace = self eye_trace(1);
  targetentity = trace[# "entity"];
  return targetentity;
}

function private function_eee09f16(pos) {
  seatindex = undefined;
  seatdist = undefined;

  for(i = 0; i < 11; i++) {
    if(self function_dcef0ba1(i)) {
      var_3693c73b = self function_defc91b2(i);

      if(isDefined(var_3693c73b) && var_3693c73b >= 0 && !self isvehicleseatoccupied(i)) {
        dist = distance(pos, self function_5051cc0c(i));

        if(!isDefined(seatindex) || seatdist > dist) {
          seatindex = i;
          seatdist = dist;
        }
      }
    }
  }

  return seatindex;
}

function private function_d1409e38(pos) {
  seatindex = undefined;
  seatdist = undefined;

  for(i = 0; i < 11; i++) {
    if(self function_dcef0ba1(i)) {
      var_3693c73b = self function_defc91b2(i);

      if(isDefined(var_3693c73b) && var_3693c73b >= 0) {
        dist = distance(pos, self function_5051cc0c(i));

        if(!isDefined(seatindex) || seatdist > dist) {
          seatindex = i;
          seatdist = dist;
        }
      }
    }
  }

  return seatindex;
}