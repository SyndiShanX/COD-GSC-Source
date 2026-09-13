/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_bombzone.gsc
*************************************************/

setupobjective(trigger, _id_08B9949739F4E0F6, _id_5DDBC1FAED2C56E6) {
  _id_EEF26A325310D3AF = undefined;
  label = undefined;

  if(isDefined(level.curobj))
    level.curobj scripts\mp\gameobjects::deleteuseobject();

  if(isDefined(trigger.originalpos))
    trigger.origin = trigger.originalpos;
  else
    trigger.originalpos = trigger.origin;

  visuals = undefined;

  if(isDefined(trigger.target))
    visuals = getEntArray(trigger.target, "targetname");

  if(isDefined(trigger.objectivekey))
    objectivekey = trigger.objectivekey;
  else
    objectivekey = trigger.script_label;

  if(istrue(_id_5DDBC1FAED2C56E6))
    _id_3C2389BA69E5822B = getreservedobjid(objectivekey);
  else
    _id_3C2389BA69E5822B = undefined;

  if(scripts\mp\utility\game::getgametype() == "dd") {
    label = trigger.script_label;
    collision = getEnt("dd_bombzone_clip" + label, "targetname");

    if(scripts\mp\utility\game::inovertime()) {
      if(label == "_a" || label == "_b") {
        trigger delete();
        visuals[0] delete();
        collision delete();
        return;
      }

      _id_EEF26A325310D3AF = scripts\mp\gameobjects::createuseobject("neutral", trigger, visuals, (0, 0, 64), _id_3C2389BA69E5822B, _id_08B9949739F4E0F6);
      _id_EEF26A325310D3AF scripts\mp\gameobjects::allowuse("any");
      _id_EEF26A325310D3AF.trigger.script_label = "_a";
    } else if(label == "_c") {
      trigger delete();
      visuals[0] delete();
      collision delete();
      return;
    }
  } else if(scripts\mp\utility\game::getgametype() == "sd")
    setomnvar("ui_bomb_owner_team", 0);

  if(!isDefined(_id_EEF26A325310D3AF)) {
    _id_EE070EC3273F71B5 = 0;

    if(!isDefined(visuals)) {
      _id_EE070EC3273F71B5 = 1;
      _id_7CCA94C5FBF2F5A5 = spawn("script_model", trigger.origin);
      _id_7CCA94C5FBF2F5A5 makeusable();
      _id_7CCA94C5FBF2F5A5.usetype = 1;
      _id_7CCA94C5FBF2F5A5.isuseobject = 1;
      _id_7CCA94C5FBF2F5A5.skiptouching = 1;
      visuals[0] = trigger;
      visuals[0].bombdefusetrig = _id_7CCA94C5FBF2F5A5;
    }

    _id_EEF26A325310D3AF = scripts\mp\gameobjects::createuseobject(game["defenders"], trigger, visuals, (0, 0, 64), _id_3C2389BA69E5822B, _id_08B9949739F4E0F6);
    _id_EEF26A325310D3AF scripts\mp\gameobjects::allowuse("enemy");

    if(_id_EE070EC3273F71B5 == 1) {
      _id_EEF26A325310D3AF.trigger makeusable();
      _id_EEF26A325310D3AF.skiptouching = 1;
    }
  }

  if(isDefined(trigger.objectivekey))
    _id_EEF26A325310D3AF.objectivekey = trigger.objectivekey;
  else
    _id_EEF26A325310D3AF.objectivekey = _id_EEF26A325310D3AF scripts\mp\gameobjects::getlabel();

  if(isDefined(trigger.iconname))
    _id_EEF26A325310D3AF.iconname = trigger.iconname;
  else
    _id_EEF26A325310D3AF.iconname = _id_EEF26A325310D3AF scripts\mp\gameobjects::getlabel();

  _id_EEF26A325310D3AF.id = "bomb_zone";
  _id_EEF26A325310D3AF.trigger setusepriority(-4);
  _id_EEF26A325310D3AF scripts\mp\gameobjects::setusetime(level.planttime);
  _id_EEF26A325310D3AF scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  _id_EEF26A325310D3AF scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES");
  _id_EEF26A325310D3AF.trigger setuseholdduration("duration_none");

  if(!level.multibomb)
    _id_EEF26A325310D3AF scripts\mp\gameobjects::setkeyobject(level.sdbomb);

  if(_id_EEF26A325310D3AF.objectivekey == "_c" && scripts\mp\utility\game::getgametype() != "gwbomb") {
    _id_EEF26A325310D3AF.objectivekey = "_a";
    _id_EEF26A325310D3AF.iconname = "_a";
  }

  if(scripts\mp\utility\game::getgametype() == "cmd" && scripts\mp\utility\game::inovertime()) {
    _id_EEF26A325310D3AF scripts\mp\gameobjects::setobjectivestatusicons("waypoint_target");
    _id_EEF26A325310D3AF scripts\mp\gameobjects::setvisibleteam("any");
  }

  _id_EEF26A325310D3AF.usecondition = ::_id_D3516B464BF6E8B4;
  _id_EEF26A325310D3AF.onbeginuse = ::bombzone_onbeginuse;
  _id_EEF26A325310D3AF.onenduse = ::bombzone_onenduse;
  _id_EEF26A325310D3AF.onuse = ::bombzone_onuseplantobject;
  _id_EEF26A325310D3AF.oncantuse = ::bombzone_oncantuse;
  _id_EEF26A325310D3AF.useweapon = makeweapon("briefcase_bomb_mp");
  _id_EEF26A325310D3AF.bombplanted = 0;
  _id_EEF26A325310D3AF.bombexploded = undefined;
  _id_EEF26A325310D3AF.resetprogress = level.resetprogress;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < visuals.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(visuals[_id_AC0E594AC96AA3A8].script_exploder)) {
      _id_EEF26A325310D3AF.exploderindex = visuals[_id_AC0E594AC96AA3A8].script_exploder;
      visuals[_id_AC0E594AC96AA3A8] thread _id_F1CE924CD6279917(_id_EEF26A325310D3AF);
      visuals[_id_AC0E594AC96AA3A8] thread setupkillcament(_id_EEF26A325310D3AF);
      break;
    }
  }

  if(scripts\mp\utility\game::getgametype() != "dd" || scripts\mp\utility\game::getgametype() == "gwbomb") {
    if(isDefined(visuals[0].target))
      _id_EEF26A325310D3AF.bombdefusetrig = getEnt(visuals[0].target, "targetname");
    else if(!isDefined(_id_EEF26A325310D3AF.bombdefusetrig) && isDefined(visuals[0].bombdefusetrig))
      _id_EEF26A325310D3AF.bombdefusetrig = visuals[0].bombdefusetrig;

    _id_EEF26A325310D3AF.bombdefusetrig.origin = _id_EEF26A325310D3AF.bombdefusetrig.origin + (0, 0, -10000);
    _id_EEF26A325310D3AF.bombdefusetrig.label = label;
  } else {
    trig = getEnt(visuals[0].target, "targetname");
    trig delete();
    _id_EEF26A325310D3AF.bombdefusetrig = _id_EEF26A325310D3AF.trigger;
  }

  _id_EEF26A325310D3AF.noweapondropallowedtrigger = spawn("trigger_radius", _id_EEF26A325310D3AF.trigger.origin, 0, 150, 60);
  return _id_EEF26A325310D3AF;
}

getreservedobjid(objectivekey) {
  if(objectivekey == "_a")
    _id_AA530B7C5AEFA0B4 = 0;
  else
    _id_AA530B7C5AEFA0B4 = 1;

  return _id_AA530B7C5AEFA0B4;
}

setupkillcament(_id_EEF26A325310D3AF) {
  _id_027BA39CB4DA36C7 = spawn("script_origin", self.origin);
  _id_027BA39CB4DA36C7.angles = self.angles;
  _id_027BA39CB4DA36C7 rotateYaw(-45, 0.05);
  waitframe();
  _id_F69BA77714DAC6C2 = undefined;
  _id_B44CEFCF38B5DA97 = self.origin + anglesToForward(_id_027BA39CB4DA36C7.angles) * 18 + (0, 0, 60);
  _id_DFDBE7C0C9DCA192 = self.origin + anglesToForward(_id_027BA39CB4DA36C7.angles) * 100 + (0, 0, 128);
  _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle"];
  contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
  result = scripts\engine\trace::sphere_trace(_id_B44CEFCF38B5DA97, _id_DFDBE7C0C9DCA192, 16, [self], contentoverride);
  _id_F69BA77714DAC6C2 = result["shape_position"];

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_skyway" && _id_EEF26A325310D3AF.objectivekey == "_b")
    _id_F69BA77714DAC6C2 = (326, 595, 85);

  self.killcament = spawn("script_model", _id_F69BA77714DAC6C2);
  self.killcament setscriptmoverkillcam("explosive");
  _id_EEF26A325310D3AF.killcamentnum = self.killcament getentitynumber();
  _id_027BA39CB4DA36C7 delete();
}

allowedwhileplanting(_id_BD138DE99B3B3507) {
  if(!_id_BD138DE99B3B3507) {
    _id_3B64EB40368C1450::set("bombzone", "allow_jump", 0);
    _id_3B64EB40368C1450::set("bombzone", "gesture", 0);
    _id_3B64EB40368C1450::set("bombzone", "melee", 0);
    _id_3B64EB40368C1450::set("bombzone", "mantle", 0);
    _id_3B64EB40368C1450::set("bombzone", "offhand_weapons", 0);
  } else {
    _id_3B64EB40368C1450::set("bombzone", "allow_jump", 1);
    _id_3B64EB40368C1450::set("bombzone", "gesture", 1);
    _id_3A9E0F1BEA21D3CC = self getcurrentweapon();

    if(isDefined(_id_3A9E0F1BEA21D3CC) && _id_3A9E0F1BEA21D3CC.basename == "briefcase_bomb_mp")
      self waittill("bomb_allow_offhands");

    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("bombzone");
  }
}

setbombplantingomnvar(_id_B5111CD83B4A3176) {
  wait 0.35;
  _id_CABC886D846DD979 = 0;

  switch (_id_B5111CD83B4A3176) {
    case "_a":
      _id_CABC886D846DD979 = 1;
      break;
    case "_b":
      _id_CABC886D846DD979 = 2;
      break;
    case "_c":
      _id_CABC886D846DD979 = 2;
      break;
    default:
      _id_CABC886D846DD979 = 2;
      break;
  }

  setomnvar("ui_bomb_interacting", _id_CABC886D846DD979);
}

setbombdefusingomnvar(_id_B5111CD83B4A3176) {
  wait 0.35;

  if(_id_B5111CD83B4A3176 == "_a")
    _id_CABC886D846DD979 = 3;
  else
    _id_CABC886D846DD979 = 4;

  setomnvar("ui_bomb_interacting", _id_CABC886D846DD979);

  if(level.codcasterenabled)
    self setgametypevip(1);

  _id_548072087C9FD504::_id_7D42D3F8DD68280C(2, self.team, self getentitynumber());
}

bombzone_onbeginuse(player) {
  player thread allowedwhileplanting(0);
  player playlocalsound("mp_bomb_raise_noise");

  if(self.bombplanted) {
    player scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("defuse");
    player notify("super_obj_drain");
    player.isdefusing = 1;
    player thread setbombdefusingomnvar(self.objectivekey);
    setomnvar("ui_bomb_defuser", player getentitynumber());
    player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS");

    if(getdvarint("dvar_9CF963B64E1223E7", 0) == 1) {} else {
      if(scripts\mp\utility\game::getgametype() == "gwbomb")
        scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb_defusing", "waypoint_bomb_defend");
      else
        scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb_defend_nt", "waypoint_bomb_defusing");

      scripts\mp\objidpoolmanager::objective_teammask_removefrommask(self.radialtimeobjid, player.team);
    }

    if(isDefined(level.sdbombmodel))
      level.sdbombmodel hide();
    else if(isDefined(level.ddbombmodel[self.objectivekey]))
      level.ddbombmodel[self.objectivekey] hide();

    player thread startnpcbombusesound("briefcase_bomb_defuse_mp", "equip_suitcase_defuse_button");
  } else {
    player scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("plant");
    player notify("super_obj_drain");
    player.isplanting = 1;
    player.bombplantweapon = self.useweapon;
    player thread setbombplantingomnvar(self.objectivekey);
    scripts\mp\utility\dialog::statusdialog("bomb_planting" + self.objectivekey, player.team, "status");
    player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, "MP_INGAME_ONLY/OBJ_PLANTING_CAPS");
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_bomb_planting");
    player thread startnpcbombusesound("briefcase_bomb_mp", "equip_suitcase_raise_button");
  }
}

bombzone_onenduse(team, player, result) {
  if(istrue(player.isdefusing) || istrue(player.isplanting))
    setomnvar("ui_bomb_interacting", 0);

  if(istrue(player.isdefusing) && level.codcasterenabled)
    player setgametypevip(0);

  player stoplocalsound("mp_bomb_raise_noise");
  setomnvar("ui_bomb_defuser", -1);
  objid = self.objidnum;

  if(level.resetprogress) {
    scripts\mp\objidpoolmanager::objective_set_progress(objid, 0);
    scripts\mp\objidpoolmanager::objective_show_progress(objid, 0);
  }

  if(!result) {
    if(scripts\mp\utility\game::inovertime() && self.bombplanted == 0)
      self.showprogressforteam = undefined;

    if(getdvarint("dvar_9CF963B64E1223E7", 0) == 1) {} else {
      if(self.bombplanted) {
        if(scripts\mp\utility\game::getgametype() == "gwbomb")
          scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defuse", "waypoint_defend");
        else
          scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_defuse");
      } else
        scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");

      if(isDefined(self.radialtimeobjid))
        scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.radialtimeobjid, player.team);
    }
  }

  if(!isDefined(player)) {
    return;
  }
  player thread allowedwhileplanting(1);
  player.bombplantweapon = undefined;

  if(isalive(player)) {
    player.isdefusing = 0;
    player.isplanting = 0;
  }

  if(isPlayer(player)) {
    player setclientomnvar("ui_objective_pinned_text_param", 0);
    player.ui_bomb_planting_defusing = undefined;
  }

  if(!scripts\mp\gameobjects::isfriendlyteam(player.pers["team"])) {
    if(isDefined(level.sdbombmodel) && !result) {
      if(self.bombplanted)
        level.sdbombmodel show();
    } else if(isDefined(level.ddbombmodel)) {
      if(isDefined(level.ddbombmodel[self.objectivekey]) && !result)
        level.ddbombmodel[self.objectivekey] show();
    }
  }

  player notify("gameobject_endUse");
}

startnpcbombusesound(weaponname, _id_CB3339ECE72DBDEB) {
  self endon("death");
  self endon("stopNpcBombSound");

  if(scripts\mp\utility\game::isanymlgmatch() || istrue(level.silentplant) || scripts\mp\utility\perk::_hasperk("specialty_engineer")) {
    self setentitysoundcontext("silent_plant", "on");
    return;
  }

  for(;;) {
    self waittill("weapon_change", _id_66B3DB972AC1531E);

    if(_id_66B3DB972AC1531E.basename == weaponname) {
      break;
    }
  }

  self playsoundtoteam(_id_CB3339ECE72DBDEB, self.team, self);
  enemyteam = scripts\mp\utility\game::getotherteam(self.team)[0];
  self playsoundtoteam(_id_CB3339ECE72DBDEB, enemyteam);
  self waittill("weapon_change");
  self notify("stopNpcBombSound");
}

_id_D3516B464BF6E8B4(player) {
  if(!isDefined(self) || !isDefined(self.visuals[0]))
    return 0;

  if(!isDefined(player))
    return 0;

  _id_EEF26A325310D3AF = self.visuals[0];
  _id_9632EBC2AE3179FA = vectorNormalize(anglestoup(_id_EEF26A325310D3AF.angles));
  _id_A02DAF26F612D1E3 = vectorNormalize(player.origin - _id_EEF26A325310D3AF.origin);
  _id_9913FD1FFEA99C33 = vectordot(_id_9632EBC2AE3179FA, _id_A02DAF26F612D1E3);
  return _id_9913FD1FFEA99C33 <= 0.5;
}

bombzone_oncantuse(player) {}

bombzone_onuseplantobject(player) {
  if(scripts\mp\utility\game::inovertime() && self.bombplanted == 0 || !scripts\mp\gameobjects::isfriendlyteam(player.pers["team"])) {
    self.showprogressforteam = undefined;
    level thread bombzone_onbombplanted(self, player);
    player notify("bomb_planted");
    _id_87FB87A85BBC8FB4 = 2;

    if(self.objectivekey == "_a")
      _id_87FB87A85BBC8FB4 = 1;

    _id_548072087C9FD504::_id_7D42D3F8DD68280C(0, player.team, player getentitynumber(), _id_87FB87A85BBC8FB4);
    player scripts\mp\utility\stats::incpersstat("plants", 1);
    player scripts\mp\persistence::statsetchild("round", "plants", player.pers["plants"]);
    player scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(3, 1);
    player scripts\cp_mp\pet_watch::addplantingcharge();
    player scripts\mp\utility\stats::setextrascore0(player.pers["plants"]);

    if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[player.team]))
      player thread removebombcarrierclass();

    if(scripts\mp\utility\game::getgametype() != "cmd") {
      if(scripts\mp\utility\game::inovertime())
        scripts\mp\utility\dialog::statusdialog("enemy_bomb_planted", scripts\mp\utility\game::getotherteam(player.team)[0], 1);
      else
        scripts\mp\utility\dialog::statusdialog("enemy_bomb" + self.objectivekey, scripts\mp\utility\game::getotherteam(player.team)[0], 1);

      if(scripts\mp\utility\game::getgametype() == "gwbomb")
        scripts\mp\utility\dialog::statusdialog("bomb_planted" + self.objectivekey, player.team, 1);
      else
        scripts\mp\utility\dialog::statusdialog("bomb_planted", player.team, 1);
    }

    level thread scripts\mp\hud_util::teamplayercardsplash("callout_bombplanted", player);
    level.bombowner = player;
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_FD5E014E1660FC72");
    player.bombplantedtime = gettime();

    if(isPlayer(player)) {
      player scripts\cp_mp\challenges::onplant();
      _id_7E2C53B0BCF117D9 = spawnStruct();
      _id_7E2C53B0BCF117D9.player = player;
      _id_7E2C53B0BCF117D9.eventname = "plant";
      _id_7E2C53B0BCF117D9.position = player.origin;
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
    }
  }
}

bombzone_onusedefuseobject(player) {
  _id_A345B1BC63EE3073 = 0;
  setomnvar("ui_bomb_interacting", 0);
  setomnvar("ui_victory_condition_completed", 1);

  foreach(_id_B5111CD83B4A3176 in level.objectives) {
    if(isDefined(_id_B5111CD83B4A3176.objectivekey) && _id_B5111CD83B4A3176.objectivekey == self.objectivekey) {
      player playlocalsound("mp_bomb_defuse");
      player notify("bomb_defused" + _id_B5111CD83B4A3176.objectivekey);
      level thread bombdefused(_id_B5111CD83B4A3176);
      break;
    }
  }

  if(scripts\mp\utility\game::getgametype() != "dd" && scripts\mp\utility\game::getgametype() != "gwbomb") {
    scripts\mp\gameobjects::disableobject();
    iprintln(&"MP/EXPLOSIVES_DEFUSED_BY", player);
  }

  if(scripts\mp\utility\game::getgametype() == "gwbomb") {
    scripts\mp\utility\dialog::statusdialog("enemy_bomb_defused" + self.objectivekey, scripts\mp\utility\game::getotherteam(player.team)[0], 1);
    scripts\mp\utility\dialog::statusdialog("bomb_defused" + self.objectivekey, player.team, 1);
  } else {
    scripts\mp\utility\dialog::statusdialog("enemy_bomb_defused", scripts\mp\utility\game::getotherteam(player.team)[0], 1);
    scripts\mp\utility\dialog::statusdialog("bomb_defused", player.team, 1);
  }

  level thread scripts\mp\hud_util::teamplayercardsplash("callout_bombdefused", player);
  scripts\cp_mp\challenges::_id_C51330573171A1BE(player);
  scripts\mp\events::bombdefused(player);
}

bombzone_onbombplanted(_id_2810BD61A09D19F5, player) {
  level endon("bombs_canceled");
  level notify("bomb_planted", _id_2810BD61A09D19F5);
  _id_BD6089532051AA97 = player.team;
  level.bombdefused = 0;
  _id_2810BD61A09D19F5.bombdefused = 0;

  if(scripts\mp\utility\game::getgametype() == "dd" && level.bombsplanted <= 0) {
    scripts\mp\gamelogic::pausetimer();
    level.timepausestart = gettime();
  }

  level.bombplanted = 1;
  level.bombsplanted = level.bombsplanted + 1;

  if(scripts\mp\utility\game::getgametype() != "btm") {
    if(scripts\mp\utility\game::getgametype() == "gwbomb") {
      if(!isDefined(level._id_16FFD04B2B868C06)) {
        level._id_16FFD04B2B868C06 = [];

        foreach(team in level.teamnamelist)
        level._id_16FFD04B2B868C06[team] = 0;
      }

      level._id_16FFD04B2B868C06[_id_BD6089532051AA97]++;
      _id_D793B74A850385E7 = getteamscore(_id_BD6089532051AA97) + level._id_16FFD04B2B868C06[_id_BD6089532051AA97];
      otherteam = scripts\mp\utility\game::getotherteam(_id_BD6089532051AA97)[0];
      _id_7DBA511994344EFC = getteamscore(otherteam) + level._id_16FFD04B2B868C06[otherteam];

      if(_id_D793B74A850385E7 >= _id_7DBA511994344EFC)
        level.timelimitoverride = 1;
    } else
      level.timelimitoverride = 1;
  }

  level.defuseendtime = int(gettime() + level.bombtimer * 1000);

  if(_id_2810BD61A09D19F5.objectivekey == "_a")
    level.aplanted = 1;
  else
    level.bplanted = 1;

  setbombtimeromnvars(player.team);
  level.destroyedobject = _id_2810BD61A09D19F5;
  level.destroyedobject.bombplanted = 1;

  if(!level.multibomb) {
    player setclientomnvar("ui_carrying_bomb", 0);
    setomnvar("ui_bomb_carrier", -1);
    setgameendtime(level.defuseendtime);
  }

  _id_2810BD61A09D19F5.visuals[0] thread scripts\mp\gamelogic::playtickingsound();
  level.tickingobject = _id_2810BD61A09D19F5.visuals[0];

  if(!level.multibomb) {
    level.sdbomb scripts\mp\gameobjects::allowcarry("none");

    if(getdvarint("dvar_9CF963B64E1223E7", 0) == 1) {
      level.sdbombmodel unlink(1);

      if(game["attackers"] == "allies")
        level.sdbombmodel.scriptable setscriptablepartstate("bomb", "plantedAllies");
      else
        level.sdbombmodel.scriptable setscriptablepartstate("bomb", "plantedAxis");
    } else {
      level.sdbomb scripts\mp\gameobjects::setvisibleteam("none");
      _id_8F59C9F0558FA031 = _id_5784FD1CDDBD00D3();
      level.sdbomb scripts\mp\gameobjects::setdropped(undefined, scripts\engine\utility::ter_op(_id_8F59C9F0558FA031 > 0, _id_8F59C9F0558FA031, undefined), getdvarint("dvar_9CF963B64E1223E7", 0) == 1);
      level.sdbombmodel = level.sdbomb.visuals[0];
      level.sdbombmodel setasgametypeobjective();
      level.sdbomb scripts\mp\gameobjects::releaseid(1, 1);
    }

    level.sdbombmodel _meth_5226227BCE83EBE9(1, _id_BD6089532051AA97);
  } else if(scripts\mp\utility\game::getgametype() == "cmd" || scripts\mp\utility\game::getgametype() == "gwbomb") {} else if(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "btm") {
    level.ddbombmodel[_id_2810BD61A09D19F5.objectivekey] = spawn("script_model", player.origin);
    level.ddbombmodel[_id_2810BD61A09D19F5.objectivekey].angles = player.angles;
    level.ddbombmodel[_id_2810BD61A09D19F5.objectivekey] setModel("offhand_2h_wm_briefcase_bomb_v0");
    level.ddbombmodel[_id_2810BD61A09D19F5.objectivekey] setasgametypeobjective();
    level.ddbombmodel[_id_2810BD61A09D19F5.objectivekey] setnonstick(1);
  } else if(getdvarint("dvar_9CF963B64E1223E7", 0) == 1) {
    level.sdbombmodel unlink(1);

    if(game["attackers"] == "allies")
      level.sdbombmodel.scriptable setscriptablepartstate("bomb", "plantedAllies");
    else
      level.sdbombmodel.scriptable setscriptablepartstate("bomb", "plantedAxis");
  } else {
    level.sdbombmodel = spawn("script_model", player.origin);
    level.sdbombmodel.angles = player.angles;
    level.sdbombmodel setModel("offhand_2h_wm_briefcase_bomb_v0");
    level.sdbombmodel setasgametypeobjective();
    level.sdbombmodel setnonstick(1);
  }

  if(scripts\mp\utility\game::getgametype() != "dd" && scripts\mp\utility\game::getgametype() != "cmd" || scripts\mp\utility\game::getgametype() != "btm" && scripts\mp\utility\game::getgametype() != "gwbomb") {
    _id_2810BD61A09D19F5 scripts\mp\gameobjects::allowuse("none");
    _id_2810BD61A09D19F5 scripts\mp\gameobjects::setvisibleteam("none");
  }

  visuals = [];

  if(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "cmd" || scripts\mp\utility\game::getgametype() == "btm") {
    _id_FF7F197ECB7A2B90 = _id_2810BD61A09D19F5;
    _id_FF7F197ECB7A2B90 scripts\mp\gameobjects::setownerteam(player.team);
  } else if(scripts\mp\utility\game::getgametype() == "gwbomb")
    _id_FF7F197ECB7A2B90 = _id_2810BD61A09D19F5;
  else {
    trigger = _id_2810BD61A09D19F5.bombdefusetrig;
    trigger.origin = level.sdbombmodel.origin;
    _id_3AAA5FB58A6C2EB7 = game["attackers"];
    _id_2810BD61A09D19F5 scripts\mp\gameobjects::releaseid(1, 1);
    _id_FF7F197ECB7A2B90 = scripts\mp\gameobjects::createuseobject(_id_3AAA5FB58A6C2EB7, trigger, visuals, (0, 0, 32));
    scripts\mp\objidpoolmanager::objective_set_play_intro(_id_FF7F197ECB7A2B90.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(_id_FF7F197ECB7A2B90.objidnum, 0);
  }

  _id_FF7F197ECB7A2B90.objectivekey = _id_2810BD61A09D19F5.objectivekey;
  _id_FF7F197ECB7A2B90.iconname = _id_2810BD61A09D19F5.iconname;
  _id_FF7F197ECB7A2B90.id = "defuse_object";
  _id_FF7F197ECB7A2B90.trigger setusepriority(-4);
  _id_FF7F197ECB7A2B90.usecondition = ::_id_8192FDAD48C58795;
  _id_FF7F197ECB7A2B90.skiptouching = 1;

  switch (scripts\mp\utility\game::getgametype()) {
    case "cmd":
      _id_FF7F197ECB7A2B90 scripts\mp\gameobjects::allowuse("none");
      break;
    case "gwbomb":
      _id_FF7F197ECB7A2B90 scripts\mp\gameobjects::allowuse("friendly");
      break;
    default:
      _id_FF7F197ECB7A2B90 scripts\mp\gameobjects::allowuse("enemy");
      break;
  }

  if(istrue(level._id_826175089E4669D6)) {
    foreach(player in scripts\mp\utility\teams::getteamdata(game["attackers"], "players"))
    _id_FF7F197ECB7A2B90.trigger disableplayeruse(player);
  }

  _id_FF7F197ECB7A2B90 scripts\mp\gameobjects::setusetime(level.defusetime);
  _id_FF7F197ECB7A2B90 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  _id_FF7F197ECB7A2B90 scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_DEFUSE_EXPLOSIVES");
  _id_FF7F197ECB7A2B90.trigger setuseholdduration("duration_none");
  _id_FF7F197ECB7A2B90 scripts\mp\gameobjects::setvisibleteam("any");

  if(getdvarint("dvar_9CF963B64E1223E7", 0) == 1) {
    level.sdbombmodel.scriptable freescriptable();
    level.sdbombmodel.scriptable = spawnscriptable("offhand_2h_wm_briefcase_bomb_v0", _id_FF7F197ECB7A2B90.trigger.origin + (0, 0, 2), (0, 0, 0));
    level.sdbombmodel.scriptable setscriptablepartstate("bomb", "plantedAllies");
  } else if(scripts\mp\utility\game::getgametype() == "gwbomb") {
    _id_FF7F197ECB7A2B90 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defuse", "waypoint_defend");
    _id_FF7F197ECB7A2B90 thread bombradialfill(_id_BD6089532051AA97, "waypoint_defuse", "waypoint_defend");
  } else {
    _id_FF7F197ECB7A2B90 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb_defend_nt", "waypoint_defuse_nt");

    if(scripts\mp\utility\game::getgametype() != "cmd")
      _id_FF7F197ECB7A2B90 thread bombradialfill(_id_BD6089532051AA97, "waypoint_bomb_defend", "waypoint_defuse");
  }

  if(scripts\mp\utility\game::getgametype() == "cmd" && level.cmdrules == 2) {} else {
    _id_FF7F197ECB7A2B90.onbeginuse = ::bombzone_onbeginuse;
    _id_FF7F197ECB7A2B90.onenduse = ::bombzone_onenduse;
    _id_FF7F197ECB7A2B90.onuse = ::bombzone_onusedefuseobject;
    _id_FF7F197ECB7A2B90.resetprogress = level.resetprogress;
    _id_FF7F197ECB7A2B90.useweapon = makeweapon("briefcase_bomb_defuse_mp");
  }

  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(player.team, "bomb_defend", "bomb_defuse");
  _id_2810BD61A09D19F5 bombtimerwait(_id_2810BD61A09D19F5.objectivekey);
  _id_2810BD61A09D19F5.visuals[0] scripts\mp\gamelogic::stoptickingsound();
  _id_FF7F197ECB7A2B90.bombplanted = 0;

  if(level.gameended)
    return;
  else if(scripts\mp\utility\game::getgametype() == "sd" && level.bombdefused || scripts\mp\utility\game::getgametype() == "sr" && level.bombdefused) {
    _id_FF7F197ECB7A2B90 scripts\mp\gameobjects::deleteuseobject();
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "cmd" || scripts\mp\utility\game::getgametype() == "btm") {
    _id_FF7F197ECB7A2B90.showprogressforteam = undefined;
    _id_CE6A51C57BD722E1 = _id_2943BCA09C2A8006::bombhandler;

    if(_id_2810BD61A09D19F5.bombdefused) {
      _id_2810BD61A09D19F5 thread[[_id_CE6A51C57BD722E1]](player, "defused");
      _id_2810BD61A09D19F5.onuse = ::bombzone_onuseplantobject;

      if(isDefined(level.ddbombmodel[_id_2810BD61A09D19F5.objectivekey]))
        level.ddbombmodel[_id_2810BD61A09D19F5.objectivekey] delete();

      return;
    } else {
      level.bombexploded = level.bombexploded + 1;
      _id_2810BD61A09D19F5 thread[[_id_CE6A51C57BD722E1]](player, "explode", _id_BD6089532051AA97);
    }
  } else if(scripts\mp\utility\game::getgametype() == "gwbomb") {
    _id_FC92D300E26E37A0 = 0;

    if(_id_2810BD61A09D19F5.bombdefused) {
      player notify("bomb_defused" + _id_2810BD61A09D19F5.objectivekey);
      _id_2810BD61A09D19F5 notify("defused");
      _id_2810BD61A09D19F5 scripts\mp\gameobjects::allowuse("enemy");
      _id_2810BD61A09D19F5 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
      _id_2810BD61A09D19F5 scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES");
      _id_2810BD61A09D19F5.id = "bomb_zone";
      _id_2810BD61A09D19F5 scripts\mp\gameobjects::setusetime(level.planttime);
      _id_2810BD61A09D19F5 scripts\mp\gameobjects::setvisibleteam("any");
      _id_2810BD61A09D19F5.useweapon = makeweapon("briefcase_bomb_mp");
      _id_2810BD61A09D19F5.bombexploded = undefined;
      _id_2810BD61A09D19F5.onuse = ::bombzone_onuseplantobject;
      _id_FC92D300E26E37A0 = 1;
    } else {
      _id_7C07DABB66BABF80::_id_C0E928DEB12CFA4F(_id_2810BD61A09D19F5);
      _id_FF7F197ECB7A2B90.showprogressforteam = undefined;
      level.bombexploded = level.bombexploded + 1;
    }

    level.bombsplanted--;
    level._id_16FFD04B2B868C06[_id_BD6089532051AA97]--;
    _id_D793B74A850385E7 = getteamscore(_id_BD6089532051AA97) + level._id_16FFD04B2B868C06[_id_BD6089532051AA97];
    otherteam = scripts\mp\utility\game::getotherteam(_id_BD6089532051AA97)[0];
    _id_AC865A705B3E1162 = getteamscore(otherteam);
    _id_4FCA91C462F41CE6 = _id_D793B74A850385E7 - _id_AC865A705B3E1162;

    if(level.bombsplanted == 0 || _id_4FCA91C462F41CE6 < 0)
      level.timelimitoverride = 0;

    if(_id_FC92D300E26E37A0)
      return;
  } else
    level.bombexploded = level.bombexploded + 1;

  if(scripts\mp\utility\game::getgametype() == "cmd")
    level waittill("allow_bomb_explosion");

  setomnvar("ui_victory_condition_completed", 1);
  level notify("bomb_exploded" + _id_2810BD61A09D19F5.objectivekey);
  player thread scripts\mp\rank::scoreeventpopup("stat_1F1E94E8339E1FD1");
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_67D7D6463CAE5631");

  if(isDefined(level.sd_onbombtimerend))
    level thread[[level.sd_onbombtimerend]]();

  if(scripts\mp\utility\game::getgametype() == "cmd" || scripts\mp\utility\game::getgametype() == "gwbomb")
    _id_B085E4DE6D22E286 = _id_2810BD61A09D19F5.curorigin;
  else if(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "btm") {
    _id_B085E4DE6D22E286 = level.ddbombmodel[_id_2810BD61A09D19F5.objectivekey].origin;
    level.ddbombmodel[_id_2810BD61A09D19F5.objectivekey] delete();
  } else {
    _id_B085E4DE6D22E286 = level.sdbombmodel.origin;
    level.sdbombmodel delete();
  }

  _id_48AFE55B48D63DEB = _id_2810BD61A09D19F5.visuals[0].origin + (0, 0, 60);
  _id_53E1BAD01CD48721 = anglestoright(_id_2810BD61A09D19F5.visuals[0].angles) * 24;
  _id_EAD5FABECE32B615 = _id_48AFE55B48D63DEB + _id_53E1BAD01CD48721;
  _id_EAD5F7BECE32AF7C = _id_48AFE55B48D63DEB - _id_53E1BAD01CD48721;
  radiusdamage(_id_EAD5FABECE32B615, 512, 200, 20, player, "MOD_EXPLOSIVE", "bomb_site_mp");
  radiusdamage(_id_EAD5F7BECE32AF7C, 512, 200, 20, player, "MOD_EXPLOSIVE", "bomb_site_mp");

  if(isDefined(player)) {
    player scripts\mp\utility\stats::incpersstat("destructions", 1);
    player scripts\mp\persistence::statsetchild("round", "destructions", player.pers["destructions"]);
  }

  if(isDefined(_id_2810BD61A09D19F5.trigger.effect))
    effect = _id_2810BD61A09D19F5.trigger.effect;
  else if(level.mapname == "mp_faridah")
    effect = "faridah_bomb_explosion";
  else
    effect = "bomb_explosion";

  _id_EFDFC6EBE7A152C5 = spawnfx(scripts\engine\utility::getfx(effect), _id_B085E4DE6D22E286);
  triggerfx(_id_EFDFC6EBE7A152C5);
  physicsexplosionsphere(_id_B085E4DE6D22E286, 200, 100, 3);
  playrumbleonposition("grenade_rumble", _id_B085E4DE6D22E286);
  earthquake(0.5, 2.0, _id_B085E4DE6D22E286, 2000);
  playsoundatpos(_id_B085E4DE6D22E286, "exp_bombsite_lr");

  if(isDefined(_id_2810BD61A09D19F5.exploderindex))
    scripts\engine\utility::exploder(_id_2810BD61A09D19F5.exploderindex);
  else if(istrue(level._id_826175089E4669D6))
    _id_2810BD61A09D19F5.trigger setModel("sd_equipment_bombsite_crate_d");

  _id_FF7F197ECB7A2B90 scripts\mp\gameobjects::disableobject();

  if(isDefined(level.onobjectivecomplete))
    _id_FF7F197ECB7A2B90[[level.onobjectivecomplete]]("bombzone", self.objectivekey, player, game["attackers"], undefined);
}

_id_5784FD1CDDBD00D3() {
  switch (level.mapname) {
    case "mp_m_stadium":
      return 10;
    default:
      return 0;
  }
}

bombradialfill(_id_BD6089532051AA97, friendlyicon, _id_30F120A1EFC1DCBE) {
  level endon("game_ended");
  self._id_F271D42FAF329B89 = 0;
  _id_038FC7BD1495C4B2 = level.framedurationseconds;
  _id_A1DFE9D4920A43FA = _id_038FC7BD1495C4B2 * 1000;
  _id_4DFBAAA453518F16 = level.bombtimer * 1000;
  addtime = _id_A1DFE9D4920A43FA / _id_4DFBAAA453518F16;
  self.radialtimeobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(self.radialtimeobjid != -1) {
    _id_024C76FC549F7FD9 = "invisible";
    scripts\mp\objidpoolmanager::objective_add_objective(self.radialtimeobjid, _id_024C76FC549F7FD9, self.curorigin + self.offset3d);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.radialtimeobjid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(self.radialtimeobjid, 0);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.radialtimeobjid);
    self.showworldicon = 1;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(friendlyicon, _id_30F120A1EFC1DCBE, self.radialtimeobjid);
  self.bombplanted = 1;

  while(self.bombplanted) {
    _id_F271D42FAF329B89 = addtime;
    self._id_F271D42FAF329B89 = _id_F271D42FAF329B89;
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.radialtimeobjid, _id_BD6089532051AA97);
    scripts\mp\objidpoolmanager::objective_show_progress(self.radialtimeobjid, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.radialtimeobjid, _id_F271D42FAF329B89);
    addtime = min(addtime + _id_A1DFE9D4920A43FA / _id_4DFBAAA453518F16, 1.0);
    waitframe();
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(self.radialtimeobjid);

  if(isDefined(self))
    self.radialtimeobjid = -1;
}

initobjectivecam(objective) {
  _id_3580D0560B630F94 = undefined;
  _id_424C25FBBE8348E0 = getEntArray("sd_bombcam_start", "targetname");

  foreach(startnode in _id_424C25FBBE8348E0) {
    if(startnode.script_label == objective.objectivekey) {
      _id_3580D0560B630F94 = startnode;
      break;
    }
  }

  _id_51434CE2F3AC3CFF = [];

  if(isDefined(_id_3580D0560B630F94) && isDefined(_id_3580D0560B630F94.target)) {
    nextnode = getEnt(_id_3580D0560B630F94.target, "targetname");

    while(isDefined(nextnode)) {
      _id_51434CE2F3AC3CFF[_id_51434CE2F3AC3CFF.size] = nextnode;

      if(isDefined(nextnode.target)) {
        nextnode = getEnt(nextnode.target, "targetname");
        continue;
      }

      break;
    }
  }

  if(isDefined(_id_3580D0560B630F94) && _id_51434CE2F3AC3CFF.size) {
    cam = spawn("script_model", _id_3580D0560B630F94.origin);
    cam.origin = _id_3580D0560B630F94.origin;
    cam.angles = _id_3580D0560B630F94.angles;
    cam.path = _id_51434CE2F3AC3CFF;
    cam setModel("tag_origin");
    cam hide();
    return cam;
  } else
    return undefined;
}

runobjectivecam() {
  level notify("objective_cam");

  foreach(player in level.players) {
    if(!isai(player)) {
      player scripts\mp\utility\player::_freezecontrols(1);
      player visionsetnakedforplayer("black_bw", 0.5);
    }
  }

  wait 0.5;

  foreach(player in level.players) {
    if(!isai(player)) {
      player scripts\mp\utility\player::setusingremote("objective_cam");
      player _id_3B64EB40368C1450::set("objective_cam", "weapon", 0);
      player playerlinkweaponviewtodelta(self, "tag_player", 1, 180, 180, 180, 180, 1);
      player scripts\mp\utility\player::_freezecontrols(1);
      player setplayerangles(self.angles);
      player visionsetnakedforplayer("", 0.5);
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.path.size; _id_AC0E594AC96AA3A8++) {
    _id_1D5DB5EEFD5BE7C6 = 0;

    if(_id_AC0E594AC96AA3A8 == 0)
      _id_1D5DB5EEFD5BE7C6 = 5 / self.path.size / 2;

    _id_B6689F84DACEB617 = 0;

    if(_id_AC0E594AC96AA3A8 == self.path.size - 1)
      _id_B6689F84DACEB617 = 5 / self.path.size / 2;

    self moveTo(self.path[_id_AC0E594AC96AA3A8].origin, 5 / self.path.size, _id_1D5DB5EEFD5BE7C6, _id_B6689F84DACEB617);
    self rotateTo(self.path[_id_AC0E594AC96AA3A8].angles, 5 / self.path.size, _id_1D5DB5EEFD5BE7C6, _id_B6689F84DACEB617);
    wait(5 / self.path.size);
  }
}

bombtimerwait(objectivekey) {
  level endon("game_ended");
  level endon("bombs_canceled");
  level endon("bomb_defused" + objectivekey);
  _id_4DFAA92E2BCE1194 = int(level.bombtimer * 1000 + gettime());
  setomnvar("ui_bomb_timer_endtime" + objectivekey, _id_4DFAA92E2BCE1194);
  thread updatetimerconstant("ui_bomb_timer_endtime" + objectivekey, _id_4DFAA92E2BCE1194, level.bombtimer * 1000, objectivekey);
  level thread handlehostmigration(_id_4DFAA92E2BCE1194, objectivekey);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

updatetimerconstant(omnvar, _id_4DFAA92E2BCE1194, bombtimer, objectivekey) {
  level endon("bombs_canceled");
  level endon("bomb_defused" + objectivekey);
  self.startbombtime = gettime();

  while(gettime() < _id_4DFAA92E2BCE1194) {
    _id_3B5803E733581858 = gettime() - self.startbombtime;
    setomnvar(omnvar, int(gettime() + bombtimer - _id_3B5803E733581858));
    waitframe();
  }
}

handlehostmigration(_id_4DFAA92E2BCE1194, objectivekey) {
  level endon("game_ended");
  level endon("bomb_defused" + objectivekey);
  level endon("disconnect");
  level waittill("host_migration_begin");
  setomnvar("ui_bomb_timer_endtime" + objectivekey, 0);
  _id_3B5803E733581858 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(_id_3B5803E733581858 > 0)
    setomnvar("ui_bomb_timer_endtime" + objectivekey, _id_4DFAA92E2BCE1194 + _id_3B5803E733581858);
}

bombdefused(_id_530B0CC4B4365BC4) {
  if(scripts\mp\utility\game::getgametype() != "dd" && scripts\mp\utility\game::getgametype() != "cmd" && scripts\mp\utility\game::getgametype() != "btm" && scripts\mp\utility\game::getgametype() != "gwbomb")
    level.bombdefused = 1;

  _id_530B0CC4B4365BC4.bombdefused = 1;
  setbombtimeromnvars();
  level notify("bomb_defused" + _id_530B0CC4B4365BC4.objectivekey);

  if(isDefined(level.onobjectivecomplete))
    _id_530B0CC4B4365BC4[[level.onobjectivecomplete]]("bombzone", self.objectivekey, undefined, game["defenders"], undefined);
}

updatebombplantedomnvar(_id_BD6089532051AA97) {
  if(scripts\mp\utility\game::getgametype() == "cmd") {
    return;
  }
  if(isDefined(_id_BD6089532051AA97)) {
    if(_id_BD6089532051AA97 == "allies")
      setomnvar("ui_bomb_owner_team", 2);
    else
      setomnvar("ui_bomb_owner_team", 1);
  }

  if(isDefined(level.aplanted)) {
    if(level.aplanted)
      setomnvar("ui_bomb_planted_a", 1);
    else
      setomnvar("ui_bomb_planted_a", 0);
  }

  if(isDefined(level.bplanted)) {
    if(level.bplanted)
      setomnvar("ui_bomb_planted_b", 1);
    else
      setomnvar("ui_bomb_planted_b", 0);
  }
}

setbombtimeromnvars(_id_BD6089532051AA97) {
  updatebombplantedomnvar(_id_BD6089532051AA97);
}

bombzone_setupbombcase(_id_C7FAB14D7179F1FE, _id_7591ED99E87A77D3) {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  trigger = undefined;
  trigger = getEnt(_id_C7FAB14D7179F1FE + "_pickup_trig", "targetname");

  if(!isDefined(trigger)) {
    _id_E8F555A5BBCEAE47 = scripts\engine\utility::getStruct("sd_bomb_spawn", "script_noteworthy");

    if(isDefined(_id_E8F555A5BBCEAE47)) {
      trigger = spawn("trigger_radius", scripts\engine\utility::drop_to_ground(_id_E8F555A5BBCEAE47.origin, 10, -100), 0, 32, 32);
      trigger.angles = _id_E8F555A5BBCEAE47.angles;
    } else {
      scripts\engine\utility::error("No " + _id_C7FAB14D7179F1FE + "_pickup_trig trigger found in map.");
      return;
    }
  }

  if(isDefined(_id_7591ED99E87A77D3))
    trigger.origin = _id_7591ED99E87A77D3;

  visuals[0] = getEnt(_id_C7FAB14D7179F1FE, "targetname");

  if(getdvarint("dvar_9CF963B64E1223E7", 0) == 1 || !isDefined(visuals[0])) {
    visuals[0] = spawn("script_model", trigger.origin);
    _id_4810864C2F387829 = getEnt(_id_C7FAB14D7179F1FE, "targetname");

    if(isDefined(_id_4810864C2F387829))
      _id_4810864C2F387829 delete();

    if(!isDefined(visuals[0])) {
      scripts\engine\utility::error("No " + _id_C7FAB14D7179F1FE + " script_model found in map.");
      return;
    }
  }

  if(getdvarint("dvar_9CF963B64E1223E7", 0) == 1) {
    visuals[0].scriptable = spawnscriptable("offhand_2h_wm_briefcase_bomb_v0", trigger.origin + (0, 0, 2), (0, 0, 0));

    if(game["attackers"] == "allies")
      visuals[0].scriptable setscriptablepartstate("bomb", "neutralAllies");
    else
      visuals[0].scriptable setscriptablepartstate("bomb", "neutralAxis");
  } else
    visuals[0] setModel("offhand_2h_wm_briefcase_bomb_v0");

  visuals[0] setnonstick(1);
  visuals[0] = getadjustedfirstroundbombcaseposition(visuals[0]);
  trigger = getadjustedfirstroundbombcaseposition(trigger, 1);

  if(!level.multibomb) {
    level.sdbomb = scripts\mp\gameobjects::createcarryobject(game["attackers"], trigger, visuals, (0, 0, 32), undefined, 1);
    level.sdbomb scripts\mp\gameobjects::allowcarry("friendly");
    level.sdbomb.allowweapons = 1;
    level.sdbomb.requireslos = 1;
    level.sdbomb.onpickup = ::onpickup;
    level.sdbomb.ondrop = ::ondrop;
    level.sdbomb.firstpickup = 1;
    level thread bombsitewatcher();
    level.bombrespawnpoint = level.sdbomb.visuals[0].origin;
    level.bombrespawnangles = level.sdbomb.visuals[0].angles;
    level.sdbomb.visualgroundoffset = (0, 0, 0);
    level.sdbomb.visuals[0] _meth_5226227BCE83EBE9(1, game["attackers"]);
  } else {
    trigger delete();
    visuals[0] delete();
  }
}

getadjustedfirstroundbombcaseposition(ent, _id_69C8E45B8B8BB727) {
  origin = (0, 0, 0);
  angles = (0, 90, 0);

  switch (level.mapname) {
    case "mp_raid":
      if(scripts\mp\flags::gameflag("infil_will_run") && game["roundsPlayed"] == 0)
        origin = (-518, -959, 267);

      break;
    case "mp_petrograd":
      origin = (263, -2500, 146);
      break;
    case "mp_oilfield_gw":
    case "mp_observe_gw":
    case "mp_lone_gw":
    case "mp_historic_gw2":
    case "mp_dogtown_gw":
    case "mp_caves_gw":
    case "mp_sunken_gw":
    case "mp_regional_gw":
    case "mp_forsaken_gw":
    case "mp_nogales_gw2":
    case "mp_fishtown_gw":
    case "mp_sira_gw":
    case "mp_wartorn_gw":
      if(isDefined(level._id_D27F667E6320D465))
        _id_4810864C2F387829 = scripts\engine\utility::getStruct(level._id_D27F667E6320D465._id_8E9196B67A6D5933, "script_noteworthy");
      else
        _id_4810864C2F387829 = scripts\engine\utility::getStruct("sd_bomb_spawn", "script_noteworthy");

      if(isDefined(_id_4810864C2F387829)) {
        origin = scripts\engine\utility::drop_to_ground(_id_4810864C2F387829.origin, 10, -10);
        angles = _id_4810864C2F387829.angles;
      } else {}

      break;
    default:
      return ent;
  }

  if(istrue(_id_69C8E45B8B8BB727))
    ent.origin = origin;
  else {
    ent.origin = origin;
    ent.angles = angles;
  }

  return ent;
}

movebombcase(_id_6C53D859D582A421, _id_B98CF035C97EDEE9) {
  if(isDefined(level.sdbomb)) {
    level.sdbomb.trigger.origin = _id_6C53D859D582A421;
    level.sdbomb.visuals[0].origin = _id_6C53D859D582A421;
    level.sdbomb.visuals[0].angles = _id_B98CF035C97EDEE9;
    level.sdbomb.visuals[0] show();
    level.sdbomb scripts\mp\gameobjects::allowcarry("friendly");

    if(getdvarint("dvar_9CF963B64E1223E7", 0) == 1) {} else {
      level.sdbomb scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb");
      level.sdbomb scripts\mp\gameobjects::setvisibleteam("friendly");
    }

    level.sdbomb.allowweapons = 1;
    level.sdbomb.onpickup = ::onpickup;
    level.sdbomb.ondrop = ::ondrop;
  }
}

bombsitewatcher() {
  level endon("game_ended");

  for(;;) {
    level waittill("bomb_carrier_changed", player, iscarrying);

    if(isDefined(player)) {
      foreach(_id_EEF26A325310D3AF in level.objectives) {
        if(istrue(iscarrying)) {
          _id_EEF26A325310D3AF.trigger enableplayeruse(player);
          continue;
        }

        _id_EEF26A325310D3AF.trigger disableplayeruse(player);
      }
    }
  }
}

onpickup(player, _id_5760E0F038D1BAA3, defused) {
  _id_45AE884A82DAC71C = isDefined(player._id_C7945BE244726AD0) && player._id_C7945BE244726AD0 < gettime() + 1000;
  player.isbombcarrier = 1;

  if(isPlayer(player)) {
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = player;
    _id_7E2C53B0BCF117D9.eventname = "pickup";
    _id_7E2C53B0BCF117D9.position = player.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
    _id_548072087C9FD504::_id_7D42D3F8DD68280C(1, player.team, player getentitynumber());
  }

  player setclientomnvar("ui_carry_object_can_drop", 0);
  player setclientomnvar("ui_carrying_bomb", 1);
  setomnvar("ui_bomb_carrier", player getentitynumber());
  self.offset3d = (0, 0, 75);

  if(getdvarint("dvar_9CF963B64E1223E7", 0) == 1) {
    level.sdbombmodel linkTo(player, "tag_origin", (0, 0, 0), (0, 0, 0));
    level.sdbombmodel.scriptable scripts\common\utility::_id_6E506F39F121EA8A(player);

    if(game["attackers"] == "allies")
      level.sdbombmodel.scriptable setscriptablepartstate("bomb", "carriedAllies");
    else
      level.sdbombmodel.scriptable setscriptablepartstate("bomb", "carriedAxis");
  } else
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_escort_bomb", "codcaster_enemy_escort_bomb");

  if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[player.team]))
    player thread applybombcarrierclass();

  if(!_id_45AE884A82DAC71C)
    thread _id_7BC240FC69EA5205(player);

  if(!level.bombdefused) {
    if(!_id_45AE884A82DAC71C)
      thread scripts\mp\hud_util::_id_7B2653A588F28E29(player, "callout_bombpickup", "callout_bombpickup_team", "");

    if(istrue(self.firstpickup))
      self.firstpickup = 0;
  }

  if(level.codcasterenabled)
    player setgametypevip(1);

  scripts\mp\utility\game::logannouncement(player, undefined, "Bomb Picked Up", player.origin);
  level notify("bomb_carrier_changed", player, 1);
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(player.team, "bomb_escort", undefined, player, "bomb_plant");
}

_id_7BC240FC69EA5205(player) {
  self notify("sd_trigger_pickup_sound");
  self endon("sd_trigger_pickup_sound");
  self endon("dropped");
  level endon("game_ended");

  if(isDefined(player)) {
    team = player.pers["team"];
    otherteam = scripts\mp\utility\game::getotherteam(team)[0];
    scripts\mp\utility\sound::playsoundonplayers(game["bomb_recovered_sound"], game["attackers"]);
    player playSound("mp_bomb_pickup");

    if(!istrue(level.bombdefused)) {
      waittime = getdvarfloat("dvar_E5A5BD503D175EC4", 0.5);

      if(waittime > 0)
        wait(waittime);

      if(!istrue(level.gameended)) {
        _id_0A675744864C65C1 = "bomb_pickup";

        if(istrue(self.firstpickup))
          _id_0A675744864C65C1 = "bomb_pickup_first";

        _id_21D6D994B0F4FAF1 = [];

        if(isDefined(player)) {
          _id_21D6D994B0F4FAF1[_id_21D6D994B0F4FAF1.size] = player;
          level thread playerdelayedvo(player, _id_0A675744864C65C1);
        }

        if(isDefined(team))
          level thread teamdelayedvo(team, _id_21D6D994B0F4FAF1);
      }
    }
  }
}

ondrop(player) {
  _id_430E559C7DF5972D = isDefined(self._id_C7945BE244726AD0) && self._id_C7945BE244726AD0 < gettime() + 1000;
  level notify("bomb_carrier_changed", player, 0);
  setomnvar("ui_bomb_carrier", -1);
  self.offset3d = (0, 0, 32);

  if(level.codcasterenabled) {
    if(isDefined(player))
      player setgametypevip(0);
  }

  if(getdvarint("dvar_9CF963B64E1223E7", 0) == 1) {} else
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb");

  if(!_id_430E559C7DF5972D)
    scripts\mp\utility\sound::playsoundonplayers(game["bomb_dropped_sound"], game["attackers"]);

  if(isDefined(player)) {
    player.isbombcarrier = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(player.team, "bomb_pickup");
  }

  if(!level.bombplanted && isDefined(level.bombresettimer) && level.bombresettimer > 0)
    thread waitforbombreset(level.bombresettimer);
}

waitforbombreset(timelimit) {
  level endon("game_ended");
  level endon("bomb_carrier_changed");
  wait(timelimit);
  scripts\mp\weapons::equipmentdeletevfx(self.visuals[0].origin, self.visuals[0].angles);
  movebombcase(level.bombrespawnpoint, level.bombrespawnangles);
}

enablemultibombui() {
  foreach(player in level.players) {
    if(!isai(player))
      player setclientomnvar("ui_carrying_bomb", player.pers["team"] == game["attackers"]);
  }
}

respawnbombcase() {
  level endon("game_ended");
  wait 5;

  if(level.multibomb)
    enablemultibombui();
  else
    movebombcase(level.bombrespawnpoint, level.bombrespawnangles);
}

advancebombcase() {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombrespawnpoint = level.curobj.visuals[0].origin + (0, 0, 48);
  level.bombrespawnangles = level.curobj.visuals[0].angles;

  if(level.multibomb)
    enablemultibombui();
  else
    movebombcase(level.bombrespawnpoint, level.bombrespawnangles);
}

applybombcarrierclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!self isonground())
    waitframe();

  self.pers["gamemodeLoadout"] = level.sd_loadout[self.team];
  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  self.gamemode_chosenclass = self.class;
  scripts\mp\class::_id_A16868D4DCD81A4B();
  self notify("faux_spawn");
  self.gameobject_fauxspawn = 1;
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

removebombcarrierclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!self isonground())
    waitframe();

  self.pers["gamemodeLoadout"] = undefined;
  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

bombzone_awardgenericbombzonemedals(attacker, victim) {
  foreach(_id_EEF26A325310D3AF in level.objectives) {
    if(!isDefined(_id_EEF26A325310D3AF.bombdefusetrig.origin)) {
      continue;
    }
    planted = istrue(_id_EEF26A325310D3AF.bombplanted);
    passed = distsquaredcheck(attacker.origin, victim.origin, scripts\engine\utility::ter_op(planted, _id_EEF26A325310D3AF.bombdefusetrig.origin, _id_EEF26A325310D3AF.trigger.origin));

    if(passed) {
      if(scripts\mp\utility\game::getgametype() == "dd" && scripts\mp\utility\game::inovertime()) {
        if(attacker.team == _id_EEF26A325310D3AF.ownerteam) {
          attacker thread scripts\mp\rank::scoreeventpopup(scripts\engine\utility::ter_op(planted, "stat_6FF0E80C570DACA1", "stat_E54C7B357A5A826C"));
          attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE(scripts\engine\utility::ter_op(planted, "stat_2D96CED878338CD2", "stat_5A3B180273BE47B1"));
        } else {
          attacker thread scripts\mp\rank::scoreeventpopup("stat_E54C7B357A5A826C");
          attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A3B180273BE47B1");
        }

        continue;
      }

      if(victim.team == game["defenders"]) {
        attacker thread scripts\mp\rank::scoreeventpopup(scripts\engine\utility::ter_op(planted, "stat_6FF0E80C570DACA1", "stat_E54C7B357A5A826C"));
        attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE(scripts\engine\utility::ter_op(planted, "stat_2D96CED878338CD2", "stat_5A3B180273BE47B1"));
        continue;
      }

      attacker thread scripts\mp\rank::scoreeventpopup(scripts\engine\utility::ter_op(planted, "stat_E54C7B357A5A826C", "stat_6FF0E80C570DACA1"));
      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE(scripts\engine\utility::ter_op(planted, "stat_5A3B180273BE47B1", "stat_2D96CED878338CD2"));
    }
  }
}

distsquaredcheck(_id_86C1C8628B1D55F8, _id_F7DED1FDB02A123D, _id_76227CD0036993E3) {
  _id_AAE76E7732B9A9DA = distancesquared(_id_76227CD0036993E3, _id_86C1C8628B1D55F8);
  _id_3D29A24F32F790B1 = distancesquared(_id_76227CD0036993E3, _id_F7DED1FDB02A123D);

  if(_id_AAE76E7732B9A9DA < 90000 || _id_3D29A24F32F790B1 < 90000)
    return 1;
  else
    return 0;
}

_id_8192FDAD48C58795(player) {
  return !scripts\mp\utility\player::isinlaststand(player);
}

playerdelayedvo(player, _id_0A675744864C65C1) {
  _id_C924752368853F99 = scripts\mp\utility\game::gettimepassed() / 1000;

  if(istrue(level.infilvotiming))
    _id_74B5B12BB6514385 = 8;
  else
    _id_74B5B12BB6514385 = 5;

  waittime = _id_74B5B12BB6514385 - _id_C924752368853F99;

  if(waittime > 0)
    wait(waittime);

  if(isDefined(player))
    player scripts\mp\utility\dialog::leaderdialogonplayer(_id_0A675744864C65C1);
}

teamdelayedvo(team, _id_21D6D994B0F4FAF1) {
  _id_C924752368853F99 = scripts\mp\utility\game::gettimepassed() / 1000;

  if(istrue(level.infilvotiming))
    _id_74B5B12BB6514385 = 8;
  else
    _id_74B5B12BB6514385 = 5;

  waittime = _id_74B5B12BB6514385 - _id_C924752368853F99;

  if(waittime > 0)
    wait(waittime);

  scripts\mp\utility\dialog::leaderdialog("bomb_achieve", team, "bomb", _id_21D6D994B0F4FAF1);
}

resetuiomnvargamemode() {
  self setclientomnvar("ui_carrying_bomb", 0);
}

setteaminhuddatafromteamname(_id_FABF84450735DD93) {
  if(_id_FABF84450735DD93 == "axis")
    self setteaminhuddata(1);
  else if(_id_FABF84450735DD93 == "allies")
    self setteaminhuddata(2);
  else
    self setteaminhuddata(0);
}

_id_F1CE924CD6279917(_id_EEF26A325310D3AF) {
  self endon("death");
  level endon("game_ended");
  _id_EEF26A325310D3AF endon("death");
  self _meth_5226227BCE83EBE9(1, game["defenders"]);
  level waittill("bomb_planted");

  if(_id_EEF26A325310D3AF.bombplanted)
    self _meth_5226227BCE83EBE9(1, game["attackers"]);
  else
    self _meth_5226227BCE83EBE9(0);
}