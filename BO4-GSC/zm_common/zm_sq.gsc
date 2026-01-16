/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_sq.gsc
***********************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;

#namespace zm_sq;

private autoexec init() {
  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    adddebugcommand("<dev string:x38>");
  }
}

  function register(name, step_name, var_e788cdd7, setup_func, cleanup_func, var_d6ca4caf, var_27465eb4) {

    assert(ishash(name), "<dev string:x77>");
    assert(ishash(step_name), "<dev string:x90>");
    assert(ishash(var_e788cdd7), "<dev string:xab>");

    if(!isDefined(name)) {
      if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
        iprintlnbold("<dev string:xca>");
        println("<dev string:xca>");
      }

      return;
    }

    if(!isDefined(step_name)) {
      if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
        iprintlnbold("<dev string:x10d>");
        println("<dev string:x10d>");
      }

      return;
    }

    if(!isDefined(setup_func)) {
      if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
        iprintlnbold("<dev string:x155>");
        println("<dev string:x155>");
      }

      return;
    }

    if(!isDefined(cleanup_func)) {
      if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
        iprintlnbold("<dev string:x19e>");
        println("<dev string:x19e>");
      }

      return;
    }

    if(isDefined(level._ee) && isDefined(level._ee[name]) && isDefined(var_d6ca4caf) && isDefined(level._ee[name].record_stat)) {
      if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
        iprintlnbold("<dev string:x1e9>");
        println("<dev string:x1e9>");
      }

      return;
    }

      if(!isDefined(level._ee)) {
        level._ee = [];
      }

    if(!isDefined(level._ee[name])) {
      level._ee[name] = {
        #name: name, 
        #completed: 0, 
        #steps: [], 
        #current_step: 0, 
        #started: 0, 
        #skip_to_step: -1
      };

      if(getdvarint(#"zm_debug_ee", 0)) {
        thread function_28aee167(name);
      }

    }

    ee = level._ee[name];

    if(!isDefined(ee.record_stat)) {
      ee.record_stat = var_d6ca4caf;
    }

    if(!isDefined(ee.var_35ccab99)) {
      ee.var_35ccab99 = var_27465eb4;
    }

    new_step = {
      #name: step_name, 
      #ee: ee, 
      #var_e788cdd7: var_e788cdd7, 
      #setup_func: setup_func, 
      #cleanup_func: cleanup_func, 
      #started: 0, 
      #completed: 0, 
      #cleaned_up: 0
    };
    previous_step = ee.steps[level._ee[name].steps.size - 1];

    if(isDefined(previous_step)) {
      previous_step.next_step = new_step;
    }

    if(!isDefined(ee.steps)) {
      ee.steps = [];
    } else if(!isarray(ee.steps)) {
      ee.steps = array(ee.steps);
    }

    ee.steps[ee.steps.size] = new_step;
    level flag::init(var_e788cdd7 + "_completed");

    if(!level flag::exists(ee.name + "_completed")) {
      level flag::init(ee.name + "_completed");
    }

    if(getdvarint(#"zm_debug_ee", 0)) {
      thread function_b3da1a16(ee.name, new_step.name);
      thread devgui_think();
    }

  }

start(name, var_9d8cf7f = 0) {
  if(!zm_utility::is_ee_enabled() && !var_9d8cf7f) {
    return;
  }

  assert(ishash(name), "<dev string:x77>");
  assert(isDefined(level._ee[name]), "<dev string:x244>" + function_9e72a96(name) + "<dev string:x24a>");

  if(level._ee[name].started) {

    if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
      iprintlnbold("<dev string:x244>" + function_9e72a96(name) + "<dev string:x265>");
      println("<dev string:x244>" + function_9e72a96(name) + "<dev string:x265>");
    }

      return;
  }

  ee = level._ee[name];
  var_5ea5c94d = 0;

  if(ee.skip_to_step > -1) {
    assert(0 <= ee.skip_to_step, "<dev string:x281>");

    if(0 < ee.skip_to_step) {
      var_5ea5c94d = 1;
    } else if(0 == ee.skip_to_step) {
      ee.skip_to_step = -1;
    }
  }

    level thread run_step(ee, ee.steps[0], var_5ea5c94d);
}

is_complete(name) {
  assert(ishash(name), "<dev string:x77>");
  assert(isDefined(level._ee[name]), "<dev string:x244>" + function_9e72a96(name) + "<dev string:x24a>");
  return level._ee[name].completed;
}

function_9212ff4d(ee_name, step_name) {
  assert(ishash(ee_name), "<dev string:x77>");
  assert(ishash(step_name), "<dev string:x90>");
  assert(isDefined(level._ee[ee_name]), "<dev string:x244>" + ee_name + "<dev string:x2a5>");

  foreach(ee_index, ee_step in level._ee[ee_name].steps) {
    if(step_name == ee_step.name) {
      return ee_index;
    }
  }

  return -1;
}

private run_step(ee, step, var_5ea5c94d) {
  level endon(#"game_ended");

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(step.name) + "<dev string:x2c8>");
    println(function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(step.name) + "<dev string:x2c8>");
  }

    ee.started = 1;
  step.started = 1;
  level thread function_3f795dc3(ee, step, var_5ea5c94d);

  if(!step.completed) {
    waitresult = level waittill(step.var_e788cdd7 + "_setup_completed", step.var_e788cdd7 + "_ended_early");
  }

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(step.name) + "<dev string:x2da>");
    println(function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(step.name) + "<dev string:x2da>");
  }

    if(game.state === "postgame") {
      return;
    }

  ended_early = isDefined(waitresult) && waitresult._notify == step.var_e788cdd7 + "_ended_early";
  [[step.cleanup_func]](var_5ea5c94d, ended_early);

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(step.name) + "<dev string:x2ef>");
    println(function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(step.name) + "<dev string:x2ef>");
  }

    step.cleaned_up = 1;

  if(game.state === "postgame") {
    return;
  }

  level flag::set(step.var_e788cdd7 + "_completed");

  if(ee.current_step === 0 && isDefined(ee.record_stat) && ee.record_stat) {
    players = getplayers();

    foreach(player in players) {
      player.var_897fa11b = 1;
    }
  }

  if(isDefined(step.next_step)) {
    var_5ea5c94d = 0;

    if(ee.skip_to_step > -1) {
      var_7f1ec3f3 = ee.current_step + 1;
      assert(var_7f1ec3f3 <= ee.skip_to_step, "<dev string:x281>");

      if(var_7f1ec3f3 < ee.skip_to_step) {
        var_5ea5c94d = 1;
      } else if(var_7f1ec3f3 == ee.skip_to_step) {
        ee.skip_to_step = -1;
      }

      wait 0.5;
    }

      ee.current_step++;
    level thread run_step(ee, step.next_step, var_5ea5c94d);
    return;
  }

  ee.completed = 1;
  level flag::set(ee.name + "_completed");

  if(sessionmodeisonlinegame() && isDefined(ee.record_stat) && ee.record_stat) {
    players = getplayers();

    foreach(player in players) {
      if(isDefined(player.var_897fa11b) && player.var_897fa11b) {
        player zm_stats::set_map_stat(#"main_quest_completed", 1);
        player zm_stats::function_a6efb963(#"main_quest_completed", 1);
        player zm_stats::function_9288c79b(#"main_quest_completed", 1);
        n_time_elapsed = gettime() - level.var_21e22beb;
        player zm_stats::function_366b6fb9("FASTEST_QUEST_COMPLETION_TIME", n_time_elapsed);
        scoreevents::processscoreevent(#"main_ee", player);

        if(isDefined(ee.var_35ccab99)) {
          player thread[[ee.var_35ccab99]]();
        }
      }
    }

    zm_stats::set_match_stat(#"main_quest_completed", 1);
    zm_stats::function_ea5b4947();
  }

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold("<dev string:x244>" + function_9e72a96(ee.name) + "<dev string:x306>");
    println("<dev string:x244>" + function_9e72a96(ee.name) + "<dev string:x306>");
  }

}

private function_3f795dc3(ee, step, var_5ea5c94d) {
  level endon(#"game_ended");
  step endoncallback(&function_df365859, #"end_early");
  level notify(step.var_e788cdd7 + "_started");
  [[step.setup_func]](var_5ea5c94d);
  step.completed = 1;
  level notify(step.var_e788cdd7 + "_setup_completed");
}

private function_df365859(notifyhash) {

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(function_9e72a96(self.ee.name) + "<dev string:x2c4>" + function_9e72a96(self.name) + "<dev string:x316>");
    println(function_9e72a96(self.ee.name) + "<dev string:x2c4>" + function_9e72a96(self.name) + "<dev string:x316>");
  }

    self.completed = 1;
  level notify(self.var_e788cdd7 + "_ended_early");
  level notify(self.var_e788cdd7 + "_setup_completed");
}

function_f09763fd(ee_name, step_name) {
  assert(ishash(ee_name), "<dev string:x77>");
  assert(isDefined(level._ee[ee_name]), "<dev string:x244>" + ee_name + "<dev string:x2a5>");
  var_da601d7f = function_44e256d8(ee_name);
  index = function_9212ff4d(ee_name, step_name);

  if(index == -1) {
    if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
      iprintlnbold("<dev string:x244>" + function_9e72a96(ee_name) + "<dev string:x325>" + function_9e72a96(step_name));
      println("<dev string:x244>" + function_9e72a96(ee_name) + "<dev string:x325>" + function_9e72a96(step_name));
    }

    return;
  }

  return var_da601d7f + "<dev string:x33f>" + function_9e72a96(step_name) + "<dev string:x348>" + index + "<dev string:x34c>";
}

function_44e256d8(ee_name) {
  assert(ishash(ee_name), "<dev string:x77>");
  return "<dev string:x350>" + function_9e72a96(ee_name) + "<dev string:x34c>";
}

function_28aee167(ee_name) {
  assert(ishash(ee_name), "<dev string:x77>");
  ee_path = function_44e256d8(ee_name);
  util::waittill_can_add_debug_command();
  adddebugcommand("<dev string:x359>" + ee_path + "<dev string:x368>" + function_9e72a96(ee_name) + "<dev string:x38b>");
}

function_b3da1a16(ee_name, step_name) {
  assert(ishash(ee_name), "<dev string:x77>");
  assert(ishash(step_name), "<dev string:x90>");
  step_path = function_f09763fd(ee_name, step_name);
  index = function_9212ff4d(ee_name, step_name);
  util::waittill_can_add_debug_command();
  adddebugcommand("<dev string:x359>" + step_path + "<dev string:x390>" + function_9e72a96(ee_name) + "<dev string:x2c4>" + index + "<dev string:x38b>");
  adddebugcommand("<dev string:x359>" + step_path + "<dev string:x3b7>" + function_9e72a96(ee_name) + "<dev string:x2c4>" + index + "<dev string:x38b>");
}

function_87306f8a(ee_name, step_name) {
  ee = level._ee[ee_name];
  step_index = function_9212ff4d(ee_name, step_name);

  if(ee.started && step_index <= ee.current_step) {
    return 0;
  }

  ee.skip_to_step = step_index;

  if(ee.started) {
    function_614612f(ee_name);
  } else {
    start(ee.name);
  }

  return 1;
}

function_614612f(ee_name) {
  ee = level._ee[ee_name];

  if(ee.started) {
    ee.steps[ee.current_step] notify(#"end_early");
    return;
  }

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold("<dev string:x3e0>" + function_9e72a96(ee_name) + "<dev string:x2c4>" + function_9e72a96(ee.steps[ee.current_step].name) + "<dev string:x3f6>");
    println("<dev string:x3e0>" + function_9e72a96(ee_name) + "<dev string:x2c4>" + function_9e72a96(ee.steps[ee.current_step].name) + "<dev string:x3f6>");
  }
}

function_f2dd8601(ee_name, var_f2c264bb) {
  level endon(#"game_ended");
  ee = level._ee[ee_name];
  step = ee.steps[var_f2c264bb];

  if(function_87306f8a(ee_name, step.name)) {
    if(!step.started) {
      wait_time = 10 * ee.steps.size;
      waitresult = level waittilltimeout(wait_time, step.var_e788cdd7 + "<dev string:x413>");

      if(waitresult._notify == #"timeout") {
        if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
          iprintlnbold("<dev string:x41e>" + function_9e72a96(ee_name) + "<dev string:x2c4>" + function_9e72a96(ee.steps[ee.current_step].name));
          println("<dev string:x41e>" + function_9e72a96(ee_name) + "<dev string:x2c4>" + function_9e72a96(ee.steps[ee.current_step].name));
        }

        return;
      }
    }

    wait 1;
  }

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold("<dev string:x448>" + function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(ee.steps[ee.current_step].name) + "<dev string:x456>");
    println("<dev string:x448>" + function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(ee.steps[ee.current_step].name) + "<dev string:x456>");
  }

  function_614612f(ee_name);
}

devgui_think() {
  level notify(#"hash_6d8b1a4c632ecc9");
  level endon(#"hash_6d8b1a4c632ecc9");

  while(true) {
    wait 1;
    cmd = getdvarstring(#"hash_319d902ea18eb39");
    setdvar(#"hash_319d902ea18eb39", "<dev string:x45c>");
    cmd = strtok(cmd, "<dev string:x2c4>");

    if(cmd.size == 0) {
      continue;
    }

    switch (cmd[0]) {
      case #"skip_to":
        ee = level._ee[cmd[1]];

        if(!isDefined(ee)) {
          continue;
        }

        var_f2c264bb = int(cmd[2]);
        step_name = ee.steps[var_f2c264bb].name;

        if(var_f2c264bb < ee.current_step) {
          if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x45f>" + function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(ee.steps[ee.current_step].name));
            println("<dev string:x45f>" + function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(ee.steps[ee.current_step].name));
          }
        } else if(var_f2c264bb == ee.current_step) {
          if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x48f>" + function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(step_name));
            println("<dev string:x48f>" + function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(step_name));
          }
        } else {
          if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x4a2>" + function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(step_name) + "<dev string:x456>");
            println("<dev string:x4a2>" + function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(step_name) + "<dev string:x456>");
          }

          function_87306f8a(ee.name, step_name);
        }

        break;
      case #"complete":
        ee = level._ee[cmd[1]];

        if(!isDefined(ee)) {
          continue;
        }

        var_f2c264bb = int(cmd[2]);

        if(var_f2c264bb < ee.current_step) {
          if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x4b1>" + function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(ee.steps[ee.current_step].name));
            println("<dev string:x4b1>" + function_9e72a96(ee.name) + "<dev string:x2c4>" + function_9e72a96(ee.steps[ee.current_step].name));
          }
        } else {
          level thread function_f2dd8601(ee.name, var_f2c264bb);
        }

        break;
      case #"start":
        if(isDefined(level._ee[cmd[1]])) {
          start(hash(cmd[1]));
        }

        break;
      case #"show_status":
        if(isDefined(level.var_7f2ca392) && level.var_7f2ca392) {
          function_c1d3567c();
        } else {
          function_5df75220();
          level thread function_9bee49bf();
        }

        break;
      case #"outro":
        if(cmd.size < 2 || !isDefined(level._ee[cmd[1]])) {
          break;
        }

        ee = level._ee[cmd[1]];

        if(isDefined(ee)) {
          level waittill(#"start_zombie_round_logic");
          step_name = ee.steps[ee.steps.size - 1].name;
          function_87306f8a(ee.name, step_name);
        }

        break;
    }
  }
}

private create_hudelem(y, x) {
  if(!isDefined(x)) {
    x = 0;
  }

  var_aa917a22 = newdebughudelem();
  var_aa917a22.alignx = "<dev string:x4e2>";
  var_aa917a22.horzalign = "<dev string:x4e2>";
  var_aa917a22.aligny = "<dev string:x4e9>";
  var_aa917a22.vertalign = "<dev string:x4f2>";
  var_aa917a22.y = y;
  var_aa917a22.x = x;
  return var_aa917a22;
}

function_5df75220() {
  current_y = 30;

  foreach(ee in level._ee) {
    current_x = 30;

    if(!isDefined(ee.debug_hudelem)) {
      ee.debug_hudelem = create_hudelem(current_y, current_x);
    }

    ee.debug_hudelem settext(function_9e72a96(ee.name));
    ee.debug_hudelem.fontscale = 1.5;
    current_x += 5;
    step_string = "<dev string:x4f8>";

    foreach(step in ee.steps) {
      current_y += 15;

      if(!isDefined(step.debug_hudelem)) {
        step.debug_hudelem = create_hudelem(current_y, current_x);
      }

      step.debug_hudelem settext(step_string + function_9e72a96(step.name));
      step.debug_hudelem.fontscale = 1.5;
    }

    current_y += 30;
  }

  level.var_7f2ca392 = 1;
}

function_c1d3567c() {
  level notify(#"hash_21c0567b0010f696");

  foreach(ee in level._ee) {
    if(isDefined(ee.debug_hudelem)) {
      ee.debug_hudelem destroy();
    }

    ee.debug_hudelem = undefined;

    foreach(step in ee.steps) {
      if(isDefined(step.debug_hudelem)) {
        step.debug_hudelem destroy();
      }

      step.debug_hudelem = undefined;
    }
  }

  level.var_7f2ca392 = undefined;
}

function_9bee49bf() {
  level endon(#"hash_21c0567b0010f696");

  while(true) {
    waitframe(1);

    foreach(ee in level._ee) {
      ee.debug_hudelem.color = function_1091b2a0(ee);

      foreach(step in ee.steps) {
        step.debug_hudelem.color = function_1091b2a0(step);
      }
    }
  }
}

function_1091b2a0(var_4f1c1316) {
  if(!var_4f1c1316.started) {
    color = (0.75, 0.75, 0.75);
  } else if(!var_4f1c1316.completed) {
    color = (1, 0, 0);
  } else {
    color = (0, 1, 0);
  }

  return color;
}

