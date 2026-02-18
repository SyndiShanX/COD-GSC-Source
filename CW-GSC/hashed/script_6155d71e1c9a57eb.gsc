/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6155d71e1c9a57eb.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_9b972177;

function private autoexec __init__system__() {
  system::register(#"hash_946f5279d6cd83c", undefined, &init_postload, undefined, undefined);
}

function private init_postload() {
  if(!is_true(level.is_survival)) {
    return;
  }

  level.var_d1b0ffd = undefined;
  level.var_d4a9453c = 0;
  level.var_b4b53e55 = 0;
  callback::on_spawned(&on_player_spawned);
  callback::add_callback(#"objective_started", &function_83b6d24a);
  callback::add_callback(#"objective_ended", &function_2b1da4a6);
}

function on_end_game() {
  var_9c1ed9ea = "gameover_survival";

  if(isDefined(level.var_e6512c09)) {
    var_9c1ed9ea = level.var_e6512c09;
  }

  function_5a47adab(var_9c1ed9ea);
}

function on_player_spawned() {
  if(level flag::get(#"intro_scene_done")) {
    if(isDefined(level.var_d1b0ffd) && level.var_d1b0ffd != "") {
      self set_to_player(level.var_d1b0ffd);
    } else {
      self set_to_player("");
    }
  }

  self thread underscore();
}

function on_player_connect() {
  if(flag::get(#"intro_scene_done")) {
    if(isDefined(level.var_d1b0ffd) && level.var_d1b0ffd != "") {
      self set_to_player(level.var_d1b0ffd);
      return;
    }

    self set_to_player("");
  }
}

function function_83b6d24a(params) {
  if(!isDefined(params)) {
    return;
  }

  if(!isDefined(params.instance)) {
    return;
  }

  if(is_true(params.instance.var_6c9943b1)) {
    return;
  }

  str_objective_name = undefined;
  s_instance = params.instance;

  if(isDefined(s_instance.content_script_name)) {
    str_objective_name = s_instance.content_script_name;
  }

  function_df47d1da(str_objective_name);
}

function function_2b1da4a6(params) {
  if(is_true(params.instance.var_6c9943b1)) {
    return;
  }

  str_objective_name = undefined;
  s_instance = params.instance;

  if(isDefined(s_instance.content_script_name)) {
    str_objective_name = s_instance.content_script_name;
  }

  function_a9cc2e9f(params.completed, str_objective_name);
}

function function_df47d1da(str_objective_name) {
  if(is_true(getgametypesetting(#"hash_1e8998fd7f271bb7"))) {
    return;
  }

  level notify(#"hash_1034af1a853c873d");
  level.var_d4a9453c = 1;
  function_5d985962(0);
  var_71ce1ff1 = function_86df3ee8(str_objective_name);

  if(isDefined(var_71ce1ff1)) {
    var_9c1ed9ea = var_71ce1ff1;
  } else {
    var_9c1ed9ea = "survival_objective_" + randomintrange(0, 3);
  }

  function_5a47adab(var_9c1ed9ea);
}

function function_a9cc2e9f(b_completed, str_objective_name = 1) {
  if(is_true(getgametypesetting(#"hash_1e8998fd7f271bb7"))) {
    return;
  }

  level notify(#"hash_27abcd3efcaaf572");
  level.var_d4a9453c = 0;

  if(str_objective_name) {
    function_5a47adab("");
    function_5d985962(1);
  }
}

function function_9a65b730(var_4338e57e) {
  if(is_true(getgametypesetting(#"hash_1e8998fd7f271bb7"))) {
    return;
  }

  if(!is_true(level.var_d4a9453c) && !is_true(level.var_b4b53e55)) {
    level.var_b4b53e55 = 1;
    function_5d985962(0);
    function_5a47adab(var_4338e57e);
  }
}

function function_16bede30() {
  if(is_true(getgametypesetting(#"hash_1e8998fd7f271bb7"))) {
    return;
  }

  if(!is_true(level.var_d4a9453c)) {
    level.var_b4b53e55 = 0;
    function_5a47adab("");
    function_5d985962(1);
  }
}

function function_9f5c2ff2(var_9c1ed9ea) {
  if(is_true(getgametypesetting(#"hash_1e8998fd7f271bb7"))) {
    return;
  }

  level notify(#"hash_65e9b602c68b844d");
  level.var_d4a9453c = 1;
  function_5d985962(0);
  function_5a47adab(var_9c1ed9ea);
}

function function_b8af32da() {
  if(is_true(getgametypesetting(#"hash_1e8998fd7f271bb7"))) {
    return;
  }

  level.var_d4a9453c = 0;
  function_5a47adab("");
  function_5d985962(1);
}

function function_5d985962(var_b375589a) {
  level.var_b375589a = var_b375589a;

  if(!var_b375589a) {
    foreach(player in level.players) {
      player.var_edc6d524 = "";
      player.var_187e3f7e = "";
    }
  }
}

function underscore() {
  self endon(#"death");
  self endon(#"disconnect");

  if(is_true(getgametypesetting(#"hash_1e8998fd7f271bb7"))) {
    return;
  }

  if(is_true(level.var_149a60e7)) {
    return;
  }

  if(!isDefined(level.var_b375589a)) {
    level.var_b375589a = 0;
  }

  if(!isDefined(self.var_edc6d524)) {
    self.var_edc6d524 = "";
  }

  if(!isDefined(self.var_187e3f7e)) {
    self.var_187e3f7e = "";
  }

  self thread function_28f119be();

  while(true) {
    waitresult = self waittill(#"change_underscore");

    if(is_true(level.var_b375589a)) {
      if(isDefined(waitresult.var_9c1ed9ea)) {
        self.var_187e3f7e = waitresult.var_9c1ed9ea;
      }

      if(self.var_edc6d524 !== self.var_187e3f7e) {
        set_to_player(self.var_187e3f7e);
        self.var_edc6d524 = self.var_187e3f7e;
      }
    }
  }
}

function function_28f119be() {
  self endon(#"death");
  self endon(#"disconnect");

  while(true) {
    if(!is_true(level.var_b375589a)) {
      wait 0.1;
      continue;
    }

    a_enemies = getaiarray();
    var_d300714c = function_61eeb910(self, a_enemies);
    var_3ac2b3dc = var_d300714c.var_9dd94851 || var_d300714c.var_b16c3c87;

    if(var_3ac2b3dc && self.var_edc6d524 != "survival_underscore_active") {
      self notify(#"change_underscore", {
        #var_9c1ed9ea: "survival_underscore_active"});
    } else if(var_d300714c.var_8cebd3a9 && !var_3ac2b3dc && self.var_edc6d524 === "") {
      self notify(#"change_underscore", {
        #var_9c1ed9ea: "survival_underscore"});
    } else if(!var_d300714c.var_8cebd3a9 && !var_3ac2b3dc && self.var_edc6d524 != "survival_underscore") {
      if(function_2d36215b(self, a_enemies)) {
        self notify(#"change_underscore", {
          #var_9c1ed9ea: "survival_underscore"});
      } else {
        self notify(#"change_underscore", {
          #var_9c1ed9ea: ""});
      }
    } else if(!var_d300714c.var_8cebd3a9 && !var_3ac2b3dc && self.var_edc6d524 != "") {
      if(!function_2d36215b(self, a_enemies)) {
        self notify(#"change_underscore", {
          #var_9c1ed9ea: ""});
      }
    }

    wait 5;
  }
}

function function_2d36215b(e_player, a_enemies) {
  ai_closest = array::get_all_closest(e_player.origin, a_enemies, undefined, undefined, 2500);

  if(ai_closest.size >= 6) {
    return true;
  }

  return false;
}

function function_61eeb910(e_player, a_enemies) {
  var_2a7ac8ab = 0;
  var_50e79c32 = 0;
  var_fb83b33f = 0;
  n_counter = 0;

  foreach(enemy in a_enemies) {
    if(isDefined(enemy.favoriteenemy)) {
      if(enemy.favoriteenemy == self) {
        n_counter++;

        if(is_true(enemy.var_d8695234) || is_true(enemy.var_c588eb) || enemy.archetype === # "raz" || enemy.archetype === # "mimic") {
          var_fb83b33f = 1;
        }
      }
    }

    if(n_counter >= 6) {
      var_50e79c32 = 1;
    }
  }

  if(n_counter > 0) {
    var_2a7ac8ab = 1;
  }

  return {
    #var_8cebd3a9: var_2a7ac8ab, #var_b16c3c87: var_50e79c32, #var_9dd94851: var_fb83b33f
  };
}

function function_5a47adab(var_9c1ed9ea) {
  level.var_d1b0ffd = var_9c1ed9ea;

  foreach(player in level.players) {
    player set_to_player(var_9c1ed9ea);
  }
}

function set_to_player(var_9c1ed9ea) {
  music::setmusicstate(var_9c1ed9ea, self);
}

function function_86df3ee8(str_objective_name) {
  str_override = undefined;

  switch (str_objective_name) {
    case # "holdout":
      str_override = "survival_objective_hold_0";
      break;
    case # "secure":
      str_override = "survival_objective_secure_0";
      break;
    case # "mq4":
      str_override = "jellyfish_all_around";
      break;
    default:
      str_override = undefined;
      break;
  }

  if(isDefined(level.var_75b02512)) {
    str_override = level.var_75b02512;
  }

  return str_override;
}

function function_57292af3() {
  var_9c1ed9ea = "survival_intro";

  if(isDefined(level.var_f546b995)) {
    var_9c1ed9ea = "survival_intro_" + level.var_f546b995;
  }

  if(is_true(getgametypesetting(#"hash_1e8998fd7f271bb7"))) {
    var_9c1ed9ea = "";
  }

  function_5a47adab(var_9c1ed9ea);
}

function insertion(var_df887556) {
  level endon(#"hash_1034af1a853c873d", #"hash_65e9b602c68b844d");
  wait 5;
  function_5d985962(1);
}