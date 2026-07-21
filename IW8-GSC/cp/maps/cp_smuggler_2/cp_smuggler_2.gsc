/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_smuggler_2\cp_smuggler_2.gsc
***************************************************/

main() {
  level.default_player_spawns = "_encstr_9BD00F2356CCB0D5C6E8BEB98358DDCDFA" + level.script;
  tank_west();
  scripts\cp\cp_compass::setupminimap("_encstr_A20E1AB7E7813351B04BC94D2180A7DAE76F0F074B3C0A047873F182");
  _encstr_AD7339B6D62BDB0B74378AF023F76003B37A97366A91B7905D8FC0805FC27E1DAEE62750026A7399379B2848CFBAB6D1238F16C79E922B681F8F10::main();
  _encstr_AFB838C27188711335EFBE7711700AB140DB6D4E8B89139A8DEF9743138651BA12A1779508D0D871E6E3C7770FA13A32E9A361DE1B80DECA3E97::main();
  _encstr_A21733C399CE5FE2A0EF3F7BC1526DC777339E4A83307F9D703F6F4CF3C0B94230A9E3F14BF1BF578801655AEFEA714BC3E82ABBD1::main();
  _encstr_955C3903590E9F22E0AF7F3B81122D07B7F35E8AC3703F5DB0FF2F0CB3937902706923B10B317F17C8C1251A2F2A31A38B811A8BD018FF1DF0E75B::main();
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
  scripts\mp\brclientmatchdata::getpresettruckspawns("_encstr_8C2F157778E06CFFEA03391FFD5F033BE5EFEB40A32D43", _encstr_BEB2384F98CBE18B792E557E97E712B1D370468798C6338283CC4FB575050E7B3BA9BF2718399FDA8B5E596EEBC3020B83C04FA3E8139E92FFFE::_id_11C5B);
  var_0 = getDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101") {
    scripts\mp\brclientmatchdata::getnextprop(var_0);
    scripts\mp\brclientmatchdata::getnextrpgspawnmodule(var_0);
    level thread[[level._id_12B19[var_0]]]();
  } else {
    var_1 = getDvar("_encstr_B89A16B183BE6EDAEAD9B3635693EB9B3A85E447AFF6319A", "_encstr_81D6136CED733BF697D0FADC2BB1AEC9B285932B58");

    if(var_1 == "_encstr_B40101")
      var_1 = "_encstr_81D6136CED733BF697D0FADC2BB1AEC9B285932B58";

    setDvar("_encstr_B89A16B183BE6EDAEAD9B3635693EB9B3A85E447AFF6319A", var_1);

    if(isDefined(var_1))
      level thread rundebugstartobjective(var_1);
  }

  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
  thread incrementalrespawnpunishmax();
}

incrementalrespawnpunishmax() {
  wait 5;
  var_0 = spawn("_encstr_8A941B8BA78B102A492CFE2992076A0890DC4972DD4312852A27C202AB", (0, 0, 0));
  var_0 settransientsoundbank("_encstr_A3631347F0A97B4F0F5BC8F322D70918BA36CB2184", 1);
}

create_level_funcs_tables_and_vars() {
  level.objectivesfunc = ::levelobjectives_init;
  level.map_interaction_func = _encstr_B8B43D9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EBCD6BABD9CEC6ACC97D8C5E3638FA37AD57D9CE36CA39D719EBD2CD3A2B9CB0B147D2ED736E71ECE6B1::register_interactions;
  level.player_interaction_monitor = _encstr_B8B43D9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EBCD6BABD9CEC6ACC97D8C5E3638FA37AD57D9CE36CA39D719EBD2CD3A2B9CB0B147D2ED736E71ECE6B1::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_B8B43D9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EBCD6BABD9CEC6ACC97D8C5E3638FA37AD57D9CE36CA39D719EBD2CD3A2B9CB0B147D2ED736E71ECE6B1::level_specific_wait_for_interaction_triggered;
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_A67441E603AB4889734302988B5D7B817BBB4056887773EB1B2A48E8F22267B3AE5377C0E3077B37C7824093496AAFD3FFF9FF404693A11D2CD948288295A1404F7304";
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
  level.objectives_table = "_encstr_BA6220FBAF701F923718AA2350AF4DDF7380124F48A1739F7738120B78DF958F8BFC";
  level.objectivesmatrixtable = "_encstr_86C024AE9A02EA0FC75A5F98D3155FC3DE4836A2D773E973A03D532159FF988591085AF3F3F8";
  level.objectiveregistration = ::levelregisterobjectives;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

init_global_systems() {
  scripts\vehicle\techo::main("_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382", "_encstr_8DC71569E5A638C00F6B687263378E48BD6ED70BB70E40", "_encstr_84532DB7DF73E3D814B1A3D964E188A9FAC71B370A0935B04D9608968BD5D0D3F25FAFB127E37511602C72EBF4BB98");
  scripts\vehicle\techo::main("_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382", "_encstr_AB560E05670AE9D86FEB60D0DF619117", "_encstr_84532DB7DF73E3D814B1A3D964E188A9FAC71B370A0935B04D9608968BD5D0D3F25FAFB127E37511602C72EBF4BB98");
  scripts\vehicle\mkilo23_ai_infil::main("_encstr_A27620B3B21A077DAD5AC6AF1B3719FADADAA563DB2399AF07A15E37D2B1E6F56B07", "_encstr_83FF0EA067A1481F49AA9B1B42024F13", "_encstr_AD6C2DB9D8274B07E8BED9B24370D7B696B1F5B1B923AFB66DD28D7B19CC7D1C0D2FE6D2C6B97DB05AAFB4CDCC96B1");
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
  level thread scripts\cp\intel\cp_intel::init_intel_pieces("_encstr_8DDF0A6ED65D3B3BB1B22791");
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

tank_west() {
  level.incrementalrespawnpunish = [];
  level.incrementalrespawnpunish[0] = tank_westturret((22523.5, 29032, 1217.38));
  level.incrementalrespawnpunish[1] = tank_westturret((22472, 29032, 1217.38));
  level.incrementalrespawnpunish[2] = tank_westturret((22482, 29096, 1217.38));
  level.incrementalrespawnpunish[3] = tank_westturret((22526, 29096, 1217.38));
}

tank_westturret(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  var_1.angles = (0, 90, 0);
  var_1.targetname = level.default_player_spawns;
  scripts\cp\cp_create_script_utility::initbunkeranims("_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_1.targetname, var_1);
  return var_1;
}