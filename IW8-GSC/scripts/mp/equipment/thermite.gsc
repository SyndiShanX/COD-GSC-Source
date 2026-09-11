/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\thermite.gsc
***********************************************/

function thermite_used(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_0;
    var_0 = scripts\mp\utility\weapon::_launchgrenade("thermite_mp", var_2.origin, (0, 0, 0));
    scripts\mp\weapons::grenadeinitialize(var_0, getcompleteweaponname("thermite_mp"));
    var_0.see_equipment_dist = var_2;
    var_0.angles = var_2.angles;
    var_0.see_killstreak_dist = self getcurrentweapon();
    var_0 linkTo(var_2);
    var_0.exploding = 1;
    var_0 setscriptablepartstate("visibility", "hide", 0);
  }

  if(isDefined(level.playimpactfx)) {
    [[level.playimpactfx]](var_0, self);
  }

  thread thermite_watchdisowned();
  thread ref_13b21();
  thread thermite_watchstuck(var_0);
}

function thermite_watchstuck(var_0) {
  self endon("death");
  var_1 = undefined;
  jumpiffalse(istrue(var_0)) LOC_0000003d;
  var_2 = ref_13b20();

  if(!istrue(var_2)) {
    thread thermite_delete();
    return;
  }

  if(isDefined(self.see_equipment_dist)) {
    self.see_equipment_dist delete();
  }

  goto LOC_00000057;
}

function ref_13b20() {
  self.see_equipment_dist endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self.see_equipment_dist waittill("missile_stuck", var_0, var_1, var_2, var_3, var_4, var_5);
  self.see_equipment_dist.surfacetype = var_2;

  if(isDefined(var_0)) {
    if(isPlayer(var_0) || isagent(var_0)) {
      if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
        if(isPlayer(var_0)) {
          thread scripts\mp\weapons::grenadestuckto(self, var_0);
        }

        if(isDefined(var_1)) {
          self linkTo(var_0, var_1);
        } else {
          self linkTo(var_0, "j_spine4", (0, 0, 0));
        }
      }
    } else if(isDefined(var_1)) {
      self linkTo(var_0, var_1);
    } else {
      self linkTo(var_0);
    }
  }

  return true;
}

function ref_13b22() {
  self endon("death");
  var_0 = self getlinkedparent();

  while(isDefined(var_0)) {
    self waittill("missile_stuck", var_0);
  }

  self.badplace = createnavbadplacebybounds(self.origin, (125, 125, 125), (0, 0, 0));
}

function ref_13b1d(var_0) {
  var_1 = 125;
  var_2 = 25;
  var_3 = 10;
  var_4 = "MOD_FIRE";

  if(var_0.basename == "thermite_mp") {
    var_1 = 125;
    var_2 = 40;
    var_3 = 40;
  }

  var_5 = self.stuckenemyentity;

  if(isDefined(var_5)) {
    if(isPlayer(var_5) && var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
      if(isDefined(level.ref_132a4) && [[level.ref_132a4.getheliflyheight]](var_5)) {
        thread thermite_destroy();
        return;
      }

      var_5 dodamage(var_2, self.origin, self.owner, self, var_4, var_0);
      var_5 scripts\cp_mp\utility\damage_utility::adddamagemodifier("thermiteStuck", 0, 0, &ref_13b1c);
    } else {
      var_5 = undefined;
    }
  }

  self radiusdamage(self.origin, var_1, var_2, var_3, self.owner, var_4, var_0);

  if(isDefined(var_5)) {
    var_5 scripts\cp_mp\utility\damage_utility::removedamagemodifier("thermiteStuck", 0);
    return;
  }
}

function ref_13b1c(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0)) {
    return true;
  }

  if(!isDefined(var_0.weapon_name) || var_0.weapon_name != "thermite_mp") {
    return true;
  }

  if(!isDefined(var_0.stuckenemyentity) || var_0.stuckenemyentity != var_2) {
    return true;
  }

  return false;
}

function thermite_watchdisowned() {
  self endon("death");
  self.owner scripts\engine\utility::ref_143a6("joined_team", "joined_spectators", "disconnect");
  thread thermite_destroy();
}

function ref_13b21() {
  self endon("death");
  level waittill("br_prematchEnded");
  thread thermite_destroy();
}

function thermite_destroy() {
  thread thermite_delete(5);
  self setscriptablepartstate("effects", "burnEnd", 0);
}

function thermite_delete(var_0) {
  self notify("death");
  self.exploding = 1;

  if(isDefined(self.dangerzoneid)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzoneid);
    self.dangerzoneid = undefined;
  }

  if(isDefined(self.badplace)) {
    destroynavobstacle(self.badplace);
    self.badplace = undefined;
  }

  self forcehidegrenadehudwarning(1);

  if(isDefined(var_0)) {
    wait var_0;
  }

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function thermite_onplayerdamaged(var_0) {
  if(var_0.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  var_0.victim.lastburntime = gettime();
  var_0.victim thread scripts\mp\weapons::enableburnfxfortime(0.6);
  return true;
}