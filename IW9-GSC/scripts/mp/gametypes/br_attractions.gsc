/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_attractions.gsc
***************************************************/

init() {
  if(!_id_362C58E8BB39BCDA::isfeatureenabled("attractions")) {
    return;
  }
  level.brattractions = [];
  level.brgametype.useserverhud = getdvarint("dvar_4452BC3660DC67FA", 1);
  _id_2B18B5E07EE78187::init();
  _id_47611598F3AD2E29::init();
  _id_286C637FB939087F::init();
}

iskingofthehillactive() {
  return isDefined(level.brattractions) && isDefined(level.brattractions["koth"]);
}

onplayerdisconnect(player) {
  if(iskingofthehillactive())
    _id_47611598F3AD2E29::onplayerdisconnect(player);
}

createattractionicontrigger(typeref, locindex, groundorigin, _id_21EFA20E3C93C7D5, _id_2EAF3F31852684FD, _id_BA52080C594353FC, triggerenterfunc, triggerexitfunc, _id_C9C301A888170672) {
  scriptable = spawnscriptable(_id_C9C301A888170672, groundorigin);
  closeobjectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(closeobjectiveiconid != -1) {
    _id_E1E2FEE99EF662F0 = groundorigin + (0, 0, _id_21EFA20E3C93C7D5);
    scripts\mp\objidpoolmanager::objective_add_objective(closeobjectiveiconid, "invisible", _id_E1E2FEE99EF662F0, _id_2EAF3F31852684FD);
    scripts\mp\objidpoolmanager::update_objective_setbackground(closeobjectiveiconid, 1);
    objective_removeallfrommask(closeobjectiveiconid);
    objective_showtoplayersinmask(closeobjectiveiconid);
    objective_setplayintro(closeobjectiveiconid, 0);
    objective_sethideelevation(closeobjectiveiconid, 1);
  }

  _id_0D653CB7C1800618 = scripts\cp_mp\parachute::getc130height() - groundorigin[2];
  icontrigger = spawn("trigger_radius", groundorigin, 0, _id_BA52080C594353FC, _id_0D653CB7C1800618);
  icontrigger.closeobjectiveiconid = closeobjectiveiconid;
  icontrigger.scriptable = scriptable;
  icontrigger.triggerenterfunc = triggerenterfunc;
  icontrigger.triggerexitfunc = triggerexitfunc;
  icontrigger.typeref = typeref;
  icontrigger.locindex = locindex;
  scripts\mp\utility\trigger::makeenterexittrigger(icontrigger, ::playericontriggerenter, ::playericontriggerexit, undefined, undefined, ::playericonfilter);
  return icontrigger;
}

shutdownattractionicontrigger(trigger) {
  if(istrue(trigger.shuttingdown)) {
    trigger waittill("death");
    return;
  }

  trigger.shuttingdown = 1;
  waittillframeend;
  scripts\mp\objidpoolmanager::returnobjectiveid(trigger.closeobjectiveiconid);

  if(isDefined(trigger.scriptable))
    trigger.scriptable freescriptable();

  trigger delete();
}

triggeraddobjectivetext(_id_734564FF3D4FD467) {
  if(istrue(level.brgametype.useserverhud))
    self.objectivetext = _id_734564FF3D4FD467;
}

triggerremoveobjectivetext() {
  self.objectivetext = undefined;
}

triggersafearea() {
  self.sandbox_safe_area = 1;
}

triggercombatarea() {
  if(!isDefined(self.sandbox_combat_area))
    self.sandbox_combat_area = _id_2772CFD929B90043::getnextcombatareaid();
}

playericontriggerenter(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }
  player playersetattractiontype(trigger.typeref);
  player playersetattractionlocationindex(trigger.locindex);
  objective_addclienttomask(trigger.closeobjectiveiconid, player);

  if(isDefined(trigger.objectivetext))
    player playerhudattractionobj(trigger.objectivetext);

  if(istrue(trigger.sandbox_safe_area))
    _id_2772CFD929B90043::playerentersafearea();

  if(isDefined(trigger.sandbox_combat_area))
    _id_2772CFD929B90043::playerentercombatarea(trigger.sandbox_combat_area);

  if(isDefined(trigger.triggerenterfunc))
    player thread[[trigger.triggerenterfunc]](player, trigger);
}

playericontriggerexit(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }
  if(!istrue(player.ignoreattractions))
    player playersetattractionoff();

  objective_removeclientfrommask(trigger.closeobjectiveiconid, player);

  if(isDefined(player.hudattractionobj))
    player thread playerfadeobjdelete();

  if(istrue(trigger.sandbox_safe_area))
    _id_2772CFD929B90043::playerexitsafearea();

  if(isDefined(trigger.sandbox_combat_area))
    _id_2772CFD929B90043::playerexitcombatarea(trigger.sandbox_combat_area);

  if(isDefined(trigger.triggerexitfunc))
    player thread[[trigger.triggerexitfunc]](player, trigger);
}

playerhudattractionobj(objectivetext) {
  if(!isDefined(self.hudattractionobj))
    self.hudattractionobj = createhudstring(0, objectivetext);
  else {
    self notify("keepHudAttractionObj");
    self.hudattractionobj.alpha = 1;
    self.hudattractionobj settext(objectivetext);
  }
}

playerfadeobjdelete() {
  self endon("keepHudAttractionObj");
  _id_B2D4B76E9BBD89ED = 1.5;
  obj = self.hudattractionobj;
  obj fadeovertime(_id_B2D4B76E9BBD89ED);
  obj.alpha = 0;
  wait(_id_B2D4B76E9BBD89ED);

  if(isDefined(obj))
    obj destroy();

  if(isDefined(self))
    self.hudattractionobj = undefined;
}

playersetignoreattractions(player, ignore) {
  if(istrue(player.ignoreattractions) && !ignore)
    player playersetattractionoff();

  player.ignoreattractions = ignore;
}

playericonfilter(player, trigger) {
  return istrue(trigger.shuttingdown) || istrue(player.ignoreattractions);
}

createhudstring(index, text) {
  _id_94480E1669B7FF0D = scripts\mp\hud_util::createfontstring("objective", 1.5);
  _id_94480E1669B7FF0D hudelementsetupandposition(index);

  if(isDefined(text))
    _id_94480E1669B7FF0D settext(text);

  return _id_94480E1669B7FF0D;
}

createhudtimer(index) {
  _id_94480E1669B7FF0D = scripts\mp\hud_util::createtimer("objective", 1.5);
  _id_94480E1669B7FF0D hudelementsetupandposition(index);
  return _id_94480E1669B7FF0D;
}

hudelementsetupandposition(index) {
  _id_FC60CBA78AC17A0C = 15;
  _id_9348226A53701BDB = 160;
  _id_6012BDCA89FF91E9 = 20;
  self.x = _id_FC60CBA78AC17A0C;
  self.y = _id_9348226A53701BDB + index * _id_6012BDCA89FF91E9;
  self.alignx = "left";
  self.aligny = "top";
  self.horzalign = "left_adjustable";
  self.vertalign = "top_adjustable";
  self.alpha = 1;
  self.glowalpha = 0;
  self.hidewheninmenu = 1;
  self.archived = 0;
}

playersetattractionoff() {
  playersetomnvarattraction(0, 0);
}

playersetattractiontype(typeref) {
  _id_CE2CF5D96393DC6F = tablelookup("mp/brattractions.csv", 1, typeref, 0);
  _id_CE2CF5D96393DC6F = int(_id_CE2CF5D96393DC6F);
  playersetomnvarattraction(0, _id_CE2CF5D96393DC6F);
}

playersetattractionlocationindex(_id_0BE9720EAAAA043E) {
  playersetomnvarattraction(1, _id_0BE9720EAAAA043E);
}

playersetattractionstateindex(_id_D73C9918509F8D36) {
  playersetomnvarattraction(2, _id_D73C9918509F8D36);
}

playersetattractionextradata(_id_ADCE5B7BC256C5DD) {
  playersetomnvarattraction(3, _id_ADCE5B7BC256C5DD);
}

playersetattractionbestplayer(player) {
  entnum = -1;

  if(isDefined(player))
    entnum = player getentitynumber();

  playersetomnvarattraction(4, entnum);
}

playersetattractionbesttime(_id_05AB9EA557C8B0A4) {
  _id_D4145D9E255225DC = self getclientomnvar("ui_br_attraction_best_time");

  if(_id_05AB9EA557C8B0A4 != _id_D4145D9E255225DC)
    self setclientomnvar("ui_br_attraction_best_time", _id_05AB9EA557C8B0A4);
}

playersetattractiontime(_id_05AB9EA557C8B0A4) {
  _id_D4145D9E255225DC = self getclientomnvar("ui_br_attraction_time");

  if(_id_05AB9EA557C8B0A4 != _id_D4145D9E255225DC)
    self setclientomnvar("ui_br_attraction_time", _id_05AB9EA557C8B0A4);
}

playersetomnvarattraction(_id_AC85B79DFC4E45C6, value) {
  [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63, value] = getattractionomnvarbitpackinginfo(_id_AC85B79DFC4E45C6, value);

  if(_id_8E90FA6D5789AD63 == "") {
    return;
  }
  playerpackdataintoomnvar(_id_8E90FA6D5789AD63, value, _id_64571E3AECCD1A07, _id_8534515023AFC188);
}

getattractionomnvarbitpackinginfo(_id_AC85B79DFC4E45C6, value) {
  _id_64571E3AECCD1A07 = 0;
  _id_8534515023AFC188 = 0;
  _id_8E90FA6D5789AD63 = "";

  switch (_id_AC85B79DFC4E45C6) {
    case 0:
      _id_64571E3AECCD1A07 = 0;
      _id_8534515023AFC188 = 8;
      _id_8E90FA6D5789AD63 = "ui_br_attraction_data";
      break;
    case 1:
      [_id_64571E3AECCD1A07, _id_8534515023AFC188] = [8, 8];
      _id_8E90FA6D5789AD63 = "ui_br_attraction_data";
      break;
    case 2:
      [_id_64571E3AECCD1A07, _id_8534515023AFC188] = [16, 8];
      _id_8E90FA6D5789AD63 = "ui_br_attraction_data";
      break;
    case 3:
      [_id_64571E3AECCD1A07, _id_8534515023AFC188] = [24, 2];
      _id_8E90FA6D5789AD63 = "ui_br_attraction_data";
      break;
    case 4:
      [_id_64571E3AECCD1A07, _id_8534515023AFC188] = [0, 8];
      _id_8E90FA6D5789AD63 = "ui_br_attraction_best_data";
      value++;
      break;
    default:
      break;
  }

  return [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63, value];
}

playerpackdataintoomnvar(_id_8E90FA6D5789AD63, value, _id_64571E3AECCD1A07, _id_8534515023AFC188) {
  mask = int(pow(2, _id_8534515023AFC188)) - 1;
  _id_A463992091F1D483 = (value &mask) << _id_64571E3AECCD1A07;
  _id_F8F977081D3DA8B4 = ~(mask << _id_64571E3AECCD1A07);
  _id_EE27F3F198276535 = self getclientomnvar(_id_8E90FA6D5789AD63);
  _id_ED711AEAF5E8CB76 = _id_EE27F3F198276535 &_id_F8F977081D3DA8B4;
  _id_82A90E56E416FA55 = _id_ED711AEAF5E8CB76 + _id_A463992091F1D483;

  if(_id_82A90E56E416FA55 != _id_EE27F3F198276535)
    self setclientomnvar(_id_8E90FA6D5789AD63, _id_82A90E56E416FA55);
}