/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_30cfffd6b7b2b212.gsc
***********************************************/

#using script_37f9ff47f340fbe8;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\easing;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\debug;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\util;
#namespace namespace_42da7c51;

function devgui() {
  while(!canadddebugcommand()) {
    waitframe(1);
  }

  setDvar(#"hash_223ad29d2c72f646", 0);
  adddebugcommand("<dev string:x38>");
  function_cd140ee9("<dev string:x96>", &function_22ffd42f);
}

function function_22ffd42f(dvar) {
  if(dvar.value) {
    var_4a0079f0 = getEntArray("<dev string:xb7>", "<dev string:xda>");

    if(var_4a0079f0.size) {
      array::thread_all(var_4a0079f0, &function_27c2f7e2);
    }

    return;
  }

  level notify(#"hash_4215adc4692a4ade");
}

function function_27c2f7e2() {
  level endon(#"hash_4215adc4692a4ade");
  self endon(#"death");
  n_frames = 1;

  while(true) {
    debugaxis(self.origin, self.angles, 16, 1, 0, n_frames);

    if(self getlightintensity() > 0) {
      cur_state = "<dev string:xef>";
    } else {
      cur_state = "<dev string:xf5>";
    }

    if(isDefined(self getlinkedent())) {
      var_2572b03f = "<dev string:xfc>";
    } else {
      var_2572b03f = "<dev string:x104>";
    }

    print3d(self.origin + (0, 0, -20), "<dev string:x10d>" + self.targetname + "<dev string:x117>" + cur_state + "<dev string:x123>" + var_2572b03f, (1, 1, 1), 1, 0.3, n_frames);
    waitframe(n_frames);
  }
}

function init_clientfields() {
  clientfield::register("toplayer", "lerp_fov", 1, 3, "int");
}

function swap_head(notify_str, head_model) {
  if(isDefined(notify_str)) {
    level waittill(notify_str);
  }

  if(isDefined(self.hatmodel)) {
    self detach(self.hatmodel);
  }

  if(isDefined(self.head)) {
    self detach(self.head);
  }

  self attach(head_model);
  self.head = head_model;
}

function function_53531f27(key, val = "targetname") {
  trig = getent(key, val);

  if(isDefined(trig) && trig istriggerenabled()) {
    trig trigger::use();
  }
}

function setup_objectives(var_567f1ddd) {
  switch (var_567f1ddd) {
    case # "tkdn_heli_intro":
      level waittill(#"hash_428d72621587561a");
    case # "tkdn_heli_trailer_park":
    case # "tkdn_heli_convoy_aslt":
    case # "hash_75cfe0319f9e4615":
      level thread function_ea61a18();
      break;
    case # "tkdn_heli_hotel_breach":
      level thread function_ea61a18();
      break;
    case # "tkdn_heli_exfil":
    default:
      break;
  }
}

function function_ea61a18() {
  objectives::scripted("hit1", undefined, #"hash_43b030a370a2cc4c", 0);
  level flag::wait_till(#"hash_5601fb6019314f30");
  objectives::complete("hit1");
}

function function_6154e4c2() {
  var_4f2ba130 = self getweaponslist();

  foreach(e_w in var_4f2ba130) {
    self takeweapon(e_w);
  }

  frag = getweapon(#"frag_grenade");

  if(!self hasweapon(frag)) {
    self giveweapon(frag);
    self setweaponammoclip(frag, 3);
    self setweaponammostock(frag, 3);
  }

  var_feaf9c84 = getweapon(#"eq_flash_grenade");

  if(!self hasweapon(var_feaf9c84)) {
    self giveweapon(var_feaf9c84);
    self setweaponammoclip(var_feaf9c84, 3);
    self setweaponammostock(var_feaf9c84, 3);
  }

  secondary_weapon = getweapon(#"shotgun_pump_t9", array("reflex", "extbarrel2", "grip", "quickdraw", "stalker"));
  primary_weapon = getweapon(#"lmg_slowfire_t9", array("reflex2", "fastreload", "quickdraw2", "stalker"));
  self giveweapon(primary_weapon);
  self giveweapon(secondary_weapon);
  self givemaxammo(primary_weapon);
  self givemaxammo(secondary_weapon);
  self clientfield::set_to_player("force_stream_weapons", 1);
  self switchtoweapon(primary_weapon);
}

function function_fbb0d73f() {
  self endon(#"death");
  self setrotorspeed(1);
  self.soundmod = "heli";
  self val::set("heli", "ignoreme", 1);
  self vehicle::toggle_tread_fx(1);
  self vehicle::toggle_exhaust_fx(1);
  self vehicle::toggle_sounds(1);
  self vehicle::lights_on();
  self turret::_init_turret(1);
  self turret::_init_turret(2);
  self turret::set_burst_parameters(0.5, 1.2, 4, 6, 1);
  self turret::set_burst_parameters(0.5, 1.2, 4, 6, 2);
  self turret::set_target_leading(1, 0.4);
  self turret::set_target_leading(2, 0.4);
  self turret::function_f5e3e1de(1, 1);
  self turret::function_f5e3e1de(1, 2);
  self turret::set_on_target_angle(20, 1);
  self turret::set_on_target_angle(20, 2);
  self.var_cb55c804 = 30;
  self setneargoalnotifydist(self.var_cb55c804);
  self sethoverparams(30, 20, 20);
  self.drivepath = 1;
  self vehicle::god_on();
  self vehicle_ai::set_state("scripted", {
    #no_clear_movement: 1, #var_a22ee662: 1
  });
}

function function_9aa54139() {
  self endon(#"death");
  self setrotorspeed(1);
  self.soundmod = "heli";
  self val::set("heli", "ignoreme", 1);
  self vehicle::toggle_tread_fx(1);
  self vehicle::toggle_exhaust_fx(1);
  self vehicle::toggle_sounds(1);
  self vehicle::lights_on();
  self.var_cb55c804 = 30;
  self setneargoalnotifydist(self.var_cb55c804);
  self sethoverparams(30, 20, 20);
  self vehicle::god_on();
  self vehicle_ai::set_state("scripted", {
    #no_clear_movement: 1, #var_a22ee662: 1
  });
}

function function_4c12f50() {
  self endon(#"death");
  var_31203ce7 = # "hash_6c5af7e35803f61d";
  a_ai = spawner::simple_spawn("heli_crew_second_heli");
  array::thread_all(a_ai, &val::set, var_31203ce7, "ignoreme", 1);
  array::thread_all(a_ai, &val::set, var_31203ce7, "allowdeath", 0);

  foreach(ai in a_ai) {
    vehicle::get_in(ai, self, ai.script_startingposition);
    ai setnosunshadow();

    if(issubstr(ai.script_startingposition, "gunner")) {
      ai ai::gun_remove();
    }
  }
}

function function_3cebcd1b() {
  self endon(#"death");
  self notify("4d8893cd1e0887cc");
  self endon("4d8893cd1e0887cc");
  level endon(#"tkdn_heli_exfil");
  var_979d3fe0 = [#"hit1_truck_rear", #"hit1_truck_house", #"hit1_truck_mid", #"hit1_truck_front", #"heli_focus_door_breach", #"heli_focus_gas_garage"];
  var_f01b798 = ["hit1_truck_rear", "hit1_truck_house", "hit1_truck_mid", "hit1_truck_front", "heli_focus_door_breach", "heli_focus_gas_garage"];

  while(true) {
    ret = level waittill(var_f01b798);
    var_87c48267 = "GetEntDislikesHashStrings";

    for(i = 0; i < var_979d3fe0.size; i++) {
      if(var_979d3fe0[i] == ret._notify) {
        var_87c48267 = var_f01b798[i];
        break;
      }
    }

    var_4cd99adc = getent(var_87c48267, "script_noteworthy", 1);

    if(!isDefined(var_4cd99adc)) {
      var_4cd99adc = struct::get(var_87c48267, "targetname");
    }

    if(isDefined(var_4cd99adc)) {
      self thread function_cbe25a41(var_4cd99adc, "tag_searchlight_fx", 1);
      level.var_7c11765c = gettime() + 2000;
      continue;
    }

    iprintlnbold("<dev string:x130>" + var_87c48267);
  }
}

function function_f97ce389(heli, tag, var_2d65f507, var_5525c0b0) {
  heli endon(#"death");
  heli.light = util::spawn_model("tag_origin", heli gettagorigin(tag) + (0, 0, -84), heli gettagangles(tag) + var_2d65f507);
  heli.light linkto(heli, "tag_searchlight_fx", (0, 0, 0), (0, 0, 0));

  if(var_5525c0b0) {
    util::delay(0.3, undefined, &playfxontag, #"hash_f80473c70ea6ee3", heli.light, "tag_origin");
    return;
  }

  heli.var_59c586ad = playFXOnTag(#"hash_7d057d370983507f", heli.light, "tag_origin");
}

function heli_light(heli, tname, tag, var_2d65f507, var_ba240678, var_fa2357fe = 0, var_1a67724f = 0, var_5525c0b0 = 0) {
  fx_light = 1;
  heli endon(#"death");
  heli waittill(#"lights_on");
  heli.col_hack = (1, 0, 0);

  if(!isDefined(level.var_eaf95d92)) {
    level.var_eaf95d92 = [];
  }

  if(!isDefined(level.var_eaf95d92[tname])) {
    if(fx_light) {
      if(!var_1a67724f) {
        level thread function_f97ce389(heli, tag, var_2d65f507, var_5525c0b0);
      }
    } else {
      heli.light = getent(tname, "targetname");

      if(!isDefined(heli.light)) {
        heli.light = getent(tname + "_temp", "targetname");
      }
    }

    if(isDefined(heli.light)) {
      heli.light linkto(heli, tag, (0, 0, -64), var_2d65f507);
      level.var_eaf95d92[tname] = heli.light;
    }
  }

  if(isDefined(var_ba240678)) {
    heli thread function_cbe25a41(var_ba240678, tag, var_fa2357fe, var_1a67724f, var_5525c0b0);
  }
}

function function_336e9e88() {
  self endon(#"death");

  while(true) {
    sphere(self.origin + (0, 0, 12), 4, (1, 1, 0), 1, 0, 10, 1);
    sphere(self.origin, 8, (1, 1, 0), 1, 0, 10, 1);

    waitframe(1);
  }
}

function function_cbe25a41(var_4cd99adc, tag = "tag_origin", var_fa2357fe = 0, var_1a67724f = 0, var_5525c0b0 = 0, var_2526f86c = 0) {
  self endon(#"death");
  self endon(#"hash_48aad0ddc0d9bf5d");
  var_869cc293 = "tag_missle_target";

  if(isDefined(self.var_ba240678)) {
    self.var_ba240678.tracking = var_4cd99adc;
    self.var_9fa13062 = 0;
    self.var_c7d51a18 = 0;

    if(self.var_1a67724f || is_true(self.var_2526f86c)) {
      self.var_ba240678 unlink();
    }

    self.var_1a67724f = var_1a67724f;
    self.var_2526f86c = var_2526f86c;

    if(self.var_1a67724f) {
      self.var_ba240678 linkto(self, var_869cc293, (0, 0, 0), (0, 0, 0));
    } else if(self.var_2526f86c) {
      self.var_ba240678 linkto(var_4cd99adc, tag, (0, 0, 0), (0, 0, 0));
    }

    n_radius = 75;
    n_speed = 100;
    n_accel = 50;
    self sethoverparams(n_radius, n_speed, n_accel);
    return;
  }

  self.var_9fa13062 = 0;
  self.var_c7d51a18 = 0;
  self.var_19a7fb91 = 32 + randomfloat(64);
  self.var_19a7fb91 = 96;
  self.var_ba240678 = util::spawn_model("tag_origin", var_4cd99adc.origin, var_4cd99adc.angles);
  self.var_113b6995 = 2;
  self.var_35f26704 = 0;
  self.var_43643137 = (0, 0, 36);
  self.forward_scalar = 128;
  self.var_1a67724f = var_1a67724f;
  self.var_ba240678 endon(#"death");

  if(self.var_1a67724f || !isDefined(self.light)) {
    self.var_ba240678 linkto(self, var_869cc293, (0, 0, 0), (0, 0, 0));
    level thread function_f97ce389(self, tag, (0, 0, 0), var_5525c0b0);
  }

  self.light endon(#"death");
  var_61bc4e7 = 0;

  if(var_fa2357fe) {
    var_8c29c159 = getent("light_ally_helispot_bnc", "targetname");

    if(isDefined(var_8c29c159)) {
      var_8c29c159.var_6da8d78a = 1;
      var_8c29c159 linkto(self.var_ba240678, "tag_origin", (0, 0, -200), (0, 0, 0));

      if(var_61bc4e7) {
        var_8c29c159 thread function_336e9e88();
      }
    }
  }

  self.var_ba240678.tracking = var_4cd99adc;
  self clientfield::set("hit1_helispotlight", 1);
  waitframe(1);
  self.light clientfield::set("hit1_light", 1);
  waitframe(1);
  self.var_ba240678 clientfield::set("hit1_track_ent", 1);
  waitframe(1);

  if(isvehicle(self.var_ba240678.tracking)) {
    self.var_ba240678.tracking clientfield::set("hit1_track_vehicle", 1);
  } else {
    self.var_ba240678.tracking clientfield::set("hit1_tracking", 1);
  }

  var_13ad4669 = 0.05;
  n_radius = 75;
  n_speed = 100;
  n_accel = 50;
  self sethoverparams(n_radius, n_speed, n_accel);
  self.var_2791e894 = 0;

  while(true) {
    if(!isDefined(self.var_ba240678.tracking) && self.var_1a67724f == 0) {
      waitframe(1);
      continue;
    }

    if(is_true(var_61bc4e7)) {
      sphere(self.var_ba240678.origin, 8, (1, 0, 0), 1, 0, 10, 1);
      sphere(self.var_ba240678.tracking.origin, 4, (0, 0, 1), 1, 0, 10, 1);
    }

    if(!(self.var_1a67724f || is_true(self.var_2526f86c))) {
      end_point = self.var_ba240678.tracking.origin + self.var_43643137 + anglesToForward(self.var_ba240678.tracking.angles) * self.forward_scalar;
      dist = distance(self.var_ba240678.origin, end_point);

      if(!self.var_9fa13062 && !self.var_c7d51a18) {
        if(dist > self.var_19a7fb91) {
          self.var_9fa13062 = 1;
          self.var_c1cda03b = 0.025;
          self.var_ab0fdcd8 = self.var_c1cda03b;
          self.var_7c772b29 = self.var_ba240678.origin;

          if(is_true(var_61bc4e7)) {
            sphere(end_point, 4, (0, 0, 1), 1, 0, 10, 40);
          }

          self.var_ba240678 thread easing::ease_origin(end_point, self.var_113b6995, #"back", undefined, 0, 1, 1, [0.35, 3.5]);
          self.var_35f26704 = gettime() + self.var_113b6995 * 1000;
          self sethoverparams(75, 100, 50);
        }
      } else if(self.var_9fa13062 && self.var_35f26704 < gettime()) {
        self.var_9fa13062 = 0;

        if(dist < self.var_19a7fb91) {
          self.var_35f26704 = gettime() + self.var_113b6995 * 1000 / 3;
          self.var_c7d51a18 = 1;
          end_point = self.var_ba240678.tracking.origin + self.var_43643137 + anglesToForward(self.var_ba240678.tracking.angles) * self.forward_scalar;

          if(is_true(var_61bc4e7)) {
            sphere(end_point, 4, (1, 0, 0), 1, 0, 10, 20);
          }

          self.var_ba240678 thread easing::ease_origin(end_point, self.var_113b6995 / 3, #"sine", undefined, 0, 1, 1);
        }
      } else if(self.var_c7d51a18) {
        if(self.var_35f26704 < gettime()) {
          self.var_c7d51a18 = 0;
        }
      }
    }

    tag_ang = self gettagangles(tag);
    org = self gettagorigin(tag) + (0, 0, -10);
    to = vectortoangles(self.var_ba240678.origin - org);
    var_172edc78 = to - tag_ang;
    waitframe(1);
  }
}

function function_aa3c5fab(params) {
  if(!isDefined(level.var_9a3944f4)) {
    return;
  }

  level.var_9a3944f4.forward_scalar = 1;
  attacker = params.eattacker;

  if(isDefined(attacker) && isai(attacker)) {
    if(attacker == level.last_player_attacker) {
      level.var_9a3944f4 thread function_cbe25a41(attacker, "tag_searchlight_fx", 1);
      level.var_7c11765c = gettime();
      return;
    }

    if(level.var_7c11765c < gettime() - 1500 || !isalive(level.last_player_attacker)) {
      level.var_7c11765c = gettime();
      level.last_player_attacker = attacker;
      level.var_9a3944f4 thread function_cbe25a41(attacker, "tag_searchlight_fx", 1);
    }
  }
}

function function_76075c60() {
  self notify("2f6249d055a44c33");
  self endon("2f6249d055a44c33");
  self endon(#"death");
  level.player endon(#"death");
  self.forward_scalar = 1;
  n_duration = 2;
  var_b2fb0514 = 1000;

  while(true) {
    s = level.player waittilltimeout(n_duration, #"damage");

    if(isDefined(s.attacker) && isai(s.attacker)) {
      if(s.attacker === level.last_player_attacker) {
        self thread function_cbe25a41(s.attacker, "tag_searchlight_fx", 1);
        level.var_7c11765c = gettime();
        continue;
      }

      if(level.var_7c11765c < gettime() - var_b2fb0514 || !isalive(level.last_player_attacker)) {
        level.var_7c11765c = gettime();
        level.last_player_attacker = s.attacker;
        self thread function_cbe25a41(s.attacker, "tag_searchlight_fx", 1);
      }

      continue;
    }

    a_axis = getaiteamarray("axis");

    if(a_axis.size) {
      arraysortclosest(a_axis, level.player.origin);
      self thread function_cbe25a41(a_axis[randomintrange(0, a_axis.size)], "tag_searchlight_fx", 1);
    }
  }
}

function function_48f9ff4e(var_b5175c20, str_flag, n_movetime = 1.5, var_1356d773 = 1) {
  self endon(#"death");
  var_2cd170e0 = struct::get(var_b5175c20, "targetname");
  e_mover = util::spawn_model("tag_origin", var_2cd170e0.origin, var_2cd170e0.angles);
  e_mover thread function_c38d67b4(var_2cd170e0, n_movetime);
  self turretsettarget(var_1356d773, e_mover);
  var_af2a1727 = [(0, 0, 100), (-100, -100, -100)];

  while(!level flag::get(str_flag)) {
    self fireweapon(var_1356d773);
    waitframe(1);
    self fireweapon(var_1356d773, undefined, var_af2a1727[randomint(var_af2a1727.size)]);
    waitframe(1);
  }

  self stopfireweapon();
  self turretcleartarget(var_1356d773);
  e_mover delete();
}

function function_e6d1297a(ent) {
  self endon(#"death");
  e_mover = util::spawn_model("tag_origin", self gettagorigin("j_spine4"), self gettagangles("j_spine4"));
  e_mover linkto(ent, "j_spine4");
  var_1356d773 = 1;
  self stopfireweapon();
  self turretcleartarget(var_1356d773);
  self turretsettarget(var_1356d773, e_mover);

  while(isalive(ent)) {
    var_3c84e44c = ent getvelocity();
    self fireweapon(var_1356d773, e_mover);

    if(isDefined(ent)) {
      line(self.origin, ent.origin);
    }

    waitframe(1);
  }

  self stopfireweapon();
  self turretcleartarget(var_1356d773);
  e_mover delete();
}

function function_c38d67b4(var_d4cf58ab, n_move_time) {
  self endon(#"death");
  var_55555ae4 = [];
  var_55555ae4[var_55555ae4.size] = var_d4cf58ab;
  var_d5c428c9 = var_55555ae4[0];

  while(isDefined(var_d5c428c9.target)) {
    s = struct::get(var_d5c428c9.target, "targetname");
    var_55555ae4[var_55555ae4.size] = s;
    var_d5c428c9 = s;
    waitframe(1);
  }

  for(i = 1; true; i = 0) {
    self moveto(var_55555ae4[i].origin, n_move_time, n_move_time * 0.33, n_move_time * 0.33);
    wait n_move_time;
    i++;

    if(i == var_55555ae4.size) {}
  }
}

function function_3958f4d7(var_89b78ba7) {
  var_85c397ce = getEntArray(var_89b78ba7, "targetname");
  var_18698d26 = getent(var_89b78ba7 + "_loaner", "targetname");
  var_2b0724ab = "exp_" + var_89b78ba7;
  var_ad298278 = ["tag_headlight_left_d0", "tag_headlight_right_d0"];

  if(var_85c397ce.size) {
    for(i = 0; i < var_85c397ce.size; i++) {
      var_4f8abe54 = var_ad298278[i];
      var_8f68e214 = var_85c397ce[i];

      if(self haspart(var_4f8abe54)) {
        var_8f68e214 linkto(self, var_4f8abe54, (0, 0, 0), (15, 0, 0));
      } else {
        var_8f68e214 linkto(self);
      }

      var_8f68e214.part = var_4f8abe54;
      playFXOnTag("vehicle/fx9_light_ru_truck_light_head_source", self, var_4f8abe54);
    }

    if(isDefined(var_18698d26)) {
      var_18698d26 linkto(self, var_4f8abe54, (-40, 28, 8), (15, 0, 0));
    }

    if(isDefined(var_2b0724ab)) {
      exploder::exploder(var_2b0724ab);
    }

    self thread function_c7a4bc11({
      #parts: var_ad298278, #lights: var_85c397ce, #var_5adc4dbd: var_18698d26, #var_ff97e2b9: var_2b0724ab
    });
    return;
  }

  iprintlnbold("<dev string:x14f>" + var_89b78ba7 + "<dev string:x168>" + self.targetname + "<dev string:x196>");

  self vehicle::lights_on();
}

function function_c7a4bc11(var_6031745) {
  self notify("2211cbd0ce327b59");
  self endon("2211cbd0ce327b59");
  var_b1ea0b0c = 3;

  while(var_6031745.parts.size && isalive(self)) {
    result = self waittill(#"damage", #"death");

    if(result._notify === "damage" && self.health > 1) {
      if(!isPlayer(result.inflictor)) {
        continue;
      }

      if(array::contains(var_6031745.parts, result.part_name)) {
        arrayremovevalue(var_6031745.parts, result.part_name);

        foreach(light in var_6031745.lights) {
          if(light.part === result.part_name) {
            light setlightintensity(0);
            waitframe(var_b1ea0b0c);
            light unlink();
            light delete();
          }
        }
      }

      continue;
    }

    foreach(light in var_6031745.lights) {
      if(isDefined(light)) {
        light setlightintensity(0);
        waitframe(var_b1ea0b0c);
        light unlink();
        light delete();
      }
    }
  }

  if(isDefined(var_6031745.var_ff97e2b9)) {
    exploder::stop_exploder(var_6031745.var_ff97e2b9);
  }
}

function function_d6fedf97(guys, killcount, sflag, timeout) {
  ai::waittill_dead_or_dying(guys, killcount, timeout);
  level flag::set(sflag);
}

function function_603d935(var_c5827a95, n_goalradius = 200, var_dd47e22 = 0.1, var_27ff9e4 = 0.4) {
  self endon(#"death");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy === "run_to_delete") {
    a_nodes = getnodearraysorted("delete_runner_node", "targetname", self.origin, 2048);

    if(a_nodes.size) {
      self ai::force_goal(a_nodes[0], 0);
      self waittill(#"goal");
      self deletedelay();
      return;
    } else {
      iprintlnbold("<dev string:x19b>");
    }
  }

  e_vol = getent(var_c5827a95, "targetname");
  wait randomfloatrange(var_dd47e22, var_27ff9e4);
  self notify(#"stop_going_to_node");
  self val::set(#"hash_4629ea2949a36bbb", "goalradius", n_goalradius);
  var_11ac69bf = undefined;

  if(math::cointoss()) {
    var_11ac69bf = 1;
  }

  self colors::disable();
  self thread ai::force_goal(e_vol, var_11ac69bf);
  self.ignoresuppression = 1;
  self.grenadeawareness = 0;
  self ai::set_behavior_attribute("sprint", 1);
  self waittill(#"reached_path_end");
  self.ignoresuppression = 0;
  self.grenadeawareness = 1;
  self ai::set_behavior_attribute("sprint", 0);
  self colors::enable();
  self val::reset_all(#"hash_4629ea2949a36bbb");
}

function function_ed760ecb(var_a7f24c3d, var_b895b611 = 1, var_d3440450 = level.var_28c22d88[0]) {
  ai = getent(var_a7f24c3d, "targetname", 1);

  if(!isalive(ai)) {
    var_e582d78a = getent(var_a7f24c3d, "targetname");
    ai = spawner::simple_spawn_single(var_e582d78a);
  }

  ai val::set(#"hash_6ac19077c919e860", "allowdeath", 0);

  if(!isDefined(level.allies)) {
    level.allies = [];
  } else if(!isarray(level.allies)) {
    level.allies = array(level.allies);
  }

  if(!isinarray(level.allies, ai)) {
    level.allies[level.allies.size] = ai;
  }

  if(is_true(var_b895b611)) {
    ai function_55623c92(var_d3440450, var_a7f24c3d);
  }

  ai setgoal(ai.origin);
  level.(var_a7f24c3d) = ai;
  return ai;
}

function function_55623c92(var_d3440450 = level.var_28c22d88[0], str_name = self.targetname) {
  var_142cfe56 = var_d3440450 + "_" + str_name;
  s_org = struct::get(var_142cfe56, "targetname");

  if(isDefined(s_org)) {
    self forceteleport(s_org.origin, s_org.angles);
  } else {
    iprintln("<dev string:x1ec>" + str_name + "<dev string:x1f3>" + level.var_c2ccaeac + "<dev string:x21c>");
  }

  if(isDefined(s_org.target)) {
    self ai::set_goal(s_org.target, "targetname");
  }
}

function function_2afe54() {
  self delete();
}

function function_436c1448(var_ece5e59a, var_d7cb8f95, var_fbe510c2 = 6, var_3ec774da = 1) {
  self endon(#"death", var_d7cb8f95);
  level endon(var_d7cb8f95);
  i = 0;

  while(true) {
    wait var_fbe510c2;

    if(level flag::get(var_d7cb8f95) || self flag::get(var_d7cb8f95)) {
      return;
    }

    self dialogue::queue(var_ece5e59a[i]);
    i++;

    if(i == var_ece5e59a.size) {
      i = 0;
    }

    if(is_true(var_3ec774da)) {
      var_fbe510c2 *= 1.5;
    }
  }
}