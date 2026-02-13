/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2314.gsc
*************************************************/

_id_1108B(var_0, var_1, var_2) {
  self _meth_87CF(self._id_1C30._id_1A35);
  self._id_1C30._id_426A = spawnStruct();
  self._id_1C30._id_5E3A = spawnStruct();
  self._id_1C30._id_5E3A._id_5E36 = "invalid";
  self._id_1C30._id_5E3A._id_F1E8 = 0;
  self.ai_explosion_damage_mult = 3.08;

  if(self _meth_86EE()) {
    thread _id_8283();
  }

  self._id_1C30.movealias = [];
  waitframe();

  if(scripts\aitypes\zombie_common\awareness::is_aware()) {
    self playLoopSound("zmb_vox_screamer_lp");
  } else {
    thread _id_CC60();
  }
}

_id_8283() {
  self endon("death");
  scripts\engine\utility::_id_5C24("scriptables_ready");
  self setscriptablepartstate("notetrack_handler", "active", 0);
}

_id_DB56(var_0, var_1, var_2, var_3) {
  return istrue(self._id_0B67.exploderequested);
}

_id_B32D(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");

  if(!istrue(self._id_7560)) {
    thread _id_0906::_id_B383(var_0, "death_generic");
    self.is_dying = 1;
    var_3 = 0.25;
    wait(var_3);

    if(isDefined(level._id_1104B)) {
      self thread[[level._id_1104B]](self);
    }

    self._id_A546 = 1;
    thread _id_1104A();
  }
}

_id_B34D(var_0, var_1, var_2) {
  if(!istrue(self._id_7560) && !istrue(self._id_DDAB)) {
    if(!istrue(self._id_0162)) {
      self._id_A546 = 1;
      _id_1104A();
    } else
      self._id_A546 = undefined;
  }
}

_id_1104A() {
  self._id_7560 = 1;
  var_0 = self gettagorigin("j_spineupper");

  if(!isDefined(self)) {
    return;
  }
  playFX(level._effect["zmb_ai_explosion_death"], var_0);
  thread _id_1104D();
  self playSound("ai_screamer_explo");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.8, 0.6, self.origin, 450);
  self notify("detonated");

  if(!isDefined(self)) {
    return;
  }
  if(!isagent(self)) {
    self delete();
  } else {
    self _meth_81FA();
  }
}

_id_1104D() {
  var_0 = self.origin;

  while(isDefined(level.screamer_detonation_time) && level.screamer_detonation_time == gettime()) {
    waitframe();
  }

  level.screamer_detonation_time = gettime();
  _func_01BA(var_0 + (0, 0, 60), 108, 65, 20, self, undefined, "s4_brain_rot_explosion_zm");
}

_id_1104C(var_0, var_1, var_2) {
  _id_08FD::_id_3899(var_0, var_1, var_2);
}

_id_B34E(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread _id_08F1::_id_10800(var_0, var_1, 1);
  var_3 = _id_0009::_id_1C7D(var_1, "blank");
  self _meth_85ED(var_1, var_3);
  thread _id_2561(var_1);

  for(;;) {
    _id_0009::_id_1C45(var_0, var_1);
  }
}

_id_2561(var_0) {
  self endon("death");
  self endon(var_0 + "_finished");

  for(;;) {
    var_1 = randomfloatrange(-1, 1);
    self _meth_8695(var_1);
    wait(randomfloatrange(0.25, 2));
  }
}

_id_11091(var_0, var_1, var_2, var_3) {
  return istrue(self._id_1104E);
}

_id_CC60() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var_0 = randomfloatrange(2, 5);
    var_1 = scripts\engine\utility::_id_108A7(var_0, "made_aware");

    if(var_1 == "timeout") {
      self playSound("zmb_screamer_vox_amb");
      continue;
    }

    self playLoopSound("zmb_vox_screamer_lp");
    break;
  }
}