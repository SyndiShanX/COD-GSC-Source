/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_smartstance_friendly.gsc
**************************************************/

stealth_smartstance_friendly_main() {
  friendly_init();
  thread friendly_stance_handler();
}

friendly_stance_handler() {
  self endon("death");
  self endon("pain_death");
  self.old_fixednode = self.fixednode;
  self.old_fixednodesaferadius = self.fixednodesaferadius;

  for(;;) {
    maps\_utility::ent_flag_wait("_stealth_stance_handler");
    common_scripts\utility::flag_waitopen("_stealth_spotted");
    self.fixednode = 1;
    self.fixednodesaferadius = 10;

    while(maps\_utility::ent_flag("_stealth_stance_handler") && !common_scripts\utility::flag("_stealth_spotted")) {
      friendly_stance_handler_set_stance_up();
      var_0 = [];
      var_0 = friendly_stance_handler_check_mightbeseen(var_0);

      if(var_0[self._stealth.logic.stance]) {
        thread friendly_stance_handler_change_stance_down();
      } else if(maps\_utility::ent_flag("_stealth_stay_still")) {
        thread friendly_stance_handler_resume_path();
      } else if(!var_0[self._stealth.behavior.stance_up] && self._stealth.behavior.stance_up != self._stealth.logic.stance) {
        thread friendly_stance_handler_change_stance_up();
      } else if(maps\_utility::ent_flag("_stealth_stance_change")) {
        self notify("_stealth_stance_dont_change");
      }

      wait 0.05;
    }

    self.fixednode = self.old_fixednode;
    self.fixednodesaferadius = self.old_fixednodesaferadius;
    self.moveplaybackrate = 1;
    self allowedstances("stand", "crouch", "prone");

    if(maps\_utility::ent_flag("_stealth_stay_still")) {
      thread friendly_stance_handler_resume_path(0);
    }
  }
}

friendly_stance_handler_set_stance_up() {
  switch (self._stealth.logic.stance) {
    case "prone":
      self._stealth.behavior.stance_up = "crouch";
      break;
    case "crouch":
      self._stealth.behavior.stance_up = "stand";
      break;
    case "stand":
      self._stealth.behavior.stance_up = "stand";
      break;
  }
}

friendly_stance_handler_check_mightbeseen(var_0) {
  var_1 = getaispeciesarray("bad_guys", "all");
  var_0[self._stealth.logic.stance] = 0;
  var_0[self._stealth.behavior.stance_up] = 0;

  foreach(var_9, var_3 in var_1) {
    var_4 = friendly_stance_handler_return_ai_sight(var_3, self._stealth.logic.stance);
    var_5 = friendly_stance_handler_return_ai_sight(var_3, self._stealth.behavior.stance_up);
    var_6 = maps\_stealth_visibility_friendly::friendly_compute_score() + var_4;
    var_7 = maps\_stealth_visibility_friendly::friendly_compute_score(self._stealth.behavior.stance_up) + var_5;
    var_8 = distance(var_3.origin, self.origin);

    if(var_8 < var_6) {
      var_0[self._stealth.logic.stance] = var_6;
      break;
    }

    if(var_8 < var_7) {
      var_0[self._stealth.behavior.stance_up] = var_7;
    }
  }

  return var_0;
}

friendly_stance_handler_return_ai_sight(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = vectornormalize(self.origin - var_0.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0.3) {
    return self._stealth.behavior.stance_handler["looking_towards"][var_1];
  } else if(var_4 < -0.7) {
    return self._stealth.behavior.stance_handler["looking_away"][var_1];
  } else {
    return self._stealth.behavior.stance_handler["neutral"][var_1];
  }
}

friendly_stance_handler_change_stance_down() {
  self.moveplaybackrate = 1;
  self notify("_stealth_stance_down");

  switch (self._stealth.logic.stance) {
    case "stand":
      self.moveplaybackrate = 0.7;
      self allowedstances("crouch");
      break;
    case "crouch":
      if(self._stealth.behavior.no_prone) {
        friendly_stance_handler_stay_still();
      } else {
        self allowedstances("prone");
      }

      break;
    case "prone":
      friendly_stance_handler_stay_still();
      break;
  }
}

friendly_stance_handler_change_stance_up() {
  self endon("_stealth_stance_down");
  self endon("_stealth_stance_dont_change");
  self endon("_stealth_stance_handler");

  if(maps\_utility::ent_flag("_stealth_stance_change")) {
    return;
  }
  var_0 = 4;
  maps\_utility::ent_flag_set("_stealth_stance_change");
  maps\_utility::add_wait(maps\_utility::_wait, var_0);
  maps\_utility::add_wait(maps\_utility::waittill_msg, "_stealth_stance_down");
  maps\_utility::add_wait(maps\_utility::waittill_msg, "_stealth_stance_dont_change");
  maps\_utility::add_wait(maps\_utility::waittill_msg, "_stealth_stance_handler");
  maps\_utility::add_func(maps\_utility::ent_flag_clear, "_stealth_stance_change");
  thread maps\_utility::do_wait_any();
  wait(var_0);
  self.moveplaybackrate = 1;

  switch (self._stealth.logic.stance) {
    case "prone":
      self allowedstances("crouch");
      break;
    case "crouch":
      self allowedstances("stand");
      break;
    case "stand":
      break;
  }
}

friendly_stance_handler_stay_still() {
  self notify("friendly_stance_handler_stay_still");

  if(maps\_utility::ent_flag("_stealth_stay_still")) {
    return;
  }
  maps\_utility::ent_flag_set("_stealth_stay_still");
  badplace_cylinder("_stealth_" + self.unique_id + "_prone", 0, self.origin, 30, 90, "bad_guys");
  self.fixednodesaferadius = 5000;
}

friendly_stance_handler_resume_path(var_0) {
  self endon("friendly_stance_handler_stay_still");

  if(!isDefined(var_0)) {
    var_0 = self._stealth.behavior.wait_resume_path;
  }

  wait(var_0);

  if(!maps\_utility::ent_flag("_stealth_stay_still")) {
    return;
  }
  maps\_utility::ent_flag_clear("_stealth_stay_still");
  badplace_delete("_stealth_" + self.unique_id + "_prone");
  self.fixednodesaferadius = 10;
}

friendly_init() {
  maps\_utility::ent_flag_init("_stealth_stance_handler");
  maps\_utility::ent_flag_init("_stealth_stay_still");
  maps\_utility::ent_flag_init("_stealth_stance_change");
  self._stealth.behavior.stance_up = undefined;
  self._stealth.behavior.stance_handler = [];
  friendly_default_stance_handler_distances();
  self._stealth.behavior.no_prone = 0;
  self._stealth.behavior.wait_resume_path = 2;
  self._stealth.plugins.smartstance = 1;
}

friendly_default_stance_handler_distances() {
  var_0 = [];
  var_0["stand"] = 500;
  var_0["crouch"] = -400;
  var_0["prone"] = 0;
  var_1 = [];
  var_1["stand"] = 500;
  var_1["crouch"] = 200;
  var_1["prone"] = 50;
  var_2 = [];
  var_2["stand"] = 800;
  var_2["crouch"] = 400;
  var_2["prone"] = 100;
  friendly_set_stance_handler_distances(var_0, var_1, var_2);
}

friendly_set_stance_handler_distances(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    foreach(var_5, var_4 in var_0) {
      self._stealth.behavior.stance_handler["looking_away"][var_5] = var_4;
    }
  }

  if(isDefined(var_1)) {
    foreach(var_5, var_4 in var_1) {
      self._stealth.behavior.stance_handler["neutral"][var_5] = var_4;
    }
  }

  if(isDefined(var_2)) {
    foreach(var_5, var_4 in var_2) {
      self._stealth.behavior.stance_handler["looking_towards"][var_5] = var_4;
    }
  }
}