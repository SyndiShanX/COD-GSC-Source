/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombies_attack_object.gsc
********************************************************/

init() {
  _id_0547::_id_7BD0("zombie_attack_tower_lever", ::preform_zombie_object_melee, ::preform_zombie_object_melee_interrupt, 3.75);
}

create_inanimate_zombie_enemy(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  self endon("death");
  self endon("entitydeleted");
  self.optionalattackpositions = var_7;
  self.maxzombies = var_0;
  self.maxhealth = var_1;
  self.health = var_1;
  self.shouldterminate = 0;
  var_11 = 0.125;

  foreach(var_13 in var_6)
  thread terminate_on(var_13, var_2);

  if(isDefined(var_10))
    thread aa_gun_health_check(var_10);

  var_15 = get_cur_objective_health();

  while(var_15 > 0 && !self.shouldterminate) {
    if(isDefined(var_10))
      var_10 _meth_82FF("ui_zm_turret_health", self.health * 0.0025);

    var_16 = _id_0547::_id_43F0(self.origin, var_4, var_3, 1);
    var_16 = common_scripts\utility::_id_40B0(self.origin, var_16);

    foreach(var_18 in var_16) {
      if(var_18 has_a_distraction()) {
        if(_id_0547::_id_5565(var_18.enemy_object, self)) {
          var_18 thread preform_zombie_object_melee_interrupt(self);
          continue;
        }
      }

      if(_id_0547::_id_5565(var_18._id_0A4B, "zombie_exploder") && !common_scripts\utility::_id_562E(var_18._id_392C)) {
        if(var_18 has_a_distraction())
          var_18 thread preform_zombie_object_melee_interrupt(self);

        continue;
      }

      if(!var_18 zombie_is_valid_type(var_8)) {
        continue;
      }
      if(!var_18 zombie_should_attack(var_9)) {
        continue;
      }
      if(var_18 already_attacking_an_objective()) {
        continue;
      }
      if(var_18 has_a_distraction()) {
        continue;
      }
      if(!(get_number_zombies_attacking_objective() >= self.maxzombies))
        var_18 set_zombie_attacking_this_object(self);
    }

    var_15 = get_cur_objective_health();
    wait(var_11);
  }

  if(!isDefined(self.capture_health))
    clear_zombie_interest();

  self thread[[var_5]]();
  common_scripts\utility::_id_379A(var_2);
}

get_cur_objective_health() {
  if(isDefined(self.capture_health))
    var_0 = self.capture_health;
  else
    var_0 = self.health;

  return var_0;
}

has_a_distraction() {
  var_0 = self;

  if(isDefined(var_0._id_3043))
    return 1;

  if(var_0 _id_053C::_id_5686())
    return 1;

  return 0;
}

aa_gun_health_check(var_0) {
  var_0 endon("left_aa_gun");

  for(;;) {
    var_0 waittill("aagun_damage");
    self.health = self.health - 5;
  }
}

clear_zombie_interest() {
  var_0 = _id_0547::_id_408F();

  foreach(var_2 in var_0) {
    if(_id_0547::_id_5565(var_2.enemy_object, self))
      var_2 thread preform_zombie_object_melee_interrupt(self);
  }
}

terminate_on(var_0, var_1) {
  self[[var_0]](var_1);
  self.shouldterminate = 1;
}

preform_zombie_object_melee(var_0) {
  if(!isDefined(self._id_9B61)) {
    preform_zombie_object_melee_interrupt(var_0);
    return;
  }

  var_1 = self[[maps\mp\agents\_agent_utility::_id_0A59("get_action_params")]]();
  var_2 = undefined;

  foreach(var_4 in ["zombie_attack_tower_lever", "attack_stand"]) {
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_087C(var_4, var_1);

    if(isDefined(var_2)) {
      break;
    }
  }

  if(!isDefined(var_2)) {
    return;
  }
  self _meth_83A2(1);
  self _meth_839B("face angle abs", self._id_9B61.angles);
  self setOrigin(var_0.origin, 0);

  for(;;) {
    var_6 = self _meth_83DB(var_2);
    var_7 = randomint(var_6);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, var_7, 1.0, "scripted_anim");

    if(isDefined(self.enemy_object)) {
      self.enemy_object take_objective_health(45);

      if(isDefined(self.enemy_object.ondamagetakenfunc))
        self.enemy_object thread[[self.enemy_object.ondamagetakenfunc]]();
    }
  }
}

take_objective_health(var_0) {
  if(isDefined(self.capture_health))
    self.capture_health = self.capture_health - var_0;
  else
    self.health = self.health - var_0;
}

preform_zombie_object_melee_interrupt(var_0) {
  self notify("cancel_attack_travel");
  self.enemy_object = undefined;
  self._id_9B61 = undefined;
  self _meth_83A2(0);
}

set_zombie_attacking_this_object(var_0) {
  self.enemy_object = var_0;
  var_1 = var_0 get_number_zombies_attacking_objective();

  if(isDefined(var_0.optionalattackpositions))
    self._id_9B61 = get_available_attack_point(var_0.optionalattackpositions);
  else
    self._id_9B61 = var_0;

  thread travel_and_attack_position(self._id_9B61, var_0);
}

get_available_attack_point(var_0) {
  var_1 = var_0;

  foreach(var_3 in _id_0547::_id_408F()) {
    if(var_3 == self) {
      continue;
    }
    if(!isDefined(var_3._id_9B61)) {
      continue;
    }
    var_1 = common_scripts\utility::_id_0F93(var_1, var_3._id_9B61);
  }

  if(var_1.size == 0)
    return common_scripts\utility::random(var_0);
  else
    return common_scripts\utility::random(var_1);
}

travel_and_attack_position(var_0, var_1) {
  self endon("death");
  self endon("cancel_attack_travel");

  if(!(maps\mp\_utility::_id_4571() == "mp_zombie_island"))
    self._id_6941 = 1;

  while(distance(self.origin, self._id_9B61.origin) > 64)
    waitframe();

  if(_id_0547::_id_5565(self._id_0A4B, "zombie_exploder")) {
    var_1.health = var_1.health - int(var_1.maxhealth / 5);
    _id_0563::_id_AB99(undefined, undefined, self.health + 1, undefined, "MOD_BULLET", "m1911_zm", self.origin, (0, 0, 0), "tag_origin", 0, "tag_weapon");
  } else
    thread _id_0547::_id_7D1A("zombie_attack_tower_lever", [var_0]);
}

already_attacking_an_objective(var_0) {
  return isDefined(self.enemy_object);
}

get_number_zombies_attacking_objective() {
  var_0 = _id_0547::_id_408F();
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(_id_0547::_id_5565(var_3.enemy_object, self))
      var_1++;
  }

  return var_1;
}

zombie_should_attack(var_0) {
  foreach(var_2 in var_0) {
    if(allowed_to_attack(var_2))
      return 1;
  }

  return 0;
}

allowed_to_attack(var_0) {
  var_1 = 1;

  switch (var_0) {
    case "zombie_is_passive":
      var_1 = !isDefined(self._id_3794["zombie_passive"]) || !common_scripts\utility::_id_3794("zombie_passive");
      break;
    case "zombie_is_crawler":
      var_1 = !common_scripts\utility::_id_562E(self._id_2FDA);
      break;
    case "zombie_is_objective":
      var_1 = !isDefined(self.escort_wps);
      break;
    case "zombie_is_stunned":
      var_1 = !common_scripts\utility::_id_562E(self._id_561D);
      break;
  }

  return var_1;
}

zombie_is_valid_type(var_0) {
  if(!isDefined(var_0))
    return 1;

  return common_scripts\utility::_id_0F79(var_0, self._id_0A4B);
}