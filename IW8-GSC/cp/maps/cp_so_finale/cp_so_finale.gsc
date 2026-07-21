/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_so_finale\cp_so_finale.gsc
*************************************************/

main() {
  _id_11C1E();
  setdvarifuninitialized("_encstr_86E10F37B1C9AFEA6E2BEBE68BAB2CC89B", 1);
  setdvarifuninitialized("_encstr_BE180EDCC6C9F59BB857C232FAB6850F", 4);
  setdvarifuninitialized("_encstr_A1D715E6C64EBE6EB8BA2C467DC6592C462B27AF5B2CC3", 2);
  setdvarifuninitialized("_encstr_8C1617C7CF3EF161B01E32BA73D8AC49197F4B17CF65DB4808", "_encstr_A34C02BB");
  setdvarifuninitialized("_encstr_9B580EE6B139F5DC5BBDAD95E8B2378E", "_encstr_934C0218");
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  scripts\engine\utility::flag_init("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
  _encstr_AB9637700EB3E8A81CE39F2928E70821E9B78090BB97AFF56F3640B26819DD0EF07B2112C83FDA6CA81A3A7068E84A0F63AE9048292D1C6A21::main();
  _encstr_86A1364E2ED323E39C2FA2C80BEF186B9B52E8DE42B9DFC84F63A8B837F4D13F327F30701EA33F33576FD8882311C8D319E6B665A58A2FF9::main();
  _encstr_A275319BB19C2DC18EDCF2B11C975B0BE0DCBC1B1CF5B9B7F5995AE6C236CAF21B07F5CDB7EB99A59B0B63B27DCCF071EC6E6C::main();
  scripts\vehicle\pindia::main("_encstr_81F518BB632CB0D75D9419E7C155A2B9B03220588801C7A359B8", "_encstr_A3A20E1D4ED51BB5FAB52DB95A6B1607", "_encstr_ADAD248703C2106F83B98B91B28FAE705FA73B37F061A3B6AF5220DE1BA7D0E8F4F1CFB95195");
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
  level.map_interaction_func = _encstr_8CBD3B5E3EC333D3AC1FB2D87B9F085B8BA2F8EE52C9CFF85F7398C827E4C10F020A586E6D61BD604687B898F709F8E18A32CFFE037A674823A2D830FF::register_interactions;
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_8EBB3F37D84E96C1479B97B11C97D6850737E5360EAFCDBD7D994BDC85C62BE56C07BEB9DBFACCA5B958B156AFDDACB0E0BDE64E16CDD6F5CAECAC9BA3C56CCDB3";
  level.player_interaction_monitor = _encstr_8CBD3B5E3EC333D3AC1FB2D87B9F085B8BA2F8EE52C9CFF85F7398C827E4C10F020A586E6D61BD604687B898F709F8E18A32CFFE037A674823A2D830FF::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_8CBD3B5E3EC333D3AC1FB2D87B9F085B8BA2F8EE52C9CFF85F7398C827E4C10F020A586E6D61BD604687B898F709F8E18A32CFFE037A674823A2D830FF::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = ::interaction_trigger_properties;
  level.strike_player_connect_black_screen_fn = ::_id_1247B;
  level.mud_sfx = ::mud_sfx;
  scripts\cp_mp\tripwire::precache("_encstr_837D0F9405A8FA375BBBAAF1632DA7B298", "_encstr_92561EBFCB9DB25070B9951B16488529F52517637FCB4B3DB9414FA46880DEE2");
  scripts\cp_mp\tripwire::precache("_encstr_837D0F9405A8FA375BBBAAF1632DA7B298", "_encstr_99261BC93A1D2057A2EF5D61EFEB1149B452F0E32379B085B9BFBB491B");
  scripts\cp_mp\tripwire::precachetrap("_encstr_8B11138E9C4B83BB4B2756EBD1E42C83D7CC4E85CE", "_encstr_923A1AA7D52492717889292B4019BFEB0D6D27034BC08A2168B18B23", 1);
  _id_12846();

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
  level thread setup_map_specific_devgui();
  setup_create_script();
  level.devgui_setup_func = ::onplayerspawneddevguisetup;

  if(level.scripted_spawner_func.size < 1)
    scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(!scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    scripts\engine\utility::flag_init("_encstr_A2D20FE4880D52A426C867576878654BD3");

  var_0 = getDvar("_encstr_8FE817B28B2847556955C9C673D89FAF6663EA2B9380FFCE38", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101")
    level thread rundebugstartobjective(var_0);

  level.eogscoreboard = ["_encstr_A19B0973B543C35FDDE063", "_encstr_8E8D0697EB01F243", "_encstr_96D30A3468575BA7C307A128", "_encstr_A9AB06297DDFD816", "_encstr_B642089B65A658E8F597"];
  scripts\cp\cp_compass::setupminimap("_encstr_A24A19AF98190B611797FE38B7A0A99EEAB67F10098A946569D439");
  scripts\engine\utility::create_func_ref("_encstr_8D0E18DBB56330034C871198DFF8CFE7EDA87F3DF8A4E48B431B", scripts\cp\cp_vehicles::incrementobjectiveachievementkill);
  supply_station_direction();
  thread play_operator_reply_vo();
}

_id_11C1E() {
  var_0 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1[0] = (-44914, 36320, -668.5);
  var_1[1] = (-30378, 28320, -668.5);

  foreach(var_4, var_3 in var_0) {
    if(!isDefined(var_1[var_4])) {
      var_3 delete();
      continue;
    }

    var_3.origin = var_1[var_4];
  }
}

_id_12846() {
  scripts\engine\utility::flag_init("_encstr_937C0EE68E2CC9D1F5DA5A9BE64B7BE6");
  scripts\engine\utility::flag_init("_encstr_912F1638AB75A0FBF1A540D6FBCA352ED42F30F8F768F989");
  scripts\engine\utility::flag_init("_encstr_A6240EB0B9E6C2ABB18E98EBDE3BCA27");
  scripts\engine\utility::flag_init("_encstr_8A5B16C8A57DA510C1B7A90B4B2044D84A19DFAE1B930E53");
  scripts\engine\utility::flag_init("_encstr_8A910E99BB4B683B7A2CDEEE8213AAB0");
  scripts\engine\utility::flag_init("_encstr_86CC0F0868CF6AE15ADEA835E2E581933C");
  scripts\engine\utility::flag_init("_encstr_88360F51B82869FBFDDF2824EBDA5B8730");
  scripts\engine\utility::flag_init("_encstr_AC7F0FE80AA5C503C64F2F29498BB3834F");
  scripts\engine\utility::flag_init("_encstr_8ED916EBE2A96FCF533AB3B0072A153D290A53204778CFD9");
  scripts\engine\utility::flag_init("_encstr_A2DE1BD95815F1400D7A0FAA32665FBB9B3F6FA8DA60BB382099F920BB");
  scripts\engine\utility::flag_init("_encstr_B23C1F2CD836F599B74CEB355D7676569CCD58EA3ADC7DB9E0C2BBE6CA91FAB437");
  scripts\engine\utility::flag_init("_encstr_81C910CF78C0230BE895EFAFE7B0526DF061");
  scripts\engine\utility::flag_init("_encstr_91660FC2B937585D368E66D7372B1DAE1C");
  scripts\engine\utility::flag_init("_encstr_8DAF1A86B2C62DEB856E6EB0AB361DCCEBCCBD89EBDC8316BB9BACC8");
  scripts\engine\utility::flag_init("_encstr_AD2D16A1CA8DA5EBB0379B165D8D8E33BEDC1C0B77E62BC8");
  scripts\engine\utility::flag_init("_encstr_B89313CD8E58E41DF5EC96374696C2F5E66CCA9B2B");
  scripts\engine\utility::flag_init("_encstr_915F1718D20DA7D387461D832187BE87726A30E8FAA76FC843");
  scripts\engine\utility::flag_init("_encstr_B67313E72B97718B7D2BEA81929327A837AE7C6F82");
  scripts\engine\utility::flag_init("_encstr_96F60F83D7B122305A1EF2FDF1A0BCEA9D");
  scripts\engine\utility::flag_init("_encstr_AD6B0F98F6B61360A9F5838D58E6E85691");
  scripts\engine\utility::flag_init("_encstr_92F61D40157ADCCF075E33C265289542276BE270FFDEC2C60380B3685B2FCD");
  scripts\engine\utility::flag_init("_encstr_B64B1EE2F00670B2137F0BFDB4173FEBD38933839A81BE772F675A59930F03D8");
  scripts\engine\utility::flag_init("_encstr_86DB22B08DD8F54316DC9DB0C9BE355D3BCECAE43758EAA39BF59B382CEEDCAC467DA537");
  scripts\engine\utility::flag_init("_encstr_95F31722315521D788958931A04241FB624F4BC8DA1111C092");
  scripts\engine\utility::flag_init("_encstr_BA831CB893CF86B390F3B604A368C887ABD5CCBF63B091B458C641DF0AFB");
  scripts\cp\laser_traps\cp_laser_traps::add_global_spawn_function("_encstr_8E8405EA382B2A", ::postspawn_axis);
}

_id_1247B(var_0) {}

play_overlord_howcopy_vo() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_96D3193568DC5F40580BADB879276197A127F8C05F5B332EA5FF20", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  weapon_xp_iw8_sn_golf28(var_0);
  var_0 = scripts\engine\utility::getStructArray("_encstr_93032013886BCD6A0F06229EF51311825138BF9B58A613734B242D195EE93B4D39D0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  weapon_xp_iw8_sn_delta(var_0);
  var_1 = scripts\engine\utility::getStructArray("_encstr_A3990BDBEF05B561FA5A488BD8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  weapon_xp_iw8_sh_romeo870(var_1);
  var_2 = scripts\engine\utility::getStructArray("_encstr_8FBB1ACAA134870DE1CF4D51D938D527DE7B92E3681807C360E3434C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  weaponclassweights(var_2);
  var_3 = scripts\engine\utility::getStructArray("_encstr_9BA41838C70CD0BF13D2F58FECD9C71B6927982107CCEB7B4A7B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  weapon_xp_iw8_sn_alpha50(var_3);
}

onplayerspawned() {
  _encstr_A39824FFD7C234188B1A3A6970CE4FB72B1FEC33032D33FE0F60C9CF6B2D7107706705929B82::givedefaultloadout();
  var_0 = "_encstr_BDF710419C225F46FDE93B32B8337A6BE00D";
  var_1 = scripts\cp\cp_weapon::buildweapon(var_0, ["_encstr_AD82121636ED9DFABBAC371D6098BEA539B7736E", "_encstr_88300F3968420F3B6ECB1EA2013BE59B60", "_encstr_BEFF0E0DA91E98107782A089BB233350", "_encstr_852C11EA41FB64BA3E20D8CF9E73018AE29368", "_encstr_93A30DAA99286F1B96F19FDBD14BA2"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
  self giveweapon(var_1);
  self setweaponammoclip(var_1, weaponclipsize(var_1));
  self setweaponammostock(var_1, weaponmaxammo(var_1));
  self switchtoweapon(var_1);
  var_2 = "_encstr_9106102387E011DF472978E0722F376ADAB9";
  var_3 = scripts\cp\cp_weapon::buildweapon(var_2, ["_encstr_978A0D0B2BEFF19730A2753963D32E", "_encstr_AF920D2B91371151476A79EB577E37", "_encstr_97E20F6E635AC82BD7ADD2B6CA13E4C498", "_encstr_8E5F063CDA2C3BCD"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
  self giveweapon(var_3);
  self setweaponammoclip(var_3, weaponclipsize(var_3));
  self setweaponammostock(var_3, weaponmaxammo(var_3));
  self.weaponlist = self getweaponslistprimaries();
  self.vo_three_remain = "_encstr_8BBA05185F8B99";
  self.vo_stealth_broken = 0;
  self.vehicle_occupancy_cp_handlesuicidefromvehicles = "_encstr_8BBA05185F8B99";
  thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0], 1);

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0]))
    self.primaryweaponobj = self.weaponlist[0];

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1]))
    self.secondaryweaponobj = self.weaponlist[1];

  self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 0);
  level.hostdamagefactorlow++;
  thread _id_143E1();

  if(!scripts\engine\utility::flag("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    thread trial_radar_sweeps();
}

_id_143E1() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self._id_124FD = undefined;
  self waittill("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32");
  self._id_124FD = 1;
}

rundebugstartobjective(var_0) {
  wait 2;
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_wait("_encstr_95D217A54E55D2EB03D84337513BA1EA0155211AA7CD0B35E9");

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

onplayerconnect(var_0) {
  level thread bug_test_move_startpoint();
}

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
  register_create_script_arrays("_encstr_9A041B9883516F60EFFE2B90D10B696F06CBD00B5B77FF3BE7F22397BC", "_encstr_9A041B9883516F60EFFE2B90D10B696F06CBD00B5B77FF3BE7F22397BC", level.scripted_spawner_func.size, _encstr_87143C3EEB43A0718BABDAB0B37513F9238368BE504F2B87B9E2D0C0DAFDCBF8B728D82ED7A731F3DD7AF09011D6DDC917B45DB0230FFB3B0213FAF8CBEE::main);
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

play_operator_reply_vo() {
  _id_1321B();
  level.initlocs_keypads = scripts\engine\utility::getStructArray("_encstr_ABAE1185379BC25736A389AFB9C10BDD73569C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_11BD9 = [];
  level.site_axis_spawnfunc = [];
  level.skipdeathicon = 0;
  level._id_123DA = 1;
  levelobjectives_init();
  play_overlord_howcopy_vo();
  scripts\cp\laser_traps\cp_laser_traps::_id_1437A();
  thread brleaderdialogteamexcludeplayer();
  thread current_carrier_time();
  thread _id_11F8F();
  _id_137C4();
  thread init_tripwires();
  thread thermitestuckto();
  scripts\engine\utility::flag_wait("_encstr_937C0EE68E2CC9D1F5DA5A9BE64B7BE6");
  level notify("_encstr_96DC119B8EEDE0BEA35AB5B29CF52BE619F6CD");
  scripts\engine\utility::delaythread(4.7, ::_id_12758, "_encstr_840E208CF0AFDA830BD7EAD61DB1BEC4B7DEDCD1FAB2DCB25BF2EB96CD13EDAEE646");
  scripts\cp\laser_traps\cp_laser_traps::_id_13067();
  thread nocrash();
  scripts\engine\utility::flag_set("_encstr_8A5B16C8A57DA510C1B7A90B4B2044D84A19DFAE1B930E53");
  carepackage_spawn();
  carepackage_unlink_from_heli();
  carepackage_waittill_settle();
}

_id_1321B() {
  level.initnonbunkerdoors = [];
  level.initnonbunkerdoorkeypad = [];
  level.initoperationcratedata = 0;
  var_0 = ["_encstr_87061071769BF94BC89C67B0CC9735AD2721", "_encstr_9A94105E6B9861ABC119229F357802CDC031", "_encstr_83C6115943BFDFC07D143DEF3EE5509DAF5ABB", "_encstr_9BC611D7779BAF20253B1AD01317110FF0DF72", "_encstr_86C611CFAFFE523558BBA2F1D36864AB592B02", "_encstr_8BC61139FE588E1BFDE5565F036FE8932F37AD", "_encstr_97CF11B23847C64F18B5BBDF4C80D30B93103F", "_encstr_AACF11C2CDE60B5D631D66D7CEBD63ABAD5623", "_encstr_81CF1116CD6E85D58D8ECCD73B7B36AEADB266", "_encstr_88CF1133FEAF292391FC8EC81EAA85CBAB1D1A"];

  foreach(var_2 in var_0)
  level.initnonbunkerdoors[level.initnonbunkerdoors.size] = getEnt(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  var_0 = ["_encstr_974015693188E7291DB88BB248159F2B46A4FFECD5F0DF", "_encstr_87061071769BF94BC89C67B0CC9735AD2721", "_encstr_9A94105E6B9861ABC119229F357802CDC031", "_encstr_83C6115943BFDFC07D143DEF3EE5509DAF5ABB", "_encstr_9BC611D7779BAF20253B1AD01317110FF0DF72", "_encstr_86C611CFAFFE523558BBA2F1D36864AB592B02", "_encstr_97CF11B23847C64F18B5BBDF4C80D30B93103F", "_encstr_97CF11B23847C64F18B5BBDF4C80D30B93103F", "_encstr_AACF11C2CDE60B5D631D66D7CEBD63ABAD5623", "_encstr_81CF1116CD6E85D58D8ECCD73B7B36AEADB266"];

  foreach(var_2 in var_0)
  level.initnonbunkerdoorkeypad[level.initnonbunkerdoorkeypad.size] = getEnt(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

_id_131FE(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0))
    level.initlocs_keypads = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1))
    level.initoperationcratedata = var_1;

  if(isDefined(var_2))
    level._id_135D2["_encstr_AF5A081BBAC993AC73A3"] = level._id_135D2[var_2];

  if(isDefined(var_3))
    level._id_11B4C = var_3;
  else
    level._id_11B4C = 1;

  _id_13F78();
}

carepackage_spawn() {
  scripts\engine\utility::delaythread(0.3, ::spawn_group, "_encstr_850707F7E5833355B8", "_encstr_8E6D14F75D53FF535697A808D34F291FDB867589B38F", 1, "_encstr_A6240EB0B9E6C2ABB18E98EBDE3BCA27", "_encstr_A6240EB0B9E6C2ABB18E98EBDE3BCA27", 1, 18);
  scripts\engine\utility::delaythread(0.4, ::spawn_group, "_encstr_A11904E483B3", "_encstr_8CBB1157FDF35F93A84F31C877C389734A63F7", 1, "_encstr_A6240EB0B9E6C2ABB18E98EBDE3BCA27", "_encstr_A6240EB0B9E6C2ABB18E98EBDE3BCA27", 1, 18);
  scripts\engine\utility::delaythread(1.5, ::_id_11D32);
  scripts\engine\utility::flag_wait("_encstr_A6240EB0B9E6C2ABB18E98EBDE3BCA27");
  _id_131FE("_encstr_AB0D1758B9E60B57B18E19EBCC93EDDC3AFA6EC1C2BBDCCAC9", 1, "_encstr_B6791099ED267D371DB09CA3FAB0E4E42C2F", 1);
  var_0 = scripts\engine\utility::getStructArray("_encstr_86D917B06EE616ABC6E8C8AFA5DC3A9C7BBEE6E0B0DDDC2B93", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread _id_135DB(var_0, 2);
}

carepackage_unlink_from_heli() {
  scripts\engine\utility::flag_wait("_encstr_99850FC11B16E52B4EDC7DD29B7D33ED98");
  thread _id_13506();
  thread _id_135EC("_encstr_877A0DBB4A0D30D23193AF207362F7");
  scripts\engine\utility::delaythread(0.2, ::_id_12758, "_encstr_A2791BDFFB771AA0F921374750705792F31823996CA3F2F023D05F7F50");
  _id_1357B("_encstr_8197127BBB80BBDAE968A2FAB867D70B589FC7B9", "_encstr_ACD20F4B118BEF03D380F9335815BC7761");
  thread _id_13566();
  thread _id_13574();
  scripts\engine\utility::flag_wait("_encstr_A2D40B270F1902AAE1C8779F62");
  _id_131FE("_encstr_BAA31541A6739F4BC9A82709983BC7AFAB8FC9EFB0D9AB", 2, undefined, 1);
  thread spawn_group("_encstr_850707F7E5833355B8", "_encstr_BE6D142C368BBE377396E0CA93F50BDC6EB0D5C6E846", 1, undefined, "_encstr_B4D40B33168D3631C26C5BFA99", 2, 30);
  scripts\engine\utility::flag_wait("_encstr_95D40BE7CF5942EAA18837DF3A");
  level.brinfilsmokesuffix = scripts\engine\utility::getStructArray("_encstr_B277119660868FFB10525AD70361BFC122EBD8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _id_131FE("_encstr_9BE1167F7F23D19D2CA97ADEFAC7832726E3FBB103602F93", 3, "_encstr_B2E70E18974ACEEBFA0FA0B762D32BF2", 1);
  scripts\engine\utility::flag_wait("_encstr_B4D40B33168D3631C26C5BFA99");
  _id_131FE("_encstr_9BE1167F7F23D19D2CA97ADEFAC7832726E3FBB103602F93", 4, undefined, 1);
  scripts\engine\utility::flag_wait("_encstr_9AD40BFE271823164B98CA81CA");
  _id_131FE("_encstr_9BE1167F7F23D19D2CA97ADEFAC7832726E3FBB103602F93", 5, undefined, 1);
  scripts\engine\utility::flag_wait("_encstr_8A910E99BB4B683B7A2CDEEE8213AAB0");
  _id_131FE("_encstr_838D1F076A837303C4730A6923F599A7A955889E464B2B08BEC73808F72FF0EB23");
}

carepackage_waittill_settle() {
  scripts\engine\utility::flag_wait("_encstr_91660FC2B937585D368E66D7372B1DAE1C");
  level.brinfilsmokesuffix = scripts\engine\utility::getStructArray("_encstr_AAB71233F69846AFC2D81B2FAF27ACCD1C85BBDC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _id_131FE("_encstr_A23E15C7AA43B3C304B3C2A9FF29B9972B124F54459A5D", 6, "_encstr_998A0DB0E26D37D1CB57BF2E52AF1A");
  thread _id_13567();
  thread _id_135F2();
  scripts\engine\utility::delaythread(3, ::_id_12758, "_encstr_A77E16C83C7DB5070B7D5DB6D163EBC4BD7B37D1BE4791DA");
  _id_1357B("_encstr_AD9712AD2DB1C69BA3C959586DBE234E7B07D719", "_encstr_B8840F126B9D8FF218872D21B7C03CC3CD");
  scripts\engine\utility::flag_wait("_encstr_852D13DA53FF691B3CB8EE7FDF570C94029758B2D5");
  _id_131FE("_encstr_A23E15C7AA43B3C304B3C2A9FF29B9972B124F54459A5D", 7, undefined, 1);
  thread _id_135EC("_encstr_BE7A0D3363804B92B0FFD38FEFC0BF");
  scripts\engine\utility::flag_wait("_encstr_AD2D1385E66E85AE364799F5992C8DC6C458D85B33");
  _id_131FE("_encstr_976816EF13AF49837533E2795ACC69EBC7BBEF578FB3B1D5", 8, undefined, 1);
  var_0 = scripts\engine\utility::getStructArray("_encstr_8834203FAB63175B08BB36D12D4BA4A14B2125EFD8C7EDA8F7E34F729059779D49A8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = _id_135DB(var_0, 3);
  _id_135D6();
  scripts\engine\utility::flag_wait("_encstr_B42D134F22A0279BEC01C2DED22082619B391BEA8C");
  _id_131FE("_encstr_995016467380794339E1CE873557EABB39DBBACE6B73056B", 9, undefined, 1);
  scripts\engine\utility::flag_set("_encstr_B89313CD8E58E41DF5EC96374696C2F5E66CCA9B2B");
  wait 2;
  thread spawn_group("_encstr_B4920771CA8F0618B2", "_encstr_822414EF454BE7193FFF5010FB7731F733AE5DE1DB87", 0, undefined, undefined, undefined, 6);
  scripts\engine\utility::flag_wait("_encstr_B62D13FB463AF935193C16AFFBC130CB88DFB6A2AD");
  var_0 = scripts\engine\utility::getStructArray("_encstr_9B4F1851D7A86EEF09CB7FA150D7CBA7807DF7CB29D033BBA563", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = _id_135DB(var_0, 2);
  scripts\engine\utility::flag_wait("_encstr_B67313E72B97718B7D2BEA81929327A837AE7C6F82");
  _id_131FE("_encstr_825719859BCD85AB1BD199AF7BAE479B4B232BF5B9E085EEE62B4E", 9, undefined, 1);
  var_0 = scripts\engine\utility::getStructArray("_encstr_AF5918C37322F04D43AB8336F21F88E8FFEA379F180EF8188F23", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_0) {
    var_4 = getnode(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5 = var_3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_5.fixednode = 1;
    var_5.matchdata_logchallenge = 1;
    var_5 setgoalnode(var_4);
    wait 0.2;
  }

  thread setupspecialdaypickupweapons();
  scripts\engine\utility::flag_wait("_encstr_AD6B0F98F6B61360A9F5838D58E6E85691");
  scripts\engine\utility::flag_set("_encstr_8A5B16C8A57DA510C1B7A90B4B2044D84A19DFAE1B930E53");
  thread _id_13423("_encstr_A53E13F368706797291589863398D1DF25636B7AD3");
  wait 0.7;
  _id_13556();
  wait 4;
  _id_13556();
  scripts\engine\utility::flag_set("_encstr_95F31722315521D788958931A04241FB624F4BC8DA1111C092");
}

_id_13556() {
  var_0 = getEnt("_encstr_96CF11859BB958ABB1D133AF67DE1BABD69553", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStructArray("_encstr_85F80F4514A2AED1A7CE1887A61F682D9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1.size;

  if(level.players.size == 2)
    var_2 = 8;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_1[var_3] scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_4 setgoalvolumeauto(var_0);
    var_4 thread _id_13093(var_1[var_3]);
    wait 0.2;
  }
}

_id_135D6() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_926D14379D933F1316D7E848930F69DF1B46B5C9F3EF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_4 = getnode(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5 = var_2 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_5 thread nvidiaansel_scriptdisable(var_3);
    var_5 thread _id_13439();
    var_5 forceteleport(var_3.origin, var_3.angles);
    wait 0.1;
    var_5 setgoalnode(var_4);
    var_5.goalradius = 32;
    var_5.fixednode = 1;
  }
}

nvidiaansel_scriptdisable(var_0) {
  self endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::flag_wait("_encstr_B67313E72B97718B7D2BEA81929327A837AE7C6F82");
  wait(randomfloatrange(0, 1.5));
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.fixednode = 0;
  self.goalradius = 32;
  wait 0.05;
  self setgoalpos(var_0.origin);
  wait(randomfloatrange(5, 6.5));
  self kill();
}

setupspecialdaypickupweapons() {
  thread _id_13423("_encstr_88610D7B20979CD7D68E445AA579DB");
  wait 0.7;
  scripts\engine\utility::flag_clear("_encstr_81C910CF78C0230BE895EFAFE7B0526DF061");
  thread _id_13579("_encstr_86D91CB06EE616ABC6E8CCAFA9EAB3D92BE4DCC2BA1DBE9B8316BB37AC4E", "_encstr_B64B1EE2F00670B2137F0BFDB4173FEBD38933839A81BE772F675A59930F03D8", "_encstr_86DB22B08DD8F54316DC9DB0C9BE355D3BCECAE43758EAA39BF59B382CEEDCAC467DA537");
  thread _id_11F5F();
}

_id_13F78() {
  var_0 = getaiarray("_encstr_8E8405EA382B2A");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.matchdata_logchallenge))
      var_2 setgoalvolumeauto(level.initnonbunkerdoors[level.initoperationcratedata]);
  }

  var_4 = getaiarray("_encstr_9A8507BA4040188D08");

  foreach(var_6 in var_4)
  var_6 setgoalvolumeauto(level.initnonbunkerdoorkeypad[level.initoperationcratedata]);

  level.player_has_grenade_crate = 1;
}

thermitestuckto() {
  scripts\engine\utility::delaythread(3.7, ::_id_12759, "_encstr_8AFA21CD787FA8E996E1B0784A2B23A69B014034C76B303B7DBA38B8B1C3B35823BFD6", "_encstr_937C0EE68E2CC9D1F5DA5A9BE64B7BE6");
  scripts\engine\utility::delaythread(15, ::_id_12759, "_encstr_B1EB25B1C3C12883E729F36FA34D9EBFEB6318DA3B316D4B1E34570D3553859B37FC38100D43CA", "_encstr_937C0EE68E2CC9D1F5DA5A9BE64B7BE6");
  scripts\engine\utility::delaythread(35, ::_id_12759, "_encstr_8B0119794BB7E0C979496B1AB04889C957EE8728434ACFBE876780", "_encstr_937C0EE68E2CC9D1F5DA5A9BE64B7BE6");
  var_0 = 45;
  scripts\engine\utility::flag_wait_or_timeout("_encstr_937C0EE68E2CC9D1F5DA5A9BE64B7BE6", var_0);
  scripts\engine\utility::flag_set("_encstr_937C0EE68E2CC9D1F5DA5A9BE64B7BE6");
}

_id_137C4() {
  var_0 = getEnt("_encstr_8501124B73A39CDEFAD139BA36ADFA0B8D83D00B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.trial_spawn_wait = var_0 scripts\common\utility::spawn_vehicle();
  level.trial_spawn_wait.script_keepdriver = 1;
  level.trial_spawn_wait thread trial_rpg_init();
  var_1 = getEnt("_encstr_ACD91796B9D14EF6FAA39C5736B6F50BC61C0D0BD76CB1D238", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1.angles = var_1.angles + (3, 1, -1);
  var_1.origin = var_1.origin + (-3, -4, -10);
  var_1 linkTo(level.trial_spawn_wait);
  wait 0.2;
  level.trial_spawn_wait notsolid();
  thread scripts\common\vehicle_paths::gopath(level.trial_spawn_wait);
  wait 1;
  level.trial_spawn_wait setwaitspeed(0);
  level.trial_spawn_wait scripts\engine\utility::waittill_notify_or_timeout("_encstr_83F31382ADE312408110479F407814999FBFCFFF85", 7.5);
  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
  level.trial_spawn_wait scripts\engine\utility::delaycall(3, ::vehicle_turnengineoff);
  wait 3;
  var_0 = scripts\engine\utility::getStruct("_encstr_8C690D6B12670A9061D44D73EED710", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_0 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
}

trial_rpg_init() {
  while(!isDefined(self.driver))
    wait 0.1;

  self.driver delete();
}

trial_radar_sweeps() {
  while(!isDefined(level.trial_spawn_wait))
    waitframe();

  if(scripts\engine\utility::flag("_encstr_A2D20FE4880D52A426C867576878654BD3")) {
    return;
  }
  var_0 = ["_encstr_A30D0B30D3708180E951D37165", "_encstr_910D0BD951F7D19EB70A9BE647", "_encstr_AC0D0B23199F175B2B07F84ECA", "_encstr_8F0D0BA3C2D9FA6EB216D1D7D4"];
  var_1 = [(-23, -10, 7), (-23, -20, 7), (-23, -17, 7), (-23, -10, 7)];
  var_2 = [40, 50, 50, 40];
  var_3 = [50, 40, 40, 50];

  if(!isDefined(level.trial_spawn_wait._id_13A26))
    level.trial_spawn_wait._id_13A26 = [];

  var_4 = undefined;
  self.animname = undefined;
  var_5 = undefined;

  foreach(var_8, var_7 in var_0) {
    if(!isDefined(level.trial_spawn_wait._id_13A26[var_7])) {
      level.trial_spawn_wait._id_13A26[var_7] = 1;
      var_4 = var_7;
      var_5 = var_8;
      self.animname = "_encstr_AC6B06F0DA2281E1" + var_8;
      break;
    }
  }

  var_9 = var_1[var_5];
  var_10 = var_2[var_5];
  var_11 = var_3[var_5];
  var_12 = scripts\cp\laser_traps\cp_laser_traps::_id_124E9(self, "_encstr_AC6B06F0DA2281E1" + var_5);
  var_12 linkTo(level.trial_spawn_wait, var_4, var_9, (0, 0, 0));
  self allowstand(0);
  self allowprone(0);
  self setstance("_encstr_B13D076BED70539F23");
  wait 0.05;
  self playerlinktodelta(var_12, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1, 1, 1);
  self lerpviewangleclamp(1, 0.25, 0.25, var_10, var_11, 80, 80);

  while(!scripts\engine\utility::flag("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    var_12 scripts\cp\cp_anim::anim_player_solo(self, var_12, "_encstr_91AD102B05FA4B18CF43C858E7377099826F");

  var_12 scripts\cp\cp_anim::anim_player_solo(self, var_12, "_encstr_BA1310289D6E4039E1D3F3E1A7C9F5900973");
  self unlink();
  var_12 delete();
  self allowstand(1);
  self allowprone(1);
  self setstance("_encstr_A5AD069B231F0BAF", 0, 1, 1);
}

init_tripwires() {
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  wait 3;
  scripts\cp_mp\tripwire::init();
  level.tripwires._id_11CD1 = getEntArray("_encstr_889F12A3E42DC1BB2D4EB2FAB6BDE6D76CB196C1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.tripwires.tripwires)
  var_1 thread last_say_times();
}

last_say_times() {
  self waittill("_encstr_8F5C086405E70FBA4B4A");

  if(isDefined(self.targets) && self.targets.size == 1) {
    var_0 = scripts\engine\utility::getclosest(self.origin, level.tripwires._id_11CD1);
    level.tripwires._id_11CD1 = scripts\engine\utility::array_remove(level.tripwires._id_11CD1, var_0);

    if(isDefined(var_0))
      var_0 delete();
  }
}

current_carrier_time() {
  level.playerexitsafeareamessage = [];
  var_0 = getEntArray("_encstr_81B20629C5B7B6B2", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0) {
    if(var_2.targetname == "_encstr_9992073ED5DACD0331")
      level.playerexitsafeareamessage[0] = var_2;
    else if(var_2.targetname == "_encstr_AB92077E28DD6D973A")
      level.playerexitsafeareamessage[1] = var_2;
    else if(var_2.targetname == "_encstr_A7920789DE6BC40366")
      level.playerexitsafeareamessage[2] = var_2;
    else if(var_2.targetname == "_encstr_A59207D2400D8A52DA")
      level.playerexitsafeareamessage[3] = var_2;
    else if(var_2.targetname == "_encstr_869207E60D0215CBFD")
      level.playerexitsafeareamessage[4] = var_2;

    var_2 hide();
    var_2._id_1405C = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_2.targetname != "_encstr_A59207D2400D8A52DA")
      var_2 thread crankedprogressuiupdater(::cqb_laser_guy_internal, &"_encstr_86800D508F10835DF91DFFFB231997", undefined, 1);
  }
}

crankedprogressuiupdater(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self._id_1405C.origin);

  if(isDefined(self._id_1405C.angles))
    var_4.angles = self._id_1405C.angles;
  else
    var_4.angles = (0, 0, 0);

  var_4._id_11C6D = self;

  if(isDefined(var_2)) {
    var_4.headicon = thread scripts\cp\utility::ent_createheadicon(var_4, 15, "_encstr_9A8507BA4040188D08", var_2, 1);
    setheadiconsnaptoedges(var_4.headicon, 1500);
    setheadiconmaxdistance(var_4.headicon, 15);
  }

  var_4 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_4 sethintdisplayrange(200);
  var_4 sethintdisplayfov(45);
  var_4 setuserange(100);
  var_4 setusefov(40);
  var_4 sethintonobstruction("_encstr_BD1805CB69C063");
  var_4 setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
  var_4 sethintrequiresholding(1);
  var_4 makeusable();

  if(isDefined(var_1))
    var_4 setHintString(var_1);

  var_4.valve_steam_on = 0;
  thread _id_12F50(var_4, var_0, var_3);
  return var_4;
}

cqb_laser_guy_internal(var_0, var_1) {
  var_0._id_11C6D show();
  var_0.valve_steam_on = 1;
  scripts\engine\utility::flag_set(var_0._id_11C6D.targetname + "_encstr_9B0F09BE1CD8859BD1B246");
  playsoundatpos(var_0._id_11C6D.origin, "_encstr_9A730EA6147D98BDB6137D07C6C2DC1D");
  wait 0.2;
  var_1 playsoundtoteam("_encstr_84EC2A521AB8AF02309745538DE81A1FD8312ACAC185777BD0F7772985405563710E42728BD307F7291F453C", "_encstr_9A8507BA4040188D08");

  if(!scripts\engine\utility::flag("_encstr_AC7F0FE80AA5C503C64F2F29498BB3834F"))
    thread _id_1350D(var_1);

  wait 1.5;
  thread _id_12758("_encstr_826319231EAFAD0758EBEAD68ED8F598B75B98EB83D885DC8EACC8");
}

_id_1350D(var_0) {
  var_1 = scripts\engine\utility::getStructArray("_encstr_8FA31E737F830710ACDB8B3E4689E84AF9D7C9FB97BADD10C772CB712E792071", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStructArray("_encstr_9BB60B1F819767E25D5BCA90B3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = 2;
  var_4 = undefined;

  if(level.players.size <= 1)
    var_3 = 1;

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_2[var_5].origin = var_1[var_5].origin;

    if(isDefined(var_1[var_5].angles))
      var_2[var_5].angles = var_1[var_5].angles;

    var_4 = var_2[var_5] scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
    var_4 getenemyinfo(var_0);
  }

  wait 2;
  thread _id_12420(var_4, "_encstr_B6331F9D2877D3D11FF0FF905DEB5F0F105B1E94616090A20233D97E88F01AFFC0");
}

levelobjectives_init() {
  level.objectives_table = "_encstr_AB431FF1828FB89F597F677F5342E8E0945FFEC8AE2270DEC33F5D032F1EA6A826";
  level.objectiveregistration = ::levelregisterobjectives;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

levelregisterobjectives() {
  scripts\cp\cp_objectives::registerobjective("_encstr_B1310A72F60A9FCB83E88B80", undefined, undefined, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_9B5F0B18360ACB4EC71F30A046", undefined, undefined, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_9A3209E0BA04C54E1FD985", undefined, undefined, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_97190B68B662D7593BFFA3F0B5", undefined, undefined, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_867A0BE0362225E858100F8FF6", undefined, undefined, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_844112770DF2979F2819F67E9069E06A58AFD78B", undefined, undefined, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_88B110986B8A1B676294F189612A6B18E1B7", undefined, undefined, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_83EA0D8FF51A5F7738904F56C85080", undefined, undefined, undefined, undefined, undefined);
}

_id_11F8F() {
  _id_11F6B();
  _id_11F6C();
  _id_11F5B();
  _id_11F5D();
  _id_11F5E();
  _id_11F59();
}

_id_11F6B() {
  setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 1);
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 2);
  var_0 = scripts\engine\utility::getStruct("_encstr_9B4C0C7F1B6860B768DEE23F4D9B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_B1310A72F60A9FCB83E88B80", 1);
  level.inittutzones = var_1;
  objective_setplayoutro(var_1, 1);
  objective_setplayintro(var_1, 1);
  objective_setminimapiconsize(var_1, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  objective_position(var_1, var_0.origin);
  objective_setdescription(var_1, &"_encstr_A6641EB3510922C750CD98F0350127F579CB263911B179FFF6A4F129BFEF2393");
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_unpinforteam(var_1, "_encstr_9A8507BA4040188D08");
  objective_setshowdistance(var_1, 1);
  objective_setbackground(var_1, 0);
  objective_setshowoncompass(var_1, 1);
  objective_setpulsate(var_1, 1);
}

_id_11F6C() {
  scripts\engine\utility::flag_wait("_encstr_937C0EE68E2CC9D1F5DA5A9BE64B7BE6");
  scripts\cp\cp_objectives::freeworldid("_encstr_B1310A72F60A9FCB83E88B80");
  objective_state(level.inittutzones, "_encstr_8267056410C669");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 3);
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_8C08193BD981AABF284594788D89AF0DE173BE418909E1777E3C9F", "_encstr_9A8507BA4040188D08", 4);
  var_0 = scripts\engine\utility::getStruct("_encstr_850B0D87FD02176F18C886C1A0489C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_9B5F0B18360ACB4EC71F30A046", 1);
  level.inittutzones = var_1;
  objective_setplayoutro(var_1, 1);
  objective_setplayintro(var_1, 1);
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  objective_position(var_1, var_0.origin);
  objective_setdescription(var_1, &"_encstr_8C08193BD981AABF284594788D89AF0DE173BE418909E1777E3C9F");
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_unpinforteam(var_1, "_encstr_9A8507BA4040188D08");
  objective_setshowdistance(var_1, 1);
  objective_setbackground(var_1, 0);
  objective_setshowoncompass(var_1, 1);
  objective_setpulsate(var_1, 1);
}

_id_11F5B() {
  thread _id_11F60();
  scripts\engine\utility::flag_wait("_encstr_A6240EB0B9E6C2ABB18E98EBDE3BCA27");
  scripts\cp\cp_objectives::freeworldid("_encstr_9B5F0B18360ACB4EC71F30A046");
  objective_state(level.inittutzones, "_encstr_8267056410C669");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 4);
  var_0 = scripts\engine\utility::getStruct("_encstr_850B0D87FD02176F18C886C1A0489C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = (0, 0, 5);
  var_2 = scripts\cp\cp_objectives::requestworldid("_encstr_9A3209E0BA04C54E1FD985", 1);
  level.inittutzones = var_2;
  objective_setplayoutro(var_2, 1);
  objective_setplayintro(var_2, 1);
  objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
  objective_position(var_2, level.playerexitsafeareamessage[0].origin + var_1);
  objective_setdescription(var_2, &"_encstr_A5601E9A05A2D090F535451451AA9AEB212972A2E54162829CA8AF12A73512A9");
  objective_unpinforteam(var_2, "_encstr_9A8507BA4040188D08");
  objective_setshowdistance(var_2, 1);
  objective_setbackground(var_2, 0);
  objective_setshowoncompass(var_2, 1);
  objective_setpulsate(var_2, 1);
  objective_setlabel(var_2, &"_encstr_83151E53D9A037B07E47DCA8FB411DDFC1F510905F0FED64F7534910A994E1DE");
  objective_icon(var_2, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  scripts\engine\utility::flag_wait("_encstr_86CC0F0868CF6AE15ADEA835E2E581933C");
  objective_position(var_2, level.playerexitsafeareamessage[1].origin + var_1);
  scripts\engine\utility::flag_wait("_encstr_88360F51B82869FBFDDF2824EBDA5B8730");
  objective_position(var_2, level.playerexitsafeareamessage[2].origin + var_1);
  scripts\engine\utility::flag_wait("_encstr_AC7F0FE80AA5C503C64F2F29498BB3834F");
  thread _id_11D85();
}

_id_11D85() {
  var_0 = getEnt("_encstr_932C0B897F5335A65A8F79FF44", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEntArray("_encstr_8B0B0AEC858ECAFA6CB14B83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEnt("_encstr_AA0411E05FAC796FFADD0B8F79E2538DE5A348", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  wait 0.2;
  thread _id_1355D();
  var_0 moveTo(var_1.origin, 3);
  wait 1;
  var_3 notsolid();
}

_id_1355D() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_AA66142F30C3D1E361854A196423AB9DEE28F7B7D0D9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = getnode(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_4 = var_2 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_4._id_13FBA = "_encstr_81E80F2113CBBB47B8035E1958FBEBA25C";
    var_4 thread _id_13092(var_3);
    wait 0.2;
  }
}

_id_11F60() {
  scripts\engine\utility::flag_wait("_encstr_8ED916EBE2A96FCF533AB3B0072A153D290A53204778CFD9");

  for(var_0 = 0; var_0 < level.solution_exists_already.size; var_0++) {
    var_1 = level.solution_exists_already[var_0];
    var_2 = "_encstr_ABB60EDCE74310A877398F814F619773" + var_0;
    var_1.objindex = scripts\cp\cp_objectives::requestworldid(var_2, 2);
    objective_setplayintro(var_1.objindex, 0);
    objective_setplayoutro(var_1.objindex, 0);
    objective_setownerteam(var_1.objindex, "_encstr_8E8405EA382B2A");
    objective_state(var_1.objindex, "_encstr_930B07BB1B6B3854FF");
    objective_icon(var_1.objindex, "_encstr_8D0D182AB6E0083F4DB702F0EF798B97E4B31BFBB8A7E68B6D7A");
    objective_setlocation(var_1.objindex, 0, var_1);
    var_1 thread laser_sights(var_1.objindex, var_2);
  }
}

_id_11F5C() {
  scripts\engine\utility::flag_wait("_encstr_B23C1F2CD836F599B74CEB355D7676569CCD58EA3ADC7DB9E0C2BBE6CA91FAB437");

  for(var_0 = 0; var_0 < level._id_11BD9.size; var_0++) {
    var_1 = level._id_11BD9[var_0];
    var_2 = "_encstr_BA670E5248F5F9838BAC7F4FB3914F7D" + var_0;
    var_1.objindex = scripts\cp\cp_objectives::requestworldid(var_2, 2);
    objective_setplayintro(var_1.objindex, 0);
    objective_setplayoutro(var_1.objindex, 0);
    objective_setownerteam(var_1.objindex, "_encstr_8E8405EA382B2A");
    objective_state(var_1.objindex, "_encstr_930B07BB1B6B3854FF");
    objective_icon(var_1.objindex, "_encstr_A13718BF3A67AAB7F81C98731DB6A7E7E8FFC9A45D6042F90BC9");
    objective_setminimapiconsize(var_1.objindex, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
    objective_setlocation(var_1.objindex, 0, var_1);
    var_1 thread laser_sights(var_1.objindex, var_2);
  }
}

_id_11F5D() {
  scripts\cp\cp_objectives::freeworldid("_encstr_9A3209E0BA04C54E1FD985");
  objective_state(level.inittutzones, "_encstr_8267056410C669");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 7);
  level._id_135D2["_encstr_AF5A081BBAC993AC73A3"] = level._id_135D2["_encstr_B4390B33DE3146D785C9932C5E"];
  scripts\engine\utility::flag_set("_encstr_8A910E99BB4B683B7A2CDEEE8213AAB0");
  scripts\engine\utility::flag_set("_encstr_91660FC2B937585D368E66D7372B1DAE1C");
  scripts\engine\utility::flag_set("_encstr_8A5B16C8A57DA510C1B7A90B4B2044D84A19DFAE1B930E53");
  var_0 = scripts\engine\utility::getStruct("_encstr_844112770DF2979F2819F67E9069E06A58AFD78B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_844112770DF2979F2819F67E9069E06A58AFD78B", 1);
  level.inittutzones = var_1;
  objective_setplayoutro(var_1, 1);
  objective_setplayintro(var_1, 1);
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  objective_position(var_1, var_0.origin);
  objective_setdescription(var_1, &"_encstr_92951FAD6FB007606966A47519B12D4204137D08CCB1277FE92B5823E172AC2D78");
  objective_setlabel(var_1, "_encstr_B40101");
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_unpinforteam(var_1, "_encstr_9A8507BA4040188D08");
  objective_setshowdistance(var_1, 1);
  objective_setbackground(var_1, 0);
  objective_setshowoncompass(var_1, 1);
  objective_setpulsate(var_1, 1);
  thread _id_11F61();
}

_id_11F61() {
  scripts\engine\utility::flag_wait("_encstr_8DAF1A86B2C62DEB856E6EB0AB361DCCEBCCBD89EBDC8316BB9BACC8");

  for(var_0 = 0; var_0 < level.sort_goal_positions_by_priority.size; var_0++) {
    var_1 = level.sort_goal_positions_by_priority[var_0];
    var_2 = "_encstr_910F0FFD5FB6BA88834A9820F15F5E984D" + var_0;
    var_1.objindex = scripts\cp\cp_objectives::requestworldid(var_2, 2);
    objective_setplayintro(var_1.objindex, 0);
    objective_setplayoutro(var_1.objindex, 0);
    objective_setownerteam(var_1.objindex, "_encstr_8E8405EA382B2A");
    objective_state(var_1.objindex, "_encstr_930B07BB1B6B3854FF");
    objective_icon(var_1.objindex, "_encstr_8D0D182AB6E0083F4DB702F0EF798B97E4B31BFBB8A7E68B6D7A");
    objective_setlocation(var_1.objindex, var_0, var_1);
    var_1 thread laser_sights(var_1.objindex, var_2);
  }
}

_id_11F5E() {
  scripts\engine\utility::flag_wait("_encstr_B4381283D8B02F59C9CDFA2C1DBEA1589B3B1693");
  thread _id_11F7B();
  scripts\cp\cp_objectives::freeworldid("_encstr_844112770DF2979F2819F67E9069E06A58AFD78B");
  objective_state(level.inittutzones, "_encstr_8267056410C669");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 4);
  var_0 = (0, 0, 5);
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_9A3209E0BA04C54E1FD985", 1);
  level.inittutzones = var_1;
  objective_setplayoutro(var_1, 1);
  objective_setplayintro(var_1, 1);
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  objective_position(var_1, level.playerexitsafeareamessage[4].origin + var_0);
  objective_setdescription(var_1, &"_encstr_A5601E9A05A2D090F535451451AA9AEB212972A2E54162829CA8AF12A73512A9");
  objective_unpinforteam(var_1, "_encstr_9A8507BA4040188D08");
  objective_setshowdistance(var_1, 1);
  objective_setbackground(var_1, 0);
  objective_setshowoncompass(var_1, 1);
  objective_setpulsate(var_1, 1);
  objective_setlabel(var_1, &"_encstr_83151E53D9A037B07E47DCA8FB411DDFC1F510905F0FED64F7534910A994E1DE");
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  scripts\engine\utility::flag_wait("_encstr_AD6B0F98F6B61360A9F5838D58E6E85691");
}

_id_11F7B() {
  scripts\engine\utility::flag_wait("_encstr_915F1718D20DA7D387461D832187BE87726A30E8FAA76FC843");

  for(var_0 = 0; var_0 < level._id_142B4.size; var_0++) {
    var_1 = level._id_142B4[var_0];
    var_2 = "_encstr_83081384B1E8FF82B6375BDFAD55CA31B918FECDC8" + var_0;
    var_1.objindex = scripts\cp\cp_objectives::requestworldid(var_2, 2);
    objective_setplayintro(var_1.objindex, 0);
    objective_setplayoutro(var_1.objindex, 0);
    objective_setownerteam(var_1.objindex, "_encstr_8E8405EA382B2A");
    objective_state(var_1.objindex, "_encstr_930B07BB1B6B3854FF");
    objective_icon(var_1.objindex, "_encstr_8B1917EF50A03EA183EBFD34C1438BC72B984F7390D86B0AE9");
    objective_setlocation(var_1.objindex, var_0, var_1);
    var_1 thread laser_sights(var_1.objindex, var_2);
  }

  for(;;) {
    if(_id_142B5(0)) {
      break;
    }

    wait 0.1;
  }

  wait 1;

  if(!scripts\engine\utility::flag("_encstr_BA831CB893CF86B390F3B604A368C887ABD5CCBF63B091B458C641DF0AFB"))
    _id_12758("_encstr_9B91208C0FF56B8385F5EAADD1B1FA8CACB98E4E7B97AC19F5AC73B25B97EB580E8D");
}

_id_11F5F() {
  scripts\engine\utility::flag_wait("_encstr_86DB22B08DD8F54316DC9DB0C9BE355D3BCECAE43758EAA39BF59B382CEEDCAC467DA537");

  for(var_0 = 0; var_0 < level._id_11BD9.size; var_0++) {
    var_1 = level._id_11BD9[var_0];
    var_2 = "_encstr_8D6C1120D9285C4E8A0932E767C4CF7F4BD7C5" + var_0;
    var_1.objindex = scripts\cp\cp_objectives::requestworldid(var_2, 2);
    objective_setplayintro(var_1.objindex, 0);
    objective_setplayoutro(var_1.objindex, 0);
    objective_setownerteam(var_1.objindex, "_encstr_8E8405EA382B2A");
    objective_state(var_1.objindex, "_encstr_930B07BB1B6B3854FF");
    objective_icon(var_1.objindex, "_encstr_A13718BF3A67AAB7F81C98731DB6A7E7E8FFC9A45D6042F90BC9");
    objective_setminimapiconsize(var_1.objindex, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
    objective_setlocation(var_1.objindex, 0, var_1);
    var_1 thread laser_sights(var_1.objindex, var_2);
  }
}

_id_11F59() {
  scripts\cp\cp_objectives::freeworldid("_encstr_9A3209E0BA04C54E1FD985");
  objective_state(level.inittutzones, "_encstr_8267056410C669");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 9);
  var_0 = scripts\engine\utility::getStruct("_encstr_BE5012AA068807C9E320F57BD5BF42C9A811E350", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_83EA0D8FF51A5F7738904F56C85080", 1);
  level.inittutzones = var_1;
  objective_setplayoutro(var_1, 1);
  objective_setplayintro(var_1, 1);
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  objective_setdescription(var_1, &"_encstr_95081968A0BE4DA7FA91A4720513A85E8C94275031517DA79025D0");
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_unpinforteam(var_1, "_encstr_9A8507BA4040188D08");
  objective_setshowdistance(var_1, 1);
  objective_setbackground(var_1, 0);
  objective_setshowoncompass(var_1, 1);
  objective_setpulsate(var_1, 1);
  scripts\engine\utility::flag_clear("_encstr_8A5B16C8A57DA510C1B7A90B4B2044D84A19DFAE1B930E53");
  var_2 = getaiarray("_encstr_8E8405EA382B2A");
  var_3 = 1;
  var_4 = 1;
  scripts\engine\utility::flag_wait("_encstr_95F31722315521D788958931A04241FB624F4BC8DA1111C092");

  for(;;) {
    var_2 = getaiarray("_encstr_8E8405EA382B2A");

    if(var_4 && var_2.size > 0) {
      scripts\engine\utility::delaythread(1, ::_id_12758, "_encstr_AB982AC8830768A809CFC52808614E25F99D48E8CBA7AF745E37F163C09FCABB110B4255E8535AEFA55AEA30");
      var_4 = 0;
    }

    if(var_3 && var_2.size < 8) {
      foreach(var_7, var_6 in var_2)
      var_6 thread _id_131F5(var_7);

      var_3 = 0;
    }

    if(var_2.size <= 0) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("_encstr_BA831CB893CF86B390F3B604A368C887ABD5CCBF63B091B458C641DF0AFB");
  setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 0);
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_AA5822B79271B9181FC87079F811C878DDF3364FE925B137153958B6F9B8C1048B8D6B3B", "_encstr_9A8507BA4040188D08", 5);
  thread _id_12758("_encstr_91B228FFEA198DDB676F1F6F519951FD48B13445C0405B82C827AF2F7DB5992778D86D8C78A8041A97DB");
  wait 4;
  level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
}

_id_131F5(var_0) {
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_A3300B70BA07BB4A1719C6C8E6", 3);
  self.objindex = var_1;
  objective_setplayintro(var_1, 0);
  objective_setplayoutro(var_1, 0);
  objective_setownerteam(var_1, "_encstr_8E8405EA382B2A");
  objective_state(var_1, "_encstr_930B07BB1B6B3854FF");
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setminimapiconsize(var_1, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
  thread laser_start_ent_thermal(var_1);
  self endon("_encstr_AD75063D571AE108");
  objective_onentity(var_1, self);
  objective_setlocation(var_1, 0, self);
  objective_setzoffset(var_1, 75);
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

laser_start_ent_thermal(var_0, var_1) {
  if(isalive(self))
    self waittill("_encstr_AD75063D571AE108");

  scripts\cp\cp_objectives::freeworldid(var_1);
  objective_state(var_0, "_encstr_8267056410C669");
}

brleaderdialogteamexcludeplayer() {
  level.thermiteboltradiusdamage = [];
  wait 1;
  var_0 = scripts\engine\utility::getStructArray("_encstr_B4F515D2B996D1D216B1FAB063D8CBD7E68316EECD2BE4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_3 thread _id_12808(var_2);
    level.thermiteboltradiusdamage[level.thermiteboltradiusdamage.size] = var_3;
    waitframe();
  }

  scripts\engine\utility::flag_wait("_encstr_937C0EE68E2CC9D1F5DA5A9BE64B7BE6");
  level.brinfilsmokesuffix = scripts\engine\utility::getStructArray("_encstr_ACB615E280E893F1B8B811423A78099ECAFF8BFF6FF3AE", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    var_0 = getaiarray("_encstr_9A8507BA4040188D08");
    var_5 = level.brinfilsmokesuffix[randomint(level.brinfilsmokesuffix.size)];
    var_6 = 4;

    if(level.players.size >= 3)
      var_6 = 2;

    if(var_0.size < var_6) {
      var_3 = var_5 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
      var_3 setgoalvolumeauto(level.initnonbunkerdoorkeypad[level.initoperationcratedata]);
    }

    wait 0.2;
  }
}

_id_12808(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = getnode(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self setgoalnode(var_1);
  self.ignoreall = 1;
  self.ignoreme = 1;

  if(self.animname == "_encstr_8D7A07F007F10143A3")
    thread watchtrashcanplayerexit();
  else if(self.animname == "_encstr_8FBB061A8039F75A")
    thread brloadoutupdateammo();
  else if(self.animname == "_encstr_8DA70EB857B09347CA27B6C2CDE8B24E")
    thread _id_1294F();

  scripts\engine\utility::flag_wait("_encstr_937C0EE68E2CC9D1F5DA5A9BE64B7BE6");

  if(self.animname == "_encstr_8D7A07F007F10143A3")
    thread watchthrowingkifefireswipe();
  else if(self.animname == "_encstr_8FBB061A8039F75A")
    thread brleaderdialogplayer("_encstr_96501C320FFA3BB7D6FACCDC854CF5A3C29C5B1636FA5A9B8E4EDBFAD403");
  else if(self.animname == "_encstr_91BB06B0D81BE519")
    thread brleaderdialogplayer("_encstr_B6F41C8C1857CB8D08819CEB892BA64B979308DB0E215B455B8357063BD2");
  else if(self.animname == "_encstr_ACBB06E149F09FBA")
    thread brleaderdialogplayer("_encstr_A24C1CA113AF13A02B27D9FBB7BAA915AE1307D1E8199465CBCA78676FFA");

  self.ignoreall = 0;
  self.ignoreme = 0;
  self setgoalpos(self.origin);
  waitframe();
  self setgoalvolumeauto(level.initnonbunkerdoorkeypad[level.initoperationcratedata]);
}

watchtrashcanplayerexit() {
  wait 4;
  self playSound("_encstr_BD531DBF9B17CBDF184173534A369A02DF3C03F507EF530CC3882F03118310");
}

brloadoutupdateammo() {
  wait 6;
  self playSound("_encstr_AC531D9AD2703B3D804F94666FE98297808913927B2857B35013957C9F925A");
}

_id_1294F() {
  wait 8;
  self playSound("_encstr_8F3D200F7BC64B3A48987CB61E190B9DE3F0878BFFFBA78BEFDA556BC58778F25AC0");
}

watchthrowingkifefireswipe() {
  self playSound("_encstr_887C24913CBED97BB6FA8D66337DC6BD73472C4B379593B9F5D056B1A558E83A85D8D6BE6260");
}

brleaderdialogplayer(var_0) {
  wait(randomfloatrange(0.5, 1));
  self playSound(var_0);
}

brloadoutcratedestroycallback() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_B22A0D28E23DDBC6FB5D86F625CF43", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_84B414C263D8F2AFC959CDC6EAB226FAB9D1C957C63A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStructArray("_encstr_852A0DDA4C8371B92230CE8F1B4752", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\engine\utility::getStruct("_encstr_AF1F14A9F14827695D989B92305B0A07036522359E93", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = scripts\engine\utility::getStructArray("_encstr_8A2A0D936C8DFF89A36F8FDA8F453A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = scripts\engine\utility::getStruct("_encstr_92BC14D01AC5130E23954E4E7D877B97EA03C0C8429B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = scripts\engine\utility::getStructArray("_encstr_972A0DB0C636E5FAE4CA9BB15DACA1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = scripts\engine\utility::getStruct("_encstr_B17F14F04B94DA4FCBBF66669392D146D34310D8EF24", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 = scripts\engine\utility::array_combine(var_0, var_2, var_4, var_6);

  foreach(var_10 in var_8) {
    var_11 = var_10 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_11 thread _id_1280B(var_10);
  }

  var_1 thread _id_143DA(var_0);
  var_3 thread _id_143DA(var_2);
  var_5 thread _id_143DA(var_4);
  var_7 thread _id_143DA(var_6);
}

_id_1280B(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.ignoreme = 1;
  self.ignoreall = 1;
  var_1 = getnode(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self setgoalnode(var_1);
  scripts\common\ai::gun_remove();
  self waittill("_encstr_872A0D49A2D3E3A1CA35AF874D7723");
  scripts\common\ai::gun_recall();
  self.ignoreme = 0;
  self.ignoreall = 0;
  self setgoalpos(self.origin);
  waitframe();
  self setgoalvolumeauto(level.initialize_create_script);
}

_id_143DA(var_0) {
  for(;;) {
    var_1 = scripts\cp\utility::getplayersinradius(self.origin, self.radius);

    if(var_1.size > 0) {
      foreach(var_3 in var_0) {
        if(isalive(var_3))
          var_3 notify("_encstr_872A0D49A2D3E3A1CA35AF874D7723");
      }
    }

    wait 0.2;
  }
}

nocrash() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level._id_12C8A = [];
  level._id_1364D = 0;
  level._id_135D2["_encstr_BE3A0BEC0B47B2FA2C9C3916CB"] = [8, 10, 14, 16];
  level._id_135D2["_encstr_B6791099ED267D371DB09CA3FAB0E4E42C2F"] = [8, 15, 22, 30];
  level._id_135D2["_encstr_B2E70E18974ACEEBFA0FA0B762D32BF2"] = [10, 16, 30, 38];
  level._id_135D2["_encstr_B4390B33DE3146D785C9932C5E"] = [10, 16, 20, 28];
  level._id_135D2["_encstr_998A0DB0E26D37D1CB57BF2E52AF1A"] = [10, 16, 30, 38];
  level._id_135D2["_encstr_A3830BE4EDAE7319D73A5AAD59"] = [30, 40, 50, 60];
  level._id_135D2["_encstr_A59309838116FAEF1010C2"] = [2, 3, 4, 5];
  level._id_135D2["_encstr_888B0EEE58EC95FA6BA5B9F53AA5DA59"] = [8, 8, 10, 12];
  level._id_135D2["_encstr_AF5A081BBAC993AC73A3"] = level._id_135D2["_encstr_BE3A0BEC0B47B2FA2C9C3916CB"];
  level.player_has_grenade_crate = 1;
  level._id_11B4C = undefined;
  var_0 = 0;
  thread laps_data();

  for(;;) {
    if(!scripts\engine\utility::flag("_encstr_8A5B16C8A57DA510C1B7A90B4B2044D84A19DFAE1B930E53"))
      scripts\engine\utility::flag_wait("_encstr_8A5B16C8A57DA510C1B7A90B4B2044D84A19DFAE1B930E53");

    if(isDefined(level.players))
      var_0 = level.players.size - 1;

    var_1 = level._id_135D2["_encstr_AF5A081BBAC993AC73A3"][var_0];
    var_2 = level._id_135D2["_encstr_A59309838116FAEF1010C2"][var_0];
    var_3 = var_1 + 4;
    var_4 = gettime() + level._id_135D2["_encstr_A3830BE4EDAE7319D73A5AAD59"][var_0] * 1000;

    for(;;) {
      if(level.player_has_grenade_crate) {
        level.player_has_grenade_crate = 0;
        break;
      } else if(spawned_enemies() <= var_2) {
        var_5 = gettime() + level._id_135D2["_encstr_888B0EEE58EC95FA6BA5B9F53AA5DA59"][var_0] * 1000;

        for(;;) {
          if(level.player_has_grenade_crate) {
            level.player_has_grenade_crate = 0;
            break;
          } else if(gettime() >= var_5 || gettime() >= var_4) {
            break;
          }

          wait 0.2;
        }

        break;
      } else if(gettime() >= var_4) {
        break;
      }

      wait 0.2;
    }

    while(isDefined(level._id_11B4C) && level._id_11B4C <= 0)
      wait 0.2;

    for(var_6 = 0; var_6 < var_1; var_6++) {
      var_7 = getaiarray("_encstr_8E8405EA382B2A");

      if(spawned_enemies() <= var_3 && var_7.size <= 30) {
        var_8 = _id_12DAC();
        var_9 = var_8 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
        level._id_12C8A[level._id_12C8A.size] = var_9;
      }

      wait(randomfloatrange(0.4, 0.7));
    }

    if(isDefined(level._id_11B4C))
      level._id_11B4C--;

    if(!scripts\engine\utility::flag("_encstr_A6240EB0B9E6C2ABB18E98EBDE3BCA27"))
      scripts\engine\utility::flag_wait("_encstr_A6240EB0B9E6C2ABB18E98EBDE3BCA27");
  }
}

laps_data() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\engine\utility::getStruct("_encstr_BE5012AA068807C9E320F57BD5BF42C9A811E350", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    var_1 = getaiarray("_encstr_8E8405EA382B2A");

    if(var_1.size > 30) {
      var_2 = var_0 prohibited_weapon_list();

      if(isDefined(var_2))
        laser_end_pos(var_2);
      else
        wait 0.5;

      continue;
    }

    wait 0.5;
  }
}

laser_end_pos(var_0) {
  var_1 = sortbydistance(level._id_12C8A, var_0.origin);
  var_2 = var_1.size - 1;

  for(var_3 = var_2; var_3 >= 0; var_3--) {
    if(isDefined(var_1[var_3]) && isalive(var_1[var_3])) {
      var_1[var_3] kill();
      return;
    }
  }
}

spawned_enemies() {
  level._id_12C8A = scripts\engine\utility::array_removedead_or_dying(level._id_12C8A);
  level._id_12C8A = scripts\engine\utility::array_removeundefined(level._id_12C8A);
  return min(level._id_12C8A.size, 32);
}

_id_12DAC() {
  if(level._id_1364D >= level.initlocs_keypads.size)
    level._id_1364D = 0;

  var_0 = level.initlocs_keypads[level._id_1364D];
  level._id_1364D++;
  return var_0;
}

postspawn_axis() {
  self endon("_encstr_AD75063D571AE108");
  waitframe();
  self setgoalvolumeauto(level.initnonbunkerdoors[level.initoperationcratedata]);
  var_0 = scripts\engine\utility::getclosest(self.origin, level.players);
  self getenemyinfo(var_0);
}

_id_13506() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_A11E10030FF37760BCCB9B0EB780A0360AE7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = getnode(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_4 = var_2 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_4._id_13FBA = "_encstr_B4D40B33168D3631C26C5BFA99";
    var_4 thread _id_13092(var_3, 1);
    wait 0.2;
  }
}

_id_13092(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self.matchdata_logchallenge = 1;

  if(isDefined(var_1) && var_1)
    teleport_ai_to_cover_node(var_0);

  for(var_2 = 0; var_2 <= 10; var_2++) {
    self.goalradius = 4;
    self.fixednode = 1;
    self setgoalnode(var_0);
    wait 0.1;
  }

  if(isDefined(self._id_13FBA)) {
    scripts\engine\utility::flag_wait(self._id_13FBA);
    self.matchdata_logchallenge = undefined;
  }
}

_id_13093(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0.target)) {
    var_1 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = getnode(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    for(var_3 = 0; var_3 <= 10; var_3++) {
      self.goalradius = 64;

      if(isDefined(var_1))
        self setgoalpos(var_1.origin);
      else
        self setgoalnode(var_2);

      wait 0.1;
    }
  }
}

_id_135DB(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    foreach(var_5 in var_0) {
      var_6 = var_5 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
      var_2[var_2.size] = var_6;
      wait 0.1;
    }

    wait 1;
  }

  return var_2;
}

spawn_group(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::getStructArray(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 = undefined;

  foreach(var_10 in var_7) {
    var_11 = var_10 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);

    switch (var_0) {
      case "_encstr_850707F7E5833355B8":
        var_11 thread _id_1280D(var_10, var_2, var_3);
        break;
      case "_encstr_A11904E483B3":
        var_11 thread _id_1280C(var_10, var_2, var_3);
        var_8 = var_11;
        break;
      case "_encstr_B4920771CA8F0618B2":
        var_11 thread _id_12807(var_10);
        break;
    }

    if(isDefined(var_4))
      var_11 thread _id_12C88(var_0, var_10, var_2, var_4, var_5, var_6);

    wait 0.1;
  }

  if(isDefined(var_0) && var_0 == "_encstr_B4920771CA8F0618B2" && isDefined(var_8) && isalive(var_8))
    scripts\engine\utility::delaythread(2, ::_id_12420, var_8, "_encstr_B6331F9D2877D3D11FF0FF905DEB5F0F105B1E94616090A20233D97E88F01AFFC0");
}

_id_12C88(var_0, var_1, var_2, var_3, var_4, var_5) {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_5))
    wait(var_5);
  else
    wait(randomfloatrange(7, 10));

  if(scripts\engine\utility::flag(var_3)) {
    return;
  }
  switch (var_0) {
    case "_encstr_850707F7E5833355B8":
      var_6 = var_1 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
      var_6 thread _id_1280D(var_1, var_2);

      if(isDefined(var_3)) {
        var_7 = var_4 - 1;

        if(var_7 > 0)
          var_6 thread _id_12C88("_encstr_850707F7E5833355B8", var_1, var_2, var_3, var_7, var_5);
      }

      break;
    case "_encstr_A11904E483B3":
      var_6 = var_1 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
      var_6 thread _id_1280C(var_1, var_2);

      if(isDefined(var_3)) {
        var_7 = var_4 - 1;

        if(var_7 > 0)
          var_6 thread _id_12C88("_encstr_A11904E483B3", var_1, var_2, var_3, var_7, var_5);
      }

      break;
  }
}

_id_1280C(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  thread _id_12DC4(var_2);

  if(!istrue(var_1))
    self.matchdata_logchallenge = 1;

  wait 0.2;
  var_3 = getnode(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(scripts\engine\utility::flag("_encstr_A2D40B270F1902AAE1C8779F62"))
    teleport_ai_to_cover_node(var_3);

  self setgoalnode(var_3);
  self.goalradius = 4;
  self.fixednode = 1;
  wait 0.5;
  self.goalradius = 4;
}

_id_12DC4(var_0) {
  if(isDefined(var_0))
    level endon(var_0);

  self waittill("_encstr_AD75063D571AE108", var_1);

  if(level._id_123DA && isDefined(var_1) && isPlayer(var_1))
    _id_123DB(var_1, "_encstr_B14C209187AF8D316CD7D5B96B64D7A573997B395BEB6DA58DC6999693B67DE438D9");
}

_id_123DB(var_0, var_1) {
  level._id_123DA = 0;

  if(isalive(var_0))
    var_0 playsoundtoteam(var_1, "_encstr_9A8507BA4040188D08");

  wait 4;
  level._id_123DA = 1;
}

_id_1280D(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  thread _id_13439(var_2);

  if(!istrue(var_1))
    self.matchdata_logchallenge = 1;

  wait 0.2;
  var_3 = getnode(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(scripts\engine\utility::flag("_encstr_A2D40B270F1902AAE1C8779F62"))
    teleport_ai_to_cover_node(var_3);

  self setgoalnode(var_3);
  self.goalradius = 4;
  self.fixednode = 1;
  wait 0.5;
  self.goalradius = 4;
}

_id_13439(var_0) {
  if(isDefined(var_0))
    level endon(var_0);

  self waittill("_encstr_AD75063D571AE108", var_1);

  if(level._id_123DA && isDefined(var_1) && isPlayer(var_1))
    _id_123DB(var_1, "_encstr_8B262451C0BF88DFCA8F13D7935387D15B9DF8292EFC611A526B29C5871BE189E335E0E35742");
}

_id_12807(var_0) {
  self endon("_encstr_AD75063D571AE108");
  thread create_opaque_ai_contents();
}

create_opaque_ai_contents() {
  self waittill("_encstr_AD75063D571AE108", var_0);

  if(level._id_123DA && isDefined(var_0) && isPlayer(var_0))
    _id_123DB(var_0, "_encstr_B8ED240B5876CDA36DAFEB64F439CFB79978A7AB38CB07DA53A1B55F6B1DC26F01103F23E0A3");
}

_id_13574() {
  scripts\engine\utility::flag_wait_any("_encstr_88360F51B82869FBFDDF2824EBDA5B8730", "_encstr_B4D40B33168D3631C26C5BFA99");
  thread _id_13578("_encstr_9B741CB7D7963A5D40939AD948509792652D032F73BD8113C819C39D4140", "_encstr_A2DE1BD95815F1400D7A0FAA32665FBB9B3F6FA8DA60BB382099F920BB", "_encstr_B23C1F2CD836F599B74CEB355D7676569CCD58EA3ADC7DB9E0C2BBE6CA91FAB437");
  thread _id_11F5C();
}

_id_13578(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_7, var_5 in level.players) {
    if(var_7 == 3) {
      continue;
    }
    var_6 = var_3[var_7] scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_6 thread _id_12809(var_7);
    var_6 thread vehicle_mp_deletenextframe(var_7);
    level._id_11BD9[level._id_11BD9.size] = var_6;

    if(!scripts\engine\utility::flag(var_1)) {
      scripts\engine\utility::flag_set(var_1);
      scripts\engine\utility::flag_clear("_encstr_8A5B16C8A57DA510C1B7A90B4B2044D84A19DFAE1B930E53");
      var_6 thread check_player_used_tacmap();
    }

    wait 1;
  }

  scripts\engine\utility::flag_set(var_2);
}

_id_13579(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_7, var_5 in level.players) {
    if(var_7 >= 2) {
      continue;
    }
    var_6 = var_3[var_7] scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_6 thread _id_12809(var_7);
    var_6 thread vehicle_mp_deletenextframe(var_7);
    level._id_11BD9[level._id_11BD9.size] = var_6;

    if(!scripts\engine\utility::flag(var_1)) {
      scripts\engine\utility::flag_set(var_1);
      setmusicstate("_encstr_9B03144F77D1D2ABE76911ABFD69D8B3E17F3E2B7E28");
      var_6 thread check_player_used_tacmap();
    }

    wait 1;
  }

  scripts\engine\utility::flag_set(var_2);
}

check_player_used_tacmap() {
  wait 3;

  if(isalive(self))
    thread _id_12420(self, "_encstr_86052B6B38166D03CDA04BC414D92F175B28CB1F69C8D10A394E13BA8D9BC2E346983F9710E102727B651BF9E0");

  wait 2.5;
  _id_12758("_encstr_A2442132E17D6B3816BEAEB53A1BBED45DCEB32B9C9BC2EA47D7B29B2BADCBBED56E2B");
}

_id_12809(var_0) {
  self endon("_encstr_AD75063D571AE108");
  childthread vehicle_mp_deletenextframelate();
  self.minpaindamage = 1000;
  self.minpainvalue = 1000;
  self.stuncooldown = 0;
  self.allowpain = 0;
  self.goalheight = 25;
  self.cautiousnavigation = 0;
  self.juggernautwalkdist = 250;
  self.juggernautgoalradius = 25;
  self.juggernautcanseeenemydelaymin = 500;
  self.juggernautcanseeenemydelaymax = 1000;
  self.runcooldown = 2000;
  self.juggernautacceleration = 100;
  self.juggernautrundelaymin = 250;
  self.juggernautrundelaymax = 750;
  scripts\cp\laser_traps\cp_laser_traps::disable_surprise();
  self.matchdata_logchallenge = 1;

  if(level.gameskill <= 2)
    self.juggernautstopdistance = 500;
  else
    self.juggernautstopdistance = 600;

  if(isDefined(level.players[var_0])) {
    self getenemyinfo(level.players[var_0]);
    self.favoriteenemy = level.players[var_0];
  }

  childthread scripts\cp\laser_traps\cp_laser_traps::_id_13F98();
  self.dropweapon = 0;
}

vehicle_mp_deletenextframelate() {
  if(!isalive(self)) {
    return;
  }
  for(;;) {
    var_0 = scripts\engine\utility::_id_143AD("_encstr_B2BE0788BAF573592F", "_encstr_ABE70A08F0C68B546D12A8E7");

    if(var_0 == "_encstr_B2BE0788BAF573592F") {
      if(!self.stuncooldown && _id_1459D()) {
        self.stuncooldown = 1;
        childthread juggernaut_pain_cooldown();
      } else if(!_id_11CA4())
        continue;
    }

    self.allowpain = 1;
    wait 0.05;
    self.minpaindamage = 0;
    self dodamage(10, self.damagepoint, self.is_specops_gametype);
    self.minpaindamage = self.minpainvalue;
    wait 0.05;
    self.allowpain = 0;
  }
}

_id_1459D() {
  if(!isDefined(self.damageweapon))
    return 0;

  var_0 = scripts\cp\utility::getbaseweaponname(self.damageweapon);

  if(var_0 == "_encstr_B4190F4BDDC1BE9BB9D70BB10786584D0C" || var_0 == "_encstr_8A5C0FA8E32097400C0797904EA782221F")
    return 1;

  return 0;
}

_id_11CA4() {
  if(!isDefined(self.damagemod))
    return 0;

  if(self.damagemod == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || self.damagemod == "_encstr_911B0C7DA090E9A7F799FD50DD48" || self.damagemod == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
    return 1;

  return 0;
}

juggernaut_pain_cooldown() {
  self notify("_encstr_A907136BF11082F388E0624BAEFEE7BD1049FFD76D");
  self endon("_encstr_A907136BF11082F388E0624BAEFEE7BD1049FFD76D");
  wait 7;
  self.stuncooldown = 0;
}

vehicle_mp_deletenextframe(var_0) {
  self waittill("_encstr_AD75063D571AE108", var_1, var_2, var_3, var_4);
  var_5 = self.origin;
  var_6 = self.angles;
  level._id_11BD9 = scripts\engine\utility::array_remove(level._id_11BD9, self);

  if(!scripts\engine\utility::flag("_encstr_81C910CF78C0230BE895EFAFE7B0526DF061")) {
    scripts\engine\utility::flag_set("_encstr_81C910CF78C0230BE895EFAFE7B0526DF061");
    thread check_missiles_reloaded_vo();
    thread minecart(var_5, var_6);
  }
}

check_missiles_reloaded_vo() {
  level endon("_encstr_BA831CB893CF86B390F3B604A368C887ABD5CCBF63B091B458C641DF0AFB");
  wait 3.5;
  _id_12758("_encstr_B10E18461EEBDA83B0AFAB6DD1637D89DBB7CDD1FA4E5DB3C497");
}

vehicle_damage_registerdefaultstates(var_0) {
  if(level._id_11BD9.size <= var_0)
    return 1;

  return 0;
}

minecart(var_0, var_1) {
  var_2 = _id_12F4F(var_0, var_1, ::script_model_pilot_kill_watch, "_encstr_B14616C0DA2711E973B47864858F93E30A2348D013FEA782", &"_encstr_ACDE245381A1B18FF9C225F10463EFF07440A50E88E409312DAFC90A3045F779C194D5803928", "_encstr_A9691F1ABA46EBB48DEDCDEBDA4BB1C6378EE49558D6F5535D9D765639CD585D8E", ::vehicle_occupancy_cp_takeriotshield, 1);
}

script_model_pilot_kill_watch(var_0, var_1) {
  var_2 = scripts\cp\loot_system::get_empty_munition_slot(var_1);

  if(isDefined(var_2)) {
    var_1.vehicle_occupancy_cp_handlesuicidefromvehicles = "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
    scripts\cp\laser_traps\cp_laser_traps::_id_124A5(var_1, "_encstr_8BFC0BC2CBD4F737E0A5E1FD79");
    var_0.valve_steam_on = 1;
  } else
    var_1 scripts\cp\utility::hint_prompt("_encstr_B6A9145BAE37D2A396B7B97DDC63DB1D9BBE33BA1B1B", 1, 2);
}

vehicle_occupancy_cp_takeriotshield(var_0) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  thread _id_13F92(var_0, "_encstr_8BFC0BC2CBD4F737E0A5E1FD79");
}

display_ai() {
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

      if(var_7 < 9)
        var_8 = var_1;
      else if(var_7 < 25)
        var_8 = var_0;
      else
        var_8 = var_2;

      var_4 = var_4 + 15;
    }

    waitframe();
  }
}

_id_135EC(var_0) {
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\common\utility::spawn_vehicle();
    var_4 thread _id_1280E();
  }
}

_id_1280E() {
  thread scripts\common\vehicle_paths::gopath(self);
  wait 1;
  self setwaitspeed(0);
  var_0 = scripts\engine\utility::_id_143AD("_encstr_AD75063D571AE108", "_encstr_83F31382ADE312408110479F407814999FBFCFFF85");
  self vehicleshowonminimap(0);

  if(isDefined(var_0) && var_0 == "_encstr_83F31382ADE312408110479F407814999FBFCFFF85") {
    wait 1.5;
    self vehicle_turnengineoff();
  }
}

_id_13566() {
  scripts\engine\utility::flag_wait_any("_encstr_A2D40B270F1902AAE1C8779F62", "_encstr_86CC0F0868CF6AE15ADEA835E2E581933C");
  level.solution_exists_already = [];
  var_0 = getEntArray("_encstr_A923138847DFF0BD53365CE8815AA75B49CF685822", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "_encstr_A5AD056A019C63" && level.players.size > 2) {
      var_3 = var_2 scripts\common\utility::spawn_vehicle();
      var_3 thread silo_door_left();
      var_3 thread skipsplash("_encstr_863A0999DF8AFBA93E8529", "_encstr_A5AD056A019C63", ::solutions);
      level.solution_exists_already[level.solution_exists_already.size] = var_3;
    } else if(var_2.script_noteworthy == "_encstr_8253060E2B5FE330") {
      var_3 = var_2 scripts\common\utility::spawn_vehicle();
      var_3 thread silo_door_left();
      var_3 thread skipsplash("_encstr_863A0999DF8AFBA93E8529", "_encstr_8253060E2B5FE330", ::solutions);
      level.solution_exists_already[level.solution_exists_already.size] = var_3;
    }

    wait 1.5;
  }

  scripts\engine\utility::flag_set("_encstr_8ED916EBE2A96FCF533AB3B0072A153D290A53204778CFD9");
  wait 3;

  if(isDefined(level.solution_exists_already[0]))
    _id_12420(level.solution_exists_already[0], "_encstr_A3EF1E5C0BDE8732EDD94BA238E9BA97D37BAED730E1C7FD973063F9B00B6703");
}

solutions(var_0) {
  if(level.solution_exists_already.size <= var_0)
    return 1;

  return 0;
}

_id_13567() {
  level.sort_goal_positions_by_priority = [];
  var_0 = getEnt("_encstr_83ED18B7D380EA4AB0318BD5EEF083D367230B7BFF28120F5873", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0 scripts\common\utility::spawn_vehicle();
  var_1._id_1385B = scripts\engine\utility::getStruct("_encstr_8DAB0A0C79D2839053678637", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1.player_too_far = 1;
  var_1.player_test_ending_teleport = "_encstr_A3FC14AB9379E37006F6B7925B614C5F1B9B0113234B";
  var_1 thread silo_door_runners();
  var_1 thread skipsplash(undefined, undefined, ::sort_wave_spawning_ai);
  level.sort_goal_positions_by_priority[level.sort_goal_positions_by_priority.size] = var_1;
  wait 1;
  scripts\engine\utility::flag_set("_encstr_8DAF1A86B2C62DEB856E6EB0AB361DCCEBCCBD89EBDC8316BB9BACC8");
}

_id_13568() {
  level.solved = [];
  var_0 = getEntArray("_encstr_BA23137E0BD94C3A2ED3D3BF475FD3ABC013B583EB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_noteworthy)) {
      continue;
    }
    if(var_2.script_noteworthy == "_encstr_A5AD056A019C63" && level.players.size > 2) {
      var_2.count++;
      var_3 = var_2 scripts\common\utility::spawn_vehicle();
      var_3 thread silo_door_right();
      var_3 thread skipsplash("_encstr_813E0C893D4D18E0EB52F0D93AEB", "_encstr_A5AD056A019C63", ::sort_by_ai_assigned);
      level.solved[level.solved.size] = var_3;
    } else if(var_2.script_noteworthy == "_encstr_8253060E2B5FE330") {
      var_2.count++;
      var_3 = var_2 scripts\common\utility::spawn_vehicle();
      var_3 thread silo_door_right();
      var_3 thread skipsplash("_encstr_813E0C893D4D18E0EB52F0D93AEB", "_encstr_8253060E2B5FE330", ::sort_by_ai_assigned);
      level.solved[level.solved.size] = var_3;
    }

    wait 1.5;
  }

  scripts\engine\utility::flag_set("_encstr_AD2D16A1CA8DA5EBB0379B165D8D8E33BEDC1C0B77E62BC8");
  wait 3;

  if(isDefined(level.solved[0]))
    _id_12420(level.solved[0], "_encstr_A3EF1E5C0BDE8732EDD94BA238E9BA97D37BAED730E1C7FD973063F9B00B6703");
}

sort_wave_spawning_ai(var_0) {
  if(level.sort_goal_positions_by_priority.size <= var_0)
    return 1;

  return 0;
}

sort_by_ai_assigned(var_0) {
  if(level.solved.size <= var_0)
    return 1;

  return 0;
}

sortbylastzombietime(var_0) {
  if(level.sortbyhvttags.size <= var_0)
    return 1;

  return 0;
}

_id_13569() {
  level.sortbyhvttags = [];
  var_0 = getEntArray("_encstr_BA23137E0BD94C3A2ED3D3BF475FD3ABC013B583EB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_noteworthy)) {
      continue;
    }
    if(var_2.script_noteworthy == "_encstr_A5AD056A019C63" && level.players.size > 2) {
      var_2.count++;
      var_3 = var_2 scripts\common\utility::spawn_vehicle();
      var_3 thread silo_jump_dogtag_revive();
      var_3 thread skipsplash("_encstr_ABD910BA9109E79108933607ABE0A91FA029", "_encstr_A5AD056A019C63", ::sortbylastzombietime);
      level.sortbyhvttags[level.sortbyhvttags.size] = var_3;
    } else if(var_2.script_noteworthy == "_encstr_8253060E2B5FE330") {
      var_2.count++;
      var_3 = var_2 scripts\common\utility::spawn_vehicle();
      var_3 thread silo_jump_dogtag_revive();
      var_3 thread skipsplash("_encstr_ABD910BA9109E79108933607ABE0A91FA029", "_encstr_8253060E2B5FE330", ::sortbylastzombietime);
      level.sortbyhvttags[level.sortbyhvttags.size] = var_3;
    }

    wait 1.5;
  }

  scripts\engine\utility::flag_set("_encstr_92F61D40157ADCCF075E33C265289542276BE270FFDEC2C60380B3685B2FCD");
  wait 3;

  if(isDefined(level.sortbyhvttags[0]))
    _id_12420(level.sortbyhvttags[0], "_encstr_A3EF1E5C0BDE8732EDD94BA238E9BA97D37BAED730E1C7FD973063F9B00B6703");
}

skipsplash(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self._id_11D97 = undefined;

  if(isDefined(var_1))
    self._id_11D97 = protect_jammer(var_0, var_1);

  self setvehgoalpos(self._id_1385B.origin, 1);
  wait 0.05;
  self settargetyaw(self._id_1385B.angles[1]);
  self sethoverparams(150, 10, 3);
  self setCanDamage(1);
  self setvehicleteam("_encstr_8E8405EA382B2A");
  self.script_team = "_encstr_8E8405EA382B2A";
  self.script_bulletshield = 0;
  self.waittill_any_timeout_no_endon_death_3 = 0;
  self.godmode = 0;
  self.healthbuffer = 17000;
  childthread heli_crash_on_pilot_death();
  var_3 = "_encstr_859B0CB3D94487E548C7786C9FBA";
  var_4 = (30, -11.511, 4);
  var_5 = self gettagorigin(var_3);
  self._id_11C2E = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_5, "_encstr_81AE1A48C3E2F9F32D40F0134067C113C7AE9B309610797F090DD9A8");
  self._id_11C2E.angles = self gettagangles(var_3);
  self._id_11C2E setModel("_encstr_AB941C74699CD92047B045DF89932839900CE0D293E9DA7F34D38382FAB3");
  self._id_11C2E linkTo(self, var_3, var_4, (6, 0, 0));
  self._id_11C2E makeunusable();
  self._id_11C2E setmode("_encstr_849007B268BD03DFD8");
  self._id_11C2E setdefaultdroppitch(0);
  self._id_11C2E setleftarc(180);
  self._id_11C2E setrightarc(180);
  self._id_11C2E settoparc(180);
  self._id_11C2E setbottomarc(180);
  self._id_11C2E setturretteam("_encstr_8E8405EA382B2A");
  wait 1.5;
  self vehicleshowonminimap(1);
  self aiupdatecoverexposetype(1);
  self.player_controls_failsafe = 1;

  for(;;) {
    var_6 = prohibited_weapon_list();

    if(!isDefined(var_6)) {
      waitframe();
      continue;
    }

    self setlookatent(var_6);
    self._id_11C2E settargetentity(var_6);

    if(scripts\engine\utility::flag("_encstr_81E80F2113CBBB47B8035E1958FBEBA25C") && isDefined(self.player_too_far) && self.player_too_far) {
      if(!scripts\engine\utility::flag("_encstr_AD2D1385E66E85AE364799F5992C8DC6C458D85B33"))
        childthread _id_137B0(self._id_1385B);
      else
        self._id_11D97 = protect_jammer("_encstr_813E0C893D4D18E0EB52F0D93AEB", "_encstr_8253060E2B5FE330");
    }

    var_7 = heli_shoot_player(var_6);

    if(!var_7 && isDefined(self._id_11D97)) {
      var_6 = prohibited_weapon_list();

      if(!isDefined(var_6)) {
        waitframe();
        continue;
      }

      var_8 = [[var_2]](1);

      if(!self.waittill_any_timeout_no_endon_death_3 && var_8) {
        self._id_11D97 = self.called50percentprogress;
        self.waittill_any_timeout_no_endon_death_3 = 1;
      }

      var_9 = self._id_11D97;
      var_9 = sortbydistance(var_9, var_6.origin);
      var_10 = var_9[0];

      if(distancesquared(var_6.origin, var_10.origin) <= squared(1000))
        var_10 = var_9[1];

      self setvehgoalpos(var_10.origin, 1);
      wait 0.05;
      self settargetyaw(var_10.angles[1]);
      continue;
    }

    wait 0.05;
  }
}

_id_137B0(var_0) {
  self.player_too_far = 0;
  wait 1;
  var_1 = scripts\engine\utility::getStruct(self.player_test_ending_teleport, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread scripts\common\vehicle::vehicle_paths(var_1);
  self waittill("_encstr_AC26197DFDCE88BB1FC296F9FBDBE72064539FF161F39868277A09");
  self setvehgoalpos(var_0.origin, 1);
  wait 0.05;
  self settargetyaw(var_0.angles[1]);
  wait 8;
  self.player_too_far = 1;
}

prohibited_weapon_list(var_0) {
  var_1 = sortbydistance(level.players, self.origin);

  foreach(var_3 in var_1) {
    if(!scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      if(isDefined(var_0) && var_0) {
        var_4 = scripts\engine\utility::getStructArray("_encstr_8CC20D6BB79CE8584EFA1D9C58D895", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

        if(scripts\engine\trace::ray_trace_passed(var_4[0].origin, var_3 getEye(), [var_3]))
          return var_3;
        else if(scripts\engine\trace::ray_trace_passed(var_4[1].origin, var_3 getEye(), [var_3]))
          return var_3;
      } else
        return var_3;
    }
  }

  return undefined;
}

proprotate(var_0) {
  var_1 = sortbydistance(level.players, self.origin);

  if(var_1.size > 1)
    var_1 = scripts\engine\utility::array_reverse(var_1);

  foreach(var_3 in var_1) {
    if(!scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      if(isDefined(var_0) && var_0) {
        var_4 = scripts\engine\utility::getStructArray("_encstr_8CC20D6BB79CE8584EFA1D9C58D895", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

        if(scripts\engine\trace::ray_trace_passed(var_4[0].origin, var_3 getEye(), [var_3]))
          return var_3;
        else if(scripts\engine\trace::ray_trace_passed(var_4[1].origin, var_3 getEye(), [var_3]))
          return var_3;
      } else
        return var_3;
    }
  }

  return undefined;
}

protect_jammer(var_0, var_1) {
  var_2 = [];
  self.called50percentprogress = scripts\engine\utility::getStructArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_4 in self.called50percentprogress) {
    if(isDefined(var_4.script_parameters) && var_4.script_parameters == var_1) {
      var_2[var_2.size] = var_4;
      continue;
    }

    if(isDefined(var_4.script_parameters) && var_4.script_parameters == var_1 + "_encstr_B4810709B378B9F3F5") {
      var_2[var_2.size] = var_4;
      self._id_1385B = var_4;
    }
  }

  if(!isDefined(self._id_1385B))
    self._id_1385B = var_2[0];

  return var_2;
}

heli_shoot_player(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(var_1 = 0; var_1 < 3 && isalive(var_0) && !var_0.inlaststand; var_1++) {
    var_2 = 0;
    var_3 = gettime() + 2000;

    while(gettime() < var_3) {
      var_4 = self._id_11C2E gettagorigin("_encstr_A14F0AE336178944BA076F41");
      var_5 = self._id_11C2E gettagangles("_encstr_A14F0AE336178944BA076F41");
      var_6 = var_0.origin + (0, 0, 20);

      if(scripts\engine\utility::within_fov(var_4, var_5, var_6, 0.99) && scripts\engine\trace::ray_trace_passed(var_4, var_6, [self, self._id_11C2E, var_0])) {
        var_2 = 1;
        break;
      }

      wait 0.1;

      if(!isalive(var_0) || var_0.inlaststand)
        return;
    }

    if(!var_2)
      return var_2;

    self._id_11C2E startbarrelspin();
    wait 1.4;

    if(self.player_controls_failsafe) {
      var_0 scripts\engine\utility::delaycall(0.5, ::playsoundtoteam, "_encstr_A6D527233CD7B50E837DAE5B991D13F56CBDB6132CE8F55A9BCC7B27DAD7D158ADB4E63BAFCC5A2756", "_encstr_9A8507BA4040188D08");
      self.player_controls_failsafe = 0;
    }

    for(var_7 = 0; var_7 < 30; var_7++) {
      self._id_11C2E shootturret();
      wait 0.1;

      if(!isalive(var_0) || var_0.inlaststand) {
        break;
      }
    }

    self._id_11C2E stopbarrelspin();
    wait 0.8;
    return var_2;
  }
}

silo_door_left() {
  while(!isDefined(self.driver))
    wait 0.1;

  scripts\engine\utility::waittill_any_ents(self, "_encstr_AD75063D571AE108", self.driver, "_encstr_AD75063D571AE108");
  level.solution_exists_already = scripts\engine\utility::array_remove(level.solution_exists_already, self);

  if(isDefined(self))
    _id_12420(self, "_encstr_B150227B19483290C83E931C711099693E5FC7EB9305D9734860CD2788181DA103D34B67");
}

silo_door_runners() {
  while(!isDefined(self.driver))
    wait 0.1;

  scripts\engine\utility::waittill_any_ents(self, "_encstr_AD75063D571AE108", self.driver, "_encstr_AD75063D571AE108");
  level.sort_goal_positions_by_priority = scripts\engine\utility::array_remove(level.sort_goal_positions_by_priority, self);

  if(isDefined(self))
    _id_12420(self, "_encstr_B150227B19483290C83E931C711099693E5FC7EB9305D9734860CD2788181DA103D34B67");
}

silo_door_right() {
  while(!isDefined(self.driver))
    wait 0.1;

  scripts\engine\utility::waittill_any_ents(self, "_encstr_AD75063D571AE108", self.driver, "_encstr_AD75063D571AE108");
  level.solved = scripts\engine\utility::array_remove(level.solved, self);

  if(isDefined(self))
    _id_12420(self, "_encstr_B150227B19483290C83E931C711099693E5FC7EB9305D9734860CD2788181DA103D34B67");
}

silo_jump_dogtag_revive() {
  while(!isDefined(self.driver))
    wait 0.1;

  scripts\engine\utility::waittill_any_ents(self, "_encstr_AD75063D571AE108", self.driver, "_encstr_AD75063D571AE108");
  level.sortbyhvttags = scripts\engine\utility::array_remove(level.sortbyhvttags, self);

  if(isDefined(self))
    _id_12420(self, "_encstr_B150227B19483290C83E931C711099693E5FC7EB9305D9734860CD2788181DA103D34B67");
}

heli_crash_on_pilot_death() {
  while(!isDefined(self.driver))
    wait 0.1;

  self.driver.health = self.driver.health + 100;
  self.driver waittill("_encstr_AD75063D571AE108");

  if(scripts\common\vehicle::vehicle_is_crashing()) {
    return;
  }
  self dodamage(self.health - self.healthbuffer + 1, self.origin);
}

_id_135F2() {
  level._id_142B4 = [];
  var_0 = getEntArray("_encstr_BD6A0E2B419BC9EBB2C18808AA4FB341", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_4, var_2 in var_0) {
    if(isDefined(var_2.targetname) && var_2.targetname == "_encstr_BE3A09CE4BE6324B2C0C19" && level.players.size <= 2) {
      continue;
    }
    var_3 = var_2 scripts\common\vehicle::spawn_vehicle_and_gopath();
    var_3 thread _id_1280F(var_4);
    level._id_142B4[level._id_142B4.size] = var_3;
  }

  scripts\engine\utility::flag_wait("_encstr_915F1718D20DA7D387461D832187BE87726A30E8FAA76FC843");
  var_5 = 1;

  foreach(var_3 in level._id_142B4) {
    if(var_5 && isDefined(var_3)) {
      _id_12420(var_3, "_encstr_AF6C267DBBB9AB52D0FF8B8AD833A7D723DB988731811D2DDBE3288023AB947ABA4A966A2A67C3DA");
      wait 2.5;

      if(isDefined(var_3))
        _id_12758("_encstr_A6AB1E07FB41EF5702CF9B473B0BA988FB6F53E3F5A22F8D527B6D39C1CE89BB");

      var_5 = 0;
    }
  }
}

_id_1280F(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.team = "_encstr_8E8405EA382B2A";
  self.nodeath = 1;
  scripts\common\vehicle::godon();
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(self);
  self.mainturret turretfiredisable();
  self.mainturret stopfiring();
  self.mainturret makeunusable();
  self.mgturret[0] setmode("_encstr_849007B268BD03DFD8");
  self.mgturret[0] makeunusable();
  self.mgturret[0] hide();
  var_1 = getEnt("_encstr_BD11112390C8DC221F176F5B4FBDBA1958585B" + (var_0 + 1), "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = 3;
  var_1.origin = self.mainturret gettagorigin("_encstr_81B71713BFDFE17E535893E3C1CB257B8DC59B41916BBA887B");
  var_1.origin = var_1.origin + anglesToForward(var_1.angles) * var_2;
  var_1.angles = self.mainturret gettagangles("_encstr_81B71713BFDFE17E535893E3C1CB257B8DC59B41916BBA887B");
  var_1.angles = var_1.angles + (10, 0, 0);
  var_1 linkTo(self.mainturret, "_encstr_81B71713BFDFE17E535893E3C1CB257B8DC59B41916BBA887B");
  var_1.og_intensity = var_1 getlightintensity();
  var_1 setlightintensity(0);
  thread _id_14447();
  thread _id_1444C();
  thread _id_1444E();
  thread watch_for_death(var_1);
  scripts\engine\utility::flag_wait("_encstr_B89313CD8E58E41DF5EC96374696C2F5E66CCA9B2B");

  if(!scripts\engine\utility::flag("_encstr_915F1718D20DA7D387461D832187BE87726A30E8FAA76FC843"))
    scripts\engine\utility::flag_set("_encstr_915F1718D20DA7D387461D832187BE87726A30E8FAA76FC843");

  scripts\common\vehicle::godoff();
  self.ignoreall = 0;
  self.ignoreme = 0;
  thread scripts\common\vehicle::vehicle_lights_on("_encstr_8F330BBBD79A4108E9E730C8AF");
  wait 0.5;
  var_1 setlightintensity(var_1.og_intensity);
  wait 1;
  self.mainturret turretfireenable();
  self.mainturret startfiring();
  var_3 = cos(10);
  thread _id_13A3F();

  for(;;) {
    while(!_id_13E6F(var_3))
      wait 0.1;

    while(_id_13E6F(var_3)) {
      for(var_4 = 0; var_4 < randomintrange(4, 5); var_4++) {
        self.mainturret shootturret();
        wait(randomfloatrange(0.2, 0.4));
      }

      wait(randomintrange(2, 4));
    }
  }
}

_id_13E6F(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = sortbydistance(level.players, self.origin);

  foreach(var_3 in var_1) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }
    if(scripts\engine\math::within_fov_2d(self.mainturret gettagorigin("_encstr_A14F0AE336178944BA076F41"), self.mainturret gettagangles("_encstr_A14F0AE336178944BA076F41"), var_3.origin, var_0))
      return 1;
  }

  return 0;
}

_id_13A3F() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_A5490D5E05C3F8B363F3C8D83B3E43", var_0);

    if(scripts\engine\utility::array_contains(level.players, var_0)) {
      var_0 setclientomnvar("_encstr_923E15B9113560D4F7A999E112AB1E28CE63473BBB1DC0", "_encstr_BD0F0DA49018CCA2987F27534B305B");
      var_0 setclientomnvar("_encstr_84E21C0A61F9D78F70DF0E15B3A0161F16D831428940B3C9409714115D60", gettime());
      var_0 setclientomnvar("_encstr_92E710499EA5C07C82A72D2367BA361843F4", "_encstr_BD0F0DA49018CCA2987F27534B305B");
      var_0 setclientomnvar("_encstr_8CD4175A10C34E8FA1A8669D5D69539607E85172F89904D31A", gettime());
      var_0 setclientomnvar("_encstr_927C1ACB9BE1423760AEA76F81237A1A4E279F6B1F989BE478721FB2", 1);
    }
  }
}

_id_1444C() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    childthread _id_13A40(var_0, var_1, var_4);
  }
}

_id_1444E() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self.mainturret waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    childthread _id_13A40(var_0, var_1, var_4);
  }
}

_id_13A40(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;

  if(scripts\engine\utility::array_contains(level.players, var_1)) {
    var_3 = var_1;

    if(isDefined(var_2) && (var_2 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_2 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_2 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B"))
      var_4 = "_encstr_A5AE098ADB583E0AF7A5AB";
    else
      var_4 = "_encstr_A5AE098ADB583E0AF7A5AB";
  }

  if(isDefined(var_3)) {
    if(isDefined(var_0)) {
      var_3 setclientomnvar("_encstr_923E15B9113560D4F7A999E112AB1E28CE63473BBB1DC0", var_4);
      var_3 setclientomnvar("_encstr_92E710499EA5C07C82A72D2367BA361843F4", var_4);
      var_3 setclientomnvar("_encstr_84E21C0A61F9D78F70DF0E15B3A0161F16D831428940B3C9409714115D60", gettime());
      var_3 setclientomnvar("_encstr_8CD4175A10C34E8FA1A8669D5D69539607E85172F89904D31A", gettime());

      if(var_4 == "_encstr_A5AE098ADB583E0AF7A5AB")
        var_3 setclientomnvar("_encstr_AB9311F5E851613F47F087E54E97D0B850CDED", int(var_0));

      if(var_0 >= self.health - self.healthbuffer)
        var_3 setclientomnvar("_encstr_B62E15F14FBDF9279D174395F76140FF80DAB9A2830475", 1);
      else
        var_3 setclientomnvar("_encstr_B62E15F14FBDF9279D174395F76140FF80DAB9A2830475", 0);
    }
  }
}

_id_14447() {
  self waittill("_encstr_AD75063D571AE108");

  while(!scripts\engine\utility::flag("_encstr_B89313CD8E58E41DF5EC96374696C2F5E66CCA9B2B")) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1);

    if(isDefined(var_1) && isPlayer(var_1))
      scripts\engine\utility::flag_set("_encstr_B89313CD8E58E41DF5EC96374696C2F5E66CCA9B2B");

    wait 0.05;
  }
}

watch_for_death(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  var_1 = self.origin;
  var_2 = self.angles;
  self setModel("_encstr_95BD1B67AC4370F5ADA5C6EB8DE646BE679673322D857D164CF5C837D1");
  var_3 = anglesToForward(var_2);
  var_4 = anglestoup(var_2);
  var_0 setlightintensity(0);
  playFX(level._effect["_encstr_B1C613D496131E11A6E250E95A7FF3B3EB07D54BF8"], var_1, var_3, var_4);
  wait 4.0;
  playFX(level._effect["_encstr_97F9158D38EBA393D20BD89B7D3A58E6DAD737B6DBB52B"], var_1, var_3, var_4);
}

_id_142B5(var_0) {
  if(level._id_142B4.size <= var_0)
    return 1;

  return 0;
}

teleport_ai_to_cover_node(var_0) {
  var_1 = var_0.angles;
  var_2 = var_0.origin;

  if(!issubstr(var_0.type, "_encstr_922406B1A6FD5E05")) {
    if(issubstr(var_0.type, "_encstr_A5AD0568019C63"))
      var_1 = var_1 + (0, 90, 0);
    else if(issubstr(var_0.type, "_encstr_8253061E2B5FE330") || issubstr(var_0.type, "_encstr_87AB0D4BD7B857DB077503DA9B8EEB") || issubstr(var_0.type, "_encstr_8BF608EDC8D8CFD8F9A8") || issubstr(var_0.type, "_encstr_AFFF0C6E8FE899DDE6174B068510"))
      var_1 = var_1 - (0, 90, 0);
  }

  self forceteleport(var_2, var_1);
  self usecovernode(var_0, 1);
  self setgoalnode(var_0);
}

_id_1357B(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2.origin = scripts\engine\utility::drop_to_ground(var_2.origin);
  var_3 = scripts\cp\laser_traps\cp_laser_traps::get_enter_leave_station_time(var_2.origin, var_2.angles);
  var_4 = scripts\cp\laser_traps\cp_laser_traps::get_ending_struct(var_3);
  var_5 = scripts\cp\laser_traps\cp_laser_traps::get_emp_effect_duration(var_3);
  thread scripts\cp\laser_traps\cp_laser_traps::get_end_ang(var_3, var_4, var_5, var_1);
}

mud_sfx(var_0) {
  if(var_0 == "_encstr_8E8405EA382B2A")
    return 0;

  var_1 = 60000;

  if(level.time_survived < 9 * var_1)
    return 3;
  else if(level.time_survived < 13 * var_1)
    return 2;

  return 1;
}

_id_11D32() {
  var_0 = scripts\engine\utility::getStruct("_encstr_869C09412DD319C19A2252", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_A59C09D6B7C94758E48119", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  wait 1;
  var_2 = 0;
  var_3 = sortbydistance(level.players, var_0.origin);

  foreach(var_5 in var_3) {
    if(!var_2 && isDefined(var_5) && !scripts\cp\cp_laststand::player_in_laststand(var_5)) {
      var_5 scripts\engine\utility::delaycall(1, ::playsoundtoteam, "_encstr_A3751D4687FAB3F6ADAFEA9B8CF52395CCACB9C8F5B3C9DEAEE64637EBA623", "_encstr_9A8507BA4040188D08");
      var_2 = 1;
    }
  }

  while(!scripts\engine\utility::flag("_encstr_A6240EB0B9E6C2ABB18E98EBDE3BCA27")) {
    enemy_mortar_launch(var_0, 1);

    if(level.players.size > 2) {
      wait 2.5;
      enemy_mortar_launch(var_1, 0);
    }

    var_7 = getaiarray("_encstr_8E8405EA382B2A");

    if(isDefined(var_7) && var_7.size < 3) {
      wait(randomfloatrange(4, 5.5));
      continue;
    }

    wait(randomfloatrange(5, 6.5));
  }
}

enemy_mortar_launch(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray("_encstr_AFC013771F86FBD92046FDC4FB10DF435DBD9FB7C1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = 2000;
  var_4 = 2.25;
  var_5 = var_0;
  var_6 = undefined;

  if(var_1)
    var_6 = var_0 prohibited_weapon_list(1);
  else
    var_6 = var_0 proprotate(1);

  if(!isDefined(var_6)) {
    var_7 = scripts\engine\utility::array_randomize(var_2);
    var_6 = var_7[0];
  }

  var_8 = randomintrange(-250, 100);
  var_9 = randomintrange(100, 250);

  if(isPlayer(var_6) && var_6 issprinting()) {
    var_8 = -600;
    var_9 = 400;
  }

  var_10 = spawnStruct();
  var_10.origin = var_6.origin + (var_8, var_9, 10);
  var_11 = scripts\engine\trace::ray_trace(var_10.origin + (0, 0, 600), var_10.origin);
  var_10.origin = var_11["_encstr_BD260953AA97E3F014279D"];

  if(getdvarint("_encstr_996F134B0A7A8790BFA860EBE0B6C11079C8D15089")) {
    var_12 = distance(var_5.origin, var_10.origin);
    var_4 = var_12 / var_3 * var_4;
  }

  var_13 = scripts\engine\utility::spawn_tag_origin(var_5.origin, (0, 0, 0));
  var_13 show();
  wait 0.15;
  playFXOnTag(level._effect["_encstr_923614C3D52BE1636068E36AC1A8B439096F6B434356"], var_13, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  playFXOnTag(level._effect["_encstr_A7BE11D38041791F48A6ECF1BE96A3FA9B4BFA"], var_13, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  playFX(level._effect["_encstr_B10F1567990FBE2BB631FACCB10BCDA1D7B6BDC9A32C9C"], var_5.origin);

  if(distance2d(var_10.origin, var_5.origin) < 400) {
    earthquake(0.1, 2, var_5.origin, 2000);

    if(isPlayer(var_6))
      level.player playRumbleOnEntity("_encstr_B14F0D7B2B51F287F03ED59C51F0DC");
  }

  wait 0.1;

  if(isPlayer(var_6))
    var_6 playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");

  playsoundatpos(var_13.origin, "_encstr_B60E16BB0F39D8F0B2D7959107AB3890D9226136F769881D");
  var_13 playLoopSound("_encstr_B1F913170377C39FD05832BBB193D71A59932FF3D1");
  var_14 = max(0.05, var_4 - 1.7);
  playsoundatpos(var_13.origin, "_encstr_8D6815EEACC2E0FAADBDC98EB0C97D4BDC36EDADB4E6CE");
  movemortar(var_13, var_5.origin, var_10.origin, var_4);
  level notify("_encstr_8DB00ED6B7278E2CC9EB2DB683B0D81D");
  var_13 stoploopsound("_encstr_B1F913170377C39FD05832BBB193D71A59932FF3D1");
  var_13 delete();
  radiusdamage(var_10.origin, 500, 1, 1);
  earthquake(0.4, 1.5, var_10.origin, 2000);
  playrumbleonposition("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB", var_6.origin);
  playFX(level._effect["_encstr_AC3C1560B2C867705F9AD5477277B9D132FA30C0FAA54D"], var_10.origin);
  var_12 = distance(var_6.origin, var_10.origin);

  if(300 > distance(var_6.origin, var_10.origin)) {
    if(isPlayer(var_6) && var_6.origin[2] + 100 > var_10.origin[2])
      var_6 scripts\engine\utility::delaycall(0.75, ::shellshock, "_encstr_8B1608EC43B8D647A113", 1);
  }

  magicgrenademanual("_encstr_A5EF0A384DEA382F83D76B59", var_10.origin + (0, 0, 5), (0, 0, 0), 0.05);
  physicsexplosionsphere(var_10.origin, 300, 150, 100);
  return 1;
}

movemortar(var_0, var_1, var_2, var_3, var_4) {
  setdvarifuninitialized("_encstr_996F134B0A7A8790BFA860EBE0B6C11079C8D15089", "_encstr_87070320DF");

  if(getdvarint("_encstr_996F134B0A7A8790BFA860EBE0B6C11079C8D15089")) {
    var_0.origin = var_1;
    var_5 = getdvarint("_encstr_979A08F619C1EA8361C7");
    var_6 = distance(var_1, var_2);
    var_7 = var_2 - var_1;
    var_8 = 0.5 * var_5 * squared(var_3) * -1;
    var_9 = (var_7[0] / var_3, var_7[1] / var_3, (var_7[2] - var_8) / var_3);
    var_0 movegravity(var_9, var_3);
    var_10 = gettime() + var_3 * 1000;

    while(gettime() < var_10) {
      var_0 anglemortar();
      waitframe();
    }
  } else {
    var_11 = 1200;

    if(isDefined(var_4))
      var_11 = var_4;

    var_12 = 1 / (var_3 / 0.05);
    var_13 = 0;

    while(var_13 < 1) {
      var_0.origin = scripts\engine\math::get_point_on_parabola(var_1, var_2, var_11, var_13);
      var_0 anglemortar();
      var_13 = var_13 + var_12;
      wait 0.05;
    }

    var_0.origin = var_2;
  }
}

anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

enemy_mortar(var_0) {
  wait 0.25;
  enemy_mortar_launch(var_0);
  wait(level.mortar_round_delay_time);
  thread enemy_mortar(var_0);
}

_id_11CC5() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_93BC119AA079EF4B208D371CBB2815179319E3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0[0];
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_3 = squared(2000);

  while(!scripts\engine\utility::flag("_encstr_A6240EB0B9E6C2ABB18E98EBDE3BCA27")) {
    var_0 = scripts\engine\utility::array_randomize(var_0);

    if(scripts\engine\utility::is_equal(var_1, var_0[0]))
      var_1 = var_0[1];
    else
      var_1 = var_0[0];

    var_2.origin = var_1.origin;
    var_4 = var_2 prohibited_weapon_list();
    var_5 = distancesquared(var_4.origin, var_2.origin);

    if(var_5 >= var_3) {
      wait 0.1;
      continue;
    }

    if(isDefined(var_4)) {
      var_6 = scripts\cp\laser_traps\cp_laser_traps::put_headicon_on_tv_station_boss();
      var_7 = scripts\engine\utility::getclosest(var_2.origin, var_6);
      no_csm(var_1, var_4, var_7);
      wait(randomfloatrange(4.5, 6.5));
    }

    wait 0.1;
  }
}

no_csm(var_0, var_1, var_2) {
  var_3 = 6000;
  var_4 = 6.25;
  var_5 = spawnStruct();
  var_5.origin = var_0.origin;
  var_6 = spawnStruct();
  var_6.origin = var_1.origin;
  var_7 = scripts\engine\trace::ray_trace(var_6.origin + (0, 0, 1000), var_6.origin);
  var_6.origin = var_7["_encstr_BD260953AA97E3F014279D"];
  var_8 = distance(var_5.origin, var_6.origin);
  var_4 = var_8 / var_3 * var_4;
  var_9 = scripts\engine\utility::spawn_tag_origin(var_5.origin, (0, 0, 0));
  wait 0.1;
  var_10 = max(0.05, var_4 - 1.7);
  var_11 = randomintrange(-100, 100);
  var_12 = randomintrange(-100, 100);

  if(var_1 issprinting()) {
    var_11 = randomintrange(-300, 300);
    var_12 = randomintrange(-300, 300);
  }

  _id_11D8E(var_9, var_5.origin, var_1.origin + (var_11, var_12, 10), var_4);
  level notify("_encstr_9B9910AD1F50DB4FF63E4A32E3478F1330E1");
  var_9 delete();

  if(!isalive(var_2)) {
    return;
  }
  var_2 endon("_encstr_AD75063D571AE108");
  var_2.grenadeweapon = getcompleteweaponname("_encstr_BA730BF8AFF178988293F158B9");
  var_13 = var_2 magicgrenademanual(var_1.origin + (var_11, var_12, 10), var_1.origin);
}

_id_11D8E(var_0, var_1, var_2, var_3) {
  var_0.origin = var_1;
  var_4 = getdvarint("_encstr_979A08F619C1EA8361C7");
  var_5 = distance(var_1, var_2);
  var_6 = var_2 - var_1;
  var_7 = 0.5 * var_4 * squared(var_3) * -1;
  var_8 = (var_6[0] / var_3, var_6[1] / var_3, (var_6[2] - var_7) / var_3);
  var_0 movegravity(var_8, var_3);
  var_9 = gettime() + var_3 * 1000;

  while(gettime() < var_9) {
    var_0 building_magic_grenade_kill_watch();
    waitframe();
  }
}

building_magic_grenade_kill_watch() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

_id_13423(var_0) {
  var_1 = 0.5;
  var_2 = 1.0;
  var_3 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in var_3) {
    playFX(level._effect["_encstr_95D618A2C95F32ED66A85337D899A49A6755E81A21F70B398808"], var_5.origin);
    playFX(level._effect["_encstr_842311B9B6EDDACA7D769C56CD58192BF56687"], var_5.origin);
    wait(randomfloatrange(0.15, 0.3));
  }
}

weapon_xp_iw8_sh_romeo870(var_0) {
  var_1 = (0, 0, 2);
  var_2 = (0, -90, 0);

  foreach(var_4 in var_0)
  var_5 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var_4.origin + var_1, var_4.angles + var_2);
}

weapon_xp_iw8_sn_golf28(var_0) {
  var_1 = (0, -90, 0);

  foreach(var_3 in var_0) {
    switch (var_3.script_parameters) {
      case "_encstr_B483058670B0B7":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var_3.origin, var_3.angles + var_1);
        var_4 setHintString(&"_encstr_A99D1E687AE9287D86A4A08C2A52273AF228A6A6E9F51A92A0A88AD7A882B451");
        break;
      case "_encstr_9BD1091BC62CBCB5F6E4CA":
        var_4 = _id_12F4F(var_3.origin, var_3.angles, scripts\cp\laser_traps\cp_laser_traps::handle_no_ammo_mun, var_3, &"_encstr_99E92015CFA3B8518D0530C597A13878519F58F859DFA0476931A39C21762B8F42A5", undefined, ::handle_nav_bounds_buildings);
        break;
      case "_encstr_88A906570DDE7B21":
        var_4 = _id_12F4F(var_3.origin, var_3.angles, scripts\cp\laser_traps\cp_laser_traps::player_max_exposure_time, var_3, &"_encstr_8EC11A9F3120B9C779B524FD4D3915B61FBB172753CF2186C9BDAA74", undefined, ::player_looking);
        break;
      case "_encstr_8B07036CD0":
        var_4 = _id_12F4F(var_3.origin, var_3.angles, scripts\cp\laser_traps\cp_laser_traps::fogenabled, var_3, &"_encstr_BDCD1AA245AA920A5354722AD742A472A2A9BC41941AD2AA41BE8643", undefined, ::focus_fire_outline_id);
        break;
      case "_encstr_BA19058303338D":
        var_4 = _id_12F4F(var_3.origin, var_3.angles, ::_id_138AB, var_3, &"_encstr_8BB01A8628D79A9EBE1925C9823115F282941AB4AA14BED4A894A94D", undefined, ::_id_138AA);
        break;
      case "_encstr_8DCB085BEF657B4DCF0B":
        var_4 = _id_12F4F(var_3.origin, var_3.angles, scripts\cp\laser_traps\cp_laser_traps::_id_11CBA, var_3, &"_encstr_9B911C680AF59A7A7D64923905312AE50AA46869AA05EB53F4897A2AD365", undefined, ::_id_11CB9);
        break;
    }
  }
}

weapon_xp_iw8_sn_delta(var_0) {
  var_1 = (0, -90, 0);

  foreach(var_3 in var_0) {
    switch (var_3.script_parameters) {
      case "_encstr_B483058670B0B7":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var_3.origin, var_3.angles + var_1);
        break;
      case "_encstr_9BD1091BC62CBCB5F6E4CA":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::handle_leads_collected_hideiconbuilding(var_3.origin, var_3.angles + var_1);
        break;
      case "_encstr_88A906570DDE7B21":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::player_limitedammo(var_3.origin, var_3.angles + var_1);
        break;
      case "_encstr_8B07036CD0":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled(var_3.origin, var_3.angles + var_1);
        break;
      case "_encstr_BA19058303338D":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime(var_3.origin, var_3.angles + var_1);
        break;
      case "_encstr_8DCB085BEF657B4DCF0B":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::_id_11CB8(var_3.origin, var_3.angles + var_1);
        break;
      case "_encstr_8A78055C8D488C":
        var_4 = scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback(var_3.origin, var_3.angles + var_1);
        break;
    }
  }
}

handle_nav_bounds_buildings(var_0) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  thread _id_13F95(var_0, "_encstr_8E910FA7E764B78317A2C973305A28B33B");
}

player_looking(var_0) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  thread _id_13F95(var_0, "_encstr_B81D0C38EDBB56C9F599B12CDC34");
}

focus_fire_outline_id(var_0) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  thread _id_13F95(var_0, "_encstr_8D7C09102FE7216D71A66D");
}

_id_138AB(var_0, var_1) {
  var_1 thread scripts\cp\cp_powers::givepower("_encstr_820F114AE740032B7F8680CAD930B1D239F212", "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, 4);
  var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

_id_138AA(var_0) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  thread _id_13F95(var_0, "_encstr_820F114AE740032B7F8680CAD930B1D239F212");
}

_id_11CB9(var_0) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  thread _id_13F95(var_0, "_encstr_87CB0E0B177C92B2411875BD7030E71B");
}

_id_13F95(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    var_5 = isDefined(var_4.powers) && isDefined(var_4.powers[var_1]) && var_4.powers[var_1].charges == var_4.powers[var_1].maxcharges;

    if(var_5) {
      var_0 disableplayeruse(var_4);

      if(isDefined(var_0.nuke_removefadeonbnkplay))
        var_0.nuke_removefadeonbnkplay hidefromplayer(var_4);

      continue;
    }

    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  for(;;) {
    var_7 = [];

    foreach(var_4 in level.players) {
      var_5 = isDefined(var_4.powers) && isDefined(var_4.powers[var_1]) && var_4.powers[var_1].charges == var_4.powers[var_1].maxcharges;

      if(var_5) {
        if(scripts\engine\utility::array_contains(var_2, var_4)) {
          var_0 disableplayeruse(var_4);

          if(isDefined(var_0.nuke_removefadeonbnkplay))
            var_0.nuke_removefadeonbnkplay hidefromplayer(var_4);
        }

        continue;
      }

      if(!scripts\engine\utility::array_contains(var_2, var_4)) {
        var_0 enableplayeruse(var_4);

        if(isDefined(var_0.nuke_removefadeonbnkplay))
          var_0.nuke_removefadeonbnkplay showtoplayer(var_4);
      }

      var_7 = scripts\engine\utility::array_add(var_7, var_4);
    }

    var_2 = var_7;
    wait 0.1;
  }
}

weaponclassweights(var_0) {
  foreach(var_2 in var_0) {
    var_3 = fire_rockets_to_target(var_2.script_parameters);
    var_4 = createheadicon(var_3);
    var_3 = spawn("_encstr_B2010820C5337B67C8CF" + var_4, var_2.origin, 1);
    var_3.angles = var_2.angles;

    if(var_2.script_parameters == "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0")
      var_3 thread _id_1432A();

    var_3 itemweaponsetammo(weaponclipsize(var_4), weaponmaxammo(var_4));
  }
}

_id_1432A() {
  self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

  if(isPlayer(var_0))
    var_0 thread scripts\mp\trials\trial_pitcher::firemanager();
}

fire_rockets_to_target(var_0) {
  switch (var_0) {
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
      return scripts\cp\cp_weapon::buildweapon("_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
    case "_encstr_8380108C3B128FFBF07F2B2771A582D71063":
      return scripts\cp\cp_weapon::buildweapon_variant("_encstr_82660D691C902EABA8293197FB038E", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 2);
    case "_encstr_87131233FF6A6649CD69F8E07265AB9326AF4937":
      return scripts\cp\cp_weapon::buildweapon_variant("_encstr_9AB60FB477707DB1DAFA6DD263DB1364C4", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 2);
    case "_encstr_9A45126853289743936788FE33DF2B13F279F028":
      return scripts\cp\cp_weapon::buildweapon("_encstr_9A45126853289743936788FE33DF2B13F279F028", ["_encstr_BAF60EE42B66C656E1AF2B5837E8C0C8", "_encstr_93EF0F670840D30269101D126623CBC943", "_encstr_9A6B0EC7F2CB4308C66AE6F7D953DBE7", "_encstr_86180F138539B5B4C8BEEDE6B1C293C491"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
    case "_encstr_860A13D377F001473B198BB1524F86D0FCFD37A318":
      return scripts\cp\cp_weapon::buildweapon_variant("_encstr_BDF710419C225F46FDE93B32B8337A6BE00D", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 2);
    case "_encstr_AFD81196BB83FADCDA7D0785832C9C817DAD83":
      return scripts\cp\cp_weapon::buildweapon_variant("_encstr_A3850ED02338F9BEDA6FF9E3EB22A3CA", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 1);
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
      return scripts\cp\cp_weapon::buildweapon("_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8", ["_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
    case "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0":
      return scripts\cp\cp_weapon::buildweapon("_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0", ["_encstr_BEE308C2D9C177A398E1", "_encstr_85031263731B1AE49B8DB738567D6B4B6D2B6691"]);
    case "_encstr_84FC12199FB2A1FF466E9A22B0910FB372678588":
    default:
      return scripts\cp\cp_weapon::buildweapon_variant("_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 3);
  }
}

weapon_xp_iw8_sn_alpha50(var_0) {
  foreach(var_2 in var_0) {
    switch (var_2.script_parameters) {
      case "_encstr_AB3508737F830710ACDB":
        var_3 = _id_12F4F(var_2.origin, var_2.angles, ::scrambler_cleanup_player, var_2, &"_encstr_A796207A8C1841BF8483E9B19FFB7831A127C6F392A0BFC4A7E78121D7D42FDB985F", undefined, ::vo_two_remain, 1);
        break;
      case "_encstr_B29108FB78F3394A7385":
        var_3 = _id_12F4F(var_2.origin, var_2.angles, ::scrapassistdamage, var_2, &"_encstr_A9A518AA59239CBF0B01013988920FD757352738FBEB87732458", undefined, ::vo_two_remain, 1);
        break;
      case "_encstr_9B67059A734A88":
        var_3 = _id_12F4F(var_2.origin, var_2.angles, ::screen, var_2, &"_encstr_B26D1354ACE1CC495DD57F67CFE6B66B01D41B6AC6", undefined, ::vo_two_remain, 1);
        break;
      case "_encstr_BDF3065BD1CE3F1D":
        var_3 = _id_12F4F(var_2.origin, var_2.angles, ::screen, var_2, &"_encstr_B26D1354ACE1CC495DD57F67CFE6B66B01D41B6AC6", undefined, ::vo_two_remain, 1);
        break;
    }
  }
}

scrambler_cleanup_player(var_0, var_1) {
  var_2 = scripts\cp\loot_system::get_empty_munition_slot(var_1);

  if(isDefined(var_2)) {
    var_1 notify("_encstr_A6571FDC59EEFAD64B8DD8CDE84EB20B6DF563DE2C32F6AB8EAF0BB857D29C5646");
    scripts\cp\laser_traps\cp_laser_traps::_id_124A5(var_1, "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895");
    var_0.valve_steam_on = 1;
    var_1.vo_stealth_broken = 1;
    var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
    var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
  } else
    var_1 scripts\cp\utility::hint_prompt("_encstr_B6A9145BAE37D2A396B7B97DDC63DB1D9BBE33BA1B1B", 1, 2);
}

scrapassistdamage(var_0, var_1) {
  var_2 = scripts\cp\loot_system::get_empty_munition_slot(var_1);

  if(isDefined(var_2)) {
    var_1 notify("_encstr_A6571FDC59EEFAD64B8DD8CDE84EB20B6DF563DE2C32F6AB8EAF0BB857D29C5646");
    scripts\cp\laser_traps\cp_laser_traps::_id_124A5(var_1, "_encstr_ACD20F4B118BEF03D380F9335815BC7761");
    var_0.valve_steam_on = 1;
    var_1.vo_stealth_broken = 1;
    var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
    var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
  } else
    var_1 scripts\cp\utility::hint_prompt("_encstr_B6A9145BAE37D2A396B7B97DDC63DB1D9BBE33BA1B1B", 1, 2);
}

screen(var_0, var_1) {
  var_2 = scripts\cp\loot_system::get_empty_munition_slot(var_1);

  if(isDefined(var_2)) {
    var_1 notify("_encstr_A6571FDC59EEFAD64B8DD8CDE84EB20B6DF563DE2C32F6AB8EAF0BB857D29C5646");
    scripts\cp\laser_traps\cp_laser_traps::_id_124A5(var_1, "_encstr_9B1807D39B48FD93A3");
    var_0.valve_steam_on = 1;
    var_1.vo_stealth_broken = 1;
    var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
    var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
  } else
    var_1 scripts\cp\utility::hint_prompt("_encstr_B6A9145BAE37D2A396B7B97DDC63DB1D9BBE33BA1B1B", 1, 2);
}

has_termal(var_0, var_1) {
  var_1 notify("_encstr_A6571FDC59EEFAD64B8DD8CDE84EB20B6DF563DE2C32F6AB8EAF0BB857D29C5646");
  var_2 = "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895";
  var_1.vo_three_remain = "_encstr_AB3508737F830710ACDB";
  var_1 _id_13201(var_2);
  var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

hasactivepunchcard(var_0, var_1) {
  var_2 = "_encstr_ACD20F4B118BEF03D380F9335815BC7761";
  var_1.vo_three_remain = "_encstr_B29108FB78F3394A7385";
  var_1 _id_13201(var_2);
  var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

hasaccesscard(var_0, var_1) {
  var_2 = "_encstr_9B1807D39B48FD93A3";
  var_1.vo_three_remain = "_encstr_BDF3065BD1CE3F1D";
  var_1 _id_13201(var_2);
  var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

has_zone(var_0, var_1) {
  var_2 = "_encstr_B8840F126B9D8FF218872D21B7C03CC3CD";
  var_1.vo_three_remain = "_encstr_9B67059A734A88";
  var_1 _id_13201(var_2);
  var_1 forceplaygestureviewmodel("_encstr_8AD00AE40F63EF233FE7B818", var_0);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

_id_13201(var_0) {
  scripts\cp\cp_munitions::give_munition_to_slot(var_0, 0);
}

_id_12B40(var_0, var_1) {
  self endon("_encstr_A6571FDC59EEFAD64B8DD8CDE84EB20B6DF563DE2C32F6AB8EAF0BB857D29C5646");

  for(;;) {
    self waittill("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", var_2);
    waitframe();
    self.munition_splash_supress = 1;

    if(var_2 == var_0) {
      if(self.munition_slots[0].can_use)
        thread vo_stealth_exchange(var_0, 0, "_encstr_8FCD148D38EBD6BAB9A5D1B4DB37BEC47D4796DA59E4");

      continue;
    }

    if(var_2 == var_1) {
      if(self.munition_slots[1].can_use)
        thread vo_stealth_exchange(var_1, 1, "_encstr_B1D214B107F5B5BACD96A3D2BDE6D764EB1DD25BB24E");
    }
  }
}

vo_stealth_exchange(var_0, var_1, var_2) {
  self.munition_slots[var_1].can_use = 0;
  var_3 = undefined;

  if(var_1 == 0)
    var_3 = 12;
  else
    var_3 = 20;

  thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_B25419D014D7D4E97D232927501354F268F4D31388D3AEC97D2D4D", 2.5);
  wait(var_3);
  scripts\cp\cp_munitions::give_munition_to_slot(var_0, var_1);
  self.munition_slots[var_1].can_use = 1;
}

_id_13EA5(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self sethudtutorialmessage(var_0, var_2);
  wait(var_1);
  self clearhudtutorialmessage();
}

vo_two_remain(var_0) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  thread _id_13F93(var_0);
}

_id_13F93(var_0) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isDefined(var_3.vo_stealth_broken) && var_3.vo_stealth_broken) {
      var_0 disableplayeruse(var_3);
      var_0 hidefromplayer(var_3);
      continue;
    }

    var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  for(;;) {
    var_5 = [];

    foreach(var_3 in level.players) {
      if(isDefined(var_3.vo_stealth_broken) && var_3.vo_stealth_broken) {
        if(scripts\engine\utility::array_contains(var_1, var_3)) {
          var_0 disableplayeruse(var_3);
          var_0 hidefromplayer(var_3);
        }

        continue;
      }

      if(!scripts\engine\utility::array_contains(var_1, var_3)) {
        var_0 enableplayeruse(var_3);
        var_0 showtoplayer(var_3);
      }

      var_5 = scripts\engine\utility::array_add(var_5, var_3);
    }

    var_1 = var_5;
    wait 0.1;
  }

  var_0 delete();
}

carepackage_set_visible_model(var_0) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  thread _id_13F94(var_0, "_encstr_AB3508737F830710ACDB");
}

_id_139AD(var_0) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  thread _id_13F94(var_0, "_encstr_B29108FB78F3394A7385");
}

_id_12A96(var_0) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  thread _id_13F94(var_0, "_encstr_BDF3065BD1CE3F1D");
}

laststand_dogtag_monitor(var_0) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  thread _id_13F94(var_0, "_encstr_9B67059A734A88");
}

_id_13F94(var_0, var_1) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_2 = [];

  foreach(var_4 in level.players) {
    if(isDefined(var_4._id_124FD)) {
      var_0 disableplayeruse(var_4);
      wait 0.1;
      continue;
    }

    if(isDefined(var_4.vo_three_remain) && var_4.vo_three_remain == var_1) {
      var_0 disableplayeruse(var_4);

      if(isDefined(var_0.nuke_removefadeonbnkplay))
        var_0.nuke_removefadeonbnkplay hidefromplayer(var_4);

      continue;
    }

    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  for(;;) {
    var_6 = [];

    foreach(var_4 in level.players) {
      if(isDefined(var_4._id_124FD)) {
        var_0 disableplayeruse(var_4);
        wait 0.1;
        continue;
      }

      if(isDefined(var_4.vo_three_remain) && var_4.vo_three_remain == var_1) {
        if(scripts\engine\utility::array_contains(var_2, var_4)) {
          var_0 disableplayeruse(var_4);

          if(isDefined(var_0.nuke_removefadeonbnkplay))
            var_0.nuke_removefadeonbnkplay hidefromplayer(var_4);
        }

        continue;
      }

      if(!scripts\engine\utility::array_contains(var_2, var_4)) {
        var_0 enableplayeruse(var_4);

        if(isDefined(var_0.nuke_removefadeonbnkplay))
          var_0.nuke_removefadeonbnkplay showtoplayer(var_4);
      }

      var_6 = scripts\engine\utility::array_add(var_6, var_4);
    }

    var_2 = var_6;
    wait 0.1;
  }
}

_id_13F92(var_0, var_1) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_2 = [];

  foreach(var_4 in level.players) {
    if(isDefined(self._id_124FD)) {
      var_0 disableplayeruse(var_4);
      waitframe();
      continue;
    }

    if(isDefined(var_4.vehicle_occupancy_cp_handlesuicidefromvehicles) && var_4.vehicle_occupancy_cp_handlesuicidefromvehicles == var_1) {
      var_0 disableplayeruse(var_4);
      var_0 hidefromplayer(var_4);
      continue;
    }

    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  for(;;) {
    var_6 = [];

    foreach(var_4 in level.players) {
      if(isDefined(self._id_124FD)) {
        var_0 disableplayeruse(var_4);
        waitframe();
        continue;
      }

      if(isDefined(var_4.vehicle_occupancy_cp_handlesuicidefromvehicles) && var_4.vehicle_occupancy_cp_handlesuicidefromvehicles == var_1) {
        if(scripts\engine\utility::array_contains(var_2, var_4)) {
          var_0 disableplayeruse(var_4);
          var_0 hidefromplayer(var_4);
        }

        continue;
      }

      if(!scripts\engine\utility::array_contains(var_2, var_4)) {
        var_0 enableplayeruse(var_4);
        var_0 showtoplayer(var_4);
      }

      var_6 = scripts\engine\utility::array_add(var_6, var_4);
    }

    var_2 = var_6;
    wait 0.1;
  }

  var_0 delete();
}

_id_12F4F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);

  if(isDefined(var_1))
    var_8.angles = var_1;
  else
    var_8.angles = (0, 0, 0);

  if(isDefined(var_3)) {
    if(isstring(var_3))
      var_8 setModel(var_3);
    else if(isstruct(var_3) && isDefined(var_3.target))
      var_8.nuke_removefadeonbnkplay = getEnt(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  scripts\cp\cp_outline_utility::outlineenableforall(var_8, "_encstr_AAA514372003FC02452D71B705218BB00E48A3B78099", "_encstr_BE8F0A272F9B2BE97268AE8B");

  if(isDefined(var_5)) {
    var_8.headicon = thread scripts\cp\utility::ent_createheadicon(var_8, 15, "_encstr_9A8507BA4040188D08", var_5, 1);
    setheadiconsnaptoedges(var_8.headicon, 1500);
    setheadiconmaxdistance(var_8.headicon, 15);
  }

  var_8 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_8 sethintdisplayrange(200);
  var_8 sethintdisplayfov(45);
  var_8 setuserange(100);
  var_8 setusefov(40);
  var_8 sethintonobstruction("_encstr_BD1805CB69C063");
  var_8 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_8 makeusable();

  if(isDefined(var_4))
    var_8 setHintString(var_4);

  var_8.valve_steam_on = 0;

  if(isDefined(var_6))
    thread[[var_6]](var_8);

  thread _id_12F50(var_8, var_2, var_7);
  return var_8;
}

_id_12F50(var_0, var_1, var_2) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(!isPlayer(var_3)) {
      continue;
    }
    thread[[var_1]](var_0, var_3);

    if(istrue(var_2) && istrue(var_0.valve_steam_on)) {
      if(isDefined(var_0.nuke_removefadeonbnkplay)) {
        var_0.nuke_removefadeonbnkplay delete();
        wait 0.05;
      }

      var_0 delete();
      break;
    }
  }
}

_id_12758(var_0) {
  if(!isDefined(level._id_121A7))
    level._id_121A7 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));

  level._id_121A7 stopsounds();
  var_1 = lookupsoundlength(var_0) * 0.001;
  level._id_121A7 playSound(var_0);
  wait(var_1);
}

_id_12759(var_0, var_1) {
  if(scripts\engine\utility::flag(var_1)) {
    return;
  }
  level endon(var_1);

  if(!isDefined(level._id_121A7))
    level._id_121A7 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));

  level._id_121A7 stopsounds();
  var_2 = lookupsoundlength(var_0) * 0.001;
  level._id_121A7 playSound(var_0);
  wait(var_2);
}

_id_12420(var_0, var_1) {
  var_2 = var_0 scripts\cp\utility::get_closest_living_player();

  if(isDefined(var_2))
    var_2 playsoundtoteam(var_1, "_encstr_9A8507BA4040188D08");
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

supply_station_direction() {
  level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
  level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_91AD102B05FA4B18CF43C858E7377099826F"] = % _encstr_BE651E27B9404EDFA8DA9A8BEF3051A8F861166DEF0F907C7F6AD84FEBF9771E;
  level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_91AD102B05FA4B18CF43C858E7377099826F"] = "_encstr_BE651E27B9404EDFA8DA9A8BEF3051A8F861166DEF0F907C7F6AD84FEBF9771E";
  level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_91AD102B05FA4B18CF43C858E7377099826F"] = "_encstr_88841283C658DCACEBCD2D47F563EDDE0ED78119";
  level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_BA1310289D6E4039E1D3F3E1A7C9F5900973"] = % _encstr_8D431BEF7847629A45CC4029E1D47813F21262EAE063FC73F8B728E053;
  level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_BA1310289D6E4039E1D3F3E1A7C9F5900973"] = "_encstr_8D431BEF7847629A45CC4029E1D47813F21262EAE063FC73F8B728E053";
  level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_BA1310289D6E4039E1D3F3E1A7C9F5900973"] = "_encstr_B45D0F10B968FDFFC01BEAC3662543F418";
  level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
  level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_91AD102B05FA4B18CF43C858E7377099826F"] = % _encstr_BD651E91FB874EE872810131B5DF4197138248D9919F8B88C16C370FC84902FF;
  level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_91AD102B05FA4B18CF43C858E7377099826F"] = "_encstr_BD651E91FB874EE872810131B5DF4197138248D9919F8B88C16C370FC84902FF";
  level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_91AD102B05FA4B18CF43C858E7377099826F"] = "_encstr_BD8412C11BC2CD56AF9BB4A3EB1BDEDE38AF0C89";
  level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BA1310289D6E4039E1D3F3E1A7C9F5900973"] = % _encstr_8D431BEF7847629A45CC4029E1D47813F21262EAE063FC73F8B728E053;
  level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BA1310289D6E4039E1D3F3E1A7C9F5900973"] = "_encstr_8D431BEF7847629A45CC4029E1D47813F21262EAE063FC73F8B728E053";
  level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BA1310289D6E4039E1D3F3E1A7C9F5900973"] = "_encstr_B45D0F10B968FDFFC01BEAC3662543F418";
  level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
  level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_91AD102B05FA4B18CF43C858E7377099826F"] = % _encstr_BE651E27B9404EDFA8DA9A8BEF3051A8F861166DEF0F907C7F6AD84FEBF9771E;
  level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_91AD102B05FA4B18CF43C858E7377099826F"] = "_encstr_BE651E27B9404EDFA8DA9A8BEF3051A8F861166DEF0F907C7F6AD84FEBF9771E";
  level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_91AD102B05FA4B18CF43C858E7377099826F"] = "_encstr_88841283C658DCACEBCD2D47F563EDDE0ED78119";
  level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_BA1310289D6E4039E1D3F3E1A7C9F5900973"] = % _encstr_8D431BEF7847629A45CC4029E1D47813F21262EAE063FC73F8B728E053;
  level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_BA1310289D6E4039E1D3F3E1A7C9F5900973"] = "_encstr_8D431BEF7847629A45CC4029E1D47813F21262EAE063FC73F8B728E053";
  level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_BA1310289D6E4039E1D3F3E1A7C9F5900973"] = "_encstr_B45D0F10B968FDFFC01BEAC3662543F418";
  level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
  level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_91AD102B05FA4B18CF43C858E7377099826F"] = % _encstr_92651E584391AF219B31675D15EB6E7185BAC8E02932D39B572CE0D8F8DFBBBF;
  level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_91AD102B05FA4B18CF43C858E7377099826F"] = "_encstr_92651E584391AF219B31675D15EB6E7185BAC8E02932D39B572CE0D8F8DFBBBF";
  level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_91AD102B05FA4B18CF43C858E7377099826F"] = "_encstr_9684121C368573AC7D9BD2E8F536EDF6C1FAC099";
  level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_BA1310289D6E4039E1D3F3E1A7C9F5900973"] = % _encstr_8D431BEF7847629A45CC4029E1D47813F21262EAE063FC73F8B728E053;
  level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_BA1310289D6E4039E1D3F3E1A7C9F5900973"] = "_encstr_8D431BEF7847629A45CC4029E1D47813F21262EAE063FC73F8B728E053";
  level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_BA1310289D6E4039E1D3F3E1A7C9F5900973"] = "_encstr_B45D0F10B968FDFFC01BEAC3662543F418";
}