/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3858411d0b73d352.gsc
***********************************************/

main() {
  load_vfx();
  level thread scripts\cp\cp_enemy_drone_turret::init();
  level.fnplaysoundonentity = scripts\cp\utility::play_sound_on_entity;
  level.fnplaysoundontag = scripts\cp\utility::play_sound_on_tag;

  if(!scripts\engine\utility::flag_exist("cp_bs_cs_completed"))
    scripts\engine\utility::flag_init("cp_bs_cs_completed");

  if(!scripts\engine\utility::flag_exist("cp_bs_spawners_cs_completed"))
    scripts\engine\utility::flag_init("cp_bs_spawners_cs_completed");

  scripts\engine\utility::flag_wait("cp_bs_cs_completed");
  scripts\engine\utility::flag_wait("cp_bs_spawners_cs_completed");
  scripts\engine\utility::flag_init("leave_lz");
  scripts\engine\utility::flag_init("hover_lz");
  scripts\engine\utility::flag_init("reached_hover_pos");
  init_player_falling_anims();
  script_model_anims();
  register_spawners();
  load_systems();
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil("exfil_location", 0);
  level._id_72069798E35CC6BC = [];
  level._id_EF796AC0B0326726 = ::_id_95F7211DB94C5A7D;
  objname = getDvar("dvar_555D54BF3BDC1791", "stealth_container");

  if(isDefined(objname) && objname == "stealth_nuke")
    level._id_B20A836DA84340B0 = ::_id_B20A836DA84340B0;

  level._id_81F873EAE0CBAC09 = scripts\cp\coop_stealth::_id_81F873EAE0CBAC09;
  level._id_DD58FE315B085D35 = _id_51023E7DB5068D92::_id_DD58FE315B085D35;
  level._id_DF3AD2237853744A = _id_51023E7DB5068D92::_id_DF3AD2237853744A;
  _id_EA0FBAC82EEC8FC1 = getEnt("exfil_heli_spawner", "targetname");
  _id_EA0FBAC82EEC8FC1 hide();
  _id_51023E7DB5068D92::main();
  thread scripts\cp\cp_outofbounds::initoob();
  level notify("level_systems_loaded");
}

load_systems() {
  level thread _id_D310A02FE098E9BB();
  level._id_8EA15099F566731C = [];
  scripts\cp\cp_remote_tank::init_remote_tank();
  _id_742F61B6768A1AAB::main();
  _id_B63085DE741C1A2F = scripts\engine\utility::getStructArray("loadout_interaction", "targetname");

  foreach(struct in _id_B63085DE741C1A2F)
  thread edit_loadout_think(struct);

  level thread spawn_rpgs_for_players();
  _id_111CC3C35CB7BBA2();
  scripts\cp\cp_hacking::hacking_init();
  _id_921CA717F116A55A();
  _id_6E49F1AC9BD52300();
  level thread _id_021787630BBEE2A4::init();
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("nuke_core", ["weapon_pickup", "offhand_weapons", "weapon_switch", "gesture", "ads", "reload", "autoreload", "sprint", "crouch", "prone", "fire", "melee", "mantle"]);
  thread flare_setup();
  level thread _id_5515BB7F1773B116();
  _id_3AE866A6DD08DAF9::_id_E7A64DF827074B05();
}

_id_1BB3F8A02C699C93() {
  _id_4B02400DAD63CAFB::_id_E7A64DF827074B05();
  level.sentrysettings["incursion_sentry"].maxrange = 443556;
  level.sentrysettings["incursion_sentry"]._id_947AF351CE904AA5 = 443556;
  _id_70DAB3207FB65169 = scripts\engine\utility::getStructArray("enemy_sentry_rpg", "targetname");

  foreach(struct in _id_70DAB3207FB65169)
  turret = _id_4B02400DAD63CAFB::setup_enemy_sentry(struct, "rpg");
}

_id_5515BB7F1773B116() {
  level._id_10EB51FBDC50D04A = scripts\engine\utility::getStructArray("vehicle_spawners", "targetname");
  scripts\engine\utility::array_thread(level._id_10EB51FBDC50D04A, ::_id_A4FA91AF21833709);
}

_id_A4FA91AF21833709() {
  if(!isDefined(self.script_noteworthy)) {
    return;
  }
  spawndata = spawnStruct();
  spawndata.origin = self.origin;
  spawndata.angles = self.angles;

  switch (self.script_noteworthy) {
    case "tac_rover":
      break;
    case "atv":
      if(!isDefined(level.atvs))
        level.atvs = [];

      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", spawndata);

      if(isDefined(vehicle))
        level.atvs = scripts\engine\utility::array_add(level.atvs, vehicle);

      break;
    case "jeep":
      break;
    case "technical":
      if(!isDefined(level.technicals))
        level.technicals = [];

      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("technical", spawndata);

      if(isDefined(vehicle))
        level.technicals = scripts\engine\utility::array_add(level.technicals, vehicle);

      break;
    case "pickup_truck":
      break;
    case "van":
      break;
    case "cargo_truck":
      if(!isDefined(level._id_1EFBD69D1F238BBC))
        level._id_1EFBD69D1F238BBC = [];

      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("cargo_truck", spawndata);

      if(isDefined(vehicle))
        level._id_1EFBD69D1F238BBC = scripts\engine\utility::array_add(level._id_1EFBD69D1F238BBC, vehicle);

      break;
    case "large_transport":
      if(!isDefined(level._id_1A4C470A469931BB))
        level._id_1A4C470A469931BB = [];

      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("large_transport", spawndata);

      if(isDefined(vehicle))
        level._id_1A4C470A469931BB = scripts\engine\utility::array_add(level._id_1A4C470A469931BB, vehicle);

      break;
    case "light_tank":
      break;
    case "apc_russian":
      break;
    case "cargo_truck_mg":
      break;
    case "little_bird":
      break;
    case "little_bird_mg":
      break;
    case "magma_plunder_chopper":
      break;
  }
}

_id_141F050950C6E98B() {
  level._id_251DD52BF1FC7C49 = getEntArray("trap_hint_trigger", "targetname");
  scripts\engine\utility::array_thread(level._id_251DD52BF1FC7C49, ::_id_ECDCACF9B5DE2010);
}

_id_ECDCACF9B5DE2010() {
  if(!isDefined(level.next_hint_time))
    level.next_hint_time = gettime();

  level._id_CC4C5A32D7A47C7F = 0;

  for(;;) {
    self waittill("trigger", entity);

    if(!isPlayer(entity)) {
      continue;
    }
    if(!scripts\cp\utility\player::isreallyalive(entity)) {
      continue;
    }
    current_time = gettime();

    if(level._id_CC4C5A32D7A47C7F > 3) {
      return;
    }
    if(!isDefined(level.next_hint_time) || level.next_hint_time > current_time) {
      wait 0.1;
      continue;
    }

    foreach(player in level.players)
    player thread _id_528BB38E3BE00A47(self);

    level._id_CC4C5A32D7A47C7F++;
    level.next_hint_time = current_time + randomintrange(30000, 30000 + level._id_CC4C5A32D7A47C7F * 5000);
  }
}

_id_528BB38E3BE00A47(trigger) {
  self endon("disconnect");
  self sethudtutorialmessage(&"CP_BAD_SITUATION_OBJ/TRAP_HINT", 1);
  wait 3;
  self clearhudtutorialmessage();
}

_id_D310A02FE098E9BB() {
  if(!isDefined(level.tanksettings))
    level.tanksettings = [];

  if(!isDefined(level.tanksettings["drone_turret"])) {
    level.tanksettings["drone_turret"] = spawnStruct();
    level.tanksettings["drone_turret"].timeout = 60.0;
    level.tanksettings["drone_turret"].maxhealth = 500;
    level.tanksettings["drone_turret"].hitstokill = 5;
    level.tanksettings["drone_turret"].streakname = "pac_sentry";
    level.tanksettings["drone_turret"].modelbase = "veh8_mil_lnd_whotel";
    level.tanksettings["drone_turret"].modeldestroyed = "veh8_mil_lnd_whotel";
    level.tanksettings["drone_turret"].mgturretmodelbase = "veh8_mil_air_tuniform_turret";
    level.tanksettings["drone_turret"].mgturretinfo = "sentry_turret_cp";
    level.tanksettings["drone_turret"].sentrymodeon = "sentry";
    level.tanksettings["drone_turret"].sentrymodeoff = "sentry_offline";
    level.tanksettings["drone_turret"].vehicleinfo = "veh_pac_sentry_mp_cp";
    level.tanksettings["drone_turret"].stringcannotplace = &"KILLSTREAKS_HINT_CANNOT_CALL_IN";
    level.tanksettings["drone_turret"].scorepopup = "destroyed_pac_sentry";
    level.tanksettings["drone_turret"].vodestroyed = "destroyed_pac_sentry";
    level.tanksettings["drone_turret"].destoyedsplash = "callout_destroyed_pac_sentry";
    level.tanksettings["drone_turret"].premoddamagefunc = undefined;
    level.tanksettings["drone_turret"].lifetime = 600;
  }
}

_id_6E49F1AC9BD52300() {
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_8BB489A8869BC0E1);
}

_id_8BB489A8869BC0E1() {
  thread _id_385ABB5E585FE105();
}

_id_385ABB5E585FE105() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("forceEnableNVGsThread");
  self endon("forceEnableNVGsThread");

  if(!scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::ent_flag_init("player_spawned_with_loadout");

  scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");
  wait 4.5;

  while(!isDefined(level._id_98C7A0B9D468973B))
    waitframe();

  if(!istrue(self._id_E6692CC0F7DB74AB)) {
    self nightvisionviewon();
    self._id_E6692CC0F7DB74AB = 1;
    scripts\cp\equipment\nvg::savenvgstate();
    scripts\cp\equipment\nvg::nvg_update3rdperson(1);
    level notify("player_enabled_nvgs");
  } else
    self nightvisionviewon();
}

_id_50F485C187208347() {
  thread _id_B9C6686207026A93();
}

_id_B9C6686207026A93() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("killReactionsThread");
  self endon("killReactionsThread");

  for(;;) {
    self waittill("got_multikill");
    childthread scripts\cp\cp_player_battlechatter::addexecutionquip();
  }
}

_id_D5C017DF6CFE21D3() {
  _id_8EC1EF0203900B0C = scripts\engine\utility::getStructArray("at_mine", "targetname");
  _id_65FBFB7F9EA1F3E0 = scripts\engine\utility::getStructArray("at_mine_forest", "targetname");

  foreach(_id_0C3EA9B1A20FF199 in _id_8EC1EF0203900B0C) {
    _id_0C3EA9B1A20FF199 spawn_at_mine();
    waitframe();
  }

  foreach(_id_0C3EA9B1A20FF199 in _id_65FBFB7F9EA1F3E0) {
    _id_0C3EA9B1A20FF199 spawn_at_mine();
    waitframe();
  }
}

spawn_at_mine() {
  _id_E020078567E41613 = magicgrenademanual("at_mine_mp", self.origin + (0, 0, 100), (0, 0, 10));
  _id_E020078567E41613.owner = _id_E020078567E41613;
  _id_E020078567E41613.team = "axis";
  thread scripts\cp\equipment\cp_at_mine::at_mine_plant(_id_E020078567E41613);
}

load_vfx() {
  _id_390BB92B200E27FA::_id_432CBDDDEB9A6775();
  _id_504283B70DE854FA::load_fx();
  _id_3AE866A6DD08DAF9::load_laser_fx();
  level._effect["vfx_nvg_light_player_nightwar_proto"] = loadfx("vfx/iw9/level/nightwar/vfx_nvg_light_player_nightwar_proto.vfx");
  level._effect["vfx_illumination_flare"] = loadfx("vfx/iw8/level/embassy/vfx_illumination_flare.vfx");
  level._effect["vfx_illumination_flare_launch_trail"] = loadfx("vfx/iw8/level/embassy/vfx_illumination_flare_launch_trail.vfx");
  level._effect["vfx_illumination_flare_unlit"] = loadfx("vfx/iw8/level/embassy/vfx_illumination_flare_unlit.vfx");
  level._effect["vfx_cp_chopper_spotlight"] = loadfx("vfx/iw8_cp/level/cp_raid_complex/vfx_cp_chopper_enemy_spotlight.vfx");
  level._effect["chopper_boss_explosion"] = loadfx("vfx/iw8_mp/killstreak/vfx_chopper_support_explosion.vfx");
  level._effect["nuke_core_vapor"] = loadfx("vfx/iw8_cp/prop/vfx_cp_nuke_core_expose_vapor.vfx");
  level._effect["sniper_muzzle_flash"] = loadfx("vfx/iw8_cp/vfx_sniper_muzzle_flash.vfx");
  level._effect["spotlight"] = loadfx("vfx/iw9/cp/vfx_cp_chopper_spotlight_01.vfx");
  level._effect["spotlight_02"] = loadfx("vfx/iw9/cp/vfx_cp_chopper_spotlight_01.vfx");
  level._effect["nvg_eyelights"] = loadfx("vfx/iw8/core/nvg/vfx_nvg_goggles_eyelights.vfx");
  level._effect["vfx_ammo_beacon"] = loadfx("vfx/iw9/cp/vfx_beacon_light.vfx");
  level.g_effect["molotov_explosion"] = loadfx("vfx/iw8/core/molotov/vfx_molotov_explosion.vfx");
  level.g_effect["molotov_explosion_child"] = loadfx("vfx/iw8/core/molotov/vfx_molotov_explosion_child.vfx");
  level.g_effect["vfx_burn_lrg_high"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_high.vfx");
  level.g_effect["vfx_burn_lrg_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_low.vfx");
  level.g_effect["vfx_burn_med_high"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_high.vfx");
  level.g_effect["vfx_burn_med_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_low.vfx");
  level.g_effect["vfx_burn_sml_high"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_high.vfx");
  level.g_effect["vfx_burn_sml_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_low.vfx");
  level.g_effect["vfx_burn_sml_head_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_head_low.vfx");
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
  level._effect["vfx_smk_signal_gr"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal_gr");
  level._effect["vfx_smk_signal_dmz"] = loadfx("vfx/iw9/level/mp_dmz_hydro/vfx_smk_signal_dmz");
  level._effect["vfx_smk_signal_dmz_diss"] = loadfx("vfx/iw9/level/mp_dmz_hydro/vfx_smk_signal_dmz_diss");
}

register_interactions() {
  register_care_package_interaction();
  _id_71332A5B74214116::registerinteraction("gasmask", ::hint_gasmask, ::activate_gasmask, ::init_gasmask, 0, "duration_long");
  _id_71332A5B74214116::registerinteraction("flare_launcher", ::_id_636AE50A85277DB4, ::_id_D1A5DAF1CA88113C, ::_id_FF55057707580F4D, 0, "duration_long");
}

#using_animtree("script_model");

_id_FF55057707580F4D(_id_70DAB3207FB65169) {
  level._id_180F9E309D809DCB = 0;
  level._id_732A9D5460F1EB0F = 0;
  level._id_C75F23F8DE84A0B6 = [];

  if(_id_70DAB3207FB65169.size > 0) {
    foreach(struct in _id_70DAB3207FB65169) {
      level._id_180F9E309D809DCB++;
      struct.model = spawn("script_model", struct.origin);
      struct.model setModel("misc_wm_mortar");
      struct.model.angles = struct.angles;
      struct.model.flash = "j_shaft_top";
      struct.model.shell = "j_mortar_shell";
      struct.model hidepart(struct.model.shell, "misc_wm_mortar");
      struct.model.animname = "mortar";
      struct.model useanimtree(#animtree);
      scripts\cp_mp\mortar_launcher::setupmortarmodelanimscripts();
      scripts\cp_mp\mortar_launcher::setupmortarplayeranimscripts();
      level._id_C75F23F8DE84A0B6 = scripts\engine\utility::array_add(level._id_C75F23F8DE84A0B6, struct.model);
    }
  }

  _id_71332A5B74214116::removefrominteractionslistbynoteworthy("flare_launcher");
}

_id_636AE50A85277DB4(_id_DF071553D0996FF9, player) {
  if(istrue(_id_DF071553D0996FF9.locked))
    return "";

  return &"CP_BAD_SITUATION_OBJ/LAUNCH_FLARE";
}

_id_D1A5DAF1CA88113C(_id_DF071553D0996FF9, player) {
  if(istrue(_id_DF071553D0996FF9.locked)) {
    return;
  }
  _id_DF071553D0996FF9.locked = 1;
  level._id_732A9D5460F1EB0F++;

  if(level._id_180F9E309D809DCB == level._id_732A9D5460F1EB0F)
    level notify("flares_launched");

  _id_DF071553D0996FF9.model hudoutlinedisable();
  player _id_B613C78D8683B4A6(player, _id_DF071553D0996FF9.model);
  _id_DF071553D0996FF9.model thread _id_A2278E76E27F083D();
  _id_71332A5B74214116::remove_from_current_interaction_list(_id_DF071553D0996FF9);
}

_id_B613C78D8683B4A6(player, _id_92753DA39919F200) {
  player setOrigin(_id_92753DA39919F200.origin);
  player setplayerangles(_id_92753DA39919F200.angles);
  player scripts\cp_mp\mortar_launcher::create_player_rig(player, "player_mortar");
  player.player_rig.angles = _id_92753DA39919F200.angles;
  scripts\cp_mp\mortar_launcher::put_player_into_rig(player.player_rig, 0.5, 0, 0, 0, 0, player);
  player _id_3B64EB40368C1450::set("mortar", "weapon", 0);
  player scripts\cp\utility::_setdof_internal(0, 6, 10, 100, 7, 4);
  player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
  _id_92753DA39919F200 showpart(_id_92753DA39919F200.shell, "misc_wm_mortar");
  player.player_rig show();
  _id_92753DA39919F200 scripts\engine\utility::delaythread(2.25, ::launch_illumination_flare);
  thread scripts\cp_mp\mortar_launcher::mortar_launch_player_effect(player, _id_92753DA39919F200);
  _id_92753DA39919F200 thread scripts\common\anim::anim_single([_id_92753DA39919F200, player.player_rig], "player_mortar_fire");
  player.player_rig waittillmatch("single anim", "end");
  _id_92753DA39919F200 hidepart(_id_92753DA39919F200.shell, "misc_wm_mortar");
  player scripts\cp\utility::setdof_default();
  scripts\cp_mp\mortar_launcher::take_player_out_of_rig(player);
}

_id_A2278E76E27F083D() {
  self playLoopSound("milbase_hot_alarm");
  level waittill("white_ph_drops_or_never");
  self stoploopsound();
}

init_gasmask(_id_70DAB3207FB65169) {
  level.blackbox_count = 0;
  level._id_15DA423B84819894 = [];

  if(_id_70DAB3207FB65169.size > 0) {
    foreach(struct in _id_70DAB3207FB65169) {
      struct.model = spawn("script_model", struct.origin);
      struct.model setModel("hat_gasmask");

      if(!isDefined(struct.angles))
        struct.angles = (0, 0, 0);

      struct.model.angles = struct.angles;
    }
  }

  _id_71332A5B74214116::removefrominteractionslistbynoteworthy("gasmask");
}

hint_gasmask(_id_DF071553D0996FF9, player) {
  return &"CP_BAD_SITUATION_OBJ/EQUIP_GASMASK_FILTER";
}

activate_gasmask(_id_DF071553D0996FF9, player) {
  if(!istrue(player.gasmaskequipped)) {
    player.gasmaskhealth = 120;
    player thread scripts\cp_mp\gasmask::equipgasmask();
    player setclientomnvar("ui_head_equip_class", 2);
  } else {
    self playsoundtoplayer("scavenger_pack_pickup", self);
    self forceplaygestureviewmodel("ges_visor_down");
    self.gasmaskswapinprogress = 1;
    wait 0.338;
    self.gasmaskswapinprogress = 0;
    player iprintln(" ^7you added a ^1gas mask^7 filter! ");
    player.gasmaskhealth = player.gasmaskhealth + 30;
  }

  _id_71332A5B74214116::remove_from_current_interaction_list(_id_DF071553D0996FF9);
}

edit_loadout_think(struct) {
  level endon("game_ended");
  model = spawn("script_model", struct.origin);
  model setModel("tag_origin");
  model scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_DWN_TWN_OBJECTIVES/DWN_TWN_LOADOUT", 25, "duration_short", "hide", 256, 65, 64, 65);
  model.headicon = createheadicon(model);
  setheadiconimage(model.headicon, "hud_icon_survival_weapon");
  setheadiconsnaptoedges(model.headicon, 0);
  setheadiconmaxdistance(model.headicon, 1024);
  setheadiconnaturaldistance(model.headicon, 30);
  setheadiconzoffset(model.headicon, 10);

  for(;;) {
    model waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    player thread edit_loadout(model);
  }
}

edit_loadout(interaction) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  self setclientomnvar("cp_open_cac", -1);
  self setclientomnvar("ui_options_menu", 2);
  scripts\engine\utility::waittill_any_2("loadout_given", "loadout_menu_closed");
  wait 1;
  self setclientomnvar("cp_open_cac", -2);
}

spawn_rpgs_for_players() {
  _id_D7BF6D3C92D1A535 = scripts\engine\utility::getStructArray("rpg_interaction", "script_noteworthy");
  _id_EF20DA01F7171CD8 = ["iw8_la_rpapa7_mp", "iw8_la_gromeo_mp", "iw8_la_kgolf_mp", "iw8_la_mike32"];

  foreach(_id_CB50110314060044 in _id_D7BF6D3C92D1A535) {
    _id_CB50110314060044.angles = (0, 0, 0);
    weapon = _id_74502A9E0EF1F19C::spawn_script_weapon(scripts\engine\utility::random(_id_EF20DA01F7171CD8), [], _id_CB50110314060044.origin + (0, 0, 64), _id_CB50110314060044.angles);
    weapon thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(weapon), weaponstartammo(weapon));
  }
}

teleport_black_overlay(player) {
  player endon("diconnect");
  player setclientomnvar("ui_hide_hud", 1);
  player disableweapons();
  player scripts\cp\utility::freezecontrolswrapper(1);
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0);
  wait 8;
  player enableweapons();
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 5);
  wait 1;
  player setclientomnvar("ui_hide_hud", 0);
  player scripts\cp\utility::freezecontrolswrapper(0);
}

screen_corner_line(string, _id_30CB22B65D96DAB7, _id_2C6CA80E296FED3A) {
  if(!isDefined(level.intro_offset))
    level.intro_offset = 0;
  else
    level.intro_offset++;

  y = cornerline_height();
  _id_EE08218F9C4900ED = 1.6;

  if(level.splitscreen)
    _id_EE08218F9C4900ED = 2;

  _id_94480E1669B7FF0D = newclienthudelem(_id_2C6CA80E296FED3A);
  _id_94480E1669B7FF0D.x = 20;
  _id_94480E1669B7FF0D.y = y;
  _id_94480E1669B7FF0D.alignx = "left";
  _id_94480E1669B7FF0D.aligny = "bottom";
  _id_94480E1669B7FF0D.horzalign = "left";
  _id_94480E1669B7FF0D.vertalign = "bottom";
  _id_94480E1669B7FF0D.sort = 3;
  _id_94480E1669B7FF0D.foreground = 1;
  _id_94480E1669B7FF0D settext(string);
  _id_94480E1669B7FF0D.alpha = 1;
  _id_94480E1669B7FF0D.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.fontscale = _id_EE08218F9C4900ED;
  _id_94480E1669B7FF0D.color = (0.8, 1, 0.8);
  _id_94480E1669B7FF0D.font = "default";
  _id_94480E1669B7FF0D.glowcolor = (0.3, 0.6, 0.3);
  _id_94480E1669B7FF0D.glowalpha = 1;
  return _id_94480E1669B7FF0D;
}

cornerline_height(player) {
  return player.intro_offset * 20 - 122;
}

introscreen_corner_line(string, _id_30CB22B65D96DAB7) {
  if(!isDefined(self.intro_offset))
    self.intro_offset = 0;
  else
    self.intro_offset++;

  y = cornerline_height(self);
  _id_EE08218F9C4900ED = 1.6;

  if(level.splitscreen)
    _id_EE08218F9C4900ED = 2;

  _id_94480E1669B7FF0D = newclienthudelem(self);
  _id_94480E1669B7FF0D.x = 20;
  _id_94480E1669B7FF0D.y = y;
  _id_94480E1669B7FF0D.alignx = "left";
  _id_94480E1669B7FF0D.aligny = "bottom";
  _id_94480E1669B7FF0D.horzalign = "left";
  _id_94480E1669B7FF0D.vertalign = "bottom";
  _id_94480E1669B7FF0D.sort = 3;
  _id_94480E1669B7FF0D.foreground = 1;
  _id_94480E1669B7FF0D settext(string);
  _id_94480E1669B7FF0D.alpha = 1;
  _id_94480E1669B7FF0D.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.fontscale = _id_EE08218F9C4900ED;
  _id_94480E1669B7FF0D.color = (0.8, 1, 0.8);
  _id_94480E1669B7FF0D.font = "default";
  _id_94480E1669B7FF0D.glowcolor = (0.3, 0.6, 0.3);
  _id_94480E1669B7FF0D.glowalpha = 1;
  return _id_94480E1669B7FF0D;
}

teleport_text(player) {
  wait 2;
  _id_B6A3F1B59AACBB4E = player introscreen_corner_line(&"CP_BAD_SITUATION_OBJ/INTRO_LINE_1", 1);
  wait 1;
  _id_B6A3F0B59AACB91B = player introscreen_corner_line(&"CP_BAD_SITUATION_OBJ/INTRO_LINE_2", 2);
  wait 1;
  _id_B6A3EFB59AACB6E8 = player introscreen_corner_line(&"CP_BAD_SITUATION_OBJ/INTRO_LINE_3", 3);
  wait 1;
  _id_B6A3F6B59AACC64D = player introscreen_corner_line(&"CP_BAD_SITUATION_OBJ/INTRO_LINE_4", 4);
  wait 3.0;
  _id_B6A3F1B59AACBB4E fadeovertime(3);
  _id_B6A3F0B59AACB91B fadeovertime(3);
  _id_B6A3EFB59AACB6E8 fadeovertime(3);
  _id_B6A3F6B59AACC64D fadeovertime(3);
  _id_B6A3F1B59AACBB4E.alpha = 0;
  _id_B6A3F0B59AACB91B.alpha = 0;
  _id_B6A3EFB59AACB6E8.alpha = 0;
  _id_B6A3F6B59AACC64D.alpha = 0;
  _id_B6A3F1B59AACBB4E destroy();
  _id_B6A3F0B59AACB91B destroy();
  _id_B6A3EFB59AACB6E8 destroy();
  _id_B6A3F6B59AACC64D destroy();
}

spawn_blackscreen_func(player) {
  player endon("disconnect");
  player endon("stop_intro");
  player setclientomnvar("ui_hide_hud", 1);
  player disableweapons();
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0);
  player waittill("spawned_player");
  thread teleport_text(player);
  player scripts\cp\utility::freezecontrolswrapper(1);

  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  if(!scripts\engine\utility::flag("introscreen_over"))
    scripts\engine\utility::flag_wait("introscreen_over");

  wait 3;
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 5);
  player enableweapons();
  wait 0.2;
  player spawn_zoom_in_infill(player, 15000, 1.45);
  player setclientomnvar("ui_hide_hud", 0);
  player scripts\cp\utility::freezecontrolswrapper(0);
  level notify("player_on_ground");
}

spawn_zoom_in_infill(player, _id_8DA4E86D479CB292, _id_00F5E2FB5A015D34) {
  _id_309E9F390EE6D658 = (0, 0, _id_8DA4E86D479CB292);
  _id_DC2D44F988BF19F2 = _id_00F5E2FB5A015D34;
  _id_7B0CDF603FF08D31 = (0, 0, 180);
  _id_4E35DA98CCB4BE51 = 0;
  _id_90421BE5304F4C34 = 0.55;
  _id_349336C6178CEBEE = scripts\engine\utility::drop_to_ground(player.origin) + _id_309E9F390EE6D658;
  _id_E2EE67418550390B = player getEye() + _id_7B0CDF603FF08D31;
  _id_773CA68F3AA1799B = player getplayerangles();
  mover = spawn("script_model", _id_349336C6178CEBEE);
  mover setModel("tag_origin");
  mover.angles = vectortoangles((0, 0, -1));
  mover thread mover_clean_up(mover, player);
  player cameralinkTo(mover, "tag_origin");
  mover moveTo(_id_E2EE67418550390B, _id_DC2D44F988BF19F2, _id_4E35DA98CCB4BE51, _id_90421BE5304F4C34);
  mover waittill("movedone");
  mover delete();
  player cameraunlink();
}

mover_clean_up(mover, player) {
  mover endon("death");
  player waittill("disconnect");
  mover delete();
}

register_spawners() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  _id_18A73A64992DD07D::registerambientgroup("defense_sequence_spawners", 0, 24, undefined, [scripts\cp\cp_wave_spawning::module_wave_spawn, 15, 5, 0.1, 8, 24], 0, "defense_sequence_spawners", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("pre_hq_spawner", 0, 24, undefined, [scripts\cp\cp_wave_spawning::module_wave_spawn, 3], 0, "pre_hq_spawner", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("whiteph_spawner", 0, 12, undefined, [scripts\cp\cp_wave_spawning::module_wave_spawn, 20], 0, "whiteph_spawner", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("hq_targets", 4, 4, 4, 0.1, undefined, "hq_targets");
  _id_18A73A64992DD07D::registerambientgroup("jugg_wave", 0, 4, undefined, [scripts\cp\cp_wave_spawning::module_wave_spawn, 30, 90], 0, "jugg_wave", undefined, undefined, undefined);
  register_spawner_functions();
}

jugg_watcher(group) {
  _id_017232CEDE4FF8B5 = self;
  _id_017232CEDE4FF8B5._id_B4E73B5C37FE850F = 1;
  _id_017232CEDE4FF8B5.maxhealth = 1200;
  _id_017232CEDE4FF8B5.health = 1200;
  _id_017232CEDE4FF8B5 thread jugg_death_watcher_internal(_id_017232CEDE4FF8B5);
  _id_017232CEDE4FF8B5 thread jugg_damage_watcher_internal(_id_017232CEDE4FF8B5);
}

jugg_death_watcher_internal(_id_017232CEDE4FF8B5) {
  _id_017232CEDE4FF8B5 waittill("death");
  _id_2B7332F3AE7FC620(_id_017232CEDE4FF8B5);
  _id_017232CEDE4FF8B5._id_B4E73B5C37FE850F = 0;
}

jugg_damage_watcher_internal(_id_017232CEDE4FF8B5) {
  _id_017232CEDE4FF8B5 endon("death");
  _id_017232CEDE4FF8B5 waittill("damage");
}

disable_sprint() {
  self.sprint = undefined;
}

register_spawner_functions() {
  _id_18A73A64992DD07D::register_module_ai_spawn_func("jugg_wave", ::jugg_watcher);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("pre_hq_spawner", ::watch_for_retreat);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("whiteph_spawner", ::_id_4C2A4CA2FB2FE544);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("defense_sequence_spawners", ::_id_6DE7210EAB005B5F);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("hq_targets", ::remove_from_list_on_death);
}

_id_4C2A4CA2FB2FE544(group, dist, fov, _id_29F9E040EDCBFC76) {
  self endon("death");
  self setengagementmaxdist(32, 64);
  self.gasmaskequipped = 1;
  thread _id_752EE1BF7DC2EFCC();
  thread _id_0CFEAE9ABDC7F108();
}

_id_0CFEAE9ABDC7F108() {
  self endon("death");
}

_id_752EE1BF7DC2EFCC() {
  self waittill("death");

  if(!istrue(level._id_2C7C99983794A146))
    return;
}

_id_2B7332F3AE7FC620(_id_C19C9BE6C28F5EB3) {
  loc = undefined;

  if(isent(_id_C19C9BE6C28F5EB3))
    loc = _id_C19C9BE6C28F5EB3.origin;
  else {
    if(!isvector(_id_C19C9BE6C28F5EB3)) {
      return;
    }
    loc = _id_C19C9BE6C28F5EB3;
  }

  gasmask = scripts\cp\utility::createhintobject(loc, "HINT_BUTTON", "hud_icon_killstreak_juggernaut", &"CP_BAD_SITUATION_OBJ/EQUIP_GASMASK_FILTER", 5, "duration_short", "show", 200, undefined, 100, 360);
  gasmask setModel("hat_gasmask");
  gasmask thread _id_6C6A84DA134BD0A0();
  gasmask thread scripts\cp\utility::delayentdelete(30);
  level._id_8EA15099F566731C = scripts\engine\utility::array_add(level._id_8EA15099F566731C, gasmask);
}

_id_7B36128C239AB88A(_id_4D8D96D547DF2E9F) {
  gasmask = scripts\cp\utility::createhintobject(scripts\engine\utility::drop_to_ground(_id_4D8D96D547DF2E9F.vpoint), "HINT_BUTTON", "hud_icon_loot_helmet", &"CP_BAD_SITUATION_OBJ/EQUIP_GASMASK_FILTER", 5, "duration_short", "show", 200, undefined, 100, 360);
  gasmask setModel("hat_gasmask");
  gasmask thread _id_6C6A84DA134BD0A0();
  gasmask thread scripts\cp\utility::delayentdelete(30);
  level._id_8EA15099F566731C = scripts\engine\utility::array_add(level._id_8EA15099F566731C, gasmask);
}

_id_67EEDE7826377808(_id_4D8D96D547DF2E9F) {
  return 1;
}

_id_6C6A84DA134BD0A0() {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!istrue(player.gasmaskequipped)) {
      player.gasmaskhealth = 120;
      player thread scripts\cp_mp\gasmask::equipgasmask();
      player setclientomnvar("ui_head_equip_class", 2);
    } else {
      player playsoundtoplayer("scavenger_pack_pickup", player);
      player forceplaygestureviewmodel("ges_visor_down");
      player.gasmaskswapinprogress = 1;
      wait 0.338;
      player.gasmaskswapinprogress = 0;
      player iprintln(" ^7you added a ^1gas mask^7 filter! ");
      player.gasmaskhealth = player.gasmaskhealth + 30;
    }

    if(scripts\engine\utility::array_contains(level._id_8EA15099F566731C, self)) {
      level._id_8EA15099F566731C = scripts\engine\utility::array_remove(level._id_8EA15099F566731C, self);
      level._id_8EA15099F566731C = scripts\engine\utility::array_removeundefined(level._id_8EA15099F566731C);
    }

    self delete();
  }
}

watch_for_retreat(group, dist, fov, _id_29F9E040EDCBFC76) {
  self endon("death");
  level waittill("ai_rush");
  _id_18A73A64992DD07D::clear_script_origin_other_on_ai();
  level waittill("ai_retreat");
  _id_18A73A64992DD07D::set_script_origin_other_on_ai(scripts\engine\utility::getStruct("ai_retreat_point", "script_noteworthy").origin);
  _id_18A73A64992DD07D::go_to_node(scripts\engine\utility::getStruct("ai_retreat_point", "script_noteworthy").origin);
}

_id_6DE7210EAB005B5F(group, dist, fov, _id_29F9E040EDCBFC76) {
  self endon("death");

  if(!istrue(level._id_8FE051BB41E3E30E))
    level waittill("ai_retreat");

  _id_18A73A64992DD07D::clear_script_origin_other_on_ai();

  foreach(ai in getaiarray("axis")) {
    self.ignoreall = 1;
    _id_18A73A64992DD07D::set_script_origin_other_on_ai(scripts\engine\utility::getStruct("ai_retreat_point", "script_noteworthy").origin);
    _id_18A73A64992DD07D::go_to_node(scripts\engine\utility::getStruct("ai_retreat_point", "script_noteworthy").origin);
  }
}

remove_from_list_on_death(group) {
  if(!isDefined(level.hq_targets))
    level.hq_targets = [];

  level.hq_targets = scripts\engine\utility::array_add(level.hq_targets, self);
  thread watch_for_death();
}

watch_for_death() {
  self waittill("death");
  level.hq_targets = scripts\engine\utility::array_remove(level.hq_targets, self);

  if(level.hq_targets.size <= 0)
    level notify("eliminated_targets");
}

watch_for_spawners(group, dist, fov, _id_29F9E040EDCBFC76) {
  self endon("death");

  if(isDefined(self.group))
    self.group endon("weapons_free");

  thread jugg_watcher(group);
}

register_objectives() {}

_id_E7C086FF6543FD5F() {
  self notify("check_if_objective_point_is_in_front");
  self endon("check_if_objective_point_is_in_front");

  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0) {
    return;
  }
  if(isDefined(level.activequests)) {
    while(level.activequests.size == 0)
      waitframe();
  }

  if(!scripts\cp\cp_objectives::is_objective_active("find_base") && !scripts\cp\cp_objectives::is_objective_active("find_base_stealth") && !scripts\cp\cp_objectives::is_objective_active("stealth_nuke")) {
    return;
  }
  trigger = scripts\cp\cp_objectives::getobjectivestructfromref("find_base_stealth").trigger;

  if(!isDefined(trigger))
    trigger = scripts\cp\cp_objectives::getobjectivestructfromref("stealth_nuke").trigger;

  trigger thread _id_D31A32F0E8DEC377(self);
}

_id_D31A32F0E8DEC377(player) {
  self notify("players_behind_objective_point_" + player.name);
  self endon("players_behind_objective_point_" + player.name);
  self endon("point_crossed");
  player endon("disconnect");
  scripts\engine\utility::flag_wait("infil_complete");

  while(istrue(level.infil_in_progress_buffer))
    waitframe();

  while(!scripts\engine\math::is_point_in_front(player.origin))
    waitframe();

  level notify("point_crossed", self);
  self notify("point_crossed");
}

_id_26008E28EB163648(objectivestruct, _id_5DCDFD3A4EFF9961) {
  _id_7E1A468DA43087E3::_id_A9B8DD7261DE2FAD();
}

_id_F139D93EDBDF4C46(objectivestruct) {
  scripts\engine\utility::flag_wait("cp_bs_cs_completed");

  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    scripts\cp\utility::teleportallplayersinteamtostructs("allies", "bs_debug_spawners", 1);
  else if(!istrue(level._id_EFE609BCE901CAA8))
    scripts\cp\utility::teleportallplayersinteamtostructs("allies", "bs_spawner", 1);

  foreach(player in level.players)
  player scripts\cp\equipment\nvg::runnvg();
}

_id_77F141849D5CFC70(delay) {
  if(scripts\engine\utility::flag_exist("infil_complete"))
    scripts\engine\utility::flag_wait("infil_complete");

  wait(delay);

  if(_id_17CA3AF80F14CE7E::_id_5E1050E3208C8C06() && getdvarint("dvar_D289B247F3EFFC3F", 0)) {
    return;
  }
  if(isDefined(level._id_D0ADA23E81337306) && level._id_D0ADA23E81337306.size > 0) {
    if(!scripts\engine\utility::array_contains(level._id_D0ADA23E81337306, "barn"))
      return;
  } else {
    _id_18A73A64992DD07D::run_spawn_module("bs_sniper_spawner");
    _id_18A73A64992DD07D::run_spawn_module("bs_ar_spawner");
    _id_18A73A64992DD07D::run_spawn_module("bs_nomove_smoke");
    return;
  }
}

_id_111CC3C35CB7BBA2() {
  level.spawn_infil_lbravo = _id_7E1A468DA43087E3::spawn_infil_lbravo;
  level.lbravo_actorthinkpath = _id_7E1A468DA43087E3::lbravo_actor_keep_anim_loop;
}

addattachmenttoweapon(_id_DD515FCF025B2E79, _id_EFFB4AE1788A8B10) {
  if(_id_EFFB4AE1788A8B10 == "")
    return _id_DD515FCF025B2E79;

  variantid = getweaponvariantindex(_id_DD515FCF025B2E79);
  _id_DD515FCF025B2E79 = _id_DD515FCF025B2E79 getnoaltweapon();
  _id_91BBF8D2294A656E = _id_DD515FCF025B2E79.attachmentvarindices;
  attachments = [];

  foreach(attachment, id in _id_91BBF8D2294A656E)
  attachments[attachments.size] = attachment;

  failed = 0;

  if(scripts\engine\utility::array_contains(attachments, _id_EFFB4AE1788A8B10))
    failed = 1;
  else if(!_id_DD515FCF025B2E79 canuseattachment(_id_EFFB4AE1788A8B10))
    failed = 1;

  if(failed)
    return undefined;

  attachments = scripts\cp\utility::weaponattachremoveextraattachments(attachments, _id_DD515FCF025B2E79);
  _id_7809AD191E44FE6A = [];

  foreach(_id_FE8F7703F6313ED4, attachment in attachments)
  _id_7809AD191E44FE6A[_id_FE8F7703F6313ED4] = _id_91BBF8D2294A656E[attachment];

  attachments[attachments.size] = _id_EFFB4AE1788A8B10;
  _id_7809AD191E44FE6A[_id_7809AD191E44FE6A.size] = 0;
  camo = _id_DD515FCF025B2E79.camo;
  stickers = [];

  if(isDefined(_id_DD515FCF025B2E79.stickerslot0))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot0;

  if(isDefined(_id_DD515FCF025B2E79.stickerslot1))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot1;

  if(isDefined(_id_DD515FCF025B2E79.stickerslot2))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot2;

  if(isDefined(_id_DD515FCF025B2E79.stickerslot3))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot3;

  if(isDefined(_id_DD515FCF025B2E79._id_B39AC546CC8621F8))
    stickers[stickers.size] = _id_DD515FCF025B2E79._id_B39AC546CC8621F8;

  _id_11A1FA68AEB971C0 = scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4();
  _id_DD515FCF025B2E79 = _id_2669878CF5A1B6BC::buildweapon(_id_2669878CF5A1B6BC::getweaponrootname(_id_DD515FCF025B2E79), attachments, camo, "none", variantid, _id_7809AD191E44FE6A, undefined, stickers, _id_11A1FA68AEB971C0);
  return _id_DD515FCF025B2E79;
}

_id_B108188EDBFC1E04(weapon_obj) {
  attachment = "laserbox_ads02";

  switch (weapon_obj.classname) {
    case "mg":
      attachment = "laserbox_ads02";
      break;
    case "sniper":
      attachment = "laserbox_ads02";
      break;
    case "smg":
      attachment = "lasercyl_ads02";
      break;
    case "spread":
      attachment = "lasercyl_ads02";
      break;
    case "ar":
      attachment = "laserbox_ads02";
      break;
    case "rifle":
      attachment = "laserbox_ads02";
      break;
    case "pistol":
      attachment = "lasercyl_ads02";
      break;
  }

  if(weapon_obj.basename == "iw9_br_msecho_mp")
    return "";

  return attachment;
}

_id_13B2E016B1AB4103(weapon_obj) {
  attachment = "laserbox_ads02";

  switch (weapon_obj.classname) {
    case "mg":
      attachment = "holo03";
      break;
    case "sniper":
      attachment = "thermal02";
      break;
    case "smg":
      attachment = "reflex02_tall";
      break;
    case "spread":
      attachment = "reflex02_tall";
      break;
    case "ar":
      attachment = "holo03";
      break;
    case "rifle":
      attachment = "holo03";
      break;
    case "pistol":
      if(weapon_obj.basename == "iw9_pi_golf17_mp" || weapon_obj.basename == "iw9_pi_golf18_mp" || weapon_obj.basename == "iw9_pi_papa220_mp")
        attachment = "iw9_minireddot02_pstl";
      else
        attachment = "iw9_minireddot02";

      break;
  }

  if(weapon_obj.basename == "iw9_br_msecho_mp")
    attachment = "arscope_therm01_p01";

  return attachment;
}

_id_8119F212171548BF(weapon_name, spawn_origin, _id_E21A7BAA6BA10015, _id_FF18084BE23382C9) {
  if(getdvarint("dvar_D0FAC5BF433516F9", 1) != 0) {
    weapon_obj = scripts\engine\utility::random(level._id_0BCD25CD23011249);
    name = getcompleteweaponname(weapon_obj);
    weapon = spawn("weapon_" + name, spawn_origin);

    if(isDefined(weapon)) {
      weapon itemweaponsetammo(weaponclipsize(weapon), weaponclipsize(weapon));
      weapon.angles = _id_E21A7BAA6BA10015;
      _id_74502A9E0EF1F19C::add_to_weapon_array(weapon);
      weapon thread scripts\engine\utility::thread_on_notify_no_endon_death("death", _id_74502A9E0EF1F19C::remove_from_weapon_array);
    }

    return weapon;
  }

  weapon_obj = makeweaponfromstring(weapon_name);
  _id_61AF07BCB152B6CD = weapon_obj;
  attachment = "";

  if(istrue(_id_FF18084BE23382C9)) {
    attachment = _id_B108188EDBFC1E04(weapon_obj);
    weapon_obj = addattachmenttoweapon(weapon_obj, attachment);
  }

  if(!isDefined(weapon_obj)) {
    weapon_obj = _id_61AF07BCB152B6CD;
    iprintln("^2 classname unidentified for - Weapon - ^5" + weapon_obj.basename + "^2 and attachment - ^5" + attachment);
  }

  attachment = _id_13B2E016B1AB4103(weapon_obj);
  weapon_obj = addattachmenttoweapon(weapon_obj, attachment);

  if(!isDefined(weapon_obj)) {
    weapon_obj = _id_61AF07BCB152B6CD;
    iprintln("^2 classname unidentified for - Weapon - ^5" + weapon_obj.basename + "^2 and attachment - ^5" + attachment);
  }

  name = getcompleteweaponname(weapon_obj);
  weapon = spawn("weapon_" + name, spawn_origin);

  if(isDefined(weapon)) {
    if(scripts\cp\utility::is_wave_gametype())
      weapon itemweaponsetammo(weaponclipsize(weapon), 0);
    else
      weapon itemweaponsetammo(weaponclipsize(weapon), weaponclipsize(weapon));

    weapon.angles = _id_E21A7BAA6BA10015;
    _id_74502A9E0EF1F19C::add_to_weapon_array(weapon);
    weapon thread scripts\engine\utility::thread_on_notify_no_endon_death("death", _id_74502A9E0EF1F19C::remove_from_weapon_array);
  }

  return weapon;
}

play_intro_hacking_vo() {
  cypher_vo_intro();
}

hacking_vo() {
  level endon("game_ended");

  while(!isDefined(level.hack_progress))
    wait 0.1;

  while(istrue(level.dialogue_playing))
    wait 0.1;

  while(level.hack_progress < 0.4)
    wait 0.1;

  cypher_vo_hack_progress(1);

  while(level.hack_progress < 0.6)
    wait 0.1;

  cypher_vo_hack_progress(2);

  while(level.hack_progress < 0.8)
    wait 0.1;

  cypher_vo_hack_progress(3);
}

choose_and_play_vo_from_array(_id_0EFE1C4B2620F108) {
  _id_0613CED62214DEE0 = scripts\engine\utility::random(_id_0EFE1C4B2620F108);
  scripts\cp\cp_dialogue::play_vo_to_all(_id_0613CED62214DEE0);
}

cypher_vo_intro() {
  wait 1;
  _id_A0E3C424652DC79B = ["dx_cps_cyph_cypher_hack_intro_10", "dx_cps_cyph_cypher_hack_intro_20", "dx_cps_cyph_cypher_hack_intro_30"];
  choose_and_play_vo_from_array(_id_A0E3C424652DC79B);
  wait 1;
  _id_A0E3C424652DC79B = ["dx_cps_cyph_cypher_connection_good_10", "dx_cps_cyph_cypher_connection_good_20", "dx_cps_cyph_cypher_connection_good_30"];
  choose_and_play_vo_from_array(_id_A0E3C424652DC79B);
}

cypher_vo_hack_progress(_id_EEEEF9F0015C63DD) {
  while(istrue(level.dialogue_playing))
    wait 0.1;

  switch (_id_EEEEF9F0015C63DD) {
    case 1:
      _id_0613CED62214DEE0 = "dx_cps_cyph_cypher_connection_stable_10";
      scripts\cp\cp_dialogue::play_vo_to_all(_id_0613CED62214DEE0);
      break;
    case 2:
      _id_0613CED62214DEE0 = "dx_cps_cyph_cypher_connection_stable_20";
      scripts\cp\cp_dialogue::play_vo_to_all(_id_0613CED62214DEE0);
      wait 0.5;
      _id_0613CED62214DEE0 = "dx_cps_kama_cypher_connection_stable_30";
      scripts\cp\cp_dialogue::play_vo_to_all(_id_0613CED62214DEE0);
      break;
    case 3:
      _id_0613CED62214DEE0 = "dx_cps_cyph_cypher_connection_stable_40";
      scripts\cp\cp_dialogue::play_vo_to_all(_id_0613CED62214DEE0);
      wait 0.5;
      _id_0613CED62214DEE0 = "dx_cps_lass_cypher_connection_stable_50";
      scripts\cp\cp_dialogue::play_vo_to_all(_id_0613CED62214DEE0);
      break;
    default:
      break;
  }
}

cypher_vo_complete() {
  scripts\cp\utility::play_music_to_team("");
  _id_A0E3C424652DC79B = ["dx_cps_cyph_cypher_connection_complete_shut_out_10", "dx_cps_cyph_cypher_connection_complete_shut_out_20", "dx_cps_cyph_cypher_connection_complete_shut_out_30"];
  choose_and_play_vo_from_array(_id_A0E3C424652DC79B);
  wait 5;
  _id_A0E3C424652DC79B = ["dx_cps_cyph_cypher_connection_complete_intel_10", "dx_cps_cyph_cypher_connection_complete_intel_20", "dx_cps_cyph_cypher_connection_complete_intel_30"];
  choose_and_play_vo_from_array(_id_A0E3C424652DC79B);
  wait 5;
  _id_0613CED62214DEE0 = "dx_cps_cyph_ml_p3_multihack_transfer_complete_10";
  scripts\cp\cp_dialogue::play_vo_to_all(_id_0613CED62214DEE0);
  wait 1;
  _id_0613CED62214DEE0 = "dx_cps_lass_ml_p3_multihack_transfer_complete_20";
  scripts\cp\cp_dialogue::play_vo_to_all(_id_0613CED62214DEE0);
}

cypher_signal_strength_nag(_id_E110CA14349454DF) {
  switch (_id_E110CA14349454DF) {
    case 0:
      _id_A0E3C424652DC79B = ["dx_cps_cyph_cypher_connection_lost_10", "dx_cps_cyph_cypher_connection_lost_20", "dx_cps_cyph_cypher_connection_lost_30"];
      choose_and_play_vo_from_array(_id_A0E3C424652DC79B);
    case 1:
      _id_0613CED62214DEE0 = "dx_cps_cyph_cypher_connection_1p_10";
      scripts\cp\cp_dialogue::play_vo_to_all(_id_0613CED62214DEE0);
      break;
    case 2:
      _id_0613CED62214DEE0 = "dx_cps_cyph_cypher_connection_2p_10";
      scripts\cp\cp_dialogue::play_vo_to_all(_id_0613CED62214DEE0);
      break;
    case 3:
      _id_0613CED62214DEE0 = "dx_cps_cyph_cypher_connection_3p_10";
      scripts\cp\cp_dialogue::play_vo_to_all(_id_0613CED62214DEE0);
      break;
    case 4:
      _id_0613CED62214DEE0 = "dx_cps_cyph_cypher_connection_4p_10";
      scripts\cp\cp_dialogue::play_vo_to_all(_id_0613CED62214DEE0);
      break;
    default:
      break;
  }
}

start_hack() {
  level thread monitor_hack_prox(self);
  level thread scripts\cp\cp_hacking::hacking_init();
  level thread scripts\cp\cp_hacking::hacking_objective_time();
  self makeunusable();
  level waittill("cpu_hacking_done");
  level._id_4CC283D9F7D02582++;

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);

    self.minimapid = undefined;
  }

  level.pers["completed_hack_locations"] = scripts\engine\utility::array_add(level.pers["completed_hack_locations"], self.script_noteworthy);

  foreach(_id_BD7FB8118E07DB19 in level._id_B374F5AE2459BB1B) {
    if(_id_BD7FB8118E07DB19.script_noteworthy == self.script_noteworthy) {
      if(_id_BD7FB8118E07DB19.headicon)
        scripts\cp\utility::ent_deleteheadicon(_id_BD7FB8118E07DB19, _id_BD7FB8118E07DB19.headicon);
    }
  }

  if(isDefined(level._id_04EDBFB792D36B24[level._id_4CC283D9F7D02582])) {
    foreach(_id_BD7FB8118E07DB19 in level._id_B374F5AE2459BB1B) {
      if(self == _id_BD7FB8118E07DB19) {
        continue;
      }
      if(_id_BD7FB8118E07DB19.script_noteworthy == level._id_04EDBFB792D36B24[level._id_4CC283D9F7D02582]) {
        switch (_id_BD7FB8118E07DB19.script_noteworthy) {
          case "barn_hack":
            scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_trap");
            break;
          case "town_hack":
            _id_742F61B6768A1AAB::_id_8BFF9A0F28C4A5C8(["bs_sniper_spawner", "bs_ar_spawner", "bs_nomove_smoke"]);
            _id_18A73A64992DD07D::run_spawn_module("bs_town_stealth");
            scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_town");
            break;
          case "farm_hack":
            _id_742F61B6768A1AAB::_id_8BFF9A0F28C4A5C8(["bs_town_stealth"]);
            _id_18A73A64992DD07D::stop_module_by_groupname("bs_town_stealth");
            _id_18A73A64992DD07D::run_spawn_module("bs_farm_stealth");
            scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_farms");
            break;
        }

        _id_BD7FB8118E07DB19.headicon = scripts\cp\utility::ent_createheadicon(_id_BD7FB8118E07DB19, 69, "allies", "hud_icon_head_equipment_friendly", 1);
        setheadiconmaxdistance(_id_BD7FB8118E07DB19.headicon, 10000);
        setheadiconsnaptoedges(_id_BD7FB8118E07DB19.headicon, 1);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
          _id_BD7FB8118E07DB19.minimapid = _id_BD7FB8118E07DB19[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("hud_icon_head_equipment_friendly", "allies", 1, 1, 0);

        level.hacks_started = 0;
        _id_BD7FB8118E07DB19 makeusable();
        _id_BD7FB8118E07DB19 setHintString(&"CP_BAD_SITUATION_OBJ/HACK_USB");
        _id_BD7FB8118E07DB19 sethintdisplayrange(400);
        _id_BD7FB8118E07DB19 sethintdisplayfov(360);
        _id_BD7FB8118E07DB19 setusefov(120);
        _id_BD7FB8118E07DB19 setuserange(120);
        _id_BD7FB8118E07DB19 sethintonobstruction("show");
        _id_BD7FB8118E07DB19 thread play_usb_anims();
      }
    }
  } else {
    _id_18A73A64992DD07D::run_spawn_module("bs_exfil_stealth");
    _id_18A73A64992DD07D::run_spawn_module("jugg_patrol_exfil");
  }
}

monitor_hack_prox(ent) {
  level endon("game_ended");
  level endon("cpu_hacking_done");
  dist = 250;
  _id_ABD9EE4725B96FC2 = dist * dist;
  _id_07C53D78252C061A = getEntArray(ent.struct.script_noteworthy, "script_noteworthy");
  _id_424F5513ECF68621 = gettime() + 15000;

  for(;;) {
    _id_98EA5AFB293A76A2 = 0;

    foreach(_id_13D8A8207F624B0D in _id_07C53D78252C061A) {
      _id_13D8A8207F624B0D.num_hackers = 0;

      foreach(player in level.players) {
        if(distancesquared(player.origin, _id_13D8A8207F624B0D.origin) < _id_ABD9EE4725B96FC2) {
          _id_98EA5AFB293A76A2++;
          _id_13D8A8207F624B0D.num_hackers++;
        }
      }
    }

    paused = 0;

    foreach(_id_13D8A8207F624B0D in _id_07C53D78252C061A) {
      if(level.players.size > 1) {
        if(_id_13D8A8207F624B0D.num_hackers == 0) {
          paused = 1;
          break;
        }
      }
    }

    setomnvar("cpu_hacking_signal", _id_98EA5AFB293A76A2);
    level.hacking_paused = paused;
    level.hack_multiplier = 1 + _id_98EA5AFB293A76A2 * 0.25;

    if(gettime() > _id_424F5513ECF68621) {
      _id_424F5513ECF68621 = _id_424F5513ECF68621 + 15000;
      _id_F17165386D606706 = int(max(0, _id_98EA5AFB293A76A2 - 1));

      if(_id_98EA5AFB293A76A2 == 0)
        level thread cypher_signal_strength_nag(_id_F17165386D606706);
    }

    waitframe();
  }
}

_id_554FE9C26B47DB53() {
  _id_7E1A468DA43087E3::init_usb_animations();
  level._id_B374F5AE2459BB1B = getEntArray("usb_hack", "targetname");

  if(!isDefined(level._id_4CC283D9F7D02582))
    level._id_4CC283D9F7D02582 = 0;

  if(!isDefined(level.hacks_started))
    level.hacks_started = 0;

  level._id_04EDBFB792D36B24 = ["barn_hack", "town_hack", "farm_hack"];

  if(!isDefined(level.pers))
    level.pers = [];

  if(!isDefined(level.pers["completed_hack_locations"]))
    level.pers["completed_hack_locations"] = [];

  level._id_4CC283D9F7D02582 = level.pers["completed_hack_locations"].size;

  foreach(_id_BD7FB8118E07DB19 in level._id_B374F5AE2459BB1B) {
    if(isDefined(level.pers["completed_hack_locations"]) && level.pers["completed_hack_locations"].size > 0) {
      if(scripts\engine\utility::array_contains(level.pers["completed_hack_locations"], _id_BD7FB8118E07DB19.script_noteworthy))
        continue;
    }

    _id_BD7FB8118E07DB19 makeusable();
    _id_BD7FB8118E07DB19 setHintString(&"CP_BAD_SITUATION_OBJ/HACK_USB");
    _id_BD7FB8118E07DB19 sethintdisplayrange(400);
    _id_BD7FB8118E07DB19 sethintdisplayfov(360);
    _id_BD7FB8118E07DB19 setusefov(360);
    _id_BD7FB8118E07DB19 setuserange(84);
    _id_BD7FB8118E07DB19 sethintonobstruction("show");

    if(_id_BD7FB8118E07DB19.script_noteworthy == level._id_04EDBFB792D36B24[level._id_4CC283D9F7D02582]) {
      switch (_id_BD7FB8118E07DB19.script_noteworthy) {
        case "barn_hack":
          scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_trap");
          break;
        case "town_hack":
          scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_town");
          break;
        case "farm_hack":
          scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_farms");
          break;
      }

      _id_BD7FB8118E07DB19 makeusable();
      _id_BD7FB8118E07DB19.headicon = scripts\cp\utility::ent_createheadicon(_id_BD7FB8118E07DB19, 69, "allies", "hud_icon_head_equipment_friendly", 1);
      setheadiconmaxdistance(_id_BD7FB8118E07DB19.headicon, 10000);
      setheadiconsnaptoedges(_id_BD7FB8118E07DB19.headicon, 1);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
        _id_BD7FB8118E07DB19.minimapid = _id_BD7FB8118E07DB19[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("hud_icon_head_equipment_friendly", "allies", 1, 1, 0);

      _id_BD7FB8118E07DB19 thread play_usb_anims();
    }
  }
}

play_usb_anims() {
  self notify("play_usb_anims");
  self endon("play_usb_anims");
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    self setHintString("");
    level.hack_duration = getdvarint("dvar_ECD8459271BDEAF7", 15);
    level.hack_duration = level.hack_duration * (level._id_4CC283D9F7D02582 + 1);
    player playlocalsound("cp_generic_placement");
    level.hacks_started++;

    if(level.hacks_started >= 2)
      thread start_hack();
    else {
      self makeunusable();
      continue;
    }

    break;
  }
}

_id_540DC79FE32B91BF(objectivestruct, _id_5DCDFD3A4EFF9961) {
  _id_742F61B6768A1AAB::_id_8BFF9A0F28C4A5C8(["bs_sniper_spawner", "bs_ar_spawner", "bs_nomove_smoke"]);

  while(level._id_4CC283D9F7D02582 == 0)
    waitframe();

  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0) {
    return;
  }
  level thread _id_59676E50BB5CE458();
  thread _id_C3D83BC301ACCD84();
  return;
}

_id_59676E50BB5CE458() {}

_id_C3D83BC301ACCD84() {
  level endon("game_ended");
  level scripts\engine\utility::waittill_any_timeout_1(level.hack_duration, "smokeshow_done");
  _id_D93FDA51690DB1C7();
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/PRICE_REALIZATION");
  scripts\cp\utility::play_music_to_team("mus_cp_landlord_juggernaut");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/PRICE_WARN_1");
  _id_18A73A64992DD07D::run_spawn_module("jugg_spawn_aj");

  foreach(ai in getaiarray()) {
    if(ai _id_18A73A64992DD07D::is_specified_unittype("juggernaut")) {
      continue;
    }
    event = spawnStruct();
    event.entity = scripts\engine\utility::random(scripts\cp\coop_stealth::get_players_not_in_laststand());
    event.investigate_pos = event.entity.origin;

    if(isDefined(event.entity)) {
      ai scripts\cp\coop_stealth::_id_BE21052E355EAC6A(event.entity.origin);
      continue;
    }

    event.entity = getEnt("jugg_circle_trigger", "targetname");
    event.investigate_pos = event.entity.origin;
    ai scripts\cp\coop_stealth::_id_BE21052E355EAC6A(event.investigate_pos);
  }

  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/STANDBY_PRICE");
  objective_setlocation(scripts\cp\cp_objectives::getobjectivestructfromref("escape_hotzone").objectiveindex, 0, getEnt("escape_hotzone", "script_noteworthy").origin);
  objective_state(scripts\cp\cp_objectives::getobjectivestructfromref("escape_hotzone").objectiveindex, "current");
  objective_setlabel(scripts\cp\cp_objectives::getobjectivestructfromref("escape_hotzone").objectiveindex, &"CP_BAD_SITUATION_OBJ/ESCAPE_HOTZONE");
}

_id_A1972074B161171C(objectivestruct, _id_5DCDFD3A4EFF9961) {
  _id_7E1A468DA43087E3::_id_A9B8DD7261DE2FAD();
}

_id_B06CA525333A9E9E(objectivestruct) {
  scripts\engine\utility::flag_wait("cp_bs_cs_completed");
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp\equipment\nvg::runnvg);
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(_id_7E1A468DA43087E3::_id_7CD97A856163B260);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "bs_spawner_trap", 1);

  foreach(player in level.players)
  player scripts\cp\equipment\nvg::runnvg();
}

_id_087952DCC072F33B() {
  _id_B680C9C22BFBFD14();
}

_id_752213D579CDECED(objectivestruct, _id_5DCDFD3A4EFF9961) {
  objectivestruct.trigger = getEnt(objectivestruct.objname, "script_noteworthy");
  level._id_1CBECB12F3EC3970 = 1;
}

_id_41439EAA625F2E01(objectivestruct, _id_5DCDFD3A4EFF9961) {
  _id_18A73A64992DD07D::stop_all_groups();
  _id_18A73A64992DD07D::stop_module_by_groupname("bs_ar_spawner_trap");
  _id_18A73A64992DD07D::stop_module_by_groupname("bs_nomove_smoke_trap");
  _id_18A73A64992DD07D::stop_module_by_groupname("bs_barn_patrol");
  _id_18A73A64992DD07D::stop_module_by_groupname("bs_barn_outer_patrol");
  _id_18A73A64992DD07D::stop_module_by_groupname("bs_nomove_barn");
  _id_742F61B6768A1AAB::_id_8BFF9A0F28C4A5C8(["bs_sniper_spawner", "bs_ar_spawner", "bs_nomove_smoke"]);
  _id_06A9D4676AB8FC39 = getEnt("pre_escape_hotzone", "script_noteworthy");

  foreach(player in level.players)
  _id_06A9D4676AB8FC39 thread _id_D31A32F0E8DEC377(player);

  level thread _id_A8D880D2F24FC506();
  objectivestruct.trigger _id_7E1A468DA43087E3::watch_for_objective_reached();
}

_id_A8D880D2F24FC506() {
  level waittill("point_crossed");
  _id_742F61B6768A1AAB::_id_8BFF9A0F28C4A5C8(["bs_ar_spawner_trap", "bs_nomove_smoke_trap", "bs_barn_patrol", "bs_barn_outer_patrol", "bs_nomove_barn"]);
  _id_18A73A64992DD07D::run_spawn_module("bs_shotgun_spawner");
  _id_18A73A64992DD07D::run_spawn_module("bs_smg_spawner");
  level thread _id_20EE1F71340AA5B8();
}

_id_20EE1F71340AA5B8() {
  level endon("end_periodic_ai_hunt");
  level notify("periodically_set_ai_on_player");
  level endon("periodically_set_ai_on_player");

  for(;;) {
    wait 5;

    foreach(ai in getaiarray("axis")) {
      if(ai.group.group_name == "bs_ar_spawner_trap" || ai.group.group_name == "bs_nomove_smoke_trap" || ai.group.group_name == "bs_barn_patrol" || ai.group.group_name == "bs_barn_outer_patrol" || ai.group.group_name == "bs_nomove_barn") {
        _id_934F2BD9F0E5C04B = ai _id_18A73A64992DD07D::get_see_recently_time_overrides();
        _id_99189C9718781C5D = 2890000;

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
          _id_678A0776298909D1 = level.players[_id_AC0E594AC96AA3A8];

          if(distancesquared(_id_678A0776298909D1.origin, ai.origin) < _id_99189C9718781C5D) {
            event = spawnStruct();
            event.entity = scripts\engine\utility::random(scripts\cp\coop_stealth::get_players_not_in_laststand());
            event.investigate_pos = event.entity.origin;

            if(isDefined(event.entity))
              ai scripts\cp\coop_stealth::_id_BE21052E355EAC6A(event.entity.origin);

            continue;
          }

          if(ai seerecently(_id_678A0776298909D1, _id_934F2BD9F0E5C04B)) {
            event = spawnStruct();
            event.entity = scripts\engine\utility::random(scripts\cp\coop_stealth::get_players_not_in_laststand());
            event.investigate_pos = event.entity.origin;

            if(isDefined(event.entity))
              ai scripts\cp\coop_stealth::_id_BE21052E355EAC6A(event.entity.origin);

            continue;
          }
        }

        ai _id_7E1A468DA43087E3::delete_ai();
        continue;
      }

      if(ai _id_18A73A64992DD07D::is_specified_unittype("juggernaut")) {
        _id_934F2BD9F0E5C04B = ai _id_18A73A64992DD07D::get_see_recently_time_overrides();
        _id_99189C9718781C5D = 100000000;

        if(istrue(ai.is_outlined_from_scoperadar)) {
          event = spawnStruct();
          event.entity = scripts\engine\utility::random(scripts\cp\coop_stealth::get_players_not_in_laststand());
          event.investigate_pos = event.entity.origin;

          if(isDefined(event.entity))
            ai scripts\cp\coop_stealth::_id_BE21052E355EAC6A(event.entity.origin);

          continue;
        }

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
          _id_678A0776298909D1 = level.players[_id_AC0E594AC96AA3A8];

          if(distancesquared(_id_678A0776298909D1.origin, ai.origin) < _id_99189C9718781C5D) {
            event = spawnStruct();
            event.entity = scripts\engine\utility::random(scripts\cp\coop_stealth::get_players_not_in_laststand());
            event.investigate_pos = event.entity.origin;

            if(isDefined(event.entity))
              continue;
          }

          if(ai seerecently(_id_678A0776298909D1, _id_934F2BD9F0E5C04B)) {
            event = spawnStruct();
            event.entity = scripts\engine\utility::random(scripts\cp\coop_stealth::get_players_not_in_laststand());
            event.investigate_pos = event.entity.origin;

            if(isDefined(event.entity))
              ai scripts\cp\coop_stealth::_id_BE21052E355EAC6A(event.entity.origin);

            continue;
          }
        }

        ai _id_7E1A468DA43087E3::delete_ai();
        continue;
      }

      event = spawnStruct();
      event.entity = scripts\engine\utility::random(scripts\cp\coop_stealth::get_players_not_in_laststand());
      event.investigate_pos = event.entity.origin;

      if(isDefined(event.entity))
        ai scripts\cp\coop_stealth::_id_BE21052E355EAC6A(event.entity.origin);
    }
  }
}

_id_60F630AC4ACC0366(objectivestruct, _id_5DCDFD3A4EFF9961) {
  _id_7E1A468DA43087E3::_id_A9B8DD7261DE2FAD();
}

_id_7FA26152E40242A0(objectivestruct) {
  scripts\engine\utility::flag_wait("cp_bs_cs_completed");
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp\equipment\nvg::runnvg);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "bs_spawner_trap", 1);

  foreach(player in level.players)
  player scripts\cp\equipment\nvg::runnvg();
}

init_exfil(objectivestruct, _id_5DCDFD3A4EFF9961) {
  thread outro_main();
  objectivestruct.trigger = getEnt(objectivestruct.objname, "script_noteworthy");
  level notify("end_periodic_ai_hunt");
  _id_18A73A64992DD07D::stop_all_groups();
  event = spawnStruct();
  event.entity = scripts\engine\utility::random(scripts\cp\coop_stealth::get_players_not_in_laststand());
  event.investigate_pos = event.entity.origin;

  foreach(ai in getaiarray("axis")) {
    if(!ai _id_18A73A64992DD07D::is_specified_unittype("juggernaut")) {
      ai scripts\cp\coop_stealth::_id_BE21052E355EAC6A(event.entity.origin);
      continue;
    }

    ai _id_7E1A468DA43087E3::delete_ai();
  }
}

_id_1BA5516CB29B671F() {
  level waittill("point_crossed");
  _id_742F61B6768A1AAB::_id_8BFF9A0F28C4A5C8(["bs_ar_spawner_trap", "bs_nomove_smoke_trap", "bs_barn_patrol", "bs_barn_outer_patrol", "bs_nomove_barn"]);
  _id_B272B0FF03EF37D6 = 6.0;
  _id_AAFB47C968E733BC = 0.5;
  _id_AAD835C968C0C46E = 1.0;
  _id_0036743E75FE4A30 = scripts\engine\utility::getStructArray("smoke_end_struct", "targetname");

  foreach(_id_D0697AF2ECA83D63 in _id_0036743E75FE4A30) {
    magicgrenademanual("smoke_grenade_mp", _id_D0697AF2ECA83D63.origin, (0, 0, 4), 0.05);
    _id_3D5486C42744F400 = randomfloatrange(_id_AAFB47C968E733BC, _id_AAD835C968C0C46E);
    wait(_id_3D5486C42744F400);
  }

  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_riotshield");
  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_rpg");
  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_lmg");
  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_shotgun");
  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_jugg");
}

_id_DD6C0BDEEADF7282() {
  wait 3;
  _id_742F61B6768A1AAB::_id_8BFF9A0F28C4A5C8();
  _id_B272B0FF03EF37D6 = 6.0;
  _id_AAFB47C968E733BC = 0.5;
  _id_AAD835C968C0C46E = 1.0;
  _id_0036743E75FE4A30 = scripts\engine\utility::getStructArray("smoke_end_struct", "targetname");

  foreach(_id_D0697AF2ECA83D63 in _id_0036743E75FE4A30) {
    magicgrenademanual("smoke_grenade_mp", _id_D0697AF2ECA83D63.origin, (0, 0, 4), 0.05);
    _id_3D5486C42744F400 = randomfloatrange(_id_AAFB47C968E733BC, _id_AAD835C968C0C46E);
    wait(_id_3D5486C42744F400);
  }

  _id_18A73A64992DD07D::run_spawn_module("exfil_jugg_spawn_aj");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/FINAL_CIRCLE");
}

_id_B0F6D6910F3B8AF8(objectivestruct, _id_5DCDFD3A4EFF9961) {
  _id_06A9D4676AB8FC39 = getEnt("pre_escape_hotzone", "script_noteworthy");

  foreach(player in level.players)
  _id_06A9D4676AB8FC39 thread _id_D31A32F0E8DEC377(player);

  level thread _id_1BA5516CB29B671F();
  _id_0068F19FB1867B29 = ["bs_exfil_riotshield", "bs_exfil_rpg", "bs_exfil_lmg", "bs_exfil_shotgun", "bs_exfil_jugg"];
  _id_699487ED1D1975AE(_id_0068F19FB1867B29);
  scripts\engine\utility::flag_wait("leave_lz");
}

_id_699487ED1D1975AE(_id_F30E1EFD91C51050) {
  _id_B272B0FF03EF37D6 = 6.0;
  _id_AAFB47C968E733BC = 0.5;
  _id_AAD835C968C0C46E = 1.0;
  _id_0036743E75FE4A30 = scripts\engine\utility::getStructArray("smoke_end_struct", "targetname");

  foreach(_id_D0697AF2ECA83D63 in _id_0036743E75FE4A30) {
    magicgrenademanual("smoke_grenade_mp", _id_D0697AF2ECA83D63.origin, (0, 0, 4), 0.05);
    _id_3D5486C42744F400 = randomfloatrange(_id_AAFB47C968E733BC, _id_AAD835C968C0C46E);
    wait(_id_3D5486C42744F400);
  }

  wait(_id_B272B0FF03EF37D6 / 2);

  if(isDefined(_id_F30E1EFD91C51050) && isarray(_id_F30E1EFD91C51050)) {
    foreach(spawngroup in _id_F30E1EFD91C51050) {
      if(isstring(spawngroup))
        _id_18A73A64992DD07D::run_spawn_module(spawngroup);
    }
  }

  wait(_id_B272B0FF03EF37D6 / 2);
  thread _id_7E1A468DA43087E3::round_smoke_semtex_logic();
  _id_16AFEDF5D85F5E8A = [0, 40, 60, 70, 80];
  _id_23A5989C66B1813D = _id_16AFEDF5D85F5E8A[level.players.size];
  wait 90;
  _id_18A73A64992DD07D::stop_all_groups();

  while(getaiarray("axis").size > 0)
    waitframe();

  level notify("kill_semtex_thread");
  _id_18A73A64992DD07D::stop_all_groups();
}

outro_main(objectiveindex) {
  waitframe();
  _id_CBD652D85EF24B68 = getEnt("exfil_vehicle_spawn_trigger_chopper", "targetname");

  if(isDefined(_id_CBD652D85EF24B68))
    _id_3F36F922FAC89B88::_id_611022CAB305A8F5(_id_CBD652D85EF24B68);

  thread _id_E7821D148B952625();
  _id_B71257DB9933DF4E(objectiveindex);
}

_id_F7742F5B4F816B4B(_id_57C09087194B74FC) {
  level endon("both_players_entered_lz");
  level notify("timer_watchForTimerEnd");
  level endon("timer_watchForTimerEnd");
  scripts\engine\utility::flag_wait("exfil_lz_heli_vo_done");
  scripts\engine\utility::flag_wait("lz_heli_landing_vo_done");
  timer = 60;
  level thread scripts\cp\utility::objective_update("exfil_area", timer, int(timer / 2), int(timer / 3), 1);
  level._id_C8C5462D20FBD92C = [];
  level._id_C8C5462D20FBD92C["dx_cp_cphy_rche_lasw_thirtyseconds"] = 0;
  level._id_C8C5462D20FBD92C["dx_cp_cphy_rche_lasw_twentysecondsletsgo"] = 0;
  level._id_C8C5462D20FBD92C["dx_cp_cphy_rche_lasw_tensecondsbreakersmo"] = 0;
  level._id_C8C5462D20FBD92C["dx_cp_cphy_rche_lasw_fivesecondslastchanc"] = 0;
  thread _id_7E1A468DA43087E3::_id_DF4629AF9E490831();

  for(;;) {
    timer--;
    wait 1;

    if(timer >= 29 && timer <= 31) {
      level notify("vo_watchForPlayersLingeringNearTheExfil");

      if(istrue(level._id_C8C5462D20FBD92C["dx_cp_cphy_rche_lasw_thirtyseconds"])) {
        continue;
      }
      thread _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_rche_lasw_thirtyseconds");
      level._id_C8C5462D20FBD92C["dx_cp_cphy_rche_lasw_thirtyseconds"] = 1;
    }

    if(timer >= 19 && timer <= 21) {
      level notify("vo_watchForPlayersLingeringNearTheExfil");

      if(istrue(level._id_C8C5462D20FBD92C["dx_cp_cphy_rche_lasw_twentysecondsletsgo"])) {
        continue;
      }
      thread _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_rche_lasw_twentysecondsletsgo");
      level._id_C8C5462D20FBD92C["dx_cp_cphy_rche_lasw_twentysecondsletsgo"] = 1;
    }

    if(timer >= 9 && timer <= 11) {
      level notify("vo_watchForPlayersLingeringNearTheExfil");

      if(istrue(level._id_C8C5462D20FBD92C["dx_cp_cphy_rche_lasw_tensecondsbreakersmo"])) {
        continue;
      }
      thread _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_rche_lasw_tensecondsbreakersmo");
      level._id_C8C5462D20FBD92C["dx_cp_cphy_rche_lasw_tensecondsbreakersmo"] = 1;
    }

    if(timer >= 0 && timer <= 6) {
      level notify("vo_watchForPlayersLingeringNearTheExfil");

      if(istrue(level._id_C8C5462D20FBD92C["dx_cp_cphy_rche_lasw_fivesecondslastchanc"])) {
        continue;
      }
      thread _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_rche_lasw_fivesecondslastchanc");
      level._id_C8C5462D20FBD92C["dx_cp_cphy_rche_lasw_fivesecondslastchanc"] = 1;
    }

    if(timer <= 0) {
      break;
    }
  }

  level notify("kill_exfil_dialogues");
  _id_D21F9FA011E13A44 = scripts\engine\utility::getStruct("heli_landing_zone_take_off", "targetname");
  level._id_DF588BF29C7FF9BC notify("cancel_flight");
  level._id_DF588BF29C7FF9BC notify("kill_completion_thread");
  level._id_DF588BF29C7FF9BC _id_0E80538EF14D00E1::create_simple_path(_id_D21F9FA011E13A44, level._id_DF588BF29C7FF9BC.angles, 1, "hydro_exfil_takeoff");
  level._id_DF588BF29C7FF9BC vehicle_setspeed(25, 5, 5);
  level._id_DF588BF29C7FF9BC thread _id_91AAF446346613DA(level._id_DF588BF29C7FF9BC.pathing_array);
  level._id_DF588BF29C7FF9BC.vehiclename = "chopper_support";
  level._id_DF588BF29C7FF9BC.streakname = "chopper_support";
  thread _id_7E1A468DA43087E3::_id_A990CCB6B2523CB3();
  wait 15;
  level thread[[level.endgame]]("axis", level.end_game_string_index["fail"]);
}

_id_E7821D148B952625() {
  level notify("start_reinforcements_loop");
  level endon("start_reinforcements_loop");
  level endon("game_ended");
  wait 45;

  for(;;) {
    thread _id_51023E7DB5068D92::_id_4E0244F0C1AB5067();
    wait 120;
  }
}

_id_B71257DB9933DF4E(objectiveindex) {
  level endon("game_ended");
  thread _id_3F36F922FAC89B88::_id_A55CAC62F5E2873E(120);
  _id_EA0FBAC82EEC8FC1 = scripts\engine\utility::getStruct("exfil_heli_spawner_updated", "targetname");
  _id_EA0FBAC82EEC8FC1.vehicletype = "mindia8_cp";
  _id_EA0FBAC82EEC8FC1.classname_mp = "script_vehicle_iw8_mindia8";
  _id_EA0FBAC82EEC8FC1.modelname = "veh9_mil_air_heli_palfa_doors_open_vehphys_mp";
  _id_EA0FBAC82EEC8FC1.targetname = "veh9_palfa";
  heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(level.players[0], _id_EA0FBAC82EEC8FC1.origin, _id_EA0FBAC82EEC8FC1.angles, "mindia8_cp", "veh9_mil_air_heli_palfa_doors_open_vehphys_mp");
  heli.classname_mp = "script_vehicle_iw8_mindia8";
  thread scripts\common\vehicle_paths::gopath(heli);
  _id_A0EEC69077D8135E = scripts\engine\utility::getStruct(_id_EA0FBAC82EEC8FC1.target, "targetname");
  heli endon("kill_completion_thread");
  _id_F204DACE25365C76 = "TAG_SEAT_0";
  heli.driver = spawn("script_model", heli gettagorigin(_id_F204DACE25365C76));
  heli.driver setModel("fullbody_sp_ally_pilot_western_vm");
  heli.driver linkTo(heli, _id_F204DACE25365C76, (0, 0, 17), (0, 0, 0));
  heli.driver scriptmodelplayanimdeltamotion("reb_vh_palfa_driver_idle_search01");
  heli.driver notsolid();

  foreach(guy in level.players)
  guy thread _id_613662165F17A93A::_id_43F97C28DF7F8049(heli);

  heli _id_0E80538EF14D00E1::create_simple_path(_id_A0EEC69077D8135E, heli.angles, 1, "hydro_exfil");
  heli vehicle_setspeed(25, 5, 5);
  heli playsoundonmovingent("cp_hydro_exfil_chopper_takeoff");
  heli thread _id_91AAF446346613DA(heli.pathing_array);
  heli.unload_land_offset = 260;
  heli.script_disconnectpaths = 1;

  if(isent(_id_EA0FBAC82EEC8FC1))
    _id_EA0FBAC82EEC8FC1 delete();

  level._id_DF588BF29C7FF9BC = heli;
  heli setvehiclelookattext(undefined, &"CP_BAD_SITUATION_OBJ/STEALTH_HELI_CALLSIGN");
  heli sethoverparams(0, 0, 0);
  heli setvehicleteam("allies");
  heli setCanDamage(0);
  _id_3988BF4DBD68EDE4 = spawn("script_model", heli.origin);
  _id_3988BF4DBD68EDE4 dontinterpolate();
  _id_D05FF9F12BA1E1A0 = getEnt("care_package_col", "targetname");

  if(isDefined(_id_D05FF9F12BA1E1A0)) {
    _id_3988BF4DBD68EDE4 clonebrushmodeltoscriptmodel(_id_D05FF9F12BA1E1A0);
    _id_3988BF4DBD68EDE4 linkTo(heli, "tag_origin", (-144, 16, -192), (0, 0, 0));
  }

  heli scripts\common\vehicle::godon();

  if(!scripts\engine\utility::flag_exist("hover_lz"))
    scripts\engine\utility::flag_init("hover_lz");

  scripts\engine\utility::flag_wait("hover_lz");
  thread _id_7E1A468DA43087E3::_id_17955A30568AFCBF();
  heli thread _id_613662165F17A93A::_id_D612A0B61112564A();
  heli thread _id_613662165F17A93A::_id_A66D0F06DA3EF875();
  heli notify("cancel_flight");
  thread _id_613662165F17A93A::_id_F10A44AA44A8FB03();
  thread _id_7E1A468DA43087E3::_id_65157E0C594D9F8D();

  if(isDefined(level._id_AE22D3BE096B121A)) {
    level._id_AE22D3BE096B121A notify("clear_attack_threads");
    level._id_AE22D3BE096B121A thread _id_3F36F922FAC89B88::_id_B65CD53D323B85E1(level._id_AE22D3BE096B121A);
  }

  level thread _id_23DF1AF2B09EE50C(objectiveindex, heli);
  _id_7D1191C6B596C0FF = scripts\engine\utility::getStruct("heli_landing_start", "targetname");
  heli setneargoalnotifydist(100);
  heli vehicle_setspeed(30, 5, 5);
  heli setvehgoalpos(_id_7D1191C6B596C0FF.origin, 1);
  heli.goalpos = _id_7D1191C6B596C0FF.origin;
  heli scripts\engine\utility::waittill_any_timeout_2(15, "near_goal", "adjusted");
  heli _id_0E80538EF14D00E1::create_simple_path(_id_7D1191C6B596C0FF, heli.angles, 1, "hydro_exfil_landing");
  heli thread _id_91AAF446346613DA(heli.pathing_array);
  heli waittill("finished_landing");
  heli sethoverparams(0, 0, 0);
  level notify("heli_ready_to_onboard");
  heli thread _id_F7742F5B4F816B4B(objectiveindex);
  _id_41A1F8C744F35B69(heli);
  level notify("timer_watchForTimerEnd");
  scripts\cp\utility::_id_7A294A03559CF85E();
  objective_state(objectiveindex, "done");

  if(isDefined(level.outofboundstriggers)) {
    foreach(_id_311721647A970021 in level.outofboundstriggers)
    _id_311721647A970021.origin = _id_311721647A970021.origin - (0, 0, 10000);
  }

  level notify("kill_exfil_dialogues");

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }
    _id_4CADAFE0DB5700B3 = player scripts\engine\utility::spawn_tag_origin();
    _id_4CADAFE0DB5700B3 linkTo(heli);
    player playerlinktodelta(_id_4CADAFE0DB5700B3, "tag_origin", 0, 180, 180, 180, 180, 0);
    player clearsoundsubmix("iw9_cp_hydro_exfil_to_lz", 2);
    player setsoundsubmix("iw9_cp_hydro_heli_exfil", 2);
  }

  _id_D21F9FA011E13A44 = scripts\engine\utility::getStruct("heli_landing_zone_take_off", "targetname");
  heli notify("cancel_flight");
  heli _id_0E80538EF14D00E1::create_simple_path(_id_D21F9FA011E13A44, heli.angles, 1, "hydro_exfil_takeoff");
  heli vehicle_setspeed(25, 5, 5);
  heli thread _id_91AAF446346613DA(heli.pathing_array);
  heli.vehiclename = "chopper_support";
  heli.streakname = "chopper_support";
  heli notify("kill_sweep_vehicles_thread");
  thread _id_7E1A468DA43087E3::_id_9DC1F66EA9B70CFE();
  _func_A3901A965FC1D7DD("mx_cp_hydro_exfil");
  thread _id_583A173126AA1F0E();
  scripts\cp\cp_analytics::_id_B6283AC45A607764("exfil_area");
  wait 15;
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

_id_583A173126AA1F0E() {
  wait 13;

  foreach(player in level.players)
  player clearsoundsubmix("iw9_cp_hydro_heli_exfil", 1);
}

_id_91AAF446346613DA(points) {
  level endon("game_ended");
  self endon("flyaway");
  self endon("cancel_flight");
  self endon("death");
  self endon("crashing");
  self notify("circle");
  self._id_7C8EBCD9C1AFA8D2 = 1;
  self clearlookatent();
  circle_radius = 2500;

  if(isDefined(self.circle_radius))
    circle_radius = self.circle_radius;

  nextpoint = points[0];
  target_ent = scripts\cp\helicopter\cp_helicopter::heli_get_target(undefined, 0);
  chopper_height = scripts\cp\helicopter\cp_helicopter::_id_68C2534A5EA3CD2B();

  if(!isDefined(target_ent))
    target_ent = self;

  self setneargoalnotifydist(100);
  self vehicle_setspeed(50, 5, 5);
  _id_9DBC893FB4BE54F2 = nextpoint.angles;

  while(isDefined(nextpoint)) {
    self setvehgoalpos(nextpoint.origin, 1);
    self.goalpos = nextpoint.origin;
    _id_9DBC893FB4BE54F2 = nextpoint.angles;
    scripts\engine\utility::waittill_any_timeout_2(30, "near_goal", "adjusted");

    if(isDefined(nextpoint.target)) {
      nextpoint = scripts\engine\utility::getStruct(nextpoint.target, "targetname");
      continue;
    }

    nextpoint = undefined;
  }

  self clearlookatent();
  self cleartargetyaw();
  self cleargoalyaw();
  self sethoverparams(25, 15, 10);
  self vehicle_setspeed(10, 10, 10);
  self notify("finished_landing");
}

_id_41A1F8C744F35B69(heli) {
  level endon("game_ended");
  playertrigger = getEnt("leave_player_trigger", "targetname");
  playertrigger enablelinkTo();
  playertrigger linkTo(heli, "tag_origin", (0, 0, -215), (0, 0, 0));
  heli thread _id_3F36F922FAC89B88::_id_34448E15CE014185();
  heli scripts\common\vehicle::godon();
  _id_145B9114A0239C0F = 1500;
  _id_1B71ADB5DD5F240C = 0;

  for(;;) {
    _id_2869011F35349233 = 1;

    foreach(player in level.players) {
      if(!isalive(player)) {
        continue;
      }
      if(!heli _id_ADBB9817E7226E3F(player.origin)) {
        _id_2869011F35349233 = 0;
        break;
      } else
        thread _id_7E1A468DA43087E3::_id_4F3FE1EF4C48406D(player);
    }

    if(_id_2869011F35349233) {
      if(!_id_1B71ADB5DD5F240C)
        _id_1B71ADB5DD5F240C = gettime();

      if(gettime() >= _id_1B71ADB5DD5F240C + _id_145B9114A0239C0F) {
        break;
      }
    } else
      _id_1B71ADB5DD5F240C = 0;

    waitframe();
  }
}

_id_D07A5DDCC74C1190(points, nextnode) {
  self endon("flyaway");
  self endon("death");
  self endon("stop_circling");
  self endon("crashing");
  self notify("circle");
  level endon("hover_lz");
  self._id_7C8EBCD9C1AFA8D2 = 1;
  self clearlookatent();
  circle_radius = 2500;

  if(isDefined(self.circle_radius))
    circle_radius = self.circle_radius;

  for(;;) {
    target_ent = scripts\cp\helicopter\cp_helicopter::heli_get_target(undefined, 0);

    if(!isDefined(target_ent))
      target_ent = self;

    chopper_height = scripts\cp\helicopter\cp_helicopter::_id_68C2534A5EA3CD2B();
    target = (target_ent.origin[0], target_ent.origin[1], chopper_height);
    _id_2F05FDC372F83530 = 0;
    start_point = points[0];
    self setvehgoalpos(points[_id_2F05FDC372F83530].origin, 1);
    self.goalpos = points[_id_2F05FDC372F83530].origin;
    self setneargoalnotifydist(100);
    self vehicle_setspeed(50, 20, 20);
    scripts\engine\utility::waittill_any_timeout_2(30, "near_goal", "adjusted");
    _id_0DB715BCDE296BEC = 0;
    index = _id_2F05FDC372F83530 + 1;

    for(;;) {
      self setvehgoalpos(nextnode.origin);
      self.goalpos = nextnode.origin;
      scripts\engine\utility::waittill_any_timeout_2(30, "near_goal", "adjusted");
      _id_0DB715BCDE296BEC++;
      index++;
      nextnode = scripts\engine\utility::getStruct(nextnode.target, "targetname");

      if(!isDefined(nextnode))
        iprintln(" FAKE!! THIS SHOULD NOT HAPPEN ");
    }
  }
}

_id_23DF1AF2B09EE50C(objectiveindex, heli) {
  wait 3;
  objective_setdescription(objectiveindex, &"CP_BAD_SITUATION_OBJ/GOTO_EXFIL_CHOPPER");
  objective_setlabel(objectiveindex, &"CP_BAD_SITUATION_OBJ/EXFIL_CHOPPER_LABEL");
  objective_setplayintro(objectiveindex, 1);
  objective_setplayoutro(objectiveindex, 1);
  objective_state(objectiveindex, "current");
  objective_icon(objectiveindex, "icon_waypoint_objective_general");
}

_id_A155D94EBB87A5F5(objectivestruct, _id_5DCDFD3A4EFF9961) {
  _id_7E1A468DA43087E3::_id_A9B8DD7261DE2FAD();
}

_id_9DD3D565E1BA2F03(objectivestruct) {
  scripts\engine\utility::flag_wait("cp_bs_cs_completed");
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp\equipment\nvg::runnvg);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "bs_spawner_exfil", 1);

  foreach(player in level.players)
  player scripts\cp\equipment\nvg::runnvg();
}

_id_98BAFDB66D8594E2(box) {
  interaction = spawnStruct();
  interaction.origin = box.origin;
  interaction.targetname = "interaction";
  interaction.script_noteworthy = "care_package_interaction";
  interaction.requires_power = 0;
  interaction.box = box;
  interaction.spend_type = "null";
  interaction.cost = 0;
  interaction.give_loadout_func = ::_id_52D0FE10B7B2E3F6;
  _id_71332A5B74214116::add_to_current_interaction_list(interaction);
  box.interaction = interaction;
  return box;
}

register_care_package_interaction() {
  level._id_888D8E47A2599311 = 0;
  _id_71332A5B74214116::register_interaction("care_package_interaction", "null", undefined, ::care_package_hint, ::care_package_activate, 0, 0, undefined);
}

care_package_hint(_id_DF071553D0996FF9, player) {
  return &"COOP_CRAFTING/PICKUP_LOADOUT_CHANGE";
}

care_package_activate(_id_DF071553D0996FF9, player) {
  player endon("disconnect");
  player[[_id_DF071553D0996FF9.give_loadout_func]]();
  level._id_888D8E47A2599311++;

  if(level._id_888D8E47A2599311 >= level.players.size)
    level notify("gas_masks_collected");

  _id_71332A5B74214116::remove_from_current_interaction_list_for_player(_id_DF071553D0996FF9, player);
}

_id_52D0FE10B7B2E3F6() {
  scripts\cp_mp\gasmask::equipgasmask();
  self setclientomnvar("ui_head_equip_class", 2);
}

_id_CC396AA39DD23F0A() {
  foreach(player in level.players) {
    if(!istrue(player.gasmaskequipped)) {
      player thread scripts\cp_mp\gasmask::equipgasmask();
      player setclientomnvar("ui_head_equip_class", 2);
    }

    player thread _id_6BEBA7279F1FC404();
  }

  wait 15;
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/SURVIVE_HINT_2");
  level._id_2C7C99983794A146 = 1;
  _id_6F1E07CE9FF97D5F::register_drop_func("gas_mask", ::_id_7B36128C239AB88A, ::_id_67EEDE7826377808, 0);
}

_id_6BEBA7279F1FC404() {
  self.gasmaskhealth = 120;
  timer = gettime() + self.gasmaskhealth * 1000;
  self setclientomnvar("cp_gasmask_filter_timer", timer);
  self setclientomnvar("ui_gasmask_damage", self.gasmaskhealth / 120);
  thread _id_DC327722EB30355C();
}

_id_DC327722EB30355C() {
  self notify("reduce_gasmaskHealthOverTime");
  self endon("reduce_gasmaskHealthOverTime");
  self endon("remove_gas_mask");

  for(;;) {
    processdamage(2);
    wait 1;
  }
}

processdamage(damage) {
  self.gasmaskhealth = self.gasmaskhealth - damage;
  self.gasmaskhealth = max(0, self.gasmaskhealth);
  self setclientomnvar("ui_gasmask_damage", self.gasmaskhealth / 120);

  if(self.gasmaskhealth <= 0) {
    timer = gettime() + 0;
    self setclientomnvar("cp_gasmask_filter_timer", timer);
    self setclientomnvar("cp_gasmask_filter_timer", 0);
    scripts\cp_mp\gasmask::breakgasmask();
  }

  if(!isDefined(self.gasdamagebuffer))
    self.gasdamagebuffer = 0;

  timer = gettime() + int(self.gasmaskhealth * 1000);
  self setclientomnvar("cp_gasmask_filter_timer", timer);
  self setclientomnvar("ui_gasmask_damage", self.gasmaskhealth / 120);
  self.gasdamagebuffer = self.gasdamagebuffer + damage * 0.2;
  _id_DEAA0150BED01750 = floor(self.gasdamagebuffer);

  if(_id_DEAA0150BED01750 >= 1)
    self.gasdamagebuffer = self.gasdamagebuffer - _id_DEAA0150BED01750;
}

_id_35096341C3A2C7C6() {
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/SURVIVE_HINT_1");
}

_id_DB8A2B798D546907() {
  _id_31ED809382E5C603 = 0.8;
  _id_43E236FCB934E2BE = 9600;

  foreach(player in level.players)
  thread runscoperadarinloop(player, _id_31ED809382E5C603, _id_43E236FCB934E2BE);
}

_id_53157166DA8B57A8(objectivestruct, _id_5DCDFD3A4EFF9961) {
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/PRICE_EXFIL");
  objectivestruct.trigger = getEnt(objectivestruct.objname, "script_noteworthy");
}

_id_03FF874D83ED81DC(objectivestruct, _id_5DCDFD3A4EFF9961) {
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/PRICE_WARN_1");
  _id_18A73A64992DD07D::run_spawn_module("jugg_wave");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/PRICE_WARN_JUGG");
  objectivestruct.trigger _id_7E1A468DA43087E3::watch_for_objective_reached();
  level notify("call_exfil", objectivestruct.trigger.origin, 1);
  level thread listen_for_exfil_heli_ready_to_land();
}

listen_for_exfil_heli_ready_to_land() {
  while(!isDefined(level.exfil_heli))
    wait 0.1;

  level.exfil_heli waittill("goal");
  level notify("successful exfil");
}

_id_166232B9150BF4E7(objectivestruct, _id_5DCDFD3A4EFF9961) {}

_id_6A40E9D5A9D93F99(objectivestruct) {
  wait 5;
  _id_07132F053DB6712D = scripts\engine\utility::getStructArray("bs_player_start", "script_noteworthy");

  foreach(player in level.players) {
    _id_A4C29FBB3DFBFC4A = scripts\engine\utility::random(_id_07132F053DB6712D);
    _id_07132F053DB6712D = scripts\engine\utility::array_remove(_id_07132F053DB6712D, _id_A4C29FBB3DFBFC4A);
    player setOrigin(scripts\engine\utility::drop_to_ground(_id_A4C29FBB3DFBFC4A.origin), 1);
    player thread _id_52D0FE10B7B2E3F6();
  }
}

_id_B680C9C22BFBFD14() {
  level.activewpzones = [];
  level.activewpinnerzones = [];
  _id_BC355572E0C24AF7 = scripts\engine\utility::getStructArray("airburst_pos", "script_noteworthy");
  thread _id_933BA8AFF1B8E91C(15);

  foreach(index, struct in _id_BC355572E0C24AF7) {
    _id_D7B44CB498FDACDB = scripts\engine\utility::random(_id_BC355572E0C24AF7);
    _id_BC355572E0C24AF7 = scripts\engine\utility::array_remove(_id_BC355572E0C24AF7, _id_D7B44CB498FDACDB);
    wp_fireairburst(_id_D7B44CB498FDACDB.origin, _id_D7B44CB498FDACDB.angles);
    flare = spawn("script_model", scripts\engine\utility::drop_to_ground(_id_D7B44CB498FDACDB.origin));
    flare setModel("ks_white_phosphorus_mp");
    flare.team = "axis";
    flare.angles = _id_D7B44CB498FDACDB.angles;
    flare.weapon_name = "white_phosphorus_proj_mp";
    flare thread wp_projwatchimpact(666, "burn");
    flare._id_69E00D24A565D9A1 = magicgrenademanual("white_phosphorus_marker_mp", flare.origin, flare.origin);
    flare._id_69E00D24A565D9A1 linkTo(flare, "tag_origin", (0, 0, 15), (0, 0, 0));
    wait(randomfloatrange(0.1, 0.25));
  }

  level notify("smokeshow_done");
}

_id_933BA8AFF1B8E91C(delay_time) {
  wait(delay_time);
  _id_0FC0C7692B855028 = scripts\engine\utility::random(scripts\engine\utility::getStructArray("smoke_pos", "script_noteworthy"));
  _id_6B5D366F98BA252B = spawn("script_model", _id_0FC0C7692B855028.origin);
  _id_6B5D366F98BA252B setModel("ks_white_phosphorus_mp");
  _id_6B5D366F98BA252B.team = "axis";
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  level wp_addtoactivewplist("smoke", _id_6B5D366F98BA252B);
  _id_6B5D366F98BA252B thread wp_watchdisorienteffect(_id_0FC0C7692B855028.radius);
  level._id_91C9CC108A0DE1C5 = "wp_smoke";
}

wp_fireairburst(_id_2D7A2733C414E4DF, _id_DB855E6AE67F1A7F) {
  _id_089C07A70B638FDD = _id_2D7A2733C414E4DF;
  _id_1FC06BF514F2782A = _id_2D7A2733C414E4DF;
  _id_30A3F1579CA0253A = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.5);
  playFX(scripts\engine\utility::getfx("white_phosphorus_inair_explosion"), _id_089C07A70B638FDD, _id_DB855E6AE67F1A7F);
  playsoundatpos(_id_1FC06BF514F2782A, "iw8_mp_white_phos_midair_explo");
}

wp_projwatchimpact(_id_30A3F1579CA0253A, _id_4E01B7D6147E61A0) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  self.projimpacted = 1;
  level wp_addtoactivewplist("inner", self);
  self setscriptablepartstate("impact", "on", 0);
  self setscriptablepartstate("flare", "on", 0);

  if(isDefined(_id_4E01B7D6147E61A0)) {
    if(_id_4E01B7D6147E61A0 == "burn")
      thread wp_watchburneffect(150);
    else
      thread wp_watchblindeffect(150);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_30A3F1579CA0253A);
  level wp_removefromactivewplist("inner", self, _id_4E01B7D6147E61A0, 1);
  self notify("stop_wp_status_effect");
  self setscriptablepartstate("flare", "off", 0);
  self setscriptablepartstate("flare_death", "on", 0);
  thread scripts\cp\utility::delayentdelete(4);
}

wp_watchblindeffect(_id_36F2E76BC9E35AC6) {
  self endon("stop_wp_status_effect");
  self endon("death");
  self.playersininnerradius = [];

  for(;;) {
    foreach(player in level.players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(distance2d(self.origin, player.origin) <= _id_36F2E76BC9E35AC6 && scripts\engine\trace::ray_trace_passed(player getEye(), self.origin + (0, 0, 30), player)) {
        if(!istrue(player.wpblinding))
          player wp_startblindplayer(self);

        continue;
      }

      if(istrue(player.wpblinding) && wp_isinwpzone("inner", player, self))
        player wp_stopblindplayer(self);
    }

    wait 0.05;
  }
}

wp_startblindplayer(_id_B16682794BB72308) {
  if(level.teambased && self.team == _id_B16682794BB72308.team || self == _id_B16682794BB72308.owner) {
    _id_13E20722A28D1047 = 1;

    if(istrue(_id_13E20722A28D1047))
      return;
  }

  _id_B16682794BB72308 wp_addplayertostatusradiuslist("inner", self);
  self.wpblinding = 1;
  thread wp_stopstatuseffectondeath(_id_B16682794BB72308);
  self visionsetnakedforplayer("wp_flare", 1);
}

wp_stopstatuseffectondeath(_id_B16682794BB72308) {
  _id_B16682794BB72308 endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  wp_resetstatuseffect(1);
}

wp_resetstatuseffect(_id_2E501FC7D257CE57) {
  if(istrue(self.wpburning)) {
    if(!isai(self))
      scripts\cp\cp_weapons::disableburnfx();

    if(scripts\cp_mp\utility\player_utility::_isalive()) {}

    self.wpburning = undefined;
  }

  if(istrue(self.wpblinding)) {
    self.wpblinding = undefined;

    if(wp_isinanywpzone("smoke", self))
      self visionsetnakedforplayer(wp_getsmokevisionset(), 1);
    else
      self visionsetnakedforplayer("", 1);
  }

  if(istrue(_id_2E501FC7D257CE57))
    level wp_removeplayerfromallstatusradiuslists("inner", self);
}

wp_stopblindplayer(_id_B16682794BB72308) {
  _id_B16682794BB72308 wp_removeplayerfromstatusradiuslist("inner", self);

  if(!wp_isinanywpzone("inner", self))
    wp_resetstatuseffect();
}

wp_removefromactivewplist(type, _id_E259CF0D8DCFA751, _id_CC9D6AB1BDF32FC0, _id_662EFE6105E9F585) {
  _id_E5DAB4F107F3A279 = [];

  if(type == "smoke") {
    foreach(_id_B16682794BB72308 in level.activewpzones) {
      if(_id_B16682794BB72308 == _id_E259CF0D8DCFA751) {
        continue;
      }
      _id_E5DAB4F107F3A279[_id_E5DAB4F107F3A279.size] = _id_B16682794BB72308;
    }

    level.activewpzones = _id_E5DAB4F107F3A279;

    foreach(player in _id_E259CF0D8DCFA751.playersindisorientradius) {
      if(!wp_isinanywpzone("smoke", player))
        player thread wp_stopdisorientplayer(_id_E259CF0D8DCFA751);
    }

    if(level.activewpzones.size <= 0)
      level.wpinprogress = undefined;
  } else {
    foreach(_id_B16682794BB72308 in level.activewpinnerzones) {
      if(_id_B16682794BB72308 == _id_E259CF0D8DCFA751) {
        continue;
      }
      _id_E5DAB4F107F3A279[_id_E5DAB4F107F3A279.size] = _id_B16682794BB72308;
    }

    level.activewpinnerzones = _id_E5DAB4F107F3A279;

    foreach(player in _id_E259CF0D8DCFA751.playersininnerradius) {
      if(!wp_isinanywpzone("inner", player)) {
        if(_id_CC9D6AB1BDF32FC0 == "burn") {
          player thread wp_stopburnplayer(_id_E259CF0D8DCFA751);
          continue;
        }

        player thread wp_stopblindplayer(_id_E259CF0D8DCFA751);
      }
    }
  }

  if(isDefined(_id_E259CF0D8DCFA751._id_69E00D24A565D9A1))
    _id_E259CF0D8DCFA751._id_69E00D24A565D9A1 delete();

  if(istrue(_id_662EFE6105E9F585)) {
    return;
  }
  _id_E259CF0D8DCFA751 delete();
}

wp_stopburnplayer(_id_B16682794BB72308) {
  _id_B16682794BB72308 wp_removeplayerfromstatusradiuslist("inner", self);

  if(!wp_isinanywpzone("inner", self)) {
    wp_resetstatuseffect();
    self notify("stop_wp_burn");
  }
}

wp_watchdisorienteffect(_id_2064C9035E8FDDD4) {
  self endon("death");
  self.playersindisorientradius = [];

  for(;;) {
    foreach(player in level.characters) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(distance2d(self.origin, player.origin) <= _id_2064C9035E8FDDD4) {
        if(!wp_isinwpzone("smoke", player, self))
          wp_addplayertostatusradiuslist("smoke", player);

        if(!istrue(player.wpdisorient))
          player thread wp_startdisorientplayer(self);
      }
    }

    wait 0.05;
  }
}

wp_startdisorientplayer(_id_B16682794BB72308) {
  _id_B16682794BB72308 endon("death");
  self endon("death");
  self endon("stop_disorient");
  level endon("game_ended");
  self.wpdisorient = 1;

  if(!isai(self)) {
    self enablephysicaldepthoffieldscripting();
    thread wp_stopdisorientonplayerdeath(_id_B16682794BB72308);
    thread wp_monitorsmokevisionset(_id_B16682794BB72308);
    playfxontagforclients(scripts\engine\utility::getfx("white_phosphorus_screen"), self, "tag_eye", self);
  }

  if(self.health > 0) {
    _id_FEAB9FA3A5844D2D = scripts\engine\utility::random(level.players).maxhealth;

    if(isai(self)) {
      _id_FEAB9FA3A5844D2D = self.maxhealth;
      return;
    }
  } else
    self dodamage(self.health + 1000, self.origin);
}

wp_gethealthdebuffamount() {
  _id_FEAB9FA3A5844D2D = 50;
  _id_A51512C2048AB572 = self.health;
  _id_D6C240915742C3A9 = _id_A51512C2048AB572 - _id_FEAB9FA3A5844D2D;

  if(_id_D6C240915742C3A9 < 1)
    _id_FEAB9FA3A5844D2D = _id_FEAB9FA3A5844D2D - (1 - _id_D6C240915742C3A9);

  return _id_FEAB9FA3A5844D2D;
}

wp_degenhealth(_id_C3770DC539016800, _id_B16682794BB72308) {
  _id_B16682794BB72308 endon("death");
  self endon("death");
  self endon("stop_disorient");
  level endon("game_ended");
  _id_455A608C8933B100 = 0;

  for(;;) {
    if(self isskydiving()) {
      waitframe();
      continue;
    }

    if(istrue(self.gasmaskequipped)) {
      waitframe();
      continue;
    }

    if(self.health > 0 && _id_455A608C8933B100 < _id_C3770DC539016800) {
      if(isai(self))
        self dodamage(10, self.origin);
      else if(isDefined(self.juggcontext))
        self dodamage(15, self.origin, undefined, undefined, "MOD_FIRE");
      else
        self dodamage(15, self.origin, undefined, undefined, "MOD_FIRE");

      _id_455A608C8933B100++;
    }

    wait 1;
  }
}

wp_stopdisorientonplayerdeath(_id_B16682794BB72308) {
  _id_B16682794BB72308 endon("death");
  self endon("stop_disorient");
  level endon("game_ended");
  self waittill("death");
  wp_stopdisorientplayer(_id_B16682794BB72308, 1);
}

wp_monitorsmokevisionset(_id_B16682794BB72308) {
  _id_B16682794BB72308 endon("death");
  self endon("disconnect");
  self endon("stop_disorient");
  level endon("game_ended");
  _id_98E6B3F49203EB6C = undefined;
  self visionsetnakedforplayer("wp_smoke", 2);
  wait 4;
  self visionsetnakedforplayer("", 180);
}

wp_getsmokevisionset() {
  _id_FC0043E95242D5CB = "wp_smoke";

  if(self isnightvisionon())
    _id_FC0043E95242D5CB = "wp_smoke_no_color";

  return _id_FC0043E95242D5CB;
}

wp_stopdisorientplayer(_id_B16682794BB72308, _id_FB8011C41299D291) {
  level endon("game_ended");

  if(istrue(_id_FB8011C41299D291))
    level wp_removeplayerfromallstatusradiuslists("smoke", self);
  else
    _id_B16682794BB72308 wp_removeplayerfromstatusradiuslist("smoke", self);

  if(!wp_isinanywpzone("smoke", self) || istrue(_id_FB8011C41299D291)) {
    if(istrue(self.wpdisorient)) {
      self.wpdisorient = undefined;
      self visionsetnakedforplayer("", 2);
      stopfxontagforclients(scripts\engine\utility::getfx("white_phosphorus_screen"), self, "tag_eye", self);

      if(istrue(self.wphealthblock))
        self.wphealthblock = undefined;

      self notify("stop_disorient");
    }
  }
}

wp_isinanywpzone(type, _id_C4B81997F0120A97) {
  _id_83EBB8884BB96F82 = 0;

  if(type == "smoke") {
    foreach(_id_B16682794BB72308 in level.activewpzones) {
      if(wp_isinwpzone(type, _id_C4B81997F0120A97, _id_B16682794BB72308)) {
        _id_83EBB8884BB96F82 = 1;
        break;
      }
    }
  } else {
    foreach(_id_B16682794BB72308 in level.activewpinnerzones) {
      if(wp_isinwpzone(type, _id_C4B81997F0120A97, _id_B16682794BB72308)) {
        _id_83EBB8884BB96F82 = 1;
        break;
      }
    }
  }

  return _id_83EBB8884BB96F82;
}

wp_addtoactivewplist(type, _id_FA00AB9D021CD558) {
  if(type == "smoke")
    level.activewpzones[level.activewpzones.size] = _id_FA00AB9D021CD558;
  else
    level.activewpinnerzones[level.activewpinnerzones.size] = _id_FA00AB9D021CD558;
}

wp_isinwpzone(type, _id_C4B81997F0120A97, _id_B16682794BB72308) {
  isinzone = 0;
  _id_2B3D4F72CF8EF276 = undefined;

  if(type == "smoke")
    _id_2B3D4F72CF8EF276 = _id_B16682794BB72308.playersindisorientradius;
  else
    _id_2B3D4F72CF8EF276 = _id_B16682794BB72308.playersininnerradius;

  foreach(player in _id_2B3D4F72CF8EF276) {
    if(player == _id_C4B81997F0120A97) {
      isinzone = 1;
      break;
    }
  }

  return isinzone;
}

wp_addplayertostatusradiuslist(type, _id_E69B22A24070EC44) {
  if(type == "smoke")
    self.playersindisorientradius[self.playersindisorientradius.size] = _id_E69B22A24070EC44;
  else
    self.playersininnerradius[self.playersininnerradius.size] = _id_E69B22A24070EC44;
}

wp_removeplayerfromstatusradiuslist(type, _id_9D90C26327E3EACD) {
  if(type == "smoke") {
    _id_E5DAB4F107F3A279 = [];

    foreach(player in self.playersindisorientradius) {
      if(player == _id_9D90C26327E3EACD) {
        continue;
      }
      _id_E5DAB4F107F3A279[_id_E5DAB4F107F3A279.size] = player;
    }

    self.playersindisorientradius = _id_E5DAB4F107F3A279;
  } else {
    _id_E5DAB4F107F3A279 = [];

    foreach(player in self.playersininnerradius) {
      if(player == _id_9D90C26327E3EACD) {
        continue;
      }
      _id_E5DAB4F107F3A279[_id_E5DAB4F107F3A279.size] = player;
    }

    self.playersininnerradius = _id_E5DAB4F107F3A279;
  }
}

wp_removeplayerfromallstatusradiuslists(type, _id_9D90C26327E3EACD) {
  if(type == "smoke") {
    foreach(_id_B16682794BB72308 in level.activewpzones) {
      if(wp_isinwpzone(type, _id_9D90C26327E3EACD, _id_B16682794BB72308))
        _id_B16682794BB72308 wp_removeplayerfromstatusradiuslist(type, _id_9D90C26327E3EACD);
    }
  } else {
    foreach(_id_B16682794BB72308 in level.activewpinnerzones) {
      if(wp_isinwpzone(type, _id_9D90C26327E3EACD, _id_B16682794BB72308))
        _id_B16682794BB72308 wp_removeplayerfromstatusradiuslist(type, _id_9D90C26327E3EACD);
    }
  }
}

wp_watchburneffect(_id_5D889FD269DFB5CA) {
  self endon("stop_wp_status_effect");
  self endon("death");
  self.playersininnerradius = [];

  for(;;) {
    foreach(player in level.characters) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(distance2d(self.origin, player.origin) <= _id_5D889FD269DFB5CA && scripts\engine\trace::ray_trace_passed(player getEye(), self.origin + (0, 0, 30), player)) {
        if(!istrue(player.wpburning))
          player thread wp_startburnplayer(self, self.owner);

        continue;
      }

      if(istrue(player.wpburning) && wp_isinwpzone("inner", player, self))
        player wp_stopburnplayer(self);
    }

    wait 0.05;
  }
}

wp_startburnplayer(_id_B16682794BB72308, attacker) {
  _id_B16682794BB72308 endon("death");
  self endon("stop_wp_burn");
  self endon("death");
  level endon("game_ended");
  _id_B16682794BB72308 wp_addplayertostatusradiuslist("inner", self);

  if(!isai(self)) {
    self dodamage(15, self.origin, attacker, _id_B16682794BB72308, "MOD_EXPLOSIVE", _id_B16682794BB72308.weapon_name);
    self.wpburning = 1;
    scripts\cp\cp_weapons::enableburnfx();
  } else {
    self dodamage(66, self.origin, attacker, _id_B16682794BB72308, "MOD_EXPLOSIVE", _id_B16682794BB72308.weapon_name);
    return;
  }

  thread wp_stopstatuseffectondeath(_id_B16682794BB72308);
  damage = 1;

  for(;;) {
    if(self.health <= damage)
      self notify("stop_degen");

    self dodamage(damage, self.origin, attacker, _id_B16682794BB72308, "MOD_EXPLOSIVE", _id_B16682794BB72308.weapon_name);
    wait 0.5;
    damage++;

    if(damage >= 10)
      damage = 10;
  }
}

runscoperadarinloop(player, _id_31ED809382E5C603, _id_43E236FCB934E2BE) {
  level endon("game_ended");
  player notify("runScopeRadarInLoop");
  player endon("runScopeRadarInLoop");
  player endon("death");
  player endon("disconnect");

  for(;;) {
    if(istrue(player.inlaststand)) {
      wait 1;
      continue;
    }

    player playlocalsound("uav_ping");
    player thread scoperadar_executeping(player, _id_31ED809382E5C603, _id_43E236FCB934E2BE, 1);
    player scoperadar_executevisuals(player, _id_31ED809382E5C603);
    wait 2.4;
  }
}

scoperadar_executeping(player, _id_31ED809382E5C603, _id_43E236FCB934E2BE, _id_3165B11E0B0BDD01) {
  level endon("game_ended");
  player endon("death");
  player endon("scope_radar_ads_out");
  hit = 0;
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  closestenemies = scripts\engine\utility::get_array_of_closest(player.origin, enemies, undefined, getdvarint("scr_default_maxagents", 32), _id_43E236FCB934E2BE);
  player.closestenemies = closestenemies;
  count = 0;

  foreach(victim in player.closestenemies) {
    victim.is_outlined_from_scoperadar = 0;

    if(istrue(_id_3165B11E0B0BDD01)) {
      count++;
      _id_340D59422336E85A = victim.origin - player.origin;

      if(1 && vectordot(anglesToForward(player.angles), _id_340D59422336E85A) < 0) {
        continue;
      }
      _id_F85C8A0556EDF077 = _id_43E236FCB934E2BE * _id_43E236FCB934E2BE;

      if(length2dsquared(_id_340D59422336E85A) > _id_F85C8A0556EDF077) {
        continue;
      }
      player thread outlineplayerbydistance(victim, player, distance2d(player.origin, victim.origin) / _id_43E236FCB934E2BE, _id_31ED809382E5C603);
      hit = 1;
      continue;
    }

    if(scripts\engine\utility::within_fov(player getEye(), player.angles, victim.origin, cos(65))) {
      count++;
      _id_340D59422336E85A = victim.origin - player.origin;
      _id_F85C8A0556EDF077 = _id_43E236FCB934E2BE * _id_43E236FCB934E2BE;

      if(length2dsquared(_id_340D59422336E85A) > _id_F85C8A0556EDF077) {
        continue;
      }
      player thread outlineplayerbydistance(victim, player, distance2d(player.origin, victim.origin) / _id_43E236FCB934E2BE, _id_31ED809382E5C603);
      hit = 1;
    }
  }
}

outlineplayerbydistance(victim, player, delay, _id_31ED809382E5C603) {
  level endon("game_ended");
  player endon("scope_radar_ads_out");
  player endon("last_stand");
  player endon("death");
  player endon("disconnect");
  player endon("weapon_change");
  wait(_id_31ED809382E5C603 * delay);
  victim.is_outlined_from_scoperadar = 1;
  victim hudoutlineenableforclient(player, "snapshotgrenade");
}

watchhighlightfadetime(player, ent, time) {
  player endon("disconnect");
  level endon("game_ended");
  player scripts\engine\utility::waittill_any_timeout_no_endon_death_1(time);

  if(isDefined(ent))
    disable_outline_for_player(ent, player);
}

disable_outline_for_player(item, player) {
  item hudoutlinedisableforclient(player);
}

scoperadar_executevisuals(player, _id_31ED809382E5C603) {
  level endon("game_ended");
  player endon("disconnect");
  player scripts\engine\utility::waittill_any_timeout_no_endon_death_2(_id_31ED809382E5C603, "last_stand", "death");

  if(isDefined(player.closestenemies)) {
    foreach(victim in player.closestenemies) {
      if(isDefined(victim)) {
        if(istrue(victim.is_outlined_from_scoperadar)) {
          disable_outline_for_player(victim, player);
          victim.is_outlined_from_scoperadar = 0;
        }
      }
    }
  }
}

remove_visuals(player) {
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(victim in enemies) {
    if(isDefined(victim)) {
      if(istrue(victim.is_outlined_from_scoperadar)) {
        disable_outline_for_player(victim, player);
        victim.is_outlined_from_scoperadar = 0;
      }
    }
  }

  if(isDefined(player.fxent))
    player.fxent delete();
}

launch_illumination_flare() {
  start = self gettagorigin("j_shaft_top");
  end = self.origin + anglesToForward(self.angles) * 2000 + (0, 0, 1000);
  flare = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));
  playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_flare_launch");
  flare show();
  time = 2.25;
  thread scripts\cp_mp\mortar_launcher::movemortar(flare, start, end, time, 400);
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_flare_trail"), flare, "tag_origin");
  flare playsoundonmovingent("weap_mortar_flare_whistle");
  wait(time);
  playFXOnTag(scripts\engine\utility::getfx("vfx_flare"), flare, "tag_origin");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_flare_trail"), flare, "tag_origin");
  flare thread flare_mover();
  flare playSound("weap_mortar_flare_burst");
  flare playSound("weap_mortar_flare_phosphorus_start");
  wait 0.1;
  flare playLoopSound("weap_mortar_flare_phosphorus_lp");
  wait 8;
  flare playSound("weap_mortar_flare_phosphorus_end");
  wait 2;
  flare delete();
}

flare_mover(end) {
  self endon("death");
  self endon("cleanup_light_threads");

  for(;;) {
    x = self.origin[0] + randomintrange(-5, 5);
    y = self.origin[1] + randomintrange(-5, 5);
    z = self.origin[2] - 100;

    if(isDefined(end) && isDefined(self.flare_lifetime)) {
      self moveTo(end, self.flare_lifetime);
      wait(self.flare_lifetime);
      continue;
    }

    self moveTo((x, y, z), 1);
    wait 1;
  }
}

_id_519042372E07840E(player) {
  player.prevweapon = player getcurrentweapon();
  player _id_3B64EB40368C1450::set("heartb_sensor", "weapon_switch", 0);
  player _id_3B64EB40368C1450::set("heartb_sensor", "fire", 0);
  weaponobj = makeweapon("iw9_cyberemp_mp");
  weaponobj = makeweapon("iw9_cyberemp_plant_mp");
  player scripts\cp\utility::_giveweapon(weaponobj);
  player setweaponammostock(weaponobj, 1);
  player setweaponammoclip(weaponobj, 1);
  player scripts\cp_mp\utility\inventory_utility::_switchtoweapon(weaponobj);
  wait 1.5;
  player scripts\cp_mp\utility\inventory_utility::_takeweapon(weaponobj);
  player scripts\cp_mp\utility\inventory_utility::_switchtoweapon(player.prevweapon);
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("heartb_sensor");
}

start_airstrikes_sequence() {
  level._id_401A0EB37B82DCB6 = getEnt("airstrike_safe_area", "script_noteworthy");

  foreach(player in level.players)
  player thread _id_5B1A447001AE232A(level._id_401A0EB37B82DCB6);

  level thread periodic_airstrikes();
}

_id_5B1A447001AE232A(trigger) {
  level endon("ai_retreat");
  self.b_should_get_hit = 0;

  for(;;) {
    wait 1;

    if(self istouching(trigger) || scripts\cp\utility::is_indoors(self)) {
      self.b_should_get_hit = 0;
      continue;
    }

    self.b_should_get_hit = 1;
  }
}

periodic_airstrikes() {
  level endon("game_ended");
  level endon("ai_retreat");

  if(!isDefined(level.aiairstrikeinprogress))
    level.aiairstrikeinprogress = [];

  for(;;) {
    wait(randomintrange(5, 10));

    foreach(player in level.players) {
      if(istrue(player.inlaststand)) {
        continue;
      }
      if(istrue(level.aiairstrikeinprogress[player.name])) {
        continue;
      }
      if(istrue(player.b_should_get_hit))
        level thread launch_airstrikes_at_position(player);
    }
  }
}

launch_airstrikes_at_position(player) {
  level.aiairstrikeinprogress[player.name] = 1;
  streakinfo = spawnStruct();
  streakinfo.streakname = "precision_airstrike";
  streakinfo.owner = player;
  animname = level.scr_anim[streakinfo.streakname]["airstrike_flyby"];
  _id_0E7CA95FE87CCFD0 = spawn("script_model", player.origin);
  _id_0E7CA95FE87CCFD0 setModel("ks_airstrike_marker_mp");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "requestObjectiveID"))
    _id_0E7CA95FE87CCFD0.objidnum = [[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "requestObjectiveID")]](99);

  _id_0E7CA95FE87CCFD0 dontinterpolate();
  _id_A465314411EA4812 = "icon_waypoint_airstrike";
  _id_0E7CA95FE87CCFD0 scripts\cp_mp\killstreaks\airstrike::airstrike_setmarkerobjective(_id_0E7CA95FE87CCFD0.objidnum, _id_A465314411EA4812, player, 50);
  _id_0E7CA95FE87CCFD0.origin = player.origin;
  _id_0E7CA95FE87CCFD0 setscriptablepartstate("marker_scope", "on", 0);
  scripts\cp_mp\killstreaks\airstrike::callstrike(player, player.origin, player.angles[1], undefined, streakinfo, animname);
  _id_0E7CA95FE87CCFD0 delete();
  level.aiairstrikeinprogress[player.name] = undefined;
}

_id_921CA717F116A55A() {
  level._id_4F38DF021E48D2E8 = [];
  level._id_4F38DF021E48D2E8["find_base"] = 0;
  level._id_4F38DF021E48D2E8["trap"] = 0;
}

_id_D93FDA51690DB1C7() {
  if(getdvarint("dvar_4F84BC7BB1801DC0", 0) != 0) {
    return;
  }
  level notify("cleanup_old_sound_events");

  foreach(_id_9E85FD38C09D58DE in level.pasystems)
  _id_9E85FD38C09D58DE thread _id_742F61B6768A1AAB::alarm_audio();

  level._id_1C6BEE662505623E = 1;
  _id_2EA028E9A0309AD6();
  level._id_1C6BEE662505623E = undefined;
}

_id_2EA028E9A0309AD6() {
  wait 30;
  level notify("cleanup_old_sound_events");
}

_id_B7EEB077DE562D79(origin) {
  scripts\cp\utility::playsoundatpos_safe(origin, "milbase_hot_alarm");
}

_id_B26A9659684D2CF9() {
  self takeweapon(self.primaryweaponobj);
  self takeweapon(self.secondaryweaponobj);
  _id_9EF97DB737B5030E = makeweaponfromstring("iw8_ar_mike4_mpv2a+barmid_mike4_mpv2|6+gripvertpro|15+holo_west02|3+laserbalanced_mike4|12+mag_mike4a|2+rec_mike4a|2+selectsemi+stocks_mike4|5+loot18");
  self giveweapon(_id_9EF97DB737B5030E);
  self setweaponammoclip(_id_9EF97DB737B5030E, weaponclipsize(_id_9EF97DB737B5030E));
  self setweaponammostock(_id_9EF97DB737B5030E, weaponmaxammo(_id_9EF97DB737B5030E));
  self switchtoweapon(_id_9EF97DB737B5030E);
  _id_88350DAC5063D94E = makeweaponfromstring("iw8_sh_mike26_mp+back_mike26|3+barlong_mike26|1+caldb_mike26|1+gripside_mike26|3+laserrangeshtgn_bar|5+minireddot03_tall|3+muzzlemelee_mike26|3+rec_mike26|3+loot3");
  self giveweapon(_id_88350DAC5063D94E);
  self setweaponammoclip(_id_88350DAC5063D94E, weaponclipsize(_id_88350DAC5063D94E));
  self setweaponammostock(_id_88350DAC5063D94E, weaponmaxammo(_id_88350DAC5063D94E));
  _id_7EF95BBA57DC4B82::giveequipment("equip_frag", "primary");
  _id_7EF95BBA57DC4B82::setequipmentammo("equip_frag", 8);
  _id_7EF95BBA57DC4B82::giveequipment("equip_flash", "secondary");
  _id_7EF95BBA57DC4B82::setequipmentammo("equip_flash", 8);
  self.weaponlist = self getweaponslistprimaries();
  thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0], 1);

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0]))
    self.primaryweaponobj = self.weaponlist[0];

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1]))
    self.secondaryweaponobj = self.weaponlist[1];
}

flare_setup() {
  level._id_66A2200948D3FA7E = [];
  level._id_260C1D2C744C8A3A = spawnStruct();
  level._id_260C1D2C744C8A3A.origin = (-20, -700, 200);
  level.flares = getEntArray("flare_fx_light", "targetname");
  level._id_D1417E7436E826F8 = getEntArray("flare_fx_light_up", "targetname");
  level.flare_lifetime = 10;
  level.flare_countdown = level.flare_lifetime;
  level.mortars = getEntArray("mortar_spawn", "targetname");

  foreach(flare in level.flares) {
    flare.og_angles = flare.angles;
    flare.og_origin = flare.origin;
    flare setlightintensity(0);
    flare.intensity = 10;
    flare._id_25C2724FD2E1663A = 300;
    flare.flare_countdown = level.flare_countdown;
  }

  foreach(flare in level._id_D1417E7436E826F8) {
    flare.og_angles = flare.angles;
    flare.og_origin = flare.origin;

    foreach(_id_CE2D4578F58049FB in level.flares) {
      if(_id_CE2D4578F58049FB.script_area == flare.script_area)
        flare.flare_light = _id_CE2D4578F58049FB;
    }

    flare setlightintensity(0);
    flare.flare_countdown = level.flare_countdown;
  }
}

_id_F3A6A87DB9AE941C() {
  foreach(_id_92753DA39919F200 in level.mortars) {
    foreach(flare in level.flares) {
      if(_id_92753DA39919F200.struct.script_noteworthy == flare.script_area)
        _id_92753DA39919F200.flare = flare;
    }

    foreach(_id_4B8C19E918877679 in level._id_D1417E7436E826F8) {
      if(_id_92753DA39919F200.struct.script_noteworthy == _id_4B8C19E918877679.script_area)
        _id_92753DA39919F200._id_4B8C19E918877679 = _id_4B8C19E918877679;
    }

    _id_92753DA39919F200.flare_lifetime = level.flare_lifetime;
    _id_92753DA39919F200.flare_countdown = level.flare_countdown;
    _id_92753DA39919F200 thread _id_AB76EC6CC6E3EABF();
  }
}

_id_B20A836DA84340B0(_id_CD977BE97BC0FC1E, stealth_group) {
  if(scripts\cp\coop_stealth::_id_94FFB636A243CF0E(4)) {
    if(isDefined(stealth_group) && isstring(stealth_group)) {
      if(!isDefined(level._id_72069798E35CC6BC["barn"]))
        level._id_72069798E35CC6BC["barn"] = 0;

      if(!isDefined(level._id_72069798E35CC6BC["town"]))
        level._id_72069798E35CC6BC["town"] = 0;

      switch (stealth_group) {
        case "pre_barn_interior":
        case "farm_outer_side":
        case "farm_outer_tank":
        case "pre_barn_test":
        case "farm_outer":
        case "pre_barn_right":
        case "pre_barn_left":
        case "pre_barn_front":
        case "pre_barn":
        case "farm_barn_outer":
        case "farm_outer_1":
          if(level._id_72069798E35CC6BC["town"] < 4) {
            if(level._id_72069798E35CC6BC["barn"] < 4)
              return _id_4E079FE327D06D85(_id_CD977BE97BC0FC1E);
            else
              return 1;
          } else
            return 1;

          break;
        case "pre_exfil_outer":
        case "farm_hack_outer":
        case "farm_barn_hack":
        case "town_spawners_5":
        case "town_spawners_4":
        case "town_spawners_3":
        case "town_spawners_2":
        case "town_spawners_1":
        case "exfil":
          if(level._id_72069798E35CC6BC["barn"] < 4) {
            if(level._id_72069798E35CC6BC["town"] < 4)
              return _id_4E079FE327D06D85(_id_CD977BE97BC0FC1E);
            else
              return 1;
          } else
            return 1;
        default:
          return _id_4E079FE327D06D85(_id_CD977BE97BC0FC1E);
      }
    } else
      return 0;
  } else
    return 0;
}

_id_4E079FE327D06D85(_id_CD977BE97BC0FC1E) {
  if(isDefined(level._id_7367EFF91F8B3FD5)) {
    foreach(_id_22855D5290E0F624 in level._id_7367EFF91F8B3FD5) {
      if(distance2dsquared(_id_22855D5290E0F624._id_C9B351269A319209, _id_CD977BE97BC0FC1E.origin) <= 9000000)
        return 1;
    }
  }

  return 0;
}

_id_95F7211DB94C5A7D(stealth_group) {
  if(isDefined(stealth_group) && isstring(stealth_group)) {
    if(!isDefined(level._id_72069798E35CC6BC[stealth_group]))
      level._id_72069798E35CC6BC[stealth_group] = 0;

    level._id_72069798E35CC6BC[stealth_group]++;

    if(!isDefined(level._id_72069798E35CC6BC["barn"]))
      level._id_72069798E35CC6BC["barn"] = 0;

    if(!isDefined(level._id_72069798E35CC6BC["town"]))
      level._id_72069798E35CC6BC["town"] = 0;

    level._id_892990D1B2DA4A65 = 4000000;

    switch (stealth_group) {
      case "pre_barn_interior":
      case "farm_outer_side":
      case "farm_outer_tank":
      case "pre_barn_test":
      case "farm_outer":
      case "pre_barn_right":
      case "pre_barn_left":
      case "pre_barn_front":
      case "pre_barn":
      case "farm_barn_outer":
      case "farm_outer_1":
        level._id_72069798E35CC6BC["barn"]++;

        if(level._id_72069798E35CC6BC["barn"] < 12) {
          return;
        }
        _id_83CFCA5199B3CB7D("barn");

        if(istrue(level._id_1C6BEE662505623E)) {
          return;
        }
        thread _id_D93FDA51690DB1C7();
        level thread spawn_para_and_heli_logic();
        break;
      case "farm_hack_outer":
      case "farm_barn_hack":
      case "town_spawners_5":
      case "town_spawners_4":
      case "town_spawners_3":
      case "town_spawners_2":
      case "town_spawners_1":
        level._id_72069798E35CC6BC["town"]++;

        if(level._id_72069798E35CC6BC["town"] < 12) {
          return;
        }
        _id_83CFCA5199B3CB7D("town");
        thread spawn_enemy_chopper(stealth_group);

        if(istrue(level._id_1C6BEE662505623E)) {
          return;
        }
        thread _id_D93FDA51690DB1C7();
        level thread spawn_para_and_heli_logic();
        break;
      case "pre_exfil_outer":
      case "exfil":
        level._id_72069798E35CC6BC["town"]++;

        if(level._id_72069798E35CC6BC["town"] < 12) {
          return;
        }
        _id_83CFCA5199B3CB7D("exfil");
        thread spawn_enemy_chopper(stealth_group);

        if(istrue(level._id_1C6BEE662505623E)) {
          return;
        }
        thread _id_D93FDA51690DB1C7();
        level thread spawn_para_and_heli_logic();
        break;
    }
  }
}

_id_83CFCA5199B3CB7D(_id_F57BD7A1277D32C9) {
  if(getdvarint("dvar_FA53D7293EC88067", 0) != 0) {
    return;
  }
  if(istrue(level._id_66A2200948D3FA7E[_id_F57BD7A1277D32C9])) {
    return;
  }
  level._id_66A2200948D3FA7E[_id_F57BD7A1277D32C9] = 1;
  flares = [];
  _id_4B8C19E918877679 = [];
  _id_089D6E7F82998C02 = undefined;

  foreach(_id_92753DA39919F200 in level.mortars) {
    if(_id_92753DA39919F200.struct.script_noteworthy == _id_F57BD7A1277D32C9)
      _id_089D6E7F82998C02 = _id_92753DA39919F200;
  }

  foreach(flare in level.flares) {
    if(_id_089D6E7F82998C02.struct.script_noteworthy == flare.script_area) {
      flares = scripts\engine\utility::array_add(flares, flare);
      _id_089D6E7F82998C02.flare = flare;
    }
  }

  flares = scripts\engine\utility::array_randomize(flares);

  foreach(flare in flares) {
    _id_089D6E7F82998C02.flare = flare;
    _id_089D6E7F82998C02._id_4B8C19E918877679 = scripts\engine\utility::getclosest(_id_089D6E7F82998C02.flare.origin, level._id_D1417E7436E826F8, 64);

    if(isDefined(_id_089D6E7F82998C02._id_4B8C19E918877679)) {
      _id_089D6E7F82998C02._id_4B8C19E918877679.flare_light = flare;
      _id_089D6E7F82998C02.flare_lifetime = level.flare_lifetime;
      _id_089D6E7F82998C02.flare_countdown = level.flare_countdown;

      if(isDefined(_id_089D6E7F82998C02.flare))
        _id_089D6E7F82998C02 _id_D60853DF1C1FFD8E(_id_089D6E7F82998C02.flare.origin);
    }
  }

  level._id_66A2200948D3FA7E[_id_F57BD7A1277D32C9] = undefined;
}

_id_AB76EC6CC6E3EABF() {
  self endon("death");

  for(;;) {
    scripts\engine\utility::waittill_any_timeout_1(10, "launch_mortar");

    if(isDefined(self.flare))
      _id_D60853DF1C1FFD8E(self.flare.origin);
  }
}

_id_D60853DF1C1FFD8E(endpos) {
  start = self gettagorigin("j_shaft_top");
  end = getgroundposition(self.origin + anglesToForward(self.angles) * 8000, 8, 1000);

  if(isDefined(endpos))
    end = endpos;

  _id_92753DA39919F200 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  _id_92753DA39919F200.flare_light = self.flare;
  _id_92753DA39919F200.flare_light_up = self._id_4B8C19E918877679;
  _id_92753DA39919F200.flare_lifetime = self.flare_lifetime;
  _id_92753DA39919F200.flare_countdown = self.flare_countdown;
  _id_92753DA39919F200.script_noteworthy = self.struct.script_noteworthy;
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));
  playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_flare_launch");
  time = 5;
  thread scripts\cp_mp\mortar_launcher::movemortar(_id_92753DA39919F200, start, end, time, 1200);
  thread _id_F50343C33D668AA4(_id_92753DA39919F200, end, time);
  wait(time);
  _id_92753DA39919F200.flare_light dontinterpolate();
  _id_92753DA39919F200.flare_light_up dontinterpolate();
  _id_92753DA39919F200.flare_light.origin = _id_92753DA39919F200.origin + (0, 0, 0);
  _id_92753DA39919F200.flare_light_up.origin = _id_92753DA39919F200.origin + (0, 0, 10);
  thread flare_light(_id_92753DA39919F200.flare_light, _id_92753DA39919F200.flare_lifetime);
  thread flare_light_up(_id_92753DA39919F200.flare_light_up, _id_92753DA39919F200.flare_lifetime);
  playFXOnTag(scripts\engine\utility::getfx("vfx_illumination_flare_unlit"), _id_92753DA39919F200, "tag_origin");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_illumination_flare_launch_trail"), _id_92753DA39919F200, "tag_origin");
  trace = scripts\engine\trace::ray_trace(_id_92753DA39919F200.origin, _id_92753DA39919F200.origin + (0, 0, -10000));
  end = trace["position"] + (0, 0, 1);
  level notify("flare_drop");
  _id_92753DA39919F200 thread scripts\engine\utility::playsoundontag("weap_mortar_flare_burst", "tag_origin");
  _id_92753DA39919F200 thread scripts\cp\utility::play_sound_on_tag("weap_mortar_flare_phosphorus_start", "tag_origin");
  _id_92753DA39919F200 thread flare_mover(end);
  _id_92753DA39919F200.flare_light thread flare_mover(end);
  _id_92753DA39919F200.flare_light_up thread flare_mover(end);
  _id_92753DA39919F200 thread flare_countdown();
  _id_92753DA39919F200 thread _id_A3F64DFCAD8AA0D0();
  wait(_id_92753DA39919F200.flare_lifetime);
  _id_92753DA39919F200 notify("cleanup_light_threads");
  _id_92753DA39919F200.flare_light notify("cleanup_light_threads");
  _id_92753DA39919F200.flare_light_up notify("cleanup_light_threads");
  _id_92753DA39919F200.flare_light unlink();
  _id_92753DA39919F200.flare_light_up unlink();
  _id_92753DA39919F200.flare_light.origin = _id_92753DA39919F200.flare_light.og_origin;
  _id_92753DA39919F200.flare_light.angles = _id_92753DA39919F200.flare_light.og_angles;
  _id_92753DA39919F200.flare_light_up.origin = _id_92753DA39919F200.flare_light_up.og_origin;
  _id_92753DA39919F200.flare_light_up.angles = _id_92753DA39919F200.flare_light_up.og_angles;
  _id_92753DA39919F200.flare_light setlightintensity(0);
  _id_92753DA39919F200.flare_light_up setlightintensity(0);

  foreach(player in level.players)
  _func_126234E884A5FC26(player, 1);

  _id_92753DA39919F200 delete();
}

_id_A3F64DFCAD8AA0D0() {
  self endon("death");
  self endon("cleanup_light_threads");
  thread _id_FA64E6BB0981A6C5();

  foreach(player in level.players)
  player thread _id_8C5BBE26F1A04428(self);
}

_id_FA64E6BB0981A6C5() {
  self endon("death");
  self endon("cleanup_light_threads");

  for(;;) {
    level waittill("connected", player);
    player thread _id_8C5BBE26F1A04428(self);
  }
}

_id_8C5BBE26F1A04428(_id_089D6E7F82998C02) {
  self notify(self.name + _id_089D6E7F82998C02.script_noteworthy);
  self endon(self.name + _id_089D6E7F82998C02.script_noteworthy);
  self endon("disconnect");
  _id_089D6E7F82998C02 endon("cleanup_light_threads");

  for(;;) {
    if(distance2dsquared(_id_089D6E7F82998C02.flare_light.origin, self.origin) <= _id_089D6E7F82998C02.flare_light _meth_2C41B0490398B48B() * _id_089D6E7F82998C02.flare_light _meth_2C41B0490398B48B()) {
      _func_126234E884A5FC26(self, 0);
      scripts\cp\coop_stealth::set_maxvisibledist(1500);
    }

    waitframe();
  }
}

_id_F50343C33D668AA4(_id_92753DA39919F200, end, time) {
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), _id_92753DA39919F200, "tag_origin");
  _id_92753DA39919F200 playLoopSound("weap_mortar_fly_lp");
  wait(time - 1.7);
  _id_92753DA39919F200 playSound("weap_mortar_incoming");
  wait 1.7;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), _id_92753DA39919F200, "tag_origin");
  _id_92753DA39919F200 stoploopsound();
  playFX(scripts\engine\utility::getfx("vfx_mortar_explosion"), end);
  earthquake(0.25, 3, end, 2048);

  if(!istrue(level.ismp))
    playrumbleonposition("cp_chopper_rumble", end);
  else {
    playrumbleonposition("grenade_rumble", end);
    playsoundatpos(end, "weap_mortar_expl_trans");
  }
}

flare_light(flare_light, flare_lifetime) {
  waitframe();
  _id_2B720D2B45858844 = 200;
  _id_06B1CFFD60900A10 = 2;
  _id_E019766D71735923 = 5;
  og_radius = flare_light _meth_2C41B0490398B48B();
  _id_2B720D2B45858844 = 240;

  if(isDefined(flare_light.intensity))
    _id_2B720D2B45858844 = flare_light.intensity;

  flare_light _meth_8A5136D4D87795D4((1, 0.95, 1.25));
  flare_light _meth_3988B5EA084F310F(flare_light _meth_2C41B0490398B48B() * 0.9);
  flare_light thread lerp_value_up(0, _id_2B720D2B45858844, _id_06B1CFFD60900A10);
  flare_light thread flicker_flare(_id_06B1CFFD60900A10, _id_2B720D2B45858844, _id_E019766D71735923);
  wait(flare_lifetime - _id_E019766D71735923);
  flare_light lerp_value_up(_id_2B720D2B45858844, 0, _id_E019766D71735923);
  flare_light _meth_3988B5EA084F310F(og_radius);
}

flicker_flare(delay_time, _id_2B720D2B45858844, _id_E019766D71735923) {
  self endon("cleanup_light_threads");
  wait(delay_time);

  while(self.flare_countdown > _id_E019766D71735923) {
    self setlightintensity(randomfloatrange(_id_2B720D2B45858844 / 4, _id_2B720D2B45858844));
    waitframe();
  }
}

flare_light_up(_id_4B8C19E918877679, lifetime) {
  og_radius = _id_4B8C19E918877679 _meth_2C41B0490398B48B();
  waitframe();
  _id_803CA6F1B38D09E6 = 666.0;
  _id_B31F696BF4DC48A6 = 1.5;
  _id_1DA3422D32BAE01D = 3;
  _id_4B8C19E918877679 _meth_8A5136D4D87795D4((1, 0.95, 1.25));
  _id_4B8C19E918877679 _meth_3988B5EA084F310F(_id_4B8C19E918877679.flare_light _meth_2C41B0490398B48B() * 0.9);
  _id_4B8C19E918877679 thread lerp_value_up(0, _id_803CA6F1B38D09E6, _id_B31F696BF4DC48A6);
  _id_4B8C19E918877679 thread flicker_flare_up(_id_4B8C19E918877679, _id_B31F696BF4DC48A6, _id_803CA6F1B38D09E6, _id_1DA3422D32BAE01D);
  wait(lifetime - _id_1DA3422D32BAE01D);
  _id_4B8C19E918877679 lerp_value_up(_id_803CA6F1B38D09E6, 0, _id_1DA3422D32BAE01D);
  _id_4B8C19E918877679 _meth_3988B5EA084F310F(og_radius);
}

lerp_value_up(curr, value, time) {
  self endon("cleanup_light_threads");
  range = value - curr;
  interval = 0.05;
  count = int(time / interval);

  if(count > 0) {
    for(_id_3777ECE6A73EADA5 = range / count; count; count--) {
      curr = curr + _id_3777ECE6A73EADA5;
      self setlightintensity(curr);
      wait(interval);
    }
  }
}

flicker_flare_up(_id_4B8C19E918877679, delay_time, _id_803CA6F1B38D09E6, _id_1DA3422D32BAE01D) {
  self endon("cleanup_light_threads");
  wait(delay_time);

  while(_id_4B8C19E918877679.flare_countdown > _id_1DA3422D32BAE01D) {
    _id_4B8C19E918877679 setlightintensity(randomfloatrange(_id_803CA6F1B38D09E6 / 8, _id_803CA6F1B38D09E6));
    waitframe();
  }
}

flare_countdown() {
  self endon("cleanup_light_threads");
  self.flare_countdown = self.flare_lifetime;

  for(_id_AC0E594AC96AA3A8 = self.flare_lifetime; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
    self.flare_countdown--;
    wait 1;
  }
}

_id_91E34877A7E0A7D6() {
  while(!isDefined(level.players))
    waitframe();

  while(level.players.size == 0)
    waitframe();

  init_flags();
  _id_06D7D5CBCC146302 = get_pavelow_boss_info();
}

phase_zero_combat(pavelow_boss) {
  level.get_chopper_boss_combat_action = undefined;
  level.get_chopper_boss_combat_action = _id_7E1A468DA43087E3::get_forest_combat_logic;
  scripts\engine\utility::flag_wait("chopper_boss_has_been_damaged");
}

init_flags() {
  scripts\engine\utility::flag_init("chopper_boss_spawn");
  scripts\engine\utility::flag_init("chopper_boss_fight_cave_complete");
  scripts\engine\utility::flag_init("chopper_boss_fight_laser_trap_complete");
  scripts\engine\utility::flag_init("chopper_boss_fight_laser_trap_door_opened");
  scripts\engine\utility::flag_init("chopper_boss_fight_player_enter_catwalk");
  scripts\engine\utility::flag_init("chopper_boss_fight_laser_trap_shutted_down");
  scripts\engine\utility::flag_init("chopper_boss_destroyed");
  scripts\engine\utility::flag_init("chopper_boss_wave_one_completed");
  scripts\engine\utility::flag_init("chopper_boss_wave_two_completed");
  scripts\engine\utility::flag_init("chopper_boss_has_been_damaged");
}

_id_A533D6D87ACB7C85(chopper_boss, _id_2465C35C543F5C38) {
  return "search";
}

get_pavelow_boss_info() {
  _id_06D7D5CBCC146302 = spawnStruct();
  return _id_06D7D5CBCC146302;
}

pavelow_boss_damage_func(pavelow_boss, _id_793E2524735293A1, damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon) {
  if(!should_damage_pavelow_boss(weapon)) {
    return;
  }
  scripts\engine\utility::flag_set("chopper_boss_has_been_damaged");
  pavelow_boss setscriptablepartstate("body_damage_light", "on");

  if(_id_793E2524735293A1)
    play_hit_marker_to_player(attacker);

  if(getdvarint("dvar_662381C72D041459", 0) != 0) {
    return;
  }
  pavelow_boss.fake_health = pavelow_boss.fake_health - damage;
  update_health_bar_to_players(pavelow_boss);

  if(pavelow_boss.fake_health <= 2000)
    pavelow_boss setscriptablepartstate("body_damage_medium", "on");

  if(pavelow_boss.fake_health <= 1000)
    pavelow_boss setscriptablepartstate("body_damage_heavy", "on");
  else if(pavelow_boss.fake_health <= 0)
    pavelow_boss thread pavelow_boss_crash_sequence(pavelow_boss);
}

should_damage_pavelow_boss(weapon) {
  if(!isDefined(weapon))
    return 0;

  if(!isDefined(weapon.basename))
    return 0;

  if(getdvarint("dvar_662381C72D041459", 0) != 0)
    return 1;

  switch (weapon.basename) {
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw9_la_gromeo_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
      return 1;
    default:
      return 0;
  }
}

play_hit_marker_to_player(attacker) {
  attacker thread _id_354C862768CFE202::updatedamagefeedback("hitcritical");
}

hide_health_bar_to_players() {
  foreach(player in level.players) {
    if(isDefined(player.pavelow_boss_health_bar))
      player.pavelow_boss_health_bar scripts\cp\utility::destroyelem();
  }
}

health_bar_player_connect_monitor(pavelow_boss) {
  pavelow_boss endon("death");

  for(;;) {
    level waittill("connected", player);
    player thread wait_display_pavelow_boss_health_bar(player, pavelow_boss);
  }
}

wait_display_pavelow_boss_health_bar(player, pavelow_boss) {
  player endon("disconnect");
  pavelow_boss endon("death");
  player waittill("loadout_given");
  update_health_bar_to_player(player, pavelow_boss);
}

update_health_bar_to_players(pavelow_boss) {
  foreach(player in level.players)
  update_health_bar_to_player(player, pavelow_boss);
}

update_health_bar_to_player(player, pavelow_boss) {
  if(!isDefined(player.pavelow_boss_health_bar)) {
    player.pavelow_boss_health_bar = player scripts\cp\utility::createprimaryprogressbar(0, 0, 300, 3);
    player.pavelow_boss_health_bar scripts\cp\utility::setpoint("center", "center", 0, -175);
  }

  player.pavelow_boss_health_bar scripts\cp\utility::updatebarscale(max(0, pavelow_boss.fake_health / 3000));
}

pavelow_boss_crash_sequence(pavelow_boss) {
  _id_87C80C8AF34C3558 = 50;
  _id_935FFA45945DE13B = 15;
  _id_17D6DCCE3E58BA92 = 10;
  pavelow_boss vehicle_setspeed(_id_87C80C8AF34C3558, _id_935FFA45945DE13B, _id_17D6DCCE3E58BA92);
  pavelow_boss playLoopSound("hind_helicopter_dying_loop");
  level.get_chopper_boss_combat_action = undefined;
  pavelow_boss thread keep_rotating(pavelow_boss);
  _id_2FE995B5748F0B4A = scripts\engine\utility::getStructArray("chopper_boss_crash_node", "targetname");
  _id_595E3BEF92B4AA71 = scripts\engine\utility::random(_id_2FE995B5748F0B4A);
  pavelow_boss_explodes(pavelow_boss);
}

keep_rotating(pavelow_boss) {
  pavelow_boss endon("death");
  pavelow_boss clearlookatent();
  pavelow_boss setmaxpitchroll(60, 90);
  pavelow_boss setyawspeed(700, 200, 200);

  for(;;) {
    if(!isDefined(pavelow_boss)) {
      return;
    }
    _id_3F403475C9BCA3F7 = randomintrange(140, 170);
    pavelow_boss settargetyaw(pavelow_boss.angles[1] + _id_3F403475C9BCA3F7);
    wait 0.5;
  }
}

pavelow_boss_explodes(pavelow_boss) {
  _id_8569C3995A389EBC = pavelow_boss.origin;
  pavelow_boss delete();
  playFX(level._effect["chopper_boss_explosion"], _id_8569C3995A389EBC);
  playsoundatpos(_id_8569C3995A389EBC, "veh_chopper_support_crash");
  earthquake(0.5, 3, _id_8569C3995A389EBC, 50000);

  foreach(player in level.players)
  player playRumbleOnEntity("artillery_rumble_heavy");

  level notify("pavelow_boss_crashed");
}

_id_AC0E704DD1BD0999(objectivestruct, _id_5DCDFD3A4EFF9961) {
  objectivestruct.trigger = getEnt("find_base", "script_noteworthy");
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp\equipment\nvg::runnvg);
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_E7C086FF6543FD5F);

  foreach(player in level.players)
  player thread _id_E7C086FF6543FD5F();
}

_id_2343B6DFD2D46275(objectivestruct, _id_5DCDFD3A4EFF9961) {
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0) {
    if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) == 1)
      _id_18A73A64992DD07D::run_spawn_module("bs_stealth_debug_nomove");
    else
      _id_18A73A64992DD07D::run_spawn_module("bs_stealth_debug_move");
  } else
    thread _id_77F141849D5CFC70(5);

  level waittill("point_crossed");
}

_id_86840537B3EE0B2C(objectivestruct, _id_5DCDFD3A4EFF9961) {
  _id_7E1A468DA43087E3::_id_A9B8DD7261DE2FAD();
}

_id_89E129EA2178B9B2(objectivestruct) {
  scripts\engine\utility::flag_wait("cp_bs_cs_completed");

  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    scripts\cp\utility::teleportallplayersinteamtostructs("allies", "bs_debug_spawners", 1);
  else if(!istrue(level._id_EFE609BCE901CAA8))
    scripts\cp\utility::teleportallplayersinteamtostructs("allies", "bs_spawner", 1);

  foreach(player in level.players)
  player scripts\cp\equipment\nvg::runnvg();
}

_id_E281027A9686A491(stringref, location) {
  level._id_324A6E68A953D960++;
  _id_742F61B6768A1AAB::_id_A61FBDC458CDBB1E();
  level notify("checkpoint_update", stringref, location);
}

_id_ABD47CB8E8E2A6D0(identifier, objectiveindex) {
  self notify("intel_load");
  self endon("intel_load");
  self endon("death");
  hintstring = &"CP_BAD_SITUATION_OBJ/PICKUP_RADOBJ";
  self.identifier = identifier;
  self.objectiveindex = objectiveindex;
  _id_51023E7DB5068D92::_id_0C0B9633531D23BA();
  _id_479E458F6F530F0D::_id_F0D61E14DFDE9CCD(self.scriptable);
  level._id_E7B157FD6CF95460[level._id_E7B157FD6CF95460.size] = self;
  thread _id_433D5BEE74FDB0ED(self);
  thread _id_49087F8C06B0DEA2(self);
  thread _id_E87B9A3563E809E2(self);
  self makeunusable();

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      player thread scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");

      if(getdvarint("dvar_3BD8C43F07F76C70", 0) != 0) {
        if(isDefined(level._id_F30F234DCD5FE40B)) {
          if(scripts\engine\utility::array_contains(level._id_F30F234DCD5FE40B, self))
            level._id_F30F234DCD5FE40B = scripts\engine\utility::array_remove(level._id_F30F234DCD5FE40B, self);

          foreach(guy in level.players)
          guy thread scripts\cp\cp_hud_message::showsplash("cp_intel_mission_complete");

          _id_479E458F6F530F0D::_id_A67007B5AF86FF0B(self.scriptable);

          if(istrue(player._id_9FC03D4C05F67987))
            level notify("radiation_objective_completed", "iskra", player);
          else
            level notify("radiation_objective_completed", "nikto", player);

          scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();

          if(level._id_F30F234DCD5FE40B.size == 0) {
            foreach(guy in level.players)
            guy notify("kill_nuke_thread");
          }
        }

        if(isDefined(player.windobject))
          player.windobject.state = "light";
      }

      self hide();
      self _meth_DFB78B3E724AD620(0);

      if(isDefined(objectiveindex))
        objective_state(objectiveindex, "done");

      if(isDefined(self.objectiveindex))
        objective_state(self.objectiveindex, "done");

      scripts\cp\cp_objectives::freeworldid(identifier);
      _id_E281027A9686A491("usb", self.script_noteworthy);

      foreach(guy in level.players) {
        guy setclientomnvar("ui_geigercounter_meter", 0);

        if(self.script_noteworthy == "a")
          guy _id_3C26BBA307588EC3(2, 1);

        if(self.script_noteworthy == "b")
          guy _id_3C26BBA307588EC3(4, 1);

        if(self.script_noteworthy == "c")
          guy _id_3C26BBA307588EC3(8, 1);

        if(self.script_noteworthy == "barn") {
          guy _id_3C26BBA307588EC3(2, 1);
          continue;
        }

        if(self.script_noteworthy == "town") {
          guy _id_3C26BBA307588EC3(4, 1);
          continue;
        }
      }

      thread _id_74EF78C75DC44055(self.script_noteworthy, player);
      self delete();
      break;
    }
  }
}

_id_74EF78C75DC44055(objname, _id_59AF5DDCF410D576) {
  switch (objname) {
    case "a":
      break;
    case "b":
      break;
    case "c":
      break;
  }

  _id_3D2B347B4893E2BF = level._id_D0ADA23E81337306.size + level._id_324A6E68A953D960;

  switch (_id_3D2B347B4893E2BF) {
    case 1:
      if(_func_EAC0CD99C9C6D8EE() == "spotted") {
        _id_59AF5DDCF410D576 _id_613662165F17A93A::_id_45530849345CAAD8();
        wait 1.5;
        wait 1.5;

        if(scripts\engine\utility::cointoss())
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_wegotwhatwecameforcl");
        else if(scripts\engine\utility::cointoss())
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_wehavetosecuretheoth");
        else
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_weneedyoutosecurethe");
      } else {
        _id_59AF5DDCF410D576 _id_613662165F17A93A::_id_45530849345CAAD8();
        wait 1.5;
        _id_CEB1FF9428033CFD = _id_7E1A468DA43087E3::_id_1F35F09BD3F3DC51(_id_59AF5DDCF410D576);

        foreach(g in _id_CEB1FF9428033CFD)
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(g, "stat_7CB1A871B292B051");

        wait 2;

        if(scripts\engine\utility::cointoss())
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_goodworkletssecureth");
        else if(scripts\engine\utility::cointoss())
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_excellentletsmoveont");
        else
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_wereonitbreakerletss");
      }

      break;
    case 2:
      if(_func_EAC0CD99C9C6D8EE() == "spotted") {
        _id_59AF5DDCF410D576 _id_613662165F17A93A::_id_45530849345CAAD8();
        wait 2;

        if(scripts\engine\utility::cointoss()) {
          if(scripts\engine\utility::cointoss())
            _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_breakcontactmovetoth");
          else
            _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_dontletthemstopyougo");
        } else if(scripts\engine\utility::cointoss())
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_keepmovinggettothela");
        else
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_cleartheareamoveonth");
      } else {
        _id_59AF5DDCF410D576 _id_613662165F17A93A::_id_45530849345CAAD8();
        wait 1.5;
        _id_CEB1FF9428033CFD = _id_7E1A468DA43087E3::_id_1F35F09BD3F3DC51(_id_59AF5DDCF410D576);

        foreach(g in _id_CEB1FF9428033CFD)
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(g, "stat_7CB1A871B292B051");

        wait 1.5;

        if(_id_613662165F17A93A::_id_A3BA3D17613320E9("a") && _id_613662165F17A93A::_id_A3BA3D17613320E9("b"))
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_onemoretogoletsgetto");
        else if(_id_613662165F17A93A::_id_A3BA3D17613320E9("b") && _id_613662165F17A93A::_id_A3BA3D17613320E9("c"))
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_excellentworkgettobr");
        else if(_id_613662165F17A93A::_id_A3BA3D17613320E9("a") && _id_613662165F17A93A::_id_A3BA3D17613320E9("c"))
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_twodowncharlietogoge");
        else
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_onemoretogoletsfinis");
      }

      break;
    case 3:
    default:
      if(_func_EAC0CD99C9C6D8EE() == "spotted") {
        _id_59AF5DDCF410D576 _id_613662165F17A93A::_id_45530849345CAAD8();
        wait 2;
      } else {
        _id_59AF5DDCF410D576 _id_613662165F17A93A::_id_45530849345CAAD8();
        wait 1.5;
        _id_CEB1FF9428033CFD = _id_7E1A468DA43087E3::_id_1F35F09BD3F3DC51(_id_59AF5DDCF410D576);

        foreach(g in _id_CEB1FF9428033CFD)
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(g, "stat_7CB1A871B292B051");

        wait 2;
      }

      scripts\engine\utility::flag_set("safe_to_start_exfil_briefing");
      thread _id_3BAD31F1C9A116F3();
      break;
  }
}

_id_3BAD31F1C9A116F3() {
  scripts\engine\utility::flag_set("stealth_music_pause");
  setmusicstate("mx_cp_hydro_stealth_hidden");
  wait 5;
  setmusicstate("mx_cp_hydro_exfil");

  foreach(player in level.players)
  player setsoundsubmix("iw9_cp_hydro_exfil_to_lz", 2);
}

_id_49087F8C06B0DEA2(_id_CC4B9CFA93202799) {
  _id_CC4B9CFA93202799 endon("death");
  _id_CC4B9CFA93202799 notify("hint_startOverlordHintsForPOIs");
  _id_CC4B9CFA93202799 endon("hint_startOverlordHintsForPOIs");

  if(!isDefined(level._id_DA9DB406A115FEC2))
    level._id_DA9DB406A115FEC2 = [];

  for(;;) {
    waitframe();
    scripts\engine\utility::flag_wait("laswell_intro_vo_done");

    if(_func_EAC0CD99C9C6D8EE() == "spotted") {
      continue;
    }
    _id_6D8E8725698EEFC2 = scripts\engine\utility::get_array_of_closest(_id_CC4B9CFA93202799.origin, level.players, undefined, undefined, 2900);

    if(isDefined(_id_6D8E8725698EEFC2) && _id_6D8E8725698EEFC2.size > 0) {
      level._id_C2D845CA09FB7053 = undefined;
      _id_B46496BA73DC641B = "stealth_" + _id_CC4B9CFA93202799.script_noteworthy;
      _id_6D8E8725698EEFC2 = scripts\engine\utility::get_array_of_closest(_id_CC4B9CFA93202799.origin, level.players, undefined, undefined, 1024);

      if(isDefined(_id_6D8E8725698EEFC2) && _id_6D8E8725698EEFC2.size > 0) {
        foreach(player in _id_6D8E8725698EEFC2) {
          if(isDefined(player._id_D8C1657269BA71F8)) {
            if(istrue(player._id_D8C1657269BA71F8[_id_CC4B9CFA93202799.script_noteworthy])) {
              if(!istrue(level._id_DA9DB406A115FEC2[_id_B46496BA73DC641B]))
                level._id_DA9DB406A115FEC2[_id_B46496BA73DC641B] = 1;
            }
          }
        }

        if(isDefined(level._id_54DA6E863D463AC0))
          [[level._id_54DA6E863D463AC0]](_id_B46496BA73DC641B, _id_6D8E8725698EEFC2, _id_CC4B9CFA93202799.script_noteworthy);
      } else if(isDefined(level._id_9EE21672DC268105))
        [[level._id_9EE21672DC268105]](_id_B46496BA73DC641B, _id_CC4B9CFA93202799);

      continue;
    }

    level._id_C2D845CA09FB7053 = 1;
  }
}

_id_E87B9A3563E809E2(_id_CC4B9CFA93202799) {
  _id_CC4B9CFA93202799 endon("death");
  _id_CC4B9CFA93202799 notify("hint_startRadObjHint");
  _id_CC4B9CFA93202799 endon("hint_startRadObjHint");

  for(;;) {
    waitframe();
    scripts\engine\utility::flag_wait("laswell_intro_vo_done");
    _id_6D8E8725698EEFC2 = scripts\engine\utility::get_array_of_closest(_id_CC4B9CFA93202799.origin, level.players, undefined, undefined, 128);

    foreach(closestplayer in _id_6D8E8725698EEFC2) {
      if(!isDefined(closestplayer._id_8CBF0A69A9D40732))
        closestplayer._id_8CBF0A69A9D40732 = [];

      if(!isDefined(closestplayer._id_8CBF0A69A9D40732[_id_CC4B9CFA93202799.script_noteworthy]))
        closestplayer._id_8CBF0A69A9D40732[_id_CC4B9CFA93202799.script_noteworthy] = 0;

      if(istrue(closestplayer._id_8CBF0A69A9D40732[_id_CC4B9CFA93202799.script_noteworthy])) {
        continue;
      }
      if(isDefined(closestplayer) && closestplayer _id_613662165F17A93A::_id_0256B4743906AC2F(_id_CC4B9CFA93202799, undefined)) {
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(closestplayer, "stat_2A647E3265A23CCA");
        thread _id_5B0659FEDD5264BD();
        closestplayer._id_8CBF0A69A9D40732[_id_CC4B9CFA93202799.script_noteworthy] = 1;
        return;
      }
    }
  }
}

_id_5B0659FEDD5264BD() {
  level endon("disconnect");
  wait 2;
  _id_2ADBA961C731BAF6 = randomintrange(1, 8);
  alias = "";

  switch (_id_2ADBA961C731BAF6) {
    case 1:
      alias = "dx_cp_cphy_acst_lasw_goodfindsticktothemi";
      break;
    case 2:
      alias = "dx_cp_cphy_acst_lasw_goodeyeouranalystswi";
      break;
    case 3:
      alias = "dx_cp_cphy_acst_lasw_goodworkkeepitup";
      break;
    case 4:
      alias = "dx_cp_cphy_acst_lasw_anythingtohelpusstay";
      break;
    case 5:
      alias = "dx_cp_cphy_acst_lasw_nicenowkeephuntingfo";
      break;
    case 6:
      alias = "dx_cp_cphy_acst_lasw_goodeye";
      break;
    case 7:
      alias = "dx_cp_cphy_acst_lasw_waytokeepaneyeout";
      break;
  }

  if(alias != "")
    _id_7E1A468DA43087E3::_id_775CD164C569E279(alias);
}

_id_433D5BEE74FDB0ED(_id_CC4B9CFA93202799) {
  _id_CC4B9CFA93202799 endon("death");
  _id_CC4B9CFA93202799 notify("hint_startGeigerCounterHint");
  _id_CC4B9CFA93202799 endon("hint_startGeigerCounterHint");

  for(;;) {
    waitframe();

    if(_func_EAC0CD99C9C6D8EE() == "spotted") {
      continue;
    }
    _id_6D8E8725698EEFC2 = scripts\engine\utility::get_array_of_closest(_id_CC4B9CFA93202799.origin, level.players, undefined, undefined, 333);

    foreach(closestplayer in _id_6D8E8725698EEFC2) {
      closestplayer._id_8B865BC6FCCF805B = undefined;

      if(!isDefined(closestplayer._id_D8C1657269BA71F8))
        closestplayer._id_D8C1657269BA71F8 = [];

      if(!isDefined(closestplayer._id_D8C1657269BA71F8[_id_CC4B9CFA93202799.script_noteworthy]))
        closestplayer._id_D8C1657269BA71F8[_id_CC4B9CFA93202799.script_noteworthy] = 0;

      if(istrue(closestplayer._id_294EF29A452328DA)) {
        continue;
      }
      if(istrue(closestplayer._id_D8C1657269BA71F8[_id_CC4B9CFA93202799.script_noteworthy])) {
        continue;
      }
      if(isDefined(level._id_B42368D46E1FDFDD[_id_CC4B9CFA93202799.script_noteworthy])) {
        if(gettime() < level._id_B42368D46E1FDFDD[_id_CC4B9CFA93202799.script_noteworthy])
          continue;
      }

      if(isDefined(closestplayer) && closestplayer _id_7EF95BBA57DC4B82::hasequipment("equip_geigercounter")) {
        closestplayer._id_8B865BC6FCCF805B = 1;

        if(isDefined(closestplayer._id_BCB3E1F6F7CD3CB7) && !istrue(closestplayer._id_BCB3E1F6F7CD3CB7._id_4B47429F8D0D3EE5)) {
          closestplayer._id_294EF29A452328DA = 1;
          closestplayer sethudtutorialmessage(&"COOP_GAME_PLAY/HINT_GEIGER_COUNTER", 1);
          closestplayer._id_D8C1657269BA71F8[_id_CC4B9CFA93202799.script_noteworthy] = 1;
          _id_CC4B9CFA93202799 thread _id_762EECECFACA8B67(8, closestplayer);
          _id_CC4B9CFA93202799 thread _id_24D6D22DEE70B61D(closestplayer);
          _id_CC4B9CFA93202799 thread _id_3B28C58AAA2E2BB5(closestplayer);
        } else
          _id_CC4B9CFA93202799 thread _id_FE06399E09BF6052(closestplayer);

        level._id_B42368D46E1FDFDD[_id_CC4B9CFA93202799.script_noteworthy] = gettime() + 25000;
      }
    }
  }
}

_id_3B28C58AAA2E2BB5(closestplayer) {
  if(scripts\engine\utility::flag(self.script_noteworthy + "notpulledout_geiger_hint")) {
    return;
  }
  scripts\engine\utility::flag_set(self.script_noteworthy + "notpulledout_geiger_hint");

  if(scripts\engine\utility::cointoss())
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_breaker1yourgettinga");
  else if(scripts\engine\utility::cointoss())
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_11youregettingareadi");
  else
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_12youregettingareadi");

  wait 1.5;
  _id_613662165F17A93A::_id_57A8C25A4A5F3B82();
}

_id_FE06399E09BF6052(closestplayer) {
  if(scripts\engine\utility::flag(self.script_noteworthy + "pulledout_geiger_hint")) {
    return;
  }
  scripts\engine\utility::flag_set(self.script_noteworthy + "pulledout_geiger_hint");

  if(scripts\engine\utility::cointoss()) {
    if(scripts\engine\utility::cointoss()) {
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_whatwereaftersinthat");
      wait 1.5;
    } else
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_solidcopytheobjectiv");
  } else if(scripts\engine\utility::cointoss())
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_thatsconfirmationthe");
  else
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_yepthatsourbuilding");

  wait 1.5;
  _id_613662165F17A93A::_id_57A8C25A4A5F3B82();
}

_id_24D6D22DEE70B61D(player) {
  self endon("stop_hint");
  self notify("hint_stopHintIfObjectIsPickedUp");
  self endon("hint_stopHintIfObjectIsPickedUp");
  self waittill("death");
  player._id_294EF29A452328DA = undefined;
  player clearhudtutorialmessage();
}

_id_762EECECFACA8B67(delay, player) {
  self endon("death");
  self notify("hint_resetStatusAfterTimeout");
  self endon("hint_resetStatusAfterTimeout");
  player scripts\engine\utility::waittill_any_timeout_1(delay, "pullout_gc");
  player._id_294EF29A452328DA = undefined;
  player clearhudtutorialmessage();
  self notify("stop_hint");
}

script_model_anims() {
  level.scr_animtree["nuke"] = #animtree;
  level.scr_anim["nuke"]["nuke_open"] = % cp_prop_nuclear_warhead_open;
  level.scr_animname["nuke"]["nuke_open"] = "cp_prop_nuclear_warhead_open";
}

init_player_falling_anims() {
  level.scr_animtree["player_falling"] = #animtree;
  level.scr_anim["player_falling"]["player_1"] = % cp_scripted_747_ending_jump_plr1;
  level.scr_animname["player_falling"]["player_1"] = "cp_scripted_747_ending_jump_plr1";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_jump_plr1";
  level.scr_eventanim["player_falling"]["player_1"] = "end_jump_plr1";
  level.scr_anim["player_falling"]["player_2"] = % cp_scripted_747_ending_jump_plr2;
  level.scr_animname["player_falling"]["player_2"] = "cp_scripted_747_ending_jump_plr2";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_jump_plr2";
  level.scr_eventanim["player_falling"]["player_2"] = "end_jump_plr2";
  level.scr_anim["player_falling"]["player_3"] = % cp_scripted_747_ending_jump_plr3;
  level.scr_animname["player_falling"]["player_3"] = "cp_scripted_747_ending_jump_plr3";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_jump_plr3";
  level.scr_eventanim["player_falling"]["player_3"] = "end_jump_plr3";
  level.scr_anim["player_falling"]["player_4"] = % cp_scripted_747_ending_jump_plr4;
  level.scr_animname["player_falling"]["player_4"] = "cp_scripted_747_ending_jump_plr4";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_jump_plr4";
  level.scr_eventanim["player_falling"]["player_4"] = "end_jump_plr4";
  level.scr_anim["player_falling"]["player_1_end"] = % cp_scripted_747_ending_exit_plr1;
  level.scr_animname["player_falling"]["player_1_end"] = "cp_scripted_747_ending_exit_plr1";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_exit_plr1";
  level.scr_eventanim["player_falling"]["player_1_end"] = "end_exit_plr1";
  level.scr_anim["player_falling"]["player_2_end"] = % cp_scripted_747_ending_exit_plr2;
  level.scr_animname["player_falling"]["player_2_end"] = "cp_scripted_747_ending_exit_plr2";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_exit_plr2";
  level.scr_eventanim["player_falling"]["player_2_end"] = "end_exit_plr2";
  level.scr_anim["player_falling"]["player_3_end"] = % cp_scripted_747_ending_exit_plr3;
  level.scr_animname["player_falling"]["player_3_end"] = "cp_scripted_747_ending_exit_plr3";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_exit_plr3";
  level.scr_eventanim["player_falling"]["player_3_end"] = "end_exit_plr3";
  level.scr_anim["player_falling"]["player_4_end"] = % cp_scripted_747_ending_exit_plr4;
  level.scr_animname["player_falling"]["player_4_end"] = "cp_scripted_747_ending_exit_plr4";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_exit_plr4";
  level.scr_eventanim["player_falling"]["player_4_end"] = "end_exit_plr4";
}

_id_CE37FA428031FAE1() {
  foreach(player in level.players)
  player thread _id_802C49684CFE6859(self);
}

_id_802C49684CFE6859(ent) {
  self notify("hide_and_show_based_on_proximity" + ent.script_noteworthy);
  self endon("hide_and_show_based_on_proximity" + ent.script_noteworthy);
  self endon("disconnect");
  ent endon("death");
  player = self;

  if(!isDefined(player._id_8AB2F6F467D470D4))
    player._id_8AB2F6F467D470D4 = [];

  player._id_8AB2F6F467D470D4[ent.script_noteworthy] = undefined;

  for(;;) {
    if(!isDefined(ent.objectiveindex)) {
      continue;
    }
    _id_F25430617AB002F8 = distance2dsquared(player.origin, ent.origin);

    if(isDefined(ent._id_5F2112921F67C9CE))
      _id_F25430617AB002F8 = distance2dsquared(player.origin, ent._id_5F2112921F67C9CE.origin);

    if(isDefined(_id_F25430617AB002F8) && _id_F25430617AB002F8 > 4194304) {
      if(!istrue(player._id_8AB2F6F467D470D4[ent.script_noteworthy])) {
        objective_addclienttomask(ent.objectiveindex, player);
        player._id_8AB2F6F467D470D4[ent.script_noteworthy] = 1;
      }
    } else if(istrue(player._id_8AB2F6F467D470D4[ent.script_noteworthy])) {
      objective_state(ent.objectiveindex, "current");
      objective_removeclientfrommask(ent.objectiveindex, player);
      player._id_8AB2F6F467D470D4[ent.script_noteworthy] = undefined;
    }

    wait 0.5;
  }
}

closenukecrate(crate) {
  crate useanimtree(#animtree);
  crate.animname = "nuke";
  crate thread scripts\common\anim::anim_first_frame_solo(crate, "nuke_open");
}

_id_B447727705929B4F(flag) {
  return self.pers["intel"] &flag;
}

_id_3C26BBA307588EC3(flag, _id_B96D126FC701024B) {
  if(_id_B96D126FC701024B)
    self.pers["intel"] = self.pers["intel"] | flag;
  else
    self.pers["intel"] = self.pers["intel"] &~flag;
}

spawn_drones() {
  _id_73862822B52EBF71 = scripts\engine\utility::getStruct("drone_spawn_trigger", "targetname");
  _id_ABD9EE4725B96FC2 = _id_73862822B52EBF71.radius * _id_73862822B52EBF71.radius;
  _id_94388E6B3645AF0C = 0;

  while(!_id_94388E6B3645AF0C) {
    foreach(player in level.players) {
      if(distance2dsquared(player.origin, _id_73862822B52EBF71.origin) < _id_ABD9EE4725B96FC2)
        _id_94388E6B3645AF0C = 1;
    }

    wait 0.1;
  }

  level.astar_node_radius_override = 8;
  level._id_9DEF439B33EAC09D = 0;
  level._id_0AC33444DF3B5F6B = 10;
  level._id_E769257BA0EA53F7 = -10;
  level._id_892990D1B2DA4A65 = 443556;
  level._id_8C0C40822E2C4024 = 1;
  _id_26312840E0E05273 = scripts\engine\utility::getStructArray("drone_spawn", "targetname");
  level._id_41543DD7848ADA95 = getdvarint("dvar_1B8014A11247469F", 5);
  counter = 0;

  foreach(spawnpoint in _id_26312840E0E05273) {
    if(counter > level._id_41543DD7848ADA95) {
      return;
    }
    scripts\cp\cp_enemy_drone_turret::spawn_enemy_drone_turret(spawnpoint);
    counter++;
  }
}

spawn_para_and_heli_logic() {
  level notify("spawn_para_and_heli_logic");
  level endon("spawn_para_and_heli_logic");
  level endon("stop_paratroopers");

  if(istrue(level._id_D544184F8833405C)) {
    return;
  }
  area = "barn";
  para_groups = ["barn_paratroopers_low", "barn_paratroopers_high"];
  _id_5A1D4CEF45C5C270 = [];
  _id_5A1D4CEF45C5C270["barn"] = 1;
  _id_5A1D4CEF45C5C270["town"] = 1;
  _id_5A1D4CEF45C5C270["farms"] = 1;
  _id_5A1D4CEF45C5C270["exfil"] = 1;
  level._id_D544184F8833405C = 1;

  for(;;) {
    while(level.spawned_ai.size >= 13)
      wait 1;

    area = _id_76E5CB6270CD98F1();
    _id_18A73A64992DD07D::run_spawn_module(area + "_heli_low");
    thread vo_paratroopers();
    para_groups = [area + "_paratroopers_low", area + "_paratroopers_high"];

    switch (area) {
      case "barn":
        thread scripts\cp\cp_aiparachute::request_paratroopers(scripts\engine\utility::random(para_groups), undefined, (-13512, 66432, 5904));
        break;
      case "town":
        thread scripts\cp\cp_aiparachute::request_paratroopers(scripts\engine\utility::random(para_groups), undefined, (-13512, 66432, 5904));
        break;
      case "farms":
        thread scripts\cp\cp_aiparachute::request_paratroopers(scripts\engine\utility::random(para_groups), undefined, (-13512, 66432, 5904));
        break;
      case "exfil":
        thread scripts\cp\cp_aiparachute::request_paratroopers(scripts\engine\utility::random(para_groups), undefined, (-13512, 66432, 5904));
        break;
    }

    wait(45 * _id_5A1D4CEF45C5C270[area]);
    _id_5A1D4CEF45C5C270[area]++;
  }
}

_id_76E5CB6270CD98F1() {
  _id_55704503DCF364A1 = scripts\cp\utility\entity::getaverageorigin(level.players);

  if(!isDefined(_id_55704503DCF364A1) || _id_55704503DCF364A1 == (0, 0, 0))
    return "barn";

  _id_C837AD627899C30C = scripts\engine\utility::getclosest(_id_55704503DCF364A1, getEntArray("mission_bs", "targetname"));

  if(!isDefined(_id_C837AD627899C30C))
    return "barn";

  switch (_id_C837AD627899C30C.script_noteworthy) {
    case "find_base":
    case "trap":
      return "barn";
    case "pre_escape_hotzone":
      return "town";
    case "pre_farm_hotzone":
      return "farms";
    case "pre_exfil":
    case "escape_hotzone":
    case "exfil":
      return "exfil";
    default:
      return "barn";
  }
}

vo_paratroopers() {
  if(!isDefined(level.paratrooper_vo_time))
    level.paratrooper_vo_time = gettime() - 1000;

  if(level.paratrooper_vo_time > gettime()) {
    return;
  }
  _id_3FE46CB10BD07785 = ["dx_cps_kama_callout_paratrooper_spawning_10", "dx_cps_kama_callout_paratrooper_spawning_20", "dx_cps_lass_callout_paratrooper_spawning_10", "dx_cps_lass_callout_paratrooper_spawning_20"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(_id_3FE46CB10BD07785), "allies");
  level.paratrooper_vo_time = gettime() + 30000;
}

spawn_enemy_chopper(stealth_group) {
  if(getdvarint("dvar_E1CC4FA6A0EDE111", 0) != 0) {
    return;
  }
  if(!isDefined(level._id_72069798E35CC6BC["town"])) {
    return;
  }
  if(level._id_72069798E35CC6BC["town"] < 10) {
    return;
  }
  if(scripts\engine\utility::flag_exist("boss_heli"))
    scripts\engine\utility::flag_set("boss_heli");

  if(!isDefined(level.helis))
    level.helis = [];

  if(!isDefined(level.heli_counter))
    level.heli_counter = 0;

  if(level.helis.size == 1) {
    return;
  }
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_MILBASE_DIALOGUE/HELI_INBOUND");
  spawn_point = scripts\engine\utility::getStruct("boss_heli_spawn", "targetname");
  spawn_point.classname_mp = "script_vehicle_apache_east";
  spawn_point.script_modelname = "veh8_mil_air_ahotel64_ks_east_mp";
  spawn_point.vehicletype = "veh_apache_cp";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 1; _id_AC0E594AC96AA3A8++) {
    level.helis[_id_AC0E594AC96AA3A8] = spawn_helicoper_enemy(spawn_point, level.heli_counter);
    level.helis[_id_AC0E594AC96AA3A8] thread watch_for_heli_death(level.heli_counter);
    wait 10;
  }
}

watch_for_heli_death(counter) {
  self waittill("vehicle_deathComplete");

  if(scripts\engine\utility::array_contains(level.helis, self))
    level.helis = scripts\engine\utility::array_remove(level.helis, self);

  level.heli_counter++;

  if(level.heli_counter >= 1) {
    level.heli_counter = 0;
    level notify("both_bosses_dead");
  }
}

spawn_helicoper_enemy(spawn_point, counter) {
  heli_path = undefined;

  if(counter != 0)
    heli_path = "heli_search_alt";

  heli = scripts\common\vehicle::vehicle_spawn(spawn_point);
  heli.death_fx_on_self = 1;
  heli scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "chopper_gunner_turret_cp", "tag_turret");
  heli thread setup_pilot(1);
  heli.isheli = 1;
  heli.health = 50000;
  heli.maxhealth = 50000;
  heli = update_health_value_for_special_cases(heli);
  heli.team = "axis";
  heli setvehicleteam(heli.team);
  heli thread damage_players_on_top();
  level thread _id_74502A9E0EF1F19C::add_to_special_lockon_target_list(heli);
  heli thread helicopter_death_lockon_clear();
  heli.headicon = createheadicon(heli);
  setheadiconimage(heli.headicon, "hud_icon_head_equipment_enemy");
  setheadiconmaxdistance(heli.headicon, 12000);
  setheadiconnaturaldistance(heli.headicon, 1500);
  setheadiconzoffset(heli.headicon, 10);
  setheadiconsnaptoedges(heli.headicon, 1);
  heli setmaxpitchroll(15, 15);
  heli.health_remaining = 2500;

  if(counter != 0)
    level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(heli, undefined, "heli_search_alt");
  else
    level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(heli);

  heli sethoverparams(25, 15, 10);
  return heli;
}

damage_players_on_top() {
  self endon("death");

  for(;;) {
    _id_E3D2AD13835AA960 = scripts\common\utility::playersnear(self.origin, 256);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E3D2AD13835AA960.size; _id_AC0E594AC96AA3A8++) {
      if(_id_E3D2AD13835AA960[_id_AC0E594AC96AA3A8].origin[2] > self.origin[2]) {
        if(_id_E3D2AD13835AA960[_id_AC0E594AC96AA3A8].origin[2] - self.origin[2] <= 32 && _id_E3D2AD13835AA960[_id_AC0E594AC96AA3A8] isonground())
          _id_E3D2AD13835AA960[_id_AC0E594AC96AA3A8] dodamage(_id_E3D2AD13835AA960[_id_AC0E594AC96AA3A8].health + 1000, self.origin, self, self, "MOD_CRUSH");
      }
    }

    wait 0.25;
  }
}

helicopter_death_lockon_clear() {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("death", "deleting_vehicle");
  level thread _id_74502A9E0EF1F19C::remove_from_special_lockon_target_list(self);
}

update_health_value_for_special_cases(heli) {
  health_scalar = 1;

  if(scripts\cp\cp_relics::are_relics_active())
    health_scalar = 5;

  heli.health = heli.health * health_scalar;
  heli.maxhealth = heli.maxhealth * health_scalar;
  return heli;
}

setup_pilot(_id_472C96D6A8ED7D53) {
  _id_F204DACE25365C76 = "tag_pilot";

  if(!self tagexists(_id_F204DACE25365C76))
    _id_F204DACE25365C76 = "tag_pilot1";

  self.pilot = spawn("script_model", self gettagorigin(_id_F204DACE25365C76));
  self.pilot setModel("aq_pilot_fullbody_1");
  self.pilot linkTo(self, _id_F204DACE25365C76, (0, 0, 0), (0, 0, 0));
  self.pilot scriptmodelplayanimdeltamotion("vh_mindia8_pilot_idle");

  if(istrue(_id_472C96D6A8ED7D53)) {
    thread watch_for_heli_getting_killed_directly();
    thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor();
  }
}

watch_for_heli_getting_killed_directly() {
  self endon("kill_this_thread_for_heli");
  self waittill("vehicle_deathComplete", _id_6BF9171C6C8FF4DB, angles);

  if(isDefined(self.headicon)) {
    deleteheadicon(self.headicon);
    self.headicon = undefined;
  }

  playFX(level._effect["vfx_blima_explosion"], _id_6BF9171C6C8FF4DB + (0, 0, -100));
  playsoundatpos(_id_6BF9171C6C8FF4DB, "cp_br_syrk_chopper_crash");
  self stoploopsound();
  wait 0.05;
  earthquake(0.45, 3, _id_6BF9171C6C8FF4DB + (0, 0, -100), 1024);
  wait 0.05;
  radiusdamage(_id_6BF9171C6C8FF4DB + (0, 0, -100), 1024, 500, 50);
  wait 0.05;

  if(isDefined(self.pilot))
    self.pilot delete();

  if(isDefined(self))
    self delete();
}

_id_424183E9E991FBA4() {
  scripts\engine\utility::flag_wait("ready_for_region_spawning");
}

_id_47B83E6A4BD5EAE0() {
  self endon("death");
  self endon("unloaded_from_techo");

  while(isalive(self)) {
    foreach(player in level.players) {
      _id_ABD9EE4725B96FC2 = distancesquared(self.origin, player.origin);

      if(self[[self.fnisinstealthcombat]]()) {
        if(_id_ABD9EE4725B96FC2 < 40000) {
          self getenemyinfo(player);

          if(isDefined(self.vehicle))
            self.vehicle thread scripts\cp\coop_stealth::_id_FFE8657189764909(self);
        }

        continue;
      }

      if(_id_ABD9EE4725B96FC2 < 22500 && player getstance() != "prone") {
        self aieventlistenerevent("proximity", player, player.origin);

        if(isDefined(self.vehicle))
          self.vehicle thread scripts\cp\coop_stealth::_id_FFE8657189764909(self);
      }
    }

    wait 0.1;
  }
}

#using_animtree("mp_vehicles_always_loaded");

_id_DE410CCCCCA132DD() {
  level.scr_animtree["exfil_heli"] = #animtree;
  level.scr_model["exfil_heli"] = "veh9_mil_air_heli_palfa_doors_open_vehphys_mp";
  level.scr_anim["exfil_heli"]["exfil_idle"] = % iw9_cp_badsituation_heliexfil_idle;
  level.scr_anim["exfil_heli"]["exfil_land"] = % iw9_cp_badsituation_heliexfil_land;
  level.scr_anim["exfil_heli"]["exfil_takeoff"] = % iw9_cp_badsituation_heliexfil_takeoff;
}

_id_693C533D6EE0937D() {
  heli = self;
  level._id_18DE9E24D428D860 _id_CED3784A002CA432([heli], "exfil_land", undefined, 7, 2, 1);
}

_id_CED3784A002CA432(guys, anime, tag, time, _id_5FCD68807ADA6113, _id_EFE93C754F5124E6) {
  pos = scripts\common\anim::get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];

  foreach(guy in guys) {
    guy hudoutlineenable("outline_depth_green");
    _id_D917428537562C1F = getstartorigin(org, angles, level.scr_anim[guy.animname][anime]);
    startang = getstartangles(org, angles, level.scr_anim[guy.animname][anime]);
    thread _id_23C207379E8F4FD7(_id_D917428537562C1F, startang);
    node = _id_0EB815E169BFBA76(_id_D917428537562C1F, undefined, undefined, 50, 69, startang);
    guy scripts\common\vehicle_paths::vehicle_paths_helicopter(node);
  }
}

_id_23C207379E8F4FD7(origin, angles) {
  for(;;)
    wait 1;
}

_id_3A30C8B011AE3527() {
  actor = self;
  actor hudoutlineenable("outline_depth_cyan");
  actor vehphys_forcekeyframedmotion();
  actor animScripted("blah", level._id_18DE9E24D428D860.origin, level._id_18DE9E24D428D860.angles, actor scripts\engine\utility::getanim("exfil_idle"));
  animduration = getanimlength(%iw9_cp_badsituation_heliexfil_idle);
  wait(animduration);
}

_id_444E69F224AD3406() {
  actor = self;
  actor hudoutlineenable("outline_depth_red");
  actor vehphys_forcekeyframedmotion();
  actor animScripted("blah", level._id_18DE9E24D428D860.origin, level._id_18DE9E24D428D860.angles, actor scripts\engine\utility::getanim("exfil_land"));
  animduration = getanimlength(%iw9_cp_badsituation_heliexfil_land);
  wait(animduration);
}

_id_0D0FB3E5EED9DAE9() {
  actor = self;
  actor hudoutlineenable("outline_depth_green");
  actor vehphys_forcekeyframedmotion();
  actor animScripted("blah", level._id_18DE9E24D428D860.origin, level._id_18DE9E24D428D860.angles, actor scripts\engine\utility::getanim("exfil_takeoff"));
  animduration = getanimlength(%iw9_cp_badsituation_heliexfil_land);
  wait(animduration - 4);
}

_id_0EB815E169BFBA76(pos, _id_C013CFD919A1A62D, _id_A95CF9509CE0D814, speed, num, _id_B092096C70BCC8E4) {
  struct = spawnStruct();
  struct.speed = speed;
  struct.origin = pos - (0, 0, 69);
  struct.angles = scripts\engine\utility::ter_op(isDefined(_id_B092096C70BCC8E4), _id_B092096C70BCC8E4, (0, 0, 0));
  struct.radius = 50;
  struct.target = _id_C013CFD919A1A62D;
  return struct;
}

_id_4DD2F281F958100F(objname) {
  return !istrue(level._id_BB07CFB91B5A51E8[objname]);
}

_id_CF8E838AFE1B1AAD() {
  level waittill("snakecam_used", _id_312B6D5871C69F3E);
  _id_312B6D5871C69F3E endon("completed_snakecam_exit");

  if(isDefined(_id_312B6D5871C69F3E._id_3DB3AC8C06039207)) {
    objname = _id_312B6D5871C69F3E._id_3DB3AC8C06039207.script_noteworthy;
    _id_D1C9446F2E09C277 = getaiarrayinradius(_id_312B6D5871C69F3E.origin, 666);
    _id_1F07ADB3B01A6E9A = 0;

    foreach(ai in _id_D1C9446F2E09C277) {
      if(scripts\engine\utility::within_fov(_id_312B6D5871C69F3E getEye(), _id_312B6D5871C69F3E getplayerangles(), ai.origin, cos(65)))
        _id_1F07ADB3B01A6E9A = 1;
    }

    if(objname == "stealth_a" || objname == "stealth_b") {
      if(istrue(_id_1F07ADB3B01A6E9A)) {
        level._id_E7B157FD6CF95460 = scripts\engine\utility::array_removeundefined(level._id_E7B157FD6CF95460);
        _id_5634333FDFCEF66F = level._id_E7B157FD6CF95460;
        _id_5634333FDFCEF66F = scripts\engine\utility::get_array_of_closest(_id_312B6D5871C69F3E.origin, level._id_E7B157FD6CF95460, undefined, 24, 500);
        _id_049F139A8104C29B = 0;

        foreach(obj in _id_5634333FDFCEF66F) {
          if(scripts\engine\utility::within_fov(_id_312B6D5871C69F3E getEye(), _id_312B6D5871C69F3E getplayerangles(), obj.origin, cos(65))) {
            _id_049F139A8104C29B = 1;
            break;
          }
        }

        if(istrue(_id_049F139A8104C29B)) {
          if(scripts\engine\utility::cointoss())
            _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_asyoucloseontheobjec");
          else if(scripts\engine\utility::cointoss())
            _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_followyourgeigercoun");
          else
            _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_thatmightbeourobject_01");

          level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_312B6D5871C69F3E, "stat_BCA5E472447F8C73");
          wait 0.5;
          _id_CEB1FF9428033CFD = _id_7E1A468DA43087E3::_id_1F35F09BD3F3DC51(_id_312B6D5871C69F3E);

          foreach(g in _id_CEB1FF9428033CFD)
          level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(g, "stat_252CF128B30AD74E");

          wait 1;
        } else if(scripts\engine\utility::cointoss())
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_anyenemiesyouseellne");
        else if(scripts\engine\utility::cointoss())
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_dontaskfortroubleify");
        else
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_engagementwithaqcoul");
      } else {
        level._id_E7B157FD6CF95460 = scripts\engine\utility::array_removeundefined(level._id_E7B157FD6CF95460);
        _id_5634333FDFCEF66F = level._id_E7B157FD6CF95460;
        _id_5634333FDFCEF66F = scripts\engine\utility::get_array_of_closest(_id_312B6D5871C69F3E.origin, level._id_E7B157FD6CF95460, undefined, 24, 500);
        _id_049F139A8104C29B = 0;

        foreach(obj in _id_5634333FDFCEF66F) {
          if(scripts\engine\utility::within_fov(_id_312B6D5871C69F3E getEye(), _id_312B6D5871C69F3E getplayerangles(), obj.origin, cos(65))) {
            _id_049F139A8104C29B = 1;
            break;
          }
        }

        if(istrue(_id_049F139A8104C29B)) {
          if(scripts\engine\utility::cointoss())
            _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_theressomethingintha_01");
          else if(scripts\engine\utility::cointoss())
            _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_thematerialswerelook");
          else
            _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_yourgeigercountersay");
        } else if(scripts\engine\utility::cointoss())
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_ifyoudontseeaclearpa");
        else
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_multipleinfilpointsp");
      }
    }

    if(objname == "stealth_c") {
      if(istrue(_id_1F07ADB3B01A6E9A)) {
        if(scripts\engine\utility::cointoss())
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_theyllneedtobedealtw");
        else if(scripts\engine\utility::cointoss())
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_theremightbeanotherw");
        else
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_lookshairyyourcall");
      } else {
        laser_traps = scripts\engine\utility::get_array_of_closest(_id_312B6D5871C69F3E.origin, level._id_CEEF08CFB883A461, undefined, 24, 500);
        _id_43B6843F64667AA9 = 0;

        foreach(_id_D1E8232B93D18970 in laser_traps) {
          if(scripts\engine\utility::within_fov(_id_312B6D5871C69F3E getEye(), _id_312B6D5871C69F3E getplayerangles(), _id_D1E8232B93D18970.origin, cos(65))) {
            _id_43B6843F64667AA9 = 1;
            break;
          }
        }

        if(istrue(_id_43B6843F64667AA9)) {
          if(scripts\engine\utility::cointoss()) {
            if(scripts\engine\utility::cointoss())
              _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_beadvisedintelreport");
            else
              _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_ifyouseelasertrapsth");
          } else if(scripts\engine\utility::cointoss())
            _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_ifyouencounterlasers");
          else
            _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_therecouldbelasershe");
        } else {
          level._id_E7B157FD6CF95460 = scripts\engine\utility::array_removeundefined(level._id_E7B157FD6CF95460);
          _id_5634333FDFCEF66F = level._id_E7B157FD6CF95460;
          _id_5634333FDFCEF66F = scripts\engine\utility::get_array_of_closest(_id_312B6D5871C69F3E.origin, level._id_E7B157FD6CF95460, undefined, 24, 500);
          _id_049F139A8104C29B = 0;

          foreach(obj in _id_5634333FDFCEF66F) {
            if(scripts\engine\utility::within_fov(_id_312B6D5871C69F3E getEye(), _id_312B6D5871C69F3E getplayerangles(), obj.origin, cos(65))) {
              _id_049F139A8104C29B = 1;
              break;
            }
          }

          if(istrue(_id_049F139A8104C29B)) {
            if(scripts\engine\utility::cointoss())
              _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_theressomethingintha");
            else
              _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_yourgeigercounterwil");

            if(scripts\engine\utility::cointoss())
              _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_youreclosinginonsome");
            else
              _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_thatmightbeourobject");
          } else if(scripts\engine\utility::cointoss())
            _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_lookslikeagoodwayin");
          else
            _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_clra_lasw_couldbeagoodinfilpoi");
        }
      }
    }
  }
}

_id_ADBB9817E7226E3F(origin) {
  forward = anglesToForward(self.angles);
  up = anglestoup(self.angles);
  _id_A011729D000A28D2 = origin - self.origin;
  _id_B6F39E71200FE477 = _func_D559A384B9C4E7D9(origin, self.origin, self.angles);
  _id_F945F5534FFEDF42 = _id_B6F39E71200FE477[0];
  _id_B383C5F0357008AE = _id_B6F39E71200FE477[1];
  _id_74DA97EBCA1BA2E7 = _id_B6F39E71200FE477[2];
  _id_9AA67BDF5007E363 = _id_F945F5534FFEDF42 > -225 && _id_F945F5534FFEDF42 < 225;
  _id_91678D915537FE2D = _id_B383C5F0357008AE > -60 && _id_B383C5F0357008AE < 60;
  _id_CBB36D65C8C53644 = _id_74DA97EBCA1BA2E7 > -235 && _id_74DA97EBCA1BA2E7 < -25;
  return _id_9AA67BDF5007E363 && _id_91678D915537FE2D && _id_CBB36D65C8C53644;
}