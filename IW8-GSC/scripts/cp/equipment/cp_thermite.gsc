/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_thermite.gsc
************************************************/

function thermite_used(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_3 = var_0;
    var_0 = self launchgrenade("thermite_mp", var_3.origin, (0, 0, 0));
    var_0.see_equipment_dist = var_3;
    var_0.angles = var_3.angles;
    var_0.owner = self;
    var_0 linkTo(var_3);
    var_0 setscriptablepartstate("visibility", "hide", 0);
  }

  var_0.set_car_collision = self.name;
  thread thermite_watchdisowned();
  thread thermite_watchstuck(var_0, var_1);
}

function thermite_watchstuck(var_0, var_1) {
  self endon("death");
  var_2 = undefined;
  jumpiffalse(istrue(var_0)) LOC_0000003e;
  var_3 = ref_13b20();

  if(!istrue(var_3)) {
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
  self.see_equipment_dist waittill("missile_stuck", var_0, var_1, var_2, var_3, var_4, var_5);
  ref_13b1f(var_0, var_1);
  return true;
}

function ref_13b1f(var_0, var_1) {
  if(isDefined(var_0)) {
    if(isPlayer(var_0) || isagent(var_0)) {
      if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
        if(isDefined(var_1)) {
          self linkTo(var_0, var_1);
        } else {
          self linkTo(var_0, "j_spine", (0, 0, 0));
        }

        if(isPlayer(var_0)) {
          var_0 thread scripts\cp\cp_weapons::enableburnfxfortime(0.6);
          return;
        }

        return;
      }

      return;
    }

    if(isDefined(var_1)) {
      self linkTo(var_0, var_1);
      return;
    }

    self linkTo(var_0);
    return;
  }
}

function thermite_watchdisowned() {
  self endon("death");
  self.owner scripts\engine\utility::ref_143a6("joined_team", "joined_spectators", "disconnect");
  thread thermite_destroy();
}

function thermite_destroy() {
  var_0 = self getlinkedparent();

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(istrue(var_0.inlaststand)) {
      thread ref_13b1e();
    }
  }

  thread thermite_delete(5);
  self setscriptablepartstate("effects", "burnEnd", 0);
}

function thermite_delete(var_0) {
  self notify("death");
  self.exploding = 1;
  self forcehidegrenadehudwarning(1);
  wait var_0;
  self delete();
}

function thermite_onplayerdamaged(var_0) {
  if(var_0.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  var_0.victim thread scripts\cp\cp_weapons::enableburnfxfortime(0.6);
  return true;
}

function ref_13b1e() {
  self endon("disconnect");
  self notify("newBurnFXLaststand");
  self endon("newBurnFXLaststand");
  waitframe();
  thread scripts\cp\cp_weapons::enableburnfxfortime(4);
}