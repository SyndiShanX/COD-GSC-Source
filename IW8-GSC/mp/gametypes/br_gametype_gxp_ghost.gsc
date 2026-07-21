/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_gxp_ghost.gsc
**************************************************/

setchecklistsubversion() {
  wait 5.0;
  scripts\mp\utility\sound::besttime("_encstr_A29607E9D81842CBBA");
}

_id_11B16() {
  return 0;
}

_id_11B80(var_0, var_1) {
  var_2 = var_0 _id_126D1(var_1);

  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && !var_2)
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_11B15(var_0);

  return !var_2;
}

init_relic_nuketimer() {
  var_0 = [];
  var_0["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"] = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  var_0["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = "_encstr_A7ED0AD79F73990E28334B92";
  var_0["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  var_0["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_968411DCBAC12B4E7D13E4BE563C8E27851BD1";
  var_0["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = [];
  var_0["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  return var_0;
}

_id_12BBA(var_0) {
  if(!isDefined(level.teamdata[var_0]["_encstr_9AFC102CD8B49DB268DEABE6E8905DB558DC"]))
    return level.teamdata[var_0]["_encstr_8A2A0B936CCCC3078547970A8B"];
  else
    return level.teamdata[var_0]["_encstr_9AFC102CD8B49DB268DEABE6E8905DB558DC"];
}

_id_12536() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self setscriptablepartstate("_encstr_ADF80637DB2FC38C", "_encstr_BA19049F4B2D");
  self setscriptablepartstate("_encstr_8D6D0C78D7A9D74ECACB31BF4740", "_encstr_B4250C393D87BECBF505130E27C3");
  self setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_8B1608EC43B8D647A113", 0);

  if(level.disable_super_in_turret.score_accuracy_think) {
    _id_125DA();

    if(!level.disable_super_in_turret.score_event_accuracy)
      self setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_A7A408B9CA5D1D4E2C63");

    self visionsetnakedforplayer("_encstr_B40101", 0);
  }

  if(!getdvarint("_encstr_A5292B3B4E3AC1A6104162034A70D95AFF1ED975F0613F986DD07BB7B8076F50508E613F0E98100F696F3BD01B", 0)) {
    scripts\mp\class::loadout_emptycacheofloadout("_encstr_AAAC09D09972B9C83F2B7F");
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.br_respawn_loadout;
    self.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
    self.class = "_encstr_AAAC09D09972B9C83F2B7F";
  }

  waittillframeend;
  _id_1267E(0, 1);
  _id_1262B(0);
}

_id_1262B(var_0) {
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125CF(var_0);

  if(var_0) {
    if(level.disable_super_in_turret.spawndistancemax) {
      self.spawnboardroom_juggdrop.alpha = 1;
      self.spawnboardroom_loadoutdrop.alpha = 1;
      self.spawn_wheelson_redroom.alpha = 1;
    }

    self disableweaponpickup();
  } else {
    _id_12589();
    self enableweaponpickup();
  }
}

_id_12589() {
  if(isDefined(self.spawnboardroom_juggdrop))
    thread kioskfiresaledoneforplayer(self.spawnboardroom_juggdrop, 1.5);

  if(isDefined(self.spawnboardroom_loadoutdrop))
    thread kioskfiresaledoneforplayer(self.spawnboardroom_loadoutdrop, 1.5);

  if(isDefined(self.spawn_wheelson_redroom))
    self.spawn_wheelson_redroom destroy();

  self.spawnboardroom_juggdrop = undefined;
  self.spawnboardroom_loadoutdrop = undefined;
  self.spawn_wheelson_redroom = undefined;
}

kioskfiresaledoneforplayer(var_0, var_1) {
  wait(var_1);

  if(isDefined(var_0))
    var_0 destroy();
}

_id_125DA() {
  foreach(var_1 in level.players) {
    if(!var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
      var_1 hudoutlinedisableforclient(self);
  }
}

_id_12645() {
  self notify("_encstr_83DF0BE6E02CDDE6E8D0ED373A");
  self _meth_87AA("_encstr_ADF80637DB2FC38C");
  self setclothtype("_encstr_A99506D77CD5A833");
  scripts\mp\deathicons::spawn_carriables_from_prefabs_all(self);
}

_id_1269B(var_0) {
  return _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC();
}

_id_1269C(var_0) {
  return _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC();
}

_id_126D1(var_0) {
  if(!istrue(var_0)) {
    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
      thread _id_12536();
      return 0;
    }
  }

  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") || level.gameended || !level.disable_super_in_turret.scale_off_bravo_audio)
    return 0;

  thread _id_125A9(0);
  return 1;
}

_id_125A9(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");

  if(level.gameended) {
    return;
  }
  if(!isDefined(level.teamdata[self.team]["_encstr_AC1C0E49F1522824238A1BE321FFF968"]) && !isDefined(level._id_12D05)) {}

  _id_131CC(self.team);
  _id_1267C(1);
  _id_125AE(1);
  waittillframeend;

  if(isDefined(self.body))
    self.body delete();

  _id_1267E(1);
  _encstr_BEE327C399CE5FE2A0EF3F75C152EFC7F9F12BEB832D7F0DC8155747C9D0B94B932802524B50F752A8::loadout_updateglobalclassgamemode(self);
  self._id_12CA8 = 1;

  if(isDefined(level._id_12D05))
    _id_12645();
  else if(var_0)
    _id_126EE();
  else
    _id_12645();

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_87EA1C63C089D1FA5514E7DB6C0912837391DBAF80802C824F2FAB9450DD"))
    [var_2, var_3] = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_87EA1C63C089D1FA5514E7DB6C0912837391DBAF80802C824F2FAB9450DD");
  else
    [var_2, var_3] = _id_12569();

  [var_2, var_6] = _id_125A8(var_2, var_3);
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();
  wait 1;
  scripts\mp\class::loadout_emptycacheofloadout("_encstr_AAAC09D09972B9C83F2B7F");
  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.disable_super_in_turret.sat_wait_for_transmission_start;
  self.class = "_encstr_AAAC09D09972B9C83F2B7F";
  self.forcespawnangles = var_3;
  self.forcespawnorigin = var_6;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  thread scripts\mp\music_and_dialog::_id_1469B();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer(1);
  _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
  self notify("_encstr_9A83101A4D14D775F893B5791590C7EB2743");
  var_7 = getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_7);
  var_8 = getcompleteweaponname("_encstr_8BFA11A8CB6A3FC0F1501B2B6171A81F604BBF");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_8, undefined, undefined, 1);
  self detachall();
  self setModel("_encstr_9AD01576AF57F7E7F36807AF484994CBD9A3BA2BE8394F");
  self attach("_encstr_81A2186BB790036F23B1326ADE86C78108CFF3F863209C1B58CB");
  self setviewmodel("_encstr_B61415EE896B31BE26FFB908FB49F6CDF26B576211B7C3");
  scripts\mp\utility\player::_setsuit("_encstr_A1890B3A8BDA2E9AC85397CF57");
  self._id_133C8 = 1;

  if(level.disable_super_in_turret.sat_sound_think)
    scripts\cp_mp\execution::_giveexecution("_encstr_A9A127ACC3ACB1D5E8D2B7DCAF5B38FA57CDB43BAC279B0B36BEE459CCBE67584E5AB0373AD798689A");
  else
    scripts\cp_mp\execution::_clearexecution();

  self _meth_87B3();
  _id_126BD(var_2, var_3, var_6);
  self skydive_interrupt();
  self.play_disguise_vo = 5;
  self skydive_setbasejumpingstatus(0);
  self skydive_setdeploymentstatus(0);
  self skydive_beginfreefall();
  thread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_8);
  _id_1262B(1);
  thread _id_12599(var_8);
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::defend_wave_2();
  thread _id_125AF();

  if(level.disable_super_in_turret.brkickedfromplane)
    thread _id_125AB();

  thread _id_125B4();
  thread _id_12595();
  self disableexecutionvictim();
  scripts\mp\utility\perk::giveperk("_encstr_974F126E38591BB4C2B1D12FF5B8D5A556E85939");
  scripts\mp\utility\perk::giveperk("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532");
  scripts\mp\utility\perk::giveperk("_encstr_8D08176EC1956C2D16D83ABCFAA1ACB09347982759B0B5959C");
  scripts\mp\utility\perk::giveperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");
  scripts\mp\utility\perk::giveperk("_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B");
  scripts\mp\utility\perk::giveperk("_encstr_A97E1950E1284F5BE2D1630BF78B3BDF7E0AA713C1FDC285A81598");
  scripts\mp\utility\perk::giveperk("_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862");
  scripts\mp\utility\perk::giveperk("_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27");
  scripts\common\utility::allow_crate_use(0);
  scripts\common\utility::allow_vehicle_use(0);
  self lerpfovbypreset("_encstr_8B880E3B782B3B528F416928DF5B3D4D");

  if(level.disable_super_in_turret.score_event_accuracy)
    self setclientomnvar("_encstr_A97717236F39FDF8B9C78BC0ED6578A6724F9FBDF753B190C9", 0);

  thread _id_12588();
  self setscriptablepartstate("_encstr_8D6D0C78D7A9D74ECACB31BF4740", "_encstr_ADF80637DB2FC38C");

  if(getdvarint("_encstr_B8812B40AE03493AD6214F902FCEAFF2D3FF51A9E8B2C58FC09DA2B950EC837F92A763D810EFEB9D3146634DE3", 0))
    self unmarkkeyframedmover(1);

  if(isDefined(level._id_12D05))
    scripts\mp\hud_message::showsplash("_encstr_AF6415422BC8A337C0B3E1E42F9BBB0F87268A6B31BB93");
  else
    scripts\mp\hud_message::showsplash("_encstr_99261729FA3750DFA2EF697B53CA0888B8D23681E47150841A");

  if(!scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
    scripts\mp\utility\perk::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");

  self.maxhealth = level.disable_super_in_turret.sat_wait_for_activated_think;
  self.health = self.maxhealth;
  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::scriptablescurid(0);
  self allowprone(0);
  self._id_12CA8 = undefined;
  wait 3;

  foreach(var_10 in level.teamdata[self.team]["_encstr_9775086022BE1B413B8B"]) {
    if(self == var_10) {
      if(!isDefined(self.setconfig)) {
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_B1301883F1BAD3099B19E850732F317F181FB003F7F223FED2C9", var_10);
        self.setconfig = 1;
      } else
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_858012C163582F56C97D2D373ABDD7D91AB7DCD1", var_10);

      continue;
    }

    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_AC7814D0E711C0B37243E5E01CDAD9C84797B89017BC", var_10);
  }
}

_id_125B4() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");
  var_0 = 0.5;

  for(;;) {
    var_1 = self getnodeoffset_code(7);
    var_2 = sortbydistance(level.disable_super_in_turret._id_12CB0, self.origin);
    var_3 = 0;

    foreach(var_5 in var_2) {
      var_6 = undefined;

      if(var_3 < level.disable_super_in_turret._id_11B76 && level.disable_super_in_turret._id_11B75 > 0)
        var_6 = distance2dsquared(self.origin, var_5.origin);

      if(var_3 < level.disable_super_in_turret._id_11B76 && (level.disable_super_in_turret._id_11B75 == 0 || var_6 < level.disable_super_in_turret._id_11B75)) {
        var_3++;
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_5.objidnum, self);
        continue;
      }

      var_3 = level.disable_super_in_turret._id_11B76;
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_5.objidnum, self);

      if(var_1 != -1 && var_1 == var_5.objidnum)
        scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    }

    wait(var_0);
  }
}

_id_12588() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");

  if(level.disable_super_in_turret.score_accuracy_think) {
    self hudoutlinedisable();

    if(!level.disable_super_in_turret.score_event_accuracy)
      self setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_AAC10DB208B88E7FEDCF5B4AD87DB6");

    self visionsetnakedforplayer("_encstr_969C11D607FAC87BCD43EBEE3DF53B86BDB91D", 0);
    _id_1259B();
  }

  waitframe();

  if(getdvarint("_encstr_B8991AB91BE4EBC4E4D7B3C307FA8D7BB7C1BEA7B7D6315ACAF5330F", 0))
    self setscriptablepartstate("_encstr_ADF80637DB2FC38C", "_encstr_B66E08EDDCEBD8BDED0E");
  else
    self setscriptablepartstate("_encstr_ADF80637DB2FC38C", "_encstr_AB0703DBB9");
}

_id_1259B() {
  foreach(var_1 in level.players) {
    if(!var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
      scripts\mp\utility\outline::outlineenableforplayer(var_1, self, "_encstr_A5EA1B78CBECF82B423F0F7157CBEDA0AF60E0B0B629785CEA5F7B1F63", "_encstr_AC190479FF92");
  }
}

_id_12595() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.sat_wait_for_connection_think = undefined;

  for(;;) {
    if(_id_1259C()) {
      if(!isDefined(self.sat_wait_for_connection_think) || !self.sat_wait_for_connection_think) {
        self.sat_wait_for_connection_think = 1;
        _id_1258D();
      }
    } else if(!isDefined(self.sat_wait_for_connection_think) || self.sat_wait_for_connection_think) {
      self.sat_wait_for_connection_think = 0;
      _id_1258E();
    }

    waitframe();
  }
}

_id_1259C() {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent))
    return 0;

  var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  return distance2dsquared(var_0, self.origin) > var_1 * var_1;
}

_id_1258D() {
  self notify("_encstr_B839109F40E87B4BAFA5853B9DDDB13771F0");
  self unsetperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
}

_id_1258E() {
  self notify("_encstr_B8580F349C7267F327E7A8288B0FA9FB1B");

  if(level.disable_super_in_turret.saw_4_angles >= 0) {
    if(level.disable_super_in_turret.saw_4_angles == 0)
      self setperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
    else
      thread _id_125A6();
  }
}

_id_125A6() {
  if(level.disable_super_in_turret.saw_4_angles <= 0) {
    return;
  }
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");
  self endon("_encstr_B839109F40E87B4BAFA5853B9DDDB13771F0");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self setperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
    wait(level.disable_super_in_turret.saw_4_origin);
    self unsetperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
    wait(level.disable_super_in_turret.saw_4_angles);
  }
}

_id_125AB() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self._id_133E9 = 1;
  self.radarmode = "_encstr_A7C90DB83D45714FA1E16D79C58F12";
  self.hasradar = 1;
  self waittill("_encstr_82930C7FA8D8D3DB387B334FB355");
  self._id_133E9 = undefined;
  self.hasradar = 0;
}

_id_125AF() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");

  for(;;) {
    if(self issupersprinting())
      self refreshsprinttime();

    waitframe();
  }
}

_id_12599(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");
  wait 1;

  while(!self isonground()) {
    _id_125B8(var_0);
    waitframe();
  }

  self setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 0);
  self skydive_interrupt();
  playFXOnTag(level._effect["_encstr_9A660D40EFC85DD88169E6D1781F73"], self, "_encstr_8FE10B52092BB64F28E6B7BFFD");
  self playsoundtoplayer("_encstr_A7AD18C427BED9F69DEBB3A1EDB91DBE967399B4D8D7B12CDC91", self, self);
  self playSound("_encstr_AADA1CFB23E96A8F5339E19820E88316C8A5FCA05850282B1AB1C075C146", self, self);
  self freezecontrols(1);
  var_1 = gettime() + 2000;

  while(self getcurrentprimaryweapon().classname == "_encstr_8BBA05185F8B99" && gettime() < var_1) {
    _id_125B8(var_0);
    waitframe();
  }

  var_2 = propwaitminigameinit(self, 0);

  if(!isDefined(var_2))
    var_2 = (0, 0, 1);

  var_3 = anglesToForward(self.angles);
  var_4 = vectortoangles(var_2);
  var_5 = angleclamp180(var_4[0] + 90);
  var_4 = (0, var_4[1], 0);
  var_6 = anglesToForward(var_4);
  var_7 = vectordot(var_6, var_3);
  var_8 = var_7 * var_5;
  var_9 = getdvarint("_encstr_816F231693DE070E62F79280A0A70DCAE96A38AFB813D23D7F93612912646031C7BD5FF8AB", 20);
  var_10 = getdvarint("_encstr_A9A1216E1B4EAF89E4BEB3F038D73D7BD64CB4B2EB378363B0E8BE5DE0BE361B2C5B38", -70);

  if(var_8 > 0)
    var_8 = min(var_9, var_8);
  else
    var_8 = max(var_10, var_8);

  self setplayerangles((var_8, self.angles[1], 0));

  if(self getcurrentprimaryweapon().classname != "_encstr_8BBA05185F8B99")
    self forceplaygestureviewmodel("_encstr_974A0E32E9FE379790B93F1B9118DE43");

  self playFX(level.disable_super_in_turret.scn_infil_hackney_heli_npc6, self.origin);
  wait 1.5;
  self freezecontrols(0);
  self freezelookcontrols(1);
  self allowsprint(0);
  self skydive_setbasejumpingstatus(0);
  self skydive_setdeploymentstatus(0);
  wait 1;
  self freezelookcontrols(0);
  wait 1;
  _id_125B8(var_0);
  self allowsprint(1);
  thread _id_125A7();
}

_id_125A7() {
  if(!level.disable_super_in_turret.saw_head_icon) {
    return;
  }
  thread _id_126B4(level.disable_super_in_turret.sat_piece);
}

_id_126B4(var_0) {
  self notifyonplayercommand("_encstr_9AEB0C1FA97BA2532703D38AC91A", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommand("_encstr_9AEB0C1FA97BA2532703D38AC91A", "_encstr_9AC10C59D6CAB12BCAF5E97BEDD6");
  thread _id_12596();
  thread _id_12637(var_0);
  thread _id_12634(var_0);
  thread _id_12635(var_0);

  if(level.disable_super_in_turret.spawndistancemax)
    thread _id_1263A(var_0);

  thread _id_12638(var_0);
  thread _id_12630(var_0);

  foreach(var_3, var_2 in var_0.powers) {
    if(isDefined(var_0.powers[var_3]._id_1388F))
      _id_13FDD(var_0.powers[var_3]._id_1388F, 2);
  }
}

_id_13FDD(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  switch (var_0) {
    case "_encstr_81730B2B2828F8B9792783FB16":
      var_2 = 0;
      var_3 = 2;
      break;
    case "_encstr_964C0DC5B3E11B4133088F226B038E":
      var_2 = 2;
      var_3 = 7;
      break;
    case "_encstr_B6B714CD072BC63A9CC263908D0B6EA3A98EC2E857B9":
      var_2 = 9;
      var_3 = 2;
      break;
    case "_encstr_A54916D670E71991E292E8815AFE57338BAA50447A8F43A7":
      var_2 = 11;
      var_3 = 7;
      break;
    case "_encstr_A9E30FE38879C75B78B6FCD34D41B30BAF":
      var_2 = 18;
      var_3 = 2;
      break;
    case "_encstr_8AED11472BD856C17B39E8284EDB3BE4B2CD37":
      var_2 = 20;
      var_3 = 7;
      break;
    case "_encstr_ACF20B9D7D8575919257DF8095":
      var_2 = 27;
      var_3 = 2;
      break;
    case "_encstr_97180B6BB0F1F290101312A81B":
      var_2 = 29;
      var_3 = 1;
      break;
    default:
      break;
  }

  if(!isDefined(level.saw_fallback_positions))
    level.saw_fallback_positions = [];

  if(!isDefined(level.saw_fallback_positions["_encstr_9951144330E17A33A0FDBF4F35538A8F40587BCFCBE8"]))
    level.saw_fallback_positions["_encstr_9951144330E17A33A0FDBF4F35538A8F40587BCFCBE8"] = 0;

  var_4 = int(pow(2, var_3)) - 1;
  var_5 = (int(var_1) &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = self calloutmarkerping_entityzoffset("_encstr_9951144330E17A33A0FDBF4F35538A8F40587BCFCBE8");
  var_8 = var_7 &var_6;
  var_9 = var_8 + var_5;
  level.saw_fallback_positions["_encstr_9951144330E17A33A0FDBF4F35538A8F40587BCFCBE8"] = var_9;
  self setclientomnvar("_encstr_9951144330E17A33A0FDBF4F35538A8F40587BCFCBE8", level.saw_fallback_positions["_encstr_9951144330E17A33A0FDBF4F35538A8F40587BCFCBE8"]);
}

_id_12630(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_82930C7FA8D8D3DB387B334FB355", "_encstr_BE870AE7BCC8BEA5AFEB016B");
  self notifyonplayercommandremove("_encstr_9AEB0C1FA97BA2532703D38AC91A", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommandremove("_encstr_9AEB0C1FA97BA2532703D38AC91A", "_encstr_9AC10C59D6CAB12BCAF5E97BEDD6");
  thread _id_1262D(var_0);
  thread _id_12632(var_0);
  thread _id_12633(var_0);
  thread _id_12631(var_0);
}

_id_12631(var_0) {
  if(!isDefined(self._id_12821)) {
    return;
  }
  if(level.disable_super_in_turret.spawndistancemax) {
    foreach(var_2 in self._id_12821) {
      if(isDefined(var_2)) {
        if(isDefined(var_2.choppergunner_refillmissiles))
          var_2.choppergunner_refillmissiles scripts\mp\hud_util::destroyelem();

        var_2 destroy();
      }
    }
  }

  self._id_12821 = undefined;
}

_id_12632(var_0) {
  if(isbot(self)) {
    return;
  }
  foreach(var_6, var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked)
    self notifyonplayercommandremove(var_6, var_4);
  }
}

_id_12633(var_0) {
  foreach(var_3, var_2 in var_0.powers) {
    if(isDefined(var_2.has_ammo_drain_passive))
      self thread[[var_2.has_ammo_drain_passive]](var_0, var_3);
  }
}

_id_1262D(var_0) {
  if(!isDefined(var_0) || !isDefined(self._id_12821)) {
    return;
  }
  self notify("_encstr_81971074BB638F9ED9D0C01A9801D77F5B90");

  foreach(var_3, var_2 in var_0.powers) {
    if(!isDefined(self._id_12821[var_3])) {
      continue;
    }
    self._id_12821[var_3].incooldown = 0;

    if(level.disable_super_in_turret.spawndistancemax)
      self._id_12821[var_3].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(0, 0);
    else
      self._id_12821[var_3].frac = 0;

    thread _id_12639(var_0, var_3);
  }

  self.laststandattackermodifiers = undefined;
  self.vehicle_occupancy_mp_hidecashbag = undefined;
}

_id_12639(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");
  self endon("_encstr_BE870AE7BCC8BEA5AFEB016B");
  self endon("_encstr_81971074BB638F9ED9D0C01A9801D77F5B90");

  if(!isDefined(self._id_12821[var_1]) || istrue(self._id_12821[var_1].incooldown)) {
    return;
  }
  var_2 = self._id_12821[var_1];

  if(level.disable_super_in_turret._id_12820 && var_2.frac > 0) {
    self._id_12821[var_1].incooldown = 1;
    var_3 = var_0.powers[var_1].idmask;
    var_4 = "_encstr_ADE41B979F424FB28B29FC419B8F99851F2F5A477AA06A5AFB609CB317" + var_1;

    if(getdvarint(var_4, 0) != 0)
      var_3 = getdvarint(var_4, 0);

    thread _id_126DE(var_0, var_1, var_3, int(var_2.frac * 100));
    var_5 = var_2.frac;
    var_3 = var_3 * var_5;

    if(level.disable_super_in_turret.spawndistancemax) {
      var_2.choppergunner_refillmissiles.bar.color = (1, 0.6, 0);
      var_2.choppergunner_refillmissiles.bar scaleovertime(var_3, 0, var_2.choppergunner_refillmissiles.height);
    }

    wait(var_3);

    if(var_1 == "_encstr_B1EE0E9F434FE920ABCAC13D220E1B7B")
      var_6 = "_encstr_8E07138D514772B15AB9C0705373A7E93FFF1D09A0";
    else if(var_1 == "_encstr_A26A09A3F2BD63A30FCA85")
      var_6 = "_encstr_BD6616A5495F6AD932C1A8687A4CA323E7ED389DC8779319";
    else
      var_6 = "_encstr_A21310A3D85813E080B7627DC788EDCFFAB6" + var_1;

    self playlocalsound(var_6);
    self._id_12821[var_1].incooldown = 0;
  } else {
    if(level.disable_super_in_turret.spawndistancemax)
      var_2.choppergunner_refillmissiles scripts\mp\hud_util::updatebar(0, 0);
    else
      var_2.frac = 0;

    thread _id_126DE(var_0, var_1, 0, 0);
  }

  if(level.disable_super_in_turret.spawndistancemax)
    var_2.choppergunner_refillmissiles.bar.color = (1, 1, 1);

  if(isDefined(var_0.powers[var_1]._id_127FC))
    self[[var_0.powers[var_1]._id_127FC]](var_0, var_1);
}

_id_126DE(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");
  self endon("_encstr_BE870AE7BCC8BEA5AFEB016B");
  self endon("_encstr_81971074BB638F9ED9D0C01A9801D77F5B90");

  if(!isDefined(var_0.powers[var_1]._id_1388F) || !isDefined(var_0.powers[var_1]._id_128BE)) {
    return;
  }
  _id_13FDD(var_0.powers[var_1]._id_1388F, 1);
  var_4 = var_2 * 1000 * var_3 / 100;
  var_5 = gettime();
  var_6 = var_5 + var_4;

  while(gettime() < var_6) {
    var_7 = gettime();
    var_8 = (var_6 - gettime()) / var_4;
    var_9 = var_8 * var_3;
    _id_13FDD(var_0.powers[var_1]._id_128BE, int(var_9));
    waitframe();
  }

  _id_13FDD(var_0.powers[var_1]._id_128BE, 0);
  _id_13FDD(var_0.powers[var_1]._id_1388F, 2);
}

_id_12638(var_0) {
  foreach(var_3, var_2 in var_0.powers) {
    if(isDefined(var_2._id_1387B))
      self thread[[var_2._id_1387B]](var_0, var_3);
  }
}

_id_1263A(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");
  self endon("_encstr_BE870AE7BCC8BEA5AFEB016B");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isbot(self)) {
    return;
  }
  waittillframeend;
  var_1 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    var_2 = scripts\engine\utility::is_player_gamepad_enabled();

    if(var_2 != var_1) {
      var_1 = var_2;

      if(var_2) {
        foreach(var_5, var_4 in var_0.powers) {
          if(isDefined(var_4.waitforstreamsynccomplete))
            self._id_12821[var_5].label = var_4.label;
        }
      } else {
        foreach(var_5, var_4 in var_0.powers) {
          if(isDefined(var_4.waitforstreamsynccomplete))
            self._id_12821[var_5].label = var_4.waitforstreamsynccomplete;
        }
      }
    }

    waitframe();
  }
}

_id_12635(var_0) {
  foreach(var_3, var_2 in var_0.powers)
  thread _id_12636(var_0, var_3);
}

_id_12636(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");
  self endon("_encstr_BE870AE7BCC8BEA5AFEB016B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill(var_1);
    waittillframeend;

    if(isDefined(self._id_12821[var_1]) && self._id_12821[var_1].incooldown) {
      _id_12614();
      continue;
    }

    if(self isinexecutionattack()) {
      continue;
    }
    self thread[[var_0.powers[var_1].func]](var_0, var_1);
  }
}

_id_12614() {
  if(!isDefined(self.laststandattackermodifiers) || gettime() > self.laststandattackermodifiers) {
    self playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
    self.laststandattackermodifiers = gettime() + 1000;
  }
}

_id_12634(var_0) {
  var_1 = 200;
  var_2 = 18;
  var_3 = var_1;
  self._id_12821 = [];

  foreach(var_6, var_5 in var_0.powers) {
    if(isDefined(var_5.label)) {
      if(level.disable_super_in_turret.spawndistancemax)
        self._id_12821[var_6] = _id_1262F(var_5.label, var_5.waitforstreamsynccomplete, var_3, var_5._id_13060);
      else {
        self._id_12821[var_6] = spawnStruct();
        self._id_12821[var_6].frac = 0;
      }

      self._id_12821[var_6].incooldown = 0;
      var_3 = var_3 + var_2;
    }
  }
}

_id_1262F(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
  var_4.x = 15;
  var_4.y = var_2;
  var_4.alignx = "_encstr_A5AD056A019C63";
  var_4.aligny = "_encstr_AC190479FF92";
  var_4.horzalign = "_encstr_AD16101BCA66A37DB0194D579B470B261BB2";
  var_4.vertalign = "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8";
  var_4.alpha = var_3;
  var_4.glowalpha = 0;
  var_4.hidewheninmenu = 1;
  var_4.archived = 0;

  if(isDefined(var_1) && !scripts\engine\utility::is_player_gamepad_enabled())
    var_4.label = var_1;
  else if(isDefined(var_0))
    var_4.label = var_0;

  var_5 = scripts\mp\hud_util::createbar((1, 1, 1), 160, 14);
  var_5.x = 13;
  var_5.y = var_2;
  var_5.alignx = "_encstr_A5AD056A019C63";
  var_5.aligny = "_encstr_AC190479FF92";
  var_5.horzalign = "_encstr_AD16101BCA66A37DB0194D579B470B261BB2";
  var_5.vertalign = "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8";
  var_5.alpha = var_3;
  var_5 _id_132A8();
  var_5.archived = 0;
  var_5.hidewheninmenu = 1;
  var_5.bar.archived = 0;
  var_5.bar.hidewheninmenu = 1;
  var_5.bar.alpha = var_3;
  var_4.choppergunner_refillmissiles = var_5;
  return var_4;
}

_id_132A8(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "_encstr_A5AD056A019C63";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y + 2;
  self.bar.x = self.x + 2;
  scripts\mp\hud_util::updatebar(self.bar.frac);
}

_id_12637(var_0) {
  if(isbot(self)) {
    return;
  }
  foreach(var_6, var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked)
    self notifyonplayercommand(var_6, var_4);
  }
}

propwaitminigameinit(var_0, var_1) {
  if(!isDefined(var_0))
    var_2 = self;
  else
    var_2 = var_0;

  if(!isDefined(var_1))
    var_1 = 0;

  var_3 = [var_2];
  var_4 = [self.origin];

  for(var_5 = -1.0; var_5 <= 1.0; var_5 = var_5 + 2.0) {
    for(var_6 = -1.0; var_6 <= 1.0; var_6 = var_6 + 2.0) {
      var_7 = var_2 getpointinbounds(var_5, var_6, 0.0);
      var_7 = (var_7[0], var_7[1], self.origin[2]);
      var_4[var_4.size] = var_7;
    }
  }

  var_8 = (0, 0, 0);
  var_9 = 0;

  foreach(var_11 in var_4) {
    var_12 = scripts\engine\trace::_bullet_trace(var_11 + (0, 0, 4), var_11 + (0, 0, -16), 0, var_3);
    var_13 = var_12["_encstr_A53009A25003666B9818C6"] > 0.0 && var_12["_encstr_A53009A25003666B9818C6"] < 1;

    if(var_13) {
      var_8 = var_8 + var_12["_encstr_820E07FAE8780B3A4C"];
      var_9++;
    }
  }

  if(var_9 > 0) {
    var_8 = var_8 / var_9;
    return var_8;
  } else
    return undefined;
}

_id_125B8(var_0) {
  if(!self hasweapon(var_0))
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);

  if(self getcurrentprimaryweapon().classname == "_encstr_8BBA05185F8B99")
    thread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_0);
}

_id_126BD(var_0, var_1, var_2) {
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_126C3(var_2, var_1);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3.angles = var_1;
  var_3 hide();
  var_3 showtoplayer(self);
  self playerlinktoabsolute(var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self playerhide();
  thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12524(var_3);
  waitframe();
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();
  var_3.origin = var_0;
  waitframe();
  self unlink();
  self clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");
  self clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 2);
  self clearclienttriggeraudiozone(1);
  self playershow();
  var_4 = 0;

  if(isDefined(level._id_121CC))
    var_4 = level._id_121CC;

  thread scripts\cp_mp\parachute::startfreefall(var_4, 0, undefined, undefined, 1);
  self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  self setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", -1);
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12C7A();
  wait 0.5;
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();
  waitframe();
  var_3 delete();
  self notify("_encstr_978F121A20F5F1EF10A0675746FB5B863780E293");
}

_id_125A8(var_0, var_1) {
  var_2 = var_0;

  if(level.disable_super_in_turret.scn_infil_hackney_heli_npc4) {
    var_3 = getdvarint("_encstr_83EC1EFFF716D94AB0F6CF100B0182B26E293F774524F20FD0BB0C5FC0E8D0DB", 10000);
    var_4 = (0, 0, var_3);
    var_0 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::getoffsetspawnorigin(var_0, var_4);
    var_5 = spawnStruct();
    var_5.origin = var_0;
    var_5.angles = var_1;
    var_5.height = var_3;
    var_2 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_5);
  } else {
    self calloutmarkerping_getinventoryslot(0.0);
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_2);
  }

  return [var_0, var_2];
}

_id_12569() {
  var_0 = 50;
  var_1 = 10000;
  [var_3, var_4] = _id_12597();

  if(isDefined(var_3))
    return [var_3, var_4];

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent) || istrue(level.disable_super_in_turret.scn_infil_hackney_heli_npc3))
    return [self.origin, self getplayerangles()];

  var_5 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  var_6 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_7 = var_5 + var_0;
  var_8 = (self.origin[0], self.origin[1], 0);
  var_9 = vectorNormalize(var_8 - var_6);
  [var_11, var_4] = run_track_enemy_patrollers(var_6, var_9, var_7);

  if(!isDefined(var_11)) {
    var_9 = var_9 * -1;
    [var_11, var_4] = run_track_enemy_patrollers(var_6, var_9, var_7);
  }

  if(!isDefined(var_11)) {
    var_9 = (1, 0, 0);
    [var_11, var_4] = run_track_enemy_patrollers(var_6, var_9, var_7);
  }

  if(!isDefined(var_11)) {
    var_9 = (-1, 0, 0);
    [var_11, var_4] = run_track_enemy_patrollers(var_6, var_9, var_7);
  }

  if(!isDefined(var_11)) {
    var_9 = (0, 1, 0);
    [var_11, var_4] = run_track_enemy_patrollers(var_6, var_9, var_7);
  }

  if(!isDefined(var_11)) {
    var_9 = (0, -1, 0);
    [var_11, var_4] = run_track_enemy_patrollers(var_6, var_9, var_7);
  }

  if(!isDefined(var_11)) {
    var_11 = self.origin;
    var_4 = self.angles;
  }

  var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_11, var_1);
  return [var_3, var_4];
}

run_track_enemy_patrollers(var_0, var_1, var_2) {
  var_3 = var_0 + var_1 * var_2;

  if(_encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_3, 1)) {
    var_4 = vectortoangles(var_1 * -1);
    return [var_3, var_4];
  } else
    return [undefined, undefined];
}

_id_12597() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = getdvarfloat("_encstr_8BB61D5047BA2E059B611C9B82616DD103A358F88B74A13B321D84AC5A3AB9", 10000);

  if(var_2 >= 0) {
    var_3 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12568(0);

    if(isDefined(var_3)) {
      var_0 = rocket_fuel_stability(var_3.origin, var_2);
      var_0 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_0);
      var_1 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::registercarryobjectpickupcheck(var_0, var_3.origin);
    }
  }

  return [var_0, var_1];
}

rocket_fuel_stability(var_0, var_1) {
  var_2 = 3.14159;
  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_4 = vectorNormalize(var_0 - var_3);
  var_5 = vectortoangles(var_4);
  var_6 = randomfloatrange(getdvarfloat("_encstr_86151C3BA9A3BFCDD8871ECD9AFB71B7BDE9FAD1B20D0E66A007BF6389EB", 10.0), getdvarfloat("_encstr_A9151CD71B537F02CD80AA67FEB14A1FB8795B27C04987FADDA4F91DEF89", 60.0));
  var_7 = var_4;
  var_8 = var_0 + var_7 * var_1;

  if(_encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_8, 0))
    return var_8;

  var_7 = var_7 * -1;
  var_8 = var_0 + var_7 * var_1;

  if(_encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_8, 0))
    return var_8;

  var_7 = vectorNormalize(var_3 - var_0);
  var_8 = var_0 + var_7 * var_1;

  if(_encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_8, 0))
    return var_8;

  var_9 = var_1;
  var_10 = distance2d(var_0, var_3);
  var_11 = var_9 / var_10;

  if(var_11 > var_2)
    var_11 = var_2;

  var_12 = var_11 * 180 / var_2;
  var_8 = rotatepointaroundvector((0, 0, 1), var_0 - var_3, var_12) + var_3;

  if(_encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_8, 0))
    return var_8;

  var_8 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(var_0, var_1);

  if(_encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_8, 0))
    return var_8;

  return undefined;
}

_id_126EE() {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
    self waittill("_encstr_83DF0BE6E02CDDE6E8D0ED373A");
}

_id_1267C(var_0) {
  self.tut_loot = var_0;
}

_id_1267F(var_0) {
  if(istrue(var_0))
    self.game_extrainfo = self.game_extrainfo | 4096;
  else
    self.game_extrainfo = self.game_extrainfo &~4096;
}

_id_126E6(var_0) {
  foreach(var_2 in level.disable_super_in_turret._id_12CB0) {
    if(isDefined(var_2.visuals[0]))
      var_2.visuals[0] _id_12CB2(self);
  }
}

_id_12CB2(var_0) {
  if(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
    self showtoplayer(var_0);

    if(!level.disable_super_in_turret._id_13A25)
      self enableplayeruse(var_0);
  } else {
    self hidefromplayer(var_0);

    if(!level.disable_super_in_turret._id_13A25)
      self disableplayeruse(var_0);
  }
}

_id_125CE() {
  foreach(var_1 in level.disable_super_in_turret._id_12CB0)
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1.objidnum, self);
}

_id_1267E(var_0, var_1) {
  self.unset_relic_gun_game = var_0;

  if(!isDefined(level.disable_super_in_turret.saw_angles))
    level.disable_super_in_turret.saw_angles = [];

  _id_1267F(var_0);

  if(isDefined(level.disable_super_in_turret._id_11B5B))
    _id_126E6(var_0);

  if(var_0) {
    self notify("_encstr_BE870AE7BCC8BEA5AFEB016B");

    if(level.disable_super_in_turret.spawndistancemax)
      _id_125AC();

    self._id_11F39 = 0;
    self.bcdisabled = 1;
    self.plunderlimit = 1;
    _id_1267C(0);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(9);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(10);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(11);
    level.disable_super_in_turret.saw_angles[level.disable_super_in_turret.saw_angles.size] = self;
    _id_13FDD("_encstr_ACF20B9D7D8575919257DF8095", self._id_11F39);
  } else {
    self notify("_encstr_82930C7FA8D8D3DB387B334FB355");
    self._id_11F39 = undefined;
    self.bcdisabled = undefined;
    self.plunderlimit = undefined;
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);

    if(isDefined(level.disable_super_in_turret._id_11B5B))
      _id_125CE();

    level.disable_super_in_turret.saw_angles = scripts\engine\utility::array_remove(level.disable_super_in_turret.saw_angles, self);
  }

  level notify("_encstr_854F1AA7858A6B39E24779E8E7057183A26C10A4D1C231E1D63FA050");
  self notify("_encstr_A34F139633DAC9CE429FB0A8B39D8131C2DB8D150A");

  if(istrue(var_1)) {
    self lerpfovbypreset("_encstr_8B1608EC43B8D647A113");

    if(level.disable_super_in_turret.score_event_accuracy)
      thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();
  }
}

_id_125AC() {
  var_0 = -60;
  var_1 = 120;
  var_2 = 180;
  self.spawnboardroom_juggdrop = _id_12530(var_0, var_1, "_encstr_8253060E2B5FE330", "_encstr_8F8D07BB035BDAD5CD", "_encstr_A5C407E1658D3339B3", "_encstr_8F8D07BB035BDAD5CD", &"_encstr_8E2F14D889B79063F760BEBD793EC76D2D39C15059E9", 0);
  self.spawnboardroom_loadoutdrop = _id_12530(var_0, var_1, "_encstr_A5AD056A019C63", "_encstr_8F8D07BB035BDAD5CD", "_encstr_A5C407E1658D3339B3", "_encstr_8F8D07BB035BDAD5CD", &"_encstr_B491169439471AF13A07BDB35DD159489FE02C7C91C7D941", level.disable_super_in_turret.saw_3_origin);
  self.spawn_wheelson_redroom = _id_12530(0, var_2, "_encstr_A5C407E1658D3339B3", "_encstr_8F8D07BB035BDAD5CD", "_encstr_A5C407E1658D3339B3", "_encstr_8F8D07BB035BDAD5CD", &"_encstr_8CF20EF1DBC7DE21894D52D03D40CBE5");
}

_id_12530(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
  var_8.x = var_0;
  var_8.y = var_1;
  var_8.alignx = var_2;
  var_8.aligny = var_3;
  var_8.horzalign = var_4;
  var_8.vertalign = var_5;
  var_8.alpha = 0;
  var_8.glowalpha = 0;
  var_8.hidewheninmenu = 1;
  var_8.archived = 0;

  if(isDefined(var_6))
    var_8.label = var_6;

  if(isDefined(var_7))
    var_8 setvalue(var_7);

  return var_8;
}

_id_125AE(var_0) {
  var_1 = self.team;
  scripts\mp\utility\teams::_id_140C9("_encstr_ABA2055BF623CA", var_1, self);
  _id_126D8();

  if(istrue(var_0))
    [[level.updategameevents]]();
}

_id_12811() {
  level notify("_encstr_A9882140321A212607A8ED57846FEEDF46FA10B10AF34B587BB3785B66F391BDED82D0");
  level endon("_encstr_A9882140321A212607A8ED57846FEEDF46FA10B10AF34B587BB3785B66F391BDED82D0");

  if(istrue(level.br_debugsolotest) || level.gameended) {
    return;
  }
  var_0 = 1000;

  if(isDefined(level.disabled_permanently) && level.disabled_permanently + var_0 > gettime())
    wait 1;

  var_1 = 0;
  var_2 = [];
  var_3 = [];

  foreach(var_5 in level.teamnamelist) {
    var_6 = level.teamdata[var_5]["_encstr_AB580A05672AE35D5FFF50B8"];

    if(var_6 > 0) {
      if(isDefined(level.teamdata[var_5]["_encstr_9AFC102CD8B49DB268DEABE6E8905DB558DC"]) && level.teamdata[var_5]["_encstr_9AFC102CD8B49DB268DEABE6E8905DB558DC"] > 0) {
        if((level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto || level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback == 0) && var_3.size > 0) {
          return;
        }
        var_3[var_3.size] = var_5;
        var_1 = var_1 + level.teamdata[var_5]["_encstr_9AFC102CD8B49DB268DEABE6E8905DB558DC"];
        continue;
      }

      if(level.teamdata[var_5]["_encstr_8A2A0B936CCCC3078547970A8B"] > 0)
        var_2[var_2.size] = var_5;
    }
  }

  if(var_3.size > 1) {
    return;
  }
  var_8 = scripts\mp\utility\script::quicksort(var_2, ::_id_134D5);

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    var_5 = var_8[var_9];
    var_10 = var_9 + 2;
    thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1209B(var_5, var_10, 0, 1);
    var_11 = scripts\mp\utility\teams::getfriendlyplayers(var_5);

    foreach(var_13 in var_11) {
      var_13 scripts\cp_mp\utility\game_utility::_id_13168(var_10);

      if(isalive(var_13)) {
        var_13 setscriptablepartstate("_encstr_ADF80637DB2FC38C", "_encstr_BA19049F4B2D");
        var_13 playerhide();
      }
    }
  }

  var_15 = var_3[0];

  foreach(var_13 in level.players) {
    if(var_13 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
      if(var_13.team != var_15) {
        var_13 allowmovement(0);
        var_13 allowmelee(0);
      }

      if(var_13 scripts\mp\utility\perk::_hasperk("_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B"))
        var_13 scripts\mp\utility\perk::removeperk("_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B");
    }

    var_13.setcheckliststateforteam = 1;
  }

  thread scripts\mp\gamelogic::endgame(var_15, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AF36133B4BA241B065DAE6B90541588BAADF81B31B"]);
}

_id_12810() {
  level thread _id_12811();
}

_id_131CC(var_0) {
  level.teamdata[var_0]["_encstr_AC1C0E49F1522824238A1BE321FFF968"] = gettime();
}

_id_134D5(var_0, var_1) {
  var_2 = level.teamdata[var_0]["_encstr_AC1C0E49F1522824238A1BE321FFF968"];
  var_3 = level.teamdata[var_1]["_encstr_AC1C0E49F1522824238A1BE321FFF968"];
  return var_2 >= var_3;
}

_id_1365D(var_0) {
  if(istrue(var_0.br_infilstarted) && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
    var_0 _id_12645();
    return 1;
  }

  return 0;
}

addtoteamlives(var_0, var_1) {
  var_0 _id_126D8();
}

removefromteamlives(var_0, var_1) {
  var_0 _id_126D8();
}

_id_126D8() {
  var_0 = self.team;
  level.teamdata[var_0]["_encstr_9AFC102CD8B49DB268DEABE6E8905DB558DC"] = 0;

  foreach(var_2 in level.teamdata[var_0]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]) {
    if(!var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC() && !var_2 _id_125E8())
      level.teamdata[var_0]["_encstr_9AFC102CD8B49DB268DEABE6E8905DB558DC"]++;
  }
}

_id_125E8() {
  return istrue(self.tut_loot);
}

_id_13247() {
  if(!level.disable_super_in_turret.saw_head_icon) {
    return;
  }
  level.disable_super_in_turret.sat_piece = spawnStruct();
  level.disable_super_in_turret.sat_piece.powers = [];
  battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "_encstr_84DD05D205AA0B", ["_encstr_97120D65B983599519EB1D86C9B7EE", "_encstr_A2071122CC07510FDD9AD8F8D3391108DB4F94", "_encstr_B4391759C2326ED785AD4BAD98DE7D58D81B569BB94B2663B2"], ::_id_1259E, 0, undefined, ::_id_125A0, undefined, &"_encstr_A9AE14D4A07DA3C20A971A8450A41D5144AFA4AAD414", undefined, 6, "_encstr_81730B2B2828F8B9792783FB16", "_encstr_964C0DC5B3E11B4133088F226B038E");
  battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "_encstr_A5C109C06D4D73FFD327AB", ["_encstr_A52F0DF89B22FF1545787B02C3C7FF", "_encstr_8D5E11D28EDBB3EC36565823B9EB8ED09CBDBB", "_encstr_B285174ED74712A79FDCEB3BB5DFCFEF28604AA3A3C3E28115"], ::_id_125A3, 0);
  battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "_encstr_A26A09A3F2BD63A30FCA85", "_encstr_8E5F0795E6AD7BAD2B", ::_id_125B0, 0, undefined, undefined, undefined, &"_encstr_961010B1B94E9169B38A4BFFF04F07B4897B", undefined, 15, "_encstr_A9E30FE38879C75B78B6FCD34D41B30BAF", "_encstr_8AED11472BD856C17B39E8284EDB3BE4B2CD37");
  battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "_encstr_B1EE0E9F434FE920ABCAC13D220E1B7B", "_encstr_9B0D065699E485D9", ::_id_125AD, 0, undefined, undefined, undefined, &"_encstr_B86F0EAB60F9110B63EE7F6521EF4F89", undefined, 15, "_encstr_B6B714CD072BC63A9CC263908D0B6EA3A98EC2E857B9", "_encstr_A54916D670E71991E292E8815AFE57338BAA50447A8F43A7");

  if(getdvarint("_encstr_8A6C1FB9C627BE89E4EB3BC383D798EAAD0ECA93F5074BB9ECF5B9AEE0E0F6E43A", 1))
    battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "_encstr_B8010BFF97CFD95F7BC1D7FFD0", ["_encstr_888C145659E2D54B837DD1F6B39DD8597D3AA1397BDD"], ::_id_125B1, 0, undefined, ::_id_125B2);
}

battlepassxpmultipliers(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = "_encstr_82D512B9D8277D984EAF3B870EAFE07BDD56277D" + var_1;

  if(getdvarint(var_13, 1) == 0) {
    return;
  }
  if(isstring(var_2))
    var_2 = [var_2];

  var_0.powers[var_1] = spawnStruct();
  var_0.powers[var_1].clients_hacked = var_2;
  var_0.powers[var_1].func = var_3;
  var_0.powers[var_1]._id_1387B = var_5;
  var_0.powers[var_1].has_ammo_drain_passive = var_6;
  var_0.powers[var_1]._id_127FC = var_7;
  var_0.powers[var_1].label = var_8;
  var_0.powers[var_1].waitforstreamsynccomplete = var_9;
  var_0.powers[var_1].idmask = var_10;
  var_0.powers[var_1]._id_1388F = var_11;
  var_0.powers[var_1]._id_128BE = var_12;
  var_0.powers[var_1]._id_13060 = var_4;
}

_id_12596() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");

  for(;;) {
    self waittill("_encstr_9AEB0C1FA97BA2532703D38AC91A");

    if(self isgestureplaying() && !istrue(self.scn_infil_tango_npc_0_sfx)) {
      self stopgestureviewmodel("_encstr_A936120AE7C2993A9B10775FA57BA06B739DDD72", 0, 1);
      self stopgestureviewmodel("_encstr_853C0FB7C1F0371263B92F87870E7A4178");
      self stopgestureviewmodel("_encstr_851D11A793B61710A8FBD19B224C80777BB603");
    }
  }
}

_id_1259E(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");
  self endon("_encstr_A1B614F35B814398C87D988F6245EDDFAD7717556F83");
  var_2 = -1;

  if(_id_1259F()) {
    _id_12614();
    return;
  }

  var_3 = getdvarfloat("_encstr_93AA23CD6CE4EB26E4AFB30EC3F50EB7EEACC9CDFA535DAD0EF58DD02C4E9D2BBE9CB0D159", 1.0);
  var_4 = getdvarfloat("_encstr_A7E920187860C7D2B6F167195F86E8574C97FE3818E02D3DA039B5B2D0DEEDC3B2FE", 0.25);
  var_5 = getdvarint("_encstr_847825A0B74ADEF50BF1AC2B12F119ED97475028DFFAD3B353E991BFE8291148E4FBB188AF8569", var_2);
  var_6 = var_3 * level.framedurationseconds;
  self.vehicle_occupancy_monitormovementcontrols = 0.0;
  self allowmelee(0);
  self disableoffhandweapons();
  self.scn_infil_tango_npc_0_sfx = 1;

  while(self ismantling() || self isthrowinggrenade() || self ismeleeing() || scripts\mp\utility\weapon::grenadeinpullback())
    waitframe();

  thread _id_12598();
  thread _id_13982();
  var_7 = undefined;
  var_8 = 0;

  if(!isDefined(self.vehicle_occupancy_mp_hidecashbag) || gettime() > self.vehicle_occupancy_mp_hidecashbag) {
    self playlocalsound("_encstr_887A19D5B4BEE9C338FA6C8616C9CE95FAA6AE6B387D9B3A16E447");
    self.vehicle_occupancy_mp_hidecashbag = gettime() + 500;
  }

  if(isDefined(var_0.powers[var_1]._id_1388F))
    _id_13FDD(var_0.powers[var_1]._id_1388F, 0);

  while(!_id_1259F()) {
    if(level.disable_super_in_turret.spawndistancemax)
      self._id_12821[var_1].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(self.vehicle_occupancy_monitormovementcontrols, 0);
    else
      self._id_12821[var_1].frac = self.vehicle_occupancy_monitormovementcontrols;

    var_9 = self.vehicle_occupancy_monitormovementcontrols;
    self.vehicle_occupancy_monitormovementcontrols = self.vehicle_occupancy_monitormovementcontrols + var_6;

    if(self.vehicle_occupancy_monitormovementcontrols >= 1) {
      self.vehicle_occupancy_monitormovementcontrols = 1.0;

      if(var_5 >= 0) {
        if(!isDefined(var_7)) {
          var_7 = gettime() + var_5 * 1000;

          if(level.disable_super_in_turret.spawndistancemax)
            thread _id_125A2(var_1, var_5);
        }

        if(gettime() >= var_7) {
          break;
        }
      }
    }

    if(level.disable_super_in_turret.spawndistancemax && var_9 < var_4 && self.vehicle_occupancy_monitormovementcontrols >= var_4)
      self._id_12821[var_1].choppergunner_refillmissiles.bar.color = (0, 1, 0);

    if(var_9 < 1 && self.vehicle_occupancy_monitormovementcontrols >= 1)
      self playlocalsound("_encstr_872918FFFB88835898FED61CD1608F8A6015671771D00A2D20A0");

    if(isDefined(var_0.powers[var_1]._id_128BE)) {
      var_8 = max(int(self.vehicle_occupancy_monitormovementcontrols * 100), 0);
      _id_13FDD(var_0.powers[var_1]._id_128BE, var_8);
    }

    waitframe();
  }

  thread _id_125A1(var_0, var_1);
}

_id_13982() {
  var_0 = self;
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 notify("_encstr_8A37157F78F36C9385A8830A1EFB0B2D98C0F753D848D6");
  var_0 endon("_encstr_8A37157F78F36C9385A8830A1EFB0B2D98C0F753D848D6");
  var_0 lerpfovbypreset("_encstr_8E420DE9EDDA98B4AC16C936162359");
  var_0 waittill("_encstr_9A83101A4D14D775F893B5791590C7EB2743");
  var_0 lerpfovbypreset("_encstr_8B880E3B782B3B528F416928DF5B3D4D");
}

_id_1259F() {
  return self getstance() == "_encstr_922406F1A6FD5E05" || istrue(self.usingascender);
}

_id_12598() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");
  self endon("_encstr_A1B614F35B814398C87D988F6245EDDFAD7717556F83");

  if(self isgestureplaying("_encstr_AC8A18CF4173E0CA6BB02788F3C22D602AA54F99BA780795784D")) {
    return;
  }
  while(self ismantling() || self isthrowinggrenade() || self ismeleeing() || scripts\mp\utility\weapon::grenadeinpullback())
    waitframe();

  self forceplaygestureviewmodel("_encstr_AC8A18CF4173E0CA6BB02788F3C22D602AA54F99BA780795784D");

  while(self isgestureplaying("_encstr_AC8A18CF4173E0CA6BB02788F3C22D602AA54F99BA780795784D")) {
    if(self isonladder()) {
      self stopgestureviewmodel("_encstr_AC8A18CF4173E0CA6BB02788F3C22D602AA54F99BA780795784D");
      break;
    }

    waitframe();
  }
}

_id_125A2(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");
  self endon("_encstr_A1B614F35B814398C87D988F6245EDDFAD7717556F83");
  self endon("_encstr_AF6D1977B15A831750CFCCCA70331A8380570E99D2635F2D8BCDB5");

  if(var_1 <= 0) {
    return;
  }
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::can_killstreak_be_detected(var_1, int(var_1 * 5), 1);
  var_3 = 1;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_3)
      self._id_12821[var_0].choppergunner_refillmissiles.bar.color = (1, 0, 0);
    else
      self._id_12821[var_0].choppergunner_refillmissiles.bar.color = (0, 1, 0);

    wait(var_2[var_4]);
    var_3 = !var_3;
  }
}

_id_125A1(var_0, var_1) {
  self stopgestureviewmodel("_encstr_AC8A18CF4173E0CA6BB02788F3C22D602AA54F99BA780795784D");
  self notify("_encstr_AF6D1977B15A831750CFCCCA70331A8380570E99D2635F2D8BCDB5");
  self notify("_encstr_A1B614F35B814398C87D988F6245EDDFAD7717556F83");
  var_2 = getdvarfloat("_encstr_A7E920187860C7D2B6F167195F86E8574C97FE3818E02D3DA039B5B2D0DEEDC3B2FE", 0.25);
  var_3 = getdvarint("_encstr_A34D27F3AA53388012D74F8970B1D8F89F626B7BF15B65A0AAFF53A336E9103E6FFA46C33AD39D70C7", 1);

  if(self.vehicle_occupancy_monitormovementcontrols >= var_2 && !_id_1259F() && _id_125A4() && !self ismantling()) {
    self playsoundtoplayer("_encstr_BAEC16C68A8711DF9BF92858D2F2D1AEFB15D947CF63382D", self, self);
    self playSound("_encstr_B8BB15711B478448B377EFC97FDA58404B8368BB515E47", self, self);
    var_4 = getdvarfloat("_encstr_9334204B1146FF1E182FFFD84949A2776C49D333FE12EF15E0C7E6CD19A02EB71562", 1300);
    var_5 = self getplayerangles();
    thread _id_1259A();
    _id_1250A(var_5, var_4, self.vehicle_occupancy_monitormovementcontrols);
    thread _id_126D7();
    thread _id_12528();
    self.laststandattackermodifiers = undefined;
    self.vehicle_occupancy_mp_hidecashbag = undefined;
  } else if(var_3) {
    if(level.disable_super_in_turret.spawndistancemax)
      self._id_12821[var_1].choppergunner_refillmissiles.bar.frac = 0;
    else
      self._id_12821[var_1].frac = 0;

    _id_13FDD(var_0.powers[var_1]._id_128BE, 0);
    self enableoffhandweapons();
    self allowmelee(1);
    self notify("_encstr_9A83101A4D14D775F893B5791590C7EB2743");
    _id_12614();
  } else
    _id_12614();

  _id_125A0(var_0, var_1, 1);
}

_id_1250A(var_0, var_1, var_2, var_3) {
  var_4 = 1;
  var_5 = (0, 0, 20);

  if(!isDefined(var_3))
    var_3 = var_5;

  var_6 = var_0;
  var_7 = (0, 0, 1);
  var_8 = (1, 0, 0);

  if(getdvarint("_encstr_B1022812A15897E286072F4B41388BEFC8C9CA9ADE70652ADF6F7B0761DED2671B10422231602CA2B835", var_4)) {
    var_7 = propwaitminigameinit();

    if(!isDefined(var_7))
      var_7 = (0, 0, 1);

    var_9 = (0, var_6[1], 0);
    var_10 = anglestoright(var_9);
    var_8 = vectorcross(var_7, var_10);
    var_11 = vectortoangles(var_8);
    var_12 = angleclamp180(var_11[0]);
    var_13 = -85;
    var_14 = var_12;
    var_15 = var_6[0];

    if(var_15 > var_12)
      var_15 = var_12;

    var_16 = getdvarfloat("_encstr_81B82FD2BEF5E17A53D9B7D3B8AE20AA87C51A4A086D9B8DFBF1E39FF001E051076862828DA7C3C1208067C7C87EADFAE9", -45.0);
    var_17 = getdvarfloat("_encstr_ACB82F43213059FA20DE1FD3FB1E7098CFFF8A7E7022B5B88BA9ABDAABBB7B88C680287B65F735135F88E91FEB0E68D32D", 0.0);
    var_18 = (var_15 - var_13) / (var_14 - var_13);
    var_19 = var_17 + var_18 * (var_16 - var_17);
    var_6 = (var_15 + var_19, var_6[1], var_6[2]);
  }

  var_20 = getdvarfloat("_encstr_91F3217BB64B7F661D099A63586FDA07432DE2F3C0109F6DC1F1F34A606F940F79057C", 0.0);

  if(var_20 != 0.0)
    var_6 = (var_6[0] + var_20, var_6[1], var_6[2]);

  var_21 = anglesToForward(var_6);
  var_22 = var_21 * var_2 * var_1;
  var_23 = self.origin + var_3;
  self setOrigin(var_23);
  self setvelocity(var_22);
  glassradiusdamage(self.origin + (0, 0, 30), 30, 50, 51);
  var_24 = anglesToForward(self.angles);
  var_25 = self.origin + (0, 0, 30) + var_24 * 15;
  radiusdamage(var_25, 100, 1, 1);
}

_id_1259A() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_ADFC0EE94EE7D6CDB0BC0767A31223BC", 0);
  self enableoffhandweapons();
  self giveandfireoffhand("_encstr_AA871114B8A31FF3ED53A010D305C8B9B96517");
  wait 0.4;
  self notify("_encstr_9A83101A4D14D775F893B5791590C7EB2743");
  self forceplaygestureviewmodel("_encstr_A936120AE7C2993A9B10775FA57BA06B739DDD72");

  while(!_id_1259D())
    waitframe();

  self notify("_encstr_83A6143B86DEB98EFA53AB5BC1BEB17BDA838D56472B");
  self stopgestureviewmodel("_encstr_A936120AE7C2993A9B10775FA57BA06B739DDD72");
  self setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_8B1608EC43B8D647A113", 0);
  self playsoundtoplayer("_encstr_A2BC0E3DF038AF6E1C1B588EAF07B14E", self, self);
  self playSound("_encstr_AA32179B45DE37B0603A1716531D99ABA85F69C27ED0C1C27C", self, self);
  self playSound("_encstr_9BBC0E1299E8B9BF4FF092CB7EA86B6E", self, self);
  self enableoffhandweapons();
  self allowmelee(1);
  self.scn_infil_tango_npc_0_sfx = undefined;
}

_id_125A4() {
  if(level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols != 0) {
    var_0 = self.origin + (0, 0, level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols);
    var_1 = playerphysicstrace(self.origin, var_0);

    if(var_1 != var_0)
      return 0;
  }

  if(level.disable_super_in_turret.vehicle_occupancy_mp_changedseats != 0) {
    var_2 = self getEye();
    var_0 = var_2 + (0, 0, level.disable_super_in_turret.vehicle_occupancy_mp_changedseats);
    var_3 = 10;
    var_4 = 20;
    var_5 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 1);
    var_1 = scripts\engine\trace::capsule_trace(var_2, var_0, var_3, var_4, (0, 0, 0), self, var_5);

    if(var_1["_encstr_A53009A25003666B9818C6"] != 1)
      return 0;
  }

  return 1;
}

_id_126D7() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");
  var_0 = getdvarfloat("_encstr_91411723FE0337DEA5C142ABA0A756A7BB48BBA7802B5BA5B1", 400.0);

  if(var_0 <= 0.0) {
    return;
  }
  var_1 = getdvarfloat("_encstr_BD98219B6C9CBE269CEBB31EC1AF0BD2397D1BBD378E9CBD63AFAD58C3D7B91C2B59C8", 1400.0);
  var_2 = getdvarfloat("_encstr_922922F72EBA6F021A872FC3703FBF28E5CF6B19F0D179A847FB3257E5FD11C367B9E32A", 0.85);
  wait 0.2;

  while(!_id_1259D()) {
    var_3 = self getnormalizedmovement();

    if(length(var_3) > 0) {
      var_4 = rotatevector((var_3[0], -1.0 * var_3[1], 0), self.angles);
      var_5 = self getvelocity();
      var_6 = length(var_5);
      var_7 = var_4 * var_0 * level.framedurationseconds;
      var_8 = var_5 + var_7;
      var_9 = length(var_8);

      if(var_9 <= var_1) {
        if(var_8[2] < 0)
          var_8 = (var_8[0], var_8[1], var_8[2] * var_2);

        self setvelocity(var_8);
      } else if(var_6 < var_1) {
        var_8 = vectorNormalize(var_8) * var_1;

        if(var_8[2] < 0)
          var_8 = (var_8[0], var_8[1], var_8[2] * var_2);

        self setvelocity(var_8);
      }
    }

    waitframe();
  }
}

_id_12528() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_82930C7FA8D8D3DB387B334FB355");
  self endon("_encstr_83A6143B86DEB98EFA53AB5BC1BEB17BDA838D56472B");
  var_0 = getdvarfloat("_encstr_B40326E6B139EB4CC97DD9F00EBE8D1B95164EEBDAB73BD2739DF5C1C62CD166277BB5EB1D5A5B56", 0.3);

  if(var_0 < 0) {
    return;
  }
  if(var_0 > 0)
    wait(var_0);

  self _meth_87B1();
}

_id_125A0(var_0, var_1, var_2) {
  if(istrue(var_2))
    thread _id_12639(var_0, var_1);

  self.vehicle_occupancy_monitormovementcontrols = undefined;
}

_id_1259D() {
  return self isonground() || self isonladder() || self ismantling();
}

_id_125A3(var_0, var_1) {
  if(isDefined(self.vehicle_occupancy_monitormovementcontrols))
    _id_125A1(var_0, "_encstr_84DD05D205AA0B");
  else
    self notify("_encstr_A1B614F35B814398C87D988F6245EDDFAD7717556F83");
}

_id_125B0(var_0, var_1) {
  var_2 = self;
  var_3 = getdvarfloat("_encstr_9AF4239BB19CAF8993FAD98738BED9347B9BE87D47598DAC1CEDE4A3BE195A6E8E2CCDB156", 400);
  var_4 = var_2 getplayerangles();
  var_5 = anglesToForward(var_4);
  var_6 = var_2 getEye();
  var_7 = var_6 + var_5 * var_3;
  var_7 = var_2 chase_hvt_vo(var_7, var_6, var_5);

  if(!isDefined(var_2) || !isDefined(var_2._id_12821)) {
    return;
  }
  if(isDefined(var_7))
    var_2 thread _id_1262C(var_0, var_1);
  else {
    var_2 _id_12614();

    if(level.disable_super_in_turret.spawndistancemax)
      var_2._id_12821["_encstr_A26A09A3F2BD63A30FCA85"].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(0.05, 0);
    else
      var_2._id_12821["_encstr_A26A09A3F2BD63A30FCA85"].frac = 0.05;

    var_2 thread _id_12639(var_0, var_1);
  }
}

chase_hvt_vo(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3))
    var_3 = 1;

  var_6 = [self];

  if(isDefined(var_4))
    var_6[var_6.size] = var_4;

  var_7 = var_0 + var_2 * 10;
  var_8 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 1);
  var_9 = scripts\engine\trace::ray_trace(var_1, var_0, var_6, var_8);
  var_10 = var_9["_encstr_BD260953AA97E3F014279D"];

  if(var_10 == var_0)
    var_11 = var_0;
  else
    var_11 = var_10 - var_2 * 10 + var_9["_encstr_820E07FAE8780B3A4C"] * 10;

  var_12 = var_11 + (0, 0, 72);
  var_13 = scripts\engine\trace::ray_trace(var_11, var_12, var_6, var_8);
  var_14 = var_13["_encstr_BD260953AA97E3F014279D"];

  if(abs(var_14[2] - var_12[2]) > 1) {
    var_15 = var_14 - (0, 0, 72);
    var_16 = scripts\engine\trace::ray_trace(var_14, var_15, var_6, var_8);
    var_17 = var_16["_encstr_BD260953AA97E3F014279D"];

    if(abs(var_17[2] - var_15[2]) > 1)
      var_11 = undefined;
    else
      var_11 = var_17;
  }

  if(isDefined(var_11) && positionwouldtelefrag(var_11, self))
    var_11 = undefined;

  if(isDefined(var_11)) {
    var_18 = self gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28");
    var_19 = self gettagangles("_encstr_813B0D4027B390B37585BBC819FD28");
    playFX(level.disable_super_in_turret._id_13AEA, var_18, anglesToForward(var_19), anglestoup(var_19));
    self enableoffhandweapons();
    self giveandfireoffhand("_encstr_A31D10CEC31C7DA3CA8DCA1CDB9C8ED7ADE0");

    if(var_3) {
      var_20 = getdvarfloat("_encstr_A26C209A30E6465823A677E1504FCAD2CA2F0B4F70FB313D83B8453CEFE882E8CB28", 0.1);
      wait(var_20);
    }

    if(!isDefined(self))
      return undefined;

    self setOrigin(var_11);
    playFXOnTag(level.disable_super_in_turret._id_13AEA, self, "_encstr_813B0D4027B390B37585BBC819FD28");
    playfxontagforclients(level.disable_super_in_turret._id_13AE9, self, "_encstr_A130084D2FDAD8AA8F62", self);

    if(istrue(var_5)) {
      var_21 = self getvelocity();
      var_22 = length(var_21);
      var_23 = var_2 * var_22 * 0.5;
      self setvelocity(var_23);
      self playsoundtoplayer("_encstr_B1A6171393EB76B7D9D7DCC2332BB9C185B156D727593856B1", self, self);
      self playSound("_encstr_A59E1A26397D76DBECFAB9583359DC0E0B1B56EB9CB238568DFA6683", self, self);
    } else {
      self playsoundtoplayer("_encstr_97641A1A9D81A73FBC66E21A48166B11702B9C65F158AA9BF07B4A83", self, self);
      self playSound("_encstr_BA3F197236E697DDED01826A983FD3BF3B15F4ED4F889B23978AFB", self, self);
    }
  }

  return var_11;
}

sat_piece_think(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  self enableplayerbreathsystem(1);
}

_id_125AD(var_0, var_1) {
  var_2 = 64;
  var_3 = var_2 * var_2;
  var_4 = getdvarfloat("_encstr_A9871E58F25A77811B876CDB8087E9C1C51B98B17A7543FB7B9FEE5F6C8793BF", 768);
  var_5 = var_4 * var_4;
  var_6 = "_encstr_8E0B110A40FBD68B1D4BA968F2F2B36E53CC96";
  var_7 = self;
  var_7 enableplayerbreathsystem(0);
  var_7 playsoundonmovingent(var_6);
  var_7 playsoundtoplayer("_encstr_81C817CE1BA937BA7CFFA793F7A65357E86086123351E84256", var_7, var_7);
  var_7 playSound("_encstr_B43A1613E4AFECDBD97D3B0DDBE6D1D79863169B3AFA3383", var_7, var_7);
  var_7 thread sat_piece_think(2);
  playFXOnTag(level.disable_super_in_turret._id_136E3, var_7, "_encstr_813B0D4027B390B37585BBC819FD28");
  playfxontagforclients(level.disable_super_in_turret._id_136E2, var_7, "_encstr_A130084D2FDAD8AA8F62", var_7);
  self enableoffhandweapons();
  self giveandfireoffhand("_encstr_BEE80DAFF03B671A99F7924BF0B373");
  var_7 playRumbleOnEntity("_encstr_9706138CB2332CAB8D1D77CAC2E07B9BBE995A9CB2");
  var_7 earthquakeforplayer(0.1, 0.3, var_7.origin, 100);
  var_8 = getcompleteweaponname("_encstr_AB64181DDD735E712232B8F8297D2F307768118731CF233FCDAB");
  var_9 = getcompleteweaponname("_encstr_A90D1FCAAD38AF1927B7B92B7DB9DEE67D0E63C22FB239D7465A93561B3AEBD60E");
  var_10 = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(var_12 in var_10) {
    var_13 = var_12.owner;

    if(isDefined(var_13)) {
      if(var_13 != var_7 && !scripts\cp_mp\utility\player_utility::playersareenemies(var_7, var_13))
        continue;
    }

    var_14 = distancesquared(var_7.origin, var_12.origin);

    if(var_14 > var_5) {
      continue;
    }
    var_15 = scripts\engine\utility::ter_op(var_14 > var_3, var_8, var_9);
    var_12 dodamage(1, var_7.origin, var_7, var_7, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_15);
    var_12 playsoundonmovingent("_encstr_B8FF13D8EB78EECB2AEA405385D30BD1C4DFB8F0A3");
    var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_7, var_12, 1, var_15, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_7, var_7.origin);
    thread _id_12586(var_16);
  }

  var_18 = getcompleteweaponname("_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18");
  var_19 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53"))
    var_19 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53")]](var_7.origin, var_4);

  var_20 = var_7 getEye();
  var_21 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 1);

  foreach(var_23 in var_19) {
    if(var_23 == var_7) {
      continue;
    }
    if(var_23 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
      continue;
    }
    if(var_23 != var_7 && !scripts\cp_mp\utility\player_utility::playersareenemies(var_7, var_23)) {
      continue;
    }
    if(_encstr_8EF62B63396EFF42C08F5F1561F24F2719118B4BE34DDFED28B537E769301927B7E91291CA1073B7886507FB77::truckdoorleft(var_23)) {
      continue;
    }
    var_24 = scripts\engine\trace::ray_trace_passed(var_20, var_23 gettagorigin("_encstr_AADA07DBF19A4A81D7"), self, var_21);

    if(!var_24) {
      continue;
    }
    var_23 dodamage(1, var_7.origin, var_7, var_7, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_18);
    var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_7, var_23, 1, var_18, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_7, var_7.origin);
    thread _id_12586(var_16);
  }

  thread _id_1262C(var_0, var_1);
}

_id_1262C(var_0, var_1) {
  if(level.disable_super_in_turret.spawndistancemax)
    self._id_12821[var_1].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(1.0, 0);
  else
    self._id_12821[var_1].frac = 1.0;

  thread _id_12639(var_0, var_1);
}

_id_12586(var_0) {
  var_1 = getdvarfloat("_encstr_9BA724F8EF12B69D7399F4032AD9EF186737482143D489773BB1FD8102F12163C217D0188F7E", 5);
  var_2 = getdvarfloat("_encstr_910B2B17937211D62B2939C2C3C71CE04DFB91D73A5D38A6DB01B3C8FA2341C0244FC7379F87D06EB74BC85072", 5);
  var_3 = var_0.victim;

  if(isPlayer(var_3)) {
    var_3 playSound("_encstr_A9FF131598C2216567CB2E90626B2F889B2789813A");
    var_4 = scripts\engine\utility::ter_op(getdvarint("_encstr_B6D327E3C83519438B10DFC89F760F9CA7F01BB928F14ECF6378B3C03DF8EBE2F178D272595D07F3D9", 0), "_encstr_8EF615225A6F2782788D15195B71CD63AF709AFB214D83", "_encstr_87250EB7D91FD1531B5B575E500985DB");
    var_3 scripts\cp_mp\utility\shellshock_utility::_shellshock(var_4, "_encstr_9B1804C793EB", var_2, 1);
    playfxontagforclients(level.disable_super_in_turret._id_136E4, var_3, "_encstr_A130084D2FDAD8AA8F62", var_3);
  } else {
    scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
    moraleslaptopthink(var_0, var_1);

    if(isDefined(var_3))
      var_3 scripts\cp_mp\emp_debuff::remove_emp();
  }
}

moraleslaptopthink(var_0, var_1) {
  var_0.victim endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_99C40CA749E1F16B80389FEB2BB9", var_1);

  if(var_2 != "_encstr_99C40CA749E1F16B80389FEB2BB9")
    var_0.empremoved = 1;
}

_id_125B1(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_B1762303A0E9B19A3574C43D56114175902BFBF7C8E3CFB30F878F363DC52A343DF0371F50");
  self endon("_encstr_B1762303A0E9B19A3574C43D56114175902BFBF7C8E3CFB30F878F363DC52A343DF0371F50");
  var_2 = gettime() + getdvarint("_encstr_B1833160778A1E35CB316CEBD2315101CC078308AB24D6F733295EF7EFAA692B299BF1F87BC9EB89C90B5B71C782A393AF7708", 500);

  while(var_2 > gettime()) {
    if(self secondaryoffhandbuttonPressed()) {
      self notify("_encstr_A26A09A3F2BD63A30FCA85");
      break;
    } else if(self fragButtonPressed()) {
      self notify("_encstr_B1EE0E9F434FE920ABCAC13D220E1B7B");
      break;
    }

    waitframe();
  }
}

_id_125B2(var_0, var_1) {
  self notify("_encstr_B1762303A0E9B19A3574C43D56114175902BFBF7C8E3CFB30F878F363DC52A343DF0371F50");
}

nukefridgewatcher() {
  return scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56";
}

modifyplayerdamage(var_0) {
  var_1 = var_0.damage;
  var_2 = isPlayer(var_0.attacker) && var_0.attacker _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC();
  var_3 = isDefined(var_0.attacker) && var_0.attacker nukefridgewatcher();
  var_4 = isPlayer(var_0.victim) && var_0.victim _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC();
  var_5 = scripts\mp\utility\weapon::getweaponbasenamescript(var_0.objweapon);

  if(var_2 && var_4 && var_0.meansofdeath == "_encstr_8DED0A21C79B660BC7588981") {
    if(!level.disable_super_in_turret.school_guards_behavior)
      var_1 = 0;
    else
      var_1 = level.disable_super_in_turret.school_guards_behavior_internal;
  } else if(var_2 && !var_4 && !var_0.attacker isinexecutionattack() && var_0.victim isinexecutionvictim())
    var_1 = 0;
  else if(isDefined(var_0.attacker) && istrue(var_0.attacker.isjuggernaut) && var_4 && var_0.meansofdeath == "_encstr_8DED0A21C79B660BC7588981")
    var_1 = var_0.victim.maxhealth / 3;
  else if(var_4 && var_0.meansofdeath == "_encstr_87A10C9D24E997A01F21838F3D34")
    var_1 = 0;
  else if(var_4 && isDefined(var_0.inflictor) && isDefined(var_0.inflictor.streakinfo) && (var_0.inflictor.streakinfo.streakname == "_encstr_A2E60C6BC099B7E1A0A93A398F48" || var_0.inflictor.streakinfo.streakname == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895" || var_0.inflictor.streakinfo.streakname == "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4")) {
    var_6 = var_0.victim.maxhealth;
    var_7 = var_0.attacker.maxhealth;
    var_1 = var_0.damage * int(floor(var_6 / var_7));
  } else if(level.disable_super_in_turret.school_guards_rpg_shoot_into_windows && var_4 && isexplosivedamagemod(var_0.meansofdeath) && isDefined(var_0.inflictor) && var_0.inflictor scripts\cp_mp\vehicles\vehicle::isvehicle())
    var_1 = 0;
  else if(var_4 && (var_0.meansofdeath == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_0.meansofdeath == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_0.meansofdeath == "_encstr_9B0D099AD3887D91252954") && (var_5 == "_encstr_BA730BF8AFF178988293F158B9" || var_5 == "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898"))
    var_1 = var_0.damage * level.disable_super_in_turret.school_guards_rpg_guys;
  else if(var_2 && !var_4 && var_0.meansofdeath == "_encstr_8DED0A21C79B660BC7588981") {
    var_8 = var_0.victim.maxhealth;
    var_9 = level.disable_super_in_turret.saveweaponstates;

    if(istrue(var_0.victim.isjuggernaut))
      var_9 = level.disable_super_in_turret.saw_2_angles;

    if(!level.disable_super_in_turret.sat_wait_for_antenna)
      var_8 = var_8 + var_0.victim.br_maxarmorhealth;

    if(istrue(var_0.victim.inlaststand)) {
      var_8 = level.laststandhealth;
      var_9 = level.disable_super_in_turret.saw_2_origin;
    }

    var_1 = int(ceil(var_8 / var_9));
  } else if(var_4 && var_3 && istrue(var_0.victim._id_1423B))
    var_1 = 0;
  else if(var_4 && var_3 && level.disable_super_in_turret.scn_infil_tango_npc_4_sfx) {
    var_1 = 0;
    _id_1424A(var_0);
  } else if(var_2 && !var_4 && var_0.meansofdeath == "_encstr_A1ED0BA9FF84562B60BA073E83" && var_5 == "_encstr_86B108781A36271E4F70") {
    var_10 = spawnStruct();
    var_10.origin = var_0.point;
    var_0.victim thread scripts\mp\equipment\concussion_grenade::applyconcussion(var_10, var_0.attacker);
  } else if(var_4) {
    var_11 = 0.7;
    var_12 = scripts\mp\utility\weapon::getweaponrootname(var_0.objweapon);
    var_13 = weaponclass(var_5);
    var_14 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::tutzonetriggerlogic(var_0.idflags);

    if(!var_14) {
      switch (var_13) {
        case "_encstr_850707F7E5833355B8":
          if(var_0.shitloc == "_encstr_81CC0586952C91" || var_0.shitloc == "_encstr_A6CC076A05751852B3") {
            if(_encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::usefailvehiclemsg(var_12))
              var_1 = int(ceil(level.disable_super_in_turret.sat_wait_for_activated_think * var_11));
            else
              var_1 = level.disable_super_in_turret.sat_wait_for_activated_think;
          }

          break;
        default:
          if(var_0.shitloc == "_encstr_81CC0586952C91" || var_0.shitloc == "_encstr_A6CC076A05751852B3") {
            var_15 = getdvarfloat("_encstr_856E15E68D93D7E0D80BF25639FADA163CA1AC0B8DD134", 100.0);
            var_16 = var_15;

            if(level.disable_super_in_turret._id_14061)
              var_16 = var_16 + _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::_encstr_861519B969C353C3787F9DC45B2A71A97E3BE5DF730B4966A121D1();

            var_1 = int(ceil(var_1 / var_16 * level.disable_super_in_turret.sat_wait_for_activated_think * level.disable_super_in_turret.sat_wait_for_access_card));
          }

          break;
      }
    }

    var_17 = "_encstr_8DAE1237B127EB4CC9EBEC3C83AFDCD82CD8957D" + var_13;
    var_18 = 0;

    if(var_13 == "_encstr_A1100738A33A638123")
      var_18 = 0.7;

    var_19 = getdvarfloat(var_17, var_18);

    if(var_19 != 0)
      var_1 = int(ceil(var_1 * var_19));

    var_20 = "_encstr_8DAE1237B127EB4CC9EBEC3C83AFDCD82CD8957D" + var_12;
    var_18 = 0;

    if(var_12 == "_encstr_B10B12CC2CE969D3A8513F1BC883B4723B648253")
      var_18 = 1.43;

    var_21 = getdvarfloat(var_20, var_18);

    if(var_21 != 0)
      var_1 = int(ceil(var_1 * var_21));

    if(var_0.meansofdeath == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_0.meansofdeath == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215")
      var_1 = int(ceil(var_1 * level.disable_super_in_turret.sceneangles));
    else if(var_0.meansofdeath == "_encstr_8DED0A21C79B660BC7588981")
      var_1 = int(ceil(var_1 * level.disable_super_in_turret.school_guards_wake_behavior));
  }

  if(var_1 > 0 && var_2 && !var_4 && var_0.attacker isinexecutionattack() && var_0.victim isinexecutionvictim())
    level.disabled_permanently = gettime();

  return var_1;
}

_id_12604() {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
    return;
  else
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_11E23();
}

droponplayerdeath(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
    return 1;

  if(level.disable_super_in_turret.spawndomplateflagtestmap)
    _id_125FC();

  return 0;
}

onplayerkilled(var_0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }
  if(isDefined(self))
    thread _id_131A5();

  if(level.gameended) {
    return;
  }
  var_1 = var_0.victim;
  var_2 = var_0.attacker;

  if(!isDefined(var_2) || !isPlayer(var_2) || !isDefined(var_1)) {
    return;
  }
  if(var_1 _id_13302(var_2, var_0.meansofdeath))
    var_1 thread _id_13662(var_1, var_2);

  if(istrue(level.disable_super_in_turret.sat_signal_lost_nag) && var_1 _id_13300(var_2))
    var_1 thread _id_1365A(var_1, var_2);

  if(var_1 _id_13326(var_2))
    var_1 thread _id_1258B();

  if(var_2 _id_13306(var_0))
    var_2 thread _id_12587();

  var_3 = var_0.hitloc;

  if(isDefined(var_3) && var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC() && (var_3 == "_encstr_81CC0586952C91" || var_3 == "_encstr_A6CC076A05751852B3")) {
    var_4 = 0;
    var_2 thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_BA1A129877094830430AE74AC815EA8048581D93", var_4, 1);
  }

  if(var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
    var_5 = var_1 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28");
    var_6 = var_1 gettagangles("_encstr_813B0D4027B390B37585BBC819FD28");
    playFX(level.disable_super_in_turret.sat_setup_access_card_pickup, var_5, anglesToForward(var_6), anglestoup(var_6));
  }

  var_1 setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_8B1608EC43B8D647A113", 0);
}

_id_131A5() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
    return;
  }
  self waittill("_encstr_BA350853C128FB939DB9");
  scripts\mp\utility\player::_setsuit("_encstr_917A134BBB70AF23CA99C25D1B47CDBA5A3AFADA38");
}

_id_13302(var_0, var_1) {
  if(!_id_13325(var_0))
    return 0;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
    return 0;

  if(var_1 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001") {
    if(!level.disable_super_in_turret.scavenger_cache_hint && !istrue(self.inlaststand))
      return 0;
  }

  if(_encstr_8EF62B63396EFF42C08F5F1561F24F2719118B4BE34DDFED28B537E769301927B7E91291CA1073B7886507FB77::truckdoorleft(self))
    return 0;

  return 1;
}

_id_13306(var_0) {
  if(!level.disable_super_in_turret.scalesitesbyteams)
    return 0;

  if(var_0.meansofdeath != "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
    return 0;

  if(var_0.victim _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
    return 0;

  if(!level.disable_super_in_turret.scavenger_cache_hint && istrue(var_0.victim.inlaststand))
    return 0;

  if(!var_0.attacker _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
    return 0;

  return 1;
}

_id_13662(var_0, var_1) {
  var_2 = spawndogtags();
  _id_13238(var_2, var_0.origin);

  if(istrue(var_0.isjuggernaut)) {
    var_3 = 2;
    var_4 = getdvarint("_encstr_85A417D2BEF5E17A53D9B7D3B8AE3E0BB3551A4D9F2D9B8719", var_3);
    var_5 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();

    for(var_6 = 1; var_6 < var_4; var_6++) {
      var_7 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_5, var_0.origin, var_0.angles, var_0, undefined, undefined, 0);

      if(!isDefined(var_7) || var_7.origin == (0, 0, 0))
        var_7.origin = var_0.origin;

      var_2 = spawndogtags();
      _id_13238(var_2, var_7.origin);
    }
  }
}

_id_13300(var_0) {
  if(!_id_13325(var_0))
    return 0;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
    if(randomintrange(1, 101) <= level.disable_super_in_turret.sat_signal_shift)
      return 1;
  }

  return 0;
}

_id_1365A(var_0, var_1) {
  var_2 = spawndogtags();
  _id_13238(var_2, var_0.origin);
}

_id_13326(var_0) {
  if(!_id_13325(var_0))
    return 0;

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
    return 0;

  return 1;
}

_id_1258B() {
  if(!isDefined(level.disable_super_in_turret.sat_wait_for_radar) || level.disable_super_in_turret.sat_wait_for_radar.size <= 0) {
    return;
  }
  self.itemsdropped = 0;
  var_0 = [];

  for(var_1 = 0; var_1 < level.disable_super_in_turret.sat_wait_for_power_think; var_1++) {
    if(randomintrange(1, 101) > level.disable_super_in_turret.sat_wait_for_power) {
      continue;
    }
    var_2 = randomintrange(0, level.disable_super_in_turret.sat_wait_for_radar.size);
    var_3 = level.disable_super_in_turret.sat_wait_for_radar[var_2];
    var_0[var_0.size] = var_3;
  }

  var_4 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A42(var_0, 0);
}

_id_13325(var_0) {
  if(isDefined(var_0) && var_0 == self)
    return 0;

  if(level.teambased && isDefined(var_0) && isDefined(var_0.team) && var_0.team == self.team)
    return 0;

  if(isDefined(var_0) && !isDefined(var_0.team) && (var_0.classname == "_encstr_85FE0DD5727A27098513298817CA23" || var_0.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0"))
    return 0;

  if(isagent(self) || isagent(var_0))
    return 0;

  return 1;
}

spawndogtags() {
  var_0 = 16;
  var_1 = undefined;
  var_2 = 0;
  var_3 = undefined;

  if(level.disable_super_in_turret._id_12CB1.size > 0) {
    var_4 = level.disable_super_in_turret._id_12CB1.size - 1;
    var_1 = level.disable_super_in_turret._id_12CB1[var_4];
    level.disable_super_in_turret._id_12CB1[var_4] = undefined;
    loadoutprimaryaddblueprintattachments(var_1);
    var_2 = 1;
    var_3 = var_1.trigger;
    var_5 = var_1.visuals;
  } else if(level.disable_super_in_turret._id_12CB0.size >= level.disable_super_in_turret._id_11B5B) {
    var_1 = resetdangercircleorigin();
    loadoutprimaryaddblueprintattachments(var_1);
    var_2 = 1;
    var_3 = var_1.trigger;
    var_5 = var_1.visuals;
  } else {
    var_6 = "_encstr_925510B7D91FD15360BB15D1F3B88B6A7521";
    var_5[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_5[0].angles = (45, 0, 0);
    var_5[0] setModel(var_6);
    var_5[0] hudoutlineenable("_encstr_8D6B15DEAEE8D84BCD957D8CB2C1D143BE07AE4E38C6CA");
    var_5[0] setasgametypeobjective();
    var_5[0].usetype = 1;
    var_5[0].vampirepoints = 1;
    var_3 = var_5[0];

    if(level.disable_super_in_turret._id_13A25) {
      var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (0, 0, 0), 0, 32, 32);
      var_3.vampirepoints = 1;
      var_5[0].vampirepoints = undefined;
    }
  }

  var_7 = "_encstr_9A19040BCDBC";
  var_8 = 0;
  var_1 = scripts\mp\gameobjects::createuseobject(var_7, var_3, var_5, (0, 0, var_0), undefined, var_2);
  var_1._id_133E5 = 1;
  var_1.onuse = ::onuse;
  var_1 scripts\mp\gameobjects::setusetime(var_8);
  var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::timeoutonabandonedcallback();
  var_1.inuse = 1;
  var_1.lastusedtime = gettime();
  var_9 = "_encstr_B40101" + var_1 getentitynumber();
  level.disable_super_in_turret._id_12CB0[var_9] = var_1;
  return var_1;
}

_id_13238(var_0, var_1) {
  var_2 = 36;
  var_3 = (0, 0, 36);
  var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_1, 30);
  var_5 = var_4 + (0, 0, var_2);
  var_0.curorigin = var_5;

  if(level.disable_super_in_turret._id_13A25)
    var_0.trigger.origin = var_5;

  var_0.visuals[0].origin = var_5;
  var_0 scripts\mp\gameobjects::initializetagpathvariables();
  var_0.interactteam = "_encstr_9A19040BCDBC";
  var_0.visuals[0] _id_13378();
  var_0.ownerteam = "_encstr_A7A408B9CA5D1D4E2C63";
  var_0.trigger triggerenable();

  if(isDefined(var_0.objidnum)) {
    if(var_0.objidnum != -1) {
      var_6 = var_0.objidnum;
      scripts\mp\objidpoolmanager::update_objective_state(var_6, "_encstr_930B07BB1B6B3854FF");
      scripts\mp\objidpoolmanager::update_objective_position(var_6, var_4 + var_3);
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_6, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(var_0.objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(var_0.objidnum, 0);
      var_0 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8D701AD8D9A3D7CD4C1A2C4F6BC02F0B49DF82890FABA35586805851", "_encstr_8ECD1123407BEFC751BD31889F2789592B50D7");
      var_0 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
      objective_icon(var_0.objidnum, "_encstr_95D51224CE5F62D720D82307C099B0393F50AB1D");
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0.objidnum);
    }
  }

  playsoundatpos(var_5, "_encstr_A28719B5E0F55B5A36D86CDBDC995A39DAEB3A0BEC37BE91C9DB0E");
  var_0.visuals[0] scriptmodelplayanim("_encstr_845B0F80326F10804A938B9F27535730E6");
}

loadoutprimaryaddblueprintattachments(var_0) {
  var_0.visuals[0] dontinterpolate();
  var_0.visuals[0] hide();
  var_0.trigger triggerdisable();
  var_0.trigger notify("_encstr_8BE208E31FA8E1631D65");
  var_0 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  var_0.inuse = 0;
  var_0.visuals[0].origin = (0, 0, 0);
  var_0.trigger.origin = (0, 0, 0);
  headlessinfilplayers(var_0);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0.objidnum);
}

resetdangercircleorigin() {
  var_0 = undefined;

  foreach(var_2 in level.disable_super_in_turret._id_12CB0) {
    if(!isDefined(var_0) || var_2.lastusedtime < var_0.lastusedtime)
      var_0 = var_2;
  }

  return var_0;
}

onuse(var_0) {
  thread _id_120A7(var_0);
}

_id_120A7(var_0) {
  if(!isDefined(var_0)) {
    thread removetags(self);
    return;
  }

  if(!playercanusetags(var_0)) {
    return;
  }
  thread removetags(self);
  var_0._id_11F39++;

  if(level.disable_super_in_turret.spawndistancemax)
    var_0 _id_125D4();

  var_0 _id_13FDD("_encstr_ACF20B9D7D8575919257DF8095", var_0._id_11F39);

  if(isDefined(level.disable_super_in_turret._id_11B5B) && var_0._id_11F39 >= level.disable_super_in_turret.saw_3_origin)
    var_0 thread _id_12587();
}

_id_13378() {
  self hide();

  if(!level.disable_super_in_turret._id_13A25) {
    self makeusable();
    self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
    self setHintString(&"_encstr_AAA40EBF0966CA113908B2FC16579988");
    self setuseprioritymax();
  }

  foreach(var_1 in level.players)
  _id_12CB2(var_1);
}

headlessinfilplayers(var_0) {
  foreach(var_2 in level.players) {
    if(!var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
      continue;
    }
    var_3 = var_2 getnodeoffset_code(7);

    if(var_3 != -1 && var_3 == var_0.objidnum)
      var_2 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
  }
}

removetags(var_0) {
  loadoutprimaryaddblueprintattachments(var_0);
  var_1 = "_encstr_B40101" + var_0 getentitynumber();
  level.disable_super_in_turret._id_12CB0[var_1] = undefined;
  level.disable_super_in_turret._id_12CB1[level.disable_super_in_turret._id_12CB1.size] = var_0;
  playFX(level._effect["_encstr_AA4F12822A7BBBC5796FA78B83F7236BB03403C0"], var_0.curorigin);
  playsoundatpos(var_0.curorigin, "_encstr_B6111319CA0760E8031797A7574A3820D966A073F2");
}

playercanusetags(var_0) {
  return var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC();
}

_id_125D4() {
  var_0 = (0, 1, 0);
  self.spawnboardroom_juggdrop setvalue(self._id_11F39);
  self.spawnboardroom_juggdrop thread spawn_vindia_assault3(var_0);
  self.spawnboardroom_loadoutdrop thread spawn_vindia_assault3(var_0);
}

_id_12587(var_0) {
  if(!istrue(var_0) && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
    return;
  }
  var_1 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC() || istrue(self._id_14438);

  if(var_1) {
    _encstr_9A1F34B98D3996838EB9BCAD07793B85DAB2D15E1CAC9B7913E4AFEC0BADB2D12F1C2BF59DE11CAF36860B1B3695379DB2CD8B9D37B1::_id_11FEF(self);
    self.scn_infil_tango_npc_2_sfx = 1;
  }

  _id_1267E(0);
  _id_125AE(0);
  _encstr_BEE327C399CE5FE2A0EF3F75C152EFC7F9F12BEB832D7F0DC8155747C9D0B94B932802524B50F752A8::move_to_new_node(self);

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
    self _meth_87AA("_encstr_B82907C2887BC62B39");
  else
    self _meth_87AA("_encstr_B40101");

  if(isDefined(self.operatorcustomization.clothtype) && self.operatorcustomization.clothtype != "_encstr_B40101")
    self setclothtype(self.operatorcustomization.clothtype);
  else
    self setclothtype("_encstr_BEE00A93594E2BE548C7786C");

  self.operatorcustomization = undefined;
  scripts\cp_mp\execution::_clearexecution();
  self._id_12CA8 = 1;
  var_2 = self.origin;
  var_3 = self.origin;
  var_4 = self getplayerangles();
  var_5 = 0;

  if(level.disable_super_in_turret.spawndragonsbreathstruct)
    [var_3, var_4, var_2] = _id_125DD();
  else {
    [var_3, var_4, var_5] = _id_125DE();
    var_2 = var_3;
  }

  self.plotarmor = 1;
  self setscriptablepartstate("_encstr_ADF80637DB2FC38C", "_encstr_BA19049F4B2D");
  self setscriptablepartstate("_encstr_8D6D0C78D7A9D74ECACB31BF4740", "_encstr_B4250C393D87BECBF505130E27C3");
  self setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_8B1608EC43B8D647A113", 0);
  _id_125AA();

  if(!var_5) {
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();
    wait 1;
  } else
    waitframe();

  scripts\mp\class::loadout_emptycacheofloadout("_encstr_AAAC09D09972B9C83F2B7F");
  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.br_respawn_loadout;
  self.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
  self.class = "_encstr_AAAC09D09972B9C83F2B7F";
  self.forcespawnangles = var_4;
  self.forcespawnorigin = var_2;
  scripts\mp\utility\player::_setsuit("_encstr_917A134BBB70AF23CA99C25D1B47CDBA5A3AFADA38");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self skydive_deployparachute();
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::defend_wave_2();
  _id_125B3(1);
  self enableexecutionvictim();
  self _meth_87B2();
  self lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");

  if(level.disable_super_in_turret.score_event_accuracy)
    thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();

  if(level.disable_super_in_turret.score_accuracy_think) {
    _id_125DA();

    if(!level.disable_super_in_turret.score_event_accuracy)
      self setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_A7A408B9CA5D1D4E2C63");

    self visionsetnakedforplayer("_encstr_B40101", 0);
  }

  if(level.disable_super_in_turret.spawndragonsbreathstruct) {
    self.plotarmor = undefined;
    _id_126BD(var_3, var_4, var_2);
  } else {
    if(!var_5) {
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();
      playFX(scripts\engine\utility::getfx("_encstr_AB150CB30DF6DCD1AFE8E4B0B937"), self.origin);
      playfxontagforclients(level.disable_super_in_turret.scn_infil_tango_npc_1_sfx, self, "_encstr_A130084D2FDAD8AA8F62", self);
    }

    if(!var_5)
      _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();

    thread _id_1252C();
  }

  if(istrue(level.disable_super_in_turret.spawndomplateflagtestmap) && _id_125FA())
    _id_125FB();
  else {
    var_8 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::disablealltablets();
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::searchcircleorigin(var_8, 0);
  }

  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize();
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::defend_wave_2();

  if(level.disable_super_in_turret.score_accuracy_think)
    move_objective_icon();

  _id_1262B(0);

  if(var_1)
    scripts\mp\hud_message::showsplash("_encstr_86C91DC3ADE83221509933781338578AD301AF4F612F6A1F48A62C43A8E0BE");

  self.plotarmor = undefined;
  thread _id_125D9();
  self._id_12CA8 = undefined;

  if(var_1) {
    foreach(var_10 in level.teamdata[self.team]["_encstr_9775086022BE1B413B8B"]) {
      if(self == var_10) {
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_BA69123350F370BF6BB0717E3D108FFC33A0AA4A", var_10);
        continue;
      }

      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_B8D614C0EBE76127FE993FD0A2BF1B835F880313A1BD", var_10);
    }
  }

  self.scn_infil_tango_npc_2_sfx = undefined;
}

move_objective_icon() {
  if(!isDefined(level.disable_super_in_turret.saw_angles)) {
    return;
  }
  level.disable_super_in_turret.saw_angles = scripts\engine\utility::array_removeundefined(level.disable_super_in_turret.saw_angles);

  foreach(var_1 in level.disable_super_in_turret.saw_angles)
  scripts\mp\utility\outline::outlineenableforplayer(self, var_1, "_encstr_A5EA1B78CBECF82B423F0F7157CBEDA0AF60E0B0B629785CEA5F7B1F63", "_encstr_AC190479FF92");
}

spawn_vindia_assault3(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(istrue(self._id_1293B)) {
    return;
  }
  var_1 = 0.5;
  var_2 = 4;
  self._id_1293B = 1;
  var_3 = self.fontscale;
  var_4 = self.color;

  if(isDefined(var_0))
    self.color = var_0;

  self changefontscaleovertime(var_1);
  self.fontscale = var_2;
  wait(var_1);
  self changefontscaleovertime(var_1);
  self.fontscale = var_3;
  wait(var_1);
  self.color = var_4;
  self._id_1293B = undefined;
}

_id_125DD() {
  var_0 = getdvarint("_encstr_AAC81DDC3639BE2693D7D9C31C7D37E058BB9BA195969D86D1DECCCC37B28E", 3000);
  var_1 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::relic_nuketimer_gettimeformission() / 1000;
  var_2 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE(0, var_1, var_0);
  var_3 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_2);
  return [var_2.origin, var_2.angles, var_3];
}

_id_125DE() {
  [var_1, var_2, var_3] = _id_125D8();

  if(!var_3)
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_1);

  return [var_1, var_2, var_3];
}

_id_125AA() {
  _id_125B3(0);
  var_0 = gettime() + 3000;

  while(self isgestureplaying() && var_0 > gettime()) {
    self stopgestureviewmodel();
    waitframe();
  }

  while(var_0 > gettime() && (self isinexecutionattack() || self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8C140CAFEF2FC261305972B65549")]]()))
    waitframe();

  playFX(scripts\engine\utility::getfx("_encstr_AB150CB30DF6DCD1AFE8E4B0B937"), self.origin);
  playfxontagforclients(level.disable_super_in_turret.scn_infil_tango_npc_1_sfx, self, "_encstr_A130084D2FDAD8AA8F62", self);
  self notify("_encstr_9A83101A4D14D775F893B5791590C7EB2743");
  self enableoffhandweapons();
  self giveandfireoffhand("_encstr_88760E2FB9C8999BE593F20BD9D03F8A");
  wait 1.25;
}

_id_125B3(var_0) {
  self allowfire(var_0);
  self allowmovement(var_0);
  self allowmelee(var_0);

  if(var_0) {
    self playershow();
    self enableoffhandweapons();
  } else {
    self playerhide();
    self disableoffhandweapons();
  }
}

_id_1252C() {
  if(!getdvarint("_encstr_AF0F1F3EEB4366550A699868B369197B5791C8A053F369B7F57180C82A3EEB73F7", 0)) {
    return;
  }
  var_0 = 650;
  var_1 = getdvarint("_encstr_819B1763BE43779EE501826B6067D217DB93C7FAC7E9F763CF", var_0);
  var_2 = incrementpersistentstat(level.players, self.origin, var_1);

  foreach(var_4 in var_2) {
    if(var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() && var_4.team != self.team && isalive(var_4))
      _id_125D7(var_4, var_1);
  }

  var_6 = anglesToForward(self.angles);
  playFX(level.disable_super_in_turret.start_coop_defuse_infiltrate, self.origin, var_6);
  playsoundatpos(self.origin, "_encstr_ACB215AFFF55B3E84BB1C150DF9CAD986F9FA3737743FA");
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", self.origin);
  earthquake(0.5, 1.5, self.origin, var_1);
}

_id_125FC() {
  var_0 = spawnStruct();
  var_0._id_12889 = [];
  var_0.brtdm_config = [];
  var_0.brtruck_cleanupents = [];
  var_0.brtruck_ontimelimit = [];
  var_0.offhands = [];
  var_0.nvidiaansel_overridecollisionradius = [];
  var_1 = [];
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var_4) && !issubstr(var_4.basename, "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") && !scripts\mp\utility\weapon::unset_relic_mythic(var_4.basename))
      var_1[var_1.size] = var_4;
  }

  foreach(var_7 in var_1) {
    var_8 = createheadicon(var_7);
    var_0.brtdm_config[var_8] = weaponclipsize(var_7);
    var_0.brtruck_ontimelimit[var_8] = self getweaponammostock(var_7);

    if(scripts\mp\utility\weapon::turnexfiltoside(var_7))
      var_0.brtruck_cleanupents[var_8] = self getweaponammoclip(var_7, "_encstr_A5AD056A019C63");

    if(getsubstr(var_8, 0, 4) == "_encstr_9B83050BD88EF5") {
      continue;
    }
    var_0._id_12889[var_0._id_12889.size] = var_7;
  }

  if(self.lastcacweaponobj != getcompleteweaponname("_encstr_8BBA05185F8B99")) {
    foreach(var_4 in var_0._id_12889) {
      if(self.lastcacweaponobj == var_4) {
        var_0.current = self.lastcacweaponobj;
        break;
      }
    }
  }

  var_12 = self getweaponslistoffhands();

  foreach(var_14 in var_12) {
    if(var_14.basename == "_encstr_A51B0B2BD260444AAFCD6F86E2") {
      continue;
    }
    var_15 = self getweaponammoclip(var_14);

    if(var_15 <= 0) {
      continue;
    }
    var_0.offhands[var_0.offhands.size] = var_14;
    var_16 = createheadicon(var_14);
    var_0.brtdm_config[var_16] = var_15;
  }

  foreach(var_20, var_19 in self.equipment)
  var_0.nvidiaansel_overridecollisionradius[var_19] = var_20;

  var_0.super = undefined;

  if(isDefined(self.super) && !self.super.usepercent)
    var_0.super = self.equipment["_encstr_BEB406F03B72BB3B"];

  self.setdeleteable = var_0;
}

_id_125FB() {
  self takeallweapons(0, 1);
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
  self.equipment["_encstr_BA7F0830B3A7859B60B0"] = undefined;
  self.equipment["_encstr_AC8F0AE74163F85AAA380AD8"] = undefined;
  self.equipment["_encstr_91B50734CA58631D1A"] = undefined;
  self.equipment["_encstr_BEB406F03B72BB3B"] = undefined;
  var_0 = getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");

  if(self.setdeleteable._id_12889.size < 2)
    self giveweapon(var_0);

  var_1 = 0;

  foreach(var_3 in self.setdeleteable._id_12889) {
    var_4 = createheadicon(var_3);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3);

    if(!var_1) {
      self assignweaponprimaryslot(var_4);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_3);
      var_1 = 1;
    }

    scripts\mp\weapons::fixupplayerweapons(self, var_4);
  }

  foreach(var_7 in self.setdeleteable.offhands) {
    var_8 = scripts\mp\equipment::getequipmentreffromweapon(var_7);

    if(!isDefined(var_8)) {
      continue;
    }
    var_9 = self.setdeleteable.nvidiaansel_overridecollisionradius[var_8];

    if(!isDefined(var_9)) {
      continue;
    }
    scripts\mp\equipment::giveequipment(var_8, var_9);
  }

  foreach(var_4, var_12 in self.setdeleteable.brtruck_ontimelimit) {
    self setweaponammostock(var_4, var_12);
    var_3 = getcompleteweaponname(getweaponbasename(var_4));
    var_13 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_3);

    if(isDefined(var_13)) {
      self.br_ammo[var_13] = var_12;
      _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_hud_update_ammotype(var_13);
    }
  }

  foreach(var_4, var_12 in self.setdeleteable.brtdm_config)
  self setweaponammoclip(var_4, var_12);

  foreach(var_4, var_12 in self.setdeleteable.brtruck_cleanupents)
  self setweaponammoclip(var_4, var_12, "_encstr_A5AD056A019C63");

  waitframe();
  var_16 = var_0;

  if(isDefined(self.setdeleteable.current))
    var_16 = self.setdeleteable.current;
  else if(isDefined(self.setdeleteable._id_12889[0]))
    var_16 = self.setdeleteable._id_12889[0];

  self switchtoweaponimmediate(var_16);

  if(isDefined(self.setdeleteable.super)) {
    var_17 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[self.setdeleteable.super]];
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::forcegivesuper(var_17, 0);
  }

  thread scripts\cp_mp\gestures::_id_13E1A();
  self.setdeleteable = undefined;
}

_id_125D9() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_84290BF4DBB698B42BAFCD2BA3");

  while(!self isonground())
    waitframe();

  thread _id_125DB();
}

_id_125D8() {
  var_0 = 500;
  var_1 = 10000;
  var_2 = 5;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent))
    return [self.origin, self getplayerangles(), 1];

  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  var_4 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_5 = distance2dsquared(self.origin, var_4);

  if(var_5 <= var_3 * var_3)
    return [self.origin, self getplayerangles(), 1];

  var_6 = undefined;
  var_7 = undefined;
  var_8 = (self.origin[0], self.origin[1], 0);
  var_9 = vectorNormalize(var_8 - var_4);

  for(var_10 = 1; var_10 <= var_2; var_10++) {
    var_11 = var_3 - var_0 * var_10;

    if(var_11 < 0) {
      break;
    }

    [var_6, var_7] = remove_marker_when_player_disconnects(var_4, var_9, var_11);

    if(isDefined(var_6)) {
      break;
    }
  }

  if(!isDefined(var_6)) {
    var_6 = var_4;
    var_7 = self getplayerangles();
  }

  var_13 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_6, var_1);
  return [var_13, var_7, 0];
}

_id_125DB() {
  if(!istrue(level.disable_super_in_turret.spawndomplates)) {
    return;
  }
  thread _id_126B4(level.disable_super_in_turret.human);
}

remove_marker_when_player_disconnects(var_0, var_1, var_2) {
  var_3 = var_0 + var_1 * var_2;
  var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::relic_nuketimer_gettimeformission() / 1000;

  if(_encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::set_relic_rocket_kill_ammo(var_3, var_4)) {
    var_5 = vectortoangles(var_1 * -1);
    return [var_3, var_5];
  } else
    return [undefined, undefined];
}

_id_125FA() {
  return isDefined(self.setdeleteable);
}

_id_125D7(var_0, var_1) {
  var_2 = 1800;
  var_3 = spawnStruct();
  var_3.origin = self.origin;
  var_0 thread scripts\mp\equipment\concussion_grenade::applyconcussion(var_3, self);
  var_0 thread _id_1262E(level.disable_super_in_turret.sat_piece);
  var_4 = var_0.origin - self.origin;
  var_5 = vectortoangles(var_4);
  var_6 = distance(var_0.origin, self.origin);
  var_7 = 1.0 - var_6 / var_1;
  var_0 _id_1250A(var_5, var_2, var_7);
}

_id_1262E(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  self notify("_encstr_81971074BB638F9ED9D0C01A9801D77F5B90");

  foreach(var_3, var_2 in var_0.powers) {
    if(!isDefined(self._id_12821[var_3])) {
      continue;
    }
    self._id_12821[var_3].incooldown = 0;
    thread _id_1262C(var_0, var_3);
  }
}

watch_flight_collision(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
    var_1 = isDefined(var_0.attacker) && var_0.attacker nukefridgewatcher();

    if(!var_1 || !level.disable_super_in_turret.scn_infil_tango_npc_5_sfx || level.disable_super_in_turret.scn_infil_tango_npc_4_sfx)
      return 0;

    thread _id_1262E(level.disable_super_in_turret.sat_piece);
    thread _id_125A5();
    thread _id_125B5(var_0);
    thread _id_1258A();
  }

  return 1;
}

_id_125A5() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_BDA21B114FFBF529ABC3C920EF5FA82E328BA783B3E230E8EFDF303857");
  waittillframeend;
  self setlaststandenabled(1);
  self.usedprops = 1;
  self.laststandreviveent makeunusable();
  var_0 = self.laststandreviveent;
  var_0.usetime = getdvarfloat("_encstr_B42719173E8231E572900F831907C3D7D3F91BAAC7962F47734D8A", 3.0) * 1000;

  if(!isDefined(var_0.curprogress))
    var_0.curprogress = 0;

  while(scripts\mp\utility\player::isreallyalive(self) && var_0.curprogress < var_0.usetime) {
    if(self isinexecutionvictim()) {
      waitframe();
      continue;
    }

    if(!isDefined(var_0.userate))
      var_0.userate = 0;

    var_0.curprogress = var_0.curprogress + level.frameduration * var_0.userate;
    var_0.userate = 1;
    scripts\mp\gameobjects::updateuiprogress(var_0, 1);

    if(var_0.curprogress >= var_0.usetime) {
      break;
    }

    waitframe();
  }

  var_0.usetime = undefined;
  var_0.curprogress = undefined;
  var_0.userate = undefined;
  scripts\mp\laststand::playanim_aibegindismountturret("_encstr_A9DE1493887907E7DB3DFEE94CC11F8AA3201A4A901F", self);
  self playsoundtoplayer("_encstr_A741177B4BBE79EA10D12E7368A13C5237E1679B1D50D3A9D8", self, self);
  self playSound("_encstr_84241BF45B31D73783B17D1393B22CE834F58DC2CD8CF5239C7B835ACD");
  self setlaststandenabled(0);
}

_id_125B5(var_0) {
  var_1 = 500;
  var_2 = 90;
  var_3 = 60;
  var_4 = 30;
  var_5 = var_0.direction_vec;
  var_6 = vectortoyaw(var_5);
  var_7 = var_2;
  var_8 = var_3;

  if(scripts\engine\utility::cointoss())
    var_8 = var_8 * -1;

  var_8 = var_8 + var_6;
  var_9 = (var_7, var_8, 0);
  var_10 = vectorNormalize((var_5[0], var_5[1], 0));
  var_11 = var_10 * var_4 + (0, 0, var_4);
  _id_1250A(var_9, var_1, 1.0, var_11);
}

_id_1258A() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self._id_1423B = 1;
  var_0 = getdvarfloat("_encstr_97091C6EB193EB134ED776F0E0BEB359D05AD81BB27DB4D6B5AE734BE8BC", 1.5);
  wait(var_0);
  self._id_1423B = undefined;
}

_id_1424A(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.victim;
  var_3 = var_0.direction_vec;
  var_3 = -1 * vectorNormalize((var_3[0], var_3[1], min(var_3[2], 0)));
  var_4 = var_2 getEye();
  var_5 = var_4 + var_3 * 400;
  var_5 = var_2 chase_hvt_vo(var_5, var_4, var_3, 0, var_1);
}

dangercircletick(var_0, var_1) {
  if(level.disable_super_in_turret.scn_infil_hackney_heli_npc1 != 1) {
    return;
  }
  if(!isDefined(level.disable_super_in_turret._id_12CB0)) {
    return;
  }
  var_2 = var_1 + level.disable_super_in_turret.scn_infil_hackney_heli_npc2;
  var_3 = var_2 * var_2;

  foreach(var_5 in level.disable_super_in_turret._id_12CB0) {
    if(isDefined(var_5.visuals) && distance2dsquared(var_5.origin, var_0) >= var_3)
      thread removetags(var_5);
  }
}