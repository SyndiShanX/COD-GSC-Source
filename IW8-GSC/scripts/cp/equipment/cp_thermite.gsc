/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_thermite.gsc
************************************************/

function thermite_used(var0, var1, var2) {
  if(isDefined(var1)) {
    var3 = var0;
    var0 = self launchgrenade("thermite_mp", var3.origin, (0, 0, 0));
    var0.see_equipment_dist = var3;
    var0.angles = var3.angles;
    var0.owner = self;
    var0 linkTo(var3);
    var0 setscriptablepartstate("visibility", "hide", 0);
  }

  var0.set_car_collision = self.name;
  thread thermite_watchdisowned();
  thread thermite_watchstuck(var0, var1);
}

function thermite_watchstuck(var0, var1) {
  self endon("death");
  var2 = undefined;
  jumpiffalse(istrue(var0)) LOC_0000003e;
  var3 = ref_13b20();

  if(!istrue(var3)) {
    thread thermite_delete();
    return;
  }

  if(isDefined(self.see_equipment_dist)) {
    self.see_equipment_dist delete();
  }

  goto LOC_0000005b;
}

function ref_13b20() {
  self.see_equipment_dist endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self.see_equipment_dist waittill("missile_stuck", var0, var1, var2, var3, var4, var5);
  ref_13b1f(var0, var1);
  return true;
}

function ref_13b1f(var0, var1) {
  if(isDefined(var0)) {
    if(isPlayer(var0) || isagent(var0)) {
      if(var0 scripts\cp_mp\utility\player_utility::_isalive()) {
        if(isDefined(var1)) {
          self linkTo(var0, var1);
        } else {
          self linkTo(var0, "j_spine", (0, 0, 0));
        }

        if(isPlayer(var0)) {
          var0 thread scripts\cp\cp_weapons::enableburnfxfortime(0.6);
          return;
        }

        return;
      }

      return;
    }

    if(isDefined(var1)) {
      self linkTo(var0, var1);
      return;
    }

    self linkTo(var0);
    return;
  }
}

function thermite_watchdisowned() {
  self endon("death");
  self.owner scripts\engine\utility::ref_143a6("joined_team", "joined_spectators", "disconnect");
  thread thermite_destroy();
}

function thermite_destroy() {
  var0 = self getlinkedparent();

  if(isDefined(var0) && isPlayer(var0)) {
    if(istrue(var0.inlaststand)) {
      thread ref_13b1e();
    }
  }

  thread thermite_delete(5);
  self setscriptablepartstate("effects", "burnEnd", 0);
}

function thermite_delete(var0) {
  self notify("death");
  self.exploding = 1;
  self forcehidegrenadehudwarning(1);
  wait var0;
  self delete();
}

function thermite_onplayerdamaged(var0) {
  if(var0.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  var0.victim thread scripts\cp\cp_weapons::enableburnfxfortime(0.6);
  return true;
}

function ref_13b1e() {
  self endon("disconnect");
  self notify("newBurnFXLaststand");
  self endon("newBurnFXLaststand");
  waitframe();
  thread scripts\cp\cp_weapons::enableburnfxfortime(4);
}