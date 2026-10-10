/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\killstreaks\killstreakdeploy.gsc
*************************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\superdeploy;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace killstreakdeploy;

function candeploykillstreak(streakinfo, deployweaponobj, var_818a18147626dfbf) {
  if(!isDefined(var_818a18147626dfbf)) {
    var_818a18147626dfbf = 1;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(isDefined(level.killstreakrounddelay) && level.killstreakrounddelay > 0) {
      if(isDefined(level.var_5fbdcf40b68612a5)) {
        timepassed = (gettime() - level.var_5fbdcf40b68612a5) / 1000;

        if(timepassed < level.killstreakrounddelay) {
          var_7edfff77a919e662 = int(level.killstreakrounddelay - timepassed);
          function_f3bb4f4911a1beb2("hud", "showErrorMessage", "KILLSTREAKS/UNAVAILABLE_FOR_N", var_7edfff77a919e662);
          return false;
        }
      }
    }
  } else if(!killstreakcanbeusedatroundstart(streakinfo.streakname)) {
    if(isDefined(level.killstreakrounddelay) && level.killstreakrounddelay > 0) {
      assertex(level.graceperiod >= level.killstreakrounddelay, "<dev string:x1c>" + level.graceperiod + "<dev string:x33>" + level.killstreakrounddelay);

      if(level.graceperiod - level.ingraceperiod < level.killstreakrounddelay) {
        optionalparam = level.killstreakrounddelay - level.graceperiod - level.ingraceperiod;

        if(issharedfuncdefined("hud", "showErrorMessage")) {
          self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/UNAVAILABLE_FOR_N", optionalparam);
        }

        return false;
      }
    }
  }

  if(isDefined(deployweaponobj)) {
    errormsg = candeploykillstreakweapon(streakinfo, deployweaponobj);

    if(isDefined(errormsg)) {
      if(streakinfo.streakname == "tacticalCamera" || streakinfo.streakname == "loadout_drop") {
        return false;
      }

      if(iscp() && streakinfo.streakname == "radar_drone_recon") {
        if(issharedfuncdefined("hud", "showErrorMessage") && istrue(var_818a18147626dfbf)) {
          self[[getsharedfunc("hud", "showErrorMessage")]]("MP/CANNOT_USE_GENERIC");
        }

        return false;
      }

      if(issharedfuncdefined("hud", "showErrorMessage") && istrue(var_818a18147626dfbf)) {
        self[[getsharedfunc("hud", "showErrorMessage")]](errormsg);
      }

      return false;
    }
  }

  return true;
}

function ondeploystart(streakinfo) {
  assertex(!istrue(streakinfo.isdeploying), "<dev string:x70>" + streakinfo.streakname + "<dev string:x84>");
  streakinfo.isdeploying = 1;
  streakinfo.owner.isdeploying = 1;
  streakinfo.owner setclientomnvar("ui_mobile_killstreak_is_deploying", 1);
  streakinfo.owner thread function_44d17dbe4db72ea9(streakinfo);
  streakinfo.owner val::set("deploy", "crate_use", 0);
  streakinfo.owner val::set("deploy", "ascender_use", 0);

  if(iscp()) {
    streakinfo.owner val::set("deploy", "cp_munitions_pickup", 0);
  }

  if(isDefined(level.var_88e858e641bc0e8e)) {
    thread[[level.var_88e858e641bc0e8e]](streakinfo);
  }
}

function ondeployfinished(streakinfo) {
  streakinfo.isdeploying = 0;
  streakinfo.owner.isdeploying = 0;

  if(streakinfo.streakname != "missile_drone") {
    streakinfo.owner setclientomnvar("ui_mobile_killstreak_is_deploying", 0);
  }

  streakinfo.owner val::reset_all("deploy");

  if(isDefined(level.var_bcf8ebbb820ae06d)) {
    thread[[level.var_bcf8ebbb820ae06d]](streakinfo);
  }

  switch (streakinfo.streakname) {
    case #"hash_413c38e72fe8b5bf":
      if(ismp()) {
        streakinfo.owner setsoundsubmix("jup_mp_kls_gunship", 1);
      }

      break;
    case #"hash_cf0ef5bef19a311b":
      streakinfo.owner setsoundsubmix("jup_global_kls_wheelson", 1);
      break;
    case #"hash_349713b5ad494dda":
      streakinfo.owner setsoundsubmix("jup_global_kls_chopper_gunner", 1);
      break;
  }
}

function streakdeploy_cancelalldeployments() {
  self notify("cancel_all_killstreak_deployments");
}

function streakdeploy_dogesturedeploy(streakinfo, gestureweaponobj) {
  level endon("game_ended");
  self endon("disconnect");

  if(!candeploykillstreak(streakinfo, gestureweaponobj)) {
    return 0;
  }

  assertex(isDefined(gestureweaponobj) && gestureweaponobj.basename != "<dev string:xb7>", "<dev string:xbf>" + streakinfo.streakname + "<dev string:xcf>");
  ondeploystart(streakinfo);
  thread watchforcancelduringgesture(streakinfo, gestureweaponobj);
  result = giveandfireoffhandreliable(gestureweaponobj);
  phonegesture = gestureweaponobj.basename == "ks_gesture_phone_mp";

  if(istrue(result) && istrue(phonegesture)) {
    function_36e63b8636445465(streakinfo.streakname);
  }

  streakinfo notify("gesture_deploy_ended");
  ondeployfinished(streakinfo);

  if(istrue(self.inlaststand)) {
    thread watchlaststandend(gestureweaponobj);
  }

  return result;
}

function watchforcancelduringgesture(streakinfo, gestureweaponobj) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  streakinfo endon("gesture_deploy_ended");
  self waittill("cancel_all_killstreak_deployments");
  self takeweapon(gestureweaponobj);
}

function watchlaststandend(gestureweaponobj) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self waittill("last_stand_finished");
  self takeweapon(gestureweaponobj);
}

function function_44d17dbe4db72ea9(streakinfo) {
  self endon("cancel_all_killstreak_deployments");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    self setclientomnvar("ui_mobile_killstreak_is_deploying", 0);
  }
}

function streakdeploy_doweaponswitchdeploy(streakinfo, weaponobj, keepweapon, weapongivencallback, var_8fd4d93dd619da88, var_91f739c2c51347d4, var_d55d8445518099b) {
  if(!candeploykillstreak(streakinfo, weaponobj)) {
    return false;
  }

  ondeploystart(streakinfo);
  assertex(isDefined(weaponobj) && weaponobj.basename != "<dev string:xb7>", "<dev string:xbf>" + streakinfo.streakname + "<dev string:x110>");
  cleanupwaitfunc = ter_op(istrue(keepweapon), &waituntilfinishedwithdeployweapon, undefined);
  switchresult = switchtodeployweapon(weaponobj, streakinfo, cleanupwaitfunc, weapongivencallback, var_8fd4d93dd619da88, var_91f739c2c51347d4, var_d55d8445518099b);

  if(!istrue(switchresult)) {
    ondeployfinished(streakinfo);
    return false;
  }

  ondeployfinished(streakinfo);
  return true;
}

function streakdeploy_doweaponfireddeploy(streakinfo, weaponobj, firednotify, weapongivencallback, var_8fd4d93dd619da88, weaponfiredcallback, var_91f739c2c51347d4, var_d55d8445518099b) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(!candeploykillstreak(streakinfo, weaponobj)) {
    return false;
  }

  ondeploystart(streakinfo);
  assertex(isDefined(weaponobj) && weaponobj.basename != "<dev string:xb7>", "<dev string:xbf>" + streakinfo.streakname + "<dev string:x154>");
  switchresult = switchtodeployweapon(weaponobj, streakinfo, &waituntilfinishedwithdeployweapon, weapongivencallback, var_8fd4d93dd619da88, var_91f739c2c51347d4, var_d55d8445518099b);

  if(!istrue(switchresult)) {
    ondeployfinished(streakinfo);
    return false;
  }

  if(isDefined(streakinfo) && isDefined(streakinfo.var_fb58a31c756db4cc)) {
    val::group_set(streakinfo.var_fb58a31c756db4cc, 0);
    firedresult = watchdeployweaponfired(streakinfo, firednotify, weaponobj, weaponfiredcallback);
    val::group_reset(streakinfo.var_fb58a31c756db4cc);
  } else {
    val::set("firedDeploy", "offhand_weapons", 0);
    firedresult = watchdeployweaponfired(streakinfo, firednotify, weaponobj, weaponfiredcallback);
    val::reset_all("firedDeploy");
  }

  ondeployfinished(streakinfo);
  return istrue(firedresult);
}

#using_animtree("script_model");

function streakdeploy_doweapontabletdeploy(streakinfo, weapongivencallback, var_8fd4d93dd619da88, var_91f739c2c51347d4, var_d55d8445518099b, var_f6a32dcc4b19aad9, var_67a06b4ea269058e, var_afe464c242489272, var_818a18147626dfbf, var_c2a00d4f077ebd87) {
  level endon("game_ended");
  self endon("disconnect");
  weaponbasename = "ks_remote_device_mp";

  if(isDefined(var_f6a32dcc4b19aad9)) {
    weaponbasename = var_f6a32dcc4b19aad9;
  }

  weaponobj = makeweapon(weaponbasename);
  deployanim = % vm_ks_tablet_tap_raise;
  var_a5e28eeb501a1341 = 1;

  if(weaponbasename == "ks_remote_nuke_mp") {
    deployanim = % vm_ks_tablet_tac_nuke_raise;
    var_a5e28eeb501a1341 = 0;
  } else if(weaponbasename == "ks_rcxd_remote_mp") {
    deployanim = % t10_vm_offhand_2h_rcxd_remote_in;
    var_a5e28eeb501a1341 = 0;
  }

  var_cd5c5ac9105ab0d7 = isremotekillstreaktabletweapon(weaponobj.basename);
  tabletanimlength = getanimlength(deployanim);

  if(istrue(var_a5e28eeb501a1341)) {
    tabletanimlength -= 1;
  }

  if(isDefined(var_afe464c242489272)) {
    tabletanimlength = var_afe464c242489272;
  }

  if(!candeploykillstreak(streakinfo, weaponobj, var_818a18147626dfbf)) {
    return false;
  }

  ondeploystart(streakinfo);

  if(!istrue(var_c2a00d4f077ebd87)) {
    thread streakdeploy_playtabletdeploydialog(streakinfo);
  }

  val::set("streakDeploy", "allow_movement", 0);
  val::set("streakDeploy", "allow_jump", 0);
  val::set("streakDeploy", "usability", 0);
  val::set("streakDeploy", "melee", 0);
  val::set("streakDeploy", "offhand_weapons", 0);
  val::set("streakDeploy", "supers", 0);
  val::set("streakDeploy", "killstreaks", 0);
  switchresult = switchtodeployweapon(weaponobj, streakinfo, &waituntilfinishedwithdeployweapon, weapongivencallback, var_8fd4d93dd619da88, var_91f739c2c51347d4, var_d55d8445518099b);

  if(isDefined(self) && _isalive()) {
    val::reset_all("streakDeploy");

    if(var_cd5c5ac9105ab0d7) {
      _freezelookcontrols(0);
    }
  }

  if(!istrue(switchresult)) {
    ondeployfinished(streakinfo);
    return false;
  }

  animresult = watchdeployweaponanimtransition(streakinfo, tabletanimlength, var_67a06b4ea269058e);
  ondeployfinished(streakinfo);
  return istrue(animresult);
}

function streakdeploy_playtabletdeploydialog(streakinfo) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);

  if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
  }
}

function streakdeploy_dothrowbackmarkerdeploy(streakinfo, weaponoverride, weapongivencallback, var_8fd4d93dd619da88, weaponfiredcallback, var_91f739c2c51347d4, var_d55d8445518099b) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  weapon = "throwback_marker_mp";

  if(isDefined(weaponoverride)) {
    weapon = weaponoverride;
  }

  streakinfo.deployweaponobj = makeweapon(weapon);
  weaponobj = streakinfo.deployweaponobj;

  if(!candeploykillstreak(streakinfo, weaponobj)) {
    return false;
  }

  ondeploystart(streakinfo);
  assertex(isDefined(weaponobj) && weaponobj.basename != "<dev string:xb7>", "<dev string:xbf>" + streakinfo.streakname + "<dev string:x154>");
  switchresult = switchtodeployweapon(weaponobj, streakinfo, &waituntilfinishedwithdeployweapon, weapongivencallback, var_8fd4d93dd619da88, var_91f739c2c51347d4, var_d55d8445518099b);

  if(!istrue(switchresult)) {
    ondeployfinished(streakinfo);
    return false;
  }

  firedresult = watchdeployweaponfired(streakinfo, "grenade_fire", weaponobj, weaponfiredcallback);
  ondeployfinished(streakinfo);
  return istrue(firedresult);
}

function switchtodeployweapon(deployweaponobj, streakinfo, cleanupwaitfunc, weapongivencallback, var_8fd4d93dd619da88, var_91f739c2c51347d4, var_d55d8445518099b, skipfirstraise) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(self hasweapon(deployweaponobj)) {
    return 0;
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
      self notify("switched_from_minigun");

      while(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
        waitframe();
      }
    }
  }

  if(!isDefined(skipfirstraise)) {
    skipfirstraise = 1;
  }

  _giveweapon(deployweaponobj, 0, 0, skipfirstraise);
  var_137e8ca1e47954dc = callweapongivencallback(streakinfo, weapongivencallback);

  if(!istrue(var_137e8ca1e47954dc)) {
    _takeweapon(deployweaponobj);
    return 0;
  }

  self dlog_recordplayerevent("dlog_event_killstreak_tablet", ["file_line_info", "After switchToDeployWeapon"]);
  thread watchforcancelduringweaponswitch(streakinfo, deployweaponobj);
  thread function_7605a5b4c0a6e117(streakinfo, deployweaponobj);
  switchresult = domonitoredweaponswitch(deployweaponobj, isbot(self, 1), streakinfo.var_9d7c6ee83f507a26);
  streakinfo notify("deploy_weapon_switch_ended");

  if(isDefined(var_8fd4d93dd619da88)) {
    self thread[[var_8fd4d93dd619da88]](streakinfo, switchresult);
  }

  waitframe();

  if(!istrue(switchresult)) {
    cleanupwaitfunc = undefined;
  }

  if(!_isalive()) {
    return 0;
  }

  thread cleanupdeployweapon(switchresult, streakinfo, deployweaponobj, cleanupwaitfunc, var_91f739c2c51347d4, var_d55d8445518099b);
  return switchresult;
}

function callweapongivencallback(streakinfo, weapongivencallback) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("cancel_all_killstreak_deployments");

  if(isDefined(weapongivencallback)) {
    return self[[weapongivencallback]](streakinfo);
  }

  return 1;
}

function watchforcancelduringweaponswitch(streakinfo, deployweaponobj) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  streakinfo endon("deploy_weapon_switch_ended");
  self waittill("cancel_all_killstreak_deployments");

  if(isswitchingtoweaponwithmonitoring(deployweaponobj)) {
    abortmonitoredweaponswitch(deployweaponobj);
  }
}

function function_7605a5b4c0a6e117(streakinfo, deployweaponobj) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  streakinfo endon("deploy_weapon_switch_ended");

  if(streakinfo.streakname == "") {
    self waittill("melee_swipe_start");
  } else {
    waittill_any_2("melee_swipe_start", "br_pickup_scriptable");
  }

  if(isswitchingtoweaponwithmonitoring(deployweaponobj)) {
    abortmonitoredweaponswitch(deployweaponobj);
    return;
  }

  _takeweapon(deployweaponobj);
  thread domonitoredweaponswitch(self.lastdroppableweaponobj, isbot(self));
}

function watchdeployweaponfired(streakinfo, firednotify, var_4ef1099365450bae, weaponfiredcallback) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("weapon_change");
  self endon("cancel_all_killstreak_deployments");

  while(true) {
    var_a9dd4e8c5e5c7178 = undefined;
    firedprojectile = undefined;

    switch (firednotify) {
      case #"hash_21a23ad4b32e4f8e":
        self waittill(firednotify, var_a9dd4e8c5e5c7178);
        break;
      case #"hash_77f5cb8818a754f0":
        self waittill(firednotify, var_a9dd4e8c5e5c7178);
        break;
      case #"hash_3989359e2b52d1ba":
        self waittill(firednotify, firedprojectile, var_a9dd4e8c5e5c7178);
        break;
      default:
        self waittill(firednotify);
        break;
    }

    if(var_a9dd4e8c5e5c7178 == var_4ef1099365450bae) {
      if(isDefined(weaponfiredcallback)) {
        firedresult = [[weaponfiredcallback]](streakinfo, var_a9dd4e8c5e5c7178, firedprojectile);

        if(!isDefined(firedresult)) {
          assertex(isDefined(firedresult), "<dev string:x197>");
          return false;
        } else if(firedresult == "failure") {
          return false;
        } else if(firedresult == "continue") {
          if(isDefined(level.killstreakweaponfiredcontinue)) {
            [[level.killstreakweaponfiredcontinue]]();
          }

          continue;
        } else if(firedresult == "success") {
          return true;
        } else {
          assertmsg("<dev string:x1fd>");
          return false;
        }
      }

      return true;
    }
  }

  return false;
}

function watchdeployweaponanimtransition(streakinfo, animlength, var_67a06b4ea269058e) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(var_67a06b4ea269058e)) {
    var_67a06b4ea269058e = 1;
  }

  alias = "iw9_ks_tablet_ui_sequence_plr";

  switch (streakinfo.streakname) {
    case #"hash_195360490caa3220":
    case #"hash_de3d319cd367bcba":
      alias = "mp_killstreak_mgb_tablet";
      break;
  }

  self playlocalsound(alias);
  setusingremote(streakinfo.streakname);

  if(issharedfuncdefined("game", "objectiveUnPinPlayer") && isDefined(self.pinnedobjid)) {
    [[getsharedfunc("game", "objectiveUnPinPlayer")]](self.pinnedobjid, self);
    self.remoteunpinned = 1;
  }

  _freezecontrols(1, undefined, "killstreakDeploy");
  thread unfreezecontrolsonroundend();

  if(istrue(var_67a06b4ea269058e)) {
    thread startweapontabletfadetransition(animlength - 0.3, streakinfo);
  }

  thread watchweapontabletstop(streakinfo);
  thread watchweapontabletcallinpos(streakinfo);
  starttabletscreen(streakinfo.streakname, 0.05);
  result = waittill_any_timeout_3(animlength, "death", "weapon_change", "cancel_all_killstreak_deployments");
  self notify("ks_freeze_end");
  _freezecontrols(0, undefined, "killstreakDeploy");

  if(!isDefined(result) || result != "timeout" || !self isonground() && !function_d474b372046544b0() && !issubstr(streakinfo.streakname, "nuke") || self isonladder()) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    self stoplocalsound("mp_killstreak_tablet_gear");
    stoptabletscreen(streakinfo.streakname);
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
  _freezecontrols(0, undefined, "killstreakDeploy");
}

function private startweapontabletfadetransition(timedelay, streakinfo) {
  self endon("disconnect");
  result = waittill_any_timeout_1(timedelay, "cancel_remote_sequence");

  if(!isDefined(result) || result == "cancel_remote_sequence") {
    return;
  }

  if(_isalive()) {
    if(isDefined(streakinfo) && streakinfo.streakname != "pac_sentry") {
      self playlocalsound("mp_killstreak_transition_whoosh");
    }

    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.3);
    result = waittill_any_timeout_1(0.7, "death");

    if(!isDefined(result) || result == "death") {
      self stoplocalsound("mp_killstreak_transition_whoosh");
    }

    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.3);
  }
}

function watchweapontabletstop(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  streakinfo waittill("killstreak_finished_with_deploy_weapon");

  if(isusingremote()) {
    clearusingremote();
  }

  switch (streakinfo.streakname) {
    case #"hash_413c38e72fe8b5bf":
      if(ismp()) {
        self clearsoundsubmix("jup_mp_kls_gunship", 1);
      }

      break;
    case #"hash_cf0ef5bef19a311b":
      self clearsoundsubmix("jup_global_kls_wheelson", 1);
      break;
    case #"hash_349713b5ad494dda":
      self clearsoundsubmix("jup_global_kls_chopper_gunner", 1);
      break;
  }
}

function watchweapontabletcallinpos(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("deploy_weapon_anim_successful");
  self endon("cancel_remote_sequence");

  while(true) {
    if(!self isonground()) {
      var_19b9ba70fb85a568 = 1;

      if(isswimmingunderwater()) {
        if(ismapselectkillstreak(streakinfo.streakname)) {
          var_19b9ba70fb85a568 = 0;
        }
      } else if(function_d474b372046544b0()) {
        if(isridekillstreak(streakinfo.streakname) || ismapselectkillstreak(streakinfo.streakname)) {
          var_19b9ba70fb85a568 = 0;
        }
      } else if(function_d57fb9abf76f9515(streakinfo.streakname)) {
        var_19b9ba70fb85a568 = 0;
      }

      if(istrue(var_19b9ba70fb85a568)) {
        wait 0.05;
        streakdeploy_cancelalldeployments();
        break;
      }
    }

    waitframe();
  }
}

function function_67f13db1409ec06d(streakinfo) {
  waituntilfinishedwithdeployweapon(streakinfo);
}

function private waituntilfinishedwithdeployweapon(streakinfo) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  childthread function_2bff7042844c915b(streakinfo, "killstreak_finished_with_deploy_weapon");
  childthread function_2bff7042844c915b(self, "cancel_all_killstreak_deployments");
  childthread function_2bff7042844c915b(self, "weapon_change");

  while(true) {
    self waittill("potential_killstreak_deployment_finish", result);

    if(isDefined(result) && result == "weapon_change") {
      if(isusingremote()) {
        continue;
      }
    }

    break;
  }

  self notify("killstreak_really_finished_with_deploy_weapon");
}

function private function_2bff7042844c915b(ent, finishednotify) {
  self endon("killstreak_really_finished_with_deploy_weapon");
  ent waittill(finishednotify);
  self notify("potential_killstreak_deployment_finish", finishednotify);
}

function private cleanupdeployweapon(switchresult, streakinfo, weaponobj, cleanupwaitfunc, var_91f739c2c51347d4, var_d55d8445518099b) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(isDefined(cleanupwaitfunc)) {
    self[[cleanupwaitfunc]](streakinfo);
  }

  if(self hasweapon(weaponobj)) {
    var_cd5c5ac9105ab0d7 = isremotekillstreaktabletweapon(weaponobj.basename);
    mapselectkillstreak = ismapselectkillstreak(streakinfo.streakname);
    var_d110628a2924ac08 = isDefined(streakinfo.streakname) && (streakinfo.streakname == "nuke" || streakinfo.streakname == "nuke_multi");
    val::set("deployCleanup", "melee", 0);
    val::set("deployCleanup", "offhand_weapons", 0);

    if(var_cd5c5ac9105ab0d7) {
      val::set("deployCleanup", "mantle", 0);
      val::set("deployCleanup", "allow_movement", 0);
      stoptabletscreen(streakinfo.streakname, 0.5, 1);
      _freezelookcontrols(1);
    } else if(istrue(mapselectkillstreak)) {
      val::set("deployCleanup", "mantle", 0);

      if(var_d110628a2924ac08) {
        stoptabletscreen(streakinfo.streakname);
      }
    }

    if(isDefined(var_91f739c2c51347d4)) {
      self[[var_91f739c2c51347d4]](streakinfo, switchresult, weaponobj);
    } else {
      getridofkillstreakdeployweapon(weaponobj);
    }

    val::reset_all("deployCleanup");

    if(var_cd5c5ac9105ab0d7) {
      _freezelookcontrols(0);
    }
  }

  if(isDefined(var_d55d8445518099b)) {
    self[[var_d55d8445518099b]](streakinfo);
  }
}

function getridofkillstreakdeployweapon(weaponobj) {
  getridofweapon(weaponobj, istrue(self.var_4a2f2f50a9020e2e));
  self.var_4a2f2f50a9020e2e = undefined;
  currentweapon = self getcurrentweapon();

  if(currentweapon.basename == "none") {
    forcevalidweapon();
  }
}

function private function_1a815b06ac8daec6(objweapon) {
  currentweapon = self getcurrentweapon().basename;
  killstreakweapon = objweapon.basename;

  if(isDefined(currentweapon) && function_b752eaae4d806c4c(currentweapon) && isDefined(killstreakweapon) && !function_b752eaae4d806c4c(killstreakweapon)) {
    return true;
  }

  return false;
}

function function_b752eaae4d806c4c(currentweapon) {
  switch (currentweapon) {
    case #"hash_1898ea54a0bc6404":
    case #"hash_5fee2c6097070f10":
    case #"hash_879b8ea58093f02c":
    case #"hash_e03f05f611764899":
      return true;
  }

  return false;
}

function candeploykillstreakweapon(streakinfo, objweapon) {
  if(self getcurrentweapon().basename == "none") {
    waitframe();
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && istrue(level.gameended)) {
    return function_9c92daea59d1e8cf();
  }

  if(isDefined(objweapon) && self hasweapon(objweapon)) {
    return function_9c92daea59d1e8cf();
  }

  if(isDefined(objweapon) && function_1a815b06ac8daec6(objweapon)) {
    return function_9c92daea59d1e8cf();
  }

  if(!val::get("weapon_switch") || !val::get("weapon")) {
    return function_9c92daea59d1e8cf();
  }

  if(isusingremote()) {
    return function_9c92daea59d1e8cf();
  }

  if(istrue(self.oob)) {
    return function_9c92daea59d1e8cf("oob");
  }

  if(streakinfo.streakname == "assault_drone" || streakinfo.streakname == "radar_drone_recon" || streakinfo.streakname == "pac_sentry") {
    if(istrue(self.var_8e2d666b5b0f2bd3)) {
      return function_9c92daea59d1e8cf();
    }
  }

  if(istrue(self.hashostage)) {
    return function_9c92daea59d1e8cf();
  }

  if(self isonladder()) {
    return function_9c92daea59d1e8cf();
  }

  if(self ismantling()) {
    return function_9c92daea59d1e8cf();
  }

  if(self ishanging()) {
    return function_9c92daea59d1e8cf();
  }

  if(isswimmingunderwater()) {
    if(isridekillstreak(streakinfo.streakname) || function_3c5423f8416220de(streakinfo.streakname)) {
      return function_9c92daea59d1e8cf("water");
    }
  } else if(function_d474b372046544b0()) {
    if(function_3c5423f8416220de(streakinfo.streakname)) {
      return function_9c92daea59d1e8cf("water");
    }
  }

  if(!self isonground() && !self isswimming()) {
    if(self isparachuting()) {
      return function_9c92daea59d1e8cf();
    }

    if(!function_d57fb9abf76f9515(streakinfo.streakname)) {
      return function_9c92daea59d1e8cf();
    }
  }

  currentgrenade = scripts\cp_mp\weapon::getgrenadeinpullback();

  if(isDefined(currentgrenade) && scripts\cp_mp\superdeploy::issuperweapon(currentgrenade)) {
    return function_9c92daea59d1e8cf();
  }

  if(isDefined(level.var_ec09dd198521feea) && level.var_ec09dd198521feea == 1 && isDefined(level.var_55c84262b9114f3c) && array_contains(level.var_55c84262b9114f3c, streakinfo.streakname)) {
    return function_9c92daea59d1e8cf();
  }

  if(isDefined(level.var_ec09dd198521feea) && level.var_ec09dd198521feea == 1 && isDefined(level.var_9fb437a5f1d70130) && array_contains(level.var_9fb437a5f1d70130, streakinfo.streakname)) {
    return "MP/CANNOT_USE_GENERIC";
  }

  if(isDefined(streakinfo) && streakinfo.streakname == "juggernaut" && getdvarint(@ "hash_d2d7564ba2f2f9d", 0)) {
    return function_9c92daea59d1e8cf();
  }

  if(utility::issharedfuncdefined(streakinfo.streakname, "canUseAdditionalConditions")) {
    if(!self[[utility::getsharedfunc(streakinfo.streakname, "canUseAdditionalConditions")]](streakinfo)) {
      return "KILLSTREAKS/CANNOT_BE_USED";
    }
  }
}

function function_9c92daea59d1e8cf(messagetype) {
  if(isDefined(messagetype) && messagetype == "oob") {
    return ter_op(iscp(), "EQUIPMENT/ARMAMENT_CANNOT_BE_USED_OUTOFBOUNDS", "KILLSTREAKS/CANNOT_BE_USED_OUTOFBOUNDS");
  }

  if(isDefined(messagetype) && messagetype == "water") {
    return ter_op(iscp(), "EQUIPMENT/ARMAMENT_CANNOT_BE_USED_WATER", "KILLSTREAKS/CANNOT_BE_USED_WATER");
  }

  return ter_op(iscp(), "EQUIPMENT/ARMAMENT_CANNOT_BE_USED", "KILLSTREAKS/CANNOT_BE_USED");
}