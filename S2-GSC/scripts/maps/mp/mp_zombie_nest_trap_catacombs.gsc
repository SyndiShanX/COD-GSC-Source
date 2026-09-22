/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_trap_catacombs.gsc
*************************************************************/

_id_9C9A(var_0) {
  var_0._id_8073 = common_scripts\utility::_id_46B7("catacombs_saw_spawner", "script_noteworthy");
  var_0._id_8074 = common_scripts\utility::_id_46B7("catacombs_saw_spawner_fixed", "script_noteworthy");
  var_0 thread _id_9098(var_0._id_8073);

  foreach(var_2 in var_0._id_8074) {
    var_0 thread _id_6F70(var_2);
  }
}

_id_9098(var_0) {
  self endon("cooldown");
  self endon("no_power");
  self endon("deactivate");
  self endon("ready");

  for(;;) {
    var_0 thread _id_902B(self);
    wait 1;
  }
}

_id_6F70(var_0) {
  var_1 = get_riverside_door();
  var_2 = distance(var_0.origin, var_1.origin) < 512;
  var_3 = (0, 0, 0);

  if(var_2 && !common_scripts\utility::_id_3C77("underground_to_riverside1")) {
    return;
  } else if(var_2) {
    var_3 = -4 * vectorNormalize(anglesToForward(var_0.angles));
    var_3 = var_3 + 96 * vectorNormalize(anglestoright(var_0.angles));
    var_3 = var_3 + (0, 0, -2);
  }

  var_4 = spawn("script_model", var_0.origin + (0, 0, -128) + var_3);
  var_4._id_9C92 = self;
  var_4._id_9CBB = self._id_0165;
  var_4 setModel("zmb_catacomb_trap_saw_02");
  var_4.angles = var_0.angles;
  var_4 rotateby((0, 0, -36000), 100);
  var_4 movez(128, 1, 0, 0.5);
  var_4 thread _id_6F72(self);
  var_4 thread _id_6F73(self);
  common_scripts\utility::_id_A70A("cooldown", "no_power", "deactivate", "ready");
  var_4 movez(-128, 1, 0, 0.5);
  wait 0.5;
  var_4 delete();
}

get_riverside_door() {
  foreach(var_1 in level._id_AC1D) {
    if(_id_0547::_id_5565(var_1.getnegotiationnextnode, "underground_to_riverside1")) {
      return var_1;
    }
  }

  return undefined;
}

_id_902B(var_0) {
  var_1 = common_scripts\utility::random(self);
  var_2 = common_scripts\utility::_id_46B5(var_1.target, "targetname");
  var_3 = spawn("script_model", var_1.origin + (0, 0, -128));
  var_3._id_9C92 = var_0;
  var_3._id_9CBB = var_0._id_0165;
  var_3 setModel("zmb_catacomb_trap_saw_02");
  var_3.angles = var_1.angles + (180, 0, 0);
  var_3 rotatevelocity((0, 0, -1000), 10);
  var_4 = spawn("script_model", var_1.origin);
  var_4 setModel("tag_origin");
  var_4.angles = var_1.angles;
  var_3 movez(128, 0.5);
  _playFXOnTag(level._effect["zmb_catacombs_saw_on"], var_4, "tag_origin");
  var_3 _id_0378::_id_8D74("aud_saw_blade_sound");
  wait 0.5;
  var_3 moveTo(var_2.origin, 2.5, 0.25, 0.25);
  var_4 moveTo(var_2.origin, 2.5, 0.25, 0.25);
  var_3 playfoley(2.5, var_0);
  _stopFXOnTag(level._effect["zmb_catacombs_saw_on"], var_4, "tag_origin");
  var_3 movez(-128, 1);
  var_3 _id_0378::_id_8D74("aud_saw_blade_end");
  wait 1;
  var_3 delete();
  var_4 delete();
}

_id_6F72(var_0) {
  var_0 endon("cooldown");
  var_0 endon("no_power");
  var_0 endon("deactivate");
  var_0 endon("ready");

  for(;;) {
    var_1 = _id_0547::_id_408F();

    foreach(var_3 in var_1) {
      if(!isDefined(var_3) || !isalive(var_3)) {
        continue;
      }
      if(isPlayer(var_3)) {
        continue;
      }
      if(isDefined(var_3._id_53D9) && var_3._id_53D9 == 1) {
        continue;
      }
      if(distance(self.origin, var_3.origin) > 64) {
        continue;
      }
      if(var_3 _id_0547::_id_580A()) {
        var_3 dodamage(var_3.health * 0.25, self.origin, self, self, "MOD_EXPLOSIVE", "trap_zm_mp");
      } else {
        var_0 maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::_id_6FEE(var_3);
        var_4 = 500 * vectorNormalize(var_3.origin - self.origin);
        var_3 _id_0547::_id_5A85("torso_lower", (var_4[0], var_4[1], 1500), self, "trap_zm_mp");
      }

      waitframe();
    }

    wait 0.1;
  }
}

_id_6F73(var_0) {
  var_0 endon("cooldown");
  var_0 endon("no_power");
  var_0 endon("deactivate");
  var_0 endon("ready");

  for(;;) {
    foreach(var_2 in level.players) {
      if(!isalive(var_2)) {
        continue;
      }
      if(_id_0547::_id_577E(var_2)) {
        continue;
      }
      if(distance(self.origin, var_2.origin) > 64) {
        continue;
      }
      var_3 = gettime();

      if(!isDefined(var_2._id_A86A)) {
        var_2._id_A86A = gettime();
      }

      if(isalive(var_2) && var_3 > var_2._id_A86A + 500 && !_id_0547::_id_577E(var_2)) {
        var_2 dodamage(5, self.origin, undefined, undefined, "MOD_CRUSH");
        var_2._id_A86A = gettime();
        waitframe();
      }
    }

    wait 0.1;
  }
}

playfoley(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0; var_2 = var_2 + 0.1) {
    var_3 = _id_0547::_id_408F();
    var_4 = common_scripts\utility::_id_0F73(var_3, level.players);

    foreach(var_6 in var_4) {
      if(!isDefined(var_6) || !isalive(var_6)) {
        continue;
      }
      if(isPlayer(var_6)) {
        if(_id_0547::_id_577E(var_6)) {
          continue;
        }
      } else if(isDefined(var_6._id_53D9) && var_6._id_53D9 == 1) {
        continue;
      }
      if(distance(self.origin, var_6.origin) > 64) {
        continue;
      }
      if(isPlayer(var_6)) {
        var_6 dodamage(5, self.origin, undefined, undefined, "MOD_CRUSH");
      } else if(var_6 _id_0547::_id_580A()) {
        var_6 dodamage(var_6.health * 0.25, self.origin, self, self, "MOD_EXPLOSIVE", "trap_zm_mp");
      } else {
        var_1 maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::_id_6FEE(var_6);
        var_7 = 500 * vectorNormalize(var_6.origin - self.origin);
        var_6 _id_0547::_id_5A85("torso_lower", (var_7[0], var_7[1], 1500), self, "trap_zm_mp");

        if(!isDefined(self.hitbytrap)) {
          foreach(var_9 in level.players) {
            var_9 maps\mp\gametypes\zombies::_id_47C7("kill_trap");
            self.hitbytrap = 1;
          }
        }
      }

      waitframe();
    }

    wait 0.1;
  }
}

getnormalhealth(var_0, var_1) {
  waitframe();
}