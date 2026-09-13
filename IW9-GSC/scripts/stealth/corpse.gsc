/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\corpse.gsc
***********************************************/

corpse_init_entity() {
  self.stealth.corpse = spawnStruct();
}

corpse_init_level() {
  if(isDefined(level.stealth) && isDefined(level.stealth.corpse)) {
    return;
  }
  level.stealth.corpse = spawnStruct();
  level.stealth.corpse.reset_time = 30;
  level scripts\stealth\utility::set_stealth_func("saw_corpse", ::corpse_seen);
  level scripts\stealth\utility::set_stealth_func("found_corpse", ::corpse_found);
  set_corpse_ranges_default();
}

set_corpse_ranges_default() {
  array["sight_dist"] = 600;
  array["detect_dist"] = 300;
  array["found_dist"] = 100;
  set_corpse_ranges(array);
}

set_corpse_ranges(array) {
  if(!isDefined(array["shadow_dist"]))
    array["shadow_dist"] = array["found_dist"];

  _func_76B92DB94020C5CE(array);
}

set_corpse_ignore() {
  _func_AA940A5B82D4D6A3(self, 1);
}

corpse_check_shadow(origin) {
  if(!isDefined(self.in_shadow_origin) || distancesquared(self.in_shadow_origin, origin) > 1.0) {
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

corpse_found(event) {
  self notify("corpse_found");
  self endon("corpse_found");
  self endon("death");

  if(isDefined(level.battlechatter))
    thread _id_50EEB9595C6D6E1B::_id_4DFFA550C687B071();

  corpse = event.entity;
  _id_A4F5FB62BA3A113B = getcorpseorigin(corpse);

  if(isDefined(self._id_2836AFE73A94B60B) && self._id_2836AFE73A94B60B != corpse)
    _func_BC97202BA2DB4CF4(self._id_2836AFE73A94B60B, 0);

  self._id_2836AFE73A94B60B = corpse;

  if(!isDefined(self._id_A9ABD657131AF071) || self._id_A9ABD657131AF071 == "small")
    self.bexaminerequested = 1;

  if(isDefined(level.fnsetcorpseremovetimerfunc))
    corpse[[level.fnsetcorpseremovetimerfunc]](level.stealth.corpse.reset_time);
}

corpse_seen(event) {
  if(isDefined(level.battlechatter))
    thread _id_50EEB9595C6D6E1B::_id_E906749F6343F822();

  corpse = event.entity;
  _id_A4F5FB62BA3A113B = getcorpseorigin(corpse);
  self.stealth.corpse.origin = _id_A4F5FB62BA3A113B;

  if(!isDefined(self._id_A9ABD657131AF071) || self._id_A9ABD657131AF071 == "small")
    self.bexaminerequested = 1;

  self notify("corpse_seen_claim");

  if(isDefined(self._id_2836AFE73A94B60B) && self._id_2836AFE73A94B60B != corpse)
    _func_BC97202BA2DB4CF4(self._id_2836AFE73A94B60B, 0);

  _func_BC97202BA2DB4CF4(corpse, 1);
  self._id_2836AFE73A94B60B = corpse;
}