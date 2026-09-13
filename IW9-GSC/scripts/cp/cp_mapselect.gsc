/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_mapselect.gsc
***********************************************/

init() {
  level._effect["map_target_mark"] = loadfx("vfx/iw8_cp/vfx_marker_map_target.vfx");
  _id_8BB8AC075D5A87DC();
}

_id_8BB8AC075D5A87DC() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("map_select", ["usability", "killstreaks", "supers", "gesture", "fire", "weapon_switch", "allow_movement", "offhand_weapons", "crouch", "prone", "allow_jump", "mantle"]);
}

tablet_enabled_check_dvar() {
  if(getdvarint("dvar_91CEAE054E93350C", 0) == 0)
    return 0;

  return 0;
}

getselectmappoint(info, _id_CDCE0F8BE900C487, _id_EDC5BB5A4B3DD2FF) {
  if(!isDefined(info)) {
    return;
  }
  issuper = isDefined(self.super) && self.super == info;
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("map_select", 0);
  self setsoundsubmix("mp_killstreak_overlay");
  _id_FB5BCF10CCC2C5DF = 0;

  if(!isDefined(_id_CDCE0F8BE900C487))
    _id_CDCE0F8BE900C487 = 1;

  if(!isDefined(_id_EDC5BB5A4B3DD2FF))
    _id_EDC5BB5A4B3DD2FF = 0;

  thread watchmapselectexit(info, issuper);
  thread watchownertimeoutdeath();
  mappointinfo = undefined;
  _id_2B7CF61AF0CB9960 = info.streakname;

  if(istrue(issuper))
    _id_2B7CF61AF0CB9960 = info.staticdata.ref;

  scripts\cp_mp\utility\killstreak_utility::starttabletscreen(_id_2B7CF61AF0CB9960, 0.05);
  mappointinfo = gathermappointinfo(_id_CDCE0F8BE900C487, _id_EDC5BB5A4B3DD2FF);

  if(isDefined(self)) {
    time = 0.75;

    if(istrue(self._id_4A2F2F50A9020E2E))
      time = 0.0;

    scripts\cp_mp\utility\killstreak_utility::stoptabletscreen(_id_2B7CF61AF0CB9960, time);

    if(scripts\cp_mp\utility\player_utility::isreallyalive(self))
      _id_3B64EB40368C1450::_id_588F2307A3040610("map_select");

    self clearsoundsubmix("mp_killstreak_overlay");
  }

  return mappointinfo;
}

gathermappointinfo(_id_CDCE0F8BE900C487, _id_EDC5BB5A4B3DD2FF) {
  self endon("disconnect");
  _id_5F98D5A0F5A0C736 = 1;

  if(_id_CDCE0F8BE900C487 <= 1) {
    self setclientomnvar("ui_map_select_uses", -1);
    _id_5F98D5A0F5A0C736 = 0;
  }

  self.mapselectpickcounter = 0;
  self.previousmapselectioninfo = undefined;
  _id_9F17B7A25B48C492 = [];
  thread watchmapselectweapon();

  if(istrue(_id_5F98D5A0F5A0C736)) {
    self setclientomnvar("ui_map_select_uses", _id_CDCE0F8BE900C487);
    self setclientomnvar("ui_map_select_count", _id_CDCE0F8BE900C487);
  }

  _id_6E586A99FA56A20F = undefined;

  while(self.mapselectpickcounter < _id_CDCE0F8BE900C487) {
    _id_6E586A99FA56A20F = waittill_confirm_or_cancel("confirm_location", "cancel_location", "death");

    if(!isDefined(_id_6E586A99FA56A20F) || _id_6E586A99FA56A20F.string == "death") {
      self._id_4A2F2F50A9020E2E = 1;
      _id_9F17B7A25B48C492 = undefined;
      break;
    } else if(_id_6E586A99FA56A20F.string == "cancel_location") {
      _id_9F17B7A25B48C492 = undefined;
      break;
    }

    _id_4D08A3DDEC28E17B = _id_6E586A99FA56A20F.location + (0, 0, 10000);
    _id_3CB14AEA5687B8F6 = _id_6E586A99FA56A20F.location - (0, 0, 10000);
    _id_F590BCBAFFB210C5 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstancesforall();
    _id_D4C559B594AD3DF9 = level.activekillstreaks;
    _id_B9D5783A4F34EFBC = scripts\engine\utility::array_combine(_id_F590BCBAFFB210C5, _id_D4C559B594AD3DF9);
    contentoverride = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0, 0, 0, 0);
    _id_9083EA775F3B0CD7 = scripts\engine\trace::ray_trace(_id_4D08A3DDEC28E17B, _id_3CB14AEA5687B8F6, _id_B9D5783A4F34EFBC, contentoverride, 0, 1);
    _id_6E586A99FA56A20F.location = _id_9083EA775F3B0CD7["position"];
    _id_9F17B7A25B48C492[_id_9F17B7A25B48C492.size] = _id_6E586A99FA56A20F;
    self.mapselectpickcounter++;

    if(istrue(_id_5F98D5A0F5A0C736))
      self setclientomnvar("ui_map_select_uses", _id_CDCE0F8BE900C487 - self.mapselectpickcounter);
  }

  level notify("vision_set_change_request", "", self, 0);
  self notify("map_select_exit", _id_6E586A99FA56A20F);
  return _id_9F17B7A25B48C492;
}

watchmapselectweapon() {
  self endon("map_select_exit");

  for(;;) {
    currentweapon = self getcurrentweapon();

    if(currentweapon.basename != "ks_remote_map_cp") {
      self notify("cancel_location");
      break;
    }

    waitframe();
  }
}

watchmapselectexit(info, issuper) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("map_select_exit", _id_1D7A120A5DF60069);
  stopmapselectsequence(info, issuper, _id_1D7A120A5DF60069);
}

watchownertimeoutdeath() {
  self endon("disconnect");
  self endon("map_select_exit");
  level endon("game_ended");
  self setclientomnvar("ui_location_selection_countdown", gettime() + 30000);
  scripts\engine\utility::waittill_any_timeout_1(30, "death");
  self notify("cancel_location");
}

startmapselectsequence(_id_FB5BCF10CCC2C5DF, _id_EDC5BB5A4B3DD2FF, _id_7426E996C9EB34D3, _id_3922786267CCC2A8, info) {
  if(!isDefined(self.pers["startedMapSelect"])) {
    self.pers["startedMapSelect"] = [];
    thread _id_B5FC9B44B6730955();
  }

  if(isDefined(info)) {
    if(_id_05834A9B56F5426C(info)) {
      triggeroneoffradarsweep(self);
      _id_D8A763B4FBA17240 = _id_13B26FCC6DDE1C17(info);
      self.pers["startedMapSelect"][_id_D8A763B4FBA17240] = info;
    }
  }

  if(!isDefined(_id_FB5BCF10CCC2C5DF))
    _id_FB5BCF10CCC2C5DF = 0;

  if(!isDefined(_id_EDC5BB5A4B3DD2FF))
    _id_EDC5BB5A4B3DD2FF = 0;

  if(!isDefined(_id_7426E996C9EB34D3))
    _id_7426E996C9EB34D3 = "circle_marker";

  if(!isDefined(_id_3922786267CCC2A8))
    _id_3922786267CCC2A8 = 0;

  self beginlocationselection(_id_FB5BCF10CCC2C5DF, _id_EDC5BB5A4B3DD2FF, _id_7426E996C9EB34D3, 1, _id_3922786267CCC2A8);
}

stopmapselectsequence(info, issuper, _id_1D7A120A5DF60069) {
  self.mapselectpickcounter = undefined;
  self.mapselectdircounter = undefined;
  self.previousmapselectioninfo = undefined;

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    if(istrue(issuper))
      self notify("super_finished_with_deploy_weapon");
    else
      info notify("killstreak_finished_with_deploy_weapon");
  }

  if(_id_1D7A120A5DF60069.string == "confirm_location" || _id_1D7A120A5DF60069.string == "death") {
    _id_D8A763B4FBA17240 = _id_13B26FCC6DDE1C17(info);
    self.pers["startedMapSelect"] = scripts\engine\utility::array_remove_index(self.pers["startedMapSelect"], _id_D8A763B4FBA17240, 1);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);

  if(isDefined(self)) {
    self endlocationselection();
    self setclientomnvar("ui_map_select_count", -1);
  }
}

_id_05834A9B56F5426C(info) {
  _id_0E4A2BC835644693 = self.pers["startedMapSelect"];

  if(isDefined(_id_0E4A2BC835644693)) {
    foreach(instance in _id_0E4A2BC835644693) {
      if(!_id_A8D72277FD0A66CC(instance, info))
        return 0;
      else if(!_id_E687E3855C8F00FF(instance, info))
        return 0;
    }
  }

  return 1;
}

_id_A8D72277FD0A66CC(_id_755A09C275461972, _id_921A13367F73AB4D) {
  if(isDefined(_id_755A09C275461972.staticdata) && isDefined(_id_921A13367F73AB4D.staticdata)) {
    if(_id_755A09C275461972.staticdata.ref == _id_921A13367F73AB4D.staticdata.ref && _id_755A09C275461972.lifeid == _id_921A13367F73AB4D.lifeid)
      return 0;
  }

  return 1;
}

_id_E687E3855C8F00FF(_id_755A09C275461972, _id_921A13367F73AB4D) {
  if(isDefined(_id_755A09C275461972.streakname) && isDefined(_id_921A13367F73AB4D.streakname)) {
    if(_id_755A09C275461972.streakname == _id_921A13367F73AB4D.streakname && _id_755A09C275461972.lifeid == _id_921A13367F73AB4D.lifeid)
      return 0;
  }

  return 1;
}

_id_B5FC9B44B6730955() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("death");
    self.pers["startedMapSelect"] = [];
  }
}

_id_13B26FCC6DDE1C17(info) {
  _id_D8A763B4FBA17240 = undefined;

  if(isDefined(info.staticdata))
    _id_D8A763B4FBA17240 = info.staticdata.ref;
  else if(isDefined(info.streakname))
    _id_D8A763B4FBA17240 = info.streakname;

  if(!isDefined(_id_D8A763B4FBA17240)) {}

  return _id_D8A763B4FBA17240;
}

waittill_confirm_or_cancel(_id_12E3586B64301806, _id_9BA4FCFEB48763BA, _id_0CD73FF319D57C07) {
  if((!isDefined(_id_12E3586B64301806) || _id_12E3586B64301806 != "death") && (!isDefined(_id_9BA4FCFEB48763BA) || _id_9BA4FCFEB48763BA != "death") && (!isDefined(_id_0CD73FF319D57C07) || _id_0CD73FF319D57C07 != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_12E3586B64301806))
    childthread waittill_return(_id_12E3586B64301806, ent);

  if(isDefined(_id_9BA4FCFEB48763BA))
    childthread waittill_return(_id_9BA4FCFEB48763BA, ent);

  if(isDefined(_id_0CD73FF319D57C07))
    childthread waittill_return(_id_0CD73FF319D57C07, ent);

  ent waittill("returned", location, angle, string);
  ent notify("die");
  _id_6E586A99FA56A20F = spawnStruct();
  _id_6E586A99FA56A20F.location = location;
  _id_6E586A99FA56A20F.angles = angle;
  _id_6E586A99FA56A20F.string = string;
  return _id_6E586A99FA56A20F;
}

waittill_return(_id_12E3586B64301806, ent) {
  if(_id_12E3586B64301806 != "death")
    self endon("death");

  ent endon("die");
  self waittill(_id_12E3586B64301806, location, angle);
  ent notify("returned", location, angle, _id_12E3586B64301806);
}

setmaplocationselection() {}

set_uav_radarstrength(player) {
  _id_67B1A4EC977A1C68 = getuavstrengthmax();
  player.radarstrength = _id_67B1A4EC977A1C68;
}