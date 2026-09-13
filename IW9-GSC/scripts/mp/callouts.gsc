/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\callouts.gsc
***********************************************/

init() {
  level.calloutglobals = spawnStruct();
  level.calloutglobals.callouttable = "mp/map_callouts/" + level.mapname + "_callouts.csv";
  createcalloutareaidmap();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && getdvarint("dvar_E4187D1543C7477E", 0) == 0) {
    areatriggers = getEntArray("callout_area", "targetname");

    foreach(_id_C1E5E178D5D956E4 in areatriggers)
    _id_C1E5E178D5D956E4 delete();

    return;
  }

  level.calloutglobals.areatriggers = getEntArray("callout_area", "targetname");

  foreach(_id_C1E5E178D5D956E4 in level.calloutglobals.areatriggers)
  _id_C1E5E178D5D956E4 thread calloutareathink();

  thread monitorplayers();
}

createcalloutareaidmap() {
  _id_584994FAB4A8712B = level.calloutglobals;
  _id_584994FAB4A8712B.areaidmap = [];
  _id_584994FAB4A8712B.areaidmap["none"] = -1;

  if(!tableexists(level.calloutglobals.callouttable)) {
    return;
  }
  _id_CB89110314447B2F = 0;

  for(;;) {
    id = tablelookupbyrow(level.calloutglobals.callouttable, _id_CB89110314447B2F, 0);

    if(!isDefined(id) || id == "") {
      break;
    }

    id = int(id);
    type = tablelookupbyrow(level.calloutglobals.callouttable, _id_CB89110314447B2F, 3);

    if(type != "area") {} else {
      ref = tablelookupbyrow(level.calloutglobals.callouttable, _id_CB89110314447B2F, 1);
      _id_584994FAB4A8712B.areaidmap[ref] = id;
    }

    _id_CB89110314447B2F++;
  }
}

monitorplayers() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    player thread clearcalloutareaondeath();
    player setplayercalloutarea("none");
  }
}

calloutareathink() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    player setplayercalloutarea(self.script_noteworthy, self);
  }
}

setplayercalloutarea(_id_E90349C02ADFB3A0, trigger) {
  if(!isDefined(_id_E90349C02ADFB3A0)) {
    return;
  }
  if(isDefined(self.calloutarea) && self.calloutarea == _id_E90349C02ADFB3A0) {
    return;
  }
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(isDefined(self.calloutarea) && _id_E90349C02ADFB3A0 != "none" && self.calloutarea != "none")
      return;
  }

  self.calloutarea = _id_E90349C02ADFB3A0;

  if(isDefined(trigger))
    thread watchplayerleavingcalloutarea(trigger, trigger.script_noteworthy);

  _id_49996EBEBBBBF375 = level.calloutglobals.areaidmap[_id_E90349C02ADFB3A0];

  if(isDefined(_id_49996EBEBBBBF375)) {
    self setclientomnvar("ui_callout_area_id", _id_49996EBEBBBBF375);

    if(level.codcasterenabled) {
      _id_721982228624D657 = scripts\mp\utility\player::get_players_watching(1, 0);

      foreach(spectator in _id_721982228624D657) {
        if(spectator _meth_8420670EAFC8D391())
          spectator setclientomnvar("ui_callout_area_id", _id_49996EBEBBBBF375);
      }
    }
  } else if(_id_E90349C02ADFB3A0 != "none")
    return;
}

watchplayerleavingcalloutarea(_id_C1E5E178D5D956E4, _id_E90349C02ADFB3A0) {
  self endon("death_or_disconnect");

  for(;;) {
    if(self.calloutarea != _id_E90349C02ADFB3A0) {
      return;
    }
    if(!self istouching(_id_C1E5E178D5D956E4)) {
      setplayercalloutarea("none");
      return;
    }

    wait 0.5;
  }
}

clearcalloutareaondeath() {
  self endon("disconnect");

  for(;;) {
    self waittill("death");
    setplayercalloutarea("none");
  }
}