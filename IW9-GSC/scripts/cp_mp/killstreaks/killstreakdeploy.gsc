/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\killstreakdeploy.gsc
**********************************************************/

candeploykillstreak(streakinfo, deployweaponobj, _id_818A18147626DFBF) {
  if(!isDefined(_id_818A18147626DFBF))
    _id_818A18147626DFBF = 1;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(isDefined(level.killstreakrounddelay) && level.killstreakrounddelay > 0) {
      if(isDefined(level._id_5FBDCF40B68612A5)) {
        _id_3B5803E733581858 = (gettime() - level._id_5FBDCF40B68612A5) / 1000;

        if(_id_3B5803E733581858 < level.killstreakrounddelay) {
          _id_7EDFFF77A919E662 = int(level.killstreakrounddelay - _id_3B5803E733581858);
          scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("hud", "showErrorMessage", "KILLSTREAKS/UNAVAILABLE_FOR_N", _id_7EDFFF77A919E662);
          return 0;
        }
      }
    }
  } else if(!scripts\cp_mp\utility\killstreak_utility::killstreakcanbeusedatroundstart(streakinfo.streakname)) {
    if(isDefined(level.killstreakrounddelay) && level.killstreakrounddelay > 0) {
      if(level.graceperiod - level.ingraceperiod < level.killstreakrounddelay) {
        _id_D153265565DF63DA = level.killstreakrounddelay - (level.graceperiod - level.ingraceperiod);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/UNAVAILABLE_FOR_N", _id_D153265565DF63DA);

        return 0;
      }
    }
  }

  if(isDefined(deployweaponobj)) {
    _id_539576F2B677F552 = candeploykillstreakweapon(streakinfo, deployweaponobj);

    if(isDefined(_id_539576F2B677F552)) {
      if(streakinfo.streakname == "tacticalCamera" || streakinfo.streakname == "loadout_drop")
        return 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage") && istrue(_id_818A18147626DFBF))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](_id_539576F2B677F552);

      return 0;
    }
  }

  if(istrue(streakinfo.owner._id_859654E0445A36D9))
    return 0;

  return 1;
}

ondeploystart(streakinfo) {
  streakinfo.isdeploying = 1;
  streakinfo.owner.isdeploying = 1;
  streakinfo.owner setclientomnvar("ui_mobile_killstreak_is_deploying", 1);
  streakinfo.owner thread _id_44D17DBE4DB72EA9(streakinfo);
  streakinfo.owner _id_3B64EB40368C1450::set("deploy", "crate_use", 0);
  streakinfo.owner _id_3B64EB40368C1450::set("deploy", "ascender_use", 0);
}

ondeployfinished(streakinfo) {
  streakinfo.isdeploying = 0;
  streakinfo.owner.isdeploying = 0;
  streakinfo.owner setclientomnvar("ui_mobile_killstreak_is_deploying", 0);
  streakinfo.owner _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("deploy");
  streakinfo notify("deploy_finished");
}

streakdeploy_cancelalldeployments() {
  self notify("cancel_all_killstreak_deployments");
}

streakdeploy_dogesturedeploy(streakinfo, _id_18F6CDAB37DE78A9) {
  level endon("game_ended");
  self endon("disconnect");

  if(!candeploykillstreak(streakinfo, _id_18F6CDAB37DE78A9))
    return 0;

  ondeploystart(streakinfo);
  thread watchforcancelduringgesture(streakinfo, _id_18F6CDAB37DE78A9);
  result = scripts\cp_mp\utility\weapon_utility::_id_F19F8B4CF085ECBD(_id_18F6CDAB37DE78A9);
  _id_18B31F57647D27FA = _id_18F6CDAB37DE78A9.basename == "ks_gesture_phone_mp";

  if(istrue(result) && istrue(_id_18B31F57647D27FA))
    scripts\cp_mp\utility\killstreak_utility::_id_36E63B8636445465(streakinfo.streakname);

  streakinfo notify("gesture_deploy_ended");
  ondeployfinished(streakinfo);

  if(istrue(self.inlaststand))
    thread _id_CCC14A44E1811CB1(_id_18F6CDAB37DE78A9);

  return result;
}

watchforcancelduringgesture(streakinfo, _id_18F6CDAB37DE78A9) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  streakinfo endon("gesture_deploy_ended");
  self waittill("cancel_all_killstreak_deployments");
  self takeweapon(_id_18F6CDAB37DE78A9);
}

_id_CCC14A44E1811CB1(_id_18F6CDAB37DE78A9) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self waittill("last_stand_finished");
  self takeweapon(_id_18F6CDAB37DE78A9);
}

_id_44D17DBE4DB72EA9(streakinfo) {
  self endon("cancel_all_killstreak_deployments");
  streakinfo endon("deploy_finished");
  level endon("game_ended");
  self waittill("death_or_disconnect");

  if(isDefined(self))
    self setclientomnvar("ui_mobile_killstreak_is_deploying", 0);
}

streakdeploy_doweaponswitchdeploy(streakinfo, weaponobj, _id_506F2E235EF4BFA8, _id_BDFFC63C4171C131, _id_8FD4D93DD619DA88, _id_91F739C2C51347D4, _id_0D55D8445518099B) {
  if(!candeploykillstreak(streakinfo, weaponobj))
    return 0;

  ondeploystart(streakinfo);
  _id_819C14E9DC86B8C8 = scripts\engine\utility::ter_op(istrue(_id_506F2E235EF4BFA8), ::waituntilfinishedwithdeployweapon, undefined);
  _id_41BF9BF4918115AC = switchtodeployweapon(weaponobj, streakinfo, _id_819C14E9DC86B8C8, _id_BDFFC63C4171C131, _id_8FD4D93DD619DA88, _id_91F739C2C51347D4, _id_0D55D8445518099B);

  if(!istrue(_id_41BF9BF4918115AC)) {
    ondeployfinished(streakinfo);
    return 0;
  }

  ondeployfinished(streakinfo);
  return 1;
}

streakdeploy_doweaponfireddeploy(streakinfo, weaponobj, firednotify, _id_BDFFC63C4171C131, _id_8FD4D93DD619DA88, _id_97EE9768F7229838, _id_91F739C2C51347D4, _id_0D55D8445518099B) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(!candeploykillstreak(streakinfo, weaponobj))
    return 0;

  ondeploystart(streakinfo);
  _id_41BF9BF4918115AC = switchtodeployweapon(weaponobj, streakinfo, ::waituntilfinishedwithdeployweapon, _id_BDFFC63C4171C131, _id_8FD4D93DD619DA88, _id_91F739C2C51347D4, _id_0D55D8445518099B);

  if(!istrue(_id_41BF9BF4918115AC)) {
    ondeployfinished(streakinfo);
    return 0;
  }

  if(isDefined(streakinfo) && isDefined(streakinfo._id_FB58A31C756DB4CC)) {
    _id_3B64EB40368C1450::_id_3633B947164BE4F3(streakinfo._id_FB58A31C756DB4CC, 0);
    _id_9CF1D5B97D062B8A = watchdeployweaponfired(streakinfo, firednotify, weaponobj, _id_97EE9768F7229838);
    _id_3B64EB40368C1450::_id_588F2307A3040610(streakinfo._id_FB58A31C756DB4CC);
  } else {
    _id_3B64EB40368C1450::set("firedDeploy", "offhand_weapons", 0);
    _id_9CF1D5B97D062B8A = watchdeployweaponfired(streakinfo, firednotify, weaponobj, _id_97EE9768F7229838);
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("firedDeploy");
  }

  ondeployfinished(streakinfo);
  return istrue(_id_9CF1D5B97D062B8A);
}

#using_animtree("script_model");

streakdeploy_doweapontabletdeploy(streakinfo, _id_BDFFC63C4171C131, _id_8FD4D93DD619DA88, _id_91F739C2C51347D4, _id_0D55D8445518099B, _id_F6A32DCC4B19AAD9, _id_67A06B4EA269058E, _id_AFE464C242489272, _id_818A18147626DFBF, _id_C2A00D4F077EBD87) {
  level endon("game_ended");
  self endon("disconnect");
  _id_5C3F9357F11D2223 = "ks_remote_device_mp";

  if(isDefined(_id_F6A32DCC4B19AAD9))
    _id_5C3F9357F11D2223 = _id_F6A32DCC4B19AAD9;

  weaponobj = makeweapon(_id_5C3F9357F11D2223);
  _id_5F6056D7176B7103 = % vm_ks_tablet_tap_raise;
  _id_A5E28EEB501A1341 = 1;

  if(_id_5C3F9357F11D2223 == "ks_remote_nuke_mp") {
    _id_5F6056D7176B7103 = % vm_ks_tablet_tac_nuke_raise;
    _id_A5E28EEB501A1341 = 0;
  }

  _id_CD5C5AC9105AB0D7 = scripts\cp_mp\utility\killstreak_utility::isremotekillstreaktabletweapon(weaponobj.basename);
  _id_2ED8C4E06182FD14 = getanimlength(_id_5F6056D7176B7103);

  if(istrue(_id_A5E28EEB501A1341))
    _id_2ED8C4E06182FD14 = _id_2ED8C4E06182FD14 - 1;

  if(isDefined(_id_AFE464C242489272))
    _id_2ED8C4E06182FD14 = _id_AFE464C242489272;

  if(!candeploykillstreak(streakinfo, weaponobj, _id_818A18147626DFBF))
    return 0;

  ondeploystart(streakinfo);

  if(!istrue(_id_C2A00D4F077EBD87))
    thread streakdeploy_playtabletdeploydialog(streakinfo);

  _id_3B64EB40368C1450::set("streakDeploy", "allow_movement", 0);
  _id_3B64EB40368C1450::set("streakDeploy", "allow_jump", 0);
  _id_3B64EB40368C1450::set("streakDeploy", "usability", 0);
  _id_3B64EB40368C1450::set("streakDeploy", "melee", 0);
  _id_3B64EB40368C1450::set("streakDeploy", "offhand_weapons", 0);
  _id_3B64EB40368C1450::set("streakDeploy", "supers", 0);
  _id_3B64EB40368C1450::set("streakDeploy", "killstreaks", 0);
  _id_41BF9BF4918115AC = switchtodeployweapon(weaponobj, streakinfo, ::waituntilfinishedwithdeployweapon, _id_BDFFC63C4171C131, _id_8FD4D93DD619DA88, _id_91F739C2C51347D4, _id_0D55D8445518099B);

  if(isDefined(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("streakDeploy");

    if(_id_CD5C5AC9105AB0D7)
      scripts\cp_mp\utility\player_utility::_freezelookcontrols(0);
  }

  if(!istrue(_id_41BF9BF4918115AC)) {
    ondeployfinished(streakinfo);
    return 0;
  }

  _id_0EABF81B5BE8DDB5 = watchdeployweaponanimtransition(streakinfo, _id_2ED8C4E06182FD14, _id_67A06B4EA269058E);
  ondeployfinished(streakinfo);
  return istrue(_id_0EABF81B5BE8DDB5);
}

streakdeploy_playtabletdeploydialog(streakinfo) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
}

streakdeploy_dothrowbackmarkerdeploy(streakinfo, weaponoverride, _id_BDFFC63C4171C131, _id_8FD4D93DD619DA88, _id_97EE9768F7229838, _id_91F739C2C51347D4, _id_0D55D8445518099B) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  weapon = "throwback_marker_mp";

  if(isDefined(weaponoverride))
    weapon = weaponoverride;

  streakinfo.deployweaponobj = makeweapon(weapon);
  weaponobj = streakinfo.deployweaponobj;

  if(!candeploykillstreak(streakinfo, weaponobj))
    return 0;

  ondeploystart(streakinfo);
  _id_41BF9BF4918115AC = switchtodeployweapon(weaponobj, streakinfo, ::waituntilfinishedwithdeployweapon, _id_BDFFC63C4171C131, _id_8FD4D93DD619DA88, _id_91F739C2C51347D4, _id_0D55D8445518099B);

  if(!istrue(_id_41BF9BF4918115AC)) {
    ondeployfinished(streakinfo);
    return 0;
  }

  _id_9CF1D5B97D062B8A = watchdeployweaponfired(streakinfo, "grenade_fire", weaponobj, _id_97EE9768F7229838);
  ondeployfinished(streakinfo);
  return istrue(_id_9CF1D5B97D062B8A);
}

switchtodeployweapon(deployweaponobj, streakinfo, _id_819C14E9DC86B8C8, _id_BDFFC63C4171C131, _id_8FD4D93DD619DA88, _id_91F739C2C51347D4, _id_0D55D8445518099B, skipfirstraise) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(self hasweapon(deployweaponobj))
    return 0;

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
      self notify("switched_from_minigun");

      while(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp")
        waitframe();
    }
  }

  if(!isDefined(skipfirstraise))
    skipfirstraise = 1;

  scripts\cp_mp\utility\inventory_utility::_giveweapon(deployweaponobj, 0, 0, skipfirstraise);
  _id_137E8CA1E47954DC = callweapongivencallback(streakinfo, _id_BDFFC63C4171C131);

  if(!istrue(_id_137E8CA1E47954DC)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(deployweaponobj);
    return 0;
  }

  self dlog_recordplayerevent("dlog_event_killstreak_tablet", ["file_line_info", "After switchToDeployWeapon"]);
  thread watchforcancelduringweaponswitch(streakinfo, deployweaponobj);
  thread _id_7605A5B4C0A6E117(streakinfo, deployweaponobj);
  _id_41BF9BF4918115AC = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(deployweaponobj, isbot(self, 1), streakinfo._id_9D7C6EE83F507A26);
  streakinfo notify("deploy_weapon_switch_ended");

  if(isDefined(_id_8FD4D93DD619DA88))
    self thread[[_id_8FD4D93DD619DA88]](streakinfo, _id_41BF9BF4918115AC);

  waitframe();

  if(!istrue(_id_41BF9BF4918115AC))
    _id_819C14E9DC86B8C8 = undefined;

  if(!scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  thread cleanupdeployweapon(_id_41BF9BF4918115AC, streakinfo, deployweaponobj, _id_819C14E9DC86B8C8, _id_91F739C2C51347D4, _id_0D55D8445518099B);
  return _id_41BF9BF4918115AC;
}

callweapongivencallback(streakinfo, _id_BDFFC63C4171C131) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("cancel_all_killstreak_deployments");

  if(isDefined(_id_BDFFC63C4171C131))
    return self[[_id_BDFFC63C4171C131]](streakinfo);

  return 1;
}

watchforcancelduringweaponswitch(streakinfo, deployweaponobj) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  streakinfo endon("deploy_weapon_switch_ended");
  self waittill("cancel_all_killstreak_deployments");

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(deployweaponobj))
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(deployweaponobj);
}

_id_7605A5B4C0A6E117(streakinfo, deployweaponobj) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  streakinfo endon("deploy_weapon_switch_ended");
  scripts\engine\utility::waittill_any_2("melee_swipe_start", "br_pickup_scriptable");

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(deployweaponobj))
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(deployweaponobj);
  else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(deployweaponobj);
    thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.lastdroppableweaponobj, isbot(self));
  }
}

watchdeployweaponfired(streakinfo, firednotify, _id_4EF1099365450BAE, _id_97EE9768F7229838) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("weapon_change");
  self endon("cancel_all_killstreak_deployments");

  for(;;) {
    _id_A9DD4E8C5E5C7178 = undefined;
    _id_B663FBBCBB2F5780 = undefined;

    switch (firednotify) {
      case "weapon_fired":
        self waittill(firednotify, _id_A9DD4E8C5E5C7178);
        break;
      case "offhand_fired":
        self waittill(firednotify, _id_A9DD4E8C5E5C7178);
        break;
      case "grenade_fire":
        self waittill(firednotify, _id_B663FBBCBB2F5780, _id_A9DD4E8C5E5C7178);
        break;
      default:
        self waittill(firednotify);
        break;
    }

    if(_id_A9DD4E8C5E5C7178 == _id_4EF1099365450BAE) {
      if(isDefined(_id_97EE9768F7229838)) {
        _id_9CF1D5B97D062B8A = [[_id_97EE9768F7229838]](streakinfo, _id_A9DD4E8C5E5C7178, _id_B663FBBCBB2F5780);

        if(!isDefined(_id_9CF1D5B97D062B8A))
          return 0;
        else if(_id_9CF1D5B97D062B8A == "failure")
          return 0;
        else if(_id_9CF1D5B97D062B8A == "continue") {
          if(isDefined(level.killstreakweaponfiredcontinue))
            [[level.killstreakweaponfiredcontinue]]();

          continue;
        } else if(_id_9CF1D5B97D062B8A == "success")
          return 1;
        else
          return 0;
      }

      return 1;
    }
  }

  return 0;
}

watchdeployweaponanimtransition(streakinfo, animlength, _id_67A06B4EA269058E) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(_id_67A06B4EA269058E))
    _id_67A06B4EA269058E = 1;

  alias = "iw9_ks_tablet_ui_sequence_plr";

  switch (streakinfo.streakname) {
    case "nuke_multi":
    case "nuke":
      alias = "mp_killstreak_mgb_tablet";
      break;
  }

  self playlocalsound(alias);
  scripts\cp_mp\utility\player_utility::setusingremote(streakinfo.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "objectiveUnPinPlayer") && isDefined(self.pinnedobjid)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "objectiveUnPinPlayer")]](self.pinnedobjid, self);
    self.remoteunpinned = 1;
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "killstreakDeploy");
  thread unfreezecontrolsonroundend();

  if(istrue(_id_67A06B4EA269058E))
    thread startweapontabletfadetransition(animlength - 0.3, streakinfo);

  thread watchweapontabletstop(streakinfo);
  thread watchweapontabletcallinpos(streakinfo);
  scripts\cp_mp\utility\killstreak_utility::starttabletscreen(streakinfo.streakname, 0.05);
  result = scripts\engine\utility::waittill_any_timeout_3(animlength, "death", "weapon_change", "cancel_all_killstreak_deployments");
  self notify("ks_freeze_end");
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "killstreakDeploy");

  if(!isDefined(result) || result != "timeout" || !self isonground() && !scripts\cp_mp\utility\player_utility::_id_D474B372046544B0() && !issubstr(streakinfo.streakname, "nuke") || self isonladder()) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    self stoplocalsound("mp_killstreak_tablet_gear");
    scripts\cp_mp\utility\killstreak_utility::stoptabletscreen(streakinfo.streakname);
    self notify("cancel_remote_sequence");
    return 0;
  }

  self notify("deploy_weapon_anim_successful");
  return 1;
}

unfreezecontrolsonroundend() {
  self endon("disconnect");
  self endon("ks_freeze_end");
  level waittill("round_switch");
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "killstreakDeploy");
}

startweapontabletfadetransition(_id_3702CBA57F844507, streakinfo) {
  self endon("disconnect");
  result = scripts\engine\utility::waittill_any_timeout_1(_id_3702CBA57F844507, "cancel_remote_sequence");

  if(!isDefined(result) || result == "cancel_remote_sequence") {
    return;
  }
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    if(isDefined(streakinfo) && streakinfo.streakname != "pac_sentry")
      self playlocalsound("mp_killstreak_transition_whoosh");

    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.3);
    result = scripts\engine\utility::waittill_any_timeout_1(0.7, "death");

    if(!isDefined(result) || result == "death")
      self stoplocalsound("mp_killstreak_transition_whoosh");

    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.3);
  }
}

watchweapontabletstop(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  streakinfo waittill("killstreak_finished_with_deploy_weapon");

  if(scripts\cp_mp\utility\player_utility::isusingremote())
    scripts\cp_mp\utility\player_utility::clearusingremote();
}

watchweapontabletcallinpos(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("deploy_weapon_anim_successful");
  self endon("cancel_remote_sequence");

  for(;;) {
    if(!self isonground()) {
      _id_19B9BA70FB85A568 = 1;

      if(scripts\cp_mp\utility\player_utility::_id_988138367C74B1F5()) {
        if(scripts\cp_mp\utility\killstreak_utility::ismapselectkillstreak(streakinfo.streakname))
          _id_19B9BA70FB85A568 = 0;
      } else if(scripts\cp_mp\utility\player_utility::_id_D474B372046544B0()) {
        if(scripts\cp_mp\utility\killstreak_utility::isridekillstreak(streakinfo.streakname) || scripts\cp_mp\utility\killstreak_utility::ismapselectkillstreak(streakinfo.streakname))
          _id_19B9BA70FB85A568 = 0;
      } else if(scripts\cp_mp\utility\killstreak_utility::_id_D57FB9ABF76F9515(streakinfo.streakname))
        _id_19B9BA70FB85A568 = 0;

      if(istrue(_id_19B9BA70FB85A568)) {
        wait 0.05;
        streakdeploy_cancelalldeployments();
        break;
      }
    }

    waitframe();
  }
}

waituntilfinishedwithdeployweapon(streakinfo) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  childthread _id_2BFF7042844C915B(streakinfo, "killstreak_finished_with_deploy_weapon");
  childthread _id_2BFF7042844C915B(self, "cancel_all_killstreak_deployments");
  childthread _id_2BFF7042844C915B(self, "weapon_change");

  for(;;) {
    self waittill("potential_killstreak_deployment_finish", result);

    if(isDefined(result) && result == "weapon_change") {
      if(scripts\cp_mp\utility\player_utility::isusingremote())
        continue;
    }

    break;
  }

  self notify("killstreak_really_finished_with_deploy_weapon");
}

_id_2BFF7042844C915B(ent, _id_F36C0162774A45FA) {
  self endon("killstreak_really_finished_with_deploy_weapon");
  ent waittill(_id_F36C0162774A45FA);
  self notify("potential_killstreak_deployment_finish", _id_F36C0162774A45FA);
}

cleanupdeployweapon(_id_41BF9BF4918115AC, streakinfo, weaponobj, _id_819C14E9DC86B8C8, _id_91F739C2C51347D4, _id_0D55D8445518099B) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(isDefined(_id_819C14E9DC86B8C8))
    self[[_id_819C14E9DC86B8C8]](streakinfo);

  if(self hasweapon(weaponobj)) {
    _id_CD5C5AC9105AB0D7 = scripts\cp_mp\utility\killstreak_utility::isremotekillstreaktabletweapon(weaponobj.basename);
    _id_AEBF6650A2151847 = scripts\cp_mp\utility\killstreak_utility::ismapselectkillstreak(streakinfo.streakname);
    _id_D110628A2924AC08 = isDefined(streakinfo.streakname) && (streakinfo.streakname == "nuke" || streakinfo.streakname == "nuke_multi");
    _id_3B64EB40368C1450::set("deployCleanup", "melee", 0);
    _id_3B64EB40368C1450::set("deployCleanup", "offhand_weapons", 0);

    if(_id_CD5C5AC9105AB0D7) {
      _id_3B64EB40368C1450::set("deployCleanup", "mantle", 0);
      _id_3B64EB40368C1450::set("deployCleanup", "allow_movement", 0);
      scripts\cp_mp\utility\killstreak_utility::stoptabletscreen(streakinfo.streakname, 0.5, 1);
      scripts\cp_mp\utility\player_utility::_freezelookcontrols(1);
    } else if(istrue(_id_AEBF6650A2151847)) {
      _id_3B64EB40368C1450::set("deployCleanup", "mantle", 0);

      if(_id_D110628A2924AC08)
        scripts\cp_mp\utility\killstreak_utility::stoptabletscreen(streakinfo.streakname);
    }

    if(isDefined(_id_91F739C2C51347D4))
      self[[_id_91F739C2C51347D4]](streakinfo, _id_41BF9BF4918115AC, weaponobj);
    else
      getridofkillstreakdeployweapon(weaponobj);

    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("deployCleanup");

    if(_id_CD5C5AC9105AB0D7)
      scripts\cp_mp\utility\player_utility::_freezelookcontrols(0);
  }

  if(isDefined(_id_0D55D8445518099B))
    self[[_id_0D55D8445518099B]](streakinfo);
}

getridofkillstreakdeployweapon(weaponobj) {
  scripts\cp_mp\utility\inventory_utility::getridofweapon(weaponobj, istrue(self._id_4A2F2F50A9020E2E));
  self._id_4A2F2F50A9020E2E = undefined;
  currentweapon = self getcurrentweapon();

  if(currentweapon.basename == "none")
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
}

_id_A0CEE45D6A20E17F(objweapon) {
  currentweapon = self getcurrentweapon().basename;
  _id_2B6C134C45883823 = objweapon.basename;

  if(isDefined(currentweapon) && currentweapon == "deploy_sentry_mp" && isDefined(_id_2B6C134C45883823) && _id_2B6C134C45883823 != "deploy_sentry_mp")
    return 1;

  return 0;
}

candeploykillstreakweapon(streakinfo, objweapon) {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && istrue(level.gameended))
    return "KILLSTREAKS/CANNOT_BE_USED";

  if(isDefined(objweapon) && self hasweapon(objweapon))
    return "KILLSTREAKS/CANNOT_BE_USED";

  if(isDefined(objweapon) && _id_A0CEE45D6A20E17F(objweapon))
    return "KILLSTREAKS/CANNOT_BE_USED";

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon_switch") || !_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon"))
    return "KILLSTREAKS/CANNOT_BE_USED";

  if(scripts\cp_mp\utility\player_utility::isusingremote())
    return "KILLSTREAKS/CANNOT_BE_USED";

  if(istrue(self.oob))
    return "KILLSTREAKS/CANNOT_BE_USED_OUTOFBOUNDS";

  if(streakinfo.streakname == "assault_drone" || streakinfo.streakname == "radar_drone_recon" || streakinfo.streakname == "pac_sentry") {
    if(istrue(self._id_8E2D666B5B0F2BD3) || istrue(self._id_E6204058F06B94E5))
      return "KILLSTREAKS/CANNOT_BE_USED";
  }

  if(istrue(self._id_E6204058F06B94E5))
    return "KILLSTREAKS/CANNOT_BE_USED";

  if(istrue(self._id_5B3C77E2EAFAB370))
    return "KILLSTREAKS/CANNOT_BE_USED";

  if(self isonladder())
    return "KILLSTREAKS/CANNOT_BE_USED";

  if(self ismantling())
    return "KILLSTREAKS/CANNOT_BE_USED";

  if(scripts\cp_mp\utility\player_utility::_id_988138367C74B1F5()) {
    if(scripts\cp_mp\utility\killstreak_utility::isridekillstreak(streakinfo.streakname) || scripts\cp_mp\utility\killstreak_utility::_id_3C5423F8416220DE(streakinfo.streakname))
      return "KILLSTREAKS/CANNOT_BE_USED_WATER";
  } else if(scripts\cp_mp\utility\player_utility::_id_D474B372046544B0()) {
    if(scripts\cp_mp\utility\killstreak_utility::_id_3C5423F8416220DE(streakinfo.streakname))
      return "KILLSTREAKS/CANNOT_BE_USED_WATER";
  }

  if(!self isonground() && !self _meth_E40102956C887F7C()) {
    if(self isparachuting())
      return "KILLSTREAKS/CANNOT_BE_USED";

    if(!scripts\cp_mp\utility\killstreak_utility::_id_D57FB9ABF76F9515(streakinfo.streakname))
      return "KILLSTREAKS/CANNOT_BE_USED";
  }

  _id_833E442B7E050D94 = _id_2669878CF5A1B6BC::getgrenadeinpullback();

  if(isDefined(_id_833E442B7E050D94) && _id_02AABAC61F2AE422::issuperweapon(_id_833E442B7E050D94))
    return "KILLSTREAKS/CANNOT_BE_USED";

  return;
}