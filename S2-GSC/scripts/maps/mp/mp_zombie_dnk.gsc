/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_dnk.gsc
*********************************************/

main() {
  maps\mp\mp_zombie_dnk_precache::main();
  maps\createart\mp_zombie_dnk_art::main();
  maps\mp\mp_zombie_dnk_fx::main();
  _id_0483::main();
  maps\mp\mp_zombie_dnk_lighting::main();
  maps\mp\mp_zombie_dnk_aud::main();
  level.custom_camo_func_on = ::island_camo_vision_start;
  level.custom_camo_func_off = ::island_camo_vision_stop;
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::init_sg();
  register_dnk_sg_objectives();
  _id_0472::_id_8A2F("compass_map_mp_zombie_dnk");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.sg_pack_use_small_radius = 1;
  level._id_ACA3 = 1;
  level._id_323A = 1;
  level._id_6BB0 = ::ondnkstartgame;
  level._id_AC71 = ::initdnkweapons;
  level._id_AC72 = ::ondnkplayerspawnweapons;
  level.initnewzombietypes = ::initzombietypes;
  level.door_data_out_of_date = 0;
  level._id_0C11 = 0;
  level._id_ABD3 = -1500;
  level._id_783F = 0;
  level.reworkedconsumabledenabled = 1;
  level.loot_pap_camo_ref_override = "zom_amp_04";
  level.pap_camo_ref_override = "zom_camo_01";
  common_scripts\utility::flag_init("dnk_defense_drop_spawner_enabled");
  common_scripts\utility::flag_set("dnk_defense_drop_spawner_enabled");
  thread maps\mp\mp_zombie_dnk_code::init_dnk_code();
  thread maps\mp\mp_zombie_dnk_code::ee_init();
  thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::shotgun_classic_init();
  thread performance_stuff();
  _func_032("ui_zm_intermission_swaptime_1", 6);
  _func_032("ui_zm_intermission_swaptime_2", 2);
  setDvar("1520", "-10 20 -1 100");
  setDvar("2494", "0.12, 0, 0");
  setDvar("4341", "0");
  _id_055A::init();
  _id_055A::_id_530A("zone_dunkirk", 1);
  _id_055A::_id_530A("zone_the_void", 0);
  _id_055A::_id_0993("zone_dunkirk", "zone_the_void", "ship_to_void");
  _id_055A::_id_088A();
  level thread beast_boss_init();
  level thread intro_special_zombies_init();
  maps\mp\zquests\zmb_secret_challenges_util::init_challenges_utility();
  level thread maps\mp\zquests\dlc3_secrets_mp_zombie_dnk::init_dlc3_secrets_mp_zombie_dnk();
}

island_camo_vision_start() {
  self _meth_849A("clut_mp_zombie_island_camo", 0.25);
}

island_camo_vision_stop() {
  self _meth_849A("clut_identity", 0.25);
}

register_dnk_sg_objectives() {
  var_0 = spawnStruct();
  var_0.ext_type = ["zombie_generic"];
  var_1 = [];
  var_1["type_keypoint_interact_repair_common"] = spawnStruct();
  var_1["type_keypoint_interact_repair_common"].extra_func = maps\mp\mp_zombie_dnk_code::sinking_init;
  var_1["type_escape_common"] = spawnStruct();
  var_1["type_escape_common"].extra_func = maps\mp\mp_zombie_dnk_code::escape_extra_run;
  var_1["type_defense_common"] = spawnStruct();
  var_1["type_defense_common"].extra_func = maps\mp\mp_zombie_dnk_code::defense_extra_run;
  var_1["type_extermination_common"] = spawnStruct();
  var_1["type_extermination_common"]._id_2A35 = spawnStruct();
  var_1["type_extermination_common"]._id_2A35.ext_type = [["zombie_exploder"], ["zombie_sizzler"]];
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::include_shotgun_v1_common_objectives(var_1);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("dnk_boss", "type_boss", [10], undefined, ::beast_boss_run);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("dnk_ext_visions", "visions", [6, 9], 150, maps\mp\mp_zombie_dnk_code::visions_run, undefined, undefined, undefined, 0);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("dnk_kpi_bomb_defusal", "keypoint_interact_bomb", [6, 9], undefined, undefined, undefined, undefined, undefined, 1, maps\mp\mp_zombie_dnk_code::bomb_disposal_init);
}

initzombietypes() {
  thread maps\mp\zombies\zombie_sizzler::init();
}

initdnkweapons() {
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::initialize_common_sg_weapons();
  level thread maps\mp\zombies\weapons\_zombie_aoe_grenade::init();
}

ondnkstartgame() {
  thread maps\mp\mp_zombie_dnk_code::level_intro_vo();
  thread maps\mp\mp_zombie_dnk_code::water_trap_init();
  level.roundendfuncgeneric = ::ondnkroundend;
}

ondnkroundend() {
  if(level._id_A980 == 1)
    level thread maps\mp\mp_zombie_dnk_code::wave_story_wave_1();

  if(level._id_A980 == 4)
    level thread maps\mp\mp_zombie_dnk_code::wave_story_wave_4();

  if(level._id_A980 == 9)
    level thread maps\mp\mp_zombie_dnk_code::wave_story_pre_boss();

  if(level._id_A980 == 10)
    level thread maps\mp\mp_zombie_dnk_code::wave_story_post_boss();

  level.shiptiltingtimermin = level.shiptiltingtimermin - 2;
  level.shiptiltingtimermax = level.shiptiltingtimermax - 2;
}

ondnkplayerspawnweapons() {}

beast_boss_init() {
  var_0 = 180;
  var_1 = 1;
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("beast_boss", ::beast_boss_run, var_0, 0, 1);
}

beast_boss_run(var_0) {
  level endon("sg_obj_timeout");
  maps\mp\zombies\zombie_sizzler::init();
  maps\mp\zombies\zombie_beast::init();
  level.trucks_are_port_locked = 1;
  level._id_1CC0 = undefined;
  var_1 = common_scripts\utility::_id_46B5("sg_boss_beast_spawnpoint", "targetname");
  level.boss = _id_054D::_id_90BA("zombie_bob", var_1, "bob", 0, 1, 0);
  level.boss _id_0547::_id_84CB();
  level.boss maps\mp\zombies\sg_events_v1\_boss_util::set_zombie_boss_has_weapon_loot();
  level.boss.sgboss = 1;
  level.boss.is_flamethrower_resistent = 1;
  level.boss thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::show_sh_boss_health(-20);
  level.boss.max_sizzler_count = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("zmb_beast_max_sizzler_count");
  var_2 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_boss_health");
  var_2 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_modified_boss_health(var_2);

  if(int(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("zmb_fireman_boss_is_uber")))
    level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::spawn_extra_redskull_assassins("zombie_assassin_freefire");

  level.boss maps\mp\agents\_agent_common::_id_83FD(int(var_2));
  var_3 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::basic_boss_waitfor_defeated();

  if(!common_scripts\utility::_id_562E(var_3))
    return 0;
  else {
    foreach(var_5 in level.players) {
      var_6 = _id_0547::_id_4745(var_5, "totalBossDefeats");
      var_6++;
      var_5 setplayerdata(common_scripts\utility::_id_46A8(), "totalBossDefeats", var_6);
    }

    common_scripts\utility::flag_set("zmb_players_gamemode_boss_defeated");
    return 1;
  }
}

intro_special_zombies_init() {
  _id_0547::_id_7BA9(::special_decorator_zombie_killed);
  var_0 = 0;

  for(;;) {
    level waittill("zombie_spawned", var_1);

    if(var_1._id_0A4B == "zombie_generic") {
      var_2 = _func_0A4(0, 100);

      if(var_2 < 1 && !common_scripts\utility::_id_562E(self.hasprop) && var_0 < level.max_prop_zombie_appearances) {
        var_0++;
        var_1 intro_special_zombies_attach();
        wait 600;
      }
    }
  }
}

intro_special_zombies_attach() {
  self.hasprop = 1;
  self.prop_decorator = spawn("script_model", self.origin);

  if(common_scripts\utility::_id_24A6())
    self.prop_decorator setModel("bsh_life_preserve_01");
  else
    self.prop_decorator setModel("bsh_life_preserve_01_snow");

  self.prop_decorator _meth_8055(self, "J_SpineLower", (0, 0, 0), (0, 90, -90));
}

special_decorator_zombie_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self.prop_decorator))
    self.prop_decorator common_scripts\utility::_id_2CBE(4, ::delete);
}

performance_stuff() {
  setDvar("634", 0);
}