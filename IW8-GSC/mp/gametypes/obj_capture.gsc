/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\obj_capture.gsc
***********************************************/

init() {
  var_0 = spawnStruct();
  var_0.pickuptime = 0.5;
  var_0.usetextfriendly = &"_encstr_A6C0122563BE8207F1ADD66D20F851FF6C2987B7";
  var_0.usetextenemy = &"_encstr_936A11A62879A32950900929278E7D19C414A3";
  var_0.onpickupfn = ::onobjectpickup;
  var_0.ondropfn = ::onobjectdrop;
  var_0.onresetfn = ::onobjectreset;
  var_0.ondelivered = ::onobjectdelivered;
  var_0.pickupicon = "_encstr_BEC116582930AAEF8732DB6FC8EBE1F1938B273EC856B7EA";
  var_0.delivertime = 0.5;
  level.objectivesettings["_encstr_8E1904B3F501"] = var_0;
}

createcaptureobjective(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = level.objectivesettings["_encstr_8E1904B3F501"];

  var_3 = createcarryobject(var_0, var_1, var_2);
  var_4 = creategoal(var_3.visuals[0].target, var_3, var_1, var_2);
  var_3.goal = var_4;
}

createcarryobject(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_3))
    scripts\engine\utility::error("_encstr_8F6B1039ED40B6BD19B21B027358B62B4680" + var_0 + "_encstr_93A7083EF94845CA1563");
  else {
    var_4 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_3.origin, 0, 96, 120);
    var_5 = scripts\mp\gameobjects::createcarryobject(var_1, var_4, [var_3], (0, 0, 85));
    var_5 scripts\mp\gameobjects::setteamusetime("_encstr_ACFC091AE8AB2FCBE15119", var_2.pickuptime);
    var_5 scripts\mp\gameobjects::setteamusetime("_encstr_88BF06FD784A6393", var_2.pickuptime);
    var_5 scripts\mp\gameobjects::setteamusetext("_encstr_88BF06FD784A6393", var_2.usetextfriendly);
    var_5 scripts\mp\gameobjects::setteamusetext("_encstr_ACFC091AE8AB2FCBE15119", var_2.usetextenemy);
    var_5 scripts\mp\gameobjects::allowcarry("_encstr_88BF06FD784A6393");
    var_5 scripts\mp\gameobjects::setobjectivestatusicons(var_2.pickupicon, var_2.pickupicon);
    var_5 scripts\mp\gameobjects::setvisibleteam("_encstr_88BF06FD784A6393");
    var_5.objidpingfriendly = 1;
    var_5.allowweapons = 1;
    var_5.onpickup = var_2.onpickupfn;
    var_5.onpickupfailed = var_2.onpickupfailfn;
    var_5.ondrop = var_2.ondropfn;
    var_5.onreset = var_2.onresetfn;
    var_5.settings = var_2;

    if(!isDefined(var_2.carrymodel))
      var_2.carrymodel = var_3.model;

    var_5 setnodeploy(1);
    var_5 setnonstick(1);
  }
}

creategoal(var_0, var_1, var_2, var_3) {
  var_4 = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_4))
    scripts\engine\utility::error("_encstr_9999170D709AFF623F5102AB95D32A37687B2E8D2998858AA7" + var_4 + "_encstr_93A7083EF94845CA1563");
  else {
    var_5 = scripts\mp\gameobjects::createuseobject(var_2, var_4, [], (0, 0, 85));
    var_5 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
    var_5 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_5 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_ADE9169F974911BF3A3A750FBABCAB4305A14CAF2AF07ADA", "_encstr_825C14FB02F737705C6E114F8AC598FD535971606ADB");
    var_5 scripts\mp\gameobjects::setusetime(var_3.delivertime);
    var_5 scripts\mp\gameobjects::setkeyobject(var_1);
    var_5.onuse = var_3.ondelivered;
    var_5.settings = var_3;
  }
}

onobjectpickup(var_0, var_1, var_2) {
  if(var_0.team == scripts\mp\gameobjects::getownerteam())
    scripts\mp\gameobjects::returnhome();
  else {
    var_0 attachobjecttocarrier(self.settings.carrymodel);
    scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_82FD166339ABDBC568F5446787404AB3D533DA69C00B63FD", "_encstr_BE7610A351B00882DBB5B3279BFE0A5FB09B");
  }
}

onobjectdrop(var_0) {
  scripts\mp\gameobjects::allowcarry("_encstr_9A19040BCDBC");
  scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_88D8197847B9B36722359D304E9A61FB1D9360C1E37D692FBB9F96", "_encstr_BEC116582930AAEF8732DB6FC8EBE1F1938B273EC856B7EA");
}

returnaftertime() {
  if(!isDefined(self.settings.returntime)) {
    return;
  }
  self endon("_encstr_9A990A13739E149BF7605DD9");
  wait(self.settings.returntime);
  scripts\mp\gameobjects::returnhome();
}

onobjectreset() {}

onobjectdelivered(var_0) {
  self.keyobject scripts\mp\gameobjects::allowcarry("_encstr_8BBA05185F8B99");
  self.keyobject scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  var_0 detachobjectifcarried();
  scripts\mp\gameobjects::deleteuseobject();
}

attachobjecttocarrier(var_0) {
  self attach(var_0, "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6", 1);
  self.carriedobject = var_0;
}

detachobjectifcarried() {
  if(isDefined(self.carriedobject)) {
    self detach(self.carriedobject, "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6");
    self.carriedobject = undefined;
  }
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  detachobjectifcarried();
}