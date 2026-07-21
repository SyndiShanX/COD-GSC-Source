/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\helicopter\chopper_boss.gsc
***********************************************/

init() {
  level.struct_filter = ::cp_struct_filter;
  scripts\engine\utility::init_struct_class();
  clean_up_structs();
  delete_on_load();
  setdefaultleveldata();
  setdefaultdvars();
  setupcallbacks();
  scripts\cp\utility::initgameflags();
  init_global_cp_flags();
  setupexplodertriggers();
  setdefaultgameparameters();
  setdefaultvisionset();
  setdefaultjiprules();
  loadglobalfx();
  specialentitymonitor();
  initdestructables();
  scripts\cp\scriptable::scriptable_cpglobalcallback();
  scripts\common\exploder::setupexploders();
  shellshock_init();
  inithud();
  initkilltriggerspawn();
  scripts\common\fx::initfx();
  scripts\mp\callbacksetup::setupdamageflags();
  scripts\cp\cp_damagefeedback::init();
  scripts\cp\cp_movers::init();
  scripts\cp\coop_fx::main();
  scripts\cp\cp_merits::buildmeritinfo();
  scripts\cp\cp_endgame::init();
  scripts\cp\cp_laststand::init_laststand();
  scripts\cp\cp_loadout::init();
  thread scripts\cp\cp_equipment::subway_car_move_think();

  if(shouldverifydedicatedconfig())
    level thread verifydedicatedconfiguration();

  level.leanthread = getdvarint("_encstr_AC801F60CA62BF4BDF7E21AD498BD6A94D72B8A8B3BB698377993D8823E7DB4DB3", 0) == 1;
  level.script = tolower(getDvar("_encstr_9570084B1793A090CDFF"));
  level.gametype = tolower(getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB"));
  level.codcasterenabled = getdvarint("_encstr_B4CC0B9A3D9A9CE915A03DA99A", 0) == 1;
  level.systemlink = getdvarint("_encstr_95B00B1305A628A6159AC9282A", 0) == 1;
  level.useperbullethitmarkers = getdvarint("_encstr_BE390BE96A252682A953282562", 0) == 1;
  level.splitscreen = issplitscreen();
  level.onlinegame = getdvarint("_encstr_BE9C0BD1E3C16D64B9DB4989F7");
  level.rankedmatch = level.onlinegame || getdvarint("_encstr_AD460A97B91F0DAE3BDBEF88");
  level.matchmakingmatch = level.onlinegame;
  level.playerxpenabled = level.matchmakingmatch || getdvarint("_encstr_AD460A97B91F0DAE3BDBEF88");
  level.weaponxpenabled = level.playerxpenabled;
  level.challengesallowed = level.matchmakingmatch && !getdvarint("_encstr_93390B136AA2628AA8A93529D4") || getdvarint("_encstr_AD460A97B91F0DAE3BDBEF88") || getdvarint("_encstr_8C27111AF16EB7BF91B710E151F0C7130469E3");
  level.enforceantiboosting = level.playerxpenabled || level.weaponxpenabled || level.challengesallowed;
  level.onlinestatsenabled = level.rankedmatch;
  level._id_12376 = getdvarint("_encstr_9AE40B491778AC81E8C425A0EA", 0);
  level.starttimeutcseconds = getsystemtime();
  level.current_personal_interaction_structs = [];
  level.aud_interior_plane_audio_zones = [];
  level.weapon_drop_cooldown = [];
  level.grenade_drop_cooldown = [];
  level.tacticalmode = 0;
  level.teamnamelist = ["_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08"];
  level.func["_encstr_848A141BAFF834B34DD472CA39A9EBADC823A19ED378"] = ::scriptmodelplayanim;
  level.func["_encstr_B67F0FABE31D3FEEA011AD9D39E9755FB1"] = ::precachempanim;
  level.func["_encstr_9B9B15B307509C0BF57C2AA241C10F1530EB4A09852025"] = ::scriptmodelclearanim;
  level.vehiclefriendlydamage = getdvarint("_encstr_84461AE78F23A8B8750C3049355D7176CAFFA5412B3B9DD885A6F981", 0) > 0;
  scripts\cp\cp_anim::init();
  level.framedurationseconds = level.frameduration / 1000;
  waypoint_init();
  level.mapcenter = findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level thread scripts\cp\cp_visionsets::vision_set_management();
  level thread scripts\cp\init_cp_mp::init();
  level.lastslowprocessframe = 0;
  scripts\cp\utility::gameflaginit("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", 0);
  scripts\cp\utility::gameflaginit("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B", 0);
  scripts\cp\utility::gameflaginit("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B", 0);
  scripts\cp\utility::gameflaginit("_encstr_8C0D0E8410E8B112602F133F559DCAF4", 0);
  level thread scripts\cp\utility\spawn_event_aggregator::init();
  scripts\cp\utility\lui_game_event_aggregator::init();
  level thread scripts\cp\utility\disconnect_event_aggregator::init();
  level thread scripts\cp\utility\player_frame_update_aggregator::init();
  level scripts\cp_mp\utility\game_utility::game_utility_init();
  level thread scripts\cp_mp\utility\shellshock_utility::shellshock_utility_init();
  level thread scripts\cp\cp_destruction::init_destruction();
  level thread scripts\cp\crafting_system::init_craftingsystem(1);
  level thread scripts\cp\cp_munitions::init_munitions();
  level thread scripts\cp\cp_outline_utility::init();
  level thread scripts\cp\inventory\cp_ac130::init();
  level thread scripts\cp\cp_deployablebox::init();
  level thread scripts\cp\drone\scout_drone::init();
  level thread scripts\cp_mp\targetmarkergroups::init();
  level thread scripts\mp\objidpoolmanager::init();
  level thread scripts\mp\playeractions::init();
  thread scripts\cp_mp\xmike109::init();
  level thread trackplayedtime();
  level thread scripts\cp\drone\emp_drone::init();
  thread scripts\mp\mp_agent_damage::init();
  scripts\mp\playeractions::addaction("_encstr_919007AA5148539DA0", scripts\common\utility::allow_mantle);
  level thread scripts\mp\sentientpoolmanager::init();
  level thread scripts\cp\cp_relics::init();
  level thread scripts\cp\cp_player_battlechatter::init();
  level thread scripts\cp_mp\vehicles\vehicle::vehicle_init();
  scripts\cp_mp\entityheadicons::init();
  level thread scripts\cp_mp\killstreaks\init::init();
  level thread scripts\cp_mp\emp_debuff::emp_debuff_init();
  level thread scripts\engine\scriptable_door::system_init();
  thread scripts\cp_mp\gestures::init();
  thread scripts\cp\gestures_cp::init_cp();

  if(!scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    level thread scripts\cp\respawn\cp_respawn::main();
    level.respawn_func = undefined;
  }

  level thread scripts\cp_mp\execution::execution_init();
  level thread watchslowmo();
  scripts\common\utility::allow_add("_encstr_8F0508CE59DCA357392B", scripts\cp\utility\player::allow_gesture);
  scripts\common\utility::allow_add("_encstr_BEF4071AA87BDF5220", scripts\common\utility::allow_supers);
  scripts\common\utility::allow_add("_encstr_A9350D834DDE8871B8C7AD38FF21E2", scripts\cp\utility\player::allow_health_regen);
  scripts\common\utility::allow_add("_encstr_A19315D78019CFB47BA36942A0592FFFB674295325204F", scripts\cp\utility\player::allow_one_hit_melee_victim);
  scripts\common\utility::allow_add("_encstr_8E400866D8589B1AB2C8", scripts\cp\utility\player::allow_flashed);
  scripts\common\utility::allow_add("_encstr_8ED90887F39B73AD5BFF", scripts\cp\utility\player::allow_stunned);
  scripts\common\utility::allow_add("_encstr_83290B682399813F110463F9DD", scripts\cp\utility\player::allow_stick_kill);
  level.livescount = 1;
  scripts\engine\utility::delaythread(60, scripts\cp\laser_traps\cp_laser_traps::little_bird_mg_cp_ondeathrespawncallback);
}

trackplayedtime() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp\utility::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  while(!level.gameended) {
    wait 1.0;

    foreach(var_1 in level.players)
    var_1 trackplayedtimeupdate();
  }
}

trackplayedtimeupdate() {
  if(isDefined(self.timeplayed)) {
    var_0 = self.sessionteam;

    if(!isDefined(self.timeplayed[var_0]))
      self.timeplayed[var_0] = 0;
    else
      self.timeplayed[var_0]++;

    if(var_0 != "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_0 != "_encstr_933E090A10B17DDFB3E522") {
      self.timeplayed["_encstr_BE7D0633C08849E2"]++;
      self.timeplayed["_encstr_93C20CED035F8BA928B8834FE840"]++;

      if(!scripts\cp\utility\player::isreallyalive(self))
        self.timeplayed["_encstr_8E6E097D1C928BB55DB708"]++;
    }
  }
}

cp_struct_filter(var_0) {
  if(!isDefined(level.struct_filter_kvps))
    level.struct_filter_kvps = [];

  switch (var_0.targetname) {
    case "_encstr_A1290F986A27D18BDB7120AA77A373974A":
      return 0;
  }

  level.struct_filter_kvps[var_0.targetname] = var_0.targetname;
  return 1;
}

clean_up_structs() {
  if(isDefined(level.struct_filter_kvps)) {
    var_0 = getarraykeys(level.struct_filter_kvps);

    for(var_1 = 0; var_1 < var_0.size; var_1++) {}

    level.struct_filter_kvps = undefined;
  }

  var_2 = level.struct;
  level.struct = [];

  for(var_1 = 0; var_1 < var_2.size; var_1++) {
    if(isDefined(var_2[var_1]))
      level.struct[level.struct.size] = var_2[var_1];
  }
}

_id_145ED(var_0, var_1, var_2) {
  getentitylessscriptablearray("_encstr_86A122C5ED023F068D3BF0A01B9FD9496912C55843DAE3894F37405867FBF3DF027E3D57", ["_encstr_8119046DAF63", var_0, "_encstr_860D056349D3A3", var_1, "_encstr_A28E061BDE5DB9D1", var_2]);
}

waypoint_init() {
  if(level.splitscreen)
    level.waypoint_size = 15;
  else
    level.waypoint_size = 8;

  level.waypoint_alpha = 0.75;
  level.waypoint_index = 0;
}

findboxcenter(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_2 = var_1 - var_0;
  var_2 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_0;
  return var_2;
}

init_global_cp_flags() {
  scripts\engine\utility::flag_init("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_init("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_init("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\engine\utility::flag_init("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\engine\utility::flag_init("_encstr_97AF17C6CAD9598DEB939585235EF5CC7B397D37D84E9607E8");
  scripts\engine\utility::flag_init("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  level thread _id_130F0();
}

_id_130F0() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait_all("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD", "_encstr_A2D20FE4880D52A426C867576878654BD3", "_encstr_A65211EB562BA098E71253B95ABB589043B525", "_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\engine\utility::flag_set("_encstr_97AF17C6CAD9598DEB939585235EF5CC7B397D37D84E9607E8");
}

setdefaultleveldata() {
  level.splitscreen = issplitscreen();
  level.onlinegame = getdvarint("_encstr_BE9C0BD1E3C16D64B9DB4989F7");
  level.playerxpenabled = level.onlinegame;
  level.rankedmatch = level.onlinegame && !getdvarint("_encstr_93390B136AA2628AA8A93529D4") || getdvarint("_encstr_AD460A97B91F0DAE3BDBEF88");
  level.script = tolower(getDvar("_encstr_9570084B1793A090CDFF"));
  level.mapname = scripts\cp_mp\utility\game_utility::getmapname();
  level.gametype = tolower(getDvar("_encstr_ADE50BEB2F7C519F9918E82B68"));
  level.otherteam["_encstr_9A8507BA4040188D08"] = "_encstr_8E8405EA382B2A";
  level.otherteam["_encstr_8E8405EA382B2A"] = "_encstr_9A8507BA4040188D08";
  level.multiteambased = 0;
  level.teambased = 1;
  level.func = [];
  level.createfx_enabled = getDvar("_encstr_A7A10BE87FB447783F6F314482") != "_encstr_B40101";
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.hardcoremode = 0;
  level.numgametypereservedobjectives = 0;
  level.reclaimedreservedobjectives = [];
  level.date = scripts\cp\utility::get_actual_time_from_civil(8);
  level.default_goalradius = 2048;
  level.path_node_table = "_encstr_BEB41A706BA5B77B07F037B5F0DF6067DF821950128EF191EA0BC6AC";
  init_create_script();
}

setdefaultdvars() {
  setDvar("_encstr_A9E413E3C01707FE01A0B31317DF99C3336B2B2788", 0);
  setDvar("_encstr_82570B397A4D3192935192A562", getdvarint("_encstr_88C210F3A9FEB7D3900B928C51D09ADFA8E0"));
  setDvar("_encstr_BAE50BF142A0C7670673B9A11F", getDvar("_encstr_9A2112B98D39F53B2CB695EB667B938DCABA859D"));
  setDvar("_encstr_976F124B6E350B3AB1A1A92CDA2D37B31DB0DA95", scripts\cp\utility::matchmakinggame());
  setDvar("_encstr_8ADD0CABA5AFEDECB2271D2DB6AC", 0);
  setDvar("_encstr_A744140DDAF1C720F1D777172C20C0A5FFC0163BF76B", 1);
  setDvar("_encstr_8C3C0A99C0159584534AB827", 1);
  setDvar("_encstr_AFBA0B534DA5D25A963DA0B4D4", 5);
  setDvar("_encstr_840310574BFA66E4D2B2DC91C62FCC4B9CCA", 0);
  setDvar("_encstr_A7970BF98DC947BC808359D183", 0);
  setDvar("_encstr_9B550B98A728B4D494395151A6", scripts\engine\utility::ter_op(level.hardcoremode == 1, 0, 1));
  setDvar("_encstr_97E60BFB592484E17DF6B2BD5F", 1);
  setDvar("_encstr_92290B8D3A757F3039B7F3594F", 0);
  setDvar("_encstr_83C8191B42BBC0E8FA0985B917277897ABFA11438AB707C0D41987", 0);
  setDvar("_encstr_A7341BF848750358B597CF3FC543279965B24AEF507891A0884BC32748", 1);
  setDvar("_encstr_87D9124B6393AECFD89C54373A5380FD074A1062", "_encstr_B40101");
  setdvarifuninitialized("_encstr_863D0BE78F23A8907CCDF388F5", "_encstr_B40101");
}

setupcallbacks() {
  level.callbackstartgametype = ::coopstartgametype;
  level.frontend4 = ::blank;
  level.callbackplayerconnect = ::defaultplayerconnect;
  level.callbackplayerdisconnect = ::defaultplayerdisconnect;
  level.callbackplayerdamage = ::defaultplayerdamage;
  level.callbackplayerimpaled = ::callback_agent_impaled;
  level.callbackplayerkilled = ::defaultplayerkilled;
  level.callbackplayermigrated = ::defaultplayermigrated;
  level.callbackhostmigration = ::defaulthostmigration;
  level.getspawnpoint = ::defaultgetspawnpoint;
  level.onspawnplayer = ::blank;
  level.onprecachegametype = ::blank;
  level.onstartgametype = ::blank;
  level.playermaxhealth = ::defaultplayermaxhealth;
  level.playerinitinvulnerability = ::player_init_invulnerability;
  level.spawnplayerfunc = ::spawnplayer;
  level.enterspectatorfunc = ::enterspectator;
  level.intermissionfunc = ::spawnintermission;
  level.getkilltriggerspawnloc = ::getkilltriggerspawnloc;
  level.initagentscriptvariables = scripts\cp\cp_agent_utils::initagentscriptvariables;
  level.setagentteam = scripts\cp\cp_agent_utils::set_agent_team;
  level.agentvalidateattacker = scripts\cp\cp_agent_utils::validateattacker;
  level.agentfunc = scripts\cp\cp_agent_utils::agentfunc;
  level.getfreeagent = scripts\cp\cp_agent_utils::getfreeagent;
  level.addtocharactersarray = scripts\cp\cp_agent_utils::addtocharactersarray;
  level.callbackplayerlaststand = scripts\cp\helicopter\utility::callback_defaultplayerlaststand;
  level.endgame = scripts\cp\cp_endgame::_id_13445;
  level.forceendgame = scripts\cp\cp_endgame::_id_13446;
}

loadglobalfx() {
  level._effect["_encstr_93310B4BF0CB13DF7159EDD341"] = loadfx("_encstr_82CD2D4092E8A791BF7ABD8053A77B8B17BA12C8EA800FAB5782302C402FE3577ED288F9135DBB0127BC459E240708");
}

defaultplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {}

defaultplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

watchslowmo() {
  for(;;) {
    if(getDvar("_encstr_863D0BE78F23A8907CCDF388F5") != "_encstr_B40101") {
      break;
    }

    wait 1;
  }

  var_0 = getdvarfloat("_encstr_863D0BE78F23A8907CCDF388F5");
  setslowmotion(var_0, var_0, 0.0);
  thread watchslowmo();
}

callback_agent_impaled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread impale(var_0, self, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

impale(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(level.harpoon_impale_additional_func))
    [[level.harpoon_impale_additional_func]](var_2, var_0, var_1, var_4, var_5, var_6, var_7, var_8);
  else {
    var_1 startragdoll();
    var_9 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);
    var_10 = var_4 + var_5 * 4096;
    var_11 = scripts\engine\trace::ray_trace_detail(var_4, var_10, undefined, var_9, undefined, 1);
    var_10 = var_11["_encstr_BD260953AA97E3F014279D"] - var_5 * 12;
    var_12 = length(var_10 - var_4);
    var_13 = var_12 / 1250;
    var_13 = clamp(var_13, 0.05, 1);
    wait 0.05;
    var_14 = var_5;
    var_15 = anglestoup(var_0.angles);
    var_16 = vectorcross(var_14, var_15);
    var_17 = scripts\engine\utility::spawn_tag_origin(var_4, axistoangles(var_14, var_16, var_15));
    var_17 moveTo(var_10, var_13);
    var_18 = spawnragdollconstraint(var_1, var_6, var_7, var_8);
    var_18.origin = var_17.origin;
    var_18.angles = var_17.angles;
    var_18 linkTo(var_17);
    thread impale_cleanup(var_1, var_17, var_13 + 0.05, var_18);
  }
}

impale_cleanup(var_0, var_1, var_2, var_3) {
  var_0 scripts\engine\utility::_id_143BA(var_2, "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
  var_3 delete();
  var_1 delete();
}

setupexplodertriggers() {}

specialentitymonitor() {
  level thread trackgrenades();
  level thread trackmissiles();
  level thread trackcarepackages();
}

trackgrenades() {
  for(;;) {
    level.grenades = getEntArray("_encstr_8C8D08671D451291C849", "_encstr_AC110A7F14873B5B3D073009");
    wait 0.05;
  }
}

trackmissiles() {
  for(;;) {
    level.missiles = getEntArray("_encstr_8D8A07F05F6987BF4B", "_encstr_AC110A7F14873B5B3D073009");
    wait 0.05;
  }
}

trackcarepackages() {
  for(;;) {
    level.carepackages = getEntArray("_encstr_BAE50DE60E739BA638C72068AF47B9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    wait 0.05;
  }
}

defaultplayermaxhealth() {
  if(istrue(self.keep_perks)) {
    if(scripts\cp\utility::has_zombie_perk("_encstr_AB671357374BBF8E0DDF4808E756819F53DD4D54CC"))
      return 200;
    else
      return 180;
  } else
    return 180;
}

setdefaultgameparameters() {
  game["_encstr_8E4A0FA5C837EB73F67241705A0A33ED43"] = "_encstr_AD830B4786ACC96B0B8DF55BE0";
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_A3D2091BD84BB29B8EA519"] = 0;
  game["_encstr_A1AD062E09D98338"] = "_encstr_877508C1D8C22F2DDC3B";
  game["_encstr_A16D07532531CB4BF7"] = "_encstr_820E07FAE8780B3A4C";
}

setdefaultvisionset() {
  visionsetnaked("_encstr_B40101", 0);
  visionsetnight("_encstr_9ABC11A97F4E2095F2EBFF95F72A53D0DFD593");
  visionsetmissilecam("_encstr_A3DD0BD6B46EE6D2C6CA6C2CD6");
  visionsetthermal(game["_encstr_8E4A0FA5C837EB73F67241705A0A33ED43"]);
  visionsetpain("_encstr_9B0E08E058D2B9D7B538", 0);
}

setdefaultjiprules() {
  setnojipscore(0, 1);
  setnojiptime(0, 1);
}

defaultgetspawnpoint() {
  return getassignedspawnpoint(scripts\engine\utility::getStructArray("_encstr_977415C0B27F2B43438C503F7C9F0AFBA2B9C0C86A1249", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
}

getassignedspawnpoint(var_0) {
  var_1 = self getentitynumber();
  return var_0[var_1];
}

defaultendgame() {
  level.gameended = 1;
  setomnvar("_encstr_BE51134A8548B7C3DFD8F55DDD85E30EA7D1CB58E8", 0);
  level notify("_encstr_9B1D0BC7932875276230426AA1", "_encstr_9A8507BA4040188D08");
  wait 0.05;
  exitlevel(0);
}

coopstartgametype() {
  [[level.onprecachegametype]]();
  level thread monitor_num_players();
  resetlevelflags();
  resetlevelarrays();

  if(isDefined(level.scripted_spawner_func)) {
    level.cs_creation_counter = 0;

    if(isarray(level.scripted_spawner_func)) {
      foreach(var_2, var_1 in level.scripted_spawner_func)[[var_1]](1, "_encstr_8A0703D983" + var_2);
    } else if(istrue(level.threadedscriptspawners))
      [[level.scripted_spawner_func]](1);
    else
      [[level.scripted_spawner_func]]();
  }

  scripts\cp\cp_analytics::_id_119B9();
  scripts\cp\perks\cp_perks::initperks();
  scripts\cp\cp_weaponrank::init();
  thread scripts\cp\cp_powers::init();
  scripts\cp\cp_merits::init();
  level thread runprematch();
  level thread graceperiodmonitor();
  scripts\cp\cp_aiparachute::strict_ff_enable();
  sysprint("_encstr_978F12092BEB3FC719247F7AEF9D578531C88393");
  level thread startgame();
  level thread scripts\mp\mp_agent::init_spawn_times();
  level thread scripts\cp\cp_mapselect::init();

  if(!istrue(level.dev_build)) {
    scripts\cp\utility::add_demo_button_combo(["_encstr_82E0094310C338C39B5EE9", "_encstr_9A2414E6BB1607EBDDAC161CB7DCBEC9CAD8560B6E2B"], ::demo_toggle_infiniteammo, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["_encstr_82E0094310C338C39B5EE9", "_encstr_AFCB0C5B83DFB3A1C04BE9E047D0", "_encstr_9A2414E6BB1607EBDDAC161CB7DCBEC9CAD8560B6E2B"], ::demo_toggle_infiniteammo, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["_encstr_82E0094310C338C39B5EE9", "_encstr_977A0F7B5BE605AAA5579048B8B9A77637"], ::demo_toggle_ufo, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["_encstr_82E0094310C338C39B5EE9", "_encstr_A96D079BEB99884E52", "_encstr_977A0F7B5BE605AAA5579048B8B9A77637"], ::demo_toggle_ufo, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["_encstr_82E0094310C338C39B5EE9", "_encstr_BE750C2313502753DDB1F7DFB7F5"], ::demo_toggle_godmode, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["_encstr_82E0094310C338C39B5EE9", "_encstr_AB19049D0FC0", "_encstr_BE750C2313502753DDB1F7DFB7F5"], ::demo_toggle_godmode, undefined, 1);
  } else
    scripts\cp\utility::add_demo_button_combo(["_encstr_AD1904291F7B", "_encstr_AB19049D0FC0", "_encstr_994C0238", "_encstr_BE750C2313502753DDB1F7DFB7F5", "_encstr_95BA0A14EB93CAC6AC8537AC"], scripts\cp\cp_modular_spawning::print_active_modules_to_screen, "_encstr_AA0B146A347BDD40A01B8E96679580A9F6325D362BB9", 2);

  game["_encstr_A9310C0449DDA97F583FADB0FD01"] = 1;
  level thread wait_for_strike_init_complete();
  scripts\cp\cp_agent_damage::register_ai_damage_callbacks();
  scripts\cp\cp_agent_damage::register_ai_drop_funcs();
}

init_create_script() {
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
}

wait_for_strike_init_complete() {
  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
}

resetlevelflags() {
  level.fauxvehiclecount = 0;
  level.gameended = 0;
  level.graceperiod = 10;
  level.ingraceperiod = level.graceperiod;
  level.noragdollents = getEntArray("_encstr_9AE40A58975A09EF5ACD3931", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.friendlyfire = 0;
  level.starttime = gettime();
  level.autoassignlowteamconsistent = -1;
}

resetlevelarrays() {
  level.players = [];
  level.participants = [];
  level.characters = [];
  level.helis = [];
  level.turrets = [];
  level.ims = [];
  level.ugvs = [];
  level.balldrones = [];
  level.fake_players = [];
  level.demo_button_combos = [];
  thread scripts\common\utility::allow_init();
}

runprematch() {
  level notify("_encstr_B88B0F1982CF57917A1293EF25669096BB");
  level endon("_encstr_B88B0F1982CF57917A1293EF25669096BB");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  setomnvar("_encstr_A1431305E44959FBD51FA8381FE0969132CAF3803F", 1);

  if(isDefined(level.prematchfunc))
    [[level.prematchfunc]]();

  scripts\cp\utility::gameflagset("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  setomnvar("_encstr_A1431305E44959FBD51FA8381FE0969132CAF3803F", 0);
}

graceperiodmonitor() {
  level notify("_encstr_855C128DBDBDE0EBD9C9166CB27DE0B2272DDBC8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_855C128DBDBDE0EBD9C9166CB27DE0B2272DDBC8");

  while(getactiveclientcount() == 0)
    wait 0.05;

  while(level.ingraceperiod > 0) {
    wait 1.0;
    level.ingraceperiod--;
  }

  level.ingraceperiod = 0;
}

startgame() {
  [[level.onstartgametype]]();
}

shouldverifydedicatedconfig() {
  return getDvar("_encstr_962E0A23568CD236C2E85946") == "_encstr_993D154A20C15C8FD1CD958CCF5CCF2DF138C2A3C0ABD2" || getDvar("_encstr_962E0A23568CD236C2E85946") == "_encstr_A3751A4656234B362C3ACA23089673D1CA4EB9CA4710CDCA4E675627";
}

verifydedicatedconfiguration() {
  for(;;) {
    if(level.rankedmatch)
      exitlevel(0);

    if(!getdvarint("_encstr_93390B136AA2628AA8A93529D4"))
      exitlevel(0);

    if(getDvar("_encstr_962E0A23568CD236C2E85946") != "_encstr_993D154A20C15C8FD1CD958CCF5CCF2DF138C2A3C0ABD2" && getDvar("_encstr_962E0A23568CD236C2E85946") != "_encstr_A3751A4656234B362C3ACA23089673D1CA4EB9CA4710CDCA4E675627")
      exitlevel(0);

    wait 5;
  }
}

refreshuimatchinprogressomnvarvalue() {
  var_0 = 0;

  if(level.players.size > 1)
    var_0 = 1;

  foreach(var_2 in level.players)
  var_2 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", var_0);
}

defaultplayerconnect() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.statusicon = "_encstr_8BD81654E368177305FBE3FFC7B83A6F80288F1E3BE8FE0A";
  self waittill("_encstr_845E066177577837");
  self.statusicon = "_encstr_B40101";
  var_0 = gettime();
  level notify("_encstr_AA940A6CB7DC9B2B6C3ACA91", self);
  initplayersessionstats();
  setplayerconnectscriptfields();
  initclientdvars();
  setupsavedactionslots();
  initplayerperks();
  initlaststand();
  scripts\cp\cp_armor::armorinit(self);
  scripts\cp\perks\cp_prestige::initplayerprestige();
  scripts\cp\perks\cp_perks::init_each_perk();
  scripts\cp\cp_damage::initplayerdamagefunctions();
  self.no_team_outlines = 0;
  self.no_outline = 0;
  self.enemy_list = [];

  if(scripts\cp\utility::coop_mode_has("_encstr_8D360838D3CB51A8EEEF"))
    thread scripts\cp\cp_outline::playeroutlinemonitor();

  thread demo_allowed_debug_outline();
  thread scripts\cp\cp_vo::initandstartvosystem();
  thread scripts\cp\cp_merits::updatemerits();
  thread track_forward_velocity();
  self setclientomnvar("_encstr_8CF415303FC7FB577A1ACD46B572BDC11FABB038978A71", 0);

  if(self ishost())
    level.player = self;

  waittillframeend;
  addplayertolevelarrays(self);

  if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060") {
    self.connectedpostgame = 1;
    self setclientdvars("_encstr_B61F197138F9AD4D2940EFBF3FCE2B31CC35C64D1BB0B6E19F5757", 0);
    spawnintermission();
    return;
  }

  if(isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_B672066D30FF90B7"]))
    self thread[[level.bot_funcs["_encstr_B672066D30FF90B7"]]]();

  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.hostmigrationtimer))
    thread scripts\cp\cp_hostmigration::hostmigrationtimerthink();

  if(isDefined(level.onplayerconnectaudioinit))
    [[level.onplayerconnectaudioinit]]();

  if(!isai(self))
    playermonitor();

  if(getdvarint("_encstr_9A9517DA69905FFBC1330F33137683E7C0331524E31027D2A6", 0))
    thread give_playtest_munitions();

  spawnplayer();
}

demo_allowed_debug_outline() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread demo_debug_outline_button_watcher();

  for(;;) {
    self waittill("_encstr_8FEF136CA8B5CF395CE34B9DCF4FAAFB4858F4A6B7");

    if(getdvarint("_encstr_B4CE0FE68D93BE8C56DABDAF23594CAECE", 0)) {
      if(isDefined(level.debug_outline)) {
        setDvar("_encstr_A105199B369CF56E34DEBBAF8EB2B1B21C7B4E3AFA39ACB0CDF6CD", 0);
        level.debug_outline = undefined;
        scripts\cp\cp_outline::unset_outline();
        scripts\cp\cp_outline::restore_outline_settings();
        announcement("_encstr_ABEB1C4469C56B2731B9086FAD83B3AC35F0CEF9AB7D1DE7D1577F7ECCC1");
        iprintln("_encstr_ABEB1C4469C56B2731B9086FAD83B3AC35F0CEF9AB7D1DE7D1577F7ECCC1");
      } else {
        setDvar("_encstr_A105199B369CF56E34DEBBAF8EB2B1B21C7B4E3AFA39ACB0CDF6CD", 1);
        level.debug_outline = 1;
        scripts\cp\cp_outline::save_outline_settings();
        demo_debug_outline_settings();
        level thread scripts\cp\cp_outline::set_outline("_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246");
        announcement("_encstr_87851B7908CECB8DEA5D67D8FD43107B2D92D241A39AC581D378C8B081");
        iprintln("_encstr_87851B7908CECB8DEA5D67D8FD43107B2D92D241A39AC581D378C8B081");
      }

      wait 0.1;
      continue;
    }

    wait 1;
  }
}

demo_toggle_godmode() {}

demo_toggle_ufo() {}

demo_toggle_infiniteammo() {
  var_0 = getdvarint("_encstr_838313CA58D8A99AFE7F77674FA582E108450515D0", 0);

  if(var_0 == 0) {
    announcement("_encstr_96491383D064383D506B0F7023C0812F8AADD870DB");
    var_0 = 1;
  } else {
    announcement("_encstr_A22414CC50A8F1723B6117FAF3D18A3F42902EC5C9C0");
    var_0 = 0;
  }

  setDvar("_encstr_838313CA58D8A99AFE7F77674FA582E108450515D0", var_0);
}

laststand_damage_shield() {
  var_0 = getaiarray("_encstr_8E8405EA382B2A");

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] kill(level.players[0].origin, level.players[0]);
}

demo_debug_outline_button_watcher() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notifyonplayercommand("_encstr_A57F06EFC39D4BF4", "_encstr_84380E9DF9C8A45A701D770377A596B9");
  self notifyonplayercommand("_encstr_A1EF075857A35065F2", "_encstr_B6380E5A0B1B1DD2B737371BDE1D04C8");
  self notifyonplayercommand("_encstr_847206E88696E4C8", "_encstr_97410B23BD6B976233901AF2F8");

  for(;;) {
    var_0 = scripts\engine\utility::_id_143BF(2, "_encstr_A57F06EFC39D4BF4");

    if(var_0 == "_encstr_995408F398012F656821") {
      continue;
    }
    var_0 = scripts\engine\utility::_id_143BF(2, "_encstr_A1EF075857A35065F2");

    if(var_0 == "_encstr_995408F398012F656821") {
      continue;
    }
    var_0 = scripts\engine\utility::_id_143BF(2, "_encstr_A57F06EFC39D4BF4");

    if(var_0 == "_encstr_995408F398012F656821") {
      continue;
    }
    var_0 = scripts\engine\utility::_id_143BF(2, "_encstr_A1EF075857A35065F2");

    if(var_0 == "_encstr_995408F398012F656821") {
      continue;
    }
    var_0 = scripts\engine\utility::_id_143BF(2, "_encstr_847206E88696E4C8");

    if(var_0 == "_encstr_995408F398012F656821") {
      continue;
    }
    self notify("_encstr_8FEF136CA8B5CF395CE34B9DCF4FAAFB4858F4A6B7");
    waitframe();
  }
}

demo_debug_outline_settings() {
  setDvar("_encstr_845C0BA4BA7DB11EC873D3C763", "_encstr_97EA0BB89A40714D10176A8089");
  setDvar("_encstr_8CE50B39519E6AD29A45A5A8A8", "_encstr_9B860926084C4013088B46");
  setDvar("_encstr_A7170B6BC99C1798FB4D7D6559", "_encstr_8D230C071117D2532275020D01C2");
  setDvar("_encstr_85630B8D92BA65507A8DEF74F7", "_encstr_BDF80B06BC219AD359627F0672");
  setDvar("_encstr_9A280B9872E4F46A5469251528", "_encstr_AF2408B23E320143CA61");
  setDvar("_encstr_BDB00A2596358A7A2D54C95A", 1);
}

track_forward_velocity() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self.velo_array = [];
  self.average_velo = (0, 0, 0);
  self.mag_array = [];
  self.average_mag = 0;
  self.velo_forward = self.origin;

  for(;;) {
    var_0 = self getvelocity();
    var_1 = [];
    var_2 = [1024 * min(length(var_0) / 240, 1)];

    if(var_0 != (0, 0, 0))
      var_1[var_1.size] = var_0;

    var_3 = int(min(19, self.velo_array.size));
    var_4 = var_2[0];

    for(var_5 = 0; var_5 < var_3; var_5++) {
      var_1[var_1.size] = self.velo_array[var_5];
      var_2[var_2.size] = self.mag_array[var_5];
      var_4 = var_4 + self.mag_array[var_5];
    }

    self.velo_array = var_1;
    self.mag_array = var_2;
    self.average_mag = var_4 / self.mag_array.size;

    if(self.velo_array.size > 0)
      self.average_velo = calculate_average_velocity(self.velo_array);

    var_6 = self getEye();
    self.velo_forward = self.origin + vectorNormalize(self.average_velo) * self.average_mag;
    wait 0.25;
  }
}

calculate_average_velocity(var_0) {
  if(var_0.size == 1)
    return var_0[0];

  var_1 = var_0[0];

  for(var_2 = 1; var_2 < var_0.size; var_2++)
    var_1 = var_1 + var_0[var_2];

  return var_1 / var_0.size;
}

give_playtest_munitions() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 2;
  self.munition_splash_supress = 1;

  if(allow_munitions(self)) {
    scripts\cp\cp_munitions::give_munition_to_slot("_encstr_A3990BDBEF05B561FA5A488BD8", 1);
    scripts\cp\cp_munitions::give_munition_to_slot("_encstr_A7B606DA83796F4A", 2);
    scripts\cp\cp_munitions::give_munition_to_slot("_encstr_B4F80E295AADB87F924F5F2F3BEA3D38", 3);
  }

  self.munition_splash_supress = undefined;
}

allow_munitions(var_0) {
  if(isDefined(level.allow_munitions))
    return [[level.allow_munitions]](var_0);

  return 1;
}

playermonitor() {
  thread slidemonitor();
  thread forceendmonitor();
  setup_button_notifys();
  thread scripts\cp\cp_munitions::givemunitionfromluinotify();
  thread player_role_monitor(self);
  thread scripts\cp\cp_loadout::change_loadout_watcher(self);
}

setplayerconnectscriptfields() {
  self.guid = scripts\cp\utility::getuniqueid();
  self.clientid = game["_encstr_A3D2091BD84BB29B8EA519"];
  game["_encstr_A3D2091BD84BB29B8EA519"]++;
  self.usingonlinedataoffline = self isusingonlinedataoffline();
  self.connected = 1;
  self.waitingtospawn = 0;
  self.movespeedscaler = 1;
  self.objectivescaler = 1;
  self.inlaststand = 0;
}

initclientdvars() {
  initclientdvarssplitscreenspecific();
  self setclientdvars("_encstr_B61F197138F9AD4D2940EFBF3FCE2B31CC35C64D1BB0B6E19F5757", 1, "_encstr_925F0A2169ABFA674F39485B", 0, "_encstr_8BCD0A61486DA76C4F44BF36", 1, "_encstr_AF040B29631B07D5B0AA918872", 1, "_encstr_AA660B9B0924E1812F96149A71", 0, "_encstr_9B6B0C8B6B6949BD435E5FAD85A2", 0);

  if(level.teambased)
    self setclientdvar("_encstr_A3D20B62A25A2854A94194A839", 0);
}

initclientdvarssplitscreenspecific() {
  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars("_encstr_A11E0A5D8FF1E1519E04D72C", "_encstr_99F90506E2DC4D");
    setDvar("_encstr_87642439EBD60BE8B2934B85B190B1DEDBB6212A356C39A5E0D19AB06E47AC4E51372CC4D8AC", 0);
  } else
    self setclientdvars("_encstr_A11E0A5D8FF1E1519E04D72C", "_encstr_A34C02BB");
}

setupsavedactionslots() {
  self.saved_actionslotdata = [];

  for(var_0 = 1; var_0 <= 4; var_0++) {
    self.saved_actionslotdata[var_0] = spawnStruct();
    self.saved_actionslotdata[var_0].type = "_encstr_B40101";
    self.saved_actionslotdata[var_0].item = undefined;
  }

  if(!self isconsoleplayer()) {
    for(var_0 = 5; var_0 <= 8; var_0++) {
      self.saved_actionslotdata[var_0] = spawnStruct();
      self.saved_actionslotdata[var_0].type = "_encstr_B40101";
      self.saved_actionslotdata[var_0].item = undefined;
    }
  }
}

initplayerperks() {
  self.perks = [];
  self.perksperkname = [];
}

slidemonitor() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_850E1357739303C8B411A358848CD8502A8FE7EBF3");
    self playFX(level._effect["_encstr_93310B4BF0CB13DF7159EDD341"], self getEye());
  }
}

forceendmonitor() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    if(var_0 == "_encstr_AF760B093E992BEAB7A90FEC4E")
      self notify("_encstr_82EE0F816D2233A3C06BCD7214775D361D");

    if(var_0 == "_encstr_A3AF090768A9910F4118EF")
      exitlevel(0);
  }
}

setup_button_notifys() {
  self setactionslot(1, "_encstr_B40101");
  self setactionslot(2, "_encstr_B40101");
  self setactionslot(3, "_encstr_B40101");
  self setactionslot(4, "_encstr_B40101");
  self notifyonplayercommand("_encstr_86660911BEE01619EB570E", "_encstr_AF5C0E59B08DA32D7B7337D8ED3A1098");
  self notifyonplayercommand("_encstr_84E20B08A677D74FA1A90707A5", "_encstr_9A5C0E7471AFC0EA624018717863626F");
  self notifyonplayercommand("_encstr_A9240B51CE3B1FE937E811DBC4", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  self notifyonplayercommand("_encstr_8F460C703189219948CA530F34DD", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");
}

spawnintermission(var_0) {
  setglobalintermissionspawninfo();
  var_1 = self.forcespawnangles;
  spawnplayer();
  self setclientdvar("_encstr_A3D20B62A25A2854A94194A839", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer())
    self setclientdvar("_encstr_B14A0A4545A9412AC9133D26", "_encstr_810703AF78");

  scripts\cp\utility::updatesessionstate("_encstr_A3BC0D2DB544180EEAE7AFB7FF9258");
}

setglobalintermissionspawninfo() {
  var_0 = getglobalintermissionpoint();
  setforcespawninfo(var_0.origin, var_0.angles);
}

setforcespawninfo(var_0, var_1) {
  self.forcespawnorigin = var_0;
  self.forcespawnangles = var_1;
}

getglobalintermissionpoint() {
  var_0 = getEntArray("_encstr_B4D317B607EBB336DE4C0B63FAA5CDD12BE4DA4BDC6E2DBD37", "_encstr_AC110A7F14873B5B3D073009");
  return var_0[0];
}

spawnplayer(var_0) {
  thread spawnplayer_internal(var_0);
}

spawnplayer_internal(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_9BA115577927E3FE09082628C1F007DA08D9B7DBDD5F1A");
  self endon("_encstr_9BA115577927E3FE09082628C1F007DA08D9B7DBDD5F1A");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");

  if(self.waitingtospawn) {
    return;
  }
  waitforspawn();
  spawnplayer_actual(var_0);
}

waitforspawn() {
  self.waitingtospawn = 1;

  if(scripts\cp\utility::isusingremote())
    self waittill("_encstr_A5D2156EE8DEE0C15646F5EACD96E6D9FA9359B5DED1CA");

  self.waitingtospawn = 0;
}

clearmatchhasmorethan1playervariablesonroundend() {
  game["_encstr_B1081C0D2D4399CC8960277358A5B702174B1747168B1238F0984F67A819"] = 0;
  game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"] = 0;
}

updatematchhasmorethan1playeromnvaronplayersfirstspawn() {
  if(!isDefined(game["_encstr_B1081C0D2D4399CC8960277358A5B702174B1747168B1238F0984F67A819"]))
    clearmatchhasmorethan1playervariablesonroundend();

  var_0 = game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"];
  game["_encstr_B1081C0D2D4399CC8960277358A5B702174B1747168B1238F0984F67A819"]++;

  if(!game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"]) {
    if(game["_encstr_B1081C0D2D4399CC8960277358A5B702174B1747168B1238F0984F67A819"] > 1)
      game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"] = 1;
  }

  if(game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"]) {
    if(!var_0) {
      for(var_1 = 0; var_1 < level.players.size; var_1++)
        level.players[var_1] setclientomnvar("_encstr_8EA81DE3592B281B57A2317BF9B74078878F2961C11581FF2F3BA821634F86", 1);
    } else
      self setclientomnvar("_encstr_8EA81DE3592B281B57A2317BF9B74078878F2961C11581FF2F3BA821634F86", 1);
  }

  self._id_11B20 = 1;
}

updatematchhasmorethan1playeromnvaronplayerdisconnect() {
  if(istrue(self._id_11B20)) {
    var_0 = game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"];
    game["_encstr_B1081C0D2D4399CC8960277358A5B702174B1747168B1238F0984F67A819"]--;

    if(game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"]) {
      if(game["_encstr_B1081C0D2D4399CC8960277358A5B702174B1747168B1238F0984F67A819"] <= 1)
        game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"] = 0;
    }

    if(!game["_encstr_B61518E9061B9F5818CFD8518F5AB1B982AED04FD27263A21DAB"]) {
      if(var_0) {
        for(var_1 = 0; var_1 < level.players.size; var_1++)
          level.players[var_1] setclientomnvar("_encstr_8EA81DE3592B281B57A2317BF9B74078878F2961C11581FF2F3BA821634F86", 0);
      }
    }

    self._id_11B20 = 0;
  }
}

spawnplayer_actual(var_0) {
  self notify("_encstr_BA350853C128FB939DB9");
  self notify("_encstr_8716143EFC0FC379CFDA5930B3E62718A39C4FB345FB");

  if(istrue(var_0)) {
    if(level.gameended)
      self spawn(getspawnorigin(self, 1), getspawnangles(self));
    else {
      self.forcespawnangles = level.br_ac130.angles;
      self spawn(getspawnorigin(self, level.br_ac130.origin), getspawnangles(self));
      self playerhide();
      self.bspawningviaac130 = 1;
      var_0 = undefined;
    }
  } else if(level.gameended)
    self spawn(getspawnorigin(self, 1), getspawnangles(self));
  else
    self spawn(getspawnorigin(self), getspawnangles(self));

  resetplayerspawneffects();
  resetplayerspawnscriptfields();
  resetplayerdamagemodifiers();
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 0);

  if(!var_0)
    nonfauxspawnsetup();

  if(isai(self))
    spawnaihandler(var_0);

  [[level.onspawnplayer]](var_0);

  if(istrue(self.bspawningviaac130)) {} else if(!scripts\cp\cp_endgame::gamealreadyended() && !istrue(var_0)) {}

  if(!var_0)
    scripts\cp\cp_visionsets::create_visionset_stack(self);

  if(var_0)
    self[[level.custom_giveloadout]](var_0);

  if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    scripts\cp\utility::setthirdpersondof(1);

  scripts\cp\utility::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");
  self painvisionon();
  waittillframeend;

  if(var_0) {
    self playerhide();
    scripts\cp\utility::allow_player_ignore_me(1);
  }

  if(!istrue(self._id_11B20))
    updatematchhasmorethan1playeromnvaronplayersfirstspawn();

  self notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  level notify("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", self);
  thread hudbooted();
  thread watch_target_health();
  thread allow_dvar_infammo();

  if(!scripts\cp\pvpe\pvpe::pvpe_enabled() || !istrue(level.dogtag_revive)) {
    if(!var_0)
      thread respawn_on();
  }

  thread scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_monitorplayerusability(self);
  thread abilityleft::claymore_crate_update_hint_logic_alt(self);

  if(scripts\cp\utility::turn_off_sniper_laser())
    self.disable_super = 1;

  self.no_outline = 0;
  self.no_team_outlines = 0;
  scripts\cp\utility::_unsetperk("_encstr_B6E812E233105BA29FF1F3FFAFBEFB89D8F99DEF");
  scripts\cp\utility::_unsetperk("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532");
  scripts\cp\utility::_unsetperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");
  scripts\cp\utility::_unsetperk("_encstr_8D08176EC1956C2D16D83ABCFAA1ACB09347982759B0B5959C");
}

respawn_on() {
  if(!isDefined(self.respawn_active)) {
    self.respawn_active = 1;
    self setclientomnvar("_encstr_92E018562B474B455F2D4E9315DA8B971B039F943B70B8D13953", 1);
    thread scripts\cp\respawn\cp_respawn::getcpcratedropcaststart();
  }
}

override_nvg_with_extraction_on_dpad() {}

hudbooted() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  resetplayerspawnomnvar();
}

open_loadout_menu() {
  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    self waittill("_encstr_93E5126FC75143212990F29AA823A3CF0825E60D");
    self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 2);
  }
}

resetplayerspawnomnvar() {
  self setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 0);
  self setclientomnvar("_encstr_AC190F7BF95918351B5BD903E2277BE82F", 1);
  self setclientomnvar("_encstr_9AC91A9DA0B0ED0F26508869412782400BA0585DFED7FBFF239685FC", 0);
  self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 0);
  scripts\cp\utility::init_vehicle_omnvars();
}

resetplayerspawneffects() {
  self stopshellshock();
  self stoprumble("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
  self setdepthoffield(0, 0, 512, 512, 4, 0);

  if(self isconsoleplayer())
    self setclientdvar("_encstr_B14A0A4545A9412AC9133D26", "_encstr_B40703B3C3");
}

resetplayerdamagemodifiers() {
  if(isDefined(self.additivedamagemodifiers)) {
    var_0 = getarraykeys(self.additivedamagemodifiers);

    foreach(var_2 in var_0)
    scripts\cp\utility::removedamagemodifier(var_2, 1);
  }

  if(isDefined(self.multiplicativedamagemodifiers)) {
    var_0 = getarraykeys(self.multiplicativedamagemodifiers);

    foreach(var_2 in var_0)
    scripts\cp\utility::removedamagemodifier(var_2, 0);
  }
}

resetplayerspawnscriptfields() {
  var_0 = getspawnteamassignment();
  self.team = var_0;
  self.sessionteam = getspawnsessionteamassignment(var_0);
  self.pers["_encstr_8AEF05472BC2D6"] = var_0;
  self.fauxdead = undefined;
  self.movespeedscaler = 1;
  scripts\common\input_allow::clear_allow_info("_encstr_AC20072B9FA9487832");
  scripts\common\input_allow::clear_allow_info("_encstr_A3760DF666334316CD32AE2B58079B");
  self.hasriotshieldequipped = 0;
  self.hasriotshield = 0;
}

getspawnsessionteamassignment(var_0) {
  if(isDefined(level.playerspawnsessionteamassignmentfunc))
    return [[level.playerspawnsessionteamassignmentfunc]](self, var_0);

  return var_0;
}

getspawnteamassignment() {
  if(isDefined(level.playerspawnteamassignmentfunc))
    return [[level.playerspawnteamassignmentfunc]](self);

  return "_encstr_9A8507BA4040188D08";
}

nonfauxspawnsetup() {
  resetnonfauxspawnscriptfields();
  scripts\cp\utility::updatesessionstate("_encstr_877508C1D8C22F2DDC3B");
}

resetnonfauxspawnscriptfields() {
  self.maxhealth = self[[level.playermaxhealth]]();
  self.health = self.maxhealth;
  self.avoidkillstreakonspawntimer = 5.0;
  self.friendlydamage = undefined;
  self.hasspawned = 1;
  self.spawntime = gettime();
  self.objectivescaler = 1;
}

spawnaihandler(var_0) {
  if(!var_0) {
    if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23"]))
      self[[level.bot_funcs["_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23"]]]();
  }
}

getspawnorigin(var_0, var_1) {
  var_2 = undefined;
  var_3 = istrue(level.skip_nav_check_on_spectate_respawn);

  if(!var_3 && isDefined(var_0.forcespawnorigin)) {
    var_2 = var_0.forcespawnorigin;
    var_2 = getclosestpointonnavmesh(var_2);

    if(isDefined(var_1))
      var_2 = var_0.forcespawnorigin;

    var_0.forcespawnorigin = undefined;
  } else {
    var_4 = var_0[[level.getspawnpoint]]();
    var_2 = scripts\engine\utility::ter_op(istrue(level.disable_start_spawn_on_navmesh), scripts\engine\utility::drop_to_ground(var_4.origin, 32, -100), getclosestpointonnavmesh(var_4.origin));

    if(isDefined(var_1))
      var_2 = var_4;
  }

  return var_2;
}

getspawnangles(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.forcespawnangles)) {
    var_1 = var_0.forcespawnangles;
    var_0.forcespawnangles = undefined;
  } else {
    var_2 = var_0[[level.getspawnpoint]]();
    var_1 = scripts\engine\utility::ter_op(isDefined(var_2.angles), var_2.angles, (0, 0, 0));
  }

  return var_1;
}

shouldfreezeplayercontrolatspawn() {
  if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060")
    return 1;

  return 0;
}

enterspectator() {
  var_0 = getglobalintermissionpoint();
  self setspectatedefaults(var_0.origin, var_0.angles);
  setforcespawninfo(var_0.origin, var_0.angles);
  setspectaterules();
  scripts\cp\utility::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
}

setspectaterules() {
  if(isDefined(level.spectaterulesfunc))
    [[level.spectaterulesfunc]](self);
  else
    defaultspectaterules(self);
}

defaultspectaterules(var_0) {
  var_0 allowspectateteam("_encstr_9A8507BA4040188D08", 1);
  var_0 allowspectateteam("_encstr_8E8405EA382B2A", 1);
  var_0 allowspectateteam("_encstr_818709A35AE71A38D792CF", 0);
  var_0 allowspectateteam("_encstr_8BBA05185F8B99", 1);
}

defaultplayerdisconnect(var_0) {
  if(!isDefined(self.connected)) {
    return;
  }
  scripts\cp\cp_analytics::on_player_disconnect(var_0);
  removeplayerfromlevelarrays(self);

  if(disconnectshouldforceend())
    level thread[[level.forceendgame]]();

  if(isDefined(level.onplayerdisconnect))
    level thread[[level.onplayerdisconnect]](self, var_0);

  updatematchhasmorethan1playeromnvaronplayerdisconnect();
}

disconnectshouldforceend() {
  if(level.splitscreen)
    return level.players.size <= 1;

  var_0 = 0;

  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2))
      var_0 = scripts\cp\cp_laststand::gameshouldend(var_2);
  }

  return var_0;
}

addplayertolevelarrays(var_0) {
  level.players[level.players.size] = var_0;
  level.participants[level.participants.size] = var_0;
  level.characters[level.characters.size] = var_0;
}

removeplayerfromlevelarrays(var_0) {
  level.players = scripts\engine\utility::array_remove(level.players, var_0);
  level.participants = scripts\engine\utility::array_remove(level.participants, var_0);
  level.characters = scripts\engine\utility::array_remove(level.characters, var_0);
}

defaultplayermigrated() {
  if(self ishost())
    initclientdvarssplitscreenspecific();

  if(ishumanplayer(self)) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(ishumanplayer(var_2))
        var_0++;
    }

    level.hostmigrationreturnedplayercount++;

    if(level.hostmigrationreturnedplayercount >= var_0 * 2 / 3)
      level notify("_encstr_8E3E1C86DEDCA35BB4CEE4B0E8A5EDB9F595B97B5D760D1C1BB0BC959CB9");
  }
}

ishumanplayer(var_0) {
  return !isbot(var_0) && !initmaxspeedforpathlengthtable(var_0);
}

defaulthostmigration() {
  if(level.gameended) {
    return;
  }
  level.hostmigrationreturnedplayercount = 0;

  foreach(var_1 in level.characters)
  var_1.hostmigrationcontrolsfrozen = 0;

  level.hostmigrationtimer = 1;
  setDvar("_encstr_A9E413E3C01707FE01A0B31317DF99C3336B2B2788", 1);
  level notify("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");

  foreach(var_1 in level.characters) {
    if(isDefined(var_1))
      var_1 thread scripts\cp\cp_hostmigration::hostmigrationtimerthink();

    if(isPlayer(var_1))
      var_1 setclientomnvar("_encstr_8BCB112DF3390A3B3A66FB3F820F10911F73FD", var_1.sessionstate);
  }

  setDvar("_encstr_B14D0ED596AF9DB0AD597DB9A3C21D95", game["_encstr_A1AD062E09D98338"]);
  level endon("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  scripts\cp\cp_hostmigration::hostmigrationwait();
  level.hostmigrationtimer = undefined;
  setDvar("_encstr_A9E413E3C01707FE01A0B31317DF99C3336B2B2788", 0);

  if(isDefined(level.hostmigrationend))
    level thread[[level.hostmigrationend]]();

  level notify("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");
}

initdestructables() {
  var_0 = getEntArray("_encstr_A6040DE8D943BB96574093B7B1DACB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(getDvar("_encstr_95141256FE4AFF1B973A5B5AD7C7439626DD6B40") == "_encstr_934C0218") {
    for(var_1 = 0; var_1 < var_0.size; var_1++)
      var_0[var_1] delete();
  } else {
    for(var_1 = 0; var_1 < var_0.size; var_1++)
      var_0[var_1] thread destructable_think();
  }
}

destructable_think() {
  var_0 = 40;
  var_1 = 0;

  if(isDefined(self.script_accumulate))
    var_0 = self.script_accumulate;

  if(isDefined(self.script_threshold))
    var_1 = self.script_threshold;

  if(isDefined(self.script_fxid))
    self.fx = loadfx(self.script_fxid);

  var_2 = 0;
  self setCanDamage(1);

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_3, var_4);

    if(var_3 >= var_1) {
      var_2 = var_2 + var_3;

      if(var_2 >= var_0) {
        thread destructable_destruct();
        return;
      }
    }
  }
}

destructable_destruct() {
  var_0 = self;

  if(isDefined(var_0.fx))
    playFX(var_0.fx, var_0.origin + (0, 0, 6));

  var_0 delete();
}

inithud() {
  level.uiparent = spawnStruct();
  level.uiparent.horzalign = "_encstr_A5AD056A019C63";
  level.uiparent.vertalign = "_encstr_AC190479FF92";
  level.uiparent.alignx = "_encstr_A5AD056A019C63";
  level.uiparent.aligny = "_encstr_AC190479FF92";
  level.uiparent.x = 0;
  level.uiparent.y = 0;
  level.uiparent.width = 0;
  level.uiparent.height = 0;
  level.uiparent.children = [];
  level.fontheight = 12;
  level.hud["_encstr_9A8507BA4040188D08"] = spawnStruct();
  level.hud["_encstr_8E8405EA382B2A"] = spawnStruct();
  level.primaryprogressbary = -61;
  level.primaryprogressbarx = 0;
  level.primaryprogressbarheight = 9;
  level.primaryprogressbarwidth = 120;
  level.primaryprogressbartexty = -75;
  level.primaryprogressbartextx = 0;
  level.primaryprogressbarfontsize = 1.2;
  level.teamprogressbary = 32;
  level.teamprogressbarheight = 14;
  level.teamprogressbarwidth = 192;
  level.teamprogressbartexty = 8;
  level.teamprogressbarfontsize = 1.65;
  level.lowertextyalign = "_encstr_A146079E6DF9115CFD";
  level.lowertexty = -140;
  level.lowertextfontsize = 1.2;
}

player_init_health_regen() {
  self.regenduration = 1;
}

player_init_invulnerability() {
  self.haveinvulnerabilityavailable = 1;
}

player_init_damageshield() {
  self.damageshieldexpiretime = gettime();
}

blank(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

initplayersessionstats() {
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_84A20B03D7F1F838AB03775977", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8E090B0D5DBF90FF9CDA303853", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_A2F90B4BA1BFA7C158F35E55DF", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8FAE0723DEEECDCA19", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_AF0C0FB3E153217787CA380893653B7973", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8B170EF86DA052432371F24A1986530A", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8F14087D0F9B2FE8DA72", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_910F0CF94274481163DA39C04337", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_921F0C32951CB1DBF22C26B1B29B", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_911F1446D019B0116FD0FA15CB6EAD6BF1691D551D5F", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_ADAE14CB90A6D88185C07001D33714DC098F73C87DA9", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8A8C0A89AB725F31196DF0EB", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_BD3B0E501BD2B5F9E303DB451753A141", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8A200E1BAB274E2B37B1CBD438569B47", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8E8D0697EB01F243", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_B642089B65A658E8F597", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_84EF055338A18F", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_82FB06EB26785BD7", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_884806B91ADEE8CD", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8CB611C62C371DEB9BD1589B23FAC67BBA378E", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8E0607055DBFB3919A", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_96D30A3468575BA7C307A128", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_88CC0521F3A13B", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_B41B0A93959BDEABC9D82BCD", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_838808DBB7E55A5EBB70", 0);
}

initlaststand() {
  if(isDefined(level.player_init_laststand_func))
    [[level.player_init_laststand_func]]();
  else
    scripts\cp\cp_laststand::default_player_init_laststand();
}

initkilltriggerspawn() {
  level.killtriggerspawnlocs = scripts\engine\utility::getStructArray("_encstr_8A250D3959DC0E2CBBB9EB5691D956", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

getkilltriggerspawnloc() {
  return scripts\engine\utility::getclosest(self.origin, level.killtriggerspawnlocs);
}

startagentstealth() {
  if(scripts\engine\utility::flag_exist("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B"))
    scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  else
    wait 0.2;
}

luinotifywatcherforcpsystems() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_95B81B478B7F50D754AE414ECBAF68489311A971038868C8D08E431FC0");
  self endon("_encstr_95B81B478B7F50D754AE414ECBAF68489311A971038868C8D08E431FC0");
  var_0 = 0;

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_1, var_2);

    if(isDefined(var_1)) {
      switch (var_1) {
        case "_encstr_8E8014F9970387282C1FA65B4509B8CDABE7456B5FAB":
          break;
        case "_encstr_8BDB131780402A828D87F39BE3AB5A72092B8C9F5B":
          break;
        case "_encstr_88420E77FBD4E8B1FF2B7BE1728BFD60":
          scripts\cp\classes\cp_class_progression::giveskillpointsthruluinotify(var_2);
          break;
        case "_encstr_86480D41F8DEA0D0B7B280EBA9877F":
          break;
        case "_encstr_8F72104753503CA1F691FFEB8F1E8A77407B":
          scripts\cp\crafting_system::givecrafteditemthruluinotify(var_2);
          break;
      }
    }
  }
}

playgestureforcraftingandskillpointstablet(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case 1:
      self forceplaygestureviewmodel("_encstr_99E91204492AD9D2A123A240A4985A9BE1F370CC");
      break;
    case 0:
      self forceplaygestureviewmodel("_encstr_82D50EB359377D1A2CB15BF58DB7DE83");
      break;
  }

  scripts\common\utility::allow_fire(var_0);
  scripts\common\utility::allow_melee(var_0);
  scripts\common\utility::allow_weapon_switch(var_0);
  scripts\common\utility::allow_usability(var_0);
  scripts\common\utility::allow_ads(var_0);
}

player_role_monitor(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;
  var_1 = 0;
  var_2 = 120;
  broadcast_status(var_0, 0);
  broadcast_role(var_0);

  for(;;) {
    waitframe();
    var_1 = var_1 + 1;

    if(var_1 == var_2) {
      var_1 = 0;
      broadcast_role(var_0);
    }
  }
}

broadcast_role(var_0) {
  var_1 = var_0 getentitynumber();
  var_2 = var_0 getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_835A0FF94ACBEA830262CB0B129627E341");
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("_encstr_A74B0A55CF2902ABAF0A7A13", var_1, "_encstr_93AF0B281BC98A6BBB0238B127", var_2);
}

broadcast_status(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("_encstr_A74B0A55CF2902ABAF0A7A13", var_2, "_encstr_8D270DC1D885BCCAE435D185E8EA6E", var_1);
}

watch_target_health() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.targethealthinfo = [];

  for(;;) {
    var_0 = getdvarint("_encstr_81B515D2BEF5E17DD0089FD7C148354AB14D9C0E175DFB", 0);

    if(var_0 == 1) {
      if(self adsButtonPressed()) {
        var_1 = self getEye();
        var_2 = self getplayerangles();
        var_3 = anglesToForward(var_2);
        var_4 = var_1 + var_3 * 10000;
        var_5 = scripts\engine\trace::_bullet_trace(var_1, var_4, 1, self, 0, 0, 0, 0, 0);
        var_6 = var_5["_encstr_850E077B0BF30318B9"];

        if(isDefined(var_6) && issentient(var_6) && !isPlayer(var_6)) {
          if(isDefined(var_6.team) && var_6.team == self.team) {
            wait 0.1;
            continue;
          }

          update_target_health_variable("_encstr_B66B11AE2D7D3A2C27762B477DD02B0BC61DD0", var_6.health);
          update_target_health_variable("_encstr_B19C155DD2BE1D0BE49D951D7D6B16E1AF43B2851B1D34", var_6.maxhealth);
          update_target_health_variable("_encstr_8DAB154BF8E10D8F036F05536F28C061BAE34259A6F590", var_6 getentitynumber());
        } else
          update_target_health_variable("_encstr_8DAB154BF8E10D8F036F05536F28C061BAE34259A6F590", -1);
      } else
        update_target_health_variable("_encstr_8DAB154BF8E10D8F036F05536F28C061BAE34259A6F590", -1);
    }

    wait 0.1;
  }
}

update_target_health_variable(var_0, var_1) {
  wait 0.05;

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(self.targethealthinfo[var_0]) || var_1 != self.targethealthinfo[var_0]) {
    self setclientomnvar(var_0, var_1);
    self.targethealthinfo[var_0] = var_1;
  }
}

allow_dvar_infammo() {
  wait 5;

  if(getdvarint("_encstr_A7D013127E3521A850E80F6768EE79FAE5871D0DD0", 0) == 0) {
    return;
  }
  var_0 = 0;

  while(var_0 < 30) {
    var_0++;

    if(!isDefined(level.infil_in_progress_buffer)) {
      break;
    }

    wait 2;
  }

  scripts\cp\coop_super::team_unlimited_ammo();
}

monitor_num_players() {
  scripts\engine\utility::flag_init("_encstr_8D33180E63B0E556E4EBB1B7BACDA37D8C59D1564EADA5E69532");
  var_0 = getDvar("_encstr_87B60BC4DC439930C8178D957F");

  if(var_0 != "_encstr_A34C02BB") {
    level.only_one_player = 0;
    scripts\engine\utility::flag_set("_encstr_8D33180E63B0E556E4EBB1B7BACDA37D8C59D1564EADA5E69532");
    return;
  }

  level.only_one_player = 1;
  scripts\engine\utility::flag_set("_encstr_8D33180E63B0E556E4EBB1B7BACDA37D8C59D1564EADA5E69532");

  while(!isDefined(level.players))
    wait 0.1;

  for(;;) {
    if(level.players.size > 1) {
      break;
    }

    wait 1;
  }

  level.only_one_player = 0;
  level notify("_encstr_8708117D756AEC4C4B8422B0CF9476A107C350");
}

shellshock_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_92C6169D2CB94AB93A2BC94EBAE047225636B05E32ABDCD8", ::gas_getblurinterruptdelayms);
}

gas_getblurinterruptdelayms(var_0) {
  return 200.0;
}

delete_on_load() {
  scripts\engine\utility::array_delete(getEntArray("_encstr_A7EE0FE3BB593A1C48B68DD5AE585F3225", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  scripts\engine\utility::delaythread(0.05, scripts\engine\utility::array_delete, getEntArray("_encstr_83B018E1371C584D2AFF574DE7C21B28BBCB29BB5E752B8DB2FB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
}