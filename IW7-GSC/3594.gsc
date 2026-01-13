/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3594.gsc
*********************************************/

func_1342F() {}

func_13430() {
  level endon("game_ended");
  self endon("end_explode");
  self.triggerportableradarping endon("disconnect");
  self waittill("explode", var_0);
  func_10E0B(var_0, self.triggerportableradarping);
}

func_10E0B(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\mp\utility::getotherteam(var_1.team);
  var_2 = scripts\mp\utility::clearscrambler(var_0, 256);
  if(var_2.size > 0) {
    foreach(var_5 in var_2) {
      if(!isagent(var_5)) {
        if(var_5.team == var_3 || var_5 == var_1) {
          var_6 = func_13431(var_2, var_5, self, var_0);
          if(!var_6) {
            continue;
          }

          var_5 thread func_5AE9(var_1, var_3);
        }
      }
    }
  }
}

func_13431(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::array_add_safe(var_0, var_2);
  if(!scripts\common\trace::ray_trace_passed(var_3, var_1.origin + (0, 0, 32), var_4)) {
    return 0;
  }

  return 1;
}

func_5AE9(var_0, var_1) {
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
  var_2 = 10;
  var_3 = 3;
  scripts\mp\utility::giveperk("specialty_block_health_regen");
  self iprintlnbold("Systems infected by Virus!");
  thread func_D572();
  thread func_D573();
  self dodamage(50, self.origin, var_0, undefined, "MOD_EXPLOSIVE", "virus_grenade_mp");
  while(var_3 > 0) {
    playFX(scripts\engine\utility::getfx("vfx_virus_active_3rd_person"), self.origin + (0, 0, 32));
    wait(0.5);
    var_3 = var_3 - 0.5;
    func_10AA5(var_0, var_1);
  }

  wait(var_2);
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
  var_0 = anglesToForward(self.angles);
  var_1 = anglestoup(self.angles);
  for(;;) {
    playFX(scripts\engine\utility::getfx("vfx_virus_particles"), self.origin + (0, 0, 32), var_0, var_1);
    wait(0.1);
  }
}

func_D573() {
  self endon("death");
  self endon("disconnect");
  self endon("virus_complete");
  for(;;) {
    var_0 = spawnfxforclient(scripts\engine\utility::getfx("vfx_virus_particles_screen"), self getEye(), self);
    triggerfx(var_0);
    var_0 thread scripts\mp\utility::deleteonplayerdeathdisconnect(self);
    wait(0.2);
    var_0 delete();
  }
}

func_10AA5(var_0, var_1) {
  var_2 = self.origin + (0, 0, 32);
  var_3 = scripts\mp\utility::clearscrambler(var_2, 256);
  if(var_3.size > 0) {
    foreach(var_5 in var_3) {
      if(!isagent(var_5)) {
        if(var_5.team == var_1) {
          if((isDefined(var_5.var_8C3B) && !var_5.var_8C3B) || !isDefined(var_5.var_8C3B)) {
            var_6 = func_13431(var_3, var_5, self, var_2);
            if(!var_6) {
              continue;
            }

            var_5 thread func_5AE9(var_0, var_1);
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