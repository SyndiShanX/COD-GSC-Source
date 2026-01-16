/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_behavior.gsc
**************************************/

#include common_scripts\utility;
#include animscripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_patrol;
#include maps\_stealth_anims;
#include maps\_stealth_logic;

main(state_functions) {
  system_init(state_functions);
  thread system_message_loop();
}

friendly_default_stance_handler_distances() {
  hidden = [];
  hidden["looking_away"]["stand"] = 500;
  hidden["looking_away"]["crouch"] = -400;
  hidden["looking_away"]["prone"] = 0;
  hidden["neutral"]["stand"] = 500;
  hidden["neutral"]["crouch"] = 200;
  hidden["neutral"]["prone"] = 50;
  hidden["looking_towards"]["stand"] = 800;
  hidden["looking_towards"]["crouch"] = 400;
  hidden["looking_towards"]["prone"] = 100;
  alert = [];
  alert["looking_away"]["stand"] = 800;
  alert["looking_away"]["crouch"] = 300;
  alert["looking_away"]["prone"] = 100;
  alert["neutral"]["stand"] = 900;
  alert["neutral"]["crouch"] = 700;
  alert["neutral"]["prone"] = 500;
  alert["looking_towards"]["stand"] = 1100;
  alert["looking_towards"]["crouch"] = 900;
  alert["looking_towards"]["prone"] = 700;
  friendly_set_stance_handler_distances(hidden, alert);
}

friendly_set_stance_handler_distances(hidden, alert) {
  if(isDefined(hidden)) {
    self._stealth.behavior.stance_handler["hidden"]["looking_away"]["stand"] = hidden["looking_away"]["stand"];
    self._stealth.behavior.stance_handler["hidden"]["looking_away"]["crouch"] = hidden["looking_away"]["crouch"];
    self._stealth.behavior.stance_handler["hidden"]["looking_away"]["prone"] = hidden["looking_away"]["prone"];
    self._stealth.behavior.stance_handler["hidden"]["neutral"]["stand"] = hidden["neutral"]["stand"];
    self._stealth.behavior.stance_handler["hidden"]["neutral"]["crouch"] = hidden["neutral"]["crouch"];
    self._stealth.behavior.stance_handler["hidden"]["neutral"]["prone"] = hidden["neutral"]["prone"];
    self._stealth.behavior.stance_handler["hidden"]["looking_towards"]["stand"] = hidden["looking_towards"]["stand"];
    self._stealth.behavior.stance_handler["hidden"]["looking_towards"]["crouch"] = hidden["looking_towards"]["crouch"];
    self._stealth.behavior.stance_handler["hidden"]["looking_towards"]["prone"] = hidden["looking_towards"]["prone"];
  }

  if(isDefined(alert)) {
    self._stealth.behavior.stance_handler["alert"]["looking_away"]["stand"] = alert["looking_away"]["stand"];
    self._stealth.behavior.stance_handler["alert"]["looking_away"]["crouch"] = alert["looking_away"]["crouch"];
    self._stealth.behavior.stance_handler["alert"]["looking_away"]["prone"] = alert["looking_away"]["prone"];
    self._stealth.behavior.stance_handler["alert"]["neutral"]["stand"] = alert["neutral"]["stand"];
    self._stealth.behavior.stance_handler["alert"]["neutral"]["crouch"] = alert["neutral"]["crouch"];
    self._stealth.behavior.stance_handler["alert"]["neutral"]["prone"] = alert["neutral"]["prone"];
    self._stealth.behavior.stance_handler["alert"]["looking_towards"]["stand"] = alert["looking_towards"]["stand"];
    self._stealth.behavior.stance_handler["alert"]["looking_towards"]["crouch"] = alert["looking_towards"]["crouch"];
    self._stealth.behavior.stance_handler["alert"]["looking_towards"]["prone"] = alert["looking_towards"]["prone"];
  }
}

enemy_try_180_turn(pos) {
  if(self._stealth.logic.dog) {
    return;
  }
  vec1 = anglestoforward(self.angles);
  vec2 = vectornormalize(pos - self.origin);

  if(vectordot(vec1, vec2) < -0.8) {
    start = self.origin + vectorscale((0, 0, 1), 16.0);
    end = pos + vectorscale((0, 0, 1), 16.0);
    spot = physicstrace(start, end);

    if(spot == end)
      self anim_generic(self, "patrol_turn180");
  }
}

enemy_go_back(spot) {
  self notify("going_back");
  self endon("death");
  self notify("stop_loop");
  self enemy_try_180_turn(spot);

  if(isDefined(self.script_patroller)) {
    if(isDefined(self.last_patrol_goal))
      self.target = self.last_patrol_goal.targetname;

    self thread maps\_patrol::patrol();
  } else {
    if(!self._stealth.logic.dog) {
      self set_generic_run_anim("patrol_walk", 1);
      self.disablearrivals = 1;
      self.disableexits = 1;
    }

    if(!self maymovetopoint(spot)) {
      nodes = enemy_get_closest_pathnodes(128, spot);

      if(!nodes.size) {
        return;
      }
      nodes = get_array_of_closest(spot, nodes);
      spot = nodes[0].origin;
    }

    self setgoalpos(spot);
    self.goalradius = 40;
  }
}

ai_create_behavior_function(name, key, function, array) {
  self._stealth.behavior.ai_functions[name][key] = function;
}

ai_change_ai_functions(name, functions) {
  if(!isDefined(functions)) {
    return;
  }
  keys = getarraykeys(functions);

  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    self ai_change_behavior_function(name, key, functions[key]);
  }
}

ai_change_behavior_function(name, key, function, array) {
  if(!isDefined(self._stealth.behavior.ai_functions[name][key])) {
    msg = "";

    if(isDefined(array)) {
      keys = getarraykeys(array);

      for(i = 0; i < keys.sise; i++) {
        msg = msg + keys[i];
        msg = msg + ", ";
      }

      assertmsg("array index with key: " + key + " is not valid. valid array keys are: " + msg);

    } else {
      assertmsg("Failed to add stealth function " + key);

    }

    return;
  }

  self ai_create_behavior_function(name, key, function, array);
}

ai_clear_custom_animation_reaction() {
  self._stealth.behavior.event.custom_animation = undefined;
}

ai_clear_custom_animation_reaction_and_idle() {
  if(!isDefined(self._stealth.behavior.event.custom_animation)) {
    return;
  }
  self._stealth.behavior.event.custom_animation.node notify("stop_loop");
  self maps\_utility::anim_stopanimscripted();
  self ai_clear_custom_animation_reaction();
}

ai_set_custom_animation_reaction(node, anime, tag, ender) {
  self._stealth.behavior.event.custom_animation = spawnstruct();
  self._stealth.behavior.event.custom_animation.node = node;
  self._stealth.behavior.event.custom_animation.anime = anime;
  self._stealth.behavior.event.custom_animation.tag = tag;
  self._stealth.behavior.event.custom_animation.ender = ender;
  self thread ai_animate_props_on_death(node, anime, tag, ender);
}

ai_animate_props_on_death(node, anime, tag, ender) {
  wait 0.1;

  if(!isDefined(self.anim_props)) {
    return;
  }
  prop = self.anim_props;
  self waittill("death");

  if(isDefined(self.anim_props_animated)) {
    return;
  }
  node thread anim_single(prop, anime);
}

system_init(state_functions) {
  assert(isDefined(level._stealth), "There is no level._stealth struct.You ran stealth behavior before running the detection logic.Run _stealth_logic::main() in your level load first");
  level._stealth.behavior = spawnstruct();
  level._stealth.behavior.sound = [];
  level._stealth.behavior.sound["huh"] = 0;
  level._stealth.behavior.sound["hmph"] = 0;
  level._stealth.behavior.sound["wtf"] = 0;
  level._stealth.behavior.sound["spotted"] = 0;
  level._stealth.behavior.sound["corpse"] = 0;
  level._stealth.behavior.sound["alert"] = 0;
  level._stealth.behavior.corpse = spawnstruct();
  level._stealth.behavior.corpse.last_pos = vectorscale((0, 0, -1), 100000.0);
  level._stealth.behavior.corpse.search_radius = 512;
  level._stealth.behavior.corpse.node_array = undefined;
  level._stealth.behavior.event_explosion_index = 5;
  level._stealth.behavior.system_state_functions = [];
  system_init_state_functions(state_functions);
  maps\_stealth_anims::main();
  flag_init("_stealth_searching_for_nodes");
  flag_init("_stealth_getallnodes");
  flag_init("_stealth_event");
}

system_init_state_functions(state_functions) {
  custom_state_functions = 0;

  if(isDefined(state_functions)) {
    if(isDefined(state_functions["hidden"]) && isDefined(state_functions["alert"]) && isDefined(state_functions["spotted"]))
      custom_state_functions = 1;
    else {
      assertmsg("you sent _stealth_behavior::main( <option_state_function_array> ) a variable but it was invalid.The variable needs to be an array of 3 indicies with values 'hidden', 'alert' and 'spotted'.These indicies must be function pointers to the system functions you wish to handle those 3 states.");

    }
  }

  if(!custom_state_functions) {
    system_set_state_function("hidden", ::system_state_hidden);
    system_set_state_function("alert", ::system_state_alert);
    system_set_state_function("spotted", ::system_state_spotted);
  } else {
    system_set_state_function("hidden", state_functions["hidden"]);
    system_set_state_function("alert", state_functions["alert"]);
    system_set_state_function("spotted", state_functions["spotted"]);
  }
}

system_message_loop() {
  funcs = level._stealth.behavior.system_state_functions;
  thread system_message_handler("_stealth_hidden", funcs["hidden"]);
  thread system_message_handler("_stealth_alert", funcs["alert"]);
  thread system_message_handler("_stealth_spotted", funcs["spotted"]);
}

system_message_handler(_flag, function) {
  while(true) {
    flag_wait(_flag);
    thread[[function]]();
    flag_waitopen(_flag);
  }
}

system_state_spotted() {
  battlechatter_on("axis");
}

system_state_alert() {
  level._stealth.behavior.sound["spotted"] = 0;
  battlechatter_off("axis");
  setdvar("bcs_stealth", "");
}

system_state_hidden() {
  level._stealth.behavior.sound["spotted"] = 0;
  battlechatter_off("axis");
  setdvar("bcs_stealth", "1");
}

system_set_state_function(detection_state, function) {
  if(!(detection_state == "hidden" || detection_state == "alert" || detection_state == "spotted")) {
    assertmsg("you sent _stealth_behavior::system_set_state_function( <detection_state> , <function> ) a bad detection state. Only valid states are 'hidden', 'alert', and 'spotted'");

  }

  level._stealth.behavior.system_state_functions[detection_state] = function;
}

enemy_logic(state_functions, alert_functions, corpse_functions, awareness_functions) {
  self enemy_init(state_functions, alert_functions, corpse_functions, awareness_functions);
  self thread enemy_message_loop();
  self thread enemy_threat_loop();
  self thread enemy_awareness_loop();
  self thread enemy_animation_loop();
  self thread enemy_corpse_loop();
}

enemy_init(state_functions, alert_functions, corpse_functions, awareness_functions) {
  assert(isDefined(self._stealth), "There is no self._stealth struct.You ran stealth behavior before running the detection logic.Run _stealth_logic::enemy_init() on this AI first");
  self._stealth.behavior = spawnstruct();
  self._stealth.behavior.sndnum = randomintrange(1, 4);
  self._stealth.behavior.ai_functions = [];
  self._stealth.behavior.ai_functions["state"] = [];
  self._stealth.behavior.ai_functions["alert"] = [];
  self._stealth.behavior.ai_functions["corpse"] = [];
  self._stealth.behavior.ai_functions["awareness"] = [];
  self enemy_default_ai_functions("state");
  self enemy_default_ai_functions("alert");
  self enemy_default_ai_functions("corpse");
  self enemy_default_ai_functions("awareness");
  self enemy_default_ai_functions("animation");
  self ai_change_ai_functions("state", state_functions);
  self ai_change_ai_functions("alert", alert_functions);
  self ai_change_ai_functions("corpse", corpse_functions);
  self ai_change_ai_functions("awareness", awareness_functions);
  self ent_flag_init("_stealth_enemy_alert_level_action");
  self ent_flag_init("_stealth_running_to_corpse");
  self ent_flag_init("_stealth_behavior_reaction_anim");
  self ent_flag_init("_stealth_behavior_first_reaction");
  self ent_flag_init("_stealth_behavior_reaction_anim_in_progress");
  self._stealth.behavior.event = spawnstruct();

  if(self._stealth.logic.dog)
    self enemy_dog_init();
}

enemy_default_ai_functions(name) {
  switch (name) {
    case "state":
      self ai_create_behavior_function("state", "hidden", ::enemy_state_hidden);
      self ai_create_behavior_function("state", "alert", ::enemy_state_alert);
      self ai_create_behavior_function("state", "spotted", ::enemy_state_spotted);
      break;
    case "alert":
      self ai_create_behavior_function("alert", "reset", ::enemy_alert_level_lostem);
      self ai_create_behavior_function("alert", "alerted_once", ::enemy_alert_level_alerted_once);
      self ai_create_behavior_function("alert", "alerted_again", ::enemy_alert_level_alerted_again);
      self ai_create_behavior_function("alert", "attack", ::enemy_alert_level_attack);
      break;
    case "corpse":
      self ai_create_behavior_function("corpse", "saw", ::enemy_corpse_saw_behavior);
      self ai_create_behavior_function("corpse", "found", ::enemy_corpse_found_behavior);
      break;
    case "awareness":
      self ai_create_behavior_function("awareness", "heard_scream", ::enemy_awareness_reaction_heard_scream);
      self ai_create_behavior_function("awareness", "doFlashBanged", ::enemy_awareness_reaction_flashbang);
      self ai_create_behavior_function("awareness", "explode", ::enemy_awareness_reaction_explosion);
      break;
    case "animation":
      self ai_create_behavior_function("animation", "wrapper", ::enemy_animation_wrapper);

      if(self._stealth.logic.dog) {
        self ai_create_behavior_function("animation", "reset", ::enemy_animation_nothing);
        self ai_create_behavior_function("animation", "attack", ::dog_animation_generic);
        self ai_create_behavior_function("animation", "heard_scream", ::dog_animation_generic);
        self ai_create_behavior_function("animation", "bulletwhizby", ::dog_animation_wakeup_fast);
        self ai_create_behavior_function("animation", "projectile_impact", ::dog_animation_wakeup_slow);
        self ai_create_behavior_function("animation", "explode", ::dog_animation_wakeup_fast);
      } else {
        self ai_create_behavior_function("animation", "reset", ::enemy_animation_nothing);
        self ai_create_behavior_function("animation", "alerted_once", ::enemy_animation_nothing);
        self ai_create_behavior_function("animation", "alerted_again", ::enemy_animation_nothing);
        self ai_create_behavior_function("animation", "attack", ::enemy_animation_attack);
        self ai_create_behavior_function("animation", "heard_scream", ::enemy_animation_generic);
        self ai_create_behavior_function("animation", "heard_corpse", ::enemy_animation_generic);
        self ai_create_behavior_function("animation", "saw_corpse", ::enemy_animation_sawcorpse);
        self ai_create_behavior_function("animation", "found_corpse", ::enemy_animation_foundcorpse);
        self ai_create_behavior_function("animation", "bulletwhizby", ::enemy_animation_whizby);
        self ai_create_behavior_function("animation", "projectile_impact", ::enemy_animation_whizby);
        self ai_create_behavior_function("animation", "explode", ::enemy_animation_generic);
      }

      self ai_create_behavior_function("animation", "doFlashBanged", ::enemy_animation_nothing);
      break;
  }
}

enemy_dog_init() {
  if(threatbiasgroupexists("dog"))
    self setthreatbiasgroup("dog");

  if(isDefined(self.enemy) || isDefined(self.favoriteenemy)) {
    return;
  }
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.allowdeath = 1;
  self thread anim_generic_loop(self, "_stealth_dog_sleeping", "stop_loop");
}

enemy_message_loop() {
  self thread ai_message_handler("_stealth_hidden", "hidden");
  self thread ai_message_handler("_stealth_alert", "alert");
  self thread ai_message_handler("_stealth_spotted", "spotted");
}

ai_message_handler(_flag, name) {
  self endon("death");
  self endon("pain_death");

  while(true) {
    flag_wait(_flag);

    function = self._stealth.behavior.ai_functions["state"][name];
    self thread[[function]]();
    flag_waitopen(_flag);
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

  if(!isDefined(self.old_baseaccuracy))
    self.old_baseaccuracy = self.baseaccuracy;

  if(!isDefined(self.old_accuracy))
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
  self clear_run_anim();
  self.fixednode = 0;
}

enemy_state_spotted() {
  _flag = "_stealth_spotted";
  ender = "_stealth_detection_level_change" + _flag;
  thread state_change_ender(_flag, ender);
  level endon(ender);
  self endon("death");
  self.fovcosine = 0.01;
  self.ignoreall = 0;

  if(!self._stealth.logic.dog) {
    self.diequietly = 0;
    self clear_run_anim();
    self.baseaccuracy = self.baseaccuracy * 3;
    self.accuracy = self.accuracy * 3;
    self.fixednode = 0;
    self enemy_stop_current_behavior();
  }

  if(!isalive(self.enemy))
    self waittill_notify_or_timeout("enemy", randomfloatrange(1, 3));

  if(self._stealth.logic.dog)
    self.favoriteenemy = get_closest_player(self.origin);
  else if(randomint(100) > 25)
    self.favoriteenemy = get_closest_player(self.origin);

  self thread enemy_spotted_clear_favorite();
}

enemy_spotted_clear_favorite() {
  self endon("death");
  wait 1.5;
  self.favoriteenemy = undefined;
}

state_change_ender(_flag, ender) {
  flag_waitopen(_flag);
  level notify(ender);
}

enemy_animation_loop() {
  self endon("death");
  self endon("pain_death");

  while(true) {
    self waittill("event_awareness", type);
    wrapper_func = self._stealth.behavior.ai_functions["animation"]["wrapper"];
    self thread[[wrapper_func]](type);
  }
}

enemy_animation_wrapper(type) {
  self endon("death");
  self endon("pain_death");

  if(self enemy_animation_pre_anim(type)) {
    return;
  }
  self enemy_animation_do_anim(type);
  self enemy_animation_post_anim(type);
}

enemy_animation_do_anim(type) {
  if(isDefined(self._stealth.behavior.event.custom_animation)) {
    self enemy_animation_custom(type);
    return;
  }

  function = self._stealth.behavior.ai_functions["animation"][type];
  self[[function]](type);
}

enemy_animation_custom(type) {
  self endon("death");
  self endon("pain_death");
  node = self._stealth.behavior.event.custom_animation.node;
  anime = self._stealth.behavior.event.custom_animation.anime;
  tag = self._stealth.behavior.event.custom_animation.tag;
  ender = self._stealth.behavior.event.custom_animation.ender;
  self ent_flag_set("_stealth_behavior_reaction_anim");
  self.allowdeath = 1;
  node notify(ender);

  if(isDefined(self.anim_props)) {
    self.anim_props_animated = 1;
    node thread anim_single(self.anim_props, anime);
  }

  if(type != "doFlashBanged") {
    if(isDefined(tag) || isDefined(self.has_delta))
      node anim_generic_aligned(self, anime, tag);
    else
      node anim_generic_custom_animmode(self, "gravity", anime);
  }

  self ai_clear_custom_animation_reaction();
}

enemy_animation_pre_anim(type) {
  self notify("enemy_awareness_reaction", type);

  if(self ent_flag("_stealth_behavior_first_reaction") || self ent_flag("_stealth_behavior_reaction_anim_in_progress"))
    return true;

  self enemy_stop_current_behavior();

  switch (type) {
    case "explode":
    case "found_corpse":
    case "heard_corpse":
    case "saw_corpse":
      self ent_flag_set("_stealth_behavior_reaction_anim");
      break;
    case "alerted_again":
    case "alerted_once":
    case "reset":
      break;
    default:
      self ent_flag_set("_stealth_behavior_first_reaction");
      self ent_flag_set("_stealth_behavior_reaction_anim");
      break;
  }

  self ent_flag_set("_stealth_behavior_reaction_anim_in_progress");
  return false;
}

enemy_animation_post_anim(type) {
  switch (type) {
    default:
      self ent_flag_clear("_stealth_behavior_reaction_anim");
      break;
  }

  self ent_flag_clear("_stealth_behavior_reaction_anim_in_progress");
}

enemy_animation_whizby(type) {
  self.allowdeath = 1;
  anime = undefined;
  anime = "_stealth_behavior_whizby_" + randomint(5);
  self thread anim_generic_custom_animmode(self, "gravity", anime);
  wait 1.5;
  self notify("stop_animmode");
}

enemy_animation_attack(type) {
  enemy = self._stealth.logic.event.awareness[type];
  anime = undefined;

  if(distancesquared(enemy.origin, self.origin) < 65536)
    anime = "_stealth_behavior_spotted_short";
  else
    anime = "_stealth_behavior_spotted_long";

  self.allowdeath = 1;
  self thread anim_generic_custom_animmode(self, "gravity", anime);
  self waittill_notify_or_timeout(anime, randomfloatrange(1.5, 3));
  self notify("stop_animmode");
}

enemy_animation_nothing(type) {
}

enemy_animation_generic(type) {
  self.allowdeath = 1;
  target = get_closest_player(self.origin);

  if(isDefined(self.enemy))
    target = self.enemy;
  else if(isDefined(self.favoriteenemy))
    target = self.favoriteenemy;

  dist = distance(self.origin, target.origin);

  for(i = 1; i < 4; i++) {
    test = 1024 * (i / 4);

    if(dist < test) {
      break;
    }
  }

  anime = "_stealth_behavior_generic" + i;
  self anim_generic_custom_animmode(self, "gravity", anime);
}

enemy_animation_sawcorpse(type) {
  self.allowdeath = 1;
  anime = undefined;
  anime = "_stealth_behavior_saw_corpse";
  self anim_generic_custom_animmode(self, "gravity", anime);
}

enemy_animation_foundcorpse(type) {
  self.allowdeath = 1;
  anime = "_stealth_find_jog";
  self anim_generic_custom_animmode(self, "gravity", anime);
}

dog_animation_generic(type) {
  self.allowdeath = 1;
  anime = undefined;

  if(randomint(100) < 50)
    anime = "_stealth_dog_wakeup_fast";
  else
    anime = "_stealth_dog_wakeup_slow";

  self anim_generic_custom_animmode(self, "gravity", anime);
}

dog_animation_wakeup_fast(type) {
  self.allowdeath = 1;
  anime = "_stealth_dog_wakeup_fast";
  self anim_generic_custom_animmode(self, "gravity", anime);
}

dog_animation_wakeup_slow(type) {
  self.allowdeath = 1;
  anime = "_stealth_dog_wakeup_slow";
  self anim_generic_custom_animmode(self, "gravity", anime);
}

enemy_awareness_loop() {
  self endon("death");
  self endon("pain_death");

  while(true) {
    self waittill("event_awareness", type);

    if(flag("_stealth_spotted")) {
      continue;
    }
    func = self._stealth.behavior.ai_functions["awareness"];

    if(isDefined(func[type]))
      self thread[[func[type]]](type);
  }
}

enemy_awareness_reaction_heard_scream(type) {
  if(self._stealth.logic.dog) {
    return;
  }
  self endon("_stealth_enemy_alert_level_change");
  level endon("_stealth_spotted");
  self endon("another_enemy_awareness_reaction");
  msg = "scream_kill_safety_check";
  self thread enemy_awareness_reaction_safety(type, msg);
  enemy_reaction_state_alert();
  spot = self enemy_find_original_goal();
  self enemy_stop_current_behavior();
  self endon("death");
  origin = self._stealth.logic.event.awareness[type];
  origin = self enemy_find_nodes_at_origin(origin);
  self enemy_investigate_explosion(origin);
  self thread enemy_announce_hmph();
  self notify(msg);
  self enemy_go_back(spot);
}

enemy_awareness_reaction_flashbang(type) {
  if(self._stealth.logic.dog) {
    return;
  }
  self endon("_stealth_enemy_alert_level_change");
  level endon("_stealth_spotted");
  self endon("another_enemy_awareness_reaction");
  msg = "flashbang_kill_safety_check";
  self thread enemy_awareness_reaction_safety(type, msg);
  enemy_reaction_state_alert();
  spot = self enemy_find_original_goal();
  self enemy_stop_current_behavior();
  self endon("death");
  enemy = self._stealth.logic.event.awareness[type];
  origin = enemy.origin;
  self waittill("stop_flashbang_effect");
  origin = self enemy_find_nodes_at_origin(origin);
  self thread enemy_investigate_explosion(origin);

  if(origin != (0, 0, 0)) {
    wait 1.05;
    self waittill("goal");
    self thread enemy_announce_wtf();
    self thread enemy_announce_spotted_bring_team(origin);
  }

  self thread enemy_announce_hmph();
  self notify(msg);
  self enemy_go_back(spot);
}

enemy_awareness_reaction_explosion(type) {
  self endon("_stealth_enemy_alert_level_change");

  if(!self._stealth.logic.dog) {
    self endon("_stealth_saw_corpse");
    level endon("_stealth_found_corpse");
  }

  level endon("_stealth_spotted");
  self endon("another_enemy_awareness_reaction");
  msg = "explostion_kill_safety_check";
  self thread enemy_awareness_reaction_safety(type, msg);
  enemy_reaction_state_alert();
  spot = self enemy_find_original_goal();
  self enemy_stop_current_behavior();
  self endon("death");
  origin = self._stealth.logic.event.awareness[type];
  origin = self enemy_find_nodes_at_origin(origin);
  self thread enemy_announce_wtf();
  self enemy_investigate_explosion(origin);
  self thread enemy_announce_hmph();
  self notify(msg);
  self enemy_go_back(spot);
}

enemy_awareness_reaction_safety(type, msg) {
  self endon("death");
  self endon(msg);

  while(true) {
    self waittill("enemy_awareness_reaction", _type);

    if(type == _type)
      continue;
    else
      break;
  }

  self notify("another_enemy_awareness_reaction");
}

enemy_find_nodes_at_origin(origin) {
  array = enemy_get_closest_pathnodes(512, origin);
  original = origin;

  if(isDefined(array) && array.size) {
    for(i = 0; i < array.size; i++) {
      if(isDefined(array[i]._stealth_corpse_behavior_taken)) {
        continue;
      }
      origin = array[i].origin;
      array[i] thread enemy_corpse_reaction_takenode();
      tooclose = get_array_of_closest(array[i].origin, array, undefined, undefined, 40);
      array_thread(tooclose, ::enemy_corpse_reaction_takenode);
      break;
    }
  } else
    origin = (0, 0, 0);

  if(original == origin)
    origin = (0, 0, 0);

  return origin;
}

enemy_investigate_explosion(origin) {
  if(origin != (0, 0, 0)) {
    wait(randomfloat(1));
    self thread enemy_runto_and_lookaround(origin);
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
    self thread enemy_threat_logic_dog();

  while(true) {
    self waittill("_stealth_enemy_alert_level_change");
    type = self._stealth.logic.alert_level.lvl;
    enemy = self._stealth.logic.alert_level.enemy;
    self thread enemy_alert_level_change(type, enemy);
  }
}

enemy_threat_logic_dog() {
  self endon("death");
  self endon("pain_death");
  self waittill("pain");
  self.ignoreall = 0;
}

enemy_alert_level_change(type, enemy) {
  self ent_flag_set("_stealth_enemy_alert_level_action");
  funcs = self._stealth.behavior.ai_functions["alert"];
  self thread[[funcs[type]]](enemy);
}

enemy_alert_level_normal() {
  self endon("_stealth_enemy_alert_level_change");
  self endon("death");
  self endon("pain_death");
  spot = self enemy_find_original_goal();
  self enemy_stop_current_behavior();
  self waittill("normal");
  self ent_flag_clear("_stealth_enemy_alert_level_action");
  self ent_flag_waitopen("_stealth_saw_corpse");
  wait 0.05;
  flag_waitopen("_stealth_found_corpse");
  self thread enemy_announce_hmph();
  self enemy_go_back(spot);
}

enemy_find_original_goal() {
  if(isDefined(self.last_set_goalnode))
    return self.last_set_goalnode.origin;

  if(isDefined(self.last_set_goalpos))
    return self.last_set_goalpos;

  return self.origin;
}

enemy_alert_level_lostem(enemy) {
  self notify("normal");
}

enemy_alert_level_alerted_once(enemy) {
  self endon("_stealth_enemy_alert_level_change");
  level endon("_stealth_spotted");
  self endon("death");
  self endon("pain_death");
  self thread enemy_announce_huh();
  self thread enemy_alert_level_normal();

  if(isDefined(self.script_patroller)) {
    self set_generic_run_anim("patrol_walk", 1);
    self.disablearrivals = 1;
    self.disableexits = 1;
  }

  vec = vectornormalize(enemy.origin - self.origin);
  dist = distance(enemy.origin, self.origin);
  dist = dist * 0.25;

  if(dist < 64)
    dist = 64;

  if(dist > 128)
    dist = 128;

  vec = vectorscale(vec, dist);
  spot = self.origin + vec + vectorscale((0, 0, 1), 16.0);
  end = spot + vectorscale((0, 0, -1), 96.0);
  spot = physicstrace(spot, end);

  if(spot == end) {
    return;
  }
  self setgoalpos(spot);
  self.goalradius = 4;
  self waittill_notify_or_timeout("goal", 2);
  wait 3;
  self notify("normal");
}

enemy_alert_level_alerted_again(enemy) {
  self endon("_stealth_enemy_alert_level_change");
  level endon("_stealth_spotted");
  self endon("death");
  self endon("pain_death");
  self thread enemy_announce_huh();
  self thread enemy_alert_level_normal();
  self set_generic_run_anim("_stealth_patrol_jog");
  self.disablearrivals = 0;
  self.disableexits = 0;
  lastknownspot = enemy.origin;
  distance = distance(lastknownspot, self.origin);
  self setgoalpos(lastknownspot);
  self.goalradius = distance * 0.5;
  self waittill("goal");
  self set_generic_run_anim("_stealth_patrol_walk", 1);
  self setgoalpos(lastknownspot);
  self.goalradius = 64;
  self.disablearrivals = 1;
  self.disableexits = 1;
  self waittill("goal");
  wait 12;
  self set_generic_run_anim("_stealth_patrol_walk", 1);
  self notify("normal");
}

enemy_alert_level_attack(enemy) {
  self endon("death");
  self endon("pain_death");
  self endon("_stealth_stop_stealth_behavior");
  self thread enemy_announce_spotted(self.origin);
  self thread enemy_close_in_on_target();
}

enemy_close_in_on_target() {
  radius = 2048;
  self.goalradius = radius;

  if(isDefined(self.script_stealth_dontseek)) {
    return;
  }
  self endon("death");
  self endon("_stealth_stop_stealth_behavior");

  while(isDefined(self.enemy)) {
    self setgoalpos(self.enemy.origin);
    self.goalradius = radius;

    if(radius > 600)
      radius = radius * 0.75;

    wait 15;
  }
}

enemy_announce_wtf() {
  if(!self enemy_announce_snd("wtf")) {
    return;
  }
  self playsound("RU_0_reaction_casualty_generic");
}

enemy_announce_huh() {
  if(!self enemy_announce_snd("huh")) {
    return;
  }
  alias = "scoutsniper_ru" + self._stealth.behavior.sndnum + "_huh";
  self playsound(alias);
}

enemy_announce_hmph() {
  if(!self enemy_announce_snd("hmph")) {
    return;
  }
  alias = "scoutsniper_ru" + self._stealth.behavior.sndnum + "_hmph";
  self playsound(alias);
}

enemy_announce_spotted(pos) {
  self endon("death");
  flag_wait("_stealth_spotted");

  if(!self enemy_announce_snd("spotted")) {
    return;
  }
  self thread enemy_announce_spotted_bring_team(pos);

  if(self._stealth.logic.dog) {
    return;
  }
  self playsound("RU_0_reaction_casualty_generic");
}

enemy_announce_spotted_bring_team(pos) {
  ai = getaispeciesarray("axis", "all");

  for(i = 0; i < ai.size; i++) {
    if(ai[i] == self) {
      continue;
    }
    if(isDefined(ai[i].enemy)) {
      continue;
    }
    if(isDefined(ai[i].favoriteenemy)) {
      continue;
    }
    ai[i] notify("heard_scream", pos);
  }
}

enemy_announce_corpse() {
  if(isDefined(self.found_corpse_wait)) {
    self endon("death");
    wait(self.found_corpse_wait);
  }

  if(!self enemy_announce_snd("corpse")) {
    return;
  }
  self playsound("RU_0_reaction_casualty_generic");
}

enemy_announce_snd(type) {
  if(level._stealth.behavior.sound[type])
    return false;

  level._stealth.behavior.sound[type] = 1;
  self thread enemy_announce_snd_reset(type);
  return true;
}

enemy_announce_snd_reset(type) {
  if(type == "spotted") {
    return;
  }
  wait 3;
  level._stealth.behavior.sound[type] = 0;
}

enemy_corpse_loop() {
  if(self._stealth.logic.dog) {
    return;
  }
  self endon("death");
  self endon("pain_death");
  self thread enemy_found_corpse_loop();

  while(true) {
    self waittill("_stealth_saw_corpse");
    self enemy_saw_corpse_logic();
  }
}

enemy_saw_corpse_logic() {
  if(flag("_stealth_spotted")) {
    return;
  }
  level endon("_stealth_spotted");
  level endon("_stealth_found_corpse");
  self thread enemy_announce_huh();

  while(true) {
    self ent_flag_waitopen("_stealth_enemy_alert_level_action");
    self enemy_corpse_saw_wrapper();
    self waittill("normal");
  }
}

enemy_stop_current_behavior() {
  if(!self ent_flag("_stealth_behavior_reaction_anim")) {
    self maps\_utility::anim_stopanimscripted();
    self notify("stop_animmode");
    self notify("stop_loop");
  }

  if(isDefined(self.script_patroller)) {
    if(isDefined(self.last_patrol_goal))
      self.last_patrol_goal.patrol_claimed = undefined;

    self notify("release_node");
    self notify("end_patrol");
    self notify("stop_contextual_melee");
  }

  self notify("stop_first_frame");
  self clear_run_anim();
}

enemy_corpse_saw_wrapper() {
  self endon("enemy_alert_level_change");
  funcs = self._stealth.behavior.ai_functions["corpse"];
  self[[funcs["saw"]]]();
}

enemy_corpse_saw_behavior() {
  self enemy_stop_current_behavior();
  ent_flag_set("_stealth_running_to_corpse");
  self.disablearrivals = 0;
  self.disableexits = 0;
  self set_generic_run_anim("_stealth_combat_jog");
  self.goalradius = 80;
  self setgoalpos(self._stealth.logic.corpse.corpse_entity.origin);
}

enemy_found_corpse_loop() {
  self endon("death");
  self endon("pain_death");

  if(isDefined(self.no_corpse_caring)) {
    return;
  }
  if(flag("_stealth_spotted")) {
    return;
  }
  level endon("_stealth_spotted");
  funcs = self._stealth.behavior.ai_functions["corpse"];

  while(true) {
    flag_wait("_stealth_found_corpse");

    while(flag("_stealth_found_corpse")) {
      if(self ent_flag("_stealth_found_corpse"))
        self thread enemy_announce_corpse();
      else
        self notify("heard_corpse", (0, 0, 0));

      self enemy_reaction_state_alert();
      self[[funcs["found"]]]();
      level waittill("_stealth_found_corpse");
    }
  }
}

enemy_corpse_found_behavior() {
  self enemy_stop_current_behavior();

  if(level._stealth.logic.corpse.last_pos != level._stealth.behavior.corpse.last_pos) {
    radius = level._stealth.behavior.corpse.search_radius;
    origin = level._stealth.logic.corpse.last_pos;
    level._stealth.behavior.corpse.node_array = enemy_get_closest_pathnodes(radius, origin);
    level._stealth.behavior.corpse.last_pos = level._stealth.logic.corpse.last_pos;
  }

  array = level._stealth.behavior.corpse.node_array;

  for(i = 0; i < array.size; i++) {
    if(isDefined(array[i]._stealth_corpse_behavior_taken)) {
      continue;
    }
    self thread enemy_runto_and_lookaround(array[i].origin);
    array[i] thread enemy_corpse_reaction_takenode();
    tooclose = get_array_of_closest(array[i].origin, array, undefined, undefined, 40);
    array_thread(tooclose, ::enemy_corpse_reaction_takenode);
    break;
  }
}

enemy_runto_and_lookaround(pos) {
  self notify("enemy_runto_and_lookaround");
  self endon("enemy_runto_and_lookaround");
  self endon("death");
  self endon("_stealth_enemy_alert_level_change");

  if(!self._stealth.logic.dog)
    self endon("_stealth_saw_corpse");

  level endon("_stealth_spotted");
  self setgoalpos(pos);
  self.goalradius = 4;
  self waittill("goal");
  wait 0.5;

  if(!self._stealth.logic.dog)
    self anim_generic_loop(self, "_stealth_look_around", "stop_loop");
}

enemy_corpse_reaction_takenode() {
  self._stealth_corpse_behavior_taken = 1;
  wait 0.25;
  self._stealth_corpse_behavior_taken = undefined;
}

enemy_get_closest_pathnodes(radius, origin) {
  if(!flag("_stealth_getallnodes")) {
    if(!flag("_stealth_searching_for_nodes")) {
      flag_set("_stealth_searching_for_nodes");
      waittillframeend;
      nodes = getallnodes();
      pathnodes = [];
      radus2rd = radius * radius;

      for(i = 0; i < nodes.size; i++) {
        if(nodes[i].type != "Path") {
          continue;
        }
        if(distancesquared(nodes[i].origin, origin) > radus2rd) {
          continue;
        }
        pathnodes[pathnodes.size] = nodes[i];
      }

      level._stealth.behavior.search_nodes_array = pathnodes;
      waittillframeend;
      flag_clear("_stealth_searching_for_nodes");
    } else
      flag_waitopen("_stealth_searching_for_nodes");

    level delay_thread(0.2, ::flag_clear, "_stealth_getallnodes");
    level flag_set("_stealth_getallnodes");
  }

  return level._stealth.behavior.search_nodes_array;
}

friendly_logic(state_functions) {
  self friendly_init(state_functions);
  self thread friendly_message_loop();
  self thread friendly_stance_handler();
}

friendly_init(state_functions) {
  assert(isDefined(self._stealth), "There is no self._stealth struct.You ran stealth behavior before running the detection logic.Run _stealth_logic::friendly_init() on this AI first");
  self._stealth.behavior = spawnstruct();
  self._stealth.behavior.accuracy = [];
  self._stealth.behavior.goodaccuracy = 50;
  self._stealth.behavior.badaccuracy = 0;
  self._stealth.behavior.old_baseaccuracy = self.baseaccuracy;
  self._stealth.behavior.old_accuracy = self.accuracy;
  self._stealth.behavior.ai_functions = [];
  self._stealth.behavior.ai_functions["state"] = [];
  self friendly_default_ai_functions("state");
  self ai_change_ai_functions("state", state_functions);
  self ent_flag_init("_stealth_custom_anim");
}

friendly_default_ai_functions(name) {
  switch (name) {
    case "state":
      self ai_create_behavior_function(name, "hidden", ::friendly_state_hidden);
      self ai_create_behavior_function(name, "alert", ::friendly_state_alert);
      self ai_create_behavior_function(name, "spotted", ::friendly_state_spotted);
      break;
  }
}

friendly_message_loop() {
  funcs = self._stealth.behavior.ai_functions["state"];
  self thread ai_message_handler("_stealth_hidden", "hidden");
  self thread ai_message_handler("_stealth_alert", "alert");
  self thread ai_message_handler("_stealth_spotted", "spotted");
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
  self disable_ai_color();
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
  self disable_ai_color();
  waittillframeend;
  self.fixednode = 0;
}

friendly_state_spotted() {
  level endon("_stealth_detection_level_change");
  self thread friendly_spotted_getup_from_prone();
  self.baseaccuracy = self._stealth.behavior.badaccuracy;
  self.accuracy = self._stealth.behavior.badaccuracy;
  self.grenadeammo = self._stealth.behavior.oldgrenadeammo;
  self allowedstances("prone", "crouch", "stand");
  self maps\_utility::anim_stopanimscripted();
  self.ignoreall = 0;
  self.ignoreme = 0;
  self reset_movemode();
  self enable_ai_color();
  self.disablearrivals = 1;
  self.disableexits = 1;
  self pushplayer(0);
}

friendly_spotted_getup_from_prone(angles) {
  self endon("death");

  if(self._stealth.logic.stance != "prone") {
    return;
  }
  self ent_flag_set("_stealth_custom_anim");
  anime = "prone_2_run_roll";

  if(isDefined(angles))
    self orientmode("face angle", angles[1] + 20);

  self thread anim_generic_custom_animmode(self, "gravity", anime);
  length = getanimlength(getanim_generic(anime));
  wait(length - 0.2);
  self notify("stop_animmode");
  self ent_flag_clear("_stealth_custom_anim");
}

friendly_stance_handler() {
  self endon("death");
  self endon("pain_death");
  self friendly_stance_handler_init();

  while(true) {
    while(self ent_flag("_stealth_stance_handler") && !flag("_stealth_spotted")) {
      self friendly_stance_handler_set_stance_up();
      stances = [];
      stances = friendly_stance_handler_check_mightbeseen(stances);

      if(stances[self._stealth.logic.stance])
        self thread friendly_stance_handler_change_stance_down();
      else if(self ent_flag("_stealth_stay_still"))
        self thread friendly_stance_handler_resume_path();
      else if(!stances[self._stealth.behavior.stance_up])
        self thread friendly_stance_handler_change_stance_up();
      else if(self ent_flag("_stealth_stance_change"))
        self notify("_stealth_stance_dont_change");

      wait 0.05;
    }

    self.moveplaybackrate = 1;
    self allowedstances("stand", "crouch", "prone");
    self thread friendly_stance_handler_resume_path();
    self ent_flag_wait("_stealth_stance_handler");
    flag_waitopen("_stealth_spotted");
  }
}

friendly_stance_handler_stay_still() {
  if(self ent_flag("_stealth_stay_still")) {
    return;
  }
  self ent_flag_set("_stealth_stay_still");
  badplace_cylinder("_stealth_" + self.ai_number + "_prone", 0, self.origin, 30, 90, "axis");
  self notify("stop_loop");
  self thread anim_generic_loop(self, "_stealth_prone_idle", "stop_loop");
}

friendly_stance_handler_resume_path() {
  self ent_flag_clear("_stealth_stay_still");
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

  if(self ent_flag("_stealth_stance_change")) {
    return;
  }
  self ent_flag_set("_stealth_stance_change");
  wait 1.5;
  self ent_flag_clear("_stealth_stance_change");
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

friendly_stance_handler_check_mightbeseen(stances) {
  ai = getaispeciesarray("axis", "all");
  stances[self._stealth.logic.stance] = 0;
  stances[self._stealth.behavior.stance_up] = 0;

  for(i = 0; i < ai.size; i++) {
    dist_add_curr = self friendly_stance_handler_return_ai_sight(ai[i], self._stealth.logic.stance);
    dist_add_up = self friendly_stance_handler_return_ai_sight(ai[i], self._stealth.behavior.stance_up);
    score_current = self maps\_stealth_logic::friendly_compute_score() + dist_add_curr;
    score_up = self maps\_stealth_logic::friendly_compute_score(self._stealth.behavior.stance_up) + dist_add_up;

    if(distancesquared(ai[i].origin, self.origin) < score_current * score_current) {
      stances[self._stealth.logic.stance] = score_current;
      break;
    }

    if(distancesquared(ai[i].origin, self.origin) < score_up * score_up)
      stances[self._stealth.behavior.stance_up] = score_up;
  }

  return stances;
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

friendly_stance_handler_return_ai_sight(ai, stance) {
  vec1 = anglestoforward(ai.angles);
  vec2 = vectornormalize(self.origin - ai.origin);
  vecdot = vectordot(vec1, vec2);
  state = level._stealth.logic.detection_level;

  if(vecdot > 0.3)
    return self._stealth.behavior.stance_handler[state]["looking_towards"][stance];
  else if(vecdot < -0.7)
    return self._stealth.behavior.stance_handler[state]["looking_away"][stance];
  else
    return self._stealth.behavior.stance_handler[state]["neutral"][stance];
}

#using_animtree("generic_human");

friendly_stance_handler_init() {
  self ent_flag_init("_stealth_stance_handler");
  self ent_flag_init("_stealth_stay_still");
  self ent_flag_init("_stealth_stance_change");
  level.scr_anim["generic"]["_stealth_prone_idle"][0] = % prone_aim_idle;
  self._stealth.behavior.stance_up = undefined;
  self._stealth.behavior.stance_handler = [];
  self friendly_default_stance_handler_distances();
}

default_event_awareness(dialogue_func, ender1, ender2, ender3) {
  level notify("event_awareness_handler");
  level endon("event_awareness_handler");
  level endon("default_event_awareness_enders");
  thread default_event_awareness_enders(ender1, ender2, ender3);
  array_thread(getaiarray("allies"), ::default_event_awareness_ended_cleanup);
  thread default_event_awareness_killed_cleanup();

  while(true) {
    type = default_event_awareness_wait();
    array_thread(getaiarray("allies"), ::default_event_awareness_setup);
    waittillframeend;
    array_thread(getaiarray("allies"), ::default_event_awareness_handle_changes);
    flag_set("_stealth_event");
    wait 2;
    [
      [dialogue_func]
    ]();
    default_event_awareness_waitclear(type);
    array_thread(getaiarray("allies"), ::default_event_awareness_cleanup);
    flag_clear("_stealth_event");
  }
}

default_event_awareness_enders(ender1, ender2, ender3) {
  level endon("default_event_awareness_enders");
  level endon("event_awareness_handler");

  if(isDefined(ender1) && isDefined(level.flag[ender1]) && flag(ender1))
    level notify("default_event_awareness_enders");

  if(isDefined(ender2) && isDefined(level.flag[ender2]) && flag(ender2))
    level notify("default_event_awareness_enders");

  if(isDefined(ender3) && isDefined(level.flag[ender3]) && flag(ender3))
    level notify("default_event_awareness_enders");

  if(flag("_stealth_spotted"))
    level notify("default_event_awareness_enders");

  level waittill_any("end_event_awareness_handler", "_stealth_spotted", ender1, ender2, ender3);
  level notify("default_event_awareness_enders");
}

default_event_awareness_killed_cleanup() {
  level waittill_either("event_awareness_handler", "default_event_awareness_enders");
  flag_clear("_stealth_event");
}

default_event_awareness_ended_cleanup() {
  level endon("event_awareness_handler");
  level waittill("default_event_awareness_enders");
  self ent_flag_clear("_stealth_stance_handler");

  if(flag("_stealth_spotted")) {
    return;
  }
  if(isDefined(self._stealth.behavior.alreadyignoreme) && self._stealth.behavior.alreadyignoreme)
    self.ignoreme = 1;
}

default_event_awareness_setup() {
  self._stealth.behavior.alreadysmartstance = self ent_flag("_stealth_stance_handler");
  self._stealth.behavior.alreadyignoreme = self.ignoreme;
  self ent_flag_set("_stealth_stance_handler");
  self.ignoreme = 0;
}

default_event_awareness_handle_changes() {
  self endon("default_event_awareness_cleanup");
  level endon("default_event_awareness_enders");

  while(true) {
    self waittill("_stealth_stance_handler");
    self._stealth.behavior.alreadysmartstance = self ent_flag("_stealth_stance_handler");

    if(!self ent_flag("_stealth_stance_handler")) {
      self ent_flag_set("_stealth_stance_handler");
      wait 0.05;
    }
  }
}

default_event_awareness_cleanup() {
  self notify("default_event_awareness_cleanup");

  if(!self._stealth.behavior.alreadysmartstance)
    self ent_flag_clear("_stealth_stance_handler");

  if(isDefined(self._stealth.behavior.alreadyignoreme) && self._stealth.behavior.alreadyignoreme)
    self.ignoreme = 1;
}

default_event_awareness_wait() {
  level endon("_stealth_found_corpse");

  while(true) {
    level waittill("event_awareness", type);

    switch (type) {
      case "found_corpse":
        return type;
      case "heard_corpse":
        return type;
      case "heard_scream":
        return type;
      case "explode":
        return type;
      default:
        continue;
    }
  }
}

default_event_awareness_waitclear(type) {
  if(isDefined(type)) {
    ai = getaispeciesarray("axis", "all");
    dist = level._stealth.logic.detect_range["alert"]["crouch"];
    array_thread(ai, ::default_event_awareness_waitclear_ai, dist);
    array_wait(ai, "default_event_awareness_waitclear_ai");
  }

  if(flag("_stealth_found_corpse")) {
    ai = getaispeciesarray("axis", "all");
    dist = level._stealth.logic.detect_range["alert"]["stand"];
    array_thread(ai, ::default_event_awareness_waitclear_ai, dist);
    array_wait(ai, "default_event_awareness_waitclear_ai");
  }
}

default_event_awareness_waitclear_ai(dist) {
  self default_event_awareness_waitclear_ai_proc(dist);
  self notify("default_event_awareness_waitclear_ai");
}

default_event_awareness_waitclear_ai_proc(dist) {
  self endon("death");
  waittillframeend;
  check1 = 0;

  if(isDefined(self.ent_flag["_stealth_behavior_first_reaction"]))
    check1 = self ent_flag("_stealth_behavior_first_reaction");

  check2 = 0;

  if(isDefined(self.ent_flag["_stealth_behavior_reaction_anim"]))
    check2 = self ent_flag("_stealth_behavior_reaction_anim");

  if(!check1 && !check2) {
    return;
  }
  self add_wait(::waittill_msg, "death");
  self add_wait(::waittill_msg, "going_back");
  level add_wait(::flag_wait, "_stealth_found_corpse");
  do_wait_any();
  self endon("goal");
  distsquared = dist * dist;

  while(distancesquared(self.origin, level.price.origin) < distsquared)
    wait 1;
}