/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3433.gsc
************************/

init() {
  scripts\mp\archetypes\archassassin::func_97D0();
  scripts\mp\archetypes\archsniper::func_97D0();
  scripts\mp\archetypes\archengineer::func_97D0();
  scripts\mp\archetypes\archscout::func_97D0();
  scripts\mp\archetypes\archheavy::func_97D0();
  level.archetypes = [];
  level.archetypeids = [];
  var_0 = 0;
  for(;;) {
    var_1 = tablelookupbyrow("mp\battleRigTable.csv", var_0, 0);
    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_1 = int(var_1);
    var_2 = tablelookupbyrow("mp\battleRigTable.csv", var_0, 1);
    level.archetypes[var_1] = var_2;
    level.archetypeids[var_2] = var_1;
    var_0++;
  }
}

removearchetype(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = undefined;
  switch (var_0) {
    case "archetype_assault":
      var_1 = ::scripts\mp\archetypes\archassault::removearchetype;
      break;

    case "archetype_heavy":
      var_1 = ::scripts\mp\archetypes\archheavy::removearchetype;
      break;

    case "archetype_scout":
      var_1 = ::scripts\mp\archetypes\archscout::removearchetype;
      break;

    case "archetype_assassin":
      var_1 = ::scripts\mp\archetypes\archassassin::removearchetype;
      break;

    case "archetype_engineer":
      var_1 = ::scripts\mp\archetypes\archengineer::removearchetype;
      break;

    case "archetype_sniper":
      var_1 = ::scripts\mp\archetypes\archsniper::removearchetype;
      break;

    default:
      break;
  }

  if(isDefined(var_1)) {
    self[[var_1]]();
  }
}

_allowbattleslide(var_0) {
  if(var_0) {
    scripts\mp\utility::giveperk("specialty_battleslide");
    return;
  }

  self notify("battleslide_unset");
}

func_1170(var_0) {
  if(var_0) {
    scripts\mp\equipment\ground_pound::func_8659();
    return;
  }

  scripts\mp\equipment\ground_pound::func_865A();
}

func_EF38() {
  self endon("death");
  self endon("disconnect");
  self notify("scriptableBoostFxManager");
  self endon("scriptableBoostFxManager");
  thread func_139CE();
  self setscriptablepartstate("jet_pack", "neutral", 0);
  for(;;) {
    self waittill("doubleJumpBoostBegin");
    if(scripts\mp\equipment\cloak::func_9FC1() == 0) {
      self setscriptablepartstate("jet_pack", "boost_on", 0);
    }

    self waittill("doubleJumpBoostEnd");
    if(scripts\mp\equipment\cloak::func_9FC1() == 0) {
      self setscriptablepartstate("jet_pack", "neutral", 0);
    }
  }
}

func_139CE() {
  self endon("scriptableBoostFxManager");
  self waittill("death");
  self setscriptablepartstate("jet_pack", "off", 0);
  self setscriptablepartstate("teamColorPins", "off", 0);
}

func_EF41() {
  self endon("death");
  self endon("disconnect");
  self notify("scriptableSlideBoostFxManager");
  self endon("scriptableSlideBoostFxManager");
  self setscriptablepartstate("jet_pack", "neutral", 0);
  thread func_139CF();
  for(;;) {
    self waittill("sprint_slide_begin");
    if(scripts\mp\equipment\cloak::func_9FC1() == 0) {
      self setscriptablepartstate("jet_pack", "boost_slide_on", 0);
    }

    self waittill("sprint_slide_end");
    if(scripts\mp\equipment\cloak::func_9FC1() == 0) {
      self setscriptablepartstate("jet_pack", "neutral", 0);
    }
  }
}

func_139CF() {
  self endon("scriptableSlideBoostFxManager");
  self waittill("death");
  self setscriptablepartstate("jet_pack", "off", 0);
  self setscriptablepartstate("teamColorPins", "off", 0);
}

getrigindexfromarchetyperef(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return 0;
  }

  for(var_1 = 0; var_1 < level.archetypes.size; var_1++) {
    if(level.archetypes[var_1] == var_0) {
      return var_1;
    }
  }

  return 0;
}