/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\callouts.gsc
*********************************************/

init() {
  level.calloutglobals = spawnStruct();
  level.calloutglobals.callouttable = "mp\map_callouts\" + level.mapname + "_callouts.csv";
  createcalloutareaidmap();
  level.calloutglobals.areatriggers = getEntArray("callout_area", "targetname");
  foreach(var_1 in level.calloutglobals.areatriggers) {
    var_1 thread calloutareathink();
  }

  thread monitorplayers();
}

createcalloutareaidmap() {
  var_0 = level.calloutglobals;
  var_0.areaidmap = [];
  var_0.areaidmap["none"] = -1;
  var_1 = 0;
  for(;;) {
    var_2 = tablelookupbyrow(level.calloutglobals.callouttable, var_1, 0);
    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_2 = int(var_2);
    var_3 = tablelookupbyrow(level.calloutglobals.callouttable, var_1, 3);
    if(var_3 != "area") {} else {
      var_4 = tablelookupbyrow(level.calloutglobals.callouttable, var_1, 1);
      var_0.areaidmap[var_4] = var_2;
    }

    var_1++;
  }
}

monitorplayers() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_0);
    var_0 setplayercalloutarea("none");
  }
}

calloutareathink() {
  level endon("game_ended");
  for(;;) {
    self waittill("trigger", var_0);
    if(!isPlayer(var_0)) {
      continue;
    }

    var_0 setplayercalloutarea(self.script_noteworthy, self);
  }
}

setplayercalloutarea(var_0, var_1) {
  if(isDefined(self.calloutarea) && self.calloutarea == var_0) {
    return;
  }

  if(isDefined(self.calloutarea) && var_0 != "none" && self.calloutarea != "none") {
    return;
  }

  self.calloutarea = var_0;
  if(isDefined(var_1)) {
    thread watchplayerleavingcalloutarea(var_1, var_1.script_noteworthy);
  }

  var_2 = level.calloutglobals.areaidmap[var_0];
  if(isDefined(var_2)) {
    self setclientomnvar("ui_callout_area_id", var_2);
    var_3 = scripts\mp\utility::get_players_watching(1, 0);
    foreach(var_5 in var_3) {
      if(var_5 ismlgspectator()) {
        var_5 setclientomnvar("ui_callout_area_id", var_2);
      }
    }

    return;
  }

  if(var_0 != "none") {}
}

watchplayerleavingcalloutarea(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  thread clearcalloutareaondeath();
  for(;;) {
    if(self.calloutarea != var_1) {
      return;
    }

    if(!self istouching(var_0)) {
      setplayercalloutarea("none");
      return;
    }

    wait(0.5);
  }
}

clearcalloutareaondeath() {
  self endon("disconnect");
  self waittill("death");
  setplayercalloutarea("none");
}