/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\bots\_bot.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\bots\_bot_ball;
#using scripts\mp\bots\_bot_clean;
#using scripts\mp\bots\_bot_combat;
#using scripts\mp\bots\_bot_conf;
#using scripts\mp\bots\_bot_ctf;
#using scripts\mp\bots\_bot_dem;
#using scripts\mp\bots\_bot_dom;
#using scripts\mp\bots\_bot_escort;
#using scripts\mp\bots\_bot_hq;
#using scripts\mp\bots\_bot_koth;
#using scripts\mp\bots\_bot_loadout;
#using scripts\mp\bots\_bot_sd;
#using scripts\mp\killstreaks\_emp;
#using scripts\mp\killstreaks\_killstreakrules;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_satellite;
#using scripts\mp\killstreaks\_uav;
#using scripts\mp\teams\_teams;
#using scripts\shared\array_shared;
#using scripts\shared\bots\_bot;
#using scripts\shared\bots\_bot_combat;
#using scripts\shared\bots\bot_buttons;
#using scripts\shared\bots\bot_traversals;
#using scripts\shared\callbacks_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\math_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weapons;
#using scripts\shared\weapons_shared;
#namespace bot;

function autoexec __init__sytem__() {
  system::register("bot_mp", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype( & init);
  level.getbotsettings = & get_bot_settings;
  level.onbotconnect = & on_bot_connect;
  level.onbotspawned = & on_bot_spawned;
  level.onbotkilled = & on_bot_killed;
  level.botidle = & bot_idle;
  level.botthreatlost = & bot_combat::chase_threat;
  level.botprecombat = & bot_combat::mp_pre_combat;
  level.botcombat = & bot_combat::combat_think;
  level.botpostcombat = & bot_combat::mp_post_combat;
  level.botignorethreat = & bot_combat::bot_ignore_threat;
  level.enemyempactive = & emp::enemyempactive;
  level.botdevguicmd = & function_682f20bc;
  level thread system_devgui_gadget_think();
}

function init() {
  level endon("game_ended");
  level.botsoak = is_bot_soak();
  if(level.rankedmatch && !level.botsoak || !init_bot_gametype()) {
    return;
  }
  wait_for_host();
  level thread populate_bots();
}

function is_bot_soak() {
  return getdvarint("", 0);
}

function wait_for_host() {
  level endon("game_ended");
  if(level.botsoak) {
    return;
  }
  host = util::gethostplayerforbots();
  while(!isDefined(host)) {
    wait(0.25);
    host = util::gethostplayerforbots();
  }
}

function get_host_team() {
  host = util::gethostplayerforbots();
  if(!isDefined(host) || host.team == "spectator") {
    return "allies";
  }
  return host.team;
}

function is_bot_comp_stomp() {
  return false;
}

function on_bot_connect() {
  self endon("disconnect");
  level endon("game_ended");
  if(isDefined(level.disableclassselection) && level.disableclassselection) {
    self set_rank();
    self bot_loadout::pick_hero_gadget();
    self bot_loadout::pick_killstreaks();
    return;
  }
  if(!(isDefined(self.pers["bot_loadout"]) && self.pers["bot_loadout"])) {
    self set_rank();
    self bot_loadout::build_classes();
    self bot_loadout::pick_hero_gadget();
    self bot_loadout::pick_killstreaks();
    self.pers["bot_loadout"] = 1;
  }
  self bot_loadout::pick_classes();
  self choose_class();
}

function on_bot_spawned() {
  self.bot.goaltag = undefined;
  weapon = undefined;
  if(getdvarint("") != 0) {
    player = util::gethostplayer();
    weapon = player getcurrentweapon();
  }
  if(getdvarstring("", "") != "") {
    weapon = getweapon(getdvarstring(""));
  }
  if(isDefined(weapon) && level.weaponnone != weapon) {
    self weapons::detach_all_weapons();
    self takeallweapons();
    self giveweapon(weapon);
    self switchtoweapon(weapon);
    self setspawnweapon(weapon);
    self teams::set_player_model(self.team, weapon);
  }
}

function on_bot_killed() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("spawned");
  self waittill("death_delay_finished");
  wait(0.1);
  if(self choose_class() && level.playerforcerespawn) {
    return;
  }
  self thread respawn();
}

function respawn() {
  self endon("spawned");
  self endon("disconnect");
  level endon("game_ended");
  while(true) {
    self tap_use_button();
    wait(0.1);
  }
}

function bot_idle() {
  if(self do_supplydrop()) {
    return;
  }
  self navmesh_wander();
  self sprint_to_goal();
}

function do_supplydrop(maxrange = 1400) {
  crates = getEntArray("care_package", "script_noteworthy");
  maxrangesq = maxrange * maxrange;
  useradiussq = 3844;
  closestcrate = undefined;
  closestcratedistsq = undefined;
  foreach(crate in crates) {
    if(!crate isonground()) {
      continue;
    }
    cratedistsq = distance2dsquared(self.origin, crate.origin);
    if(cratedistsq > maxrangesq) {
      continue;
    }
    inuse = isDefined(crate.useent) && (isDefined(crate.useent.inuse) && crate.useent.inuse);
    if(cratedistsq <= useradiussq) {
      if(inuse && !self usebuttonpressed()) {
        continue;
      }
      self press_use_button();
      return true;
    }
    if(!self has_minimap() && !self botsighttracepassed(crate)) {
      continue;
    }
    if(!isDefined(closestcrate) || cratedistsq < closestcratedistsq) {
      closestcrate = crate;
      closestcratedistsq = cratedistsq;
    }
  }
  if(isDefined(closestcrate)) {
    randomangle = (0, randomint(360), 0);
    randomvec = anglesToForward(randomangle);
    point = closestcrate.origin + (randomvec * 39);
    if(self botsetgoal(point)) {
      self thread watch_crate(closestcrate);
      return true;
    }
  }
  return false;
}

function watch_crate(crate) {
  self endon("death");
  self endon("bot_goal_reached");
  level endon("game_ended");
  while(isDefined(crate) && !self bot_combat::has_threat()) {
    wait(level.botsettings.thinkinterval);
  }
  self botsetgoal(self.origin);
}

function populate_bots() {
  level endon("game_ended");
  if(level.teambased) {
    maxallies = getdvarint("bot_maxAllies", 0);
    maxaxis = getdvarint("bot_maxAxis", 0);
    level thread monitor_bot_team_population(maxallies, maxaxis);
  } else {
    maxfree = getdvarint("bot_maxFree", 0);
    level thread monitor_bot_population(maxfree);
  }
}

function monitor_bot_team_population(maxallies, maxaxis) {
  level endon("game_ended");
  if(!maxallies && !maxaxis) {
    return;
  }
  fill_balanced_teams(maxallies, maxaxis);
  while(true) {
    wait(3);
    allies = getplayers("allies");
    axis = getplayers("axis");
    if(allies.size > maxallies && remove_best_bot(allies)) {
      continue;
    }
    if(axis.size > maxaxis && remove_best_bot(axis)) {
      continue;
    }
    if(allies.size < maxallies || axis.size < maxaxis) {
      add_balanced_bot(allies, maxallies, axis, maxaxis);
    }
  }
}

function fill_balanced_teams(maxallies, maxaxis) {
  allies = getplayers("allies");
  axis = getplayers("axis");
  while(allies.size < maxallies || axis.size < maxaxis && add_balanced_bot(allies, maxallies, axis, maxaxis)) {
    wait(0.05);
    allies = getplayers("allies");
    axis = getplayers("axis");
  }
}

function add_balanced_bot(allies, maxallies, axis, maxaxis) {
  bot = undefined;
  if(allies.size < maxallies && (allies.size <= axis.size || axis.size >= maxaxis)) {
    bot = add_bot("allies");
  } else if(axis.size < maxaxis) {
    bot = add_bot("axis");
  }
  return isDefined(bot);
}

function monitor_bot_population(maxfree) {
  level endon("game_ended");
  if(!maxfree) {
    return;
  }
  players = getplayers();
  while(players.size < maxfree) {
    add_bot();
    wait(0.05);
    players = getplayers();
  }
  while(true) {
    wait(3);
    players = getplayers();
    if(players.size < maxfree) {
      add_bot();
    } else if(players.size > maxfree) {
      remove_best_bot(players);
    }
  }
}

function remove_best_bot(players) {
  bots = filter_bots(players);
  if(!bots.size) {
    return false;
  }
  bestbots = [];
  foreach(bot in bots) {
    if(bot.sessionstate == "spectator") {
      continue;
    }
    if(bot.sessionstate == "dead" || !bot bot_combat::has_threat()) {
      bestbots[bestbots.size] = bot;
    }
  }
  if(bestbots.size) {
    remove_bot(bestbots[randomint(bestbots.size)]);
  } else {
    remove_bot(bots[randomint(bots.size)]);
  }
  return true;
}

function choose_class() {
  if(isDefined(level.disableclassselection) && level.disableclassselection) {
    return false;
  }
  currclass = self bot_loadout::get_current_class();
  if(!isDefined(currclass) || randomint(100) < (isDefined(level.botsettings.changeclassweight) ? level.botsettings.changeclassweight : 0)) {
    classindex = randomint(self.loadoutclasses.size);
    classname = self.loadoutclasses[classindex].name;
  }
  if(!isDefined(classname) || classname === currclass) {
    return false;
  }
  self notify("menuresponse", "ChooseClass_InGame", classname);
  return true;
}

function use_killstreak() {
  if(!level.loadoutkillstreaksenabled || self emp::enemyempactive()) {
    return;
  }
  weapons = self getweaponslist();
  inventoryweapon = self getinventoryweapon();
  foreach(weapon in weapons) {
    killstreak = killstreaks::get_killstreak_for_weapon(weapon);
    if(!isDefined(killstreak)) {
      continue;
    }
    if(weapon != inventoryweapon && !self getweaponammoclip(weapon)) {
      continue;
    }
    if(self killstreakrules::iskillstreakallowed(killstreak, self.team)) {
      useweapon = weapon;
      break;
    }
  }
  if(!isDefined(useweapon)) {
    return;
  }
  killstreak_ref = killstreaks::get_menu_name(killstreak);
  switch (killstreak_ref) {
    case "killstreak_counteruav":
    case "killstreak_helicopter_player_gunner":
    case "killstreak_raps":
    case "killstreak_satellite":
    case "killstreak_sentinel":
    case "killstreak_uav": {
      self switchtoweapon(useweapon);
      break;
    }
  }
}

function has_radar() {
  if(level.teambased) {
    return uav::hasuav(self.team) || satellite::hassatellite(self.team);
  }
  return uav::hasuav(self.entnum) || satellite::hassatellite(self.entnum);
}

function has_minimap() {
  if(self isempjammed()) {
    return 0;
  }
  if(isDefined(level.hardcoremode) && level.hardcoremode) {
    return self has_radar();
  }
  return 1;
}

function get_enemies(on_radar = 0) {
  enemies = self getenemies();
  for(i = 0; i < enemies.size; i++) {
    if(isplayer(enemies[i]) && enemies[i] isinmovemode("", "")) {
      arrayremoveindex(enemies, i);
      i--;
    }
  }
  if(on_radar && !self has_radar()) {
    for(i = 0; i < enemies.size; i++) {
      if(!isDefined(enemies[i].lastfiretime)) {
        arrayremoveindex(enemies, i);
        i--;
        continue;
      }
      if((gettime() - enemies[i].lastfiretime) > 2000) {
        arrayremoveindex(enemies, i);
        i--;
      }
    }
  }
  return enemies;
}

function set_rank() {
  players = getplayers();
  ranks = [];
  bot_ranks = [];
  human_ranks = [];
  for(i = 0; i < players.size; i++) {
    if(players[i] == self) {
      continue;
    }
    if(isDefined(players[i].pers["rank"])) {
      if(players[i] util::is_bot()) {
        bot_ranks[bot_ranks.size] = players[i].pers["rank"];
        continue;
      }
      human_ranks[human_ranks.size] = players[i].pers["rank"];
    }
  }
  if(!human_ranks.size) {
    human_ranks[human_ranks.size] = 10;
  }
  human_avg = math::array_average(human_ranks);
  while((bot_ranks.size + human_ranks.size) < 5) {
    r = human_avg + (randomintrange(-5, 5));
    rank = math::clamp(r, 0, level.maxrank);
    human_ranks[human_ranks.size] = rank;
  }
  ranks = arraycombine(human_ranks, bot_ranks, 1, 0);
  avg = math::array_average(ranks);
  s = math::array_std_deviation(ranks, avg);
  rank = int(math::random_normal_distribution(avg, s, 0, level.maxrank));
  while(!isDefined(self.pers["codpoints"])) {
    wait(0.1);
  }
  self.pers["rank"] = rank;
  self.pers["rankxp"] = rank::getrankinfominxp(rank);
  self setrank(rank);
  self rank::syncxpstat();
}

function init_bot_gametype() {
  switch (level.gametype) {
    case "ball": {
      bot_ball::init();
      return true;
    }
    case "conf": {
      bot_conf::init();
      return true;
    }
    case "ctf": {
      bot_ctf::init();
      return true;
    }
    case "dem": {
      bot_dem::init();
      return true;
    }
    case "dm": {
      return true;
    }
    case "dom": {
      bot_dom::init();
      return true;
    }
    case "escort": {
      namespace_ebd80b8b::init();
      return true;
    }
    case "infect": {
      return true;
    }
    case "gun": {
      return true;
    }
    case "koth": {
      bot_koth::init();
      return true;
    }
    case "sd": {
      bot_sd::init();
      return true;
    }
    case "clean": {
      bot_clean::init();
      return true;
    }
    case "tdm": {
      return true;
    }
  }
  return false;
}

function get_bot_settings() {
  switch (getdvarint("bot_difficulty", 1)) {
    case 0: {
      bundlename = "bot_mp_easy";
      break;
    }
    case 1: {
      bundlename = "bot_mp_normal";
      break;
    }
    case 2: {
      bundlename = "bot_mp_hard";
      break;
    }
    case 3:
    default: {
      bundlename = "bot_mp_veteran";
      break;
    }
  }
  return struct::get_script_bundle("botsettings", bundlename);
}

function friend_goal_in_radius(goal_name, origin, radius) {
  return false;
}

function friend_in_radius(goal_name, origin, radius) {
  return false;
}

function get_friends() {
  return [];
}

function get_closest_enemy(origin, someflag) {
  return undefined;
}

function bot_vehicle_weapon_ammo(weaponname) {
  return false;
}

function navmesh_points_visible(origin, point) {
  return false;
}

function dive_to_prone(exit_stance) {}

function function_682f20bc(cmd) {
  var_d03a6f21 = strtok(cmd, "");
  if(var_d03a6f21.size == 0) {
    return false;
  }
  host = util::gethostplayerforbots();
  team = get_host_team();
  switch (var_d03a6f21[0]) {
    case "": {
      team = util::getotherteam(team);
    }
    case "": {
      count = 1;
      if(var_d03a6f21.size > 1) {
        count = int(var_d03a6f21[1]);
      }
      for(i = 0; i < count; i++) {
        add_bot(team);
      }
      return true;
    }
    case "": {
      team = util::getotherteam(team);
    }
    case "": {
      remove_bots(undefined, team);
      return true;
    }
    case "": {
      team = util::getotherteam(team);
    }
    case "": {
      bot = add_bot_at_eye_trace(team);
      if(isDefined(bot)) {
        bot thread fixed_spawn_override();
      }
      return true;
    }
    case "": {
      players = getplayers();
      foreach(player in players) {
        if(!player util::is_bot()) {
          continue;
        }
        weapon = host getcurrentweapon();
        player weapons::detach_all_weapons();
        player takeallweapons();
        player giveweapon(weapon);
        player switchtoweapon(weapon);
        player setspawnweapon(weapon);
        player teams::set_player_model(player.team, weapon);
      }
      return true;
    }
  }
  return false;
}

function system_devgui_gadget_think() {
  setdvar("", "");
  for(;;) {
    wait(1);
    gadget = getdvarstring("");
    if(gadget != "") {
      bot_turn_on_gadget(getweapon(gadget));
      setdvar("", "");
    }
  }
}

function bot_turn_on_gadget(gadget) {
  players = getplayers();
  foreach(player in players) {
    if(!player util::is_bot()) {
      continue;
    }
    host = util::gethostplayer();
    weapon = host getcurrentweapon();
    if(!isDefined(weapon) || weapon == level.weaponnone || weapon == level.weaponnull) {
      weapon = getweapon("");
    }
    player weapons::detach_all_weapons();
    player takeallweapons();
    player giveweapon(weapon);
    player switchtoweapon(weapon);
    player setspawnweapon(weapon);
    player teams::set_player_model(player.team, weapon);
    player giveweapon(gadget);
    slot = player gadgetgetslot(gadget);
    player gadgetpowerset(slot, 100);
    player botpressbuttonforgadget(gadget);
  }
}

function fixed_spawn_override() {
  self endon("disconnect");
  spawnorigin = self.origin;
  spawnangles = self.angles;
  while(true) {
    self waittill("spawned_player");
    self setorigin(spawnorigin);
    self setplayerangles(spawnangles);
  }
}