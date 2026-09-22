/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_trap_med.gsc
*******************************************************/

_id_9CB8(var_0) {
  var_0._id_9CB9 = _getEnt("electric_trap_origin", "targetname");
  level._id_9CB8 = var_0._id_9CB9;
  level._id_9CB8._id_9C92 = var_0;
  level._id_9CB8._id_9CBB = var_0._id_0165;
  var_0 thread _id_8B0D();
}

_id_8B0D() {
  self._id_9CB9._id_565F = 1;
  var_0 = common_scripts\utility::_id_46B5("med_trap_fx_point", "targetname");
  var_1 = _spawnfx(level._effect["zmb_med_spike_trap_on"], var_0.origin, anglesToForward(var_0.angles));
  _triggerfx(var_1);
  thread _id_30E4(var_0);
  thread _id_30E3(var_0);
  _id_0378::_id_8D74("aud_trap_spikes", self._id_9CB9.origin);
  common_scripts\utility::_id_A70A("cooldown", "no_power", "ready", "deactivate");
  var_1 delete();
  self._id_9CB9._id_565F = 0;
}

_id_2FF4() {
  self endon("med_trap_stop_fx");
  self._id_16F7 = spawn("script_model", self.origin);
  self._id_16F7 setModel("tag_origin");
  self._id_16F2 = spawn("script_model", self.origin);
  self._id_16F2 setModel("tag_origin");

  for(;;) {
    for(var_0 = 0; var_0 < 2; var_0++) {
      self._id_16F7.origin = self.origin;
      self._id_16F2.origin = self gettagorigin("TAG_Chains_0" + (var_0 + 1));
      var_1 = _func_382("zmb_electricity_reg_beam_med", self._id_16F7, "tag_origin", self._id_16F2, "tag_origin");
      self._id_16F7 moveTo(self._id_16F2.origin, 1);
      wait 1;
      var_1 delete();
    }
  }
}

_id_93C3() {
  self notify("med_trap_stop_fx");
  waitframe();
  self._id_16F7 delete();
  self._id_16F2 delete();
}

_id_30E4(var_0) {
  while(self._id_9CB9._id_565F) {
    var_1 = _id_0547::_id_408F();

    foreach(var_3 in var_1) {
      if(_distance2d(var_3.origin, var_0.origin) < 135 && var_3.origin[2] < self._id_9CB9.origin[2]) {
        playFX(level._effect["zmb_med_trap_gib"], var_3.origin + (0, 0, 50), anglesToForward(var_3.angles));
        waitframe();
        var_4 = gettime();

        if(isalive(var_3) && var_3._id_0BA4 != "traverse") {
          if(!isDefined(var_3._id_A874) || isDefined(var_3._id_A874) && var_4 > var_3._id_A874 + 1000) {
            if(var_3 _id_0547::_id_580A()) {
              var_3 dodamage(var_3.health * 0.1, self._id_9CB9.origin, level._id_9CB8, level._id_9CB8, "MOD_EXPLOSIVE", "trap_zm_mp");
            } else {
              maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::_id_6FEE(var_3);
              var_3 dodamage(var_3.health + 666, self._id_9CB9.origin, level._id_9CB8, level._id_9CB8, "MOD_EXPLOSIVE", "trap_zm_mp");

              if(!isDefined(self.hitbytrap)) {
                foreach(var_6 in level.players) {
                  var_6 maps\mp\gametypes\zombies::_id_47C7("kill_trap");
                  self.hitbytrap = 1;
                }
              }
            }

            if(isalive(var_3)) {
              var_3._id_A874 = gettime();
            }
          }

          waitframe();
        }
      }
    }

    wait 0.15;
  }
}

_id_30E3(var_0) {
  while(self._id_9CB9._id_565F) {
    var_1 = level.players;

    foreach(var_3 in var_1) {
      if(!isalive(var_3)) {
        continue;
      }
      if(_id_0547::_id_577E(var_3)) {
        continue;
      }
      if(_distance2d(var_3.origin, var_0.origin) < 135 && var_3.origin[2] < self._id_9CB9.origin[2]) {
        waitframe();
        var_4 = gettime();

        if(!isDefined(var_3._id_A874)) {
          var_3._id_A874 = gettime();
        }

        if(isalive(var_3) && var_4 > var_3._id_A874 + 500 && !_id_0547::_id_577E(var_3)) {
          var_3 dodamage(5, self._id_9CB9.origin, undefined, undefined, "MOD_CRUSH");
          var_3._id_A874 = gettime();
          waitframe();
        }
      }
    }

    wait 0.15;
  }
}