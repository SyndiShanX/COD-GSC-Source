/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_attractions.gsc
******************************************************/

#using scripts\cp_mp\parachute;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_attraction_gulag;
#using scripts\mp\gametypes\br_attraction_kingofthehill;
#using scripts\mp\gametypes\br_attraction_racetrack;
#using scripts\mp\gametypes\br_attractions;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\trigger;
#namespace br_attractions;

function init() {
  if(!scripts\mp\gametypes\br_gametypes::isfeatureenabled("attractions")) {
    return;
  }

  level.brattractions = [];
  level.brgametype.useserverhud = getdvarint(@ "hash_4452bc3660dc67fa", 1);
  scripts\mp\gametypes\br_attraction_racetrack::init();
  scripts\mp\gametypes\br_attraction_kingofthehill::init();
  scripts\mp\gametypes\br_attraction_gulag::init();
}

function iskingofthehillactive() {
  return isDefined(level.brattractions) && isDefined(level.brattractions["koth"]);
}

function onplayerdisconnect(player) {
  if(iskingofthehillactive()) {
    scripts\mp\gametypes\br_attraction_kingofthehill::onplayerdisconnect(player);
  }
}

function createattractionicontrigger(typeref, locindex, groundorigin, iconzoffset, iconshader, var_ba52080c594353fc, triggerenterfunc, triggerexitfunc, var_c9c301a888170672) {
  scriptable = spawnscriptable(var_c9c301a888170672, groundorigin);
  closeobjectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(closeobjectiveiconid != -1) {
    objorigin = groundorigin + (0, 0, iconzoffset);
    scripts\mp\objidpoolmanager::objective_add_objective(closeobjectiveiconid, "invisible", objorigin, iconshader);
    scripts\mp\objidpoolmanager::update_objective_setbackground(closeobjectiveiconid, 1);
    objective_removeallfrommask(closeobjectiveiconid);
    objective_showtoplayersinmask(closeobjectiveiconid);
    objective_setplayintro(closeobjectiveiconid, 0);
    objective_sethideelevation(closeobjectiveiconid, 1);
  }

  trigheight = scripts\cp_mp\parachute::getc130height() - groundorigin[2];
  icontrigger = spawn("trigger_radius", groundorigin, 0, var_ba52080c594353fc, trigheight);
  icontrigger.closeobjectiveiconid = closeobjectiveiconid;
  icontrigger.scriptable = scriptable;
  icontrigger.triggerenterfunc = triggerenterfunc;
  icontrigger.triggerexitfunc = triggerexitfunc;
  icontrigger.typeref = typeref;
  icontrigger.locindex = locindex;
  scripts\mp\utility\trigger::makeenterexittrigger(icontrigger, &playericontriggerenter, &playericontriggerexit, undefined, undefined, &playericonfilter);
  return icontrigger;
}

function shutdownattractionicontrigger(trigger) {
  if(istrue(trigger.shuttingdown)) {
    trigger waittill("death");
    return;
  }

  trigger.shuttingdown = 1;
  waittillframeend();
  scripts\mp\objidpoolmanager::returnobjectiveid(trigger.closeobjectiveiconid);

  if(isDefined(trigger.scriptable)) {
    trigger.scriptable freescriptable();
  }

  trigger delete();
}

function triggeraddobjectivetext(localizedstring) {
  if(istrue(level.brgametype.useserverhud)) {
    self.objectivetext = localizedstring;
  }
}

function triggerremoveobjectivetext() {
  self.objectivetext = undefined;
}

function triggersafearea() {
  self.sandbox_safe_area = 1;
}

function playericontriggerenter(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }

  player playersetattractiontype(trigger.typeref);
  player playersetattractionlocationindex(trigger.locindex);
  objective_addclienttomask(trigger.closeobjectiveiconid, player);

  if(isDefined(trigger.objectivetext)) {
    player playerhudattractionobj(trigger.objectivetext);
  }

  if(isDefined(trigger.triggerenterfunc)) {
    player thread[[trigger.triggerenterfunc]](player, trigger);
  }
}

function playericontriggerexit(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }

  if(!istrue(player.ignoreattractions)) {
    player playersetattractionoff();
  }

  objective_removeclientfrommask(trigger.closeobjectiveiconid, player);

  if(isDefined(player.hudattractionobj)) {
    player thread playerfadeobjdelete();
  }

  if(isDefined(trigger.triggerexitfunc)) {
    player thread[[trigger.triggerexitfunc]](player, trigger);
  }
}

function playerhudattractionobj(objectivetext) {
  if(!isDefined(self.hudattractionobj)) {
    self.hudattractionobj = scripts\mp\gametypes\br_attractions::createhudstring(0, objectivetext);
    return;
  }

  self notify("keepHudAttractionObj");
  self.hudattractionobj.alpha = 1;
  self.hudattractionobj settext(objectivetext);
}

function playerfadeobjdelete() {
  self endon("keepHudAttractionObj");
  var_b2d4b76e9bbd89ed = 1.5;
  obj = self.hudattractionobj;
  obj fadeovertime(var_b2d4b76e9bbd89ed);
  obj.alpha = 0;
  wait var_b2d4b76e9bbd89ed;

  if(isDefined(obj)) {
    obj destroy();
  }

  if(isDefined(self)) {
    self.hudattractionobj = undefined;
  }
}

function playersetignoreattractions(player, ignore) {
  if(istrue(player.ignoreattractions) && !ignore) {
    player playersetattractionoff();
  }

  player.ignoreattractions = ignore;
}

function playericonfilter(player, trigger) {
  return istrue(trigger.shuttingdown) || istrue(player.ignoreattractions);
}

function createhudstring(index, text) {
  hudelem = scripts\mp\hud_util::createfontstring("objective", 1.5);
  hudelem hudelementsetupandposition(index);

  if(isDefined(text)) {
    hudelem settext(text);
  }

  return hudelem;
}

function createhudtimer(index) {
  hudelem = scripts\mp\hud_util::createtimer("objective", 1.5);
  hudelem hudelementsetupandposition(index);
  return hudelem;
}

function hudelementsetupandposition(index) {
  var_fc60cba78ac17a0c = 15;
  var_9348226a53701bdb = 160;
  var_6012bdca89ff91e9 = 20;
  self.x = var_fc60cba78ac17a0c;
  self.y = var_9348226a53701bdb + index * var_6012bdca89ff91e9;
  self.alignx = "left";
  self.aligny = "top";
  self.horzalign = "left_adjustable";
  self.vertalign = "top_adjustable";
  self.alpha = 1;
  self.glowalpha = 0;
  self.hidewheninmenu = 1;
  self.archived = 0;
}

function playersetattractionoff() {
  playersetomnvarattraction(0, 0);
}

function playersetattractiontype(typeref) {
  typeindex = tablelookup("mp/brattractions.csv", 1, typeref, 0);
  assertex(isDefined(typeindex) && typeindex != "<dev string:x1c>", "<dev string:x20>");
  typeindex = int(typeindex);
  playersetomnvarattraction(0, typeindex);
}

function playersetattractionlocationindex(locationindex) {
  playersetomnvarattraction(1, locationindex);
}

function playersetattractionstateindex(stateindex) {
  playersetomnvarattraction(2, stateindex);
}

function playersetattractionextradata(extradata) {
  playersetomnvarattraction(3, extradata);
}

function playersetattractionbestplayer(player) {
  entnum = -1;

  if(isDefined(player)) {
    entnum = player getentitynumber();
  }

  playersetomnvarattraction(4, entnum);
}

function playersetattractionbesttime(timems) {
  prev = self getclientomnvar("ui_br_attraction_best_time");

  if(timems != prev) {
    self setclientomnvar("ui_br_attraction_best_time", timems);
  }
}

function playersetattractiontime(timems) {
  prev = self getclientomnvar("ui_br_attraction_time");

  if(timems != prev) {
    self setclientomnvar("ui_br_attraction_time", timems);
  }
}

function playersetomnvarattraction(dataref, value) {
  assert(isPlayer(self));
  [bitoffset, bitwidth, var_8e90fa6d5789ad63, value] = getattractionomnvarbitpackinginfo(dataref, value);

  if(var_8e90fa6d5789ad63 == "") {
    return;
  }

  playerpackdataintoomnvar(var_8e90fa6d5789ad63, value, bitoffset, bitwidth);
}

function getattractionomnvarbitpackinginfo(dataref, value) {
  bitoffset = 0;
  bitwidth = 0;
  var_8e90fa6d5789ad63 = "";

  switch (dataref) {
    case 0:
      bitoffset = 0;
      bitwidth = 8;
      var_8e90fa6d5789ad63 = "ui_br_attraction_data";
      break;
    case 1:
      [bitoffset, bitwidth] = [8, 8];
      var_8e90fa6d5789ad63 = "ui_br_attraction_data";
      break;
    case 2:
      [bitoffset, bitwidth] = [16, 8];
      var_8e90fa6d5789ad63 = "ui_br_attraction_data";
      break;
    case 3:
      [bitoffset, bitwidth] = [24, 2];
      var_8e90fa6d5789ad63 = "ui_br_attraction_data";
      break;
    case 4:
      [bitoffset, bitwidth] = [0, 8];
      var_8e90fa6d5789ad63 = "ui_br_attraction_best_data";
      value++;
      break;
    default:
      assertmsg("<dev string:x41>" + dataref + "<dev string:x5a>");
      break;
  }

  return [bitoffset, bitwidth, var_8e90fa6d5789ad63, value];
}

function playerpackdataintoomnvar(var_8e90fa6d5789ad63, value, bitoffset, bitwidth) {
  mask = int(pow(2, bitwidth)) - 1;
  var_a463992091f1d483 = (value &mask) << bitoffset;
  var_f8f977081d3da8b4 = ~(mask << bitoffset);
  prevvalue = self getclientomnvar(var_8e90fa6d5789ad63);
  cleanedbase = prevvalue &var_f8f977081d3da8b4;
  var_82a90e56e416fa55 = cleanedbase + var_a463992091f1d483;

  if(var_82a90e56e416fa55 != prevvalue) {
    self setclientomnvar(var_8e90fa6d5789ad63, var_82a90e56e416fa55);
  }
}