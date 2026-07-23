/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1376.gsc
**************************************/

_id_4281() {
  _id_425C();
  var_0 = self._id_0B6E._id_41D0._id_41D1["state"]["hidden"];
  thread maps\_stealth_shared_utilities::_id_41CE(var_0, "enemy_behavior");
  var_0 = self._id_0B6E._id_41D0._id_41D1["state"]["spotted"];
  thread maps\_stealth_shared_utilities::_id_41CB(var_0, "enemy_behavior");
  thread _id_4282();
}

_id_4282() {
  self endon("death");
  self endon("pain_death");
  self endon("damage");

  for(;;) {
    self waittill("event_awareness", var_0);

    if(!maps\_utility::_id_1008("_stealth_enabled")) {
      continue;
    }
    var_1 = self._id_0B6E._id_41D0._id_41D1["animation"]["wrapper"];
    self thread[[var_1]](var_0);
  }
}

_id_4283() {
  self.fovcosine = 0.5;
  self.fovcosinebusy = 0.1;
  self.favoriteenemy = undefined;
  self._id_0FA0 = 1;
  self._id_0F9F = 1;
  thread maps\_utility::_id_0D72(0);

  if(self.type == "dog") {
    return;
  }
  self.diequietly = 1;
  self clearenemy();
}

_id_4284(var_0) {
  self.fovcosine = 0.01;
  self.ignoreall = 0;
  self._id_0FA0 = undefined;
  self._id_0F9F = undefined;

  if(isDefined(self._id_4285)) {
    self.fixednode = self._id_4285;
  }
  thread maps\_utility::_id_0D72(1);

  if(self.type != "dog") {
    self.diequietly = 0;

    if(!isDefined(var_0)) {
      maps\_utility::_id_140C();
      maps\_stealth_shared_utilities::_id_41EF();
    }
  } else {
    self._id_23DB = undefined;
    self._id_206F = undefined;
  }

  if(isDefined(var_0)) {
    return;
  }
  if(isDefined(level._id_0B6E._id_1124._id_426E)) {
    var_1 = level._id_0B6E._id_1124._id_426E[self._id_204F];

    if(isDefined(var_1)) {
      self getenemyinfo(var_1);
    }
  }
}

_id_425C() {
  maps\_utility::_id_1402("_stealth_override_goalpos");
  maps\_utility::_id_1402("_stealth_enemy_alert_level_action");
  maps\_utility::_id_1402("_stealth_running_to_corpse");
  maps\_utility::_id_1402("_stealth_behavior_reaction_anim");
  maps\_utility::_id_1402("_stealth_behavior_first_reaction");
  maps\_utility::_id_1402("_stealth_behavior_reaction_anim_in_progress");
  self._id_0B6E._id_41D0 = spawnStruct();
  self.a._id_1018 = 1;
  self._id_0B6E._id_41D0._id_41D1 = [];
  _id_4288();
  _id_4289();
  self._id_0B6E._id_41D0._id_0EFE = spawnStruct();

  if(self.type == "dog") {
    _id_4286();
  }
  self._id_0B6E._id_423A = spawnStruct();
  thread maps\_stealth_shared_utilities::_id_41E3();
}

_id_4286() {
  if(threatbiasgroupexists("dog")) {
    self setthreatbiasgroup("dog");
  }
  if(isDefined(self.enemy) || isDefined(self.favoriteenemy)) {
    return;
  }
  maps\_utility::_id_1402("_stealth_behavior_asleep");

  if(isDefined(self._id_2075) || isDefined(self._id_2050)) {
    return;
  }
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.allowdeath = 1;
  thread maps\_anim::_id_11CD(self, "gravity", "_stealth_dog_sleeping");
  maps\_utility::_id_13DC("_stealth_behavior_asleep");
}

_id_4287(var_0) {
  foreach(var_3, var_2 in var_0) {}
  maps\_stealth_shared_utilities::_id_41CF("state", var_3, var_2);

  var_4 = self._id_0B6E._id_41D0._id_41D1["state"]["hidden"];
  thread maps\_stealth_shared_utilities::_id_41CE(var_4, "enemy_behavior");
  var_4 = self._id_0B6E._id_41D0._id_41D1["state"]["spotted"];
  thread maps\_stealth_shared_utilities::_id_41CB(var_4, "enemy_behavior");
}

_id_4288() {
  var_0 = [];
  var_0["hidden"] = ::_id_4283;
  var_0["spotted"] = ::_id_4284;
  _id_4287(var_0);
}

_id_4289() {
  maps\_stealth_shared_utilities::_id_41CF("animation", "wrapper", maps\_stealth_shared_utilities::_id_4200);

  if(self.type == "dog") {
    maps\_stealth_shared_utilities::_id_41CF("animation", "grenade danger", _id_055B::_id_4242);
    maps\_stealth_shared_utilities::_id_41CF("animation", "bulletwhizby", _id_055B::_id_4242);
    maps\_stealth_shared_utilities::_id_41CF("animation", "gunshot_teammate", _id_055B::_id_4242);
    maps\_stealth_shared_utilities::_id_41CF("animation", "projectile_impact", _id_055B::_id_4243);
  } else {
    maps\_stealth_shared_utilities::_id_41CF("animation", "grenade danger", _id_055B::_id_423F);
    maps\_stealth_shared_utilities::_id_41CF("animation", "bulletwhizby", _id_055B::_id_423F);
    maps\_stealth_shared_utilities::_id_41CF("animation", "gunshot_teammate", _id_055B::_id_423F);
    maps\_stealth_shared_utilities::_id_41CF("animation", "projectile_impact", _id_055B::_id_423F);
  }
}