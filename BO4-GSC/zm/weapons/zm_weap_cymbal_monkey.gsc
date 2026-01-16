/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_cymbal_monkey.gsc
************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_clone;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_cymbal_monkey;

autoexec __init__system__() {
  system::register(#"zm_weap_cymbal_monkey", &__init__, &__main__, #"zm_weapons");
}

__init__() {
  level.weaponzmcymbalmonkey = getweapon(#"cymbal_monkey");
  zm_weapons::register_zombie_weapon_callback(level.weaponzmcymbalmonkey, &player_give_cymbal_monkey);
  zm_loadout::register_lethal_grenade_for_level(#"cymbal_monkey");
  clientfield::register("scriptmover", "" + #"hash_60a7e5b79e8064a5", 1, 1, "int");
  zm::function_84d343d(#"cymbal_monkey", &function_3681e2bc);
}

__main__() {
  if(!cymbal_monkey_exists()) {
    return;
  }

  level.zombiemode_devgui_cymbal_monkey_give = &player_give_cymbal_monkey;

    if(isDefined(level.legacy_cymbal_monkey) && level.legacy_cymbal_monkey) {
      level.cymbal_monkey_model = "weapon_zombie_monkey_bomb";
    }
  else {
    level.cymbal_monkey_model = "wpn_t7_zmb_monkey_bomb_world";
  }

  level._effect[#"monkey_glow"] = #"zm_weapons/fx8_cymbal_monkey_light";
  level._effect[#"grenade_samantha_steal"] = #"hash_7965ec9e0938553f";
  level.cymbal_monkeys = [];
  level.var_2f2478f2 = 1;

  if(!isDefined(level.valid_poi_max_radius)) {
    level.valid_poi_max_radius = 150;
  }

  if(!isDefined(level.valid_poi_half_height)) {
    level.valid_poi_half_height = 100;
  }

  if(!isDefined(level.valid_poi_inner_spacing)) {
    level.valid_poi_inner_spacing = 2;
  }

  if(!isDefined(level.valid_poi_radius_from_edges)) {
    level.valid_poi_radius_from_edges = 16;
  }

  if(!isDefined(level.valid_poi_height)) {
    level.valid_poi_height = 36;
  }
}

function_3681e2bc(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(meansofdeath === "MOD_IMPACT") {
    return 0;
  }

  var_b1c1c5cf = zm_equipment::function_7d948481(0.1, 0.25, 1, 1);
  var_5d7b4163 = zm_equipment::function_379f6b5d(damage, var_b1c1c5cf, 1, 4, 50);
  return var_5d7b4163;
}

player_give_cymbal_monkey() {
  w_weapon = level.weaponzmcymbalmonkey;

  if(!self hasweapon(w_weapon)) {
    self giveweapon(w_weapon);
  }

  self thread player_handle_cymbal_monkey();
}

player_handle_cymbal_monkey() {
  self notify(#"starting_monkey_watch");
  self endon(#"starting_monkey_watch", #"disconnect");
  attract_dist_diff = level.monkey_attract_dist_diff;

  if(!isDefined(attract_dist_diff)) {
    attract_dist_diff = 16;
  }

  num_attractors = level.num_monkey_attractors;

  if(!isDefined(num_attractors)) {
    num_attractors = 32;
  }

  max_attract_dist = level.monkey_attract_dist;

  if(!isDefined(max_attract_dist)) {
    max_attract_dist = 3000;
  }

  while(true) {
    grenade = get_thrown_monkey();
    self player_throw_cymbal_monkey(grenade, num_attractors, max_attract_dist, attract_dist_diff);
    waitframe(1);
  }
}

watch_for_dud(actor) {
  self endon(#"death");
  self waittill(#"grenade_dud");
  self.mdl_monkey.dud = 1;
  self playSound(#"zmb_vox_monkey_scream");
  self.monk_scream_vox = 1;
  wait 3;

  if(isDefined(self.mdl_monkey)) {
    self.mdl_monkey delete();
  }

  if(isDefined(actor)) {
    actor delete();
  }

  if(isDefined(self.damagearea)) {
    self.damagearea delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

watch_for_emp(actor) {
  self endon(#"death");

  if(!zm_utility::should_watch_for_emp()) {
    return;
  }

  while(true) {
    waitresult = level waittill(#"emp_detonate");

    if(distancesquared(waitresult.position, self.origin) < waitresult.radius * waitresult.radius) {
      break;
    }
  }

  self.stun_fx = 1;

  if(isDefined(level._equipment_emp_destroy_fx)) {
    playFX(level._equipment_emp_destroy_fx, self.origin + (0, 0, 5), (0, randomfloat(360), 0));
  }

  wait 0.15;
  self.attract_to_origin = 0;
  self zm_utility::deactivate_zombie_point_of_interest();
  wait 1;
  self detonate();
  wait 1;

  if(isDefined(self.mdl_monkey)) {
    self.mdl_monkey delete();
  }

  if(isDefined(actor)) {
    actor delete();
  }

  if(isDefined(self.damagearea)) {
    self.damagearea delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

clone_player_angles(owner) {
  self endon(#"death");
  owner endon(#"death");

  while(isDefined(self)) {
    self.angles = owner.angles;
    waitframe(1);
  }
}

show_briefly(showtime) {
  self endon(#"show_owner");

  if(isDefined(self.show_for_time)) {
    self.show_for_time = showtime;
    return;
  }

  self.show_for_time = showtime;
  self setvisibletoall();

  while(self.show_for_time > 0) {
    self.show_for_time -= 0.05;
    waitframe(1);
  }

  self setvisibletoallexceptteam(level.zombie_team);
  self.show_for_time = undefined;
}

show_owner_on_attack(owner) {
  owner endon(#"hide_owner", #"show_owner");
  self endon(#"explode", #"death", #"grenade_dud");
  owner.show_for_time = undefined;

  for(;;) {
    owner waittill(#"weapon_fired");
    owner thread show_briefly(0.5);
  }
}

hide_owner(owner) {
  owner notify(#"hide_owner");
  owner endon(#"hide_owner");
  owner setperk("specialty_immunemms");
  owner.no_burning_sfx = 1;
  owner notify(#"stop_flame_sounds");
  owner setvisibletoallexceptteam(level.zombie_team);
  owner.hide_owner = 1;

  if(isDefined(level._effect[#"human_disappears"])) {
    playFX(level._effect[#"human_disappears"], owner.origin);
  }

  self thread show_owner_on_attack(owner);
  evt = self waittill(#"explode", #"death", #"grenade_dud");
  println("<dev string:x38>" + evt._notify);
  owner notify(#"show_owner");
  owner unsetperk("specialty_immunemms");

  if(isDefined(level._effect[#"human_disappears"])) {
    playFX(level._effect[#"human_disappears"], owner.origin);
  }

  owner.no_burning_sfx = undefined;
  owner setvisibletoall();
  owner.hide_owner = undefined;
  owner show();
}

proximity_detonate(owner) {
  wait 1.5;

  if(!isDefined(self)) {
    return;
  }

  detonateradius = 96;
  explosionradius = detonateradius * 2;
  damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - detonateradius), 512 | 4, detonateradius, detonateradius * 1.5);
  damagearea setexcludeteamfortrigger(owner.team);
  damagearea enablelinkto();
  damagearea linkto(self);
  self.damagearea = damagearea;

  while(isDefined(self)) {
    waitresult = damagearea waittill(#"trigger");
    ent = waitresult.activator;

    if(isDefined(owner) && ent == owner) {
      continue;
    }

    if(isDefined(ent.team) && ent.team == owner.team) {
      continue;
    }

    self playSound(#"wpn_claymore_alert");
    dist = distance(self.origin, ent.origin);
    radiusdamage(self.origin + (0, 0, 12), explosionradius, 1, 1, owner, "MOD_GRENADE_SPLASH", level.weaponzmcymbalmonkey);

    if(isDefined(owner)) {
      self detonate(owner);
    } else {
      self detonate(undefined);
    }

    break;
  }

  if(isDefined(damagearea)) {
    damagearea delete();
  }
}

player_throw_cymbal_monkey(e_grenade, num_attractors, max_attract_dist, attract_dist_diff) {
  self endon(#"starting_monkey_watch", #"disconnect");

  if(isDefined(e_grenade)) {
    e_grenade endon(#"death");

    if(self laststand::player_is_in_laststand()) {
      if(isDefined(e_grenade.damagearea)) {
        e_grenade.damagearea delete();
      }

      e_grenade delete();
      return;
    }

    e_grenade ghost();
    e_grenade.angles = self.angles;
    e_grenade.mdl_monkey = util::spawn_model(e_grenade.model, e_grenade.origin, e_grenade.angles);
    e_grenade.mdl_monkey linkto(e_grenade);
    e_grenade.mdl_monkey thread monkey_cleanup(e_grenade);
    e_grenade.mdl_monkey playSound(#"hash_68402c92c838b7f7");
    clone = undefined;

    if(isDefined(level.cymbal_monkey_dual_view) && level.cymbal_monkey_dual_view) {
      e_grenade.mdl_monkey setvisibletoallexceptteam(level.zombie_team);
      clone = zm_clone::spawn_player_clone(self, (0, 0, -999), level.cymbal_monkey_clone_weapon, undefined);
      e_grenade.mdl_monkey.simulacrum = clone;
      clone zm_clone::clone_animate("idle");
      clone thread clone_player_angles(self);
      clone notsolid();
      clone ghost();
    }

    e_grenade thread watch_for_dud(clone);
    e_grenade thread watch_for_emp(clone);
    info = spawnStruct();
    info.sound_attractors = [];
    e_grenade waittill(#"stationary");

    if(isDefined(level.grenade_planted)) {
      self thread[[level.grenade_planted]](e_grenade, e_grenade.mdl_monkey);
    }

    if(isDefined(e_grenade)) {
      if(isDefined(clone)) {
        clone forceteleport(e_grenade.origin, e_grenade.angles);
        clone thread hide_owner(self);
        e_grenade thread proximity_detonate(self);
        clone show();
        clone setinvisibletoall();
        clone setvisibletoteam(level.zombie_team);
      }

      e_grenade resetmissiledetonationtime();
      playFXOnTag(level._effect[#"monkey_glow"], e_grenade.mdl_monkey, "tag_weapon");
      valid_poi = e_grenade is_on_navmesh(self);

      if(valid_poi && isDefined(e_grenade.var_45eaa114) && e_grenade.var_45eaa114) {
        wait 0.1;
        e_grenade zm_utility::create_zombie_point_of_interest(max_attract_dist, num_attractors, 10000);
        valid_poi = e_grenade zm_utility::create_zombie_point_of_interest_attractor_positions(attract_dist_diff, undefined, level.valid_poi_max_radius, 1);

        if(valid_poi) {
          e_grenade thread do_monkey_sound(info);
          e_grenade thread function_875fd1df();
          level.cymbal_monkeys[level.cymbal_monkeys.size] = e_grenade;
        } else {
          e_grenade zm_utility::deactivate_zombie_point_of_interest();
        }
      }

      if(!valid_poi) {
        e_grenade.script_noteworthy = undefined;
        level thread grenade_stolen_by_sam(e_grenade, clone);
      }

      return;
    }

    e_grenade.script_noteworthy = undefined;
    level thread grenade_stolen_by_sam(e_grenade, clone);
  }
}

private function_ab9a9770() {
  s_trace = groundtrace(self.origin + (0, 0, 70), self.origin + (0, 0, -100), 0, self);

  if(isDefined(s_trace[#"entity"])) {
    entity = s_trace[#"entity"];

    if(entity ismovingplatform()) {
      return true;
    }
  }

  return false;
}

function_2f2478f2() {
  v_orig = self.origin;
  queryresult = positionquery_source_navigation(self.origin, 0, level.valid_poi_max_radius, level.valid_poi_half_height, level.valid_poi_inner_spacing, level.valid_poi_radius_from_edges);

  if(queryresult.data.size) {
    foreach(point in queryresult.data) {
      height_offset = abs(self.origin[2] - point.origin[2]);

      if(height_offset > level.valid_poi_height) {
        continue;
      }

      if(zm_utility::check_point_in_enabled_zone(point.origin) && bullettracepassed(point.origin + (0, 0, 20), v_orig + (0, 0, 20), 0, self, undefined, 0, 0)) {
        self.origin = point.origin;
        return true;
      }
    }
  }

  return false;
}

grenade_stolen_by_sam(e_grenade, e_actor) {
  if(!isDefined(e_grenade.mdl_monkey)) {
    return;
  }

  direction = e_grenade.mdl_monkey.origin;
  direction = (direction[1], direction[0], 0);

  if(direction[1] < 0 || direction[0] > 0 && direction[1] > 0) {
    direction = (direction[0], direction[1] * -1, 0);
  } else if(direction[0] < 0) {
    direction = (direction[0] * -1, direction[1], 0);
  }

  players = getplayers();

  for(i = 0; i < players.size; i++) {
    if(isalive(players[i])) {
      players[i] playlocalsound(level.zmb_laugh_alias);
    }
  }

  playFXOnTag(level._effect[#"grenade_samantha_steal"], e_grenade.mdl_monkey, "tag_origin");
  e_grenade.mdl_monkey unlink();
  e_grenade.mdl_monkey movez(60, 1, 0.25, 0.25);
  e_grenade.mdl_monkey vibrate(direction, 1.5, 2.5, 1);
  e_grenade.mdl_monkey waittill(#"movedone");
  e_grenade.mdl_monkey delete();

  if(isDefined(e_actor)) {
    e_actor delete();
  }

  if(isDefined(e_grenade)) {
    if(isDefined(e_grenade.damagearea)) {
      e_grenade.damagearea delete();
    }

    e_grenade delete();
  }
}

monkey_cleanup(e_grenade) {
  self endon(#"death");

  while(true) {
    if(!isDefined(e_grenade)) {
      if(isDefined(self.dud) && self.dud) {
        wait 6;
      }

      if(isDefined(self.simulacrum)) {
        self.simulacrum delete();
      }

      zm_utility::self_delete();
      return;
    }

    waitframe(1);
  }
}

do_monkey_sound(info) {
  self endon(#"death");
  self.monk_scream_vox = 0;

  if(isDefined(level.grenade_safe_to_bounce)) {
    if(![
        [level.grenade_safe_to_bounce]
      ](self.owner, level.weaponzmcymbalmonkey)) {
      self playSound(#"zmb_vox_monkey_scream");
      self.monk_scream_vox = 1;
    }
  }

  if(!self.monk_scream_vox && level.musicsystem.currentplaytype < 4) {
    self playSound(#"hash_4509539f9e7954e2");
  }

  self playLoopSound(#"hash_4ac1d6c76c698e02");

  if(!self.monk_scream_vox) {
    self thread play_delayed_explode_vox();
  }

  waitresult = self waittill(#"explode");
  level notify(#"grenade_exploded", waitresult.position);
  self stoploopsound();
  monkey_index = -1;

  for(i = 0; i < level.cymbal_monkeys.size; i++) {
    if(!isDefined(level.cymbal_monkeys[i])) {
      monkey_index = i;
      break;
    }
  }

  if(monkey_index >= 0) {
    arrayremoveindex(level.cymbal_monkeys, monkey_index);
  }

  for(i = 0; i < info.sound_attractors.size; i++) {
    if(isDefined(info.sound_attractors[i])) {
      info.sound_attractors[i] notify(#"monkey_blown_up");
    }
  }
}

function_875fd1df() {
  mdl_monkey = self.mdl_monkey;
  mdl_monkey thread scene::play(#"cin_t8_monkeybomb_dance", mdl_monkey);

  while(isDefined(self)) {
    waitframe(1);
  }

  if(isDefined(mdl_monkey)) {
    mdl_monkey thread scene::stop();
  }
}

play_delayed_explode_vox() {
  wait 6.5;

  if(isDefined(self)) {
    self playSound(#"zmb_vox_monkey_explode");
  }
}

get_thrown_monkey() {
  self endon(#"starting_monkey_watch", #"disconnect");

  while(true) {
    waitresult = self waittill(#"grenade_fire");
    grenade = waitresult.projectile;
    weapon = waitresult.weapon;

    if(weapon == level.weaponzmcymbalmonkey) {
      grenade.use_grenade_special_long_bookmark = 1;
      grenade.grenade_multiattack_bookmark_count = 1;
      grenade.weapon = weapon;
      return grenade;
    }

    waitframe(1);
  }
}

monitor_zombie_groans(info) {
  self endon(#"explode");

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.attractor_array)) {
      waitframe(1);
      continue;
    }

    for(i = 0; i < self.attractor_array.size; i++) {
      if(!isinarray(info.sound_attractors, self.attractor_array[i])) {
        if(isDefined(self.origin) && isDefined(self.attractor_array[i].origin)) {
          if(distancesquared(self.origin, self.attractor_array[i].origin) < 250000) {
            if(!isDefined(info.sound_attractors)) {
              info.sound_attractors = [];
            } else if(!isarray(info.sound_attractors)) {
              info.sound_attractors = array(info.sound_attractors);
            }

            info.sound_attractors[info.sound_attractors.size] = self.attractor_array[i];
            self.attractor_array[i] thread play_zombie_groans();
          }
        }
      }
    }

    waitframe(1);
  }
}

play_zombie_groans() {
  self endon(#"monkey_blown_up", #"death");

  while(true) {
    if(isDefined(self)) {
      self playSound(#"zmb_vox_zombie_groan");
      wait randomfloatrange(2, 3);
      continue;
    }

    return;
  }
}

cymbal_monkey_exists() {
  return zm_weapons::is_weapon_included(level.weaponzmcymbalmonkey);
}

is_on_navmesh(e_player) {
  self endon(#"death");

  if(isDefined(e_player)) {
    e_player endon(#"death");
    e_origin = e_player.origin;
  } else {
    e_origin = self.origin;
  }

  if(ispointonnavmesh(self.origin, 60) == 1) {
    self.var_45eaa114 = 1;
    return true;
  }

  v_valid_point = getclosestpointonnavmesh(self.origin, 150, 12);

  if(isDefined(v_valid_point)) {
    var_3fb36683 = zm_utility::check_point_in_enabled_zone(v_valid_point, undefined, undefined);

    if(!(isDefined(var_3fb36683) && var_3fb36683)) {
      v_dir = vectornormalize(e_origin - self.origin);
      v_pos = self.origin + v_dir * 24;
      v_valid_point = getclosestpointonnavmesh(v_pos, 150, 12);

      if(isDefined(v_valid_point)) {
        var_3fb36683 = zm_utility::check_point_in_enabled_zone(v_valid_point, undefined, undefined);

        if(!(isDefined(var_3fb36683) && var_3fb36683)) {
          v_valid_point = undefined;
        }
      }
    }
  }

  if(isDefined(v_valid_point)) {
    self.origin = v_valid_point;

    if(isDefined(self.mdl_monkey)) {
      self.mdl_monkey.origin = self.origin;
      self.mdl_monkey clientfield::set("" + #"hash_60a7e5b79e8064a5", 1);
    }

    self.var_45eaa114 = 1;
    return true;
  }

  self.var_45eaa114 = 0;
  return false;
}