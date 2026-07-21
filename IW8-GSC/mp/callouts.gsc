/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\callouts.gsc
***********************************************/

init() {
  level.calloutglobals = spawnStruct();
  level.calloutglobals.callouttable = "_encstr_95A011C791F8BA09E0B68E16C8585F732DEF46" + level.mapname + "_encstr_93350E8911CF339DF07BECD3F5A86213";
  createcalloutareaidmap();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    return;
  }
  level.calloutglobals.areatriggers = getEntArray("_encstr_83CD0DD81636B1F6BAD1F5859CAC2C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.calloutglobals.areatriggers)
  var_1 thread calloutareathink();

  thread monitorplayers();
}

createcalloutareaidmap() {
  var_0 = level.calloutglobals;
  var_0.areaidmap = [];
  var_0.areaidmap["_encstr_8BBA05185F8B99"] = -1;

  if(!tableexists(level.calloutglobals.callouttable)) {
    return;
  }
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(level.calloutglobals.callouttable, var_1, 0);

    if(!isDefined(var_2) || var_2 == "_encstr_B40101") {
      break;
    }

    var_2 = int(var_2);
    var_3 = tablelookupbyrow(level.calloutglobals.callouttable, var_1, 3);

    if(var_3 != "_encstr_878405507B07A3") {} else {
      var_4 = tablelookupbyrow(level.calloutglobals.callouttable, var_1, 1);
      var_0.areaidmap[var_4] = var_2;
    }

    var_1++;
  }
}

monitorplayers() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread clearcalloutareaondeath();
    var_0 setplayercalloutarea("_encstr_8BBA05185F8B99");
  }
}

calloutareathink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

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
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    if(isDefined(self.calloutarea) && var_0 != "_encstr_8BBA05185F8B99" && self.calloutarea != "_encstr_8BBA05185F8B99")
      return;
  }

  self.calloutarea = var_0;

  if(isDefined(var_1))
    thread watchplayerleavingcalloutarea(var_1, var_1.script_noteworthy);

  var_2 = level.calloutglobals.areaidmap[var_0];

  if(isDefined(var_2)) {
    self setclientomnvar("_encstr_850913EFEB98025148A8C54B83F999CB6D13BF1769", var_2);

    if(level.codcasterenabled) {
      var_3 = scripts\mp\utility\player::get_players_watching(1, 0);

      foreach(var_5 in var_3) {
        if(var_5 ismlgspectator())
          var_5 setclientomnvar("_encstr_850913EFEB98025148A8C54B83F999CB6D13BF1769", var_2);
      }
    }
  } else if(var_0 != "_encstr_8BBA05185F8B99")
    return;
}

watchplayerleavingcalloutarea(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    if(self.calloutarea != var_1) {
      return;
    }
    if(!self istouching(var_0)) {
      setplayercalloutarea("_encstr_8BBA05185F8B99");
      return;
    }

    wait 0.5;
  }
}

clearcalloutareaondeath() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_AD75063D571AE108");
    setplayercalloutarea("_encstr_8BBA05185F8B99");
  }
}