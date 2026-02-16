/*******************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight.gsc
*******************************************************************/

init_super_slasher_quest() {
  load_super_slasher_vfx();
  start_super_slasher_quest();
}

start_super_slasher_quest() {
  scripts\cp\zombies\zombie_quest::register_quest_step("superslasher", 0, scripts\cp\maps\cp_rave\cp_rave_interactions::init_survivor_trapped, scripts\cp\maps\cp_rave\cp_rave_interactions::wait_for_survivor_trapped, ::blank, ::debug_trap_survivor);
  scripts\cp\zombies\zombie_quest::register_quest_step("superslasher", 1, scripts\cp\maps\cp_rave\cp_rave_interactions::init_survivor_released, scripts\cp\maps\cp_rave\cp_rave_interactions::wait_for_survivor_released, ::debug_release_survivor, ::debug_release_survivor);
  scripts\cp\zombies\zombie_quest::register_quest_step("superslasher", 2, ::init_get_survivor_to_island, ::get_survivor_to_island, ::complete_to_island, ::debug_get_survivor_to_island);
  scripts\cp\zombies\zombie_quest::register_quest_step("superslasher", 3, ::init_super_slasher_fight, ::super_slasher_fight, ::complete_fight, ::debug_super_slasher_fight);
}

blank() {}

load_super_slasher_vfx() {
  level._effect["memory_trap_loop"] = loadfx("vfx\iw7\levels\cp_rave\vfx_rave_dcatcher_dmg_loop.vfx");
  level._effect["memory_trap_start"] = loadfx("vfx\iw7\levels\cp_rave\vfx_rave_dcatcher_dmg_start.vfx");
  level._effect["memory_trap_idle"] = loadfx("vfx\iw7\levels\cp_rave\vfx_rave_dcatcher_idle.vfx");
  level._effect["memory_trap_active"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_dcatcher_active.vfx");
  level._effect["memory_weak_spot"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_superslasher_weak_spot.vfx");
  level._effect["floating_charm_trail_small"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_superslasher_floating_charm_small.vfx");
  level._effect["floating_charm_trail_medium"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_superslasher_floating_charm_medium.vfx");
  level._effect["floating_charm_trail_large"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_superslasher_floating_charm_large.vfx");
  level._effect["superslasher_summon_zombie_portal"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_superslasher_spawn_portal.vfx");
  level._effect["soul_charm_beam_small"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_superslasher_soul_beam_small.vfx");
  level._effect["soul_charm_beam_medium"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_superslasher_soul_beam_small.vfx");
  level._effect["soul_charm_beam_full"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_superslasher_soul_beam_full.vfx");
  level._effect["charm_to_trap"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_superslasher_soul_charm_arc.vfx");
  level._effect["initial_weak_spot_hit"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_ss_weakspot_hit.vfx");
  level._effect["weak_spot_J_hit"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_ss_weakspot_hit_j.vfx");
  level._effect["weak_spot_A_hit"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_ss_weakspot_hit_a.vfx");
  level._effect["weak_spot_Y_hit"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_ss_weakspot_hit_y.vfx");
  level._effect["weak_spot_M_hit"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_ss_weakspot_hit_m.vfx");
  level._effect["weak_spot_E_hit"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_ss_weakspot_hit_e.vfx");
  level._effect["weak_spot_W_hit"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_ss_weakspot_hit_w.vfx");
  level._effect["weak_spot_S_hit"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_ss_weakspot_hit_s.vfx");
  level._effect["punji_tell"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_punji_tell.vfx");
  level._effect["punji_subside"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_punji_subside.vfx");
  level._effect["happy_face"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_super_slasher_glow.vfx");
  level._effect["sad_face"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_super_slasher_glow_sad.vfx");
  level._effect["soul_key_glow"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_soulkey_flames.vfx");
  level._effect["boat_fall_splash"] = loadfx("vfx\iw7\levels\cp_rave\vfx_ks_water_splash.vfx");
  level._effect["fight_stage"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_ss_stage.vfx");
  level._effect["initial_weak_spot"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_superslasher_initial_weak_spot.vfx");
}

debug_trap_survivor() {
  scripts\engine\utility::flag_set("survivor_trapped");
}

debug_release_survivor() {
  scripts\engine\utility::flag_set("survivor_released");
  if(!isDefined(level.boat_survivor)) {
    level thread scripts\cp\maps\cp_rave\cp_rave_boat::spawn_survivor_on_boat();
  }
}

init_get_survivor_to_island() {
  scripts\engine\utility::flag_init("survivor_got_to_island");
}

get_survivor_to_island() {
  scripts\engine\utility::flag_wait("survivor_got_to_island");
  scripts\cp\maps\cp_rave\cp_rave_boat::fade_screen_after_ss_intro();
}

complete_to_island() {
  scripts\cp\maps\cp_rave\cp_rave_boat::move_players_to_shore();
  level.getspawnpoint = scripts\cp\maps\cp_rave\cp_rave::respawn_on_island;
  scripts\engine\utility::flag_clear("survivor_released");
  level notify("end_boat_hotjoin");
  level.boat_vehicle vehicle_teleport(level.boat_start_node.origin, level.boat_start_node.angles);
  level.boat_vehicle attachpath(level.boat_start_node);
  scripts\cp\cp_interaction::add_to_current_interaction_list(level.boat_interaction_struct);
  move_lost_and_found("island");
  scripts\cp\maps\cp_rave\cp_rave_boat::fade_in_for_ss_fight();
}

move_lost_and_found(var_0) {
  if(!isDefined(level.lnf_struct)) {
    level.lnf_struct = scripts\engine\utility::getstruct("lost_and_found", "script_noteworthy");
    level.lnf_struct.og_origin = level.lnf_struct.origin;
  }

  if(var_0 == "island") {
    if(isDefined(level.lnf_sign)) {
      level.lnf_sign show();
    }

    level.lnf_struct.origin = (-4679.5, 4989.5, -113.82);
  } else {
    if(isDefined(level.lnf_sign)) {
      level.lnf_sign hide();
    }

    level.lnf_struct.origin = level.lnf_struct.og_origin;
  }

  foreach(var_2 in level.players) {
    if(!isDefined(var_2.lost_and_found_ent)) {
      continue;
    }

    var_2.lost_and_found_ent.origin = level.lnf_struct.origin + (0, 0, 45);
  }
}

debug_get_survivor_to_island() {}

init_super_slasher_fight() {
  scripts\engine\utility::flag_init("super_slasher_fight_complete");
  reg_weak_spots();
  reg_spawns();
  level thread watch_for_player_deaths();
}

super_slasher_fight() {
  level.wave_num_override = int(max(38, level.wave_num));
  level.disable_loot_fly_to_player = 1;
  level.loot_time_out = 99999;
  level thread max_ammo_manager();
  deploy_stair_barrier();
  stop_spawn_wave();
  clear_existing_enemies();
  activate_fight_stage_vfx();
  scripts\engine\utility::flag_clear("zombie_drop_powerups");
  for(;;) {
    level.superslasher = scripts\mp\mp_agent::spawnnewagent("superslasher", "axis", level.superslasherspawnspot, level.superslasherspawnangles);
    if(isDefined(level.superslasher)) {
      break;
    } else {
      scripts\engine\utility::waitframe();
    }
  }

  thread watch_for_player_connect();
  level.superslasher.dont_cleanup = 1;
  level.superslasher.var_E0 = 1;
  level.superslasher thread put_on_happy_face(level.superslasher);
  level.force_respawn_location = scripts\cp\maps\cp_rave\cp_rave::respawn_on_island;
  soul_collection_sequence_init();
  thread scripts\cp\maps\cp_rave\cp_rave::deactivateadjacentvolumes();
  wait(2);
  level notify("ss_intro_finished");
  foreach(var_1 in level.players) {
    var_1 playsoundtoplayer(var_1.vo_prefix + "slasher_super_first", var_1);
  }

  wait(6);
  level thread unlimited_zombie_spawn();
  level thread soul_collection_sequence();
  level thread enableslasherpas();
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_superslasher_firstspawn", "rave_announcer_vo", "highest", 5, 0, 0, 1);
  level waittill("super_slasher_death");
  destroy_stair_barrier();
  level.no_slasher = 0;
  level thread move_lost_and_found("cabin");
  level.force_respawn_location = undefined;
  level.getspawnpoint = scripts\cp\cp_globallogic::defaultgetspawnpoint;
  level thread disableslasherpas();
  level.loot_time_out = undefined;
  scripts\engine\utility::flag_set("zombie_drop_powerups");
  scripts\engine\utility::flag_set("stop_unlimited_spawn");
  wait(5);
  resume_spawn_wave();
}

watch_for_player_connect() {
  level endon("super_slasher_death");
  level endon("game_ended");
  foreach(var_1 in level.players) {
    if(var_1 scripts\cp\utility::isteleportenabled()) {
      var_1 scripts\cp\utility::allow_player_teleport(0);
    }
  }

  for(;;) {
    level waittill("connected", var_3);
    if(var_3 scripts\cp\utility::isteleportenabled()) {
      var_3 scripts\cp\utility::allow_player_teleport(0);
    }
  }
}

complete_fight() {
  scripts\engine\utility::flag_set("super_slasher_fight_complete");
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_superslasher_death", "rave_announcer_vo", "highest", 5, 0, 0, 1);
  if(!scripts\cp\zombies\directors_cut::directors_cut_is_activated()) {
    scripts\cp\maps\cp_rave\cp_rave_interactions::enable_slasher_weapon();
  }

  level thread play_slasher_death_vo();
  level thread delay_drop_soul_key();
  level.wave_num_override = undefined;
}

delay_drop_soul_key() {
  level endon("game_ended");
  wait(8);
  drop_soul_key();
  foreach(var_1 in level.players) {
    if(!var_1 scripts\cp\utility::isteleportenabled()) {
      var_1 scripts\cp\utility::allow_player_teleport(1);
    }
  }

  if(isDefined(level.volumes_before_fight) && level.volumes_before_fight.size > 1) {
    foreach(var_4 in level.volumes_before_fight) {
      var_4 scripts\cp\zombies\zombies_spawning::make_volume_active();
    }
  }
}

enableslasherpas() {
  level notify("force_new_song");
  level.jukebox_table = "cp\zombies\cp_rave_music_genre_slasher.csv";
  scripts\cp\zombies\zombie_jukebox::parse_music_genre_table();
  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start((-5867, 4938, 381), undefined, 1);
  wait(0.5);
  level notify("jukebox_start");
  level.slasherpa = 1;
  enablepaspeaker("pa_super_slasher");
}

disableslasherpas() {
  disablepaspeaker("pa_super_slasher");
  level notify("force_new_song");
  level.slasherpa = undefined;
  level.jukebox_table = "cp\zombies\cp_rave_music_genre.csv";
  scripts\cp\zombies\zombie_jukebox::parse_music_genre_table();
  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start((1785, -2077, 211));
  level notify("jukebox_start");
}

play_slasher_death_vo() {
  level endon("game_ended");
  wait(scripts\cp\cp_vo::get_sound_length("ww_superslasher_death"));
  var_0 = level.players;
  var_1 = scripts\engine\utility::random(var_0);
  switch (var_1.vo_prefix) {
    case "p1_":
      level thread scripts\cp\cp_vo::try_to_play_vo("defeatslasher_28_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      break;

    case "p2_":
      level thread scripts\cp\cp_vo::try_to_play_vo("defeatslasher_31_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      break;

    case "p3_":
      level thread scripts\cp\cp_vo::try_to_play_vo("defeatslasher_30_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      break;

    case "p4_":
      level thread scripts\cp\cp_vo::try_to_play_vo("defeatslasher_29_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      break;

    default:
      break;
  }
}

debug_super_slasher_fight() {}

use_memory_trap(var_0, var_1) {}

slasher_trapped(var_0) {
  var_1 = 0.5;
  level notify("super_slasher_is_trapped");
  level.superslasher scripts\aitypes\superslasher\util::forcetrapped(6);
  try_drop_max_ammo();
  deactivate_all_super_slasher_barriers();
  var_0.memory_trap_vfx_ent delete();
  var_2 = spawnfx(level._effect["memory_trap_start"], var_0.memory_trap_loc);
  triggerfx(var_2);
  wait(var_1);
  var_2 delete();
  var_3 = spawnfx(level._effect["memory_trap_loop"], var_0.memory_trap_loc);
  triggerfx(var_3);
  wait(6 - var_1);
  var_3 delete();
  var_0.completed = 1;
  level.superslasher slasher_weakspot_phase(level.superslasher.fight_round);
  level.superslasher thread activate_weak_spots(level.superslasher);
}

get_trap_trigger() {
  var_0 = scripts\engine\utility::getStructArray("memory_trap_trigger", "script_noteworthy");
  var_1 = [];
  foreach(var_3 in var_0) {
    if(scripts\engine\utility::istrue(var_3.completed)) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  var_5 = scripts\engine\utility::random(var_1);
  set_up_trap_trigger(var_5);
  return var_5;
}

init_memory_traps() {
  var_0 = scripts\engine\utility::getStructArray("memory_trap_trigger", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.completed = 0;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
  }
}

set_up_trap_trigger(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_0.floating_charm_locs = [];
  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "memory_trap_model":
        var_0.model_loc = var_3.origin;
        var_0.model_angles = var_3.angles;
        break;

      case "memory_trap_loc":
        var_0.memory_trap_loc = var_3.origin;
        break;

      case "floating_charm_loc":
        var_0.floating_charm_locs[var_0.floating_charm_locs.size] = var_3;
        break;
    }
  }
}

activate_trap_trigger(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(var_0.memory_trap_loc, 0, -500);
  var_2 = spawn("script_model", var_1);
  var_2 setModel("tag_origin");
  var_0.memory_trap_vfx_ent = var_2;
  wait(0.1);
  set_memory_trap_state(var_2, "idle");
  playsoundatpos(var_1, "superslasher_damage_trap_portal_open_lr");
  var_0 thread slasher_in_trap(var_0, var_1);
}

set_memory_trap_state(var_0, var_1) {
  if(!isDefined(var_0.current_state)) {
    var_0.current_state = "";
  }

  if(var_0.current_state == var_1) {
    return;
  }

  if(var_0.current_state != "") {
    stopFXOnTag(level._effect["memory_trap_" + var_0.current_state], var_0, "tag_origin");
  }

  var_0.current_state = var_1;
  playFXOnTag(level._effect["memory_trap_" + var_1], var_0, "tag_origin");
}

slasher_in_trap(var_0, var_1) {
  var_0 endon("initial_weak_spot_hit");
  var_2 = 22500;
  for(;;) {
    if(isDefined(level.superslasher)) {
      if(distance2dsquared(level.superslasher.origin, var_1) <= var_2) {
        activate_initial_weak_spot(var_0);
      } else {
        deactivate_initial_weak_spot(var_0);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

activate_initial_weak_spot(var_0) {
  set_memory_trap_state(var_0.memory_trap_vfx_ent, "active");
  if(!isDefined(level.superslasher.initial_weak_spot)) {
    var_1 = scripts\engine\utility::random(["tag_chest_le", "tag_chest_ri"]);
    level.superslasher.initial_weak_spot = set_up_weak_spot(var_1, level.superslasher, "initial_weak_spot");
    level.superslasher.initial_weak_spot.weak_spot_model thread initial_weak_spot_damage_monitor(level.superslasher.initial_weak_spot.weak_spot_model, var_0);
  }
}

initial_weak_spot_damage_monitor(var_0, var_1) {
  var_0 endon("death");
  var_0.health = 9999999;
  var_0 setCanDamage(1);
  for(;;) {
    var_0 waittill("damage", var_2, var_3, var_4, var_5);
    var_0.health = 9999999;
    if(isDefined(var_3)) {
      if(var_3 == level.superslasher) {
        continue;
      }

      if(!isPlayer(var_3)) {
        continue;
      }

      var_6 = var_4 * -1;
      playFX(level._effect["initial_weak_spot_hit"], var_5, var_6);
      break;
    }
  }

  foreach(var_8 in level.players) {
    var_8.unlimited_rave = 0;
    scripts\cp\maps\cp_rave\cp_rave::exit_rave_mode(var_8);
  }

  level thread slasher_trapped(var_1);
  var_1 notify("initial_weak_spot_hit");
  level.superslasher.initial_weak_spot.weak_spot_vfx_ent delete();
  level.superslasher.initial_weak_spot = undefined;
  playsoundatpos(level.superslasher.origin, "superslasher_damage_trap_lr");
  var_0 delete();
}

deactivate_initial_weak_spot(var_0) {
  set_memory_trap_state(var_0.memory_trap_vfx_ent, "idle");
  if(isDefined(level.superslasher.initial_weak_spot)) {
    level.superslasher.initial_weak_spot.weak_spot_model delete();
    level.superslasher.initial_weak_spot.weak_spot_vfx_ent delete();
    level.superslasher.initial_weak_spot = undefined;
  }
}

slasher_weakspot_phase(var_0) {
  self.bmaystomp = 1;
  self.bmayjumpattack = 1;
  self.bmayfrisbee = 0;
  self.bmaysawfan = 0;
  self.bmayshockwave = 0;
  self.bmaywire = 0;
  self.bmayshark = 0;
  self.animratescale = 1.1 + min(var_0, 3) * 0.15;
}

reg_weak_spots() {
  level.super_slasher_weak_spots = [];
  register_memory_weak_spot("tag_chest_le", (0, 0, 0), (3, 0, 0), (90, 0, 0));
  register_memory_weak_spot("tag_chest_ri", (0, 0, 0), (3, 0, 0), (90, 0, 0));
  register_memory_weak_spot("tag_thigh_le", (0, 0, 0), (3, 0, 0), (90, 0, 0));
  register_memory_weak_spot("tag_thigh_ri", (0, 0, 0), (3, 0, 0), (90, 0, 0));
  register_memory_weak_spot("tag_shoulder2_le", (0, 0, 0), (3, 0, 0), (90, 0, 0));
  register_memory_weak_spot("tag_shoulder2_ri", (0, 0, 0), (3, 0, 0), (90, 0, 0));
  register_memory_weak_spot("tag_shoulder1_le", (0, 0, 0), (3, 0, 0), (90, 0, 0));
  register_memory_weak_spot("tag_shoulder1_ri", (0, 0, 0), (3, 0, 0), (90, 0, 0));
}

register_memory_weak_spot(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.tag_name = var_0;
  var_4.damage_model_offset = var_1;
  var_4.vfx_offset = var_2;
  var_4.angular_offset = var_3;
  level.super_slasher_weak_spots[var_0] = var_4;
}

activate_weak_spots(var_0) {
  var_0 endon("death");
  var_1 = get_potential_weak_spot_tags();
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_2 > 0) {
      wait(5);
    }

    complete_weak_spot(var_1[var_2], var_0, get_weak_spot_hit_vfx_index(var_2));
  }

  try_drop_max_ammo();
  var_0 scripts\aitypes\superslasher\util::forcetrapped(6);
  wait(6);
  delete_fight_stage_vfx(var_0.fight_round);
  if(var_0.fight_round == 3) {
    switch_to_sad_face(var_0);
    slasher_abilities_final();
    return;
  }

  var_0.bmayshockwave = 1;
  var_0 scripts\aitypes\superslasher\util::requestshockwave();
  if(distance2dsquared(var_0.origin, level.superslashergotogroundspot) > 4096) {
    var_0 scripts\aitypes\superslasher\util::dosawsharks();
  }
}

complete_weak_spot(var_0, var_1, var_2) {
  var_3 = set_up_weak_spot(var_0, var_1, "memory_weak_spot");
  var_3.weak_spot_model weak_spot_damage_monitor(var_3.weak_spot_model, var_1, 900 * level.players.size, var_2);
  var_3.weak_spot_model delete();
  var_3.weak_spot_vfx_ent delete();
}

set_up_weak_spot(var_0, var_1, var_2) {
  var_3 = level.super_slasher_weak_spots[var_0];
  var_4 = var_3.tag_name;
  var_5 = var_1 gettagorigin(var_4);
  var_6 = spawn("script_model", var_5);
  var_6 setModel("tag_origin");
  wait(0.1);
  var_5 = var_1 gettagorigin(var_4);
  var_7 = spawn("script_model", var_5);
  var_7 setModel("zmb_superslasher_weak_spot");
  var_7 linkto(var_1, var_4, var_3.damage_model_offset, var_3.angular_offset);
  var_7 getrandomweaponfromcategory();
  playFXOnTag(level._effect[var_2], var_6, "tag_origin");
  var_6 linkto(var_1, var_4, var_3.vfx_offset, var_3.angular_offset);
  var_8 = spawnStruct();
  var_8.weak_spot_vfx_ent = var_6;
  var_8.weak_spot_model = var_7;
  return var_8;
}

weak_spot_damage_monitor(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0.health = 9999999;
  var_0 setCanDamage(1);
  var_0.fake_health = var_2;
  for(;;) {
    var_0 waittill("damage", var_4, var_5, var_6, var_7);
    var_0.health = 9999999;
    if(isDefined(var_5)) {
      if(var_5 == var_1) {
        continue;
      }

      if(!isPlayer(var_5)) {
        continue;
      }

      var_8 = var_6 * -1;
      playFX(level._effect[var_3], var_7, var_8);
      playsoundatpos(var_0.origin, "superslasher_pain_magic_hits");
      var_0.fake_health = var_0.fake_health - var_4;
      if(var_0.fake_health <= 0) {
        break;
      }
    }
  }
}

get_potential_weak_spot_tags() {
  var_0 = ["tag_chest_le", "tag_chest_ri", "tag_thigh_le", "tag_thigh_ri", "tag_shoulder1_le", "tag_shoulder1_ri", "tag_shoulder2_le", "tag_shoulder2_ri"];
  return scripts\engine\utility::array_randomize(var_0);
}

get_weak_spot_hit_vfx_index(var_0) {
  var_1 = ["weak_spot_J_hit", "weak_spot_A_hit", "weak_spot_Y_hit", "weak_spot_M_hit", "weak_spot_E_hit", "weak_spot_W_hit", "weak_spot_E_hit", "weak_spot_S_hit"];
  return var_1[var_0];
}

slasher_abilities_final() {
  self.bmaystomp = 1;
  self.bmayjumpattack = 1;
  self.bmayfrisbee = 0;
  self.bmaysawfan = 0;
  self.bmayshockwave = 0;
  self.bmaywire = 0;
  self.bmayshark = 0;
  self.var_E0 = 0;
}

slasher_abilities_collection(var_0) {
  self.bmaystomp = 1;
  self.bmayjumpattack = 1;
  self.bmayfrisbee = 0;
  self.bmaysawfan = 0;
  self.bmaywire = var_0 != 1;
  self.bmayshark = 0;
}

soul_collection_sequence_init() {
  scripts\engine\utility::flag_init("charm_sequence_complete");
  scripts\engine\utility::flag_init("max_ammo_active");
  var_0 = (-5083, 3909, -89);
  var_1 = "zmb_soul_charm";
  var_2 = (-3990, 5655, -163);
  var_3 = "zmb_soul_charm";
  var_4 = (-4469, 4634, -126);
  var_5 = "zmb_soul_charm";
  var_6 = (-4746, 5504, -101);
  var_7 = "zmb_soul_charm";
  var_8 = (-4095, 3968, -124);
  var_9 = "zmb_soul_charm";
  register_soul_collection_loc(var_0, var_1);
  register_soul_collection_loc(var_2, var_3);
  register_soul_collection_loc(var_4, var_5);
  register_soul_collection_loc(var_6, var_7);
  register_soul_collection_loc(var_8, var_9);
  level.superslasher.fight_round = 0;
  self.animratescale = 1.1;
}

soul_collection_sequence() {
  foreach(var_1 in level.players) {
    var_1.unlimited_rave = 1;
    scripts\cp\maps\cp_rave\cp_rave::enter_rave_mode(var_1);
  }

  level.superslasher.fight_round++;
  level.superslasher slasher_abilities_collection(level.superslasher.fight_round);
  try_drop_max_ammo();
  set_zombie_spawning_parameters("continuous", 999999, 0.2, 0.05, "random", "generic_zombie");
  scripts\engine\utility::flag_clear("charm_sequence_complete");
  scripts\engine\utility::flag_set("start_unlimited_spawn");
  activate_soul_collection_locs();
  level thread zom_die_soul_mon();
  level thread delay_change_spawn_loc();
}

delay_change_spawn_loc() {
  level endon("game_ended");
  wait(5);
  set_zombie_spawning_parameters("continuous", 999999, 1, 0.05, "near_player", "generic_zombie");
}

register_soul_collection_loc(var_0, var_1) {
  if(!isDefined(level.soul_collection_locs)) {
    level.soul_collection_locs = [];
  }

  var_2 = spawnStruct();
  var_2.pos = var_0;
  var_2.model = var_1;
  level.soul_collection_locs[level.soul_collection_locs.size] = var_2;
}

activate_soul_collection_locs() {
  level.soul_collection_models = [];
  var_0 = level.players.size;
  for(var_1 = 0; var_1 <= var_0; var_1++) {
    activate_soul_collection_loc(level.soul_collection_locs[var_1]);
    scripts\engine\utility::waitframe();
  }
}

activate_soul_collection_loc(var_0) {
  var_1 = spawn("script_model", var_0.pos);
  var_1 setModel(var_0.model);
  var_1 thread item_keep_rotating(var_1);
  var_1 setscriptablepartstate("fx", "none");
  var_1.original_pos = var_0.pos;
  var_1 thread soul_collection_monitor(var_1);
  level.soul_collection_models[level.soul_collection_models.size] = var_1;
}

item_keep_rotating(var_0) {
  var_0 endon("death");
  var_1 = var_0.angles;
  for(;;) {
    var_0 rotateto(var_1 + (randomintrange(-40, 40), randomintrange(-40, 90), randomintrange(-40, 90)), 3);
    wait(3);
  }
}

soul_collection_monitor(var_0) {
  var_0 endon("death");
  level endon("charm_sequence_complete");
  set_coll_state(var_0, "none");
  var_0.soul_collected = 0;
  for(;;) {
    var_0 waittill("soul_collected");
    update_soul_collected(var_0, 1);
    move_up(var_0);
    if(all_soul_charm_full()) {
      level thread mem_trap_seq();
      continue;
    }

    var_0 thread soul_deplete_mon(var_0);
  }
}

mem_trap_seq() {
  level.superslasher scripts\asm\superslasher\superslasher_actions::stopwireattack();
  level.superslasher slasher_abilities_trap(level.superslasher.fight_round);
  try_drop_max_ammo();
  level.cp_rave_zombie_death_pos_record_func = undefined;
  scripts\engine\utility::flag_set("charm_sequence_complete");
  set_zombie_spawning_parameters("wave", 24 * level.players.size, 1, 10, "random", "generic_zombie");
  turn_off_charm_state_vfx();
  var_0 = get_trap_trigger();
  vfx_point_to_trap(var_0);
  charm_fly_to_trap_loc(var_0);
  activate_trap_trigger(var_0);
}

vfx_point_to_trap(var_0) {
  var_1 = var_0.memory_trap_loc;
  var_2 = int(60);
  for(var_3 = 0; var_3 < var_2; var_3++) {
    foreach(var_5 in level.soul_collection_models) {
      var_6 = var_5.origin;
      var_7 = var_1 - var_6;
      var_8 = vectortoangles(var_7);
      playfxbetweenpoints(level._effect["charm_to_trap"], var_6, var_8, var_1);
    }

    scripts\engine\utility::waitframe();
  }
}

charm_fly_to_trap_loc(var_0) {
  var_1 = var_0.memory_trap_loc;
  foreach(var_3 in level.soul_collection_models) {
    var_3 moveto(var_1, 1.5);
  }

  wait(1.5);
  foreach(var_3 in level.soul_collection_models) {
    if(isDefined(var_3)) {
      var_3 delete();
    }
  }
}

turn_off_charm_state_vfx() {
  foreach(var_1 in level.soul_collection_models) {
    set_coll_state(var_1, "none");
  }
}

all_soul_charm_full() {
  foreach(var_1 in level.soul_collection_models) {
    if(var_1.current_collection_state != "full") {
      return 0;
    }
  }

  return 1;
}

update_soul_collected(var_0, var_1) {
  var_0.soul_collected = clamp(var_0.soul_collected + var_1, 0, 30);
  var_2 = get_new_coll_state(var_0.soul_collected);
  set_coll_state(var_0, var_2);
}

soul_deplete_mon(var_0) {
  var_0 notify("soul_deplete_mon");
  level endon("charm_sequence_complete");
  var_0 endon("death");
  var_0 endon("soul_deplete_mon");
  wait(50);
  var_1 = 20;
  var_2 = var_1 / 30;
  var_3 = var_0.soul_collected;
  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_0 moveto(var_0.origin - (0, 0, var_1), var_2);
    var_0 waittill("movedone");
    update_soul_collected(var_0, -1);
  }
}

move_up(var_0) {
  var_1 = int(20);
  var_2 = var_0.original_pos + (0, 0, var_1) * var_0.soul_collected;
  if(var_0.origin != var_2) {
    var_3 = abs(var_2[2] - var_0.origin[2]) / 60;
    var_0 moveto(var_2, var_3, var_3 / 2, var_3 / 2);
  }
}

get_new_coll_state(var_0) {
  var_1 = int(15);
  if(var_0 == 30) {
    return "full";
  }

  if(var_0 < 30 && var_0 >= var_1) {
    return "medium";
  }

  if(var_0 < var_1 && var_0 > 0) {
    return "small";
  }

  return "none";
}

set_coll_state(var_0, var_1) {
  if(!isDefined(var_0.current_collection_state)) {
    var_0.current_collection_state = "";
  }

  if(var_0.current_collection_state == var_1) {
    return;
  }

  var_0 setscriptablepartstate("fx", var_1);
  if(isDefined(var_0.current_state_vfx)) {
    var_0.current_state_vfx delete();
  }

  var_0.current_collection_state = var_1;
  if(var_1 != "none") {
    var_0.current_state_vfx = spawnfx(level._effect["soul_charm_beam_" + var_1], var_0.original_pos, (1, 0, 0), (0, 0, 1));
    triggerfx(var_0.current_state_vfx);
  }
}

zom_die_soul_mon() {
  level endon("charm_sequence_complete");
  level.soul_charm_queue = [];
  level.cp_rave_zombie_death_pos_record_func = ::add_to_zombie_death_pos_record;
  for(;;) {
    if(level.soul_charm_queue.size > 0) {
      var_0 = level.soul_charm_queue[0];
      level.soul_charm_queue = scripts\engine\utility::array_remove(level.soul_charm_queue, var_0);
      var_1 = var_0.pos;
      var_2 = scripts\engine\utility::getclosest(var_1, level.soul_collection_models);
      if(distance2dsquared(var_1, var_2.origin) <= 250000) {
        level thread soul_fly_charm(var_1, var_2);
      }

      scripts\engine\utility::waitframe();
      continue;
    }

    level waittill("zombie_killed");
  }
}

add_to_zombie_death_pos_record(var_0) {
  var_1 = spawnStruct();
  var_1.pos = var_0;
  level.soul_charm_queue[level.soul_charm_queue.size] = var_1;
}

soul_fly_charm(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin_soultrail");
  for(;;) {
    var_3 = var_1.origin;
    var_4 = var_2.origin;
    var_5 = distance(var_4, var_3);
    var_6 = var_5 / 600;
    if(var_6 < 0.05) {
      var_6 = 0.05;
    }

    var_2 moveto(var_3, var_6);
    wait(0.05);
    if(isDefined(var_1) && distancesquared(var_2.origin, var_1.origin) > 256) {
      continue;
    } else {
      break;
    }
  }

  var_1 notify("soul_collected");
  var_2 delete();
}

slasher_abilities_trap(var_0) {
  self.bmayshockwave = 0;
  self.bmayfrisbee = 0;
}

summon_a_zombie_at(var_0, var_1) {
  var_0 = scripts\engine\utility::drop_to_ground(var_0, 30, -100);
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.script_parameters = "ground_spawn_no_boards";
  var_2.script_animation = "spawn_ground";
  var_3 = var_2 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy(get_spawn_type(), 1);
  if(isDefined(var_3)) {
    var_3.dont_cleanup = 1;
    var_3 thread play_intro(var_3, var_0, var_1);
    return var_3;
  }
}

play_intro(var_0, var_1, var_2) {
  var_3 = (0, 0, -11);
  if(scripts\engine\utility::istrue(var_2)) {
    var_0 scragentsetanimscale(0, 1);
  }

  var_4 = spawnfx(level._effect["superslasher_summon_zombie_portal"], var_1 + var_3, (0, 0, 1), (1, 0, 0));
  triggerfx(var_4);
  playsoundatpos(var_1 + var_3, "zmb_superslasher_summon_activate");
  var_5 = thread scripts\engine\utility::play_loopsound_in_space("zmb_superslasher_summon_activate_lp", var_1 + var_3);
  var_0 scripts\engine\utility::waittill_any("death", "intro_vignette_done");
  if(scripts\engine\utility::istrue(var_2) && isDefined(var_0)) {
    var_0 scragentsetanimscale(1, 1);
  }

  playsoundatpos(var_1 + var_3, "zmb_superslasher_summon_deactivate");
  var_5 stoploopsound();
  var_4 delete();
  var_0.synctransients = "sprint";
  wait(0.05);
  var_5 delete();
}

unlimited_zombie_spawn() {
  level endon("stop_unlimited_spawn");
  scripts\engine\utility::flag_init("stop_unlimited_spawn");
  scripts\engine\utility::flag_init("start_unlimited_spawn");
  scripts\engine\utility::flag_wait("start_unlimited_spawn");
  for(;;) {
    spawn_up_to_goal();
    wait_clear_wave();
    wait(get_wait_between_wave());
  }
}

stop_spawn_wave() {
  scripts\engine\utility::flag_set("pause_wave_progression");
  level.zombies_paused = 1;
  level.dont_resume_wave_after_solo_afterlife = 1;
}

resume_spawn_wave() {
  level.dont_resume_wave_after_solo_afterlife = undefined;
  level.zombies_paused = 0;
  scripts\engine\utility::flag_clear("pause_wave_progression");
}

clear_existing_enemies() {
  foreach(var_1 in level.spawned_enemies) {
    var_1.died_poorly = 1;
    var_1.nocorpse = 1;
    var_1 suicide();
  }

  scripts\engine\utility::waitframe();
}

spawn_up_to_goal() {
  var_0 = get_num_of_zombies_to_spawn();
  var_1 = 0;
  while(var_1 < var_0) {
    var_2 = level thread summon_a_zombie_at(get_zombie_spawn_spot(), 1);
    wait(get_wait_between_spawn());
    if(isDefined(var_2)) {
      var_1++;
      var_2.dont_cleanup = 1;
      continue;
    }

    wait(get_wait_between_spawn());
    var_0 = get_num_of_zombies_to_spawn();
  }
}

wait_clear_wave() {
  if(get_spawn_mode() == "wave") {
    for(;;) {
      if(level.current_num_spawned_enemies == 0) {
        break;
      }

      wait(1);
    }
  }
}

reg_spawns() {
  level.super_slasher_zombie_spawn_loc = scripts\engine\utility::getStructArray("super_slasher_zombie_spawn_loc", "script_noteworthy");
  var_0 = gettime();
  foreach(var_2 in level.super_slasher_zombie_spawn_loc) {
    var_2.previous_used_time_stamp = var_0;
  }
}

get_close_zom_spawn(var_0) {
  var_1 = 4000;
  var_2 = 360000;
  var_3 = sortbydistance(level.super_slasher_zombie_spawn_loc, var_0);
  var_4 = var_3[0];
  var_5 = gettime();
  foreach(var_7 in var_3) {
    if(distance2dsquared(var_0, var_7.origin) < var_2) {
      continue;
    }

    if(var_7.previous_used_time_stamp + var_1 < var_5) {
      var_7.previous_used_time_stamp = var_5;
      var_4 = var_7;
      break;
    }
  }

  return var_4.origin;
}

get_zombie_spawn_spot() {
  switch (get_zombie_spawn_location()) {
    case "near_player":
      var_0 = get_random_available_player();
      if(isDefined(var_0)) {
        return get_close_zom_spawn(var_0.origin);
      } else {
        var_1 = scripts\engine\utility::random(level.super_slasher_zombie_spawn_loc);
        return var_1.origin;
      }

      break;

    case "shockwave":
      var_2 = get_least_targeted_player();
      if(isDefined(var_2)) {
        return get_spawn_shockwave(var_2);
      } else {
        var_1 = scripts\engine\utility::random(level.super_slasher_zombie_spawn_loc);
        return var_1.origin;
      }

      break;

    default:
      var_1 = scripts\engine\utility::random(level.super_slasher_zombie_spawn_loc);
      return var_1.origin;
  }
}

get_least_targeted_player() {
  var_0 = gettime();
  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }

    if(!isDefined(var_2.last_shockwave_spawn_target_time)) {
      var_2.last_shockwave_spawn_target_time = var_0;
      return var_2;
    }
  }

  var_4 = 999999999;
  var_5 = undefined;
  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }

    if(var_2.last_shockwave_spawn_target_time < var_4) {
      var_4 = var_2.last_shockwave_spawn_target_time;
      var_5 = var_2;
    }
  }

  if(isDefined(var_5)) {
    var_5.last_shockwave_spawn_target_time = var_0;
    return var_5;
  }

  return undefined;
}

get_spawn_shockwave(var_0) {
  if(isDefined(var_0.super_slasher_shockwave_safe_area) && ispointinvolume(var_0.origin, var_0.super_slasher_shockwave_safe_area)) {
    var_1 = scripts\engine\utility::getStructArray(var_0.super_slasher_shockwave_safe_area.target, "targetname");
    var_2 = scripts\engine\utility::random(var_1);
    return var_2.origin;
  }

  return get_close_zom_spawn(var_2.origin);
}

get_random_available_player() {
  var_0 = [];
  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }

    var_0[var_0.size] = var_2;
  }

  return scripts\engine\utility::random(var_0);
}

activate_super_slasher_barrier(var_0) {
  level endon("game_ended");
  if(!isDefined(level.active_super_slasher_barrierfunc_list)) {
    level.active_super_slasher_barrierfunc_list = [];
  }

  var_1 = getent("super_slasher_barrier_" + var_0, "targetname");
  if(isDefined(var_1)) {
    var_2 = var_1.origin;
    var_3 = (var_2[0], var_2[1], var_2[2] - 1024);
    var_1 moveto(var_3, 0.05);
    var_1 waittill("movedone");
    var_1 disconnectpaths();
  }

  var_1.barrier_models = [];
  play_barrier_sfx(var_0);
  var_4 = scripts\engine\utility::getStructArray(var_1.target, "targetname");
  foreach(var_6 in var_4) {
    var_1 thread barrier_deploy_sequence(var_1, var_6);
    scripts\engine\utility::waitframe();
  }

  level.active_super_slasher_barrierfunc_list[level.active_super_slasher_barrierfunc_list.size] = var_0;
}

play_barrier_sfx(var_0) {
  var_1 = undefined;
  switch (var_0) {
    case 1:
      var_1 = (-4265, 4876, -89);
      break;

    case 2:
      var_1 = (-4449, 4402, -95);
      break;

    case 3:
      var_1 = (-4637, 5528, -91);
      break;

    case 4:
      var_1 = (-4730, 4012, -103);
      break;
  }

  playsoundatpos(var_1, "superslasher_barrier_spawn_lr");
}

barrier_deploy_sequence(var_0, var_1) {
  playFX(level._effect["punji_tell"], var_1.origin, anglesToForward(var_1.angles), anglestoup(var_1.angles));
  wait(2);
  var_2 = spawn("script_model", var_1.origin + (0, 0, -60));
  var_2 setModel("cp_rave_door_sized_collision");
  var_2 setscriptablepartstate("door_effect", "active");
  var_2.angles = var_1.angles + (0, 90, 0);
  var_0.barrier_models[var_0.barrier_models.size] = var_2;
}

deactivate_super_slasher_barrier(var_0) {
  if(!scripts\engine\utility::array_contains(level.active_super_slasher_barrierfunc_list, var_0)) {
    return;
  }

  var_1 = getent("super_slasher_barrier_" + var_0, "targetname");
  if(isDefined(var_1)) {
    var_2 = var_1.origin;
    var_3 = (var_2[0], var_2[1], var_2[2] + 1024);
    var_1 moveto(var_3, 0.05);
    var_1 waittill("movedone");
    var_1 connectpaths();
  }

  foreach(var_5 in var_1.barrier_models) {
    var_5 thread barrier_destroy_sequence(var_5);
    scripts\engine\utility::waitframe();
  }

  var_1.barrier_models = [];
  level.active_super_slasher_barrierfunc_list = scripts\engine\utility::array_remove(level.active_super_slasher_barrierfunc_list, var_0);
}

barrier_destroy_sequence(var_0) {
  playFX(level._effect["punji_subside"], var_0.origin);
  wait(2);
  var_0 delete();
}

deactivate_all_super_slasher_barriers() {
  if(!isDefined(level.active_super_slasher_barrierfunc_list)) {
    return;
  }

  foreach(var_1 in level.active_super_slasher_barrierfunc_list) {
    deactivate_super_slasher_barrier(var_1);
  }
}

set_zombie_spawning_parameters(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.spawn_mode = var_0;
  var_6.num_of_zombies_to_spawn = var_1;
  var_6.wait_between_spawn = var_2;
  var_6.wait_between_wave = var_3;
  var_6.spawn_location = var_4;
  var_6.spawn_type = var_5;
  level.slasher_spawning = var_6;
}

get_num_of_zombies_to_spawn() {
  return level.slasher_spawning.num_of_zombies_to_spawn;
}

get_zombie_spawn_location() {
  return level.slasher_spawning.spawn_location;
}

get_wait_between_spawn() {
  return level.slasher_spawning.wait_between_spawn;
}

get_wait_between_wave() {
  return level.slasher_spawning.wait_between_wave;
}

get_spawn_mode() {
  return level.slasher_spawning.spawn_mode;
}

get_spawn_type() {
  return level.slasher_spawning.spawn_type;
}

kill_off_existing_zombies() {
  var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_2 in var_0) {
    var_2.precacheleaderboards = 1;
    var_2.is_burning = 1;
    var_2.nocorpse = undefined;
    var_2 thread scripts\cp\loot::kill_selected_enemy(1);
    scripts\engine\utility::waitframe();
  }
}

try_drop_max_ammo() {
  var_0 = (-5181, 4623, -103);
  if(!scripts\engine\utility::flag("max_ammo_active")) {
    scripts\engine\utility::flag_set("max_ammo_active");
    level thread[[level.drop_max_ammo_func]](var_0, undefined, "ammo_max");
  }
}

max_ammo_manager() {
  level thread unlimited_max_ammo();
  level thread max_ammo_pick_up_listener();
}

unlimited_max_ammo() {
  level endon("game_ended");
  level endon("super_slasher_fight_complete");
  var_0 = 360;
  for(;;) {
    wait(var_0);
    try_drop_max_ammo();
  }
}

max_ammo_pick_up_listener() {
  level endon("game_ended");
  level endon("super_slasher_fight_complete");
  for(;;) {
    level waittill("pick_up_max_ammo");
    scripts\engine\utility::flag_clear("max_ammo_active");
  }
}

put_on_happy_face(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  wait(0.1);
  playFXOnTag(level._effect["happy_face"], var_0, "j_head");
}

switch_to_sad_face(var_0) {
  stopFXOnTag(level._effect["happy_face"], var_0, "j_head");
  playFXOnTag(level._effect["sad_face"], var_0, "j_head");
}

drop_soul_key() {
  var_0 = (-4880, 4710, -87);
  if(isDefined(level.soul_key_drop_pos)) {
    var_0 = level.soul_key_drop_pos;
  }

  var_1 = spawn("script_model", var_0);
  var_1 setModel("zmb_soul_key_single");
  var_2 = spawnfx(level._effect["soul_key_glow"], var_1.origin);
  triggerfx(var_2);
  var_1 thread item_keep_rotating(var_1);
  var_1 thread soul_key_pick_up_monitor(var_1, var_2);
}

soul_key_pick_up_monitor(var_0, var_1) {
  var_0 endon("death");
  var_0 makeusable();
  var_0 sethintstring(&"CP_RAVE_PICK_UP_SOUL_KEY");
  for(;;) {
    var_0 waittill("trigger", var_2);
    if(isPlayer(var_2)) {
      stop_spawn_wave();
      var_2 playlocalsound("part_pickup");
      scripts\cp\zombies\directors_cut::give_dc_player_extra_xp_for_carrying_newb();
      foreach(var_2 in level.players) {
        var_2 setplayerdata("cp", "haveSoulKeys", "any_soul_key", 1);
        var_2 setplayerdata("cp", "haveSoulKeys", "soul_key_2", 1);
        var_2 scripts\cp\zombies\achievement::update_achievement("LOCKSMITH", 1);
      }

      break;
    }
  }

  clear_existing_enemies();
  scripts\cp\utility::play_bink_video("zombies_cp_rave_outro", 32, 1);
  level thread delay_resume_wave_progression();
  level thread delay_try_drop_talisman(var_0.origin);
  var_1 delete();
  var_0 delete();
}

delay_try_drop_talisman(var_0) {
  level endon("game_ended");
  wait(32);
  level thread scripts\cp\zombies\directors_cut::try_drop_talisman(var_0, vectortoangles((0, 1, 0)));
}

delay_resume_wave_progression() {
  level endon("game_ended");
  wait(37);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_easteregg_complete", "rave_announcer_vo", "highest", 5, 0, 0, 1);
  level.pause_nag_vo = 0;
  resume_spawn_wave();
}

deploy_stair_barrier() {
  var_0 = getent("super_slasher_stair_clip", "targetname");
  var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  playFX(level._effect["super_slasher_saw_shark_hit"], scripts\engine\utility::drop_to_ground(var_1.origin, 50, -500));
  var_2 = var_0.origin;
  var_3 = (var_2[0], var_2[1], var_2[2] - 1024);
  var_0 moveto(var_3, 0.05);
  var_0 waittill("movedone");
  var_0 disconnectpaths();
  var_4 = spawn("script_model", var_1.origin);
  var_4 setModel("cp_rave_punji_stream");
  var_4.angles = var_1.angles;
  var_0.stair_barrier_model = var_4;
}

destroy_stair_barrier() {
  var_0 = getent("super_slasher_stair_clip", "targetname");
  playFX(level._effect["super_slasher_saw_shark_hit"], scripts\engine\utility::drop_to_ground(var_0.stair_barrier_model.origin, 50, -500));
  var_0 connectpaths();
  var_1 = var_0.origin;
  var_2 = (var_1[0], var_1[1], var_1[2] + 1024);
  var_0 moveto(var_2, 0.05);
  var_0 waittill("movedone");
  var_0.stair_barrier_model delete();
}

activate_fight_stage_vfx() {
  level.super_slasher_fight_stage_vfx = [];
  spawn_fight_stage_vfx(1, (-6170, 5352, 553), anglesToForward((0, -55, 0)));
  spawn_fight_stage_vfx(2, (-6035, 4322, 553), anglesToForward((0, 55, 0)));
  spawn_fight_stage_vfx(3, (-6345, 4784, 553), anglesToForward((0, 7, 0)));
}

spawn_fight_stage_vfx(var_0, var_1, var_2) {
  var_3 = spawnfx(level._effect["fight_stage"], var_1, var_2);
  triggerfx(var_3);
  level.super_slasher_fight_stage_vfx[var_0] = var_3;
}

delete_fight_stage_vfx(var_0) {
  var_1 = level.super_slasher_fight_stage_vfx[var_0];
  var_1 delete();
}

watch_for_player_deaths() {
  level endon("super_slasher_fight_complete");
  while(!scripts\engine\utility::flag("super_slasher_fight_complete")) {
    level waittill("player_entered_ala", var_0);
    var_0 thread scripts\cp\maps\cp_rave\cp_rave::exit_rave_mode(var_0);
    var_0 thread watch_for_revive(var_0);
  }
}

watch_for_revive(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  if(scripts\engine\utility::istrue(var_0.unlimited_rave)) {
    var_0 thread scripts\cp\maps\cp_rave\cp_rave::enter_rave_mode(var_0);
  }
}