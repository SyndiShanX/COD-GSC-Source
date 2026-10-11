/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_516de9f009ec5f26.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_40510196b9a59795;
#using script_5a4a5d9ba343ff8f;
#using script_686729055b66c6e4;
#using script_7edf952f8921aa6b;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;
#namespace namespace_88bb859063902058;

function function_dfad208433b79ddf() {
  if(!istrue(self.var_d8e84213ec8965fa)) {
    return;
  }

  level callback::add("on_mimic_player_grab_end", &function_b683140d304fc9b7);

  function_157d2e0cb4457c53();
}

function function_ea94f43e92438867() {
  self.var_d8e84213ec8965fa = self.zombieaisettings.var_e58a65b7a8f5973c.ismarauder;

  if(!istrue(self.var_d8e84213ec8965fa)) {
    return;
  }

  self.never_hide = 1;
  self.var_874b7b92577de3c7 = 0;
  self.var_f4eed917fd6bba9f = 0;
  self.var_4ad3e42cb03c819 = 0;
  self.var_f5d340f5be4dd4c1 = 0;
  self.var_e4976943db081dfe = 0;
  self.var_a0734722dbd53031 = 0;
  self.var_b7041a60af9367c1 = self.zombieaisettings.var_e58a65b7a8f5973c.var_23c4b2cbc1ada3a9;
  self.var_c56217d83f172c6f = self.zombieaisettings.var_e58a65b7a8f5973c.var_18173043f8f5acf7;
  assert(isDefined(self.var_c56217d83f172c6f), "<dev string:x1c>");
  callback::add("on_zombie_ai_killed", &function_cb83f981a61d07ab);
  callback::add("on_zombie_ai_damaged", &function_7f069f16ad59a75);
  thread function_e0f206e1fb21f1c7();
}

function function_b683140d304fc9b7(params) {
  mimic = params.attacker;

  if(!isalive(mimic) || !istrue(mimic.var_d8e84213ec8965fa)) {
    return;
  }

  n_points = function_fc2ee23e4402d457();

  if(n_points == 0) {
    return;
  }

  var_f95d1fce4a395991 = max(2000, n_points * 0.1);
  var_f95d1fce4a395991 = int(min(n_points, var_f95d1fce4a395991));
  function_88137cfcbacc59b2(var_f95d1fce4a395991);
  mimic.var_f4eed917fd6bba9f = var_f95d1fce4a395991;
  mimic.var_19392b26f34656d5 = self;
  mimic.var_3c14f359976ed2ab = int(var_f95d1fce4a395991 * 0.02) + 1;
  mimic.var_e4976943db081dfe = gettime() + 1000;
  mimic.var_f5d340f5be4dd4c1 = gettime() + 30000;
}

function function_e0f206e1fb21f1c7() {
  self endon("death");

  while(true) {
    wait 0.2;

    if(ent_flag("optical_camouflage")) {
      if(function_8ce7894f1a52fb77("burn") || is_stunned() || istrue(self getaiblackboarddynamic("in_grab_attack"))) {
        function_25bb1e6120021962(0);
        continue;
      }

      foreach(player in level.players) {
        if(isalive(player) && distancesquared(player.origin, self.origin) < 250000) {
          player thread function_9ccabafa45460ec5();
        }
      }

      continue;
    }

    if(istrue(self.var_f6c9f3a2e2f03d29)) {
      self.var_f6c9f3a2e2f03d29 = undefined;
      thread function_a9264d47d7eea82d();
      return;
    }

    if(self.var_f4eed917fd6bba9f == 0 && gettime() > self.var_4ad3e42cb03c819) {
      function_25bb1e6120021962(1);
      continue;
    }

    if(self.var_f4eed917fd6bba9f > 0) {
      n_cur_time = gettime();

      if(n_cur_time > self.var_f5d340f5be4dd4c1) {
        var_2356d8692d58de6f = 1;

        foreach(player in level.players) {
          if(isalive(player) && distancesquared(player.origin, self.origin) < 1000000) {
            var_2356d8692d58de6f = 0;
            break;
          }
        }

        if(var_2356d8692d58de6f) {
          thread function_a9264d47d7eea82d();
          return;
        }
      }

      if(n_cur_time > self.var_f5d340f5be4dd4c1 - 5000) {}

      if(n_cur_time >= self.var_e4976943db081dfe) {
        if(self.var_f4eed917fd6bba9f > self.var_3c14f359976ed2ab) {
          self.var_f4eed917fd6bba9f -= self.var_3c14f359976ed2ab;
        } else {
          self.var_f4eed917fd6bba9f = 0;
        }

        self.var_e4976943db081dfe = n_cur_time + 1000;
      }
    }

    if(!isDefined(self.var_9523239a14665910) || distancesquared(self.origin, self.var_9523239a14665910) < 10000) {
      self.var_9523239a14665910 = function_ca41c464e28c0f2b();
      self setbtgoalpos(4, self.var_9523239a14665910);
    }
  }
}

function function_25bb1e6120021962(state) {
  if(self.var_874b7b92577de3c7 == state) {
    return;
  }

  self.var_874b7b92577de3c7 = state;

  if(state) {
    ent_flag_set("optical_camouflage");
    self clearbtgoal(4);
    self.var_9523239a14665910 = undefined;
    utility::function_3677f2be30fdd581("optical_camouflage", "on");
    val::set("optical_camouflage", "show_healthbar", 0);
    return;
  }

  ent_flag_clear("optical_camouflage");
  self.var_4ad3e42cb03c819 = gettime() + 30000;
  utility::function_3677f2be30fdd581("optical_camouflage", "off");
  val::reset("optical_camouflage", "show_healthbar");
}

function private function_cb83f981a61d07ab(params) {
  if(isPlayer(self.var_19392b26f34656d5) && self.var_f4eed917fd6bba9f > 0) {
    self.var_19392b26f34656d5 function_36a28b99ec0f7fd8(self.var_f4eed917fd6bba9f);
  }
}

function private function_7f069f16ad59a75(params) {
  if(self.var_f4eed917fd6bba9f >= self.var_b7041a60af9367c1) {
    self.var_a0734722dbd53031 += params.idamage;

    if(self.var_a0734722dbd53031 < 0.05 * self.maxhealth) {
      return;
    }

    self.var_a0734722dbd53031 = 0;
    self.var_f4eed917fd6bba9f -= self.var_b7041a60af9367c1;
    spawnnewitemfromscriptablesharedfunc(self.var_c56217d83f172c6f, self.origin);
  }
}

function private function_9ccabafa45460ec5() {
  self notify("get_mimic_maraud_radar_jamming_singleton");
  self endon("get_mimic_maraud_radar_jamming_singleton");
  self endon("disconnect");

  if(!istrue(self.var_2a0ee7f6545aacea)) {
    function_345d613203ca10d8(5);
    self.var_2a0ee7f6545aacea = 1;
  }

  wait 1;
  function_ea96a5c13167a126(5);
  self.var_2a0ee7f6545aacea = undefined;
}

function private function_ca41c464e28c0f2b() {
  if(isDefined(level.var_76f9d35386d7f2dd)) {
    farthest_pos = self[[level.var_76f9d35386d7f2dd]]();
    return default_to(farthest_pos, self.origin);
  }

  closet_player = getclosest(self.origin, level.players);
  a_positions = getrandomnavpoints(self.origin, 1600, 5);
  farthest_pos = undefined;
  to_player = vectorNormalize(closet_player.origin - self.origin);

  if(isDefined(a_positions)) {
    max_dist_sq = 0;

    foreach(pos in a_positions) {
      to_target = vectorNormalize(pos - self.origin);

      if(vectordot(to_target, to_player) > 0.5) {
        continue;
      }

      dist_sq = distancesquared(pos, self.origin);

      if(dist_sq > max_dist_sq) {
        max_dist_sq = dist_sq;
        farthest_pos = pos;
      }
    }
  }

  return default_to(farthest_pos, self.origin);
}

function private function_a9264d47d7eea82d() {
  self endon("death");
  function_7ada97e01329f789();
  wait 0.7;
  self hide();
  self setsolid(0);
  params = spawnStruct();
  callback::callback("on_entity_hidden_in_prop", params);
  self.trap_prop = params;
  waittill_any_timeout_1(randomintrange(60, 120), "force_respawn");
  params.activators = [];
  callback::callback("on_entity_revealed", params);
  self.var_f4eed917fd6bba9f = 0;
  self.health = int(min(self.maxhealth, self.health + self.maxhealth * 0.5));
  thread function_e0f206e1fb21f1c7();
}

function function_157d2e0cb4457c53() {
  function_6e7290c8ee4f558b("<dev string:x4d>");
  function_a9a864379a098ad6("<dev string:x70>", "<dev string:x8c>", &function_d5a60ed3fa596347);
  function_a9a864379a098ad6("<dev string:xa8>", "<dev string:xc7>", &function_dc415bc56699ba00);
  function_a9a864379a098ad6("<dev string:xe6>", "<dev string:x104>", &function_2b6ac9200eee0f85);
  function_fe953f000498048f();
}

function function_d5a60ed3fa596347() {
  mimic = function_6d1fbda4b8524ef2(level.players[0].origin, undefined, "<dev string:x122>");

  if(isDefined(mimic)) {
    mimic notify("<dev string:x139>");
  }
}

function function_dc415bc56699ba00() {
  mimic = function_6d1fbda4b8524ef2(level.players[0].origin, undefined, "<dev string:x122>");

  if(isDefined(mimic)) {
    mimic function_25bb1e6120021962(1);
  }
}

function function_2b6ac9200eee0f85() {
  mimic = function_6d1fbda4b8524ef2(level.players[0].origin, undefined, "<dev string:x122>");

  if(isDefined(mimic)) {
    mimic.var_f6c9f3a2e2f03d29 = 1;
  }
}

# /