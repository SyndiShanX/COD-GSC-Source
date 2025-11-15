/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3380.gsc
************************/

init_discoball_trap() {
  if(scripts\engine\utility::flag_exist("pre_game_over")) {
    scripts\engine\utility::flag_wait("pre_game_over");
  } else {
    wait(3);
  }

  level.discotrapuses = 0;
  level.var_562E = scripts\engine\utility::getstructarray("discoball_switch_fx_spot", "script_noteworthy");
  var_00 = scripts\engine\utility::getstructarray("interaction_discoballtrap", "script_noteworthy");
  level.var_562F = getent(var_00[0].target, "targetname");
  level.var_562F enablelinkto();
  level.var_5631 = scripts\engine\utility::getstruct(var_00[0].target, "targetname");
  level.var_5630 = spawn("script_model", level.var_5631.origin);
  level.var_5630 setModel("zmb_spaceland_discoball_scriptable");
  level.dance_floor_volume = getent("dance_floor_volume", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread func_5632();
  }

  wait(1);
  level.var_4D7A = scripts\engine\utility::getstructarray("dance_floor_attract_spots", "targetname");
  func_E1E0();
}

func_5632() {
  var_00 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  for(;;) {
    var_01 = "power_on";
    if(var_00) {
      var_01 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_01 == "power_off" && !scripts\engine\utility::istrue(self.powered_on)) {
      wait(0.25);
      continue;
    }

    if(var_01 != "power_off") {
      self.powered_on = 1;
      level.var_562F linkto(level.var_5630);
      getent("dance_floor", "targetname") setscriptablepartstate("dance_floor", "on");
      level thread scripts\cp\cp_vo::add_to_nag_vo("dj_traps_use_nag", "zmb_dj_vo", 60, 15, 2, 1);
    } else {
      self.powered_on = 0;
      level.var_562F unlink();
    }

    scripts\engine\utility::waitframe();
  }
}

use_discoball_trap(param_00, param_01) {
  playFX(level._effect["console_spark"], param_00.origin + (0, 0, 40));
  var_02 = sortbydistance(scripts\engine\utility::getstructarray("dischord_start_struct", "targetname"), param_01.origin);
  level.discotrapuses++;
  level.discotrap_active = 1;
  level.disco_trap_kills = 0;
  level.dichordtraptrigger = var_02[0];
  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  param_00.trap_kills = 0;
  param_00.var_126A5 = param_01;
  disablepaspeaker("astrocade");
  playsoundatpos(level.var_5630.origin + (0, 0, -100), "discoball_anc_activate");
  wait(3);
  var_03 = spawn("script_origin", level.var_5630.origin + (0, 0, -100));
  scripts\engine\utility::waitframe();
  var_03 playSound("mus_zombies_trap_disco");
  level thread func_254E();
  level.var_5630 rotateyaw(2880, 31);
  getent("dance_floor", "targetname") setscriptablepartstate("dance_floor", "active");
  wait(23.5);
  level.var_5630 playSound("trap_disco_laser_start");
  wait(1.5);
  level.var_5630 setscriptablepartstate("lasers", "on");
  level thread func_27C9(level.var_562F, level.var_5630, param_01, param_00);
  wait(5.2);
  level.var_5630 playSound("trap_disco_laser_start");
  wait(0.8);
  level notify("ball_trap_done");
  level.var_5630 setscriptablepartstate("lasers", "off");
  func_E1E0();
  level.discotrap_active = undefined;
  if(param_01 scripts\cp\utility::is_valid_player(1)) {
    param_01.tickets_earned = param_00.trap_kills;
    scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(param_01);
  }

  getent("dance_floor", "targetname") setscriptablepartstate("dance_floor", "on");
  wait(3);
  var_03 delete();
  enablepaspeaker("astrocade");
  scripts\cp\cp_interaction::enable_linked_interactions(param_00);
  scripts\cp\cp_interaction::interaction_cooldown(param_00, max(level.discotrapuses * 45, 45));
}

func_254E() {
  level endon("ball_trap_done");
  level.var_3BAA = 0;
  level.var_4D7B = 1;
  var_00 = [];
  var_01 = spawnStruct();
  var_02 = spawnStruct();
  var_01.origin = (2824.5, -1159.5, 131);
  var_02.origin = (2998.5, -1306.5, 131);
  var_00 = [var_01, var_02];
  for(;;) {
    var_03 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_04 = scripts\engine\utility::get_array_of_closest(level.var_5630.origin, var_03, undefined, 24, 600);
    var_05 = sortbydistance(var_04, level.var_5630.origin);
    foreach(var_07 in var_05) {
      if(!scripts\cp\utility::should_be_affected_by_trap(var_07) || var_07.about_to_dance) {
        continue;
      }

      if(abs(level.var_5630.origin[2] - var_07.origin[2]) > 225) {
        continue;
      }

      var_08 = func_78B2(var_07, var_00);
      var_07 thread visionsetthermalforplayer(var_08);
      var_07 thread release_zombie_on_trap_done();
    }

    wait(0.1);
  }
}

func_78B2(param_00, param_01) {
  var_02 = sortbydistance(param_01, param_00.origin);
  return var_02[0];
}

func_78B3(param_00) {
  var_01 = sortbydistance(level.var_4D7A, param_00.origin);
  foreach(var_03 in var_01) {
    if(!var_03.occupied) {
      var_03.occupied = 1;
      param_00.var_4D7D = var_03;
      return var_03;
    }
  }

  return undefined;
}

func_E1E0() {
  foreach(var_01 in level.var_4D7A) {
    var_01.occupied = 0;
  }
}

visionsetthermalforplayer(param_00) {
  self endon("death");
  self endon("turned");
  level endon("ball_trap_done");
  self.about_to_dance = 1;
  self.scripted_mode = 1;
  self.og_goalradius = self.objective_playermask_showto;
  self ghostskulls_total_waves(32);
  var_01 = level.var_5631.origin - param_00.origin;
  var_02 = vectortoangles(var_01);
  self.desired_dance_angles = (0, var_02[1], 0);
  if(!self istouching(level.dance_floor_volume)) {
    self ghostskulls_complete_status(param_00.origin);
    scripts\engine\utility::waittill_any_3("goal", "goal_reached");
  }

  if(!level.var_3BAA) {
    var_03 = scripts\engine\utility::getstruct("dance_floor_attract_spot_center", "targetname");
    self ghostskulls_complete_status(var_03.origin);
    scripts\engine\utility::waittill_any_3("goal", "goal_reached");
    if(scripts\engine\utility::istrue(level.var_3BAA)) {
      param_00 = func_78B3(self);
      if(!isDefined(param_00)) {
        var_04 = sortbydistance(level.var_4D7A, self.origin);
        self ghostskulls_complete_status(var_04[0].origin);
        scripts\engine\utility::waittill_any_3("goal", "goal_reached");
      } else {
        self ghostskulls_complete_status(param_00.origin);
        scripts\engine\utility::waittill_any_3("goal", "goal_reached");
      }
    } else {
      level.var_3BAA = 1;
      self.var_9B6E = 1;
    }
  } else {
    var_05 = func_78B3(self);
    if(!isDefined(var_05)) {
      var_04 = sortbydistance(level.var_4D7A, self.origin);
      var_05 = var_04[0];
    }

    self ghostskulls_complete_status(var_05.origin);
    scripts\engine\utility::waittill_any_3("goal", "goal_reached");
  }

  self.do_immediate_ragdoll = 1;
  self.is_dancing = 1;
}

release_zombie_on_trap_done() {
  self endon("death");
  level waittill("ball_trap_done");
  if(isDefined(self.og_goalradius)) {
    self ghostskulls_total_waves(self.og_goalradius);
  }

  self.og_goalradius = undefined;
  self.about_to_dance = 0;
  self.scripted_mode = 0;
}

func_27C9(param_00, param_01, param_02, param_03) {
  level endon("ball_trap_done");
  for(;;) {
    param_00 waittill("trigger", var_04);
    if(isDefined(var_04.padding_damage)) {
      continue;
    }

    if(isplayer(var_04)) {
      if(!var_04 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(!var_04 istouching(level.dance_floor_volume)) {
        continue;
      }

      var_04.padding_damage = 1;
      var_04 dodamage(25, var_04.origin);
      var_04 thread remove_padding_damage();
      continue;
    }

    if(scripts\cp\utility::should_be_affected_by_trap(var_04, undefined, 1)) {
      if(!var_04 istouching(level.dance_floor_volume)) {
        continue;
      }

      var_04.marked_for_death = 1;
      var_04.trap_killed_by = param_02;
      param_03.trap_kills = param_03.trap_kills + 2;
      if(scripts\engine\utility::flag("mini_ufo_green_ready")) {
        level.disco_trap_kills++;
      }

      if(isDefined(param_02)) {
        var_05 = ["kill_trap_generic", "kill_trap_danceparty"];
        param_02 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_05), "zmb_comment_vo", "highest", 10, 0, 0, 1, 20);
        if(!isDefined(param_02.trapkills["trap_danceparty"])) {
          param_02.trapkills["trap_danceparty"] = 1;
        } else {
          param_02.trapkills["trap_danceparty"]++;
        }

        var_04 dodamage(var_04.health + 100, var_04.origin, param_02, param_02, "MOD_UNKNOWN", "iw7_discotrap_zm");
        continue;
      }

      var_04 dodamage(var_04.health + 100, var_04.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_discotrap_zm");
    }
  }
}

remove_padding_damage() {
  self endon("disconnect");
  wait(0.25);
  self.padding_damage = undefined;
}