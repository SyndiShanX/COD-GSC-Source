/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_mobile_armory.gsc
*****************************************************/

init() {
  level._effect["poi_mobile_armory_available"] = loadfx("vfx/iw8_br/gameplay/vfx_br_poi_armory_white.vfx");
  level._effect["poi_mobile_armory_charging"] = loadfx("vfx/iw8_br/gameplay/vfx_br_poi_armory_red.vfx");
  level.br_mobilearmories = [];
  level.br_mobile_armory_enabled = getdvarint("dvar_FAF37A1BB44F33A1", 0) != 0;
  level.mobilearmoryplundercost = getdvarint("dvar_9C45DD1E0492AB50", 1);
  _id_1F6BC044DD1738AB::initstatemachineforpoitype("mobile_armory");
  _id_1F6BC044DD1738AB::registerstatecallbacksforpoitype("mobile_armory", 0, ::_onenterdefaultstate, undefined, ::_onexitdefaultstate);
  _id_1F6BC044DD1738AB::registerstatecallbacksforpoitype("mobile_armory", 1, ::_onenterchargingstate, undefined, ::_onexitchargingstate);
  _id_1F6BC044DD1738AB::registerstatecallbacksforpoitype("mobile_armory", 2, ::_onenteractivestate, undefined, ::_onexitactivestate);
  _id_1F6BC044DD1738AB::registerstatecallbacksforpoitype("mobile_armory", 3, ::_onentercooldownstate, undefined, undefined);
}

spawnmobilearmory(struct) {
  if(!istrue(level.br_mobile_armory_enabled)) {
    return;
  }
  _id_F474D8D44BE22A81 = spawn("script_model", struct.origin);

  if(isDefined(struct.angles))
    _id_F474D8D44BE22A81.angles = struct.angles;

  _id_F474D8D44BE22A81 setModel("veh8_mil_lnd_stango_static");
  _id_7347F41687BA2720 = scripts\engine\utility::getStruct(struct.target, "targetname");

  if(!isDefined(_id_F474D8D44BE22A81.interactiveelement)) {
    _id_9D9F9751C9583C1B = (0, 0, 3);
    interactiveelement = spawn("script_model", _id_7347F41687BA2720.origin + _id_9D9F9751C9583C1B);

    if(isDefined(_id_7347F41687BA2720.angles))
      interactiveelement.angles = _id_7347F41687BA2720.angles;

    interactiveelement setModel("military_crate_large_stackable_01");
    interactiveelement setCursorHint("HINT_NOICON");
    interactiveelement setuseholdduration("duration_medium");
    interactiveelement sethintdisplayfov(120);
    interactiveelement setusefov(120);
    interactiveelement setuserange(80);
    interactiveelement setusepriority(-1);
    _id_F474D8D44BE22A81.interactiveelement = interactiveelement;
  }

  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "active", (0, 0, 0), "hud_icon_br_mobile_armory");
    scripts\mp\objidpoolmanager::update_objective_onentity(objectiveiconid, _id_F474D8D44BE22A81);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objectiveiconid);
    _id_F474D8D44BE22A81.objectiveiconid = objectiveiconid;
    _id_F474D8D44BE22A81 thread _mobilearmorymanageminimapicon();
  } else {}

  level.br_mobilearmories[level.br_mobilearmories.size] = _id_F474D8D44BE22A81;
  return _id_F474D8D44BE22A81;
}

_mobilearmorymanageminimapicon() {
  _id_65E09ECB5157FFE1 = self;
  _id_65E09ECB5157FFE1 endon("death");
  _id_C5452D63F815C7E9 = 1.0;
  _id_E2329E812C2919BB = 5000;
  _id_65E09ECB5157FFE1.playersinrange = [];

  for(;;) {
    wait(_id_C5452D63F815C7E9);

    if(!istrue(level.br_prematchstarted)) {
      continue;
    }
    foreach(player in _id_65E09ECB5157FFE1.playersinrange) {
      if(isDefined(player))
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_65E09ECB5157FFE1.objectiveiconid, player);
    }

    _id_65E09ECB5157FFE1.playersinrange = scripts\mp\utility\player::getplayersinradius(_id_65E09ECB5157FFE1.origin, _id_E2329E812C2919BB);

    foreach(player in _id_65E09ECB5157FFE1.playersinrange)
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(_id_65E09ECB5157FFE1.objectiveiconid, player);
  }
}

onprematchdone() {
  foreach(_id_65E09ECB5157FFE1 in level.br_mobilearmories)
  _id_65E09ECB5157FFE1 _id_1F6BC044DD1738AB::gotopoistate("mobile_armory", 0);
}

_mobilearmoryendusethink() {
  _id_65E09ECB5157FFE1 = self;
  _id_65E09ECB5157FFE1 notify("mobileArmoryUseThinkEnd");
}

_mobilearmoryusethink() {
  _id_65E09ECB5157FFE1 = self;
  _id_65E09ECB5157FFE1 endon("death");
  _id_65E09ECB5157FFE1 _mobilearmoryendusethink();
  _id_65E09ECB5157FFE1 endon("mobileArmoryUseThinkEnd");
  _id_3268DF12A22D1A03 = _id_65E09ECB5157FFE1 _id_1F6BC044DD1738AB::getcurrentpoistate();
  _id_65E09ECB5157FFE1.recordedusers = [];

  for(;;) {
    _id_65E09ECB5157FFE1.interactiveelement waittill("trigger", player);

    if(_id_65E09ECB5157FFE1 _id_1F6BC044DD1738AB::getcurrentpoistate() != _id_3268DF12A22D1A03) {
      return;
    }
    if(_id_65E09ECB5157FFE1 _id_1F6BC044DD1738AB::getcurrentpoistate() == 0) {
      if(player.plundercount < level.mobilearmoryplundercost) {
        player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/NOT_ENOUGH_PLUNDER_ACTIVATE");
        continue;
      } else
        player _id_6AFF3948CF4CCA03::playersetplundercount(player.plundercount - level.mobilearmoryplundercost);
    }

    if(_id_3268DF12A22D1A03 == 0) {
      _id_65E09ECB5157FFE1.ownerteam = player.team;
      _id_65E09ECB5157FFE1 thread _id_1F6BC044DD1738AB::gotopoistate("mobile_armory", 1);
      return;
    } else if(_id_3268DF12A22D1A03 == 2) {
      _id_9C71EF3EE76C7193 = 0;

      foreach(_id_EEE718E33217DC9E in _id_65E09ECB5157FFE1.recordedusers) {
        if(_id_EEE718E33217DC9E == player) {
          _id_9C71EF3EE76C7193 = 1;
          break;
        }
      }

      if(_id_9C71EF3EE76C7193)
        player scripts\mp\hud_message::showerrormessage("MP/BR_MOBILE_ARMORY_ALREADY_USED");
      else
        player thread _mobilearmorychooseclass(_id_65E09ECB5157FFE1);
    }
  }
}

_mobilearmorychooseclass(_id_65E09ECB5157FFE1) {
  player = self;
  player endon("death");
  player endon("disconnect");
  level endon("game_ended");

  if(isai(player)) {
    return;
  }
  if(player isswitchingweapon() || player isreloading() || player ismantling() || player isthrowinggrenade() || player israisingweapon() || player ismeleeing()) {
    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/MOBILE_ARMORY_ACTION_ERROR");
    return;
  }

  player setclientomnvar("ui_options_menu", 2);

  for(;;) {
    player waittill("luinotifyserver", _id_7148C1A6F25491F8, _id_0AC2E2DC79F3D177);

    if(_id_7148C1A6F25491F8 != "class_select") {
      continue;
    }
    _id_2D36749FDFFC49B4 = scripts\mp\menus::getclasschoice(_id_0AC2E2DC79F3D177);
    player.pers["class"] = _id_2D36749FDFFC49B4;
    player.class = _id_2D36749FDFFC49B4;
    player scripts\mp\class::preloadandqueueclass(_id_2D36749FDFFC49B4);
    player scripts\mp\class::swaploadout();
    player.gearchangedfromloadout = 0;
    _id_65E09ECB5157FFE1.recordedusers[_id_65E09ECB5157FFE1.recordedusers.size] = player;
    _id_053C0AA79EB3CB6C = 50;
    _id_9111B9A018285894 = player getweaponslistprimaries();

    foreach(weaponobj in _id_9111B9A018285894) {
      weaponname = getcompleteweaponname(weaponobj);

      if(getsubstr(weaponname, 0, 4) == "alt_") {
        continue;
      }
      clipsize = weaponclipsize(weaponobj);
      _id_CB2DBF59AAEEC569 = int(min(_id_053C0AA79EB3CB6C, clipsize));
      player setweaponammoclip(weaponobj, _id_CB2DBF59AAEEC569);
    }

    _id_724736FCF0FB6604::br_ammo_update_weapons(player);
  }
}

_onenterdefaultstate(_id_65E09ECB5157FFE1) {
  _id_4430B08D5A2D47BF = _id_1F6BC044DD1738AB::getinteractiveoutlineasset();
  _id_65E09ECB5157FFE1.interactiveelement hudoutlineenable(_id_4430B08D5A2D47BF);
  _id_65E09ECB5157FFE1.interactiveelement makeusable();
  _id_65E09ECB5157FFE1.interactiveelement setHintString(&"MP/BR_ACTIVATE_MOBILE_ARMORY");
  _id_65E09ECB5157FFE1 thread _mobilearmoryusethink();
  _id_018E46C38378F618 = scripts\engine\utility::getfx("poi_mobile_armory_available");
  playFXOnTag(_id_018E46C38378F618, _id_65E09ECB5157FFE1, "tag_origin");
}

_onexitdefaultstate(_id_65E09ECB5157FFE1) {
  _id_65E09ECB5157FFE1.interactiveelement hudoutlinedisable();
  _id_65E09ECB5157FFE1 _mobilearmoryendusethink();
  _id_65E09ECB5157FFE1.interactiveelement makeunusable();
  _id_018E46C38378F618 = scripts\engine\utility::getfx("poi_mobile_armory_available");
  stopFXOnTag(_id_018E46C38378F618, _id_65E09ECB5157FFE1, "tag_origin");
}

_onenterchargingstate(_id_65E09ECB5157FFE1) {
  _id_3058DBC123E6C741 = getdvarfloat("dvar_718BB8E6FBB6438E", 10.0);
  _id_65E09ECB5157FFE1 thread _id_1F6BC044DD1738AB::gotopoistateontimer("mobile_armory", 2, _id_3058DBC123E6C741);
  _id_1F6BC044DD1738AB::showmiscmessagetoteam(_id_65E09ECB5157FFE1.ownerteam, "br_mobile_armory_charging", _id_3058DBC123E6C741, int(_id_3058DBC123E6C741 * 1000));
  _id_90D6A5C6923319DE = scripts\engine\utility::getfx("poi_mobile_armory_charging");
  playFXOnTag(_id_90D6A5C6923319DE, _id_65E09ECB5157FFE1, "tag_origin");
  _id_65E09ECB5157FFE1 playLoopSound("truck_reversebeep_lp");
}

_onexitchargingstate(_id_65E09ECB5157FFE1) {
  _id_90D6A5C6923319DE = scripts\engine\utility::getfx("poi_mobile_armory_charging");
  stopFXOnTag(_id_90D6A5C6923319DE, _id_65E09ECB5157FFE1, "tag_origin");
  _id_65E09ECB5157FFE1 stoploopsound();
}

_onenteractivestate(_id_65E09ECB5157FFE1) {
  _id_4430B08D5A2D47BF = _id_1F6BC044DD1738AB::getinteractiveoutlineasset();
  _id_65E09ECB5157FFE1.interactiveelement hudoutlineenable(_id_4430B08D5A2D47BF);
  level thread _id_1E4A61DB11011446::teamsplashbr("br_mobile_armory_activate", _id_65E09ECB5157FFE1.player, _id_65E09ECB5157FFE1.ownerteam);
  _id_65E09ECB5157FFE1.interactiveelement makeusable();
  _id_65E09ECB5157FFE1.interactiveelement setHintString(&"MP/BR_USE_MOBILE_ARMORY");
  _id_65E09ECB5157FFE1 thread _mobilearmoryusethink();
  activetimeseconds = getdvarfloat("dvar_E9149BFE8D43E5A0", 15.0);
  _id_65E09ECB5157FFE1 thread _id_1F6BC044DD1738AB::gotopoistateontimer("mobile_armory", 3, activetimeseconds);
  _id_1F6BC044DD1738AB::showmiscmessagetoteam(_id_65E09ECB5157FFE1.ownerteam, "br_mobile_armory_active", activetimeseconds, int(activetimeseconds * 1000));
}

_onexitactivestate(_id_65E09ECB5157FFE1) {
  _id_65E09ECB5157FFE1.interactiveelement hudoutlinedisable();
  _id_65E09ECB5157FFE1 _mobilearmoryendusethink();
  _id_65E09ECB5157FFE1.interactiveelement makeunusable();
  _id_1F6BC044DD1738AB::showmiscmessagetoteam(_id_65E09ECB5157FFE1.ownerteam, "br_mobile_armory_cooldown", 3);
  _id_65E09ECB5157FFE1.ownerteam = undefined;
}

_onentercooldownstate(_id_65E09ECB5157FFE1) {
  _id_ECDA8DCB2C2CA2D2 = getdvarfloat("dvar_8F082ED019C7F63D", 120.0);
  _id_65E09ECB5157FFE1 thread _id_1F6BC044DD1738AB::gotopoistateontimer("mobile_armory", 0, _id_ECDA8DCB2C2CA2D2);
}