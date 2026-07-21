/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\gametypes\cp_specops.gsc
***********************************************/

main() {
  level.playerent = scripts\cp\cp_weapon::bomber_spawn_origin_array_init;
  level._id_127F3 = ::playerattractiontriggerexit;
  level._id_11B51 = 48;
  scripts\cp\helicopter\chopper_boss::init();
  level thread onplayerconnect();
  level.skip_playerhudphoto = 1;
  scripts\cp\cp_music_and_dialog::init();
  scripts\cp\utility::coop_mode_enable(["_encstr_9A150C1BBDF647BE6EBCB9A3CAB6"]);
  initdefaultsettings();
  scripts\cp\cp_weapon::weaponsinit();
  level.health_scalar = 1.5;
  scripts\cp\cp_outline::outline_init();
  setomnvar("_encstr_877723D5D2BE0D2DC82B7D9B85B659381B583ACA9BAFCCF6937DD3AC39DEEB34CA5836A334", 0);
  scripts\cp\survival\survival_loadout::init();
  level scripts\cp\cp_hud_message::init_cp_hud_message();
  level thread scripts\cp\loot_system::init_loot();
  level thread scripts\cp\cp_interaction::coop_interaction_pregame();
  level thread scripts\cp\utility::global_physics_sound_monitor();
  level thread scripts\cp\zombies\zombieclientmatchdata::init();
  level thread monitor_num_players();
  setDvar("_encstr_B1C81256933B1E3FE2F128587ABFE3519F345DCB", 2);
  scripts\cp\cp_gameskill::init_gameskill();
  level.use_temp_bc = 1;
  create_player_threatbias_groups();

  if(scripts\cp\pvpe\pvpe::pvpe_enabled())
    scripts\cp\pvpe\pvpe::init_pvpe();
  else if(scripts\cp\pvpve\pvpve::pvpve_enabled())
    scripts\cp\pvpve\pvpve::init_pvpve();

  thread scripts\cp\cp_battlechatter::manualinitbattlechatter();
  scripts\cp\laser_traps\cp_laser_traps::stopinteract();
  scripts\cp\laser_traps\cp_laser_traps::teamanchoredwidgetinstances();
  scripts\cp\killstreaks\nuke_cp::init_script_triggers();
  scripts\engine\utility::create_func_ref("_encstr_878C09270957938E21F994", ::_id_134EC);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924", ::lastdepositinstruct);
  scripts\cp\helicopter\chopper_boss::clearmatchhasmorethan1playervariablesonroundend();
  scripts\cp\laser_traps\cp_laser_traps::_id_1430D();
}

_id_134EC(var_0) {
  return scripts\cp\laser_traps\cp_laser_traps::_id_134F1(self.script_type, self.origin, self.angles, 1);
}

lastdepositinstruct(var_0) {
  objective_delete(var_0);
  scripts\cp\utility::nonobjective_returnobjectiveid(var_0);
}

create_player_threatbias_groups() {}

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
  scripts\engine\utility::flag_init("_encstr_AB8C1A73A8E8C7952085050B99819B3729019B39115BBB4CB0913D14");
  level.wave_num = 1;
  level.cycle_reward_scalar = 1;
  level.cash_scalar = 1;
  level.powers = [];
  level.overcook_func = [];
  level.hardcoremode = getdvarint("_encstr_A6D3149BB19C7D2C63A5AC73CDD786164E91B17B4ECA");
  level.ricochetdamage = getdvarint("_encstr_A28C149BC69C7D85364BB2B9CDBE39B436BDC63495A3");
  level.casualmode = getdvarint("_encstr_8AF9124663CBEECB158230501BE18761971DC7B1");
  level.default_weapon = "_encstr_8B98105A770ED71C5ABE46AC1B0DF6AFB61C";
  setdvarifuninitialized("_encstr_B8CA1E87CDBF2A6428162AB709B0B5228D630BF7A9D5422C8818297A6188FD9A", 0);
  level.usehealthpacks = getdvarint("_encstr_B8CA1E87CDBF2A6428162AB709B0B5228D630BF7A9D5422C8818297A6188FD9A", 0);
  level.pap_max = 2;
  level.exploimpactmod = 0.1;
  level.shotgundamagemod = 0.1;
  level.armorpiercingmod = 0.2;
  level.maxlogclients = 10;
  level.move_speed_scale = scripts\cp\survival\survival_loadout::updatemovespeedscale;
  level.getnodearrayfunction = ::getnodearray;
  level.prematchfunc = ::prematchfunc;
  level.callbackplayerdamage = scripts\cp\cp_damage::callback_playerdamage;
  level.callbackplayerkilled = ::callbackplayerkilled;
  level.onplayerdisconnect = ::onplayerdisconnect;
  level.onstartgametype = ::onstartgametype;
  level.onspawnplayer = ::onspawnplayer;
  level.onprecachegametype = ::onprecachegametype;
  level.laststand_enter_gamemodespecificaction = ::enter_laststand;
  level.prespawnfromspectaorfunc = ::prespawnfromspectatorfunc;
  level.laststand_exit_gamemodespecificaction = ::exit_laststand_func;
  level.last_stand_hud_update = ::last_stand_hud_update;
  level.getspawnpoint = ::getspawnpoint;
  level.update_money_performance = scripts\cp\cp_core_gamescore::update_money_earned_performance;
  level.active_volume_check = scripts\cp\utility::is_in_active_volume;
  level.endgame_write_clientmatchdata_for_player_func = ::endgame_clientmatchdata;
  level.hostmigrationend = ::hostmigrationend;
  level.onhostmigration = ::hostmigrationstart;
  level.custom_player_hotjoin_func = undefined;
  level.game_mode_statstable = "_encstr_97E1356C83CBF47B5B4CD256E6F2B5BD32957D9B8E4EA537B3F58EB098B1AC37F2D3EDB531B4596EEBE6472C8E37A30B26C62B8B6CB9EC";
  level.game_mode_attachment_map = "_encstr_88452457E0455830375A58C153E672386D4ACBC3A7BE70852FA270C81A8B2D9086B0FD4713A3";
  var_0 = getDvar("_encstr_9A050BF1B1D21107C3D5B601E0");
  level.power_up_table = "_encstr_8C880C13578883BDBB48C21AD867" + var_0 + "_encstr_81DC0A7D8DB7F6D1E236E6CE";
}

exit_laststand_func(var_0) {
  var_0 scripts\cp\cp_powers::restore_powers(var_0, var_0.pre_laststand_powers);
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
}

reset_override_visionset(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait(var_0);

  if(isDefined(level.vision_set_override))
    level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", level.vision_set_override, self, 0.1);
}

onstartgametype() {
  scripts\cp\utility::set_segmented_health_regen_parameters(100, 100, 25, 2, 1, 0.05);
  scripts\cp\cp_persistence::register_eog_to_lb_playerdata_mapping();
  level thread scripts\cp\cp_interaction::init();
  scripts\cp\cp_analytics::initlevelvars();
  thread update_laststand_times();
  level thread init_enemy_spawner();
  thread scripts\cp\cp_traversalassist::traversal_assist_init();
  thread scripts\cp_mp\auto_ascender::init();
  thread scripts\cp_mp\ent_manager::init();

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
  level thread checkpoint_revive();

  if(scripts\cp\pvpe\pvpe::pvpe_enabled())
    scripts\cp\pvpe\pvpe::initialize_player_team_slot_assignment();
  else if(scripts\cp\pvpve\pvpve::pvpve_enabled())
    scripts\cp\pvpve\pvpve::initialize_player_team_slot_assignment();

  thread scripts\cp\cp_outofbounds::initoob();
}

init_enemy_spawner() {
  scripts\cp\cp_spawner_scoring::spawner_scoring_init();
}

onprecachegametype() {
  level._effect["_encstr_8F3D0E0F27C16BDA189860B95F14AB99"] = loadfx("_encstr_BA1A30864B111DF0775FFE2ACF02AADAD35F9DCBA2ABD643B0DBD17A17AD59BB1083130D680B930EB33803229373254330E2");
  level._effect["_encstr_AC091A5D2B3318A8B211E018478190503AABF7D3DBA9D698EA754850"] = loadfx("_encstr_A18D38EC66C3CB5ADD077D4C3979B3B05BCA0ED8582F5E4BE666966379D9CC3CAF2693BE5A9B662DC6AFC6637B5D8CD7378DC9DED8B15CB3990F");
  level._effect["_encstr_BE771BE3B1B8275256D7C7E39DF3FA6F70BB5DEA0E48AD5A224B17925B"] = loadfx("_encstr_AA7B39CC7D8896271F58AE16FD3892875AB138AA071360AC8AF8B13ACEF808D9998AAD0F33DE77A3196EAA8B38EA0FA84AAFFC71581181B0438E83");
  level._effect["_encstr_83BE1A3E744A3FA6DDC9BAC228C31D87A065BDB0AF732FAA81B1370F"] = loadfx("_encstr_AB7D385E142A9E44F7D2F92268AF3F5F600DC0CC3F52D60C9D18823A9A2537739E664A4743182BD4B1B9BAA3A041A1973056B0CF470B425B5D98");
  level._effect["_encstr_9BBE1A1EA5A8B9FB4E96126A592B1B61903B8D80BFA87CF7778E7FB7"] = loadfx("_encstr_AA9138CE33F0CB4BEE1CBE899CCB760B5B95E01BC25EF2967366D28D979D333CD72627F5B49BCC5AD8D753AB5B0EBEEED2CD83F58123C5EC663C");
  level._effect["_encstr_8C66180BA22310A82AEF7B7DFED4E0D8D78A8010D9ABB3C8C4BC"] = loadfx("_encstr_9B5E3694372BF788D77A69984B5781A3821F0F114E93AFF0A62BD0E0D626F9E90946863024BAF5389CB7D810EB41160932AF732D6DD34D42");
  level._effect["_encstr_A78918D999E1F52627FA4B37332D1BEB3707DE3ABE364BCE1A1D"] = loadfx("_encstr_AB8136C3699B16F408C99FAA35A23F7749A11BEA11F3DE2CF86DD1BCB7B087DBF839B341F8C083646337C3A8DF8881331B318A7BA8A44B18");
  precachempanim("_encstr_845B0F80326F10804A938B9F27535730E6");
  scripts\cp\pvpe\pvpe::precache_pvpe_vfx();
}

handlenondeterministicentities() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
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

      if(istrue(var_0 getplayerdata("_encstr_850703B7D9", "_encstr_B1451318AA665FCB079166EB816733C34D7240E063", "_encstr_BA09099DA5F9CC40D8DD63")) && istrue(var_0 getplayerdata("_encstr_850703B7D9", "_encstr_B1451318AA665FCB079166EB816733C34D7240E063", "_encstr_AAB606A02553A822")) && istrue(var_0 getplayerdata("_encstr_850703B7D9", "_encstr_B1451318AA665FCB079166EB816733C34D7240E063", "_encstr_B45009027C7997B8E14BAB")) && istrue(var_0 getplayerdata("_encstr_850703B7D9", "_encstr_B1451318AA665FCB079166EB816733C34D7240E063", "_encstr_A5010A6214AA72111592A844")))
        var_0 thread scripts\cp_mp\xmike109::screenent_d("_encstr_8A8E0FA3D3A2C810702F33A993F1D8988B");

      var_0 thread scripts\cp\helicopter\chopper_boss::player_init_health_regen();
      var_0 scripts\cp\cp_persistence::session_stats_init();
      var_0 scripts\cp\utility::brjugg_playerwelcomesplashes(0);
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
      var_0.move_door_to_pos = 0;
      var_0 scripts\cp\utility::allow_player_teleport(0);
      var_0.achievement_registration_func = scripts\cp\cp_achievement::register_default_achievements;
      var_0 scripts\cp\cp_achievement::switchminimapid(var_0);
      var_0._id_136A1 = var_0.connect_time;
      var_0 scripts\cp\cp_mapselect::set_uav_radarstrength(var_0);
      var_0 scripts\cp\cp_persistence::lb_player_update_stat("_encstr_838808DBB7E55A5EBB70", level.wave_num, 1);
      var_0 scripts\cp\cp_wall_buys::setup_player_weapon_models(var_0);
      var_0 thread scripts\cp\cp_analytics::init_weapon_and_player_analytics(var_0);

      if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
        var_0 scripts\cp\pvpe\pvpe::assign_pvpe_team_and_slot_number(var_0);
        var_0 scripts\cp\pvpe\pvpe::terrorist_self_revive_time_override(var_0);
      }

      if(level._id_12376)
        var_0 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_initplayer();

      var_0.gameskill = scripts\cp\cp_gameskill::get_gameskill();
      var_0 scripts\cp\cp_gameskill::set_difficulty_from_locked_settings();
      var_0.gs.scripteddeathshielddurationscale = 1;
      thread juggernaut_pincer(var_0);

      if(scripts\engine\utility::flag("_encstr_A65211EB562BA098E71253B95ABB589043B525")) {
        if(isDefined(level.custom_player_hotjoin_func))
          var_0 thread[[level.custom_player_hotjoin_func]]();
      }

      if(isDefined(level.custom_onplayerconnect_func))
        [[level.custom_onplayerconnect_func]](var_0);

      if(!isDefined(level.kick_player_queue))
        level thread kick_player_queue_loop();

      var_0 thread pausemenu_think();
    }
  }
}

pausemenu_think() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    if(var_0 == "_encstr_B4F50BECBD4795BE2795A339CB") {
      scripts\cp\laser_traps\cp_laser_traps::_id_1430E("_encstr_85F206A6C7DB7DBA", 30);
      scripts\cp\laser_traps\cp_laser_traps::_id_1430B("_encstr_85F206A6C7DB7DBA", 1);
    }
  }
}

team_slot_assignment_available_from_player_disconnect() {
  return level.disconnect_player_team_slot_assignment.size > 0;
}

get_team_slot_assignment_from_player_disconnect() {
  var_0 = level.disconnect_player_team_slot_assignment[0];
  level.disconnect_player_team_slot_assignment = scripts\engine\utility::array_remove(level.disconnect_player_team_slot_assignment, var_0);
  return var_0;
}

player_hotjoin() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A7070BCB760B80B877421038BA");
  self notify("_encstr_A3E20B27B4653818174A2BD362");
  self notify("_encstr_81420F308D43D07842CEF9DF8BE8A04A3A");
  self endon("_encstr_81420F308D43D07842CEF9DF8BE8A04A3A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
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
}

hotjoin_protection() {
  self notify("_encstr_8590139C30612AFFB8E8DF6B2050BC8227D5A4D528");
  self endon("_encstr_8590139C30612AFFB8E8DF6B2050BC8227D5A4D528");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\cp\utility::allow_player_ignore_me(1);
  self.ability_invulnerable = 1;
  wait 8;
  scripts\cp\utility::allow_player_ignore_me(0);
  self.ability_invulnerable = undefined;
}

onspawnplayer(var_0) {
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

  if(!isDefined(self.move_door_to_pos))
    self.move_door_to_pos = 0;

  scripts\cp\utility::brjugg_playerwelcomesplashes(1);

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
  scripts\common\input_allow::clear_all_allow_info();
  scripts\cp_mp\utility\damage_utility::cleardamagemodifiers();
  thread scripts\cp\perks\cp_perks::watchcombatspeedscaler();

  if(isDefined(level.custom_onspawnplayer_func))
    self[[level.custom_onspawnplayer_func]]();

  scripts\cp\helicopter\chopper_boss::player_init_invulnerability();
  scripts\cp\helicopter\chopper_boss::player_init_damageshield();
  var_1 = get_starting_currency(self);
  thread scripts\cp\cp_persistence::wait_to_set_player_currency(var_1);
  set_player_max_currency(999999);
  thread scripts\cp\cp_damage::core_health_regen();
  thread scripts\cp\cp_hud_util::zom_player_health_overlay_watcher();
  thread scripts\cp\cp_weapon::watchweaponusage();
  thread scripts\cp\cp_weapon::watchweaponchange();
  thread scripts\cp\cp_weapon::watchweaponfired();
  thread scripts\cp\coop_personal_ents::assignpersonalmodelents(self);
  thread scripts\cp\coop_personal_ents::movepentstostructs(self);
  thread give_skillpoints_at_start();

  if(isDefined(self.anchor))
    self.anchor delete();

  scripts\cp\utility::force_usability_enabled();

  if(scripts\cp\pvpe\pvpe::pvpe_enabled() && scripts\cp\pvpe\pvpe::player_is_terrorist(self))
    scripts\cp\pvpe\pvpe::on_spawn_terrorist_player(self);

  thread _id_12476();
}

_id_12476() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_862D14866BBF6318C1E0071F2058CEFA5D688B3A45C1");
    scripts\cp\cp_globallogic::broadcast_status(self, 3);
    self waittill("_encstr_B49E157ED43A29CBA573499077F6404B53B1E5702F72D9");

    if(isalive(self) && !self.inlaststand)
      scripts\cp\cp_globallogic::broadcast_status(self, 0);
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
  foreach(var_3 in var_1) {
    if(distancesquared(var_3.origin, var_0.origin) < 250000)
      return 1;
  }

  return 0;
}

is_respawn_loc_near_alive_enemies(var_0) {
  var_1 = scripts\mp\mp_agent::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_3 in var_1) {
    if(distancesquared(var_3.origin, var_0.origin) < 250000)
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

prematchfunc() {
  var_0 = 0;

  if(var_0 > 0) {
    var_1 = level wait_for_first_player_connect();
    wait(var_0 - 3);

    if(isDefined(level.postintroscreenfunc))
      [[level.postintroscreenfunc]]();

    scripts\engine\utility::flag_set("_encstr_A65211EB562BA098E71253B95ABB589043B525");
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
  var_0 = getDvar("_encstr_9A050BF1B1D21107C3D5B601E0");
  var_1 = getDvar(var_0 + "_encstr_B4580B18900D4FFAE3A7CAC953", "_encstr_B40101");
  var_2 = "_encstr_911904535326" + var_0 + "_encstr_A6F310A6BAC37268E64CE3C545CA7A4E3F83";
  var_3 = int(tablelookup(var_2, 1, var_1, 0));

  if(isDefined(var_1) && var_1 != "_encstr_B40101") {
    self setclientomnvar("_encstr_A7FE1805DC2832CA4A98C780F74FB3BEE3CB30035701807931E0", var_3);
    self setclientomnvar("_encstr_87DC0D2B694129CB535A4F55F99218", 1);
  }
}

wait_for_first_player_connect() {
  var_0 = undefined;

  if(level.players.size == 0)
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
  else
    var_0 = level.players[0];

  return var_0;
}

juggernaut_pincer(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0.introscreen_overlay = newclienthudelem(var_0);
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
  var_1 = 4.0;
  var_0.introscreen_overlay fadeovertime(var_1);
  var_0.introscreen_overlay.alpha = 0.0;
  wait(var_1);
  var_0.introscreen_overlay destroy();

  if(level.players.size > 1) {
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(isDefined(var_4.introscreen_overlay)) {
        var_2 = 1;
        break;
      }
    }

    if(var_2 == 0) {
      var_6 = getdvarint("_encstr_A2662B38923A172127D40F7B8F57EB37E51A80B0AA96877B1FC3B7F79B7FB0FB4B42D0F832EAFDD0FFFA1D6E73", 5);
      wait(var_6);
      scripts\cp\helicopter\chopper_boss::refreshuimatchinprogressomnvarvalue();
      return;
    }
  } else
    scripts\cp\helicopter\chopper_boss::refreshuimatchinprogressomnvarvalue();
}

playerinfildisabled(var_0) {
  return istrue(var_0.infil_disabled);
}

callbackplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  [[level.callbackplayerlaststand]](var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9);
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
  var_0 scripts\cp\cp_analytics::log_event("_encstr_8FCE169139ED073895917D3ADBAFD885CD47F5E61DC2E623", 1, [var_0.clientid], [var_0.clientid], [var_0.clientid]);
  var_0.pre_arcade_game_weapon = undefined;
  var_0.pre_arcade_game_weapon_clip = undefined;
  var_0.pre_arcade_game_weapon_stock = undefined;
  var_0.former_mule_weapon = undefined;
  var_0.pre_laststand_powers = var_0 scripts\cp\cp_powers::get_info_for_player_powers(var_0);
  var_0 scripts\cp\cp_powers::clearpowers();
  var_0 clearaccessory();
  var_2 = var_0 getcurrentweapon();
  var_3 = getweaponbasename(var_2);
  var_4 = var_0 getcurrentweaponclipammo();

  if(!isDefined(var_0.downsperweaponlog[var_3]))
    var_0.downsperweaponlog[var_3] = 1;
  else
    var_0.downsperweaponlog[var_3]++;

  var_0 clearclienttriggeraudiozone(0);

  if(!self issplitscreenplayer() && !scripts\cp\cp_endgame::gamealreadyended())
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

  if(scripts\cp\pvpe\pvpe::player_is_terrorist(var_0))
    var_0 thread scripts\cp\pvpe\pvpe::terrorist_enter_laststand(var_0, var_1);
}

updaterecentkills(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_850C125B73F20718A55261B98786505A9AABF1DF");
  self endon("_encstr_850C125B73F20718A55261B98786505A9AABF1DF");
  self.recentkillcount++;
  var_2 = getweaponbasename(var_1);

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
    if(istrue(var_2.scripted_mode)) {
      var_2.died_poorly = 1;
      var_2 suicide();
      continue;
    } else if(istrue(var_2.ignoreme)) {
      var_2.died_poorly = 1;
      var_2 suicide();
      continue;
    } else if(istrue(var_2.ignoreall)) {
      var_2.died_poorly = 1;
      var_2 suicide();
      continue;
    } else if(!istrue(var_2.entered_playspace)) {
      var_2.died_poorly = 1;
      var_2 suicide();
      continue;
    } else {
      var_2.scripted_mode = 1;
      var_2 scragentsetgoalpos(var_2.origin);
      var_2.ignoreme = 1;
      var_2.ignoreall = 1;
    }
  }
}

hostmigrationend() {
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
  foreach(var_1 in level.players) {
    if(isDefined(var_1.current_vehicle_seat)) {
      var_2 = var_1.current_vehicle_seat;
      var_1 _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::enter_seat_omnvar(var_1, var_2);
    }
  }
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
  level endon("_encstr_9B1D0BC7932875276230426AA1");
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
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_B4C40E582257FDB09BB4077FC103B8B0");

  if(!isDefined(self.starting_skillpoints_given)) {
    scripts\cp\classes\cp_class_progression::give_skill_points(4);
    self.starting_skillpoints_given = 1;
  }
}

givedefaultloadout() {
  var_0 = self;
  var_0 setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 0);
  var_0 takeallweapons();
  var_0 scripts\cp\utility::_clearperks();
  var_0 scripts\cp\utility::_detachall();
  var_0.headmodel = undefined;
  var_0.changingweapon = undefined;
  var_0.class = "_encstr_8BBA05185F8B99";
  var_1 = var_0 scripts\cp\cp_loadout::get_player_character_num();
  var_0 thread scripts\cp\survival\survival_loadout::setmodelfromcustomization(var_1);
  var_2 = var_0 scripts\cp\survival\survival_loadout::lookupcurrentoperatorskin(var_0.team);
  var_3 = var_0 scripts\cp\survival\survival_loadout::getplayerfoleytype(var_2);

  if(var_3 == "_encstr_B40101")
    var_3 = "_encstr_BEE00A93594E2BE548C7786C";

  var_0 setclothtype(var_3);
  var_0 scripts\cp\cp_loadout::updatemovespeedscale();
  var_0 setsuit("_encstr_AB6C0C1784D2171608824D4727A0");
  var_0.primaryweapon = isundefinedweapon();
  var_0 scripts\cp\utility::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");
  var_0 scripts\cp\utility::giveperk("_encstr_82E61BB90795365A85C68EE5FA2B3C07C2CD23958CD7B54BCD2DB58507");
  var_4 = var_0.melee_weapon;
  var_0.default_starting_melee_weapon = var_4;
  var_0.currentmeleeweapon = var_4;
  var_0 scripts\cp\classes\cp_class_progression::give_player_class();
  var_0 scripts\cp\cp_loadout::set_player_perks();
  var_0 setactionslot(2, "_encstr_B40101");
  var_0 setactionslot(3, "_encstr_B4DC085639F9C2779108");
  scripts\cp\cp_munitions::reset_munitions(var_0);
  var_5 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_8D0B0F2DB9D9ACCD47DE39BC9AB1ED3A9B", "_encstr_96500B3AEDA3B0363563DE1DCD");

  for(var_6 = 0; var_6 < var_5; var_6++)
    var_0 scripts\cp\cp_munitions::give_munition_to_slot("_encstr_8BBA05185F8B99", var_6);

  var_0.loadoutaccessoryweapon = var_0 scripts\cp\cp_loadout::cac_getaccessoryweapon();
  var_0.loadoutaccessorydata = var_0 scripts\cp\cp_loadout::cac_getaccessorydata();
  var_0.loadoutaccessorylogic = var_0 scripts\cp\cp_loadout::force_interrupt_all_current_combat_actions();

  if(isDefined(var_0.loadoutaccessorydata) && isDefined(var_0.loadoutaccessoryweapon) && var_0.loadoutaccessoryweapon != "_encstr_8BBA05185F8B99")
    var_0 scripts\cp\cp_accessories::giveplayeraccessory(var_0.loadoutaccessorydata, var_0.loadoutaccessoryweapon, var_0.loadoutaccessorylogic);

  var_0.last_stand_pistol = scripts\cp\cp_weapon::buildweapon("_encstr_B8B7134BEE70EB0ED2FA5BB4D69526721398D7AD07", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);

  if(level._id_12376)
    scripts\cp\whizby::_id_13263(self);
}

playerattractiontriggerexit() {
  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.execution))
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);
}

getspawnpoint() {
  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  var_0 = scripts\engine\utility::getStructArray("_encstr_977415C0B27F2B43438C503F7C9F0AFBA2B9C0C86A1249", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(level.default_player_spawns)) {
    var_1 = scripts\engine\utility::getStructArray(level.default_player_spawns, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_1.size > 0)
      var_0 = var_1;
  }

  if(scripts\cp\pvpe\pvpe::pvpe_enabled())
    return scripts\cp\pvpe\pvpe::getassignedspawnpointbasedonteam(self);
  else if(scripts\cp\pvpve\pvpve::pvpve_enabled())
    return scripts\cp\pvpve\pvpve::getassignedspawnpointbasedonteam(self);
  else
    return getassignedspawnpoint(var_0);
}

getassignedspawnpoint(var_0) {
  var_1 = self getentitynumber();
  return var_0[var_1];
}

update_laststand_times() {
  scripts\cp\cp_laststand::init_laststand_anims();
  var_0 = level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_B60A0B3A6AB96AFB10B069213E"];
  var_1 = level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_83750D5A23D82BBEE6E8C2CD8CFA98"];
  var_2 = level.scr_anim["_encstr_8601114B60167252E5BB8B4788E16A245B48BB"]["_encstr_9A6C0CFF3503F75A6970922A993B"];
  var_3 = getanimlength(var_0);
  var_4 = getanimlength(var_1);
  var_5 = getanimlength(var_2);
  var_6 = 0.5;
  var_7 = (var_3 + var_4 + var_5 + var_6) * 1000;
  var_8 = 5000;
  var_9 = (var_3 + var_5 + var_6) * 1000;
  scripts\cp\cp_laststand::set_revive_time(var_7, var_8, var_9);
}