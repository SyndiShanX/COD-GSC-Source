/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3594.gsc
************************/

func_1342F() {}

func_13430() {
  level endon("game_ended");
  self endon("end_explode");
  self.triggerportableradarping endon("disconnect");
  self waittill("explode", var_00);
  func_10E0B(var_00, self.triggerportableradarping);
}

func_10E0B(param_00, param_01) {
  var_02 = [];
  var_03 = scripts\mp\utility::getotherteam(param_01.team);
  var_02 = scripts\mp\utility::clearscrambler(param_00, 256);
  if(var_02.size > 0) {
    foreach(var_05 in var_02) {
      if(!isagent(var_05)) {
        if(var_05.team == var_03 || var_05 == param_01) {
          var_06 = func_13431(var_02, var_05, self, param_00);
          if(!var_06) {
            continue;
          }

          var_05 thread func_5AE9(param_01, var_03);
        }
      }
    }
  }
}

func_13431(param_00, param_01, param_02, param_03) {
  var_04 = scripts\engine\utility::array_add_safe(param_00, param_02);
  if(!scripts\common\trace::ray_trace_passed(param_03, param_01.origin + (0, 0, 32), var_04)) {
    return 0;
  }

  return 1;
}

func_5AE9(param_00, param_01) {
  thread func_13BA1();
  if(isDefined(self.var_8C3B) && self.var_8C3B) {
    scripts\mp\utility::removeperk("specialty_block_health_regen");
    self notify("force_regen");
    self notify("virus_complete");
  }

  self endon("death");
  self endon("disconnect");
  self endon("virus_complete");
  self.var_8C3B = 1;
  var_02 = 10;
  var_03 = 3;
  scripts\mp\utility::giveperk("specialty_block_health_regen");
  self iprintlnbold("Systems infected by Virus!");
  thread func_D572();
  thread func_D573();
  self dodamage(50, self.origin, param_00, undefined, "MOD_EXPLOSIVE", "virus_grenade_mp");
  while(var_03 > 0) {
    playFX(scripts\engine\utility::getfx("vfx_virus_active_3rd_person"), self.origin + (0, 0, 32));
    wait(0.5);
    var_03 = var_03 - 0.5;
    func_10AA5(param_00, param_01);
  }

  wait(var_02);
  self iprintlnbold("Virus purged, rebooting systems...");
  self.var_8C3B = 0;
  scripts\mp\utility::removeperk("specialty_block_health_regen");
  self notify("force_regen");
  self notify("virus_complete");
}

func_D572() {
  self endon("death");
  self endon("disconnect");
  self endon("virus_complete");
  var_00 = anglesToForward(self.angles);
  var_01 = anglestoup(self.angles);
  for(;;) {
    playFX(scripts\engine\utility::getfx("vfx_virus_particles"), self.origin + (0, 0, 32), var_00, var_01);
    wait(0.1);
  }
}

func_D573() {
  self endon("death");
  self endon("disconnect");
  self endon("virus_complete");
  for(;;) {
    var_00 = spawnfxforclient(scripts\engine\utility::getfx("vfx_virus_particles_screen"), self getEye(), self);
    triggerfx(var_00);
    var_00 thread scripts\mp\utility::deleteonplayerdeathdisconnect(self);
    wait(0.2);
    var_00 delete();
  }
}

func_10AA5(param_00, param_01) {
  var_02 = self.origin + (0, 0, 32);
  var_03 = scripts\mp\utility::clearscrambler(var_02, 256);
  if(var_03.size > 0) {
    foreach(var_05 in var_03) {
      if(!isagent(var_05)) {
        if(var_05.team == param_01) {
          if((isDefined(var_05.var_8C3B) && !var_05.var_8C3B) || !isDefined(var_05.var_8C3B)) {
            var_06 = func_13431(var_03, var_05, self, var_02);
            if(!var_06) {
              continue;
            }

            var_05 thread func_5AE9(param_00, param_01);
          }
        }
      }
    }
  }
}

func_13BA1() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("player_spawned");
  self waittill("death");
  if(isDefined(self.var_8C3B)) {
    self.var_8C3B = undefined;
  }
}