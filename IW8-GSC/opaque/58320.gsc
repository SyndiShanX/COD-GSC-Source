/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58320.gsc
***********************************************/

create_vehicle_interact() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_83F40783ADF1D14AA3", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::create_weapon_pick_up);
  create_vehicle_omnvars_data();
  create_vehicle_occupancy_data();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_83F40783ADF1D14AA3", _calloutmarkerping_handleluinotify_mappingdeletemarker::create_script_wait_for_flags);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_83F40783ADF1D14AA3", "_encstr_99BF1103D0D4179DFB42DB03358B930DBDB7A1", ::create_vault_assault_loadout_selection);
  level.resttimems = scripts\mp\utility\player::getplayersinradius;
  level.little_bird_mg_mp_initspawning = _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::little_bird_mg_mp_initmines;
  level._encstr_95CA1C6BBBD86B70A90FC143F9570A821BE87ECC17E0B0F58F407D4748CE = _encstr_A5E12A9EFE03F3136CDF72683BDF091B1AE79523922A8FB022E3E9F02BA54075E3810D2EAE927BC346DF80E8::little_bird_mg_mp_ondeathrespawncallback;
  level._id_13352 = scripts\mp\hud_message::showerrormessage;
  level._id_11A22 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_11A21;
  level.crossbowusageloop = scripts\mp\rank::giverankxp;
  level.ctgs_recordmatchstats = scripts\mp\rank::scoreeventpopup;
  level.cumulative_damage_monitor = scripts\mp\hud_message::showsplash;
  level.createpropspeclist = scripts\mp\utility\player::unset_relic_trex;
  level.cruisepredator_assigntargetmarkers = scripts\mp\utility\perk::_hasperk;
  level.ctf_bot_attacker_limit_for_team = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag;
  level.cruise_predator_direction_override = scripts\mp\utility\points::sec_sys_struct_1;
  level.createpropspecatehud = _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::get_unique_id;
  level.crossbowbolts = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata;
  level.crossbow = _encstr_86912B6E0EF303C3BC0FC2D86B8F794BAA3765F3227AFFE0921339083715F189035BD068FAD3AB536C4AF038F7::pattern;
  level.critical_messages = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack;
  level.createzombieloadout = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack;
  level.createquestcircle = _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::addtop3brcharge;
  level.cumulative_damage_to_chopper_boss = _encstr_9641241F9B6AB8D73BD33878CB7E04A0C5F569831017A0B09BDB0EA3027F4B189D435527BB7E::chopperexfil_sh050_start;
  level.crossbowimpactwatcher = scripts\mp\utility\teams::getteamdata;
  level.createplayerplundereventdata = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog;
  level.failsafe_triggered = getdvarint("_encstr_8DFB1C2308F5D9838B50999CD1300F117DD04AAA508D818B81AE70897478", 1);
}

create_vehicle_omnvars_data() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_83F40783ADF1D14AA3", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
  var_0.areplayersnear = 60;
  var_1 = getdvarfloat("_encstr_8718159B1BC9F5318EFA4E593783B0EE9BBE2359C60BBC", 100);

  if(var_1 >= 0)
    var_0._id_12CA1 = var_1;
}

create_vehicle_occupancy_data() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_83F40783ADF1D14AA3", 1);
  var_0.frontextents = 165;
  var_0.backextents = 168;
  var_0.leftextents = 57;
  var_0.rightextents = 57;
  var_0.bottomextents = 35;
  var_0.distancetobottom = 50;
  var_0.loscheckoffset = (0, 0, 70);
}

create_weapon_pick_up(var_0, var_1) {
  var_2 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var_0, var_1);
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_83F40783ADF1D14AA3");
  var_4 = isDefined(var_3) && isDefined(var_3._id_12CA1);

  if(isDefined(var_2) && (istrue(level.failsafe_triggered) || var_4))
    var_2.ondeathrespawn = ::create_vehicle_vehicledata;

  return var_2;
}

create_vehicle_vehicledata() {
  thread create_weapon_pick_ups();
}

create_weapon_pick_ups() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_1.ref = var_0.ref;
  var_1.rallypointhealth = var_0.rallypointhealth;
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_83F40783ADF1D14AA3", var_1, var_2);
}

create_vault_assault_loadout_selection(var_0, var_1, var_2, var_3, var_4) {
  var_0 _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::_id_141FF(var_3.team);
}