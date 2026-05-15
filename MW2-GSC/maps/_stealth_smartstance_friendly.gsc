/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_stealth_smartstance_friendly.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_stealth_utility;
#include maps\_stealth_shared_utilities;

stealth_smartstance_friendly_main() {
  self friendly_init();

  self thread friendly_stance_handler();
}

friendly_stance_handler() {
  self endon("death");
  self endon("pain_death");

  self.old_fixednode = self.fixednode;
  self.old_fixednodesaferadius = self.fixednodesaferadius;

  while(1) {
    self ent_flag_wait("_stealth_stance_handler");
    flag_waitopen("_stealth_spotted");

    self.fixednode = 1;
    self.fixednodesaferadius = 10;

    while(self ent_flag("_stealth_stance_handler") && !flag("_stealth_spotted")) {
      self friendly_stance_handler_set_stance_up();
      stances = [];
      stances = friendly_stance_handler_check_mightbeseen(stances);

      if(stances[self._stealth.logic.stance]) {
        self thread friendly_stance_handler_change_stance_down();
      } else if(self ent_flag("_stealth_stay_still")) {
        self thread friendly_stance_handler_resume_path();
      } else if(!stances[self._stealth.behavior.stance_up] && self._stealth.behavior.stance_up != self._stealth.logic.stance) {
        self thread friendly_stance_handler_change_stance_up();
      } else if(self ent_flag("_stealth_stance_change")) {
        self notify("_stealth_stance_dont_change");
      }

      wait .05;
    }

    self.fixednode = self.old_fixednode;
    self.fixednodesaferadius = self.old_fixednodesaferadius;

    self.moveplaybackrate = 1;
    self allowedstances("stand", "crouch", "prone");

    if(self ent_flag("_stealth_stay_still")) {
      self thread friendly_stance_handler_resume_path(0);
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

friendly_stance_handler_check_mightbeseen(stances) {
  ai = getaispeciesarray("bad_guys", "all");

  stances[self._stealth.logic.stance] = 0;
  stances[self._stealth.behavior.stance_up] = 0;

  foreach(key, actor in ai) {
    dist_add_curr = self friendly_stance_handler_return_ai_sight(actor, self._stealth.logic.stance);
    dist_add_up = self friendly_stance_handler_return_ai_sight(actor, self._stealth.behavior.stance_up);

    score_current = (self maps\_stealth_visibility_friendly::friendly_compute_score()) + dist_add_curr;
    score_up = (self maps\_stealth_visibility_friendly::friendly_compute_score(self._stealth.behavior.stance_up)) + dist_add_up;

    dist = distance(actor.origin, self.origin);

    if(dist < score_current) {
      stances[self._stealth.logic.stance] = score_current;
      break;
    }

    if(dist < score_up) {
      stances[self._stealth.behavior.stance_up] = score_up;
    }
  }

  return stances;
}

friendly_stance_handler_return_ai_sight(ai, stance) {
  vec1 = anglesToForward(ai.angles);
  vec2 = vectornormalize(self.origin - ai.origin);

  vecdot = vectordot(vec1, vec2);

  if(vecdot > .3) {
    return self._stealth.behavior.stance_handler["looking_towards"][stance];
  } else if(vecdot < -.7) {
    return self._stealth.behavior.stance_handler["looking_away"][stance];
  } else {
    return self._stealth.behavior.stance_handler["neutral"][stance];
  }
}

friendly_stance_handler_change_stance_down() {
  self.moveplaybackrate = 1;

  self notify("_stealth_stance_down");

  switch (self._stealth.logic.stance) {
    case "stand":
      self.moveplaybackrate = .7;
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

  if(self ent_flag("_stealth_stance_change")) {
    return;
  }
  time = 4;

  self ent_flag_set("_stealth_stance_change");
  self add_wait(::_wait, time);
  self add_wait(::waittill_msg, "_stealth_stance_down");
  self add_wait(::waittill_msg, "_stealth_stance_dont_change");
  self add_wait(::waittill_msg, "_stealth_stance_handler");
  self add_func(::ent_flag_clear, "_stealth_stance_change");
  thread do_wait_any();

  wait time;

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

  if(self ent_flag("_stealth_stay_still")) {
    return;
  }
  self ent_flag_set("_stealth_stay_still");

  badplace_cylinder("_stealth_" + self.unique_id + "_prone", 0, self.origin, 30, 90, "bad_guys");

  self.fixednodesaferadius = 5000;
}

friendly_stance_handler_resume_path(time) {
  self endon("friendly_stance_handler_stay_still");

  if(!isDefined(time)) {
    time = self._stealth.behavior.wait_resume_path;
  }

  wait(time);

  if(!self ent_flag("_stealth_stay_still")) {
    return;
  }
  self ent_flag_clear("_stealth_stay_still");

  badplace_delete("_stealth_" + self.unique_id + "_prone");

  self.fixednodesaferadius = 10;
}

friendly_init() {
  self ent_flag_init("_stealth_stance_handler");
  self ent_flag_init("_stealth_stay_still");
  self ent_flag_init("_stealth_stance_change");

  self._stealth.behavior.stance_up = undefined;
  self._stealth.behavior.stance_handler = [];
  self friendly_default_stance_handler_distances();

  self._stealth.behavior.no_prone = false;
  self._stealth.behavior.wait_resume_path = 2;

  self._stealth.plugins.smartstance = true;
}

friendly_default_stance_handler_distances() {
  looking_away = [];
  looking_away["stand"] = 500;
  looking_away["crouch"] = -400;
  looking_away["prone"] = 0;

  neutral = [];
  neutral["stand"] = 500;
  neutral["crouch"] = 200;
  neutral["prone"] = 50;

  looking_towards = [];
  looking_towards["stand"] = 800;
  looking_towards["crouch"] = 400;
  looking_towards["prone"] = 100;

  friendly_set_stance_handler_distances(looking_away, neutral, looking_towards);
}

friendly_set_stance_handler_distances(looking_away, neutral, looking_towards) {
  if(isDefined(looking_away)) {
    foreach(key, value in looking_away) {
      self._stealth.behavior.stance_handler["looking_away"][key] = value;
    }
  }

  if(isDefined(neutral)) {
    foreach(key, value in neutral) {
      self._stealth.behavior.stance_handler["neutral"][key] = value;
    }
  }

  if(isDefined(looking_towards)) {
    foreach(key, value in looking_towards) {
      self._stealth.behavior.stance_handler["looking_towards"][key] = value;
    }
  }
}