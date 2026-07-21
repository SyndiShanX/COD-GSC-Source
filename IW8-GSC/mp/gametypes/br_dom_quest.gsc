/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_dom_quest.gsc
***********************************************/

init() {
  var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcategory("_encstr_A1580B19DE5B5A9B0BA35AEDCD", 1);

  if(!var_0) {
    return;
  }
  var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcategory("_encstr_A909147CC770449B97A3A2CA88E0933F5043F3D47BE0", 1);

  if(var_0) {
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2A("_encstr_A909147CC770449B97A3A2CA88E0933F5043F3D47BE0", "_encstr_8B5F22989C367BEDE8FAE49519C26C8E95C8AF32DBB5B4E6B0A3967BCDEBD12C988D95E8");
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B3D("_encstr_A909147CC770449B97A3A2CA88E0933F5043F3D47BE0", ::markplayeraseliminatedonkilled);
  }

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B3D("_encstr_A1580B19DE5B5A9B0BA35AEDCD", ::markplayeraseliminatedonkilled);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerremovequestinstance("_encstr_A1580B19DE5B5A9B0BA35AEDCD", ::domquest_removequestinstance);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestlocale("_encstr_A5B00B4FB8380F8AF087BF83E3");
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registercreatequestlocale("_encstr_A5B00B4FB8380F8AF087BF83E3", ::domlocale_createquestlocale);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registercheckiflocaleisavailable("_encstr_A5B00B4FB8380F8AF087BF83E3", ::domlocale_checkiflocaleisavailable);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerremovequestinstance("_encstr_A5B00B4FB8380F8AF087BF83E3", ::domlocale_removelocaleinstance);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcircletick("_encstr_A5B00B4FB8380F8AF087BF83E3", ::domlocale_circletick);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2D("_encstr_A5B00B4FB8380F8AF087BF83E3", ::marked_for_no_death);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B30("_encstr_A5B00B4FB8380F8AF087BF83E3", ::markedentities_removeentsbyindex);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A5B00B4FB8380F8AF087BF83E3").nextid = 0;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297C("_encstr_A1580B19DE5B5A9B0BA35AEDCD", 1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B31("_encstr_A1580B19DE5B5A9B0BA35AEDCD", ::maphint_offerscriptableused);
  _id_13239();
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_881B13D6B4B9B9B47BE67D91B7ADD7C2C61B56C11D"] = "_encstr_9ADA22D6D26EB9D2B7E6F5AD4B6E37B4B773EB19F6B5D7B06C1BAC0E8EFA372B36ABC9AC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_960D14A170CB300B4F80677BC2458033B0B6C78BE098"] = "_encstr_81C91C0D78C823DAF09D4787FBA62361802009D750C0C7B3D59FCFBFF74E";
}

domquest_removequestinstance() {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::releaseteamonquest(self.team);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivehidefromteam(self.team);

  if(isDefined(self.tablet.trackriotshield_grenadepullbackforc4))
    [[self.tablet.trackriotshield_grenadepullbackforc4]](self);

  self._id_1393B thread mark_phone_guy_once_all_spawned();
}

domlocale_removelocaleinstance() {
  foreach(var_1 in self.subscribedinstances)
  var_1 thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();

  deletedomflaggameobject();
  self.domflag = undefined;
}

markplayeraseliminatedonkilled() {
  var_0 = role_edit(self);
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::play_train_speaker_vo("_encstr_A1580B19DE5B5A9B0BA35AEDCD", var_0);

  if(!isDefined(var_1))
    return 0;

  getlootspawnpointcount(var_1.index);
  self._id_12C4A = var_1;
  return 1;
}

domlocale_createquestlocale(var_0) {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A5B00B4FB8380F8AF087BF83E3").nextid++;
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::createlocaleinstance("_encstr_A5B00B4FB8380F8AF087BF83E3", "_encstr_A1580B19DE5B5A9B0BA35AEDCD", "_encstr_B8740AD52D2251ED815B7802" + _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A5B00B4FB8380F8AF087BF83E3").nextid);

  if(!isDefined(var_0)) {
    var_1.curorigin = (0, 0, 0);
    var_1.enabled = 0;
    return var_1;
  }

  var_2 = var_0.origin;

  if(!(var_0.spawnflags & 7)) {}

  var_3 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12971(var_0);
  var_4 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, int(var_3), int(level.defend_wave_3));
  level.setdomscriptablepartstatefunc = ::domflag_setdomscriptablepartstate;
  var_5 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_4, undefined, undefined, undefined, undefined, 0);
  var_5.squadindex = self.squadindex;
  var_5.onuse = ::domflag_onuse;
  var_5.onbeginuse = ::mark_danger_timeout;
  var_5.onuseupdate = ::domflag_onuseupdate;
  var_5.onenduse = ::domflag_onenduse;
  var_5.usecondition = ::mark_loot;
  var_5.lockupdatingicons = 1;
  var_5.getrandompointincirclewithindistance = 1;

  if(istrue(self.tablet._id_11FF8) && isDefined(var_0.traincar)) {
    if(istrue(level._id_145F1.maphint_debugthink))
      var_5.flagmodel setModel("_encstr_ABD62340F14924AFC8132B7EC357C088979827FA0D09B75B6A89386F9C6D46CFF52061B5B0");
    else
      var_5.flagmodel setModel("_encstr_933B1D1BADFA237BDAB4E6B0475ADBCDEBE07BB4378EFA03137D5BEDB39527");

    var_6 = var_0.traincar.maphint_keypadscriptableused;
    var_7 = var_0.traincar.angles;

    if(isDefined(var_0.traincar.manageworldspawnedprojectiles))
      var_7 = var_0.traincar.manageworldspawnedprojectiles;

    var_5.flagmodel linkTo(var_0.traincar.wz_tease, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_6, var_7);
    var_4 enablelinkTo();
    var_4 linkTo(var_5.flagmodel);

    if(isDefined(var_5.visuals) && isarray(var_5.visuals)) {
      foreach(var_9 in var_5.visuals)
      var_9 linkTo(var_5.flagmodel);
    }

    var_5.scriptable linkTo(var_0.traincar.wz_tease);
    var_5.traincar = var_0.traincar;
    scripts\mp\objidpoolmanager::update_objective_onentity(var_5.objidnum, var_5.flagmodel);
  } else {
    var_5.flagmodel setModel("_encstr_AD751E3382F9D3286C5F50E02BA1261F72BF38BE2F528FF077DF58E81BD978A5");
    scripts\mp\objidpoolmanager::update_objective_position(var_5.objidnum, var_5.curorigin + (0, 0, 60));
  }

  level.flagcapturetime = getdvarfloat("_encstr_BAB31E0FDF7859F2FB50B730C0010FAD05DBF5D1A76E115D032311C11BE7B80F", 30);
  var_5 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  var_1.lastcircletick = -1;
  var_1.domflag = var_5;
  var_1.curorigin = var_5.curorigin;
  var_5.locale = var_1;
  var_5.flagmodel.unresolved_collision_func = ::_id_13F27;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::addquestinstance("_encstr_A5B00B4FB8380F8AF087BF83E3", var_1);
  return var_1;
}

domlocale_checkiflocaleisavailable(var_0) {
  var_1 = getdvarfloat("_encstr_B4E425331262F7CEFB1E192805319BB39F17FB7968C3B32941416B21DDB31D6FB0ED23B7E363F4", 0.2);
  var_2 = getdvarfloat("_encstr_87391BFA49B07F3A2EAF9BBF2340F3ADE0D3B349207010A105E3974F07", 4);
  var_3 = 0;

  if(isDefined(self.domflag.curprogress))
    var_3 = self.domflag.curprogress / self.domflag.usetime;

  if(var_3 > var_1)
    return 0;

  if(self.subscribedinstances.size >= var_2)
    return 0;

  return 1;
}

domlocale_circletick(var_0, var_1) {
  if(!isDefined(self.domflag)) {
    return;
  }
  var_2 = gettime();

  if(self.lastcircletick == var_2) {
    return;
  }
  self.lastcircletick = var_2;

  if(isDefined(self.domflag) && isDefined(self.domflag.traincar))
    self.curorigin = self.domflag.traincar.origin;

  var_3 = distance2d(self.curorigin, var_0);

  if(var_3 > var_1) {
    foreach(var_5 in self.subscribedinstances) {
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(var_5.team, "_encstr_9392231640A7E328D810C851142BF0DB8FA78715AF2B172E3FFB46858DEF0ED02A0B0BB3C7");
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_875718B6D2DC6E96EDCD7DBD26A6FA6CD2278DD8B2F5CCB09636", var_5.team, 1);
      var_5.result = "_encstr_A78F076CA54E1B1B56";

      if(isDefined(var_5.tablet.trackriotshield_grenadepullbackforc4))
        [[var_5.tablet.trackriotshield_grenadepullbackforc4]](var_5);
    }

    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
  }
}

marked_for_no_death(var_0) {
  mark_danger(var_0);
}

markedentities_removeentsbyindex(var_0) {
  if(var_0.team == self.subscribedinstances[0].team)
    mark_location(var_0);
}

takequestitem(var_0) {
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::createquestinstance("_encstr_A1580B19DE5B5A9B0BA35AEDCD", self.team, var_0.index, var_0, self.squadindex);
  var_2 = "_encstr_B40101";

  if(var_0.type == "_encstr_8B5F22989C367BEDE8FAE49519C26C8E95C8AF32DBB5B4E6B0A3967BCDEBD12C988D95E8")
    var_2 = "_encstr_87D20AFAE4564616D81DAC23";

  var_1.modifier = var_2;
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerteamonquest(self.team, self);
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B15(self);
  var_1.team = self.team;
  var_1.tablet = var_0;
  var_3 = getdvarint("_encstr_A52B153380A271124E787D702407E76DB310E8E5602FF7", 240);
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297D(var_3, 4);
  var_4 = role_edit(var_0);
  var_5 = var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::requestquestlocale("_encstr_A5B00B4FB8380F8AF087BF83E3", var_4, 1);

  if(!var_5.enabled) {
    var_1.result = "_encstr_A6270A37B7BED87B8D2C36AC";

    if(isDefined(var_1.tablet.trackriotshield_grenadepullbackforc4))
      [[var_1.tablet.trackriotshield_grenadepullbackforc4]](var_1);

    var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::releaseteamonquest(self.team);
  } else {
    var_5 domflagupdateicons();
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshowtoteam("_encstr_A1580B19DE5B5A9B0BA35AEDCD" + var_1.modifier, self.team);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::addquestinstance("_encstr_A1580B19DE5B5A9B0BA35AEDCD", var_1);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13879("_encstr_A1580B19DE5B5A9B0BA35AEDCD", self, self.team);
    var_6 = spawnStruct();
    var_6.excludedplayers = [];
    var_6.excludedplayers[0] = self;
    var_6._id_127D5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardmodifier("_encstr_A1580B19DE5B5A9B0BA35AEDCD", _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.team), var_1.modifier);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_AF071F79AA67188892EF8D9BB3FAC0F0CFC20311129409BE5BB7AD8907D31DC085", var_6);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(self, "_encstr_AC72289A1BCF89302D2DDB11ADCC1780D7C0D5DF8F64DF2A61660293D789EF1DE8110B9EC5547AE9C7A8", var_6);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::searchfunc(self.team, "_encstr_8864196AD8F71DE7538E594728FECBA437B883C34949D6F3E8FD4C");
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lookforvehicles(var_1.team, self, 6, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_A1580B19DE5B5A9B0BA35AEDCD"));
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_881B13D6B4B9B9B47BE67D91B7ADD7C2C61B56C11D", var_1.team, 1);
  }
}

domflagupdateicons() {
  objective_showtoplayersinmask(self.domflag.objidnum);
  objective_removeallfrommask(self.domflag.objidnum);

  foreach(var_1 in self.subscribedinstances) {
    foreach(var_3 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_1.team, self.squadindex)) {
      if(!var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag())
        objective_addclienttomask(self.domflag.objidnum, var_3);
    }
  }
}

mark_danger(var_0) {
  objective_removeclientfrommask(self.domflag.objidnum, var_0);
}

mark_location(var_0) {
  objective_addclienttomask(self.domflag.objidnum, var_0);
}

mark_phone_guy_once_all_spawned() {
  self endon("_encstr_A2BD0839CAB6B7CE5919");
  waittillframeend;
  domflagupdateicons();
}

deletedomflaggameobject() {
  foreach(var_1 in self.domflag.visuals)
  var_1 delete();

  if(isDefined(self.domflag.flagmodel))
    self.domflag.flagmodel delete();

  if(isDefined(self.domflag.scriptable))
    self.domflag.scriptable delete();

  if(isDefined(self.domflag.trigger)) {
    self.domflag.trigger delete();
    self.domflag.trigger = undefined;
  }

  self.domflag thread gameobjectreleaseid_delayed();
  self.domflag notify("_encstr_8BE208E31FA8E1631D65");
}

gameobjectreleaseid_delayed() {
  wait 0.1;
  scripts\mp\gameobjects::releaseid();
}

_id_13239() {
  if(isDefined(level.defend_wave_3)) {
    return;
  }
  level.disableinitplayergameobjects = 0;
  level.defend_wave_3 = 120;
  level.iconneutral = "_encstr_8A2A1BBF61C8DB85C0439319D747EA8B1BB2A0F050D304DB3ECD574992";
  level.iconcapture = "_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6";
  level.icondefend = "_encstr_BAE213EE165E1CF6A57347BE91CACCB2E623AFC44E";
  level.icondefending = "_encstr_962A16BB162FE0F6D2DC1DF58C5933593791A5E6CE7DC4C9";
  level.iconcontested = "_encstr_B8CC16938363A3682C0AAB06E20F083B7A4B7BDA8CC1503B";
  level.icontaking = "_encstr_961C13B4569BE9E86943501133B9A013527F38B6EA";
  level.iconlosing = "_encstr_B41B13BB85CBE07BA59BA37DC6F6DC5A9BD9EB4C39";
  level.squadspawndebug = "_encstr_8C1211AFCFB0E25F40D9B0FA3098A6FBAF7F43";
  _setdomflagiconinfo("_encstr_8B99155A36DB9BD7DDC2970E7B2DE63AAF19BDB5FA2693", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", 0);
  _setdomflagiconinfo("_encstr_961C13B4569BE9E86943501133B9A013527F38B6EA", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", 1);
  _setdomflagiconinfo("_encstr_AF4314FB2751EB67FF25540726777BA18B835D81C5D6", "_encstr_88BF06FD784A6393", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", 0);
  _setdomflagiconinfo("_encstr_BAE213EE165E1CF6A57347BE91CACCB2E623AFC44E", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", 0);
  _setdomflagiconinfo("_encstr_962A16BB162FE0F6D2DC1DF58C5933593791A5E6CE7DC4C9", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", 0);
  _setdomflagiconinfo("_encstr_A2D015BBB0BCC1DB5AE647D713C6DBD8B6B4DC3BD789E4", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_922B2143880199E8D7D0141D599FB0E9285FFFD50AF90921CFE8AC847067F05976584F", 0);
  _setdomflagiconinfo("_encstr_966014DF178A63454BE0CB7168A9BDD7208D547F3EB3", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_B8E62095EF77589E3DD1D7FF091446D093B8EDDE7ACFA0D444D9F7E729CE0348D93E", 0);
  _setdomflagiconinfo("_encstr_B41B13BB85CBE07BA59BA37DC6F6DC5A9BD9EB4C39", "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", 1);
  _setdomflagiconinfo("_encstr_8A2A1BBF61C8DB85C0439319D747EA8B1BB2A0F050D304DB3ECD574992", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", 0);
  _setdomflagiconinfo("_encstr_B8CC16938363A3682C0AAB06E20F083B7A4B7BDA8CC1503B", "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", 1);
  _setdomflagiconinfo("_encstr_81A5177FCBC012AFA3D063D9B988FF81C0B3F2F76B101153D6", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", 0);
  _setdomflagiconinfo("_encstr_8C4418A5D8BDCDF5DD58CB387BA5E647BED12C39D9CAA3FA9839", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", 0);
  _setdomflagiconinfo("_encstr_8C1211AFCFB0E25F40D9B0FA3098A6FBAF7F43", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_BAEC2251A887D49DD7187931D1FDA5CC374FC85EDADF5C614F300119F885F766A789CFAE", 0);
}

_setdomflagiconinfo(var_0, var_1, var_2, var_3) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 1;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = "_encstr_B679245D2DF5B507D7319CFA6BB0E0DAACCDEAEBB41BDBE6EB46F6ADEBB74C4D591B1DB4EC2B";
  level.waypointpulses[var_0] = var_3;
}

domflag_onuseupdate(var_0, var_1, var_2, var_3) {
  if(var_1 < 1.0 && !level.gameended)
    _id_12427(var_1, var_0);

  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify))
    self.didstatusnotify = 1;
}

mark_danger_timeout(var_0) {
  if(!isDefined(self._id_11F63) || !self._id_11F63) {
    self._id_11F63 = 1;

    if(isDefined(self.traincar)) {
      if(isDefined(level._id_145F1) && istrue(level._id_145F1.mark_armor)) {
        var_1 = self.traincar.maphint_keypadscriptableused + (200, 0, 0);
        var_2 = self.traincar.origin + rotatevector(var_1, self.traincar.angles);
        level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(var_2, "_encstr_8218041DF5FA", 3);
      }
    } else
      level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(self.curorigin, "_encstr_8218041DF5FA");

    var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, self.squadindex);
    var_4 = scripts\mp\utility\player::getplayersinradius(self.curorigin, 7800, undefined, var_3);

    foreach(var_6 in var_4) {
      if(isDefined(var_6) && isalive(var_6))
        var_6 thread scripts\mp\hud_message::showsplash("_encstr_AD091A7A386958E75FB02851AC1A78C659D705851F231109AD99B343");
    }

    var_8 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, self.squadindex);

    foreach(var_10 in var_8)
    var_10 notify("_encstr_91D9276C8563B1B75D8EAD0B936D95E4835AB9D9EBBB8527E9F673CAA55A1B36A2AE56E6D1A436DBCD");
  }
}

domflag_onuse(var_0) {
  foreach(var_2 in self.locale.subscribedinstances) {
    if(var_2.team == var_0.team) {
      var_3 = spawnStruct();
      var_4 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(var_0.team);
      var_5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_A1580B19DE5B5A9B0BA35AEDCD" + var_2.modifier);
      var_6 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtovalue(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtotype("_encstr_A1580B19DE5B5A9B0BA35AEDCD", var_2.modifier));
      var_7 = _encstr_96292CAF888B0430F313B7ADBBE6A98203C79BE8A065087EB2CE1F3145C08EA2D74BCD198818A58A035B351780C8::clear_all_remaining(var_0);
      var_3._id_121B5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_121B9(var_5, var_4, var_6, undefined, var_7);
      self.squadindex = var_2.squadindex;
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(var_2.team, "_encstr_9BD61D1A9D81673F31A0728A2B1B075D29038565F780E1C7E8D88B6211ED67", var_3);
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lookforvehicles(var_2.team, var_0, 8, var_5);
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_960D14A170CB300B4F80677BC2458033B0B6C78BE098", var_2.team, 1, 1);
      var_2._id_12D2E = self.flagmodel.origin;
      var_2._id_12D2B = self.flagmodel.angles;
      var_2.result = "_encstr_88E30897BDF1B71F7823";

      if(isDefined(var_2.tablet.trackriotshield_grenadepullbackforc4))
        [[var_2.tablet.trackriotshield_grenadepullbackforc4]](var_2);

      if(isDefined(self.assisttouchlist[var_2.team])) {
        var_8 = getarraykeys(self.assisttouchlist[var_2.team]);

        foreach(var_10 in var_8) {
          var_11 = self.assisttouchlist[var_2.team][var_10].player;

          if(isDefined(var_11.owner))
            var_11 = var_11.owner;

          if(!isPlayer(var_11)) {
            continue;
          }
          var_11 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_8B9D3B6B7256A342777CCD05D6333A577958878330C90CDA1F8E973E48C5C13F21D83F4748204602C7AC1D72B89F6BFD8BF8F3EF105E858AB73EE42D18", 1);
          var_11 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_A3F63F9161A993101E0F81DA3B4FDA7666C710635C780B65F0E0DB0FDF8037B708927F07CB4BB4F5A954554BA66880FDDA07E47BABDEA062FACBB928EDAF4848BA", 1);
          var_2 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B15(var_11);
        }
      }

      continue;
    }

    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(var_2.team, "_encstr_9BEF1CF6BD17F425FDBB1B0FED3B12E3E1E220C8F24DE6DB8B9B90DD584B");
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_9B9511AD2D379B4BBDE6BE9D95B9FACC2CB48D", var_2.team, 1);
    var_2.result = "_encstr_BD79059C51C351";

    if(isDefined(var_2.tablet.trackriotshield_grenadepullbackforc4))
      [[var_2.tablet.trackriotshield_grenadepullbackforc4]](var_2);
  }

  self.locale thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
}

domflag_onenduse(var_0, var_1, var_2) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend(var_0, var_1, var_2);
}

_id_12427(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_2 = "_encstr_B40101";
    var_0 = int(floor(var_0 * 10));
    var_2 = "_encstr_856B180A5867CF6F6068A3D9972B4F12537312A1E0E3C6A71EC7" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
  }
}

domflag_setdomscriptablepartstate(var_0, var_1, var_2) {
  switch (var_1) {
    case "_encstr_B85C0AD87B9B8E95CD8E2B46":
    case "_encstr_A7C5056BD931D1":
    case "_encstr_BA19049F4B2D":
      return 0;
    default:
      var_1 = "_encstr_8F7106EACDD273CE";

      if(isDefined(var_2))
        var_1 = var_1 + var_2;

      self.scriptable setscriptablepartstate(var_0, var_1);

      if(var_0 == "_encstr_8A0C06B1E08832D3")
        self.scriptable setscriptablepartstate("_encstr_8F7905C4EDE23F", var_1);

      return 1;
  }
}

mark_loot(var_0) {
  if(getdvarint("_encstr_A614141F9B6A09DE2311F1588BBF01D087F53FBF1852", 0)) {
    if(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
      return 0;
  }

  var_1 = var_0.team;

  foreach(var_3 in self.locale.subscribedinstances) {
    if(var_3.team == var_1)
      return 1;
  }

  return 0;
}

maphint_offerscriptableused() {
  while(self._id_1393B.domflag.numtouching[self.id])
    waitframe();

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.id, "_encstr_BDC3224C39D7C8F66B96372CA34BEDB9D7E2AEAC9BD1FAE8A5DACAC9BE56E1C12DE42B23");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_9B9511AD2D379B4BBDE6BE9D95B9FACC2CB48D", self.team, 1);
}

role_edit(var_0) {
  var_1 = spawnStruct();
  var_1._id_12FA3 = "_encstr_9A17115CD55637E80AB7B473E8B9509393B097";
  var_1._id_12F9F = (var_0.origin[0], var_0.origin[1], 0);
  var_1._id_12FA6 = 12000;
  var_1._id_12FA7 = 0;
  var_1._id_12FA4 = 8000;
  var_1._id_12FA5 = 6000;
  var_1._id_1297F = 7;
  var_1.mintime = getdvarfloat("_encstr_BAB31E0FDF7859F2FB50B730C0010FAD05DBF5D1A76E115D032311C11BE7B80F", 30);
  var_1._id_12FA1 = 1;
  var_1._id_12C4A = var_0._id_12C4A;

  if(playmatchendcamera()) {
    if(var_1._id_12FA6 < level._id_12965)
      var_1._id_12FA6 = level._id_12965;

    var_1._id_12FA4 = level._id_12965;
    var_1._id_12FA5 = level._id_12966;
  }

  if(istrue(var_0._id_11FF8)) {
    var_1._id_12FA3 = "_encstr_AD1C182B5B6D903511A7F3F5E30BE7C01236526708E450677ABB";
    var_1._id_1407E = 1;
  }

  var_2 = getdvarint("_encstr_A5EE17FB4EEA61AE83D7535357FBEDC19FA58530F23439D39A", -1);
  var_3 = getdvarint("_encstr_81EE17CD36C9FA899CD7C55756DC8E88EDAD88D2CD3AA685C3", -1);

  if(var_2 >= 0)
    var_1._id_12FA5 = var_2;

  if(var_3 >= 0)
    var_1._id_12FA4 = var_3;

  return var_1;
}

playmatchendcamera() {
  var_0 = 0;
  var_1 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_88AB1A158BDF6B1548D18F7F35459A290B27CFEAE26BB0DBB00ABD20", "_encstr_A1580B19DE5B5A9B0BA35AEDCD");

  if(isDefined(var_1))
    return var_1;

  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  switch (var_2) {
    case "_encstr_87A205AF50D049":
    case "_encstr_866209ECEDB1197DEE0B4E":
    case "_encstr_9B1F05BE4B9B52":
    case "_encstr_8AE1099A0B999F2D28AF15":
    case "_encstr_BE180419DAE9":
      var_0 = 1;
      break;
  }

  return var_0;
}

_id_13F27(var_0, var_1) {
  var_0 setOrigin(var_0.origin + (0, 0, 34));
  var_0 setstance("_encstr_B13D076BED70539F23");
}