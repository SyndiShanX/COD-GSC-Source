/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_br.gsc
************************************************/

#using script_3d2770dc09c1243;
#using script_40e63dd222434655;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\game;
#namespace bots_gametype_br;

function main() {
  if(namespace_ef54497d29a56093::function_5a60778277d6ae4b()) {
    namespace_ef54497d29a56093::initialize();
    return;
  }

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    if(isDefined(level.var_7d43ccdc62f43db3)) {
      [[level.var_7d43ccdc62f43db3]]();
    }

    return;
  }

  if(scripts\cp_mp\utility\game_utility::function_6493ec89ae923684()) {
    namespace_bc2665cbe6cf4e1f::function_5865e18adb02de38();
    [[level.var_7d43ccdc62f43db3]]();
    return;
  }

  if(scripts\mp\utility\game::getsubgametype() == "plunder" && scripts\mp\gametypes\br_public::isdmzbotpracticematch()) {
    [[level.dmz_bot_callback_func]]();
    return;
  }

  setup_callbacks();
  setup_bot_br();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  level.bot_funcs["player_spawned_gamemode"] = &function_543a0a3113ff89f7;
  level.bot_funcs["gametype_think"] = &bot_br_think;
}

function setup_bot_br() {
  setdvarifuninitialized(@ "hash_6ea9d854913f0e36", 0.25);
}

function function_543a0a3113ff89f7() {
  self botsetflag("ignore_nodes", 1);
}

function bot_br_think() {
  self notify("bot_br_think");
  self endon("bot_br_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_7da10f5ca0899c16 = randomfloat(1) < getdvarfloat(@ "hash_6ea9d854913f0e36", 0);
  thread ammo_manager();

  while(true) {
    if(getdvarint(@ "hash_c2de8ca6dc8512c1") || self.sessionstate == "<dev string:x1c>") {
      wait 0.05;
      continue;
    }

    if(scripts\mp\gametypes\br_public::isbrpracticemode() && !scripts\mp\flags::gameflag("graceperiod_done")) {
      self.ignoreall = 0;
      wait 0.05;
      continue;
    }

    if(isDefined(self.br_infil_type)) {
      if(scripts\mp\gametypes\br_public::isbrpracticemode() && !isDefined(self.infil_complete)) {
        self.ignoreall = 1;
        self botclearscriptgoal();
      }

      self botsetflag("disable_all_ai", 1);

      if((scripts\mp\gametypes\br_public::isplayerbrsquadleader() || var_7da10f5ca0899c16) && istrue(level.c130inbounds)) {
        var_4fa3d43b222d0428 = function_a4091ef2be7e55b0();
        wait var_4fa3d43b222d0428;

        if(scripts\mp\gametypes\br_public::isplayerbrsquadleader()) {
          self notify("halo_jump_c130");
        } else {
          self notify("halo_jump_solo_c130");
        }

        self.gulaguses = 1;

        if(getdvarint(@ "hash_3ff738f6200e3a65", 1) > 0) {
          self.gulaguses = 0;
        }

        self.jumped = 1;

        while(isDefined(self.br_infil_type)) {
          wait 0.05;
        }
      }

      wait 0.05;
      continue;
    }

    if(scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
      thread bot_gulag_think();
      self waittill("gulag_end");
      wait 3;
    } else {
      self botclearscriptenemy();
    }

    if(isDefined(level.br_circle) && isnavmeshloaded()) {
      script_goal = undefined;
      var_f8cd7c50ce12c857 = self bothasscriptgoal();

      if(var_f8cd7c50ce12c857) {
        script_goal = self botgetscriptgoal();
      }

      if(!bot_has_tactical_goal() && !bot_is_remote_or_linked()) {
        if((istrue(self isskydiving()) || istrue(self isparachuting())) && istrue(self.jumped) && istrue(scripts\mp\gametypes\br_public::isbrpracticemode())) {
          self botsetflag("disable_all_ai", 0);
          self botclearscriptgoal();
          bot_parachute_into_map();
        }

        if(scripts\mp\gametypes\br_public::isbrpracticemode() && !isDefined(self.infil_complete)) {
          self.ignoreall = 1;
          wait 1;
          continue;
        }

        has_path = self botpathexists();
        needs_new_goal = !var_f8cd7c50ce12c857 || !has_path || !scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(script_goal);

        if(var_f8cd7c50ce12c857) {
          distsq = distancesquared(self.origin, script_goal);
          goalradius = self botgetscriptgoalRadius();
          var_531b6f0c0441a69 = distsq < goalradius * goalradius;

          if(!var_531b6f0c0441a69) {
            self.lasttimereachedscriptgoal = undefined;
          } else if(!isDefined(self.lasttimereachedscriptgoal)) {
            self.lasttimereachedscriptgoal = gettime();
          }
        }

        var_7268d1b7d5e3bcdf = level.bot_personality_type[self.personality] == "stationary";

        if(isDefined(self.lasttimereachedscriptgoal)) {
          var_1f511711d810114a = 0;

          if(var_7268d1b7d5e3bcdf) {
            var_1f511711d810114a = 20000;
          }

          needs_new_goal = needs_new_goal || gettime() - self.lasttimereachedscriptgoal >= var_1f511711d810114a;
        }

        if(needs_new_goal) {
          random_point = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle();
          var_5d3fe0fc4ce4a392 = self getclosestreachablepointonnavmesh(random_point);

          if(isDefined(var_5d3fe0fc4ce4a392)) {
            self botsetscriptgoal(var_5d3fe0fc4ce4a392, 1024, "hunt", undefined, undefined, !var_7268d1b7d5e3bcdf);
            self.lasttimereachedscriptgoal = gettime();
          }
        }
      }
    } else {
      scripts\mp\bots\bots_personality::update_personality_default();
    }

    wait 0.05;
  }
}

function function_a4091ef2be7e55b0() {
  var_293fbe5226705d6f = level.br_ac130.origin;
  var_11b7e7d7f8fb6a6d = vectorNormalize(level.infilstruct.c130pathstruct.endpt - var_293fbe5226705d6f);
  var_b4af06317fcb3871 = (level.br_level.br_mapbounds[0][0] - var_293fbe5226705d6f[0]) / var_11b7e7d7f8fb6a6d[0];
  var_b4d218317ff1a7bf = (level.br_level.br_mapbounds[0][1] - var_293fbe5226705d6f[0]) / var_11b7e7d7f8fb6a6d[0];
  var_e659401cd955f3d8 = (level.br_level.br_mapbounds[0][1] - var_293fbe5226705d6f[1]) / var_11b7e7d7f8fb6a6d[1];
  var_e67c561cd97c6bf2 = (level.br_level.br_mapbounds[1][1] - var_293fbe5226705d6f[1]) / var_11b7e7d7f8fb6a6d[1];
  boundsdistances = [var_b4af06317fcb3871, var_b4d218317ff1a7bf, var_e659401cd955f3d8, var_e67c561cd97c6bf2];
  var_858f6ee61ae10b78 = -1;

  foreach(var_820ffebf5ea17ef1 in boundsdistances) {
    if(var_820ffebf5ea17ef1 > 0) {
      if(var_858f6ee61ae10b78 < 0 || var_820ffebf5ea17ef1 < var_858f6ee61ae10b78) {
        var_858f6ee61ae10b78 = var_820ffebf5ea17ef1;
      }
    }
  }

  var_544e266d9bc7fbc2 = var_293fbe5226705d6f + var_11b7e7d7f8fb6a6d * var_858f6ee61ae10b78;
  c130speed = scripts\mp\gametypes\br_c130::getc130speed();
  var_fdefbfd6d1c30ea6 = var_858f6ee61ae10b78 / c130speed;
  return randomfloatrange(0.1, 0.9) * var_fdefbfd6d1c30ea6;
}

function bot_parachute_into_map() {
  self endon("death_or_disconnect");
  self.ignoreall = 1;
  self.desired_landing_spot = bot_get_landing_spot();

  if(getdvarint(@ "hash_451b67b44f0ded25") > 0) {
    thread draw_debug_sphere();
  }

  parachute_time = gettime() + randomfloatrange(5, 10) * 1000;
  chute_pulled = 0;

  while(istrue(self isskydiving()) || istrue(self isparachuting())) {
    if(level.br_circle.circleindex > 0 && istrue(level.circleclosing) && !scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(self.desired_landing_spot)) {
      self.desired_landing_spot = bot_get_landing_spot();
    }

    angles_to_goal = bot_get_angles_to_goal(self, self.desired_landing_spot);
    speed = 1;
    var_26555d95dc188e56 = self.desired_landing_spot - self getEye();

    if(var_26555d95dc188e56[2] > 0 && vectordot(vectorNormalize(var_26555d95dc188e56), (0, 0, 1)) > 0.939693) {
      self.desired_landing_spot = self.origin - (0, 0, 100);
    }

    self botlookatpoint(self.desired_landing_spot, 0.05, "script_forced");
    self botsetscriptmove(angles_to_goal[1], 0.05, speed);

    if(gettime() > parachute_time && !chute_pulled) {
      self botpressbutton("jump", 1);
      chute_pulled = 1;
    }

    wait 0.05;
  }

  self.infil_complete = 1;
  self botlookatpoint(undefined);
  self.ignoreall = 0;
  bot_go_to_destination();
}

function bot_get_landing_spot(var_26ba07cc43e5f46) {
  if(!isDefined(level.free_landing_spots) || level.free_landing_spots.size < 1) {
    level.free_landing_spots = function_7580ae3d6694d93(level.bot_landing_spots);
    level.free_landing_spots = array_randomize(level.free_landing_spots);
  }

  if(isDefined(level.br_circle) && isnavmeshloaded()) {
    landing_spot = random(level.free_landing_spots);

    if(isDefined(landing_spot)) {
      random_point = landing_spot.origin;
      level.free_landing_spots = array_remove(level.free_landing_spots, landing_spot);
    } else {
      random_point = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle();
    }

    return getclosestpointonnavmesh(random_point, self);
  }

  return undefined;
}

function function_7580ae3d6694d93(spotcandidates) {
  radius = scripts\mp\gametypes\br_circle::getdangercircleradius();
  origin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  return get_array_of_closest(origin, spotcandidates, undefined, undefined, radius);
}

function bot_get_angles_to_goal(bot, goal_origin) {
  var_2d1d4d719dbc9554 = vectorNormalize(goal_origin - bot.origin);
  return vectortoangles(var_2d1d4d719dbc9554);
}

function bot_get_distance_to_goal(bot, goal_origin) {
  return distance(bot.origin, goal_origin);
}

function bot_give_weapon() {
  if(!isDefined(level.bot_allowed_weapons)) {
    level.bot_allowed_weapons = ["iw8_sm_papa90_mp", "iw8_sh_charlie725_mp", "iw8_ar_akilo47_mp+acog", "iw8_lm_mgolf34_mp", "iw8_sn_kilo98_mp+scope", "iw8_sm_beta_mp+reflexmini2", "iw8_sm_augolf_mp+acog", "iw8_sm_mpapa7_mp+acog", "iw8_ar_falima_mp+reflexmini", "iw8_ar_kilo433_mp+acog", "iw8_ar_scharlie_mp+reflexmini2", "iw8_lm_lima86_mp+acog"];
  }

  random_weapon = random(level.bot_allowed_weapons);

  switch (random_weapon) {
    case #"hash_f3248b9b1283bc96":
      if(!isDefined(level.bot_shotguns)) {
        level.bot_shotguns = 0;
      }

      level.bot_shotguns++;

      if(level.bot_shotguns >= 1) {
        level.bot_allowed_weapons = array_remove(level.bot_allowed_weapons, "iw8_sh_charlie725_mp");
      }

      break;
    case #"hash_8f2294a118c6d741":
      if(!isDefined(level.bot_snipers)) {
        level.bot_snipers = 0;
      }

      level.bot_snipers++;

      if(level.bot_snipers >= 1) {
        level.bot_allowed_weapons = array_remove(level.bot_allowed_weapons, "iw8_sn_kilo98_mp+scope");
      }

      break;
  }

  weapon_obj = [[level.fnbuildweapon]]([[level.fngetweaponrootname]](random_weapon), [], "none", "none", -1);
  self giveweapon(weapon_obj);
  self setweaponammoclip(weapon_obj, weaponclipsize(weapon_obj));
  self setweaponammostock(weapon_obj, weaponclipsize(weapon_obj));
  self switchtoweapon("none");
}

function bot_go_to_destination() {
  self switchtoweapon("none");
  destination = get_destination_in_current_circle();

  if(!isDefined(destination)) {
    destination = spawnStruct();
    destination.origin = getrandompointinsafecirclenearby();
  }

  destination.claimed = 1;
  var_7268d1b7d5e3bcdf = level.bot_personality_type[self.personality] == "stationary";
  self botsetscriptgoal(self getclosestreachablepointonnavmesh(destination.origin), 256, "guard", undefined, undefined, !var_7268d1b7d5e3bcdf);
  waittill_any_2("goal", "last_stand_start");
  destination.claimed = undefined;

  if(!istrue(self.inlaststand)) {
    bot_give_weapon();
  }

  bot_br_circle_think();
}

function get_destination_in_current_circle() {
  destinations = function_7580ae3d6694d93(level.bot_destination_spots);
  destinations = sortbydistance(destinations, self.origin);
  destination = get_closest_unclaimed_destination(destinations);

  if(!isDefined(destination)) {
    destination = get_closest_destination(destinations);
  }

  return destination;
}

function get_closest_unclaimed_destination(destinations) {
  foreach(destination in destinations) {
    if(!istrue(destination.claimed)) {
      return destination;
    }
  }

  return undefined;
}

function get_closest_destination(destinations) {
  return getclosest(self.origin, destinations);
}

function draw_debug_sphere() {
  self endon("<dev string:x29>");

  while(true) {
    sphere(self.desired_landing_spot, 128, (1, 1, 0), 0, 5);
    wait 0.05;
  }
}

function bot_br_circle_think() {
  var_7268d1b7d5e3bcdf = level.bot_personality_type[self.personality] == "stationary";
  in_gas = 0;

  while(true) {
    var_6b81b7b2626279ec = getrandompointincirclenearby();
    in_gas = bot_is_in_gas() || istrue(level.circleclosing);

    if(in_gas) {
      var_6b81b7b2626279ec = getrandompointinsafecirclenearby();
    }

    if(isDefined(var_6b81b7b2626279ec)) {
      player_enemy = bot_get_player_enemy();

      if(istrue(level.bots_seek_player) && isDefined(player_enemy) && !in_gas) {
        thread update_player_enemy_on_death();
        self getenemyinfo(player_enemy);

        if(self botgetpersonality() != "run_and_gun") {
          bot_set_personality("run_and_gun");
        }

        if(self bothasscriptgoal()) {
          self botclearscriptgoal();
        }

        if(!bot_has_player_enemy()) {
          function_e858f82b38107a7c(player_enemy);
        }
      } else {
        function_6465d473e19215e3();

        if(self bothasscriptgoal()) {
          self botclearscriptgoal();
        }

        if(in_gas) {
          self botsetscriptgoal(var_6b81b7b2626279ec, 128, "critical", undefined, undefined, 0);
        } else {
          self botsetscriptgoal(var_6b81b7b2626279ec, 400, "guard", undefined, undefined, 0);
        }

        if(istrue(in_gas)) {
          in_gas = 0;
        }

        thread path_timeout();
        result = waittill_any_ents_return(self, "goal", self, "bad_path", level, "br_circle_started", self, "last_stand_start", self, "path_timeout");

        if(isDefined(result) && result != "bad_path" && result != "br_circle_started" && result != "path_timeout" && result != "last_stand_start") {
          timetowait = gettime() + randomintrange(3, 8) * 1000;

          while(gettime() < timetowait) {
            if(bot_is_in_gas()) {
              function_6465d473e19215e3();
              break;
            }

            wait 0.1;
          }
        }
      }
    }

    wait 1;
  }
}

function path_timeout() {
  self endon("last_stand_start");
  level endon("game_ended");
  self endon("goal");
  self endon("bad_path");
  level endon("br_circle_started");
  wait 15;
  self notify("path_timeout");
}

function bot_gulag_think() {
  self endon("death_or_disconnect");
  self endon("gulag_end");
  level endon("game_ended");
  var_7268d1b7d5e3bcdf = level.bot_personality_type[self.personality] == "stationary";
  function_6465d473e19215e3(1);
  self.ignoreme = 1;
  self.ignoreall = 1;
  self botclearscriptgoal();

  while(!istrue(self.gulagarena)) {
    wait 1;
  }

  self.ignoreme = 0;
  self.ignoreall = 0;
  bot_set_personality("run_and_gun");

  while(true) {
    arena = self.arena;

    if(isDefined(arena)) {
      foreach(player in arena.arenaplayers) {
        if(player == self) {
          continue;
        }

        if(istrue(arena.overtime) && isDefined(arena.dom) && isDefined(arena.dom.arenaflag) && isDefined(arena.dom.arenaflag.flagmodel)) {
          self botsetscriptgoal(arena.dom.arenaflag.flagmodel.origin, 64, "objective");
          self botclearscriptenemy();
          continue;
        }

        self getenemyinfo(player);
        self botsetscriptgoal(self getclosestreachablepointonnavmesh(player.origin), 256, "guard");

        if(self.team != player.team) {
          self botsetscriptenemy(player);
        }
      }
    }

    wait 3;
  }
}

function ammo_manager(isdisabled) {
  self endon("death_or_disconnect");

  while(true) {
    weapon_list = self getweaponslistprimaries();

    if(weapon_list.size == 1 && weapon_list[0].basename == "iw9_me_fists_mp" || isDefined(isdisabled) && self[[isdisabled]]()) {
      wait 1;
      continue;
    }

    foreach(weapon in weapon_list) {
      if(self getweaponammostock(weapon) < weaponclipsize(weapon)) {
        self setweaponammostock(weapon, weaponclipsize(weapon));
      }
    }

    wait 0.1;
  }
}

function bot_get_player_enemy() {
  if(isDefined(level.player_enemy_cooldown) && gettime() <= level.player_enemy_cooldown) {
    return undefined;
  }

  player_enemy = get_player_enemy();

  if(!isDefined(player_enemy)) {
    return undefined;
  }

  return player_enemy;
}

function bots_with_player_enemy() {
  count = 0;

  foreach(bot in level.players) {
    if(!isbot(bot)) {
      continue;
    }

    if(bot bot_has_player_enemy()) {
      count++;
    }
  }

  return count;
}

function function_e858f82b38107a7c(enemy) {
  self.player_enemy = enemy;
  self botsetscriptenemy(enemy);
}

function function_6465d473e19215e3(dontnotify) {
  self.player_enemy = undefined;
  self botclearscriptenemy();

  if(!istrue(dontnotify)) {
    self notify("update_on_death");
  }
}

function bot_has_player_enemy() {
  return isDefined(self.player_enemy);
}

function get_player_enemy() {
  player_enemy = get_player();
  var_41dc9e8631a11f9c = squared(3000);

  if(istrue(self.inlaststand) || scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
    return undefined;
  }

  if(!isDefined(player_enemy) || istrue(player_enemy.inlaststand) || !isalive(player_enemy) || player_enemy scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
    return undefined;
  }

  if(bot_is_in_gas()) {
    return undefined;
  }

  alive_bots = get_alive_bots();

  if(alive_bots >= 3) {
    if(distancesquared(player_enemy.origin, self.origin) > var_41dc9e8631a11f9c) {
      return undefined;
    }

    player_hunters = bots_with_player_enemy();

    if(bot_has_player_enemy()) {
      return player_enemy;
    }

    if(player_hunters >= 1) {
      return undefined;
    }

    return player_enemy;
  }

  return player_enemy;
}

function get_player() {
  foreach(player in level.players) {
    if(!isbot(player)) {
      return player;
    }
  }
}

function update_player_enemy_on_death() {
  self notify("update_on_death");
  self endon("update_on_death");
  waittill_any_3("death", "death_or_disconnect", "last_stand_start");

  if(isDefined(self)) {
    function_6465d473e19215e3(1);
  }

  level.player_enemy_cooldown = gettime() + 7;
}

function bot_is_in_gas() {
  if(!scripts\mp\flags::gameflag("graceperiod_done")) {
    return false;
  }

  circleorigin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  circleradius = scripts\mp\gametypes\br_circle::getdangercircleradius();

  if(istrue(level.circleclosing)) {
    circleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    circleradius = scripts\mp\gametypes\br_circle::getsafecircleradius();
  }

  if(scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
    return false;
  }

  if(!isalive(self) || self.sessionstate != "playing") {
    return false;
  }

  return !ispointinsidecircle(self.origin, circleorigin, circleradius);
}

function getrandompointincirclewithindistance(maxdistance) {
  random_point = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle();

  if(!isDefined(maxdistance)) {
    maxdistance = 1000;
  }

  if(distance2d(self.origin, random_point) > maxdistance) {
    dir = vectortoangles(random_point - self.origin);
    fwd = anglesToForward(dir);
    random_point = self.origin + fwd * maxdistance;
  }

  return self getclosestreachablepointonnavmesh(random_point);
}

function getrandompointinsafecirclenearby() {
  safecircleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  dist = scripts\mp\gametypes\br_circle::getsafecircleradius();
  random_point = scripts\mp\gametypes\br_circle::getrandompointincircle(safecircleorigin, dist, 0.75, 0.9, 1, 1);
  return self getclosestreachablepointonnavmesh(random_point);
}

function getrandompointincirclenearby() {
  timeout = gettime() + 5000;

  while(gettime() < timeout) {
    point = scripts\mp\gametypes\br_circle::getrandompointincircle(self.origin, 750, 0.6, 1, 1, 1);
    reachable_point = self getclosestreachablepointonnavmesh(point);

    if(ispointincurrentcircle(reachable_point)) {
      return reachable_point;
    }

    wait 0.05;
  }

  random_point = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle();
  return self getclosestreachablepointonnavmesh(random_point);
}

function ispointincurrentcircle(point) {
  circleorigin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  circleradius = scripts\mp\gametypes\br_circle::getdangercircleradius();
  return ispointinsidecircle(point, circleorigin, circleradius);
}

function get_alive_bots() {
  alive_bots = 0;

  foreach(player in level.players) {
    if(!isbot(player) || !isalive(player) || player.sessionstate != "playing") {
      continue;
    }

    alive_bots++;
  }

  return alive_bots;
}

function botisonplayerteam(player) {
  alive_players = level.teamdata[player.team]["alivePlayers"];

  if(array_contains(alive_players, self)) {
    return true;
  }

  return false;
}