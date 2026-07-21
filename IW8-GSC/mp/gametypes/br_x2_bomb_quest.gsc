/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_x2_bomb_quest.gsc
***********************************************/

init() {
  var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcategory("_encstr_A93908FBBAC970BACA02", 0);

  if(!var_0) {
    return;
  }
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A93908FBBAC970BACA02")._id_11C4C = getdvarint("_encstr_8E891FCBE01D217BA34898EA608907F5656952E2F8B76497D8D581BD05D507BA83", 240);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerremovequestinstance("_encstr_A93908FBBAC970BACA02", ::_id_1464F);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2E("_encstr_A93908FBBAC970BACA02", ::_id_1464D);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B30("_encstr_A93908FBBAC970BACA02", ::_id_14650);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestthink("_encstr_A93908FBBAC970BACA02", ::_id_14652, 0.05);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297C("_encstr_A93908FBBAC970BACA02", 0);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B31("_encstr_A93908FBBAC970BACA02", ::_id_1464C);
  level.disable_super_in_turret._id_14653 = 0;
  init_post_bsp_entities();
  level._id_1464E = "_encstr_999B050670F0FA";
  level._id_14651 = 0;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B38("_encstr_8D600AE8F5694A3F2C68BA72");

  if(!isDefined(level.disable_super_in_turret._id_12391))
    level.disable_super_in_turret._id_12391 = [];
}

init_post_bsp_entities() {
  var_0 = [];
  var_0[0] = [];
  var_0[1] = [];
  var_0[2] = [];
  var_0[3] = [];
  var_0[4] = [];
  var_0[5] = [];
  var_0[6] = [];
  var_0[7] = [];

  if(level.mapname == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE") {
    var_0[0][var_0[0].size] = (-483, -2260, 30);
    var_0[0][var_0[0].size] = (-483, -2310, 30);
    var_0[0][var_0[0].size] = (-483, -2360, 30);
    var_0[0][var_0[0].size] = (-483, -2410, 30);
    var_0[0][var_0[0].size] = (-483, -2460, 30);
    var_0[0][var_0[0].size] = (-483, -2510, 30);
  } else {
    var_0[0][var_0[0].size] = (4853.5, -1000.75, -108.75);
    var_0[0][var_0[0].size] = (4853.25, -1009.75, -124);
    var_0[0][var_0[0].size] = (4858.25, -951.25, -126);
    var_0[0][var_0[0].size] = (4857.75, -952.75, -105.75);
    var_0[0][var_0[0].size] = (4855.75, -978.25, -121.75);
    var_0[0][var_0[0].size] = (4860, -928.75, -111.5);
    var_0[0][var_0[0].size] = (4861.75, -910, -121.75);
    var_0[0][var_0[0].size] = (4858.75, -927.25, -82.25);
    var_0[0][var_0[0].size] = (4856.5, -939.25, -66.25);
    var_0[0][var_0[0].size] = (4855.25, -976.75, -84.5);
    var_0[0][var_0[0].size] = (4852.25, -987.25, -66.25);
    var_0[0][var_0[0].size] = (4852, -999.25, -82.25);
    var_0[1][var_0[1].size] = (-31358, 3518, -284);
    var_0[1][var_0[1].size] = (-31253, 3510, -284);
    var_0[1][var_0[1].size] = (-31368, 3415, -284);
    var_0[1][var_0[1].size] = (-31263, 3408, -284);
    var_0[1][var_0[1].size] = (-31375, 3314, -284);
    var_0[1][var_0[1].size] = (-31271, 3306, -284);
    var_0[1][var_0[1].size] = (-31381, 3227, -284);
    var_0[1][var_0[1].size] = (-31271, 3215, -284);
    var_0[1][var_0[1].size] = (-31390, 3115, -284);
    var_0[1][var_0[1].size] = (-31283, 3104, -284);
    var_0[1][var_0[1].size] = (-31394, 3029, -284);
    var_0[1][var_0[1].size] = (-31288, 3022, -284);
  }

  foreach(var_6, var_2 in var_0) {
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A93908FBBAC970BACA02").launcher_second_techo[var_6] = [];

    foreach(var_5, var_4 in var_2)
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A93908FBBAC970BACA02").launcher_second_techo[var_6][var_5] = init_reach_icbm_launch(getdvarvector("_encstr_AF791360475AC0E2C36750A2B8686722CAE963610C" + var_6 + "_encstr_BA4C02DF" + var_5, var_4));
  }
}

_id_14650(var_0) {
  if(!gethillspawnshutofforigin(var_0)) {
    return;
  }
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshow("_encstr_A93908FBBAC970BACA02");
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336C(var_0);
}

_id_1464C() {
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_9B9511AD2D379B4BBDE6BE9D95B9FACC2CB48D", self.team, 1);
}

_id_1464F() {
  if(isDefined(self.initspawnswar)) {
    foreach(var_1 in self.playerlist) {
      if(isDefined(var_1)) {
        self.initspawnswar.gameobject hidefromplayer(var_1);
        self.initspawnswar.gameobject disableplayeruse(var_1);
      }
    }
  }

  last_time_calc_defuser();
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::releaseteamonquest(self.team);
}

_id_1464D(var_0) {
  if(var_0.team == self.team) {
    if(!_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::isteamvalid(var_0.team)) {
      self.result = "_encstr_BD79059C51C351";
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
    }
  }
}

gethillspawnshutofforigin(var_0) {
  return _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::extra_riders_func(var_0);
}

search(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::extra_riders_getin_anim_func("_encstr_A93908FBBAC970BACA02", var_0, var_1, var_4);
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;

  switch (level._id_1464E) {
    case "_encstr_B48F074AB8A8FE9AB1":
      var_6 = "_encstr_8D600AE8F5694A3F2C68BA72";
      var_7 = "_encstr_A607254A23C093FA8167E1F745A8B5C77F7BB2C38BB8E723588DF4C759E0BEB7B0F0AA3BB08C07";
      var_8 = "_encstr_950D26B35B897BC8C7A3DEB1C897FBED6BB08BF9A2A8904D1938B5A9C38319E8083A4A4EAC0C2E5A";
      break;
    case "_encstr_999B050670F0FA":
    default:
      var_6 = "_encstr_A93908FBBAC970BACA02";
      var_7 = "_encstr_B28C233193EBE1C8AFC4EDDA4C7DB8AE56371DFACDE81693E87DE8B216B6EBCD7BE85ACCE5";
      var_8 = "_encstr_BDF8265D93CE9702A7132BF19033FA6F6188C5FF3B11D7CDFFE8370962AB792F39625D7BCDF86BD7";
      break;
  }

  var_5 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tape_machine_animations(var_8, "_encstr_AF5A081BBAC993AC73A3", (0, 0, 0));
  var_5 _id_1312D();

  foreach(var_2 in var_5.playerlist) {
    if(isDefined(var_2)) {
      var_5 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336C(var_2);
      var_2._id_1296E = var_5.initspawnswar.origin;
    }
  }

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshowtoteam(var_6, self.team);
  var_5 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297D(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A93908FBBAC970BACA02")._id_11C4C, 4);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::addquestinstance("_encstr_A93908FBBAC970BACA02", var_5);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13879("_encstr_A93908FBBAC970BACA02", self, self.team);
  var_11 = spawnStruct();
  var_11._id_127D5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardmodifier("_encstr_A93908FBBAC970BACA02", _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.team));
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, var_7, var_11);
  return var_5;
}

calculatehelispawndata() {
  return _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::enemy_signal_flare("_encstr_A93908FBBAC970BACA02", ::search);
}

init_reach_icbm_launch(var_0) {
  var_1 = spawnStruct();
  var_1.origin = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_0, 0, -200) + (0, 0, 20);
  var_1.gameobject = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_1.gameobject.origin = var_0;
  var_1.gameobject.angles = (45, 0, 45);
  var_1.gameobject hide();
  var_1.gameobject thread _id_1464B();
  return var_1;
}

_id_1464B() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
    var_0 _id_14065(self);
    var_0 playlocalsound("_encstr_8B9A129827D71C5AD8D6570EFAEC5637B29CA58D");
  }
}

_id_14065(var_0) {
  var_1 = _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::entmantling("_encstr_A93908FBBAC970BACA02", self);

  if(level._id_1464E == "_encstr_B48F074AB8A8FE9AB1") {
    thread init_trap_room_spawning_module(var_0.origin);
    thread _id_126C7();
  } else {
    var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_2 setModel("_encstr_A63D1A93E21F28F38AF7B1A3A3E3D028F6BB5E898B86D8397247310B");
    var_2.angles = (0, 180, 0);
    var_2 istacmapactive();
    level.disable_super_in_turret._id_12391[level.disable_super_in_turret._id_12391.size] = var_2;
  }

  var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex);

  foreach(var_5 in var_3) {
    if(isDefined(var_5))
      var_5 notify("_encstr_AF550AC56FA5E85827DB4951");
  }

  level._id_14639 = level._id_14639 + _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex).size;
  level._id_14651++;
  var_1 _id_12A37();
}

_id_1312D() {
  self.initprematchc130 = level._id_14632;
  self.initspawnswar = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_A93908FBBAC970BACA02").launcher_second_techo[self.initprematchc130][level.disable_super_in_turret._id_14653];

  if(!isDefined(self.initspawnswar)) {
    return;
  }
  level.disable_super_in_turret._id_14653++;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_11DB0(self.initspawnswar.origin + (0, 0, 38));

  if(!istrue(self.initspawnswar.gameobject.spawn_gate_guards)) {
    self.initspawnswar.gameobject.spawn_gate_guards = 1;
    self.initspawnswar.gameobject istacmapactive();
    self.initspawnswar.gameobject scripts\mp\gameobjects::sethintobject(undefined, undefined, undefined, regroup_trigger(), undefined, "_encstr_97C20EB5FD43A179CC6AD05152651579", undefined, 200, 90, 72, 90);
    self.initspawnswar.gameobject setuseprioritymax();
  }

  foreach(var_1 in self.playerlist) {
    if(isDefined(var_1))
      self.initspawnswar.gameobject enableplayeruse(var_1);
  }

  self.initspawnswar.gameobject show();
  _id_13FC5();
}

_id_12A37() {
  foreach(var_1 in self.playerlist) {
    if(isDefined(var_1))
      var_1 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
  }

  _id_1464A();
}

_id_14652() {
  if(isDefined(self.initspawnswar) && isDefined(self.initspawnswar.gameobject))
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_11DB0(self.initspawnswar.gameobject.origin);

  if(istrue(self.playermonitorspectatorcycle) || scripts\mp\flags::gameflag("_encstr_B6510A08D359E2D89E68B374" + (self.initprematchc130 + 1) + "_encstr_A1C00A885BFB01D52BAA3070") || scripts\mp\flags::gameflag("_encstr_8D1A130FC87D1D39B0A5DCFAC8596E3A93EDBC2B91"))
    path_timeout();
}

_id_1464A() {
  var_0 = spawnStruct();
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.team);
  var_2 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_A93908FBBAC970BACA02");
  var_3 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtovalue(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtotype("_encstr_A93908FBBAC970BACA02"));
  var_0._id_121B5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_121B9(var_2, var_1, var_3);
  var_4 = undefined;

  switch (level._id_1464E) {
    case "_encstr_B48F074AB8A8FE9AB1":
      var_4 = "_encstr_8B3A1C1ECB79F85FD897CFFF85FF8267A0B357226321AB422969C3CFA995";
      break;
    case "_encstr_999B050670F0FA":
    default:
      var_4 = "_encstr_B1701AE633817857C0ADDFEF95E82B45087B1B2189A8ADABA14BBBC7";
      break;
  }

  if(getdvarint("_encstr_AD301D9B1B4EF598C9BE3CC8FA36DB37A339C26CE85A961B63D8165B912D3C", 1)) {
    var_5 = _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::enter_laser_panel_anim_sequence(self.playerlist);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::longwaitradarsweep(var_5, var_4, var_0);

    foreach(var_7 in self.playerlist) {
      if(isDefined(var_7))
        var_7 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_ACC60DC427EBC323AF855B265D6ED0");
    }
  } else
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, var_4, var_0);

  self._id_12D2E = self.playerlist[0].origin;
  self._id_12D2B = self.playerlist[0].angles;
  self.result = "_encstr_88E30897BDF1B71F7823";
  self._id_11EBA = 1;
  _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::extract_ontimerexpired(self);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
}

path_timeout() {
  _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::extract_ontimerexpired(self);
  self.result = "_encstr_BD79059C51C351";
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
}

_id_13FC5() {
  foreach(var_1 in self.playerlist) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = undefined;

    switch (level._id_1464E) {
      case "_encstr_B48F074AB8A8FE9AB1":
        var_2 = "_encstr_8D600AE8F5694A3F2C68BA72";
        break;
      case "_encstr_999B050670F0FA":
      default:
        var_2 = "_encstr_A93908FBBAC970BACA02";
        break;
    }

    var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshow(var_2);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336C(var_1);
  }
}

spawn_caches_tank(var_0) {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_downed_friendly(var_0);
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivehide();
}

last_time_calc_defuser() {
  foreach(var_1 in self.playerlist) {
    if(isDefined(var_1))
      spawn_caches_tank(var_1);
  }

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdropedtime();

  foreach(var_1 in self.playerlist) {
    if(isDefined(var_1))
      var_1 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
  }
}

regroup_trigger() {
  var_0 = undefined;

  switch (level._id_1464E) {
    case "_encstr_B48F074AB8A8FE9AB1":
      var_0 = &"_encstr_8821200EBAD98D8D760F19697FA0AB5F805315808376C11B17071191C78F9D3D280E";
      break;
    case "_encstr_999B050670F0FA":
    default:
      var_0 = &"_encstr_B24B1E2BB1CE7A789D956E55E0E9472FD5398F931928B8D7B7B6675BC82978EC";
      break;
  }

  return var_0;
}

init_trap_room_spawning_module(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1.35;

  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2 setModel("_encstr_82BA10EA6AB770590257CBB7A70A1E6825D2");
  var_2.origin = var_2.origin + (0, 0, var_1);
  var_2.angles = (0, 0, 0);
  var_2 playSound("_encstr_B4731D67EDA520C50F5A4913028B8F28FC79C733B78FC3972B71E31B2A9BBE");
  var_2 playLoopSound("_encstr_85CC1BF750D02B12F7FE0EC2D5916AEBF8A82F57298B95FAF785997D47");
  var_2 setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_AB0703DBB9");
  var_2 unmarkkeyframedmover(1);
  level.disable_super_in_turret._id_12391[level.disable_super_in_turret._id_12391.size] = var_2;
}

loop_station_closed_vo(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_8FA70A7917830EF0B09E4379");
  var_0 playSound("_encstr_88741E3B933094C7F831728A58C65BCF300FB4B13390D18B9B2B6BE283171387");
  wait 1;
  var_0 stoploopsound();
  wait 4.5;
  var_0 delete();
}

_id_126C7() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12616("_encstr_8C4F1BB4DDC1BECEACB9EB0E36F2E4AF381BAB9B192B93D7DCDAB7D695", 1.867);
}

has_headicon() {
  foreach(var_2, var_1 in level.disable_super_in_turret._id_12391) {
    if(isDefined(var_1)) {
      switch (level._id_1464E) {
        case "_encstr_B48F074AB8A8FE9AB1":
          thread loop_station_closed_vo(var_1);
          break;
        case "_encstr_999B050670F0FA":
        default:
          var_1 delete();
          break;
      }
    }
  }

  level.disable_super_in_turret._id_12391 = [];
}

_id_1362D(var_0, var_1) {
  var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_0, 100, -200);
  init_trap_room_spawning_module(var_2, var_1);
}