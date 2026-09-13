/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\globallogic.gsc
***********************************************/

init() {
  level._id_21E8A7768C0260F2 = _func_811510B694DDD963();
  level._id_1A2B600A06EC21F4 = _func_1E231FC15FDAB31D();
  level._id_62F6F7640E4431E3 = _func_90B5B6E99AEF29D6();
  level._id_55F7EC9F66F3468D = _func_79404C2FCCA1C184();
  thread _id_3FEEC618E51A6291::init_starts();
  scripts\cp\cp_anim::init();
  _id_3233DDE235C8D2F7();
  _id_6ADC128D1309D048();
  _id_303F9875F954E1C4();
  _id_B204B08F674548AB();
  _id_F6A78BBE53021BF8();
  _id_4361A652D4E6CC62();
}

_id_3233DDE235C8D2F7() {
  scripts\cp\utility::initgameflags();
  scripts\cp\utility::initlevelflags();
  _id_5588F0C4FF7058F1();
  init_global_cp_flags();
  _id_1284BFDE6C25B9CA();
  init_global_cp_script_funcs();
  level.struct_filter = ::cp_struct_filter;
  scripts\engine\utility::init_struct_class();
  scripts\engine\utility::flag_set("bsp_structs_initialized");
  delete_on_load();
  _id_04CDABCD91A92977::main();
  level thread _id_7280BABC254585B2();
}

_id_5588F0C4FF7058F1() {
  _id_A59D6B296A8381F6();
}

_id_A59D6B296A8381F6() {
  setDvar("dvar_9F60E77C0E91DA76", 180);
  setDvar("dvar_9F60E67C0E91D843", 180);
  setDvar("dvar_9F60E57C0E91D610", 180);
}

_id_CA96261E273D33C0(_id_E3108E412AFB3811) {
  level._id_3480ABEA6656FCE6 = _id_E3108E412AFB3811;
}

_id_8619B71F2573363B(_id_E3108E412AFB3811) {
  level._id_CEE48B761F8CA747 = _id_E3108E412AFB3811;
}

_id_B204B08F674548AB() {
  setomnvar("ui_hide_nameplates_for_zero_health", 0);
  _id_01E81309DCF11FAA();
  _id_FC091EC7A771F2FF();
  shellshock_init();
  _id_5C5D6F7B09D3C739();
  adjust_heartbeat_sensor_settings();
  _id_56585B89BE143A09();
  _id_E2FC4DEA9278CBD8();
  setup_callbacks();
  _id_248519CFCAF04C4A();
  _id_A75F0074296BA485();
  _id_BF4F95EC0DFF09AE();
  _id_44DAA9C20A1FD399();
  _id_1C2B32222A73294B();
  _id_CA96261E273D33C0(1);
  scripts\cp\utility::_id_7BB9F9B4DC700888();
}

_id_6ADC128D1309D048() {
  scripts\common\fx::initfx();
  scripts\common\exploder::setupexploders();
  scripts\common\create_script_utility::initialize_create_script();
  level thread scripts\engine\scriptable_door::system_init();
  scripts\common\utility::spawncorpsehider();
  level thread _id_0448EF4D9E70CE5E::main();
  level thread _id_61EB50466A589DEC::main();
  thread _id_7AB5B649FA408138::_id_6DCA6F439CA0A74F();
  _id_6BFE39BD5C12F84A::main(_id_41A5F0BF29408720::_id_764239E6A246C46A);
}

_id_4361A652D4E6CC62() {
  create_player_threatbias_groups();
  scripts\cp\cp_gameskill::init_gameskill();
  _id_6B18C507926DD700::_id_E39F8BC855EE1D4E();
  level thread scripts\cp\cp_movers::main();
  level thread _id_3ADFC798ED499F31::_id_9A3C64059E71FA7B();
  level thread _id_167432A034A768DC();
  _id_5401225E56F7FA1B();
  _id_7E9D9AC29D0AC7A3();
  scripts\cp\scriptable::scriptable_cpglobalcallback();
  _id_467F0FDFDD155A45::init();
  _id_354C862768CFE202::init();
  scripts\cp\coop_fx::main();
  scripts\cp\cp_merits::buildmeritinfo();
  thread _id_7EF95BBA57DC4B82::init();
  thread _id_1E22D314CC16F807::init();
  thread _id_4BAC13D511590220::_id_7DCAD89B9C0264A6();
  scripts\cp\whizby::init();
  scripts\cp\cp_dialogue::main();
  level thread _id_35DE402EFC5ACFB3::init_battlechatter();
  level thread _id_18A73A64992DD07D::_id_4C108AF46678AF57();
  level thread _id_0AFB7E332AEE4BF2::_id_029CB39AA7064ED6();
  level thread _id_187A04151C40FB72::init();
  level thread _id_293BC33BD79CABD1::init();
  level thread _id_644C18834356D9DC::init_munitions();
  level thread scripts\cp\cp_deployablebox::init();
  level thread scripts\cp\drone\scout_drone::init();
  level thread _id_4D5D872A7BD5C0C3::_id_234851F94416F178();
  level thread scripts\cp\cp_visionsets::vision_set_management();
  level thread scripts\cp\cp_outline_utility::init();
  level thread _id_F79A0775F27A26D7();
  thread scripts\cp\challenges_cp::init();
  thread _id_3D5DC66341D1ED92::init();
  level thread scripts\cp\cp_analytics::initsegmentstats();
  level thread scripts\cp\cp_analytics::dlog_analytics_init();
  thread _id_4192352A88553D67::init();
  thread _id_122C94E0D5135583::init();
  level thread scripts\cp\cp_awards::init();
  level thread _id_41AE4F5CA24216CB::_id_8E9B2E8BA0328E3C();
  level thread scripts\cp\cp_player_battlechatter::init();
  _id_74502A9E0EF1F19C::weaponsinit();
  scripts\cp\cp_outline::outline_init();
  scripts\cp\cp_music_and_dialog::_id_21168B5CD3F92925();
  level scripts\cp\cp_hud_message::init_cp_hud_message();
  level thread scripts\cp\loot_system::init_loot();
  _id_12E2FB553EC1605E::init();
  thread scripts\cp\cp_relics::init();
  level thread[[level._id_59C3F456A9E5D4F0]]();
  level thread scripts\cp\utility::global_physics_sound_monitor();
  level thread _id_75A86C2332C8E92C::init();
  level thread _id_703FDBB02501D31E::_id_6620B2D387064D74();
  _id_371B4C2AB5861E62::_id_A09756B37F2E0681();

  if(!scripts\cp\utility::_id_F620E996A1D7D81A() && !scripts\cp\utility::is_operations_gametype()) {
    level thread _id_66122A002AFF5D57::init();
    level thread _id_3FD3C5A2E270592E::init();
  }

  level thread _id_68183EB068FF036F::_id_A0B9C16CA4FA0611();
  _id_070DE4B08084A8FE::_id_D86F905B2EFC08B9();

  if(_id_476B6443E3798F5E::_id_AB29F5844AA437FB())
    _id_476B6443E3798F5E::_id_AE2BC8E7D8D4FC9B();

  if(_id_0BE6CB102C46939E::_id_777C44BDFC80C0BB())
    thread _id_0BE6CB102C46939E::_id_FBBB9E404CE48427();

  _id_17CA3AF80F14CE7E::_id_4BECAA200DDC0956();
  _id_3BC2A3F24DCD4061();
  scripts\cp\utility::_id_3069B525E1C98FAF("START");
  level thread scripts\cp\cp_debug::_id_27BBF9605C8354E8();
  level thread _id_C15A7CE9004A44B4();
}

_id_3BC2A3F24DCD4061() {
  _id_0998572FF3C96EE5::init();
  _id_5E5507D57BBBB709::init();
}

_id_C15A7CE9004A44B4() {
  level endon("game_ended");
  wait 5;
  _id_EF4970D8905D4C5B("br_loot_cache");
  _id_EF4970D8905D4C5B("br_loot_cache_lege");
  _id_EF4970D8905D4C5B("br_loot_cache_gulag");
  _id_EF4970D8905D4C5B("br_scavenger_quest_cache");
  _id_EF4970D8905D4C5B("br_quest_safe");
  _id_EF4970D8905D4C5B("dmz_supply_drop");
  _id_EF4970D8905D4C5B("dmz_boss_supply_drop");
  _id_EF4970D8905D4C5B("dmz_supply_drop_samsite");
  _id_EF4970D8905D4C5B("dmz_safe");
  _id_EF4970D8905D4C5B("dmz_hidden_container");
  _id_EF4970D8905D4C5B("dmz_secret_stash");
  _id_EF4970D8905D4C5B("dmz_geiger_counter_cache");
  _id_EF4970D8905D4C5B("cache_medicine_cabinet");
  _id_EF4970D8905D4C5B("cache_bar_cabinet");
  _id_EF4970D8905D4C5B("cache_school_locker_a");
  _id_EF4970D8905D4C5B("cache_school_locker_b");
  _id_EF4970D8905D4C5B("cache_computer_tower");
  _id_EF4970D8905D4C5B("cache_dresser");
  _id_EF4970D8905D4C5B("cache_fridge_a");
  _id_EF4970D8905D4C5B("cache_fridge_b");
  _id_EF4970D8905D4C5B("cache_fridge_mini");
  _id_EF4970D8905D4C5B("cache_fridge_old");
  _id_EF4970D8905D4C5B("cache_comm_fridge_01");
  _id_EF4970D8905D4C5B("cache_comm_fridge_02");
  _id_EF4970D8905D4C5B("cache_toolbox");
  _id_EF4970D8905D4C5B("cache_cash_register");
  _id_EF4970D8905D4C5B("dmz_crate_wood");
  _id_EF4970D8905D4C5B("cache_medical_box_wall");
  _id_EF4970D8905D4C5B("cache_office_cabinet");
  _id_EF4970D8905D4C5B("dmz_hidden_container_common");
  _id_EF4970D8905D4C5B("cache_duffel_bag_01");
  _id_EF4970D8905D4C5B("cache_duffel_bag_02");
  _id_EF4970D8905D4C5B("cache_hanging_clothes");
  _id_EF4970D8905D4C5B("cache_mail_kiosk");
  _id_EF4970D8905D4C5B("cache_weapon_locker");
}

_id_EF4970D8905D4C5B(_id_14004B68DDACB781) {}

create_player_threatbias_groups() {
  createthreatbiasgroup("player1");
  createthreatbiasgroup("player2");
  createthreatbiasgroup("player3");
  createthreatbiasgroup("player4");
  createthreatbiasgroup("player1_enemy");
  createthreatbiasgroup("player2_enemy");
  createthreatbiasgroup("player3_enemy");
  createthreatbiasgroup("player4_enemy");
  setthreatbias("player1", "player1_enemy", 10000);
  setthreatbias("player2", "player2_enemy", 10000);
  setthreatbias("player3", "player3_enemy", 10000);
  setthreatbias("player4", "player4_enemy", 10000);
}

_id_7280BABC254585B2() {
  level thread _id_14609B809484646E::init();
  level thread scripts\cp\utility\spawn_event_aggregator::init();
  level thread scripts\cp\utility\lui_game_event_aggregator::init();
  level thread scripts\cp\utility\disconnect_event_aggregator::init();
  level thread scripts\cp\utility\player_frame_update_aggregator::init();
  level thread _id_157445DAE3AF0F9F::init();
  level thread _id_6DEE2410821C6C07::init();
  level thread _id_02D4725BF070AC3B::init();
  level scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(::check_for_execution_allows);
  level scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(scripts\cp_mp\utility\player_utility::updateinputtypewatcher);
  level _id_157445DAE3AF0F9F::_id_3AE366EC2732AF83(::_id_D1A06B15D459DBDA);
  level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback(_id_644C18834356D9DC::_id_0B64F3836C1D7A06);
  level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback(_id_531CB1BE084314F7::_id_DB908ECACCBE933C);
  level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback(scripts\cp\loot_system::_id_E146F016A8A7244F);
  level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback(::_id_4A39C5C1F9EA026F);
  level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback(::_id_FCD3A5870BCEC50C);
  level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback(_id_07C40FA80892A721::_id_13CAA305C839A278);
  level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback(::_id_9A82F8A066C216E0);

  if(getDvar("ui_gametype") == "missions")
    level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback(scripts\cp\cp_objectives::_id_4060F86CF056CF74);

  level _id_14609B809484646E::_id_8ECE37593311858A(_id_07C40FA80892A721::initarmor);
  level _id_14609B809484646E::_id_8ECE37593311858A(::_id_64908CF46D806427);
  level _id_14609B809484646E::_id_8ECE37593311858A(::_id_E14E30E8C9C40402);
  level _id_14609B809484646E::_id_8ECE37593311858A(::_id_174CBB4C8632933F);
  level _id_14609B809484646E::_id_8ECE37593311858A(_id_04CDABCD91A92977::_id_342AF7EA8A120B16);
  level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(_id_07C40FA80892A721::givestartingarmor);
  level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(_id_519BED5012F1C015::_id_36D589DC5C4191F6);
  level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(_id_56EF8D52FE1B48A1::_id_50EB338949884FCA);
  level scripts\cp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::_id_7FDEB6DCCFD886AB);
  level _id_14609B809484646E::_id_8ECE37593311858A(scripts\cp\intel\cp_intel::_id_807054CFA320FF66);
  level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp\intel\cp_intel::_id_383BBAC10494B5FF);
  level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_288E19381DA612C4);
  level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(_id_0E80538EF14D00E1::_id_3458E37BBAC2FF9A);
}

_id_288E19381DA612C4() {
  _id_AA1CAEBF050B34CC = self getplayerdata("cp", "progression", "thirdPerson");

  if(istrue(_id_AA1CAEBF050B34CC))
    _id_5E658169357048F0(1);
  else
    _id_5E658169357048F0(0);
}

_id_4A39C5C1F9EA026F(_id_7148C1A6F25491F8, value) {
  if(_id_7148C1A6F25491F8 == "toggle_camera_view") {
    player = undefined;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      _id_8EFEF5B1E4D79B79 = level.players[_id_AC0E594AC96AA3A8] getentitynumber();

      if(_id_8EFEF5B1E4D79B79 == value) {
        player = level.players[_id_AC0E594AC96AA3A8];

        if(istrue(player._id_512F0D6731086F73)) {
          return;
        }
        if(istrue(player._id_911B640702FEC71A))
          player _id_5E658169357048F0(0);
        else
          player _id_5E658169357048F0(1);

        break;
      }
    }
  }
}

_id_5E658169357048F0(_id_E3108E412AFB3811) {
  if(istrue(_id_E3108E412AFB3811)) {
    self setclientomnvar("ui_toggle_third_person", 1);
    self setplayerdata("cp", "progression", "thirdPerson", 1);
    self._id_911B640702FEC71A = 1;

    if(!istrue(self._id_57910E77921F4061))
      _id_532E7B905134A981(1);
  } else {
    self setclientomnvar("ui_toggle_third_person", 0);
    self setplayerdata("cp", "progression", "thirdPerson", 0);
    self._id_911B640702FEC71A = undefined;
    _id_532E7B905134A981(0);
  }

  self notify("toggled_third_person_camera", _id_E3108E412AFB3811);
}

_id_532E7B905134A981(_id_E3108E412AFB3811) {
  if(istrue(_id_E3108E412AFB3811))
    self setcamerathirdperson(1);
  else {
    self setcamerathirdperson(0);
    self _meth_5762CF97C6F1A2C1("none");
  }
}

_id_DB31AE430D191461(_id_E3108E412AFB3811) {
  if(istrue(_id_E3108E412AFB3811)) {
    self._id_57910E77921F4061 = 1;

    if(istrue(self._id_911B640702FEC71A))
      _id_532E7B905134A981(0);
  } else {
    self._id_57910E77921F4061 = undefined;

    if(istrue(self._id_911B640702FEC71A))
      _id_532E7B905134A981(1);
  }
}

_id_9A82F8A066C216E0(_id_7148C1A6F25491F8, value) {
  if(_id_7148C1A6F25491F8 == "jump_to_start") {
    _id_B6364D542D70DC1B = getDvar("dvar_C4B5F7005920FC31");
    _id_67F14F8315CB0F2F = strtok(_id_B6364D542D70DC1B, ",");

    if(isDefined(_id_67F14F8315CB0F2F[value - 1])) {
      if(isDefined(level.start_arrays) && isDefined(level.start_arrays[_id_67F14F8315CB0F2F[value - 1]])) {
        setDvar("start", _id_67F14F8315CB0F2F[value - 1]);
        scripts\cp\cp_checkpoint::checkpoint_set("");
      }

      _id_467F0FDFDD155A45::_id_180B06D3D67D483C("Jump To Start Used");
      _id_467F0FDFDD155A45::restart_map(0, "map_restart");
    }
  }
}

_id_535F161986DC4245() {}

_id_303F9875F954E1C4() {
  level thread scripts\mp\callbacksetup::setupdamageflags();
  level thread scripts\mp\objidpoolmanager::init();
  level thread scripts\mp\sentientpoolmanager::init();

  if(!isDefined(level.tweakablesinitialized))
    thread scripts\mp\tweakables::init();
}

_id_F6A78BBE53021BF8() {
  _id_51337DEDFD496B9C();
  level thread scripts\cp\init_cp_mp::init();
  scripts\cp_mp\agents\agent_init::agent_init();
  level thread scripts\cp_mp\utility\game_utility::game_utility_init();
  level thread scripts\cp_mp\utility\shellshock_utility::shellshock_utility_init();
  level thread scripts\cp_mp\targetmarkergroups::init();
  scripts\cp_mp\utility\player_utility::initdismembermentlist();
  scripts\cp_mp\entityheadicons::init();
  level thread scripts\cp_mp\emp_debuff::emp_debuff_init();
  level thread scripts\cp_mp\gestures::init();
  level thread scripts\cp\gestures_cp::init_cp();
  level thread scripts\cp_mp\execution::execution_init();
  level thread scripts\cp\execution::init_cp_execution();
  _id_15DE7DC4D21F1DA3::init();
  level _id_76CC264B397DB9CB::init();
  level _id_07C40FA80892A721::init();
  level _id_1F97A44D1761C919::init();
  level _id_0CBB0697DE4C5728::_id_3B59B4D385A202E6();
  level thread _id_C4ADA2395F072B1F();
  level thread _id_0E80538EF14D00E1::vehicles_init();
  level thread scripts\cp_mp\killstreaks\init::init();
  level thread scripts\cp_mp\challenges::init();
}

_id_51337DEDFD496B9C() {
  _id_4F1F43B1ED3AF8F9::init();
}

_id_C4ADA2395F072B1F() {
  level.healthregendelay = 6;
  level.healthregendisabled = level.healthregendelay <= 0;
  level.playerhealth_regularregendelay = level.healthregendelay;
  level _id_0372301AF73968CB::_id_A6C2D3F08399946F();
  level _id_6A5D3BF7A5B7064A::init();
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(_id_6A5D3BF7A5B7064A::_id_9BC46D4B8891A740);
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(_id_0372301AF73968CB::manageplayerregen);
}

_id_D1A06B15D459DBDA() {
  if(isDefined(self.timeplayed)) {
    team = self.sessionteam;

    if(!isDefined(self.timeplayed[team]))
      self.timeplayed[team] = 0;
    else
      self.timeplayed[team]++;

    if(team != "spectator" && team != "codcaster") {
      self.timeplayed["total"]++;
      self.timeplayed["missionTeam"]++;

      if(!scripts\cp\utility\player::isreallyalive(self))
        self.timeplayed["timeDead"]++;
    }
  }
}

cp_struct_filter(struct) {
  if(isDefined(struct.targetname)) {
    switch (struct.targetname) {
      case "fortress":
      case "front_side":
        return 0;
    }
  }

  if(isDefined(struct.script_noteworthy)) {
    switch (struct.script_noteworthy) {
      case "fabric_banner_alquetala_01":
      case "lockMe":
      case "vfx_mayh_gameplay_dmz_rectangular_aq_flag_wind_1":
      case "vfx_mayh_gameplay_dmz_long_thin_aq_flag_wind_1":
      case "guard_ar":
      case "ee_window_bars_01_black":
      case "window_cover_set_metal_mesh_bars_48_khaki":
      case "guard_shotgun":
      case "guard_stationary":
      case "guard":
      case "guard_sniper":
      case "mediumHouse":
      case "ee_manmade_mine_ladder_a_cover":
      case "guard_lmg":
      case "ee_window_bars_02_black":
      case "guard_stationary_shotgun":
      case "window_cover_set_metal_mesh_bars_96_khaki":
      case "guard_stationary_smg":
      case "guard_smg":
        return 0;
    }
  }

  return 1;
}

waypoint_init() {
  if(level.splitscreen)
    level.waypoint_size = 15;
  else
    level.waypoint_size = 8;

  level.waypoint_alpha = 0.75;
  level.waypoint_index = 0;
}

findboxcenter(_id_3C59120EE220BF08, _id_C978C20E8E5AA292) {
  center = (0, 0, 0);
  center = _id_C978C20E8E5AA292 - _id_3C59120EE220BF08;
  center = (center[0] / 2, center[1] / 2, center[2] / 2) + _id_3C59120EE220BF08;
  return center;
}

init_global_cp_flags() {
  scripts\engine\utility::flag_init("strike_init_done");
  scripts\engine\utility::flag_init("infil_complete");
  scripts\engine\utility::flag_init("introscreen_over");
  scripts\engine\utility::flag_init("interactions_initialized");
  scripts\engine\utility::flag_init("level_ready_for_script");
  scripts\engine\utility::flag_init("player_spawned_with_loadout");
  scripts\engine\utility::flag_init("ready_for_devgui");
  scripts\engine\utility::flag_init("gameskill_initialized");
  scripts\engine\utility::flag_init("bsp_structs_initialized");
  scripts\engine\utility::flag_init("scriptables_ready");
  scripts\engine\utility::flag_init("player_spawned_with_loadout");
  scripts\engine\utility::flag_init("level_stealth_initialized");
  scripts\engine\utility::flag_init("stealth_enabled");
  scripts\engine\utility::flag_init("stealth_spotted");
  level thread set_systems_init_flag();
}

_id_1284BFDE6C25B9CA() {
  scripts\cp\utility::gameflaginit("prematch_done", 0);
  scripts\cp\utility::gameflaginit("infil_setup_complete", 0);
  scripts\cp\utility::gameflaginit("infil_will_run", 0);
  scripts\cp\utility::gameflaginit("infil_started", 0);
}

init_global_cp_script_funcs() {
  level thread create_script_wait_for_flags();
}

set_systems_init_flag() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait_all("strike_init_done", "infil_complete", "introscreen_over", "interactions_initialized");
  scripts\engine\utility::flag_set("level_ready_for_script");
}

_id_56585B89BE143A09() {
  level.splitscreen = issplitscreen();
  level._id_AD231D0DAAE0BAD9 = _id_791E463B9DF434FC();
  level._id_2CB04CA6155DE37F = getdvarint("dvar_CC4EE5AA21AA68D3", 1);
  level.onlinegame = getdvarint("onlinegame");
  level.rankedmatch = level.onlinegame && !getdvarint("xblive_privatematch") || getdvarint("force_ranking");
  level.script = tolower(getDvar("g_mapname"));
  level.mapname = scripts\cp_mp\utility\game_utility::getmapname();
  level.gametype = tolower(getDvar("ui_gametype"));
  level.otherteam["allies"] = "axis";
  level.otherteam["axis"] = "allies";
  level.multiteambased = 0;
  level.teambased = 1;
  level.func = [];
  level.coop_mode_feature = [];
  level._id_8C70B00C48E8BD20 = [];
  level.createfx_enabled = getDvar("createfx") != "";
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level._id_12226443217B5474 = 0;
  level.numgametypereservedobjectives = 0;
  level.numkills = 0;
  level.lethaldelay = 0;
  level._id_D67242E275D6F310 = 0;
  level.reclaimedreservedobjectives = [];
  level._id_646444267BCF2E45 = [];
  level.date = scripts\cp\utility::get_actual_time_from_civil(8);
  level.default_goalradius = 2048;
  level.path_node_table = "cp/cp_path_node_table.csv";
  level.leanthread = getdvarint("scr_runlean_playerthread_count", 0) == 1;
  level.gametype = tolower(getDvar("g_gametype"));
  level.codcasterenabled = getdvarint("com_codcasterenabled", 0) == 1;
  level.systemlink = getdvarint("systemlink", 0) == 1;
  level._id_3904DE63DBC4B0AF = getdvarint("dvar_401232859BCE6C37", 0);
  level.useperbullethitmarkers = getdvarint("ui_use_per_bullet_hitmarkers", 0) == 1;
  level.splitscreen = issplitscreen();
  level.onlinegame = getdvarint("onlinegame");
  level.rankedmatch = level.onlinegame || getdvarint("force_ranking");
  level.matchmakingmatch = level.onlinegame && !getdvarint("xblive_privatematch");
  level.playerxpenabled = 1;
  level.weaponxpenabled = level.playerxpenabled;
  level.challengesallowed = level.matchmakingmatch || getdvarint("force_challenges");
  level.enforceantiboosting = level.playerxpenabled || level.weaponxpenabled || level.challengesallowed;
  level.onlinestatsenabled = level.rankedmatch;
  level.starttimeutcseconds = getsystemtime();
  level.pingsystemactive = getdvarint("dvar_E8512E1508AFEFE8", 1);
  level.current_personal_interaction_structs = [];
  level.active_cs_files = [];
  level._id_30871F40B5BCC61C = [];
  level.weapon_drop_cooldown = [];
  level.grenade_drop_cooldown = [];
  level.teamnamelist = ["axis", "allies"];
  level.func["scriptmodelplayanim"] = ::scriptmodelplayanim;
  level.func["scriptModelPlayAnim"] = ::scriptmodelplayanim;
  level.func["precachempanim"] = ::precachempanim;
  level.func["scriptmodelclearanim"] = ::scriptmodelclearanim;
  level.func["scriptModelClearAnim"] = ::scriptmodelclearanim;
  level.fnoffhandfire = _id_74502A9E0EF1F19C::ai_offhandfiremanager;
  level.vehiclefriendlydamage = getdvarint("scr_vehiclefriendlydamage", 0) > 0;
  level.framedurationseconds = level.frameduration / 1000;
  level.lastslowprocessframe = 0;
  level.mapcenter = findboxcenter(level.spawnmins, level.spawnmaxs);
  level.maxsquadsize = getdvarint("party_maxSquadSize", 4);
  level._id_DA6CB768C7CA7B39 = ::_id_CC7BFEB1D9EC91CB;
  level._id_C4E3D516B4EA7BE7 = 8;
  level._id_37190777EEB4333F = 1;
  _id_66122A002AFF5D57::_id_7A302A314424968F(1);
  setmapcenter(level.mapcenter);
  waypoint_init();

  if(getdvarint("dvar_2082BD2F4A48916F", 0) != 0)
    level.dogtag_revive = 1;

  thread _id_0598E0C00C8151F7::_id_847508E235FD547C();
}

_id_CC7BFEB1D9EC91CB() {
  self._id_230A3287F9AD2965 = 1;
}

_id_791E463B9DF434FC() {
  value = getdvarint("dvar_9138AFE32459DDB3", 0);
  _id_6302CA9978061647 = value + 1;
  value = setDvar("dvar_9138AFE32459DDB3", _id_6302CA9978061647);
  return _id_6302CA9978061647;
}

_id_E2FC4DEA9278CBD8() {
  setDvar("dvar_855E5F66C3D7CEC5", 1);
  setDvar("dvar_AB695F7F6C849BD1", 1);
  setDvar("ui_inhostmigration", 0);
  setDvar("camera_thirdPerson", getdvarint("scr_thirdperson"));
  setDvar("bg_compassShowEnemies", getDvar("scr_game_forceuav"));
  setDvar("ismatchmakinggame", scripts\cp\utility::matchmakinggame());
  setDvar("ui_overtime", 0);
  setDvar("ui_allow_teamchange", 1);
  setDvar("g_deadChat", 1);
  setDvar("min_wait_for_players", 5);
  setDvar("ui_friendlyfire", 0);
  setDvar("cg_drawFriendlyHUDGrenades", 0);
  setDvar("cg_drawCrosshair", scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924(), 0, 1));
  setDvar("cg_drawCrosshairNames", 1);
  setDvar("cg_drawFriendlyNamesAlways", 0);
  setDvar("dvar_67846A0D7AA3030A", 0);
  setDvar("dvar_DB88B998734440CC", "");
  setDvar("hud_health_min_fully_healed", defaultplayermaxhealth());
  setdvarifuninitialized("scr_slowmo", "");
  setDvar("scr_disableScoreSplash", 0);
  setDvar("scr_nohitmarker", 0);
  setDvar("dvar_687F6FE472201DF1", 1);
  setDvar("dvar_4E5B353BF84974A9", 1);
  setDvar("online_matchdata_enabled", 0);
  setDvar("dvar_BD445B33649DDB33", 1);
  setdvarifuninitialized("dvar_697B2DEB810DA53B", 50);
  registerfalldamagedvars();
}

registerfalldamagedvars() {
  setDvar("bg_fallDamageMinHeight", 225);
  setDvar("bg_fallDamageMaxHeight", 560);
}

setup_callbacks() {
  level.callbackstartgametype = ::_id_C11F28939572CDF9;
  level.callbackplayeractive = ::blank;
  level.callbackplayerconnect = ::defaultplayerconnect;
  level.callbackplayerdisconnect = ::defaultplayerdisconnect;
  level.callbackplayerdamage = ::defaultplayerdamage;
  level.callbackplayerimpaled = ::callback_agent_impaled;
  level.callbackplayerkilled = ::defaultplayerkilled;
  level.callbackplayermigrated = ::defaultplayermigrated;
  level.callbackhostmigration = ::defaulthostmigration;
  level._id_42D9B617BBCA6A42 = ::blank;
  level._id_935C97AA3757676F = ::_id_5C9544EF10CB9E0C;
  level.getspawnpoint = ::defaultgetspawnpoint;
  level.onspawnplayer = ::blank;
  level.onprecachegametype = ::blank;
  level.onstartgametype = ::blank;
  level.playermaxhealth = ::defaultplayermaxhealth;
  level.playerinitinvulnerability = ::player_init_invulnerability;
  level.spawnplayerfunc = ::spawnplayer;
  level.enterspectatorfunc = ::_id_382AB3472A4DA4E6;
  level.intermissionfunc = ::spawnintermission;
  level.getkilltriggerspawnloc = ::getkilltriggerspawnloc;
  level.initagentscriptvariables = scripts\cp\cp_agent_utils::initagentscriptvariables;
  level.setagentteam = scripts\cp\cp_agent_utils::set_agent_team;
  level.agentvalidateattacker = scripts\cp\cp_agent_utils::validateattacker;
  level.agentfunc = scripts\cp\cp_agent_utils::agentfunc;
  level.getfreeagent = scripts\cp\cp_agent_utils::getfreeagent;
  level.addtocharactersarray = scripts\cp_mp\utility\game_utility::addtocharactersarray;
  level.callbackplayerlaststand = _id_0AFB7E332AEE4BF2::callback_playerlaststand;
  level.endgame = _id_467F0FDFDD155A45::endgame;
  level.forceendgame = _id_467F0FDFDD155A45::forceendgame;
  level._id_B11DB2283DBD7ED3 = _id_519BED5012F1C015::player_movement_state;
  level._id_3C8E175D92BE01EA = ::_id_297BF30B6352B598;
  level._id_4941FC1EE570D4CB = ::_id_047320A25B8EE003;
  level._id_CDA3AF1F73639C7C = ::_id_2A643088582C8BE3;
  scripts\cp\utility\cp_controlled_callbacks::registercontrolledcallback("Earthquake", ::earthquake, 5, scripts\cp\utility::_id_97196D9C69A91E2B, 0, 0, 0, 1, 1);
  scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback(_id_467F0FDFDD155A45::_id_51A7FD1C0C6690F9);
  scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback(_id_0598E0C00C8151F7::_id_0899BD4ADD25DDD3);

  if(getDvar("ui_gametype") == "cp_survival")
    level.intermissionfunc = ::spawnintermission;

  _id_251F071833394C68::_id_2FCE2F81588A2462();
}

_id_047320A25B8EE003() {
  _id_1C7DBF040C780003 = _id_5E5507D57BBBB709::_id_CAB56589FD214C7E();

  if(isDefined(_id_1C7DBF040C780003) && _id_1C7DBF040C780003 == "assault") {
    if(istrue(self.hasplatepouch))
      return 6;
    else
      return 4;
  }

  if(istrue(self.hasplatepouch))
    return 5;

  return 3;
}

_id_01E81309DCF11FAA() {
  level._effect["slide_dust"] = loadfx("vfx/core/screen/vfx_scrnfx_tocam_slidedust_m");
}

defaultplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {}

defaultplayerkilled(einflictor, attacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration) {}

_id_167432A034A768DC() {
  level endon("game_ended");
  _id_540D620F7A951BDC = "";

  for(;;) {
    if(getDvar("scr_slowmo", _id_540D620F7A951BDC) != _id_540D620F7A951BDC) {
      break;
    }

    wait 1;
  }

  time = getdvarfloat("scr_slowmo");
  setslowmotion(time, time, 0.0);
  level thread _id_167432A034A768DC();
}

callback_agent_impaled(eattacker, sweapon, _id_F98A651C69C13CBA, vpoint, vdir, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34) {
  thread impale(eattacker, self, sweapon, _id_F98A651C69C13CBA, vpoint, vdir, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34);
}

impale(eattacker, _id_5B033344A44BB910, sweapon, _id_F98A651C69C13CBA, vpoint, vdir, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34) {
  if(isDefined(level.harpoon_impale_additional_func))
    [[level.harpoon_impale_additional_func]](sweapon, eattacker, _id_5B033344A44BB910, vpoint, vdir, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34);
  else {
    _id_5B033344A44BB910 startragdoll();
    contents = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
    endpoint = vpoint + vdir * 4096;
    trace = scripts\engine\trace::ray_trace_detail(vpoint, endpoint, undefined, contents, undefined, 1);
    endpoint = trace["position"] - vdir * 12;
    _id_80C97B146B16BE3F = length(endpoint - vpoint);
    flighttime = _id_80C97B146B16BE3F / 1250;
    flighttime = clamp(flighttime, 0.05, 1);
    wait 0.05;
    _id_A0480A10EE4E345F = vdir;
    _id_C323F0CB880A051F = anglestoup(eattacker.angles);
    _id_C1148FF802BE2880 = vectorcross(_id_A0480A10EE4E345F, _id_C323F0CB880A051F);
    _id_483E4E4E5B094BE2 = scripts\engine\utility::spawn_tag_origin(vpoint, axistoangles(_id_A0480A10EE4E345F, _id_C1148FF802BE2880, _id_C323F0CB880A051F));
    _id_483E4E4E5B094BE2 moveTo(endpoint, flighttime);
    _id_D04F3DA69954A74E = spawnragdollconstraint(_id_5B033344A44BB910, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34);
    _id_D04F3DA69954A74E.origin = _id_483E4E4E5B094BE2.origin;
    _id_D04F3DA69954A74E.angles = _id_483E4E4E5B094BE2.angles;
    _id_D04F3DA69954A74E linkTo(_id_483E4E4E5B094BE2);
    thread impale_cleanup(_id_5B033344A44BB910, _id_483E4E4E5B094BE2, flighttime + 0.05, _id_D04F3DA69954A74E);
  }
}

impale_cleanup(_id_E851FFA44B7E0D54, _id_483E4E4E5B094BE2, time, _id_D04F3DA69954A74E) {
  _id_E851FFA44B7E0D54 scripts\engine\utility::waittill_any_timeout_2(time, "death", "disconnect");
  _id_D04F3DA69954A74E delete();
  _id_483E4E4E5B094BE2 delete();
}

_id_248519CFCAF04C4A() {
  _id_66C10BBC36EE3A2C = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_damage"];

  foreach(triggertype in _id_66C10BBC36EE3A2C) {
    triggers = getEntArray(triggertype, "classname");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < triggers.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(triggers[_id_AC0E594AC96AA3A8].script_prefab_exploder))
        triggers[_id_AC0E594AC96AA3A8].script_exploder = triggers[_id_AC0E594AC96AA3A8].script_prefab_exploder;

      if(isDefined(triggers[_id_AC0E594AC96AA3A8].script_exploder))
        level thread exploder_load(triggers[_id_AC0E594AC96AA3A8]);
    }
  }
}

_id_5401225E56F7FA1B() {
  level thread trackgrenades();
  level thread trackmissiles();
  level thread trackcarepackages();
}

trackgrenades() {
  for(;;) {
    level.grenades = getEntArray("grenade", "classname");
    wait 0.05;
  }
}

trackmissiles() {
  for(;;) {
    level.missiles = getEntArray("rocket", "classname");
    wait 0.05;
  }
}

trackcarepackages() {
  for(;;) {
    level.carepackages = getEntArray("care_package", "targetname");
    wait 0.05;
  }
}

defaultplayermaxhealth() {
  if(istrue(self.keep_perks)) {
    if(scripts\cp\utility::has_zombie_perk("perk_machine_tough"))
      return 200;
    else
      return getdvarint("scr_player_maxhealth", 100);
  } else
    return getdvarint("scr_player_maxhealth", 100);
}

_id_A75F0074296BA485() {
  game["thermal_vision"] = "thermal_mp";
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["clientid"] = 0;
  game["state"] = "playing";
  game["status"] = "normal";
}

_id_BF4F95EC0DFF09AE() {
  visionsetnaked("", 0);
  visionsetnight("default_night_mp");
  visionsetmissilecam("missilecam");
  visionsetthermal(game["thermal_vision"]);
  visionsetpain("damage_deathsdoor", 0);
  _func_DCCECA58C71CEB5F("death");
  _func_AF2D9A459EBD113D("damage_radial");
  _func_347F34CAC350B5DD("damage_severe");
  _func_C838F02B25DA3712("whizby");
}

_id_44DAA9C20A1FD399() {
  setnojipscore(1, 1);
  setnojiptime(1, 1);
}

_id_1C2B32222A73294B() {
  if(getdvarint("dvar_022EDDF44003BAF9", 0) != 0 && _func_7EDA3128313BB227())
    setDvar("dvar_925F7DCEB8E6205E", 1);
  else
    setDvar("dvar_925F7DCEB8E6205E", 0);
}

defaultgetspawnpoint() {
  return getassignedspawnpoint(scripts\engine\utility::getStructArray("default_player_start", "targetname"));
}

getassignedspawnpoint(spawnpoints) {
  _id_556E8724DC4D8291 = self getentitynumber();
  return spawnpoints[_id_556E8724DC4D8291];
}

_id_C11F28939572CDF9() {
  [[level.onprecachegametype]]();
  level thread monitor_num_players();
  level thread _id_23EB2E4122646287();
  level thread scripts\cp\utility::_id_CC38DDC890D2BB22();
  level thread _id_2933E78A1455A35F();
  resetlevelflags();
  resetlevelarrays();
  scripts\common\create_script_utility::initialize_registered_create_script_files();
  _id_6E09A830FAB9468F::initperks();
  scripts\cp\cp_weaponrank::init();
  scripts\cp\utility::_id_C0D2C91F2688ECE4(1);
  level thread runprematch();
  level thread graceperiodmonitor();
  scripts\cp\cp_aiparachute::init_cp_aiparachute();
  sysprint("Ready for Compass");
  scripts\mp\flags::levelflaginit("game_over", 0);
  level thread startgame();
  level thread scripts\cp\cp_mapselect::init();

  if(!istrue(level.dev_build)) {
    scripts\cp\utility::add_demo_button_combo(["touchpad", "swap_weapon_release"], ::demo_toggle_infiniteammo, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["touchpad", "swap_weapon", "swap_weapon_release"], ::demo_toggle_infiniteammo, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["touchpad", "stance_release"], ::demo_toggle_ufo, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["touchpad", "stance", "stance_release"], ::demo_toggle_ufo, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["touchpad", "use_release"], ::demo_toggle_godmode, undefined, 1);
    scripts\cp\utility::add_demo_button_combo(["touchpad", "use", "use_release"], ::demo_toggle_godmode, undefined, 1);
  } else
    scripts\cp\utility::add_demo_button_combo(["ads", "use", "a", "use_release", "a_release"], _id_18A73A64992DD07D::print_active_modules_to_screen, "show active modules", 2);

  level scripts\mp\utility\lower_message::_id_05A98C45A6252B4A();
  _id_600B944A95C3A7BF::init();
  game["gamestarted"] = 1;
  game["life_count"] = 0;
  level thread wait_for_strike_init_complete();
  _id_6F1E07CE9FF97D5F::register_ai_damage_callbacks();
  _id_6F1E07CE9FF97D5F::register_ai_drop_funcs();
  level thread _id_285752B1F53ED9F1::_id_9030FF462F3DAA1A();

  if(level.gametype == "dungeons")
    level thread scripts\cp\cp_analytics::recordbreadcrumbdata();
}

_id_2933E78A1455A35F() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 5;
  [_id_985D5155902AB692, time_remaining] = _id_00BE99AA6C661D4A("dvar_EB91D378C179BA9F", 420);
  _id_C77BC7BF12F9B7E2(_id_985D5155902AB692, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_MINUTES", int(time_remaining));
  _id_45DD7A4F2DE86AB2 = _id_985D5155902AB692;
  [_id_985D5155902AB692, time_remaining] = _id_00BE99AA6C661D4A("dvar_ED70323C9A6E966B", 450);
  _id_C77BC7BF12F9B7E2(_id_985D5155902AB692 - _id_45DD7A4F2DE86AB2, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_MINUTES", int(time_remaining));
  _id_45DD7A4F2DE86AB2 = _id_985D5155902AB692;
  [_id_985D5155902AB692, time_remaining] = _id_00BE99AA6C661D4A("dvar_DEE32F538DBA0794", 465);
  _id_C77BC7BF12F9B7E2(_id_985D5155902AB692 - _id_45DD7A4F2DE86AB2, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_MINUTES", int(time_remaining));
  _id_45DD7A4F2DE86AB2 = _id_985D5155902AB692;
  [_id_985D5155902AB692, time_remaining] = _id_00BE99AA6C661D4A("dvar_3C8FB3B02192F953", 475);
  _id_C77BC7BF12F9B7E2(_id_985D5155902AB692 - _id_45DD7A4F2DE86AB2, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_MINUTES", int(time_remaining));
  _id_45DD7A4F2DE86AB2 = _id_985D5155902AB692;
  [_id_985D5155902AB692, time_remaining] = _id_00BE99AA6C661D4A("dvar_4182434F66636DA8", 478);
  _id_C77BC7BF12F9B7E2(_id_985D5155902AB692 - _id_45DD7A4F2DE86AB2, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_MINUTES", int(time_remaining));
  _id_45DD7A4F2DE86AB2 = _id_985D5155902AB692;
  [_id_985D5155902AB692, time_remaining] = _id_00BE99AA6C661D4A("dvar_A233B185B88F1A75", 479);
  _id_C77BC7BF12F9B7E2(_id_985D5155902AB692 - _id_45DD7A4F2DE86AB2, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_MINUTES", int(time_remaining));
  _id_45DD7A4F2DE86AB2 = _id_985D5155902AB692;
  [_id_985D5155902AB692, time_remaining] = _id_00BE99AA6C661D4A("dvar_3902A722E6CC08F8", 479.5);
  _id_C77BC7BF12F9B7E2(_id_985D5155902AB692 - _id_45DD7A4F2DE86AB2, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_SECONDS", int(time_remaining * 60));
  _id_45DD7A4F2DE86AB2 = _id_985D5155902AB692;
  [_id_985D5155902AB692, time_remaining] = _id_00BE99AA6C661D4A("dvar_B5E11430896DCCCA", 479.75);
  _id_C77BC7BF12F9B7E2(_id_985D5155902AB692 - _id_45DD7A4F2DE86AB2, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_SECONDS", int(time_remaining * 60));
  wait 1;
  _id_546BDD6F69FD53E0 = int(time_remaining * 60) - 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_546BDD6F69FD53E0; _id_AC0E594AC96AA3A8++)
    _id_C77BC7BF12F9B7E2(1, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_SECONDS", _id_546BDD6F69FD53E0 - _id_AC0E594AC96AA3A8);
}

_id_00BE99AA6C661D4A(dvar, _id_072F66ADA661AC94) {
  _id_985D5155902AB692 = getdvarfloat(dvar, _id_072F66ADA661AC94);
  time_remaining = 480 - _id_985D5155902AB692;
  return [_id_985D5155902AB692, time_remaining];
}

_id_C77BC7BF12F9B7E2(_id_626341D24C77DB50, _id_E301921436F4FE9D, time_remaining) {
  level endon("game_ended");
  wait(_id_626341D24C77DB50 * 60);
  level thread scripts\cp\cp_hud_message::showerrormessagetoallplayers(_id_E301921436F4FE9D, time_remaining);
}

create_script_wait_for_flags() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  level thread scripts\cp\cp_snakecam::init_camera_interaction();
}

wait_for_strike_init_complete() {
  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    level endon("game_ended");
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(scripts\cp\coop_stealth::level_should_run_sp_stealth()) {
    _id_07CAEBC5D4875185::main();
    scripts\engine\utility::flag_set("level_stealth_initialized");
  }

  scripts\cp_mp\parachute::initparachutedvars();
}

resetlevelflags() {
  level.fauxvehiclecount = 0;
  level.gameended = 0;
  level.graceperiod = 10;
  level.ingraceperiod = level.graceperiod;
  level.noragdollents = getEntArray("noragdoll", "targetname");
  level.friendlyfire = 0;
  level.starttime = gettime();
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
  _id_3B64EB40368C1450::_id_20EB90F5B8963388();
  scripts\cp_mp\utility\game_utility::_id_EA9801BFF6CCF12A();
}

runprematch() {
  level notify("coop_pre_match");
  level endon("coop_pre_match");
  level endon("game_ended");
  setomnvar("ui_prematch_period", 1);

  if(isDefined(level.prematchfunc))
    [[level.prematchfunc]]();

  scripts\cp\utility::gameflagset("prematch_done");
  setomnvar("ui_prematch_period", 0);
}

graceperiodmonitor() {
  level notify("coop_grace_period");
  level endon("game_ended");
  level endon("coop_grace_period");

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
  thread gametimer();
}

gametimer() {
  level endon("game_ended");

  if(isDefined(game["startTimeFromMatchStart"]))
    level.starttimefrommatchstart = game["startTimeFromMatchStart"];

  if(!isDefined(game["startTimeFromMatchStart"])) {
    game["startTimeFromMatchStart"] = gettime();
    level.starttimefrommatchstart = gettime();
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_match_start");
  }
}

_id_062E5612AD414ABF() {
  return getDvar("dvar_08588CA386DBFF67") == "dedicated lan server" || getDvar("dvar_08588CA386DBFF67") == "dedicated internet server";
}

_id_F79A0775F27A26D7() {
  if(!_id_062E5612AD414ABF()) {
    return;
  }
  for(;;) {
    if(level.rankedmatch)
      exitlevel(0);

    if(!getdvarint("xblive_privatematch"))
      exitlevel(0);

    if(getDvar("dvar_08588CA386DBFF67") != "dedicated lan server" && getDvar("dvar_08588CA386DBFF67") != "dedicated internet server")
      exitlevel(0);

    wait 5;
  }
}

refreshuimatchinprogressomnvarvalue() {
  _id_2B8BDD3EBC30486A = 0;

  if(level.players.size > 1)
    _id_2B8BDD3EBC30486A = 1;

  foreach(player in level.players)
  player setclientomnvar("ui_match_in_progress", _id_2B8BDD3EBC30486A);
}

defaultplayerconnect() {
  self endon("disconnect");
  self.statusicon = "hud_status_connecting";
  self waittill("begin");

  if(getdvarint("dvar_390753F43CA68388", 0)) {
    level._id_D67242E275D6F310 = 1;
    scripts\cp\utility::_id_4CBAED764C116A25(1);
  }

  self.statusicon = "";
  connect_time = gettime();
  level notify("connected", self);
  _id_5CE6E63DF1D04ECA();
  _id_3999591663B82C6A();
  _id_8259ED9008F45C23();
  _id_CCC85FDB936857B3();
  init_laststand();
  _id_6361F223BF803C8E();
  scripts\cp\perks\cp_prestige::initplayerprestige();
  _id_6E09A830FAB9468F::init_each_perk();
  _id_25845ACA699D038D::initplayerdamagefunctions();
  thread setup_player_stealth();

  if(scripts\cp\utility::coop_mode_has("outline"))
    thread scripts\cp\cp_outline::playeroutlinemonitor();

  thread demo_allowed_debug_outline();
  thread _id_166B4F052DA169A7::_id_36BCBFD3365DC368();
  thread scripts\cp\cp_merits::updatemerits();
  thread track_forward_velocity();
  self.pers["matchdataWeaponStats"] = [];
  self.pers["weaponStats"] = [];
  self setclientomnvar("ui_scoreboard_freeze", 0);

  if(self ishost())
    level.player = self;
  else if(isdedicatedserver()) {
    if(!isDefined(level.player))
      level.player = level.players[0];
  }

  waittillframeend;
  addplayertolevelarrays(self);

  if(game["state"] == "postgame") {
    self.connectedpostgame = 1;
    self setclientdvars("cg_drawSpectatorMessages", 0);
    spawnintermission();
    return;
  }

  if(isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["think"]))
    self thread[[level.bot_funcs["think"]]]();

  level endon("game_ended");

  if(isDefined(level.hostmigrationtimer))
    thread scripts\cp\cp_hostmigration::hostmigrationtimerthink();

  _id_0F1B6F6CFED27EB0();

  if(isDefined(level.onplayerconnectaudioinit))
    [[level.onplayerconnectaudioinit]]();

  if(!isai(self))
    playermonitor();

  if(getdvarint("dvar_35749E6D180B4D00", 0)) {}

  scripts\cp_mp\utility\game_utility::startkeyearning();
  spawnplayer();
}

_id_6361F223BF803C8E() {
  self._id_5814D27874B48E54 = spawnStruct();
  self._id_5814D27874B48E54.player = self;
}

_id_B9953EB97AD6C0D2() {
  return self._id_5814D27874B48E54;
}

_id_EA9FC8F6656867D7() {
  if(isDefined(level._id_94C009BD348D6AA6)) {
    keys = getarraykeys(level._id_94C009BD348D6AA6);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
      dvar = keys[_id_AC0E594AC96AA3A8];
      value = level._id_94C009BD348D6AA6[dvar];
      setDvar(dvar, value);
    }
  }
}

check_for_execution_allows() {
  if(!isalive(self))
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(istrue(self.inlaststand))
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(istrue(self.being_revived))
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(istrue(self.isreviving))
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(self isreloading())
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(istrue(self.binvehicle))
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(self isonladder())
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(self issprintsliding())
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(self issupersprinting())
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(self isjumping())
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(self isgestureplaying())
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(self isviewmodelanimplaying())
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(self isthrowinggrenade())
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(self isparachuting())
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(self isinfreefall())
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(istrue(self.isjuggernaut))
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(self islinked())
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(!self isonground())
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else if(isDefined(self getcurrentweapon()) && isDefined(self getcurrentweapon().basename) && issubstr(self getcurrentweapon().basename, "mike32"))
    scripts\cp_mp\execution::disableexecutionattackwrapper();
  else
    scripts\cp_mp\execution::enableexecutionattackwrapper();
}

demo_allowed_debug_outline() {
  self endon("disconnect");
  thread demo_debug_outline_button_watcher();

  for(;;) {
    self waittill("demo_debug_outline");

    if(getdvarint("dvar_C021E81D04F69F38", 0)) {
      if(isDefined(level.debug_outline)) {
        setDvar("dvar_9E9513E7705385BD", 0);
        level.debug_outline = undefined;
        scripts\cp\cp_outline::unset_outline();
        scripts\cp\cp_outline::restore_outline_settings();
        announcement("debug - outline turned off!");
        iprintln("debug - outline turned off!");
      } else {
        setDvar("dvar_9E9513E7705385BD", 1);
        level.debug_outline = 1;
        scripts\cp\cp_outline::save_outline_settings();
        demo_debug_outline_settings();
        level thread scripts\cp\cp_outline::set_outline("outline_nodepth_red");
        announcement("debug - outline turned on!");
        iprintln("debug - outline turned on!");
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
  value = getdvarint("player_sustainammo", 0);

  if(value == 0) {
    announcement("infinite ammo - on");
    value = 1;
  } else {
    announcement("infinite ammo - off");
    value = 0;
  }

  setDvar("player_sustainammo", value);
}

demo_debug_outline_button_watcher() {
  self endon("disconnect");
  self notifyonplayercommand("first", "-actionslot 1");
  self notifyonplayercommand("second", "-actionslot 2");
  self notifyonplayercommand("third", "+usereload");

  for(;;) {
    msg = scripts\engine\utility::waittill_any_timeout_no_endon_death_1(2, "first");

    if(msg == "timeout") {
      continue;
    }
    msg = scripts\engine\utility::waittill_any_timeout_no_endon_death_1(2, "second");

    if(msg == "timeout") {
      continue;
    }
    msg = scripts\engine\utility::waittill_any_timeout_no_endon_death_1(2, "first");

    if(msg == "timeout") {
      continue;
    }
    msg = scripts\engine\utility::waittill_any_timeout_no_endon_death_1(2, "second");

    if(msg == "timeout") {
      continue;
    }
    msg = scripts\engine\utility::waittill_any_timeout_no_endon_death_1(2, "third");

    if(msg == "timeout") {
      continue;
    }
    self notify("demo_debug_outline");
    waitframe();
  }
}

demo_debug_outline_settings() {
  setDvar("r_hudOutlineFillColor0", ".5 .5 .5 1");
  setDvar("r_hudOutlineFillColor1", "1 1 1 .2");
  setDvar("r_hudOutlineOccludedOutlineColor", "1 .25 .25 1");
  setDvar("r_hudOutlineOccludedInlineColor", ".7 .7 .7 1");
  setDvar("r_hudOutlineOccludedInteriorColor", "1 0 0 1");
  setDvar("r_hudOutlineOccludedColorFromFill", 1);
}

setup_player_stealth() {
  self notify("setup_player_stealth");
  self endon("setup_player_stealth");
  self endon("disconnect");
  self waittill("spawned_player");

  if(scripts\cp\coop_stealth::level_should_run_sp_stealth()) {
    scripts\engine\utility::flag_wait("level_stealth_initialized");
    scripts\stealth\player::main();
    _func_531194F673A06DE5(0);
    thread scripts\cp\coop_stealth::suspicious_door_monitor();
  }
}

track_forward_velocity() {
  self notify("track_forward_velocity");
  self endon("track_forward_velocity");
  self endon("disconnect");
  self waittill("spawned_player");
  self.velo_array = [];
  self.average_velo = (0, 0, 0);
  self.mag_array = [];
  self.average_mag = 0;
  self.velo_forward = self.origin;
  self.velo_forward_memory = [];
  _id_0C690971453D240F = 0;
  _id_AD8C91B69D4E6868 = 0;
  _id_14CC1F4D241C2506 = 0;
  _id_A345E8165850A107 = 0;
  _id_B98E1CC2E2BF1F8C = undefined;

  for(;;) {
    velocity = self getvelocity();
    _id_6D906809844C7CB1 = [];
    _id_685EDEBDE05DB999 = [1024 * min(length(velocity) / 240, 1)];
    _id_9BCCABB90A92AA8C = [];

    if(velocity != (0, 0, 0)) {
      if(!isDefined(_id_B98E1CC2E2BF1F8C) || distance2dsquared(self.origin, _id_B98E1CC2E2BF1F8C) >= 62500) {
        _id_0C690971453D240F = 1;
        _id_AD8C91B69D4E6868 = 1;
        _id_14CC1F4D241C2506 = 0;
        _id_A345E8165850A107 = 0;
        _id_9BCCABB90A92AA8C[_id_9BCCABB90A92AA8C.size] = self.origin;
        _id_6D906809844C7CB1[_id_6D906809844C7CB1.size] = velocity;
        _id_B98E1CC2E2BF1F8C = self.origin;
      } else {
        _id_14CC1F4D241C2506++;
        _id_A345E8165850A107++;

        if(_id_14CC1F4D241C2506 >= 12) {
          _id_14CC1F4D241C2506 = 0;
          _id_0C690971453D240F = 0;
        }

        if(_id_A345E8165850A107 >= 5) {
          _id_A345E8165850A107 = 0;
          _id_AD8C91B69D4E6868 = 0;
        }
      }
    } else {
      _id_14CC1F4D241C2506++;
      _id_A345E8165850A107++;

      if(_id_14CC1F4D241C2506 >= 12) {
        _id_14CC1F4D241C2506 = 0;
        _id_0C690971453D240F = 0;
      }

      if(_id_A345E8165850A107 >= 5) {
        _id_A345E8165850A107 = 0;
        _id_AD8C91B69D4E6868 = 0;
      }
    }

    _id_D12F2C604EEFFB33 = _id_685EDEBDE05DB999[0];
    _id_A5407B03B3E5F39F = int(min(20, self.velo_array.size));

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A5407B03B3E5F39F; _id_AC0E594AC96AA3A8++) {
      if(!_id_0C690971453D240F && _id_AC0E594AC96AA3A8 + 1 >= _id_A5407B03B3E5F39F) {
        _id_0C690971453D240F = 1;
        break;
      }

      _id_6D906809844C7CB1[_id_6D906809844C7CB1.size] = self.velo_array[_id_AC0E594AC96AA3A8];
      _id_685EDEBDE05DB999[_id_685EDEBDE05DB999.size] = self.mag_array[_id_AC0E594AC96AA3A8];
      _id_D12F2C604EEFFB33 = _id_D12F2C604EEFFB33 + self.mag_array[_id_AC0E594AC96AA3A8];
    }

    _id_6941E2C17CFF7386 = 5;

    if(isDefined(level.disable_recent_area_memory))
      _id_6941E2C17CFF7386 = level.disable_recent_area_memory;

    _id_A5407B03B3E5F39F = int(min(_id_6941E2C17CFF7386, self.velo_forward_memory.size));

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A5407B03B3E5F39F; _id_AC0E594AC96AA3A8++) {
      if(!_id_AD8C91B69D4E6868 && _id_AC0E594AC96AA3A8 + 1 >= _id_A5407B03B3E5F39F) {
        _id_AD8C91B69D4E6868 = 1;
        break;
      }

      index = _id_9BCCABB90A92AA8C.size;
      _id_9BCCABB90A92AA8C[index] = self.velo_forward_memory[_id_AC0E594AC96AA3A8];
    }

    self.velo_forward_memory = _id_9BCCABB90A92AA8C;
    self.velo_array = _id_6D906809844C7CB1;

    if(self.velo_array.size > 0)
      self.average_velo = calculate_average_velocity(self.velo_array);

    self.mag_array = _id_685EDEBDE05DB999;
    self.average_mag = _id_D12F2C604EEFFB33 / self.mag_array.size;
    self.velo_forward = self.origin + vectorNormalize(self.average_velo) * self.average_mag;
    wait 0.5;
  }
}

calculate_average_velocity(array) {
  if(array.size == 1)
    return array[0];

  average_velo = array[0];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++)
    average_velo = average_velo + array[_id_AC0E594AC96AA3A8];

  return average_velo / array.size;
}

give_playtest_munitions() {
  self endon("disconnect");
  self waittill("spawned_player");
  scripts\engine\utility::ent_flag_wait("intro_binks_complete");
  wait 2;
  self.munition_splash_supress = 1;

  if(allow_munitions(self)) {
    _id_644C18834356D9DC::give_munition_to_slot("ammo_crate", 1);
    _id_644C18834356D9DC::give_munition_to_slot("armor", 2);
    _id_644C18834356D9DC::give_munition_to_slot("grenade_crate", 3);
  }

  self.munition_splash_supress = undefined;
}

allow_munitions(player) {
  if(isDefined(level.allow_munitions))
    return [[level.allow_munitions]](player);

  return 1;
}

playermonitor() {
  thread slidemonitor();
  thread forceendmonitor();
  setup_button_notifys();
  _id_644C18834356D9DC::_id_077084F05581A035();
  thread player_broadcast();
  thread _id_12E2FB553EC1605E::change_loadout_watcher(self);
}

_id_64908CF46D806427() {
  if(!isDefined(level.teamdata["allies"]))
    level.teamdata["allies"] = [];

  if(!isDefined(level.teamdata["allies"]["players"]))
    level.teamdata["allies"]["players"] = [];

  if(!isDefined(level.teamdata["axis"]["players"]))
    level.teamdata["axis"]["players"] = [];

  level.teamdata["allies"]["players"][level.teamdata["allies"]["players"].size] = self;
}

_id_7FDEB6DCCFD886AB(player) {
  if(!isDefined(level.teamdata["allies"]))
    level.teamdata["allies"] = [];

  if(!isDefined(level.teamdata["allies"]["players"]))
    level.teamdata["allies"]["players"] = [];

  if(!isDefined(level.teamdata["axis"]["players"]))
    level.teamdata["axis"]["players"] = [];

  level.teamdata["allies"]["players"] = scripts\engine\utility::array_remove(level.teamdata["allies"]["players"], player);
}

_id_5C9544EF10CB9E0C(_id_401C3A2E68AAB0FD) {
  _id_04CDABCD91A92977::_id_8CF8FF669AC52156(_id_401C3A2E68AAB0FD, 1);
}

_id_2A643088582C8BE3(_id_4B86A4E17C656399, progress, _id_0ABC57BB73D4BF1A) {
  _id_04CDABCD91A92977::_id_A1B2DC3090437789(_id_4B86A4E17C656399, progress, _id_0ABC57BB73D4BF1A);
}

_id_E14E30E8C9C40402() {
  thread _id_BFC702532EEAD581();
}

_id_BFC702532EEAD581() {
  self endon("disconnect");
  scripts\engine\utility::flag_wait("level_ready_for_script");

  foreach(player in level.players)
  player _id_07C40FA80892A721::_id_1B593D5E688A409C();

  level thread _id_74502A9E0EF1F19C::_id_F2525BF18ABAD733("iw9_armor_plate_deploy_mp");
}

_id_41F5E1B0D3379C5C(_id_EA3E3B2121E6713A, _id_E1D097C517C3AF5B) {
  if(isDefined(_id_EA3E3B2121E6713A)) {
    switch (_id_EA3E3B2121E6713A) {
      case "br_drop_all":
        _id_22366EC9A93104DB = 1;
        drop_type = undefined;
        count = undefined;

        switch (_id_E1D097C517C3AF5B) {
          case 0:
            _id_8334742FE1363A27 = _id_3BCAA2CBAF54ABDD::get_player_currency();

            if(thread _id_3BCAA2CBAF54ABDD::try_take_player_currency(_id_8334742FE1363A27)) {
              _id_22366EC9A93104DB = 1;
              count = _id_8334742FE1363A27;
              drop_type = "brloot_plunder_cash_common_1";

              if(_id_8334742FE1363A27 >= 5000)
                drop_type = "brloot_plunder_cash_epic_1";
              else if(_id_8334742FE1363A27 >= 2500)
                drop_type = "brloot_plunder_cash_rare_1";
              else if(_id_8334742FE1363A27 >= 1000)
                drop_type = "brloot_plunder_cash_uncommon_1";
            }

            break;
          case 2:
            if(isDefined(self.armorqueued) && self.armorqueued >= 1) {
              drop_type = "brloot_armor_plate";
              count = self.armorqueued;
              _id_22366EC9A93104DB = 1;
              _id_4D61729C67E951B3();
            }

            break;
          case 3:
            drop_type = "brloot_ammo_762";

            if(_id_C5251179824F0DEB(drop_type)) {
              count = _id_F9C71B46B5E50150(drop_type, _id_93F256198133479F(drop_type));
              _id_22366EC9A93104DB = 1;
            }

            break;
          case 5:
            drop_type = "brloot_ammo_919";

            if(_id_C5251179824F0DEB(drop_type)) {
              count = _id_F9C71B46B5E50150(drop_type, _id_93F256198133479F(drop_type));
              _id_22366EC9A93104DB = 1;
            }

            break;
          case 4:
            drop_type = "brloot_ammo_12g";

            if(_id_C5251179824F0DEB(drop_type)) {
              count = _id_F9C71B46B5E50150(drop_type, _id_93F256198133479F(drop_type));
              _id_22366EC9A93104DB = 1;
            }

            break;
          case 7:
            drop_type = "brloot_ammo_50cal";

            if(_id_C5251179824F0DEB(drop_type)) {
              count = _id_F9C71B46B5E50150(drop_type, _id_93F256198133479F(drop_type));
              _id_22366EC9A93104DB = 1;
            }

            break;
          case 6:
            drop_type = "brloot_ammo_rocket";

            if(_id_C5251179824F0DEB(drop_type)) {
              count = _id_F9C71B46B5E50150(drop_type, _id_93F256198133479F(drop_type));
              _id_22366EC9A93104DB = 1;
            }

            break;
          case 9:
            item = scripts\cp\cp_weapons::drop_weapon_scripted(1, 180);

            if(isDefined(item)) {
              _id_9111B9A018285894 = scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();

              foreach(weapon in _id_9111B9A018285894) {
                if(weapon.basename != "none" && weapon.basename != item.objweapon.basename) {
                  scripts\cp\cp_weapons::switchtoweaponreliable(weapon);

                  if(_id_9111B9A018285894.size == 1 && weapon.basename != "iw9_me_fists_mp")
                    self giveweapon("iw9_me_fists_mp");

                  break;
                }
              }

              if(_id_9111B9A018285894.size == 0)
                self giveweapon("iw9_me_fists_mp");

              _id_22366EC9A93104DB = 1;
            }

            break;
        }

        if(_id_22366EC9A93104DB && isDefined(drop_type) && isDefined(count)) {
          _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(0, self.origin, self.angles, self);
          item = _id_66122A002AFF5D57::spawnpickup(drop_type, _id_CB4FAD49263E20C4, count, 1, undefined, 0);
        }

        break;
      case "dpad_slot_down":
        _id_22366EC9A93104DB = 1;
        drop_type = undefined;
        count = undefined;

        switch (_id_E1D097C517C3AF5B) {
          case 0:
            _id_A1708BF4C9F30FD8 = 500;
            _id_8334742FE1363A27 = _id_3BCAA2CBAF54ABDD::get_player_currency();

            if(_id_8334742FE1363A27 > 0) {
              _id_7AACA62C33E5F649 = int(min(_id_A1708BF4C9F30FD8, _id_8334742FE1363A27));

              if(thread _id_3BCAA2CBAF54ABDD::try_take_player_currency(_id_7AACA62C33E5F649)) {
                drop_type = "brloot_plunder_cash_common_1";
                count = _id_7AACA62C33E5F649;
                _id_22366EC9A93104DB = 1;
              }
            }

            break;
          case 2:
            drop_type = "brloot_armor_plate";
            count = 1;
            _id_22366EC9A93104DB = 1;
            _id_0974FB5E98D373E0();
            break;
          case 3:
            drop_type = "brloot_ammo_762";

            if(_id_C5251179824F0DEB(drop_type)) {
              count = _id_F9C71B46B5E50150(drop_type, 30);
              _id_22366EC9A93104DB = 1;
            }

            break;
          case 5:
            drop_type = "brloot_ammo_919";

            if(_id_C5251179824F0DEB(drop_type)) {
              count = _id_F9C71B46B5E50150(drop_type, 13);
              _id_22366EC9A93104DB = 1;
            }

            break;
          case 4:
            drop_type = "brloot_ammo_12g";

            if(_id_C5251179824F0DEB(drop_type)) {
              count = _id_F9C71B46B5E50150(drop_type, 10);
              _id_22366EC9A93104DB = 1;
            }

            break;
          case 7:
            drop_type = "brloot_ammo_50cal";

            if(_id_C5251179824F0DEB(drop_type)) {
              count = _id_F9C71B46B5E50150(drop_type, 10);
              _id_22366EC9A93104DB = 1;
            }

            break;
          case 6:
            drop_type = "brloot_ammo_rocket";

            if(_id_C5251179824F0DEB(drop_type)) {
              count = _id_F9C71B46B5E50150(drop_type, 1);
              _id_22366EC9A93104DB = 1;
            }

            break;
        }

        if(_id_22366EC9A93104DB && isDefined(drop_type) && isDefined(count)) {
          _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(0, self.origin, self.angles, self);
          item = _id_66122A002AFF5D57::spawnpickup(drop_type, _id_CB4FAD49263E20C4, count, 1, undefined, 0);
        }

        break;
      case "dpad_slot_up":
        break;
      case "dpad_perk_buy":
        break;
      case "drop_item":
      default:
        break;
    }
  }
}

_id_4D61729C67E951B3() {
  if(isDefined(self.armorqueued) && self.armorqueued > 0) {
    self.armorqueued = 0;
    self setclientomnvar("ui_equipment_id_health", 27);
    self setclientomnvar("ui_equipment_id_health_numCharges", self.armorqueued);
  }
}

_id_0974FB5E98D373E0() {
  if(isDefined(self.armorqueued) && self.armorqueued > 0) {
    self.armorqueued--;
    self setclientomnvar("ui_equipment_id_health", 27);
    self setclientomnvar("ui_equipment_id_health_numCharges", self.armorqueued);
  }
}

_id_C5251179824F0DEB(drop_type) {
  return self.br_ammo[drop_type] > 0;
}

_id_93F256198133479F(drop_type) {
  return self.br_ammo[drop_type];
}

_id_F9C71B46B5E50150(drop_type, _id_A586C04E36B58E35) {
  if(self.br_ammo[drop_type] > 0) {
    if(self.br_ammo[drop_type] >= _id_A586C04E36B58E35)
      count = _id_A586C04E36B58E35;
    else
      count = self.br_ammo[drop_type];

    self.br_ammo[drop_type] = self.br_ammo[drop_type] - count;
    _id_66122A002AFF5D57::br_ammo_update_weapons();
    return count;
  } else
    return undefined;
}

_id_5CE6E63DF1D04ECA() {
  self.guid = scripts\cp\utility::getuniqueid();
  self.clientid = game["clientid"];
  game["clientid"]++;
  self.usingonlinedataoffline = self isusingonlinedataoffline();
  self.connected = 1;
  self.waitingtospawn = 0;
  self.movespeedscaler = 1;
  self.objectivescaler = 1;
  self.inlaststand = 0;
  self.no_team_outlines = 0;
  self.no_outline = 0;
  self.enemy_list = [];
  self.assigned_ai = 0;
  thread _id_76CC264B397DB9CB::setsquad("allies");
}

_id_6C3EFB0E9DA75C0C() {
  if(!isDefined(level._id_0EFD26B348839344))
    level._id_0EFD26B348839344 = -1;

  level._id_0EFD26B348839344++;
  return level._id_0EFD26B348839344;
}

_id_3999591663B82C6A() {
  initclientdvarssplitscreenspecific();
  self setclientdvars("cg_deadChatWithDead", 0, "cg_deadChatWithTeam", 1, "cg_deadHearTeamLiving", 1, "cg_deadHearAllLiving", 0);

  if(level.teambased)
    self setclientdvar("cg_everyoneHearsEveryone", 0);
}

initclientdvarssplitscreenspecific() {
  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars("cg_fovScale", "0.75");
    setDvar("r_materialbloomhqscriptmasterenable", 0);
  } else
    self setclientdvars("cg_fovScale", "1");
}

_id_8259ED9008F45C23() {
  self.saved_actionslotdata = [];

  for(_id_81DF7FA84A06A6D0 = 1; _id_81DF7FA84A06A6D0 <= 4; _id_81DF7FA84A06A6D0++) {
    self.saved_actionslotdata[_id_81DF7FA84A06A6D0] = spawnStruct();
    self.saved_actionslotdata[_id_81DF7FA84A06A6D0].type = "";
    self.saved_actionslotdata[_id_81DF7FA84A06A6D0].item = undefined;
  }

  if(!self isconsoleplayer()) {
    for(_id_81DF7FA84A06A6D0 = 5; _id_81DF7FA84A06A6D0 <= 8; _id_81DF7FA84A06A6D0++) {
      self.saved_actionslotdata[_id_81DF7FA84A06A6D0] = spawnStruct();
      self.saved_actionslotdata[_id_81DF7FA84A06A6D0].type = "";
      self.saved_actionslotdata[_id_81DF7FA84A06A6D0].item = undefined;
    }
  }
}

_id_CCC85FDB936857B3() {
  self.perks = [];
  self.perksperkname = [];
}

slidemonitor() {
  self endon("disconnect");

  for(;;) {
    self waittill("sprint_slide_begin");
    self playFX(level._effect["slide_dust"], self getEye());
  }
}

forceendmonitor() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, val);

    if(_id_7148C1A6F25491F8 == "arcade_off")
      self notify("adjustedstance");

    if(_id_7148C1A6F25491F8 == "end_game") {
      level thread[[level.forceendgame]]();
      self notify("disconnect");
    }
  }
}

setup_button_notifys() {
  self setactionslot(1, "");

  if(istrue(level.disable_nvg))
    self setactionslot(2, "");

  self setactionslot(2, "");
  self setactionslot(3, "");
  self setactionslot(4, "");
  self notifyonplayercommand("d_pad_up", "+actionslot 1");
  self notifyonplayercommand("d_pad_down", "+actionslot 2");
  self notifyonplayercommand("d_pad_left", "+actionslot 3");
  self notifyonplayercommand("d_pad_right", "+actionslot 4");
  self notifyonplayercommand("kbm_armor", "killstreak2");
}

_id_FCD3A5870BCEC50C(_id_7148C1A6F25491F8, value) {
  if(_id_7148C1A6F25491F8 == "backpack_toggled") {
    if(value == 0)
      _id_66122A002AFF5D57::_id_F0A8D592BDDE9818();
    else
      _id_66122A002AFF5D57::_id_410042DC2CC03264();
  }
}

spawnintermission(_id_1379934A423852EF) {
  level endon("exitLevel_called");
  self endon("disconnect");
  setglobalintermissionspawninfo();
  _id_E87CC8634B3E137F = self.forcespawnangles;
  self _meth_BC667001F9DD3808(self.forcespawnorigin);
  wait 2;

  while(!self ispredictedstreamposready())
    wait 0.5;

  spawnplayer();
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer())
    self setclientdvar("cg_fov", "90");

  scripts\cp\utility::updatesessionstate("intermission");
  self clearpredictedstreampos();
}

setglobalintermissionspawninfo() {
  _id_F0E8BFBC0E6F690A = getglobalintermissionpoint();
  setforcespawninfo(_id_F0E8BFBC0E6F690A.origin, _id_F0E8BFBC0E6F690A.angles);
}

setforcespawninfo(origin, angles) {
  self.forcespawnorigin = origin;
  self.forcespawnangles = angles;
}

getglobalintermissionpoint() {
  spawnpoints = getEntArray("mp_global_intermission", "classname");
  return spawnpoints[0];
}

spawnplayer(_id_13FE2B86C5E85A64, _id_546519C4D54162CC, _id_EF83A4D91DF14784) {
  if(isDefined(_id_546519C4D54162CC) && _id_546519C4D54162CC > 0)
    wait(_id_546519C4D54162CC);

  thread spawnplayer_internal(_id_13FE2B86C5E85A64, _id_EF83A4D91DF14784);
}

spawnplayer_internal(_id_13FE2B86C5E85A64, _id_EF83A4D91DF14784) {
  level endon("game_ended");
  self notify("spawnplayer_internal");
  self endon("spawnplayer_internal");
  self endon("disconnect");
  self endon("joined_spectators");

  if(self.waitingtospawn) {
    return;
  }
  waitforspawn();
  spawnplayer_actual(_id_13FE2B86C5E85A64, _id_EF83A4D91DF14784);
}

waitforspawn() {
  self.waitingtospawn = 1;

  if(scripts\cp\utility::isusingremote())
    self waittill("stopped_using_remote");

  self.waitingtospawn = 0;
}

_id_D98E304DD9D5D8CD() {
  game["numPlayersConsideredPlaying"] = 0;
  game["matchHasMoreThan1Player"] = 0;
}

_id_DCAD74D2A0609F85() {
  if(!isDefined(game["numPlayersConsideredPlaying"]))
    _id_D98E304DD9D5D8CD();

  _id_2D9482A14615CC39 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]++;

  if(!game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] > 1)
      game["matchHasMoreThan1Player"] = 1;
  }

  if(game["matchHasMoreThan1Player"]) {
    if(!_id_2D9482A14615CC39) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
        level.players[_id_AC0E594AC96AA3A8] setclientomnvar("match_has_more_than_1_player", 1);
    } else
      self setclientomnvar("match_has_more_than_1_player", 1);
  }
}

updatematchhasmorethan1playeromnvaronplayerdisconnect() {
  _id_2D9482A14615CC39 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]--;

  if(game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] <= 1)
      game["matchHasMoreThan1Player"] = 0;
  }

  if(!game["matchHasMoreThan1Player"]) {
    if(_id_2D9482A14615CC39) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
        level.players[_id_AC0E594AC96AA3A8] setclientomnvar("match_has_more_than_1_player", 0);
    }
  }
}

_id_C2E445D76A446AA0() {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case "cp_raid1_maze":
    case "cp_raid1test":
    case "cp_hydro":
      return 0;
    default:
      return 1;
  }
}

_id_297BF30B6352B598(player) {
  _id_D16569F10048FCE9 = undefined;
  _id_10FD8ED3FED0E0AE = undefined;

  if(isDefined(player._id_0BFEBCD1C49C31E8)) {
    _id_10FD8ED3FED0E0AE = player._id_0BFEBCD1C49C31E8;
    player._id_0BFEBCD1C49C31E8 = undefined;
  }

  return [_id_D16569F10048FCE9, _id_10FD8ED3FED0E0AE];
}

spawnplayer_actual(_id_13FE2B86C5E85A64, _id_EF83A4D91DF14784) {
  self notify("spawned");
  self notify("started_spawnplayer");
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();
  _id_F4ABAFA11215D661 = istrue(level._id_A3E60D4FD52EFC95) && isDefined(self.forcespawnorigin) && isDefined(self.forcespawnangles);

  if(checkpoint != "" && !istrue(_id_F4ABAFA11215D661)) {
    _id_7AE2E9DAEB3B303B = _id_C2E445D76A446AA0();

    if(_id_7AE2E9DAEB3B303B || (istrue(level._id_CAADFDA74F61A3CA) || !istrue(_id_EF83A4D91DF14784))) {
      if(isDefined(game["override_checkpoint_func"]) && isDefined(game["override_checkpoint_spawn_name"])) {
        _id_0F0700E8B95517CB = scripts\engine\utility::getStructArray(game["override_checkpoint_spawn_name"], "targetname");
        _id_EA847593E957F2B0 = game["override_checkpoint_func"];
        spawnpoint = [[_id_EA847593E957F2B0]](_id_0F0700E8B95517CB);
      } else
        spawnpoint = scripts\cp\cp_checkpoint::checkpoint_get_item(checkpoint, "player_spawn");

      if(isDefined(spawnpoint)) {
        self.forcespawnorigin = spawnpoint.origin;
        self.checkpointstruct = spawnpoint;
        spawnpoint scripts\cp\utility::_id_9EC4754A395BCC2D();
        self.forcespawnangles = spawnpoint.angles;
        spawnpoint thread scripts\cp\cp_checkpoint::checkpoint_release_spawnpoint(self);
      }
    }
  }

  if(istrue(_id_13FE2B86C5E85A64)) {
    if(level.gameended)
      self spawn(_id_95B85B8E7CCE3028(self, 1), _id_014850251D755F82(self));
  } else if(level.gameended)
    self spawn(_id_95B85B8E7CCE3028(self, 1), _id_014850251D755F82(self));
  else
    self spawn(_id_95B85B8E7CCE3028(self), _id_014850251D755F82(self));

  broadcast_status(self, 0);

  if(istrue(self._id_E5E63A2028402D60))
    scripts\cp_mp\utility\player_utility::_id_82F44F5F304BA91A(1);

  _id_9F5574F906E43A39();
  _id_CFCFA5E7A3E83553();
  _id_8631490F6F8345AD();
  self setclientomnvar("ui_stop_armor_hint", 0);

  if(isDefined(self.body)) {
    self.body delete();
    self.body = undefined;
  }

  _id_13FE2B86C5E85A64 = scripts\engine\utility::ter_op(isDefined(_id_13FE2B86C5E85A64), _id_13FE2B86C5E85A64, 0);

  if(!_id_13FE2B86C5E85A64)
    _id_4CF2BFBD74938A5B();

  if(isai(self))
    _id_A4D80FF0B2718938(_id_13FE2B86C5E85A64);

  [[level.onspawnplayer]](_id_13FE2B86C5E85A64);

  if(!_id_13FE2B86C5E85A64)
    scripts\cp\cp_visionsets::create_visionset_stack(self);

  self[[level.custom_giveloadout]](_id_13FE2B86C5E85A64, undefined, self.defaultclassindex);

  if(getdvarint("camera_thirdPerson"))
    scripts\cp\utility::setthirdpersondof(1);

  scripts\cp\utility::giveperk("specialty_pistoldeath");
  self painvisionon();

  if(istrue(level.disable_nvg))
    self setactionslot(2, "");

  self setactionslot(3, "altmode");
  self setclientomnvar("ui_hide_objectives", 0);
  waittillframeend;

  if(_id_13FE2B86C5E85A64) {
    scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
    scripts\cp\utility::allow_player_ignore_me(1);
  }

  self notify("spawned_player");
  level notify("player_spawned", self);
  self._id_EAA61B501C84602E = 1;
  thread hudbooted();
  thread allow_dvar_infammo();
  thread scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_monitorplayerusability(self);
  thread _id_6E09A830FAB9468F::markedentities_think();
  _id_5814D27874B48E54 = _id_B9953EB97AD6C0D2();
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_player_spawned", _id_5814D27874B48E54.player);
  _id_3D5DC66341D1ED92::_id_A48A39A256E53D99();
  self.no_outline = 0;
  self.no_team_outlines = 0;
  self._id_07C968C5609ADED2 = 0;
  scripts\cp\utility::_unsetperk("specialty_spygame");
  scripts\cp\utility::_unsetperk("specialty_coldblooded");
  scripts\cp\utility::_unsetperk("specialty_noscopeoutline");
  scripts\cp\utility::_unsetperk("specialty_heartbreaker");
  self notify("force_regeneration");

  if(istrue(level._id_2DCE4D6DCB6C3FB9)) {
    scripts\cp\utility::restore_weapons_status([]);
    _id_1DB8D0E02A99C5E2::_id_2DD3214261E60026();
  }

  if(istrue(self.bspawningviaac130))
    _id_0AFB7E332AEE4BF2::give_fists_if_no_real_weapon(self);
  else if(!istrue(_id_13FE2B86C5E85A64) && !_id_467F0FDFDD155A45::gamealreadyended()) {
    if(!istrue(self.ishotjoiningplayer)) {
      thread open_loadout_menu();
      scripts\engine\utility::waittill_any_2("loadout_given", "start_hotjoining_via_c130");
      _id_DCAD74D2A0609F85();

      if(isDefined(level.post_loadout_spawn_func))
        self thread[[level.post_loadout_spawn_func]]();
    }
  }
}

hudbooted() {
  self endon("disconnect");
  resetplayerspawnomnvar();
}

resetplayerspawnomnvar() {
  self setclientomnvar("ui_hud_shake", 0);
  self setclientomnvar("cp_super_fired", 0);
  clientnum = self getentitynumber();
  setomnvar("cp_team_oriented_super_ended", clientnum);

  if(_id_C2906D44795D8F40() || scripts\cp\utility::_id_93D685AC42F15C61())
    self setclientomnvar("ui_hide_minimap", 0);
  else
    self setclientomnvar("ui_hide_minimap", 1);

  scripts\cp\utility::init_vehicle_omnvars();
}

_id_C2906D44795D8F40() {
  return istrue(level.minimaponbydefault);
}

open_loadout_menu() {
  if(!scripts\cp\utility::is_wave_gametype() && !scripts\cp\utility::_id_A3577E8E6C88A56B() && !scripts\cp\utility::_id_F620E996A1D7D81A()) {
    self waittill("open_loadout_menu");
    self setclientomnvar("ui_options_menu", 2);
  }
}

_id_9F5574F906E43A39() {
  self stopshellshock();
  self stoprumble("damage_heavy");
  self setdepthoffield(0, 0, 512, 512, 4, 0);

  if(self isconsoleplayer())
    self setclientdvar("cg_fov", "65");
}

_id_8631490F6F8345AD() {
  if(isDefined(self.additivedamagemodifiers)) {
    _id_93AA207EB1B3C1D2 = getarraykeys(self.additivedamagemodifiers);

    foreach(key in _id_93AA207EB1B3C1D2)
    scripts\cp\utility::removedamagemodifier(key, 1);
  }

  if(isDefined(self.multiplicativedamagemodifiers)) {
    _id_93AA207EB1B3C1D2 = getarraykeys(self.multiplicativedamagemodifiers);

    foreach(key in _id_93AA207EB1B3C1D2)
    scripts\cp\utility::removedamagemodifier(key, 0);
  }
}

_id_CFCFA5E7A3E83553() {
  team = getspawnteamassignment();
  self.team = team;
  self.sessionteam = getspawnsessionteamassignment(team);
  self.pers["team"] = team;
  self.fauxdead = undefined;
  self.movespeedscaler = 1;
  _id_3B64EB40368C1450::nuke("weapon");
  _id_3B64EB40368C1450::nuke("offhand_weapons");
  self.hasriotshieldequipped = 0;
  self.hasriotshield = 0;
  self._id_198B774C93C48891 = undefined;
  self._id_9691E7D8CDE294F2 = undefined;
}

getspawnteamassignment() {
  if(isDefined(level.playerspawnteamassignmentfunc))
    return [[level.playerspawnteamassignmentfunc]](self);

  return "allies";
}

getspawnsessionteamassignment(team) {
  if(isDefined(level.playerspawnsessionteamassignmentfunc))
    return [[level.playerspawnsessionteamassignmentfunc]](self, team);

  return team;
}

_id_4CF2BFBD74938A5B() {
  resetnonfauxspawnscriptfields();
  scripts\cp\utility::updatesessionstate("playing");
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

_id_A4D80FF0B2718938(_id_13FE2B86C5E85A64) {
  if(!_id_13FE2B86C5E85A64) {
    if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["player_spawned"]))
      self[[level.bot_funcs["player_spawned"]]]();
  }
}

_id_95B85B8E7CCE3028(player, _id_A889D598403B4DE6) {
  spawnorigin = undefined;
  _id_9FBA0D30D2B918DB = istrue(level.skip_nav_check_on_spectate_respawn);

  if(istrue(self._id_D88F609DB87E5503)) {
    _id_9FBA0D30D2B918DB = 1;
    self._id_D88F609DB87E5503 = undefined;
  }

  if(isDefined(player.forcespawnorigin)) {
    spawnorigin = player.forcespawnorigin;

    if(!_id_9FBA0D30D2B918DB)
      spawnorigin = getclosestpointonnavmesh(spawnorigin);

    if(isDefined(_id_A889D598403B4DE6))
      spawnorigin = player.forcespawnorigin;

    player.forcespawnorigin = undefined;
  } else {
    spawnpoint = player[[level.getspawnpoint]]();
    spawnorigin = scripts\engine\utility::ter_op(istrue(level.disable_start_spawn_on_navmesh), scripts\engine\utility::drop_to_ground(spawnpoint.origin, 32, -100), getclosestpointonnavmesh(spawnpoint.origin));

    if(getdvarint("dvar_B80F97B9C08F17F5", 0))
      spawnorigin = scripts\engine\utility::ter_op(istrue(level.disable_start_spawn_on_navmesh), spawnpoint.origin, getclosestpointonnavmesh(spawnpoint.origin));

    if(isDefined(_id_A889D598403B4DE6))
      spawnorigin = spawnpoint;
  }

  return spawnorigin;
}

_id_014850251D755F82(player) {
  spawnangles = undefined;

  if(isDefined(player.forcespawnangles)) {
    spawnangles = player.forcespawnangles;
    player.forcespawnangles = undefined;
  } else {
    spawnpoint = player[[level.getspawnpoint]]();
    spawnangles = scripts\engine\utility::ter_op(isDefined(spawnpoint.angles), spawnpoint.angles, (0, 0, 0));
  }

  return spawnangles;
}

_id_382AB3472A4DA4E6() {
  _id_F0E8BFBC0E6F690A = getglobalintermissionpoint();
  self setspectatedefaults(_id_F0E8BFBC0E6F690A.origin, _id_F0E8BFBC0E6F690A.angles);
  setforcespawninfo(_id_F0E8BFBC0E6F690A.origin, _id_F0E8BFBC0E6F690A.angles);
  setspectaterules();
  scripts\cp\utility::updatesessionstate("spectator");
  thread _id_3141EA1D420F1715();
}

_id_3141EA1D420F1715() {
  self endon("disconnect");
  self endon("last_stand_finished");
  self endon("laststand_revived");
  self endon("spawned");
  level endon("game_ended");

  for(;;) {
    level waittill("player_disconnect");

    if(level.players.size == 1) {
      level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
      continue;
    }

    if(_id_0AFB7E332AEE4BF2::everyone_else_all_in_laststand())
      level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
  }
}

setspectaterules() {
  if(isDefined(level.spectaterulesfunc))
    [[level.spectaterulesfunc]](self);
  else
    defaultspectaterules(self);
}

defaultspectaterules(player) {
  player allowspectateteam("allies", 1);
  player allowspectateteam("axis", 1);
  player allowspectateteam("freelook", 0);
  player allowspectateteam("none", 1);
}

defaultplayerdisconnect(_id_401C3A2E68AAB0FD) {
  if(!isDefined(self.connected)) {
    return;
  }
  scripts\cp\cp_analytics::on_player_disconnect(_id_401C3A2E68AAB0FD);
  _id_5814D27874B48E54 = spawnStruct();
  _id_5814D27874B48E54.player = self;
  _id_5814D27874B48E54._id_934DC135AAF6F953 = _id_401C3A2E68AAB0FD;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_player_disconnect", _id_5814D27874B48E54);

  if(isDefined(self.team))
    _id_76CC264B397DB9CB::leavesquad(self.team, self._id_0FF97225579DE16A);

  removeplayerfromlevelarrays(self);

  if(disconnectshouldforceend()) {
    reset_map_dvars();

    if(level.players.size == 0)
      level thread _id_467F0FDFDD155A45::endgame("axis", _id_467F0FDFDD155A45::get_end_game_string_index("host_end"));
    else
      level thread _id_467F0FDFDD155A45::endgame("axis", _id_467F0FDFDD155A45::get_end_game_string_index("kia"));
  }

  if(isDefined(level.onplayerdisconnect))
    level thread[[level.onplayerdisconnect]](self, _id_401C3A2E68AAB0FD);

  level thread scripts\cp\utility\disconnect_event_aggregator::rundisconnectcallbacks(self);
  updatematchhasmorethan1playeromnvaronplayerdisconnect();
  level notify("player_disconnect");
}

disconnectshouldforceend() {
  if(level.splitscreen)
    return level.players.size <= 1;

  if(level.players.size < 1)
    return 1;

  gameshouldend = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(level.players[_id_AC0E594AC96AA3A8]))
      gameshouldend = _id_0AFB7E332AEE4BF2::_id_5DE995015A65E87D(level.players[_id_AC0E594AC96AA3A8]);
  }

  return gameshouldend;
}

addplayertolevelarrays(player) {
  level.players[level.players.size] = player;
  level.participants[level.participants.size] = player;
  level.characters[level.characters.size] = player;
}

removeplayerfromlevelarrays(player) {
  level.players = scripts\engine\utility::array_remove(level.players, player);
  level.participants = scripts\engine\utility::array_remove(level.participants, player);
  level.characters = scripts\engine\utility::array_remove(level.characters, player);
}

defaultplayermigrated() {
  if(self ishost())
    initclientdvarssplitscreenspecific();

  if(ishumanplayer(self)) {
    _id_B287376C626B75B6 = 0;

    foreach(player in level.players) {
      if(ishumanplayer(player))
        _id_B287376C626B75B6++;
    }

    level.hostmigrationreturnedplayercount++;

    if(level.hostmigrationreturnedplayercount >= _id_B287376C626B75B6 * 2 / 3)
      level notify("hostmigration_enoughplayers");
  }
}

ishumanplayer(player) {
  return !isbot(player) && !istestclient(player);
}

defaulthostmigration() {
  if(level.gameended) {
    return;
  }
  level.hostmigrationreturnedplayercount = 0;

  foreach(_id_7DC3241E7F3C6B24 in level.characters)
  _id_7DC3241E7F3C6B24.hostmigrationcontrolsfrozen = 0;

  level.hostmigrationtimer = 1;
  setDvar("ui_inhostmigration", 1);
  level notify("host_migration_begin");

  foreach(_id_7DC3241E7F3C6B24 in level.characters) {
    if(isDefined(_id_7DC3241E7F3C6B24))
      _id_7DC3241E7F3C6B24 thread scripts\cp\cp_hostmigration::hostmigrationtimerthink();

    if(isPlayer(_id_7DC3241E7F3C6B24))
      _id_7DC3241E7F3C6B24 setclientomnvar("ui_session_state", _id_7DC3241E7F3C6B24.sessionstate);
  }

  setDvar("ui_game_state", game["state"]);
  level endon("host_migration_begin");
  scripts\cp\cp_hostmigration::hostmigrationwait();
  level.hostmigrationtimer = undefined;
  setDvar("ui_inhostmigration", 0);

  if(isDefined(level.hostmigrationend))
    level thread[[level.hostmigrationend]]();

  level notify("host_migration_end");
}

_id_FC091EC7A771F2FF() {
  ents = getEntArray("destructable", "targetname");

  if(getDvar("dvar_022975EF58F3A25E") == "0") {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < ents.size; _id_AC0E594AC96AA3A8++)
      ents[_id_AC0E594AC96AA3A8] delete();
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < ents.size; _id_AC0E594AC96AA3A8++)
      ents[_id_AC0E594AC96AA3A8] thread destructable_think();
  }
}

destructable_think() {
  accumulate = 40;
  threshold = 0;

  if(isDefined(self.script_accumulate))
    accumulate = self.script_accumulate;

  if(isDefined(self.script_threshold))
    threshold = self.script_threshold;

  if(isDefined(self.script_fxid))
    self.fx = loadfx(self.script_fxid);

  dmg = 0;
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", amount, other);

    if(amount >= threshold) {
      dmg = dmg + amount;

      if(dmg >= accumulate) {
        thread destructable_destruct();
        return;
      }
    }
  }
}

destructable_destruct() {
  ent = self;

  if(isDefined(ent.fx))
    playFX(ent.fx, ent.origin + (0, 0, 6));

  ent delete();
}

_id_5C5D6F7B09D3C739() {
  level.uiparent = spawnStruct();
  level.uiparent.horzalign = "left";
  level.uiparent.vertalign = "top";
  level.uiparent.alignx = "left";
  level.uiparent.aligny = "top";
  level.uiparent.x = 0;
  level.uiparent.y = 0;
  level.uiparent.width = 0;
  level.uiparent.height = 0;
  level.uiparent.children = [];
  level.fontheight = 12;
  level.hud["allies"] = spawnStruct();
  level.hud["axis"] = spawnStruct();
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
  level.lowertextyalign = "bottom";
  level.lowertexty = -140;
  level.lowertextfontsize = 1.2;
  level.minimaponbydefault = getdvarint("scr_game_enableMinimap") != 0 || getdvarint("dvar_BC802DEB1FF2A842") != 0;
}

exploder_load(trigger) {
  level endon("killexplodertridgers" + trigger.script_exploder);
  trigger waittill("trigger");

  if(isDefined(trigger.script_chance) && randomfloat(1) > trigger.script_chance) {
    if(isDefined(trigger.script_delay))
      wait(trigger.script_delay);
    else
      wait 4;

    level thread exploder_load(trigger);
    return;
  }

  scripts\engine\utility::exploder(trigger.script_exploder);
  level notify("killexplodertridgers" + trigger.script_exploder);
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

blank(_id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_434849FD34BB4BA0, _id_434850FD34BB5B05, _id_43484FFD34BB58D2, _id_43484EFD34BB569F, _id_43484DFD34BB546C, _id_434854FD34BB63D1, _id_434853FD34BB619E, _id_B34F53DAF7F166C2) {}

init_laststand() {
  if(isDefined(level.player_init_laststand_func))
    [[level.player_init_laststand_func]]();
  else
    _id_0AFB7E332AEE4BF2::default_player_init_laststand();
}

_id_7E9D9AC29D0AC7A3() {
  level.killtriggerspawnlocs = scripts\engine\utility::getStructArray("respawn_edge", "targetname");
}

getkilltriggerspawnloc() {
  return scripts\engine\utility::getclosest(self.origin, level.killtriggerspawnlocs);
}

player_broadcast() {
  level endon("game_ended");
  self endon("disconnect");
  wait 1;
  broadcast_status(self, 0);

  for(;;) {
    broadcast_currency(self);
    broadcast_carry_items(self);
    _id_F3467E4343B7B3BF(self);
    wait 5;
  }
}

broadcast_currency(player) {
  _id_1DAB4A6BAD01C509 = player getentitynumber();
  _id_31877A68C46AF8CA = player getplayerdata("cp", "alienSession", "currency");
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "currency", _id_31877A68C46AF8CA);
}

_id_F3467E4343B7B3BF(player) {
  _id_1DAB4A6BAD01C509 = player getentitynumber();
  _id_1C7DBF040C780003 = player _id_5E5507D57BBBB709::_id_CC1CCC9E93B22C24();
  _id_01BC8CC8CE771CC3 = player _id_5E5507D57BBBB709::_id_0CA8C9FF1FF9DB6E();
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "playerRole", _id_1C7DBF040C780003);
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "playerKitTier", _id_01BC8CC8CE771CC3);
}

broadcast_carry_items(player) {
  _id_1DAB4A6BAD01C509 = player getentitynumber();

  if(!isDefined(player.carryitemomnvar))
    player.carryitemomnvar = 0;

  if(!isDefined(player.carryitem2omnvar))
    player.carryitem2omnvar = 0;

  if(!isDefined(player._id_70E7C265A77E6DBF))
    player._id_70E7C265A77E6DBF = 0;

  if(!isDefined(player._id_FE09B9D92140B766))
    player._id_FE09B9D92140B766 = 0;

  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "carryItem2", player.carryitem2omnvar);
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "carryItem", player.carryitemomnvar);
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "carryItem3", player._id_70E7C265A77E6DBF);
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "carryItem4", player._id_FE09B9D92140B766);
}

broadcast_status(player, status) {
  _id_1DAB4A6BAD01C509 = player getentitynumber();
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "playerStatus", status);
}

watch_target_health() {
  self endon("death");
  self endon("disconnect");
  self.targethealthinfo = [];

  for(;;) {
    _id_EE6F2D844D4428E4 = getdvarint("dvar_498C16FCD4CDAD6A", 0);

    if(_id_EE6F2D844D4428E4 == 1) {
      if(self adsButtonPressed()) {
        tracestart = self getEye();
        _id_3C70A7175FBFA3FC = self getplayerangles();
        _id_898F508242FA99F6 = anglesToForward(_id_3C70A7175FBFA3FC);
        _id_8B39E5984DA1FFAF = tracestart + _id_898F508242FA99F6 * 10000;
        results = scripts\engine\trace::_bullet_trace(tracestart, _id_8B39E5984DA1FFAF, 1, self, 0, 0, 0, 0, 0);
        _id_9595F9643C69A295 = results["entity"];

        if(isDefined(_id_9595F9643C69A295) && issentient(_id_9595F9643C69A295) && !isPlayer(_id_9595F9643C69A295)) {
          if(isDefined(_id_9595F9643C69A295.team) && _id_9595F9643C69A295.team == self.team) {
            wait 0.1;
            continue;
          }

          update_target_health_variable("ui_target_health", _id_9595F9643C69A295.health);
          update_target_health_variable("ui_target_max_health", _id_9595F9643C69A295.maxhealth);
          update_target_health_variable("ui_target_entity_num", _id_9595F9643C69A295 getentitynumber());
        } else
          update_target_health_variable("ui_target_entity_num", -1);
      } else
        update_target_health_variable("ui_target_entity_num", -1);
    }

    wait 0.1;
  }
}

update_target_health_variable(_id_E9D476A3809CB3F1, value) {
  wait 0.05;

  if(!isDefined(value)) {
    return;
  }
  if(!isDefined(self.targethealthinfo[_id_E9D476A3809CB3F1]) || value != self.targethealthinfo[_id_E9D476A3809CB3F1]) {
    self setclientomnvar(_id_E9D476A3809CB3F1, value);
    self.targethealthinfo[_id_E9D476A3809CB3F1] = value;
  }
}

allow_dvar_infammo() {
  wait 5;

  if(getdvarint("dvar_F994E29F457ACC28", 0) == 0) {
    return;
  }
  _id_262683DEEA02353A = 0;

  while(_id_262683DEEA02353A < 30) {
    _id_262683DEEA02353A++;

    if(!isDefined(level.infil_in_progress_buffer)) {
      break;
    }

    wait 2;
  }

  _id_56EF8D52FE1B48A1::team_unlimited_ammo();
}

monitor_num_players() {
  scripts\engine\utility::flag_init("player_count_determined");
  _id_4E272A6BB24A5E12 = getDvar("party_partyPlayerCountNum");

  if(_id_4E272A6BB24A5E12 != "1") {
    level.only_one_player = 0;
    scripts\engine\utility::flag_set("player_count_determined");
    return;
  }

  level.only_one_player = 1;
  scripts\engine\utility::flag_set("player_count_determined");

  while(!isDefined(level.players))
    wait 0.1;

  for(;;) {
    if(level.players.size > 1) {
      break;
    }

    wait 1;
  }

  level.only_one_player = 0;
  level notify("multiple_players");
}

shellshock_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "gasInterruptDelayFunc", ::gas_getblurinterruptdelayms);
}

gas_getblurinterruptdelayms(duration) {
  return 200.0;
}

_id_1C677521CA122DBF(value) {
  self setclientomnvar("ui_parachute_acquired", value);
}

delete_on_load() {
  scripts\engine\utility::array_delete(getEntArray("delete_on_load", "targetname"));
  scripts\engine\utility::delaythread(0.05, scripts\engine\utility::array_delete, getEntArray("delete_on_firstframeend", "targetname"));
}

reset_map_dvars() {
  scripts\cp\cp_checkpoint::checkpoint_set("");
  setDvar("intro_vo", "");
  setDvar("dvar_F2A4B47C16A549B3", "");
}

adjust_heartbeat_sensor_settings() {}

_id_23EB2E4122646287() {
  if(getdvarint("r_reflectionprobegenerate", 0)) {
    return;
  }
  if(getdvarint("dvar_742CAA13B3C2E685", 0)) {
    return;
  }
  if(getdvarint("dvar_7C87CBDA06B9834A") || getdvarint("dvar_3B3635B854BC49AC")) {
    return;
  }
  if(!isDefined(level._id_E6997D1DB0CB5E47))
    level._id_E6997D1DB0CB5E47 = _id_6D0DC66DA1DBE933(100, 20);

  if(!isDefined(level._id_BCA590EA5961E80E))
    level._id_BCA590EA5961E80E = _id_6D0DC66DA1DBE933(115, 20);

  scripts\engine\utility::flag_set("debug_attempts_initialized");
}

_id_3543EAAFA6B72B85() {
  if(getdvarint("r_reflectionprobegenerate", 0)) {
    return;
  }
  if(getdvarint("dvar_742CAA13B3C2E685", 0)) {
    return;
  }
  if(getdvarint("dvar_7C87CBDA06B9834A") || getdvarint("dvar_3B3635B854BC49AC")) {
    return;
  }
  if(!isDefined(level._id_84E3A11B470D0DB0))
    level._id_84E3A11B470D0DB0 = _id_6D0DC66DA1DBE933(308, 10);

  _id_E41A5E1DEE804551(level._id_84E3A11B470D0DB0, level._id_AD231D0DAAE0BAD9);
}

_id_6D0DC66DA1DBE933(x, y, scale, alpha, sort) {
  if(!isDefined(alpha))
    alpha = 1;

  if(!isDefined(scale))
    scale = 1;

  if(!isDefined(sort))
    sort = 20;

  hud = newhudelem();
  hud.location = 0;
  hud.alignx = "left";
  hud.aligny = "bottom";
  hud.vertalign = "fullscreen";
  hud.horzalign = "fullscreen";
  hud.foreground = 1;
  hud.fontscale = scale;
  hud.sort = sort;
  hud.alpha = alpha;
  hud.x = x;
  hud.y = y;
  hud.og_scale = scale;
  hud.archived = 0;
  return hud;
}

_id_E41A5E1DEE804551(hud, text) {
  if(isDefined(text) && isDefined(hud)) {
    hud.text = text;

    if(isnumber(text))
      hud setvalue(text);
    else
      hud clearalltextafterhudelem();
  }

  return hud;
}

_id_1312ACE74EFDF578() {
  if(getdvarint("r_reflectionprobegenerate", 0)) {
    return;
  }
  if(getdvarint("dvar_742CAA13B3C2E685", 0)) {
    return;
  }
  if(!isDefined(level._id_21DB8F81CCBCC579))
    level._id_21DB8F81CCBCC579 = _id_6D0DC66DA1DBE933(328, 10);

  count = 0;

  for(;;) {
    if(getdvarint("dvar_72B7197CC79C01DB") || getdvarint("dvar_3B3635B854BC49AC")) {
      wait 60;
      count++;
      continue;
    }

    _id_E41A5E1DEE804551(level._id_21DB8F81CCBCC579, count);
    wait 60;
    count++;
  }
}

_id_CC928C881B761377() {
  return level._id_2CB04CA6155DE37F;
}

_id_51623708072C759D(_id_E1CAB194B557363D) {
  _id_8D0ED9033CFAB106 = scripts\cp\challenges_cp::_id_862A7D40F77A77D6(level.script);
  missionid = _func_96B7FC7E35353254(_id_8D0ED9033CFAB106);

  if(missionid >= 211 && missionid <= 215) {
    _id_36B7946483E1DE83 = 211 - missionid;
    _id_F029F8962C196100 = 1 << _id_36B7946483E1DE83;
    return _id_E1CAB194B557363D &_id_F029F8962C196100;
  } else
    return 0;
}

_id_AFB6191A17745644() {
  self endon("disconnect");
  _id_4B86A4E17C656399 = 10277;
  self waittillmatch("challengeProgress", _id_4B86A4E17C656399);
  self._id_15076EBE90844CFF = self._id_3B3A45AF0209FF05[_id_4B86A4E17C656399]._id_0ABC57BB73D4BF1A > getsystemtime();

  if(!level._id_1154D5FCCCE1DCE3 && scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_4B86A4E17C656399 = 10443;
    _id_0293BA44C408FEF1::_id_CF013B45184BB054(self, _id_4B86A4E17C656399);
    self waittillmatch("challengeProgress", _id_4B86A4E17C656399);
    self._id_066CDA89D1B89A4B = _id_51623708072C759D(self._id_3B3A45AF0209FF05[_id_4B86A4E17C656399].progress);
  }

  if(self._id_15076EBE90844CFF && self._id_066CDA89D1B89A4B)
    level._id_1154D5FCCCE1DCE3 = 1;
}

_id_174CBB4C8632933F() {
  if(scripts\cp\utility::_id_138028CA2B958511()) {
    return;
  }
  self.skipuavupdate = 1;
  self setclientomnvar("ui_radar_blocked", 0);
}

_id_0F1B6F6CFED27EB0() {}