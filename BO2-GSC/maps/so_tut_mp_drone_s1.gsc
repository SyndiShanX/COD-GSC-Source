/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\so_tut_mp_drone_s1.gsc
***************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_scene;
#include maps\_audio;
#include maps\_music;
#include maps\_anim;
#include maps\_statemachine;
#include maps\_claw;
#include maps\_cic_turret;
#include maps\_metal_storm;
#include maps\_so_rts_support;
#include maps\_so_rts_rules;
#include maps\_so_rts_catalog;
#include maps\_so_rts_squad;
#include maps\_objectives;
#include maps\_so_rts_main;
#include maps\_so_rts_event;
#include maps\_so_rts_ai;

precache() {
  precacheshader("compass_a10");
  precachemodel("t6_wpn_turret_sentry_gun_monsoon_yellow");
  precachemodel("t6_wpn_turret_sentry_gun_monsoon_red");
  precachemodel("p6_drone_gas_silo_dmg");
  precachemodel("fxanim_gp_vtol_drop_asd_drone_mod");
  precachemodel("p6_sf_target_gizmo");
  precachemodel("t6_wpn_emp_device_world");
  precachemodel("p_glo_satellitedish");
  precachestring(&"SO_TUT_MP_DRONE_OBJ_TUTORIAL");
  precachestring(&"SO_TUT_MP_DRONE_FPS_CLAW");
  precachestring(&"SO_TUT_MP_DRONE_FPS_INF");
  precachestring(&"SO_TUT_MP_DRONE_FPS_TURRET");
  precachestring(&"SO_TUT_MP_DRONE_TACT_PROMPT");
  precachestring(&"SO_TUT_MP_DRONE_TACT_CLAW");
  precachestring(&"SO_TUT_MP_DRONE_TACT_CLAW_MOVE");
  precachestring(&"SO_TUT_MP_DRONE_TACT_INF");
  precachestring(&"SO_TUT_MP_DRONE_TACT_INF_MOVE");
  precachestring(&"SO_TUT_MP_DRONE_TACT_ALL_MOVE");
  precachestring(&"SO_TUT_MP_DRONE_TACT_TARGET");
  precachestring(&"SO_TUT_MP_DRONE_TACT_CONTROL");
  precachestring(&"SO_TUT_MP_DRONE_INF_PROMPT");
  precachestring(&"SO_TUT_MP_DRONE_FPS_INF_MOVE");
  precachestring(&"SO_TUT_MP_DRONE_FPS_INF_ALL_MOVE");
  precachestring(&"SO_TUT_MP_DRONE_MOVETO");
  precachestring(&"SO_TUT_MP_DRONE_TUT_START");
  precachestring(&"SO_TUT_MP_DRONE_TUT_START2");
  precachestring(&"SO_TUT_MP_DRONE_CLAW_FIRE");
  precachestring(&"SO_TUT_MP_DRONE_CLAW_GREN");
  precachestring(&"SO_TUT_MP_DRONE_TARGET");
  precachestring(&"SO_TUT_MP_DRONE_ENEMY");
  precachestring(&"SO_TUT_MP_DRONE_ASD_TARGET1");
  precachestring(&"SO_TUT_MP_DRONE_ASD_TARGET2");
  precachestring(&"SO_TUT_MP_DRONE_MOVE_CURSOR_TARGET");
  precachestring(&"SO_TUT_MP_DRONE_ATTACK_TARGET");
  precachestring(&"SO_TUT_MP_DRONE_ALL_ATTACK_TARGET");
  precachestring(&"SO_TUT_MP_DRONE_UNSELECT");
  precachestring(&"SO_TUT_MP_DRONE_UNSELECT_2");
  precachestring(&"SO_TUT_MP_DRONE_MOVE_SINGLE");
  precachestring(&"SO_TUT_MP_DRONE_HIGHLIGHT");
  maps\_claw::init();
  maps\_cic_turret::init();
  maps\_metal_storm::init();
}

drone_tut_takeoverwatch() {
  self endon("drone_mission_complete");

  while(true) {
    level waittill("entity_taken_over", entity);
    level waittill_any("takeover_complete", "player_in_control");
    level.rts.player enableinvulnerability();
  }
}

drone_ai_takeover_trigger(oob) {
  while(isDefined(self)) {
    self waittill("trigger", who);

    if(isDefined(oob) && oob) {
      who.allow_oob = 1;
      who.no_takeover = 1;
      who.unselectable = 1;
    } else {
      who.allow_oob = undefined;
      who.no_takeover = undefined;
      who.unselectable = undefined;

      if(isDefined(who.manual_lui_add) && who.manual_lui_add) {
        who.manual_lui_add = undefined;
        luinotifyevent(&"rts_add_friendly_human", 5, who getentitynumber(), who.squadid, 35, 0, who.pkg_ref.idx);
      }
    }
  }
}

drone_ai_takeover_off() {
  level endon("rts_terminated");
  triggers = getentarray("rts_takeover_OFF", "targetname");
  array_thread(triggers, ::drone_ai_takeover_trigger, 1);
}

drone_ai_takeover_on() {
  level endon("rts_terminated");
  triggers = getentarray("rts_takeover_ON", "targetname");
  array_thread(triggers, ::drone_ai_takeover_trigger, 0);
}

drone_level_scenario_one() {
  setdvar("ui_isrtstutorial", 1);
  level.custom_introscreen = maps\_so_rts_support::custom_introscreen;
  level.rts.use_random_drop_path = 1;
  level.nag = 0;
  flag_init("intro_done");
  flag_init("outro_done");
  flag_init("target_is_ready");
  maps\_so_rts_rules::set_gamemode("tutorial");
  level.rts.codespawncb = ::dronecodespawner;
  thread drone_geo_changes();
  flag_wait("all_players_connected");
  getplayers()[0] setdstat("PlayerCareerStats", "storypoints", "SO_WAR_TUTORIAL_COMPLETE", 1);
  level thread drone_ai_takeover_off();
  level thread drone_ai_takeover_on();
  flag_wait("start_rts");
  maps\_so_rts_support::hide_player_hud();
  level thread drone_tut_takeoverwatch();
  level thread maps\_so_rts_support::player_oobwatch();
  thread setup_objectives();
  maps\_so_rts_support::level_create_turrets();
  maps\_so_rts_catalog::spawn_package("infantry_ally_reg2_pkg", "allies", 1);
  turretpkg = maps\_so_rts_catalog::package_getpackagebytype("turret_pkg");
  squadid = maps\_so_rts_squad::createsquad(level.rts.allied_center.origin, "allies", turretpkg);
  luinotifyevent(&"rts_add_squad", 3, squadid, turretpkg.idx, 0);
  maps\_so_rts_catalog::spawn_package("turret_pkg", "allies", 1);
  maps\_so_rts_catalog::spawn_package("infantry_ally_reg_pkg", "allies", 1);
  maps\_so_rts_catalog::spawn_package("bigdog_pkg", "allies", 1, ::drone_level_player_startfps);
  squad = getsquadbypkg("bigdog_pkg", "allies");
  level thread maps\_so_rts_squad::removesquadmarker(squad.id, 1);
  squad = getsquadbypkg("turret_pkg", "allies");
  level thread maps\_so_rts_squad::removesquadmarker(squad.id, 1);
  flag_wait("introscreen_complete");
  flag_set("rts_hud_on");
  maps\_so_rts_support::show_player_hud();
  luinotifyevent(&"rts_toggle_button_prompts", 1, 0);
}

setup_objectives() {
  level.rts.player endon("expired");
  level thread maps\_objectives::init();
  level.obj_tutorial = register_objective(&"SO_TUT_MP_DRONE_OBJ_TUTORIAL");
  set_objective(level.obj_tutorial);
}

drone_level_player_startfps() {
  playerstart = getent("rts_player_start", "targetname");
  assert(isDefined(playerstart));
  inf2squad = getsquadbypkg("infantry_ally_reg2_pkg", "allies");
  nextsquad = inf2squad.id;
  assert(nextsquad != -1, "should not be -1, player squad should be created");
  level.rts.activesquad = nextsquad;
  level.rts.targetteammate = level.rts.squads[nextsquad].members[0];
  level thread maps\_so_rts_main::player_in_control();
  level waittill("switch_nearfullstatic");
  level.rts.squads[nextsquad].members[0] forceteleport(playerstart.origin, playerstart.angles);
  level waittill("switch_complete");
  level_fade_in(level.rts.player, 1);
  level thread drone_tutorial();
}

drone_mission_complete_s1(success, basejustlost) {
  self notify("drone_mission_complete");
  self endon("drone_mission_complete");
  screen_fade_out(0.5);
  level notify("mission_complete", success);
  level.rts.game_success = success;
  level.rts.player freezecontrols(1);
  level.rts.player set_ignoreme(1);
  flag_clear("rts_hud_on");
  maps\_so_rts_support::hide_player_hud();
  level.rts.player enableinvulnerability();
  flag_set("rts_game_over");
  maps\_so_rts_support::missionsuccessmenu();
  nextmission();
}

level_fade_in(player, delay) {
  if(!isDefined(player))
    player = level.rts.player;

  if(!isDefined(delay))
    delay = 0.5;

  thread screen_fade_in(delay);
}

drone_geo_changes() {
  level.rts_floor = getent("overwatch_floor", "targetname");
  level.rts_floor delete();
  ents = getentarray("rts_poi_LZ", "targetname");

  foreach(ent in ents)
  ent delete();

  ents = getentarray("rts_remove", "targetname");

  foreach(ent in ents)
  ent delete();

  ents = getentarray("script_model", "classname");

  foreach(ent in ents) {
    if(isDefined(ent.script_index)) {
      if(ent.script_index == 999)
        ent delete();
    }
  }

  ents = getentarray("delivery_van", "targetname");

  foreach(ent in ents)
  ent delete();

  level.laser_doors = getentarray("laser_door", "targetname");

  foreach(ent in level.laser_doors)
  ent disconnectpaths();

  roof = getent("rts_factory_roof", "targetname");

  if(isDefined(roof)) {
    targetloc = getstruct("rts_factory_roof_pos", "targetname");

    if(isDefined(targetloc))
      roof moveto(targetloc.origin, 0.1);
  }
}

drone_tutorialmsg(text, onnote, offnote, yoff, scmod, color) {
  if(!isDefined(yoff))
    yoff = 0;

  if(!isDefined(scmod))
    scmod = 0;

  if(!isDefined(color))
    color = (1, 1, 1);

  note = level waittill_any_return(onnote, "tutorial_abort");

  if(note == "tutorial_abort") {
    return;
  }
  msg = newhudelem();
  msg.alignx = "center";
  msg.aligny = "middle";
  msg.horzalign = "center";
  msg.vertalign = "middle";
  msg.y = msg.y - (130 + yoff);
  msg.foreground = 1;
  msg.fontscale = 2 + scmod;
  msg.hidewheninmenu = 1;
  msg.alpha = 0;
  msg.color = color;
  msg settext(text);
  msg fadeovertime(1);
  msg.alpha = 0.75;
  level notify(onnote + "_ready");
  level waittill_any(offnote, "tutorial_abort");
  msg fadeovertime(1);
  msg.alpha = 0.0;
  wait 1;
  msg destroy();
  level notify(offnote + "_done");
}

drone_tutorial_exit() {
  note = level waittill_any_return("tutorial_complete", "tutorial_abort");

  if(note != "tutorial_abort") {
    if(getdvarint(#"_id_0F241E06") == 0) {
      luinotifyevent(&"rts_tutorial_complete");

      while(true) {
        level.player waittill("menuresponse", menu_action, action_arg);

        if(menu_action == "rts_action") {
          break;
        }
      }
    } else
      changelevel("", 0);
  }

  setdvar("ui_isrtstutorial", 0);
  level thread maps\_so_rts_rules::mission_complete(1);
}

drone_watchbuttonpress() {
  level endon("tutorial_abort");
  dogsquad = getsquadbypkg("bigdog_pkg", "allies");
  infsquad = getsquadbypkg("infantry_ally_reg_pkg", "allies");
  inf2squad = getsquadbypkg("infantry_ally_reg2_pkg", "allies");

  while(true) {
    level waittill("button_event", btn);

    if(btn == "DPAD_DOWN" || btn == "DPAD_DOWN_LONG") {
      if(flag("fps_mode_locked_out"))
        package_highlightunits(dogsquad.id);
    }

    if(btn == "DPAD_LEFT" || btn == "DPAD_LEFT_LONG") {
      if(flag("fps_mode_locked_out"))
        package_highlightunits(infsquad.id);
    }

    if(btn == "DPAD_RIGHT" || btn == "DPAD_RIGHT_LONG") {
      if(flag("fps_mode_locked_out"))
        package_highlightunits(inf2squad.id);
    }
  }
}

drone_magicmarker(startscale, desiredscale, timeinsec, show) {
  if(!isDefined(show))
    show = 1;

  if(show)
    self show();

  self setscale(startscale);
  incs = int(timeinsec * 1000 / 50);
  inc = (desiredscale - startscale) / incs;
  curscale = startscale;

  while(incs > 0) {
    curscale = curscale + inc;

    if(curscale <= 0)
      self hide();
    else
      self setscale(curscale);

    incs--;
    wait 0.05;
  }

  if(!show)
    self hide();
}

nag_until_notify(interval, note) {
  level notify("nag_until_notify");
  level endon("nag_until_notify");
  repeat = 2;

  while(repeat) {
    repeat--;
    thenote = waittill_any_timeout(interval, note);

    if(thenote == "timeout")
      maps\_so_rts_event::trigger_event("dlg_nag");
    else
      break;

    interval = interval + interval / 2;
  }
}

drone_tutorial() {
  level endon("tutorial_abort");
  level thread drone_tutorial_exit();
  level thread drone_watchbuttonpress();
  localized_text_size = 0;

  if(getdvar(#"language") == "russian" || getdvar(#"language") == "polish")
    localized_text_size = -0.7;

  if(getdvarint(#"_id_0F241E06") == 0) {
    level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_TUT_START", "tut_start", "tut_start_done");
    level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_TUT_START2", "tut_start", "tut_start_done", -24);
  }

  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_FPS_CLAW", "fps_claw", "fps_claw_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_CLAW_FIRE", "fps_claw_fire", "fps_claw_fire_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_CLAW_GREN", "fps_claw_gren", "fps_claw_gren_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_FPS_INF", "fps_inf", "fps_inf_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_FPS_TURRET", "fps_turret", "fps_turret_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_TACT_PROMPT", "tact_prompt", "tact_prompt_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_TACT_CLAW", "tact_claw", "tact_claw_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_TACT_CLAW_MOVE", "tact_claw_move", "tact_claw_move_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_TACT_INF", "tact_inf", "tact_inf_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_TACT_INF_MOVE", "tact_inf_move", "tact_inf_move_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_TACT_ALL_MOVE", "tact_all_move", "tact_all_move_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_TACT_TARGET", "tact_target", "tact_target_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_TACT_CONTROL", "tact_control", "tact_control_done", -30, -0.5);
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_INF_PROMPT", "inf_prompt", "inf_prompt_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_FPS_INF_MOVE", "inf_move", "inf_move_done", 0, localized_text_size);
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_FPS_INF_ALL_MOVE", "inf_all_move", "inf_all_move_done", 0, localized_text_size);
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_MOVETO", "tact_move_claw_instruction", "tact_move_claw_instruction_done", -30, -0.5);
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_MOVETO", "tact_inf_instruction", "tact_inf_instruction_done", -30, -0.5);
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_MARKER", "tact_marker", "tact_marker_done", -30, -0.5);
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_TACT_PROMPT", "tact_prompt2", "tact_prompt2_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_ASD_TARGET1", "tact_targetasd", "tact_targetasd_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_ASD_TARGET2", "tact_targetasd", "tact_targetasd_done", -24);
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_MOVE_CURSOR_TARGET", "tact_enemy", "tact_enemy_done", 0, localized_text_size);
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_ATTACK_TARGET", "tact_target_enemy", "tact_target_enemy_done", -30, -0.5);
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_ALL_ATTACK_TARGET", "tact_alltarget_enemy", "tact_alltarget_enemy_done", -30, -0.5);
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_MOVE_SINGLE", "fps_move_single", "fps_move_single_done");
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_UNSELECT", "fps_unselect", "fps_unselect_done", -30, -0.5);
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_HIGHLIGHT", "tact_highlight", "tact_highlight_done", -30, -0.5);
  level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_DONE", "tut_done", "tut_done_done");
  flag_set("block_button_press");
  flag_set("rts_mode_locked_out");
  flag_wait("introscreen_complete");
  flag_set("rts_event_ready");
  maps\_so_rts_event::trigger_event("main_music_state");
  maps\_so_rts_event::trigger_event("dlg_intro_cam");
  dogsquad = getsquadbypkg("bigdog_pkg", "allies");
  infsquad = getsquadbypkg("infantry_ally_reg_pkg", "allies");
  inf2squad = getsquadbypkg("infantry_ally_reg2_pkg", "allies");
  tursquad = getsquadbypkg("turret_pkg", "allies");
  tursquad.no_show_marker = 1;

  foreach(dog in dogsquad.members)
  dog.takedamage = 0;

  foreach(guy in infsquad.members) {
    guy.goalradius = 350;
    guy.takedamage = 0;
  }

  foreach(guy in inf2squad.members) {
    guy.goalradius = 350;
    guy.takedamage = 0;
  }

  if(getdvarint(#"_id_0F241E06") == 0) {
    level notify("tut_start");
    wait 5;
    level notify("tut_start_done");
    level waittill("tut_start_done_done");
    wait 3;
  }

  maps\_so_rts_event::trigger_event("dlg_prep_claw");
  level thread nag_until_notify(15, "fps_claw_done");
  flag_clear("block_button_press");
  level notify("fps_claw");

  while(true) {
    if(isDefined(level.rts.player.ally) && issubstr(level.rts.player.ally.ai_ref.ref, "bigdog")) {
      break;
    }

    wait 0.05;
  }

  flag_set("block_button_press");
  level notify("fps_claw_done");
  level waittill("fps_claw_done_done");
  wait 3;
  level notify("fps_claw_fire");
  level thread nag_until_notify(15, "fps_claw_fire_done");
  level.rts.player.ally.vehicle waittill("turret_fire");
  level notify("fps_claw_fire_done");
  level waittill("fps_claw_fire_done_done");
  level notify("fps_claw_gren");
  level thread nag_until_notify(15, "fps_claw_gren_done");
  level.rts.player waittill_any("grenade_fire", "grenade_launcher_fire");
  maps\_so_rts_event::trigger_event("dlg_prep_claw_ack");
  level notify("fps_claw_gren_done");
  level waittill("fps_claw_gren_done_done");
  maps\_so_rts_event::trigger_event("dlg_prep_soldier");
  level thread nag_until_notify(15, "fps_inf_done");
  flag_clear("block_button_press");
  level notify("fps_inf");

  while(true) {
    if(isDefined(level.rts.player.ally) && issubstr(level.rts.player.ally.pkg_ref.ref, "infantry")) {
      break;
    }

    wait 0.05;
  }

  level notify("fps_inf_done");
  maps\_so_rts_event::trigger_event("dlg_prep_soldier_ack");
  level waittill("fps_inf_done_done");
  wait 3;

  if(isDefined(level.rts.player.ally) && !issubstr(level.rts.player.ally.ai_ref.ref, "turret")) {
    maps\_so_rts_event::trigger_event("dlg_prep_turret");
    level thread nag_until_notify(15, "fps_turret_done");
    level notify("fps_turret");

    while(true) {
      if(isDefined(level.rts.player.ally) && issubstr(level.rts.player.ally.ai_ref.ref, "turret")) {
        break;
      }

      wait 0.05;
    }

    level notify("fps_turret_done");
    maps\_so_rts_event::trigger_event("dlg_prep_turret_ack");
    level waittill("fps_turret_done_done");
    wait 3;
  }

  flag_clear("rts_mode_locked_out");
  level notify("tact_prompt");
  maps\_so_rts_event::trigger_event("dlg_prep_tactical");
  level thread nag_until_notify(15, "tact_prompt_done");

  while(flag("fps_mode"))
    wait 0.05;

  maps\_so_rts_event::trigger_event("dlg_prep_tactical_ack");
  flag_set("fps_mode_locked_out");
  flag_set("unit_select_locked_out");
  setsaveddvar("vc_lut", -3);
  level notify("tact_prompt_done");
  level waittill("tact_prompt_done_done");
  wait 3;

  if(dogsquad.members.size > 0) {
    infsquad.selectable = 0;
    inf2squad.selectable = 0;
    tursquad.selectable = 0;
    maps\_so_rts_event::trigger_event("dlg_move_claw");
    level thread nag_until_notify(15, "tact_claw_done");

    if(!isDefined(level.rts.activesquad) || level.rts.activesquad == 99 || !issubstr(level.rts.squads[level.rts.activesquad].pkg_ref.ref, "bigdog")) {
      level notify("tact_claw");
      level waittill("tact_claw_ready");
      wait 0.75;
      level notify("tact_highlight");
      level waittill("tact_highlight_ready");

      while(true) {
        if(isDefined(level.rts.activesquad) && level.rts.activesquad != 99 && issubstr(level.rts.squads[level.rts.activesquad].pkg_ref.ref, "bigdog")) {
          break;
        }

        wait 0.05;
      }

      flag_set("block_button_press");
      level notify("tact_claw_done");
      level notify("tact_highlight_done");
      level waittill("tact_claw_done_done");
    } else
      flag_set("block_button_press");

    spots = sortarraybyfurthest(dogsquad.members[0].origin, getentarray("rts_movespot", "targetname"), undefined, undefined, 1);
    level.rts.tutorialobj = getent("tut_highlight", "targetname");
    level.rts.tutorialobj ignorecheapentityflag(1);
    level.rts.tutorialobj hide();
    spot = spots[1].origin;
    arrayremoveindex(spots, 1, 0);
    level notify("tact_claw_move");
    wait 1;
    level.rts.tutorialobj.origin = spot;
    wait 1;
    level.rts.tutorialobj thread drone_magicmarker(0, 1, 1);
    level notify("tact_move_claw_instruction");
    level waittill("tact_move_claw_instruction_ready");
    wait 1;
    flag_clear("block_button_press");
    dogsquad.members[0].goalradius = 128;

    attempts = 0;
    level thread nag_until_notify(15, "tact_move_claw_instruction_done");

    while(true) {
      level waittill("squad_moved", point, squadid);

      if(distancesquared(level.rts.squads[dogsquad.id].centerpoint, level.rts.tutorialobj.origin) < 16900) {
        break;
      }

      maps\_so_rts_event::trigger_event("sfx_wrong_action");
      attempts++;
    }

    level.rts.tutorialobj thread drone_magicmarker(1, 0, 1, 0);
    level notify("tact_move_claw_instruction_done");
    level notify("tact_marker");
    level waittill("tact_marker_ready");
    wait 3;
    maps\_so_rts_event::trigger_event("dlg_move_claw_ack");
    wait 2;
    level notify("tact_marker_done");
    level notify("tact_claw_move_done");
    level waittill("tact_claw_move_done_done");
  }

  wait 3;
  infsquad.selectable = 1;
  inf2squad.selectable = 1;
  dogsquad.selectable = 0;

  if(infsquad.members.size > 0 || inf2squad.members.size > 0) {
    maps\_so_rts_event::trigger_event("dlg_move_soldier");
    level thread nag_until_notify(15, "tact_inf_done");
    level notify("tact_inf");
    level waittill("tact_inf_ready");

    while(true) {
      if(isDefined(level.rts.activesquad) && level.rts.activesquad != 99 && issubstr(level.rts.squads[level.rts.activesquad].pkg_ref.ref, "infantry")) {
        break;
      }

      wait 0.05;
    }

    flag_set("block_button_press");
    infsquadid = level.rts.activesquad;

    if(infsquad.id == infsquadid)
      inf2squad.selectable = 0;
    else
      infsquad.selectable = 0;

    level notify("tact_inf_done");
    level waittill("tact_inf_done_done");
    spots = sortarraybyfurthest(level.rts.squads[infsquadid].centerpoint, spots, undefined, undefined, 1);
    level.rts.tutorialobj.origin = spots[0].origin;
    wait 0.2;
    arrayremoveindex(spots, 0, 0);
    level.rts.tutorialobj thread drone_magicmarker(0, 2, 1);
    level notify("tact_inf_move");
    level waittill("tact_inf_move_ready");
    level notify("tact_inf_instruction");

    flag_clear("block_button_press");
    attempts = 0;
    level thread nag_until_notify(15, "tact_inf_move_done");

    while(true) {
      level waittill("squad_moved", point, squadid);

      if(distancesquared(level.rts.squads[infsquadid].centerpoint, level.rts.tutorialobj.origin) < 67600) {
        break;
      }

      maps\_so_rts_event::trigger_event("sfx_wrong_action");
      attempts++;
    }

    level notify("tact_inf_instruction_done");
    level notify("tact_inf_move_done");
    level waittill("tact_inf_move_done_done");
    flag_clear("block_button_press");
  }

  level.rts.tutorialobj thread drone_magicmarker(2, 0, 1, 0);
  wait 2;
  maps\_so_rts_event::trigger_event("dlg_move_soldier_ack");
  wait 1;
  infsquad.selectable = 1;
  inf2squad.selectable = 1;
  dogsquad.selectable = 1;
  level.rts.tutorialobj delete();
  level.rts.tutorialobj = undefined;
  level notify("tact_all_move");
  maps\_so_rts_event::trigger_event("dlg_move_all");
  level thread nag_until_notify(15, "tact_all_move_done");
  level waittill("tact_all_move_ready");
  level waittill("all_squads_move");
  level notify("tact_all_move_done");
  maps\_so_rts_event::trigger_event("dlg_move_all_ack");
  level waittill("tact_all_move_done_done");
  wait 3;
  flag_clear("unit_select_locked_out");
  dogsquad.members[0].no_takeover = 1;

  foreach(tur in tursquad.members)
  tur.no_takeover = 1;

  maps\_so_rts_event::trigger_event("dlg_switch_soldier_fps");
  level thread nag_until_notify(15, "tact_control_done");
  level notify("tact_target");
  level waittill("tact_target_ready");

  while(true) {
    if(isDefined(level.rts.targetteammate) && issubstr(level.rts.targetteammate.pkg_ref.ref, "infantry")) {
      break;
    }

    wait 0.05;
  }

  level notify("tact_control");
  level waittill("tact_control_ready");
  flag_set("rts_mode_locked_out");
  flag_clear("fps_mode_locked_out");

  while(true) {
    if(isDefined(level.rts.player.ally) && issubstr(level.rts.player.ally.pkg_ref.ref, "infantry")) {
      break;
    }

    wait 0.05;
  }

  maps\_so_rts_event::trigger_event("dlg_switch_soldier_fps_ack");
  flag_set("unit_select_locked_out");
  flag_set("block_button_press");
  level notify("tact_control_done");
  level notify("tact_target_done");
  level waittill("tact_control_done_done");
  wait 3;
  maps\_so_rts_event::trigger_event("dlg_target_incomming");
  level notify("tact_targetasd");
  metalsquadid = maps\_so_rts_catalog::spawn_package("metalstorm_pkg", "axis", 0, ::metal_storm_target);
  flag_wait("target_is_ready");
  maps\_so_rts_event::trigger_event("dlg_target_arriving");
  level notify("tact_targetasd_done");
  level waittill("tact_targetasd_done_done");
  maps\_so_rts_event::trigger_event("dlg_test_tactical");
  level thread nag_until_notify(15, "tact_prompt2_done");
  flag_clear("rts_mode_locked_out");
  flag_clear("block_button_press");
  level notify("tact_prompt2");
  level waittill("tact_prompt2_ready");

  while(flag("fps_mode"))
    wait 0.05;

  flag_set("fps_mode_locked_out");
  flag_clear("unit_select_locked_out");
  level notify("tact_prompt2_done");
  level waittill("tact_prompt2_done_done");
  wait 3;
  maps\_so_rts_event::trigger_event("dlg_target_unit");
  level thread nag_until_notify(15, "tact_target_enemy");
  level notify("tact_enemy");
  level waittill("tact_enemy_ready");
  package_highlightunits(infsquad.id);

  while(true) {
    if(isDefined(level.rts.targetteamenemy) && issubstr(level.rts.targetteamenemy.pkg_ref.ref, "metalstorm")) {
      break;
    }

    wait 0.05;
  }

  level notify("tact_target_enemy");
  wait 0.05;
  maps\_so_rts_event::trigger_event("dlg_move_to_engage");
  level thread nag_until_notify(15, "tact_target_enemy_done");
  level waittill("squad_attack", target);
  level notify("metal_storm_target_practice");
  target.takedamage = 1;
  target.ignoreme = 0;
  ticks = 0;

  while(isDefined(level.rts.squads[metalsquadid].members[0])) {
    wait 0.05;
    ticks++;

    if(ticks == 100) {
      level notify("tact_target_enemy_done");
      wait 0.05;
      maps\_so_rts_event::trigger_event("dlg_move_all_engage");
      level thread nag_until_notify(15, "tact_alltarget_enemy_done");
      level waittill("tact_target_enemy_done_done");
      wait 1;
      level notify("tact_alltarget_enemy");
      level waittill("tact_alltarget_enemy_ready");
    }
  }

  level notify("tact_enemy_done");
  level notify("tact_target_enemy_done");
  level notify("tact_alltarget_enemy_done");
  level waittill("tact_enemy_done_done");
  flag_clear("fps_mode_locked_out");
  maps\_so_rts_event::trigger_event("dlg_last_infantry");
  level thread nag_until_notify(15, "inf_prompt_done");
  level notify("inf_prompt");
  level waittill("inf_prompt_ready");

  while(true) {
    if(isDefined(level.rts.player.ally) && issubstr(level.rts.player.ally.pkg_ref.ref, "infantry")) {
      break;
    }

    wait 0.05;
  }

  flag_set("rts_mode_locked_out");
  level notify("inf_prompt_done");
  level waittill("inf_prompt_done_done");
  wait 3;
  maps\_so_rts_event::trigger_event("dlg_last_infantry_move");
  level thread nag_until_notify(15, "inf_move_done");
  level notify("inf_move");
  level waittill("inf_move_ready");
  note = level waittill_any_return("squad_moved", "all_squads_move");
  level notify("inf_move_done");
  level waittill("inf_move_done_done");
  maps\_so_rts_event::trigger_event("dlg_looking_good");
  wait 3;

  if(note == "all_squads_move") {
    level notify("fps_move_single");
    level waittill("fps_move_single_ready");
    level notify("fps_unselect");
    inorange = 0;

    while(note == "all_squads_move" || level.rts.activesquad == 99) {
      note = level waittill_any_return("squad_moved", "all_squads_move");

      if(level.rts.activesquad == 99 && !inorange) {
        inorange = 1;
        level notify("fps_unselect_done");
        level waittill("fps_unselect_done_done");
        size = localized_text_size != 0 ? localized_text_size : -0.5;
        level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_UNSELECT", "fps_unselect", "fps_unselect_done", -30, size, (1, 0.84, 0.2));
        level thread drone_tutorialmsg(&"SO_TUT_MP_DRONE_UNSELECT_2", "fps_unselect", "fps_unselect_done", -60, size, (1, 0.84, 0.2));
        level notify("fps_unselect");
        level waittill("fps_unselect_ready");
      }
    }

    level notify("fps_move_single_done");
    level notify("fps_unselect_done");
    level waittill("fps_move_single_done_done");
  } else {
    maps\_so_rts_event::trigger_event("dlg_last_all_move");
    level thread nag_until_notify(15, "inf_all_move_done");
    level notify("inf_all_move");
    level waittill("all_squads_move");
    maps\_so_rts_event::trigger_event("dlg_last_all_move_ack");
    level notify("inf_all_move_done");
    level notify("fps_unselect_done");
    level waittill("inf_all_move_done_done");
  }

  maps\_so_rts_event::trigger_event("dlg_outro_alright");
  wait 3;
  maps\_so_rts_event::trigger_event("dlg_outro_goodwork");
  level notify("tut_done");
  set_objective(level.obj_tutorial, undefined, "done");
  wait 2;
  level notify("tut_done_done");
  level waittill("tut_done_done_done");
  level notify("tutorial_complete");
}

metal_storm_target_think(squadid) {
  wait 0.2;
  self.health = 1500;

  foreach(guy in level.rts.squads[squadid].members) {
    guy.ignoreall = 1;
    guy.ignoreme = 1;
    guy.takedamage = 0;
  }

  flag_set("target_is_ready");
  level waittill("metal_storm_target_practice");
  spot = getent("asd_movespot", "targetname");
  maps\_so_rts_squad::ordersquaddefend(spot.origin, squadid);

  foreach(guy in level.rts.squads[squadid].members) {
    if(isDefined(guy)) {
      guy.ignoreall = 1;
      guy.ignoreme = 1;
    }
  }
}

metal_storm_target(squadid) {
  foreach(guy in level.rts.squads[squadid].members) {
    guy.ignoreall = 1;
    guy.ignoreme = 1;
    guy.takedamage = 0;
  }

  thread metal_storm_target_think(squadid);
}

dronecodespawner(pkg_ref, team, callback, squadid) {
  if(pkg_ref.ref == "infantry_ally_reg_pkg") {
    spot = getent("squad_1_loc", "targetname");
    squadid = maps\_so_rts_ai::spawn_ai_package_standard(pkg_ref, team, undefined, spot.origin);
    maps\_so_rts_squad::reissuesquadlastorders(squadid);

    foreach(guy in level.rts.squads[squadid].members)
    guy.allow_oob = 1;
  } else if(pkg_ref.ref == "infantry_ally_reg2_pkg") {
    spot = getent("squad_2_loc", "targetname");
    squadid = maps\_so_rts_ai::spawn_ai_package_standard(pkg_ref, team, undefined, spot.origin);
    maps\_so_rts_squad::reissuesquadlastorders(squadid);

    foreach(guy in level.rts.squads[squadid].members)
    guy.allow_oob = 1;
  } else if(pkg_ref.ref == "bigdog_pkg") {
    spot = getstruct("bigdog_unit_start_point", "targetname");
    squadid = maps\_so_rts_ai::spawn_ai_package_standard(pkg_ref, team, undefined, spot.origin, 0);
    level.rts.squads[squadid].members[0] forceteleport(spot.origin, spot.angles);
    level.rts.squads[squadid].members[0] thread claw_think();
    maps\_so_rts_squad::reissuesquadlastorders(squadid);
  } else if(pkg_ref.ref == "turret_pkg") {
    ai_ref = level.rts.ai[pkg_ref.units[0]];
    squadid = maps\_so_rts_squad::createsquad(level.rts.allied_center.origin, team, pkg_ref);
    turrets = getentarray("sentry_turret_friendly", "targetname");

    foreach(turret in turrets) {
      turret.ai_ref = ai_ref;
      turret maps\_so_rts_squad::addaitosquad(squadid);
    }

    maps\_so_rts_catalog::units_delivered(team, squadid);
  }

  if(isDefined(callback))
    thread[[callback]](squadid);

  return squadid;
}

claw_think() {
  wait 1;
  self.goalradius = 64;
  spot = getstruct("claw_movespot", "targetname");
  self setgoalpos(spot.origin);
}