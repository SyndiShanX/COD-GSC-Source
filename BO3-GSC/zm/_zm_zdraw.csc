/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_zdraw.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#namespace zm_zdraw;

function autoexec __init__sytem__() {
  system::register("", &__init__, &__main__, undefined);
}

function __init__() {
  setDvar("", "");
  level.zdraw = spawnStruct();
  function_3e630288();
  function_aa8545fe();
  function_404ac348();
  level thread function_41fec76e();
}

function __main__() {}

function function_3e630288() {
  level.zdraw.colors = [];
  level.zdraw.colors[""] = (1, 0, 0);
  level.zdraw.colors[""] = (0, 1, 0);
  level.zdraw.colors[""] = (0, 0, 1);
  level.zdraw.colors[""] = (1, 1, 0);
  level.zdraw.colors[""] = (1, 0.5, 0);
  level.zdraw.colors[""] = (0, 1, 1);
  level.zdraw.colors[""] = (1, 0, 1);
  level.zdraw.colors[""] = (0, 0, 0);
  level.zdraw.colors[""] = (1, 1, 1);
  level.zdraw.colors[""] = vectorscale((1, 1, 1), 0.75);
  level.zdraw.colors[""] = vectorscale((1, 1, 1), 0.1);
  level.zdraw.colors[""] = vectorscale((1, 1, 1), 0.2);
  level.zdraw.colors[""] = vectorscale((1, 1, 1), 0.3);
  level.zdraw.colors[""] = vectorscale((1, 1, 1), 0.4);
  level.zdraw.colors[""] = vectorscale((1, 1, 1), 0.5);
  level.zdraw.colors[""] = vectorscale((1, 1, 1), 0.6);
  level.zdraw.colors[""] = vectorscale((1, 1, 1), 0.7);
  level.zdraw.colors[""] = vectorscale((1, 1, 1), 0.8);
  level.zdraw.colors[""] = vectorscale((1, 1, 1), 0.9);
  level.zdraw.colors[""] = (0.4392157, 0.5019608, 0.5647059);
  level.zdraw.colors[""] = (1, 0.7529412, 0.7960784);
  level.zdraw.colors[""] = vectorscale((1, 1, 0), 0.5019608);
  level.zdraw.colors[""] = (0.5450981, 0.2705882, 0.07450981);
  level.zdraw.colors[""] = (1, 1, 1);
}

function function_aa8545fe() {
  level.zdraw.commands = [];
  level.zdraw.commands[""] = &function_5ef6cf9b;
  level.zdraw.commands[""] = &function_eae4114a;
  level.zdraw.commands[""] = &function_f2f3c18e;
  level.zdraw.commands[""] = &function_8f04ad79;
  level.zdraw.commands[""] = &function_a13efe1c;
  level.zdraw.commands[""] = &function_b3b92edc;
  level.zdraw.commands[""] = &function_8c2ca616;
  level.zdraw.commands[""] = &function_3145e33f;
  level.zdraw.commands[""] = &function_f36ec3d2;
  level.zdraw.commands[""] = &function_7bdd3089;
  level.zdraw.commands[""] = &function_be7cf134;
}

function function_404ac348() {
  level.zdraw.color = level.zdraw.colors[""];
  level.zdraw.alpha = 1;
  level.zdraw.scale = 1;
  level.zdraw.duration = int(1 * 62.5);
  level.zdraw.radius = 8;
  level.zdraw.sides = 10;
  level.zdraw.var_5f3c7817 = (0, 0, 0);
  level.zdraw.var_922ae5d = 0;
  level.zdraw.var_c1953771 = "";
}

function function_41fec76e() {
  level notify("hash_15f14510");
  level endon("hash_15f14510");
  for(;;) {
    cmd = getdvarstring("");
    if(cmd.size) {
      function_404ac348();
      params = strtok(cmd, "");
      function_4282fd75(params, 0, 1);
      setDvar("", "");
    }
    wait(0.5);
  }
}

function function_4282fd75(var_859cfb21, startat, var_37cd5424) {
  if(!isDefined(var_37cd5424)) {
    var_37cd5424 = 0;
  }
  while(isDefined(var_859cfb21[startat])) {
    if(isDefined(level.zdraw.commands[var_859cfb21[startat]])) {
      startat = [[level.zdraw.commands[var_859cfb21[startat]]]](var_859cfb21, startat + 1);
    } else {
      if(isDefined(var_37cd5424) && var_37cd5424) {
        function_c69caf7e("" + var_859cfb21[startat]);
      }
      return startat;
    }
  }
  return startat;
}

function function_7bdd3089(var_859cfb21, startat) {
  while(isDefined(var_859cfb21[startat])) {
    if(function_c0fb9425(var_859cfb21[startat])) {
      var_b78d9698 = function_36371547(var_859cfb21, startat);
      if(var_b78d9698 > startat) {
        startat = var_b78d9698;
        center = level.zdraw.var_5f3c7817;
        sphere(center, level.zdraw.radius, level.zdraw.color, level.zdraw.alpha, 1, level.zdraw.sides, level.zdraw.duration);
        level.zdraw.var_5f3c7817 = (0, 0, 0);
      }
    } else {
      var_b78d9698 = function_4282fd75(var_859cfb21, startat);
      if(var_b78d9698 > startat) {
        startat = var_b78d9698;
      } else {
        return startat;
      }
    }
  }
  return startat;
}

function function_f36ec3d2(var_859cfb21, startat) {
  while(isDefined(var_859cfb21[startat])) {
    if(function_c0fb9425(var_859cfb21[startat])) {
      var_b78d9698 = function_36371547(var_859cfb21, startat);
      if(var_b78d9698 > startat) {
        startat = var_b78d9698;
        center = level.zdraw.var_5f3c7817;
        debugstar(center, level.zdraw.duration, level.zdraw.color);
        level.zdraw.var_5f3c7817 = (0, 0, 0);
      }
    } else {
      var_b78d9698 = function_4282fd75(var_859cfb21, startat);
      if(var_b78d9698 > startat) {
        startat = var_b78d9698;
      } else {
        return startat;
      }
    }
  }
  return startat;
}

function function_be7cf134(var_859cfb21, startat) {
  level.zdraw.linestart = undefined;
  while(isDefined(var_859cfb21[startat])) {
    if(function_c0fb9425(var_859cfb21[startat])) {
      var_b78d9698 = function_36371547(var_859cfb21, startat);
      if(var_b78d9698 > startat) {
        startat = var_b78d9698;
        lineend = level.zdraw.var_5f3c7817;
        if(isDefined(level.zdraw.linestart)) {
          line(level.zdraw.linestart, lineend, level.zdraw.color, level.zdraw.alpha, 1, level.zdraw.duration);
        }
        level.zdraw.linestart = lineend;
        level.zdraw.var_5f3c7817 = (0, 0, 0);
      }
    } else {
      var_b78d9698 = function_4282fd75(var_859cfb21, startat);
      if(var_b78d9698 > startat) {
        startat = var_b78d9698;
      } else {
        return startat;
      }
    }
  }
  return startat;
}

function function_3145e33f(var_859cfb21, startat) {
  level.zdraw.text = "";
  if(isDefined(var_859cfb21[startat])) {
    var_b78d9698 = function_ce50bae5(var_859cfb21, startat);
    if(var_b78d9698 > startat) {
      startat = var_b78d9698;
      level.zdraw.text = level.zdraw.var_c1953771;
      level.zdraw.var_c1953771 = "";
    }
  }
  while(isDefined(var_859cfb21[startat])) {
    if(function_c0fb9425(var_859cfb21[startat])) {
      var_b78d9698 = function_36371547(var_859cfb21, startat);
      if(var_b78d9698 > startat) {
        startat = var_b78d9698;
        center = level.zdraw.var_5f3c7817;
        print3d(center, level.zdraw.text, level.zdraw.color, level.zdraw.alpha, level.zdraw.scale, level.zdraw.duration);
        level.zdraw.var_5f3c7817 = (0, 0, 0);
      }
    } else {
      var_b78d9698 = function_4282fd75(var_859cfb21, startat);
      if(var_b78d9698 > startat) {
        startat = var_b78d9698;
      } else {
        return startat;
      }
    }
  }
  return startat;
}

function function_5ef6cf9b(var_859cfb21, startat) {
  if(isDefined(var_859cfb21[startat])) {
    if(function_c0fb9425(var_859cfb21[startat])) {
      var_b78d9698 = function_36371547(var_859cfb21, startat);
      if(var_b78d9698 > startat) {
        startat = var_b78d9698;
        level.zdraw.color = level.zdraw.var_5f3c7817;
        level.zdraw.var_5f3c7817 = (0, 0, 0);
      } else {
        level.zdraw.color = (1, 1, 1);
      }
    } else {
      if(isDefined(level.zdraw.colors[var_859cfb21[startat]])) {
        level.zdraw.color = level.zdraw.colors[var_859cfb21[startat]];
      } else {
        level.zdraw.color = (1, 1, 1);
        function_c69caf7e("" + var_859cfb21[startat]);
      }
      startat = startat + 1;
    }
  }
  return startat;
}

function function_eae4114a(var_859cfb21, startat) {
  if(isDefined(var_859cfb21[startat])) {
    var_b78d9698 = function_33acda19(var_859cfb21, startat);
    if(var_b78d9698 > startat) {
      startat = var_b78d9698;
      level.zdraw.alpha = level.zdraw.var_922ae5d;
      level.zdraw.var_922ae5d = 0;
    } else {
      level.zdraw.alpha = 1;
    }
  }
  return startat;
}

function function_a13efe1c(var_859cfb21, startat) {
  if(isDefined(var_859cfb21[startat])) {
    var_b78d9698 = function_33acda19(var_859cfb21, startat);
    if(var_b78d9698 > startat) {
      startat = var_b78d9698;
      level.zdraw.scale = level.zdraw.var_922ae5d;
      level.zdraw.var_922ae5d = 0;
    } else {
      level.zdraw.scale = 1;
    }
  }
  return startat;
}

function function_f2f3c18e(var_859cfb21, startat) {
  if(isDefined(var_859cfb21[startat])) {
    var_b78d9698 = function_33acda19(var_859cfb21, startat);
    if(var_b78d9698 > startat) {
      startat = var_b78d9698;
      level.zdraw.duration = int(level.zdraw.var_922ae5d);
      level.zdraw.var_922ae5d = 0;
    } else {
      level.zdraw.duration = int(1 * 62.5);
    }
  }
  return startat;
}

function function_8f04ad79(var_859cfb21, startat) {
  if(isDefined(var_859cfb21[startat])) {
    var_b78d9698 = function_33acda19(var_859cfb21, startat);
    if(var_b78d9698 > startat) {
      startat = var_b78d9698;
      level.zdraw.duration = int(62.5 * level.zdraw.var_922ae5d);
      level.zdraw.var_922ae5d = 0;
    } else {
      level.zdraw.duration = int(1 * 62.5);
    }
  }
  return startat;
}

function function_b3b92edc(var_859cfb21, startat) {
  if(isDefined(var_859cfb21[startat])) {
    var_b78d9698 = function_33acda19(var_859cfb21, startat);
    if(var_b78d9698 > startat) {
      startat = var_b78d9698;
      level.zdraw.radius = level.zdraw.var_922ae5d;
      level.zdraw.var_922ae5d = 0;
    } else {
      level.zdraw.radius = 8;
    }
  }
  return startat;
}

function function_8c2ca616(var_859cfb21, startat) {
  if(isDefined(var_859cfb21[startat])) {
    var_b78d9698 = function_33acda19(var_859cfb21, startat);
    if(var_b78d9698 > startat) {
      startat = var_b78d9698;
      level.zdraw.sides = int(level.zdraw.var_922ae5d);
      level.zdraw.var_922ae5d = 0;
    } else {
      level.zdraw.sides = 10;
    }
  }
  return startat;
}

function function_c0fb9425(param) {
  if(isDefined(param) && (isint(param) || isfloat(param) || (isstring(param) && strisnumber(param)))) {
    return true;
  }
  return false;
}

function function_36371547(var_859cfb21, startat) {
  if(isDefined(var_859cfb21[startat])) {
    var_b78d9698 = function_33acda19(var_859cfb21, startat);
    if(var_b78d9698 > startat) {
      startat = var_b78d9698;
      level.zdraw.var_5f3c7817 = (level.zdraw.var_922ae5d, level.zdraw.var_5f3c7817[1], level.zdraw.var_5f3c7817[2]);
      level.zdraw.var_922ae5d = 0;
    } else {
      function_c69caf7e("");
      return startat;
    }
    var_b78d9698 = function_33acda19(var_859cfb21, startat);
    if(var_b78d9698 > startat) {
      startat = var_b78d9698;
      level.zdraw.var_5f3c7817 = (level.zdraw.var_5f3c7817[0], level.zdraw.var_922ae5d, level.zdraw.var_5f3c7817[2]);
      level.zdraw.var_922ae5d = 0;
    } else {
      function_c69caf7e("");
      return startat;
    }
    var_b78d9698 = function_33acda19(var_859cfb21, startat);
    if(var_b78d9698 > startat) {
      startat = var_b78d9698;
      level.zdraw.var_5f3c7817 = (level.zdraw.var_5f3c7817[0], level.zdraw.var_5f3c7817[1], level.zdraw.var_922ae5d);
      level.zdraw.var_922ae5d = 0;
    } else {
      function_c69caf7e("");
      return startat;
    }
  }
  return startat;
}

function function_33acda19(var_859cfb21, startat) {
  if(isDefined(var_859cfb21[startat])) {
    if(function_c0fb9425(var_859cfb21[startat])) {
      level.zdraw.var_922ae5d = float(var_859cfb21[startat]);
      startat = startat + 1;
    }
  }
  return startat;
}

function function_ce50bae5(var_859cfb21, startat) {
  if(isDefined(var_859cfb21[startat])) {
    level.zdraw.var_c1953771 = var_859cfb21[startat];
    startat = startat + 1;
  }
  return startat;
}

function function_c69caf7e(msg) {
  println("" + msg);
}