/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_so_estate\cp_so_estate.gsc
*************************************************/

main() {
  init_flags();
  select_bridge_one_spawners();
  setdvarifuninitialized("_encstr_86E10F37B1C9AFEA6E2BEBE68BAB2CC89B", 1);
  setdvarifuninitialized("_encstr_BE180EDCC6C9F59BB857C232FAB6850F", 4);
  setdvarifuninitialized("_encstr_A1D715E6C64EBE6EB8BA2C467DC6592C462B27AF5B2CC3", 2);
  setdvarifuninitialized("_encstr_8C1617C7CF3EF161B01E32BA73D8AC49197F4B17CF65DB4808", "_encstr_A34C02BB");
  setdvarifuninitialized("_encstr_9B580EE6B139F5DC5BBDAD95E8B2378E", "_encstr_934C0218");
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  _encstr_95BF37376C93D2078ECDF26C0EF2D6C2073779B10E7DCDF6D756E647851DB25E6C07F56EDBAF569B8E2CE895D7389CB21B0B6C0D2B8BB3B9D8::main();
  _encstr_85FD365636CB3BEB9417AAD00397AD63935AE0D64AB1D7F0576740602FE4D9074A47C848669BC73B5F77C8204309B3DB11EEBE6DAD8227E1::main();
  _encstr_99A931D32ED33F8A7910764AF03705D74B8E077B3F1E2F150788BB3350A97FB681F7EFE3D8A6BFDA09B0D33AB9D5F07A79DE5B::main();
  scripts\engine\utility::flag_init("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
  scripts\vehicle\decho::main("_encstr_9BC6258B2FD80371E69838D0B21601A7D1DFF039AA29FCDBDBAB096F60A7608F6F08F1DFCFE398", "_encstr_8FBF194AA1BEB3CDE1C14049DF089697C81B83610803738498CB50", "_encstr_A1892A9BCA88E8EBC4A1C5EF5BA078C811CF41B76071B05F12E81F4103F372E20C0AB8804F57B23B7BC02127");
  scripts\vehicle\mindia8::main("_encstr_B6D51CB3F801C0B7680BD4EF17B05B51A320BA0A70EB187FA167B2C338BB", "_encstr_A7441001DAE2D308EB795F25317880A5FBD8", "_encstr_A73C205F57B61AF82096EB37681033828597BFD7894802A9D819243E4AC97DEA6629");
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 1.25);
  setDvar("_encstr_83920A488F414D730D6721C8", 4);
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 2048);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", 8);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", 8);

  if(level.createfx_enabled) {
    return;
  }
  scripts\cp\vehicle::init_vehicles();
  scripts\common\vehicle::init_vehicles();
  level.objectivesfunc = ::levelobjectives_init;
  level thread scripts\cp\cp_objectives::objectives_init();
  level scripts\cp\cp_hud_message::init_cp_hud_message();
  level._id_12177 = 1;
  level.hostdamagefactorlow = 0;
  level._id_133BA = 1;
  level.map_interaction_func = _encstr_9ABE3B4BFE5A601773F71F8F93AED178F05278C1A28F7840F9B7DFB9EFC32DC2BBEAFE5B8D27B006A38FD993FF3AE0A055C2A1D1F34928B08B4AE78717::register_interactions;
  level.custom_onspawnplayer_func = ::_id_124F3;
  level.weapon_rank_event_table = "_encstr_81553F92F3354F39D30B3D21FBBF81594B62680947A8F33D09CD477328B3D1D6EFCB5E5045B7B3AA24D39120C75F4F6BC9C24B16FF1EF89968E35D8821D59F0263";
  level.player_interaction_monitor = _encstr_9ABE3B4BFE5A601773F71F8F93AED178F05278C1A28F7840F9B7DFB9EFC32DC2BBEAFE5B8D27B006A38FD993FF3AE0A055C2A1D1F34928B08B4AE78717::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_9ABE3B4BFE5A601773F71F8F93AED178F05278C1A28F7840F9B7DFB9EFC32DC2BBEAFE5B8D27B006A38FD993FF3AE0A055C2A1D1F34928B08B4AE78717::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = ::interaction_trigger_properties;
  level.strike_player_connect_black_screen_fn = ::_id_1247B;

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
  scripts\cp\laser_traps\cp_laser_traps::_id_131F6();

  if(level.scripted_spawner_func.size < 1)
    scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(!scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    scripts\engine\utility::flag_init("_encstr_A2D20FE4880D52A426C867576878654BD3");

  var_0 = getDvar("_encstr_A58217AE4FC74BEF6EA05F4BA823DD3137E5B662359FC22A10", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101")
    level thread rundebugstartobjective(var_0);

  level.eogscoreboard = ["_encstr_A19B0973B543C35FDDE063", "_encstr_8E8D0697EB01F243", "_encstr_96D30A3468575BA7C307A128", "_encstr_A9AB06297DDFD816", "_encstr_B642089B65A658E8F597"];
  scripts\cp\cp_compass::setupminimap("_encstr_BE52196A45688946F3D8E863F3903189A716C7B839A50341B2D38A");
  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
  thread _id_1369F();
  thread _id_12DAA();
  thread light_tank_gunnerdamagemodignorefunc();
  level.waittill_wave_spawned_or_timeout = gettime();
  level.shouldgodirectlytospectatefunc = ::_id_11E55;
}

_id_11E55(var_0) {
  return 0;
}

select_bridge_one_spawners() {
  level.trial_fobs_cleared = 0;
}

init_flags() {
  scripts\engine\utility::flag_init("_encstr_8E780DEC585BCABEB9D1B0C98E2B8C");
  scripts\engine\utility::flag_init("_encstr_9B7610EBFB1BBA4B40B1C1D20BF087026501");
  scripts\engine\utility::flag_init("_encstr_91640F0B12075BDA51555F578250EFDD08");
  scripts\engine\utility::flag_init("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A");
  scripts\engine\utility::flag_init("_encstr_AAD914D7E25B4A8C1976A1B8CD484991C99DF6A010CD");
  scripts\engine\utility::flag_init("_encstr_887B16B1B2CCD1FAB7134D5636D1D2D92BF54E0B32A5ABB9");
  scripts\engine\utility::flag_init("_encstr_B48F19CC5830F54A2847FFB381E5732D18C6C6D55378AC531F7D13");
  scripts\engine\utility::flag_init("_encstr_8B1B16EF38C33592E7EE3E724D6BABFD2949131B4899632B");
  scripts\engine\utility::flag_init("_encstr_B2A319E948F3EF6DCF70725BF0A3A2A7A9B87B91D579637573183A");
  scripts\engine\utility::flag_init("_encstr_9585160BB6CBF8F9B7F291BBEB77AEA0672FA78135B21B33");
  scripts\engine\utility::flag_init("_encstr_955D19A2F80DAF25B98F312889C0EA17BD767AAAE0E853DDB0D72D");
  scripts\engine\utility::flag_init("_encstr_A35D0CDF83056A6728A0FDC2B928");
}

levelobjectives_init() {
  level.objectives_table = "_encstr_BE0A1F26C75F3278E688A75F2B5B345AB1D5A15DA67DEAB36BB0CBBFD8981BA35D";
  level.objectiveregistration = ::levelregisterobjectives;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

levelregisterobjectives() {}

_id_124F3() {
  _encstr_A39824FFD7C234188B1A3A6970CE4FB72B1FEC33032D33FE0F60C9CF6B2D7107706705929B82::givedefaultloadout();
  self clearaccessory();
  self takeallweapons();
  self setsuit("_encstr_AB6C0C1784D2171608824D4727A0");
  var_0 = "_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1";
  var_1 = scripts\cp\cp_weapon::buildweapon(var_0, ["_encstr_88270B9BE59120260B9BFD6343", "_encstr_9B6B081A7BABC93A37DE", "_encstr_84D60CAB40EBFFEFF6A179634D73", "_encstr_AFE70F131627C657E6A391FAB5B4D6950D", "_encstr_AFE00DCE634BCDC6CA9BC84B1693E5", "_encstr_8DA90B8F58028E0B6B61854235", "_encstr_A7A50DCDE8DBD86D6EFADA4BDA2B86"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 1);
  self giveweapon(var_1);
  self setweaponammoclip(var_1, weaponclipsize(var_1));
  self setweaponammostock(var_1, weaponmaxammo(var_1));
  self switchtoweapon(var_1);
  self.last_stand_pistol = scripts\cp\cp_weapon::buildweapon("_encstr_B8B7134BEE70EB0ED2FA5BB4D69526721398D7AD07", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  self giveweapon(self.last_stand_pistol);
  self setweaponammoclip(self.last_stand_pistol, weaponclipsize(self.last_stand_pistol));
  self setweaponammostock(self.last_stand_pistol, weaponmaxammo(self.last_stand_pistol));
  thread scripts\cp\cp_powers::givepower("_encstr_81580B52FF3F7F3D195A6A61A7", "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, 4);
  thread scripts\cp\cp_powers::givepower("_encstr_A22A16E07BEE5693EB9B732C83B934EDE83AE4B2E658C895", "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, 4);
  self.weaponlist = self getweaponslistprimaries();
  thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0], 1);

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0]))
    self.primaryweaponobj = self.weaponlist[0];

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1]))
    self.secondaryweaponobj = self.weaponlist[1];

  var_2 = self;
  var_2.loadoutaccessoryweapon = var_2 scripts\cp\cp_loadout::cac_getaccessoryweapon();
  var_2.loadoutaccessorydata = var_2 scripts\cp\cp_loadout::cac_getaccessorydata();
  var_2.loadoutaccessorylogic = var_2 scripts\cp\cp_loadout::force_interrupt_all_current_combat_actions();

  if(isDefined(var_2.loadoutaccessorydata) && isDefined(var_2.loadoutaccessoryweapon) && var_2.loadoutaccessoryweapon != "_encstr_8BBA05185F8B99")
    var_2 scripts\cp\cp_accessories::giveplayeraccessory(var_2.loadoutaccessorydata, var_2.loadoutaccessoryweapon, var_2.loadoutaccessorylogic);

  self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 0);
  self._id_12544 = [];
  level.hostdamagefactorlow++;

  if(!scripts\engine\utility::flag("_encstr_8E780DEC585BCABEB9D1B0C98E2B8C"))
    self allowmovement(0);

  thread scripts\cp\laser_traps\cp_laser_traps::mountain_three_death_func();
}

_id_1247B(var_0) {}

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
  scripts\cp\cp_objectives::registerobjective("_encstr_8F560CB32953C96271EFFB03033C", undefined, undefined, undefined, undefined, undefined);
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
  register_create_script_arrays("_encstr_AC041B3369C76BA0B7F13B8D4FD3D0F146CA5726957501FAAAF89333EB", "_encstr_AC041B3369C76BA0B7F13B8D4FD3D0F146CA5726957501FAAAF89333EB", level.scripted_spawner_func.size, _encstr_82C73C5F57B61AF82013BDB66B223D520FCFA6871948E3AF5139A27B61907D0E6E21DF4FBF904A8B70819B07DE1092E237B1BF872F264359784B058F73F8::main);
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

_id_12DAA() {
  while(level.hostdamagefactorlow < 1)
    waitframe();

  var_0 = scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback(scripts\engine\utility::getStruct("_encstr_A9A810CBBBC93895416B032D1329D1886342", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin, scripts\engine\utility::getStruct("_encstr_BAA8101B6B19E845715B537D635981B8B352", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").angles);
  setheadiconsnaptoedges(var_0.headiconid, 400);
  var_1 = scripts\cp\laser_traps\cp_laser_traps::player_limitedammo(scripts\engine\utility::getStruct("_encstr_BAA8101B6B19E845715B537D635981B8B352", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin, scripts\engine\utility::getStruct("_encstr_B1A8107FC8CFA3DB71A07F4D184FF0AFA15E", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").angles);
  setheadiconsnaptoedges(var_1.headiconid, 400);
  var_2 = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime(scripts\engine\utility::getStruct("_encstr_B1A8107FC8CFA3DB71A07F4D184FF0AFA15E", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin, scripts\engine\utility::getStruct("_encstr_BAA8101B6B19E845715B537D635981B8B352", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").angles);
  setheadiconsnaptoedges(var_2.headiconid, 400);
  var_3 = scripts\cp\laser_traps\cp_laser_traps::_id_13433(scripts\engine\utility::getStruct("_encstr_A2A8106E47B0E48ED78E58C983EB36B736D0", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin, scripts\engine\utility::getStruct("_encstr_B1A8107FC8CFA3DB71A07F4D184FF0AFA15E", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").angles);
  setheadiconsnaptoedges(var_3.headiconid, 400);
  var_4 = [["_encstr_96100C2640AA513F33F8C753C152", "_encstr_B483058670B0B7", 1], ["_encstr_88100C19BF5307CF70B7B75DF73A", "_encstr_8A78055C8D488C", 1], ["_encstr_81100CBAE069415F8337F716C003", "_encstr_B483058670B0B7", 1], ["_encstr_AA100CC06FA8262FC3E60C9871DF", "_encstr_8A78055C8D488C", 1], ["_encstr_97100C453F032810E0CE7368798D", "_encstr_9B6609EB658A6B7A335003", 1], ["_encstr_AD100C55FF90713E436A9BA09182", "_encstr_8DCB085BEF657B4DCF0B", 1], ["_encstr_85100C750F331820B09E231809DF", "_encstr_B483058670B0B7", 1], ["_encstr_91100CF55F30D19EE30AFBC0F11A", "_encstr_8A78055C8D488C", 1], ["_encstr_AC100C7B17E3175B0107E0688913", "_encstr_9B6609EB658A6B7A335003", 1], ["_encstr_92270DD528386F13187F6FC85F51E2", "_encstr_B483058670B0B7", 1], ["_encstr_BE270DCA7768797F8F91B32A3E472E", "_encstr_B483058670B0B7", 1], ["_encstr_BD270D11AABBF8C85229AFE56F6A8A", "_encstr_9B1804C793EB", 1], ["_encstr_82270D6E85DBE73B20CFF8484F197B", "_encstr_B483058670B0B7", 1], ["_encstr_AC270D5DF78869364B9293B899A64D", "_encstr_8A78055C8D488C", 1], ["_encstr_91270DE002E84793C369B4207FEE93", "_encstr_BA19058303338D", 1], ["_encstr_8E270D98DBF0FAE6381677737DC41B", "_encstr_9B6609EB658A6B7A335003", 1], ["_encstr_B8270D82D85149579B3FFFEED84BBE", "_encstr_BA19058303338D", 1], ["_encstr_93270DFD5728C996EB32F3D8F9C6EB", "_encstr_9B1804C793EB", 1], ["_encstr_A1270DE80AE0BF6BCB71AC2877F61A", "_encstr_8B07036CD0", 1], ["_encstr_88270DB9EFB9F12E1BD9F4652F3AEB", "_encstr_8B07036CD0", 1], ["_encstr_81270D92CF18494B704A6B7A58AAFF", "_encstr_BA19058303338D", 1], ["_encstr_AA270DE2D811D68F23910866EE739E", "_encstr_8DCB085BEF657B4DCF0B", 1], ["_encstr_97270D823F203127D7D98BE2E60EEE", "_encstr_BA19058303338D", 1]];
  _id_13513(var_4);
  thread _id_135B4();
  scripts\engine\utility::flag_wait("_encstr_9B7610EBFB1BBA4B40B1C1D20BF087026501");
  scripts\cp\laser_traps\cp_laser_traps::_id_1437A();
  scripts\engine\utility::flag_set("_encstr_8E780DEC585BCABEB9D1B0C98E2B8C");

  foreach(var_6 in level.players)
  var_6 allowmovement(1);

  scripts\cp\laser_traps\cp_laser_traps::_id_13067();
  thread _id_13523("_encstr_A7D515B62C96731ADE5DE6B2D7B65AB92BBEDCE00BEECD");
  level.brclosealldoors = 0;
  level.audio_jugg_death = [];
  intro();
  incendiary_pickup_watcher();
  _id_13DF5();
  _id_1338E();
  _id_11A71();
  oil_puddles();
}

intro() {
  var_0 = [[[4, "_encstr_AD07034A38"]], [[6, "_encstr_AD07034A38"]], [[8, "_encstr_AD07034A38"]], [[10, "_encstr_AD07034A38"]]];
  _id_1321A("_encstr_922A191FB78B40F52FD2F339592FA3F06270ABB51F33103E6F8A4B", var_0, 0);
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_8AAB223482F56AA7BE8A6AA80A5151BC9A524D35A47A72BE29C9A62A295534A2523D3935", "_encstr_9A8507BA4040188D08", 10);
  thread _id_12758("_encstr_BE352C28EB5769E1CB215A5785C27710DF2BD8E0E73F40F3B2D2CD705DBA5F9E3E9F68D8A7C898AFAA7F46782287");
  scripts\engine\utility::flag_wait("_encstr_91640F0B12075BDA51555F578250EFDD08");
  _id_122F7();
  var_1 = scripts\common\utility::getvehiclespawner("_encstr_A16514872F63A80DD73A6B91E187CB88FAA8035DF7DA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1 scripts\common\utility::spawn_vehicle();
  var_2.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var_2);
  var_2 thread _id_14352(["_encstr_8CC50F1BB75DE41D2F0B9C19D75B859637", "_encstr_95C6116736686310AB27D563FD971EE3AA083B", "_encstr_8577147E159B2D4BB93F2088DFEBA049227CE0FDEA72", "_encstr_8C5310B1DBABE4E82FB04E8CAFD8DEBBB29C"]);
  var_2 thread heli_crash_on_pilot_death();
  var_2 thread heli_death_thread();
  var_3 = scripts\common\utility::getvehiclespawner("_encstr_BA4411E81BD4D3478759364BAD6B81F93A47A2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = var_3 scripts\common\utility::spawn_vehicle();
  var_4.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var_4);
  var_4 thread heli_death_thread();
  var_5 = scripts\common\utility::getvehiclespawner("_encstr_96311114DD29F2088BAF4ACBB8DBFA155DC1E6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = var_5 scripts\common\utility::spawn_vehicle();
  var_6.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var_6);
  var_6 thread heli_death_thread();
  wait 6.0;
}

_id_122F7() {}

incendiary_pickup_watcher() {
  thread _id_12758("_encstr_93C81953C32EA5CB1378833AD521F17F5308AF83A141F4D36B0E0C");
  _id_131F3(0);
  var_0 = [["_encstr_8AA51551225F18B05BDBF1D3AF130DB13EFA98488BF732", "_encstr_AD07034A38", 1], ["_encstr_A6A515ACB9FA1BDEAB938E97C239917D99E47BCD3AF58C", "_encstr_AD07034A38", 1], ["_encstr_B2A515E5C696F7AD9BF823CB58AD274FE92E6796DD3E0E", "_encstr_AD07034A38", 1, undefined, ["_encstr_88950636C6DE9B59", 1000]], ["_encstr_B4A51568FB9E86D0679295633116F0D99823EDB813A734", "_encstr_AD07034A38", 2], ["_encstr_B6A5152BE6F5D8DED5E4E85EB09C23EB66397BCDA3AF9A", "_encstr_AD07034A38", 2], ["_encstr_A2A515E52B2731BF3B4BD0B09212514E2BB278E8847FD3", "_encstr_AD07034A38", 3], ["_encstr_95A51537384ECB5A5B8EA3987F3DA2AF3198A79398A657", "_encstr_AD07034A38", 4, undefined, ["_encstr_88950636C6DE9B59", 1000]], ["_encstr_9A0114A8B3514F6047EAA51BD173496F027AD820E962", "_encstr_AD07034A38", 1, undefined, ["_encstr_88950636C6DE9B59", 1000]], ["_encstr_A501142B37BE1BBDD5938E970BC9197DB9D223AC7DC8", "_encstr_AD07034A38", 2, undefined, ["_encstr_88950636C6DE9B59", 1000]], ["_encstr_8D011459DC7D1BBD5D39D15EC22723BEDC969156FA66", "_encstr_AD07034A38", 3, undefined, ["_encstr_88950636C6DE9B59", 1000]], ["_encstr_A937172ABFC978BA4B12DB77AF73A8CE0F1F9A371367752D97", "_encstr_BE1904DCDA9D", 1, undefined, ["_encstr_88950636C6DE9B59", 800]], ["_encstr_BA991A23F6292390ED484027A7E881A153C399957327CD0725E8FFA7", "_encstr_AD07034A38", 3], ["_encstr_A9991AD51B1701AF2B5B20408202615E17A0E75D726FA8F3D7238102", "_encstr_AD07034A38", 2], ["_encstr_8C991A569BAF36DBAB271DF2C24E19D7EA8383CAE4BE6356CCE8EBCC", "_encstr_A65B084B38A76BEFC350", 1, undefined, ["_encstr_88950636C6DE9B59", 600]], ["_encstr_9A991A474791168FB3F65CCB1625BA81A520C8D81397A5EA384070AA", "_encstr_A65B084B38A76BEFC350", 4], ["_encstr_927B1BCFBFF8623FE00B236801B07CF94511234725AFBBE148505BF933", "_encstr_AD07034A38", 3], ["_encstr_BE7B1B7743D14BD2A5FDC3EFC3CEAABF78CBAAFFDB7902CAF4E1CB7F8D", "_encstr_AD07034A38", 2], ["_encstr_8E7B1BACDCD7C6DEBAC93AE52C938CEBAB070EB293EB4E5A3B863AFA99", "_encstr_A65B084B38A76BEFC350", 1, undefined, ["_encstr_88950636C6DE9B59", 600]], ["_encstr_B87B1B531B9FD62ADBA67CE1396E2A7F872B7A5AA3F04379AA786BA7CB", "_encstr_A65B084B38A76BEFC350", 4], ["_encstr_87FF178893716F4067CA857BB113694FE5FAA02B1B99BB581B", "_encstr_AD07034A38", 1], ["_encstr_8AF91A4D737F69D75333B8E83AAA89A6EB07CC35EAD7301B7FBBE9A2", "_encstr_AD07034A38", 3], ["_encstr_A6F91AF2FB5FA2679BFAD39BF913458131708C5FEB3F09B82A6421CB", "_encstr_AD07034A38", 3], ["_encstr_B2F91A9757618A2763C5ECFB39B5A1A073E7C720AD215225DBB50783", "_encstr_AD07034A38", 4], ["_encstr_97F91A95B9EB1B7BEA93E8CB853919F51BDB77B29CAF632B33E8F51A", "_encstr_A65B084B38A76BEFC350", 4, undefined, ["_encstr_88950636C6DE9B59", 600]], ["_encstr_87491B3AF0D7BEDFF36E24318F7BBBC9C97883B2407F323F695B2C1FBF", "_encstr_AD07034A38", 3], ["_encstr_96491BDB73F8793FD3AB4B296323054FBBEF8F65AB9F40A3D99390F8E2", "_encstr_AD07034A38", 3], ["_encstr_88491BB2DCBEC6BDAEC91DF20B2791BEB1B77756E47D93D27643D1D7CC", "_encstr_AD07034A38", 4], ["_encstr_81491B01BF908E30DBB310D9B82802C8411037A2BB67B27B47EBFC2101", "_encstr_A65B084B38A76BEFC350", 4, undefined, ["_encstr_88950636C6DE9B59", 600]]];
  thread _id_134ED(var_0, 0);
  var_1 = [[[[1, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"]], [[2, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"]], [[3, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"]], [[4, "_encstr_BE1904DCDA9D"], [2, "_encstr_AD07034A38"]]]];
  var_2 = ["_encstr_B2CB1031501B82483B8742D9B11218A430E3", "_encstr_B2360F5288DDA373B8BBF2EC2F08FF3786"];
  var_3 = ["_encstr_930D05B2186F72", "_encstr_BEDB0BFF1EE37A5E3840978778", "_encstr_A7A10A1B9784610A58130321"];
  thread player_sees_hvt_leaving_vo("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A", "_encstr_AD7B0E41F545A00DABC7AD9927725918", var_2, var_3, var_1);
  scripts\engine\utility::flag_wait("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A");
  var_1 = [[[[1, "_encstr_A65B084B38A76BEFC350"], [2, "_encstr_AD07034A38"]], [[1, "_encstr_A65B084B38A76BEFC350"], [4, "_encstr_AD07034A38"]], [[1, "_encstr_A65B084B38A76BEFC350"], [6, "_encstr_AD07034A38"]], [[2, "_encstr_A65B084B38A76BEFC350"], [6, "_encstr_AD07034A38"]]], [[[2, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"]], [[2, "_encstr_BE1904DCDA9D"], [2, "_encstr_AD07034A38"]], [[4, "_encstr_BE1904DCDA9D"], [3, "_encstr_AD07034A38"]], [[4, "_encstr_BE1904DCDA9D"], [4, "_encstr_AD07034A38"]]]];
  var_2 = ["_encstr_BEDB0BFF1EE37A5E3840978778", "_encstr_A7A10A1B9784610A58130321", "_encstr_8A6707D81AAB2736D0"];
  var_3 = ["_encstr_930D05B2186F72", "_encstr_A5C407E1658D3339B3"];
  thread player_sees_hvt_leaving_vo("_encstr_B48F19CC5830F54A2847FFB381E5732D18C6C6D55378AC531F7D13", undefined, var_2, var_3, var_1);
  scripts\engine\utility::flag_wait_either("_encstr_B48F19CC5830F54A2847FFB381E5732D18C6C6D55378AC531F7D13", "_encstr_887B16B1B2CCD1FAB7134D5636D1D2D92BF54E0B32A5ABB9");
}

_id_13DF5() {
  thread _id_14344();
  var_0 = [["_encstr_BE301320C7578BE5AB2E5A5E09920371D51BB079B6", "_encstr_AD07034A38", 1], ["_encstr_8E3013F070C97DA29DE81A0BF1B93F35856631F7F6", "_encstr_AD07034A38", 1, undefined, ["_encstr_88950636C6DE9B59", 600]], ["_encstr_B8301348EBC6CBAB25A6E3ABA7C9F28CF09EDF6FC7", "_encstr_9A190463ADB3", 2], ["_encstr_96301317E77F73E063D7CA46BE8BBF167348B36134", "_encstr_AD07034A38", 1], ["_encstr_8730138AB370337A40379373B73047B385881291D3", "_encstr_AD07034A38", 2], ["_encstr_BD30139537AFA39357C6ADE67D46B29956CD19F56C", "_encstr_AD07034A38", 2], ["_encstr_823013CA9BFAA327EA8D5BCDBE195933953746EB6E", "_encstr_AD07034A38", 3], ["_encstr_97301325E3EF74DAC53AC057E6A51AC4937384E94A", "_encstr_9A190463ADB3", 3], ["_encstr_AA3013E75B916150483A7F52F61C19E9096E6D2129", "_encstr_AD07034A38", 4], ["_encstr_A6C5140DEF7F0BDBB3B64A2241ED40C6FD3813D77953", "_encstr_AD07034A38", 4]];
  thread _id_134ED(var_0, 1);
  thread _id_14347();
  scripts\engine\utility::flag_wait("_encstr_B48F19CC5830F54A2847FFB381E5732D18C6C6D55378AC531F7D13");
  _id_131F3(1);
  thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(10000, 10000, (0, 90, 0), scripts\engine\utility::getStruct("_encstr_9138130867234DC81276A49327858EBF2F3BB38803", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", ::_id_1249A);
  scripts\engine\utility::delaythread(1, ::_id_12758, "_encstr_88551871D8875DC31789032B6033B127B325F1137F7F8F8BAF80");
  var_1 = [[[[1, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"]], [[2, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"]], [[3, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"]], [[4, "_encstr_BE1904DCDA9D"], [2, "_encstr_AD07034A38"]]]];
  var_2 = ["_encstr_85A60AD23BDB5247F3289B83"];
  var_3 = ["_encstr_85A60AD23BDB5247F3289B83"];
  thread player_sees_hvt_leaving_vo("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A", "_encstr_A95C09DC34AC8CBE16631B", var_2, var_3, var_1);

  if(!scripts\engine\utility::flag("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A")) {
    var_4 = getEnt("_encstr_886F0ECE2CC932B273AF235999B2CD91", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    while(!var_4 trial_turret_thread_func())
      waitframe();
  }

  var_2 = ["_encstr_930D05B2186F72", "_encstr_88760B258B4BD52F61B0133A3B"];
  var_3 = ["_encstr_8A6C09B6DEE6EAB5CACDA3", "_encstr_8A6707D81AAB2736D0", "_encstr_A7A10A1B9784610A58130321"];
  var_5 = [["_encstr_8B9017DF3E37CBE23B800F674953A132295823D92CD5B236E3", "_encstr_850707F7E5833355B8", 2], ["_encstr_AF76140DBE1E0F4A875B27E67798D9E48B45E619C052", "_encstr_850707F7E5833355B8", 1], ["_encstr_8D7614B59FB98248C2BFB7C3619856937BD82848E742", "_encstr_850707F7E5833355B8", 3], ["_encstr_A57614756B9F82400B92459D0FC8D2793F874B236887", "_encstr_850707F7E5833355B8", 3], ["_encstr_96D71877D8481B834D0B9F282FA3D0E3891FF858EF4131A5B05B", "_encstr_850707F7E5833355B8", 1], ["_encstr_87D7182BE6F547275DD86D9B7DBBD2CDC8DE77D79B5A1959F591", "_encstr_850707F7E5833355B8", 4]];
  thread _id_134ED(var_5, 1);
  var_6 = [[[4, "_encstr_AD07034A38"]], [[6, "_encstr_AD07034A38"]], [[8, "_encstr_AD07034A38"]], [[10, "_encstr_AD07034A38"]]];
  _id_1321A("_encstr_AA2F16E95E7A28BDF267E7F98F3B7F7812B9F3A102D7E8ED", var_6, 1);
  var_7 = scripts\common\utility::getvehiclespawner("_encstr_9AFE11ECC23919B2CDBE1B86DEE01C959CBE4C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 = var_7 scripts\common\utility::spawn_vehicle();
  var_8.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var_8);
  var_8 thread heli_crash_on_pilot_death();
  var_8 thread heli_death_thread();
  var_8 thread _id_14352(["_encstr_AC710CD0FA723959435FBE3B7DB3", "_encstr_A1A110573F75D2FD5059277B90ABB38A35CD"]);
  scripts\engine\utility::flag_wait("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A");
  var_1 = [[[[1, "_encstr_BE1904DCDA9D"], [2, "_encstr_AD07034A38"]], [[1, "_encstr_BE1904DCDA9D"], [4, "_encstr_AD07034A38"]], [[1, "_encstr_BE1904DCDA9D"], [6, "_encstr_AD07034A38"]], [[2, "_encstr_BE1904DCDA9D"], [6, "_encstr_AD07034A38"]]], [[[1, "_encstr_BE1904DCDA9D"], [2, "_encstr_AD07034A38"]], [[2, "_encstr_BE1904DCDA9D"], [2, "_encstr_AD07034A38"], [1, "_encstr_9A190463ADB3"]], [[2, "_encstr_BE1904DCDA9D"], [4, "_encstr_AD07034A38"], [1, "_encstr_9A190463ADB3"]], [[3, "_encstr_BE1904DCDA9D"], [4, "_encstr_AD07034A38"], [2, "_encstr_9A190463ADB3"]]], [[[1, "_encstr_BE1904DCDA9D"], [2, "_encstr_AD07034A38"]], [[2, "_encstr_BE1904DCDA9D"], [2, "_encstr_AD07034A38"], [1, "_encstr_A65B084B38A76BEFC350"]], [[2, "_encstr_BE1904DCDA9D"], [4, "_encstr_AD07034A38"], [1, "_encstr_A65B084B38A76BEFC350"]], [[2, "_encstr_BE1904DCDA9D"], [5, "_encstr_AD07034A38"], [1, "_encstr_A65B084B38A76BEFC350"]]]];
  var_2 = ["_encstr_930D05B2186F72", "_encstr_88760B258B4BD52F61B0133A3B"];
  var_3 = ["_encstr_8A6C09B6DEE6EAB5CACDA3", "_encstr_8A6707D81AAB2736D0", "_encstr_A7A10A1B9784610A58130321"];
  thread player_sees_hvt_leaving_vo("_encstr_8B1B16EF38C33592E7EE3E724D6BABFD2949131B4899632B", undefined, var_2, var_3, var_1);
  scripts\engine\utility::flag_wait_either("_encstr_8B1B16EF38C33592E7EE3E724D6BABFD2949131B4899632B", "_encstr_887B16B1B2CCD1FAB7134D5636D1D2D92BF54E0B32A5ABB9");
}

_id_1338E() {
  var_0 = [["_encstr_B6EC1CF2CB0867F49073A8A73B40BF8FCDA17A7AF07D1FEF187FD6A4578A", "_encstr_AD07034A38", 1, undefined, ["_encstr_88950636C6DE9B59", 600]], ["_encstr_84EC1C427BB8D74423E35857ABD00F1F5DD1EACA608DAF7F68CF4634E7E2", "_encstr_AD07034A38", 1, undefined, ["_encstr_88950636C6DE9B59", 600]], ["_encstr_B2EC1CD2183FA2DFF9DD680FED23D7E1E1306AAA9811112BD3301E2C9043", "_encstr_AD07034A38", 2]];
  thread _id_134ED(var_0, 2);
  var_1 = getEnt("_encstr_91810EA179DBF6F97F4A90C1731491C9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread _id_14346(var_1);
  scripts\engine\utility::flag_wait("_encstr_8B1B16EF38C33592E7EE3E724D6BABFD2949131B4899632B");
  _id_131F3(2);
  thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(10000, 10000, (0, 90, 0), scripts\engine\utility::getStruct("_encstr_97F417A8A22A73B347AB7A67877F1ECF924A2B48CA859BEB0F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, "_encstr_9B1807D39B48FD93A3", ::_id_1249B);
  scripts\engine\utility::delaythread(1, ::_id_12758, "_encstr_88551871D8875DC31789032B6033B127B325F1137F7F8F8BAF80");

  while(var_1 callback_subscribe())
    waitframe();

  thread _id_12758("_encstr_924F19C887F55B0E857DAE3747C6FAA1D237E8F5AD5A63C6C23636");
  var_2 = [[[[1, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"]], [[2, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"]], [[3, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"]], [[4, "_encstr_BE1904DCDA9D"], [2, "_encstr_AD07034A38"]]]];
  var_3 = ["_encstr_BEDB0BFF1EE37A5E3840978778", "_encstr_8C5310B1DBABE4E82FB04E8CAFD8DEBBB29C"];
  var_4 = ["_encstr_A56810DF76F5791E633873582F01709F173B", "_encstr_AFD907760B272359DC", "_encstr_88760B258B4BD52F61B0133A3B"];
  thread player_sees_hvt_leaving_vo("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A", "_encstr_956B0E1757B245B86F5B63B9C9495009", var_3, var_4, var_2);
  var_5 = [["_encstr_B81A1FB26EFA37A54659A1ED5DB9B27D8C5699CADC197DD2CD1DAC2796F6C9F5C4", "_encstr_AD07034A38", 1, "_encstr_8DCB085BEF657B4DCF0B", ["_encstr_88950636C6DE9B59", 800]], ["_encstr_921A1FDBC3A14B1BF275B81D53B399C119DB170F48406F3BCB8B47E324DF957EF2", "_encstr_AD07034A38", 2, "_encstr_88A906570DDE7B21"], ["_encstr_BE1A1F59E67D374B3256D0B7ABB995EB1995CC2BDC23F5A5373A2B39B4DE93AFCC", "_encstr_AD07034A38", 2, "_encstr_8DCB085BEF657B4DCF0B"], ["_encstr_8F1A1FCD1E4E6FC451B80A72D0973F27C18D56453871978C1D08C25B2897B26F73", "_encstr_A65B084B38A76BEFC350", 1, "_encstr_8DCB085BEF657B4DCF0B", ["_encstr_88950636C6DE9B59", 600]], ["_encstr_A31A1FCA9BD7CD4BC8ACD0DB5DDCACD78CCA335973237D5A73D1B24EB4BD39AFA9", "_encstr_AD07034A38", 3, "_encstr_88A906570DDE7B21"], ["_encstr_AC1A1F5BE3591033132A78803397FDB92F4DD5C396FF290B13D3D12BDA8F2E0153", "_encstr_AD07034A38", 1, "_encstr_88A906570DDE7B21"], ["_encstr_911A1F556321E22C3198B1B2FB2BA5F65153632388C267BA06FB2ADEDA37DBD66E", "_encstr_BE1904DCDA9D", 4, "_encstr_88A906570DDE7B21"], ["_encstr_BA90205937BE9B2D32AC1AF6BA9BB2AFC82B992BDC8CBE1BB757933A9785278CF562", "_encstr_A65B084B38A76BEFC350", 1, "_encstr_88A906570DDE7B21", ["_encstr_A5F108E19FBB92F3D05B", 800]], ["_encstr_959020799ED8976F0A55A0AD8DE7E3577212FEFB58EA1F4FA2C3330970C3F31AC916", "_encstr_AD07034A38", 2, "_encstr_8DCB085BEF657B4DCF0B"], ["_encstr_A2902056CDBEE6B4195943ED57DC95F58C95CC567391FA1BDB5D3947CB2C9346FA99", "_encstr_AD07034A38", 3, "_encstr_8DCB085BEF657B4DCF0B"], ["_encstr_845D1B81F26FA8837AD7998F8F53DD81ECCF69195DBC11C7E29799E7B6", "_encstr_BE1904DCDA9D", 1, "_encstr_8DCB085BEF657B4DCF0B"], ["_encstr_8A5D1BC8E247BB900FEF9970CBAE47517AC8C3AD58152779F04042A7DD", "_encstr_AD07034A38", 1, "_encstr_88A906570DDE7B21"], ["_encstr_855D1B95CD7DE62D199586EDBACDCAAF46AC99CA9B197D07EDED36EB66", "_encstr_AD07034A38", 2, "_encstr_88A906570DDE7B21"], ["_encstr_AD5D1BB2DCFADCD28C2B0DDBEADC59D7235999AC9B19D71C7BBD1BD768", "_encstr_8BFC0BC2CBD4F737E0A5E1FD79", 3, "_encstr_88A906570DDE7B21", ["_encstr_88950636C6DE9B59", 800]], ["_encstr_975D1B1AC737137B0B1DC840F3D8DD8798B02AD5AD815E48622728498B", "_encstr_AD07034A38", 1, "_encstr_8DCB085BEF657B4DCF0B"], ["_encstr_AA5D1BF5366647DC4950F29AC8BF173FB9957E6DC069AFA277E8BA91FA", "_encstr_AD07034A38", 3, "_encstr_8DCB085BEF657B4DCF0B"], ["_encstr_815D1B7377490688AC97D830BB83D0A852B7FD8BEB22D808CF6D400E33", "_encstr_BE1904DCDA9D", 4, "_encstr_8DCB085BEF657B4DCF0B", ["_encstr_88950636C6DE9B59", 800]], ["_encstr_8577207D12392FE8A42FF0D077EB213F323F64F5AD62AFF3876FD859431FB8F5E9B2", "_encstr_A11904E483B3", 1, "_encstr_88A906570DDE7B21"], ["_encstr_8A77205D32190FC8844F90B017CB011FD2DF44D5CD028F13674FB83963FF9895C992", "_encstr_850707F7E5833355B8", 2, "_encstr_8DCB085BEF657B4DCF0B"], ["_encstr_847720CA37F5E6D2325934BDABDC95AF8CB266597323BEC1F6ED63AF4EED7B66D766", "_encstr_A11904E483B3", 3, "_encstr_88A906570DDE7B21"], ["_encstr_8877202DAFB192F765F1E29ADBC61F41807BA6B53DD0D1DB98A89A81C3107F470171", "_encstr_850707F7E5833355B8", 4, "_encstr_88A906570DDE7B21"]];
  thread _id_134ED(var_5, 2);
  scripts\engine\utility::flag_wait("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A");
  var_2 = [[[[1, "_encstr_A65B084B38A76BEFC350"], [2, "_encstr_AD07034A38"]], [[1, "_encstr_A65B084B38A76BEFC350"], [4, "_encstr_AD07034A38"]], [[1, "_encstr_A65B084B38A76BEFC350"], [6, "_encstr_AD07034A38"]], [[2, "_encstr_A65B084B38A76BEFC350"], [6, "_encstr_AD07034A38"]]], [[[2, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"]], [[2, "_encstr_BE1904DCDA9D"], [2, "_encstr_AD07034A38"]], [[4, "_encstr_BE1904DCDA9D"], [3, "_encstr_AD07034A38"]], [[4, "_encstr_BE1904DCDA9D"], [4, "_encstr_AD07034A38"]]], [[[2, "_encstr_BE1904DCDA9D"], [1, "_encstr_9A190463ADB3"], [1, "_encstr_A65B084B38A76BEFC350"]], [[2, "_encstr_BE1904DCDA9D"], [2, "_encstr_9A190463ADB3"], [2, "_encstr_A65B084B38A76BEFC350"]], [[4, "_encstr_BE1904DCDA9D"], [2, "_encstr_9A190463ADB3"], [3, "_encstr_A65B084B38A76BEFC350"]], [[4, "_encstr_BE1904DCDA9D"], [3, "_encstr_9A190463ADB3"], [4, "_encstr_A65B084B38A76BEFC350"]]]];
  var_3 = ["_encstr_BEDB0BFF1EE37A5E3840978778", "_encstr_8C5310B1DBABE4E82FB04E8CAFD8DEBBB29C"];
  var_4 = ["_encstr_A56810DF76F5791E633873582F01709F173B", "_encstr_AFD907760B272359DC", "_encstr_88760B258B4BD52F61B0133A3B"];
  scripts\engine\utility::delaythread(1, ::_id_12758, "_encstr_92802CACFB2E4FA25F496AB29B7751F741693C2F959377AF3DE0620B798F12E739C587CBAF598FB5DB90CA61F221");
  thread player_sees_hvt_leaving_vo("_encstr_B2A319E948F3EF6DCF70725BF0A3A2A7A9B87B91D579637573183A", undefined, var_3, var_4, var_2);
  var_6 = [[[4, "_encstr_AD07034A38"]], [[6, "_encstr_AD07034A38"]], [[8, "_encstr_AD07034A38"]], [[10, "_encstr_AD07034A38"]]];
  _id_1321A("_encstr_AC2D16B1CAB93AB2E4F58D34EDC138B2E4D71D2C4E3BCA1D", var_6, 3);
  var_7 = scripts\common\utility::getvehiclespawner("_encstr_95DA11695F66A8BD3367E7F98F3B7F7812B95B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 = var_7 scripts\common\utility::spawn_vehicle();
  var_8.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var_8);
  var_8 thread heli_crash_on_pilot_death();
  var_8 thread heli_death_thread();
  var_8 thread _id_14352(["_encstr_928D153B6772D0A89FAB93A9D96828168AEF85A7CB7AA5", "_encstr_86531642372826F990D38BB2E911E05F406AE19B93407235"]);
  scripts\engine\utility::flag_wait_either("_encstr_B2A319E948F3EF6DCF70725BF0A3A2A7A9B87B91D579637573183A", "_encstr_887B16B1B2CCD1FAB7134D5636D1D2D92BF54E0B32A5ABB9");
}

_id_11A71() {
  scripts\engine\utility::flag_wait("_encstr_B2A319E948F3EF6DCF70725BF0A3A2A7A9B87B91D579637573183A");
  thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(10000, 10000, (0, 90, 0), scripts\engine\utility::getStruct("_encstr_9AF813710AD3A590566BD73B97BF217E63E3EBF902", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, "_encstr_9B1807D39B48FD93A3", ::_id_1249B);
  scripts\engine\utility::delaythread(1, ::_id_12758, "_encstr_88551871D8875DC31789032B6033B127B325F1137F7F8F8BAF80");
  var_0 = [["_encstr_8CD81A3F4F0872C1D058945DD3E80DA9FE91E7EBD7CBCBB7B8614132", "_encstr_A11904E483B3", 1], ["_encstr_A9D81A5FBEB7DA713868839798532DA1A75B23122E61E3B7ED3067FA", "_encstr_A11904E483B3", 3], ["_encstr_99E917058B21FA42A92EB8DDADD0FA7A528730C7A8473306AB", "_encstr_AD07034A38", 1], ["_encstr_ABE9171008496A167BE28EE4CF850D4AB9E78C0503650EF00F", "_encstr_BE1904DCDA9D", 2, undefined, ["_encstr_88950636C6DE9B59", 800]], ["_encstr_A7E917A8F8090FE23BBD8721D5A14056C57FF1D80C98AEB1E3", "_encstr_AD07034A38", 2], ["_encstr_A1E917A38E36184150D89793DD2967F6C8F8EA35BFCFD6DEC1", "_encstr_AD07034A38", 3], ["_encstr_93E9176546164FAE2398119AF805E70B2938E417DCF98BF973", "_encstr_A65B084B38A76BEFC350", 1, undefined, ["_encstr_88950636C6DE9B59", 600]], ["_encstr_A3E9175DC8011A3728E036F0F51C10B8A5EE59880B58BBB1AE", "_encstr_A65B084B38A76BEFC350", 3], ["_encstr_8FE917D2EB283FD6D845FFCC7B889F6BED063AFAF39D8B81D2", "_encstr_9A190463ADB3", 1], ["_encstr_8CE91795CDBEAD584BE6AF32B23356CD197D8D7BBB59277D0E", "_encstr_BE1904DCDA9D", 4], ["_encstr_9AE9172BE77788E38A8DA035A7922310B4BFD0D84FE523E7D7", "_encstr_8BFC0BC2CBD4F737E0A5E1FD79", 3], ["_encstr_B68315FAC3AF07EEF01D97B413D0B74335FEF2A2C9F8A2", "_encstr_AD07034A38", 1], ["_encstr_A68315F3FF6F7AEE6FDB78D165072B484B1F70FA6039F6", "_encstr_A65B084B38A76BEFC350", 2, undefined, ["_encstr_88950636C6DE9B59", 800]], ["_encstr_95831595CDBEADC2A537BEC856CC95DC23F5B5D2C87D86", "_encstr_BE1904DCDA9D", 1], ["_encstr_B4831587B321B5C27B15BF2B7B94CAFEA09E3D0CC9C915", "_encstr_BE1904DCDA9D", 2], ["_encstr_B18315D037A758337A7D70E597A27360C4EFE838F30FFB", "_encstr_AD07034A38", 3, undefined, ["_encstr_88950636C6DE9B59", 800]], ["_encstr_A2831507087EF58A739079AF0D05828E6101BFBF08D667", "_encstr_AD07034A38", 3], ["_encstr_888315569B7DB5584BE6F546599956CD467DB6A5467D70", "_encstr_9A190463ADB3", 4]];
  thread _id_134ED(var_0, 3);
  var_1 = [[[[1, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"]], [[2, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"]], [[3, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"]], [[4, "_encstr_BE1904DCDA9D"], [2, "_encstr_AD07034A38"]]]];
  var_2 = ["_encstr_AFD907760B272359DC", "_encstr_97180566B392A2"];
  var_3 = ["_encstr_8A6C09B6DEE6EAB5CACDA3", "_encstr_8C5310B1DBABE4E82FB04E8CAFD8DEBBB29C", "_encstr_A7A10A1B9784610A58130321"];
  thread player_sees_hvt_leaving_vo("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A", "_encstr_92010E83DFCA682007331BD151F1F891", var_2, var_3, var_1);
  _id_131F3(3);
  thread _id_1431B();
  thread _id_14345();
  scripts\engine\utility::flag_wait("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A");
  var_4 = [[[2, "_encstr_AD07034A38"], [2, "_encstr_9A190463ADB3"]], [[4, "_encstr_AD07034A38"], [2, "_encstr_9A190463ADB3"]], [[5, "_encstr_AD07034A38"], [3, "_encstr_9A190463ADB3"]], [[6, "_encstr_AD07034A38"], [4, "_encstr_9A190463ADB3"]]];
  _id_1321A("_encstr_BAC518BEE718EBC723A981AAD542C212A83F262FE3A1638FC58B", var_4, 4);
  thread _id_12758("_encstr_A39D2939A8E7A087F3B7091B2FDB5810718540D6170E58310BCF2D2B5FF21C301A5E0968BF6688F6815EA1");
  var_5 = scripts\common\utility::getvehiclespawner("_encstr_A6DA112AB128F37FB88F5B2897D042FF4E6EB7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = var_5 scripts\common\utility::spawn_vehicle();
  var_6.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var_6);
  var_6 thread heli_crash_on_pilot_death();
  var_6 thread _id_14353();
  var_6 thread heli_death_thread();
  _id_1321A("_encstr_BD901807A3F07FFF589E4A0260AF63F72877EAB7110B82AFF5D3", var_4, 4);
  var_7 = scripts\common\utility::getvehiclespawner("_encstr_BAFE119DB093195973FAB1437B0707CA9CF519", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 = var_7 scripts\common\utility::spawn_vehicle();
  thread scripts\common\vehicle_paths::gopath(var_8);
  var_8 thread heli_crash_on_pilot_death();
  var_8 thread _id_14353();
  var_8 thread heli_death_thread();
  var_1 = [[[[2, "_encstr_BE1904DCDA9D"], [1, "_encstr_AD07034A38"], [1, "_encstr_A65B084B38A76BEFC350"]], [[2, "_encstr_BE1904DCDA9D"], [2, "_encstr_AD07034A38"], [1, "_encstr_A65B084B38A76BEFC350"]], [[4, "_encstr_BE1904DCDA9D"], [3, "_encstr_AD07034A38"], [2, "_encstr_A65B084B38A76BEFC350"]], [[4, "_encstr_BE1904DCDA9D"], [4, "_encstr_AD07034A38"], [2, "_encstr_A65B084B38A76BEFC350"]]], [[[2, "_encstr_A65B084B38A76BEFC350"], [1, "_encstr_AD07034A38"], [1, "_encstr_9A190463ADB3"]], [[2, "_encstr_A65B084B38A76BEFC350"], [2, "_encstr_AD07034A38"], [1, "_encstr_9A190463ADB3"]], [[4, "_encstr_A65B084B38A76BEFC350"], [3, "_encstr_AD07034A38"], [2, "_encstr_9A190463ADB3"]], [[4, "_encstr_A65B084B38A76BEFC350"], [4, "_encstr_AD07034A38"], [2, "_encstr_9A190463ADB3"]]]];
  var_2 = ["_encstr_AFD907760B272359DC", "_encstr_A7A10A1B9784610A58130321"];
  var_3 = ["_encstr_8A6C09B6DEE6EAB5CACDA3", "_encstr_8C5310B1DBABE4E82FB04E8CAFD8DEBBB29C", "_encstr_97180566B392A2"];
  thread player_sees_hvt_leaving_vo("_encstr_955D19A2F80DAF25B98F312889C0EA17BD767AAAE0E853DDB0D72D", undefined, var_2, var_3, var_1);
  scripts\engine\utility::flag_wait("_encstr_955D19A2F80DAF25B98F312889C0EA17BD767AAAE0E853DDB0D72D");
}

oil_puddles() {
  var_0 = [["_encstr_9AE90B2BE77789D17A4C39A8B2", "_encstr_9A190463ADB3", 1], ["_encstr_AFE90B2B37F5CA87CC4B63FAC8", "_encstr_AD07034A38", 1], ["_encstr_8DE90B452B013252E841E91EA3", "_encstr_A65B084B38A76BEFC350", 1, undefined, ["_encstr_88950636C6DE9B59", 800]], ["_encstr_A2E90B7A4380A7280893240F31", "_encstr_AD07034A38", 2], ["_encstr_B1E90B59B97DB287CC2D1BBEA9", "_encstr_AD07034A38", 3], ["_encstr_BAE90BE58AA19B422EE758C9F2", "_encstr_A65B084B38A76BEFC350", 3, undefined, ["_encstr_88950636C6DE9B59", 800]], ["_encstr_A9E90BE1101737E81D90ACD97E", "_encstr_AD07034A38", 4]];
  thread _id_134ED(var_0, 4);
  thread _id_140E4();
  thread pointinsquare();
  wait 2;
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_8A12060D5BA9C745", 10);
  objective_setdescription(var_1, &"_encstr_A37E1E860AEB9AD3D7A2D48A50152ACB1494A786545488AFA8F4FA8A2C329262");
  objective_setlabel(var_1, &"_encstr_A1BF13D005D7A67AF551351550A2A2F28A2C322931");
  objective_setplayintro(var_1, 1);
  objective_setplayoutro(var_1, 0);
  objective_position(var_1, scripts\engine\utility::getStruct("_encstr_A3CF10AFF8F12982F7F8CEC4D5B73BE15B88", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin);
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 1);
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 6);
  var_2 = getEnt("_encstr_96CD0D95C3335A637DD9F63657DA59", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = 1;

  while(var_3) {
    if(isDefined(level.playervehicle) && ispointinvolume(level.playervehicle.origin, var_2) && !level.playervehicle.isempty)
      var_3 = 0;

    waitframe();
  }

  if(isDefined(level.playervehicle)) {
    scripts\engine\utility::flag_wait("_encstr_A35D0CDF83056A6728A0FDC2B928");
    thread poke_the_player_after_faux_death();
    objective_state(4, "_encstr_8267056410C669");
    setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 0);
    thread _id_12758("_encstr_9B611A8C1911B5334716235B9B2957EF488B05036998BB2F600B6AF2");
    level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
  }
}

_id_140E4() {
  var_0 = getEnt("_encstr_A2A40E6C39E3B6A7BDAA1030B3D44768", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 notsolid();
  var_1 = getEnt("_encstr_B8C90CCBD338F96A60102E344948", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 notsolid();
  var_2 = scripts\engine\utility::getStruct("_encstr_96400B15996D09595783713EDF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\engine\utility::getStruct("_encstr_88400B882AA5FFE8F726E5F05A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = scripts\engine\utility::getStruct("_encstr_81400BB539CDA9F9F72391DE1F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = scripts\engine\utility::getStruct("_encstr_BE400BDD51B5D1919F7BB9E647", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = scripts\engine\utility::getStruct("_encstr_92400B9D11F591D1DF3BF9A617", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = scripts\engine\utility::getStruct("_encstr_82400B63BA1308C845EE5B37B6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 = scripts\engine\utility::getStruct("_encstr_BD400BCEC237D7B5DECEAC7D9B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 moveTo(var_2.origin, 2, 1.5, 0);
  var_1 rotateTo(var_2.angles, 2, 1.5, 0);
  wait 2;
  var_1 moveTo(var_3.origin, 1);
  var_1 rotateTo(var_3.angles, 1);
  wait 1;
  var_1 moveTo(var_4.origin, 2);
  var_1 rotateTo(var_4.angles, 2);
  wait 2;
  var_1 moveTo(var_5.origin, 3, 1, 0);
  var_1 rotateTo(var_5.angles, 3, 1, 0);
  wait 3;
  var_1 moveTo(var_6.origin, 3, 1, 0);
  var_1 rotateTo(var_6.angles, 3, 1, 0);
  wait 3;
  var_1 moveTo(var_7.origin, 3, 1, 0);
  var_1 rotateTo(var_7.angles, 3, 1, 0);
  wait 3;
  var_1 moveTo(var_8.origin, 3, 1, 0);
  var_1 rotateTo(var_8.angles, 3, 1, 0);
}

pointinsquare() {
  var_0 = getEnt("_encstr_8DCE0F55904F634F2FEAA020E105E3F993", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_AA8C168528A2D9C64FA7B838776C59259B190E9945BBB3E9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 moveTo(var_1.origin, 4, 3, 1);
  var_0 rotateTo(var_1.angles, 4, 2, 1);
  var_2 = getEnt("_encstr_8E5B10B2F02DA37D3B0BA3CAD7935AB3D047", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\engine\utility::getStruct("_encstr_AD9F17C00B816B5FAA8EF57569937B71F8538978E32F43D342", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 moveTo(var_3.origin, 4.5, 3.5, 1);
  var_2 rotateTo(var_3.angles, 4.5, 3.5, 1);
  scripts\engine\utility::flag_set("_encstr_A35D0CDF83056A6728A0FDC2B928");
}

poke_the_player_after_faux_death() {
  var_0 = 2;
  var_1 = 0.2;
  var_2 = 1;
  var_3 = 2;
  var_4 = 0.2;
  var_5 = 1.1;

  if(isDefined(level.playervehicle) && length(level.playervehicle vehicle_getvelocity()) > 200) {
    var_0 = 0.5;
    var_1 = 0;
    var_2 = 0.4;
    var_3 = 0.5;
    var_4 = 0;
    var_5 = 0.35;
  }

  var_6 = getEnt("_encstr_8DCE0F55904F634F2FEAA020E105E3F993", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = scripts\engine\utility::getStruct("_encstr_869714AFFAB8841954230B477789E2CE3866A572F138", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 moveTo(var_7.origin, var_0, var_1, var_2);
  var_6 rotateTo(var_7.angles, var_0, var_1, var_2);
  var_8 = getEnt("_encstr_8E5B10B2F02DA37D3B0BA3CAD7935AB3D047", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = scripts\engine\utility::getStruct("_encstr_AD5E15B21E4B1DBEEC0B8E59BE9C5AD9431DD7ED1C599B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 moveTo(var_9.origin, var_3, var_4, var_5);
  var_8 rotateTo(var_9.angles, var_3, var_4, var_5);
}

_id_131F3(var_0) {
  wait 2;
  scripts\engine\utility::flag_clear("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A");
  scripts\engine\utility::flag_clear("_encstr_887B16B1B2CCD1FAB7134D5636D1D2D92BF54E0B32A5ABB9");
  waitframe();
  level.initvo = scripts\cp\cp_objectives::requestworldid("_encstr_8C6F07548064F3196E" + var_0, 10);
  level.initusage = "_encstr_B40101";
  var_1 = "_encstr_B40101";
  var_2 = [];
  level._id_11F90 = undefined;
  level._id_11F88 = "_encstr_B40101";
  level._id_12BBF = "_encstr_B40101";
  level.useeventamount = 0;
  var_3 = 0;

  switch (var_0) {
    case 0:
      level._id_11F90 = scripts\engine\utility::getStruct("_encstr_9BAC14BD2653598DE8B4D9B2EB1BDE5793D12F2C4EC8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      level.initvehicles = "_encstr_B48F19CC5830F54A2847FFB381E5732D18C6C6D55378AC531F7D13";
      var_1 = "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1";
      var_2 = scripts\engine\utility::getStructArray("_encstr_A1AA10233DCC9270B0B945BF861BE3517D19", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      level._id_11F88 = &"_encstr_B63B288682FAD49EAFA235158215A8BCA68A28258621FAD089A7A15A15A7BAA2A4EB24AA5298224A39D1";
      level.initusage = "_encstr_BD46283287EB8D0EE6F5D60BB5587DB91699B20DBDBACD957DA537D1B21BF53B853A34B24EAC19F5C40C";
      var_3 = 2;
      break;
    case 1:
      level._id_11F90 = scripts\engine\utility::getStruct("_encstr_854E1128063A53F9E42F30500F1C13BB72EC9E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      level.initvehicles = "_encstr_8B1B16EF38C33592E7EE3E724D6BABFD2949131B4899632B";
      var_1 = "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98";
      var_2 = scripts\engine\utility::getStructArray("_encstr_82310DD273A32BC6BED193D5C6DADC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      level._id_11F88 = &"_encstr_81721B8F016EDB782F354AB30F1190FFB7C1FF4301241F11CDD5467C6E";
      level.initusage = "_encstr_8B46288AC2605FCA405F83912308D9D797F912D288CD47C7491B8E8CDB4891FFCF133A8AB3ADD3B11AD1";
      var_3 = 3;
      break;
    case 2:
      level._id_11F90 = scripts\engine\utility::getStruct("_encstr_A9061477DD4847AF1D2D536AAEF6FF7F5851FFD557E8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      level.initvehicles = "_encstr_B2A319E948F3EF6DCF70725BF0A3A2A7A9B87B91D579637573183A";
      var_1 = "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3";
      var_2 = scripts\engine\utility::getStructArray("_encstr_9A7510B49BD159B1AF9BA54656D0DE5DB92B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      level._id_11F88 = &"_encstr_87212536CF57D9BF1ED14F5B19976DC6E7ED0EFADE0151E82499CB6F218C24893F154263B3BF08";
      level.initusage = "_encstr_BD46283287EB8D0EE6F5D60BB5587DB91699B20DBDBACD957DA537D1B21BF53B853A34B24EAC19F5C40C";
      level._id_12BBF = &"_encstr_87212536CF57D9BF1ED14F5B19976DC6E7ED0EFADE0151E82499CB6F218C24893F154263B3BF08";
      level.useeventamount = 1;
      var_3 = 4;
      break;
    case 3:
      level._id_11F90 = scripts\engine\utility::getStruct("_encstr_B22E145802BCE341E35104F50FEF49A3E50AE0AB8B97", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      level.initvehicles = "_encstr_955D19A2F80DAF25B98F312889C0EA17BD767AAAE0E853DDB0D72D";
      var_1 = "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94";
      var_2 = scripts\engine\utility::getStructArray("_encstr_BE0A10A4C8E95264E6789F8758382F1BBFD5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      level._id_11F88 = &"_encstr_8CEA1F5F88014968B790D73FB8F335F2AA35E3F5033CE1A1F7480C461047F5D977";
      level.initusage = "_encstr_B6922971C061D8972F51D33BCB33D840403693E94CD560536BCA4EE333DF0680D184174FE1FD78256FC2AD";
      var_3 = 5;
      break;
  }

  var_4 = scripts\engine\utility::random(var_2);
  var_5 = scripts\cp\laser_traps\cp_laser_traps::trial_active_fob(var_4.origin, var_4.angles, ::train_elements_disable);
  scripts\cp\cp_outline_utility::outlineenableforall(var_5, "_encstr_AAA514372003FC02452D71B705218BB00E48A3B78099", "_encstr_BE8F0A272F9B2BE97268AE8B");
  objective_setdescription(level.initvo, level._id_11F88);
  objective_setlabel(level.initvo, &"_encstr_8ABC1CE80FDF27D039112194E909B0FEA723CD69DDDF6070796C7DD13D60");
  objective_setplayintro(level.initvo, 1);
  objective_setplayoutro(level.initvo, 0);

  if(level.useeventamount) {
    objective_setlocation(level.initvo, 0, scripts\engine\utility::getStruct("_encstr_864F0F623B302DEF48122BB2E929E03F08", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin);
    objective_setlocation(level.initvo, 1, scripts\engine\utility::getStruct("_encstr_82C112B07AF3E5485321ADF36FFA3036DB628979", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin);
  } else
    objective_position(level.initvo, level._id_11F90.origin);

  objective_icon(level.initvo, var_1);
  objective_setshowoncompass(level.initvo, 1);
  objective_state(level.initvo, "_encstr_AF5A081BBAC993AC73A3");
  setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 1);
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", var_3);
}

train_elements_disable(var_0, var_1) {
  level.audio_jugg_death = [];

  foreach(var_3 in getaiarray("_encstr_8E8405EA382B2A")) {
    var_4 = 0;

    if(istrue(var_3.matchdata_logkillstreakevent))
      var_4 = 1;

    if(isDefined(var_3.ridingvehicle))
      var_4 = 1;

    if(!var_4)
      level.audio_jugg_death = scripts\engine\utility::array_add(level.audio_jugg_death, var_3);
  }

  if(!scripts\engine\utility::flag("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A") && level.useeventamount) {
    objective_unsetlocation(level.initvo, 0);
    objective_unsetlocation(level.initvo, 1);
  }

  scripts\engine\utility::flag_set("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A");
  scripts\engine\utility::flag_set("_encstr_AAD914D7E25B4A8C1976A1B8CD484991C99DF6A010CD");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 7);
  objective_onentity(level.initvo, level.playervehicle);
  objective_setlabel(level.initvo, &"_encstr_999F253350C1A2A76957564B50FB45BF1E77994B2B485F0C0383551031A10C97DD77F04B3FE42B");
  objective_setdescription(level.initvo, &"_encstr_999F253350C1A2A76957564B50FB45BF1E77994B2B485F0C0383551031A10C97DD77F04B3FE42B");
  objective_setzoffset(level.initvo, 92);
  var_0 notify("_encstr_832718E84395C10D11C36DF51D9B6389F4F71040973B19EF5A2A");
  var_0 clearhudtutorialmessage(1);
  var_0 thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_82AE1C93712902E7704DD9B1D52D07D531BB1A0ADB311DBF18E4E4B9BD09", 5);
  var_6 = deleteheadicon(var_0);
  var_0.headicon = var_6;
  setheadiconenemyimage(var_6, "_encstr_AFC513632B8D49D1A8403D49FBF8E781D3859BAFF1");
  setheadiconzoffset(var_6, 1);
  addclienttoheadiconmask(var_6, 10);

  foreach(var_8 in level.players) {
    var_8 playlocalsound("_encstr_8A2A10977041BFC5636FF3199B432E681BB0");

    if(var_8 != var_0) {
      var_8 notify("_encstr_832718E84395C10D11C36DF51D9B6389F4F71040973B19EF5A2A");
      var_8 clearhudtutorialmessage(1);
      var_8 thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_95F41A344999415D01B5960C818BE0A76FDF075D681511C4907F3D01", 5);
    }
  }

  thread getcirclerangemin(var_0, var_1.objid);
}

getcirclerangemin(var_0, var_1) {
  var_2 = var_0.origin;
  var_3 = var_0.angles;

  while(isDefined(var_0) && !scripts\cp\cp_laststand::player_in_laststand(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && !scripts\engine\utility::flag(level.initvehicles)) {
    var_2 = var_0.origin;
    var_3 = var_0.angles;

    if(isDefined(level.playervehicle) && distance(var_0.origin, level.playervehicle.origin) <= 128)
      scripts\engine\utility::flag_set(level.initvehicles);

    if(distance2d(var_0.origin, level._id_11F90.origin) > level._id_11F90.radius)
      scripts\engine\utility::flag_set("_encstr_887B16B1B2CCD1FAB7134D5636D1D2D92BF54E0B32A5ABB9");

    waitframe();
  }

  scripts\engine\utility::flag_clear("_encstr_AAD914D7E25B4A8C1976A1B8CD484991C99DF6A010CD");

  if(!scripts\engine\utility::flag(level.initvehicles)) {
    var_4 = scripts\cp\laser_traps\cp_laser_traps::trial_active_fob(var_2, var_3, ::train_elements_disable);
    objective_position(level.initvo, var_2 + (0, 0, 12));
    objective_setlabel(level.initvo, &"_encstr_87C01F86057D9A9EFA514DA2822A15BCD32449FAA451689EAC2A49D7529C51A898");
    objective_setdescription(level.initvo, &"_encstr_87C01F86057D9A9EFA514DA2822A15BCD32449FAA451689EAC2A49D7529C51A898");

    if(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive())
      setheadiconimage(var_0.headicon);

    foreach(var_6 in level.players)
    var_6 playlocalsound("_encstr_A9C90EDF68C15838DB52701EAA2B6048");
  } else {
    objective_state(level.initvo, "_encstr_8267056410C669");
    setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 0);

    foreach(var_6 in level.players) {
      var_6 playlocalsound("_encstr_B692127FC861F8987BF2107EBA3FC1E84535A9FB");
      var_6 notify("_encstr_832718E84395C10D11C36DF51D9B6389F4F71040973B19EF5A2A");
      var_6 clearhudtutorialmessage(1);
    }

    scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_A7AE1DBF7BC99639171F3FD736245110949B194BE311DE2163E587CDEADD91", "_encstr_9A8507BA4040188D08", 7);
    thread _id_12758(level.initusage);

    if(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive())
      setheadiconimage(var_0.headicon);

    wait 5;
  }
}

_id_13517(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\cp\laser_traps\cp_laser_traps::get_enter_leave_station_time(var_2.origin, var_2.angles);
  var_4 = scripts\cp\laser_traps\cp_laser_traps::get_ending_struct(var_3);
  var_5 = scripts\cp\laser_traps\cp_laser_traps::get_emp_effect_duration(var_3);
  thread scripts\cp\laser_traps\cp_laser_traps::get_end_ang(var_3, var_4, var_5, var_1);
}

_id_135B4() {
  var_0 = scripts\engine\utility::getStruct("_encstr_92F817801CAAD8F58E486382EB4B1EB853F0C380F95BDE8123", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(!isDefined(var_0)) {
    var_0 = scripts\engine\utility::getStruct("_encstr_92F817801CAAD8F58E486382EB4B1EB853F0C380F95BDE8123", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    waitframe();
  }

  var_0.team = "_encstr_9A8507BA4040188D08";
  level.playervehicle = scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var_0);
  level.playervehicle scripts\engine\utility::set_ai_number();
  level.playervehicle thread scripts\common\vehicle_code::vehicle_ai_avoidance_logic();
  level.playervehicle scripts\common\vehicle::godon();
  level.playervehicle setCanDamage(0);
  scripts\engine\utility::flag_set("_encstr_9B7610EBFB1BBA4B40B1C1D20BF087026501");
  level.playervehicle.headicon = deleteheadicon(level.playervehicle);
  setheadiconenemyimage(level.playervehicle.headicon, "_encstr_A63F1B306324B9F37AEF85DFB3224BC0FBBD192ECB89E0A00387BDA34B");
  addclienttoheadiconmask(level.playervehicle.headicon, 80);
  setheadiconzoffset(level.playervehicle.headicon, 1);
  setheadiconsnaptoedges(level.playervehicle.headicon, 31999);
  setheadiconmaxdistance(level.playervehicle.headicon, 31999);
  setheadicondrawthroughgeo(level.playervehicle.headicon, 1);
  setheadiconowner(level.playervehicle.headicon, "_encstr_9A8507BA4040188D08");
  hideheadiconfromplayersinmask(level.playervehicle.headicon);
  scripts\engine\utility::flag_wait("_encstr_8E780DEC585BCABEB9D1B0C98E2B8C");
  var_1 = level.players;
  level._id_14255 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupantsandreserving(level.playervehicle);

  foreach(var_3 in level._id_14255)
  var_1 = scripts\engine\utility::array_remove(var_1, var_3);

  foreach(var_3 in var_1)
  addteamtoheadiconmask(level.playervehicle.headicon, var_3);

  var_7 = 0;

  while(isDefined(level.playervehicle)) {
    level._id_14255 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupantsandreserving(level.playervehicle);

    if(scripts\cp\cp_endgame::gamealreadyended()) {
      foreach(var_3 in var_1) {
        removeteamfromheadiconmask(level.playervehicle.headicon, var_3);
        return 1;
      }
    }

    if(scripts\engine\utility::flag("_encstr_AAD914D7E25B4A8C1976A1B8CD484991C99DF6A010CD")) {
      var_7 = 1;

      foreach(var_3 in var_1)
      removeteamfromheadiconmask(level.playervehicle.headicon, var_3);
    } else {
      if(var_7) {
        foreach(var_3 in var_1)
        addteamtoheadiconmask(level.playervehicle.headicon, var_3);

        var_7 = 0;
      }

      foreach(var_3 in var_1) {
        if(scripts\engine\utility::array_contains(level._id_14255, var_3)) {
          var_1 = scripts\engine\utility::array_remove(var_1, var_3);
          removeteamfromheadiconmask(level.playervehicle.headicon, var_3);
        }
      }

      foreach(var_3 in level.players) {
        if(!scripts\engine\utility::array_contains(var_1, var_3) && !scripts\engine\utility::array_contains(level._id_14255, var_3)) {
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
          addteamtoheadiconmask(level.playervehicle.headicon, var_3);
        }
      }
    }

    waitframe();
  }

  level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BD79059C51C351"]);
}

_id_13513(var_0) {
  foreach(var_2 in var_0) {
    if(level.players.size >= var_2[2]) {
      var_3 = scripts\engine\utility::getStruct(var_2[1], "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_4 = undefined;

      switch (var_2[1]) {
        case "_encstr_B483058670B0B7":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles);
          break;
        case "_encstr_8A78055C8D488C":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback(scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles);
          break;
        case "_encstr_88A906570DDE7B21":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::player_limitedammo(scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles);
          break;
        case "_encstr_8DCB085BEF657B4DCF0B":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::_id_11CB8(scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles);
          break;
        case "_encstr_9BD1091BC62CBCB5F6E4CA":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::handle_leads_collected_hideiconbuilding(scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles);
          break;
        case "_encstr_9B6609EB658A6B7A335003":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::_id_13433(scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles);
          break;
        case "_encstr_BA19058303338D":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime(scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles);
          break;
        case "_encstr_8B07036CD0":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled(scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles);
          break;
        case "_encstr_9B1804C793EB":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::plunderfxondropthreashold(scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles);
          break;
        default:
          var_4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, scripts\engine\utility::getStruct(var_2[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles);
          break;
      }

      if(isDefined(var_4))
        setheadiconsnaptoedges(var_4.headiconid, 1000);
    }
  }
}

_id_135F7(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in var_3) {
    if(int(var_5.script_parameters) <= level.players.size)
      _id_135F5(var_5, var_1, var_2);
  }
}

_id_135F5(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_weapon::buildweapon(var_1, var_2);
  var_4 = "_encstr_B2010820C5337B67C8CF" + var_1;

  foreach(var_6 in var_2)
  var_4 = var_4 + ("_encstr_BE4C0295" + var_6);

  var_8 = spawn(var_4, var_0.origin, 1);
  var_8.angles = var_0.angles;
  var_8 _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::setscriptammo(var_1, var_0);
}

_id_1369F() {
  wait 4;
  level._id_13690 = [];
  var_0 = getEntArray("_encstr_92D70D7FE8CE28B8F7A3D199FADF60", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0)
  level._id_13690[var_2.script_parameters] = var_2;

  var_4 = scripts\engine\utility::getStructArray("_encstr_92D70D7FE8CE28B8F7A3D199FADF60", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_6 in var_4)
  level._id_13690[var_6.script_parameters] = var_6;

  scripts\engine\utility::flag_wait("_encstr_8E780DEC585BCABEB9D1B0C98E2B8C");
  scripts\engine\utility::flag_set("_encstr_91640F0B12075BDA51555F578250EFDD08");
}

_id_1321A(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.initteamdatafields = var_2;
  var_4 = [];

  foreach(var_6 in var_3) {
    if(isDefined(var_6.script_demeanor)) {
      if(!isDefined(var_6.script_startingposition))
        var_4 = scripts\engine\utility::array_add(var_4, var_6);
    }
  }

  var_8 = var_1[level.players.size - 1];

  foreach(var_10 in var_8) {
    for(var_11 = 0; var_11 < int(var_10[0]); var_11++) {
      var_12 = 1;
      var_13 = getaiarray("_encstr_8E8405EA382B2A");

      if(getaiarray("_encstr_8E8405EA382B2A").size >= 40)
        var_12 = velnumdatapoints(var_13);

      if(var_12) {
        var_6 = var_4[0];
        _id_131EB(var_6, var_10[1]);
        var_4 = scripts\engine\utility::array_remove(var_4, var_6);
      }
    }
  }

  foreach(var_6 in var_4)
  scripts\engine\utility::deletestruct_ref(var_6);
}

player_sees_hvt_leaving_vo(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon(var_0);
  var_6 = 25;
  var_7 = 90;
  var_8 = gettime();
  var_9 = gettime();
  var_10 = 0;

  if(var_0 != "_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A")
    level endon("_encstr_887B16B1B2CCD1FAB7134D5636D1D2D92BF54E0B32A5ABB9");

  if(isDefined(var_1)) {
    var_11 = getEnt(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    while(!var_11 trial_turret_thread_func())
      waitframe();
  }

  if(!isDefined(var_5))
    var_5 = [2, 4, 5, 6];

  var_12 = var_5[level.players.size - 1];
  var_13 = 0;

  for(;;) {
    var_14 = [];

    foreach(var_16 in level.audio_jugg_death) {
      if(isDefined(var_16) && isalive(var_16))
        var_14 = scripts\engine\utility::array_add(var_14, var_16);
    }

    level.audio_jugg_death = var_14;

    foreach(var_19 in level.players) {
      var_20 = [];

      if(isDefined(var_19._id_12544)) {
        foreach(var_16 in var_19._id_12544) {
          if(isDefined(var_16) && isalive(var_16))
            var_20 = scripts\engine\utility::array_add(var_20, var_16);
        }
      }

      var_19._id_12544 = var_20;
    }

    var_24 = 0;

    if(scripts\engine\utility::flag("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A")) {
      if(level.audio_jugg_death.size > 0)
        var_24 = 1;
    } else if(level.audio_jugg_death.size > var_12)
      var_24 = 1;

    if(var_24) {
      var_25 = level.players[0];

      foreach(var_19 in level.players) {
        if(var_19._id_12544.size < var_25._id_12544.size)
          var_25 = var_19;
      }

      if(var_25._id_12544.size <= var_12 / level.players.size && scripts\engine\utility::time_has_passed(var_9, var_10)) {
        var_16 = scripts\engine\utility::getclosest(var_25.origin, level.audio_jugg_death);
        level.audio_jugg_death = scripts\engine\utility::array_remove(level.audio_jugg_death, var_16);

        if(isDefined(var_16.select_lobby_patrol_spawners))
          var_16.goalradius = var_16.select_lobby_patrol_spawners;
        else
          var_16.goalradius = 600;

        var_16 cleargoalvolume();
        var_16 setgoalentity(var_25);
        var_9 = gettime();
        var_25._id_12544 = scripts\engine\utility::array_add(var_25._id_12544, var_16);

        if(scripts\engine\utility::flag("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A"))
          var_10 = 6 - level.players.size;
        else
          var_10 = 10 - level.players.size;
      }
    } else if(scripts\engine\utility::time_has_passed(var_8, var_6) && getaiarray("_encstr_8E8405EA382B2A").size < var_12 && level.brclosealldoors <= 0) {
      _id_13560(_id_12A02(var_2, var_3), var_4[var_13]);
      var_8 = gettime();
      var_13++;

      if(var_13 >= var_4.size)
        var_13 = 0;

      if(brdownedbyairstriketime())
        var_6 = var_6 + 45;
      else
        var_6 = var_6 + 10;

      if(var_6 > var_7)
        var_6 = var_7;
    }

    wait 0.1;
  }
}

brdownedbyairstriketime() {
  if(level.players.size > 1) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var_2))
        var_0++;
    }

    if(var_0 == level.players.size - 1)
      return 1;
  }

  return 0;
}

_id_13560(var_0, var_1, var_2) {
  var_3 = var_1[level.players.size - 1];
  var_4 = 0;

  foreach(var_6 in var_0) {
    if(var_4) {
      break;
    }

    var_7 = level._id_13690[var_6];

    if(var_7 trial_turret_thread_func() == 0) {
      var_4 = 1;
      var_8 = scripts\engine\utility::getStructArray("_encstr_AC5B0F175DCDAA0189037A06BB38251388" + var_6, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      foreach(var_10 in var_3) {
        for(var_11 = 0; var_11 < var_10[0]; var_11++) {
          var_12 = 0;

          if(isDefined(var_10[2]) && var_10[2])
            var_12 = 1;

          var_13 = getaiarray("_encstr_8E8405EA382B2A");

          if(var_12 && getaiarray("_encstr_8E8405EA382B2A").size >= 40)
            velnumdatapoints(var_13);

          if(getaiarray("_encstr_8E8405EA382B2A").size < 40) {
            var_14 = level.players[0];

            foreach(var_16 in level.players) {
              if(var_16._id_12544.size < var_14._id_12544.size)
                var_14 = var_16;
            }

            var_18 = 600;

            if((var_12 || var_14._id_12544.size < 3) && var_8.size > 0) {
              var_19 = scripts\engine\utility::random(var_8);
              var_8 = scripts\engine\utility::array_remove(var_8, var_19);
              var_19.count = 1;
              _id_131EB(var_19, var_10[1]);
              var_20 = var_19 scripts\cp\laser_traps\cp_laser_traps::_id_134F1(var_19.script_type, var_19.origin, var_19.angles, 1, 1);

              if(isDefined(var_2)) {
                var_20 setgoalvolumeauto(getEnt(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
                level.audio_jugg_death = scripts\engine\utility::array_add(level.audio_jugg_death, var_20);
              } else {
                var_20.select_lobby_patrol_spawners = var_19.select_lobby_patrol_spawners;
                var_20.goalradius = var_19.select_lobby_patrol_spawners;
                var_20 setgoalentity(var_14);
                var_14._id_12544 = scripts\engine\utility::array_add(var_14._id_12544, var_20);
              }

              var_21 = var_20 scripts\cp\laser_traps\cp_laser_traps::print_spawner_score_for_factor();
              var_20 scripts\cp\laser_traps\cp_laser_traps::set_baseaccuracy(0);
              var_20 scripts\engine\utility::delaythread(5.5, scripts\cp\laser_traps\cp_laser_traps::set_baseaccuracy, var_21);
            }

            waitframe();
          }
        }
      }
    }
  }
}

_id_134ED(var_0, var_1) {
  level._id_14071 = [];
  level.initteamdatafields = var_1;

  foreach(var_3 in var_0) {
    var_4 = scripts\engine\utility::getStruct(var_3[0], "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(level.players.size >= var_3[2]) {
      var_5 = 0;

      while(!var_5) {
        var_6 = 1;
        var_7 = getaiarray("_encstr_8E8405EA382B2A");

        if(getaiarray("_encstr_8E8405EA382B2A").size >= 40)
          var_6 = velnumdatapoints(var_7);

        if(var_6) {
          _id_134EE(var_4, var_3, var_1);
          var_5 = 1;
        }

        waitframe();
      }
    }
  }
}

_id_134EE(var_0, var_1, var_2, var_3) {
  var_4 = var_0.script_parameters;
  var_5 = getEnt(var_0.script_parameters, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_5 trial_turret_thread_func() && !istrue(var_3)) {
    var_6 = [];

    foreach(var_8 in level._id_13690) {
      if(!var_8 trial_turret_thread_func())
        var_6 = scripts\engine\utility::array_add(var_6, var_8);
    }

    var_10 = scripts\engine\utility::getclosest(var_0.origin, var_6);
    var_11 = [];
    var_12 = scripts\engine\utility::getStructArray("_encstr_AC5B0F175DCDAA0189037A06BB38251388" + var_10.targetname, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_14 in var_12) {
      if(!scripts\engine\utility::array_contains(level._id_14071, var_14)) {
        var_0 = var_14;
        level._id_14071 = scripts\engine\utility::array_add(level._id_14071, var_0);
        break;
      }
    }
  }

  _id_131EB(var_0, var_1[1]);
  var_16 = var_0 scripts\cp\laser_traps\cp_laser_traps::_id_134F1(var_0.script_type, var_0.origin, var_0.angles, 1, 1);

  if(var_0.script_type != "_encstr_A1C91E665198571380E39B8FCBBB0993603E5AEBCB69EA3BE48FBFDB256F93DC")
    var_16 setgoalvolumeauto(var_5);

  var_16.script_parameters = var_4;
  var_16.set_level_weapons_free = var_2;

  if(var_0.script_type == "_encstr_9A2D25F2F80905133E7DA6A50182DF4E69814B0BD0873F879355A2CC30EBD314D138D321C07DB7") {
    var_16 laseron();
    var_16.matchdata_logkillstreakevent = 1;
  } else if(var_0.script_type == "_encstr_A70F22BED71BB0921E67906D1DDBA1A6784F7A6338EFD23DD38102C371125B5F66358EC4")
    var_16.matchdata_logkillstreakevent = 1;
  else if(var_0.script_type == "_encstr_A1C91E665198571380E39B8FCBBB0993603E5AEBCB69EA3BE48FBFDB256F93DC") {
    var_16.matchdata_logkillstreakevent = 1;
    var_16 thread bomber_death_watcher();
    var_16.goalheight = 3000;
  }

  if(isDefined(var_1[3])) {
    switch (var_1[3]) {
      case "_encstr_8DCB085BEF657B4DCF0B":
        var_16 bomber_disable_movement_for_time();
        break;
      case "_encstr_88A906570DDE7B21":
        var_16 bomb_case_explode_vfx_sequence();
        break;
    }
  }

  if(isDefined(var_1[4])) {
    switch (var_1[4][0]) {
      case "_encstr_88950636C6DE9B59":
        var_16 thread _id_1434A(var_1[4][1]);
        break;
      case "_encstr_A5F108E19FBB92F3D05B":
        var_16 thread _id_14349(var_1[4][1]);
        break;
    }
  }
}

_id_14345() {
  var_0 = getEnt("_encstr_917B0F6BB0D237FADAA5C8D75D07C1B29C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(!var_0 trial_turret_thread_func())
    waitframe();

  var_1 = getEnt("_encstr_85F60B5316D26DB7E72B830D62", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_1 trial_turret_thread_func()) {
    while(var_1 trial_turret_thread_func())
      waitframe();
  }

  var_2 = scripts\engine\utility::getStruct("_encstr_B68315FAC3AF07EEF01D97B413D0B74335FEF2A2C9F8A2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = 0;

  while(!var_3) {
    var_4 = 1;
    var_5 = getaiarray("_encstr_8E8405EA382B2A");

    if(getaiarray("_encstr_8E8405EA382B2A").size >= 40)
      var_4 = velnumdatapoints(var_5);

    if(var_4) {
      _id_134EE(var_2, ["_encstr_B68315FAC3AF07EEF01D97B413D0B74335FEF2A2C9F8A2", "_encstr_8BFC0BC2CBD4F737E0A5E1FD79", 1], 3, 1);
      var_3 = 1;
    }

    waitframe();
  }
}

_id_1434A(var_0) {
  var_1 = getEnt(self.script_parameters, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = 1;
  var_3 = undefined;

  while(var_2) {
    var_4 = scripts\engine\utility::array_removeundefined(level.players);

    foreach(var_6 in var_4) {
      if(!isDefined(var_6) || !isDefined(var_6.origin)) {
        continue;
      }
      if(ispointinvolume(var_6.origin, var_1)) {
        if(distance(var_6.origin, self.origin) <= var_0) {
          var_3 = var_6;
          var_2 = 0;
          break;
        }
      }

      wait 0.1;
    }
  }

  if(isDefined(self.select_lobby_patrol_spawners))
    self.goalradius = self.select_lobby_patrol_spawners;
  else
    self.goalradius = 600;

  var_3._id_12544 = scripts\engine\utility::array_add(var_3._id_12544, self);
  self cleargoalvolume();
  self setgoalentity(var_3);
}

_id_14349(var_0) {
  var_1 = 1;
  var_2 = undefined;

  while(var_1) {
    foreach(var_4 in level.players) {
      if(distance(var_4.origin, self.origin) <= var_0) {
        var_2 = var_4;
        var_1 = 0;
        break;
      }

      wait 0.1;
    }
  }

  if(isDefined(self.select_lobby_patrol_spawners))
    self.goalradius = self.select_lobby_patrol_spawners;
  else
    self.goalradius = 600;

  var_2._id_12544 = scripts\engine\utility::array_add(var_2._id_12544, self);
  self cleargoalvolume();
  self setgoalentity(var_2);
}

_id_131EB(var_0, var_1) {
  var_2 = 600;

  switch (var_1) {
    case "_encstr_A11804C86B39":
      var_0.script_type = "_encstr_A77F21C2B1D1BD27FA959B56B5CBEBC6C1FA27D5E6F591CA9B2BC9A3F51693D7CDB3B3";
      break;
    case "_encstr_9A190463ADB3":
      var_0.script_type = "_encstr_B234229137502D3350A9EA42B09B4FE6C8E71A0D6F61B7576E41235BDE79DF5F591D9667";
      break;
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      var_0.script_type = "_encstr_A1C91E665198571380E39B8FCBBB0993603E5AEBCB69EA3BE48FBFDB256F93DC";
      level.brclosealldoors++;
      var_2 = 300;
      break;
    case "_encstr_A11904E483B3":
      var_0.script_type = "_encstr_A70F22BED71BB0921E67906D1DDBA1A6784F7A6338EFD23DD38102C371125B5F66358EC4";
      break;
    case "_encstr_A65B084B38A76BEFC350":
      var_0.script_type = "_encstr_B40126C2B13AED4E7D959BCAADF27DD8C1F54EAEE6AF32CA9B9527D1F56EA1F6473BD5CDD79B9D76";
      var_2 = 100;
      break;
    case "_encstr_BE1904DCDA9D":
      var_0.script_type = "_encstr_8F0122C2D81D7B27AF2B9B566B97AFD838EB93D5CDAFC8B2CD95938EFA9BB6CEAFE69DCE";
      var_2 = 500;
      break;
    case "_encstr_850707F7E5833355B8":
      var_0.script_type = "_encstr_9A2D25F2F80905133E7DA6A50182DF4E69814B0BD0873F879355A2CC30EBD314D138D321C07DB7";
      var_2 = 10000;
      break;
    default:
      var_0.script_type = "_encstr_A77F21C2B1D1BD27FA959B56B5CBEBC6C1FA27D5E6F591CA9B2BC9A3F51693D7CDB3B3";
      break;
  }

  var_0.select_lobby_patrol_spawners = var_2;
}

_id_14344() {
  scripts\engine\utility::delaythread(1, ::_id_12758, "_encstr_BD6E240A42E0DF4AC0DF04119F1859131778722149C09F45788313277D80DC474E906AA95B87");
  var_0 = getEnt("_encstr_9969130F06F3411168C5306813CAB0DB28AF3BF5AD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(var_0 callback_subscribe())
    waitframe();

  var_1 = getEnt("_encstr_96E5141C7C72CFF66CDBA01857AF481B5A251C2F932A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!var_1 trial_turret_thread_func()) {
    var_2 = [[[2, "_encstr_AD07034A38"]], [[3, "_encstr_AD07034A38"]], [[4, "_encstr_AD07034A38"]], [[4, "_encstr_AD07034A38"]]];
    _id_1321A("_encstr_9A2715D42B5607EB5B2C969BB3C2E895BEE81693EC2B8E", var_2, 1);
    var_3 = scripts\common\utility::getvehiclespawner("_encstr_87580E35CA590EF5AD2CA5B97616A3AC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_4 = var_3 scripts\common\utility::spawn_vehicle();
    thread scripts\common\vehicle_paths::gopath(var_4);
    var_4 thread _id_14354(["_encstr_928D153B6772D0A89FAB93A9D96828168AEF85A7CB7AA5"]);
    var_5 = [[[2, "_encstr_AD07034A38"]], [[2, "_encstr_AD07034A38"]], [[3, "_encstr_AD07034A38"]], [[4, "_encstr_AD07034A38"]]];
    _id_1321A("_encstr_8683162229354B59F85BC9C67FB0DB47C606BB1A539CD74B", var_5, 1);
    var_6 = scripts\common\utility::getvehiclespawner("_encstr_97B30FA6CA951CEBAD0BA5B93B5847CA91", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_7 = var_6 scripts\common\utility::spawn_vehicle();
    thread scripts\common\vehicle_paths::gopath(var_7);
    var_7 thread _id_14354(["_encstr_928D153B6772D0A89FAB93A9D96828168AEF85A7CB7AA5"]);
  }
}

_id_14346(var_0) {
  while(var_0 callback_subscribe())
    waitframe();

  var_1 = getEnt("_encstr_915912CED22BEEFAA339AB36ADFAC634BA931B43", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!var_1 trial_turret_thread_func()) {
    var_2 = [[[2, "_encstr_AD07034A38"]], [[3, "_encstr_AD07034A38"]], [[4, "_encstr_AD07034A38"]], [[4, "_encstr_AD07034A38"]]];
    _id_1321A("_encstr_8C071312B35062FF3680C3BBC99BC7DBD8059765F9", var_2, 1);
    var_3 = scripts\common\utility::getvehiclespawner("_encstr_99960C0431B0E8613E5957B3B753", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_4 = var_3 scripts\common\utility::spawn_vehicle();
    thread scripts\common\vehicle_paths::gopath(var_4);
    var_4 thread _id_14354(["_encstr_BAC312BAE448C984F223837AD9428663600908CF", "_encstr_B4811502F0F8BD5278230F2F0F91CAF6209EFFCAA84054"]);
  }

  var_5 = getEnt("_encstr_BA1F14BB080857E92DF5DF8F2F40D3B1E81177C60350", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!var_5 trial_turret_thread_func()) {
    var_6 = [[[2, "_encstr_AD07034A38"]], [[3, "_encstr_AD07034A38"]], [[4, "_encstr_AD07034A38"]], [[4, "_encstr_AD07034A38"]]];
    _id_1321A("_encstr_99DA156ACB281A77B6385A72C1879317A18119FA5780A3", var_6, 1);
    var_7 = scripts\common\utility::getvehiclespawner("_encstr_B2D30EFAF1EDA3B1F0A31CE54798833F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_8 = var_7 scripts\common\utility::spawn_vehicle();
    thread scripts\common\vehicle_paths::gopath(var_8);
    var_8 thread _id_14354(["_encstr_B4811502F0F8BD5278230F2F0F91CAF6209EFFCAA84054"]);
  }
}

_id_12A02(var_0, var_1) {
  var_2 = [];
  var_3 = var_0;
  var_4 = var_1;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = scripts\engine\utility::random(var_3);
    var_3 = scripts\engine\utility::array_remove(var_3, var_6);
    var_2 = scripts\engine\utility::array_add(var_2, var_6);
  }

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = scripts\engine\utility::random(var_4);
    var_4 = scripts\engine\utility::array_remove(var_4, var_6);
    var_2 = scripts\engine\utility::array_add(var_2, var_6);
  }

  return var_2;
}

trial_turret_thread_func() {
  var_0 = 1;

  if(isstruct(self))
    var_0 = 0;

  foreach(var_2 in level.players) {
    if(var_0) {
      if(ispointinvolume(var_2.origin, self))
        return 1;
    } else if(distance2d(self.origin, var_2.origin) <= self.radius)
      return 1;
  }

  return 0;
}

callback_subscribe() {
  var_0 = 1;

  if(isstruct(self))
    var_0 = 0;

  foreach(var_2 in level.players) {
    if(var_0) {
      if(!ispointinvolume(var_2.origin, self))
        return 0;
    } else if(!distance2d(self.origin, var_2.origin) <= self.radius)
      return 0;
  }

  return 1;
}

velnumdatapoints(var_0) {
  var_1 = 0;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_5 = 0;

    foreach(var_7 in level.players)
    var_5 = var_5 + distance(var_7.origin, var_4.origin);

    if(var_5 > var_1) {
      if(!isDefined(var_4.set_level_weapons_free) || isDefined(var_4.set_level_weapons_free) && var_4.set_level_weapons_free < level.initteamdatafields) {
        var_1 = var_5;
        var_2 = var_4;
      }
    }
  }

  if(isDefined(var_2)) {
    var_2 kill();
    return 1;
  }

  return 0;
}

_id_14354(var_0) {
  self waittill("_encstr_A9210A283BEC90BB323450EC");
  var_1 = 0;

  foreach(var_3 in self.riders) {
    var_3 setgoalvolumeauto(getEnt(var_0[var_1], "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
    var_1++;

    if(var_1 >= var_0.size)
      var_1 = 0;

    level.audio_jugg_death = scripts\engine\utility::array_add(level.audio_jugg_death, var_3);
  }
}

_id_14352(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_A9210A283BEC90BB323450EC");
  var_1 = 0;

  foreach(var_3 in self.riders) {
    if(var_3 != self.driver) {
      var_3 setgoalvolumeauto(getEnt(var_0[var_1], "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
      var_1++;

      if(var_1 >= var_0.size)
        var_1 = 0;

      level.audio_jugg_death = scripts\engine\utility::array_add(level.audio_jugg_death, var_3);
    }
  }
}

_id_14353() {
  self waittill("_encstr_A9210A283BEC90BB323450EC");

  foreach(var_1 in self.riders) {
    if(var_1 != self.driver)
      var_1 nextareanags();
  }
}

nextareanags() {
  if(isDefined(self.select_lobby_patrol_spawners))
    self.goalradius = self.select_lobby_patrol_spawners;
  else
    self.goalradius = 600;

  var_0 = level.players[0];

  foreach(var_2 in level.players) {
    if(var_2._id_12544.size < var_0._id_12544.size)
      var_0 = var_2;
  }

  var_0._id_12544 = scripts\engine\utility::array_add(var_0._id_12544);
  self setgoalentity(var_0);
}

bomber_disable_movement_for_time() {
  self.grenadeweapon = getcompleteweaponname("_encstr_BA730BF8AFF178988293F158B9");
  self.grenadeammo = 255;
  self.grenadesafedist = 400;
  self.grenadeweapon.ammo = 255;
}

bomb_case_explode_vfx_sequence() {
  self.grenadeweapon = getcompleteweaponname("_encstr_ADDE09191257768811AD59");
  self.grenadeammo = 255;
  self.grenadesafedist = 400;
  self.grenadeweapon.ammo = 255;
}

_id_14347() {
  var_0 = getEnt("_encstr_886F0ECE2CC932B273AF235999B2CD91", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(!var_0 trial_turret_thread_func())
    waitframe();

  var_1 = scripts\engine\utility::getStructArray("_encstr_B2C515701BA5A11FF3690496FF7A53091D17F808F347FB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    var_4 = magicgrenademanual("_encstr_8823119675DAFF897F878020BB99612B219D8F", var_3.origin, anglesToForward(var_3.angles) * 800, 3, level.player);
    wait(randomfloatrange(0.7, 1.5));
  }

  var_0 = getEnt("_encstr_B8EA1757D011C52277156AE768198A8E5970835F330B378A69", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(!var_0 trial_turret_thread_func())
    waitframe();
}

_id_1431B() {
  var_0 = getEnt("_encstr_B1560993CFDA78A93504E9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_8D701608D9ABD8C10C0A2DFF6FD8077F4CE786580DB3A542", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt("_encstr_85F60B5316D26DB7E72B830D62", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEnt("_encstr_A96B1B5BB096CDAFA1EDAE6E59FACD47162DE4CDD7C207839CBD163634", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = getEnt("_encstr_86531642372826F990D38BB2E911E05F406AE19B93407235", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = getEnt("_encstr_928D153B6772D0A89FAB93A9D96828168AEF85A7CB7AA5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(!var_3 trial_turret_thread_func() && !var_0 trial_turret_thread_func())
    waitframe();

  if(!var_0 trial_turret_thread_func()) {
    thread player_maxhealth("_encstr_8E5B1AB6C22D73A17BAB9BCAD73B9CB2DC161959FA1DD0E4DBEEEB26");

    while(!var_0 trial_turret_thread_func())
      waitframe();

    if(!var_2 trial_turret_thread_func())
      thread player_maxhealth("_encstr_BE5B1A61319435A29DF393C31F18F6F2CE8FFDC01120C23B504B5E7B");
  }

  while(!scripts\engine\utility::flag("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A") && !var_1 trial_turret_thread_func())
    waitframe();

  if(!var_2 trial_turret_thread_func())
    thread player_maxhealth("_encstr_925B1AE238E3B58BC8A56B75A8113BBF05C0FAFA61616CABA08C7F3B");

  scripts\engine\utility::flag_wait("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A");

  while(!scripts\engine\utility::flag("_encstr_955D19A2F80DAF25B98F312889C0EA17BD767AAAE0E853DDB0D72D") && !var_4 trial_turret_thread_func() && !var_5 trial_turret_thread_func())
    waitframe();

  if(!scripts\engine\utility::flag("_encstr_955D19A2F80DAF25B98F312889C0EA17BD767AAAE0E853DDB0D72D")) {
    var_6 = scripts\engine\utility::getStructArray("_encstr_9B1E16314F3AD084B8CF6739779B6D2724F5CF1F6B71C260", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_8 in var_6) {
      magicgrenademanual("_encstr_8823119675DAFF897F878020BB99612B219D8F", var_8.origin + (0, 0, 5), (0, 0, 0), 1, level.player);
      wait(randomfloatrange(0.7, 1.5));
    }
  }
}

player_maxhealth(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    var_4 = 1000;
    magicgrenademanual("_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683", var_3.origin, anglesToForward(var_3.angles) * var_4, 3, level.players[0]);
    wait(randomfloatrange(0.7, 1.5));
  }
}

weapon_xp_iw8_sm_smgolf45(var_0, var_1) {
  while(var_0 > 0) {
    if(istrue(var_1)) {
      foreach(var_3 in level.players) {
        var_3 playlocalsound("_encstr_A6DA11CA3125AF3CD1D74C21ADF089BBC3E922");
        var_3 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", var_0);
        var_3 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 0);
      }
    }

    var_0--;
    wait 1.0;
  }
}

_id_12758(var_0) {
  level.light_tank_removegunnerdamagemod = scripts\engine\utility::array_add(level.light_tank_removegunnerdamagemod, var_0);
}

light_tank_gunnerdamagemodignorefunc() {
  level.light_tank_removegunnerdamagemod = [];

  for(;;) {
    while(level.light_tank_removegunnerdamagemod.size == 0)
      waitframe();

    var_0 = level.light_tank_removegunnerdamagemod[0];
    level.light_tank_removegunnerdamagemod = scripts\engine\utility::array_remove_index(level.light_tank_removegunnerdamagemod, 0);

    if(!isDefined(level._id_121A7))
      level._id_121A7 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));

    level._id_121A7 stopsounds();
    var_1 = lookupsoundlength(var_0) * 0.001;
    level._id_121A7 playSound(var_0);
    wait(var_1);
    level.waittill_wave_spawned_or_timeout = gettime();
    wait 1;
  }
}

bomber_death_watcher() {
  self endon("_encstr_AD75063D571AE108");
  thread vehicle_mp_createlate();
  childthread vehicle_mp_deletenextframelate();
  childthread _id_14342();
  scripts\cp\laser_traps\cp_laser_traps::set_goal_pos(self.origin);
  scripts\cp\laser_traps\cp_laser_traps::disable_surprise();
  self.stuncooldown = 0;
  self.allowpain = 0;

  if(level.gameskill <= 2)
    self.juggernautstopdistance = 500;
  else
    self.juggernautstopdistance = 600;

  self.minpaindamage = 1000;
  self.minpainvalue = 1000;
  self.runcooldown = 2000;
  self.cautiousnavigation = 0;
  self.juggernautwalkdist = 250;
  self.juggernautgoalradius = 25;
  self.goalheight = 25;
  self.goalradius = 2048;
  self.juggernautacceleration = 100;
  self.juggernautcanseeenemydelaymin = 500;
  self.juggernautcanseeenemydelaymax = 1000;
  self.juggernautrundelaymin = 250;
  self.juggernautrundelaymax = 750;
  childthread scripts\cp\laser_traps\cp_laser_traps::_id_13F98();
  self.dropweapon = 0;
  _id_1333A();
}

_id_1333A() {
  self.objindex = scripts\cp\cp_objectives::requestworldid("_encstr_97B4051FB0E8F7" + self getentitynumber(), 5);
  objective_setplayintro(self.objindex, 0);
  objective_setplayoutro(self.objindex, 0);
  objective_setownerteam(self.objindex, "_encstr_8E8405EA382B2A");
  objective_state(self.objindex, "_encstr_930B07BB1B6B3854FF");
  objective_icon(self.objindex, "_encstr_A13718BF3A67AAB7F81C98731DB6A7E7E8FFC9A45D6042F90BC9");
  objective_setlocation(self.objindex, 0, self);
  thread laser_sights(self.objindex, "_encstr_97B4051FB0E8F7" + self getentitynumber());
}

laser_sights(var_0, var_1) {
  self waittill("_encstr_AD75063D571AE108");
  scripts\cp\cp_objectives::freeworldid(var_1);
  objective_state(var_0, "_encstr_8267056410C669");
}

_id_14342() {
  var_0 = 1;

  while(var_0) {
    wait 0.2;

    foreach(var_2 in level.players) {
      if(distance(var_2.origin, self.origin) <= 2048)
        var_0 = 0;
    }
  }

  setmusicstate("_encstr_9B03144F77D1D2ABE76911ABFD69D8B3E17F3E2B7E28");
  scripts\engine\utility::delaythread(2, ::_id_12758, "_encstr_8BBD211D484F98D966B1D8F81B7DCF305FFF1405BA63C1EB0BD9682822D55B2E3773AD");
}

vehicle_mp_createlate() {
  self waittill("_encstr_AD75063D571AE108");
  level.brclosealldoors--;
}

vehicle_mp_deletenextframelate() {
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

_id_13523(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  thread scripts\cp\laser_traps\cp_laser_traps::_id_13542(var_3.origin, var_3.angles);
}

_id_1249B(var_0, var_1, var_2) {
  thread _id_12758("_encstr_9BFB1F32C3D75BC116FAC9BA8EC6AFCDACE647C997FACEAB73BE583686B42BD9AC");
}

_id_1249A(var_0, var_1, var_2) {
  thread _id_12758("_encstr_AFBC2819E1AF5B83C27DE4571D1BEBE09CCA8DD29B5AED37BE852D9C9BA3274BD656FA168D3496959DB2");
}

heli_crash_on_pilot_death() {
  self endon("_encstr_AD75063D571AE108");

  while(!isDefined(self.driver))
    wait 0.1;

  self.driver.health = self.driver.health + 100;
  self.driver waittill("_encstr_AD75063D571AE108");

  if(scripts\common\vehicle::vehicle_is_crashing()) {
    return;
  }
  self dodamage(self.health - self.healthbuffer + 1, self.origin);
}

heli_death_thread() {
  self waittill("_encstr_A6031278D920CF1E337059BFB30AE728497B302A");
  var_0 = self.origin;

  foreach(var_2 in self.riders)
  var_2 kill();

  self stopsounds();
  thread scripts\engine\utility::play_sound_in_space("_encstr_AFF61652F8E04B09A0239C91C7700AF39D73B96A23CF5FBC", var_0);
  playFX(scripts\engine\utility::getfx("_encstr_B6B3110D86C021E3470A2856E24BA7F05D1CA3"), var_0);
  waitframe();
  self delete();
}