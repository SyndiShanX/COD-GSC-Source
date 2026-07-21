/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_treasure_hunt.gsc
******************************************************/

activate_c4_for_pick_up() {}

activate_laser_trap_parent() {}

init() {
  table_getrole();
  level thread table_getaddblueprintattachments();
}

table_getrole() {
  tarmac_techo_start();
  successfulteams();
  init_callbacks();
}

tarmac_techo_start() {
  level._id_13D17 = spawnStruct();
  level._id_13D17._id_13900 = getDvar("_encstr_B61E2D731890306D3A596B353EC60B22DDFC458539D139EF871727B50BB703DCE6DB90AB376A47EFE890886A18CFAE", "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  level._id_13D17._id_13901 = getDvar("_encstr_A21E2D3B5F730998FBA958EB5A8F250A77A4FBFE3B0714E021B1DF1B1B48BB6B6BE24BB0E82FF9BB9F81A87FA21E9B", "_encstr_B805127C9C59D94398C193AE10710632593B0577");
  level._id_13D17._id_138FF = getDvar("_encstr_84602B5B966B5F86FDB12B52F017BB13619BC5CEB596DB8D8308E2AB40777243596E4C71C039CF95A3E09AE2A8", "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B");
  level._id_13D17.parachute_set_spawn_values = getdvarfloat("_encstr_9BBD271BAFF8B9FB4EF7A3DAB9267F2AE841959EE9E93FAF7C492B5223EE772298FB2F161190C5879B", 30.0);
  level._id_13D17.spotlight_target_found_dist_sq = getdvarint("_encstr_83D12CDC36397D2639512795586EAE39B28457DCA3EBEAE65929CA9B1C16BBB9882B630BF2A095931A5A4E1BC695", 1);
  level._id_13D17.spotlight_target_found_speed = getdvarint("_encstr_961D23B6D62BB74972AB60C067AB6325E2B42DB06B91BB534D5BD0780BD17BA52966244D02", 0);
  level._id_13D17.spotlight_tag = getdvarint("_encstr_A6FB3093EB0561537B731395F933CD53B5498D73F33F85081A402DA030853A29E06DE5491B58E5060FC3A2F8FFE061F798CA", 1);
  level._id_13D17.paired_lasers = getdvarfloat("_encstr_8890233736E4FA98C951C9B2586EABE42B24EA73E8BE0B2D9C8D93B0338E4A599BE016EECD", 0.08);
  level._id_13D17.padding_damage = getdvarfloat("_encstr_97A72637B127FA13C9454EB2B0CDABE4B284D59B1DAF85D2931B390B991D9AB0E1146363DBDD95C8", 30);
  level._id_13D17.para_groups = getdvarfloat("_encstr_825626CD1BC97D139C5193B20B6E57932B42ABE63ABE852D271B4E58993A15BCC19534430B378DB2", 1.0);
  level._id_13D17.splashtime_drops = getdvarint("_encstr_99392B6E1BC9AF4C9CA29CB2C2B9EA4ECA09BACD3AFA4E95B907B0BBDCABC24BD123F6C9A04ECADCD1392B856B", 0);
  level._id_13D17.spinpropkey = getdvarint("_encstr_AAB226035AA3C870C20CB58321EA802687805B2893BF96B05A709BAF469D88ED1FFA52377B9FCE70", 1);
  level._id_12CA7 = getdvarint("_encstr_B1FD147BCE6AE12E037BD5F3C77BEDF0156C2350B39F", 7500);
}

successfulteams() {
  if(getdvarint("_encstr_A2B51C6E6C937D9827A2C92BB0E6AB399512ABDC3AF5E01B0B5E1D2BCDA3", 0))
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE");

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");
}

init_callbacks() {
  level.decoyassists = ::groundz;
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_85DC0CB2A8BE0795B831C9C57B28", ::circletimer);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A549125D02CF7BE7E581E8980BFF55355FB9DDC3", ::droponplayerdeath);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_992B1791C362CB50F215A1F8C7CC91863A1B71278F5A98E82C", ::_id_12604);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_BADF16AD165ED0F6B99B96C895E40A3616CBB2E488AC5846", ::dyn_door);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AB11161D39D23B76954E29AC6E832CEE377ACE95E436C2F2", ::_id_13DCB);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AB6E121F8B384F1A31424C9F0D0802380EE3B392", ::wait_for_chopper_boss_finish_turning);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8CDB0F17758F62C1503912545010040A7D", ::onplayerkilled);
}

table_getaddblueprintattachments() {
  waitframe();
  scripts\mp\flags::gameflaginit("_encstr_A2D20FE4880D52A426C867576878654BD3", 0);
  _encstr_85592F474FBE12F0D81BA53D532A2F2A99EBC3E7116DFB97B0C3A18228E07462EC73E7BBBD805395D02B248DE072BF9BCE::init();
  thread _id_13206();
  level thread syringe_out();
}

_id_13206() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level._id_13D17._id_12CA4 = 1;
  thread _id_131E8();
  thread _id_13207();
}

_id_131E8() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_9A040DC8621F5B8D5FC7A615D12BEA");
  var_0 = raid_player_start_pos_array();
  var_1 = 0.0;

  for(var_2 = 0; var_2 < var_0; var_2++)
    var_1 = var_1 + (level.br_level.br_circleclosetimes[var_2] + level.br_level.br_circledelaytimes[var_2]);

  level.ally_movement_defend_0 = var_1;
  var_3 = int(var_1 * 1000);
  var_4 = var_3;
  var_5 = getdvarint("_encstr_B85F30DC1B9CEBD1C9AC0B37BAE459AFA1EA378ED74E959B8385BBCDBED863DE9B2B46F5A35AD62B4ED7AD160FFA474BB656", 90000);

  if(var_4 > var_5) {
    wait((var_4 - var_5) / 1000);
    var_4 = var_5;
  }

  setomnvarforallclients("_encstr_AB2C1FAB5C571836E1DBF9C38B7AF5C03F37720302D1D8ED1997C5F93723CBF0DD", int(gettime() + var_4));

  foreach(var_7 in level.players) {
    if(!isDefined(var_7)) {
      continue;
    }
    var_7 thread scripts\mp\hud_message::showsplash("_encstr_A1EA21D00B9FF37392F49EA58C7965D901E37840E37BA92B8A5D9538A6A29743794BE8");
  }
}

_id_13207() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level._id_13D17._id_12CA1 = [];

  if(istrue(level._id_13D17.spotlight_target_found_dist_sq)) {
    var_0 = raid_player_start_pos_array();

    for(var_1 = 0; var_1 < var_0; var_1++)
      level._id_13D17._id_12CA1[var_1] = getdvarint("_encstr_A56B258FFE7E3E126E2093E8EE8CF015010F92F79BA35AF70DA9A7E54AFA97DFDE4F83DBD3A1EF" + (var_1 + 1), level._id_13D17.parachute_set_spawn_values);
  } else
    level._id_13D17._id_12CA1[0] = getdvarint("_encstr_A61B1D88266379210DCF6BA536AFEB3B017102D5D25B490FF8F68DBDB581FA", level._id_13D17.parachute_set_spawn_values);
}

syringe_out() {
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");
}

activate_battle_station() {}

groundz() {
  level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0];

  switch (getdvarint("_encstr_B6841B6E8D937D4CBDC8E51BF6EA738EF51BA5C9B1B1CABE37E0959519", 0)) {
    case 1:
      level.br_level.br_circledelaytimes = [150, 125, 105, 80, 60];
      level.br_level.br_circleclosetimes = [90, 75, 75, 60, 115];
      level.br_level.default_player_connect_black_screen = [120, 0, 0, 0, 0];
      break;
    case 2:
      level.br_level.br_circledelaytimes = [125, 100, 75, 60, 0];
      level.br_level.br_circleclosetimes = [90, 75, 45, 45, 85];
      level.br_level.default_player_connect_black_screen = [100, 0, 0, 0, 0];
      break;
    case 3:
      level.br_level.br_circledelaytimes = [30, 10, 10, 10, 10];
      level.br_level.br_circleclosetimes = [10, 10, 10, 10, 10];
      level.br_level.default_player_connect_black_screen = [5, 0, 0, 0, 0];
      break;
    case 0:
    default:
      level.br_level.br_circledelaytimes = [150, 110, 75, 60, 0];
      level.br_level.br_circleclosetimes = [90, 75, 60, 60, 100];
      level.br_level.default_player_connect_black_screen = [120, 0, 0, 0, 0];
      break;
  }

  level.br_level.br_circleradii = [18000, 12000, 8000, 4500, 1500, 0];
  level.br_level.br_circleminimapradii = [7500, 6500, 5500, 5000, 4500];
}

circletimer(var_0) {
  if(istrue(level._id_13D17._id_12CA4)) {
    var_1 = raid_player_start_pos_array();

    if(var_0 >= 3)
      little_bird_mg_exitendinternal();
  }
}

activate_control_station_interaction() {}

dyn_door(var_0) {
  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    var_0 thread _id_14343();
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_11B15(var_0);
  }

  return 1;
}

droponplayerdeath(var_0) {
  _unlinkcorpsefromvehicle::_id_125FC();
  var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::minplunderextractions(var_1);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::missiontime(var_1);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::mintokensdropondeath(var_1);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::missedinfilplayerhandler(var_1);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::hangar_doors_opening_quadrace();
  return 1;
}

onplayerkilled(var_0) {
  if(!istrue(level.br_prematchstarted) || level.gameended || !isDefined(var_0.victim)) {
    return;
  }
  thread _id_11EC8(var_0.victim);

  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker) || var_0.attacker == var_0.victim) {
    return;
  }
  var_1 = scripts\mp\utility\teams::getteamdata(var_0.attacker.team, "_encstr_8A2A0B936CCCC3078547970A8B");

  if(var_1 <= 0)
    return;
}

activatedtime() {}

_id_14343() {
  if(!istrue(level._id_13D17._id_12CA4)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B4BE0C6E5CEAB091BEDDB483B232");
  self endon("_encstr_8AC8131EA7E8A61728E3D36AABAF739F48019177CD");
  thread getdroplocationnearcurrentcircle();
  var_0 = int(min(level.br_circle.circleindex, level._id_13D17._id_12CA1.size - 1));
  self._id_12CA1 = int(level._id_13D17._id_12CA1[var_0]);

  if(istrue(level._id_13D17.spotlight_target_found_speed))
    self._id_12CA1 = level._id_13D17._id_1452F;

  if(!isDefined(self._id_12CA1)) {
    var_1 = "_encstr_BEC88EA7B78370478BBB49D98FE29FF0688B491B8EF6D085D62BE5C7F31A5EE0D9B6B351036E623E9A1B47E58381A6E09A7C1B0BACB788FDB37B33C7DB69E5383CD6E20995E2D2AE6A6B57F5B3313670CAAC0B1BFC67186D034B23D72B1975886C0692F6A689D016CAE767016792C84034DF31A84EFED07FC2CF1B95420B05909E26258137511801FBE7159F5A23587A" + level._id_13D17.parachute_set_spawn_values;
    scripts\mp\utility\script::laststand_dogtags(var_1);
    self._id_12CA1 = int(level._id_13D17.parachute_set_spawn_values);
  }

  _id_1333F();
  _id_130DD(self._id_12CA1);

  for(self._id_12CA3 = 0; self._id_12CA1 > 0; self._id_12CA1--) {
    if(isalive(self))
      self._id_12CA1 = 0;
    else
      _id_130DD(self._id_12CA1);

    _id_130DC(self._id_12CA3);
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_AD4E116857C3E0D65F68B9EBB997BEC040CF6B", self._id_12CA1);
    self._id_12CA3 = 0;
    wait 1;
  }

  spawn_boss_wave_3();
  _id_130DC(0);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_AD4E116857C3E0D65F68B9EBB997BEC040CF6B", 0);

  if(!isalive(self)) {
    if(isDefined(self.team))
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lookforvehicles(self.team, self, 12, 1);

    thread manage_health_stage_allows(0, level.teamdata[self.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]);
  }
}

manage_health_stage_allows(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_AA180D46F62D73ECA456371C58BBDC");

  if(istrue(self.respawningfromtoken)) {
    return;
  }
  self.respawningfromtoken = 1;

  if(istrue(level._id_13D17.spinpropkey))
    self notify("_encstr_8716143EFC0FC379CFDA5930B3E62718A39C4FB345FB");

  if(istrue(var_0)) {
    _id_130DE();
    thread scripts\mp\events::killeventtextpopup("_encstr_BD8215895A97587DF27F050153093C384EF79161C513A8", 0, 0);
    wait 1.5;
  }

  _id_13FAD(var_1);
  scripts\mp\playerlogic::addtoalivecount("_encstr_ACBC09F2CD31DFEA992847");
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self, "_encstr_ACBC09F2CD31DFEA992847");
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::addrespawntoken(1);
  var_2 = 0;

  if(istrue(level._id_13D17.splashtime_drops))
    var_2 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_126E8();

  var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::relic_nuketimer_gettimeformission() / 1000;
  var_4 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE(0, var_3);
  var_5 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_4);
  self.forcespawnorigin = var_5;

  if(var_2)
    scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  var_6 = 1.0;
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();
  wait(var_6);
  spawn_boss_wave_3();
  scripts\mp\hud_message::heartbeat_sensor_pick_up_monitor();
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer();
  _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
  self.respawningfromtoken = undefined;
  _id_12C5E();
  thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_13DCB(20);
  respawn(var_4, var_5);
}

respawn(var_0, var_1) {
  level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");

  if(isDefined(self.oobimmunity))
    scripts\mp\outofbounds::disableoobimmunity(self);

  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::scriptednode(self);

  if(!isDefined(var_0))
    var_0 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE();

  var_2 = var_0.origin;
  var_3 = var_0.angles;
  var_4 = var_2;

  if(isDefined(var_1))
    var_4 = var_1;

  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::set_scriptable_states();
  self setOrigin(var_4, 1);
  self setplayerangles(var_3);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
  var_5 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_5.angles = var_3;
  var_5 hide();
  var_5 showtoplayer(self);
  self playerlinktoabsolute(var_5, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self playerhide();
  thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12524(var_5);
  waitframe();
  _id_124E6();

  if(getdvarint("_encstr_A69D166B46DACF52A7B74FD7339D037227F39329CA20A30A", 1) == 0)
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();

  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();

  if(isDefined(var_1))
    var_5.origin = var_2;

  var_5 playsoundtoplayer("_encstr_85E90F214B17D778126B31F7262DE02EF7", self);
  wait 1.5;
  self unlink();
  self clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
    self clearsoundsubmix("_encstr_AC6F16A09BE04FB9335FB4B574A7C1875B03C008A3CC6B30", 2);
  else
    self clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 2);

  self clearclienttriggeraudiozone(1);
  self playershow();
  _id_124ED(1);
  var_6 = 0;

  if(isDefined(level._id_121CC))
    var_6 = level._id_121CC;

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
    thread scripts\cp_mp\parachute::startfreefall(var_6, 0, undefined, undefined, 1);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    self setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", -1);

  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12C7A();
  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize();
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12072();
  _encstr_851F24F3D825E47B3B1687CDAF681F2EB3700BABA8D3DA4E91FEEFEACD8BCFB2D96836C208B7::_id_12072();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::removerespawntoken();
  var_7 = level.ph_setfinalkillcamwinner > 0.0 && randomfloat(1.0) < level.ph_setfinalkillcamwinner;

  if(istrue(var_7) && isDefined(level._id_13D17) && isDefined(level._id_13D17.para_groups)) {
    var_8 = 0;

    if(isDefined(level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"]))
      var_8 = level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"].size;

    if(var_8 < level._id_13D17.padding_damage) {
      thread _id_124F2(var_2);
      wait 1.5;
    }
  }

  wait 0.5;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12523();

  waitframe();
  var_5 delete();

  if(istrue(level._id_133EF))
    _encstr_85592F474FBE12F0D81BA53D532A2F2A99EBC3E7116DFB97B0C3A18228E07462EC73E7BBBD805395D02B248DE072BF9BCE::toma_strike_munitionused(1);

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
    self notify("_encstr_B18313686F8BFB339B7D70E452326346C747E078FF");

  self notify("_encstr_978F121A20F5F1EF10A0675746FB5B863780E293");

  if(!istrue(level.stage))
    thread scripts\mp\hud_message::showsplash("_encstr_A12F1470AB3F139372147E052CD9C5B96C6F68B877C1", 20, undefined);
}

wait_for_chopper_boss_finish_turning(var_0, var_1) {
  thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::playergulagautowin("_encstr_A254085207A6B7334B5A", var_0, var_1);
  _id_13FAD(level.teamdata[self.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"], var_0);
}

activategastrap() {}

_id_124F2(var_0) {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A78F076CA54E1B1B56")) {
    return;
  }
  var_1 = level.br_circle.circleindex + 1;

  if(!isDefined(level.br_level.default_class_chosen[var_1]))
    var_1 = level.br_circle.circleindex;

  var_2 = vectortoyaw(level.br_level.default_class_chosen[var_1] - var_0);
  var_3 = spawnStruct();
  var_3.origin = (var_0[0], var_0[1], var_0[2] + 4000);
  var_3.angles = (0, var_2, 0);
  var_3.cannotbesuspended = 1;
  var_4 = spawnStruct();
  var_5 = "_encstr_BDC80A5437EAD749519A6068";

  if(randomfloat(1.0) > level._id_13D17.para_groups)
    var_5 = "_encstr_83F40783ADF1D14AA3";

  var_3.targetname = var_5;

  switch (var_5) {
    case "_encstr_83F40783ADF1D14AA3":
      var_3.modelname = "_encstr_871219BCED2B66779B69C8E072690BF82BAFCEB84DBBE9BDB9F348";
      var_3.vehicletype = "_encstr_8CEE061DAC01B8F7";
      var_6 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var_3, var_4);
      break;
    case "_encstr_BDC80A5437EAD749519A6068":
      var_3.modelname = "_encstr_821619CEAC0DAFCD1AD7ADB4B1F5582D9CFA9185D8E034B0F5EE9E";
      var_3.vehicletype = "_encstr_85100F7376B718BBA15A43D8058F09CC4A";
      var_6 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var_3, var_4);
      break;
    default:
      return;
  }

  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_6, "_encstr_A266062032BD7723", self);
}

_id_124ED(var_0) {
  if(var_0) {
    self enableoffhandweapons();
    self enableusability();
  } else {
    self disableoffhandweapons();
    self disableusability();
  }
}

getdroplocationnearcurrentcircle() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AA180D46F62D73ECA456371C58BBDC");

  for(var_0 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_8A2A0B936CCCC3078547970A8B"); var_0 > 0; var_0 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_8A2A0B936CCCC3078547970A8B"))
    waitframe();

  spawn_boss_wave_3();
  self notify("_encstr_B4BE0C6E5CEAB091BEDDB483B232");
}

spawn_boss_wave_3() {
  var_0 = self calloutmarkerping_entityzoffset("_encstr_855A17D5A57DE4AC98A5278E3449CAB9072CDDDC155AB5564E");
  var_1 = var_0 &~16384;
  self setclientomnvar("_encstr_855A17D5A57DE4AC98A5278E3449CAB9072CDDDC155AB5564E", var_1);
}

_id_1333F() {
  var_0 = self calloutmarkerping_entityzoffset("_encstr_855A17D5A57DE4AC98A5278E3449CAB9072CDDDC155AB5564E");
  var_1 = var_0 | 16384;
  self setclientomnvar("_encstr_855A17D5A57DE4AC98A5278E3449CAB9072CDDDC155AB5564E", var_1);
}

_id_130DE() {
  var_0 = self calloutmarkerping_entityzoffset("_encstr_855A17D5A57DE4AC98A5278E3449CAB9072CDDDC155AB5564E");
  var_1 = var_0 | 32768;
  self setclientomnvar("_encstr_855A17D5A57DE4AC98A5278E3449CAB9072CDDDC155AB5564E", var_1);
}

_id_12C5E() {
  var_0 = self calloutmarkerping_entityzoffset("_encstr_855A17D5A57DE4AC98A5278E3449CAB9072CDDDC155AB5564E");
  var_1 = var_0 &~32768;
  self setclientomnvar("_encstr_855A17D5A57DE4AC98A5278E3449CAB9072CDDDC155AB5564E", var_1);
}

_id_130DD(var_0) {
  var_1 = self calloutmarkerping_entityzoffset("_encstr_855A17D5A57DE4AC98A5278E3449CAB9072CDDDC155AB5564E");
  var_2 = var_1 &~16383;
  var_3 = var_2 | var_0;
  self setclientomnvar("_encstr_855A17D5A57DE4AC98A5278E3449CAB9072CDDDC155AB5564E", var_3);
}

_id_130DC(var_0) {
  var_1 = self calloutmarkerping_entityzoffset("_encstr_855A17D5A57DE4AC98A5278E3449CAB9072CDDDC155AB5564E");
  var_2 = var_1 &~2147418112;
  var_3 = var_1 & 1073741824;

  if(var_3 != 0)
    var_3 = 0;
  else
    var_3 = 1073741824;

  var_4 = var_2 | var_0 << 16 | var_3;
  self setclientomnvar("_encstr_855A17D5A57DE4AC98A5278E3449CAB9072CDDDC155AB5564E", var_4);
}

_id_124E6() {
  self notify("_encstr_85E416E34BFFD7F8032A9BF7286B58256F23598BD34714E8");
  self.health = self.maxhealth;
  scripts\mp\healthoverlay::onexitdeathsdoor(1);
  scripts\mp\utility\player::enableplayerforspawnlogic(0);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A1500D40B22258CE7B07674D3F421C", 0);
}

_id_13DCB() {
  wait 0.5;
  return 1;
}

raid_player_start_pos_array() {
  return getdvarint("_encstr_AC612D1007FA6E455B6356D50663A3735503B87023BF416B93D646691F09DB9BA83F200857515B370AFFDB60375229", 3);
}

little_bird_mg_exitendinternal() {
  level._id_13D17._id_12CA4 = 0;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    _encstr_B8A728C0C63A387B6D487EF5ABCA8F876BCF74F98972F638A65361F7E239C883030BA57980AFF2073206::isbrsquadleader(var_1, "_encstr_A7A811E456E61C16DDCDAF912DB958C4C62B19", undefined, 2);
    var_1 setclientomnvar("_encstr_AB2C1FAB5C571836E1DBF9C38B7AF5C03F37720302D1D8ED1997C5F93723CBF0DD", 0);
  }
}

_id_13FAD(var_0, var_1) {
  var_2 = !istrue(level.teamdata[self.team]["_encstr_ADC01314AB683D4BDFF91812C32E733A9025B19E33"]);

  if(var_2)
    level.teamdata[self.team]["_encstr_ADC01314AB683D4BDFF91812C32E733A9025B19E33"] = 1;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.endturretonplayerstatus))
      var_4.endturretonplayerstatus = 0;

    var_4.endturretonplayerstatus++;
    var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_8AC70C0AB3C8245B35E562CB6895", var_4.endturretonplayerstatus);
    var_4 _id_121B2();
    var_5 = !isDefined(var_1) || var_4 != var_1;
    var_6 = var_2 && var_5;

    if(var_6)
      var_4 thread scripts\mp\hud_message::showsplash("_encstr_8C3018314EBE9C5926B4C93AD0EB335A39B9E8FA4EAC9D5A3B95");
  }
}

_id_11EC8(var_0) {
  foreach(var_2 in scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B")) {
    if(!istrue(var_2.shouldgamelobbyremainintact) && isalive(var_2) && var_0 != var_2) {
      var_2.shouldgamelobbyremainintact = 1;
      var_2 thread scripts\mp\hud_message::showsplash("_encstr_87DA165A72410BFFDE9C52618A911CE36BBB9869ECC397D8");
    }
  }
}

_id_121B2() {
  if(!isDefined(self.endgame_finitewaves_music))
    self.endgame_finitewaves_music = 0;

  var_0 = self.endgame_finitewaves_music;

  if(var_0 > 255)
    var_0 = 255;

  self.extrascore0 = var_0;
  self.pers["_encstr_8A220C2BC3474E0BB9B17B9CB203"] = var_0;
  return var_0;
}

activate_server_for_interact() {}

_id_12604() {
  if(!isDefined(self._id_12EB0)) {
    var_0 = getcompleteweaponname(level._id_13D17._id_13900);
    var_1 = scripts\mp\class::fixcollision(level._id_13D17._id_13901, "_encstr_96C8098FDBB937AFFB32F2", undefined, -1);
    var_2 = getcompleteweaponname(level._id_13D17._id_138FF);
    var_3 = scripts\mp\equipment::getequipmentreffromweapon(var_2);
    self giveweapon(var_0);
    self giveweapon(var_1);
    self switchtoweaponimmediate(var_1);
    self assignweaponprimaryslot(var_1);
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_give_type(self, "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9", var_1.clipsize * 2);
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_update_weapons(self);
    self notify("_encstr_B2110C63C02DC5E92388229F9D75");
    scripts\mp\equipment::giveequipment(var_3, "_encstr_BA7F0830B3A7859B60B0");
    scripts\mp\weapons::fixupplayerweapons(self, var_1);
  } else
    _unlinkcorpsefromvehicle::_id_125FB();

  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::scriptablescurid(150);
}

active_healthpacks() {}

activate_emp_drone_pick_up() {}