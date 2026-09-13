/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_capture.gsc
************************************************/

init() {
  settings = spawnStruct();
  settings.pickuptime = 0.5;
  settings.usetextfriendly = &"MP/RETURNING_FLAG";
  settings.usetextenemy = &"MP/GRABBING_FLAG";
  settings.onpickupfn = ::onobjectpickup;
  settings.ondropfn = ::onobjectdrop;
  settings.onresetfn = ::onobjectreset;
  settings.ondelivered = ::onobjectdelivered;
  settings.pickupicon = "waypoint_capture_take";
  settings.delivertime = 0.5;
  level.objectivesettings["ctf"] = settings;
}

createcaptureobjective(_id_84BFD80DD3535D6D, team, settings) {
  if(!isDefined(settings))
    settings = level.objectivesettings["ctf"];

  _id_61B9936BD67AFC79 = createcarryobject(_id_84BFD80DD3535D6D, team, settings);
  goal = creategoal(_id_61B9936BD67AFC79.visuals[0].target, _id_61B9936BD67AFC79, team, settings);
  _id_61B9936BD67AFC79.goal = goal;
}

createcarryobject(_id_84BFD80DD3535D6D, team, settings) {
  _id_5FF5210F68C5F433 = getEnt(_id_84BFD80DD3535D6D, "targetname");

  if(!isDefined(_id_5FF5210F68C5F433))
    scripts\engine\utility::error("No model named " + _id_84BFD80DD3535D6D + " found!");
  else {
    trigger = spawn("trigger_radius", _id_5FF5210F68C5F433.origin, 0, 96, 120);
    object = scripts\mp\gameobjects::createcarryobject(team, trigger, [_id_5FF5210F68C5F433], (0, 0, 85));
    object scripts\mp\gameobjects::setteamusetime("friendly", settings.pickuptime);
    object scripts\mp\gameobjects::setteamusetime("enemy", settings.pickuptime);
    object scripts\mp\gameobjects::setteamusetext("enemy", settings.usetextfriendly);
    object scripts\mp\gameobjects::setteamusetext("friendly", settings.usetextenemy);
    object scripts\mp\gameobjects::allowcarry("enemy");
    object scripts\mp\gameobjects::setobjectivestatusicons(settings.pickupicon, settings.pickupicon);
    object scripts\mp\gameobjects::setvisibleteam("enemy");
    object.objidpingfriendly = 1;
    object.allowweapons = 1;
    object.onpickup = settings.onpickupfn;
    object.onpickupfailed = settings.onpickupfailfn;
    object.ondrop = settings.ondropfn;
    object.onreset = settings.onresetfn;
    object.settings = settings;

    if(!isDefined(settings.carrymodel))
      settings.carrymodel = _id_5FF5210F68C5F433.model;

    object setnodeploy(1);
    object setnonstick(1);
  }
}

creategoal(_id_4E0BFADC66E471D1, _id_C07321AC837070B6, team, settings) {
  _id_BD7F0D49276A106A = getEnt(_id_4E0BFADC66E471D1, "targetname");

  if(!isDefined(_id_BD7F0D49276A106A))
    scripts\engine\utility::error("No goal trigger named " + _id_BD7F0D49276A106A + " found!");
  else {
    goal = scripts\mp\gameobjects::createuseobject(team, _id_BD7F0D49276A106A, [], (0, 0, 85));
    goal scripts\mp\gameobjects::allowuse("enemy");
    goal scripts\mp\gameobjects::setvisibleteam("any");
    goal scripts\mp\gameobjects::setobjectivestatusicons("waypoint_blitz_defend", "waypoint_blitz_goal");
    goal scripts\mp\gameobjects::setusetime(settings.delivertime);
    goal scripts\mp\gameobjects::setkeyobject(_id_C07321AC837070B6);
    goal.onuse = settings.ondelivered;
    goal.settings = settings;
  }
}

onobjectpickup(player, _id_5760E0F038D1BAA3, defused) {
  if(player.team == scripts\mp\gameobjects::getownerteam())
    scripts\mp\gameobjects::returnhome();
  else {
    player attachobjecttocarrier(self.settings.carrymodel);
    scripts\mp\gameobjects::setvisibleteam("any");
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_capture_kill", "waypoint_escort");
  }
}

onobjectdrop(player) {
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_capture_recover", "waypoint_capture_take");
}

returnaftertime() {
  if(!isDefined(self.settings.returntime)) {
    return;
  }
  self endon("picked_up");
  wait(self.settings.returntime);
  scripts\mp\gameobjects::returnhome();
}

onobjectreset() {}

onobjectdelivered(player) {
  self.keyobject scripts\mp\gameobjects::allowcarry("none");
  self.keyobject scripts\mp\gameobjects::setvisibleteam("none");
  player detachobjectifcarried();
  scripts\mp\gameobjects::deleteuseobject();
}

attachobjecttocarrier(_id_6C37C6A8BB079680) {
  self attach(_id_6C37C6A8BB079680, "tag_stowed_back3", 1);
  self.carriedobject = _id_6C37C6A8BB079680;
}

detachobjectifcarried() {
  if(isDefined(self.carriedobject)) {
    self detach(self.carriedobject, "tag_stowed_back3");
    self.carriedobject = undefined;
  }
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  detachobjectifcarried();
}