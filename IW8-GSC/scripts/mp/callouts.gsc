/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\callouts.gsc
***********************************************/

function init() {
  level.calloutglobals = spawnStruct();
  level.calloutglobals.callouttable = "mp/map_callouts/" + level.mapname + "_callouts.csv";
  createcalloutareaidmap();

  if(scripts\mp\utility\game::getgametype() == "br") {
    return;
  }

  level.calloutglobals.areatriggers = getEntArray("callout_area", "targetname");

  foreach(var1 in level.calloutglobals.areatriggers) {
    thread calloutareathink();
  }

  thread monitorplayers();
}

function createcalloutareaidmap() {
  var0 = level.calloutglobals;
  var0.areaidmap = [];
  var0.areaidmap["none"] = -1;

  if(!tableexists(level.calloutglobals.callouttable)) {
    return;
  }

  for(var1 = 0;; var1++) {
    var2 = tablelookupbyrow(level.calloutglobals.callouttable, var1, 0);

    if(!isDefined(var2) || var2 == "") {
      break;
    }

    var2 = int(var2);
    var3 = tablelookupbyrow(level.calloutglobals.callouttable, var1, 3);

    if(var3 != "area") {
      continue;
    }

    var4 = tablelookupbyrow(level.calloutglobals.callouttable, var1, 1);
    var0.areaidmap[var4] = var2;
  }
}

function monitorplayers() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var0);
    thread clearcalloutareaondeath();
    setplayercalloutarea(var0, "none");
  }
}

function calloutareathink() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var0);

    if(!isPlayer(var0)) {
      continue;
    }

    setplayercalloutarea(var0, self.script_noteworthy, self);
  }
}

function setplayercalloutarea(var0, var1) {
  if(isDefined(self.calloutarea) && self.calloutarea == var0) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() != "br") {
    if(isDefined(self.calloutarea) && var0 != "none" && self.calloutarea != "none") {
      return;
    }
  }

  self.calloutarea = var0;

  if(isDefined(var1)) {
    thread watchplayerleavingcalloutarea(var1, var1.script_noteworthy);
  }

  var2 = level.calloutglobals.areaidmap[var0];

  if(isDefined(var2)) {
    self setclientomnvar("ui_callout_area_id", var2);

    if(level.codcasterenabled) {
      var3 = scripts\mp\utility\player::get_players_watching(1, 0);

      foreach(var5 in var3) {
        if(var5 ismlgspectator()) {
          var5 setclientomnvar("ui_callout_area_id", var2);
        }
      }

      return;
    }

    return;
  }

  if(var4 != "none") {
    return;
  }
}

function watchplayerleavingcalloutarea(var0, var1) {
  self endon("death_or_disconnect");

  for(;;) {
    if(self.calloutarea != var1) {
      return;
    }

    if(!self istouching(var0)) {
      setplayercalloutarea("none");
      return;
    }

    wait 0.5;
  }
}

function clearcalloutareaondeath() {
  self endon("disconnect");

  for(;;) {
    self waittill("death");
    setplayercalloutarea("none");
  }
}