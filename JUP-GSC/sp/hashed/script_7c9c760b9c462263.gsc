/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_7c9c760b9c462263.gsc
*************************************************/

#using script_4b7698942d6f679a;
#using script_53f4e6352b0b2425;
#using scripts\anim\dialogue;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\hud_util;
#using scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_rig;
#using scripts\sp\utility;
#namespace namespace_6bfab3abd0e2748a;

function function_f61d69c52c69f691() {}

function function_14cca8a7ced708ab() {
  thread namespace_9c93a5b828db4a4b::function_e39d8a96b86719ce(0);
  namespace_9c93a5b828db4a4b::spawn_allies();
  utility::set_start_location("showers", [level.player, level.ally1, level.ally2]);
  namespace_9c93a5b828db4a4b::function_dc2aa213aa5830aa(utility::getStruct("makarov_shower_path_start", "targetname"));
  waitframe();
  allies = [level.ally1, level.ally2, level.makarov];

  foreach(ally in allies) {
    ally thread function_68ec96120a686299();
  }

  level.ally1 utility::set_force_color("c");
  level.ally2 utility::set_force_color("y");
  level.makarov utility::set_force_color("r");
}

function function_d169d9173281b55c() {
  level thread function_7454bc08b9d9bef0();
  level thread function_18cd8b965262b66d();
  level thread function_59a853479ab33a5c();
  utility::flag_wait("flag_showers_start");
  thread utility::autosave_by_name("showers_start");
  level.player utility::player_speed_default(2);
  utility::flag_wait("flag_spawn_riot_enemies");
  level thread showers_riot_enemies();
  utility::flag_wait("flag_armory_start");
  level thread function_6cfaceef45832d1f();
}

function function_b6028b9ab8a4bc8d() {}

function function_68ec96120a686299() {
  utility::demeanor_override("cqb");
  utility::set_movement_speed(100);

  if(self == level.makarov) {
    utility::set_stayahead_values(1, 200, 0, 0.1);
    utility::set_stayahead_values(2, 150, -50, 0.1);
    utility::set_stayahead_values(3, 100, -100, 0.1);
    utility::set_stayahead_values(4, 80, -150, 0.1);
    thread utility::enable_stayahead(level.player);
  } else {
    utility::set_stayahead_values(1, 200, 250, 0.1);
    utility::set_stayahead_values(2, 150, 150, 0.1);
    utility::set_stayahead_values(3, 100, 100, 0.1);
    utility::set_stayahead_values(4, 80, 50, 0.1);
  }

  self enableavoidance(1, 1);
}

function function_6cfaceef45832d1f() {
  utility::flag_wait("prisoner_rush_spawn");
  var_cba7f225cd4ca912 = getaiarrayinradius(level.player.origin, 20000);

  foreach(guy in var_cba7f225cd4ca912) {
    if(utility::is_equal(guy.targetname, "showers_vignette_guy") || utility::is_equal(guy.targetname, "showers_riot_arrival_guy")) {
      guy delete();
    }
  }
}

function function_7454bc08b9d9bef0() {
  utility::activate_trigger_with_targetname("trigger_allies_outside_of_showers_pos");
  utility::flag_wait("flag_showers_start");
  utility::activate_trigger_with_targetname("trigger_showers_makarov_start_pos");
  utility::flag_wait("flag_showers_enter");
  utility::activate_trigger_with_targetname("trigger_showers_allies_start_pos");
  utility::flag_wait("flag_showers_riot_arrival");
  utility::activate_trigger_with_targetname("trigger_showers_allies_riot_pos");
  utility::flag_wait("flag_showers_riot_enemies_dead");
  utility::activate_trigger_with_targetname("trigger_shower_enemies_dead_pos");
}

function function_18cd8b965262b66d() {}

function function_59a853479ab33a5c() {
  var_feaa3d1470b941a2 = getspawnerarray("showers_vignette_guy");

  foreach(spawner in var_feaa3d1470b941a2) {
    guy = spawner utility::spawn_ai(1);
    guy thread function_a6eed5e44ce609d1();
    waitframe();
  }

  utility::flag_wait("flag_showers_riot_arrival");
  sndorg = utility::getStruct("showers_riot_arrival_sound_org", "targetname");
  var_5f9218dbc9f75cb5 = snd::snd_play("temp_env_siren_alarm_on_fade", level.player);
  riot_node = utility::getStruct("jup_vip_riot_clash_3", "targetname");
  waitframe();
  riot_node thread scene::play(undefined, ["shot_010", "shot_020"]);
}

function function_a6eed5e44ce609d1() {
  if(!isDefined(self.animation)) {
    return;
  }

  ai::gun_remove();
  thread function_f4df2627076abecb(self.animation);
  thread function_11c04172a0891d4f();
}

function function_f4df2627076abecb(animation) {
  level endon("showers_vignettes_stop");
  self endon("vignette_stop");
  wait randomfloatrange(0, 1.5);
  animorg = spawn("script_origin", self.origin);
  animorg.angles = self.angles;

  switch (animation) {
    case #"hash_34568ed1ab0d36f7":
    case #"hash_34568fd1ab0d388a":
      while(true) {
        animorg animation::anim_single_solo(self, "vip_0000_riot_temp_melee_loop_01");
        animorg animation::anim_single_solo(self, "vip_0000_riot_temp_melee_loop_02");
        waitframe();
      }

      break;
    case #"hash_6527f3cb7a650c85":
      animorg animation::anim_loop_solo(self, "civ_cap_cower03_prone_exposed_idle");
      break;
    default:
      while(true) {
        animorg animation::anim_single_solo(self, animation);
        waitframe();
      }

      break;
  }
}

function function_11c04172a0891d4f() {
  self endon("death");
  self waittill("damage");
  utility::anim_stopanimScripted();
  self notify("vignette_stop");
  self kill();
}

function showers_riot_enemies() {
  riot_enemies = utility::array_spawn_targetname("showers_riot_enemies");

  foreach(guy in riot_enemies) {
    guy.accuracy = 0.5;
    guy.fixednode = 1;
    guy utility::demeanor_override("combat");
  }
}

function function_1eb8de7c96aac07c() {}

function function_461dd387c934770() {
  thread namespace_9c93a5b828db4a4b::function_e39d8a96b86719ce(0);
  namespace_9c93a5b828db4a4b::spawn_allies();
  utility::set_start_location("riotpush", [level.player, level.ally1, level.ally2]);
  namespace_9c93a5b828db4a4b::function_dc2aa213aa5830aa(utility::getStruct("makarov_riotpush_start", "targetname"));
  waitframe();
  allies = [level.ally1, level.ally2, level.makarov];

  foreach(ally in allies) {
    ally thread function_bf0fd3398e2af800();
  }

  level.ally1 utility::set_force_color("c");
  level.ally2 utility::set_force_color("y");
  level.makarov utility::set_force_color("r");
}

function function_e6da23f91b0abf29() {
  level thread function_87c823278218d6c9();
  level thread function_f8b3a120064d1888();
  thread utility::autosave_by_name("showers_end");
  utility::flag_wait("flag_player_enters_armory");
  level thread function_dcea48232a4daf67();
  thread utility::autosave_by_name("armory_start");
  utility::flag_wait("flag_player_enters_curved_hallway");
  level thread function_e128e1cbe2761b84();
  level thread function_cb1e0c0468a8e296();
  utility::flag_wait("flag_armory_enemies_dead");
  thread utility::autosave_by_name("armory_end");
  button_org = utility::getStruct("escape_lift_button", "targetname");
  button_org cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SP_JUP_VIP/INTERACT_ENTER_ELEVATOR");
  button_org waittill("trigger");
  var_d390ee98b67613e5 = getEnt("riot_elevator_door", "targetname");
  elevator_cage_door_dest = utility::getStruct("sm_elevator_cage_door_dest", "targetname");
  var_d390ee98b67613e5 moveTo(elevator_cage_door_dest.origin, 6);
  utility::flag_wait("flag_player_within_elevator");

  iprintlnbold("<dev string:x1c>");

  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::elevator_anim();
  flag_wait("cine_elevator_end");
  teleport_player(getStruct("elevator_tp_end", "targetname"));
}

function function_add6409c01487ea6() {}

function function_bf0fd3398e2af800() {
  utility::demeanor_override("cqb");
  utility::set_movement_speed(100);

  if(self == level.makarov) {
    utility::set_stayahead_values(1, 200, 0, 0.1);
    utility::set_stayahead_values(2, 150, -50, 0.1);
    utility::set_stayahead_values(3, 100, -100, 0.1);
    utility::set_stayahead_values(4, 80, -150, 0.1);
    thread utility::enable_stayahead(level.player);
  } else {
    utility::set_stayahead_values(1, 200, 250, 0.1);
    utility::set_stayahead_values(2, 150, 150, 0.1);
    utility::set_stayahead_values(3, 100, 100, 0.1);
    utility::set_stayahead_values(4, 80, 50, 0.1);
  }

  self enableavoidance(1, 1);
}

function function_87c823278218d6c9() {
  utility::activate_trigger_with_targetname("trigger_shower_enemies_dead_pos");
  utility::flag_wait("flag_armory_enemies_dead");
  utility::activate_trigger_with_targetname("trigger_armory_enemies_dead_pos");
}

function function_f8b3a120064d1888() {}

function function_dcea48232a4daf67() {
  var_256e9d5846be8741 = getspawnerarray("armory_riot_shield_guys");
  var_925b25e91e45d49e = utility::array_spawn(var_256e9d5846be8741, 1);
  waitframe();

  foreach(guy in var_925b25e91e45d49e) {
    guy.fixednode = 1;
    guy.ignoreall = 1;
  }

  utility::flag_wait("flag_armory_retreat");
  retreat_volume = getEnt("armory_retreat_goal", "targetname");

  foreach(guy in var_925b25e91e45d49e) {
    if(isalive(guy)) {
      guy.fixednode = 0;
      guy cleargoalentity();
      guy setgoalvolumeauto(retreat_volume);
    }
  }
}

function function_e128e1cbe2761b84() {
  var_af0642fa4de0f643 = getspawnerarray("armory_guys_group_1");
  armory_guys = utility::array_spawn(var_af0642fa4de0f643, 1);
  waitframe();

  foreach(guy in armory_guys) {
    guy.fixednode = 1;
  }

  while(armory_guys.size > 3) {
    armory_guys = utility::array_removedead_or_dying(armory_guys);
    wait 1;
  }

  utility::flag_set("flag_armory_retreat");
  retreat_volume = getEnt("armory_retreat_goal", "targetname");

  foreach(guy in armory_guys) {
    if(isalive(guy)) {
      guy.fixednode = 0;
      guy cleargoalentity();
      guy setgoalvolumeauto(retreat_volume);
    }
  }
}

function function_cb1e0c0468a8e296() {
  utility::flag_wait_either("flag_armory_rushers_spawn", "flag_armory_player_halfway");
  armory_rushers_spawner = getspawnerarray("armory_rushers_spawner");
  var_4d948b7f2686bd1e = utility::array_spawn(armory_rushers_spawner, 1);
  waitframe();

  foreach(guy in var_4d948b7f2686bd1e) {
    guy.accuracy = 0.5;
  }

  utility::flag_wait("flag_armory_retreat");
  retreat_volume = getEnt("armory_retreat_goal", "targetname");

  foreach(guy in var_4d948b7f2686bd1e) {
    if(isalive(guy)) {
      guy.fixednode = 0;
      guy cleargoalentity();
      guy setgoalvolumeauto(retreat_volume);
    }
  }
}