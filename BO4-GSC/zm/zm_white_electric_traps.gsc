/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_electric_traps.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_trap_electric;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_items;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_traps;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_white_electric_traps;

autoexec __init__system__() {
  system::register(#"zm_white_electric_trap", &__init__, &__main__, undefined);
}

__init__() {
  level init_clientfields();
}

init_clientfields() {
  clientfield::register("actor", "" + #"electrocute_ai_fx", 20000, 1, "int");
  clientfield::register("scriptmover", "" + #"hash_6d40a3f1944d81b2", 20000, 2, "int");
}

__main__() {
  if(!zm_custom::function_901b751c(#"zmtrapsenabled")) {
    return;
  }

  var_c6eff49f = struct::get_array("s_electric", "targetname");

  foreach(var_edf030ab in var_c6eff49f) {
    var_edf030ab thread function_c6e2a4fd();
  }
}

function_c6e2a4fd() {
  var_5dac9747 = self.target2 + "_" + self.script_noteworthy;
  str_trigger = self.target3 + "_" + self.script_noteworthy;
  str_volume = self.target4 + "_" + self.script_noteworthy;
  self.var_5aecd907 = [];
  self.var_f35c90d7 = [];
  self.var_1be9f510 = [];
  self._trap_type = "electric";
  self.var_5aecd907 = struct::get_array(var_5dac9747, "targetname");
  self.var_f35c90d7 = struct::get_array(str_trigger, "targetname");
  self.a_e_lights = getEntArray(self.target5, "targetname");
  self.var_1be9f510 = getEntArray(str_volume, "targetname");

  foreach(vol in self.var_1be9f510) {
    vol._trap_type = "electric";
  }

  foreach(var_5c7a3998 in self.var_f35c90d7) {
    var_5c7a3998.trap_struct = self;
  }

  self.var_6b64b967 = 0;
  self.var_41ee2ddc = 1;

  if(isDefined(self.power_flag)) {
    level flag::wait_till("all_players_spawned");
    level flag::wait_till(self.power_flag);
  }

  self thread function_4d2eaaf4();
  self thread function_f118c57a();
}

function_4d2eaaf4() {
  foreach(var_5c7a3998 in self.var_f35c90d7) {
    var_5c7a3998 zm_unitrigger::create(&function_d12e5ff9, 64, &electric_trap_think);
  }
}

function_d12e5ff9(e_player) {
  if(e_player zm_utility::is_drinking()) {
    self sethintstring("");
    return 0;
  }

  if(self.stub.related_parent.trap_struct.var_6b64b967 === 1) {
    self sethintstring(#"zombie/trap_active");
    return 1;
  }

  if(isDefined(self.stub.related_parent.trap_struct.power_flag) && !level flag::get(self.stub.related_parent.trap_struct.power_flag)) {
    self sethintstring(#"zombie/need_power");
    return 1;
  }

  if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete")) {
    self sethintstring(#"zombie/need_power");
    return 1;
  }

  if(self.stub.related_parent.trap_struct.var_41ee2ddc === 0 || isDefined(level.var_4f7df1ac) && level.var_4f7df1ac) {
    self sethintstring(#"zombie/trap_cooldown");
    return 1;
  }

  if(util::get_game_type() == "zstandard") {
    if(function_8b1a219a()) {
      self sethintstring(#"hash_61d85c966dd9e83f");
      return 1;
    } else {
      self sethintstring(#"hash_24a438482954901");
      return 1;
    }

    return;
  }

  if(function_8b1a219a()) {
    self sethintstring(#"hash_6e8ef1b690e98e51", 1000);
    return 1;
  }

  self sethintstring(#"hash_23c1c09e94181fdb", 1000);
  return 1;
}

electric_trap_think() {
  level endon(#"end_game");

  while(true) {
    s_waitresult = self waittill(#"trigger");
    e_who = s_waitresult.activator;

    if(!zm_utility::can_use(e_who)) {
      continue;
    }

    if(isDefined(level.var_4f7df1ac) && level.var_4f7df1ac) {
      continue;
    }

    if(isDefined(self.stub.related_parent.trap_struct.power_flag) && !level flag::get(self.stub.related_parent.trap_struct.power_flag)) {
      continue;
    }

    if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete")) {
      continue;
    }

    if(self.stub.related_parent.trap_struct.var_6b64b967 === 1) {
      continue;
    }

    if(zm_utility::is_player_valid(e_who) && self.stub.related_parent.trap_struct.var_41ee2ddc === 1) {
      b_purchased = self.stub.related_parent.trap_struct.a_e_lights[0] zm_traps::trap_purchase(e_who, 1000);

      if(!b_purchased) {
        continue;
      }

      self.stub.related_parent.trap_struct notify(#"hash_5c14ac54b628d28");
      self.stub.related_parent.trap_struct.e_activator = e_who;

      if(!(isDefined(level.var_3c9cfd6f) && level.var_3c9cfd6f) && zm_audio::can_speak()) {
        e_who thread zm_audio::create_and_play_dialog(#"trap_electric", #"activate");
      }
    }
  }
}

function_f118c57a(e_player) {
  level endon(#"end_game");
  function_91ecec97(self.a_e_lights, "p8_zm_off_trap_switch_light_green_on");

  while(true) {
    self waittill(#"hash_5c14ac54b628d28");
    function_91ecec97(self.a_e_lights, "p8_zm_off_trap_switch_light_red_on");
    self.var_6b64b967 = 1;
    e_who = self.e_activator;

    foreach(e_volume in self.var_1be9f510) {
      e_volume.activated_by_player = e_who;
    }

    if(isDefined(e_who)) {
      zm_utility::play_sound_at_pos("purchase", e_who.origin);

      if(isDefined(self._trap_type)) {
        e_who zm_audio::create_and_play_dialog(#"trap_activate", self._trap_type);
      }

      level notify(#"trap_activated", {
        #trap_activator: e_who, 
        #trap: self
      });
    }

    switch (self.script_string) {
      case #"sequential":
        self function_193dbfbb();
        break;
      case #"moving":
        self function_6ae39b5();
        break;
    }

    self.var_6b64b967 = 0;
    self.var_41ee2ddc = 0;
    n_cooldown = zm_traps::function_da13db45(60, e_who);
    wait n_cooldown;
    function_91ecec97(self.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
    self.var_41ee2ddc = 1;
    playsoundatposition(#"zmb_trap_ready", self.origin);
  }
}

function_193dbfbb() {
  level endon(#"end_game");
  n_total_time = 0;
  n_check_time = 0.1;
  n_sequence = 1;
  var_34e4f6b8 = spawn("script_origin", self.origin);
  var_34e4f6b8 playSound(#"hash_1fb395621513432f");
  var_34e4f6b8 playLoopSound(#"hash_177d7a6df8ed0d7b");

  foreach(var_131f4c21 in self.var_5aecd907) {
    var_131f4c21.mdl_laser = util::spawn_model("tag_origin", var_131f4c21.origin, var_131f4c21.angles);
  }

  while(n_total_time < 40) {
    if(n_sequence == 1) {
      n_sequence = 0;
    } else {
      n_sequence = 1;
    }

    self function_70557fa2(n_sequence);

    for(i = 0; i < 2 / n_check_time; i++) {
      self thread function_a01c3869(n_sequence);
      self thread function_fae74a9e(n_sequence);
      wait n_check_time;
    }

    n_total_time += 2;
  }

  if(isDefined(var_34e4f6b8)) {
    playsoundatposition(#"hash_3819c6cd06a27f15", var_34e4f6b8.origin);
    var_34e4f6b8 delete();
  }

  self function_8f250fa1();
}

function_70557fa2(n_sequence) {
  foreach(var_131f4c21 in self.var_5aecd907) {
    if(var_131f4c21.script_int === n_sequence) {
      if(var_131f4c21.var_7f831216 === 2) {
        var_131f4c21.mdl_laser clientfield::set("" + #"hash_6d40a3f1944d81b2", 2);
      } else {
        var_131f4c21.mdl_laser clientfield::set("" + #"hash_6d40a3f1944d81b2", 1);
      }

      continue;
    }

    var_131f4c21.mdl_laser clientfield::set("" + #"hash_6d40a3f1944d81b2", 0);
  }
}

function_a01c3869(n_sequence) {
  a_ai_zombies = getaiteamarray(level.zombie_team);

  foreach(ai_zombie in a_ai_zombies) {
    foreach(var_6cc24199 in self.var_1be9f510) {
      if(var_6cc24199.script_int === n_sequence && isalive(ai_zombie) && ai_zombie istouching(var_6cc24199)) {
        ai_zombie thread zm_trap_electric::damage(var_6cc24199);
      }
    }
  }
}

function_fae74a9e(n_sequence) {
  a_e_players = getplayers();

  foreach(e_player in a_e_players) {
    foreach(var_6cc24199 in self.var_1be9f510) {
      if(var_6cc24199.script_int === n_sequence && isalive(e_player) && e_player istouching(var_6cc24199)) {
        e_player thread electrocute_player(var_6cc24199);
        continue;
      }

      if(isalive(e_player) && e_player istouching(var_6cc24199)) {
        if(!isDefined(e_player.var_58538bef)) {
          e_player thread function_9492f89b(var_6cc24199, 1);
        }
      }
    }
  }
}

function_6ae39b5() {
  level endon(#"end_game");
  n_total_time = 0;
  n_check_time = 0.1;
  var_131f4c21 = self.var_5aecd907[0];
  var_fc92faff = self.var_1be9f510[0];
  var_131f4c21.mdl_laser = util::spawn_model("tag_origin", var_131f4c21.origin, var_131f4c21.angles);
  var_131f4c21.mdl_laser enablelinkto();
  var_fc92faff enablelinkto();
  var_fc92faff linkto(var_131f4c21.mdl_laser);
  self thread function_3b764073();
  self thread function_242055cf();

  while(n_total_time < 40) {
    self thread function_a01c3869();
    self thread function_fae74a9e();
    wait n_check_time;
    n_total_time += n_check_time;
  }

  self function_8f250fa1();
}

function_242055cf() {
  level endon(#"end_game");
  mdl_laser = self.var_5aecd907[0].mdl_laser;
  v_start_pos = mdl_laser.origin;
  var_65c6475f = ceil(40 / 3 * 2);

  for(i = 0; i < var_65c6475f; i++) {
    mdl_laser moveto(self.origin, 2);
    mdl_laser waittill(#"movedone");
    wait 1;
    mdl_laser moveto(v_start_pos, 2);
    mdl_laser waittill(#"movedone");
    wait 1;
  }
}

function_3b764073() {
  foreach(var_131f4c21 in self.var_5aecd907) {
    if(isDefined(var_131f4c21.mdl_laser)) {
      var_131f4c21.mdl_laser clientfield::set("" + #"hash_6d40a3f1944d81b2", 1);
    }
  }
}

function_8f250fa1() {
  foreach(var_131f4c21 in self.var_5aecd907) {
    if(isDefined(var_131f4c21.mdl_laser)) {
      var_131f4c21.mdl_laser clientfield::set("" + #"hash_6d40a3f1944d81b2", 0);
    }
  }
}

electrocute_zombie(e_activator, e_volume) {
  self endon(#"death");
  self clientfield::set("" + #"electrocute_ai_fx", 1);
  self.marked_for_death = 1;

  if(isactor(self)) {
    refs[0] = "guts";
    refs[1] = "right_arm";
    refs[2] = "left_arm";
    refs[3] = "right_leg";
    refs[4] = "left_leg";
    refs[5] = "no_legs";
    refs[6] = "head";
    self.a.gib_ref = refs[randomint(refs.size)];
    playsoundatposition(#"hash_5183b687ad8d715a", self.origin);

    if(randomint(100) > 50) {
      self thread zm_traps::electroctute_death_fx();
    }

    bhtnactionstartevent(self, "electrocute");
    self notify(#"bhtn_action_notify", {
      #action: "electrocute"
    });
    wait randomfloat(1.25);
    self playSound(#"hash_5183b687ad8d715a");
  }

  self dodamage(self.health + 666, self.origin, e_activator, e_volume);
}

electrocute_player(e_trigger) {
  if(!isDefined(self.var_58538bef)) {
    self thread function_9492f89b(e_trigger, 0);
  } else if(self.var_58538bef) {
    self.var_58538bef = 0;
  }

  shock_status_effect = getstatuseffect(#"hash_19533caf858a9f3b");

  if(e_trigger zm_traps::function_3f401e8d(self)) {
    return;
  }

  if(!(isDefined(self.b_no_trap_damage) && self.b_no_trap_damage)) {
    self thread zm_traps::player_elec_damage(e_trigger);
    status_effect::status_effect_apply(shock_status_effect, undefined, self, 0);
  }
}

function_91ecec97(a_e_lights, str_model) {
  foreach(light in a_e_lights) {
    light setModel(str_model);
  }
}

function_9492f89b(v_volume, var_1e034eed) {
  self endon(#"disconnect");
  self.var_58538bef = var_1e034eed;

  while(isalive(self) && self istouching(v_volume)) {
    waitframe(1);
  }

  if(self.var_58538bef && (self zm_utility::is_jumping() || self issliding())) {
    self notify(#"hash_15541419dbbe7e1a");
  }

  self.var_58538bef = undefined;
}