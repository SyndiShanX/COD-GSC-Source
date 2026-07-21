/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\obj_grindzone.gsc
***********************************************/

init() {
  setuphudelements();
}

setuphudelements() {
  level.iconneutral = "_encstr_BE320FB08F710BDF6A6DD54846C215D0EF";
  level.iconcapture = "_encstr_AC3A16DD2CF2C1F696E6A3D7DCC67B9CB4733B7D99BDACBE";
  level.icondefend = "_encstr_A6A219EEB0CB83DE4B738EF5E6B1BDC9A5DC3BEB33275AB23746EB";
  level.iconenemycontested = "_encstr_96D614F3485B0B204306A14957A5E88B8B6FE045B377";
  level.iconfriendlycontested = "_encstr_96D614F3485B0B204306A14957A5E88B8B6FE045B377";
}

setupobjective(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0.origin, 0, 90, 128);
  var_3.script_label = var_0.script_label;
  var_0 = var_3;
  var_4[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_4[0].angles = var_0.angles;

  if(isDefined(var_0.objectivekey))
    var_5 = var_0.objectivekey;
  else
    var_5 = var_0.script_label;

  if(isDefined(var_0.iconname))
    var_6 = var_0.iconname;
  else
    var_6 = var_0.script_label;

  if(istrue(var_1))
    var_7 = getreservedobjid(var_5);
  else
    var_7 = undefined;

  var_8 = scripts\mp\gameobjects::createuseobject("_encstr_A7A408B9CA5D1D4E2C63", var_0, var_4, (0, 0, 90), var_1, var_2);
  var_8 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  var_8 scripts\mp\gameobjects::setusetime(level.bankcapturetime);
  var_8 scripts\mp\gameobjects::cancontestclaim(1);
  var_8 scripts\mp\gameobjects::mustmaintainclaim(1);
  var_8.tagsdeposited = 0;
  var_8.disabled = 0;
  var_8.objectivekey = var_5;
  var_8.iconname = var_6;

  if(!istrue(var_2)) {
    var_8 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_8 _id_1317D();
    objective_setlabel(var_8.objidnum, &"_encstr_AC7F2291F92993CC1751B1BD770FF4D15696F1C950B53B25F7A72D851067FF2F7DC9C179");
    var_8 scripts\engine\utility::delaythread(1.0, ::setneutral);
  }

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    var_8.visuals[0].origin = getgroundposition(var_8.trigger.origin, 2) - (0, 0, 2);
    var_8.visuals[0] setModel("_encstr_83A41A2B56BE32AC1B7B93D79DE4B0B3CA9B8EF6E62BAF0C26D7ADC1");
    var_8 thread _id_14395(var_8);
  }

  return var_8;
}

_id_14395(var_0) {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  playFX(level.spawnoffsettacinsertmax["_encstr_B8A50F48057D083AF8E073F74820B7A3D0"], getgroundposition(var_0.trigger.origin, 4) + (0, 0, 2));
}

_id_1317D() {
  self.onbeginuse = ::zone_onusebegin;
  self.onuseupdate = ::zone_onuseupdate;
  self.onenduse = ::zone_onuseend;
  self.onuse = ::zone_onuse;
  self.onunoccupied = ::zone_onunoccupied;
  self.oncontested = ::zone_oncontested;
  self.onuncontested = ::zone_onuncontested;
  self.id = "_encstr_87D9083A6F628DDB5F1F";
  scripts\mp\gameobjects::pinobjiconontriggertouch();
  self.claimgracetime = level.bankcapturetime * 1000;
  self.scriptable = setupscriptablevisuals(self.visuals[0].origin, self);
}

getreservedobjid(var_0) {
  if(var_0 == "_encstr_994C023A")
    var_1 = 0;
  else
    var_1 = 1;

  return var_1;
}

setupscriptablevisuals(var_0, var_1) {
  var_2 = var_0 + (0, 0, 32);
  var_3 = var_0 + (0, 0, -32);
  var_4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_5 = [];
  var_6 = scripts\engine\trace::ray_trace(var_2, var_3, var_5, var_4);
  var_1.baseeffectpos = var_6["_encstr_BD260953AA97E3F014279D"];
  var_7 = vectortoangles(var_6["_encstr_820E07FAE8780B3A4C"]);
  var_1.baseeffectforward = anglesToForward(var_7);
  var_1.baseeffectpos = player_give_intel_2_ks(var_1);
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.baseeffectpos);
  var_8 setModel("_encstr_A78016CE39A5B946FA991B169DFA6EC6C94B07D1C226B1CA");
  var_8.angles = generateaxisanglesfromforwardvector(var_1.baseeffectforward, var_8.angles);
  return var_8;
}

player_give_intel_2_ks(var_0) {
  var_1 = var_0.baseeffectpos;

  if(level.mapname == "_encstr_A9940CCB60D9B8B3B33AD901B212") {
    if(var_0.trigger.script_label == "_encstr_8B4C024C")
      var_1 = var_0.baseeffectpos + (0, 0, 10);
  }

  return var_1;
}

activatezone() {
  self.onbeginuse = undefined;
  self.onuseupdate = undefined;
  self.onenduse = undefined;
  self.onuse = undefined;
  self.onunoccupied = undefined;
  self.oncontested = undefined;
  self.onuncontested = undefined;
}

deactivatezone() {
  self.onbeginuse = undefined;
  self.onuseupdate = undefined;
  self.onenduse = undefined;
  self.onuse = undefined;
  self.onunoccupied = undefined;
  self.oncontested = undefined;
  self.onuncontested = undefined;
}

setneutral() {
  scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
  setneutralicons();
  updateflagstate("_encstr_A7C5056BD931D1", 0);
}

zone_onusebegin(var_0) {
  self.didstatusnotify = 0;
  thread scripts\mp\gameobjects::useobjectdecay(var_0.team);
}

zone_onuseupdate(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();

  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    if(!isagent(var_3))
      updateflagcapturestate(var_0);

    self.didstatusnotify = 1;
  }
}

zone_onuseend(var_0, var_1, var_2) {
  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
    setneutralicons();
    updateflagstate("_encstr_A7C5056BD931D1", 0);
  } else {
    setteamicons();
    updateflagstate(var_3, 0);
  }
}

zone_onuse(var_0) {
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  var_3 = scripts\mp\utility\game::getotherteam(var_1)[0];
  var_4 = gettime();
  setteamicons();
  updateflagstate(var_1, 0);
  scripts\mp\gameobjects::setownerteam(var_1);
}

zone_onunoccupied() {
  setneutralicons();
  setneutral();
}

zone_oncontested() {
  setcontestedicons();
  updateflagstate("_encstr_B85C0AD87B9B8E95CD8E2B46", 0);
}

zone_onuncontested(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "_encstr_8BBA05185F8B99" || var_1 == "_encstr_A7A408B9CA5D1D4E2C63")
    setneutralicons();
  else
    setteamicons();

  var_2 = scripts\engine\utility::ter_op(var_1 == "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A7C5056BD931D1", var_1);
  updateflagstate(var_2, 0);
}

setcrankedtimerzonecap(var_0) {
  if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var_0.cranked) && var_0.cranked)
    var_0 scripts\mp\cranked::setcrankedplayerbombtimer("_encstr_A1BD075837DCD29B47");
}

setneutralicons() {
  if(!isDefined(level.tacopssublevel))
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
}

setteamicons() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

setcontestedicons() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconfriendlycontested);
}

updateflagstate(var_0, var_1) {
  self.scriptable setscriptablepartstate("_encstr_8F7905C4EDE23F", var_0);

  if(!istrue(var_1))
    self.scriptable setscriptablepartstate("_encstr_8A0C06B1E08832D3", "_encstr_BA19049F4B2D");
}

updateflagcapturestate(var_0) {
  self.scriptable setscriptablepartstate("_encstr_8A0C06B1E08832D3", var_0);
}