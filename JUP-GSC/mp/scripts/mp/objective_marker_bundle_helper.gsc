/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\objective_marker_bundle_helper.gsc
*********************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#namespace objective_marker_bundle_helper;

function function_40062e64625f8b19(bundlename) {
  bundlexhash = hashcat(%"hash_334a4b8da1c7fd3f", bundlename);
  return createobjectivemarkerfrombundlexhash(bundlexhash);
}

function createobjectivemarkerfrombundlexhash(bundlexhash) {
  if(!isDefined(level.var_9e689c10231cd26a)) {
    function_62882d44d01e1bed();
  }

  objectivemarkerbundle = getscriptbundle(bundlexhash);

  if(isDefined(objectivemarkerbundle)) {
    objectivemarkerid = scripts\mp\objidpoolmanager::requestobjectiveid(0);

    if(objectivemarkerid == -1) {
      assertmsg("<dev string:x1c>" + getxhashsourcename(bundlexhash) + "<dev string:x82>");
      return -1;
    }

    function_8678d41b7abe69c(objectivemarkerbundle, objectivemarkerid);
    function_42343c058b711417(objectivemarkerbundle, objectivemarkerid);
    function_21cb5c5225485f2a(objectivemarkerbundle, objectivemarkerid);
    function_a7836ce77f8d8cc0(objectivemarkerbundle, objectivemarkerid);
    function_bd9b7f8bf8d0835d(objectivemarkerbundle, objectivemarkerid);
    return objectivemarkerid;
  }

  assertmsg("<dev string:x95>" + getxhashsourcename(bundlexhash) + "<dev string:xb9>");
  return -1;
}

function private function_62882d44d01e1bed() {
  if(isDefined(level.var_9e689c10231cd26a)) {
    return;
  }

  level.var_9e689c10231cd26a = function_6859acd104e04215();
}

function private function_6859acd104e04215() {
  var_9e689c10231cd26a = spawnStruct();
  var_9e689c10231cd26a.backgroundoptions = [];
  var_9e689c10231cd26a.backgroundoptions["default"] = 0;
  var_9e689c10231cd26a.backgroundoptions["no_background"] = 1;
  var_9e689c10231cd26a.backgroundoptions["carry_object"] = 2;
  var_9e689c10231cd26a.backgroundoptions["mission"] = 3;
  var_9e689c10231cd26a.backgroundoptions["mission_tracked"] = 4;
  var_9e689c10231cd26a.backgroundoptions["poi"] = 5;
  var_9e689c10231cd26a.backgroundoptions["circle"] = 6;
  var_9e689c10231cd26a.backgroundoptions["diamond"] = 7;
  var_9e689c10231cd26a.backgroundoptions["stronghold"] = 8;
  var_9e689c10231cd26a.backgroundoptions["side_relative"] = 9;
  return var_9e689c10231cd26a;
}

function private function_8678d41b7abe69c(objectivemarkerbundle, objectivemarkerid) {
  generalsettings = objectivemarkerbundle.generalsettings;
  minimapsettings = objectivemarkerbundle.minimapsettings;
  var_4b16eeed74027f36 = objectivemarkerbundle.var_4b16eeed74027f36;
  compasssettings = objectivemarkerbundle.compasssettings;
  hudsettings = objectivemarkerbundle.hudsettings;
  objective_icon(objectivemarkerid, generalsettings.var_63d1b5b543ef6387);
  objective_state(objectivemarkerid, generalsettings.state);
  function_5fd2627c5ce186db(objectivemarkerid, generalsettings.isoptional);
  objective_setownerteam(objectivemarkerid, generalsettings.ownerteam);
  backgroundoption = level.var_9e689c10231cd26a.backgroundoptions[generalsettings.background];
  objective_setbackground(objectivemarkerid, backgroundoption);

  if(isDefined(generalsettings.var_670c323f7450e31c)) {
    var_670c323f7450e31c = (0, 0, 0);
    var_22fcb4a5ea0d8ffd = generalsettings.var_670c323f7450e31c;
    var_a1308c95bb637c66 = strtok(var_22fcb4a5ea0d8ffd, " ");

    if(var_a1308c95bb637c66.size == 4) {
      var_670c323f7450e31c = (float(var_a1308c95bb637c66[0]) * 255, float(var_a1308c95bb637c66[1]) * 255, float(var_a1308c95bb637c66[2]) * 255);
    }

    objective_settint(objectivemarkerid, int(var_670c323f7450e31c[0]), int(var_670c323f7450e31c[1]), int(var_670c323f7450e31c[2]));
  }
}

function private function_42343c058b711417(objectivemarkerbundle, objectivemarkerid) {
  minimapsettings = objectivemarkerbundle.minimapsettings;
  objective_setminimapiconsize(objectivemarkerid, minimapsettings.minimapsize);
  function_9766d0b79eada249(objectivemarkerid, minimapsettings.var_2c9e3e6eb028ae83);
  function_865f9c5d005f9a08(objectivemarkerid, minimapsettings.var_ca24ca64976c2e5a);
  function_6468f83ab1b52315(objectivemarkerid, minimapsettings.var_1c92f2975a3a8fdf);
  objective_setrotateonminimap(objectivemarkerid, minimapsettings.var_750c1118d84c32bc);
}

function private function_21cb5c5225485f2a(objectivemarkerbundle, objectivemarkerid) {
  var_4b16eeed74027f36 = objectivemarkerbundle.var_4b16eeed74027f36;
  function_9427cb5974c925d9(objectivemarkerid, var_4b16eeed74027f36.var_3105aa9935faca5a);
  function_2b46ef80dca002f9(objectivemarkerid, var_4b16eeed74027f36.var_2ca015b89073d0f6);
  function_9929f54e3253dbb4(objectivemarkerid, var_4b16eeed74027f36.var_49d9c4f6fdf7fee2);
  objective_sethideelevation(objectivemarkerid, var_4b16eeed74027f36.hideelevation);
}

function private function_a7836ce77f8d8cc0(objectivemarkerbundle, objectivemarkerid) {
  compasssettings = objectivemarkerbundle.compasssettings;
  objective_setshowoncompass(objectivemarkerid, compasssettings.showoncompass);
}

function private function_bd9b7f8bf8d0835d(objectivemarkerbundle, objectivemarkerid) {
  hudsettings = objectivemarkerbundle.hudsettings;
  objective_setpulsate(objectivemarkerid, hudsettings.var_ae2a59338cbf7d38);
  objective_setshowprogress(objectivemarkerid, hudsettings.showprogressbar);
  objective_setplayintro(objectivemarkerid, hudsettings.var_155aeca74730ee1a);
  objective_setplayoutro(objectivemarkerid, hudsettings.var_188b0071d7c1b2c3);
  objective_setshowdistance(objectivemarkerid, hudsettings.showdistance);
  objective_setzoffset(objectivemarkerid, hudsettings.zoffset);

  if(isDefined(hudsettings.hudtext.label) && hudsettings.hudtext.label != "") {
    objective_setlabel(objectivemarkerid, hudsettings.hudtext.label);
  }

  if(isDefined(hudsettings.hudtext.friendlylabel) && hudsettings.hudtext.friendlylabel != "") {
    objective_setfriendlylabel(objectivemarkerid, hudsettings.hudtext.friendlylabel);
  }

  if(isDefined(hudsettings.hudtext.enemylabel) && hudsettings.hudtext.enemylabel != "") {
    objective_setenemylabel(objectivemarkerid, hudsettings.hudtext.enemylabel);
  }

  if(isDefined(hudsettings.hudtext.neutrallabel) && hudsettings.hudtext.neutrallabel != "") {
    objective_setneutrallabel(objectivemarkerid, hudsettings.hudtext.neutrallabel);
  }

  if(isDefined(hudsettings.hudtext.description) && hudsettings.hudtext.description != "") {
    objective_setdescription(objectivemarkerid, hudsettings.hudtext.description);
  }
}