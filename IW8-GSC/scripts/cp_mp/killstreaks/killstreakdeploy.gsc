/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\killstreakdeploy.gsc
**********************************************************/

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);

    if(!isDefined(var0.pers["startedMapSelect"])) {
      var0.pers["startedMapSelect"] = 0;
    }
  }
}

function candeploykillstreak(var0, var1) {
  if(!scripts\cp_mp\utility\killstreak_utility::killstreakcanbeusedatroundstart(var0.streakname)) {
    if(isDefined(level.killstreakrounddelay) && level.killstreakrounddelay > 0) {
      if(level.graceperiod - level.ingraceperiod < level.killstreakrounddelay) {
        var2 = level.killstreakrounddelay - level.graceperiod - level.ingraceperiod;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/UNAVAILABLE_FOR_N", var2);
        }

        return false;
      }
    }
  }

  if(isDefined(var2)) {
    var3 = candeploykillstreakweapon(var1, var2);

    if(isDefined(var3)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var3);
      }

      return false;
    }
  }

  return true;
}

function ondeploystart(var0) {
  var0.isdeploying = 1;
  var0.owner.isdeploying = 1;
  var0.owner scripts\common\utility::allow_crate_use(0);
  var0.owner scripts\common\utility::brjugg_droponplayerdeath(0);
}

function ondeployfinished(var0, var1) {
  var0.isdeploying = 0;
  var0.owner.isdeploying = 0;
  var0.owner scripts\common\utility::allow_crate_use(1);
  var0.owner scripts\common\utility::brjugg_droponplayerdeath(1);
}

function streakdeploy_cancelalldeployments() {
  self notify("cancel_all_killstreak_deployments");
}

function streakdeploy_dogesturedeploy(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");

  if(!candeploykillstreak(var0, var1)) {
    return 0;
  }

  ondeploystart(var0);
  thread watchforcancelduringgesture(var0, var1);
  var2 = streakdeploy_giveandfireoffhandreliable(var1);
  var0 notify("gesture_deploy_ended");
  ondeployfinished(var0, var2);

  if(istrue(self.inlaststand)) {
    thread ref_144e2(var1);
  }

  return var2;
}

function watchforcancelduringgesture(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var0 endon("gesture_deploy_ended");
  self waittill("cancel_all_killstreak_deployments");
  self takeweapon(var1);
}

function ref_144e2(var0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self waittill("last_stand_finished");
  self takeweapon(var0);
}

function streakdeploy_doweaponswitchdeploy(var0, var1, var2, var3, var4, var5, var6) {
  if(!candeploykillstreak(var0, var1)) {
    return false;
  }

  ondeploystart(var0);
  var7 = scripts\engine\utility::ter_op(istrue(var2), &waituntilfinishedwithdeployweapon, undefined);
  var8 = switchtodeployweapon(var1, var0, var7, var3, var4, var5, var6);

  if(!istrue(var8)) {
    ondeployfinished(var0, 0);
    return false;
  }

  ondeployfinished(var0, var8);
  return true;
}

function streakdeploy_doweaponfireddeploy(var0, var1, var2, var3, var4, var5, var6, var7) {
  level endon("game_ended");
  self endon("disconnect");

  if(!candeploykillstreak(var0, var1)) {
    return false;
  }

  ondeploystart(var0);
  var8 = switchtodeployweapon(var1, var0, &waituntilfinishedwithdeployweapon, var3, var4, var6, var7);

  if(!istrue(var8)) {
    ondeployfinished(var0, 0);
    return false;
  }

  scripts\common\utility::allow_offhand_weapons(0);
  var9 = watchdeployweaponfired(var0, var2, var1, var5);
  scripts\common\utility::allow_offhand_weapons(1);
  ondeployfinished(var0, var9);
  return istrue(var9);
}

function streakdeploy_doweapontabletdeploy(var0, var1, var2, var3, var4, var5, var6, var7) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(var7)) {
    var7 = &waituntilfinishedwithdeployweapon;
  }

  var8 = "ks_remote_device_mp";

  if(isDefined(var5)) {
    var8 = var5;
  }

  var9 = getcompleteweaponname(var8);
  var10 = 1.6;

  if(var8 == "ks_remote_nuke_mp") {
    var10 = 2.133;
  }

  if(!candeploykillstreak(var0, var9)) {
    return false;
  }

  ondeploystart(var0);
  thread ref_13912(var0);
  scripts\cp_mp\utility\killstreak_utility::starttabletscreen(var0.streakname, 0.75);
  scripts\common\utility::allow_movement(0);
  scripts\common\utility::allow_jump(0);
  scripts\common\utility::allow_usability(0);
  scripts\common\utility::allow_melee(0);
  scripts\common\utility::allow_offhand_weapons(0);
  var11 = switchtodeployweapon(var9, var0, var7, var1, var2, var3, var4);

  if(isDefined(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::allow_movement(1);
    scripts\common\utility::allow_jump(1);
    scripts\common\utility::allow_usability(1);
    scripts\common\utility::allow_melee(1);
    scripts\common\utility::allow_offhand_weapons(1);
  }

  if(!istrue(var11)) {
    ondeployfinished(var0, 0);

    if(isDefined(self)) {
      scripts\cp_mp\utility\killstreak_utility::stoptabletscreen(0, 1);
    }

    return false;
  }

  var12 = watchdeployweaponanimtransition(var0, var10, var6);
  ondeployfinished(var0, var12);
  return istrue(var12);
}

function ref_13912(var0) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var0.streakname);
    return;
  }
}

function streakdeploy_dothrowbackmarkerdeploy(var0, var1, var2, var3, var4, var5, var6) {
  level endon("game_ended");
  self endon("disconnect");
  var7 = "throwback_marker_mp";

  if(isDefined(var1)) {
    var7 = var1;
  }

  var0.deployweaponobj = getcompleteweaponname(var7);
  var8 = var0.deployweaponobj;

  if(!candeploykillstreak(var0, var8)) {
    return false;
  }

  ondeploystart(var0);
  var9 = switchtodeployweapon(var8, var0, &waituntilfinishedwithdeployweapon, var2, var3, var5, var6);

  if(!istrue(var9)) {
    ondeployfinished(var0, 0);
    return false;
  }

  var10 = watchdeployweaponfired(var0, "grenade_fire", var8, var4);
  ondeployfinished(var0, var10);
  return istrue(var10);
}

function switchtodeployweapon(var0, var1, var2, var3, var4, var5, var6, var7) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(self hasweapon(var0)) {
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

  if(!isDefined(var7)) {
    var7 = 1;
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(var0, 0, 0, var7);
  var8 = callweapongivencallback(var1, var3);

  if(!istrue(var8)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var0);
    return 0;
  }

  thread watchforcancelduringweaponswitch(var1, var0);
  thread watchformeleeduringweaponswitch(var1, var0);
  var9 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var0);
  var1 notify("deploy_weapon_switch_ended");

  if(isDefined(var4)) {
    self thread[[var4]](var1, var9);
  }

  waitframe();

  if(!var9) {
    var2 = undefined;
  }

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  thread cleanupdeployweapon(var9, var1, var0, var2, var5, var6);
  return var9;
}

function callweapongivencallback(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("cancel_all_killstreak_deployments");

  if(isDefined(var1)) {
    return self[[var1]](var0);
  }

  return 1;
}

function watchforcancelduringweaponswitch(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var0 endon("deploy_weapon_switch_ended");
  self waittill("cancel_all_killstreak_deployments");

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var1)) {
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var1);
    return;
  }
}

function watchformeleeduringweaponswitch(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var0 endon("deploy_weapon_switch_ended");
  self waittill("melee_swipe_start");

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var1)) {
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var1);
    return;
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var1);
  thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.lastdroppableweaponobj);
}

function watchdeployweaponfired(var0, var1, var2, var3) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("weapon_change");
  self endon("cancel_all_killstreak_deployments");

  for(;;) {
    var4 = undefined;
    var5 = undefined;

    switch (var1) {
      case "weapon_fired":
        self waittill(var1, var4);
        break;
      case "offhand_fired":
        self waittill(var1, var4);
        break;
      case "grenade_fire":
        self waittill(var1, var5, var4);
        break;
      default:
        self waittill(var1);
        break;
    }

    if(var4 == var2) {
      if(isDefined(var3)) {
        var6 = [[var3]](var0, var4, var5);

        if(!isDefined(var6)) {
          return false;
        } else if(var6 == "failure") {
          return false;
        } else if(var6 == "continue") {
          if(isDefined(level.votes)) {
            [[level.votes]]();
          }

          continue;
        } else if(var6 == "success") {
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

function watchdeployweaponanimtransition(var0, var1, var2) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(var2)) {
    var2 = 1;
  }

  var3 = "mp_killstreak_tablet_gear";

  switch (var0.streakname) {
    case "nuke":
      var3 = "mp_killstreak_nuke_tablet";
      break;
    case "chopper_gunner":
      var3 = "iw8_chopper_gunner_tablet";
      break;
    case "cruise_predator":
      var3 = "iw8_cruise_missile_tablet";
      break;
    case "gunship":
      var3 = "iw8_gunship_tablet";
      break;
    case "pac_sentry":
      var3 = "iw8_wheelson_tablet";
      break;
  }

  self playlocalsound(var3);
  scripts\cp_mp\utility\player_utility::setusingremote(var0.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "objectiveUnPinPlayer") && isDefined(self.pinnedobjid)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "objectiveUnPinPlayer")]](self.pinnedobjid, self);
    self.remoteunpinned = 1;
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "killstreakDeploy");
  thread unfreezecontrolsonroundend();

  if(istrue(var2)) {
    thread startweapontabletfadetransition(var1 - 0.3);
  }

  thread watchweapontabletstop(var0);
  thread watchweapontabletcallinpos();
  var4 = scripts\engine\utility::ref_143bb(var1, "death", "weapon_change", "cancel_all_killstreak_deployments");
  self notify("ks_freeze_end");
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "killstreakDeploy");

  if(!isDefined(var4) || var4 != "timeout" || !self isonground() || self isonladder()) {
    var0 notify("killstreak_finished_with_deploy_weapon");
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

function startweapontabletfadetransition(var0) {
  self endon("disconnect");
  var1 = scripts\engine\utility::ref_143b9(var0, "cancel_remote_sequence");

  if(!isDefined(var1) || var1 == "cancel_remote_sequence") {
    return;
  }

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self playlocalsound("mp_killstreak_transition_whoosh");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.3);
    var1 = scripts\engine\utility::ref_143b9(0.7, "death");

    if(!isDefined(var1) || var1 == "death") {
      self stoplocalsound("mp_killstreak_transition_whoosh");
    }

    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.3);
    return;
  }
}

function watchweapontabletstop(var0) {
  level endon("game_ended");
  self endon("disconnect");
  var0 waittill("killstreak_finished_with_deploy_weapon");
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

function waituntilfinishedwithdeployweapon(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  scripts\engine\utility::waittill_any_ents(var0, "killstreak_finished_with_deploy_weapon", self, "cancel_all_killstreak_deployments", self, "weapon_change");
}

function cleanupdeployweapon(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(isDefined(var3)) {
    self[[var3]](var1);
  }

  if(self hasweapon(var2)) {
    var6 = scripts\cp_mp\utility\killstreak_utility::use_contract(var2.basename);
    var7 = scripts\cp_mp\utility\killstreak_utility::ismapselectkillstreak(var1.streakname);
    scripts\common\utility::allow_melee(0);
    scripts\common\utility::allow_offhand_weapons(0);
    scripts\common\utility::brjugg_droponplayerdeath(0);

    if(var6) {
      scripts\common\utility::allow_mantle(0);
      scripts\common\utility::allow_movement(0);
      scripts\cp_mp\utility\player_utility::_freezelookcontrols(1);
    } else if(istrue(var7)) {
      scripts\common\utility::allow_mantle(0);
    }

    if(isDefined(var4)) {
      self[[var4]](var1, var0, var2);
    } else {
      rocket_fuel(var2);
    }

    scripts\common\utility::allow_melee(1);
    scripts\common\utility::allow_offhand_weapons(1);
    scripts\common\utility::brjugg_droponplayerdeath(1);

    if(var6) {
      scripts\common\utility::allow_mantle(1);
      scripts\common\utility::allow_movement(1);
      scripts\cp_mp\utility\player_utility::_freezelookcontrols(0);
    } else if(istrue(var7)) {
      scripts\common\utility::allow_mantle(1);
    }
  }

  if(isDefined(var5)) {
    self[[var5]](var1);
    return;
  }
}

function rocket_fuel(var0) {
  scripts\cp_mp\utility\inventory_utility::getridofweapon(var0);
  var1 = self getcurrentweapon();

  if(var1.basename == "none") {
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    return;
  }
}

function candeploykillstreakweapon(var0, var1) {
  if(self hasweapon(var1)) {
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

  if((scripts\cp_mp\utility\killstreak_utility::isridekillstreak(var0.streakname) || scripts\cp_mp\utility\killstreak_utility::ismapselectkillstreak(var0.streakname)) && !self isonground()) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }

  if(scripts\cp_mp\utility\player_utility::isusingremote()) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }
}

function streakdeploy_giveandfireoffhandreliable(var0) {
  self endon("death");
  self endon("disconnect");
  self giveandfireoffhand(var0);

  if(!self hasweapon(var0)) {
    self notify("giveAndFireOffhandReliableFailed", var0);
    return false;
  }

  var1 = spawnStruct();
  GscBinSkip4(0x6e, var1, self, var0);
}

function streakdeploy_watchgiveandfireoffhandreliablesuccess(var0, var1) {
  self endon("race_end");
  var0 waittillmatch("offhand_fired", var1);
  self.success = 1;
  self notify("race_start");
}

function streakdeploy_watchgiveandfireoffhandreliablefailure(var0, var1) {
  self endon("race_end");

  while(var0 hasweapon(var1)) {
    waitframe();
  }

  self.failure = 1;
  self notify("race_start");
}