/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_16b1b77a76492c6a.gsc
***********************************************/

#using script_19367cd29a4485db;
#using script_27347f09888ad15;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace namespace_2c949ef8;

function init() {
  level thread main();
}

function main() {
  init_devgui();
}

function function_5e62ed5c() {
  level endon(#"game_ended", #"disable_ambush");

  while(true) {
    if(!isDefined(level.var_cf15d540)) {
      level.var_cf15d540 = 300;
    }

    if(!isDefined(level.var_f535b5f0)) {
      level.var_f535b5f0 = 480;
    }

    level.var_49f4fe8e = undefined;
    wait_result = level waittilltimeout(randomfloatrange(level.var_cf15d540, level.var_f535b5f0), #"start_ambush", #"objective_locked");

    if(level flag::get("objective_locked")) {
      level flag::wait_till_clear("objective_locked");
      continue;
    }

    a_players = namespace_85745671::function_347f7d34();
    a_ai_zombies = getaiarray();
    var_571f5454 = undefined;
    e_target = undefined;

    if(wait_result._notify === "start_ambush") {
      if(!isDefined(level.var_49f4fe8e)) {
        level.var_49f4fe8e = 1;
      }

      if(isDefined(wait_result.player)) {
        e_target = wait_result.player;
        var_571f5454 = e_target.origin;
      } else if(isDefined(wait_result.location)) {
        var_571f5454 = wait_result.location;

        if(a_players.size > 0) {
          e_target = arraygetclosest(var_571f5454, a_players);
        }
      }

      var_30ff34e3 = wait_result.var_30ff34e3;
    } else if(getdvarint(#"hash_21e1866f0c677ab8", 1)) {
      return;
    }

    if(isDefined(e_target)) {
      var_120d0570 = array::get_all_closest(e_target.origin, a_ai_zombies, undefined, undefined, 1200);
    } else if(a_players.size > 0) {
      var_5502295b = function_8af8f660();
      var_df053feb = array::get_all_farthest(var_5502295b, a_players);

      foreach(player in var_df053feb) {
        var_120d0570 = array::get_all_closest(player.origin, a_ai_zombies, undefined, undefined, 1200);

        if(var_120d0570.size <= 10) {
          var_571f5454 = player.origin;
          break;
        }
      }
    }

    if(isDefined(var_571f5454)) {
      foreach(safehouse in struct::get_array("safehouse", "content_script_name")) {
        if(isDefined(safehouse.origin) && distance2dsquared(var_571f5454, safehouse.origin) <= sqr(2000)) {
          var_571f5454 = undefined;
          break;
        }
      }
    }

    if(isDefined(var_571f5454)) {
      function_8b6ae460(var_571f5454, undefined, undefined, undefined, level.var_49f4fe8e);
      level thread function_39925c0d();
    }
  }
}

function function_39925c0d() {
  level endon(#"game_ended", #"ambush_over", #"disable_ambush");
  wait 240;
  level notify(#"ambush_over");
}

function function_f4413120() {
  if(isalive(self)) {
    self playsoundtoplayer(#"hash_177c25d969608d58", self);
  }
}

function function_be6ec6c(var_2b43a4c4, var_30ff34e3 = 1) {
  if(!isDefined(var_2b43a4c4)) {
    level notify(#"start_ambush", {
      #var_30ff34e3: var_30ff34e3
    });
    return;
  }

  if(isPlayer(var_2b43a4c4)) {
    level notify(#"start_ambush", {
      #player: var_2b43a4c4, #var_30ff34e3: var_30ff34e3
    });
    return;
  }

  if(isvec(var_2b43a4c4)) {
    level notify(#"start_ambush", {
      #location: var_2b43a4c4, #var_30ff34e3: var_30ff34e3
    });
  }
}

function function_47838885(var_120d0570) {
  if(isarray(var_120d0570)) {
    foreach(ai_zombie in var_120d0570) {
      if(ai_zombie.team === # "axis") {
        ai_zombie thread namespace_85745671::function_9456addc(120);
      }
    }
  }
}

function private function_8d3a76bb(var_cf21a49f) {
  switch (getplayers("allies", var_cf21a49f, 4096).size) {
    case 1:
      return 5;
    case 2:
      return 7;
    case 3:
      return 10;
    default:
      return 12;
  }
}

function function_8b6ae460(v_loc, var_aa19ae, var_437c9d8d, var_f24d0052, var_6a7b6ec4, var_6cd49f50, var_c8c520ef = 1, str_targetname, n_height, var_dc0c4612 = 0) {
  var_120d0570 = array::get_all_closest(v_loc, getaiarray(), undefined, undefined, var_f24d0052);
  function_47838885(var_120d0570);
  var_76913854 = getplayers("allies", v_loc, 4096);

  if(is_true(var_c8c520ef)) {
    array::thread_all(var_76913854, &function_f4413120);
  }

  function_156560eb(v_loc, var_aa19ae, var_437c9d8d, var_f24d0052, var_6a7b6ec4, var_6cd49f50, str_targetname, n_height, var_dc0c4612);
}

function function_156560eb(var_cf21a49f, var_aa19ae, var_437c9d8d = 1500, var_f24d0052 = 3000, var_6a7b6ec4 = 1, var_6cd49f50, str_targetname = "ambush_zombie", n_height, var_dc0c4612 = 0) {
  level endon(#"game_ended", #"ambush_over", #"disable_ambush");
  var_5b660261 = undefined;
  var_42c6e7d2 = [];

  if(!isDefined(var_aa19ae)) {
    var_aa19ae = "default_ambush_list_realm_" + level.realm;
  }

  var_6443acc = namespace_679a22ba::function_77be8a83(var_aa19ae);
  var_11a3ade0 = var_cf21a49f;

  while(isDefined(var_cf21a49f)) {
    var_663d8b4e = function_8d3a76bb(var_cf21a49f);
    var_bb956a6c = function_48defc2d(var_cf21a49f, var_663d8b4e, var_437c9d8d, var_f24d0052, var_6a7b6ec4, n_height);

    for(i = 0; i < var_bb956a6c.size; i++) {
      a_players = namespace_85745671::function_347f7d34(var_dc0c4612);

      if(!a_players.size) {
        wait 1;
        continue;
      }

      v_spawn = var_bb956a6c[i].origin;
      v_target = arraygetclosest(v_spawn, a_players).origin;

      if(!(isDefined(v_target) && isDefined(v_spawn))) {
        wait 1;
        continue;
      }

      v_angles = vectortoangles(v_target - v_spawn);
      v_angles = (0, v_angles[1], 0);
      var_4bf95f4c = namespace_679a22ba::function_ca209564(var_aa19ae, var_6443acc);

      if(!isDefined(var_4bf95f4c)) {
        function_1eaaceab(var_42c6e7d2);
        var_61262c99 = arraycopy(var_42c6e7d2);

        foreach(ai in var_61262c99) {
          if(ai.current_state.name === # "wander" && isDefined(ai.birthtime) && gettime() - ai.birthtime > int(5 * 1000) && !isDefined(ai.favoriteenemy)) {
            arrayremovevalue(var_61262c99, ai);
          }
        }

        if(!var_61262c99.size) {
          return;
        } else {
          wait 0.5;
          continue;
        }
      }

      ai_spawned = namespace_85745671::function_9d3ad056(var_4bf95f4c.aitype_name, v_spawn, v_angles, str_targetname);

      if(isDefined(ai_spawned)) {
        if(!isDefined(var_42c6e7d2)) {
          var_42c6e7d2 = [];
        } else if(!isarray(var_42c6e7d2)) {
          var_42c6e7d2 = array(var_42c6e7d2);
        }

        var_42c6e7d2[var_42c6e7d2.size] = ai_spawned;
        ai_spawned.var_42c6e7d2 = var_42c6e7d2;
        ai_spawned.var_9602c8b2 = &function_12db74f8;
        ai_spawned thread function_1c491c2b(var_6cd49f50, var_4bf95f4c.list_name, var_6443acc);
        namespace_679a22ba::function_266ee075(var_4bf95f4c.list_name, var_6443acc);

        if(str_targetname === "demented_echo_zombie") {
          playFXOnTag(#"hash_7f6d176eb7cc63dc", ai_spawned, "tag_origin");
        } else if(str_targetname === "black_chest_zombie") {
          playFX(#"hash_7eba9aeb0c1d0afe", ai_spawned.origin, anglesToForward(ai_spawned.angles), anglestoup(ai_spawned.angles));
        }

        waitframe(randomintrangeinclusive(1, 3));
        continue;
      }

      wait 0.25;
    }

    wait randomfloatrange(4, 5);
    a_players = namespace_85745671::function_347f7d34(var_dc0c4612);

    if(a_players.size) {
      var_cf21a49f = arraygetclosest(var_11a3ade0, a_players).origin;
    }
  }
}

function private function_48defc2d(var_cf21a49f, var_6c57e71b, var_437c9d8d, var_f24d0052, var_6a7b6ec4, n_height = 80) {
  if(!var_6a7b6ec4) {
    var_bb956a6c = namespace_85745671::function_e4791424(var_cf21a49f, 1, n_height, var_f24d0052, max(var_437c9d8d, int(var_f24d0052 * 0.75)));

    if(isDefined(var_bb956a6c[0])) {
      var_bb956a6c = array::randomize(namespace_85745671::function_e4791424(var_bb956a6c[0].origin, var_6c57e71b, n_height, 1024, 8));
    }
  }

  if(!isDefined(var_bb956a6c) || !var_bb956a6c.size) {
    var_bb956a6c = array::randomize(namespace_85745671::function_e4791424(var_cf21a49f, var_6c57e71b, n_height, var_f24d0052, var_437c9d8d));
  }

  return var_bb956a6c;
}

function function_1c491c2b(var_6cd49f50 = 120, var_f6dca9f2, var_6443acc) {
  self endon(#"death");
  self thread namespace_85745671::function_9456addc(var_6cd49f50);

  while(true) {
    wait 5;
    a_players = getplayers("all", self.origin, 4096);

    if(a_players.size == 0 || isDefined(self.var_eb221ba) && self.var_eb221ba >= 10) {
      if(isDefined(var_f6dca9f2) && isDefined(var_6443acc)) {
        namespace_679a22ba::function_898aced0(var_f6dca9f2, var_6443acc);
      }

      self callback::callback(#"hash_10ab46b52df7967a");
    }
  }
}

function function_12db74f8() {
  if(self.zombie_move_speed !== # "super_sprint" && self.zombie_move_speed !== # "sprint") {
    self namespace_85745671::function_9758722(#"sprint");
  }
}

function private function_8af8f660() {
  v_average = (0, 0, 0);
  a_players = getplayers();

  foreach(player in a_players) {
    if(player.sessionstate === "spectator") {
      continue;
    }

    v_average += function_b5c91b37(player);
  }

  if(a_players.size > 1) {
    v_average /= a_players.size;
  }

  return v_average;
}

function private function_b5c91b37(player) {
  if(player isinvehicle()) {
    velocity = player getvehicleoccupied() getvelocity();
  } else {
    velocity = player getvelocity();
  }

  return player.origin + velocity * 5;
}

function function_c0966bb1(destination) {
  a_triggers = array::randomize(getEntArray("ambush_trigger", "targetname"));
  var_d0300267 = [];

  foreach(trigger in a_triggers) {
    if(trigger.destination === destination.targetname) {
      if(!isDefined(var_d0300267)) {
        var_d0300267 = [];
      } else if(!isarray(var_d0300267)) {
        var_d0300267 = array(var_d0300267);
      }

      var_d0300267[var_d0300267.size] = trigger;
    }
  }

  if(!var_d0300267.size) {
    return;
  }

  level flag::set(#"hash_44074059e3987765");
  n_max = var_d0300267.size * 0.666;
  n_count = 0;

  if(getdvarint(#"hash_11ff4ccbba6b40f6", 0)) {
    n_max = var_d0300267.size;
  }

  foreach(trigger in var_d0300267) {
    trigger.var_83523415 = undefined;

    if(n_count < n_max) {
      a_spawns = array::randomize(struct::get_array(trigger.target));
      trigger callback::on_trigger(&function_39ee3b21, undefined, a_spawns);
      n_count++;
      waitframe(1);
      continue;
    }

    trigger delete();
  }
}

function function_39ee3b21(eventstruct, a_spawns) {
  if(!is_true(self.var_83523415) && isPlayer(eventstruct.activator) && level flag::get(#"hash_44074059e3987765")) {
    self.var_83523415 = 1;
    self callback::remove_on_trigger(&function_39ee3b21);
    str_bundle = "default_zombies_realm_" + level.realm;

    if((!isDefined(a_spawns) || !a_spawns.size) && isDefined(self.spawn_struct)) {
      if(isalive(self.vehicle) && self.vehicle_position === self.vehicle.origin) {
        a_spawns = array(self.spawn_struct);
      } else {
        self delete();
        return;
      }
    }

    foreach(spawn in a_spawns) {
      if(getaicount() < getailimit()) {
        if(isDefined(spawn.var_90d0c0ff) && spawn.var_90d0c0ff == "anim_spawn_from_fireplace") {
          ai = spawnactor(#"hash_32f6e8de727ac61b", spawn.origin, spawn.angles, undefined, 1, 1);
        } else {
          var_4bf95f4c = namespace_679a22ba::function_ca209564(str_bundle);

          if(!isDefined(var_4bf95f4c)) {
            break;
          }

          var_abb82760 = namespace_85745671::function_3b941e5c(spawn.origin, var_4bf95f4c.aitype_name);
          var_4bf95f4c.aitype_name = isDefined(var_abb82760) ? var_abb82760 : var_4bf95f4c.aitype_name;
          ai = spawnactor(var_4bf95f4c.aitype_name, spawn.origin, spawn.angles, undefined, 1, 1);
        }

        if(isDefined(ai)) {
          if(isDefined(spawn.var_90d0c0ff) && spawn.var_90d0c0ff != " " && spawn.var_90d0c0ff != "") {
            ai.var_c9b11cb3 = spawn.var_90d0c0ff;
          } else {
            ai.var_c9b11cb3 = "anim_spawn_from_ground";
          }

          ai thread awareness::function_c241ef9a(ai, eventstruct.activator, 20);
          ai callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_5c3d1f);
        }
      }

      waitframe(randomintrange(2, 5));
    }
  }
}

function function_5c3d1f() {
  self notify("6f3adf669d32a3cc");
  self endon("6f3adf669d32a3cc");
  self endon(#"death");

  if(self.current_state.name !== # "wander" && self.current_state.name !== # "idle") {
    return;
  }

  while(self.birthtime + int(30 * 1000) > gettime() || getplayers(undefined, self.origin, 2048).size > 0) {
    wait 1;
  }

  if(self.current_state.name === # "wander" || self.current_state.name === # "idle") {
    self callback::callback(#"hash_10ab46b52df7967a");
  }
}

function init_devgui() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x49>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x83>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xbf>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xf7>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x141>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x191>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x1d9>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x221>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x275>");
  level thread function_2ebea850();
  level thread function_cfc99c9e();
  level thread function_986ead58();
}

function function_2ebea850() {
  while(true) {
    if(getdvarint(#"hash_21e1866f0c677ab8", 0)) {
      level notify(#"disable_ambush");
      setDvar(#"hash_21e1866f0c677ab8", 0);
    } else if(getdvarint(#"hash_606c763dd8de6def", 0)) {
      level notify(#"disable_ambush");
      level thread function_5e62ed5c();
      setDvar(#"hash_606c763dd8de6def", 0);
    } else if(getdvarint(#"hash_56ab9987e62df113", 0)) {
      level notify(#"ambush_over");
      array::run_all(getaiarray("<dev string:x2d0>", "<dev string:x2e1>"), &kill);
      setDvar(#"hash_56ab9987e62df113", 0);
    } else if(getdvarint(#"hash_94d12ce1eee7e5a", 0)) {
      level.var_49f4fe8e = 1;
      level thread function_be6ec6c();
      setDvar(#"hash_94d12ce1eee7e5a", 0);
    } else if(getdvarint(#"hash_3139027e2331e6b6", 0)) {
      level.var_49f4fe8e = 0;
      level thread function_be6ec6c();
      setDvar(#"hash_3139027e2331e6b6", 0);
    }

    wait 0.1;
  }
}

function function_cfc99c9e() {
  while(true) {
    if(getdvarint(#"hash_6c7a7cb80d06cc72", 0)) {
      level notify(#"disable_ambush");
      level.var_cf15d540 = 30;
      level.var_f535b5f0 = 40;
      level thread function_5e62ed5c();
      setDvar(#"hash_6c7a7cb80d06cc72", 0);
    } else if(getdvarint(#"hash_4ca0f239aa5ff2d7", 0)) {
      level notify(#"disable_ambush");
      level.var_cf15d540 = 300;
      level.var_f535b5f0 = 480;
      level thread function_5e62ed5c();
      setDvar(#"hash_4ca0f239aa5ff2d7", 0);
    }

    wait 0.1;
  }
}

function function_986ead58() {
  while(true) {
    if(getdvarint(#"hash_35d97c59a1cbade9", 0)) {
      spawns = function_10c88d2e();
      level thread namespace_420b39d3::function_46997bdf(&spawns, "<dev string:x2ef>");
      setDvar(#"hash_35d97c59a1cbade9", 0);
    } else if(getdvarint(#"hash_2fcac2478bfe37f7", 0)) {
      spawns = function_10c88d2e();
      namespace_420b39d3::function_70e877d7(&spawns);
      setDvar(#"hash_2fcac2478bfe37f7", 0);
    }

    wait 0.1;
  }
}

function function_10c88d2e() {
  spawns = [];

  if(isDefined(level.contentmanager.currentdestination)) {
    destination = level.contentmanager.currentdestination;
    a_triggers = getEntArray("<dev string:x2f9>", "<dev string:x2e1>");

    foreach(trigger in a_triggers) {
      if(trigger.destination === destination.targetname) {
        a_spawns = struct::get_array(trigger.target);
        spawns = arraycombine(a_spawns, spawns);
      }
    }
  }

  return spawns;
}