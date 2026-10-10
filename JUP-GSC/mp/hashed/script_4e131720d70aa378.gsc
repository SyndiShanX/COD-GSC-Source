/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4e131720d70aa378.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_7edf952f8921aa6b;
#using scripts\aitypes\zombie_abom\zombie_abom_metabones;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_e9b11a352725c944;

function function_cf142512f48666b7(params) {
  level._effect["abom_beam_fx"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_zai_abom_beam.vfx");
  level._effect["abom_beam_hit_fx"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_zai_abom_beam_target.vfx");
  level._effect["abom_beam_tip_fx"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_zai_abom_beam_tip.vfx");
  level._effect["abom_mega_beam_fx"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_megabomb_beam.vfx");
  level._effect["abom_mega_beam_hit_fx"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_zai_abom_beam_target.vfx");
  level._effect["abom_mega_beam_tip_fx"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_megabomb_beam_tip.vfx");
}

function function_75a233b1c9abd8f() {
  thread function_182410ab5b6fb9bc();
  thread function_930d5914e10d5346();
  self.var_9a4d2d08feefac73 = [];

  for(head_index = 0; head_index <= 2; head_index++) {
    self.var_9a4d2d08feefac73[head_index] = spawn("script_model", (0, 0, 0));
    self.var_9a4d2d08feefac73[head_index] setModel(self.zombieaisettings.var_e58a65b7a8f5973c.var_a20e9b98232bb5f4);
    self.var_9a4d2d08feefac73[head_index] utility::function_3677f2be30fdd581("beam_tip", "off");
    thread delete_on_death(self.var_9a4d2d08feefac73[head_index]);
  }

  self.var_2c320bc0dc4f6799 = [];
  self.var_d3b24d5f093d5e28 = [];
  self.var_d3b24d5f093d5e28[0] = "tag_fx_head_le_throat";
  self.var_d3b24d5f093d5e28[1] = "tag_fx_head_center_throat";
  self.var_d3b24d5f093d5e28[2] = "tag_fx_head_ri_throat";
  self.var_90ead69a54beacc9 = [];
  self.aimyawspeed = 10;
  self function_3e89eb3d8e3f1811("beam_attack_cooldown", 30000);

  function_45e1e95fc9efceff();
}

function private function_da88e000ff6f242f(entity, hit_ent, num_beams, can_dissolve) {
  beam_damage = 4 + num_beams * 1;

  if(isai(hit_ent) && isDefined(hit_ent.maxhealth)) {
    beam_damage = max(hit_ent.maxhealth * 0.1, beam_damage * 2);

    if(can_dissolve) {
      if(!istrue(self.zombieaisettings.var_e58a65b7a8f5973c.var_3ef3fffffdcdc02a)) {
        beam_damage *= 3;
      }
    }

    if(is_equal(hit_ent.aicategory, "boss")) {
      return 0;
    }
  } else if(isPlayer(hit_ent)) {
    beam_damage = int(beam_damage * getdvarfloat(@ "hash_801a4981ce836d30", 1));
  }

  return beam_damage;
}

function function_66d92e1111a38ee9(asmname, statename, tostatename, params) {
  if(!isDefined(self.enemy) || !isalive(self.enemy)) {
    return true;
  }

  if(!math::is_point_in_front(self.enemy.origin)) {
    function_8a5018a3e30b704f();

    beam_print("<dev string:x1c>");

    return true;
  }

  if(distance2dsquared(self.enemy.origin, self.origin) < squared(self.melee_range)) {
    beam_print("<dev string:x3b>");

    return true;
  }

  var_c8c23052c39bc69a = gettime() - default_to(self.var_854c33494a097e21, 0);
  var_41f14a9d49e907c = getdvarint(@ "hash_7c663c1d1f1b1fab", 6000);

  if(var_41f14a9d49e907c > 0 && var_c8c23052c39bc69a > var_41f14a9d49e907c) {
    beam_print("<dev string:x63>");

    return true;
  }

  var_d0e04c2289257723 = gettime() - default_to(self.var_c84d64668e4e6d47, 0);
  var_c9db76492248aca0 = getdvarint(@ "hash_5a02ebc4afef300d", 3000);

  if(var_c9db76492248aca0 > 0 && var_d0e04c2289257723 > var_c9db76492248aca0) {
    beam_print("<dev string:x83>");

    return true;
  }

  var_17850e916c131df7 = self function_a3779ffa296b2f99();

  if(isDefined(var_17850e916c131df7)) {
    beam_print("<dev string:xa7>", var_17850e916c131df7);
    line(self.origin, self function_a3779ffa296b2f99(), (1, 1, 0));
  }

  if(isDefined(var_17850e916c131df7) && !math::is_point_in_front(var_17850e916c131df7)) {
    beam_print("<dev string:xb2>");

    return true;
  }

  return false;
}

function private function_182410ab5b6fb9bc() {
  self endon("death");

  while(true) {
    self waittill("beam_attack_intro_start");
    utility::function_3ab9164ef76940fd("beam_tell", "beam_tell_on");
    self waittill("beam_attack_intro_end");
    utility::function_3ab9164ef76940fd("beam_tell", "beam_tell_off");
  }
}

function private function_930d5914e10d5346() {
  self endon("death");

  while(true) {
    self waittill("beam_attack_loop_start");

    if(istrue(self function_11e2d4051ea44b35("in_beam_attack"))) {
      self.var_854c33494a097e21 = gettime();
      self function_3e89eb3d8e3f1811("beam_attack_cooldown", 30000);

      if(isDefined(self.enemy)) {
        self getenemyinfo(self.enemy);
      }

      thread function_13f829a62eb5d21a();
      thread function_bb1b67da31c9b073();
    }
  }
}

function private function_13f829a62eb5d21a() {
  self endon("death");
  self endon("beam_attack_loop_finished");
  beams_created = 0;
  var_3aa70c7a997446b9 = self.enemy;
  var_5cc980dd8bb1fd02 = 0;
  var_70ea1e27e5d67eaf = [(0, 0, 0), (0, 0, 0), (0, 0, 0)];
  var_607dd22e123cc194 = [(0, 0, 0), (0, 0, 0), (0, 0, 0)];
  round_number = function_2201d3f3d7ab07a7();
  var_a1c42ad56045a94d = 10 + clamp(math::remap(round_number, 20, 30, 0, 25), 0, 25);
  var_fc8cef22d2662288 = 45;
  kill_queue = [];

  while(true) {
    var_3aa70c7a997446b9 = self.enemy;
    clamp_pitch = ter_op(isai(var_3aa70c7a997446b9), 2, 1) * var_fc8cef22d2662288;
    round_number = function_2201d3f3d7ab07a7();
    var_a7c8081f62161240 = math::remap(round_number, 20, 30, 0, 1);
    var_754a0ac8af18875d = gettime() - default_to(self.var_c84d64668e4e6d47, 0);
    var_ce47fa867b5efda9 = 5000;

    if(var_754a0ac8af18875d > var_ce47fa867b5efda9) {
      var_a7c8081f62161240 = 1;
    }

    self.aimyawspeed = 10 + clamp(var_a7c8081f62161240, 0, 1) * 50;
    beam_length = self.zombieaisettings.var_e58a65b7a8f5973c.var_a9e8db47e0618b28;
    var_1fd01e8ed4e7ceb5 = self.var_d3b24d5f093d5e28[1];
    head_angles = self gettagangles(var_1fd01e8ed4e7ceb5);
    head_angles = (0, head_angles[1], 0);
    head_pos = self gettagorigin(var_1fd01e8ed4e7ceb5);
    var_cdf2c3e51c96c434 = anglesToForward(head_angles);
    var_d8e0d0e55a3fa02b = function_917da7c89d67b27b();
    var_259257f526d63b6d = [];

    for(priority_i = 1; priority_i < var_d8e0d0e55a3fa02b.size; priority_i++) {
      var_259257f526d63b6d = array_add(var_259257f526d63b6d, var_d8e0d0e55a3fa02b[priority_i]);
    }

    secondary_targets = [];

    if(var_259257f526d63b6d.size > 0 && isDefined(var_3aa70c7a997446b9)) {
      var_58ff9912c00fb565 = default_to(self.zombieaisettings.var_e58a65b7a8f5973c.var_d4d3fb3f1b2ef02, 250);
      var_5b52fa257178a1df = physics_querypoint(var_3aa70c7a997446b9.origin, var_58ff9912c00fb565, physics_createcontents(["physicscontents_characterproxy"]), [self, var_3aa70c7a997446b9], "physicsquery_all");

      foreach(potential_target in var_5b52fa257178a1df) {
        if(var_259257f526d63b6d.size <= 0) {
          break;
        }

        target_ent = potential_target["entity"];

        if(!isalive(target_ent) || target_ent.team == self.team) {
          continue;
        }

        var_3689502790cb7dfe = math::function_1c46b3e291eff242(target_ent.origin - self.origin, var_cdf2c3e51c96c434);

        if(var_3689502790cb7dfe) {
          if(array_contains(var_259257f526d63b6d, 2)) {
            var_259257f526d63b6d = array_remove(var_259257f526d63b6d, 2);
            secondary_targets[2] = target_ent;
          }
        } else if(array_contains(var_259257f526d63b6d, 0)) {
          var_259257f526d63b6d = array_remove(var_259257f526d63b6d, 0);
          secondary_targets[0] = target_ent;
        }

        beam_print("<dev string:xd3>" + ter_op(var_3689502790cb7dfe, "<dev string:xe0>", "<dev string:xe9>"), target_ent.origin + (0, 0, 70));
      }
    }

    var_86720ff875e123cb = var_d8e0d0e55a3fa02b[0];

    foreach(head_index in var_d8e0d0e55a3fa02b) {
      var_5d5285fb1aa381ff = undefined;
      is_primary = head_index == var_86720ff875e123cb;

      if(is_primary || isDefined(secondary_targets[head_index])) {
        target_ent = ter_op(is_primary, var_3aa70c7a997446b9, secondary_targets[head_index]);
        var_5d5285fb1aa381ff = function_2aac335c6c6cea96(var_70ea1e27e5d67eaf[head_index], target_ent, head_index, is_primary, head_angles, head_pos, clamp_pitch, var_a1c42ad56045a94d);
      } else {
        var_5d5285fb1aa381ff = var_70ea1e27e5d67eaf[var_86720ff875e123cb];
      }

      var_70ea1e27e5d67eaf[head_index] = function_9ad4af8fe5c34b1d(var_70ea1e27e5d67eaf[head_index], var_5d5285fb1aa381ff);
      var_607dd22e123cc194[head_index] = function_cbd6bdebcfc8b014(var_70ea1e27e5d67eaf[head_index], head_angles, head_pos, beam_length);
    }

    var_bf17a1557a2b2486 = [];
    var_7dd5b5b98f1f4795 = [];
    var_4ceed1e2c078e87b = [];
    current_time = gettime();
    assert(isDefined(self.var_9a4d2d08feefac73));

    for(var_a94f488377f3c78a = 0; var_a94f488377f3c78a <= 2; var_a94f488377f3c78a++) {
      if(function_b2fae60b8f9f98b2(self, var_a94f488377f3c78a)) {
        source_pos = self gettagorigin(self.var_d3b24d5f093d5e28[var_a94f488377f3c78a]);
        beam_trace = scripts\engine\trace::ray_trace(source_pos, var_607dd22e123cc194[var_a94f488377f3c78a]);
        end_pos = var_607dd22e123cc194[var_a94f488377f3c78a];
        var_4b5a75d5223543c8 = physics_getsurfacetypefromflags(beam_trace["surfaceflags"]);
        var_2b9c39598d19ea34 = var_4b5a75d5223543c8["name"];

        if(isstartstr(var_2b9c39598d19ea34, "surftype_water")) {
          beam_trace = scripts\engine\trace::ray_trace(beam_trace["position"], var_607dd22e123cc194[var_a94f488377f3c78a]);
        }

        hit_something = beam_trace["fraction"] < 1;

        if(hit_something) {
          end_pos = beam_trace["position"];
        }

        var_41b133fe058bf8d = self.var_9a4d2d08feefac73[var_a94f488377f3c78a] getscriptablepartstate("beam_tip") == "off";

        if(var_41b133fe058bf8d || !is_equal(hit_something, self.var_90ead69a54beacc9[var_a94f488377f3c78a])) {
          if(hit_something) {
            self.var_9a4d2d08feefac73[var_a94f488377f3c78a] utility::function_3677f2be30fdd581("beam_tip", "hit");
          } else {
            self.var_9a4d2d08feefac73[var_a94f488377f3c78a] utility::function_3677f2be30fdd581("beam_tip", "hit_nothing");
          }
        }

        hit_ent = beam_trace["entity"];

        if(isDefined(hit_ent)) {
          self.var_c84d64668e4e6d47 = current_time;
          entnum = hit_ent getentitynumber();
          var_7dd5b5b98f1f4795[entnum] = default_to(var_7dd5b5b98f1f4795[entnum], 0) + 1;
          var_4ceed1e2c078e87b[entnum] = hit_ent;
        }

        self.var_90ead69a54beacc9[var_a94f488377f3c78a] = hit_something;
        var_bf17a1557a2b2486[var_a94f488377f3c78a] = end_pos;
      }
    }

    for(var_a94f488377f3c78a = 0; var_a94f488377f3c78a <= 2; var_a94f488377f3c78a++) {
      if(function_b2fae60b8f9f98b2(self, var_a94f488377f3c78a)) {
        target_ent = self.var_9a4d2d08feefac73[var_a94f488377f3c78a];
        target_ent.origin = var_bf17a1557a2b2486[var_a94f488377f3c78a];

        if(!beams_created) {
          target_ent dontinterpolate();

          if(issubstr(self.subclass, "mega")) {
            self.var_2c320bc0dc4f6799[var_a94f488377f3c78a] = playfxontagsbetweenclients(getfx("abom_mega_beam_fx"), self, self.var_d3b24d5f093d5e28[var_a94f488377f3c78a], target_ent, "tag_origin");
          } else {
            self.var_2c320bc0dc4f6799[var_a94f488377f3c78a] = playfxontagsbetweenclients(getfx("abom_beam_fx"), self, self.var_d3b24d5f093d5e28[var_a94f488377f3c78a], target_ent, "tag_origin");
          }

          if(isDefined(self.var_2c320bc0dc4f6799[var_a94f488377f3c78a])) {
            self.var_2c320bc0dc4f6799[var_a94f488377f3c78a] function_cea710f9d017694a(1);
          }

          utility::function_3ab9164ef76940fd(self.var_183bb43a8d0e0829[var_a94f488377f3c78a] + "_weakpoint", "weakpoint_off");
          utility::function_3ab9164ef76940fd(self.var_183bb43a8d0e0829[var_a94f488377f3c78a] + "_beam", "beam_on");
        }
      }
    }

    beams_created = 1;

    if(!istrue(var_5cc980dd8bb1fd02)) {
      var_4947c720fa52dbf1 = 0;

      for(var_a94f488377f3c78a = 0; var_a94f488377f3c78a <= 2; var_a94f488377f3c78a++) {
        if(function_b2fae60b8f9f98b2(self, var_a94f488377f3c78a)) {
          var_4947c720fa52dbf1++;
        }
      }

      if(var_4947c720fa52dbf1 > 0) {
        utility::function_3ab9164ef76940fd("beam_audio", "beam_audio_on_" + var_4947c720fa52dbf1);
      }

      var_5cc980dd8bb1fd02 = 1;
    }

    foreach(entnum, num_beams in var_7dd5b5b98f1f4795) {
      hit_ent = var_4ceed1e2c078e87b[entnum];
      assert(isDefined(hit_ent));
      assert(num_beams > 0);

      if(!hit_ent ent_flag("abom_beam_attack_hit")) {
        can_dissolve = isai(hit_ent) && isDefined(hit_ent.subclass) && issubstr(hit_ent.subclass, "zombie_base");

        if(can_dissolve && istrue(self.zombieaisettings.var_e58a65b7a8f5973c.var_3ef3fffffdcdc02a)) {
          hit_ent ent_flag_set("dissolve");

          if(self.zombieaisettings.var_e58a65b7a8f5973c.var_2a63977888a58d8 > 0) {
            kill_info = spawnStruct();
            kill_info.ent = hit_ent;
            kill_info.time = current_time + self.zombieaisettings.var_e58a65b7a8f5973c.var_2a63977888a58d8;
            kill_queue[kill_queue.size] = kill_info;
          } else {
            hit_ent kill(self.origin, self, self, "MOD_PROJECTILE");
          }
        } else {
          damage = function_da88e000ff6f242f(self, hit_ent, num_beams, can_dissolve);
          hit_ent dodamage(damage, self.origin, self, self, "MOD_PROJECTILE");

          if(can_dissolve && damage > hit_ent.health) {
            hit_ent ent_flag_set("dissolve");
          }

          beam_print("<dev string:xf1>" + hit_ent getentitynumber() + "<dev string:x102>" + damage, hit_ent.origin + (0, 0, 72));
        }

        hit_ent ent_flag_set("abom_beam_attack_hit");
        hit_ent thread ent_flag_clear_delayed("abom_beam_attack_hit", 0.2);
      }
    }

    for(kill_index = kill_queue.size - 1; kill_index >= 0; kill_index--) {
      if(current_time >= kill_queue[kill_index].time) {
        if(isalive(kill_queue[kill_index].ent)) {
          kill_queue[kill_index].ent kill(self.origin, self, self, "MOD_PROJECTILE");
        }

        kill_queue[kill_index] = kill_queue[kill_queue.size - 1];
        kill_queue[kill_queue.size - 1] = undefined;
      }
    }

    if(function_a87645b86864efb()) {
      for(var_a94f488377f3c78a = 0; var_a94f488377f3c78a <= 2; var_a94f488377f3c78a++) {
        sphere(var_607dd22e123cc194[var_a94f488377f3c78a], 50, (1, 0, 0));

        if(isDefined(var_bf17a1557a2b2486[var_a94f488377f3c78a])) {
          sphere(var_bf17a1557a2b2486[var_a94f488377f3c78a], 20, (1, 0, 0));
          line(self gettagorigin(self.var_d3b24d5f093d5e28[var_a94f488377f3c78a]), var_bf17a1557a2b2486[var_a94f488377f3c78a], (1, 0, 0));
        }
      }
    }

    waitframe();
  }
}

function private function_917da7c89d67b27b() {
  head_priority = [];
  var_f443fc71944dc106 = [1, 0, 2];

  foreach(head_index in var_f443fc71944dc106) {
    if(function_b2fae60b8f9f98b2(self, head_index)) {
      head_priority = array_add(head_priority, head_index);
    }
  }

  return head_priority;
}

function private function_2aac335c6c6cea96(var_f28f9901bee5219e, var_3aa70c7a997446b9, head_index, var_c786483f5e0eddbc, head_angles, head_pos, clamp_pitch, clamp_yaw) {
  if(isDefined(var_3aa70c7a997446b9)) {
    var_ecdc71b3afd2d7b6 = var_3aa70c7a997446b9 getcentroid();
    var_3b73b4bab4a9ee61 = (var_ecdc71b3afd2d7b6[2] - var_3aa70c7a997446b9.origin[2]) * 2;
    var_754a0ac8af18875d = gettime() - default_to(self.var_c84d64668e4e6d47, 0);
    var_ce47fa867b5efda9 = 1000;
    var_5792393d1c69d993 = clamp(math::remap(var_754a0ac8af18875d, 0, var_ce47fa867b5efda9, 0, 1), 0, 0.8);
    var_ac03b17fc9cbce8d = (0, 0, var_3b73b4bab4a9ee61 * var_5792393d1c69d993);

    beam_print("<dev string:x10c>" + var_5792393d1c69d993, var_3aa70c7a997446b9.origin);

    target_pos = var_3aa70c7a997446b9.origin + var_ac03b17fc9cbce8d;

    if(var_c786483f5e0eddbc) {
      self.var_130b2c98c9d80a1a = target_pos;
    }

    var_26fd5f1bb657d099 = vectortoangles(target_pos - head_pos);
    pitch_clamped = int(clamp(angleclamp180(var_26fd5f1bb657d099[0] - head_angles[0]), -1 * clamp_pitch, clamp_pitch));
    var_bfb998964a6ca671 = int(clamp(angleclamp180(var_26fd5f1bb657d099[1] - head_angles[1]), -1 * clamp_yaw, clamp_yaw));
    var_fce15ec651f5ca51 = (pitch_clamped, var_bfb998964a6ca671, 0);
    return var_fce15ec651f5ca51;
  }

  return var_f28f9901bee5219e;
}

function private function_9ad4af8fe5c34b1d(var_f28f9901bee5219e, var_4ac8f68adb651800) {
  var_2fb6fb2766d40645 = getdvarfloat(@ "hash_f3c398f445ce88db", 10) * level.framedurationseconds;
  var_558413ac2021436c = getdvarfloat(@ "hash_829b91a5ea9d859a", 20) * level.framedurationseconds;
  new_yaw = math::function_804deea7a479c83b(var_f28f9901bee5219e[1], var_4ac8f68adb651800[1], var_2fb6fb2766d40645);
  new_pitch = math::function_804deea7a479c83b(var_f28f9901bee5219e[0], var_4ac8f68adb651800[0], var_558413ac2021436c);
  return (new_pitch, new_yaw, var_4ac8f68adb651800[2]);
}

function private function_cbd6bdebcfc8b014(var_f28f9901bee5219e, head_angles, head_pos, beam_length) {
  beam_angles = angleclamp(head_angles + var_f28f9901bee5219e);
  beam_forward = anglesToForward(beam_angles);
  end_point = head_pos + beam_forward * beam_length;
  return end_point;
}

function private function_bb1b67da31c9b073() {
  self endon("death");
  self waittill("beam_attack_loop_finished");

  for(var_a94f488377f3c78a = 0; var_a94f488377f3c78a <= 2; var_a94f488377f3c78a++) {
    if(isDefined(self.var_2c320bc0dc4f6799[var_a94f488377f3c78a])) {
      self.var_2c320bc0dc4f6799[var_a94f488377f3c78a] delete();
    }

    if(isDefined(self.var_9a4d2d08feefac73[var_a94f488377f3c78a])) {
      self.var_9a4d2d08feefac73[var_a94f488377f3c78a] utility::function_3677f2be30fdd581("beam_tip", "end");
    }

    utility::function_3ab9164ef76940fd(self.var_183bb43a8d0e0829[var_a94f488377f3c78a] + "_beam", "beam_off");
    utility::function_3ab9164ef76940fd("beam_audio", "beam_audio_end");
  }

  self clearpath();
  self clearbtgoal(0);
  self function_e64ea2b4e79c4b74(0);

  if(ent_flag("no_beam_attack_cooldown")) {
    self function_3e89eb3d8e3f1811("beam_attack_cooldown", 0);
    ent_flag_clear("no_beam_attack_cooldown");
  }
}

function private function_8a5018a3e30b704f() {
  if(!istrue(self.zombieaisettings.var_e58a65b7a8f5973c.var_e2963f289e5dec02)) {
    return;
  }

  if(ent_flag("on_followup_beam_cooldown")) {
    return;
  }

  ent_flag_set("on_followup_beam_cooldown");
  var_6f3c6030b2c2bb08 = 20;
  thread ent_flag_clear_delayed("on_followup_beam_cooldown", var_6f3c6030b2c2bb08);
  ent_flag_set("no_beam_attack_cooldown");
}

function function_45e1e95fc9efceff() {
  function_6e7290c8ee4f558b("<dev string:x121>");
  function_a9a864379a098ad6("<dev string:x141>", "<dev string:x156>", &function_b453b984aa01e08f);
  function_a9a864379a098ad6("<dev string:x170>", "<dev string:x185>", &function_7e09fc9744157fee);
  function_fe953f000498048f();
}

function private function_b453b984aa01e08f() {
  abom = function_6d1fbda4b8524ef2(level.players[0].origin, undefined, "<dev string:x19f>");

  if(!isDefined(abom)) {
    abom = function_6d1fbda4b8524ef2(level.players[0].origin, undefined, "<dev string:x1ae>");
  }

  if(!isDefined(abom)) {
    return;
  }

  abom function_3e89eb3d8e3f1811("<dev string:x1c2>", 1);
}

function private function_a87645b86864efb() {
  return getdvarint(@ "hash_e89dc8c72b8a01da", 0) > 0;
}

function private function_7e09fc9744157fee() {
  function_2fb888667001fc39("<dev string:x1d4>", @ "hash_e89dc8c72b8a01da");
}

function private beam_print(text, pos) {
  if(function_a87645b86864efb()) {
    pos = default_to(pos, self.origin + (0, 0, 70));
    print3d(pos, "<dev string:x1ee>" + text, (1, 0, 0));
  }
}

# /