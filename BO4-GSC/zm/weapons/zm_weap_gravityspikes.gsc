/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_gravityspikes.gsc
************************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai\zombie_vortex;
#include scripts\core_common\ai_shared;
#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\throttle_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_lightning_chain;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_gravityspikes;

autoexec __init__system__() {
  system::register(#"zm_weap_gravityspikes", &__init__, undefined, undefined);
}

__init__() {
  level.hero_weapon[#"gravityspikes"][0] = getweapon(#"hero_gravityspikes_t8_lv1");
  level.hero_weapon[#"gravityspikes"][1] = getweapon(#"hero_gravityspikes_t8_lv2");
  level.hero_weapon[#"gravityspikes"][2] = getweapon(#"hero_gravityspikes_t8_lv3");
  zm_loadout::register_hero_weapon_for_level(#"hero_gravityspikes_t8_lv1");
  zm_loadout::register_hero_weapon_for_level(#"hero_gravityspikes_t8_lv2");
  zm_loadout::register_hero_weapon_for_level(#"hero_gravityspikes_t8_lv3");
  callback::on_connect(&function_326aec56);
  callback::on_player_damage(&player_invulnerable_during_gravityspike_slam);
  level.n_zombies_lifted_for_ragdoll = 0;
  level.spikes_chop_cone_range = 120;
  level.spikes_chop_cone_range_sq = level.spikes_chop_cone_range * level.spikes_chop_cone_range;

  if(!isDefined(level.ai_gravity_throttle)) {
    level.ai_gravity_throttle = new throttle();
    [[level.ai_gravity_throttle]] - > initialize(2, 0.1);
  }

  zm_perks::register_lost_perk_override(&function_957545d8);
  callback::on_connect(&function_984185e0);
  callback::on_bleedout(&function_569653b);
  callback::on_revived(&function_569653b);
  scene::add_scene_func(#"p8_zm_gravityspikes_miniboss_trap_scene", &function_8d31d238, "init");
  register_clientfields();
}

register_clientfields() {
  clientfield::register("actor", "gravity_slam_down", 1, 1, "int");
  clientfield::register("scriptmover", "gravity_trap_fx", 1, 1, "int");
  clientfield::register("scriptmover", "gravity_trap_spike_spark", 1, 1, "int");
  clientfield::register("scriptmover", "gravity_trap_destroy", 1, 1, "counter");
  clientfield::register("scriptmover", "gravity_trap_location", 1, 1, "int");
  clientfield::register("scriptmover", "gravity_slam_fx", 1, 1, "int");
  clientfield::register("toplayer", "gravity_slam_player_fx", 1, 1, "counter");
  clientfield::register("actor", "sparky_beam_fx", 1, 1, "int");
  clientfield::register("actor", "sparky_zombie_fx", 1, 1, "int");
  clientfield::register("actor", "sparky_zombie_trail_fx", 1, 1, "int");
  clientfield::register("actor", "ragdoll_impact_watch", 1, 1, "int");
  clientfield::register("allplayers", "gravity_shock_wave_fx", 1, 1, "int");
  clientfield::register("toplayer", "hero_gravityspikes_vigor_postfx", 1, 1, "counter");
  clientfield::register("actor", "gravity_aoe_impact_fx", -1, 1, "int");
  clientfield::register("actor", "gravity_aoe_impact_tu6", 6000, 1, "counter");
}

function_4d17107b(weapon, var_e7c11b0c = 1) {
  if(weapon == level.hero_weapon[#"gravityspikes"][2]) {
    return true;
  }

  if(weapon == level.hero_weapon[#"gravityspikes"][1] && var_e7c11b0c < 3) {
    return true;
  }

  if(weapon == level.hero_weapon[#"gravityspikes"][0] && var_e7c11b0c < 2) {
    return true;
  }

  return false;
}

function_326aec56() {
  self endon(#"disconnect");
  self thread function_5a6c0fea();

  while(true) {
    waitresult = self waittill(#"weapon_change");
    wpn_cur = waitresult.weapon;
    wpn_prev = waitresult.last_weapon;

    if(isinarray(level.hero_weapon[#"gravityspikes"], wpn_cur)) {
      self clientfield::increment_to_player("hero_gravityspikes_vigor_postfx");
      self update_gravityspikes_state(1);
      self.b_gravity_trap_fx_on = 0;
      self.var_de01b5c2 = undefined;
      self thread gravityspikes_stuck_above_zombie_watcher();
    } else if(isinarray(level.hero_weapon[#"gravityspikes"], wpn_prev)) {
      self thread function_e0537f19(wpn_prev);
    }

    if(wpn_cur == level.hero_weapon[#"gravityspikes"][0]) {
      zm_hero_weapon::show_hint(wpn_cur, #"hash_2ed06d351658eadf");
      self thread gravityspikes_attack_watcher(wpn_cur, 1);
      continue;
    }

    if(wpn_cur == level.hero_weapon[#"gravityspikes"][1]) {
      if(!self gamepadusedlast()) {
        self zm_hero_weapon::show_hint(wpn_cur, #"hash_6b4f0b375a21c020");
      } else {
        self zm_hero_weapon::show_hint(wpn_cur, #"hash_1014fb82e4e32c24");
      }

      self thread gravityspikes_attack_watcher(wpn_cur, 2);
      self thread gravityspikes_altfire_watcher(wpn_cur);
      self thread function_478a4910(wpn_cur);
      continue;
    }

    if(wpn_cur == level.hero_weapon[#"gravityspikes"][2]) {
      if(!self gamepadusedlast()) {
        self zm_hero_weapon::show_hint(wpn_cur, #"hash_22403f43ff20f2db");
      } else {
        self zm_hero_weapon::show_hint(wpn_cur, #"hash_3b5dc0adfa400025");
      }

      self thread gravityspikes_attack_watcher(wpn_cur, 3);
      self thread gravityspikes_altfire_watcher(wpn_cur);
      self thread function_28be8532(wpn_cur);
    }
  }
}

private function_5a6c0fea() {
  self endon(#"disconnect");

  while(true) {
    waitresult = self waittill(#"hero_weapon_give");
    var_cad4df8e = waitresult.weapon;

    if(function_4d17107b(var_cad4df8e, 2)) {
      self clientfield::increment_to_player("hero_gravityspikes_vigor_postfx");
    }
  }
}

private function_e0537f19(w_gravityspikes) {
  self notify("3e6e1fb0a555c2a5");
  self endon("3e6e1fb0a555c2a5");
  self endon(#"disconnect");
  n_slot = self gadgetgetslot(w_gravityspikes);

  if(self function_36dfc05f(n_slot)) {
    for(var_966dad48 = self gadgetpowerget(n_slot); var_966dad48 > 0; var_966dad48 = self gadgetpowerget(n_slot)) {
      waitframe(1);
    }

    self ability_player::function_f2250880(w_gravityspikes);
    self.var_80612bea = 0;
  }

  self update_gravityspikes_state(0);
  self.b_gravity_trap_spikes_in_ground = undefined;
  self.b_gravity_trap_fx_on = undefined;
  self notify(#"gravity_spike_expired");

  if(self clientfield::get("gravity_shock_wave_fx")) {
    self clientfield::set("gravity_shock_wave_fx", 0);
  }
}

gravityspikes_attack_watcher(w_gravityspikes, n_level) {
  self endon(#"disconnect", #"bled_out", #"death", #"gravity_spike_expired");

  while(true) {
    if(n_level >= 3) {
      s_result = self waittill(#"weapon_melee_power");
    } else {
      s_result = self waittill(#"weapon_melee_power", #"weapon_melee");
    }

    if(s_result.weapon == w_gravityspikes) {
      self playrumbleonentity("talon_spike");
      self thread knockdown_zombies_slam(1);
      self thread no_damage_gravityspikes_slam();
    }
  }
}

private knockdown_zombies_slam(var_52b14308) {
  v_forward = anglesToForward(self getplayerangles());
  v_pos = self.origin + vectorscale(v_forward, 24);
  a_ai = getaiteamarray(level.zombie_team);
  a_ai = array::filter(a_ai, 0, &gravityspikes_target_filtering);
  a_ai_kill_zombies = arraysortclosest(a_ai, v_pos, a_ai.size, 0, 200);
  array::thread_all(a_ai_kill_zombies, &gravity_spike_melee_kill, v_pos, self, var_52b14308);
  a_ai_slam_zombies = arraysortclosest(a_ai, v_pos, a_ai.size, 200, 400);
  array::thread_all(a_ai_slam_zombies, &zombie_slam_direction, v_pos);
  self thread play_slam_fx(v_pos);
}

private play_slam_fx(v_pos) {
  mdl_fx_pos = util::spawn_model("tag_origin", v_pos, (-90, 0, 0));
  waitframe(1);
  mdl_fx_pos clientfield::set("gravity_slam_fx", 1);

  if(isDefined(self)) {
    self clientfield::increment_to_player("gravity_slam_player_fx");
  }

  waitframe(1);
  mdl_fx_pos delete();
}

private zombie_slam_direction(v_position) {
  self endon(#"death");

  if(!(self.archetype === #"zombie") || isDefined(self.knockdown) && self.knockdown) {
    return;
  }

  zombie_utility::setup_zombie_knockdown(v_position);
}

private player_invulnerable_during_gravityspike_slam(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  if(self.n_gravityspikes_state === 1 && isDefined(self.gravityspikes_slam) && self.gravityspikes_slam) {
    return 0;
  }

  return idamage;
}

private no_damage_gravityspikes_slam() {
  self endon(#"disconnect");
  self.gravityspikes_slam = 1;
  wait 1.5;
  self.gravityspikes_slam = undefined;
}

private gravityspikes_stuck_above_zombie_watcher() {
  self notify("3582bc9c4933ff9f");
  self endon("3582bc9c4933ff9f");
  self endon(#"disconnect", #"bled_out", #"death", #"gravity_spike_expired", #"hash_55b145e95edc2ebe");
  var_88758440 = 1;

  while(function_4d17107b(self getcurrentweapon())) {
    v_player_angles = self getplayerangles();
    forward_vec = anglesToForward((0, v_player_angles[1], 0));

    if(forward_vec[0] == 0 && forward_vec[1] == 0 && forward_vec[2] == 0) {
      waitframe(1);
      continue;
    }

    forward_right_45_vec = rotatepoint(forward_vec, (0, 45, 0));
    forward_left_45_vec = rotatepoint(forward_vec, (0, -45, 0));
    right_vec = anglestoright(v_player_angles);
    start_point = self.origin + (0, 0, 50);
    end_point = self.origin + (0, 0, -35);
    var_a024434f = [];

    if(var_88758440) {
      var_a024434f[0] = end_point + vectorscale(forward_vec, 30);
      var_a024434f[1] = end_point + vectorscale(right_vec, 30);
      var_a024434f[2] = end_point - vectorscale(right_vec, 30);
      var_88758440 = 0;
    } else {
      var_a024434f[0] = end_point + vectorscale(forward_right_45_vec, 30);
      var_a024434f[1] = end_point + vectorscale(forward_left_45_vec, 30);
      var_a024434f[2] = end_point - vectorscale(forward_vec, 30);
      var_88758440 = 1;
    }

    for(i = 0; i < 3; i++) {
      trace = bulletTrace(start_point, var_a024434f[i], 1, self);

      if(getdvarint(#"hash_5e15d0f6012693c5", 0) > 0) {
        line(start_point, var_a024434f[i], (1, 1, 1), 1, 0, 60);
        recordline(start_point, var_a024434f[i], (1, 1, 1), "<dev string:x38>", self);
      }

        if(trace[#"fraction"] < 1) {
          if(isactor(trace[#"entity"]) && trace[#"entity"].health > 0 && (trace[#"entity"].archetype == #"zombie" || trace[#"entity"].archetype == #"zombie_dog")) {
            self thread knockdown_zombies_slam();
            self thread no_damage_gravityspikes_slam();
            wait 1;
            break;
          }
        }
    }

    waitframe(1);
  }
}

gravityspikes_altfire_watcher(w_gravityspikes) {
  self endon(#"disconnect", #"bled_out", #"death", #"gravity_spike_expired", #"gravity_spike_planted");

  while(true) {
    s_result = self waittill(#"weapon_melee_power_left");

    if(s_result.weapon == w_gravityspikes && !(isDefined(self.var_de01b5c2) && self.var_de01b5c2)) {
      self.var_de01b5c2 = 1;
      self playrumbleonentity("damage_heavy");
      self thread function_26a4b7f5(w_gravityspikes);
      self waittilltimeout(5, #"stop_shockwave");
      self.var_de01b5c2 = undefined;
    }
  }
}

private function_26a4b7f5(w_gravityspikes) {
  self endon(#"disconnect", #"gravity_spike_expired", #"gravity_spike_planted");
  self clientfield::set("gravity_shock_wave_fx", 1);

  while(isDefined(self.var_de01b5c2) && self.var_de01b5c2) {
    v_forward = anglesToForward(self getplayerangles());
    v_pos = self.origin + vectorscale(v_forward, 24);
    var_b735005c = arraygetclosest(self.origin, getaiteamarray(level.zombie_team), 200);
    a_ai_zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 200);

    foreach(ai_zombie in a_ai_zombies) {
      if(isalive(ai_zombie) && (ai_zombie.zm_ai_category == #"basic" || ai_zombie.zm_ai_category == #"enhanced") && math::cointoss()) {
        ai_zombie thread zombie_utility::setup_zombie_knockdown(v_pos);
      }
    }

    if(!isDefined(var_b735005c)) {
      wait 0.2;
      continue;
    }

    if(var_b735005c.zm_ai_category == #"basic" || var_b735005c.zm_ai_category == #"popcorn" || var_b735005c.zm_ai_category == #"enhanced") {
      while(isalive(var_b735005c)) {
        var_b735005c thread function_6a21cc79(self, w_gravityspikes);
        wait 0.2;
      }

      continue;
    }

    var_b735005c thread function_6a21cc79(self, w_gravityspikes);
    wait 0.2;
  }

  self clientfield::set("gravity_shock_wave_fx", 0);
}

private function_6a21cc79(e_player, w_gravityspikes) {
  self endon(#"death");

  if(self.zm_ai_category == #"basic" || self.zm_ai_category == #"enhanced") {
    [[level.ai_gravity_throttle]] - > waitinqueue(self);
    n_damage = self.maxhealth * 0.25;
    self clientfield::increment("gravity_aoe_impact_tu6");

    if(n_damage >= self.health || distance2d(e_player.origin, self.origin) <= 50) {
      e_player thread electrocute_actor(self);
      return;
    } else {
      self dodamage(n_damage, self.origin, e_player, e_player, "torso_upper", "MOD_ELECTROCUTED", 0, w_gravityspikes);
    }

    return;
  }

  if(self.zm_ai_category == #"popcorn") {
    self clientfield::increment("gravity_aoe_impact_tu6");
    [[level.ai_gravity_throttle]] - > waitinqueue(self);
    self dodamage(self.health + 100, self.origin, e_player, e_player, "head", "MOD_ELECTROCUTED", 0, w_gravityspikes);
    return;
  }

  if(self.zm_ai_category == #"miniboss" || self.zm_ai_category == #"boss") {
    self clientfield::increment("gravity_aoe_impact_tu6");
    [[level.ai_gravity_throttle]] - > waitinqueue(self);
    self dodamage(self.maxhealth * 0.1, self.origin, e_player, e_player, "head", "MOD_ELECTROCUTED", 0, w_gravityspikes);
    return;
  }

  self clientfield::increment("gravity_aoe_impact_tu6");
  [[level.ai_gravity_throttle]] - > waitinqueue(self);
  self dodamage(self.maxhealth * 0.2, self.origin, e_player, e_player, "head", "MOD_ELECTROCUTED", 0, w_gravityspikes);
}

private electrocute_actor(ai_zombie) {
  self endon(#"disconnect");

  if(!isDefined(ai_zombie) || !isalive(ai_zombie)) {
    return;
  }

  bhtnactionstartevent(ai_zombie, "electrocute");
  ai_zombie notify(#"bhtn_action_notify", {
    #action: "electrocute"
  });

  if(!isDefined(self.tesla_enemies_hit)) {
    self.tesla_enemies_hit = 1;
  }

  lightning_params = lightning_chain::create_lightning_chain_params(5);
  lightning_params.head_gib_chance = 100;
  lightning_params.network_death_choke = 4;
  lightning_params.should_kill_enemies = 0;
  ai_zombie.tesla_death = 0;
  self thread arc_damage_init(ai_zombie, lightning_params);
  ai_zombie thread tesla_death(self);
}

private arc_damage_init(ai_zombie, params) {
  self endon(#"disconnect");

  if(ai_zombie ai::is_stunned()) {
    return;
  }

  ai_zombie lightning_chain::arc_damage_ent(self, 1, params);
}

private tesla_death(e_player) {
  self endon(#"death");

  if(isDefined(level.no_gib_in_wolf_area) && isDefined(self[[level.no_gib_in_wolf_area]]()) && self[[level.no_gib_in_wolf_area]]()) {
    self.no_gib = 1;
  }

  if(!(isDefined(self.no_gib) && self.no_gib)) {
    self thread function_cc9e1996();
  }

  wait 2;
  [[level.ai_gravity_throttle]] - > waitinqueue(self);

  if(isDefined(self)) {
    if(isDefined(e_player)) {
      self dodamage(self.health + 100, self.origin, e_player, e_player, "torso_upper", "MOD_ELECTROCUTED");
      return;
    }

    self dodamage(self.health + 100, self.origin, undefined, undefined, "torso_upper", "MOD_ELECTROCUTED");
  }
}

private function_cc9e1996() {
  self notify("3e6df5bd8abc99d1");
  self endon("3e6df5bd8abc99d1");
  self waittill(#"death");

  if(isDefined(self) && isactor(self)) {
    self playSound(#"zmb_zombie_head_gib");

    if(randomint(100) < 50) {
      gibserverutils::gibhead(self);
    }

    if(randomint(100) < 50) {
      gibserverutils::gibleftarm(self);
    }

    if(randomint(100) < 50) {
      gibserverutils::gibrightarm(self);
    }

    if(randomint(100) < 50) {
      gibserverutils::giblegs(self);
    }
  }
}

function_28be8532(w_gravityspikes) {
  self endon(#"disconnect", #"bled_out", #"death", #"gravity_spike_expired", #"hash_55b145e95edc2ebe");

  while(true) {
    s_result = self waittill(#"weapon_melee");

    if(s_result.weapon === w_gravityspikes && isDefined(self gravity_spike_position_valid()) && self gravity_spike_position_valid()) {
      if(isDefined(self.var_de01b5c2) && self.var_de01b5c2) {
        self notify(#"stop_shockwave");
        self.var_de01b5c2 = undefined;
      }

      self thread plant_gravity_trap(w_gravityspikes);
      continue;
    }

    self playSound(#"zmb_trap_deny");
    wait 1;
    continue;
  }
}

private gravity_spike_position_valid() {
  if(!ispointonnavmesh(self.origin, self)) {
    return 0;
  }

  if(isDefined(level.gravityspike_position_check)) {
    return self[[level.gravityspike_position_check]]();
  }

  return 1;
}

private player_near_gravity_vortex() {
  self endon(#"disconnect", #"bled_out", #"death", #"gravity_spike_expired");

  while(isDefined(self.b_gravity_trap_spikes_in_ground) && self.b_gravity_trap_spikes_in_ground && self.n_gravityspikes_state === 1 && isDefined(self.mdl_gravity_trap_fx_source)) {
    foreach(e_player in level.players) {
      if(zm_utility::is_player_valid(e_player) && !(isDefined(e_player.idgun_vision_on) && e_player.idgun_vision_on)) {
        if(distance(e_player.origin, self.mdl_gravity_trap_fx_source.origin) < float(64)) {
          e_player thread zombie_vortex::player_vortex_visionset("zm_idgun_vortex");
        }
      }

      if(distance(e_player.origin, self.mdl_gravity_trap_fx_source.origin) < 128) {
        e_player.var_fed415aa = 1;
      } else {
        e_player.var_fed415aa = undefined;
      }

      if(e_player laststand::player_is_in_laststand() && distance(e_player.origin, self.mdl_gravity_trap_fx_source.origin) < 128) {
        self thread function_23494ff7(e_player);
        continue;
      }

      if(isDefined(e_player.var_4fc8bf2a) && e_player.var_4fc8bf2a) {
        e_player thread function_569653b();
      }
    }

    waitframe(1);
  }
}

function_984185e0() {
  self thread function_fa0a1b19();
}

function_fa0a1b19() {
  if(!isDefined(self.var_f9c533d9)) {
    self.var_f9c533d9 = [];
  }

  s_revive_override = self zm_laststand::register_revive_override(&function_d5c9a81);

  if(!isDefined(self.var_f9c533d9)) {
    self.var_f9c533d9 = [];
  } else if(!isarray(self.var_f9c533d9)) {
    self.var_f9c533d9 = array(self.var_f9c533d9);
  }

  self.var_f9c533d9[self.var_f9c533d9.size] = s_revive_override;
}

private function_23494ff7(e_revivee) {
  if(!(isDefined(e_revivee.var_4fc8bf2a) && e_revivee.var_4fc8bf2a)) {
    if(self !== e_revivee) {
      e_revivee.var_ec334996 += 100;
    }

    e_revivee.get_revive_time = &override_revive_time;
    e_revivee.var_84280a99 = self;
    e_revivee.var_4fc8bf2a = 1;
    self thread function_9c510b18(e_revivee);
  }
}

private function_9c510b18(e_revivee) {
  e_revivee endon(#"disconnect", #"death", #"bledout", #"stop_revive_trigger");
  self waittill(#"disconnect", #"gravity_spike_expired");
  e_revivee thread function_569653b();
}

override_revive_time(e_revivee) {
  n_time = 3;

  if(self hasperk(#"specialty_quickrevive")) {
    n_time /= 4;
  } else {
    n_time /= 2;
  }

  return n_time;
}

function_569653b(s_params) {
  if(self != level) {
    if(isDefined(s_params)) {
      e_revivee = s_params.e_revivee;
    } else {
      e_revivee = self;
    }

    e_revivee.get_revive_time = undefined;
    e_revivee.var_84280a99 = undefined;
    e_revivee.var_4fc8bf2a = undefined;
  }
}

function_d5c9a81(e_revivee) {
  if(!isDefined(e_revivee.revivetrigger)) {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  if(self laststand::player_is_in_laststand() && !isDefined(self.var_6d772cb)) {
    return false;
  }

  if(self.team != e_revivee.team) {
    return false;
  }

  if(isDefined(self.is_zombie) && self.is_zombie) {
    return false;
  }

  if(isDefined(level.can_revive_use_depthinwater_test) && level.can_revive_use_depthinwater_test && e_revivee depthinwater() > 10) {
    return true;
  }

  if(isDefined(level.can_revive) && ![[level.can_revive]](e_revivee)) {
    return false;
  }

  if(isDefined(level.var_1461fd14) && ![[level.var_1461fd14]](e_revivee)) {
    return false;
  }

  if(e_revivee zm_player::in_kill_brush() || !e_revivee zm_player::in_enabled_playable_area()) {
    return false;
  }

  if(isDefined(e_revivee.var_4fc8bf2a) && e_revivee.var_4fc8bf2a) {
    return true;
  }

  return false;
}

function_957545d8(perk) {
  self thread zm_perks::function_b2dfd295(perk, &function_1049648d);
  return false;
}

function_1049648d(e_reviver, var_84280a99) {
  return isDefined(self.var_fed415aa) && self.var_fed415aa;
}

plant_gravity_trap(w_gravityspikes) {
  self endoncallback(&function_c9830e97, #"bled_out", #"death");
  self notify(#"hash_55b145e95edc2ebe");
  self thread zm_hero_weapon::function_4e984e83(w_gravityspikes, 0.35);
  self.var_80612bea = 1;
  self thread zm_audio::create_and_play_dialog(#"hero_level_3", #"gravityspikes");
  v_forward = anglesToForward(self.angles);
  v_right = anglestoright(self.angles);
  v_spawn_pos_right = self.origin + (0, 0, 32);
  v_spawn_pos_left = v_spawn_pos_right;
  a_trace = physicstraceex(v_spawn_pos_right, v_spawn_pos_right + v_right * 24, (-16, -16, -16), (16, 16, 16), self);
  v_spawn_pos_right += v_right * a_trace[#"fraction"] * 24;
  a_trace = physicstraceex(v_spawn_pos_left, v_spawn_pos_left + v_right * -24, (-16, -16, -16), (16, 16, 16), self);
  v_spawn_pos_left += v_right * a_trace[#"fraction"] * -24;
  var_f4daeb3f = util::function_97cf7eb0(v_spawn_pos_right, 1000, 24);
  var_d7061a0d = util::function_97cf7eb0(v_spawn_pos_left, 1000, 24);
  a_s_spawn_pos = array(var_f4daeb3f, var_d7061a0d);
  self create_gravity_trap_spikes_in_ground(a_s_spawn_pos);

  if(self isonground()) {
    var_aa0fedb0 = {
      #position: self.origin + (0, 0, 32), 
      #entity: self getgroundent()
    };
  } else {
    var_aa0fedb0 = util::function_97cf7eb0(self.origin, 1000, length((0, 0, 32)));
  }

  self gravity_trap_fx_on(var_aa0fedb0);
  self.b_gravity_trap_spikes_in_ground = 1;
  self thread player_near_gravity_vortex();
  self thread destroy_gravity_trap_spikes_in_ground();
  self thread gravity_trap_loop(w_gravityspikes);
  zm_utility::function_3e549e65();
  self waittill(#"gravity_spike_expired");
  zm_utility::function_b7e5029f();

  if(isDefined(self)) {
    self.b_gravity_trap_spikes_in_ground = undefined;
    self notify(#"destroy_ground_spikes");
  }

  foreach(e_player in level.players) {
    e_player.var_fed415aa = undefined;
  }
}

function_c9830e97(var_c34665fc) {
  if(isDefined(self.b_gravity_trap_spikes_in_ground) && self.b_gravity_trap_spikes_in_ground) {
    zm_utility::function_b7e5029f();
  }
}

private gravity_trap_loop(w_gravityspikes) {
  self endon(#"disconnect", #"bled_out", #"death");
  is_gravity_trap_fx_on = 1;

  while(true) {
    if(self gadgetpowerget(self gadgetgetslot(w_gravityspikes)) > 0) {
      a_zombies = getaiteamarray(level.zombie_team);
      a_zombies = array::filter(a_zombies, 0, &gravityspikes_target_filtering);
      array::thread_all(a_zombies, &gravity_trap_check, self);
    } else if(is_gravity_trap_fx_on) {
      self gravity_trap_fx_off();
      is_gravity_trap_fx_on = 0;
      return;
    }

    if(!(isDefined(self.b_gravity_trap_spikes_in_ground) && self.b_gravity_trap_spikes_in_ground)) {
      return;
    }

    wait 0.1;
  }
}

private gravity_trap_check(player) {
  player endon(#"disconnect", #"bled_out", #"death");
  assert(isDefined(level.ai_gravity_throttle));
  assert(isDefined(player));

  if(!isDefined(player.mdl_gravity_trap_fx_source)) {
    return;
  }

  n_gravity_trap_radius_sq = 16384;
  v_gravity_trap_origin = player.mdl_gravity_trap_fx_source.origin;

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(self check_for_range_and_los(v_gravity_trap_origin, 96, n_gravity_trap_radius_sq)) {
    if(self.in_gravity_trap === 1 || !self.allowdeath) {
      return;
    }

    self.in_gravity_trap = 1;
    [[level.ai_gravity_throttle]] - > waitinqueue(self);

    if(isDefined(self) && isalive(self)) {
      self zombie_lift(player, v_gravity_trap_origin, 0, randomintrange(184, 284), (0, 0, -24), randomintrange(64, 128));
    }
  }
}

private create_gravity_trap_spikes_in_ground(a_s_spawn_pos) {
  if(!isDefined(self.mdl_gravity_trap_spikes)) {
    self.mdl_gravity_trap_spikes = [];
  }

  for(i = 0; i < a_s_spawn_pos.size; i++) {
    if(!isDefined(self.mdl_gravity_trap_spikes[i])) {
      self.mdl_gravity_trap_spikes[i] = util::spawn_model("wpn_t8_zm_talon_spikes_world", a_s_spawn_pos[i].position);
    }

    self.mdl_gravity_trap_spikes[i].origin = a_s_spawn_pos[i].position;
    self.mdl_gravity_trap_spikes[i].angles = self.angles;
    self.mdl_gravity_trap_spikes[i] show();

    if(isDefined(a_s_spawn_pos[i].entity) && isvehicle(a_s_spawn_pos[i].entity) && a_s_spawn_pos[i].entity ismovingplatform()) {
      self.mdl_gravity_trap_spikes[i] linkto(a_s_spawn_pos[i].entity);
    }

    waitframe(1);
    self.mdl_gravity_trap_spikes[i] thread gravity_spike_planted_play();
    self.mdl_gravity_trap_spikes[i] clientfield::set("gravity_trap_spike_spark", 1);

    if(isDefined(level.symbols_quest_comp)) {
      [
        [level.symbols_quest_comp]
      ](self.mdl_gravity_trap_spikes[i]);
    }
  }
}

private gravity_spike_planted_play() {
  self endon(#"death");
  wait 2;
  self useanimtree("generic");
  self animation::play(#"o_spikes_stand_plant", self, undefined, 1, 0, 0, 0, 0, 0, 0, undefined, undefined);
}

private destroy_gravity_trap_spikes_in_ground() {
  mdl_spike_source = self.mdl_gravity_trap_fx_source;
  mdl_gravity_trap_spikes = self.mdl_gravity_trap_spikes;
  self.var_6d772cb = mdl_spike_source;
  self waittill(#"destroy_ground_spikes", #"disconnect", #"bled_out");
  self.var_6d772cb = undefined;

  if(isDefined(mdl_spike_source)) {
    mdl_spike_source playSound(#"hash_5d0917b44402f070");
    mdl_spike_source clientfield::set("gravity_trap_location", 0);
    mdl_spike_source delete();
  }

  if(!isDefined(mdl_gravity_trap_spikes)) {
    return;
  }

  for(i = 0; i < mdl_gravity_trap_spikes.size; i++) {
    if(isDefined(mdl_gravity_trap_spikes[i])) {
      mdl_gravity_trap_spikes[i] scene::stop(#"cin_zm_dlc1_spike_plant_loop");
      mdl_gravity_trap_spikes[i] clientfield::set("gravity_trap_spike_spark", 0);
      mdl_gravity_trap_spikes[i] delete();
    }
  }
}

private gravity_trap_fx_on(s_spawn_pos) {
  self endoncallback(&function_f1c63c4c, #"disconnect");

  if(!isDefined(self.mdl_gravity_trap_fx_source)) {
    self.mdl_gravity_trap_fx_source = util::spawn_model("tag_origin", s_spawn_pos.position);
  }

  self.mdl_gravity_trap_fx_source.origin = s_spawn_pos.position;
  self.mdl_gravity_trap_fx_source show();
  self.mdl_gravity_trap_fx_source unlink();

  if(isDefined(s_spawn_pos.entity) && isvehicle(s_spawn_pos.entity) && s_spawn_pos.entity ismovingplatform()) {
    self.mdl_gravity_trap_fx_source linkto(s_spawn_pos.entity);
  }

  waitframe(1);
  self.mdl_gravity_trap_fx_source clientfield::set("gravity_trap_fx", 1);
}

function_f1c63c4c(str_notify) {
  if(isDefined(self.mdl_gravity_trap_fx_source)) {
    self.mdl_gravity_trap_fx_source delete();
  }
}

private gravity_trap_fx_off() {
  if(!isDefined(self.mdl_gravity_trap_fx_source)) {
    return;
  }

  self.mdl_gravity_trap_fx_source unlink();
  self.mdl_gravity_trap_fx_source clientfield::set("gravity_trap_fx", 0);
  self.mdl_gravity_trap_fx_source clientfield::set("gravity_trap_location", 1);
}

update_gravityspikes_state(n_gravityspikes_state) {
  self.n_gravityspikes_state = n_gravityspikes_state;
}

private check_for_range_and_los(v_attack_source, n_allowed_z_diff, n_radius_sq) {
  if(isalive(self)) {
    n_z_diff = self.origin[2] - v_attack_source[2];

    if(abs(n_z_diff) < n_allowed_z_diff) {
      if(distance2dsquared(self.origin, v_attack_source) < n_radius_sq) {
        v_offset = (0, 0, 50);

        if(bullettracepassed(self.origin + v_offset, v_attack_source + v_offset, 0, self)) {
          return true;
        }
      }
    }
  }

  return false;
}

private gravityspikes_target_filtering(ai_enemy) {
  b_callback_result = 1;

  if(isDefined(level.var_722474af)) {
    b_callback_result = [[level.var_722474af]](ai_enemy);
  }

  return b_callback_result;
}

private zombie_lift(player, v_attack_source, n_push_away, n_lift_height, v_lift_offset, n_lift_speed) {
  self endon(#"death");
  w_gravityspikes = player.var_fd05e363;

  if(isDefined(self.zombie_lift_override)) {
    self thread[[self.zombie_lift_override]](player, v_attack_source, n_push_away, n_lift_height, v_lift_offset, n_lift_speed);
    return;
  }

  if(!isDefined(self) || !isDefined(self.zm_ai_category)) {
    return;
  }

  if(self.zm_ai_category === #"popcorn") {
    [[level.ai_gravity_throttle]] - > waitinqueue(self);
    self.no_powerups = 1;
    self dodamage(self.health + 100, self.origin, player, player, "head", "MOD_ELECTROCUTED", 0, w_gravityspikes);
    self playSound("wpn_dg4_electrocution_impact");
    return;
  }

  if(self.zm_ai_category === #"miniboss") {
    [[level.ai_gravity_throttle]] - > waitinqueue(self);

    if(isalive(self) && isDefined(self.b_melee_kill) && self.b_melee_kill && !(isDefined(self.var_5bf7575e) && self.var_5bf7575e) && !(isDefined(player.b_gravity_trap_spikes_in_ground) && player.b_gravity_trap_spikes_in_ground)) {
      self dodamage(self.maxhealth * 0.1, self.origin, player, player, "head", "MOD_ELECTROCUTED", 0, w_gravityspikes);
      self.var_5bf7575e = 1;
      self.b_melee_kill = undefined;
      self ai::stun();
      wait 1;
      self.var_5bf7575e = undefined;
      self ai::clear_stun();
    } else if(isalive(self) && !(isDefined(self.var_42d5176d) && self.var_42d5176d) && isDefined(player.b_gravity_trap_spikes_in_ground) && player.b_gravity_trap_spikes_in_ground) {
      [
        [level.ai_gravity_throttle]
      ] - > waitinqueue(self);
      self dodamage(self.maxhealth * 0.1, self.origin, player, player, "torso_upper", "MOD_ELECTROCUTED", 0, w_gravityspikes);
      self thread track_lifted_for_ragdoll_count();
      self.var_42d5176d = 1;
      self val::set(#"trap_ignore", "ignoreall", 1);
      v_pos = groundtrace(self.origin + (0, 0, 100), self.origin + (0, 0, -1000), 0, self)[#"position"];

      if(!isDefined(v_pos)) {
        v_pos = self.origin;
      }

      self.var_68f4c9de = util::spawn_model("tag_origin", v_pos, self.angles);
      self.var_68f4c9de thread scene::init(#"p8_zm_gravityspikes_miniboss_trap_scene", self);
      self clientfield::set("sparky_beam_fx", 1);
      self clientfield::set("sparky_zombie_fx", 1);
      self thread gravity_trap_notify_watcher(player);
      self waittill(#"gravity_trap_complete");

      if(isDefined(self)) {
        self val::reset(#"trap_ignore", "ignoreall");
        self clientfield::set("sparky_beam_fx", 0);
        self clientfield::set("sparky_zombie_fx", 0);
        self clientfield::set("sparky_zombie_trail_fx", 1);

        if(isDefined(self.var_68f4c9de)) {
          self.var_68f4c9de scene::play(#"p8_zm_gravityspikes_miniboss_trap_scene", self);
        }

        if(isDefined(self)) {
          self.in_gravity_trap = undefined;
          self.var_42d5176d = undefined;

          if(isDefined(self.var_68f4c9de)) {
            self.var_68f4c9de delete();
          }
        }
      }
    }

    return;
  }

  if(self.zm_ai_category === #"boss") {
    if(isalive(self) && isDefined(self.b_melee_kill) && self.b_melee_kill && !(isDefined(self.var_5bf7575e) && self.var_5bf7575e) && !(isDefined(player.b_gravity_trap_spikes_in_ground) && player.b_gravity_trap_spikes_in_ground)) {
      [
        [level.ai_gravity_throttle]
      ] - > waitinqueue(self);
      self dodamage(self.maxhealth * 0.05, self.origin, player, player, "head", "MOD_ELECTROCUTED", 0, w_gravityspikes);
      self.var_5bf7575e = 1;
      self.b_melee_kill = undefined;
      wait 1;
      self.var_5bf7575e = undefined;
    } else if(isalive(self) && !(isDefined(self.var_42d5176d) && self.var_42d5176d) && isDefined(player.b_gravity_trap_spikes_in_ground) && player.b_gravity_trap_spikes_in_ground) {
      [
        [level.ai_gravity_throttle]
      ] - > waitinqueue(self);
      self dodamage(self.maxhealth * 0.05, self.origin, player, player, "head", "MOD_ELECTROCUTED", 0, w_gravityspikes);
      self.var_42d5176d = 1;
      self waittill(#"death", #"gravity_trap_complete");
      self.var_42d5176d = undefined;
      self.in_gravity_trap = undefined;
    }

    return;
  }

  if(isDefined(level.no_gib_in_wolf_area) && isDefined(self[[level.no_gib_in_wolf_area]]()) && self[[level.no_gib_in_wolf_area]]()) {
    self.ignore_gravityspikes_ragdoll = 1;
  }

  if(level.n_zombies_lifted_for_ragdoll < 8 && !(isDefined(self.ignore_gravityspikes_ragdoll) && self.ignore_gravityspikes_ragdoll)) {
    self thread track_lifted_for_ragdoll_count();
    v_centroid = self getcentroid();
    v_away_from_source = vectornormalize(v_centroid - v_attack_source);
    v_away_from_source *= n_push_away;
    v_away_from_source = (v_away_from_source[0], v_away_from_source[1], n_lift_height);
    a_trace = physicstraceex(v_centroid + (0, 0, 32), v_centroid + v_away_from_source, (-16, -16, -16), (16, 16, 16), self);
    v_lift = a_trace[#"fraction"] * v_away_from_source;
    v_lift += v_lift_offset;

    if(!(isDefined(bullettracepassed(v_centroid, v_centroid + v_lift, 0, self)) && bullettracepassed(v_centroid, v_centroid + v_lift, 0, self))) {
      v_trace_pos = bulletTrace(v_centroid, v_centroid + v_lift, 0, self)[#"position"];

      if(isDefined(v_trace_pos)) {
        v_lift = v_trace_pos + v_lift_offset;
      }
    }

    n_lift_time = length(v_lift) / n_lift_speed;

    if(isDefined(self) && isDefined(self.b_melee_kill) && self.b_melee_kill) {
      self setplayercollision(0);

      if(!(isDefined(level.ignore_gravityspikes_ragdoll) && level.ignore_gravityspikes_ragdoll)) {
        self startragdoll();
        self launchragdoll(150 * anglestoup(self.angles) + (v_away_from_source[0], v_away_from_source[1], 0));
      }

      self clientfield::set("ragdoll_impact_watch", 1);
      self clientfield::set("sparky_zombie_trail_fx", 1);
      waitframe(1);
    } else if(isDefined(self) && v_lift[2] > 0) {
      self setplayercollision(0);
      self clientfield::set("sparky_beam_fx", 1);
      self clientfield::set("sparky_zombie_fx", 1);
      self playSound("zmb_talon_electrocute");

      if(isDefined(self.missinglegs) && self.missinglegs) {
        self thread scene::play(#"cin_zm_dlc1_zombie_crawler_talonspike_a_loop", self);
      } else {
        self thread scene::play(#"cin_zm_dlc1_zombie_talonspike_loop", self);
      }

      self.mdl_trap_mover = util::spawn_model("tag_origin", v_centroid, self.angles);
      self thread util::delete_on_death(self.mdl_trap_mover);
      self linkto(self.mdl_trap_mover);
      self.mdl_trap_mover moveto(v_centroid + v_lift, n_lift_time, 0, n_lift_time * 0.4);
      self thread zombie_lift_wacky_rotate(n_lift_time, player);
      self thread gravity_trap_notify_watcher(player);
      self waittill(#"gravity_trap_complete");

      if(isDefined(self)) {
        self unlink();
        self scene::stop();
        self startragdoll(1);
        self clientfield::set("gravity_slam_down", 1);
        self clientfield::set("sparky_beam_fx", 0);
        self clientfield::set("sparky_zombie_fx", 0);
        self clientfield::set("sparky_zombie_trail_fx", 1);
        self clientfield::set("ragdoll_impact_watch", 1);
        v_land_pos = util::ground_position(self.origin, 1000);
        n_fall_dist = abs(self.origin[2] - v_land_pos[2]);
        n_slam_wait = n_fall_dist / 200 * 0.75;
        self thread corpse_off_navmesh_watcher(n_slam_wait);

        if(n_slam_wait > 0) {
          wait n_slam_wait;
        }
      }
    }

    if(isalive(self)) {
      self zombie_kill_and_gib(player);
    }

    if(isalive(self)) {
      self playSound("zmb_talon_ai_slam");
    }

    return;
  }

  self zombie_kill_and_gib(player);

  if(isalive(self)) {
    self playSound("zmb_talon_ai_slam");
  }
}

function_8d31d238(a_ents) {
  self waittill(#"scene_done");

  if(isDefined(self)) {
    self delete();
  }
}

private gravity_trap_notify_watcher(player) {
  self endon(#"gravity_trap_complete");

  if(isDefined(self.mdl_trap_mover)) {
    self thread gravity_trap_timeout_watcher();
  }

  util::waittill_any_ents(self, "death", player, #"gravity_spike_expired", player, "disconnect", player, "bled_out");
  self notify(#"gravity_trap_complete");
}

private gravity_trap_timeout_watcher() {
  self endon(#"gravity_trap_complete");
  self.mdl_trap_mover waittilltimeout(4, #"movedone");

  if(isalive(self) && !(isDefined(self.b_melee_kill) && self.b_melee_kill)) {
    wait randomfloatrange(0.2, 1);
  }

  self notify(#"gravity_trap_complete");
}

private zombie_lift_wacky_rotate(n_lift_time, player) {
  player endon(#"gravity_spike_expired");
  self endon(#"death");

  while(true) {
    negative_x = randomintrange(0, 10) > 5 ? -1 : 1;
    negative_z = randomintrange(0, 10) > 5 ? -1 : 1;
    self.mdl_trap_mover rotateto((randomintrange(90, 180) * negative_x, randomintrange(-90, 90), randomintrange(90, 180) * negative_z), n_lift_time < 2 ? 5 : n_lift_time, 0);
    self.mdl_trap_mover waittill(#"rotatedone");
  }
}

private zombie_kill_and_gib(player) {
  self endon(#"death");

  if(isDefined(player) && isDefined(player.var_fd05e363)) {
    w_gravityspikes = player.var_fd05e363;
  } else {
    w_gravityspikes = undefined;
  }

  [[level.ai_gravity_throttle]] - > waitinqueue(self);

  if(isDefined(level.no_gib_in_wolf_area) && isDefined(self[[level.no_gib_in_wolf_area]]()) && self[[level.no_gib_in_wolf_area]]()) {
    self.no_gib = 1;
  }

  self.no_powerups = 1;
  self dodamage(self.health + 100, self.origin, player, player, "torso_upper", "MOD_ELECTROCUTED", 0, w_gravityspikes);
  waitframe(1);

  if(!(isDefined(self.no_gib) && self.no_gib)) {
    n_random = randomint(100);

    if(n_random >= 20) {
      self playSound(#"zmb_zombie_head_gib");
      self zombie_utility::gib_random_parts();
    }
  }
}

private track_lifted_for_ragdoll_count() {
  level.n_zombies_lifted_for_ragdoll++;
  self waittill(#"death", #"gravity_trap_complete");
  level.n_zombies_lifted_for_ragdoll--;
}

private corpse_off_navmesh_watcher(n_timeout) {
  self.b_ignore_cleanup = 1;

  if(self.zm_ai_category !== #"basic" && self.zm_ai_category !== #"enhanced") {
    return;
  }

  s_result = self waittilltimeout(n_timeout, #"actor_corpse", #"deleted");

  if(s_result._notify == "actor_corpse") {
    v_pos = getclosestpointonnavmesh(s_result.corpse.origin, 256);

    if(!isDefined(v_pos) || s_result.corpse.origin[2] > v_pos[2] + 64) {
      s_result.corpse thread do_zombie_explode();
    }

    return;
  }

  if(isDefined(self)) {
    self thread do_zombie_explode();
  }
}

private do_zombie_explode() {
  waitframe(1);

  if(isDefined(self)) {
    if(self.animname === "zombie_eaten") {
      return;
    }

    if(isDefined(level.no_gib_in_wolf_area) && isDefined(self[[level.no_gib_in_wolf_area]]()) && self[[level.no_gib_in_wolf_area]]()) {
      self.no_gib = 1;
    }

    if(!(isDefined(self.no_gib) && self.no_gib)) {
      self playSound(#"zmb_zombie_head_gib");
      gibserverutils::annihilate(self);
    }
  }
}

private gravity_spike_melee_kill(v_position, player, var_52b14308) {
  self.b_melee_kill = 1;
  self.var_46d39f48 = var_52b14308;

  if(self check_for_range_and_los(v_position, 96, 40000)) {
    self zombie_lift(player, v_position, 128, randomintrange(128, 200), (0, 0, 0), randomintrange(150, 200));
  }
}

function_478a4910(w_gravityspikes) {
  self endon(#"disconnect", #"bled_out", #"death", #"gravity_spike_expired", #"gravity_spike_planted");
  s_result = self waittill(#"weapon_melee_power_left");

  if(s_result.weapon == w_gravityspikes) {
    self thread zm_audio::create_and_play_dialog(#"hero_level_2", #"gravityspikes");
  }
}