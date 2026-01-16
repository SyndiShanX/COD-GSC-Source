/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_wolf_protector.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\callbacks;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_perk_wolf_protector;

autoexec __init__system__() {
  system::register(#"zm_perk_wolf_protector", &__init__, undefined, undefined);
}

__init__() {
  if(getdvarint(#"hash_4e1190045ef3588b", 0)) {
    function_27473e44();
  }
}

function_27473e44() {
  if(function_8b1a219a()) {
    zm_perks::register_perk_basic_info(#"specialty_wolf_protector", #"perk_wolf_protector", 3000, #"hash_4cacb949ec1378", getweapon("zombie_perk_bottle_wolf_protector"), getweapon("zombie_perk_totem_wolf_protector"), #"zmperkswolfprotector");
  } else {
    zm_perks::register_perk_basic_info(#"specialty_wolf_protector", #"perk_wolf_protector", 3000, #"hash_5b2099ef891bc954", getweapon("zombie_perk_bottle_wolf_protector"), getweapon("zombie_perk_totem_wolf_protector"), #"zmperkswolfprotector");
  }

  zm_perks::register_perk_clientfields(#"specialty_wolf_protector", &register_clientfield, &set_clientfield);
  zm_perks::register_perk_threads(#"specialty_wolf_protector", &give_perk, &take_perk, &reset_cooldown);
  callback::on_ai_killed(&on_ai_killed);
  callback::on_ai_damage(&on_ai_damaged);
  callback::on_disconnect(&on_disconnect);
}

register_clientfield() {
  clientfield::register("actor", "wolf_protector_fx", 20000, 1, "int");
  clientfield::register("actor", "wolf_protector_spawn_fx", 20000, 1, "counter");
}

set_clientfield(state) {}

give_perk() {
  self endon(#"disconnect", #"specialty_wolf_protector" + "_take");
  self.var_7d46fb46 = zm_perks::function_c1efcc57(#"specialty_wolf_protector");

  if(isDefined(self.var_6577c75d) && self.var_6577c75d && isDefined(self.var_7d46fb46)) {
    self zm_perks::function_2ac7579(self.var_7d46fb46, 2, #"perk_wolf_protector");
  }

  if(!isDefined(self.var_6577c75d)) {
    self.var_6577c75d = 0;
  }

  if(!isDefined(self.var_815af0c3)) {
    self.var_815af0c3 = 0;
  }

  if(!isDefined(self.var_f7a89869)) {
    self.var_f7a89869 = 45;
  }

  if(!isDefined(self.var_f9d35f81)) {
    self.var_f9d35f81 = 1;
  }

  if(!isDefined(self.var_9a054c95)) {
    self.var_9a054c95 = 300;
  }

  if(!isDefined(self.var_669304d0)) {
    self.var_669304d0 = 0;
  }

  if(!isDefined(self.var_2dc0d63c)) {
    self.var_2dc0d63c = 0;
  }

  if(!isDefined(self.var_841cdb3)) {
    self.var_841cdb3 = 0;
  }
}

take_perk(b_pause, str_perk, str_result, n_slot) {
  self notify(#"specialty_wolf_protector" + "_take");
  assert(isDefined(self.var_7d46fb46), "<dev string:x38>");
  self function_6d80c359();

  if(isDefined(self.var_7d46fb46)) {
    self zm_perks::function_13880aa5(self.var_7d46fb46, 0, #"perk_wolf_protector");
    self.var_7d46fb46 = undefined;
  }
}

on_ai_killed(s_params) {
  player = s_params.eattacker;

  if(isplayer(player) && player hasperk(#"specialty_wolf_protector") && player.var_6577c75d === 0 && player.var_815af0c3 === 0) {
    if(!player.var_669304d0) {
      player.var_841cdb3 = 1;
      player thread function_ce74ad2e();
      player thread function_f3cd6eac();
      return;
    }

    player.var_841cdb3++;
  }
}

on_ai_damaged(s_params) {
  player = s_params.eattacker;

  if(isplayer(player) && player hasperk(#"specialty_wolf_protector") && isDefined(s_params.weapon) && player.var_6577c75d === 0 && player.var_815af0c3 === 0) {
    var_c7364922 = s_params.idamage;

    if(s_params.idamage > self.health) {
      var_c7364922 = self.health;
    }

    if(!player.var_669304d0) {
      player.var_2dc0d63c = var_c7364922;
      player.var_841cdb3 = 0;
      player thread function_ce74ad2e();
      player thread function_f3cd6eac();
      return;
    }

    player.var_2dc0d63c += var_c7364922;
  }
}

on_disconnect() {
  self.var_815af0c3 = 0;

  if(isDefined(self.var_5e8ff98e)) {
    self.var_5e8ff98e val::reset(#"wolf_protector", "takedamage");
    self.var_5e8ff98e clientfield::set("wolf_protector_fx", 0);
    self.var_5e8ff98e playSound(#"hash_55c72512f51a5e87");
    self.var_5e8ff98e thread util::delayed_delete(0.1);
  }
}

function_ce74ad2e() {
  self notify("7c799d117c563854");
  self endon("7c799d117c563854");
  level endon(#"end_game");
  self endon(#"death", #"disconnect", #"wolf_protector_spawn");
  self.var_669304d0 = 1;
  wait 4;

  if(self.var_2dc0d63c <= level.zombie_health * 6 || self.var_841cdb3 <= 6) {
    self.var_669304d0 = 0;
  }
}

function_f3cd6eac() {
  self endon(#"death", #"disconnect");
  self notify("695e9be7c8a2488a");
  self endon("695e9be7c8a2488a");

  while(self.var_669304d0) {
    waitframe(1);

    if((self.var_2dc0d63c >= level.zombie_health * 6 || self.var_841cdb3 >= 6) && !isDefined(self.var_5e8ff98e) && !self scene::is_igc_active()) {

      iprintlnbold("<dev string:x58>");

        self playSound(#"hash_7c5128882f070d07");
      self notify(#"wolf_protector_spawn");
      wait 1.5;

      if(zm_utility::is_player_valid(self, undefined, undefined, undefined, 0) && self hasperk(#"specialty_wolf_protector")) {
        self function_d0c6285a();
      }

      self.var_669304d0 = 0;
    }
  }
}

function_562ade9e() {
  spawn_location = getclosestpointonnavmesh(anglesToForward(self.angles) * 100 + self.origin, 100);

  if(isDefined(spawn_location) && !is_in_playable_space(spawn_location)) {
    spawn_location = function_d5b75a76(spawn_location);
  }

  return spawn_location;
}

function_d0c6285a() {
  self notify("28244f2ad3846403");
  self endon("28244f2ad3846403");
  spawn_pos = function_562ade9e();

  if(!isDefined(spawn_pos)) {

    iprintlnbold("<dev string:x67>");

      return;
  }

  if(!isDefined(self.var_5e8ff98e)) {
    ai = spawnactor(#"spawner_zm_wolf_ally", spawn_pos, self.angles, "wolf_protector", 1);

    if(isDefined(ai)) {
      self.var_815af0c3 = 1;
      ai val::set(#"wolf_protector", "takedamage", 0);
      ai.player_owner = self;
      self.var_5e8ff98e = ai;
      ai clientfield::increment("wolf_protector_spawn_fx");
      ai thread clientfield::set("wolf_protector_fx", 1);
      ai ghost();
      wait 0.6;

      if(isDefined(ai)) {
        ai show();
        ai spawn_shockwave();
        ai playSound(#"evt_wolf_protector_spawn");
        self thread function_163853f(self.var_f7a89869);
        ai thread zm_audio::zmbaivox_notifyconvert();
        ai thread zm_audio::play_ambient_zombie_vocals();
      }
    }
  }
}

spawn_shockwave() {
  a_ai = getaiarray();
  a_aoe_ai = arraysortclosest(a_ai, self.origin, a_ai.size, 0, 200);

  foreach(ai in a_aoe_ai) {
    if(isactor(ai)) {
      ai playSound(#"hash_22ff6701cf652785");
      ai.marked_for_recycle = 1;
      ai.has_been_damaged_by_player = 0;
      ai dodamage(ai.health + 1000, self.origin, self);
    }
  }
}

is_in_playable_space(pos) {
  if(zm_utility::function_21f4ac36() && !isDefined(level.var_a2a9b2de)) {
    level.var_a2a9b2de = getnodearray("player_region", "script_noteworthy");
  }

  if(isDefined(level.var_a2a9b2de)) {
    node = undefined;

    if(isDefined(level.var_61afcb81)) {
      node = function_52c1730(pos, level.var_a2a9b2de, level.var_61afcb81);
    } else {
      node = function_52c1730(pos, level.var_a2a9b2de, 500);
    }

    if(isDefined(node)) {
      return 1;
    }

    return 0;
  }
}

function_d5b75a76(pos) {
  if(!zm_utility::function_21f4ac36() || !isDefined(level.var_a2a9b2de)) {
    return undefined;
  }

  var_1a7af6f3 = arraysortclosest(level.var_a2a9b2de, pos);

  foreach(var_30d9be5a in var_1a7af6f3) {
    if(zm_zonemgr::zone_is_enabled(var_30d9be5a.targetname)) {
      nd_closest = var_30d9be5a;
      break;
    }
  }

  if(!isDefined(nd_closest)) {
    return undefined;
  }

  return nd_closest.origin;
}

function_163853f(var_e31f9259) {
  self endon(#"disconnect", #"specialty_wolf_protector" + "_take");

  if(self hasperk(#"specialty_wolf_protector") && isDefined(self.var_7d46fb46)) {
    self zm_perks::function_f0ac059f(self.var_7d46fb46, self.var_815af0c3, #"perk_wolf_protector");
  }

  self thread function_eb6d99d7(var_e31f9259);
  self waittilltimeout(var_e31f9259, #"scene_igc_shot_started", #"fake_death");
  self function_6d80c359();
}

function_6d80c359() {
  self.var_815af0c3 = 0;

  if(isDefined(self.var_5e8ff98e)) {
    self zm_perks::function_f0ac059f(self.var_7d46fb46, self.var_815af0c3, #"perk_dying_wish");
    self thread function_166fb685(self.var_9a054c95);
    self.var_5e8ff98e val::reset(#"wolf_protector", "takedamage");
    self.var_5e8ff98e clientfield::set("wolf_protector_fx", 0);
    self.var_5e8ff98e playSound(#"hash_55c72512f51a5e87");
    self.var_5e8ff98e thread util::delayed_delete(0.1);
  }
}

function_eb6d99d7(var_1483b30b) {
  self endon(#"disconnect", #"specialty_wolf_protector" + "_take", #"scene_igc_shot_started");
  n_time_left = var_1483b30b;
  self zm_perks::function_13880aa5(self.var_7d46fb46, 1, #"perk_wolf_protector");

  while(n_time_left > 0) {
    wait 0.1;
    n_time_left -= 0.1;
    n_time_left = math::clamp(n_time_left, 0, var_1483b30b);
    n_percentage = n_time_left / var_1483b30b;
    n_percentage = math::clamp(n_percentage, 0.02, var_1483b30b);

    if(self hasperk(#"specialty_wolf_protector") && isDefined(self.var_7d46fb46)) {
      self zm_perks::function_13880aa5(self.var_7d46fb46, n_percentage, #"perk_wolf_protector");
    }
  }
}

function_166fb685(var_85dcb56c) {
  self endon(#"hash_7c5d9af32e10c147", #"disconnect");
  self.var_6577c75d = 1;

  if(self hasperk(#"specialty_wolf_protector") && isDefined(self.var_7d46fb46)) {
    self zm_perks::function_2ac7579(self.var_7d46fb46, 2, #"perk_wolf_protector");
  }

  self thread function_7d72c6f9(var_85dcb56c);
  wait var_85dcb56c;
  self thread reset_cooldown();
}

function_7d72c6f9(var_85dcb56c) {
  self endon(#"disconnect", #"hash_7c5d9af32e10c147");
  self.var_72c60d5 = var_85dcb56c;
  self zm_perks::function_13880aa5(self.var_7d46fb46, 0, #"perk_wolf_protector");

  while(true) {
    wait 0.1;
    self.var_72c60d5 -= 0.1;
    self.var_72c60d5 = math::clamp(self.var_72c60d5, 0, var_85dcb56c);
    n_percentage = 1 - self.var_72c60d5 / var_85dcb56c;
    n_percentage = math::clamp(n_percentage, 0.02, var_85dcb56c);

    if(self hasperk(#"specialty_wolf_protector") && isDefined(self.var_7d46fb46)) {
      self zm_perks::function_13880aa5(self.var_7d46fb46, n_percentage, #"perk_wolf_protector");
    }
  }
}

reset_cooldown() {
  self notify(#"hash_7c5d9af32e10c147");
  self.var_6577c75d = 0;

  if(self hasperk(#"specialty_wolf_protector")) {
    assert(isDefined(self.var_7d46fb46), "<dev string:x38>");

    if(isDefined(self.var_7d46fb46)) {
      self zm_perks::function_2ac7579(self.var_7d46fb46, 1, #"perk_wolf_protector");
      self zm_perks::function_13880aa5(self.var_7d46fb46, 1, #"perk_wolf_protector");
    }
  }
}