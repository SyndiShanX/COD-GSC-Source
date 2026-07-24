/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3380.gsc
**************************************/

init_discoball_trap() {
  if(scripts\engine\utility::flag_exist("pre_game_over")) {
    scripts\engine\utility::flag_wait("pre_game_over");
  } else {
    wait 3;
  }

  level.discotrapuses = 0;
  level._id_562E = scripts\engine\utility::getStructArray("discoball_switch_fx_spot", "script_noteworthy");
  var_0 = scripts\engine\utility::getStructArray("interaction_discoballtrap", "script_noteworthy");
  level._id_562F = getEnt(var_0[0].target, "targetname");
  level._id_562F enablelinkTo();
  level._id_5631 = scripts\engine\utility::getStruct(var_0[0].target, "targetname");
  level._id_5630 = spawn("script_model", level._id_5631.origin);
  level._id_5630 setModel("zmb_spaceland_discoball_scriptable");
  level.dance_floor_volume = getEnt("dance_floor_volume", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_5632();
  }

  wait 1;
  level._id_4D7A = scripts\engine\utility::getStructArray("dance_floor_attract_spots", "targetname");
  _id_E1E0();
}

_id_5632() {
  var_0 = scripts\engine\utility::is_true(self.requires_power) && isDefined(self.power_area);

  for(;;) {
    var_1 = "power_on";

    if(var_0) {
      var_1 = level scripts\engine\utility::waittill_any_return_no_endon_death("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_1 == "power_off" && !scripts\engine\utility::is_true(self.powered_on)) {
      wait 0.25;
      continue;
    }

    if(var_1 != "power_off") {
      self.powered_on = 1;
      level._id_562F linkTo(level._id_5630);
      getEnt("dance_floor", "targetname") setscriptablepartstate("dance_floor", "on");
      level thread scripts\cp\cp_vo::add_to_nag_vo("dj_traps_use_nag", "zmb_dj_vo", 60, 15, 2, 1);
    } else {
      self.powered_on = 0;
      level._id_562F unlink();
    }

    scripts\engine\utility::waitframe();
  }
}

use_discoball_trap(var_0, var_1) {
  playFX(level._effect["console_spark"], var_0.origin + (0, 0, 40));
  var_2 = sortbydistance(scripts\engine\utility::getStructArray("dischord_start_struct", "targetname"), var_1.origin);
  level.discotrapuses++;
  level.discotrap_active = 1;
  level.disco_trap_kills = 0;
  level.dichordtraptrigger = var_2[0];
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  var_0.trap_kills = 0;
  var_0._id_126A5 = var_1;
  disablepaspeaker("astrocade");
  playsoundatpos(level._id_5630.origin + (0, 0, -100), "discoball_anc_activate");
  wait 3;
  var_3 = spawn("script_origin", level._id_5630.origin + (0, 0, -100));
  scripts\engine\utility::waitframe();
  var_3 playSound("mus_zombies_trap_disco");
  level thread _id_254E();
  level._id_5630 rotateYaw(2880, 31);
  getEnt("dance_floor", "targetname") setscriptablepartstate("dance_floor", "active");
  wait 23.5;
  level._id_5630 playSound("trap_disco_laser_start");
  wait 1.5;
  level._id_5630 setscriptablepartstate("lasers", "on");
  level thread _id_27C9(level._id_562F, level._id_5630, var_1, var_0);
  wait 5.2;
  level._id_5630 playSound("trap_disco_laser_start");
  wait 0.8;
  level notify("ball_trap_done");
  level._id_5630 setscriptablepartstate("lasers", "off");
  _id_E1E0();
  level.discotrap_active = undefined;

  if(var_1 scripts\cp\utility::is_valid_player(1)) {
    var_1.tickets_earned = var_0.trap_kills;
    scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(var_1);
  }

  getEnt("dance_floor", "targetname") setscriptablepartstate("dance_floor", "on");
  wait 3;
  var_3 delete();
  enablepaspeaker("astrocade");
  scripts\cp\cp_interaction::enable_linked_interactions(var_0);
  scripts\cp\cp_interaction::interaction_cooldown(var_0, max(level.discotrapuses * 45, 45));
}

_id_254E() {
  level endon("ball_trap_done");
  level._id_3BAA = 0;
  level._id_4D7B = 1;
  var_0 = [];
  var_1 = spawnStruct();
  var_2 = spawnStruct();
  var_1.origin = (2824.5, -1159.5, 131);
  var_2.origin = (2998.5, -1306.5, 131);
  var_0 = [var_1, var_2];

  for(;;) {
    var_3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_4 = scripts\engine\utility::get_array_of_closest(level._id_5630.origin, var_3, undefined, 24, 600);
    var_5 = sortbydistance(var_4, level._id_5630.origin);

    foreach(var_7 in var_5) {
      if(!scripts\cp\utility::should_be_affected_by_trap(var_7) || var_7.about_to_dance) {
        continue;
      }
      if(abs(level._id_5630.origin[2] - var_7.origin[2]) > 225) {
        continue;
      }
      var_8 = _id_78B2(var_7, var_0);
      var_7 thread _id_8401(var_8);
      var_7 thread release_zombie_on_trap_done();
    }

    wait 0.1;
  }
}

_id_78B2(var_0, var_1) {
  var_2 = sortbydistance(var_1, var_0.origin);
  return var_2[0];
}

_id_78B3(var_0) {
  var_1 = sortbydistance(level._id_4D7A, var_0.origin);

  foreach(var_3 in var_1) {
    if(!var_3.occupied) {
      var_3.occupied = 1;
      var_0._id_4D7D = var_3;
      return var_3;
    }
  }

  return undefined;
}

_id_E1E0() {
  foreach(var_1 in level._id_4D7A) {
    var_1.occupied = 0;
  }
}

_id_8401(var_0) {
  self endon("death");
  self endon("turned");
  level endon("ball_trap_done");
  self.about_to_dance = 1;
  self.scripted_mode = 1;
  self.og_goalradius = self.goalradius;
  self scragentsetgoalRadius(32);
  var_1 = level._id_5631.origin - var_0.origin;
  var_2 = vectortoangles(var_1);
  self.desired_dance_angles = (0, var_2[1], 0);

  if(!self istouching(level.dance_floor_volume)) {
    self scragentsetgoalpos(var_0.origin);
    scripts\engine\utility::waittill_any("goal", "goal_reached");
  }

  if(!level._id_3BAA) {
    var_3 = scripts\engine\utility::getStruct("dance_floor_attract_spot_center", "targetname");
    self scragentsetgoalpos(var_3.origin);
    scripts\engine\utility::waittill_any("goal", "goal_reached");

    if(scripts\engine\utility::is_true(level._id_3BAA)) {
      var_0 = _id_78B3(self);

      if(!isDefined(var_0)) {
        var_4 = sortbydistance(level._id_4D7A, self.origin);
        self scragentsetgoalpos(var_4[0].origin);
        scripts\engine\utility::waittill_any("goal", "goal_reached");
      } else {
        self scragentsetgoalpos(var_0.origin);
        scripts\engine\utility::waittill_any("goal", "goal_reached");
      }
    } else {
      level._id_3BAA = 1;
      self._id_9B6E = 1;
    }
  } else {
    var_5 = _id_78B3(self);

    if(!isDefined(var_5)) {
      var_4 = sortbydistance(level._id_4D7A, self.origin);
      var_5 = var_4[0];
    }

    self scragentsetgoalpos(var_5.origin);
    scripts\engine\utility::waittill_any("goal", "goal_reached");
  }

  self.do_immediate_ragdoll = 1;
  self.is_dancing = 1;
}

release_zombie_on_trap_done() {
  self endon("death");
  level waittill("ball_trap_done");

  if(isDefined(self.og_goalradius)) {
    self scragentsetgoalRadius(self.og_goalradius);
  }

  self.og_goalradius = undefined;
  self.about_to_dance = 0;
  self.scripted_mode = 0;
}

_id_27C9(var_0, var_1, var_2, var_3) {
  level endon("ball_trap_done");

  for(;;) {
    var_0 waittill("trigger", var_4);

    if(isDefined(var_4.padding_damage)) {
      continue;
    }
    if(isPlayer(var_4)) {
      if(!var_4 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(!var_4 istouching(level.dance_floor_volume)) {
        continue;
      }
      var_4.padding_damage = 1;
      var_4 dodamage(25, var_4.origin);
      var_4 thread remove_padding_damage();
      continue;
    }

    if(scripts\cp\utility::should_be_affected_by_trap(var_4, undefined, 1)) {
      if(!var_4 istouching(level.dance_floor_volume)) {
        continue;
      }
      var_4.marked_for_death = 1;
      var_4.trap_killed_by = var_2;
      var_3.trap_kills = var_3.trap_kills + 2;

      if(scripts\engine\utility::flag("mini_ufo_green_ready")) {
        level.disco_trap_kills++;
      }

      if(isDefined(var_2)) {
        var_5 = ["kill_trap_generic", "kill_trap_danceparty"];
        var_2 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_5), "zmb_comment_vo", "highest", 10, 0, 0, 1, 20);

        if(!isDefined(var_2.trapkills["trap_danceparty"])) {
          var_2.trapkills["trap_danceparty"] = 1;
        } else {
          var_2.trapkills["trap_danceparty"]++;
        }

        var_4 dodamage(var_4.health + 100, var_4.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_discotrap_zm");
        continue;
      }

      var_4 dodamage(var_4.health + 100, var_4.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_discotrap_zm");
    }
  }
}

remove_padding_damage() {
  self endon("disconnect");
  wait 0.25;
  self.padding_damage = undefined;
}