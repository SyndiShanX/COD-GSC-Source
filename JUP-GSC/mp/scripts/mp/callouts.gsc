/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\callouts.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace callouts;

function init() {
  level.calloutglobals = spawnStruct();
  var_9a187ca43f4254c1 = getdvarint(@ "hash_7e7742c1722382ad", 1);

  if(var_9a187ca43f4254c1) {
    var_d27e5efe115c3af6 = function_af945a8525e5b3bb();
    var_3683bdd8902109b0 = "mp/compass_regions/" + "compassregions_poi_regions_" + level.mapname + ".csv";
    var_d8c79ee51c9021b6 = "mp/compass_regions/" + "compassregions_poi_regions_" + level.mapname + "_" + var_d27e5efe115c3af6 + ".csv";
    function_ce75c09cff4c1efb(var_d8c79ee51c9021b6, var_3683bdd8902109b0, 1);
  }

  level.calloutglobals.var_41e0068712e63739 = var_9a187ca43f4254c1 && function_afcbc7a4eac55f9e(1);

  if(!level.calloutglobals.var_41e0068712e63739) {
    if(getdvarint(@ "hash_aa26c2e5021f3cfc") && getdvarint(@ "hash_aa26c2e5021f3cfc")) {
      mapinfo = getmapscriptbundle();

      if(isDefined(mapinfo)) {
        level.calloutglobals.calloutlist = [];

        for(idx = 0; idx < mapinfo.calloutlist.size; idx++) {
          level.calloutglobals.calloutlist = array_add(level.calloutglobals.calloutlist, mapinfo.calloutlist[idx].variant_object);
        }
      } else {
        println("<dev string:x1c>");
      }
    } else if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.var_4cf37c2e28b33e1f)) {
      level.calloutglobals.callouttable = level.gamemodebundle.var_4cf37c2e28b33e1f + level.mapname + "_callouts.csv";
    } else {
      level.calloutglobals.callouttable = "mp/map_callouts/" + level.mapname + "_callouts.csv";
    }
  }

  function_2249b7a6c9367c61();

  if(!level.calloutglobals.var_41e0068712e63739 && !isDefined(level.calloutglobals.calloutlist) && !isDefined(level.calloutglobals.callouttable)) {
    return;
  }

  function_953aac55917212f6();

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && getdvarint(@ "hash_e4187d1543c7477e", 0) == 0) {
    return;
  }

  function_46502299a0d096ef();
  thread monitorplayers();
}

function private function_2249b7a6c9367c61() {
  globals = level.calloutglobals;
  globals.var_715bd89e6082150f = [];
  globals.areaidmap = [];
  globals.areaidmap["none"] = -1;
}

function private function_953aac55917212f6() {
  globals = level.calloutglobals;

  if(globals.var_41e0068712e63739) {
    sitecount = function_c3d63e6778e39f83(1);

    for(siteidx = 0; siteidx < sitecount; siteidx++) {
      site = function_d0ed84c86e823a7c(1, siteidx);
      region = function_7fdd7f9d54666e5f(1, site.region);
      ref = region.name + " site_" + siteidx;
      assertex(!isDefined(globals.areaidmap[ref]), "<dev string:x4f>" + ref + "<dev string:x60>" + level.mapname);
      globals.areaidmap[ref] = site.region;
      globals.var_715bd89e6082150f[siteidx] = ref;
    }

    return;
  }

  if(isDefined(level.calloutglobals.calloutlist)) {
    for(idx = 0; idx < level.calloutglobals.calloutlist.size; idx++) {
      type = level.calloutglobals.calloutlist[idx].type;

      if(type != "area") {
        continue;
      }

      ref = level.calloutglobals.calloutlist[idx].calloutref;
      assertex(!isDefined(globals.areaidmap[ref]), "<dev string:x4f>" + ref + "<dev string:x60>" + level.mapname);
      globals.areaidmap[ref] = idx;
    }

    return;
  }

  if(isDefined(level.calloutglobals.callouttable) && tableexists(level.calloutglobals.callouttable)) {
    for(row = 0; true; row++) {
      id = tablelookupbyrow(level.calloutglobals.callouttable, row, 0);

      if(!isDefined(id) || id == "") {
        break;
      }

      id = int(id);
      type = tablelookupbyrow(level.calloutglobals.callouttable, row, 3);

      if(type != "area") {
        continue;
      }

      ref = tablelookupbyrow(level.calloutglobals.callouttable, row, 1);
      assertex(!isDefined(globals.areaidmap[ref]), "<dev string:x4f>" + ref + "<dev string:x7b>" + level.calloutglobals.callouttable);
      globals.areaidmap[ref] = id;
    }
  }
}

function private function_46502299a0d096ef() {
  if(!level.calloutglobals.var_41e0068712e63739) {
    level.calloutglobals.areatriggers = getEntArray("callout_area", "targetname");

    foreach(areatrigger in level.calloutglobals.areatriggers) {
      areatrigger thread function_b9da575102b3cd82();
    }
  }
}

function private monitorplayers() {
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    player thread clearcalloutareaondeath();
    player setplayercalloutarea("none");

    if(level.gametype == "zm_rb") {
      player callback::add("zone_changed", &function_f9b1f6b7aa093270);
    }

    if(level.calloutglobals.var_41e0068712e63739) {
      player thread function_fe13722061e1576d();
    }
  }
}

function private function_b9da575102b3cd82() {
  level endon("game_ended");

  while(true) {
    self waittill("trigger", player);

    if(isDefined(player.owner) && isPlayer(player.owner)) {
      player = player.owner;
    }

    if(!isPlayer(player)) {
      continue;
    }

    player setplayercalloutarea(self.script_noteworthy, self);
  }
}

function private function_fe13722061e1576d() {
  assert(level.calloutglobals.var_41e0068712e63739);
  level endon("game_ended");
  self endon("death_or_disconnect");
  player = self;
  globals = level.calloutglobals;
  clientnum = player getentitynumber();

  while(gettime() / level.frameduration % 5 != clientnum % 5) {
    waitframe();
  }

  while(true) {
    siteidx = function_3db4b97c31efed0b(1, player.origin);
    ref = "none";

    if(isDefined(siteidx)) {
      ref = globals.var_715bd89e6082150f[siteidx];
    }

    areaid = globals.areaidmap[ref];

    if(!isDefined(player.calloutarea) || areaid != globals.areaidmap[player.calloutarea]) {
      player setplayercalloutarea(ref);
    }

    wait level.framedurationseconds * 5;
  }
}

function setplayercalloutarea(calloutref, trigger) {
  if(!isDefined(calloutref)) {
    return;
  }

  if(isDefined(self.calloutarea) && self.calloutarea == calloutref) {
    return;
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(isDefined(self.calloutarea) && calloutref != "none" && self.calloutarea != "none") {
      return;
    }
  }

  self.calloutarea = calloutref;

  if(isDefined(trigger)) {
    thread watchplayerleavingcalloutarea(trigger, trigger.script_noteworthy);
  }

  areaid = level.calloutglobals.areaidmap[calloutref];

  if(isDefined(areaid)) {
    self setclientomnvar("ui_callout_area_id", areaid);

    if(istrue(level.codcasterenabled)) {
      spectators = get_players_watching(1, 0);

      foreach(spectator in spectators) {
        if(spectator iscodcaster()) {
          spectator setclientomnvar("ui_callout_area_id", areaid);
        }
      }
    }

    return;
  }

  if(calloutref != "none") {
    if(level.calloutglobals.var_41e0068712e63739 || getdvarint(@ "hash_aa26c2e5021f3cfc")) {
      assertmsg("<dev string:x91>" + calloutref + "<dev string:xa3>" + level.mapname);
      return;
    }

    assertmsg("<dev string:x91>" + calloutref + "<dev string:xc1>" + level.calloutglobals.callouttable);
  }
}

function private watchplayerleavingcalloutarea(areatrigger, calloutref) {
  self endon("death_or_disconnect");

  while(true) {
    if(self.calloutarea != calloutref) {
      return;
    }

    if(!self istouching(areatrigger)) {
      setplayercalloutarea("none");
      return;
    }

    wait 0.5;
  }
}

function private clearcalloutareaondeath() {
  self endon("disconnect");

  while(true) {
    self waittill("death");
    setplayercalloutarea("none");
  }
}

function function_f9b1f6b7aa093270(params) {
  if(isDefined(params.zone_struct) && isDefined(params.zone_struct.display_name)) {
    setplayercalloutarea("none");
    setplayercalloutarea(params.zone_struct.display_name);
  }
}

function function_45d5ee5f369ad604(object) {
  assert(isDefined(object.origin));
  globals = level.calloutglobals;
  ref = "none";

  if(globals.var_41e0068712e63739) {
    siteidx = function_3db4b97c31efed0b(1, object.origin);

    if(isDefined(siteidx)) {
      ref = globals.var_715bd89e6082150f[siteidx];
    }
  } else if(isDefined(level.calloutglobals.areatriggers)) {
    foreach(areatrigger in level.calloutglobals.areatriggers) {
      if(object istouching(areatrigger)) {
        ref = areatrigger.script_noteworthy;
        break;
      }
    }
  }

  return globals.areaidmap[ref];
}