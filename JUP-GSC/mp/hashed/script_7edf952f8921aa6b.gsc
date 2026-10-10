/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7edf952f8921aa6b.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_4a8c20678bd6a83e;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\engine\utility;
#namespace zombie_utils;

function autoexec init() {
  utility::registersharedfunc("zombie_utils", "setMoveSpeed", &function_f1e5805da192a1ef);
  utility::registersharedfunc("zombie_utils", "setTarget", &function_a047f71d0256058b);
  utility::registersharedfunc("zombie_utils", "registerDamageCallback", &function_b5e57408c7878df7);
}

function function_f1e5805da192a1ef(var_21a40aa35e41881a, id, priority) {
  assertex(ent_flag("<dev string:x1c>"), "<dev string:x30>");
  id = isDefined(id) ? id : "default";
  priority = isDefined(priority) ? priority : 0;
  self.var_caeb5ca53668812c = isDefined(self.var_caeb5ca53668812c) ? self.var_caeb5ca53668812c : [];

  if(isDefined(var_21a40aa35e41881a)) {
    archetype = self.animsetname;
    target_speed = getanimspeedthreshold(archetype, var_21a40aa35e41881a);

    if(!isDefined(target_speed)) {
      return;
    }
  }

  var_2d685d04940730d0 = spawnStruct();
  var_2d685d04940730d0.id = id;
  var_2d685d04940730d0.var_21a40aa35e41881a = var_21a40aa35e41881a;
  var_2d685d04940730d0.priority = priority;

  for(i = 0; i < self.var_caeb5ca53668812c.size; i++) {
    current = self.var_caeb5ca53668812c[i];

    if(isDefined(current) && current.id == id) {
      self.var_caeb5ca53668812c = array_remove_index(self.var_caeb5ca53668812c, i);
      break;
    }
  }

  b_added = 0;

  if(isDefined(var_21a40aa35e41881a)) {
    for(i = 0; i < self.var_caeb5ca53668812c.size; i++) {
      current = self.var_caeb5ca53668812c[i];

      if(!isDefined(current) || current.priority < priority) {
        continue;
      }

      if(current.priority == priority) {
        assertmsg("<dev string:x78>" + current.id + "<dev string:xb1>" + id + "<dev string:xc3>");
        self.var_caeb5ca53668812c = array_insert(self.var_caeb5ca53668812c, var_2d685d04940730d0, i + 1);
        b_added = 1;
      } else if(current.priority > priority) {
        self.var_caeb5ca53668812c = array_insert(self.var_caeb5ca53668812c, var_2d685d04940730d0, i);
        b_added = 1;
      }

      break;
    }

    if(!b_added) {
      b_added = 1;
      self.var_caeb5ca53668812c = array_add(self.var_caeb5ca53668812c, var_2d685d04940730d0);
    }
  }

  if(isarray(self.var_caeb5ca53668812c) && isstruct(self.var_caeb5ca53668812c[self.var_caeb5ca53668812c.size - 1])) {
    new_move_speed = self.var_caeb5ca53668812c[self.var_caeb5ca53668812c.size - 1].var_21a40aa35e41881a;

    if(!bb_movetyperequested(new_move_speed)) {
      bb_requestmovetype(new_move_speed);
      archetype = self.animsetname;
      target_speed = getanimspeedthreshold(archetype, new_move_speed);

      if(isDefined(target_speed)) {
        self aisetdesiredspeed(target_speed);
        self aisettargetspeed(target_speed);
        callback::callback("on_move_speed_changed");
      }
    }
  }
}

function function_a047f71d0256058b(target_ent, id, priority) {
  id = isDefined(id) ? id : "default";
  priority = isDefined(priority) ? priority : 0;
  self.var_a2f8ae60cc4dab38 = isDefined(self.var_a2f8ae60cc4dab38) ? self.var_a2f8ae60cc4dab38 : [];
  target_struct = spawnStruct();
  target_struct.id = id;
  target_struct.target_ent = target_ent;
  target_struct.priority = priority;

  for(i = 0; i < self.var_a2f8ae60cc4dab38.size; i++) {
    current = self.var_a2f8ae60cc4dab38[i];

    if(!isDefined(current.target_ent) || !isalive(current.target_ent) || isDefined(current) && current.id == id) {
      self.var_a2f8ae60cc4dab38 = array_remove_index(self.var_a2f8ae60cc4dab38, i);
      break;
    }
  }

  b_added = 0;

  if(isDefined(target_ent)) {
    for(i = 0; i < self.var_a2f8ae60cc4dab38.size; i++) {
      current = self.var_a2f8ae60cc4dab38[i];

      if(!isDefined(current) || current.priority < priority) {
        continue;
      }

      if(current.priority == priority) {
        assertmsg("<dev string:xf9>" + current.id + "<dev string:xb1>" + id + "<dev string:xc3>");
        self.var_a2f8ae60cc4dab38 = array_insert(self.var_a2f8ae60cc4dab38, target_struct, i + 1);
        b_added = 1;
      } else if(current.priority > priority) {
        self.var_a2f8ae60cc4dab38 = array_insert(self.var_a2f8ae60cc4dab38, target_struct, i);
        b_added = 1;
      }

      break;
    }

    if(!b_added) {
      b_added = 1;
      self.var_a2f8ae60cc4dab38 = array_add(self.var_a2f8ae60cc4dab38, target_struct);
    }
  }

  if(self.var_a2f8ae60cc4dab38.size > 0 && isstruct(self.var_a2f8ae60cc4dab38[self.var_a2f8ae60cc4dab38.size - 1])) {
    new_target = self.var_a2f8ae60cc4dab38[self.var_a2f8ae60cc4dab38.size - 1].target_ent;

    if(!isDefined(self.favoriteenemy) && isDefined(new_target) || isDefined(self.favoriteenemy) && !isDefined(new_target) || self.favoriteenemy != new_target) {
      self.favoriteenemy = new_target;
    }
  }
}

function function_b5e57408c7878df7(func) {
  if(!isDefined(self.var_36cfc021447f6d92)) {
    self.var_36cfc021447f6d92 = [];
  }

  self.var_36cfc021447f6d92 = array_add(self.var_36cfc021447f6d92, func);
}

function function_fabb6087888f45c8(func) {
  if(!isarray(self.var_36cfc021447f6d92)) {
    return;
  }

  self.var_36cfc021447f6d92 = array_remove(self.var_36cfc021447f6d92, func);
}

function function_68ab6089a2897e86(weapon_name, func) {
  if(!isDefined(self.var_ccb94c2ea5886365)) {
    self.var_ccb94c2ea5886365 = [];
  }

  self.var_ccb94c2ea5886365[weapon_name] = func;
}

function function_4a7028dbd330a123(weapon_name) {
  if(!isarray(self.var_ccb94c2ea5886365)) {
    return;
  }

  self.var_ccb94c2ea5886365 = array_remove_key(self.var_ccb94c2ea5886365, weapon_name);
}

function function_2201d3f3d7ab07a7() {
  assert(isDefined(self.difficulty_round));
  return self.difficulty_round;
}

function function_6dc6c46856cb890(ent) {
  assert(isDefined(ent));
  self.var_8841e18d41e1ecb = default_to(self.var_8841e18d41e1ecb, []);
  var_ff81381f2596d7da = !isDefined(self.var_8841e18d41e1ecb[ent getentitynumber()]);
  var_3aa2cc768cd55c4b = !var_ff81381f2596d7da && self.var_8841e18d41e1ecb[ent getentitynumber()].time != gettime();

  if(var_ff81381f2596d7da || var_3aa2cc768cd55c4b) {
    reachable_info = spawnStruct();
    reachable_info.time = gettime();
    reachable_info.origin = self getclosestreachablepointonnavmesh(ent.origin, 0);
    self.var_8841e18d41e1ecb[ent getentitynumber()] = reachable_info;
  }

  var_c43c46ac461773dc = self.var_8841e18d41e1ecb[ent getentitynumber()].origin;
  return var_c43c46ac461773dc;
}

function function_a55b3d6929d24cf7(pos, priority) {
  assert(isDefined(pos));
  priority = default_to(priority, 0);

  if(isDefined(level.var_196dea71269368b1) && isDefined(level.var_a3db96fad0d53230)) {
    zone_cost = [[level.var_a3db96fad0d53230]](self.origin, pos);
    path = undefined;

    if(isDefined(zone_cost) && zone_cost > 2) {
      path = [[level.var_196dea71269368b1]](self.origin, pos);
    }

    if(isarray(path) && path.size > 2) {
      self.var_a7caf2881d0c1fee = "<dev string:x12a>";

      self setbtgoalpos(priority, path[1].origin);
      return;
    }
  }

  self.var_a7caf2881d0c1fee = "<dev string:x137>";

  self setbtgoalpos(priority, pos);
}

function function_2576f3b996c15ad(id, value) {
  self.bt_params = default_to(self.bt_params, []);
  self.bt_params[id] = value;
}

function function_b559c67c7f8f6459(id) {
  assert(isDefined(self.bt_params) && isDefined(self.bt_params[id]));
  return self.bt_params[id];
}

function function_ca27630def7b7aad(attacker) {
  if(ent_flag("turned")) {
    return;
  }

  ent_flag_set("turned");
  params = spawnStruct();
  params.attacker = attacker;
  callback::callback("on_turned", params);
  self.health = self.maxhealth;
  self.allowpain = 0;

  if(isDefined(attacker) && isDefined(attacker.team)) {
    self.team = attacker.team;
  }

  self clearpath();
}

function function_6d1fbda4b8524ef2(origin, team, var_8559bf711f66a349) {
  zombie_team = team;

  if(!isDefined(zombie_team)) {
    zombie_team = "all";
  }

  all_zombies = getaispeciesarray(zombie_team, "zombie");
  var_dc6aeaa01d771f22 = [];

  if(isDefined(var_8559bf711f66a349)) {
    foreach(ai in all_zombies) {
      if(ai.subclass != var_8559bf711f66a349) {
        continue;
      }

      var_dc6aeaa01d771f22 = array_add(var_dc6aeaa01d771f22, ai);
    }
  } else {
    var_dc6aeaa01d771f22 = all_zombies;
  }

  return get_array_of_closest(origin, var_dc6aeaa01d771f22)[0];
}

function function_cb7771bf461049eb(var_642af5f587dd2300) {
  assert(isDefined(var_642af5f587dd2300));
  zombieaisettingsbundle = getscriptbundle("zombieaisettings:" + var_642af5f587dd2300.zombieaisetting);

  if(isDefined(zombieaisettingsbundle.var_fef5d84db3c8e7f7)) {
    var_e58a65b7a8f5973c = getscriptbundle(zombieaisettingsbundle.var_fef5d84db3c8e7f7);
    return var_e58a65b7a8f5973c;
  }

  return undefined;
}

function function_d8853db47f5b98e4(params) {
  if(isDefined(params.body)) {
    return params.body;
  }

  if(isDefined(params.bodyentnum)) {
    body = getentbynum(params.bodyentnum);

    if(isactorcorpse(body) && body.classname == params.origclassname) {
      return body;
    }
  }
}

function function_6226a01fb62f39fd(player, var_3aa66d1cfed21aca, var_ecf8d79fb68e4fb, var_9f4347003cf3a72a, var_f7c06d80611e778e, var_f55638498fcbc37c, isdog) {
  level endon("game_ended");
  self endon("death");

  if(!isPlayer(player)) {
    return false;
  }

  if(istrue(player.var_68b9486f4adbcb62)) {
    return false;
  }

  self clearbtgoal(2);
  self.var_f79f774d8b98ab5 = self._blackboard.movetype;
  function_f1e5805da192a1ef("run", "turned", 25);
  safeorigin = function_3d10829b418c916a(player, var_f7c06d80611e778e);

  if(isDefined(safeorigin)) {
    function_a55b3d6929d24cf7(safeorigin, 2);
    var_95b51daa0fb10c76 = player.origin;
    reached_goal = 0;
    waitframe();

    while(true) {
      if(istrue(player.var_68b9486f4adbcb62)) {
        function_e3952036dafb66ee();
        return false;
      }

      if(!isDefined(self)) {
        return false;
      }

      if(isDefined(self.enemy) && distancesquared(self.origin, player.origin) <= squared(700)) {
        function_e3952036dafb66ee();
        return false;
      }

      if(!isalive(player) || istrue(player.inlaststand)) {
        function_e3952036dafb66ee();
        return false;
      }

      if(!isDefined(self.goalpos) || self function_1fde453596ea559c() > 2000) {
        function_e3952036dafb66ee();
        return false;
      }

      if(istrue(var_f55638498fcbc37c) && isDefined(self.enemy)) {
        function_e3952036dafb66ee();
        return false;
      }

      if(!is_traversing() && isDefined(self.goalpos) && distancesquared(self.goalpos, safeorigin) > 1024) {
        function_a55b3d6929d24cf7(safeorigin, 2);
        waitframe();
        continue;
      }

      if(distancesquared(player.origin, var_95b51daa0fb10c76) > var_3aa66d1cfed21aca && distancesquared(player.origin, self.origin) < var_ecf8d79fb68e4fb) {
        safeorigin = function_3d10829b418c916a(player, var_f7c06d80611e778e);
        var_95b51daa0fb10c76 = player.origin;

        if(isDefined(safeorigin)) {
          function_a55b3d6929d24cf7(safeorigin, 2);
          waitframe();
          continue;
        }
      } else if(distancesquared(player.origin, self.origin) >= var_ecf8d79fb68e4fb && self.teleportcooldown >= var_9f4347003cf3a72a) {
        function_69e98977aca657e7(self.var_66c1831357048c02.origin, isdog);
        function_e3952036dafb66ee();
        break;
      }

      if(distance2dsquared(self.goalpos, self.origin) < 2500) {
        reached_goal = 1;
      }

      if(reached_goal && !is_traversing()) {
        function_e3952036dafb66ee();
        break;
      }

      waitframe();
    }
  }

  self notify("ob_pet_player_reached");
  return true;
}

function function_3d10829b418c916a(player, var_116c339edecfbe08) {
  forward = self.origin - player.origin;
  forward = vectorNormalize(forward);
  targetorigin = player.origin + (forward[0], forward[1], 0) * var_116c339edecfbe08;
  safeorigin = self getclosestreachablepointonnavmesh(targetorigin);
  safeorigin = getgroundposition(safeorigin, 15);

  level thread scripts\cp_mp\utility\debug_utility::drawsphere(safeorigin, 15, 3, (1, 0, 1));

  return safeorigin;
}

function function_e3952036dafb66ee() {
  self clearbtgoal(2);
}

function function_69e98977aca657e7(point, isdog) {
  level endon("game_ended");
  self endon("death");
  safeorigin = getclosestpointonnavmesh(point, self);

  if(isDefined(safeorigin)) {
    if(distancesquared(safeorigin, point) > 1000000) {
      wait 2;
      return;
    }

    if(istrue(isdog)) {
      playsoundatpos(self.origin + (0, 0, 50), "evt_ai_hellhound_friendly_teleport_out");
    }

    tag_origin = spawn_tag_origin(self.origin);
    self linkTo(tag_origin);
    tag_origin.origin = safeorigin + (0, 0, -15000);
    wait 0.5;
    thread animscripted_sharedfunc("spawn", "spawn_end", safeorigin, self.angles, "spawn_animating");
    tag_origin.origin = safeorigin;
    tag_origin delete();

    if(!istrue(isdog)) {
      playsoundatpos(safeorigin + (0, 0, 50), "evt_ai_aether_disciple_spawn_teleport");
    }

    wait 1.5;

    if(istrue(isdog)) {
      playsoundatpos(safeorigin + (0, 0, 50), "evt_ai_hellhound_friendly_teleport_in");
    }

    self notify("pet_teleported");
    self.teleportcooldown = 0;
    thread function_9f4347003cf3a72a();
    self notify("ob_pet_player_reached");
  }
}

function private function_9f4347003cf3a72a() {
  level endon("game_ended");
  self endon("death");
  self endon("pet_teleported");

  while(true) {
    self.teleportcooldown++;
    wait 1;
  }
}

function function_3c10d5b169a1bb6f(params) {
  new_damage = params.idamage;
  var_eff1dd1bc375195c = 0;

  if(istrue(self.pet) && isDefined(params.einflictor) && isDefined(params.einflictor.subclass)) {
    switch (params.einflictor.subclass) {
      case #"hash_91cd18ea8bf6d95":
        new_damage = params.idamage / 6;
        break;
      case #"hash_3794ac3fadfffd9c":
      case #"hash_5a24fffee0d81302":
      case #"hash_e907579ab7e94379":
      case #"hash_ef4c998bcc00f823":
        new_damage = params.idamage / 11.6;
        break;
      case #"hash_3c0ffb3dab1a9835":
      case #"hash_806a6487959205af":
      case #"hash_b32707f6c3892f15":
      case #"hash_c9beeb2ff7f370db":
        new_damage = params.idamage / 17.2;
        break;
      case #"hash_1380581f5144c465":
      case #"hash_93b4f38d9787d026":
      case #"hash_99a38be9e88b5244":
      case #"hash_b668d02ebeae46bb":
      case #"hash_f297af39454fdc7b":
        if(isDefined(params.einflictor.difficulty)) {
          if(params.einflictor.difficulty == "difficulty_hard") {
            new_damage = params.idamage / getdvarint(@ "hash_13b73e8b91b19d8a", 9);
            break;
          } else if(params.einflictor.difficulty == "difficulty_darkaether") {
            new_damage = params.idamage / getdvarint(@ "hash_d84f83094aedff87", 10);
            break;
          }
        }

        new_damage = params.idamage / getdvarint(@ "hash_5c7e34e0a997c120", 8);
        break;
      case #"hash_c1b612499d7bd4a":
      case #"hash_9bc2060c1da7a187":
        if(isDefined(params.einflictor.difficulty)) {
          if(params.einflictor.difficulty == "difficulty_normal") {
            new_damage = params.idamage / getdvarint(@ "hash_f3fd9b1304bf2c5", 47);
            break;
          } else if(params.einflictor.difficulty == "difficulty_hard") {
            new_damage = params.idamage / getdvarint(@ "hash_dab7d369b926b997", 75);
            break;
          } else if(params.einflictor.difficulty == "difficulty_darkaether") {
            new_damage = params.idamage / getdvarint(@ "hash_ead43a07340270a8", 225);
            break;
          }
        }

        new_damage = params.idamage / getdvarint(@ "hash_1ce5d1a5816cd7cd", 4);
        break;
      case #"hash_3e4a9c816939eeef":
        if(params.einflictor.difficulty == "difficulty_normal") {
          new_damage = params.idamage / getdvarint(@ "hash_e994276c20c268f2", 9.5);
          break;
        } else if(params.einflictor.difficulty == "difficulty_hard") {
          new_damage = params.idamage / getdvarint(@ "hash_4900f5db37e2f49c", 25);
          break;
        } else if(params.einflictor.difficulty == "difficulty_darkaether") {
          new_damage = params.idamage / getdvarint(@ "hash_6ce4da83c050527f", 75);
          break;
        }

        new_damage = params.idamage;
        break;
      case #"hash_60cbd0daf82a39c9":
        if(params.einflictor.difficulty == "difficulty_hard") {
          new_damage = params.idamage * getdvarint(@ "hash_ff78cd83ac74baf6", 1.75);
          break;
        } else if(params.einflictor.difficulty == "difficulty_darkaether") {
          new_damage = params.idamage * getdvarint(@ "hash_c66f3edc8af303d9", 1.8);
          break;
        }

        new_damage = params.idamage / getdvarint(@ "hash_8143d9c771cb175e", 1.5);
        break;
      case #"hash_c1fa8721b046b258":
        if(params.einflictor.difficulty == "difficulty_hard") {
          new_damage = params.idamage * getdvarint(@ "hash_a0b3efb4514864af", 2);
          break;
        } else if(params.einflictor.difficulty == "difficulty_darkaether") {
          new_damage = params.idamage * getdvarint(@ "hash_81f2d653216bc8d0", 2);
          break;
        }
      case #"hash_2ae98751cea446c1":
        if(new_damage > 7500) {
          new_damage = 7500;
          var_eff1dd1bc375195c = 1;
          break;
        }

        break;
    }
  }

  if(isDefined(params.einflictor) && isDefined(params.einflictor.difficulty)) {
    if(params.einflictor.difficulty == "difficulty_hard") {
      switch (self.difficulty) {
        case #"hash_7bb2cd766703d463":
          new_damage = min(new_damage, getdvarint(@ "hash_26daf3192bc85578", 125));
          break;
        case #"hash_af83e47edfa8900a":
          new_damage = min(new_damage, getdvarint(@ "hash_26daf6192bc85c11", 200));
          break;
        case #"hash_5343b465e56ec9a4":
          new_damage = min(new_damage, getdvarint(@ "hash_26daf5192bc859de", 275));
          break;
        case #"hash_651f76c0ad6741ec":
          new_damage = min(new_damage, getdvarint(@ "hash_26daf5192bc859de", 375));
          break;
      }
    } else if(params.einflictor.difficulty == "difficulty_darkaether") {
      switch (self.difficulty) {
        case #"hash_5343b465e56ec9a4":
          new_damage = min(new_damage, getdvarint(@ "hash_b64601929d5c8272", 250));
          break;
        case #"hash_651f76c0ad6741ec":
          new_damage = min(new_damage, getdvarint(@ "hash_b645fc929d5c7773", 300));
          break;
        default:
          break;
      }

      if(!istrue(var_eff1dd1bc375195c)) {
        if(new_damage > getdvarint(@ "hash_2628480127867b19", 2500)) {
          new_damage = getdvarint(@ "hash_2628480127867b19", 2500);
        }
      }
    }
  }

  return int(new_damage);
}

function function_5b71b171ed50f326() {
  self endon("death");

  if(isPlayer(self.var_66c1831357048c02)) {
    self.var_66c1831357048c02 waittill("death_or_disconnect");
    self kill();
  }
}

function function_e8f6a314663565f(var_a1581cb0bffd878f) {
  level endon("game_ended");
  self endon("death");
  player = self.var_66c1831357048c02;
  player endon("death_or_disconnect");
  self function_65cdab0fc78aba8f(player.origin, 700);
  var_e82887f4e9e2c5ec = undefined;

  while(true) {
    if(!isDefined(var_e82887f4e9e2c5ec)) {
      var_e82887f4e9e2c5ec = player.origin;
    } else if(distancesquared(var_e82887f4e9e2c5ec, player.origin) >= var_a1581cb0bffd878f) {
      self function_65cdab0fc78aba8f(player.origin, 700);
      var_e82887f4e9e2c5ec = player.origin;
    }

    wait 1;
  }
}