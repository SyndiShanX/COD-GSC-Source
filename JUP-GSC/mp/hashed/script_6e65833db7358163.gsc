/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6e65833db7358163.gsc
*************************************************/

#using script_38db8bccc9eb301f;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\vision_utility;
#using scripts\engine\utility;
#using scripts\mp\supers;
#namespace namespace_24a6e4eec2adc745;

function init() {
  scripts\mp\supers::function_53110a12409d01da("super_aether_shroud", undefined, undefined, &function_d3ff64a0b2474cca, &function_cf7110293e2d063e, undefined);

  function_6e7290c8ee4f558b("<dev string:x1c>");
  add_devgui_command("<dev string:x35>", "<dev string:x4b>");
  add_devgui_command("<dev string:x7d>", "<dev string:x96>");
  function_fe953f000498048f();

  level.var_4f96195d350ff960 = [];
  level.var_4e33240295d7bdc2 = [];
  var_6f0c028c94328ae3 = namespace_e23f629a8349dfaf::function_e7b6474ebd683537("super_aether_shroud", #"hash_da26bdf3857515de");
  var_9462543a62d56ae0 = namespace_e23f629a8349dfaf::function_e7b6474ebd683537("super_aether_shroud", #"hash_2f0b226efbc9fa82");
  var_21ecbfef71b4de59 = namespace_e23f629a8349dfaf::function_e7b6474ebd683537("super_aether_shroud", #"hash_3605e6a6954477e7");
  level._effect["aether_shroud_1p_effect"] = loadfx(default_to(var_6f0c028c94328ae3, ""));
  level._effect["aether_shroud_3p_head_effect"] = loadfx(default_to(var_9462543a62d56ae0, ""));
  level._effect["aether_shroud_3p_torso_effect"] = loadfx(default_to(var_21ecbfef71b4de59, ""));
  supertable = getscriptbundle(level.supertable);

  foreach(super in supertable.super_list) {
    if(super.ref == "super_aether_shroud") {
      level.var_f04301db8ca5ecfa["super_aether_shroud"] = getscriptbundle("super:" + super.bundle);
      break;
    }
  }
}

function function_86417e1aaa5f1a7d(v_position, n_radius, var_7c572f708cdf5ef5) {
  var_1c15eb881886a8b7 = spawnStruct();
  var_1c15eb881886a8b7.v_position = v_position;
  var_1c15eb881886a8b7.n_radius = n_radius;
  var_1c15eb881886a8b7.var_7c572f708cdf5ef5 = var_7c572f708cdf5ef5;
  level.var_4f96195d350ff960 = array_add_safe(level.var_4f96195d350ff960, var_1c15eb881886a8b7);
}

function function_7a23d1e9435c166d(var_7c572f708cdf5ef5) {
  if(isarray(level.var_4f96195d350ff960)) {
    var_a9b90636cbf1fe13 = [];

    foreach(var_1c15eb881886a8b7 in level.var_4f96195d350ff960) {
      if(var_1c15eb881886a8b7.var_7c572f708cdf5ef5 == var_7c572f708cdf5ef5) {
        var_a9b90636cbf1fe13 = array_add_safe(var_a9b90636cbf1fe13, var_1c15eb881886a8b7);
      }
    }

    foreach(var_a4187e31b206b777 in var_a9b90636cbf1fe13) {
      level.var_4f96195d350ff960 = array_remove(level.var_4f96195d350ff960, var_a4187e31b206b777);
    }
  }
}

function function_81fd5ce82ea52d2b(vol_forced) {
  if(isstring(vol_forced)) {
    vol_forced = getEnt(vol_forced, "targetname");
  }

  if(isent(vol_forced)) {
    level.var_4e33240295d7bdc2 = array_add_safe(level.var_4e33240295d7bdc2, vol_forced);
  }
}

function function_bf84ffa9f6668166(vol_forced) {
  if(isstring(vol_forced)) {
    vol_forced = getEnt(vol_forced, "targetname");
  }

  if(isent(vol_forced)) {
    level.var_4e33240295d7bdc2 = array_remove(level.var_4e33240295d7bdc2, vol_forced);
  }
}

function function_911c48a329a02364(v_destination) {
  foreach(var_1c15eb881886a8b7 in level.var_4f96195d350ff960) {
    if(isDefined(var_1c15eb881886a8b7.v_position) && isDefined(var_1c15eb881886a8b7.n_radius)) {
      if(distancesquared(v_destination, var_1c15eb881886a8b7.v_position) <= var_1c15eb881886a8b7.n_radius * var_1c15eb881886a8b7.n_radius) {
        return true;
      }
    }

    if(isstring(var_1c15eb881886a8b7.var_7c572f708cdf5ef5)) {
      var_fd32a267f73f2457 = getEntArray(var_1c15eb881886a8b7.var_7c572f708cdf5ef5, "targetname");

      foreach(var_774845f9562d0f6b in var_fd32a267f73f2457) {
        if(var_774845f9562d0f6b istouchingpoint(v_destination)) {
          return true;
        }
      }
    }
  }

  level.var_4e33240295d7bdc2 = array_removeundefined(level.var_4e33240295d7bdc2);

  if(level.var_4e33240295d7bdc2.size > 0) {
    foreach(vol_forced in level.var_4e33240295d7bdc2) {
      if(vol_forced istouchingpoint(v_destination)) {
        return false;
      }
    }

    return true;
  }

  return false;
}

function function_d3ff64a0b2474cca() {
  if(isDefined(level.var_f04301db8ca5ecfa["super_aether_shroud"])) {
    var_8dcc5d0cbc133cf9 = level.var_f04301db8ca5ecfa["super_aether_shroud"].offhandweapon;
    deploysuccess = namespace_e23f629a8349dfaf::function_75abcff430ed00b7(var_8dcc5d0cbc133cf9);

    if(deploysuccess) {
      self setscriptablepartstate("wand_fx", "wand_on_aether_shroud", 0);
      var_45b3d22c6cca7734 = namespace_e23f629a8349dfaf::function_dabbdf1761a23f5c();

      switch (var_45b3d22c6cca7734) {
        case 0:
          thread function_f2f5db77ae69537f();
          break;
        case 1:
        default:
          thread function_f2f5db77ae69537f();
          thread function_b65531559070a5b();
          break;
        case 2:
          thread function_f2f5db77ae69537f();
          thread function_b65531559070a5b();
          break;
        case 3:
          thread function_f2f5db77ae69537f();
          thread function_b65531559070a5b();
          thread function_958362f296f71e8e();
          break;
        case 4:
          thread function_f2f5db77ae69537f();
          thread function_b65531559070a5b();
          thread function_958362f296f71e8e();
          thread function_412f7ef9dbae113d();
          break;
        case 5:
          thread function_f2f5db77ae69537f();
          thread function_b65531559070a5b();
          thread function_958362f296f71e8e();
          thread function_412f7ef9dbae113d();
          break;
      }

      return true;
    }
  }

  return false;
}

function function_cf7110293e2d063e(fromdeath, attacker) {
  self notify("end_aether_shroud");
  ent_flag_clear("field_upgrade_in_use");
  return false;
}

function function_f2f5db77ae69537f() {
  self endon("disconnect");
  ent_flag_init("field_upgrade_in_use");
  ent_flag_set("field_upgrade_in_use");
  self.var_f2f5db77ae69537f = 1;
  n_duration = level.superglobals.staticsuperdata["super_aether_shroud"].usetime;

  if(isDefined(level.var_6a36f59e08b56ed7)) {
    self[[level.var_6a36f59e08b56ed7]](1);
  } else {
    val::set("aether_shroud", "ignoreme", 1);
  }

  thread apply_effects(n_duration);
  s_waitresult = waittill_any_timeout_3(n_duration, "player_downed", "death", "end_aether_shroud");

  if(isDefined(level.var_6a36f59e08b56ed7)) {
    self[[level.var_6a36f59e08b56ed7]](0);
  } else {
    val::reset("aether_shroud", "ignoreme");
  }

  thread remove_effects();
  self.var_f2f5db77ae69537f = undefined;
  ent_flag_clear("field_upgrade_in_use");
}

function function_b65531559070a5b() {
  curweap = self getcurrentprimaryweapon();
  total_ammo = self getammocount(curweap);
  clip_size = int(min(total_ammo, weaponclipsize(curweap)));
  remaining_stock = total_ammo - clip_size;

  if(remaining_stock < 0) {
    remaining_stock = 0;
    clip_size = total_ammo;
  }

  self setweaponammoclip(curweap, clip_size);
  self setweaponammostock(curweap, remaining_stock);
}

function function_958362f296f71e8e() {
  if(istrue(self.var_aad74f4d55dbe0fc)) {
    return;
  }

  if(istrue(self.var_bb5272d39f79bc98)) {
    return;
  }

  if(!isDefined(level.superglobals.staticsuperdata["super_aether_shroud"].var_ac26a499fff83d59)) {
    level.superglobals.staticsuperdata["super_aether_shroud"].var_ac26a499fff83d59 = namespace_e23f629a8349dfaf::function_e7b6474ebd683537("super_aether_shroud", "aetherShroudTeleportDistance");
  }

  var_937222b11d4389e5 = level.superglobals.staticsuperdata["super_aether_shroud"].var_ac26a499fff83d59;
  v_angles = self.angles;
  a_v_points = [];
  v_eye = self getEye();
  v_teleport = undefined;

  for(i = 1; i <= 10; i++) {
    var_4c03aeb41c2a7c99 = i / 10 * var_937222b11d4389e5;
    v_point = v_eye + anglesToForward(v_angles) * var_4c03aeb41c2a7c99;
    v_point = getgroundposition(v_point, 16);
    a_v_points = array_add(a_v_points, v_point);
  }

  for(i = a_v_points.size - 1; i >= 0; i--) {
    v_dest = a_v_points[i];

    if(ispointonnavmesh(v_dest) && within_fov(v_eye, self getplayerangles(), v_dest, 0.8) && !function_911c48a329a02364(v_dest)) {
      v_dest = getclosestpointonnavmesh(v_dest);

      if(isDefined(v_dest)) {
        v_teleport = v_dest;
        break;
      }
    }
  }

  if(isDefined(v_teleport)) {
    v_dir = v_teleport - self.origin;
    v_dir = (v_dir[0], v_dir[1], 1);
    v_dir = vectorNormalize(v_dir);
    var_82a5b257c2daccc3 = self getvelocity();
    n_length = length(var_82a5b257c2daccc3);
    var_9c022cc1c2d7a3a = var_82a5b257c2daccc3 + v_dir * n_length;
    self dontinterpolate();
    self setOrigin(v_teleport, 1, 1);
    self setvelocity(var_9c022cc1c2d7a3a);
  }
}

function function_412f7ef9dbae113d(var_c00a90770505e4b2, n_duration) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");

  if(!isDefined(level.superglobals.staticsuperdata["super_aether_shroud"].var_c00a90770505e4b2)) {
    level.superglobals.staticsuperdata["super_aether_shroud"].var_c00a90770505e4b2 = namespace_e23f629a8349dfaf::function_e7b6474ebd683537("super_aether_shroud", "aetherShroudPlayerSpeed");
  }

  var_c00a90770505e4b2 = level.superglobals.staticsuperdata["super_aether_shroud"].var_c00a90770505e4b2;
  n_duration = level.superglobals.staticsuperdata["super_aether_shroud"].usetime;
  val::set("aether_shroud", "move_speed_scale", var_c00a90770505e4b2);
  self.var_6bc3ec77e73ba9d5 = 1;
  waittill_any_timeout_no_endon_death_2(n_duration, "player_downed", "death");
  val::reset("aether_shroud", "move_speed_scale");
  self.var_6bc3ec77e73ba9d5 = undefined;
}

function apply_effects(n_duration) {
  thread function_3e7ec946182e3969(n_duration);
  visionset = level.var_f04301db8ca5ecfa["super_aether_shroud"].var_1ffaeb4cd78e4a67;
  scripts\cp_mp\utility\vision_utility::function_27a921508cb04613(visionset, 0.5);
  waitframe();

  if(isalive(self)) {
    self setscriptablepartstate("aether_shroud_fx", "super_fx_on", 0);
  }
}

function function_3e7ec946182e3969(n_duration) {
  if(!isDefined(n_duration)) {
    return;
  }

  self endon("death_or_disconnect");
  self notify("applyFOVPresentation");
  self endon("applyFOVPresentation");
  self lerpfovbypreset("zombiedefault");
  waittill_any_timeout_no_endon_death_2(n_duration, "super_use_finished", "end_aether_shroud");
  self lerpfovbypreset("default_2seconds");
}

function remove_effects() {
  visionset = level.var_f04301db8ca5ecfa["super_aether_shroud"].var_1ffaeb4cd78e4a67;
  scripts\cp_mp\utility\vision_utility::function_9a92ae402e209ecc(visionset);
  self setscriptablepartstate("aether_shroud_fx", "super_fx_deactivate", 0);
}