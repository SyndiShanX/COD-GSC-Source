/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_smuggler\cp_smuggler.gsc
***********************************************/

main() {
  level.default_player_spawns = "_encstr_9BD00F2356CCB0D5C6E8BEB98358DDCDFA" + level.script;
  scripts\cp\cp_compass::setupminimap("_encstr_BE2418CB77C0B2370ED3311AF9E7972E80AF535DAB68BFCB3DEB");
  _encstr_8F9A3592FEB5C228D3F8D6FFF860FD8A490E0D0EDF473B4D9B70FFCBB8E3E7D2E1B0E205C56FB284A1A027433879633A9FB3EF6DA4AF4A::main();
  _encstr_AA89341E7E837393EC5FF298BB5FC89B4BE2B8AE12090F78B537A818F73AC8DFA24D20266AA1D7A09D5FA010DF521E0BBB7328BC029A::main();
  _encstr_8FAC2FD3D07234180CBF5D3F4B98C5EFEA6332EEF839576D433104B4459D6F26CB9F9B35E391B70D37EBCFDBF8D81A5F37::main();
  _encstr_AB8835DCC64E2D078E37BCB11CCBB5C2E09B798D07AF9BB5AB76B363B293CB1BE0D7E65BAB76B3B1564EEB364BEC0D1D96DC3B713B9B8D::main();
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  setdvarifuninitialized("_encstr_86E10F37B1C9AFEA6E2BEBE68BAB2CC89B", 1);

  if(level.createfx_enabled) {
    return;
  }
  registerscriptedagents();
  scripts\cp_mp\tripwire::precache("_encstr_837D0F9405A8FA375BBBAAF1632DA7B298", "_encstr_92561EBFCB9DB25070B9951B16488529F52517637FCB4B3DB9414FA46880DEE2");
  scripts\cp_mp\tripwire::precache("_encstr_837D0F9405A8FA375BBBAAF1632DA7B298", "_encstr_99261BC93A1D2057A2EF5D61EFEB1149B452F0E32379B085B9BFBB491B");
  scripts\cp_mp\tripwire::precachetrap("_encstr_8B11138E9C4B83BB4B2756EBD1E42C83D7CC4E85CE", "_encstr_923A1AA7D52492717889292B4019BFEB0D6D27034BC08A2168B18B23", 1);
  scripts\cp\utility::coop_mode_enable();
  scripts\cp_mp\utility\game_utility::registerlargemap();
  create_level_funcs_tables_and_vars();
  init_global_systems();
  init_objectives();
  init_level_systems();
  _encstr_BEB2384F98CBE18B792E557E97E712B1D370468798C6338283CC4FB575050E7B3BA9BF2718399FDA8B5E596EEBC3020B83C04FA3E8139E92FFFE::_id_131ED();
  scripts\mp\brclientmatchdata::getquestrewardgroupindex();
  level.incorrectcodeentered = 1.5;
  scripts\mp\brclientmatchdata::getpresettruckspawns("_encstr_8A12071CD08B1F423B", _encstr_BEB2384F98CBE18B792E557E97E712B1D370468798C6338283CC4FB575050E7B3BA9BF2718399FDA8B5E596EEBC3020B83C04FA3E8139E92FFFE::_id_11C58);
  var_0 = getDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101") {
    scripts\mp\brclientmatchdata::getnextprop(var_0);
    scripts\mp\brclientmatchdata::getnextrpgspawnmodule(var_0);
    level thread[[level._id_12B19[var_0]]]();
  } else {
    var_1 = getDvar("_encstr_B89A16B183BE6EDAEAD9B3635693EB9B3A85E447AFF6319A", "_encstr_8EE61883FA7355A005AD37039F6AABAE47A3390B478680709D85");

    if(var_1 == "_encstr_B40101")
      var_1 = "_encstr_8EE61883FA7355A005AD37039F6AABAE47A3390B478680709D85";

    setDvar("_encstr_B89A16B183BE6EDAEAD9B3635693EB9B3A85E447AFF6319A", var_1);

    if(isDefined(var_1))
      level thread rundebugstartobjective(var_1);
  }

  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
  thread incrementalrespawnpunishmax();
  thread player_exfil_struct();
  thread _id_13528();
}

incrementalrespawnpunishmax() {
  wait 5;
  var_0 = spawn("_encstr_8A941B8BA78B102A492CFE2992076A0890DC4972DD4312852A27C202AB", (0, 0, 0));
  var_0 settransientsoundbank("_encstr_A3631347F0A97B4F0F5BC8F322D70918BA36CB2184", 1);
}

create_level_funcs_tables_and_vars() {
  level.objectivesfunc = ::levelobjectives_init;
  level.map_interaction_func = _encstr_A95739DC1BC92D1CA337BC36C15E5B0B83B9CB361CFAE6ADBA9D3BC62BC9798D07F5DC5BBAB33B8D2B4EFA963747B2E4B0C68E96B7379B5CB3E636::register_interactions;
  level.player_interaction_monitor = _encstr_A95739DC1BC92D1CA337BC36C15E5B0B83B9CB361CFAE6ADBA9D3BC62BC9798D07F5DC5BBAB33B8D2B4EFA963747B2E4B0C68E96B7379B5CB3E636::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_A95739DC1BC92D1CA337BC36C15E5B0B83B9CB361CFAE6ADBA9D3BC62BC9798D07F5DC5BBAB33B8D2B4EFA963747B2E4B0C68E96B7379B5CB3E636::level_specific_wait_for_interaction_triggered;
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_A9243D3F497B1B6B9B0B58CFC047257890630E51639FB265BDF87751400528E8421952A9958C44F06A3BE78B92E11BB07B4B80183F77CD6B65CEFB20E27F6B";
  level.disable_start_spawn_on_navmesh = 1;
  level.additional_laststand_weapon_exclusion = [];
  level.ambientgroupinit = ::register_spawn_modules;
}

init_objectives() {
  level thread scripts\cp\cp_objectives::objectives_init();
  level thread setup_global_event_objectives();
  level thread _encstr_A6B43D7FA8FBD1BB297E050EE7B72261038096B7C8B601D35B965A80EE4F1A388E087747704B516FCF20267CBDFF23F973C067871003876291CD2A659487AA::main();
  level thread _encstr_9ACB388F6126F16B4348E02948B59D5F8703609EBA8FE7F37B9382FAE712A6DF52B921632B62F8E3552782470FB7462C475B801B0E37D2D2BBB7::main();
}

levelobjectives_init() {
  level.objectives_table = "_encstr_B1B41E66CA2617C3970FD01837C718435BB9E87EA47ADF8B9903E8302A1B33AD";
  level.objectivesmatrixtable = "_encstr_86C024AE9A02EA0FC75A5F98D3155FC3DE4836A2D773E973A03D532159FF988591085AF3F3F8";
  level.objectiveregistration = ::levelregisterobjectives;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

init_global_systems() {
  scripts\vehicle\techo::main("_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382", "_encstr_8DC71569E5A638C00F6B687263378E48BD6ED70BB70E40", "_encstr_84532DB7DF73E3D814B1A3D964E188A9FAC71B370A0935B04D9608968BD5D0D3F25FAFB127E37511602C72EBF4BB98");
  scripts\vehicle\techo::main("_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382", "_encstr_AB560E05670AE9D86FEB60D0DF619117", "_encstr_84532DB7DF73E3D814B1A3D964E188A9FAC71B370A0935B04D9608968BD5D0D3F25FAFB127E37511602C72EBF4BB98");
  scripts\vehicle\mkilo23_ai_infil::main("_encstr_A27620B3B21A077DAD5AC6AF1B3719FADADAA563DB2399AF07A15E37D2B1E6F56B07", "_encstr_B87B11439AA9512A79A760E17BE35A272F677A", "_encstr_AD6C2DB9D8274B07E8BED9B24370D7B696B1F5B1B923AFB66DD28D7B19CC7D1C0D2FE6D2C6B97DB05AAFB4CDCC96B1");
  scripts\vehicle\empty_turret::main("_encstr_96CE0F8D83AF1DABC9C9563AF5C4DB2397", "_encstr_8C2A0D6F68EF6DE92E0B681D764723", "_encstr_AC291C7FFB0AD8B75B71B3D9EAC7E628676FEBCB70F3106863CBCB2302EB");
  scripts\cp\cp_remote_tank::main("_encstr_BE60197393DBEB2F50DA9D27AD609F87204017E5D573216D879BA3", "_encstr_BE1B129DCAA1F583B036BEB92B37D14E5E7DAD83", "_encstr_AAE42838923A7BA363E78475B87F8929A7F970A8C996BFF83BCD07F7B7DF10F30FB208C83221D311AFFC");
  scripts\cp\cp_remote_tank::main("_encstr_850114B32B430EBE6BA536AFC6B923FAEE43DEA359B1", "_encstr_BE1B129DCAA1F583B036BEB92B37D14E5E7DAD83", "_encstr_AA6E28FF6F7308C395309EDDD0630AC369B1DAFB9E67226A2DC5B91B991F58F197A303A748F143131704");
  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  setup_create_script();
  level thread scripts\cp\crate_drops\cp_crate_drops::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level thread scripts\cp\cp_breach_c4::main();
  level thread scripts\cp\intel\cp_intel::intel_init();
  level thread scripts\cp\intel\cp_intel::init_intel_pieces("_encstr_BD50097A1143DAD738900B");
  scripts\cp\cp_gameskill::init_gameskill();
  level thread scripts\cp\cp_kidnapper::init_kidnapper_combat_loop();
  level thread scripts\cp\cp_battlechatter::manualinitbattlechatter();
}

init_level_systems() {
  level thread setup_map_specific_devgui();
  level thread wait_for_pre_game_period();
  level thread heli_crash_path_loc_setup();
  level thread _encstr_99A330CDB1E4B4E047DC976C3879B58538CDBCC6C1FA23BD9BCAD1E65BCB36E0D791DE73CA1D37B57D4BE6A32B63B8ECB98D::init_intel_pieces();
}

spawn_technicals_for_players() {
  wait 10;
  var_0 = spawnStruct();
  var_0.origin = (29647.5, -9049.5, -424);
  var_0.angles = (0, 120, 0);
  var_0.team = "_encstr_9A8507BA4040188D08";
  scripts\cp_mp\vehicles\technical::technical_create(var_0);
  var_0 = spawnStruct();
  var_0.origin = (17811.5, -22229.5, -210.101);
  var_0.angles = (0, 135, 0);
  var_0.team = "_encstr_9A8507BA4040188D08";
  scripts\cp_mp\vehicles\technical::technical_create(var_0);
}

heli_crash_path_loc_setup() {
  wait 2;
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
}

rundebugstartobjective(var_0) {
  wait 2;
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_wait("_encstr_95D217A54E55D2EB03D84337513BA1EA0155211AA7CD0B35E9");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(isDefined(level.objectivestabledata[var_0])) {
    var_1 = level.objectivestabledata[var_0];

    if(isDefined(var_1.csdependency)) {
      if(!scripts\engine\utility::flag_exist(var_1.csdependency))
        scripts\engine\utility::flag_init(var_1.csdependency);

      scripts\engine\utility::flag_set(var_1.csdependency);

      if(!scripts\engine\utility::flag_exist(var_1.csdependency + "_encstr_93D80BF536F6B638D8AC1D95C8"))
        scripts\engine\utility::flag_init(var_1.csdependency + "_encstr_93D80BF536F6B638D8AC1D95C8");

      scripts\engine\utility::flag_wait(var_1.csdependency + "_encstr_93D80BF536F6B638D8AC1D95C8");
    }

    if(isDefined(var_1.ondebugstartfunc))
      [[var_1.ondebugstartfunc]](var_1);

    thread scripts\cp\cp_objectives::run_objective(var_1.objname, var_1.questtype);
  }
}

levelregisterobjectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_95D217A54E55D2EB03D84337513BA1EA0155211AA7CD0B35E9");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  level thread _encstr_AFA33D0BD15B9040DBB23EBF1AA7534883A7BEDF83C1BD557A4903E3E7306BE32949F01A81B4A7C3F94049C8F16390D837609BAB35C8767068576E55446A89::register_smugglercache_objective();
  level thread _encstr_AFA43B0BD15B9040DBB23EBF1AA7534883A7BEDF83C1BD557A4903E3E7306BE32949F01A81B4A7C3F94049C8F14233F01D708BAB0D487410A87A640246::register_apprehension_objective();

  if(isDefined(level.convoy4_objective_func))
    [[level.convoy4_objective_func]]();

  if(isDefined(level.safehouse_s11_obj_func))
    level thread[[level.safehouse_s11_obj_func]]();
}

setup_global_event_objectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp\cp_objectives_events::init();
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
  register_cs_inits();
  scripts\cp\utility::register_create_script("_encstr_8C362076B8B7410F4D8A40704229EFB8F7578C7905BB6E49F70290E8FA3AA9F1B3EB", "_encstr_8C362076B8B7410F4D8A40704229EFB8F7578C7905BB6E49F70290E8FA3AA9F1B3EB", level.scripted_spawner_func.size, _encstr_9A5240AB261D2FCB0BC3AEA709FFDA5A9A5F6E2959177FCDC71C90C00DB3BE025B8F113FD819689867FFC2CF70A72019A915AF991310C9F3185003B2EB8FA6E81F67::main);
  scripts\cp\utility::register_create_script("_encstr_88801936837D91DB73564737DA7D370E16DD377D0785E495B93AE6", "_encstr_88801936837D91DB73564737DA7D370E16DD377D0785E495B93AE6", level.scripted_spawner_func.size, _encstr_A20A380EDB739021DBFBAAC0E3252329D353B88E201FF95705E268784ADDF74317EC10F08DDB4387A1AB40E063A5D79B4782AD78F47F20D792B2::main);
  scripts\cp\utility::register_create_script("_encstr_847614C607F5C8DE37593ACD5BD7A5378EB2C6D71B9B", "_encstr_847614C607F5C8DE37593ACD5BD7A5378EB2C6D71B9B", level.scripted_spawner_func.size, _encstr_92A233BBE21B7B48DBB3E777D855F837BB5BB8213B57257875BD294FFBBD40075F420808F253E660C19915491D55D946077E81533A::main);
  scripts\cp\utility::register_create_script("_encstr_B666176C0E7DB9AD57763BC695E4FAB3561AD236C6CAEB36B9", "_encstr_B666176C0E7DB9AD57763BC695E4FAB3561AD236C6CAEB36B9", level.scripted_spawner_func.size, _encstr_88FD371B7F6A4A70C330B7C30768276A83ABAED8739FD3832D8F77F15573C7915B79BB1B257789506F45710ED3A1A17F71C9D79A8728FF47B7::main);
  scripts\cp\utility::register_create_script("_encstr_93431232DF1F8A5AD0CB5FF12CE3FFEA07110A46", "_encstr_97BF19B107FAD8859C951C2C1BB6B0D9567DD84E0B47B2E6AFD86E", level.scripted_spawner_func.size, scripts\cp\crate_drops\cp_crate_drops_cs::main);
  scripts\cp\utility::register_create_script("_encstr_ABD222387F4924AFA80B43FA048F430FE530209A3B075FB6780340079EEEC6A14BA161B2", "_encstr_ABD222387F4924AFA80B43FA048F430FE530209A3B075FB6780340079EEEC6A14BA161B2", level.scripted_spawner_func.size, _encstr_AFA4410BD15B9040DBB23EBF1AA7534883A7BEDF83C1BD557A4903E3E7306BE32949F01A81B4A7C3F9A0294952D2D0D81F7057873BC073F8290F4F92586E8B4D0F6BCE::main);
  scripts\cp\utility::register_create_script("_encstr_BAA2264327F6D74DFB30723AD80D0657A983CDEB28B8DFD2D160F9C2480BFE5BC1E04373D6E06B9B", "_encstr_BAA2264327F6D74DFB30723AD80D0657A983CDEB28B8DFD2D160F9C2480BFE5BC1E04373D6E06B9B", level.scripted_spawner_func.size, _encstr_81E24513A7F03CAB551B8EB2839717F6382FF78B19F1078F70F133BBC82857EAE9D73D055F88CD6F26297AA2B055DFE91847BA8CF9A1560B450123CA3EB6C71A88E134AE0F989E::main);
  scripts\cp\utility::register_create_script("_encstr_8463204B1FCEF343D7686A73F01531632086C4C82011A30F83884209780F32377B6D", "_encstr_8463204B1FCEF343D7686A73F01531632086C4C82011A30F83884209780F32377B6D", level.scripted_spawner_func.size, _encstr_ADD43FF3EF70630F29D0EA9647F053772A83571F10411B2262DD89A7CAE8DB7369B32D470FC4F7F8738FB082634C921136D32B88609BDFFF4F8340EBA590C2E7D9::main);
  scripts\cp\cp_create_script_utility::register_cs_offsets("_encstr_878D21670948F395D09B5298FB49CB6AB86DCF8739901A6A28C1CBE74E10137383F92B", (28911.3, 41021.8, 1040), (0, 300, 0));
  scripts\cp\utility::register_create_script("_encstr_878D21670948F395D09B5298FB49CB6AB86DCF8739901A6A28C1CBE74E10137383F92B", "_encstr_878D21670948F395D09B5298FB49CB6AB86DCF8739901A6A28C1CBE74E10137383F92B", level.scripted_spawner_func.size, _encstr_816A4083DA235360C3AB8F0FB07DC02F53B39009533F97B05E823D339A45686F470B53F19B53CBC2F96B3F65E6BDF0159F82CBF932230D718A430D6308237274477A::main);
  scripts\cp\utility::register_create_script("_encstr_854823D883EBCD5B573BEC362BC9AF9B85CC59A1DE57DC95FAD8E4AC588E95E6369C960E1D", "_encstr_9A7625B11C7DDCB5BA3B9DC656E4BEDCB03359A17BAE6E56BE23F5D827ACB047B26E8D394B1C8E", level.scripted_spawner_func.size, _encstr_819F434F2B5B808763C3984637A019589713AEC80FAFC3F01F04F101B818978EDB19DBF0E33F41D9E13B2F778F0D8DD03AB393F7AF8248E0B90CA7ABC6732B78DCAABF9217::main);

  if(level.scripted_spawner_func.size < 1)
    scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
}

register_cs_inits() {
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_847614C607F5C8DE37593ACD5BD7A5378EB2C6D71B9B");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_93431232DF1F8A5AD0CB5FF12CE3FFEA07110A46");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_B666176C0E7DB9AD57763BC695E4FAB3561AD236C6CAEB36B9");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_8C362076B8B7410F4D8A40704229EFB8F7578C7905BB6E49F70290E8FA3AA9F1B3EB");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_88801936837D91DB73564737DA7D370E16DD377D0785E495B93AE6");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_BD71217A43E0C38D28AB1C03AF79521F941942224B4E9FC91097171679D01B5B50710B");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("_encstr_86F1195BC207F519F6DDDCE8EDEEDCBE382C3AE4F61B7D070B3AA1");
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

registerscriptedagents() {
  scripts\mp\agents\soldier\soldier_agent::registerscriptedagent();
  scripts\mp\agents\juggernaut\juggernaut_agent::registerscriptedagent();
}

onplayerconnect(var_0) {
  var_0.gameskill = scripts\cp\cp_gameskill::get_gameskill();
  var_0 scripts\cp\cp_gameskill::set_difficulty_from_locked_settings();
  var_0 thread scripts\cp\coop_personal_ents::player_run_pent_updates(var_0);

  if(getdvarint("_encstr_BA5A1066DE93C695AF9BC10BDD377D9DAC86", 0) != 0) {
    var_1 = [(20120, -24623, 1000), (19554, -24184, 1000), (18935, -23685, 1000), (18319, -22907, 1000), (13692, 15239, 1000), (14316, 16296, 1000)];

    foreach(var_3 in var_1)
    scripts\cp\vehicles\little_bird_cp::spawn_little_bird_at_location(var_3, (0, 0, 0), "_encstr_9A8507BA4040188D08");
  }
}

onplayerspawned() {}

setup_map_specific_devgui() {}

register_spawn_modules() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\cp\cp_modular_spawning::register_aitype_setup("_encstr_A1940DCC0D590F3747A8BB619053EB", "_encstr_99471BB02E495036E989410D4BC0BCE1124F3053AFB327EACA199B1793", undefined, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_956217D838EB8CBDE6AC479BB5AFD056D8B4BE371C58DD9BB9", 0, 24, undefined, 0.1, undefined, "_encstr_956217D838EB8CBDE6AC479BB5AFD056D8B4BE371C58DD9BB9", scripts\cp\cp_modular_spawning::init_wave_settings);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_92EC1C070331F5B0BE8F538B34A740BDDA8F87AF9B7AC4E0DB695B41DA54", 0, 6, undefined, 0.1, undefined, "_encstr_956217D838EB8CBDE6AC479BB5AFD056D8B4BE371C58DD9BB9");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_956217D838EB8CBDE6AC479BB5AFD056D8B4BE371C58DD9BB9", scripts\cp\cp_modular_spawning::toggle_teleport_enemy_info_loop);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_92EC1C070331F5B0BE8F538B34A740BDDA8F87AF9B7AC4E0DB695B41DA54", scripts\cp\cp_modular_spawning::toggle_teleport_enemy_info_loop);
  scripts\cp\cp_modular_spawning::register_module_as_passive("_encstr_92EC1C070331F5B0BE8F538B34A740BDDA8F87AF9B7AC4E0DB695B41DA54");
  scripts\cp\cp_modular_spawning::register_module_as_passive("_encstr_956217D838EB8CBDE6AC479BB5AFD056D8B4BE371C58DD9BB9");
}

set_vehicle_settings_on_spawners(var_0) {
  var_1 = scripts\cp\cp_modular_spawning::process_module_var(var_0, var_0.spawn_points);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    var_1[var_2] scripts\cp\cp_modular_spawning::initialize_as_veh_spawner();
}

player_exfil_struct() {
  var_0 = getEntArray("_encstr_92FE106AF8010BC5E2D6FA976E239B4BEDDD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")[0];
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (16790, 21198.5, 293));
  var_1.angles = (0, 330, 90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}

_id_13528() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2165.46, 29700.2, 184));
  var_0.angles = (0, 62.6779, 0);
  var_0 setModel("_encstr_BA0B2E972198FA12C6C7CFB3AB6E6B291089C11F59E8B49A10599F1FAF9F729D9850C3A2F1C175E2F963FF9A59A8EADE");
}