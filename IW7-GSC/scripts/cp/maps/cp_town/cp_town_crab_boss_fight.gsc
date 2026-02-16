/***************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_crab_boss_fight.gsc
***************************************************************/

init_crab_boss_stage() {
  scripts\cp\zombies\zombie_quest::register_quest_step("crabBoss", 0, ::init_crab_boss_quest, ::crab_boss_quest, ::end_crab_boss_quest, ::debug_beat_crab_boss_quest, 4, "Quest Step");
  scripts\cp\zombies\zombie_quest::register_quest_step("crabBoss", 1, ::init_escort_bomb, ::escort_bomb, ::end_escort_bomb, ::debug_beat_escort_bomb, 4, "Escort the Bomb");
  scripts\cp\zombies\zombie_quest::register_quest_step("crabBoss", 2, ::blank, ::death_ray_cannon, ::end_death_ray_cannon, ::debug_beat_death_ray_cannon, 4, "Death Ray Cannon");
  scripts\cp\zombies\zombie_quest::register_quest_step("crabBoss", 3, ::blank, ::death_wall, ::end_death_wall, ::debug_beat_death_wall, 4, "Wall of Death");
  scripts\cp\zombies\zombie_quest::register_quest_step("crabBoss", 4, ::blank, ::sonic_ring, ::end_sonic_ring, ::debug_sonic_ring, 4, "Sonic Beam");
}

blank() {}

init_crab_boss_quest() {
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::load_escort_vfx();
  scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::load_death_ray_cannon_vfx();
  scripts\cp\maps\cp_town\cp_town_crab_boss_sonic_ring::load_sonic_ring_vfx();
  scripts\cp\maps\cp_town\cp_town_crab_boss_death_wall::load_death_wall_vfx();
  scripts\engine\utility::flag_init("crab_boss_zombie_spawn");
  wait(5);
  scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::set_up_death_ray_cannons();
  hide_lost_n_found_sign();
  var_0 = scripts\engine\utility::drop_to_ground((6491, 11387, -439), 100, -2000);
  level.crab_boss = scripts\mp\mp_agent::spawnnewagent("crab_boss", "axis", var_0, (0, 40, 0), "iw7_zombie_laser_mp");
  level.crab_boss thread crab_boss_pre_combat_sequence(level.crab_boss);
  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(1);
  scripts\engine\utility::flag_init("boss_fight_active");
  scripts\engine\utility::flag_init("boss_fight_finished");
}

hide_lost_n_found_sign() {
  var_0 = getent("crab_boss_lnf_sign", "targetname");
  if(isDefined(var_0)) {
    var_0 hide();
  }
}

crab_boss_pre_combat_sequence(var_0) {
  var_0 endon("death");
  scripts\engine\utility::flag_init("crab_boss_pre_combat_stage_1");
  scripts\engine\utility::flag_init("crab_boss_pre_combat_stage_2");
  scripts\engine\utility::flag_init("crab_boss_combat_ready");
  level thread wait_door_open_to_beach();
  set_tanker_anim("search");
  scripts\engine\utility::flag_wait("crab_boss_pre_combat_stage_1");
  move_to_taunt_loc(var_0);
  gets_to_combat_pos();
}

advance_pre_combat_stage() {
  if(!scripts\engine\utility::flag("crab_boss_pre_combat_stage_1")) {
    scripts\engine\utility::flag_set("crab_boss_pre_combat_stage_1");
    return;
  }

  if(!scripts\engine\utility::flag("crab_boss_pre_combat_stage_2")) {
    scripts\engine\utility::flag_set("crab_boss_pre_combat_stage_2");
  }
}

set_tanker_anim(var_0) {
  var_1 = getent("town_tanker", "targetname");
  var_1 setscriptablepartstate("boat", var_0);
}

wait_door_open_to_beach() {
  for(;;) {
    level waittill("volume_activated", var_0);
    if(var_0 == "bridge_beach") {
      advance_pre_combat_stage();
      break;
    }
  }
}

move_to_taunt_loc(var_0) {
  var_0.shouldabortentranceanim = 1;
  for(;;) {
    var_1 = var_0 scripts\asm\asm::asm_getcurrentstate("crab_boss");
    if(var_1 == "idle") {
      break;
    }

    wait(0.1);
  }

  set_tanker_anim("idle");
  level.crab_boss thread crab_boss_sfx_water_slosh_loop_start();
  var_2 = scripts\engine\utility::drop_to_ground((4095, 6788, -200), 50, -1000);
  var_0 scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::crab_boss_move_to(var_2);
  var_0 scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::crab_boss_face_point((3018, 2278, -42));
  for(;;) {
    var_0 scripts\cp\maps\cp_town\cp_town_crab_boss_death_wall::do_taunt();
    if(scripts\engine\utility::flag("crab_boss_pre_combat_stage_2")) {
      return;
    }
  }
}

play_vo_at_start_of_boss_fight() {
  var_0 = scripts\engine\utility::random(level.players);
  if(isDefined(var_0.vo_prefix)) {
    switch (var_0.vo_prefix) {
      case "p1_":
        level thread scripts\cp\cp_vo::try_to_play_vo("sally_boss_final_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p2_":
        level thread scripts\cp\cp_vo::try_to_play_vo("pdex_boss_final_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p3_":
        level thread scripts\cp\cp_vo::try_to_play_vo("andre_boss_final_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      case "p4_":
        level thread scripts\cp\cp_vo::try_to_play_vo("aj_boss_final_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        break;

      default:
        break;
    }
  }

  foreach(var_2 in level.players) {
    if(var_2.vo_prefix == "p5_") {
      var_2 thread scripts\cp\cp_vo::try_to_play_vo("encounter_radthing", "town_comment_vo", "low", 10, 0, 0, 0, 10);
    }
  }
}

crab_boss_sfx_water_slosh_loop_start() {
  self playLoopSound("boss_crog_water_slosh_lp");
}

crab_boss_quest() {
  level waittill("crab_boss_quest_completed");
}

end_crab_boss_quest() {}

debug_beat_crab_boss_quest() {}

gets_to_combat_pos() {
  var_0 = 10;
  for(;;) {
    var_1 = level.crab_boss scripts\asm\asm::asm_getcurrentstate("crab_boss");
    if(var_1 == "idle") {
      break;
    }

    wait(0.1);
  }

  level.crab_boss scripts\aitypes\crab_boss\behaviors::dosubmerge();
  level.crab_boss waittill("submerge_done");
  var_2 = spawn("script_model", level.crab_boss.origin);
  var_2.angles = level.crab_boss.angles;
  var_2 setModel("tag_origin");
  level.crab_boss linkto(var_2, "tag_origin");
  var_3 = scripts\engine\utility::drop_to_ground((3621, 4536, -231), 200, -1000);
  var_2 moveto(var_3, var_0, 2, 5);
  level.crab_boss thread do_water_vfx(level.crab_boss, var_0, var_3);
  var_2 waittill("movedone");
  level.crab_boss unlink();
  var_2 delete();
  level.crab_boss_random_taunt_anim = 1;
  scripts\engine\utility::flag_set("crab_boss_combat_ready");
}

do_water_vfx(var_0, var_1, var_2) {
  var_3 = 0.5;
  var_4 = 600;
  var_5 = (var_2[0] - 300, var_2[1], var_0.origin[2]);
  var_6 = vectornormalize(var_5 - var_0.origin);
  var_7 = var_0.origin + var_6 * var_4;
  var_8 = spawn("script_model", var_7);
  var_8 setModel("tag_origin");
  var_8 linkto(var_0);
  for(var_9 = 0; var_9 < var_1 / var_3 - 2; var_9++) {
    playFXOnTag(level._effect["crog_submerge_idle"], var_8, "tag_origin");
    playFXOnTag(level._effect["crog_submerge_idle"], var_0, "tag_origin");
    wait(var_3);
  }

  var_8 delete();
}

init_escort_bomb() {
  level thread crab_boss_disable_teleport_monitor();
  level thread crab_boss_zombie_spawn_manager();
  level thread max_ammo_manager();
  move_lost_and_found("beach");
  level.force_respawn_location = ::respawn_on_beach;
  var_0 = scripts\engine\utility::drop_to_ground((3621, 4536, -231), 0, -1000);
  activate_crab_boss_fight_blocker();
  scripts\cp\maps\cp_town\cp_town_interactions::applyvisionsettoallplayers("cp_town_color");
  scripts\engine\utility::flag_set("boss_fight_active");
}

crab_boss_disable_teleport_monitor() {
  level endon("crab_boss_fight_complete");
  level endon("game_ended");
  foreach(var_1 in level.players) {
    if(var_1 scripts\cp\utility::isteleportenabled()) {
      var_1 scripts\cp\utility::allow_player_teleport(0);
    }
  }

  for(;;) {
    level waittill("connected", var_1);
    if(var_1 scripts\cp\utility::isteleportenabled()) {
      var_1 scripts\cp\utility::allow_player_teleport(0);
    }
  }
}

escort_bomb() {
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::start_escort_sequence();
  level waittill("escort_sequence_ended");
}

end_escort_bomb() {
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::disable_bomb_push_interactions();
  scripts\cp\maps\cp_town\cp_town_crab_boss_escort::delete_push_origins();
}

debug_beat_escort_bomb() {}

max_ammo_manager() {
  level thread unlimited_max_ammo();
  level thread max_ammo_pick_up_listener();
}

unlimited_max_ammo() {
  level endon("game_ended");
  level endon("crab_boss_fight_complete");
  scripts\engine\utility::flag_init("max_ammo_active");
  var_0 = 180;
  for(;;) {
    wait(var_0);
    try_drop_max_ammo();
  }
}

try_drop_max_ammo() {
  var_0 = (2933, 1994, -31);
  if(!scripts\engine\utility::flag("max_ammo_active")) {
    scripts\engine\utility::flag_set("max_ammo_active");
    level thread[[level.drop_max_ammo_func]](var_0, undefined, "ammo_max");
  }
}

max_ammo_pick_up_listener() {
  level endon("game_ended");
  level endon("crab_boss_fight_complete");
  for(;;) {
    level waittill("pick_up_max_ammo");
    scripts\engine\utility::flag_clear("max_ammo_active");
  }
}

move_lost_and_found(var_0) {
  var_1 = (2956, 772, 11.8);
  var_2 = "com_cardboardbox02";
  if(!isDefined(level.lnf_struct)) {
    level.lnf_struct = scripts\engine\utility::getstruct("lost_and_found", "script_noteworthy");
    level.lnf_struct.og_origin = level.lnf_struct.origin;
  }

  if(var_0 == "beach") {
    level.lnf_struct.origin = var_1;
    var_3 = getent("crab_boss_lnf_sign", "targetname");
    if(isDefined(var_3)) {
      var_3 show();
    }
  } else {
    level.lnf_struct.origin = level.lnf_struct.og_origin;
    var_3 = getent("crab_boss_lnf_sign", "targetname");
    if(isDefined(var_3)) {
      var_3 hide();
    }
  }

  foreach(var_5 in level.players) {
    if(!isDefined(var_5.lost_and_found_ent)) {
      continue;
    }

    var_5.lost_and_found_ent.origin = level.lnf_struct.origin + (0, 0, 45);
  }
}

respawn_on_beach(var_0) {
  var_1 = [(2887, 753, 54), (2771, 769, 27), (2710, 723, 33), (2617, 770, 44)];
  var_2 = spawnStruct();
  foreach(var_4 in var_1) {
    if(canspawn(var_4) && !positionwouldtelefrag(var_4)) {
      var_2.origin = var_4;
      var_2.angles = (0, 90, 0);
      return var_2;
    }
  }

  var_2.origin = var_1[0];
  var_2.angles = (0, 90, 0);
  return var_2;
}

crab_boss_zombie_spawn_manager() {
  level endon("crab_boss_fight_complete");
  level.wave_num_override = int(max(33, level.wave_num));
  level.allow_wave_spawn = 0;
  level.max_wave_spawn_num = 9999999;
  stop_spawn_wave();
  clear_remaining_enemies();
  scripts\engine\utility::flag_wait("crab_boss_zombie_spawn");
  var_0 = 0;
  for(;;) {
    if(can_spawn_zombie()) {
      var_1 = get_zombie_spawner();
      var_2 = var_1 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("generic_zombie", 1, var_1);
      if(isDefined(var_2)) {
        var_0++;
        var_2.dont_cleanup = 1;
        var_2.synctransients = "sprint";
        if(isDefined(level.cb_zmb_spawn_func)) {
          [[level.cb_zmb_spawn_func]](var_2);
        }

        var_2 thread play_intro(var_2);
      }
    }

    wait(get_zombie_spawn_delay());
    if(!scripts\engine\utility::flag("crab_boss_zombie_spawn")) {
      scripts\engine\utility::flag_wait("crab_boss_zombie_spawn");
      continue;
    }

    if(should_do_wave_spawn()) {
      if(should_do_wait_between_wave(var_0)) {
        var_0 = 0;
        wait_between_wave();
      }
    }
  }
}

wait_between_wave() {
  var_0 = 10;
  if(isDefined(level.wait_time_between_wave)) {
    wait(level.wait_time_between_wave);
    return;
  }

  wait(var_0);
}

should_do_wait_between_wave(var_0) {
  return var_0 >= level.max_wave_spawn_num;
}

should_do_wave_spawn() {
  if(scripts\engine\utility::istrue(level.allow_wave_spawn)) {
    if(level.players.size == 1) {
      return 1;
    }

    return 0;
  }

  return 0;
}

stop_spawn_wave() {
  scripts\engine\utility::flag_set("pause_wave_progression");
  level.zombies_paused = 1;
  level.dont_resume_wave_after_solo_afterlife = 1;
}

clear_remaining_enemies() {
  foreach(var_1 in level.spawned_enemies) {
    if(var_1.agent_type == "crab_boss") {
      continue;
    }

    var_1.died_poorly = 1;
    var_1.nocorpse = 1;
    var_1 suicide();
  }

  scripts\engine\utility::waitframe();
}

play_intro(var_0) {
  var_0 endon("death");
  var_0 waittill("intro_vignette_done");
  var_0.synctransients = "sprint";
}

assign_enemy(var_0) {
  var_1 = get_zmb_target_player();
  var_0.enemyoverride = var_1;
}

get_zmb_target_player() {
  var_0 = undefined;
  var_1 = [];
  foreach(var_3 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  var_5 = gettime();
  foreach(var_3 in var_1) {
    if(!isDefined(var_3.last_attacked_by_crab_boss_zombie_time)) {
      var_3.last_attacked_by_crab_boss_zombie_time = var_5;
    }
  }

  var_8 = undefined;
  foreach(var_3 in var_1) {
    if(!isDefined(var_8)) {
      var_8 = var_3.last_attacked_by_crab_boss_zombie_time;
      var_0 = var_3;
      continue;
    }

    if(var_3.last_attacked_by_crab_boss_zombie_time < var_8) {
      var_8 = var_3.last_attacked_by_crab_boss_zombie_time;
      var_0 = var_3;
    }
  }

  if(isDefined(var_0)) {
    var_0.last_attacked_by_crab_boss_zombie_time = var_5;
  }

  return var_0;
}

get_zombie_spawner() {
  var_0 = 20;
  var_1 = undefined;
  var_2 = [(2736, 3630, -179), (2781, 3459, -179), (2867, 3334, -182), (2987, 3214, -181), (3196, 3094, -179), (3376, 3070, -179), (3518, 3093, -180), (3669, 3162, -183)];
  if(isDefined(level.crab_boss_zombie_spawn_pos_list)) {
    var_1 = scripts\engine\utility::random(level.crab_boss_zombie_spawn_pos_list);
  } else {
    var_1 = scripts\engine\utility::random(var_2);
  }

  var_3 = randomfloatrange(var_0 * -1, var_0);
  var_4 = randomfloatrange(var_0 * -1, var_0);
  var_1 = (var_1[0] + var_3, var_1[1] + var_4, var_1[2]);
  var_1 = getclosestpointonnavmesh(var_1);
  var_5 = spawnStruct();
  var_5.origin = var_1;
  var_5.angles = vectortoangles((-26, -110, 18));
  var_5.script_parameters = "ground_spawn_no_boards";
  var_5.script_animation = "spawn_ground";
  return var_5;
}

can_spawn_zombie() {
  var_0 = 15;
  if(isDefined(level.crab_boss_max_zombie_spawn)) {
    var_1 = level.crab_boss_max_zombie_spawn;
  } else {
    var_1 = var_1;
  }

  return get_num_alive_agent_of_type("generic_zombie") < var_1;
}

get_num_alive_agent_of_type(var_0) {
  var_1 = 0;
  foreach(var_3 in level.spawned_enemies) {
    if(isDefined(var_3.agent_type) && var_3.agent_type == var_0) {
      var_1++;
    }
  }

  return var_1;
}

get_zombie_spawn_delay() {
  if(isDefined(level.crab_boss_zombie_spawn_delay)) {
    return level.crab_boss_zombie_spawn_delay;
  }

  return 2;
}

death_ray_cannon() {
  level.cb_zmb_spawn_func = ::assign_enemy;
  var_0 = getDvar("scrAgent_ragdollImpulseZ");
  setDvar("scrAgent_ragdollImpulseZ", 10000);
  scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::set_up_weak_spot();
  scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::hit_weak_spot_with_death_ray_cannon();
  for(var_1 = 0; var_1 < 1; var_1++) {
    level waittill("crab_boss_weak_spot_initial_hit");
    scripts\cp\cp_vo::try_to_play_vo_on_all_players("boss_phase_2_success_cannon");
  }

  scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::activate_weak_spot();
  var_2 = level.players.size * 30000;
  var_3 = 0;
  for(;;) {
    level waittill("crab_boss_weak_spot_hit", var_4);
    var_3 = var_3 + var_4;
    adjust_zombie_spawning(var_3, var_2);
    if(var_3 >= var_2) {
      break;
    }
  }

  delete_weak_spot();
  level.crab_boss notify("stop_death_ray_attack_logic");
  setDvar("scrAgent_ragdollImpulseZ", var_0);
  scripts\cp\cp_vo::try_to_play_vo_on_all_players("boss_phase_2_success_cannon_final");
  scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::crab_boss_pain_and_heal();
}

delete_weak_spot() {
  if(isDefined(level.crab_boss.crab_boss_weak_spot)) {
    level.crab_boss.crab_boss_weak_spot delete();
  }

  if(isDefined(level.crab_boss.crab_boss_weak_vfx)) {
    level.crab_boss.crab_boss_weak_vfx delete();
  }
}

adjust_zombie_spawning(var_0, var_1) {
  var_2 = var_0 / var_1;
  if(var_2 >= 1) {
    set_crab_boss_max_zombie_spawn(4, 4, 4, 4);
    set_crab_boss_zombie_spawn_delay(3, 3, 3, 3);
    level.max_wave_spawn_num = 4;
    level.wait_time_between_wave = 25;
    return;
  }

  if(var_2 >= 0.8) {
    set_crab_boss_max_zombie_spawn(15, 15, 15, 15);
    set_crab_boss_zombie_spawn_delay(0.3, 0.3, 0.4, 0.5);
    level.max_wave_spawn_num = 20;
    level.wait_time_between_wave = 15;
    return;
  }

  if(var_2 >= 0.6) {
    set_crab_boss_max_zombie_spawn(15, 15, 14, 14);
    set_crab_boss_zombie_spawn_delay(0.5, 0.5, 0.6, 0.7);
    level.max_wave_spawn_num = 18;
    level.wait_time_between_wave = 18;
    return;
  }

  if(var_2 >= 0.4) {
    set_crab_boss_max_zombie_spawn(14, 14, 13, 13);
    set_crab_boss_zombie_spawn_delay(0.7, 0.7, 0.8, 0.9);
    level.max_wave_spawn_num = 16;
    level.wait_time_between_wave = 21;
    return;
  }

  if(var_2 >= 0.2) {
    set_crab_boss_max_zombie_spawn(14, 14, 13, 12);
    set_crab_boss_zombie_spawn_delay(0.9, 0.9, 1, 1.1);
    level.max_wave_spawn_num = 14;
    level.wait_time_between_wave = 24;
    return;
  }
}

set_crab_boss_max_zombie_spawn(var_0, var_1, var_2, var_3) {
  switch (level.players.size) {
    case 4:
      level.crab_boss_max_zombie_spawn = var_0;
      break;

    case 3:
      level.crab_boss_max_zombie_spawn = var_1;
      break;

    case 2:
      level.crab_boss_max_zombie_spawn = var_2;
      break;

    case 1:
      level.crab_boss_max_zombie_spawn = var_3;
      break;

    default:
      break;
  }
}

set_crab_boss_zombie_spawn_delay(var_0, var_1, var_2, var_3) {
  switch (level.players.size) {
    case 4:
      level.crab_boss_zombie_spawn_delay = var_0;
      break;

    case 3:
      level.crab_boss_zombie_spawn_delay = var_1;
      break;

    case 2:
      level.crab_boss_zombie_spawn_delay = var_2;
      break;

    case 1:
      level.crab_boss_zombie_spawn_delay = var_3;
      break;

    default:
      break;
  }
}

end_death_ray_cannon() {
  level.cb_zmb_spawn_func = undefined;
}

debug_beat_death_ray_cannon() {}

death_wall() {
  scripts\cp\maps\cp_town\cp_town_crab_boss_death_wall::wall_of_death();
}

end_death_wall() {
  scripts\cp\maps\cp_town\cp_town_crab_boss_death_wall::end_wall_of_death();
}

debug_beat_death_wall() {}

sonic_ring() {
  scripts\cp\maps\cp_town\cp_town_crab_boss_sonic_ring::do_sonic_ring();
}

end_sonic_ring() {
  scripts\cp\maps\cp_town\cp_town_crab_boss_sonic_ring::sonic_ring_cleanup();
}

debug_sonic_ring() {}

replay_final_sequence() {
  if(!scripts\cp\zombies\zombie_quest::quest_line_exist("replayCrabBossFinalSequence")) {
    scripts\cp\zombies\zombie_quest::register_quest_step("replayCrabBossFinalSequence", 0, ::blank, ::death_wall, ::end_death_wall, ::debug_beat_death_wall, 5, "Wall of Death");
    scripts\cp\zombies\zombie_quest::register_quest_step("replayCrabBossFinalSequence", 1, ::blank, ::sonic_ring, ::end_sonic_ring, ::debug_sonic_ring, 5, "Sonic Beam");
  }

  level thread scripts\cp\zombies\zombie_quest::start_quest_line("replayCrabBossFinalSequence");
}

activate_crab_boss_fight_blocker() {
  level.crab_boss_fight_blocker_models = [];
  var_0 = scripts\engine\utility::getStructArray("crab_boss_fight_door_model", "targetname");
  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel("cp_disco_street_barricade");
    var_3.angles = var_2.angles;
    level.crab_boss_fight_blocker_models[level.crab_boss_fight_blocker_models.size] = var_3;
  }

  var_5 = getent("crab_boss_fight_door_clip", "targetname");
  var_5 dontinterpolate();
  var_5.origin = var_5.origin + (0, 0, 1024);
}

deactivate_crab_boss_fight_blocker() {
  if(isDefined(level.crab_boss_fight_blocker_models)) {
    foreach(var_1 in level.crab_boss_fight_blocker_models) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }
  }

  var_3 = getent("crab_boss_fight_door_clip", "targetname");
  if(isDefined(var_3)) {
    var_3 delete();
  }
}

show_icon_on_escort_vehicle() {
  foreach(var_1 in level.players) {
    var_2 = newclienthudelem(var_1);
    var_2 setshader("apache_target_lock", 36, 36);
    var_2 setwaypoint(1, 1);
    var_2 settargetent(level.escort_vehicle);
    var_2.alpha = 1;
    var_2.color = (1, 0, 0);
    var_1.escort_vehicle_icon = var_2;
  }
}

remove_icon_on_escort_vehicle() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.escort_vehicle_icon)) {
      var_1.escort_vehicle_icon destroy();
    }
  }
}

usecrabbossdebug(var_0, var_1) {}

setupplayerloadouts() {
  var_0 = ["iw7_ar57_zm", "iw7_m4_zm", "iw7_erad_zm"];
  var_1 = ["iw7_crb_zml", "iw7_lmg03_zm", "iw7_mauler_zm"];
  var_2 = ["perk_machine_revive", "perk_machine_flash", "perk_machine_tough", "perk_machine_run", "perk_machine_rat_a_tat"];
  foreach(var_4 in level.players) {
    foreach(var_6 in var_2) {
      var_4 thread scripts\cp\zombies\zombies_perk_machines::give_zombies_perk_immediate(var_6, 1);
    }

    var_8 = randomint(var_1.size);
    var_9 = randomint(var_0.size);
    var_4 takeweapon(var_4 scripts\cp\utility::getvalidtakeweapon());
    var_10 = scripts\cp\utility::getrawbaseweaponname(var_1[var_8]);
    if(isDefined(var_4.weapon_build_models[var_10])) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_4, var_4.weapon_build_models[var_10]);
    } else {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_4, var_1[var_8]);
    }

    var_11 = scripts\cp\utility::getrawbaseweaponname(var_0[var_9]);
    if(isDefined(var_4.weapon_build_models[var_11])) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_4, var_4.weapon_build_models[var_11]);
    } else {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_4, var_1[var_8]);
    }

    var_4.total_currency_earned = min(10000, var_4 scripts\cp\cp_persistence::get_player_max_currency());
    var_4 scripts\cp\cp_persistence::set_player_currency(10000);
    var_4 scripts\cp\cp_interaction::refresh_interaction();
  }

  if(isDefined(level.pap_max) && level.pap_max < 3) {
    level.pap_max++;
  }

  level[[level.upgrade_weapons_func]]();
  level thread[[level.upgrade_weapons_func]]();
}

open_sesame(var_0) {
  if(scripts\engine\utility::istrue(var_0)) {
    level.open_sesame = undefined;
  } else if(scripts\engine\utility::istrue(level.open_sesame)) {
    level.open_sesame = undefined;
    return;
  } else {
    level.open_sesame = 1;
  }

  foreach(var_2 in level.generators) {
    thread scripts\cp\zombies\zombie_power::generic_generator(var_2);
    wait(0.1);
  }

  if(isDefined(level.fast_travel_spots)) {
    foreach(var_5 in level.fast_travel_spots) {
      var_5.used_once = 1;
    }
  }

  var_7 = getEntArray("door_buy", "targetname");
  foreach(var_9 in var_7) {
    var_9 notify("trigger", "open_sesame");
    wait(0.1);
  }

  var_11 = getEntArray("chi_door", "targetname");
  foreach(var_9 in var_11) {
    var_9.physics_capsulecast notify("damage", undefined, "open_sesame");
    wait(0.1);
  }

  level.moon_donations = 3;
  level.kepler_donations = 3;
  level.triton_donations = 3;
  if(isDefined(level.team_killdoors)) {
    foreach(var_15 in level.team_killdoors) {
      var_15 scripts\cp\zombies\zombie_doors::open_team_killdoor(level.players[0]);
    }
  }

  var_11 = scripts\engine\utility::getStructArray("interaction", "targetname");
  foreach(var_13 in var_11) {
    var_14 = scripts\engine\utility::getStructArray(var_13.script_noteworthy, "script_noteworthy");
    foreach(var_16 in var_14) {
      if(isDefined(var_16.target) && isDefined(var_13.target)) {
        if(var_16.target == var_13.target && var_16 != var_13) {
          if(scripts\engine\utility::array_contains(var_11, var_16)) {
            var_11 = scripts\engine\utility::array_remove(var_11, var_16);
          }
        }
      }
    }

    if(scripts\cp\cp_interaction::interaction_is_door_buy(var_13)) {
      if(!isDefined(var_13.script_noteworthy)) {
        continue;
      }

      if(var_13.script_noteworthy == "team_door_switch") {
        scripts\cp\zombies\interaction_openareas::use_team_door_switch(var_13, level.players[0]);
      }
    }
  }
}

teleportplayertobeach() {
  var_0 = [(1654, -1472, 304), (1812, -1366, 239), (1914, -1174, 187), (2185, -1170, 185)];
  var_1 = (3426, 3850, -348);
  foreach(var_5, var_3 in level.players) {
    var_4 = scripts\engine\utility::drop_to_ground(var_0[var_5], 200, -500);
    var_3 setorigin(var_4, 1);
    var_3 setplayerangles(vectortoangles(var_1 - var_0[var_5]));
  }
}