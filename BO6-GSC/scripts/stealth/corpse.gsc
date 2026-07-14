/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\stealth\corpse.gsc
**************************************/

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
  level utility::set_stealth_func("f\\\xb5P\xa8\xd1Y\xa5\xe5-", &corpse_seen);
  level utility::set_stealth_func("\x8e7@ucX\x91\xf2+\x1b\xa6\xbf", &corpse_found);
  set_corpse_ranges_default();
}

function set_corpse_ranges_default() {
  array["~\xb9e\xde\xb9\xe1\x0e\x88\b\x02"] = 600;
  array["\x02\xaa\v\x86\xc1\xd4\x18\xa1'B\xdd"] = 300;
  array["Zk\xab[\xafHa\xe8\x9eV"] = 100;
  set_corpse_ranges(array);
}

function set_corpse_ranges(array) {
  if(!isDefined(array["o .\xaf\xffzb\xa8\x14\x9an"])) {
    array["o .\xaf\xffzb\xa8\x14\x9an"] = array["Zk\xab[\xafHa\xe8\x9eV"];
  }

  function_b4a367499c391b0b(array);
}

function set_corpse_ignore() {
  assert(isent(self));
  function_e73ef77be17e0bda(self, 1);
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
  self notify("m\x85\xb8;\xeaPI\xcc`\";T");
  self endon("m\x85\xb8;\xeaPI\xcc`\";T");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(level.battlechatter)) {
    function_99e8e66d1969d7cb(self, undefined, "m\x85\xb8;\xeaPI\xcc`\";T");
  }

  corpse = event.entity;
  corpseorigin = getcorpseorigin(corpse);

  if(isDefined(self.var_5bb1fe7c95f5520e) && self.var_5bb1fe7c95f5520e != corpse) {
    function_571ac82071b4a5a9(self.var_5bb1fe7c95f5520e, 0);
  }

  self.var_5bb1fe7c95f5520e = corpse;

  if(!isDefined(self.var_869f9cbd5520033c) || self.var_869f9cbd5520033c == "\xf7\xc8\xa7\xe0\xc6") {
    self.bexaminerequested = 1;
  }

  corpse function_b1bf1171855d067a(level.stealth.corpse.reset_time);
}

function corpse_seen(event) {
  if(isDefined(level.battlechatter)) {
    function_99e8e66d1969d7cb(self, undefined, "#\xdc\xbf\xc3C\xd8\x97Fg\xb3|");
  }

  corpse = event.entity;
  corpseorigin = getcorpseorigin(corpse);
  self.stealth.corpse.origin = corpseorigin;

  if(!isDefined(self.var_869f9cbd5520033c) || self.var_869f9cbd5520033c == "\xf7\xc8\xa7\xe0\xc6") {
    self.bexaminerequested = 1;
  }

  self notify("\xd4\xdf\xadY\x1b\xbcQOc \xbb\x82{\xa2\xa9\xc3\xc7");

  if(isDefined(self.var_5bb1fe7c95f5520e) && self.var_5bb1fe7c95f5520e != corpse) {
    function_571ac82071b4a5a9(self.var_5bb1fe7c95f5520e, 0);
  }

  function_571ac82071b4a5a9(corpse, 1);
  self.var_5bb1fe7c95f5520e = corpse;
}