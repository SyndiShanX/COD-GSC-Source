/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\stealth\corpse.gsc
***********************************************/

#using scripts\asm\asm;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\stealth\debug;
#using scripts\stealth\utility;
#namespace corpse;

function corpse_init_entity() {
  assert(isDefined(self.stealth));
  self.stealth.corpse = spawnStruct();
}

function corpse_init_level() {
  if(isDefined(level.stealth) && isDefined(level.stealth.corpse)) {
    return;
  }

  level.stealth.corpse = spawnStruct();
  level.stealth.corpse.reset_time = 30;
  level scripts\stealth\utility::set_stealth_func("saw_corpse", &corpse_seen);
  level scripts\stealth\utility::set_stealth_func("found_corpse", &corpse_found);
  set_corpse_ranges_default();
}

function set_corpse_ranges_default() {
  array["sight_dist"] = 600;
  array["detect_dist"] = 300;
  array["found_dist"] = 100;
  set_corpse_ranges(array);
}

function set_corpse_ranges(array) {
  if(!isDefined(array["shadow_dist"])) {
    array["shadow_dist"] = array["found_dist"];
  }

  function_76b92db94020c5ce(array);
}

function set_corpse_ignore() {
  assert(isent(self));
  function_aa940a5b82d4d6a3(self, 1);
}

function corpse_check_shadow(origin) {
  if(!isDefined(self.in_shadow_origin) || distancesquared(self.in_shadow_origin, origin) > 1) {
    self.in_shadow = undefined;

    if(isDefined(level.trigger_stealth_shadow)) {
      foreach(trigger in level.trigger_stealth_shadow) {
        if(isDefined(trigger) && ispointinvolume(origin, trigger)) {
          self.in_shadow = 1;
          break;
        }
      }
    }

    self.in_shadow_origin = origin;
  }

  return istrue(self.in_shadow);
}

function corpse_found(event) {
  self notify("corpse_found");
  self endon("corpse_found");
  self endon("death");

  if(isDefined(level.battlechatter)) {
    addbattlechatternotify(self, undefined, "corpse_found");
  }

  corpse = event.entity;
  corpseorigin = getcorpseorigin(corpse);

  if(isDefined(self.var_2836afe73a94b60b) && self.var_2836afe73a94b60b != corpse) {
    function_bc97202ba2db4cf4(self.var_2836afe73a94b60b, 0);
  }

  self.var_2836afe73a94b60b = corpse;

  if(!isDefined(self.var_a9abd657131af071) || self.var_a9abd657131af071 == "small") {
    self.bexaminerequested = 1;
  }

  if(isDefined(level.fnsetcorpseremovetimerfunc)) {
    corpse[[level.fnsetcorpseremovetimerfunc]](level.stealth.corpse.reset_time);
  }
}

function corpse_seen(event) {
  if(isDefined(level.battlechatter)) {
    addbattlechatternotify(self, undefined, "corpse_seen");
  }

  corpse = event.entity;
  corpseorigin = getcorpseorigin(corpse);
  self.stealth.corpse.origin = corpseorigin;

  if(!isDefined(self.var_a9abd657131af071) || self.var_a9abd657131af071 == "small") {
    self.bexaminerequested = 1;
  }

  self notify("corpse_seen_claim");

  if(isDefined(self.var_2836afe73a94b60b) && self.var_2836afe73a94b60b != corpse) {
    function_bc97202ba2db4cf4(self.var_2836afe73a94b60b, 0);
  }

  function_bc97202ba2db4cf4(corpse, 1);
  self.var_2836afe73a94b60b = corpse;
}