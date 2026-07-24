/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_vips\sa_vips.gsc
***********************************************/

main() {
  scripts\sp\utility::_id_116CB("sa_vips");
  scripts\sp\maps\sa_vips\gen\sa_vips_art::main();
  scripts\sp\maps\sa_vips\sa_vips_fx::main();
  scripts\sp\maps\sa_vips\sa_vips_lighting::main();
  scripts\sp\maps\sa_vips\sa_vips_precache::main();
  scripts\sp\maps\sa_vips\sa_vips_audio::main();
  _id_0F00::_id_25D8(24);
  _id_0EFE::_id_FD0B();
  _id_0F05::_id_FCF3();
  _id_0F04::_id_FCEE();
  _id_0EFC::_id_967E();
  precache();
  _id_0F0B::_id_D7F7();
  _id_0F0E::_id_D7F8();
  _id_FA53();
  scripts\sp\utility::_id_1263F("sa_vips_space_tr");
  scripts\sp\utility::_id_1263F("sa_vips_spacemisc_tr");
  scripts\sp\utility::_id_1263F("sa_vips_hull_tr");
  scripts\sp\utility::_id_1263F("sa_vips_starboardlower_tr");
  scripts\sp\utility::_id_1263F("sa_vips_messhall_tr");
  scripts\sp\utility::_id_1263F("sa_vips_armory_tr");
  scripts\sp\utility::_id_1263F("sa_vips_hubbow_tr");
  scripts\sp\utility::_id_1263F("sa_vips_bowupper_tr");
  scripts\sp\utility::_id_1263F("sa_vips_bowlower_tr");
  scripts\sp\utility::_id_1263F("sa_vips_cargobay_tr");
  scripts\sp\utility::_id_1263F("sa_vips_interior_tr");
  scripts\sp\utility::_id_1263F("sa_vips_breachroom_tr");
  scripts\sp\utility::_id_1263F("sa_vips_exfil_tr");
  scripts\sp\utility::_id_1263F("sa_vips_prime_tr");
  scripts\sp\utility::_id_1263F("sa_vips_playerjackal_tr");
  scripts\sp\utility::_id_1263F("sa_vips_ignore_everything_tr");

  if(getDvar("createfx") != "") {
    level thread _id_0F16::_id_88CA();
  }

  scripts\sp\load::main();
  level._id_74D5 = [];
  level._id_74D5["exfil_door_interior_custom_func"] = ::_id_6907;
  level._id_74D5["exfil_door_exterior_custom_func"] = ::_id_6906;
  level._id_74D5["breach_airlock_door_custom_func"] = ::_id_2F54;
  level._id_74D5["body_bag_melee_kill"] = ::_id_2C0C;
  level._id_74D5["sa_vips_ss1_wegottamove"] = ::_id_E9F1;
  level._id_74D5["sa_vips_ss2_headingtosector3"] = ::_id_E9F2;
  level._id_74D5["generic_runner_vo_01"] = ::_id_7768;
  level._id_74D5["generic_runner_vo_02"] = ::_id_7769;
  level._id_74D5["generic_runner_vo_03"] = ::_id_776A;
  level._id_74D5["seek_player_on_stealth_spotted"] = ::_id_F105;
  scripts\engine\utility::trigger_off("sa_hangar_start_trigger_01", "targetname");
  level._id_E9E9 = 1;
  level._id_98C4 = ::_id_9716;
  _id_0F0C::_id_E9BF();
  _id_0EFE::main();
  _id_0F05::_id_95B6();
  _id_0F04::_id_9587();
  thread scripts\sp\maps\sa_vips\sa_vips_lighting::_id_E9EF();
  _id_0F21::main();
  setsaveddvar("r_tessellationOverride", 0);
  setsaveddvar("r_umbraShadowCasters", 1);
  setsaveddvar("r_umbraMinObjectContribution", 4);
  setsaveddvar("player_zeroGravAutoLevel", (0, 0, 1));
  setsaveddvar("player_isInZeroGLevel", 1);
  level._id_10ED1 = scripts\engine\utility::getStruct("stealth_kill_anim_org", "targetname");
  level._id_133E0 = scripts\engine\utility::getStruct("vip_execution_struct", "targetname");
  scripts\sp\utility::_id_22CA("dead_bodyonly", ::_id_4DE4);
  scripts\sp\utility::_id_22C9("unsa_infil_drop_ship_allies", ::_id_1D22);
  var_0 = getEntArray("exploder_state_trigger", "targetname");

  if(isDefined(var_0)) {
    scripts\engine\utility::array_thread(var_0, ::_id_F399);
  }

  level._id_13D3E = getEnt("window_scorch_decals", "targetname");

  if(isDefined(level._id_13D3E)) {
    level._id_13D3E hide();
  }

  _id_0F00::_id_DED5();
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_570D();
  level thread _id_0A2F::_id_3D61();
  level._id_133E1 = 120;
  scripts\engine\utility::exploder(1);
  var_1 = getEnt("sa_hubbow_start_from_starboardlower", "targetname");

  if(isDefined(var_1)) {
    scripts\engine\utility::trigger_off("sa_hubbow_start_from_starboardlower", "targetname");
  }

  level thread _id_119BF();
}

precache() {
  scripts\engine\utility::flag_init("start_vip_captain_execute_vip_watcher");
  scripts\engine\utility::flag_init("stealth_spotted-Group:sa_hangar_vol_sg");
  scripts\engine\utility::flag_init("stealth_spotted-Group:sa_starboard_lower_vol_sg");
  scripts\engine\utility::flag_init("captain_spawned");
  scripts\engine\utility::flag_init("vips_spawned");
  scripts\engine\utility::flag_init("vent_hatch_triggered");
  scripts\engine\utility::flag_init("captain_key_pickedUp");
  scripts\engine\utility::flag_init("clean_up_turret_clips");
  scripts\engine\utility::flag_init("zero_g_begin");
  scripts\engine\utility::flag_init("zerog_brooks_spawned");
  scripts\engine\utility::flag_init("zerog_kashima_spawned");
  scripts\engine\utility::flag_init("dropship_unloaded");
  scripts\engine\utility::flag_init("zerog_enemies_alerted");
  scripts\engine\utility::flag_init("zero_g_end");
  scripts\engine\utility::flag_init("zerog_enemies_player_fire");
  scripts\engine\utility::flag_init("zerog_first_enemies_dead");
  scripts\engine\utility::flag_init("zerog_second_enemies_dead");
  scripts\engine\utility::flag_init("zerog_third_enemies_dead");
  scripts\engine\utility::flag_init("zerog_combat_enemies_dead");
  scripts\engine\utility::flag_init("zerog_debris_drop");
  scripts\engine\utility::flag_init("open_bay");
  scripts\engine\utility::flag_init("infiltrate_begin");
  scripts\engine\utility::flag_init("breach_started");
  scripts\engine\utility::flag_init("player_entered_ship");
  scripts\engine\utility::flag_init("obj_marker_on_breach_room_computer");
  scripts\engine\utility::flag_init("obj_marker_on_breach_room_computer_disable");
  scripts\engine\utility::flag_init("access_denied");
  scripts\engine\utility::flag_init("breach_room_vo_done");
  scripts\engine\utility::flag_init("infiltrate_end");
  scripts\engine\utility::flag_init("hack_security_begin");
  scripts\engine\utility::flag_init("hack_security_end");
  scripts\engine\utility::flag_init("interior_begin");
  scripts\engine\utility::flag_init("body_bag_melee_kill_enemy_dead_or_alerted");
  scripts\engine\utility::flag_init("interior_end");
  scripts\engine\utility::flag_init("cargo_bay_begin");
  scripts\engine\utility::flag_init("cargo_bay_end");
  scripts\engine\utility::flag_init("recover_tech_begin");
  scripts\engine\utility::flag_init("cargobay_regrouped");
  scripts\engine\utility::flag_init("lower_cargobay_door_close");
  scripts\engine\utility::flag_init("unload_cargobay_transient");
  scripts\engine\utility::flag_init("c8_took_damage");
  scripts\engine\utility::flag_init("armory_combat_final_wave");
  scripts\engine\utility::flag_init("armory_combat_end");
  scripts\engine\utility::flag_init("salter_start_ready_to_recover_tech");
  scripts\engine\utility::flag_init("salter_ready_to_recover_tech");
  scripts\engine\utility::flag_init("recover_tech_end");
  scripts\engine\utility::flag_init("chargeshot_picked_up");
  scripts\engine\utility::flag_init("tech_recovered");
  scripts\engine\utility::flag_init("initial_recover_tech_vo_done");
  scripts\engine\utility::flag_init("armory_loot_door_fully_opened");
  scripts\engine\utility::flag_init("exfil_begin");
  scripts\engine\utility::flag_init("retreat_hubstern_enemies_04");
  scripts\engine\utility::flag_init("armory_loot_door_hacked");
  scripts\engine\utility::flag_init("armory_loot_door_opened");
  scripts\engine\utility::flag_init("infiltrate_door_opened");
  scripts\engine\utility::flag_init("armory_door_close");
  scripts\engine\utility::flag_init("exfil_end");
  scripts\engine\utility::flag_init("enable_infiltrate");
  scripts\engine\utility::flag_init("enable_infiltrate_disabled");
  scripts\engine\utility::flag_init("execute_vips");
  scripts\engine\utility::flag_init("vips_dead");
  scripts\engine\utility::flag_init("enable_armory_loot_room_door_01");
  scripts\engine\utility::flag_init("tube_cleanup");
  _id_0F0E::_id_F902();

  if(!scripts\engine\utility::flag_exist("flag_armory_defend")) {
    scripts\engine\utility::flag_init("flag_armory_defend");
  }

  precachemodel("beacon_intel_tablet");
  precachemodel("generic_prop_x3");
  precachemodel("veh_mil_air_un_jackal_02");
  precachemodel("sdf_window_exterior_01_shield_destroyed");
  precacheitem("iw7_chargeshot");
  precacheitem("iw7_chargeshot+chargeshotscope");
}

_id_FA53() {
  scripts\sp\utility::_id_F343("zero_g");
  scripts\sp\utility::_id_1749("zero_g", ::_id_13E7D, "Zero G", ::_id_13E6C, ["sa_vips_space_tr", "sa_vips_hull_tr", "sa_vips_spacemisc_tr"], ::_id_13E70);
  scripts\sp\utility::_id_1749("infiltrate", ::_id_94A0, "Infiltrate", ::_id_9498, ["sa_vips_space_tr", "sa_vips_hull_tr", "sa_vips_interior_tr", "sa_vips_breachroom_tr", "sa_vips_prime_tr", "sa_vips_spacemisc_tr"], ::_id_949C);
  scripts\sp\utility::_id_1749("hack_security", ::_id_87DE, "Hack Security", ::_id_87D9, ["sa_vips_starboardlower_tr", "sa_vips_messhall_tr", "sa_vips_interior_tr", "sa_vips_hull_tr", "sa_vips_prime_tr"], ::_id_87DC);
  scripts\sp\utility::_id_1749("interior", ::_id_9A72, "Interior", ::_id_9A62, ["sa_vips_messhall_tr", "sa_vips_hubbow_tr", "sa_vips_interior_tr", "sa_vips_starboardlower_tr", "sa_vips_hull_tr", "sa_vips_prime_tr"], ::_id_9A6A);
  scripts\sp\utility::_id_1749("cargo_bay", ::_id_3A68, "Cargo Bay", ::_id_3A61, ["sa_vips_bowupper_tr", "sa_vips_interior_tr", "sa_vips_hubbow_tr", "sa_vips_hull_tr", "sa_vips_prime_tr", "sa_vips_cargobay_tr"], ::_id_3A65);
  scripts\sp\utility::_id_1749("recover_tech", ::_id_DE02, "Recover Tech", ::_id_DDFB, ["sa_vips_cargobay_tr", "sa_vips_interior_tr", "sa_vips_hull_tr", "sa_vips_prime_tr"], ::_id_DDFF);
  scripts\sp\utility::_id_1749("exfil", ::_id_692A, "Exfil", ::_id_68ED, ["sa_vips_armory_tr", "sa_vips_interior_tr", "sa_vips_hubbow_tr", "sa_vips_hull_tr", "sa_vips_prime_tr"], ::_id_6900);
  scripts\sp\utility::_id_1749("loot_room", ::_id_B090, "Loot Room", ::_id_B08A, ["sa_vips_armory_tr", "sa_vips_interior_tr", "sa_vips_hull_tr", "sa_vips_prime_tr"]);
}

_id_13E70() {
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_13E94();

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_8E06();
  }
}

_id_13E7D() {}

_id_13E6C() {
  scripts\engine\utility::flag_set("zero_g_begin");
  setglobalsoundcontext("atmosphere", "space", 0.1);
  level.player freezecontrols(1);
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(0);
  level.player disableoffhandweapons();
  level.player _meth_8185();
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level thread scripts\sp\hud_util::_id_6AA3(0.0);
  wait 0.05;
  scripts\engine\utility::trigger_off("player_in_gravity_trigger", "targetname");
  scripts\sp\utility::_id_12641("sa_vips_playerjackal_tr");
  wait 0.05;
  level thread _id_4281();
  _id_B2C8();
  thread _id_0F16::_id_8EA3();
  _id_0F16::_id_3E3F("zero_g_start_point");
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_13E95();
  thread _id_104CE();
  level._id_13E7D = 1;
  _id_0E4B::_id_8E06(0);
  _id_133E3();
  level thread _id_91B6();
  level thread _id_13E7B();
  level thread _id_0F16::_id_FA47();
  level thread _id_0F16::_id_FA48();
  level._id_13EAA = [];
  level thread _id_1295D();
  scripts\sp\maps\sa_vips\sa_vips_fx::_id_13360(1);
  _id_0BDC::_id_A151();
  scripts\sp\utility::_id_241F(0);
  _id_0F0E::_id_A122("zero_g_start_point", "player_jackal", "hover");
  level._id_D16F = level._id_D127;
  level._id_D127.ignoreall = 1;
  level._id_D127.ignoreme = 1;
  level._id_D127 scripts\sp\vehicle::_id_8441();
  level._id_D127 thread _id_0BDC::_id_A07D();
  level.player.ignoreme = 1;
  level._id_C0B7 = 1;
  var_0 = scripts\sp\utility::_id_22CB("unsa_infil_drop_ship_allies", 1);
  level thread _id_13E8B();
  level thread _id_13EA6();
  level thread _id_13EDE();
  level thread _id_13E7F();
  level thread _id_13E7A();
  level thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_13E93();
  wait 0.5;
  level thread _id_A127("clean_up_turret_clips");
  level._id_2FA5["breach_window_left"] thread _id_0F17::_id_13D5C();
  level thread _id_0F16::_id_D05C(undefined, 1, "player_jackal_fly_out_spline");
  wait 1.0;
  level thread scripts\sp\utility::_id_12643(["sa_vips_prime_tr", "sa_vips_interior_tr", "sa_vips_breachroom_tr"]);
  wait 1.5;
  level thread scripts\sp\hud_util::_id_6A99(3.0);
  level notify("start_ally_dismount");

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F530(0);
    scripts\sp\specialist_MAYBE::_id_8E06();
    scripts\sp\specialist_MAYBE::_id_F53C(0);
  }

  level waittill("dismount_anim_ended");
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(1);
  level.player enableoffhandweapons();
  level.player showhud();
  thread scripts\sp\utility::_id_266F(0);
  wait 1.0;
  level thread _id_0F36::_id_12AB4("zero_g_end");
  level thread _id_5404();
  scripts\engine\utility::flag_wait("zerog_enemies_spawn");
  level thread scripts\sp\utility::_id_1264E("sa_vips_playerjackal_tr");

  while(!istransientloaded("sa_vips_prime_tr")) {
    wait 0.05;
    waitfortransient("sa_vips_prime_tr");
  }

  wait 1.5;
  scripts\engine\utility::flag_wait("zerog_combat_enemies_dead");
  scripts\engine\utility::flag_set("zero_g_end");
  var_1 = getEnt("zerog_ai_clip", "targetname");
  var_1 notsolid();
  var_1 connectpaths();
  var_1 delete();
  scripts\sp\utility::_id_15F5("ally_moveup_zerog_combatc");

  if(!scripts\engine\utility::flag("game_saving")) {
    level thread scripts\sp\utility::_id_2679();
  }
}

_id_1295D() {
  level.player waittill("jackal_note_hud_on");
  level thread _id_0BDC::_id_A226();
}

_id_1D22() {
  thread scripts\sp\utility::_id_B14F();
  self.ignoreall = 1;
  self.ignoreme = 1;
  thread scripts\sp\utility::_id_F2DA(0);
  self._id_B3E9 = 1;
  scripts\sp\utility::_id_F417(1);
  scripts\sp\utility::_id_F2D8(25);

  switch (self.script_parameters) {
    case "brooks":
      level._id_30F6 = self;
      self._id_F089 = "tag_player";
      self._id_5680 = "dismount_right_pilot";
      thread _id_0F16::isfirstarmageddonmeteorhit("iw7_m4+silencer", "primary", "iw7_m8");

      if(scripts\engine\utility::flag("zero_g_begin")) {
        _id_0F16::isfirstarmageddonmeteorhit("iw7_m8", "primary");
      }

      scripts\engine\utility::flag_set("zerog_brooks_spawned");
      break;
    case "kashima":
      level._id_A54E = self;
      self._id_F089 = "tag_copilot";
      self._id_5680 = "dismount_right_copilot";
      thread _id_0F16::isfirstarmageddonmeteorhit("iw7_erad+silencersmge", "primary", "iw7_m8");

      if(scripts\engine\utility::flag("zero_g_begin")) {
        _id_0F16::isfirstarmageddonmeteorhit("iw7_m8", "primary");
      }

      scripts\engine\utility::flag_set("zerog_kashima_spawned");
      break;
    default:
      break;
  }

  scripts\engine\utility::flag_wait_any("zerog_enemies_alerted", "zerog_enemies_player_fire");
  self.ignoreme = 0;
  self.ignoreall = 0;
  thread scripts\sp\utility::_id_F2DA(1);
  wait 3;
  scripts\sp\utility::_id_F2D8(2);
  scripts\engine\utility::flag_wait("zerog_combat_enemies_dead");
  self.ignoreme = 1;
  self.ignoreall = 1;
  thread scripts\sp\utility::_id_F2DA(0);
  level waittill("breach_start");
  scripts\sp\utility::_id_1101B();
  self delete();
}

#using_animtree("jackal");

_id_13E8B() {
  scripts\engine\utility::flag_wait_all("zerog_brooks_spawned", "zerog_kashima_spawned");
  level._id_13E89 = _id_13E8A();
  thread _id_13EB5();
  level._id_13E89 scripts\sp\anim::_id_1ECA(level._id_30F6, level._id_30F6._id_5680, level._id_30F6._id_F089);
  level._id_13E89 scripts\sp\anim::_id_1ECA(level._id_A54E, level._id_A54E._id_5680, level._id_A54E._id_F089);
  level waittill("start_ally_dismount");
  level._id_13E89 _id_0BDC::_id_A2DE(1);
  level._id_13E89 setanimknob(%jackal_vehicle_space_assault_to_mount, 1.0, 2.0);
  wait 3.0;
  level._id_13E89 thread scripts\sp\anim::_id_1EC7(level._id_30F6, level._id_30F6._id_5680, level._id_30F6._id_F089);
  level._id_13E89 scripts\sp\anim::_id_1EC7(level._id_A54E, level._id_A54E._id_5680, level._id_A54E._id_F089);
  var_0 = getcsplineid("player_jackal_fly_out_spline");
  level._id_13E89 _id_0C24::_id_10A49();
  level._id_13E89 _id_0BDC::_id_A301(0.5, 0.1);
  level._id_13E89 _meth_8479(var_0);
  level._id_13E89 _meth_847B(3);
}

_id_13EB5() {
  wait 25;
  level._id_13E89 delete();
  level._id_D16F delete();
}

_id_13EDE() {
  scripts\engine\utility::flag_wait("zerog_enemies_spawn");

  if(!scripts\engine\utility::flag("game_saving")) {
    level thread scripts\sp\utility::_id_2679();
  }

  scripts\engine\utility::flag_set("open_bay");
  wait 2;
  scripts\sp\utility::_id_22CA("zerog_hang_enemies", ::_id_13EAA);
  var_0 = scripts\sp\utility::_id_22CD("zerog_hang_enemies", 1);
}

_id_2F54() {
  self._id_5985 linkTo(self, "tag_ui_back");
  scripts\engine\utility::flag_wait("zerog_enemies_spawn");
  wait 5.0;
  scripts\sp\utility::_id_22CA("zerog_airlock_enemies", ::_id_13EAA);
  scripts\sp\utility::_id_22CA("zerog_airlock_enemies", ::_id_13E88);
  scripts\sp\anim::_id_1F35(self, "airlock_open_player");
  self._id_5985 connectpaths();
  var_0 = scripts\sp\utility::_id_22CD("zerog_airlock_enemies", 1);
  level._id_13EAA = scripts\sp\utility::_id_22B9(level._id_13EAA);
  level thread _id_13755(level._id_13EAA, int(level._id_13EAA.size / 3), "zerog_first_enemies_dead");
  thread _id_0F16::_id_68BF("zerog_first_enemies_dead", "zerog_combat_volume_02");
  thread _id_0F16::_id_1C17("zerog_first_enemies_dead", "ally_moveup_zerog_combata");
  level thread _id_13755(level._id_13EAA, int(level._id_13EAA.size / 2), "zerog_second_enemies_dead");
  thread _id_0F16::_id_68BF("zerog_second_enemies_dead", "zerog_combat_volume_03");
  thread _id_0F16::_id_1C17("zerog_second_enemies_dead", "ally_moveup_zerog_combatb");
}

_id_13E88() {
  self endon("death");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  self linkTo(var_0, "tag_origin");
  var_0 moveTo(self.origin + (0, -200, randomintrange(-50, 50)), 2.5);
  wait 2.55;
  self unlink();
}

_id_13EA6() {
  thread _id_13E9E();
  scripts\engine\utility::flag_wait("zerog_first_enemies_dead");
  scripts\sp\utility::_id_22C9("zerog_dropshipone_spawners", ::_id_13EAA);
  var_0 = scripts\sp\vehicle::_id_1080D("dropship_zerog_backup");
  var_0.ignoreme = 1;
  var_0.ignoreall = 1;
  var_0 scripts\sp\vehicle::_id_8441();
  var_0 detach("veh_mil_air_ca_dropship_personnel", "tag_connect");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("veh_mil_air_ca_dropship_personnel");
  var_1 linkTo(var_0, "tag_connect", (0, 0, 0), (0, 0, 0));
  var_0 hidepart("j_backlandinggear_ri");
  var_0 hidepart("j_backlandinggear_le");
  var_0 waittill("unloading");
  var_0 attach("veh_mil_air_ca_dropship_personnel", "tag_connect");
  var_1 delete();
  var_0 scripts\sp\utility::_id_65E3("unloaded");

  if(!scripts\engine\utility::flag("game_saving")) {
    level thread scripts\sp\utility::_id_2679();
  }

  scripts\engine\utility::flag_set("dropship_unloaded");
  level._id_13EAA = scripts\sp\utility::_id_22B9(level._id_13EAA);
  level thread _id_13755(level._id_13EAA, int(level._id_13EAA.size / 3), "zerog_third_enemies_dead");
  thread _id_0F16::_id_68BF("zerog_third_enemies_dead", "zerog_combat_volume_04");
  thread _id_0F16::_id_1C17("zerog_third_enemies_dead", "ally_moveup_zerog_combatb");
  level thread _id_13755(level._id_13EAA, level._id_13EAA.size, "zerog_combat_enemies_dead");
}

_id_13E9E() {
  scripts\engine\utility::flag_wait("dropship_enemy_debris");
  scripts\engine\utility::flag_set("zerog_debris_drop");
}

_id_13EA7() {}

_id_13EAA() {
  self endon("death");
  level._id_13EAA = scripts\engine\utility::add_to_array(level._id_13EAA, self);
  self.ignoreall = 1;
  self.ignoreme = 1;
  thread scripts\sp\utility::_id_F2DA(0);
  thread _id_13678();
  scripts\engine\utility::flag_wait("zerog_enemies_alerted");
  self.ignoreall = 0;
  self.ignoreme = 0;
}

_id_13678() {
  level.player endon("death");
  thread _id_56F5();
  self addaieventlistener("death");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "ai_events");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "damage");
  level scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "zerog_enemies_alerted");
  scripts\sp\utility::_id_57D6();

  if(!scripts\engine\utility::flag("zerog_enemies_player_fire")) {
    scripts\engine\utility::flag_set("zerog_enemies_player_fire");
    level.player scripts\sp\utility::_id_1034D("sa_vips_plr_engaging");
  }

  wait 2;
  scripts\engine\utility::flag_set("zerog_enemies_alerted");
}

_id_56F5() {
  self endon("death");
  level endon("zerog_enemies_alerted");

  if(scripts\engine\utility::flag("zerog_enemies_alerted")) {
    return;
  }
  var_0 = squared(650);

  while(distancesquared(self.origin, level.player.origin) > var_0) {
    wait 0.1;
  }

  scripts\engine\utility::flag_set("zerog_enemies_alerted");
}

_id_13E7F() {
  _id_13EC2();
  _id_13EA0();
  _id_13ED2();
  _id_13E9C();
  _id_13EA8();
}

_id_13EC2() {
  level.player endon("death");
  setmusicstate("mx_186_savips_levelstart");
  level endon("dropship_enemy_debris");
  wait 0.25;
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_alphateaminposi");
  wait 0.5;
  scripts\sp\utility::_id_10350("sa_vips_eth_beadvisedgalaxi");
  wait 0.15;
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_keepembusysalt");
  wait 0.5;
  scripts\sp\utility::_id_10350("sa_vips_slt_copyapproaching");
  level notify("zerog_flyby");
  scripts\sp\utility::_id_10350("sa_vips_slt_lightemup");
  playrumbleonposition("grenade_rumble", level.player.origin);
  earthquake(0.4, 1, level.player.origin, 400);
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_alphasweaponret");
  wait 0.15;
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_fanupusethebrieffo");
  level._id_A54E scripts\sp\utility::_id_10347("sa_vips_ksh_peelingright");
  level._id_30F6 scripts\sp\utility::_id_10347("sa_vips_brk_checkgoinleft");
}

_id_13EA0() {
  level.player endon("death");
  level endon("zerog_enemies_spawn");
  scripts\engine\utility::flag_wait("dropship_enemy_debris");
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_staysharptheyknoww");
  wait 1;
  scripts\sp\utility::_id_10350("sa_vips_eth_sirenemytriggersco");
  wait 3;
  level._id_30F6 scripts\sp\utility::_id_10347("sa_vips_brk_wastheocana");
  wait 0.5;
  level._id_A54E scripts\sp\utility::_id_10347("sa_vips_ksh_whatsleftofit");
  wait 0.5;
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_allwecandoishitem");
  wait 5;
  scripts\sp\utility::_id_10350("sa_vips_eth_sirtargetsconverg");
}

_id_13ED2() {
  level.player endon("death");
  level endon("zerog_enemies_alerted");
  scripts\engine\utility::flag_wait("zerog_enemies_spawn");
  wait 1.0;
  level._id_A54E scripts\sp\utility::_id_10347("sa_vips_ksh_searchingforus");
  level.player scripts\sp\utility::_id_1034D("sa_vips_letemgetcloser");
  wait 4;
  level._id_A54E scripts\sp\utility::_id_10347("sa_vips_ksh_targetinsight");
  wait 3;
  level._id_30F6 scripts\sp\utility::_id_10347("sa_vips_brk_takingtheshot");
  scripts\engine\utility::flag_set("zerog_enemies_alerted");
}

_id_13E9C() {
  level endon("zerog_third_enemies_dead");
  scripts\engine\utility::flag_wait("zerog_enemies_alerted");
  level._id_30F6 scripts\sp\utility::_id_10347("sa_vips_brk_eyesondeadahead");
  scripts\engine\utility::flag_wait("zerog_second_enemies_dead");
  level._id_A54E scripts\sp\utility::_id_10347("sa_vips_ksh_boostersintheopen");
  level._id_30F6 scripts\sp\utility::_id_10347("sa_vips_brk_copy2_64");
}

_id_13EA8() {
  level.player endon("death");
  level endon("zerog_combat_enemies_dead");
  scripts\engine\utility::flag_wait("zerog_first_enemies_dead");
  level._id_30F6 scripts\sp\utility::_id_10347("sa_vips_brk_transportdeadahead");
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_takeem");
  wait 1;
  _id_13EBA();
  scripts\engine\utility::flag_wait("zerog_third_enemies_dead");
  level._id_30F6 scripts\sp\utility::_id_10347("sa_vips_brk_iseeemguns");
}

_id_13EBA() {
  level.player endon("death");
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_approachingingres");
  scripts\sp\utility::_id_10350("sa_vips_slt_check");
}

_id_BC47(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_3 = var_2 scripts\engine\utility::get_target_ent();
  var_2 moveTo(var_3.origin, var_1);
  var_2 rotateTo(var_3.angles, var_1);
}

_id_BC48(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 4;
  }

  var_3 = getEntArray(var_0, "targetname");

  foreach(var_5 in var_3) {
    var_6 = var_5 scripts\engine\utility::get_target_ent();
    var_7 = randomfloatrange(var_1 - var_1 / 2, var_1);
    var_5 moveTo(var_6.origin, var_7);
    var_5 rotateTo(var_6.angles, var_7);
    var_5 thread _id_0F31::_id_3109(var_7 / var_2);
  }
}

_id_8004() {
  var_0 = getEntArray("objectBrushNoGrapple", "targetname");
  return var_0;
}

_id_91B6() {
  var_0 = getEntArray("large_maintenance_door_left", "targetname");
  var_1 = getEntArray("large_maintenance_door_right", "targetname");
  var_2 = var_0[0] scripts\engine\utility::get_target_array();
  var_3 = var_1[0] scripts\engine\utility::get_target_array();

  foreach(var_5 in var_2) {
    var_5 linkTo(var_0[0]);
  }

  foreach(var_5 in var_3) {
    var_5 linkTo(var_1[0]);
  }

  foreach(var_10 in var_0) {
    var_10 rotateTo((0, 0, 60), 0.05);
  }

  foreach(var_10 in var_1) {
    var_10 rotateTo((0, 0, -60), 0.05);
  }

  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_wait("open_bay");
  playFX(scripts\engine\utility::getfx("vfx_sa_moon_hull_decomp"), var_0[0].origin);

  foreach(var_10 in var_0) {
    var_10 rotateTo((0, 0, 0), 3, 1, 0.05);
  }

  foreach(var_10 in var_1) {
    var_10 rotateTo((0, 0, 0), 3, 1, 0.05);
  }
}

_id_13E8A() {
  var_0 = scripts\sp\vehicle::_id_1080C("zero_g_ally_jackal");
  var_0 _id_0BDC::_id_19A0(1);
  var_0._id_1FBB = "fake_jackal";
  var_0.ignoreall = 1;
  var_0.ignoreme = 1;
  scripts\sp\utility::_id_241F(0);
  var_0 _id_0BDC::_id_6B4C("hover_space");
  var_0 scripts\sp\vehicle::_id_8441();
  level._id_A056._id_1630 = scripts\engine\utility::array_remove(level._id_A056._id_1630, var_0);
  return var_0;
}

_id_A127(var_0) {
  scripts\sp\utility::_id_22CA("axis_jackals", _id_0BDC::_id_1990, 1);
  scripts\sp\utility::_id_22CA("ally_jackal", _id_0BDC::_id_1990, 1);
  level._id_26EB = spawnStruct();
  level._id_26EB thread _id_0F0E::_id_B2D9("axis_jackals", 5, -1, "intro_jackals_done", undefined, undefined, "stop_ambient_jackals");
  level._id_1D0A = spawnStruct();
  level._id_1D0A thread _id_0F0E::_id_B2D9("ally_jackal", 3, -1, "intro_allies_done", 1, undefined, "stop_ambient_jackals");
  level._id_3965 thread _id_0BB6::_id_39F0(undefined, undefined, 1);

  if(isDefined(level._id_3965.turrets)) {
    var_1 = getEnt("mg_cannon_clip", "targetname");
    var_2 = getEnt("flak_cannon_clip", "targetname");

    foreach(var_4 in level._id_3965.turrets) {
      foreach(var_6 in var_4) {
        var_6 setCanDamage(0);
        var_7 = var_2;

        if(var_6.type == "cap_turret_small_constant") {
          var_7 = var_1;
        }

        var_8 = spawn("script_model", var_6.origin);
        var_8.angles = var_6.angles;
        var_8 linkTo(var_6, "tag_origin", (0, 0, 0), (0, 0, 0));
        var_8 clonebrushmodeltoscriptmodel(var_7);

        if(isDefined(var_0)) {
          var_6 thread _id_40D5(var_8, var_0);
        }
      }
    }
  }

  level waittill("zerog_flyby");
  level._id_1D09 = spawnStruct();
  level._id_1D09 thread _id_0F0E::_id_B2DB("ally_jackal_overhead", "allyJackalPath", 4, 4, "intro_allies_done", 1, undefined, undefined);
  level waittill("intro_allies_done");

  foreach(var_12 in level._id_1D0A._id_FE2D) {
    var_12 _id_0BDC::_id_1990(1);
  }
}

_id_40D6() {
  level._id_3965 _id_0BB6::_id_39F1();
  level notify("stop_ambient_jackals");

  if(isDefined(level._id_26EB) && isDefined(level._id_26EB._id_FE2D)) {
    scripts\sp\utility::_id_228A(level._id_26EB._id_FE2D);
  }

  if(isDefined(level._id_1D0A) && isDefined(level._id_1D0A._id_FE2D)) {
    scripts\sp\utility::_id_228A(level._id_1D0A._id_FE2D);
  }

  if(isDefined(level._id_1D09) && isDefined(level._id_1D09._id_FE2D)) {
    scripts\sp\utility::_id_228A(level._id_1D09._id_FE2D);
  }
}

_id_949C() {
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_949A();
}

_id_94A0() {
  _id_133E3();
  _id_B2C8();
  thread _id_0F16::_id_8EA3();
  _id_0F16::_id_3E3F("infiltrate_start_point");
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_949B();
  _id_0E4B::_id_8E06(0);
  wait 0.5;
  level thread _id_4281();
  thread _id_A127("clean_up_turret_clips");
  level._id_2FA5["breach_window_left"] thread _id_0F17::_id_13D5C();
  thread _id_104CE();
}

_id_9498() {
  scripts\engine\utility::flag_set("infiltrate_begin");
  setglobalsoundcontext("atmosphere", "space", 0.1);
  _id_133E4();
  scripts\sp\maps\sa_vips\sa_vips_fx::_id_13360(1);
  scripts\engine\utility::exploder("vfx_vips_gravity_debris");
  scripts\engine\utility::exploder("vfx_vips_airfill");
  scripts\engine\utility::exploder("vfx_vips_airfill_impact");
  var_0 = getEnt("breach_room_screen_access_denied", "targetname");

  if(isDefined(var_0)) {
    var_0 hide();
  }

  var_1 = getEnt("breach_room_screen_bink", "targetname");

  if(isDefined(var_1)) {
    var_1 hide();
  }

  wait 0.5;
  level thread scripts\sp\utility::_id_12643(["sa_vips_starboardlower_tr", "sa_vips_messhall_tr"]);
  _id_0F31::_id_E0C8();
  thread _id_0F35::_id_FAFD();
  thread _id_94A1();
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_9499();
  thread _id_2F87();
  thread _id_2F6C();
  thread _id_949F();
  scripts\engine\utility::trigger_off("player_in_gravity_trigger", "targetname");
  scripts\sp\utility::_id_F3E4(0, 0);
  scripts\engine\utility::flag_set("enable_infiltrate");
  _id_0F0B::_id_F8E7();
  level._id_2F80["hull_breach"]._id_91C5 = ::_id_2FA0;
  level thread _id_1373F();
  scripts\engine\utility::array_thread(level._id_2F7F, _id_0F0B::_id_1592, undefined, undefined, undefined, undefined, ["sa_vips_interior_tr", "sa_vips_breachroom_tr", "sa_vips_prime_tr"]);
  thread scripts\sp\maps\sa_vips\sa_vips_lighting::_id_E70A();
  wait 0.05;
  level thread _id_119C1(scripts\sp\utility::_id_C264("breach_hull_1"), level._id_2F7F[0].origin, 286225, "breach_started");
  _id_2F6E();
  _id_0F05::_id_10B66();
  scripts\engine\utility::trigger_on("player_in_gravity_trigger", "targetname");
  _id_0F0C::_id_E9AB("sa_starboard_lower_vol");
  level thread _id_0F16::_id_991E(1);
  scripts\engine\utility::flag_set("infiltrate_end");

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F53C(1);
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  var_2 = getEntArray("breach_room_dyn_ents", "targetname");

  if(isDefined(var_2)) {
    scripts\sp\utility::_id_228A(var_2);
  }

  if(!scripts\engine\utility::flag("game_saving")) {
    level thread scripts\sp\utility::_id_2679();
  }

  scripts\engine\utility::waitframe();
  level notify("armory_ammo_crates");
}

_id_1373F() {
  level waittill("breach_start");
  setumbraportalstate("infiltrate_window_gate", 1);
  scripts\engine\utility::flag_set("breach_started");
  scripts\engine\utility::exploder("vfx_vips_breach_glass");
}

_id_2F6E() {
  level.player endon("death");
  level waittill("zero_g_mantle_started");
  wait_for_transient_if_queued(["sa_vips_starboardlower_tr"]);
  level thread _id_E463();
  _id_0F35::_id_FB25(0, 1);
  _id_0F31::_id_E0C8();
  _id_0F31::_id_E0CE();
  _id_0F31::_id_E0CD();
  level.player setsoundsubmix("sa_ship_interior");
  level._id_E99E["breach_room_exit_door"].collision solid();
  var_0 = scripts\engine\utility::getStruct("breach_room_exit_door_close_org", "targetname");
  var_1 = scripts\sp\utility::_id_10639("player_arms");
  var_1 hide();
  var_2 = [];
  var_3 = scripts\sp\utility::_id_10639("player_arms");
  var_2[var_2.size] = var_3;
  var_3 hide();
  var_4 = scripts\sp\utility::_id_10639("generic_prop_x3");
  var_2[var_2.size] = var_4;
  level._id_E99E["breach_room_exit_door"].left._id_C730 = level._id_E99E["breach_room_exit_door"].left.origin;
  level._id_E99E["breach_room_exit_door"].left._id_C72A = level._id_E99E["breach_room_exit_door"].left.angles;
  level._id_E99E["breach_room_exit_door"].right._id_C730 = level._id_E99E["breach_room_exit_door"].right.origin;
  level._id_E99E["breach_room_exit_door"].right._id_C72A = level._id_E99E["breach_room_exit_door"].right.angles;
  level._id_E99E["breach_room_exit_door"].left linkTo(var_4, "j_prop_1", (0, 0, 0), (0, 180, 0));
  level._id_E99E["breach_room_exit_door"].right linkTo(var_4, "j_prop_2", (0, 0, 0), (0, 0, 0));
  var_0 thread scripts\sp\anim::_id_1EC3(var_1, "breach_room_console");
  var_0 thread scripts\sp\anim::_id_1EC1(var_2, "breach_room_exit_door_close");
  level waittill("breach_entered");
  _id_0F35::_id_FB26(0, 1);
  level thread scripts\sp\utility::_id_266F();
  scripts\sp\maps\sa_vips\sa_vips_fx::_id_1335D(1);
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_ehtanimonboardi");
  level thread _id_6C74();
  level thread _id_0F00::_id_CDBC("sa_vips_spa_attentionshipha", undefined, undefined, 1);
  var_5 = scripts\engine\utility::getStruct("breach_room_computer", "targetname");
  var_5 _id_0E46::_id_48C4(undefined, undefined, &"SHIP_ASSAULT_ACCESS_TERMINAL");
  scripts\engine\utility::flag_set("obj_marker_on_breach_room_computer");
  var_5 waittill("trigger");
  scripts\engine\utility::flag_set("obj_marker_on_breach_room_computer_disable");
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player disableweaponswitch();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player _meth_80D1();
  var_6 = 0.5;
  level.player _meth_84FE();
  level.player _meth_823C(var_1, "tag_player", var_6, 0.0, 0.0);
  wait(var_6);
  var_1 show();
  level thread _id_2F85();
  var_0 scripts\sp\anim::_id_1F35(var_1, "breach_room_console");
  level.player unlink();
  level.player _meth_84FD();
  var_1 delete();
  level.player enableweapons();
  level.player enableweaponswitch();
  level.player allowsprint(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_80A1();
  level.player freezecontrols(0);
  scripts\engine\utility::flag_wait("breach_room_vo_done");
  level thread scripts\sp\utility::_id_266F();
  var_7 = getEnt("breach_room_exit_door_close_trigger", "targetname");
  var_7 waittill("trigger");
  wait_for_transient_if_queued(["sa_vips_messhall_tr"]);
  level notify("clear_breach_bodies");
  level thread scripts\sp\utility::_id_12651(["sa_vips_space_tr", "sa_vips_spacemisc_tr"]);
  level thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_F0E7();
  level notify("breach_room_exit_door_close_triggered");
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player disableweaponswitch();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player _meth_80D1();
  var_6 = 0.5;
  level.player _meth_823C(var_3, "tag_player", var_6, 0.0, 0.0);
  wait(var_6);
  var_3 show();
  var_0 thread scripts\sp\anim::_id_1F2C(var_2, "breach_room_exit_door_close");
  var_3 waittillmatch("single anim", "button_hit");
  level thread _id_E2EA();
  level thread _id_8528();
  level thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_E460();
  var_0 notify("stop_breach_exit_dead_guys_loop");
  level notify("return_to_gravity_physics_debris_turn_on_phsyics");
  level._id_E99E["breach_room_exit_door"].left unlink();
  level._id_E99E["breach_room_exit_door"].right unlink();
  var_4 delete();
  level._id_E99E["breach_room_exit_door"].left.origin = level._id_E99E["breach_room_exit_door"].left._id_C730;
  level._id_E99E["breach_room_exit_door"].left.angles = level._id_E99E["breach_room_exit_door"].left._id_C72A;
  level._id_E99E["breach_room_exit_door"].right.origin = level._id_E99E["breach_room_exit_door"].right._id_C730;
  level._id_E99E["breach_room_exit_door"].right.angles = level._id_E99E["breach_room_exit_door"].right._id_C72A;
  level._id_E99E["breach_room_exit_door"] _id_0F05::_id_E9A0();
  level._id_E99E["breach_room_exit_door"] thread scripts\sp\utility::play_sound_on_entity("sa_hack_finish");
  level._id_E99E["breach_room_exit_door"] _id_0F05::_id_AED6(0);
  var_3 waittillmatch("single anim", "gun_up");
  level.player enableweapons();
  level thread scripts\sp\utility::_id_1264E("sa_vips_breachroom_tr");
  var_3 waittillmatch("single anim", "end");
  level.player unlink();
  var_3 delete();
  level thread scripts\sp\utility::_id_1264E("sa_vips_breachroom_tr");
}

_id_6C74() {
  level endon("obj_marker_on_breach_room_computer_disable");
  wait 8.0;
  scripts\sp\utility::_id_10350("sa_vips_eth_patchmein");
}

_id_E2EA() {
  level.player endon("death");
  setmusicstate("");
  level.player scripts\sp\utility::_id_1034D("sa_vips_sealtheroom");
  scripts\sp\utility::_id_10350("sa_vips_eth_copy3_75");
  scripts\sp\utility::_id_10350("sa_vips_eth_restoringatmo");
}

_id_8528() {
  while(!level.player isonground() || level.player _meth_84F4() != "none") {
    scripts\engine\utility::waitframe();
  }

  level.player _meth_8545();
  playrumbleonposition("damage_heavy", level.player.origin);
  level.player forceplaygestureviewmodel("ges_samoon_bridge_gravity_land");
  level thread scripts\sp\maps\sa_vips\sa_vips_fx::_id_13310();
  scripts\sp\utility::_id_10FEC("vfx_vips_gravity_debris");
  scripts\engine\utility::exploder("vfx_vips_gravity_debris_on");
  scripts\sp\maps\sa_vips\sa_vips_fx::_id_13360(0);
  wait 2.34;
  level.player allowsprint(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_80A1();
  level.player allowmantle(1);
  level.player _meth_8512(1);
  level.player allowwallrun(1);
  level.player enableweaponswitch();
  level.player freezecontrols(0);
}

_id_E463() {
  var_0 = getEntArray("return_to_gravity_physics_debris", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_E462();
  }
}

_id_E462() {
  thread _id_0F16::_id_6F40();
  thread _id_E464();
}

_id_E464() {
  level waittill("return_to_gravity_physics_debris_turn_on_phsyics");
  wait 3.0;
  self notify("stop_float_in_space");
  self physicslaunchserver(self.origin, (0, 0, -0.1));
  scripts\engine\utility::flag_wait("hack_security_end");
  self delete();
}

_id_40AF() {
  var_0 = getEntArray("return_to_gravity_physics_debris", "targetname");

  if(isDefined(var_0)) {
    scripts\sp\utility::_id_228A(var_0);
  }
}

_id_2F85() {
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_8792();
  thread scripts\sp\maps\sa_vips\sa_vips_lighting::_id_E9F0();
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame("sa_vips_big_screen_animation_v1");
  var_0 = getEnt("breach_room_screen_home", "targetname");

  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_1 = getEnt("breach_room_screen_bink", "targetname");

  if(isDefined(var_1)) {
    var_1 show();
  }

  level thread _id_2F8A();

  while(!iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  while(iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  var_1 = getEnt("breach_room_screen_bink", "targetname");

  if(isDefined(var_1)) {
    var_1 hide();
  }

  var_2 = getEnt("breach_room_screen_access_denied", "targetname");

  if(isDefined(var_2)) {
    var_2 show();
  }
}

_id_2F8A() {
  level.player endon("death");
  wait 6.25;
  level.player scripts\sp\utility::_id_1034D("sa_vips_ethanyourein");
  wait 1.0;
  scripts\sp\utility::_id_10350("sa_vips_eth_scanningnowsir");
  wait 2.25;
  scripts\sp\utility::_id_10350("sa_vips_eth_stolenweaponis");
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_wherearetheeng");
  scripts\engine\utility::flag_set("access_denied");
  scripts\sp\utility::_id_10350("sa_vips_eth_searchingtheyreb");
  wait 3.0;
  level notify("end_pa_group");
  _id_0F00::_id_CDBD("sa_vips_bkv_totheunsaforces", 1);
  level thread _id_0F00::_id_CDD7("war");
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_whereshetrans");
  wait 0.5;
  scripts\sp\utility::_id_10350("sa_vips_eth_whereholding");
  wait 0.2;
  level.player scripts\sp\utility::_id_1034D("sa_vips_moveonhostages");
  scripts\engine\utility::flag_set("breach_room_vo_done");
  scripts\sp\utility::_id_10350("sa_vips_brk_yessironthemove");
}

_id_2F87() {
  scripts\sp\utility::_id_22CA("breach_room_dead_guys", ::_id_2F88);
  var_0 = scripts\sp\utility::_id_22CD("breach_room_dead_guys", 1);
  var_1 = scripts\engine\utility::getStruct("breach_room_exit_door_close_org", "targetname");
  var_1 scripts\sp\anim::_id_1EE7(var_0, "breach_room_dead_guys_loop");
}

_id_2F88() {
  self._id_1FBB = self.script_noteworthy;
  self notsolid();
  scripts\engine\utility::flag_wait("infiltrate_end");
  self delete();
}

_id_2F6C() {
  scripts\sp\utility::_id_22CA("breach_exit_dead_guys", ::_id_2F6D);
  scripts\engine\utility::flag_wait("player_entered_ship");
  wait 2.0;
  var_0 = scripts\sp\utility::_id_22CD("breach_exit_dead_guys", 1);
  var_1 = scripts\engine\utility::getStruct("breach_room_exit_door_close_org", "targetname");
  var_1 scripts\sp\anim::_id_1EE7(var_0, "breach_exit_dead_guys_loop", "stop_breach_exit_dead_guys_loop");
  var_1 scripts\sp\anim::_id_1F2C(var_0, "breach_exit_dead_guys_drop");
}

_id_2F6D() {
  self._id_1FBB = self.script_noteworthy;
  self notsolid();
}

_id_554D(var_0) {
  level.player endon("death");
  setglobalsoundcontext("atmosphere", "space", 2);
  level.player playRumbleOnEntity("damage_heavy");
  thread _id_0F0A::_id_D1D2(var_0, 1);
  wait 1.0;
  level.player thread _id_0F0A::_id_CD73();
  scripts\engine\utility::flag_wait(var_0);
  level.player playSound("sa_ability_lifesupport_on_lr");
  setglobalsoundcontext("atmosphere", "helmet", 2);
  thread _id_0F14::_id_134F9("life_support", "on");
}

_id_94A1() {
  level.player endon("death");
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_movingtobreach");
  scripts\sp\utility::_id_10350("sa_vips_brk_copy2_64");
  scripts\engine\utility::flag_wait("breach_started");
  setmusicstate("");
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_ethangivemeahull");
  wait 0.25;
  scripts\sp\utility::_id_10350("sa_vips_eth_enemiesdirectlyin");
  wait 0.5;
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_notforlong");
  wait 4.0;
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_fireinthehole");
}

_id_2FA0() {
  var_0 = [];
  var_0 = scripts\engine\utility::array_add(var_0, getEnt("sa_sternstarboard_rooma_vol", "targetname"));
  var_0 = scripts\engine\utility::array_add(var_0, getEnt("sa_starboard_lower_vol", "targetname"));
  level thread _id_0F0A::_id_AC5C(var_0, "infiltrate_end");
  level._id_2F80["hull_breach"]._id_B308._id_BFFB._id_10E65 = 1;
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 hide();
  var_1 setModel("sdf_window_exterior_01_shield_destroyed");
  var_1.origin = level._id_2FA5["breach_window_left"]._id_2FA7.origin;
  var_1.angles = level._id_2FA5["breach_window_left"]._id_2FA7.angles;

  if(isDefined(level._id_2FA5["breach_window_left"]._id_83C8)) {
    level._id_2FA5["breach_window_left"]._id_83C8 delete();
  }

  if(isDefined(level._id_2FA5["breach_window_left"]._id_83CD)) {
    level._id_2FA5["breach_window_left"]._id_83CD delete();
  }

  var_2 = scripts\engine\utility::getStruct("breach_room_computer", "targetname");
  glassradiusdamage(var_2.origin, 400, 100, 99);

  if(isDefined(level._id_2FA5["breach_window_left"]._id_6AED)) {
    level._id_2FA5["breach_window_left"]._id_6AED notify("damage", 400);
  }

  level._id_E99E["breach_room_exit_door"].scripted = 1;
  level._id_E99E["breach_room_exit_door"] thread _id_0F05::_id_E9A2();
  thread _id_2FA2();
  wait 0.5;
  level._id_2FA5["breach_window_left"]._id_2FA7 delete();
  var_1 show();

  if(isDefined(level._id_13D3E)) {
    level._id_13D3E show();
  }

  playrumbleonposition("grenade_rumble", level.player.origin);
  level.player _meth_8545();
  level.player forceplaygestureviewmodel("ges_zg_wallbreach_explode");
  screenshake(level.player.origin, 10, 10, 0, 0.75, 0, 0.3, 0, 4, 4, 0);
  level thread _id_2F70();
}

_id_2F70() {
  var_0 = 300;
  var_1 = 65536;
  var_2 = getcorpsearray();

  foreach(var_4 in var_2) {
    var_5 = level._id_2F7F[0].origin;
    var_6 = var_4 _meth_82CC();
    var_7 = distancesquared(var_5, var_6);

    if(var_7 < var_1) {
      physicsjolt(var_4 _meth_82CC(), 60, 60, anglesToForward(level._id_2F7F[0].angles) * var_0);
    }
  }

  var_9 = getaiarray();

  foreach(var_4 in var_9) {
    if(isalive(var_4)) {
      continue;
    }
    var_5 = level._id_2F7F[0].origin;
    var_6 = var_4.origin;
    var_7 = distancesquared(var_5, var_6);

    if(var_7 < var_1) {
      physicsjolt(var_4.origin, 60, 60, anglesToForward(level._id_2F7F[0].angles) * var_0);
    }
  }
}

_id_87DC() {}

_id_87DE() {
  visionsetalternate(2, 0);
  _id_133E4();
  _id_B2C8();
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_87DB();
  thread _id_0F16::_id_8EA3();
  level thread _id_8E82();
  _id_0F0C::_id_E9AB("sa_starboard_lower_vol");
  level thread _id_0F16::_id_991E(1);
  _id_0F16::_id_3E3E("hack_security_start_point");
  level thread _id_40AF();
  level thread _id_5404();
  wait 0.1;
  level._id_E99E["breach_room_exit_door"] _id_0F05::_id_AED6(0);
  scripts\engine\utility::waitframe();
  level notify("armory_ammo_crates");
}

_id_87D9() {
  scripts\engine\utility::flag_set("hack_security_begin");
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  level thread _id_8E98();
  var_0 = getEntArray("zero_g_physics_debris", "targetname");

  if(isDefined(var_0)) {
    scripts\sp\utility::_id_22A4(var_0, "stop_float_in_space");
    scripts\sp\utility::_id_228A(var_0);
  }

  if(!scripts\sp\utility::_id_93A6()) {
    _id_0E4B::_id_8DEA();
  }

  level notify("stop_space_debris");
  level thread _id_87DF();
  level thread starboardlower_force_cleared_when_hubbow_starts();
  setmusicstate("mx_194c_savips_stealth_mood1");
  level thread _id_0F16::_id_88EC();
  level._id_E99E["armory_door_upper_01"] _id_0F05::_id_AED6(0);
  level._id_E99E["armory_door_upper_02"] _id_0F05::_id_AED6(0);
  level._id_E99E["armory_to_hallway_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["hallway_to_mess_door"] _id_0F05::_id_AED6(0);
  _id_0F0C::_id_E9D7("sa_starboard_lower_vol", 1);
  _id_0F0C::_id_E9D7("sa_starboard_lower_rooma_vol", 1);
  _id_0F0C::_id_E9D1("sa_armory_room_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_starboard_lower_rooma_vol", "cleared");
  _id_0F0C::_id_E9D1("sac_bowupper_vol", "cleared");
  level thread _id_10F43();
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_87DA();
  thread _id_87DD();
  thread _id_117C8();
  level thread _id_0F16::_id_1DEA("ambient_ship_moment_interior", "interior_end");
  level thread _id_F0E2();
  scripts\engine\utility::flag_wait("give_ability_security_highlighting");
  level.player _id_0F16::_id_FCF5();
  scripts\engine\utility::flag_set("hack_security_end");
  level thread scripts\sp\utility::_id_2679();
}

starboardlower_force_cleared_when_hubbow_starts() {
  scripts\engine\utility::flag_wait("sa_hubbow_start");
  wait 1;
  _id_0F0C::_id_E9D1("sa_starboard_lower_vol", "cleared");
}

_id_8E98() {
  var_0 = getEnt("messhall_vent_hatch_in_place", "targetname");

  if(isDefined(var_0)) {
    var_0 hide();
    var_0 notsolid();
  }

  var_1 = getEnt("messhall_vent_hatch_in_place_clip", "targetname");

  if(isDefined(var_1)) {
    var_1 notsolid();
    var_1 connectpaths();
  }
}

_id_100EF() {
  var_0 = getEnt("messhall_vent_hatch_in_place", "targetname");

  if(isDefined(var_0)) {
    var_0 show();
    var_0 solid();
  }

  var_1 = getEnt("messhall_vent_hatch_in_place_clip", "targetname");

  if(isDefined(var_1)) {
    var_1 solid();
    var_1 disconnectPaths();
  }
}

_id_8E99() {
  var_0 = getEnt("messhall_vent_hatch_on_ground", "targetname");

  if(isDefined(var_0)) {
    var_0 hide();
    var_0 notsolid();
  }

  var_1 = getEnt("messhall_vent_hatch_on_ground_clip", "targetname");

  if(isDefined(var_1)) {
    var_1 notsolid();
  }
}

_id_100F0() {
  var_0 = getEnt("messhall_vent_hatch_on_ground", "targetname");

  if(isDefined(var_0)) {
    var_0 show();
    var_0 solid();
  }

  var_1 = getEnt("messhall_vent_hatch_on_ground_clip", "targetname");

  if(isDefined(var_1)) {
    var_1 solid();
  }
}

_id_87DF() {
  wait 3.0;
  level._id_D4A5 = 1;
  scripts\sp\utility::_id_10350("sa_vips_eth_keepitslow");
  scripts\engine\utility::flag_wait("start_threat_sight_hint");
  scripts\sp\utility::_id_10350("sa_vips_eth_placetohide");
  scripts\engine\utility::flag_wait("sa_starboard_lower_vol_cleared");
  scripts\sp\utility::_id_10350("sa_vips_eth_youreclear38_3");
  scripts\sp\utility::_id_10350("sa_vips_eth_moreontheway");
  level._id_D4A5 = undefined;
}

_id_F0E2() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("access_cameras_vo");
  level._id_D4A5 = 1;
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_ethancanyoua");
  scripts\sp\utility::_id_10350("sa_vips_eth_accessingstandby");
  scripts\engine\utility::flag_wait("give_ability_security_highlighting");
  level scripts\sp\utility::_id_10350("sa_vips_eth_camerafeedsare");
  level._id_D4A5 = undefined;
}

_id_9A6A() {
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_9A66();
}

_id_9A72() {
  visionsetalternate(2, 0);
  _id_133E4();
  _id_B2C8();
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_9A67();
  thread _id_0F16::_id_8EA3();
  level thread _id_8E82();
  _id_0F0C::_id_E9AB("sa_starboard_lower_rooma_vol");
  _id_0F0C::_id_E9D1("sa_starboard_lower_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_armory_room_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_starboard_lower_rooma_vol", "cleared");
  _id_0F0C::_id_E9D1("sac_bowupper_vol", "cleared");
  level thread _id_0F16::_id_991E(1);
  _id_0F16::_id_3E3E("interior_start_point");
  level.player setstance("crouch");
  level thread _id_8E98();
  level thread _id_40AF();
  level thread _id_5404();
  level thread _id_0F16::_id_88EC();
  _id_0F16::_id_13351("vfx_vips_amb_hall", 1);
  level thread _id_10F43();
  wait 0.1;
  level.player _id_0F16::_id_FCF5();
  level._id_E99E["breach_room_exit_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["armory_to_hallway_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["hallway_to_mess_door"] _id_0F05::_id_AED6(0);
  scripts\engine\utility::waitframe();
  level notify("armory_ammo_crates");
}

_id_2FA2() {
  level.player endon("death");
  level waittill("zero_g_mantle_started");
  scripts\engine\utility::flag_set("clean_up_turret_clips");
  level thread _id_40D6();
  level thread _id_8E82();
  scripts\engine\utility::flag_set("tube_cleanup");
  level thread _id_554D("infiltrate_end");
  scripts\engine\utility::flag_set("player_entered_ship");
}

_id_9A62() {
  scripts\engine\utility::flag_set("interior_begin");
  setglobalsoundcontext("atmosphere", "helmet", 0.1);

  if(!scripts\sp\utility::_id_93A6()) {
    _id_0E4B::_id_8DEA();
  }

  level notify("stop_space_debris");
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_9A65();
  thread _id_9A70();
  level thread _id_0F16::_id_1DEA("ambient_ship_moment_interior", "interior_end");
  level._id_E99E["armory_door_upper_01"] _id_0F05::_id_AED6(0);
  level._id_E99E["armory_door_upper_02"] _id_0F05::_id_AED6(0);
  level._id_E99E["hubbow_to_lower_armory_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["hubbow_to_sac_lower_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["cargo_bay_to_sac_lower_door"] _id_0F05::_id_AED6(0);
  level thread _id_13292();
  level thread _id_46B1();
  scripts\engine\utility::flag_wait("cargo_bay_start");
  scripts\engine\utility::flag_set("interior_end");
  level thread scripts\sp\utility::_id_2679();
}

_id_13292() {
  var_0 = getEnt("vent_hatch", "targetname");
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = getEnt("vent_hatch_clip", "targetname");

  if(isDefined(var_3)) {
    var_3 linkTo(var_0, "tag_origin");
  }

  level thread _id_13293(var_0);
  var_4 = scripts\engine\utility::getStruct("stealth_kill_anim_org", "targetname");
  var_5 = [];
  var_6 = scripts\sp\utility::_id_10639("player_arms");
  var_5[var_5.size] = var_6;
  var_6 hide();
  var_7 = scripts\sp\utility::_id_10639("generic_prop_x3");
  var_5[var_5.size] = var_7;
  var_4 scripts\sp\anim::_id_1EC1(var_5, "vent_open");
  var_0 linkTo(var_7, "j_prop_1");
  var_0 waittill("trigger");
  scripts\engine\utility::flag_set("vent_hatch_triggered");
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_5F14(var_0);
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player setstance("crouch");
  level.player allowstand(0);
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player _meth_80D1();
  level.player _meth_823C(var_6, "tag_player", 0.5, 0.25);
  wait 0.5;
  var_6 show();
  var_4 thread scripts\sp\anim::_id_1F2C(var_5, "vent_open");
  var_6 waittillmatch("single anim", "gun_up");
  level.player enableweapons();
  var_6 waittillmatch("single anim", "end");

  if(isDefined(var_3)) {
    var_3 connectpaths();
  }

  level.player unlink();
  var_6 delete();
  level.player allowsprint(1);
  level.player freezecontrols(0);
  level.player allowstand(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_80A1();
  scripts\engine\utility::flag_wait("recover_tech_begin");
  var_7 scripts\sp\utility::anim_stopanimScripted();
  var_7 clearanim(var_7 scripts\sp\utility::_id_7DC1("vent_open"), 0);
  var_7.origin = var_1;
  var_7.angles = var_2;
  wait 0.05;
  var_3 disconnectPaths();
}

_id_13293(var_0) {
  while(!scripts\engine\utility::flag("vent_hatch_triggered")) {
    var_0 _id_0E46::_id_48C4(undefined, undefined, undefined, undefined, 96, 48, 1);
    scripts\engine\utility::flag_wait("stealth_spotted-Group:sa_starboard_lower_vol_sg");

    if(scripts\engine\utility::flag("vent_hatch_triggered")) {
      return;
    }
    var_1 = [];
    var_2 = [];
    var_3 = [];

    if(isDefined(level._id_E977._id_E6E2["sa_starboard_lower_vol"]) && isDefined(level._id_E977._id_E6E2["sa_starboard_lower_vol"]._id_1352E)) {
      var_4 = level._id_E977._id_E6E2["sa_starboard_lower_vol"]._id_1352E scripts\sp\utility::_id_77E3("axis");

      if(isDefined(var_4)) {
        var_2 = var_4;
        var_2 = scripts\sp\utility::array_removedeadvehicles(var_2);
      }
    }

    if(isDefined(level._id_E977._id_E6E2["sa_starboard_lower_rooma_vol"]) && isDefined(level._id_E977._id_E6E2["sa_starboard_lower_rooma_vol"]._id_1352E)) {
      var_5 = level._id_E977._id_E6E2["sa_starboard_lower_rooma_vol"]._id_1352E scripts\sp\utility::_id_77E3("axis");

      if(isDefined(var_5)) {
        var_3 = var_5;
        var_3 = scripts\sp\utility::array_removedeadvehicles(var_3);
      }
    }

    var_1 = scripts\engine\utility::array_combine(var_2, var_3);

    if(isDefined(var_1) && var_1.size >= 1) {
      var_0 _id_0E46::_id_DFE3();
    }

    scripts\engine\utility::flag_waitopen("stealth_spotted-Group:sa_starboard_lower_vol_sg");
  }
}

_id_E9F1(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("stealth_alertlevel_change");
  var_0 scripts\sp\utility::_id_10347("sa_vips_ss1_wegottamove");
}

_id_E9F2(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("stealth_alertlevel_change");
  wait 2.0;
  var_0 scripts\sp\utility::_id_10347("sa_vips_ss2_headingtosector3");
}

_id_3A65() {
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_3A63();
}

_id_7768(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("stealth_alertlevel_change");
  var_2 = [];
  var_2[var_2.size] = "sa_vips_sa1_gogogo72_1";
  var_2[var_2.size] = "sa_vips_sa1_hurryup72_4";
  var_2[var_2.size] = "sa_vips_sa1_decompressionsalong";
  var_2[var_2.size] = "sa_vips_sa1_pickupteam2";
  var_2[var_2.size] = "sa_vips_sa1_copycommandonsitrep";
  var_2[var_2.size] = "sa_vips_sa1_copyyourlast";
  var_2[var_2.size] = "sa_vips_sa1_gogogo72_1";
  _id_776B(var_2, var_0, var_1);
}

_id_7769(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("stealth_alertlevel_change");
  var_2 = [];
  var_2[var_2.size] = "sa_vips_sa2_movemove72_2";
  var_2[var_2.size] = "sa_vips_sa2_movingtodeck3";
  var_2[var_2.size] = "sa_vips_sa2_letsmovegogo";
  var_2[var_2.size] = "sa_vips_sa2_movingstarboardnow";
  var_2[var_2.size] = "sa_vips_sa2_stillonthemove";
  var_2[var_2.size] = "sa_vips_sa2_fireteamnearmedbay";
  var_2[var_2.size] = "sa_vips_sa2_movemove72_2";
  _id_776B(var_2, var_0, var_1);
}

_id_776A(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("stealth_alertlevel_change");
  var_2 = [];
  var_2[var_2.size] = "sa_vips_sa3_keeptimoving";
  var_2[var_2.size] = "sa_vips_sa3_firesonthedeckbelow";
  var_2[var_2.size] = "sa_vips_sa3_befpretheyflushit";
  var_2[var_2.size] = "sa_vips_sa3_moveyourass";
  var_2[var_2.size] = "sa_vips_sa3_reportinaftersealing";
  var_2[var_2.size] = "sa_vips_sa3_keeptimoving";
  _id_776B(var_2, var_0, var_1);
}

_id_776B(var_0, var_1, var_2) {
  for(;;) {
    var_3 = scripts\engine\utility::random(var_0);

    if(soundexists(var_3)) {
      var_1 scripts\sp\utility::_id_10347(var_3);
      var_0 = scripts\engine\utility::array_remove(var_0, var_3);
    } else
      break;

    if(var_0.size <= 0) {
      break;
    }

    if(isDefined(var_2) && (isDefined(var_2.script_index) && var_2.script_index == -1)) {
      wait(randomfloatrange(3.0, 6.0));
      continue;
    }

    break;
  }
}

_id_3A68() {
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  visionsetalternate(2, 0);
  _id_133E4();
  _id_B2C8();
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_3A64();
  thread _id_0F16::_id_8EA3();
  level thread _id_8E82();
  _id_0F0C::_id_E9AB("sac_bowupper_vol");
  _id_0F0C::_id_E9D1("sa_armory_room_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_hubbow_vol", "cleared");
  _id_0F0C::_id_E9D1("sac_bowupper_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_starboard_lower_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_starboard_lower_rooma_vol", "cleared");
  level thread _id_0F16::_id_991E(1);
  thread _id_0F16::_id_3E3E("cargo_bay_start_point");
  level thread _id_40AF();
  level thread _id_5404();
  level thread _id_10F43();
  level thread _id_46B1();
  _id_0F16::_id_13351("vfx_vips_amb_cargohall", 1);
  _id_0F16::_id_13351("vfx_vips_amb_server", 1);
  level._id_E99E["armory_to_hallway_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["hubbow_to_lower_armory_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["hubbow_to_sac_lower_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["cargo_bay_to_sac_lower_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["hallway_to_mess_door"] _id_0F05::_id_AED6(0);
  level.player _id_0F16::_id_FCF5();
  scripts\engine\utility::waitframe();
  level notify("armory_ammo_crates");
}

_id_3A61() {
  scripts\engine\utility::flag_set("cargo_bay_begin");
  level thread _id_3A67();
  level thread _id_3A69();
  level thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_3A62();
  level thread _id_0F16::_id_1DEA("ambient_ship_moment_cargo_bay", "cargo_bay_end");
  level thread _id_133DD();
  level thread _id_B359(1);
  level thread _id_3A66();
  level thread _id_0B1E::_id_59BE("cargo_bay_peek_door_01");
  level thread _id_0B1E::_id_59BE("cargo_bay_peek_door_02");
  var_0 = getEntArray("cargo_bay_peek_door_02", "targetname");
  var_1 = _id_7C3A(var_0, "door_peek_door");
  var_2 = getEnt("cargo_bay_peek_door_02_clip", "targetname");

  if(isDefined(var_2)) {
    var_2 linkTo(var_1);
  }

  _id_133E9();
  _id_133DA();
  level thread _id_133DF();
  wait 0.05;
  level notify("cargo_bay_peek_door_crates");
  scripts\engine\utility::flag_wait("sa_hangar_vol_cleared");
  _id_0F0C::_id_E9D1("sa_hubbow_vol", "cleared");
  scripts\engine\utility::flag_set("cargo_bay_end");
  level thread scripts\sp\utility::_id_2679();
}

_id_7C3A(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy)) {
      if(var_3.script_noteworthy == var_1) {
        return var_3;
      }
    }
  }
}

_id_3A66() {
  level endon("cargo_bay_end");
  scripts\engine\utility::flag_wait("sa_hangar_start");
  wait 1.0;

  for(;;) {
    wait 1.0;

    if(isDefined(level._id_E977._id_D0F2) && level._id_E977._id_D0F2 != "sa_hangar_vol") {
      continue;
    }
    var_0 = getaiarray("axis");
    var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

    if(isDefined(var_0) && var_0.size <= 3) {
      level._id_112FC = 1;
    }

    if(scripts\engine\utility::is_true(level._id_112FC) && isDefined(var_0) && var_0.size == 1 && scripts\engine\utility::array_contains(var_0, level._id_133D3)) {
      level._id_133D8 = 1;

      while(scripts\engine\utility::is_true(level._id_6787)) {
        wait 0.05;
      }

      if(soundexists("sa_vips_eth_cleartotakeoutcaptain")) {
        level thread scripts\sp\utility::_id_10350("sa_vips_eth_cleartotakeoutcaptain");
        break;
      }
    }
  }
}

_id_133EB() {
  self endon("death");
  scripts\sp\utility::_id_65E3("scurry_anim_finished");
  level._id_133E0 notify(self._id_1FBB + "_stop_loop");
  level._id_133E0 scripts\sp\anim::_id_1F35(self, "underfire_to_rescue");
  level._id_133E0 thread scripts\sp\anim::_id_1EEA(self, "execute_" + self._id_1FBB + "_saved", self._id_1FBB + "_stop_loop");
}

_id_3A69() {
  level.player endon("death");
  setmusicstate("");
  scripts\engine\utility::flag_wait("sa_hangar_start");
  level._id_D4A5 = 1;
  scripts\sp\utility::_id_10350("sa_vips_eth_captainyoureclosin");
  level._id_D4A5 = undefined;
  scripts\engine\utility::flag_wait("player_almost_to_cargo_bay");
  level endon("execute_vips");
  level endon("captain_dead_or_alerted");
  level._id_D4A5 = 1;
  scripts\sp\utility::_id_10350("sa_vips_eth_captainyoureclose");
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_copythat9_12");
  scripts\engine\utility::flag_wait("player_in_cargo_bay");
  thread _id_3A8F();
  level notify("cargo_bay_peek_door_crates");
  level thread scripts\sp\utility::_id_2679();
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_inthecargobay");
  scripts\sp\utility::_id_10350("sa_vips_eth_heldinmainbay");
  scripts\sp\utility::_id_10350("sa_vips_eth_directfightwilllikely");
  scripts\sp\utility::_id_10350("sa_vips_eth_thinktheherdfirst");
  level._id_D4A5 = undefined;
  wait 3.0;
  level._id_D4A5 = 1;
  scripts\sp\utility::_id_10350("sa_vips_slt_reyeswerelockedan");
  level.player scripts\sp\utility::_id_1034D("sa_vips_shithitsfan");
  scripts\sp\utility::_id_10350("sa_vips_slt_solidcopy");
  level._id_D4A5 = undefined;
}

_id_3A8F() {
  wait 1;
  setmusicstate("mx_190_savips_escape");
}

#using_animtree("generic_human");

_id_133E3() {
  _id_EE21();
  _id_D05D();
  _id_A074();
  level._id_EC87["generic"] = #animtree;
  level._id_EC85["breach_exit_dead_guy_1"]["breach_exit_dead_guys_loop"][0] = % sa_vips_body1_zg_door_close_loop;
  level._id_EC85["breach_exit_dead_guy_2"]["breach_exit_dead_guys_loop"][0] = % sa_vips_body2_zg_door_close_loop;
  level._id_EC85["breach_exit_dead_guy_3"]["breach_exit_dead_guys_loop"][0] = % sa_vips_body3_zg_door_close_loop;
  level._id_EC85["breach_exit_dead_guy_1"]["breach_exit_dead_guys_drop"] = % sa_vips_body1_zg_door_close;
  level._id_EC85["breach_exit_dead_guy_2"]["breach_exit_dead_guys_drop"] = % sa_vips_body2_zg_door_close;
  level._id_EC85["breach_exit_dead_guy_3"]["breach_exit_dead_guys_drop"] = % sa_vips_body3_zg_door_close;
  level._id_EC85["generic"]["dismount_left_pilot"] = % vh_zg_org_jackal_dismount_left_pilot;
  level._id_EC85["generic"]["dismount_center_pilot"] = % vh_zg_org_jackal_dismount_center_pilot;
  level._id_EC85["generic"]["dismount_right_pilot"] = % vh_zg_org_jackal_dismount_right_pilot;
  level._id_EC85["generic"]["dismount_left_copilot"] = % vh_zg_org_jackal_dismount_left_copilot;
  level._id_EC85["generic"]["dismount_center_copilot"] = % vh_zg_org_jackal_dismount_center_copilot;
  level._id_EC85["generic"]["dismount_right_copilot"] = % vh_zg_org_jackal_dismount_right_copilot;
  level._id_EC87["breach_x_ray"] = #animtree;
  level._id_EC85["breach_x_ray"]["shipcrib_bridge_sitting_exit_r45_01"] = % shipcrib_bridge_sitting_exit_r45_01;
  level._id_EC85["breach_x_ray"]["payback_escape_forward_wave_right_price"] = % payback_escape_forward_wave_right_price;
  level._id_EC85["breach_x_ray"]["hm_grnd_yel_patrol_creepwalk_console_loop"] = % hm_grnd_yel_patrol_creepwalk_console_loop;
  level._id_EC85["breach_x_ray"]["hm_grnd_grn_walk_frantic_fast_forward"] = % hm_grnd_grn_walk_frantic_fast_forward;
  level._id_EC85["breach_x_ray"]["run_lowready_f_noloop"] = % run_lowready_f_noloop;
  level._id_EC85["breach_x_ray"]["hm_grnd_run_lowready_twitch_stumble_forward01_ar"] = % hm_grnd_run_lowready_twitch_stumble_forward01_ar;
  level._id_EC85["sa_vips_breach_room_body1"]["breach_room_dead_guys_loop"][0] = % sa_vips_breach_room_body1;
  level._id_EC85["sa_vips_breach_room_body2"]["breach_room_dead_guys_loop"][0] = % sa_vips_breach_room_body2;
  level._id_EC85["sa_vips_breach_room_body3"]["breach_room_dead_guys_loop"][0] = % sa_vips_breach_room_body3;
  level._id_EC85["sa_vips_breach_room_body4"]["breach_room_dead_guys_loop"][0] = % sa_vips_breach_room_body4;
}

_id_133E4() {
  _id_EE22();
  _id_D105();
  _id_7760();
  _id_341F();
  level._id_EC87["vip1"] = #animtree;
  level._id_EC85["vip1"]["vip_idle"][0] = % sa_vips_hostages_idle_hostage01;
  level._id_EC85["vip1"]["execute_vip1"] = % sa_vips_hostages_kill1_hostage01;
  level._id_EC85["vip1"]["execute_vip1_saved"][0] = % sa_vips_hostages_rescue_idle_hostage01;
  level._id_EC85["vip1"]["vip_scurry"] = % sa_vips_hostages_scurry_hostage01;
  level._id_EC85["vip1"]["vip_underfire_idle"][0] = % sa_vips_hostages_underfire_idle_hostage01;
  level._id_EC85["vip1"]["underfire_to_rescue"] = % sa_vips_hostages_cover_transition_hostage01;
  scripts\sp\anim::_id_17F6("vip1", "death", ::_id_A5F4, "execute_vip1");
  level._id_EC87["vip2"] = #animtree;
  level._id_EC85["vip2"]["vip_idle"][0] = % sa_vips_hostages_idle_hostage02;
  level._id_EC85["vip2"]["execute_vip2"] = % sa_vips_hostages_kill2_hostage02;
  level._id_EC85["vip2"]["execute_vip2_saved"][0] = % sa_vips_hostages_rescue_idle_hostage02;
  level._id_EC85["vip2"]["vip_scurry"] = % sa_vips_hostages_scurry_hostage02;
  level._id_EC85["vip2"]["vip_underfire_idle"][0] = % sa_vips_hostages_underfire_idle_hostage02;
  level._id_EC85["vip2"]["underfire_to_rescue"] = % sa_vips_hostages_cover_transition_hostage02;
  scripts\sp\anim::_id_17F6("vip2", "death", ::_id_A5F4, "execute_vip2");
  level._id_EC87["vip3"] = #animtree;
  level._id_EC85["vip3"]["vip_idle"][0] = % sa_vips_hostages_idle_hostage03;
  level._id_EC85["vip3"]["execute_vip3"] = % sa_vips_hostages_kill3_hostage03;
  level._id_EC85["vip3"]["execute_vip3_saved"][0] = % sa_vips_hostages_rescue_idle_hostage03;
  level._id_EC85["vip3"]["vip_scurry"] = % sa_vips_hostages_scurry_hostage03;
  level._id_EC85["vip3"]["vip_underfire_idle"][0] = % sa_vips_hostages_underfire_idle_hostage03;
  level._id_EC85["vip3"]["underfire_to_rescue"] = % sa_vips_hostages_cover_transition_hostage03;
  scripts\sp\anim::_id_17F6("vip3", "death", ::_id_A5F4, "execute_vip3");
  level._id_EC87["vip4"] = #animtree;
  level._id_EC85["vip4"]["vip_idle"][0] = % sa_vips_hostages_idle_hostage04;
  level._id_EC85["vip4"]["execute_vip4"] = % sa_vips_hostages_kill4_hostage04;
  level._id_EC85["vip4"]["execute_vip4_saved"][0] = % sa_vips_hostages_rescue_idle_hostage04;
  level._id_EC85["vip4"]["vip_scurry"] = % sa_vips_hostages_scurry_hostage04;
  level._id_EC85["vip4"]["vip_underfire_idle"][0] = % sa_vips_hostages_underfire_idle_hostage04;
  level._id_EC85["vip4"]["underfire_to_rescue"] = % sa_vips_hostages_cover_transition_hostage04;
  scripts\sp\anim::_id_17F6("vip4", "death", ::_id_A5F4, "execute_vip4");
  level._id_EC87["vip_captain"] = #animtree;
  level._id_EC85["vip_captain"]["execution_pace_idle"] = % sa_vips_hostages_pace_idle_executioner;
  level._id_EC85["vip_captain"]["execution_ready_idle"][0] = % sa_vips_hostages_ready_idle_executioner;
  level._id_EC85["vip_captain"]["execute_vip1"] = % sa_vips_hostages_kill1_executioner;
  level._id_EC85["vip_captain"]["execute_vip2"] = % sa_vips_hostages_kill2_executioner;
  level._id_EC85["vip_captain"]["execute_vip3"] = % sa_vips_hostages_kill3_executioner;
  level._id_EC85["vip_captain"]["execute_vip4"] = % sa_vips_hostages_kill4_executioner;
  level._id_EC87["salter"] = #animtree;
  level._id_EC85["salter"]["vip_outro"] = % sa_vips_hostages_outro_salter;
  level._id_EC88["salter"]["sa_vips_slt_secureengineer"] = % sa_vips_slt_secureengineer_face;
  level._id_EC88["salter"]["sa_vips_slt_brookskashimas"] = % sa_vips_slt_brookskashimas_face;
  level._id_EC88["salter"]["sa_vips_slt_securebodies"] = % sa_vips_slt_securebodies_face;
  level._id_EC87["generic"] = #animtree;
  level._id_EC85["generic"]["run_explosion_death_left_01"] = % hm_grnd_run_lowready_explosion_death_left01;
  level._id_EC85["generic"]["run_explosion_death_left_02"] = % hm_grnd_run_lowready_explosion_death_left02;
  level._id_EC85["generic"]["sa_vips_deadman_drag_enemy1"] = % sa_vips_deadman_drag_enemy1;
  scripts\sp\anim::_id_17F6("generic", "start_drag", ::_id_4DF2, "sa_vips_deadman_drag_enemy1");
  level._id_EC85["generic"]["sa_vips_deadman_drag_enemy2"] = % sa_vips_deadman_drag_enemy2;
  level._id_EC85["generic"]["sa_vips_deadman_drag_deadbody"] = % sa_vips_deadman_drag_deadbody;
  level._id_EC85["generic"]["sa_vips_deadman_drag_deadbody_loop"][0] = % sa_vips_deadman_drag_deadbody_loop;
  scripts\sp\anim::_id_17F6("generic", "death", ::_id_4DF4, "sa_vips_deadman_drag_deadbody");
  level._id_EC87["generic"] = #animtree;
  level._id_EC85["generic"]["hm_grnd_org_long_death_crawl_death01"] = % hm_grnd_org_long_death_crawl_death01;
  level._id_EC85["generic"]["hm_grnd_org_long_death_crawl_back_death01"] = % hm_grnd_org_long_death_crawl_back_death01;
  level._id_EC85["generic"]["hm_grnd_org_long_death_crawl_back_death02"] = % hm_grnd_org_long_death_crawl_back_death02;
  level._id_EC85["generic"]["body_bag_body_loop_victim"] = % sa_vips_stealth_kill_loop_victim;
  level._id_EC85["generic"]["body_bag_body_loop_body1"][0] = % sa_vips_stealth_kill_loop_body1;
  level._id_EC85["generic"]["body_bag_body_loop_body2"][0] = % sa_vips_stealth_kill_loop_body2;
  level._id_EC85["generic"]["body_bag_body_loop_body3"][0] = % sa_vips_stealth_kill_loop_body3;
  level._id_EC85["generic"]["body_bag_melee_kill"] = % sa_vips_stealth_kill_victim;
  scripts\sp\anim::_id_17F6("generic", "stealth_kill", ::_id_10ED0, "body_bag_melee_kill");
}

_id_133E2() {
  _id_A1AF();
  _id_D057();
  _id_EE20();
  _id_775F();
}

_id_2C0C(var_0, var_1) {
  level._id_2C0B = var_0;
  level._id_2C0B._id_4591 = level._id_10ED1.origin;
  level._id_2C0B._id_4583 = level._id_10ED1.angles;
  level._id_2C0B thread scripts\sp\maps\sa_vips\sa_vips_fx::_id_132E1();
  level._id_2C0B thread _id_0E45::_id_F309("body_bag_melee_kill");
  wait 0.05;
  level._id_2C0B scripts\sp\utility::_id_65E1("stealth_hold_position");
  level._id_2C0B scripts\engine\utility::waittill_either("stealth_alertlevel_change", "death");

  if(isDefined(level._id_2C0B) && isalive(level._id_2C0B)) {
    level._id_2C0B._id_4591 = undefined;
    level._id_2C0B._id_4583 = undefined;
    level._id_2C0B thread _id_0E45::_id_F309(undefined, undefined);
  }

  scripts\engine\utility::flag_set("body_bag_melee_kill_enemy_dead_or_alerted");
}

_id_4DF2(var_0) {
  var_1 = getspawner("deadman_spawner", "targetname");
  var_1 scripts\sp\utility::_id_1747(::_id_4DF5, var_0);
  var_0._id_4DF1 = var_1 scripts\sp\utility::_id_10619(1);
  var_0 scripts\engine\utility::waittill_either("stealth_alertlevel_change", "death");

  if(isDefined(var_0._id_4DF1)) {
    var_0._id_4DF1 notify("stop_deadman_funcs");
    var_0._id_4DF1 startragdoll();
  }
}

_id_4DF5(var_0) {
  self endon("stop_deadman_funcs");
  scripts\sp\utility::_id_86E4();
  self notsolid();
  self._id_1FBB = "generic";
  wait 0.1;
  self._id_EF68 = var_0._id_A889;
  var_0._id_A889 thread scripts\sp\anim::_id_1EC7(self, "sa_vips_deadman_drag_deadbody");
  wait 0.05;
  var_1 = var_0 islegacyagent(var_0 scripts\sp\utility::_id_7DC3("sa_vips_deadman_drag_enemy1"));
  self _meth_82B0(scripts\sp\utility::_id_7DC3("sa_vips_deadman_drag_deadbody"), var_1);
}

_id_4DF4(var_0) {
  if(isDefined(var_0) && isalive(var_0)) {
    var_0._id_EF68 scripts\sp\anim::_id_1ECC(var_0, "sa_vips_deadman_drag_deadbody_loop");
  }
}

#using_animtree("player");

_id_D05D() {
  level._id_EC87["player_arms"] = #animtree;
  level._id_EC8C["player_arms"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_arms"]["breach_room_console"] = % sa_vips_plr_console_access;
  level._id_EC85["player_arms"]["breach_room_exit_door_close"] = % sa_vips_plr_zg_door_close;
}

_id_D105() {
  level._id_EC87["player_arms"] = #animtree;
  level._id_EC8C["player_arms"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_arms"]["vent_open"] = % sa_vips_vent_open_plr;
  level._id_EC85["player_arms"]["weapon_pickup"] = % sa_vips_chargeshot_pickup_plr;
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["body_bag_melee_kill"] = % sa_vips_stealth_kill_plr;
}

#using_animtree("script_model");

_id_EE22() {
  level._id_EC87["generic_prop_x3"] = #animtree;
  level._id_EC8C["generic_prop_x3"] = "generic_prop_x3";
  level._id_EC85["generic_prop_x3"]["vent_open"] = % sa_vips_vent_open_vent;
  level._id_EC87["chargeshot"] = #animtree;
  level._id_EC8C["chargeshot"] = "weapon_chargeshot_vm";
  level._id_EC85["chargeshot"]["weapon_pickup"] = % sa_vips_chargeshot_pickup_gun;
}

_id_EE21() {
  level._id_EC87["generic_prop_x3"] = #animtree;
  level._id_EC8C["generic_prop_x3"] = "generic_prop_x3";
  level._id_EC85["generic_prop_x3"]["breach_room_exit_door_close"] = % sa_vips_doors_zg_door_close;
}

#using_animtree("generic_human");

_id_7760() {
  level._id_EC85["carry_man_a"]["fireman_carry"] = % sa_vips_ambience_fireman_carry_guya;
  level._id_EC85["carry_man_a"]["fireman_carry_idle"][0] = % sa_vips_ambience_fireman_carry_guya_idle;
  level._id_EC85["carry_man_b"]["fireman_carry"] = % sa_vips_ambience_fireman_carry_guyb;
  level._id_EC85["carry_man_b"]["fireman_carry_idle"][0] = % sa_vips_ambience_fireman_carry_guyb_idle;
  level._id_EC85["redshirt_radio"]["redshirt_radio_idle"][0] = % titan_stealth_street_sdf_radio_idle;
}

_id_775F() {
  level._id_EC87["salter"] = #animtree;
  level._id_EC85["salter"]["exfil"] = % sa_vips_exfil_xo;
  level._id_EC85["salter"]["exfil_loop"][0] = % sa_vips_exfil_loop_xo;
}

#using_animtree("script_model");

_id_EE20() {
  level._id_EC87["sdf_door_airlock_01"] = #animtree;
  level._id_EC8C["sdf_door_airlock_01"] = "sdf_door_airlock_01";
  level._id_EC85["sdf_door_airlock_01"]["exfil_door_interior"] = % sa_vips_airlock_pull_airlock;
  level._id_EC85["sdf_door_airlock_01"]["exfil_door_exterior"] = % sa_vips_exfil_airlock;
}

#using_animtree("c8");

_id_341F() {
  level._id_EC85["c8"]["c8_startup"] = % c8_grnd_org_exposed_crouch_to_stand;
}

#using_animtree("jackal");

_id_A074() {
  level._id_EC87["fake_jackal"] = #animtree;
  level._id_EC8C["fake_jackal"] = "veh_mil_air_un_jackal_02";
}

_id_A1AF() {
  level._id_EC87["fake_jackal"] = #animtree;
  level._id_EC8C["fake_jackal"] = "veh_mil_air_un_jackal_02";
  level._id_EC85["fake_jackal"]["exfil"] = % sa_vips_exfil_jackal;
  level._id_EC85["fake_jackal"]["exfil_loop"][0] = % sa_vips_exfil_loop_jackal;
}

#using_animtree("player");

_id_D057() {
  level._id_EC87["player_arms"] = #animtree;
  level._id_EC8C["player_arms"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_arms"]["exfil_door_interior"] = % sa_vips_airlock_pull_plr;
  level._id_EC85["player_arms"]["exfil_door_exterior"] = % sa_vips_exfil_plr;
}

_id_A5F4(var_0) {
  if(isDefined(var_0) && isalive(var_0)) {
    var_0 scripts\sp\utility::_id_1101B();
    var_0 scripts\sp\utility::_id_54C6();
  }
}

_id_133DA() {
  var_0 = getEnt("vip_captain_spawner", "targetname");
  var_0 scripts\sp\utility::_id_1747(::_id_133D9);
  var_0 scripts\sp\utility::_id_1747(::_id_3A27);
  var_0 scripts\sp\utility::_id_1747(::_id_133D4);
  level._id_133D3 = scripts\sp\utility::_id_107EA("vip_captain_spawner", 1);
  wait 0.05;
  scripts\engine\utility::flag_set("captain_spawned");
}

_id_133D4() {
  self waittill("death");
  _id_0A2F::_id_DA45("captain5");
}

_id_133E9() {
  scripts\sp\utility::_id_22CA("vip_spawners", ::_id_133E7);
  level._id_1342C = scripts\sp\utility::_id_22CD("vip_spawners", 1);
  level._id_1342D = level._id_1342C.size;
  wait 0.05;
  scripts\engine\utility::flag_set("vips_spawned");
}

_id_133E7() {
  self endon("death");
  _id_0F19::_id_F30D();
  scripts\sp\utility::_id_65E0("scurry_anim_finished");
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_B14F(1);
  scripts\sp\utility::_id_F2A8(1);
  self.a.nodeath = 1;
  scripts\sp\utility::_id_86E4();
  self.diequietly = 1;
  self.noragdoll = 1;
  scripts\sp\utility::_id_5564();

  switch (self.script_noteworthy) {
    case "vip1":
      self._id_1FBB = self.script_noteworthy;
      level._id_133CF = self;
      self._id_EB74 = "execute_vip1_saved";
      self._id_13704 = "kill1";
      break;
    case "vip2":
      self._id_1FBB = self.script_noteworthy;
      level._id_133D0 = self;
      self._id_EB74 = "execute_vip2_saved";
      self._id_13704 = "kill2";
      break;
    case "vip3":
      self._id_1FBB = self.script_noteworthy;
      level._id_133D1 = self;
      self._id_EB74 = "execute_vip3_saved";
      self._id_13704 = "kill3";
      break;
    case "vip4":
      self._id_1FBB = self.script_noteworthy;
      level._id_133D2 = self;
      self._id_EB74 = "execute_vip4_saved";
      self._id_13704 = "kill4";
      break;
    default:
      break;
  }

  thread _id_133DB();
  scripts\sp\utility::_id_86E4();
  self.health = 50;
}

_id_133DD() {
  wait 0.1;
  scripts\engine\utility::flag_wait_any("execute_vips", "captain_dead_or_alerted");
  wait 0.05;
  level._id_133E0 notify("vip1_stop_loop");
  level._id_133E0 notify("vip2_stop_loop");
  level._id_133E0 notify("vip3_stop_loop");
  level._id_133E0 notify("vip4_stop_loop");

  if(isDefined(level._id_133CF) && isalive(level._id_133CF)) {
    level._id_133CF thread _id_133E6("vip1_stop_loop");
  }

  if(isDefined(level._id_133D0) && isalive(level._id_133D0)) {
    level._id_133D0 thread _id_133E6("vip2_stop_loop");
  }

  if(isDefined(level._id_133D1) && isalive(level._id_133D1)) {
    level._id_133D1 thread _id_133E6("vip3_stop_loop");
  }

  if(isDefined(level._id_133D2) && isalive(level._id_133D2)) {
    level._id_133D2 thread _id_133E6("vip4_stop_loop");
  }

  level endon("sa_hangar_vol_cleared");

  while(isDefined(level._id_1342C[0]) && level._id_1342C.size > 0) {
    wait 16.0;

    if(isDefined(level._id_1342C[0]) && isalive(level._id_1342C[0])) {
      if(isDefined(level._id_1342C[0]._id_B14F) && level._id_1342C[0]._id_B14F) {
        level._id_1342C[0] scripts\sp\utility::_id_1101B();
      }

      level._id_1342C[0] scripts\sp\utility::_id_F2A8(1);
      level._id_1342C[0] scripts\sp\utility::_id_F416(0);
      level._id_1342C[0].a.nodeath = 0;
      level._id_1342C[0].diequietly = 0;
      level._id_1342C[0].noragdoll = undefined;
      level._id_1342C[0].forceragdollimmediate = 1;
    }
  }
}

_id_133E6(var_0) {
  self endon("death");
  scripts\engine\utility::delaycall(randomfloatrange(0.05, 0.5), ::playsound, "sa_vips_eng_panic");
  level._id_133E0 scripts\sp\anim::_id_1F35(self, "vip_scurry");

  if(scripts\engine\utility::flag("sa_hangar_vol_cleared")) {
    level._id_133E0 notify(self._id_1FBB + "_stop_loop");
    level._id_133E0 scripts\sp\anim::_id_1F35(self, "underfire_to_rescue");
    level._id_133E0 thread scripts\sp\anim::_id_1EEA(self, "execute_" + self._id_1FBB + "_saved", self._id_1FBB + "_stop_loop");
  } else {
    level._id_133E0 thread scripts\sp\anim::_id_1EEA(self, "vip_underfire_idle", var_0);
    scripts\engine\utility::flag_wait("sa_hangar_vol_cleared");
    level._id_133E0 notify(self._id_1FBB + "_stop_loop");
    level._id_133E0 scripts\sp\anim::_id_1F35(self, "underfire_to_rescue");
    level._id_133E0 thread scripts\sp\anim::_id_1EEA(self, "execute_" + self._id_1FBB + "_saved", self._id_1FBB + "_stop_loop");
  }
}

_id_133DB() {
  self waittill("death");
  level._id_1342C = scripts\engine\utility::array_remove(level._id_1342C, self);
  level._id_1342D--;

  if(level._id_1342D <= 0) {
    scripts\engine\utility::flag_set("vips_dead");
  }
}

_id_133D9() {
  self endon("death");
  self._id_1FBB = "vip_captain";
  scripts\sp\utility::_id_F2A8(1);
  scripts\engine\utility::flag_init("captain_dead_or_alerted");
  scripts\engine\utility::flag_init("captain_dead");
  thread _id_C846();
  var_0 = _id_0F27::_id_79F6("stealth_spotted");
  level thread _id_68D4(var_0);
  wait 0.05;
  thread _id_133D7(var_0);
  scripts\sp\utility::_id_65E1("stealth_hold_position");
}

_id_133D7(var_0) {
  self endon("death");

  for(;;) {
    if(scripts\engine\utility::flag(var_0)) {
      break;
    }

    if(isDefined(level._id_E977._id_D0F2) && level._id_E977._id_D0F2 == "sa_hangar_vol") {
      scripts\sp\utility::_id_F415(0);
    } else {
      scripts\sp\utility::_id_F415(1);
    }

    wait 0.05;
  }

  level thread _id_0F27::_id_558C();
  scripts\sp\utility::_id_F415(0);
}

_id_C846() {
  scripts\engine\utility::flag_wait("captain_dead_or_alerted");

  if(isDefined(level._id_C84C)) {
    wait 0.05;
    level._id_C84C stopsounds();
  }
}

_id_46B1() {
  level endon("execute_vips");
  level endon("captain_dead_or_alerted");
  wait 0.25;
  var_0 = [];
  var_0[var_0.size] = "sa_vips_bkv_atruewarriorwou";
  var_0[var_0.size] = "sa_vips_bkv_theirbloodisony";
  var_0[var_0.size] = "sa_vips_bkv_justturnyoursel";
  var_0[var_0.size] = "sa_vips_bkv_youhavecomehere";
  var_0[var_0.size] = "sa_vips_bkv_theearthbornare";
  var_0[var_0.size] = "sa_vips_bkv_comesavethemyou";
  var_0[var_0.size] = "sa_vips_bkv_onlyyoucanstopt";
  var_0[var_0.size] = "sa_vips_bkv_theywerenotbrou";
  var_0[var_0.size] = "sa_vips_bkv_youcamealongway";

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    _id_0F00::_id_CDBD(var_0[var_1], 1, undefined, 1);
    wait 15.0;

    if(var_1 >= var_0.size) {
      var_1 = 0;
    }
  }
}

_id_133D5() {
  level._id_133D5 = 1;
}

_id_68D4(var_0) {
  scripts\engine\utility::flag_wait(var_0);
  level thread _id_0F27::_id_558C();
  scripts\engine\utility::flag_set("execute_vips");
  level._id_C816 = undefined;
  _id_0F16::_id_2638(1);
  _id_0F16::_id_2637(&"SA_VIPS_DEFEND");
}

_id_B359(var_0, var_1) {
  if(scripts\engine\utility::is_true(var_0)) {
    level waittill("sa_hangar_vol_spawned");
    var_2 = level._id_E977._id_E6E2["sa_hangar_vol"]._id_C203;
    var_3 = scripts\engine\utility::flag_wait_any_return("execute_vips", "sa_hangar_vol_cleared", "vips_dead");

    if(isDefined(var_3) && var_3 == "execute_vips") {
      var_4 = level._id_E977._id_E6E2["sa_hangar_vol"]._id_1352E scripts\sp\utility::_id_77E3("axis");
      var_4 = scripts\sp\utility::array_removedeadvehicles(var_4);

      foreach(var_6 in var_4) {
        if(!isDefined(var_6._id_1074F)) {
          var_4 scripts\engine\utility::array_remove(var_4, var_6);
        }
      }

      if(var_4.size > var_2 - 4) {
        wait 6.0;
        level thread _id_B355();
      }
    } else if(isDefined(var_3) && var_3 == "vips_dead")
      level thread _id_B354();
  }

  scripts\sp\utility::_id_22CA("marines", ::_id_B350, var_1);
  level._id_B351 = scripts\sp\utility::_id_22CD("marines", 1);
}

_id_B355() {
  scripts\sp\utility::_id_10350("sa_vips_slt_gogogo");
  scripts\sp\utility::_id_10350("sa_vips_ksh_cominginhotlt");
}

_id_B354() {
  scripts\sp\utility::_id_10350("sa_vips_slt_gogogo");
  scripts\sp\utility::_id_10350("sa_vips_ksh_cominginhotlt");
}

_id_B350(var_0) {
  self endon("death");
  scripts\sp\utility::_id_B14F(1);
  scripts\sp\utility::_id_F417(1);
  scripts\sp\utility::_id_F2D8(10);
  thread scripts\sp\utility::_id_F2DA(1);

  switch (self.script_noteworthy) {
    case "salter":
      level._id_EA2C = self;
      self._id_1FBB = "salter";
      thread _id_0F16::isfirstarmageddonmeteorhit("iw7_m4+silencer", "primary", "iw7_m8");
      break;
    case "marine_01":
      level._id_B340 = self;
      self._id_1FBB = "marine_01";
      thread _id_0F16::isfirstarmageddonmeteorhit("iw7_m4+silencer", "primary", "iw7_m8");
      break;
    case "marine_02":
      level._id_B341 = self;
      self._id_1FBB = "marine_02";
      thread _id_0F16::isfirstarmageddonmeteorhit("iw7_erad+silencersmge", "primary", "iw7_m8");
      break;
    default:
      break;
  }

  scripts\engine\utility::flag_wait("sa_hangar_vol_cleared");
  wait 0.5;

  if(isDefined(level._id_1342D) && level._id_1342D >= 1) {}

  switch (self.script_noteworthy) {
    case "salter":
      if(scripts\engine\utility::is_true(var_0)) {
        var_1 = getnode("salter_guard_node", "targetname");
        scripts\sp\utility::_id_F39F();
        scripts\sp\utility::_id_F3BC();
        scripts\sp\utility::_id_1160F(var_1);
      }

      scripts\engine\utility::flag_wait("salter_start_ready_to_recover_tech");
      self.asm.movementgunposeoverride = "run_gun_down";
      level._id_133E0 scripts\sp\anim::_id_1F17(self, "vip_outro");
      level thread _id_EA4B();
      level._id_133E0 scripts\sp\anim::_id_1F37(self, "vip_outro");
      scripts\sp\utility::_id_F39E();
      scripts\sp\utility::_id_12BFA();
      scripts\engine\utility::flag_set("salter_ready_to_recover_tech");
      break;
    case "marine_01":
      scripts\sp\utility::_id_51E1("cqb");
      scripts\sp\utility::_id_F39F();
      scripts\sp\utility::_id_F3BC();
      var_2 = getnode("marine_01_guard_node", "targetname");

      if(scripts\engine\utility::is_true(var_0)) {
        scripts\sp\utility::_id_F3DD(8.0);
        scripts\sp\utility::_id_1160F(var_2);
      } else {
        scripts\sp\utility::_id_F3DD(var_2.radius);
        scripts\sp\utility::_id_F3D9(var_2);
      }

      break;
    case "marine_02":
      scripts\sp\utility::_id_51E1("cqb");
      scripts\sp\utility::_id_F39F();
      scripts\sp\utility::_id_F3BC();
      var_3 = getnode("marine_02_guard_node", "targetname");

      if(scripts\engine\utility::is_true(var_0)) {
        scripts\sp\utility::_id_1160F(var_3);
      } else {
        scripts\sp\utility::_id_F3DD(8.0);
        scripts\sp\utility::_id_F3DD(var_3.radius);
        scripts\sp\utility::_id_F3D9(var_3);
      }

      break;
    default:
      break;
  }
}

_id_EA4B() {
  if(level._id_1342D > 0) {
    if(level._id_1342D == 1) {
      level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_secureengineer");
    } else {
      level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_brookskashimas");
    }
  } else
    level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_securebodies");

  level._id_B340 thread scripts\sp\utility::_id_10346("sa_vips_brk_copy11_98");
  wait 0.5;
  level._id_B341 thread scripts\sp\utility::_id_10346("sa_vips_ksh_copy11_96");
}

_id_DDFF() {
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_DDFD();
}

_id_DE02() {
  visionsetalternate(2, 0);
  _id_133E4();
  _id_B2C8();
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_DDFE();
  thread _id_0F16::_id_8EA3();
  level thread _id_8E82();
  _id_0F0C::_id_E9AB("sa_hangar_vol");
  _id_0F0C::_id_E9D1("sa_hangar_vol", "cleared");
  _id_0F0C::_id_E9D1("sac_bowupper_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_hubbow_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_starboard_lower_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_starboard_lower_rooma_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_armory_room_vol", "cleared");
  level thread _id_0F16::_id_991E(1);
  thread _id_0F16::_id_3E3E("recover_tech_start_point");
  _id_133E9();
  level thread _id_40AF();
  _id_0F16::_id_13351("vfx_vips_amb_cargo", 1);
  level._id_133E0 thread scripts\sp\anim::_id_1EEA(level._id_133CF, "vip_underfire_idle", "vip1_stop_loop");
  level._id_133E0 thread scripts\sp\anim::_id_1EEA(level._id_133D0, "vip_underfire_idle", "vip2_stop_loop");
  level._id_133E0 thread scripts\sp\anim::_id_1EEA(level._id_133D1, "vip_underfire_idle", "vip3_stop_loop");
  level._id_133E0 thread scripts\sp\anim::_id_1EEA(level._id_133D2, "vip_underfire_idle", "vip4_stop_loop");
  level.player _id_0F16::_id_FCF5();
  scripts\engine\utility::flag_set("sa_hangar_vol_cleared");
  level thread _id_B359(undefined, 1);
  level._id_E99E["breach_room_exit_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["cargo_bay_to_sac_lower_door"] _id_0F05::_id_AED6(0);
  wait 0.05;
  level notify("cargo_bay_peek_door_crates");
  level notify("armory_ammo_crates");
}

_id_DDFB() {
  scripts\engine\utility::flag_set("recover_tech_begin");
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  level._id_5A3E = 1;
  level thread _id_104CE();
  _id_0F0C::_id_E9D1("sa_hangar_vol", "cleared");
  _id_0F0C::_id_E9D1("sac_bowupper_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_hubbow_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_starboard_lower_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_starboard_lower_rooma_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_armory_room_vol", "cleared");
  level thread _id_DE03();
  level thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_DDFC();
  level._id_10FB1 = getEnt("stolen_tech", "targetname");
  level._id_10FB1 _id_0E46::_id_48C4();
  level._id_10FB1._id_6AF1 = 1;
  level thread _id_3CCB();
  level thread _id_5987("lower_cargobay_door_close", "cargobay_door_close_check", "cargo_bay_to_sac_lower_door", "sa_vips_cargobay_tr", undefined, "cargobay_regroup_ammo_crate");
  level thread _id_2254();
  level thread _id_DE01();
  level thread _id_0F16::_id_1DEA("ambient_ship_moment_recover_tech", "recover_tech_end");
  wait 0.05;
  level thread _id_0F27::_id_558C();
  scripts\engine\utility::flag_wait("start_missile_racks");
  level._id_DBBE = getEntArray("missile_racks", "targetname");
  scripts\engine\utility::array_thread(level._id_DBBE, _id_0EFC::_id_F9D7);
  level._id_E99E["hubbow_to_sac_lower_door"]._id_C611 = 0;
  wait 0.5;
  level notify("armory_ammo_crates");
  scripts\engine\utility::flag_wait("tech_recovered");
  level thread scripts\sp\utility::_id_1264E("sa_vips_bowlower_tr");
  level._id_E99E["hubbow_to_sac_lower_door"] thread _id_0F05::_id_E9A0();
  level._id_E99E["hubbow_to_sac_lower_door"] thread _id_0F05::_id_AED6(0);
  scripts\engine\utility::flag_set("recover_tech_end");
}

_id_3CCB() {
  level.player endon("death");
  var_0 = spawnStruct();
  var_0.origin = level._id_10FB1.origin;
  var_0.angles = level._id_10FB1.angles;
  var_1 = [];
  var_2 = scripts\sp\utility::_id_10639("player_arms");
  var_1[var_1.size] = var_2;
  var_2 hide();
  var_1[var_1.size] = level._id_10FB1;
  level._id_10FB1._id_1FBB = "chargeshot";
  level._id_10FB1 scripts\sp\anim::_id_F64A();
  var_0 scripts\sp\anim::_id_1EC1(var_1, "weapon_pickup");
  level._id_10FB1 waittill("trigger");
  var_3 = level.player getcurrentweapon();
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player _meth_80D1();
  level.player _meth_823C(var_2, "tag_player", 0.5, 0.25);
  wait 0.5;
  level.player takeweapon(var_3);
  level.player giveweapon("iw7_chargeshot+chargeshotscope");
  level.player setweaponammoclip("iw7_chargeshot+chargeshotscope", weaponclipsize("iw7_chargeshot"));
  var_2 show();
  var_0 thread scripts\sp\anim::_id_1F2C(var_1, "weapon_pickup");
  var_2 waittillmatch("single anim", "gun_up");
  level.player enableweapons();
  level.player switchtoweaponimmediate("iw7_chargeshot+chargeshotscope");
  level.player thread scripts\sp\utility::_id_1034D("vip_plr_looks_fun");
  var_2 waittillmatch("single anim", "end");
  level.player unlink();
  level._id_10FB1 delete();
  var_2 delete();
  level.player allowsprint(1);
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_80A1();
  scripts\engine\utility::flag_set("chargeshot_picked_up");
}

_id_DE03() {
  level.player endon("death");
  thread _id_691F();
  level endon("recover_tech_end");
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_allclearwereg");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_copyprepforci");
  scripts\sp\utility::_id_10350("sa_vips_ksh_hostagesaredown");

  if(isDefined(level._id_1342D)) {
    switch (level._id_1342D) {
      case 4:
        level.player _meth_84C7("saVIPHostagesState", "all");
        level.player scripts\sp\utility::_id_1034D("sa_vips_plr_fouralive");
        scripts\sp\utility::_id_10350("sa_vips_eth_outstandingcaptain");
        break;
      case 3:
        level.player _meth_84C7("saVIPHostagesState", "some");
        level.player scripts\sp\utility::_id_1034D("sa_vips_plr_threealive1kia");
        scripts\sp\utility::_id_10350("sa_vips_eth_welldonecaptain");
        break;
      case 2:
        level.player _meth_84C7("saVIPHostagesState", "some");
        level.player scripts\sp\utility::_id_1034D("sa_vips_plr_twosafe2kia");
        scripts\sp\utility::_id_10350("sa_vips_eth_understoodsir");
        break;
      case 1:
        level.player _meth_84C7("saVIPHostagesState", "some");
        level.player scripts\sp\utility::_id_1034D("sa_vips_plr_threeciviliansdown");
        scripts\sp\utility::_id_10350("sa_vips_eth_copysir");
        break;
      case 0:
        level.player _meth_84C7("saVIPHostagesState", "failed");
        level.player scripts\sp\utility::_id_1034D("sa_vips_plr_nosurvivors");
        scripts\sp\utility::_id_10350("sa_vips_eth_imsorrysir");
        break;
    }
  }

  scripts\engine\utility::flag_wait("cargo_bay_regroup");
  scripts\engine\utility::flag_set("salter_start_ready_to_recover_tech");
  scripts\engine\utility::flag_wait("salter_ready_to_recover_tech");
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_saltletsgogeto");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_copyonyou");
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_ethanweremoving");
  scripts\sp\utility::_id_10350("sa_vips_eth_ayesirillhaveyour");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_letsgetwhatwec");
  scripts\engine\utility::flag_set("initial_recover_tech_vo_done");
  scripts\engine\utility::flag_wait("recover_tech_hurry");
  scripts\engine\utility::flag_wait("vips_exfilled");

  if(level._id_1342D > 0) {
    if(level._id_1342D == 1) {
      scripts\sp\utility::_id_10350("sa_vips_brk_engineersecure");
    } else {
      scripts\sp\utility::_id_10350("sa_vips_brk_civilianssecure");
    }
  } else
    scripts\sp\utility::_id_10350("sa_vips_brk_bodiessecured");

  if(isDefined(level._id_B340)) {
    level._id_B340 delete();
  }

  if(isDefined(level._id_B341)) {
    level._id_B341 delete();
  }

  if(isDefined(level._id_1342C)) {
    foreach(var_1 in level._id_1342C) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }
  }

  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_rogerthatgoodwork");
  scripts\engine\utility::flag_wait("sa_armory_room_vol_cleared");
}

_id_691F() {
  setmusicstate("");
}

_id_6900() {
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_68FC();
}

_id_692A() {
  visionsetalternate(2, 0);
  _id_133E4();
  _id_B2C8();
  level.player _meth_84C7("lastShipcribMission", "shipcrib_titan");
  level.player _meth_84C7("lastCompletedMission", "shipcrib_titan");
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_68FD();
  thread _id_0F16::_id_8EA3();
  level thread _id_8E82();
  _id_0F0C::_id_E9AB("sa_armory_room_vol");
  _id_0F0C::_id_E9D1("sa_hangar_vol", "cleared");
  _id_0F0C::_id_E9D1("sac_bowupper_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_hubbow_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_armory_room_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_starboard_lower_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_starboard_lower_rooma_vol", "cleared");
  level thread _id_0F16::_id_991E(1);
  level thread _id_40AF();
  _id_0F16::_id_13351("vfx_vips_amb_armory", 1);
  _id_0F16::_id_13351("vfx_vips_amb_hub", 1);
  level._id_5A3E = 1;
  level.player _id_0F16::_id_FCF5();
  var_0 = getspawner("salter_exfil", "script_noteworthy");
  level._id_EA2C = var_0 scripts\sp\utility::_id_10619(1);
  level._id_EA2C scripts\sp\utility::_id_B14F(1);
  level._id_EA2C scripts\sp\utility::_id_F417(1);
  level._id_EA2C scripts\sp\utility::_id_F2D8(10);
  level._id_EA2C._id_1FBB = "salter";
  level._id_EA2C scripts\sp\utility::_id_F3B5("r");
  level._id_EA2C scripts\sp\utility::_id_61C7();
  level._id_EA2C thread scripts\sp\utility::_id_F2DA(1);
  level._id_EA2C thread _id_0F16::isfirstarmageddonmeteorhit("iw7_m4+silencer", "primary", "iw7_m8");
  level._id_DBBE = getEntArray("missile_racks", "targetname");
  scripts\engine\utility::array_thread(level._id_DBBE, _id_0EFC::_id_F9D7);
  level._id_E99E["breach_room_exit_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["hubbow_to_sac_lower_door"] _id_0F05::_id_AED6(0);
  thread _id_0F16::_id_3E3E("exfil_start_point");
  wait 0.05;
  level thread _id_0F27::_id_558C();
  wait 0.2;
  var_1 = level.player getcurrentweapon();
  level.player takeweapon(var_1);
  level.player giveweapon("iw7_chargeshot+chargeshotscope");
  level.player switchtoweapon("iw7_chargeshot+chargeshotscope");
  level.player setweaponammoclip("iw7_chargeshot+chargeshotscope", weaponclipsize("iw7_chargeshot"));
  var_2 = getEnt("stolen_tech", "targetname");

  if(isDefined(var_2)) {
    var_2 delete();
  }

  level._id_E99E["armory_loot_room_door_01"]._id_72D1 = 1;
  level._id_E99E["armory_loot_room_door_01"] _id_0F05::_id_12BD3();
  level._id_E99E["cargo_bay_to_sac_lower_door"] _id_0F05::_id_AED6(0);
  thread _id_104CE();
  scripts\engine\utility::waitframe();
  level notify("cargobay_regroup_ammo_crate");
}

_id_68ED() {
  scripts\engine\utility::flag_set("exfil_begin");
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  level thread _id_100EF();
  level thread _id_8E99();
  level._id_E99E["armory_door_upper_01"] _id_0F05::_id_AED6(0);
  level._id_E99E["armory_door_upper_02"] _id_0F05::_id_AED6(0);
  level._id_E99E["armory_to_hallway_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["hallway_to_mess_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["cargo_bay_to_sac_lower_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["hubbow_to_sac_upper_door"] _id_0F05::_id_AED6(0);
  level thread _id_0F16::_id_1DEA("ambient_ship_moment_exfil", "exfil_end");
  level thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_68FB();
  level thread _id_6934();
  level thread _id_6921();
  level thread _id_5987("armory_door_close", "armory_door_close_check", "armory_to_hallway_door", "sa_vips_armory_tr", "sa_vips_hubbow_tr");
  scripts\sp\utility::_id_12643(["sa_vips_exfil_tr", "sa_vips_playerjackal_tr", "sa_vips_spacemisc_tr"]);
  var_0 = getEnt("armory_door_close_check", "targetname");

  for(;;) {
    if(level.player istouching(var_0) && level._id_EA2C istouching(var_0)) {
      level._id_E99E["armory_to_hallway_door"] thread _id_0F05::_id_E9A0();
      level._id_E99E["armory_to_hallway_door"] thread _id_0F05::_id_AED6(0);
      wait 0.5;

      if(isDefined(level._id_DBBE)) {
        foreach(var_2 in level._id_DBBE) {
          var_2 _id_0EFC::_id_B892();
        }
      }

      scripts\sp\utility::_id_12651(["sa_vips_armory_tr", "sa_vips_hubbow_tr", "sa_vips_prime_tr"]);
      break;
    }

    wait 0.05;
  }

  wait 1.0;
  level notify("armory_ammo_crates");
  _id_0BDB::spawn_jackal_mip_buffer("veh_mil_air_un_jackal_02_player");
  level thread scripts\sp\utility::_id_BF97();
  scripts\engine\utility::flag_wait("enable_exfil_airlock_setup");
  _id_133E2();
  level thread _id_68F9();

  if(!scripts\sp\utility::_id_93A6()) {
    _id_0E4B::_id_8E0A();
  }

  level.player _id_0F16::_id_FD0C();
  level waittill("player_used_jackal");
  level._id_D127 unlink();
  level._id_C267 notify("stop_exfil_loop");
  scripts\engine\utility::flag_wait("player_in_jackal");

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F530(1);
  }

  scripts\engine\utility::flag_set("exfil_end");
  level waittill("infinity");
}

_id_6934() {
  level.player endon("death");
  level.player scripts\sp\utility::_id_1034D("vip_plr_exfil_point");
  scripts\sp\utility::_id_10350("vip_eth_jackal_waiting");
  scripts\engine\utility::flag_wait("enable_exfil_airlock_setup");
  scripts\sp\utility::_id_10350("sa_vips_eth_jackalisinposition");
  setmusicstate("");
  scripts\engine\utility::flag_wait("infiltrate_door_opened");
  level thread cleanup_axis_jackals_when_player_jackal_used();
  wait 4.0;
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_ridingbackwithyou");
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_backseatdriver");
  scripts\engine\utility::flag_wait("player_in_jackal");
  wait 1.0;
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_flybetterthanshoot");

  if(isDefined(level._id_EA2C)) {
    level._id_EA2C delete();
  }

  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_justholdon");
  level.player thread scripts\sp\utility::_id_1034D("sa_vips_plr_letsgohome");
  level scripts\engine\utility::delaythread(2.7, _id_0BDC::_id_A226);
  thread scripts\sp\hud_util::_id_6AA3(3, "black");
  wait 3;

  if(isDefined(level._id_3965)) {
    level._id_3965 _id_0BB6::_id_39E1();
    level._id_3965 _id_0BB8::_id_39C5();

    if(isDefined(level._id_3965._id_4074)) {
      foreach(var_1 in level._id_3965._id_4074) {
        if(isDefined(var_1)) {
          var_1 delete();
        }
      }

      level._id_118A8._id_4074 = [];
    }

    level._id_3965 delete();
  }

  scripts\sp\utility::_id_228A(level._id_1D0A._id_FE2D);
  wait 0.05;
  thread scripts\sp\utility::_id_BF95();
}

cleanup_axis_jackals_when_player_jackal_used() {
  level._id_D127 waittill("trigger");
  level notify("stop_ambient_jackals");
  wait 0.5;
  scripts\sp\utility::_id_228A(level._id_26EB._id_FE2D);
}

#using_animtree("jackal");

_id_68F9() {
  level._id_C267 = scripts\engine\utility::getStruct("obj_exfil_org", "targetname");
  var_0 = [];
  var_1 = scripts\sp\utility::_id_10639("fake_jackal");
  var_1 hide();
  var_0[var_0.size] = var_1;
  level._id_C0B7 = 1;
  thread _id_0F16::_id_D154("player_jackal");
  wait 0.1;
  level._id_D127 thread _id_0BDC::_id_A07D();
  level._id_D127 linkTo(var_1, "tag_origin", (0, 0, 0), (0, 0, 0));
  level._id_D127 _id_0BDC::_id_F420(500, 135, 30, 1, 1);
  _id_0BDC::_id_A156(1);
  level._id_D127 _id_0BDC::_id_104A6(0);
  level._id_D127 _meth_849F(1);
  level._id_D127 _id_0BDC::_id_A2DE(1);
  scripts\sp\utility::_id_241F(0);
  level._id_D127 _id_0BDC::_id_6B4C("hover", 1);
  level._id_C267 scripts\sp\anim::_id_1EC1(var_0, "exfil");
  scripts\engine\utility::flag_wait("infiltrate_door_opened");
  var_0[var_0.size] = level._id_EA2C;
  level._id_C267 thread scripts\sp\anim::_id_1F2C(var_0, "exfil");
  wait 3.0;
  level._id_D127 setanimknob(%jackal_vehicle_space_assault_to_mount, 1.0, 2.0);
  level._id_D127 _id_0BDC::_id_104A6(1);
  level._id_D127 endon("trigger");
  var_1 waittillmatch("single anim", "end");
  level._id_C267 scripts\sp\anim::_id_1EE7(var_0, "exfil_loop", "stop_exfil_loop");
}

_id_6907() {
  if(scripts\sp\utility::hastag(self.model, "tag_screen_locked")) {
    self showpart("tag_screen_locked", self.model);
  }

  if(scripts\sp\utility::hastag(self.model, "tag_screen_open")) {
    self hidepart("tag_screen_open", self.model);
  }

  scripts\engine\utility::flag_wait("enable_exfil_airlock_setup");

  if(scripts\sp\utility::hastag(self.model, "tag_screen_locked")) {
    self hidepart("tag_screen_locked", self.model);
  }

  if(scripts\sp\utility::hastag(self.model, "tag_screen_open")) {
    self showpart("tag_screen_open", self.model);
  }

  scripts\engine\utility::flag_wait("exfil_airlock_setup");
  self._id_1FBB = "sdf_door_airlock_01";
  self _meth_83D0(level._id_EC87["sdf_door_airlock_01"]);
  var_0 = scripts\engine\utility::getStruct("obj_exfil_org", "targetname");
  var_1 = [];
  var_2 = scripts\sp\utility::_id_10639("player_arms");
  var_2 hide();
  var_1[var_1.size] = var_2;
  var_1[var_1.size] = self;
  var_0 scripts\sp\anim::_id_1EC1(var_1, "exfil_door_interior");
  _id_0E46::_id_48C4("tag_ui_back");
  self waittill("trigger");
  level notify("starboardlower_ammo_crate");
  level thread _id_7264();
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_68EE();
  level thread scripts\sp\utility::_id_12651(["sa_vips_interior_tr", "sa_vips_messhall_tr", "sa_vips_starboardlower_tr"]);
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player _meth_80D1();
  var_3 = 0.5;
  level.player _meth_823C(var_2, "tag_player", var_3, var_3 * 0.5, 0.0);
  wait(var_3);
  var_2 show();
  var_0 thread scripts\sp\anim::_id_1F2C(var_1, "exfil_door_interior");
  var_2 waittillmatch("single anim", "gun_up");

  if(scripts\sp\utility::hastag(self.model, "tag_screen_locked")) {
    self showpart("tag_screen_locked", self.model);
  }

  if(scripts\sp\utility::hastag(self.model, "tag_screen_open")) {
    self hidepart("tag_screen_open", self.model);
  }

  level.player enableweapons();
  var_2 waittillmatch("single anim", "end");
  var_4 = getaiarray("axis");
  scripts\sp\utility::_id_228A(var_4);
  level notify("end_pa_group");

  if(isDefined(level._id_EA2C)) {
    level._id_EA2C delete();
  }

  var_5 = getspawner("salter_exfil_zerog", "script_noteworthy");
  level._id_EA2C = var_5 scripts\sp\utility::_id_10619(1);
  level._id_EA2C scripts\sp\utility::_id_B14F(1);
  level._id_EA2C scripts\sp\utility::_id_F417(1);
  level._id_EA2C scripts\sp\utility::_id_F2D8(10);
  level._id_EA2C._id_1FBB = "salter";
  level._id_EA2C thread scripts\sp\utility::_id_F2DA(1);
  level._id_EA2C scripts\sp\utility::_id_F415(1);
  level._id_EA2C scripts\sp\utility::_id_F416(1);
  level._id_EA2C scripts\sp\utility::_id_F39F();
  level._id_EA2C._id_B3E9 = 1;
  var_6 = getnode("salter_exit_airlock_node_01", "targetname");

  if(isDefined(var_6)) {
    level._id_EA2C scripts\sp\utility::_id_1160F(var_6);
  }

  var_7 = getnode("salter_exit_airlock_node_02", "targetname");

  if(isDefined(var_7)) {
    level._id_EA2C _meth_82EE(var_7);
  }

  scripts\engine\utility::exploder("vfx_airlock_depress");
  thread _id_0F05::_id_10B65(1);
  level.player unlink();
  var_2 delete();
  level.player allowsprint(1);
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_80A1();
}

_id_6906() {
  if(scripts\sp\utility::hastag(self.model, "tag_screen_locked")) {
    self showpart("tag_screen_locked", self.model);
  }

  if(scripts\sp\utility::hastag(self.model, "tag_unlocked")) {
    self hidepart("tag_unlocked", self.model);
  }

  scripts\engine\utility::flag_wait("exfil_airlock_setup");
  setglobalsoundcontext("atmosphere", "space", 6.1);
  self._id_1FBB = "sdf_door_airlock_01";
  self _meth_83D0(level._id_EC87["sdf_door_airlock_01"]);
  var_0 = scripts\engine\utility::getStruct("obj_exfil_org", "targetname");
  var_1 = [];
  var_2 = scripts\sp\utility::_id_10639("player_arms");
  var_2 hide();
  var_1[var_1.size] = var_2;
  var_1[var_1.size] = self;
  var_0 scripts\sp\anim::_id_1EC1(var_1, "exfil_door_exterior");
  level waittill("airlock_depressurize_complete");

  if(scripts\sp\utility::hastag(self.model, "tag_screen_locked")) {
    self hidepart("tag_screen_locked", self.model);
  }

  if(scripts\sp\utility::hastag(self.model, "tag_screen_open")) {
    self showpart("tag_screen_open", self.model);
  }

  _id_0E46::_id_48C4("tag_ui_front");
  self waittill("trigger");
  level thread _id_A127();
  level thread _id_100DC();
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_68EF();
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player _meth_80D1();
  var_3 = 0.5;
  level.player _meth_823C(var_2, "tag_player", var_3, var_3 * 0.5, 0.0);
  wait(var_3);
  var_2 show();
  scripts\engine\utility::flag_set("infiltrate_door_opened");
  var_0 thread scripts\sp\anim::_id_1F2C(var_1, "exfil_door_exterior");
  var_2 waittillmatch("single anim", "gun_up");

  if(scripts\sp\utility::hastag(self.model, "tag_screen_locked")) {
    self showpart("tag_screen_locked", self.model);
  }

  if(scripts\sp\utility::hastag(self.model, "tag_screen_open")) {
    self hidepart("tag_screen_open", self.model);
  }

  level.player enableweapons();
  var_2 waittillmatch("single anim", "end");
  level.player unlink();
  var_2 delete();
  level.player allowsprint(1);
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_80A1();
  _id_0F35::_id_FB26(0, 1);
  _id_0F35::_id_FB25(1, 1);
  _id_0F31::_id_E0C8();
  _id_0F31::_id_E0CE();
  _id_0F31::_id_E0CD();
  scripts\engine\utility::trigger_off("player_in_gravity_trigger", "targetname");
}

_id_13E7A() {
  wait 0.5;
  _id_1723("obj_board_ship", "current", &"SA_VIPS_OBJ_BOARD_SHIP");
  _id_2FB0("obj_secure_vips_breadcrumb_start", "obj_board_ship", "zerog_enemies_spawn", 1);
}

_id_949F() {
  _id_1723("obj_board_ship", "current", &"SA_VIPS_OBJ_BOARD_SHIP");
  level waittill("breach_entered");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_board_ship"));
  scripts\engine\utility::flag_wait("breach_room_vo_done");
  _id_1723("obj_secure_vips", "current", &"SA_VIPS_OBJ_SECURE_VIPS");
  var_0 = scripts\engine\utility::getStruct("breach_room_exit_door_close_org", "targetname");
  _id_12DFB("obj_secure_vips", var_0.origin);
  level waittill("breach_room_exit_door_close_triggered");
  _id_12DFB("obj_secure_vips", (0, 0, 0));
}

_id_87DD() {
  wait 0.5;
  _id_1723("obj_secure_vips", "current", &"SA_VIPS_OBJ_SECURE_VIPS");
  var_0 = scripts\engine\utility::getStruct("obj_secure_vips_org", "targetname");
  wait 1.0;
  thread _id_0F16::_id_2635(var_0, &"SA_VIPS_SECURE", "interior_begin");
}

_id_9A70() {
  wait 0.5;
  _id_1723("obj_secure_vips", "current", &"SA_VIPS_OBJ_SECURE_VIPS");
  var_0 = scripts\engine\utility::getStruct("obj_secure_vips_org", "targetname");
  wait 1.0;
  thread _id_0F16::_id_2635(var_0, &"SA_VIPS_SECURE", "cargo_bay_start");
}

_id_3A67() {
  wait 0.5;
  _id_1723("obj_secure_vips", "current", &"SA_VIPS_OBJ_SECURE_VIPS");
  objective_string(scripts\sp\utility::_id_C264("obj_secure_vips"), &"SA_VIPS_CLEAR_THE_CARGO_BAY");
  level._id_C816 = 1;
  var_0 = scripts\engine\utility::getStruct("obj_secure_vips_org", "targetname");
  wait 1.0;
  thread _id_0F16::_id_2635(var_0, undefined);
  wait 0.05;
  scripts\engine\utility::flag_wait("sa_hangar_vol_cleared");
  objective_string(scripts\sp\utility::_id_C264("obj_secure_vips"), &"SA_VIPS_OBJ_SECURE_VIPS");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_secure_vips"));
}

_id_DE01() {
  level._id_C816 = undefined;
  _id_0F16::_id_2638(1);
  wait 0.5;
  level._id_E99E["armory_loot_room_door_01"].collision disconnectPaths();
  _id_1723("obj_recover_tech", "current", &"SA_VIPS_OBJ_RECOVER_TECH");
  var_0 = scripts\engine\utility::getStruct("obj_secure_vips_org", "targetname");
  level thread _id_0F16::_id_2635(var_0, undefined, "cargo_bay_regroup");
  _id_0F16::_id_2638(1);
  _id_0F16::_id_2637(&"SA_VIPS_REGROUP");
  scripts\engine\utility::flag_wait("cargo_bay_regroup");
  level thread scripts\sp\utility::_id_1264E("sa_vips_bowupper_tr");
  level thread scripts\sp\utility::_id_12643(["sa_vips_bowlower_tr", "sa_vips_hubbow_tr", "sa_vips_armory_tr"]);
  _id_0F16::_id_2638(0);
  level._id_E99E["cargo_bay_door_01"] _id_0F05::_id_AED6(0);
  level._id_E99E["armory_to_hallway_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["hallway_to_mess_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["cargo_bay_to_sac_lower_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["hubbow_to_sac_upper_door"] _id_0F05::_id_AED6(0);
  level._id_E99E["armory_door_upper_01"] _id_0F05::_id_12BD3(0);
  level._id_E99E["armory_door_upper_02"] _id_0F05::_id_12BD3(0);
  level._id_E99E["hubbow_to_lower_armory_door"] _id_0F05::_id_12BD3(0);
  level._id_E99E["hubbow_to_sac_lower_door"] _id_0F05::_id_12BD3(0);
  level._id_E99E["hubbow_to_sac_lower_door"]._id_C611 = 1;
  level thread _id_DE21();
  level thread _id_1CD4();
  scripts\sp\utility::_id_22CA("ambient_lower_combat_guys", ::_id_F8B9, "cargobay_regrouped", "spawn_lower_corridor_guys_02", 1, "hubbow_runners_02_gv");
  var_1 = scripts\sp\utility::_id_22CD("ambient_lower_combat_guys");
  level thread _id_BC35();
  scripts\engine\utility::flag_wait("salter_ready_to_recover_tech");
  level._id_EA2C scripts\sp\utility::_id_F39E();
  level._id_EA2C scripts\sp\utility::_id_12BFA();
  level._id_EA2C scripts\sp\utility::_id_F3B5("r");
  level._id_EA2C scripts\sp\utility::_id_61C7();
  level._id_EA2C.ignoreall = 1;
  objective_onentity(scripts\sp\utility::_id_C264("obj_recover_tech"), level._id_EA2C, (0, 0, 60));
  level thread _id_DE00();
  level thread scripts\sp\utility::_id_2679();
  level thread _id_3A90();
  wait 1.0;
  scripts\engine\utility::flag_wait("cargobay_regrouped");
  level._id_EA2C thread scripts\sp\utility::_id_F2DA(1);
  level._id_EA2C _id_0C4C::_id_1960("move_up");
  level._id_EA2C.ignoreall = 0;
  scripts\sp\utility::_id_15F5("salter_go_to_r2");
  level thread _id_13755(var_1, 3, "spawn_lower_corridor_guys_02");
  scripts\engine\utility::flag_wait_either("spawn_lower_corridor_guys_02", "ambient_lower_combat_guys_dead");
  scripts\sp\utility::_id_15F5("salter_go_to_r3");
  _id_E0EA(var_1, "hubbow_runners_02_gv", 1);
  var_2 = scripts\sp\utility::_id_22CD("lower_corridor_guys_02");
  level thread _id_13755(var_2, 2, "spawn_hubbow_runners_01");
  scripts\engine\utility::flag_wait_either("spawn_hubbow_runners_01", "lower_corridor_guys_02_dead");
  level thread scripts\sp\utility::_id_2679();
  _id_E0EA(var_2, "hubbow_runners_02_gv", 1);
  scripts\engine\utility::flag_wait_all("lower_cargobay_door_close", "unload_cargobay_transient");
  var_3 = scripts\sp\utility::_id_22CD("hubbow_runners_02");
  _id_E0EA(var_2, "hubbow_runners_02_gv", 1);
  _id_E0EA(var_1, "hubbow_runners_03_gv", 1);
  scripts\sp\utility::_id_15F5("salter_go_to_r4");
  scripts\sp\utility::_id_15F5("redshirt_move_1");
  level thread _id_13755(var_3, 2, "spawn_hubbow_runners_03");
  scripts\engine\utility::flag_wait_either("spawn_hubbow_runners_03", "hubbow_runners_02_dead");
  level thread scripts\sp\utility::_id_2679();
  scripts\engine\utility::flag_set("start_missile_racks");
  thread _id_1063D();
  scripts\sp\utility::_id_15F5("salter_go_to_r5");
  scripts\sp\utility::_id_15F5("redshirt_move_2");
  _id_E0EA(var_3, "hubbow_runners_03_gv", 1);
  _id_E0EA(var_2, "hubbow_runners_03_gv", 1);
  _id_E0EA(var_1, "hubbow_runners_03_gv", 1);
  var_4 = getaiarray("axis");

  if(!scripts\engine\utility::flag("spawn_armory_guys_01") && var_4.size >= 3) {
    level thread _id_13755(var_4, 2, "spawn_armory_guys_01");
  }

  _id_E0EA(var_4, "armory_guys_01_gv", 1);
  scripts\sp\utility::_id_15F5("salter_go_to_r6");
  scripts\engine\utility::flag_wait("spawn_armory_guys_01");
  level thread scripts\sp\utility::_id_2679();
  level thread _id_106F8();
  level thread _id_106F9();
  level thread _id_10806();
  level thread _id_10807();
  var_4 = [];
  var_5 = scripts\sp\utility::_id_22CD("armory_guys_01");
  var_6 = scripts\sp\utility::_id_22CD("armory_guys_02");
  var_4 = scripts\engine\utility::array_combine(var_5, var_6);
  level thread _id_13755(var_4, 4, "spawn_armory_guys_03");
  scripts\engine\utility::flag_wait("spawn_armory_guys_03");
  level thread scripts\sp\utility::_id_2679();
  var_7 = scripts\sp\utility::_id_22CD("armory_guys_03");
  var_4 = scripts\engine\utility::array_combine(var_4, var_7);
  level notify("retreat_upper_armory_enemies");
  level thread _id_13755(var_4, 5, "spawn_armory_guys_04");
  scripts\sp\utility::_id_15F5("salter_go_to_r7");
  scripts\sp\utility::_id_15F5("redshirt_move_3");
  scripts\engine\utility::flag_wait("spawn_armory_guys_04");
  level thread scripts\sp\utility::_id_2679();
  _id_E0EA(var_4, "armory_guys_04_gv", 1);
  level thread _id_13755(var_4, 4, "spawn_armory_guys_05_06");
  scripts\engine\utility::flag_wait("spawn_armory_guys_05_06");
  level notify("armory_guys_05_06_spawned");
  level thread scripts\sp\utility::_id_2679();
  _id_E0EA(var_4, "armory_guys_05_gv", 1);
  var_8 = scripts\sp\utility::_id_22CD("armory_guys_05");
  var_4 = scripts\engine\utility::array_combine(var_4, var_8);
  var_9 = scripts\sp\utility::_id_22CD("armory_guys_06");
  var_4 = scripts\engine\utility::array_combine(var_4, var_9);
  scripts\sp\utility::_id_15F5("salter_go_to_r8");
  scripts\sp\utility::_id_15F5("redshirt_move_4");
  level thread _id_13755(var_4, 4, "armory_combat_end");
  scripts\engine\utility::flag_set("armory_combat_final_wave");
  scripts\engine\utility::flag_wait_all("armory_combat_end", "armory_c8_01_dead");
  level thread scripts\sp\utility::_id_2679();
  var_4 = scripts\sp\utility::array_removedeadvehicles(var_4);

  if(var_4.size >= 3) {
    scripts\sp\utility::_id_13754(var_4, var_4.size - 2);
  }

  var_4 = scripts\sp\utility::array_removedeadvehicles(var_4);
  scripts\engine\utility::array_thread(var_4, ::_id_E357, "armory_spawn_closet_retreat_origins");
  scripts\sp\utility::_id_15F5("salter_go_to_r9");
  scripts\sp\utility::_id_15F5("redshirt_move_5");
  level._id_E99E["armory_loot_room_door_01"]._id_4D94._id_885A = 3;
  level thread _id_21D3();
  scripts\engine\utility::flag_set("enable_armory_loot_room_door_01");
  objective_position(scripts\sp\utility::_id_C264("obj_recover_tech"), (0, 0, 0));
  wait 0.05;
  level thread _id_0F16::_id_2635(level._id_E99E["armory_loot_room_door_01"]._id_32D9, undefined, "armory_loot_door_hacked");
  _id_0F16::_id_2638(1);
  level waittill("armory_loot_door_hacked");
  scripts\engine\utility::flag_set("armory_loot_door_hacked");
  level thread _id_0F16::_id_2635(level._id_E99E["armory_loot_room_door_01"]._id_9026, undefined, "armory_loot_door_opened");
  _id_0F16::_id_2638(1);
  level waittill("armory_door_start_open");
  level thread scripts\sp\utility::_id_2679();
  scripts\engine\utility::flag_set("armory_loot_door_opened");
  level thread _id_6A5E();

  for(;;) {
    if(scripts\engine\utility::is_true(level._id_E99E["armory_loot_room_door_01"]._id_C5D9)) {
      break;
    } else
      wait 0.05;
  }

  scripts\engine\utility::flag_set("armory_loot_door_fully_opened");
  level thread _id_0F16::_id_2635(level._id_10FB1, undefined, "tech_recovered");
  _id_0F16::_id_2638(1);
  scripts\sp\utility::_id_15F5("salter_go_to_r10");
  scripts\engine\utility::flag_wait("chargeshot_picked_up");
  scripts\engine\utility::flag_set("tech_recovered");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_recover_tech"));
  scripts\sp\utility::_id_266F();
}

_id_6A5E() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("armory_loot_door_fully_opened");
  thread vips_exfil_music();
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_jackpoteyeson");
}

vips_exfil_music() {
  wait 6;
  setmusicstate("mx_402_savips_exfil");
}

_id_21D3() {
  level.player endon("death");
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_clear");
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_ethanwereathear");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_packageisbehind");
  scripts\sp\utility::_id_10350("sa_vips_eth_proximityhacksho");
  level.player thread scripts\sp\utility::_id_1034D("sa_vips_plr_copy2");
}

_id_106F8() {
  scripts\engine\utility::flag_wait("spawn_flank_armory_enemies_01");
  var_0 = scripts\sp\utility::_id_22CD("armory_flank_enemies_01", 1);
  level waittill("retreat_armory_flank_enemies");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);
  scripts\engine\utility::array_thread(var_0, ::_id_E357, "armory_spawn_closet_retreat_origins");
}

_id_106F9() {
  scripts\engine\utility::flag_wait("spawn_flank_armory_enemies_02");
  var_0 = scripts\sp\utility::_id_22CD("armory_flank_enemies_02", 1);
  level waittill("retreat_armory_flank_enemies");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);
  scripts\engine\utility::array_thread(var_0, ::_id_E357, "armory_spawn_closet_retreat_origins");
}

_id_10806() {
  scripts\engine\utility::flag_wait("spawn_upper_armory_path_1");
  var_0 = scripts\sp\utility::_id_22CD("armory_upper_01", 1);
  level waittill("retreat_upper_armory_enemies");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);
  scripts\engine\utility::array_thread(var_0, ::_id_E357, "armory_spawn_closet_retreat_origins");
}

_id_10807() {
  scripts\engine\utility::flag_wait("spawn_upper_armory_path_2");
  var_0 = scripts\sp\utility::_id_22CD("armory_upper_02", 1);
  level waittill("retreat_upper_armory_enemies");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);
  scripts\engine\utility::array_thread(var_0, ::_id_E357, "armory_spawn_closet_retreat_origins");
}

_id_1063D() {
  level endon("death");
  level._id_21C2 = scripts\sp\utility::_id_107EA("armory_c8_01", 1);
  level._id_21C2 endon("death");
  level._id_21C2.ignoreall = 1;
  level._id_21C2._id_1FBB = "c8";
  level._id_21C2 thread _id_3441();
  level._id_21C2 scripts\sp\anim::_id_1EC3(level._id_21C2, "c8_startup");
  scripts\engine\utility::flag_wait_either("spawn_armory_guys_05_06", "c8_took_damage");
  level._id_21C2 scripts\sp\anim::_id_1F35(level._id_21C2, "c8_startup");
  wait 1;
  var_0 = getnode("armory_c8_01_pos", "targetname");
  level._id_21C2 _meth_82EE(var_0);
  var_1 = getEnt("armory_guys_04_gv", "targetname");
  wait 2;
  level._id_21C2.ignoreall = 0;

  if(isDefined(level._id_21C2) && isalive(level._id_21C2)) {
    level._id_21C2 _meth_82F1(var_1);
  }

  scripts\engine\utility::flag_wait("armory_combat_final_wave");
  wait 90;

  if(isDefined(level._id_21C2) && isalive(level._id_21C2)) {
    if(level._id_21C2.health >= 100) {
      level._id_21C2.health = 100;
    }
  }
}

_id_3441() {
  self waittill("damage");
  scripts\engine\utility::flag_set("c8_took_damage");
}

_id_DE21() {
  var_0 = scripts\sp\utility::_id_107EA("ally_redshirt_01", "targetname");
  var_0 thread _id_DE25();
  var_1 = scripts\sp\utility::_id_107EA("ally_redshirt_02", "targetname");
  var_1 thread _id_DE28();
  var_2 = scripts\sp\utility::_id_107EA("ally_redshirt_03", "targetname");
}

_id_DE28() {
  self endon("death");
  self.accuracy = 0.05;
  self._id_1FBB = "redshirt_radio";
  thread scripts\sp\utility::_id_F2DA(1);
  thread scripts\sp\anim::_id_1EEA(self, "redshirt_radio_idle");
  scripts\engine\utility::flag_wait("cargobay_regrouped");
  wait 0.5;
  scripts\sp\utility::anim_stopanimScripted();
  wait 0.5;
  var_0 = getnode(self.target, "targetname");
  self _meth_82EE(var_0);
}

_id_DE25() {
  self endon("death");
  self.accuracy = 0.05;
  scripts\sp\utility::_id_B14F();
  thread scripts\sp\utility::_id_F2DA(1);
  var_0 = getEnt("ambient_combat_attackstart_1", "targetname");
  var_1 = self.origin;
  scripts\engine\utility::flag_wait("spawn_lower_corridor_guys_01");
  var_2 = _id_0E26::_id_107D2(self.origin, self.angles, "allies");
  var_2.moveplaybackrate = 1.2;
  var_2.ignoreme = 1;
  scripts\engine\utility::flag_wait("redshirt_death_start");
  scripts\sp\utility::_id_414F();
  scripts\engine\utility::waitframe();
  var_3 = getnode("ally_hallway_death_node", "targetname");
  self _meth_82EE(var_3);
  scripts\sp\utility::_id_F417(1);
  scripts\sp\utility::_id_1101B();
  scripts\engine\utility::waitframe();
  self.health = 5;
  wait 2;

  if(isDefined(self) && isalive(self)) {
    magicbullet("iw7_m4", var_0.origin, var_1);
    bullettracer(var_0.origin, var_1, "iw7_m4", 1);
  }

  wait 8;

  if(isDefined(self) && isalive(self)) {
    scripts\sp\utility::_id_F3B5("b");
  }
}

_id_1CD4() {
  var_0 = scripts\engine\utility::getStruct("hallway_drag_body", "targetname");
  var_1 = [];
  var_2 = scripts\sp\utility::_id_107EA("ally_redshirt_01_carry_a", "targetname");
  var_2 scripts\sp\utility::_id_86E4();
  var_2._id_1FBB = "carry_man_a";
  var_2 scripts\sp\utility::_id_B14F();
  var_2.ignoreme = 1;
  var_3 = scripts\sp\utility::_id_107EA("ally_redshirt_01_carry_b", "targetname");
  var_3 scripts\sp\utility::_id_86E4();
  var_3._id_1FBB = "carry_man_b";
  var_3 scripts\sp\utility::_id_B14F();
  var_3.ignoreme = 1;
  var_1 = scripts\engine\utility::array_add(var_1, var_2);
  var_1 = scripts\engine\utility::array_add(var_1, var_3);
  scripts\engine\utility::flag_wait("cargobay_regrouped");
  var_0 scripts\sp\anim::_id_1F2C(var_1, "fireman_carry");
  var_0 thread scripts\sp\anim::_id_1EE7(var_1, "fireman_carry_idle", "stop_carry_loop");
  scripts\engine\utility::flag_wait("lower_cargobay_door_close");
  scripts\engine\utility::waitframe();
  var_0 notify("stop_carry_loop");

  if(isDefined(var_2) && isalive(var_2)) {
    var_2 scripts\sp\utility::anim_stopanimScripted();
    scripts\engine\utility::waitframe();
    var_2 scripts\sp\utility::_id_1101B();
    var_2 delete();
  }

  if(isDefined(var_3) && isalive(var_3)) {
    var_3 scripts\sp\utility::anim_stopanimScripted();
    scripts\engine\utility::waitframe();
    var_3 scripts\sp\utility::_id_1101B();
    var_3 delete();
  }
}

_id_F8B9(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = getnode(self.target, "targetname");
  self _meth_82EE(var_4);
  scripts\sp\utility::_id_F39F();
  var_5 = getEnt(var_3, "targetname");
  scripts\sp\utility::_id_B14F();
  scripts\engine\utility::flag_wait(var_0);
  scripts\sp\utility::_id_1101B();
  scripts\engine\utility::flag_wait(var_1);

  if(isDefined(self) && isalive(self)) {
    wait(var_2);
    scripts\sp\utility::_id_F39E();
    scripts\engine\utility::waitframe();
    self.pathrandompercent = randomintrange(90, 100);
    self _meth_82F1(var_5);
  }
}

_id_BC35() {
  var_0 = getEnt("hallway_bulletshield", "targetname");
  var_0 movey(-304, 0.5);
  scripts\engine\utility::flag_wait("cargobay_regrouped");
  var_0 delete();
}

_id_DE00() {
  scripts\engine\utility::flag_wait("spawn_lower_corridor_guys_01");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_targetsdownfront");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_dropem");
  scripts\engine\utility::flag_wait("spawn_hubbow_runners_01");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_forceupwerealm");
}

_id_6921() {
  level thread _id_6901();
  wait 0.5;
  _id_1723("obj_exfil", "current", &"SA_VIPS_OBJ_EXFIL");
  var_0 = scripts\engine\utility::getStruct("obj_exfil_org", "targetname");
  wait 1.0;
  scripts\sp\utility::_id_15F5("salter_go_to_r11");
  scripts\engine\utility::flag_wait("exfil_combat_start");
  var_1 = [];
  var_2 = scripts\sp\utility::_id_22CD("exfil_armory_enemies_01");
  var_3 = scripts\sp\utility::_id_22CD("exfil_armory_upper_enemies_01");
  var_1 = scripts\engine\utility::array_combine(var_2, var_3);
  level thread _id_13755(var_1, 5, "spawn_exfil_armory_enemies_02");
  scripts\engine\utility::flag_wait_either("spawn_exfil_armory_enemies_02", "exfil_armory_enemies_01_dead");
  level thread scripts\sp\utility::_id_2679();
  scripts\sp\utility::_id_15F5("salter_go_to_r12");
  scripts\sp\utility::_id_15F5("redshirt_move_6");
  _id_E0EA(var_2, "exfil_armory_enemies_02_gv");
  var_4 = scripts\sp\utility::_id_22CD("exfil_armory_enemies_02");
  var_1 = scripts\engine\utility::array_combine(var_1, var_4);
  scripts\sp\utility::_id_15F5("salter_go_to_r13");
  var_5 = scripts\sp\utility::_id_107EA("exfil_c8_01", 1);
  var_6 = getnode(var_5.target, "targetname");
  var_5 _meth_82EE(var_6);
  thread _id_1D0C();
  _id_E0EA(var_3, "exfil_armory_enemies_02_gv");
  scripts\engine\utility::flag_wait("exfil_c8_01_dead");
  level thread scripts\sp\utility::_id_2679();
  var_1 = getaiarray("axis");
  scripts\engine\utility::array_thread(var_1, ::_id_E357, "armory_spawn_closet_retreat_origins");

  while(!istransientloaded("sa_vips_starboardlower_tr") || !istransientloaded("sa_vips_messhall_tr")) {
    wait 0.05;
    waitforalltransients();
  }

  level._id_E99E["armory_to_hallway_door"] _id_0F05::_id_12BD3(0);
  level._id_E99E["hallway_to_mess_door"] _id_0F05::_id_12BD3(0);
  level thread _id_0F16::_id_2635(var_0, undefined, "exfil_airlock_setup");
  scripts\sp\utility::_id_15F5("salter_go_to_r16");
  var_7 = [];
  scripts\engine\utility::flag_wait("spawn_exfil_hallway_guys");
  var_8 = scripts\sp\utility::_id_22CD("exfil_hallway_enemies_01");

  foreach(var_10 in var_8) {
    var_7 = scripts\engine\utility::array_add(var_7, var_10);
  }

  level thread scripts\sp\utility::_id_2679();
  scripts\engine\utility::flag_wait("spawn_exfil_exfil_c8_02");
  var_12 = scripts\sp\utility::_id_22CD("exfil_hallway_enemies_02");

  foreach(var_10 in var_12) {
    var_7 = scripts\engine\utility::array_add(var_7, var_10);
  }

  var_15 = scripts\sp\utility::_id_107EA("exfil_c8_02", 1);
  var_7 = scripts\engine\utility::array_add(var_7, var_15);
  var_6 = getnode(var_15.target, "targetname");
  var_15 _meth_82EE(var_6);
  var_7 = scripts\sp\utility::array_removedeadvehicles(var_7);
  scripts\sp\utility::_id_13754(var_7);
  scripts\engine\utility::flag_set("enable_exfil_airlock_setup");
}

_id_1D0C() {
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2) && !isDefined(var_2._id_B14F)) {
      var_2 _meth_81D0();
    }
  }
}

_id_E0EA(var_0, var_1, var_2) {
  var_0 = _id_22AD(var_0);
  var_3 = getEnt(var_1, "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_F72B, var_3, var_2);
}

_id_F72B(var_0, var_1) {
  self endon("death");
  self notify("stop_setGoalVolumeAutoDelay");
  self endon("stop_setGoalVolumeAutoDelay");

  if(scripts\engine\utility::is_true(var_1)) {
    wait(randomfloatrange(1.0, 2.5));
  }

  self _meth_82F1(var_0);
}

_id_22AD(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    if(var_3 scripts\sp\utility::_id_58DA()) {
      continue;
    }
    if(scripts\engine\utility::is_true(var_3._id_EE87)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_6901() {
  level.player endon("death");
  wait 0.5;
  level.player scripts\sp\utility::_id_1034D("sa_vips_plr_itsachargeshotpl");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_sturdyhardware");
  wait 0.5;
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_theyreclosingitlet");
  scripts\sp\utility::_id_10350("sa_vips_eth_copy11jackalsareon");
  scripts\engine\utility::flag_wait("exfil_combat_start");
  wait 1;
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_bossincoming");
  scripts\engine\utility::flag_wait_either("spawn_exfil_armory_enemies_02", "exfil_armory_enemies_01_dead");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_keepmoving");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_egresspointcomin");
  scripts\engine\utility::flag_wait_either("spawn_exfil_hallway_guys", "exfil_c8_01_dead");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_vips_slt_almosttotheexfil");
}

_id_1723(var_0, var_1, var_2) {
  if(!scripts\sp\utility::_id_C268(var_0)) {
    objective_add(scripts\sp\utility::_id_C264(var_0), var_1, var_2);
    thread _id_0F16::_id_C278(scripts\sp\utility::_id_C264(var_0));
  }
}

_id_12DFB(var_0, var_1) {
  if(scripts\sp\utility::_id_C268(var_0)) {
    objective_position(scripts\sp\utility::_id_C264(var_0), var_1);
    thread _id_0F16::_id_C278(scripts\sp\utility::_id_C264(var_0));
  }
}

_id_79F8(var_0) {
  var_1 = [];

  switch (var_0) {
    case "sa_hangar_vol":
      var_1["ar_nogrenades"] = 2;
      var_1["smg_nogrenades"] = 2;
      var_1["lmg_nogrenades"] = 2;
      break;
    case "sa_armory_room_vol":
      var_1["ar"] = 1;
      var_1["sg"] = 1;
      var_1["smg"] = 1;
      var_1["lmg"] = 1;
      break;
    case "sa_hubbow_vol":
      var_1["smg"] = 2;
      break;
    case "sa_bridge_vol":
      var_1["ar"] = 2;
      break;
    case "sa_bridge_com_vol":
      var_1["ar"] = 2;
      break;
    case "sa_sternport_rooma_vol":
      var_1["smg"] = 2;
      break;
    case "sa_sternport_roomb_vol":
      var_1["smg"] = 2;
      break;
    case "sa_starboard_lower_vol":
      var_1["smg"] = 0;
      break;
    case "sa_starboard_lower_rooma_vol":
      var_1["smg"] = 0;
      break;
    case "sac_bowupper_vol":
      var_1["smg"] = 1;
      break;
    case "sa_sternstarboard_rooma_vol":
      break;
    default:
      var_1["ar"] = randomintrange(2, 4);
      break;
  }

  return var_1;
}

_id_7B73(var_0) {
  var_1 = [];

  switch (var_0) {
    case "sa_hangar_vol":
      var_1["ar_nogrenades"] = 3;
      var_1["smg_nogrenades"] = 2;
      var_1["lmg_nogrenades"] = 2;
      break;
    case "sa_armory_room_vol":
      var_1["ar"] = 1;
      var_1["sg"] = 1;
      var_1["smg"] = 2;
      var_1["lmg"] = 1;
      break;
    case "sa_hubbow_vol":
      var_1["smg"] = 3;
      break;
    case "sa_bridge_vol":
      var_1["smg"] = 2;
      break;
    case "sa_bridge_com_vol":
      var_1["smg"] = 2;
      break;
    case "sa_sternport_rooma_vol":
      var_1["smg"] = 2;
      break;
    case "sa_sternport_roomb_vol":
      var_1["smg"] = 2;
      break;
    case "sa_starboard_lower_vol":
      var_1["smg"] = 0;
      break;
    case "sa_starboard_lower_rooma_vol":
      var_1["smg"] = 0;
      break;
    case "sa_sternstarboard_rooma_vol":
      break;
    default:
      var_1["ar"] = randomintrange(3, 6);
      break;
  }

  return var_1;
}

_id_7913(var_0) {
  var_1 = [];

  switch (var_0) {
    case "sa_hangar_vol":
      break;
    case "sa_armory_room_vol":
      break;
    case "sa_hubbow_vol":
      break;
    case "sa_bridge_vol":
      break;
    case "sa_bridge_com_vol":
      break;
    case "sa_sternport_rooma_vol":
      break;
    case "sa_sternport_roomb_vol":
      break;
    case "sa_starboard_lower_vol":
      break;
    case "sa_starboard_lower_rooma_vol":
      break;
    case "sa_sternstarboard_rooma_vol":
      break;
    default:
      break;
  }

  return var_1;
}

_id_9716() {
  var_0 = [];
  var_0["sa_hangar_vol"] = "sa_hangar_start";
  var_0["sa_armory_room_vol"] = "sa_armory_start";
  var_0["sa_hubbow_vol"] = "sa_hubbow_start";
  var_0["sa_bridge_vol"] = "sa_bridge_start";
  var_0["sa_bridge_com_vol"] = "sa_bridge_com_start";
  var_0["sa_barracks_vol"] = "sa_barracks_start";
  var_0["sa_sternport_rooma_vol"] = "sa_sternport_rooma_start";
  var_0["sa_sternport_roomb_vol"] = "sa_sternport_roomb_start";
  var_0["sa_starboard_lower_rooma_vol"] = "sa_starboard_lower_rooma_start";
  var_0["sa_sternstarboard_rooma_vol"] = "sa_sternstarboard_rooma_start";
  var_0["sac_hubstern_port_vol"] = "sac_hubstern_port_start";
  var_0["sac_portlower_vol"] = "sac_portlower_start";
  var_0["sa_starboard_lower_vol"] = "sa_starboard_lower_start";
  var_0["sac_bowupper_vol"] = "sac_bowupper_start";
  var_0["sac_bowlower_vol"] = "sac_bowlower_start";
  var_1 = [];
  var_1["sa_hangar_vol"] = "alert";
  var_1["sa_armory_room_vol"] = "alert";
  var_1["sa_hubbow_vol"] = "alert";
  var_1["sa_bridge_vol"] = "alert";
  var_1["sa_bridge_com_vol"] = "alert";
  var_1["sa_barracks_vol"] = "alert";
  var_1["sa_sternport_rooma_vol"] = "alert";
  var_1["sa_sternport_roomb_vol"] = "alert";
  var_1["sa_starboard_lower_rooma_vol"] = "alert";
  var_1["sa_sternstarboard_rooma_vol"] = "alert";
  var_1["sac_hubstern_port_vol"] = "alert";
  var_1["sac_portlower_vol"] = "alert";
  var_1["sa_starboard_lower_vol"] = "alert";
  var_1["sac_bowupper_vol"] = "alert";
  var_1["sac_bowlower_vol"] = "alert";
  var_2 = [];
  var_2["sa_hangar_vol"] = "sa_hangar_combat_vol";
  var_2["sa_armory_room_vol"] = "sa_armory_combat_vol";
  var_2["sa_hubbow_vol"] = "sa_hubbow_combat_vol";
  var_2["sa_bridge_vol"] = "sa_bridge_combat_vol";
  var_2["sa_bridge_com_vol"] = "sa_bridge_com_combat_vol";
  var_2["sa_barracks_vol"] = "sa_barracks_combat_vol";
  var_2["sa_sternport_rooma_vol"] = "sa_sternport_rooma_combat_vol";
  var_2["sa_sternport_roomb_vol"] = "sa_sternport_roomb_combat_vol";
  var_2["sa_starboard_lower_rooma_vol"] = "sa_starboard_lower_rooma_combat_vol";
  var_2["sa_sternstarboard_rooma_vol"] = "sa_sternstarboard_rooma_vol";
  var_2["sac_hubstern_port_vol"] = "sac_hubstern_port_combat_vol";
  var_2["sac_portlower_vol"] = "sac_portlower_combat_vol";
  var_2["sa_starboard_lower_vol"] = "sa_starboard_lower_combat_vol";
  var_2["sac_bowupper_vol"] = "sac_bowupper_combat_vol";
  var_2["sac_bowlower_vol"] = "sac_bowupper_combat_vol";
  _id_0F0C::_id_E9E4(var_0, var_1, var_2, ::_id_79F8, ::_id_7B73, ::_id_7913);
}

_id_2FB0(var_0, var_1, var_2, var_3) {
  var_4 = getEnt(var_0, "targetname");
  var_5 = scripts\engine\utility::getStruct(var_4.target, "targetname");

  if(isDefined(var_5)) {
    var_6 = var_5.origin;
    level thread _id_12DFB(var_1, var_6);
  }

  while(isDefined(var_4) && isDefined(var_4.target)) {
    var_7 = getEnt(var_4.target, "targetname");
    var_4 waittill("trigger");
    var_4 = var_7;

    if(isDefined(var_4)) {
      var_6 = var_4 getorigin();

      if(isDefined(var_4.target)) {
        var_5 = scripts\engine\utility::getStruct(var_4.target, "targetname");

        if(isDefined(var_5)) {
          var_6 = var_5.origin;
        }
      }

      level thread _id_12DFB(var_1, var_6);
    }
  }

  if(isDefined(var_4)) {
    var_4 waittill("trigger");
  }

  if(isDefined(var_2)) {
    scripts\engine\utility::flag_set(var_2);
  }

  if(scripts\engine\utility::is_true(var_3)) {
    _id_12DFB(var_1, (0, 0, 0));
  }
}

_id_133DF() {
  scripts\engine\utility::flag_wait_all("vips_spawned", "captain_spawned");
  level endon("execute_vips");
  level._id_133D3 endon("death");
  level endon("captain_dead_or_alerted");
  level._id_133D3 endon("start_context_melee");
  level._id_133E0 thread scripts\sp\anim::_id_1EEA(level._id_133CF, "vip_idle", "vip1_stop_loop");
  level._id_133E0 thread scripts\sp\anim::_id_1EEA(level._id_133D0, "vip_idle", "vip2_stop_loop");
  level._id_133E0 thread scripts\sp\anim::_id_1EEA(level._id_133D1, "vip_idle", "vip3_stop_loop");
  level._id_133E0 thread scripts\sp\anim::_id_1EEA(level._id_133D2, "vip_idle", "vip4_stop_loop");

  for(;;) {
    level._id_133E0 scripts\sp\anim::_id_1F35(level._id_133D3, "execution_pace_idle");
  }
}

_id_133DE() {
  self endon("death");
  self waittillmatch("single anim", self._id_13704);

  if(!scripts\engine\utility::is_true(level._id_3A1A)) {
    self waittillmatch("single anim", "death");
    scripts\sp\utility::_id_1101B();
    scripts\sp\utility::_id_54C6();
  }
}

_id_3A27() {
  level.player endon("death");
  wait 1.0;
  var_0 = scripts\engine\utility::waittill_any_return("stealth_alertlevel_change", "death");
  level._id_3A1A = 1;
  scripts\engine\utility::flag_set("captain_dead_or_alerted");
  level notify("captain_dead_or_alerted");

  if(var_0 == "stealth_alertlevel_change") {
    if(isDefined(level._id_133D3) && isalive(level._id_133D3)) {
      level._id_133D3 thread scripts\sp\utility::_id_10346("sa_vips_bkv_executethem");
    }
  }

  wait 0.1;

  if(scripts\engine\utility::flag("sa_hangar_vol_cleared")) {
    return;
  }
  if(var_0 == "death") {
    var_1 = getaiarray("axis");
    var_1 = scripts\engine\utility::array_remove(var_1, self);
    var_2 = scripts\sp\utility::_id_7D80(self.origin, var_1, 1000);

    foreach(var_4 in var_2) {
      if(!isDefined(level._id_3A21)) {
        var_4 thread scripts\sp\utility::_id_10347("sa_vips_sf1_thecaptainskia");
        level._id_3A21 = 1;
      }

      var_4 _meth_84F7("seek_backup", self, self.origin);
      var_1 = scripts\engine\utility::array_remove(var_1, var_4);
    }

    wait 2.0;
    thread _id_0F00::_id_CDBD("sa_vips_spa_thecaptainisdow", 1);
    wait 2.0;
    var_6 = [];
    var_6[var_6.size] = "sa_vips_sf1_shoottheprisone";
    var_6[var_6.size] = "sa_vips_sf2_killthemnow";

    foreach(var_4 in var_1) {
      if(isDefined(var_4) && isalive(var_4)) {
        var_4 _meth_84F7("attack", level.player, level.player.origin);

        if(var_6.size >= 1) {
          var_8 = scripts\engine\utility::random(var_6);
          var_6 = scripts\engine\utility::array_remove(var_6, var_8);
          var_4 scripts\engine\utility::delaythread(randomfloatrange(0.25, 1.0), scripts\sp\utility::_id_10347, var_8);
        }
      }
    }
  } else {
    var_1 = getaiarray("axis");
    var_1 = scripts\sp\utility::array_removedeadvehicles(var_1);

    foreach(var_4 in var_1) {
      if(isDefined(var_4) && isalive(var_4)) {
        var_4 _meth_84F7("attack", level.player, level.player.origin);
      }
    }
  }
}

_id_117C8() {
  var_0 = scripts\engine\utility::getStruct("threat_sight_hint_struct", "targetname");
  scripts\engine\utility::flag_wait("start_threat_sight_hint");
  scripts\sp\utility::_id_56BE("threat_meter", 6.0);
  var_1 = 0;

  for(;;) {
    level.player thread _id_0F26::_id_117C4(var_0.origin, var_1);
    wait 0.05;
    var_1 = var_1 + 0.01;

    if(var_1 >= 1.0) {
      break;
    }
  }

  wait 0.5;
  level.player thread _id_0F26::_id_117C4(var_0.origin, 0);
}

_id_104CE() {
  if(!isDefined(level._id_104CF)) {
    level._id_104CF = 1;
    var_0 = _id_0F31::_id_7EDE();
    scripts\engine\utility::array_thread(var_0, _id_0F31::_id_310C, 1);
    _id_0F31::_id_E727(5);
    level thread _id_BC48("space_small_movers", 480);
    level thread _id_BC48("space_large_movers", 120, 20);
    var_1 = getEntArray("objectBrushNoGrapple2", "targetname");
    scripts\engine\utility::array_thread(var_1, _id_0F16::_id_310D, 1);

    foreach(var_3 in var_1) {
      var_3 thread _id_0F31::_id_3109(5);
    }
  }

  thread _id_BC61();
}

_id_BC61() {
  level endon("death");
  level endon("stop_space_debris");
  var_0 = (-6000, -6000, 0);
  var_1 = 90;
  var_2 = getEntArray("asteroid_field", "script_noteworthy");

  for(;;) {
    var_0 = var_0 * -1;

    foreach(var_4 in var_2) {
      var_4 moveTo(var_4.origin + var_0, var_1);
    }

    wait(var_1);
  }
}

_id_9325() {
  self endon("death");
  scripts\sp\utility::_id_F415(1);
  scripts\engine\utility::waittill_either("damage", "goal");
  scripts\sp\utility::_id_F415(0);
}

_id_E357(var_0) {
  self endon("death");
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  self.health = 10;
  var_1 = getEntArray(var_0, "targetname");
  var_2 = scripts\engine\utility::getclosest(self.origin, var_1);
  self cleargoalvolume();
  scripts\sp\utility::_id_F39F();
  scripts\sp\utility::_id_F3BC();
  scripts\sp\utility::_id_F3E0(100);
  self setgoalpos(var_2.origin);
  self waittill("goal");
  self delete();
}

_id_13755(var_0, var_1, var_2, var_3) {
  level endon(var_2);
  scripts\sp\utility::_id_13754(var_0, var_1, var_3);
  scripts\engine\utility::flag_set(var_2);
}

_id_4DE4() {
  self endon("delete");
  self notsolid();
  self._id_1FBB = "generic";

  if(self.animation == "body_bag_body_loop_body1") {
    level._id_10ED1 thread scripts\sp\anim::_id_1EEA(self, "body_bag_body_loop_body1", "stop_dead_loop");
    scripts\engine\utility::flag_wait("body_bag_melee_kill_enemy_dead_or_alerted");
    level._id_10ED1 notify("stop_dead_loop");
    level._id_10ED1 scripts\sp\anim::_id_1EC3(self, "body_bag_body_loop_body1");
  } else
    level._id_10ED1 thread scripts\sp\anim::_id_1EEA(self, self.animation);
}

_id_5987(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon(var_0);
  var_6 = getEnt(var_1, "targetname");

  for(;;) {
    if(level.player istouching(var_6) && level._id_EA2C istouching(var_6)) {
      level._id_E99E[var_2] thread _id_0F05::_id_E9A0();
      level._id_E99E[var_2] thread _id_0F05::_id_AED6(0);
      wait 0.5;

      if(isDefined(var_5)) {
        level notify(var_5);
      }

      level thread scripts\sp\utility::_id_1264E(var_3);

      if(isDefined(var_4)) {
        level thread scripts\sp\utility::_id_1264E(var_4);
      }

      scripts\engine\utility::flag_set(var_0);
    }

    wait 0.1;
  }
}

_id_2254() {
  scripts\engine\utility::flag_wait_either("spawn_hubbow_runners_01", "lower_corridor_guys_02_dead");
  scripts\engine\utility::flag_set("unload_cargobay_transient");
}

_id_3A90() {
  level endon("cargobay_regrouped");
  var_0 = getEnt("cargobay_exit_door_open", "targetname");

  for(;;) {
    if(level.player istouching(var_0) && level._id_EA2C istouching(var_0)) {
      while(!istransientloaded("sa_vips_armory_tr") || !istransientloaded("sa_vips_bowlower_tr") || !istransientloaded("sa_vips_hubbow_tr")) {
        wait 0.05;
        waitforalltransients();
      }

      level._id_E99E["cargo_bay_to_sac_lower_door"] thread _id_0F05::_id_12BD3(0);
      scripts\engine\utility::flag_set("cargobay_regrouped");
    }

    wait 0.1;
  }
}

_id_13E7B() {
  var_0 = getEntArray("zero_g_physics_debris", "targetname");

  if(isDefined(var_0)) {
    scripts\engine\utility::array_thread(var_0, _id_0F16::_id_6F40);
  }
}

_id_13E7C() {
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1) && var_1 == level.player && isDefined(var_3) && isDefined(var_2)) {
      self notify("stop_float_in_space");

      if(isDefined(var_5) && issubstr(var_5, "box")) {
        break;
      }

      self physicslaunchserver(var_3, var_2);
      break;
    } else
      wait 0.05;
  }
}

_id_119C1(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  while(!scripts\engine\utility::flag(var_3)) {
    var_5 = distancesquared(level.player.origin, var_1);

    if(var_4 && var_5 >= var_2) {
      var_4 = 0;
      objective_state_nomessage(var_0, "current");
    } else if(!var_4 && var_5 < var_2) {
      var_4 = 1;
      objective_state_nomessage(var_0, "invisible");
    }

    wait 0.05;
  }
}

_id_10F43() {
  level endon("stop_stealth_vo_watcher");
  level endon("execute_vips");
  level endon("captain_dead_or_alerted");
  level.player thread _id_0F24::_id_10EE3();
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  for(;;) {
    level.player waittill("stealth_noteworthy", var_6, var_7);

    if(scripts\engine\utility::is_true(level._id_D4A5)) {
      continue;
    }
    if(!isDefined(var_6)) {
      continue;
    }
    foreach(var_9 in var_7) {
      if(isDefined(var_9) && isDefined(level._id_133D3) && var_9 == level._id_133D3) {
        switch (var_6) {
          case "aim":
            if(!isDefined(var_0)) {
              if(scripts\engine\utility::is_true(level._id_133D8)) {
                var_0 = [];
                var_0[var_0.size] = "sa_vips_eth_makeitcountsir";
                var_0[var_0.size] = "sa_vips_eth_drophim";
              } else {
                var_0 = [];
                var_0[var_0.size] = "sa_vips_eth_ifyoudrophim";
                var_0[var_0.size] = "sa_vips_eth_cleartheothers";
                var_0[var_0.size] = "sa_vips_eth_clearoutafewmore";
              }
            }

            var_10 = var_0[0];
            level._id_6787 = 1;

            if(soundexists(var_10)) {
              scripts\sp\utility::_id_10350(var_10);
            }

            level._id_6787 = undefined;
            var_0 = scripts\engine\utility::array_remove(var_0, var_0[0]);

            if(isDefined(var_0) && var_0.size <= 0) {
              var_0 = undefined;
            }

            if(isDefined(var_9) && isalive(var_9)) {
              level.player._id_10E6D._id_10EDF[var_9 getentitynumber()] = undefined;
            }

            break;
          default:
            break;
        }

        continue;
      }

      switch (var_6) {
        case "aim":
          if(!isDefined(var_1)) {
            var_1 = [];
            var_1[var_1.size] = "sa_vips_eth_waittilnooneslooking";
            var_1[var_1.size] = "sa_vips_eth_dontletotherssee";
            var_1[var_1.size] = "sa_vips_eth_noonesees";
          }

          var_10 = var_1[0];
          level._id_6787 = 1;
          scripts\sp\utility::_id_10350(var_10);
          level._id_6787 = undefined;
          var_1 = scripts\engine\utility::array_remove(var_1, var_1[0]);

          if(isDefined(var_1) && var_1.size <= 0) {
            var_1 = undefined;
          }

          break;
        case "civilian_kill":
          break;
        case "good_kill_double":
          if(!isDefined(var_2)) {
            var_2 = [];
            var_2[var_2.size] = "sa_vips_eth_noalertssent";
            var_2[var_2.size] = "sa_vips_eth_cleandrop";
            var_2[var_2.size] = "sa_vips_eth_intheclearcaptain";
            var_2[var_2.size] = "sa_vips_eth_yourestillclean";
            var_2[var_2.size] = "sa_vips_eth_niceworksir5_129";
            var_2[var_2.size] = "sa_vips_eth_noonenoticed5_130";
            var_2[var_2.size] = "sa_vips_eth_niceshot5_132";
          }

          var_10 = var_2[0];
          level._id_6787 = 1;
          scripts\sp\utility::_id_10350(var_10);
          level._id_6787 = undefined;
          var_2 = scripts\engine\utility::array_remove(var_2, var_2[0]);

          if(isDefined(var_2) && var_2.size <= 0) {
            var_2 = undefined;
          }

          break;
        case "good_kill_impressive":
          if(!isDefined(var_3)) {
            var_3 = [];
            var_3[var_3.size] = "sa_vips_eth_noalertssent";
            var_3[var_3.size] = "sa_vips_eth_cleandrop";
            var_3[var_3.size] = "sa_vips_eth_intheclearcaptain";
            var_3[var_3.size] = "sa_vips_eth_yourestillclean";
            var_3[var_3.size] = "sa_vips_eth_niceworksir5_129";
            var_3[var_3.size] = "sa_vips_eth_noonenoticed5_130";
            var_3[var_3.size] = "sa_vips_eth_niceshot5_132";
          }

          var_10 = var_3[0];
          level._id_6787 = 1;
          scripts\sp\utility::_id_10350(var_10);
          level._id_6787 = undefined;
          var_3 = scripts\engine\utility::array_remove(var_3, var_3[0]);

          if(isDefined(var_3) && var_3.size <= 0) {
            var_3 = undefined;
          }

          break;
        case "good_kill_bullet":
          if(!isDefined(var_4)) {
            var_4 = [];
            var_4[var_4.size] = "sa_vips_eth_noalertssent";
            var_4[var_4.size] = "sa_vips_eth_cleandrop";
            var_4[var_4.size] = "sa_vips_eth_intheclearcaptain";
            var_4[var_4.size] = "sa_vips_eth_yourestillclean";
            var_4[var_4.size] = "sa_vips_eth_niceworksir5_129";
            var_4[var_4.size] = "sa_vips_eth_noonenoticed5_130";
            var_4[var_4.size] = "sa_vips_eth_targetdown5_131";
            var_4[var_4.size] = "sa_vips_eth_niceshot5_132";
            var_4[var_4.size] = "sa_vips_eth_hesdown5_133";
          }

          var_10 = var_4[0];
          level._id_6787 = 1;
          scripts\sp\utility::_id_10350(var_10);
          level._id_6787 = undefined;
          var_4 = scripts\engine\utility::array_remove(var_4, var_4[0]);

          if(isDefined(var_4) && var_4.size <= 0) {
            var_4 = undefined;
          }

          break;
        case "good_kill":
          if(!isDefined(var_5)) {
            var_5 = [];
            var_5[var_5.size] = "sa_vips_eth_noalertssent";
            var_5[var_5.size] = "sa_vips_eth_cleandrop";
            var_5[var_5.size] = "sa_vips_eth_intheclearcaptain";
            var_5[var_5.size] = "sa_vips_eth_yourestillclean";
            var_5[var_5.size] = "sa_vips_eth_niceworksir5_129";
            var_5[var_5.size] = "sa_vips_eth_noonenoticed5_130";
          }

          var_10 = var_5[0];
          level._id_6787 = 1;
          scripts\sp\utility::_id_10350(var_10);
          level._id_6787 = undefined;
          var_5 = scripts\engine\utility::array_remove(var_5, var_5[0]);

          if(isDefined(var_5) && var_5.size <= 0) {
            var_5 = undefined;
          }

          break;
        default:
          break;
      }
    }

    wait 6.0;
  }
}

_id_F399() {
  self endon("death");

  for(;;) {
    self waittill("trigger");
    _id_0F16::_id_13351(self._id_EF20, self.script_index);

    if(scripts\engine\utility::is_true(self.script_index)) {
      switch (self._id_EF20) {
        case "vfx_vips_amb_server":
          wait_for_transient_if_queued(["sa_vips_hubbow_tr"]);
          break;
        case "vfx_vips_amb_cargohall":
          wait_for_transient_if_queued(["sa_vips_bowupper_tr"]);
          break;
        case "vfx_vips_amb_cargo":
          wait_for_transient_if_queued(["sa_vips_cargobay_tr"]);
          break;
        case "vfx_vips_amb_hall":
          wait_for_transient_if_queued(["sa_vips_starboardlower_tr", "sa_vips_messhall_tr"]);
          break;
        case "vfx_vips_amb_armory":
          wait_for_transient_if_queued(["sa_vips_armory_tr"]);
          break;
        default:
          break;
      }
    }

    wait 0.05;
  }
}

wait_for_transient_if_queued(var_0) {
  foreach(var_2 in var_0) {
    if(istransientqueued(var_2)) {
      while(!istransientloaded(var_2)) {
        wait 0.05;
        waitfortransient(var_2);
      }
    }
  }
}

_id_B090() {
  thread _id_0F16::_id_8EA3();
  _id_0F0C::_id_E9AB("sa_armory_room_vol");
  _id_0F0C::_id_E9D1("sa_hangar_vol", "cleared");
  _id_0F0C::_id_E9D1("sac_bowupper_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_hubbow_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_armory_room_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_starboard_lower_vol", "cleared");
  _id_0F0C::_id_E9D1("sa_starboard_lower_rooma_vol", "cleared");
  level thread _id_0F16::_id_991E(1);
  _id_0F16::_id_13351("vfx_vips_amb_armory", 1);
  _id_0F16::_id_13351("vfx_vips_amb_hub", 1);
  level.player setOrigin((488.963, -217.653, -47.9062));
  level.player setplayerangles((0, 220, 0));
}

_id_B08A() {
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  wait 2.0;
  level._id_E99E["armory_loot_room_door_01"]._id_4D94._id_885A = 3;
  scripts\engine\utility::flag_set("enable_armory_loot_room_door_01");
}

_id_5404() {
  level.player endon("death");
  level endon("execute_vips");
  level endon("captain_dead_or_alerted");
  level endon("sa_hangar_vol_cleared");

  for(;;) {
    wait 1.0;
    var_0 = level.player getcurrentweapon();

    if(var_0 == "none" || _id_9F55(var_0)) {
      continue;
    } else {
      break;
    }
  }

  level thread scripts\sp\utility::_id_10350("sa_vips_eth_sticksuppressedweapon");
}

_id_9F55(var_0) {
  return issubstr(var_0, "silence");
}

_id_B2C8() {
  _id_0F0E::_id_F901();
  scripts\engine\utility::waitframe();
  _id_0F0E::_id_F900("destroyer_exterior_hull");
  level._id_3965 _id_0BB8::_id_397D();
}

_id_4281() {
  if(isDefined(level._id_2FA5["window_messhall_corridor"])) {
    level._id_2FA5["window_messhall_corridor"] thread _id_0F17::_id_13D3F();
  }

  if(isDefined(level._id_2FA5["window_messhall_01"])) {
    level._id_2FA5["window_messhall_01"] thread _id_0F17::_id_13D3F();
  }

  if(isDefined(level._id_2FA5["window_messhall_02"])) {
    level._id_2FA5["window_messhall_02"] thread _id_0F17::_id_13D3F();
  }

  if(isDefined(level._id_2FA5["window_messhall_03"])) {
    level._id_2FA5["window_messhall_03"] thread _id_0F17::_id_13D3F();
  }

  scripts\engine\utility::flag_wait("player_entered_ship");

  if(isDefined(level._id_2FA5["window_messhall_corridor"])) {
    level._id_2FA5["window_messhall_corridor"] thread _id_0F17::_id_13D42();
  }

  if(isDefined(level._id_2FA5["window_messhall_01"])) {
    level._id_2FA5["window_messhall_01"] thread _id_0F17::_id_13D42();
  }

  if(isDefined(level._id_2FA5["window_messhall_02"])) {
    level._id_2FA5["window_messhall_02"] thread _id_0F17::_id_13D42();
  }

  if(isDefined(level._id_2FA5["window_messhall_03"])) {
    level._id_2FA5["window_messhall_03"] thread _id_0F17::_id_13D42();
  }
}

_id_7264() {
  if(isDefined(level._id_2FA5["window_messhall_corridor"])) {
    level._id_2FA5["window_messhall_corridor"] thread _id_0F17::_id_13D5C();
  }

  if(isDefined(level._id_2FA5["window_messhall_01"])) {
    level._id_2FA5["window_messhall_01"] thread _id_0F17::_id_13D5C();
  }

  if(isDefined(level._id_2FA5["window_messhall_02"])) {
    level._id_2FA5["window_messhall_02"] thread _id_0F17::_id_13D5C();
  }

  if(isDefined(level._id_2FA5["window_messhall_03"])) {
    level._id_2FA5["window_messhall_03"] thread _id_0F17::_id_13D5C();
  }
}

_id_8E82() {
  var_0 = getEntArray("delete_for_exfil", "targetname");

  if(isDefined(var_0)) {
    scripts\engine\utility::array_call(var_0, ::hide);
  }

  var_1 = getEntArray("space_large_movers", "targetname");

  if(isDefined(var_1)) {
    scripts\engine\utility::array_call(var_1, ::hide);
  }

  var_2 = getEntArray("rotating_roid", "targetname");

  if(isDefined(var_2)) {
    scripts\engine\utility::array_call(var_2, ::hide);
  }
}

_id_100DC() {
  var_0 = getEntArray("delete_for_exfil", "targetname");

  if(isDefined(var_0)) {
    scripts\engine\utility::array_call(var_0, ::show);
  }

  var_1 = getEntArray("space_large_movers", "targetname");

  if(isDefined(var_1)) {
    scripts\engine\utility::array_call(var_1, ::show);
  }

  var_2 = getEntArray("rotating_roid", "targetname");

  if(isDefined(var_2)) {
    scripts\engine\utility::array_call(var_2, ::show);
  }
}

_id_10ED0(var_0) {
  thread scripts\sp\maps\sa_vips\sa_vips_audio::_id_10ED0();
}

_id_40D5(var_0, var_1) {
  scripts\engine\utility::flag_wait(var_1);
  var_0 delete();
}

_id_F105(var_0, var_1) {
  var_0 endon("death");
  scripts\engine\utility::flag_wait("stealth_spotted");
  setmusicstate("mx_413a_savips_breakstealth");
  var_0 notify("stop_handle_volume_combat");
  wait 0.05;
  var_0 notify("stop_handle_volume_combat");
  var_0 thread _id_0F0C::_id_4276();
}

_id_119BF() {
  level endon("stop_toggle_ignoreme_on_player");

  if(!scripts\engine\utility::flag_exist("set_ignoreme_on_player")) {
    scripts\engine\utility::flag_init("set_ignoreme_on_player");
  }

  for(;;) {
    scripts\engine\utility::flag_wait("set_ignoreme_on_player");
    level.player scripts\sp\utility::_id_F416(1);
    scripts\engine\utility::flag_waitopen("set_ignoreme_on_player");
    level.player scripts\sp\utility::_id_F416(0);
  }
}