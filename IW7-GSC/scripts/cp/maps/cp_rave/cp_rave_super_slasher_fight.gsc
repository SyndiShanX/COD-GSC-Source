/*******************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight.gsc
*******************************************************************/

init_super_slasher_quest() {
  load_super_slasher_vfx();
  start_super_slasher_quest();
}

start_super_slasher_quest() {
  scripts\cp\zombies\zombie_quest::register_quest_step("superslasher", 0, ::scripts\cp\maps\cp_rave\cp_rave_interactions::init_survivor_trapped, ::scripts\cp\maps\cp_rave\cp_rave_interactions::wait_for_survivor_trapped, ::blank, ::debug_trap_survivor);
  scripts\cp\zombies\zombie_quest::register_quest_step("superslasher", 1, ::scripts\cp\maps\cp_rave\cp_rave_interactions::init_survivor_released, ::scripts\cp\maps\cp_rave\cp_rave_interactions::wait_for_survivor_released, ::debug_release_survivor, ::debug_release_survivor);
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
  level.getspawnpoint = ::scripts\cp\maps\cp_rave\cp_rave::respawn_on_island;
  scripts\engine\utility::flag_clear("survivor_released");
  level notify("end_boat_hotjoin");
  level.boat_vehicle vehicle_teleport(level.boat_start_node.origin, level.boat_start_node.angles);
  level.boat_vehicle attachpath(level.boat_start_node);
  scripts\cp\cp_interaction::add_to_current_interaction_list(level.boat_interaction_struct);
  move_lost_and_found("island");
  scripts\cp\maps\cp_rave\cp_rave_boat::fade_in_for_ss_fight();
}

move_lost_and_found(param_00) {
  if(!isDefined(level.lnf_struct)) {
    level.lnf_struct = scripts\engine\utility::getstruct("lost_and_found", "script_noteworthy");
    level.lnf_struct.og_origin = level.lnf_struct.origin;
  }

  if(param_00 == "island") {
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

  foreach(var_02 in level.players) {
    if(!isDefined(var_02.lost_and_found_ent)) {
      continue;
    }

    var_02.lost_and_found_ent.origin = level.lnf_struct.origin + (0, 0, 45);
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
  level.force_respawn_location = ::scripts\cp\maps\cp_rave\cp_rave::respawn_on_island;
  soul_collection_sequence_init();
  thread scripts\cp\maps\cp_rave\cp_rave::deactivateadjacentvolumes();
  wait(2);
  level notify("ss_intro_finished");
  foreach(var_01 in level.players) {
    var_01 playsoundtoplayer(var_01.vo_prefix + "slasher_super_first", var_01);
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
  level.getspawnpoint = ::scripts\cp\cp_globallogic::defaultgetspawnpoint;
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
  foreach(var_01 in level.players) {
    if(var_01 scripts\cp\utility::isteleportenabled()) {
      var_01 scripts\cp\utility::allow_player_teleport(0);
    }
  }

  for(;;) {
    level waittill("connected", var_03);
    if(var_03 scripts\cp\utility::isteleportenabled()) {
      var_03 scripts\cp\utility::allow_player_teleport(0);
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
  foreach(var_01 in level.players) {
    if(!var_01 scripts\cp\utility::isteleportenabled()) {
      var_01 scripts\cp\utility::allow_player_teleport(1);
    }
  }

  if(isDefined(level.volumes_before_fight) && level.volumes_before_fight.size > 1) {
    foreach(var_04 in level.volumes_before_fight) {
      var_04 scripts\cp\zombies\zombies_spawning::make_volume_active();
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
  var_00 = level.players;
  var_01 = scripts\engine\utility::random(var_00);
  switch (var_01.vo_prefix) {
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

use_memory_trap(param_00, param_01) {}

slasher_trapped(param_00) {
  var_01 = 0.5;
  level notify("super_slasher_is_trapped");
  level.superslasher scripts\aitypes\superslasher\util::forcetrapped(6);
  try_drop_max_ammo();
  deactivate_all_super_slasher_barriers();
  param_00.memory_trap_vfx_ent delete();
  var_02 = spawnfx(level._effect["memory_trap_start"], param_00.memory_trap_loc);
  triggerfx(var_02);
  wait(var_01);
  var_02 delete();
  var_03 = spawnfx(level._effect["memory_trap_loop"], param_00.memory_trap_loc);
  triggerfx(var_03);
  wait(6 - var_01);
  var_03 delete();
  param_00.completed = 1;
  level.superslasher slasher_weakspot_phase(level.superslasher.fight_round);
  level.superslasher thread activate_weak_spots(level.superslasher);
}

get_trap_trigger() {
  var_00 = scripts\engine\utility::getstructarray("memory_trap_trigger", "script_noteworthy");
  var_01 = [];
  foreach(var_03 in var_00) {
    if(scripts\engine\utility::istrue(var_03.completed)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  var_05 = scripts\engine\utility::random(var_01);
  set_up_trap_trigger(var_05);
  return var_05;
}

init_memory_traps() {
  var_00 = scripts\engine\utility::getstructarray("memory_trap_trigger", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.completed = 0;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_02);
  }
}

set_up_trap_trigger(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00.target, "targetname");
  param_00.floating_charm_locs = [];
  foreach(var_03 in var_01) {
    switch (var_03.script_noteworthy) {
      case "memory_trap_model":
        param_00.model_loc = var_03.origin;
        param_00.model_angles = var_03.angles;
        break;

      case "memory_trap_loc":
        param_00.memory_trap_loc = var_03.origin;
        break;

      case "floating_charm_loc":
        param_00.floating_charm_locs[param_00.floating_charm_locs.size] = var_03;
        break;
    }
  }
}

activate_trap_trigger(param_00) {
  var_01 = scripts\engine\utility::drop_to_ground(param_00.memory_trap_loc, 0, -500);
  var_02 = spawn("script_model", var_01);
  var_02 setModel("tag_origin");
  param_00.memory_trap_vfx_ent = var_02;
  wait(0.1);
  set_memory_trap_state(var_02, "idle");
  playsoundatpos(var_01, "superslasher_damage_trap_portal_open_lr");
  param_00 thread slasher_in_trap(param_00, var_01);
}

set_memory_trap_state(param_00, param_01) {
  if(!isDefined(param_00.current_state)) {
    param_00.current_state = "";
  }

  if(param_00.current_state == param_01) {
    return;
  }

  if(param_00.current_state != "") {
    stopFXOnTag(level._effect["memory_trap_" + param_00.current_state], param_00, "tag_origin");
  }

  param_00.current_state = param_01;
  playFXOnTag(level._effect["memory_trap_" + param_01], param_00, "tag_origin");
}

slasher_in_trap(param_00, param_01) {
  param_00 endon("initial_weak_spot_hit");
  var_02 = 22500;
  for(;;) {
    if(isDefined(level.superslasher)) {
      if(distance2dsquared(level.superslasher.origin, param_01) <= var_02) {
        activate_initial_weak_spot(param_00);
      } else {
        deactivate_initial_weak_spot(param_00);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

activate_initial_weak_spot(param_00) {
  set_memory_trap_state(param_00.memory_trap_vfx_ent, "active");
  if(!isDefined(level.superslasher.initial_weak_spot)) {
    var_01 = scripts\engine\utility::random(["tag_chest_le", "tag_chest_ri"]);
    level.superslasher.initial_weak_spot = set_up_weak_spot(var_01, level.superslasher, "initial_weak_spot");
    level.superslasher.initial_weak_spot.weak_spot_model thread initial_weak_spot_damage_monitor(level.superslasher.initial_weak_spot.weak_spot_model, param_00);
  }
}

initial_weak_spot_damage_monitor(param_00, param_01) {
  param_00 endon("death");
  param_00.health = 9999999;
  param_00 setCanDamage(1);
  for(;;) {
    param_00 waittill("damage", var_02, var_03, var_04, var_05);
    param_00.health = 9999999;
    if(isDefined(var_03)) {
      if(var_03 == level.superslasher) {
        continue;
      }

      if(!isplayer(var_03)) {
        continue;
      }

      var_06 = var_04 * -1;
      playFX(level._effect["initial_weak_spot_hit"], var_05, var_06);
      break;
    }
  }

  foreach(var_08 in level.players) {
    var_08.unlimited_rave = 0;
    scripts\cp\maps\cp_rave\cp_rave::exit_rave_mode(var_08);
  }

  level thread slasher_trapped(param_01);
  param_01 notify("initial_weak_spot_hit");
  level.superslasher.initial_weak_spot.weak_spot_vfx_ent delete();
  level.superslasher.initial_weak_spot = undefined;
  playsoundatpos(level.superslasher.origin, "superslasher_damage_trap_lr");
  param_00 delete();
}

deactivate_initial_weak_spot(param_00) {
  set_memory_trap_state(param_00.memory_trap_vfx_ent, "idle");
  if(isDefined(level.superslasher.initial_weak_spot)) {
    level.superslasher.initial_weak_spot.weak_spot_model delete();
    level.superslasher.initial_weak_spot.weak_spot_vfx_ent delete();
    level.superslasher.initial_weak_spot = undefined;
  }
}

slasher_weakspot_phase(param_00) {
  self.bmaystomp = 1;
  self.bmayjumpattack = 1;
  self.bmayfrisbee = 0;
  self.bmaysawfan = 0;
  self.bmayshockwave = 0;
  self.bmaywire = 0;
  self.bmayshark = 0;
  self.animratescale = 1.1 + min(param_00, 3) * 0.15;
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

register_memory_weak_spot(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.tag_name = param_00;
  var_04.damage_model_offset = param_01;
  var_04.vfx_offset = param_02;
  var_04.angular_offset = param_03;
  level.super_slasher_weak_spots[param_00] = var_04;
}

activate_weak_spots(param_00) {
  param_00 endon("death");
  var_01 = get_potential_weak_spot_tags();
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(var_02 > 0) {
      wait(5);
    }

    complete_weak_spot(var_01[var_02], param_00, get_weak_spot_hit_vfx_index(var_02));
  }

  try_drop_max_ammo();
  param_00 scripts\aitypes\superslasher\util::forcetrapped(6);
  wait(6);
  delete_fight_stage_vfx(param_00.fight_round);
  if(param_00.fight_round == 3) {
    switch_to_sad_face(param_00);
    slasher_abilities_final();
    return;
  }

  param_00.bmayshockwave = 1;
  param_00 scripts\aitypes\superslasher\util::requestshockwave();
  if(distance2dsquared(param_00.origin, level.superslashergotogroundspot) > 4096) {
    param_00 scripts\aitypes\superslasher\util::dosawsharks();
  }
}

complete_weak_spot(param_00, param_01, param_02) {
  var_03 = set_up_weak_spot(param_00, param_01, "memory_weak_spot");
  var_03.weak_spot_model weak_spot_damage_monitor(var_03.weak_spot_model, param_01, 900 * level.players.size, param_02);
  var_03.weak_spot_model delete();
  var_03.weak_spot_vfx_ent delete();
}

set_up_weak_spot(param_00, param_01, param_02) {
  var_03 = level.super_slasher_weak_spots[param_00];
  var_04 = var_03.tag_name;
  var_05 = param_01 gettagorigin(var_04);
  var_06 = spawn("script_model", var_05);
  var_06 setModel("tag_origin");
  wait(0.1);
  var_05 = param_01 gettagorigin(var_04);
  var_07 = spawn("script_model", var_05);
  var_07 setModel("zmb_superslasher_weak_spot");
  var_07 linkto(param_01, var_04, var_03.damage_model_offset, var_03.angular_offset);
  var_07 getrandomweaponfromcategory();
  playFXOnTag(level._effect[param_02], var_06, "tag_origin");
  var_06 linkto(param_01, var_04, var_03.vfx_offset, var_03.angular_offset);
  var_08 = spawnStruct();
  var_08.weak_spot_vfx_ent = var_06;
  var_08.weak_spot_model = var_07;
  return var_08;
}

weak_spot_damage_monitor(param_00, param_01, param_02, param_03) {
  param_00 endon("death");
  param_00.health = 9999999;
  param_00 setCanDamage(1);
  param_00.fake_health = param_02;
  for(;;) {
    param_00 waittill("damage", var_04, var_05, var_06, var_07);
    param_00.health = 9999999;
    if(isDefined(var_05)) {
      if(var_05 == param_01) {
        continue;
      }

      if(!isplayer(var_05)) {
        continue;
      }

      var_08 = var_06 * -1;
      playFX(level._effect[param_03], var_07, var_08);
      playsoundatpos(param_00.origin, "superslasher_pain_magic_hits");
      param_00.fake_health = param_00.fake_health - var_04;
      if(param_00.fake_health <= 0) {
        break;
      }
    }
  }
}

get_potential_weak_spot_tags() {
  var_00 = ["tag_chest_le", "tag_chest_ri", "tag_thigh_le", "tag_thigh_ri", "tag_shoulder1_le", "tag_shoulder1_ri", "tag_shoulder2_le", "tag_shoulder2_ri"];
  return scripts\engine\utility::array_randomize(var_00);
}

get_weak_spot_hit_vfx_index(param_00) {
  var_01 = ["weak_spot_J_hit", "weak_spot_A_hit", "weak_spot_Y_hit", "weak_spot_M_hit", "weak_spot_E_hit", "weak_spot_W_hit", "weak_spot_E_hit", "weak_spot_S_hit"];
  return var_01[param_00];
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

slasher_abilities_collection(param_00) {
  self.bmaystomp = 1;
  self.bmayjumpattack = 1;
  self.bmayfrisbee = 0;
  self.bmaysawfan = 0;
  self.bmaywire = param_00 != 1;
  self.bmayshark = 0;
}

soul_collection_sequence_init() {
  scripts\engine\utility::flag_init("charm_sequence_complete");
  scripts\engine\utility::flag_init("max_ammo_active");
  var_00 = (-5083, 3909, -89);
  var_01 = "zmb_soul_charm";
  var_02 = (-3990, 5655, -163);
  var_03 = "zmb_soul_charm";
  var_04 = (-4469, 4634, -126);
  var_05 = "zmb_soul_charm";
  var_06 = (-4746, 5504, -101);
  var_07 = "zmb_soul_charm";
  var_08 = (-4095, 3968, -124);
  var_09 = "zmb_soul_charm";
  register_soul_collection_loc(var_00, var_01);
  register_soul_collection_loc(var_02, var_03);
  register_soul_collection_loc(var_04, var_05);
  register_soul_collection_loc(var_06, var_07);
  register_soul_collection_loc(var_08, var_09);
  level.superslasher.fight_round = 0;
  self.animratescale = 1.1;
}

soul_collection_sequence() {
  foreach(var_01 in level.players) {
    var_01.unlimited_rave = 1;
    scripts\cp\maps\cp_rave\cp_rave::enter_rave_mode(var_01);
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

register_soul_collection_loc(param_00, param_01) {
  if(!isDefined(level.soul_collection_locs)) {
    level.soul_collection_locs = [];
  }

  var_02 = spawnStruct();
  var_02.pos = param_00;
  var_02.model = param_01;
  level.soul_collection_locs[level.soul_collection_locs.size] = var_02;
}

activate_soul_collection_locs() {
  level.soul_collection_models = [];
  var_00 = level.players.size;
  for(var_01 = 0; var_01 <= var_00; var_01++) {
    activate_soul_collection_loc(level.soul_collection_locs[var_01]);
    scripts\engine\utility::waitframe();
  }
}

activate_soul_collection_loc(param_00) {
  var_01 = spawn("script_model", param_00.pos);
  var_01 setModel(param_00.model);
  var_01 thread item_keep_rotating(var_01);
  var_01 setscriptablepartstate("fx", "none");
  var_01.original_pos = param_00.pos;
  var_01 thread soul_collection_monitor(var_01);
  level.soul_collection_models[level.soul_collection_models.size] = var_01;
}

item_keep_rotating(param_00) {
  param_00 endon("death");
  var_01 = param_00.angles;
  for(;;) {
    param_00 rotateto(var_01 + (randomintrange(-40, 40), randomintrange(-40, 90), randomintrange(-40, 90)), 3);
    wait(3);
  }
}

soul_collection_monitor(param_00) {
  param_00 endon("death");
  level endon("charm_sequence_complete");
  set_coll_state(param_00, "none");
  param_00.soul_collected = 0;
  for(;;) {
    param_00 waittill("soul_collected");
    update_soul_collected(param_00, 1);
    move_up(param_00);
    if(all_soul_charm_full()) {
      level thread mem_trap_seq();
      continue;
    }

    param_00 thread soul_deplete_mon(param_00);
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
  var_00 = get_trap_trigger();
  vfx_point_to_trap(var_00);
  charm_fly_to_trap_loc(var_00);
  activate_trap_trigger(var_00);
}

vfx_point_to_trap(param_00) {
  var_01 = param_00.memory_trap_loc;
  var_02 = int(60);
  for(var_03 = 0; var_03 < var_02; var_03++) {
    foreach(var_05 in level.soul_collection_models) {
      var_06 = var_05.origin;
      var_07 = var_01 - var_06;
      var_08 = vectortoangles(var_07);
      playfxbetweenpoints(level._effect["charm_to_trap"], var_06, var_08, var_01);
    }

    scripts\engine\utility::waitframe();
  }
}

charm_fly_to_trap_loc(param_00) {
  var_01 = param_00.memory_trap_loc;
  foreach(var_03 in level.soul_collection_models) {
    var_03 moveto(var_01, 1.5);
  }

  wait(1.5);
  foreach(var_03 in level.soul_collection_models) {
    if(isDefined(var_03)) {
      var_03 delete();
    }
  }
}

turn_off_charm_state_vfx() {
  foreach(var_01 in level.soul_collection_models) {
    set_coll_state(var_01, "none");
  }
}

all_soul_charm_full() {
  foreach(var_01 in level.soul_collection_models) {
    if(var_01.current_collection_state != "full") {
      return 0;
    }
  }

  return 1;
}

update_soul_collected(param_00, param_01) {
  param_00.soul_collected = clamp(param_00.soul_collected + param_01, 0, 30);
  var_02 = get_new_coll_state(param_00.soul_collected);
  set_coll_state(param_00, var_02);
}

soul_deplete_mon(param_00) {
  param_00 notify("soul_deplete_mon");
  level endon("charm_sequence_complete");
  param_00 endon("death");
  param_00 endon("soul_deplete_mon");
  wait(50);
  var_01 = 20;
  var_02 = var_01 / 30;
  var_03 = param_00.soul_collected;
  for(var_04 = 0; var_04 < var_03; var_04++) {
    param_00 moveto(param_00.origin - (0, 0, var_01), var_02);
    param_00 waittill("movedone");
    update_soul_collected(param_00, -1);
  }
}

move_up(param_00) {
  var_01 = int(20);
  var_02 = param_00.original_pos + (0, 0, var_01) * param_00.soul_collected;
  if(param_00.origin != var_02) {
    var_03 = abs(var_02[2] - param_00.origin[2]) / 60;
    param_00 moveto(var_02, var_03, var_03 / 2, var_03 / 2);
  }
}

get_new_coll_state(param_00) {
  var_01 = int(15);
  if(param_00 == 30) {
    return "full";
  }

  if(param_00 < 30 && param_00 >= var_01) {
    return "medium";
  }

  if(param_00 < var_01 && param_00 > 0) {
    return "small";
  }

  return "none";
}

set_coll_state(param_00, param_01) {
  if(!isDefined(param_00.current_collection_state)) {
    param_00.current_collection_state = "";
  }

  if(param_00.current_collection_state == param_01) {
    return;
  }

  param_00 setscriptablepartstate("fx", param_01);
  if(isDefined(param_00.current_state_vfx)) {
    param_00.current_state_vfx delete();
  }

  param_00.current_collection_state = param_01;
  if(param_01 != "none") {
    param_00.current_state_vfx = spawnfx(level._effect["soul_charm_beam_" + param_01], param_00.original_pos, (1, 0, 0), (0, 0, 1));
    triggerfx(param_00.current_state_vfx);
  }
}

zom_die_soul_mon() {
  level endon("charm_sequence_complete");
  level.soul_charm_queue = [];
  level.cp_rave_zombie_death_pos_record_func = ::add_to_zombie_death_pos_record;
  for(;;) {
    if(level.soul_charm_queue.size > 0) {
      var_00 = level.soul_charm_queue[0];
      level.soul_charm_queue = scripts\engine\utility::array_remove(level.soul_charm_queue, var_00);
      var_01 = var_00.pos;
      var_02 = scripts\engine\utility::getclosest(var_01, level.soul_collection_models);
      if(distance2dsquared(var_01, var_02.origin) <= 250000) {
        level thread soul_fly_charm(var_01, var_02);
      }

      scripts\engine\utility::waitframe();
      continue;
    }

    level waittill("zombie_killed");
  }
}

add_to_zombie_death_pos_record(param_00) {
  var_01 = spawnStruct();
  var_01.pos = param_00;
  level.soul_charm_queue[level.soul_charm_queue.size] = var_01;
}

soul_fly_charm(param_00, param_01) {
  var_02 = spawn("script_model", param_00);
  var_02 setModel("tag_origin_soultrail");
  for(;;) {
    var_03 = param_01.origin;
    var_04 = var_02.origin;
    var_05 = distance(var_04, var_03);
    var_06 = var_05 / 600;
    if(var_06 < 0.05) {
      var_06 = 0.05;
    }

    var_02 moveto(var_03, var_06);
    wait(0.05);
    if(isDefined(param_01) && distancesquared(var_02.origin, param_01.origin) > 256) {
      continue;
    } else {
      break;
    }
  }

  param_01 notify("soul_collected");
  var_02 delete();
}

slasher_abilities_trap(param_00) {
  self.bmayshockwave = 0;
  self.bmayfrisbee = 0;
}

summon_a_zombie_at(param_00, param_01) {
  param_00 = scripts\engine\utility::drop_to_ground(param_00, 30, -100);
  var_02 = spawnStruct();
  var_02.origin = param_00;
  var_02.script_parameters = "ground_spawn_no_boards";
  var_02.script_animation = "spawn_ground";
  var_03 = var_02 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy(get_spawn_type(), 1);
  if(isDefined(var_03)) {
    var_03.dont_cleanup = 1;
    var_03 thread play_intro(var_03, param_00, param_01);
    return var_03;
  }
}

play_intro(param_00, param_01, param_02) {
  var_03 = (0, 0, -11);
  if(scripts\engine\utility::istrue(param_02)) {
    param_00 scragentsetanimscale(0, 1);
  }

  var_04 = spawnfx(level._effect["superslasher_summon_zombie_portal"], param_01 + var_03, (0, 0, 1), (1, 0, 0));
  triggerfx(var_04);
  playsoundatpos(param_01 + var_03, "zmb_superslasher_summon_activate");
  var_05 = thread scripts\engine\utility::play_loopsound_in_space("zmb_superslasher_summon_activate_lp", param_01 + var_03);
  param_00 scripts\engine\utility::waittill_any_3("death", "intro_vignette_done");
  if(scripts\engine\utility::istrue(param_02) && isDefined(param_00)) {
    param_00 scragentsetanimscale(1, 1);
  }

  playsoundatpos(param_01 + var_03, "zmb_superslasher_summon_deactivate");
  var_05 stoploopsound();
  var_04 delete();
  param_00.synctransients = "sprint";
  wait(0.05);
  var_05 delete();
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
  foreach(var_01 in level.spawned_enemies) {
    var_01.died_poorly = 1;
    var_01.nocorpse = 1;
    var_01 suicide();
  }

  scripts\engine\utility::waitframe();
}

spawn_up_to_goal() {
  var_00 = get_num_of_zombies_to_spawn();
  var_01 = 0;
  while(var_01 < var_00) {
    var_02 = level thread summon_a_zombie_at(get_zombie_spawn_spot(), 1);
    wait(get_wait_between_spawn());
    if(isDefined(var_02)) {
      var_01++;
      var_02.dont_cleanup = 1;
      continue;
    }

    wait(get_wait_between_spawn());
    var_00 = get_num_of_zombies_to_spawn();
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
  level.super_slasher_zombie_spawn_loc = scripts\engine\utility::getstructarray("super_slasher_zombie_spawn_loc", "script_noteworthy");
  var_00 = gettime();
  foreach(var_02 in level.super_slasher_zombie_spawn_loc) {
    var_02.previous_used_time_stamp = var_00;
  }
}

get_close_zom_spawn(param_00) {
  var_01 = 4000;
  var_02 = 360000;
  var_03 = sortbydistance(level.super_slasher_zombie_spawn_loc, param_00);
  var_04 = var_03[0];
  var_05 = gettime();
  foreach(var_07 in var_03) {
    if(distance2dsquared(param_00, var_07.origin) < var_02) {
      continue;
    }

    if(var_07.previous_used_time_stamp + var_01 < var_05) {
      var_07.previous_used_time_stamp = var_05;
      var_04 = var_07;
      break;
    }
  }

  return var_04.origin;
}

get_zombie_spawn_spot() {
  switch (get_zombie_spawn_location()) {
    case "near_player":
      var_00 = get_random_available_player();
      if(isDefined(var_00)) {
        return get_close_zom_spawn(var_00.origin);
      } else {
        var_01 = scripts\engine\utility::random(level.super_slasher_zombie_spawn_loc);
        return var_01.origin;
      }

      break;

    case "shockwave":
      var_02 = get_least_targeted_player();
      if(isDefined(var_02)) {
        return get_spawn_shockwave(var_02);
      } else {
        var_01 = scripts\engine\utility::random(level.super_slasher_zombie_spawn_loc);
        return var_01.origin;
      }

      break;

    default:
      var_01 = scripts\engine\utility::random(level.super_slasher_zombie_spawn_loc);
      return var_01.origin;
  }
}

get_least_targeted_player() {
  var_00 = gettime();
  foreach(var_02 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_02)) {
      continue;
    }

    if(!isDefined(var_02.last_shockwave_spawn_target_time)) {
      var_02.last_shockwave_spawn_target_time = var_00;
      return var_02;
    }
  }

  var_04 = 999999999;
  var_05 = undefined;
  foreach(var_02 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_02)) {
      continue;
    }

    if(var_02.last_shockwave_spawn_target_time < var_04) {
      var_04 = var_02.last_shockwave_spawn_target_time;
      var_05 = var_02;
    }
  }

  if(isDefined(var_05)) {
    var_05.last_shockwave_spawn_target_time = var_00;
    return var_05;
  }

  return undefined;
}

get_spawn_shockwave(param_00) {
  if(isDefined(param_00.super_slasher_shockwave_safe_area) && ispointinvolume(param_00.origin, param_00.super_slasher_shockwave_safe_area)) {
    var_01 = scripts\engine\utility::getstructarray(param_00.super_slasher_shockwave_safe_area.target, "targetname");
    var_02 = scripts\engine\utility::random(var_01);
    return var_02.origin;
  }

  return get_close_zom_spawn(var_02.origin);
}

get_random_available_player() {
  var_00 = [];
  foreach(var_02 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_02)) {
      continue;
    }

    var_00[var_00.size] = var_02;
  }

  return scripts\engine\utility::random(var_00);
}

activate_super_slasher_barrier(param_00) {
  level endon("game_ended");
  if(!isDefined(level.active_super_slasher_barrierfunc_list)) {
    level.active_super_slasher_barrierfunc_list = [];
  }

  var_01 = getent("super_slasher_barrier_" + param_00, "targetname");
  if(isDefined(var_01)) {
    var_02 = var_01.origin;
    var_03 = (var_02[0], var_02[1], var_02[2] - 1024);
    var_01 moveto(var_03, 0.05);
    var_01 waittill("movedone");
    var_01 disconnectpaths();
  }

  var_01.barrier_models = [];
  play_barrier_sfx(param_00);
  var_04 = scripts\engine\utility::getstructarray(var_01.target, "targetname");
  foreach(var_06 in var_04) {
    var_01 thread barrier_deploy_sequence(var_01, var_06);
    scripts\engine\utility::waitframe();
  }

  level.active_super_slasher_barrierfunc_list[level.active_super_slasher_barrierfunc_list.size] = param_00;
}

play_barrier_sfx(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case 1:
      var_01 = (-4265, 4876, -89);
      break;

    case 2:
      var_01 = (-4449, 4402, -95);
      break;

    case 3:
      var_01 = (-4637, 5528, -91);
      break;

    case 4:
      var_01 = (-4730, 4012, -103);
      break;
  }

  playsoundatpos(var_01, "superslasher_barrier_spawn_lr");
}

barrier_deploy_sequence(param_00, param_01) {
  playFX(level._effect["punji_tell"], param_01.origin, anglesToForward(param_01.angles), anglestoup(param_01.angles));
  wait(2);
  var_02 = spawn("script_model", param_01.origin + (0, 0, -60));
  var_02 setModel("cp_rave_door_sized_collision");
  var_02 setscriptablepartstate("door_effect", "active");
  var_02.angles = param_01.angles + (0, 90, 0);
  param_00.barrier_models[param_00.barrier_models.size] = var_02;
}

deactivate_super_slasher_barrier(param_00) {
  if(!scripts\engine\utility::array_contains(level.active_super_slasher_barrierfunc_list, param_00)) {
    return;
  }

  var_01 = getent("super_slasher_barrier_" + param_00, "targetname");
  if(isDefined(var_01)) {
    var_02 = var_01.origin;
    var_03 = (var_02[0], var_02[1], var_02[2] + 1024);
    var_01 moveto(var_03, 0.05);
    var_01 waittill("movedone");
    var_01 connectpaths();
  }

  foreach(var_05 in var_01.barrier_models) {
    var_05 thread barrier_destroy_sequence(var_05);
    scripts\engine\utility::waitframe();
  }

  var_01.barrier_models = [];
  level.active_super_slasher_barrierfunc_list = scripts\engine\utility::array_remove(level.active_super_slasher_barrierfunc_list, param_00);
}

barrier_destroy_sequence(param_00) {
  playFX(level._effect["punji_subside"], param_00.origin);
  wait(2);
  param_00 delete();
}

deactivate_all_super_slasher_barriers() {
  if(!isDefined(level.active_super_slasher_barrierfunc_list)) {
    return;
  }

  foreach(var_01 in level.active_super_slasher_barrierfunc_list) {
    deactivate_super_slasher_barrier(var_01);
  }
}

set_zombie_spawning_parameters(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = spawnStruct();
  var_06.spawn_mode = param_00;
  var_06.num_of_zombies_to_spawn = param_01;
  var_06.wait_between_spawn = param_02;
  var_06.wait_between_wave = param_03;
  var_06.spawn_location = param_04;
  var_06.spawn_type = param_05;
  level.slasher_spawning = var_06;
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
  var_00 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_02 in var_00) {
    var_02.precacheleaderboards = 1;
    var_02.is_burning = 1;
    var_02.nocorpse = undefined;
    var_02 thread scripts\cp\loot::kill_selected_enemy(1);
    scripts\engine\utility::waitframe();
  }
}

try_drop_max_ammo() {
  var_00 = (-5181, 4623, -103);
  if(!scripts\engine\utility::flag("max_ammo_active")) {
    scripts\engine\utility::flag_set("max_ammo_active");
    level thread[[level.drop_max_ammo_func]](var_00, undefined, "ammo_max");
  }
}

max_ammo_manager() {
  level thread unlimited_max_ammo();
  level thread max_ammo_pick_up_listener();
}

unlimited_max_ammo() {
  level endon("game_ended");
  level endon("super_slasher_fight_complete");
  var_00 = 360;
  for(;;) {
    wait(var_00);
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

put_on_happy_face(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  wait(0.1);
  playFXOnTag(level._effect["happy_face"], param_00, "j_head");
}

switch_to_sad_face(param_00) {
  stopFXOnTag(level._effect["happy_face"], param_00, "j_head");
  playFXOnTag(level._effect["sad_face"], param_00, "j_head");
}

drop_soul_key() {
  var_00 = (-4880, 4710, -87);
  if(isDefined(level.soul_key_drop_pos)) {
    var_00 = level.soul_key_drop_pos;
  }

  var_01 = spawn("script_model", var_00);
  var_01 setModel("zmb_soul_key_single");
  var_02 = spawnfx(level._effect["soul_key_glow"], var_01.origin);
  triggerfx(var_02);
  var_01 thread item_keep_rotating(var_01);
  var_01 thread soul_key_pick_up_monitor(var_01, var_02);
}

soul_key_pick_up_monitor(param_00, param_01) {
  param_00 endon("death");
  param_00 makeusable();
  param_00 sethintstring( & "CP_RAVE_PICK_UP_SOUL_KEY");
  for(;;) {
    param_00 waittill("trigger", var_02);
    if(isplayer(var_02)) {
      stop_spawn_wave();
      var_02 playlocalsound("part_pickup");
      scripts\cp\zombies\directors_cut::give_dc_player_extra_xp_for_carrying_newb();
      foreach(var_02 in level.players) {
        var_02 setplayerdata("cp", "haveSoulKeys", "any_soul_key", 1);
        var_02 setplayerdata("cp", "haveSoulKeys", "soul_key_2", 1);
        var_02 scripts\cp\zombies\achievement::update_achievement("LOCKSMITH", 1);
      }

      break;
    }
  }

  clear_existing_enemies();
  scripts\cp\utility::play_bink_video("zombies_cp_rave_outro", 32, 1);
  level thread delay_resume_wave_progression();
  level thread delay_try_drop_talisman(param_00.origin);
  param_01 delete();
  param_00 delete();
}

delay_try_drop_talisman(param_00) {
  level endon("game_ended");
  wait(32);
  level thread scripts\cp\zombies\directors_cut::try_drop_talisman(param_00, vectortoangles((0, 1, 0)));
}

delay_resume_wave_progression() {
  level endon("game_ended");
  wait(37);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_easteregg_complete", "rave_announcer_vo", "highest", 5, 0, 0, 1);
  level.pause_nag_vo = 0;
  resume_spawn_wave();
}

deploy_stair_barrier() {
  var_00 = getent("super_slasher_stair_clip", "targetname");
  var_01 = scripts\engine\utility::getstruct(var_00.target, "targetname");
  playFX(level._effect["super_slasher_saw_shark_hit"], scripts\engine\utility::drop_to_ground(var_01.origin, 50, -500));
  var_02 = var_00.origin;
  var_03 = (var_02[0], var_02[1], var_02[2] - 1024);
  var_00 moveto(var_03, 0.05);
  var_00 waittill("movedone");
  var_00 disconnectpaths();
  var_04 = spawn("script_model", var_01.origin);
  var_04 setModel("cp_rave_punji_stream");
  var_04.angles = var_01.angles;
  var_00.stair_barrier_model = var_04;
}

destroy_stair_barrier() {
  var_00 = getent("super_slasher_stair_clip", "targetname");
  playFX(level._effect["super_slasher_saw_shark_hit"], scripts\engine\utility::drop_to_ground(var_00.stair_barrier_model.origin, 50, -500));
  var_00 connectpaths();
  var_01 = var_00.origin;
  var_02 = (var_01[0], var_01[1], var_01[2] + 1024);
  var_00 moveto(var_02, 0.05);
  var_00 waittill("movedone");
  var_00.stair_barrier_model delete();
}

activate_fight_stage_vfx() {
  level.super_slasher_fight_stage_vfx = [];
  spawn_fight_stage_vfx(1, (-6170, 5352, 553), anglesToForward((0, -55, 0)));
  spawn_fight_stage_vfx(2, (-6035, 4322, 553), anglesToForward((0, 55, 0)));
  spawn_fight_stage_vfx(3, (-6345, 4784, 553), anglesToForward((0, 7, 0)));
}

spawn_fight_stage_vfx(param_00, param_01, param_02) {
  var_03 = spawnfx(level._effect["fight_stage"], param_01, param_02);
  triggerfx(var_03);
  level.super_slasher_fight_stage_vfx[param_00] = var_03;
}

delete_fight_stage_vfx(param_00) {
  var_01 = level.super_slasher_fight_stage_vfx[param_00];
  var_01 delete();
}

watch_for_player_deaths() {
  level endon("super_slasher_fight_complete");
  while(!scripts\engine\utility::flag("super_slasher_fight_complete")) {
    level waittill("player_entered_ala", var_00);
    var_00 thread scripts\cp\maps\cp_rave\cp_rave::exit_rave_mode(var_00);
    var_00 thread watch_for_revive(var_00);
  }
}

watch_for_revive(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 waittill("spawned_player");
  if(scripts\engine\utility::istrue(param_00.unlimited_rave)) {
    param_00 thread scripts\cp\maps\cp_rave\cp_rave::enter_rave_mode(param_00);
  }
}