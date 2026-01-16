/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_stealth_behavior.gsc
********************************/

main(var_0) {
  system_init(var_0);
  thread system_message_loop();
}

friendly_default_stance_handler_distances() {
  var_0 = [];
  var_0["looking_away"]["stand"] = 500;
  var_0["looking_away"]["crouch"] = -400;
  var_0["looking_away"]["prone"] = 0;
  var_0["neutral"]["stand"] = 500;
  var_0["neutral"]["crouch"] = 200;
  var_0["neutral"]["prone"] = 50;
  var_0["looking_towards"]["stand"] = 800;
  var_0["looking_towards"]["crouch"] = 400;
  var_0["looking_towards"]["prone"] = 100;
  var_1 = [];
  var_1["looking_away"]["stand"] = 800;
  var_1["looking_away"]["crouch"] = 300;
  var_1["looking_away"]["prone"] = 100;
  var_1["neutral"]["stand"] = 900;
  var_1["neutral"]["crouch"] = 700;
  var_1["neutral"]["prone"] = 500;
  var_1["looking_towards"]["stand"] = 1100;
  var_1["looking_towards"]["crouch"] = 900;
  var_1["looking_towards"]["prone"] = 700;
  friendly_set_stance_handler_distances(var_0, var_1);
}

friendly_set_stance_handler_distances(var_0, var_1) {
  if(isdefined(var_0)) {
    self._stealth.behavior.stance_handler["hidden"]["looking_away"]["stand"] = var_0["looking_away"]["stand"];
    self._stealth.behavior.stance_handler["hidden"]["looking_away"]["crouch"] = var_0["looking_away"]["crouch"];
    self._stealth.behavior.stance_handler["hidden"]["looking_away"]["prone"] = var_0["looking_away"]["prone"];
    self._stealth.behavior.stance_handler["hidden"]["neutral"]["stand"] = var_0["neutral"]["stand"];
    self._stealth.behavior.stance_handler["hidden"]["neutral"]["crouch"] = var_0["neutral"]["crouch"];
    self._stealth.behavior.stance_handler["hidden"]["neutral"]["prone"] = var_0["neutral"]["prone"];
    self._stealth.behavior.stance_handler["hidden"]["looking_towards"]["stand"] = var_0["looking_towards"]["stand"];
    self._stealth.behavior.stance_handler["hidden"]["looking_towards"]["crouch"] = var_0["looking_towards"]["crouch"];
    self._stealth.behavior.stance_handler["hidden"]["looking_towards"]["prone"] = var_0["looking_towards"]["prone"];
  }

  if(isdefined(var_1)) {
    self._stealth.behavior.stance_handler["alert"]["looking_away"]["stand"] = var_1["looking_away"]["stand"];
    self._stealth.behavior.stance_handler["alert"]["looking_away"]["crouch"] = var_1["looking_away"]["crouch"];
    self._stealth.behavior.stance_handler["alert"]["looking_away"]["prone"] = var_1["looking_away"]["prone"];
    self._stealth.behavior.stance_handler["alert"]["neutral"]["stand"] = var_1["neutral"]["stand"];
    self._stealth.behavior.stance_handler["alert"]["neutral"]["crouch"] = var_1["neutral"]["crouch"];
    self._stealth.behavior.stance_handler["alert"]["neutral"]["prone"] = var_1["neutral"]["prone"];
    self._stealth.behavior.stance_handler["alert"]["looking_towards"]["stand"] = var_1["looking_towards"]["stand"];
    self._stealth.behavior.stance_handler["alert"]["looking_towards"]["crouch"] = var_1["looking_towards"]["crouch"];
    self._stealth.behavior.stance_handler["alert"]["looking_towards"]["prone"] = var_1["looking_towards"]["prone"];
  }
}

enemy_try_180_turn(var_0) {
  if(self._stealth.logic.dog) {
    return;
  }
  var_1 = anglestoforward(self.angles);
  var_2 = vectornormalize(var_0 - self.origin);

  if(vectordot(var_1, var_2) < -0.8) {
    var_3 = self.origin + (0, 0, 16);
    var_4 = var_0 + (0, 0, 16);
    var_5 = physicstrace(var_3, var_4);

    if(var_5 == var_4)
      maps\_anim::anim_generic(self, "patrol_turn180");
  }
}

enemy_go_back(var_0) {
  self notify("going_back");
  self endon("death");
  self notify("stop_loop");
  enemy_try_180_turn(var_0);

  if(isdefined(self.script_patroller)) {
    if(isdefined(self.last_patrol_goal))
      self.target = self.last_patrol_goal.targetname;

    thread maps\_patrol::patrol();
  } else {
    if(!self._stealth.logic.dog) {
      maps\_utility::set_generic_run_anim("patrol_walk", 1);
      self.disablearrivals = 1;
      self.disableexits = 1;
    }

    if(!self maymovetopoint(var_0)) {
      var_1 = enemy_get_closest_pathnodes(128, var_0);

      if(!var_1.size) {
        return;
      }
      var_1 = common_scripts\utility::get_array_of_closest(var_0, var_1);
      var_0 = var_1[0].origin;
    }

    self setgoalpos(var_0);
    self.goalradius = 40;
  }
}

ai_create_behavior_function(var_0, var_1, var_2, var_3) {
  self._stealth.behavior.ai_functions[var_0][var_1] = var_2;
}

ai_change_ai_functions(var_0, var_1) {
  if(!isdefined(var_1)) {
    return;
  }
  var_2 = getarraykeys(var_1);

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    ai_change_behavior_function(var_0, var_4, var_1[var_4]);
  }
}

ai_change_behavior_function(var_0, var_1, var_2, var_3) {
  ai_create_behavior_function(var_0, var_1, var_2, var_3);
}

ai_clear_custom_animation_reaction() {
  self._stealth.behavior.event.custom_animation = undefined;
}

ai_clear_custom_animation_reaction_and_idle() {
  if(!isdefined(self._stealth.behavior.event.custom_animation)) {
    return;
  }
  self._stealth.behavior.event.custom_animation.node notify("stop_loop");
  self stopanimscripted();
  ai_clear_custom_animation_reaction();
}

ai_set_custom_animation_reaction(var_0, var_1, var_2, var_3) {
  self._stealth.behavior.event.custom_animation = spawnstruct();
  self._stealth.behavior.event.custom_animation.node = var_0;
  self._stealth.behavior.event.custom_animation.anime = var_1;
  self._stealth.behavior.event.custom_animation.tag = var_2;
  self._stealth.behavior.event.custom_animation.ender = var_3;
  thread ai_animate_props_on_death(var_0, var_1, var_2, var_3);
}

ai_animate_props_on_death(var_0, var_1, var_2, var_3) {
  wait 0.1;

  if(!isdefined(self.anim_props)) {
    return;
  }
  var_4 = self.anim_props;
  self waittill("death");

  if(isdefined(self.anim_props_animated)) {
    return;
  }
  var_0 thread maps\_anim::anim_single(var_4, var_1);
}

system_init(var_0) {
  level._stealth.behavior = spawnstruct();
  level._stealth.behavior.sound = [];
  level._stealth.behavior.sound["huh"] = 0;
  level._stealth.behavior.sound["hmph"] = 0;
  level._stealth.behavior.sound["wtf"] = 0;
  level._stealth.behavior.sound["spotted"] = 0;
  level._stealth.behavior.sound["corpse"] = 0;
  level._stealth.behavior.sound["alert"] = 0;
  level._stealth.behavior.corpse = spawnstruct();
  level._stealth.behavior.corpse.last_pos = (0, 0, -100000);
  level._stealth.behavior.corpse.search_radius = 512;
  level._stealth.behavior.corpse.node_array = undefined;
  level._stealth.behavior.event_explosion_index = 5;
  level._stealth.behavior.system_state_functions = [];
  system_init_state_functions(var_0);
  maps\_stealth_anims::main();
  common_scripts\utility::flag_init("_stealth_searching_for_nodes");
  common_scripts\utility::flag_init("_stealth_getallnodes");
  common_scripts\utility::flag_init("_stealth_event");
}

system_init_state_functions(var_0) {
  var_1 = 0;

  if(isdefined(var_0)) {
    if(isdefined(var_0["hidden"]) && isdefined(var_0["alert"]) && isdefined(var_0["spotted"]))
      var_1 = 1;
    else {

    }
  }

  if(!var_1) {
    system_set_state_function("hidden", ::system_state_hidden);
    system_set_state_function("alert", ::system_state_alert);
    system_set_state_function("spotted", ::system_state_spotted);
  } else {
    system_set_state_function("hidden", var_0["hidden"]);
    system_set_state_function("alert", var_0["alert"]);
    system_set_state_function("spotted", var_0["spotted"]);
  }
}

system_message_loop() {
  var_0 = level._stealth.behavior.system_state_functions;
  thread system_message_handler("_stealth_hidden", var_0["hidden"]);
  thread system_message_handler("_stealth_alert", var_0["alert"]);
  thread system_message_handler("_stealth_spotted", var_0["spotted"]);
}

system_message_handler(var_0, var_1) {
  for (;;) {
    common_scripts\utility::flag_wait(var_0);
    thread[[var_1]]();
    common_scripts\utility::flag_waitopen(var_0);
  }
}

system_state_spotted() {
  maps\_utility::battlechatter_on("axis");
}

system_state_alert() {
  level._stealth.behavior.sound["spotted"] = 0;
  maps\_utility::battlechatter_off("axis");
  setdvar("bcs_stealth", "");
}

system_state_hidden() {
  level._stealth.behavior.sound["spotted"] = 0;
  maps\_utility::battlechatter_off("axis");
  setdvar("bcs_stealth", "1");
  animscripts\battlechatter::resetnextsaytimes("allies", "threat");
}

system_set_state_function(var_0, var_1) {
  if(!(var_0 == "hidden" || var_0 == "alert" || var_0 == "spotted")) {}

  level._stealth.behavior.system_state_functions[var_0] = var_1;
}

enemy_logic(var_0, var_1, var_2, var_3) {
  enemy_init(var_0, var_1, var_2, var_3);
  thread enemy_message_loop();
  thread enemy_threat_loop();
  thread enemy_awareness_loop();
  thread enemy_animation_loop();
  thread enemy_corpse_loop();
}

enemy_init(var_0, var_1, var_2, var_3) {
  self._stealth.behavior = spawnstruct();
  self._stealth.behavior.sndnum = randomintrange(1, 4);
  self._stealth.behavior.ai_functions = [];
  self._stealth.behavior.ai_functions["state"] = [];
  self._stealth.behavior.ai_functions["alert"] = [];
  self._stealth.behavior.ai_functions["corpse"] = [];
  self._stealth.behavior.ai_functions["awareness"] = [];
  enemy_default_ai_functions("state");
  enemy_default_ai_functions("alert");
  enemy_default_ai_functions("corpse");
  enemy_default_ai_functions("awareness");
  enemy_default_ai_functions("animation");
  ai_change_ai_functions("state", var_0);
  ai_change_ai_functions("alert", var_1);
  ai_change_ai_functions("corpse", var_2);
  ai_change_ai_functions("awareness", var_3);
  maps\_utility::ent_flag_init("_stealth_enemy_alert_level_action");
  maps\_utility::ent_flag_init("_stealth_running_to_corpse");
  maps\_utility::ent_flag_init("_stealth_behavior_reaction_anim");
  maps\_utility::ent_flag_init("_stealth_behavior_first_reaction");
  maps\_utility::ent_flag_init("_stealth_behavior_reaction_anim_in_progress");
  self._stealth.behavior.event = spawnstruct();

  if(self._stealth.logic.dog)
    enemy_dog_init();
}

enemy_default_ai_functions(var_0) {
  switch (var_0) {
    case "state":
      ai_create_behavior_function("state", "hidden", ::enemy_state_hidden);
      ai_create_behavior_function("state", "alert", ::enemy_state_alert);
      ai_create_behavior_function("state", "spotted", ::enemy_state_spotted);
      break;
    case "alert":
      ai_create_behavior_function("alert", "reset", ::enemy_alert_level_lostem);
      ai_create_behavior_function("alert", "alerted_once", ::enemy_alert_level_alerted_once);
      ai_create_behavior_function("alert", "alerted_again", ::enemy_alert_level_alerted_again);
      ai_create_behavior_function("alert", "attack", ::enemy_alert_level_attack);
      break;
    case "corpse":
      ai_create_behavior_function("corpse", "saw", ::enemy_corpse_saw_behavior);
      ai_create_behavior_function("corpse", "found", ::enemy_corpse_found_behavior);
      break;
    case "awareness":
      ai_create_behavior_function("awareness", "heard_scream", ::enemy_awareness_reaction_heard_scream);
      ai_create_behavior_function("awareness", "doFlashBanged", ::enemy_awareness_reaction_flashbang);
      ai_create_behavior_function("awareness", "explode", ::enemy_awareness_reaction_explosion);
      break;
    case "animation":
      ai_create_behavior_function("animation", "wrapper", ::enemy_animation_wrapper);

      if(self._stealth.logic.dog) {
        ai_create_behavior_function("animation", "reset", ::enemy_animation_nothing);
        ai_create_behavior_function("animation", "attack", ::dog_animation_generic);
        ai_create_behavior_function("animation", "heard_scream", ::dog_animation_generic);
        ai_create_behavior_function("animation", "bulletwhizby", ::dog_animation_wakeup_fast);
        ai_create_behavior_function("animation", "projectile_impact", ::dog_animation_wakeup_slow);
        ai_create_behavior_function("animation", "explode", ::dog_animation_wakeup_fast);
      } else {
        ai_create_behavior_function("animation", "reset", ::enemy_animation_nothing);
        ai_create_behavior_function("animation", "alerted_once", ::enemy_animation_nothing);
        ai_create_behavior_function("animation", "alerted_again", ::enemy_animation_nothing);
        ai_create_behavior_function("animation", "attack", ::enemy_animation_attack);
        ai_create_behavior_function("animation", "heard_scream", ::enemy_animation_generic);
        ai_create_behavior_function("animation", "heard_corpse", ::enemy_animation_generic);
        ai_create_behavior_function("animation", "saw_corpse", ::enemy_animation_sawcorpse);
        ai_create_behavior_function("animation", "found_corpse", ::enemy_animation_foundcorpse);
        ai_create_behavior_function("animation", "bulletwhizby", ::enemy_animation_whizby);
        ai_create_behavior_function("animation", "projectile_impact", ::enemy_animation_whizby);
        ai_create_behavior_function("animation", "explode", ::enemy_animation_generic);
      }

      ai_create_behavior_function("animation", "doFlashBanged", ::enemy_animation_nothing);
      break;
  }
}

enemy_dog_init() {
  if(threatbiasgroupexists("dog"))
    self setthreatbiasgroup("dog");

  if(isdefined(self.enemy) || isdefined(self.favoriteenemy)) {
    return;
  }
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.allowdeath = 1;
  thread maps\_anim::anim_generic_loop(self, "_stealth_dog_sleeping", undefined, "stop_loop");
}

enemy_message_loop() {
  thread ai_message_handler("_stealth_hidden", "hidden");
  thread ai_message_handler("_stealth_alert", "alert");
  thread ai_message_handler("_stealth_spotted", "spotted");
}

ai_message_handler(var_0, var_1) {
  self endon("death");
  self endon("pain_death");

  for (;;) {
    common_scripts\utility::flag_wait(var_0);
    var_2 = self._stealth.behavior.ai_functions["state"][var_1];
    self thread[[var_2]]();
    common_scripts\utility::flag_waitopen(var_0);
  }
}

enemy_state_hidden() {
  level endon("_stealth_detection_level_change");
  self.fovcosine = 0.5;
  self.favoriteenemy = undefined;

  if(self._stealth.logic.dog) {
    return;
  }
  self.diequietly = 1;

  if(!isdefined(self.old_baseaccuracy))
    self.old_baseaccuracy = self.baseaccuracy;

  if(!isdefined(self.old_accuracy))
    self.old_accuracy = self.accuracy;

  self.baseaccuracy = self.old_baseaccuracy;
  self.accuracy = self.old_accuracy;
  self.fixednode = 1;
  self clearenemy();
}

enemy_state_alert() {
  level endon("_stealth_detection_level_change");
}

enemy_reaction_state_alert() {
  self.fovcosine = 0.01;
  self.ignoreall = 0;
  self.diequietly = 0;
  maps\_utility::clear_run_anim();
  self.fixednode = 0;
}

enemy_state_spotted() {
  var_0 = "_stealth_spotted";
  var_1 = "_stealth_detection_level_change" + var_0;
  thread state_change_ender(var_0, var_1);
  level endon(var_1);
  self endon("death");
  self.fovcosine = 0.01;
  self.ignoreall = 0;

  if(!self._stealth.logic.dog) {
    self.diequietly = 0;
    maps\_utility::clear_run_anim();
    self.baseaccuracy = self.baseaccuracy * 3;
    self.accuracy = self.accuracy * 3;
    self.fixednode = 0;
    enemy_stop_current_behavior();
  }

  if(!isalive(self.enemy))
    common_scripts\utility::waittill_notify_or_timeout("enemy", randomfloatrange(1, 3));

  if(self._stealth.logic.dog)
    self.favoriteenemy = level.player;
  else if(randomint(100) > 25)
    self.favoriteenemy = level.player;

  thread enemy_spotted_clear_favorite();
}

enemy_spotted_clear_favorite() {
  self endon("death");
  wait 1.5;
  self.favoriteenemy = undefined;
}

state_change_ender(var_0, var_1) {
  common_scripts\utility::flag_waitopen(var_0);
  level notify(var_1);
}

enemy_animation_loop() {
  self endon("death");
  self endon("pain_death");

  for (;;) {
    self waittill("event_awareness", var_0);
    var_1 = self._stealth.behavior.ai_functions["animation"]["wrapper"];
    self thread[[var_1]](var_0);
  }
}

enemy_animation_wrapper(var_0) {
  self endon("death");
  self endon("pain_death");

  if(enemy_animation_pre_anim(var_0)) {
    return;
  }
  enemy_animation_do_anim(var_0);
  enemy_animation_post_anim(var_0);
}

enemy_animation_do_anim(var_0) {
  if(isdefined(self._stealth.behavior.event.custom_animation)) {
    enemy_animation_custom(var_0);
    return;
  }

  var_1 = self._stealth.behavior.ai_functions["animation"][var_0];
  self[[var_1]](var_0);
}

enemy_animation_custom(var_0) {
  self endon("death");
  self endon("pain_death");
  var_1 = self._stealth.behavior.event.custom_animation.node;
  var_2 = self._stealth.behavior.event.custom_animation.anime;
  var_3 = self._stealth.behavior.event.custom_animation.tag;
  var_4 = self._stealth.behavior.event.custom_animation.ender;
  maps\_utility::ent_flag_set("_stealth_behavior_reaction_anim");
  self.allowdeath = 1;
  var_1 notify(var_4);

  if(isdefined(self.anim_props)) {
    self.anim_props_animated = 1;
    var_1 thread maps\_anim::anim_single(self.anim_props, var_2);
  }

  if(var_0 != "doFlashBanged") {
    if(isdefined(var_3) || isdefined(self.has_delta))
      var_1 maps\_anim::anim_generic(self, var_2, var_3);
    else
      var_1 maps\_anim::anim_generic_custom_animmode(self, "gravity", var_2);
  }

  ai_clear_custom_animation_reaction();
}

enemy_animation_pre_anim(var_0) {
  self notify("enemy_awareness_reaction", var_0);

  if(maps\_utility::ent_flag("_stealth_behavior_first_reaction") || maps\_utility::ent_flag("_stealth_behavior_reaction_anim_in_progress"))
    return 1;

  enemy_stop_current_behavior();

  switch (var_0) {
    case "found_corpse":
    case "saw_corpse":
    case "heard_corpse":
    case "explode":
      maps\_utility::ent_flag_set("_stealth_behavior_reaction_anim");
      break;
    case "alerted_again":
    case "alerted_once":
    case "reset":
      break;
    default:
      maps\_utility::ent_flag_set("_stealth_behavior_first_reaction");
      maps\_utility::ent_flag_set("_stealth_behavior_reaction_anim");
      break;
  }

  maps\_utility::ent_flag_set("_stealth_behavior_reaction_anim_in_progress");
  return 0;
}

enemy_animation_post_anim(var_0) {
  switch (var_0) {
    default:
      maps\_utility::ent_flag_clear("_stealth_behavior_reaction_anim");
      break;
  }

  maps\_utility::ent_flag_clear("_stealth_behavior_reaction_anim_in_progress");
}

enemy_animation_whizby(var_0) {
  self.allowdeath = 1;
  var_1 = "_stealth_behavior_whizby_" + randomint(5);
  thread maps\_anim::anim_generic_custom_animmode(self, "gravity", var_1);
  wait 1.5;
  self notify("stop_animmode");
}

enemy_animation_attack(var_0) {
  var_1 = self._stealth.logic.event.awareness[var_0];

  if(distance(var_1.origin, self.origin) < 256)
    var_2 = "_stealth_behavior_spotted_short";
  else
    var_2 = "_stealth_behavior_spotted_long";

  self.allowdeath = 1;
  thread maps\_anim::anim_generic_custom_animmode(self, "gravity", var_2);
  common_scripts\utility::waittill_notify_or_timeout(var_2, randomfloatrange(1.5, 3));
  self notify("stop_animmode");
}

enemy_animation_nothing(var_0) {}

enemy_animation_generic(var_0) {
  self.allowdeath = 1;
  var_1 = level.player;

  if(isdefined(self.enemy))
    var_1 = self.enemy;
  else if(isdefined(self.favoriteenemy))
    var_1 = self.favoriteenemy;

  var_2 = distance(self.origin, var_1.origin);
  var_3 = 4;
  var_4 = 1024;

  for (var_5 = 1; var_5 < var_3; var_5++) {
    var_6 = var_4 * (var_5 / var_3);

    if(var_2 < var_6) {
      break;
    }
  }

  var_7 = "_stealth_behavior_generic" + var_5;
  maps\_anim::anim_generic_custom_animmode(self, "gravity", var_7);
}

enemy_animation_sawcorpse(var_0) {
  self.allowdeath = 1;
  var_1 = "_stealth_behavior_saw_corpse";
  maps\_anim::anim_generic_custom_animmode(self, "gravity", var_1);
}

enemy_animation_foundcorpse(var_0) {
  self.allowdeath = 1;
  var_1 = "_stealth_find_jog";
  maps\_anim::anim_generic_custom_animmode(self, "gravity", var_1);
}

dog_animation_generic(var_0) {
  self.allowdeath = 1;
  var_1 = undefined;

  if(randomint(100) < 50)
    var_1 = "_stealth_dog_wakeup_fast";
  else
    var_1 = "_stealth_dog_wakeup_slow";

  maps\_anim::anim_generic_custom_animmode(self, "gravity", var_1);
}

dog_animation_wakeup_fast(var_0) {
  self.allowdeath = 1;
  var_1 = "_stealth_dog_wakeup_fast";
  maps\_anim::anim_generic_custom_animmode(self, "gravity", var_1);
}

dog_animation_wakeup_slow(var_0) {
  self.allowdeath = 1;
  var_1 = "_stealth_dog_wakeup_slow";
  maps\_anim::anim_generic_custom_animmode(self, "gravity", var_1);
}

enemy_awareness_loop() {
  self endon("death");
  self endon("pain_death");

  for (;;) {
    self waittill("event_awareness", var_0);

    if(common_scripts\utility::flag("_stealth_spotted")) {
      continue;
    }
    var_1 = self._stealth.behavior.ai_functions["awareness"];

    if(isdefined(var_1[var_0]))
      self thread[[var_1[var_0]]](var_0);
  }
}

enemy_awareness_reaction_heard_scream(var_0) {
  if(self._stealth.logic.dog) {
    return;
  }
  self endon("_stealth_enemy_alert_level_change");
  level endon("_stealth_spotted");
  self endon("another_enemy_awareness_reaction");
  var_1 = "scream_kill_safety_check";
  thread enemy_awareness_reaction_safety(var_0, var_1);
  enemy_reaction_state_alert();
  var_2 = enemy_find_original_goal();
  enemy_stop_current_behavior();
  self endon("death");
  var_3 = self._stealth.logic.event.awareness[var_0];
  var_3 = enemy_find_nodes_at_origin(var_3);
  enemy_investigate_explosion(var_3);
  thread enemy_announce_hmph();
  self notify(var_1);
  enemy_go_back(var_2);
}

enemy_awareness_reaction_flashbang(var_0) {
  if(self._stealth.logic.dog) {
    return;
  }
  self endon("_stealth_enemy_alert_level_change");
  level endon("_stealth_spotted");
  self endon("another_enemy_awareness_reaction");
  var_1 = "flashbang_kill_safety_check";
  thread enemy_awareness_reaction_safety(var_0, var_1);
  enemy_reaction_state_alert();
  var_2 = enemy_find_original_goal();
  enemy_stop_current_behavior();
  self endon("death");
  var_3 = self._stealth.logic.event.awareness[var_0];
  self waittill("stop_flashbang_effect");
  var_3 = enemy_find_nodes_at_origin(var_3);
  thread enemy_investigate_explosion(var_3);

  if(var_3 != (0, 0, 0)) {
    wait 1.05;
    self waittill("goal");
    thread enemy_announce_wtf();
    thread enemy_announce_spotted_bring_team(var_3);
  }

  thread enemy_announce_hmph();
  self notify(var_1);
  enemy_go_back(var_2);
}

enemy_awareness_reaction_explosion(var_0) {
  self endon("_stealth_enemy_alert_level_change");

  if(!self._stealth.logic.dog) {
    self endon("_stealth_saw_corpse");
    level endon("_stealth_found_corpse");
  }

  level endon("_stealth_spotted");
  self endon("another_enemy_awareness_reaction");
  var_1 = "explostion_kill_safety_check";
  thread enemy_awareness_reaction_safety(var_0, var_1);
  enemy_reaction_state_alert();
  var_2 = enemy_find_original_goal();
  enemy_stop_current_behavior();
  self endon("death");
  var_3 = self._stealth.logic.event.awareness[var_0];
  var_3 = enemy_find_nodes_at_origin(var_3);
  thread enemy_announce_wtf();
  enemy_investigate_explosion(var_3);
  thread enemy_announce_hmph();
  self notify(var_1);
  enemy_go_back(var_2);
}

enemy_awareness_reaction_safety(var_0, var_1) {
  self endon("death");
  self endon(var_1);

  for (;;) {
    self waittill("enemy_awareness_reaction", var_2);

    if(var_0 == var_2)
      continue;
    else
      break;
  }

  self notify("another_enemy_awareness_reaction");
}

enemy_find_nodes_at_origin(var_0) {
  var_1 = enemy_get_closest_pathnodes(512, var_0);
  var_2 = var_0;

  if(isdefined(var_1) && var_1.size) {
    for (var_3 = 0; var_3 < var_1.size; var_3++) {
      if(isdefined(var_1[var_3]._stealth_corpse_behavior_taken)) {
        continue;
      }
      var_0 = var_1[var_3].origin;
      var_1[var_3] thread enemy_corpse_reaction_takenode();
      var_4 = common_scripts\utility::get_array_of_closest(var_1[var_3].origin, var_1, undefined, undefined, 40);
      common_scripts\utility::array_thread(var_4, ::enemy_corpse_reaction_takenode);
      break;
    }
  } else
    var_0 = (0, 0, 0);

  if(var_2 == var_0)
    var_0 = (0, 0, 0);

  return var_0;
}

enemy_investigate_explosion(var_0) {
  if(var_0 != (0, 0, 0)) {
    wait(randomfloat(1));
    thread enemy_runto_and_lookaround(var_0);
    self.disablearrivals = 0;
    self.disableexits = 0;
    self waittill("goal");
    wait(randomfloatrange(30, 50));
  } else
    wait(randomfloatrange(1, 4));
}

enemy_threat_loop() {
  self endon("death");
  self endon("pain_death");

  if(self._stealth.logic.dog)
    thread enemy_threat_logic_dog();

  for (;;) {
    self waittill("_stealth_enemy_alert_level_change");
    var_0 = self._stealth.logic.alert_level.lvl;
    var_1 = self._stealth.logic.alert_level.enemy;
    thread enemy_alert_level_change(var_0, var_1);
  }
}

enemy_threat_logic_dog() {
  self endon("death");
  self endon("pain_death");
  self waittill("pain");
  self.ignoreall = 0;
}

enemy_alert_level_change(var_0, var_1) {
  maps\_utility::ent_flag_set("_stealth_enemy_alert_level_action");
  var_2 = self._stealth.behavior.ai_functions["alert"];
  self thread[[var_2[var_0]]](var_1);
}

enemy_alert_level_normal() {
  self endon("_stealth_enemy_alert_level_change");
  self endon("death");
  self endon("pain_death");
  var_0 = enemy_find_original_goal();
  enemy_stop_current_behavior();
  self waittill("normal");
  maps\_utility::ent_flag_clear("_stealth_enemy_alert_level_action");
  maps\_utility::ent_flag_waitopen("_stealth_saw_corpse");
  wait 0.05;
  common_scripts\utility::flag_waitopen("_stealth_found_corpse");
  thread enemy_announce_hmph();
  enemy_go_back(var_0);
}

enemy_find_original_goal() {
  if(isdefined(self.last_set_goalnode))
    return self.last_set_goalnode.origin;

  if(isdefined(self.last_set_goalpos))
    return self.last_set_goalpos;

  return self.origin;
}

enemy_alert_level_lostem(var_0) {
  self notify("normal");
}

enemy_alert_level_alerted_once(var_0) {
  self endon("_stealth_enemy_alert_level_change");
  level endon("_stealth_spotted");
  self endon("death");
  self endon("pain_death");
  thread enemy_announce_huh();
  thread enemy_alert_level_normal();

  if(isdefined(self.script_patroller)) {
    var_1 = !(isdefined(self.canpatrolturn) && self.canpatrolturn);
    maps\_utility::set_generic_run_anim("patrol_walk", 1, var_1);
    self.disablearrivals = 1;
    self.disableexits = 1;
  }

  var_2 = vectornormalize(var_0.origin - self.origin);
  var_3 = distance(var_0.origin, self.origin);
  var_3 = var_3 * 0.25;

  if(var_3 < 64)
    var_3 = 64;

  if(var_3 > 128)
    var_3 = 128;

  var_2 = maps\_utility::vector_multiply(var_2, var_3);
  var_4 = self.origin + var_2 + (0, 0, 16);
  var_5 = var_4 + (0, 0, -96);
  var_4 = physicstrace(var_4, var_5);

  if(var_4 == var_5) {
    return;
  }
  self setgoalpos(var_4);
  self.goalradius = 4;
  common_scripts\utility::waittill_notify_or_timeout("goal", 2);
  wait 3;
  self notify("normal");
}

enemy_alert_level_alerted_again(var_0) {
  self endon("_stealth_enemy_alert_level_change");
  level endon("_stealth_spotted");
  self endon("death");
  self endon("pain_death");
  thread enemy_announce_huh();
  thread enemy_alert_level_normal();
  maps\_utility::set_generic_run_anim("_stealth_patrol_jog");
  self.disablearrivals = 0;
  self.disableexits = 0;
  var_1 = var_0.origin;
  var_2 = distance(var_1, self.origin);
  self setgoalpos(var_1);
  self.goalradius = var_2 * 0.5;
  self waittill("goal");
  maps\_utility::set_generic_run_anim("_stealth_patrol_walk", 1);
  self setgoalpos(var_1);
  self.goalradius = 64;
  self.disablearrivals = 1;
  self.disableexits = 1;
  self waittill("goal");
  wait 12;
  maps\_utility::set_generic_run_anim("_stealth_patrol_walk", 1);
  self notify("normal");
}

enemy_alert_level_attack(var_0) {
  self endon("death");
  self endon("pain_death");
  self endon("_stealth_stop_stealth_behavior");
  thread enemy_announce_spotted(self.origin);
  thread enemy_close_in_on_target();
}

enemy_close_in_on_target() {
  var_0 = 2048;
  self.goalradius = var_0;

  if(isdefined(self.script_stealth_dontseek)) {
    return;
  }
  self endon("death");
  self endon("_stealth_stop_stealth_behavior");

  while (isdefined(self.enemy)) {
    self setgoalpos(self.enemy.origin);
    self.goalradius = var_0;

    if(var_0 > 600)
      var_0 = var_0 * 0.75;

    wait 15;
  }
}

isininteriorvozone() {
  if(isdefined(level._interior_vo_zone)) {
    for (var_0 = 0; var_0 < level._interior_vo_zone.size; var_0++) {
      if(self istouching(level._interior_vo_zone[var_0]))
        return 1;
    }

    return 0;
  } else
    return 0;
}

enemy_announce_wtf() {
  if(!enemy_announce_snd("wtf")) {
    return;
  }
  self playsound("RU_0_reaction_casualty_generic");
}

enemy_announce_huh() {
  if(!enemy_announce_snd("huh")) {
    return;
  }
  if(isininteriorvozone())
    var_0 = "scoutsniper_ru" + self._stealth.behavior.sndnum + "_huh_house_int";
  else
    var_0 = "scoutsniper_ru" + self._stealth.behavior.sndnum + "_huh";

  self playsound(var_0);
}

enemy_announce_hmph() {
  if(!enemy_announce_snd("hmph")) {
    return;
  }
  if(isininteriorvozone())
    var_0 = "scoutsniper_ru" + self._stealth.behavior.sndnum + "_hmph_house_int";
  else
    var_0 = "scoutsniper_ru" + self._stealth.behavior.sndnum + "_hmph";

  self playsound(var_0);
}

enemy_announce_spotted(var_0) {
  self endon("death");
  common_scripts\utility::flag_wait("_stealth_spotted");

  if(!enemy_announce_snd("spotted")) {
    return;
  }
  thread enemy_announce_spotted_bring_team(var_0);

  if(self._stealth.logic.dog) {
    return;
  }
  self playsound("RU_0_reaction_casualty_generic");
}

enemy_announce_spotted_bring_team(var_0) {
  var_1 = getaispeciesarray("axis", "all");

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == self) {
      continue;
    }
    if(isdefined(var_1[var_2].enemy)) {
      continue;
    }
    if(isdefined(var_1[var_2].favoriteenemy)) {
      continue;
    }
    var_1[var_2] notify("heard_scream", var_0);
  }
}

enemy_announce_corpse() {
  if(isdefined(self.found_corpse_wait)) {
    self endon("death");
    wait(self.found_corpse_wait);
  }

  if(!enemy_announce_snd("corpse")) {
    return;
  }
  self playsound("RU_0_reaction_casualty_generic");
}

enemy_announce_snd(var_0) {
  if(level._stealth.behavior.sound[var_0])
    return 0;

  level._stealth.behavior.sound[var_0] = 1;
  thread enemy_announce_snd_reset(var_0);
  return 1;
}

enemy_announce_snd_reset(var_0) {
  if(var_0 == "spotted") {
    return;
  }
  wait 3;
  level._stealth.behavior.sound[var_0] = 0;
}

enemy_corpse_loop() {
  if(self._stealth.logic.dog) {
    return;
  }
  self endon("death");
  self endon("pain_death");
  thread enemy_found_corpse_loop();

  for (;;) {
    self waittill("_stealth_saw_corpse");
    enemy_saw_corpse_logic();
  }
}

enemy_saw_corpse_logic() {
  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  level endon("_stealth_spotted");
  level endon("_stealth_found_corpse");
  thread enemy_announce_huh();

  for (;;) {
    maps\_utility::ent_flag_waitopen("_stealth_enemy_alert_level_action");
    enemy_corpse_saw_wrapper();
    self waittill("normal");
  }
}

enemy_stop_current_behavior() {
  if(!maps\_utility::ent_flag("_stealth_behavior_reaction_anim")) {
    self stopanimscripted();
    self notify("stop_animmode");
    self notify("stop_loop");
  }

  if(isdefined(self.script_patroller)) {
    if(isdefined(self.last_patrol_goal))
      self.last_patrol_goal.patrol_claimed = undefined;

    self notify("release_node");
    self notify("end_patrol");
  }

  self notify("stop_first_frame");
  maps\_utility::clear_run_anim();
}

enemy_corpse_saw_wrapper() {
  self endon("enemy_alert_level_change");
  var_0 = self._stealth.behavior.ai_functions["corpse"];
  self[[var_0["saw"]]]();
}

enemy_corpse_saw_behavior() {
  enemy_stop_current_behavior();
  maps\_utility::ent_flag_set("_stealth_running_to_corpse");
  self.disablearrivals = 0;
  self.disableexits = 0;
  maps\_utility::set_generic_run_anim("_stealth_combat_jog");
  self.goalradius = 80;
  self setgoalpos(self._stealth.logic.corpse.corpse_entity.origin);
}

enemy_found_corpse_loop() {
  self endon("death");
  self endon("pain_death");

  if(isdefined(self.no_corpse_caring)) {
    return;
  }
  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  level endon("_stealth_spotted");
  var_0 = self._stealth.behavior.ai_functions["corpse"];

  for (;;) {
    common_scripts\utility::flag_wait("_stealth_found_corpse");

    while (common_scripts\utility::flag("_stealth_found_corpse")) {
      if(maps\_utility::ent_flag("_stealth_found_corpse"))
        thread enemy_announce_corpse();
      else
        self notify("heard_corpse", (0, 0, 0));

      enemy_reaction_state_alert();
      self[[var_0["found"]]]();
      level waittill("_stealth_found_corpse");
    }
  }
}

enemy_corpse_found_behavior() {
  enemy_stop_current_behavior();

  if(level._stealth.logic.corpse.last_pos != level._stealth.behavior.corpse.last_pos) {
    var_0 = level._stealth.behavior.corpse.search_radius;
    var_1 = level._stealth.logic.corpse.last_pos;
    level._stealth.behavior.corpse.node_array = enemy_get_closest_pathnodes(var_0, var_1);
    level._stealth.behavior.corpse.last_pos = level._stealth.logic.corpse.last_pos;
  }

  var_2 = level._stealth.behavior.corpse.node_array;

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isdefined(var_2[var_3]._stealth_corpse_behavior_taken)) {
      continue;
    }
    thread enemy_runto_and_lookaround(var_2[var_3].origin);
    var_2[var_3] thread enemy_corpse_reaction_takenode();
    var_4 = common_scripts\utility::get_array_of_closest(var_2[var_3].origin, var_2, undefined, undefined, 40);
    common_scripts\utility::array_thread(var_4, ::enemy_corpse_reaction_takenode);
    break;
  }
}

enemy_runto_and_lookaround(var_0) {
  self notify("enemy_runto_and_lookaround");
  self endon("enemy_runto_and_lookaround");
  self endon("death");
  self endon("_stealth_enemy_alert_level_change");

  if(!self._stealth.logic.dog)
    self endon("_stealth_saw_corpse");

  level endon("_stealth_spotted");
  self setgoalpos(var_0);
  self.goalradius = 4;
  self waittill("goal");
  wait 0.5;

  if(!self._stealth.logic.dog)
    maps\_anim::anim_generic_loop(self, "_stealth_look_around", undefined, "stop_loop");
}

enemy_corpse_reaction_takenode() {
  self._stealth_corpse_behavior_taken = 1;
  wait 0.25;
  self._stealth_corpse_behavior_taken = undefined;
}

enemy_get_closest_pathnodes(var_0, var_1) {
  if(!common_scripts\utility::flag("_stealth_getallnodes")) {
    if(!common_scripts\utility::flag("_stealth_searching_for_nodes")) {
      common_scripts\utility::flag_set("_stealth_searching_for_nodes");
      waittillframeend;
      var_2 = getallnodes();
      var_3 = [];
      var_4 = var_0 * var_0;

      for (var_5 = 0; var_5 < var_2.size; var_5++) {
        if(var_2[var_5].type != "Path") {
          continue;
        }
        if(distancesquared(var_2[var_5].origin, var_1) > var_4) {
          continue;
        }
        var_3[var_3.size] = var_2[var_5];
      }

      level._stealth.behavior.search_nodes_array = var_3;
      waittillframeend;
      common_scripts\utility::flag_clear("_stealth_searching_for_nodes");
    } else
      common_scripts\utility::flag_waitopen("_stealth_searching_for_nodes");

    level maps\_utility::delaythread(0.2, common_scripts\utility::flag_clear, "_stealth_getallnodes");
    level common_scripts\utility::flag_set("_stealth_getallnodes");
  }

  return level._stealth.behavior.search_nodes_array;
}

friendly_logic(var_0) {
  friendly_init(var_0);
  thread friendly_message_loop();
  thread friendly_stance_handler();
}

friendly_init(var_0) {
  self._stealth.behavior = spawnstruct();
  self._stealth.behavior.accuracy = [];
  self._stealth.behavior.goodaccuracy = 50;
  self._stealth.behavior.badaccuracy = 0;
  self._stealth.behavior.old_baseaccuracy = self.baseaccuracy;
  self._stealth.behavior.old_accuracy = self.accuracy;
  self._stealth.behavior.ai_functions = [];
  self._stealth.behavior.ai_functions["state"] = [];
  friendly_default_ai_functions("state");
  ai_change_ai_functions("state", var_0);
  maps\_utility::ent_flag_init("_stealth_custom_anim");
}

friendly_default_ai_functions(var_0) {
  switch (var_0) {
    case "state":
      ai_create_behavior_function(var_0, "hidden", ::friendly_state_hidden);
      ai_create_behavior_function(var_0, "alert", ::friendly_state_alert);
      ai_create_behavior_function(var_0, "spotted", ::friendly_state_spotted);
      break;
  }
}

friendly_message_loop() {
  var_0 = self._stealth.behavior.ai_functions["state"];
  thread ai_message_handler("_stealth_hidden", "hidden");
  thread ai_message_handler("_stealth_alert", "alert");
  thread ai_message_handler("_stealth_spotted", "spotted");
}

friendly_state_hidden() {
  level endon("_stealth_detection_level_change");
  self.baseaccuracy = self._stealth.behavior.goodaccuracy;
  self.accuracy = self._stealth.behavior.goodaccuracy;
  self._stealth.behavior.oldgrenadeammo = self.grenadeammo;
  self.grenadeammo = 0;
  self.forcesidearm = 0;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.disablearrivals = 0;
  self.disableexits = 0;
  maps\_utility::disable_ai_color();
  waittillframeend;
  self.fixednode = 0;
}

friendly_state_alert() {
  level endon("_stealth_detection_level_change");
  self.baseaccuracy = self._stealth.behavior.goodaccuracy;
  self.accuracy = self._stealth.behavior.goodaccuracy;
  self._stealth.behavior.oldgrenadeammo = self.grenadeammo;
  self.grenadeammo = 0;
  self.forcesidearm = 0;
  self.ignoreall = 1;
  maps\_utility::disable_ai_color();
  waittillframeend;
  self.fixednode = 0;
}

friendly_state_spotted() {
  level endon("_stealth_detection_level_change");
  thread friendly_spotted_getup_from_prone(undefined, 1);
  self.baseaccuracy = self._stealth.behavior.badaccuracy;
  self.accuracy = self._stealth.behavior.badaccuracy;
  self.grenadeammo = self._stealth.behavior.oldgrenadeammo;
  self allowedstances("prone", "crouch", "stand");
  self stopanimscripted();
  self.ignoreall = 0;
  self.ignoreme = 0;
  maps\_utility::disable_cqbwalk();
  maps\_utility::enable_ai_color();
  self.disablearrivals = 1;
  self.disableexits = 1;
  self pushplayer(0);
}

friendly_spotted_getup_from_prone(var_0, var_1) {
  self endon("death");

  if(self._stealth.logic.stance != "prone") {
    return;
  }
  maps\_utility::ent_flag_set("_stealth_custom_anim");

  if(isdefined(var_1) && var_1)
    var_2 = "prone_2_stand";
  else
    var_2 = "prone_2_run_roll";

  if(isdefined(var_0))
    self orientmode("face angle", var_0[1] + 20);

  thread maps\_anim::anim_generic_custom_animmode(self, "gravity", var_2);
  var_3 = getanimlength(maps\_utility::getanim_generic(var_2));
  wait(var_3 - 0.2);
  self notify("stop_animmode");
  maps\_utility::ent_flag_clear("_stealth_custom_anim");
}

friendly_stance_handler() {
  self endon("death");
  self endon("pain_death");
  friendly_stance_handler_init();

  for (;;) {
    while (maps\_utility::ent_flag("_stealth_stance_handler") && !common_scripts\utility::flag("_stealth_spotted")) {
      friendly_stance_handler_set_stance_up();
      var_0 = [];
      var_0 = friendly_stance_handler_check_mightbeseen(var_0);

      if(var_0[self._stealth.logic.stance])
        thread friendly_stance_handler_change_stance_down();
      else if(maps\_utility::ent_flag("_stealth_stay_still"))
        thread friendly_stance_handler_resume_path();
      else if(!var_0[self._stealth.behavior.stance_up])
        thread friendly_stance_handler_change_stance_up();
      else if(maps\_utility::ent_flag("_stealth_stance_change"))
        self notify("_stealth_stance_dont_change");

      wait 0.05;
    }

    self.moveplaybackrate = 1;
    self allowedstances("stand", "crouch", "prone");
    thread friendly_stance_handler_resume_path();
    maps\_utility::ent_flag_wait("_stealth_stance_handler");
    common_scripts\utility::flag_waitopen("_stealth_spotted");
  }
}

friendly_stance_handler_stay_still() {
  if(maps\_utility::ent_flag("_stealth_stay_still")) {
    return;
  }
  maps\_utility::ent_flag_set("_stealth_stay_still");
  badplace_cylinder("_stealth_" + self.ai_number + "_prone", 0, self.origin, 30, 90, "axis");

  if(self.a.movement != "stop") {
    self notify("move_interrupt");
    animscripts\setposemovement::pronecrawltoprone();

    if(!maps\_utility::ent_flag("_stealth_stay_still"))
      maps\_utility::ent_flag_set("_stealth_stay_still");

    self orientmode("face current");
  }

  self notify("stop_loop");
  thread maps\_anim::anim_generic_loop(self, "_stealth_prone_idle", undefined, "stop_loop");
}

friendly_stance_handler_resume_path() {
  maps\_utility::ent_flag_clear("_stealth_stay_still");
  badplace_delete("_stealth_" + self.ai_number + "_prone");
  self notify("stop_loop");
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
      self allowedstances("prone");
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
  maps\_utility::ent_flag_set("_stealth_stance_change");
  wait 1.5;
  maps\_utility::ent_flag_clear("_stealth_stance_change");
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

friendly_stance_handler_check_mightbeseen(var_0) {
  var_1 = getaispeciesarray("axis", "all");
  var_0[self._stealth.logic.stance] = 0;
  var_0[self._stealth.behavior.stance_up] = 0;

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = friendly_stance_handler_return_ai_sight(var_1[var_2], self._stealth.logic.stance);
    var_4 = friendly_stance_handler_return_ai_sight(var_1[var_2], self._stealth.behavior.stance_up);
    var_5 = maps\_stealth_logic::friendly_compute_score() + var_3;
    var_6 = maps\_stealth_logic::friendly_compute_score(self._stealth.behavior.stance_up) + var_4;

    if(distance(var_1[var_2].origin, self.origin) < var_5) {
      var_0[self._stealth.logic.stance] = var_5;
      break;
    }

    if(distance(var_1[var_2].origin, self.origin) < var_6)
      var_0[self._stealth.behavior.stance_up] = var_6;
  }

  return var_0;
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

friendly_stance_handler_return_ai_sight(var_0, var_1) {
  var_2 = anglestoforward(var_0.angles);
  var_3 = vectornormalize(self.origin - var_0.origin);
  var_4 = vectordot(var_2, var_3);
  var_5 = level._stealth.logic.detection_level;

  if(var_4 > 0.3)
    return self._stealth.behavior.stance_handler[var_5]["looking_towards"][var_1];
  else if(var_4 < -0.7)
    return self._stealth.behavior.stance_handler[var_5]["looking_away"][var_1];
  else
    return self._stealth.behavior.stance_handler[var_5]["neutral"][var_1];
}

#using_animtree("generic_human");

friendly_stance_handler_init() {
  maps\_utility::ent_flag_init("_stealth_stance_handler");
  maps\_utility::ent_flag_init("_stealth_stay_still");
  maps\_utility::ent_flag_init("_stealth_stance_change");
  level.scr_anim["generic"]["_stealth_prone_idle"][0] = % prone_aim_5_legsstraight;
  self._stealth.behavior.stance_up = undefined;
  self._stealth.behavior.stance_handler = [];
  friendly_default_stance_handler_distances();
}

default_event_awareness(var_0, var_1, var_2, var_3) {
  level notify("event_awareness_handler");
  level endon("event_awareness_handler");
  level endon("default_event_awareness_enders");
  thread default_event_awareness_enders(var_1, var_2, var_3);
  common_scripts\utility::array_thread(getaiarray("allies"), ::default_event_awareness_ended_cleanup);
  thread default_event_awareness_killed_cleanup();

  for (;;) {
    var_4 = default_event_awareness_wait();
    common_scripts\utility::array_thread(getaiarray("allies"), ::default_event_awareness_setup);
    waittillframeend;
    common_scripts\utility::array_thread(getaiarray("allies"), ::default_event_awareness_handle_changes);
    common_scripts\utility::flag_set("_stealth_event");
    wait 2;
    [
      [var_0]
    ]();
    default_event_awareness_waitclear(var_4);
    common_scripts\utility::array_thread(getaiarray("allies"), ::default_event_awareness_cleanup);
    common_scripts\utility::flag_clear("_stealth_event");
  }
}

default_event_awareness_enders(var_0, var_1, var_2) {
  level endon("default_event_awareness_enders");
  level endon("event_awareness_handler");

  if(isdefined(var_0) && isdefined(level.flag[var_0]) && common_scripts\utility::flag(var_0))
    level notify("default_event_awareness_enders");

  if(isdefined(var_1) && isdefined(level.flag[var_1]) && common_scripts\utility::flag(var_1))
    level notify("default_event_awareness_enders");

  if(isdefined(var_2) && isdefined(level.flag[var_2]) && common_scripts\utility::flag(var_2))
    level notify("default_event_awareness_enders");

  if(common_scripts\utility::flag("_stealth_spotted"))
    level notify("default_event_awareness_enders");

  level common_scripts\utility::waittill_any("end_event_awareness_handler", "_stealth_spotted", var_0, var_1, var_2);
  level notify("default_event_awareness_enders");
}

default_event_awareness_killed_cleanup() {
  level common_scripts\utility::waittill_either("event_awareness_handler", "default_event_awareness_enders");
  common_scripts\utility::flag_clear("_stealth_event");
}

default_event_awareness_ended_cleanup() {
  level endon("event_awareness_handler");
  level waittill("default_event_awareness_enders");
  maps\_utility::ent_flag_clear("_stealth_stance_handler");

  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  if(isdefined(self._stealth.behavior.alreadyignoreme) && self._stealth.behavior.alreadyignoreme)
    self.ignoreme = 1;
}

default_event_awareness_setup() {
  self._stealth.behavior.alreadysmartstance = maps\_utility::ent_flag("_stealth_stance_handler");
  self._stealth.behavior.alreadyignoreme = self.ignoreme;
  maps\_utility::ent_flag_set("_stealth_stance_handler");
  self.ignoreme = 0;
}

default_event_awareness_handle_changes() {
  self endon("default_event_awareness_cleanup");
  level endon("default_event_awareness_enders");

  for (;;) {
    self waittill("_stealth_stance_handler");
    self._stealth.behavior.alreadysmartstance = maps\_utility::ent_flag("_stealth_stance_handler");

    if(!maps\_utility::ent_flag("_stealth_stance_handler")) {
      maps\_utility::ent_flag_set("_stealth_stance_handler");
      wait 0.05;
    }
  }
}

default_event_awareness_cleanup() {
  self notify("default_event_awareness_cleanup");

  if(!self._stealth.behavior.alreadysmartstance)
    maps\_utility::ent_flag_clear("_stealth_stance_handler");

  if(isdefined(self._stealth.behavior.alreadyignoreme) && self._stealth.behavior.alreadyignoreme)
    self.ignoreme = 1;
}

default_event_awareness_wait() {
  level endon("_stealth_found_corpse");

  for (;;) {
    level waittill("event_awareness", var_0);

    switch (var_0) {
      case "found_corpse":
        return var_0;
      case "heard_corpse":
        return var_0;
      case "heard_scream":
        return var_0;
      case "explode":
        return var_0;
      default:
        break;
    }
  }
}

default_event_awareness_waitclear(var_0) {
  if(isdefined(var_0)) {
    var_1 = getaispeciesarray("axis", "all");
    var_2 = level._stealth.logic.detect_range["alert"]["crouch"];
    common_scripts\utility::array_thread(var_1, ::default_event_awareness_waitclear_ai, var_2);
    maps\_utility::array_wait(var_1, "default_event_awareness_waitclear_ai");
  }

  if(common_scripts\utility::flag("_stealth_found_corpse")) {
    var_1 = getaispeciesarray("axis", "all");
    var_2 = level._stealth.logic.detect_range["alert"]["stand"];
    common_scripts\utility::array_thread(var_1, ::default_event_awareness_waitclear_ai, var_2);
    maps\_utility::array_wait(var_1, "default_event_awareness_waitclear_ai");
  }
}

default_event_awareness_waitclear_ai(var_0) {
  default_event_awareness_waitclear_ai_proc(var_0);
  self notify("default_event_awareness_waitclear_ai");
}

default_event_awareness_waitclear_ai_proc(var_0) {
  self endon("death");
  waittillframeend;
  var_1 = 0;

  if(isdefined(self.ent_flag["_stealth_behavior_first_reaction"]))
    var_1 = maps\_utility::ent_flag("_stealth_behavior_first_reaction");

  var_2 = 0;

  if(isdefined(self.ent_flag["_stealth_behavior_reaction_anim"]))
    var_1 = maps\_utility::ent_flag("_stealth_behavior_reaction_anim");

  if(!var_1 && !var_2) {
    return;
  }
  maps\_utility::add_wait(maps\_utility::waittill_msg, "death");
  maps\_utility::add_wait(maps\_utility::waittill_msg, "going_back");
  level maps\_utility::add_wait(common_scripts\utility::flag_wait, "_stealth_found_corpse");
  maps\_utility::do_wait_any();
  self endon("goal");
  var_3 = var_0 * var_0;

  while (distancesquared(self.origin, level.price.origin) < var_3)
    wait 1;
}