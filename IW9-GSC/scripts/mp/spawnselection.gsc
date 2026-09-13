/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\spawnselection.gsc
***********************************************/

init() {
  if(_id_167619FE3D0CFF00())
    setDvar("scr_game_disablespawncamera", 0);
  else
    return;

  level.usec130spawn = getdvarint("scr_game_c130_spawn", 0) == 1;
  level.usesquadspawn = getdvarint("scr_game_squad_spawn", 0) == 1;
  level.usesquadspawnselection = getdvarint("scr_game_spawnselection_squad", 1) == 1;
  level.spawnsquadleaderonly = getdvarint("dvar_FC11053944AB5F7E", 0) == 1;
  level._id_F15BECFBC1B01A1B = getdvarint("dvar_EE75F0B9D9E03349", 1) == 1;
  level._id_A50B22FA98674A50 = getdvarint("dvar_EF54007B614237DA", 0) == 1;
  level._id_6F40C2B6970373C0 = getdvarint("dvar_8FE41B9FFB4E54AA", 1) == 1;
  level._id_757EC02DF4D678F5 = getdvarint("dvar_537448D6935DD02B", 1) == 1;
  level._id_111C5F085A86C2F0 = ::_id_F83711DD7546DB96;
  level._id_ABA39CAF969CD3F7 = ::_id_DC659688380C4195;
  level.checkspawnselectionafk = scripts\mp\utility\game::matchmakinggame() && getdvarint("dvar_0A66999457B70DA2", 1) == 1;
  level._id_F13131261B4C6AD5 = getdvarint("dvar_06560B9B4C5FCBAB", 0) == 1;
  level._id_CA4FE20B267C4F54 = getdvarint("dvar_9FE20711E5BCEE42", 0) == 1;
  level._id_4D2556C1D0F4893E = getdvarint("dvar_A959156DFF929A38", 0) == 1;
  level._id_7119A108C4BA4D2C = getdvarint("dvar_4CE0B40AAC178E56", 0) == 1;
  level._id_C0E8540C63B7AF50 = getdvarfloat("scr_spawnselection_obj_owned_partial_pct", 0);
  level._id_F335C53DB1D6DD34 = getdvarint("dvar_8E9E98F013DB1AC4", 1) == 1;
  level.availablespawnlocations = [];

  foreach(_id_F90358454413407F in level.teamnamelist)
  level.availablespawnlocations[_id_F90358454413407F] = [];

  if(!isDefined(level._id_D280C5FDB0036183))
    level._id_D280C5FDB0036183 = ::_id_DC3A172BF923D9B3;

  level thread initspawns();
  scripts\common\ui::lui_registercallback("tac_ops_spawn_focus_changed", ::endcondition_focuschanged);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::isplayerindanger_think);
}

_id_DC3A172BF923D9B3() {
  return 1;
}

delayspawntoc130() {}

churnareas() {
  _id_45C9DAE424956501 = [];
  _id_45C9DAE424956501[0] = "lane01_";
  _id_45C9DAE424956501[1] = "lane02_";
  _id_45C9DAE424956501[2] = "lane03_";
  _id_265F87A0122DCFE7 = [];
  _id_265F87A0122DCFE7[_id_265F87A0122DCFE7.size] = _id_45C9DAE424956501[0] + (randomint(3) + 1);
  _id_265F87A0122DCFE7[_id_265F87A0122DCFE7.size] = _id_45C9DAE424956501[1] + (randomint(3) + 1);
  _id_265F87A0122DCFE7[_id_265F87A0122DCFE7.size] = _id_45C9DAE424956501[2] + (randomint(3) + 1);
  setspawnlocations(_id_265F87A0122DCFE7, "allies");
  _id_4E35AC8FC8C9F4CE = [];
  _id_4E35AC8FC8C9F4CE[_id_265F87A0122DCFE7.size] = _id_45C9DAE424956501[0] + (randomint(3) + 1);
  _id_4E35AC8FC8C9F4CE[_id_265F87A0122DCFE7.size] = _id_45C9DAE424956501[1] + (randomint(3) + 1);
  _id_4E35AC8FC8C9F4CE[_id_265F87A0122DCFE7.size] = _id_45C9DAE424956501[2] + (randomint(3) + 1);
  setspawnlocations(_id_4E35AC8FC8C9F4CE, "axis");
  updatespawnareas();

  for(;;) {
    wait 10.0;
    _id_265F87A0122DCFE7 = [];
    _id_265F87A0122DCFE7[_id_265F87A0122DCFE7.size] = _id_45C9DAE424956501[0] + (randomint(3) + 1);
    _id_265F87A0122DCFE7[_id_265F87A0122DCFE7.size] = _id_45C9DAE424956501[1] + (randomint(3) + 1);
    _id_265F87A0122DCFE7[_id_265F87A0122DCFE7.size] = _id_45C9DAE424956501[2] + (randomint(3) + 1);
    setspawnlocations(_id_265F87A0122DCFE7, "allies");
    _id_4E35AC8FC8C9F4CE = [];
    _id_4E35AC8FC8C9F4CE[_id_4E35AC8FC8C9F4CE.size] = _id_45C9DAE424956501[0] + (randomint(3) + 1);
    _id_4E35AC8FC8C9F4CE[_id_4E35AC8FC8C9F4CE.size] = _id_45C9DAE424956501[1] + (randomint(3) + 1);
    _id_4E35AC8FC8C9F4CE[_id_4E35AC8FC8C9F4CE.size] = _id_45C9DAE424956501[2] + (randomint(3) + 1);
    setspawnlocations(_id_4E35AC8FC8C9F4CE, "axis");
    updatespawnareas();
  }
}

setspawnlocations(_id_F05F5B44B0E2757F, team) {
  _id_FCCD72853AB541BE = [];

  foreach(loc in level.availablespawnlocations[team]) {
    if(issubstr(loc, "dynamic") || issubstr(loc, "vehicle") || issubstr(loc, "squad"))
      _id_FCCD72853AB541BE[_id_FCCD72853AB541BE.size] = loc;
  }

  level.availablespawnlocations[team] = [];

  foreach(ref in _id_F05F5B44B0E2757F) {
    if(!scripts\engine\utility::array_contains(level.availablespawnlocations[team], ref))
      level.availablespawnlocations[team][level.availablespawnlocations[team].size] = ref;
  }

  foreach(ref in _id_FCCD72853AB541BE) {
    if(!scripts\engine\utility::array_contains(level.availablespawnlocations[team], ref))
      level.availablespawnlocations[team][level.availablespawnlocations[team].size] = ref;
  }
}

allowspawnlocation(ref, team) {
  if(!scripts\engine\utility::array_contains(level.availablespawnlocations[team], ref))
    level.availablespawnlocations[team][level.availablespawnlocations[team].size] = ref;
}

removespawnlocation(ref, team) {
  availablespawnlocations = [];

  foreach(location in level.availablespawnlocations[team]) {
    if(location != ref)
      availablespawnlocations[availablespawnlocations.size] = location;
  }

  level.availablespawnlocations[team] = availablespawnlocations;
}

updatespawnareas() {
  level notify("tac_ops_map_changed");
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(!isDefined(level._id_A88344345B7590C8))
    level._id_A88344345B7590C8 = ::setupspawnlocations;

  [[level._id_A88344345B7590C8]]();

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict" || scripts\mp\utility\game::getgametype() == "risk" || scripts\mp\utility\game::getgametype() == "bigctf")
    setupspawninfluencezones();
}

setupspawnlocations() {
  while(!isDefined(level.gamemodespawnpointnames))
    waitframe();

  level.spawnselectionlocations = [];

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodespawnpointnames[_id_F90358454413407F]);
    scripts\mp\spawnlogic::registerspawnpoints(_id_F90358454413407F, _id_29D9D2428185616D);

    foreach(s in _id_29D9D2428185616D) {
      if(!isDefined(s.target) || s.target == "") {
        continue;
      }
      targets = getEntArray(s.target, "targetname");

      if(!isDefined(targets) || targets.size == 0)
        targets = scripts\engine\utility::getStructArray(s.target, "targetname");

      if(targets.size == 0) {
        continue;
      }
      target = undefined;

      if(targets.size == 1)
        target = targets[0];
      else if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
        foreach(ent in targets) {
          if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == level.localeid) {
            target = ent;
            break;
          }
        }
      } else {
        _id_84D4866087B00608 = undefined;

        foreach(ent in targets) {
          distsq = distancesquared(s.origin, ent.origin);

          if(!isDefined(_id_84D4866087B00608) || distsq < _id_84D4866087B00608) {
            target = ent;
            _id_84D4866087B00608 = distsq;
          }
        }
      }

      if(!isDefined(target)) {
        continue;
      }
      ref = target.script_label;
      team = _id_F90358454413407F;

      if(isDefined(target.script_team) && scripts\mp\utility\teams::isgameplayteam(target.script_team)) {
        if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_quarry2" && target.targetname == "gw_fob_03_safe_axis")
          team = "axis";
        else if(team == "team_three" || team == "team_four") {} else
          team = target.script_team;
      }

      if(isDefined(level.spawnselectionlocations[ref]) && isDefined(level.spawnselectionlocations[ref][team])) {
        loc = level.spawnselectionlocations[ref][team];

        if(!scripts\engine\utility::array_contains(loc.spawnpoints, s))
          loc.spawnpoints[loc.spawnpoints.size] = s;

        continue;
      }

      struct = spawnStruct();
      struct.origin = target.origin;
      struct.angles = target.angles;
      struct.spawnpoints = [];
      struct.spawnpoints[0] = s;

      if(!issubstr(ref, "safe"))
        initspawnarea(team, struct, ref);
      else
        level.spawnselectionlocations[ref][team] = struct;
    }

    foreach(key, _id_5A9CFC3686B1FD8D in level.spawnselectionlocations) {
      if(isDefined(_id_5A9CFC3686B1FD8D[_id_F90358454413407F]))
        scripts\mp\spawnlogic::registerspawnset(key + "_" + _id_F90358454413407F, _id_5A9CFC3686B1FD8D[_id_F90358454413407F].spawnpoints);
    }
  }

  level.usespawnselection = _id_167619FE3D0CFF00() && level.spawnselectionlocations.size > 0;

  if(level.usespawnselection)
    level.getspawnpoint = ::getspawnpoint;
}

initspawnarea(team, struct, ref) {
  typeid = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, ref);
  _id_1C75A457E19F3B75 = spawn("script_model", struct.origin);
  _id_1C75A457E19F3B75 setModel("tag_origin");
  struct.anchorentity = _id_1C75A457E19F3B75;
  struct.typeid = typeid;
  struct.typeref = ref;
  struct.owner = "allies";

  if(!issubstr(ref, "HQ") && !issubstr(ref, "vehicle")) {
    _id_53DB5BA095078996 = undefined;

    if(isDefined(level.localeid))
      _id_53DB5BA095078996 = getlabelid(ref + "_" + level.localeid);

    if(!isDefined(_id_53DB5BA095078996) || _id_53DB5BA095078996 == -1)
      struct.labelid = typeid;
    else
      struct.labelid = _id_53DB5BA095078996;
  } else
    struct.labelid = typeid;

  if(isDefined(struct.dynamicent))
    _id_1C75A457E19F3B75 linkTo(struct.dynamicent);

  level.spawnselectionlocations[ref][team] = struct;
}

getlabelid(ref) {
  labelid = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, ref);

  if(!isDefined(labelid))
    labelid = 0;

  return labelid;
}

setanchorent(ref, team, ent) {
  level.spawnselectionlocations[ref][team].anchorentity = ent;
}

setupspawninfluencezones() {
  level.spawninfluencezones = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 5; _id_AC0E594AC96AA3A8++) {
    trigger = scripts\cp_mp\utility\game_utility::getlocaleent("gw_fob_0" + _id_AC0E594AC96AA3A8 + "_spawnInfluenceZone");

    if(!isDefined(trigger)) {
      continue;
    }
    scripts\mp\utility\trigger::makeenterexittrigger(trigger, ::spawninfluencezone_onusebegin, ::spawninfluencezone_onuseend);
    trigger.touchlist = [];
    level.spawninfluencezones["gw_fob_0" + _id_AC0E594AC96AA3A8] = trigger;
  }
}

spawninfluencezone_onusebegin(ent, trigger) {
  if(isDefined(ent.classname) && ent.classname == "script_vehicle") {
    return;
  }
  trigger.touchlist = scripts\engine\utility::array_add(trigger.touchlist, ent);
}

spawninfluencezone_onuseend(ent, trigger) {
  if(isDefined(ent.classname) && ent.classname == "script_vehicle") {
    return;
  }
  trigger.touchlist = scripts\engine\utility::array_remove(trigger.touchlist, ent);
}

isteamtouching(team) {
  found = 0;
  _id_92CC828BFCF717C8 = [];

  foreach(_id_F90358454413407F in self.touchlist) {
    if(!isDefined(_id_F90358454413407F)) {
      continue;
    }
    if(isDefined(_id_F90358454413407F.team) && _id_F90358454413407F.team == team)
      found = 1;

    _id_92CC828BFCF717C8[_id_92CC828BFCF717C8.size] = _id_F90358454413407F;
  }

  self.touchlist = _id_92CC828BFCF717C8;
  return found;
}

getspawnpoint() {
  scripts\mp\spawnlogic::deactivateallspawnsets();

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodestartspawnpointnames[self.team]);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
    return spawnpoint;
  }

  spawnpoint = undefined;
  self.wassquadspawned = 0;

  if(isDefined(self.selectedspawnarea)) {
    scripts\mp\utility\player::printspawnmessage("spawnSelection::getSpawnPoint() = " + self.selectedspawnarea);

    if(issubstr(self.selectedspawnarea, "squad")) {
      index = undefined;

      if(self.selectedspawnarea == "squad_leader")
        index = level.squaddata[self.team][self._id_0FF97225579DE16A]._id_D6EE3E704C6731D4._id_3F78C6A0862F9E25;
      else
        index = int(getsubstr(self.selectedspawnarea, self.selectedspawnarea.size - 1, self.selectedspawnarea.size));

      _id_F0EA4030349A33D5 = level.squaddata[self.team][self._id_0FF97225579DE16A].players[index];
      spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(_id_F0EA4030349A33D5);
      _id_F0EA4030349A33D5 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_90720F3E9E9E20B1");
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5FE4192C1FD1BE4C");
      self.wassquadspawned = 1;

      if(isDefined(_id_F0EA4030349A33D5.vehicle)) {
        self.spawningintovehicle = 1;
        self.vehiclespawninginto = _id_F0EA4030349A33D5.vehicle.vehiclename;
      }

      scripts\mp\utility\stats::incpersstat("spawnSelectSquad", 1);
      _id_F0EA4030349A33D5 scripts\mp\utility\stats::incpersstat("timesSelectedAsSquadLeader", 1);
    } else if(issubstr(self.selectedspawnarea, "dynamic")) {
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");
      thread _id_27C2DB69A21775A0::spawnplayertoc130();
    } else if(issubstr(self.selectedspawnarea, "vehicle")) {
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");
      _id_A5D118F040F60DB0 = level.spawnselectionlocations[self.selectedspawnarea][self.team].dynamicent;
      _id_0EAF618DB8FDDBE9 = -200;
      heightoffset = 64;
      spawnpoint.origin = _id_A5D118F040F60DB0.origin + anglesToForward(_id_A5D118F040F60DB0.angles) * _id_0EAF618DB8FDDBE9 + (0, 0, heightoffset);
      spawnpoint.angles = (0, _id_A5D118F040F60DB0.angles[1], 0);
      seat = scripts\cp_mp\vehicles\vehicle_occupancy::_id_D3D95972F58AD2BC(_id_A5D118F040F60DB0);

      if(isDefined(seat) && istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(_id_A5D118F040F60DB0)) && (istrue(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle(_id_A5D118F040F60DB0 scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD())._id_1AD50A59DA38C8F5) || seat == "driver")) {
        data = spawnStruct();
        data.useonspawn = 1;
        data.enterstartwaitmsg = "spawned_player";
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(_id_A5D118F040F60DB0, seat, self, data);
      } else {
        exitboundinginfo = scripts\cp_mp\vehicles\vehicle_occupancy::_id_517F60905F08BF96(_id_A5D118F040F60DB0);
        _id_B8E7E41430673DD2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(_id_A5D118F040F60DB0.vehiclename);
        _id_0DE71EEF0AD57608 = 0;

        foreach(ref, direction in _id_B8E7E41430673DD2.exitdirections) {
          if(direction == "top" || direction == "inside") {
            position = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getexitposition(_id_A5D118F040F60DB0, self, ref, exitboundinginfo, 1);
            _id_7862C7C7ADE2B42E = _id_B8E7E41430673DD2.exitoffsets[ref];

            if(isDefined(position)) {
              spawnpoint.origin = position;
              self._id_F109E15FAE27DDC2 = _id_A5D118F040F60DB0;
              self._id_9066885BD8B59751 = _id_7862C7C7ADE2B42E;
              thread scripts\cp_mp\vehicles\vehicle::vehicle_preventplayercollisiondamagefortimeafterexit(_id_A5D118F040F60DB0, self);
              break;
            } else if(!_id_0DE71EEF0AD57608) {
              _id_0DE71EEF0AD57608 = 1;
              _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(_id_A5D118F040F60DB0 scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
              _id_7862C7C7ADE2B42E = _id_E2818AD39A3341B4.exitoffsets[ref];
              spawnpoint.origin = _id_A5D118F040F60DB0.origin + rotatevector(_id_7862C7C7ADE2B42E, _id_A5D118F040F60DB0.angles);
              self._id_F109E15FAE27DDC2 = _id_A5D118F040F60DB0;
              self._id_9066885BD8B59751 = _id_7862C7C7ADE2B42E;
              thread scripts\cp_mp\vehicles\vehicle::vehicle_preventplayercollisiondamagefortimeafterexit(_id_A5D118F040F60DB0, self);
            }
          }
        }
      }

      driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(_id_A5D118F040F60DB0);
      _id_7731ADEF63E19B0C = _id_A5D118F040F60DB0 scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
      _id_4AC41C9583912B8F = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle(_id_7731ADEF63E19B0C)._id_51B047BD40D984FE;

      if(isDefined(driver) && isDefined(_id_4AC41C9583912B8F) && _id_4AC41C9583912B8F != "")
        driver thread scripts\mp\utility\points::_id_0366980B6A8796AE(_func_1823FF50BB28148D(_id_4AC41C9583912B8F));

      self.spawningintovehicle = 1;
      scripts\mp\utility\stats::incpersstat("spawnSelectVehicle", 1);
    } else if(self.selectedspawnarea == "tac_insert") {
      if(isDefined(self.setspawnpoint)) {
        self.ti_spawn = 1;
        spawnpoint = self.setspawnpoint;
      }
    } else {
      if(isDefined(level.spawninfluencezones)) {
        trigger = undefined;
        keys = getarraykeys(level.spawninfluencezones);

        foreach(key in keys) {
          if(key == self.selectedspawnarea)
            trigger = level.spawninfluencezones[key];
        }

        if(isDefined(trigger) && trigger isteamtouching(scripts\mp\utility\game::getotherteam(self.team)[0])) {
          ref = self.selectedspawnarea + "_safe_" + self.team;
          spawnset = level.spawnglobals.spawnsets[ref];

          if(!isDefined(spawnset))
            ref = self.selectedspawnarea + "_" + self.team;
        } else
          ref = self.selectedspawnarea + "_" + self.team;
      } else
        ref = self.selectedspawnarea + "_" + self.team;

      scripts\mp\spawnlogic::activatespawnset(ref, 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");

      if(issubstr(self.selectedspawnarea, "alliesHQ") || issubstr(self.selectedspawnarea, "axisHQ"))
        scripts\mp\utility\stats::incpersstat("spawnSelectBase", 1);
      else
        scripts\mp\utility\stats::incpersstat("spawnSelectFlag", 1);
    }
  } else
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");

  if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
    _id_279BB6642EC5E695 = self getspectatingplayer();

    if(isDefined(_id_279BB6642EC5E695) && isDefined(self._id_0FF97225579DE16A) && self.team == _id_279BB6642EC5E695.team && self._id_0FF97225579DE16A == _id_279BB6642EC5E695._id_0FF97225579DE16A) {
      spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(_id_279BB6642EC5E695);
      _id_279BB6642EC5E695 thread scripts\mp\utility\points::givexpwithtext("stat_90720F3E9E9E20B1");
      thread scripts\mp\utility\points::givexpwithtext("stat_5FE4192C1FD1BE4C");
      self.wassquadspawned = 1;
    }
  }

  return spawnpoint;
}

refreshplayerspawnareaomnvars() {
  for(_id_7DF4A8A7599BCCA3 = 0; _id_7DF4A8A7599BCCA3 < 16; _id_7DF4A8A7599BCCA3++) {
    self setclientomnvar("ui_tom_spawn_entity_" + _id_7DF4A8A7599BCCA3, undefined);
    self setclientomnvar("ui_tom_spawn_id_" + _id_7DF4A8A7599BCCA3, -1);
  }

  if(isDefined(self.forcedavailablespawnlocation))
    picklane(self.forcedavailablespawnlocation);

  thread evaluatefobspawns();

  if(istrue(level.usesquadspawnselection))
    thread evaluatesquadspawn();

  if(isDefined(self.setspawnpoint))
    thread _id_7DE3F8F504024FDE();
}

evaluatefobspawns() {
  self endon("disconnect");
  self endon("end_respawn");
  self notify("evaluateFOBSpawns");
  self endon("evaluateFOBSpawns");
  _id_0E62653E4F73622A = [];

  for(;;) {
    if(_id_0E62653E4F73622A.size > level.availablespawnlocations[self.team].size) {
      thread refreshplayerspawnareaomnvars();
      return;
    }

    index = 0;

    foreach(_id_F90358454413407F in level.availablespawnlocations[self.team]) {
      if(!isDefined(_id_0E62653E4F73622A[index])) {
        break;
      }

      if(_id_0E62653E4F73622A[index].location != _id_F90358454413407F) {
        thread refreshplayerspawnareaomnvars();
        return;
      }

      index++;
    }

    index = 0;

    foreach(_id_F90358454413407F in level.availablespawnlocations[self.team]) {
      selected = level.spawnselectionlocations[_id_F90358454413407F][self.team];

      if(index == _id_0E62653E4F73622A.size) {
        data = spawnStruct();
        data.location = undefined;
        data.entity = undefined;
        data.id = undefined;
        _id_0E62653E4F73622A[_id_0E62653E4F73622A.size] = data;
      }

      if(!isDefined(_id_0E62653E4F73622A[index].location))
        _id_0E62653E4F73622A[index].location = _id_F90358454413407F;

      if(!isDefined(_id_0E62653E4F73622A[index].entity)) {
        _id_0E62653E4F73622A[index].entity = selected.anchorentity;
        self setclientomnvar("ui_tom_spawn_entity_" + index, selected.anchorentity);
      }

      indanger = 0;
      _id_A81AF2627597688A = 0;
      _id_8D03C3781F6B70C0 = 0;
      _id_5E41EE78365ED202 = 0;

      if(isDefined(selected.objectivekey)) {
        indanger = istrue(selected.indanger);
        _id_A81AF2627597688A = level.objectives[selected.objectivekey].ownerteam == self.team;
      } else if(issubstr(_id_F90358454413407F, "vehicle")) {
        _id_C6577C1382E4B40D = selected.dynamicent;

        if(isDefined(_id_C6577C1382E4B40D) && !istrue(_id_C6577C1382E4B40D.isdestroyed)) {
          indanger = istrue(_id_C6577C1382E4B40D.indanger);
          _id_8D03C3781F6B70C0 = hassquadmatepassengers(_id_C6577C1382E4B40D, self);

          if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(_id_C6577C1382E4B40D).size == 0 || !istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(_id_C6577C1382E4B40D)))
            _id_5E41EE78365ED202 = 1;
        }
      }

      id = selected.labelid;

      if(indanger)
        id = id + 128;

      if(_id_A81AF2627597688A)
        id = id + 256;

      if(istrue(_id_5E41EE78365ED202))
        id = id + 1024;

      if(istrue(_id_8D03C3781F6B70C0))
        id = id + 2048;

      if(isDefined(selected.objectivekey)) {
        id = id + 32768;
        objectiveindex = level.objectives[selected.objectivekey].objidnum;
        id = id + (objectiveindex << 16);
      }

      if(!isDefined(_id_0E62653E4F73622A[index].id) || _id_0E62653E4F73622A[index].id != id) {
        _id_0E62653E4F73622A[index].id = id;
        self setclientomnvar("ui_tom_spawn_id_" + index, id);
      }

      index++;
    }

    waitframe();
  }
}

isobjectiveindanger(objectivekey, team) {
  obj = level.objectives[objectivekey];

  switch (obj.id) {
    case "bomb_zone":
      if(istrue(level._id_B307135DBCEF5A38))
        return team != obj.ownerteam;
      else
        return 0;
    case "defuse_object":
      if(!level._id_A09DCE2C531D0BAB)
        return 1;

      if(istrue(level._id_F335C53DB1D6DD34))
        return team != obj.ownerteam;

      _id_763491D0037DFF6E = level._id_C0E8540C63B7AF50 > 0.0;
      _id_D590566A3430702F = isDefined(obj._id_F271D42FAF329B89) && obj._id_F271D42FAF329B89 <= level._id_C0E8540C63B7AF50;

      if(_id_763491D0037DFF6E)
        return !_id_D590566A3430702F;
      else
        return 0;
    case "destroyed_site":
      return 0;
    default:
      _id_90EE2572B0FE338A = obj.ownerteam != team;
      _id_A5250821FB1BEA6A = !level._id_F13131261B4C6AD5 && obj.stalemate;
      isblocked = !level._id_CA4FE20B267C4F54 && obj.captureblocked;
      isbeingcaptured = !level._id_4D2556C1D0F4893E && (obj.claimteam != "none" && obj.claimteam != team);
      _id_A3A90D8C2AEE0964 = !level._id_7119A108C4BA4D2C && istrue(obj.spawnpointdanger);
      _id_ADFC287FDBF815AA = level._id_C0E8540C63B7AF50 > 0.0 && obj.curprogress / obj.usetime <= level._id_C0E8540C63B7AF50;

      if(_id_ADFC287FDBF815AA) {
        _id_A5250821FB1BEA6A = 0;
        isblocked = 0;
        isbeingcaptured = 0;
        isbeingcaptured = 0;
      }

      return _id_90EE2572B0FE338A || _id_A5250821FB1BEA6A || isblocked || isbeingcaptured || _id_A3A90D8C2AEE0964;
  }

  return 0;
}

isvehicleindanger(_id_C6577C1382E4B40D) {
  currenttime = gettime();
  _id_E2ADEC8D28854D3F = isDefined(_id_C6577C1382E4B40D) && (isDefined(_id_C6577C1382E4B40D.lasttimedamaged) && _id_C6577C1382E4B40D.lasttimedamaged + 5000 > currenttime);
  oob = isDefined(_id_C6577C1382E4B40D) && _id_C6577C1382E4B40D scripts\mp\outofbounds::istouchingoobtrigger();
  _id_BD1F266BC80DA88D = 0;

  if(isDefined(_id_C6577C1382E4B40D.team)) {
    _id_35C341A22B58D17D = scripts\common\utility::playersnear(_id_C6577C1382E4B40D.origin, 384);

    foreach(player in _id_35C341A22B58D17D) {
      if(isDefined(player) && player.team != _id_C6577C1382E4B40D.team && isalive(player) && !isDefined(player.fauxdead)) {
        if(abs(_id_C6577C1382E4B40D.origin[2] - player.origin[2]) < 100) {
          _id_BD1F266BC80DA88D = 1;
          break;
        }
      }
    }
  }

  return _id_E2ADEC8D28854D3F || oob || _id_BD1F266BC80DA88D;
}

_id_167619FE3D0CFF00() {
  if(!isDefined(level.usespawnselection))
    level.usespawnselection = getdvarint("scr_game_usespawnselection", 0) != 0;

  return level.usespawnselection;
}

vehicleindangertracking(_id_C6577C1382E4B40D) {
  _id_C6577C1382E4B40D endon("death");
  _id_C6577C1382E4B40D.indanger = 0;
  _id_55D25B77E9FB1759 = getdvarfloat("dvar_B5BC6252B2764D8C", 0.15);

  for(;;) {
    currenttime = gettime();
    burningdown = istrue(_id_C6577C1382E4B40D.burningdown);
    _id_83D6B23061E5BF09 = scripts\cp_mp\utility\weapon_utility::islockedonto(_id_C6577C1382E4B40D);
    _id_F7772E25266681DE = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_canspawninto(_id_C6577C1382E4B40D);
    _id_E2ADEC8D28854D3F = isDefined(_id_C6577C1382E4B40D) && (isDefined(_id_C6577C1382E4B40D.lasttimedamaged) && _id_C6577C1382E4B40D.lasttimedamaged + 5000 > currenttime);
    oob = isDefined(_id_C6577C1382E4B40D) && _id_C6577C1382E4B40D scripts\mp\outofbounds::istouchingoobtrigger();
    _id_5AA9CFB2EA0FF115 = 0;
    _id_BD1F266BC80DA88D = 0;

    if(isDefined(_id_C6577C1382E4B40D.team) && _id_C6577C1382E4B40D.vehiclename != "apc_russian" && _id_C6577C1382E4B40D.vehiclename != "veh9_apc_8x8") {
      _id_35C341A22B58D17D = scripts\common\utility::playersnear(_id_C6577C1382E4B40D.origin, 384);

      foreach(player in _id_35C341A22B58D17D) {
        if(isDefined(player) && player.team != _id_C6577C1382E4B40D.team && isalive(player) && !isDefined(player.fauxdead)) {
          if(abs(_id_C6577C1382E4B40D.origin[2] - player.origin[2]) < 100) {
            _id_BD1F266BC80DA88D = 1;
            break;
          }
        }
      }
    }

    if(_id_C6577C1382E4B40D.vehiclename == "apc_russian" || _id_C6577C1382E4B40D.vehiclename == "veh9_apc_8x8" || _id_C6577C1382E4B40D.vehiclename == "veh9_palfa") {
      _id_6990F1D64BBBBBF3 = _id_C6577C1382E4B40D.health / _id_C6577C1382E4B40D.maxhealth;

      if(_id_6990F1D64BBBBBF3 > _id_55D25B77E9FB1759)
        _id_E2ADEC8D28854D3F = 0;

      _id_83D6B23061E5BF09 = 0;
    } else if(_id_C6577C1382E4B40D.vehiclename == "veh9_patrol_boat")
      _id_5AA9CFB2EA0FF115 = _id_C6577C1382E4B40D vehicle_isonground();

    _id_2492DAEF403F6853 = _id_C6577C1382E4B40D.indanger;
    _id_C6577C1382E4B40D.indanger = _id_E2ADEC8D28854D3F || oob || _id_BD1F266BC80DA88D || burningdown || _id_83D6B23061E5BF09 || !_id_F7772E25266681DE || _id_5AA9CFB2EA0FF115;
    waitframe();
  }
}

hassquadmatepassengers(vehicle, player) {
  if(!isDefined(level.squaddata))
    return 0;

  _id_607DA387F3617ED1 = level.squaddata[self.team][self._id_0FF97225579DE16A].players;

  foreach(_id_F85572CD5F6117C6 in vehicle.occupants) {
    foreach(_id_C98AAC0E8E6EAF8C in _id_607DA387F3617ED1) {
      if(_id_C98AAC0E8E6EAF8C == _id_F85572CD5F6117C6)
        return 1;
    }
  }

  return 0;
}

setspawnselectionorder() {
  _id_8831727CF86C30A0 = scripts\engine\utility::getStructArray("axisLeft_alliesRight", "targetname");

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    _id_EF171A7416DC2AB0 = undefined;

    foreach(marker in _id_8831727CF86C30A0) {
      if(marker.script_noteworthy == level.localeid)
        _id_EF171A7416DC2AB0 = marker;
    }
  } else
    _id_EF171A7416DC2AB0 = scripts\engine\utility::getStruct("axisLeft_alliesRight", "targetname");

  _id_C099305BCDB72AD7 = [];

  foreach(location in level.spawnselectionlocations) {
    foreach(index, team in location) {
      if(index != self.team)
        continue;
      else
        _id_C099305BCDB72AD7[_id_C099305BCDB72AD7.size] = team;
    }
  }

  if(self.team == "axis")
    _id_3067799883AAEEB7 = _id_EF171A7416DC2AB0 scripts\engine\utility::array_sort_with_func(_id_C099305BCDB72AD7, ::sortlocationsbydistance_closestfirst);
  else
    _id_3067799883AAEEB7 = _id_EF171A7416DC2AB0 scripts\engine\utility::array_sort_with_func(_id_C099305BCDB72AD7, ::sortlocationsbydistance_farthestfirst);

  foreach(index, objective in _id_3067799883AAEEB7) {
    self setclientomnvar("ui_tom_spawn_entity_" + index, objective.anchorentity);
    self setclientomnvar("ui_tom_spawn_id_" + index, objective.labelid);
  }
}

sortlocationsbydistance_closestfirst(_id_0FCF7E6E6D8C4861, _id_0FCF7B6E6D8C41C8) {
  return distancesquared(_id_0FCF7E6E6D8C4861.origin, self.origin) < distancesquared(_id_0FCF7B6E6D8C41C8.origin, self.origin);
}

sortlocationsbydistance_farthestfirst(_id_0FCF7E6E6D8C4861, _id_0FCF7B6E6D8C41C8) {
  return distancesquared(_id_0FCF7E6E6D8C4861.origin, self.origin) > distancesquared(_id_0FCF7B6E6D8C41C8.origin, self.origin);
}

picklane(lane) {
  _id_B67BEB76F4CEC0F7 = undefined;

  foreach(loc in level.availablespawnlocations[self.team]) {
    if(issubstr(loc, lane)) {
      _id_B67BEB76F4CEC0F7 = loc;
      break;
    }
  }

  if(!isDefined(_id_B67BEB76F4CEC0F7)) {
    return;
  }
  if(!isDefined(level.spawnselectionlocations[_id_B67BEB76F4CEC0F7])) {
    return;
  }
  selected = level.spawnselectionlocations[_id_B67BEB76F4CEC0F7][self.team];

  if(!isDefined(selected)) {
    return;
  }
  _id_4E2F30F5B1DFA9F3 = self.team == "allies";
  _id_69DE983472A45AF9 = 0;

  switch (lane) {
    case "lane03_":
    case "spawn_selection_a":
    case "left":
      _id_69DE983472A45AF9 = scripts\engine\utility::ter_op(_id_4E2F30F5B1DFA9F3, 0, 2);
      break;
    case "lane02_":
    case "spawn_selection_b":
    case "mid":
      _id_69DE983472A45AF9 = 1;
      break;
    case "lane01_":
    case "spawn_selection_c":
    case "right":
      _id_69DE983472A45AF9 = scripts\engine\utility::ter_op(_id_4E2F30F5B1DFA9F3, 2, 0);
      break;
  }

  self setclientomnvar("ui_tom_spawn_entity_" + _id_69DE983472A45AF9, selected.anchorentity);
  self setclientomnvar("ui_tom_spawn_id_" + _id_69DE983472A45AF9, selected.labelid);
}

refreshsquadspawns() {
  _id_D861F893072A477E = 3;

  foreach(loc in level.availablespawnlocations[self.team]) {
    if(issubstr(loc, "squad_")) {
      selected = level.spawnselectionlocations[loc][self.team];
      self setclientomnvar("ui_tom_spawn_entity_" + _id_D861F893072A477E, selected.anchorentity);
      self setclientomnvar("ui_tom_spawn_id_" + _id_D861F893072A477E, selected.labelid);
      _id_D861F893072A477E++;
    }
  }
}

refreshdynamicspawns() {
  _id_D861F893072A477E = 6;

  foreach(loc in level.availablespawnlocations[self.team]) {
    if(issubstr(loc, "dynamic_")) {
      if(!isDefined(level.spawnselectionlocations[loc][self.team])) {
        continue;
      }
      selected = level.spawnselectionlocations[loc][self.team];

      if(!isDefined(selected)) {
        continue;
      }
      self setclientomnvar("ui_tom_spawn_entity_" + _id_D861F893072A477E, selected.anchorentity);
      self setclientomnvar("ui_tom_spawn_id_" + _id_D861F893072A477E, selected.labelid);
      _id_D861F893072A477E++;
    }
  }
}

waitforspawnselection(timeuntilspawn, _id_54A4645082A09829) {
  if(istrue(level.gameended) || istrue(level.nukeinfo._id_AD590A75663898F3)) {
    pickrandomnonvehiclespawn();
    return;
  }

  self endon("disconnect");
  self.selectedspawnarea = undefined;
  refreshplayerspawnareaomnvars();
  getclosestavailablespawnlocation();

  if(istrue(level.forcetopickafob)) {
    timeuntilspawnmessaging(1, "waiting_to_spawn");
    pickrandomnonvehiclespawn();
    return;
  }

  if(isai(self) || istrue(_id_54A4645082A09829) || issubstr(self.name, "_hl_")) {
    timeuntilspawnmessaging(timeuntilspawn, "waiting_to_spawn");

    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      return;
    }
    pickrandomnonvehiclespawn();
    return;
  }

  while(!scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  self lerpfovscalefactor(0.0, 0.2);
  spawnselectionthink(timeuntilspawn);
  self lerpfovscalefactor(1.0, 0.2);
}

pickrandomnonvehiclespawn() {
  _id_E7479A24D5E8F522 = scripts\engine\utility::array_randomize(level.availablespawnlocations[self.team]);

  foreach(area in _id_E7479A24D5E8F522) {
    if(issubstr(area, "fob") || issubstr(area, "HQ")) {
      self.selectedspawnarea = area;
      return;
    }
  }
}

pickrandomvehiclespawn(_id_B6603908715584DA) {
  if(!isDefined(_id_B6603908715584DA))
    _id_B6603908715584DA = "vehicle";

  _id_E7479A24D5E8F522 = scripts\engine\utility::array_randomize(level.availablespawnlocations[self.team]);

  foreach(area in _id_E7479A24D5E8F522) {
    if(issubstr(area, "vehicle")) {
      self.selectedspawnarea = area;
      return;
    }
  }
}

pickrandomspawn() {
  _id_E7479A24D5E8F522 = scripts\engine\utility::array_randomize(level.availablespawnlocations[self.team]);
  self.selectedspawnarea = _id_E7479A24D5E8F522[0];
  return;
}

_id_37B8D5F51288BA7D() {
  timeoutms = getdvarint("dvar_00B7CDDBC61E64ED", 2000);

  if(!istrue(self._id_A7461778C6502729) && scripts\mp\flags::gameflag("prematch_done")) {
    timeoutms = getdvarint("dvar_A06DC2C4DE808757", 9000);
    self._id_A7461778C6502729 = 1;
  }

  _id_0DC51DE4E8CBD07B = scripts\mp\spawncamera::getspawncamera();
  _id_11F3B4465C8B637B = _id_2CEDCC356F1B9FC8::playerstreamhintlocation(_id_0DC51DE4E8CBD07B.origin, timeoutms);
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0);
  _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.5);
}

spawnselectionthink(timeuntilspawn) {
  level endon("game_ended");
  self endon("disconnect");
  thread checkformatchend();

  if(istrue(level.gameended)) {
    return;
  }
  if(scripts\mp\utility\game::isteamreviveenabled()) {
    return;
  }
  if(istrue(level.nukeinfo._id_AD590A75663898F3)) {
    return;
  }
  if(!self[[level._id_D280C5FDB0036183]]()) {
    return;
  }
  scripts\mp\class::loadout_clearperks();
  thread scripts\mp\spawncamera::startspawncamera(0, 0, 0);
  thread _id_37B8D5F51288BA7D();
  self.selectedspawnarea = undefined;
  self.inspawnselection = 1;
  self setclientomnvar("ui_hide_objectives", 1);
  thread selectiondelaymessaging(timeuntilspawn);

  if(istrue(level.spawnselectionshowfriendly) || istrue(level.spawnselectionshowenemy))
    thread scripts\mp\flashpoint::flashpoint_spawnselectionvfx();

  if(istrue(level.showteamtanks))
    thread vehicle_showteamtanks();

  wait 0.5;

  if(isDefined(level._id_111C5F085A86C2F0))
    self[[level._id_111C5F085A86C2F0]]();

  self setclientomnvar("ui_hide_objectives", 0);
  self setclientomnvar("ui_tac_ops_map_open", 1);
  self cameralinkTo(self.spawncameraent, "tag_origin", 1);
  scripts\mp\utility\player::printspawnmessage("spawnselection::spawnSelectionThink() CameralinkTo()");
  thread timeuntilspawnmessaging(timeuntilspawn, "waiting_to_spawn");
  thread selectionmade();

  if(istrue(level.checkspawnselectionafk))
    thread watchforafk();

  self._id_F9CD51A4708EC70F = 0;

  for(;;) {
    _id_302DCE65CAB2ACF3 = watchendconditions();
    _id_83CB6D50FA2DAF87 = 1;

    switch (_id_302DCE65CAB2ACF3) {
      case "tac_ops_map_selection_valid":
        _id_83CB6D50FA2DAF87 = 1;
        break;
      case "tac_ops_map_changed":
        _id_83CB6D50FA2DAF87 = 0;
        refreshplayerspawnareaomnvars();
        break;
      case "tac_ops_map_cleared":
        _id_83CB6D50FA2DAF87 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case "spawned_player":
        _id_83CB6D50FA2DAF87 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case "tac_ops_map_game_ended":
        _id_83CB6D50FA2DAF87 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case "tac_ops_spawn_focus_changed":
        _id_83CB6D50FA2DAF87 = 0;
        break;
      case "tac_ops_map_nuke":
        _id_83CB6D50FA2DAF87 = 0;
        self setclientomnvar("ui_hide_objectives", 1);
        self setclientomnvar("ui_tac_ops_map_open", 0);
        thread spawnselectionshutdown_nuke();
        break;
      case "tac_ops_map_no_valid_selections":
        _id_83CB6D50FA2DAF87 = 1;
        self._id_F9CD51A4708EC70F = 1;
        break;
      default:
        break;
    }

    if(_id_83CB6D50FA2DAF87) {
      self notify("stop_spawnselection_afk");
      self setclientomnvar("ui_tac_ops_map_open", 0);
      self.inspawnselection = 0;

      if(isDefined(level._id_ABA39CAF969CD3F7))
        self[[level._id_ABA39CAF969CD3F7]]();

      return;
    }
  }
}

checkformatchend() {
  self endon("stop_spawnselection_afk");
  self endon("disconnect");

  while(!istrue(level.gameended))
    waitframe();

  self setclientomnvar("ui_tac_ops_map_open", 0);
}

watchforafk() {
  self endon("disconnect");
  self endon("stop_spawnselection_afk");

  if(isDefined(level.spawnselectionafktime))
    wait(level.spawnselectionafktime);
  else
    wait 60.0;

  self notify("afk_disconnection_imminent");
  wait 1;
  kick(self getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
}

selectiondelaymessaging(timeuntilspawn) {
  self endon("disconnect");
  self.canprocessselection = 0;

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict" || scripts\mp\utility\game::getgametype() == "risk" || scripts\mp\utility\game::getgametype() == "gwbomb" || scripts\mp\utility\game::getgametype() == "bigctf")
    self setclientomnvar("ui_tom_respawnTimerActive", 1);

  if(timeuntilspawn > 0)
    wait(timeuntilspawn);

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict" || scripts\mp\utility\game::getgametype() == "risk" || scripts\mp\utility\game::getgametype() == "gwbomb" || scripts\mp\utility\game::getgametype() == "bigctf")
    self setclientomnvar("ui_tom_respawnTimerActive", 0);

  scripts\mp\utility\lower_message::setlowermessageomnvar("select_spawn");
  self.canprocessselection = 1;

  if(isDefined(self.selectedspawnarea))
    validateselectedspawnarea();
}

validateselectedspawnarea() {
  foreach(loc in level.availablespawnlocations[self.team]) {
    if(loc == self.selectedspawnarea) {
      self notify("tac_ops_map_selection_made");
      return;
    }
  }

  self.selectedspawnarea = undefined;
}

selectionmade() {
  self endon("disconnect");
  self endon("tac_ops_map_selection_valid");

  for(;;) {
    self waittill("luinotifyserver", message, _id_84D6164F2A6EB8DA);

    if(message == "tac_ops_spawn_area_selected") {
      _id_84D6164F2A6EB8DA = updateplayerspawninputtype(_id_84D6164F2A6EB8DA);
      scripts\mp\utility\player::printspawnmessage("spawnSelection::selectionMade() START");
      selectedspawnarea = undefined;

      foreach(loc in level.spawnselectionlocations) {
        if(isDefined(loc[self.team]) && isDefined(loc[self.team].anchorentity) && loc[self.team].anchorentity getentitynumber() == _id_84D6164F2A6EB8DA) {
          updatespecificfobindanger(loc[self.team].typeref, self, self.team);

          if(isDefined(loc[self.team].objectivekey) && isobjectiveindanger(loc[self.team].objectivekey, self.team)) {
            break;
          }

          if(isDefined(loc[self.team].typeref) && issubstr(loc[self.team].typeref, "vehicle") && istrue(loc[self.team].dynamicent.indanger)) {
            break;
          }

          selectedspawnarea = loc[self.team].typeref;
          break;
        }
      }

      if(!isDefined(selectedspawnarea)) {
        _id_3CAB94F850A2511F = getsquadspawnlocations(self.team, self._id_0FF97225579DE16A);

        foreach(loc in _id_3CAB94F850A2511F) {
          if(isDefined(loc.dynamicent) && loc.dynamicent getentitynumber() == _id_84D6164F2A6EB8DA) {
            if(loc.dynamicent.team != self.team || loc.dynamicent._id_0FF97225579DE16A != self._id_0FF97225579DE16A) {
              thread refreshplayerspawnareaomnvars();
              break;
            }

            if(issquadmateindanger(loc.dynamicent)) {
              break;
            }

            vehicle = loc.dynamicent.vehicle;

            if(isDefined(vehicle)) {
              if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(vehicle).size == 0 || !istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(vehicle))) {
                break;
              }
            }

            spawninfo = spawnStruct();
            spawninfo = scripts\mp\spawnscoring::capsulepass(spawninfo, loc.dynamicent);

            if(!isDefined(spawninfo.spawnposition)) {
              loc.dynamicent.nogroundfoundtime = gettime();
              break;
            }

            selectedspawnarea = loc.typeref;
            break;
          }
        }
      }

      if(!isDefined(selectedspawnarea)) {
        if(isDefined(self.setspawnpoint) && self.setspawnpoint getentitynumber() == _id_84D6164F2A6EB8DA)
          selectedspawnarea = "tac_insert";
        else
          continue;
      }

      _id_F199BBB576943488 = issubstr(selectedspawnarea, "squad");
      _id_A95007E8E6D9D166 = getdvarint("dvar_517D1754377878D8", 0) == 1;

      if(istrue(self.canprocessselection) || _id_F199BBB576943488 && _id_A95007E8E6D9D166) {
        scripts\mp\utility\player::printspawnmessage("spawnSelection::selectionMade() = " + selectedspawnarea);
        self.selectedspawnarea = selectedspawnarea;
        self notify("tac_ops_map_selection_made");
        return;
      }
    }
  }
}

updateplayerspawninputtype(_id_84D6164F2A6EB8DA) {
  if(!isDefined(self.gwinputtypesused))
    self.gwinputtypesused = [];

  _id_C1606C1030582CFA = 65536;
  _id_9078B4C4E3258DFB = 131072;
  _id_CAAF532A5FD0A997 = 262144;
  _id_E4F4A7AF0D80EA24 = 524288;
  self.gwinputtypesused["rightmouseup"] = istrue(self.gwinputtypesused["rightmouseup"]) || (_id_84D6164F2A6EB8DA &_id_C1606C1030582CFA) > 0;
  self.gwinputtypesused["leftmouseup"] = istrue(self.gwinputtypesused["leftmouseup"]) || (_id_84D6164F2A6EB8DA &_id_9078B4C4E3258DFB) > 0;
  self.gwinputtypesused["activate"] = istrue(self.gwinputtypesused["activate"]) || (_id_84D6164F2A6EB8DA &_id_CAAF532A5FD0A997) > 0;
  self.gwinputtypesused["gostand"] = istrue(self.gwinputtypesused["gostand"]) || (_id_84D6164F2A6EB8DA &_id_E4F4A7AF0D80EA24) > 0;
  return _id_84D6164F2A6EB8DA &~(_id_C1606C1030582CFA | _id_9078B4C4E3258DFB | _id_CAAF532A5FD0A997 | _id_E4F4A7AF0D80EA24);
}

watchendconditions() {
  self endon("disconnect");
  thread endconditionwatcher_gameended();
  thread endconditionwatcher_selectionmade();
  thread endconditionwatcher_mapcleared();
  thread endconditionwatcher_mapchanged();
  thread endconditionwatcher_nuke();
  thread _id_B0E57461A4AF2476();
  result = scripts\engine\utility::_id_EFE4706DF8361219("tac_ops_map_selection_valid", "tac_ops_map_changed", "tac_ops_map_cleared", "spawned_player", "tac_ops_map_game_ended", "tac_ops_map_nuke", "tac_ops_map_no_valid_selections");
  self notify("tac_ops_end_condition_met");
  return result;
}

endconditionwatcher_selectionmade() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_SelectionMade()");
  self endon("endConditionWatcher_SelectionMade()");

  for(;;) {
    self waittill("tac_ops_map_selection_made");
    self notify("tac_ops_map_selection_valid");
    break;
  }
}

endcondition_focuschanged(_id_84D6164F2A6EB8DA) {
  if(isDefined(self.selectedspawnarea)) {
    return;
  }
  self endon("disconnect");
  self notify("endConditionWatcher_FocusChanged()");
  self endon("endConditionWatcher_FocusChanged()");
  self notify("tac_ops_spawn_focus_changed");
  scripts\mp\utility\player::printspawnmessage("endCondition_FocusChanged() START");
  selectedspawnarea = undefined;

  foreach(loc in level.spawnselectionlocations) {
    if(isDefined(loc[self.team]) && isDefined(loc[self.team].anchorentity) && loc[self.team].anchorentity getentitynumber() == _id_84D6164F2A6EB8DA) {
      thread keepstreamposfresh(loc[self.team].anchorentity.origin);
      selectedspawnarea = loc[self.team].typeref;
      break;
    }
  }

  if(!isDefined(selectedspawnarea)) {
    _id_3CAB94F850A2511F = getsquadspawnlocations(self.team, self._id_0FF97225579DE16A);

    foreach(loc in _id_3CAB94F850A2511F) {
      if(isDefined(loc.dynamicent) && loc.dynamicent getentitynumber() == _id_84D6164F2A6EB8DA) {
        thread keepstreamposfresh(loc.dynamicent.origin);
        selectedspawnarea = loc.typeref;
        break;
      }
    }
  }

  if(!isDefined(selectedspawnarea)) {
    return;
  }
  scripts\mp\utility\player::printspawnmessage("endCondition_FocusChanged() = " + selectedspawnarea);
  self setclientomnvar("ui_tom_veh_health_percent", 0);

  if(issubstr(selectedspawnarea, "squad")) {
    if(!istrue(level._id_72C2648CE78BEA79))
      thread managesquadcameraposition(selectedspawnarea);

    id = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, selectedspawnarea);
    self setclientomnvar("ui_tom_previous_selection", id);
    return;
  }

  if(issubstr(selectedspawnarea, "vehicle")) {
    if(!istrue(level._id_8F6541607D5DDA6B))
      thread managevehiclecameraposition(selectedspawnarea);

    thread managevehiclehealthui(selectedspawnarea);
    id = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, selectedspawnarea);
    self setclientomnvar("ui_tom_previous_selection", id);
    return;
  }

  id = -1;

  if(isDefined(level.localeid))
    id = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, selectedspawnarea + "_" + level.localeid);

  if(id == -1)
    id = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, selectedspawnarea);

  self setclientomnvar("ui_tom_previous_selection", id);

  if(isDefined(level.spawncameras[selectedspawnarea]) && isDefined(level.spawncameras[selectedspawnarea][self.team])) {
    self.forcedspawncameraref = selectedspawnarea;

    while(!scripts\mp\flags::gameflag("prematch_done"))
      waitframe();

    thread scripts\mp\spawncamera::movetospawncamera(0);
  }
}

keepstreamposfresh(origin) {
  self endon("disconnect");
  self endon("tac_ops_map_selection_valid");
  self endon("spawned_player");
  self notify("keepStreamPosFresh");
  self endon("keepStreamPosFresh");

  for(;;) {
    self _meth_BC667001F9DD3808(origin, 1);
    wait 1.0;
  }
}

endconditionwatcher_gameended() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_GameEnded()");
  self endon("endConditionWatcher_GameEnded()");
  level waittill("game_ended");
  self notify("tac_ops_map_game_ended");
}

endconditionwatcher_mapcleared() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_MapCleared()");
  self endon("endConditionWatcher_MapCleared()");
  level waittill("tac_ops_map_cleared");
  self notify("tac_ops_map_cleared");
}

endconditionwatcher_mapchanged() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_MapChanged()");
  self endon("endConditionWatcher_MapChanged()");
  level waittill("tac_ops_map_changed");
  self notify("tac_ops_map_changed");
}

endconditionwatcher_nuke() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_Nuke()");
  self endon("endConditionWatcher_Nuke()");
  level waittill("nuke_detonated");
  self notify("tac_ops_map_nuke");
}

_id_B0E57461A4AF2476() {
  self endon("disconnect");
  self endon("tac_ops_map_selection_valid");

  while(self[[level._id_D280C5FDB0036183]]())
    waitframe();

  self notify("tac_ops_map_no_valid_selections");
}

spawnselectionshutdown_nuke() {
  if(!istrue(self.inspawnselection)) {
    return;
  }
  self visionsetnakedforplayer("nuke_global_aftermath", 0.05);
  wait 2.0;

  if(!istrue(self.inspawnselection)) {
    return;
  }
  self visionsetnakedforplayer("flir_0_black_to_white_heavy_damage", 0.05);
}

adddynamicspawnarea(team, ent, ref, offset) {
  if(isDefined(level.spawnselectionlocations[ref]) && isDefined(level.spawnselectionlocations[ref][team])) {
    _id_7BF80D7FF1D68A01 = level.spawnselectionlocations[ref][team];
    _id_7BF80D7FF1D68A01.origin = ent.origin + scripts\engine\utility::ter_op(isDefined(offset), offset, (0, 0, 0));
    _id_7BF80D7FF1D68A01.angles = ent.angles;
  } else {
    _id_7BF80D7FF1D68A01 = spawnStruct();
    _id_7BF80D7FF1D68A01.origin = ent.origin + scripts\engine\utility::ter_op(isDefined(offset), offset, (0, 0, 0));
    _id_7BF80D7FF1D68A01.angles = ent.angles;
    _id_7BF80D7FF1D68A01.dynamicent = ent;
    _id_7BF80D7FF1D68A01.script_noteworthy = ref;
    initspawnarea(team, _id_7BF80D7FF1D68A01, ref);
    updatespawnareas();
  }
}

removedynamicspawnarea(team, ref) {
  if(isDefined(level.spawnselectionlocations[ref]) && isDefined(level.spawnselectionlocations[ref][team])) {
    level.spawnselectionlocations[ref][team] = undefined;

    if(level.spawnselectionlocations[ref].size == 0)
      level.spawnselectionlocations[ref] = undefined;
  }

  updatespawnareas();
}

getsquadspawnlocations(team, squadindex) {
  locations = [];

  if(isDefined(level.squadspawnselectionlocations) && isDefined(level.squadspawnselectionlocations[team]) && isDefined(level.squadspawnselectionlocations[team][squadindex]))
    locations = level.squadspawnselectionlocations[team][squadindex];

  return locations;
}

updatesquadspawn(team, squad, ref, ent) {
  if(!isDefined(level.squadspawnselectionlocations))
    level.squadspawnselectionlocations = [];

  if(!isDefined(level.squadspawnselectionlocations[team]))
    level.squadspawnselectionlocations[team] = [];

  if(!isDefined(level.squadspawnselectionlocations[team][squad]))
    level.squadspawnselectionlocations[team][squad] = [];

  if(isDefined(level.squadspawnselectionlocations[team][squad][ref])) {
    if(!isDefined(ent)) {
      level.squadspawnselectionlocations[team][squad][ref] = undefined;
      return;
    }

    _id_7BF80D7FF1D68A01 = level.squadspawnselectionlocations[team][squad][ref];
    _id_7BF80D7FF1D68A01.typeref = ref;
    _id_7BF80D7FF1D68A01.origin = ent.origin;
    _id_7BF80D7FF1D68A01.angles = ent.angles;
    _id_7BF80D7FF1D68A01.dynamicent = ent;
  } else {
    if(!isDefined(ent)) {
      return;
    }
    _id_7BF80D7FF1D68A01 = spawnStruct();
    _id_7BF80D7FF1D68A01.typeref = ref;
    _id_7BF80D7FF1D68A01.origin = ent.origin;
    _id_7BF80D7FF1D68A01.angles = ent.angles;
    _id_7BF80D7FF1D68A01.dynamicent = ent;
    level.squadspawnselectionlocations[team][squad][ref] = _id_7BF80D7FF1D68A01;
  }
}

removespawnareaondeathdisconnect(team, ref) {
  self endon("tac_ops_end_condition_met");
  adddynamicspawnarea(team, self, ref);
  self waittill("death_or_disconnect");
  thread addspawnareaonspawn(team, ref);
}

addspawnareaonspawn(team, ref) {
  self endon("tac_ops_end_condition_met");
  removedynamicspawnarea(team, ref);
  self endon("disconnect");
  self waittill("spawned_player");
  thread removespawnareaondeathdisconnect(team, ref);
}

_id_360FEEC64890E6F1() {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tacInsert_destroyed");
  self._id_EAEA86358D19ED20 = 1;
  _id_F148FCD88267D96E = int(level.tispawndelay);
  self setclientomnvar("ui_tom_ti_respawnTimer", gettime() + _id_F148FCD88267D96E * 1000);

  for(;;) {
    _id_F148FCD88267D96E = clamp(_id_F148FCD88267D96E, 0, level.tispawndelay);

    if(_id_F148FCD88267D96E == 0) {
      self setclientomnvar("ui_tom_ti_respawnTimer", 0);
      self._id_EAEA86358D19ED20 = 0;
      return;
    } else
      _id_F148FCD88267D96E = _id_F148FCD88267D96E - level.framedurationseconds;

    waitframe();
  }
}

_id_7DE3F8F504024FDE() {
  if(!isDefined(self.setspawnpoint)) {
    return;
  }
  self endon("disconnect");
  self endon("end_respawn");
  self notify("evaluateTISpawn");
  self endon("evaluateTISpawn");
  _id_2F55781AF96F22F9 = level.availablespawnlocations[self.team].size;
  _id_221D2A4479C093B6 = _id_2F55781AF96F22F9 + 4;
  _id_B0B3EFD85F274C12 = spawnStruct();
  _id_B0B3EFD85F274C12.entity = self.setspawnpoint;
  _id_B0B3EFD85F274C12.id = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "tac_insert");

  if(!istrue(self._id_EAEA86358D19ED20))
    thread _id_360FEEC64890E6F1();

  for(;;) {
    if(!isDefined(self.setspawnpoint)) {
      self setclientomnvar("ui_tom_spawn_id_" + _id_221D2A4479C093B6, -1);
      self setclientomnvar("ui_tom_spawn_entity_" + _id_221D2A4479C093B6, undefined);
      refreshplayerspawnareaomnvars();
      return;
    }

    self setclientomnvar("ui_tom_spawn_id_" + _id_221D2A4479C093B6, _id_B0B3EFD85F274C12.id);
    self setclientomnvar("ui_tom_spawn_entity_" + _id_221D2A4479C093B6, _id_B0B3EFD85F274C12.entity);
    waitframe();
  }
}

evaluatesquadspawn() {
  if(!isDefined(level.squaddata)) {
    return;
  }
  self endon("disconnect");
  self endon("end_respawn");
  self notify("evaluateSquadSpawn");
  self endon("evaluateSquadSpawn");
  _id_2F55781AF96F22F9 = level.availablespawnlocations[self.team].size;
  typeid = [];
  typeid[0] = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_0");
  typeid[1] = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_1");
  typeid[2] = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_2");
  typeid[3] = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_3");
  _id_72E07B77470F32D9 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_leader");
  _id_5966E8A05A4D1903 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    data = spawnStruct();
    data.guid = undefined;
    data.entity = undefined;
    data.idmask = undefined;
    _id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8] = data;
  }

  _id_4DA35154D6D43593 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++)
    _id_4DA35154D6D43593[_id_AC0E594AC96AA3A8] = "squad_" + _id_AC0E594AC96AA3A8;

  for(;;) {
    _id_D6EE3E704C6731D4 = _id_58BE75C518BF0D40::getsquadleader(self.team, self._id_0FF97225579DE16A);
    players = level.squaddata[self.team][self._id_0FF97225579DE16A].players;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(_id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8].guid)) {
        continue;
      }
      if(!isDefined(players[_id_AC0E594AC96AA3A8]) || players[_id_AC0E594AC96AA3A8].guid != _id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8].guid) {
        thread refreshplayerspawnareaomnvars();
        return;
      }
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 < players.size)
        player = players[_id_AC0E594AC96AA3A8];
      else
        player = undefined;

      ref = _id_4DA35154D6D43593[_id_AC0E594AC96AA3A8];
      updatesquadspawn(self.team, self._id_0FF97225579DE16A, ref, player);
    }

    locations = getsquadspawnlocations(self.team, self._id_0FF97225579DE16A);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 < players.size)
        player = players[_id_AC0E594AC96AA3A8];
      else
        player = undefined;

      issquadleader = isDefined(player) && isDefined(_id_D6EE3E704C6731D4) && player == _id_D6EE3E704C6731D4;

      if(!issquadleader && istrue(level.spawnsquadleaderonly)) {
        continue;
      }
      ref = _id_4DA35154D6D43593[_id_AC0E594AC96AA3A8];
      selected = locations[ref];
      _id_D059A36C2835B580 = isDefined(player) && isDefined(player.vehicle) && istrue(player.vehicle.israllypointvehicle);

      if(isDefined(player) && self != player && issquadspawnable(player) && !istrue(_id_D059A36C2835B580)) {
        indanger = istrue(player.indanger);
        idmask = typeid[_id_AC0E594AC96AA3A8];

        if(indanger)
          idmask = idmask + 128;

        if(issquadleader)
          idmask = idmask + 256;

        if(isDefined(player.vehicle)) {
          idmask = idmask + 512;

          if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(player.vehicle).size == 0 || !istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(player.vehicle)))
            idmask = idmask + 1024;

          if(player.vehicle.vehiclename == "little_bird" || player.vehicle.vehiclename == "little_bird_mg")
            idmask = idmask + 4096;
        }

        idmask = idmask + (player._id_3F78C6A0862F9E25 << 13);

        if(!isDefined(_id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8].guid))
          _id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8].guid = player.guid;

        if(!isDefined(_id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8].entity) && isDefined(selected) && isDefined(selected.dynamicent)) {
          _id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8].entity = selected.dynamicent;
          self setclientomnvar("ui_tom_spawn_entity_" + (_id_2F55781AF96F22F9 + _id_AC0E594AC96AA3A8), selected.dynamicent);
        }

        if(!isDefined(_id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8].idmask) || _id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8].idmask != idmask) {
          _id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8].idmask = idmask;
          self setclientomnvar("ui_tom_spawn_id_" + (_id_2F55781AF96F22F9 + _id_AC0E594AC96AA3A8), idmask);
        }

        continue;
      }

      if(isDefined(_id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8].entity)) {
        _id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8].entity = undefined;
        self setclientomnvar("ui_tom_spawn_entity_" + (_id_2F55781AF96F22F9 + _id_AC0E594AC96AA3A8), undefined);
      }

      if(isDefined(_id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8].idmask) && _id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8].idmask != -1) {
        _id_5966E8A05A4D1903[_id_AC0E594AC96AA3A8].idmask = -1;
        self setclientomnvar("ui_tom_spawn_id_" + (_id_2F55781AF96F22F9 + _id_AC0E594AC96AA3A8), -1);
      }
    }

    waitframe();
  }
}

handlerespawnselection(spawnedasspectator, timeuntilspawn) {
  level endon("game_ended");
  self endon("disconnect");
  _id_114D19D4F6606873 = undefined;

  if(!isDefined(_id_114D19D4F6606873)) {
    if(istrue(level.usec130spawnfirstonly) && istrue(level.usec130spawn) && !istrue(self.spawnedusingc130) && isDefined(level.spawnc130[self.team]))
      _id_114D19D4F6606873 = 1;
    else if(istrue(level.usesquadspawn))
      _id_114D19D4F6606873 = 0;
    else if(istrue(level.usespawnselection))
      _id_114D19D4F6606873 = 2;
    else if(istrue(level.usec130spawn))
      _id_114D19D4F6606873 = 1;
    else
      _id_114D19D4F6606873 = 3;
  }

  _id_33C2A141EBC8F7AE = gettime();
  selectionmade = 0;

  while(!selectionmade) {
    currenttime = gettime();
    spawndelay = (_id_33C2A141EBC8F7AE + timeuntilspawn * 1000 - currenttime) / 1000;

    switch (_id_114D19D4F6606873) {
      case 0:
        self.squadspawnconfirmed = 0;
        self.squadspawnaborted = 0;

        if(!isai(self))
          thread handlesquadspawnabort();

        if(!spawnedasspectator)
          thread scripts\mp\playerlogic::respawn_asspectator(self.origin + (0, 0, 60), self.angles);

        spawnedasspectator = 1;
        _id_2F55781AF96F22F9 = scripts\engine\utility::ter_op(isDefined(self.spawnselectedsquadmate), self.spawnselectedsquadmate, 0);

        if(thread cyclevalidsquadspectate(_id_2F55781AF96F22F9, 1)) {
          if(!isai(self)) {
            result = handlesquadspawnconfirm(spawndelay);

            if(!istrue(result))
              self.squadspawnaborted = 1;
            else
              self.squadspawnconfirmed = 1;
          } else {
            timeuntilspawnmessaging(timeuntilspawn, "spawn_revive_wait");

            if(scripts\engine\utility::cointoss())
              self.squadspawnconfirmed = 1;
            else
              self.squadspawnaborted = 1;
          }
        } else
          self.squadspawnaborted = 1;

        if(self.squadspawnaborted) {
          self.forcespectatorclient = -1;

          if(istrue(level.usec130spawn))
            _id_114D19D4F6606873 = 1;
          else if(istrue(level.usespawnselection))
            _id_114D19D4F6606873 = 2;
          else
            _id_114D19D4F6606873 = 3;
        } else
          selectionmade = 1;

        break;
      case 1:
        thread scripts\mp\spawncamera::startspawncamera();
        _id_7F011A0A8ADBDF3D = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(_id_7F011A0A8ADBDF3D))
          _id_7F011A0A8ADBDF3D = 0;

        if(istrue(level.usec130spawnfirstonly))
          self.spawnedusingc130 = 1;

        spawntoc130();
        selectionmade = 1;
        break;
      case 2:
        _id_6109158034DA3FE9 = scripts\mp\flags::gameflag("infil_will_run") && !istrue(scripts\mp\flags::gameflag("infil_started"));

        if((scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict" || scripts\mp\utility\game::getgametype() == "risk" || scripts\mp\utility\game::getgametype() == "bigctf") && !_id_6109158034DA3FE9 && !scripts\mp\flags::gameflag("prematch_done")) {
          _id_C2106FA614419D22 = [[level._id_E637D49948A038D3]](self.team);
          _id_5940F376A254619D = spawn("script_model", _id_C2106FA614419D22.startorigin);
          _id_5940F376A254619D setModel("tag_origin");
          _id_5940F376A254619D.angles = _id_C2106FA614419D22.startangles;
          self cameralinkTo(_id_5940F376A254619D, "tag_origin");
          _id_5940F376A254619D moveTo(_id_C2106FA614419D22.endorigin, 18);
          _id_5940F376A254619D rotateTo(_id_C2106FA614419D22.endangles, 18);
          scripts\mp\flags::gameflagwait("prematch_done");
          self cameraunlink();
          self.spawncameratime = 0.5;
          thread scripts\mp\spawncamera::startspawncamera(0.0, 0.5, 0.5);
        } else {
          self.spawncameratime = 0.5;
          thread scripts\mp\spawncamera::startspawncamera(0.0, 0.5, 0.5);
        }

        _id_7F011A0A8ADBDF3D = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(_id_7F011A0A8ADBDF3D))
          _id_7F011A0A8ADBDF3D = 0;

        waitforspawnselection(spawndelay + _id_7F011A0A8ADBDF3D);

        if(isDefined(self.selectedspawnarea))
          selectionmade = 1;

        break;
      case 3:
        thread scripts\mp\spawncamera::startspawncamera();
        _id_7F011A0A8ADBDF3D = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(_id_7F011A0A8ADBDF3D))
          _id_7F011A0A8ADBDF3D = 0;

        timeuntilspawnmessaging(spawndelay + _id_7F011A0A8ADBDF3D, "waiting_to_spawn");
        selectionmade = 1;
        break;
    }
  }

  if(needsbuttontorespawn()) {
    if(!istrue(self.waitingtoselectclass))
      scripts\mp\utility\lower_message::setlowermessageomnvar("press_to_spawn");

    if(!spawnedasspectator)
      thread scripts\mp\playerlogic::respawn_asspectator(self.origin + (0, 0, 60), self.angles);

    spawnedasspectator = 1;
    waitrespawnbutton();
  }

  thread scripts\mp\spawncamera::endspawncamera();
}

handlesquadspawnabort() {
  self endon("disconnect");
  self notify("handleSquadSpawnAbort");
  self endon("handleSquadSpawnAbort");
  self notifyonplayercommand("switchSpawnMethod", "+stance");
  self waittill("switchSpawnMethod");
  self.forcespectatorclient = -1;
  self.squadspawnaborted = 1;
  self notify("squad_spawn_abort");
}

handlesquadspawncycle() {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  self notify("handleSquadSpawnCycle");
  self endon("handleSquadSpawnCycle");
  self notifyonplayercommand("cyclePos", "+gostand");

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_2("cyclePos", "cycleNeg");

    if(isDefined(result)) {
      current = self getspectatingplayer();

      if(result == "cyclePos")
        thread cyclevalidsquadspectate(current._id_3F78C6A0862F9E25, 1);
      else if(result == "cycleNeg")
        thread cyclevalidsquadspectate(current._id_3F78C6A0862F9E25, 0);
    }
  }
}

handlesquadspawnconfirm(timeuntilspawn) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  timeuntilspawnmessaging(timeuntilspawn, "waiting_to_spawn");
  scripts\mp\utility\lower_message::setlowermessageomnvar("squad_spawn");
  self notifyonplayercommand("respawn_confirm", "+usereload");
  self waittill("respawn_confirm");
  return 1;
}

cyclevalidsquadspectate(_id_2F55781AF96F22F9, _id_9FC5FBEAE7221FB6) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  self notify("cycleValidSquadSpectate");
  self endon("cycleValidSquadSpectate");
  players = level.squaddata[self.team][self._id_0FF97225579DE16A].players;
  _id_39D4BB9B710FFD49 = _id_2F55781AF96F22F9;
  _id_D0DE0DB1760B9C5B = scripts\engine\utility::ter_op(_id_9FC5FBEAE7221FB6, 1, -1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    if(iscurrentspectatetarget(players[_id_39D4BB9B710FFD49]) || !issquadspawnable(players[_id_39D4BB9B710FFD49])) {
      _id_39D4BB9B710FFD49 = _id_39D4BB9B710FFD49 + _id_D0DE0DB1760B9C5B;

      if(_id_39D4BB9B710FFD49 == players.size)
        _id_39D4BB9B710FFD49 = 0;

      if(_id_39D4BB9B710FFD49 == -1)
        _id_39D4BB9B710FFD49 = players.size - 1;

      continue;
    }

    thread monitorsquadspectator(players[_id_39D4BB9B710FFD49]);
    return 1;
  }

  return 0;
}

iscurrentspectatetarget(player) {
  if(!isDefined(self.forcespectatorclient))
    return 0;

  _id_279BB6642EC5E695 = self getspectatingplayer();

  if(!isDefined(_id_279BB6642EC5E695))
    return 0;

  return player == _id_279BB6642EC5E695;
}

issquadspawnable(player) {
  if(!isDefined(player))
    return 0;

  if(!scripts\mp\utility\player::isreallyalive(player))
    return 0;

  if(istrue(player.inspawncamera))
    return 0;

  if(player isskydiving())
    return 0;

  if(player scripts\mp\utility\player::isusingremote())
    return 0;

  return 1;
}

isplayerindanger_think() {
  thread internal_isplayerindanger_think();

  if(getdvarint("dvar_99A922188EC4750F", 0) == 1)
    thread scripts\mp\spawnscoring::squadspawndebug();
}

internal_isplayerindanger_think() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    if(issquadspawnable(self))
      self.indanger = issquadmateindanger(self);

    waitframe();
  }
}

issquadmateindanger(player) {
  currenttime = gettime();

  if(isDefined(player) && (isDefined(player.pers["lastDamageTime"]) && player.pers["lastDamageTime"] + 5000 > currenttime) || isDefined(player.lasttimedamaged) && player.lasttimedamaged + 5000 > currenttime)
    return 1;

  if(player isonladder())
    return 1;

  player scripts\mp\battlechatter_mp::validaterecentattackers();

  if(isDefined(player.recentattackers) && player.recentattackers.size > 0)
    return 1;

  if(isDefined(player.lastweaponfiretimestart) && player.lastweaponfiretimestart + 3000 > currenttime)
    return 1;

  if(isDefined(player.lastweaponfiretimestart) && isDefined(player.lastweaponfiretimeend) && player.lastweaponfiretimestart > player.lastweaponfiretimeend || isDefined(player.lastweaponfiretimestart) && !isDefined(player.lastweaponfiretimeend))
    return 1;

  _id_F2E473B17CA70265 = player getclosestenemy(384, 100, 1);

  if(isDefined(_id_F2E473B17CA70265))
    return 1;

  if(isDefined(player.vehicle)) {
    if(istrue(player.vehicle.burningdown))
      return 1;

    if(istrue(scripts\cp_mp\utility\weapon_utility::islockedonto(player.vehicle)))
      return 1;
  }

  if(isDefined(player) && player scripts\mp\outofbounds::istouchingoobtrigger())
    return 1;

  if(getdvarint("dvar_3728C11E46EC4B26", 0) == 1) {
    bucket = player getspawnbucketforplayer(1, player.origin);
    bucket = scripts\mp\spawnlogic::getspawnbucketfromstring(bucket);

    if(bucket >= 2)
      return 1;
  }

  if(isDefined(player) && isDefined(player.nogroundfoundtime) && player.nogroundfoundtime + 1000 > currenttime)
    return 1;

  return 0;
}

monitorsquadspectator(target) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  self notify("monitorSquadSpectator");
  self endon("monitorSquadSpectator");
  index = target._id_3F78C6A0862F9E25;
  self.forcespectatorclient = target getentitynumber();
  self forcethirdpersonwhenspectating();
  thread handlesquadspawncycle();

  while(issquadspawnable(target)) {
    if(issquadmateindanger(target))
      self setclientomnvar("ui_squad_spawn_combat", 1);
    else
      self setclientomnvar("ui_squad_spawn_combat", 0);

    self.squadspectatepos = target.origin + anglesToForward(target.angles) * -80 + (0, 0, 64);
    self.squadspectateang = target.angles;
    waitframe();
  }

  if(!thread cyclevalidsquadspectate(index, 1)) {
    self.squadspawnaborted = 0;
    self notify("squad_spawn_abort");
  }
}

spawntoc130() {
  self endon("disconnect");

  while(istrue(level.usec130spawn) && !isDefined(level.spawnc130))
    waitframe();

  if(!istrue(level.usec130spawn) || !isDefined(level.spawnc130[self.team])) {
    wait 1.5;
    return;
  }

  if(!istrue(level.usec130spawnfirstonly) && isDefined(level.timeuntilnextc130) && level.timeuntilnextc130[self.team] - gettime() <= (level.flighttime + level.timebetweenc130passes) * 1000)
    scripts\mp\utility\lower_message::setlowermessageomnvar("waiting_for_c130", int(level.timeuntilnextc130[self.team]));
  else
    scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");

  thread _id_27C2DB69A21775A0::spawnplayertoc130();

  if(isDefined(level.spawnc130[self.team]))
    self waittill("c130_ready");
}

needsbuttontorespawn() {
  if(scripts\mp\tweakables::gettweakablevalue("player", "forcerespawn") != 0)
    return 0;

  if(!self.hasspawned)
    return 0;

  _id_3E1DEAE4CD178CFB = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_waverespawndelay")) > 0;

  if(_id_3E1DEAE4CD178CFB)
    return 0;

  if(self.wantsafespawn)
    return 0;

  return 1;
}

waitrespawnbutton() {
  self endon("disconnect");
  self endon("end_respawn");

  for(;;) {
    if(self useButtonPressed()) {
      break;
    }

    wait 0.05;
  }
}

timeuntilspawnmessaging(timeuntilspawn, _id_401C3A2E68AAB0FD) {
  self endon("disconnect");

  if(timeuntilspawn > 0) {
    if(!isDefined(_id_401C3A2E68AAB0FD))
      _id_401C3A2E68AAB0FD = "waiting_to_spawn";

    scripts\mp\utility\lower_message::setlowermessageomnvar(_id_401C3A2E68AAB0FD, int(gettime() + timeuntilspawn * 1000));
    scripts\engine\utility::waittill_any_timeout_no_endon_death_1(timeuntilspawn, "force_spawn");
  }
}

managesquadcameraposition(ref) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageSquadCameraPosition");
  self endon("manageSquadCameraPosition");
  index = undefined;

  if(ref == "squad_leader")
    index = level.squaddata[self.team][self._id_0FF97225579DE16A]._id_D6EE3E704C6731D4._id_3F78C6A0862F9E25;
  else
    index = int(getsubstr(ref, ref.size - 1, ref.size));

  _id_356A015AA1975023 = undefined;

  if(isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self._id_0FF97225579DE16A]) && isDefined(level.squaddata[self.team][self._id_0FF97225579DE16A].players[index]))
    _id_356A015AA1975023 = level.squaddata[self.team][self._id_0FF97225579DE16A].players[index];

  forward = level.spawnselectionteamforward[self.team];

  while(isDefined(self.spawncameraent) && isDefined(_id_356A015AA1975023)) {
    _id_2F38DABD01860335 = [];
    _id_8003B0D4F9FBEE0E = [];

    if(istrue(level.usestaticspawnselectioncamera)) {
      temp = getstaticcameraposition(self.team);
      _id_2F38DABD01860335 = temp.origin;
      _id_8003B0D4F9FBEE0E = temp.angles;
    } else {
      heightoffset = 7000;

      if(istrue(level.useunifiedspawnselectioncameraheight))
        heightoffset = _id_87BBBEE0BBF27304();

      _id_2F38DABD01860335 = _id_356A015AA1975023.origin + forward * -8500 + (0, 0, heightoffset);
      _id_67794FF6E49C4961 = vectorNormalize(_id_356A015AA1975023.origin - _id_2F38DABD01860335);
      _id_8003B0D4F9FBEE0E = scripts\mp\utility\script::vectortoanglessafe(_id_67794FF6E49C4961, (0, 0, 1));
      _id_2F38DABD01860335 = _id_2F38DABD01860335 + [[level._id_3C89983E2030DFFF]](self.team, _id_356A015AA1975023.origin);
    }

    self.spawncameratargetpos = _id_2F38DABD01860335;
    self.spawncameratargetang = _id_8003B0D4F9FBEE0E;
    self.spawncameraent moveTo(_id_2F38DABD01860335, 0.25, 0.05, 0.2);
    self.spawncameraent rotateTo(_id_8003B0D4F9FBEE0E, 0.25, 0.05, 0.2);
    waitframe();
  }
}

managevehiclecameraposition(ref) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageVehicleCameraPosition");
  self endon("manageVehicleCameraPosition");
  index = int(getsubstr(ref, ref.size - 1, ref.size));
  _id_A5D118F040F60DB0 = level.spawnselectionlocations[ref][self.team].dynamicent;
  forward = level.spawnselectionteamforward[self.team];
  _id_FF816C44D164CAC1 = 0;

  while(isDefined(self.spawncameraent) && isDefined(_id_A5D118F040F60DB0) && !istrue(_id_A5D118F040F60DB0.isdestroyed)) {
    _id_2F38DABD01860335 = [];
    _id_8003B0D4F9FBEE0E = [];

    if(istrue(level.usestaticspawnselectioncamera)) {
      temp = getstaticcameraposition(self.team);
      _id_2F38DABD01860335 = temp.origin;
      _id_8003B0D4F9FBEE0E = temp.angles;
    } else {
      heightoffset = 7000;

      if(istrue(level.useunifiedspawnselectioncameraheight))
        heightoffset = _id_87BBBEE0BBF27304();

      _id_2F38DABD01860335 = _id_A5D118F040F60DB0.origin + forward * -8500 + (0, 0, heightoffset);
      groundpos = level.spawnselectionlocations[ref][self.team].anchorentity.origin;
      camerapos = groundpos + forward * -8500 + (0, 0, heightoffset);
      _id_6D399A908D913B0B = vectorNormalize(groundpos - camerapos);
      _id_8003B0D4F9FBEE0E = scripts\mp\utility\script::vectortoanglessafe(_id_6D399A908D913B0B, (0, 0, 1));
      _id_2F38DABD01860335 = _id_2F38DABD01860335 + [[level._id_3C89983E2030DFFF]](self.team, groundpos);
    }

    self.spawncameratargetpos = _id_2F38DABD01860335;
    self.spawncameratargetang = _id_8003B0D4F9FBEE0E;

    if(!isDefined(self.spawncameraendtime) || gettime() > self.spawncameraendtime) {
      self.spawncameraent moveTo(_id_2F38DABD01860335, 0.25, 0.05, 0.2);
      self.spawncameraent rotateTo(_id_8003B0D4F9FBEE0E, 0.25, 0.05, 0.2);
    } else if(!_id_FF816C44D164CAC1) {
      _id_FF816C44D164CAC1 = 1;
      self.spawncameraent moveTo(_id_2F38DABD01860335, self.spawncameratime, self.spawncameratime * 0.3, self.spawncameratime * 0.4);
      self.spawncameraent rotateTo(_id_8003B0D4F9FBEE0E, self.spawncameratime, self.spawncameratime * 0.3, self.spawncameratime * 0.4);
    }

    waitframe();
  }
}

managevehiclehealthui(ref) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageVehicleHealthUI");
  self endon("manageVehicleHealthUI");
  _id_A5D118F040F60DB0 = level.spawnselectionlocations[ref][self.team].dynamicent;
  self setclientomnvar("ui_tom_veh_health_percent", 0);
  waitframe();
  _id_3ED7C323526C2B33 = undefined;

  while(isDefined(_id_A5D118F040F60DB0)) {
    _id_559A0810819CF4F0 = int(clamp(_id_A5D118F040F60DB0.health / _id_A5D118F040F60DB0.maxhealth * 100, 0, 100));

    if(_id_559A0810819CF4F0 < 0) {}

    if(!isDefined(_id_3ED7C323526C2B33) || _id_3ED7C323526C2B33 != _id_559A0810819CF4F0) {
      self setclientomnvar("ui_tom_veh_health_percent", int(_id_559A0810819CF4F0));
      _id_3ED7C323526C2B33 = _id_559A0810819CF4F0;
    }

    waitframe();
  }
}

getclosestavailablespawnlocation() {
  _id_84D4866087B00608 = undefined;
  _id_F7F7EA6E8E4C442D = undefined;

  if(!scripts\mp\flags::gameflag("prematch_done") && (scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict" || scripts\mp\utility\game::getgametype() == "bigctf") || scripts\mp\utility\game::getgametype() == "risk" || !isDefined(self.hasvisitedgwspawnselection)) {
    if(self.team == "axis" || self.team == "team_three" || self.team == "team_four")
      _id_F7F7EA6E8E4C442D = "gw_fob_axisHQ";
    else
      _id_F7F7EA6E8E4C442D = "gw_fob_alliesHQ";

    self.hasvisitedgwspawnselection = 1;
  } else {
    _id_BE1261E9563D861B = 0;

    foreach(ref in level.availablespawnlocations[self.team]) {
      distsq = distancesquared(self.origin, level.spawnselectionlocations[ref][self.team].anchorentity.origin);

      if(!isDefined(distsq)) {
        continue;
      }
      if(ref == "gw_fob_" + self.team + "HQ") {
        if(distsq < 4194304) {
          _id_84D4866087B00608 = distsq;
          _id_F7F7EA6E8E4C442D = ref;
          break;
        }
      }

      if(!isDefined(_id_84D4866087B00608) || distsq < _id_84D4866087B00608) {
        _id_84D4866087B00608 = distsq;
        _id_F7F7EA6E8E4C442D = ref;
      }
    }

    if(isDefined(level.squadspawnselectionlocations) && isDefined(level.squadspawnselectionlocations[self.team][self._id_0FF97225579DE16A])) {
      locations = getsquadspawnlocations(self.team, self._id_0FF97225579DE16A);

      foreach(loc in locations) {
        if(loc.dynamicent == self) {
          continue;
        }
        distsq = distancesquared(self.origin, loc.dynamicent.origin);

        if(distsq < _id_84D4866087B00608) {
          _id_84D4866087B00608 = distsq;
          _id_F7F7EA6E8E4C442D = loc.typeref;
        }
      }
    }
  }

  if(issubstr(_id_F7F7EA6E8E4C442D, "vehicle")) {}

  id = -1;

  if(isDefined(_id_F7F7EA6E8E4C442D)) {
    if(!issubstr(_id_F7F7EA6E8E4C442D, "squad") && !issubstr(_id_F7F7EA6E8E4C442D, "vehicle") && !issubstr(_id_F7F7EA6E8E4C442D, "HQ")) {
      _id_ECB1ED5831DEB517 = _id_F7F7EA6E8E4C442D + "_" + level.localeid;
      id = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, _id_ECB1ED5831DEB517);
    }

    if(id == -1)
      id = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, _id_F7F7EA6E8E4C442D);

    self setclientomnvar("ui_tom_previous_selection", id);
    self.forcedspawncameraref = _id_F7F7EA6E8E4C442D;
  } else {
    self setclientomnvar("ui_tom_previous_selection", -1);
    self.forcedspawncameraref = undefined;
  }
}

getstaticcameraposition(team) {
  _id_FBC978E58D9EFD71 = spawnStruct();

  if(isDefined(level._id_45ABEC6DE5366021) && isDefined(level._id_7B73A66E2D4CA32F)) {
    _id_FBC978E58D9EFD71.origin = level._id_45ABEC6DE5366021;
    _id_FBC978E58D9EFD71.angles = level._id_7B73A66E2D4CA32F;
    return _id_FBC978E58D9EFD71;
  }

  if(level.mapname == "mp_locale_test") {
    switch (level.localeid) {
      case "locale_6":
        if(team == "axis") {
          _id_FBC978E58D9EFD71.origin = (2094, -1804, 2763);
          _id_FBC978E58D9EFD71.angles = (54, 40, 0);
        } else {
          _id_FBC978E58D9EFD71.origin = (2315, 1956, 2763);
          _id_FBC978E58D9EFD71.angles = (54, 296, 0);
        }

        break;
      case "locale_7":
        if(team == "axis") {
          _id_FBC978E58D9EFD71.origin = (5556, -1368, 2464);
          _id_FBC978E58D9EFD71.angles = (56, 42, 0);
        } else {
          _id_FBC978E58D9EFD71.origin = (5636, 1630, 2446);
          _id_FBC978E58D9EFD71.angles = (56, 307, 0);
        }

        break;
      default:
        if(team == "axis") {
          _id_FBC978E58D9EFD71.origin = (0, 0, 0);
          _id_FBC978E58D9EFD71.angles = (0, 0, 0);
        } else {
          _id_FBC978E58D9EFD71.origin = (0, 0, 0);
          _id_FBC978E58D9EFD71.angles = (0, 0, 0);
        }

        break;
    }
  } else {
    switch (level.localeid) {
      case "locale_5":
        if(team == "axis") {
          _id_FBC978E58D9EFD71.origin = (30965, 28984, 12785);
          _id_FBC978E58D9EFD71.angles = (53, 82, 0);
        } else {
          _id_FBC978E58D9EFD71.origin = (35294, 53430, 12785);
          _id_FBC978E58D9EFD71.angles = (50, 260, 0);
        }

        break;
      case "locale_6":
        if(team == "axis") {
          _id_FBC978E58D9EFD71.origin = (35294, 53430, 12785);
          _id_FBC978E58D9EFD71.angles = (50, 260, 0);
        } else {
          _id_FBC978E58D9EFD71.origin = (30965, 28984, 12785);
          _id_FBC978E58D9EFD71.angles = (53, 82, 0);
        }

        break;
      case "locale_7":
        if(team == "axis") {
          _id_FBC978E58D9EFD71.origin = (0, 0, 0);
          _id_FBC978E58D9EFD71.angles = (0, 0, 0);
        } else {
          _id_FBC978E58D9EFD71.origin = (0, 0, 0);
          _id_FBC978E58D9EFD71.angles = (0, 0, 0);
        }

        break;
      case "locale_34":
      case "locale_33":
      case "locale_28":
        _id_FBC978E58D9EFD71.origin = (6000, -46000, 19500);
        _id_FBC978E58D9EFD71.angles = (73, 130, 0);
        break;
      case "locale_51":
      case "locale_50":
        _id_FBC978E58D9EFD71.origin = (-33000, -23775, 12650);
        _id_FBC978E58D9EFD71.angles = (82, 111, 0);
        break;
      default:
        if(team == "axis") {
          _id_FBC978E58D9EFD71.origin = (0, 0, 0);
          _id_FBC978E58D9EFD71.angles = (0, 0, 0);
        } else {
          _id_FBC978E58D9EFD71.origin = (0, 0, 0);
          _id_FBC978E58D9EFD71.angles = (0, 0, 0);
        }

        break;
    }
  }

  return _id_FBC978E58D9EFD71;
}

_id_87BBBEE0BBF27304() {
  if(getdvarint("dvar_9D53A38D10C6BBC5", 0) > 0)
    return getdvarint("dvar_9D53A38D10C6BBC5", 0);

  if(!isDefined(level.localeid))
    return 7000;

  if(level.mapname == "mp_locale_test") {
    switch (level.localeid) {
      case "locale_6":
        return 7000;
      case "locale_7":
        return 7000;
      case "locale_8":
        return 7000;
      case "locale_9":
        return 7000;
      case "locale_24":
        return 12000;
      default:
        return 7000;
    }
  } else {
    switch (level.localeid) {
      case "locale_5":
        return 7000;
      case "locale_6":
        return 8000;
      case "locale_7":
        return 8000;
      case "locale_8":
        return 8000;
      case "locale_9":
        return 8000;
      case "locale_16":
        return 7000;
      case "locale_17":
        return 5000;
      case "locale_24":
        return 12000;
      default:
        return 7000;
    }
  }
}

updatefobindanger() {
  if(!istrue(level.usespawnselection)) {
    return;
  }
  level thread updatefobspawnsindanger();

  for(;;) {
    foreach(team in level.teamnamelist) {
      foreach(_id_F90358454413407F in level.availablespawnlocations[team]) {
        selected = level.spawnselectionlocations[_id_F90358454413407F][team];

        if(isDefined(selected) && isDefined(selected.objectivekey))
          selected.indanger = isobjectiveindanger(selected.objectivekey, team);
      }
    }

    waitframe();
  }
}

updatefobspawnsindanger() {
  for(;;) {
    foreach(team in level.teamnamelist) {
      _id_F7632B4589B2BED4 = scripts\mp\utility\teams::getteamdata(team, "players")[0];

      foreach(location in level.availablespawnlocations[team]) {
        if(!issubstr(location, "HQ") && issubstr(location, "fob")) {
          _id_2EBE16A8C2CAFE36 = 1;
          _id_00786E91448E72BE = isDefined(level.spawnglobals.spawnsets[location + "_safe_" + team]);
          _id_8A0FCA89B6C1A093 = location + "_" + team;
          _id_363D9492F84CD9E5 = undefined;

          if(_id_00786E91448E72BE)
            _id_363D9492F84CD9E5 = location + "_safe_" + team;

          if(isDefined(level.spawninfluencezones)) {
            trigger = undefined;
            keys = getarraykeys(level.spawninfluencezones);

            foreach(key in keys) {
              if(key == location) {
                trigger = level.spawninfluencezones[key];
                break;
              }
            }

            if(isDefined(trigger) && trigger isteamtouching(scripts\mp\utility\game::getotherteam(team)[0]))
              _id_2EBE16A8C2CAFE36 = 0;
          }

          indanger = 0;

          if(isDefined(_id_F7632B4589B2BED4)) {
            _id_1E77BB9E18BF61A7 = undefined;
            _id_55807291C518DEED = undefined;

            if(_id_2EBE16A8C2CAFE36) {
              scripts\mp\spawnlogic::activatespawnset(_id_8A0FCA89B6C1A093, 1);
              _id_1E77BB9E18BF61A7 = _id_F7632B4589B2BED4 getspawnbucketforplayer();
              _id_1E77BB9E18BF61A7 = scripts\mp\spawnlogic::getspawnbucketfromstring(_id_1E77BB9E18BF61A7);
            }

            if(_id_00786E91448E72BE) {
              scripts\mp\spawnlogic::activatespawnset(_id_363D9492F84CD9E5, 1);
              _id_55807291C518DEED = _id_F7632B4589B2BED4 getspawnbucketforplayer();
              _id_55807291C518DEED = scripts\mp\spawnlogic::getspawnbucketfromstring(_id_55807291C518DEED);
            }

            if(_id_2EBE16A8C2CAFE36 && _id_00786E91448E72BE)
              indanger = _id_1E77BB9E18BF61A7 >= 2 && _id_55807291C518DEED >= 2;
            else if(_id_2EBE16A8C2CAFE36 && !_id_00786E91448E72BE)
              indanger = _id_1E77BB9E18BF61A7 >= 2;
            else if(_id_00786E91448E72BE)
              indanger = _id_55807291C518DEED >= 2;
          }

          objectivekey = level.spawnselectionlocations[location][team].objectivekey;
          level.objectives[objectivekey].spawnpointdanger = indanger;
          level.objectives[objectivekey].spawnpointdangertime = gettime();
        }
      }
    }

    wait 1.0;
  }
}

updatespecificfobindanger(location, player, team) {
  objectivekey = level.spawnselectionlocations[location][team].objectivekey;

  if(!isDefined(objectivekey) || !isDefined(level.objectives[objectivekey]) || !isDefined(level.objectives[objectivekey].spawnpointdangertime) || level.objectives[objectivekey].spawnpointdangertime == gettime()) {
    return;
  }
  _id_2EBE16A8C2CAFE36 = 1;
  _id_00786E91448E72BE = isDefined(level.spawnglobals.spawnsets[location + "_safe_" + team]);
  _id_8A0FCA89B6C1A093 = location + "_" + team;
  _id_363D9492F84CD9E5 = undefined;

  if(_id_00786E91448E72BE)
    _id_363D9492F84CD9E5 = location + "_safe_" + team;

  if(isDefined(level.spawninfluencezones)) {
    trigger = undefined;
    keys = getarraykeys(level.spawninfluencezones);

    foreach(key in keys) {
      if(key == location) {
        trigger = level.spawninfluencezones[key];
        break;
      }
    }

    if(isDefined(trigger) && isDefined(trigger.numplayers) && trigger.numplayers[scripts\mp\utility\game::getotherteam(team)[0]] > 0)
      _id_2EBE16A8C2CAFE36 = 0;
  }

  indanger = 0;

  if(isDefined(player)) {
    _id_1E77BB9E18BF61A7 = undefined;
    _id_55807291C518DEED = undefined;

    if(_id_2EBE16A8C2CAFE36) {
      scripts\mp\spawnlogic::activatespawnset(_id_8A0FCA89B6C1A093, 1);
      _id_1E77BB9E18BF61A7 = player getspawnbucketforplayer();
      _id_1E77BB9E18BF61A7 = scripts\mp\spawnlogic::getspawnbucketfromstring(_id_1E77BB9E18BF61A7);
    }

    if(_id_00786E91448E72BE) {
      scripts\mp\spawnlogic::activatespawnset(_id_363D9492F84CD9E5, 1);
      _id_55807291C518DEED = player getspawnbucketforplayer();
      _id_55807291C518DEED = scripts\mp\spawnlogic::getspawnbucketfromstring(_id_55807291C518DEED);
    }

    if(_id_2EBE16A8C2CAFE36 && _id_00786E91448E72BE)
      indanger = _id_1E77BB9E18BF61A7 >= 2 && _id_55807291C518DEED >= 2;
    else if(_id_2EBE16A8C2CAFE36 && !_id_00786E91448E72BE)
      indanger = _id_1E77BB9E18BF61A7 >= 2;
    else if(_id_00786E91448E72BE)
      indanger = _id_55807291C518DEED >= 2;
  }

  level.objectives[objectivekey].spawnpointdanger = indanger;
  level.objectives[objectivekey].spawnpointdangertime = gettime();
}

vehicle_showteamtanks() {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(tank in level.trackedtanks[self.team])
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(tank.spawnselectionmarker.objidnum, self);

  while(self.inspawnselection)
    waitframe();

  foreach(tank in level.trackedtanks["axis"])
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(tank.spawnselectionmarker.objidnum, self);

  foreach(tank in level.trackedtanks["allies"])
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(tank.spawnselectionmarker.objidnum, self);
}

_id_F83711DD7546DB96() {
  if(!isDefined(level.gw_objstruct) || !isDefined(level.gw_objstruct.allieshqloc) || !isDefined(level.gw_objstruct.allieshqloc.marker)) {
    return;
  }
  if(self.team == "allies") {
    if(level._id_A50B22FA98674A50)
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.allieshqloc.marker.objidnum, self);
    else
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.allieshqloc.marker.objidnum, self);

    if(level._id_F15BECFBC1B01A1B)
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.axishqloc.enemymarker.objidnum, self);
    else
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.axishqloc.enemymarker.objidnum, self);
  } else {
    if(level._id_A50B22FA98674A50)
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.axishqloc.marker.objidnum, self);
    else
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.axishqloc.marker.objidnum, self);

    if(level._id_F15BECFBC1B01A1B)
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.allieshqloc.enemymarker.objidnum, self);
    else
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.allieshqloc.enemymarker.objidnum, self);
  }
}

_id_DC659688380C4195() {
  if(!isDefined(level.gw_objstruct) || !isDefined(level.gw_objstruct.allieshqloc) || !isDefined(level.gw_objstruct.allieshqloc.marker)) {
    return;
  }
  if(self.team == "allies") {
    if(level._id_757EC02DF4D678F5)
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.allieshqloc.marker.objidnum, self);
    else
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.allieshqloc.marker.objidnum, self);

    if(level._id_6F40C2B6970373C0)
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.axishqloc.enemymarker.objidnum, self);
    else
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.axishqloc.enemymarker.objidnum, self);
  } else {
    if(level._id_757EC02DF4D678F5)
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.axishqloc.marker.objidnum, self);
    else
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.axishqloc.marker.objidnum, self);

    if(level._id_6F40C2B6970373C0)
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.allieshqloc.enemymarker.objidnum, self);
    else
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.allieshqloc.enemymarker.objidnum, self);
  }
}