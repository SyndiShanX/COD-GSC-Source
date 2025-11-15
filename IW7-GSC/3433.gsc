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
  var_00 = 0;
  for(;;) {
    var_01 = tablelookupbyrow("mp\battleRigTable.csv", var_00, 0);
    if(!isDefined(var_01) || var_01 == "") {
      break;
    }

    var_01 = int(var_01);
    var_02 = tablelookupbyrow("mp\battleRigTable.csv", var_00, 1);
    level.archetypes[var_01] = var_02;
    level.archetypeids[var_02] = var_01;
    var_00++;
  }
}

removearchetype(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = undefined;
  switch (param_00) {
    case "archetype_assault":
      var_01 = ::scripts\mp\archetypes\archassault::removearchetype;
      break;

    case "archetype_heavy":
      var_01 = ::scripts\mp\archetypes\archheavy::removearchetype;
      break;

    case "archetype_scout":
      var_01 = ::scripts\mp\archetypes\archscout::removearchetype;
      break;

    case "archetype_assassin":
      var_01 = ::scripts\mp\archetypes\archassassin::removearchetype;
      break;

    case "archetype_engineer":
      var_01 = ::scripts\mp\archetypes\archengineer::removearchetype;
      break;

    case "archetype_sniper":
      var_01 = ::scripts\mp\archetypes\archsniper::removearchetype;
      break;

    default:
      break;
  }

  if(isDefined(var_01)) {
    self[[var_01]]();
  }
}

_allowbattleslide(param_00) {
  if(param_00) {
    scripts\mp\utility::giveperk("specialty_battleslide");
    return;
  }

  self notify("battleslide_unset");
}

func_1170(param_00) {
  if(param_00) {
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

getrigindexfromarchetyperef(param_00) {
  if(!isDefined(param_00) || param_00 == "none") {
    return 0;
  }

  for(var_01 = 0; var_01 < level.archetypes.size; var_01++) {
    if(level.archetypes[var_01] == param_00) {
      return var_01;
    }
  }

  return 0;
}