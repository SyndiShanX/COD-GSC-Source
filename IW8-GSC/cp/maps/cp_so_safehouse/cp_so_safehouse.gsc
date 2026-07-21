/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_so_safehouse\cp_so_safehouse.gsc
*******************************************************/

main() {
  setdvarifuninitialized("_encstr_86E10F37B1C9AFEA6E2BEBE68BAB2CC89B", 1);
  setdvarifuninitialized("_encstr_BE180EDCC6C9F59BB857C232FAB6850F", 4);
  setdvarifuninitialized("_encstr_A1D715E6C64EBE6EB8BA2C467DC6592C462B27AF5B2CC3", 2);
  setdvarifuninitialized("_encstr_8C1617C7CF3EF161B01E32BA73D8AC49197F4B17CF65DB4808", "_encstr_A34C02BB");
  setdvarifuninitialized("_encstr_9B580EE6B139F5DC5BBDAD95E8B2378E", "_encstr_934C0218");
  setsaveddvar("_encstr_95060BA9A2A045A57214A87A2D", 2);
  setsaveddvar("_encstr_87F50B71398D854C077F1F1906", 2);
  setsaveddvar("_encstr_B8E20B275451130545274DA6D3", 3);
  setsaveddvar("_encstr_843D0BF7516E708C19BFBAF5D7", 0.7);
  setsaveddvar("_encstr_9AAE0BE199FBA771822861B120", 50);
  setsaveddvar("_encstr_95180B19CC090904C7A15113EF", (-550, 0, 0));
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  scripts\engine\utility::create_func_ref("_encstr_8D7618A3C773894402B3B4E1F8A0D9A776E84818E7053D686299", scripts\cp\vehicle::_id_13119);
  scripts\engine\utility::create_func_ref("_encstr_8D0E18DBB56330034C871198DFF8CFE7EDA87F3DF8A4E48B431B", scripts\cp\cp_vehicles::incrementobjectiveachievementkill);
  _encstr_BAA53D53AE53BF0AF990F6CA70B78557CB0E87FBBF9EAF9587B81A92F0117D5F03FD1F73D726675DDFA0028AE849B5977B55E7F86E897FE64F104A069097EE::main();
  _encstr_BDAC3C3656AB5B8BF4B70A70A377E08333FA80B6EA113750F75F7050DF58F813EBE708CC07DA4799A0D718204F7BF17DD24C904D1AC2DF018A13FA68D783::main();
  _encstr_B84C37676F9E32D038FB455E730A054A77A78EAFF150DBB739C3CEE7C9085F434E13061799F8037F11ABC6EFE160979B26BB3F8B11B80A3B08::main();
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 1.25);
  setDvar("_encstr_83920A488F414D730D6721C8", 4);
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 2048);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", 8);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", 8);

  if(level.createfx_enabled) {
    return;
  }
  scripts\cp\vehicle::init_vehicles();
  level thread scripts\cp\cp_objectives::objectives_init();
  level._id_12177 = 1;
  level.hostdamagefactorlow = 0;
  level._id_133BA = 1;
  level.map_interaction_func = _encstr_8ADE419B10954729808F5F5811EE30B2DF5F378EFBD1381039A2D0CC2BB175B3C3E78F02CB1E73A7AE8B5384C292C80BFF850F178D9349BE719968FB982E0BBE51472E::register_interactions;
  level.custom_onspawnplayer_func = ::_id_124A6;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_BA13456BDE7A403753D77FEFF3CEF15810B298E182EF586019CFDBFDDFE2C830CB8F10792A07E0283127D3F5F70AB748636786739761B0D07A1BCB9DD7415D980D3D6BE0BEDB58";
  level.player_interaction_monitor = _encstr_8ADE419B10954729808F5F5811EE30B2DF5F378EFBD1381039A2D0CC2BB175B3C3E78F02CB1E73A7AE8B5384C292C80BFF850F178D9349BE719968FB982E0BBE51472E::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_8ADE419B10954729808F5F5811EE30B2DF5F378EFBD1381039A2D0CC2BB175B3C3E78F02CB1E73A7AE8B5384C292C80BFF850F178D9349BE719968FB982E0BBE51472E::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = ::interaction_trigger_properties;
  level.strike_player_connect_black_screen_fn = ::_id_1247B;
  level.mud_sfx = ::mud_sfx;

  if(!scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_init("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_init("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
  level thread scripts\cp\cp_movers::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level.additional_laststand_weapon_exclusion = [];
  level.devgui_setup_func = ::onplayerspawneddevguisetup;

  if(level.scripted_spawner_func.size < 1)
    scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(!scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    scripts\engine\utility::flag_init("_encstr_A2D20FE4880D52A426C867576878654BD3");

  var_0 = getDvar("_encstr_9A161AD8C1F537DEEBB9B033CA34DBAB9BB2F5371D16398EFA7B89A9", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101")
    level thread rundebugstartobjective(var_0);

  level.eogscoreboard = ["_encstr_A19B0973B543C35FDDE063", "_encstr_8E8D0697EB01F243", "_encstr_96D30A3468575BA7C307A128", "_encstr_A9AB06297DDFD816", "_encstr_B642089B65A658E8F597"];
  scripts\cp\cp_compass::setupminimap("_encstr_88341C3E2882531AEBCBAFF20133298FC8E6E28F61CE2EA0E7A08FF3885D");
  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
  level.laststand_enter_gamemodespecificaction = ::enter_laststand;
  level.laststand_exit_gamemodespecificaction = ::exit_laststand;
  thread weapon_xp_iw8_sn_crossbow();
}

mud_sfx(var_0) {
  if(var_0 == "_encstr_8E8405EA382B2A")
    return 0;

  var_1 = 60000;

  if(level.time_survived < 8 * var_1)
    return 3;
  else if(level.time_survived < 10 * var_1)
    return 2;
  else if(level.time_survived < 16 * var_1)
    return 1;

  return 0;
}

display_ai() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = (1, 1, 0);
  var_1 = (0, 1, 0);
  var_2 = (1, 0, 0);
  var_3 = ["_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08", "_encstr_BE7D0633C08849E2"];

  for(;;) {
    var_4 = 30;

    foreach(var_6 in var_3) {
      if(var_6 == "_encstr_BE7D0633C08849E2")
        var_7 = getaiarray().size;
      else
        var_7 = getaiarray(var_6).size;

      if(var_7 < 20)
        var_8 = var_1;
      else if(var_7 < 30)
        var_8 = var_0;
      else
        var_8 = var_2;

      var_4 = var_4 + 15;
    }

    waitframe();
  }
}

enter_laststand(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(var_4 != var_0 && !istrue(var_4.inlaststand))
      var_2[var_2.size] = var_4;
  }

  if(var_2.size == 1)
    var_2[0] _id_1243D("_encstr_AB941D7DCA5173B77701C2F52B1141A0F08AED8299E813971F33DF863AF315", 5, 10);

  if(scripts\engine\utility::is_equal(var_1, level.silo_thrust_dogtag_revive)) {
    level.silo_thrust_dogtag_revive.milestonephasepercent_lzs = var_0;

    foreach(var_4 in level.players) {
      var_7 = scripts\engine\utility::ter_op(var_4 == var_0, &"_encstr_ADB9235F9B297699B73ADD355758618D01570FF167403051840507CC4F7CA94748AF7B6343", &"_encstr_838E2116A2411744F7EF91A19FC89CC3691FA80B4FC8670E948719F9671CD6A3C0F56B");
      var_4 thread logevent_kidnapevent(var_4, var_7, 3);
    }
  }

  _encstr_A39824FFD7C234188B1A3A6970CE4FB72B1FEC33032D33FE0F60C9CF6B2D7107706705929B82::enter_laststand(var_0, var_1);
}

exit_laststand(var_0) {
  _encstr_A39824FFD7C234188B1A3A6970CE4FB72B1FEC33032D33FE0F60C9CF6B2D7107706705929B82::exit_laststand_func(var_0);

  if(isDefined(var_0.min_dist_sq_from_node)) {
    var_0 switchtoweapon(var_0.min_dist_sq_from_node);
    var_0.min_dist_sq_from_node = undefined;
  }

  var_0 _id_1243D("_encstr_ADD91D9120813877CFB1739B6B93B830A69D2B37B4F638350F9AA84382436C", 1, 5);
}

init_loot_structs() {
  var_0 = spawnStruct();
  var_0.origin = (0, 0, 1000);
  var_0.angles = (0, 0, 0);
  var_0.name = "_encstr_BDBB0616C6C186C2";
  var_0.script_noteworthy = "_encstr_91540D2DDC33D263FA36132785B3DE";
  var_0.script_team = "_encstr_9A8507BA4040188D08";
  var_0.spawnflags = int(1);
  var_0.targetname = "_encstr_B606099A8BB9EC5A283379";
  var_0.target = "_encstr_9A780C2DDC335AC6BECD1B5973CA";
  level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_B606099A8BB9EC5A283379"] = [var_0];
  var_0 = spawnStruct();
  var_0.origin = (-2000, -5000, 1000);
  var_0.angles = (0, 3, 0);
  var_0.targetname = "_encstr_9A780C2DDC335AC6BECD1B5973CA";
  var_0.target = "_encstr_A19118D486FB373377A95A93C84326FB93FF2E53AD81BBBE39F8";
  level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_9A780C2DDC335AC6BECD1B5973CA"] = [var_0];
  var_0 = spawnStruct();
  var_0._id_12F91 = int(1);
  var_0.classname = "_encstr_A3DC1337B14ED2E047BE6E8E27EA1BA3AFA12B63D2";
  var_0.target = "_encstr_97550B9297673C207532C77635";
  var_0.script_decel = int(50);
  var_0.angles = (0, 318, 0);
  var_0.lookahead = int(1);
  var_0.origin = (-600, -1000, 1000);
  var_0.script_accel = int(50);
  var_0.speed = int(120);
  var_0.targetname = "_encstr_A19118D486FB373377A95A93C84326FB93FF2E53AD81BBBE39F8";
  level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_A19118D486FB373377A95A93C84326FB93FF2E53AD81BBBE39F8"] = [var_0];
  var_0 = spawnStruct();
  var_0.script_decel = int(20);
  var_0.script_goalyaw = 1;
  var_0.target = "_encstr_96550BC6AEB91D7BDA99C8060E";
  var_0.targetname = "_encstr_97550B9297673C207532C77635";
  var_0.radius = int(400);
  var_0.angles = (0, 325, 0);
  var_0.lookahead = int(1);
  var_0.origin = (-300, -500, 1000);
  var_0._id_12F91 = int(1);
  var_0.classname = "_encstr_A3DC1337B14ED2E047BE6E8E27EA1BA3AFA12B63D2";
  var_0.script_accel = int(20);
  var_0.speed = int(120);
  level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_97550B9297673C207532C77635"] = [var_0];
  var_0 = spawnStruct();
  var_0.script_decel = int(20);
  var_0.script_goalyaw = 1;
  var_0.targetname = "_encstr_96550BC6AEB91D7BDA99C8060E";
  var_0.radius = int(200);
  var_0.angles = (0, 165, 0);
  var_0.lookahead = int(1);
  var_0.origin = (0, 0, 500);
  var_0._id_12F91 = int(1);
  var_0.classname = "_encstr_A3DC1337B14ED2E047BE6E8E27EA1BA3AFA12B63D2";
  var_0.script_accel = int(20);
  var_0.speed = int(100);
  level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_96550BC6AEB91D7BDA99C8060E"] = [var_0];
}

weapon_xp_iw8_sm_victor() {
  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(!isDefined(level.spawn_points))
    return _encstr_A39824FFD7C234188B1A3A6970CE4FB72B1FEC33032D33FE0F60C9CF6B2D7107706705929B82::getspawnpoint();

  return scripts\engine\utility::random(level.spawn_points);
}

weapon_xp_iw8_sn_mike14(var_0) {
  thread scripts\cp\helicopter\chopper_boss::spawnplayer_internal(0);
}

weapon_xp_iw8_sn_hdromeo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  scripts\cp\cp_laststand::enter_camera_zoomout();

  if(istrue(var_0.fauxdead)) {
    var_0.fauxdead = undefined;
    var_0 scripts\cp\cp_laststand::enter_bleed_out(var_0);
    var_0 scripts\cp\cp_laststand::playslamzoomflash();
  } else
    scripts\cp\cp_laststand::camera_zoomout(var_0, var_1, undefined);

  scripts\cp\cp_laststand::exit_camera_zoomout();

  if(!isDefined(level.players_in_respawn_queue))
    level.players_in_respawn_queue = [];

  level.players_in_respawn_queue = scripts\engine\utility::array_add(level.players_in_respawn_queue, var_0);
  var_12 = 0;
  var_13 = undefined;

  foreach(var_15 in level.players) {
    if(var_15.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D")
      var_12++;
  }

  if(var_12 == level.players.size - 1) {
    foreach(var_15 in level.players) {
      if(var_15.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D")
        continue;
    }
  }

  foreach(var_15 in level.players) {
    if(!istrue(level.player_cam_disable)) {
      level.player_cam_disable = 1;

      foreach(var_15 in level.players)
      var_15.respawn_active = 0;
    }
  }

  for(;;) {
    var_23 = var_0 scripts\engine\utility::_id_143AD("_encstr_956C0F7507A3AF90D73D46BBA5A9186DCB", "_encstr_ADDB0D9B2D4B28E08312533B3AFF20");

    if(isDefined(var_23)) {
      if(istrue(var_0.binc130)) {
        continue;
      }
      if(var_23 == "_encstr_ADDB0D9B2D4B28E08312533B3AFF20") {
        foreach(var_15 in level.players)
        var_15 thread scripts\cp\cp_hud_message::showsplash("_encstr_ADDB0D9B2D4B28E08312533B3AFF20");
      } else {}

      level.players_in_respawn_queue = scripts\engine\utility::array_remove(level.players_in_respawn_queue, var_0);
      return 1;
    }
  }
}

_id_124A6() {
  _encstr_A39824FFD7C234188B1A3A6970CE4FB72B1FEC33032D33FE0F60C9CF6B2D7107706705929B82::givedefaultloadout();
  self setsuit("_encstr_AB6C0C1784D2171608824D4727A0");
  var_0 = "_encstr_860A13D377F001473B198BB1524F86D0FCFD37A318";
  var_1 = ["_encstr_81AC0B6EB76BD36233901AF2F8", "_encstr_A97B0FED234D201C59AB629CDF2D6190B8", "_encstr_8B7208D9AA51B88FA2D7", "_encstr_B40D0D5DCA27691A66DAFAB015A4BB", "_encstr_871816834BCD47B78D3B4E5A078198BEDCC643582763B459", "_encstr_93A30DAA99286F1B96F19FDBD14BA2", "_encstr_B256149C59991BACE1AFEEB2DC1D0313EB969CDBDCDC", "_encstr_88270B9BE59120260B9BFD6343", "_encstr_BD0B10AF3C9D588AF7C143499A973E98B485"];
  var_2 = scripts\cp\cp_weapon::buildweapon(var_0, var_1, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 0);
  self giveweapon(var_2);
  self setweaponammoclip(var_2, weaponclipsize(var_2));
  self setweaponammostock(var_2, weaponmaxammo(var_2));
  self switchtoweapon(var_2);
  var_3 = "_encstr_925D13A28841F9E728B06A7FB1514FE8B74A497A18";
  var_1 = ["_encstr_99AC12C22FD3578C4F18C389E0B705C7A82B1F28", "_encstr_87700A95EFFAF0F80536F8F0", "_encstr_A25012CFB5FB4B3A48102DF96B607D524099060A", "_encstr_B40415CE39B40ECE95C91DE04EDE7D9CBDD6ACED709B18", "_encstr_AF0C1633FA3740778FCA90A0E3A5213E2B9F49BD4FD2A339", "_encstr_96B00D7A4D62E63535C8332F5A5272", "_encstr_85F51126836A5FF8FE3779E8CF05F18FC7FB3F"];
  var_4 = scripts\cp\cp_weapon::buildweapon(var_3, var_1, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 0);
  self giveweapon(var_4);
  self setweaponammoclip(var_4, weaponclipsize(var_4));
  self setweaponammostock(var_4, weaponmaxammo(var_4));
  thread scripts\cp\cp_powers::givepower("_encstr_8E910FA7E764B78317A2C973305A28B33B", "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, 4);
  thread scripts\cp\cp_powers::givepower("_encstr_B81D0C38EDBB56C9F599B12CDC34", "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, 4);
  self.weaponlist = self getweaponslistprimaries();
  thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0], 1);

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0]))
    self.primaryweaponobj = self.weaponlist[0];

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1]))
    self.secondaryweaponobj = self.weaponlist[1];

  self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 0);
  thread hostagetemppistol();
  level.hostdamagefactorlow++;
  level notify("_encstr_B23015932F806D6F4E8B5A521711B76060BD2B1763E8B3");
}

_id_1247B(var_0) {}

rundebugstartobjective(var_0) {
  wait 2;
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");

  if(isDefined(level.objectivestabledata[var_0])) {
    var_1 = level.objectivestabledata[var_0];

    if(isDefined(var_1.ondebugstartfunc))
      [[var_1.ondebugstartfunc]](var_1);

    thread scripts\cp\cp_objectives::run_objective(var_1.objname, var_1.questtype);
  }
}

onplayerspawneddevguisetup(var_0) {
  var_1 = var_0.name;
  var_2 = undefined;

  foreach(var_5, var_4 in level.players) {
    if(var_4 == var_0) {
      var_2 = int(var_5);
      break;
    }
  }

  if(isDefined(var_2))
    var_0 thread setupdevguientries(var_0, var_1, var_2);
}

setupdevguientries(var_0, var_1, var_2) {}

wait_for_pre_game_period() {
  if(!isDefined(level.agent_funcs))
    level.agent_funcs = [];

  wait 0.2;
}

wait_for_strike_init_complete() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_init("_encstr_9B931F0EAC279B7BB916D87D95B9A3EB4FB7CDAC9BF52D9B968E4BB01B964F598C");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD")) {
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
    var_0 = getDvar("_encstr_A70910FF7B8AE9B6DB23D098BA9FE0C0E5D5");
    var_1 = undefined;

    switch (var_0) {
      case "_encstr_91CC11D3C3F9EA1AC8BE04606377DA1C3FF361":
        break;
      default:
        break;
    }
  }
}

registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("_encstr_B16824CBD3E6A3A018F1A199A729F8692B074B573F5AF5199C57E910CD192813325B5DE78F03");
  scripts\mp\agents\soldier\soldier_agent::registerscriptedagent();
  scripts\mp\agents\juggernaut\juggernaut_agent::registerscriptedagent();
}

onplayerconnect(var_0) {}

onplayerspawned() {}

bug_test_move_startpoint() {
  if(getdvarint("_encstr_829910CF5E203138B80B9FF8309F40F9FFA4", 0)) {
    var_0 = scripts\engine\utility::getStructArray("_encstr_977415C0B27F2B43438C503F7C9F0AFBA2B9C0C86A1249", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_2 in var_0) {
      var_2.origin = (3743, -1008, 384);
      var_2.angles = (6, 265, 0);
    }
  }
}

should_run_event(var_0) {
  return 0;
}

setup_map_specific_devgui() {}

interaction_trigger_properties(var_0, var_1, var_2) {
  switch (var_1.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(var_1.useduration))
        self.interaction_trigger setuseholdduration(var_1.useduration);

      break;
  }
}

setup_create_script() {
  level.threadedscriptspawners = 1;
  level.create_script_file_ids = [];
  level.cs_scripted_spawners = [];
  level.scripted_spawners = [];
  level.cs_scripted_spawners_triggers = [];
  level.scripted_spawners_triggers = [];
  level.cs_scripted_spawners_models = [];
  level.scripted_spawners_models = [];
  level.createscriptfilesinitialized = 0;
  level.scripted_spawner_func_strings = [];
  level.scripted_spawner_map_strings = [];
  level.scripted_spawner_func = [];
  register_create_script_arrays("_encstr_97341E2383EF73C7EF3B8103A1A3BA4DBF58BFE663E5C7A0C526DB91D382B335", "_encstr_97341E2383EF73C7EF3B8103A1A3BA4DBF58BFE663E5C7A0C526DB91D382B335", level.scripted_spawner_func.size, _encstr_82FA42EB26DB379261188E42E83F0DCF33960F73C706171D0F9B920A78E9C5D78B7587EB5FAEEF2567289A0210C13D6FE3ED6F63F631EF2BCB31A36AB03BB2A3F044CB1B::main);
}

register_create_script_arrays(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0))
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = var_0;

  if(isDefined(var_1))
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = var_1;

  if(isDefined(var_2))
    level.create_script_file_ids[var_0] = "_encstr_8A0703D983" + var_2;

  if(isDefined(var_3))
    level.scripted_spawner_func[level.scripted_spawner_func.size] = var_3;
}

_id_12DF6() {
  if(isDefined(level._id_13AC6[self.team]))
    self thread[[level._id_13AC6[self.team]]]();
}

_id_14379() {
  while(!isDefined(level.players) || level.players.size < 1)
    wait 1;

  wait 3;
  scripts\cp\laser_traps\cp_laser_traps::_id_1437A();
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\engine\utility::flag_set("_encstr_B457128F6887433F83FFC9E9287313EB579B1097");
}

hostagetemppistol() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self._id_14389 = 1;
  waitframe();
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("_encstr_83AB065EE1391A7B", 640, 480);
  var_0.alignx = "_encstr_A5AD056A019C63";
  var_0.aligny = "_encstr_AC190479FF92";
  var_0.sort = 1;
  var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.alpha = 1;
  var_0.foreground = 1;
  var_0.lowresbackground = 1;
  var_1 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self playerlinktoabsolute(var_1);
  self setmovespeedscale(0);
  scripts\engine\utility::flag_wait("_encstr_B457128F6887433F83FFC9E9287313EB579B1097");
  var_0 fadeovertime(1);
  var_0.alpha = 0.0;
  wait 0.3;
  self unlink();
  completepayloadpunish(1, 1);
  wait 1;

  if(isDefined(var_0))
    var_0 destroy();

  var_1 delete();
}

infil_player_allow(var_0) {
  if(self ishost() && getdvarint("_encstr_9677144F98CBD71A4DA4C4BDAF5FC3B5B1487FDB6063") == 1) {
    scripts\common\utility::allow_weapon(var_0, "_encstr_9B8F06A38D72C380");
    return;
  }

  scripts\common\utility::allow_movement(var_0, "_encstr_9B8F06A38D72C380");
  scripts\common\utility::allow_prone(var_0, "_encstr_9B8F06A38D72C380");
  scripts\common\utility::allow_crouch(var_0, "_encstr_9B8F06A38D72C380");
  scripts\common\utility::allow_jump(var_0, "_encstr_9B8F06A38D72C380");
  scripts\common\utility::allow_fire(var_0, "_encstr_9B8F06A38D72C380");
  scripts\common\utility::allow_ads(var_0, "_encstr_9B8F06A38D72C380");
  scripts\common\utility::allow_sprint(var_0, "_encstr_9B8F06A38D72C380");
  scripts\common\utility::allow_melee(var_0, "_encstr_9B8F06A38D72C380");
  scripts\common\utility::allow_reload(var_0, "_encstr_9B8F06A38D72C380");
  scripts\common\utility::allow_lean(var_0, "_encstr_9B8F06A38D72C380");
  scripts\common\utility::allow_slide(var_0, "_encstr_9B8F06A38D72C380");
  scripts\common\utility::allow_offhand_weapons(var_0, "_encstr_9B8F06A38D72C380");
  scripts\common\utility::allow_weapon_switch(var_0, "_encstr_9B8F06A38D72C380");
  scripts\common\utility::allow_usability(var_0, "_encstr_9B8F06A38D72C380");
  scripts\common\utility::allow_script_weapon_switch(var_0, "_encstr_9B8F06A38D72C380");
}

init_flags() {
  scripts\engine\utility::flag_init("_encstr_B457128F6887433F83FFC9E9287313EB579B1097");
  scripts\engine\utility::flag_init("_encstr_BA7D12FF558AF7092F8F20B05F7CA1CDA33A65F5");
  scripts\engine\utility::flag_init("_encstr_999618C61338F9A23A3723EFA9D3A93930DE3ACD6BB8945AB77D");
  scripts\engine\utility::flag_init("_encstr_A36F0EC4EDDAC4AFB20F3836F623B246");
  scripts\engine\utility::flag_init("_encstr_A351129D304AFBA87F936890CFA7803312DD0595");
  scripts\engine\utility::flag_init("_encstr_867B0EE53B248B71FEB05BCAFB1B617F");
}

stopstreamtomovingplane() {
  level.cpvehiclename = [];

  foreach(var_1 in ["_encstr_8A7F06F0C07A9183", "_encstr_93960DC627AAC7013B43D84918DF40", "_encstr_B6CC0586B28D96"]) {
    var_2 = scripts\engine\utility::getStruct("_encstr_A2FC0BCAED597B2160D37C75A7" + var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2.set_relic_landlocked = scripts\engine\utility::getStructArray("_encstr_BD3D0FECEAB09C91BE6E0E85BB73B2C9BE" + var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2.keypad_damagedeathdisconnectwatch = scripts\engine\utility::getStructArray("_encstr_8EC710919533BACD957D6E072C77CD2BE4AF" + var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2.name = var_1;
    var_2.blend_movespeedscale_cpso = [];
    var_2 thread _id_13F77();
    level.cpvehiclename[var_1] = var_2;
  }
}

_id_13F77() {
  for(;;) {
    waitframe();

    if(self.blend_movespeedscale_cpso.size > 0)
      self.blend_movespeedscale_cpso = scripts\engine\utility::array_removedead(self.blend_movespeedscale_cpso);
  }
}

store_platform_models() {
  level.current_checkpoint = 0;
  level.bombs = [];
  level.bombs[level.bombs.size] = _id_1350B((-1222.5, 2396.75, 3.25), (0, -277.936, 0), "_encstr_8A7F06F0C07A9183");
  level.bombs[level.bombs.size] = _id_1350B((1030.25, 1982, 318), (0, 86.6868, 0), "_encstr_B6CC0586B28D96");
  level.bombs[level.bombs.size] = _id_1350B((-655.25, -2000.5, 125.75), (0, 339.723, 0), "_encstr_93960DC627AAC7013B43D84918DF40");
}

stoppingpower_clearhcronperkscleared() {
  scripts\cp\laser_traps\cp_laser_traps::stopinteract();

  foreach(var_1 in scripts\engine\utility::getStructArray("_encstr_BD3508CD07B0BB7356E4", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"))
  var_1.spawn_functions = [];

  thread _id_135BA();
}

cqb_laser_guy() {
  foreach(var_1 in level.cpvehiclename) {
    scripts\cp\laser_traps\cp_laser_traps::array_spawn_function(var_1.set_relic_landlocked, ::_id_133A7, var_1);
    scripts\cp\laser_traps\cp_laser_traps::array_spawn_function(var_1.keypad_damagedeathdisconnectwatch, ::_id_133A7, var_1);
    var_2 = [];

    foreach(var_4 in var_1.set_relic_landlocked) {
      if(scripts\engine\utility::array_contains_key(var_2, var_4.script_type)) {
        var_2[var_4.script_type][var_2[var_4.script_type].size] = var_4;
        continue;
      }

      var_2[var_4.script_type] = [var_4];
    }

    var_6 = [];
    var_7 = rear_minigun_speed();

    while(var_6.size < var_7) {
      var_8 = 0;

      for(var_9 = 1; var_6.size < var_7 && var_9; var_8++) {
        var_9 = 0;

        foreach(var_11 in var_2) {
          if(var_8 < var_11.size) {
            var_6[var_6.size] = var_11[var_8];
            var_9 = 1;

            if(var_6.size >= var_7) {
              break;
            }
          }
        }
      }
    }

    var_1.blend_movespeedscale_cpso = scripts\cp\laser_traps\cp_laser_traps::can_spawn_extras(var_6);
    var_1 thread _id_133A9();
  }
}

_id_133A7(var_0) {
  if(!isDefined(self.target)) {
    self setgoalpos(var_0.origin);
    self.goalradius = var_0.radius;
  }

  if(issubstr(self.agent_type, "_encstr_9A190463ADB3") || issubstr(self.agent_type, "_encstr_A11904E483B3"))
    self.disablepistol = 1;

  self endon("_encstr_AD75063D571AE108");

  while(!istrue(var_0.bomb.defused)) {
    foreach(var_2 in level.players) {
      if(distance2dsquared(var_2.origin, var_0.origin) < 2250000)
        self getenemyinfo(var_2);
    }

    waitframe();
  }

  self.goalradius = 500;
  var_4 = 0;

  for(;;) {
    if(isDefined(self.enemy) && isalive(self.enemy) && isPlayer(self.enemy) && !self.enemy.inlaststand)
      var_2 = self.enemy;
    else
      var_2 = race_set_checkpoint();

    if(!isDefined(var_2)) {
      break;
    }

    childthread getcash(var_2);
    var_5 = 5;
    var_6 = gettime();
    scripts\engine\utility::waittill_notify_or_timeout("_encstr_86E5092BA829F7AB738DA4", var_5);

    if(scripts\engine\utility::time_has_passed(var_6, var_5)) {
      var_4 = 0;
      continue;
    }

    var_4++;

    if(var_4 >= 10 && distancesquared(self.origin, var_2.origin) > 1000000) {
      break;
    }
  }

  for(;;) {
    var_7 = 1;

    foreach(var_2 in level.players) {
      if(scripts\engine\utility::within_fov(var_2 getEye(), var_2 getgunangles(), self.origin, 0)) {
        var_7 = 0;
        break;
      }
    }

    if(var_7) {
      scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
      return;
    }

    waitframe();
  }
}

_id_133A9() {
  thread _id_133A8();
  var_0["_encstr_B42E085325A82CB3F221"] = [];
  var_0["_encstr_B69B0589C236B6"] = [];
  var_0["_encstr_A5AD056A019C63"] = [];
  var_0["_encstr_8253060E2B5FE330"] = [];
  var_1 = self.bomb.origin;
  var_2 = anglesToForward(self.bomb.angles);
  var_3 = anglestoright(self.bomb.angles);
  var_4 = [];

  if(self.name == "_encstr_8A7F06F0C07A9183")
    var_4 = [(-1749.25, 2316.25, 93.5), (-1749.5, 2372.25, 93.5)];

  foreach(var_6 in self.keypad_damagedeathdisconnectwatch) {
    if(scripts\engine\utility::array_contains(var_4, var_6.origin)) {
      self.keypad_damagedeathdisconnectwatch = scripts\engine\utility::array_remove(self.keypad_damagedeathdisconnectwatch, var_6);
      var_4 = scripts\engine\utility::array_remove(var_4, var_6.origin);
      continue;
    }

    var_7 = scripts\engine\utility::flatten_vector(var_6.origin - var_1);
    var_8 = vectordot(var_7, var_2);
    var_9 = undefined;

    if(var_8 >= 0.5)
      var_9 = "_encstr_B42E085325A82CB3F221";
    else if(var_8 <= -0.5)
      var_9 = "_encstr_B69B0589C236B6";

    if(!isDefined(var_9)) {
      var_10 = vectordot(var_7, var_3);

      if(var_10 >= 0.5)
        var_9 = "_encstr_8253060E2B5FE330";
      else
        var_9 = "_encstr_A5AD056A019C63";
    }

    var_0[var_9][var_0[var_9].size] = var_6;
  }

  var_13 = getarraykeys(var_0);
  var_9 = scripts\engine\utility::random(var_13);
  var_14 = scripts\engine\utility::array_remove(var_13, var_9);
  self.bomb waittill("_encstr_8F5C086405E70FBA4B4A");
  var_15 = 0;
  var_16 = 0;

  while(!istrue(self.bomb.defused)) {
    waitframe();

    if(istrue(self._id_13E14)) {
      continue;
    }
    if(var_16 >= var_15) {
      if(self.blend_movespeedscale_cpso.size > 4 || qm_intro_dialogue() - self.blend_movespeedscale_cpso.size < 4) {
        wait 5;
        continue;
      }

      var_15 = qm_intro_dialogue() - self.blend_movespeedscale_cpso.size;
      var_16 = 0;
    }

    var_17 = scripts\engine\utility::array_randomize(var_0[var_9]);

    if(var_17.size) {
      var_18 = 0;

      for(var_19 = 0; var_19 < 4 && var_16 < var_15 && self.blend_movespeedscale_cpso.size < qm_intro_dialogue(); var_19++) {
        if(istrue(self._id_13E14)) {
          waitframe();
          var_19--;
          continue;
        }

        var_18 = questenabled(var_17, var_18);

        if(!isDefined(var_18)) {
          break;
        }

        var_6 = var_17[var_18];
        var_20 = var_6 _id_12980();

        if(isDefined(var_20) && isalive(var_20)) {
          var_16++;

          if(isDefined(var_6.script_count)) {
            if(!isDefined(var_6.spawned))
              var_6.spawned = [var_20];
            else
              var_6.spawned[var_6.spawned.size] = var_20;
          }

          self.blend_movespeedscale_cpso[self.blend_movespeedscale_cpso.size] = var_20;
          wait(reaper_waitingformissilereload());
          var_18++;
        }
      }
    }

    var_9 = scripts\engine\utility::random(var_14);
    var_14 = scripts\engine\utility::array_remove(var_14, var_9);

    if(!var_14.size)
      var_14 = scripts\engine\utility::array_combine(var_13);
  }
}

_id_133A8() {
  self.bomb waittill("_encstr_8F5C086405E70FBA4B4A");
  self._id_13E14 = 1;
  var_0 = 0;
  var_1 = scripts\engine\utility::random(getEntArray("_encstr_B8B50E13DEE66EEBE68358BBDC954EBE" + self.name, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));

  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getStruct("_encstr_B8B50E13DEE66EEBE68358BBDC954EBE" + self.name, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_0 = 1;
  } else
    var_0 = scripts\engine\utility::getStructArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").size;

  while(getaiarray("_encstr_8E8405EA382B2A").size + var_0 > 48)
    waitframe();

  if(isstruct(var_1)) {
    var_2 = [var_1 scripts\cp\laser_traps\cp_laser_traps::spawn_ai()];
    var_2[0] thread vehicle_occupancy_clearallowmovementplayer(self);
  } else {
    var_3 = var_1 scripts\common\vehicle::spawn_vehicle_and_gopath();
    waitframe();
    var_2 = var_3.riders;

    switch (self.name) {
      case "_encstr_B6CC0586B28D96":
        level.players _id_1243D("_encstr_B8892C622A88A732A8872B298B50B1FFCF8D5A5A13F59FEC20F95133B783832FEE1E0273DBC71764A8D55707E32A", 5, undefined, 1);
        var_3 thread silo_thrust_platforms(self);
        var_3 scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_AD75063D571AE108", scripts\engine\utility::flag_set, "_encstr_A351129D304AFBA87F936890CFA7803312DD0595");
        var_3.driver scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_AD75063D571AE108", scripts\engine\utility::flag_set, "_encstr_A351129D304AFBA87F936890CFA7803312DD0595");
        _id_11E5C("_encstr_AB6614D8F6CAA30914FFE0603F5081F982D1C6500AF3", undefined, "_encstr_8D0D182AB6E0083F4DB702F0EF798B97E4B31BFBB8A7E68B6D7A", "_encstr_8E8405EA382B2A", var_3, 15, "_encstr_A351129D304AFBA87F936890CFA7803312DD0595", 0, 0);
        break;
      case "_encstr_8A7F06F0C07A9183":
        var_3 nonbunkerdoors();
        var_3 thread _id_13DD3();
        break;
    }
  }

  self.blend_movespeedscale_cpso = scripts\engine\utility::array_combine(self.blend_movespeedscale_cpso, var_2);
  self._id_13E14 = undefined;
}

siteusedinternal() {
  nonbunkerdoors();
  self.script_disconnectpaths = 0;
  self._id_12307 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  self._id_12307 setModel("_encstr_A32F27DBCBCB7FA798C0FD09F980B241915D43FF85E0B140304B320D70D0EDAAE0D1A377399C7A1A28");
  self._id_12307 linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, -73), (0, 0, 0));
  _id_13B33(::heli_crash_on_pilot_death);
  var_0 = undefined;

  foreach(var_2 in scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF")) {
    if(!isDefined(var_2.script_type)) {
      var_0 = var_2;
      break;
    }
  }

  thread scripts\common\vehicle::vehicle_paths(var_0);
  var_4 = createnavbadplacebybounds((-483.75, -1444, 187.375), (180, 30, 130), (0, 0, 0));
  scripts\engine\utility::waittill_either("_encstr_BD82096B5DA4B07F924F29", "_encstr_AD75063D571AE108");
  destroynavobstacle(var_4);

  if(!isalive(self)) {
    self._id_12307 delete();
    return;
  }

  scripts\engine\utility::waittill_either("_encstr_AC26197DFDCE88BB1FC296F9FBDBE72064539FF161F39868277A09", "_encstr_AD75063D571AE108");
  self._id_12307 delete();
}

_id_13DD3() {
  self.godmode = 1;

  while(!scripts\common\vehicle_code::vehicle_is_stopped())
    waitframe();

  self.godmode = 0;
  self waittill("_encstr_AD75063D571AE108");
  var_0 = self.origin;
  var_1 = self.angles;
  waitframe();

  if(isDefined(self.riders))
    scripts\engine\utility::array_call(self.riders, ::delete);

  self delete();
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2 setModel("_encstr_85151FF315D2501E1DF8E16FF5F549E975553A35B73F31F8FB339B215781B98738");
  var_2.angles = var_1;
  var_2 show();
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_3.angles = var_1;
  var_4 = getEnt("_encstr_AC210F4B5AA7A07D22A7290F2309B6684C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 clonebrushmodeltoscriptmodel(var_4);
  var_3 disconnectPaths();
}

isplayeronground() {
  level.players[0] notifyonplayercommand("_encstr_ACD50C4393A893C9F180FAD2D02F", "_encstr_A9E60828803C73F11780");

  while(self.godmode)
    level.players[0] waittill("_encstr_ACD50C4393A893C9F180FAD2D02F");

  self dodamage(99999999, self.origin);
}

_id_13B33(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self childthread[[var_0]]();
}

vehicle_occupancy_clearallowmovementplayer(var_0) {
  level.players _id_1243D("_encstr_8BBD211D484F98D966B1D8F81B7DCF305FFF1405BA63C1EB0BD9682822D55B2E3773AD", 5, undefined, 1);
  setmusicstate("_encstr_9B03144F77D1D2ABE76911ABFD69D8B3E17F3E2B7E28");
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_8B7205D9ED5958");
  self.goalradius = 2000;
  thread _id_12809();

  for(;;) {
    if(isDefined(self.enemy)) {
      self getenemyinfo(self.enemy);
      self setgoalpos(self.enemy.origin);
      wait 1;
      continue;
    }

    var_1 = race_set_checkpoint(var_0);

    if(!isDefined(var_1)) {
      waitframe();
      continue;
    }

    self getenemyinfo(var_1);
    self setgoalpos(var_1.origin);
    wait 1;
  }
}

_id_12809() {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(level.juggernauts))
    level.juggernauts = [];

  level.juggernauts[level.juggernauts.size] = self;
  thread vehicle_mp_deletenextframelate();
  childthread juggernaut_pain_cooldown();
  self.stuncooldown = 0;
  self.allowpain = 0;
  self.minpaindamage = 1000;
  self.minpainvalue = 1000;
  self.og_maxsightdistsqr = self.maxsightdistsqrd;
  self.og_maxvis = self.maxvisibledist;
  self.og_radius = self.juggernautgoalradius;
  self.runcooldown = 2000;
  self.cautiousnavigation = 0;
  self.juggernautwalkdist = 250;
  self.juggernautgoalradius = 25;
  self.goalheight = 25;
  self.juggernautacceleration = 100;
  self.juggernautcanseeenemydelaymin = 500;
  self.juggernautcanseeenemydelaymax = 1000;
  self.juggernautrundelaymin = 250;
  self.juggernautrundelaymax = 750;
  scripts\cp\laser_traps\cp_laser_traps::disable_surprise();

  if(level.gameskill <= 2)
    self.juggernautstopdistance = 500;
  else
    self.juggernautstopdistance = 600;

  _id_1333A();
}

vehicle_mp_deletenextframelate() {
  if(!isalive(self)) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!istrue(self.allowpain)) {
      if(isDefined(var_9) && getweaponbasename(var_9) == "_encstr_88A906570DDE7B21")
        self.allowpain = 1;
    }

    if(var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_4 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_4 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421") {
      if(istrue(self.allowpain) && (!isDefined(var_9) || !scripts\engine\utility::is_equal(var_9.basename, "_encstr_88A906570DDE7B21")))
        self notify("_encstr_951A0D38ED58580F37D17055136ABF");

      self.minpaindamage = 0;

      if(isDefined(var_1) && isPlayer(var_1)) {
        var_10 = var_0 / 2;

        if(var_10 < 50)
          var_10 = 50;
        else if(var_10 > 150)
          var_10 = 100;
      } else
        var_10 = 25;

      self dodamage(var_10, var_3, var_1);
      self.minpaindamage = self.minpainvalue;
    }
  }
}

juggernaut_pain_cooldown() {
  for(;;) {
    self waittill("_encstr_951A0D38ED58580F37D17055136ABF");
    self.stuncooldown = 1;
    self.allowpain = 0;
    wait 7;
    self.stuncooldown = 0;
    self.allowpain = 1;
  }
}

isgunlessweapon() {}

silo_thrust_platforms(var_0) {
  level.silo_thrust_dogtag_revive = self;
  self endon("_encstr_AD75063D571AE108");
  nonbunkerdoors();
  childthread isgunlessweapon();
  childthread heli_crash_on_pilot_death();
  childthread heli_damage_monitor();
  childthread heli_damage_monitor(self.driver);
  childthread skipfirstraise(self.driver);
  var_1 = "_encstr_859B0CB3D94487E548C7786C9FBA";
  var_2 = (30, -11.511, 4);
  var_3 = self gettagorigin(var_1);
  self.minigun = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_3, "_encstr_848A1D0187AAB9ABC57012BA182DD7EDF86FD5C0C7183D477BC9BA02467623");
  self.minigun.angles = self gettagangles(var_1);
  self.minigun setModel("_encstr_AB941C74699CD92047B045DF89932839900CE0D293E9DA7F34D38382FAB3");
  self.minigun linkTo(self, var_1, var_2, (6, 0, 0));
  self.minigun makeunusable();
  self.minigun setmode("_encstr_849007B268BD03DFD8");
  self.minigun setdefaultdroppitch(0);
  self.minigun setleftarc(180);
  self.minigun setrightarc(180);
  self.minigun settoparc(180);
  self.minigun setbottomarc(180);
  self.minigun setturretteam("_encstr_8E8405EA382B2A");
  self.turret_pointer = scripts\engine\utility::spawn_script_origin();
  self.minigun settargetentity(self.turret_pointer);
  self.linked_ents = [self.minigun];
  thread scripts\engine\utility::delete_on_death(self.minigun);
  thread scripts\engine\utility::delete_on_death(self.turret_pointer);
  childthread heli_movement();
  var_4 = 1;

  for(;;) {
    if(istrue(var_4)) {
      var_5 = race_set_checkpoint(var_0);
      var_4 = undefined;
    } else
      var_5 = race_set_checkpoint(var_0, 1);

    if(!isDefined(var_5)) {
      wait 0.1;
      continue;
    }

    self setlookatent(var_5);

    if(!callback_trigger(self.target_player, var_5))
      self notify("_encstr_BE8512EEFF08A8A5D3CB412FC3376FF80BA0793B");

    self.target_player = var_5;
    single_loop(var_5);
    wait 0.1;
  }
}

nonbunkerdoors() {
  self setvehicleteam("_encstr_8E8405EA382B2A");
  self.script_team = "_encstr_8E8405EA382B2A";
  self.godmode = 0;
  self.script_bulletshield = 0;
  self setCanDamage(1);
  self vehicleshowonminimap(1);
  self aiupdatecoverexposetype(1);
  _id_1333A();
}

_id_1333A() {
  self.objindex = scripts\cp\cp_objectives::requestworldid("_encstr_97B4051FB0E8F7" + self getentitynumber(), 5);
  objective_setplayintro(self.objindex, 0);
  objective_setplayoutro(self.objindex, 0);
  objective_setownerteam(self.objindex, "_encstr_8E8405EA382B2A");
  objective_state(self.objindex, "_encstr_930B07BB1B6B3854FF");

  if(issubstr(self.model, "_encstr_951007814D5B63F807"))
    objective_icon(self.objindex, "_encstr_8D0D182AB6E0083F4DB702F0EF798B97E4B31BFBB8A7E68B6D7A");
  else if(issubstr(self.model, "_encstr_B8B407A3E4DEADACDE"))
    objective_icon(self.objindex, "_encstr_855D11A58DBDDCEB5BA5E62DB685E0AF168E9D");
  else
    objective_icon(self.objindex, "_encstr_A13718BF3A67AAB7F81C98731DB6A7E7E8FFC9A45D6042F90BC9");

  objective_setlocation(self.objindex, 0, self);
  thread laser_sights(self.objindex, "_encstr_97B4051FB0E8F7" + self getentitynumber());
}

laser_fx(var_0) {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_0))
    setheadiconimage(var_0);
}

laser_sights(var_0, var_1) {
  self waittill("_encstr_AD75063D571AE108");
  scripts\cp\cp_objectives::freeworldid(var_1);
  objective_state(var_0, "_encstr_8267056410C669");
}

ispubliceventoftypeactive() {
  for(;;) {
    var_0 = rotatevectorinverted(self.minigun gettagorigin("_encstr_A14F0AE336178944BA076F41") - self.origin, self.angles);
    var_1 = self.origin + rotatevector(var_0, self.angles);
    waitframe();
  }
}

heli_movement() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_A7FB130B3AE8856C6DEB1A561B5A7D373A27ABC61D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self.initlocs_nonmorsephones = undefined;
  self.player_closes_in = 1;

  for(;;) {
    if(!isDefined(self.target_player)) {
      waitframe();
      continue;
    }

    if(istrue(self.player_closes_in)) {
      var_1 = 60;
      self.player_closes_in = undefined;
    } else {
      var_2 = scripts\engine\utility::ter_op(isDefined(self._id_124CA), 20, 10);
      var_1 = clamp(distance(self.origin, self.initlocs_nonmorsephones.origin) / 5, var_2, 40);
    }

    self.initlocs_nonmorsephones = printer(var_0, self.target_player);
    skip_soldier_spawn(self.initlocs_nonmorsephones.origin, var_1);

    if(!isDefined(self._id_124CA)) {
      scripts\engine\utility::_id_143BA(randomfloatrange(3, 5), "_encstr_BE8512EEFF08A8A5D3CB412FC3376FF80BA0793B", "_encstr_AB150F388D165E9539BED8B7BDB6B437B3");
      continue;
    }

    if(radiussq()) {
      wait 2;
      continue;
    }

    var_3 = level scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_82D311381B16E5594EAF33964EB2C8FAC90776", 0.8);

    if(var_3 == "_encstr_82D311381B16E5594EAF33964EB2C8FAC90776" && radiussq())
      wait 2;
  }
}

radiussq() {
  foreach(var_1 in level.players) {
    if(istrue(var_1.inlaststand) || !isDefined(var_1.waittill_drone_timeout)) {
      continue;
    }
    if(scripts\engine\utility::time_has_passed(var_1.waittill_drone_timeout["_encstr_84EF055338A18F"], 0.4)) {
      continue;
    }
    var_2 = vectorNormalize(self.origin - var_1.waittill_drone_timeout["_encstr_97FE07DE392D76D2CD"]);
    var_3 = anglesToForward(var_1.waittill_drone_timeout["_encstr_A7610758E6CED8569B"]);
    var_4 = scripts\engine\math::anglebetweenvectors(var_2, var_3);

    if(var_4 < 45)
      return 1;
  }

  return 0;
}

printer(var_0, var_1) {
  if(isDefined(self.milestonephasepercent_lzs)) {
    var_2 = sortbydistance(var_0, self.milestonephasepercent_lzs.origin);
    var_3 = var_2[var_2.size - 1];
    self.milestonephasepercent_lzs = undefined;
    return var_3;
  }

  var_4 = [];
  var_5 = [];

  foreach(var_3 in sortbydistance(var_0, var_1.origin)) {
    var_7 = distance2dsquared(var_3.origin, var_1.origin);

    if(var_7 > 4000000) {
      break;
    }

    if(var_7 < 1000000) {
      continue;
    }
    if(scripts\engine\utility::is_equal(var_3, self.initlocs_nonmorsephones)) {
      continue;
    }
    var_5[var_5.size] = var_3;
    var_8 = rotatevectorinverted(self.minigun gettagorigin("_encstr_A14F0AE336178944BA076F41") - self.origin, self.angles);
    var_9 = vectortoangles(scripts\engine\utility::flatten_vector(var_1.origin - var_3.origin));
    var_10 = var_3.origin + rotatevector(var_8, var_9);

    if(scripts\engine\trace::ray_trace_passed(var_10, var_1.origin + (0, 0, 20), scripts\engine\utility::array_combine(level.players, [self, self.minigun])))
      var_4[var_4.size] = var_3;

    waitframe();

    if(var_4.size > 3) {
      break;
    }
  }

  if(var_4.size)
    return scripts\engine\utility::random(var_4);

  return scripts\engine\utility::random(var_5);
}

skip_soldier_spawn(var_0, var_1) {
  self notify("_encstr_82060DF843732090CDAFBFF90323E9");
  self endon("_encstr_82060DF843732090CDAFBFF90323E9");
  var_2 = findpath3d(self.origin, var_0);

  if(!isDefined(var_2)) {
    iprintlnbold("_encstr_81DB3239ED10E6856733C804C82CA3C202CCDE4E40D059B19624404295D8960833D8BCA573EC0477A563B110132B0113584640C5");
    return;
  }

  var_3 = 0;
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 37);
  self vehicle_setspeed(var_1, var_1 * 0.5, var_1 * 0.5);

  foreach(var_6, var_5 in var_2) {
    if(var_6 == var_2.size - 1)
      var_3 = 1;

    self setvehgoalpos(var_5, var_3);
    scripts\engine\utility::_id_143A5("_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_8B7205D9ED5958");
  }

  self notify("_encstr_A5B309CD79E00F3AF0838B");
}

single_loop(var_0) {
  for(var_1 = 0; var_1 < 3 && siteused(var_0); var_1++) {
    var_2 = 0;
    var_3 = gettime() + 2000;

    while(gettime() < var_3) {
      var_4 = var_0.origin + (0, 0, 20);
      self.turret_pointer.origin = var_4;
      var_5 = self.minigun gettagorigin("_encstr_A14F0AE336178944BA076F41");
      var_6 = self.minigun gettagangles("_encstr_A14F0AE336178944BA076F41");

      if(scripts\engine\utility::within_fov(var_5, var_6, var_4, 0.99)) {
        var_2 = 1;
        break;
      }

      wait 0.1;

      if(!siteused(var_0))
        return;
    }

    if(!var_2) {
      return;
    }
    self.minigun startbarrelspin();
    var_7 = 200;
    self.turret_pointer moveTo(var_0.origin + anglesToForward(var_0.angles) * var_7, 2, 1, 1);
    wait 2;

    for(var_8 = 0; var_8 < 30; var_8++) {
      if(var_7 > 0)
        var_7 = var_7 - 20;

      self.turret_pointer moveTo(var_0.origin + anglesToForward(var_0.angles) * var_7 + (0, 0, 20), 0.1, 0.05, 0.05);
      self.minigun shootturret();
      wait 0.1;

      if(!siteused(var_0)) {
        break;
      }
    }

    self.minigun stopbarrelspin();
    wait 1;
  }
}

siteused(var_0) {
  if(!isalive(var_0))
    return 0;

  if(var_0.inlaststand)
    return 0;

  if(isDefined(self.attacker))
    return 0;

  return 1;
}

heli_damage_monitor(var_0) {
  if(!isDefined(var_0))
    var_0 = self;

  if(var_0 != self)
    var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(var_0 == self && isDefined(var_10) && var_10.basename == "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8") {
      waitframe();

      if(!scripts\common\vehicle::vehicle_is_crashing())
        self dodamage(self.health - self.healthbuffer + 1, self.origin);
    }

    if(!isPlayer(var_2)) {
      continue;
    }
    self.attacker = var_2;
  }
}

skipfirstraise(var_0) {
  if(!isDefined(var_0))
    var_0 = self;

  if(var_0 != self)
    var_0 endon("_encstr_AD75063D571AE108");

  var_1 = cos(15);

  for(;;) {
    var_2 = undefined;

    foreach(var_4 in level.players) {
      var_5 = var_4 getEye();
      var_6 = var_4 getgunangles();
      var_7 = anglesToForward(var_6);

      if(scripts\engine\utility::within_fov(var_5, var_6, var_0.origin, var_1)) {
        var_8 = vectorNormalize(var_0.origin - var_5) * 150;

        if(sighttracepassed(var_5, var_0.origin - var_8, 0, var_4)) {
          var_2 = var_4;
          break;
        }

        waitframe();
      }
    }

    if(!isDefined(self._id_124CA) && isDefined(var_2) || isDefined(self._id_124CA) && !isDefined(var_2)) {
      if(isDefined(var_2))
        self notify("_encstr_AB150F388D165E9539BED8B7BDB6B437B3", var_2);

      self._id_124CA = var_2;
    }

    wait 0.2;
  }
}

callback_trigger(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1))
    return 1;

  return scripts\engine\utility::is_equal(var_0, var_1);
}

heli_crash_on_pilot_death() {
  self.driver waittill("_encstr_AD75063D571AE108");

  if(scripts\common\vehicle::vehicle_is_crashing()) {
    return;
  }
  self dodamage(self.health - self.healthbuffer + 1, self.origin);
}

race_set_checkpoint(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self.attacker)) {
    var_2 = self.attacker;
    self.attacker = undefined;
  } else if(isDefined(self._id_124CA))
    var_2 = self._id_124CA;
  else if(isDefined(var_0) && !istrue(var_0.bomb.defused)) {
    if(isDefined(var_0.bomb.playerusing) && (!istrue(var_1) || _id_124BF(var_0.bomb.playerusing)))
      var_2 = var_0.bomb.playerusing;
    else
      var_2 = progression_deadzone(var_0.bomb.origin, var_1);
  } else
    var_2 = progression_deadzone(self.origin, var_1);

  return var_2;
}

progression_deadzone(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!isalive(var_4) || var_4.inlaststand) {
      continue;
    }
    if(istrue(var_1) && !_id_124BF(var_4)) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  var_4 = scripts\engine\utility::getclosest(var_0, var_2);
  return var_4;
}

_id_124BF(var_0) {
  var_1 = var_0 getEye();
  var_2 = level.players;

  if(isent(self))
    var_2 = scripts\engine\utility::array_add(var_2, self);

  if(isDefined(self.linked_ents))
    var_2 = scripts\engine\utility::array_combine(var_2, self.linked_ents);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_1 + (0, 0, 256), var_2))
    return 1;

  waitframe();
  return scripts\engine\trace::ray_trace_passed(var_1, self.origin, var_2);
}

questenabled(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  while(!isDefined(var_2)) {
    if(!isDefined(var_3))
      var_3 = var_1;
    else if(var_3 % var_0.size == var_1 % var_0.size) {
      break;
    }

    var_4 = var_0[var_1 % var_0.size];

    if(isDefined(var_4.script_count) && isDefined(var_4.spawned)) {
      var_4.spawned = scripts\engine\utility::array_removedead_or_dying(var_4.spawned);

      if(var_4.spawned.size >= var_4.script_count) {
        var_1++;
        continue;
      }
    }

    if(!istrue(var_4.script_forcespawn) && (scripts\engine\utility::get_array_of_closest(var_4.origin, level.players, undefined, undefined, 500).size || var_4 c130airdrop_dropcrates())) {
      var_1++;
      continue;
    }

    var_2 = var_1 % var_0.size;
  }

  return var_2;
}

c130airdrop_dropcrates() {
  var_0 = [self.origin + (0, 0, 18), self.origin + (0, 0, 72), self.origin + rotatevector((0, 10, 0), self.angles) + (0, 0, 60), self.origin + rotatevector((0, -10, 0), self.angles) + (0, 0, 60)];

  foreach(var_2 in level.players) {
    var_3 = var_2 getEye();
    var_4 = var_2 getgunangles();

    foreach(var_6 in var_0) {
      if(scripts\engine\utility::within_fov(var_3, var_4, var_6, 0)) {
        if(sighttracepassed(var_3, var_6, 0, var_2))
          return 1;

        waitframe();
        var_3 = var_2 getEye();
        var_4 = var_2 getgunangles();
      }
    }
  }

  return 0;
}

rear_minigun_speed() {
  switch (level.players.size) {
    case 2:
    case 1:
      return 4;
    default:
      return 8;
  }
}

qm_intro_dialogue() {
  switch (level.players.size) {
    case 2:
    case 1:
      switch (level.current_checkpoint) {
        case 0:
          return 4;
        case 1:
          return 8;
        default:
          return 12;
      }
    default:
      switch (level.current_checkpoint) {
        case 0:
          return 8;
        case 1:
          return 12;
        default:
          return 16;
      }
  }
}

reaper_waitingformissilereload() {
  switch (level.current_checkpoint) {
    case 0:
      return 1;
    case 1:
      return 0.5;
    default:
      return 0.25;
  }
}

_id_13548(var_0) {
  while(!scripts\engine\utility::get_array_of_closest(var_0.origin, level.players, undefined, undefined, 500).size)
    waitframe();

  thread _id_1354B();
  level scripts\engine\utility::thread_on_notify("_encstr_A39A0FD3BBC734F8399ED04BB85B53303F", ::_id_1354B);
  var_1 = scripts\engine\utility::getStructArray("_encstr_A3CD0EAFF8F12982F7F64A06DCAD2AFA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\engine\utility::array_thread(var_1, scripts\cp\laser_traps\cp_laser_traps::add_spawn_function, ::onentercallback);

  for(var_2 = 0; !scripts\engine\utility::flag("_encstr_867B0EE53B248B71FEB05BCAFB1B617F"); var_2++) {
    switch (var_2) {
      case 0:
        if(level.players.size > 2)
          var_3 = 8;
        else
          var_3 = 4;

        break;
      case 1:
        if(level.players.size > 2)
          var_3 = 12;
        else
          var_3 = 8;

        break;
      default:
        if(level.players.size > 2)
          var_3 = 16;
        else
          var_3 = 12;

        break;
    }

    var_4 = [];

    while(var_4.size < var_3) {
      for(var_5 = 0; var_5 < var_1.size && var_4.size < var_3; var_5++) {
        var_6 = var_1[var_5];
        var_7 = scripts\engine\utility::getclosest(var_6.origin, level.players);

        if(distancesquared(var_7.origin, var_6.origin) < 250000) {
          continue;
        }
        if(!var_6 c130airdrop_dropcrates()) {
          var_8 = var_6 _id_12980();

          if(isDefined(var_8))
            var_4[var_4.size] = var_8;
        }

        waitframe();
      }

      waitframe();
    }

    while(var_4.size > level.players.size) {
      wait 1;
      var_4 = scripts\engine\utility::array_removedead_or_dying(var_4);
    }
  }
}

_id_1354B() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_8E0A198540A3109991EAF86012379D4817D59510A323D9E78562D8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\engine\utility::array_thread(var_0, scripts\cp\laser_traps\cp_laser_traps::add_spawn_function, ::onentercallback);
  scripts\engine\utility::array_thread(var_0, scripts\cp\laser_traps\cp_laser_traps::add_spawn_function, ::_id_12809);
  var_1 = scripts\engine\utility::ter_op(level.players.size > 2, 2, 1);
  var_2 = 0;

  if(!isDefined(level.juggernauts))
    level.juggernauts = [];

  foreach(var_4 in level.juggernauts) {
    if(isalive(var_4))
      var_2++;
  }

  if(var_2 >= var_1) {
    return;
  }
  if(var_1 - var_2 > 1)
    level.players _id_1243D("_encstr_A91D2B09B869A08F7F59C8B1420FD0683E3491E75D0BF9DA0FB241395BDBF78013AF3751F1B33893BBAA5EAB67", 2);
  else
    level.players _id_1243D("_encstr_B19C2319F0BE5B83C27DC95DD163F5C9BA3B31E5D7593795AD5EF5D863F6DCCAAFCEED85C6", 2);

  setmusicstate("_encstr_9B03144F77D1D2ABE76911ABFD69D8B3E17F3E2B7E28");

  while(var_2 < var_1) {
    foreach(var_7 in var_0) {
      if(!var_7 c130airdrop_dropcrates()) {
        var_8 = var_7 _id_12980();

        if(isDefined(var_8))
          var_2++;

        if(var_2 >= var_1) {
          break;
        }
      }
    }

    wait 2;
  }
}

_id_1354A() {
  level waittill("_encstr_859C0D852852E3A077AF1070BB6579");
  var_0 = [];

  if(isDefined(level.silo_thrust_dogtag_revive) && isalive(level.silo_thrust_dogtag_revive)) {
    level.silo_thrust_dogtag_revive scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_AD75063D571AE108", scripts\engine\utility::flag_set, "_encstr_A351129D304AFBA87F936890CFA7803312DD0595");
    var_0[0] = level.silo_thrust_dogtag_revive;
  } else {
    var_1 = scripts\common\utility::getvehiclespawner("_encstr_A9431253BFF346E9C02007E35009C659D0180350", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = var_1 scripts\common\vehicle::spawn_vehicle_and_gopath();
    var_0[0] = var_2;
    waitframe();
    level.players _id_1243D("_encstr_9A892CEAE0D9489808171C0A102EC00BE16B7375E7331E52826AC8564703C3C70AA7790569823F482380C7FF9B1B", 2, undefined, 1);
    var_2 thread silo_thrust_platforms();
    var_2 scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_AD75063D571AE108", scripts\engine\utility::flag_set, "_encstr_A351129D304AFBA87F936890CFA7803312DD0595");
  }

  _id_11E5C("_encstr_93DD0FF626A6B2B1E82D9D95BEC4B7CD37", &"_encstr_9B292180BF18F76D396F919E6BA92557A6B5DEC8057A675639239EA547317F53C5ADE1", "_encstr_B4B922700AE59DAE9731EB6707D7B06141C39880423E21A15F54FB5DF42B196F769AB868", "_encstr_8E8405EA382B2A", var_0, undefined, "_encstr_A351129D304AFBA87F936890CFA7803312DD0595");
}

_id_11CF2() {
  if(isalive(self))
    self waittill("_encstr_AD75063D571AE108");

  level._id_13A86++;
}

onentercallback() {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(self.target)) {
    self.goalradius = 1000;
    var_0 = scripts\engine\utility::getStruct("_encstr_AC0703695B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    self setgoalpos(var_0.origin);
  }

  if(issubstr(self.agent_type, "_encstr_9A190463ADB3") || issubstr(self.agent_type, "_encstr_A11904E483B3"))
    self.disablepistol = 1;
}

_id_135BA() {
  level.spawn_queue = [];

  for(;;) {
    wait 0.1;

    if(level.spawn_queue.size) {
      var_0 = level.spawn_queue[0];
      var_1 = var_0 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
      var_0 notify("_encstr_BA350853C128FB939DB9", var_1);
      level.spawn_queue = scripts\engine\utility::array_remove(level.spawn_queue, var_0);
    }
  }
}

_id_12980() {
  level.spawn_queue[level.spawn_queue.size] = self;
  self waittill("_encstr_BA350853C128FB939DB9", var_0);
  return var_0;
}

getcash(var_0, var_1) {
  self notify("_encstr_85131172152337995CF9DF8739C1E9A2FC7B8B");
  self endon("_encstr_85131172152337995CF9DF8739C1E9A2FC7B8B");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_1))
    var_1 = 1;

  for(;;) {
    self setgoalpos(var_0.origin);
    wait(var_1);
  }
}

target_play_death_anim() {
  var_0 = squared(300);
  var_1 = gettime();
  var_2 = 1;

  while(var_2) {
    foreach(var_4 in level.players) {
      if(distance2dsquared(var_4.origin, (-1050, 514, 0)) < var_0) {
        continue;
      }
      var_2 = 0;
      break;
    }

    waitframe();
  }

  scripts\cp\laser_traps\cp_laser_traps::_id_13067();
  setomnvar("_encstr_959613C61CF5C6DBBACD478CDEDDB9BEB1BD36B74E", 0);
  var_6 = [330, 330, 330, 330];
  level._id_13B8B = var_6[level.players.size - 1];
  setomnvar("_encstr_BDBA0E36077D77C26795EB1D2DADB293", gettime() + int(level._id_13B8B * 1000));
  setomnvar("_encstr_85C50D39532F76301B2EF18F464378", 1);
  var_7 = level._id_13B8B;
  level._id_13B88 = 1;

  while(level._id_13B8B > 0 && !scripts\engine\utility::flag("_encstr_BA7D12FF558AF7092F8F20B05F7CA1CDA33A65F5")) {
    level notify("_encstr_932E0BEB7BC2350379B9637E43");

    if(level._id_13B8B <= 30) {
      foreach(var_4 in level.players) {
        if(level._id_13B8B > 20) {
          var_4 playSound("_encstr_B61216E504A9835B0F9B0850A75AF6D7F2ABD0EDDF424F40");
          continue;
        }

        if(level._id_13B8B > 10) {
          var_4 playSound("_encstr_A9B919BAA5F5B507D7E8A56BCA4EBEB1F6EACD8E23DBDDE6AF2603");
          continue;
        }

        if(level._id_13B8B > 5) {
          var_4 playSound("_encstr_88981FAE96AF5B83EB474B6B5693BE36B75737A332DEBB37F586C21B66AF6EB21B");
          continue;
        }

        if(level._id_13B8B > 1.5) {
          var_4 playSound("_encstr_962A22AB96EBDA07BEE85AD6AC9CFAD8B7D5B947C8BDEEB9FA17BA8539E89593F5B9B28D");
          continue;
        }

        var_4 playSound("_encstr_B6AF180B8909B0EFAF8BE810E26330885D0DB5B12CED983887F7");
      }
    }

    setomnvar("_encstr_959613C61CF5C6DBBACD478CDEDDB9BEB1BD36B74E", level._id_13B8B <= 30);
    wait 1;
    var_10 = 1;

    if(var_10)
      level._id_13B8B--;
  }

  thread little_bird_mg_initcollision();

  if(scripts\engine\utility::flag("_encstr_BA7D12FF558AF7092F8F20B05F7CA1CDA33A65F5")) {
    return;
  }
  level endon("_encstr_BA7D12FF558AF7092F8F20B05F7CA1CDA33A65F5");
  bombs_explode();
}

little_bird_mg_initcollision() {
  setomnvar("_encstr_85C50D39532F76301B2EF18F464378", 0);
  level._id_13B88 = 0;

  for(var_0 = 0; var_0 < 30; var_0++) {
    wait 0.05;
    setomnvar("_encstr_BDBA0E36077D77C26795EB1D2DADB293", gettime() + int(level._id_13B8B * 1000));
  }

  setomnvar("_encstr_959613C61CF5C6DBBACD478CDEDDB9BEB1BD36B74E", 0);
}

init_player() {
  var_0 = self;
  var_0.maxvisibledist = 2000;
  var_0 thread _id_14481();

  foreach(var_3, var_2 in level.bombs)
  objective_addclienttomask(var_3, var_0);

  var_0 thread spawn_backup_helispawner_jammer2();
  wait 2;
  scripts\cp\laser_traps\cp_laser_traps::_id_124A5(var_0, ["_encstr_A3990BDBEF05B561FA5A488BD8", "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38"][level.infil_lbravo_is_alive]);
  level.infil_lbravo_is_alive = !level.infil_lbravo_is_alive;
}

_id_14481() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_0);

    if(isDefined(var_0) && var_0.basename == "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8") {
      self.waittill_drone_timeout = [];
      self.waittill_drone_timeout["_encstr_84EF055338A18F"] = gettime();
      self.waittill_drone_timeout["_encstr_97FE07DE392D76D2CD"] = self getEye();
      self.waittill_drone_timeout["_encstr_A7610758E6CED8569B"] = self getplayerangles();
      level notify("_encstr_82D311381B16E5594EAF33964EB2C8FAC90776", self);
    }
  }
}

spawn_backup_helispawner_jammer2() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
}

give_auto_revive() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.has_auto_revive = 1;

  while(istrue(self.has_auto_revive)) {
    self waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
    wait 0.1;

    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      scripts\cp\cp_laststand::instant_revive(self);

      if(isDefined(self.dogtag))
        self.dogtag delete();
    }
  }
}

stoppingpowercanonehitkill(var_0) {
  var_1 = self;
  var_2 = "_encstr_8DBB0ADE4CA6BE4CF66B31FA" + var_0;

  if(var_0 == 0)
    objective_setdescription(var_0, &"_encstr_A1771B201FB857CDD98F717ECB098537C6D57E68E59AC73659837E053B");

  var_3 = scripts\cp\cp_objectives::requestworldid(var_2, 3);
  objective_setlabel(var_3, &"_encstr_97851F04A9D703D14FD90B03DFA5197937B6DC6DB07FCDF157E53F0B379E393FB7");
  objective_setplayintro(var_3, 1);
  objective_setplayoutro(var_3, 0);
  objective_position(var_3, var_1.origin + (0, 0, 12));
  objective_state(var_3, "_encstr_AF5A081BBAC993AC73A3");
  var_4 = ["_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556"];

  if(var_3 < var_4.size)
    objective_icon(var_3, var_4[var_0]);
  else
    objective_icon(var_3, "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556");

  wait 0.5;
}

logevent_xpearned() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(scripts\engine\utility::flag("_encstr_BA7D12FF558AF7092F8F20B05F7CA1CDA33A65F5")) {
    return;
  }
  level waittill("_encstr_932E0BEB7BC2350379B9637E43");
  self.timer = scripts\cp\utility::createtimer("_encstr_B8B209842D94DB0579ECFC", 1.5);
  self.timer scripts\cp\utility::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, -180);
  self.timer settimer(level._id_13B8B);
  self.timer.color = (1, 1, 1);
  self.timer.archived = 0;
  self.timer.foreground = 1;
}

init_fx() {
  level._effect["_encstr_B2831A1BBDDE077D31BDAD4CD732B2665DDC581BBE2B0F83D8F63256"] = loadfx("_encstr_8437344B1910FF5A7CB1C73F4908A2E77B6389D6D0407AF1DD135B7F77C79A6F90C9F811E9F80D1AB83B2B63A1F81391B050E5A3C118");
  level._effect["_encstr_96E312CEF2423DB91BCF72E8C6CA48039B6765AA"] = loadfx("_encstr_A68A3CEC993CE5D2EE70E51B2BD9AC3697072D6C1B0B46A536B1F2E567CCC3F5E096B1BEAC87838DB7BEDCD5B46C2D3295FA13DE6B13FA959B8CC53BCCC3");
}

subway_black_screen_fade_in() {
  level.mini_map_origin_fix = [];
  level.mini_map_origin_fix["_encstr_B68F0858F533E4F6DC47"] = [(-636, -1284, 0), (0, 50, 0)];
  level.mini_map_origin_fix["_encstr_AF3D0CA139EA68AD9C1738188947"] = [(-1792, 564, 0), (0, -25, 0)];
  level.mini_map_origin_fix["_encstr_A9F3096ED14EACACA3BE62"] = [(-774, 1885, 0), (0, -131, 0)];
  level.mini_map_origin_fix["_encstr_8CF3099B4BEA395BCB5166"] = [(141, 1364, 0), (0, -27, 0)];
  level.mini_map_origin_fix["_encstr_B8470AFE951BADCB39BFA008"] = [(669, -471, 0), (0, 240, 0)];
  level.mini_map_origin_fix["_encstr_81410D8339CA08FD9BB111B8EAB7AB"] = [(-476, 502, 0), (0, -25, 0)];
  level.bombs[0].minigun_attack_min_cooldown = ["_encstr_A9F3096ED14EACACA3BE62", "_encstr_81410D8339CA08FD9BB111B8EAB7AB", "_encstr_AF3D0CA139EA68AD9C1738188947", "_encstr_B8470AFE951BADCB39BFA008", "_encstr_8CF3099B4BEA395BCB5166", "_encstr_B68F0858F533E4F6DC47"];
  level.bombs[1].minigun_attack_min_cooldown = ["_encstr_8CF3099B4BEA395BCB5166", "_encstr_81410D8339CA08FD9BB111B8EAB7AB", "_encstr_B8470AFE951BADCB39BFA008", "_encstr_AF3D0CA139EA68AD9C1738188947", "_encstr_B68F0858F533E4F6DC47", "_encstr_A9F3096ED14EACACA3BE62"];
  level.bombs[2].minigun_attack_min_cooldown = ["_encstr_B68F0858F533E4F6DC47", "_encstr_81410D8339CA08FD9BB111B8EAB7AB", "_encstr_B8470AFE951BADCB39BFA008", "_encstr_AF3D0CA139EA68AD9C1738188947", "_encstr_A9F3096ED14EACACA3BE62", "_encstr_8CF3099B4BEA395BCB5166"];
}

takeplayerweaponaway() {}

init_fan_blades(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = spawnStruct();
  var_11.classname = "_encstr_A3DC1337B14ED2E047BE6E8E27EA1BA3AFA12B63D2";
  var_11.targetname = var_0;
  var_11.target = var_1;
  var_11.origin = var_2;
  var_11.angles = var_3;
  var_11.speed = scripts\engine\utility::ter_op(isDefined(var_4), var_4, int(100));
  var_11.script_accel = scripts\engine\utility::ter_op(isDefined(var_5), var_5, int(20));
  var_11.script_decel = scripts\engine\utility::ter_op(isDefined(var_6), var_6, int(20));
  var_11.radius = scripts\engine\utility::ter_op(isDefined(var_7), var_7, int(400));
  var_11.script_goalyaw = scripts\engine\utility::ter_op(isDefined(var_8), var_8, 1);
  var_11.lookahead = scripts\engine\utility::ter_op(isDefined(var_9), var_9, 1);
  var_11._id_12F91 = scripts\engine\utility::ter_op(isDefined(var_8), var_8, 1);
  level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_0] = [var_11];
  return var_11;
}

superslotcleanup() {
  if(getdvarint("_encstr_82BE108B3E9A1156425FE1B7B7FA14782C92", 0) == 1) {
    if(scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
      scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");

    return;
  }

  scripts\cp\infilexfil\lbravo_infil_cp::initanims("_encstr_BDBB0616C6C186C2");
  var_0 = [];
  var_0[0] = [0, 1];
  var_0[1] = [2, 3];
  var_0[2] = [4];
  var_0[3] = [5];
  level.prematchperiod = 10;
  var_1 = init_fan_blades("_encstr_BD600AF3EA2BC368F3890531", "_encstr_A6A7060EB0A34362", (6000, 2000, 1000), (0, 45, 0));
  init_fan_blades("_encstr_A6A7060EB0A34362", "_encstr_95A70663A82BC08F", (3000, 0, 800), (0, 45, 0));
  init_fan_blades("_encstr_95A70663A82BC08F", "_encstr_B4A706C0DAFB03FE", (0, 0, 300), (0, 90, 0));
}

_id_1357F(var_0) {
  var_1 = spawnVehicle("_encstr_B85414BCDF02F19615D70899DF390B87EA86364F732A", "_encstr_99D313C93D5C98D566EC39CA2AABF097A81837CB36", "_encstr_85DC1042C9BE0F13E827C9C67DF0DDAF6EE3", var_0.origin, var_0.angles);
  return var_1;
}

switchespaused() {
  _id_1238E("_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1", (-1055, 375, 102), (-14, 90, 0));
  _id_1238E("_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1", (-1015, 377, 102), (-14, 90, 0));
  _id_1238E("_encstr_87131233FF6A6649CD69F8E07265AB9326AF4937", (-951, 518.75, 91.5), (279.099, 89.9925, -100.98));
  _id_1238E("_encstr_87131233FF6A6649CD69F8E07265AB9326AF4937", (-965.5, 519.75, 91), (279.099, 89.9925, -100.98));
  _id_1238E("_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8", (-1022, 625.5, 90.625), (-65, 90, 90));
  _id_1238E("_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8", (-1011, 625.5, 90.625), (-65, 90, 90));
  scripts\cp\laser_traps\cp_laser_traps::_id_13433((-951.75, 577.5, 107.125), (0, 98, 0));
  scripts\cp\laser_traps\cp_laser_traps::player_limitedammo((-975, 557.25, 73), (0, 86, 0));
  scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime((-957.5, 537.25, 105.125), (0, 250, 0));
  scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback((-951, 471.75, 107.125), (0, 86, 0));
  scripts\cp\laser_traps\cp_laser_traps::handle_leads_collected_hideiconbuilding((-965, 492.5, 73), (0, 75, 0));
  scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled((-975, 457.5, 73), (0, 95, 0));
  scripts\cp\laser_traps\cp_laser_traps::_id_11CB8((-952.5, 432.25, 107.125), (0, 110, 0));
}

teamanchoredinfoomnvars() {
  _id_135F6((-975, 616, 72), (0, 25, 0), "_encstr_A3990BDBEF05B561FA5A488BD8");
  _id_135F6((-975, 415, 72), (0, -25, 0), "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38");
}

switch_weapon_from_minigun() {
  foreach(var_1 in getEntArray("_encstr_85FE0DD5727A27098513298817CA23", "_encstr_AC110A7F14873B5B3D073009")) {
    if(var_1.origin[2] == -32) {
      var_1 delete();
      break;
    }
  }

  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1006.75, -2239, 123.75));
  var_3.angles = (0, 3.998, 0);
  var_4 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 clonebrushmodeltoscriptmodel(var_4);
}

weapon_xp_iw8_sn_crossbow() {
  level scripts\cp\cp_hud_message::init_cp_hud_message();
  switch_weapon_from_minigun();
  init_flags();
  stopstreamtomovingplane();
  init_fx();
  superslotcleanup();
  level.ignorescoring = 1;
  _id_14379();
  store_platform_models();
  subway_black_screen_fade_in();
  stoppingpower_clearhcronperkscleared();
  switchespaused();
  teamanchoredinfoomnvars();
  level.custom_player_hotjoin_func = ::init_player;
  level.infil_lbravo_is_alive = 0;

  foreach(var_1 in level.players)
  var_1 thread init_player();

  thread target_play_death_anim();
  setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 1);
  setomnvar("_encstr_879619BFBB89C890E2D7F913FCC69068E33735BFC2D18338042F82", 2);

  foreach(var_5, var_4 in level.bombs)
  var_4 thread stoppingpowercanonehitkill(var_5);

  thread cqb_laser_guy();
  thread _id_11B3E();
  level thread get_drone_movement_vector();

  while(level.current_checkpoint < level.bombs.size)
    level waittill("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C");

  scripts\engine\utility::flag_set("_encstr_BA7D12FF558AF7092F8F20B05F7CA1CDA33A65F5");
  setomnvar("_encstr_879619BFBB89C890E2D7F913FCC69068E33735BFC2D18338042F82", 6);
  var_6 = scripts\engine\utility::getStruct("_encstr_AC0703695B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread _id_13548(var_6);
  _id_11E5C("_encstr_8D1C0DED89A959B13AA5EC2BBE1B4F", &"_encstr_AB7724459157B9055FF7BF845D7CB9650EDF4618A69568FBC99F3365DE9DF04CFB2431C4123B", undefined, "_encstr_9A8507BA4040188D08", undefined, var_6.origin + (0, 0, 15), "_encstr_867B0EE53B248B71FEB05BCAFB1B617F");
  thread friendly_dmg_text_cooldown(var_6);
  level waittill("_encstr_859C0D852852E3A077AF1070BB6579");
  wait 60;

  if(isDefined(level.silo_thrust_dogtag_revive) && isalive(level.silo_thrust_dogtag_revive)) {
    thread logevent_munitionused(&"_encstr_85EF263BD981AABF28E780F80D8B8793496BDF4F95716747755CE9F05675939F61D137CB31E1BE5B", 15);
    level.silo_thrust_dogtag_revive waittill("_encstr_AD75063D571AE108");
  }

  thread _id_13549();
  level waittill("_encstr_81FE11037FEB66A887751E91DD7D981162939B");
  level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
}

friendly_dmg_text_cooldown(var_0) {
  var_0 _id_11A9A(&"_encstr_82F11BC0FB877927C6EA4D466154F5CD9969C696A953185FDF380B2928");
  var_1 = getgroundposition(var_0.origin, 1);
  magicgrenademanual("_encstr_A9AF1246CAC1367B2FAF0B969CC8C9DB07AFD683", var_1, (0, 0, 0), 0.01);
  level notify("_encstr_859C0D852852E3A077AF1070BB6579");
}

_id_13549() {
  var_0 = scripts\common\utility::getvehiclespawner("_encstr_BA2A0B59C3994B8DAF0DAC364B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = undefined;

  foreach(var_3 in scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF")) {
    if(isDefined(var_3.script_type)) {
      continue;
    }
    var_1 = var_3;
    break;
  }

  var_5 = 0;

  while(isDefined(var_1.target)) {
    var_1 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5++;

    switch (var_5) {
      case 5:
      case 4:
        var_1.origin = var_1.origin + (0, 0, 50);
        break;
    }
  }

  var_6 = var_0 scripts\common\vehicle::spawn_vehicle_and_gopath();

  if(isDefined(var_6) && isDefined(var_6.riders)) {
    foreach(var_8 in var_6.riders)
    var_8.ignoreme = 1;
  }

  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6.origin);
  var_10 setModel("_encstr_A32F27DBCBCB7FA798C0FD09F980B241915D43FF85E0B140304B320D70D0EDAAE0D1A377399C7A1A28");
  var_10 linkTo(var_6, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, -73), (0, 0, 0));
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6.origin);
  var_11 dontinterpolate();
  var_11.angles = var_6.angles;
  var_11 linkTo(var_6);
  var_12 = getEnt("_encstr_BE620F3FA9DC43E3C1CADFEBECE95EB7F8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_11 clonebrushmodeltoscriptmodel(var_12);
  var_13 = anglestoright(var_6.angles) * 64;
  var_14 = anglestoright(var_6.angles) * -64;
  var_15 = anglesToForward(var_6.angles) * 64;
  var_16 = anglesToForward(var_6.angles) * -64;
  _id_11A87(var_6, var_13 + var_15);
  _id_11A87(var_6, var_14 + var_15);
  _id_11A87(var_6, var_13 + var_16);
  _id_11A87(var_6, var_14 + var_16);
  level notify("_encstr_A39A0FD3BBC734F8399ED04BB85B53303F");
  _id_11E5C("_encstr_8BC8103776908F37FB6B742B917B48B53F75", &"_encstr_BAF9238682F535F47DA90A9154903D559A1597E99094541A5194B215F5428A6292EB6212C4", "_encstr_B4B922700AE59DAE9731EB6707D7B06141C39880423E21A15F54FB5DF42B196F769AB868", "_encstr_9A8507BA4040188D08", var_6, undefined, "_encstr_81FE11037FEB66A887751E91DD7D981162939B", 1, 0);
  waitframe();
  level.should_do_damage_check_func = ::_id_132C0;
  scripts\engine\utility::flag_wait("_encstr_867B0EE53B248B71FEB05BCAFB1B617F");
  thread logevent_munitionused(&"_encstr_A2501E5FF1E07907B95766BF8D595F515E6366833304B1CFC15FE97706C19178", 15);

  for(;;) {
    var_17 = [];

    foreach(var_19 in level.players) {
      if(var_19.inlaststand || distance2dsquared(var_19.origin, var_6.origin) > 40000) {
        continue;
      }
      var_17[var_17.size] = var_19;
    }

    if(var_17.size > 0 && isDefined(level.waittill_any_timeout_3) && scripts\engine\utility::time_has_passed(level.players, 10)) {
      scripts\engine\utility::random(var_17) scripts\cp\cp_player_battlechatter::dosound("_encstr_BD720EA70D981947EB11722A1EC88FCF");
      level.waittill_any_timeout_3 = gettime();
    }

    if(var_17.size == level.players.size) {
      break;
    }

    waitframe();
  }

  level notify("_encstr_81FE11037FEB66A887751E91DD7D981162939B");
}

_id_11A87(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin + var_1);
  var_2 dontinterpolate();
  var_2.angles = var_0.angles;
  var_2 linkTo(var_0);
  var_3 = getEnt("_encstr_92FE106AF8010BC5E2D6FA976E239B4BEDDD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 clonebrushmodeltoscriptmodel(var_3);
}

_id_132C0(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_5.team == "_encstr_9A8507BA4040188D08")
    return 0;

  return 1;
}

_id_11A9A(var_0) {
  if(!isDefined(self.origin)) {
    return;
  }
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_1 endon("_encstr_AD75063D571AE108");
  var_1.isusable = 1;
  var_1 setCursorHint("_encstr_BA110C6847D07307ADF8103C97A0");
  var_1 sethintdisplayfov(360);
  var_1 setusefov(135);
  var_1 sethintdisplayrange(500);
  var_1 setuserange(80);
  var_1 sethintonobstruction("_encstr_BD1805CB69C063");
  var_1 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_1 sethintlockplayermovement(1);
  var_1 makeusable();
  var_1 setHintString(var_0);
  var_1.userate = 1;
  var_1.laststandfinisherdone = 4;
  var_1.curprogress = 0;
  var_1.usetime = 5;
  var_1.inuse = 0;
  var_1.playerusing = undefined;
  var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
  var_1 delete();
}

_id_11E5C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  thread _id_11E5D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_11E5D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = scripts\cp\cp_objectives::requestworldid(var_0, 3);

  if(isDefined(var_1))
    objective_setlabel(var_9, var_1);

  objective_state(var_9, "_encstr_AF5A081BBAC993AC73A3");

  if(!isDefined(var_2))
    var_2 = "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD";

  objective_icon(var_9, var_2);

  if(isDefined(var_3))
    objective_setownerteam(var_9, var_3);

  if(isDefined(var_4)) {
    if(!isarray(var_4))
      var_4 = [var_4];

    var_10 = 0;

    foreach(var_12 in var_4) {
      objective_setlocation(var_9, var_10, var_12);

      if(isDefined(var_5))
        objective_setzoffset(var_9, var_5);

      var_10++;
    }
  } else if(isDefined(var_5))
    objective_position(var_9, var_5);

  if(!isDefined(var_7))
    var_7 = 1;

  if(!isDefined(var_8))
    var_8 = 1;

  objective_setplayintro(var_9, var_7);
  objective_setplayoutro(var_9, var_8);
  level waittill(var_6);
  objective_state(var_9, "_encstr_8267056410C669");
}

propinputwatch(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(istrue(var_3.spectating) || istrue(var_3.inlaststand)) {
      continue;
    }
    var_1[var_1.size] = var_3.origin;
  }

  if(var_1.size == 0)
    return scripts\engine\utility::random(level.mini_map_origin_fix);

  var_5 = averagepoint(var_1);
  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in level.mini_map_origin_fix) {
    if(isDefined(var_0) && var_0[0] == var_9[0]) {
      continue;
    }
    var_10 = distance2dsquared(var_5, var_9[0]);

    if(!isDefined(var_6) || var_10 > var_6) {
      var_6 = var_10;
      var_7 = var_9;
    }
  }

  return var_7;
}

projdistsq(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = self.origin;

  var_2 = undefined;
  var_3 = undefined;

  foreach(var_7, var_5 in var_1) {
    var_6 = distance2dsquared(var_0, var_5[0]);

    if(!isDefined(var_2) || var_6 < var_2) {
      var_2 = var_6;
      var_3 = var_7;
    }
  }

  return var_3;
}

get_drone_movement_vector() {
  for(var_0 = 0; var_0 < 3; var_0++) {
    level waittill("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C", var_1, var_2);
    thread minigameinfo(var_1, var_2, 2, 1);
    thread minigameinfo(var_1, var_2, 5);
  }
}

minigameinfo(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_2);
  var_4 = undefined;
  var_5 = undefined;

  for(var_6 = 0; var_6 < var_0.minigun_attack_min_cooldown.size; var_6++) {
    var_4 = var_0.minigun_attack_min_cooldown[var_6];

    if(!istrue(level.mini_map_origin_fix[var_4]["_encstr_834F0CF3726B5728B10FB272D7D8"])) {
      var_5 = level.mini_map_origin_fix[var_4];
      break;
    }
  }

  if(!isDefined(var_5)) {
    thread logevent_munitionused(&"_encstr_8BA121B7395693307766864F4561085D7F098E4F592F3D8923161CB65C93C11484F9BF", 3);
    return;
  }

  level.players _id_1243D("_encstr_BE9821E9C3D191A851E173EB533499DFEA43514D07CB70C07A4499807FEC5018833FDB", 1, 30);

  if(!istrue(var_3)) {
    var_7 = [ &"_encstr_A77E2386287D4DF4FA4D50641542E9AA4D2AF20D822515A00A1A2D0A7454FA114A7A28F582", &"_encstr_AB7E2390AF08E77D491F818E5B9935A756A5EE18156677628127F3916729C92B7E9C91419D", &"_encstr_997E23E3B776D7452F11901859F98D072F95075BA7BFF7DA3BB9386061CBF11BA768E0CFCE", &"_encstr_917E23B6486777BFF1193909105CC7CF3FC5183EF18B7D49AE20714928272F2583A72F880C"];
    var_8 = var_7[var_0.objindex];
    thread logevent_munitionused(var_8, 3);
  }

  level.mini_map_origin_fix[var_4]["_encstr_834F0CF3726B5728B10FB272D7D8"] = 1;
  level childthread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(8000, 20000, var_5[1], var_5[0] + (0, 0, 1000), undefined, ::weapon_xp_iw8_sn_sbeta);
}

voqueue() {}

logevent_munitionused(var_0, var_1) {
  foreach(var_3 in level.players)
  thread logevent_kidnapevent(var_3, var_0, var_1);
}

logevent_kidnapevent(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_B85508B0DFF33FD00BEF");
  var_0 endon("_encstr_B85508B0DFF33FD00BEF");
  var_0 clearhudtutorialmessage();
  wait 0.5;
  var_0 sethudtutorialmessage(var_1);
  wait(var_2);
  var_0 clearhudtutorialmessage();
}

weapon_xp_iw8_sn_sbeta(var_0, var_1, var_2) {
  if(scripts\cp\laser_traps\cp_laser_traps::_id_124D0(var_0)) {
    thread logevent_kidnapevent(var_0, &"_encstr_978915C5A9D7863155D53B15DFA209F80371DEED4133C9", 3.0);
    return 0;
  }

  if(!isDefined(level.get_dropoff_point_spawner))
    level.get_dropoff_point_spawner = 0;

  var_3 = projdistsq(var_0.origin, level.mini_map_origin_fix);
  var_4 = ["_encstr_9B1807D39B48FD93A3", "_encstr_9B1807D39B48FD93A3", "_encstr_8BFC0BC2CBD4F737E0A5E1FD79"];
  var_5 = ["_encstr_9BFB1F32C3D75BC116FAC9BA8EC6AFCDACE647C997FACEAB73BE583686B42BD9AC", "_encstr_9BFB1F32C3D75BC116FAC9BA8EC6AFCDACE647C997FACEAB73BE583686B42BD9AC", "_encstr_8C341F320FBE5B1C16AFC9BAE88DAF9ABAB3CE2B4ECD585D3A7D161BD02DACECCA"];
  var_6 = var_5[level.get_dropoff_point_spawner];
  var_0 _id_1243D(var_6, 1, 10);
  level.mini_map_origin_fix[var_3]["_encstr_834F0CF3726B5728B10FB272D7D8"] = 0;
  scripts\cp\laser_traps\cp_laser_traps::_id_124A5(var_0, var_4[level.get_dropoff_point_spawner]);
  level.get_dropoff_point_spawner++;

  if(level.get_dropoff_point_spawner >= var_4.size)
    level.get_dropoff_point_spawner = 0;

  return 1;
}

_id_1435C() {
  for(self._id_12C9D = 1; self._id_12C9D > 0; var_0.forcespawnangles = level._id_12C8E[var_1][1]) {
    self waittillmatch("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", "_encstr_A20A088EDD77B3031B2A");
    var_0 = level.players_in_respawn_queue[0];
    var_1 = projdistsq(self.origin, level._id_12C8E);
    var_0.forcespawnorigin = level._id_12C8E[var_1][0];
  }

  self._id_12C9D = undefined;
}

pretrograd_interaction_effects() {
  foreach(var_1 in level.players) {
    if(istrue(var_1.spectating)) {
      continue;
    }
    if(_id_124B1(var_1))
      return 1;
  }

  return 0;
}

_id_124B1(var_0) {
  for(var_1 = 0; var_1 < var_0.munition_slots.size; var_1++) {
    if(var_0 scripts\cp\loot_system::is_empty_or_none(var_1)) {
      continue;
    }
    if(var_0.munition_slots[var_1].ref == "_encstr_A20A088EDD77B3031B2A")
      return 1;
  }

  return 0;
}

prev_weapon_taccover() {
  foreach(var_1 in level.players) {
    if(istrue(var_1.spectating))
      return 1;
  }

  return 0;
}

_id_11B3E() {
  level.players _id_1243D("_encstr_85711FC8E1FA5BE0C2FAE4573A63BE26B7BD6EA3EB9DB2CD2B4ED26CC97BAE9B23");
  level.players _id_1243D("_encstr_95D51B67433F52F8A169537708389FEA07502A1BB8FBDA36C960433FE0", 10);
}

bombs_explode() {
  var_0 = [];

  foreach(var_2 in level.bombs) {
    if(!istrue(var_2.defused))
      var_0[var_0.size] = var_2;
  }

  var_4 = [];

  foreach(var_2 in var_0) {
    if(!istrue(var_2.inuse))
      var_4[var_4.size] = var_2;
  }

  var_7 = 0;

  foreach(var_2 in var_0) {
    var_2 thread explode(0);
    wait(randomfloatrange(0.1, 0.3));
  }

  scripts\engine\utility::flag_wait("_encstr_A36F0EC4EDDAC4AFB20F3836F623B246");
  wait 2;
  level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
}

explode(var_0) {
  var_1 = self;
  var_1 endon("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C");
  var_2 = gettime();

  if(var_1.inuse)
    var_1 waittill("_encstr_B19C0B9BDEE8D74BDC7DD5DC95");

  if(!var_0 || scripts\engine\utility::time_has_passed(var_2, 1)) {
    foreach(var_4 in level.players)
    var_1 playsoundtoplayer("_encstr_BAE710E54853EF0127F728A88F54B9B73A72", var_4);
  }

  playFX(level._effect["_encstr_96E312CEF2423DB91BCF72E8C6CA48039B6765AA"], var_1.origin);
  playFX(level._effect["_encstr_B2831A1BBDDE077D31BDAD4CD732B2665DDC581BBE2B0F83D8F63256"], var_1.origin);
  earthquake(1, 2, var_1.origin, 3000);

  foreach(var_7 in getaiarrayinradius(var_1.origin, 1000))
  var_7 kill(var_1.origin);

  foreach(var_4 in level.players) {
    if(distance2dsquared(var_4.origin, var_1.origin) < squared(1000))
      var_4 kill(var_1.origin);
  }

  objective_state(var_1.objindex, "_encstr_9B46072B7EA254ADAF");
  var_1.exploded = 1;
  var_1 hide();
  scripts\engine\utility::flag_set("_encstr_A36F0EC4EDDAC4AFB20F3836F623B246");
}

_id_1350B(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_3.objindex = level.bombs.size;
  var_3.angles = var_1;
  var_3.name = var_2;
  var_3 setModel("_encstr_93161A78F20BBB801DE4C79F0589407E9F7AD161EA27653936F75BAD");
  var_3 thread _id_1448E();

  if(isDefined(var_2) && scripts\engine\utility::array_contains_key(level.cpvehiclename, var_2))
    level.cpvehiclename[var_2].bomb = var_3;

  return var_3;
}

_id_135F6(var_0, var_1, var_2) {
  var_3 = "_encstr_A11122C832BD7B2337CA0368B313C919A7F978201B97AB9E47D4077E838751E10F81123A";

  if(var_2 == "_encstr_A3990BDBEF05B561FA5A488BD8") {
    var_4 = &"_encstr_8EBD203414EB353DF59AA0235124F4553554E54528A5157D05356A9E7D3492288A54";
    var_5 = "_encstr_A1941BDB8F5E3F326B90DBC2A83F2CE7B0781F51A9A047311728B2CB58";
    var_6 = "_encstr_A1941BDB8F5E3F326B90DBC2A83F2CE7B0781F51A9A047311728B2CB58";
    var_7 = ::_id_124AA;
    var_8 = &"_encstr_B2CA2435B791A391594F719D1028DCBD57F0A0EBD1139839B391CBEF819E47CE63E3AF6175FC";
  } else {
    var_4 = &"_encstr_8E6E23E652B1E7D4677F21110F58EC53D98F5895FE28039E2703196907AC650FA0E2F71D47";
    var_5 = "_encstr_95971AC61CF5C69CB0CC47ACC87DA5C6B7B9AFB20F0736F6CDB49D56";
    var_6 = "_encstr_95971AC61CF5C69CB0CC47ACC87DA5C6B7B9AFB20F0736F6CDB49D56";
    var_7 = ::_id_124AC;
    var_8 = &"_encstr_B27D2790DFE15B6F2F61BF7C194CDF9D37802A70A65D185EAF371560FEE9BDB986D99F9339D1D63F19";
  }

  var_9 = scripts\cp\laser_traps\cp_laser_traps::_id_139AA(var_0, var_1, ::_id_14541, var_3, var_4, var_5, var_6, var_7, undefined, var_8);
  addclienttoheadiconmask(var_9.headiconid, 30);
  setheadiconmaxdistance(var_9.headiconid, 200);
  var_9.type = var_2;
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_9.origin);
  var_10 dontinterpolate();
  var_10.angles = var_9.angles;
  var_11 = getEnt("_encstr_ABBB13B6A5C62D4758272FD71B270B3A2BF56CBDC6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_10 clonebrushmodeltoscriptmodel(var_11);
  return var_9;
}

_id_14541(var_0, var_1) {
  if(scripts\cp\laser_traps\cp_laser_traps::_id_124D0(var_1)) {
    thread logevent_kidnapevent(var_1, &"_encstr_978915C5A9D7863155D53B15DFA209F80371DEED4133C9", 3.0);
    return 0;
  }

  for(var_2 = 0; var_2 < var_1.munition_slots.size; var_2++) {
    if(var_1.munition_slots[var_2].ref == "_encstr_A3990BDBEF05B561FA5A488BD8")
      var_1 scripts\cp\cp_munitions::remove_munition(var_2, "_encstr_A3990BDBEF05B561FA5A488BD8");

    if(var_1.munition_slots[var_2].ref == "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38")
      var_1 scripts\cp\cp_munitions::remove_munition(var_2, "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38");
  }

  var_1 scripts\cp\laser_traps\cp_laser_traps::_id_124A5(var_1, var_0.type);
  return 1;
}

_id_124AC(var_0) {
  if(!isDefined(var_0.munition_slots))
    return 0;

  for(var_1 = 0; var_1 < var_0.munition_slots.size; var_1++) {
    if(var_0.munition_slots[var_1].ref == "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38")
      return 1;
  }

  return 0;
}

_id_124AA(var_0) {
  if(!isDefined(var_0.munition_slots))
    return 0;

  for(var_1 = 0; var_1 < var_0.munition_slots.size; var_1++) {
    if(var_0.munition_slots[var_1].ref == "_encstr_A3990BDBEF05B561FA5A488BD8")
      return 1;
  }

  return 0;
}

propclonepower() {
  var_0 = [9, 13, 16, 16];

  if(!isDefined(level.players) || level.players.size < 1)
    return var_0[0];

  return var_0[level.players.size - 1];
}

propcontrolshud() {
  var_0 = [14, 14, 10, 10];

  if(!isDefined(level.players) || level.players.size < 1)
    return var_0[0];

  return var_0[level.players.size - 1];
}

propdeathfx() {
  var_0 = [0.4, 0.4, 0.4, 0.4];

  if(!isDefined(level.players) || level.players.size < 1)
    return var_0[0];

  return var_0[level.players.size - 1];
}

_id_1448E() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C");
  self.isusable = 1;
  var_0 = self;
  var_1 = [ &"_encstr_8C8A1CF75958C1BF118F8E476581F7F9361B3E4FE56A686BB1D4739F5E91", &"_encstr_8D8A1C79A3EE6735F97A2739F54B044D91B7B720C54085C1A36305B5A935", &"_encstr_AF8A1C1D6227E1D871C71315B7281069838F08149E6A19E61957252BC7E0", &"_encstr_B18A1C46B897876F21C90939400CB79F0F15C8C8C2BB0D3FDB704939D957"];
  var_0 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_0 sethintdisplayfov(360);
  var_0 setusefov(360);
  var_0 sethintdisplayrange(500);
  var_0 setuserange(84);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_0 sethintlockplayermovement(1);
  var_0 setHintString(var_1[self.objindex]);
  var_0 setusepriority(-10);
  var_0 makeusable();
  var_0.curprogress = 0;
  var_0.userate = 1;
  var_0.laststanddowneddata = propcontrolshud();
  var_0.laststandfinisherdone = propdeathfx();
  var_0.usetime = propclonepower();
  var_0.inuse = 0;
  var_0.playerusing = undefined;
  var_0._id_1387D = getcompleteweaponname("_encstr_B108190EAE4BCAC6C9A07F2F3981B732355017471CAB630D96F86B");

  for(;;) {
    if(!isDefined(var_0.laststanddowneddata) || !isDefined(var_0.laststandfinisherdone) || !isDefined(var_0.usetime)) {
      var_0.laststanddowneddata = propcontrolshud();
      var_0.laststandfinisherdone = propdeathfx();
      var_0.usetime = propclonepower();
      wait 1;
      continue;
    }

    childthread _id_14368(var_0);
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(get_carry_item_omnvar(var_2, var_0)) {
      var_3 = _id_1387F(var_2, var_0);
      var_0.playerusing = var_2;

      if(!istrue(var_3)) {
        continue;
      }
      self hide();
      var_4 = _id_1448F(var_2, var_0);

      if(isDefined(var_2))
        _id_138F5(var_2, var_0, var_4);

      var_0.playerusing = undefined;

      if(istrue(self.exploded)) {
        break;
      }

      if(istrue(var_4))
        thread keypad_disable_for_time(var_2);

      self show();
    }
  }
}

_id_14368(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8F5C086405E70FBA4B4A");

  if(1) {
    return;
  }
  wait(var_0.laststanddowneddata);

  for(;;) {
    var_0.curprogress = var_0.curprogress - level.framedurationseconds * var_0.laststandfinisherdone;
    var_1 = clamp(var_0.curprogress / var_0.usetime, 0, 1);
    objective_setprogress(self.objindex, var_1);

    if(var_0.curprogress <= 0) {
      objective_setshowprogress(self.objindex, 0);
      var_0.curprogress = 0;
      return;
    }

    waitframe();
  }
}

_id_1448F(var_0, var_1) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_1.userate = scripts\engine\utility::ter_op(isDefined(var_0.objectivescaler), var_0.objectivescaler, var_1.userate);

  while(get_alertreset_alias(var_0, var_1) && var_0 useButtonPressed()) {
    var_1.curprogress = var_1.curprogress + level.framedurationseconds * var_1.userate;
    var_2 = clamp(var_1.curprogress / var_1.usetime, 0, 1);
    objective_setprogress(self.objindex, var_2);
    var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_2);

    if(var_1.curprogress >= var_1.usetime)
      return 1;

    waitframe();
  }

  return 0;
}

_id_1387F(var_0, var_1) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(var_0 getcurrentweapon()) && var_0 getcurrentweapon().basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB") {
    scripts\cp\cp_weapon::minigamefinishcount(var_0);

    while(var_0 getcurrentweapon().basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB" || var_0 getcurrentweapon().basename == "_encstr_8BBA05185F8B99")
      waitframe();
  }

  var_1._id_13F76 = var_0 getcurrentweapon();
  var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_1.curprogress / var_1.usetime);
  var_1.inuse = 1;
  self notify("_encstr_8D2D076910203D836D");

  if(!isDefined(level.waittill_end_condition_met) || scripts\engine\utility::time_has_passed(level.waittill_end_condition_met, 10)) {
    level.waittill_end_condition_met = gettime();

    if(self.objindex == 0)
      level.players _id_1243D("_encstr_95301CC8F0D7B51C0BEB4EAB3AD8AF31EDDAC4F519CA33D56ED2B9B3FA2C", 1);
    else if(self.objindex == 1)
      level.players _id_1243D("_encstr_BA301C44D1D97DEB9FDE1B13C3611FF67B53FAF771E04727BE30D23A8E4E", 1);
    else
      level.players _id_1243D("_encstr_972C1A3287AFB583C2BE93BA1D8DFA4CBDB689EB192B9957E6B4CDEC", 1);
  }

  var_1 makeunusable();
  objective_setlabel(self.objindex, &"_encstr_B494219439479341FF69BB934FD589C987262CFDA4EF5D41C7158F83B60F39068F6927");
  objective_setshowprogress(self.objindex, 1);
  objective_sethot(self.objindex, 1);
  var_0 setmovespeedscale(0.2);
  var_0 giveweapon(var_1._id_1387D);
  var_0 scripts\cp\cp_weapons::switchtoweaponreliable(var_1._id_1387D);
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 9);
  var_0 scripts\common\utility::allow_movement(0, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 scripts\common\utility::allow_jump(0, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 scripts\common\utility::allow_mount_side(0, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 scripts\common\utility::allow_mount_top(0, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 scripts\common\utility::allow_mantle(0, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 scripts\common\utility::allow_offhand_weapons(0, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 scripts\common\utility::brjugg_onplayerkilled(0, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 scripts\common\utility::allow_weapon_pickup(0, "_encstr_A3A60998EDB513AFABCDAC");
  return 1;
}

_id_138F5(var_0, var_1, var_2) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 scripts\common\utility::allow_movement(1, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 scripts\common\utility::allow_jump(1, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 scripts\common\utility::allow_mount_side(1, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 scripts\common\utility::allow_mount_top(1, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 scripts\common\utility::allow_mantle(1, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 scripts\common\utility::allow_offhand_weapons(1, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 scripts\common\utility::brjugg_onplayerkilled(1, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 setmovespeedscale(0.2);
  var_0 scripts\cp\cp_weapons::switchtoweaponreliable(var_1._id_13F76);
  var_0 takeweapon(var_1._id_1387D);

  if(istrue(var_0.inlaststand)) {
    thread logevent_kidnapevent(var_0, &"_encstr_AF951F77A03971409FE9FD05909B080942CD27E10A95B1B003F4748D59B3D3292B", 3);
    var_0.min_dist_sq_from_node = var_1._id_13F76;
  }

  objective_setlabel(self.objindex, &"_encstr_97851F04A9D703D14FD90B03DFA5197937B6DC6DB07FCDF157E53F0B379E393FB7");
  objective_sethot(self.objindex, 0);
  var_1.inuse = 0;
  self notify("_encstr_B19C0B9BDEE8D74BDC7DD5DC95");
  var_1 makeusable();
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
  var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_1.curprogress / var_1.usetime);
  var_0 scripts\common\utility::allow_weapon_pickup(1, "_encstr_A3A60998EDB513AFABCDAC");
  var_0 setmovespeedscale(1);
}

keypad_disable_for_time(var_0) {
  self makeunusable();
  self.isusable = 0;
  objective_state(self.objindex, "_encstr_8267056410C669");
  self.defused = 1;
  level.current_checkpoint++;

  if(level.current_checkpoint < level.bombs.size - 1)
    level.players _id_1243D("_encstr_889E1923F0EBB5382CEB39AB3AB1F598EDB5267D19B233ABCD9532", 3);
  else if(level.current_checkpoint < level.bombs.size)
    level.players _id_1243D("_encstr_BDE225911EFA6BE02C7D9C57E863D7C47BBD6E3A7DEE2DDCDC4B373B7D6BB0A36C3438DEB49B3A", 3);
  else
    level.players _id_1243D("_encstr_A6A32B8C3CFA6BE00BFA4E57E8367D95E1CC4B8DBB969B37B4E6ECD76E4758278EBE775A9BE696DCB38ECA85B6", 3);

  self notify("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C");
  level notify("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C", self, var_0);
}

get_carry_item_omnvar(var_0, var_1) {
  return get_alertreset_alias(var_0, var_1);
}

get_alertreset_alias(var_0, var_1) {
  if(!trial_use_headicon())
    return 0;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(var_0 meleeButtonPressed())
    return 0;

  if(!self.isusable)
    return 0;

  return 1;
}

trial_use_headicon() {
  if(isDefined(self.last_stand_state))
    return 0;

  return 1;
}

completepayloadpunish(var_0, var_1, var_2) {
  var_3 = self;

  if(!isPlayer(var_3)) {
    return;
  }
  var_3.movespeedscale = 0;
  var_3 setmovespeedscale(0);

  if(!isDefined(var_3.movespeedscale))
    var_3.movespeedscale = 1.0;

  var_4 = ::movespeed_get_func;
  var_5 = ::movespeed_set_func;
  var_3 thread player_speed_proc(var_0, var_1, var_4, var_5, "_encstr_85D015B358912E02F7F98DC3D5977BED39807F4FD8689D", var_2);
}

player_speed_proc(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify(var_4);
  self endon(var_4);
  var_6 = [[var_2]](var_5);
  var_7 = var_0;

  if(isDefined(var_1) && var_1 > 0) {
    var_8 = var_7 - var_6;
    var_9 = 0.05;
    var_10 = var_1 / var_9;
    var_11 = var_8 / var_10;

    while(abs(var_7 - var_6) > abs(var_11 * 1.1)) {
      var_6 = var_6 + var_11;
      [[var_3]](var_6, var_5);
      wait(var_9);
    }
  }

  [[var_3]](var_7, var_5);
}

movespeed_get_func(var_0) {
  if(!isDefined(var_0))
    var_0 = "_encstr_8B1608EC43B8D647A113";

  if(!isDefined(self.movespeedscales) || !isDefined(self.movespeedscales[var_0]))
    return 1;

  return self.movespeedscales[var_0];
}

movespeed_set_func(var_0, var_1) {
  var_2 = 1.0;

  if(!isDefined(var_1))
    var_1 = "_encstr_8B1608EC43B8D647A113";

  self.movespeedscales[var_1] = var_0;

  foreach(var_4, var_0 in self.movespeedscales) {
    if(var_0 == 1)
      self.movespeedscales = scripts\engine\utility::array_remove_key(self.movespeedscales, var_4);

    var_2 = var_2 * var_0;
  }

  self.movespeedscale = var_2;
  self setmovespeedscale(self.movespeedscale);
}

_id_1243D(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    wait(var_3);

  if(isDefined(var_2)) {
    if(!isDefined(level.waittill_dropped_cash_collected))
      level.waittill_dropped_cash_collected = [];

    var_4 = level.waittill_dropped_cash_collected[var_0];

    if(!isDefined(var_4) || scripts\engine\utility::time_has_passed(var_4, var_2))
      level.waittill_dropped_cash_collected[var_0] = gettime();
    else
      return 0;
  }

  if(isarray(self)) {
    foreach(var_6 in self)
    var_6 thread _id_1243A(var_0, var_1);
  } else
    thread _id_1243A(var_0, var_1);
}

_id_1243A(var_0, var_1) {
  var_2 = self;
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isarray(var_0))
    var_0 = scripts\engine\utility::random(var_0);

  if(!soundexists(var_0))
    return 0;

  if(istrue(var_2.dialogue_playing)) {
    if(isDefined(var_1))
      var_2 scripts\engine\utility::waittill_notify_or_timeout("_encstr_B6F908C3D81F8727583D", var_1);

    if(istrue(var_2.dialogue_playing))
      return 0;
  }

  var_2.dialogue_playing = 1;
  var_2.current_dialogue = var_0;
  var_2 playlocalsound(var_0);
  wait(lookupsoundlength(var_0) / 1000);
  var_2.dialogue_playing = 0;
  var_2.current_dialogue = "_encstr_B40101";
  var_2 notify("_encstr_B6F908C3D81F8727583D", var_0);
  return 1;
}

_id_1238E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = strtok(var_0, "_encstr_BE4C0295");
  var_6 = var_5[0];
  var_7 = scripts\engine\utility::array_remove(var_5, var_6);
  var_8 = scripts\cp\cp_weapon::buildweapon(var_6, var_7);
  var_9 = "_encstr_B2010820C5337B67C8CF" + var_6;
  var_10 = scripts\cp\utility::array_merge(var_8.attachments, var_7);

  foreach(var_12 in var_10)
  var_9 = var_9 + ("_encstr_BE4C0295" + var_12);

  var_14 = spawn(var_9, var_1, 1);
  var_14.angles = var_2;
  var_3 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, weaponclipsize(var_6));
  var_4 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, weaponmaxammo(var_6));
  var_14 itemweaponsetammo(var_3, var_4);
  return var_14;
}