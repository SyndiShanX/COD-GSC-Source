/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_598e0c00c8151f7.gsc
***********************************************/

main() {
  level._id_59C3F456A9E5D4F0 = _id_71332A5B74214116::init;

  if(getdvarint("dvar_742CAA13B3C2E685", 0)) {
    return;
  }
  _id_116171939929AF39::init();
  _id_DA61A45A047A1745();
  _id_3B64EB40368C1450::_id_7372010B17478CDC("base_jumping", 0, 0, "$self", ::_id_F4116328CE66A82D, "$value");
  thread _id_E68FDD067463CAB4();
  _id_14609B809484646E::_id_8ECE37593311858A(::_id_15D7372202E8E1A9);
  _id_14609B809484646E::_id_8ECE37593311858A(::_id_476934EBCF86281D);
  _id_14609B809484646E::_id_8ECE37593311858A(::_id_6A98C6DA3DFA5426);
  _id_14609B809484646E::_id_8ECE37593311858A(::_id_ABE70D559DB2E125);
  _id_14609B809484646E::_id_8ECE37593311858A(scripts\common\ai::_id_D7EDB8535850DB35);
  _id_14609B809484646E::_id_8ECE37593311858A(scripts\cp\cp_awards::onplayerconnect);

  if(getdvarint("dvar_5086F953F0CF9D8B", 0) != 0) {}

  _id_E73F88105B0ED543();
  level thread scripts\cp\cp_matchdata::init();
  _id_116171939929AF39::_id_D98E304DD9D5D8CD();
}

_id_F4116328CE66A82D(_id_785A82E3F6EED24F) {
  self skydive_setbasejumpingstatus(_id_785A82E3F6EED24F);
  self skydive_setdeploymentstatus(_id_785A82E3F6EED24F);

  if(_id_785A82E3F6EED24F)
    self.ffsm_state = undefined;
  else
    self.ffsm_state = 5;
}

_id_DA61A45A047A1745() {
  level.skip_playerhudphoto = 1;
  level.use_temp_bc = 1;
  scripts\cp\utility::coop_mode_enable("agent_drops");
}

_id_E73F88105B0ED543() {
  setdvarifuninitialized("enable_segmented_health_regen", 0);
  _id_0448EF4D9E70CE5E::_id_3E689374A8C8C3A2(33);
  level.wave_num = 1;
  level.cycle_reward_scalar = 1;
  level.cash_scalar = 1;
  level.powers = [];
  level.overcook_func = [];
  level._id_12226443217B5474 = getdvarint("dvar_7026CEFFE6E03F2D");
  level.ricochetdamage = getdvarint("scr_aliens_ricochet");
  level.casualmode = getdvarint("scr_aliens_casual");
  level.default_weapon = "iw9_pi_papa220_mp";
  level.usehealthpacks = getdvarint("enable_segmented_health_regen", 0);
  level.pap_max = 2;
  level.health_scalar = 1.5;
  level.armoronweaponswitchlongpress = 1;
  level.allow_super = ::_id_E4A796F1B77914AC;
  level.dogtag_revive = 1;
  level._id_F4C8727CAC33C176 = 1;

  if(scripts\cp\utility::is_raid_gamemode())
    level._id_F4A07073EC587E25 = 0;

  _id_52343D5C1B190CF0();
  scripts\cp\cp_gameskill::_id_31B2BF3FE796B1B2();

  if(getdvarint("dvar_00302B919208FAFA", 0) <= 0)
    _id_116171939929AF39::registerfalldamagedvars();

  level.exploimpactmod = 0.1;
  level.shotgundamagemod = 0.1;
  level.armorpiercingmod = 1.5;
  level.armorpiercingmodks = 1.25;
  level.maxlogclients = 10;
  _id_6DEE2410821C6C07::_id_60D43F6A3C2B5F1B(_id_12E2FB553EC1605E::updatemovespeedscale);
  level.move_speed_scale = _id_12E2FB553EC1605E::updatemovespeedscale;
  level.getnodearrayfunction = ::getnodearray;
  level.prematchfunc = ::prematchfunc;

  if(getdvarint("dvar_5086F953F0CF9D8B", 0) != 0) {} else
    level.callbackplayerdamage = _id_25845ACA699D038D::callback_playerdamage;

  level.callbackplayerkilled = ::callbackplayerkilled;
  level.onplayerdisconnect = ::onplayerdisconnect;
  level.onstartgametype = ::onstartgametype;
  level.onspawnplayer = ::onspawnplayer;
  level.onprecachegametype = ::onprecachegametype;
  level.get_bleed_out_time = ::_id_840A5E4F7961DF6B;
  level.laststand_enter_gamemodespecificaction = ::enter_laststand;
  level.enter_spectator_func = _id_0AFB7E332AEE4BF2::enable_dogtag_revive;
  level.prespawnfromspectatorfunc = ::prespawnfromspectatorfunc;
  level.laststand_exit_gamemodespecificaction = ::exit_laststand_func;
  level.last_stand_hud_update = ::last_stand_hud_update;
  level.getspawnpoint = ::getspawnpoint;
  level.update_money_performance = scripts\cp\cp_core_gamescore::update_money_earned_performance;
  level.endgame_write_clientmatchdata_for_player_func = ::endgame_clientmatchdata;
  level.hostmigrationend = ::hostmigrationend;
  level.onhostmigration = ::hostmigrationstart;

  if(scripts\cp\utility::_id_138028CA2B958511())
    _id_338A174587F6C1F1();
  else
    level.endgame = ::_id_B4A7666318FB5D7E;

  scripts\cp\utility::coop_mode_enable(["events"]);
  scripts\cp\utility::coop_mode_enable(["loot_drops"]);
}

_id_B4A7666318FB5D7E(winner, _id_1379934A423852EF) {
  _id_467F0FDFDD155A45::endgame(winner, _id_1379934A423852EF);
}

_id_79430C7F1CF86099(winner, _id_1379934A423852EF) {
  [[level._id_2F1EE97802511A62]](winner, _id_1379934A423852EF);
}

_id_338A174587F6C1F1() {
  level.endgame = ::_id_79430C7F1CF86099;
  _id_18AF78602B67B70C::_id_490993B77C6D2C41();

  if(getdvarint("dvar_91394B3E7856422F", 1))
    level thread scripts\cp\cp_gameskill::_id_E63A845C77F9AA8A();
}

_id_840A5E4F7961DF6B() {
  return undefined;
}

exit_laststand_func(player) {
  player _id_1DB8D0E02A99C5E2::_id_2DD3214261E60026();
  player setclientomnvar("ui_is_laststand", 0);
  player clearclienttriggeraudiozone(0.3);
  player playlocalsound("deaths_door_out");
  player stoplocalsound("deaths_door_in");

  if(isDefined(level.vision_set_override))
    player thread reset_override_visionset(0.2);

  _id_A91C50E065B4BEBE = randomintrange(1, 5);
  _id_56F3CCDE65AF5B46 = "zmb_revive_music_lr_0" + _id_A91C50E065B4BEBE;
  player scripts\cp\utility::playlocalsound_safe(_id_56F3CCDE65AF5B46);
  player scripts\cp\utility::allow_player_ignore_me(0);
  player thread scripts\engine\utility::delaythread(2, _id_12E2FB553EC1605E::_id_A01818AE9EDECBE6, 1);
  player thread scripts\engine\utility::delaythread(2, _id_12E2FB553EC1605E::_id_A6EB74F88574F882, 1);

  if(scripts\cp\utility::is_raid_gamemode())
    player scripts\cp\utility::allow_player_basejumping(0, "raid_parachute");
}

reset_override_visionset(timer) {
  level endon("game_ended");
  self endon("disconnect");
  wait(timer);

  if(isDefined(level.vision_set_override))
    level notify("vision_set_change_request", level.vision_set_override, self, 0.1);
}

onstartgametype() {
  _id_3FEEC618E51A6291::do_starts();
  scripts\cp\utility::set_segmented_health_regen_parameters(100, 100, 25, 2, 1, 0.05);
  _id_3BCAA2CBAF54ABDD::register_eog_to_lb_playerdata_mapping();
  scripts\cp\cp_analytics::initlevelvars();
  level thread update_laststand_times();

  if(!isDefined(level.kick_player_queue) && getdvarint("dvar_A9BD7A859F32D084", 0))
    level thread kick_player_queue_loop();

  level thread init_enemy_spawner();
  level.teamdata["allies"]["hasSpawned"] = 0;
  level.teamdata["allies"]["players"] = [];
  level.teamdata["axis"]["hasSpawned"] = 0;
  level.teamdata["axis"]["players"] = [];
  level.ascendermsgfunc = ::ascendermsgfunc;
  _id_703FDBB02501D31E::_id_276D0D2C772B45BB("cash_drop_100");
  _id_703FDBB02501D31E::_id_276D0D2C772B45BB("cash_drop_500");
  _id_56EF8D52FE1B48A1::init_super();
  setdvarifuninitialized("dvar_98608587FF94283E", 1);
  setDvar("bg_piggybackArmorOnNVG", 1);
  thread scripts\cp_mp\auto_ascender::init();
  thread scripts\cp_mp\auto_ascender_solo::init();
  thread scripts\cp_mp\ent_manager::init();
  thread _id_C47EE3C82EA9FA70();
  level scripts\cp\calloutmarkerping_cp::calloutmarkerping_init();

  if(!isDefined(level.normal_mode_activation_funcs))
    level.normal_mode_activation_funcs = [];

  if(!isDefined(level.special_mode_activation_funcs))
    level.special_mode_activation_funcs = [];

  if(!isDefined(level.pentskipfov))
    level.pentskipfov = [];

  if(!isDefined(level.pentparams))
    level.pentparams = [];

  level.spawnloopupdatefunc = _id_18A73A64992DD07D::update_spawn_data_on_death;
  _id_3BCAA2CBAF54ABDD::rank_init();
  level thread handlenondeterministicentities();
  level thread checkpoint_revive();
  thread scripts\cp\cp_outofbounds::initoob();
  scripts\cp\cp_outofbounds::killstreakregisteroobcallbacks();

  if(level.gametype == "cp_survival") {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
      level.players[_id_AC0E594AC96AA3A8] setclientomnvar("ui_session_state", "spectator");
  }

  level thread scripts\cp\utility::_id_76BA4ACF14679724();
}

init_enemy_spawner() {
  _id_54F6CD90DD31BBF0::spawner_scoring_init();
}

onprecachegametype() {
  level._effect["vfx_gameplay_tier2_helmet_pop"] = loadfx("vfx/iw9/gameplay/mp/vfx_gameplay_tier2_helmet_pop.vfx");
  level._effect["vfx_gameplay_tier3_helmet_pop"] = loadfx("vfx/iw9/gameplay/mp/vfx_gameplay_tier3_helmet_pop.vfx");
  _id_435C3F85A3D06576::_id_041B2475A04910BA();
  _id_435C3F85A3D06576::_id_47F4F9F3FA1A644D();
  precachempanim("mp_dogtag_spin");
}

handlenondeterministicentities() {
  level endon("game_ended");
  wait 5;
  level notify("spawn_nondeterministic_entities");

  if(isDefined(level.post_nondeterministic_func))
    level thread[[level.post_nondeterministic_func]]();
}

_id_C47EE3C82EA9FA70() {
  scripts\engine\utility::flag_wait("level_ready_for_script");
  _id_D560FEC5DA37ED20 = getEntArray("ammo_refil_station", "targetname");
  _id_D560FEC5DA37ED20 = scripts\engine\utility::array_combine(getEntArray("ammo_refill_station", "targetname"), _id_D560FEC5DA37ED20);

  if(!istrue(level._id_CEE48B761F8CA747) && istrue(level._id_3480ABEA6656FCE6)) {
    foreach(_id_F4CD4BA928C38D78 in _id_D560FEC5DA37ED20)
    _id_F4CD4BA928C38D78 setscriptablepartstate("military_ammo_restock", "USEABLE_ON_NO_ARMOR");

    return;
  } else if(!istrue(level._id_3480ABEA6656FCE6) && istrue(level._id_CEE48B761F8CA747)) {
    foreach(_id_F4CD4BA928C38D78 in _id_D560FEC5DA37ED20)
    _id_F4CD4BA928C38D78 setscriptablepartstate("military_ammo_restock", "USEABLE_ON_NO_EQUIPMENT");

    return;
  } else if(!istrue(level._id_3480ABEA6656FCE6) && !istrue(level._id_CEE48B761F8CA747)) {
    foreach(_id_F4CD4BA928C38D78 in _id_D560FEC5DA37ED20)
    _id_F4CD4BA928C38D78 setscriptablepartstate("military_ammo_restock", "USEABLE_ON_ONLY_AMMO");
  }
}

_id_476934EBCF86281D() {
  self setplayerdata("cp", "CPSession", "timeSurvivedLastMatch", 0);
  self setplayerdata("cp", "CPSession", "isPersonalBestLastMatch", 0);
  self setplayerdata("cp", "CPSession", "hasCompletedLastMatch", 0);
  self.xpscale = getdvarint("online_zombies_xpscale");
  self.weaponxpscale = getdvarint("online_zombie_weapon_xpscale");

  if(scripts\cp\utility::rankingenabled()) {
    _id_69A07D6024AEB70B = getdvarint("online_zombie_party_weapon_xpscale");
    _id_2B96F5B26B76CABB = getdvarint("online_zombie_party_xpscale");
    _id_E2F208FF5491C24E = self getprivatepartysize() > 1;

    if(isDefined(_id_69A07D6024AEB70B)) {
      if(_id_E2F208FF5491C24E && _id_69A07D6024AEB70B > 1)
        self.weaponxpscale = _id_69A07D6024AEB70B;
    }

    if(isDefined(_id_2B96F5B26B76CABB)) {
      if(_id_E2F208FF5491C24E && _id_2B96F5B26B76CABB > 1)
        self.xpscale = _id_2B96F5B26B76CABB;
    }
  }

  self.total_currency_earned = 0;
}

_id_6A98C6DA3DFA5426() {
  scripts\cp\cp_analytics::on_player_connect();
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_player_first_connect", self);
}

_id_ABE70D559DB2E125() {
  self.num_of_plays = [];
}

_id_15D7372202E8E1A9() {
  self.can_give_revive_xp = 1;

  if(isDefined(self.connecttime))
    self.connect_time = self.connecttime;
  else
    self.connect_time = gettime();

  thread _id_116171939929AF39::player_init_health_regen();
  _id_3BCAA2CBAF54ABDD::session_stats_init();
  self.recentkillcount = 0;
  self.enabledignoreme = 0;
  _id_1DAB4A6BAD01C509 = self getentitynumber();
  self setclientomnvar("ui_client_num", _id_1DAB4A6BAD01C509);
  _id_0AFB7E332AEE4BF2::_id_9B04C8ABB560BA40();
  self.timeplayed = [];

  foreach(team in level.teamnamelist)
  self.timeplayed[team] = 0;

  self.timeplayed["total"] = 0;
  self.timeplayed["missionTeam"] = 0;
  self.timeplayed["other"] = 0;
  self.timeplayed["timeDead"] = 0;
  self.achievement_registration_func = scripts\cp\cp_achievement::register_default_achievements;
  scripts\cp\cp_achievement::init_player_achievements(self);
  self.spawntimestamp = self.connect_time;
  scripts\cp\cp_mapselect::set_uav_radarstrength(self);
  _id_3BCAA2CBAF54ABDD::lb_player_update_stat("waveNum", level.wave_num, 1);
  _id_3BCAA2CBAF54ABDD::player_persistence_init();
  thread scripts\cp\cp_analytics::init_weapon_and_player_analytics(self);

  if(!isDefined(level.kick_player_queue) && getdvarint("dvar_A9BD7A859F32D084", 0))
    thread kick_for_inactivity(self);

  thread _id_00E33B20F5FE616A();
  self.disabledteleportation = 0;
  scripts\cp\utility::allow_player_teleport(0);
  thread _id_0A54323530992C18();
  scripts\cp_mp\calloutmarkerping::calloutmarkerping_initplayer();
  self.gameskill = scripts\cp\cp_gameskill::get_gameskill();
  scripts\cp\cp_gameskill::set_difficulty_from_locked_settings();
  self.powers = [];
  self.powers_active = [];
  self.power_cooldowns = 0;
  self.disabled_interactions = [];
  self.disabledinteractions = 0;
  self.pap = [];
  self.self_revives_purchased = 0;
  self.max_self_revive_machine_use = 3;
  self.cash_scalar = 1;
  self.infiniteammocounter = 0;

  if(istestclient(self))
    thread testclient_ignoreme_dvar();
}

testclient_ignoreme_dvar() {
  if(getdvarint("dvar_BB2888F50EAE5956", 0) == 0) {
    return;
  }
  wait 3;
  self.ignoreme = 1;
}

_id_00E33B20F5FE616A() {
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, index);

    if(_id_53AA0268E875EAFB()) {
      if(_id_7148C1A6F25491F8 == "restart_from_checkpoint") {
        _id_B1371367551B7B36(2);
        _id_4681153436825797 = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

        if(isDefined(level._id_633EE74E2649AAC7))
          [[level._id_633EE74E2649AAC7]]();

        if(isDefined(_id_4681153436825797) && _id_4681153436825797 != "")
          scripts\cp\utility::_id_2C08BE5ADB8B60F4();
        else
          game["star_rewards_times"] = undefined;

        if(isDefined(_id_4681153436825797))
          scripts\cp\cp_checkpoint::checkpoint_set(_id_4681153436825797, 1);

        _id_467F0FDFDD155A45::freezeallplayers(1.0, "cg_fovScale", 1);

        foreach(player in level.players) {
          level thread scripts\engine\utility::delaythread(1.5, scripts\cp_mp\utility\game_utility::fadetoblackforplayer, player, 1, 2);
          player thread scripts\cp\cp_hud_message::tutorialprint(&"COOP_GAME_PLAY/RESTART_FROM_CHECKPOINT", 2);
          player.ignoreme = 1;
          player.ability_invulnerable = 1;
          player notify("force_regeneration");
        }

        _id_467F0FDFDD155A45::_id_180B06D3D67D483C("Restart From Checkpoint Used");
        _id_E324581866772E44 = level._id_BBEEFAD58B75989A;
        level._id_BBEEFAD58B75989A = 1;
        wait 4;
        level._id_BBEEFAD58B75989A = _id_E324581866772E44;
        _id_467F0FDFDD155A45::restart_map(undefined, "map_restart");
      }

      if(_id_7148C1A6F25491F8 == "mission_restart") {
        _id_B1371367551B7B36(1);
        game["star_rewards_times"] = undefined;

        if(isDefined(level._id_633EE74E2649AAC7))
          [[level._id_633EE74E2649AAC7]](1);

        scripts\cp\cp_checkpoint::checkpoint_set("");
        _id_467F0FDFDD155A45::freezeallplayers(1.0, "cg_fovScale", 1);

        foreach(player in level.players) {
          player.pers["loadout"] = undefined;
          player.pers["equipment"] = undefined;
          player.pers["super"] = undefined;
          player.pers["intel"] = undefined;

          if(isDefined(player.pers["counting_stats"])) {
            if(isDefined(player.pers["counting_stats"]["kills"]))
              player.pers["counting_stats"]["kills"] = undefined;

            if(isDefined(player.pers["counting_stats"]["downs"]))
              player.pers["counting_stats"]["downs"] = undefined;

            if(isDefined(player.pers["counting_stats"]["revives"]))
              player.pers["counting_stats"]["revives"] = undefined;
          }

          level thread scripts\engine\utility::delaythread(1.5, scripts\cp_mp\utility\game_utility::fadetoblackforplayer, player, 1, 2);
        }

        _id_467F0FDFDD155A45::_id_180B06D3D67D483C("Mission Restart Used");

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
          level.players[_id_AC0E594AC96AA3A8] thread scripts\cp\cp_hud_message::tutorialprint(&"COOP_GAME_PLAY/RESTART_MISSION", 2);
          level.players[_id_AC0E594AC96AA3A8].ignoreme = 1;
          level.players[_id_AC0E594AC96AA3A8].ability_invulnerable = 1;
          level.players[_id_AC0E594AC96AA3A8] notify("force_regeneration");
        }

        _id_E324581866772E44 = level._id_BBEEFAD58B75989A;
        level._id_BBEEFAD58B75989A = 1;
        wait 4;
        level._id_BBEEFAD58B75989A = _id_E324581866772E44;
        _id_467F0FDFDD155A45::restart_map(undefined, "map_restart");
      }

      continue;
    }

    if(_id_7148C1A6F25491F8 == "mission_restart" || _id_7148C1A6F25491F8 == "restart_from_checkpoint")
      thread scripts\cp\cp_hud_message::tutorialprint(&"COOP_GAME_PLAY/RESTART_DISABLED", 5);
  }
}

_id_B1371367551B7B36(value) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(level.players[_id_AC0E594AC96AA3A8] == self) {
      continue;
    }
    level.players[_id_AC0E594AC96AA3A8] setclientomnvar("ui_restart_selected", value);
  }
}

_id_53AA0268E875EAFB() {
  if(istrue(level._id_BBEEFAD58B75989A))
    return 0;

  return 1;
}

_id_CD054D9BA5A62557(_id_E3108E412AFB3811) {
  level._id_BBEEFAD58B75989A = !_id_E3108E412AFB3811;
}

hotjoin_protection() {
  self notify("hotjoin_protection");
  self endon("hotjoin_protection");
  self endon("disconnect");
  scripts\cp\utility::allow_player_ignore_me(1);
  self.ability_invulnerable = 1;
  wait 8;
  scripts\cp\utility::allow_player_ignore_me(0);
  self.ability_invulnerable = undefined;
}

onspawnplayer(_id_13FE2B86C5E85A64) {
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
  self.class = "none";
  self.armorqueued = 0;
  _id_0AFB7E332AEE4BF2::_id_9B04C8ABB560BA40();
  _id_3B64EB40368C1450::_id_8B5F9E0014775208();
  scripts\cp_mp\utility\damage_utility::cleardamagemodifiers();
  thread _id_6E09A830FAB9468F::watchcombatspeedscaler();

  if(isDefined(level.custom_onspawnplayer_func))
    self[[level.custom_onspawnplayer_func]]();

  if(istrue(level.parachutecancutautodeploy))
    self skydive_cutautodeployon();
  else
    self skydive_cutautodeployoff();

  if(istrue(level.parachutecancutparachute))
    self skydive_cutparachuteon();
  else
    self skydive_cutparachuteoff();

  _id_116171939929AF39::player_init_invulnerability();
  _id_116171939929AF39::player_init_damageshield();
  thread _id_3E1F4659860B35D9();
  thread _id_0AFB7E332AEE4BF2::_id_73707F2512AA6814();
  thread add_player_to_threatbias_group();
  thread scripts\cp\coop_personal_ents::assignpersonalmodelents(self);
  thread scripts\cp\coop_personal_ents::movepentstostructs(self);

  if(scripts\cp\utility::_id_6AAFBDD00B977115())
    thread scripts\cp\equipment\nvg::runnvg();

  if(isDefined(self.anchor))
    self.anchor delete();

  scripts\cp\utility::force_usability_enabled();
  self.hasspawned = 1;
  self.pers["hasSpawned"] = 1;
}

add_player_to_threatbias_group() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(self == level.players[_id_AC0E594AC96AA3A8]) {
      _id_64F22D47F382BD43 = _id_AC0E594AC96AA3A8 + 1;

      if(_id_64F22D47F382BD43 == 5) {
        return;
      }
      self setthreatbiasgroup("player" + _id_64F22D47F382BD43);
    }
  }
}

get_starting_currency(player) {
  starting_currency_after_revived_from_spectator = player.starting_currency_after_revived_from_spectator;

  if(isDefined(starting_currency_after_revived_from_spectator)) {
    player.starting_currency_after_revived_from_spectator = undefined;
    return starting_currency_after_revived_from_spectator;
  } else
    return _id_3BCAA2CBAF54ABDD::get_starting_currency();
}

set_player_max_currency(amount) {
  amount = int(amount);
  self.maxcurrency = amount;
}

prespawnfromspectatorfunc(player) {
  if(istrue(level._id_F4C8727CAC33C176))
    player._id_57C207FDE9B78089 = 1;

  revivefromspectatorweaponsetup(player);
  set_spawn_loc(player);
}

revivefromspectatorweaponsetup(player) {
  weaponlist = spawnStruct();
  weaponlist.copy_fullweaponlist = player.copy_fullweaponlist;
  weaponlist.copy_weapon_current = player.copy_weapon_current;
  weaponlist.copy_weapon_ammo_clip = player.copy_weapon_ammo_clip;
  weaponlist.copy_weapon_ammo_stock = player.copy_weapon_ammo_stock;

  if(isDefined(player.saved_last_stand_pistol)) {
    weaponlist.last_stand_pistol = player.saved_last_stand_pistol;
    player.saved_last_stand_pistol = undefined;
  } else
    weaponlist.last_stand_pistol = player.last_stand_pistol;

  weaponlist.weapon_levels = player.copy_weapon_level;

  if(isDefined(player.current_crafted_inventory)) {
    weaponlist.current_crafted_inventory = player.current_crafted_inventory;
    player.current_crafted_inventory = undefined;
  }

  weaponlist.copy_all_powers = player.pre_laststand_powers;
  weaponlist.copy_special_ammo_type = player.special_ammo_type;
  player.weaponlist = weaponlist;
}

set_spawn_loc(player) {
  spawnpoint = getplayerrespawnloc(player);
  player _id_116171939929AF39::setforcespawninfo(spawnpoint.origin, spawnpoint.angles);

  if(isDefined(player.respawn_forcespawnorigin))
    player.forcespawnorigin = player.respawn_forcespawnorigin;

  if(isDefined(player.respawn_forcespawnangles))
    player.forcespawnangles = player.respawn_forcespawnangles;
}

getplayerrespawnloc(downed_player) {
  if(isDefined(level.force_respawn_location))
    return [[level.force_respawn_location]](downed_player);

  if(!isDefined(level.active_player_respawn_locs) || level.active_player_respawn_locs.size == 0 || level.players.size == 0)
    return [[level.getspawnpoint]]();

  if(isDefined(level.respawn_loc_override_func))
    return [[level.respawn_loc_override_func]](downed_player);

  _id_28E11B47827DA015 = get_available_players(downed_player);
  _id_5DD3D8AA84432CA3 = get_available_respawn_locs(_id_28E11B47827DA015);

  if(_id_5DD3D8AA84432CA3.size == 0)
    return get_respawn_loc_near_team_center(downed_player, _id_28E11B47827DA015);

  if(_id_5DD3D8AA84432CA3.size == 1)
    return _id_5DD3D8AA84432CA3[0];

  return downed_player get_respawn_loc_rated(_id_28E11B47827DA015, _id_5DD3D8AA84432CA3);
}

get_available_players(downed_player) {
  _id_28E11B47827DA015 = [];

  foreach(player in level.players) {
    if(player == downed_player) {
      continue;
    }
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
      continue;
    }
    _id_28E11B47827DA015[_id_28E11B47827DA015.size] = player;
  }

  return _id_28E11B47827DA015;
}

get_available_respawn_locs(_id_28E11B47827DA015) {
  _id_5DD3D8AA84432CA3 = [];

  foreach(_id_C337FC4166B34662 in level.active_player_respawn_locs) {
    if(!canspawn(_id_C337FC4166B34662.origin)) {
      continue;
    }
    if(positionwouldtelefrag(_id_C337FC4166B34662.origin)) {
      continue;
    }
    if(is_respawn_loc_near_available_players(_id_C337FC4166B34662, _id_28E11B47827DA015)) {
      continue;
    }
    if(is_respawn_loc_near_alive_enemies(_id_C337FC4166B34662)) {
      continue;
    }
    _id_5DD3D8AA84432CA3[_id_5DD3D8AA84432CA3.size] = _id_C337FC4166B34662;
  }

  return _id_5DD3D8AA84432CA3;
}

is_respawn_loc_near_available_players(_id_D95EF4BCC28FA1AA, _id_28E11B47827DA015) {
  foreach(_id_B2143E1339865CE4 in _id_28E11B47827DA015) {
    if(distancesquared(_id_B2143E1339865CE4.origin, _id_D95EF4BCC28FA1AA.origin) < 250000)
      return 1;
  }

  return 0;
}

is_respawn_loc_near_alive_enemies(_id_D95EF4BCC28FA1AA) {
  _id_CCC9F9C05ABCFDE9 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(_id_2E90373C39823C95 in _id_CCC9F9C05ABCFDE9) {
    if(distancesquared(_id_2E90373C39823C95.origin, _id_D95EF4BCC28FA1AA.origin) < 250000)
      return 1;
  }

  return 0;
}

get_respawn_loc_near_team_center(downed_player, _id_28E11B47827DA015) {
  _id_05B96A0B63B2DA7F = 0;
  _id_05B9690B63B2D84C = 0;
  _id_05B96C0B63B2DEE5 = 0;
  counter = 0;

  foreach(player in _id_28E11B47827DA015) {
    _id_05B96A0B63B2DA7F = _id_05B96A0B63B2DA7F + player.origin[0];
    _id_05B9690B63B2D84C = _id_05B9690B63B2D84C + player.origin[1];
    _id_05B96C0B63B2DEE5 = _id_05B96C0B63B2DEE5 + player.origin[2];
    counter++;
  }

  _id_BF41D0CE35D5C8EC = (_id_05B96A0B63B2DA7F / counter, _id_05B9690B63B2D84C / counter, _id_05B96C0B63B2DEE5 / counter);
  _id_2D6C745AFAB7A7B1 = sortbydistance(level.active_player_respawn_locs, _id_BF41D0CE35D5C8EC);
  return _id_2D6C745AFAB7A7B1[0];
}

get_respawn_loc_rated(_id_28E11B47827DA015, _id_5DD3D8AA84432CA3) {
  _id_6E1F6C61482C7506 = scripts\engine\utility::ter_op(_id_28E11B47827DA015.size == 0, 1, _id_28E11B47827DA015.size);
  _id_5408A7783CA52166 = level.spawned_enemies.size / _id_6E1F6C61482C7506;
  _id_620C96A13D50E7BD = _id_5408A7783CA52166 * 2;
  _id_A7B39F36AFAD5914 = -99999999;
  _id_D024CACEC9D41EFD = undefined;

  foreach(_id_FDF23B2021E21BA2 in _id_5DD3D8AA84432CA3) {
    _id_2CEC23DDABF59363 = 0;

    foreach(player in _id_28E11B47827DA015) {
      if(player == self) {
        continue;
      }
      if(!isalive(player)) {
        continue;
      }
      if(istrue(player.inlaststand)) {
        _id_2CEC23DDABF59363 = _id_2CEC23DDABF59363 - distancesquared(player.origin, _id_FDF23B2021E21BA2.origin) * (_id_620C96A13D50E7BD * 2);
        continue;
      }

      _id_2CEC23DDABF59363 = _id_2CEC23DDABF59363 - distancesquared(player.origin, _id_FDF23B2021E21BA2.origin) * _id_620C96A13D50E7BD;
    }

    foreach(_id_C8C0E3CBCE8F401A in level.spawned_enemies)
    _id_2CEC23DDABF59363 = _id_2CEC23DDABF59363 + distancesquared(_id_C8C0E3CBCE8F401A.origin, _id_FDF23B2021E21BA2.origin);

    _id_2CEC23DDABF59363 = _id_2CEC23DDABF59363 / 1000000;

    if(_id_2CEC23DDABF59363 > _id_A7B39F36AFAD5914) {
      _id_A7B39F36AFAD5914 = _id_2CEC23DDABF59363;
      _id_D024CACEC9D41EFD = _id_FDF23B2021E21BA2;
    }
  }

  return _id_D024CACEC9D41EFD;
}

prematchfunc() {
  prematchperiod = 0;

  if(prematchperiod > 0) {
    player = level wait_for_first_player_connect();
    wait(prematchperiod - 3);

    if(isDefined(level.postintroscreenfunc))
      [[level.postintroscreenfunc]]();

    scripts\engine\utility::flag_set("introscreen_over");
    level.introscreen_done = 1;
  } else {
    if(scripts\engine\utility::flag("infil_complete")) {}

    level.introscreen_done = 1;
    scripts\engine\utility::flag_set("introscreen_over");
  }

  if(istrue(level.intermission))
    return;
}

_id_D099C5897E9877A0() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  level waittill("show_chyrons", delay);

  if(isDefined(delay))
    wait(delay);

  show_introscreen_text();
  _id_B809AC841A0C626E(6);
}

_id_3C30EAE58FA58A37() {
  if(getdvarint("dvar_8E13D59B3F6A0521") || istrue(level._id_37190777EEB4333F))
    return 1;

  _id_DDAC31817B064B95 = getDvar("ui_mapname");
  _id_892708EFF6520B44 = getDvar(_func_2EF675C13CA1C4AF("dvar_287B3B75F2C14FE9", _id_DDAC31817B064B95), _id_16099993B2A42B16());
  return isDefined(_id_892708EFF6520B44) && _id_892708EFF6520B44 != "";
}

show_introscreen_text() {
  _id_DDAC31817B064B95 = getDvar("ui_mapname");
  _id_892708EFF6520B44 = getDvar(_func_2EF675C13CA1C4AF("dvar_287B3B75F2C14FE9", _id_DDAC31817B064B95), _id_16099993B2A42B16());
  _id_A1F826C73E18485B = "cp/" + _id_DDAC31817B064B95 + "_objectives.csv";
  _id_D31685C0A626FF37 = int(tablelookup(_id_A1F826C73E18485B, 1, _id_892708EFF6520B44, 0));

  if(isDefined(_id_892708EFF6520B44) && _id_892708EFF6520B44 != "") {
    self setclientomnvar("ui_hide_hud", 0);
    self setclientomnvar("ui_chyron_mission_index", _id_D31685C0A626FF37);
    self setclientomnvar("ui_chyron_on", 1);
  }
}

_id_B809AC841A0C626E(delay) {
  self endon("disconnect");

  if(isDefined(delay))
    wait(delay);

  self setclientomnvar("ui_hide_hud", 0);
  self setclientomnvar("ui_chyron_on", 0);
  self setclientomnvar("ui_chyron_mission_index", 0);
}

_id_16099993B2A42B16() {
  switch (level.script) {
    case "cp_hydro":
      return "stealth_container";
    case "cp_mission_esc":
      return "obj_escape_chyrons";
    case "cp_raid1_boss1":
      return "chyrons";
    default:
      return "";
  }
}

wait_for_first_player_connect() {
  player = undefined;

  if(level.players.size == 0)
    level waittill("connected", player);
  else
    player = level.players[0];

  return player;
}

_id_0A54323530992C18() {
  if(isDefined(level.strike_player_connect_black_screen_fn))
    [[level.strike_player_connect_black_screen_fn]](self);
  else
    _id_2C1C1D3964F1BCB7();
}

_id_2C1C1D3964F1BCB7() {
  self endon("disconnect");
  self endon("stop_intro");

  if(_id_3C30EAE58FA58A37()) {
    self setclientomnvar("ui_hide_hud", 1);
    scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 1, 0);
  }

  self waittill("spawned");
  self setsoundsubmix("iw9_cp_intro_black");
  thread _id_7EE6F60568E750FF();

  if(_id_3C30EAE58FA58A37()) {
    scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
    self disableweapons();
    scripts\cp\utility::freezecontrolswrapper(1);

    if(istrue(self.ishotjoiningplayer)) {
      if(scripts\engine\utility::flag_exist("strike_init_done"))
        scripts\engine\utility::flag_wait("strike_init_done");

      if(!scripts\engine\utility::flag("introscreen_over"))
        scripts\engine\utility::flag_wait("introscreen_over");

      wait 1;
      thread _id_D099C5897E9877A0();
      thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 0, 4);
      wait 2;
      scripts\cp\utility::freezecontrolswrapper(0);
      self setclientomnvar("ui_hide_hud", 0);
      self enableweapons();
      _id_116171939929AF39::refreshuimatchinprogressomnvarvalue();
    } else {
      if(isDefined(level.player_controls_failsafe))
        self thread[[level.player_controls_failsafe]]();

      if(scripts\engine\utility::flag_exist("strike_init_done"))
        scripts\engine\utility::flag_wait("strike_init_done");

      if(!scripts\engine\utility::flag("introscreen_over"))
        scripts\engine\utility::flag_wait("introscreen_over");

      wait 6;
      _id_17B49115747DDFEC();
      thread _id_D099C5897E9877A0();

      if(!istrue(level._id_A37A759E3BE7F4CE))
        thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 0, 6);

      wait 1;
    }

    scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
    level._id_3CE2DE189EFF819B++;

    if(getdvarint("dvar_03BBBED1090811C4", 0) == 0)
      thread _id_2957797B844CB941();
    else {
      scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 0, 0);
      scripts\cp\utility::freezecontrolswrapper(0);
      self setclientomnvar("ui_hide_hud", 0);
      self enableweapons();
      _id_116171939929AF39::refreshuimatchinprogressomnvarvalue();
      scripts\engine\utility::ent_flag_set("intro_binks_complete");
      scripts\engine\utility::flag_set("intro_binks_complete");
      scripts\engine\utility::flag_set("both_players_intro_binks_complete");
    }
  }
}

_id_847508E235FD547C() {
  level endon("game_ended");

  if(getdvarint("dvar_E15D9836CD3C3360", 0) != 0) {
    scripts\engine\utility::flag_set("safe_to_start_binks_now");
    return;
  }

  if(scripts\cp\utility::_id_2597E428C03B341C()) {
    scripts\engine\utility::flag_set("safe_to_start_binks_now");
    return;
  }

  if(!isdedicatedserver()) {
    scripts\engine\utility::flag_set("safe_to_start_binks_now");
    return;
  }

  if(istrue(game["has_seen_binks"])) {
    scripts\engine\utility::flag_set("safe_to_start_binks_now");
    return;
  }

  if(scripts\cp\utility::_id_138028CA2B958511()) {
    start = getDvar("start");

    if(start != "captured" && start != "") {
      scripts\engine\utility::flag_set("safe_to_start_binks_now");
      return;
    }
  } else {
    scripts\engine\utility::flag_set("safe_to_start_binks_now");
    return;
  }

  level endon("game_ended");
  _id_DC10F2AB37E368E8 = 0;
  _id_24D7D1143698395A = getdvarint("party_minplayers");
  max_size = 2;

  if(scripts\cp\utility::_id_138028CA2B958511())
    max_size = 3;

  if(_id_24D7D1143698395A != max_size) {
    _id_DC10F2AB37E368E8 = 1;
    scripts\engine\utility::flag_set("safe_to_start_binks_now");
    return;
  }

  while(!isDefined(level.players))
    waitframe();

  _id_E8EA021DB03F054D = getdvarint("sv_connectTimeout");
  time = gettime();

  while(gettime() <= time + _id_E8EA021DB03F054D * 1000) {
    if(level._id_3CE2DE189EFF819B == max_size) {
      break;
    }

    wait 1;
  }

  scripts\engine\utility::flag_set("safe_to_start_binks_now");
}

_id_7EE6F60568E750FF() {
  self endon("disconnect");
  scripts\engine\utility::flag_wait("intro_binks_complete");
  scripts\engine\utility::ent_flag_wait("intro_binks_complete");
  self clearsoundsubmix("iw9_cp_intro_black", 0);
}

lbravo_infil_spawn_blackscreen_func(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("stop_intro");

  if(_id_3C30EAE58FA58A37()) {
    player setclientomnvar("ui_hide_hud", 1);
    scripts\cp_mp\utility\game_utility::_id_852712268D005332(player, 1, 0);
  }

  player waittill("spawned");

  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  if(scripts\engine\utility::flag_exist("introscreen_over"))
    scripts\engine\utility::flag_wait("introscreen_over");

  player setsoundsubmix("iw9_cp_intro_black");
  player thread _id_7EE6F60568E750FF();

  if(isDefined(level._id_C305C6C4B514E53B) && isfunction(level._id_C305C6C4B514E53B))
    player[[level._id_C305C6C4B514E53B]](0, undefined, 0);
  else
    player _id_12E2FB553EC1605E::givedefaultloadout(0, undefined, 0);

  player disableweapons();
  player scripts\cp\utility::freezecontrolswrapper(1);

  if(getdvarint("dvar_03BBBED1090811C4", 0) == 0)
    player thread _id_2957797B844CB941();
  else {
    player scripts\engine\utility::ent_flag_set("intro_binks_complete");
    scripts\engine\utility::flag_set("intro_binks_complete");
    scripts\engine\utility::flag_set("both_players_intro_binks_complete");
  }

  scripts\engine\utility::flag_wait("intro_binks_complete");

  if(player scripts\engine\utility::ent_flag("intro_binks_complete")) {
    scripts\cp_mp\utility\game_utility::_id_852712268D005332(player, 0, 0);
    player setclientomnvar("ui_hide_hud", 0);
    player scripts\cp\utility::freezecontrolswrapper(0);
  }

  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  _id_116171939929AF39::refreshuimatchinprogressomnvarvalue();
  player scripts\cp\utility::freezecontrolswrapper(0);
  player enableweapons();

  if(scripts\engine\utility::flag_exist("infil_over") && !scripts\engine\utility::flag("infil_over")) {
    scripts\cp_mp\utility\game_utility::_id_852712268D005332(player, 0, 0);
    player setclientomnvar("ui_hide_hud", 0);
    level notify("trying_to_join_infil", player);
  } else {
    if(isDefined(level._id_C305C6C4B514E53B) && isfunction(level._id_C305C6C4B514E53B)) {} else
      player notify("open_loadout_menu");

    scripts\cp_mp\utility\game_utility::_id_852712268D005332(player, 0, 4);
    player setclientomnvar("ui_hide_hud", 0);
  }
}

_id_17B49115747DDFEC() {
  scripts\engine\utility::flag_set("player_spawned_with_loadout");
}

callbackplayerkilled(inflictor, attacker, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration) {
  _id_25845ACA699D038D::playerkilled_internal(inflictor, attacker, self, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, 0);
}

enter_laststand(player, attacker) {
  player _id_3BCAA2CBAF54ABDD::eog_player_update_stat("downs", 1);
  player scripts\cp\cp_analytics::log_event("dropped_to_last_stand", 1, [player.clientid], [player.clientid], [player.clientid]);
  player.pre_arcade_game_weapon = undefined;
  player.pre_arcade_game_weapon_clip = undefined;
  player.pre_arcade_game_weapon_stock = undefined;
  player.former_mule_weapon = undefined;
  player _id_1DB8D0E02A99C5E2::_id_7C70DC615DA72C51();
  player _id_7EF95BBA57DC4B82::clearallequipment();
  currentweapon = player getcurrentweapon();
  _id_66B240BF0B2BAFF8 = getweaponbasename(currentweapon);
  _id_6A3B7F7386AB3BE8 = player getcurrentweaponclipammo();

  if(!isDefined(player.downsperweaponlog[_id_66B240BF0B2BAFF8]))
    player.downsperweaponlog[_id_66B240BF0B2BAFF8] = 1;
  else
    player.downsperweaponlog[_id_66B240BF0B2BAFF8]++;

  player clearclienttriggeraudiozone(0);

  if(!self issplitscreenplayer())
    player setclienttriggeraudiozonepartialwithfade("last_stand_cp", 0.02, "mix", "reverb", "filter");

  have_self_revive = player scripts\cp\utility::has_auto_revive();

  if(have_self_revive) {
    _id_F4A1F546FFFCD5E4 = scripts\cp\utility::isplayingsolo() || level.only_one_player;
    player notify("player_has_self_revive", _id_F4A1F546FFFCD5E4);
  }

  if(isDefined(player.mule_weapon) && !istrue(player.playing_ghosts_n_skulls))
    player.former_mule_weapon = player.mule_weapon;
  else
    player.former_mule_weapon = undefined;

  player scripts\cp\utility::allow_player_ignore_me(1);
  player setclientomnvar("ui_is_laststand", 1);
}

onplayerdisconnect(_id_2421296BA8CCB5EE, _id_401C3A2E68AAB0FD) {
  _id_2421296BA8CCB5EE setplayerdata("cp", "CPSession", "subParty", -1);
  _id_3BCAA2CBAF54ABDD::eog_update_on_player_disconnect(_id_2421296BA8CCB5EE);

  if(isDefined(level._id_88714F70DBEA9FE4))
    [[level._id_88714F70DBEA9FE4]](_id_2421296BA8CCB5EE);
}

endgame_clientmatchdata(player, _id_0432A6B6AADCC1EF) {}

hostmigrationstart() {
  _id_CCC9F9C05ABCFDE9 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(zombie in _id_CCC9F9C05ABCFDE9) {
    if(istrue(zombie.scripted_mode)) {
      zombie.died_poorly = 1;
      zombie suicide();
      continue;
    } else if(istrue(zombie.ignoreme)) {
      zombie.died_poorly = 1;
      zombie suicide();
      continue;
    } else if(istrue(zombie.ignoreall)) {
      zombie.died_poorly = 1;
      zombie suicide();
      continue;
    } else if(!istrue(zombie.entered_playspace)) {
      zombie.died_poorly = 1;
      zombie suicide();
      continue;
    } else {
      zombie.scripted_mode = 1;
      zombie setgoalpos(zombie.origin);
      zombie.ignoreme = 1;
      zombie.ignoreall = 1;
    }
  }
}

hostmigrationend() {
  enemies = getaiarray("axis");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < enemies.size; _id_AC0E594AC96AA3A8++) {
    enemies[_id_AC0E594AC96AA3A8].scripted_mode = 0;
    enemies[_id_AC0E594AC96AA3A8].ignoreme = 0;
    enemies[_id_AC0E594AC96AA3A8].ignoreall = 0;
  }

  if(isDefined(level.customhostmigrationend))
    level thread[[level.customhostmigrationend]]();
}

kick_for_inactivity(player) {
  level endon("game_ended");
  player endon("disconnect");
  input_has_happened = 0;
  _id_A375F55FCB7B1C80 = gettime();
  _id_47309AB08FA928A9 = level.onlinegame && !getdvarint("xblive_privatematch");

  if(!_id_47309AB08FA928A9) {
    return;
  }
  player thread check_for_move_change();
  player thread check_for_movement();
  player notifyonplayercommand("inputReceived", "+speed_throw");
  player notifyonplayercommand("inputReceived", "+stance");
  player notifyonplayercommand("inputReceived", "+goStand");
  player notifyonplayercommand("inputReceived", "+usereload");
  player notifyonplayercommand("inputReceived", "+activate");
  player notifyonplayercommand("inputReceived", "+melee_zoom");
  player notifyonplayercommand("inputReceived", "+breath_sprint");
  player notifyonplayercommand("inputReceived", "+attack");
  player notifyonplayercommand("inputReceived", "+frag");
  player notifyonplayercommand("inputReceived", "+smoke");
  time = 120;
  _id_CD743003D3F4F0CA = 0.1;

  for(;;) {
    result = scripts\engine\utility::waittill_any_timeout_no_endon_death_2(_id_CD743003D3F4F0CA, "inputReceived", "currency_earned");

    if(gettime() - _id_A375F55FCB7B1C80 < 30000) {
      continue;
    }
    if(result != "timeout") {
      time = 120;
      input_has_happened = 1;
      continue;
    }

    if(!istrue(player.in_afterlife_arcade) && !istrue(player.inlaststand))
      time = time - _id_CD743003D3F4F0CA;

    if(time < 0) {
      if(input_has_happened) {
        input_has_happened = 0;
        continue;
      }

      add_to_kick_queue(player);
    }
  }
}

check_for_movement() {
  level endon("game_ended");
  self endon("disconnect");
  _id_F20CE68135A2BA2C = self getnormalizedmovement();
  _id_A375F55FCB7B1C80 = gettime();

  for(;;) {
    wait 0.2;
    _id_8929332B64537B53 = self getnormalizedmovement();

    if(_id_8929332B64537B53[0] == _id_F20CE68135A2BA2C[0] && _id_8929332B64537B53[1] == _id_F20CE68135A2BA2C[1]) {
      if(gettime() - _id_A375F55FCB7B1C80 > 90000)
        add_to_kick_queue(self);

      continue;
    }

    self notify("inputReceived");
    return;
  }
}

add_to_kick_queue(player) {
  if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
    return;
  }
  if(istrue(player.immune_against_kick_for_inactivity)) {
    return;
  }
  if(!scripts\engine\utility::array_contains(level.kick_player_queue, player))
    level.kick_player_queue = scripts\engine\utility::array_add_safe(level.kick_player_queue, player);
}

kick_player_queue_loop() {
  level endon("game_ended");
  level.kick_player_queue = [];

  for(;;) {
    if(level.kick_player_queue.size > 0) {
      foreach(player in level.kick_player_queue) {
        if(!isDefined(player)) {
          continue;
        }
        player thread delay_kick_inactive_player(player);
      }

      level.kick_player_queue = [];
    }

    wait 0.1;
  }
}

delay_kick_inactive_player(player) {
  level endon("game_ended");
  self endon("disconnect");
  _id_3E9F2BC33C97B138 = 10;

  if(istrue(player.being_kicked_from_inactivity)) {
    return;
  }
  player.being_kicked_from_inactivity = 1;
  player sethudtutorialmessage(&"COOP_GAME_PLAY/KICK_FOR_INACTIVITY", 1);
  player setclientomnvar("ui_kick_warning", 1);
  result = player scripts\engine\utility::waittill_any_in_array_or_timeout(["inputReceived"], _id_3E9F2BC33C97B138);
  player clearhudtutorialmessage();
  player setclientomnvar("ui_kick_warning", 0);
  player.being_kicked_from_inactivity = undefined;

  if(result == "timeout") {
    if(scripts\cp\utility::get_num_of_valid_players() == 1)
      level thread[[level.endgame]]("axis", level.end_game_string_index["fail"]);
    else
      kick(player getentitynumber(), "EXE/PLAYERKICKED_INACTIVE");
  }
}

check_for_move_change() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("done_inactivity_check");

  while(!isDefined(self.model))
    wait 0.1;

  forward = 1;
  _id_E35FE7E5DCDE5F75 = forward;
  _id_E2EA1C206287E216 = forward;

  for(;;) {
    _id_DDB1A7C10DD388CC = self getnormalizedmovement();
    _id_E35FE7E5DCDE5F75 = get_move_direction_from_vectors(_id_DDB1A7C10DD388CC);

    if(_id_E2EA1C206287E216 != _id_E35FE7E5DCDE5F75) {
      _id_E2EA1C206287E216 = _id_E35FE7E5DCDE5F75;
      self notify("inputReceived");
    }

    wait 0.1;
  }
}

get_move_direction_from_vectors(_id_ECCBCEB6C0EB084B) {
  forward = 1;
  _id_41EF0825D377E717 = 2;
  _id_A85F14C2589F9C2A = 3;
  back = 4;
  back_right = 5;
  back_left = 6;
  right = 7;
  left = 8;
  _id_33A31B037E06CAAF = forward;

  if(_id_ECCBCEB6C0EB084B[0] > 0) {
    if(_id_ECCBCEB6C0EB084B[1] <= 0.7 && _id_ECCBCEB6C0EB084B[1] >= -0.7)
      _id_33A31B037E06CAAF = forward;

    if(_id_ECCBCEB6C0EB084B[0] > 0.5 && _id_ECCBCEB6C0EB084B[1] > 0.7)
      _id_33A31B037E06CAAF = _id_41EF0825D377E717;
    else if(_id_ECCBCEB6C0EB084B[0] > 0.5 && _id_ECCBCEB6C0EB084B[1] < -0.7)
      _id_33A31B037E06CAAF = _id_A85F14C2589F9C2A;
  } else if(_id_ECCBCEB6C0EB084B[0] < 0) {
    if(_id_ECCBCEB6C0EB084B[1] < 0.4 && _id_ECCBCEB6C0EB084B[1] > -0.4)
      _id_33A31B037E06CAAF = back;

    if(_id_ECCBCEB6C0EB084B[0] < -0.5 && _id_ECCBCEB6C0EB084B[1] > 0.5)
      _id_33A31B037E06CAAF = back_right;
    else if(_id_ECCBCEB6C0EB084B[0] < -0.5 && _id_ECCBCEB6C0EB084B[1] < -0.5)
      _id_33A31B037E06CAAF = back_left;
  } else if(_id_ECCBCEB6C0EB084B[1] > 0.4)
    _id_33A31B037E06CAAF = right;
  else if(_id_ECCBCEB6C0EB084B[1] < -0.4)
    _id_33A31B037E06CAAF = left;

  return _id_33A31B037E06CAAF;
}

last_stand_hud_update() {
  self setclientomnvar("zm_player_health", 0);
}

enable_dogtag_revive(downed_player) {
  _id_BBDCC7365DD1C6BA = downed_player.origin;

  if(scripts\cp\cp_outofbounds::isoob(downed_player, 0))
    _id_BBDCC7365DD1C6BA = downed_player._id_80F9D0AEAA47CC0C.origin;

  dogtag = spawn("script_model", _id_BBDCC7365DD1C6BA + (0, 0, 40));
  dogtag setModel("military_dogtags_iw9_blue");
  dogtag makeusable();
  dogtag scriptmodelplayanim("mp_dogtag_spin");
  dogtag setHintString(&"COOP_GAME_PLAY/REVIVE_USE");
  dogtag endon("death");
  downed_player.respawn_forcespawnorigin = _id_BBDCC7365DD1C6BA;
  downed_player.respawn_forcespawnangles = (0, 0, 0);
  downed_player.dogtag = dogtag;
  downed_player.dogtag.owner = downed_player;
  downed_player _id_0AFB7E332AEE4BF2::addoverheadicon();
  dogtag thread _id_0AFB7E332AEE4BF2::revivetriggerthink(downed_player.team);
  dogtag thread endreviveonownerdeathordisconnect();
  level notify("laststand_dogtag_spawned", dogtag);
}

revivetriggerthink(downed_player) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("instant_revive");
  downed_player endon("instant_revive");
  _id_A268CB99479F185D = 8000;

  for(;;) {
    _id_A268CB99479F185D = 8000;
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(player scripts\cp\utility::_hasperk("specialty_quick_revive"))
      _id_A268CB99479F185D = level.fast_revive_time;

    self.bplayerrevivingteammate = 1;
    _id_0AFB7E332AEE4BF2::set_revive_icon_color(self, (0.0117, 0.9882, 0.9882), 1);
    result = scripts\cp\utility::player_lua_progressbar(player, _id_A268CB99479F185D, 9216, 5);
    _id_0AFB7E332AEE4BF2::set_revive_icon_color(self, (1, 0, 0), 1);
    self.bplayerrevivingteammate = undefined;

    if(!result) {
      continue;
    }
    break;
  }

  downed_player _id_0AFB7E332AEE4BF2::instant_revive(downed_player);
  downed_player notify("last_stand_finished");
}

endreviveonownerdeathordisconnect() {
  self endon("disconnect");
  self endon("death");
  self.owner scripts\engine\utility::waittill_any_2("disconnect", "last_stand_finished");
  self.owner = undefined;
  self delete();
}

checkpoint_revive() {
  level endon("game_ended");
  checkpoint = 1;

  for(;;) {
    level waittill("checkpoint_revive");
    _id_9522874AB2BF9C33 = scripts\engine\utility::getStructArray("player_checkpoint_" + checkpoint, "targetname");

    foreach(_id_AC0E594AC96AA3A8, player in level.players) {
      if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
        player.respawn_forcespawnorigin = _id_9522874AB2BF9C33[_id_AC0E594AC96AA3A8].origin;
        player.respawn_forcespawnangles = _id_9522874AB2BF9C33[_id_AC0E594AC96AA3A8].angles;
        player _id_0AFB7E332AEE4BF2::instant_revive(player);

        if(isDefined(player.dogtag))
          player.dogtag delete();
      }
    }

    checkpoint++;
  }
}

give_skillpoints_at_start() {
  self endon("disconnect");
  self waittill("loadout_given");

  if(!isDefined(self.starting_skillpoints_given))
    self.starting_skillpoints_given = 1;
}

_id_3E1F4659860B35D9() {
  self endon("disconnect");
  scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");

  if(isDefined(level._id_599B1DAA7D61C567))
    [[level._id_599B1DAA7D61C567]](self);

  if(!isDefined(self._id_CC352A8B3FA7B683)) {
    starting_currency = get_starting_currency(self);
    wait 3;

    if(starting_currency > 0)
      thread _id_66122A002AFF5D57::playerplunderpickup(starting_currency);

    set_player_max_currency(999999);
    self._id_CC352A8B3FA7B683 = 1;
  }
}

getspawnpoint() {
  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  _id_267CC90C53834B52 = scripts\engine\utility::getStructArray("default_player_start", "targetname");

  if(isDefined(level.default_player_spawns)) {
    _id_0F0700E8B95517CB = scripts\engine\utility::getStructArray(level.default_player_spawns, "targetname");

    if(_id_0F0700E8B95517CB.size > 0)
      _id_267CC90C53834B52 = _id_0F0700E8B95517CB;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player_spawn", "getPlayerSpawnPointOverride")) {
    _id_EA847593E957F2B0 = scripts\cp_mp\utility\script_utility::getsharedfunc("player_spawn", "getPlayerSpawnPointOverride");
    return [[_id_EA847593E957F2B0]](_id_267CC90C53834B52);
  }

  return getassignedspawnpoint(_id_267CC90C53834B52);
}

getassignedspawnpoint(spawnpoints) {
  _id_556E8724DC4D8291 = self getentitynumber();

  if(positionwouldtelefrag(spawnpoints[_id_556E8724DC4D8291].origin)) {
    foreach(spawnpoint in spawnpoints) {
      if(positionwouldtelefrag(spawnpoint.origin)) {
        continue;
      }
      return spawnpoint;
    }
  }

  return spawnpoints[_id_556E8724DC4D8291];
}

enable_lbravo_player_infil() {
  if(getdvarint("dvar_C55DC89EF275CDAA", 0) == 1) {
    return;
  }
  if(!scripts\cp\utility::_id_A3577E8E6C88A56B()) {
    if(player_infil_already_played())
      return;
  }

  level._id_EFE609BCE901CAA8 = 1;
  level.strike_player_connect_black_screen_fn = ::lbravo_infil_spawn_blackscreen_func;
  level thread delay_init_infil();
}

player_infil_already_played() {
  return istrue(game["player_infil_already_played"]);
}

delay_init_infil() {
  level endon("game_ended");
  _id_C36DC418FD5A866C = 1;
  wait(_id_C36DC418FD5A866C);
  level thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("alpha");
  level waittill("players_unloaded_from_infil");
  game["player_infil_already_played"] = 1;
}

_id_7ABFF7F9FA613FA2(player) {
  player setclientomnvar("ui_hide_hud", 0);
  player setclientomnvar("ui_hide_hud", 0);
  player show_introscreen_text();
  wait 6;
  player setclientomnvar("ui_hide_hud", 1);
  player setclientomnvar("ui_chyron_on", 0);
  player setclientomnvar("ui_chyron_mission_index", 0);
  _id_116171939929AF39::refreshuimatchinprogressomnvarvalue();
}

update_laststand_times() {
  _id_0AFB7E332AEE4BF2::init_laststand_anims();
  inanim = level.scr_anim["ls_revive_helper"]["in_stand_1"];
  idleanim = level.scr_anim["ls_revive_helper"]["idle_stand_1"];
  _id_548EA94669718E62 = level.scr_anim["ls_revive_helper"]["out_stand_1"];
  _id_F05037A2663B00D9 = getanimlength(inanim);
  _id_2385B76CF2542716 = getanimlength(idleanim);
  _id_0DCD276B4FDA552A = getanimlength(_id_548EA94669718E62);
  _id_750C94BA41F40A47 = 0.5;
  normal_revive_time = (_id_F05037A2663B00D9 + _id_2385B76CF2542716 + _id_0DCD276B4FDA552A + _id_750C94BA41F40A47) * 1000;
  spectator_revive_time = 5000;
  fast_revive_time = (_id_F05037A2663B00D9 + _id_0DCD276B4FDA552A + _id_750C94BA41F40A47) * 1000;
  _id_0AFB7E332AEE4BF2::set_revive_time(normal_revive_time, spectator_revive_time, fast_revive_time);
}

ascendermsgfunc(_id_E94B62032A5AE9C3, time) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\cp\utility::hint_prompt(_id_E94B62032A5AE9C3, 1);
  wait(time);
  scripts\cp\utility::hint_prompt(_id_E94B62032A5AE9C3, 0);
}

_id_E4A796F1B77914AC(player) {
  return 0;
}

getgametypenumlives() {
  return 1;
}

isdevelopmentspawningofbotclient(_id_2C6CA80E296FED3A) {
  return 0;
}

gamehasstarted() {
  if(isDefined(level.gamehasstarted))
    return level.gamehasstarted;

  foreach(team in level.teamnamelist) {
    if(scripts\cp\cp_outline_utility::getteamdata(team, "hasSpawned"))
      return 1;
  }

  return 0;
}

timeuntilspawn(_id_E02F2CD6C285F5D1) {
  if(level.ingraceperiod && !self.hasspawned || level.gameended)
    return 0;

  respawndelay = 0;

  if(self.hasspawned) {
    if(isDefined(level.onrespawndelay)) {
      result = self[[level.onrespawndelay]]();

      if(isDefined(result))
        respawndelay = result;
      else
        respawndelay = getdvarfloat(_func_2EF675C13CA1C4AF("scr_", scripts\cp\utility::getgametype(), "_playerrespawndelay"));
    } else
      respawndelay = getdvarfloat(_func_2EF675C13CA1C4AF("scr_", scripts\cp\utility::getgametype(), "_playerrespawndelay"));

    if(isDefined(self.suicidespawndelay))
      respawndelay = respawndelay + getdvarfloat(_func_2EF675C13CA1C4AF("scr_", scripts\cp\utility::getgametype(), "_suicidespawndelay"));

    if(isDefined(self.respawntimerstarttime) && !isDefined(level.spawndelay)) {
      _id_4B0EB3DD662207F4 = (gettime() - self.respawntimerstarttime) / 1000.0;
      respawndelay = respawndelay - _id_4B0EB3DD662207F4;

      if(respawndelay < 0)
        respawndelay = 0;
    }

    if(isDefined(self.setspawnpoint))
      respawndelay = respawndelay + level.tispawndelay;
  }

  _id_3E1DEAE4CD178CFB = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\cp\utility::getgametype(), "_waverespawndelay")) > 0;

  if(level.ingraceperiod && !self.hasspawned || level.gameended)
    respawndelay = 0;
  else if(getdvarint("dvar_4AC8D16CE8DD74FD", 0) == 1)
    respawndelay = 999.0;

  if(!isDefined(self._id_DB03AE1B2B480308))
    self._id_DB03AE1B2B480308 = respawndelay;

  return respawndelay;
}

playerkilled_spawn(_id_642470E1ABC1BBF9) {
  if(isDefined(level.modeplayerkilledspawn) && [[level.modeplayerkilledspawn]](_id_642470E1ABC1BBF9)) {
    return;
  }
  victim = _id_642470E1ABC1BBF9.victim;
  victim endon("spawned");
  victim endon("disconnect");
  attacker = _id_642470E1ABC1BBF9.attacker;
  victim resetplayervariables();
  victim resetplayeromnvarsonspawn();

  if(isDefined(attacker))
    victim.lastattacker = attacker;
  else
    victim.lastattacker = undefined;

  victim.wantsafespawn = 0;

  if(game["state"] != "playing") {
    if(!level.showingfinalkillcam)
      victim scripts\cp\utility::updatesessionstate("dead");

    return;
  }

  victim waittill("last_stand_finished");
  victim thread _id_116171939929AF39::spawnplayer(undefined, 1);
}

resetplayervariables() {
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  self.inlaststand = 0;
  self.pers["cur_kill_streak"] = 0;
  self.killcountthislife = 0;
  detachusemodels();
}

detachusemodels() {
  if(isDefined(self.attachedusemodel)) {
    self detach(self.attachedusemodel, "tag_inhand");
    self.attachedusemodel = undefined;
  }
}

resetplayeromnvarsonspawn() {
  resetuiomnvarscommon();
  self setclientomnvar("ui_life_kill_count", 0);
  self setclientomnvar("ui_shrapnel_overlay", 0);
}

resetuiomnvarscommon() {
  if(isDefined(level.resetuiomnvargamemode))
    [[level.resetuiomnvargamemode]]();

  self setclientomnvar("ui_objective_pinned_text_param", 0);
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_reviver_id", -1);
  self setclientomnvar("ui_edge_glow", 0);
  self setclientomnvar("ui_life_kill_count", 0);
  self setclientomnvar("ui_is_laststand", 0);
}

_id_52343D5C1B190CF0() {
  level._id_12226443217B5474 = getdvarint("dvar_127490A7577F169F", 0);

  if(!istrue(level._id_12226443217B5474)) {
    return;
  }
  level._id_EE05489A095DF4D1 = getdvarint("dvar_509B01D1370107AF", 0) == 1;
  level._id_11D8636343EAE20C = getdvarint("dvar_E05A6970966D8552", 0);
  level._id_0ACCB27010DAA82D = getdvarint("dvar_4A592B7D1EFA862D", 0);
  level._id_1921CB8DD51A8F73 = getdvarint("dvar_4C748C9425636394", 1);
  level._id_A80E6D45222F9A47 = 0;
  level._id_F63478BCA59E2670 = getdvarint("dvar_3B76545D82D3FD12", 4);
  level.testrandomrealismclients = getdvarint("dvar_596700A25033A832", 0) == 1;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    level.healthregendisabled = 1;

  setomnvar("ui_realism_mode", scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924());

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()) {
    level.modifyplayerdamage = _id_25845ACA699D038D::gamemodemodifyplayerdamage;
    setDvar("jump_slowdownenable", 1);
    setDvar("sprintleap_enabled", 0);
    level._id_57ECE26E490AD8C4 = 1;

    if(istrue(level._id_1921CB8DD51A8F73)) {
      level._id_26109C02A53CEA84 = [];
      level._id_26109C02A53CEA84["rocketlauncher"] = getdvarfloat("dvar_02B6CEEF99F7C775", 0.75);
      level._id_26109C02A53CEA84["sniper"] = getdvarfloat("dvar_02B2AAEF99F38272", 0.8);
      level._id_26109C02A53CEA84["mg"] = getdvarfloat("dvar_0263C3EF999D0B4F", 0.85);
      level._id_26109C02A53CEA84["rifle"] = getdvarfloat("dvar_0274C6EF99AF1C44", 0.9);
      level._id_26109C02A53CEA84["smg"] = getdvarfloat("dvar_02B2A9EF99F3803F", 0.95);
      level._id_26109C02A53CEA84["spread"] = getdvarfloat("dvar_02B2B3EF99F3963D", 0.95);
      level._id_26109C02A53CEA84["grenade"] = getdvarfloat("dvar_027DB6EF99B917C2", 1.0);
      level._id_26109C02A53CEA84["melee"] = getdvarfloat("dvar_0263C5EF999D0FB5", 1.0);
      level._id_26109C02A53CEA84["pistol"] = getdvarfloat("dvar_02BFA5EF9A018BF8", 1.0);
    }

    if(!isusingmatchrulesdata()) {
      setDvar("scr_game_enableMinimap", 0);
      setDvar("scr_player_maxhealth", 30);
      setDvar("scr_player_healthregentime", 0);
      setDvar("scr_team_fftype", 4);
      setDvar("scr_game_allowkillcam", 0);
      setDvar("dvar_A4D532F42D919827", 0);
      setDvar("dvar_D75D5638785F3B09", 0);
      setDvar("dvar_08AD1AB9436BCCCA", 0);
      setDvar("dvar_28D450F7F28644B7", 0);
      setDvar("dvar_8A1945C94D5092C2", 0);
    }

    _id_14609B809484646E::_id_8ECE37593311858A(::_id_3708850EAB3864C2);
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_3708850EAB3864C2);
  }
}

_id_3708850EAB3864C2() {
  if(istrue(level.testrandomrealismclients)) {
    if(!isDefined(self.isrealismenabled)) {
      if(scripts\engine\utility::cointoss()) {
        self setclientomnvar("ui_realism_hud", 1);
        self.isrealismenabled = 1;
      } else {
        self setclientomnvar("ui_realism_hud", 0);
        self.isrealismenabled = 0;
      }
    }
  } else
    self setclientomnvar("ui_realism_hud", scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924());
}

_id_7BAC8EE72285298E() {
  _id_76A22C18960F72AF = self.origin;
  startpos = _id_76A22C18960F72AF + (0, 0, 14);
  stance = self getstance();
  zoffset = 35;

  if(stance == "prone")
    zoffset = 14;

  if(stance == "crouch")
    zoffset = 25;

  _id_9C19496CE8106E6B = _id_76A22C18960F72AF + (0, 0, zoffset);
  randomangle = (0, randomfloat(360), 0);
  _id_A76189155F382805 = anglesToForward(randomangle);
  _id_A73587155F07BD39 = randomfloatrange(30, 150);
  _id_90128D0639A1315D = startpos + _id_A73587155F07BD39 * _id_A76189155F382805;
  _id_B809B8F732448A84 = playerphysicstrace(startpos, _id_90128D0639A1315D);

  if(!isDefined(self._id_A25375A5AB23EACB)) {
    visuals = [];
    visuals[0] = spawn("script_model", _id_9C19496CE8106E6B);
    visuals[0] setModel("equipment_scavenger_bag");
    trigger = spawn("trigger_radius", _id_9C19496CE8106E6B, 0, 32, 32);
    pickup = _id_029458C0B233BE34::createuseobject("neutral", trigger, visuals, undefined, undefined, 1);
    pickup.onuse = ::_id_75C517D33CD52B54;
    pickup.usetime = 0;
    pickup _id_029458C0B233BE34::_id_58281AC4DA450DED("any");
    pickup.owner = self;
    self._id_A25375A5AB23EACB = pickup;
    self._id_A25375A5AB23EACB thread monitordisconnect();
  } else {
    self._id_A25375A5AB23EACB.curorigin = _id_9C19496CE8106E6B;
    self._id_A25375A5AB23EACB.visuals[0].origin = _id_9C19496CE8106E6B;
    self._id_A25375A5AB23EACB.trigger.origin = _id_9C19496CE8106E6B;
  }

  self._id_A25375A5AB23EACB thread _id_5C5358EF41543DA6(_id_9C19496CE8106E6B, _id_B809B8F732448A84);

  if(level._id_0ACCB27010DAA82D > 0)
    self._id_A25375A5AB23EACB thread monitortimeout();
}

_id_5C5358EF41543DA6(startpos, endpos) {
  self endon("death");
  _id_C9DFC53C7CC5876A = (endpos - startpos) * 25;
  self.visuals[0] physicslaunchserver(self.visuals[0].origin, _id_C9DFC53C7CC5876A);
  wait 1.0;

  if(isDefined(self.trigger) && isDefined(self.visuals[0])) {
    self.trigger.origin = self.visuals[0].origin;
    self.curorigin = self.visuals[0].origin;
    self.visuals[0] physicsstopserver();
  }
}

_id_75C517D33CD52B54(player, team) {
  if(player.health == player.maxhealth) {
    return;
  }
  player playsoundtoplayer("br_pickup_generic", player);
  player thread _id_427B6F3ADC1B7A7D();

  if(level._id_EE05489A095DF4D1) {
    if(level._id_11D8636343EAE20C == 0)
      player.health = player.maxhealth;
    else
      player.health = min(player.health + level._id_11D8636343EAE20C, player.maxhealth);
  } else
    player notify("force_regeneration");

  _id_5DC0C80460E6C6BB();
}

_id_427B6F3ADC1B7A7D() {
  self endon("death_or_disconnect");
  self lerpfovbypreset("zombiedefault");
  wait 0.5;
  self lerpfovbypreset("default_2seconds");
}

monitordisconnect() {
  self waittill("disconnect");
  _id_5DC0C80460E6C6BB();
}

monitortimeout() {
  self endon("death");
  self notify("monitorTimeOut");
  self endon("monitorTimeOut");
  wait(level._id_0ACCB27010DAA82D);
  _id_5DC0C80460E6C6BB();
}

_id_5DC0C80460E6C6BB() {
  if(isDefined(self.owner))
    self.owner._id_A25375A5AB23EACB = undefined;

  self.visuals[0] delete();
  deleteuseobject();
}

releaseid(_id_321E7A51D3237066, _id_301EC764DD09B364) {
  if(istrue(_id_321E7A51D3237066))
    scripts\mp\objidpoolmanager::returnreservedobjectiveid(self.objidnum, _id_301EC764DD09B364);
  else
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnum);

  self.objidnum = -1;
}

deleteuseobject() {
  releaseid();
  self.trigger delete();
  self.trigger = undefined;
  self notify("deleted");
}

_id_E68FDD067463CAB4() {
  level._id_3CE2DE189EFF819B = 0;
  level._id_39F8811038B028E3 = _id_F44EE02F4FB6F8B3();
  level._id_9649FC22A9587E59 = "cp_igc_cine_intro";
  level._id_78B8EF682953FEA0 = getdvarint("dvar_E951E68CF79A6FA3", 1);
  level._id_ED5707896C1F5275 = getdvarint("dvar_A89846E9402CAFDC", 1);
  votesys_init();
  scripts\engine\utility::flag_init("both_players_intro_binks_complete");
  scripts\engine\utility::flag_init("intro_binks_complete");
  level._id_F897D54E1C59990C = [];
  level._id_AAA051A8D17A5425[level._id_9649FC22A9587E59] = [];
  level._id_AAA051A8D17A5425[level._id_39F8811038B028E3] = [];
  thread _id_B257DC057B65BA40();
}

_id_F44EE02F4FB6F8B3() {
  switch (level.script) {
    case "cp_raid1":
      return "cp_raid1_cine_intro";
    case "cp_raid1_trap":
      return "cp_raid2_cine_intro";
    case "cp_raid1_boss1":
      return "cp_raid3_cine_intro";
    case "cp_jugg_maze":
      return "cp_raid4_cine_intro";
    case "cp_hydro":
      return "cp_bads_cine_intro";
    case "cp_mission_esc":
      if(_id_54F6F9D73EB5378C())
        return "cp_heliesc_cine_intro";
      else
        return "cp_vehesc_cine_intro";
    case "cp_observatory":
      return "cp_obsv_cine_intro";
    case "cp_lone":
      return "cp_lone_cine_intro";
  }

  return "mp_nukesequence_daytime";
}

_id_D9C12C0427276BBD(_id_4F105563CA74CF73) {
  if(!isDefined(_id_4F105563CA74CF73)) {
    return;
  }
  self preloadcinematicforplayer(_id_4F105563CA74CF73);
}

_id_89AD5EA43ADD9DA8(_id_4F105563CA74CF73) {
  if(!isDefined(_id_4F105563CA74CF73)) {
    return;
  }
  self setplayermusicstate("");
  self playcinematicforplayer(_id_4F105563CA74CF73);
  self setclientomnvar("ui_cp_bink_overlay_state", 3);
}

_id_54F6F9D73EB5378C() {
  if(isDefined(level._id_05F694EFAFEB95D7))
    return level._id_05F694EFAFEB95D7;

  _id_CB385B838E10F79E = getDvar("start");

  if(!isDefined(_id_CB385B838E10F79E) || _id_CB385B838E10F79E == "") {
    checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();
    _id_156EE1DE40D62A30 = ["checkpoint_monument", "checkpoint_house", "checkpoint_heli_mid", "checkpoint_gasstation", "checkpoint_blueroof", "checkpoint_culdesac"];
    level._id_05F694EFAFEB95D7 = scripts\engine\utility::array_contains(_id_156EE1DE40D62A30, checkpoint);
    return scripts\engine\utility::array_contains(_id_156EE1DE40D62A30, checkpoint);
  }

  _id_682644DBD89854FD = ["support_heli_monument", "support_heli_house", "support_heli_mid", "support_heli_gasstaation", "support_heli_blueroof", "support_heli_culdesac", "support_heli_escape", "support_heli_profile"];
  level._id_05F694EFAFEB95D7 = scripts\engine\utility::array_contains(_id_682644DBD89854FD, _id_CB385B838E10F79E);
  return scripts\engine\utility::array_contains(_id_682644DBD89854FD, _id_CB385B838E10F79E);
}

_id_20C2A39E2AED32AA() {
  return 666;
}

_id_B257DC057B65BA40() {
  if(getdvarint("dvar_03BBBED1090811C4", 0) != 0) {
    return;
  }
  level._id_A37A759E3BE7F4CE = 1;

  if(isDefined(level._id_A8EE6FCD872EA434))
    thread[[level._id_A8EE6FCD872EA434]]();

  scripts\engine\utility::flag_wait("intro_binks_complete");

  foreach(player in level.players) {
    if(player scripts\engine\utility::ent_flag("intro_binks_complete"))
      player thread _id_4A89B0747EF8CBAE();
  }

  if(isDefined(level._id_4C0339FDED885183))
    thread[[level._id_4C0339FDED885183]]();

  _id_6751C6B4700086BA();
  level._id_A37A759E3BE7F4CE = undefined;
  _id_08FA94C0CECE0E08();
}

_id_4A89B0747EF8CBAE() {
  self notify("binks_showBriefingHint");
  self endon("binks_showBriefingHint");
  self endon("disconnect");
  level endon("game_ended");
  thread _id_E52DFC61E590258D();
}

_id_E52DFC61E590258D() {
  self endon("disconnect");
  self notify("binks_showBriefingHint");
  self endon("binks_showBriefingHint");
  self._id_97C3058D5E4880EB = 1;

  if(scripts\cp\utility::_id_138028CA2B958511())
    self sethudtutorialmessage(&"COOP_GAME_PLAY/WAITING_FOR_TEAMMATE_CINEMATIC_RAID", 1);
  else
    self sethudtutorialmessage(&"COOP_GAME_PLAY/WAITING_FOR_TEAMMATE_BINK", 1);

  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  self clearhudtutorialmessage();
  self._id_97C3058D5E4880EB = undefined;
}

_id_6751C6B4700086BA() {
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");

  if(isDefined(level._id_79ED5BB784E23EC9))
    thread[[level._id_79ED5BB784E23EC9]]();
}

_id_C6BCA49503D623EB() {
  if(istrue(game["has_seen_binks"]))
    return 0;

  switch (level.script) {
    case "cp_raid1":
      return 1;
    case "cp_raid1_trap":
      return 1;
    case "cp_raid1_boss1":
      return 1;
    case "cp_jugg_maze":
      return 1;
    case "cp_ai_tests":
    case "cp_lone":
    case "cp_mission_esc":
    case "cp_hydro":
    case "cp_observatory":
      _id_6AEC809BE13C61CC = 0;
      _id_79B0DEAB13945AED = _id_0998572FF3C96EE5::_id_399CCFE790A8B2EB();

      if(isDefined(_id_79B0DEAB13945AED) && _id_79B0DEAB13945AED != "")
        _id_6AEC809BE13C61CC = self getplayerdata("cp", "hasSeenBinks", _id_79B0DEAB13945AED, "hasSeenBinksForMission", "hasSeenBink");

      if(_id_6AEC809BE13C61CC != 0)
        return 0;

      return _id_9CBA61715CD37182();
    default:
      return 0;
  }
}

_id_9CBA61715CD37182() {
  if(getdvarint("dvar_75CC47D2BB324F3A", 1)) {
    _id_79B0DEAB13945AED = _id_0998572FF3C96EE5::_id_399CCFE790A8B2EB();

    if(isDefined(_id_79B0DEAB13945AED) && _id_79B0DEAB13945AED != "") {
      _id_6AEC809BE13C61CC = self getplayerdata("cp", "hasSeenBinks", _id_79B0DEAB13945AED, "hasSeenBinksForMission", "hasSkippedCounter");
      _id_AF359AFB5D35D981 = getdvarint("dvar_F74155737D8C6C8B", 3);

      if(scripts\cp\utility::_id_138028CA2B958511())
        _id_AF359AFB5D35D981 = 1;

      if(_id_6AEC809BE13C61CC >= _id_AF359AFB5D35D981)
        return 0;
      else
        return 1;
    }
  }

  return 1;
}

_id_438D425FF6F1787E() {
  if(istrue(game["has_seen_binks"]))
    return 0;

  switch (level.script) {
    case "cp_lone":
    case "cp_mission_esc":
    case "cp_hydro":
    case "cp_observatory":
      return !self getplayerdata("cp", "hasSeenLaswellBink");
    default:
      return 0;
  }
}

_id_FC042664E4918BA0() {
  level endon("both_players_intro_binks_complete");
  self waittill("disconnect");

  if(scripts\engine\utility::array_contains(level._id_F897D54E1C59990C, self))
    level._id_F897D54E1C59990C = scripts\engine\utility::array_remove(level._id_F897D54E1C59990C, self);

  if(scripts\engine\utility::flag("intro_binks_complete")) {
    while(level._id_F897D54E1C59990C.size > 0)
      waitframe();

    scripts\engine\utility::flag_set("both_players_intro_binks_complete");
  }
}

_id_2957797B844CB941() {
  self endon("disconnect");
  level endon("game_ended");

  if(getdvarint("dvar_E15D9836CD3C3360", 0) == 0 || scripts\cp\utility::_id_138028CA2B958511()) {
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0);
    scripts\engine\utility::flag_wait("safe_to_start_binks_now");
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0);
  }

  self enableweapons();
  self setclienttriggeraudiozone("cp_bink");
  self setclientomnvar("ui_hide_bigmap", 1);
  self setclientomnvar("ui_show_tac_map", 0);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("gameEndFreeze", ["usability", "ads", "fire", "weapon_switch", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "allow_jump", "sprint", "crouch", "prone", "melee"]);
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("gameEndFreeze", 0);
  scripts\cp\utility::hideminimap(1);
  thread _id_FC042664E4918BA0();
  scripts\cp\utility::allow_player_ignore_me(1);
  scripts\cp\utility::_id_4CBAED764C116A25(1);
  _id_66122A002AFF5D57::_id_F0A8D592BDDE9818();
  self._id_4B668A8CB58C3B0E = 1;

  if(_id_438D425FF6F1787E()) {
    level._id_F897D54E1C59990C = scripts\engine\utility::array_add(level._id_F897D54E1C59990C, self);
    _id_B5B5CE43D03DF251 = _id_A9E24E1C37BE3B07();

    if(!istrue(_id_B5B5CE43D03DF251)) {
      self setplayerdata("cp", "hasSeenLaswellBink", 1);
      wait 2.5;
    } else
      wait 0.1;
  }

  self notify("binks_watchForPlayerSkip" + self._id_4B668A8CB58C3B0E);
  self notify("bink_playerUseButtonPressedTime" + self._id_4B668A8CB58C3B0E);
  self notify("binks_playerVoteSkipYes" + self._id_4B668A8CB58C3B0E);
  self._id_4B668A8CB58C3B0E++;

  if(_id_C6BCA49503D623EB()) {
    if(!scripts\engine\utility::array_contains(level._id_F897D54E1C59990C, self))
      level._id_F897D54E1C59990C = scripts\engine\utility::array_add(level._id_F897D54E1C59990C, self);

    _id_B5B5CE43D03DF251 = _id_C12C167D4D4AA30D();
    _id_79B0DEAB13945AED = _id_0998572FF3C96EE5::_id_399CCFE790A8B2EB();

    if(istrue(_id_B5B5CE43D03DF251)) {
      if(isDefined(_id_79B0DEAB13945AED) && _id_79B0DEAB13945AED != "") {
        if(scripts\cp\utility::_id_138028CA2B958511()) {
          _id_8B462903A1F84F9C = _id_C563A1CD8C07E2FC();

          foreach(_id_8D0ED9033CFAB106 in _id_8B462903A1F84F9C) {
            _id_6AEC809BE13C61CC = self getplayerdata("cp", "hasSeenBinks", _id_8D0ED9033CFAB106, "hasSeenBinksForMission", "hasSkippedCounter");
            self setplayerdata("cp", "hasSeenBinks", _id_8D0ED9033CFAB106, "hasSeenBinksForMission", "hasSkippedCounter", _id_6AEC809BE13C61CC + 1);
          }
        } else {
          _id_6AEC809BE13C61CC = self getplayerdata("cp", "hasSeenBinks", _id_79B0DEAB13945AED, "hasSeenBinksForMission", "hasSkippedCounter");
          self setplayerdata("cp", "hasSeenBinks", _id_79B0DEAB13945AED, "hasSeenBinksForMission", "hasSkippedCounter", _id_6AEC809BE13C61CC + 1);
        }
      }
    } else if(isDefined(_id_79B0DEAB13945AED) && _id_79B0DEAB13945AED != "") {
      if(scripts\cp\utility::_id_138028CA2B958511()) {
        _id_8B462903A1F84F9C = _id_C563A1CD8C07E2FC();

        foreach(_id_8D0ED9033CFAB106 in _id_8B462903A1F84F9C)
        self setplayerdata("cp", "hasSeenBinks", _id_8D0ED9033CFAB106, "hasSeenBinksForMission", "hasSeenBink", 1);
      } else
        self setplayerdata("cp", "hasSeenBinks", _id_79B0DEAB13945AED, "hasSeenBinksForMission", "hasSeenBink", 1);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("binks", "binksExitFunc"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("binks", "binksExitFunc")]]();
  else
    _id_044E01D7A8010339();
}

_id_044E01D7A8010339() {
  level._id_F897D54E1C59990C = scripts\engine\utility::array_remove(level._id_F897D54E1C59990C, self);
  self._id_4B668A8CB58C3B0E = 666;
  scripts\engine\utility::ent_flag_set("intro_binks_complete");
  self setclientomnvar("ui_vote_results", 0);
  scripts\cp\utility::_id_4CBAED764C116A25(0);
  scripts\cp\utility::allow_player_ignore_me(0);
  scripts\cp\utility::freezecontrolswrapper(0);
  thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 0, 2);
  scripts\cp\utility::hideminimap(0);
  self setclientomnvar("ui_hide_hud", 0);
  self setclientomnvar("ui_hide_bigmap", 0);
  self setclientomnvar("ui_show_tac_map", 1);
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("gameEndFreeze", 1);
  _id_116171939929AF39::refreshuimatchinprogressomnvarvalue();
  self clearclienttriggeraudiozone(0);
  scripts\engine\utility::flag_set("intro_binks_complete");
  thread _id_4A89B0747EF8CBAE();

  while(level._id_F897D54E1C59990C.size > 0)
    waitframe();

  game["has_seen_binks"] = 1;
  scripts\engine\utility::flag_set("both_players_intro_binks_complete");
}

_id_A9E24E1C37BE3B07() {
  self endon("disconnect");
  _id_B5B5CE43D03DF251 = 0;
  _id_2C10AD7BD4FAEB69(level._id_9649FC22A9587E59);
  thread userskip_wait();
  result = scripts\engine\utility::waittill_any_return_2("userskipped", "intro_bink_complete_" + self._id_4B668A8CB58C3B0E);

  if(result == "userskipped") {
    _id_B5B5CE43D03DF251 = 1;
    _id_E388C4536131A087();
  }

  userskip_stop();
  _id_93C743B9EB010CC4();
  return _id_B5B5CE43D03DF251;
}

_id_C12C167D4D4AA30D() {
  self endon("disconnect");
  _id_2C10AD7BD4FAEB69(level._id_39F8811038B028E3);
  thread userskip_wait();
  result = scripts\engine\utility::waittill_any_return_2("userskipped", "intro_bink_complete_" + self._id_4B668A8CB58C3B0E);

  if(result == "userskipped") {
    if(istrue(level._id_78B8EF682953FEA0)) {
      if(_id_DC3D46C99CA3DB15()) {
        votesys_new("vote_bink_skip", _id_9AA1E8FA14FE1FFC());
        vote_player_set("vote_bink_skip", 1);
        _id_A9B8FA5C0A14AD43 = scripts\engine\utility::waittill_any_return_3("voted_skip_bink", "bink_skip_failed", "release_players_from_skipped_state");
      }
    }

    _id_E388C4536131A087();
  }

  userskip_stop();
  _id_93C743B9EB010CC4();

  if(result == "userskipped")
    return 1;
  else
    return 0;
}

_id_DC3D46C99CA3DB15() {
  if(scripts\cp\utility::_id_138028CA2B958511())
    return 1;
  else if(level.script == "cp_lone")
    return 1;
  else
    return 0;
}

_id_9CDB93A7BC82FE39() {
  _id_0B087EF2D3550558 = _id_0265A57BCD485237("vote_bink_skip");
  hintstring = &"COOP_GAME_PLAY/WAITING_FOR_TEAMMATE_BINK";

  if(isDefined(_id_0B087EF2D3550558)) {
    switch (_id_0B087EF2D3550558) {
      case 1:
        hintstring = &"COOP_GAME_PLAY/SKIP_BINK_1";
        break;
      case 2:
        hintstring = &"COOP_GAME_PLAY/SKIP_BINK_2";
        break;
      case 3:
        hintstring = &"COOP_GAME_PLAY/SKIP_BINK_3";
        break;
    }

    foreach(player in level.players)
    player sethudtutorialmessage(hintstring, 1);
  }
}

_id_9AA1E8FA14FE1FFC() {
  switch (level.script) {
    case "cp_raid1":
      return 168;
    case "cp_raid1_trap":
      return 56;
    case "cp_raid1_boss1":
      return 40;
    case "cp_jugg_maze":
      return 126;
  }

  return 90;
}

_id_0899BD4ADD25DDD3(_id_7148C1A6F25491F8, val) {
  if(_id_7148C1A6F25491F8 == "bink_complete") {
    self setclientomnvar("ui_cp_bink_overlay_state", 0);
    self stopcinematicforplayer(0);
    scripts\engine\utility::ent_flag_set("intro_bink_complete_" + self._id_4B668A8CB58C3B0E);

    foreach(player in level.players)
    player notify("release_players_from_skipped_state");
  } else if(_id_7148C1A6F25491F8 == "skip_bink_input")
    scripts\engine\utility::ent_flag_set("userskipped");
}

_id_E388C4536131A087() {
  self setclientomnvar("ui_cp_bink_overlay_state", 0);
  self stopcinematicforplayer(1);
  scripts\engine\utility::ent_flag_set("intro_bink_complete_" + self._id_4B668A8CB58C3B0E);
}

_id_2C10AD7BD4FAEB69(_id_4F105563CA74CF73) {
  self endon("disconnect");

  if(!isDefined(_id_4F105563CA74CF73))
    _id_4F105563CA74CF73 = _id_F44EE02F4FB6F8B3();

  self._id_52D4CFB878CEDD94 = 1;
  _id_89AD5EA43ADD9DA8(_id_4F105563CA74CF73);
}

_id_93C743B9EB010CC4() {
  self._id_52D4CFB878CEDD94 = undefined;
}

_id_320A9A5B90FDD2D8(_id_976CD00F06AF538C, player) {
  level._id_AAA051A8D17A5425[_id_976CD00F06AF538C] = scripts\engine\utility::array_remove(level._id_AAA051A8D17A5425[_id_976CD00F06AF538C], player);
}

_id_B934A33991DCF12E(_id_976CD00F06AF538C) {
  self notify("binks_playerVoteClearOnDeath");
  self endon("binks_playerVoteClearOnDeath");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_2("last_stand", "death");
  _id_320A9A5B90FDD2D8(_id_976CD00F06AF538C, self);
  self setclientomnvar("ui_vote_type", 0);
}

_id_08FA94C0CECE0E08() {
  level.missionstarttime = gettime();
}

userskip_wait() {
  self endon("disconnect");
  _id_B57418FDE4F91E90 = "userskipped";
  _id_5A5437BAB7D7156B = "stop_userskip";
  flags = [_id_B57418FDE4F91E90, _id_5A5437BAB7D7156B];

  foreach(flag in flags)
  scripts\engine\utility::ent_flag_clear(flag);

  self setclientomnvar("ui_is_bink_skippable", 1);

  while(!scripts\engine\utility::ent_flag(_id_5A5437BAB7D7156B) && !scripts\engine\utility::ent_flag(_id_B57418FDE4F91E90))
    waitframe();

  self setclientomnvar("ui_is_bink_skippable", 0);
  self notify("stop_userskip_input_thread");
  return scripts\engine\utility::ent_flag(_id_B57418FDE4F91E90);
}

userskip_stop() {
  scripts\engine\utility::ent_flag_set("stop_userskip");
}

_id_C563A1CD8C07E2FC() {
  if(!scripts\cp\utility::_id_138028CA2B958511())
    return [];

  switch (level.script) {
    case "cp_raid1":
      return ["Raid1", "Raid1Veteran"];
    case "cp_raid1_trap":
      return ["Raid2", "Raid2Veteran"];
    case "cp_raid1_boss1":
      return ["Raid3", "Raid3Veteran"];
    case "cp_jugg_maze":
      return ["Raid4", "Raid4Veteran"];
    case "cp_raid1test":
      return ["Raid5", "Raid5Veteran"];
  }

  return [];
}

vote_player_init() {
  if(!isDefined(self.votes))
    self.votes = [];
}

vote_player_reset(type) {
  vote_player_init();
  self.votes[type] = undefined;
}

vote_player_set(type, val) {
  if(isDefined(self.votes[type])) {
    return;
  }
  self.votes[type] = val;
}

votesys_init() {
  level.voting = [];
}

votesys_new(type, duration, _id_756E935DDDEF03CF) {
  if(isDefined(level.voting[type])) {
    return;
  }
  foreach(player in level.players)
  player vote_player_reset(type);

  level.voting[type] = 1;
  level thread votesys_think(type, duration, _id_756E935DDDEF03CF);
}

votesys_think(type, duration, _id_756E935DDDEF03CF) {
  success = 0;
  endtime = gettime() + duration * 1000;
  _id_B42A658AF40E53BE = -1;
  _id_B1EA6E95CD5257DD = -1;
  _id_D12A341B40354143 = -1;
  waitframe();

  while(gettime() < endtime) {
    if(level.gameended) {
      success = 0;
      break;
    }

    _id_0F1A9809EED7E8F0 = int((endtime - gettime()) * 0.001);

    if(_id_0F1A9809EED7E8F0 != _id_B1EA6E95CD5257DD) {
      _id_B1EA6E95CD5257DD = _id_0F1A9809EED7E8F0;
      votesys_update_time(_id_0F1A9809EED7E8F0);
    }

    foreach(player in level.players) {
      if(!isDefined(player.votes))
        player vote_player_reset(type);
    }

    count = 0;

    foreach(player in level.players) {
      if(!isDefined(player.votes))
        player vote_player_reset(type);

      if(istrue(player.votes[type]))
        count++;
    }

    if(count != _id_B42A658AF40E53BE || _id_D12A341B40354143 != level.players.size + 1) {
      _id_B42A658AF40E53BE = count;
      _id_D12A341B40354143 = level.players.size;
      votesys_update_playercount(count, _id_D12A341B40354143);
    }

    if(count == level.players.size || level._id_F897D54E1C59990C.size == 0) {
      success = 1;
      break;
    }

    waitframe();
  }

  if(level.gameended)
    success = 0;

  level.voting[type] = undefined;
  votesys_update_time(0);
  votesys_update_playercount(0, 0);

  foreach(player in level.players)
  player vote_player_reset(type);

  if(success) {
    foreach(player in level.players)
    player scripts\engine\utility::ent_flag_set("voted_skip_bink");
  } else {
    foreach(player in level.players)
    player scripts\engine\utility::ent_flag_set("bink_skip_failed");
  }
}

votesys_update_time(time) {
  setomnvar("ui_votesys_time", time);
}

votesys_update_playercount(_id_0B087EF2D3550558, _id_D12A341B40354143) {
  setomnvar("ui_votesys_playervotes", _id_0B087EF2D3550558);
  setomnvar("ui_votesys_playercount", _id_D12A341B40354143);
}

_id_0265A57BCD485237(type) {
  count = 0;

  foreach(player in level.players) {
    if(!isDefined(player.votes))
      player vote_player_reset(type);

    if(istrue(player.votes[type]))
      count++;
  }

  return count;
}