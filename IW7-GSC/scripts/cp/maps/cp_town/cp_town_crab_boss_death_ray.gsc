/*******************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
    var_00 = get_target_player();
    if(isDefined(var_00)) {
      level.crab_boss attack_player(var_00);
      continue;
    }

    level.crab_boss scripts\cp\maps\cp_town\cp_town_crab_boss_death_wall::do_taunt();
  }
}

bomb_capture_dialogue() {
  level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("el_deathray_ready", "elvira_player_dialogue_vo", "highest", 70, 0, 0, 1);
  wait(scripts\cp\cp_vo::get_sound_length("el_deathray_ready") + 10);
}

attack_player(param_00) {
  var_01 = func_7842(param_00);
  level.crab_boss crab_boss_face_point(param_00.origin);
  switch (var_01) {
    case "beam":
      level.crab_boss crab_boss_beam(param_00);
      break;

    case "smash":
      level.crab_boss crab_boss_smash();
      break;

    case "spawn":
      level.crab_boss crab_boss_spawn(param_00);
      break;

    case "bomb":
      level.crab_boss crab_boss_bomb(param_00);
      break;

    default:
      break;
  }
}

func_7842(param_00) {
  if(player_under_overhead_bridge(param_00)) {
    return "beam";
  }

  if(player_near_left_or_right_cannon(param_00)) {
    return "beam";
  }

  if(player_near_center_cannon(param_00)) {
    return scripts\engine\utility::random(["beam", "smash"]);
  }

  if(player_on_overhead_bridge(param_00)) {
    return scripts\engine\utility::random(["spawn"]);
  }

  if(player_near_crab_boss(param_00)) {
    return scripts\engine\utility::random(["beam", "smash"]);
  }

  return scripts\engine\utility::random(["spawn", "bomb"]);
}

player_under_overhead_bridge(param_00) {
  if(param_00.origin[2] >= 161) {
    return 0;
  }

  return param_00.origin[1] >= -300 & param_00.origin[1] <= 1400;
}

player_near_left_or_right_cannon(param_00) {
  if(distancesquared(param_00.origin, (2135, 3746, 164)) <= 90000) {
    return 1;
  }

  if(distancesquared(param_00.origin, (4265, 2933, 164)) <= 90000) {
    return 1;
  }

  return 0;
}

player_on_overhead_bridge(param_00) {
  return param_00.origin[2] > 390;
}

player_near_center_cannon(param_00) {
  return distancesquared(param_00.origin, (3014, 2250, -44)) <= 90000;
}

player_near_crab_boss(param_00) {
  return distance2d(param_00.origin, level.crab_boss.origin) <= 2200;
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
  var_00 = scripts\engine\utility::drop_to_ground((2054, 3742, 178), 100, -200);
  var_01 = scripts\engine\utility::drop_to_ground((2054, 3742, 178), 100, -200);
  level.crab_boss crab_boss_face_point((2135, 3746, 164));
  level.crab_boss crab_boss_beam(var_00, var_01);
}

attack_right_turret() {
  var_00 = scripts\engine\utility::drop_to_ground((4317, 2918, 172), 100, -200);
  var_01 = scripts\engine\utility::drop_to_ground((4317, 2918, 172), 100, -200);
  level.crab_boss crab_boss_face_point((4265, 2933, 164));
  level.crab_boss crab_boss_beam(var_00, var_01);
}

attack_back_turret() {
  var_00 = (2657, 750, 470);
  var_01 = 100;
  var_02 = 10;
  level.crab_boss crab_boss_face_point((2686, 807, 421));
  level.crab_boss crab_boss_bomb(var_00, var_01, var_02);
}

crab_boss_move_to(param_00) {
  level.crab_boss crab_boss_face_point(param_00);
  level.crab_boss scripts\aitypes\crab_boss\behaviors::bossmoveto(0, param_00);
  level.crab_boss waittill("move_complete");
}

crab_boss_face_point(param_00) {
  if(level.crab_boss scripts\aitypes\crab_boss\behaviors::facepoint(0, param_00)) {
    level.crab_boss waittill("turn_done");
  }
}

crab_boss_smash() {
  level.crab_boss scripts\aitypes\crab_boss\behaviors::dosmashattack(0);
  level.crab_boss waittill("smash_done");
}

crab_boss_beam(param_00) {
  level.crab_boss scripts\aitypes\crab_boss\behaviors::beamattackposition(0, param_00);
  level.crab_boss waittill("beam_done");
}

crab_boss_spawn(param_00) {
  var_01 = scripts\cp\maps\cp_town\cp_town_crab_boss_fight::get_num_alive_agent_of_type("crab_mini");
  if(var_01 >= 8) {
    level.crab_boss crab_boss_bomb(param_00);
    return;
  }

  level.crab_boss scripts\aitypes\crab_boss\behaviors::dodeathrayspawn(param_00);
  level.crab_boss waittill("toxic_spawn_done");
}

crab_boss_bomb(param_00) {
  level.crab_boss.bomb_target = param_00;
  level.crab_boss scripts\aitypes\crab_boss\behaviors::dobombattack(0);
  level.crab_boss waittill("bomb_done");
}

set_up_death_ray_cannons() {
  level.death_ray_cannons = [];
  var_00 = scripts\engine\utility::getstructarray("death_ray_cannon", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_03 = spawnturret("misc_turret", var_02.origin, "death_ray_cannon_zm");
    var_03 setModel("cp_town_laser_death_ray");
    var_03 give_player_session_tokens("manual");
    var_03 turretfiredisable();
    var_03 makeunusable();
    var_03 setdefaultdroppitch(30);
    var_03 getvalidlocation();
    var_03 sethintstring( & "CP_TOWN_USE_DEATH_RAY_CANNON");
    var_03.angles = var_02.angles;
    var_03 set_arc_value(var_03);
    var_03.not_ready_hint = set_up_not_ready_hint(var_03);
    var_03 thread death_ray_player_use_monitor(var_03);
    var_04 = get_death_ray_cannon_location(var_03);
    level.death_ray_cannons[var_04] = var_03;
  }
}

set_up_not_ready_hint(param_00) {
  var_01 = get_not_ready_hint_pos(param_00);
  var_02 = spawnStruct();
  var_02.name = "death_ray_cannon";
  var_02.script_noteworthy = "death_ray_cannon";
  var_02.origin = var_01;
  var_02.cost = 0;
  var_02.powered_on = 1;
  var_02.spend_type = undefined;
  var_02.script_parameters = "";
  var_02.requires_power = 0;
  var_02.hint_func = ::death_ray_hint_func;
  var_02.activation_func = ::scripts\cp\maps\cp_town\cp_town_interactions::blankusefunc;
  var_02.enabled = 1;
  var_02.disable_guided_interactions = 1;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_02);
  return var_02;
}

get_not_ready_hint_pos(param_00) {
  if(param_00.origin == (2160, 3768, 144)) {
    return (2144, 3768, 153);
  }

  if(param_00.origin == (4244, 2947, 144)) {
    return (4254, 2942, 152);
  }

  if(param_00.origin == (3014, 2287, -49)) {
    return (3013, 2264, -48);
  }

  if(param_00.origin == (2683, 847.5, 410)) {
    return (2680, 822, 414);
  }
}

disable_all_death_ray_cannons() {
  foreach(var_01 in level.death_ray_cannons) {
    var_01 makeunusable();
    var_01 setdefaultdroppitch(30);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_01.not_ready_hint);
  }
}

enable_all_death_ray_cannons() {
  foreach(var_01 in level.death_ray_cannons) {
    var_01 makeusable();
    var_01 setdefaultdroppitch(0);
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_01.not_ready_hint);
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

death_ray_player_use_monitor(param_00) {
  var_01 = int(20);
  for(;;) {
    param_00 waittill("trigger", var_02);
    var_02 playlocalsound("town_weap_mount_turret_plr");
    var_03 = 0;
    var_04 = 0;
    show_charge_progress(var_02);
    update_charge_progress(var_02, var_04 / var_01);
    var_02 thread leave_death_ray_cannon_monitor(var_02);
    while(var_02 isusingturret()) {
      if(var_02 attackbuttonpressed()) {
        if(!var_03) {
          param_00 playSound("town_laser_cannon_charge");
          playFXOnTag(level._effect["death_ray_cannon_buildup"], param_00, "tag_flash");
          var_03 = 1;
        }

        var_04 = var_04 + 1;
        update_charge_progress(var_02, var_04 + 1 / var_01);
      } else {
        if(var_03) {
          param_00 stopsounds();
          killfxontag(level._effect["death_ray_cannon_muzzle_flash"], param_00, "tag_flash");
          killfxontag(level._effect["death_ray_cannon_buildup"], param_00, "tag_flash");
          playFXOnTag(level._effect["death_ray_cannon_buildup_cancel"], param_00, "tag_flash");
          var_03 = 0;
        }

        var_04 = 0;
        update_charge_progress(var_02, var_04 / var_01);
      }

      if(var_04 == var_01) {
        if(var_03) {
          stopFXOnTag(level._effect["death_ray_cannon_buildup"], param_00, "tag_flash");
          var_03 = 0;
        }

        var_04 = 0;
        update_charge_progress(var_02, var_04 / var_01);
        fire_death_ray_cannon(param_00, var_02);
      }

      scripts\engine\utility::waitframe();
    }
  }
}

show_charge_progress(param_00) {
  param_00 setclientomnvar("zm_ui_num_targets_escaped", 1);
}

hide_charge_progress(param_00) {
  param_00 setclientomnvar("zm_ui_num_targets_escaped", 0);
}

update_charge_progress(param_00, param_01) {
  param_00 setclientomnvar("zom_entangler_progress_percent", param_01);
}

leave_death_ray_cannon_monitor(param_00) {
  param_00 endon("disconnect");
  while(param_00 isusingturret()) {
    scripts\engine\utility::waitframe();
  }

  param_00 playlocalsound("town_weap_unmount_turret_plr");
  hide_charge_progress(param_00);
}

activate_weak_spot() {
  var_00 = level.crab_boss.crab_boss_weak_spot;
  var_00 thread damage_monitor(var_00);
}

damage_monitor(param_00) {
  param_00 endon("death");
  level.crab_boss endon("stop_death_ray_attack_logic");
  param_00.health = 9999999;
  param_00 setCanDamage(1);
  for(;;) {
    param_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    param_00.health = 9999999;
    if(isplayer(var_02)) {
      var_02 scripts\cp\cp_damage::updatedamagefeedback("pink_arcane_cp");
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

fire_death_ray_cannon(param_00, param_01) {
  param_00 playSound("town_laser_cannon_fire");
  var_02 = param_00 gettagorigin("tag_flash");
  playFXOnTag(level._effect["death_ray_cannon_muzzle_flash"], param_00, "tag_flash");
  var_03 = get_death_ray_trace(param_01);
  var_04 = get_death_ray_physics_trace(param_01);
  playfxbetweenpoints(level._effect["death_ray_cannon_beam"], var_02, vectortoangles(var_03["position"] - var_02), var_03["position"]);
  play_impact_vfx(var_03, var_04);
  if(is_crab_boss_weak_spot(var_03)) {
    level.crab_boss playSound("boss_crog_hit_gore");
    level.crab_boss playSound("boss_crog_pain");
    level.crab_boss scripts\aitypes\crab_boss\behaviors::interruptcurrentstate();
    param_01 scripts\cp\cp_damage::updatedamagefeedback("pink_arcane_cp");
    level.crab_boss.reveal_weak_spot = 1;
    level notify("crab_boss_weak_spot_initial_hit");
    level notify("crab_boss_weak_spot_hit", 15000);
  }

  earthquake(0.6, 0.5, param_00.origin, 100);
  param_00 turretfireenable();
  param_00 shootturret();
  scripts\engine\utility::waitframe();
  param_00 turretfiredisable();
  kill_nearby_mini_crab(var_03["position"], param_01);
  death_ray_cannon_cool_down(param_00, param_01);
}

kill_nearby_mini_crab(param_00, param_01) {
  var_02 = -25536;
  var_03 = 10000;
  foreach(var_05 in level.spawned_enemies) {
    if(distancesquared(var_05.origin, param_00) <= var_02) {
      var_05.ragdollimpactvector = vectornormalize(var_05.origin - param_00) * var_03;
      var_05.ragdollhitloc = "torso_lower";
      var_05 dodamage(var_05.health, param_00, param_01);
      param_01 scripts\cp\cp_damage::updatedamagefeedback("hitaliensoft");
    }
  }
}

death_ray_cannon_cool_down(param_00, param_01) {
  param_01 thread death_ray_cannon_cool_down_hud_manager(param_01);
  param_00 makeunusable();
  wait(1);
  param_00 makeusable();
}

death_ray_cannon_cool_down_hud_manager(param_00) {
  param_00 endon("disconnect");
  param_00 setclientomnvar("zm_ui_num_targets_escaped", 2);
  var_01 = int(20);
  for(var_02 = 0; var_02 < var_01; var_02++) {
    if(param_00 isusingturret()) {
      scripts\engine\utility::waitframe();
      continue;
    }

    return;
  }

  param_00 setclientomnvar("zm_ui_num_targets_escaped", 1);
}

get_death_ray_trace(param_00) {
  var_01 = anglesToForward(param_00 getplayerangles());
  var_02 = param_00 getEye();
  return bulletTrace(var_02, var_02 + var_01 * 5000, 0, param_00);
}

get_death_ray_physics_trace(param_00) {
  var_01 = anglesToForward(param_00 getplayerangles());
  var_02 = param_00 getEye();
  return scripts\common\trace::ray_trace_detail(var_02, var_02 + var_01 * 5000, param_00, undefined, 1);
}

play_impact_vfx(param_00, param_01) {
  var_02 = get_vfx_alias(param_00, param_01);
  var_03 = get_vfx_loc(param_00, param_01);
  var_04 = vectortoangles(param_00["normal"]);
  if(var_02 == "death_ray_cannon_weak_spot_impact") {
    playFXOnTag(level._effect["death_ray_cannon_weak_spot_impact"], level.crab_boss.crab_boss_weak_spot, "tag_origin");
    return;
  }

  playFX(level._effect[var_02], var_03, anglestoright(var_04), param_00["normal"]);
}

get_vfx_loc(param_00, param_01) {
  if(is_crab_boss(param_01)) {
    return param_01["position"];
  }

  return param_00["position"];
}

get_vfx_alias(param_00, param_01) {
  if(is_crab_boss_weak_spot(param_00)) {
    return "death_ray_cannon_weak_spot_impact";
  }

  if(is_crab_boss(param_01)) {
    return "death_ray_cannon_ricochet";
  }

  switch (param_00["surfacetype"]) {
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

is_crab_boss(param_00) {
  return isDefined(param_00["entity"]) && isDefined(level.crab_boss) && param_00["entity"] == level.crab_boss;
}

is_crab_boss_weak_spot(param_00) {
  return isDefined(param_00["entity"]) && scripts\engine\utility::istrue(param_00["entity"].is_crab_boss_weak_spot);
}

set_up_weak_spot() {
  var_00 = level.crab_boss gettagorigin("j_spineupper");
  var_01 = spawn("script_model", var_00);
  var_01 setModel("zmb_crabboss_weak_spot");
  var_01 linkto(level.crab_boss, "j_spineupper", (0, -125, 0), (90, -55, 0));
  var_01 hide();
  var_01.is_crab_boss_weak_spot = 1;
  var_02 = spawn("script_model", var_00);
  var_02 setModel("crab_boss_origin");
  var_02 linkto(var_01, "tag_origin");
  level.crab_boss.crab_boss_weak_spot = var_01;
  level.crab_boss.crab_boss_weak_vfx = var_02;
}

get_death_ray_cannon_location(param_00) {
  var_01 = (2112, 3748, 217);
  var_02 = (4254, 2948, 211);
  var_03 = (3018, 2267, 11);
  var_04 = (2679, 835, 476);
  var_05 = 90000;
  if(distance2dsquared(var_01, param_00.origin) < var_05) {
    return "left";
  }

  if(distance2dsquared(var_02, param_00.origin) < var_05) {
    return "right";
  }

  if(distance2dsquared(var_03, param_00.origin) < var_05) {
    return "center";
  }

  if(distance2dsquared(var_04, param_00.origin) < var_05) {
    return "back";
  }
}

mini_crab_spawning_logic() {
  level.crab_boss endon("stop_death_ray_attack_logic");
  wait(16);
  level thread increasing_max_mini_crab_count();
  for(var_00 = 0; var_00 < 10; var_00++) {
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
  for(var_00 = 10; var_00 <= 23; var_00++) {
    level.max_mini_crab_count = var_00;
    wait(20);
  }
}

spawn_one_mini_crab() {
  var_00 = 70;
  var_01 = [(4208, 3491, -198), (4066, 3438, -198), (3873, 3338, -198), (3657, 3262, -198), (3422, 3258, -198), (3180, 3296, -198), (2917, 3462, -198), (2813, 3652, -198), (2698, 3841, -198), (2655, 4036, -198)];
  var_02 = scripts\engine\utility::random(var_01);
  var_03 = randomfloatrange(var_00 * -1, var_00);
  var_04 = randomfloatrange(var_00 * -1, var_00);
  var_02 = (var_02[0] + var_03, var_02[1] + var_04, var_02[2]);
  var_02 = getclosestpointonnavmesh(var_02);
  var_05 = make_mini_crab_spawner(var_02);
  var_06 = var_05 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("crab_mini", 1, var_05);
}

make_mini_crab_spawner(param_00) {
  var_01 = spawnStruct();
  var_01.origin = param_00;
  var_01.angles = (0, 256, 0);
  return var_01;
}

set_arc_value(param_00) {
  var_01 = get_death_ray_cannon_location(param_00);
  switch (var_01) {
    case "left":
      param_00 setleftarc(60);
      param_00 setrightarc(60);
      param_00 settoparc(14);
      param_00 give_crafted_gascan(30);
      break;

    case "right":
      param_00 setleftarc(60);
      param_00 setrightarc(60);
      param_00 settoparc(14);
      param_00 give_crafted_gascan(30);
      break;

    case "center":
      param_00 setleftarc(60);
      param_00 setrightarc(60);
      param_00 settoparc(14);
      param_00 give_crafted_gascan(30);
      break;

    case "back":
      param_00 setleftarc(60);
      param_00 setrightarc(60);
      param_00 settoparc(5);
      param_00 give_crafted_gascan(50);
      break;
  }
}

crab_boss_pain_and_heal() {
  level.crab_boss scripts\aitypes\crab_boss\behaviors::dopain(5);
  level.crab_boss waittill("pain_done");
  level.crab_boss crab_boss_face_point((3014, 2250, -44));
}

get_target_player() {
  var_00 = undefined;
  var_01 = [];
  foreach(var_03 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_03)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  var_05 = gettime();
  foreach(var_03 in var_01) {
    if(!isDefined(var_03.last_attacked_by_crab_boss_time)) {
      var_03.last_attacked_by_crab_boss_time = var_05;
    }
  }

  var_08 = undefined;
  foreach(var_03 in var_01) {
    if(!isDefined(var_08)) {
      var_08 = var_03.last_attacked_by_crab_boss_time;
      var_00 = var_03;
      continue;
    }

    if(var_03.last_attacked_by_crab_boss_time < var_08) {
      var_08 = var_03.last_attacked_by_crab_boss_time;
      var_00 = var_03;
    }
  }

  if(isDefined(var_00)) {
    var_00.last_attacked_by_crab_boss_time = var_05;
  }

  return var_00;
}

delay_player_shellshock() {
  level endon("game_ended");
  level.crab_boss endon("death");
  var_00 = 2;
  wait(7);
  earthquake(0.2, var_00, level.crab_boss.origin, 5000);
}

death_ray_hint_func(param_00, param_01) {
  return & "CP_TOWN_DEATH_RAY_NOT_READY";
}