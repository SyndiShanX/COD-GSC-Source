/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4f794fb0bc50676b.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_686729055b66c6e4;
#using script_7edf952f8921aa6b;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\math;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_f50b7a445cd149bc;

function init() {
  level callback::add("player_weapon_change", &function_7bd275ed660d3b32);
  level._effect["plasmagun_trail"] = [];
  level._effect["plasmagun_trail_pap"] = [];

  for(i = 0; i < 6; i++) {
    level._effect["plasmagun_trail"][i] = loadfx("vfx/jup/ob/gameplay/zm_weapons/vfx_zmb_dark_aether_plasma_hit_lvl" + i + ".vfx");
    level._effect["plasmagun_trail_pap"][i] = loadfx("vfx/jup/ob/gameplay/zm_weapons/vfx_zmb_dark_aether_plasma_hit_pap_lvl" + i + ".vfx");
  }

  level._effect["plasmagun_air_launch_explosion"] = loadfx("vfx/jup/ob/gameplay/zm_weapons/vfx_zmb_dark_aether_plasma_fiy_loop_camera_1p.vfx");
  level callback::add("on_zombie_ai_killed", &function_acff8f7424c6a789);
  var_a6a33e69f0bceb0c = makeweapon("jup_la_plasmagun_mp");
  assert(isDefined(var_a6a33e69f0bceb0c.weaponcustomsettings), "<dev string:x1c>");
  level.var_bb16eca3af147d1e = var_a6a33e69f0bceb0c.weaponcustomsettings;
  level.var_4f5da0e672c7da16 = throttle_initialize("plasmagun_damage", 5, 0.05);
}

function function_7bd275ed660d3b32(params) {
  if(!isDefined(params.weapon) || isbot(self)) {
    return;
  }

  if(params.weapon.basename == "jup_la_plasmagun_mp") {
    thread plasmagun_watch_enter_charge();
    thread plasmagun_watch_fire_notify();
    thread monitor_plasmagun_vfx_state(params.weapon);
    thread function_e52edfb5ea677904();
    thread function_3a1fea67117b5878(params.weapon);
  } else {
    self notify("stop_plasmagun_watch_enter_charge");
    self notify("stop_plasmagun_watch_fire_notify");
    self notify("stop_monitor_plasmagun_vfx_state");
    self notify("stop_plasmagun_watch_charge_overtime");
    utility::function_3677f2be30fdd581("PlasmaLauncherAmbientVFX", "off");
    self.var_1b497a63cfb737b2 = 0;
  }

  if(function_fe8f110892c02b38("ui_plasma_launcher_charge_time")) {
    ispap = function_d379e4f28a5e64b7();
    charge_time = ter_op(ispap, 2, 3);
    self setclientomnvar("ui_plasma_launcher_charge_time", charge_time);
  }
}

function private plasmagun_watch_enter_charge() {
  self endon("death");
  self notify("stop_plasmagun_watch_enter_charge");
  self endon("stop_plasmagun_watch_enter_charge");

  while(true) {
    self waittill("weapon_enter_or_clear_charge", param);

    switch (param) {
      case 0:
        function_d4e2072a078a7a16();
        break;
      case 1:
        function_2fe43dabafffe097();
        break;
      case 2:
        function_1a8cf1d0a5a6b560();
        break;
      default:
        break;
    }
  }
}

function private plasmagun_watch_fire_notify() {
  self endon("death");
  self notify("stop_plasmagun_watch_fire_notify");
  self endon("stop_plasmagun_watch_fire_notify");

  while(true) {
    self waittill("weapon_fired", objweapon);

    if(isDefined(objweapon) && objweapon.basename == "jup_la_plasmagun_mp") {
      if(istrue(self.var_e8aa11bc1e7cb985) && isDefined(self.var_f66d06842794850a)) {
        thread function_5fb77a929eee804c(objweapon);
      } else if(istrue(self.var_ea0b71e2cfd433a8) && isDefined(self.var_8929c2f2830df829)) {
        function_ec35cd5953d2903b(objweapon);
      }

      self.no_clear = 1;
    }
  }
}

function private function_d4e2072a078a7a16() {
  val::set("plasma_charge", "mantle", 0);
  val::set("plasma_charge", "sprint", 0);
  val::set("plasma_charge", "equipment_primary", 0);
  val::set("plasma_charge", "equipment_secondary", 0);
  val::set("plasma_charge", "gesture", 0);
  paped = 0;
  state_name = "fire_charge";

  if(function_d379e4f28a5e64b7() > 0) {
    paped = 1;
    state_name = "fire_charge_pap";
  }

  thread plasmagun_watch_charge_overtime(state_name, paped);

  if(function_fe8f110892c02b38("ui_plasma_launcher_light_color")) {
    self setclientomnvar("ui_plasma_launcher_light_color", 0);
  }

  utility::function_3677f2be30fdd581("PlasmaLauncherStates", state_name);
  self.var_f66d06842794850a = gettime();
  self.var_e8aa11bc1e7cb985 = 1;
  self.var_8929c2f2830df829 = undefined;
  self.var_ea0b71e2cfd433a8 = 0;
  self.no_clear = 0;
  self notify("plasmagun_ammo_regen_stop");
}

function private function_2fe43dabafffe097() {
  val::set("plasma_charge", "mantle", 0);
  val::set("plasma_charge", "sprint", 0);
  val::set("plasma_charge", "equipment_primary", 0);
  val::set("plasma_charge", "equipment_secondary", 0);
  val::set("plasma_charge", "gesture", 0);
  paped = 0;
  state_name = "launch_charge";

  if(function_d379e4f28a5e64b7() > 0) {
    paped = 1;
    state_name = "launch_charge_pap";
  }

  thread plasmagun_watch_charge_overtime(state_name, paped);

  if(function_fe8f110892c02b38("ui_plasma_launcher_light_color")) {
    self setclientomnvar("ui_plasma_launcher_light_color", 1);
  }

  utility::function_3677f2be30fdd581("PlasmaLauncherStates", state_name);
  self.var_f66d06842794850a = undefined;
  self.var_e8aa11bc1e7cb985 = 0;
  self.var_8929c2f2830df829 = gettime();
  self.var_ea0b71e2cfd433a8 = 1;
  self.no_clear = 0;
  self notify("plasmagun_ammo_regen_stop");
}

function private plasmagun_watch_charge_overtime(state_name, paped) {
  self endon("death");
  self notify("stop_plasmagun_watch_charge_overtime");
  self endon("stop_plasmagun_watch_charge_overtime");
  wait_time = 3;

  if(paped) {
    wait_time = 2;
  }

  msg = waittill_any_timeout_1(wait_time + 0.1, "skydive_deployparachute");

  if(isDefined(msg) && msg == "skydive_deployparachute") {
    function_1a8cf1d0a5a6b560();
  }

  if(utility::function_35c178c80fa19cbd("PlasmaLauncherStates", state_name)) {
    utility::function_3677f2be30fdd581("PlasmaLauncherStates", "off");
    thread function_3a1fea67117b5878(self getcurrentweapon());
  }
}

function private function_1a8cf1d0a5a6b560() {
  val::set("plasma_charge", "mantle", 1);
  val::set("plasma_charge", "sprint", 1);
  val::set("plasma_charge", "equipment_primary", 1);
  val::set("plasma_charge", "equipment_secondary", 1);
  val::set("plasma_charge", "gesture", 1);

  if(istrue(self.no_clear)) {
    return;
  }

  if(function_fe8f110892c02b38("ui_plasma_launcher_light_color")) {
    self setclientomnvar("ui_plasma_launcher_light_color", 0);
  }

  utility::function_3677f2be30fdd581("PlasmaLauncherStates", "off");
  self.var_f66d06842794850a = undefined;
  self.var_e8aa11bc1e7cb985 = 0;
  self.var_8929c2f2830df829 = undefined;
  self.var_ea0b71e2cfd433a8 = 0;
  thread function_3a1fea67117b5878(self getcurrentweapon());
}

function private function_71e3d59774799cfa(is_launch, var_f70ff2193bcb2c83) {
  if(is_launch) {
    if(var_f70ff2193bcb2c83) {
      utility::function_3677f2be30fdd581("PlasmaLauncherStates", "weapon_launch_fired_full");
    } else {
      utility::function_3677f2be30fdd581("PlasmaLauncherStates", "weapon_launch_fired");
    }
  } else if(var_f70ff2193bcb2c83) {
    utility::function_3677f2be30fdd581("PlasmaLauncherStates", "weapon_fired_full");
  } else {
    utility::function_3677f2be30fdd581("PlasmaLauncherStates", "weapon_fired");
  }

  thread function_5b2ffe8a6eb4cf9d();
  thread function_3a1fea67117b5878(self getcurrentweapon());
}

function private function_5b2ffe8a6eb4cf9d() {
  self endon("death");
  waitframe();
  utility::function_3677f2be30fdd581("PlasmaLauncherStates", "off");
}

function private function_e52edfb5ea677904() {
  self endon("death");
  self endon("stop_monitor_plasmagun_vfx_state");

  while(true) {
    result = waittill_any_return_5("weapon_switch_started", "skydive_deployparachute", "weapon_switch_canceled", "offhand_end", "skydive_end");

    if(!isDefined(result)) {
      continue;
    }

    if(result == "weapon_switch_started" || result == "skydive_deployparachute") {
      self.var_1b497a63cfb737b2 = 1;
      continue;
    }

    self.var_1b497a63cfb737b2 = 0;
  }
}

function private monitor_plasmagun_vfx_state(current_weapon) {
  self endon("death");
  self notify("stop_monitor_plasmagun_vfx_state");
  self endon("stop_monitor_plasmagun_vfx_state");
  var_e6f4ad46c089cece = "off";

  if(!istrue(self.var_c9b32cb8f261f065)) {
    wait 1;
    self.var_c9b32cb8f261f065 = 1;
  }

  while(true) {
    if(istrue(self.var_1b497a63cfb737b2)) {
      fx_state = "off";
    } else {
      fx_state = "on";
    }

    if(fx_state != var_e6f4ad46c089cece) {
      if(fx_state == "on" && function_d379e4f28a5e64b7() > 0) {
        fx_state = "on_pap";
      }

      utility::function_3677f2be30fdd581("PlasmaLauncherAmbientVFX", fx_state);
      var_e6f4ad46c089cece = fx_state;
    }

    waitframe();
  }
}

function private function_d379e4f28a5e64b7() {
  if(issharedfuncdefined("zombie", "get_pap_level")) {
    current_weapon = self getcurrentweapon();

    if(!is_equal(current_weapon.basename, "jup_la_plasmagun_mp")) {
      return 0;
    }

    return function_af5127390d3221e9(current_weapon);
  }

  return 0;
}

function private function_3f54cae9f655ea24(var_3032a1d2003305a6, charge_time, obj_weapon) {
  var_da49a6c35dc8e259 = 0;
  var_d389b0c90dbea55d = ter_op(var_3032a1d2003305a6, 2, 3);

  if(function_fe8f110892c02b38("ui_plasma_launcher_charge_time")) {
    self setclientomnvar("ui_plasma_launcher_charge_time", var_d389b0c90dbea55d);
  }

  if(charge_time >= var_d389b0c90dbea55d) {
    var_da49a6c35dc8e259 = 5;
  } else {
    var_da49a6c35dc8e259 = int(charge_time / var_d389b0c90dbea55d * 5);
  }

  var_da49a6c35dc8e259 = max(var_da49a6c35dc8e259, 1);
  current_ammo = self getweaponammoclip(obj_weapon);
  var_da49a6c35dc8e259 = int(min(var_da49a6c35dc8e259, current_ammo + 1));
  return var_da49a6c35dc8e259;
}

function private function_1f358f6cc8bd3599(base_damage, ai_target, pap_level) {
  if(isDefined(ai_target) && ai_target scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    base_damage = 100;
  }

  pap_multiplier = 1;

  if(pap_level > 0) {
    pap_multiplier = 2 + 0.5 * (pap_level - 1);
  }

  return base_damage * pap_multiplier;
}

function private function_5fb77a929eee804c(objweapon) {
  self endon("death");
  var_3032a1d2003305a6 = 0;
  var_800f2adb5f8efb28 = function_d379e4f28a5e64b7();

  if(var_800f2adb5f8efb28 > 0) {
    var_3032a1d2003305a6 = 1;
  }

  time_now = gettime();
  var_ff1723e516236c87 = function_c89ed1840c8d0f0f(time_now - self.var_f66d06842794850a);
  var_f70ff2193bcb2c83 = 0;
  var_f528b2c52c8909ac = function_3f54cae9f655ea24(var_3032a1d2003305a6, var_ff1723e516236c87, objweapon);
  function_a88ee6bfa7bbbf2d(objweapon, var_f528b2c52c8909ac);

  if(var_f528b2c52c8909ac == 5) {
    var_f70ff2193bcb2c83 = 1;
  }

  function_71e3d59774799cfa(0, var_f70ff2193bcb2c83);
  self.var_f66d06842794850a = undefined;

  function_b333f7f92486cb57("<dev string:x4f>" + var_f528b2c52c8909ac);

  plasma_length = level.var_bb16eca3af147d1e.var_5737a3eec36cf475 + level.var_bb16eca3af147d1e.var_b2cc181b1e309cae * var_f528b2c52c8909ac;
  var_351af8c1f3879c3f = level.var_bb16eca3af147d1e.var_7c57d2cc8909e9da + level.var_bb16eca3af147d1e.var_803043770a12cf9 * var_f528b2c52c8909ac;
  plasma_radius = var_351af8c1f3879c3f / 2;
  start_point = self getvieworigin();
  player_angles = self getplayerangles();
  plasma_direction = vectorNormalize(anglesToForward(player_angles));
  muzzle_point = self gettagorigin("tag_flash");
  end_point = start_point + plasma_direction * plasma_length;
  mid_point = (start_point + end_point) / 2;
  var_6fda1daae1df6534 = function_1e42f5373983de9f(start_point, player_angles);
  var_f464ee4235e6e103 = level.var_bb16eca3af147d1e.var_6cf27ccb42a2cb44 + level.var_bb16eca3af147d1e.var_d61c1c529cf19e43 * var_f528b2c52c8909ac;
  contentoverride = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0);
  ignoreents = [self];
  trace = scripts\engine\trace::ray_trace(start_point, end_point, ignoreents, contentoverride);
  end_point = trace["position"];
  var_390da608d44b5b72 = spawn_tag_origin(var_6fda1daae1df6534, vectortoangles(vectorNormalize(end_point - var_6fda1daae1df6534)));
  var_390da608d44b5b72 show();
  var_390da608d44b5b72 function_172fff96f149cb86(trace["position"], var_f528b2c52c8909ac, 0.3, var_800f2adb5f8efb28);
  var_daaa88e256ba5cdf = spawn_tag_origin(var_6fda1daae1df6534, vectortoangles(vectorNormalize(end_point - var_6fda1daae1df6534)));
  var_daaa88e256ba5cdf thread function_9aa347a76fa69e30(var_f528b2c52c8909ac, var_f464ee4235e6e103);

  function_2287375d7ea1f1ae(start_point, end_point, plasma_radius, (0, 1, 0), 0, 240);

  ai_targets = function_b42e7cb6787cfbef(start_point, end_point, mid_point, plasma_length, plasma_radius, plasma_direction);

  foreach(ai_target in ai_targets) {
    ai_target function_1be0050857965aa8(var_3032a1d2003305a6);
    ai_target thread function_140dea1474dc3f28(function_1f358f6cc8bd3599(level.var_bb16eca3af147d1e.plasmaimpactdamage, ai_target, var_800f2adb5f8efb28), self, objweapon);
  }

  thread function_85eca118ca41d759(objweapon, var_f464ee4235e6e103, var_800f2adb5f8efb28, start_point, end_point, mid_point, plasma_length, plasma_radius, plasma_direction);
}

function function_85eca118ca41d759(objweapon, var_f464ee4235e6e103, var_800f2adb5f8efb28, start_point, end_point, mid_point, plasma_length, plasma_radius, plasma_direction) {
  self endon("death");
  var_b9937f7b1b9b4ee2 = 0;

  while(var_b9937f7b1b9b4ee2 < var_f464ee4235e6e103) {
    wait 0.5;
    ai_targets = function_b42e7cb6787cfbef(start_point, end_point, mid_point, plasma_length, plasma_radius, plasma_direction);

    foreach(ai_target in ai_targets) {
      ai_target thread function_140dea1474dc3f28(function_1f358f6cc8bd3599(level.var_bb16eca3af147d1e.var_ae0afbdb9e060fc8, ai_target, var_800f2adb5f8efb28), self, objweapon);
    }

    var_b9937f7b1b9b4ee2 += 0.5;
  }
}

function function_140dea1474dc3f28(plasma_damage, player, objweapon) {
  self endon("death");
  throttle::function_f632348cbb773537(level.var_4f5da0e672c7da16, self);
  self dodamage(plasma_damage, player.origin, player, undefined, "MOD_UNKNOWN", objweapon, "upper_torso");
}

function function_1be0050857965aa8(var_3032a1d2003305a6) {
  var_36aa7007d5c49a07 = "plasma_hit_vfx";

  if(var_3032a1d2003305a6) {
    var_36aa7007d5c49a07 += "_pap";
  }

  if(isDefined(self.aicategory) && self.aicategory == "normal" && randomint(10) < 5) {
    var_36aa7007d5c49a07 += "a";
  }

  utility::function_3677f2be30fdd581("plasma_hit", var_36aa7007d5c49a07);
}

function function_1e42f5373983de9f(viewpoint, player_angles) {
  var_f1eb02de236eecda = getdvarint(@ "hash_cb8683d34d92d83", 100);
  offset_left = getdvarint(@ "hash_6c6825ac08c7934b", -2);
  offset_up = getdvarint(@ "hash_625b2aec934211f3", -3);
  target_position = rotatevector((var_f1eb02de236eecda, offset_left, offset_up), player_angles);
  return viewpoint + target_position;
}

function function_172fff96f149cb86(end_point, charge_level, fly_time, pap_level) {
  level endon("game_ended");
  self endon("death");

  if(pap_level > 0) {
    playFXOnTag(level._effect["plasmagun_trail_pap"][charge_level], self, "tag_origin");
  } else {
    playFXOnTag(level._effect["plasmagun_trail"][charge_level], self, "tag_origin");
  }

  thread play_loop_sound_on_entity("proj_plasmagun_lp");
  self moveTo(end_point, fly_time);
  wait fly_time;
  stop_loop_sound_on_entity("proj_plasmagun_lp");
  playsoundatpos(self.origin, "proj_plasmagun_lp_end");
  self delete();
}

function function_9aa347a76fa69e30(charge_level, fx_time) {
  level endon("game_ended");
  self endon("death");
  thread play_loop_sound_on_entity("proj_plasmagun_lp");
  wait fx_time;
  stop_loop_sound_on_entity("proj_plasmagun_lp");
  playsoundatpos(self.origin, "proj_plasmagun_lp_end");
  self delete();
}

function function_b42e7cb6787cfbef(start_point, end_point, mid_point, plasma_length, plasma_radius, plasma_direction) {
  var_48c04837d9e0eafc = plasma_radius * plasma_radius;
  var_18c86d4b6f045520 = (plasma_radius + 30) * (plasma_radius + 30);
  var_8dae93390b0b3a19 = getaiarrayinradius(mid_point, plasma_length / 2);
  ai_targets = [];

  foreach(var_6175dabe2b377ef0 in var_8dae93390b0b3a19) {
    trace_pos = var_6175dabe2b377ef0 getcentroid();

    function_f4402753f88cefb5(trace_pos, 20, (1, 0, 0), 0, 240);

    if(pointvscylinder(trace_pos, var_48c04837d9e0eafc, plasma_length, start_point, plasma_direction)) {
      ai_targets = function_6d6af8144a5131f1(ai_targets, var_6175dabe2b377ef0);
    }
  }

  var_5cc482101de7fbe0 = getentarrayinradius("script_vehicle", "classname", mid_point, plasma_length / 2 + 30);

  foreach(var_d65737e032faf4d3 in var_5cc482101de7fbe0) {
    trace_pos = var_d65737e032faf4d3 getcentroid();

    if(pointvscylinder(trace_pos, var_18c86d4b6f045520, plasma_length + 30, start_point, plasma_direction)) {
      ai_targets = function_6d6af8144a5131f1(ai_targets, var_d65737e032faf4d3);
    }
  }

  return ai_targets;
}

function private function_ec35cd5953d2903b(objweapon) {
  var_3032a1d2003305a6 = 0;
  var_800f2adb5f8efb28 = function_d379e4f28a5e64b7();
  time_now = gettime();
  var_987479ea4dd468d4 = function_c89ed1840c8d0f0f(time_now - self.var_8929c2f2830df829);

  if(var_800f2adb5f8efb28 > 0) {
    var_3032a1d2003305a6 = 1;
  }

  var_f70ff2193bcb2c83 = 0;
  var_7f54af4b0790e28d = function_3f54cae9f655ea24(var_3032a1d2003305a6, var_987479ea4dd468d4, objweapon);
  function_a88ee6bfa7bbbf2d(objweapon, var_7f54af4b0790e28d);

  if(var_7f54af4b0790e28d == 5) {
    var_f70ff2193bcb2c83 = 1;
  }

  function_71e3d59774799cfa(1, var_f70ff2193bcb2c83);
  self.var_8929c2f2830df829 = undefined;

  function_b333f7f92486cb57("<dev string:x64>" + var_7f54af4b0790e28d);

  if(var_7f54af4b0790e28d > 0) {
    self radiusdamage(self.origin, level.var_bb16eca3af147d1e.var_60fca609d86bfc77, level.var_bb16eca3af147d1e.var_4f35c31d13113691 * var_7f54af4b0790e28d, level.var_bb16eca3af147d1e.var_4f35c31d13113691 * var_7f54af4b0790e28d, self, "MOD_EXPLOSIVE", "jup_la_plasmagun_mp");
    var_424765b57629b251 = spawn_tag_origin(self.origin, (0, 0, 0));
    var_424765b57629b251 show();
    playFXOnTag(level._effect["plasmagun_air_launch_explosion"], var_424765b57629b251, "tag_origin");
    var_424765b57629b251 delaycall(2, &delete);

    if(function_4de5fbb5a8d10590()) {
      neworigin = (self.origin[0], self.origin[1], self.origin[2] + 20);
      self setOrigin(neworigin);
      self setvelocity((1, 1, level.var_bb16eca3af147d1e.var_e21272e6f0102e08 * var_7f54af4b0790e28d));
    }
  }
}

function private function_4de5fbb5a8d10590() {
  contentoverride = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0);
  ignoreents = [self];
  trace = scripts\engine\trace::ray_trace(self.origin, self.origin + (0, 0, 80), ignoreents, contentoverride);

  if(isDefined(trace["fraction"]) && trace["fraction"] < 0.99) {
    return false;
  }

  return true;
}

function private function_acff8f7424c6a789(params) {
  if(isDefined(params.objweapon) && isDefined(params.objweapon.basename) && params.objweapon.basename == "jup_la_plasmagun_mp") {
    var_29a8ba8c9dd43fd2 = 0;

    if(issharedfuncdefined("zombie", "get_pap_level") && isDefined(params.eattacker)) {
      var_29a8ba8c9dd43fd2 = params.eattacker function_af5127390d3221e9(params.objweapon);
    }

    if(var_29a8ba8c9dd43fd2 > 0) {
      ent_flag_set("plasma_death_pap");
      return;
    }

    ent_flag_set("plasma_death");
  }
}

function private function_3a1fea67117b5878(var_a6a33e69f0bceb0c) {
  self endon("death_or_disconnect");
  self notify("plasmagun_ammo_regen_stop");
  self endon("plasmagun_ammo_regen_stop");

  if(!isDefined(var_a6a33e69f0bceb0c) || var_a6a33e69f0bceb0c.basename != "jup_la_plasmagun_mp") {
    return;
  }

  wait 2;
  clip_size = weaponclipsize(var_a6a33e69f0bceb0c);

  while(true) {
    wait 0.6;
    current_ammo = self getweaponammoclip(var_a6a33e69f0bceb0c);

    if(current_ammo >= clip_size) {
      break;
    }

    self setweaponammoclip(var_a6a33e69f0bceb0c, current_ammo + 1);
  }
}

function private function_a88ee6bfa7bbbf2d(var_a6a33e69f0bceb0c, charge_level) {
  current_ammo = self getweaponammoclip(var_a6a33e69f0bceb0c);
  new_ammo = int(max(0, current_ammo - charge_level + 1));
  self setweaponammoclip(var_a6a33e69f0bceb0c, new_ammo);
}

function private function_b333f7f92486cb57(string) {
  if(getdvarint(@ "hash_6c4707e681bb2aa5", 0) == 0) {
    return;
  }

  iprintlnbold(string);
}

function private function_2287375d7ea1f1ae(start, end, radius, color, depthtest, duration) {
  if(getdvarint(@ "hash_6c4707e681bb2aa5", 0) == 0) {
    return;
  }

  cylinder(start, end, radius, color, depthtest, duration);
}

function private function_f4402753f88cefb5(origin, radius, color, depthtest, duration) {
  if(getdvarint(@ "hash_6c4707e681bb2aa5", 0) == 0) {
    return;
  }

  sphere(origin, radius, color, depthtest, duration);
}

# /