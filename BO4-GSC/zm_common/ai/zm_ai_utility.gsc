/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\ai\zm_ai_utility.gsc
***********************************************/

#include script_2c5daa95f8fec03c;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_ai_utility;

autoexec __init__system__() {
  system::register(#"zm_ai_utility", &__init__, undefined, undefined);
}

private __init__() {
  spawner::add_ai_spawn_function(&function_8d30564f);
  callback::on_vehicle_spawned(&function_8d30564f);
}

private function_8d30564f() {
  self.spawn_time = gettime();
  self function_637778cf();
}

private function_637778cf() {
  settingsbundle = self ai::function_9139c839();

  if(!isDefined(settingsbundle)) {
    return;
  }

  self.zm_ai_category = settingsbundle.category;
  self.var_28aab32a = settingsbundle.var_10460f1e;
  self.var_95d94ac4 = settingsbundle.stunduration;
  self.score_event = settingsbundle.scoreevent;

  if(isDefined(settingsbundle.var_5c3586f3)) {
    self.powerups = arraycopy(settingsbundle.var_5c3586f3);
    self thread function_3edc6292();
  }

  if(isDefined(settingsbundle.weapondamagescaleoverrides)) {
    function_a19d7104(settingsbundle);
  }
}

private function_a19d7104(settingsbundle) {
  if(isDefined(settingsbundle.var_6199bcd5) && settingsbundle.var_6199bcd5) {
    return;
  }

  if(!isDefined(level.var_532264f5)) {
    level.var_532264f5 = [];
  }

  if(!isDefined(level.var_532264f5[settingsbundle.name])) {
    level.var_532264f5[settingsbundle.name] = [];
  }

  foreach(var_e8d7c6d7 in settingsbundle.weapondamagescaleoverrides) {
    if(!isDefined(var_e8d7c6d7.weaponid) || !isDefined(var_e8d7c6d7.damagescale)) {
      println("<dev string:x38>" + settingsbundle.name);
      continue;
    }

    level.var_532264f5[settingsbundle.name][var_e8d7c6d7.weaponid] = {
      #var_c6cc6205: var_e8d7c6d7.damagescale, 
      #var_fff93f95: var_e8d7c6d7.weakpointdamagescale, 
      #var_8e22aa87: var_e8d7c6d7.instakilldamagescale, 
      #var_fac896db: var_e8d7c6d7.var_97b22faa
    };
  }

  settingsbundle.var_6199bcd5 = 1;
}

function_94d76123(weapon) {
  if(isDefined(self.var_76167463) && isDefined(weapon) && isDefined(level.var_532264f5) && isDefined(level.var_532264f5[self.var_76167463]) && isDefined(level.var_532264f5[self.var_76167463][weapon.name])) {
    return true;
  }

  return false;
}

function_86cb3728(weapon) {
  return level.var_532264f5[self.var_76167463][weapon.name];
}

function_2ad308c4(archetype, drop_func) {
  if(!isDefined(level.var_1029f68)) {
    level.var_1029f68 = [];
  }

  if(!isDefined(level.var_1029f68[archetype])) {
    level.var_1029f68[archetype] = [];
  }

  if(!isDefined(level.var_1029f68[archetype])) {
    level.var_1029f68[archetype] = [];
  } else if(!isarray(level.var_1029f68[archetype])) {
    level.var_1029f68[archetype] = array(level.var_1029f68[archetype]);
  }

  level.var_1029f68[archetype][level.var_1029f68[archetype].size] = drop_func;
}

function_594bb7bd(player) {
  if(!isDefined(level.var_1029f68)) {
    return;
  }

  foreach(archetype, callback_array in level.var_1029f68) {
    ai_array = getaiarchetypearray(archetype);

    foreach(ai in ai_array) {
      foreach(callback in callback_array) {
        ai[[callback]](player);
      }
    }
  }
}

get_pathnode_path(pathnode) {
  path_struct = {
    #path: array(pathnode), 
    #loops: 0
  };
  var_592eaf7 = pathnode;

  while(isDefined(var_592eaf7.target)) {
    var_592eaf7 = getnode(var_592eaf7.target, "targetname");

    if(!isDefined(var_592eaf7)) {
      break;
    }

    if(isinarray(path_struct.path, var_592eaf7)) {
      path_struct.loops = 1;
      break;
    }

    if(!isDefined(path_struct.path)) {
      path_struct.path = [];
    } else if(!isarray(path_struct.path)) {
      path_struct.path = array(path_struct.path);
    }

    path_struct.path[path_struct.path.size] = var_592eaf7;
  }

  return path_struct;
}

start_patrol(entity, patrol_path, var_b90f0f49, var_73fcb9ff, var_572b1f58) {
  entity thread update_patrol(entity, patrol_path, var_b90f0f49, var_73fcb9ff, var_572b1f58);
}

stop_patrol(entity) {
  if(entity ai::has_behavior_attribute("patrol")) {
    entity ai::set_behavior_attribute("patrol", 0);
  }

  entity notify(#"stop_patrol");
}

private update_patrol(entity, patrol_path, var_b90f0f49, var_73fcb9ff, var_572b1f58) {
  entity notify(#"stop_patrol");
  entity endon(#"death", #"stop_patrol");

  if(!entity ai::has_behavior_attribute("patrol")) {
    return;
  }

  entity ai::set_behavior_attribute("patrol", 1);

  while(entity ai::get_behavior_attribute("patrol") && patrol_path.size > 0) {
    for(i = 0; i < patrol_path.size; i++) {
      var_cf88d3eb = patrol_path[i];
      next_goal = getclosestpointonnavmesh(var_cf88d3eb.origin, 100, entity getpathfindingradius());

      if(!isDefined(next_goal)) {
        break;
      }

      entity setgoal(next_goal);
      entity waittill(#"goal_changed");
      entity waittill(#"goal");

      if(isDefined(var_73fcb9ff)) {
        entity[[var_73fcb9ff]](var_cf88d3eb);
      }

      if(entity ai::get_behavior_attribute("patrol") == 0) {
        break;
      }
    }

    if(!(isDefined(var_b90f0f49) && var_b90f0f49)) {
      break;
    }
  }

  if(isDefined(var_572b1f58)) {
    entity[[var_572b1f58]]();
  }
}

function_8d44707e(var_7112190, var_fc65696c) {
  n_min = self ai::function_9139c839().minhealth;
  n_max = self ai::function_9139c839().maxhealth;
  var_cc83a31d = self ai::function_9139c839().var_250a1683;
  var_1be13a31 = self ai::function_9139c839().var_854eebd;
  n_health = n_min + var_cc83a31d * (isDefined(var_fc65696c) ? var_fc65696c : level.round_number);

  if(isDefined(var_1be13a31) && var_7112190 && level.players.size > 1) {
    n_health += n_health * (level.players.size - 1) * var_1be13a31;
  }

  return int(math::clamp(n_health, n_min, n_max));
}

function_db610082() {
  if(!isDefined(self)) {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  if(self.archetype !== #"zombie") {
    return false;
  }

  if(isDefined(self.aat_turned) && self.aat_turned) {
    return false;
  }

  if(isDefined(self.missinglegs) && self.missinglegs) {
    return false;
  }

  if(isDefined(self.knockdown) && self.knockdown) {
    return false;
  }

  if(gibserverutils::isgibbed(self, 56)) {
    return false;
  }

  if(isDefined(self.traversal) || self function_dd070839()) {
    return false;
  }

  if(isDefined(self.var_69a981e6) && self.var_69a981e6) {
    return false;
  }

  if(isDefined(self.barricade_enter) && self.barricade_enter) {
    return false;
  }

  if(isDefined(self.is_leaping) && self.is_leaping) {
    return false;
  }

  if(!(isDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
    return false;
  }

  if(!(isDefined(self zm_utility::in_playable_area()) && self zm_utility::in_playable_area())) {
    return false;
  }

  return true;
}

function_422fdfd4(entity, attacker, weapon, var_5457dc44, hitloc, point, var_ebcb86d6, var_b85996d4, var_159ce525, var_ddd319d6, var_d2314927) {
  var_8d3f5b7d = isalive(attacker) && isplayer(attacker);
  var_201ce857 = var_8d3f5b7d && attacker zm_powerups::is_insta_kill_active();
  var_84ed9a13 = function_de3dda83(var_5457dc44, hitloc, point, var_ebcb86d6);
  registerzombie_bgb_used_reinforce = isDefined(var_84ed9a13) && namespace_81245006::function_f29756fe(var_84ed9a13) == 1;
  var_30362eca = registerzombie_bgb_used_reinforce && var_84ed9a13.type !== #"armor";

  if(entity function_94d76123(weapon)) {
    var_532264f5 = entity function_86cb3728(weapon);
    var_c6cc6205 = isDefined(var_b85996d4) ? var_b85996d4 : var_532264f5.var_c6cc6205;
    var_fff93f95 = isDefined(var_159ce525) ? var_159ce525 : var_532264f5.var_fff93f95;
    var_cee56a92 = isDefined(var_ddd319d6) ? var_ddd319d6 : var_532264f5.var_8e22aa87;
    var_e008ecea = isDefined(var_d2314927) ? var_d2314927 : var_532264f5.var_fac896db;
  } else {
    var_c6cc6205 = var_b85996d4;
    var_fff93f95 = var_159ce525;
    var_cee56a92 = var_ddd319d6;
    var_e008ecea = var_d2314927;
  }

  if(!var_201ce857 && !var_30362eca) {
    var_b1c1c5cf = isDefined(var_c6cc6205) ? var_c6cc6205 : entity ai::function_9139c839().damagescale;
  } else if(!var_201ce857 && var_30362eca) {
    var_b1c1c5cf = isDefined(var_fff93f95) ? var_fff93f95 : entity ai::function_9139c839().weakpointdamagescale;
  } else if(var_201ce857 && !var_30362eca) {
    var_b1c1c5cf = isDefined(var_cee56a92) ? var_cee56a92 : entity ai::function_9139c839().instakilldamagescale;
  } else {
    var_b1c1c5cf = isDefined(var_e008ecea) ? var_e008ecea : entity ai::function_9139c839().var_97b22faa;
  }

  if(var_8d3f5b7d) {
    has_weakpoints = isDefined(namespace_81245006::function_fab3ee3e(self));

    if(var_30362eca && attacker hasperk(#"specialty_mod_awareness")) {
      if(var_b1c1c5cf < 1) {
        var_b1c1c5cf += 0.2;
      } else {
        var_b1c1c5cf *= 1.2;
      }
    } else if(registerzombie_bgb_used_reinforce && var_84ed9a13.type == #"armor" && weaponhasattachment(weapon, "fmj2")) {
      if(self.zm_ai_category == #"boss") {
        var_b1c1c5cf *= 1.1;
      } else {
        var_b1c1c5cf = min(1, var_b1c1c5cf + 0.1);
      }
    } else if(has_weakpoints && !registerzombie_bgb_used_reinforce && weaponhasattachment(weapon, "fmj") && var_b1c1c5cf < 1) {
      if(self.zm_ai_category == #"boss") {
        var_b1c1c5cf *= 1.1;
      } else {
        var_b1c1c5cf = min(1, var_b1c1c5cf + 0.1);
      }
    }
  }

  return {
    #damage_scale: var_b1c1c5cf, 
    #var_84ed9a13: var_84ed9a13, 
    #registerzombie_bgb_used_reinforce: registerzombie_bgb_used_reinforce, 
    #var_201ce857: var_201ce857
  };
}

function_de3dda83(var_5457dc44, hitloc, point, var_ebcb86d6) {
  if(isDefined(var_ebcb86d6)) {
    var_84ed9a13 = var_ebcb86d6;
  } else {
    var_84ed9a13 = namespace_81245006::function_3131f5dd(self, hitloc, 1);

    if(!isDefined(var_84ed9a13)) {
      var_84ed9a13 = namespace_81245006::function_37e3f011(self, var_5457dc44);
    }

    if(!isDefined(var_84ed9a13)) {
      var_84ed9a13 = namespace_81245006::function_73ab4754(self, point, 1);
    }
  }

  return var_84ed9a13;
}

function_a2e8fd7b(entity, player, var_3f120c4d = 4) {
  assert(isplayer(player), "<dev string:x67>");

  if(getdvarint(#"zm_zone_pathing", 1)) {
    zone_path = zm_zonemgr::function_54fc7938(player, entity);

    if(isDefined(zone_path) && zone_path.cost >= var_3f120c4d) {
      to_zone = level.zones[zone_path.to_zone];

      for(var_3a38abb0 = 0; isDefined(to_zone.var_458fe8a) && to_zone.var_458fe8a && var_3a38abb0 < 4; var_3a38abb0++) {
        zone_path = zm_zonemgr::function_54fc7938(player, zone_path.to_zone);

        if(!isDefined(zone_path)) {
          return player;
        }

        to_zone = level.zones[zone_path.to_zone];
      }

      if(isDefined(to_zone) && to_zone.nodes.size > 0) {
        return to_zone.nodes[0];
      }
    }
  }

  return player;
}

make_zombie_target(entity) {
  if(isinarray(level.zombie_targets, entity)) {

    iprintlnbold("<dev string:x9d>" + entity getentitynumber() + "<dev string:xa7>");

      return false;
  }

  function_1eaaceab(level.zombie_targets);
  arrayremovevalue(level.zombie_targets, undefined);

  if(level.zombie_targets.size + 4 >= 16) {

    iprintlnbold("<dev string:xc5>" + entity getentitynumber() + "<dev string:xde>");

      return false;
  }

  if(!isDefined(entity.am_i_valid)) {
    entity.am_i_valid = 1;
  }

  if(!isDefined(level.zombie_targets)) {
    level.zombie_targets = [];
  } else if(!isarray(level.zombie_targets)) {
    level.zombie_targets = array(level.zombie_targets);
  }

  level.zombie_targets[level.zombie_targets.size] = entity;
  return true;
}

is_zombie_target(entity) {
  return isinarray(level.zombie_targets, entity);
}

remove_zombie_target(entity) {
  if(!isinarray(level.zombie_targets, entity)) {

    iprintlnbold("<dev string:x9d>" + entity getentitynumber() + "<dev string:x10a>");

      return false;
  }

  arrayremovevalue(level.zombie_targets, entity);
  return true;
}

function_3edc6292() {
  if(!isDefined(self.powerups)) {
    return 0;
  }

  if(!isDefined(self.var_d0686fde)) {
    self.var_d0686fde = [];
  } else if(!isarray(self.var_d0686fde)) {
    self.var_d0686fde = array(self.var_d0686fde);
  }

  for(i = 0; i < self.powerups.size; i++) {
    self.var_d0686fde[i] = self.powerups[i].dropid;
  }
}

function_991333ce(entity, ai_array) {
  enemies = ai_array;

  if(!isDefined(enemies)) {
    enemies = getaiteamarray(level.zombie_team);
  }

  foreach(enemy in enemies) {
    if(enemy.favoriteenemy === entity) {
      if(isDefined(enemy.var_ef1ed308)) {
        [
          [enemy.var_ef1ed308]
        ](enemy);
      } else {
        enemy.favoriteenemy = undefined;
      }

      enemy.var_93a62fe = undefined;
      enemy setgoal(enemy.origin);
    }
  }
}

private function_f1b557c6() {
  if(self isplayinganimscripted()) {
    return false;
  }

  if(isactor(self) && (self.isarriving || self function_dd070839() || self asmistransdecrunning() || self asmistransitionrunning())) {
    return false;
  }

  return true;
}

function_a8dc3363(s_location) {
  if(isalive(self)) {
    self endon(#"death");
    self val::set(#"ai_cleanup", "hide", 2);
    util::wait_network_frame();
    self pathmode("dont move", 1);

    while(!self function_f1b557c6()) {
      waitframe(1);
    }

    self dontinterpolate();
    self forceteleport(s_location.origin, self.angles, 0, 1);
    self pathmode("move allowed");
    self val::reset(#"ai_cleanup", "hide");
    self zombie_utility::reset_attack_spot();
    self.completed_emerging_into_playable_area = 0;
    self.find_flesh_struct_string = s_location.script_string;
    self.got_to_entrance = undefined;
    self.at_entrance_tear_spot = undefined;
    self.spawn_time = gettime();

    if((self.zm_ai_category == #"basic" || self.zm_ai_category == #"enhanced") && s_location.script_noteworthy != "spawn_location" && s_location.script_noteworthy != "blight_father_location") {
      self.spawn_pos = undefined;
      self zm_utility::move_zombie_spawn_location(s_location);
    }
  }
}

function_54054394(entity) {
  if(!isDefined(level.var_5fa2f970)) {
    level.var_5fa2f970 = getEntArray("no_powerups", "targetname");
  }

  foreach(volume in level.var_5fa2f970) {
    if(entity istouching(volume)) {
      return true;
    }
  }

  return false;
}