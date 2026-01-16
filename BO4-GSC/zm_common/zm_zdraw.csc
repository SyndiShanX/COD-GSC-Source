/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_zdraw.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_utility;

#namespace zm_zdraw;

autoexec __init__system__() {
  system::register(#"zdraw", &__init__, &__main__, undefined);
}

__init__() {
  setdvar(#"zdraw", "<dev string:x38>");
  level.zdraw = spawnStruct();
  function_c9f70832();
  function_99bd35ec();
  function_b36498d3();
  level thread function_c78d9e67();
}

__main__() {}

function_c9f70832() {
  level.zdraw.colors = [];
  level.zdraw.colors[#"red"] = (1, 0, 0);
  level.zdraw.colors[#"green"] = (0, 1, 0);
  level.zdraw.colors[#"blue"] = (0, 0, 1);
  level.zdraw.colors[#"yellow"] = (1, 1, 0);
  level.zdraw.colors[#"orange"] = (1, 0.5, 0);
  level.zdraw.colors[#"cyan"] = (0, 1, 1);
  level.zdraw.colors[#"purple"] = (1, 0, 1);
  level.zdraw.colors[#"black"] = (0, 0, 0);
  level.zdraw.colors[#"white"] = (1, 1, 1);
  level.zdraw.colors[#"grey"] = (0.75, 0.75, 0.75);
  level.zdraw.colors[#"gray1"] = (0.1, 0.1, 0.1);
  level.zdraw.colors[#"gray2"] = (0.2, 0.2, 0.2);
  level.zdraw.colors[#"gray3"] = (0.3, 0.3, 0.3);
  level.zdraw.colors[#"gray4"] = (0.4, 0.4, 0.4);
  level.zdraw.colors[#"gray5"] = (0.5, 0.5, 0.5);
  level.zdraw.colors[#"gray6"] = (0.6, 0.6, 0.6);
  level.zdraw.colors[#"gray7"] = (0.7, 0.7, 0.7);
  level.zdraw.colors[#"gray8"] = (0.8, 0.8, 0.8);
  level.zdraw.colors[#"gray9"] = (0.9, 0.9, 0.9);
  level.zdraw.colors[#"slate"] = (0.439216, 0.501961, 0.564706);
  level.zdraw.colors[#"pink"] = (1, 0.752941, 0.796078);
  level.zdraw.colors[#"olive"] = (0.501961, 0.501961, 0);
  level.zdraw.colors[#"brown"] = (0.545098, 0.270588, 0.0745098);
  level.zdraw.colors[#"default"] = (1, 1, 1);
}

function_99bd35ec() {
  level.zdraw.commands = [];
  level.zdraw.commands[#"color"] = &function_54389019;
  level.zdraw.commands[#"alpha"] = &function_82f2d020;
  level.zdraw.commands[#"duration"] = &function_cb18c560;
  level.zdraw.commands[#"seconds"] = &function_82201799;
  level.zdraw.commands[#"scale"] = &function_f7176625;
  level.zdraw.commands[#"radius"] = &function_a026f442;
  level.zdraw.commands[#"sides"] = &function_912c8db9;
  level.zdraw.commands[#"text"] = &function_b5cdeec6;
  level.zdraw.commands[#"star"] = &function_da7503f4;
  level.zdraw.commands[#"sphere"] = &function_3a2c5c6b;
  level.zdraw.commands[#"line"] = &function_25fd7d2a;
}

function_b36498d3() {
  level.zdraw.color = level.zdraw.colors[#"default"];
  level.zdraw.alpha = 1;
  level.zdraw.scale = 1;
  level.zdraw.duration = int(1 * 62.5);
  level.zdraw.radius = 8;
  level.zdraw.sides = 10;
  level.zdraw.var_eeef5e89 = (0, 0, 0);
  level.zdraw.var_f78505a1 = 0;
  level.zdraw.var_d15c03f8 = "<dev string:x38>";
}

function_c78d9e67() {
  level notify(#"hash_79dc2eb04ee1da22");
  level endon(#"hash_79dc2eb04ee1da22");

  for(;;) {
    cmd = getdvarstring(#"zdraw");

    if(cmd.size) {
      function_b36498d3();
      params = strtok(cmd, "<dev string:x3b>");
      function_cd7ed6c5(params, 0, 1);
      setdvar(#"zdraw", "<dev string:x38>");
    }

    wait 0.5;
  }
}

function_cd7ed6c5(var_a99ac828, startat, toplevel) {
  if(!isDefined(toplevel)) {
    toplevel = 0;
  }

  while(isDefined(var_a99ac828[startat])) {
    if(isDefined(level.zdraw.commands[var_a99ac828[startat]])) {
      startat = [
        [level.zdraw.commands[var_a99ac828[startat]]]
      ](var_a99ac828, startat + 1);
      continue;
    }

    if(isDefined(toplevel) && toplevel) {
      function_96c207f("<dev string:x41>" + var_a99ac828[startat]);
    }

    return startat;
  }

  return startat;
}

function_3a2c5c6b(var_a99ac828, startat) {
  while(isDefined(var_a99ac828[startat])) {
    if(function_b0f457f2(var_a99ac828[startat])) {
      var_769ff4d7 = function_b59acc83(var_a99ac828, startat);

      if(var_769ff4d7 > startat) {
        startat = var_769ff4d7;
        center = level.zdraw.var_eeef5e89;
        sphere(center, level.zdraw.radius, level.zdraw.color, level.zdraw.alpha, 1, level.zdraw.sides, level.zdraw.duration);
        level.zdraw.var_eeef5e89 = (0, 0, 0);
      }

      continue;
    }

    var_769ff4d7 = function_cd7ed6c5(var_a99ac828, startat);

    if(var_769ff4d7 > startat) {
      startat = var_769ff4d7;
      continue;
    }

    return startat;
  }

  return startat;
}

function_da7503f4(var_a99ac828, startat) {
  while(isDefined(var_a99ac828[startat])) {
    if(function_b0f457f2(var_a99ac828[startat])) {
      var_769ff4d7 = function_b59acc83(var_a99ac828, startat);

      if(var_769ff4d7 > startat) {
        startat = var_769ff4d7;
        center = level.zdraw.var_eeef5e89;
        debugstar(center, level.zdraw.duration, level.zdraw.color);
        level.zdraw.var_eeef5e89 = (0, 0, 0);
      }

      continue;
    }

    var_769ff4d7 = function_cd7ed6c5(var_a99ac828, startat);

    if(var_769ff4d7 > startat) {
      startat = var_769ff4d7;
      continue;
    }

    return startat;
  }

  return startat;
}

function_25fd7d2a(var_a99ac828, startat) {
  level.zdraw.linestart = undefined;

  while(isDefined(var_a99ac828[startat])) {
    if(function_b0f457f2(var_a99ac828[startat])) {
      var_769ff4d7 = function_b59acc83(var_a99ac828, startat);

      if(var_769ff4d7 > startat) {
        startat = var_769ff4d7;
        lineend = level.zdraw.var_eeef5e89;

        if(isDefined(level.zdraw.linestart)) {
          line(level.zdraw.linestart, lineend, level.zdraw.color, level.zdraw.alpha, 1, level.zdraw.duration);
        }

        level.zdraw.linestart = lineend;
        level.zdraw.var_eeef5e89 = (0, 0, 0);
      }

      continue;
    }

    var_769ff4d7 = function_cd7ed6c5(var_a99ac828, startat);

    if(var_769ff4d7 > startat) {
      startat = var_769ff4d7;
      continue;
    }

    return startat;
  }

  return startat;
}

function_b5cdeec6(var_a99ac828, startat) {
  level.zdraw.text = "<dev string:x38>";

  if(isDefined(var_a99ac828[startat])) {
    var_769ff4d7 = function_7bf700e4(var_a99ac828, startat);

    if(var_769ff4d7 > startat) {
      startat = var_769ff4d7;
      level.zdraw.text = level.zdraw.var_d15c03f8;
      level.zdraw.var_d15c03f8 = "<dev string:x38>";
    }
  }

  while(isDefined(var_a99ac828[startat])) {
    if(function_b0f457f2(var_a99ac828[startat])) {
      var_769ff4d7 = function_b59acc83(var_a99ac828, startat);

      if(var_769ff4d7 > startat) {
        startat = var_769ff4d7;
        center = level.zdraw.var_eeef5e89;
        print3d(center, level.zdraw.text, level.zdraw.color, level.zdraw.alpha, level.zdraw.scale, level.zdraw.duration);
        level.zdraw.var_eeef5e89 = (0, 0, 0);
      }

      continue;
    }

    var_769ff4d7 = function_cd7ed6c5(var_a99ac828, startat);

    if(var_769ff4d7 > startat) {
      startat = var_769ff4d7;
      continue;
    }

    return startat;
  }

  return startat;
}

function_54389019(var_a99ac828, startat) {
  if(isDefined(var_a99ac828[startat])) {
    if(function_b0f457f2(var_a99ac828[startat])) {
      var_769ff4d7 = function_b59acc83(var_a99ac828, startat);

      if(var_769ff4d7 > startat) {
        startat = var_769ff4d7;
        level.zdraw.color = level.zdraw.var_eeef5e89;
        level.zdraw.var_eeef5e89 = (0, 0, 0);
      } else {
        level.zdraw.color = (1, 1, 1);
      }
    } else {
      if(isDefined(level.zdraw.colors[var_a99ac828[startat]])) {
        level.zdraw.color = level.zdraw.colors[var_a99ac828[startat]];
      } else {
        level.zdraw.color = (1, 1, 1);
        function_96c207f("<dev string:x59>" + var_a99ac828[startat]);
      }

      startat += 1;
    }
  }

  return startat;
}

function_82f2d020(var_a99ac828, startat) {
  if(isDefined(var_a99ac828[startat])) {
    var_769ff4d7 = revive_getdvar(var_a99ac828, startat);

    if(var_769ff4d7 > startat) {
      startat = var_769ff4d7;
      level.zdraw.alpha = level.zdraw.var_f78505a1;
      level.zdraw.var_f78505a1 = 0;
    } else {
      level.zdraw.alpha = 1;
    }
  }

  return startat;
}

function_f7176625(var_a99ac828, startat) {
  if(isDefined(var_a99ac828[startat])) {
    var_769ff4d7 = revive_getdvar(var_a99ac828, startat);

    if(var_769ff4d7 > startat) {
      startat = var_769ff4d7;
      level.zdraw.scale = level.zdraw.var_f78505a1;
      level.zdraw.var_f78505a1 = 0;
    } else {
      level.zdraw.scale = 1;
    }
  }

  return startat;
}

function_cb18c560(var_a99ac828, startat) {
  if(isDefined(var_a99ac828[startat])) {
    var_769ff4d7 = revive_getdvar(var_a99ac828, startat);

    if(var_769ff4d7 > startat) {
      startat = var_769ff4d7;
      level.zdraw.duration = int(level.zdraw.var_f78505a1);
      level.zdraw.var_f78505a1 = 0;
    } else {
      level.zdraw.duration = int(1 * 62.5);
    }
  }

  return startat;
}

function_82201799(var_a99ac828, startat) {
  if(isDefined(var_a99ac828[startat])) {
    var_769ff4d7 = revive_getdvar(var_a99ac828, startat);

    if(var_769ff4d7 > startat) {
      startat = var_769ff4d7;
      level.zdraw.duration = int(62.5 * level.zdraw.var_f78505a1);
      level.zdraw.var_f78505a1 = 0;
    } else {
      level.zdraw.duration = int(1 * 62.5);
    }
  }

  return startat;
}

function_a026f442(var_a99ac828, startat) {
  if(isDefined(var_a99ac828[startat])) {
    var_769ff4d7 = revive_getdvar(var_a99ac828, startat);

    if(var_769ff4d7 > startat) {
      startat = var_769ff4d7;
      level.zdraw.radius = level.zdraw.var_f78505a1;
      level.zdraw.var_f78505a1 = 0;
    } else {
      level.zdraw.radius = 8;
    }
  }

  return startat;
}

function_912c8db9(var_a99ac828, startat) {
  if(isDefined(var_a99ac828[startat])) {
    var_769ff4d7 = revive_getdvar(var_a99ac828, startat);

    if(var_769ff4d7 > startat) {
      startat = var_769ff4d7;
      level.zdraw.sides = int(level.zdraw.var_f78505a1);
      level.zdraw.var_f78505a1 = 0;
    } else {
      level.zdraw.sides = 10;
    }
  }

  return startat;
}

function_b0f457f2(param) {
  if(isDefined(param) && (isint(param) || isfloat(param) || isstring(param) && strisnumber(param))) {
    return 1;
  }

  return 0;
}

function_b59acc83(var_a99ac828, startat) {
  if(isDefined(var_a99ac828[startat])) {
    var_769ff4d7 = revive_getdvar(var_a99ac828, startat);

    if(var_769ff4d7 > startat) {
      startat = var_769ff4d7;
      level.zdraw.var_eeef5e89 = (level.zdraw.var_f78505a1, level.zdraw.var_eeef5e89[1], level.zdraw.var_eeef5e89[2]);
      level.zdraw.var_f78505a1 = 0;
    } else {
      function_96c207f("<dev string:x6f>");
      return startat;
    }

    var_769ff4d7 = revive_getdvar(var_a99ac828, startat);

    if(var_769ff4d7 > startat) {
      startat = var_769ff4d7;
      level.zdraw.var_eeef5e89 = (level.zdraw.var_eeef5e89[0], level.zdraw.var_f78505a1, level.zdraw.var_eeef5e89[2]);
      level.zdraw.var_f78505a1 = 0;
    } else {
      function_96c207f("<dev string:x6f>");
      return startat;
    }

    var_769ff4d7 = revive_getdvar(var_a99ac828, startat);

    if(var_769ff4d7 > startat) {
      startat = var_769ff4d7;
      level.zdraw.var_eeef5e89 = (level.zdraw.var_eeef5e89[0], level.zdraw.var_eeef5e89[1], level.zdraw.var_f78505a1);
      level.zdraw.var_f78505a1 = 0;
    } else {
      function_96c207f("<dev string:x6f>");
      return startat;
    }
  }

  return startat;
}

revive_getdvar(var_a99ac828, startat) {
  if(isDefined(var_a99ac828[startat])) {
    if(function_b0f457f2(var_a99ac828[startat])) {
      level.zdraw.var_f78505a1 = float(var_a99ac828[startat]);
      startat += 1;
    }
  }

  return startat;
}

function_7bf700e4(var_a99ac828, startat) {
  if(isDefined(var_a99ac828[startat])) {
    level.zdraw.var_d15c03f8 = var_a99ac828[startat];
    startat += 1;
  }

  return startat;
}

function_96c207f(msg) {
  println("<dev string:x94>" + msg);
}

