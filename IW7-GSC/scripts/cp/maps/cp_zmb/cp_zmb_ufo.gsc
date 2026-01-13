/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_ufo.gsc
*************************************************/

init_ufo_quest() {
  level endon("game_ended");
  scripts\mp\agents\zombie_grey\zombie_grey_agent::registerscriptedagent();
  level thread power_on_monitor();
  var_0 = scripts\engine\utility::getstruct("ufo_initial_position", "targetname");
  init_ufo_vfx();
  init_ufo_anim();
  wait(3);
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("zmb_spaceland_ufo_off");
  level.ufo = var_1;
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
  var_0 = 0;
  for(;;) {
    level waittill("activate_power");
    var_0++;
    var_1 = get_ufo_model(var_0);
    level.ufo setModel(var_1);
    if(var_0 == 5) {
      break;
    }
  }
}

get_ufo_model(var_0) {
  switch (var_0) {
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
  var_0 = level.ufo;
  level thread transform_wave_zombies_to_suicide_bombers();
  var_0 moveto((647, 621, 901), 5);
  var_0 waittill("movedone");
  foreach(var_2 in level.fast_travel_spots) {
    var_2.disabled = undefined;
    scripts\cp\zombies\zombie_fast_travel::turn_on_exit_portal_fx(0);
  }

  level.beam_trap_vfx = play_fx_with_delay(1, "ufo_lazer_beam", var_0.origin);
  var_4 = 50;
  var_5 = 50;
  level.num_ufo_zombies_killed = 0;
  while(var_4 >= 0) {
    for(;;) {
      var_6 = make_suicide_bomber_spawn_struct();
      var_7 = var_6 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("generic_zombie", 1);
      if(isDefined(var_7)) {
        break;
      }

      wait(0.05);
    }

    var_4--;
    var_7.entered_playspace = 1;
    var_7.nocorpse = 1;
    var_7.health = 5000;
    var_7.is_suicide_bomber = 1;
    var_7.is_reserved = 1;
    var_7 setscriptablepartstate("eyes", "eye_glow_off");
    var_7 detachall();
    var_7 setModel("park_clown_zombie");
    var_7.should_play_transformation_anim = 0;
    var_7 thread delayed_move_mode(var_7);
    var_7 thread death_track(var_5);
    wait(randomfloatrange(0.05, 1));
  }

  while(level.num_ufo_zombies_killed < var_5) {
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
  foreach(var_1 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    var_1 thread scripts\cp\maps\cp_zmb\cp_zmb_dj::adjustmovespeed(var_1);
  }

  for(;;) {
    level waittill("agent_spawned", var_3);
    if(isDefined(var_3.agent_type) && var_3.agent_type == "zombie_brute") {
      continue;
    }

    var_3 thread scripts\cp\maps\cp_zmb\cp_zmb_dj::adjustmovespeed(var_3, 1);
  }
}

deactivateadjacentvolumes() {
  level endon("game_ended");
  var_0 = level.active_spawn_volumes;
  var_1 = getEntArray("placed_transponder", "script_noteworthy");
  foreach(var_3 in var_0) {
    if(var_3.basename == "moon" || var_3.basename == "front_gate") {
      continue;
    }

    var_3 scripts\cp\zombies\zombies_spawning::make_volume_inactive();
    foreach(var_5 in var_1) {
      if(ispointinvolume(var_5.origin, var_3)) {
        var_5 notify("detonateExplosive");
      }
    }
  }

  while(!scripts\engine\utility::flag("disable_portals")) {
    wait(0.05);
  }

  scripts\engine\utility::flag_waitopen("disable_portals");
  foreach(var_9 in var_0) {
    var_9 scripts\cp\zombies\zombies_spawning::make_volume_active();
  }
}

ufo_intro_fly_to_center_portal() {
  level thread play_ufo_start_vfx();
  var_0 = level.ufo;
  var_0.angles = vectortoangles((1, 0, 0));
  var_0 thread ufo_earthquake();
  var_0 thread ufo_damage_monitor(var_0);
  var_0 playLoopSound("ufo_movement_lp");
  var_0.origin = (647, 621, 901);
  var_0.angles = (0, 0, 0);
  var_0 scriptmodelplayanim("zmb_spaceland_ufo_breakaway", 1);
  var_0 setscriptablepartstate("thrusters", "on");
  wait(7);
  var_0 scriptmodelplayanim("zmb_spaceland_ufo_idle");
  scripts\engine\utility::flag_set("ufo_intro_reach_center_portal");
}

start_match_tone_sequence() {
  level endon("tones_played_successfully");
  var_0 = level.ufo;
  scripts\engine\utility::flag_wait("ufo_intro_reach_center_portal");
  setup_ufo_tone_array();
  var_0 play_match_tone_sequence();
}

setup_ufo_tone_array() {
  var_0 = level.ufo;
  var_1 = [];
  for(var_2 = 0; var_2 < 4; var_2++) {
    var_3 = strtok(level.ufotones[var_2], "_");
    var_1[var_1.size] = var_3[3];
  }

  var_0.tone_array = scripts\engine\utility::array_randomize_objects(var_1);
}

play_match_tone_sequence() {
  level endon("tone_sequence_completed");
  var_0 = 5;
  var_1 = level.ufo;
  var_1 thread listenjump();
  for(;;) {
    playtonesequence();
    var_2 = 0;
    for(var_3 = 0; var_3 < var_0; var_3++) {
      var_4 = get_beam_down_ground_location();
      var_5 = (var_4.origin[0], var_4.origin[1], var_1.origin[2]);
      var_6 = distance(var_1.origin, var_5);
      var_7 = var_6 / 150;
      var_1 playSound("ufo_movement_start");
      var_1 moveto(var_5, var_7);
      var_1 waittill("movedone");
    }

    var_6 = distance(var_1.origin, (647, 621, 901));
    var_7 = var_6 / 150;
    if(var_7 < 0.05) {
      var_7 = 0.05;
    }

    var_1 playSound("ufo_movement_start");
    var_1 moveto((647, 621, 901), var_7);
    var_1 waittill("movedone");
  }
}

disableportals() {
  scripts\engine\utility::flag_set("disable_portals");
  foreach(var_1 in level.fast_travel_spots) {
    var_1.disabled = 1;
    var_1 turn_off_exit_portal_fx();
    var_1 scripts\cp\zombies\zombie_fast_travel::portal_close_fx();
  }
}

enableportals() {
  scripts\engine\utility::flag_clear("disable_portals");
  foreach(var_1 in level.fast_travel_spots) {
    var_1.disabled = undefined;
  }
}

play_fail_sound() {
  level endon("game_ended");
  foreach(var_1 in level.players) {
    var_1 playlocalsound("dj_deny");
  }

  wait(2);
  foreach(var_1 in level.players) {
    var_1 playlocalsound("ww_magicbox_laughter");
  }
}

listenjump() {
  level endon("tones_played_successfully");
  var_0 = level.ufo;
  scripts\cp\maps\cp_zmb\cp_zmb_dj::activateallmiddleplacementstructs();
  var_1 = 1;
  var_2 = 0;
  var_3 = undefined;
  while(var_1) {
    var_4 = 0;
    var_5 = 0;
    var_6 = 1;
    for(;;) {
      scripts\cp\maps\cp_zmb\cp_zmb_dj::activateallmiddleplacementstructs();
      level waittill("tone_played", var_7, var_3);
      if(!scripts\engine\utility::flag("ufo_listening")) {
        break;
      }

      if(!isDefined(var_7)) {
        level notify("played_tones_too_slowly");
        var_0 notify("played_tones_too_slowly");
        setalltonestructstostate("idle - on");
        level thread play_fail_sound();
        scripts\cp\maps\cp_zmb\cp_zmb_dj::deactivateallmiddleplacementstructs();
        wait(2);
        break;
      }

      if(!isDefined(var_3)) {
        wait(2);
        break;
      }

      var_0 thread setplaybacktimer();
      var_8 = getstructstate(var_7, "active");
      settonestructtostate(var_3, var_8);
      var_5++;
      if(var_6 && var_7 == var_0.tone_array[var_4]) {
        var_4++;
        if(var_4 == 4) {
          var_2++;
          var_0 notify("completed_tone_match");
          scripts\engine\utility::flag_clear("force_spawn_boss");
          if(var_2 == 3) {
            var_1 = 0;
            wait(2);
            level notify("tone_sequence_completed");
            level thread scripts\cp\cp_vo::try_to_play_vo("ww_ufo_tonegen_complete", "zmb_ww_vo", "highest", 60, 1, 0, 1);
            break;
          } else {
            var_0.tone_array = scripts\engine\utility::array_randomize_objects(var_0.tone_array);
            scripts\cp\maps\cp_zmb\cp_zmb_dj::deactivateallmiddleplacementstructs();
            wait(4);
            break;
          }
        } else {
          level notify("correct_tone_played");
          var_0 notify("correct_tone_played");
          continue;
        }

        continue;
      }

      level notify("incorrect_tone_played");
      var_6 = 0;
      if(var_5 == 4) {
        wait(1);
        var_0 notify("incorrect_tone_played");
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
  foreach(var_1 in level.alldjcenterstructs) {
    if(isDefined(var_1.tone)) {
      var_2 = strtok(var_1.tone, "_");
      var_3 = getstructstate(var_2[3], "neutral");
      var_1.model setscriptablepartstate("tone", var_3);
    }
  }
}

destroyalltonestructs() {
  foreach(var_1 in level.alldjcenterstructs) {
    if(isDefined(var_1.model)) {
      var_1.model setscriptablepartstate("tone", "explode");
    }
  }

  wait(0.1);
  foreach(var_1 in level.alldjcenterstructs) {
    var_1.model delete();
    var_1.disabled = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
  }
}

setalltonestructstostate(var_0) {
  foreach(var_2 in level.alldjcenterstructs) {
    if(isDefined(var_2.model)) {
      var_2.model setscriptablepartstate("tone", var_0);
    }
  }
}

turn_off_exit_portal_fx() {
  if(isDefined(level.exit_portal_fx)) {
    level.exit_portal_fx delete();
  }
}

settonestructtostate(var_0, var_1) {
  var_0.model setscriptablepartstate("tone", var_1);
}

playtonesequence() {
  var_0 = level.ufo;
  var_0.timeout = 15;
  level.zombies_paused = 1;
  set_ufo_model_with_thrusters(var_0, "zmb_spaceland_ufo_off", 1);
  setalltonestructstostate("neutral");
  playsequence(var_0.tone_array, 1);
  setalltonestructstostate("idle - on");
  scripts\engine\utility::flag_set("ufo_listening");
  var_0 thread waitfortimeouttomove(var_0);
  set_ufo_model_with_thrusters(var_0, "zmb_spaceland_ufo", 1);
  playFXOnTag(level._effect["ufo_light_white"], var_0, "tag_origin");
  for(;;) {
    var_1 = var_0 scripts\engine\utility::waittill_any_return("completed_tone_match", "incorrect_tone_played", "ufo_timed_out", "correct_tone_played", "played_tones_too_slowly");
    if(var_1 == "completed_tone_match") {
      scripts\engine\utility::flag_set("force_drop_max_ammo");
      thread flashufolights(1);
      break;
    } else {
      if(var_1 == "correct_tone_played") {
        var_0.timeout = min(15, var_0.timeout + 4);
        continue;
      }

      if(var_1 == "incorrect_tone_played") {
        scripts\engine\utility::flag_set("force_spawn_boss");
        break;
      } else {
        if(var_1 == "played_tones_too_slowly") {
          scripts\engine\utility::flag_set("force_spawn_boss");
          continue;
        }

        if(var_1 == "ufo_timed_out") {
          break;
        }
      }
    }
  }

  stopFXOnTag(level._effect["ufo_light_white"], var_0, "tag_origin");
  level.zombies_paused = 0;
  setalltonestructstoneutralstate();
  scripts\engine\utility::flag_clear("ufo_listening");
}

waitfortimeouttomove(var_0) {
  var_0 endon("completed_tone_match");
  while(var_0.timeout >= 1) {
    wait(1);
    var_0.timeout = var_0.timeout - 1;
  }

  var_0 notify("ufo_timed_out");
}

getstructstate(var_0, var_1) {
  var_2 = 0;
  foreach(var_4 in level.ufotones) {
    var_5 = strtok(var_4, "_");
    if(var_0 == var_5[3]) {
      break;
    }
  }

  switch (var_2) {
    case 0:
      return var_1 + " - red";

    case 1:
      return var_1 + " - green";

    case 2:
      return var_1 + " - blue";

    case 3:
      return var_1 + " - yellow";

    default:
      return "neutral";
  }
}

flashufolights(var_0) {
  var_1 = level.ufo;
  for(var_2 = 0; var_2 < 5; var_2++) {
    set_ufo_model_with_thrusters(var_1, "zmb_spaceland_ufo_off", var_0);
    wait(0.5);
    set_ufo_model_with_thrusters(var_1, "zmb_spaceland_ufo", var_0);
    wait(0.5);
  }

  for(var_2 = 0; var_2 < 4; var_2++) {
    set_ufo_model_with_thrusters(var_1, "zmb_spaceland_ufo_blue", var_0);
    wait(0.25);
    set_ufo_model_with_thrusters(var_1, "zmb_spaceland_ufo_green", var_0);
    wait(0.25);
    set_ufo_model_with_thrusters(var_1, "zmb_spaceland_ufo_yellow", var_0);
    wait(0.25);
    set_ufo_model_with_thrusters(var_1, "zmb_spaceland_ufo_red", var_0);
    wait(0.25);
    set_ufo_model_with_thrusters(var_1, "zmb_spaceland_ufo", var_0);
    wait(0.25);
  }

  set_ufo_model_with_thrusters(var_1, "zmb_spaceland_ufo", var_0);
}

playsequence(var_0, var_1) {
  var_2 = level.ufo;
  playsoundatpos(var_2.origin, "UFO_tone_playback_" + var_0[0]);
  var_3 = getufolightcolor(var_0[0]);
  set_ufo_model_with_thrusters(var_2, var_3, var_1);
  thread shakeplayershud();
  wait(3.5);
  playsoundatpos(var_2.origin, "UFO_tone_playback_" + var_0[1]);
  var_3 = getufolightcolor(var_0[1]);
  set_ufo_model_with_thrusters(var_2, var_3, var_1);
  thread shakeplayershud();
  wait(3.5);
  playsoundatpos(var_2.origin, "UFO_tone_playback_" + var_0[2]);
  var_3 = getufolightcolor(var_0[2]);
  set_ufo_model_with_thrusters(var_2, var_3, var_1);
  thread shakeplayershud();
  wait(3.5);
  playsoundatpos(var_2.origin, "UFO_tone_playback_" + var_0[3]);
  var_3 = getufolightcolor(var_0[3]);
  set_ufo_model_with_thrusters(var_2, var_3, var_1);
  thread shakeplayershud();
  wait(3.5);
  set_ufo_model_with_thrusters(var_2, "zmb_spaceland_ufo", var_1);
}

set_ufo_model_with_thrusters(var_0, var_1, var_2) {
  var_0 setModel(var_1);
  if(scripts\engine\utility::istrue(var_2)) {
    var_0 thread delay_turn_on_thrusters(var_0);
  }
}

delay_turn_on_thrusters(var_0) {
  var_0 notify("ufo_delay_turn_on_thrusters");
  var_0 endon("death");
  var_0 endon("ufo_delay_turn_on_thrusters");
  wait(0.1);
  var_0 setscriptablepartstate("thrusters", "on");
}

getufolightcolor(var_0) {
  var_1 = 0;
  foreach(var_3 in level.ufotones) {
    var_4 = strtok(var_3, "_");
    if(var_0 == var_4[3]) {
      break;
    }
  }

  switch (var_1) {
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
  foreach(var_1 in level.players) {
    if(!isalive(var_1)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_1.is_off_grid)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
      continue;
    }

    var_1 setclientomnvar("ui_hud_shake", 1);
    var_1 playrumbleonentity("artillery_rumble");
  }
}

setplaybacktimer() {
  self notify("stop_playback_timer");
  self endon("stop_playback_timer");
  var_0 = scripts\engine\utility::ter_op(level.players.size == 1, 4, 2.5);
  wait(var_0);
  level notify("tone_played");
}

play_fx_with_delay(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3) && isDefined(var_4)) {
    var_5 = spawnfx(level._effect[var_1], var_2, var_3, var_4);
  } else {
    var_5 = spawnfx(level._effect[var_2], var_3);
  }

  wait(var_0);
  triggerfx(var_5);
  return var_5;
}

keep_rotate(var_0) {
  var_0 endon("death");
  var_0 endon("ufo_started_moving");
  var_1 = 0.4;
  for(;;) {
    var_2 = var_0.angles[0];
    var_0 rotateyaw(var_2 + 120, var_1);
    wait(var_1);
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

delayed_move_mode(var_0) {
  var_0 endon("death");
  wait(1);
  var_0.health = 150;
  var_0.synctransients = "sprint";
  var_0.moveratescale = 0.8;
  var_0.traverseratescale = 0.8;
  var_0.generalspeedratescale = 0.8;
}

death_track(var_0) {
  self waittill("death");
  level.num_ufo_zombies_killed++;
}

make_grey_spawn_struct(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  var_1.angles = (0, 90, 0);
  var_1.is_coaster_spawner = 1;
  return var_1;
}

make_suicide_bomber_spawn_struct() {
  var_0 = [(647, 621, 80), (-40, 658, 1), (1286, 658, 1)];
  var_1 = spawnStruct();
  var_1.origin = scripts\engine\utility::random(var_0);
  var_1.angles = (0, 90, 0);
  var_1.is_coaster_spawner = 1;
  return var_1;
}

start_grey_sequence() {
  level endon("game_ended");
  scripts\cp\zombies\zombie_analytics::log_grey_sequence_activated(level.wave_num);
  wait(3);
  play_start_grey_sequence_vo();
  var_0 = 0.3;
  var_1 = 0.7;
  var_2 = [(642, 710, 67), (996, 657, 11), (642, 325, 11), (303, 651, 11)];
  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = make_grey_spawn_struct(var_2[var_3]);
    scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(1);
    for(;;) {
      var_5 = scripts\mp\mp_agent::spawnnewagent("zombie_grey", "axis", var_4.origin, var_4.angles, "iw7_zapper_grey");
      if(isDefined(var_5)) {
        if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
          var_5 scripts\mp\mp_agent::set_agent_health(int(700000));
        }

        var_5 thread intro_anim_timer(var_5);
        var_5 get_info_for_all_players(var_5);
        var_5.favorite_target_player = level.players[var_3];
        var_5.dont_scriptkill = 1;
        scripts\asm\zombie_grey\zombie_grey_asm::set_up_grey(var_5);
        break;
      }

      scripts\asm\zombie_grey\zombie_grey_asm::try_kill_off_zombies(1);
      scripts\engine\utility::waitframe();
    }

    scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
    wait(randomfloatrange(var_0, var_1));
  }
}

get_info_for_all_players(var_0) {
  foreach(var_2 in level.players) {
    var_0 getenemyinfo(var_2);
  }
}

intro_anim_timer(var_0) {
  var_1 = 7;
  var_0 endon("death");
  var_2 = var_0 scripts\cp\utility::waittill_any_ents_or_timeout_return(var_1, var_0, "damage");
  var_0.should_stop_intro_anim = 1;
  scripts\aitypes\zombie_grey\behaviors::set_next_teleport_attack_time(var_0);
  scripts\aitypes\zombie_grey\behaviors::set_can_do_teleport_attack(var_0, 1);
}

play_start_grey_sequence_vo() {
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_alien_spawn", "zmb_ww_vo", "highest", 60, 1, 0, 1);
  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("alien_first", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
  }
}

grey_on_killed_func(var_0, var_1, var_2, var_3, var_4) {
  level.spawned_enemies = scripts\engine\utility::array_remove(level.spawned_enemies, var_0);
  level.spawned_grey = scripts\engine\utility::array_remove(level.spawned_grey, var_0);
  if(level.spawned_grey.size == 0) {
    if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
      level thread grey_killed_vo(var_1);
      scripts\cp\cp_weaponrank::try_give_weapon_xp_zombie_killed(var_1, var_2, var_3, var_4, var_0.agent_type);
    }

    level notify("stop_ufo_zombie_spawn");
    level notify("complete_alien_grey_fight");
  }
}

grey_killed_vo(var_0) {
  level endon("game_ended");
  if(isDefined(var_0)) {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("alien_defeat", "zmb_comment_vo", "highest", 10, 0, 0, 1);
  }

  wait(4);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_alien_death", "zmb_ww_vo", "highest", 60, 0, 0, 1);
}

ufo_damage_monitor(var_0) {
  var_0 endon("death");
  var_0.maxhealth = 999999999;
  var_0.health = 999999999;
  var_0.fake_health = 3000;
  var_0 setCanDamage(1);
  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    if(isDefined(var_0A)) {
      if(weapon_can_damage_ufo(var_0A)) {
        break;
      } else if(isDefined(var_2) && isplayer(var_2)) {
        var_0B = gettime();
        if(!isDefined(var_2.previous_weapon_too_weak_for_ufo_time) || var_0B - var_2.previous_weapon_too_weak_for_ufo_time / 1000 > 3) {
          var_2 scripts\cp\cp_vo::try_to_play_vo("nag_ufo_shoot", "zmb_comment_vo", "high", 100, 0, 0, 1, 100);
          var_2.previous_weapon_too_weak_for_ufo_time = var_0B;
        }
      }
    }
  }

  var_0 moveto((-554, -1488, 2280), 3, 1.5);
  var_0 playsoundonmovingent("zmb_ufo_explo");
  playFXOnTag(level._effect["ufo_small_explosion"], var_0, "TAG_ORIGIN");
  wait(3);
  var_0 stoploopsound();
  level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_ufo_shoot");
  scripts\cp\zombies\zombie_analytics::log_ufo_destroyed(level.wave_num);
  level thread pausespawningfortime();
  level thread destroy_ufo_vo();
  if(isDefined(var_0.turrets)) {
    foreach(var_0D in var_0.turrets) {
      var_0D delete();
    }
  }

  playFX(level._effect["ufo_explosion"], var_0.origin);
  scripts\engine\utility::flag_set("ufo_destroyed");
  var_0 delete();
}

pausespawningfortime() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("pause_spawn_after_UFO_destroyed");
  scripts\engine\utility::flag_set("pause_spawn_after_UFO_destroyed");
  level.zombies_paused = 1;
  scripts\engine\utility::flag_set("pause_wave_progression");
  var_0 = spawn("script_model", level.players[0].origin);
  var_0 setModel("tag_origin");
  var_0.team = "allies";
  level.forced_nuke = 1;
  scripts\cp\loot::process_loot_content(level.players[0], "kill_50", var_0, 0);
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

weapon_can_damage_ufo(var_0) {
  if(var_0 == "iw7_spaceland_wmd") {
    return 1;
  }

  return 0;
}

attach_alien_fuse(var_0) {
  var_0.available_fuse = [];
  var_0.available_fuse[var_0.available_fuse.size] = create_alien_fuse(var_0, "tag_back_le");
  var_0.available_fuse[var_0.available_fuse.size] = create_alien_fuse(var_0, "tag_back_ri");
}

create_alien_fuse(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_3 = spawn("script_model", var_0 gettagorigin(var_1));
  var_3 setModel("park_alien_gray_fuse");
  var_3.angles = var_0 gettagangles(var_1);
  var_3 linkto(var_0, var_1, (0, 0, 0), var_2);
  var_3.triggerportableradarping = var_0;
  var_3.tag_name = var_1;
  return var_3;
}

remove_alien_fuse(var_0, var_1) {
  var_1.triggerportableradarping.available_fuse = scripts\engine\utility::array_remove(var_1.triggerportableradarping.available_fuse, var_1);
  if(isDefined(var_1)) {
    var_1 delete();
  }
}

drop_alien_fuses() {
  var_0 = spawn("script_model", (657, 765, 105));
  var_0 setModel("park_alien_gray_fuse");
  var_0.angles = (randomintrange(0, 360), randomintrange(0, 360), randomintrange(0, 360));
  var_1 = spawn("script_model", (641, 765, 105));
  var_1 setModel("park_alien_gray_fuse");
  var_1.angles = (randomintrange(0, 360), randomintrange(0, 360), randomintrange(0, 360));
  var_1 thread delay_spawn_glow_vfx_on(var_1, "souvenir_glow");
  var_1 thread item_keep_rotating(var_1);
  var_0 thread delay_spawn_glow_vfx_on(var_0, "souvenir_glow");
  var_0 thread item_keep_rotating(var_0);
  var_0 thread fuse_pick_up_monitor(var_0, var_1);
}

delay_spawn_glow_vfx_on(var_0, var_1) {
  var_0 endon("death");
  wait(0.3);
  playFXOnTag(level._effect[var_1], var_0, "tag_origin");
}

item_keep_rotating(var_0) {
  var_0 endon("death");
  var_1 = var_0.angles;
  for(;;) {
    var_0 rotateto(var_1 + (randomintrange(-40, 40), randomintrange(-40, 90), randomintrange(-40, 90)), 3);
    wait(3);
  }
}

fuse_pick_up_monitor(var_0, var_1) {
  var_0 endon("death");
  var_0 makeusable();
  var_0 sethintstring(&"CP_ZMB_UFO_PICK_UP_FUSE");
  foreach(var_3 in level.players) {
    var_3 thread scripts\cp\cp_vo::add_to_nag_vo("nag_ufo_fusefail", "zmb_comment_vo", 60, 15, 6, 1);
  }

  for(;;) {
    var_0 waittill("trigger", var_3);
    if(isplayer(var_3)) {
      var_3 playlocalsound("part_pickup");
      var_3 thread scripts\cp\cp_vo::try_to_play_vo("quest_ufo_collect_alienfuse_2", "zmb_comment_vo", "highest", 10, 0, 0, 1, 100);
      break;
    }
  }

  level.num_fuse_in_possession++;
  scripts\cp\cp_interaction::add_to_current_interaction_list(scripts\engine\utility::getstruct("pap_upgrade", "script_noteworthy"));
  scripts\cp\cp_interaction::remove_from_current_interaction_list(scripts\engine\utility::getstruct("weapon_upgrade", "script_noteworthy"));
  level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_ufo_fusefail");
  foreach(var_3 in level.players) {
    var_3 setclientomnvar("zm_special_item", 1);
  }

  var_1 delete();
  var_0 delete();
}

drop_soul_key() {
  var_0 = spawn("script_model", (646, 774, 105));
  var_0 setModel("zmb_soul_key_base");
  var_1 = spawnfx(level._effect["soul_key_glow"], var_0.origin);
  triggerfx(var_1);
  var_0 thread item_keep_rotating(var_0);
  var_0 thread soul_key_pick_up_monitor(var_0, var_1);
}

soul_key_pick_up_monitor(var_0, var_1) {
  var_0 endon("death");
  var_2 = 137;
  var_0 makeusable();
  var_0 sethintstring(&"CP_ZMB_UFO_PICK_UP_SOUL_KEY");
  for(;;) {
    var_0 waittill("trigger", var_3);
    if(isplayer(var_3)) {
      var_3 playlocalsound("part_pickup");
      scripts\cp\zombies\directors_cut::give_dc_player_extra_xp_for_carrying_newb();
      foreach(var_3 in level.players) {
        check_willard_pick_up_soul_key(var_3);
        var_3 setplayerdata("cp", "haveSoulKeys", "any_soul_key", 1);
        var_3 setplayerdata("cp", "haveSoulKeys", "soul_key_1", 1);
        var_3 scripts\cp\zombies\achievement::update_achievement("SOUL_KEY", 1);
      }

      if(any_player_is_willard()) {
        stop_spawn_wave();
        clear_existing_enemies();
        stop_gameplay_audio();
        scripts\cp\utility::play_bink_video("sysload_o4", var_2);
        wait(var_2);
        resume_spawn_wave();
        resume_gameplay_audio();
      }

      level thread scripts\cp\cp_vo::try_to_play_vo("dj_quest_ufo_soulkey_achieve", "zmb_dj_vo", "high", 20, 0, 0, 1);
      level thread soulkey_quest_vo(var_3);
      break;
    }
  }

  level thread scripts\cp\zombies\directors_cut::try_drop_talisman(var_0.origin, vectortoangles((0, 1, 0)));
  var_1 delete();
  var_0 delete();
}

stop_gameplay_audio() {
  scripts\cp\cp_vo::set_vo_system_busy(1);
  level.disable_broadcast = 1;
  scripts\engine\utility::flag_set("jukebox_paused");
  level notify("skip_song");
  foreach(var_1 in level.players) {
    scripts\cp\maps\cp_zmb\cp_zmb_vo::clear_up_all_vo(var_1);
    var_1 _meth_82C0("bink_fadeout_amb", 0.66);
  }
}

resume_gameplay_audio() {
  scripts\cp\cp_vo::set_vo_system_busy(0);
  level.disable_broadcast = undefined;
  scripts\engine\utility::flag_clear("jukebox_paused");
  foreach(var_1 in level.players) {
    var_1 clearclienttriggeraudiozone(0);
  }
}

clear_existing_enemies() {
  foreach(var_1 in level.spawned_enemies) {
    var_1.died_poorly = 1;
    var_1.nocorpse = 1;
    var_1 suicide();
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
  foreach(var_1 in level.players) {
    if(isDefined(var_1.vo_prefix) && var_1.vo_prefix == "p6_") {
      return 1;
    }
  }

  return 0;
}

check_willard_pick_up_soul_key(var_0) {
  if(isDefined(var_0.vo_prefix) && var_0.vo_prefix == "p6_") {
    var_0 scripts\cp\cp_merits::processmerit("mt_dlc4_troll");
  }
}

soulkey_quest_vo(var_0) {
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("quest_ufo_collect_soulkey", "zmb_comment_vo", "highest", 10, 0, 3, 1, 100);
  level thread scripts\cp\cp_vo::try_to_play_vo("collect_soulkey_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
  var_0 thread scripts\cp\cp_vo::add_to_nag_vo("nag_return_arcanecore", "zmb_comment_vo", 60, 120, 6, 1);
}

pap_upgrade_hintstring(var_0, var_1) {
  if(isDefined(level.num_fuse_in_possession) && level.num_fuse_in_possession > 0) {
    return &"CP_ZMB_INTERACTIONS_PAP_UPGRADE";
  }

  return "";
}

upgrade_pap(var_0, var_1) {
  level.num_fuse_in_possession--;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  insert_alien_fuses();
  scripts\engine\utility::flag_set("fuses_inserted");
  level.pap_max = int(min(level.pap_max + 1, 3));
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("zm_special_item", 0);
  }

  wait(3);
  scripts\cp\cp_interaction::add_to_current_interaction_list(scripts\engine\utility::getstruct("weapon_upgrade", "script_noteworthy"));
}

insert_alien_fuses() {
  var_0 = getent("pap_machine", "targetname");
  var_0 setscriptablepartstate("door", "close");
  wait(0.5);
  var_0 setscriptablepartstate("machine", "upgraded");
  wait(0.25);
  var_0 setscriptablepartstate("reels", "neutral");
  wait(0.25);
  var_0 setscriptablepartstate("reels", "on");
  wait(0.25);
  var_0 setscriptablepartstate("door", "open_idle");
}

init_pap_upgrade() {
  var_0 = scripts\engine\utility::getstructarray("pap_upgrade", "script_noteworthy");
  foreach(var_2 in var_0) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
  }
}

can_use_pap_upgrade(var_0, var_1) {
  if(isDefined(level.num_fuse_in_possession) && level.num_fuse_in_possession > 0) {
    return 1;
  }

  return 0;
}

activate_ufo_turret(var_0) {
  var_1 = [];
  var_2 = setup_ufo_turret(var_0 gettagorigin("tag_origin"));
  var_2 linkto(var_0, "tag_origin", (0, 0, -100), (180, 0, 0));
  var_1[var_1.size] = var_2;
  var_0.turrets = var_1;
}

setup_ufo_turret(var_0) {
  var_1 = spawnturret("misc_turret", var_0, "ufo_turret_gun_zombie");
  var_1 setModel("weapon_ceiling_sentry_temp");
  var_1 getvalidattachments();
  var_1 makeunusable();
  var_1.team = "axis";
  var_1 setturretteam("axis");
  var_1 give_player_session_tokens("sentry");
  var_1 setsentryowner(undefined);
  var_1 setleftarc(360);
  var_1 setrightarc(360);
  var_1 give_crafted_gascan(360);
  var_1 settoparc(360);
  var_1 laseron();
  var_1 thread ufo_turret_fire_monitor(var_1);
  return var_1;
}

ufo_turret_fire_monitor(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  for(;;) {
    wait(3);
    var_1 = get_ufo_turret_target();
    if(isDefined(var_1)) {
      var_0 settargetentity(var_1);
      var_2 = scripts\engine\utility::waittill_any_timeout_1(2, "turret_on_target");
      if(var_2 == "turret_on_target") {
        var_3 = randomintrange(30, 45);
        for(var_4 = 0; var_4 < var_3; var_4++) {
          if(!can_be_attacked_by_ufo_turret(var_1)) {
            break;
          }

          var_0 shootturret();
          wait(0.1);
        }
      }
    }

    var_0 cleartargetentity();
  }
}

get_ufo_turret_target() {
  var_0 = [];
  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }

    var_0[var_0.size] = var_2;
  }

  return scripts\engine\utility::random(var_0);
}

can_be_attacked_by_ufo_turret(var_0) {
  if(!isplayer(var_0)) {
    return 0;
  }

  if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    return 0;
  }

  return 1;
}

start_ufo_zombie_spawn_sequence() {
  var_0 = level.ufo;
  level endon("game_ended");
  level endon("stop_ufo_zombie_spawn");
  var_0 endon("death");
  if(!scripts\engine\utility::flag("ufo_intro_reach_center_portal")) {
    scripts\engine\utility::flag_wait("ufo_intro_reach_center_portal");
  }

  level thread max_ufo_zombie_spawn_number_logic();
  for(;;) {
    var_1 = get_num_of_nodes_to_travel_before_spawn_zombie();
    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_3 = get_beam_down_ground_location();
      var_4 = (var_3.origin[0], var_3.origin[1], (647, 621, 901)[2]);
      ufo_fly_to_pos(var_4);
    }

    var_5 = get_num_ufo_zombies();
    if(var_5 > 0) {
      level thread ufo_beam_down_zombies(var_5);
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
  var_0 = 24;
  level.max_ufo_zombie_spawn_number = 1;
  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = get_update_max_spawn_frequency();
    wait(var_2);
    level.max_ufo_zombie_spawn_number++;
  }
}

get_update_max_spawn_frequency() {
  return 40;
}

get_num_ufo_zombies() {
  var_0 = 24 - level.spawned_enemies.size - 3;
  var_1 = min(var_0, level.max_ufo_zombie_spawn_number);
  return var_1;
}

ufo_beam_down_zombies(var_0) {
  var_1 = activate_ufo_beam("ufo_zombie_spawn_beam");
  spawn_and_beam_down_zombies(var_0);
  deactivate_ufo_beam(var_1, "ufo_zombie_spawn_beam");
  level notify("beam_down_zombie_complete");
}

ufo_fly_to_pos(var_0) {
  var_1 = distance(level.ufo.origin, var_0);
  var_2 = var_1 / 150;
  level.ufo moveto(var_0, var_2);
  level.ufo waittill("movedone");
}

activate_ufo_beam(var_0) {
  var_1 = level.ufo;
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("tag_origin");
  var_2.angles = vectortoangles((0, 0, 1));
  wait(0.2);
  playFXOnTag(level._effect[var_0], var_2, "tag_origin");
  return var_2;
}

deactivate_ufo_beam(var_0, var_1) {
  killfxontag(level._effect[var_1], var_0, "tag_origin");
  var_0 delete();
}

spawn_and_beam_down_zombies(var_0) {
  var_1 = level.ufo;
  level endon("stop_ufo_zombie_spawn");
  var_1 endon("death");
  wait(1);
  var_2 = get_ufo_zombie_spawn_locations(var_0);
  for(var_3 = 0; var_3 < var_0; var_3++) {
    level thread spawn_and_beam_down_zombie(var_2[var_3]);
    if(var_3 == var_0 - 1) {
      break;
    }

    wait(1);
  }

  wait(2);
}

get_ufo_zombie_spawn_locations(var_0) {
  var_1 = [];
  var_2 = level.ufo;
  var_3 = var_2.angles;
  var_4 = 360 / var_0;
  for(var_5 = 0; var_5 < var_0; var_5++) {
    var_6 = (var_3[0], var_3[1] + var_4 * var_5, var_3[2]);
    var_7 = var_2.origin + anglesToForward(var_6) * 30;
    var_1[var_1.size] = var_7;
  }

  return var_1;
}

spawn_and_beam_down_zombie(var_0) {
  var_1 = (0, 0, -50);
  var_2 = (0, 0, -4000);
  var_3 = scripts\mp\mp_agent::spawnnewagent("generic_zombie", "axis", var_0, level.ufo.angles, undefined);
  if(isDefined(var_3)) {
    var_3.entered_playspace = 1;
    var_3 ghostskulls_total_waves(var_3.defaultgoalradius);
    var_3.maxhealth = scripts\cp\zombies\zombies_spawning::calculatezombiehealth("generic_zombie");
    var_3.health = var_3.maxhealth;
    var_3 thread ufo_zombie_death_monitor(var_3);
    level.spawned_enemies[level.spawned_enemies.size] = var_3;
    var_4 = spawn("script_model", var_3.origin);
    var_4 setModel("tag_origin");
    var_3 linkto(var_4, "tag_origin");
    var_5 = bulletTrace(var_0 + var_1, var_0 + var_2, 0, level.ufo)["position"];
    var_4 moveto(var_5, 1.5, 0, 0.75);
    var_4 waittill("movedone");
    var_3 unlink();
    var_4 delete();
  }
}

ufo_zombie_death_monitor(var_0) {
  var_0 waittill("death");
  level.spawned_enemies = scripts\engine\utility::array_remove(level.spawned_enemies, var_0);
}

get_beam_down_ground_location() {
  var_0 = level.ufo;
  var_1 = [];
  var_2 = scripts\engine\utility::getstructarray("ufo_zombie_spawn_loc", "targetname");
  foreach(var_4 in var_2) {
    if(distance2dsquared(var_0.origin, var_4.origin) < 250000) {
      continue;
    }

    if(distance2dsquared(var_0.origin, var_4.origin) > 1000000) {
      continue;
    }

    var_1[var_1.size] = var_4;
  }

  return scripts\engine\utility::random(var_1);
}

ufo_pre_grey_regen_func(var_0) {
  var_1 = level.ufo;
  level notify("stop_ufo_zombie_spawn");
  var_2 = (var_0.origin[0], var_0.origin[1], var_1.origin[2]);
  var_1 dontinterpolate();
  var_1.origin = var_2;
}

ufo_post_grey_regen_func() {}

move_grey_fight_clip_down() {
  level endon("game_ended");
  var_0 = getent("grey_fight_clip", "targetname");
  if(isDefined(var_0)) {
    var_1 = var_0.origin;
    var_2 = (var_1[0], var_1[1], var_1[2] - 1024);
    var_0 moveto(var_2, 0.05);
    var_0 waittill("movedone");
    var_0 disconnectpaths();
  }
}

clear_grey_fight_clips() {
  var_0 = getent("grey_fight_clip", "targetname");
  if(isDefined(var_0)) {
    var_0 connectpaths();
    var_0 delete();
  }
}

start_grey_fight_blocker_vfx() {
  level.grey_fight_vfx = [];
  level.grey_fight_sfx = [];
  var_0 = [(438, -1353, 125), (1379, 660, 85), (-137, 645, 100)];
  var_1 = [(0, 40, 0), (0, 180, 0), (0, 0, 0)];
  foreach(var_6, var_3 in var_0) {
    var_4 = scripts\engine\utility::play_loopsound_in_space("zmb_portal_area_lock_in", var_3);
    var_5 = spawnfx(level._effect["moving_target_portal"], var_3, anglesToForward(var_1[var_6]), anglestoup(var_1[var_6]));
    triggerfx(var_5);
    level.grey_fight_vfx[level.grey_fight_vfx.size] = var_5;
    level.grey_fight_sfx[level.grey_fight_sfx.size] = var_4;
  }
}

stop_grey_fight_blocker_vfx() {
  if(!isDefined(level.grey_fight_vfx)) {
    return;
  }

  foreach(var_1 in level.grey_fight_vfx) {
    var_1 delete();
  }
}

stop_grey_fight_blocker_sfx() {
  if(!isDefined(level.grey_fight_sfx)) {
    return;
  }

  foreach(var_1 in level.grey_fight_sfx) {
    var_1 stoploopsound();
    wait(0.1);
    var_1 delete();
  }
}

start_slow_projectile_sequence(var_0) {
  var_0 thread shoot_slow_projectiles(var_0);
  var_0 thread fly_around_main_street(var_0);
}

fly_around_main_street(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  if(!scripts\engine\utility::flag("ufo_intro_reach_center_portal")) {
    scripts\engine\utility::flag_wait("ufo_intro_reach_center_portal");
  }

  for(;;) {
    var_1 = get_beam_down_ground_location();
    var_2 = (var_1.origin[0], var_1.origin[1], (647, 621, 901)[2]);
    ufo_fly_to_pos(var_2);
  }
}

shoot_slow_projectiles(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_1 = 5;
  for(;;) {
    wait(randomfloatrange(10, 15));
    var_2 = get_slow_projectile_targets(level.ufo);
    if(var_2.size > 0) {
      var_3 = get_spread_out_points(level.ufo, var_1);
      foreach(var_5 in var_3) {
        level thread fire_slow_projectile_from(var_5, var_2[randomint(var_2.size)]);
      }
    }
  }
}

get_spread_out_points(var_0, var_1) {
  var_2 = 360 / var_1;
  var_3 = var_0.angles;
  var_4 = [];
  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = var_2 / 2 + var_5 * var_2;
    var_7 = (var_3[0], var_3[1] + var_6, var_3[2]);
    var_8 = anglesToForward(var_7);
    var_9 = var_0.origin + var_8 * 350 + (0, 0, -200);
    var_4[var_4.size] = var_9;
  }

  return var_4;
}

fire_slow_projectile_from(var_0, var_1) {
  var_2 = magicbullet("iw7_ufo_proj", var_0, var_0 + (0, 0, -100));
  wait(0.6);
  if(isDefined(var_2) && isDefined(var_1) && !scripts\cp\cp_laststand::player_in_laststand(var_1)) {
    var_2 missile_settargetent(var_1);
  }
}

get_slow_projectile_targets(var_0) {
  var_1 = [];
  foreach(var_3 in level.players) {
    if(!can_be_slow_projectile_target(var_3, var_0)) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  return var_1;
}

can_be_slow_projectile_target(var_0, var_1) {
  if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    return 0;
  }

  if(!bullettracepassed(var_1.origin, var_0 getEye(), 0, var_1)) {
    return 0;
  }

  return 1;
}

transform_wave_zombies_to_suicide_bombers() {
  level endon("game_ended");
  scripts\cp\zombies\zombie_analytics::log_suicide_bomber_sequence_activated(level.wave_num);
  foreach(var_1 in level.spawned_enemies) {
    if(isDefined(var_1.agent_type) && var_1.agent_type == "generic_zombie") {
      var_1 scripts\asm\zombie\zombie::turnintosuicidebomber(1);
      var_1 setavoidanceradius(4);
      wait(randomfloatrange(0.3, 0.7));
    }
  }
}

activate_spaceland_powernode() {
  level thread spaceland_powernode_damage_monitor();
}

spaceland_powernode_damage_monitor() {
  var_0 = getent("main_gate_powernode_damage_trigger", "targetname");
  var_0 setCanDamage(1);
  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    var_0B = get_power_node_struct(var_4);
    if(!isDefined(var_0B)) {
      if(randomint(100) > 85) {
        scripts\cp\cp_vo::try_to_play_vo_on_all_players("nag_ufo_signfail");
      }

      continue;
    }

    if(scripts\engine\utility::istrue(var_0B.is_activated)) {
      continue;
    }

    if(can_charge_power_nodes(var_0A, var_2)) {
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

should_play_arc_vfx(var_0) {
  if(var_0.var_336 == "main_gate_powernode_5") {
    return 0;
  }

  return 1;
}

change_gate_light_color(var_0) {
  var_1 = get_nearby_gate_light_scriptable(var_0);
  var_1 setscriptablepartstate("main_gate_light", "charged");
}

get_nearby_gate_light_scriptable(var_0) {
  var_1 = 10000;
  for(var_2 = 1; var_2 <= 5; var_2++) {
    var_3 = getent("gate_light_0" + var_2, "targetname");
    if(distancesquared(var_0.origin, var_3.origin) < var_1) {
      return var_3;
    }
  }
}

can_charge_power_nodes(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = getweaponbasename(var_0);
  switch (var_2) {
    case "iw7_headcutter_zm_pap1":
    case "iw7_headcutter_zm":
    case "iw7_facemelter_zm_pap1":
    case "iw7_facemelter_zm":
    case "iw7_dischord_zm_pap1":
    case "iw7_dischord_zm":
    case "iw7_shredder_zm_pap1":
    case "iw7_shredder_zm":
      if(var_1 scripts\cp\cp_weapon::get_weapon_level(var_0) == 2) {
        return 1;
      } else {
        return 0;
      }

      break;

    default:
      return 0;
  }
}

play_arc_vfx_between_points(var_0, var_1, var_2, var_3) {
  var_4 = spawnfx(scripts\engine\utility::getfx("ufo_elec_beam_impact"), var_1);
  var_5 = spawnfx(scripts\engine\utility::getfx("ufo_elec_beam_impact"), var_2);
  var_6 = scripts\engine\utility::play_loopsound_in_space("zmb_ufo_spaceland_sign_charge_lp", var_1);
  triggerfx(var_4);
  triggerfx(var_5);
  for(;;) {
    playfxbetweenpoints(scripts\engine\utility::getfx(var_0), var_1, vectortoangles(var_1 - var_2), var_2);
    var_7 = scripts\engine\utility::waittill_any_timeout_1(1, var_3);
    if(var_7 == var_3) {
      break;
    }
  }

  var_6 delete();
  var_4 delete();
  var_5 delete();
}

all_power_nodes_are_activated() {
  var_0 = ["main_gate_powernode_1", "main_gate_powernode_2", "main_gate_powernode_3", "main_gate_powernode_4", "main_gate_powernode_5"];
  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getstruct(var_2, "targetname");
    if(!scripts\engine\utility::istrue(var_3.is_activated)) {
      return 0;
    }
  }

  return 1;
}

trigger_wmd() {
  var_0 = (726, 1788, 154);
  var_1 = (608, 1793, 154);
  var_2 = (668, 1580, 154);
  var_3 = (669, 1237, 154);
  var_4 = (648, 611, 281);
  var_5 = (647, 632, 86);
  var_6 = (646, 694, 51);
  var_7 = scripts\engine\utility::getstruct("main_gate_powernode_1", "targetname");
  var_8 = scripts\engine\utility::getstruct("main_gate_powernode_2", "targetname");
  var_9 = scripts\engine\utility::getstruct("main_gate_powernode_3", "targetname");
  var_0A = scripts\engine\utility::getstruct("main_gate_powernode_4", "targetname");
  var_0B = scripts\engine\utility::getstruct("main_gate_powernode_5", "targetname");
  level thread play_arc_vfx_between_points("powernode_arc_medium", var_8.origin, var_0, "spaceland_arc_fired");
  level thread play_arc_vfx_between_points("powernode_arc_medium", var_0A.origin, var_1, "spaceland_arc_fired");
  level thread play_arc_vfx_between_points("powernode_arc_medium", var_9.origin, var_2, "spaceland_arc_fired");
  level thread play_arc_vfx_between_points("powernode_arc_medium", var_0, var_2, "spaceland_arc_fired");
  level thread play_arc_vfx_between_points("powernode_arc_medium", var_1, var_2, "spaceland_arc_fired");
  playsoundatpos(var_0, "zmb_ufo_spaceland_sign_build");
  wait(randomfloatrange(1.3, 1.7));
  level thread play_arc_vfx_between_points("powernode_arc_big", var_2, var_3, "spaceland_arc_fired");
  wait(randomfloatrange(1.3, 1.7));
  level thread play_arc_vfx_between_points("powernode_arc_big", var_3, var_5, "spaceland_arc_fired");
  var_7.is_activated = 0;
  var_8.is_activated = 0;
  var_9.is_activated = 0;
  var_0A.is_activated = 0;
  var_0B.is_activated = 0;
  scripts\engine\utility::exploder(90);
  wait(2);
  playsoundatpos(var_5, "zmb_ufo_spaceland_sign_wmd");
  level notify("spaceland_arc_fired");
  magicbullet("iw7_spaceland_wmd", var_4 + (0, 0, 50), var_4 + (0, 0, 2000));
  change_gate_light_scriptable_to_on_state();
}

change_gate_light_scriptable_to_on_state() {
  for(var_0 = 1; var_0 <= 5; var_0++) {
    var_1 = getent("gate_light_0" + var_0, "targetname");
    var_1 setscriptablepartstate("main_gate_light", "on");
  }
}

play_trigger_wmd_vo() {
  wait(0.1);
  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_ufo_signhit_5", "zmb_comment_vo", "highest", 10, 0, 0, 0, 50);
  }
}

get_power_node_struct(var_0) {
  var_1 = 10000;
  var_2 = ["main_gate_powernode_1", "main_gate_powernode_2", "main_gate_powernode_3", "main_gate_powernode_4", "main_gate_powernode_5"];
  foreach(var_4 in var_2) {
    var_5 = scripts\engine\utility::getstruct(var_4, "targetname");
    if(distancesquared(var_5.origin, var_0) < var_1) {
      return var_5;
    }
  }
}

play_ufo_start_vfx() {
  var_0 = (-1066.27, -2577.7, 2051.62);
  var_1 = (-2164.96, -2780.52, 1923.13);
  var_2 = (-1710.99, -2499.7, 1618.13);
  var_3 = 0.8;
  playsoundatpos((-1198, -2137, 1946), "zmb_ufo_break_free_ice");
  playFX(level._effect["vfx_ufo_snow"], var_0);
  playFX(level._effect["vfx_ufo_snow"], var_1);
  wait(var_3);
  playFX(level._effect["vfx_ufo_snow"], var_2);
}