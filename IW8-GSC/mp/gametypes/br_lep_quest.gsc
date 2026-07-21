/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_lep_quest.gsc
***********************************************/

init() {
  var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcategory("_encstr_A11904D82B38", 0);

  if(!var_0) {
    return;
  }
  scripts\engine\scriptable::_id_12F5B("_encstr_AD9B0589ED9197", ::drone_movement_vector_monitor);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2A("_encstr_A11904D82B38", "_encstr_951B1278EA63183F2B87B8436BC9BB43663049F0");
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A11904D82B38")._id_12FA0 = getdvarint("_encstr_AA0E1C485FA2260DE369811DBA69772919A3400837415BC72A8F16131022", 1000);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A11904D82B38")._id_11C4C = getdvarint("_encstr_9B7C1B325E15019AB3F9BB8798CE5DAAAFEE3CADB0313AAD79F987D718", 300);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A11904D82B38")._id_11C4D = getdvarint("_encstr_BA841C3EBB4E709B8B716DCB8B292D3303D349BF3079E7F0153542BA3B03", 60);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A11904D82B38")._id_12C83 = getdvarint("_encstr_A5681E8FFE7E3E126E2050E86A01F09D373513BBD8721AFD45BAAAE3BA5AA763", 1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B3D("_encstr_A11904D82B38", ::dropoff_point_spawner);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerremovequestinstance("_encstr_A11904D82B38", ::dropbrc130airdropcrate);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2E("_encstr_A11904D82B38", ::drop_structs);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestlocale("_encstr_95730B18C25320E85DE3BBA90D");
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registercreatequestlocale("_encstr_95730B18C25320E85DE3BBA90D", ::doclocksound);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2B("_encstr_95730B18C25320E85DE3BBA90D", ::drop_jugg_suit_on_death);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerremovequestinstance("_encstr_95730B18C25320E85DE3BBA90D", ::dropbrammoboxes);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registercheckiflocaleisavailable("_encstr_95730B18C25320E85DE3BBA90D", ::do_secured_player_vo);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcircletick("_encstr_95730B18C25320E85DE3BBA90D", ::do_wave_spawning_while_players_return_to_safehouse);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2D("_encstr_95730B18C25320E85DE3BBA90D", ::dom_ontimerexpired);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B30("_encstr_95730B18C25320E85DE3BBA90D", ::dropbrequipment);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297C("_encstr_A11904D82B38", 1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B31("_encstr_A11904D82B38", ::drop_percent);
  var_1 = [];
  var_1[0] = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::filtercondition_isdead;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerplayerfilter("_encstr_A11904D82B38", var_1);
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A1D214DAD26EE62DB737EB378D169DEB161B36B21C8E"] = "_encstr_95AB1C5B5ACDE62D7BE6BEB52D9B6EB47B737DB9D81667FA858D8D2B38A3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2B615AD2D9BCD5AF6737D9BB1C2B3AFCD5D1BC6B237E6"] = "_encstr_82361D1BA96220030F4A4E300247C638BD36F7DF4B4EB0401793C1F92AAFFE";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8AB610B5E8282733B50FF0B356334B5AC241"] = "_encstr_A5310FF2B81DA373991EDCFF2E0307EA81";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_92B210AD256B090B4D153F11194568A343D0"] = "_encstr_BDD80FEA4DB5FB33E9A8ECF9EF327D7B65";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8AE913B1B2E0EB5CD556CDD1BE99B4E65AB90D95C8"] = "_encstr_A6BF12468F70D8D3A7D243D161B848580F40B9DF";
  thread download_paused_watcher();
}

download_paused_watcher() {
  level.flagonexit = [];
  var_0 = "_encstr_81331C5507EA8A3E594D888071C91B7AF194ED7F61F3F0073DBF28D283EB";
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "_encstr_B40101") {
      break;
    }

    var_2 = int(var_2);
    var_3 = spawnStruct();
    var_3.origin = (float(tablelookupbyrow(var_0, var_1, 1)), float(tablelookupbyrow(var_0, var_1, 2)), float(tablelookupbyrow(var_0, var_1, 3)));
    var_3.angles = (float(tablelookupbyrow(var_0, var_1, 4)), float(tablelookupbyrow(var_0, var_1, 5)), float(tablelookupbyrow(var_0, var_1, 6)));
    var_3._id_12DC1 = var_1 + 1;

    if(!isDefined(level.flagonexit[var_2]))
      level.flagonexit[var_2] = [];

    level.flagonexit[var_2][level.flagonexit[var_2].size] = var_3;
    var_1++;
  }

  for(var_4 = 0; var_4 < level.flagonexit.size; var_4++)
    level.flagonexit[var_4] = scripts\engine\utility::array_randomize(level.flagonexit[var_4]);
}

dropbrc130airdropcrate() {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::releaseteamonquest(self.team);
}

drop_structs(var_0) {
  if(var_0.team == self.team) {
    var_1 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B");
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestinstancedata("_encstr_95730B18C25320E85DE3BBA90D", self.team).playerlist = var_1;

    if(isDefined(self._id_1393B) && isDefined(self._id_1393B.force_spawn_all_dead_players) && var_1.size)
      self._id_1393B.force_spawn_all_dead_players setotherent(var_1[0]);

    if(!_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::isteamvalid(var_0.team)) {
      self.result = "_encstr_BD79059C51C351";
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
    }
  }
}

dom_ontimerexpired(var_0) {
  if(!do_player_rescued_anim(var_0)) {
    return;
  }
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivehide();
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_downed_friendly(var_0);
}

dropbrequipment(var_0) {
  if(!do_player_rescued_anim(var_0)) {
    return;
  }
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshow("_encstr_A11904D82B38");
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336C(var_0);
}

do_player_rescued_anim(var_0) {
  if(var_0.team == self.subscribedinstances[0].team)
    return 1;
  else
    return 0;
}

doclocksound(var_0) {
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::createlocaleinstance("_encstr_95730B18C25320E85DE3BBA90D", "_encstr_A11904D82B38", self.team);

  if(!isDefined(var_0)) {
    var_1.curorigin = (0, 0, 0);
    var_1.enabled = 0;
    return var_1;
  }

  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tape_machine_animations("_encstr_BD0524AD633E67D277D09B41C0638A3FD158150F8B41A79D4FB892AB69A7C6EB89B69CA19C29", "_encstr_AF5A081BBAC993AC73A3");
  var_1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B");
  var_1._id_12320 = 0;
  var_1.grenade_obj = self.grenade_obj;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::addquestinstance("_encstr_95730B18C25320E85DE3BBA90D", var_1);
  var_1 dropbrplatepouch(var_0);
  return var_1;
}

drop_jugg_suit_on_death(var_0) {
  self._id_12320++;
  var_1 = dropbrplatepouch(var_0);

  if(var_1) {
    self.subscribedinstances[0].intelprogress = var_0.origin;
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.subscribedinstances[0].team, "_encstr_ADE11B99F3AFF9E0DA9F5B5BCD423028C33A52C3C99BA018B6AC1377FE");
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_92B210AD256B090B4D153F11194568A343D0", self.subscribedinstances[0].team, 1);

    if(istrue(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A11904D82B38")._id_12C83))
      self.subscribedinstances[0] _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297D(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A11904D82B38")._id_11C4C, 1);
    else
      self.subscribedinstances[0] _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297B(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A11904D82B38")._id_11C4D);
  }
}

dropbrplatepouch(var_0) {
  if(!isDefined(var_0)) {
    var_1 = self.subscribedinstances[0];

    foreach(var_3 in scripts\mp\utility\teams::getteamdata(var_1.team, "_encstr_9775086022BE1B413B8B"))
    var_3 scripts\mp\utility\lower_message::_id_1316E("_encstr_A77C1BAA1837DE4F13C7031BEB98CF23E358F2F1803FD33FEB3C1D14FE", undefined, 5);

    var_1.result = "_encstr_A6270A37B7BED87B8D2C36AC";
    var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
    return 0;
  }

  getlootspawnpointcount(var_0.index);

  if(self._id_12320 == 2) {
    var_5 = level.flagonexit[self.grenade_obj.index][0];
    var_0.origin = scripts\engine\utility::drop_to_ground(var_5.origin, 0);
    var_0.angles = var_5.angles;
    level.flagonexit[self.grenade_obj.index] = scripts\engine\utility::array_remove(level.flagonexit[self.grenade_obj.index], var_5);
    level.flagonexit[self.grenade_obj.index][level.flagonexit[self.grenade_obj.index].size] = var_5;
  }

  dropfunc(var_0.origin, var_0.angles, self);
  self.curorigin = var_0.origin + (0, 0, 50);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_11DB0(self.curorigin);
  droporigin();
  return 1;
}

dropbrammoboxes() {
  doexfilallyidle();
  self.playerlist = undefined;
  self.subscribedinstances = undefined;

  if(isDefined(self.force_spawn_all_dead_players)) {
    if(self.force_spawn_all_dead_players getscriptablepartstate("_encstr_AD9B0589ED9197") == "_encstr_A61E154F98A9FEDA4D24C73AAF6192A036F04BB7808124")
      self.force_spawn_all_dead_players delete();
  }
}

do_wave_spawning_while_players_return_to_safehouse(var_0, var_1) {
  if(!isDefined(self.lastcircletick))
    self.lastcircletick = -1;

  var_2 = gettime();

  if(self.lastcircletick == var_2) {
    return;
  }
  self.lastcircletick = var_2;
  var_3 = distance2d(self.curorigin, var_0);

  if(var_3 > var_1) {
    foreach(var_5 in self.subscribedinstances)
    var_5 dontdeleteonseatenter();
  }
}

do_secured_player_vo() {
  return 0;
}

dropoff_sound_hvt_handler(var_0) {
  if(!istrue(var_0.init))
    var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::tabletinit("_encstr_A11904D82B38");

  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::createquestinstance("_encstr_A11904D82B38", self.team, var_0.index, var_0);
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerteamonquest(self.team, self);
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B15(self);
  var_1.team = self.team;
  var_1.startlocation = self.origin;
  var_1.intelprogress = self.origin;
  var_1._id_12C4A = var_0._id_12C4A;
  var_1.grenade_obj = var_0.grenade_obj;
  var_2 = drone_instant_killed_monitor(var_1.startlocation, var_1._id_12C4A[0]);
  var_3 = var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::requestquestlocale("_encstr_95730B18C25320E85DE3BBA90D", var_2, 1);

  if(!var_3.enabled) {
    scripts\mp\utility\lower_message::_id_1316E("_encstr_A77C1BAA1837DE4F13C7031BEB98CF23E358F2F1803FD33FEB3C1D14FE", undefined, 5);
    var_1.result = "_encstr_A6270A37B7BED87B8D2C36AC";
    var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::releaseteamonquest(self.team);
    var_4 = spawnStruct();
    var_4.origin = var_0.origin;
    var_4.angles = var_0.angles;
    var_4.itemsdropped = 0;

    if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52") {
      var_5 = "_encstr_8D3E238922CEE1D85FFBD980877C1637F20EF30571A25FA02CD758B037BF49732BE5FE9693";
      var_4 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::chooseandspawnitems(0, 1, "_encstr_91B50734CA58631D1A", var_5);
      var_4 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::chooseandspawnitems(0, 2, "_encstr_B483058670B0B7", var_5);
      var_4 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::chooseandspawnitems(1, 1, "_encstr_83A20883C6EA378C2B93", var_5);
    } else {
      var_4 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::chooseandspawnitems(0, 1, "_encstr_91B50734CA58631D1A");
      var_4 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::chooseandspawnitems(0, 2, "_encstr_B483058670B0B7");
      var_4 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::chooseandspawnitems(1, 1, "_encstr_83A20883C6EA378C2B93");
    }

    return;
  }

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshowtoteam("_encstr_A11904D82B38", self.team);
  var_1.totalscavengeditems = 0;
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297D(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A11904D82B38")._id_11C4C, 4);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::addquestinstance("_encstr_A11904D82B38", var_1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13879("_encstr_A11904D82B38", self, self.team);
  var_6 = spawnStruct();
  var_6.excludedplayers = [];
  var_6.excludedplayers[0] = self;
  var_6._id_127D5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardmodifier("_encstr_A11904D82B38", _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.team));
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_ADEA183D324701E8B9E9E1531F2F9096D27BD7C3158FF367C693", var_6);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(self, "_encstr_928521AAC32023CF181FD9C57358D3A75E7B1233AB989B066051C5CC6FD85C9B0DF15B", var_6);

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker())
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::searchfunc(self.team, "_encstr_8864196AD8F71DE7538E594728FECBA437B883C34949D6F3E8FD4C");

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lookforvehicles(var_1.team, self, 6, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_A11904D82B38"));
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_8AB610B5E8282733B50FF0B356334B5AC241", var_1.team, 1);
}

drone_instant_killed_monitor(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_12FA3 = "_encstr_B16718DF8753BD6855FA81B92D27286558FF4F493FA8F6709950";
  var_2._id_12F9F = var_0;
  var_2._id_12FA6 = 10000;
  var_2._id_12FA7 = 0;
  var_2._id_12FA4 = 4000;
  var_2._id_12FA5 = 2000;
  var_2._id_12FA1 = 0;
  var_2._id_12C4A = var_1;
  var_2.mintime = 100;
  return var_2;
}

docache4voskits(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.team);
  var_4 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_A11904D82B38");
  var_5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtovalue(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtotype("_encstr_A11904D82B38"));
  var_2._id_121B5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_121B9(var_4, var_3, var_5);

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker()) {
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_82E216229E4940459BD1C3E7571A282FF0E89888352809AF", var_2);
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_8AE913B1B2E0EB5CD556CDD1BE99B4E65AB90D95C8", self.team, 1, 1);
    level thread dooutrovo(self.team);
  }

  foreach(var_1 in self.team)
  var_1.highlighttoteam = 1;

  self._id_12D2E = var_0.origin;
  self._id_12D2B = var_0.angles;
  self.result = "_encstr_88E30897BDF1B71F7823";
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
}

dontdeleteonseatenter() {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_BA011C89E4FA1B9538D7E2BA2B373AF53696271B1B59BE660BD236AEE456");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_875718B6D2DC6E96EDCD7DBD26A6FA6CD2278DD8B2F5CCB09636", self.team, 1);
  self.result = "_encstr_BD79059C51C351";
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
}

droporigin() {
  foreach(var_1 in self.playerlist)
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivesetparameter(self._id_12320);

  var_3 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::sortvalidplayersinarray(self.playerlist);

  foreach(var_1 in var_3["_encstr_9B9406CE2CC64B23"]) {
    var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshow("_encstr_A11904D82B38");
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336C(var_1);
  }

  foreach(var_1 in var_3["_encstr_975C08DAFD6501713F9D"]) {
    var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivehide();
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_downed_friendly(var_1);
  }
}

doreturnvo(var_0) {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_downed_friendly(var_0);
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivehide();
}

doexfilallyidle() {
  foreach(var_1 in self.playerlist)
  doreturnvo(var_1);

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdropedtime();
}

drop_percent() {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_A91E1B904BDFF0B373B9DFE50F7BA9DE5CBF60D0238769419BDC56E527");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_9B9511AD2D379B4BBDE6BE9D95B9FACC2CB48D", self.team, 1);
}

dropfunc(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_4 = var_2.playerlist[0];
  var_3.angles = var_1;
  var_3 setotherent(var_4);
  var_3 setModel("_encstr_8B061EADA58DD2A32CC9CBFAC6F67BA3AF36C985A3AC7D8D95C1EB2ED5ACE6A3");
  var_3 setscriptablepartstate("_encstr_AD9B0589ED9197", "_encstr_A61E154F98A9FEDA4D24C73AAF6192A036F04BB7808124");
  var_3.questlocale = var_2;
  var_2.force_spawn_all_dead_players = var_3;

  foreach(var_6 in level.players) {
    if(var_6 != var_4 && (var_4.team == "_encstr_8BBA05185F8B99" || var_6.team != var_4.team))
      var_3 disablescriptableplayeruse(var_6);
  }
}

drone_movement_vector_monitor(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_3 _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_ADBB1538C49859E5C29B60B8A33047CAA3AF31F1D38BE8", var_0))) {
    return;
  }
  if(var_2 == "_encstr_A61E154F98A9FEDA4D24C73AAF6192A036F04BB7808124" && isDefined(var_0.entity)) {
    if(!isDefined(var_0.entity.questlocale.subscribedinstances)) {
      var_3 iprintlnbold("_encstr_BA9D2B0D3459E68E02942BC5D52DC92BCD02C201A0D8859B5640D0E42CDC0D019437E8B23601A9969B372D7B37");
      return;
    }

    var_5 = var_0.entity.questlocale.subscribedinstances[0];

    if(var_3.team != var_5.team) {
      var_3 iprintlnbold("_encstr_BA9D2B0D3459E68E02942BC5D52DC92BCD02C201A0D8859B5640D0E42CDC0D019437E8B23601A9969B372D7B37");
      return;
    }

    var_0 setscriptablepartstate("_encstr_AD9B0589ED9197", "_encstr_8DAD16CAB9020C8D736F05336F60A169D9526388A6E9F02F");
    var_6 = getdvarint("_encstr_869A222A9960AFCADE5F175F0B84E2C6A021E2B931405BA2BD71777B7BAD2A2468A85EB8", 30);
    var_0.entity scripts\engine\utility::delaycallwatchself(var_6, ::delete);
    var_5 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B15(var_3);
    var_5._id_12D30 = var_0;

    switch (var_0.entity.questlocale._id_12320) {
      case 0:
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::search_activate_battle_station("_encstr_AF010CC8DF318383A2E78516F10F", var_3.team, var_0.origin, var_0.angles, var_5._id_12D30);
        break;
      case 1:
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::search_activate_battle_station("_encstr_9A010C18B2DE65212BFF2D9EEF72", var_3.team, var_0.origin, var_0.angles, var_5._id_12D30);
        break;
      case 2:
        if(var_0.entity.questlocale._id_12320 == 2 && 1) {
          _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::search_activate_battle_station("_encstr_9A010C18B2DE65212BFF2D9EEF72", var_3.team, var_0.origin, var_0.angles, var_5._id_12D30);
          dropcount(var_0);
        }

        break;
      default:
        dropcount(var_0);
        break;
    }

    if(var_0.entity.questlocale._id_12320 == 3) {
      var_5._id_12D2E = var_0.origin;
      var_5._id_12D2B = var_0.angles;
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lookforvehicles(var_5.team, var_3, 8, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_A11904D82B38"));
      var_5 docache4voskits(var_0.entity, var_3);
    } else {
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lookforvehicles(var_5.team, var_3, 7, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_A11904D82B38"));
      var_7 = drone_instant_killed_monitor(var_0.origin, var_5._id_12C4A[var_0.entity.questlocale._id_12320 + 1]);
      var_0.entity.questlocale _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_11DAF("_encstr_95730B18C25320E85DE3BBA90D", var_7);
    }

    level notify("_encstr_82941EBD48D8D4AA27572B17C7D8633D389137C960B08412106F17CBB9F07B64" + var_0.origin);
    var_8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53")]](var_3.team, 0);

    foreach(var_10 in var_8)
    var_10 notify("_encstr_91D9276C8563B1B75D8EAD0B936D95E4835AB9D9EBBB8527E9F673CAA55A1B36A2AE56E6D1A436DBCD");
  }
}

dropcount(var_0) {
  var_1 = [_encstr_AC5329EBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6FE3500FA333A39A19809D93FDA0278B::door_parts()];

  if(!isDefined(var_1) || var_1.size <= 0) {
    return;
  }
  var_2 = spawnStruct();
  var_3 = anglesToForward((0, var_0.angles[1] - -90, 0));
  var_2.origin = var_0.origin + var_3 * 25;
  var_2.angles = (0, var_0.angles[1], 0);
  var_2.itemsdropped = 0;
  var_4 = var_2 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A42(var_1, 1, undefined);
}

dropoff_point_spawner() {
  self._id_12C4A = [];
  self.grenade_obj = relic_disable_health_regen(self.origin);
  var_0 = self.grenade_obj.origin - self.origin;

  for(var_1 = 0; var_1 < 4; var_1++) {
    if(var_1 == 2)
      continue;
    else if(var_1 < 2) {
      var_2 = 0.333333;
      var_3 = self.origin + var_0 * ((var_1 + 1) * var_2);
    } else
      var_3 = self.grenade_obj.origin + rotatevector((5500, 0, 0), (0, randomfloatrange(0, 360), 0));

    var_4 = drone_instant_killed_monitor(var_3);
    var_5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::play_train_speaker_vo("_encstr_A11904D82B38", var_4);

    if(!isDefined(var_5))
      return 0;

    getlootspawnpointcount(var_5.index);
    var_3 = var_5.origin;
    self._id_12C4A[var_1] = var_5;
  }

  return 1;
}

relic_disable_health_regen(var_0) {
  var_1 = spawnStruct();
  var_1.origin = undefined;
  var_1.index = undefined;
  var_2 = undefined;

  foreach(var_7, var_4 in level.weapon_should_not_get_ammo) {
    var_5 = 0;

    if(istrue(level.group_unset_jugg_standstill))
      var_5 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updatescavengerhud(var_4);
    else
      var_5 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::ispointincurrentsafecircle(var_4);

    if(!var_5) {
      continue;
    }
    var_6 = distance2d(var_0, var_4);

    if(!isDefined(var_2) || var_6 < var_2) {
      var_1.origin = var_4;
      var_1.index = var_7;
      var_2 = var_6;
    }
  }

  return var_1;
}

dooutrovo(var_0) {
  foreach(var_2 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"])
  var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_120A4("_encstr_BAF20AB1AC1CD719B4E6EB23");
}