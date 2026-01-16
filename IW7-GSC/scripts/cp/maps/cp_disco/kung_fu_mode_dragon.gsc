/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\kung_fu_mode_dragon.gsc
************************************************************/

setup_kung_fu_dragon_powers() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\powers\coop_powers::powersetupfunctions("power_shuriken_dragon", ::set_dragon_shuriken_power, ::unset_dragon_shuriken_power, ::use_dragon_shuriken, undefined, undefined, undefined);
  level._effect["dragon_symbol"] = loadfx("vfx\iw7\levels\cp_disco\vfx_kungfu_seal_dragon_ground.vfx");
}

set_dragon_shuriken_power(var_0) {
  self notify("stop_shuriken_watcher");
  self.shuriken_charged = undefined;
  thread dragon_shuriken_throw_listener(var_0);
  thread dragon_shuriken_pullback_listener(var_0);
}

get_shuriken_weapon_proj() {
  var_0 = self.kung_fu_progression.active_discipline;
  switch (var_0) {
    case "dragon":
      return "iw7_shuriken_dragon_proj";

    case "tiger":
      return "iw7_shuriken_tiger_proj";

    case "snake":
      return "iw7_shuriken_snake_proj";

    case "crane":
      return "iw7_shuriken_crane_proj";

    default:
      break;
  }
}

get_shuriken_grenade_weapon() {
  var_0 = self.kung_fu_progression.active_discipline;
  switch (var_0) {
    case "dragon":
      return "iw7_shuriken_zm_dragon";

    case "tiger":
      return "iw7_shuriken_zm_tiger";

    case "snake":
      return "iw7_shuriken_zm_snake";

    case "crane":
      return "iw7_shuriken_zm_crane";

    default:
      break;
  }
}

dragon_shuriken_throw_listener(var_0) {
  self endon("disconnect");
  self endon("last_stand");
  self endon("stop_shuriken_watcher");
  var_1 = get_shuriken_weapon_proj();
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = get_shuriken_grenade_weapon();
  if(!isDefined(var_2)) {
    return;
  }

  for(;;) {
    self waittill("grenade_fire", var_3, var_4, var_5);
    if(var_4 != var_2) {
      continue;
    }

    self setscriptablepartstate("shuriken", "inactive");
    while(isDefined(var_3) && distance2dsquared(var_3.origin, self.origin) <= 8100) {
      wait(0.05);
    }

    if(!isDefined(var_3)) {
      thread scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(scripts\cp\maps\cp_disco\kung_fu_mode::getrbabilitycost());
      continue;
    }

    scripts\cp\powers\coop_powers::power_disablepower();
    if(scripts\engine\utility::istrue(self.shuriken_charged)) {
      self.shuriken_charged = undefined;
      throw_charged_shuriken(var_0, var_3, var_1);
      continue;
    }

    var_6 = sortbydistance(level.spawned_enemies, var_3.origin);
    var_7 = [];
    var_8 = var_3.origin;
    var_9 = self getplayerangles();
    var_10 = anglesToForward(var_3.angles);
    var_11 = vectornormalize(var_10) * 100 + var_8;
    var_12 = 10;
    var_13 = var_12 * -1;
    var_13 = var_13 + var_12;
    var_14 = var_8 + anglesToForward(var_9 + (var_13 / 10, var_13, 0)) * 45;
    magicbullet(var_1, var_8, var_14, self);
    var_13 = var_13 + var_12;
    var_3 delete();
    thread scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(scripts\cp\maps\cp_disco\kung_fu_mode::getrbabilitycost());
    scripts\cp\powers\coop_powers::power_enablepower();
  }
}

dragon_shuriken_pullback_listener(var_0) {
  self endon("watch_for_kung_fu_timeout");
  self endon("disconnect");
  self endon("last_stand");
  self endon("stop_shuriken_watcher");
  var_1 = get_shuriken_grenade_weapon();
  if(!isDefined(var_1)) {
    return;
  }

  for(;;) {
    self waittill("grenade_pullback", var_2);
    if(var_2 != var_1) {
      return;
    }

    thread dragon_shuriken_switch_listener();
    thread charge_shuriken(2);
  }
}

charge_shuriken(var_0) {
  self endon("grenade_fire");
  self endon("offhand_end");
  self endon("put_shuriken_away");
  wait(var_0);
  self.shuriken_charged = 1;
  set_charged_scriptable_state();
}

dragon_shuriken_switch_listener() {
  self endon("watch_for_kung_fu_timeout");
  self endon("disconnect");
  self endon("last_stand");
  self endon("stop_shuriken_watcher");
  self endon("grenade_fire");
  self notifyonplayercommand("put_shuriken_away", "+weapnext");
  self waittill("put_shuriken_away", var_0);
  self.shuriken_charged = undefined;
  self setscriptablepartstate("shuriken", "inactive");
}

set_charged_scriptable_state() {
  var_0 = self.kung_fu_progression.active_discipline;
  switch (var_0) {
    case "dragon":
      self setscriptablepartstate("shuriken", "dragon_active");
      break;

    case "tiger":
      self setscriptablepartstate("shuriken", "tiger_active");
      break;

    case "snake":
      self setscriptablepartstate("shuriken", "snake_active");
      break;

    case "crane":
      self setscriptablepartstate("shuriken", "crane_active");
      break;

    default:
      break;
  }
}

unset_dragon_shuriken_power(var_0) {}

use_dragon_shuriken(var_0) {}

throw_charged_shuriken(var_0, var_1, var_2) {
  var_3 = sortbydistance(level.spawned_enemies, var_1.origin);
  var_4 = [];
  var_5 = var_1.origin;
  if(!isDefined(var_2)) {
    var_2 = "iw7_shuriken_dragon_proj";
  }

  thread scripts\engine\utility::play_sound_in_space("kungfu_shuriken_split", var_5);
  foreach(var_7 in var_3) {
    if(scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var_7.origin, 0.9)) {
      var_4[var_4.size] = var_7;
    }
  }

  if(var_4.size == 0) {
    var_9 = self getplayerangles();
    var_10 = anglesToForward(var_1.angles);
    var_11 = vectornormalize(var_10) * 100 + var_5;
    var_12 = 10;
    var_13 = var_12 * -1;
    for(var_14 = 0; var_14 < 3; var_14++) {
      var_15 = var_5 + anglesToForward(var_9 + (var_13 / 10, var_13, 0)) * 45;
      magicbullet(var_2, var_5, var_15, self);
      var_13 = var_13 + var_12;
    }
  } else {
    var_14 = 0;
    foreach(var_7 in var_4) {
      if(var_14 == 3) {
        break;
      } else {
        var_14++;
      }

      magicbullet(var_2, var_5, var_7 gettagorigin("j_mainroot") + (0, 0, 10), self);
    }
  }

  var_1 delete();
  scripts\cp\powers\coop_powers::power_enablepower();
  thread scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(scripts\cp\maps\cp_disco\kung_fu_mode::getrbabilitycost());
}

use_dragon_shuriken_power(var_0) {}

dragon_super_use(var_0) {
  self.dragon_super = 1;
  var_1 = scripts\cp\utility::getvalidtakeweapon();
  var_2 = "dragon";
  if(isDefined(self.kung_fu_progression.active_discipline)) {
    var_1 = level.kung_fu_upgrades[var_2].melee_weapon;
  }

  scripts\cp\powers\coop_powers::power_disablepower();
  scripts\engine\utility::allow_melee(0);
  self playgestureviewmodel("ges_dragon_melee_super", undefined, 1);
  thread stay_in_kung_fu_till_gesture_done("ges_dragon_melee_super");
  thread play_dragon_hand_fx();
  wait(0.5);
  var_3 = self.origin + (0, 0, 60);
  var_4 = self getplayerangles();
  var_5 = anglesToForward(var_4);
  var_6 = vectornormalize(var_5) * 100 + self.origin;
  var_5 = vectornormalize(var_5) * 3000 + var_3;
  var_7 = spawn("script_model", var_6);
  var_7.angles = var_4 + (0, -90, 0);
  var_7 setModel("tag_origin_dragon_super");
  var_7.owner = self;
  var_7.spiral_center = self.origin;
  var_7 thread move_dragon(var_5, var_2, var_1);
  var_7 thread dragon_super_damage(self, 15, var_1);
}

stay_in_kung_fu_till_gesture_done(var_0) {
  self endon("disconnect");
  self.kung_fu_shield = 1;
  var_1 = 500;
  if(self.chi_meter_amount - var_1 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  var_2 = self getgestureanimlength(var_0);
  wait(var_2);
  scripts\engine\utility::allow_melee(1);
  self.dragon_super = undefined;
  self.kung_fu_exit_delay = 0;
  self.kung_fu_shield = undefined;
  scripts\cp\powers\coop_powers::power_enablepower();
}

play_dragon_hand_fx() {
  self setscriptablepartstate("kung_fu_super_fx", "dragon");
  wait(2);
  self setscriptablepartstate("kung_fu_super_fx", "off");
}

move_dragon(var_0, var_1, var_2) {
  self moveto(self.origin + (0, 0, 50), 0.25);
  self waittill("movedone");
  thread dragon_time_out(10);
  follow_dragon_path(var_1, var_2);
  thread scripts\engine\utility::play_sound_in_space("kungfu_dragon_proj_off", self.origin);
  self setscriptablepartstate("tag", "off", 1);
  self delete();
}

move_dragon_forward() {
  self endon("dragon_time_out");
  var_0 = 100;
  for(;;) {
    var_1 = anglesToForward(self.angles);
    var_1 = vectornormalize(var_1);
    var_1 = var_1 * var_0;
    self moveto(self.origin + var_1, 0.1);
    self waittill("movedone");
  }
}

aim_dragon() {
  self endon("dragon_time_out");
  for(;;) {
    var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    if(var_0.size > 0) {
      var_1 = scripts\engine\utility::get_array_of_closest(self.origin, var_0, undefined, 24, 500, 1);
      var_2 = anglesToForward(self.angles);
      while(isalive(var_1[0])) {
        var_3 = var_1[0] findpath(self.origin, var_1[0].origin);
        level thread debug_show_path(var_3);
        var_4 = var_1[0].origin + (0, 0, 60) - self.origin + (0, 0, 60);
        var_5 = vectortoangles(var_4);
        self rotateto(var_5, 0.1);
        wait(0.1);
      }
    }

    wait(0.1);
  }
}

follow_dragon_path(var_0, var_1) {
  self endon("dragon_time_out");
  var_2 = -25536;
  for(;;) {
    var_3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_4 = [];
    foreach(var_6 in var_3) {
      if(isDefined(var_6.agent_type) && var_6.agent_type != "ratking") {
        var_4 = scripts\engine\utility::array_add(var_4, var_6);
      }
    }

    var_3 = var_4;
    var_3 = [];
    if(var_3.size > 0) {
      var_8 = scripts\engine\utility::get_array_of_closest(self.origin, var_3, undefined, 24, 1500, 1);
      if(var_8.size > 0) {
        var_9 = anglesToForward(self.angles);
        var_10 = var_8[0];
        self.enemy = var_10;
        clean_up_spiral();
        while(isalive(var_10)) {
          var_11 = distancesquared(self.origin, var_10.origin);
          if(var_11 < var_2) {
            var_12 = var_10.origin + (0, 0, 60) - self.origin + (0, 0, 60);
            var_13 = vectortoangles(var_12);
            self rotateto(var_13, 0.1);
            var_14 = length(var_12);
            var_12 = vectornormalize(var_12) * var_14 + 100;
            self moveto(self.origin + var_12 + (0, 0, 60), 0.25);
            self waittill("movedone");
            if(isalive(var_10)) {
              dragon_kill_guy(var_10, self.owner, var_1);
            }

            continue;
          }

          var_15 = getclosestpointonnavmesh(self.origin);
          var_10 = var_10 findpath(var_15, var_10.origin, 1, 1);
          var_10 = [];
          move_along_path_new(var_10, var_10);
          wait(0.1);
        }
      } else {
        thread idle_spiral();
      }
    } else {
      thread idle_spiral();
    }

    wait(0.1);
  }
}

clean_up_spiral() {
  self.on_spiral_path = 0;
  if(isDefined(self.spin_org)) {
    self.spin_org delete();
  }

  self notify("found_enemy");
}

idle_spiral() {
  self endon("found_enemy");
  self endon("death");
  wait(0.25);
  if(!scripts\engine\utility::istrue(self.on_spiral_path)) {
    move_along_spiral_path();
  }
}

move_along_spiral_path(var_0) {
  self endon("found_enemy");
  self endon("death");
  self endon("got_new_path");
  spin_linked_ent();
}

spin_linked_ent() {
  self endon("found_enemy");
  self endon("death");
  var_0 = self.spiral_center;
  self.on_spiral_path = 1;
  self.spin_org = spawn("script_origin", var_0);
  self linkto(self.spin_org);
  self.spin_org rotateyaw(-100000, 300);
  for(;;) {
    self.spin_org movez(75, 2);
    self.spin_org waittill("movedone");
    self.spin_org movez(-75, 2);
    self.spin_org waittill("movedone");
  }
}

move_along_path_new(var_0, var_1) {
  self endon("death");
  self endon("got_new_path");
  var_2 = 100;
  var_3 = var_2 * var_2;
  if(var_0.size > 0) {
    var_4 = 0;
    var_5 = var_0[var_4];
    var_6 = 0;
    while(distancesquared(self.origin, var_5) < var_3) {
      if(isDefined(var_0[var_4 + 1])) {
        var_4++;
        var_5 = var_0[var_4];
        continue;
      }

      var_6 = 1;
      break;
    }

    if(!var_6) {
      thread turn_towards_target(var_5);
    }
  } else if(isalive(var_1)) {
    var_5 = var_1.origin + (0, 0, 60);
    thread turn_towards_target(var_5);
  }

  thread move_forward();
}

move_forward() {
  var_0 = 500;
  var_1 = anglesToForward(self.angles);
  var_1 = vectornormalize(var_1) * var_0;
  var_2 = self.origin + var_1;
  var_2 = getclosestpointonnavmesh(var_2);
  self moveto(var_2 + (0, 0, 60), 1);
}

turn_towards_target(var_0) {
  var_1 = 360;
  var_2 = var_0 - self.origin + (0, 0, 60);
  var_3 = vectortoangles(var_2);
  var_4 = anglesdelta(self.angles, var_3) * 2;
  if(var_4 == 0) {
    return;
  }

  var_5 = var_4 / var_1;
  var_5 = abs(var_5);
  self rotateto(var_3, var_5);
  var_6 = anglesToForward(var_3);
  var_6 = vectornormalize(var_6) * 100;
  var_7 = self.origin + var_6;
}

debug_show_path(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1 + 1])) {}
  }
}

dragon_time_out(var_0) {
  wait(var_0);
  self notify("dragon_time_out");
}

dragon_super_damage(var_0, var_1, var_2) {
  self endon("death");
  self notify("dragon_time_out");
  var_3 = 0.1;
  var_4 = 22500;
  while(!isDefined(self.spin_org)) {
    wait(0.1);
  }

  var_5 = self.spin_org;
  while(var_1 > 0 && isDefined(var_5)) {
    var_6 = level.spawned_enemies;
    foreach(var_8 in var_6) {
      if(distancesquared(self.spiral_center, var_8.origin) < var_4) {
        dragon_kill_guy(var_8, var_0, var_2);
      }
    }

    var_1 = var_1 - var_3;
    wait(var_3);
  }
}

dragon_kill_guy(var_0, var_1, var_2) {
  var_0.nocorpse = 1;
  var_0.full_gib = 1;
  if(isDefined(var_1)) {
    var_0 dodamage(var_0.health + 1000, var_0.origin, var_1, var_1, "MOD_UNKNOWN", var_2);
    return;
  }

  var_0 dodamage(var_0.health + 1000, var_0.origin, level.players[0], level.players[0], "MOD_UNKNOWN", var_2);
}