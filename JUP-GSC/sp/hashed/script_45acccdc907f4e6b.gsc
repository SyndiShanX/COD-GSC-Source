/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_45acccdc907f4e6b.gsc
*************************************************/

#using script_3a8f9ace195c9da9;
#using script_48324b060b129b7b;
#using scripts\common\anim;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_anim;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace namespace_d9f909ec3bbe3190;

function function_2c0fafcfd11ce596() {}

function function_f2f1d806aee5bca8(var_b5a86f3dc4a94929, spawner_targetname, area, var_16b05bd666017c36, spawn_func) {
  struct_array = getStructArray(var_b5a86f3dc4a94929, "targetname");
  return function_c81e06844e5ec033(struct_array, spawner_targetname, area, var_16b05bd666017c36, spawn_func);
}

function private function_c81e06844e5ec033(struct_array, spawner_targetname, area, var_16b05bd666017c36, spawn_func) {
  var_59c0ae1b42751e1c = [];

  foreach(struct in struct_array) {
    if(isDefined(struct.script_flag_wait) && !flag(struct.script_flag_wait)) {
      level thread function_7f3ead6056d853a9(struct, struct.script_flag_wait);
      continue;
    }

    spawner_struct = getStruct(spawner_targetname, "targetname");

    if(isDefined(spawner_struct) && !isDefined(spawner_struct.script_fakeactor) && !isDefined(spawner_struct.script_drone)) {}

    guy = function_30c9ebd0a0c2ad2(struct, spawner_targetname);
    guy thread[[spawn_func]]();
    var_59c0ae1b42751e1c = array_add(var_59c0ae1b42751e1c, guy);
  }

  if(!isDefined(var_16b05bd666017c36) || var_16b05bd666017c36) {
    level notify("ambient_vignette_areas_detect_player");
  }

  return var_59c0ae1b42751e1c;
}

function function_978c9be612a7da04(struct_targetname, guy) {
  if(!isDefined(guy)) {
    guy = self;
  }

  if(!isDefined(struct_targetname)) {
    struct_targetname = guy.animation;
  }

  guy endon("death");
  guy.animname = "generic";

  if(isstruct(struct_targetname)) {
    struct = struct_targetname;
  } else {
    struct = function_7a18da6e48b71c35(struct_targetname);
  }

  if(isDefined(struct.script_area)) {
    error(struct_targetname + " vignette struct with script_area cannot be used with the ambient_vignette_on_actor function");
  }

  struct thread function_e39484d42f09b9c1(guy);
  guy thread function_f1407389d8059cde();
}

function function_ee51e20891506e33(struct_targetname, end_on, var_b2ca5107267bfd0) {
  if(isDefined(end_on)) {
    level endon(end_on);
    self endon(end_on);
  }

  if(isDefined(var_b2ca5107267bfd0)) {
    vignette_struct = function_7a18da6e48b71c35(var_b2ca5107267bfd0);
  } else if(isstruct(struct_targetname)) {
    vignette_struct = struct_targetname;
  } else {
    vignette_struct = function_7a18da6e48b71c35(struct_targetname);
  }

  vignette_struct function_26a3493d0bbd5d04();

  if(isstruct(struct_targetname)) {
    target_node = struct_targetname;
  } else {
    target_node = function_7a18da6e48b71c35(struct_targetname);
  }

  if(!isDefined(target_node)) {
    target_node = function_ef5226389e773adc(struct_targetname);
  }

  target_node waittill("trigger", actor);

  if(isDefined(actor)) {
    if(isDefined(var_b2ca5107267bfd0)) {
      function_978c9be612a7da04(var_b2ca5107267bfd0, actor);
      return;
    }

    function_978c9be612a7da04(struct_targetname, actor);
  }
}

function private function_26a3493d0bbd5d04() {
  self.var_c1a11a0ac9f432e5 = 1;
}

function private function_af2ef99ebc503337(vign_struct) {
  if(!isDefined(level.var_726ab598c8999175)) {
    level.var_726ab598c8999175 = [];
  }

  if(isDefined(vign_struct.script_dialogue)) {
    level.var_726ab598c8999175[vign_struct.script_dialogue] = self;
  }
}

function function_245bb82d6b4f9621(vo_lines, guys, distance_to_player) {
  if(!isDefined(distance_to_player)) {
    distance_toplayer = 150;
  }

  for(i = 0; i < vo_lines.size; i++) {
    vo_line = vo_lines[i];
    guy = guys[i % guys.size];
    function_f6e5be73709120c9(vo_line, guy, distance_to_player);
  }
}

function function_f6e5be73709120c9(vo_line, guy, distance_to_player) {
  if(!isDefined(distance_to_player)) {
    distance_toplayer = 150;
  }

  if(isDefined(level.var_726ab598c8999175[guy])) {
    while(true) {
      if(isDefined(level.var_726ab598c8999175[guy])) {
        distance_from_player = distance(level.player.origin, level.var_726ab598c8999175[guy].origin);

        if(distance_from_player < distance_to_player) {
          level.var_726ab598c8999175[guy] function_31fcf0528e5d8d3f(vo_line);
          break;
        }

        waitframe();
        continue;
      }

      break;
    }
  }
}

function function_30c9ebd0a0c2ad2(struct, spawner_targetname) {
  if(isDefined(struct.spawned_ai)) {
    if(isalive(struct.spawned_ai)) {
      iprintln("<dev string:x1c>");
    } else {
      iprintln("<dev string:x57>");
    }
  }

  if(isDefined(struct.script_flag) && flag(struct.script_flag)) {
    if(getdvarint(@ "vignette_debug", 0) >= 2) {
      iprintln("<dev string:x89>" + struct.animation + "<dev string:xa5>");
    }

    return undefined;
  }

  var_c6d613ae4e3ab31b = function_7a18da6e48b71c35(spawner_targetname);

  if(isDefined(struct.script_char_index)) {
    var_c6d613ae4e3ab31b.script_char_index = struct.script_char_index;
  }

  var_c6d613ae4e3ab31b.count = 1;
  guy = var_c6d613ae4e3ab31b spawn_ai();
  var_c6d613ae4e3ab31b.script_char_index = undefined;

  if(!isDefined(guy)) {
    if(getdvarint(@ "vignette_debug", 0) >= 1) {
      if(isDefined(struct.animation)) {
        if(isDefined(struct.script_area)) {
          iprintln("<dev string:xdc>" + struct.animation + "<dev string:xf6>" + struct.script_area);
        } else {
          iprintln("<dev string:xdc>" + struct.animation);
        }
      } else {
        iprintln("<dev string:x100>");
      }
    }

    return guy;
  }

  guy.origin = struct.origin;
  guy.animname = "generic";
  guy thread function_af2ef99ebc503337(struct);
  struct.spawned_ai = guy;
  struct thread function_e39484d42f09b9c1(guy);
  guy thread function_f1407389d8059cde();
  return guy;
}

function function_6c41b6b29880e91b(struct) {
  if(isDefined(struct.spawned_ai)) {
    if(isDefined(struct.spawned_ai.var_13527d2fba952c3)) {
      struct.spawned_ai.var_13527d2fba952c3 delete();
    }

    struct.spawned_ai delete();
  }

  struct.spawned_ai = undefined;
}

function function_f1407389d8059cde() {
  thread function_20bbd63614910d95();
  self waittill("killvignettescript");

  if(isDefined(self.animstruct)) {
    self.animstruct notify("stop_loop");
    self.animstruct notify("single anim", "end");
    self.animstruct notify("looping anim", "end");
    self.animstruct notify("stop_animmode");
  }

  self.fixednode = 0;
}

function private function_20bbd63614910d95() {
  self waittill("death");
  self notify("killvignettescript");
}

function private function_e39484d42f09b9c1(guy) {
  level endon("game_over");
  guy endon("death");
  guy endon("vignette_clear_queue");
  function_916233af1855619c();

  if(isDefined(self.script_flag_wait) && !istrue(self.var_bd44a8387495a3fd)) {
    if(function_68f8b8bd65b54d3("ai_waittill_notify")) {
      guy waittill(self.script_flag_wait);
    } else {
      flag_wait(self.script_flag_wait);
    }
  }

  if(function_68f8b8bd65b54d3("combat_pathto")) {
    destination = guy function_f79d38f6a9ba4ebd(self, undefined, 0);
    guy function_87ace1da6b53a07f(destination);
    self.var_c1a11a0ac9f432e5 = 1;

    if(!function_68f8b8bd65b54d3("attack_while_pathing")) {
      self.ignoreall = 1;
    }

    guy.fixednode = 1;
  }

  if(function_68f8b8bd65b54d3("no_collide")) {
    guy notsolid();
  }

  anime = self.animation;
  guy.animation = self.targetname;
  guy.animstruct = self;

  if(isDefined(anime)) {
    if(guy.asmname != guy.defaultasm) {
      guy scripts\common\cap::cap_exit();
    }

    guy notify("next_vignette_started");

    if(!function_68f8b8bd65b54d3("no_vignette_props")) {
      guy function_4cac1b1f818c5e1(anime);
    }

    if(isDefined(self.var_c1a11a0ac9f432e5) && self.var_c1a11a0ac9f432e5) {
      guy.animname = "generic";
      anim_reach_solo(guy, anime);
    }

    if(isarray(level.scr_anim[guy.animname][anime])) {
      thread anim_generic_loop(guy, anime);

      if(isDefined(guy.var_13527d2fba952c3)) {
        thread anim_loop_solo(guy.var_13527d2fba952c3, anime);
      }

      if(isDefined(self.script_delay)) {
        if(isarray(level.scr_anim[guy.animname][anime])) {
          anim_entry = guy getanim(anime)[0];
        } else {
          anim_entry = guy getanim(anime);
        }

        total_time = getanimlength(anim_entry);
        assertex(self.script_delay < total_time, "Delay of guy at " + self.origin + " is larger than duration of the animation.");
        guy delaycall(0.05, &setanimtime, anim_entry, (self.script_delay - 0.05) / total_time);

        if(isDefined(guy.var_13527d2fba952c3)) {
          var_85a34c1e6ad7515f = guy.var_13527d2fba952c3 getanim(anime)[0];
          guy.var_13527d2fba952c3 delaycall(0.05, &setanimtime, var_85a34c1e6ad7515f, (self.script_delay - 0.05) / total_time);
        }
      }
    } else {
      if(isDefined(self.script_startrunning) && self.script_startrunning) {
        thread anim_generic_run(guy, anime);
      } else {
        thread anim_generic(guy, anime);
      }

      if(isDefined(guy.var_13527d2fba952c3)) {
        thread anim_single_solo(guy.var_13527d2fba952c3, anime);
      }

      if(isDefined(self.script_delay)) {
        wait 0.1;
        anim_set_time_solo(guy, anime, self.script_delay);

        if(isDefined(guy.var_13527d2fba952c3)) {
          anim_set_time_solo(guy.var_13527d2fba952c3, anime, self.script_delay);
        }
      }
    }

    if(isDefined(self.script_flag)) {
      guy thread delete_on_flag(self.script_flag);

      if(isDefined(guy.var_13527d2fba952c3)) {
        guy.var_13527d2fba952c3 thread delete_on_flag(self.script_flag);
      }
    }

    if(function_68f8b8bd65b54d3("abort_on_player_attack")) {
      thread function_a1cf2a622d1c69e4(guy);
    }
  }

  if(isDefined(self.target)) {
    nextstruct = function_7a18da6e48b71c35(self.target);
    nextstruct function_916233af1855619c();

    if(isDefined(nextstruct.script_flag_wait)) {
      if(nextstruct function_68f8b8bd65b54d3("ai_waittill_notify")) {
        guy waittill(nextstruct.script_flag_wait);
        nextstruct.var_bd44a8387495a3fd = 1;
      } else {
        flag_wait(nextstruct.script_flag_wait);
      }

      self notify("stop_loop");
      self notify("single anim", "end");
      waitframe();
    } else if(isDefined(anime)) {
      self waittill(anime);
    }

    nextstruct thread function_e39484d42f09b9c1(guy);
    return;
  }

  if(function_68f8b8bd65b54d3("death_anim")) {
    if(isDefined(anime)) {
      anim_entry = guy getanim(anime);
      total_time = getanimlength(anim_entry);
      wait total_time - 1;
    }

    guy.skipdeathanim = 1;
    guy.noragdoll = 1;
    guy kill();
  }
}

function private function_a1cf2a622d1c69e4(guy) {
  level endon("game_over");
  guy endon("death");
  guy endon("next_vignette_started");

  while(true) {
    guy waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(attacker == level.player) {
      break;
    }
  }

  guy notify("vignette_clear_queue");
  self notify("stop_loop");
  self notify("single anim", "end");
  guy function_e483413541e6f5cc();
  guy.animation = undefined;
  guy.fixednode = 0;
  guy.animstruct notify("killvignettescript");
}

function private function_7f3ead6056d853a9(struct, flag_name, var_f60cd9a27ada9130) {
  if(isDefined(struct.script_area)) {
    level endon("vignette_area_spawned" + struct.script_area);
    level endon("vignette_area_despawned" + struct.script_area);
  }

  flag_wait(flag_name);
  level thread function_30c9ebd0a0c2ad2(struct, struct.spawner_targetname);
}

function private function_4cac1b1f818c5e1(anime) {}

function function_18427c47e3d50aa0() {}

function function_3c2871f926a2104(obj, goalradius, endon_flag) {
  self endon("death");

  if(isDefined(endon_flag)) {
    self endon(endon_flag);
  }

  level thread function_ee51e20891506e33(obj);
  self.fixednode = 1;
  destination = function_f79d38f6a9ba4ebd(obj, goalradius, 0);
  function_87ace1da6b53a07f(destination, endon_flag);
  self notify("arrived");
  obj notify("trigger", self);
}

function function_a846ca4a4153373(start_flag, obj, goalradius, endon_flag) {
  self endon("death");

  if(isDefined(endon_flag)) {
    self endon(endon_flag);
  }

  if(!isDefined(start_flag)) {
    if(isDefined(obj.script_flag_wait)) {
      start_flag = obj.script_flag_wait;
    }
  }

  if(isDefined(start_flag)) {
    level flag_wait(start_flag);
  }

  function_3c2871f926a2104(obj, goalradius, endon_flag);
}

function private function_87ace1da6b53a07f(destination, endon_flag) {
  self endon("death");

  if(isDefined(endon_flag)) {
    self endon(endon_flag);
  }

  while(distance(self.origin, destination) > 5) {
    waitframe();
  }
}

function private function_5e587c0f3de781be(start_flag, obj, goalradius, endon_flag) {
  self endon("death");

  if(isDefined(endon_flag)) {
    self endon(endon_flag);
  }

  if(!isDefined(start_flag)) {
    if(isDefined(obj.script_flag_wait)) {
      start_flag = obj.script_flag_wait;
    }
  }

  self.fixednode = 1;
  function_f79d38f6a9ba4ebd(obj, goalradius, 0);

  if(isDefined(start_flag)) {
    level flag_wait(start_flag);
  }
}

function private function_f79d38f6a9ba4ebd(obj, goalradius, ignoreall_override) {
  self.goalradius = default_to(goalradius, 5);
  self.var_c833409fb72d15fb = 1;
  self.allowstrafe = 0;
  self.ignoreall = default_to(ignoreall_override, 1);
  destination = undefined;

  if(isDefined(obj.animation)) {
    animname = "generic";
    anime = obj.animation;
    animation = undefined;

    if(isDefined(level.scr_anim[animname][anime])) {
      if(isarray(level.scr_anim[animname][anime])) {
        animation = level.scr_anim[animname][anime][0];
      } else {
        animation = level.scr_anim[animname][anime];
      }
    }

    destination = getstartorigin(obj.origin, obj.angles, animation);
  }

  if(!isDefined(destination)) {
    destination = obj.origin;
  }

  self cleargoalvolume();
  self clearentitytarget();
  self.var_4ebe755e0a0a430e = 0;
  self.var_c833409fb72d15fb = 1;
  self setgoalpos(destination);
  return destination;
}

function function_c5754ca7623ea40b() {}

function anim_reach_solo(guy, anime, tag) {
  self endon("death");
  newguy[0] = guy;
  anim_reach(newguy, anime, tag);
}

function anim_reach(guys, anime, tag, animname_override) {
  anim_reach_with_funcs(guys, anime, tag, animname_override, &function_f7abc6758c6fa304, &function_fa9f14f0cbd676f0);
}

function function_387a7cfe0a5bff51() {}