/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1912.gsc
*************************************************/

init() {
  level._id_5B9F = [];
  var_0 = spawnStruct();
  var_0.weaponinfo = "zmb_fireworksprojectile_mp";
  var_0.modelbase = "park_fireworks_trap";
  var_0._id_9FDD = "park_fireworks_trap_good";
  var_0._id_9FDE = "park_fireworks_trap_bad";
  var_0._id_0224 = &"COOP_CRAFTABLES/PICKUP";
  var_0._id_B17C = &"COOP_CRAFTABLES/PLACE";
  var_0._id_31A4 = &"COOP_CRAFTABLES/CANNOT_PLACE";
  var_0._id_B158 = &"COOP_CRAFTABLES/PLACE_CANCELABLE";
  var_0._id_9371 = 120.0;
  var_0._id_C0C7 = 2;
  var_0._id_7116 = 0.4;
  var_0._id_A77E = 12;
  var_0._id_57EA = "park_fireworks_trap_rocket";
  var_0._id_B16E = 30.0;
  var_0._id_B175 = 16.0;
  var_0._id_32D4 = (0, 0, 35);
  var_0._id_32D3 = (0, 0, 0);
  level._id_5B9F["crafted_ims"] = var_0;
}

_id_6EDA(var_0, var_1) {
  var_1 thread _id_10A2B();
  var_1 notify("new_power", "crafted_ims");
  var_1 thread scripts\cp\utility::_id_FE75(var_1, "iw7_pickup_zm");
  scripts\cp\utility::_id_D19E("crafted_ims", ::_id_6EDA, var_1);
}

_id_10A2B() {
  self endon("death");
  self endon("disconnect");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_ims", "+actionslot 3");

  for(;;) {
    self waittill("pullout_ims");

    if(istrue(self._id_87A7)) {
      continue;
    }
    if(istrue(self._id_9500)) {
      continue;
    }
    if(isDefined(self._id_1529) && self._id_1529 == 0) {
      continue;
    }
    if(scripts\cp\utility::_id_8708()) {
      break;
    }
  }

  thread _id_6EE9("crafted_ims");
}

_id_6EE9(var_0) {
  self endon("disconnect");
  scripts\cp\utility::_id_3958("msg_power_hint");
  var_1 = _id_3F16(var_0, self);
  self._id_8B3D = var_1.name;
  scripts\cp\utility::_id_C435();
  self._id_32BE = var_1;
  var_1._id_5BDA = 1;
  var_2 = _id_D4BA(var_1, 1);
  self._id_32BE = undefined;
  thread scripts\cp\utility::_id_C6FE();
  return var_2;
}

_id_D4BA(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 thread _id_5B9C(self);
  scripts\common\utility::_id_158D(0);
  self notifyonplayercommand("place_ims", "+attack");
  self notifyonplayercommand("place_ims", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_ims", "+actionslot 3");

  if(!self _meth_8684()) {
    self notifyonplayercommand("cancel_ims", "+actionslot 5");
    self notifyonplayercommand("cancel_ims", "+actionslot 6");
    self notifyonplayercommand("cancel_ims", "+actionslot 7");
  }

  for(;;) {
    var_3 = scripts\engine\utility::_id_10899("place_ims", "cancel_ims", "force_cancel_placement", "player_action_slot_restart");

    if(!isDefined(var_3)) {
      var_3 = "force_cancel_placement";
    }

    if(var_3 == "cancel_ims" || var_3 == "force_cancel_placement" || var_3 == "player_action_slot_restart") {
      if(!var_1 && var_3 == "cancel_ims") {
        continue;
      }
      var_0 _id_5B9B(var_3 == "force_cancel_placement" && !isDefined(var_0._id_5BDA));

      if(var_3 != "force_cancel_placement") {
        thread _id_10A2B();
      } else if(var_1) {
        scripts\cp\utility::_id_C397(self);
      }

      return 0;
    }

    if(!var_0._id_314C) {
      continue;
    }
    if(var_1) {
      scripts\cp\utility::_id_C397(self);
    }

    var_0 thread _id_5B9E(var_2);
    self notify("IMS_placed");
    scripts\common\utility::_id_158D(1);
    return 1;
  }
}

_id_3F16(var_0, var_1) {
  if(isDefined(var_1._id_87A7) && var_1._id_87A7) {
    return;
  }
  var_2 = spawnturret("misc_turret", var_1.origin + (0, 0, 25), "sentry_minigun_mp");
  var_2.angles = var_1.angles;
  var_2._id_5BA0 = var_0;
  var_2.owner = var_1;
  var_2.name = "crafted_ims";
  var_2._id_32BE = spawn("script_model", var_2.origin);
  var_2._id_32BE.angles = var_1.angles;
  var_2 _meth_8224();
  var_2 _meth_839D(1);
  var_2 setmode("sentry_offline");
  var_2 makeunusable();
  var_2 setsentryowner(var_1);
  return var_2;
}

_id_3F15(var_0, var_1) {
  var_2 = var_0.owner;
  var_3 = var_0._id_5BA0;
  var_4 = spawn("script_model", var_0.origin + (0, 0, 1));
  var_4 setModel(level._id_5B9F[var_3].modelbase);
  var_4._id_CB76 = 3;
  var_4.angles = var_0.angles;
  var_4._id_5BA0 = var_3;
  var_4.owner = var_2;
  var_4 setotherent(var_2);
  var_4.team = var_2.team;
  var_4.name = "crafted_ims";
  var_4._id_DBE2 = 0;
  var_4.hidden = 0;
  var_4._id_1DF8 = 1;
  var_4._id_7561 = [];
  var_4._id_3B73 = level._id_5B9F[var_3];
  var_4 thread _id_5B99();

  if(isDefined(var_1)) {
    var_4 thread scripts\cp\utility::_id_8B2C(var_1);
  } else {
    var_4 thread scripts\cp\utility::_id_8B2C(undefined, level._id_5B9F[self._id_5BA0]._id_9371);
  }

  return var_4;
}

_id_7D63(var_0) {
  self._id_7D43 = 1;
  self notify("death");
}

_id_7D61(var_0) {
  self endon("carried");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  _id_5B9D();

  if(isDefined(self._id_84F0)) {
    self._id_84F0 scripts\cp\utility::_id_C6FE();
    self notify("deleting");
    wait 1.0;
  }

  _id_5559();
  self delete();
}

_id_5559() {
  self setscriptablepartstate("base", "explode");
  wait 0.5;
  _func_01BA(self.origin + (0, 0, 40), 200, 500, 250, self, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
  wait 0.65;
}

_id_5B99() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(!var_0 scripts\cp\utility::_id_8708()) {
      continue;
    }
    if(istrue(var_0._id_87A7)) {
      continue;
    }
    var_1 = _id_3F16(self._id_5BA0, var_0);

    if(!isDefined(var_1)) {
      continue;
    }
    _id_5B9D();

    if(isDefined(self _meth_8151())) {
      self unlink();
    }

    var_0 thread _id_D4BA(var_1, 0, self._id_9371);
    self delete();
    break;
  }
}

_id_5B9E(var_0) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self._id_32CA)) {
    self._id_32CA _meth_80FC();
  }

  self._id_32CA = undefined;

  if(isDefined(self.owner)) {
    self.owner._id_87A7 = 0;
  }

  self._id_5BDA = undefined;
  var_1 = _id_3F15(self, var_0);
  var_1._id_8983 = 1;
  var_1 thread _id_7D61(self.owner);
  self playSound("ims_plant");
  self notify("placed");
  var_1 thread _id_5B9A();
  var_2 = spawnStruct();

  if(isDefined(self._id_A283)) {
    var_2._id_950E = self._id_A283;
  }

  var_2._id_5338 = "carried";
  var_2._id_43F7 = ::_id_7D63;
  var_1 thread _id_0744::_id_7403(var_2);
  self._id_32BE delete();
  self delete();
}

_id_5B9B(var_0) {
  if(isDefined(self._id_32CA)) {
    var_1 = self._id_32CA;
    var_1 _meth_80FC();
    var_1._id_87A7 = undefined;
    var_1._id_32CD = undefined;
    var_1 scripts\common\utility::_id_158D(1);
  }

  if(isDefined(var_0) && var_0) {
    _id_5559();
  }

  self._id_32BE delete();
  self delete();
}

_id_5B9C(var_0) {
  self _meth_8376(var_0);
  self notsolid();
  self setCanDamage(0);
  self._id_32CA = var_0;
  var_0._id_87A7 = 1;
  var_0 thread scripts\cp\utility::_id_FBDF(self, self._id_32BE, level._id_5B9F["crafted_ims"]);
  thread scripts\cp\utility::_id_8B26(var_0);
  thread _id_7D64(var_0);
  thread _id_7D65(var_0);

  if(isDefined(level._id_4FE9)) {
    self thread[[level._id_4FE9]](var_0);
  }

  self notify("carried");
}

_id_7D64(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  var_0 waittill("disconnect");
  _id_5B9B();
}

_id_7D65(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  level waittill("game_ended");
  _id_5B9B();
}

_id_5B9A() {
  self endon("death");
  self setcursorhint("HINT_NOICON");
  self sethintstring(level._id_5B9F[self._id_5BA0]._id_0224);
  scripts\cp\utility::_id_1179();
  var_0 = self.owner;
  var_0 _meth_80FC();
  self makeuseable();
  self setusefov(120);
  self setuserange(96);
  wait 0.05;
  var_1 = (0, 0, 27);
  var_2 = (0, 0, 500) - var_1;
  var_3 = self.origin;
  var_4 = self.origin + var_1;
  var_5 = scripts\engine\trace::_bullet_trace(var_4, var_4 + var_2, 0, self);
  var_6 = var_5;
  self._id_1DE5 = var_6["position"] - (0, 0, 20) - self.origin;

  if(self._id_1DE5[2] < 250) {
    self._id_90DF = "launch_low";
  } else if(self._id_1DE5[2] < 450) {
    self._id_90DF = "launch_med";
  } else {
    self._id_90DF = "launch_high";
  }

  var_7 = spawn("trigger_radius", self.origin, 0, 256, 100);
  self._id_1DFB = var_7;
  self._id_1DFB _meth_80DB();
  self._id_1DFB linkto(self);
  self._id_1DF4 = length(self._id_1DE5) / 400;
  wait 0.75;
  self setscriptablepartstate("base", "on");
  thread _id_5B98();
  thread scripts\cp\utility::_id_8B23("fireworks_disconnect");
}

_id_5B9D() {
  self makeunusable();

  if(isDefined(self._id_1DFB)) {
    self._id_1DFB delete();
  }

  if(isDefined(self._id_57DD)) {
    self._id_57DD delete();
    self._id_57DD = undefined;
  }

  scripts\cp\utility::_id_C4BF();
}

_id_5B98() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self._id_1DFB)) {
      break;
    }

    self._id_1DFB waittill("trigger", var_0);

    if(isPlayer(var_0) || isDefined(var_0._id_B02C) || isDefined(var_0._id_1210) && var_0._id_1210 == "the_hoff") {
      continue;
    }
    var_1 = var_0.origin + (0, 0, 50);

    if(!_func_0202(self._id_1DE5 + self.origin, var_1, 0, self)) {
      continue;
    }
    if(!isDefined(self._id_1DFB)) {
      break;
    }

    if(!isDefined(self._id_7561[self._id_1DF8])) {
      self._id_7561[self._id_1DF8] = 1;
      thread _id_90DE(var_0, self._id_1DF8);
      self._id_1DF8++;
    }

    if(self._id_1DF8 > self._id_3B73._id_A77E) {
      self setscriptablepartstate("firework", "off");
      break;
    }

    self waittill("firework_exploded");
    self setscriptablepartstate("firework", "off");
    wait(self._id_3B73._id_C0C7);

    if(!isDefined(self.owner)) {
      break;
    }
  }

  if(isDefined(self._id_32CA) && isDefined(self.owner) && self._id_32CA == self.owner) {
    return;
  }
  self notify("death");
}

_id_90DE(var_0, var_1) {
  self setscriptablepartstate("firework", self._id_90DF);
  var_2 = spawn("script_model", self.origin);
  var_2 setModel(self._id_3B73._id_57EA);
  var_2.angles = self.angles;
  var_2 setscriptablepartstate("rocket", "launch");
  var_3 = self._id_3B73.weaponinfo;
  var_4 = self.owner;
  var_2 moveto(self._id_1DE5 + self.origin, self._id_1DF4, self._id_1DF4 * 0.5, 0);
  var_2 waittill("movedone");
  var_2 setscriptablepartstate("rocket", "explode");
  wait 0.1;

  if(isDefined(var_4)) {
    _func_0143(var_3, var_2.origin, var_0.origin, var_4);
  } else {
    _func_0143(var_3, var_2.origin, var_0.origin, level.players[0]);
  }

  var_2 delete();
  self notify("firework_exploded");
}