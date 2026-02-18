/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_mannequin_ally.gsc
***********************************************/

#using script_ed50e9299d3e143;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\archetype\archetype_zod_companion;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_spawner;
#namespace namespace_ca8676a3;

function private autoexec __init__system__() {
  system::register(#"hash_217942543a3e669b", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  spawner::add_archetype_spawn_function(#"zod_companion", &function_10c92445);

  function_851f409b();
}

function private function_10c92445() {
  self.ignore_nuke = 1;
  self.ignore_all_poi = 1;
  self.is_inert = 1;
  self.instakill_func = &zm_powerups::function_16c2586a;
  self.var_69bfb00a = &function_188e5077;
  self.var_135f3e2e = &function_2abc1fe5;
  self.var_b98a92a2 = 1000;
  self.var_ab38d331 = 0;
  self val::set(#"mannequin_ally", "takedamage", 0);
  self.var_7c4488fd = 1;
  self.var_535fbaa3 = 1200;
  self namespace_47c5b560::function_904442b2();
  self.var_6d409ca1 = &function_6d409ca1;
  self.var_397796ce = 256;
  self.var_42918474 = 1;
  self.var_ce2dd587 = 10;
  self.var_fdd8e511 = 10;
  self.var_952959e1 = &function_a3b94da7;
  self.var_793f9f37 = &function_87d77748;
  self.noplayermeleeblood = 1;
  self.var_ba00404c = 1;
  self.var_674fb2e2 = 1;
  self val::set(#"klaus", "prioritize_target_near_leader", 1);
  self callback::function_d8abfc3d(#"hash_49bf4815e9501d2", &zodcompanionutility::function_ae69d4a5);
  self setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");

  if(getdvarint(#"hash_63cafe6978c3b249", 0)) {
    if(!isDefined(level.var_777acf92)) {
      level.var_777acf92 = spawnStruct();
      level.var_777acf92.origin = self.origin;
      level.var_777acf92.angles = self.angles;
    }
  }

  if(isDefined(level.var_777acf92)) {
    self thread function_65ed0370(level.var_777acf92.origin, level.var_777acf92.angles);
  }

  self thread function_d37f3f18();
}

function private function_188e5077(angles) {
  self thread animation::play("ai_t9_zm_klaus_stn_exposed_revive", self, angles, 1);
}

function function_65ed0370(origin, angles) {
  self endon(#"death");
  self forceteleport(origin, angles);
  self orientmode("face default");
  self animation::play("ai_t9_zm_klaus_intro");
}

function private function_2abc1fe5(closestai, closestplayer) {
  if(isDefined(closestplayer.entity)) {
    return closestplayer.entity;
  }

  return undefined;
}

function private function_6d409ca1() {
  return self.leader;
}

function switch_weapon(weapon_name) {
  self ai::gun_remove();
  weapon = getweapon(weapon_name);
  self aiutility::setcurrentweapon(weapon);
  self aiutility::setprimaryweapon(weapon);
  self ai::gun_switchto(weapon, "right");
}

function function_94fde0c0() {
  self.aat[aat::function_702fb333(self.weapon)] = "ammomod_deadwire";
  self.tesla_network_death_choke = 0;
  self.tesla_arc_count = 0;
}

function function_a3b94da7() {
  aiutility::releaseclaimnode(self);
  self clearforcedgoal();
  self.next_move_time = gettime();
}

function function_87d77748() {
  if(zodcompanionbehavior::zodcompanionhasdefendlocation(self)) {
    self zodcompanionutility::function_34179e9a();
  }
}

function function_8996b315(var_ac5f535, bomb_model) {
  self zodcompanionutility::function_34179e9a();
  self zodcompanionutility::function_60dcf99d(var_ac5f535);

  if(is_true(var_ac5f535)) {
    self val::reset(#"mannequin_ally", "takedamage");
    self val::set(#"zod_companion", "ignoreall", 1);
    level flag::set(#"hash_66eb1b5632f46da8");

    if(isDefined(self.weapon)) {
      self.last_weapon_name = self.weapon.name;
      self val::set(#"hash_12fe84721f8b0c30", "take_weapons", 1);
    }

    if(isDefined(bomb_model)) {
      self attach(bomb_model, "tag_weapon_right");
    }

    return;
  }

  self val::set(#"mannequin_ally", "takedamage", 0);
  self val::reset(#"zod_companion", "ignoreall");
  level flag::clear(#"hash_66eb1b5632f46da8");

  if(isDefined(self.last_weapon_name)) {
    self val::reset(#"hash_12fe84721f8b0c30", "take_weapons");
    self switch_weapon(self.last_weapon_name);
    self.last_weapon_name = undefined;
  }

  if(isDefined(bomb_model)) {
    self detach(bomb_model, "tag_weapon_right");
  }
}

function function_92157e49(goal, move_speed = "walk") {
  navmeshpoint = getclosestpointonnavmesh(goal, self getpathfindingradius() * 2, self getpathfindingradius());

  if(isDefined(navmeshpoint)) {
    switch (move_speed) {
      case # "sprint":
        self ai::set_behavior_attribute("sprint", 1);
        self setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
        break;
      case # "run":
        self ai::set_behavior_attribute("sprint", 0);
        self setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
        break;
      case # "walk":
      default:
        self ai::set_behavior_attribute("sprint", 0);
        self setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
        break;
    }

    aiutility::releaseclaimnode(self);
    self clearforcedgoal();
    self setgoal(navmeshpoint, 1);
  }
}

function private function_d37f3f18() {
  level endon(#"end_game");

  while(isalive(self)) {
    if(!isDefined(self.leader)) {
      waitframe(1);
      continue;
    }

    if(!level flag::get(#"hash_6d16c284cbb301d1")) {
      var_12001660 = is_true(self.leader.var_4db2872c);
      self.leader.var_4db2872c = 0;

      if(var_12001660 && self.leader laststand::player_is_in_laststand()) {
        zm_player::function_8ef51109();
      }
    } else {
      self.leader.var_4db2872c = 1;
    }

    waitframe(1);
  }

  if(isDefined(self.leader)) {
    var_12001660 = is_true(self.leader.var_4db2872c);
    self.leader.var_4db2872c = 0;

    if(var_12001660 && self.leader laststand::player_is_in_laststand()) {
      zm_player::function_8ef51109();
    }
  }
}

function private function_851f409b() {
  adddebugcommand("<dev string:x38>");
  adddebugcommand("<dev string:x8b>");
  adddebugcommand("<dev string:xef>");
  adddebugcommand("<dev string:x14d>");
  zm_devgui::add_custom_devgui_callback(&function_18227767);
}

function private function_18227767(cmd) {
  switch (cmd) {
    case # "hash_31690de1b49c022a":
      ais = getaiarchetypearray(#"zod_companion");

      if(ais.size > 0) {
        ai = ais[0];
        var_49e9776e = !is_true(ai.iscarryingbomb);
        ai function_8996b315(var_49e9776e);
      }

      break;
    case # "hash_dc11efc5ca22f74":
      function_e3e858b1(250, "<dev string:x1b3>");
      break;
    case # "hash_35381ef4960cf279":
      function_e3e858b1(250, "<dev string:x1bd>");
      break;
    case # "hash_22d1be7a17698c91":
      function_e3e858b1(250, "<dev string:x1c4>");
      break;
    default:
      break;
  }
}

function private function_e3e858b1(dist, move_speed) {
  if(!isDefined(move_speed)) {
    move_speed = "<dev string:x1c4>";
  }

  ais = getaiarchetypearray(#"zod_companion");

  if(ais.size > 0) {
    ai = ais[0];
    fwd = vectorscale(vectornormalize(anglesToForward(ai.angles)), dist);
    eye = ai.origin + (0, 0, 80);
    trace = bulletTrace(eye, eye + fwd, 0, ai);
    var_380c580a = positionquery_source_navigation(trace[# "position"], 128, 256, 128, 20);
    point = ai.origin;

    if(isDefined(var_380c580a) && var_380c580a.data.size > 0) {
      point = var_380c580a.data[0].origin;
    }

    ai function_92157e49(point, move_speed);
  }
}