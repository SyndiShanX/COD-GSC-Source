/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_74608ad5d25450b1.gsc
***********************************************/

#include script_174ce72cc0f850;
#include script_24c32478acf44108;
#include script_724752ab26bff81b;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_white_main_quest;
#include scripts\zm\zm_white_util;
#include scripts\zm\zm_white_zones;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_item_pickup;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;

#namespace namespace_3b2b9e06;

preload() {
  namespace_bd74bbd2::register(#"sc_mk2x", 20000, "sc_mk2x", &function_a66f0de2, &function_17f3e9e2);
  clientfield::register("scriptmover", "" + #"hash_56a1bc72bf8de8f1", 20000, 1, "int");
  clientfield::register("actor", "" + #"hash_38c69da8fb2b74e4", 20000, 1, "int");
}

init() {
  level.var_ae5fb719 = spawnStruct();
  level.var_ae5fb719.n_step = 0;
  level.var_ae5fb719.var_10630268 = getweapon("ray_gun_mk2x");
  level.var_ae5fb719.var_d58b0729 = getweapon("ray_gun_mk2x_upgraded");
  callback::on_disconnect(&on_disconnect);
}

private function_18a1849f(e_player) {
  if(!isDefined(level.var_ae5fb719.e_player)) {
    return false;
  }

  return e_player === level.var_ae5fb719.e_player;
}

private function_f6048ee(e_player) {
  if(isDefined(e_player)) {
    if(!isDefined(level.var_ae5fb719.e_player)) {
      if(isDefined(e_player.var_9c20e2c9)) {
        self sethintstring(#"hash_744b68f010abb05");
      } else {
        self sethintstring(#"hash_12346bdab086516e");
      }
    } else if(level.var_ae5fb719.e_player == e_player) {
      self sethintstring(#"hash_74fc96e8d58ff646");
    } else {
      self sethintstring(#"hash_2054e8fdb6521566");
    }

    return true;
  }

  return false;
}

private function_5b4f9f76(e_player) {
  var_2fff5cb5 = level.var_ae5fb719.e_player === e_player;
  var_24441d81 = !isDefined(level.var_ae5fb719.e_player) && !isDefined(e_player.var_9c20e2c9);
  return var_2fff5cb5 || var_24441d81;
}

private function_5cedad9c(w_weapon) {
  return isDefined(w_weapon) && (w_weapon == level.var_ae5fb719.var_10630268 || w_weapon == level.var_ae5fb719.var_d58b0729);
}

start_quest() {
  start_step_1();
}

private start_step_1() {
  level thread function_cbeb9a33();

  if(!isDefined(level.var_ae5fb719.s_start)) {
    level.var_ae5fb719.s_start = zm_hms_util::function_4e7f5b2e("mk2x_start");
  }

  level.var_ae5fb719.var_fead3ae9 = util::spawn_model("p8_zm_whi_fuse_pickup_empty", level.var_ae5fb719.s_start.origin, level.var_ae5fb719.s_start.angles);
  e_drawer = getent(level.var_ae5fb719.s_start.target, "targetname");

  if(!isDefined(e_drawer.b_open)) {
    e_drawer setCanDamage(1);
    e_drawer val::set("quest_mk2x", "allowDeath", 0);
    e_drawer thread function_4e9f1680();
  } else {
    s_unitrigger = level.var_ae5fb719.var_fead3ae9 zm_item_pickup::create_item_pickup(&function_9d66ea6f, &function_f6048ee, &function_5b4f9f76, 80);
    zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
  }

  exploder::exploder("fxexp_mk2_x_smoke_emit_" + level.var_ae5fb719.s_start.exploder_id);
  level.var_ae5fb719.n_step = 1;
}

private function_4e9f1680() {
  self endon(#"death");
  pixbeginevent(#"hash_73eb0f44c0388afc");

  while(true) {
    s_notify = self waittill(#"damage");
    e_player = s_notify.attacker;

    if(s_notify zm_hms_util::function_69320b44("zm_aat_frostbite")) {
      self setCanDamage(0);
      self thread function_c0fc92d2();
      break;
    }
  }

  pixendevent();
}

private function_c0fc92d2() {
  self endon(#"death");
  exploder::stop_exploder("fxexp_mk2_x_smoke_emit_" + level.var_ae5fb719.s_start.exploder_id);
  v_dest = self.origin + 8 * self.open_dir;
  level.var_ae5fb719.var_fead3ae9 linkto(self);
  self playSound("zmb_ee_drawer_open");
  self moveto(v_dest, 0.1);
  self waittill(#"movedone");
  level.var_ae5fb719.var_fead3ae9 unlink();
  level.var_ae5fb719.s_start.origin = level.var_ae5fb719.var_fead3ae9.origin;
  s_unitrigger = level.var_ae5fb719.var_fead3ae9 zm_item_pickup::create_item_pickup(&function_9d66ea6f, &function_f6048ee, &function_5b4f9f76, 80);
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
  self.b_open = 1;
}

private function_9d66ea6f(e_item, e_player) {

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(e_player.name + "<dev string:x38>");
    println(e_player.name + "<dev string:x38>");
  }

    level.var_ae5fb719.e_player = e_player;
  namespace_a01a2431::function_605e5c25(e_player);
  e_player.var_9c20e2c9 = 1;
  e_player playSound("evt_canister_pickup");
  zm_ui_inventory::function_7df6bb60("zm_white_ww_mod_phase", 1, e_player);
  zm_ui_inventory::function_7df6bb60("zm_white_ww_mk2x_ammo", 1, e_player);
  e_player thread function_130ea633();
  start_step_2();
}

function_130ea633() {
  if(zm_utility::is_classic()) {
    self zm_vo::vo_stop();
    self zm_hms_util::function_51b752a9("vox_ww_x_ammo_pickup");

    if(!zm_white_main_quest::function_6cebbce1()) {
      self zm_audio::do_player_or_npc_playvox("vox_ww_x_freeze_rush_0", 1);
    }
  }
}

private start_step_2() {
  level.var_ae5fb719.var_ad2870bb = 3;
  level.var_ae5fb719.var_128cd2c8 = 3;
  callback::on_ai_spawned(&function_ecdebc72);
  callback::on_ai_killed(&function_c6c9eeef);
  level.var_ae5fb719.n_step = 2;
}

private function_ecdebc72() {
  self endon(#"death");

  if(self.archetype === #"zombie" && math::cointoss(20)) {
    while(!isDefined(self.spawn_pos)) {
      waitframe(1);
    }

    if(zm_white_zones::is_bunker_zone(self.spawn_pos.zone_name) && function_e4f54b1d() < level.var_ae5fb719.var_ad2870bb) {
      self.var_13a2274b = 1;
      self.actor_damage_func = &function_cdddec81;
      self zombie_utility::set_zombie_run_cycle("walk");
      self clientfield::set("" + #"hash_38c69da8fb2b74e4", 1);
    }
  }
}

private function_e4f54b1d() {
  n_count = 0;
  a_ai_zombies = getaiteamarray(level.zombie_team);

  foreach(ai_zombie in a_ai_zombies) {
    if(ai_zombie.var_13a2274b === 1) {
      n_count++;
    }
  }

  return n_count;
}

function_cdddec81(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isplayer(attacker)) {
    if(attacker zm_hms_util::function_fab5fb4d(weapon, "zm_aat_frostbite")) {
      if(self.var_7ba65499 !== 1) {
        self set_frozen(1);
        self thread function_53817e75();
      }

      if(damage >= self.health) {
        return 0;
      }
    } else if(meansofdeath == "MOD_MELEE" && self.var_7ba65499 === 1) {
      if(level.var_ae5fb719.var_ad2870bb > 0) {
        level thread function_baec0416(self.origin, self.angles);
      }

      self zombie_utility::zombie_eye_glow_stop();
      self clientfield::set("" + #"hash_757f891a37d3db00", 1);
      return (self.health + 666);
    }
  }

  return damage;
}

private set_frozen(b_frozen = 1) {
  if(b_frozen) {
    self clientfield::set("" + #"hash_5ad28d5f104a6e3b", 1);
    self clientfield::set("" + #"hash_1aa3522b88c2b76f", 1);
    self clientfield::set("" + #"hash_259cdeffe60fe48f", 1);
    self namespace_9ff9f642::freeze();
    self.var_7ba65499 = 1;
    return;
  }

  self clientfield::set("" + #"hash_5ad28d5f104a6e3b", 0);
  self clientfield::set("" + #"hash_1aa3522b88c2b76f", 0);
  self clientfield::set("" + #"hash_259cdeffe60fe48f", 0);
  self namespace_9ff9f642::unfreeze();
  self.var_7ba65499 = undefined;
}

function_c6c9eeef(s_params) {
  if(self.var_7ba65499 === 1) {
    self set_frozen(0);
  }
}

private function_53817e75() {
  self endon(#"death");
  wait 5;
  self set_frozen(0);
}

private function_baec0416(v_pos, v_angles) {
  if(isDefined(v_pos)) {
    v_drop = zm_hms_util::function_6d41bab8(v_pos, 360);
  }

  if(isDefined(v_drop)) {
    v_ground = groundtrace(v_drop + (0, 0, 32) + (0, 0, 8), v_drop + (0, 0, 32) + (0, 0, -100000), 0, self)[#"position"];
    v_normal = getnavmeshfacenormal(v_drop, 32);
    var_55ab02db = function_c1fa62a2(v_angles, v_normal);
    e_goo = util::spawn_model("p8_zm_whi_goop_puddle_01", v_ground, var_55ab02db);
    e_goo zm_item_pickup::create_item_pickup(&function_cf69599, "", &function_18a1849f, 96);
    e_goo.targetname = "mk2x_goo";
    level.var_ae5fb719.var_ad2870bb--;
    waitframe(1);

    if(isDefined(e_goo)) {
      zm_unitrigger::reregister_unitrigger_as_dynamic(e_goo.s_unitrigger);
    }
  }
}

private function_cf69599(e_item, e_player) {
  level.var_ae5fb719.var_128cd2c8--;
  e_player playSound("evt_ee_goo_pickup");

  if(level.var_ae5fb719.var_128cd2c8 == 2) {
    if(zm_utility::is_classic()) {
      e_player thread zm_hms_util::function_51b752a9("vox_ww_x_goo_acquire");
    }

    return;
  }

  if(level.var_ae5fb719.var_128cd2c8 < 1) {

    if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
      iprintlnbold(e_player.name + "<dev string:x65>");
      println(e_player.name + "<dev string:x65>");
    }

      if(!zm_white_main_quest::function_6cebbce1() && !(isDefined(level.var_5dd0d3ff.isspeaking) && level.var_5dd0d3ff.isspeaking)) {
        if(zm_utility::is_classic()) {
          e_player thread zm_white_util::function_491673da(#"hash_aec062a8a2a5d26");
        }
      }

    function_6f437b06();
    start_step_3();
  }
}

private function_6f437b06() {
  callback::remove_on_ai_spawned(&function_ecdebc72);
  callback::remove_on_ai_killed(&function_c6c9eeef);
}

private cleanup_step_2() {
  function_6f437b06();
  a_e_goo = getEntArray("mk2x_goo", "targetname");
  array::run_all(a_e_goo, &zm_item_pickup::function_d6812b9d);
}

private start_step_3() {
  s_sc = struct::get("mk2x_sc");
  s_sc zm_unitrigger::create("");
  s_sc thread function_473f437();
  level.var_ae5fb719.n_step = 3;
}

private function_473f437() {
  self endon(#"death", #"stop_think");

  while(true) {
    s_notify = self waittill(#"trigger_activated");
    playsoundatposition("evt_rgun_frame_putback", (-223, -1658, -178));

    if(function_18a1849f(s_notify.e_who)) {
      level.var_ae5fb719.var_fead3ae9 = util::spawn_model("p8_zm_whi_fuse_pickup_fluid_purple_half", self.origin, self.angles);
      namespace_bd74bbd2::start(#"sc_mk2x");

      if(zm_utility::is_classic()) {
        level.var_ae5fb719.e_player thread zm_hms_util::function_51b752a9("vox_ww_x_charge");
      }

      zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
      break;
    }
  }
}

private function_a66f0de2() {
  namespace_bd74bbd2::end(#"sc_mk2x");
  s_unitrigger = level.var_ae5fb719.var_fead3ae9 zm_item_pickup::create_item_pickup(&function_b9a31cb, &function_f6048ee, &function_5b4f9f76);
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
  level.var_ae5fb719.var_fead3ae9 setModel("p8_zm_whi_fuse_pickup_fluid_purple");
  level.var_ae5fb719.var_fead3ae9 clientfield::set("" + #"hash_56a1bc72bf8de8f1", 1);
}

private function_b9a31cb(e_item, e_player) {

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(e_player.name + "<dev string:x82>");
    println(e_player.name + "<dev string:x82>");
  }

    zm_ui_inventory::function_7df6bb60("zm_white_ww_mk2x_ammo", 2, e_player);
  e_player.var_f7694097 = 1;
  e_player playSound("evt_canister_pickup");

  if(!zm_white_main_quest::function_6cebbce1() && zm_utility::is_classic()) {
    e_player thread zm_white_util::function_491673da(#"hash_28707927bb714f9");
  }

  start_step_4();
}

private function_17f3e9e2() {
  s_unitrigger = level.var_ae5fb719.var_fead3ae9 zm_unitrigger::create(&function_7015dc35);
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
  level.var_ae5fb719.var_fead3ae9 thread function_2ac1278b();
}

private function_7015dc35(e_player) {
  if(isDefined(e_player)) {
    if(level.var_ae5fb719.e_player === e_player) {
      self sethintstring(#"hash_14eae7c162ebb8d2");
    } else {
      self sethintstring(#"hash_2054e8fdb6521566");
    }

    return true;
  }

  return false;
}

private function_2ac1278b() {
  self endon(#"death");

  while(true) {
    s_notify = self waittill(#"trigger_activated");
    e_player = s_notify.e_who;

    if(function_18a1849f(e_player)) {
      namespace_bd74bbd2::start(#"sc_mk2x");
      zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
      break;
    }
  }
}

cleanup_step_3() {
  if(isDefined(level.var_ae5fb719.var_fead3ae9)) {
    namespace_bd74bbd2::end(#"sc_mk2x");
    level.var_ae5fb719.var_fead3ae9 delete();
    return;
  }

  s_sc = struct::get("mk2x_sc");
  s_sc notify(#"stop_think");
  zm_unitrigger::unregister_unitrigger(s_sc.s_unitrigger);
}

private start_step_4() {
  level.var_ae5fb719.e_player thread function_cba90c3c();
  level.var_ae5fb719.n_step = 4;
}

private function_cba90c3c() {
  self endon(#"death");
  self waittill(#"hash_13f3f231b45420ef");
  self thread function_c6fc34a();
  complete_quest();
}

function_c6fc34a() {
  if(zm_utility::is_classic()) {
    self zm_vo::vo_stop();
    self zm_hms_util::function_51b752a9("vox_ww_x_craft");

    if(!zm_white_main_quest::function_6cebbce1()) {
      self zm_audio::do_player_or_npc_playvox("vox_ww_x_craft_rush_1", 1);
    }
  }
}

private complete_quest() {

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(level.var_ae5fb719.e_player.name + "<dev string:x9f>");
    println(level.var_ae5fb719.e_player.name + "<dev string:x9f>");
  }

    level.var_ae5fb719.e_player = undefined;
  level.var_ae5fb719.n_step = 5;
}

private on_disconnect() {
  if(function_18a1849f(self)) {
    restart_quest();
  }
}

private restart_quest(var_e19b7aed = 1) {
  switch (level.var_ae5fb719.n_step) {
    case 1:
      var_e19b7aed = 0;
      break;
    case 2:
      cleanup_step_2();
      break;
    case 3:
      cleanup_step_3();
      break;
  }

  level.var_ae5fb719.e_player = undefined;

  if(var_e19b7aed) {
    start_step_1();
  }
}

function_cbeb9a33() {
  level waittill(#"insanity_mode_triggered");
  exploder::stop_exploder("fxexp_mk2_x_smoke_emit_" + level.var_ae5fb719.s_start.exploder_id);

  if(isDefined(level.var_ae5fb719.var_fead3ae9) && isDefined(level.var_ae5fb719.var_fead3ae9.s_unitrigger)) {
    zm_unitrigger::unregister_unitrigger(level.var_ae5fb719.var_fead3ae9.s_unitrigger);
    level.var_ae5fb719.var_fead3ae9 delete();
  }

  restart_quest(0);
}