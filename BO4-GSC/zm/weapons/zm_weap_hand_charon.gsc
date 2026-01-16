/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_hand_charon.gsc
***********************************************/

#include script_24c32478acf44108;
#include scripts\abilities\ability_player;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\throttle_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_lightning_chain;
#include scripts\zm_common\callbacks;
#include scripts\zm_common\zm_armor;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_net;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_transformation;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_hand_charon;

autoexec __init__system__() {
  system::register(#"zm_weap_hand_charon", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "charon_pool", 16000, 1, "int");
  clientfield::register("scriptmover", "charon_shoot", 16000, 1, "counter");
  clientfield::register("scriptmover", "" + #"charon_impact", 16000, 2, "int");
  clientfield::register("allplayers", "charon_flash", 16000, 1, "int");
  clientfield::register("actor", "" + #"charon_death", 16000, 1, "counter");
  clientfield::register("actor", "" + #"charon_zombie_impact", 16000, 1, "counter");
  clientfield::register("actor", "" + #"charon_pool_victim", 16000, 1, "int");
  level.w_hand_charon = getweapon(#"ww_hand_c");
  level.w_hand_charon_charged = getweapon(#"ww_hand_c_charged");
  level.w_hand_charon_uncharged = getweapon(#"ww_hand_c_uncharged");
  level.w_hand_charon_upgraded = getweapon(#"ww_hand_c_upgraded");
  zm_weapons::include_zombie_weapon(#"ww_hand_c", 0);
  zm_weapons::include_zombie_weapon(#"ww_hand_c_charged", 0);
  zm_weapons::include_zombie_weapon(#"ww_hand_c_uncharged", 0);
  zm_weapons::include_zombie_weapon(#"ww_hand_c_upgraded", 0);
  namespace_9ff9f642::register_slowdown(#"charon_slowdown_time", 0.7, 3);
  namespace_9ff9f642::register_slowdown(#"charon_dissolve_time", 0.3, 1);

  if(!isDefined(level.var_844d377c)) {
    level.var_844d377c = new throttle();
    [[level.var_844d377c]] - > initialize(6, 0.1);
  }

  callback::add_weapon_fired(level.w_hand_charon, &function_10b4d6ac);
  callback::add_weapon_fired(level.w_hand_charon_charged, &function_dd7bc108);
  callback::add_weapon_fired(level.w_hand_charon_uncharged, &function_10b4d6ac);
  callback::add_weapon_fired(level.w_hand_charon_upgraded, &function_10b4d6ac);
  level.var_5cf3f4a2 = [];
  level.var_d260634e = [];
  level.n_dragged = 0;
}

on_player_connect() {
  self thread function_3f8da82c();
}

function_3f8da82c() {
  self endon(#"disconnect");

  while(true) {
    s_notify = self waittill(#"weapon_change");

    if(s_notify.weapon === level.w_hand_charon_uncharged) {
      self zm_hero_weapon::show_hint(level.w_hand_charon, #"hash_3ce2314ad3d39939");
    }
  }
}

function_10b4d6ac(weapon) {
  self endon(#"death");

  if(weapon == level.w_hand_charon_upgraded) {
    n_damage = 8500;
    b_up = 1;
  } else {
    n_damage = 5000;
    b_up = 0;
  }

  self clientfield::set("charon_flash", 1);
  a_e_targets = function_b04434cf(b_up);

  if(isDefined(a_e_targets)) {
    if(isDefined(a_e_targets[0]) && a_e_targets[0].zm_ai_category === #"boss") {
      n_proj = 3;
    } else if(!a_e_targets.size || a_e_targets.size === 1 && !isactor(a_e_targets[0])) {
      n_proj = 1;
    } else {
      n_proj = 3;
    }
  }

  for(i = 0; i < n_proj; i++) {
    e_projectile = util::spawn_model("tag_origin", self gettagorigin("tag_flash"), self gettagangles("tag_flash"));

    if(isDefined(e_projectile)) {
      e_projectile thread set_projectile(i);

      if(isDefined(a_e_targets) && isDefined(a_e_targets[i])) {
        self thread function_26819e32(e_projectile, a_e_targets[i], n_damage);
      } else if(i == 1 && isDefined(a_e_targets[i - 1])) {
        self thread function_26819e32(e_projectile, a_e_targets[i - 1], n_damage);
      } else if(i == 2) {
        if(isDefined(a_e_targets[i - 1])) {
          self thread function_26819e32(e_projectile, a_e_targets[i - 1], n_damage);
        } else if(isDefined(a_e_targets[i - 2])) {
          self thread function_26819e32(e_projectile, a_e_targets[i - 2], n_damage);
        }
      } else {
        self thread function_26819e32(e_projectile);
      }
    }

    wait 0.1;
  }
}

function_b04434cf(b_up) {
  if(b_up) {
    n_range = 3000;
  } else {
    n_range = 2150;
  }

  view_pos = self getEye();
  forward_view_angles = anglesToForward(self getplayerangles());

  if(forward_view_angles[2] < -0.7) {
    var_ccb70dad = vectornormalize((forward_view_angles[0], forward_view_angles[1], -0.25));
  } else {
    var_ccb70dad = vectornormalize(forward_view_angles);
  }

  a_e_targets = function_3874b38f();
  a_e_valid = [];

  foreach(e_target in a_e_targets) {
    if(self is_valid_target(e_target, n_range)) {
      a_e_valid[a_e_valid.size] = e_target;
    }
  }

  a_e_valid = array::get_all_closest(self.origin, a_e_valid);
  a_e_priority = [];

  foreach(e_target in a_e_valid) {
    if(isDefined(e_target.var_564012c4) && e_target.var_564012c4) {
      if(!isDefined(a_e_priority)) {
        a_e_priority = [];
      } else if(!isarray(a_e_priority)) {
        a_e_priority = array(a_e_priority);
      }

      a_e_priority[a_e_priority.size] = e_target;
    }
  }

  foreach(e_target in a_e_priority) {
    arrayremovevalue(a_e_valid, e_target);
    array::push_front(a_e_valid, e_target);
  }

  var_99588c0f = function_3ebebb9c();

  if(isDefined(var_99588c0f)) {
    var_99588c0f = array::remove_undefined(var_99588c0f);
    var_99588c0f = arraysortclosest(var_99588c0f, self.origin);

    foreach(e_target in var_99588c0f) {
      if(!self zm_utility::is_player_looking_at(e_target getcentroid(), 0.9, 0, self) && !self zm_utility::is_player_looking_at(e_target.origin, 0.9, 0, self)) {
        continue;
      }

      if(distance2dsquared(self.origin, e_target.origin) > n_range * n_range) {
        continue;
      }

      array::push_front(a_e_valid, e_target);
    }
  }

  var_465b9157 = function_b9a3e6f9();

  if(isDefined(var_465b9157)) {
    var_465b9157 = array::remove_undefined(var_465b9157);
    var_465b9157 = arraysortclosest(var_465b9157, self.origin);

    foreach(e_target in var_465b9157) {
      if(!self zm_utility::is_player_looking_at(e_target.origin, 0.9, 1, self)) {
        continue;
      }

      if(distance2dsquared(self.origin, e_target.origin) > n_range * n_range) {
        continue;
      }

      e_target.var_3df1a748 = 1;
      array::push_front(a_e_valid, e_target);
    }
  }

  return a_e_valid;
}

is_valid_target(e_target, n_range) {
  if(zm_utility::is_magic_bullet_shield_enabled(e_target)) {
    return false;
  }

  if(isDefined(e_target.var_2e4247bc) && e_target.var_2e4247bc || isDefined(e_target.var_f9b38410) && e_target.var_f9b38410) {
    return false;
  }

  if(isDefined(e_target.var_131a4fb0) && e_target.var_131a4fb0) {
    return false;
  }

  if(distance2dsquared(self.origin, e_target.origin) <= 64 * 64 && (self zm_utility::is_player_looking_at(e_target getcentroid(), 0.3, 1, self) || self zm_utility::is_player_looking_at(e_target getcentroid() + (0, 0, 32), 0.3, 1, self))) {
    return true;
  }

  if(isDefined(e_target.fake_death) && e_target.fake_death) {
    return false;
  }

  if(!isalive(e_target)) {
    return false;
  }

  if(distance2dsquared(self.origin, e_target.origin) > n_range * n_range) {
    return false;
  }

  var_c060d2c8 = !(isDefined(level.var_58f509b6) && level.var_58f509b6);

  if(!self zm_utility::is_player_looking_at(e_target getcentroid(), 0.9, var_c060d2c8, self) && !self zm_utility::is_player_looking_at(e_target.origin, 0.9, var_c060d2c8, self) && !self zm_utility::is_player_looking_at(e_target getcentroid() + (0, 0, 28), 0.9, var_c060d2c8, self)) {
    return false;
  }

  return true;
}

set_projectile(n_index) {
  self endon(#"death");
  self.n_index = n_index;
  wait 0.1;
  self clientfield::increment("charon_shoot");
}

function_26819e32(e_projectile, ai_zombie, n_damage) {
  e_projectile endon(#"death");
  self endon(#"disconnect");

  if(isDefined(ai_zombie)) {
    ai_zombie.var_131a4fb0 = 1;
  }

  e_projectile thread projectile_timeout();
  v_end = self function_247597a();
  n_dist = distance(e_projectile.origin, v_end);
  n_time = n_dist / 1500;

  if(n_time <= 0.1) {
    n_time = 0.1;
  }

  if(!isDefined(ai_zombie) || isDefined(ai_zombie.var_3df1a748) && ai_zombie.var_3df1a748) {
    e_projectile moveto(v_end, n_time);
    e_projectile waittill(#"movedone");
    e_projectile clientfield::set("" + #"charon_impact", 1);
    waitframe(1);
  } else {
    var_2ed6f142 = self getweaponmuzzlepoint();
    v_forward = self getweaponforwarddir();
    v_end = var_2ed6f142 + v_forward * 200;
    n_dist_sq = distance2dsquared(self.origin, v_end);

    if(isDefined(ai_zombie) && distance2dsquared(e_projectile.origin, ai_zombie.origin) <= n_dist_sq) {
      n_dist = distance(e_projectile.origin, ai_zombie.origin);
      n_time = n_dist / 1500;

      if(n_time <= 0.1) {
        n_time = 0.1;
      }

      if(isDefined(ai_zombie)) {
        e_projectile moveto(ai_zombie getcentroid(), n_time);
        wait n_time - 0.05;
      }
    } else if(isDefined(ai_zombie)) {
      var_4d8b7233 = 0;
      var_14dcf3ed = 0;
      v_org = function_30239376(ai_zombie);
      n_dist = distance(self.origin, v_org);
      var_7fd007f9 = n_dist * 0.5;
      v_end = var_2ed6f142 + v_forward * 100;
      var_a93a9211 = distance(self.origin, v_end);
      v_right = var_2ed6f142 + anglestoup(self.angles) * 50;
      v_right_end = v_right + v_forward * 100;
      v_left = var_2ed6f142 - anglestoup(self.angles) * 50;
      v_left_end = v_left + v_forward * 100;
      n_time = var_a93a9211 / 1500;

      if(n_time <= 0.1) {
        n_time = 0.1;
      }

      if(e_projectile.n_index === 1) {
        e_projectile moveto(v_right_end, n_time);
      } else if(e_projectile.n_index === 2) {
        e_projectile moveto(v_left_end, n_time);
      } else {
        e_projectile moveto(v_end, n_time);
      }

      wait n_time - 0.05;

      if(isDefined(ai_zombie) && ai_zombie.zm_ai_category === #"boss") {
        if(isDefined(ai_zombie gettagorigin("j_tail_1"))) {
          n_hit_dist_sq = 2500;
        } else {
          n_hit_dist_sq = 400;
        }
      } else {
        n_hit_dist_sq = 400;
      }

      while(isDefined(ai_zombie)) {
        v_target = function_30239376(ai_zombie);
        n_dist = distance(e_projectile.origin, v_target);

        if(n_dist > var_7fd007f9) {
          var_4d8b7233 += 20;

          if(e_projectile.n_index === 1) {
            v_horz = v_target + anglestoright(ai_zombie.angles) * 100;
          } else if(e_projectile.n_index === 2) {
            v_horz = v_target - anglestoright(ai_zombie.angles) * 100;
          } else {
            v_horz = v_target;
          }

          if(isDefined(v_horz)) {
            v_end = v_horz + (0, 0, var_4d8b7233);
          }
        } else {
          var_4d8b7233 -= 20;

          if(isDefined(v_target)) {
            v_end = v_target + (0, 0, var_4d8b7233);

            if(v_end[2] < v_target[2] + 8) {
              v_end = v_target + (0, 0, 8);
            }
          }
        }

        n_time = n_dist / 1500;

        if(n_time <= 0.1) {
          n_time = 0.1;
        }

        if(isDefined(v_end) && isDefined(ai_zombie)) {
          e_projectile moveto(v_end, n_time);
        }

        waitframe(1);
        var_dc65d1c = distance2dsquared(e_projectile.origin, v_end);

        if(var_dc65d1c <= n_hit_dist_sq) {
          break;
        }
      }
    }
  }

  if(isDefined(ai_zombie)) {
    if(isDefined(ai_zombie gettagorigin("j_spine4"))) {
      v_end = function_30239376(ai_zombie);
    }
  }

  if(isDefined(v_end)) {
    e_projectile moveto(v_end, 0.05);
    e_projectile waittill(#"movedone");
  }

  if(isalive(ai_zombie) || isDefined(ai_zombie) && ai_zombie.zm_ai_category === #"boss") {
    if(isDefined(level.var_2f926dcc)) {
      self thread[[level.var_2f926dcc]](ai_zombie, level.w_hand_charon_uncharged);
    } else {
      self thread function_dced5aef(ai_zombie, level.w_hand_charon_uncharged, undefined, n_damage);
    }
  }

  waitframe(1);
  e_projectile delete();
}

function_30239376(e_target) {
  if(isDefined(e_target) && e_target.zm_ai_category === #"boss") {
    if(isDefined(e_target gettagorigin("j_tail_1"))) {
      v_org = e_target gettagorigin("j_tail_1");
    } else if(isDefined(e_target gettagorigin("j_spine4"))) {
      v_org = e_target gettagorigin("j_spine4");
    } else {
      v_org = e_target getcentroid();
    }
  } else if(isDefined(e_target gettagorigin("j_spine4"))) {
    v_org = e_target gettagorigin("j_spine4");
  } else {
    v_org = e_target.origin;
  }

  return v_org;
}

projectile_timeout() {
  self endon(#"death");
  wait 5;
  self delete();
}

function_dced5aef(e_target, weapon = level.weaponnone, v_to_target, n_damage) {
  self endon(#"death");
  e_target endon(#"death");

  if(isactor(e_target) && zm_utility::is_magic_bullet_shield_enabled(e_target)) {
    return;
  }

  if(isDefined(e_target) && isDefined(e_target.zm_ai_category)) {
    [[level.var_844d377c]] - > waitinqueue(e_target);

    switch (e_target.zm_ai_category) {
      case #"popcorn":
      case #"basic":
      case #"enhanced":
        if(isDefined(level.var_14f649ad) && level.var_14f649ad) {
          n_damage = e_target.health + 666;
        }

        if(n_damage >= e_target.health) {
          e_target.var_131a4fb0 = 1;
        }

        if(e_target.archetype === #"skeleton") {
          e_target dodamage(n_damage, e_target.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon);
        } else if(isDefined(e_target.var_131a4fb0) && e_target.var_131a4fb0) {
          self thread function_197896ad(e_target, n_damage);
        } else {
          e_target dodamage(n_damage, e_target.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon);
        }

        break;
      case #"heavy":
        e_target dodamage(n_damage, e_target.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon);
        break;
      case #"miniboss":
        e_target clientfield::increment("" + #"charon_zombie_impact");
        n_damage = int(n_damage * 0.3);
        e_target dodamage(n_damage, e_target.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon);

        if(randomint(10) == 0) {
          e_target thread ai::stun();
        }

        if(isDefined(e_target)) {
          e_target.var_131a4fb0 = 0;
        }

        break;
      case #"boss":
        if(!isactor(e_target)) {
          e_target clientfield::set("" + #"charon_impact", 1);
        }

        n_damage = 175;
        e_target dodamage(n_damage, e_target.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon);

        if(isDefined(e_target)) {
          e_target.var_131a4fb0 = 0;
        }

        break;
    }

    return;
  }

  e_target dodamage(n_damage, e_target.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon);
}

function_247597a(b_charged) {
  var_2ed6f142 = self getweaponmuzzlepoint();
  v_forward = self getweaponforwarddir();
  v_end = var_2ed6f142 + v_forward * 10000;
  a_trace = bulletTrace(var_2ed6f142, v_end, 1, self);

  if(isDefined(level.var_4822b326)) {
    level notify(#"ww_charon_hit", {
      #player: self, 
      #e_entity: a_trace[#"entity"]
    });
  }

  if(isDefined(b_charged) && b_charged) {
    return a_trace;
  }

  return a_trace[#"position"];
}

function_dd7bc108(weapon) {
  self endon(#"disconnect", #"weapon_change");

  if(self.currentweapon === level.w_hand_charon_upgraded) {
    n_damage = 8500;
  } else {
    n_damage = 5000;
  }

  self clientfield::set("charon_flash", 1);
  n_inc = 100;
  v_org = self.origin;

  if(self.currentweapon === level.w_hand_charon_upgraded) {
    n_ammo = self getweaponammoclip(level.w_hand_charon_upgraded);
  } else {
    n_ammo = self getweaponammoclip(level.w_hand_charon);
  }

  if(n_ammo >= 2) {
    n_ammo -= 2;
  }

  if(self.currentweapon === level.w_hand_charon_upgraded) {
    self setweaponammoclip(level.w_hand_charon_upgraded, n_ammo);
  } else {
    self setweaponammoclip(level.w_hand_charon, n_ammo);
  }

  a_trace = function_247597a(1);

  if(!isDefined(a_trace[#"position"]) && !isDefined(a_trace[#"entity"])) {
    return;
  }

  if(isDefined(a_trace[#"entity"])) {
    v_on_nav = a_trace[#"entity"].origin;

    if(isDefined(a_trace[#"position"])) {
      v_hit = a_trace[#"position"];
    }
  } else {
    v_on_nav = getclosestpointonnavmesh(a_trace[#"position"], 128, 32);

    if(isDefined(v_on_nav)) {
      v_hit = v_on_nav;
    } else {
      v_hit = a_trace[#"position"];
    }
  }

  e_projectile = util::spawn_model("tag_origin", self gettagorigin("tag_flash"), self gettagangles("tag_flash"));

  if(isDefined(e_projectile)) {
    e_projectile function_39e6dc29(a_trace[#"position"]);
    wait 0.1;
  }

  if(isDefined(v_on_nav)) {
    var_330f37da = v_on_nav;
  } else {
    return;
  }

  if(isDefined(self.mdl_aoe)) {
    self.mdl_aoe delete();
    self.mdl_aoe zm_utility::deactivate_zombie_point_of_interest();
  }

  if(isDefined(self.var_b1224954)) {
    self.var_b1224954 delete();
  }

  self.mdl_aoe = util::spawn_model("tag_origin", var_330f37da, (-90, 0, 0));

  if(isDefined(self.mdl_aoe)) {
    self.var_b1224954 = spawn("trigger_radius_new", var_330f37da, 512 | 1, 100, 60);

    if(isDefined(self.var_b1224954)) {
      self thread charon_pool(n_damage);
    } else {
      self.mdl_aoe delete();
      self.mdl_aoe zm_utility::deactivate_zombie_point_of_interest();
    }
  }

  wait 0.1;
  self clientfield::set("charon_flash", 0);
}

function_39e6dc29(v_end) {
  self endon(#"death");
  self thread set_projectile(0);
  n_dist = distance(self.origin, v_end);
  n_time = n_dist / 1500;

  if(n_time <= 0.1) {
    n_time = 0.1;
  }

  self moveto(v_end, n_time);
  self waittill(#"movedone");
  self clientfield::set("" + #"charon_impact", 2);
  wait 0.1;
  self delete();
}

charon_pool(n_damage) {
  if(isDefined(self.var_b1224954)) {
    var_49981df5 = self.var_b1224954;
    var_49981df5 endon(#"death");
  }

  if(isDefined(self) && isDefined(self.mdl_aoe)) {
    mdl_aoe = self.mdl_aoe;
    mdl_aoe clientfield::set("charon_pool", 1);
    mdl_aoe zm_utility::create_zombie_point_of_interest(200, 16, 1000);
    mdl_aoe zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, undefined, 100, 1);
    mdl_aoe.var_8305fd51 = #"charon_pool";
    self thread function_249b5556(n_damage);
    self notify(#"hash_52d2f17ac6d67de2");

    if(n_damage == 5000) {
      wait 15;
    } else {
      wait 22;
    }

    if(isDefined(mdl_aoe)) {
      mdl_aoe zm_utility::deactivate_zombie_point_of_interest();
      mdl_aoe clientfield::set("charon_pool", 0);
      mdl_aoe delete();
    }

    if(isDefined(var_49981df5)) {
      var_49981df5 delete();
    }
  }
}

function_249b5556(n_damage) {
  self endon(#"death");
  self.var_b1224954 endon(#"death");

  while(true) {
    s_result = self.var_b1224954 waittill(#"trigger");

    if(isDefined(s_result.activator)) {
      if(!isplayer(s_result.activator)) {
        ai_zombie = s_result.activator;

        if(!isalive(ai_zombie)) {
          continue;
        }

        if(!isDefined(ai_zombie.zm_ai_category)) {
          continue;
        }

        if(isDefined(ai_zombie.var_2e4247bc) && ai_zombie.var_2e4247bc || isDefined(ai_zombie.var_339655cf) && ai_zombie.var_339655cf) {
          continue;
        }

        if(isDefined(ai_zombie.var_69a981e6) && ai_zombie.var_69a981e6) {
          continue;
        }

        if(!(isDefined(ai_zombie.var_47d982a1) && ai_zombie.var_47d982a1) && isalive(ai_zombie)) {
          zm_transform::function_5db4f2f5(ai_zombie);
          [
            [level.var_844d377c]
          ] - > waitinqueue(ai_zombie);

          if(!isDefined(ai_zombie)) {
            continue;
          }

          switch (ai_zombie.zm_ai_category) {
            case #"popcorn":
            case #"basic":
            case #"enhanced":
              ai_zombie.var_47d982a1 = 1;
              ai_zombie thread function_ccd87945(self);
              ai_zombie thread namespace_9ff9f642::slowdown(#"charon_slowdown_time");
              break;
            case #"heavy":
              ai_zombie.var_47d982a1 = 1;
              self thread charon_slow(ai_zombie, n_damage);
              ai_zombie thread function_da454404();
              break;
            case #"miniboss":
              ai_zombie.var_47d982a1 = 1;
              self thread charon_slow(ai_zombie, n_damage);
              ai_zombie thread function_da454404();
              break;
          }
        }

        continue;
      }

      self notify(#"hash_288cb56263c7b7fa");
    }
  }
}

function_ccd87945(e_player) {
  self endon(#"death");
  e_player endon(#"death");

  if(isDefined(e_player.var_b1224954)) {
    if(!isDefined(e_player.var_b1224954.n_dragged)) {
      e_player.var_b1224954.n_dragged = 0;
    }

    e_player.var_b1224954.n_dragged++;
    e_player notify(#"hash_175b1370e662293a", {
      #var_b1224954: e_player.var_b1224954
    });
  }

  wait randomfloatrange(0.5, 1.5);
  self.e_attacker = e_player;

  if(isDefined(level.var_50ce2afd)) {
    e_player thread[[level.var_50ce2afd]]();
  }

  if(level.n_dragged < 5) {
    level.n_dragged++;
    self thread function_31d8c58();
    return;
  }

  if(isDefined(e_player) && isalive(self)) {
    self dodamage(self.health + 999, self.origin, e_player, e_player, undefined, "MOD_UNKNOWN", 0, level.w_hand_charon);
  }
}

function_31d8c58() {
  self endon(#"death");
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.allowdeath = 0;
  self.no_gib = 1;
  self.b_ignore_cleanup = 1;
  self.no_powerups = 1;
  self.var_131a4fb0 = 1;
  self notsolid();
  self clientfield::set("" + #"charon_pool_victim", 1);
  var_f9d1df1d = vectornormalize(anglesToForward(self.angles));
  mdl_tag = util::spawn_model("tag_origin", self.origin, self.angles);
  mdl_tag.var_58b95 = util::spawn_model("tag_origin", anglestoright(self.angles) * 8 + self.origin + var_f9d1df1d * 6, self.angles + (0, -90, 0));
  mdl_tag.var_31436e10 = util::spawn_model("tag_origin", anglestoright(self.angles) * -6 + self.origin + var_f9d1df1d * 6, self.angles + (0, 90, 0));

  if(isDefined(mdl_tag)) {
    mdl_tag thread scene::play(#"aib_vign_cust_zm_red_zmb_ww_drggd_dwn_00", self);
    mdl_tag thread function_8a38ce84();
  }

  if(isDefined(mdl_tag.var_58b95)) {
    mdl_tag.var_58b95 thread scene::play(#"hash_1cfca52bdf13d5bf" + randomint(3));
  }

  if(isDefined(mdl_tag.var_31436e10)) {
    mdl_tag.var_31436e10 thread scene::play(#"hash_1cfca52bdf13d5bf" + randomint(3));
  }

  level.n_dragged--;

  if(level.n_dragged < 0) {
    level.n_dragged = 0;
  }

  wait 3;

  if(isDefined(self)) {
    self.allowdeath = 1;
    self.skipdeath = 1;
    self.diedinscriptedanim = 1;
    self ghost();

    if(self.archetype === #"skeleton") {
      self dodamage(self.health + 999, mdl_tag.origin, self.e_attacker, self.e_attacker, undefined, "MOD_UNKNOWN", 0, level.w_hand_charon);
    } else {
      self dodamage(self.health + 100, mdl_tag.origin, self.e_attacker, self.e_attacker, undefined, "MOD_UNKNOWN", 0, level.w_hand_charon);
    }

    wait 0.5;

    if(isalive(self)) {
      self show();
    }
  }
}

function_8a38ce84() {
  wait 3.8;

  if(isDefined(self.var_58b95)) {
    self.var_58b95 delete();
  }

  if(isDefined(self.var_31436e10)) {
    self.var_31436e10 delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

function_197896ad(e_target, n_damage) {
  self endon(#"death");

  if(!(isDefined(e_target.var_61768419) && e_target.var_61768419)) {
    e_target.var_61768419 = 1;

    if(e_target.health <= n_damage) {
      e_target clientfield::increment("" + #"charon_death");
      e_target.skipdeath = 1;
      e_target.diedinscriptedanim = 1;
      n_damage = e_target.health + 999;
    } else {
      n_damage = n_damage;
    }

    [[level.var_844d377c]] - > waitinqueue(e_target);
    e_target clientfield::increment("" + #"charon_zombie_impact");
    e_target ai::stun(3);
    wait 0.8;

    if(isDefined(e_target)) {
      e_target thread namespace_9ff9f642::slowdown(#"charon_slowdown_time");
    }

    wait 0.7;

    if(isDefined(e_target)) {
      e_target thread namespace_9ff9f642::slowdown(#"charon_dissolve_time");
    }

    wait 1;

    if(isalive(e_target)) {
      if(isDefined(e_target.skipdeath) && e_target.skipdeath) {
        e_target hide();
      }

      if(e_target.archetype === #"skeleton") {
        e_target dodamage(n_damage, self.origin, self, self, "none", "MOD_UNKNOWN", 0, level.w_hand_charon_uncharged);
      } else {
        e_target dodamage(n_damage, e_target.origin, self, self, "none", "MOD_UNKNOWN", 0, level.w_hand_charon_uncharged);
      }
    }

    wait 0.1;

    if(isDefined(e_target)) {
      e_target.var_131a4fb0 = 0;
      e_target.var_61768419 = 0;
    }

    wait 0.5;

    if(isalive(e_target)) {
      e_target show();
    }
  }
}

charon_slow(e_target, n_damage) {
  self endon(#"death");
  e_target endon(#"death");
  e_target.var_317b8f00 = 1;
  e_target thread namespace_9ff9f642::slowdown(#"charon_slowdown_time");

  while(isDefined(self.var_b1224954) && isDefined(e_target.var_317b8f00) && e_target.var_317b8f00) {
    e_target dodamage(n_damage, e_target.origin, self, self, "none", "MOD_UNKNOWN", 0, level.w_hand_charon);

    if(randomint(6) == 0) {
      e_target thread ai::stun(1);
    }

    wait 2;
  }

  e_target thread namespace_9ff9f642::function_520f4da5(#"charon_slowdown_time");
}

function_da454404() {
  self endon(#"death");
  wait 3;

  if(isDefined(self) && isDefined(self.var_47d982a1) && self.var_47d982a1) {
    self.var_47d982a1 = 0;
    self.var_317b8f00 = 0;
  }
}

function_3874b38f() {
  var_72714481 = getaiteamarray("axis");
  return var_72714481;
}

function_5fc81f0a(e_target) {
  if(!isDefined(level.var_5cf3f4a2)) {
    level.var_5cf3f4a2 = [];
  } else if(!isarray(level.var_5cf3f4a2)) {
    level.var_5cf3f4a2 = array(level.var_5cf3f4a2);
  }

  if(!isinarray(level.var_5cf3f4a2, e_target)) {
    level.var_5cf3f4a2[level.var_5cf3f4a2.size] = e_target;
  }
}

function_6d783edd(e_target) {
  arrayremovevalue(level.var_5cf3f4a2, e_target);
}

function_3ebebb9c() {
  return level.var_5cf3f4a2;
}

function_25513188(e_target) {
  if(!isDefined(level.var_d260634e)) {
    level.var_d260634e = [];
  } else if(!isarray(level.var_d260634e)) {
    level.var_d260634e = array(level.var_d260634e);
  }

  if(!isinarray(level.var_d260634e, e_target)) {
    level.var_d260634e[level.var_d260634e.size] = e_target;
  }
}

function_5760b289(e_target) {
  arrayremovevalue(level.var_d260634e, e_target);
}

function_b9a3e6f9() {
  return level.var_d260634e;
}