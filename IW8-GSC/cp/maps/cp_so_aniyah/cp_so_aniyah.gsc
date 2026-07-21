/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_so_aniyah\cp_so_aniyah.gsc
*************************************************/

main() {
  _id_11C1E();
  setdvarifuninitialized("_encstr_86E10F37B1C9AFEA6E2BEBE68BAB2CC89B", 1);
  setdvarifuninitialized("_encstr_BE180EDCC6C9F59BB857C232FAB6850F", 4);
  setdvarifuninitialized("_encstr_A1D715E6C64EBE6EB8BA2C467DC6592C462B27AF5B2CC3", 2);
  setdvarifuninitialized("_encstr_8C1617C7CF3EF161B01E32BA73D8AC49197F4B17CF65DB4808", "_encstr_A34C02BB");
  setdvarifuninitialized("_encstr_9B580EE6B139F5DC5BBDAD95E8B2378E", "_encstr_934C0218");
  setdvarifuninitialized("_encstr_BAE417EE8E73EF21383FA0485753F8D10A396EFB65AB792902", 0);
  setdvarifuninitialized("_encstr_BAD51AB3EA1378C8D2972767EFFCE8B517B28E39B28329202E940379", 0);
  setdvarifuninitialized("_encstr_A70E1A3AD7DBB6D6FB8F336891AA03A1019BBB429807B3B8F28304DF", 0);
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  scripts\engine\utility::flag_init("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
  scripts\engine\utility::flag_init("_encstr_81A51669D168D9D32131B37A7B86378E18ADEEF567109F4B");
  scripts\engine\utility::flag_init("_encstr_929A115637B2B62D9537D7DC0785779BA5379D");
  scripts\engine\utility::flag_init("_encstr_AC8A14C7A36175EA19A80818D3453B0927B137917930");
  scripts\engine\utility::flag_init("_encstr_B88A141953F75540B113B9933FA5A888DB1A93632943");
  _encstr_97D83782EE85F218E3E8C60F0870CDBA597E1D3ECFB72B5FAE50CB2F6891B006D71799B2380FC2963088EF3341EB626AAF271EEC9505FAB399::main();
  _encstr_AD1C366BDE7A403753D77FEFF3CEF15810B298E182EF58601987C5E3AF724BE2DF8F38F0EE2881263297D3E5C71B07A04F6623134567A8D6::main();
  _encstr_B68B31DC3693D207E837978D07E5B50B079B97B1C1FAE67B7DC2B92DF216A1E58DC1BE6EEDD70B9BB4BC0B34EBCC87B876CDD8::main();
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
  level._id_13BEA = 0;
  level.c130airdrop_getvalidteaminlastplace = [];
  level.hostdamagefactorlow = 0;
  level.map_interaction_func = _encstr_B6C03B92FEB5C228D3F8D6FFF860FD8A490E0D0EDF473B4FDE40DBDF5881A016C727E982C81FD28620F8DF2351F86E6B93BEEE3E2D9B8ADE8B6ACF47D8::register_interactions;
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_A7FE3F035EBE924BEB908721D846B1B7E0C638377837681876F9CE5B03A068CF6670B0EF5F17DF7BB428DFB8F9B030787F6025BE7FD2908919A82FA328B6DBE0A3";
  level.player_interaction_monitor = _encstr_B6C03B92FEB5C228D3F8D6FFF860FD8A490E0D0EDF473B4FDE40DBDF5881A016C727E982C81FD28620F8DF2351F86E6B93BEEE3E2D9B8ADE8B6ACF47D8::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_B6C03B92FEB5C228D3F8D6FFF860FD8A490E0D0EDF473B4FDE40DBDF5881A016C727E982C81FD28620F8DF2351F86E6B93BEEE3E2D9B8ADE8B6ACF47D8::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = ::interaction_trigger_properties;
  level.strike_player_connect_black_screen_fn = ::_id_1247B;
  level.mud_sfx = ::mud_sfx;

  if(!scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_init("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_init("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  scripts\engine\utility::flag_init("_encstr_8A871AFF50EDB017BF03F67B5AB345F0C3B91F6DFF9330D1C7CA8B83");
  scripts\engine\utility::flag_init("_encstr_81530F604BBB788B47AFC9647507A3B0B4");
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
  level thread scripts\cp\cp_movers::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level.additional_laststand_weapon_exclusion = [];
  level thread setup_map_specific_devgui();
  level.devgui_setup_func = ::onplayerspawneddevguisetup;

  if(level.scripted_spawner_func.size < 1)
    scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(!scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    scripts\engine\utility::flag_init("_encstr_A2D20FE4880D52A426C867576878654BD3");

  var_0 = getDvar("_encstr_921217B3B176F01208B1E2EA830142667B3BD1FBB35F3AEE6A", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101")
    level thread rundebugstartobjective(var_0);

  level.eogscoreboard = ["_encstr_A19B0973B543C35FDDE063", "_encstr_8E8D0697EB01F243", "_encstr_96D30A3468575BA7C307A128", "_encstr_A9AB06297DDFD816", "_encstr_B642089B65A658E8F597"];
  scripts\cp\cp_compass::setupminimap("_encstr_BA5419B1BD5B0E0B6EDC7DD61638BE6CE07DCDB7FAC2735AE50B34");
  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
  thread playing_bomb_counter_beep();
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

_id_11C1E() {
  var_0 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1[0] = (11264, -5120, 256);
  var_1[1] = (-7168, 5120, 256);

  foreach(var_4, var_3 in var_0) {
    if(!isDefined(var_1[var_4])) {
      var_3 delete();
      continue;
    }

    var_3.origin = var_1[var_4];
  }
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

onplayerconnect(var_0) {}

onplayerspawned() {
  _encstr_A39824FFD7C234188B1A3A6970CE4FB72B1FEC33032D33FE0F60C9CF6B2D7107706705929B82::givedefaultloadout();
  var_0 = "_encstr_8C160DAFE71BF161681EB5BCB0F8FC";
  var_1 = scripts\cp\cp_weapon::buildweapon_variant(var_0, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 5);
  self giveweapon(var_1);
  self setweaponammoclip(var_1, weaponclipsize(var_1));
  self setweaponammostock(var_1, weaponmaxammo(var_1));
  self switchtoweapon(var_1);
  var_2 = "_encstr_9106102387E011DF472978E0722F376ADAB9";
  var_3 = scripts\cp\cp_weapon::buildweapon_variant(var_2, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 1);
  self giveweapon(var_3);
  self setweaponammoclip(var_3, weaponclipsize(var_3));
  self setweaponammostock(var_3, weaponmaxammo(var_3));
  thread scripts\cp\cp_powers::givepower("_encstr_81580B52FF3F7F3D195A6A61A7", "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, 4);
  thread scripts\cp\cp_powers::givepower("_encstr_A22A16E07BEE5693EB9B732C83B934EDE83AE4B2E658C895", "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, 4);
  self.last_stand_pistol = scripts\cp\cp_weapon::buildweapon_variant("_encstr_9106102387E011DF472978E0722F376ADAB9", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 1);
  self.weaponlist = self getweaponslistprimaries();
  thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0], 1);

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0]))
    self.primaryweaponobj = self.weaponlist[0];

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1]))
    self.secondaryweaponobj = self.weaponlist[1];

  self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 0);

  if(!scripts\engine\utility::flag("_encstr_81A51669D168D9D32131B37A7B86378E18ADEEF567109F4B"))
    self allowmovement(0);

  level.hostdamagefactorlow++;

  if(!isDefined(level.givematchplacementchallenge) && !isDefined(level.give_weapon_alt_clip_ammo_hack) && (level.hostdamagefactorlow > 1 || getdvarint("_encstr_BAE417EE8E73EF21383FA0485753F8D10A396EFB65AB792902", 0)))
    _id_13522();

  if(level.hostdamagefactorlow > 1)
    level._id_11B47 = 2;
  else
    level._id_11B47 = 4;

  level._id_11B46 = 47 - level._id_11B47 * 4 * level.hostdamagefactorlow;
  bomb_vest_controller_holder();

  if(scripts\engine\utility::flag("_encstr_929A115637B2B62D9537D7DC0785779BA5379D"))
    thread setup_bot_arena();

  thread interruptbombplanting();
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

_id_1247B(var_0) {}

_id_14379() {
  while(level.hostdamagefactorlow < getdvarint("_encstr_87B60BC4DC439930C8178D957F"))
    waitframe();
}

playing_bomb_counter_beep() {
  level._id_11B4D = 1;
  level._id_11F7E = [];
  level.openangles = [];
  level._id_13855 = [];
  createthreatbiasgroup("_encstr_86190E3BC9B7D537C8BE8EE4B7DE83CD");
  createthreatbiasgroup("_encstr_AD580CDA8088C50E135328F0CBB3");
  createthreatbiasgroup("_encstr_A9DA0FDF3ED75B7E99E1E39B38122D7387");
  createthreatbiasgroup("_encstr_B6CC0586B28D96");
  setignoremegroup("_encstr_B6CC0586B28D96", "_encstr_86190E3BC9B7D537C8BE8EE4B7DE83CD");
  setignoremegroup("_encstr_A9DA0FDF3ED75B7E99E1E39B38122D7387", "_encstr_AD580CDA8088C50E135328F0CBB3");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  team_revive_kbm_override_callback();
  stream_time();
  thread bwasjuggernaut(7600, 0, "_encstr_AC8A14C7A36175EA19A80818D3453B0927B137917930");
  thread stoppingpower_onweaponcreated();
  thread target_found_speed();
  teamcanrespawn();
  taketeamplunder();
  stoppingpower_clearhcrongameended();
  var_0 = scripts\engine\utility::getStruct("_encstr_BEA21090FB4541FFD144203C5C3A4F49B65B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("_encstr_846B19C3C3C8A8D1D17369A7EA808CB793B8FC3B5807E360CDEBC4");
  var_2 = getEnt("_encstr_B80B10928C18C0D0C222A2C392ADD1820EE5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2.origin = (4249.97, 2341.5, 200);
  var_2.angles = (0, 114, 0);
  scripts\cp\laser_traps\cp_laser_traps::_id_1437A();
  thread _id_13F26();
  scripts\engine\utility::flag_set("_encstr_81A51669D168D9D32131B37A7B86378E18ADEEF567109F4B");
  supersupplydropbeginuse();
  thread supportbox_watch_flight();
  thread subway_fast_travel_teleport_data();
  thread _id_12758("_encstr_BE352C28EB5769E1CB215A5785C27710DF2BD8E0E73F40F3B2D2CD705DBA5F9E3E9F68D8A7C898AFAA7F46782287");

  foreach(var_4 in level.players) {
    var_4 allowmovement(1);
    var_4 setthreatbiasgroup("_encstr_A9DA0FDF3ED75B7E99E1E39B38122D7387");
  }

  scripts\cp\laser_traps\cp_laser_traps::_id_13067();
  var_6 = scripts\engine\utility::getStruct("_encstr_A6F61132E62D026BDEBAD3979BD3D8623E2087", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(brevent1playerthink(var_6.origin, 450) && !getdvarint("_encstr_BAE417EE8E73EF21383FA0485753F8D10A396EFB65AB792902"))
    wait 0.1;

  foreach(var_4 in level.players)
  var_4 thread setup_bot_arena();

  scripts\engine\utility::flag_set("_encstr_929A115637B2B62D9537D7DC0785779BA5379D");
  thread setup_heli_starts();
  thread setup_enemytype_on_spawner();
  thread bot_add_landing_spot("_encstr_87DE0E96E6D1951BBE4CEB59F0D1E40B", undefined, undefined, undefined, 1);
  thread bot_add_landing_spot("_encstr_8F3A0E0F3DC9AB6DB9425007F0A3DA6B", "_encstr_82A60860CA33FBB84772", 600, 1, 2);
  thread bot_add_landing_spot("_encstr_A9E50E60F83C37FC6F429F5743AB3B8F", "_encstr_92A608F832037DA811F3", 2000, 2, 4);
  level waittill("_encstr_B2200FB2C399D236D76CF6DA381BCA472B");
  level notify("_encstr_99690F2FC5B24130509F29B0278B90B8B0");
  setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 0);
  level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
}

_id_12758(var_0) {
  if(!isDefined(level._id_121A7))
    level._id_121A7 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));

  level._id_121A7 stopsounds();
  var_1 = lookupsoundlength(var_0) * 0.001;
  level._id_121A7 playSound(var_0);
  wait(var_1);
}

_id_1244F(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(level.givematchplacementchallenge.vo))
    level.givematchplacementchallenge.vo = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));

  level.givematchplacementchallenge.vo stopsounds();
  var_2 = lookupsoundlength(var_0) * 0.001;

  if(var_1)
    level.givematchplacementchallenge.vo playsoundtoplayer(var_0, level.givematchplacementchallenge);
  else
    level.givematchplacementchallenge.vo playSound(var_0);

  wait(var_2);
}

_id_12450(var_0) {
  _id_1244F(var_0, 1);
}

vip_onrespawn(var_0) {
  if(isDefined(level.givematchplacementchallenge) && isDefined(level.choppergunners[0]) && isDefined(level.choppergunners[0])) {
    if(level.givematchplacementchallenge == var_0)
      return 1;

    if(scripts\engine\utility::is_equal(level.choppergunners[0], var_0))
      return 1;

    if(scripts\engine\utility::is_equal(level.choppergunners[0].turret, var_0))
      return 1;
  }

  return 0;
}

_id_123D5(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(isDefined(level.givematchplacementchallenge) && !isDefined(level.givematchplacementchallenge.waittill_player_deposits))
    level.givematchplacementchallenge.waittill_player_deposits = 0;

  if(vip_onrespawn(var_0) && (scripts\engine\utility::time_has_passed(level.givematchplacementchallenge.waittill_player_deposits, 6) || var_2)) {
    level.givematchplacementchallenge.waittill_player_deposits = gettime();
    _id_1244F(scripts\engine\utility::random(var_1));
  }
}

getdomplateradius() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  var_0 = ["_encstr_B6AE2C29980968606739E9B3A26B30C8DC14B1BF3CAA08BF5711A1B86A435F60B24F151BDC556075871A3946979A", "_encstr_A7AE2CF1DBC90438259979533E7081320213692703C3450B4BE12168A5E8307DCB77CD83DB7A1FF09185A9861AF0"];
  level.givematchplacementchallenge.playapacheonly_dialogue = 0;
  level.givematchplacementchallenge.getggweapontablelootvariants = 0;

  for(;;) {
    level.givematchplacementchallenge waittill("_encstr_A2D20E628B1F32BC26B87F2F70D86C5A");
    level.givematchplacementchallenge.playapacheonly_dialogue = 1;
    level.givematchplacementchallenge.getggweapontablelootvariants = 0;

    if(self.missilesleft == 0) {
      level.givematchplacementchallenge.waittill_player_deposits = gettime();
      level.givematchplacementchallenge.getggweapontablelootvariants = 1;
      _id_12450(scripts\engine\utility::random(var_0));
      wait 3;
    }
  }
}

getdropbagdelay() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  var_0 = ["_encstr_8D352A8CC3AFD9F6DAEBB038B00EFAAD2D1BB1378E4E9516ADAF36D0F6C1385939AFC6EDDA31C2D1EB468160", "_encstr_99352A91BBA9641805B95973DEE06112227309072323A5202B81018845C8505D2B578FB73F8A7F5047B2438B", "_encstr_A5352A82C37F230718AFC9D02783FFACBB388A0B88FD5F77B068D3F0C86B8B77F509E242F8B516FBEEC68AA0", "_encstr_99352A91BBA9641805B95973DEE06112227309072323A5202B81018845C8505D2B578FB73F8A7F5047B2038B"];

  for(;;) {
    self waittill("_encstr_991E12DA5ACDDC5A1B956E7DE49533D2B1D85919");

    if(isDefined(level.givematchplacementchallenge) && !isDefined(level.givematchplacementchallenge.waittill_player_deposits))
      level.givematchplacementchallenge.waittill_player_deposits = 0;

    if(scripts\engine\utility::time_has_passed(level.givematchplacementchallenge.waittill_player_deposits, 6) || istrue(level.givematchplacementchallenge.getggweapontablelootvariants)) {
      level.givematchplacementchallenge.waittill_player_deposits = gettime();
      _id_12450(scripts\engine\utility::random(var_0));
      wait 18;
    }
  }
}

_id_123F4() {
  if(!isDefined(level.givematchplacementchallenge.waittill_player_deposits))
    level.givematchplacementchallenge.waittill_player_deposits = 0;

  if(scripts\engine\utility::time_has_passed(level.givematchplacementchallenge.waittill_player_deposits, 6)) {
    level.givematchplacementchallenge.waittill_player_deposits = gettime();

    if(give_super_ammo_after_loadout_given(self.origin)) {
      if(randomint(100) > 50)
        _id_12450("_encstr_A1352A45A3594C0ADFC1AF1851A731222B2113DB808D1836DB47E821775BDF75A34F71EF3556C73D96479D0A");
      else
        _id_12450("_encstr_AC352AB81B494D481FEF0787A913363FACC270B873DA93412FC71EF38F3B1BFBD29990D01A76D3BB27B13CD7");
    } else if(level.choppergunners[0] scripts\engine\math::is_point_on_right(self.origin))
      _id_12450("_encstr_B6352A9D2877E5EF91F0AF4853EA683BD8511C9E38D8C8E26251D67B88183BFFC039B2A28376B38C387B8681");
    else
      _id_12450("_encstr_A9352A855051CB4790C78B90F983F1F3C1F8A076CBC0A1BEDA8FBA61355AFBA223B6B06F3542CA7BC063E042");
  }
}

team_revive_kbm_override_callback() {
  level.giveplayerpoints = ["_encstr_A6352AC86B391D184F5FB73779E3C6EF1C9263E8C30A63917FB74E235F8B6B4B0249C080CAA6A30BD7E1EE07", "_encstr_97352A2482EF76C7DDF9815B21AFB9428B108CE27B6ED708CB26D9F00213B3BD3A0F82B7D0F0EAC86106CFF2", "_encstr_86352A72F08FB39788B07960B7F38F3C0BA87A9B386D2FE72098436058DB7BC7659972D26825E64B9ED71D30", "_encstr_AF8129323C7DCEDEB5AFB0838538BED64B361B6E479CCA0BB67D8D0DDB1CC1B29CBEC67BB53158E8EB2303", "_encstr_A7352AB080170B38BD970E20E350CF942422FAE6E8BA1F300C67061358FB38F518890107605E8703A16682B7", "_encstr_95812991E1BECEDEB5AFC2E016E07DD64BC6B1E6E8C9AC0BAD7D6CA1ED071CAC93EB36DBD626C247D7E681", "_encstr_8181297AF887AB8F80884168BF0B873433B00283A37527EF38904B7840D303FF6D917ADA602D9E7396CB30", "_encstr_96582CC80FAF9D7BDAAF850E580ED76D2D63D8B9E84E5685DAF536A1B7070E5939EB9CAC58D8D12DED37E6AF98C0", "_encstr_AB1F2DD3B1905B5758C67E0239885F4253017B7741AED2115BAEF60C1060B8FAB6CF9BA7D35E8BC1F890EAD9C33AA0", "_encstr_85582C1B7928E3EF109E367A71D0178A9BF9A3CF19E69AD9F866AE44A8A860A2EE0753EF9B865399B068A2816B82", "_encstr_8C582C8C0FD7B3BDB5FA161C580EF55BD21BB1E647E495C2DAAFB1D0DE070E599C7DC9595836D196F673E6D78603"];
  level.givepointsandxp = ["_encstr_86582CF5D8312D50D5CFA0201FE06EAFFA457986333BC3D98BB7A8D83F1843FB3321EE05CE42B92D675B2069BE70", "_encstr_8C582C8C0FD7B3BDB5FA161C580EF55BD21BB1E647E495C2DAAFB1D0DE070E599C7DC9595836D196F673E6D7C603"];
  level.givequest = ["_encstr_A51F2D9332868330A0466BB2566B086463EB990BBBCDC5596D31D73B70F3F87D8DA7C0F1F9C004437F5D436126874F", "_encstr_A1582C19F0D79DDB6BFA580E2C83BEDA4BC68D9BE827CAB0B6BE8D34B7383859E4EBC92BC2361D96F69BB9EB0781"];
}

teamcanrespawn() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_BD8615DD59C20EF637FA3B0B4E5AC2DC3AAFDC8385DDCD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = strtok(var_2.weaponinfo, "_encstr_854C021F");
    var_4 = var_3[0];
    var_5 = int(var_3[1]);
    var_6 = scripts\cp\cp_weapon::buildweapon_variant(var_4, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", var_5);
    var_7 = spawn("_encstr_B2010820C5337B67C8CF" + createheadicon(var_6), var_2.origin, 17);
    var_7.angles = var_2.angles;
    var_7 _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::setscriptammo(var_4, var_2);
  }

  init_gas_trap_room("_encstr_A60C1F40077FD54060215B067A5DF7321F4A209F7043F853586245EFC2D319AF73", (9746.25, 541.635, 232.99), (359.463, 336.201, -6.52015));
  init_gas_trap_room("_encstr_A60C1F40077FD54060215B067A5DF7321F4A209F7043F853586245EFC2D319AF73", (9716, 500.707, 237.361), (0, 269.056, 0));
  init_gas_trap_room("_encstr_A60C1F40077FD54060215B067A5DF7321F4A209F7043F853586245EFC2D319AF73", (9721.62, 582.172, 232.99), (359.463, 291.201, -6.52017));
  init_gas_trap_room("_encstr_A60C1F40077FD54060215B067A5DF7321F4A209F7043F853586245EFC2D319AF73", (9671.29, 574.622, 237.349), (356.672, 224.06, -0.874738));
}

init_gas_trap_room(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_3.angles = var_2;
  var_3 setModel(var_0);
}

init_loadout_selection_structs(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.angles = var_1;
  return var_2;
}

taketeamplunder() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_973F0B7A3FE97FE22BE85AB358", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0) || var_0.size == 0) {
    var_0 = [];
    var_0[0] = init_loadout_selection_structs((3414.02, -206.307, 438.851), (0.937701, 163.49, -73.7181));
    var_0[1] = init_loadout_selection_structs((4095.08, 2409.04, 516.146), (0.937701, 163.49, -73.7181));
    var_0[2] = init_loadout_selection_structs((3547.26, 116.885, 438.851), (0.937701, 163.49, -73.7181));
  }

  var_1 = "_encstr_BA090ED4634AD742CFC7BBABA36F5A77";
  var_2 = scripts\cp\cp_weapon::buildweapon(var_1);

  foreach(var_4 in var_0) {
    var_5 = spawn("_encstr_B2010820C5337B67C8CF" + createheadicon(var_2), var_4.origin, 17);
    var_5.angles = var_4.angles;
    var_5 itemweaponsetammo(weaponclipsize(var_5), weaponmaxammo(var_5));
  }
}

stoppingpower_onweaponcreated() {
  scripts\engine\utility::flag_wait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
  level.bronattackerdamagenottracked = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_A30F0808D5B10E70E85F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var_2.origin, var_2.angles);
    setheadiconsnaptoedges(var_3.headiconid, 1000);
    level.bronattackerdamagenottracked[level.bronattackerdamagenottracked.size] = var_3;
  }

  level._id_13855[level._id_13855.size] = broadcast_health((7915.56, 719.412, 309.503), (0, 35.2279, 0));
  scripts\engine\utility::flag_wait("_encstr_AC8A14C7A36175EA19A80818D3453B0927B137917930");
  thread bwasjuggernaut(6400, 0, "_encstr_B88A141953F75540B113B9933FA5A888DB1A93632943");
  broadcast_health((6286.55, 98.5832, 304.667), (0, 50.2161, 0));
  broadcast_health((3952.29, 2727.76, 509.668), (0, 193.771, 0));
  scripts\engine\utility::flag_wait("_encstr_B88A141953F75540B113B9933FA5A888DB1A93632943");
  last_exfil_nag();
  broadcast_health((3286.01, -309.974, 637.655), (0, 6.95607, 0));
}

last_exfil_nag() {
  foreach(var_1 in level._id_13855)
  var_1 delete();
}

broadcast_health(var_0, var_1) {
  var_2 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var_0, var_1);
  setheadiconsnaptoedges(var_2.headiconid, 1000);
  level.bronattackerdamagenottracked[level.bronattackerdamagenottracked.size] = var_2;
  return var_2;
}

supportbox_watch_flight() {
  scripts\engine\utility::flag_wait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
  level.weapon_xp_iw8_pi_decho = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_B86E0AD752F94895F39A3980", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getclosest(var_2.origin, scripts\engine\utility::array_combine(level._id_11F7E, [scripts\engine\utility::getStruct("_encstr_8A12060D5BA9C745", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")]));

    if(level._id_11F7E["_encstr_BDA6081B738B7DB08792"] == var_3 || level._id_11F7E["_encstr_82A60860CA33FBB84772"] == var_3)
      var_4 = scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback(var_2.origin, var_2.angles);
    else
      var_4 = scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled(var_2.origin, var_2.angles);

    setheadiconsnaptoedges(var_4.headiconid, 1000);
    level.weapon_xp_iw8_pi_decho[level.weapon_xp_iw8_pi_decho.size] = var_4;
  }

  level._id_13855[level._id_13855.size] = weapon_xp_iw8_pi_golf21(scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback, (9603.81, 604.333, 276.825), (0, 324.1, 0));
  level._id_13855[level._id_13855.size] = weapon_xp_iw8_pi_golf21(scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled, (9585.84, 617.592, 277.95), (0, 331.922, 0));
  weapon_xp_iw8_pi_golf21(scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled, (7705.28, 1012.39, 306.169), (0, 212.005, 0));
  scripts\engine\utility::flag_wait("_encstr_AC8A14C7A36175EA19A80818D3453B0927B137917930");
  weapon_xp_iw8_pi_golf21(scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled, (6189.07, 249.703, 300.327), (0, 225.653, 0));
  weapon_xp_iw8_pi_golf21(scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback, (4105.12, 2344.8, 516.591), (0, 169.026, 0));
  scripts\engine\utility::flag_wait("_encstr_B88A141953F75540B113B9933FA5A888DB1A93632943");
  weapon_xp_iw8_pi_golf21(scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback, (3479.5, 125.858, 440.031), (0, 194.667, 0));
}

weapon_xp_iw8_pi_golf21(var_0, var_1, var_2) {
  var_3 = [[var_0]](var_1, var_2);
  setheadiconsnaptoedges(var_3.headiconid, 1000);
  level.weapon_xp_iw8_pi_decho[level.weapon_xp_iw8_pi_decho.size] = var_3;
  return var_3;
}

target_found_speed() {
  scripts\engine\utility::flag_wait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
  level._id_13A14 = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_9B100CE698BED1588D3A96B18563", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = scripts\cp\laser_traps\cp_laser_traps::_id_13433(var_2.origin, var_2.angles);
    setheadiconsnaptoedges(var_3.headiconid, 1000);
    level._id_13A14[level._id_13A14.size] = var_3;
  }

  level._id_13855[level._id_13855.size] = _id_13A15(scripts\cp\laser_traps\cp_laser_traps::player_limitedammo, (9642.09, 572.949, 276.446), (0, 317.414, 0));
  level._id_13855[level._id_13855.size] = _id_13A15(scripts\cp\laser_traps\cp_laser_traps::_id_13433, (9625.2, 589.434, 277.056), (0, 322.444, 0));
  _id_13A15(scripts\cp\laser_traps\cp_laser_traps::player_limitedammo, (7851.16, 700.082, 311.378), (0, 22.4981, 0));
  scripts\engine\utility::flag_wait("_encstr_AC8A14C7A36175EA19A80818D3453B0927B137917930");
  _id_13A15(scripts\cp\laser_traps\cp_laser_traps::player_limitedammo, (6113.88, 301.455, 297.712), (0, 101.655, 0));
  _id_13A15(scripts\cp\laser_traps\cp_laser_traps::player_limitedammo, (3917.02, 2626.14, 366.841), (0, 301.772, 0));
  _id_13A15(scripts\cp\laser_traps\cp_laser_traps::player_limitedammo, (3529.03, -202.147, 440.773), (0, 31.7719, 0));
}

_id_13A15(var_0, var_1, var_2) {
  var_3 = [[var_0]](var_1, var_2);
  setheadiconsnaptoedges(var_3.headiconid, 1000);
  level._id_13A14[level._id_13A14.size] = var_3;
  return var_3;
}

stream_time() {
  for(var_0 = 1; var_0 < 4; var_0++) {
    var_1 = scripts\engine\utility::getStruct("_encstr_99AE1310F8DBDDD358FE129B22991F38A828A504B0" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = scripts\cp\laser_traps\cp_laser_traps::get_enter_leave_station_time(var_1.origin, var_1.angles);
    var_3 = scripts\cp\laser_traps\cp_laser_traps::get_ending_struct(var_2);
    var_4 = scripts\cp\laser_traps\cp_laser_traps::get_emp_effect_duration(var_2);

    switch (var_0) {
      case 1:
        thread scripts\cp\laser_traps\cp_laser_traps::get_end_ang(var_2, var_3, var_4, "_encstr_9B1807D39B48FD93A3", ::_id_124A2);
        break;
      case 2:
        thread scripts\cp\laser_traps\cp_laser_traps::get_end_ang(var_2, var_3, var_4, "_encstr_ACD20F4B118BEF03D380F9335815BC7761", ::_id_124A3);
        break;
      case 3:
        thread scripts\cp\laser_traps\cp_laser_traps::get_end_ang(var_2, var_3, var_4, "_encstr_8BFC0BC2CBD4F737E0A5E1FD79", ::_id_124A4);
        break;
      default:
        break;
    }

    setheadiconsnaptoedges(var_2.headicon, 1000);
  }
}

_id_124A2(var_0, var_1, var_2) {
  thread _id_12758("_encstr_9BFB1F32C3D75BC116FAC9BA8EC6AFCDACE647C997FACEAB73BE583686B42BD9AC");
}

_id_124A3(var_0, var_1, var_2) {
  thread _id_12758("_encstr_AFC7232A62C0C76A703FFAE571C07937F17BD3B3A92E57E2F08DE9F37B31BE8F2B100A1B31");
}

_id_124A4(var_0, var_1, var_2) {
  thread _id_12758("_encstr_8C341F320FBE5B1C16AFC9BAE88DAF9ABAB3CE2B4ECD585D3A7D161BD02DACECCA");
}

_id_13522() {
  var_0 = scripts\engine\utility::getStruct("_encstr_8BA213238AA327284806DB59DF3F8F8B37EB524B7D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.give_weapon_alt_clip_ammo_hack = scripts\cp\laser_traps\cp_laser_traps::get_enter_leave_station_time(var_0.origin, var_0.angles);
  var_1 = scripts\cp\laser_traps\cp_laser_traps::get_ending_struct(level.give_weapon_alt_clip_ammo_hack);
  var_2 = scripts\cp\laser_traps\cp_laser_traps::get_emp_effect_duration(level.give_weapon_alt_clip_ammo_hack);
  thread giveachievementpilotkill(level.give_weapon_alt_clip_ammo_hack, var_1, var_2);
}

giveachievementpilotkill(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_81530F604BBB788B47AFC9647507A3B0B4");
  var_4 = createnavobstaclebybounds(var_0.origin, (30, 10, 64), var_0.angles);
  var_5 = var_0 scripts\cp\utility::killstreak_createobjective("_encstr_ABC919966CDB73F5DAD237A5B55883AF8DC2C9590E85C6B5B0ECAC", "_encstr_9A8507BA4040188D08", 1, 1, 0);
  var_6 = deleteheadicon(var_0);
  setheadiconfriendlyimage(var_6, "_encstr_82D41B345D467D5A6CB773F56DB4D863CD47279516B6D7853816B1D095");
  addclienttoheadiconmask(var_6, -7);
  setheadiconmaxdistance(var_6, 0);
  setheadiconsnaptoedges(var_6, 1000);
  setheadiconowner(var_6, undefined);
  setheadiconzoffset(var_6, 1);
  hideheadiconfromplayersinmask(var_6);
  var_0.headicon = var_6;
  var_0 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_0 sethintdisplayrange(256);
  var_0 setuserange(100);
  var_0 setusefov(180);
  var_0 sethintdisplayfov(180);
  var_0 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_0 setusepriority(0);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0 sethinttag("_encstr_BA300854E318F1FF9699");
  var_0 makeusable();
  var_0 setHintString(&"_encstr_A6C51D2B637FC22FE7A7D8AC217F298FEF2787A748FD793718DB232AA80F5D");
  var_0.hostage_room_enemy_watcher = undefined;
  thread give_xp_to_all_players_hack(var_0, var_2, var_1, var_5, var_4);

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_7);

    if(!isPlayer(var_7) || istrue(var_7 scripts\cp\cp_outofbounds::isoob())) {
      continue;
    }
    var_7 thread _id_1428E(var_0);
  }
}

give_xp_to_all_players_hack(var_0, var_1, var_2, var_3, var_4) {
  var_0 waittill("_encstr_81530F604BBB788B47AFC9647507A3B0B4");
  setomnvarforallclients("_encstr_9A5D0DE370D7D08AD318797D73E377", 0);
  var_0 makeunusable();
  var_0 notsolid();
  setheadiconimage(var_0.headicon);
  var_0.headicon = undefined;
  var_1 delete();
  var_2 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_95EB0866891B23FB85B3", 0);
  var_2 setscriptablepartstate("_encstr_95EB0866891B23FB85B3", "_encstr_99AD06D3A5B1538B", 0);
  objective_state(var_3, "_encstr_8267056410C669");
  scripts\cp\utility::nonobjective_returnobjectiveid(var_3);
  wait 2.0;
  var_0 setCanDamage(0);
  var_0 setnonstick(1);
  destroynavobstacle(var_4);
  var_2 delete();
  var_0 delete();
}

_id_1428E(var_0) {
  var_0 endon("_encstr_81530F604BBB788B47AFC9647507A3B0B4");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self setclientomnvar("_encstr_9A5D0DE370D7D08AD318797D73E377", 1);
  thread waittill_juggs_alive(var_0);
  self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_1);

  if(var_1 == "_encstr_A7C40B7B5BB711338349C068D8") {
    thread _id_124A0(self);
    var_0 notify("_encstr_81530F604BBB788B47AFC9647507A3B0B4");
  }
}

waittill_juggs_alive(var_0) {
  var_0 endon("_encstr_81530F604BBB788B47AFC9647507A3B0B4");
  self waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self setclientomnvar("_encstr_9A5D0DE370D7D08AD318797D73E377", 0);
}

_id_124A0(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 0.1;

  while(!var_0 isonground() || var_0 isonladder() || var_0 isjumping())
    waitframe();

  if(istrue(var_0 scripts\cp\cp_outofbounds::isoob())) {
    var_1 = 0;

    for(;;) {
      wait 0.05;

      if(!istrue(var_0 scripts\cp\cp_outofbounds::isoob()))
        var_1++;
      else
        var_1 = 0;

      if(var_1 >= 20) {
        break;
      }
    }
  }

  level.givematchplacementchallenge = var_0;
  var_0.stopcirclesatgameend = 1;
  var_0 thread setup_crates_to_mark();
  var_0 playerhide();
  var_0 vehiclepinonminimap(1);
  var_0 allowmovement(0);
  var_2 = scripts\engine\utility::array_remove(level.players, var_0);
  level.givematchplacementchallenge.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_8AA71D73E46590B11AA3F5F3E7A288383EFA58290DCCD873A26FDDEB979A4D", var_0, var_2, var_0, 1, 1);

  foreach(var_4 in var_2) {
    var_4.headicon = deleteheadicon(var_4);
    setheadiconenemyimage(var_4.headicon, "_encstr_A62C214CED91A9090910CB07C021F9E20F0D92835BE1C24DF0F0171B0898B50AC11118");
    addclienttoheadiconmask(var_4.headicon, 0);
    setheadiconzoffset(var_4.headicon, 1);
    setheadiconsnaptoedges(var_4.headicon, 31999);
    setheadiconmaxdistance(var_4.headicon, 31999);
    setheadicondrawthroughgeo(var_4.headicon, 1);
    setheadiconowner(var_4.headicon, "_encstr_9A8507BA4040188D08");

    foreach(var_6 in var_2)
    addteamtoheadiconmask(var_4.headicon, var_6);

    setheadiconteam(var_4.headicon);
  }

  var_9 = 0;

  for(;;) {
    switch (var_9) {
      case 0:
        scripts\engine\utility::delaythread(4.0, ::_id_12758, "_encstr_827828320FF5DA07C2F5C9BA1DB1F58D86BD3883CA9CF576BADCDCB2E4D7999CA5B2B93263CBD7AB6ECA");
        break;
      case 1:
        scripts\engine\utility::delaythread(4.0, ::_id_12758, "_encstr_8A8129E048D9A5AF5DAFD0F96BA1408CE48BD5A723E6E3B95A61A7B3383383A3EDF117907946D73B797A7F");
        break;
      case 2:
        scripts\engine\utility::delaythread(4.0, ::_id_12758, "_encstr_8B6A29A5F82063105D39AF4F49539727ABFC818FABEBD5CF3217BB52DFF8BF09CBB1AFF84BA5E79847F252");
        var_9 = -1;
        break;
      default:
        break;
    }

    var_9++;
    var_0 scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunner();
    level.givematchplacementchallenge.chopper = level.choppergunners[0];
    level.givematchplacementchallenge.chopper.owner = var_0;
    level.givematchplacementchallenge.chopper.occupants = [var_0];
    level.givematchplacementchallenge.attractor = missile_createattractorent(level.givematchplacementchallenge.chopper, 1000, 7000);
    level.givematchplacementchallenge.chopper setthreatbiasgroup("_encstr_B6CC0586B28D96");
    level.givematchplacementchallenge.chopper thread getdomplateradius();
    level.givematchplacementchallenge.chopper thread getdropbagdelay();
    var_0 notify("_encstr_9A361DEB401969863BDA2338F5AF78F722E2FA21F0B311C1503AE879A33B16");
    var_0 setthreatbiasgroup("_encstr_B6CC0586B28D96");
    level.givematchplacementchallenge.chopper waittill("_encstr_AD75063D571AE108");
    var_0 thread scripts\cp\utility::freezecontrolswrapper(1);
    var_0 playerhide();
    var_0 vehiclepinonminimap(1);
    var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
    wait 2.25;
    var_10 = 10.0;
    var_0 thread black_screen(var_10, 1.0);
    var_0 thread givequestrewards(var_10);
    wait 7.5;
    var_0 thread scripts\cp\utility::freezecontrolswrapper(0);
    var_0 scripts\engine\utility::delaycall(2.5, ::setclientomnvar, "_encstr_AA5B0CE53B662BDC495081EAC891", 0);
  }
}

interruptbombplanting() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9A361DEB401969863BDA2338F5AF78F722E2FA21F0B311C1503AE879A33B16");
  self.players_monitor = 0;

  while(isDefined(self)) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1);

    if(isDefined(level.givematchplacementchallenge) && isDefined(level.choppergunners) && isDefined(level.choppergunners[0]) && isDefined(level.choppergunners[0].turret)) {
      if(!isDefined(self) || !isDefined(var_1)) {
        return;
      }
      if(level.givematchplacementchallenge == var_1 || scripts\engine\utility::is_equal(level.choppergunners[0], var_1) || scripts\engine\utility::is_equal(level.choppergunners[0].turret, var_1)) {
        level childthread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "_encstr_B621107140282E7F17C807BE3FD0893CD4B0");
        level childthread scripts\cp\cp_player_battlechatter::trysaylocalsound(level.givematchplacementchallenge, "_encstr_B621107140282E7F17C807BE3FD0893CD4B0");
        waitframe();
        childthread smokeglvfx(level.givematchplacementchallenge);
      }
    }

    waitframe();
  }
}

smokeglvfx(var_0) {
  if(istrue(self.inlaststand) && !istrue(self.players_monitor)) {
    self.players_monitor = 1;
    childthread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_84C11B4608015B8059D6F92B63FD43EE5587C097A14519EFF931291955", 5);
    var_0 childthread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_963922A6B918B2B0EE4DE538E9A73498A85A9791FCB771DD2628CFD83369C32EC9B871DD", 5);
    wait 20;
    self.players_monitor = 0;
  }
}

givequestrewards(var_0) {
  for(var_1 = int(var_0); var_1 > -1; var_1--) {
    self setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", var_1);
    wait 1;
  }
}

give_super_ammo_after_loadout_given(var_0) {
  if(isDefined(level.givematchplacementchallenge))
    return scripts\engine\utility::within_fov(level.givematchplacementchallenge getEye(), level.givematchplacementchallenge getplayerangles(), var_0, 0.8);
  else
    return 0;
}

supersupplydropbeginuse() {
  level.train_elements_disable = getdvarint("_encstr_BAD51AB3EA1378C8D2972767EFFCE8B517B28E39B28329202E940379", 0);

  for(var_0 = 1; var_0 < 4; var_0++) {
    var_1 = scripts\engine\utility::getStruct("_encstr_8C6F07548064F3196E" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = scripts\cp\laser_traps\cp_laser_traps::trial_active_fob(var_1.origin, var_1.angles, ::trial_end_time);
    level._id_11F7E["_encstr_8C6F07548064F3196E" + var_0] = var_2;

    switch (var_0) {
      case 1:
        var_2.helis_assault3_hangar = 1;
        var_2.icon = "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1";
        break;
      case 2:
        var_2.helis_assault3_hangar = 2;
        var_2.icon = "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98";
        break;
      case 3:
        var_2.helis_assault3_hangar = 4;
        var_2.icon = "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3";
        break;
    }

    var_2._id_11F64 = scripts\cp\cp_objectives::requestworldid("_encstr_8C6F07548064F3196E" + var_0, 10);
    objective_setdescription(var_2._id_11F64, &"_encstr_97761EF9E1314F048FB9D8A3491F2C6FED68099108DE09BCDFB258AB6613F5E1");
    objective_setlabel(var_2._id_11F64, &"_encstr_926F132692712794277719293F114C67B88D255DFD");
    objective_setplayintro(var_2._id_11F64, 1);
    objective_setplayoutro(var_2._id_11F64, 0);
    objective_position(var_2._id_11F64, var_1.origin + (0, 0, 15));
    objective_icon(var_2._id_11F64, var_2.icon);
    objective_state(var_2._id_11F64, "_encstr_AF5A081BBAC993AC73A3");
  }

  setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 1);
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 2);
}

trial_end_time(var_0, var_1) {
  var_2 = 0;
  level.player playlocalsound("_encstr_8A2A10977041BFC5636FF3199B432E681BB0");

  if(level.train_elements_disable == 0) {
    var_2 = 1;
    thread _id_12758("_encstr_BD46283287EB8D0EE6F5D60BB5587DB91699B20DBDBACD957DA537D1B21BF53B853A34B24EAC19F5C40C");
  }

  level._id_11F7E = scripts\engine\utility::array_remove(level._id_11F7E, var_1);
  level.train_elements_disable = level.train_elements_disable | var_1.helis_assault3_hangar;
  level notify("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A");
  level._id_11B4D = 2;
  objective_state(var_1._id_11F64, "_encstr_8267056410C669");
  thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_9BE01C6E39E197A71FC3651CC1D7A836E4DE6B35CDF8A799951933B3DD47", "_encstr_9A8507BA4040188D08", 8);

  if(!var_2) {
    if(level.train_elements_disable == 7)
      thread _id_12758("_encstr_B6922971C061D8972F51D33BCB33D840403693E94CD560536BCA4EE333DF0680D184174FE1FD78256FC2AD");
    else
      thread _id_12758("_encstr_8B46288AC2605FCA405F83912308D9D797F912D288CD47C7491B8E8CDB4891FFCF133A8AB3ADD3B11AD1");
  }
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

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
    var_1 delete();
    break;
  }
}

subway_fast_travel_teleport_data() {
  scripts\engine\utility::flag_init("_encstr_A3E6105D90C85AB1EE43F0E8FE9F58F82589");

  while(level.train_elements_disable < 7)
    level waittill("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A");

  var_0 = scripts\engine\utility::getStruct("_encstr_8A12060D5BA9C745", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_11F7E["_encstr_8A12060D5BA9C745"] = var_0;
  var_0._id_11F64 = scripts\cp\cp_objectives::requestworldid("_encstr_8A12060D5BA9C745", 10);
  objective_setdescription(var_0._id_11F64, &"_encstr_8840202139E9E7AC371170FB317774D702F0B9D950315F243F76EF41DF8FBE5DBCC8");
  objective_setlabel(var_0._id_11F64, &"_encstr_A101171A05D735E9AF8227A42BA02197D31249AF2A2CC8A431");
  objective_setplayintro(var_0._id_11F64, 1);
  objective_setplayoutro(var_0._id_11F64, 0);
  objective_position(var_0._id_11F64, var_0.origin + (0, 0, 15));
  objective_icon(var_0._id_11F64, "_encstr_B4B922700AE59DAE9731EB6707D7B06141C39880423E21A15F54FB5DF42B196F769AB868");
  objective_state(var_0._id_11F64, "_encstr_AF5A081BBAC993AC73A3");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 5);
  var_0 _id_11A9A(&"_encstr_A396199F1B89BAE13996312C3928119057AFDF5D1004F1889781C8");
  scripts\engine\utility::flag_set("_encstr_A3E6105D90C85AB1EE43F0E8FE9F58F82589");
  thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_96511AA10AFAA9A7F50A9C526550847990D31344F56296D789E9933A", "_encstr_9A8507BA4040188D08", 8);
  thread _id_12758("_encstr_BADA1D7079095B386FE6E28659C797F2A902E0D14033ABE758072B1A3143F2");
  objective_setdescription(var_0._id_11F64, &"_encstr_96511AA10AFAA9A7F50A9C526550847990D31344F56296D789E9933A");
  objective_setlabel(var_0._id_11F64, &"_encstr_A797157ECA297F3C8FCFB1F1D7E994CF84A5417591F095");
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 6);
  var_1 = scripts\engine\utility::getStruct("_encstr_A6740DED18FB48B1B94330B86ACE79", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  magicgrenademanual("_encstr_A9AF1246CAC1367B2FAF0B969CC8C9DB07AFD683", var_1.origin, (0, 0, 0), 0.01);
  wait 10;
  var_2 = scripts\common\utility::getvehiclespawner("_encstr_BA2A0B59C3994B8DAF0DAC364B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in scripts\engine\utility::getStructArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF")) {
    var_4 scripts\cp\laser_traps\cp_laser_traps::add_spawn_function(::_id_11A8F);

    if(isDefined(var_4.speed)) {
      for(var_5 = var_4; isDefined(var_5.target); var_5 = scripts\engine\utility::getStruct(var_5.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF")) {
        if(isDefined(var_5.speed)) {
          var_5.speed = var_5.speed / 2;
          continue;
        }

        var_5.speed = 15;
      }
    }
  }

  var_7 = var_2 scripts\common\vehicle::spawn_vehicle_and_gopath();
  var_7 vehicleshowonminimap(1);
  var_7 aiupdatecoverexposetype(1);
  var_7 scripts\common\vehicle::godon();
  var_7 waittill("_encstr_AC26197DFDCE88BB1FC296F9FBDBE72064539FF161F39868277A09");
  var_7 setvehgoalpos(var_7.origin + (0, 0, 30), 1);
  var_7 sethoverparams(5);
  thread _id_142DD();
  objective_setdescription(var_0._id_11F64, &"_encstr_8D0519D0147D9A3DD7A03952B214425E9454053442BE2A16325298");
  objective_setlabel(var_0._id_11F64, &"_encstr_A101171A05D735E9AF8227A42BA02197D31249AF2A2CC8A431");
  createnavobstaclebyent(var_7);
  wait 3.0;

  while(!brevent1playerthink(var_7.origin, 150))
    waitframe();

  level notify("_encstr_B2200FB2C399D236D76CF6DA381BCA472B");
  wait 1.5;
  thread _id_12758("_encstr_9B611A8C1911B5334716235B9B2957EF488B05036998BB2F600B6AF2");
}

_id_11A8F() {
  self.ignoreme = 1;
  self setCanDamage(0);
  self setCanRadiusDamage(0);

  for(;;) {
    self.health = 10000;
    self waittill("_encstr_B2BE0788BAF573592F");
  }
}

_id_142DD() {
  level endon("_encstr_B2200FB2C399D236D76CF6DA381BCA472B");
  var_0 = 1;

  for(;;) {
    if(var_0)
      _id_12758("_encstr_A30A2C9B2399511A20A926ED6CAAB812388BF7113B3388ED707331BF390528C8EB93F90390963A87D82A8B2929DB");
    else
      _id_12758("_encstr_99A02A1428C12D9F983FC60303F55FF50BBF7005D35A0704834F16C27AEDC833BBF1D458FFC17DACC39F495D");

    var_0 = !var_0;
    wait 10.0;
  }
}

bomb_vest_controller_holder() {
  level.select_equipment_spawners = scripts\engine\math::remap(level.hostdamagefactorlow, 1, 4, 600, 800);
  level.select_hostage_room_one_spawners = scripts\engine\math::remap(level.hostdamagefactorlow, 1, 4, 1000, 1200);
  level.select_chopper_boss_target_player = scripts\engine\math::remap(level.hostdamagefactorlow, 1, 4, 1500, 1700);
  level.select_cliff_one_spawners = scripts\engine\math::remap(level.hostdamagefactorlow, 1, 4, 2000, 2200);
}

bomb_vest_detonator_control_think(var_0) {
  wait 0.1;
  self setthreatbiasgroup("_encstr_86190E3BC9B7D537C8BE8EE4B7DE83CD");

  switch (self.agent_type) {
    case "_encstr_A278229E76213AA23EF05B7F98D25722C1806655E7CFC2FDC3E81323F14B28AA9124EB4D":
      self.goalradius = level.select_equipment_spawners;
      break;
    case "_encstr_86CC1E10E9ABBA652999B67722CBD79F28E9929A775F31559FC13BACE603E901":
      self.goalradius = level.select_hostage_room_one_spawners;
      break;
    case "_encstr_82581D851BD1BD93D79573B26B2FF51B83FA0BC6B8BE91AC372B4E1DD7B09C":
      self.goalradius = level.select_chopper_boss_target_player;
      break;
    default:
      self.goalradius = level.select_cliff_one_spawners;
      break;
  }

  if(!getdvarint("_encstr_BAE417EE8E73EF21383FA0485753F8D10A396EFB65AB792902", 0) && scripts\engine\utility::is_equal(level.givematchplacementchallenge, var_0))
    var_1 = scripts\engine\utility::random(scripts\engine\utility::array_remove(level.players, var_0));
  else
    var_1 = var_0;

  self setgoalentity(var_1, 1);
  thread blueprintextract_cleanupwhennoavailablelocales();
  self waittill("_encstr_AD75063D571AE108", var_2);
  thread _id_123D5(var_2, scripts\engine\utility::array_combine(level.giveplayerpoints, level.givepointsandxp));
  var_0 notify("_encstr_86480B43E6DFE8C3073240C91A");
}

blueprintextract_cleanupwhennoavailablelocales(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0)) {
    while(!(level.train_elements_disable &var_0))
      level waittill("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A");
  }

  for(;;) {
    wait(randomintrange(5, 16));

    if(!give_super_ammo_after_loadout_given(self.origin) && !c130_door_badplace_id(self.origin, 2500)) {
      self.nocorpse = 1;
      self kill();
    }
  }
}

bonustimeapplied(var_0) {
  self setthreatbiasgroup("_encstr_AD580CDA8088C50E135328F0CBB3");
  thread bomb_case_detonator_wire_color_change_think();
  thread blueprintextract_cleanupwhennoavailablelocales();
  self waittill("_encstr_AD75063D571AE108", var_1);
  thread _id_123D5(var_1, scripts\engine\utility::array_combine(level.giveplayerpoints, level.givepointsandxp));
  var_0 notify("_encstr_A1E40D8D0F318947B0609793D14927");
}

bomb_case_detonator_wire_color_change_think() {
  self endon("_encstr_AD75063D571AE108");
  self.favoriteenemy = level.choppergunners[0];
  self waittill("_encstr_938C091AC8B8AFFB036D37");
  _id_123F4();
}

gatherstadiumlocs(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  return level.openangles.size + var_0 < level._id_11B46;
}

bot_add_landing_spot(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(isDefined(var_1)) {
    var_5 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    while(!(level.train_elements_disable &var_3) && !c130_door_badplace_id(var_5.origin, var_2))
      scripts\engine\utility::waittill_notify_or_timeout("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A", 1.0);

    if(var_1 == "_encstr_92A608F832037DA811F3")
      wait 1.0;
  }

  var_6 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_8 in var_6) {
    while(!gatherstadiumlocs())
      wait 0.1;

    var_9 = var_8 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(isDefined(var_9) && isalive(var_9)) {
      var_9 thread bomb_case_detonator_control_think();
      var_9 thread blueprintextract_cleanupwhennoavailablelocales(var_4);
    }

    wait 0.1;
  }

  if(var_0 == "_encstr_A9E50E60F83C37FC6F429F5743AB3B8F") {
    var_11 = [];
    var_11[0] = init_for_final_sequence((3104.26, 405.641, 418), (0, 270, 0));
    var_11[1] = init_for_final_sequence((3339.29, 650.742, 555.381), (0, 360, 0));
    var_11[2] = init_for_final_sequence((3637.31, -479.099, 437.43), (0, 134.999, 0));
    var_11 = scripts\engine\utility::array_randomize(var_11);
    var_12 = clamp(getdvarint("_encstr_A70E1A3AD7DBB6D6FB8F336891AA03A1019BBB429807B3B8F28304DF", 0), 0, var_11.size);

    if(var_12 <= 0) {
      if(isDefined(level.givematchplacementchallenge))
        var_13 = scripts\engine\utility::array_remove(level.players, level.givematchplacementchallenge);
      else
        var_13 = level.players;

      var_12 = clamp(var_13.size, 1, var_11.size);
    }

    while(!c130_door_badplace_id(var_5.origin, 900))
      wait 0.1;

    for(var_14 = 0; var_14 < var_12; var_14++) {
      while(!gatherstadiumlocs())
        wait 0.1;

      var_9 = var_11[var_14] scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
      wait 0.1;
      var_9 thread bomb_case_detonator_control_think();
      var_9 thread bomber_death_watcher();
    }
  }
}

init_for_final_sequence(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.angles = var_1;
  var_2.count = 0;
  var_2.model = "_encstr_86EE131F41AC6AEA882151E4DB5007027EE5AFCFE1";
  var_2.script_count = 0;
  var_2.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_2.script_dist_only = 0;
  var_2.script_dot = 0.0;
  var_2.script_escalation_level = 0;
  var_2.script_forcespawn = 0;
  var_2.script_goalheight = 0;
  var_2.script_noteworthy = "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
  var_2.script_origin_other = (0, 0, 0);
  var_2.script_radius = 0;
  var_2.script_reuse_max = 0.0;
  var_2.script_speed = 0;
  var_2.script_team = "_encstr_8E8405EA382B2A";
  var_2.script_timeout = 0.0;
  var_2.script_type = "_encstr_A1C91E665198571380E39B8FCBBB0993603E5AEBCB69EA3BE48FBFDB256F93DC";
  return var_2;
}

bomber_death_watcher() {
  self endon("_encstr_AD75063D571AE108");
  setmusicstate("_encstr_9B03144F77D1D2ABE76911ABFD69D8B3E17F3E2B7E28");
  childthread vehicle_mp_deletenextframelate();
  self.stuncooldown = 0;
  self.allowpain = 0;
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
  scripts\cp\laser_traps\cp_laser_traps::disable_surprise();

  if(level.gameskill <= 2)
    self.juggernautstopdistance = 500;
  else
    self.juggernautstopdistance = 600;

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

bomb_case_detonator_control_think() {
  self setthreatbiasgroup("_encstr_86190E3BC9B7D537C8BE8EE4B7DE83CD");
  level.openangles[level.openangles.size] = self;
  self waittill("_encstr_AD75063D571AE108", var_0);
  thread _id_123D5(var_0, scripts\engine\utility::array_combine(level.giveplayerpoints, level.givepointsandxp));
  level.openangles = scripts\engine\utility::array_remove(level.openangles, self);
}

bot_can_switch_to_attacker() {
  thread bomb_case_detonator_control_think();
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_B4350A0AAB73BA371120E5FC");

  switch (self.agent_type) {
    case "_encstr_A278229E76213AA23EF05B7F98D25722C1806655E7CFC2FDC3E81323F14B28AA9124EB4D":
      self.goalradius = level.select_equipment_spawners;
      break;
    case "_encstr_86CC1E10E9ABBA652999B67722CBD79F28E9929A775F31559FC13BACE603E901":
      self.goalradius = level.select_hostage_room_one_spawners;
      break;
    case "_encstr_82581D851BD1BD93D79573B26B2FF51B83FA0BC6B8BE91AC372B4E1DD7B09C":
      self.goalradius = level.select_chopper_boss_target_player;
      break;
    default:
      self.goalradius = level.select_cliff_one_spawners;
      break;
  }

  var_0 = scripts\engine\utility::getclosest(self.origin, level.players);
  self setgoalentity(var_0, 1);
  thread blueprintextract_cleanupwhennoavailablelocales();
}

_id_13649() {
  if(!isDefined(self.waittill_interrogation_dialogue_or_timeout))
    return 0;

  return gettime() - self.waittill_interrogation_dialogue_or_timeout < 10000;
}

stoppingpower_clearhcrongameended() {
  level.set_flag_via_event_structs = scripts\engine\utility::getStructArray("_encstr_B21A0DCEE4DBAE3719F5561E335AC6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_12D8A = scripts\engine\utility::getStructArray("_encstr_88760B3A9730D72FE55202FAF8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.set_flag_via_event_structs = scripts\engine\utility::array_combine(level.set_flag_via_event_structs, scripts\engine\utility::getStructArray("_encstr_B28F0FB393EDD5B932BE2DDC8E9536EB13", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  level.set_flag_via_event_structs = scripts\engine\utility::array_combine(level.set_flag_via_event_structs, scripts\engine\utility::getStructArray("_encstr_B48F0F4FDBE8E56AB53FDFCB81ED9217AA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  level._id_12D8A = scripts\engine\utility::array_combine(level._id_12D8A, scripts\engine\utility::getStructArray("_encstr_8D9E0DC9DBF6997DD23747CAB1EB91", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  level.set_flag_via_event_structs = scripts\engine\utility::array_combine(level.set_flag_via_event_structs, scripts\engine\utility::getStructArray("_encstr_B68F0FD9277BEAE6C8F5B4B947ACB1FA33", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  level._id_12D8A = scripts\engine\utility::array_combine(level._id_12D8A, scripts\engine\utility::getStructArray("_encstr_A59E0D27B7BD66D7D2733A5963D7CC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  var_0 = scripts\engine\utility::getStruct("_encstr_A9AE1276E4BDBA738CAF4BE61DCAB1D713AF1381", "_encstr_A16007A921A23B85E3");
  var_0.origin = var_0.origin + (0, 0, 30);

  foreach(var_2 in scripts\engine\utility::getStructArray("_encstr_A9AE1276E4BDBA738CAF4BE61DCAB1D713AF1381", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"))
  var_2.origin = var_2.origin + (0, 0, 30);

  var_0 = scripts\engine\utility::getStruct("_encstr_BD1D11DF5DC0E37BF526423A6B5D4BD18A9F05", "_encstr_A16007A921A23B85E3");
  var_0.origin = (3792.98, -240.453, 421.175);
  var_0.angles = (0, 151.019, 0);
  var_4 = [(3758.22, -263.405, 421.175), (3748.75, -239.547, 421.175), (3776.37, -211.444, 421.175)];
  var_5 = [(0, 106.019, 0), (0, 151.019, 0), (0, 196.019, 0)];

  foreach(var_7, var_2 in scripts\engine\utility::getStructArray("_encstr_BD1D11DF5DC0E37BF526423A6B5D4BD18A9F05", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")) {
    var_2.origin = var_4[var_7];
    var_2.angles = var_5[var_7];
  }

  var_0 = scripts\engine\utility::getStruct("_encstr_871D113B93BD57378CFA2D9B472B36BECCBEA1", "_encstr_A16007A921A23B85E3");
  var_0.origin = (3796.9, 148.39, 422.785);
  var_0.angles = (0, 199.503, 0);
  var_4 = [(3791.04, 107.149, 422.785), (3766.9, 115.867, 422.785), (3764.17, 155.183, 422.785)];
  var_5 = [(0, 154.503, 0), (0, 199.503, 0), (0, 244.502, 0)];

  foreach(var_7, var_2 in scripts\engine\utility::getStructArray("_encstr_871D113B93BD57378CFA2D9B472B36BECCBEA1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")) {
    var_2.origin = var_4[var_7];
    var_2.angles = var_5[var_7];
  }
}

_id_134ED(var_0, var_1) {
  self.waittill_interrogation_dialogue_or_timeout = gettime();
  self.count = 1;
  self.script_moveoverride = 1;
  var_2 = scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
  var_2 thread[[var_1]](var_0);
  var_3 = [var_2];
  var_2.script_noteworthy = "_encstr_A123070F0B327D488F" + self.targetname + "_encstr_92480869F853CE0321BE";
  wait 0.1;
  var_4 = scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_6 in var_4) {
    var_6.count = 1;
    var_2 = var_6 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
    var_2 thread[[var_1]](var_0);
    var_3[var_3.size] = var_2;
    var_2.script_noteworthy = "_encstr_A123070F0B327D488F" + self.targetname + "_encstr_BA4C02DF" + self.script_noteworthy;
    wait 0.1;
  }

  return var_3;
}

setup_bot_arena() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.nexthealthtiercalledout = [];
  var_0 = 5;
  self.track_get_reward_time_string = 1000;
  self._id_1215A = 2000;
  self.hostage_carrier_oob = cos(90);

  for(;;) {
    while(level._id_11F7E.size == 0)
      wait 0.1;

    var_1 = self.origin;

    if(scripts\engine\utility::is_equal(level.givematchplacementchallenge, self)) {
      var_2 = self getEye();
      var_1 = (var_2[0], var_2[1], 0);
    }

    var_3 = scripts\engine\utility::getclosest(var_1, level._id_11F7E);
    var_4 = var_3.origin - var_1;
    var_5 = [];
    var_6 = [];

    foreach(var_8 in level.set_flag_via_event_structs) {
      if(!var_8 _id_13649()) {
        if(scripts\engine\utility::is_equal(var_8.script_parameters, "_encstr_9A87073A50B8188CB8") || !give_super_ammo_after_loadout_given(var_8.origin)) {
          if(scripts\engine\math::within_fov_2d(var_1, vectortoangles(var_4), var_8.origin, self.hostage_carrier_oob)) {
            var_9 = distance2d(var_1, var_8.origin);

            if(!c130_door_badplace_id(var_8.origin, self.track_get_reward_time_string)) {
              if(var_9 < self._id_1215A)
                var_6[var_6.size] = var_8;
              else
                var_5[var_5.size] = var_8;
            }
          }
        }
      }
    }

    if(var_5.size > 0) {
      var_5 = scripts\engine\utility::array_randomize(var_5);
      self.nexthealthtiercalledout[self.nexthealthtiercalledout.size] = var_5[0] _id_134ED(self, ::bomb_vest_detonator_control_think);
    }

    if(var_6.size > 0) {
      var_6 = scripts\engine\utility::array_randomize(var_6);
      self.nexthealthtiercalledout[self.nexthealthtiercalledout.size] = var_6[0] _id_134ED(self, ::bomb_vest_detonator_control_think);
    }

    if(self.nexthealthtiercalledout.size >= level._id_11B47) {
      while(self.nexthealthtiercalledout.size > 0) {
        self waittill("_encstr_86480B43E6DFE8C3073240C91A");
        var_11 = [];

        foreach(var_14, var_13 in self.nexthealthtiercalledout) {
          self.nexthealthtiercalledout[var_14] = scripts\engine\utility::array_removedead_or_dying(var_13);

          if(self.nexthealthtiercalledout[var_14].size != 0)
            var_11[var_11.size] = self.nexthealthtiercalledout[var_14];
        }

        self.nexthealthtiercalledout = var_11;
      }

      wait(var_0);
    }

    wait 0.1;
  }
}

setup_crates_to_mark() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = 3;
  self._id_12D85 = [];

  for(;;) {
    while(level._id_11F7E.size == 0)
      wait 0.1;

    var_1 = self getEye();
    var_1 = (var_1[0], var_1[1], 0);
    var_2 = [];

    foreach(var_4 in level._id_12D8A) {
      if(!var_4 _id_13649() && !give_super_ammo_after_loadout_given(var_4.origin)) {
        var_5 = distance2d(var_1, var_4.origin);

        if(var_5 > 2000)
          var_2[var_2.size] = var_4;
      }
    }

    if(var_2.size >= level._id_11B4D) {
      var_2 = scripts\engine\utility::array_randomize(var_2);

      for(var_7 = 0; var_7 < level._id_11B4D; var_7++)
        self._id_12D85[self._id_12D85.size] = var_2[var_7] _id_134ED(self, ::bonustimeapplied);
    }

    if(self._id_12D85.size >= level._id_11B4D) {
      while(self._id_12D85.size > 0) {
        self waittill("_encstr_A1E40D8D0F318947B0609793D14927");
        var_8 = [];

        foreach(var_11, var_10 in self._id_12D85) {
          self._id_12D85[var_11] = scripts\engine\utility::array_removedead_or_dying(var_10);

          if(self._id_12D85[var_11].size != 0)
            var_8[var_8.size] = self._id_12D85[var_11];
        }

        self._id_12D85 = var_8;
      }

      if(var_0 == 3 && level.train_elements_disable & 4)
        var_0 = 1.5;

      wait(var_0);
    }

    wait 0.1;
  }
}

setup_heli_starts() {
  while(!(level.train_elements_disable & 2))
    level waittill("_encstr_AAE610E842BB6320CFDB08F1BC4F8919A74A");

  var_0 = scripts\common\utility::getvehiclespawnerarray("_encstr_A5D60C8EE4EAC6ADF53707C2DDE6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 = scripts\engine\utility::array_randomize(var_0);

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getStructArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_5 in var_3)
    var_5 scripts\cp\laser_traps\cp_laser_traps::add_spawn_function(::bot_can_switch_to_attacker);

    while(!gatherstadiumlocs(4))
      wait 0.5;

    var_7 = var_2 scripts\common\vehicle::spawn_vehicle_and_gopath();
    var_7 thread _id_13DEA();
  }

  wait 6.0;

  if(randomint(100) > 50)
    _id_12758("_encstr_AD6C2B321EF51B07E6BEADB06BC2D7B116B1C6BDD5A3AF3AACC60D73B4D8851B6EEBE6E0C2BBB9B49BB3AF2606");
  else
    _id_12758("_encstr_BD6C2B0A42E0DF4AC0DF0311A3885917173802224BCD7703188F081643B09E5346F60B5B51247BBC78FF07B2C9");

  wait 1.0;

  if(isDefined(level.givematchplacementchallenge)) {
    level.givematchplacementchallenge.waittill_player_deposits = gettime();
    _id_12450("_encstr_B1352AC2FB59CD48E719E9A0D1303173101948E3A1B33B77D49F376045320169E6D6AE3F936AC6A39FD6DFEF");
  }
}

_id_13DEA() {
  self.nodeath = 1;
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(self);
  var_0 = loadfx("_encstr_93512A9CCE4B48776D9BE8B282C00978BE7CAF1627C78E95D722F0C82A5F9F91BB08A1B7AB5FF09DEDEB8018");
  var_1 = loadfx("_encstr_87473BEB025BD20833BAF65B223805E8B2ADFFC7D44032B3258E9F40685FB219493E5516C3E17C82A1318B82231F4EE958DBC7DF6B113B5DF1426BB6E3");
  thread _id_13DE8();
  self waittill("_encstr_AD75063D571AE108", var_2);

  if(self.model == "_encstr_B8D414D0EB63CBEFFDA31BD0AC3838B7E3A8B201A07E")
    self setModel("_encstr_ABCF1F9D561A83F5ADB463BE36B991AF1C2DDCC8A516EB6E8E0BD1D2B1FA8C9BD1");
  else
    self setModel("_encstr_99B223B8D87A806F387C62E792F82489A7C0200CAB5B982063D9E02B7FEF28D393D133DA79");

  var_3 = anglesToForward(self.angles);
  var_4 = anglestoup(self.angles);
  playFX(var_0, self.origin, var_3, var_4);
  thread _id_123D5(var_2, scripts\engine\utility::array_combine(level.giveplayerpoints, level.givequest));
  wait 1.0;
  playFX(var_1, self.origin + var_3 * 20 + var_4 * 10, var_3, var_4);
}

_id_13DE8() {
  self endon("_encstr_AD75063D571AE108");
  self vehicleshowonminimap(1);
  self aiupdatecoverexposetype(1);
  wait 1.0;
  self setwaitspeed(0);
  self waittill("_encstr_83F31382ADE312408110479F407814999FBFCFFF85");
  wait 1.0;
  self vehicleshowonminimap(0);
}

setup_enemytype_on_spawner() {
  scripts\engine\utility::flag_wait("_encstr_A3E6105D90C85AB1EE43F0E8FE9F58F82589");
  var_0 = getEntArray("_encstr_81A3097CCB78D46FA6F0E2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\common\utility::getvehiclespawnerarray("_encstr_AB530B8E5873DAFAE6E016779B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::array_randomize(var_1);

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\common\vehicle::spawn_vehicle_and_gopath();
    var_5 = scripts\engine\utility::getclosest(var_3.origin, var_0);
    var_4.helimakeexfilwait = var_5;

    if(distance2d(var_5.origin, (-336.514, 2708.69, 254)) < 200)
      var_5.angles = var_5.angles + (0, -45, 0);

    var_5.origin = var_4.origin + (0, 0, 60);
    var_5 linkTo(var_4);
    var_4 thread _id_13A4E();
  }

  wait 6.0;

  if(randomint(100) > 50)
    _id_12758("_encstr_BE1E254C0B08D80B02477A991551778F27B17BED0B8C2789309287E65B822684626878FA198B43");
  else
    _id_12758("_encstr_AF1E25ACFB2E4FA25F491AB2F05351F741693C2F959377EB23B80269188916EFD843B6DF383392");

  wait 1.0;

  if(isDefined(level.givematchplacementchallenge)) {
    level.givematchplacementchallenge.waittill_player_deposits = gettime();
    var_7 = randomint(100);

    if(level.givematchplacementchallenge.playapacheonly_dialogue && var_7 > 66)
      _id_12450("_encstr_81352A1703699EB0C881A880928B4F2A7C942D5F74EB901B370F8E62426A98AB43FEA2BD252A0B3357D393DB");
    else if(level.givematchplacementchallenge.playapacheonly_dialogue && var_7 > 33)
      _id_12450("_encstr_84352A8DB8BF0B179521D060FAEABF60BF4401FE2CA3D1537C49C8A8F202D9F9BBCF1E789D9B19B1A9870272");
    else
      _id_12450("_encstr_AC352AB81B494D481FEF0787A913363FACC270B873DA93412FC71EF38F3B1BFBD29990D01A76D3BB27B3BFD7");
  }
}

_id_13A4E() {
  self setModel("_encstr_9B101CEC59D0E0D7B5B4C6AFB17346AF672D9BC84B58EBB026D7DD2BCDA3");
  self.mainturret setModel("_encstr_A71D23D83A74019ECFE9B120F41B21075B4290D0924E97119637452DC20349E9C94B70E0DB");
  self.mainturret makeunusable();
  self makeunusable();
  self.nodeath = 1;
  self vehicleshowonminimap(1);
  self aiupdatecoverexposetype(1);
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(self);
  scripts\common\vehicle::godoff();
  self.mgturret[0] setmode("_encstr_849007B268BD03DFD8");
  self.mgturret[0] makeunusable();
  self.mgturret[0] hide();
  var_0 = loadfx("_encstr_AA192D67660F792DEE83F55B1C79D64B8D36DCE89356C2D697D9CCF0FA4758CDB5D7235916E8D0D7560F1CC5D966E1");
  var_1 = loadfx("_encstr_8CEA2B35BEC8AA7B174756D9AB1EAD182411B9B76FF698A823FBE88152B7F0E07E663F77DBDD188A8F160369FB");
  thread _id_13A3D();
  thread _id_13A43();
  thread _id_13A44();
  thread _id_13A3F();
  self waittill("_encstr_AD75063D571AE108", var_2);
  self setModel("_encstr_95C5204E8538D2F9F368DAE168DDEF97137BAED42BA1073E33C1535A68316933EB5D");
  var_3 = anglesToForward(self.angles);
  var_4 = anglestoup(self.angles);
  playFX(var_0, self.origin, var_3, var_4);

  if(!isDefined(level._id_13A42))
    level._id_13A42 = 0;

  level._id_13A42++;

  if(level._id_13A42 < 4)
    thread _id_123D5(var_2, scripts\engine\utility::array_combine(level.giveplayerpoints, level.givequest));
  else {
    var_5 = ["_encstr_9B9F280B6938F3FFE06E266A41E007FA8BE993DFE9D68AA9E8765E74B8B85052DE772F43B3F0035F52B3", "_encstr_A39F2839A8E7080812B7133967EB58587905A053531258372ACF0F31471317601A51898BBD67B8E0575A", "_encstr_9B9F280B6938F3FFE06E266A41E007FA8BE993DFE9D68AA9E8765E74B8B85052DE772F43B3F0035F42B3"];
    thread _id_123D5(var_2, var_5, 1);
  }

  wait 4.0;
  playFX(var_1, self.origin, var_3, var_4);
}

_id_13A3D() {
  self endon("_encstr_AD75063D571AE108");
  self setwaitspeed(0);
  scripts\engine\utility::_id_143A5("_encstr_83F31382ADE312408110479F407814999FBFCFFF85", "_encstr_B2BE0788BAF573592F");
  self.mainturret.maxrange = 3000;
  self.mainturret turretfireenable();
  self.mainturret startfiring();
  var_0 = cos(10);

  for(;;) {
    while(!_id_13E6F(var_0))
      wait 0.1;

    while(_id_13E6F(var_0)) {
      for(var_1 = 0; var_1 < randomintrange(3, 5); var_1++) {
        self.mainturret shootturret();
        wait(randomfloatrange(0.3, 0.6));
      }

      wait(randomintrange(3, 6));
    }
  }
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

_id_13A40(var_0, var_1, var_2) {
  var_3 = undefined;

  if(cave_initial_enemy_goto_struct_on_spawn_and_wait_till_seen(var_1))
    var_3 = level.givematchplacementchallenge;
  else if(scripts\engine\utility::array_contains(level.players, var_1) && isDefined(var_2) && (var_2 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_2 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_2 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F") || var_2 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B")
    var_3 = var_1;

  if(isDefined(var_3) && isPlayer(var_3)) {
    if(isDefined(var_0)) {
      var_3 setclientomnvar("_encstr_923E15B9113560D4F7A999E112AB1E28CE63473BBB1DC0", "_encstr_A5AE098ADB583E0AF7A5AB");
      var_3 setclientomnvar("_encstr_92E710499EA5C07C82A72D2367BA361843F4", "_encstr_A5AE098ADB583E0AF7A5AB");
      var_3 setclientomnvar("_encstr_84E21C0A61F9D78F70DF0E15B3A0161F16D831428940B3C9409714115D60", gettime());
      var_3 setclientomnvar("_encstr_8CD4175A10C34E8FA1A8669D5D69539607E85172F89904D31A", gettime());
      var_3 setclientomnvar("_encstr_AB9311F5E851613F47F087E54E97D0B850CDED", int(var_0));

      if(var_0 >= self.health - self.healthbuffer)
        var_3 setclientomnvar("_encstr_B62E15F14FBDF9279D174395F76140FF80DAB9A2830475", 1);
      else
        var_3 setclientomnvar("_encstr_B62E15F14FBDF9279D174395F76140FF80DAB9A2830475", 0);
    }
  }
}

_id_13A45(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0)) {
    if(var_0.basename == "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8") {
      self dodamage(var_1, var_3, var_2, var_4, var_5, var_0, var_6);
      wait 0.1;
    }

    if(issubstr(var_0.basename, "_encstr_AC190457A459") && isDefined(var_5) && (var_5 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_5 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_5 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B")) {
      self dodamage(var_1 * 3, var_3, var_2, var_4, var_5, var_0, var_6);
      wait 0.1;
    }
  }
}

_id_13A43() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    childthread _id_13A40(var_0, var_1, var_4);
    _id_13A45(var_9, var_0, var_1, var_3, var_13, var_4, var_10);
  }
}

_id_13A44() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self.mainturret waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    childthread _id_13A40(var_0, var_1, var_4);
    _id_13A45(var_9, var_0, var_1, var_3, var_13, var_4, var_10);
  }
}

cave_initial_enemy_goto_struct_on_spawn_and_wait_till_seen(var_0) {
  if(isDefined(level.givematchplacementchallenge) && isDefined(level.choppergunners) && isDefined(level.choppergunners[0]) && isDefined(level.choppergunners[0].turret)) {
    if(level.givematchplacementchallenge == var_0)
      return 1;

    if(scripts\engine\utility::is_equal(level.choppergunners[0], var_0))
      return 1;

    if(scripts\engine\utility::is_equal(level.choppergunners[0].turret, var_0))
      return 1;
  }

  return 0;
}

_id_13E6F(var_0) {
  foreach(var_2 in level.players) {
    if(!scripts\engine\utility::is_equal(var_2, level.givematchplacementchallenge)) {
      if(scripts\engine\math::within_fov_2d(self.mainturret gettagorigin("_encstr_A14F0AE336178944BA076F41"), self.mainturret gettagangles("_encstr_A14F0AE336178944BA076F41"), var_2.origin, var_0))
        return 1;
    }
  }

  return 0;
}

_id_13F26() {
  level notify("_encstr_AB2616F34590BBA19B18430AC88F63B769216DA7D4F967B5");
  level endon("_encstr_AB2616F34590BBA19B18430AC88F63B769216DA7D4F967B5");
  var_0 = 1;

  while(var_0) {
    wait 0.2;

    if(isDefined(level.givematchplacementchallenge))
      var_1 = scripts\engine\utility::array_remove(level.players, level.givematchplacementchallenge);
    else
      var_1 = level.players;

    var_0 = 0;

    foreach(var_3 in var_1) {
      if(isDefined(var_3) && !scripts\cp\cp_laststand::player_in_laststand(var_3) && var_3 scripts\cp_mp\utility\player_utility::_isalive())
        var_0 = 1;
    }
  }

  if(level.players.size == 1 && scripts\engine\utility::is_equal(level.players[0], level.givematchplacementchallenge))
    level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BD79059C51C351"]);
  else
    level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
}

c130_drop(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(level.givematchplacementchallenge) && var_3 == level.givematchplacementchallenge) {
      continue;
    }
    if(distancesquared(var_3.origin, var_0) <= var_1 * var_1)
      return 1;
  }

  return 0;
}

c130_door_badplace_id(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(level.givematchplacementchallenge) && var_3 == level.givematchplacementchallenge) {
      continue;
    }
    if(distance2dsquared(var_3.origin, var_0) <= var_1 * var_1)
      return 1;
  }

  return 0;
}

brevent1playerthink(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(level.givematchplacementchallenge) && var_3 == level.givematchplacementchallenge) {
      continue;
    }
    if(distance2dsquared(var_3.origin, var_0) > var_1 * var_1)
      return 0;
  }

  return 1;
}

black_screen(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.x = 0;
  var_2.y = 0;
  var_2.alignx = "_encstr_A5AD056A019C63";
  var_2.aligny = "_encstr_AC190479FF92";
  var_2.sort = 20;
  var_2.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_2.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_2.alpha = 1;
  var_2.foreground = 1;
  var_2 setshader("_encstr_83AB065EE1391A7B", 640, 480);
  var_2 endon("_encstr_AD75063D571AE108");
  wait(var_0);
  var_2 fadeovertime(var_1);
  var_2.alpha = 0;
  wait(var_1);
  var_2 destroy();
}

mud_sfx(var_0) {
  if(var_0 == "_encstr_8E8405EA382B2A")
    return 0;

  var_1 = 60000;

  if(level.time_survived < 3 * var_1)
    return 3;
  else if(level.time_survived < 6 * var_1)
    return 2;

  return 1;
}

bwasjuggernaut(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 0;

  for(;;) {
    foreach(var_4 in level.players) {
      if(scripts\engine\utility::is_equal(level.givematchplacementchallenge, var_4)) {
        continue;
      }
      if(var_4.origin[var_1] < var_0) {
        scripts\engine\utility::flag_set(var_2);
        return;
      }
    }

    wait 1;
  }
}