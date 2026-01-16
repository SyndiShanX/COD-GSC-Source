/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_utility.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\_skipto;
#include maps\_scene;
#include maps\_anim;
#include maps\_dialog;
#include maps\_drones;
#include maps\angola_riverbed;
#include maps\angola_savannah;
#include maps\_challenges_sp;
#include maps\_mpla_unita;
#include animscripts\shared;
#include maps\_mortar;

level_init_flags() {
  flag_init("show_introscreen_title");
  flag_init("end_angola");
  maps\angola_riverbed::init_flags();
  maps\angola_savannah::init_flags();
}

skipto_setup() {
  skipto = level.skipto_point;

  if(skipto == "riverbed_intro") {
    return;
  }
  flag_set("riverbed_player_intro_done");

  if(skipto == "riverbed") {
    return;
  }
  if(skipto == "savannah_start") {
    return;
  }
  flag_set("savannah_brim_reached");

  if(skipto == "savannah_hill") {
    return;
  }
  if(skipto == "savannah_finish")
    return;
}

setup_objectives() {
  level.obj_start = register_objective(&"ANGOLA_OBJ_START");
  level.obj_follow_buffel = register_objective(&"ANGOLA_OBJ_FOLLOW_BUFFEL");
  level.obj_destroy_mortar_crew = register_objective(&"ANGOLA_OBJ_DESTROY_MORTAR");
  level.obj_destroy_first_wave = register_objective(&"ANGOLA_OBJ_DESTROY_FIRST_WAVE");
  level.obj_destroy_technical = register_objective(&"ANGOLA_OBJ_DESTROY_TECHNICAL");
  level.obj_destroy_second_wave = register_objective(&"ANGOLA_OBJ_DESTROY_SECOND_WAVE");
  level.obj_get_to_buffel = register_objective(&"ANGOLA_OBJ_GET_TO_BUFFEL");
  level.obj_lockbreaker = register_objective("");
  level thread angola_objectives();
}

angola_objectives() {
  while(!isDefined(level.savimbi))
    wait 0.05;

  flag_wait("riverbed_player_intro_done");
  wait 3;
  set_objective(level.obj_start);
  set_objective(level.obj_start, undefined, "done");
  flag_wait("savimbi_rally_done");
  set_objective(level.obj_follow_buffel, level.savimbi, "follow");
  flag_wait("savannah_brim_reached");
  set_objective(level.obj_follow_buffel, level.savimbi, "delete");
}

setup_challenges() {
  wait_for_first_player();
  level.player thread maps\_challenges_sp::register_challenge("machetegib", maps\angola_savannah::challenge_machete_gibs);
  level.player thread maps\_challenges_sp::register_challenge("mortarkills", maps\angola_savannah::challenge_mortar_kills);
  level.player thread maps\_challenges_sp::register_challenge("tankkills", maps\angola_savannah::challenge_tank_kills);
}

blackscreen(fadein, stay, fadeout) {
  blackscreen = newhudelem();
  blackscreen.alpha = 0;
  blackscreen.horzalign = "fullscreen";
  blackscreen.vertalign = "fullscreen";
  blackscreen setshader("black", 640, 480);

  if(fadein > 0)
    blackscreen fadeovertime(fadein);

  blackscreen.alpha = 1;
  wait(stay);

  if(fadeout > 0)
    blackscreen fadeovertime(fadeout);

  blackscreen.alpha = 0;
  blackscreen destroy();
}

init_fight(str_node, str_friend, str_enemy) {
  level.a_nd_engage = getnodearray(str_node, "targetname");

  foreach(node in level.a_nd_engage)
  node.open = 1;

  level.a_sp_friend = getentarray(str_friend, "targetname");
  level.a_sp_enemy = getentarray(str_enemy, "targetname");
}

create_fight(e_friend, e_enemy, b_start_spawn, str_noteworthy) {
  if(!isDefined(b_start_spawn))
    b_start_spawn = 0;

  if(!isDefined(e_enemy)) {
    if(b_start_spawn)
      n_allowed_fights = 9;
    else
      n_allowed_fights = 6;

    current_enemy_fighters = getentarray(level.a_sp_enemy[0].targetname + "_ai", "targetname");

    if(current_enemy_fighters.size <= n_allowed_fights) {
      sp_enemy = level.a_sp_enemy[randomint(level.a_sp_enemy.size)];

      if(distance2dsquared(sp_enemy.origin, level.player.origin) < 250000) {
        if(!within_fov(level.player.origin, level.player.angles, sp_enemy.origin, cos(100)))
          e_enemy = sp_enemy spawn_ai(1);
        else
          return;
      } else
        e_enemy = sp_enemy spawn_ai(1);
    } else
      return;

    if(isDefined(e_enemy)) {
      if(isDefined(str_noteworthy))
        e_enemy.script_noteworthy = str_noteworthy;

      if(randomint(100) > 60) {
        e_enemy.script_string = "machete";
        e_enemy maps\_mpla_unita::setup_mpla();
      }

      e_enemy setthreatbiasgroup("enemy_dancer");
      e_enemy thread magic_bullet_shield();
    }
  }

  if(!isDefined(e_friend)) {
    if(level.a_sp_friend.size) {
      while(!isDefined(e_friend)) {
        sp_friendly = level.a_sp_friend[randomint(level.a_sp_friend.size)];

        if(!within_fov(level.player.origin, level.player.angles, sp_friendly.origin, cos(100)) && distance2dsquared(sp_friendly.origin, level.player.origin) > 250000)
          e_friend = sp_friendly spawn_ai(1);

        wait 0.05;
      }
    }

    if(isDefined(e_friend))
      e_friend thread setup_friendly_dancer();
  }

  nd_e_goal = _get_fight_node();

  if(isDefined(nd_e_goal) && isDefined(e_enemy) && isDefined(e_friend)) {
    e_enemy.e_opp = e_friend;
    e_friend.e_opp = e_enemy;
    nd_f_goal = getnode(nd_e_goal.target, "targetname");

    e_enemy thread _fight_think_debug(nd_e_goal, nd_f_goal);

    e_enemy thread _fight_think(nd_e_goal);
    e_friend thread _fight_think(nd_f_goal);
  } else {
    if(isDefined(e_enemy) && isalive(e_enemy)) {
      e_enemy stop_magic_bullet_shield();
      e_enemy die();
    }

    if(isDefined(e_friend) && isalive(e_friend)) {
      e_friend stop_magic_bullet_shield();
      e_friend die();
    }

    wait 1;
  }
}

setup_friendly_dancer() {
  self endon("death");
  self setthreatbiasgroup("friendly_dancer");
  self thread magic_bullet_shield();
}

cleanup_fight(str_name, str_key, n_delay) {
  if(isDefined(n_delay))
    wait(n_delay);

  a_fighter_name = getentarray(str_name, str_key);

  foreach(fighter in a_fighter_name) {
    if(isDefined(fighter)) {
      fighter stop_fighter_magic_bullet_shield();
      fighter kill(fighter.origin, level.player);
    }

    wait(randomfloatrange(0.1, 0.3));
  }
}

enemy_melee_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(!isalive(self))
    return n_damage;

  new_damage = n_damage;

  if(e_attacker == level.player)
    return new_damage;
  else if(self.a.pose != "back") {
    if(isai(e_inflictor)) {
      savimbi = getent("savimbi", "targetname");

      if(e_inflictor != savimbi)
        n_damage = int(n_damage / 4);
      else
        return new_damage;
    }
  } else if(isDefined(self.favoriteenemy) && e_attacker == self.favoriteenemy && isDefined(self.melee))
    return 0;

  return new_damage;
}

_get_fight_node() {
  vh_lead_buffel = getent("savimbi_buffel", "targetname");

  for(i = 0; i < level.a_nd_engage.size; i++) {
    nd_eval = level.a_nd_engage[i];
    level.a_nd_engage[i].valid = 1;
  }

  a_valid_nodes = [];

  for(i = 0; i < level.a_nd_engage.size; i++) {
    if(level.a_nd_engage[i].open && level.a_nd_engage[i].valid)
      a_valid_nodes[a_valid_nodes.size] = level.a_nd_engage[i];
  }

  nd_goal = undefined;

  if(a_valid_nodes.size) {
    nd_goal = a_valid_nodes[randomint(a_valid_nodes.size)];
    nd_goal.open = 0;
  }

  return nd_goal;
}

_fight_node_cooldown() {
  wait 10;
  self.open = 1;
}

_fight_think_debug(nd_goal, nd_f_goal) {
  self endon("death");
  self.e_opp endon("death");

  while(true) {
    recordline(self.e_opp.origin, nd_f_goal.origin, (1, 0, 0), "Script", self);
    recordline(self.origin, nd_goal.origin, (1, 0, 0), "Script", self);
    recordline(self.origin, self.e_opp.origin, (1, 1, 1), "Script", self);
    recordenttext("M", self, (1, 1, 1), "Script");
    recordenttext("M", self.e_opp, (1, 1, 1), "Script");

    if(isDefined(nd_goal.open))
      record3dtext(nd_goal.open, nd_goal.origin, (1, 1, 1), "Script", self);

    if(isDefined(nd_f_goal.open))
      record3dtext(nd_f_goal.open, nd_f_goal.origin, (1, 1, 1), "Script", self);

    wait 0.05;
  }

}

_init_fighter() {
  self endon("death");
  self ent_flag_init("ready_for_fight");
  self ent_flag_init("engaged", 1);
  self.goalradius = 32;

  if(self.team == "allies")
    self.health = 300;

  if(isalive(self.e_opp))
    self.favoriteenemy = self.e_opp;

  self thread _player_nearby_watcher();
  self disable_long_death();
  self.pathenemyfightdist = 0;
  self.pathenemylookahead = 0;
  self.ignoresuppression = 1;
  self.overrideactordamage = ::enemy_melee_damage_override;
}

_release_fighter() {
  self ent_flag_clear("ready_for_fight");
  self ent_flag_clear("engaged");
  self.favoriteenemy = undefined;
  self.overrideactordamage = undefined;
}

_fight_think(nd_goal) {
  self _init_fighter();

  if(!within_fov(level.player.origin, level.player.angles, nd_goal.origin, cos(100)))
    self teleport(nd_goal.origin, nd_goal.angles);

  self thread _fight_get_to_my_node(nd_goal);
  self stop_magic_bullet_shield();

  if(isalive(self.e_opp)) {
    self thread _opponent_death_watcher();
    self waittill_any("death", "opp_death", "player_nearby");
  }

  nd_goal.open = 1;

  if(isalive(self))
    self _release_fighter();

  wait 0.2;

  if(!(isDefined(self.hunting_player) && self.hunting_player)) {
    if(isDefined(self.melee))
      self thread _random_death(6);
    else
      self thread _random_death();
  }
}

_fight_get_to_my_node(nd_goal) {
  self endon("death");
  self setgoalnode(nd_goal);
  self waittill("goal");
  self ent_flag_set("ready_for_fight");
}

_opponent_death_watcher() {
  self endon("death");
  self endon("player_nearby");
  self.e_opp waittill("death");
  self notify("opp_death");
}

_player_nearby_watcher() {
  self endon("death");

  if(self.team != "allies") {
    return;
  }
  while(true) {
    if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 40000) {
      self notify("player_nearby");

      if(self.team == "axis")
        self.e_opp notify("player_nearby");

      return;
    }

    wait 0.2;
  }
}

_random_death(offset, b_short_death) {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(offset))
    wait(randomfloatrange(5.0, 7.0) + offset);
  else if(isDefined(b_short_death) && b_short_death)
    wait(randomfloatrange(1.0, 1.5));
  else if(isDefined(self.team == "allies") && (isDefined(self.targetname) && issubstr(self.targetname, "brim_")))
    wait 0.5;
  else
    wait(randomfloatrange(5.0, 7.0));

  if(isDefined(self) && isalive(self))
    self kill();
}

equip_machete() {
  self animscripts\shared::placeweaponon(self.weapon, "none");
  self.melee_weapon = spawn("script_model", self gettagorigin("tag_weapon_right"));
  self.melee_weapon.angles = self gettagangles("tag_weapon_right");
  self.melee_weapon setmodel("t6_wpn_machete_prop");
  self.melee_weapon linkto(self, "tag_weapon_right");
}

unequip_machete() {
  self animscripts\shared::placeweaponon(self.weapon, "right");
  self.melee_weapon delete();
}

equip_savimbi_machete() {
  self.melee_weapon = spawn("script_model", self gettagorigin("tag_weapon_left"));
  self.melee_weapon.angles = self gettagangles("tag_weapon_left");
  self.melee_weapon setmodel("t6_wpn_machete_prop");
  self.melee_weapon linkto(self, "tag_weapon_left");
}

unequip_savimbi_machete() {
  if(isDefined(self.melee_weapon))
    self.melee_weapon delete();
}

unequip_savimbi_machete_battle() {
  self detach("t6_wpn_machete_prop", "tag_weapon_chest");
}

_drop_machete_on_death() {
  self waittill("death");
  melee_weapon = self.melee_weapon;
  melee_weapon unlink();
  melee_weapon physicslaunch();
  wait 15;
  melee_weapon delete();
}

#using_animtree("generic_human");

load_buffel(b_less_full, real_gunner) {
  if(!isDefined(real_gunner))
    real_gunner = 0;

  if(!issubstr(self.vehicletype, "buffel")) {
    return;
  }
  if(self.riders.size > 0) {
    return;
  }
  self.riders = [];

  if(self.vehicletype == "apc_buffel")
    n_vehicle_size = level.vehicle_aianims["apc_buffel"].size - 1;
  else
    n_vehicle_size = level.vehicle_aianims["apc_buffel"].size;

  for(i = 0; i < n_vehicle_size; i++) {
    if(i > 0 && i < 9 && isDefined(b_less_full)) {
      continue;
    }
    if((self.vehicletype == "apc_buffel_gun_turret" || self.vehicletype == "apc_buffel_gun_turret_nophysics") && (i == 5 || i == 6)) {
      continue;
    }
    if((self.targetname == "savimbi_buffel" || self.targetname == "convoy_destroy_2" || self.targetname == "buffel_mortar" || self.targetname == "convoy_destroy_1" || self.targetname == "riverbed_convoy_buffel") && (i > 0 && i < 9)) {
      continue;
    }
    if(real_gunner && i == 9) {
      sp_gunner_spawner = getent("buffel_gunner", "targetname");
      ai_buffel_gunner = simple_spawn_single(sp_gunner_spawner, ::buffel_gunner, self, level.vehicle_aianims["apc_buffel"][i].sittag);
      self.riders[self.riders.size] = ai_buffel_gunner;
      continue;
    }

    m_rider = self create_friendly_model_actor(i);
    m_rider useanimtree(#animtree);
    m_rider linkto(self, level.vehicle_aianims["apc_buffel"][i].sittag);
    m_rider.seat = i;
    v_origin = self gettagorigin(level.vehicle_aianims["apc_buffel"][i].sittag);
    v_angles = self gettagangles(level.vehicle_aianims["apc_buffel"][i].sittag);
    anim_ride = level.vehicle_aianims["apc_buffel"][i].idle;
    m_rider animscripted("ride_buffel_" + i, v_origin, v_angles, anim_ride);
    self.riders[self.riders.size] = m_rider;
  }
}

unload_buffel() {
  if(!issubstr(self.vehicletype, "buffel")) {
    return;
  }
  foreach(m_rider in self.riders) {
    if(isDefined(m_rider))
      m_rider delete();
  }
}

buffel_gunner(vh_to_enter, str_seat_tag) {
  self enter_vehicle(vh_to_enter, str_seat_tag);
  self thread magic_bullet_shield();
}

load_gaz66(b_less_full) {
  if(!issubstr(self.vehicletype, "gaz66")) {
    return;
  }
  self.riders = [];
  n_random_max = 1;

  for(i = 0; i < n_random_max; i++) {
    m_rider = create_friendly_model_actor();
    m_rider useanimtree(#animtree);
    m_rider linkto(self, level.vehicle_aianims["truck_gaz66_cargo_doors"][i].sittag);
    v_origin = self gettagorigin(level.vehicle_aianims["truck_gaz66_cargo_doors"][i].sittag);
    v_angles = self gettagangles(level.vehicle_aianims["truck_gaz66_cargo_doors"][i].sittag);
    anim_ride = % ai_crew_gaz66_driver_idle;
    m_rider animscripted("ride_gaz66_" + i, v_origin, v_angles, anim_ride);
    self.riders[self.riders.size] = m_rider;
  }
}

unload_gaz66() {
  if(self.vehicletype != "truck_gaz66_cargo") {
    return;
  }
  foreach(m_rider in self.riders)
  m_rider delete();
}

destroy_buffel() {
  self.fire_turret = 0;
  playfxontag(getfx("buffel_explode"), self, "tag_body");
  self notify("stop_fire");
  self unload_buffel();
}

create_friendly_model_actor(index) {
  sp_model = getent("post_heli_friendly", "targetname");

  if(isDefined(self.targetname) && self.targetname == "convoy_destroy_1" && index == 0) {
    drone = getent("drone_name", "targetname");
    sp_model.script_friendname = drone.script_noteworthy;
  } else if(isDefined(self.targetname) && self.targetname == "convoy_destroy_2" && index == 0) {
    drone = getent("drone_name", "targetname");
    sp_model.script_friendname = drone.script_string;
  } else
    sp_model.script_friendname = undefined;

  m_actor = sp_model spawn_drone(1);
  return m_actor;
}

create_enemy_model_actor() {
  sp_model = getent("post_heli_enemy", "targetname");
  m_actor = sp_model spawn_drone(1);
  return m_actor;
}

savimbi_setup() {
  self attach("t6_wpn_launch_mm1_world", "tag_weapon_right");
  self set_ignoreme(1);
  self.a.allow_sidearm = 0;
  self.disableaivsaimelee = 1;
}

savimbi_fire_mgl_left(savimbi) {
  v_start = savimbi gettagorigin("tag_flash");
  fire_node = getent("mgl_fire_left", "targetname");
  magicbullet("mgl_sp", v_start, fire_node.origin);
}

savimbi_fire_mgl_right(savimbi) {
  v_start = savimbi gettagorigin("tag_flash");
  fire_node = getent("mgl_fire_right", "targetname");
  magicbullet("mgl_sp", v_start, fire_node.origin);
}

savimbi_fire_mgl_forward(savimbi) {
  v_start = savimbi gettagorigin("tag_flash");
  fire_node = getent("mgl_fire_forward", "targetname");
  magicbullet("mgl_sp", v_start, fire_node.origin);
}

player_convoy_watch(str_flag) {
  vh_lead_buffel = self;

  while(!flag(str_flag)) {
    if(!flag("player_in_helicopter")) {
      n_player_x = level.player.origin[0];
      n_player_y = level.player.origin[1];
      n_buffel_x = vh_lead_buffel.origin[0];
      n_buffel_y = vh_lead_buffel.origin[1];

      if(!flag("savannah_brim_reached")) {
        distx_max = 1000;
        distx_death = 1400;
        disty_min = 1800;
        disty_max = 1950;
        disty_death = 2100;
      } else if(flag("savannah_brim_reached") && flag("reset_distance_fail")) {
        distx_max = 2800;
        distx_death = 3000;
        disty_min = 1800;
        disty_max = 1950;
        disty_death = 2100;
      } else {
        distx_max = 1750;
        distx_death = 2000;
        disty_min = 1800;
        disty_max = 1950;
        disty_death = 2100;
      }

      if(n_player_x > n_buffel_x + distx_max || n_player_x < n_buffel_x - 2050 || n_player_y > n_buffel_y + disty_max || n_player_y < n_buffel_y - disty_max) {
        if(n_player_x < n_buffel_x - 2050)
          missionfailedwrapper_nodeath(&"ANGOLA_ABANDON_FAIL");
        else {
          level.player dodamage(60, vh_lead_buffel.origin + vectorscale((1, 0, 0), 3000.0));
          wait(randomfloatrange(0.1, 0.2));
        }
      } else if(n_player_x > n_buffel_x + distx_death || n_player_x < n_buffel_x - distx_death || n_player_y > n_buffel_y + disty_death || n_player_y < n_buffel_y - disty_death) {
        if(n_player_x < n_buffel_x - distx_death) {
        } else if(n_player_x > n_buffel_x + distx_death) {
          level.player dodamage(90, vh_lead_buffel.origin + vectorscale((1, 0, 0), 3000.0));
          wait(randomfloatrange(0.1, 0.2));
        } else
          level.player kill();
      } else if(n_player_x > n_buffel_x + 1600 || n_player_x < n_buffel_x - 1900 || n_player_y > n_buffel_y + disty_min || n_player_y < n_buffel_y - disty_min) {
        if(n_player_y > n_buffel_y + disty_min)
          level thread set_fail_mortars(1);
        else if(n_player_y < n_buffel_y - disty_min)
          level thread set_fail_mortars(0);

        level thread savimbi_say_convoy_warning();
        flag_set("fail_mortars");

        if(!flag("strafe_hint_active"))
          screen_message_create(&"ANGOLA_CONVOY_WARNING");

        wait(randomfloatrange(2, 2.5));
      } else if(flag("fail_mortars") && !flag("strafe_hint_active")) {
        flag_clear("fail_mortars");
        screen_message_delete();
      }
    }

    wait 0.1;
  }
}

prep_savimbi_nag_array() {
  level.savimbi_nag = [];
  level.savimbi_nag[0] = "savi_you_should_stay_with_0";
  level.savimbi_nag[1] = "savi_where_are_you_going_0";
  level.savimbi_nag[2] = "savi_you_cannot_leave_the_0";
  level.savimbi_nag[3] = "savi_stay_close_protect_0";
  level.savimbi_nag[4] = "savi_you_must_stay_close_0";
  level.savimbi_nag[5] = "savi_there_is_strength_in_0";
  level.savimbi_nag[6] = "savi_do_not_abandon_the_c_0";
  level.savimbi_nag[7] = "savi_you_are_too_far_from_0";
}

savimbi_say_convoy_warning() {
  if(!flag("fail_mortars")) {
    savimbi = level.savimbi;

    if(level.savimbi_nag.size) {
      index = randomintrange(0, level.savimbi_nag.size - 1);
      level.savimbi say_dialog(level.savimbi_nag[index]);
      arrayremoveindex(level.savimbi_nag, index);
    }
  }
}

set_fail_mortars(n_side) {
  if(flag("fail_mortars"))
    return;
  else
    flag_set("fail_mortars");

  if(n_side) {
    switch (level.mortar_fail) {
      case 1:
        a_mortars = getstructarray("mortar_savannah_hill_left", "targetname");
        break;
      case 2:
        a_mortars = getstructarray("mortar_savannah_left", "targetname");
        break;
      default:
        a_mortars = getstructarray("mortar_savannah_start_left", "targetname");
        break;
    }
  } else {
    switch (level.mortar_fail) {
      case 1:
        a_mortars = getstructarray("mortar_savannah_hill_right", "targetname");
        break;
      case 2:
        a_mortars = getstructarray("mortar_savannah_right", "targetname");
        break;
      default:
        a_mortars = getstructarray("mortar_savannah_start_right", "targetname");
        break;
    }
  }

  while(flag("fail_mortars")) {
    e_mortar = a_mortars[randomint(a_mortars.size)];
    e_mortar thread maps\_mortar::mortar_boom(e_mortar.origin, 0.15, 1, 200, getfx("mortar_savannah"), 1);
    wait(randomfloatrange(0.5, 1.5));
  }
}

watch_savannah_deep_fail() {
  level endon("savannah_player_boarded_buffel");
  deep_fail_trig = getent("savannah_deep_fail", "targetname");
  deep_fail_trig waittill("trigger");
  level.player kill();
}

watch_savannah_deep_warn() {
  level endon("savannah_player_boarded_buffel");
  level thread watch_savannah_deep_fail();
  t_deep_warn = getent("savannah_deep_warn", "targetname");

  while(!flag("savannah_player_boarded_buffel")) {
    if(level.player istouching(t_deep_warn)) {
      while(level.player istouching(t_deep_warn)) {
        if(!flag("strafe_hint_active"))
          screen_message_create(&"ANGOLA_CONVOY_WARNING");

        wait 0.05;
      }

      if(!flag("strafe_hint_active") && !flag("fail_mortars"))
        screen_message_delete();
    }

    wait 0.05;
  }
}

watch_savannah_short_fail() {
  level endon("savannah_start_hill");
  fail_trig = getent("savannah_short_fail", "targetname");
  fail_trig waittill("trigger");
  missionfailedwrapper_nodeath(&"ANGOLA_ABANDON_FAIL");
}

watch_savannah_short_warn() {
  level endon("savannah_start_hudson");
  level thread watch_savannah_short_fail();
  t_warn = getent("savannah_short_warn", "targetname");

  while(!flag("savannah_start_hudson")) {
    if(level.player istouching(t_warn)) {
      if(!flag("strafe_hint_active"))
        screen_message_create(&"ANGOLA_CONVOY_WARNING");
    } else if(!flag("strafe_hint_active") && !flag("fail_mortars"))
      screen_message_delete();

    wait 0.05;
  }
}

create_after_strafe_fights(n_heli_runs) {
  switch (n_heli_runs) {
    case 1:
      a_spots = getstructarray("post_heli_fight_spot", "targetname");
      break;
    case 2:
      a_spots = getstructarray("post_heli_fight_spot2", "targetname");
      break;
    case 4:
      a_spots = getstructarray("push_fight_spot", "targetname");
      break;
    default:
      return;
      break;
  }

  goal_array = getnodearray("final_push_goal", "script_noteworthy");
  a_scenes[0] = "_01";
  a_scenes[1] = "_02";
  a_scenes[2] = "_03";
  a_scenes[3] = "_04";
  a_scenes[4] = "_05";
  v_angles = level.player getplayerangles();
  v_check = level.player.origin + anglestoforward(v_angles) * 500;
  scene = array_randomize(a_scenes);
  align = get_array_of_closest(v_check, a_spots, undefined, 3);
  a_old_align = getentarray("fight_align", "script_noteworthy");

  for(i = 0; i < a_old_align.size; i++)
    a_old_align[i] delete();

  for(i = 0; i < 3; i++) {
    level thread _fight_vignette(align[i], scene[i], goal_array);
    wait 0.05;
  }
}

_fight_vignette(align, scene, goal_array) {
  sp_enemy = getent("post_heli_enemy", "targetname");
  sp_friend = getent("post_heli_friendly", "targetname");
  m_align = spawn("script_origin", align.origin);

  if(isDefined(align.angles))
    m_align.angles = (align.angles[0], randomint(360), align.angles[2]);
  else
    m_align.angles = (0, randomint(360), 0);

  m_align.targetname = "hill_fight" + scene;
  m_align.script_noteworthy = "fight_align";
  add_scene_properties("hill_fight" + scene, m_align.targetname);
  enemy = sp_enemy spawn_ai(1);

  if(isDefined(enemy)) {
    enemy.animname = "hill_fight_mpla" + scene;
    enemy.script_string = "machete_scripted";
    enemy maps\_mpla_unita::setup_mpla();
    enemy setthreatbiasgroup("enemy_dancer");
    enemy.a.deathforceragdoll = 1;
  }

  friend = sp_friend spawn_ai(1);

  if(isDefined(friend)) {
    friend.animname = "hill_fight_unita" + scene;
    friend.script_string = "machete_scripted";
    friend maps\_mpla_unita::setup_mpla();
    friend.a.deathforceragdoll = 1;
  }

  if(isDefined(enemy) && isDefined(friend)) {
    level thread run_scene("hill_fight" + scene);
    enemy thread _fight_vignette_think("hill_fight" + scene);
    friend thread _fight_vignette_think("hill_fight" + scene);
    scene_wait("hill_fight" + scene);

    if(isalive(enemy)) {
      enemy notify("stop_think");
      enemy thread _random_death();
    }

    if(isalive(friend)) {
      enemy notify("stop_think");

      if(friend.animname == "hill_fight_unita_03")
        friend kill();
      else {
        friend thread _random_death();

        if(isDefined(goal_array)) {
          wait 0.5;
          friend set_goal_node(goal_array[randomintrange(0, goal_array.size)]);
        }
      }
    }
  } else {
    if(isDefined(enemy) && isalive(enemy))
      enemy die();

    if(isDefined(friend) && isalive(friend))
      friend die();

    wait 1;
  }
}

_fight_vignette_think(scene) {
  self endon("stop_think");
  self waittill("death");
  end_scene(scene);
}

attach_weapon() {
  weaponmodel = "t6_wpn_ar_ak47_world";
  self attach(weaponmodel, "tag_weapon_right");
  self useweaponhidetags(self.weapon);
}

#using_animtree("fxanim_props");

animate_grass(is_default) {
  grass_array = getentarray("fxanim_heli_grass_flyover", "targetname");
  far_grass_array = getentarray("fxanim_heli_grass_flyover_2", "targetname");

  foreach(grass in grass_array) {
    grass useanimtree(#animtree);

    if(is_default) {
      grass notify("stop_loop");
      grass thread anim_loop(grass, "grass_standing_amb_loop", "stop_loop", "fxanim_props");
      continue;
    }

    grass thread animate_grass_single();
  }

  foreach(grass in far_grass_array) {
    grass useanimtree(#animtree);

    if(is_default) {
      grass notify("stop_loop");
      grass thread anim_loop(grass, "grass_standing_amb_loop", "stop_loop", "fxanim_props");
      continue;
    }

    grass delay_thread(0.4, ::animate_grass_single);
  }
}

animate_grass_single() {
  self notify("stop_loop");
  self anim_single(self, "grass_heli_fly_over", "fxanim_props");
  level thread animate_grass(1);
}

stop_savannah_grass() {
  grass_array = getentarray("fxanim_heli_grass_flyover", "targetname");

  foreach(grass in grass_array)
  grass notify("stop_loop");

  grass_array = getentarray("fxanim_heli_grass_flyover_2", "targetname");

  foreach(grass in grass_array)
  grass notify("stop_loop");
}

animate_heli_grass(is_default) {
  grass_array = getentarray("fxanim_heli_grass_land", "targetname");

  foreach(grass in grass_array) {
    grass useanimtree(#animtree);
    grass notify("stop_loop");

    if(is_default) {
      grass thread anim_loop(grass, "grass_standing_amb_loop", "stop_loop", "fxanim_props");
      continue;
    }

    grass thread anim_loop(grass, "grass_heli_fly_over_loop", "stop_loop", "fxanim_props");
  }
}

victory_grass() {
  static_grass = getentarray("static_heli_grass_land", "targetname");

  foreach(grass in static_grass)
  grass delete();

  cloth_grass = getentarray("fxanim_heli_grass_land", "targetname");

  foreach(grass in cloth_grass)
  grass show();
}

hide_victory_grass() {
  cloth_grass = getentarray("fxanim_heli_grass_land", "targetname");

  foreach(grass in cloth_grass)
  grass hide();
}

turn_on_convoy_headlights() {
  a_vh = getentarray("convoy", "script_noteworthy");

  foreach(vehicle in a_vh)
  vehicle setclientflag(10);
}

delete_array(value, key) {
  stuff = getentarray(value, key);

  for(i = 0; i < stuff.size; i++)
    stuff[i] delete();
}

delete_struct_array(value, key) {
  stuff = getstructarray(value, key);

  for(i = 0; i < stuff.size; i++)
    stuff[i] structdelete();
}

refill_player_clip() {
  a_str_weapons = level.player getweaponslistprimaries();

  foreach(str_weapon in a_str_weapons) {
    level.player givemaxammo(str_weapon);
    level.player setweaponammoclip(str_weapon, weaponclipsize(str_weapon));
  }
}

savannah_player_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  damage_modifier = get_difficulty_damage_modifier();

  if(isDefined(str_weapon) && (str_weapon == "buffel_gun_turret" || str_weapon == "eland_turret"))
    return 0;

  if(!flag("fail_stop_protection")) {
    if(str_means_of_death == "MOD_PROJECTILE_SPLASH" || str_means_of_death == "MOD_PROJECTILE")
      n_damage = int(n_damage / (damage_modifier * 4));
    else
      n_damage = int(n_damage / damage_modifier);
  } else
    return n_damage * 3;

  return n_damage;
}

get_difficulty_damage_modifier() {
  str_difficulty = getdifficulty();

  switch (str_difficulty) {
    case "fu":
      return 3;
      break;
    case "hard":
      return 3;
      break;
    case "medium":
      return 3;
      break;
    default:
      return 6;
      break;
  }
}

enemy_rpg_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(e_inflictor == level.player)
    return n_damage;
  else if(isDefined(self.targetname) && issubstr(self.targetname, "final_launcher"))
    return 0;
  else {
    n_damage = int(n_damage / 3);
    return n_damage;
  }
}

show_victory_vehicles(b_show) {
  m_buffel = getent("destroyed_buffel", "targetname");
  m_tank = getent("destroyed_tank", "targetname");

  if(b_show) {
    m_buffel show();
    m_buffel solid();
    m_tank show();
    m_tank solid();
  } else {
    m_buffel hide();
    m_buffel notsolid();
    m_tank hide();
    m_tank notsolid();
  }
}

angola_challenge_actor_killed_callback(e_inflictor, e_attacker, n_damage, str_mod, str_weapon, v_hit_direction, str_hit_location, psoffsettime) {
  if(e_attacker == level.player) {
    if(str_weapon == "machete_sp")
      level.player notify(level.machete_notify);
    else if(str_weapon == "mortar_shell_dpad_sp") {
      level.mortar_kills++;

      if(level.mortar_kills == 1)
        level thread mortar_kill_timer();
    }
  }
}

mortar_kill_timer() {
  wait 0.3;

  if(level.mortar_kills > 4)
    flag_set("mortar_challenge_complete");
  else
    level.mortar_kills = 0;
}

check_player_weapons() {
  n_clip = level.player getweaponammoclip("mortar_shell_dpad_sp");
  level.player set_temp_stat(1, n_clip);
  n_stock = level.player getweaponammostock("mortar_shell_dpad_sp");
  level.player set_temp_stat(2, n_stock);
}

remove_buffel_riders() {
  foreach(rider in self.riders) {
    if(rider.seat != 0 && rider.seat != 9)
      rider delete();
  }
}

riverbed_fail_watch() {
  array_thread(getentarray("riverbed_warning", "targetname"), ::riverbed_fail_warning);
  array_thread(getentarray("riverbed_fail", "targetname"), ::riverbed_fail_kill);
}

riverbed_fail_warning() {
  for(n_count = 1; !flag("savannah_base_reached") && !flag("clash_runners_ready") && !flag("savimbi_reached_savannah"); n_count++) {
    self waittill("trigger");

    if(n_count % 2 != 0)
      level.savimbi say_dialog("savi_i_would_not_wish_you_0", 0.5);
    else
      level.savimbi say_dialog("savi_stay_close_to_the_co_0", 0.5);

    wait(randomfloatrange(5, 7.5));
  }
}

riverbed_fail_kill() {
  self waittill("trigger");
  setdvar("ui_deadquote", & "ANGOLA_CONVOY_FAIL");
  level.player maps\_mortar::explosion_boom("mortar_savannah");
  wait 0.45;
  level.player dodamage(level.player.health + 1000, (0, 0, 0));
}

mpla_scripted_attach_machete(ai_guy) {
  ai_guy.scripted_melee_weapon = spawn("script_model", ai_guy gettagorigin("tag_weapon_left"));
  ai_guy.scripted_melee_weapon.angles = ai_guy gettagangles("tag_weapon_left");
  ai_guy.scripted_melee_weapon setmodel("t6_wpn_machete_prop");
  ai_guy.scripted_melee_weapon linkto(ai_guy, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
}

mpla_scripted_drop_machete(ai_guy) {
  scripted_melee_weapon = ai_guy.scripted_melee_weapon;
  scripted_melee_weapon unlink();
  scripted_melee_weapon physicslaunch();
  wait 15;
  scripted_melee_weapon delete();
}

mpla_disable_aim_assist(ai_guy) {
  ai_guy disableaimassist();
}

gib_arm(ai_guy) {
  ai_guy.force_gib = 1;
  ai_guy.custom_gib_refs = "left_arm";
}

gib_head(ai_guy) {
  ai_guy.force_gib = 1;
  ai_guy.custom_gib_refs = "left_arm";
}

toggle_player_radio(b_toggle) {
  player = level.player;

  if(b_toggle) {
    player.currentweapon = player getcurrentweapon();
    player giveweapon("air_support_radio_sp");
    player setactionslot(1, "weapon", "air_support_radio_sp");
  } else {
    player switchtoweapon(player.currentweapon);
    player takeweapon("air_support_radio_sp");
  }
}

riverbed_lockbreaker_perk() {
  mortar_array = getentarray("pickup_mortar", "targetname");

  foreach(mortar in mortar_array)
  mortar delete();

  run_scene_first_frame("lockbreaker");
  t_open = getent("lockbreaker_buffel_trigger", "targetname");
  t_open sethintstring(&"SCRIPT_HINT_BRUTE_FORCE");
  t_open setcursorhint("HINT_NOICON");
  t_open trigger_off();
  a_weapons = getentarray("lockbreaker_weapon", "script_noteworthy");

  foreach(weapon in a_weapons)
  weapon trigger_off();

  level.player waittill_player_has_brute_force_perk();
  t_open trigger_on();
  set_objective(level.obj_lockbreaker, t_open, "interact");
  t_open waittill("trigger");
  set_objective(level.obj_lockbreaker, t_open, "remove");
  t_open delete();
  a_weapons = getentarray("lockbreaker_weapon", "script_noteworthy");

  foreach(weapon in a_weapons)
  weapon trigger_on();

  level thread run_scene("lockbreaker_interact");
  lockpick = get_model_or_models_from_scene("lockbreaker_interact", "lockbreaker");
  lockpick setforcenocull();
  scene_wait("lockbreaker_interact");
  level thread give_player_mortars();
}

give_player_mortars() {
  level.player set_temp_stat(3, 1);
  level.player giveweapon("mortar_shell_dpad_sp");
  level.player setactionslot(4, "weapon", "mortar_shell_dpad_sp");
  level.player givemaxammo("mortar_shell_dpad_sp");
  level thread mortar_helper_message(2);
  level.player thread monitor_mortar_ammo();
}

monitor_mortar_ammo() {
  self endon("death");

  while(true) {
    if(!self getammocount("mortar_shell_dpad_sp") && self getcurrentweapon() == "mortar_shell_dpad_sp") {
      a_weapons = self getweaponslistprimaries();
      self switchtoweapon(a_weapons[0]);
    }

    wait 0.1;
  }
}

fake_fire(m_model) {
  fire_origin = m_model gettagorigin("tag_flash");
  fire_angles = m_model gettagangles("tag_flash");
  forward = anglestoforward(fire_angles);
  forward = vectorscale(forward, 750);
  playfxontag(level._effect["scene_weapon_flash"], m_model, "tag_flash");
  m_model playsoundontag("wpn_ak47_fire_npc", "tag_flash");
  magicbullet("ak47_sp", fire_origin, m_model.origin + anglestoforward(fire_angles) * 500);
}

fake_weapon(m_model) {
  m_model setactorweapon("ak47_sp");
}

warn_to_kill_player(n_time_to_fail) {
  if(!isDefined(n_time_to_fail))
    n_time_to_fail = 0;

  level endon("strafe_run_called");
  fake_mortar = spawn("script_origin", (0, 0, 0));
  savimbi_buffel = getent("savimbi_buffel", "targetname");

  for(x = 1; x < n_time_to_fail + 1; x++) {
    area_forward = anglestoforward(savimbi_buffel.angles) * 500 * (n_time_to_fail + 1 - x);
    fake_mortar.origin = savimbi_buffel.origin + area_forward + (randomintrange(-500, 500), 0, 0);
    fake_mortar thread maps\_mortar::mortar_boom(fake_mortar.origin, 0.05, 0.25, 50, getfx("mortar_savannah"), 0, 0);
    wait 1;
  }

  fake_mortar.origin = level.player.origin;
  fake_mortar thread maps\_mortar::mortar_boom(level.player.origin, 1, 1, 200, getfx("mortar_savannah"), 0);
  level.player kill();
}

stop_fighter_magic_bullet_shield(ent) {
  self endon("death");

  if(!isDefined(ent))
    ent = self;

  if(isai(ent))
    ent bloodimpact("normal");

  ent.attackeraccuracy = 1;
  ent notify("stop_magic_bullet_shield");
  ent.magic_bullet_shield = undefined;
  ent._mbs = undefined;
}

drone_killer() {
  level endon("push_warp_ready");

  while(true) {
    a_drones = get_array_of_closest(level.player.origin, level.drones.team["axis"].array, undefined, undefined, 1024);

    foreach(drone in a_drones) {
      if(isDefined(drone))
        drone dodamage(100, drone.origin);

      wait 0.05;
    }

    wait 0.05;
  }
}

unita_say(str_vo) {
  ai_unita = get_closest_ai(level.player.origin, "allies");
  ai_unita say_dialog(str_vo);
}