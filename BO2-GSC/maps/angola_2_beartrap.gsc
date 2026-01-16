/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_2_beartrap.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\_skipto;
#include maps\_scene;
#include maps\_anim;
#include maps\angola_2_beartrap;
#include maps\angola_stealth;
#include maps\angola_2_util;

give_player_beartrap() {
  level.player giveweapon("beartrap_sp");
  flag_set("player_has_beartraps");
  level.player setactionslot(1, "weapon", "beartrap_sp");
  level.player thread maps\angola_2_beartrap::beartrap_watch();
  level thread beartrap_helper_message();
  level thread moderate_number_of_beartraps();
  level.player thread beartrap_refill_think();
  level thread beartrap_mortar_plant_think();
  level.player.planting_beartrap_mortar = 0;

  if(isDefined(level.player_has_mortars) && level.player_has_mortars)
    level.player thread mortar_refill_think();
}

beartrap_ai_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  return n_damage;
}

beartrap_helper_message(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  screen_message_create(&"ANGOLA_2_BEARTRAP_HELPER");
  wait 4;
  screen_message_delete();
}

beartrap_watch() {
  self endon("death");
  level.num_beartrap_catches = 0;
  level.num_beartrap_challenge_kills = 10;

  while(true) {
    self waittill("grenade_fire", e_grenade, str_weapon_name);

    if(str_weapon_name == "beartrap_sp")
      e_grenade thread beartrap_triggered_think();
  }
}

beartrap_triggered_think() {
  self endon("trap_removed_to_make_room");
  level notify("beartrap_added", self);
  self thread beartrap_explosive_think();
  self.trap_mode = "TRAP_LOOKING_FOR_TARGET";

  while(true) {
    switch (self.trap_mode) {
      case "TRAP_LOOKING_FOR_TARGET":
        self beartrap_looking_for_target();
        break;
      case "TRAP_PULLING_IN_TARGET":
        self beartrap_pulling_in_target();

        if(self.trap_mode != "TRAP_CATCHES_TARGET")
          self.trap_mode = "TRAP_LOOKING_FOR_TARGET";

        break;
      case "TRAP_CATCHES_TARGET":
        self beartrap_catches_targes();
        return;
        break;
    }

    wait 0.05;
  }
}

beartrap_looking_for_target() {
  self.trap_target = undefined;
  can_see_trap_dist = 1000;
  can_see_trap_dot = 0.75;
  closest_dist = 999999;
  closest_ai = undefined;

  while(!isDefined(closest_ai)) {
    a_enemies = getaiarray("axis");

    foreach(ai_enemy in a_enemies) {
      dist = self beartrap_search_for_ai_victim(ai_enemy, can_see_trap_dist, can_see_trap_dot);

      if(dist > 0 && dist < closest_dist) {
        closest_ai = ai_enemy;
        closest_dist = dist;
      }
    }

    if(!isDefined(closest_ai)) {
      delay = randomfloatrange(0.1, 0.2);
      wait(delay);
    }
  }

  self.trap_target = closest_ai;
  self.trap_target.investigating_bear_trap = 1;
  self.trap_target notify("kill_patrol");
  self.trap_mode = "TRAP_PULLING_IN_TARGET";
}

beartrap_pulling_in_target() {
  self.trap_target endon("death");
  self.trap_target setgoalpos(self.origin);
  self.trap_target.goalradius = 42;
  self.trap_target waittill("goal");

  if(self.message)
    screen_message_delete();

  self.trap_target thread ai_caught_in_beartrap(self);
  self.trap_target.using_beartrap = 1;
  level notify("beartrap_triggered");
  self.trap_mode = "TRAP_CATCHES_TARGET";
}

bear_trap_closing_animations() {
  beartrap = spawn_anim_model("beartrap");
  beartrap.origin = self.origin;
  beartrap.angles = self.angles;
  self hide();
  playsoundatposition("exp_beartrap_clamp", self.origin);
  self anim_single(beartrap, "beartrap_snap_closed");
  self thread anim_loop(beartrap, "beartrap_closed_idle", "beartrap_stop_loop");
  self waittill_either("ai_caught_dead", "death");
  self remove_from_beartrap_array();
  self delete();
  beartrap thread cleanup_beartrap_script_model(30);
}

cleanup_beartrap_script_model(delay) {
  level.player endon("death");

  if(isDefined(delay))
    wait(delay);

  self notify("beartrap_stop_loop");
  self anim_stopanimscripted();
  self delete();
}

beartrap_catches_targes() {
  if(maps\angola_stealth::is_player_in_stealth_mode()) {
    wait 0.05;
    level thread maps\angola_stealth::patrol_alerted_find_player_quickly(20, 20);
    ai_goto_trap_radius = 2400;
    a_enemies = getaiarray("axis");

    foreach(ai_enemy in a_enemies) {
      if(isDefined(ai_enemy) && isalive(ai_enemy)) {
        if(!maps\angola_2_util::ent_is_launcher(ai_enemy) && !isDefined(ai_enemy.using_beartrap) && !isDefined(ai_enemy.investigating_bear_trap)) {
          if(distance2d(self.origin, ai_enemy.origin) < ai_goto_trap_radius)
            ai_enemy thread second_wave_investigate_beartrap(self);
        }
      }
    }
  }
}

ai_caught_in_beartrap(e_beartrap) {
  self endon("death");
  org = e_beartrap create_beartrap_align("org_trap", self);
  org anim_generic_reach_aligned(self, "ai_beartrap_caught");
  e_beartrap thread bear_trap_closing_animations();
  self.allowdeath = 1;

  if(e_beartrap.beartrap_exlposive == 1)
    e_beartrap thread primed_beartrap_explode(self);

  org anim_generic_aligned(self, "ai_beartrap_caught");
  org thread anim_generic_loop(self, "ai_beartrap_caught_loop");
  wait 4;
  e_beartrap notify("ai_caught_dead");

  if(!isDefined(e_beartrap.beartrap_exlposive) || !e_beartrap.beartrap_exlposive) {
    level.num_beartrap_catches = level.num_beartrap_catches + 1;
    self dodamage(self.health + 100, self.origin);
  }
}

primed_beartrap_explode(guy) {
  level.player endon("death");
  wait 4;
  level.num_beartrap_catches = level.num_beartrap_catches + 1;
  playfx(level._effect["def_explosion"], self.origin);
  playsoundatposition("exp_mortar", self.origin);

  if(isDefined(self.mortar_ref))
    self.mortar_ref delete();

  level thread ai_beartrap_explosive_radius(self, 400);
}

create_beartrap_align(str_align, e_user) {
  e_align = spawn("script_origin", self.origin);
  e_align.angles = e_user.angles;
  e_align thread wait_to_delete_beartrap_align(e_user);
  return e_align;
}

wait_to_delete_beartrap_align(e_user) {
  e_user waittill("death");
  self delete();
}

beartrap_alert_ai_to_player_soon(delay) {
  level endon("player_position_located");
  wait(delay);
  level notify("player_position_located");
}

beartrap_search_for_ai_victim(ai_enemy, in_range_distance, vis_dot) {
  if(isDefined(ai_enemy.investigating_bear_trap))
    return 0;

  dist_to_trap = distance(ai_enemy.origin, self.origin);

  if(dist_to_trap < in_range_distance) {
    v_ai_forward = anglestoforward(ai_enemy.angles);
    v_dir_to_trap = vectornormalize(self.origin - ai_enemy.origin);
    dot = vectordot(v_ai_forward, v_dir_to_trap);

    if(dot > vis_dot)
      return dist_to_trap;
  }

  return 0;
}

second_wave_investigate_beartrap(e_trap) {
  self endon("death");
  e_trap endon("death");
  ai_reached_trap_radius = 84;
  level notify("patrol_dont_check_player_fire");
  wait 0.2;
  rval = randomfloatrange(0, 100);

  if(rval < 100)
    self clear_run_anim();

  self setgoalpos(e_trap.origin);
  self.goalradius = ai_reached_trap_radius;
  self waittill("goal");
  self.goalradius = 512;
  self.animname = "stand_and_look_around";
  self set_run_anim("stand");
  at_trap_find_player_wait = 5;
  wait(at_trap_find_player_wait);
  level notify("player_position_located");
}

animate_the_bear_trap() {
}

beartrap_mortar_plant_think() {
  level.player endon("death");
  level endon("je_end_scene_started");
  level.a_beartraps = [];

  while(true) {
    n_dist_min = 128;
    e_beartrap_closest = undefined;
    level waittill("player_trying_to_plant");

    foreach(e_beartrap in level.a_beartraps) {
      if(isDefined(e_beartrap.message) && e_beartrap.message) {
        n_dist_between_player = distance(e_beartrap.origin, level.player.origin);

        if(n_dist_between_player < n_dist_min) {
          e_beartrap_closest = e_beartrap;
          n_dist_min = n_dist_between_player;
        }
      }
    }

    if(isDefined(e_beartrap_closest)) {
      e_beartrap_closest notify("end_plant_message");
      screen_message_delete();
      e_beartrap_closest.mortar_ref = play_plant_mortar_anim(e_beartrap_closest);
      total_mortars = level.player getweaponammostock("mortar_shell_dpad_sp") + level.player getweaponammoclip("mortar_shell_dpad_sp");

      if(total_mortars == 0)
        level.player takeweapon("mortar_shell_dpad_sp");
      else if(level.player getweaponammostock("mortar_shell_dpad_sp") > 0)
        level.player setweaponammostock("mortar_shell_dpad_sp", level.player getweaponammostock("mortar_shell_dpad_sp") - 1);
      else if(level.player getweaponammoclip("mortar_shell_dpad_sp") > 0)
        level.player setweaponammoclip("mortar_shell_dpad_sp", level.player getweaponammoclip("mortar_shell_dpad_sp") - 1);

      e_beartrap_closest.beartrap_exlposive = 1;
      arrayremovevalue(level.a_beartraps, e_beartrap_closest);
    }

    wait 0.05;
  }
}

beartrap_explosive_think() {
  self endon("end_plant_message");
  self endon("trap_removed_to_make_room");
  level endon("beartrap_triggered");
  self.beartrap_exlposive = 0;
  self.message = 0;
  arrayinsert(level.a_beartraps, self, level.a_beartraps.size);
  wait 1;

  while(true) {
    if(!does_player_have_mortar() && self.trap_mode != "TRAP_CATCHES_TARGET") {
      wait 0.05;
      continue;
    }

    in_message_range = 0;
    dist = distance(self.origin, level.player.origin);

    if(dist < 64) {
      forward = anglestoforward(level.player.angles);
      dir = vectornormalize(self.origin - level.player.origin);
      dot = vectordot(forward, dir);

      if(dot >= 0.0) {
        in_message_range = 1;

        if(!self.message) {
          screen_message_create(&"ANGOLA_2_PRIME_BEARTRAP_WITH_MORTAR");
          self.message = 1;
        }

        if(self.message && level.player usebuttonpressed())
          level notify("player_trying_to_plant");
      }
    }

    if(!in_message_range && self.message) {
      screen_message_delete();
      self.message = 0;
    }

    wait 0.05;
  }
}

ai_beartrap_explosive_radius(e_beartrap, radius) {
  num_ai_hit_by_trap = 0;
  a_ai = getaiarray("axis");

  if(isDefined(a_ai)) {
    for(i = 0; i < a_ai.size; i++) {
      e_ent = a_ai[i];
      dist = distance(e_beartrap.origin, e_ent.origin);

      if(dist < radius) {
        num_ai_hit_by_trap++;
        e_ent thread ai_beartrap_explosive_death(e_beartrap);
      }
    }

    radiusdamage(e_beartrap.origin, radius, 100, 50, level.player, "MOD_EXPLOSIVE");
  }

  if(num_ai_hit_by_trap >= 4)
    level notify("three_ai_hit_by_mortar_beartrap_explosion");
}

ai_beartrap_explosive_death(e_beartrap) {
  self endon("death");

  if(!isDefined(self.alreadylaunched)) {
    self.a.nodeath = 1;
    self.alreadylaunched = 1;
    self startragdoll(1);
    x = randomintrange(-30, 30);
    y = randomintrange(-30, 30);
    v_launch = (x, y, 100);
    vectornormalize(v_launch);
    v_launch = v_launch * 1.5;
    self launchragdoll(v_launch, "J_SpineUpper");
    level.num_beartrap_catches = level.num_beartrap_catches + 1;
    wait 2;
    self dodamage(self.health, self.origin, level.player, -1, "explosive");
  }
}

does_player_have_mortar() {
  a_weapons = level.player getweaponslist();

  foreach(str_weapon in a_weapons) {
    if(str_weapon == "mortar_shell_dpad_sp") {
      if(level.player getammocount(str_weapon) > 0)
        return true;
    }
  }

  return false;
}

play_plant_mortar_anim(beartrap) {
  level.player.planting_beartrap_mortar = 1;
  player_rig = spawn_anim_model("player_body_river");
  player_rig hide();
  mortar = spawn_anim_model("mortar");
  mortar hide();
  guys = [];
  guys[0] = player_rig;
  guys[1] = mortar;
  player_rig.origin = level.player.origin;
  player_rig.angles = level.player.angles;
  level.player disableweapons();
  level.player playerlinktoabsolute(player_rig, "tag_player");

  foreach(guy in guys)
  guy show();

  beartrap anim_single_aligned(guys, "mortar_plant");
  level.player unlink();
  level.player enableweapons();
  player_rig delete();
  level.player.planting_beartrap_mortar = 0;
  return mortar;
}

beartrap_refill_think() {
  level.player endon("death");

  while(true) {
    self waittill("ammo_refilled");
    b_beartraps = 0;
    a_weapons = self getweaponslist();

    foreach(str_weapon in a_weapons) {
      if(str_weapon == "beartrap_sp")
        b_beartraps = 1;
    }

    if(b_beartraps)
      self givemaxammo("beartrap_sp");
    else
      self giveweapon("beartrap_sp");
  }
}

mortar_refill_think() {
  level.player endon("death");

  while(true) {
    self waittill("ammo_refilled");
    b_mortars = 0;
    a_weapons = self getweaponslist();

    foreach(str_weapon in a_weapons) {
      if(str_weapon == "mortar_shell_dpad_sp")
        b_mortars = 1;
    }

    if(b_mortars)
      self givemaxammo("mortar_shell_dpad_sp");
    else
      self giveweapon("mortar_shell_dpad_sp");
  }
}

moderate_number_of_beartraps() {
  level.player endon("death");

  if(!isDefined(level.active_beartraps))
    level.active_beartraps = [];

  while(true) {
    level waittill("beartrap_added", trap);

    if(isDefined(trap)) {
      if(level.active_beartraps.size < 10)
        level.active_beartraps[level.active_beartraps.size] = trap;
      else
        level.active_beartraps = add_beartrap_into_full_array(trap);
    }
  }
}

remove_from_beartrap_array() {
  level.active_beartraps = trap_array_remove(level.active_beartraps, self);
  screen_message_delete();
}

add_beartrap_into_full_array(trap) {
  level.active_beartraps[0] notify("trap_removed_to_make_room");

  if(isDefined(level.active_beartraps[0].mortar_ref))
    level.active_beartraps[0].mortar_ref delete();

  level.active_beartraps[0] delete();
  a_temp = [];

  for(i = 1; i <= level.active_beartraps.size; i++)
    a_temp[a_temp.size] = level.active_beartraps[i];

  a_temp[9] = trap;
  return a_temp;
}

trap_array_remove(a_array, e_ent) {
  a_temp = [];
  removed_index = undefined;

  for(i = 0; i < a_array.size; i++) {
    if(a_array[i] == e_ent)
      removed_index = i;
  }

  for(i = 0; i < a_array.size; i++) {
    if(i < removed_index) {
      if(a_array[i] != e_ent)
        a_temp[a_temp.size] = a_array[i];

      continue;
    }

    a_temp[a_temp.size] = a_array[i + 1];
  }

  return a_temp;
}