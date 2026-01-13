/*******************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray.gsc
*******************************************************************/

hit_weak_spot_with_death_ray_cannon() {
  enable_all_death_ray_cannons();
  level thread crab_boss_attack_logic();
}

crab_boss_attack_logic() {
  level.crab_boss endon("stop_death_ray_attack_logic");
  wait(2.3);
  level thread delay_player_shellshock();
  level.crab_boss func_6115();
  level thread bomb_capture_dialogue();
  start_death_ray_zombie_spawning();
  level.crab_boss crab_boss_move_to(scripts\engine\utility::drop_to_ground((3426, 3850, -348), 100, -500));
  for(;;) {
    var_0 = get_target_player();
    if(isDefined(var_0)) {
      level.crab_boss attack_player(var_0);
      continue;
    }

    level.crab_boss scripts\cp\maps\cp_town\cp_town_crab_boss_death_wall::do_taunt();
  }
}

bomb_capture_dialogue() {
  level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("el_deathray_ready", "elvira_player_dialogue_vo", "highest", 70, 0, 0, 1);
  wait(scripts\cp\cp_vo::get_sound_length("el_deathray_ready") + 10);
}

attack_player(var_0) {
  var_1 = func_7842(var_0);
  level.crab_boss crab_boss_face_point(var_0.origin);
  switch (var_1) {
    case "beam":
      level.crab_boss crab_boss_beam(var_0);
      break;

    case "smash":
      level.crab_boss crab_boss_smash();
      break;

    case "spawn":
      level.crab_boss crab_boss_spawn(var_0);
      break;

    case "bomb":
      level.crab_boss crab_boss_bomb(var_0);
      break;

    default:
      break;
  }
}

func_7842(var_0) {
  if(player_under_overhead_bridge(var_0)) {
    return "beam";
  }

  if(player_near_left_or_right_cannon(var_0)) {
    return "beam";
  }

  if(player_near_center_cannon(var_0)) {
    return scripts\engine\utility::random(["beam", "smash"]);
  }

  if(player_on_overhead_bridge(var_0)) {
    return scripts\engine\utility::random(["spawn"]);
  }

  if(player_near_crab_boss(var_0)) {
    return scripts\engine\utility::random(["beam", "smash"]);
  }

  return scripts\engine\utility::random(["spawn", "bomb"]);
}

player_under_overhead_bridge(var_0) {
  if(var_0.origin[2] >= 161) {
    return 0;
  }

  return var_0.origin[1] >= -300 &var_0.origin[1] <= 1400;
}

player_near_left_or_right_cannon(var_0) {
  if(distancesquared(var_0.origin, (2135, 3746, 164)) <= 90000) {
    return 1;
  }

  if(distancesquared(var_0.origin, (4265, 2933, 164)) <= 90000) {
    return 1;
  }

  return 0;
}

player_on_overhead_bridge(var_0) {
  return var_0.origin[2] > 390;
}

player_near_center_cannon(var_0) {
  return distancesquared(var_0.origin, (3014, 2250, -44)) <= 90000;
}

player_near_crab_boss(var_0) {
  return distance2d(var_0.origin, level.crab_boss.origin) <= 2200;
}

func_6115() {
  level.crab_boss scripts\aitypes\crab_boss\behaviors::doemerge();
  level.crab_boss waittill("emerge_complete");
}

start_death_ray_zombie_spawning() {
  level.allow_wave_spawn = 1;
  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(14, 13, 12, 11);
  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1.1, 1.2, 1.3, 1.4);
  level.max_wave_spawn_num = 10;
  level.wait_time_between_wave = 30;
  scripts\engine\utility::flag_set("crab_boss_zombie_spawn");
}

attack_center_turret() {
  level.crab_boss crab_boss_face_point((3014, 2250, -44));
  level.crab_boss crab_boss_smash();
}

attack_left_turret() {
  var_0 = scripts\engine\utility::drop_to_ground((2054, 3742, 178), 100, -200);
  var_1 = scripts\engine\utility::drop_to_ground((2054, 3742, 178), 100, -200);
  level.crab_boss crab_boss_face_point((2135, 3746, 164));
  level.crab_boss crab_boss_beam(var_0, var_1);
}

attack_right_turret() {
  var_0 = scripts\engine\utility::drop_to_ground((4317, 2918, 172), 100, -200);
  var_1 = scripts\engine\utility::drop_to_ground((4317, 2918, 172), 100, -200);
  level.crab_boss crab_boss_face_point((4265, 2933, 164));
  level.crab_boss crab_boss_beam(var_0, var_1);
}

attack_back_turret() {
  var_0 = (2657, 750, 470);
  var_1 = 100;
  var_2 = 10;
  level.crab_boss crab_boss_face_point((2686, 807, 421));
  level.crab_boss crab_boss_bomb(var_0, var_1, var_2);
}

crab_boss_move_to(var_0) {
  level.crab_boss crab_boss_face_point(var_0);
  level.crab_boss scripts\aitypes\crab_boss\behaviors::bossmoveto(0, var_0);
  level.crab_boss waittill("move_complete");
}

crab_boss_face_point(var_0) {
  if(level.crab_boss scripts\aitypes\crab_boss\behaviors::facepoint(0, var_0)) {
    level.crab_boss waittill("turn_done");
  }
}

crab_boss_smash() {
  level.crab_boss scripts\aitypes\crab_boss\behaviors::dosmashattack(0);
  level.crab_boss waittill("smash_done");
}

crab_boss_beam(var_0) {
  level.crab_boss scripts\aitypes\crab_boss\behaviors::beamattackposition(0, var_0);
  level.crab_boss waittill("beam_done");
}

crab_boss_spawn(var_0) {
  var_1 = scripts\cp\maps\cp_town\cp_town_crab_boss_fight::get_num_alive_agent_of_type("crab_mini");
  if(var_1 >= 8) {
    level.crab_boss crab_boss_bomb(var_0);
    return;
  }

  level.crab_boss scripts\aitypes\crab_boss\behaviors::dodeathrayspawn(var_0);
  level.crab_boss waittill("toxic_spawn_done");
}

crab_boss_bomb(var_0) {
  level.crab_boss.bomb_target = var_0;
  level.crab_boss scripts\aitypes\crab_boss\behaviors::dobombattack(0);
  level.crab_boss waittill("bomb_done");
}

set_up_death_ray_cannons() {
  level.death_ray_cannons = [];
  var_0 = scripts\engine\utility::getstructarray("death_ray_cannon", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_3 = spawnturret("misc_turret", var_2.origin, "death_ray_cannon_zm");
    var_3 setModel("cp_town_laser_death_ray");
    var_3 give_player_session_tokens("manual");
    var_3 turretfiredisable();
    var_3 makeunusable();
    var_3 setdefaultdroppitch(30);
    var_3 getvalidlocation();
    var_3 sethintstring(&"CP_TOWN_USE_DEATH_RAY_CANNON");
    var_3.angles = var_2.angles;
    var_3 set_arc_value(var_3);
    var_3.not_ready_hint = set_up_not_ready_hint(var_3);
    var_3 thread death_ray_player_use_monitor(var_3);
    var_4 = get_death_ray_cannon_location(var_3);
    level.death_ray_cannons[var_4] = var_3;
  }
}

set_up_not_ready_hint(var_0) {
  var_1 = get_not_ready_hint_pos(var_0);
  var_2 = spawnStruct();
  var_2.name = "death_ray_cannon";
  var_2.script_noteworthy = "death_ray_cannon";
  var_2.origin = var_1;
  var_2.cost = 0;
  var_2.powered_on = 1;
  var_2.spend_type = undefined;
  var_2.script_parameters = "";
  var_2.requires_power = 0;
  var_2.hint_func = ::death_ray_hint_func;
  var_2.activation_func = scripts\cp\maps\cp_town\cp_town_interactions::blankusefunc;
  var_2.enabled = 1;
  var_2.disable_guided_interactions = 1;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
  return var_2;
}

get_not_ready_hint_pos(var_0) {
  if(var_0.origin == (2160, 3768, 144)) {
    return (2144, 3768, 153);
  }

  if(var_0.origin == (4244, 2947, 144)) {
    return (4254, 2942, 152);
  }

  if(var_0.origin == (3014, 2287, -49)) {
    return (3013, 2264, -48);
  }

  if(var_0.origin == (2683, 847.5, 410)) {
    return (2680, 822, 414);
  }
}

disable_all_death_ray_cannons() {
  foreach(var_1 in level.death_ray_cannons) {
    var_1 makeunusable();
    var_1 setdefaultdroppitch(30);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_1.not_ready_hint);
  }
}

enable_all_death_ray_cannons() {
  foreach(var_1 in level.death_ray_cannons) {
    var_1 makeusable();
    var_1 setdefaultdroppitch(0);
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1.not_ready_hint);
  }
}

load_death_ray_cannon_vfx() {
  level._effect["death_ray_cannon_beam"] = loadfx("vfx\iw7\levels\cp_town\death_ray_cannon_beam.vfx");
  level._effect["death_ray_cannon_muzzle_flash"] = loadfx("vfx\iw7\levels\cp_town\death_ray_cannon_muzzle_flash.vfx");
  level._effect["death_ray_cannon_buildup"] = loadfx("vfx\iw7\levels\cp_town\cannon\vfx_cannon_buildup.vfx");
  level._effect["death_ray_cannon_buildup_cancel"] = loadfx("vfx\iw7\levels\cp_town\cannon\vfx_cannon_build_cancel.vfx");
  level._effect["death_ray_cannon_water_impact"] = loadfx("vfx\iw7\levels\cp_town\cannon\vfx_wtr_impact.vfx");
  level._effect["death_ray_cannon_sand_impact"] = loadfx("vfx\iw7\levels\cp_town\cannon\vfx_sand_impact.vfx");
  level._effect["death_ray_cannon_rock_impact"] = loadfx("vfx\iw7\levels\cp_town\cannon\vfx_rock_impact.vfx");
  level._effect["death_ray_cannon_wood_impact"] = loadfx("vfx\iw7\levels\cp_town\cannon\vfx_wood_impact.vfx");
  level._effect["death_ray_cannon_weak_spot_impact"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_bcrog_imp_blood.vfx");
  level._effect["death_ray_cannon_ricochet"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_bcrog_imp_ricochet.vfx");
  level._effect["crab_boss_smash_attack"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_claw_smash_imp.vfx");
  level._effect["crab_boss_beam_attack"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_lure_laser_beam.vfx");
  level._effect["crab_boss_beam_impact"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_laser_buildup_imp.vfx");
  level._effect["crab_boss_beam_impact_buildup"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_beam_attack_buildup.vfx");
}

death_ray_player_use_monitor(var_0) {
  var_1 = int(20);
  for(;;) {
    var_0 waittill("trigger", var_2);
    var_2 playlocalsound("town_weap_mount_turret_plr");
    var_3 = 0;
    var_4 = 0;
    show_charge_progress(var_2);
    update_charge_progress(var_2, var_4 / var_1);
    var_2 thread leave_death_ray_cannon_monitor(var_2);
    while(var_2 isusingturret()) {
      if(var_2 attackbuttonpressed()) {
        if(!var_3) {
          var_0 playSound("town_laser_cannon_charge");
          playFXOnTag(level._effect["death_ray_cannon_buildup"], var_0, "tag_flash");
          var_3 = 1;
        }

        var_4 = var_4 + 1;
        update_charge_progress(var_2, var_4 + 1 / var_1);
      } else {
        if(var_3) {
          var_0 stopsounds();
          killfxontag(level._effect["death_ray_cannon_muzzle_flash"], var_0, "tag_flash");
          killfxontag(level._effect["death_ray_cannon_buildup"], var_0, "tag_flash");
          playFXOnTag(level._effect["death_ray_cannon_buildup_cancel"], var_0, "tag_flash");
          var_3 = 0;
        }

        var_4 = 0;
        update_charge_progress(var_2, var_4 / var_1);
      }

      if(var_4 == var_1) {
        if(var_3) {
          stopFXOnTag(level._effect["death_ray_cannon_buildup"], var_0, "tag_flash");
          var_3 = 0;
        }

        var_4 = 0;
        update_charge_progress(var_2, var_4 / var_1);
        fire_death_ray_cannon(var_0, var_2);
      }

      scripts\engine\utility::waitframe();
    }
  }
}

show_charge_progress(var_0) {
  var_0 setclientomnvar("zm_ui_num_targets_escaped", 1);
}

hide_charge_progress(var_0) {
  var_0 setclientomnvar("zm_ui_num_targets_escaped", 0);
}

update_charge_progress(var_0, var_1) {
  var_0 setclientomnvar("zom_entangler_progress_percent", var_1);
}

leave_death_ray_cannon_monitor(var_0) {
  var_0 endon("disconnect");
  while(var_0 isusingturret()) {
    scripts\engine\utility::waitframe();
  }

  var_0 playlocalsound("town_weap_unmount_turret_plr");
  hide_charge_progress(var_0);
}

activate_weak_spot() {
  var_0 = level.crab_boss.crab_boss_weak_spot;
  var_0 thread damage_monitor(var_0);
}

damage_monitor(var_0) {
  var_0 endon("death");
  level.crab_boss endon("stop_death_ray_attack_logic");
  var_0.health = 9999999;
  var_0 setCanDamage(1);
  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    var_0.health = 9999999;
    if(isplayer(var_2)) {
      var_2 scripts\cp\cp_damage::updatedamagefeedback("pink_arcane_cp");
      var_0B = 1;
      if(isDefined(var_0A) && issubstr(var_0A, "iw7_lockon_zm")) {
        level.crab_boss playSound("boss_crog_hit_gore");
        level.crab_boss playSound("boss_crog_pain");
        var_0B = 4500;
        playFXOnTag(level._effect["death_ray_cannon_weak_spot_impact"], level.crab_boss.crab_boss_weak_spot, "tag_origin");
      }

      level notify("crab_boss_weak_spot_hit", var_0B);
    }
  }
}

fire_death_ray_cannon(var_0, var_1) {
  var_0 playSound("town_laser_cannon_fire");
  var_2 = var_0 gettagorigin("tag_flash");
  playFXOnTag(level._effect["death_ray_cannon_muzzle_flash"], var_0, "tag_flash");
  var_3 = get_death_ray_trace(var_1);
  var_4 = get_death_ray_physics_trace(var_1);
  playfxbetweenpoints(level._effect["death_ray_cannon_beam"], var_2, vectortoangles(var_3["position"] - var_2), var_3["position"]);
  play_impact_vfx(var_3, var_4);
  if(is_crab_boss_weak_spot(var_3)) {
    level.crab_boss playSound("boss_crog_hit_gore");
    level.crab_boss playSound("boss_crog_pain");
    level.crab_boss scripts\aitypes\crab_boss\behaviors::interruptcurrentstate();
    var_1 scripts\cp\cp_damage::updatedamagefeedback("pink_arcane_cp");
    level.crab_boss.reveal_weak_spot = 1;
    level notify("crab_boss_weak_spot_initial_hit");
    level notify("crab_boss_weak_spot_hit", 15000);
  }

  earthquake(0.6, 0.5, var_0.origin, 100);
  var_0 turretfireenable();
  var_0 shootturret();
  scripts\engine\utility::waitframe();
  var_0 turretfiredisable();
  kill_nearby_mini_crab(var_3["position"], var_1);
  death_ray_cannon_cool_down(var_0, var_1);
}

kill_nearby_mini_crab(var_0, var_1) {
  var_2 = -25536;
  var_3 = 10000;
  foreach(var_5 in level.spawned_enemies) {
    if(distancesquared(var_5.origin, var_0) <= var_2) {
      var_5.ragdollimpactvector = vectornormalize(var_5.origin - var_0) * var_3;
      var_5.ragdollhitloc = "torso_lower";
      var_5 dodamage(var_5.health, var_0, var_1);
      var_1 scripts\cp\cp_damage::updatedamagefeedback("hitaliensoft");
    }
  }
}

death_ray_cannon_cool_down(var_0, var_1) {
  var_1 thread death_ray_cannon_cool_down_hud_manager(var_1);
  var_0 makeunusable();
  wait(1);
  var_0 makeusable();
}

death_ray_cannon_cool_down_hud_manager(var_0) {
  var_0 endon("disconnect");
  var_0 setclientomnvar("zm_ui_num_targets_escaped", 2);
  var_1 = int(20);
  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(var_0 isusingturret()) {
      scripts\engine\utility::waitframe();
      continue;
    }

    return;
  }

  var_0 setclientomnvar("zm_ui_num_targets_escaped", 1);
}

get_death_ray_trace(var_0) {
  var_1 = anglesToForward(var_0 getplayerangles());
  var_2 = var_0 getEye();
  return bulletTrace(var_2, var_2 + var_1 * 5000, 0, var_0);
}

get_death_ray_physics_trace(var_0) {
  var_1 = anglesToForward(var_0 getplayerangles());
  var_2 = var_0 getEye();
  return scripts\common\trace::ray_trace_detail(var_2, var_2 + var_1 * 5000, var_0, undefined, 1);
}

play_impact_vfx(var_0, var_1) {
  var_2 = get_vfx_alias(var_0, var_1);
  var_3 = get_vfx_loc(var_0, var_1);
  var_4 = vectortoangles(var_0["normal"]);
  if(var_2 == "death_ray_cannon_weak_spot_impact") {
    playFXOnTag(level._effect["death_ray_cannon_weak_spot_impact"], level.crab_boss.crab_boss_weak_spot, "tag_origin");
    return;
  }

  playFX(level._effect[var_2], var_3, anglestoright(var_4), var_0["normal"]);
}

get_vfx_loc(var_0, var_1) {
  if(is_crab_boss(var_1)) {
    return var_1["position"];
  }

  return var_0["position"];
}

get_vfx_alias(var_0, var_1) {
  if(is_crab_boss_weak_spot(var_0)) {
    return "death_ray_cannon_weak_spot_impact";
  }

  if(is_crab_boss(var_1)) {
    return "death_ray_cannon_ricochet";
  }

  switch (var_0["surfacetype"]) {
    case "wood_solid":
      return "death_ray_cannon_wood_impact";

    case "water":
    case "water_waist":
      return "death_ray_cannon_water_impact";

    case "rock":
    case "dirt":
      return "death_ray_cannon_rock_impact";

    default:
      return "death_ray_cannon_sand_impact";
  }
}

is_crab_boss(var_0) {
  return isDefined(var_0["entity"]) && isDefined(level.crab_boss) && var_0["entity"] == level.crab_boss;
}

is_crab_boss_weak_spot(var_0) {
  return isDefined(var_0["entity"]) && scripts\engine\utility::istrue(var_0["entity"].is_crab_boss_weak_spot);
}

set_up_weak_spot() {
  var_0 = level.crab_boss gettagorigin("j_spineupper");
  var_1 = spawn("script_model", var_0);
  var_1 setModel("zmb_crabboss_weak_spot");
  var_1 linkto(level.crab_boss, "j_spineupper", (0, -125, 0), (90, -55, 0));
  var_1 hide();
  var_1.is_crab_boss_weak_spot = 1;
  var_2 = spawn("script_model", var_0);
  var_2 setModel("crab_boss_origin");
  var_2 linkto(var_1, "tag_origin");
  level.crab_boss.crab_boss_weak_spot = var_1;
  level.crab_boss.crab_boss_weak_vfx = var_2;
}

get_death_ray_cannon_location(var_0) {
  var_1 = (2112, 3748, 217);
  var_2 = (4254, 2948, 211);
  var_3 = (3018, 2267, 11);
  var_4 = (2679, 835, 476);
  var_5 = 90000;
  if(distance2dsquared(var_1, var_0.origin) < var_5) {
    return "left";
  }

  if(distance2dsquared(var_2, var_0.origin) < var_5) {
    return "right";
  }

  if(distance2dsquared(var_3, var_0.origin) < var_5) {
    return "center";
  }

  if(distance2dsquared(var_4, var_0.origin) < var_5) {
    return "back";
  }
}

mini_crab_spawning_logic() {
  level.crab_boss endon("stop_death_ray_attack_logic");
  wait(16);
  level thread increasing_max_mini_crab_count();
  for(var_0 = 0; var_0 < 10; var_0++) {
    spawn_one_mini_crab();
    scripts\engine\utility::waitframe();
  }

  for(;;) {
    while(level.spawned_enemies.size < level.max_mini_crab_count) {
      spawn_one_mini_crab();
      wait(3);
    }

    scripts\engine\utility::waitframe();
  }
}

increasing_max_mini_crab_count() {
  level.crab_boss endon("stop_death_ray_attack_logic");
  for(var_0 = 10; var_0 <= 23; var_0++) {
    level.max_mini_crab_count = var_0;
    wait(20);
  }
}

spawn_one_mini_crab() {
  var_0 = 70;
  var_1 = [(4208, 3491, -198), (4066, 3438, -198), (3873, 3338, -198), (3657, 3262, -198), (3422, 3258, -198), (3180, 3296, -198), (2917, 3462, -198), (2813, 3652, -198), (2698, 3841, -198), (2655, 4036, -198)];
  var_2 = scripts\engine\utility::random(var_1);
  var_3 = randomfloatrange(var_0 * -1, var_0);
  var_4 = randomfloatrange(var_0 * -1, var_0);
  var_2 = (var_2[0] + var_3, var_2[1] + var_4, var_2[2]);
  var_2 = getclosestpointonnavmesh(var_2);
  var_5 = make_mini_crab_spawner(var_2);
  var_6 = var_5 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("crab_mini", 1, var_5);
}

make_mini_crab_spawner(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  var_1.angles = (0, 256, 0);
  return var_1;
}

set_arc_value(var_0) {
  var_1 = get_death_ray_cannon_location(var_0);
  switch (var_1) {
    case "left":
      var_0 setleftarc(60);
      var_0 setrightarc(60);
      var_0 settoparc(14);
      var_0 give_crafted_gascan(30);
      break;

    case "right":
      var_0 setleftarc(60);
      var_0 setrightarc(60);
      var_0 settoparc(14);
      var_0 give_crafted_gascan(30);
      break;

    case "center":
      var_0 setleftarc(60);
      var_0 setrightarc(60);
      var_0 settoparc(14);
      var_0 give_crafted_gascan(30);
      break;

    case "back":
      var_0 setleftarc(60);
      var_0 setrightarc(60);
      var_0 settoparc(5);
      var_0 give_crafted_gascan(50);
      break;
  }
}

crab_boss_pain_and_heal() {
  level.crab_boss scripts\aitypes\crab_boss\behaviors::dopain(5);
  level.crab_boss waittill("pain_done");
  level.crab_boss crab_boss_face_point((3014, 2250, -44));
}

get_target_player() {
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
    if(!isDefined(var_3.last_attacked_by_crab_boss_time)) {
      var_3.last_attacked_by_crab_boss_time = var_5;
    }
  }

  var_8 = undefined;
  foreach(var_3 in var_1) {
    if(!isDefined(var_8)) {
      var_8 = var_3.last_attacked_by_crab_boss_time;
      var_0 = var_3;
      continue;
    }

    if(var_3.last_attacked_by_crab_boss_time < var_8) {
      var_8 = var_3.last_attacked_by_crab_boss_time;
      var_0 = var_3;
    }
  }

  if(isDefined(var_0)) {
    var_0.last_attacked_by_crab_boss_time = var_5;
  }

  return var_0;
}

delay_player_shellshock() {
  level endon("game_ended");
  level.crab_boss endon("death");
  var_0 = 2;
  wait(7);
  earthquake(0.2, var_0, level.crab_boss.origin, 5000);
}

death_ray_hint_func(var_0, var_1) {
  return &"CP_TOWN_DEATH_RAY_NOT_READY";
}