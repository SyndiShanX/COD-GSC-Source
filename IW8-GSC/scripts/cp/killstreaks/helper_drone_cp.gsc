/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\helper_drone_cp.gsc
******************************************************/

function helper_drone_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("helper_drone", "mark_players", &helperdrone_markplayers_cp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("helper_drone", "watchMarkingEntStatus", &markent_watchmarkingentstatus_cp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("helper_drone", "get_mark_ui_duration", &get_mark_ui_duration);
  scripts\cp_mp\utility\script_utility::registersharedfunc("helper_drone", "get_outer_reticle_targets", &get_outer_reticle_targets);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "superUseFinished", &scripts\cp\coop_super::superusefinished);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isInLastStand", &scripts\cp\cp_laststand::player_in_laststand);
  var0 = getarraykeys(level.helperdronesettings);

  foreach(var2 in var0) {
    var3 = level.helperdronesettings[var2].hitstokill;

    if(isDefined(var3)) {
      scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data(var2, var3);
      scripts\cp\vehicles\damage_cp::set_weapon_hit_damage_data_for_vehicle("emp_grenade_mp", var3, var2);
    }
  }
}

function get_mark_ui_duration() {
  return 30;
}

function helperdrone_markplayers_cp(var0) {
  var1 = self.owner;
  var1 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  for(;;) {
    var2 = get_mark_target_array();

    foreach(var4 in var2) {
      if(!isDefined(var4)) {
        continue;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var4)) {
          continue;
        }
      }

      if(var4 == var1) {
        continue;
      }

      if(level.teambased && var4.team == var1.team) {
        continue;
      }

      if(scripts\cp_mp\killstreaks\helper_drone::isbeingmarked(var4)) {
        continue;
      }

      if(scripts\cp_mp\killstreaks\helper_drone::isreconmarked(var4)) {
        continue;
      }

      scripts\cp_mp\killstreaks\helper_drone::ref_131c9(self.targetmarkergroup, var4, 0);

      if(!scripts\cp_mp\killstreaks\helper_drone::isinmarkingrange(var4)) {
        continue;
      }

      if(!scripts\cp_mp\killstreaks\helper_drone::canseetarget(var4)) {
        continue;
      }

      scripts\cp_mp\killstreaks\helper_drone::ref_131c9(self.targetmarkergroup, var4, 1);

      if(istrue(self.markingtarget)) {
        continue;
      }

      if(var1 scripts\cp_mp\killstreaks\helper_drone::helperdrone_istargetinreticle(var4, 70, 40)) {
        thread startmarkingtarget_cp(var4, "enemy", 0, 1);
      }
    }

    waitframe();
  }
}

function startmarkingtarget_cp(var0, var1, var2, var3) {
  var4 = self.owner;
  var4 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var5 = spawnStruct();
  var5.target = var0;
  var5.targetnum = var0 getentitynumber();
  var5.markingent = self;
  var5.ownerteam = var4.team;
  var5.outlineid = undefined;
  var5.headicon = undefined;
  var5.beingmarked = undefined;
  var5.reconmarked = undefined;
  var5.notifytoendmark = "unmarked_" + var5.targetnum;

  if(!isDefined(var5.targetnum)) {
    return;
  }

  var6 = self.targetmarkergroup;

  if(!isDefined(var6)) {
    return;
  }

  var5.beingmarked = 1;
  self.markingtarget = 1;
  self.owner notify("marking_target");
  self.owner setclientomnvar("ui_rcd_controls", 2);
  var7 = scripts\cp_mp\killstreaks\helper_drone::getmarkingdelay(var0);

  while(var7 > 0) {
    if(!isDefined(var0)) {
      return;
    }

    if(!var4 scripts\cp_mp\killstreaks\helper_drone::helperdrone_istargetinreticle(var0, 70, 40)) {
      var5.beingmarked = undefined;
      self.markingtarget = undefined;
      self.owner setclientomnvar("ui_rcd_controls", 1);
      return;
    }

    var7 -= 0.05;
    wait 0.05;
  }

  var5.reconmarked = 1;
  self.markingtarget = undefined;
  scripts\cp_mp\killstreaks\helper_drone::markent(var5, 30);
  self.owner setclientomnvar("ui_rcd_controls", 4);
  scripts\cp_mp\killstreaks\helper_drone::ref_131c9(var6, var0, 2);
  scripts\cp_mp\killstreaks\helper_drone::addmarkpoints(var0, var1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pers", "incPersStat")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("pers", "incPersStat")]]("reconDroneMarks", 1);
  }

  self.usedcount++;

  if(!isDefined(self.ref_1406b)) {
    self.ref_1406b = 0;
  }

  if(isalive(var0) && isDefined(var0.ridingvehicle)) {
    self.ref_1406b++;
  }

  var8 = 35;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_improved_target_mark")) {
      var8 += 2;
    }
  }

  thread ref_13f20(var5);
  scripts\cp_mp\killstreaks\helper_drone::waituntilunmarked(var5, var8);
}

function ref_13f20(var0) {
  var1 = var0.target;
  var1 waittill("death");
  scripts\cp_mp\killstreaks\helper_drone::unmark(var0);
}

function get_mark_target_array() {
  return level.spawned_enemies;
}

function get_outer_reticle_targets(var0) {
  var1 = 3000;
  var2 = var1 * var1;
  var3 = [];
  var4 = cos(70);

  foreach(var6 in level.spawned_enemies) {
    if(distancesquared(self.origin, var6.origin) < var2) {
      if(scripts\engine\utility::within_fov(self.origin, self.angles, var6.origin, var4)) {
        var3 = var6;
      }
    }
  }

  return var3;
}

function markent_watchmarkingentstatus_cp(var0) {}