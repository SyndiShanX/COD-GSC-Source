/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_34328dad68218b76.gsc
***********************************************/

#using script_19367cd29a4485db;
#using script_3411bb48d41bd3b;
#using script_5b95daf45672308f;
#using script_6155d71e1c9a57eb;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_utility;
#namespace namespace_a2a34bbc;

function private autoexec __init__system__() {
  system::register(#"hash_1613437b4759eb4a", &preinit, undefined, undefined, #"content_manager");
}

function preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_759fe9a9853a9b36")) && !getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  level.var_3c3b40c7 = sr_orda_health_bar::register();
  spawner::add_archetype_spawn_function(#"hulk", &function_43cf284);
  content_manager::register_script(#"hulking_summoner", &function_6ef31de9, 1);
}

function private function_6ef31de9(s_instance) {
  s_instance endon(#"cleanup");
  s_instance flag::clear("cleanup");
  level flag::wait_till(#"hash_34f9aa6f075e21c0");
  var_c088f113 = s_instance.contentgroups[# "trigger_spawn"][0];
  var_7af625c6 = s_instance.contentgroups[# "hash_11421144b772dcdf"][0];
  s_instance.n_obj_id = zm_utility::function_f5a222a8(#"hash_71d4dbe7c877d7ae", var_7af625c6.origin);
  level callback::add_callback(#"hash_594217387367ebb4", &function_b3a6e0bc, s_instance);

  while(!isDefined(s_instance.ai_hulk)) {
    s_instance.ai_hulk = namespace_85745671::function_9d3ad056(#"hash_21f3d5d40d72e08d", var_7af625c6.origin, var_7af625c6.angles, "world_event_orda");
    wait 0.1;
  }

  if(isDefined(s_instance.ai_hulk)) {
    s_instance.ai_hulk.var_a950813d = 1;
    s_instance.ai_hulk.instance = s_instance;

    if(isDefined(s_instance.n_obj_id)) {
      objective_onentity(s_instance.n_obj_id, s_instance.ai_hulk);
    }
  }
}

function function_b3a6e0bc(eventstruct) {
  if(isDefined(self.ai_hulk) && self.ai_hulk.current_state.name !== # "chase" && isDefined(level.var_fdcaf3a6) && distance2dsquared(self.ai_hulk.origin, level.var_fdcaf3a6.origin) < sqr(6000)) {
    self.ai_hulk.var_98f1f37c = 1;
    self.ai_hulk.allowdeath = 1;
    self.ai_hulk callback::callback(#"hash_10ab46b52df7967a");
    var_c39323b5 = 1;
  }

  if(is_true(var_c39323b5) || !isDefined(self.ai_hulk) || !isalive(self.ai_hulk)) {
    if(isDefined(self.n_obj_id)) {
      objective_clearentity(self.n_obj_id);
      zm_utility::function_bc5a54a8(self.n_obj_id);
      self.n_obj_id = undefined;
    }
  }
}

function function_43cf284() {
  self endon(#"death");
  self callback::function_d8abfc3d(#"death", &function_4d7e58e3);
  self callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_a1b85021);
  self callback::function_d8abfc3d(#"on_ai_damage", &function_558990e3);
  level flag::wait_till("objective_locked");

  if(level.contentmanager.activeobjective.content_script_name === # "holdout") {
    level waittill(#"survival_holdout_dest");
    self function_8bed563f();
    self val::set(#"hash_6b8a1b0c7fbf3df1", "ignoreall", 1);
    self val::set(#"hash_6b8a1b0c7fbf3df1", "ignoreme", 1);
    self val::set(#"hash_6b8a1b0c7fbf3df1", "takedamage", 0);
    self hide();

    if(isDefined(level.contentmanager.activeobjective)) {
      level.contentmanager.activeobjective waittill(#"return");
    }

    self val::reset_all(#"hash_6b8a1b0c7fbf3df1");
    self show();
  }
}

function function_a1b85021() {
  if(self.current_state.name === # "chase") {
    self thread function_cfa54bac();
  }
}

function function_558990e3(s_params) {
  self thread function_cfa54bac();
}

function function_6dcb2e93() {
  self endon(#"disconnect");
  self waittill(#"spawned_player");

  if(!isDefined(level.var_3c3b40c7)) {
    return;
  }

  foreach(other in getplayers()) {
    if(level.var_3c3b40c7 sr_orda_health_bar::is_open(other)) {
      var_3acd97a5 = arraygetclosest(other.origin, getaiarchetypearray(#"hulk"));

      if(!isDefined(var_3acd97a5)) {
        return;
      }

      n_health_percent = var_3acd97a5.health / var_3acd97a5.maxhealth;
      level.var_3c3b40c7 sr_orda_health_bar::open(self, 1);
      level.var_3c3b40c7 sr_orda_health_bar::set_health(self, n_health_percent);
      return;
    }
  }
}

function function_cfa54bac() {
  self notify("bd3edc313281b8e");
  self endon("bd3edc313281b8e");
  self endoncallback(&function_8bed563f, #"death");
  self endoncallback(&function_8bed563f, #"hash_3f015eab8b2c125a");
  self callback::function_52ac9652(#"hash_4afe635f36531659", &function_a1b85021);
  self callback::function_52ac9652(#"on_ai_damage", &function_558990e3);
  callback::on_connect(&function_6dcb2e93);
  n_health_percent = self.health / self.maxhealth;

  foreach(e_player in getplayers()) {
    if(!level.var_3c3b40c7 sr_orda_health_bar::is_open(e_player)) {
      level.var_3c3b40c7 sr_orda_health_bar::open(e_player, 1);
    }

    level.var_3c3b40c7 sr_orda_health_bar::set_health(e_player, n_health_percent);
  }

  level thread function_66917018();
  self thread function_4990efc9();

  while(true) {
    self waittill(#"damage", #"healing");
    n_health_percent = self.health / self.maxhealth;

    foreach(e_player in getplayers()) {
      if(level.var_3c3b40c7 sr_orda_health_bar::is_open(e_player)) {
        level.var_3c3b40c7 sr_orda_health_bar::set_health(e_player, n_health_percent);
      }
    }

    self thread function_4990efc9();
  }
}

function function_8bed563f(str_notify) {
  self notify(#"hash_5dbe35d2a8f175a5");

  foreach(e_player in getplayers()) {
    if(level.var_3c3b40c7 sr_orda_health_bar::is_open(e_player)) {
      level.var_3c3b40c7 sr_orda_health_bar::close(e_player);
    }
  }

  level thread function_b79f95b6();

  if(isalive(self)) {
    self callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_a1b85021);
    self callback::function_d8abfc3d(#"on_ai_damage", &function_558990e3);
  }

  callback::remove_on_connect(&function_6dcb2e93);
}

function function_4990efc9() {
  self notify("6dc90215a5b232a4");
  self endon("6dc90215a5b232a4");
  self endon(#"damage", #"death", #"hash_5dbe35d2a8f175a5");
  wait 10;

  while(self.current_state.name === # "chase") {
    wait 1;
  }

  self function_8bed563f();
}

function private function_4d7e58e3(eventstruct) {
  self callback::function_52ac9652(#"death", &function_4d7e58e3);
  instance = self.instance;

  if(!is_true(self.var_98f1f37c)) {
    if(isDefined(self.origin)) {
      v_drop = self.origin;
    } else {
      v_drop = instance.origin;
    }

    level thread zm_powerups::specific_powerup_drop("full_ammo", v_drop);
    level scoreevents::doscoreeventcallback("scoreEventSR", {
      #scoreevent: "event_complete", #nearbyplayers: 1, #var_b0a57f8c: 6000, #location: self.origin
    });
  }

  if(isDefined(instance.n_obj_id)) {
    objective_clearentity(instance.n_obj_id);
    zm_utility::function_bc5a54a8(instance.n_obj_id);
    instance.n_obj_id = undefined;
  }
}

function function_66917018() {
  level endon(#"hash_3c5a5e6a1814686a");
  level notify(#"hash_58fe6212779ab6f7");
  wait 1;
  namespace_9b972177::function_9a65b730("summoner");
}

function function_b79f95b6() {
  level endon(#"hash_58fe6212779ab6f7");
  level notify(#"hash_3c5a5e6a1814686a");
  wait 4;
  namespace_9b972177::function_16bede30();
}