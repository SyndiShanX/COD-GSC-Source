/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombies_attack_object.gsc
************************************************/

func_00D5() {
  lib_0547::func_7BD0("zombie_attack_tower_lever", ::preform_zombie_object_melee, ::preform_zombie_object_melee_interrupt, 3.75);
}

create_inanimate_zombie_enemy(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  self endon("death");
  self endon("entitydeleted");
  self.optionalattackpositions = param_07;
  self.maxzombies = param_00;
  self.var_FB = param_01;
  self.var_BC = param_01;
  self.shouldterminate = 0;
  var_0B = 0.125;
  foreach(var_0D in param_06) {
    thread terminate_on(var_0D, param_02);
  }

  if(isDefined(param_0A)) {
    thread aa_gun_health_check(param_0A);
  }

  var_0F = get_cur_objective_health();
  while(var_0F > 0 && !self.shouldterminate) {
    if(isDefined(param_0A)) {
      param_0A setclientomnvar("ui_zm_turret_health", self.var_BC * 0.0025);
    }

    var_10 = lib_0547::func_43F0(self.var_116, param_04, param_03, 1);
    var_10 = common_scripts\utility::func_40B0(self.var_116, var_10);
    foreach(var_12 in var_10) {
      if(var_12 has_a_distraction()) {
        if(lib_0547::func_5565(var_12.enemy_object, self)) {
          var_12 thread preform_zombie_object_melee_interrupt(self);
          continue;
        }
      }

      if(lib_0547::func_5565(var_12.var_A4B, "zombie_exploder") && !common_scripts\utility::func_562E(var_12.var_392C)) {
        if(var_12 has_a_distraction()) {
          var_12 thread preform_zombie_object_melee_interrupt(self);
        }

        continue;
      }

      if(!var_12 zombie_is_valid_type(param_08)) {
        continue;
      }

      if(!var_12 zombie_should_attack(param_09)) {
        continue;
      }

      if(var_12 already_attacking_an_objective()) {
        continue;
      }

      if(var_12 has_a_distraction()) {
        continue;
      }

      if(!get_number_zombies_attacking_objective() >= self.maxzombies) {
        var_12 set_zombie_attacking_this_object(self);
      }
    }

    var_0F = get_cur_objective_health();
    wait(var_0B);
  }

  if(!isDefined(self.capture_health)) {
    clear_zombie_interest();
  }

  self thread[[param_05]]();
  common_scripts\utility::func_379A(param_02);
}

get_cur_objective_health() {
  if(isDefined(self.capture_health)) {
    var_00 = self.capture_health;
  } else {
    var_00 = self.var_BC;
  }

  return var_00;
}

has_a_distraction() {
  var_00 = self;
  if(isDefined(var_00.var_3043)) {
    return 1;
  }

  if(var_00 lib_053C::func_5686()) {
    return 1;
  }

  return 0;
}

aa_gun_health_check(param_00) {
  param_00 endon("left_aa_gun");
  for(;;) {
    param_00 waittill("aagun_damage");
    self.var_BC = self.var_BC - 5;
  }
}

clear_zombie_interest() {
  var_00 = lib_0547::func_408F();
  foreach(var_02 in var_00) {
    if(lib_0547::func_5565(var_02.enemy_object, self)) {
      var_02 thread preform_zombie_object_melee_interrupt(self);
    }
  }
}

terminate_on(param_00, param_01) {
  self[[param_00]](param_01);
  self.shouldterminate = 1;
}

preform_zombie_object_melee(param_00) {
  if(!isDefined(self.var_9B61)) {
    preform_zombie_object_melee_interrupt(param_00);
    return;
  }

  var_01 = self[[maps\mp\agents\_agent_utility::func_A59("get_action_params")]]();
  var_02 = undefined;
  foreach(var_04 in ["zombie_attack_tower_lever", "attack_stand"]) {
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_87C(var_04, var_01);
    if(isDefined(var_02)) {
      break;
    }
  }

  if(!isDefined(var_02)) {
    return;
  }

  self scragentsetscripted(1);
  self scragentsetorientmode("face angle abs", self.var_9B61.var_1D);
  self setorigin(param_00.var_116, 0);
  for(;;) {
    var_06 = self method_83DB(var_02);
    var_07 = randomint(var_06);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_02, var_07, 1, "scripted_anim");
    if(isDefined(self.enemy_object)) {
      self.enemy_object take_objective_health(45);
      if(isDefined(self.enemy_object.ondamagetakenfunc)) {
        self.enemy_object thread[[self.enemy_object.ondamagetakenfunc]]();
      }
    }
  }
}

take_objective_health(param_00) {
  if(isDefined(self.capture_health)) {
    self.capture_health = self.capture_health - param_00;
    return;
  }

  self.var_BC = self.var_BC - param_00;
}

preform_zombie_object_melee_interrupt(param_00) {
  self notify("cancel_attack_travel");
  self.enemy_object = undefined;
  self.var_9B61 = undefined;
  self scragentsetscripted(0);
}

set_zombie_attacking_this_object(param_00) {
  self.enemy_object = param_00;
  var_01 = param_00 get_number_zombies_attacking_objective();
  if(isDefined(param_00.optionalattackpositions)) {
    self.var_9B61 = get_available_attack_point(param_00.optionalattackpositions);
  } else {
    self.var_9B61 = param_00;
  }

  thread travel_and_attack_position(self.var_9B61, param_00);
}

get_available_attack_point(param_00) {
  var_01 = param_00;
  foreach(var_03 in lib_0547::func_408F()) {
    if(var_03 == self) {
      continue;
    }

    if(!isDefined(var_03.var_9B61)) {
      continue;
    }

    var_01 = common_scripts\utility::func_F93(var_01, var_03.var_9B61);
  }

  if(var_01.size == 0) {
    return common_scripts\utility::func_7A33(param_00);
  }

  return common_scripts\utility::func_7A33(var_01);
}

travel_and_attack_position(param_00, param_01) {
  self endon("death");
  self endon("cancel_attack_travel");
  if(!maps\mp\_utility::func_4571() == "mp_zombie_island") {
    self.var_6941 = 1;
  }

  while(distance(self.var_116, self.var_9B61.var_116) > 64) {
    wait 0.05;
  }

  if(lib_0547::func_5565(self.var_A4B, "zombie_exploder")) {
    param_01.var_BC = param_01.var_BC - int(param_01.var_FB / 5);
    lib_0563::func_AB99(undefined, undefined, self.var_BC + 1, undefined, "MOD_BULLET", "m1911_zm", self.var_116, (0, 0, 0), "tag_origin", 0, "tag_weapon");
    return;
  }

  thread lib_0547::func_7D1A("zombie_attack_tower_lever", [param_00]);
}

already_attacking_an_objective(param_00) {
  return isDefined(self.enemy_object);
}

get_number_zombies_attacking_objective() {
  var_00 = lib_0547::func_408F();
  var_01 = 0;
  foreach(var_03 in var_00) {
    if(lib_0547::func_5565(var_03.enemy_object, self)) {
      var_01++;
    }
  }

  return var_01;
}

zombie_should_attack(param_00) {
  foreach(var_02 in param_00) {
    if(allowed_to_attack(var_02)) {
      return 1;
    }
  }

  return 0;
}

allowed_to_attack(param_00) {
  var_01 = 1;
  switch (param_00) {
    case "zombie_is_passive":
      var_01 = !isDefined(self.var_3794["zombie_passive"]) || !common_scripts\utility::func_3794("zombie_passive");
      break;

    case "zombie_is_crawler":
      var_01 = !common_scripts\utility::func_562E(self.var_2FDA);
      break;

    case "zombie_is_objective":
      var_01 = !isDefined(self.escort_wps);
      break;

    case "zombie_is_stunned":
      var_01 = !common_scripts\utility::func_562E(self.var_561D);
      break;
  }

  return var_01;
}

zombie_is_valid_type(param_00) {
  if(!isDefined(param_00)) {
    return 1;
  }

  return common_scripts\utility::func_F79(param_00, self.var_A4B);
}