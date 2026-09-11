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
  var_0 = getarraykeys(level.helperdronesettings);

  foreach(var_2 in var_0) {
    var_3 = level.helperdronesettings[var_2].hitstokill;

    if(isDefined(var_3)) {
      scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data(var_2, var_3);
      scripts\cp\vehicles\damage_cp::set_weapon_hit_damage_data_for_vehicle("emp_grenade_mp", var_3, var_2);
    }
  }
}

function get_mark_ui_duration() {
  return 30;
}

function helperdrone_markplayers_cp(var_0) {
  var_1 = self.owner;
  var_1 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  for(;;) {
    var_2 = get_mark_target_array();

    foreach(var_4 in var_2) {
      if(!isDefined(var_4)) {
        continue;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var_4)) {
          continue;
        }
      }

      if(var_4 == var_1) {
        continue;
      }

      if(level.teambased && var_4.team == var_1.team) {
        continue;
      }

      if(scripts\cp_mp\killstreaks\helper_drone::isbeingmarked(var_4)) {
        continue;
      }

      if(scripts\cp_mp\killstreaks\helper_drone::isreconmarked(var_4)) {
        continue;
      }

      scripts\cp_mp\killstreaks\helper_drone::ref_131c9(self.targetmarkergroup, var_4, 0);

      if(!scripts\cp_mp\killstreaks\helper_drone::isinmarkingrange(var_4)) {
        continue;
      }

      if(!scripts\cp_mp\killstreaks\helper_drone::canseetarget(var_4)) {
        continue;
      }

      scripts\cp_mp\killstreaks\helper_drone::ref_131c9(self.targetmarkergroup, var_4, 1);

      if(istrue(self.markingtarget)) {
        continue;
      }

      if(var_1 scripts\cp_mp\killstreaks\helper_drone::helperdrone_istargetinreticle(var_4, 70, 40)) {
        thread startmarkingtarget_cp(var_4, "enemy", 0, 1);
      }
    }

    waitframe();
  }
}

function startmarkingtarget_cp(var_0, var_1, var_2, var_3) {
  var_4 = self.owner;
  var_4 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var_5 = spawnStruct();
  var_5.target = var_0;
  var_5.targetnum = var_0 getentitynumber();
  var_5.markingent = self;
  var_5.ownerteam = var_4.team;
  var_5.outlineid = undefined;
  var_5.headicon = undefined;
  var_5.beingmarked = undefined;
  var_5.reconmarked = undefined;
  var_5.notifytoendmark = "unmarked_" + var_5.targetnum;

  if(!isDefined(var_5.targetnum)) {
    return;
  }

  var_6 = self.targetmarkergroup;

  if(!isDefined(var_6)) {
    return;
  }

  var_5.beingmarked = 1;
  self.markingtarget = 1;
  self.owner notify("marking_target");
  self.owner setclientomnvar("ui_rcd_controls", 2);
  var_7 = scripts\cp_mp\killstreaks\helper_drone::getmarkingdelay(var_0);

  while(var_7 > 0) {
    if(!isDefined(var_0)) {
      return;
    }

    if(!var_4 scripts\cp_mp\killstreaks\helper_drone::helperdrone_istargetinreticle(var_0, 70, 40)) {
      var_5.beingmarked = undefined;
      self.markingtarget = undefined;
      self.owner setclientomnvar("ui_rcd_controls", 1);
      return;
    }

    var_7 -= 0.05;
    wait 0.05;
  }

  var_5.reconmarked = 1;
  self.markingtarget = undefined;
  scripts\cp_mp\killstreaks\helper_drone::markent(var_5, 30);
  self.owner setclientomnvar("ui_rcd_controls", 4);
  scripts\cp_mp\killstreaks\helper_drone::ref_131c9(var_6, var_0, 2);
  scripts\cp_mp\killstreaks\helper_drone::addmarkpoints(var_0, var_1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pers", "incPersStat")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("pers", "incPersStat")]]("reconDroneMarks", 1);
  }

  self.usedcount++;

  if(!isDefined(self.ref_1406b)) {
    self.ref_1406b = 0;
  }

  if(isalive(var_0) && isDefined(var_0.ridingvehicle)) {
    self.ref_1406b++;
  }

  var_8 = 35;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_improved_target_mark")) {
      var_8 += 2;
    }
  }

  thread ref_13f20(var_5);
  scripts\cp_mp\killstreaks\helper_drone::waituntilunmarked(var_5, var_8);
}

function ref_13f20(var_0) {
  var_1 = var_0.target;
  var_1 waittill("death");
  scripts\cp_mp\killstreaks\helper_drone::unmark(var_0);
}

function get_mark_target_array() {
  return level.spawned_enemies;
}

function get_outer_reticle_targets(var_0) {
  var_1 = 3000;
  var_2 = var_1 * var_1;
  var_3 = [];
  var_4 = cos(70);

  foreach(var_6 in level.spawned_enemies) {
    if(distancesquared(self.origin, var_6.origin) < var_2) {
      if(scripts\engine\utility::within_fov(self.origin, self.angles, var_6.origin, var_4)) {
        var_3 = var_6;
      }
    }
  }

  return var_3;
}

function markent_watchmarkingentstatus_cp(var_0) {}