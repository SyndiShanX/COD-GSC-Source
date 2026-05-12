/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_trap_med.gsc
***********************************************/

func_9CB8(param_00) {
  param_00.var_9CB9 = getent("electric_trap_origin", "targetname");
  level.var_9CB8 = param_00.var_9CB9;
  level.var_9CB8.var_9C92 = param_00;
  level.var_9CB8.var_9CBB = param_00.var_0165;
  param_00 thread func_8B0D();
}

func_8B0D() {
  self.var_9CB9.var_565F = 1;
  var_00 = common_scripts\utility::func_46B5("med_trap_fx_point", "targetname");
  var_01 = spawnfx(level.var_0611["zmb_med_spike_trap_on"], var_00.var_0116, anglesToForward(var_00.var_001D));
  triggerfx(var_01);
  thread func_30E4(var_00);
  thread func_30E3(var_00);
  lib_0378::func_8D74("aud_trap_spikes", self.var_9CB9.var_0116);
  common_scripts\utility::func_A70A("cooldown", "no_power", "ready", "deactivate");
  var_01 delete();
  self.var_9CB9.var_565F = 0;
}

func_2FF4() {
  self endon("med_trap_stop_fx");
  self.var_16F7 = spawn("script_model", self.var_0116);
  self.var_16F7 setModel("tag_origin");
  self.var_16F2 = spawn("script_model", self.var_0116);
  self.var_16F2 setModel("tag_origin");
  for(;;) {
    for(var_00 = 0; var_00 < 2; var_00++) {
      self.var_16F7.var_0116 = self.var_0116;
      self.var_16F2.var_0116 = self gettagorigin("TAG_Chains_0" + var_00 + 1);
      var_01 = launchbeam("zmb_electricity_reg_beam_med", self.var_16F7, "tag_origin", self.var_16F2, "tag_origin");
      self.var_16F7 moveto(self.var_16F2.var_0116, 1);
      wait(1);
      var_01 delete();
    }
  }
}

func_93C3() {
  self notify("med_trap_stop_fx");
  wait 0.05;
  self.var_16F7 delete();
  self.var_16F2 delete();
}

func_30E4(param_00) {
  while(self.var_9CB9.var_565F) {
    var_01 = lib_0547::func_408F();
    foreach(var_03 in var_01) {
      if(distance2d(var_03.var_0116, param_00.var_0116) < 135 && var_03.var_0116[2] < self.var_9CB9.var_0116[2]) {
        playFX(level.var_0611["zmb_med_trap_gib"], var_03.var_0116 + (0, 0, 50), anglesToForward(var_03.var_001D));
        wait 0.05;
        var_04 = gettime();
        if(isalive(var_03) && var_03.var_0BA4 != "traverse") {
          if(!isDefined(var_03.var_A874) || isDefined(var_03.var_A874) && var_04 > var_03.var_A874 + 1000) {
            if(var_03 lib_0547::func_580A()) {
              var_03 dodamage(var_03.var_00BC * 0.1, self.var_9CB9.var_0116, level.var_9CB8, level.var_9CB8, "MOD_EXPLOSIVE", "trap_zm_mp");
            } else {
              maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::func_6FEE(var_03);
              var_03 dodamage(var_03.var_00BC + 666, self.var_9CB9.var_0116, level.var_9CB8, level.var_9CB8, "MOD_EXPLOSIVE", "trap_zm_mp");
              if(!isDefined(self.hitbytrap)) {
                foreach(var_06 in level.var_744A) {
                  var_06 maps\mp\gametypes\zombies::func_47C7("kill_trap");
                  self.hitbytrap = 1;
                }
              }
            }

            if(isalive(var_03)) {
              var_03.var_A874 = gettime();
            }
          }

          wait 0.05;
        }
      }
    }

    wait(0.15);
  }
}

func_30E3(param_00) {
  while(self.var_9CB9.var_565F) {
    var_01 = level.var_744A;
    foreach(var_03 in var_01) {
      if(!isalive(var_03)) {
        continue;
      }

      if(lib_0547::func_577E(var_03)) {
        continue;
      }

      if(distance2d(var_03.var_0116, param_00.var_0116) < 135 && var_03.var_0116[2] < self.var_9CB9.var_0116[2]) {
        wait 0.05;
        var_04 = gettime();
        if(!isDefined(var_03.var_A874)) {
          var_03.var_A874 = gettime();
        }

        if(isalive(var_03) && var_04 > var_03.var_A874 + 500 && !lib_0547::func_577E(var_03)) {
          var_03 dodamage(5, self.var_9CB9.var_0116, undefined, undefined, "MOD_CRUSH");
          var_03.var_A874 = gettime();
          wait 0.05;
        }
      }
    }

    wait(0.15);
  }
}