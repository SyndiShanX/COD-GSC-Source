/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_visibility_friendly.gsc
*************************************************/

stealth_visibility_friendly_main() {
  friendly_init();
  thread friendly_visibility_logic();
}

friendly_visibility_logic() {
  self endon("death");
  self endon("pain_death");
  var_0 = self._stealth.logic.current_stance_func;

  if(isplayer(self)) {
    thread player_movespeed_calc_loop();
  }

  for(;;) {
    maps\_utility::ent_flag_wait("_stealth_enabled");
    self[[var_0]]();
    self.maxvisibledist = friendly_compute_score();
    wait 0.05;
  }
}

friendly_getvelocity() {
  return length(self getvelocity());
}

player_getvelocity_pc() {
  var_0 = length(self getvelocity());
  var_1 = self._stealth.logic.stance;
  var_2 = [];
  var_2["stand"] = 30;
  var_2["crouch"] = 15;
  var_2["prone"] = 4;
  var_3 = [];
  var_3["stand"] = 40;
  var_3["crouch"] = 25;
  var_3["prone"] = 10;

  if(!var_0) {
    self._stealth.logic.player_pc_velocity = 0;
  } else if(var_0 > self._stealth.logic.player_pc_velocity) {
    self._stealth.logic.player_pc_velocity = self._stealth.logic.player_pc_velocity + var_2[var_1];

    if(self._stealth.logic.player_pc_velocity > var_0) {
      self._stealth.logic.player_pc_velocity = var_0;
    }
  } else if(var_0 < self._stealth.logic.player_pc_velocity) {
    self._stealth.logic.player_pc_velocity = self._stealth.logic.player_pc_velocity - var_3[var_1];

    if(self._stealth.logic.player_pc_velocity < 0) {
      self._stealth.logic.player_pc_velocity = 0;
    }
  }

  return self._stealth.logic.player_pc_velocity;
}

friendly_compute_score(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self._stealth.logic.stance;
  }

  if(var_0 == "back") {
    var_0 = "prone";
  }

  if(isDefined(self.type) && self.type == "dog") {
    if(isDefined(self.sprint) && self.sprint) {
      var_0 = "crouch";
    } else {
      var_0 = "prone";
    }
  }

  if(maps\_stealth_utility::stealth_group_spotted_flag()) {
    var_1 = "spotted";
  } else {
    var_1 = "hidden";
  }

  var_2 = level._stealth.logic.detect_range[var_1][var_0];

  if(maps\_utility::ent_flag("_stealth_in_shadow")) {
    var_2 = var_2 * 0.5;

    if(var_2 < level._stealth.logic.detect_range["hidden"]["prone"]) {
      var_2 = level._stealth.logic.detect_range["hidden"]["prone"];
    }
  }

  var_3 = self._stealth.logic.movespeed_multiplier[var_1][var_0];

  if(isDefined(self._stealth_move_detection_cap) && var_3 > self._stealth_move_detection_cap) {
    var_3 = self._stealth_move_detection_cap;
  }

  return var_2 + var_3;
}

friendly_getstance_ai() {
  return self.a.pose;
}

friendly_getangles_ai() {
  return self.angles;
}

friendly_compute_stances_ai() {
  self._stealth.logic.stance = self[[self._stealth.logic.getstance_func]]();
  self._stealth.logic.oldstance = self._stealth.logic.stance;
}

player_movespeed_calc_loop() {
  self endon("death");
  self endon("pain_death");
  var_0 = self._stealth.logic.getangles_func;
  var_1 = self._stealth.logic.getvelocity_func;
  var_2 = self[[var_0]]();

  for(;;) {
    maps\_utility::ent_flag_wait("_stealth_enabled");
    var_3 = undefined;

    if(maps\_utility::ent_flag("_stealth_in_shadow")) {
      var_3 = 0;
    } else {
      var_3 = self[[var_1]]();
    }

    foreach(var_9, var_5 in self._stealth.logic.movespeed_multiplier) {
      foreach(var_8, var_7 in var_5) {
        var_7 = var_3 * self._stealth.logic.movespeed_scale[var_9][var_8];
      }
    }

    var_2 = self[[var_0]]();
    wait 0.1;
  }
}

friendly_getstance_player() {
  return self getstance();
}

friendly_getangles_player() {
  return self getplayerangles();
}

friendly_compute_stances_player() {
  var_0 = self[[self._stealth.logic.getstance_func]]();

  if(!self._stealth.logic.stance_change) {
    switch (var_0) {
      case "prone":
        if(self._stealth.logic.oldstance != "prone") {
          self._stealth.logic.stance_change = self._stealth.logic.stance_change_time;
        }

        break;
      case "crouch":
        if(self._stealth.logic.oldstance == "stand") {
          self._stealth.logic.stance_change = self._stealth.logic.stance_change_time;
        }

        break;
    }
  }

  if(self._stealth.logic.stance_change) {
    self._stealth.logic.stance = self._stealth.logic.oldstance;

    if(self._stealth.logic.stance_change > 0.05) {
      self._stealth.logic.stance_change = self._stealth.logic.stance_change - 0.05;
    } else {
      self._stealth.logic.stance_change = 0;
      self._stealth.logic.stance = var_0;
      self._stealth.logic.oldstance = var_0;
    }
  } else {
    self._stealth.logic.stance = var_0;
    self._stealth.logic.oldstance = var_0;
  }
}

friendly_init() {
  maps\_utility::ent_flag_init("_stealth_in_shadow");
  maps\_utility::ent_flag_init("_stealth_enabled");
  maps\_utility::ent_flag_set("_stealth_enabled");
  maps\_stealth_shared_utilities::group_flag_init("_stealth_spotted");
  maps\_stealth_shared_utilities::group_add_to_global_list();
  self._stealth = spawnStruct();
  self._stealth.logic = spawnStruct();

  if(isplayer(self)) {
    self._stealth.logic.getstance_func = ::friendly_getstance_player;
    self._stealth.logic.getangles_func = ::friendly_getangles_player;

    if(level.console) {
      self._stealth.logic.getvelocity_func = ::friendly_getvelocity;
    } else {
      self._stealth.logic.getvelocity_func = ::player_getvelocity_pc;
      self._stealth.logic.player_pc_velocity = 0;
    }

    self._stealth.logic.current_stance_func = ::friendly_compute_stances_player;
  } else {
    self._stealth.logic.getstance_func = ::friendly_getstance_ai;
    self._stealth.logic.getangles_func = ::friendly_getangles_ai;
    self._stealth.logic.getvelocity_func = ::friendly_getvelocity;
    self._stealth.logic.current_stance_func = ::friendly_compute_stances_ai;
  }

  self._stealth.logic.stance_change_time = 0.2;
  self._stealth.logic.stance_change = 0;
  self._stealth.logic.oldstance = self[[self._stealth.logic.getstance_func]]();
  self._stealth.logic.stance = self[[self._stealth.logic.getstance_func]]();
  self._stealth.logic.spotted_list = [];
  self._stealth.logic.movespeed_multiplier = [];
  self._stealth.logic.movespeed_scale = [];
  self._stealth.logic.movespeed_multiplier["hidden"] = [];
  self._stealth.logic.movespeed_multiplier["hidden"]["prone"] = 0;
  self._stealth.logic.movespeed_multiplier["hidden"]["crouch"] = 0;
  self._stealth.logic.movespeed_multiplier["hidden"]["stand"] = 0;
  self._stealth.logic.movespeed_multiplier["spotted"] = [];
  self._stealth.logic.movespeed_multiplier["spotted"]["prone"] = 0;
  self._stealth.logic.movespeed_multiplier["spotted"]["crouch"] = 0;
  self._stealth.logic.movespeed_multiplier["spotted"]["stand"] = 0;
  friendly_default_movespeed_scale();
}

friendly_default_movespeed_scale() {
  var_0 = [];
  var_0["prone"] = 3;
  var_0["crouch"] = 2;
  var_0["stand"] = 2;
  var_1 = [];
  var_1["prone"] = 2;
  var_1["crouch"] = 2;
  var_1["stand"] = 2;
  friendly_set_movespeed_scale(var_0, var_1);
}

friendly_set_movespeed_scale(var_0, var_1) {
  if(isDefined(var_0)) {
    self._stealth.logic.movespeed_scale["hidden"]["prone"] = var_0["prone"];
    self._stealth.logic.movespeed_scale["hidden"]["crouch"] = var_0["crouch"];
    self._stealth.logic.movespeed_scale["hidden"]["stand"] = var_0["stand"];
  }

  if(isDefined(var_1)) {
    self._stealth.logic.movespeed_scale["spotted"]["prone"] = var_1["prone"];
    self._stealth.logic.movespeed_scale["spotted"]["crouch"] = var_1["crouch"];
    self._stealth.logic.movespeed_scale["spotted"]["stand"] = var_1["stand"];
  }
}