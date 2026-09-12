/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevents_meter.gsc
**********************************************************/

function init() {
  level.br_pe_meter = spawnStruct();
  level.br_pe_meter.intel_used_logic = 0;
  level.br_pe_meter.timescompleted = 0;
  level.br_pe_meter.state = 0;
  level.br_pe_meter.maxvalue = 255;
  level.br_pe_meter.targets = getdvarleveleventtargets();
  level.br_pe_meter.maxvalue = level.br_pe_meter.targets[0];
  _pemetersetdetails();
  thread ref_12933();
}

function ispubliceventmeterenabled() {
  return getdvarint("br_pe_meter_enabled", 0) > 0;
}

function getdvarleveleventtargets() {
  var_0 = getDvar("scr_br_pe_meter_event_targets", "10 15 20");
  var_1 = [];

  if(var_0 != "") {
    var_2 = strtok(var_0, " ");

    foreach(var_4 in var_2) {
      var_5 = int(var_4);
      var_1 = var_5;
    }
  }

  return var_1;
}

function getdvarpemetereventweights(var_0) {
  var_1 = getDvar("scr_br_pe_" + var_0 + "_pe_meter_event_weights", "0 0 0 0 0 0 0 0");
  var_2 = [];

  if(var_1 != "") {
    var_3 = strtok(var_1, " ");

    foreach(var_5 in var_3) {
      var_2 = float(var_5);
    }
  }

  return var_2;
}

function getcurrentmeterlevel() {
  var_0 = level.br_pe_meter.timescompleted;
  var_0 = clamp(var_0, 0, level.br_pe_meter.targets.size - 1);
  return int(var_0);
}

function ref_12933() {
  level endon("cancel_public_event");
  scripts\mp\flags::gameflagwait("prematch_done");
  setstatepemeter(1);
}

function triggernewpublicevent() {
  level thread scripts\mp\gametypes\br_publicevents::give_intel_data(1, getcurrentmeterlevel(), 1);
  level.br_pe_meter.timescompleted += 1;
}

function increasepubliceventmeter(var_0) {
  if(!ispubliceventmeterenabled()) {
    return;
  }

  if(level.br_pe_meter.state == 0) {
    return;
  }

  if(level.br_pe_meter.intel_used_logic >= level.br_pe_meter.maxvalue) {
    return;
  }

  if(!isDefined(var_0) || var_0 <= 0) {
    scripts\mp\utility\script::laststand_dogtags("PE Meter increase amount is undefined or <= 0.");
    return;
  }

  var_1 = level.br_pe_meter.intel_used_logic + var_0;
  var_1 = clamp(var_1, 0, level.br_pe_meter.maxvalue);

  if(var_1 >= level.br_pe_meter.maxvalue) {
    triggernewpublicevent();
    _pemetersetdetails(var_1, undefined, 0);
    var_2 = getdvarint("scr_br_pe_meter_delay_before_reset", 1);
    thread resetpemeter(var_2);
    return;
  }

  _pemetersetdetails(var_1, undefined, undefined);
}

function resetpemeter(var_0) {
  if(isDefined(var_0)) {
    wait var_0;
  }

  var_1 = 0;
  var_2 = level.br_pe_meter.targets[getcurrentmeterlevel()];
  _pemetersetdetails(var_1, var_2, 1);
}

function setstatepemeter(var_0) {
  _pemetersetdetails(undefined, undefined, var_0);
}

function getmetercurrentratio() {
  return level.br_pe_meter.intel_used_logic / level.br_pe_meter.maxvalue;
}

function _pemetersetdetails(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level.br_pe_meter.intel_used_logic = var_0;
  }

  if(isDefined(var_1)) {
    level.br_pe_meter.maxvalue = var_1;
  }

  if(isDefined(var_2)) {
    level.br_pe_meter.state = var_2;
  }

  var_3 = getomnvar("ui_br_pe_meter_data");
  var_4 = 0;
  var_4 += (int(level.br_pe_meter.state) & 3) << 16;
  var_4 += (int(level.br_pe_meter.maxvalue) & 255) << 8;
  var_4 += (int(level.br_pe_meter.intel_used_logic) & 255) << 0;

  if(var_3 != var_4) {
    setomnvar("ui_br_pe_meter_data", var_4);
    return;
  }
}