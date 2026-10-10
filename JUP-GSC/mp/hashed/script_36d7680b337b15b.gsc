/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_36d7680b337b15b.gsc
************************************************/

#using script_16ea1b94f0f381b3;
#using script_193e3e231841082f;
#using script_3b78d23dad7ec5be;
#using script_6c63dbe7d4c85e19;
#using script_7edf952f8921aa6b;
#using script_bd0d3e8f9ff5c11;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace zombie_deathworm;

function function_2dd162d826667677() {
  self.var_544ffa1d219d6810 = undefined;
  self.var_a60b211ca1cf2a4e = 0;
  self.var_cadb0f258ae78683 = 400;
  thread function_a0d80c109b9ae1a4();

  function_c321972f4a10279a();
}

function startsnakebite(asmname, statename, params) {
  if(isDefined(self.var_6856f1954a5f95cb) && gettime() - self.var_6856f1954a5f95cb < 17000) {
    self function_3e89eb3d8e3f1811("snakebite_fast", 1);
    return;
  }

  var_de7821bc51ab43a0 = [[self.var_8f1d8328f7a9091b]]();
  alive_percentage = [[self.var_c54a21ea717fe8a5]]();
  is_injured = self.health < self.maxhealth * 0.5;

  if(var_de7821bc51ab43a0 >= 4 || var_de7821bc51ab43a0 > 1 && alive_percentage >= 1 || is_injured) {
    self function_3e89eb3d8e3f1811("snakebite_fast", 1);
    return;
  }

  self function_3e89eb3d8e3f1811("snakebite_fast", 0);
}

function function_82000d1cf70c611d(asmname, statename, params) {
  self function_3e89eb3d8e3f1811("in_snake_bite", 0);
  self.var_6856f1954a5f95cb = gettime();
}

function private function_ee486eaddde6fd68() {
  self endon("death");
  self endon("snake_bite_end");
  self.var_a60b211ca1cf2a4e = 0;
  self.var_cadb0f258ae78683 = 400;
  self.var_3f4dee1c560fc063 = undefined;
  is_fast = istrue(self function_11e2d4051ea44b35("snakebite_fast"));
  playback_rate = is_fast ? 2 : 1;
  tracking_time = 4000;
  alive_percentage = [[self.var_c54a21ea717fe8a5]]();

  if(alive_percentage >= 1 && self.var_f8adf1aaec88d636 >= 7 || alive_percentage >= 0.8 && self.var_f8adf1aaec88d636 >= 13) {
    tracking_time = 6000;
  }

  var_20624047a42925e0 = gettime() + tracking_time / playback_rate;

  while(gettime() < var_20624047a42925e0) {
    if(isDefined(self.var_544ffa1d219d6810)) {
      if(!function_e82696e7b59178f3(self.var_544ffa1d219d6810.origin)) {
        target_yaw = getyawtospot(self.var_544ffa1d219d6810.origin);
        target_yaw = clamp(target_yaw, -70, 70);
        target_dist = distance2d(self.origin, self.var_544ffa1d219d6810.origin);
        target_dist = clamp(target_dist, 471, 1886);
        self.var_a60b211ca1cf2a4e = target_yaw;
        self.var_cadb0f258ae78683 = target_dist;
        self.var_3f4dee1c560fc063 = self.var_544ffa1d219d6810.origin;

        if(function_2113bc484dd870c2()) {
          sphere(self.var_3f4dee1c560fc063, 20, (1, 0, 0));
          bite_print("<dev string:x1c>", self.var_3f4dee1c560fc063);
        }
      } else {
        bite_print("<dev string:x2a>", self.var_544ffa1d219d6810.origin);
      }
    }

    self function_a490fd20800374d8(self.var_a60b211ca1cf2a4e);
    self function_12df4eebdbb4f79(self.var_cadb0f258ae78683);

    if(function_2113bc484dd870c2()) {
      head_pos = self gettagorigin("<dev string:x45>");
      line(self.origin, head_pos, (1, 0, 0));
      bite_print("<dev string:x4f>" + distance2d(self.origin, head_pos), head_pos);
    }

    waitframe();
  }

  thread snake_bite_danger_zone();

  bite_print("<dev string:x65>" + self.var_cadb0f258ae78683);

  if(self.var_cadb0f258ae78683 > 1000) {
    return;
  }

  self endon("snake_bite_about_to_hit");

  while(true) {
    head_pos = self gettagorigin("j_head");
    head_angles = self gettagangles("j_head");
    head_forward = anglesToForward(head_angles);
    head_up = anglestoup(head_angles);
    forward_amount = getdvarfloat(@ "hash_7174d8c71ecb56dc", 450);
    up_amount = getdvarfloat(@ "hash_d5be4cd033c8e19c", 150);
    var_da6f0c3db9954161 = create_playerclip_contents();
    trace = ray_trace(head_pos + head_forward * forward_amount * 0.5 + head_up * up_amount, head_pos + head_forward * forward_amount + head_up * up_amount, self, var_da6f0c3db9954161);
    trace2 = ray_trace(head_pos + head_forward * forward_amount * 0.5 - head_up * up_amount, head_pos + head_forward * forward_amount - head_up * up_amount, self, var_da6f0c3db9954161);
    trace3 = ray_trace(head_pos + head_forward * forward_amount * 0.5 - head_up * up_amount, head_pos + head_forward * forward_amount * 0.5 - head_up * up_amount * 2, self, var_da6f0c3db9954161);

    if(function_2113bc484dd870c2()) {
      draw_trace(trace, (1, 0, 0), 1);
      draw_trace(trace2, (1, 0, 0), 1);
      draw_trace(trace3, (1, 0, 0), 1);
    }

    if(isDefined(trace) && trace["hittype"] == "hittype_world" || isDefined(trace2) && trace2["hittype"] == "hittype_world" || isDefined(trace3) && trace3["hittype"] == "hittype_world") {
      self notify("snake_bite_hit");
      self asmfireevent(self.asmname, "end");
    }

    waitframe();
  }
}

function private function_a0d80c109b9ae1a4() {
  self endon("death");

  while(true) {
    self waittill("snake_bite_start");
    ent_flag_clear("has_snake_bite_hit");
    thread thread_on_notify("snake_bite_end", &function_2ec0b59b433b1f34, undefined, undefined, self);
    self.var_544ffa1d219d6810 = self.enemy;

    if(function_2113bc484dd870c2()) {
      if(isDefined(self.var_544ffa1d219d6810)) {
        line(self.origin, self.var_544ffa1d219d6810.origin, (1, 0, 0));
      }

      bite_print("<dev string:x92>");
    }

    thread function_ee486eaddde6fd68();
    thread function_eef6594341c62496();
  }
}

function private snake_bite_danger_zone() {
  self endon("snake_bite_hit");
  self endon("snake_bite_end");
  self endon("death");
  var_a3986c6c03221f24 = 200;
  self.danger_players = [];

  while(true) {
    if(isDefined(self.var_3f4dee1c560fc063)) {
      players = function_883458a342af3041(self.var_3f4dee1c560fc063, var_a3986c6c03221f24);

      if(function_2113bc484dd870c2()) {
        sphere(self.var_3f4dee1c560fc063, var_a3986c6c03221f24, (1, 1, 0));
        bite_print("<dev string:xa6>", self.var_3f4dee1c560fc063);
      }

      foreach(player in players) {
        if(!player ent_flag("in_snake_bite_danger_zone")) {
          player function_3677f2be30fdd581("deathwormVFX", "snake_bite_danger");
          thread function_cf9764313ad75400(player);
          player ent_flag_set("in_snake_bite_danger_zone");
        }
      }

      foreach(danger_player in self.danger_players) {
        if(!array_contains(players, danger_player)) {
          danger_player function_3677f2be30fdd581("deathwormVFX", "off");
          danger_player ent_flag_clear("in_snake_bite_danger_zone");
        }
      }

      self.danger_players = players;
    }

    waitframe();
  }
}

function private function_cf9764313ad75400(player) {
  self endon("death");
  waittill_any_3("death", "snake_bite_hit", "snake_bite_end");
  currentstate = player getscriptablepartstate("deathwormVFX", 1);

  if(isDefined(currentstate) && currentstate != "swallowed") {
    player function_3677f2be30fdd581("deathwormVFX", "off");
  }

  player ent_flag_clear("in_snake_bite_danger_zone");
}

function private function_2ec0b59b433b1f34() {
  ai::function_3e5ce428974325fb("snake_bite_cooldown", getdvarint(@ "hash_5b8c5fcfa978b47", 5000));
  ai::function_3e5ce428974325fb("snake_bite_close_cooldown", getdvarint(@ "hash_bf7cde3d3856076a", 2000));
}

function melee_impact(var_f238c840934e431e, damage_radius, max_damage) {
  if(!isDefined(damage_radius)) {
    damage_radius = 400;
  }

  if(!isDefined(max_damage)) {
    max_damage = 420;
  }

  head_pos = self gettagorigin("j_head");
  assert(isDefined(head_pos));
  var_b9f231daf3d07f7d = 60000;
  var_ac4af4d91d50f961 = 50000;
  targets = function_143526130b12b2b6(head_pos, damage_radius);

  foreach(target in targets) {
    var_fbe2fca375ce1bbb = max_damage;

    if(isPlayer(target)) {
      function_d26c4202b8c890da(target, head_pos);
    } else if(isai(target)) {
      var_fbe2fca375ce1bbb = 0;

      if(isDefined(target.aicategory) && !istrue(var_f238c840934e431e)) {
        if(target.aicategory == "normal") {
          var_fbe2fca375ce1bbb = target.health;
        } else if(target.aicategory == "special") {
          var_fbe2fca375ce1bbb = 100000;
        } else if(target.aicategory == "elite") {
          var_fbe2fca375ce1bbb = 50000;
        }
      }
    }

    var_d45caa2978502280 = distance2d(head_pos, target.origin);
    damage_percentage = max((damage_radius - var_d45caa2978502280) / damage_radius, 0);
    var_bb94b44258598dce = math::remap(damage_percentage, 0, 1, 10, var_fbe2fca375ce1bbb);

    if(isalive(target)) {
      if(istrue(var_f238c840934e431e)) {
        if(istrue(self.var_fa1a1806d30a40e1) && self.var_f8adf1aaec88d636 > 1 && target.armorhealth > 0) {
          target dodamage(var_bb94b44258598dce, head_pos, self, self, "MOD_MELEE");
        }

        swallowed = function_bea202648c100e56(target, head_pos, var_bb94b44258598dce);

        if(!swallowed) {
          target dodamage(var_bb94b44258598dce, head_pos, self, self, "MOD_MELEE");
        }
      } else if(isai(target)) {
        target knockdown_ai(head_pos);
        target dodamage(var_bb94b44258598dce, head_pos, self, self, "MOD_MELEE");
      } else if(isPlayer(target)) {
        target dodamage(var_bb94b44258598dce, head_pos, self, self, "MOD_MELEE");
      }
    }

    bite_print("<dev string:xb5>" + var_bb94b44258598dce, target.origin + (0, 0, 70));
  }

  self setscriptablepartstate("audio", "snake_bite_impact");
  earthquake(0.8, 0.4, head_pos, 1000);

  if(function_2113bc484dd870c2()) {
    iprintlnbold("<dev string:xc2>");
    bite_print("<dev string:xd2>" + targets.size + "<dev string:xda>", head_pos);
    sphere(head_pos, damage_radius, (1, 0, 0));
  }
}

function private function_eef6594341c62496() {
  self endon("death");
  self endon("snake_bite_start");
  self waittill("snake_bite_hit");
  ent_flag_set("has_snake_bite_hit");
  damage = 320;
  var_de7821bc51ab43a0 = [[self.var_8f1d8328f7a9091b]]();

  if(var_de7821bc51ab43a0 >= 13) {
    damage = 600;
  }

  melee_impact(1, undefined, damage);
}

function private function_d26c4202b8c890da(player, damage_point) {
  player knockback_flat(player.origin - damage_point, 1600);
  player playRumbleOnEntity("heavy_1s");
}

function function_c321972f4a10279a() {
  function_6e7290c8ee4f558b("<dev string:xe6>");
  function_a9a864379a098ad6("<dev string:x105>", "<dev string:x119>", &function_38699ca6e633d4e);
  function_a9a864379a098ad6("<dev string:x12d>", "<dev string:x141>", &function_790ff4ccb7f11b99);
  function_fe953f000498048f();
}

function private function_38699ca6e633d4e() {
  worm = function_6d1fbda4b8524ef2(level.players[0].origin, undefined, "<dev string:x155>");

  if(!isDefined(worm)) {
    return;
  }

  worm function_3e89eb3d8e3f1811("<dev string:x169>", 1);
}

function private function_2113bc484dd870c2() {
  return getdvarint(@ "hash_4c15f2ff8e7fd1bf", 0) > 0;
}

function private function_790ff4ccb7f11b99() {
  function_2fb888667001fc39("<dev string:x17a>", @ "hash_4c15f2ff8e7fd1bf");
}

function private bite_print(text, pos) {
  if(function_2113bc484dd870c2()) {
    pos = default_to(pos, self.origin + (0, 0, 70));
    print3d(pos, "<dev string:x198>" + text, (1, 0, 0));
  }
}

# /