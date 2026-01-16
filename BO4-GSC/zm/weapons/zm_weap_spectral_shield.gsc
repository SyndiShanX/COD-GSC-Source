/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_spectral_shield.gsc
**************************************************/

#include script_24c32478acf44108;
#include script_6951ea86fdae9ae0;
#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\throttle_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\weapons\zm_weap_riotshield;
#include scripts\zm_common\trials\zm_trial_restrict_loadout;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_crafting;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_spectral_shield;

autoexec __init__system__() {
  system::register(#"zm_weap_spectral_shield", &__init__, &__main__, undefined);
}

__init__() {
  level.var_4e845c84 = getweapon(#"zhield_spectral_turret");
  level.var_d7e67022 = getweapon(#"zhield_spectral_dw");
  level.var_58e17ce3 = getweapon(#"zhield_spectral_turret_upgraded");
  level.var_637136f3 = getweapon(#"zhield_spectral_dw_upgraded");
  level.var_70f7eb75 = level.var_637136f3;
  level.var_ecfcf864 = &function_4173ee30;
  level.var_1177ae05 = &function_401e4768;
  level.riotshield_melee_power = &melee_power;
  level.var_fe5b96fb = &zombie_knockdown;
  level.var_a6a70655 = [];
  level.var_a6a70655[level.var_a6a70655.size] = "guts";
  level.var_a6a70655[level.var_a6a70655.size] = "right_arm";
  level.var_a6a70655[level.var_a6a70655.size] = "left_arm";

  if(zm_utility::is_ee_enabled()) {
    level.var_f7d93c4e = &function_df8ce6e2;
    level.var_932a1afb = &function_9693e041;
  }

  level.var_c7626f2a = [];
  clientfield::register("allplayers", "" + #"afterlife_vision_play", 1, 1, "int");
  clientfield::register("toplayer", "" + #"afterlife_window", 1, 1, "int");
  clientfield::register("scriptmover", "" + #"afterlife_entity_visibility", 1, 2, "int");
  clientfield::register("allplayers", "" + #"spectral_key_beam_fire", 1, 1, "int");
  clientfield::register("allplayers", "" + #"spectral_key_beam_flash", 1, 2, "int");
  n_bits = getminbitcountfornum(4);
  clientfield::register("actor", "" + #"zombie_spectral_key_stun", 1, n_bits, "int");
  clientfield::register("vehicle", "" + #"zombie_spectral_key_stun", 1, n_bits, "int");
  clientfield::register("scriptmover", "" + #"zombie_spectral_key_stun", 1, n_bits, "int");
  clientfield::register("scriptmover", "" + #"spectral_key_essence", 1, 1, "int");
  clientfield::register("allplayers", "" + #"hash_7663ae2eb866d2eb", 1, 1, "counter");
  clientfield::register("allplayers", "" + #"spectral_key_charging", 1, 2, "int");
  clientfield::register("allplayers", "" + #"spectral_shield_blast", 1, 1, "counter");
  clientfield::register("scriptmover", "" + #"shield_crafting_fx", 1, 1, "counter");
  clientfield::register("actor", "" + #"spectral_blast_death", 1, 1, "int");
  clientfield::register("allplayers", "" + #"zombie_spectral_heal", 1, 1, "counter");
  namespace_9ff9f642::register_slowdown(#"hash_119644e9a557f4e9", 0.5, 1);
  callback::on_ai_killed(&function_90a37da4);
  callback::on_connect(&function_70072647);
  zm::function_84d343d(#"zhield_spectral_turret", &function_a8b4c2a7);
  zm::function_84d343d(#"zhield_spectral_dw", &function_a8b4c2a7);
  zm::function_84d343d(#"zhield_spectral_turret_upgraded", &function_a8b4c2a7);
  zm::function_84d343d(#"zhield_spectral_dw_upgraded", &function_a8b4c2a7);

  if(!isDefined(level.var_dbfca4ee)) {
    level.var_dbfca4ee = new throttle();
    [[level.var_dbfca4ee]] - > initialize(6, 0.1);
  }

  level thread function_3a6ee2ea();

}

__main__() {
  level thread function_b84d0267();
}

function_70072647() {
  self.var_9fd623ed = 0;
  self callback::function_33f0ddd3(&function_33f0ddd3);
}

function_98890cd8(w_current) {
  if(w_current === level.var_d7e67022 || w_current === level.var_637136f3) {
    return true;
  }

  if(w_current === level.var_4e845c84 || w_current === level.var_58e17ce3) {
    return true;
  }

  return false;
}

private function_33f0ddd3(eventstruct) {
  if(eventstruct.weapon === level.var_d7e67022 || eventstruct.weapon === level.var_637136f3) {
    if(eventstruct.event === "give_weapon") {
      if(eventstruct.weapon === level.var_d7e67022) {
        self.var_9fd623ed = 0;
      }

      if(eventstruct.weapon === level.var_d7e67022 && self hasweapon(level.var_4e845c84)) {
        self setweaponammoclip(level.var_4e845c84, 0);
        self.var_f7c822b5 = 2;
      } else if(self hasweapon(level.var_58e17ce3)) {
        self.var_5ba94c1e = 1;
        self setweaponammoclip(level.var_58e17ce3, 0);
        self.var_f7c822b5 = 4;
      }

      self thread function_5f950378();
      return;
    }

    if(eventstruct.event === "take_weapon") {
      if(eventstruct.weapon === level.var_637136f3) {
        self.var_9fd623ed = 0;
      }

      if(function_98890cd8(eventstruct.weapon)) {
        self thread function_cb1c46b8(0);
      }

      self notify(#"hash_1a22e1dd781f58d6");
    }
  }
}

function_4173ee30() {
  w_current = self getcurrentweapon();

  if(!function_98890cd8(w_current)) {
    return;
  }

  if(w_current == level.var_637136f3 || w_current == level.var_d7e67022) {
    if(!(isDefined(self.var_8d49716e) && self.var_8d49716e)) {
      self thread function_1b33fb6d(w_current);
      self thread function_ebe5f74b();
    }

    self.var_8d49716e = 1;

    if(self.previousweapon == level.var_637136f3 || self.previousweapon == level.var_d7e67022) {
      return;
    }

    zm_hero_weapon::show_hint(w_current, #"hash_1656aebadea29360");
    self playsoundtoplayer(#"hash_6a9b5c781d4019b2", self);

    if(w_current == level.var_637136f3) {
      self.var_f7c822b5 = 4;
    } else if(w_current == level.var_d7e67022) {
      self.var_f7c822b5 = 2;
    }
  }

  if(!self clientfield::get_to_player("" + #"afterlife_window")) {
    self clientfield::set_to_player("" + #"afterlife_window", 1);
  }

  if(w_current == level.var_4e845c84 || w_current == level.var_58e17ce3) {
    if(self.previousweapon == level.var_4e845c84 || self.previousweapon == level.var_58e17ce3) {
      return;
    }

    if(self clientfield::get("" + #"spectral_key_charging")) {
      zm_hero_weapon::show_hint(w_current, #"hash_7c3a1b7b56c4fac1");
    }

    self thread function_cb1c46b8(1);
    return;
  }

  self thread function_cb1c46b8(0);
}

private function_ebe5f74b() {
  self endon(#"bled_out", #"disconnect", #"hash_1b7c4bada7fa6175");
  self notify("4c9754f8548fd6a6");
  self endon("4c9754f8548fd6a6");

  while(true) {
    s_result = self waittill(#"destroy_riotshield", #"weapon_change");

    if(s_result._notify == "destroy_riotshield" || isDefined(s_result.weapon) && !function_98890cd8(s_result.weapon)) {
      self thread function_401e4768();
    }
  }
}

function_401e4768() {
  if(isDefined(self.var_8d49716e) && self.var_8d49716e) {
    self.var_8d49716e = undefined;
  }

  if(self clientfield::get_to_player("" + #"afterlife_window")) {
    self clientfield::set_to_player("" + #"afterlife_window", 0);
  }

  self notify(#"hash_1b7c4bada7fa6175");

  if(function_98890cd8(self.previousweapon)) {
    self playsoundtoplayer(#"hash_6632e419b4028fc4", self);
  }

  self thread function_cb1c46b8(0);
  self thread function_804309c(1);
}

function_90a37da4(s_params) {
  if(self clientfield::get("" + #"zombie_spectral_key_stun")) {
    self clientfield::set("" + #"zombie_spectral_key_stun", 0);
  }

  if(isplayer(s_params.eattacker) && (s_params.weapon == level.var_d7e67022 || s_params.weapon == level.var_637136f3 || s_params.weapon == level.var_4e845c84 || s_params.weapon == level.var_58e17ce3)) {
    self zm_trial_restrict_loadout::function_bb33631e(#"spoon");
  }

  if(isplayer(s_params.eattacker) && (s_params.weapon == level.var_d7e67022 || s_params.weapon == level.var_637136f3) && s_params.smeansofdeath === "MOD_ELECTROCUTED") {
    s_params.eattacker thread function_b952c1b(self);
  }
}

function_a8b4c2a7(einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(self clientfield::get("" + #"zombie_spectral_key_stun") && meansofdeath !== "MOD_ELECTROCUTED") {
    return 0;
  }

  if(meansofdeath !== "MOD_IMPACT" && meansofdeath !== "MOD_ELECTROCUTED" && !(isDefined(self.var_cbfc5f6e) && self.var_cbfc5f6e)) {
    return 0;
  }

  if(zm_trial_restrict_loadout::is_active() && zm_trial_restrict_loadout::function_937e218c() === #"spoon" && isplayer(eattacker)) {
    self.var_12745932 = 1;
  }

  if(isplayer(eattacker)) {
    if(self.animname === "zombie_eaten" && !(isDefined(self.allowdeath) && self.allowdeath) && self.health <= 1) {
      if((weapon == level.var_d7e67022 || weapon == level.var_637136f3) && meansofdeath === "MOD_ELECTROCUTED") {
        if(self clientfield::get("" + #"zombie_spectral_key_stun")) {
          self clientfield::set("" + #"zombie_spectral_key_stun", 0);
        }

        eattacker thread function_b952c1b(self);
      }
    }
  }

  return idamage;
}

private function_b952c1b(ai_zombie) {
  self endon(#"disconnect");
  v_pos = ai_zombie getcentroid();
  var_88f24b00 = util::spawn_model("tag_origin", v_pos + (0, 0, 12), ai_zombie.angles);
  var_88f24b00 clientfield::set("" + #"spectral_key_essence", 1);
  var_88f24b00 playSound(#"zmb_sq_souls_release");
  n_dist = distance(var_88f24b00.origin, self function_7eae6d92(var_88f24b00));
  n_move_time = n_dist / 1200;
  n_dist_sq = distance2dsquared(var_88f24b00.origin, self function_7eae6d92(var_88f24b00));
  n_start_time = gettime();
  n_total_time = 0;

  while(n_dist_sq > 256 && isalive(self)) {
    var_88f24b00 moveto(self function_7eae6d92(var_88f24b00), n_move_time);
    wait 0.1;

    if(isalive(self)) {
      n_current_time = gettime();
      n_total_time = (n_current_time - n_start_time) / 1000;
      n_move_time = self function_f40aa0ef(var_88f24b00, n_total_time);

      if(n_move_time == 0) {
        break;
      }

      n_dist_sq = distance2dsquared(var_88f24b00.origin, self function_7eae6d92(var_88f24b00));
    }
  }

  var_88f24b00 clientfield::set("" + #"spectral_key_essence", 0);
  util::wait_network_frame();
  var_88f24b00 delete();
  wait 0.1;
  self playsoundontag(#"zmb_sq_souls_impact", "tag_weapon_right");
  self clientfield::increment("" + #"hash_7663ae2eb866d2eb");
  self.var_9fd623ed = math::clamp(self.var_9fd623ed + 1, 0, self.var_f7c822b5 * 3);
  self thread function_804309c();
  self notify(#"hash_22a49f7903e394a5");
}

private function_7eae6d92(var_88f24b00) {
  n_pos = self.origin + (0, 0, 46) + anglestoright(self.angles) * 24 + anglesToForward(self.angles) * 70;
  return n_pos;
}

private function_1e981d89(n_pos) {
  self endon(#"death");
  self notify("<dev string:x38>");
  self endon("<dev string:x38>");

  while(true) {
    debugstar(n_pos, 5, (0, 1, 0));
    waitframe(5);
  }
}

  function function_f40aa0ef(var_88f24b00, n_total_time) {
    if(n_total_time >= 2.5) {
      return 0;
    }

    if(n_total_time < 0.25) {
      var_e89ec7fd = 0.25 - n_total_time;
      var_e89ec7fd = var_e89ec7fd < 0.05 ? 0.05 : var_e89ec7fd;
    } else {
      var_e89ec7fd = 0.05;
    }

    var_a6693654 = n_total_time * 0.25;
    var_5100df85 = 1200 + 1200 * var_a6693654;
    n_dist = distance(var_88f24b00.origin, self getEye());
    n_move_time = n_dist / var_5100df85;
    n_move_time = n_move_time < var_e89ec7fd ? var_e89ec7fd : n_move_time;
    return n_move_time;
  }

function_5f950378() {
  self endon(#"disconnect");

  if(!isDefined(self.var_f7c822b5)) {
    self.var_f7c822b5 = 2;
  }

  var_18138fac = self.var_f7c822b5 * 3;

  while(true) {
    s_result = self waittill(#"hash_22a49f7903e394a5", #"hash_1a22e1dd781f58d6", #"weapon_change", #"weapon_change_complete");
    var_74e62fc6 = self clientfield::get("" + #"spectral_key_charging");

    if((s_result._notify == "weapon_change" || s_result._notify == "weapon_change_complete") && !(isDefined(function_98890cd8(s_result.weapon)) && function_98890cd8(s_result.weapon))) {
      if(var_74e62fc6 != 0) {
        self clientfield::set("" + #"spectral_key_charging", 0);
      }

      continue;
    }

    if(self.var_9fd623ed >= var_18138fac) {
      if(var_74e62fc6 != 2) {
        self clientfield::set("" + #"spectral_key_charging", 2);
        self thread zm_audio::create_and_play_dialog(#"shield", #"charged", undefined, 1);
      }
    } else if(self.var_9fd623ed >= 3) {
      if(var_74e62fc6 != 1) {
        self clientfield::set("" + #"spectral_key_charging", 1);
      }
    } else if(var_74e62fc6 != 0) {
      self clientfield::set("" + #"spectral_key_charging", 0);
    }

    if(s_result._notify === #"hash_1a22e1dd781f58d6") {
      return;
    }
  }
}

function_cb1c46b8(b_enabled) {
  self endon(#"death");

  if(isDefined(b_enabled) && b_enabled) {
    if(!self clientfield::get("" + #"afterlife_vision_play")) {
      self clientfield::set("" + #"afterlife_vision_play", 1);
      self.snd_ent = spawn("script_origin", self.origin);
      self.snd_ent linkto(self);
      self.snd_ent playLoopSound(#"hash_197dd6d18afad004");
    }

    return;
  }

  if(self clientfield::get("" + #"afterlife_vision_play")) {
    self clientfield::set("" + #"afterlife_vision_play", 0);
  }

  if(isDefined(self.snd_ent)) {
    self.snd_ent stoploopsound();
    self.snd_ent delete();
  }
}

function_16dd8932() {
  level flag::wait_till("start_zombie_round_logic");
  self clientfield::set("" + #"afterlife_entity_visibility", 1);
}

melee_power(weapon) {
  if(self.var_9fd623ed >= 3 && (weapon == level.var_4e845c84 || weapon == level.var_58e17ce3)) {
    self clientfield::increment("" + #"spectral_shield_blast", 1);
    self playSound(#"hash_4fa7a7bff648310f");
    self.var_9fd623ed = math::clamp(self.var_9fd623ed - 3, 0, self.var_f7c822b5 * 3);
    self thread function_804309c();
    self notify(#"hash_22a49f7903e394a5");
    self thread function_92a54dac();
    self thread function_b18688c9();
    self function_d1cb7257();
    return;
  }

  riotshield::riotshield_melee(weapon);
}

private function_92a54dac() {
  self endon(#"death");
  a_e_afterlife = getEntArray("blast_attack_interactables", "script_noteworthy");

  foreach(e_afterlife in a_e_afterlife) {
    n_dist_sq = distancesquared(e_afterlife.origin, self.origin);

    if(n_dist_sq < 262144) {
      var_2ed6f142 = self getweaponmuzzlepoint();
      v_normal = vectornormalize(e_afterlife.origin - var_2ed6f142);
      var_ee5864e0 = self getweaponforwarddir();
      n_dot = vectordot(var_ee5864e0, v_normal);

      if(n_dot > 0.61) {
        e_afterlife notify(#"blast_attack", {
          #e_player: self
        });
      }
    }
  }
}

private function_b18688c9() {
  var_2ed6f142 = self getweaponmuzzlepoint();
  v_forward_angles = self getweaponforwarddir();

  if(level.players.size == 1) {
    return;
  }

  foreach(e_player in level.players) {
    if(e_player == self) {
      continue;
    }

    n_dist_sq = distancesquared(e_player.origin, self.origin);

    if(n_dist_sq < 262144 && isDefined(e_player sightconetrace(var_2ed6f142, self, v_forward_angles, 25)) && e_player sightconetrace(var_2ed6f142, self, v_forward_angles, 25)) {
      if(e_player laststand::player_is_in_laststand()) {
        if(self zm_laststand::can_revive(e_player, 1, 1)) {
          if(isDefined(e_player.revivetrigger) && isDefined(e_player.revivetrigger.beingrevived)) {
            e_player.revivetrigger setinvisibletoall();
            e_player.revivetrigger.beingrevived = 0;
          }

          e_player zm_laststand::auto_revive(self);
          self notify(#"hash_6db9af45fe6345fc");
        }

        continue;
      }

      e_player set_player_health();
    }
  }
}

private set_player_health() {
  if(self.health < self.var_66cb03ad) {
    self.health = self.var_66cb03ad;
    self clientfield::increment("" + #"zombie_spectral_heal", 1);
  }
}

private function_d1cb7257(n_clientfield) {
  self endon(#"disconnect");

  if(!isDefined(level.var_e386af8)) {
    level.var_e386af8 = [];
    level.var_7a867055 = [];
    level.var_2f7aae6c = [];
    level.var_8cd4a995 = [];
  }

  self function_750abd36();
  self.var_6c8b52a7 = 0;

  for(i = 0; i < level.var_2f7aae6c.size; i++) {
    [[level.var_dbfca4ee]] - > waitinqueue(level.var_2f7aae6c[i]);

    if(!isDefined(level.var_2f7aae6c[i])) {
      continue;
    }

    level.var_2f7aae6c[i] thread function_a9521272(self, level.var_8cd4a995[i], i);
  }

  for(i = 0; i < level.var_e386af8.size; i++) {
    [[level.var_dbfca4ee]] - > waitinqueue(level.var_e386af8[i]);

    if(!isDefined(level.var_e386af8[i])) {
      continue;
    }

    level.var_e386af8[i] thread function_c3eaccb8(self, level.var_7a867055[i]);
  }

  self notify(#"hash_5ac00f85b943ba5f", self.var_6c8b52a7);
  level.var_e386af8 = [];
  level.var_7a867055 = [];
  level.var_2f7aae6c = [];
  level.var_8cd4a995 = [];
}

function_750abd36() {
  var_2ed6f142 = self getweaponmuzzlepoint();
  a_zombies = array::get_all_closest(var_2ed6f142, getaiteamarray(level.zombie_team), undefined, undefined, 1200);

  if(!a_zombies.size) {
    return;
  }

  var_c57defd6 = 1440000;
  var_a1a810b8 = 1048576;
  n_fling_range_sq = 262144;
  var_74238e2c = 32400;
  var_60f35d29 = 9216;
  var_d6b10e11 = 9216;
  var_ee5864e0 = self getweaponforwarddir();
  v_end_pos = var_2ed6f142 + vectorscale(var_ee5864e0, 1200);

  for(i = 0; i < a_zombies.size; i++) {
    if(!isalive(a_zombies[i])) {
      continue;
    }

    v_zombie_origin = a_zombies[i] getcentroid();
    var_a155935 = distancesquared(var_2ed6f142, v_zombie_origin);

    if(var_a155935 > var_c57defd6) {
      return;
    }

    normal = vectornormalize(v_zombie_origin - var_2ed6f142);
    dot = vectordot(var_ee5864e0, normal);

    if(var_a155935 < var_d6b10e11) {
      level.var_2f7aae6c[level.var_2f7aae6c.size] = a_zombies[i];
      dist_mult = 1;
      fling_vec = vectornormalize(v_zombie_origin - var_2ed6f142);
      fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
      fling_vec = vectorscale(fling_vec, 50 + 50 * dist_mult);
      level.var_8cd4a995[level.var_8cd4a995.size] = fling_vec;
      continue;
    } else if(var_a155935 < var_60f35d29 && 0 > dot) {
      if(!isDefined(a_zombies[i].var_ae25f0b5)) {
        a_zombies[i].var_ae25f0b5 = level.var_fe5b96fb;
      }

      level.var_e386af8[level.var_e386af8.size] = a_zombies[i];
      level.var_7a867055[level.var_7a867055.size] = 0;
      continue;
    }

    if(0 > dot) {
      continue;
    }

    radial_origin = pointonsegmentnearesttopoint(var_2ed6f142, v_end_pos, v_zombie_origin);

    if(distancesquared(v_zombie_origin, radial_origin) > var_74238e2c) {
      continue;
    }

    if(0 == a_zombies[i] damageconetrace(var_2ed6f142, self)) {
      continue;
    }

    a_zombies[i].var_45233b = 1.1 * sqrt(var_a155935) / 1200;

    if(var_a155935 < n_fling_range_sq) {
      level.var_2f7aae6c[level.var_2f7aae6c.size] = a_zombies[i];
      dist_mult = (n_fling_range_sq - var_a155935) / n_fling_range_sq;
      fling_vec = vectornormalize(v_zombie_origin - var_2ed6f142);

      if(5000 < var_a155935) {
        fling_vec += vectornormalize(v_zombie_origin - radial_origin);
      }

      fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
      fling_vec = vectorscale(fling_vec, 50 + 50 * dist_mult);
      level.var_8cd4a995[level.var_8cd4a995.size] = fling_vec;
      continue;
    }

    if(var_a155935 < var_a1a810b8) {
      if(!isDefined(a_zombies[i].var_ae25f0b5)) {
        a_zombies[i].var_ae25f0b5 = level.var_fe5b96fb;
      }

      level.var_e386af8[level.var_e386af8.size] = a_zombies[i];
      level.var_7a867055[level.var_7a867055.size] = 1;
      continue;
    }

    if(!isDefined(a_zombies[i].var_ae25f0b5)) {
      a_zombies[i].var_ae25f0b5 = level.var_fe5b96fb;
    }

    level.var_e386af8[level.var_e386af8.size] = a_zombies[i];
    level.var_7a867055[level.var_7a867055.size] = 0;
  }
}

function_a9521272(player, fling_vec, index) {
  delay = self.var_45233b;

  if(isDefined(delay) && delay > 0.05) {
    wait delay;
  }

  if(!isalive(self)) {
    return;
  }

  if(isDefined(self.var_3b188a21)) {
    self[[self.var_3b188a21]](player);
    return;
  }

  if(self.zm_ai_category === #"basic" || self.zm_ai_category === #"enhanced") {
    if(!(isDefined(self.gibbed) && self.gibbed) && !(isDefined(self.no_gib) && self.no_gib)) {
      self zombie_utility::gib_random_parts();
    }

    self zombie_utility::setup_zombie_knockdown(player);
  }

  self function_68871817(player);

  if(self.health <= 0) {
    if(!(isDefined(self.no_damage_points) && self.no_damage_points)) {
      points = 10;

      if(1 == index) {
        points = 30;
      }
    }

    self.var_91ea09e0 = 1;
    player.var_6c8b52a7++;
  }
}

zombie_knockdown(player, gib) {
  delay = self.var_45233b;

  if(isDefined(delay) && delay > 0.05) {
    wait delay;
  }

  if(!isalive(self)) {
    return;
  }

  if(!isvehicle(self)) {
    if(gib && !(isDefined(self.gibbed) && self.gibbed)) {
      self.a.gib_ref = array::random(level.var_a6a70655);
      self thread zombie_death::do_gib();
    } else {
      self zombie_utility::setup_zombie_knockdown(player);
    }
  }

  if(isDefined(level.var_6e9f8dbd)) {
    self[[level.var_6e9f8dbd]](player, gib);
    return;
  }

  if(self.health < 15 && self.zm_ai_category !== #"popcorn") {
    self clientfield::set("" + #"spectral_blast_death", 1);
  }

  self dodamage(15, player.origin, player, player, undefined, "MOD_IMPACT", 0, player getcurrentweapon());

  if(self.health <= 0) {
    player.var_6c8b52a7++;
  }
}

function_68871817(e_attacker) {
  if(isDefined(self)) {
    if(isplayer(e_attacker)) {
      w_damage = e_attacker getcurrentweapon();
    } else {
      w_damage = undefined;
    }

    if(self.zm_ai_category == #"miniboss" || self.zm_ai_category == #"boss") {
      self thread namespace_9ff9f642::slowdown(#"hash_119644e9a557f4e9");
      self dodamage(self.maxhealth * 0.1, e_attacker.origin, e_attacker, e_attacker, "torso_lower", "MOD_IMPACT", 0, w_damage);
      return;
    }

    if(self.zm_ai_category !== #"popcorn") {
      self clientfield::set("" + #"spectral_blast_death", 1);
    }

    self dodamage(self.health + 666, e_attacker.origin, e_attacker, e_attacker, undefined, "MOD_IMPACT", 0, w_damage);
  }
}

function_c3eaccb8(player, gib) {
  self endon(#"death");

  if(!isalive(self)) {
    return;
  }

  if(isDefined(self.var_ae25f0b5)) {
    self[[self.var_ae25f0b5]](player, gib);
  }
}

private function_1b33fb6d(var_155e1cdd) {
  self endoncallback(&function_dc44932e, #"bled_out", #"disconnect", #"hash_1b7c4bada7fa6175");
  self notify("76bebc69db039874");
  self endon("76bebc69db039874");
  self thread function_804309c();

  while(true) {
    self waittill(#"weapon_fired");

    if(self zm_utility::is_drinking()) {
      continue;
    }

    self clientfield::set("" + #"spectral_key_beam_fire", 1);
    self clientfield::set("" + #"spectral_key_beam_flash", 1);
    self thread function_d1a7390b(var_155e1cdd);
    self thread function_423e10ee();

    while(zm_utility::is_player_valid(self) && self attackbuttonpressed() && !self fragbuttonpressed() && !self adsbuttonpressed() && !self zm_utility::is_drinking() && !(isDefined(self.var_4154aa8f) && self.var_4154aa8f)) {
      if(self isweaponlocked(var_155e1cdd) || namespace_fcd611c3::is_active() && !self namespace_fcd611c3::function_26f124d8()) {
        break;
      }

      waitframe(1);
    }

    self.var_f1b20bef = undefined;
    self clientfield::set("" + #"spectral_key_beam_fire", 0);
    self clientfield::set("" + #"spectral_key_beam_flash", 0);
    self notify(#"hash_7a5ea8904c04f16b");
    self thread function_804309c();

    while(isDefined(self.var_4154aa8f) && self.var_4154aa8f && zm_utility::is_player_valid(self) && self attackbuttonpressed()) {
      waitframe(1);
    }

    self.var_4154aa8f = undefined;
  }
}

private function_dc44932e(var_c34665fc) {
  if(var_c34665fc == #"hash_1b7c4bada7fa6175" || var_c34665fc == "weapon_change") {
    self.var_f1b20bef = undefined;
    self.var_4154aa8f = undefined;
    self clientfield::set("" + #"spectral_key_beam_fire", 0);
    self clientfield::set("" + #"spectral_key_beam_flash", 0);
    self notify(#"hash_7a5ea8904c04f16b");
  }
}

private function_423e10ee() {
  self endon(#"death", #"hash_1b7c4bada7fa6175", #"hash_7a5ea8904c04f16b");
  wait 180;
  self.var_4154aa8f = 1;
}

function_d1a7390b(w_curr) {
  self endon(#"disconnect", #"hash_7a5ea8904c04f16b");
  n_dist_sq_max = 173056;

  while(true) {
    var_24bae834 = 0;
    v_position = self getweaponmuzzlepoint();
    v_forward = self getweaponforwarddir();
    a_trace = beamtrace(v_position, v_position + v_forward * 416, 1, self);

    if(isDefined(a_trace[#"position"])) {
      n_dist_sq = distancesquared(self.origin, a_trace[#"position"]);

      if(n_dist_sq > n_dist_sq_max) {
        a_trace[#"entity"] = undefined;
      }
    }

    ai_zombie_target = self function_f0b16c98(w_curr, n_dist_sq_max);

    if(isDefined(a_trace[#"entity"]) || isDefined(ai_zombie_target)) {
      if(isDefined(ai_zombie_target)) {
        self.var_f1b20bef = ai_zombie_target;
      } else if(isDefined(a_trace[#"entity"])) {
        self.var_f1b20bef = a_trace[#"entity"];
      }

      e_last_target = self.var_f1b20bef;

      if(isai(e_last_target)) {
        self notify(#"hash_6ce63d9afba84f4c");

        if(!isDefined(e_last_target.maxhealth)) {
          e_last_target.maxhealth = e_last_target.health;
        }

        if(isDefined(e_last_target.var_77858b62)) {
          if(!(isDefined(e_last_target.var_5bf7575e) && e_last_target.var_5bf7575e)) {
            e_last_target thread[[e_last_target.var_77858b62]](self);
          }
        } else if(isDefined(e_last_target.zm_ai_category)) {
          switch (e_last_target.zm_ai_category) {
            case #"basic":
            case #"enhanced":
              if(!isDefined(e_last_target.var_455d573e)) {
                e_last_target.var_455d573e = e_last_target function_81947c70();
              }

              if(!(isDefined(e_last_target.var_5bf7575e) && e_last_target.var_5bf7575e)) {
                e_last_target thread function_35d74d73(self);
                waitframe(1);
              }

              if(isDefined(e_last_target)) {
                if(e_last_target.health <= e_last_target.var_455d573e) {
                  if(isDefined(e_last_target.var_9a51bdab)) {
                    n_current_time = gettime();
                    n_total_time = float(n_current_time - e_last_target.var_9a51bdab) / 1000;

                    if(n_total_time < 2) {
                      break;
                    }
                  }
                }

                e_last_target dodamage(e_last_target.var_455d573e, e_last_target getcentroid(), self, self, "torso_lower", "MOD_ELECTROCUTED");
              }

              break;
            case #"heavy":
            case #"miniboss":
            case #"boss":
              e_last_target dodamage(e_last_target.maxhealth * 0.01, e_last_target getcentroid(), self, self, "torso_lower", "MOD_ELECTROCUTED");

              if(!(isDefined(e_last_target.var_5bf7575e) && e_last_target.var_5bf7575e)) {
                e_last_target thread function_986701ac(self);
              }

              break;
            case #"popcorn":
              if(!isDefined(e_last_target.var_455d573e)) {
                e_last_target.var_455d573e = e_last_target function_81947c70();
              }

              if(!(isDefined(e_last_target.var_5bf7575e) && e_last_target.var_5bf7575e)) {
                e_last_target thread function_a370d183(self);
              }

              e_last_target dodamage(e_last_target.var_455d573e, e_last_target getcentroid(), self, self, undefined, "MOD_ELECTROCUTED");
              break;
            default:
              e_last_target dodamage(e_last_target.maxhealth * 0.01, e_last_target.origin, self, self, undefined, "MOD_ELECTROCUTED");
              break;
          }
        }
      } else if(function_ffa5b184(e_last_target)) {
        self notify(#"hash_6ce63d9afba84f4c");
        e_last_target dodamage(10, e_last_target.origin, self, self, undefined, "MOD_ELECTROCUTED");
      } else if(isDefined(level.var_c7626f2a)) {
        foreach(key_func in level.var_c7626f2a) {
          if(!isDefined(e_last_target.var_2b6afc3c)) {
            self thread[[key_func]](e_last_target);
            continue;
          }

          e_last_target notify(#"hash_2afc3e42ad78d30e");
        }
      }
    } else {
      self.var_f1b20bef = undefined;
      var_24bae834 = 0;

      switch (a_trace[#"surfacetype"]) {
        case #"glasscar":
        case #"rock":
        case #"metal":
        case #"metalcar":
        case #"glass":
          var_24bae834 = 1;
          var_7a585212 = "reflective_geo";
          break;
      }
    }

    e_last_target = undefined;
    wait 0.1;
  }
}

private function_81947c70() {
  if(self.zm_ai_category == #"popcorn") {
    var_f71f411b = 10;
  } else if(level.round_number < 16) {
    var_4e32983f = 1.3 / 16;
    var_15239c92 = (level.round_number - 1) * var_4e32983f + 2;
    var_f71f411b = var_15239c92 / 0.1;
  } else {
    var_f71f411b = 33;
  }

  if(!isDefined(self.maxhealth)) {
    self.maxhealth = self.health;
  }

  n_damage = int(math::clamp(self.maxhealth / var_f71f411b, 1, 1100));
  self.var_9a51bdab = gettime();
  return n_damage;
}

function_f0b16c98(w_curr, n_dist_sq_max) {
  var_2ed6f142 = self getweaponmuzzlepoint();
  v_forward_angles = self getweaponforwarddir();

  if(isalive(self.var_f1b20bef) && isDefined(self.var_f1b20bef sightconetrace(var_2ed6f142, self, v_forward_angles, 25)) && self.var_f1b20bef sightconetrace(var_2ed6f142, self, v_forward_angles, 25)) {
    return self.var_f1b20bef;
  }

  if(isDefined(level.var_68fa1bc)) {
    n_dist_sq = distancesquared(self.origin, level.var_68fa1bc.origin);

    if(n_dist_sq < n_dist_sq_max) {
      if(isDefined(level.var_68fa1bc sightconetrace(var_2ed6f142, self, v_forward_angles, 25)) && level.var_68fa1bc sightconetrace(var_2ed6f142, self, v_forward_angles, 25)) {
        return level.var_68fa1bc;
      }
    }
  }

  var_c581a3b2 = getaiteamarray(level.zombie_team);
  a_ai_zombies = arraysortclosest(var_c581a3b2, var_2ed6f142, 12);

  for(i = 0; i < a_ai_zombies.size; i++) {
    n_dist_sq = distancesquared(self.origin, a_ai_zombies[i].origin);

    if(n_dist_sq < n_dist_sq_max) {
      if(isDefined(a_ai_zombies[i] sightconetrace(var_2ed6f142, self, v_forward_angles, 25) && isDefined(a_ai_zombies[i].allowdeath) && a_ai_zombies[i].allowdeath) && a_ai_zombies[i] sightconetrace(var_2ed6f142, self, v_forward_angles, 25) && isDefined(a_ai_zombies[i].allowdeath) && a_ai_zombies[i].allowdeath) {
        return a_ai_zombies[i];
      }
    }
  }
}

function_35d74d73(e_attacker) {
  self notify(#"hash_3f91506396266ee6");
  self endon(#"hash_3f91506396266ee6");
  e_attacker endon(#"disconnect");

  if(isDefined(self.aat_turned) && self.aat_turned || !isalive(self)) {
    return;
  }

  self.var_5bf7575e = 1;
  self ai::stun();
  self.instakill_func = &function_6472c628;

  if(!self clientfield::get("" + #"zombie_spectral_key_stun")) {
    var_21c1ba1 = e_attacker getentitynumber();
    self clientfield::set("" + #"zombie_spectral_key_stun", var_21c1ba1 + 1);
    e_attacker clientfield::set("" + #"spectral_key_beam_flash", 2);

    if(self.zm_ai_category == #"basic" || self.zm_ai_category == #"enhanced") {
      bhtnactionstartevent(self, "electrocute");
    }
  }

  while(e_attacker.var_f1b20bef === self && isalive(self)) {
    if(self.health <= self.maxhealth * 0.5 && !(isDefined(self.is_floating) && self.is_floating)) {
      self thread scene::play(#"aib_tplt_zombie_base_dth_f_float_notrans_01", self);
      self.is_floating = 1;
    }

    waitframe(1);
  }

  if(isDefined(self) && isDefined(self.is_floating) && self.is_floating) {
    self thread scene::stop(#"aib_tplt_zombie_base_dth_f_float_notrans_01");
    self.is_floating = undefined;
  }

  var_d64818ae = e_attacker clientfield::get("" + #"spectral_key_beam_flash");

  if(e_attacker attackbuttonpressed() && var_d64818ae === 2) {
    e_attacker clientfield::set("" + #"spectral_key_beam_flash", 1);
  }

  if(isalive(self)) {
    if(self clientfield::get("" + #"zombie_spectral_key_stun")) {
      self clientfield::set("" + #"zombie_spectral_key_stun", 0);
    }

    self.var_5bf7575e = 0;
    self ai::clear_stun();
    self.instakill_func = undefined;
  }
}

private function_6472c628(e_player, mod, shitloc) {
  w_current = e_player getcurrentweapon();

  if(function_98890cd8(w_current)) {
    return true;
  }

  return false;
}

function_986701ac(e_attacker) {
  self notify(#"hash_3c2776b4262d3359");
  self endon(#"hash_3c2776b4262d3359", #"death");

  if(isDefined(self.aat_turned) && self.aat_turned) {
    return;
  }

  self.var_5bf7575e = 1;

  if(!self clientfield::get("" + #"zombie_spectral_key_stun")) {
    var_21c1ba1 = e_attacker getentitynumber();
    self clientfield::set("" + #"zombie_spectral_key_stun", var_21c1ba1 + 1);
    e_attacker clientfield::set("" + #"spectral_key_beam_flash", 2);
  }

  while(e_attacker.var_f1b20bef === self && isalive(self)) {
    waitframe(1);
  }

  var_d64818ae = e_attacker clientfield::get("" + #"spectral_key_beam_flash");

  if(e_attacker attackbuttonpressed() && var_d64818ae === 2) {
    e_attacker clientfield::set("" + #"spectral_key_beam_flash", 1);
  }

  if(isDefined(self)) {
    if(self clientfield::get("" + #"zombie_spectral_key_stun")) {
      self clientfield::set("" + #"zombie_spectral_key_stun", 0);
    }

    self.var_5bf7575e = 0;
  }
}

private function_8103698() {
  if(isDefined(self.var_aef7bb46) && self.var_aef7bb46) {
    return;
  }

  self.var_aef7bb46 = 1;
  self thread function_da5e7ec0();
  self ai::stun();
  wait 1;
  self ai::clear_stun();
}

private function_da5e7ec0() {
  self endon(#"death");
  wait 12.5;
  self.var_aef7bb46 = undefined;
}

private function_a370d183(e_attacker) {
  self notify(#"hash_3c2776b4262d3359");
  self endon(#"hash_3c2776b4262d3359", #"death");
  e_attacker endon(#"disconnect");
  self.var_5bf7575e = 1;
  self ai::stun();

  if(!self clientfield::get("" + #"zombie_spectral_key_stun")) {
    var_21c1ba1 = e_attacker getentitynumber();
    self clientfield::set("" + #"zombie_spectral_key_stun", var_21c1ba1 + 1);
    e_attacker clientfield::set("" + #"spectral_key_beam_flash", 2);
  }

  while(e_attacker.var_f1b20bef === self && isalive(self)) {
    waitframe(1);
  }

  var_d64818ae = e_attacker clientfield::get("" + #"spectral_key_beam_flash");

  if(e_attacker attackbuttonpressed() && var_d64818ae === 2) {
    e_attacker clientfield::set("" + #"spectral_key_beam_flash", 1);
  }

  if(isDefined(self)) {
    if(self clientfield::get("" + #"zombie_spectral_key_stun")) {
      self clientfield::set("" + #"zombie_spectral_key_stun", 0);
    }

    self.var_5bf7575e = undefined;
    self ai::clear_stun();
  }
}

function_804309c(var_4c6ec31d = 0) {
  if(self hasweapon(level.var_637136f3)) {
    if(self.var_9fd623ed < 3 || isDefined(var_4c6ec31d) && var_4c6ec31d) {
      if(self getweaponammoclip(level.var_637136f3) !== 0) {
        self setweaponammoclip(level.var_637136f3, 0);
        self setweaponammoclip(level.var_58e17ce3, 0);
        self setweaponammoclip(getweapon(#"zhield_spectral_lh_upgraded"), 0);
      }
    } else if(self.var_9fd623ed >= 3) {
      if(self getweaponammoclip(level.var_d7e67022) !== int(self.var_9fd623ed / 3)) {
        self setweaponammoclip(level.var_637136f3, int(self.var_9fd623ed / 3));
        self setweaponammoclip(level.var_58e17ce3, int(self.var_9fd623ed / 3));
        self setweaponammoclip(getweapon(#"zhield_spectral_lh_upgraded"), int(self.var_9fd623ed / 3));
      }
    }

    return;
  }

  if(self hasweapon(level.var_d7e67022)) {
    if(self.var_9fd623ed < 3 || isDefined(var_4c6ec31d) && var_4c6ec31d) {
      if(self getweaponammoclip(level.var_d7e67022) !== 0) {
        self setweaponammoclip(level.var_d7e67022, 0);
        self setweaponammoclip(level.var_4e845c84, 0);
        self setweaponammoclip(getweapon(#"zhield_spectral_lh"), 0);
      }

      return;
    }

    if(self.var_9fd623ed >= 3) {
      if(self getweaponammoclip(level.var_d7e67022) !== int(self.var_9fd623ed / 3)) {
        self setweaponammoclip(level.var_d7e67022, int(self.var_9fd623ed / 3));
        self setweaponammoclip(level.var_4e845c84, int(self.var_9fd623ed / 3));
        self setweaponammoclip(getweapon(#"zhield_spectral_lh"), int(self.var_9fd623ed / 3));
      }
    }
  }
}

private function_b84d0267() {
  level flag::wait_till("start_zombie_round_logic");
  a_mdl_shields = getEntArray("shield_model", "script_noteworthy");

  foreach(mdl_shield in a_mdl_shields) {
    mdl_shield hidepart("tag_hellbox_lock");
  }

  while(true) {
    s_result = level waittill(#"crafting_started");

    if(isDefined(s_result.unitrigger)) {
      s_result.unitrigger thread function_d0b3a2c6();
    }
  }
}

function_d0b3a2c6() {
  self endon(#"death");

  if(isDefined(self.stub.blueprint) && isDefined(self.stub.blueprint.var_54a97edd) && self.stub.blueprint.var_54a97edd === level.var_d7e67022) {
    if(isDefined(self.stub.model)) {
      s_progress = self waittill(#"hash_6db03c91467a21f5");

      if(isDefined(s_progress.b_completed) && s_progress.b_completed) {
        self.stub.model clientfield::increment("" + #"shield_crafting_fx");
      }
    }
  }
}

function_9693e041(player) {
  if(!player hasweapon(level.var_637136f3) && isDefined(player.var_5ba94c1e) && player.var_5ba94c1e) {
    self.hint_string = zm_utility::function_d6046228(#"hash_5eaa3c1a4110ddc9", #"hash_33cd9a34111d6257");

    if(isDefined(player.talisman_shield_price)) {
      var_a185bd91 = player.talisman_shield_price;
    } else {
      var_a185bd91 = 0;
    }

    self.cost = self zm_crafting::function_ceac3bf9(player);
  }

  if(player hasweapon(level.var_637136f3)) {
    if(isDefined(self.blueprint.var_54a97edd.isriotshield) && self.blueprint.var_54a97edd.isriotshield && isDefined(player.player_shield_reset_health) && isDefined(player.var_d3345483) && player.var_d3345483) {
      self.cost = self zm_crafting::function_ceac3bf9(player, 1);
      self.hint_string = zm_utility::function_d6046228(#"hash_35387f35bd87b96b", #"hash_3ee2e0100fefb461");
      _shad_turret_debug_server = 1;
      return;
    }

    self.hint_string = #"hash_53fd856df9288be7";
    self.cost = undefined;
    return 1;
  }
}

function_df8ce6e2(player) {
  player.var_54a51968 = self.target;
  player thread function_e5ca1c8d();

  if(!(isDefined(player.var_5ba94c1e) && player.var_5ba94c1e)) {
    return true;
  }

  w_shield = getweapon(#"zhield_spectral_dw");
  w_shield_upgraded = getweapon(#"zhield_spectral_dw_upgraded");

  if(player != self.parent_player) {
    return false;
  }

  if(!zm_utility::is_player_valid(player)) {
    player thread zm_utility::ignore_triggers(0.5);
    return false;
  }

  if(player hasweapon(w_shield)) {
    player zm_weapons::weapon_take(w_shield);
    player thread zm_weapons::weapon_give(w_shield_upgraded);
    player.weaponriotshield = w_shield_upgraded;
    return false;
  }

  if(player zm_crafting::function_2d53738e(w_shield_upgraded)) {
    if(isDefined(self.stub.blueprint.var_54a97edd.isriotshield) && self.stub.blueprint.var_54a97edd.isriotshield && isDefined(player.player_shield_reset_health) && isDefined(player.var_d3345483) && player.var_d3345483) {
      var_d97673ff = 1;
    } else {
      return false;
    }
  }

  if(isDefined(var_d97673ff) && var_d97673ff) {
    var_f66d1847 = self.stub zm_crafting::function_ceac3bf9(player, 1);

    if(isDefined(var_f66d1847) && var_f66d1847 > 0) {
      if(player zm_score::can_player_purchase(var_f66d1847)) {
        player thread zm_crafting::function_fccf9f0d();
        player zm_score::minus_to_player_score(var_f66d1847);
        player zm_utility::play_sound_on_ent("purchase");
      } else {
        zm_utility::play_sound_on_ent("no_purchase");
        player thread zm_audio::create_and_play_dialog("general", "outofmoney");
        return false;
      }
    }

    player[[player.player_shield_reset_health]](w_shield_upgraded, 0);
  } else {
    var_f66d1847 = self.stub zm_crafting::function_ceac3bf9(player);

    if(isDefined(var_f66d1847) && var_f66d1847 > 0) {
      if(player zm_score::can_player_purchase(var_f66d1847)) {
        player thread zm_crafting::function_fccf9f0d();
        player zm_score::minus_to_player_score(var_f66d1847);
        player zm_utility::play_sound_on_ent("purchase");
      } else {
        zm_utility::play_sound_on_ent("no_purchase");
        player thread zm_audio::create_and_play_dialog("general", "outofmoney");
        return false;
      }
    }

    if(isDefined(player.hasriotshield) && player.hasriotshield && isDefined(player.weaponriotshield)) {
      player zm_weapons::weapon_take(player.weaponriotshield);
    }

    player thread zm_weapons::weapon_give(w_shield_upgraded);
  }

  player notify(#"hash_77d44943fb143b18", {
    #weapon: self.stub.blueprint.var_54a97edd
  });
  return false;
}

private function_e5ca1c8d() {
  self notify("29615d74ce832e90");
  self endon("29615d74ce832e90");
  self endon(#"death");
  s_result = self waittilltimeout(5, #"hash_77d44943fb143b18");

  if(s_result._notify == #"hash_77d44943fb143b18" && function_98890cd8(s_result.weapon)) {
    self thread function_804309c();
  }
}

function_265e517c(e_player) {
  a_mdl_shield = getEntArray("shield_model", "script_noteworthy");
  var_824b5a74 = getEntArray("shield_upgraded_model", "script_noteworthy");

  if(var_824b5a74.size == 0) {
    foreach(mdl_shield in a_mdl_shield) {
      var_ca89c8f9 = util::spawn_model(mdl_shield.model, mdl_shield.origin, mdl_shield.angles);
      var_ca89c8f9.script_noteworthy = "shield_upgraded_model";
      var_ca89c8f9 setinvisibletoall();
      var_ca89c8f9.var_54a51968 = mdl_shield.targetname;
    }

    var_7c26f4d0 = 1;
  }

  if(isDefined(var_7c26f4d0) && var_7c26f4d0) {
    var_824b5a74 = getEntArray("shield_upgraded_model", "script_noteworthy");
  }

  if(isDefined(e_player)) {
    foreach(mdl_shield in a_mdl_shield) {
      mdl_shield setinvisibletoplayer(e_player);
    }

    foreach(var_ca89c8f9 in var_824b5a74) {
      if(e_player.var_54a51968 === var_ca89c8f9.var_54a51968) {
        var_ca89c8f9 setvisibletoplayer(e_player);
        break;
      }
    }
  }
}

render_debug_sphere(origin, color) {
  if(getdvarint(#"turret_debug_server", 0)) {

    sphere(origin, 2, color, 0.75, 1, 10, 100);

  }
}

function_7067b673(origin1, origin2, color) {
  if(getdvarint(#"turret_debug_server", 0)) {

    line(origin1, origin2, color, 0.75, 1, 100);

  }
}

function_3a6ee2ea() {
  if(!getdvarint(#"zm_debug_ee", 0)) {
    return;
  }

  zm_devgui::add_custom_devgui_callback(&function_6da92963);
  adddebugcommand("<dev string:x4b>");
  adddebugcommand("<dev string:xbe>");
}

function_6da92963(cmd) {
  switch (cmd) {
    case #"hash_2346833eb7280698":
      foreach(e_player in level.players) {
        if(e_player hasweapon(level.var_4e845c84)) {
          e_player.var_9fd623ed = math::clamp(e_player.var_f7c822b5 * 3, 0, e_player.var_f7c822b5 * 3);
          e_player setweaponammoclip(level.var_4e845c84, e_player.var_9fd623ed);
          e_player notify(#"hash_22a49f7903e394a5");
          e_player thread function_804309c();
          continue;
        }

        if(e_player hasweapon(level.var_58e17ce3)) {
          e_player.var_9fd623ed = math::clamp(e_player.var_f7c822b5 * 3, 0, e_player.var_f7c822b5 * 3);
          e_player setweaponammoclip(level.var_58e17ce3, e_player.var_9fd623ed);
          e_player notify(#"hash_22a49f7903e394a5");
          e_player thread function_804309c();
        }
      }

      break;
    case #"hash_5a13ac5a96bb700c":
      foreach(e_player in level.players) {
        if(e_player hasweapon(level.var_4e845c84)) {
          e_player.var_9fd623ed = math::clamp(e_player.var_f7c822b5 * 3, 0, e_player.var_f7c822b5 * 3);
          e_player setweaponammoclip(level.var_4e845c84, e_player.var_f7c822b5);
          e_player notify(#"hash_22a49f7903e394a5");
          e_player thread function_4df187a9(level.var_4e845c84);
          continue;
        }

        if(e_player hasweapon(level.var_58e17ce3)) {
          e_player.var_9fd623ed = math::clamp(e_player.var_f7c822b5 * 3, 0, e_player.var_f7c822b5 * 3);
          e_player setweaponammoclip(level.var_58e17ce3, e_player.var_f7c822b5);
          e_player notify(#"hash_22a49f7903e394a5");
          e_player thread function_4df187a9(level.var_58e17ce3);
        }
      }

      break;
  }
}

function_4df187a9(w_shield) {
  self notify(#"hash_1f37709e96e62bf2");
  self endon(#"disconnect", #"hash_1f37709e96e62bf2");

  while(true) {
    self thread function_804309c();
    s_result = self waittill(#"hash_5ac00f85b943ba5f", #"take_weapon");

    if(!self hasweapon(w_shield)) {
      return;
    }

    self.var_9fd623ed = math::clamp(self.var_f7c822b5 * 3, 0, self.var_f7c822b5 * 3);
    self setweaponammoclip(w_shield, self.var_f7c822b5);
    self notify(#"hash_22a49f7903e394a5");
  }
}

