/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_ufo.gsc
*************************************************/

init_ufo_quest() {
  level endon("game_ended");
  scripts\mp\agents\zombie_grey\zombie_grey_agent::registerscriptedagent();
  level thread power_on_monitor();
  var_00 = scripts\engine\utility::getstruct("ufo_initial_position", "targetname");
  init_ufo_vfx();
  init_ufo_anim();
  wait(3);
  var_01 = spawn("script_model", var_00.origin);
  var_01.angles = var_00.angles;
  var_01 setModel("zmb_spaceland_ufo_off");
  level.ufo = var_01;
  level.grey_on_killed_func = ::grey_on_killed_func;
  level.greygetmeleedamagedfunc = ::remove_alien_fuse;
  level.greysetupfunc = ::attach_alien_fuse;
  level.num_fuse_in_possession = 0;
  level.pre_grey_regen_func = ::ufo_pre_grey_regen_func;
  level.post_grey_regen_func = ::ufo_post_grey_regen_func;
  scripts\engine\utility::flag_init("fuses_inserted");
  scripts\engine\utility::flag_init("dj_ufo_destroy_nag");
}

init_ufo_anim() {
  precachempanim("zmb_spaceland_ufo_idle");
  precachempanim("zmb_spaceland_ufo_breakaway");
}

init_ufo_vfx() {
  level._effect["ufo_explosion"] = loadfx("vfx\iw7\_requests\coop\vfx_ufo_explosion.vfx");
  level._effect["ufo_small_explosion"] = loadfx("vfx\iw7\core\zombie\ufo\ufo_explosion\vfx_ufo_expl_sm_body.vfx");
  level._effect["ufo_zombie_spawn_beam"] = loadfx("vfx\iw7\core\zombie\ufo\ufo_beam\vfx_ufo_beam_spawning.vfx");
  level._effect["ufo_lazer_beam"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_ufobeam.vfx");
  level._effect["powernode_arc_small"] = loadfx("vfx\iw7\core\zombie\ufo\vfx_sentry_shock_arc_s.vfx");
  level._effect["powernode_arc_medium"] = loadfx("vfx\iw7\core\zombie\ufo\vfx_sentry_shock_arc_m.vfx");
  level._effect["powernode_arc_big"] = loadfx("vfx\iw7\core\zombie\ufo\vfx_sentry_shock_arc_b.vfx");
  level._effect["ufo_elec_beam_impact"] = loadfx("vfx\iw7\core\zombie\ufo\vfx_ufo_elec_beam_impact.vfx");
  level._effect["soul_key_glow"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_soulkey_flames.vfx");
}

power_on_monitor() {
  level endon("game_ended");
  var_00 = 0;
  for(;;) {
    level waittill("activate_power");
    var_00++;
    var_01 = get_ufo_model(var_00);
    level.ufo setModel(var_01);
    if(var_00 == 5) {
      break;
    }
  }
}

get_ufo_model(param_00) {
  switch (param_00) {
    case 1:
      return "zmb_spaceland_ufo_blue";

    case 2:
      return "zmb_spaceland_ufo_green";

    case 3:
      return "zmb_spaceland_ufo_yellow";

    case 4:
      return "zmb_spaceland_ufo_red";

    case 5:
      return "zmb_spaceland_ufo";

    default:
      break;
  }
}

ufo_suicide_bomber_sequence() {
  level endon("debug_beat_UFO_suicide_bomber");
  var_00 = level.ufo;
  level thread transform_wave_zombies_to_suicide_bombers();
  var_00 moveto((647, 621, 901), 5);
  var_00 waittill("movedone");
  foreach(var_02 in level.fast_travel_spots) {
    var_02.disabled = undefined;
    scripts\cp\zombies\zombie_fast_travel::turn_on_exit_portal_fx(0);
  }

  level.beam_trap_vfx = play_fx_with_delay(1, "ufo_lazer_beam", var_00.origin);
  var_04 = 50;
  var_05 = 50;
  level.num_ufo_zombies_killed = 0;
  while(var_04 >= 0) {
    for(;;) {
      var_06 = make_suicide_bomber_spawn_struct();
      var_07 = var_06 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("generic_zombie", 1);
      if(isDefined(var_07)) {
        break;
      }

      wait(0.05);
    }

    var_04--;
    var_07.entered_playspace = 1;
    var_07.nocorpse = 1;
    var_07.health = 5000;
    var_07.is_suicide_bomber = 1;
    var_07.is_reserved = 1;
    var_07 setscriptablepartstate("eyes", "eye_glow_off");
    var_07 detachall();
    var_07 setModel("park_clown_zombie");
    var_07.should_play_transformation_anim = 0;
    var_07 thread delayed_move_mode(var_07);
    var_07 thread death_track(var_05);
    wait(randomfloatrange(0.05, 1));
  }

  while(level.num_ufo_zombies_killed < var_05) {
    wait(1);
  }

  level.beam_trap_vfx delete();
  wait(1);
}

ufostopwavefromprogressing() {
  level thread deactivateadjacentvolumes();
  level.savedcurrentdeaths = level.current_enemy_deaths;
  level.savemaxspawns = level.max_static_spawned_enemies;
  level.savedesireddeaths = level.desired_enemy_deaths_this_wave;
  level.ufo_starting_wave = level.wave_num;
  level.wave_num_override = 28;
  level.current_enemy_deaths = 0;
  level.max_static_spawned_enemies = 24;
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    level.spawndelayoverride = 0.7;
  } else {
    level.spawndelayoverride = 0.35;
  }

  level thread force_zombie_sprint();
  scripts\engine\utility::flag_set("pause_wave_progression");
  if(scripts\engine\utility::flag_exist("tones_played_successfully")) {
    scripts\engine\utility::flag_wait("tones_played_successfully");
  }
}

force_zombie_sprint() {
  level endon("complete_alien_grey_fight");
  foreach(var_01 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    var_01 thread scripts\cp\maps\cp_zmb\cp_zmb_dj::adjustmovespeed(var_01);
  }

  for(;;) {
    level waittill("agent_spawned", var_03);
    if(isDefined(var_03.agent_type) && var_03.agent_type == "zombie_brute") {
      continue;
    }

    var_03 thread scripts\cp\maps\cp_zmb\cp_zmb_dj::adjustmovespeed(var_03, 1);
  }
}

deactivateadjacentvolumes() {
  level endon("game_ended");
  var_00 = level.active_spawn_volumes;
  var_01 = getEntArray("placed_transponder", "script_noteworthy");
  foreach(var_03 in var_00) {
    if(var_03.basename == "moon" || var_03.basename == "front_gate") {
      continue;
    }

    var_03 scripts\cp\zombies\zombies_spawning::make_volume_inactive();
    foreach(var_05 in var_01) {
      if(ispointinvolume(var_05.origin, var_03)) {
        var_05 notify("detonateExplosive");
      }
    }
  }

  while(!scripts\engine\utility::flag("disable_portals")) {
    wait(0.05);
  }

  scripts\engine\utility::flag_waitopen("disable_portals");
  foreach(var_09 in var_00) {
    var_09 scripts\cp\zombies\zombies_spawning::make_volume_active();
  }
}

ufo_intro_fly_to_center_portal() {
  level thread play_ufo_start_vfx();
  var_00 = level.ufo;
  var_00.angles = vectortoangles((1, 0, 0));
  var_00 thread ufo_earthquake();
  var_00 thread ufo_damage_monitor(var_00);
  var_00 playLoopSound("ufo_movement_lp");
  var_00.origin = (647, 621, 901);
  var_00.angles = (0, 0, 0);
  var_00 scriptmodelplayanim("zmb_spaceland_ufo_breakaway", 1);
  var_00 setscriptablepartstate("thrusters", "on");
  wait(7);
  var_00 scriptmodelplayanim("zmb_spaceland_ufo_idle");
  scripts\engine\utility::flag_set("ufo_intro_reach_center_portal");
}

start_match_tone_sequence() {
  level endon("tones_played_successfully");
  var_00 = level.ufo;
  scripts\engine\utility::flag_wait("ufo_intro_reach_center_portal");
  setup_ufo_tone_array();
  var_00 play_match_tone_sequence();
}

setup_ufo_tone_array() {
  var_00 = level.ufo;
  var_01 = [];
  for(var_02 = 0; var_02 < 4; var_02++) {
    var_03 = strtok(level.ufotones[var_02], "_");
    var_01[var_01.size] = var_03[3];
  }

  var_00.tone_array = scripts\engine\utility::array_randomize_objects(var_01);
}

play_match_tone_sequence() {
  level endon("tone_sequence_completed");
  var_00 = 5;
  var_01 = level.ufo;
  var_01 thread listenjump();
  for(;;) {
    playtonesequence();
    var_02 = 0;
    for(var_03 = 0; var_03 < var_00; var_03++) {
      var_04 = get_beam_down_ground_location();
      var_05 = (var_04.origin[0], var_04.origin[1], var_01.origin[2]);
      var_06 = distance(var_01.origin, var_05);
      var_07 = var_06 / 150;
      var_01 playSound("ufo_movement_start");
      var_01 moveto(var_05, var_07);
      var_01 waittill("movedone");
    }

    var_06 = distance(var_01.origin, (647, 621, 901));
    var_07 = var_06 / 150;
    if(var_07 < 0.05) {
      var_07 = 0.05;
    }

    var_01 playSound("ufo_movement_start");
    var_01 moveto((647, 621, 901), var_07);
    var_01 waittill("movedone");
  }
}

disableportals() {
  scripts\engine\utility::flag_set("disable_portals");
  foreach(var_01 in level.fast_travel_spots) {
    var_01.disabled = 1;
    var_01 turn_off_exit_portal_fx();
    var_01 scripts\cp\zombies\zombie_fast_travel::portal_close_fx();
  }
}

enableportals() {
  scripts\engine\utility::flag_clear("disable_portals");
  foreach(var_01 in level.fast_travel_spots) {
    var_01.disabled = undefined;
  }
}

play_fail_sound() {
  level endon("game_ended");
  foreach(var_01 in level.players) {
    var_01 playlocalsound("dj_deny");
  }

  wait(2);
  foreach(var_01 in level.players) {
    var_01 playlocalsound("ww_magicbox_laughter");
  }
}

listenjump() {
  level endon("tones_played_successfully");
  var_00 = level.ufo;
  scripts\cp\maps\cp_zmb\cp_zmb_dj::activateallmiddleplacementstructs();
  var_01 = 1;
  var_02 = 0;
  var_03 = undefined;
  while(var_01) {
    var_04 = 0;
    var_05 = 0;
    var_06 = 1;
    for(;;) {
      scripts\cp\maps\cp_zmb\cp_zmb_dj::activateallmiddleplacementstructs();
      level waittill("tone_played", var_07, var_03);
      if(!scripts\engine\utility::flag("ufo_listening")) {
        break;
      }

      if(!isDefined(var_07)) {
        level notify("played_tones_too_slowly");
        var_00 notify("played_tones_too_slowly");
        setalltonestructstostate("idle - on");
        level thread play_fail_sound();
        scripts\cp\maps\cp_zmb\cp_zmb_dj::deactivateallmiddleplacementstructs();
        wait(2);
        break;
      }

      if(!isDefined(var_03)) {
        wait(2);
        break;
      }

      var_00 thread setplaybacktimer();
      var_08 = getstructstate(var_07, "active");
      settonestructtostate(var_03, var_08);
      var_05++;
      if(var_06 && var_07 == var_00.tone_array[var_04]) {
        var_04++;
        if(var_04 == 4) {
          var_02++;
          var_00 notify("completed_tone_match");
          scripts\engine\utility::flag_clear("force_spawn_boss");
          if(var_02 == 3) {
            var_01 = 0;
            wait(2);
            level notify("tone_sequence_completed");
            level thread scripts\cp\cp_vo::try_to_play_vo("ww_ufo_tonegen_complete", "zmb_ww_vo", "highest", 60, 1, 0, 1);
            break;
          } else {
            var_00.tone_array = scripts\engine\utility::array_randomize_objects(var_00.tone_array);
            scripts\cp\maps\cp_zmb\cp_zmb_dj::deactivateallmiddleplacementstructs();
            wait(4);
            break;
          }
        } else {
          level notify("correct_tone_played");
          var_00 notify("correct_tone_played");
          continue;
        }

        continue;
      }

      level notify("incorrect_tone_played");
      var_06 = 0;
      if(var_05 == 4) {
        wait(1);
        var_00 notify("incorrect_tone_played");
        setalltonestructstostate("idle - on");
        level thread play_fail_sound();
        scripts\cp\maps\cp_zmb\cp_zmb_dj::deactivateallmiddleplacementstructs();
        wait(5);
        break;
      }
    }
  }

  scripts\engine\utility::flag_set("tones_played_successfully");
}

setalltonestructstoneutralstate() {
  foreach(var_01 in level.alldjcenterstructs) {
    if(isDefined(var_01.tone)) {
      var_02 = strtok(var_01.tone, "_");
      var_03 = getstructstate(var_02[3], "neutral");
      var_01.model setscriptablepartstate("tone", var_03);
    }
  }
}

destroyalltonestructs() {
  foreach(var_01 in level.alldjcenterstructs) {
    if(isDefined(var_01.model)) {
      var_01.model setscriptablepartstate("tone", "explode");
    }
  }

  wait(0.1);
  foreach(var_01 in level.alldjcenterstructs) {
    var_01.model delete();
    var_01.disabled = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_01);
  }
}

setalltonestructstostate(param_00) {
  foreach(var_02 in level.alldjcenterstructs) {
    if(isDefined(var_02.model)) {
      var_02.model setscriptablepartstate("tone", param_00);
    }
  }
}

turn_off_exit_portal_fx() {
  if(isDefined(level.exit_portal_fx)) {
    level.exit_portal_fx delete();
  }
}

settonestructtostate(param_00, param_01) {
  param_00.model setscriptablepartstate("tone", param_01);
}

playtonesequence() {
  var_00 = level.ufo;
  var_00.timeout = 15;
  level.zombies_paused = 1;
  set_ufo_model_with_thrusters(var_00, "zmb_spaceland_ufo_off", 1);
  setalltonestructstostate("neutral");
  playsequence(var_00.tone_array, 1);
  setalltonestructstostate("idle - on");
  scripts\engine\utility::flag_set("ufo_listening");
  var_00 thread waitfortimeouttomove(var_00);
  set_ufo_model_with_thrusters(var_00, "zmb_spaceland_ufo", 1);
  playFXOnTag(level._effect["ufo_light_white"], var_00, "tag_origin");
  for(;;) {
    var_01 = var_00 scripts\engine\utility::waittill_any_return("completed_tone_match", "incorrect_tone_played", "ufo_timed_out", "correct_tone_played", "played_tones_too_slowly");
    if(var_01 == "completed_tone_match") {
      scripts\engine\utility::flag_set("force_drop_max_ammo");
      thread flashufolights(1);
      break;
    } else {
      if(var_01 == "correct_tone_played") {
        var_00.timeout = min(15, var_00.timeout + 4);
        continue;
      }

      if(var_01 == "incorrect_tone_played") {
        scripts\engine\utility::flag_set("force_spawn_boss");
        break;
      } else {
        if(var_01 == "played_tones_too_slowly") {
          scripts\engine\utility::flag_set("force_spawn_boss");
          continue;
        }

        if(var_01 == "ufo_timed_out") {
          break;
        }
      }
    }
  }

  stopFXOnTag(level._effect["ufo_light_white"], var_00, "tag_origin");
  level.zombies_paused = 0;
  setalltonestructstoneutralstate();
  scripts\engine\utility::flag_clear("ufo_listening");
}

waitfortimeouttomove(param_00) {
  param_00 endon("completed_tone_match");
  while(param_00.timeout >= 1) {
    wait(1);
    param_00.timeout = param_00.timeout - 1;
  }

  param_00 notify("ufo_timed_out");
}

getstructstate(param_00, param_01) {
  var_02 = 0;
  foreach(var_04 in level.ufotones) {
    var_05 = strtok(var_04, "_");
    if(param_00 == var_05[3]) {
      break;
    }
  }

  switch (var_02) {
    case 0:
      return param_01 + " - red";

    case 1:
      return param_01 + " - green";

    case 2:
      return param_01 + " - blue";

    case 3:
      return param_01 + " - yellow";

    default:
      return "neutral";
  }
}

flashufolights(param_00) {
  var_01 = level.ufo;
  for(var_02 = 0; var_02 < 5; var_02++) {
    set_ufo_model_with_thrusters(var_01, "zmb_spaceland_ufo_off", param_00);
    wait(0.5);
    set_ufo_model_with_thrusters(var_01, "zmb_spaceland_ufo", param_00);
    wait(0.5);
  }

  for(var_02 = 0; var_02 < 4; var_02++) {
    set_ufo_model_with_thrusters(var_01, "zmb_spaceland_ufo_blue", param_00);
    wait(0.25);
    set_ufo_model_with_thrusters(var_01, "zmb_spaceland_ufo_green", param_00);
    wait(0.25);
    set_ufo_model_with_thrusters(var_01, "zmb_spaceland_ufo_yellow", param_00);
    wait(0.25);
    set_ufo_model_with_thrusters(var_01, "zmb_spaceland_ufo_red", param_00);
    wait(0.25);
    set_ufo_model_with_thrusters(var_01, "zmb_spaceland_ufo", param_00);
    wait(0.25);
  }

  set_ufo_model_with_thrusters(var_01, "zmb_spaceland_ufo", param_00);
}

playsequence(param_00, param_01) {
  var_02 = level.ufo;
  playsoundatpos(var_02.origin, "UFO_tone_playback_" + param_00[0]);
  var_03 = getufolightcolor(param_00[0]);
  set_ufo_model_with_thrusters(var_02, var_03, param_01);
  thread shakeplayershud();
  wait(3.5);
  playsoundatpos(var_02.origin, "UFO_tone_playback_" + param_00[1]);
  var_03 = getufolightcolor(param_00[1]);
  set_ufo_model_with_thrusters(var_02, var_03, param_01);
  thread shakeplayershud();
  wait(3.5);
  playsoundatpos(var_02.origin, "UFO_tone_playback_" + param_00[2]);
  var_03 = getufolightcolor(param_00[2]);
  set_ufo_model_with_thrusters(var_02, var_03, param_01);
  thread shakeplayershud();
  wait(3.5);
  playsoundatpos(var_02.origin, "UFO_tone_playback_" + param_00[3]);
  var_03 = getufolightcolor(param_00[3]);
  set_ufo_model_with_thrusters(var_02, var_03, param_01);
  thread shakeplayershud();
  wait(3.5);
  set_ufo_model_with_thrusters(var_02, "zmb_spaceland_ufo", param_01);
}

set_ufo_model_with_thrusters(param_00, param_01, param_02) {
  param_00 setModel(param_01);
  if(scripts\engine\utility::istrue(param_02)) {
    param_00 thread delay_turn_on_thrusters(param_00);
  }
}

delay_turn_on_thrusters(param_00) {
  param_00 notify("ufo_delay_turn_on_thrusters");
  param_00 endon("death");
  param_00 endon("ufo_delay_turn_on_thrusters");
  wait(0.1);
  param_00 setscriptablepartstate("thrusters", "on");
}

getufolightcolor(param_00) {
  var_01 = 0;
  foreach(var_03 in level.ufotones) {
    var_04 = strtok(var_03, "_");
    if(param_00 == var_04[3]) {
      break;
    }
  }

  switch (var_01) {
    case 0:
      return "zmb_spaceland_ufo_red";

    case 1:
      return "zmb_spaceland_ufo_green";

    case 2:
      return "zmb_spaceland_ufo_blue";

    case 3:
      return "zmb_spaceland_ufo_yellow";

    default:
      return undefined;
  }
}

shakeplayershud() {
  foreach(var_01 in level.players) {
    if(!isalive(var_01)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_01.is_off_grid)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_01.in_afterlife_arcade)) {
      continue;
    }

    var_01 setclientomnvar("ui_hud_shake", 1);
    var_01 playrumbleonentity("artillery_rumble");
  }
}

setplaybacktimer() {
  self notify("stop_playback_timer");
  self endon("stop_playback_timer");
  var_00 = scripts\engine\utility::ter_op(level.players.size == 1, 4, 2.5);
  wait(var_00);
  level notify("tone_played");
}

play_fx_with_delay(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_03) && isDefined(param_04)) {
    var_05 = spawnfx(level._effect[param_01], param_02, param_03, param_04);
  } else {
    var_05 = spawnfx(level._effect[param_02], param_03);
  }

  wait(param_00);
  triggerfx(var_05);
  return var_05;
}

keep_rotate(param_00) {
  param_00 endon("death");
  param_00 endon("ufo_started_moving");
  var_01 = 0.4;
  for(;;) {
    var_02 = param_00.angles[0];
    param_00 rotateyaw(var_02 + 120, var_01);
    wait(var_01);
  }
}

ufo_earthquake() {
  self endon("stop_quake");
  self endon("death");
  for(;;) {
    earthquake(randomfloatrange(0.05, 0.15), 3, self.origin + (0, 0, -100), 1500);
    wait(2);
  }
}

delayed_move_mode(param_00) {
  param_00 endon("death");
  wait(1);
  param_00.health = 150;
  param_00.synctransients = "sprint";
  param_00.moveratescale = 0.8;
  param_00.traverseratescale = 0.8;
  param_00.generalspeedratescale = 0.8;
}

death_track(param_00) {
  self waittill("death");
  level.num_ufo_zombies_killed++;
}

make_grey_spawn_struct(param_00) {
  var_01 = spawnStruct();
  var_01.origin = param_00;
  var_01.angles = (0, 90, 0);
  var_01.is_coaster_spawner = 1;
  return var_01;
}

make_suicide_bomber_spawn_struct() {
  var_00 = [(647, 621, 80), (-40, 658, 1), (1286, 658, 1)];
  var_01 = spawnStruct();
  var_01.origin = scripts\engine\utility::random(var_00);
  var_01.angles = (0, 90, 0);
  var_01.is_coaster_spawner = 1;
  return var_01;
}

start_grey_sequence() {
  level endon("game_ended");
  scripts\cp\zombies\zombie_analytics::log_grey_sequence_activated(level.wave_num);
  wait(3);
  play_start_grey_sequence_vo();
  var_00 = 0.3;
  var_01 = 0.7;
  var_02 = [(642, 710, 67), (996, 657, 11), (642, 325, 11), (303, 651, 11)];
  for(var_03 = 0; var_03 < level.players.size; var_03++) {
    var_04 = make_grey_spawn_struct(var_02[var_03]);
    scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(1);
    for(;;) {
      var_05 = scripts\mp\mp_agent::spawnnewagent("zombie_grey", "axis", var_04.origin, var_04.angles, "iw7_zapper_grey");
      if(isDefined(var_05)) {
        if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
          var_05 scripts\mp\mp_agent::set_agent_health(int(700000));
        }

        var_05 thread intro_anim_timer(var_05);
        var_05 get_info_for_all_players(var_05);
        var_05.favorite_target_player = level.players[var_03];
        var_05.dont_scriptkill = 1;
        scripts\asm\zombie_grey\zombie_grey_asm::set_up_grey(var_05);
        break;
      }

      scripts\asm\zombie_grey\zombie_grey_asm::try_kill_off_zombies(1);
      scripts\engine\utility::waitframe();
    }

    scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
    wait(randomfloatrange(var_00, var_01));
  }
}

get_info_for_all_players(param_00) {
  foreach(var_02 in level.players) {
    param_00 getenemyinfo(var_02);
  }
}

intro_anim_timer(param_00) {
  var_01 = 7;
  param_00 endon("death");
  var_02 = param_00 scripts\cp\utility::waittill_any_ents_or_timeout_return(var_01, param_00, "damage");
  param_00.should_stop_intro_anim = 1;
  scripts\aitypes\zombie_grey\behaviors::set_next_teleport_attack_time(param_00);
  scripts\aitypes\zombie_grey\behaviors::set_can_do_teleport_attack(param_00, 1);
}

play_start_grey_sequence_vo() {
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_alien_spawn", "zmb_ww_vo", "highest", 60, 1, 0, 1);
  foreach(var_01 in level.players) {
    var_01 thread scripts\cp\cp_vo::try_to_play_vo("alien_first", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
  }
}

grey_on_killed_func(param_00, param_01, param_02, param_03, param_04) {
  level.spawned_enemies = scripts\engine\utility::array_remove(level.spawned_enemies, param_00);
  level.spawned_grey = scripts\engine\utility::array_remove(level.spawned_grey, param_00);
  if(level.spawned_grey.size == 0) {
    if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
      level thread grey_killed_vo(param_01);
      scripts\cp\cp_weaponrank::try_give_weapon_xp_zombie_killed(param_01, param_02, param_03, param_04, param_00.agent_type);
    }

    level notify("stop_ufo_zombie_spawn");
    level notify("complete_alien_grey_fight");
  }
}

grey_killed_vo(param_00) {
  level endon("game_ended");
  if(isDefined(param_00)) {
    param_00 thread scripts\cp\cp_vo::try_to_play_vo("alien_defeat", "zmb_comment_vo", "highest", 10, 0, 0, 1);
  }

  wait(4);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_alien_death", "zmb_ww_vo", "highest", 60, 0, 0, 1);
}

ufo_damage_monitor(param_00) {
  param_00 endon("death");
  param_00.maxhealth = 999999999;
  param_00.health = 999999999;
  param_00.fake_health = 3000;
  param_00 setCanDamage(1);
  for(;;) {
    param_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(isDefined(var_0A)) {
      if(weapon_can_damage_ufo(var_0A)) {
        break;
      } else if(isDefined(var_02) && isplayer(var_02)) {
        var_0B = gettime();
        if(!isDefined(var_02.previous_weapon_too_weak_for_ufo_time) || var_0B - var_02.previous_weapon_too_weak_for_ufo_time / 1000 > 3) {
          var_02 scripts\cp\cp_vo::try_to_play_vo("nag_ufo_shoot", "zmb_comment_vo", "high", 100, 0, 0, 1, 100);
          var_02.previous_weapon_too_weak_for_ufo_time = var_0B;
        }
      }
    }
  }

  param_00 moveto((-554, -1488, 2280), 3, 1.5);
  param_00 playsoundonmovingent("zmb_ufo_explo");
  playFXOnTag(level._effect["ufo_small_explosion"], param_00, "TAG_ORIGIN");
  wait(3);
  param_00 stoploopsound();
  level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_ufo_shoot");
  scripts\cp\zombies\zombie_analytics::log_ufo_destroyed(level.wave_num);
  level thread pausespawningfortime();
  level thread destroy_ufo_vo();
  if(isDefined(param_00.turrets)) {
    foreach(var_0D in param_00.turrets) {
      var_0D delete();
    }
  }

  playFX(level._effect["ufo_explosion"], param_00.origin);
  scripts\engine\utility::flag_set("ufo_destroyed");
  param_00 delete();
}

pausespawningfortime() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("pause_spawn_after_UFO_destroyed");
  scripts\engine\utility::flag_set("pause_spawn_after_UFO_destroyed");
  level.zombies_paused = 1;
  scripts\engine\utility::flag_set("pause_wave_progression");
  var_00 = spawn("script_model", level.players[0].origin);
  var_00 setModel("tag_origin");
  var_00.team = "allies";
  level.forced_nuke = 1;
  scripts\cp\loot::process_loot_content(level.players[0], "kill_50", var_00, 0);
  wait(20);
  level.zombies_paused = 0;
  scripts\engine\utility::flag_clear("pause_wave_progression");
  scripts\engine\utility::flag_clear("pause_spawn_after_UFO_destroyed");
}

destroy_ufo_vo() {
  scripts\cp\cp_vo::try_to_play_vo_on_all_players("ufo_destroy");
  wait(5);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_ufo_spawn_cut", "zmb_announcer_vo", "highest", 60, 0, 0, 1);
}

weapon_can_damage_ufo(param_00) {
  if(param_00 == "iw7_spaceland_wmd") {
    return 1;
  }

  return 0;
}

attach_alien_fuse(param_00) {
  param_00.available_fuse = [];
  param_00.available_fuse[param_00.available_fuse.size] = create_alien_fuse(param_00, "tag_back_le");
  param_00.available_fuse[param_00.available_fuse.size] = create_alien_fuse(param_00, "tag_back_ri");
}

create_alien_fuse(param_00, param_01) {
  var_02 = (0, 0, 0);
  var_03 = spawn("script_model", param_00 gettagorigin(param_01));
  var_03 setModel("park_alien_gray_fuse");
  var_03.angles = param_00 gettagangles(param_01);
  var_03 linkto(param_00, param_01, (0, 0, 0), var_02);
  var_03.triggerportableradarping = param_00;
  var_03.tag_name = param_01;
  return var_03;
}

remove_alien_fuse(param_00, param_01) {
  param_01.triggerportableradarping.available_fuse = scripts\engine\utility::array_remove(param_01.triggerportableradarping.available_fuse, param_01);
  if(isDefined(param_01)) {
    param_01 delete();
  }
}

drop_alien_fuses() {
  var_00 = spawn("script_model", (657, 765, 105));
  var_00 setModel("park_alien_gray_fuse");
  var_00.angles = (randomintrange(0, 360), randomintrange(0, 360), randomintrange(0, 360));
  var_01 = spawn("script_model", (641, 765, 105));
  var_01 setModel("park_alien_gray_fuse");
  var_01.angles = (randomintrange(0, 360), randomintrange(0, 360), randomintrange(0, 360));
  var_01 thread delay_spawn_glow_vfx_on(var_01, "souvenir_glow");
  var_01 thread item_keep_rotating(var_01);
  var_00 thread delay_spawn_glow_vfx_on(var_00, "souvenir_glow");
  var_00 thread item_keep_rotating(var_00);
  var_00 thread fuse_pick_up_monitor(var_00, var_01);
}

delay_spawn_glow_vfx_on(param_00, param_01) {
  param_00 endon("death");
  wait(0.3);
  playFXOnTag(level._effect[param_01], param_00, "tag_origin");
}

item_keep_rotating(param_00) {
  param_00 endon("death");
  var_01 = param_00.angles;
  for(;;) {
    param_00 rotateto(var_01 + (randomintrange(-40, 40), randomintrange(-40, 90), randomintrange(-40, 90)), 3);
    wait(3);
  }
}

fuse_pick_up_monitor(param_00, param_01) {
  param_00 endon("death");
  param_00 makeusable();
  param_00 sethintstring(&"CP_ZMB_UFO_PICK_UP_FUSE");
  foreach(var_03 in level.players) {
    var_03 thread scripts\cp\cp_vo::add_to_nag_vo("nag_ufo_fusefail", "zmb_comment_vo", 60, 15, 6, 1);
  }

  for(;;) {
    param_00 waittill("trigger", var_03);
    if(isplayer(var_03)) {
      var_03 playlocalsound("part_pickup");
      var_03 thread scripts\cp\cp_vo::try_to_play_vo("quest_ufo_collect_alienfuse_2", "zmb_comment_vo", "highest", 10, 0, 0, 1, 100);
      break;
    }
  }

  level.num_fuse_in_possession++;
  scripts\cp\cp_interaction::add_to_current_interaction_list(scripts\engine\utility::getstruct("pap_upgrade", "script_noteworthy"));
  scripts\cp\cp_interaction::remove_from_current_interaction_list(scripts\engine\utility::getstruct("weapon_upgrade", "script_noteworthy"));
  level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_ufo_fusefail");
  foreach(var_03 in level.players) {
    var_03 setclientomnvar("zm_special_item", 1);
  }

  param_01 delete();
  param_00 delete();
}

drop_soul_key() {
  var_00 = spawn("script_model", (646, 774, 105));
  var_00 setModel("zmb_soul_key_base");
  var_01 = spawnfx(level._effect["soul_key_glow"], var_00.origin);
  triggerfx(var_01);
  var_00 thread item_keep_rotating(var_00);
  var_00 thread soul_key_pick_up_monitor(var_00, var_01);
}

soul_key_pick_up_monitor(param_00, param_01) {
  param_00 endon("death");
  var_02 = 137;
  param_00 makeusable();
  param_00 sethintstring(&"CP_ZMB_UFO_PICK_UP_SOUL_KEY");
  for(;;) {
    param_00 waittill("trigger", var_03);
    if(isplayer(var_03)) {
      var_03 playlocalsound("part_pickup");
      scripts\cp\zombies\directors_cut::give_dc_player_extra_xp_for_carrying_newb();
      foreach(var_03 in level.players) {
        check_willard_pick_up_soul_key(var_03);
        var_03 setplayerdata("cp", "haveSoulKeys", "any_soul_key", 1);
        var_03 setplayerdata("cp", "haveSoulKeys", "soul_key_1", 1);
        var_03 scripts\cp\zombies\achievement::update_achievement("SOUL_KEY", 1);
      }

      if(any_player_is_willard()) {
        stop_spawn_wave();
        clear_existing_enemies();
        stop_gameplay_audio();
        scripts\cp\utility::play_bink_video("sysload_o4", var_02);
        wait(var_02);
        resume_spawn_wave();
        resume_gameplay_audio();
      }

      level thread scripts\cp\cp_vo::try_to_play_vo("dj_quest_ufo_soulkey_achieve", "zmb_dj_vo", "high", 20, 0, 0, 1);
      level thread soulkey_quest_vo(var_03);
      break;
    }
  }

  level thread scripts\cp\zombies\directors_cut::try_drop_talisman(param_00.origin, vectortoangles((0, 1, 0)));
  param_01 delete();
  param_00 delete();
}

stop_gameplay_audio() {
  scripts\cp\cp_vo::set_vo_system_busy(1);
  level.disable_broadcast = 1;
  scripts\engine\utility::flag_set("jukebox_paused");
  level notify("skip_song");
  foreach(var_01 in level.players) {
    scripts\cp\maps\cp_zmb\cp_zmb_vo::clear_up_all_vo(var_01);
    var_01 _meth_82C0("bink_fadeout_amb", 0.66);
  }
}

resume_gameplay_audio() {
  scripts\cp\cp_vo::set_vo_system_busy(0);
  level.disable_broadcast = undefined;
  scripts\engine\utility::flag_clear("jukebox_paused");
  foreach(var_01 in level.players) {
    var_01 clearclienttriggeraudiozone(0);
  }
}

clear_existing_enemies() {
  foreach(var_01 in level.spawned_enemies) {
    var_01.died_poorly = 1;
    var_01.nocorpse = 1;
    var_01 suicide();
  }

  scripts\engine\utility::waitframe();
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

any_player_is_willard() {
  foreach(var_01 in level.players) {
    if(isDefined(var_01.vo_prefix) && var_01.vo_prefix == "p6_") {
      return 1;
    }
  }

  return 0;
}

check_willard_pick_up_soul_key(param_00) {
  if(isDefined(param_00.vo_prefix) && param_00.vo_prefix == "p6_") {
    param_00 scripts\cp\cp_merits::processmerit("mt_dlc4_troll");
  }
}

soulkey_quest_vo(param_00) {
  param_00 thread scripts\cp\cp_vo::try_to_play_vo("quest_ufo_collect_soulkey", "zmb_comment_vo", "highest", 10, 0, 3, 1, 100);
  level thread scripts\cp\cp_vo::try_to_play_vo("collect_soulkey_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
  param_00 thread scripts\cp\cp_vo::add_to_nag_vo("nag_return_arcanecore", "zmb_comment_vo", 60, 120, 6, 1);
}

pap_upgrade_hintstring(param_00, param_01) {
  if(isDefined(level.num_fuse_in_possession) && level.num_fuse_in_possession > 0) {
    return &"CP_ZMB_INTERACTIONS_PAP_UPGRADE";
  }

  return "";
}

upgrade_pap(param_00, param_01) {
  level.num_fuse_in_possession--;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  insert_alien_fuses();
  scripts\engine\utility::flag_set("fuses_inserted");
  level.pap_max = int(min(level.pap_max + 1, 3));
  foreach(param_01 in level.players) {
    param_01 setclientomnvar("zm_special_item", 0);
  }

  wait(3);
  scripts\cp\cp_interaction::add_to_current_interaction_list(scripts\engine\utility::getstruct("weapon_upgrade", "script_noteworthy"));
}

insert_alien_fuses() {
  var_00 = getent("pap_machine", "targetname");
  var_00 setscriptablepartstate("door", "close");
  wait(0.5);
  var_00 setscriptablepartstate("machine", "upgraded");
  wait(0.25);
  var_00 setscriptablepartstate("reels", "neutral");
  wait(0.25);
  var_00 setscriptablepartstate("reels", "on");
  wait(0.25);
  var_00 setscriptablepartstate("door", "open_idle");
}

init_pap_upgrade() {
  var_00 = scripts\engine\utility::getstructarray("pap_upgrade", "script_noteworthy");
  foreach(var_02 in var_00) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_02);
  }
}

can_use_pap_upgrade(param_00, param_01) {
  if(isDefined(level.num_fuse_in_possession) && level.num_fuse_in_possession > 0) {
    return 1;
  }

  return 0;
}

activate_ufo_turret(param_00) {
  var_01 = [];
  var_02 = setup_ufo_turret(param_00 gettagorigin("tag_origin"));
  var_02 linkto(param_00, "tag_origin", (0, 0, -100), (180, 0, 0));
  var_01[var_01.size] = var_02;
  param_00.turrets = var_01;
}

setup_ufo_turret(param_00) {
  var_01 = spawnturret("misc_turret", param_00, "ufo_turret_gun_zombie");
  var_01 setModel("weapon_ceiling_sentry_temp");
  var_01 getvalidattachments();
  var_01 makeunusable();
  var_01.team = "axis";
  var_01 setturretteam("axis");
  var_01 give_player_session_tokens("sentry");
  var_01 setsentryowner(undefined);
  var_01 setleftarc(360);
  var_01 setrightarc(360);
  var_01 give_crafted_gascan(360);
  var_01 settoparc(360);
  var_01 laseron();
  var_01 thread ufo_turret_fire_monitor(var_01);
  return var_01;
}

ufo_turret_fire_monitor(param_00) {
  param_00 endon("death");
  level endon("game_ended");
  for(;;) {
    wait(3);
    var_01 = get_ufo_turret_target();
    if(isDefined(var_01)) {
      param_00 settargetentity(var_01);
      var_02 = scripts\engine\utility::waittill_any_timeout_1(2, "turret_on_target");
      if(var_02 == "turret_on_target") {
        var_03 = randomintrange(30, 45);
        for(var_04 = 0; var_04 < var_03; var_04++) {
          if(!can_be_attacked_by_ufo_turret(var_01)) {
            break;
          }

          param_00 shootturret();
          wait(0.1);
        }
      }
    }

    param_00 cleartargetentity();
  }
}

get_ufo_turret_target() {
  var_00 = [];
  foreach(var_02 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_02)) {
      continue;
    }

    var_00[var_00.size] = var_02;
  }

  return scripts\engine\utility::random(var_00);
}

can_be_attacked_by_ufo_turret(param_00) {
  if(!isplayer(param_00)) {
    return 0;
  }

  if(scripts\cp\cp_laststand::player_in_laststand(param_00)) {
    return 0;
  }

  return 1;
}

start_ufo_zombie_spawn_sequence() {
  var_00 = level.ufo;
  level endon("game_ended");
  level endon("stop_ufo_zombie_spawn");
  var_00 endon("death");
  if(!scripts\engine\utility::flag("ufo_intro_reach_center_portal")) {
    scripts\engine\utility::flag_wait("ufo_intro_reach_center_portal");
  }

  level thread max_ufo_zombie_spawn_number_logic();
  for(;;) {
    var_01 = get_num_of_nodes_to_travel_before_spawn_zombie();
    for(var_02 = 0; var_02 < var_01; var_02++) {
      var_03 = get_beam_down_ground_location();
      var_04 = (var_03.origin[0], var_03.origin[1], (647, 621, 901)[2]);
      ufo_fly_to_pos(var_04);
    }

    var_05 = get_num_ufo_zombies();
    if(var_05 > 0) {
      level thread ufo_beam_down_zombies(var_05);
      level waittill("beam_down_zombie_complete");
    }
  }
}

get_num_of_nodes_to_travel_before_spawn_zombie() {
  return 1;
}

max_ufo_zombie_spawn_number_logic() {
  level endon("game_ended");
  level endon("stop_ufo_zombie_spawn");
  var_00 = 24;
  level.max_ufo_zombie_spawn_number = 1;
  for(var_01 = 0; var_01 < var_00; var_01++) {
    var_02 = get_update_max_spawn_frequency();
    wait(var_02);
    level.max_ufo_zombie_spawn_number++;
  }
}

get_update_max_spawn_frequency() {
  return 40;
}

get_num_ufo_zombies() {
  var_00 = 24 - level.spawned_enemies.size - 3;
  var_01 = min(var_00, level.max_ufo_zombie_spawn_number);
  return var_01;
}

ufo_beam_down_zombies(param_00) {
  var_01 = activate_ufo_beam("ufo_zombie_spawn_beam");
  spawn_and_beam_down_zombies(param_00);
  deactivate_ufo_beam(var_01, "ufo_zombie_spawn_beam");
  level notify("beam_down_zombie_complete");
}

ufo_fly_to_pos(param_00) {
  var_01 = distance(level.ufo.origin, param_00);
  var_02 = var_01 / 150;
  level.ufo moveto(param_00, var_02);
  level.ufo waittill("movedone");
}

activate_ufo_beam(param_00) {
  var_01 = level.ufo;
  var_02 = spawn("script_model", var_01.origin);
  var_02 setModel("tag_origin");
  var_02.angles = vectortoangles((0, 0, 1));
  wait(0.2);
  playFXOnTag(level._effect[param_00], var_02, "tag_origin");
  return var_02;
}

deactivate_ufo_beam(param_00, param_01) {
  killfxontag(level._effect[param_01], param_00, "tag_origin");
  param_00 delete();
}

spawn_and_beam_down_zombies(param_00) {
  var_01 = level.ufo;
  level endon("stop_ufo_zombie_spawn");
  var_01 endon("death");
  wait(1);
  var_02 = get_ufo_zombie_spawn_locations(param_00);
  for(var_03 = 0; var_03 < param_00; var_03++) {
    level thread spawn_and_beam_down_zombie(var_02[var_03]);
    if(var_03 == param_00 - 1) {
      break;
    }

    wait(1);
  }

  wait(2);
}

get_ufo_zombie_spawn_locations(param_00) {
  var_01 = [];
  var_02 = level.ufo;
  var_03 = var_02.angles;
  var_04 = 360 / param_00;
  for(var_05 = 0; var_05 < param_00; var_05++) {
    var_06 = (var_03[0], var_03[1] + var_04 * var_05, var_03[2]);
    var_07 = var_02.origin + anglesToForward(var_06) * 30;
    var_01[var_01.size] = var_07;
  }

  return var_01;
}

spawn_and_beam_down_zombie(param_00) {
  var_01 = (0, 0, -50);
  var_02 = (0, 0, -4000);
  var_03 = scripts\mp\mp_agent::spawnnewagent("generic_zombie", "axis", param_00, level.ufo.angles, undefined);
  if(isDefined(var_03)) {
    var_03.entered_playspace = 1;
    var_03 ghostskulls_total_waves(var_03.defaultgoalradius);
    var_03.maxhealth = scripts\cp\zombies\zombies_spawning::calculatezombiehealth("generic_zombie");
    var_03.health = var_03.maxhealth;
    var_03 thread ufo_zombie_death_monitor(var_03);
    level.spawned_enemies[level.spawned_enemies.size] = var_03;
    var_04 = spawn("script_model", var_03.origin);
    var_04 setModel("tag_origin");
    var_03 linkto(var_04, "tag_origin");
    var_05 = bulletTrace(param_00 + var_01, param_00 + var_02, 0, level.ufo)["position"];
    var_04 moveto(var_05, 1.5, 0, 0.75);
    var_04 waittill("movedone");
    var_03 unlink();
    var_04 delete();
  }
}

ufo_zombie_death_monitor(param_00) {
  param_00 waittill("death");
  level.spawned_enemies = scripts\engine\utility::array_remove(level.spawned_enemies, param_00);
}

get_beam_down_ground_location() {
  var_00 = level.ufo;
  var_01 = [];
  var_02 = scripts\engine\utility::getstructarray("ufo_zombie_spawn_loc", "targetname");
  foreach(var_04 in var_02) {
    if(distance2dsquared(var_00.origin, var_04.origin) < 250000) {
      continue;
    }

    if(distance2dsquared(var_00.origin, var_04.origin) > 1000000) {
      continue;
    }

    var_01[var_01.size] = var_04;
  }

  return scripts\engine\utility::random(var_01);
}

ufo_pre_grey_regen_func(param_00) {
  var_01 = level.ufo;
  level notify("stop_ufo_zombie_spawn");
  var_02 = (param_00.origin[0], param_00.origin[1], var_01.origin[2]);
  var_01 dontinterpolate();
  var_01.origin = var_02;
}

ufo_post_grey_regen_func() {}

move_grey_fight_clip_down() {
  level endon("game_ended");
  var_00 = getent("grey_fight_clip", "targetname");
  if(isDefined(var_00)) {
    var_01 = var_00.origin;
    var_02 = (var_01[0], var_01[1], var_01[2] - 1024);
    var_00 moveto(var_02, 0.05);
    var_00 waittill("movedone");
    var_00 disconnectpaths();
  }
}

clear_grey_fight_clips() {
  var_00 = getent("grey_fight_clip", "targetname");
  if(isDefined(var_00)) {
    var_00 connectpaths();
    var_00 delete();
  }
}

start_grey_fight_blocker_vfx() {
  level.grey_fight_vfx = [];
  level.grey_fight_sfx = [];
  var_00 = [(438, -1353, 125), (1379, 660, 85), (-137, 645, 100)];
  var_01 = [(0, 40, 0), (0, 180, 0), (0, 0, 0)];
  foreach(var_06, var_03 in var_00) {
    var_04 = scripts\engine\utility::play_loopsound_in_space("zmb_portal_area_lock_in", var_03);
    var_05 = spawnfx(level._effect["moving_target_portal"], var_03, anglesToForward(var_01[var_06]), anglestoup(var_01[var_06]));
    triggerfx(var_05);
    level.grey_fight_vfx[level.grey_fight_vfx.size] = var_05;
    level.grey_fight_sfx[level.grey_fight_sfx.size] = var_04;
  }
}

stop_grey_fight_blocker_vfx() {
  if(!isDefined(level.grey_fight_vfx)) {
    return;
  }

  foreach(var_01 in level.grey_fight_vfx) {
    var_01 delete();
  }
}

stop_grey_fight_blocker_sfx() {
  if(!isDefined(level.grey_fight_sfx)) {
    return;
  }

  foreach(var_01 in level.grey_fight_sfx) {
    var_01 stoploopsound();
    wait(0.1);
    var_01 delete();
  }
}

start_slow_projectile_sequence(param_00) {
  param_00 thread shoot_slow_projectiles(param_00);
  param_00 thread fly_around_main_street(param_00);
}

fly_around_main_street(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  if(!scripts\engine\utility::flag("ufo_intro_reach_center_portal")) {
    scripts\engine\utility::flag_wait("ufo_intro_reach_center_portal");
  }

  for(;;) {
    var_01 = get_beam_down_ground_location();
    var_02 = (var_01.origin[0], var_01.origin[1], (647, 621, 901)[2]);
    ufo_fly_to_pos(var_02);
  }
}

shoot_slow_projectiles(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  var_01 = 5;
  for(;;) {
    wait(randomfloatrange(10, 15));
    var_02 = get_slow_projectile_targets(level.ufo);
    if(var_02.size > 0) {
      var_03 = get_spread_out_points(level.ufo, var_01);
      foreach(var_05 in var_03) {
        level thread fire_slow_projectile_from(var_05, var_02[randomint(var_02.size)]);
      }
    }
  }
}

get_spread_out_points(param_00, param_01) {
  var_02 = 360 / param_01;
  var_03 = param_00.angles;
  var_04 = [];
  for(var_05 = 0; var_05 < param_01; var_05++) {
    var_06 = var_02 / 2 + var_05 * var_02;
    var_07 = (var_03[0], var_03[1] + var_06, var_03[2]);
    var_08 = anglesToForward(var_07);
    var_09 = param_00.origin + var_08 * 350 + (0, 0, -200);
    var_04[var_04.size] = var_09;
  }

  return var_04;
}

fire_slow_projectile_from(param_00, param_01) {
  var_02 = magicbullet("iw7_ufo_proj", param_00, param_00 + (0, 0, -100));
  wait(0.6);
  if(isDefined(var_02) && isDefined(param_01) && !scripts\cp\cp_laststand::player_in_laststand(param_01)) {
    var_02 missile_settargetent(param_01);
  }
}

get_slow_projectile_targets(param_00) {
  var_01 = [];
  foreach(var_03 in level.players) {
    if(!can_be_slow_projectile_target(var_03, param_00)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01;
}

can_be_slow_projectile_target(param_00, param_01) {
  if(scripts\cp\cp_laststand::player_in_laststand(param_00)) {
    return 0;
  }

  if(!bullettracepassed(param_01.origin, param_00 getEye(), 0, param_01)) {
    return 0;
  }

  return 1;
}

transform_wave_zombies_to_suicide_bombers() {
  level endon("game_ended");
  scripts\cp\zombies\zombie_analytics::log_suicide_bomber_sequence_activated(level.wave_num);
  foreach(var_01 in level.spawned_enemies) {
    if(isDefined(var_01.agent_type) && var_01.agent_type == "generic_zombie") {
      var_01 scripts\asm\zombie\zombie::turnintosuicidebomber(1);
      var_01 setavoidanceradius(4);
      wait(randomfloatrange(0.3, 0.7));
    }
  }
}

activate_spaceland_powernode() {
  level thread spaceland_powernode_damage_monitor();
}

spaceland_powernode_damage_monitor() {
  var_00 = getent("main_gate_powernode_damage_trigger", "targetname");
  var_00 setCanDamage(1);
  for(;;) {
    var_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    var_0B = get_power_node_struct(var_04);
    if(!isDefined(var_0B)) {
      if(randomint(100) > 85) {
        scripts\cp\cp_vo::try_to_play_vo_on_all_players("nag_ufo_signfail");
      }

      continue;
    }

    if(scripts\engine\utility::istrue(var_0B.is_activated)) {
      continue;
    }

    if(can_charge_power_nodes(var_0A, var_02)) {
      change_gate_light_color(var_0B);
      var_0B.is_activated = 1;
      var_0C = var_0B.origin;
      playsoundatpos(var_0C, "zmb_ufo_spaceland_sign_charge");
      level thread play_trigger_wmd_vo();
      if(should_play_arc_vfx(var_0B)) {
        var_0D = scripts\engine\utility::getstruct(var_0B.target, "targetname");
        var_0E = var_0D.origin;
        level thread play_arc_vfx_between_points("powernode_arc_small", var_0C, var_0E, "spaceland_arc_fired");
      }

      if(all_power_nodes_are_activated()) {
        level thread trigger_wmd();
      }
    }
  }
}

should_play_arc_vfx(param_00) {
  if(param_00.var_336 == "main_gate_powernode_5") {
    return 0;
  }

  return 1;
}

change_gate_light_color(param_00) {
  var_01 = get_nearby_gate_light_scriptable(param_00);
  var_01 setscriptablepartstate("main_gate_light", "charged");
}

get_nearby_gate_light_scriptable(param_00) {
  var_01 = 10000;
  for(var_02 = 1; var_02 <= 5; var_02++) {
    var_03 = getent("gate_light_0" + var_02, "targetname");
    if(distancesquared(param_00.origin, var_03.origin) < var_01) {
      return var_03;
    }
  }
}

can_charge_power_nodes(param_00, param_01) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_02 = getweaponbasename(param_00);
  switch (var_02) {
    case "iw7_headcutter_zm_pap1":
    case "iw7_headcutter_zm":
    case "iw7_facemelter_zm_pap1":
    case "iw7_facemelter_zm":
    case "iw7_dischord_zm_pap1":
    case "iw7_dischord_zm":
    case "iw7_shredder_zm_pap1":
    case "iw7_shredder_zm":
      if(param_01 scripts\cp\cp_weapon::get_weapon_level(param_00) == 2) {
        return 1;
      } else {
        return 0;
      }

      break;

    default:
      return 0;
  }
}

play_arc_vfx_between_points(param_00, param_01, param_02, param_03) {
  var_04 = spawnfx(scripts\engine\utility::getfx("ufo_elec_beam_impact"), param_01);
  var_05 = spawnfx(scripts\engine\utility::getfx("ufo_elec_beam_impact"), param_02);
  var_06 = scripts\engine\utility::play_loopsound_in_space("zmb_ufo_spaceland_sign_charge_lp", param_01);
  triggerfx(var_04);
  triggerfx(var_05);
  for(;;) {
    playfxbetweenpoints(scripts\engine\utility::getfx(param_00), param_01, vectortoangles(param_01 - param_02), param_02);
    var_07 = scripts\engine\utility::waittill_any_timeout_1(1, param_03);
    if(var_07 == param_03) {
      break;
    }
  }

  var_06 delete();
  var_04 delete();
  var_05 delete();
}

all_power_nodes_are_activated() {
  var_00 = ["main_gate_powernode_1", "main_gate_powernode_2", "main_gate_powernode_3", "main_gate_powernode_4", "main_gate_powernode_5"];
  foreach(var_02 in var_00) {
    var_03 = scripts\engine\utility::getstruct(var_02, "targetname");
    if(!scripts\engine\utility::istrue(var_03.is_activated)) {
      return 0;
    }
  }

  return 1;
}

trigger_wmd() {
  var_00 = (726, 1788, 154);
  var_01 = (608, 1793, 154);
  var_02 = (668, 1580, 154);
  var_03 = (669, 1237, 154);
  var_04 = (648, 611, 281);
  var_05 = (647, 632, 86);
  var_06 = (646, 694, 51);
  var_07 = scripts\engine\utility::getstruct("main_gate_powernode_1", "targetname");
  var_08 = scripts\engine\utility::getstruct("main_gate_powernode_2", "targetname");
  var_09 = scripts\engine\utility::getstruct("main_gate_powernode_3", "targetname");
  var_0A = scripts\engine\utility::getstruct("main_gate_powernode_4", "targetname");
  var_0B = scripts\engine\utility::getstruct("main_gate_powernode_5", "targetname");
  level thread play_arc_vfx_between_points("powernode_arc_medium", var_08.origin, var_00, "spaceland_arc_fired");
  level thread play_arc_vfx_between_points("powernode_arc_medium", var_0A.origin, var_01, "spaceland_arc_fired");
  level thread play_arc_vfx_between_points("powernode_arc_medium", var_09.origin, var_02, "spaceland_arc_fired");
  level thread play_arc_vfx_between_points("powernode_arc_medium", var_00, var_02, "spaceland_arc_fired");
  level thread play_arc_vfx_between_points("powernode_arc_medium", var_01, var_02, "spaceland_arc_fired");
  playsoundatpos(var_00, "zmb_ufo_spaceland_sign_build");
  wait(randomfloatrange(1.3, 1.7));
  level thread play_arc_vfx_between_points("powernode_arc_big", var_02, var_03, "spaceland_arc_fired");
  wait(randomfloatrange(1.3, 1.7));
  level thread play_arc_vfx_between_points("powernode_arc_big", var_03, var_05, "spaceland_arc_fired");
  var_07.is_activated = 0;
  var_08.is_activated = 0;
  var_09.is_activated = 0;
  var_0A.is_activated = 0;
  var_0B.is_activated = 0;
  scripts\engine\utility::exploder(90);
  wait(2);
  playsoundatpos(var_05, "zmb_ufo_spaceland_sign_wmd");
  level notify("spaceland_arc_fired");
  magicbullet("iw7_spaceland_wmd", var_04 + (0, 0, 50), var_04 + (0, 0, 2000));
  change_gate_light_scriptable_to_on_state();
}

change_gate_light_scriptable_to_on_state() {
  for(var_00 = 1; var_00 <= 5; var_00++) {
    var_01 = getent("gate_light_0" + var_00, "targetname");
    var_01 setscriptablepartstate("main_gate_light", "on");
  }
}

play_trigger_wmd_vo() {
  wait(0.1);
  foreach(var_01 in level.players) {
    var_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_ufo_signhit_5", "zmb_comment_vo", "highest", 10, 0, 0, 0, 50);
  }
}

get_power_node_struct(param_00) {
  var_01 = 10000;
  var_02 = ["main_gate_powernode_1", "main_gate_powernode_2", "main_gate_powernode_3", "main_gate_powernode_4", "main_gate_powernode_5"];
  foreach(var_04 in var_02) {
    var_05 = scripts\engine\utility::getstruct(var_04, "targetname");
    if(distancesquared(var_05.origin, param_00) < var_01) {
      return var_05;
    }
  }
}

play_ufo_start_vfx() {
  var_00 = (-1066.27, -2577.7, 2051.62);
  var_01 = (-2164.96, -2780.52, 1923.13);
  var_02 = (-1710.99, -2499.7, 1618.13);
  var_03 = 0.8;
  playsoundatpos((-1198, -2137, 1946), "zmb_ufo_break_free_ice");
  playFX(level._effect["vfx_ufo_snow"], var_00);
  playFX(level._effect["vfx_ufo_snow"], var_01);
  wait(var_03);
  playFX(level._effect["vfx_ufo_snow"], var_02);
}