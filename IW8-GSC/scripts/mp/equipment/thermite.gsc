/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\thermite.gsc
***********************************************/

function thermite_used(var0, var1) {
  if(isDefined(var1)) {
    var2 = var0;
    var0 = scripts\mp\utility\weapon::_launchgrenade("thermite_mp", var2.origin, (0, 0, 0));
    scripts\mp\weapons::grenadeinitialize(var0, getcompleteweaponname("thermite_mp"));
    var0.see_equipment_dist = var2;
    var0.angles = var2.angles;
    var0.see_killstreak_dist = self getcurrentweapon();
    var0 linkTo(var2);
    var0.exploding = 1;
    var0 setscriptablepartstate("visibility", "hide", 0);
  }

  if(isDefined(level.playimpactfx)) {
    [[level.playimpactfx]](var0, self);
  }

  thread thermite_watchdisowned();
  thread ref_13b21();
  thread thermite_watchstuck(var0);
}

function thermite_watchstuck(var0) {
  self endon("death");
  var1 = undefined;
  jumpiffalse(istrue(var0)) LOC_0000003d;
  var2 = ref_13b20();

  if(!istrue(var2)) {
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
  self.see_equipment_dist waittill("missile_stuck", var0, var1, var2, var3, var4, var5);
  self.see_equipment_dist.surfacetype = var2;

  if(isDefined(var0)) {
    if(isPlayer(var0) || isagent(var0)) {
      if(var0 scripts\cp_mp\utility\player_utility::_isalive()) {
        if(isPlayer(var0)) {
          thread scripts\mp\weapons::grenadestuckto(self, var0);
        }

        if(isDefined(var1)) {
          self linkTo(var0, var1);
        } else {
          self linkTo(var0, "j_spine4", (0, 0, 0));
        }
      }
    } else if(isDefined(var1)) {
      self linkTo(var0, var1);
    } else {
      self linkTo(var0);
    }
  }

  return true;
}

function ref_13b22() {
  self endon("death");
  var0 = self getlinkedparent();

  while(isDefined(var0)) {
    self waittill("missile_stuck", var0);
  }

  self.badplace = createnavbadplacebybounds(self.origin, (125, 125, 125), (0, 0, 0));
}

function ref_13b1d(var0) {
  var1 = 125;
  var2 = 25;
  var3 = 10;
  var4 = "MOD_FIRE";

  if(var0.basename == "thermite_mp") {
    var1 = 125;
    var2 = 40;
    var3 = 40;
  }

  var5 = self.stuckenemyentity;

  if(isDefined(var5)) {
    if(isPlayer(var5) && var5 scripts\cp_mp\utility\player_utility::_isalive()) {
      if(isDefined(level.ref_132a4) && [[level.ref_132a4.getheliflyheight]](var5)) {
        thread thermite_destroy();
        return;
      }

      var5 dodamage(var2, self.origin, self.owner, self, var4, var0);
      var5 scripts\cp_mp\utility\damage_utility::adddamagemodifier("thermiteStuck", 0, 0, &ref_13b1c);
    } else {
      var5 = undefined;
    }
  }

  self radiusdamage(self.origin, var1, var2, var3, self.owner, var4, var0);

  if(isDefined(var5)) {
    var5 scripts\cp_mp\utility\damage_utility::removedamagemodifier("thermiteStuck", 0);
    return;
  }
}

function ref_13b1c(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var0)) {
    return true;
  }

  if(!isDefined(var0.weapon_name) || var0.weapon_name != "thermite_mp") {
    return true;
  }

  if(!isDefined(var0.stuckenemyentity) || var0.stuckenemyentity != var2) {
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

function thermite_delete(var0) {
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

  if(isDefined(var0)) {
    wait var0;
  }

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function thermite_onplayerdamaged(var0) {
  if(var0.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  var0.victim.lastburntime = gettime();
  var0.victim thread scripts\mp\weapons::enableburnfxfortime(0.6);
  return true;
}