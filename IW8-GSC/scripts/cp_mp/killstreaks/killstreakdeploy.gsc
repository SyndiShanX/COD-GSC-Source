/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\killstreakdeploy.gsc
**********************************************************/

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0.pers["startedMapSelect"])) {
      var_0.pers["startedMapSelect"] = 0;
    }
  }
}

function candeploykillstreak(var_0, var_1) {
  if(!scripts\cp_mp\utility\killstreak_utility::killstreakcanbeusedatroundstart(var_0.streakname)) {
    if(isDefined(level.killstreakrounddelay) && level.killstreakrounddelay > 0) {
      if(level.graceperiod - level.ingraceperiod < level.killstreakrounddelay) {
        var_2 = level.killstreakrounddelay - level.graceperiod - level.ingraceperiod;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/UNAVAILABLE_FOR_N", var_2);
        }

        return false;
      }
    }
  }

  if(isDefined(var_2)) {
    var_3 = candeploykillstreakweapon(var_1, var_2);

    if(isDefined(var_3)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var_3);
      }

      return false;
    }
  }

  return true;
}

function ondeploystart(var_0) {
  var_0.isdeploying = 1;
  var_0.owner.isdeploying = 1;
  var_0.owner scripts\common\utility::allow_crate_use(0);
  var_0.owner scripts\common\utility::brjugg_droponplayerdeath(0);
}

function ondeployfinished(var_0, var_1) {
  var_0.isdeploying = 0;
  var_0.owner.isdeploying = 0;
  var_0.owner scripts\common\utility::allow_crate_use(1);
  var_0.owner scripts\common\utility::brjugg_droponplayerdeath(1);
}

function streakdeploy_cancelalldeployments() {
  self notify("cancel_all_killstreak_deployments");
}

function streakdeploy_dogesturedeploy(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");

  if(!candeploykillstreak(var_0, var_1)) {
    return 0;
  }

  ondeploystart(var_0);
  thread watchforcancelduringgesture(var_0, var_1);
  var_2 = streakdeploy_giveandfireoffhandreliable(var_1);
  var_0 notify("gesture_deploy_ended");
  ondeployfinished(var_0, var_2);

  if(istrue(self.inlaststand)) {
    thread ref_144e2(var_1);
  }

  return var_2;
}

function watchforcancelduringgesture(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var_0 endon("gesture_deploy_ended");
  self waittill("cancel_all_killstreak_deployments");
  self takeweapon(var_1);
}

function ref_144e2(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self waittill("last_stand_finished");
  self takeweapon(var_0);
}

function streakdeploy_doweaponswitchdeploy(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!candeploykillstreak(var_0, var_1)) {
    return false;
  }

  ondeploystart(var_0);
  var_7 = scripts\engine\utility::ter_op(istrue(var_2), &waituntilfinishedwithdeployweapon, undefined);
  var_8 = switchtodeployweapon(var_1, var_0, var_7, var_3, var_4, var_5, var_6);

  if(!istrue(var_8)) {
    ondeployfinished(var_0, 0);
    return false;
  }

  ondeployfinished(var_0, var_8);
  return true;
}

function streakdeploy_doweaponfireddeploy(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  self endon("disconnect");

  if(!candeploykillstreak(var_0, var_1)) {
    return false;
  }

  ondeploystart(var_0);
  var_8 = switchtodeployweapon(var_1, var_0, &waituntilfinishedwithdeployweapon, var_3, var_4, var_6, var_7);

  if(!istrue(var_8)) {
    ondeployfinished(var_0, 0);
    return false;
  }

  scripts\common\utility::allow_offhand_weapons(0);
  var_9 = watchdeployweaponfired(var_0, var_2, var_1, var_5);
  scripts\common\utility::allow_offhand_weapons(1);
  ondeployfinished(var_0, var_9);
  return istrue(var_9);
}

function streakdeploy_doweapontabletdeploy(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(var_7)) {
    var_7 = &waituntilfinishedwithdeployweapon;
  }

  var_8 = "ks_remote_device_mp";

  if(isDefined(var_5)) {
    var_8 = var_5;
  }

  var_9 = getcompleteweaponname(var_8);
  var_10 = 1.6;

  if(var_8 == "ks_remote_nuke_mp") {
    var_10 = 2.133;
  }

  if(!candeploykillstreak(var_0, var_9)) {
    return false;
  }

  ondeploystart(var_0);
  thread ref_13912(var_0);
  scripts\cp_mp\utility\killstreak_utility::starttabletscreen(var_0.streakname, 0.75);
  scripts\common\utility::allow_movement(0);
  scripts\common\utility::allow_jump(0);
  scripts\common\utility::allow_usability(0);
  scripts\common\utility::allow_melee(0);
  scripts\common\utility::allow_offhand_weapons(0);
  var_11 = switchtodeployweapon(var_9, var_0, var_7, var_1, var_2, var_3, var_4);

  if(isDefined(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::allow_movement(1);
    scripts\common\utility::allow_jump(1);
    scripts\common\utility::allow_usability(1);
    scripts\common\utility::allow_melee(1);
    scripts\common\utility::allow_offhand_weapons(1);
  }

  if(!istrue(var_11)) {
    ondeployfinished(var_0, 0);

    if(isDefined(self)) {
      scripts\cp_mp\utility\killstreak_utility::stoptabletscreen(0, 1);
    }

    return false;
  }

  var_12 = watchdeployweaponanimtransition(var_0, var_10, var_6);
  ondeployfinished(var_0, var_12);
  return istrue(var_12);
}

function ref_13912(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    return;
  }
}

function streakdeploy_dothrowbackmarkerdeploy(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("game_ended");
  self endon("disconnect");
  var_7 = "throwback_marker_mp";

  if(isDefined(var_1)) {
    var_7 = var_1;
  }

  var_0.deployweaponobj = getcompleteweaponname(var_7);
  var_8 = var_0.deployweaponobj;

  if(!candeploykillstreak(var_0, var_8)) {
    return false;
  }

  ondeploystart(var_0);
  var_9 = switchtodeployweapon(var_8, var_0, &waituntilfinishedwithdeployweapon, var_2, var_3, var_5, var_6);

  if(!istrue(var_9)) {
    ondeployfinished(var_0, 0);
    return false;
  }

  var_10 = watchdeployweaponfired(var_0, "grenade_fire", var_8, var_4);
  ondeployfinished(var_0, var_10);
  return istrue(var_10);
}

function switchtodeployweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(self hasweapon(var_0)) {
    return 0;
  }

  if(level.gametype != "br") {
    if(createheadicon(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
      self notify("switched_from_minigun");

      while(createheadicon(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
        waitframe();
      }
    }
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, 0, 0, var_7);
  var_8 = callweapongivencallback(var_1, var_3);

  if(!istrue(var_8)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    return 0;
  }

  thread watchforcancelduringweaponswitch(var_1, var_0);
  thread watchformeleeduringweaponswitch(var_1, var_0);
  var_9 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0);
  var_1 notify("deploy_weapon_switch_ended");

  if(isDefined(var_4)) {
    self thread[[var_4]](var_1, var_9);
  }

  waitframe();

  if(!var_9) {
    var_2 = undefined;
  }

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  thread cleanupdeployweapon(var_9, var_1, var_0, var_2, var_5, var_6);
  return var_9;
}

function callweapongivencallback(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("cancel_all_killstreak_deployments");

  if(isDefined(var_1)) {
    return self[[var_1]](var_0);
  }

  return 1;
}

function watchforcancelduringweaponswitch(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var_0 endon("deploy_weapon_switch_ended");
  self waittill("cancel_all_killstreak_deployments");

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_1)) {
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_1);
    return;
  }
}

function watchformeleeduringweaponswitch(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var_0 endon("deploy_weapon_switch_ended");
  self waittill("melee_swipe_start");

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_1)) {
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_1);
    return;
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
  thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.lastdroppableweaponobj);
}

function watchdeployweaponfired(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("weapon_change");
  self endon("cancel_all_killstreak_deployments");

  for(;;) {
    var_4 = undefined;
    var_5 = undefined;

    switch (var_1) {
      case "weapon_fired":
        self waittill(var_1, var_4);
        break;
      case "offhand_fired":
        self waittill(var_1, var_4);
        break;
      case "grenade_fire":
        self waittill(var_1, var_5, var_4);
        break;
      default:
        self waittill(var_1);
        break;
    }

    if(var_4 == var_2) {
      if(isDefined(var_3)) {
        var_6 = [[var_3]](var_0, var_4, var_5);

        if(!isDefined(var_6)) {
          return false;
        } else if(var_6 == "failure") {
          return false;
        } else if(var_6 == "continue") {
          if(isDefined(level.votes)) {
            [[level.votes]]();
          }

          continue;
        } else if(var_6 == "success") {
          return true;
        } else {
          return false;
        }
      }

      return true;
    }
  }

  return false;
}

function watchdeployweaponanimtransition(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = "mp_killstreak_tablet_gear";

  switch (var_0.streakname) {
    case "nuke":
      var_3 = "mp_killstreak_nuke_tablet";
      break;
    case "chopper_gunner":
      var_3 = "iw8_chopper_gunner_tablet";
      break;
    case "cruise_predator":
      var_3 = "iw8_cruise_missile_tablet";
      break;
    case "gunship":
      var_3 = "iw8_gunship_tablet";
      break;
    case "pac_sentry":
      var_3 = "iw8_wheelson_tablet";
      break;
  }

  self playlocalsound(var_3);
  scripts\cp_mp\utility\player_utility::setusingremote(var_0.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "objectiveUnPinPlayer") && isDefined(self.pinnedobjid)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "objectiveUnPinPlayer")]](self.pinnedobjid, self);
    self.remoteunpinned = 1;
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "killstreakDeploy");
  thread unfreezecontrolsonroundend();

  if(istrue(var_2)) {
    thread startweapontabletfadetransition(var_1 - 0.3);
  }

  thread watchweapontabletstop(var_0);
  thread watchweapontabletcallinpos();
  var_4 = scripts\engine\utility::ref_143bb(var_1, "death", "weapon_change", "cancel_all_killstreak_deployments");
  self notify("ks_freeze_end");
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "killstreakDeploy");

  if(!isDefined(var_4) || var_4 != "timeout" || !self isonground() || self isonladder()) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
    self stoplocalsound("mp_killstreak_tablet_gear");
    self notify("cancel_remote_sequence");
    return false;
  }

  self notify("deploy_weapon_anim_successful");
  return true;
}

function unfreezecontrolsonroundend() {
  self endon("disconnect");
  self endon("ks_freeze_end");
  level waittill("round_switch");
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "killstreakDeploy");
}

function startweapontabletfadetransition(var_0) {
  self endon("disconnect");
  var_1 = scripts\engine\utility::ref_143b9(var_0, "cancel_remote_sequence");

  if(!isDefined(var_1) || var_1 == "cancel_remote_sequence") {
    return;
  }

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self playlocalsound("mp_killstreak_transition_whoosh");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.3);
    var_1 = scripts\engine\utility::ref_143b9(0.7, "death");

    if(!isDefined(var_1) || var_1 == "death") {
      self stoplocalsound("mp_killstreak_transition_whoosh");
    }

    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.3);
    return;
  }
}

function watchweapontabletstop(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 waittill("killstreak_finished_with_deploy_weapon");
  scripts\cp_mp\utility\killstreak_utility::stoptabletscreen(0.325);
  scripts\cp_mp\utility\player_utility::clearusingremote();
}

function watchweapontabletcallinpos() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("deploy_weapon_anim_successful");
  self endon("cancel_remote_sequence");

  for(;;) {
    if(!self isonground()) {
      streakdeploy_cancelalldeployments();
      break;
    }

    waitframe();
  }
}

function waituntilfinishedwithdeployweapon(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  scripts\engine\utility::waittill_any_ents(var_0, "killstreak_finished_with_deploy_weapon", self, "cancel_all_killstreak_deployments", self, "weapon_change");
}

function cleanupdeployweapon(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(isDefined(var_3)) {
    self[[var_3]](var_1);
  }

  if(self hasweapon(var_2)) {
    var_6 = scripts\cp_mp\utility\killstreak_utility::use_contract(var_2.basename);
    var_7 = scripts\cp_mp\utility\killstreak_utility::ismapselectkillstreak(var_1.streakname);
    scripts\common\utility::allow_melee(0);
    scripts\common\utility::allow_offhand_weapons(0);
    scripts\common\utility::brjugg_droponplayerdeath(0);

    if(var_6) {
      scripts\common\utility::allow_mantle(0);
      scripts\common\utility::allow_movement(0);
      scripts\cp_mp\utility\player_utility::_freezelookcontrols(1);
    } else if(istrue(var_7)) {
      scripts\common\utility::allow_mantle(0);
    }

    if(isDefined(var_4)) {
      self[[var_4]](var_1, var_0, var_2);
    } else {
      rocket_fuel(var_2);
    }

    scripts\common\utility::allow_melee(1);
    scripts\common\utility::allow_offhand_weapons(1);
    scripts\common\utility::brjugg_droponplayerdeath(1);

    if(var_6) {
      scripts\common\utility::allow_mantle(1);
      scripts\common\utility::allow_movement(1);
      scripts\cp_mp\utility\player_utility::_freezelookcontrols(0);
    } else if(istrue(var_7)) {
      scripts\common\utility::allow_mantle(1);
    }
  }

  if(isDefined(var_5)) {
    self[[var_5]](var_1);
    return;
  }
}

function rocket_fuel(var_0) {
  scripts\cp_mp\utility\inventory_utility::getridofweapon(var_0);
  var_1 = self getcurrentweapon();

  if(var_1.basename == "none") {
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    return;
  }
}

function candeploykillstreakweapon(var_0, var_1) {
  if(self hasweapon(var_1)) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }

  if(self isonladder()) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }

  if(self ismantling()) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }

  if(!scripts\common\utility::is_weapon_switch_allowed()) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }

  if(istrue(self.alreadytouchingtrigger)) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }

  if((scripts\cp_mp\utility\killstreak_utility::isridekillstreak(var_0.streakname) || scripts\cp_mp\utility\killstreak_utility::ismapselectkillstreak(var_0.streakname)) && !self isonground()) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }

  if(scripts\cp_mp\utility\player_utility::isusingremote()) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }
}

function streakdeploy_giveandfireoffhandreliable(var_0) {
  self endon("death");
  self endon("disconnect");
  self giveandfireoffhand(var_0);

  if(!self hasweapon(var_0)) {
    self notify("giveAndFireOffhandReliableFailed", var_0);
    return false;
  }

  var_1 = spawnStruct();
  GscBinSkip4(0x6e, var_1, self, var_0);
}

function streakdeploy_watchgiveandfireoffhandreliablesuccess(var_0, var_1) {
  self endon("race_end");
  var_0 waittillmatch("offhand_fired", var_1);
  self.success = 1;
  self notify("race_start");
}

function streakdeploy_watchgiveandfireoffhandreliablefailure(var_0, var_1) {
  self endon("race_end");

  while(var_0 hasweapon(var_1)) {
    waitframe();
  }

  self.failure = 1;
  self notify("race_start");
}