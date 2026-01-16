/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_zombshell.gsc
***********************************************/

#include script_24c32478acf44108;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\callbacks;
#include scripts\zm_common\trials\zm_trial_headshots_only;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_utility;

#namespace zm_perk_zombshell;

autoexec __init__system__() {
  system::register(#"zm_perk_zombshell", &__init__, undefined, undefined);
}

__init__() {
  if(getdvarint(#"hash_49ef5478510b5af3", 0)) {
    enable_zombshell_perk_for_level();
    namespace_9ff9f642::register_slowdown(#"hash_5d9e1ae933ad6f87", 0.7, 3);
    namespace_9ff9f642::register_slowdown(#"hash_63a208b609d3fa87", 0.8, 3);
  }
}

enable_zombshell_perk_for_level() {
  if(function_8b1a219a()) {
    zm_perks::register_perk_basic_info(#"specialty_zombshell", #"perk_zombshell", 4000, #"hash_3d4a42f8dbfe314f", getweapon("zombie_perk_bottle_zombshell"), getweapon("zombie_perk_totem_zombshell"), #"zmperkszombshell");
  } else {
    zm_perks::register_perk_basic_info(#"specialty_zombshell", #"perk_zombshell", 4000, #"zombie/perk_zombshell", getweapon("zombie_perk_bottle_zombshell"), getweapon("zombie_perk_totem_zombshell"), #"zmperkszombshell");
  }

  zm_perks::register_perk_clientfields(#"specialty_zombshell", &function_137d1be7, &function_1ab3592a);
  zm_perks::register_perk_threads(#"specialty_zombshell", &function_a639586f, &function_7328ce94, &reset_cooldown);
  zm_perks::register_actor_damage_override(#"specialty_zombshell", &function_65a90069);

  if(isDefined(level.var_241ad22d) && level.var_241ad22d) {
    level thread[[level.var_241ad22d]]();
  }

  callback::on_ai_killed(&on_ai_killed);
  callback::function_74872db6(&function_74872db6);
}

function_137d1be7() {
  clientfield::register("scriptmover", "" + #"zombshell_aoe", 15000, 1, "int");
  clientfield::register("toplayer", "" + #"hash_5f545b88ba3e2938", 15000, 1, "int");
  clientfield::register("actor", "" + #"zombshell_explosion", 15000, 1, "counter");
}

function_1ab3592a(state) {}

function_a639586f() {
  self endon(#"disconnect", #"specialty_zombshell" + "_take");
  self.var_849c3bcf = zm_perks::function_c1efcc57(#"specialty_zombshell");

  if(isDefined(self.var_69604b18) && self.var_69604b18 && isDefined(self.var_849c3bcf)) {
    self zm_perks::function_2ac7579(self.var_849c3bcf, 2, #"perk_zombshell");
  }

  if(!isDefined(self.var_69604b18)) {
    self.var_69604b18 = 0;
  }

  if(!isDefined(self.var_491bd66d)) {
    self.var_491bd66d = 1;
  }

  if(!isDefined(self.var_c0832831)) {
    self.var_c0832831 = 15;
  }
}

function_7328ce94(b_pause, str_perk, str_result, n_slot) {
  self notify(#"specialty_zombshell" + "_take");
  self function_993d228c();

  if(isDefined(self.e_zombshell)) {
    self.e_zombshell delete();
  }

  assert(isDefined(self.var_849c3bcf), "<dev string:x38>");

  if(isDefined(self.var_849c3bcf)) {
    self zm_perks::function_13880aa5(self.var_849c3bcf, 0, #"perk_zombshell");
    self.var_849c3bcf = undefined;
  }
}

on_ai_killed(s_params) {
  player = s_params.eattacker;

  if(isplayer(player) && player hasperk(#"specialty_zombshell") && s_params.shitloc !== "none") {
    n_chance = player hasperk(#"specialty_mod_zombshell") ? 20 : 15;

    if(!isDefined(player.e_zombshell) && !player.var_69604b18 && math::cointoss(n_chance) && isDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area) {
      self.no_powerups = 1;
      self shell_explosion(player, s_params.weapon);
    }
  }
}

shell_explosion(e_attacker, w_weapon) {
  e_attacker endon(#"disconnect", #"specialty_zombshell" + "_take");

  if(!isDefined(self)) {
    e_attacker function_993d228c();
    return;
  }

  v_origin = self.origin + (0, 0, 20);
  self clientfield::increment("" + #"zombshell_explosion");

  if(!isDefined(e_attacker.e_zombshell)) {
    e_attacker.e_zombshell = util::spawn_model("tag_origin", v_origin);
  }

  e_attacker.e_zombshell.origin = v_origin;
  e_attacker.e_zombshell clientfield::set("" + #"zombshell_aoe", 1);
  a_enemies = getaiteamarray(#"axis");

  if(isDefined(self)) {
    arrayremovevalue(a_enemies, self);
  }

  a_e_blasted_zombies = arraysortclosest(a_enemies, v_origin, 3, undefined, 128);

  foreach(zombie in a_e_blasted_zombies) {
    zombie zombie_death_gib(e_attacker, w_weapon);
    util::wait_network_frame();
  }

  physicsexplosionsphere(v_origin, 128, 0, 5, 500, 500);
  e_attacker thread aoe_think(e_attacker.e_zombshell.origin);

  if(e_attacker hasperk(#"specialty_mod_zombshell")) {
    wait 8;
  } else {
    wait 8;
  }

  e_attacker.e_zombshell clientfield::set("" + #"zombshell_aoe", 0);
  e_attacker notify(#"zombshell_aoe");
  e_attacker function_993d228c();
  e_attacker thread zombshell_cooldown(e_attacker.var_c0832831);
  e_attacker.var_491bd66d++;
  e_attacker.var_c0832831 += 15;
  wait 0.1;

  if(isDefined(e_attacker.e_zombshell)) {
    e_attacker.e_zombshell delete();
  }
}

zombie_death_gib(e_attacker, w_weapon) {
  if(!isalive(self) || isDefined(level.headshots_only) && level.headshots_only || zm_trial_headshots_only::is_active()) {
    return;
  }

  gibserverutils::gibhead(self);

  if(math::cointoss()) {
    gibserverutils::gibleftarm(self);
  } else {
    gibserverutils::gibrightarm(self);
  }

  gibserverutils::giblegs(self);
  self dodamage(self.health, self.origin, e_attacker, e_attacker, "none", "MOD_EXPLOSIVE", 0, w_weapon);
}

aoe_think(var_4eaa1f4c) {
  self endon(#"death", #"zombshell_aoe", #"scene_ready", #"specialty_zombshell" + "_take");

  while(true) {
    array::thread_all(level.activeplayers, &function_279e31b8, self);
    n_frame = self function_6b9dcec(var_4eaa1f4c);
    var_adaf2ccb = math::clamp(0.25 - n_frame * 0.05, 0.05, 0.25);

    if(!isDefined(var_adaf2ccb)) {
      var_adaf2ccb = 0.25;
    }

    wait var_adaf2ccb;
  }
}

function_6b9dcec(var_fc7bb684) {
  self endon(#"death", #"zombshell_aoe", #"specialty_zombshell" + "_take");
  a_enemies = getaiteamarray(#"axis");
  a_ai_zombies = arraysortclosest(a_enemies, var_fc7bb684, undefined, undefined, 128);
  a_ai_zombies = array::filter(a_ai_zombies, 0, &function_c3af2a78);
  n_count = 0;
  n_frames = 0;

  foreach(zombie in a_ai_zombies) {
    zombie function_17a24d7f(self);
    n_count++;

    if(n_count == 4) {
      waitframe(1);
      n_count = 0;
      n_frames++;
    }
  }

  return n_frames;
}

function_c3af2a78(ai_enemy) {
  b_callback_result = 1;

  if(isDefined(level.var_35b2b6d3)) {
    b_callback_result = [[level.var_35b2b6d3]](ai_enemy);
  }

  return b_callback_result;
}

function_17a24d7f(e_player) {
  e_player endon(#"death", #"zombshell_aoe");

  if(isalive(self) && isDefined(self.zm_ai_category)) {
    if(isalive(self) && isactor(self) && !(isDefined(self.var_36c260a2) && self.var_36c260a2) && !self function_dd070839()) {
      self thread function_a8e6f773();
    }
  }
}

function_a8e6f773(n_time = 3) {
  self endon(#"death");
  self notify("1d4b84eee4e87828");
  self endon("1d4b84eee4e87828");

  if(isDefined(self.aat_turned) && self.aat_turned) {
    return;
  }

  self.var_36c260a2 = 1;

  if(self.zm_ai_category === #"heavy" || self.zm_ai_category === #"miniboss") {
    self thread namespace_9ff9f642::slowdown(#"hash_63a208b609d3fa87");
  } else {
    self thread namespace_9ff9f642::slowdown(#"hash_5d9e1ae933ad6f87");
  }

  wait n_time;
  self.var_36c260a2 = undefined;
}

function_65a90069(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isDefined(self.var_36c260a2) && self.var_36c260a2) {
    n_damage = int(damage * 1.25);
    return n_damage;
  }

  return damage;
}

function_279e31b8(e_owner) {
  self notify("b24e157aae48642");
  self endon("b24e157aae48642");
  self endoncallback(&function_26c2620, #"death", #"zombshell_aoe", #"scene_ready", #"specialty_zombshell" + "_take");
  var_bbf6e7fd = 16384;
  var_fc7bb684 = e_owner.e_zombshell.origin;

  while(isDefined(e_owner.e_zombshell) && distancesquared(self.origin, var_fc7bb684) < var_bbf6e7fd && self hasperk(#"specialty_mod_zombshell")) {
    if(!isDefined(self.var_9c1c5b59)) {
      self val::set(#"perk_zombshell", "ignoreme");
      self clientfield::set_to_player("" + #"hash_5f545b88ba3e2938", 1);
      self.var_9c1c5b59 = 1;
    }

    wait 0.5;
  }

  if(isDefined(self.var_9c1c5b59) && self.var_9c1c5b59) {
    self function_993d228c();
  }
}

function_993d228c() {
  self val::reset(#"perk_zombshell", "ignoreme");
  self clientfield::set_to_player("" + #"hash_5f545b88ba3e2938", 0);
  self.var_9c1c5b59 = undefined;
}

function_26c2620(str_notify) {
  if(str_notify === "scene_ready") {
    self function_993d228c();
  }
}

zombshell_cooldown(var_85dcb56c) {
  self endon(#"hash_4aaf55c36b37725e", #"disconnect");
  self.var_69604b18 = 1;

  if(self hasperk(#"specialty_zombshell") && isDefined(self.var_849c3bcf)) {
    self zm_perks::function_2ac7579(self.var_849c3bcf, 2, #"perk_zombshell");
  }

  self thread function_7d72c6f9(var_85dcb56c);
  wait var_85dcb56c;
  self thread reset_cooldown();
}

function_7d72c6f9(var_85dcb56c) {
  self endon(#"disconnect", #"hash_4aaf55c36b37725e");
  self.var_fc63c7bc = var_85dcb56c;
  self zm_perks::function_13880aa5(self.var_849c3bcf, 0, #"perk_zombshell");

  while(true) {
    wait 0.1;
    self.var_fc63c7bc -= 0.1;
    self.var_fc63c7bc = math::clamp(self.var_fc63c7bc, 0, var_85dcb56c);
    n_percentage = 1 - self.var_fc63c7bc / var_85dcb56c;
    n_percentage = math::clamp(n_percentage, 0.02, var_85dcb56c);

    if(self hasperk(#"specialty_zombshell") && isDefined(self.var_849c3bcf)) {
      self zm_perks::function_13880aa5(self.var_849c3bcf, n_percentage, #"perk_zombshell");
    }
  }
}

reset_cooldown() {
  self notify(#"hash_4aaf55c36b37725e");
  self.var_69604b18 = 0;

  if(self hasperk(#"specialty_zombshell")) {
    assert(isDefined(self.var_849c3bcf), "<dev string:x38>");

    if(isDefined(self.var_849c3bcf)) {
      self zm_perks::function_2ac7579(self.var_849c3bcf, 1, #"perk_zombshell");
      self zm_perks::function_13880aa5(self.var_849c3bcf, 1, #"perk_zombshell");
    }
  }
}

function_74872db6() {
  a_players = getplayers();

  foreach(player in a_players) {
    player.var_c0832831 = 15;
  }
}