/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_extract_quest.gsc
***********************************************/

init() {
  var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcategory("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", 1);

  if(!var_0) {
    return;
  }
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B3D("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", ::overtimebuiltintomatchtimer);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerremovequestinstance("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", ::overridefieldupgrade1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestlocale("_encstr_B1A3181363AE5638C95A9BE82BC33AC985B147D7C6DBB116B1AC");
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registercreatequestlocale("_encstr_B1A3181363AE5638C95A9BE82BC33AC985B147D7C6DBB116B1AC", ::outofboundstimebr);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registercheckiflocaleisavailable("_encstr_B1A3181363AE5638C95A9BE82BC33AC985B147D7C6DBB116B1AC", ::outline_ents);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerremovequestinstance("_encstr_B1A3181363AE5638C95A9BE82BC33AC985B147D7C6DBB116B1AC", ::outputfunc);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcircletick("_encstr_B1A3181363AE5638C95A9BE82BC33AC985B147D7C6DBB116B1AC", ::outline_grenade_box);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2D("_encstr_B1A3181363AE5638C95A9BE82BC33AC985B147D7C6DBB116B1AC", ::outofboundstriggersspawned);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B30("_encstr_B1A3181363AE5638C95A9BE82BC33AC985B147D7C6DBB116B1AC", ::outofboundswatcher);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_B1A3181363AE5638C95A9BE82BC33AC985B147D7C6DBB116B1AC").nextid = 0;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297C("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", 1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B31("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", ::optional_params);

  if(!istrue(level.br_plunder_enabled)) {
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::thermite_linktostuck();
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::thermite_watchglstuck();
    level._effect["_encstr_A77412B358622F2289451AD6264959CB68A84F67"] = loadfx("_encstr_AC5632E3B071B5DF9B7337026EA8DF6EF3300B3AE02B0D6B51BB2F3A06CE8FF73D49A323D0D1150F2EAD0A3F1F1667FE9D104ACB");
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1278E();
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::thermite_watchstucktoterrain();
  }

  if(!_encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::updateplayerspawninputtype())
    scripts\engine\scriptable::scriptable_addusedcallback(_encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::plundersiteused);

  var_1 = getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E";
  level.outro_enemy_spawning = scripts\engine\utility::ter_op(var_1, "_encstr_9B62228A0D88354FCD16135BB9A6FBE168A114024388BBC776C8BB42C67FD323E871BD8A", "_encstr_82051D5B3350BFC763E1A74DB1A2053F7DC13BAAB36A2C2F47F3A078F7A0EA");
  level.outro_dialogue_logic = scripts\engine\utility::ter_op(var_1, "_encstr_B2A9286ECDD19F17A967636588FF3499F043DCDB027733D643D1F3F908E9E0138A91E1A2203B757808F3", "_encstr_818723B35AA5BA58BB91FB9BEF187BF66163B34A307F23A14FABEB37796D1777077039495A");
  level._id_127C7.data["_encstr_B4AB16DF8A20F26AC6994BF781FB4359081715A320F8AD93"]._id_1287B = level._id_127C7.data["_encstr_B4AB16DF8A20F26AC6994BF781FB4359081715A320F8AD93"]._id_14068;
  level._id_127C7.data["_encstr_B4AB16DF8A20F26AC6994BF781FB4359081715A320F8AD93"]._id_14068 = ::originalloc;
  level._id_127C7.data["_encstr_B4F91169D8BC587FE20B7123436A3F1844BE77"]._id_1287B = level._id_127C7.data["_encstr_B4F91169D8BC587FE20B7123436A3F1844BE77"]._id_14068;
  level._id_127C7.data["_encstr_B4F91169D8BC587FE20B7123436A3F1844BE77"]._id_14068 = ::originalloc;
  level.overrideviewkickscalek98 = getdvarint("_encstr_B1B7216E0EF36F81BABF90707BD2B94F3BB9E9FF20D9FFA99113D8E8EF0A7189B25B5E", 30000);
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8285175B4BB9DC96DB37BE2B3CA3E4B036E8D7161B8D56381D"] = "_encstr_8E761160A2A1B3721BE1B938C163FB13538AC8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81C6180D78C823DAF09D47A7D9253369E063091213B0FBD2D6BF"] = "_encstr_B29F1631AAE36DC0162BA9875D7C80BE7FC34BB9F2272610";
}

usb_keys() {
  return _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::upload_station_players_manager("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", 1);
}

originalloc(var_0, var_1, var_2) {
  var_1.warningbits = var_0.index;
  var_1 notify("_encstr_A2F40CB9FFAADB511D6268E3CCD4");

  if(var_2 > 0 && istrue(level.br_plunder_enabled) && (getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E"))
    [[level._id_127C7.data["_encstr_B4AB16DF8A20F26AC6994BF781FB4359081715A320F8AD93"]._id_1287B]](var_0, var_1, var_2);
}

overridefieldupgrade1() {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::releaseteamonquest(self.team);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivehidefromteam(self.team);
  overwatch_tank_backup(0, undefined);

  if(isDefined(self.get_track_controller_struct))
    self.get_track_controller_struct _id_13F71();

  self._id_1393B thread ow_current_scrambler_count();
}

outputfunc() {
  foreach(var_1 in self.subscribedinstances)
  var_1 thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdropedtime();
  self.soldier_agent_lwfn8 thread _id_12C02();
}

overtimebuiltintomatchtimer() {
  var_0 = rocket_missile(self);
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::play_train_speaker_vo("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", var_0);

  if(!isDefined(var_1))
    return 0;

  self._id_12C4A = var_1;
  return 1;
}

outofboundstimebr(var_0) {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_B1A3181363AE5638C95A9BE82BC33AC985B147D7C6DBB116B1AC").nextid++;
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::createlocaleinstance("_encstr_B1A3181363AE5638C95A9BE82BC33AC985B147D7C6DBB116B1AC", "_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", "_encstr_8FF20EC00983100336E4834F3AAA9D78" + _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_B1A3181363AE5638C95A9BE82BC33AC985B147D7C6DBB116B1AC").nextid);

  if(!isDefined(var_0)) {
    var_1.curorigin = (0, 0, 0);
    var_1.enabled = 0;
    return var_1;
  }

  var_2 = "_encstr_B43F0E4671B87173BD8FD73315553AA4";

  if(scripts\cp_mp\utility\game_utility::getmapname() == "_encstr_AFFF0BE590A158DFF3D1238507" || scripts\cp_mp\utility\game_utility::turretlightsonstate())
    var_2 = "_encstr_8B1613E94F28D44B25F5F38BFB0D73CB91236778C9";

  var_1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B");
  var_1.soldier_agent_lwfn1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1.soldier_agent_lwfn1 setModel(level.outro_dialogue_logic);
  var_3 = var_1.playerlist[0];
  var_1.soldier_agent_lwfn1 setotherent(var_3);
  var_1.soldier_agent_lwfn1 setscriptablepartstate(level.outro_enemy_spawning, var_2);
  var_1.soldier_agent_lwfn1.playermaxheath = 1;
  var_1.soldier_agent_lwfn8 = var_1.soldier_agent_lwfn1 getlinkedscriptableinstance();
  var_1.soldier_agent_lwfn8.audio_shf_kill_hangar_lights = "_encstr_930B07BB1B6B3854FF";
  var_1.soldier_agent_lwfn8.audio_jugg_spawn = "_encstr_B43F0E4671B87173BD8FD73315553AA4";
  var_1.soldier_agent_lwfn8.load_relics_from_playlistdvars = "_encstr_95DF070DD22319CA9B";
  var_1.soldier_agent_lwfn8.little_bird_onexitheavydamagestate = "_encstr_95DF070DD22319CA9B";
  var_1.soldier_agent_lwfn8._id_1296D = 0;
  var_1.soldier_agent_lwfn8.playerplunderbankdepositcallback = 1;
  var_1._id_11985 = var_0;
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tape_machine_animations("_encstr_85952BDB33375AE07E886BD7D891B8022BD8A3D9ABF7B23686A87B6358C9635BEBE0ED41B71D5A4529C83763C8", "_encstr_AF5A081BBAC993AC73A3", var_0.origin);
  var_1.lastcircletick = -1;
  var_1.curorigin = var_0.origin;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::addquestinstance("_encstr_B1A3181363AE5638C95A9BE82BC33AC985B147D7C6DBB116B1AC", var_1);
  return var_1;
}

outofboundstriggersplanetrace(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  var_2 = rocket_missile(var_1);
  var_3 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::play_train_speaker_vo("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", var_2);
  return isDefined(var_3);
}

_id_12C02() {
  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_BE180419DAE9" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_8AE1099A0B999F2D28AF15" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_9B1F05BE4B9B52" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_866209ECEDB1197DEE0B4E")
    self setscriptablepartstate(level.outro_enemy_spawning, "_encstr_95DF070DD22319CA9B");

  if(isDefined(self.heli))
    self waittill("_encstr_9B7A0AF45D2962A7702893C3");

  self getscriptablelinkedentity() delete();
}

outline_ents(var_0) {}

outline_grenade_box(var_0, var_1) {
  if(!isDefined(self.soldier_agent_lwfn1)) {
    return;
  }
  var_2 = gettime();

  if(self.lastcircletick == var_2) {
    return;
  }
  self.lastcircletick = var_2;
  var_3 = distance2d(self.curorigin, var_0);

  if(var_3 > var_1) {
    foreach(var_5 in self.subscribedinstances) {
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(var_5.team, "_encstr_85092AB3DD98125C8089028A20708C196D21137B633E3B37D8937FD27B21A332BEAFFBBFB7D4D2C918FBB25F");
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_875718B6D2DC6E96EDCD7DBD26A6FA6CD2278DD8B2F5CCB09636", var_5.team, 1);
      var_5.result = "_encstr_A78F076CA54E1B1B56";
    }

    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
  }
}

outofboundstriggersspawned(var_0) {
  originalsubtype(var_0);
}

outofboundswatcher(var_0) {
  if(var_0.team == self.subscribedinstances[0].team)
    overridepointsneeded(var_0);
}

overwatchent() {
  objective_showtoplayersinmask(self.objectiveiconid);
  objective_removeallfrommask(self.objectiveiconid);

  foreach(var_1 in self.subscribedinstances) {
    foreach(var_3 in scripts\mp\utility\teams::getteamdata(var_1.team, "_encstr_9775086022BE1B413B8B")) {
      if(!var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag())
        objective_addclienttomask(self.objectiveiconid, var_3);
    }
  }
}

originalsubtype(var_0) {
  objective_removeclientfrommask(self.objectiveiconid, var_0);
}

overridepointsneeded(var_0) {
  objective_addclienttomask(self.objectiveiconid, var_0);
}

ow_current_scrambler_count() {
  self endon("_encstr_A2BD0839CAB6B7CE5919");
  waittillframeend;
  overwatchent();
}

overwatch_tank_backup(var_0, var_1) {
  var_2 = 0;
  var_3 = -1;

  if(var_0) {
    var_2 = var_1 getentitynumber();
    var_3 = self.overwatch_soldiers_05_bombers;
  }

  foreach(var_5 in scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B")) {
    var_5 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivesetparameter(var_2);
    var_5 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13EFD(var_3);
    var_6 = isDefined(var_1) && var_5 == var_1;
    var_7 = var_0 && var_6;
    var_5 setclientomnvar("_encstr_BEDE16A3D8587362F9D9716B9F2B289376715A3B66AE371F", var_7);
  }
}

takequestitem(var_0) {
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::register_vehicle_spawners(self.team);

  if(isDefined(var_1) && var_1.size > 0) {
    foreach(var_3 in var_1)
    var_3.tracknonoobplayerlocation _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
  }

  var_5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::createquestinstance("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", self.team, var_0.index, var_0);
  var_5.team = self.team;
  var_5.tablet = var_0;
  var_5.overwatch_soldiers_05_bombers = var_0.overwatch_soldiers_05_bombers;
  var_5 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerteamonquest(self.team, self);
  var_6 = getdvarint("_encstr_925422E7EF1ED14288FE961D53D898FB7B1D633761454B3958A3C1A24BE0C3D35D8B8F8F", 240);
  var_5 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297D(var_6, 4);
  var_7 = rocket_missile(var_0);
  var_8 = var_5 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::requestquestlocale("_encstr_B1A3181363AE5638C95A9BE82BC33AC985B147D7C6DBB116B1AC", var_7, 1);

  if(!var_8.enabled) {
    var_5.result = "_encstr_A6270A37B7BED87B8D2C36AC";
    var_5 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::releaseteamonquest(self.team);
    return;
  }

  var_8 overwatchent();
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshowtoteam("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", self.team);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::addquestinstance("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", var_5);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13879("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", self, self.team);

  if(!level.br_plunder_enabled) {
    foreach(var_10 in scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B"))
    var_10.plundercount = 0;
  }

  var_12 = spawnStruct();
  var_12.excludedplayers = [];
  var_12.excludedplayers[0] = self;
  var_12._id_127D5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardmodifier("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.team));
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_872726A3CD88024CB0B9129AD0809C297D31636B53CE2B07C8834F226B31C3D3C7BDEB671165A2FD", var_12);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(self, "_encstr_8A152F0A5E8EEB45B3784B6370ED3B67A1C384927FD17B4163C0020B80B7320399AE0C070D397BD56320A952403DAF1F13", var_12);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lookforvehicles(var_5.team, self, 6, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793"));
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_8285175B4BB9DC96DB37BE2B3CA3E4B036E8D7161B8D56381D", var_5.team, 1);
  _id_1328B(var_8, var_0.overwatch_soldiers_05_bombers);
  var_5.get_track_controller_struct = self;

  foreach(var_10 in level.players) {
    if(var_10 != self)
      var_8.soldier_agent_lwfn8 disablescriptablepartplayeruse(level.outro_enemy_spawning, var_10);
  }

  var_5 overwatch_tank_backup(1, self);
  var_5 thread _id_14507(self);
  var_5 thread _id_144B6(self);
}

_id_1328B(var_0, var_1) {
  self.overheatreductiontime = 1;
  self.override_minimap_hide = var_0.soldier_agent_lwfn8.index;
  self.override_supply_drop_vfx = "_encstr_845B1F61B25C48807B3F8D898F3257E8E10D2B19D8AC784F22FBFFB1F7AA91E894";
  self.overridefieldupgrade2 = var_1;
}

_id_13F71() {
  self.overheatreductiontime = undefined;
  self.override_minimap_hide = undefined;
  self.override_supply_drop_vfx = undefined;
  self.overridefieldupgrade2 = undefined;
}

order_path_data(var_0) {
  if(self hasweapon(var_0.weapon)) {
    var_1 = getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
    var_2 = scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_0.weapon);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0.weapon);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);

    if(var_2)
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_1);
  }
}

operatorsfxalias(var_0) {
  if(!isDefined(self.overridecountdownmusic))
    return 0;

  return self.overridecountdownmusic == var_0;
}

_id_14508(var_0) {
  self endon("_encstr_A2BD0839CAB6B7CE5919");

  for(;;) {
    var_0 waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");

    if(isDefined(var_0) && !var_0 hasweapon(self.weapon)) {
      var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
      var_2 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, var_0.origin, var_0.angles, var_0);
      var_3 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_845B1F61B25C48807B3F8D898F3257E8E10D2B19D8AC784F22FBFFB1F7AA91E894", var_2);
      var_3._id_12C4A = self._id_1393B._id_11985;
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_839A23C49CFAC4C65DCA0727D2E6E87D951E1DC9C26C1DEB8BAECAE6E8F599C29636572759", var_0.team, 1, 1);
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(var_0.team, "_encstr_839A23C49CFAC4C65DCA0727D2E6E87D951E1DC9C26C1DEB8BAECAE6E8F599C29636572759");
      var_0 _id_13F71();
      self.result = "_encstr_BD79059C51C351";
      thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
      return;
    }
  }
}

_id_14507(var_0) {
  self endon("_encstr_A2BD0839CAB6B7CE5919");
  var_1 = var_0.team;

  for(;;) {
    var_0 waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_839A23C49CFAC4C65DCA0727D2E6E87D951E1DC9C26C1DEB8BAECAE6E8F599C29636572759", var_1, 1, 1);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(var_1, "_encstr_839A23C49CFAC4C65DCA0727D2E6E87D951E1DC9C26C1DEB8BAECAE6E8F599C29636572759");

    if(isDefined(var_0))
      var_0 _id_13F71();

    self.result = "_encstr_BD79059C51C351";
    thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
    return;
  }
}

_id_144B6(var_0) {
  self endon("_encstr_A2BD0839CAB6B7CE5919");

  for(;;) {
    var_0 waittill("_encstr_A2F40CB9FFAADB511D6268E3CCD4");

    if(var_0.warningbits == self._id_1393B.soldier_agent_lwfn8.index) {
      var_1 = "_encstr_A7B812EA407547CA4833868447A895AB9059F2A1" + self.overwatch_soldiers_05_bombers;
      var_2 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::riotshield_init_cp(self.overwatch_soldiers_05_bombers);

      foreach(var_4 in scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B")) {
        var_4 scripts\cp\vehicles\vehicle_compass_cp::_id_120A4(var_1);

        if(var_2 > 0)
          var_4 thread scripts\mp\hud_message::showsplash("_encstr_BE3F1CF542F9801093EA79601273D9C801BF736BE85D73F087339029DB73", var_2);
      }

      self._id_1393B.soldier_agent_lwfn8._id_1296D = 1;
      logtrophysuccesful(var_0);
      var_6 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793");
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lookforvehicles(self.team, var_0, 8, var_6);
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_81C6180D78C823DAF09D47A7D9253369E063091213B0FBD2D6BF", self.team, 1, 1);
      self._id_12D2E = self._id_1393B.soldier_agent_lwfn1.origin;
      self._id_12D2B = self._id_1393B.soldier_agent_lwfn1.angles;
      self.result = "_encstr_88E30897BDF1B71F7823";
      thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
      return;
    }
  }
}

logtrophysuccesful(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self.team;
  var_2 = spawnStruct();
  var_3 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(var_0.team);
  var_4 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793");
  var_5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtovalue(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtotype("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793"));
  var_6 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::riotshield_init_cp(self.overwatch_soldiers_05_bombers);
  var_2._id_121B5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_121B9(var_4, var_3, var_5, var_6);
  waitframe();
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(var_1, "_encstr_97AA24BB3298FDD9BDE7A07B82DB11A972428BD64FF2750663D392EA70B1C89D0951E92FB970", var_2);
}

rocket_missile(var_0) {
  var_1 = spawnStruct();
  var_1._id_12FA3 = "_encstr_8B7F149D563A4A9B581BD12D3B560959B15A83588CB9";
  var_1._id_12F9F = (var_0.origin[0], var_0.origin[1], 0);
  var_1._id_12FA6 = level.overrideviewkickscalek98;
  var_1._id_12FA7 = 0;
  var_1._id_12FA4 = getdvarint("_encstr_92F326CD8DE4EB8993FA8936AB2B1C39B473A3AC8747272C36D1F52D322B2C8D53C2874A0BDCD9B2", 20000);
  var_1._id_12FA5 = getdvarint("_encstr_921726A397D391C29E8F22BA4305C3C33853738A7309EB6FFAE3379019878FF1584AC84FB678AA57", 15000);
  var_1._id_12FA1 = 1;

  if(getdvarint("_encstr_888E17E6D8E47D13937D85C63A7DDADB91B27D3113B1D2A34F", 0)) {
    var_1._id_12FA1 = 0;
    var_1._id_12FA6 = 200000;
    var_1._id_13D09 = _encstr_96292CAF888B0430F313B7ADBBE6A98203C79BE8A065087EB2CE1F3145C08EA2D74BCD198818A58A035B351780C8::clear_and_give_killstreak_loadout_support();
    var_1.mintime = _encstr_96292CAF888B0430F313B7ADBBE6A98203C79BE8A065087EB2CE1F3145C08EA2D74BCD198818A58A035B351780C8::clear_and_give_killstreak_loadout_recon();
  }

  var_1._id_12C4A = var_0._id_12C4A;
  return var_1;
}

optional_params() {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_B24329B2DB3813850863C0CA13B8CB9F5DF24B3B018E83B1F07BCDB33109138FF1C9A35169DBCB74C0B3C4");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_9B9511AD2D379B4BBDE6BE9D95B9FACC2CB48D", self.team, 1);
}