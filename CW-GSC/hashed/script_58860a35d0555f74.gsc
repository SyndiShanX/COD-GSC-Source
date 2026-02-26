/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_58860a35d0555f74.gsc
***********************************************/

#using script_176597095ddfaa17;
#using script_72401f526ba71638;
#using scripts\core_common\ai_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#namespace namespace_1fd59e39;

function private autoexec __init__system__() {
  system::register(#"hash_7fd3c8de50685459", &preinit, undefined, undefined, #"hash_13a43d760497b54d");
}

function private preinit() {
  level.var_ff7ae671 = [];
  level.var_f3346ffc = [];
  clientfield::register("allplayers", "" + # "hash_59400ab6cbfaec5d", 1, 1, "int");
  callback::on_spawned(&on_spawned);
  namespace_1b527536::function_36e0540e(#"aether_shroud", 1, 45, "field_upgrade_aether_shroud_item_sr");
  namespace_1b527536::function_36e0540e(#"aether_shroud_1", 1, 45, "field_upgrade_aether_shroud_1_item_sr");
  namespace_1b527536::function_36e0540e(#"aether_shroud_2", 1, 45, "field_upgrade_aether_shroud_2_item_sr");
  namespace_1b527536::function_36e0540e(#"aether_shroud_3", 1, 45, "field_upgrade_aether_shroud_3_item_sr");
  namespace_1b527536::function_36e0540e(#"aether_shroud_4", 1, 45, "field_upgrade_aether_shroud_4_item_sr");
  namespace_1b527536::function_36e0540e(#"aether_shroud_5", 2, 45, "field_upgrade_aether_shroud_5_item_sr");
  namespace_1b527536::function_dbd391bf(#"aether_shroud", &function_84c43da8);
  namespace_1b527536::function_dbd391bf(#"aether_shroud_1", &function_84c43da8);
  namespace_1b527536::function_dbd391bf(#"aether_shroud_2", &function_84c43da8);
  namespace_1b527536::function_dbd391bf(#"aether_shroud_3", &function_84c43da8);
  namespace_1b527536::function_dbd391bf(#"aether_shroud_4", &function_84c43da8);
  namespace_1b527536::function_dbd391bf(#"aether_shroud_5", &function_84c43da8);
  level.var_e163165b = [#"ww_ieu_electric_t9"];

  level thread function_e41cc86b();
}

function function_1376ec37(v_position, n_radius, var_faa5f280) {
  var_f740b763 = {
    #v_position: v_position, #n_radius: n_radius, #var_faa5f280: var_faa5f280
  };

  if(!isDefined(level.var_ff7ae671)) {
    level.var_ff7ae671 = [];
  } else if(!isarray(level.var_ff7ae671)) {
    level.var_ff7ae671 = array(level.var_ff7ae671);
  }

  if(!isinarray(level.var_ff7ae671, var_f740b763)) {
    level.var_ff7ae671[level.var_ff7ae671.size] = var_f740b763;
  }
}

function function_be3960b8(var_faa5f280) {
  if(isarray(level.var_ff7ae671)) {
    var_a40ff4f = [];

    foreach(var_f740b763 in level.var_ff7ae671) {
      if(var_f740b763.var_faa5f280 === var_faa5f280) {
        if(!isDefined(var_a40ff4f)) {
          var_a40ff4f = [];
        } else if(!isarray(var_a40ff4f)) {
          var_a40ff4f = array(var_a40ff4f);
        }

        var_a40ff4f[var_a40ff4f.size] = var_f740b763;
      }
    }

    foreach(var_afea3d3b in var_a40ff4f) {
      arrayremovevalue(level.var_ff7ae671, var_afea3d3b);
    }
  }
}

function function_4a05e25f(vol_forced) {
  if(isstring(vol_forced)) {
    vol_forced = getent(vol_forced, "targetname");
  }

  if(isentity(vol_forced)) {
    if(!isDefined(level.var_f3346ffc)) {
      level.var_f3346ffc = [];
    } else if(!isarray(level.var_f3346ffc)) {
      level.var_f3346ffc = array(level.var_f3346ffc);
    }

    if(!isinarray(level.var_f3346ffc, vol_forced)) {
      level.var_f3346ffc[level.var_f3346ffc.size] = vol_forced;
    }
  }
}

function function_faa74262(vol_forced) {
  if(isstring(vol_forced)) {
    vol_forced = getent(vol_forced, "targetname");
  }

  if(isentity(vol_forced)) {
    arrayremovevalue(level.var_f3346ffc, vol_forced);
  }
}

function private function_83407b23(v_destination) {
  foreach(var_f740b763 in level.var_ff7ae671) {
    if(isDefined(var_f740b763.v_position) && isDefined(var_f740b763.n_radius)) {
      if(distancesquared(v_destination, var_f740b763.v_position) <= sqr(var_f740b763.n_radius)) {
        return true;
      }
    }

    if(isstring(var_f740b763.var_faa5f280)) {
      var_5ea34012 = getEntArray(var_f740b763.var_faa5f280, "targetname");

      foreach(var_9efd28d0 in var_5ea34012) {
        if(istouching(v_destination, var_9efd28d0)) {
          return true;
        }
      }
    }
  }

  arrayremovevalue(level.var_f3346ffc, undefined);

  if(level.var_f3346ffc.size > 0) {
    foreach(vol_forced in level.var_f3346ffc) {
      if(istouching(v_destination, vol_forced)) {
        return false;
      }
    }

    return true;
  }

  return false;
}

function private function_e41cc86b() {
  self notify("<dev string:x38>");
  self endon("<dev string:x38>");

  while(true) {
    if(getdvarint(#"hash_3ce5890428b398f1", 0)) {
      foreach(var_ee6a1fe8 in level.var_ff7ae671) {
        if(isDefined(var_ee6a1fe8.v_position) && isDefined(var_ee6a1fe8.n_radius)) {
          sphere(var_ee6a1fe8.v_position, var_ee6a1fe8.n_radius, (1, 0, 0));
          print3d(var_ee6a1fe8.v_position, "<dev string:x4c>" + var_ee6a1fe8.v_position + "<dev string:x6f>" + var_ee6a1fe8.n_radius, (0, 1, 0));
        }
      }
    }

    waitframe(1);
  }
}

function on_spawned() {
  self.var_b1164fd0 = undefined;
  self clientfield::set("" + # "hash_59400ab6cbfaec5d", 0);
  self val::reset(#"aether_shroud", "ignoreme");
}

function private function_4473f9bb(currentweapon) {
  if(killstreaks::is_killstreak_weapon(currentweapon)) {
    return false;
  }

  foreach(weaponname in level.var_e163165b) {
    weapon = getweapon(weaponname);

    if(weapon === currentweapon) {
      return false;
    }
  }

  return true;
}

function function_84c43da8(params) {
  self namespace_1b527536::function_460882e2(1);
  self flag::increment("zm_field_upgrade_in_use");
  weapon = params.weapon;
  currentweapon = self getcurrentweapon();
  currentweapon = currentweapon.rootweapon;

  switch (weapon.name) {
    case # "aether_shroud":
      self thread function_ff022837(5, weapon);
      break;
    case # "aether_shroud_1":
      self thread function_ff022837(5, weapon);

      if(function_4473f9bb(currentweapon)) {
        self player::fill_current_clip(1);
      }

      break;
    case # "aether_shroud_2":
      self thread function_ff022837(8, weapon);

      if(function_4473f9bb(currentweapon)) {
        self player::fill_current_clip(1);
      }

      break;
    case # "aether_shroud_3":
      self thread function_ff022837(8, weapon);

      if(function_4473f9bb(currentweapon)) {
        self player::fill_current_clip(1);
      }

      self thread function_c5e5e928(500);
      break;
    case # "aether_shroud_5":
    case # "aether_shroud_4":
      self thread function_ff022837(8, weapon);

      if(function_4473f9bb(currentweapon)) {
        self player::fill_current_clip(1);
      }

      self thread function_c5e5e928(500);
      self thread function_df6782a4(1.5, 8);
      break;
  }
}

function function_ff022837(n_duration, weapon) {
  self endon(#"disconnect");
  self.var_b1164fd0 = 1;
  self clientfield::set("" + # "hash_59400ab6cbfaec5d", 1);
  self val::set(#"aether_shroud", "ignoreme", 1);
  s_waitresult = self waittilltimeout(n_duration, #"scene_igc_shot_started", #"player_downed", #"death");
  self thread function_c8e90b89(s_waitresult._notify, weapon);
  self flag::decrement("zm_field_upgrade_in_use");
}

function function_c8e90b89(str_notify, weapon) {
  self notify("749fc2e6423f1edb");
  self endon("749fc2e6423f1edb");
  self endon(#"disconnect");
  self flag::wait_till_clear("zm_field_upgrade_in_use");

  if(str_notify != "death") {
    self thread battlechatter::play_gadget_success(weapon);
  }

  self.var_b1164fd0 = undefined;
  self clientfield::set("" + # "hash_59400ab6cbfaec5d", 0);
  self val::reset(#"aether_shroud", "ignoreme");
}

function function_c5e5e928(var_e14b4254) {
  if(is_true(self.var_1a4a768c)) {
    return;
  }

  if(self function_b4813488() || self isziplining() || is_true(self.var_16735873)) {
    return;
  }

  v_angles = self.angles;
  a_v_points = [];

  for(i = 1; i <= 10; i++) {
    var_92848b84 = i / 10 * var_e14b4254;
    v_point = self getplayercamerapos() + anglesToForward(v_angles) * var_92848b84;
    v_point = groundtrace(v_point + (0, 0, 8), v_point + (0, 0, -100000), 0, self)[#"position"];

    if(!isDefined(a_v_points)) {
      a_v_points = [];
    } else if(!isarray(a_v_points)) {
      a_v_points = array(a_v_points);
    }

    a_v_points[a_v_points.size] = v_point;
  }

  if(zm_utility::is_survival()) {
    for(i = a_v_points.size - 1; i >= 0; i--) {
      v_dest = a_v_points[i];

      if(ispointonnavmesh(v_dest, 15) && self util::is_player_looking_at(v_dest, 0.8, 0, self) && !function_83407b23(v_dest)) {
        v_dest = function_9cc082d2(v_dest, 128);

        if(isDefined(v_dest) && namespace_d0ab5955::function_3824d2dc(v_dest[#"point"]) && function_2e44fb9a(v_dest[#"point"])) {
          v_teleport = v_dest[#"point"];
          break;
        }
      }
    }
  } else if(zm_utility::function_c200446c()) {
    for(i = a_v_points.size - 1; i >= 0; i--) {
      v_dest = a_v_points[i];

      if(ispointonnavmesh(v_dest, 15) && self util::is_player_looking_at(v_dest, 0.8, 0, self) && death_circle::function_a086017a(v_dest) && !function_83407b23(v_dest)) {
        v_dest = function_9cc082d2(v_dest, 128);

        if(isDefined(v_dest) && function_2e44fb9a(v_dest[#"point"])) {
          v_teleport = v_dest[#"point"];
          break;
        }
      }
    }
  } else {
    for(i = a_v_points.size - 1; i >= 0; i--) {
      v_dest = a_v_points[i];

      if(zm_utility::check_point_in_playable_area(v_dest) && zm_utility::check_point_in_enabled_zone(v_dest) && ispointonnavmesh(v_dest, 15) && self util::is_player_looking_at(v_dest, 0.8, 0, self) && !function_83407b23(v_dest)) {
        v_dest = function_9cc082d2(v_dest, 128);

        if(isDefined(v_dest) && function_2e44fb9a(v_dest[#"point"])) {
          v_teleport = v_dest[#"point"];
          break;
        }
      }
    }
  }

  if(isDefined(v_teleport)) {
    v_dir = v_teleport - self.origin;
    v_dir = (v_dir[0], v_dir[1], 1);
    v_dir = vectornormalize(v_dir);
    self playSound(#"hash_3d03d5d52c39fe35");
    var_dcbe57af = self getvelocity();
    n_length = length(var_dcbe57af);
    var_7bfb3e25 = var_dcbe57af + v_dir * n_length;
    self dontinterpolate();
    self setorigin(v_teleport);
    self setvelocity(var_7bfb3e25);
  }
}

function private function_2e44fb9a(var_ab528fee) {
  v_trace_start = var_ab528fee + (0, 0, 70);
  trace = physicstraceex(v_trace_start, var_ab528fee);

  if(trace[#"fraction"] < 0.99) {
    return false;
  }

  return true;
}

function function_df6782a4(var_77d307ea, n_duration) {
  if(!isPlayer(self)) {
    return;
  }

  self notify("26e83eceea4db8d5");
  self endon("26e83eceea4db8d5");
  self endon(#"disconnect");
  self val::set(#"aether_shroud", "move_speed_scale", var_77d307ea);
  self.var_11994308 = 1;
  self waittilltimeout(n_duration, #"scene_igc_shot_started");
  self val::reset(#"aether_shroud", "move_speed_scale");
  self.var_11994308 = undefined;
}