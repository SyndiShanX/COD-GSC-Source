/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_01.gsc
*********************************************/

func_00F9() {
  level.var_AC31 = 0;
  level.var_0C19 = 0;
  level.var_AC2E = 2;
  lib_04BF::func_00F9();
  lib_0426::func_00F9();
  lib_04BE::func_00F9();
  if(getDvar("233") == "1") {
    func_6B91();
  }

  maps\mp\_load::func_00F9();
  maps\mp\mp_zombie_nest_01_lighting::func_00F9();
  maps\mp\mp_zombie_nest_01_aud::func_00F9();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  setDvar("1520", "-1 -1 -1 5");
  setDvar("2494", "0.12, 0, 0");
  common_scripts\utility::func_3C87("flag_zone1_start");
  common_scripts\utility::func_3C87("flag_jumpscare_trigger");
  common_scripts\utility::func_3C87("flag_generator_grate_look");
  common_scripts\utility::func_3C87("flag_fuse_pickedup");
  common_scripts\utility::func_3C87("flag_bunker_lights_off");
  lib_055A::func_00D5();
  level.var_8C96 = ::func_666B;
  maps\mp\_water::func_00D5();
  func_5339();
  maps\mp\mp_zombie_falldamage_modifier::func_00F9();
  maps\mp\mp_zombie_nest_pneumos::func_00F9();
  thread lib_0551::func_3D50(0);
  func_5375();
  level thread func_531C();
  thread maps\mp\zombies\_zombies_money::func_00D5();
  thread lib_055D::func_00D5();
  thread func_347A();
  level.var_ABD3 = 0;
  level.var_324B = ::func_76D0;
  level.var_AC71 = ::func_531D;
  level.var_AC72 = ::func_6B5A;
  level.var_6BB0 = ::func_6B5B;
  level.var_AC2F = ::func_531E;
  if(1) {
    level.var_64B6 = ::func_6668;
  }

  thread func_3FD2();
  thread maps\mp\mp_zombie_nest_pneumos::func_2037();
  thread func_83FA("bunker_light_switch", 0);
  thread func_7EAC();
  thread func_2033();
  thread func_1D8F();
  thread func_3C23();
  level.var_0C11 = 0;
  thread maps\mp\_utility::func_6F74(::maps\mp\mp_zombie_nest_ee_util::func_73B8);
  thread maps\mp\_utility::func_6F74(::func_742E);
  thread func_3BF9();
  thread func_3DCE();
  thread func_18DE();
  level thread maps\mp\zquests\dlc1_secrets_mp_zombie_nest_01::init_dlc1_secrets_mp_zombie_nest_01();
  if(maps\mp\_utility::isproductionlevelactive(10)) {
    level thread maps\mp\zombies\_zombies_lo_events::init_zm_lo_events();
  }

  lib_0565::func_7C07("raven_set");
  lib_0565::func_7C07("treasure_set");
  lib_0565::func_7C07("assassin_set");
  lib_0565::func_7C07("survivalist_set");
  lib_0565::func_7C07("mountain_man_set");
  lib_0565::func_7C07("bat_elite_set");
  thread func_4D47();
  level thread lib_0557::manage_mtx5_event();
}

func_531E() {
  lib_055F::func_00D5();
  lib_0568::func_00D5();
  lib_0564::func_3BFB(1);
}

func_531D() {
  thread lib_057D::func_5162();
  lib_0580::func_00D5();
  lib_057E::func_51CF();
  lib_057F::func_00D5();
}

func_6B5A() {
  thread maps\mp\zombies\_zombies_magicbox::func_A7D9();
}

func_AA3C() {
  if(!0) {
    var_00 = getEntArray("zbarrier_window", "script_noteworthy");
    foreach(var_02 in var_00) {
      var_02 makeunusable();
    }
  }
}

func_5339() {
  lib_0557::func_786C();
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_fire_well::func_418E());
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_fire_well::func_40E8());
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_enigma::func_430C());
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_cart::func_43E8());
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_cart::func_43E9());
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_cart::func_43E7());
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_fuses::func_4303());
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_overcharge::func_41E7());
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_paintings::func_43CC());
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_overcharge::func_40C0(1));
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_overcharge::func_40C0(2));
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_overcharge::func_40C0(3));
  lib_0557::func_AB8D("collectible_armor_purchased");
  level thread maps\mp\_utility::func_6F74(::func_7827);
  lib_0557::func_AB8D(lib_0569::func_42A5());
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_final_boss::func_40E2());
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_hc_toy_arms::func_40AC(1));
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_hc_toy_arms::func_40AC(2));
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_hc_toy_arms::func_40AC(3));
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_hc_toy_arms::func_42F3());
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::func_42ED("blood"));
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::func_42ED("moon"));
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::func_42ED("death"));
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::func_42ED("storm"));
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_hc_tools_of_the_trade::func_42EF());
  lib_0557::func_AB8C(maps\mp\mp_zombie_nest_ee_hc_true_voice::func_42EE());
  thread maps\mp\mp_zombie_nest_ee_fire_well::func_00F9();
  thread maps\mp\mp_zombie_nest_ee_enigma::func_00F9();
  thread maps\mp\mp_zombie_nest_ee_cart::func_00F9();
  thread maps\mp\mp_zombie_nest_ee_shard::func_00F9();
  thread maps\mp\mp_zombie_nest_ee_fuses::func_00F9();
  thread maps\mp\mp_zombie_nest_ee_tower_battle::func_00F9();
  thread maps\mp\mp_zombie_nest_ee_overcharge::func_00F9();
  thread maps\mp\mp_zombie_nest_ee_paintings::func_00F9();
  thread maps\mp\mp_zombie_nest_ee_boss_blimp::func_00F9();
  thread lib_0560::func_00D5();
  thread maps\mp\mp_zombie_nest_ee_final_boss::func_00F9();
  thread maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::func_00F9();
  level thread maps\mp\mp_zombie_nest_ee_util::func_50F3();
  thread lib_0562::func_00D5();
  thread maps\mp\mp_zombie_nest_ee_wave_manipulation::func_00F9();
  thread maps\mp\mp_zombie_nest_ee_hc_toy_arms::func_00F9();
  thread maps\mp\mp_zombie_nest_ee_hc_restore_pub_power::func_00F9();
  thread maps\mp\mp_zombie_nest_ee_hc_tools_of_the_trade::func_00F9();
  thread maps\mp\mp_zombie_nest_ee_hc_pub_fight::func_00F9();
  thread maps\mp\mp_zombie_nest_straub_appearances::func_00F9();
  thread maps\mp\mp_zombie_nest_ee_hc_true_voice::func_00F9();
  level thread lib_053D::func_00D5();
  level.var_6662 = common_scripts\utility::func_46B7("objective_testing_spawners", "targetname");
  level.var_6664 = common_scripts\utility::func_46B7("objective_testing_spawners_salt", "targetname");
  level.var_6663 = common_scripts\utility::func_46B7("objective_testing_spawners_com", "targetname");
  level.var_6661 = common_scripts\utility::func_46B7("objective_testing_spawners_blimp", "targetname");
}

func_7827() {
  common_scripts\utility::func_3799("collectible_armor_purchased");
  for(;;) {
    self waittill("perkmachine_activated", var_00);
    if(isDefined(var_00) && var_00.var_0109 == "armor") {
      break;
    }
  }

  common_scripts\utility::func_379A("collectible_armor_purchased");
}

func_5375() {
  lib_055A::func_530A("zone1_1_start", 1);
  lib_055A::func_530A("zone1_2_gallows", 0);
  lib_055A::func_530A("zone1_3_riverside", 0);
  lib_055A::func_530A("zone1_4_bridge", 0);
  lib_055A::func_530A("zone1_5_rooftops", 0);
  lib_055A::func_530A("zone1_4_bridge_tower", 0);
  lib_055A::func_530A("zone2_1_well", 0);
  lib_055A::func_530A("zone2_2_catacombs", 0);
  lib_055A::func_530A("zone3_1_com", 0);
  lib_055A::func_530A("zone3_2_med", 0);
  lib_055A::func_530A("zone3_3_rnd", 0);
  lib_055A::func_530A("zone4_1_mine", 0);
  lib_055A::func_530A("zone4_2_hilt", 0);
  lib_055A::func_0993("zone1_3_riverside", "zone1_1_start", "start_to_riverside");
  lib_055A::func_0993("zone1_1_start", "zone1_2_gallows", "start_to_gallows");
  lib_055A::func_0993("zone1_2_gallows", "zone1_3_riverside", "gallows_to_riverside");
  lib_055A::func_0993("zone1_4_bridge", "zone1_3_riverside", "riverside_to_bridge");
  lib_055A::func_0993("zone1_4_bridge", "zone1_1_start", "start_to_bridge");
  lib_055A::func_0993("zone1_4_bridge", "zone1_4_bridge_tower", "safe_haven_to_bridge");
  lib_055A::func_0993("zone1_2_gallows", "zone2_1_well", "gallows_to_well");
  lib_055A::func_0993("zone2_2_catacombs", "zone2_1_well", "well_to_underground");
  lib_055A::func_0993("zone2_2_catacombs", "zone1_3_riverside", "underground_to_riverside1");
  lib_055A::func_0993("zone1_5_rooftops", "zone1_3_riverside", "riverside_to_rooftops");
  lib_055A::func_0993("zone3_1_com", "zone1_2_gallows", "gallows_to_com");
  lib_055A::func_0993("zone3_1_com", "zone3_3_rnd", "com_to_rnd");
  lib_055A::func_0993("zone3_1_com", "zone3_2_med", "com_to_med");
  lib_055A::func_0993("zone3_2_med", "zone2_2_catacombs", "med_to_underground");
  lib_055A::func_0993("zone3_3_rnd", "zone1_5_rooftops", "activate_rooftops");
  lib_055A::func_0993("zone3_1_com", "zone4_1_mine", "com_to_mine");
  lib_055A::func_0993("zone3_3_rnd", "zone4_1_mine", "rnd_to_mine");
  lib_055A::func_0993("zone4_1_mine", "zone4_2_hilt", "activate_mine");
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_GALLOWS", "start_to_gallows", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_GALLOWS", "start_to_gallows", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_TWR", "safe_haven_to_bridge", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_TWR", "safe_haven_to_bridge", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_ENTRANCE", "start_to_riverside", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_RIVERSIDE", "start_to_riverside", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_GALLOWS", "gallows_to_riverside", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_RIVERSIDE", "gallows_to_riverside", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_ENTRANCE", "start_to_bridge", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_BRIDGE", "start_to_bridge", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_BRIDGE", "riverside_to_bridge", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_RIVERSIDE", "riverside_to_bridge", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_FIRE_WELL", "gallows_to_well", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_GALLOWS", "gallows_to_well", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_COM", "gallows_to_com", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_GALLOWS", "gallows_to_com", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_CATACOMBS", "underground_to_riverside1", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_RIVERSIDE", "underground_to_riverside1", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_CATACOMBS", "med_to_underground", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_MED", "med_to_underground", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_MED", "com_to_med", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_COM", "com_to_med", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_RND", "com_to_rnd", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_COM", "com_to_rnd", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_ROOFTOPS", "riverside_to_rooftops", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_RIVERSIDE", "riverside_to_rooftops", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_MINE", "com_to_mine", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_COM", "com_to_mine", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_MINE", "rnd_to_mine", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_RND", "rnd_to_mine", 1);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_CATACOMBS", "well_to_underground", 0);
  lib_053F::func_7BE6(&"ZOMBIE_NEST_DOOR_FIRE_WELL", "well_to_underground", 1);
  lib_0547::func_3C8A("com_to_rnd", "activate_rooftops");
  lib_0547::func_3C8A("riverside_to_rooftops", "activate_rooftops");
  lib_0547::func_3C8A("rnd_to_mine", "activate_rooftops");
  lib_0547::func_3C8A("com_to_mine", "activate_mine");
  lib_0547::func_3C8A("rnd_to_mine", "activate_mine");
  lib_055A::func_088A();
  common_scripts\utility::func_3C8F("flag_zone1_start");
  maps\mp\gametypes\zombies::func_0997("zone1", ::func_AC9A, ::func_AC90, ::func_AC97);
  maps\mp\gametypes\zombies::func_5294("zone1");
}

func_6B5B() {
  thread func_9CF8();
  level.var_7F22["normal"] = ::func_666A;
  level.var_7F22["zombie_dog"] = ::func_666A;
  level.var_7F18["normal"] = ::func_6669;
  lib_0547::remove_wallbuys_from_box();
}

func_666A() {
  var_00 = common_scripts\utility::func_7A33(level.var_744A);
  switch (level.var_A980) {
    case 5:
      wait(4);
      common_scripts\utility::func_0FB2(level.var_744A, ::lib_0367::func_8E3C, "sprinterflies");
      break;

    case 6:
      wait(3);
      var_00 thread lib_0367::func_8E3B("conv_wavedifficultyclue");
      break;

    case 9:
      wait(3);
      if(!lib_0557::func_783E("explore village", "Restore Bunker Door Power")) {
        thread lib_054E::func_7449("nag_stop_killing");
      }
      break;

    case 14:
      wait(3);
      if(lib_0557::func_783E("explore village", "Restore Bunker Door Power") && !lib_0557::func_783E("2 open salt mine", "use power machines")) {
        thread lib_054E::func_7449("nag_open_salt");
      }
      break;

    case 21:
      wait(3);
      if(lib_0557::func_783E("6B Left Hand overcharge", "activate left hand") && !lib_0557::func_783E("7 Voice paintings", "find code pieces")) {
        foreach(var_02 in level.var_744A) {
          if(!common_scripts\utility::func_3C77("flag_player_has_head")) {
            if(common_scripts\utility::func_3C77("flag_both_hints_seen")) {
              var_02 thread lib_0367::func_8E3C("firemanheadneed");
            }

            continue;
          }

          if(lib_057E::func_314D(var_02)) {
            break;
          }

          var_02 thread lib_0367::func_8E3C("firemanheadneed");
        }
      }
      break;
  }
}

func_531C() {
  wait 0.05;
  level.var_A62B lib_054E::func_AB1A("player", "general", "nag_open_salt", "nagopensaltmine", undefined);
}

func_6669() {
  if((common_scripts\utility::func_3C77("gallows_to_com") || common_scripts\utility::func_3C77("med_to_underground") || common_scripts\utility::func_3C77("riverside_to_rooftops")) && !lib_0557::func_783E("8A The Hilt", "Shoot Hilt")) {
    thread maps\mp\mp_zombie_nest_straub_appearances::func_74E2();
  }
}

func_6668(param_00) {
  if(self.var_0A4B != "zombie_generic") {
    return undefined;
  }

  if(isDefined(self.var_6250) && self.var_6250 > 0) {
    var_01 = lib_054D::func_443F("rageBuff");
    if(isDefined(var_01) && var_01.var_90F0 != 1) {
      var_01.var_90F0 = 1;
      self notify("speed_debuffs_changed");
    }

    return undefined;
  }

  if(!isDefined(self.var_A978)) {
    return undefined;
  }

  var_02 = lib_054D::func_4268();
  var_03 = 30;
  var_04 = 10;
  var_05 = 60;
  var_06 = 200;
  var_07 = var_03 * 1000;
  var_08 = var_04;
  var_09 = var_05;
  if(var_02 > var_06 && lib_0547::func_5565(self.var_0108, "sprint")) {
    lib_054D::func_099B("rageBuff", func_4641());
  }

  if(var_02 > var_09) {
    if(!isDefined(self.var_5B50)) {
      self.var_5B50 = gettime();
    }

    if(self.var_5B50 + var_07 <= gettime() && self.var_A978 + self.var_6480 + var_08 < 100) {
      self.var_5B50 = gettime();
      return self.var_6480 + var_08;
    }

    return undefined;
  }
}

func_4641() {
  var_00 = lib_054D::func_443F("rageBuff");
  if(!isDefined(var_00)) {
    var_00 = func_9094();
  }

  return var_00;
}

func_9094() {
  var_00 = 1.2;
  var_01 = spawnStruct();
  var_01.var_1CF2 = undefined;
  var_01.var_1CF0 = ::func_7CF6;
  var_01.var_90F0 = var_00;
  self notify("speed_debuffs_changed");
  return var_01;
}

func_7CF6(param_00) {
  param_00.var_90F0 = 1;
  self notify("speed_debuffs_changed");
}

func_6B91() {}

func_76D0(param_00) {
  if(!common_scripts\utility::func_562E(self.var_5525)) {
    return 0;
  }

  if(!lib_055A::func_AC29(param_00, "zone2_2_catacombs")) {
    return 0;
  }

  return 1;
}

func_3FD2(param_00) {
  waittillframeend;
  thread func_6B2D();
  thread func_8A19();
}

func_83FA(param_00, param_01) {
  setdvarifuninitialized(param_00, param_01);
  var_02 = param_01;
  for(;;) {
    var_03 = getdvarint(param_00, 0);
    if(var_03 != var_02) {
      switch (var_03) {
        case 0:
          var_04 = function_021F("switch", "targetname");
          foreach(var_06 in var_04) {
            wait(0.1);
            var_06 setscriptablepartstate("switchlights", "on");
          }
          break;

        case 1:
          var_04 = function_021F("switch", "targetname");
          foreach(var_06 in var_04) {
            wait(0.1);
            var_06 setscriptablepartstate("switchlights", "off");
          }
          break;

        case 2:
          var_04 = function_021F("switch", "targetname");
          foreach(var_06 in var_04) {
            wait(0.1);
            var_06 setscriptablepartstate("switchlights", "red");
          }
          break;
      }

      var_02 = var_03;
    }

    wait(0.2);
  }
}

func_6B2D() {
  var_00 = getEntArray("trig_oneway_grate_trigger", "targetname");
  common_scripts\utility::func_0FB2(var_00, ::func_6B2E);
}

func_6B2E() {
  var_00 = self;
  var_00.var_24A7 = getent(var_00.var_01A2, "targetname");
  var_01 = var_00.var_24A7.var_0116;
  var_02 = (150, 0, 0);
  for(;;) {
    var_00 waittill("trigger", var_03);
    var_00.var_24A7 moveto(var_00.var_24A7.var_0116 + var_02, 1);
    while(var_03 istouching(var_00)) {
      wait 0.05;
    }

    var_00.var_24A7 moveto(var_01, 0.5);
  }
}

func_AC9A() {
  level endon("zone1Cleanup");
  lib_055B::waittill_jumpscare_initialized();
  thread func_A557();
  thread func_3D8A();
  thread func_3284();
  thread func_1DA6();
  thread func_1DA9();
  thread func_2E8B();
  thread func_2EA0();
  thread func_2E9F();
  thread func_2E8A();
  thread func_2E77();
  thread func_2E94();
  thread func_2E90();
  thread func_2E89();
  thread func_2E95();
  thread func_2E93();
  thread func_3C0C();
  thread func_1CC8();
  maps\mp\gametypes\zombies::func_8028(0);
  wait(5);
}

func_9CF8() {
  level.var_9CFB = 1;
  level.var_62B5 = 1;
  maps\mp\zombies\_zombies_traps::func_7BD7("gj_zmb_drop_gate_switch_01", "gj_zmb_drop_gate_switch_01", "gj_zmb_drop_gate_switch_01", "gj_zmb_drop_gate_switch_01");
  thread maps\mp\zombies\_zombies_traps::func_9CC6("trap_rnd", "active", ::maps\mp\mp_zombie_nest_trap_rnd::func_9CC0);
  thread maps\mp\zombies\_zombies_traps::func_9CC6("trap_roof", "active", ::maps\mp\mp_zombie_nest_trap_betty::func_9C97);
  thread maps\mp\zombies\_zombies_traps::func_9CC6("trap_med", "active", ::maps\mp\mp_zombie_nest_trap_med::func_9CB8);
  thread maps\mp\zombies\_zombies_traps::func_9CC6("trap_catacombs", "active", ::maps\mp\mp_zombie_nest_trap_catacombs::func_9C9A);
  level thread func_9E92();
  maps\mp\zombies\_zombies_traps::func_9CC7("trap_rnd", &"ZOMBIE_NEST_RND_TRAP", &"ZOMBIES_TRAP_COOLDOWN", "rnd");
  maps\mp\zombies\_zombies_traps::func_9CC7("trap_roof", &"ZOMBIE_NEST_BETTY_TRAP", &"ZOMBIES_TRAP_COOLDOWN", "betty");
  maps\mp\zombies\_zombies_traps::func_9CC7("trap_med", &"ZOMBIE_NEST_MED_TRAP", &"ZOMBIES_TRAP_COOLDOWN", "med");
  maps\mp\zombies\_zombies_traps::func_9CC7("trap_catacombs", &"ZOMBIE_NEST_CATACOMBS_TRAP", &"ZOMBIES_TRAP_COOLDOWN", "catacombs");
}

func_9E92() {
  level waittill("firewell_machinery_ready");
  var_00 = common_scripts\utility::func_46B5("trap_firewell", "script_noteworthy");
  var_00 func_52E1();
  var_00 thread maps\mp\zombies\_zombies_traps::func_9CAF(1, var_00.var_9DC2, var_00.var_3F4E, var_00.var_9CBA);
  thread maps\mp\zombies\_zombies_traps::func_9CC6("trap_firewell", "active", ::maps\mp\mp_zombie_nest_trap_firewell::func_9CAA);
  maps\mp\zombies\_zombies_traps::func_9CC7("trap_firewell", &"ZOMBIE_NEST_WELL_TRAP", &"ZOMBIES_TRAP_COOLDOWN", "firewell");
}

func_52E1() {
  self.var_9DC2 = [];
  self.var_9CBA = [];
  self.var_3F4E = [];
  var_00 = common_scripts\utility::func_44BE(self.var_01A2, "targetname");
  foreach(var_02 in var_00) {
    if(!isDefined(var_02.var_0165)) {
      continue;
    }

    switch (var_02.var_0165) {
      case "activate_model":
        self.var_9CBA = common_scripts\utility::func_0F6F(self.var_9CBA, var_02);
        break;

      case "activate":
        self.var_9DC2 = common_scripts\utility::func_0F6F(self.var_9DC2, var_02);
        break;

      case "fx_ready":
        self.var_3F4E = common_scripts\utility::func_0F6F(self.var_3F4E, var_02);
        break;

      default:
        break;
    }
  }

  var_04 = common_scripts\utility::func_46B5("zmb_flamethrower_trap_light", "script_noteworthy");
  var_05 = getent("pilot_light_trigger", "targetname");
  self.var_3F4E = common_scripts\utility::func_0F6F(self.var_3F4E, var_04);
  self.var_9DC2 = common_scripts\utility::func_0F6F(self.var_9DC2, var_05);
}

func_2E9F() {
  var_00 = getEntArray("trig_elec_gate_dialog_gen", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread func_2EA2();
  }

  while(!common_scripts\utility::func_3C83("power_sz2")) {
    wait(1);
  }

  common_scripts\utility::func_3C9F("power_sz2");
  foreach(var_02 in var_00) {
    var_02 delete();
  }
}

func_2EA2() {
  level endon("power_sz2");
  for(;;) {
    self waittill("trigger", var_00);
    if(!isPlayer(var_00)) {
      wait(0.5);
      continue;
    }

    if(!common_scripts\utility::func_562E(var_00.var_306E)) {
      var_01 = var_00 lib_0367::func_8E3D("electricgate2");
      if(isDefined(var_01)) {
        var_00.var_306E = 1;
      }
    }
  }
}

func_2EA0() {
  var_00 = getEntArray("electric_gate_dialogue", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread func_2EA1();
  }

  while(!common_scripts\utility::func_3C83("power_sz2")) {
    wait(1);
  }

  common_scripts\utility::func_3C9F("power_sz2");
  foreach(var_02 in var_00) {
    var_02 delete();
  }
}

func_2EA1() {
  level endon("power_sz2");
  for(;;) {
    self waittill("trigger", var_00);
    if(!isPlayer(var_00)) {
      wait(0.5);
      continue;
    }

    if(!common_scripts\utility::func_562E(var_00.var_306D)) {
      var_01 = var_00 lib_0367::func_8E3D("electricgate");
      if(isDefined(var_01)) {
        var_00.var_306D = 1;
      }
    }
  }
}

func_2E8B() {
  level endon("power_sz2");
  var_00 = getent("generator_sign_dialogue", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(!isDefined(var_01.var_3069) && isPlayer(var_01)) {
      var_01 thread lib_0367::func_8E3C("seegenerator");
      var_01.var_3069 = 1;
    }
  }
}

func_2E8A() {
  level endon("power_sz2");
  var_00 = getent("fuel_tank_dialogue", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  for(;;) {
    var_00 waittill("trigger", var_01);
    if(!isDefined(var_01.var_3068) && isPlayer(var_01)) {
      var_01 thread lib_0367::func_8E3C("firewellexamine");
      var_01.var_3068 = 1;
    }
  }
}

func_2E77() {
  level endon("power_sz2");
  var_00 = getent("bunker_ent_dialogue", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  var_01 = [];
  for(;;) {
    var_00 waittill("trigger", var_02);
    if(!isPlayer(var_02)) {
      wait(0.5);
      continue;
    } else if(!common_scripts\utility::func_0F79(var_01, var_02)) {
      if(isDefined(var_02.var_3069)) {
        var_01 = common_scripts\utility::func_0F6F(var_01, var_02);
        continue;
      }

      var_03 = var_02 lib_0367::func_8E3D("saltminedoor");
      if(isDefined(var_03)) {
        var_01 = common_scripts\utility::func_0F6F(var_01, var_02);
      }

      var_04 = 1;
      foreach(var_06 in level.var_744A) {
        if(!common_scripts\utility::func_0F79(var_01, var_06)) {
          var_04 = 0;
        }
      }

      if(var_04) {
        break;
      }
    }
  }

  var_00 delete();
}

func_2E99(param_00) {
  if(!isDefined(param_00.var_3062)) {
    param_00 thread lib_0367::func_8E3C("firstearthquake");
    param_00.var_3062 = 1;
  }
}

func_2E94() {
  wait(5);
  foreach(var_01 in level.var_744A) {
    var_01 thread lib_0367::func_8E3C("villageintro");
  }
}

func_2E87() {
  level endon("start_to_gallows");
  for(;;) {
    if(isDefined(level.var_AC1D)) {
      break;
    } else {
      wait(0.25);
    }
  }

  var_00 = lib_053F::func_44A6("start_to_gallows");
}

func_2E90() {
  level endon("flag_ww_part_02_picked_up");
  var_00 = function_021F("med_untotenpresse_smasher", "targetname");
  if(isDefined(var_00)) {
    childthread maps\mp\mp_zombie_nest_ee_util::func_720B("conv_juicerintro", var_00[0].var_0116, 250, 50);
  }
}

func_2E89() {
  level endon("flag_ww_part_01_picked_up");
  var_00 = getent("trig_see_forge", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  var_01 = [];
  for(;;) {
    var_00 waittill("trigger", var_02);
    if(!isPlayer(var_02)) {
      wait(0.5);
      continue;
    } else if(!common_scripts\utility::func_0F79(var_01, var_02)) {
      var_03 = var_02 lib_0367::func_8E3D("forgestartup2");
      if(isDefined(var_03)) {
        var_01 = common_scripts\utility::func_0F6F(var_01, var_02);
      }

      var_04 = 1;
      foreach(var_06 in level.var_744A) {
        if(!common_scripts\utility::func_0F79(var_01, var_06)) {
          var_04 = 0;
        }
      }

      if(var_04) {
        break;
      }
    }
  }

  var_00 delete();
}

func_2E95() {
  level endon("flag_ww_forged");
  var_00 = getent("trig_see_med_office", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  var_01 = [];
  for(;;) {
    var_00 waittill("trigger", var_02);
    if(!isPlayer(var_02)) {
      wait(0.5);
      continue;
    } else if(!common_scripts\utility::func_0F79(var_01, var_02)) {
      var_03 = var_02 lib_0367::func_8E3D("medofficereaction");
      if(isDefined(var_03)) {
        var_01 = common_scripts\utility::func_0F6F(var_01, var_02);
      }

      var_04 = 1;
      foreach(var_06 in level.var_744A) {
        if(!common_scripts\utility::func_0F79(var_01, var_06)) {
          var_04 = 0;
        }
      }

      if(var_04) {
        break;
      }
    }
  }

  var_00 delete();
}

func_2E93() {
  level endon("flag_correct_code_entered");
  var_00 = getent("trig_enter_klaus_office", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  for(;;) {
    var_00 waittill("trigger", var_01);
    if(isPlayer(var_01)) {
      break;
    }

    wait(0.5);
  }

  var_01 thread lib_0367::func_8E3B("conv_klausroom");
  var_00 delete();
}

func_3C0C() {
  common_scripts\utility::func_3C87("flag_vo_fireman_head_spotted");
  lib_0547::func_7BA9(::func_3C0B);
}

func_3C0B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(self.var_0A4B == "zombie_fireman") {
    if(isDefined(param_01)) {
      if(isPlayer(param_01) && !common_scripts\utility::func_3C77("flag_vo_fireman_head_spotted")) {
        param_01 thread lib_0367::func_8E3C("firemankilled");
        common_scripts\utility::func_3C8F("flag_vo_fireman_head_spotted");
        lib_0547::func_2D8C(::func_3C0B);
        return;
      }
    }
  }
}

func_A557() {
  var_00 = getEntArray("sewage_jumpscare", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread lib_055B::func_8A74();
  }

  while(!common_scripts\utility::func_3C83("fire trap active")) {
    wait(1);
  }

  common_scripts\utility::func_3C9F("fire trap active");
  foreach(var_02 in var_00) {
    var_02 notify("end_jumpscare");
  }
}

func_3D8A() {
  var_00 = getEntArray("floor_burst_jumpscare", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread lib_055B::func_3D86();
  }
}

func_3284() {
  var_00 = getEntArray("door_burst_jumpscare", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread lib_055B::func_3266();
  }
}

func_1DA6() {
  var_00 = getEntArray("drop_jumpscare", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread lib_055B::func_1D91();
  }
}

func_1DA9() {
  var_00 = getEntArray("bunker_window_jumpscare", "targetname");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_81A1)) {
      var_02 thread func_1706(var_02.var_81A1);
      continue;
    }

    var_02 thread lib_055B::func_1DA1();
  }
}

func_1706(param_00) {
  common_scripts\utility::func_3C9F(param_00);
  thread lib_055B::func_1DA1();
}

func_8A19() {
  var_00 = 0;
  for(;;) {
    level waittill("zombie_wave_started");
    if(level.var_A980 >= 3 && var_00 == 0) {
      thread func_AC91();
      var_00 = 1;
    }
  }
}

func_AC91() {
  var_00 = 60 * randomfloatrange(1, 2);
  level.var_6F18 = 0;
  for(;;) {
    wait(var_00);
    var_00 = 60 * randomfloatrange(1, 10);
    if(level.var_6F18 || common_scripts\utility::func_3C77("flag_bunker_lights_off")) {
      continue;
    }

    level notify("zone1EarthquakeBegin");
    var_01 = randomfloatrange(3, 5);
    var_02 = randomfloatrange(3, 5);
    var_03 = randomfloatrange(3, 5);
    var_04 = randomfloatrange(4, 8);
    lib_0378::func_8D74("zone1Earthquake", "rumble1", var_01);
    wait(var_01);
    lib_0378::func_8D74("zone1Earthquake", "rumble2", var_02);
    wait(var_02);
    lib_0378::func_8D74("zone1Earthquake", "rumble3", var_03);
    wait(var_03);
    lib_0378::func_8D74("zone1Earthquake", "earthquake", var_04);
    thread func_353F(var_04);
    if(!common_scripts\utility::func_3C77("flag_bunker_lights_off")) {
      thread func_3541(var_04);
    }

    var_05 = maps\mp\mp_zombie_nest_ee_util::func_4649();
    if(isDefined(var_05)) {
      level thread func_3254(var_04, var_05);
    }

    level thread common_scripts\_exploder::func_088E(207);
    wait(var_04);
    level notify("zone1EarthquakeEnd");
  }
}

func_3541(param_00) {
  var_01 = function_021F("light_zm_objective", "targetname");
  foreach(var_03 in var_01) {
    wait 0.05;
    var_03.var_6C56 = var_03 getscriptablepartstate("puzzlelight");
  }

  foreach(var_03 in var_01) {
    wait 0.05;
    var_03 setscriptablepartstate("puzzlelight", "cycle1a");
  }

  wait(0.1);
  foreach(var_03 in var_01) {
    wait 0.05;
    if(isDefined(var_03.var_6C56)) {
      var_03 setscriptablepartstate("puzzlelight", var_03.var_6C56);
    }
  }
}

func_353F(param_00) {
  wait 0.05;
  param_00 = param_00 - 0.05;
  param_00 = param_00 * 0.7;
  var_01 = 4;
  for(var_02 = 0; var_02 < var_01; var_02++) {
    func_3540();
    wait(param_00 / var_01);
  }
}

func_3540() {
  foreach(var_01 in level.var_744A) {
    var_02 = undefined;
    var_03 = undefined;
    var_04 = function_032F();
    for(var_05 = 0; var_05 < var_04; var_05++) {
      if(function_01CB(var_05)) {
        continue;
      }

      var_06 = getglassorigin(var_05);
      var_07 = common_scripts\utility::func_5D93(distance(var_06, var_01.var_0116), 0, -15536, 1, 0);
      var_08 = vectordot(anglesToForward(var_01.var_001D), var_06 - var_01.var_0116);
      var_09 = common_scripts\utility::func_5D93(var_08, 0.5, 1, 0, 1);
      var_0A = var_07 * var_09 * 3 + randomfloat(0.2);
      if(!isDefined(var_03) || var_0A > var_03) {
        var_02 = var_05;
        var_03 = var_0A;
      }
    }

    if(isDefined(var_02)) {
      var_0B = vectornormalize(vectornormalize(var_01.var_0116 - getglassorigin(var_02)) + common_scripts\utility::func_7A5F(0.3));
      destroyglass(var_02, var_0B);
    }
  }
}

func_3254(param_00, param_01) {
  earthquake(0.3, param_00, param_01.var_0116, 850, param_01);
  function_01BC("tank_rumble", param_01.var_0116);
  thread func_2E99(param_01);
  wait(param_00);
  function_01BD();
}

func_34B6() {
  for(;;) {
    level waittill("zombie_wave_started");
    if(!isDefined(level.var_A980) || level.var_A980 % 5 != 0) {
      continue;
    }

    common_scripts\utility::func_3C8F("sky_rush");
    lib_055A::func_8712(1, "sky_rush_event");
    level waittill("zombie_wave_ended");
    common_scripts\utility::func_3C7B("sky_rush");
    lib_055A::func_8712(0, "sky_rush_event");
  }
}

func_AC90() {}

func_AC97() {}

func_1CC8() {
  wait(1);
  level thread common_scripts\_exploder::func_088E(238);
}

func_5CB9() {}

func_7EAC() {
  common_scripts\utility::func_3C9F("gallows_to_riverside");
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_819A) && var_01.var_819A == "gallows_to_riverside" && !isDefined(var_01.var_6BE1) || !var_01.var_6BE1) {
      var_01 notify("open", undefined);
    }
  }
}

func_2033() {
  common_scripts\utility::func_3C9F("underground_to_riverside1");
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_819A) && var_01.var_819A == "underground_to_riverside1" && !isDefined(var_01.var_6BE1) || !var_01.var_6BE1) {
      var_01 notify("open", undefined);
    }
  }
}

func_1D8F() {
  var_00 = common_scripts\utility::func_46B7("bunker_door_indicator", "targetname");
  common_scripts\utility::func_0FB2(var_00, ::maps\mp\mp_zombie_nest_ee_util::func_A16D, "red");
  common_scripts\utility::func_3C9F("gallows_to_com");
  common_scripts\utility::func_0FB2(var_00, ::maps\mp\mp_zombie_nest_ee_util::func_A16D, "green");
}

func_3C23() {
  for(;;) {
    if(common_scripts\utility::func_3C83("power_sz2")) {
      break;
    } else {
      wait(1);
    }
  }

  common_scripts\utility::func_3C9F("power_sz2");
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_819A) && var_01.var_819A == "gallows_to_well" && !isDefined(var_01.var_6BE1) || !var_01.var_6BE1) {
      var_01 notify("open", undefined);
    }
  }
}

func_742E() {
  self endon("disconnect");
  for(;;) {
    common_scripts\utility::func_A70A("new_wallbuy_weapon", "new_equipment");
    var_00 = 0;
    if(common_scripts\utility::func_24A6()) {
      var_00 = 1;
    }

    if(var_00) {
      wait(1);
      thread lib_0367::func_8E3C("newweapon");
    }
  }
}

func_3DCE() {
  lib_055B::func_3DB1();
  common_scripts\utility::func_3CA2("com_to_rnd", "activate_rooftops", "rnd_to_mine");
  var_00 = lib_055B::func_3DB0();
  foreach(var_02 in var_00) {
    var_02 thread lib_055B::func_3DB3();
  }

  thread func_3DCC();
  thread func_3DCD();
  common_scripts\utility::func_3C9F("flag_fol_inc_armed");
  foreach(var_02 in var_00) {
    var_02.var_5971 = 1;
  }

  lib_0557::func_7870("4 cart", "head to rnd");
  if(!common_scripts\utility::func_3C77("flag_first_fol_inc_selected")) {
    foreach(var_02 in var_00) {
      if(isDefined(var_02.var_81E1) && var_02.var_81E1 == 0) {
        var_02 thread lib_055B::func_3DAE();
      }
    }
  }
}

func_3DCD() {
  for(;;) {
    level waittill("zombie_wave_started");
    if(level.var_A980 >= 8) {
      break;
    }
  }

  if(common_scripts\utility::func_3C77("flag_fol_inc_armed")) {
    return;
  }

  common_scripts\utility::func_3C8F("flag_fol_inc_armed");
  var_00 = lib_055B::func_3DAF();
  foreach(var_02 in var_00) {
    var_02 thread lib_055B::func_3DAD();
  }
}

func_3DCC() {
  lib_0557::func_7870("4 cart", "press button");
  if(common_scripts\utility::func_3C77("flag_fol_inc_armed")) {
    return;
  }

  common_scripts\utility::func_3C8F("flag_fol_inc_armed");
  var_00 = lib_055B::func_3DAF();
  foreach(var_02 in var_00) {
    var_02 thread lib_055B::func_3DAD();
  }
}

func_18DE() {
  while(!common_scripts\utility::func_3C83("flag_rnd_enigma_set")) {
    wait(1);
  }

  common_scripts\utility::func_3CA0("flag_rnd_enigma_set", "flag_med_enigma_set");
  common_scripts\utility::func_3CA2("com_to_mine", "rnd_to_mine");
  var_00 = common_scripts\utility::func_46B7("bomber_intro_mine_spawn", "targetname");
  foreach(var_02 in var_00) {
    var_03 = lib_054D::func_90BA("zombie_exploder", var_02, "intro bombers", 0, 1, 0, undefined, 0);
    var_03 lib_0547::func_84CB();
  }
}

func_18DF() {
  for(;;) {
    self waittill("trigger", var_00);
    if(isPlayer(var_00)) {
      break;
    }

    wait(0.5);
  }

  var_01 = common_scripts\utility::func_46B7(self.var_01A2, "targetname");
  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_0165) && var_03.var_0165 == "zombie_sky_spawner") {
      var_03.var_8C95 = 1;
    }

    var_04 = lib_054D::func_90BA("zombie_exploder", var_03, "intro bombers", 0, 1, 0, undefined, 0);
  }
}

func_3BF9() {
  var_00 = common_scripts\utility::func_46B5("first_fireman_spawner_default", "targetname");
  var_01 = common_scripts\utility::func_46B5("first_fireman_spawner_fallback", "targetname");
  while(!common_scripts\utility::func_3C83("flag_ww_part_02_picked_up")) {
    wait(1);
  }

  common_scripts\utility::func_3C9F("flag_ww_part_02_picked_up");
  if(!level.var_3BFE > 0) {
    var_02 = 0;
    foreach(var_04 in level.var_744A) {
      if(lib_055A::func_7413(var_04, "zone3_1_com")) {
        var_02 = 1;
        var_00 = var_01;
        break;
      }
    }

    if(!var_02) {
      lib_0378::func_8D74("fireman_intro_scream", var_00.var_0116);
    }

    if(!var_02) {
      var_06 = getEntArray("fireman_intro_trig", "targetname");
      foreach(var_08 in var_06) {
        var_08 thread func_3BFA();
      }

      level waittill("com_entered_by_player", var_0A);
      thread func_3BF6();
      var_0B = lib_0564::func_3C11(0, var_00, 0);
      var_0B func_3BF7(var_00);
      return;
    }

    var_0B = lib_0564::func_3C11(0, var_00);
  }
}

func_3BF6() {
  var_00 = common_scripts\utility::func_46B7("fireman_intro_explosion", "script_noteworthy");
  var_01 = var_00[0].var_0116;
  lib_0378::func_8D74("well_explosion", var_01);
  lib_0378::func_8D74("fireman_intro_scream", var_01);
  lib_0378::func_8D74("aud_fireman_fire_emitters", var_01);
  level thread common_scripts\_exploder::func_088E(215);
  foreach(var_03 in var_00) {
    earthquake(0.3, 4, var_03.var_0116, 850);
    wait(0.4);
  }

  thread func_6E18();
}

func_6E18() {
  var_00 = getent("move_cart_button_console", "targetname");
  playFXOnTag(level.var_0611["zmb_com_room_fire_panel"], var_00, "tag_origin");
  wait(18);
  stopFXOnTag(level.var_0611["zmb_com_room_fire_panel"], var_00, "tag_origin");
}

func_3BF7(param_00) {
  var_01 = common_scripts\utility::func_46B5("first_fireman_flame_point", "targetname");
  if(!isDefined(var_01)) {
    return;
  }

  self.var_00CA = 1;
  self.var_5748 = 1;
  self.var_57E8 = 1;
  lib_053C::func_06CE(var_01.var_0116);
  var_02 = gettime();
  var_03 = 0;
  for(;;) {
    var_04 = gettime();
    if(var_04 > var_02 + 5000) {
      var_03 = 1;
      break;
    }

    if(distance(self.var_0116, var_01.var_0116) > 16) {
      wait(0.1);
      continue;
    }

    break;
  }

  if(!var_03) {
    self scragentsetscripted(1);
    self method_839C("anim deltas");
    self scragentsetorientmode("face angle abs", var_01.var_001D, var_01.var_001D);
    maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "firemanintro");
    thread func_3BF5();
    var_05 = common_scripts\utility::func_A715("fireman_intro_finished", "damage");
    if(var_05 == "damage") {
      stopFXOnTag(level.var_0611["zombie_fireman_flamethrower_expensive"], self, "tag_flamethrower_fx");
      lib_0378::func_8D74("flamethrower_stop", "tag_flamethrower_fx");
    }

    maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "firemanintro");
    self scragentsetscripted(0);
  }

  var_06 = common_scripts\utility::func_46B5("first_fireman_end_point", "targetname");
  if(isDefined(var_06)) {
    lib_053C::func_06CE(var_06.var_0116);
    for(;;) {
      if(distance(self.var_0116, var_06.var_0116) > 16) {
        wait(0.1);
        continue;
      }

      break;
    }
  }

  self.var_00CA = 0;
  self.var_5748 = 0;
  self.var_57E8 = 0;
  self method_855C();
}

func_3BF5() {
  self endon("damage");
  maps\mp\agents\_scripted_agent_anim_util::func_8415("s2_fireman_intro_flame", 0, 1);
  wait(2.333333);
  playFXOnTag(level.var_0611["zombie_fireman_flamethrower_expensive"], self, "tag_flamethrower_fx");
  lib_0378::func_8D74("flamethrower_start", "tag_flamethrower_fx");
  wait(2.666667);
  stopFXOnTag(level.var_0611["zombie_fireman_flamethrower_expensive"], self, "tag_flamethrower_fx");
  lib_0378::func_8D74("flamethrower_stop", "tag_flamethrower_fx");
  wait(0.3333333);
  self notify("fireman_intro_finished");
}

func_3BFC() {
  var_00 = function_021F("fireman_intro", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("heat", "enable");
  }

  wait(2.3);
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("heat", "die");
  }
}

func_3BFA() {
  level endon("com_entered_by_player");
  for(;;) {
    self waittill("trigger", var_00);
    if(isPlayer(var_00)) {
      level notify("com_entered_by_player", var_00);
      break;
    }

    wait(0.5);
  }
}

func_347A() {
  var_00 = getent("disable_clocktower_jumpscare", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(isPlayer(var_01) && level.var_2F29 == 0) {
      level.var_2F29 = 1;
    }
  }
}

func_666B() {
  var_00 = 1000000;
  var_01 = lib_0547::func_4282(self);
  var_02 = var_01["ignoreBlimp"];
  if(common_scripts\utility::func_562E(var_02)) {
    return 1;
  }

  if(isDefined(level.var_179A) && distance2dsquared(self.var_0116, level.var_179A.var_0116) < var_00) {
    return 1;
  }

  return 0;
}

func_4D48(param_00) {
  common_scripts\utility::func_A70B(param_00.var_3678, "open");
  level notify("disable_initial_door_highlight");
  if(isDefined(param_00.var_5E61)) {
    param_00.var_5E61 hudoutlinedisable();
    param_00.var_5E61 delete();
  }
}

func_4D49(param_00) {
  level endon("disable_initial_door_highlight");
  var_01 = self;
  while(param_00.var_3290.size) {
    var_01 waittill("money_update");
    foreach(var_03 in param_00.var_3290) {
      if(var_01.var_62D6 < var_03.var_267B) {
        if(isDefined(param_00.var_5E61) && common_scripts\utility::func_562E(param_00.var_5E61.var_5594)) {
          param_00.var_5E61.var_5594 = 0;
          param_00.var_5E61 hudoutlinedisableforclient(var_01);
        }

        continue;
      }

      if(isDefined(param_00.var_5E61) && !common_scripts\utility::func_562E(param_00.var_5E61.var_5594)) {
        param_00.var_5E61 hudoutlineenableforclient(var_01, 0, 0);
        param_00.var_5E61.var_5594 = 1;
      }
    }
  }
}

func_415E(param_00) {
  var_01 = [];
  while(!isDefined(level.var_AC1D)) {
    wait 0.05;
  }

  foreach(var_03 in level.var_AC1D) {
    if(!isDefined(var_03.var_819A) || !common_scripts\utility::func_0F79(param_00, var_03.var_819A)) {
      continue;
    }

    var_01 = common_scripts\utility::func_0F6F(var_01, var_03);
  }

  return var_01;
}

func_4D47() {
  var_00 = func_415E(["start_to_gallows"]);
  var_01 = getent("first_door_lock", "targetname");
  var_02 = func_415E(["start_to_bridge", "start_to_gallows", "start_to_riverside"]);
  var_03 = spawnStruct();
  var_03.var_3290 = var_00;
  var_03.var_5E61 = var_01;
  var_03.var_3678 = var_02;
  level thread func_4D48(var_03);
  level endon("disable_initial_door_highlight");
  level childthread maps\mp\_utility::func_6F74(::func_4D49, var_03);
}