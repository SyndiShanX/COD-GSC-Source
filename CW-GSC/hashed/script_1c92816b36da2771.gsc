/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1c92816b36da2771.gsc
***********************************************/

#using script_1ea5c1aec36ac889;
#using script_3411bb48d41bd3b;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\archetype\archetype_zod_companion;
#using scripts\zm\zm_platinum_vo;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_intel;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;
#namespace namespace_6fb22263;

function init() {
  level.var_93f1848f = getent("klaus_barricade_01", "targetname");
  level.var_93f1848f makesentient();
  level.var_adabb803 = getent("klaus_barricade_02", "targetname");
  level.var_93c6843d = getent("klaus_barricade_03", "targetname");
  level.var_7636dd99 = getent("klaus_barricade_col", "targetname");
  level.var_d46d2206 = getent("brain_rot_check_vol", "targetname");
  level.var_fdbdc48f = struct::get("klaus_barricade_pos", "targetname");

  level thread function_cd7a3de4();
  level thread function_8d8c6876();

  level zm_sq::register(#"hash_6ab89cd32fd14628", #"step_1", #"hash_6ab89cd32fd14628", &function_dac6c069, &function_ea7dccdf);
  level zm_sq::start(#"hash_6ab89cd32fd14628", 1);
  level.var_7636dd99 disconnectpaths();
  level.var_dd86d7a7 = 2000;
  level thread function_c3447490();
  level thread function_e61f50db();
  callback::on_item_pickup(&on_item_pickup);
  spawner::add_archetype_spawn_function(#"zod_companion", &function_95d547cd);
  spawner::add_archetype_spawn_function(#"zod_companion", &function_d47881a3);
  var_8f2f30f5 = getEntArray("klaus_radio", "targetname");
  array::run_all(var_8f2f30f5, &function_619a5c20);
  level.var_bc98869d = struct::get_array("klaus_exfil_loc", "targetname");
  level.var_7030d9f = struct::get("tag_align_klaus_sit", "targetname");
  level thread function_e61b4631();
  callback::on_revived(&on_player_revived);
  callback::on_actor_killed(&function_b3791df9);
  callback::add_callback(#"on_host_migration_end", &on_host_migration_end);
}

function function_d47881a3() {
  self endon(#"death");
  counters = array(0, 0);
  timeout_time = gettime();
  var_686cf729 = undefined;
  last_origin = self.origin;

  while(true) {
    var_686cf729 = last_origin == self.origin ? var_686cf729 : undefined;
    last_origin = self.origin;

    while(self isplayinganimscripted() || is_true(self.var_8dd8140a)) {
      counters = array(0, 0);
      wait 1;
      continue;
    }

    waitresult = self waittilltimeout(2, #"bad_path", #"goal");

    if(self isplayinganimscripted() || is_true(self.var_8dd8140a)) {
      continue;
    }

    goalinfo = self function_4794d6a3();

    switch (waitresult._notify) {
      case # "bad_path":
        if(!self function_dd070839()) {
          counters[1]++;
          var_686cf729 = goalinfo.goalpos;
        }
      case # "goal":
        if(isDefined(var_686cf729) && goalinfo.goalpos === var_686cf729) {
          break;
        }

        counters[1] = 0;
        var_686cf729 = undefined;
      default:
        if(gettime() - timeout_time >= 2000) {
          if(last_origin == self.origin) {
            counters[0]++;
          } else {
            counters[0] = 0;
          }

          timeout_time = gettime();
        }

        break;
    }

    if(counters[0] > 45 || counters[1] > 10) {
      function_c94afb95(1);
    }
  }
}

function function_73367fa9() {
  if(isDefined(level.klaus)) {
    level.var_d8930bb3 = level.klaus zodcompanionutility::function_3419fc55();
    self.owner = level.klaus.owner;

    if(isDefined(level.klaus.n_obj_id)) {
      zm_utility::function_bc5a54a8(level.klaus.n_obj_id);
      level.klaus.n_obj_id = undefined;
    }

    self.n_obj_id = zm_utility::function_f5a222a8(#"hash_209bfeab2ecbce14", self);
  }

  self clientfield::set("" + # "hash_3e4641a9ea00d061", 0);

  if(isDefined(level.var_7c745515)) {
    self.var_80cee89b = level.var_7c745515;
  }

  if(isDefined(level.klaus.leader)) {
    self.leader = level.klaus.leader;
  }

  if(isDefined(level.klaus.owner)) {
    self.owner = level.klaus.owner;
  }

  if(isDefined(level.klaus.var_c0d80964)) {
    self.var_c0d80964 = level.klaus.var_c0d80964;
  }

  if(isDefined(level.var_d8930bb3)) {
    if(isarray(level.var_d8930bb3)) {
      foreach(callback_func in level.var_d8930bb3) {
        self zodcompanionutility::function_fc67b7ed(callback_func);
      }
    } else {
      self zodcompanionutility::function_fc67b7ed(level.var_d8930bb3);
    }
  }

  if(isDefined(level.klaus)) {
    level.klaus delete();
  }

  level.klaus = self;
}

function event_handler[hostmigration_playermigrated] codecallback_playermigrated(eventstruct) {
  if(!level flag::get("klaus_helm_crafted")) {
    if(isDefined(level.klaus)) {
      level.klaus hidepart("J_Helm");
    }
  }
}

function function_95d547cd() {
  self clientfield::set("" + # "hash_3e4641a9ea00d061", 1);

  if(!level flag::get("klaus_helm_crafted")) {
    self hidepart("J_Helm");
  }
}

function function_dac6c069(var_a276c861) {
  callback::on_ai_spawned(&on_ai_spawned);
  callback::on_actor_killed(&function_ffe3712a);
  scene::add_scene_func(#"hash_c1640839c1a4da0", &function_9f1d395, "init");
  level thread function_c8b7a7da();
  level thread function_b1ac17cb();
  level thread function_e9e410c2();
  level flag::wait_till(#"hash_5f5899aa1acda8de");

  if(isDefined(level.var_7636dd99)) {
    level.var_7636dd99 connectpaths();
    level.var_7636dd99 notsolid();
  }

  level flag::set("connect_east_berlin_hotel_to_jack_room");
  level flag::wait_till(#"hash_5503fb2f49e6a242");
}

function function_ea7dccdf(var_a276c861, var_19e802fa) {
  if(var_a276c861 || var_19e802fa) {
    level.var_93f1848f hide();
    level.var_adabb803 hide();
    level.var_93c6843d hide();
    level.var_7636dd99 connectpaths();
    level.var_7636dd99 notsolid();
    level flag::set("connect_east_berlin_hotel_to_jack_room");
    level flag::clear(#"hash_392c756e6906b2a2");
    level flag::set(#"hash_504c8d65e27d0216");
    level flag::clear(#"hash_20e3ef55ace43370");
    level flag::set(#"hash_ea77ee1e954ccf");
    level flag::set(#"hash_5503fb2f49e6a242");
    a_players = function_a1ef346b();

    if(isDefined(level.klaus)) {
      level.klaus showpart("J_Wrist_LE", "c_t9_zmb_dlc4_battle_klaus_body", 1);
      level.klaus showpart("J_Wrist_RI", "c_t9_zmb_dlc4_battle_klaus_body", 1);
    }

    if(isDefined(level.var_86967fca)) {
      level.var_86967fca delete();
    }

    zm_utility::function_d729de6a(1, [# "zone_safe_house"]);

    if(isDefined(level.klaus)) {
      level.klaus thread zm_platinum_vo::function_b6999bc7();
    }

    level thread function_5df1db76(a_players[0]);
    level thread function_8d5c5a84(a_players[0], 1);
    level.var_dd86d7a7 = 2000;
  }
}

function function_ffe3712a(params) {
  if(self.archetype !== # "mechz") {
    return;
  }

  level notify(#"hash_4c46400ce2d2546d", {
    #position: self.origin, #aitype: self.aitype
  });
}

function function_c8b7a7da() {
  level endon(#"game_ended", #"hash_20e3ef55ace43370");

  while(true) {
    waitresult = level waittill(#"hash_4c46400ce2d2546d");

    if(zm_utility::check_point_in_playable_area(waitresult.position)) {
      point = function_4ba8fde(#"item_zmquest_platinum_klaus_battery");
      var_169eb568 = item_drop::drop_item(0, undefined, 1, 0, point.id, waitresult.position, undefined, 2);
      var_169eb568.var_dd21aec2 = 1 | 16;
      var_169eb568.itementry.var_4cd830a = 1;
      break;
    }
  }
}

function private on_ai_spawned() {
  if(self.archetype === # "zombie") {
    if(!level flag::get(#"hash_1ec3570883b4621e")) {
      self.on_brainrot = &function_f0c28731;
    }
  }
}

function private function_f0c28731() {
  self thread function_1d1380d1();
}

function private function_1d1380d1() {
  self endon(#"death");

  if(!isDefined(level.var_d46d2206)) {
    return;
  }

  while(!level flag::get(#"hash_1ec3570883b4621e")) {
    if(!isDefined(level.var_7d95f3b6) || level.var_7d95f3b6 == self) {
      if(istouching(self.origin, level.var_d46d2206) || isDefined(self.attacker.origin) && istouching(self.attacker.origin, level.var_d46d2206)) {
        level.var_7d95f3b6 = self;
        self.var_8b59c468 = &function_60e4a5cf;
      } else {
        level.var_7d95f3b6 = undefined;
        self.var_8b59c468 = undefined;
      }
    } else {
      self.var_8b59c468 = undefined;
    }

    wait 1;
  }

  self.var_8b59c468 = undefined;
}

function private function_60e4a5cf() {
  if(!is_true(self.aat_turned)) {
    return;
  }

  if(level flag::get(#"hash_1ec3570883b4621e")) {
    self.favoriteenemy = undefined;
    return;
  }

  e_barricade = level.var_93f1848f;

  if(isDefined(e_barricade)) {
    self setgoal(level.var_fdbdc48f);
    self.favoriteenemy = e_barricade;

    if(is_true(self.var_92724e20)) {
      return;
    }

    n_dist = distancesquared(self.origin, e_barricade.origin);

    if(n_dist < 4096) {
      self thread function_2c0c38a6();
    }
  }
}

function function_2c0c38a6() {
  self endon(#"death");
  self.var_92724e20 = 1;

  if(!level flag::get(#"hash_2e1d65f192bc836d")) {
    self thread animation::play("ai_t9_zm_zombie_base_attack_02");
    self waittill(#"zombie_melee");
    level flag::set(#"hash_2e1d65f192bc836d");
  }

  if(!level flag::get(#"hash_53366bbacf4a4d81")) {
    self thread animation::play("ai_t9_zm_zombie_base_attack_01");
    self waittill(#"zombie_melee");
    level flag::set(#"hash_53366bbacf4a4d81");
  }

  if(!level flag::get(#"hash_45739b14988fa0da")) {
    self thread animation::play("ai_t9_zm_zombie_base_attack_02");
    self waittill(#"zombie_melee");
    level flag::set(#"hash_45739b14988fa0da");
  }

  self.favoriteenemy = undefined;
  self.var_92724e20 = undefined;
}

function function_b1ac17cb() {
  level endon(#"end_game");
  level flag::wait_till(#"hash_2e1d65f192bc836d");
  playsoundatposition(#"hash_3062089467caadf9", level.var_93f1848f.origin);
  level.var_93f1848f thread scene::play(#"hash_e8f7626058dd98b", level.var_93f1848f);
  level.var_93f1848f notsolid();
  level waittill(#"hash_53366bbacf4a4d81");
  playsoundatposition(#"hash_3062089467caadf9", level.var_93c6843d.origin);
  level.var_93c6843d thread scene::play(#"hash_e8f7826058ddcf1", level.var_93c6843d);
  level.var_93c6843d notsolid();
  level waittill(#"hash_45739b14988fa0da");
  playsoundatposition(#"hash_3062089467caadf9", level.var_adabb803.origin);
  level.var_adabb803 thread scene::play(#"hash_e8f7726058ddb3e", level.var_adabb803);
  level.var_adabb803 notsolid();
  level flag::set(#"hash_1ec3570883b4621e");
  level.var_7d95f3b6 = undefined;
  level.var_93f1848f function_60d50ea4();
  wait 1.5;
  level flag::set(#"hash_5f5899aa1acda8de");
}

function private function_e9e410c2() {
  var_6ce87cc1 = struct::get("hotel_klaus_hand_pos", "targetname");
  level scene::init(#"hash_c1640839c1a4da0");
  level waittill(#"hash_5f5899aa1acda8de");
  e_player = var_6ce87cc1 zm_unitrigger::function_fac87205(#"hash_33a598ef0986e1d0", 20);
  e_player val::set(#"hash_3130bc68547f6e0d", "disable_weapons");
  level notify(#"hash_57f2c29e7e96eda7");
  e_player flag::set(#"hash_7fb35d12e64cf793");
  e_player.var_7d32b2c6 = 0;
  e_player val::set(#"hash_2d4db1e2c3e7d2f1", "ignoreme", 1);
  level scene::play(#"hash_c1640839c1a4da0", e_player);

  if(isDefined(e_player)) {
    e_player val::reset(#"hash_2d4db1e2c3e7d2f1", "ignoreme");
    e_player.var_7d32b2c6 = undefined;
    e_player flag::clear(#"hash_7fb35d12e64cf793");
  }

  array::thread_all(getplayers(), &zm_intel::collect_intel, #"zmintel_platinum_requiem_artifact_01");
  level zm_ui_inventory::function_7df6bb60(#"hash_6a83f912cd01808c", 1);

  if(isDefined(e_player)) {
    e_player val::reset(#"hash_3130bc68547f6e0d", "disable_weapons");
  }

  level flag::set(#"hash_392c756e6906b2a2");
  function_5f47a7c2(#"hand_trigger");
}

function function_9f1d395(a_ents) {
  level.var_7f5dece9 = a_ents[# "hash_3ff4f1ad9bf348f6"];
  level.var_7f5dece9 function_619a5c20();
}

function function_5f47a7c2(var_9b0beac5) {
  switch (var_9b0beac5) {
    case # "hand_trigger":
      if(level flag::get(#"hash_20e3ef55ace43370")) {
        zm_unitrigger::unregister_unitrigger(level.var_7030d9f.s_unitrigger);
        level.var_7030d9f zm_unitrigger::create(#"hash_2c3c554b12d5df70", 70, &function_c1de4506);
      } else {
        level.var_7030d9f zm_unitrigger::create(#"hash_21c91c10a92808e8", 70, &function_9ccbc60d);
      }

      break;
    case # "battery_trigger":
      if(level flag::get(#"hash_392c756e6906b2a2")) {
        zm_unitrigger::unregister_unitrigger(level.var_7030d9f.s_unitrigger);
        level.var_7030d9f zm_unitrigger::create(#"hash_2c3c554b12d5df70", 70, &function_c1de4506);
      } else {
        level.var_7030d9f zm_unitrigger::create(#"hash_31ddc51f017469cf", 70, &function_cd5cd91b);
      }

      break;
    case # "hash_20aee20bab8b4015":
      break;
  }
}

function function_9ccbc60d() {
  self endon(#"kill_trigger");

  while(true) {
    waitresult = self waittill(#"trigger");
    e_player = waitresult.activator;

    if(isPlayer(e_player)) {
      e_player function_bc82f900(#"zm_interact_rumble");
    }

    if(!zm_utility::can_use(e_player)) {
      continue;
    }

    level flag::clear(#"hash_392c756e6906b2a2");
    level flag::set(#"hash_504c8d65e27d0216");
    level thread function_eff5258f(e_player);
    zm_unitrigger::unregister_unitrigger(level.var_7030d9f.s_unitrigger);
    waitframe(1);
  }
}

function function_cd5cd91b() {
  self endon(#"kill_trigger");

  while(true) {
    waitresult = self waittill(#"trigger");
    e_player = waitresult.activator;

    if(isPlayer(e_player)) {
      e_player function_bc82f900(#"zm_interact_rumble");
    }

    if(!zm_utility::can_use(e_player)) {
      continue;
    }

    level flag::clear(#"hash_20e3ef55ace43370");
    level flag::set(#"hash_ea77ee1e954ccf");
    level thread function_83b1ebd5(e_player);
    zm_unitrigger::unregister_unitrigger(level.var_7030d9f.s_unitrigger);
    waitframe(1);
  }
}

function function_c1de4506() {
  self endon(#"kill_trigger");

  while(true) {
    waitresult = self waittill(#"trigger");
    e_player = waitresult.activator;

    if(isPlayer(e_player)) {
      e_player function_bc82f900(#"zm_interact_rumble");
    }

    if(!zm_utility::can_use(e_player)) {
      continue;
    }

    level flag::clear(#"hash_392c756e6906b2a2");
    level flag::set(#"hash_504c8d65e27d0216");
    level thread function_eff5258f(e_player);
    level flag::clear(#"hash_20e3ef55ace43370");
    level flag::set(#"hash_ea77ee1e954ccf");
    level thread function_83b1ebd5(e_player);
    zm_unitrigger::unregister_unitrigger(level.var_7030d9f.s_unitrigger);
    waitframe(1);
  }
}

function private function_eff5258f(var_ba86b46) {
  if(isDefined(level.klaus)) {
    level.klaus showpart("J_Wrist_LE", "c_t9_zmb_dlc4_battle_klaus_body", 1);
    level.klaus showpart("J_Wrist_RI", "c_t9_zmb_dlc4_battle_klaus_body", 1);

    if(isDefined(level.var_86967fca)) {
      level.var_86967fca delete();
    }

    level.klaus playSound(#"hash_959c459c39ed856");
    level thread function_f0bfb4bb(var_ba86b46);
  }
}

function private function_83b1ebd5(var_ba86b46) {
  var_40f19a2b = struct::get(#"hash_62ef3afbc8fb21e", "targetname");
  var_af3fc617 = util::spawn_model(#"p9_zm_platinum_battery_pack", var_40f19a2b.origin, var_40f19a2b.angles);
  var_af3fc617 playSound(#"hash_59d0bfe69e34e2a");
  wait 1;
  level scene::play(#"hash_e667b7bb5057190", "close_hatch", level.klaus);
  level thread scene::play(#"hash_e667b7bb5057190", "sit_loop_with_hatch_closed", level.klaus);
  var_af3fc617 delete();
  level thread function_f0bfb4bb(var_ba86b46);
}

function private function_f0bfb4bb(var_ba86b46) {
  if(level flag::get(#"hash_ea77ee1e954ccf") && level flag::get(#"hash_504c8d65e27d0216")) {
    zm_utility::function_d729de6a(1, [# "zone_safe_house"]);

    if(isDefined(level.klaus)) {
      level.klaus thread zm_platinum_vo::function_b6999bc7();
    }

    level thread function_5df1db76(var_ba86b46);
    level thread function_8d5c5a84(var_ba86b46, 1);
    level flag::set(#"hash_5503fb2f49e6a242");
  }
}

function private function_c3447490() {
  level flag::wait_till("initial_blackscreen_passed");
  scene::add_scene_func(#"hash_e667b7bb5057190", &function_3691fd0b, "sit_loop_hatch_opened");
  level thread scene::play(#"hash_e667b7bb5057190", "sit_loop_hatch_opened");

  if(isDefined(level.klaus)) {
    level.klaus clientfield::set("" + # "hash_3e4641a9ea00d061", 1);
  }

  level.var_cee8794f = struct::get("tag_align_klaus_sit", "targetname");
  level.klaus_hole_loc = struct::get("klaus_hole_loc", "targetname");
}

function function_3691fd0b(a_ents) {
  level.klaus = a_ents[# "klaus"];

  if(isDefined(level.klaus)) {
    level.klaus hidepart("J_Helm");
    level.var_86967fca = a_ents[# "weapon"];
    level.klaus clientfield::set("" + # "hash_703543ca871a0f75", 0);
    level.klaus flag::set(#"hash_2ba0c8dec55ab3f2");
    level flag::set(#"hash_720384d338d58cf4");
    level.klaus hidepart("J_Wrist_LE", "c_t9_zmb_dlc4_battle_klaus_body", 1);
    level.klaus hidepart("J_Wrist_RI", "c_t9_zmb_dlc4_battle_klaus_body", 1);
  }
}

function private function_e61f50db() {
  var_3cf3aa06 = struct::get_array("klaus_radio", "targetname");
  function_b503a4ce(0);
  level flag::wait_till(#"hash_5503fb2f49e6a242");
  function_b503a4ce(2);

  foreach(var_a9fd9d6d in var_3cf3aa06) {
    if(var_a9fd9d6d.script_noteworthy === "sh_kl_rd") {
      var_a9fd9d6d zm_unitrigger::create(&function_cd37638e, (36, 64, 64), &function_b88fcac5);
      continue;
    }

    var_a9fd9d6d zm_unitrigger::create(&function_cd37638e, 64, &function_b88fcac5);
  }
}

function private function_b503a4ce(n_state) {
  var_3cf3aa06 = struct::get_array("klaus_radio", "targetname");

  switch (n_state) {
    case 0:
      foreach(struct in var_3cf3aa06) {
        mdl_radio = util::spawn_model(#"p9_zm_platinum_radio_call_boxes", struct.origin, struct.angles);

        if(!isDefined(level.var_8f2f30f5)) {
          level.var_8f2f30f5 = [];
        } else if(!isarray(level.var_8f2f30f5)) {
          level.var_8f2f30f5 = array(level.var_8f2f30f5);
        }

        level.var_8f2f30f5[level.var_8f2f30f5.size] = mdl_radio;
      }

      break;
    case 1:
      if(isarray(level.var_8f2f30f5)) {
        foreach(radio in level.var_8f2f30f5) {
          radio setModel(#"p9_zm_platinum_radio_call_boxes_on");
          radio function_619a5c20();
          radio playSound(#"hash_694ca8a2f30e0e55");
          radio clientfield::set("" + # "klaus_radio_obj", 1);

          if(!isDefined(radio.var_7ecc12d9)) {
            radio.var_7ecc12d9 = radio playLoopSound(#"hash_27a52bcb771fe5e5");
          }
        }
      }

      break;
    case 2:
      foreach(radio in level.var_8f2f30f5) {
        radio setModel(#"p9_zm_platinum_radio_call_boxes_off");
        radio function_619a5c20();
        radio playSound(#"hash_7b6bafe300f8cd31");
        radio clientfield::set("" + # "klaus_radio_obj", 0);

        if(isDefined(radio.var_7ecc12d9)) {
          radio stoploopsound(radio.var_7ecc12d9);
          radio.var_7ecc12d9 = undefined;
        }
      }

      break;
  }
}

function function_cd37638e(e_player) {
  if(level flag::get(#"hash_4b065039d7f1a611")) {
    return 0;
  }

  if(level flag::get(#"hash_6d16c284cbb301d1")) {
    self sethintstring(#"hash_699fa2bf0dc59d0a");
    return 1;
  }

  if(level flag::get(#"hash_57651acabc979ef4")) {
    self sethintstring(#"hash_5da96c5cd62c2b6b");
    return 1;
  }

  self sethintstring(#"hash_43ea7417941fd644", level.var_dd86d7a7);
  return 1;
}

function function_b88fcac5() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"trigger");

    if(!level flag::get(#"hash_57651acabc979ef4") && !level flag::get(#"hash_6d16c284cbb301d1")) {
      e_player = waitresult.activator;

      if(!zm_utility::can_use(e_player)) {
        continue;
      }

      if(e_player zm_score::can_player_purchase(level.var_dd86d7a7)) {
        playsoundatposition(#"hash_101e63a672483dad", self.origin);
        e_player zm_score::minus_to_player_score(level.var_dd86d7a7);
        level.var_dd86d7a7 = 2000;
        function_b503a4ce(2);
        level thread function_8d5c5a84(e_player);

        if(isDefined(level.klaus)) {
          level.klaus.owner = e_player;
        }
      } else {
        level.var_dd86d7a7 -= e_player.score;

        iprintlnbold("<dev string:x38>" + e_player.score + "<dev string:x4b>" + level.var_dd86d7a7);

        e_player zm_score::minus_to_player_score(e_player.score);
      }

      if(isPlayer(e_player)) {
        e_player playrumbleonentity(#"zm_interact_rumble");
      }
    }

    waitframe(1);
  }
}

function function_a8333f44(override_time = undefined) {
  level endon(#"hash_5eb0053f75fee299", #"end_game", #"hash_7c60044f6a90f7f5", #"hash_3e5422d0a468ceb8", #"hash_2394f251215a8fae");
  self notify("75d1cf60a23ea155");
  self endon("75d1cf60a23ea155");

  if(isDefined(override_time)) {
    wait override_time;
  } else if(level flag::get(#"hash_75f07aed08b6bb5e")) {
    wait 168;
  } else {
    wait 120;
  }

  function_55bd650c();
}

function function_55bd650c() {
  if(is_true(level.var_743318e1)) {
    return;
  }

  if(level flag::get(#"hash_279a97271de2b7e1")) {
    level function_b10f9033();
    level flag::clear(#"hash_6d16c284cbb301d1");
    level notify(#"hash_2304a1d24bb8597f");
    level thread function_ac84a204();
    level thread function_ec916ba1();

    if(isDefined(level.klaus)) {
      level.klaus.owner = undefined;
    }
  }
}

function function_ec916ba1() {
  level endon(#"hash_567b7d7322c5892b");
  level flag::set(#"hash_57651acabc979ef4");
  function_b503a4ce(2);
  wait 120;
  level flag::clear(#"hash_57651acabc979ef4");
  function_b503a4ce(1);
}

function private function_c7a25b76() {
  self endon(#"death");

  while(isDefined(self.leader)) {
    if(!level flag::get(#"hash_279a97271de2b7e1")) {
      return;
    }

    waitframe(1);
  }

  level notify(#"hash_3e5422d0a468ceb8");
  function_55bd650c();
}

function function_9215d4c0(s_params) {
  attacker = s_params.eattacker;

  if(attacker === level.klaus && isPlayer(level.klaus.leader)) {
    level scoreevents::doscoreeventcallback("scoreEventZM", {
      #attacker: level.klaus.leader, #scoreevent: # "hash_7a2b38dbc394a3e1", #enemy: self
    });
    level.klaus.leader zm_stats::increment_challenge_stat(#"hash_708cbf9c621c9597");
  }
}

function private function_8d5c5a84(var_a5839c5b, var_1e447653 = 0) {
  level flag::set(#"hash_6d16c284cbb301d1");
  callback::on_ai_killed(&function_9215d4c0);

  if(var_1e447653) {
    level thread function_8f45af77(var_a5839c5b);
    level flag::set(#"hash_2629dab56bd39ff5");

    if(isDefined(level.klaus)) {
      level.klaus clientfield::set("" + # "hash_703543ca871a0f75", 1);
      level.klaus.var_8dd8140a = 1;
      level scene::play(#"hash_e667b7bb5057190", "stand_up_struggle", level.klaus);

      if(level.klaus.origin != (-261.636, 13500, -263.511)) {
        level.klaus forceteleport((-261.636, 13500, -263.511));
      }

      level.klaus.var_8dd8140a = 0;
      level.klaus clientfield::set("" + # "hash_3e4641a9ea00d061", 0);
    }

    level flag::set(#"hash_19be6db4d7ab2200");
    zm_utility::function_d729de6a(0, [# "zone_safe_house"]);
  } else if(isDefined(level.klaus)) {
    var_22043f8e = var_a5839c5b.origin;
    level.klaus zodcompanionutility::function_3fb3f41e(var_a5839c5b);
    level.klaus zodcompanionutility::function_681263de();
    level.klaus playSound(#"hash_260545f3283bead9");
    level thread function_9eef76d4();
    var_d15867da = var_a5839c5b.cached_zone_name;

    if(isDefined(var_d15867da)) {
      if(isinarray(level.var_65c43c31, var_d15867da)) {
        level scene::play(#"hash_e667b7bb5057190", "stand_up", level.klaus);
        level scene::play(#"hash_e667b7bb5057190", "stand_up_intro_to_idle", level.klaus);
      } else {
        level scene::play(#"hash_e667b7bb5057190", "stand_up", level.klaus);
        level scene::play(#"hash_e667b7bb5057190", "walk_fly_out", level.klaus);

        if(isDefined(var_a5839c5b) && isDefined(var_22043f8e)) {
          level.klaus forceteleport(getclosestpointonnavmesh(var_22043f8e, 999, 100));
        } else {
          var_6b90fdca = struct::get("klaus_backup_land_pos", "targetname");
          level.klaus forceteleport(getclosestpointonnavmesh(var_6b90fdca.origin, 300, 100));
        }

        level.klaus zodcompanionutility::function_681263de();
        level.klaus thread function_d805df4d();
        level scene::play(#"hash_e667b7bb5057190", "fly_in", level.klaus);
      }
    }

    level thread namespace_33c196c8::function_e7136ed2(var_a5839c5b);
    level flag::set(#"hash_279a97271de2b7e1");
  }

  if(isDefined(level.klaus)) {
    level.klaus.n_obj_id = zm_utility::function_f5a222a8(#"hash_209bfeab2ecbce14", level.klaus);
    level.klaus clientfield::set("" + # "hash_3e4641a9ea00d061", 0);
    level.klaus thread function_c7a25b76();
    level.klaus zodcompanionutility::function_633d6f7b(0);
  }

  level thread function_a8333f44();
}

function private function_5df1db76(var_ba86b46) {
  level endon(#"hash_19be6db4d7ab2200");
  var_ba86b46 endon(#"disconnect");
  level waittill(#"hash_71df321b5441bd94");
  level thread namespace_33c196c8::function_e7136ed2(var_ba86b46);
  level flag::set(#"hash_279a97271de2b7e1");
  var_ba86b46 waittill(#"hash_7b63ce1ec3e195b4");

  if(isDefined(level.klaus)) {
    level.klaus flag::set(#"hash_28114ffa1168ced9");
  }

  level scene::stop(#"hash_e667b7bb5057190");
}

function private function_8f45af77(var_a5839c5b) {
  level flag::wait_till(#"hash_720384d338d58cf4");

  if(isDefined(level.klaus)) {
    level.klaus zodcompanionutility::function_3fb3f41e(var_a5839c5b);
  }
}

function function_c94afb95(var_eaf5148f = 0) {
  level endon(#"hash_3f335a51cee1c293");

  if(!isDefined(level.klaus)) {
    return;
  }

  var_8b274988 = zm_zonemgr::get_zone_from_position(level.klaus.origin);
  var_8dd281be = isinarray(level.var_65c43c31, var_8b274988);
  level.klaus thread zm_platinum_vo::function_cc3eb0e8();
  level.klaus playSound(#"hash_4aff00bda51f3122");

  if(isDefined(level.klaus.leader)) {
    level thread namespace_33c196c8::function_2d3ad651(level.klaus.leader);
  }

  level.klaus zodcompanionutility::function_34179e9a();

  if(!var_eaf5148f) {
    exfil_loc = level.klaus function_99383da0();
    callback::remove_on_ai_killed(&function_9215d4c0);
    var_8704f18f = var_8dd281be ? level.var_cee8794f.origin : exfil_loc.origin;
    level.klaus zodcompanionutility::function_14f3d97b(var_8704f18f, 1);
    level.klaus waittill(#"goal");
  }

  level.klaus clientfield::set("" + # "hash_3e4641a9ea00d061", 1);

  if(isDefined(level.klaus.n_obj_id)) {
    zm_utility::function_bc5a54a8(level.klaus.n_obj_id);
    level.klaus.n_obj_id = undefined;
  }

  if(var_8dd281be) {
    level scene::play(#"hash_e667b7bb5057190", "sit_down_with_turn", level.klaus);
  } else {
    level scene::play(#"hash_e667b7bb5057190", "fly_out", level.klaus);
    level scene::play(#"hash_e667b7bb5057190", "fly_in_walk", level.klaus);
    level scene::play(#"hash_e667b7bb5057190", "sit_down", level.klaus);
  }

  level thread scene::play(#"hash_e667b7bb5057190", "sit_loop", level.klaus);
}

function private function_99383da0() {
  var_781b19f5 = 99999;

  foreach(loc in level.var_bc98869d) {
    var_6bde26ff = distance(loc.origin, self.origin);
    z_offset = loc.origin[2] - self.origin[2];
    target_zone = zm_zonemgr::get_zone_from_position(loc.origin);

    if(var_6bde26ff < var_781b19f5 && z_offset < 500 && z_offset > -500 && zm_zonemgr::zone_is_enabled(target_zone)) {
      var_781b19f5 = var_6bde26ff;
      var_7b794373 = loc;
    }
  }

  if(isDefined(var_7b794373)) {
    return var_7b794373;
  }

  return self;
}

function private function_b10f9033() {
  level endon(#"end_game", #"hash_3f335a51cee1c293");
  level flag::wait_till_clear(#"hash_66eb1b5632f46da8");

  if(isDefined(level.klaus)) {
    level.klaus flag::wait_till_clear(#"reviving_a_player");
  }

  level flag::clear(#"hash_279a97271de2b7e1");
  function_c94afb95();
}

function on_item_pickup(params) {
  item = params.item;

  if(isPlayer(self)) {
    if(isDefined(item.itementry)) {
      switch (item.itementry.name) {
        case # "item_zmquest_platinum_klaus_hand":
          level zm_ui_inventory::function_7df6bb60(#"hash_6a83f912cd01808c", 1);
          level flag::set(#"hash_392c756e6906b2a2");

          iprintlnbold("<dev string:x74>");

          break;
        case # "item_zmquest_platinum_klaus_battery":
          level zm_ui_inventory::function_7df6bb60(#"hash_4b03961693d6a43a", 1);
          level flag::set(#"hash_20e3ef55ace43370");
          function_5f47a7c2(#"battery_trigger");
          array::thread_all(getplayers(), &zm_intel::collect_intel, #"zmintel_platinum_omega_artifact_01");

          iprintlnbold("<dev string:x8d>");

          break;
      }
    }
  }
}

function private function_d805df4d() {
  level endon(#"end_game", #"hash_279a97271de2b7e1");
  level waittill(#"hash_16edc834907a3c69");
  self thread function_75de6325();
  self thread function_d2653f4c();
}

function private function_9eef76d4() {
  level endon(#"end_game");
  wait 2;

  if(isDefined(level.klaus)) {
    level.klaus thread zm_platinum_vo::function_2a5a3ef4();
  }
}

function private function_75de6325() {
  a_zombies = self getenemiesinradius(self.origin, 400);

  foreach(zombie in a_zombies) {
    if(zombie.zm_ai_category === # "normal" && isalive(zombie)) {
      zombie zombie_utility::setup_zombie_knockdown(self.origin);
    }
  }
}

function private function_d2653f4c() {
  a_players = function_a1ef346b(undefined, self.origin, 400);

  foreach(player in a_players) {
    if(isalive(player)) {
      player function_bc82f900(#"hash_16b38e722c3ccc");
    }
  }
}

function private function_e61b4631() {
  level endon(#"end_game");
  var_6927f3bb = 0;

  while(!var_6927f3bb) {
    if(level flag::get(#"hash_392c756e6906b2a2") && level flag::get(#"hash_20e3ef55ace43370")) {
      break;
    }

    a_players = function_a1ef346b();

    foreach(player in a_players) {
      player_zone = player.cached_zone_name;

      if(distance(player.origin, level.var_7030d9f.origin) < 300 && player_zone === "zone_safe_house") {
        level flag::set(#"hash_4f9fb4cb9a1c3158");
        var_6927f3bb = 1;
        break;
      }
    }

    wait 1;
  }
}

function private function_ac84a204() {
  level endon(#"end_game", #"hash_6d16c284cbb301d1", #"hash_56267ee0c41be1fb");

  if(isDefined(level.klaus)) {
    level.klaus endon(#"death");
  }

  while(true) {
    if(isDefined(level.klaus)) {
      a_players = function_a1ef346b(undefined, level.klaus.origin, 200);

      foreach(player in a_players) {
        if(!player flag::get(#"hash_2928b9ed24838b5a") && !level flag::get(#"hash_9fadb9e12ac3696")) {
          player flag::set(#"hash_2928b9ed24838b5a");
          player thread function_297e6185();
        }
      }
    }

    waitframe(1);
  }
}

function private function_297e6185() {
  self endon(#"death");

  if(isDefined(level.klaus)) {
    level.klaus endon(#"death");
  }

  var_702cfbbf = gettime() + int(4 * 1000);

  while(true) {
    if(isDefined(level.klaus) && distance(self.origin, level.klaus.origin) > 200 || level flag::get(#"hash_6d16c284cbb301d1") || level flag::get(#"hash_535517e75a9e59ca") || self scene::is_igc_active()) {
      self flag::clear(#"hash_2928b9ed24838b5a");
      break;
    }

    if(gettime() > var_702cfbbf) {
      if(math::cointoss(10)) {
        if(isDefined(level.klaus)) {
          level.klaus thread zm_platinum_vo::function_b4b07ee0();
        }

        level flag::set(#"hash_535517e75a9e59ca");
        level thread function_6902c12b();
      }

      self flag::clear(#"hash_2928b9ed24838b5a");
      break;
    }

    waitframe(1);
  }
}

function private function_6902c12b() {
  level endon(#"end_game");
  level thread flag::set_for_time(20, #"hash_9fadb9e12ac3696");
}

function on_player_revived(params) {
  if(isDefined(params.e_reviver) && params.e_reviver == level.klaus) {
    level.klaus thread zm_platinum_vo::function_37c7631f();
  }
}

function function_b3791df9(params) {
  if(isDefined(params.eattacker)) {
    if(level.klaus === params.eattacker && params.smeansofdeath == "MOD_RIFLE_BULLET") {
      level.klaus thread zm_platinum_vo::function_63803452();
    }

    if(level.klaus === params.eattacker && params.smeansofdeath == "MOD_MELEE") {
      level.klaus thread zm_platinum_vo::function_6a1fe73a();
    }
  }
}

function on_host_migration_end(params) {
  if(isDefined(level.klaus) && !level flag::get(#"hash_504c8d65e27d0216")) {
    level.klaus hidepart("J_Wrist_LE", "c_t9_zmb_dlc4_battle_klaus_body", 1);
    level.klaus hidepart("J_Wrist_RI", "c_t9_zmb_dlc4_battle_klaus_body", 1);
  }
}

function function_cd7a3de4() {
  util::add_debug_command("<dev string:xa9>");
  util::add_debug_command("<dev string:x100>");
  util::add_debug_command("<dev string:x157>");
  util::add_debug_command("<dev string:x1b2>");
  util::add_debug_command("<dev string:x215>");
  util::add_debug_command("<dev string:x27f>");
  util::add_debug_command("<dev string:x2f7>");
  util::add_debug_command("<dev string:x352>");
  zm_devgui::add_custom_devgui_callback(&cmd);
}

function cmd(cmd) {
  switch (cmd) {
    case # "hash_4ce575885ab4acea":
      level flag::set(#"hash_75f07aed08b6bb5e");
      break;
    case # "collect_hands":
      level flag::set(#"hash_392c756e6906b2a2");
      level zm_ui_inventory::function_7df6bb60(#"hash_6a83f912cd01808c", 1);
      function_5f47a7c2(#"hand_trigger");
      break;
    case # "collect_battery":
      level flag::set(#"hash_20e3ef55ace43370");
      level zm_ui_inventory::function_7df6bb60(#"hash_4b03961693d6a43a", 1);
      function_5f47a7c2(#"battery_trigger");
      break;
    case # "hash_19a215e19189ffcb":
      level flag::toggle(#"hash_66eb1b5632f46da8");
      break;
    case # "hash_46febba823b8b1fc":
      level flag::set(#"hash_5f5899aa1acda8de");
      break;
    case # "hash_21562ac47b7b0515":
      if(level flag::get(#"hash_57651acabc979ef4")) {
        level notify(#"hash_567b7d7322c5892b");
        level flag::clear(#"hash_57651acabc979ef4");
        function_b503a4ce(1);
      }
    case # "hash_54da172330d6643a":
      if(is_true(level.var_5f8aa169)) {
        level notify(#"hash_212022a63900fb38");
      } else {
        level thread function_953cbff5();
      }

      break;
    case # "hash_3a5dbf52c46ea8de":
      if(is_true(level.var_743318e1)) {
        level.var_743318e1 = undefined;
        iprintlnbold("<dev string:x3b8>");
      } else {
        level.var_743318e1 = 1;
        iprintlnbold("<dev string:x3d2>");
      }

      break;
  }
}

function function_953cbff5() {
  level endon(#"end_game", #"hash_212022a63900fb38");
  var_9039575a = getent("<dev string:x3ed>", "<dev string:x406>");
  var_3cf3aa06 = struct::get_array("<dev string:x414>", "<dev string:x406>");

  while(true) {
    if(isDefined(level.klaus)) {
      circle(level.klaus.origin, 50, (0, 1, 0));
      print3d(level.klaus.origin, "<dev string:x423>", (0, 1, 0));
    }

    if(isDefined(var_9039575a)) {
      circle(var_9039575a.origin, 100, (0, 1, 0));
      print3d(var_9039575a.origin, "<dev string:x42c>", (0, 1, 0));
    }

    if(isarray(var_3cf3aa06)) {
      foreach(var_927876a9 in var_3cf3aa06) {
        circle(var_927876a9.origin, 30, (0, 1, 0));
        print3d(var_927876a9.origin, "<dev string:x445>", (0, 1, 0));
      }
    }

    waitframe(1);
  }
}

function private function_8d8c6876() {
  level endon(#"end_game");

  while(true) {
    if(isDefined(level.klaus) && level flag::get(#"hash_5503fb2f49e6a242")) {
      if(getdvarint(#"hash_2090a496be9714aa", 0)) {
        iprintln("<dev string:x454>" + level flag::get(#"hash_6d16c284cbb301d1") + "<dev string:x46a>" + "<dev string:x471>" + level flag::get(#"hash_279a97271de2b7e1") + "<dev string:x46a>" + "<dev string:x486>" + level flag::get(#"hash_57651acabc979ef4"));
        iprintln("<dev string:x498>" + level flag::get(#"hash_66eb1b5632f46da8") + "<dev string:x46a>" + "<dev string:x4b3>" + level flag::get(#"hash_75f07aed08b6bb5e"));

        if(isDefined(level.klaus.exhausted)) {
          iprintln("<dev string:x4c7>" + level.klaus.exhausted);
        } else {
          iprintln("<dev string:x4dc>");
        }
      }
    }

    wait 3;
  }
}