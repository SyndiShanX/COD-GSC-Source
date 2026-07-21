/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\gametypes\cp_wave_sv.gsc
***********************************************/

main() {
  scripts\cp\cp_globallogic::init();
  level thread onplayerconnect();
  level.skip_playerhudphoto = 1;
  level.disable_nvg = 1;
  scripts\cp\cp_music_and_dialog::init();
  scripts\cp\survival\survival_loadout::init();
  scripts\cp\utility::coop_mode_enable(["_encstr_9A150C1BBDF647BE6EBCB9A3CAB6"]);
  initdefaultsettings();
  scripts\cp\cp_weapon::weaponsinit();
  level.health_scalar = 1.5;
  scripts\cp\cp_outline::outline_init();
  level.playerent = scripts\cp\cp_weapon::bomber_spawn_origin_array_init;
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  setomnvar("_encstr_877723D5D2BE0D2DC82B7D9B85B659381B583ACA9BAFCCF6937DD3AC39DEEB34CA5836A334", 0);
  level scripts\cp\cp_hud_message::init_cp_hud_message();
  level thread scripts\cp\loot_system::init_loot();
  level thread scripts\cp\cp_interaction::coop_interaction_pregame();
  level thread scripts\cp\utility::global_physics_sound_monitor();
  level thread scripts\cp\zombies\zombieclientmatchdata::init();
  level thread monitor_num_players();
  level.use_temp_bc = 1;
  create_player_threatbias_groups();

  if(scripts\cp\pvpe\pvpe::pvpe_enabled())
    scripts\cp\pvpe\pvpe::init_pvpe();
  else if(scripts\cp\pvpve\pvpve::pvpve_enabled())
    scripts\cp\pvpve\pvpve::init_pvpve();
}

create_player_threatbias_groups() {
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
  level.cycle_reward_scalar = 1;
  level.cash_scalar = 1;
  level.powers = [];
  level.overcook_func = [];
  level.hardcoremode = getdvarint("_encstr_A6D3149BB19C7D2C63A5AC73CDD786164E91B17B4ECA");
  level.ricochetdamage = getdvarint("_encstr_A28C149BC69C7D85364BB2B9CDBE39B436BDC63495A3");
  level.casualmode = getdvarint("_encstr_8AF9124663CBEECB158230501BE18761971DC7B1");
  level.default_weapon = "_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B";
  setdvarifuninitialized("_encstr_B8CA1E87CDBF2A6428162AB709B0B5228D630BF7A9D5422C8818297A6188FD9A", 0);
  level.usehealthpacks = getdvarint("_encstr_B8CA1E87CDBF2A6428162AB709B0B5228D630BF7A9D5422C8818297A6188FD9A", 0);
  level.pap_max = 2;
  level.exploimpactmod = 0.1;
  level.shotgundamagemod = 0.1;
  level.armorpiercingmod = 1.5;
  level.armorpiercingmodks = 1.25;
  level.maxlogclients = 10;
  level.custom_giveloadout = ::givedefaultloadout;
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
  level.enter_spectator_func = undefined;
  level.prespawnfromspectaorfunc = ::prespawnfromspectatorfunc;
  level.laststand_exit_gamemodespecificaction = ::exit_laststand_func;
  level.last_stand_hud_update = ::last_stand_hud_update;
  level.getspawnpoint = ::getspawnpoint;
  level.update_money_performance = scripts\cp\cp_core_gamescore::update_money_earned_performance;
  level.active_volume_check = scripts\cp\utility::is_in_active_volume;
  level.endgame_write_clientmatchdata_for_player_func = ::endgame_clientmatchdata;
  level.hostmigrationend = ::hostmigrationend;
  level.onhostmigration = ::hostmigrationstart;
  setDvar("_encstr_8EB10B48F101F2EBF4BEDDDCD6", 200);
  setDvar("_encstr_B8610BC5BCB99F08E167979F37", 375);
  setDvar("_encstr_B6A30B7A9AC413984596A2D429", 200);
  setDvar("_encstr_91210B8D31359451D7313824D9", 375);
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
  setDvar("_encstr_A18B12E63693D7DD85CE95EB3A4BB6B2D7E6ACE8", -1);
  level thread init_enemy_spawner();
  thread scripts\cp\cp_traversalassist::traversal_assist_init();
  thread scripts\cp_mp\ent_manager::init();

  if(level._id_12376)
    scripts\cp\whizby::calloutmarkerping_init();

  scripts\cp\cp_persistence::mortars_get_player_targeted();
  level thread getclosestplayerforreward();
  level.excludedattachments = [];

  if(!isDefined(level.normal_mode_activation_funcs))
    level.normal_mode_activation_funcs = [];

  if(!isDefined(level.special_mode_activation_funcs))
    level.special_mode_activation_funcs = [];

  if(!isDefined(level.pentskipfov))
    level.pentskipfov = [];

  if(!isDefined(level.pentparams))
    level.pentparams = [];

  level.spawnloopupdatefunc = scripts\cp\cp_modular_spawning::update_spawn_data_on_death;
  scripts\cp\cp_persistence::rank_init();
  level thread handlenondeterministicentities();
  level thread _id_14524();
  level thread smokinggunclassindex();
  thread scripts\cp\cp_outofbounds::initoob();
  scripts\cp\cp_modular_spawning::init_modular_spawning();
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  level thread _id_137D5();
}

_id_137D5() {
  level thread clear_remaining_objective();
  begin_wave_spawning();

  if(scripts\cp\utility::turn_off_sniper_laser())
    level thread floor2lights();

  scripts\cp\killstreaks\uav_cp::scriptable_adddamagedcallback();
}

watch_for_super_ammo_depleted() {
  if(level.logfriendlyfire < 60) {
    return;
  }
  var_0 = 20;

  switch (level.logfriendlyfire) {
    case 64:
    case 63:
    case 62:
    case 61:
    case 60:
      var_0 = 18;
      break;
    case 69:
    case 68:
    case 67:
    case 66:
    case 65:
      var_0 = 16;
      break;
    case 74:
    case 73:
    case 72:
    case 71:
    case 70:
      var_0 = 14;
      break;
    case 79:
    case 78:
    case 77:
    case 76:
    case 75:
      var_0 = 12;
      break;
    case 84:
    case 83:
    case 82:
    case 81:
    case 80:
      var_0 = 11;
      break;
    case 89:
    case 88:
    case 87:
    case 86:
    case 85:
      var_0 = 10;
      break;
    case 94:
    case 93:
    case 92:
    case 91:
    case 90:
      var_0 = 9;
      break;
    case 99:
    case 98:
    case 97:
    case 96:
    case 95:
      var_0 = 8;
      break;
  }

  if(level.logfriendlyfire >= 100 && level.logfriendlyfire < 125)
    var_0 = 7;
  else if(level.logfriendlyfire >= 125 && level.logfriendlyfire < 150)
    var_0 = 6;
  else if(level.logfriendlyfire >= 150)
    var_0 = 5;

  level._id_14529 = var_0;
  setDvar("_encstr_A18B12E63693D7DD85CE95EB3A4BB6B2D7E6ACE8", var_0);

  if(level.logfriendlyfire == 100)
    level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_A5E31886F5D081F65F17612987A06C5B597537878289C1FD187B", "_encstr_9A8507BA4040188D08", 4);
}

floor2lights(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = getEnt("_encstr_8FCA0DBB95C207F6DCBE36932CA359", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt("_encstr_B156119FEF8A79C82CC2C941ACDF90AEB2630B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEnt("_encstr_B4F80E295AADB87F924F5F2F3BEA3D38", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  wait 10;

  if(isDefined(var_1))
    var_1 flip_time();

  if(isDefined(var_2))
    var_2 flip_time();

  if(isDefined(var_3))
    var_3 flip_time();

  level thread floor_gas();
}

floor_gas() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_A6370DE8B4DA597BAEA3F5EE0BCE59");

    if(isDefined(level._id_14531) && level._id_14531 <= level.logfriendlyfire) {
      return;
    }
    level thread init_client();
  }
}

flip_time() {
  if(self.targetname == "_encstr_8FCA0DBB95C207F6DCBE36932CA359") {
    self setHintString(&"_encstr_8B911B56201789CF7D9197BF49B784C053786E5BB38F311D4501A78B51");
    level.infilvideocompletecallback = self;
  } else if(self.targetname == "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38") {
    self setHintString(&"_encstr_A2AD1D68F4A7A0EBD1285315FA0A26A095BC84AA95BE51A8AA29A0A98A39A2");
    level.infil_driver = self;
  } else if(self.targetname == "_encstr_B156119FEF8A79C82CC2C941ACDF90AEB2630B") {
    self setHintString(&"_encstr_93EA1FA7D144E041371F959F784128B92E6A2B6789BE23E809816AC3C683300B37");
    level.infil_plane_vo = self;
  }

  self setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  self sethintdisplayrange(256);
  self sethintdisplayfov(90);
  self setuserange(128);
  self setusefov(90);
  self sethinttag("_encstr_BAA7174128938F8DCD0BF1DB8801095BE90ECDC7B298C7D5D1");
  self sethintonobstruction("_encstr_BECC055CF3811A");
  self setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  thread floor1lights();
}

floor1lights() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread flood_spawn_till_flag();
  level watch_for_super_ammo_depleted();
  level waittill("_encstr_B4700EC309BCBBCF1F5BD1DB031A5869");
  level._id_14522 = 0;

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", -2);
    level.players[var_0] clearsoundsubmix("_encstr_82630E1B1CAF6E47DB4ECABE8CEA36DA", 1);
  }

  if(self.targetname != "_encstr_8FCA0DBB95C207F6DCBE36932CA359") {
    self makeunusable();
    self setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_BA19049F4B2D");

    if(isDefined(self.headicon))
      setheadiconteam(self.headicon);
  }

  landing_damage_watcher();

  if(self.targetname == "_encstr_8FCA0DBB95C207F6DCBE36932CA359") {
    level thread init_and_start_whack_a_mole_sequence_data();
    thread bronloadoutcratedestroyed();
  }

  thread floor1lights();
}

flood_spawn_till_flag() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_A6370DE8B4DA597BAEA3F5EE0BCE59");
  level endon("_encstr_B4700EC309BCBBCF1F5BD1DB031A5869");
  level notify("_encstr_A6B1140CB0F7422018FFFA5B21E7888D6B1A33B938F7");

  for(;;) {
    level._id_14522 = 1;

    if(self.targetname == "_encstr_8FCA0DBB95C207F6DCBE36932CA359")
      self setHintString(&"_encstr_8B911B56201789CF7D9197BF49B784C053786E5BB38F311D4501A78B51");

    self makeusable();
    self setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_AB0703DBB9");

    if(isDefined(self.headicon))
      hideheadiconfromplayersinmask(self.headicon);

    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!istrue(var_0._id_12C68)) {
      var_0 setclientomnvar("_encstr_AA8C130E6F03FBA377FF10A09F5F7837CAD7081583", 2);
      var_0._id_12C68 = 1;
    }

    if(self.targetname == "_encstr_8FCA0DBB95C207F6DCBE36932CA359") {
      var_1 = -1;
      var_2 = var_0.currentprimaryweapon.basename;

      for(var_3 = 0; var_3 < var_0.primaryweapons.size; var_3++) {
        var_4 = var_0.primaryweapons[var_3].basename;
        var_5 = scripts\cp\utility::strip_suffix(var_4, "_encstr_851A049F8337");

        if(var_3 < 2)
          var_0 setplayerdata("_encstr_850703B7D9", "_encstr_AB1413BB2C67594DBAE4ECB4D91636ABB22C07DBDC", var_3, var_5);

        if(var_2 == var_4)
          var_1 = var_3;
      }

      wait 0.1;

      if(var_1 == 0 || var_1 == 1) {
        var_0._id_120B7 = var_1;

        if(istrue(level._id_14522))
          var_0 setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", var_1);
        else
          var_0 setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", 4);

        var_0 setsoundsubmix("_encstr_82630E1B1CAF6E47DB4ECABE8CEA36DA", 1);
        level thread _id_14542(var_0);
      } else
        var_0 thread scripts\cp\utility::hint_prompt("_encstr_8A1E151B0BE68EFABAB92BD7BB961D86EBDDCA58C17BCD", 1, 2);

      continue;
    }

    if(self.targetname == "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38") {
      var_0 setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", 2);
      var_0 setsoundsubmix("_encstr_82630E1B1CAF6E47DB4ECABE8CEA36DA", 1);
      level thread _id_14542(var_0);
      continue;
    }

    if(self.targetname == "_encstr_B156119FEF8A79C82CC2C941ACDF90AEB2630B") {
      var_0 setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", 3);
      var_0 setsoundsubmix("_encstr_82630E1B1CAF6E47DB4ECABE8CEA36DA", 1);
      continue;
    }

    continue;
  }
}

_id_14542(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A6370DE8B4DA597BAEA3F5EE0BCE59");
  level endon("_encstr_A6B1140CB0F7422018FFFA5B21E7888D6B1A33B938F7");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 waittill("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_0 setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", -2);
  var_0 clearsoundsubmix("_encstr_82630E1B1CAF6E47DB4ECABE8CEA36DA", 1);
}

bronloadoutcratedestroyed() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A6370DE8B4DA597BAEA3F5EE0BCE59");
  level endon("_encstr_A6B1140CB0F7422018FFFA5B21E7888D6B1A33B938F7");
  self setHintString(&"_encstr_8B391E566CF9D089D4F35F77E7678079E1F8DEAE85998D41352F6727D183E8A4");

  for(;;) {
    self makeusable();
    self setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_AB0703DBB9");

    if(isDefined(self.headicon))
      hideheadiconfromplayersinmask(self.headicon);

    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!istrue(var_0._id_12C68)) {
      var_0 setclientomnvar("_encstr_AA8C130E6F03FBA377FF10A09F5F7837CAD7081583", 2);
      var_0._id_12C68 = 1;
    }

    if(self.targetname == "_encstr_8FCA0DBB95C207F6DCBE36932CA359") {
      var_1 = -1;
      var_2 = var_0.currentprimaryweapon.basename;

      for(var_3 = 0; var_3 < var_0.primaryweapons.size; var_3++) {
        var_4 = var_0.primaryweapons[var_3].basename;
        var_5 = scripts\cp\utility::strip_suffix(var_4, "_encstr_851A049F8337");

        if(var_3 < 2)
          var_0 setplayerdata("_encstr_850703B7D9", "_encstr_AB1413BB2C67594DBAE4ECB4D91636ABB22C07DBDC", var_3, var_5);

        if(var_2 == var_4)
          var_1 = var_3;
      }

      var_6 = 1;
      var_7 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 5, var_2, 1);

      if(var_7 == "_encstr_8ACC0DEC0F42B1A0263F50189B45B9" || var_7 == "_encstr_8D200E63B9A7DBC550975D5D99600FAA")
        var_6 = 0;

      if(var_6 && (var_1 == 0 || var_1 == 1)) {
        var_0._id_120B7 = var_1;

        if(istrue(level._id_14522))
          var_0 setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", var_1);
        else
          var_0 setclientomnvar("_encstr_83A50C1B07BEB70E2B73FAD885C6", 4);

        var_0 setsoundsubmix("_encstr_82630E1B1CAF6E47DB4ECABE8CEA36DA", 1);
      } else
        var_0 thread scripts\cp\utility::hint_prompt("_encstr_8A1E151B0BE68EFABAB92BD7BB961D86EBDDCA58C17BCD", 1, 2);

      continue;
    }

    continue;
  }
}

init_and_start_whack_a_mole_sequence_data() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\cp\cp_objectives::requestworldid("_encstr_9AAF0D77A57F20318BFBF8A8E222C3", 20);
  objective_state(var_0, "_encstr_AF5A081BBAC993AC73A3");
  objective_setshowoncompass(var_0, 1);
  objective_setplayintro(var_0, 1);
  objective_setlabel(var_0, "_encstr_B40101");
  objective_icon(var_0, "_encstr_A70E17FCFB19B654994F90709A1B732CB0EBBEF25917423912");
  objective_position(var_0, level.infilvideocompletecallback.origin + infilcinematicactive(level.infilvideocompletecallback));
  objective_setshowdistance(var_0, 1);
  objective_setshowprogress(var_0, 0);
  objective_setbackground(var_0, 1);
  level waittill("_encstr_A98610D8021D2F61AFB969519F876BC1C52B");
  objective_state(var_0, "_encstr_8267056410C669");
  objective_delete(var_0);
  scripts\cp\cp_objectives::freeworldidbyobjid(var_0);
}

init_client() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_A98610D8021D2F61AFB969519F876BC1C52B");
  var_0 = scripts\cp\cp_objectives::requestworldid("_encstr_8A360E3758107252B7B44F461FEFDA3B", 20);
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_8271109BDD082B8767F8DB93F051FD0F4045", 20);
  var_2 = scripts\cp\cp_objectives::requestworldid("_encstr_8888109B47DBE4ACEBB5AEE696A32DDECDDC", 20);
  level.infilcoveroverlay = 1;
  objective_state(var_0, "_encstr_AF5A081BBAC993AC73A3");
  objective_setshowoncompass(var_0, 1);
  objective_setlabel(var_0, "_encstr_B40101");
  objective_icon(var_0, "_encstr_B10119D463E897520E670BD7472DABF638AB0E5DDE9875EADF0F03");
  objective_position(var_0, level.infilvideocompletecallback.origin + infilcinematicactive(level.infilvideocompletecallback));
  objective_setshowdistance(var_0, 1);
  objective_setshowprogress(var_0, 0);
  objective_setbackground(var_0, 1);
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  objective_setshowoncompass(var_1, 1);
  objective_setlabel(var_1, "_encstr_B40101");
  objective_icon(var_1, "_encstr_8E391CC16517F1B38F0A3806D30FF670ECDE5B51273FD8858F1350492A63");
  objective_position(var_1, level.infil_driver.origin + infilcinematicactive(level.infil_driver));
  objective_setshowdistance(var_1, 1);
  objective_setshowprogress(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
  objective_setshowoncompass(var_2, 1);
  objective_setlabel(var_2, "_encstr_B40101");
  objective_icon(var_2, "_encstr_86671D1AEAC8F55A6CF6CDFA6EBA4ED94BD958B17DB52DC6D89B8E392BB0DA");
  objective_position(var_2, level.infil_plane_vo.origin + infilcinematicactive(level.infil_plane_vo));
  objective_setshowdistance(var_2, 1);
  objective_setshowprogress(var_2, 0);
  objective_setbackground(var_2, 1);

  if(level.logfriendlyfire <= 2) {
    objective_setplayintro(var_0, 1);
    objective_setplayintro(var_1, 1);
    objective_setplayintro(var_2, 1);
  } else {
    objective_setplayintro(var_0, 0);
    objective_setplayintro(var_1, 0);
    objective_setplayintro(var_2, 0);
  }

  level waittill("_encstr_87DB0C4A6C422BFF401A48570B53");
  objective_state(var_0, "_encstr_8267056410C669");
  objective_delete(var_0);
  scripts\cp\cp_objectives::freeworldidbyobjid(var_0);
  objective_state(var_1, "_encstr_8267056410C669");
  objective_delete(var_1);
  scripts\cp\cp_objectives::freeworldidbyobjid(var_1);
  objective_state(var_2, "_encstr_8267056410C669");
  objective_delete(var_2);
  scripts\cp\cp_objectives::freeworldidbyobjid(var_2);
  level thread init_and_start_whack_a_mole_sequence_data();
}

infilcinematicactive(var_0) {
  return rotatevector((17.5, 0, 0), var_0.angles);
}

landing_damage_watcher() {
  level notify("_encstr_87DB0C4A6C422BFF401A48570B53");
  level.infilcoveroverlay = 0;
}

init_exfil() {
  self.headicon = deleteheadicon(self);

  if(self.targetname == "_encstr_8FCA0DBB95C207F6DCBE36932CA359")
    setheadiconfriendlyimage(self.headicon, "_encstr_B10119D463E897520E670BD7472DABF638AB0E5DDE9875EADF0F03");
  else if(self.targetname == "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38")
    setheadiconfriendlyimage(self.headicon, "_encstr_8E391CC16517F1B38F0A3806D30FF670ECDE5B51273FD8858F1350492A63");
  else if(self.targetname == "_encstr_B156119FEF8A79C82CC2C941ACDF90AEB2630B")
    setheadiconfriendlyimage(self.headicon, "_encstr_86671D1AEAC8F55A6CF6CDFA6EBA4ED94BD958B17DB52DC6D89B8E392BB0DA");

  setheadicondrawthroughgeo(self.headicon, 1);
  setheadiconsnaptoedges(self.headicon, 29000);
  setheadiconmaxdistance(self.headicon, 30);
  addclienttoheadiconmask(self.headicon, 20);
  setheadiconteam(self.headicon);

  for(var_0 = 0; var_0 < level.players.size; var_0++)
    addteamtoheadiconmask(self.headicon, level.players[var_0]);
}

begin_wave_spawning() {
  wait 10;

  foreach(var_1 in level.players)
  scripts\cp\cp_persistence::update_player_career_highest_wave(var_1, 1, level.players.size);

  if(1)
    level thread _id_139BA();

  level._id_139BB = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
}

getclosestplayerforreward() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarint("_encstr_BAE1176E369CD77785B356E6D9BECCB4E64B3ACAEE2C9D56E6", 0);

  if(var_0 == 0) {
    return;
  }
  waitframe();
  level._id_14532 = 1;
  level._id_14531 = var_0;
  setomnvar("_encstr_AF74190B3F1E378A8B0A3FE5413859D78D03ED0E55C9170FFBE621", level._id_14531);
  setDvar("_encstr_A18B12E63693D7DD85CE95EB3A4BB6B2D7E6ACE8", 25);

  for(;;) {
    level waittill("_encstr_A69A0C9B62ABDD913F0E918326E7");
    waitframe();
    var_1 = level.logfriendlyfire;

    if(var_1 >= var_0) {
      setomnvar("_encstr_BDBA0E36077D77C26795EB1D2DADB293", 0);
      setomnvar("_encstr_B41B151BC1FACA73955B4B9537F59C595B582DCDB4B99D", 0);
      level notify("_encstr_B1BD11D2F3CABB076CC280022FEAD0DD3DE116");
      level._id_14530 = 1;
      level thread mp_t_reflex_patch();
      level thread mp_vacant_patch();
      level thread mp_t_reflex_containers_collisions();
      wait 6;
      scripts\cp\cp_objectives::screenent_c("_encstr_8666105BC2D4F69CEBF64C53ACB18EA5B395");
      level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
    }
  }
}

_id_139BA() {
  foreach(var_3, var_1 in level.players) {
    var_2 = max(0.05, var_3 * 0.25);
    var_1 thread _id_14516(var_2);
  }

  for(;;) {
    level waittill("_encstr_B4700EC309BCBBCF1F5BD1DB031A5869");
    level.inithelipropanims = gettime();
    level waittill("_encstr_A69A0C9B62ABDD913F0E918326E7");
    level.inithelipropanims = undefined;
  }
}

_id_14516(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(istrue(self._id_14516)) {
    return;
  }
  self._id_14516 = 1;
  self._id_14515 = [];

  for(;;) {
    if(istrue(level.wave_cooldown_active) || (!isDefined(level.logfriendlyfire) || level.logfriendlyfire == 0)) {
      self._id_14515 = [];
      level waittill("_encstr_B4700EC309BCBBCF1F5BD1DB031A5869");
    }

    self._id_14515 = scripts\engine\utility::array_removedead_or_dying(self._id_14515);

    if(self._id_14515.size >= 3) {
      wait 0.05;
      continue;
    }

    var_1 = _id_143D8();

    if(!istrue(var_1)) {
      wait 0.05;
      continue;
    }

    wait(var_0);
    var_2 = scripts\mp\mp_agent::getaliveagentsofteam("_encstr_8E8405EA382B2A");

    if(isDefined(var_2) && var_2.size > 0)
      var_2 = sortbydistance(var_2, self.origin);
    else
      continue;

    var_3 = randomintrange(1, 2);

    if(isDefined(level.inithelipropanims)) {
      if(gettime() - level.inithelipropanims > 90000)
        var_3 = 2;
      else if(gettime() - level.inithelipropanims > 135000)
        var_3 = 3;
    }

    var_3 = int(min(var_3, var_2.size));

    for(var_4 = 0; var_4 < var_3; var_4++) {
      self._id_14515 = scripts\engine\utility::array_removedead_or_dying(self._id_14515);
      var_5 = var_2[var_4];

      if(istrue(var_5.module_vehicles_count) || isDefined(var_5.unittype) && (var_5.unittype == "_encstr_8EF60E63FBE3D70440A312175B98CF6B" || var_5.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79")) {
        if(var_3 < var_2.size && self._id_14515.size < 3)
          var_3++;

        continue;
      }

      self._id_14515[self._id_14515.size] = var_5;
      var_5 thread bleedout_heartbeat_sfx_logic(self);
    }
  }
}

_id_143D8(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A69A0C9B62ABDD913F0E918326E7");

  if(!isDefined(var_0))
    var_0 = 12;

  if(!isDefined(var_1))
    var_1 = 300;

  while(isalive(self)) {
    var_2 = self.origin;

    if(isDefined(level.inithelipropanims)) {
      while(gettime() - level.inithelipropanims < 30000) {
        var_2 = self.origin;
        wait 1;
      }
    }

    var_5 = gettime();
    var_6 = 1;

    while(gettime() - var_5 < var_0 * 1000) {
      var_7 = distance(self.origin, var_2);

      if(var_7 > var_1) {
        var_6 = 0;
        break;
      }

      wait 0.2;
    }

    if(gettime() - var_5 < var_0 * 1000)
      var_6 = 0;

    if(var_6)
      return 1;
    else if(isDefined(level._id_1451E) && isDefined(level._id_1451E) > 0 && level._id_1451E <= 3)
      return 1;
  }
}

bleedout_heartbeat_sfx_logic(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_99D612C17FDC401566E798D9FA39FE4B3030384A");
  self endon("_encstr_99D612C17FDC401566E798D9FA39FE4B3030384A");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 6;
  var_2 = 5;
  var_3 = 0.5;
  var_4 = self.goalradius;
  self.module_vehicles_count = 1;

  for(;;) {
    if(!isDefined(var_0) || !isalive(var_0) || scripts\cp\cp_laststand::player_in_laststand(var_0)) {
      break;
    }

    self getenemyinfo(var_0);
    var_5 = var_0.origin;
    scripts\cp\cp_modular_spawning::set_goal_pos(var_5);
    var_6 = max(64, self.goalradius * var_3);
    scripts\cp\cp_modular_spawning::set_goal_radius(var_6);
    var_7 = scripts\engine\utility::_id_143B9(var_1, "_encstr_8B7205D9ED5958");

    if(isDefined(var_7) && var_7 == "_encstr_8B7205D9ED5958")
      wait(var_2);
  }

  if(isDefined(var_0) && isDefined(var_0._id_14515))
    var_0._id_14515 = scripts\engine\utility::array_remove(var_0._id_14515, self);

  var_8 = [];

  foreach(var_10 in level.players) {
    if(!isDefined(var_0) || !isalive(var_0) || scripts\cp\cp_laststand::player_in_laststand(var_0)) {
      continue;
    }
    var_8[var_8.size] = var_10;
  }

  if(var_8.size > 0) {
    var_8 = sortbydistance(var_8, self.origin);
    self getenemyinfo(var_8[0]);
    scripts\cp\cp_modular_spawning::set_goal_pos(var_8[0].origin);
  }

  scripts\cp\cp_modular_spawning::set_goal_radius(var_4);
  self.module_vehicles_count = undefined;
}

isloadoutindexdefault(var_0, var_1) {
  self notify("_encstr_A34A0F11CA132DA859E953C711BF6076FF");
  self endon("_encstr_A34A0F11CA132DA859E953C711BF6076FF");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  while(istrue(self.module_vehicles_count)) {
    thread scripts\engine\utility::draw_circle(var_1, self.goalradius, (1, 0, 0), 1, 0, 2);
    wait 0.1;
  }
}

clear_remaining_objective() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 3;
  var_0 = ["_encstr_9B9C2F0B6938A2E0106E652E03F8077A8FF78387BF5E2AA4D0315E7378404EF155153F3F9BE8B26EC058D53CF028B7AF97", "_encstr_8F9C2FB2304F362B8B70B4B17ED3CF7E5B90FA3AA18FED93804583BC1B78C3898B505232081F24E359B885A9A0813F9A89", "_encstr_869F2FC5E80137E39B9F80D87FA15E6F8A564BDD897AE7A87C6FF86817F7B0DF12BDB551985153905BAF80882317AE71EF"];
  var_1 = scripts\engine\utility::random(var_0);
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var_1, "_encstr_9A8507BA4040188D08");
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
      var_0 scripts\cp\cp_mapselect::set_uav_radarstrength(var_0);
      var_0 scripts\cp\cp_persistence::lb_player_update_stat("_encstr_838808DBB7E55A5EBB70", level.wave_num, 1);
      var_0 scripts\cp\cp_wall_buys::setup_player_weapon_models(var_0);
      var_0 scripts\cp\cp_persistence::player_persistence_init();
      var_0 thread scripts\cp\cp_analytics::init_weapon_and_player_analytics(var_0);

      if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
        var_0 scripts\cp\pvpe\pvpe::assign_pvpe_team_and_slot_number(var_0);
        var_0 scripts\cp\pvpe\pvpe::terrorist_self_revive_time_override(var_0);
      }

      var_0.gameskill = scripts\cp\cp_gameskill::get_gameskill();
      var_0 scripts\cp\cp_gameskill::set_difficulty_from_locked_settings();
      var_0 thread strike_player_connect_black_screen();
      var_0 thread scripts\cp\utility::_id_13C3E(1);
      var_0.timeplayed = [];

      foreach(var_5 in level.teamnamelist)
      var_0.timeplayed[var_5] = 0;

      var_0.timeplayed["_encstr_BE7D0633C08849E2"] = 0;
      var_0.timeplayed["_encstr_93C20CED035F8BA928B8834FE840"] = 0;
      var_0.timeplayed["_encstr_8261067B1D34AC27"] = 0;
      var_0.timeplayed["_encstr_8E6E097D1C928BB55DB708"] = 0;

      if(level._id_12376)
        var_0 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_initplayer();

      if(scripts\engine\utility::flag("_encstr_A65211EB562BA098E71253B95ABB589043B525")) {
        if(isDefined(level.custom_player_hotjoin_func))
          var_0 thread[[level.custom_player_hotjoin_func]]();
      }

      if(isDefined(level.custom_onplayerconnect_func))
        [[level.custom_onplayerconnect_func]](var_0);

      if(!isDefined(level.kick_player_queue))
        level thread kick_player_queue_loop();

      var_0 thread kick_for_inactivity(var_0);
      var_0 thread mission_jumpto_debug();

      if(1) {
        var_7 = max(0.05, int(var_0 getentitynumber()) * 0.25);
        var_0 thread _id_14516(var_7);
      }
    }
  }
}

mission_jumpto_debug() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    if(var_0 == "_encstr_A9F20DADA56E6E2D7BDCBEA9D5AD0E") {
      var_2 = getDvar("_encstr_9A050BF1B1D21107C3D5B601E0");
      var_3 = "_encstr_911904535326" + var_2 + "_encstr_A6F310A6BAC37268E64CE3C545CA7A4E3F83";
      var_4 = tablelookup(var_3, 0, var_1, 1);
      var_5 = var_2 + "_encstr_B4580B18900D4FFAE3A7CAC953";
      setdvarifuninitialized(var_5, var_4);
      setDvar(var_5, var_4);
      scripts\cp\cp_endgame::restart_map();
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
  scripts\cp\utility::freezecontrolswrapper(1);
  thread scripts\cp\perks\cp_perks::watchcombatspeedscaler();

  if(isDefined(level.custom_onspawnplayer_func))
    self[[level.custom_onspawnplayer_func]]();

  scripts\cp\cp_globallogic::player_init_invulnerability();
  scripts\cp\cp_globallogic::player_init_damageshield();
  var_1 = get_starting_currency(self);
  thread scripts\cp\cp_persistence::wait_to_set_player_currency(var_1);
  set_player_max_currency(999999);
  thread scripts\cp\cp_damage::core_health_regen();
  thread scripts\cp\cp_hud_util::zom_player_health_overlay_watcher();
  thread add_player_to_threatbias_group();
  thread scripts\cp\cp_weapon::watchweaponusage();
  thread scripts\cp\cp_weapon::watchweaponchange();
  thread scripts\cp\cp_weapon::watchweaponfired();
  thread scripts\cp\coop_personal_ents::assignpersonalmodelents(self);
  thread scripts\cp\coop_personal_ents::movepentstostructs(self);
  thread give_skillpoints_at_start();

  if(!istrue(level.disable_nvg))
    thread scripts\cp\equipment\nvg::runnvg();

  if(isDefined(self.anchor))
    self.anchor delete();

  scripts\cp\utility::force_usability_enabled();

  if(scripts\cp\pvpe\pvpe::pvpe_enabled() && scripts\cp\pvpe\pvpe::player_is_terrorist(self))
    scripts\cp\pvpe\pvpe::on_spawn_terrorist_player(self);

  self setplayerdata("_encstr_850703B7D9", "_encstr_AB1413BB2C67594DBAE4ECB4D91636ABB22C07DBDC", 0, "_encstr_8BE20ED75722A6731BF84F3064CA126B");
  self setplayerdata("_encstr_850703B7D9", "_encstr_AB1413BB2C67594DBAE4ECB4D91636ABB22C07DBDC", 1, "_encstr_8BE20ED75722A6731BF84F3064CA126B");
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
    self setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
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
  var_0 show_introscreen_text();
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
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_0 playerhide();
  var_0 disableweapons();
  var_0 scripts\cp\utility::freezecontrolswrapper(1);

  while(!istrue(var_0.zombiespawnabovedeath))
    wait 1;

  var_0 playershow();
  var_0 scripts\cp\utility::freezecontrolswrapper(0);
  var_0 enableweapons();
  var_0 notify("_encstr_93E5126FC75143212990F29AA823A3CF0825E60D");
  var_0.introscreen_overlay fadeovertime(2);
  var_0.introscreen_overlay.alpha = 0.5;
  wait 2;
  var_0.introscreen_overlay destroy();
  var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);

  if(level.players.size > 1) {
    var_1 = 0;

    foreach(var_3 in level.players) {
      if(isDefined(var_3.introscreen_overlay)) {
        var_1 = 1;
        break;
      }
    }

    if(var_1 == 0) {
      var_5 = getdvarint("_encstr_869F0BD124405564BBD749598B", 0);
      wait(var_5);
      scripts\cp\cp_globallogic::refreshuimatchinprogressomnvarvalue();
      return;
    }
  } else
    scripts\cp\cp_globallogic::refreshuimatchinprogressomnvarvalue();
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

  if(istrue(level.infilcoveroverlay)) {
    landing_damage_watcher();
    level thread init_client();
  } else
    landing_damage_watcher();

  if(isDefined(level._id_1451E))
    setomnvar("_encstr_B41B151BC1FACA73955B4B9537F59C595B582DCDB4B99D", level._id_1451E);
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
  var_1 = 0;
  var_2 = gettime();
  var_3 = level.onlinegame;

  if(!var_3) {
    return;
  }
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
  var_4 = 120;
  var_5 = 0.1;

  for(;;) {
    var_6 = scripts\engine\utility::_id_143C0(var_5, "_encstr_83300E5B75EB036BB24FC8E067CE0169", "_encstr_B46E10418BBE95276B2AC97E479AB848876A");

    if(gettime() - var_2 < 30000) {
      continue;
    }
    if(var_6 != "_encstr_995408F398012F656821") {
      var_4 = 120;
      var_1 = 1;
      continue;
    }

    if(!istrue(var_0.in_afterlife_arcade) && !istrue(var_0.inlaststand))
      var_4 = var_4 - var_5;

    if(var_4 < 0) {
      if(var_1) {
        var_1 = 0;
        continue;
      }

      add_to_kick_queue(var_0);
    }
  }
}

check_for_movement() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = self getnormalizedmovement();
  var_1 = gettime();

  for(;;) {
    wait 0.2;
    var_2 = self getnormalizedmovement();

    if(var_2[0] == var_0[0] && var_2[1] == var_0[1]) {
      if(gettime() - var_1 > 90000)
        add_to_kick_queue(self);

      continue;
    }

    self notify("_encstr_83300E5B75EB036BB24FC8E067CE0169");
    return;
  }
}

add_to_kick_queue(var_0) {
  if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    return;
  }
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
        var_1 thread kill_off_non_essential_ai(var_1);
      }

      level.kick_player_queue = [];
    }

    wait 0.1;
  }
}

kill_off_non_essential_ai(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = 10;

  if(istrue(var_0.clear_up_objective_after_delay)) {
    return;
  }
  var_0.clear_up_objective_after_delay = 1;
  var_0 sethudtutorialmessage(&"_encstr_A95323A19EA714D7E80AA951EB056250B2E52DA4D0967D64E94AEB52721468A2A465294595");
  var_0 setclientomnvar("_encstr_9A6A1083E98E4FD8412AF0DFD95330528B6F", 1);
  var_2 = var_0 scripts\engine\utility::waittill_any_in_array_or_timeout(["_encstr_83300E5B75EB036BB24FC8E067CE0169"], var_1);
  var_0 clearhudtutorialmessage();
  var_0 setclientomnvar("_encstr_9A6A1083E98E4FD8412AF0DFD95330528B6F", 0);
  var_0.clear_up_objective_after_delay = undefined;

  if(var_2 == "_encstr_995408F398012F656821") {
    if(scripts\cp\utility::questtimeradd() == 1)
      level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BD79059C51C351"]);
    else
      kick(var_0 getentitynumber(), "_encstr_A6CC1AB8383F0A01305921294D57CBBB789D75196328214621BF17D3");
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

enable_dogtag_revive(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin + (0, 0, 40));
  var_1 setModel("_encstr_8CFD1ADD63D0EC6B0F8B5B2151506FE30BD75B679BE060FFA620938A");
  var_1 makeusable();
  var_1 scriptmodelplayanim("_encstr_845B0F80326F10804A938B9F27535730E6");
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
  self endon("_encstr_B17A0FC04B036BCA6803AE5662C31BDBD9");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self.bplayerrevivingteammate = 1;
    var_2 = scripts\cp\utility::player_lua_progressbar(var_1, 8000, 9216, 5);
    self.bplayerrevivingteammate = undefined;

    if(!var_2) {
      continue;
    }
    break;
  }

  playFX(level._effect["_encstr_8F3D0E0F27C16BDA189860B95F14AB99"], self.origin);
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

_id_14524() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_8F6D16E8A5DA2BDEAED17DDD85ECCAAF6CDBB538C6591DAC");
    var_0 = [];

    foreach(var_2 in level.players) {
      if(istrue(var_2.isreviving))
        var_0[var_0.size] = var_2;

      if(scripts\cp\cp_laststand::player_in_laststand(var_2) && !istrue(var_2.clear_prev_goal) && !istrue(scripts\cp\cp_laststand::is_being_revived(var_2)))
        var_2 scripts\cp\cp_laststand::instant_revive(var_2);
    }

    wait 2;

    foreach(var_2 in var_0) {
      if(!scripts\cp\cp_laststand::player_in_laststand(var_2) && !istrue(var_2.clear_prev_goal))
        var_2 thread scripts\cp\cp_laststand::set_cam();
    }
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

givedefaultloadout(var_0, var_1, var_2) {
  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  var_3 = self;

  if(!istrue(var_3._id_12C69)) {
    var_3 setclientomnvar("_encstr_AA8C130E6F03FBA377FF10A09F5F7837CAD7081583", 1);
    var_3 thread _id_1434C();
    var_3._id_12C69 = 1;
  }

  var_3.changingweapon = undefined;
  var_3 scripts\cp\cp_accessories::clearplayeraccessory();
  var_3 takeallweapons();

  if(!istrue(var_3.keep_perks))
    var_3 scripts\cp\utility::_clearperks();

  var_3 scripts\cp\utility::_detachall();
  var_3.spawnperk = 0;

  if(initmaxspeedforpathlengthtable(var_3))
    var_3 thread _id_13B0E();

  if(isDefined(var_3.headmodel))
    var_3.headmodel = undefined;

  var_3 thread scripts\cp\survival\survival_loadout::setmodelfromcustomization();
  var_4 = var_3 scripts\cp\survival\survival_loadout::lookupcurrentoperatorskin(var_3.team);
  var_5 = var_3 scripts\cp\survival\survival_loadout::getplayerfoleytype(var_4);

  if(var_5 == "_encstr_B40101")
    var_5 = "_encstr_BEE00A93594E2BE548C7786C";

  var_3 setclothtype(var_5);
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(isDefined(level.move_speed_scale))
    var_3[[level.move_speed_scale]]();
  else
    var_3 scripts\cp\survival\survival_loadout::updatemovespeedscale();

  var_3.primaryweapon = isundefinedweapon();
  var_3.starting_weapon = isundefinedweapon();
  var_3 thread scripts\cp\cp_weapon::setweaponlaser_internal();
  var_3 notify("_encstr_B2030CA0C91D2F44C0B314F8836B");
  var_3 scripts\cp\utility::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");
  var_3 scripts\cp\utility::giveperk("_encstr_82E61BB90795365A85C68EE5FA2B3C07C2CD23958CD7B54BCD2DB58507");

  if(isDefined(var_0) && var_0) {
    return;
  }
  var_6 = var_3.melee_weapon;
  var_3.default_starting_melee_weapon = var_6;
  var_3.currentmeleeweapon = var_6;
  var_3.class = "_encstr_8BBA05185F8B99";
  var_3.class_num = 666;

  if(getqueuedspleveltransients(var_3.default_starting_pistol)) {
    if(!getqueuedspleveltransients(var_3.starting_weapon))
      var_3.default_starting_pistol = var_3.starting_weapon;
    else if(isDefined(level.default_weapon))
      var_3.default_starting_pistol = scripts\cp\cp_weapon::buildweapon(level.default_weapon, [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
    else
      var_3.default_starting_pistol = scripts\cp\cp_weapon::buildweapon("_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  }

  var_3.last_stand_pistol = var_3.default_starting_pistol;
  var_7 = spawnStruct();
  var_8 = var_3 scripts\cp\cp_loadout::cac_getloadoutselectedidx();
  var_9 = var_3 scripts\cp\cp_loadout::loadout_updateclasscustom(var_7, var_8);
  var_3.classstruct = var_9;

  if(!getqueuedspleveltransients(var_3.starting_weapon) && var_3.starting_weapon == var_3.default_starting_pistol) {} else {
    var_10 = scripts\cp\utility::getrawbaseweaponname(var_3.default_starting_pistol);
    var_3.default_starting_pistol = scripts\cp\survival\survival_loadout::return_wbk_version_of_weapon(var_3, var_10, var_3.default_starting_pistol);
    var_3 scripts\cp\utility::_giveweapon(var_3.default_starting_pistol, undefined, undefined, 1);
  }

  if(!getqueuedspleveltransients(var_3.starting_weapon)) {
    var_10 = scripts\cp\utility::getrawbaseweaponname(var_3.starting_weapon);
    var_3.starting_weapon = scripts\cp\survival\survival_loadout::return_wbk_version_of_weapon(var_3, var_10, var_3.starting_weapon);
    var_3 scripts\cp\utility::_giveweapon(var_3.starting_weapon, undefined, undefined, 0);
  }

  if(isDefined(var_3.operatorcustomization) && isDefined(var_3.operatorcustomization.execution))
    var_3 scripts\cp_mp\execution::_giveexecution(var_3.operatorcustomization.execution);

  var_11 = scripts\cp\utility::getrawbaseweaponname(var_3.default_starting_pistol);
  var_3[[level.move_speed_scale]]();
  var_7 = spawnStruct();
  var_7.lvl = scripts\cp\survival\survival_loadout::get_baseweapon_pap_level(var_3, var_11);
  var_3.pap[var_11] = var_7;
  var_3 notify("_encstr_A56D15C7BF3A174856E9C8E1CB0508D8B233636D5F82D5");
  var_3 giveweapon("_encstr_BEB611F03B72BB3B07E435BCF9772051117388");
  var_3 assignweaponoffhandspecial("_encstr_BEB611F03B72BB3B07E435BCF9772051117388");
  var_3.specialoffhandgrenade = "_encstr_BEB611F03B72BB3B07E435BCF9772051117388";
  var_3 scripts\cp\survival\survival_loadout::set_player_perks();
  var_12 = var_3.default_starting_pistol;

  if(!getqueuedspleveltransients(var_3.starting_weapon))
    var_12 = var_3.starting_weapon;

  if(isDefined(self.classstruct.loadoutaccessorydata) && isDefined(self.classstruct.loadoutaccessoryweapon) && self.classstruct.loadoutaccessoryweapon != "_encstr_8BBA05185F8B99")
    scripts\cp\cp_accessories::giveplayeraccessory(self.classstruct.loadoutaccessorydata, self.classstruct.loadoutaccessoryweapon, self.classstruct.loadoutaccessorylogic);

  var_13 = self getplayerdata("_encstr_850703B7D9", "_encstr_8D0B0F2DB9D9ACCD47DE39BC9AB1ED3A9B", "_encstr_96500B3AEDA3B0363563DE1DCD");
  var_3 scripts\cp\cp_munitions::reset_munitions(self, var_13);
  var_14 = 1;
  var_15 = 1;
  var_16 = "_encstr_81580B52FF3F7F3D195A6A61A7";
  var_17 = "_encstr_B81D0C38EDBB56C9F599B12CDC34";
  var_3 thread scripts\cp\cp_powers::givepower(var_16, "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, var_14);
  var_3 thread scripts\cp\cp_powers::givepower(var_17, "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, var_15);
  var_3 thread scripts\cp\survival\survival_loadout::wait_and_force_weapon_switch(var_12);

  if(istrue(level.disable_nvg))
    var_3 setactionslot(2, "_encstr_B40101");

  var_3 setactionslot(3, "_encstr_B4DC085639F9C2779108");

  if(isDefined(var_3.operatorcustomization) && isDefined(var_3.operatorcustomization.execution))
    var_3 scripts\cp_mp\execution::_giveexecution(var_3.operatorcustomization.execution);

  var_3 notify("_encstr_B4C40E582257FDB09BB4077FC103B8B0");
  var_3.zombiespawnabovedeath = 1;

  if(!scripts\engine\utility::flag_exist("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0"))
    scripts\engine\utility::flag_init("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  scripts\engine\utility::flag_set("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
}

_id_1434C() {
  wait 15;
  self setclientomnvar("_encstr_AA8C130E6F03FBA377FF10A09F5F7837CAD7081583", 1);
}

_id_13B0E() {
  if(getdvarint("_encstr_AA1E1B4BFE5AD11562F7A98FE3CAD573F459B04125BF70453BE3FBBFD3", 0) == 0) {
    return;
  }
  wait 3;
  self.ignoreme = 1;
}

getspawnpoint() {
  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(scripts\cp\pvpe\pvpe::pvpe_enabled())
    return scripts\cp\pvpe\pvpe::getassignedspawnpointbasedonteam(self);
  else if(scripts\cp\pvpve\pvpve::pvpve_enabled())
    return scripts\cp\pvpve\pvpve::getassignedspawnpointbasedonteam(self);
  else
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

mp_t_reflex_patch() {
  foreach(var_1 in level.players)
  var_1.ability_invulnerable = 1;

  wait 6.6;

  foreach(var_1 in level.players) {
    var_1 clearclienttriggeraudiozone(1);

    if(istrue(var_1.musicplaying)) {
      var_1 playlocalsound("_encstr_938A1A9DCB39AAEB047FD7177336710C10B1972581E16AA3E5210F23");
      var_1 setscriptablepartstate("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A7A408B9CA5D1D4E2C63", 0);
    }

    var_1 setplayermusicstate("_encstr_A13211C1259BD88BFF03FB61B32B3ED3282E47");
    var_1 setsoundsubmix("_encstr_B89F0CD807D75B58A36C1A2B3723", 1);
  }

  wait 2.2;

  foreach(var_1 in level.players) {
    var_1 clearsoundsubmix("_encstr_B89F0CD807D75B58A36C1A2B3723", 1);
    var_1 clearsoundsubmix("_encstr_B2281235B9A105E75D01F22A48BDE7FD1827B983", 1);
  }
}

mp_vacant_patch() {
  var_0 = "_encstr_AFE8222387F5C607E6FA5B0BB5B0BEC55DB0279C9723FACAF0D139C2C6D12DB7DCAFD460";
  level scripts\cp\cp_vo::try_to_play_vo_on_team(var_0, "_encstr_9A8507BA4040188D08");
  wait 0.2;
  var_0 = "_encstr_A7782ACA48375E4313D81B09E97937E2F3104282880B122F4EB61D14FD63AB213FB0FA2A18E74B3F6108B268";
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var_0, "_encstr_9A8507BA4040188D08");
}

mp_t_reflex_containers_collisions() {
  wait 1;

  foreach(var_1 in level.players) {
    var_1 allowmovement(0);
    var_1 allowfire(0);
    var_1 disableoffhandweapons();
    var_1 disableusability();
    var_1 allowmovement(0);
  }

  wait 3;

  foreach(var_1 in level.players)
  var_1 thread scripts\mp\vehicles\vehicle_damage_mp::_id_1340D(1.5, 1, 1);

  wait 2;
  var_5 = scripts\engine\utility::getStructArray("_encstr_A37A0C630B892AE72801FE02F9C8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(!isDefined(var_5) || var_5.size == 0) {
    return;
  }
  foreach(var_1 in level.players) {
    var_7 = var_5[0];
    var_8 = var_7.origin;
    var_9 = scripts\engine\utility::getStruct(var_7.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_8);
    var_10 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_10.angles = var_7.angles;
    var_10 moveTo(var_9.origin, 20, 1, 1);
    var_1 playerhide();
    var_1 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
    var_1 spawn_endgame_camera(var_10);
    var_1 lerpfovscalefactor(0, 0);
  }
}

spawn_endgame_camera(var_0) {
  self.ignoreme = 1;
  self cameralinkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self setclientdvar("_encstr_A3D20B62A25A2854A94194A839", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer())
    self setclientdvar("_encstr_B14A0A4545A9412AC9133D26", "_encstr_82070322E1");
}

smokinggunclassindex() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_97AF17C6CAD9598DEB939585235EF5CC7B397D37D84E9607E8");
  wait 10;
  var_0 = 60000;
  var_1 = [];

  for(;;) {
    if(isDefined(level.vehicle) && isDefined(level.vehicle.helicopter_crash_locations)) {
      for(var_2 = 0; var_2 < level.vehicle.helicopter_crash_locations.size; var_2++) {
        var_3 = level.vehicle.helicopter_crash_locations[var_2];

        if(!isDefined(var_3) || !isstruct(var_3)) {
          continue;
        }
        if(istrue(var_3.claimed)) {
          if(!isDefined(var_3.hacks_needed)) {
            var_3.hacks_needed = gettime();
            var_1[var_1.size] = var_3;
          } else if(isDefined(var_3.hacks_needed)) {
            if(gettime() > var_3.hacks_needed + var_0) {
              var_3.hacks_needed = undefined;
              var_3.claimed = undefined;

              if(scripts\engine\utility::array_contains(var_1, var_3))
                var_1 = scripts\engine\utility::array_remove(var_1, var_3);
            }
          }

          continue;
        }

        if(scripts\engine\utility::array_contains(var_1, var_3)) {
          var_3.hacks_needed = undefined;
          var_1 = scripts\engine\utility::array_remove(var_1, var_3);
        }
      }
    }

    wait 1;
  }
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