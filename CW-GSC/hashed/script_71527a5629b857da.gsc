/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_71527a5629b857da.gsc
***********************************************/

#using script_1162c195eb8dd834;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\smart_bundle;
#namespace smart_bundle;

function function_4e82b483() {
  while(true) {
    level waittill(#"hash_5e64e62033b849ba");

    while(level.smart_bundle.var_78371b11 < level.smart_bundle.spawnq.size) {
      waittillframeend();

      if(isDefined(level.smart_bundle.spawn_wait)) {
        wait level.smart_bundle.spawn_wait;
        level.smart_bundle.spawn_wait = undefined;
      }

      if(!(level.smart_bundle.spawnq[level.smart_bundle.var_78371b11].var_9785b19e.var_39a8d200 == "active" || level.smart_bundle.spawnq[level.smart_bundle.var_78371b11].var_9785b19e.var_39a8d200 == "wait_deactivate")) {
        level.smart_bundle.var_78371b11++;
        continue;
      }

      spawner = level.smart_bundle.spawnq[level.smart_bundle.var_78371b11];

      if(spawner.classname == "script_vehicle") {
        ai = spawner spawner::spawn(1);

        if(isDefined(ai) && isDefined(spawner.target)) {
          ai thread vehicle::go_path();
        }

        spawner.var_9785b19e thread function_cf2b1b9b(ai);
      } else {
        if(isDefined(spawner.script_suspend) && isDefined(spawner.suspended_ai)) {
          spawner prespawn_suspended_ai();
        }

        ai = spawner spawner::spawn(1);
      }

      spawner.var_9785b19e thread function_c0ea60b9(spawner, ai);
      level.smart_bundle.var_78371b11++;
      waitframe(1);
    }

    level.smart_bundle.spawnq = [];
    level.smart_bundle.var_78371b11 = 0;
    level notify(#"hash_383aa92c3a20edcd");
  }
}

function function_cf2b1b9b(vehicle) {
  vehicle endon(#"death");
  waitframe(4);

  if(isDefined(vehicle.var_761c973.riders) && vehicle.var_761c973.riders.size > 0) {
    if(!isDefined(self.var_60efc9d0)) {
      self.var_60efc9d0 = [];
    }

    self.var_60efc9d0 = arraycombine(self.var_60efc9d0, vehicle.var_761c973.riders, 1, 0);
  }
}

function function_8760a4bd(spawner) {
  if(level.smart_bundle.spawnq.size > 64) {
    level waittill(#"hash_383aa92c3a20edcd");
    waitframe(2);
  }

  level.smart_bundle.spawnq[level.smart_bundle.spawnq.size] = spawner;
  level notify(#"hash_5e64e62033b849ba");
}

function function_bc78de5d() {
  self.var_f0a4c650 = [];
  self.var_fe336ab9 = 0;
  a_ai = [];

  foreach(spawner in self.spawner_ents) {
    self function_4f5c58a1(spawner);
    self function_214a640(spawner);
    ai = spawner spawner::spawn(1);

    if(isDefined(ai)) {
      a_ai[a_ai.size] = ai;
    }

    spawner.var_9785b19e thread function_c0ea60b9(spawner, ai);
  }

  scene::play(self.scene_name, a_ai);
}

function function_30e5290f() {
  self.var_f0a4c650 = [];
  self.var_fe336ab9 = 0;

  if(self.spawner_ents.size == 0 || !is_true(self.var_2b96e535)) {
    return;
  }

  for(i = 0; i < self.spawner_ents.size; i++) {
    self thread function_4783d4fa(self.spawner_ents[i]);
  }

  self thread function_f029622c();
}

function function_4f5c58a1(spawner) {
  spawner.script_suspend = 1;

  if(isDefined(self.script_suspend_group)) {
    spawner.script_suspend_group = self.script_suspend_group;
  }

  spawner.count = 99;
  spawner.suspended_ai = undefined;
}

function function_4783d4fa(spawner) {
  if(!isDefined(spawner)) {
    if(isDefined(self.targetname)) {
      println("<dev string:x38>" + self.targetname + "<dev string:x43>");
    }

    return;
  }

  self endon(#"hash_740faf03c1eeca5b");
  function_4f5c58a1(spawner);
  self function_214a640(spawner);
  spawner function_9a0ffb73();
  function_8760a4bd(spawner);
}

function function_214a640(spawner) {
  spawner.var_9785b19e = self;
  spawner.stub_index = self.var_f0a4c650.size;
  self.var_f0a4c650[self.var_f0a4c650.size] = spawner;
}

function function_fe336ab9(spawner) {
  assert(spawner.stub_index < self.var_f0a4c650.size);
  assert(self.var_fe336ab9 < self.var_f0a4c650.size);
  assert(self.var_f0a4c650[spawner.stub_index] != self);
  self.var_f0a4c650[spawner.stub_index] = self;
  self.var_fe336ab9++;
  self notify(#"hash_7fafbdd20ef09362");
}

function function_2264f2c4() {
  self.despawned = 1;
}

function function_c0ea60b9(spawner, ai) {
  self endon(#"hash_740faf03c1eeca5b");

  if(!isDefined(ai)) {
    function_fe336ab9(spawner);
    return;
  }

  self.dynamic_ents[self.dynamic_ents.size] = ai;
  self notify(#"hash_544b598ad6fe9445");
  ai.var_9785b19e = self;
  ai.spawner = spawner;
  spawner.var_de1cdf28 = ai;

  if(isDefined(spawner.script_suspend) && isDefined(spawner.suspended_ai)) {
    ai thread postspawn_suspended_ai();
  }

  ret = ai waittill(#"death", #"pain_death", #"smart_bundle_suspended_ai");

  if(ret._notify != "smart_bundle_suspended_ai") {
    if(!is_true(ai.despawned)) {
      function_fe336ab9(spawner);
      return;
    }

    ai function_2c2c15de(spawner);

    if(isDefined(spawner.script_suspend_group)) {
      level.smart_bundle.spawn_wait = 0.5;
      self util::delay(0.05, undefined, &function_764d4b74);

      if(isDefined(self.targetname)) {
        iprintln(self.targetname + "<dev string:x68>");
      }

      self notify(#"despawn");
      return;
    }
  }

  if(isDefined(self.var_38a97b32)) {
    wait 2;

    while(true) {
      level waittill(self.var_38a97b32);

      if(level flag::get(self.var_38a97b32)) {
        function_8760a4bd(spawner);
        return;
      }
    }
  }

  name = "<dev string:x98>";

  if(isDefined(spawner.targetname)) {
    name = spawner.targetname;
  }

  iprintln("<dev string:xa5>" + name + "<dev string:xbd>" + spawner.origin);
}

function function_2c2c15de(spawner) {
  if(!isDefined(self.spawner) || !isDefined(self.script_suspend)) {
    return;
  }

  spawner = self.spawner;
  struct = spawnStruct();
  struct.origin = self.origin;
  struct.angles = self.angles;
  struct.suspendtime = gettime();

  if(isDefined(self.suspendvars)) {
    struct.suspendvars = self.suspendvars;
  } else {
    struct.suspendvars = spawnStruct();
  }

  if(isDefined(self.stealth)) {
    struct.stealth = spawnStruct();
    struct.stealth.bsmstate = self.stealth.bsmstate;
    struct.stealth.investigateevent = self.stealth.investigateevent;
  }

  if(isDefined(self.node)) {
    if(isDefined(self.using_goto_node)) {
      if(isDefined(self.node.targetname)) {
        struct.target = self.node.targetname;
      }

      struct.node = self.node;
    }

    struct.target = self.node.targetname;
  }

  spawner.suspended_ai = struct;
  spawner.postspawnresetorigin = 1;
}

function prespawn_suspended_ai() {
  if(!isDefined(self.script_suspend)) {
    return undefined;
  }

  if(!isDefined(self.suspended_ai)) {
    return 0;
  }

  self.count++;

  if(!isDefined(self.og_spawner_origin)) {
    self.og_spawner_origin = self.origin;
  }

  if(!isDefined(self.og_spawner_angles)) {
    self.og_spawner_angles = self.angles;
  }

  if(isDefined(self.try_og_origin)) {
    self.origin = self.og_spawner_origin;
    self.angles = self.og_spawner_angles;
  } else {
    self.origin = self.suspended_ai.origin;
    self.angles = self.suspended_ai.angles;
  }

  if(isDefined(self.suspended_ai.suspendvars)) {
    self.suspendvars = self.suspended_ai.suspendvars;
  }

  return 1;
}

function postspawn_suspended_ai() {
  suspendstruct = self.spawner.suspended_ai;

  if(isDefined(self.spawner.postspawnresetorigin)) {
    self.spawner.origin = self.og_spawner_origin;
    self.spawner.angles = self.og_spawner_angles;
  }

  self thread postspawn_suspend_ai_framedelay(suspendstruct);

  if(!isDefined(suspendstruct.suspendvars)) {
    return;
  }

  self.suspendvars = suspendstruct.suspendvars;
  self.spawner.suspended_ai = undefined;
}

function postspawn_suspend_ai_framedelay(suspendstruct) {
  waittillframeend();
  waittillframeend();

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(suspendstruct.stealth)) {
    assert(self.team == "<dev string:xf6>", "<dev string:xfe>");
  }
}