/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1371.gsc
**************************************/

#using_animtree("generic_human");

_id_423D(var_0) {
  self clearanim( % root, var_0);
}

_id_423E(var_0) {
  var_1 = 600;

  if(isDefined(self.enemy)) {
    var_1 = distance(self.enemy.origin, self.origin);

  }
  if(var_1 < 512) {
    var_2 = "_stealth_behavior_spotted_short";
  } else {
    var_2 = "_stealth_behavior_spotted_long";

  }
  self.allowdeath = 1;
  thread maps\_anim::_id_11CC(self, "gravity", var_2);

  if(var_1 < 200) {
    wait 0.5;
  } else {
    common_scripts\utility::waittill_notify_or_timeout(var_2, randomfloatrange(1.5, 3));

  }
  self notify("stop_animmode");
}

_id_423F(var_0) {}

_id_4240(var_0) {
  self.allowdeath = 1;
  var_1 = level.player;

  if(isDefined(self.enemy)) {
    var_1 = self.enemy;
  } else if(isDefined(self.favoriteenemy)) {
    var_1 = self.favoriteenemy;

  }
  var_2 = distance(self.origin, var_1.origin);
  var_3 = 4;
  var_4 = 1024;

  for(var_5 = 1; var_5 < var_3; var_5++) {
    var_6 = var_4 * (var_5 / var_3);

    if(var_2 < var_6) {
      break;
    }
  }

  var_7 = "_stealth_behavior_generic" + var_5;
  maps\_anim::_id_11CC(self, "gravity", var_7);
}

_id_4241(var_0) {
  self.allowdeath = 1;
  var_1 = undefined;

  if(isDefined(self.meleeingplayer)) {
    var_2 = self.meleeingplayer;

    if(isDefined(var_2._id_1EC3) && isDefined(var_2._id_1EC3._id_3B47) && self == var_2._id_1EC3._id_3B47) {
      return;
    }
  }

  if(maps\_utility::_id_1008("_stealth_behavior_asleep")) {
    if(randomint(100) < 50) {
      var_1 = "_stealth_dog_wakeup_fast";
    } else {
      var_1 = "_stealth_dog_wakeup_slow";
    }
  } else {
    var_1 = "_stealth_dog_growl";

  }
  maps\_anim::_id_11CC(self, "gravity", var_1);
}

_id_4242(var_0) {
  self.allowdeath = 1;
  var_1 = undefined;

  if(maps\_utility::_id_1008("_stealth_behavior_asleep")) {
    var_1 = "_stealth_dog_wakeup_fast";
  } else {
    var_1 = "_stealth_dog_growl";

  }
  maps\_anim::_id_11CC(self, "gravity", var_1);
}

_id_4243(var_0) {
  self.allowdeath = 1;
  var_1 = undefined;

  if(maps\_utility::_id_1008("_stealth_behavior_asleep")) {
    var_1 = "_stealth_dog_wakeup_slow";
  } else {
    var_1 = "_stealth_dog_growl";

  }
  maps\_anim::_id_11CC(self, "gravity", var_1);
}

_id_4244(var_0) {
  self.allowdeath = 1;
  var_1 = "_stealth_behavior_saw_corpse";
  maps\_anim::_id_11CC(self, "gravity", var_1);
}

_id_4245(var_0) {
  self.allowdeath = 1;
  var_1 = "_stealth_dog_saw_corpse";
  maps\_anim::_id_11CC(self, "gravity", var_1);
}

_id_4246(var_0) {
  self.allowdeath = 1;
  var_1 = "_stealth_dog_howl";
  maps\_anim::_id_11CC(self, "gravity", var_1);
  maps\_anim::_id_11CC(self, "gravity", var_1);
  maps\_anim::_id_11CC(self, "gravity", var_1);
  maps\_anim::_id_11CC(self, "gravity", var_1);
  maps\_anim::_id_11CC(self, "gravity", var_1);
  maps\_anim::_id_11CC(self, "gravity", var_1);
}

_id_4247(var_0) {
  self endon("enemy");

  if(isDefined(self.enemy)) {
    return;
  }
  self.allowdeath = 1;

  if(self.a._id_0D2B == "stop") {
    var_1 = "_stealth_find_stand";
  } else {
    var_1 = "_stealth_find_jog";

  }
  maps\_anim::_id_11CC(self, "gravity", var_1);
}

_id_4248(var_0) {
  self endon("enemy");

  if(isDefined(self.enemy)) {
    return;
  }
  self.allowdeath = 1;
  var_1 = "_stealth_dog_find";
  maps\_anim::_id_11CC(self, "gravity", var_1);
}