/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4a247ed69e84b56f.gsc
***********************************************/

#using script_17dcb1172e441bf6;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_47851dbeea22fe66;
#using script_634ae70c663d1cc9;
#using script_774302f762d76254;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_538252ab;

function init() {}

function main() {
  level.doa.var_ed906439 = [];
}

function function_49caf2d6() {
  self notify("5911fdf5a238fc16");
  self endon("5911fdf5a238fc16");
  self thread namespace_268747c0::function_978c05b5();
  result = self waittill(#"destroy_hazard");

  if(is_true(self.var_7c56394) && is_true(result.var_760a0807)) {
    arrayremovevalue(level.doa.var_ed906439, self);
    namespace_1e25ad94::debugmsg("Deleting killzone trap permenently at:" + self.origin);
  }

  util::wait_network_frame();

  if(isDefined(self.trigger)) {
    self.trigger namespace_268747c0::function_54f185a();
    self.trigger = undefined;
  }

  if(isDefined(self.script_model)) {
    self.script_model delete();
  }
}

function function_4acf40a(trap, var_7c56394 = 0, modelname) {
  if(isDefined(modelname)) {
    hazard = namespace_ec06fe4a::spawnmodel(trap.origin, modelname);

    if(isDefined(hazard)) {
      hazard.targetname = "hazard";
      hazard.var_fd5301f9 = "killzone";
      hazard.angles = trap.angles;
      hazard enablelinkto();
    }

    trap.script_model = hazard;
  }

  trap.var_7c56394 = var_7c56394;
  trap thread function_e20d74b3();
  return trap;
}

function function_7ae8d74a(trap, page = 0) {
  if(!is_true(trap.initialized)) {
    assert(isDefined(trap.script_parameters), "<dev string:x38>");
    args = strtok(trap.script_parameters, ";");
    assert(args.size >= 4, "<dev string:x5d>");
    trap.type = hash(args[0]);
    trap.radius = int(args[1]);
    trap.height = int(args[2]);
    trap.teleport = 1;
    trap.damage = 50;
    trap.var_f3e30707 = 1;

    if(args.size > 3) {
      trap.teleport = int(args[3]);
    }

    if(args.size > 4) {
      trap.damage = int(args[4]);
    }

    if(args.size > 5) {
      trap.var_f3e30707 = int(args[5]);
    }

    if(trap.type === # "acid") {
      trap.var_2e485cc = getstatuseffect(#"hash_69c2a47bf2322b6b");
    }

    if(trap.type === # "fire") {
      trap.var_2e485cc = getstatuseffect(#"hash_69374f563cb01313");
    }

    trap.initialized = 1;
  }

  if(page) {
    if(!isDefined(level.doa.var_ed906439)) {
      level.doa.var_ed906439 = [];
    } else if(!isarray(level.doa.var_ed906439)) {
      level.doa.var_ed906439 = array(level.doa.var_ed906439);
    }

    level.doa.var_ed906439[level.doa.var_ed906439.size] = trap;
    return;
  }

  function_4acf40a(trap);
}

function function_d4a86caf() {
  self notify("6ec0a773d4131741");
  self endon("6ec0a773d4131741");
  level endon(#"game_over");

  while(true) {
    wait 0.5;

    foreach(trap in level.doa.var_ed906439) {
      time = gettime();

      if(isDefined(trap.var_eb9d64bb) && time < trap.var_eb9d64bb) {
        continue;
      }

      trap.var_eb9d64bb = time + 2000 + randomint(600);

      if(!is_true(trap.active)) {
        activate = 0;

        if(isDefined(trap.var_f8660931)) {
          distsq = distancesquared(trap.origin, trap.var_f8660931.origin);

          if(distsq < sqr(3200)) {
            activate = 1;
          }
        }

        if(!activate) {
          trap.var_f8660931 = namespace_ec06fe4a::function_6eacecf5(trap.origin, 3200);

          if(isDefined(trap.var_f8660931)) {
            activate = 1;
          } else {
            trap.var_f8660931 = namespace_ec06fe4a::function_bd3709ce(trap.origin, 1200);

            if(isDefined(trap.var_f8660931)) {
              activate = 1;
            }
          }
        }

        if(activate) {
          function_4acf40a(trap, 1);
          trap.var_eb9d64bb += 5000;
          namespace_1e25ad94::debugmsg("Paging IN killzone trap at:" + trap.origin);
        }

        continue;
      }

      trap.var_f8660931 = namespace_ec06fe4a::function_f3eab80e(trap.origin, 3600);

      if(!isDefined(trap.var_f8660931)) {
        trap notify(#"destroy_hazard", {
          #var_760a0807: 0
        });
        namespace_1e25ad94::debugmsg("Paging out killzone trap at:" + trap.origin);
      }
    }
  }
}

function function_90e65586() {
  level.doa.var_ed906439 = [];
  level thread function_d4a86caf();

  if(isDefined(level.doa.var_a77e6349)) {
    traps = [[level.doa.var_a77e6349]] - > function_87f950c1("killzone");
    page = 1;
    arena = 0;
  } else {
    traps = [[level.doa.var_39e3fa99]] - > function_242886d5("killzone");
    arena = 1;
  }

  foreach(trap in traps) {
    function_7ae8d74a(trap, page);
    trap.arena = arena;
  }
}

function function_e20d74b3() {
  self notify("749b46a4633ab082");
  self endon("749b46a4633ab082");
  level endon(#"game_over");
  self endon(#"destroy_hazard");
  self thread function_49caf2d6();
  wait randomfloatrange(0.1, 3);

  while(true) {
    self.trigger = self namespace_268747c0::function_678eaf60("killzone", self.origin, 1024, 1, 256);

    if(self.trigger.radius != self.radius || self.trigger.height != self.height) {
      self.trigger delete();
      namespace_268747c0::function_e8bbd3ad("killzone");
      self.trigger = namespace_268747c0::function_3111b4b2("killzone", "trigger_radius", self.radius, self.height);

      if(isDefined(self.trigger)) {
        self.trigger namespace_268747c0::function_b3c196a(self, self.origin, self.angles);
      }
    }

    self.trigger thread function_d1b295d7(self);
    wait 1;

    if(isDefined(self.trigger)) {
      self.trigger triggerenable(1);

      while(isDefined(self.trigger)) {
        wait 0.25;
      }
    }
  }
}

function function_d1b295d7(trap) {
  self notify("1e24548a9aeb5437");
  self endon("1e24548a9aeb5437");
  level endon(#"game_over");
  self endon(#"death", #"destroy_hazard", #"hash_5dc5b7f198cd1bec");
  var_f3e30707 = (isDefined(trap.var_f3e30707) ? trap.var_f3e30707 : 1) * 1000;

  while(true) {
    result = self waittill(#"trigger");
    guy = result.activator;

    if(!isDefined(guy)) {
      continue;
    }

    if(is_true(guy.var_47267079) || is_true(guy.boss)) {
      continue;
    }

    if(is_true(guy.laststand)) {
      continue;
    }

    if(!isalive(guy)) {
      continue;
    }

    if(!isDefined(guy.var_386ce6f4)) {
      guy.var_386ce6f4 = 0;
    }

    time = gettime();

    if(guy.var_386ce6f4 > gettime()) {
      continue;
    }

    guy.var_386ce6f4 = time + var_f3e30707;

    if(isPlayer(guy)) {
      guy dodamage(isDefined(trap.damage) ? trap.damage : guy.health + 100, guy.origin);
      guy playrumbleonentity("damage_light");

      if(isDefined(trap.var_2e485cc) && guy.birthtime != gettime()) {
        guy thread status_effect::status_effect_apply(trap.var_2e485cc, guy.currentweapon, self, 1);
      }
    } else {
      if(!isDefined(guy.var_a1500eee)) {
        guy.var_a1500eee = 0;
      }

      if(guy.var_a1500eee < gettime()) {
        if(trap.type === # "fire") {
          guy namespace_83eb6304::function_3ecfde67("burn_zombie");
        }

        guy.var_a1500eee = gettime() + 1000;
      }

      if(trap.type === # "fire") {
        guy thread namespace_ec06fe4a::function_570729f0(randomfloatrange(0.5, 2.2));
      } else {
        guy thread namespace_ec06fe4a::function_570729f0(0.1);
      }
    }

    level notify(#"hash_50b5d49dd2306ca6", {
      #guy: guy
    });

    if(isPlayer(guy) && is_true(trap.arena) && is_true(trap.teleport)) {
      spot = [[level.doa.var_39e3fa99]] - > function_70fb5745();
      guy setorigin(spot.origin);
    }
  }
}