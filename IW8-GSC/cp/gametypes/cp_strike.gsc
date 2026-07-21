/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\gametypes\cp_strike.gsc
***********************************************/

main() {
  scripts\cp\cp_globallogic::init();
  level thread onplayerconnect();
  level.skip_playerhudphoto = 1;
  scripts\cp\cp_music_and_dialog::init();
  scripts\cp\utility::coop_mode_enable(["_encstr_932E0A09FB023CC0DA8D7FFF", "_encstr_B6AB0619EDB7E49B", "_encstr_92BF0A60CAC5390E63854B46", "_encstr_8E9B098B0DE07723433072", "_encstr_8D360838D3CB51A8EEEF", "_encstr_8FE80CC2293E5B12385FD4C16FC8"]);
  initdefaultsettings();
  scripts\cp\cp_weapon::weaponsinit();
  level.health_scalar = 1.5;
  scripts\cp\cp_outline::outline_init();
  setomnvar("_encstr_877723D5D2BE0D2DC82B7D9B85B659381B583ACA9BAFCCF6937DD3AC39DEEB34CA5836A334", 0);
  scripts\cp\cp_quest::init_quest_system();
  scripts\cp\survival\survival_loadout::init();
  level scripts\cp\cp_hud_message::init_cp_hud_message();
  dev_damage_show_damage_numbers();
  level thread scripts\cp\loot_system::init_loot();
  level thread scripts\cp\cp_interaction::coop_interaction_pregame();
  level thread scripts\cp\utility::global_physics_sound_monitor();
  level thread scripts\cp\zombies\zombieclientmatchdata::init();
  level thread monitor_num_players();
  level.use_temp_bc = 1;
  createthreatbiasgroup("_encstr_AB750823E92B1B8F727E");
  createthreatbiasgroup("_encstr_997508DBF53B3A7B7D82");
  createthreatbiasgroup("_encstr_9B7508F3E99FBB4DB07B");
  createthreatbiasgroup("_encstr_8375081C63C2CBCAE468");
  createthreatbiasgroup("_encstr_9AEF0E08A1702017BEAB61CA681D0F98");
  createthreatbiasgroup("_encstr_A5C70EC998486F2D4392AE5D5BE5A951");
  createthreatbiasgroup("_encstr_91600E081507D86A4AEFBF6D8550E953");
  createthreatbiasgroup("_encstr_8C660ECB024703902A84176BF6D7E8CB");
  setthreatbias("_encstr_AB750823E92B1B8F727E", "_encstr_9AEF0E08A1702017BEAB61CA681D0F98", 10000);
  setthreatbias("_encstr_997508DBF53B3A7B7D82", "_encstr_A5C70EC998486F2D4392AE5D5BE5A951", 10000);
  setthreatbias("_encstr_9B7508F3E99FBB4DB07B", "_encstr_91600E081507D86A4AEFBF6D8550E953", 10000);
  setthreatbias("_encstr_8375081C63C2CBCAE468", "_encstr_8C660ECB024703902A84176BF6D7E8CB", 10000);
}

initdefaultsettings() {
  scripts\engine\utility::flag_init("_encstr_92A70BF8321FF5C011AB6B69C4");
  scripts\engine\utility::flag_init("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\engine\utility::flag_init("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_init("_encstr_B1C4134B73E8C9F6AF3B596E3AAE27CA7D327B9BCA");
  scripts\engine\utility::flag_init("_encstr_BDD50EC19395FACE856B95F5BDB3ACC9");
  scripts\engine\utility::flag_init("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\engine\utility::flag_init("_encstr_84ED15B3F8A193440897544A9FC881A3D893DABB03871F");
  scripts\engine\utility::flag_init("_encstr_8BA416297AC063070845C4D98B2F7FA1BBF78297FD679EAF");
  scripts\engine\utility::flag_init("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_init("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C");
  scripts\engine\utility::flag_init("_encstr_92C5119CAC85465ED7CCED4EFA8CACEC3BABA5");
  scripts\engine\utility::flag_init("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  scripts\engine\utility::flag_init("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");
  level.wave_num = 1;
  level.no_power_cooldowns = 1;
  level.cycle_damage_scalar = 1;
  level.cycle_reward_scalar = 1;
  level.powers = [];
  level.overcook_func = [];
  level.hardcoremode = getdvarint("_encstr_A6D3149BB19C7D2C63A5AC73CDD786164E91B17B4ECA");
  level.ricochetdamage = getdvarint("_encstr_A28C149BC69C7D85364BB2B9CDBE39B436BDC63495A3");
  level.casualmode = getdvarint("_encstr_8AF9124663CBEECB158230501BE18761971DC7B1");
  level.last_loot_drop = 0;
  level.last_powers_dropped = [];
  level.cash_scalar = 1;
  level.insta_kill = 0;
  level.default_weapon = "_encstr_8B98105A770ED71C5ABE46AC1B0DF6AFB61C";
  level.pap_max = 2;
  level.inventory_nag = 0;
  level.exploimpactmod = 0.1;
  level.shotgundamagemod = 0.1;
  level.armorpiercingmod = 0.2;
  level.maxlogclients = 10;
  level.in_room_check_func = ::blank_func;
  level.custom_giveloadout = ::givedefaultloadout;
  level.move_speed_scale = scripts\cp\survival\survival_loadout::updatemovespeedscale;
  level.getnodearrayfunction = ::getnodearray;
  level.prematchfunc = ::prematchfunc;
  level.callbackplayerdamage = scripts\cp\cp_damage::callback_playerdamage;
  level.callbackplayerkilled = ::callbackplayerkilled;
  level.laststand_enter_gamemodespecificaction = ::enter_laststand;
  level.enter_spectator_func = ::enable_dogtag_revive;
  level.prespawnfromspectaorfunc = ::prespawnfromspectatorfunc;
  level.update_money_performance = scripts\cp\cp_core_gamescore::update_money_earned_performance;
  level.loot_drop_check_func = ::blank_func;
  level.active_volume_check = scripts\cp\utility::is_in_active_volume;
  level.laststand_exit_gamemodespecificaction = ::exit_laststand_func;
  level.onplayerdisconnect = ::onplayerdisconnect;
  level.endgame_write_clientmatchdata_for_player_func = ::endgame_clientmatchdata;
  level.hostmigrationend = ::hostmigrationend;
  level.onhostmigration = ::hostmigrationstart;
  level.last_stand_hud_update = ::last_stand_hud_update;
  level.game_mode_statstable = "_encstr_97E1356C83CBF47B5B4CD256E6F2B5BD32957D9B8E4EA537B3F58EB098B1AC37F2D3EDB531B4596EEBE6472C8E37A30B26C62B8B6CB9EC";
  level.game_mode_attachment_map = "_encstr_88452457E0455830375A58C153E672386D4ACBC3A7BE70852FA270C81A8B2D9086B0FD4713A3";
  var_0 = getDvar("_encstr_9A050BF1B1D21107C3D5B601E0");
  level.power_up_table = "_encstr_8C880C13578883BDBB48C21AD867" + var_0 + "_encstr_81DC0A7D8DB7F6D1E236E6CE";
  level.onstartgametype = ::onstartgametype;
  level.onspawnplayer = ::onspawnplayer;
  level.onprecachegametype = ::onprecachegametype;
  level.agent_killed_queue = [];
  level.getspawnpoint = ::getspawnpoint;
  level.forcespawnsettings = 1;
  setdvarifuninitialized("_encstr_B8CA1E87CDBF2A6428162AB709B0B5228D630BF7A9D5422C8818297A6188FD9A", 0);
  level.usehealthpacks = getdvarint("_encstr_B8CA1E87CDBF2A6428162AB709B0B5228D630BF7A9D5422C8818297A6188FD9A", 0);
}

is_friendly_dmg(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.team) && var_1.team == var_0.team)
      return 1;

    if(isDefined(var_1.owner) && isDefined(var_1.owner.team) && var_1.owner.team == var_0.team)
      return 1;
  }

  return 0;
}

blank_func() {
  return 0;
}

waitforplayers() {
  while(!isDefined(level.players))
    wait 0.1;
}

exit_laststand_func(var_0) {
  var_0 scripts\cp\cp_powers::restore_powers(var_0, var_0.pre_laststand_powers);
  var_0.flung = undefined;
  var_0 setclientomnvar("_encstr_9AC91A9DA0B0ED0F26508869412782400BA0585DFED7FBFF239685FC", 0);
  var_0 clearclienttriggeraudiozone(0.3);
  var_0 playlocalsound("_encstr_8EC410035B3FCBE018966FB588C80FB28DC1");
  var_0 stoplocalsound("_encstr_AA6A0F3B8081C4325F10DF1560051991C8");

  if(isDefined(level.vision_set_override))
    var_0 thread reset_override_visionset(0.2);

  var_1 = randomintrange(1, 5);
  var_2 = "_encstr_ACC516E2D8A50783031DCC1BE121D01FCA5097E1A952DF8A" + var_1;
  var_0 scripts\cp\utility::playlocalsound_safe(var_2);
  var_0 scripts\cp\utility::allow_player_ignore_me(0);

  if(istrue(var_0.have_permanent_perks))
    var_0 thread give_permanent_perks(var_0);
}

give_permanent_perks(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_1 = ["_encstr_A33812C9223BBF07CD018FA88C2BC9F7F098158F", "_encstr_81991360BD43A7D1DBF0C26AA80597BF7991F9FB43", "_encstr_AD721437572BDFEE6D7FE8A847B6617FD27B2030AAE2", "_encstr_B6921259DD2AE8AF1FB2F1981A3BC591053FA5FB", "_encstr_B6E3170395B6D0F759E7237BFBA649C93D4AFC0F818925B1C5", "_encstr_817A145378B59437E88F5B5893D087D11DC0BB5A0863", "_encstr_848D1118A3F8B40FC151B20AB8A83F61503B8E", "_encstr_841E1338B24EDABEB516D8862D9B59FA37D6168DB6", "_encstr_AB671357374BBF8E0DDF4808E756819F53DD4D54CC", "_encstr_878D112B23DE52BFB0F916DC90C0CD69B243B3"];

  if(isDefined(level.all_perk_list))
    var_1 = level.all_perk_list;

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player)
    var_1 = scripts\engine\utility::array_remove(var_1, "_encstr_817A145378B59437E88F5B5893D087D11DC0BB5A0863");

  wait 1;

  foreach(var_3 in var_1) {
    if(var_0 scripts\cp\utility::has_zombie_perk(var_3)) {
      continue;
    }
    waitframe();
  }
}

reset_override_visionset(var_0) {
  wait(var_0);

  if(isDefined(level.vision_set_override))
    level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", level.vision_set_override, self, 0.1);
}

onstartgametype() {
  scripts\cp\utility::set_segmented_health_regen_parameters(100, 100, 25, 2, 1, 0.05);
  scripts\cp\cp_persistence::register_eog_to_lb_playerdata_mapping();
  level thread scripts\cp\cp_interaction::init();
  scripts\cp\cp_analytics::initlevelvars();
  scripts\cp\cp_laststand::set_revive_time(3000, 5000);
  level thread init_enemy_spawner();
  thread scripts\cp\cp_traversalassist::traversal_assist_init();

  if(level._id_12376)
    level scripts\cp\whizby::calloutmarkerping_init();

  level.excludedattachments = [];

  if(!isDefined(level.normal_mode_activation_funcs))
    level.normal_mode_activation_funcs = [];

  if(!isDefined(level.special_mode_activation_funcs))
    level.special_mode_activation_funcs = [];

  if(!isDefined(level.pentskipfov))
    level.pentskipfov = [];

  if(!isDefined(level.pentparams))
    level.pentparams = [];

  scripts\cp\cp_persistence::rank_init();
  level thread handlenondeterministicentities();
  level.num_healthpacks = 0;
  level thread checkpoint_revive();
  scripts\cp\cp_modular_spawning::init_modular_spawning();
}

init_enemy_spawner() {
  scripts\cp\cp_spawner_scoring::spawner_scoring_init();
}

onprecachegametype() {
  level._effect["_encstr_8F3D0E0F27C16BDA189860B95F14AB99"] = loadfx("_encstr_BA1A30864B111DF0775FFE2ACF02AADAD35F9DCBA2ABD643B0DBD17A17AD59BB1083130D680B930EB33803229373254330E2");
}

handlenondeterministicentities() {
  wait 5;
  level notify("_encstr_A609205B63DFAFED815DE7FE5188B32FFE78721228AEFB6448D7E5F65980FBA7AD53");

  if(isDefined(level.post_nondeterministic_func))
    level thread[[level.post_nondeterministic_func]]();
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(!isai(var_0)) {
      var_0 scripts\cp\cp_analytics::on_player_connect();

      if(isDefined(var_0.connecttime))
        var_0.connect_time = var_0.connecttime;
      else
        var_0.connect_time = gettime();

      var_0.xpscale = getdvarint("_encstr_88EE0BA96A519AA7252605A539");
      var_0.weaponxpscale = getdvarint("_encstr_A5390B3B9D5A38AA8124320DDF");

      if(var_0 scripts\cp\utility::rankingenabled()) {
        var_1 = getdvarint("_encstr_8C010B98A2A62841A4A84DA6A7");
        var_2 = getdvarint("_encstr_93290BA56BA2B1861F90F4BC09");
        var_3 = var_0 getprivatepartysize() > 1;

        if(isDefined(var_1)) {
          if(var_3 && var_1 > 1)
            var_0.weaponxpscale = var_1;
        }

        if(isDefined(var_2)) {
          if(var_3 && var_2 > 1)
            var_0.xpscale = var_2;
        }
      }

      var_0 thread scripts\cp\cp_globallogic::player_init_health_regen();
      var_0 scripts\cp\cp_persistence::session_stats_init();
      var_0.num_of_plays = [];
      var_0.nextcasheffecttime = 0;
      var_0.total_currency_earned = 0;
      var_0.can_give_revive_xp = 1;
      var_0.pap = [];
      var_0.powerupicons = [];
      var_0.powers = [];
      var_0.powers_active = [];
      var_0.disabled_interactions = [];
      var_0.onkillweaponpassives = [];
      var_0.onuseweaponpassives = [];
      var_0.ondamageweaponpassives = [];
      var_0.disabledteleportation = 0;
      var_0.disabledinteractions = 0;
      var_0.power_cooldowns = 0;
      var_0.tickets_earned = 0;
      var_0.time_to_give_next_tickets = gettime();
      var_0.self_revives_purchased = 0;
      var_0.max_self_revive_machine_use = 3;
      var_0.cash_scalar = 1;
      var_0.recentkillcount = 0;
      var_0.enabledignoreme = 0;
      var_0.infiniteammocounter = 0;
      var_0.awarenessadjustment = 0;
      var_0 scripts\cp\utility::allow_player_teleport(0);

      if(scripts\engine\utility::flag("_encstr_A65211EB562BA098E71253B95ABB589043B525")) {
        if(isDefined(level.custom_player_hotjoin_func))
          var_0 thread[[level.custom_player_hotjoin_func]]();
      }

      var_0 scripts\cp\cp_mapselect::set_uav_radarstrength(var_0);
      var_0 scripts\cp\cp_persistence::lb_player_update_stat("_encstr_838808DBB7E55A5EBB70", level.wave_num, 1);
      var_0 scripts\cp\cp_wall_buys::setup_player_weapon_models(var_0);
      var_0 scripts\cp\cp_persistence::player_persistence_init();
      var_0 thread scripts\cp\cp_analytics::init_weapon_and_player_analytics(var_0);
      var_0 thread strike_player_connect_black_screen();

      if(isDefined(level.custom_onplayerconnect_func))
        [[level.custom_onplayerconnect_func]](var_0);

      if(!isDefined(level.kick_player_queue))
        level thread kick_player_queue_loop();

      var_0 thread kick_for_inactivity(var_0);
    }
  }
}

watchforluinotifyweaponreset(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_B4C8196F1792BFF0FE8A1089F0DD50FDCA3B3BC5BFCA8BC8682719");
  var_1 = "_encstr_AAF31AE7381ED052EF3388410846014DEB5EC0F803971A47229F4253";

  if(scripts\cp\utility::map_check(3))
    var_1 = "_encstr_ABCC1FD807CB3607EB3A7BEE377DDDB01B8DBEC4D597EBADED2395D8B9716C9BD9";
  else if(scripts\cp\utility::map_check(2))
    var_1 = "_encstr_AAC0203EF0F0CE1BD7895B4A997D87E34FCCF52942F06087C8A88DADC59F88A1A7AE";

  for(;;) {
    var_0 waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_2, var_3);

    if(isDefined(var_2)) {
      if(var_2 == "_encstr_91CC1993C7F75A0B89BC15F8517F6AD17A30E10BAFC399245AF3DE") {
        var_4 = tablelookupbyrow(var_1, var_3, 1);

        if(isDefined(var_4)) {
          var_5 = tablelookup(var_1, 0, var_3, 2);

          if(isDefined(var_5) && var_5 != "_encstr_B40101")
            var_0 setplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_BD42193DF6AD892DCA05D80BE559C9AB565838EDB9A6BD9195B1B9", var_5, "_encstr_8A3E0A0D67C353E09EEBD48D", -1);
        }

        continue;
      }

      if(var_2 == "_encstr_B4C8196F1792BFF0FE8A1089F0DD50FDCA3B3BC5BFCA8BC8682719")
        var_0 notify("_encstr_B4C8196F1792BFF0FE8A1089F0DD50FDCA3B3BC5BFCA8BC8682719");
    }
  }
}

streamweaponsonzonechange(var_0) {}

player_hotjoin() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A7070BCB760B80B877421038BA");
  self notify("_encstr_A3E20B27B4653818174A2BD362");
  self waittill("_encstr_BA350853C128FB939DB9");
  thread hotjoin_protection();
  self.pers["_encstr_B4290A2138037CFFB4080B8D"] = 1;

  if(isDefined(level.wave_num))
    self.wave_num_when_joined = level.wave_num;

  var_0 = getDvar("_encstr_9A050BF1B1D21107C3D5B601E0");

  if(isDefined(self.introscreen_overlay)) {
    self.introscreen_overlay.alpha = 1;
    wait 3;
    self.introscreen_overlay fadeovertime(3);
    self.introscreen_overlay.alpha = 0;
    wait 3;

    if(isDefined(self.introscreen_overlay))
      self.introscreen_overlay destroy();
  }

  while(!istrue(self.photosetup))
    wait 1;

  self setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
  self.reboarding_points = 0;
  wait 3;
  level thread reenable_zombie_emmisive();
}

reenable_zombie_emmisive() {
  var_0 = scripts\mp\mp_agent::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_2 in var_0) {
    if(istrue(var_2.is_suicide_bomber))
      continue;
    else if(istrue(var_2.is_turned)) {
      continue;
    }
    var_2 emissiveblend(1, 0.1);
    wait 0.05;
  }
}

hotjoin_protection() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.ignoreme = 1;
  self.ability_invulnerable = 1;
  wait 8;
  self.ignoreme = 0;
  self.ability_invulnerable = undefined;
}

onspawnplayer() {
  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.alien_loadout;
  self.fireshield = 0;
  self.isreviving = 0;
  self.isrepairing = 0;
  self.iscarrying = 0;
  self.isboosted = undefined;
  self.ishealthboosted = undefined;
  self.burning = undefined;
  self.shocked = undefined;
  self.player_action_disabled = undefined;
  self.no_team_outlines = 0;
  self.no_outline = 0;
  self.disabledteleportation = 0;
  self.disabledinteractions = 0;
  self.can_teleport = 1;

  if(!isDefined(self.enabledignoreme))
    self.enabledignoreme = 0;

  if(!isDefined(self.ignoreme))
    self.ignoreme = 0;

  self.hide_tutorial = 1;
  self.flung = undefined;
  self.is_holding_deployable = 0;
  self.has_special_weapon = 0;
  self.lastkilltime = gettime();
  self.lastmultikilltime = gettime();
  initplayeromnvars();
  thread scripts\cp\perks\cp_perks::watchcombatspeedscaler();

  if(isDefined(level.custom_onspawnplayer_func))
    self[[level.custom_onspawnplayer_func]]();

  scripts\cp\cp_globallogic::player_init_invulnerability();
  scripts\cp\cp_globallogic::player_init_damageshield();
  var_0 = get_starting_currency(self);
  thread scripts\cp\cp_persistence::wait_to_set_player_currency(var_0);
  set_player_max_currency(999999);
  thread watchglproxy();
  thread scripts\cp\cp_damage::core_health_regen();
  thread scripts\cp\cp_hud_util::zom_player_health_overlay_watcher();
  thread add_player_to_threatbias_group();
  thread scripts\cp\cp_weapon::watchweaponusage();
  thread scripts\cp\cp_weapon::watchweaponchange();
  thread scripts\cp\cp_weapon::watchweaponfired();
  thread scripts\cp\coop_personal_ents::assignpersonalmodelents(self);
  thread scripts\cp\coop_personal_ents::movepentstostructs(self);
  thread give_skillpoints_at_start();

  if(allow_nvg())
    thread scripts\cp\equipment\nvg::runnvg();

  if(isDefined(self.anchor))
    self.anchor delete();

  scripts\cp\utility::force_usability_enabled();
}

initplayeromnvars() {
  self setclientomnvar("_encstr_AC190F7BF95918351B5BD903E2277BE82F", 1);
  self setclientomnvar("_encstr_9AC91A9DA0B0ED0F26508869412782400BA0585DFED7FBFF239685FC", 0);
  self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 0);
}

add_player_to_threatbias_group() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(self == level.players[var_0]) {
      var_1 = var_0 + 1;

      if(var_1 == 5) {
        return;
      }
      self setthreatbiasgroup("_encstr_8BB007E03658CBCAE4" + var_1);
    }
  }
}

get_starting_currency(var_0) {
  var_1 = var_0.starting_currency_after_revived_from_spectator;

  if(isDefined(var_1)) {
    var_0.starting_currency_after_revived_from_spectator = undefined;
    return var_1;
  } else
    return scripts\cp\cp_persistence::get_starting_currency();
}

set_player_max_currency(var_0) {
  var_0 = int(var_0);
  self.maxcurrency = var_0;
}

prespawnfromspectatorfunc(var_0) {
  var_0.starting_currency_after_revived_from_spectator = var_0 scripts\cp\cp_persistence::get_player_currency();
  revivefromspectatorweaponsetup(var_0);
  set_spawn_loc(var_0);
}

revivefromspectatorweaponsetup(var_0) {
  var_1 = spawnStruct();
  var_1.copy_fullweaponlist = var_0.copy_fullweaponlist;
  var_1.copy_weapon_current = var_0.copy_weapon_current;
  var_1.copy_weapon_ammo_clip = var_0.copy_weapon_ammo_clip;
  var_1.copy_weapon_ammo_stock = var_0.copy_weapon_ammo_stock;

  if(isDefined(var_0.saved_last_stand_pistol)) {
    var_1.last_stand_pistol = var_0.saved_last_stand_pistol;
    var_0.saved_last_stand_pistol = undefined;
  } else
    var_1.last_stand_pistol = var_0.last_stand_pistol;

  var_1.weapon_levels = var_0.copy_weapon_level;

  if(isDefined(var_0.current_crafting_struct)) {
    var_1.copy_crafting_struct = var_0.current_crafting_struct;
    var_0 scripts\cp\utility::remove_crafting_item();
  } else if(isDefined(var_0.puzzle_piece))
    var_0 scripts\cp\utility::remove_crafting_item();

  if(isDefined(var_0.current_crafted_inventory)) {
    var_1.current_crafted_inventory = var_0.current_crafted_inventory;
    var_0.current_crafted_inventory = undefined;
  }

  var_1.copy_all_powers = var_0.pre_laststand_powers;
  var_1.copy_special_ammo_type = var_0.special_ammo_type;
  var_0.weaponlist = var_1;
}

restore_player_weapons_after_bleedout(var_0) {
  var_0 notify("_encstr_A10511BB565807ED37BE38BA4EB1A1B0DC2B8C");
  var_1 = var_0.weaponlist;
  var_0 takeallweapons();
  var_0.copy_fullweaponlist = var_1.copy_fullweaponlist;
  var_0.copy_weapon_current = var_1.copy_weapon_current;
  var_0.copy_weapon_ammo_clip = var_1.copy_weapon_ammo_clip;
  var_0.copy_weapon_ammo_stock = var_1.copy_weapon_ammo_stock;
  var_0.copy_all_powers = var_1.copy_all_powers;
  var_0.copy_weapon_level = var_1.weapon_levels;
  var_0 scripts\cp\utility::restore_primary_weapons_only();
  var_0 scripts\cp\utility::restore_super_weapon();
  var_0 scripts\cp\cp_powers::restore_powers(var_0, var_0.copy_all_powers);

  if(isDefined(var_1.copy_crafting_struct)) {
    var_0.current_crafting_struct = var_1.copy_crafting_struct;
    var_0[[level.crafting_icon_create_func]](var_0.current_crafting_struct);
  }

  if(isDefined(var_1.current_crafted_inventory))
    level thread[[var_1.current_crafted_inventory.restore_func]](undefined, var_0);

  var_0.special_ammo_type = var_1.copy_special_ammo_type;
  var_0.have_things_in_lost_and_found = 0;
  var_0.last_stand_pistol = var_1.last_stand_pistol;
  var_0.weaponlist = undefined;
}

set_spawn_loc(var_0) {
  var_1 = getplayerrespawnloc(var_0);
  var_0.forcespawnorigin = var_1.origin;
  var_0.forcespawnangles = var_1.angles;

  if(isDefined(var_0.respawn_forcespawnorigin))
    var_0.forcespawnorigin = var_0.respawn_forcespawnorigin;

  if(isDefined(var_0.respawn_forcespawnangles))
    var_0.forcespawnangles = var_0.respawn_forcespawnangles;
}

getplayerrespawnloc(var_0) {
  if(isDefined(level.force_respawn_location))
    return [[level.force_respawn_location]](var_0);

  if(!isDefined(level.active_player_respawn_locs) || level.active_player_respawn_locs.size == 0 || level.players.size == 0)
    return [[level.getspawnpoint]]();

  if(isDefined(level.respawn_loc_override_func))
    return [[level.respawn_loc_override_func]](var_0);

  var_1 = get_available_players(var_0);
  var_2 = get_available_respawn_locs(var_1);

  if(var_2.size == 0)
    return get_respawn_loc_near_team_center(var_0, var_1);

  if(var_2.size == 1)
    return var_2[0];

  return var_0 get_respawn_loc_rated(var_1, var_2);
}

get_available_players(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3 == var_0) {
      continue;
    }
    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

get_available_respawn_locs(var_0) {
  var_1 = [];

  foreach(var_3 in level.active_player_respawn_locs) {
    if(!canspawn(var_3.origin)) {
      continue;
    }
    if(positionwouldtelefrag(var_3.origin)) {
      continue;
    }
    if(is_respawn_loc_near_available_players(var_3, var_0)) {
      continue;
    }
    if(is_respawn_loc_near_alive_enemies(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

is_respawn_loc_near_available_players(var_0, var_1) {
  var_2 = 250000;

  foreach(var_4 in var_1) {
    if(distancesquared(var_4.origin, var_0.origin) < var_2)
      return 1;
  }

  return 0;
}

is_respawn_loc_near_alive_enemies(var_0) {
  var_1 = 250000;
  var_2 = scripts\mp\mp_agent::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_4 in var_2) {
    if(distancesquared(var_4.origin, var_0.origin) < var_1)
      return 1;
  }

  return 0;
}

get_respawn_loc_near_team_center(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  foreach(var_7 in var_1) {
    var_2 = var_2 + var_7.origin[0];
    var_3 = var_3 + var_7.origin[1];
    var_4 = var_4 + var_7.origin[2];
    var_5++;
  }

  var_9 = (var_2 / var_5, var_3 / var_5, var_4 / var_5);
  var_10 = sortbydistance(level.active_player_respawn_locs, var_9);
  return var_10[0];
}

get_respawn_loc_rated(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_0.size == 0, 1, var_0.size);
  var_3 = level.spawned_enemies.size / var_2;
  var_4 = var_3 * 2;
  var_5 = -99999999;
  var_6 = undefined;

  foreach(var_8 in var_1) {
    var_9 = 0;

    foreach(var_11 in var_0) {
      if(var_11 == self) {
        continue;
      }
      if(!isalive(var_11)) {
        continue;
      }
      if(istrue(var_11.inlaststand)) {
        var_9 = var_9 - distancesquared(var_11.origin, var_8.origin) * (var_4 * 2);
        continue;
      }

      var_9 = var_9 - distancesquared(var_11.origin, var_8.origin) * var_4;
    }

    foreach(var_14 in level.spawned_enemies)
    var_9 = var_9 + distancesquared(var_14.origin, var_8.origin);

    var_9 = var_9 / 1000000;

    if(var_9 > var_5) {
      var_5 = var_9;
      var_6 = var_8;
    }
  }

  return var_6;
}

take_away_special_ammo(var_0) {
  var_0.special_ammo_type = undefined;
}

prematchfunc() {
  var_0 = 0;
  level thread show_introscreen_text();

  if(var_0 > 0) {
    var_1 = level wait_for_first_player_connect();
    wait(var_0 - 3);

    if(isDefined(level.postintroscreenfunc))
      [[level.postintroscreenfunc]]();

    scripts\engine\utility::flag_set("_encstr_A65211EB562BA098E71253B95ABB589043B525");
    level notify("_encstr_A65211EB562BA098E71253B95ABB589043B525");
    level.introscreen_done = 1;
  } else {
    wait 2;

    if(scripts\engine\utility::flag("_encstr_A2D20FE4880D52A426C867576878654BD3"))
      wait 2;

    level.introscreen_done = 1;
    scripts\engine\utility::flag_set("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  }

  if(istrue(level.intermission))
    return;
}

show_introscreen_text() {
  level waittill("_encstr_B2600CF8759933D3EE634E77CB7A");
  wait 3;

  if(isDefined(level.introscreen_text_func))
    [[level.introscreen_text_func]]();
}

wait_for_first_player_connect() {
  var_0 = undefined;

  if(level.players.size == 0)
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
  else
    var_0 = level.players[0];

  return var_0;
}

strike_player_connect_black_screen() {
  if(isDefined(level.strike_player_connect_black_screen_fn))
    [[level.strike_player_connect_black_screen_fn]](self);
  else
    default_strike_player_connect_black_screen(self);
}

default_strike_player_connect_black_screen(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_A3E20B27B4653818174A2BD362");
  var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
  var_0 disableweapons();
  var_0 scripts\cp\utility::freezecontrolswrapper(1);
  var_0.introscreen_overlay = newclienthudelem(self);
  var_0.introscreen_overlay.x = 0;
  var_0.introscreen_overlay.y = 0;
  var_0.introscreen_overlay setshader("_encstr_83AB065EE1391A7B", 640, 480);
  var_0.introscreen_overlay.alignx = "_encstr_A5AD056A019C63";
  var_0.introscreen_overlay.aligny = "_encstr_AC190479FF92";
  var_0.introscreen_overlay.sort = 1;
  var_0.introscreen_overlay.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.introscreen_overlay.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.introscreen_overlay.alpha = 1;
  var_0.introscreen_overlay.foreground = 1;

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(!scripts\engine\utility::flag("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  var_0.introscreen_overlay fadeovertime(1);
  var_0.introscreen_overlay.alpha = 0;
  wait 1;

  if(scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");

  var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
  var_0.introscreen_overlay destroy();
  scripts\engine\utility::flag_set("_encstr_B1C4134B73E8C9F6AF3B596E3AAE27CA7D327B9BCA");
  var_0 scripts\cp\zombies\cp_consumables::init_player_consumables();
  var_0 scripts\cp\utility::freezecontrolswrapper(0);
  var_0 enableweapons();
}

melee_strength_timer() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_BEED1EEB49E0460F08ADE27A697DA7BB70CF6241F9685EEFCE1B3AA3F1CD8737");
  self.meleestrength = 1.0;
  var_0 = 1;
  self.meleestrength = 0;
  var_1 = gettime();

  for(;;) {
    var_2 = gettime();

    if(var_2 - var_1 >= level.playermeleestunregentime)
      self.meleestrength = 1.0;
    else
      self.meleestrength = 0;

    if(self meleeButtonPressed() && !self isreloading() && !self useButtonPressed()) {
      var_1 = gettime();

      if(var_0 == 1)
        var_0 = 0;
    } else if(!self meleeButtonPressed())
      var_0 = 1;
    else
      var_0 = 0;

    wait 0.05;
  }
}

hasgl3weapon() {
  var_0 = 0;
  var_1 = self getweaponslist("_encstr_BA7F0830B3A7859B60B0");

  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(isgl3weapon(var_3)) {
        var_0 = 1;
        break;
      }
    }
  }

  return var_0;
}

isgl3weapon(var_0) {
  var_1 = getweaponbasename(var_0);

  if(!isDefined(var_1))
    return 0;

  return var_1 == "_encstr_992D0EA3AF07D840EC9AC37880F76009";
}

watchglproxy() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_92F60B281EFAD7E88FC25302E7");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = undefined;
  self notifyonplayercommand("_encstr_957F0699A5E4ACC8", "_encstr_A9E60828803C73F11780");

  for(;;) {
    scripts\engine\utility::_id_143A6("_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", "_encstr_9B250DC319077B65B00FB8B93DD0AF");
    self notify("_encstr_8D54167BBB2033913579EC1BE08FC02A281B0F0818DFF8DB");
    wait 0.1;
    var_1 = self getweaponslistall();

    foreach(var_3 in var_1) {
      if(isgl3weapon(var_3)) {
        var_0 = 1;
        continue;
      }

      var_0 = 0;
    }
  }
}

laststandcurrencypenaltyamount(var_0) {}

callbackplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  [[level.callbackplayerlaststand]](var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9);
}

dev_damage_show_damage_numbers() {
  if(getdvarint("_encstr_9A0C129859B919896529678BD660B5887E688A4E", 0) == 1)
    setomnvar("_encstr_A9670E9EB6F58CB2D9EB8C2C5B0B9D56", 1);
  else
    setomnvar("_encstr_A9670E9EB6F58CB2D9EB8C2C5B0B9D56", 0);
}

precachelb() {
  var_0 = "_encstr_997205D1FD7DFE" + getDvar("_encstr_9A050BF1B1D21107C3D5B601E0");

  if(scripts\cp\utility::isplayingsolo())
    var_0 = var_0 + "_encstr_AD6706D735A7629E";
  else
    var_0 = var_0 + "_encstr_A9DF0651B93F4DDB";

  precacheleaderboards(var_0);
}

enter_laststand(var_0, var_1) {
  var_0 scripts\cp\cp_persistence::eog_player_update_stat("_encstr_A9AB06297DDFD816", 1);
  var_0.pre_arcade_game_weapon = undefined;
  var_0.pre_arcade_game_weapon_clip = undefined;
  var_0.pre_arcade_game_weapon_stock = undefined;
  var_0.former_mule_weapon = undefined;
  var_0.pre_laststand_powers = var_0 scripts\cp\cp_powers::get_info_for_player_powers(var_0);
  var_0 scripts\cp\cp_powers::clearpowers();
  var_2 = var_0 getcurrentweapon();
  var_3 = getweaponbasename(var_2);
  var_4 = var_0 getcurrentweaponclipammo();

  if(!isDefined(var_0.downsperweaponlog[var_3]))
    var_0.downsperweaponlog[var_3] = 1;
  else
    var_0.downsperweaponlog[var_3]++;

  var_0 clearclienttriggeraudiozone(0);

  if(!self issplitscreenplayer())
    var_0 setclienttriggeraudiozonepartialwithfade("_encstr_A9740E114FFBF529ABC3C920EF5F102F", 0.02, "_encstr_AB1904853B28", "_encstr_BD940712ABD03FA35E", "_encstr_A9A80769FCC4081D93");

  var_0.have_self_revive = var_0 scripts\cp\utility::has_auto_revive();

  if(var_0.have_self_revive) {
    var_5 = scripts\cp\utility::isplayingsolo() || level.only_one_player;
    var_0 notify("_encstr_A5F6170E6358CBACE4EBD02C6ED76E956333FAE42BECD2B3CA", var_5);
  }

  if(isDefined(var_0.mule_weapon) && !istrue(var_0.playing_ghosts_n_skulls))
    var_0.former_mule_weapon = var_0.mule_weapon;
  else
    var_0.former_mule_weapon = undefined;

  var_0 scripts\cp\zombies\zombieclientmatchdata::logplayerdeath();
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0 setclientomnvar("_encstr_9AC91A9DA0B0ED0F26508869412782400BA0585DFED7FBFF239685FC", 1);
}

inventory_nag() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 0;
  var_1 = 1;

  if(!scripts\cp\utility::is_codxp()) {
    while(var_0 < 3) {
      level waittill("_encstr_99E110E8B31183B59183E7741FC9F9C8769F");

      if(0 == var_1 % 2 && var_1 > 1) {
        foreach(var_3 in level.players)
        var_3 setclientomnvar("_encstr_AC6C0C383A392DD9675F3DBD60F3", 1);

        var_0 = var_0 + 1;
      }

      var_1 = var_1 + 1;
      wait 0.5;

      foreach(var_3 in level.players)
      var_3 setclientomnvar("_encstr_AC6C0C383A392DD9675F3DBD60F3", 0);
    }
  }
}

updaterecentkills(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_850C125B73F20718A55261B98786505A9AABF1DF");
  self endon("_encstr_850C125B73F20718A55261B98786505A9AABF1DF");
  self.recentkillcount++;
  var_2 = getweaponbasename(var_1);

  if(var_1 == "_encstr_B1561BBDFF6AE06031C2C983ADF2D02EA37B1F0577C23D505C1FB6D892") {
    if(!isDefined(self.killswithitem[self.itemtype]))
      self.killswithitem[self.itemtype] = 1;
    else
      self.killswithitem[self.itemtype]++;
  }

  if(!isDefined(self.killsperweaponlog[var_2]))
    self.killsperweaponlog[var_2] = 1;
  else
    self.killsperweaponlog[var_2]++;

  if(!isDefined(self.recentkillsperweapon))
    self.recentkillsperweapon = [];

  if(!isDefined(self.recentkillsperweapon[var_1]))
    self.recentkillsperweapon[var_1] = 1;
  else
    self.recentkillsperweapon[var_1]++;

  var_3 = scripts\cp\utility::getequipmenttype(var_1);
  wait 1.25;
  self.recentkillcount = 0;
  self.recentkillsperweapon = undefined;
}

onplayerdisconnect(var_0, var_1) {
  var_0 setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_8BD6092BB3484AE75EE3E3", -1);
  scripts\cp\cp_persistence::eog_update_on_player_disconnect(var_0);
}

endgame_clientmatchdata(var_0, var_1) {}

hostmigrationstart() {
  var_0 = scripts\mp\mp_agent::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_2 in var_0) {
    var_3 = isDefined(var_2.agent_type) && (var_2.agent_type == "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" || var_2.agent_type == "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B" || var_2.agent_type == "_encstr_97630D0B93F8274B3E8D82ABA81D73" || var_2.agent_type == "_encstr_9BE008764102938025A5" || var_2.agent_type == "_encstr_A60E0DA22F1BF540F8660F84DAD6A1");

    if(!var_3 && !var_2 scripts\cp\utility::agentisinstakillimmune()) {
      if(istrue(var_2.scripted_mode)) {
        var_2.died_poorly = 1;
        var_2 suicide();
        continue;
      }

      if(istrue(var_2.ignoreme)) {
        var_2.died_poorly = 1;
        var_2 suicide();
        continue;
      }

      if(istrue(var_2.ignoreall)) {
        var_2.died_poorly = 1;
        var_2 suicide();
        continue;
      }

      if(!istrue(var_2.entered_playspace)) {
        var_2.died_poorly = 1;
        var_2 suicide();
        continue;
      }
    }

    var_2.scripted_mode = 1;
    var_2 scragentsetgoalpos(var_2.origin);
    var_2.ignoreme = 1;
    var_2.ignoreall = 1;
  }
}

hostmigrationend() {
  thread resetplayerhud();
  var_0 = scripts\mp\mp_agent::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_2 in var_0) {
    var_2.scripted_mode = 0;
    var_2.ignoreme = 0;
    var_2.ignoreall = 0;
  }

  if(isDefined(level.customhostmigrationend))
    level thread[[level.customhostmigrationend]]();
}

resetplayerhud() {
  foreach(var_1 in level.players) {}
}

kick_for_inactivity(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 thread check_for_move_change();
  var_0 thread check_for_movement();
  var_0.input_has_happened = 0;
  var_1 = gettime();
  var_2 = level.onlinegame && !getdvarint("_encstr_93390B136AA2628AA8A93529D4");

  if(var_2) {
    var_0 notifyonplayercommand("_encstr_83300E5B75EB036BB24FC8E067CE0169", "_encstr_97120D65B983599519EB1D86C9B7EE");
    var_0 notifyonplayercommand("_encstr_83300E5B75EB036BB24FC8E067CE0169", "_encstr_A6E308B2DCE8B0B936B2");
    var_0 notifyonplayercommand("_encstr_83300E5B75EB036BB24FC8E067CE0169", "_encstr_B44609DFE7078F394E1651");
    var_0 notifyonplayercommand("_encstr_83300E5B75EB036BB24FC8E067CE0169", "_encstr_97410B23BD6B976233901AF2F8");
    var_0 notifyonplayercommand("_encstr_83300E5B75EB036BB24FC8E067CE0169", "_encstr_B4C60AD707B2BDC0E6CE1309");
    var_0 notifyonplayercommand("_encstr_83300E5B75EB036BB24FC8E067CE0169", "_encstr_9AC10C59D6CAB12BCAF5E97BEDD6");
    var_0 notifyonplayercommand("_encstr_83300E5B75EB036BB24FC8E067CE0169", "_encstr_977F0F954CE4B20BE8867D9B07935A37D1");
    var_0 notifyonplayercommand("_encstr_83300E5B75EB036BB24FC8E067CE0169", "_encstr_A9E60828803C73F11780");
    var_0 notifyonplayercommand("_encstr_83300E5B75EB036BB24FC8E067CE0169", "_encstr_9B0D065699E485D9");
    var_0 notifyonplayercommand("_encstr_83300E5B75EB036BB24FC8E067CE0169", "_encstr_8E5F0795E6AD7BAD2B");
    var_3 = 120;
    var_4 = 0.1;

    for(;;) {
      if(isDefined(level.wave_num) && level.wave_num > 5) {
        break;
      }

      var_5 = scripts\engine\utility::_id_143C0(var_4, "_encstr_83300E5B75EB036BB24FC8E067CE0169", "_encstr_B46E10418BBE95276B2AC97E479AB848876A");

      if(gettime() - var_1 < 30000) {
        continue;
      }
      if(var_5 != "_encstr_995408F398012F656821") {
        var_3 = 120;
        var_0.input_has_happened = 1;
        continue;
      }

      if(!istrue(var_0.in_afterlife_arcade) && !istrue(var_0.inlaststand))
        var_3 = var_3 - var_4;

      if(var_3 < 0) {
        if(level.players.size > 1) {
          if(var_0.input_has_happened) {
            var_0.input_has_happened = 0;
            continue;
          }

          add_to_kick_queue(var_0);
          break;
        }
      }
    }
  }
}

check_for_movement() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = level.onlinegame && !getdvarint("_encstr_93390B136AA2628AA8A93529D4");

  if(var_0) {
    var_1 = self getnormalizedmovement();
    var_2 = gettime();

    for(;;) {
      wait 0.2;
      var_3 = self getnormalizedmovement();

      if(var_3[0] == var_1[0] && var_3[1] == var_1[1]) {
        if(gettime() - var_2 > 90000 && level.players.size > 1)
          add_to_kick_queue(self);

        continue;
      }

      return;
    }
  }
}

add_to_kick_queue(var_0) {
  if(!scripts\engine\utility::array_contains(level.kick_player_queue, var_0))
    level.kick_player_queue = scripts\engine\utility::array_add_safe(level.kick_player_queue, var_0);
}

kick_player_queue_loop() {
  level.kick_player_queue = [];

  for(;;) {
    if(level.kick_player_queue.size > 0) {
      foreach(var_1 in level.kick_player_queue) {
        if(!isDefined(var_1)) {
          continue;
        }
        if(!var_1 ishost())
          kick(var_1 getentitynumber(), "_encstr_A6CC1AB8383F0A01305921294D57CBBB789D75196328214621BF17D3");
      }

      if(level.kick_player_queue.size > 0) {
        foreach(var_1 in level.kick_player_queue) {
          if(!isDefined(var_1)) {
            continue;
          }
          kick(var_1 getentitynumber(), "_encstr_A6CC1AB8383F0A01305921294D57CBBB789D75196328214621BF17D3");
        }
      }

      level.kick_player_queue = [];
    }

    wait 0.1;
  }
}

check_for_move_change() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9136163060534DE792352697E383ABAB6B6701B8A207E8E8");

  while(!isDefined(self.model))
    wait 0.1;

  var_0 = 1;
  var_1 = var_0;
  var_2 = var_0;

  for(;;) {
    var_3 = self getnormalizedmovement();
    var_1 = get_move_direction_from_vectors(var_3);

    if(var_2 != var_1) {
      var_2 = var_1;
      self notify("_encstr_83300E5B75EB036BB24FC8E067CE0169");
    }

    wait 0.1;
  }
}

get_move_direction_from_vectors(var_0) {
  var_1 = 1;
  var_2 = 2;
  var_3 = 3;
  var_4 = 4;
  var_5 = 5;
  var_6 = 6;
  var_7 = 7;
  var_8 = 8;
  var_9 = var_1;

  if(var_0[0] > 0) {
    if(var_0[1] <= 0.7 && var_0[1] >= -0.7)
      var_9 = var_1;

    if(var_0[0] > 0.5 && var_0[1] > 0.7)
      var_9 = var_2;
    else if(var_0[0] > 0.5 && var_0[1] < -0.7)
      var_9 = var_3;
  } else if(var_0[0] < 0) {
    if(var_0[1] < 0.4 && var_0[1] > -0.4)
      var_9 = var_4;

    if(var_0[0] < -0.5 && var_0[1] > 0.5)
      var_9 = var_5;
    else if(var_0[0] < -0.5 && var_0[1] < -0.5)
      var_9 = var_6;
  } else if(var_0[1] > 0.4)
    var_9 = var_7;
  else if(var_0[1] < -0.4)
    var_9 = var_8;

  return var_9;
}

health_meter_monitor(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;

  for(;;) {
    var_0 setclientomnvar("_encstr_AC46111A7DD1C19079F720908798491B0AA39B", var_0.health / 100);
    wait 0.05;
  }
}

last_stand_hud_update() {
  self setclientomnvar("_encstr_AC46111A7DD1C19079F720908798491B0AA39B", 0);
}

armor_meter_monitor(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;

  for(;;) {
    if(isDefined(var_0.armoramount))
      var_0 setclientomnvar("_encstr_B10D10A75BEBE063B0BC2B4E7D0BC9B5DB39", var_0.armoramount);

    waitframe();
  }
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

enable_dogtag_revive(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin + (0, 0, 40));
  var_1 setModel("_encstr_9A8513EA5818F089A8A7118A53BBC00E837F5735A3");
  var_1 makeusable();
  var_1 thread rotate_tags();
  var_1 setHintString(&"_encstr_86B11AF1183D511EE741A1AD4763A4BB10A6F159E1C40515AFBD56B5");
  var_1 endon("_encstr_AD75063D571AE108");
  var_0.respawn_forcespawnorigin = var_0.origin;
  var_0.respawn_forcespawnangles = (0, 0, 0);
  var_0.dogtag = var_1;
  var_0.dogtag.owner = var_0;
  scripts\cp\cp_laststand::makereviveicon(var_1, var_0, (1, 0, 0));
  var_1 thread revivetriggerthink(var_0);
  var_1 thread endreviveonownerdeathordisconnect();
}

rotate_tags() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self rotateYaw(30, 0.5);
    wait 0.5;
  }
}

revivetriggerthink(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    var_2 = scripts\cp\utility::player_lua_progressbar(var_1, 8000, 9216, 5);

    if(!var_2) {
      continue;
    }
    break;
  }

  playFX(level._effect["_encstr_8F3D0E0F27C16BDA189860B95F14AB99"], self.origin);
  playsoundatpos(self.origin, "_encstr_8E68108350396FCF6B7875BF3AEBBB544580");
  var_0 scripts\cp\cp_laststand::instant_revive(var_0);
  var_0 notify("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
}

endreviveonownerdeathordisconnect() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self.owner scripts\engine\utility::_id_143A5("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self.owner = undefined;
  self delete();
}

checkpoint_revive() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 1;

  for(;;) {
    level waittill("_encstr_867212BB09F0064FDFED621A8BA0D37F80932605");
    var_1 = scripts\engine\utility::getStructArray("_encstr_AB771323E92B1B8F72C7AE937DB69840106F5285E1" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_4, var_3 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
        var_3.respawn_forcespawnorigin = var_1[var_4].origin;
        var_3.respawn_forcespawnangles = var_1[var_4].angles;
        var_3 scripts\cp\cp_laststand::instant_revive(var_3);

        if(isDefined(var_3.dogtag))
          var_3.dogtag delete();
      }
    }

    var_0++;
  }
}

give_skillpoints_at_start() {
  self waittill("_encstr_B4C40E582257FDB09BB4077FC103B8B0");

  if(!isDefined(self.starting_skillpoints_given)) {
    scripts\cp\classes\cp_class_progression::give_skill_points(4);
    self.starting_skillpoints_given = 1;
  }
}

givedefaultloadout(var_0, var_1) {
  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(isDefined(self.weaponlist))
    restore_player_weapons_after_bleedout(self);

  scripts\cp\survival\survival_loadout::givedefaultloadout(var_0, var_1);
}

getspawnpoint() {
  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  return getassignedspawnpoint(scripts\engine\utility::getStructArray("_encstr_977415C0B27F2B43438C503F7C9F0AFBA2B9C0C86A1249", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
}

getassignedspawnpoint(var_0) {
  var_1 = self getentitynumber();
  return var_0[var_1];
}

allow_nvg() {
  if(istrue(level.disable_nvg))
    return 0;

  return 1;
}