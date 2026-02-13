/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_stun_mine.gsc
*************************************************/

stun_mine_used(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  thread scripts\cp\cp_weapon::_id_A106(self, var_0);
  var_0 thread watch_portal_activation();
  var_0 waittill("missile_stuck", var_1);
  var_0 setscriptablepartstate("plant", "active", 0);
  var_0 thread explode_on_notify();
  var_0 thread destroy_on_notify();
  var_0 thread scripts\cp\cp_weapon::_id_9ED2();
  thread scripts\cp\cp_weapon::_id_A105(self, var_0);
  wait 0.25;
  var_0 setscriptablepartstate("arm", "active", 0);
  var_0 thread watch_trigger();
  scripts\cp\cp_weapon::_id_ABB6(var_0, undefined, 1);
  var_0 thread _id_0728::_id_99EF("tag_use", 1);
}

explode_on_notify() {
  self endon("death");
  level endon("game_ended");
  self waittill("detonateExplosive", var_0);
  detonate_stun_mine();
}

destroy_on_notify() {
  self endon("death");
  level endon("game_ended");
  self waittill("destroyExplosive");
  destroy_stun_mine();
}

watch_portal_activation() {
  level endon("game_ended");
  self endon("death");
  level waittill("portal_activated");
  self delete();
}

watch_trigger() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var_0 = scripts\cp\utility::_id_66CD(64, self.origin);

    if(var_0.size) {
      detonate_stun_mine();
      return;
    }

    wait 0.25;
  }
}

detonate_stun_mine() {
  var_0 = scripts\cp\utility::_id_66CD(175, self.origin);
  thread stun_enemies(var_0, self.owner);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  self setscriptablepartstate("explode", "fromDamage", 0);

  if(isDefined(self.owner)) {
    self.owner._id_B1D0 = scripts\engine\utility::array_remove(self.owner._id_B1D0, self);
  }

  self makeunusable();
  waitframe();
  self detonate();
}

destroy_stun_mine() {
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  self setscriptablepartstate("destroy", "active", 0);

  if(isDefined(self.owner)) {
    self.owner._id_B1D0 = scripts\engine\utility::array_remove(self.owner._id_B1D0, self);
  }

  self makeunusable();
  wait 1;
  self delete();
}

stun_enemies(var_0, var_1) {
  level endon("game_ended");

  foreach(var_3 in var_0) {
    if(isalive(var_3)) {
      var_3 scripts\aitypes\zombie_common\stun::stun(3.0);
    }

    if(isDefined(var_1)) {
      _id_072A::addplayereffects("stun_mine", var_3, var_1, 3.0);
      var_1 _id_0752::_id_7003("stun_mine_stunned_enemy", undefined, undefined, undefined, var_3);
    }

    waitframe();
  }
}