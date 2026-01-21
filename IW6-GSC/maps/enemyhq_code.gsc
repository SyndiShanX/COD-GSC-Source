/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\enemyhq_code.gsc
*****************************************************/

spawn_targetname_at_struct_targetname(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = common_scripts\utility::getstruct(var_1, "targetname");

  if(isDefined(var_2) && isDefined(var_3)) {
    var_2.origin = var_3.origin;

    if(isDefined(var_3.angles))
      var_2.angles = var_3.angles;

    var_4 = var_2 maps\_utility::spawn_ai();
    return var_4;
  }

  if(isDefined(var_2)) {
    var_4 = var_2 maps\_utility::spawn_ai();
    iprintlnbold("Add a script struct called: " + var_1 + " to spawn him in the correct location.");
    var_4 teleport(level.player.origin, level.player.angles);
    return var_4;
  }

  iprintlnbold("failed to spawn " + var_0 + " at " + var_1);
  return undefined;
}

array_spawn_targetname_allow_fail(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  var_3 = array_spawn_allow_fail(var_2, var_1);
  return var_3;
}

array_spawn_allow_fail(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_4.count = 1;
    var_5 = var_4 maps\_utility::spawn_ai(var_1);

    if(isDefined(var_5))
      var_2[var_2.size] = var_5;
  }

  return var_2;
}

init_color_trigger_listeners(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1) {
    if(!isDefined(level.payback_color_trigger_disable_previous))
      level.payback_color_trigger_disable_previous = [];

    level.payback_color_trigger_disable_previous[var_0] = 1;
  }

  var_2 = getEntArray(var_0, "script_noteworthy");

  foreach(var_4 in var_2) {
    if(var_1) {
      var_5 = strtok(var_4.targetname, "_");
      var_6 = var_5[var_5.size - 1];
      var_4.payback_color_value = int(var_6);
    }

    var_4 thread ehq_color_trigger_listener();
  }
}

ehq_color_trigger_listener() {
  self endon("disable_trigger");
  self.payback_color_trigger_active = 1;
  self waittill("trigger");
  var_0 = [];

  if(isDefined(level.payback_color_trigger_disable_previous) && isDefined(level.payback_color_trigger_disable_previous[self.script_noteworthy])) {
    var_1 = getEntArray(self.script_noteworthy, "script_noteworthy");

    foreach(var_3 in var_1) {
      if(var_3.payback_color_trigger_active && var_3.payback_color_value <= self.payback_color_value) {
        var_0[var_0.size] = var_3;
        var_3.payback_color_trigger_active = 0;
      }
    }
  } else
    var_0 = getEntArray(self.targetname, "targetname");

  foreach(var_3 in var_0) {
    var_3 notify("disable_trigger");
    var_3 common_scripts\utility::trigger_off();
  }
}

retreat_from_vol_to_vol(var_0, var_1, var_2, var_3) {
  var_4 = getent(var_0, "targetname");
  var_5 = var_4 maps\_utility::get_ai_touching_volume("axis");
  var_6 = getent(var_1, "targetname");
  var_7 = getnode(var_6.target, "targetname");

  foreach(var_9 in var_5) {
    if(isDefined(var_9) && isalive(var_9)) {
      var_9.forcegoal = 0;
      var_9.fixednode = 0;
      var_9.pathrandompercent = randomintrange(75, 100);
      var_9 setgoalnode(var_7);
      var_9 setgoalvolumeauto(var_6);
    }
  }
}

wait_goal() {
  self waittill("goal");
  self.ignoreall = 0;
}

ai_array_killcount_flag_set(var_0, var_1, var_2, var_3) {
  maps\_utility::waittill_dead_or_dying(var_0, var_1, var_3);
  common_scripts\utility::flag_set(var_2);
}

d_dialogue_queue(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = self.script_friendname;

  iprintlnbold(var_1 + ": " + var_0);
}

die_quietly() {
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield == 1)
    maps\_utility::stop_magic_bullet_shield();

  self.no_pain_sound = 1;
  self.diequietly = 1;
  maps\_utility::die();
}

set_move_rate(var_0) {
  self.moveplaybackrate = var_0;
  self.movetransitionrate = var_0;
}

safe_activate_trigger_with_targetname(var_0) {
  var_1 = 64;
  var_2 = getent(var_0, "targetname");

  if(isDefined(var_2) && !isDefined(var_2.trigger_off)) {
    var_2 maps\_utility::activate_trigger();

    if(isDefined(var_2.spawnflags) && var_2.spawnflags &var_1)
      var_2 common_scripts\utility::trigger_off();
  }
}

safe_activate_triggers_with_targetname(var_0, var_1) {
  var_2 = 64;

  if(!isDefined(var_1))
    var_1 = 0;

  var_3 = getEntArray(var_0, "targetname");

  if(!isDefined(level.atrium_player_outside))
    level.atrium_player_outside = 0;

  foreach(var_5 in var_3) {
    if(isDefined(var_5) && !isDefined(var_5.trigger_off)) {
      var_6 = 1;

      if(var_1) {
        if(isDefined(var_5.script_parameters)) {
          if(level.atrium_player_outside == 1 && var_5.script_parameters == "inside" || level.atrium_player_outside == 0 && var_5.script_parameters == "outside")
            var_6 = 0;
        }
      }

      if(var_6)
        var_5 maps\_utility::activate_trigger();

      if(isDefined(var_5.spawnflags) && var_5.spawnflags &var_2)
        var_5 common_scripts\utility::trigger_off();
    }
  }
}

safe_disable_trigger_with_targetname(var_0) {
  var_1 = getent(var_0, "targetname");

  if(isDefined(var_1))
    var_1 common_scripts\utility::trigger_off();
}

safe_delete_trigger_with_targetname(var_0) {
  var_1 = getent(var_0, "targetname");

  if(isDefined(var_1))
    var_1 delete();
}

set_flag_on_killcount(var_0, var_1, var_2, var_3) {
  maps\_utility::waittill_dead_or_dying(var_0, var_1);
  common_scripts\utility::flag_set(var_2);
}

radio_dialog_add_and_go(var_0, var_1) {
  maps\_utility::radio_add(var_0);
  maps\_utility::radio_dialogue(var_0, var_1);
}

char_dialog_add_and_go(var_0) {
  level.scr_sound[self.animname][var_0] = var_0;
  maps\_utility::dialogue_queue(var_0);
}

raven_player_can_see_ai(var_0, var_1) {
  var_2 = gettime();

  if(!isDefined(var_1))
    var_1 = 0;

  if(isDefined(var_0.playerseesmetime) && var_0.playerseesmetime + var_1 >= var_2)
    return var_0.playerseesme;

  var_0.playerseesmetime = var_2;

  if(!common_scripts\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, 0.766)) {
    var_0.playerseesme = 0;
    return 0;
  }

  var_3 = level.player getEye();
  var_4 = var_0.origin;

  if(sighttracepassed(var_3, var_4, 0, level.player)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_5 = var_0 getEye();

  if(sighttracepassed(var_3, var_5, 0, level.player)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_6 = (var_5 + var_4) * 0.5;

  if(sighttracepassed(var_3, var_6, 0, level.player)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_0.playerseesme = 0;
  return 0;
}

debug_show_ai_counts() {
  level notify("end_debug_counts");
  level endon("end_debug_counts");
  level.osprey_debug_ai = 1;
  var_0 = -1;
  var_1 = -1;

  while(level.osprey_debug_ai) {
    var_2 = getaiarray("axis");
    var_3 = getaiarray("allies");

    if(var_0 != var_2.size || var_1 != var_3.size) {
      iprintln("Ax:" + var_2.size + " Al:" + var_3.size);
      var_0 = var_2.size;
      var_1 = var_3.size;
    }

    wait 0.05;
  }
}

ambient_animate(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = undefined;

  if(!isDefined(var_3))
    var_3 = 1;

  if(isDefined(var_2) && var_2 == 1)
    var_6 = maps\_utility::dronespawn_bodyonly(self);
  else {
    var_2 = 0;
    var_6 = maps\_utility::spawn_ai();
  }

  if(isDefined(var_6)) {
    var_6 endon("death");

    if(var_2 == 0) {
      if(isDefined(var_1))
        var_6 thread prepare_to_be_shot(var_1, var_3);

      var_6 maps\_utility::set_allowdeath(1);
    }

    if(isDefined(self.animation)) {
      var_6.animname = "generic";

      if(var_2 == 0 && var_3 == 1)
        var_6 maps\_utility::set_generic_idle_anim("scientist_idle");

      if(isDefined(self.target)) {
        var_4 = common_scripts\utility::getstruct(self.target, "targetname");

        if(!isDefined(var_4))
          var_5 = getnode(self.target, "targetname");

        if(isDefined(var_4))
          var_4 thread maps\_anim::anim_generic_loop(var_6, self.animation);

        if(isDefined(var_5)) {
          var_6 maps\_utility::disable_arrivals();
          var_6 maps\_utility::disable_turnanims();
          var_6 maps\_utility::disable_exits();
          var_6 maps\_utility::set_run_anim(self.animation);

          if(isDefined(var_0) && var_0 == 1)
            var_6 thread delete_on_complete(1);
        }
      } else if(isarray(level.scr_anim["generic"][self.animation]))
        var_6 thread maps\_anim::anim_generic_loop(var_6, self.animation);
      else {
        var_6 maps\_utility::disable_turnanims();
        var_6.ignoreall = 1;

        if(var_2 == 0)
          var_6.allowdeath = 1;

        var_6 thread maps\_anim::anim_single_solo(var_6, self.animation);

        if(isDefined(var_0) && var_0 == 1)
          var_6 thread delete_on_complete(0);
      }
    }
  }

  return var_6;
}

physics_fountain(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = length(var_2);
  var_9 = vectornormalize(var_2);
  var_1 endon("death");

  if(!isDefined(level.phys_fountain))
    level.phys_fountain = [];

  while(var_6 > 0) {
    var_10 = rotatevector(var_9, var_1.angles);
    var_10 = var_10 * var_8 + var_1.origin;
    var_11 = rotatevector(var_3, var_1.angles) * var_7;
    var_12 = spawn("script_model", var_10);
    var_12.angles = (0, 0, 0);
    var_12 setModel(var_0);
    var_12 physicslaunchclient(var_10, var_11);
    thread cleanup_phys_obj(var_12, var_5);
    wait(var_4);
    var_6--;
  }
}

cleanup_phys_obj(var_0, var_1) {
  wait(var_1);
  var_0 delete();
}

delete_on_complete(var_0) {
  if(!var_0) {
    self waittillmatch("single anim", "end");
    self notify("killanimscript");
  } else
    self waittill("reached_path_end");

  if(!raven_player_can_see_ai(self))
    self delete();
}

hint_blow_charges_wait() {
  if(common_scripts\utility::flag(level.c4_cancel_flag))
    return 1;

  return 0;
}

sniperuse_hint_wait() {
  if(common_scripts\utility::flag(level.sniper_cancel_flag))
    return 1;

  return 0;
}

sniper_hint(var_0, var_1) {
  wait(var_1);

  if(!common_scripts\utility::flag(var_0)) {
    level.sniper_cancel_flag = var_0;
    thread maps\_utility::display_hint("sniperuse_hint");
  }
}

c4_hint(var_0, var_1) {
  wait(var_1);

  if(!common_scripts\utility::flag(var_0)) {
    level.c4_cancel_flag = var_0;
    thread maps\_utility::display_hint("blow_charges");
  }
}

do_nag_dialog(var_0, var_1) {
  if(isstring(var_0))
    thread maps\_utility::add_dialogue_line(var_0, var_1);
  else if(var_0 == level.player)
    radio_dialog_add_and_go(var_1);
  else
    var_0 char_dialog_add_and_go(var_1);
}

nag_player_until_flag(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("death");
  var_6 = maps\_utility::make_array(var_2, var_3, var_4, var_5);
  do_nag_dialog(var_0, var_6[0]);
  var_7 = 1;
  var_8 = 4;
  wait(var_8);

  while(!common_scripts\utility::flag(var_1)) {
    do_nag_dialog(var_0, var_6[var_7]);
    var_8 = var_8 * 2;
    var_7++;

    if(!isDefined(var_6[var_7]))
      var_7 = 0;

    wait(var_8);
  }
}

prepare_to_be_shot(var_0, var_1) {
  self endon("death");
  level waittill(var_0);
  self.ignoreme = 0;
  self.ignoreall = 0;
  maps\_utility::anim_stopanimscripted();

  if(var_1 == 1)
    maps\_utility::set_generic_idle_anim("scientist_idle");

  maps\_utility::enable_arrivals();
  maps\_utility::enable_exits();
  maps\_utility::enable_turnanims();
}

reassign_goal_volume(var_0, var_1) {
  if(!isarray(var_0))
    var_0 = maps\_utility::make_array(var_0);

  var_0 = maps\_utility::array_removedead_or_dying(var_0);
  var_2 = getent(var_1, "targetname");

  foreach(var_4 in var_0)
  var_4 setgoalvolumeauto(var_2);
}

set_black_fade(var_0, var_1, var_2) {
  level endon("set_black_fade");

  if(isDefined(var_2) && var_2) {
    while(level.player maps\_utility::issliding())
      wait 0.05;
  }

  if(!isDefined(var_0))
    var_0 = 1;

  var_0 = max(0.0, min(1.0, var_0));

  if(!isDefined(var_1))
    var_1 = 1;

  var_1 = max(0.01, var_1);

  if(!isDefined(level.hud_black)) {
    level.hud_black = newhudelem();
    level.hud_black.x = 0;
    level.hud_black.y = 0;
    level.hud_black.horzalign = "fullscreen";
    level.hud_black.vertalign = "fullscreen";
    level.hud_black.foreground = 1;
    level.hud_black.sort = -999;
    level.hud_black setshader("black", 650, 490);
    level.hud_black.alpha = 0.0;
  }

  level.hud_black fadeovertime(var_1);
  level.hud_black.alpha = max(0.0, min(1.0, var_0));

  if(var_0 <= 0) {
    wait(var_1);
    level.hud_black destroy();
    level.hud_black = undefined;
  }
}

setupplayerforanimations(var_0) {
  if(!isDefined(var_0))
    var_0 = "stand";

  if(level.player isthrowinggrenade())
    wait 1.2;

  level.player disableweapons();
  level.player allowjump(0);
  level.player allowmelee(0);
  level.player disableoffhandweapons();
  level.player allowsprint(0);
  level.player allowads(0);

  if(var_0 != "stand")
    level.player allowstand(0);

  if(var_0 != "crouch")
    level.player allowcrouch(0);

  if(var_0 != "prone")
    level.player allowprone(0);

  if(level.player getstance() != var_0) {
    level.player setstance(var_0);
    wait 0.4;
  }
}

setupplayerforgameplay() {
  level.player allowsprint(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowstand(1);
  level.player enableoffhandweapons();
  level.player allowmelee(1);
  level.player allowads(1);
  level.player allowjump(1);
  level.player enableweapons();
}

keegan_swap_head_to_mask() {
  self detach(self.headmodel, "");
  self attach("head_hesh_stealth_z", "", 1);
  self.headmodel = "head_hesh_stealth_z";
}

player_enter_truck_progression(var_0) {
  var_1 = getent("TRIG_get_in_truck", "targetname");
  var_1 sethintstring(&"ENEMY_HQ_GETINTRUCK");
  var_2 = common_scripts\utility::getstruct("STRUCT_get_in_truck", "targetname");
  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_1, var_2);
  common_scripts\utility::flag_set("FLAG_player_enter_truck");
  thread keegan_enter_truck_scene();
  level.player setstance("stand");
  level.player allowcrouch(0);
  player_enter_truck_func(var_0);
}

keegan_enter_truck_scene() {
  common_scripts\utility::flag_wait("FLAG_keegan_start_mask_anim");
  level.player_truck notify("stop_keegan_loop");
  level.player_truck maps\_anim::anim_single_solo(level.allies[1], "enter_truck", "tag_driver");
  level.player_truck thread maps\_anim::anim_loop_solo(level.allies[1], "enter_truck_loop", "stop_keegan_loop", "tag_driver");
}

vehicle_play_guy_anim(var_0, var_1, var_2, var_3) {
  var_4 = maps\_vehicle_aianim::anim_pos(self, var_2);
  var_5 = var_1 maps\_utility::getanim(var_0);
  var_1 notify("newanim");
  var_1 endon("newanim");
  var_1 endon("death");
  maps\_anim::anim_single_solo(var_1, var_0, var_4.sittag);

  if(!isDefined(var_3) || var_3 == 1)
    maps\_vehicle_aianim::guy_idle(var_1, var_2);
}

player_enter_truck_func(var_0) {
  level notify("end_truck_nag");
  thread maps\enemyhq_audio::aud_truck_enter();
  thread maps\enemyhq_intro::spawn_trucks();
  thread maps\_utility::autosave_now();
  level.player enabledeathshield(1);
  level.player allowsprint(0);
  thread maps\enemyhq_atrium::wall_chunks_hide();
  var_1 = common_scripts\utility::getstruct("player_teleport_atrium", "targetname");
  level.truck_player_arms = maps\_utility::spawn_anim_model("player_rig");
  level.truck_player_arms.animname = "player_rig";
  level.grenades = level.player getweaponammoclip("fraggrenade");
  level.player takeweapon("fraggrenade");
  setsaveddvar("ammoCounterHide", 1);
  level.player disableweaponswitch();
  level.player giveweapon("test_detonator_black_ice", 0, 0, 0, 1);
  level.player setweaponammoclip("test_detonator_black_ice", 0);
  level.player switchtoweapon("test_detonator_black_ice");
  level.player givemaxammo("sc2010+reflex_sp");
  level.player disableweapons();
  level.truck_player_arms.animname = "player_rig";
  var_0.animname = "truck";
  level.truck_player_arms setModel("viewhands_player_us_rangers");
  level.truck_player_arms hide();
  level.truck_player_arms linkto(var_0, "tag_passenger");
  level.truck_player_arms thread maps\_anim::anim_first_frame_solo(level.truck_player_arms, "player_enter_truck");
  level.player playerlinktoblend(level.truck_player_arms, "tag_player", 0.5);
  level.player forcemovingplatformentity(var_0);
  var_0 thread maps\_anim::anim_single_solo(level.truck_player_arms, "player_enter_truck", "tag_passenger");
  var_0 thread maps\_anim::anim_single_solo(var_0, "player_enter_truck");
  wait 0.25;
  level.player playerlinktoabsolute(level.truck_player_arms, "tag_player");
  level.truck_player_arms show();
  wait 2.5;
  level.player playerlinktodelta(level.truck_player_arms, "tag_player", 1, 15, 15, 15, 15, 1);
  level.truck_player_arms waittillmatch("single anim", "end");
  level.player playerlinktodelta(level.truck_player_arms, "tag_player", 1, 115, 15, 27, 15);
  level.truck_player_arms hide();
  common_scripts\utility::flag_wait("bring_up_clacker");
  level notify("bring_up_clacker");
  c4_hint("FLAG_clacked_the_clacker", 0.5);
  level.player disableweaponswitch();
  thread call_flag_when_clacked();
  level.player enableweapons();
  level.player_truck thread listen_player_jolt_vehicles();
  thread call_jolt_by_flag();
  level.dog thread maps\enemyhq_intro::dog_additional_drivein_anims();
  setsaveddvar("ammoCounterHide", 1);
  level.player waittill("detonate");
  common_scripts\utility::flag_set("FLAG_blow_sticky_01");
  common_scripts\utility::flag_wait("FLAG_player_bust_windshield");
  level.player setstance("stand");
  level.player allowcrouch(0);
  screenshake(level.player.origin, 7, 2, 4, 1.25, 0, 0.15, 500, 3, 3, 4, 1.1);
  thread play_rumble_seconds("damage_heavy", 1);
  thread maps\enemyhq_audio::aud_bust_windshield();
  var_2 = spawn("script_model", level.truck_player_arms gettagorigin("tag_weapon_right"));
  var_2.angles = level.truck_player_arms gettagangles("tag_weapon_right");
  var_2 linkto(level.truck_player_arms, "tag_weapon_right");
  var_2 setModel("weapon_sc2010");
  var_3 = spawn("script_model", var_2 gettagorigin("tag_red_dot"));
  var_3 setModel("viewmodel_reddot_reflex_iw6");
  var_3.origin = var_2 gettagorigin("tag_red_dot");
  var_3.angles = var_2 gettagangles("tag_red_dot");
  var_3 linkto(var_2, "tag_red_dot");
  var_4 = [];
  var_4[0] = level.truck_player_arms;
  var_4[1] = var_0;
  level.truck_player_arms show();
  var_0 thread maps\_anim::anim_single_solo(var_4[0], "player_smash_windshield", "tag_passenger");
  level.player playerlinktodelta(level.truck_player_arms, "tag_player", 0.2, 5, 5, 5, 5, 1);
  var_0 setflaggedanimrestart("vehicle_anim_flag", var_0 maps\_utility::getanim("player_smash_windshield"));
  var_0 clearanim(var_0 maps\_utility::getanim("player_enter_truck"), 0.2);
  var_4[0] waittillmatch("single anim", "end");
  level.player playerlinktodelta(level.truck_player_arms, "tag_player", 0.2, 45, 45, 27, 10, 1);
  common_scripts\utility::flag_set("FLAG_blow_sticky_03");
  level.player takeweapon("test_detonator_black_ice");
  level.player enableweapons();
  level.player switchtoweaponimmediate("sc2010+reflex_sp");
  level.player givemaxammo("sc2010+reflex_sp");
  level.truck_player_arms hide();
  common_scripts\utility::flag_set("FLAG_player_gun_up");
  common_scripts\utility::waitframe();
  level.player enableweapons();
  level.player switchtoweaponimmediate("sc2010+reflex_sp");
  setsaveddvar("ammoCounterHide", 0);
  var_2 delete();

  if(isDefined(var_3))
    var_3 delete();

  common_scripts\utility::flag_wait("FLAG_truck_exploder_start");
  common_scripts\utility::flag_wait("FLAG_start_pathblockers");
  common_scripts\utility::flag_wait("FLAG_stop_hit_reactions");
  level.player disableweapons();
  thread player_bust_thru_scene(var_1, var_0);
  common_scripts\utility::flag_wait("drive_in_done");
  level.player enableweaponswitch();
  level notify("end_jolt_vehicles_thread");
  common_scripts\utility::waitframe();
  level.player_truck thread listen_player_jolt_jumps();
}

call_flag_when_clacked() {
  level.player waittill("detonate");
  level notify("c4_detonated");
  common_scripts\utility::flag_set("FLAG_clacked_the_clacker");
}

player_enter_truck_atrium_startpoint(var_0) {
  var_1 = common_scripts\utility::getstruct("player_teleport_atrium", "targetname");
  level.truck_player_arms = maps\_utility::spawn_anim_model("player_rig");
  level.truck_player_arms.animname = "player_rig";
  var_0.animname = "truck";
  level.truck_player_arms linkto(var_0, "tag_passenger");
  level.player playerlinktodelta(level.truck_player_arms, "tag_player", 1, 70, 70, 35, 35, 1);
  level.player disableweapons();
  level.truck_player_arms setModel("viewhands_player_us_rangers");
  level.truck_player_arms hide();
  thread player_bust_thru_scene(var_1, var_0);
}

player_bust_thru_scene(var_0, var_1) {
  common_scripts\utility::flag_wait("FLAG_bust_thru_prep");
  level.player setweaponammoclip("sc2010+reflex_sp", 30);
  level.player givemaxammo("sc2010+reflex_sp");
  level.player enabledeathshield(0);
  level.player enableinvulnerability();
  level notify("drive_in_done");
  wait 0.05;
  common_scripts\utility::flag_set("drive_in_done");
  var_2 = maps\_utility::get_ai_group_ai("field_chaos_guys");

  foreach(var_4 in var_2)
  var_4 delete();

  level.truck_player_arms show();
  level.player_truck maps\_vehicle::vehicle_stop_named("atrium_truck_stop", 1, 1);
  level.player playerlinktodelta(level.truck_player_arms, "tag_player", 1, 17, 10, 8, 8, 1);
  var_1 thread maps\_anim::anim_single_solo(level.truck_player_arms, "bust_thru_prep", "tag_passenger");
  level.allies[0] thread char_dialog_add_and_go("enemyhq_mrk_comininhot");
  thread play_rumble_seconds("damage_heavy", 2.5);
  common_scripts\utility::flag_wait("kick_off_atrium_combat");
  level.player disableweapons();
  level.truck_player_arms unlink();
  thread maps\enemyhq_audio::aud_exit_truck();
  var_0 maps\_anim::anim_single_solo(level.truck_player_arms, "bust_thru");
  common_scripts\utility::flag_set("FLAG_player_exit_truck");
  level.player maps\_utility::set_ignoreme(0);
  level.truck_player_arms delete();
  level.allies[0] thread char_dialog_add_and_go("enemyhq_mrk_bishopisthroughthis");
  level.player allowcrouch(1);
  level.player allowsprint(1);
  level notify("end_jolt_jumps_thread");
  thread dog_hint();
  thread handle_hesh_teleport();
  level notify("player_exited_truck");
  level.player disableweapons();
  common_scripts\utility::trigger_off("TRIG_player_exit_truck", "targetname");
  level.player enableweapons();
  level.player switchtoweaponimmediate("sc2010+reflex_sp");
  level.player unlink();
  level.player forcemovingplatformentity(undefined);
  level.player giveweapon("fraggrenade");
  level.player setweaponammoclip("fraggrenade", level.grenades);
  thread maps\enemyhq_atrium::wall_chunks_show();
  wait 3;
  level.player disableinvulnerability();
}

dog_hint_check() {
  return 0;
}

dog_hint() {
  common_scripts\utility::flag_wait("FLAG_atrium_dog_hint");
  thread maps\_utility::display_hint_timeout("riley_hint", 3);
}

handle_hesh_teleport() {
  var_0 = getnode("NODE_ally2_teleport_atrium", "targetname");
  level.allies[2] unlink();
  level.player_truck notify("stop_baker_loop");
  level.allies[2] maps\_utility::anim_stopanimscripted();
  common_scripts\utility::waitframe();
  level.allies[2] forceteleport(var_0.origin, var_0.angles);
}

listen_player_press_x() {
  level endon("player_exited_truck");

  for(;;) {
    if(level.player usebuttonpressed())
      common_scripts\utility::flag_set("FLAG_player_exit_truck");

    wait 0.05;
  }
}

turn_exit_trigger_on() {
  wait 4;
  common_scripts\utility::trigger_on("TRIG_player_exit_truck", "targetname");
}

create_overlay_element(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = 0;
  var_2.y = 0;
  var_2 setshader(var_0, 640, 480);
  var_2.alignx = "left";
  var_2.aligny = "top";
  var_2.horzalign = "fullscreen";
  var_2.vertalign = "fullscreen";
  var_2.alpha = var_1;
  var_2.foreground = 1;
  var_2.sort = 2;
  return var_2;
}

restore_ignoreme(var_0) {
  self endon("death");
  self endon("dog_attacks_ai");
  var_0 waittill("cancel_attack");
  self setthreatbiasgroup("axis");
}

dog_command_attack(var_0, var_1) {
  var_0.ignoreme = 0;
  var_0 setthreatbiasgroup("dog_targets");
  var_0 thread restore_ignoreme(self);
  self.favoriteenemy = var_0;
  self.ignoreall = 0;
  self getenemyinfo(var_0);
  self setgoalentity(var_0);
  var_2 = var_0 common_scripts\utility::waittill_any_return("dog_attacks_ai", "death");
  return var_2;
}

dog_attack_targets_by_priority(var_0, var_1, var_2) {
  level endon("death");

  if(!isDefined(var_2))
    var_2 = 0;

  for(var_3 = 0; !common_scripts\utility::flag(var_1) && var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(isDefined(var_4)) {
      if(level.dog dog_command_attack(var_4, level.player) == "dog_attacks_ai") {
        if(var_2 == 0)
          return;
      }
    }
  }
}

handle_dog_modes() {
  level endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(var_0 == level.dog) {
      common_scripts\utility::trigger_off();

      switch (self.targetname) {
        case "start_dog_sniffing":
          if(isDefined(self.target)) {
            var_1 = getnode(self.target, "targetname");
            var_0 maps\_utility_dogs::enable_dog_sniff();
            wait 0.1;
            var_0 setgoalnode(var_1);
          } else if(level.dog dog_using_colors()) {
            var_2 = var_0.pathgoalpos;

            if(!isDefined(var_2))
              var_2 = var_0.goalpos;

            var_0 maps\_utility::disable_ai_color();
            var_0 setgoalpos(var_0.origin + anglesToForward(var_0.angles) * 24);
            var_0 maps\_utility_dogs::enable_dog_sniff();
            wait 0.1;
            var_0 setgoalpos(var_2);
            var_0 maps\_utility::enable_ai_color();
          } else
            var_0 maps\_utility_dogs::enable_dog_sniff();

          var_0 notify("start_sniffing");
          break;
        case "stop_dog_sniffing":
          if(isDefined(self.target)) {
            var_1 = getnode(self.target, "targetname");
            var_0 maps\_utility_dogs::disable_dog_sniff();
            wait 0.1;
            var_0 setgoalnode(var_1);
          } else if(level.dog dog_using_colors()) {
            var_2 = var_0.pathgoalpos;
            var_0 maps\_utility::disable_ai_color();
            var_0 setgoalpos(var_0.origin + anglesToForward(var_0.angles) * 24);
            var_0 maps\_utility_dogs::disable_dog_sniff();
            wait 0.1;
            var_0 setgoalpos(var_2);
            var_0 maps\_utility::enable_ai_color();
          } else
            var_0 maps\_utility_dogs::disable_dog_sniff();

          var_0 notify("stop_sniffing");
          break;
        case "start_dog_sneak":
          var_0 maps\_utility_dogs::enable_dog_sneak();
          var_0 notify("start_sneaking");
          break;
        case "stop_dog_sneak":
          var_0 maps\_utility_dogs::disable_dog_sneak();
          var_0 notify("stop_sneaking");
          break;
      }
    }
  }
}

toggle_ally_outlines(var_0) {}

listen_player_jolt_vehicles() {
  level endon("end_jolt_vehicles_thread");

  for(;;) {
    self waittill("veh_jolt", var_0);
    thread screen_shake_vehicles();
    thread reaction_anims();
    wait 2;
  }
}

call_jolt_by_flag() {
  for(;;) {
    common_scripts\utility::flag_wait("veh_jolt");
    level.player_truck notify("veh_jolt");
    common_scripts\utility::flag_clear("veh_jolt");
    wait 0.05;
  }
}

listen_player_jolt_jumps() {
  level endon("end_jolt_jumps_thread");

  for(;;) {
    self waittill("veh_jolt", var_0);
    thread screen_shake_jumps();
  }
}

debug_jolt_jumps() {
  level endon("end_jolt_jumps_thread");

  for(;;) {
    wait 0.25;
    iprintln("running jumps thread");
  }
}

debug_jolt_vehs() {
  level endon("end_jolt_vehicles_thread");

  for(;;) {
    wait 0.25;
    iprintln("running vehs thread");
  }
}

#using_animtree("player");

reaction_anims() {
  var_0 = [];
  var_0[0] = level.allies[1];
  level.truck_player_arms setanim(%ehq_truck_drivein_hit_player, 0.9, 1, 1);
}

screen_shake_vehicles() {
  thread maps\enemyhq_audio::aud_vehicle_jolt();
  thread play_rumble_seconds("damage_heavy", 2);
  screenshake(level.player.origin, 6, 2, 15, 2, 0, 1.25, 500, 5, 3, 7, 1.1);
}

screen_shake_jumps() {
  thread maps\enemyhq_audio::aud_screen_shake_jumps();
  thread play_rumble_seconds("damage_heavy", 1);
}

screenshakefade(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = var_1 * 10;
  var_5 = var_2 * 10;

  if(var_5 > 0)
    var_6 = var_0 / var_5;
  else
    var_6 = var_0;

  var_7 = var_3 * 10;
  var_8 = var_4 - var_7;

  if(var_7 > 0)
    var_9 = var_0 / var_7;
  else
    var_9 = var_0;

  var_10 = 0.1;
  var_0 = 0;

  for(var_11 = 0; var_11 < var_4; var_11++) {
    if(var_11 <= var_5)
      var_0 = var_0 + var_6;

    if(var_11 > var_8)
      var_0 = var_0 - var_9;

    earthquake(var_0, var_10, level.player.origin, 500);
    wait(var_10);
  }
}

play_rumble_seconds(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1 * 20; var_2++) {
    level.player playrumbleonentity(var_0);
    wait 0.05;
  }
}

delete_ai_at_path_end() {
  self endon("death");
  self waittill("reached_path_end");
  delete_ai();
}

ignoreall_false_at_path_end() {
  self endon("death");
  self waittill("reached_path_end");
  self.ignoreall = 0;
}

delete_ai() {
  var_0[0] = self;
  level thread maps\_utility::ai_delete_when_out_of_sight(var_0, 512);
}

carry_bishop() {
  wait 0.05;
  self.moveplaybackrate = 1;
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  maps\_utility::disable_cqbwalk();
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.nododgemove = 1;
  maps\_utility::pathrandompercent_set(0);
  self pushplayer(1);
  self.dontmelee = 1;
  self.ignorerandombulletdamage = 1;
  maps\_utility::disable_danger_react();
  maps\_utility::setflashbangimmunity(1);
  self.dontavoidplayer = 1;
  self.badplaceawareness = 0;
  self.disableplayeradsloscheck = 1;
  maps\_utility::disable_surprise();
  maps\_utility::disable_careful();
  ignore_everything();
  self.disablefriendlyfirereaction = 1;
  maps\_utility::set_generic_run_anim("wounded_carry_carrier", 1);
  maps\_utility::set_idle_anim("wounded_carry_idle");
  thread maps\_anim::anim_generic_loop(level.bishop, "wounded_carry_wounded", "stop_anim", "tag_origin");
  level.bishop linkto(self, "tag_origin");
  thread sync_carry_walk_anims();
}

#using_animtree("generic_human");

sync_carry_walk_anims() {
  self endon("stop_anim");
  level.bishop endon("stop_anim");

  while(isDefined(self) && isDefined(level.bishop)) {
    var_0 = self getanimtime(%wounded_carry_fastwalk_carrier);

    if(isDefined(var_0) && var_0 > 0)
      level.bishop setanimtime(%wounded_carry_fastwalk_wounded_relative, var_0);

    wait 0.05;
  }
}

ignore_everything() {
  self.ignoreall = 1;
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  maps\_utility::disable_pain();
  self.og_newenemyreactiondistsq = self.newenemyreactiondistsq;
  self.newenemyreactiondistsq = 0;
}

clear_ignore_everything() {
  self.ignoreall = 0;
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.fixednode = 1;
  self.disablebulletwhizbyreaction = 0;
  maps\_utility::enable_pain();

  if(isDefined(self.og_newenemyreactiondistsq))
    self.newenemyreactiondistsq = self.og_newenemyreactiondistsq;
}

gasmask_on_npc(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0)
    self attach("prop_sas_gasmask_attach", "j_head", 1);
  else {
    self.gasmask = spawn("script_model", (0, 0, 0));
    self.gasmask setModel("prop_sas_gasmask_attach");
    self.gasmask linkto(self, "tag_eye", (-4.027, 0, -2.948), (-90, -90, 180));
  }

  self.gasmask_on = 1;
}

bob_mask(var_0) {
  self endon("stop_mask_bob");
  var_1 = 0;
  var_2 = level.player getplayerangles();
  var_3 = 0;
  var_4 = 0;
  var_5 = 0.05;

  for(;;) {
    if(isDefined(var_0)) {
      var_6 = level.player getplayerangles();
      var_7 = level.player getvelocity();
      var_8 = var_7[2];
      var_7 = var_7 - var_7 * (0, 0, 1);
      var_9 = length(var_7);
      var_10 = level.player getstance();
      var_11 = clamp(var_9, 0, 280) / 280;
      var_12 = 0.1 + var_11 * 0.25;
      var_13 = 0.1 + var_11 * 0.25;
      var_14 = 1.0;

      if(var_10 == "crouch")
        var_14 = 0.75;

      if(var_10 == "prone")
        var_14 = 0.4;

      if(var_10 == "stand")
        var_14 = 1.0;

      var_15 = 5.0;
      var_16 = 0.9;
      var_17 = level.player playerads();
      var_18 = var_15 * (1.0 - var_17) + var_16 * var_17;
      var_18 = var_18 * (1 + var_11 * 2);
      var_19 = 5;
      var_20 = var_19 * var_12 * var_14;
      var_21 = var_19 * var_13 * var_14;
      var_1 = var_1 + var_5 * 1000.0 * var_18;
      var_22 = 57.2958;
      var_23 = sin(var_1 * 0.001 * var_22);
      var_24 = sin(var_1 * 0.0007 * var_22);
      var_25 = angleclamp180(var_6[1] - var_2[1]);
      var_25 = clamp(var_25, -10, 10);
      var_26 = var_25 / 10 * var_19 * (1 - var_12);
      var_27 = var_26 - var_4;
      var_4 = var_4 + clamp(var_27, -1.0, 1.0);
      var_28 = clamp(var_8, -200, 200) / 200 * var_19 * (1 - var_13);
      var_29 = var_28 - var_3;
      var_3 = var_3 + clamp(var_29, -0.6, 0.6);
      var_0 moveovertime(0.05);
      var_0.x = clamp(var_23 * var_20 + var_4 - var_19, 0 - 2 * var_19, 0);
      var_0.y = clamp(var_24 * var_21 + var_3 - var_19, 0 - 2 * var_19, 0);
      var_2 = var_6;
    }

    wait(var_5);
  }
}

gasmask_hud_on(var_0) {
  wait 0.333;

  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0) {
    set_black_fade(1.0, 0.25);
    wait 0.25;
  }

  common_scripts\utility::array_thread(level.allies, ::gasmask_on_npc);
  self.gasmask_hud_elem = newhudelem();
  self.gasmask_hud_elem.x = 0;
  self.gasmask_hud_elem.y = 0;
  self.gasmask_hud_elem.horzalign = "fullscreen";
  self.gasmask_hud_elem.vertalign = "fullscreen";
  self.gasmask_hud_elem.foreground = 0;
  self.gasmask_hud_elem.sort = -1;
  self.gasmask_hud_elem setshader("gasmask_overlay_delta2", 650, 490);
  self.gasmask_hud_elem.alpha = 1.0;
  self.gasmask_hud_elem.enablehudlighting = 1;

  if(var_0) {
    wait 0.25;
    set_black_fade(0.0, 0.25);
  }

  thread bob_mask(self.gasmask_hud_elem);
}

gasmask_hud_off(var_0) {
  wait 0.333;

  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0) {
    set_black_fade(1.0, 0.25);
    wait 0.25;
  }

  self notify("stop_mask_bob");
  self.gasmask_hud_elem destroy();
  self.gasmask_hud_elem = undefined;
  level.player notify("stop_breathing");

  if(var_0) {
    wait 0.25;
    set_black_fade(0.0, 0.25);
  }
}

gasmask_breathing() {
  var_0 = 1.0;
  self endon("stop_breathing");

  for(;;) {
    maps\_utility::play_sound_on_entity("pybk_breathing_gasmask");
    wait(var_0);
  }
}

gas_mask_on_player_anim() {
  level.player endon("death");
  thread maps\enemyhq_audio::aud_gas_mask_on();
  level.player disableweaponswitch();
  level.player disableusability();
  level.player disableoffhandweapons();
  setsaveddvar("ammoCounterHide", 1);
  wait 0.25;
  level.player.last_weapon = level.player getcurrentweapon();
  level.player disableweapons();
  wait 0.5;

  if(level.player.last_weapon == "alt_ak47_grenadier")
    level.player.last_weapon = "ak47_grenadier";

  if(level.player.last_weapon == "alt_m4m203_acog_payback")
    level.player.last_weapon = "m4m203_acog_payback";

  if(level.player.last_weapon == "alt_m4_grenadier")
    level.player.last_weapon = "m4_grenadier";

  var_0 = undefined;
  var_1 = undefined;

  if(level.player.last_weapon != "none") {
    var_0 = level.player getweaponammostock(level.player.last_weapon);
    var_1 = level.player getweaponammoclip(level.player.last_weapon);
  }

  level.player takeweapon(level.player.last_weapon);
  level.player giveweapon("scuba_mask_on");
  level.player enableweapons();
  level.player switchtoweapon("scuba_mask_on");
  level.player maps\_utility::delaythread(0.75, ::gasmask_hud_on);
  wait 2.5;
  level.player takeweapon("scuba_mask_on");
  level.player giveweapon(level.player.last_weapon, 0, 0, 0, 1);

  if(level.player.last_weapon != "none") {
    level.player setweaponammostock(level.player.last_weapon, var_0);
    level.player setweaponammoclip(level.player.last_weapon, var_1);
    level.player switchtoweapon(level.player.last_weapon);
  }

  level.player enableusability();
  level.player enableweaponswitch();
  level.player enableoffhandweapons();
  setsaveddvar("ammoCounterHide", 0);
}

gas_mask_off_player_anim() {
  level endon("death");
  level.player disableweaponswitch();
  level.player disableusability();
  level.player disableoffhandweapons();
  setsaveddvar("ammoCounterHide", 1);
  wait 0.25;
  level.player.last_weapon = level.player getcurrentweapon();
  level.player disableweapons();
  wait 0.5;

  if(level.player.last_weapon == "alt_ak47_grenadier")
    level.player.last_weapon = "ak47_grenadier";

  if(level.player.last_weapon == "alt_m4m203_acog_payback")
    level.player.last_weapon = "m4m203_acog_payback";

  if(level.player.last_weapon == "alt_m4_grenadier")
    level.player.last_weapon = "m4_grenadier";

  var_0 = undefined;
  var_1 = undefined;

  if(level.player.last_weapon != "none") {
    var_0 = level.player getweaponammostock(level.player.last_weapon);
    var_1 = level.player getweaponammoclip(level.player.last_weapon);
  }

  level.player takeweapon(level.player.last_weapon);
  level.player giveweapon("scuba_mask_off");
  level.player enableweapons();
  level.player switchtoweapon("scuba_mask_off");
  level.player maps\_utility::delaythread(0.02, ::gasmask_hud_off);
  wait 2.5;
  level.player takeweapon("scuba_mask_off");
  level.player giveweapon(level.player.last_weapon, 0, 0, 0, 1);

  if(level.player.last_weapon != "none") {
    level.player setweaponammostock(level.player.last_weapon, var_0);
    level.player setweaponammoclip(level.player.last_weapon, var_1);
    level.player switchtoweapon(level.player.last_weapon);
  }

  level.player enableusability();
  level.player enableweaponswitch();
  level.player enableoffhandweapons();
  setsaveddvar("ammoCounterHide", 0);
  maps\_utility::autosave_now();
}

get_killed(var_0) {
  if(!isalive(var_0)) {
    return;
  }
  if(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield == 1)
    var_0 maps\_utility::stop_magic_bullet_shield();

  var_0.allowdeath = 1;
  var_0.a.nodeath = 1;
  var_0 maps\_utility::set_battlechatter(0);
  var_0 kill();
}

corpse_setup(var_0, var_1, var_2) {
  var_3 = maps\_utility::spawn_ai(1);
  var_3 maps\_utility::gun_remove();
  var_3.animname = "generic";
  var_4 = var_3 maps\_utility::getanim(var_1);

  if(!isDefined(var_0))
    var_0 = self;

  var_0 maps\_anim::anim_generic_first_frame(var_3, var_1);
  var_5 = maps\_vehicle_aianim::convert_guy_to_drone(var_3);
  var_5 setanim(var_4, 1, 0.2);
  var_5 notsolid();

  if(isDefined(var_2)) {
    common_scripts\utility::flag_wait(var_2);
    var_5 delete();
  } else
    return var_5;
}

stream_waterfx(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  if(isDefined(var_1))
    var_2 = 1;

  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    level endon(var_0);
  }

  for(;;) {
    wait(randomfloatrange(0.15, 0.3));
    var_3 = self.origin + (0, 0, 150);
    var_4 = self.origin - (0, 0, 150);
    var_5 = bulletTrace(var_3, var_4, 0, undefined);

    if(var_5["surfacetype"] != "water") {
      continue;
    }
    var_6 = "water_movement";

    if(isplayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5)
        var_6 = "water_stop";
    } else if(isDefined(level._effect["water_" + self.a.movement]))
      var_6 = "water_" + self.a.movement;

    var_7 = common_scripts\utility::getfx(var_6);
    var_3 = var_5["position"];
    var_8 = (0, self.angles[1], 0);
    var_9 = anglesToForward(var_8);
    var_10 = anglestoup(var_8);
    playFX(var_7, var_3, var_10, var_9);

    if(var_6 != "water_stop" && var_2)
      thread common_scripts\utility::play_sound_in_space(var_1, var_3);
  }
}

lock_player_control_until_flag(var_0) {
  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  if(!isDefined(level.dog_lock_check))
    level.dog_lock_check = 0;

  level.dog_lock_check++;
  level.dog maps\_utility::ent_flag_set("pause_dog_command");
  level.dog_lock_flag = var_0;
  self.ally_owner.dog_hud_active[0] = 0;
  level.player notify("cancel_designate");
  common_scripts\utility::flag_wait(var_0);
  level.dog_lock_flag = undefined;
  level.dog_lock_check--;

  if(level.dog_lock_check == 0)
    unlock_player_control();

  self.ally_owner.dog_hud_active[0] = 1;
}

lock_player_control(var_0) {
  level.dog maps\_utility::ent_flag_set("pause_dog_command");
  return;
}

unlock_player_control() {
  level.dog maps\_utility::ent_flag_clear("pause_dog_command");
}

clear_dog_scripted_mode(var_0) {
  unlock_player_control();
}

disable_control() {
  self notify("disable_dog_control");
  self.controlled_dog = undefined;
  self enableoffhandweapons();
  setdvar("ui_dog_grenade", 0);
}

set_dog_scripted_mode(var_0) {
  lock_player_control();
}

dog_using_colors() {
  return isDefined(self.script_forcecolor) || isDefined(self.script_old_forcecolor);
}

handle_leave_team_fail(var_0, var_1) {
  level endon("stop_leave_fails");
  thread handle_leave_team_too_far_fail(var_1);
  var_2 = [];
  var_2[0] = "enemyhq_mrk_logangetbackhere";
  var_2[1] = "enemyhq_mrk_whereareyougoing";

  for(;;) {
    common_scripts\utility::flag_wait(var_0);
    var_3 = 0;

    while(common_scripts\utility::flag(var_0)) {
      if(var_3 >= var_2.size) {
        setdvar("ui_deadquote", &"ENEMY_HQ_YOU_LEFT_YOUR_TEAM_BEHIND");
        maps\_utility::missionfailedwrapper();
        break;
      }

      thread radio_dialog_add_and_go(var_2[var_3]);
      var_3++;
      wait 6;
    }
  }
}

handle_leave_team_too_far_fail(var_0) {
  level endon("stop_leave_fails");
  common_scripts\utility::flag_wait(var_0);
  setdvar("ui_deadquote", &"ENEMY_HQ_YOU_LEFT_YOUR_TEAM_BEHIND");
  maps\_utility::missionfailedwrapper();
}