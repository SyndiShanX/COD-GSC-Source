/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_01.gsc
*************************************************/

main() {
  level._id_AC31 = 0;
  level._id_0C19 = 0;
  level._id_AC2E = 2;
  _id_04BF::main();
  _id_0426::main();
  _id_04BE::main();

  if(getDvar("233") == "1")
    _id_6B91();

  _id_0483::main();
  maps\mp\mp_zombie_nest_01_lighting::main();
  maps\mp\mp_zombie_nest_01_aud::main();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  setDvar("1520", "-1 -1 -1 5");
  setDvar("2494", "0.12, 0, 0");
  common_scripts\utility::flag_init("flag_zone1_start");
  common_scripts\utility::flag_init("flag_jumpscare_trigger");
  common_scripts\utility::flag_init("flag_generator_grate_look");
  common_scripts\utility::flag_init("flag_fuse_pickedup");
  common_scripts\utility::flag_init("flag_bunker_lights_off");
  _id_055A::init();
  level._id_8C96 = ::_id_666B;
  _id_0496::init();
  _id_5339();
  maps\mp\mp_zombie_falldamage_modifier::main();
  maps\mp\mp_zombie_nest_pneumos::main();
  thread _id_0551::_id_3D50(0);
  _id_5375();
  level thread _id_531C();
  thread _id_0544::init();
  thread _id_055D::init();
  thread _id_347A();
  level._id_ABD3 = 0;
  level._id_324B = ::_id_76D0;
  level._id_AC71 = ::_id_531D;
  level._id_AC72 = ::_id_6B5A;
  level._id_6BB0 = ::_id_6B5B;
  level._id_AC2F = ::_id_531E;

  if(1)
    level._id_64B6 = ::_id_6668;

  thread _id_3FD2();
  thread maps\mp\mp_zombie_nest_pneumos::_id_2037();
  thread _id_83FA("bunker_light_switch", 0);
  thread _id_7EAC();
  thread _id_2033();
  thread _id_1D8F();
  thread _id_3C23();
  level._id_0C11 = 0;
  thread maps\mp\_utility::_id_6F74(maps\mp\mp_zombie_nest_ee_util::_id_73B8);
  thread maps\mp\_utility::_id_6F74(::_id_742E);
  thread _id_3BF9();
  thread _id_3DCE();
  thread _id_18DE();
  level thread maps\mp\zquests\dlc1_secrets_mp_zombie_nest_01::init_dlc1_secrets_mp_zombie_nest_01();

  if(maps\mp\_utility::isproductionlevelactive(10))
    level thread maps\mp\zombies\_zombies_lo_events::init_zm_lo_events();

  _id_0565::_id_7C07("raven_set");
  _id_0565::_id_7C07("treasure_set");
  _id_0565::_id_7C07("assassin_set");
  _id_0565::_id_7C07("survivalist_set");
  _id_0565::_id_7C07("mountain_man_set");
  _id_0565::_id_7C07("bat_elite_set");
  thread _id_4D47();
  level thread _id_0557::manage_mtx5_event();
}

_id_531E() {
  _id_055F::init();
  _id_0568::init();
  _id_0564::_id_3BFB(1);
}

_id_531D() {
  thread _id_057D::_id_5162();
  _id_0580::init();
  _id_057E::_id_51CF();
  _id_057F::init();
}

_id_6B5A() {
  thread _id_0548::_id_A7D9();
}

_id_AA3C() {
  if(!0) {
    var_0 = getEntArray("zbarrier_window", "script_noteworthy");

    foreach(var_2 in var_0)
    var_2 _meth_80B3();
  }
}

_id_5339() {
  _id_0557::_id_786C();
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_fire_well::_id_418E());
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_fire_well::_id_40E8());
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_enigma::_id_430C());
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_cart::_id_43E8());
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_cart::_id_43E9());
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_cart::_id_43E7());
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_fuses::_id_4303());
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_overcharge::_id_41E7());
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_paintings::_id_43CC());
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_overcharge::_id_40C0(1));
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_overcharge::_id_40C0(2));
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_overcharge::_id_40C0(3));
  _id_0557::_id_AB8D("collectible_armor_purchased");
  level thread maps\mp\_utility::_id_6F74(::_id_7827);
  _id_0557::_id_AB8D(_id_0569::_id_42A5());
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_final_boss::_id_40E2());
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_hc_toy_arms::_id_40AC(1));
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_hc_toy_arms::_id_40AC(2));
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_hc_toy_arms::_id_40AC(3));
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_hc_toy_arms::_id_42F3());
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::_id_42ED("blood"));
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::_id_42ED("moon"));
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::_id_42ED("death"));
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::_id_42ED("storm"));
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_hc_tools_of_the_trade::_id_42EF());
  _id_0557::_id_AB8C(maps\mp\mp_zombie_nest_ee_hc_true_voice::_id_42EE());
  thread maps\mp\mp_zombie_nest_ee_fire_well::main();
  thread maps\mp\mp_zombie_nest_ee_enigma::main();
  thread maps\mp\mp_zombie_nest_ee_cart::main();
  thread maps\mp\mp_zombie_nest_ee_shard::main();
  thread maps\mp\mp_zombie_nest_ee_fuses::main();
  thread maps\mp\mp_zombie_nest_ee_tower_battle::main();
  thread maps\mp\mp_zombie_nest_ee_overcharge::main();
  thread maps\mp\mp_zombie_nest_ee_paintings::main();
  thread maps\mp\mp_zombie_nest_ee_boss_blimp::main();
  thread _id_0560::init();
  thread maps\mp\mp_zombie_nest_ee_final_boss::main();
  thread maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::main();
  level thread maps\mp\mp_zombie_nest_ee_util::_id_50F3();
  thread _id_0562::init();
  thread maps\mp\mp_zombie_nest_ee_wave_manipulation::main();
  thread maps\mp\mp_zombie_nest_ee_hc_toy_arms::main();
  thread maps\mp\mp_zombie_nest_ee_hc_restore_pub_power::main();
  thread maps\mp\mp_zombie_nest_ee_hc_tools_of_the_trade::main();
  thread maps\mp\mp_zombie_nest_ee_hc_pub_fight::main();
  thread maps\mp\mp_zombie_nest_straub_appearances::main();
  thread maps\mp\mp_zombie_nest_ee_hc_true_voice::main();
  level thread _id_053D::init();
  level._id_6662 = common_scripts\utility::_id_46B7("objective_testing_spawners", "targetname");
  level._id_6664 = common_scripts\utility::_id_46B7("objective_testing_spawners_salt", "targetname");
  level._id_6663 = common_scripts\utility::_id_46B7("objective_testing_spawners_com", "targetname");
  level._id_6661 = common_scripts\utility::_id_46B7("objective_testing_spawners_blimp", "targetname");
}

_id_7827() {
  common_scripts\utility::_id_3799("collectible_armor_purchased");

  for(;;) {
    self waittill("perkmachine_activated", var_0);

    if(isDefined(var_0) && var_0.name == "armor") {
      break;
    }
  }

  common_scripts\utility::_id_379A("collectible_armor_purchased");
}

_id_5375() {
  _id_055A::_id_530A("zone1_1_start", 1);
  _id_055A::_id_530A("zone1_2_gallows", 0);
  _id_055A::_id_530A("zone1_3_riverside", 0);
  _id_055A::_id_530A("zone1_4_bridge", 0);
  _id_055A::_id_530A("zone1_5_rooftops", 0);
  _id_055A::_id_530A("zone1_4_bridge_tower", 0);
  _id_055A::_id_530A("zone2_1_well", 0);
  _id_055A::_id_530A("zone2_2_catacombs", 0);
  _id_055A::_id_530A("zone3_1_com", 0);
  _id_055A::_id_530A("zone3_2_med", 0);
  _id_055A::_id_530A("zone3_3_rnd", 0);
  _id_055A::_id_530A("zone4_1_mine", 0);
  _id_055A::_id_530A("zone4_2_hilt", 0);
  _id_055A::_id_0993("zone1_3_riverside", "zone1_1_start", "start_to_riverside");
  _id_055A::_id_0993("zone1_1_start", "zone1_2_gallows", "start_to_gallows");
  _id_055A::_id_0993("zone1_2_gallows", "zone1_3_riverside", "gallows_to_riverside");
  _id_055A::_id_0993("zone1_4_bridge", "zone1_3_riverside", "riverside_to_bridge");
  _id_055A::_id_0993("zone1_4_bridge", "zone1_1_start", "start_to_bridge");
  _id_055A::_id_0993("zone1_4_bridge", "zone1_4_bridge_tower", "safe_haven_to_bridge");
  _id_055A::_id_0993("zone1_2_gallows", "zone2_1_well", "gallows_to_well");
  _id_055A::_id_0993("zone2_2_catacombs", "zone2_1_well", "well_to_underground");
  _id_055A::_id_0993("zone2_2_catacombs", "zone1_3_riverside", "underground_to_riverside1");
  _id_055A::_id_0993("zone1_5_rooftops", "zone1_3_riverside", "riverside_to_rooftops");
  _id_055A::_id_0993("zone3_1_com", "zone1_2_gallows", "gallows_to_com");
  _id_055A::_id_0993("zone3_1_com", "zone3_3_rnd", "com_to_rnd");
  _id_055A::_id_0993("zone3_1_com", "zone3_2_med", "com_to_med");
  _id_055A::_id_0993("zone3_2_med", "zone2_2_catacombs", "med_to_underground");
  _id_055A::_id_0993("zone3_3_rnd", "zone1_5_rooftops", "activate_rooftops");
  _id_055A::_id_0993("zone3_1_com", "zone4_1_mine", "com_to_mine");
  _id_055A::_id_0993("zone3_3_rnd", "zone4_1_mine", "rnd_to_mine");
  _id_055A::_id_0993("zone4_1_mine", "zone4_2_hilt", "activate_mine");
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_GALLOWS", "start_to_gallows", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_GALLOWS", "start_to_gallows", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_TWR", "safe_haven_to_bridge", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_TWR", "safe_haven_to_bridge", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_ENTRANCE", "start_to_riverside", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_RIVERSIDE", "start_to_riverside", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_GALLOWS", "gallows_to_riverside", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_RIVERSIDE", "gallows_to_riverside", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_ENTRANCE", "start_to_bridge", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_BRIDGE", "start_to_bridge", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_BRIDGE", "riverside_to_bridge", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_RIVERSIDE", "riverside_to_bridge", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_FIRE_WELL", "gallows_to_well", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_GALLOWS", "gallows_to_well", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_COM", "gallows_to_com", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_GALLOWS", "gallows_to_com", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_CATACOMBS", "underground_to_riverside1", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_RIVERSIDE", "underground_to_riverside1", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_CATACOMBS", "med_to_underground", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_MED", "med_to_underground", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_MED", "com_to_med", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_COM", "com_to_med", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_RND", "com_to_rnd", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_COM", "com_to_rnd", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_ROOFTOPS", "riverside_to_rooftops", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_RIVERSIDE", "riverside_to_rooftops", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_MINE", "com_to_mine", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_COM", "com_to_mine", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_MINE", "rnd_to_mine", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_RND", "rnd_to_mine", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_CATACOMBS", "well_to_underground", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_NEST_DOOR_FIRE_WELL", "well_to_underground", 1);
  _id_0547::_id_3C8A("com_to_rnd", "activate_rooftops");
  _id_0547::_id_3C8A("riverside_to_rooftops", "activate_rooftops");
  _id_0547::_id_3C8A("rnd_to_mine", "activate_rooftops");
  _id_0547::_id_3C8A("com_to_mine", "activate_mine");
  _id_0547::_id_3C8A("rnd_to_mine", "activate_mine");
  _id_055A::_id_088A();
  common_scripts\utility::flag_set("flag_zone1_start");
  maps\mp\gametypes\zombies::_id_0997("zone1", ::_id_AC9A, ::_id_AC90, ::_id_AC97);
  maps\mp\gametypes\zombies::_id_5294("zone1");
}

_id_6B5B() {
  thread _id_9CF8();
  level._id_7F22["normal"] = ::_id_666A;
  level._id_7F22["zombie_dog"] = ::_id_666A;
  level._id_7F18["normal"] = ::_id_6669;
  _id_0547::remove_wallbuys_from_box();
}

_id_666A() {
  var_0 = common_scripts\utility::random(level.players);

  switch (level._id_A980) {
    case 5:
      wait 4;
      common_scripts\utility::_id_0FB2(level.players, _id_0367::_id_8E3C, "sprinterflies");
      break;
    case 6:
      wait 3;
      var_0 thread _id_0367::_id_8E3B("conv_wavedifficultyclue");
      break;
    case 9:
      wait 3;

      if(!_id_0557::_id_783E("explore village", "Restore Bunker Door Power"))
        thread _id_054E::_id_7449("nag_stop_killing");

      break;
    case 14:
      wait 3;

      if(_id_0557::_id_783E("explore village", "Restore Bunker Door Power") && !_id_0557::_id_783E("2 open salt mine", "use power machines"))
        thread _id_054E::_id_7449("nag_open_salt");

      break;
    case 21:
      wait 3;

      if(_id_0557::_id_783E("6B Left Hand overcharge", "activate left hand") && !_id_0557::_id_783E("7 Voice paintings", "find code pieces")) {
        foreach(var_2 in level.players) {
          if(!common_scripts\utility::_id_3C77("flag_player_has_head")) {
            if(common_scripts\utility::_id_3C77("flag_both_hints_seen"))
              var_2 thread _id_0367::_id_8E3C("firemanheadneed");

            continue;
          }

          if(_id_057E::_id_314D(var_2)) {
            break;
          }

          var_2 thread _id_0367::_id_8E3C("firemanheadneed");
        }
      }

      break;
  }
}

_id_531C() {
  waitframe();
  level._id_A62B _id_054E::_id_AB1A("player", "general", "nag_open_salt", "nagopensaltmine", undefined);
}

_id_6669() {
  if((common_scripts\utility::_id_3C77("gallows_to_com") || common_scripts\utility::_id_3C77("med_to_underground") || common_scripts\utility::_id_3C77("riverside_to_rooftops")) && !_id_0557::_id_783E("8A The Hilt", "Shoot Hilt"))
    thread maps\mp\mp_zombie_nest_straub_appearances::_id_74E2();
}

_id_6668(var_0) {
  if(self._id_0A4B != "zombie_generic")
    return undefined;

  if(isDefined(self._id_6250) && self._id_6250 > 0) {
    var_1 = _id_054D::_id_443F("rageBuff");

    if(isDefined(var_1) && var_1._id_90F0 != 1) {
      var_1._id_90F0 = 1;
      self notify("speed_debuffs_changed");
    }

    return undefined;
  }

  if(!isDefined(self._id_A978))
    return undefined;

  var_2 = _id_054D::_id_4268();
  var_3 = 30;
  var_4 = 10;
  var_5 = 60;
  var_6 = 200;
  var_7 = var_3 * 1000;
  var_8 = var_4;
  var_9 = var_5;

  if(var_2 > var_6 && _id_0547::_id_5565(self._id_0108, "sprint"))
    _id_054D::_id_099B("rageBuff", _id_4641());

  if(var_2 > var_9) {
    if(!isDefined(self._id_5B50))
      self._id_5B50 = gettime();

    if(self._id_5B50 + var_7 <= gettime() && self._id_A978 + (self._id_6480 + var_8) < 100) {
      self._id_5B50 = gettime();
      return self._id_6480 + var_8;
    } else
      return undefined;
  }
}

_id_4641() {
  var_0 = _id_054D::_id_443F("rageBuff");

  if(!isDefined(var_0))
    var_0 = _id_9094();

  return var_0;
}

_id_9094() {
  var_0 = 1.2;
  var_1 = spawnStruct();
  var_1._id_1CF2 = undefined;
  var_1._id_1CF0 = ::_id_7CF6;
  var_1._id_90F0 = var_0;
  self notify("speed_debuffs_changed");
  return var_1;
}

_id_7CF6(var_0) {
  var_0._id_90F0 = 1;
  self notify("speed_debuffs_changed");
}

_id_6B91() {}

_id_76D0(var_0) {
  if(!common_scripts\utility::_id_562E(self._id_5525))
    return 0;

  if(!_id_055A::_id_AC29(var_0, "zone2_2_catacombs"))
    return 0;

  return 1;
}

_id_3FD2(var_0) {
  waittillframeend;
  thread _id_6B2D();
  thread _id_8A19();
}

_id_83FA(var_0, var_1) {
  setdvarifuninitialized(var_0, var_1);
  var_2 = var_1;

  for(;;) {
    var_3 = getdvarint(var_0, 0);

    if(var_3 != var_2) {
      switch (var_3) {
        case 0:
          var_4 = _func_21F("switch", "targetname");

          foreach(var_6 in var_4) {
            wait 0.1;
            var_6 _meth_83FA("switchlights", "on");
          }

          break;
        case 1:
          var_4 = _func_21F("switch", "targetname");

          foreach(var_6 in var_4) {
            wait 0.1;
            var_6 _meth_83FA("switchlights", "off");
          }

          break;
        case 2:
          var_4 = _func_21F("switch", "targetname");

          foreach(var_6 in var_4) {
            wait 0.1;
            var_6 _meth_83FA("switchlights", "red");
          }

          break;
      }

      var_2 = var_3;
    }

    wait 0.2;
  }
}

_id_6B2D() {
  var_0 = getEntArray("trig_oneway_grate_trigger", "targetname");
  common_scripts\utility::_id_0FB2(var_0, ::_id_6B2E);
}

_id_6B2E() {
  var_0 = self;
  var_0._id_24A7 = _func_18E(var_0.target, "targetname");
  var_1 = var_0._id_24A7.origin;
  var_2 = (150, 0, 0);

  for(;;) {
    var_0 waittill("trigger", var_3);
    var_0._id_24A7 _meth_82B1(var_0._id_24A7.origin + var_2, 1);

    while(var_3 istouching(var_0))
      waitframe();

    var_0._id_24A7 _meth_82B1(var_1, 0.5);
  }
}

_id_AC9A() {
  level endon("zone1Cleanup");
  _id_055B::waittill_jumpscare_initialized();
  thread _id_A557();
  thread _id_3D8A();
  thread _id_3284();
  thread _id_1DA6();
  thread _id_1DA9();
  thread _id_2E8B();
  thread _id_2EA0();
  thread _id_2E9F();
  thread _id_2E8A();
  thread _id_2E77();
  thread _id_2E94();
  thread _id_2E90();
  thread _id_2E89();
  thread _id_2E95();
  thread _id_2E93();
  thread _id_3C0C();
  thread _id_1CC8();
  maps\mp\gametypes\zombies::_id_8028(0);
  wait 5;
}

_id_9CF8() {
  level._id_9CFB = 1;
  level._id_62B5 = 1;
  _id_0546::_id_7BD7("gj_zmb_drop_gate_switch_01", "gj_zmb_drop_gate_switch_01", "gj_zmb_drop_gate_switch_01", "gj_zmb_drop_gate_switch_01");
  thread _id_0546::_id_9CC6("trap_rnd", "active", maps\mp\mp_zombie_nest_trap_rnd::_id_9CC0);
  thread _id_0546::_id_9CC6("trap_roof", "active", maps\mp\mp_zombie_nest_trap_betty::_id_9C97);
  thread _id_0546::_id_9CC6("trap_med", "active", maps\mp\mp_zombie_nest_trap_med::_id_9CB8);
  thread _id_0546::_id_9CC6("trap_catacombs", "active", maps\mp\mp_zombie_nest_trap_catacombs::_id_9C9A);
  level thread _id_9E92();
  _id_0546::_id_9CC7("trap_rnd", &"ZOMBIE_NEST_RND_TRAP", &"ZOMBIES_TRAP_COOLDOWN", "rnd");
  _id_0546::_id_9CC7("trap_roof", &"ZOMBIE_NEST_BETTY_TRAP", &"ZOMBIES_TRAP_COOLDOWN", "betty");
  _id_0546::_id_9CC7("trap_med", &"ZOMBIE_NEST_MED_TRAP", &"ZOMBIES_TRAP_COOLDOWN", "med");
  _id_0546::_id_9CC7("trap_catacombs", &"ZOMBIE_NEST_CATACOMBS_TRAP", &"ZOMBIES_TRAP_COOLDOWN", "catacombs");
}

_id_9E92() {
  level waittill("firewell_machinery_ready");
  var_0 = common_scripts\utility::_id_46B5("trap_firewell", "script_noteworthy");
  var_0 _id_52E1();
  var_0 thread _id_0546::_id_9CAF(1, var_0._id_9DC2, var_0._id_3F4E, var_0._id_9CBA);
  thread _id_0546::_id_9CC6("trap_firewell", "active", maps\mp\mp_zombie_nest_trap_firewell::_id_9CAA);
  _id_0546::_id_9CC7("trap_firewell", &"ZOMBIE_NEST_WELL_TRAP", &"ZOMBIES_TRAP_COOLDOWN", "firewell");
}

_id_52E1() {
  self._id_9DC2 = [];
  self._id_9CBA = [];
  self._id_3F4E = [];
  var_0 = common_scripts\utility::_id_44BE(self.target, "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_0165)) {
      continue;
    }
    switch (var_2._id_0165) {
      case "activate_model":
        self._id_9CBA = common_scripts\utility::_id_0F6F(self._id_9CBA, var_2);
        break;
      case "activate":
        self._id_9DC2 = common_scripts\utility::_id_0F6F(self._id_9DC2, var_2);
        break;
      case "fx_ready":
        self._id_3F4E = common_scripts\utility::_id_0F6F(self._id_3F4E, var_2);
        break;
      default:
        break;
    }
  }

  var_4 = common_scripts\utility::_id_46B5("zmb_flamethrower_trap_light", "script_noteworthy");
  var_5 = _func_18E("pilot_light_trigger", "targetname");
  self._id_3F4E = common_scripts\utility::_id_0F6F(self._id_3F4E, var_4);
  self._id_9DC2 = common_scripts\utility::_id_0F6F(self._id_9DC2, var_5);
}

_id_2E9F() {
  var_0 = getEntArray("trig_elec_gate_dialog_gen", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_2EA2();

  while(!common_scripts\utility::_id_3C83("power_sz2"))
    wait 1;

  common_scripts\utility::_id_3C9F("power_sz2");

  foreach(var_2 in var_0)
  var_2 delete();
}

_id_2EA2() {
  level endon("power_sz2");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      wait 0.5;
      continue;
    }

    if(!common_scripts\utility::_id_562E(var_0._id_306E)) {
      var_1 = var_0 _id_0367::_id_8E3D("electricgate2");

      if(isDefined(var_1))
        var_0._id_306E = 1;
    }
  }
}

_id_2EA0() {
  var_0 = getEntArray("electric_gate_dialogue", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 thread _id_2EA1();

  while(!common_scripts\utility::_id_3C83("power_sz2"))
    wait 1;

  common_scripts\utility::_id_3C9F("power_sz2");

  foreach(var_2 in var_0)
  var_2 delete();
}

_id_2EA1() {
  level endon("power_sz2");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      wait 0.5;
      continue;
    }

    if(!common_scripts\utility::_id_562E(var_0._id_306D)) {
      var_1 = var_0 _id_0367::_id_8E3D("electricgate");

      if(isDefined(var_1))
        var_0._id_306D = 1;
    }
  }
}

_id_2E8B() {
  level endon("power_sz2");
  var_0 = _func_18E("generator_sign_dialogue", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isDefined(var_1._id_3069) && isPlayer(var_1)) {
      var_1 thread _id_0367::_id_8E3C("seegenerator");
      var_1._id_3069 = 1;
    }
  }
}

_id_2E8A() {
  level endon("power_sz2");
  var_0 = _func_18E("fuel_tank_dialogue", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isDefined(var_1._id_3068) && isPlayer(var_1)) {
      var_1 thread _id_0367::_id_8E3C("firewellexamine");
      var_1._id_3068 = 1;
    }
  }
}

_id_2E77() {
  level endon("power_sz2");
  var_0 = _func_18E("bunker_ent_dialogue", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = [];

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      wait 0.5;
      continue;
    } else if(!common_scripts\utility::_id_0F79(var_1, var_2)) {
      if(isDefined(var_2._id_3069)) {
        var_1 = common_scripts\utility::_id_0F6F(var_1, var_2);
        continue;
      }

      var_3 = var_2 _id_0367::_id_8E3D("saltminedoor");

      if(isDefined(var_3))
        var_1 = common_scripts\utility::_id_0F6F(var_1, var_2);

      var_4 = 1;

      foreach(var_6 in level.players) {
        if(!common_scripts\utility::_id_0F79(var_1, var_6))
          var_4 = 0;
      }

      if(var_4) {
        break;
      }
    }
  }

  var_0 delete();
}

_id_2E99(var_0) {
  if(!isDefined(var_0._id_3062)) {
    var_0 thread _id_0367::_id_8E3C("firstearthquake");
    var_0._id_3062 = 1;
  }
}

_id_2E94() {
  wait 5;

  foreach(var_1 in level.players)
  var_1 thread _id_0367::_id_8E3C("villageintro");
}

_id_2E87() {
  level endon("start_to_gallows");

  for(;;) {
    if(isDefined(level._id_AC1D)) {
      break;
    } else
      wait 0.25;
  }

  var_0 = _id_053F::_id_44A6("start_to_gallows");
}

_id_2E90() {
  level endon("flag_ww_part_02_picked_up");
  var_0 = _func_21F("med_untotenpresse_smasher", "targetname");

  if(isDefined(var_0))
    childthread maps\mp\mp_zombie_nest_ee_util::_id_720B("conv_juicerintro", var_0[0].origin, 250, 50);
}

_id_2E89() {
  level endon("flag_ww_part_01_picked_up");
  var_0 = _func_18E("trig_see_forge", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = [];

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      wait 0.5;
      continue;
    } else if(!common_scripts\utility::_id_0F79(var_1, var_2)) {
      var_3 = var_2 _id_0367::_id_8E3D("forgestartup2");

      if(isDefined(var_3))
        var_1 = common_scripts\utility::_id_0F6F(var_1, var_2);

      var_4 = 1;

      foreach(var_6 in level.players) {
        if(!common_scripts\utility::_id_0F79(var_1, var_6))
          var_4 = 0;
      }

      if(var_4) {
        break;
      }
    }
  }

  var_0 delete();
}

_id_2E95() {
  level endon("flag_ww_forged");
  var_0 = _func_18E("trig_see_med_office", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = [];

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      wait 0.5;
      continue;
    } else if(!common_scripts\utility::_id_0F79(var_1, var_2)) {
      var_3 = var_2 _id_0367::_id_8E3D("medofficereaction");

      if(isDefined(var_3))
        var_1 = common_scripts\utility::_id_0F6F(var_1, var_2);

      var_4 = 1;

      foreach(var_6 in level.players) {
        if(!common_scripts\utility::_id_0F79(var_1, var_6))
          var_4 = 0;
      }

      if(var_4) {
        break;
      }
    }
  }

  var_0 delete();
}

_id_2E93() {
  level endon("flag_correct_code_entered");
  var_0 = _func_18E("trig_enter_klaus_office", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isPlayer(var_1)) {
      break;
    }

    wait 0.5;
  }

  var_1 thread _id_0367::_id_8E3B("conv_klausroom");
  var_0 delete();
}

_id_3C0C() {
  common_scripts\utility::flag_init("flag_vo_fireman_head_spotted");
  _id_0547::_id_7BA9(::_id_3C0B);
}

_id_3C0B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(self._id_0A4B == "zombie_fireman") {
    if(isDefined(var_1)) {
      if(isPlayer(var_1) && !common_scripts\utility::_id_3C77("flag_vo_fireman_head_spotted")) {
        var_1 thread _id_0367::_id_8E3C("firemankilled");
        common_scripts\utility::flag_set("flag_vo_fireman_head_spotted");
        _id_0547::_id_2D8C(::_id_3C0B);
      }
    }
  }
}

_id_A557() {
  var_0 = getEntArray("sewage_jumpscare", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_055B::_id_8A74();

  while(!common_scripts\utility::_id_3C83("fire trap active"))
    wait 1;

  common_scripts\utility::_id_3C9F("fire trap active");

  foreach(var_2 in var_0)
  var_2 notify("end_jumpscare");
}

_id_3D8A() {
  var_0 = getEntArray("floor_burst_jumpscare", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_055B::_id_3D86();
}

_id_3284() {
  var_0 = getEntArray("door_burst_jumpscare", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_055B::_id_3266();
}

_id_1DA6() {
  var_0 = getEntArray("drop_jumpscare", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_055B::_id_1D91();
}

_id_1DA9() {
  var_0 = getEntArray("bunker_window_jumpscare", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_81A1)) {
      var_2 thread _id_1706(var_2._id_81A1);
      continue;
    }

    var_2 thread _id_055B::_id_1DA1();
  }
}

_id_1706(var_0) {
  common_scripts\utility::_id_3C9F(var_0);
  thread _id_055B::_id_1DA1();
}

_id_8A19() {
  var_0 = 0;

  for(;;) {
    level waittill("zombie_wave_started");

    if(level._id_A980 >= 3 && var_0 == 0) {
      thread _id_AC91();
      var_0 = 1;
    }
  }
}

_id_AC91() {
  var_0 = 60 * _func_0A5(1, 2);
  level._id_6F18 = 0;

  for(;;) {
    wait(var_0);
    var_0 = 60 * _func_0A5(1, 10);

    if(level._id_6F18 || common_scripts\utility::_id_3C77("flag_bunker_lights_off")) {
      continue;
    }
    level notify("zone1EarthquakeBegin");
    var_1 = _func_0A5(3, 5);
    var_2 = _func_0A5(3, 5);
    var_3 = _func_0A5(3, 5);
    var_4 = _func_0A5(4, 8);
    _id_0378::_id_8D74("zone1Earthquake", "rumble1", var_1);
    wait(var_1);
    _id_0378::_id_8D74("zone1Earthquake", "rumble2", var_2);
    wait(var_2);
    _id_0378::_id_8D74("zone1Earthquake", "rumble3", var_3);
    wait(var_3);
    _id_0378::_id_8D74("zone1Earthquake", "earthquake", var_4);
    thread _id_353F(var_4);

    if(!common_scripts\utility::_id_3C77("flag_bunker_lights_off"))
      thread _id_3541(var_4);

    var_5 = maps\mp\mp_zombie_nest_ee_util::_id_4649();

    if(isDefined(var_5))
      level thread _id_3254(var_4, var_5);

    level thread common_scripts\_exploder::_id_088E(207);
    wait(var_4);
    level notify("zone1EarthquakeEnd");
  }
}

_id_3541(var_0) {
  var_1 = _func_21F("light_zm_objective", "targetname");

  foreach(var_3 in var_1) {
    waitframe();
    var_3._id_6C56 = var_3 _meth_866B("puzzlelight");
  }

  foreach(var_3 in var_1) {
    waitframe();
    var_3 _meth_83FA("puzzlelight", "cycle1a");
  }

  wait 0.1;

  foreach(var_3 in var_1) {
    waitframe();

    if(isDefined(var_3._id_6C56))
      var_3 _meth_83FA("puzzlelight", var_3._id_6C56);
  }
}

_id_353F(var_0) {
  waitframe();
  var_0 = var_0 - 0.05;
  var_0 = var_0 * 0.7;
  var_1 = 4;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    _id_3540();
    wait(var_0 / var_1);
  }
}

_id_3540() {
  foreach(var_1 in level.players) {
    var_2 = undefined;
    var_3 = undefined;
    var_4 = _func_32F();

    for(var_5 = 0; var_5 < var_4; var_5++) {
      if(_func_1CB(var_5)) {
        continue;
      }
      var_6 = _func_1CA(var_5);
      var_7 = common_scripts\utility::_id_5D93(distance(var_6, var_1.origin), 0, 50000, 1, 0);
      var_8 = vectordot(anglesToForward(var_1.angles), var_6 - var_1.origin);
      var_9 = common_scripts\utility::_id_5D93(var_8, 0.5, 1, 0, 1);
      var_10 = var_7 * var_9 * 3 + _func_0A3(0.2);

      if(!isDefined(var_3) || var_10 > var_3) {
        var_2 = var_5;
        var_3 = var_10;
      }
    }

    if(isDefined(var_2)) {
      var_11 = vectorNormalize(vectorNormalize(var_1.origin - _func_1CA(var_2)) + common_scripts\utility::_id_7A5F(0.3));
      _func_1CC(var_2, var_11);
    }
  }
}

_id_3254(var_0, var_1) {
  _func_17F(0.3, var_0, var_1.origin, 850, var_1);
  _func_1BC("tank_rumble", var_1.origin);
  thread _id_2E99(var_1);
  wait(var_0);
  _func_1BD();
}

_id_34B6() {
  for(;;) {
    level waittill("zombie_wave_started");

    if(!isDefined(level._id_A980) || level._id_A980 % 5 != 0) {
      continue;
    }
    common_scripts\utility::flag_set("sky_rush");
    _id_055A::_id_8712(1, "sky_rush_event");
    level waittill("zombie_wave_ended");
    common_scripts\utility::_id_3C7B("sky_rush");
    _id_055A::_id_8712(0, "sky_rush_event");
  }
}

_id_AC90() {}

_id_AC97() {}

_id_1CC8() {
  wait 1;
  level thread common_scripts\_exploder::_id_088E(238);
}

_id_5CB9() {}

_id_7EAC() {
  common_scripts\utility::_id_3C9F("gallows_to_riverside");

  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1._id_819A) && var_1._id_819A == "gallows_to_riverside" && (!isDefined(var_1._id_6BE1) || !var_1._id_6BE1))
      var_1 notify("open", undefined);
  }
}

_id_2033() {
  common_scripts\utility::_id_3C9F("underground_to_riverside1");

  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1._id_819A) && var_1._id_819A == "underground_to_riverside1" && (!isDefined(var_1._id_6BE1) || !var_1._id_6BE1))
      var_1 notify("open", undefined);
  }
}

_id_1D8F() {
  var_0 = common_scripts\utility::_id_46B7("bunker_door_indicator", "targetname");
  common_scripts\utility::_id_0FB2(var_0, maps\mp\mp_zombie_nest_ee_util::_id_A16D, "red");
  common_scripts\utility::_id_3C9F("gallows_to_com");
  common_scripts\utility::_id_0FB2(var_0, maps\mp\mp_zombie_nest_ee_util::_id_A16D, "green");
}

_id_3C23() {
  for(;;) {
    if(common_scripts\utility::_id_3C83("power_sz2")) {
      break;
    } else
      wait 1;
  }

  common_scripts\utility::_id_3C9F("power_sz2");

  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1._id_819A) && var_1._id_819A == "gallows_to_well" && (!isDefined(var_1._id_6BE1) || !var_1._id_6BE1))
      var_1 notify("open", undefined);
  }
}

_id_742E() {
  self endon("disconnect");

  for(;;) {
    common_scripts\utility::_id_A70A("new_wallbuy_weapon", "new_equipment");
    var_0 = 0;

    if(common_scripts\utility::_id_24A6())
      var_0 = 1;

    if(var_0) {
      wait 1;
      thread _id_0367::_id_8E3C("newweapon");
    }
  }
}

_id_3DCE() {
  _id_055B::_id_3DB1();
  common_scripts\utility::_id_3CA2("com_to_rnd", "activate_rooftops", "rnd_to_mine");
  var_0 = _id_055B::_id_3DB0();

  foreach(var_2 in var_0)
  var_2 thread _id_055B::_id_3DB3();

  thread _id_3DCC();
  thread _id_3DCD();
  common_scripts\utility::_id_3C9F("flag_fol_inc_armed");

  foreach(var_2 in var_0)
  var_2._id_5971 = 1;

  _id_0557::_id_7870("4 cart", "head to rnd");

  if(!common_scripts\utility::_id_3C77("flag_first_fol_inc_selected")) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2._id_81E1) && var_2._id_81E1 == 0)
        var_2 thread _id_055B::_id_3DAE();
    }
  }
}

_id_3DCD() {
  for(;;) {
    level waittill("zombie_wave_started");

    if(level._id_A980 >= 8) {
      break;
    }
  }

  if(common_scripts\utility::_id_3C77("flag_fol_inc_armed"))
    return;
  else {
    common_scripts\utility::flag_set("flag_fol_inc_armed");
    var_0 = _id_055B::_id_3DAF();

    foreach(var_2 in var_0)
    var_2 thread _id_055B::_id_3DAD();
  }
}

_id_3DCC() {
  _id_0557::_id_7870("4 cart", "press button");

  if(common_scripts\utility::_id_3C77("flag_fol_inc_armed"))
    return;
  else {
    common_scripts\utility::flag_set("flag_fol_inc_armed");
    var_0 = _id_055B::_id_3DAF();

    foreach(var_2 in var_0)
    var_2 thread _id_055B::_id_3DAD();
  }
}

_id_18DE() {
  while(!common_scripts\utility::_id_3C83("flag_rnd_enigma_set"))
    wait 1;

  common_scripts\utility::_id_3CA0("flag_rnd_enigma_set", "flag_med_enigma_set");
  common_scripts\utility::_id_3CA2("com_to_mine", "rnd_to_mine");
  var_0 = common_scripts\utility::_id_46B7("bomber_intro_mine_spawn", "targetname");

  foreach(var_2 in var_0) {
    var_3 = _id_054D::_id_90BA("zombie_exploder", var_2, "intro bombers", 0, 1, 0, undefined, 0);
    var_3 _id_0547::_id_84CB();
  }
}

_id_18DF() {
  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      break;
    }

    wait 0.5;
  }

  var_1 = common_scripts\utility::_id_46B7(self.target, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_0165) && var_3._id_0165 == "zombie_sky_spawner")
      var_3._id_8C95 = 1;

    var_4 = _id_054D::_id_90BA("zombie_exploder", var_3, "intro bombers", 0, 1, 0, undefined, 0);
  }
}

_id_3BF9() {
  var_0 = common_scripts\utility::_id_46B5("first_fireman_spawner_default", "targetname");
  var_1 = common_scripts\utility::_id_46B5("first_fireman_spawner_fallback", "targetname");

  while(!common_scripts\utility::_id_3C83("flag_ww_part_02_picked_up"))
    wait 1;

  common_scripts\utility::_id_3C9F("flag_ww_part_02_picked_up");

  if(!(level._id_3BFE > 0)) {
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(_id_055A::_id_7413(var_4, "zone3_1_com")) {
        var_2 = 1;
        var_0 = var_1;
        break;
      }
    }

    if(!var_2)
      _id_0378::_id_8D74("fireman_intro_scream", var_0.origin);

    if(!var_2) {
      var_6 = getEntArray("fireman_intro_trig", "targetname");

      foreach(var_8 in var_6)
      var_8 thread _id_3BFA();

      level waittill("com_entered_by_player", var_10);
      thread _id_3BF6();
      var_11 = _id_0564::_id_3C11(0, var_0, 0);
      var_11 _id_3BF7(var_0);
    } else
      var_11 = _id_0564::_id_3C11(0, var_0);
  }
}

_id_3BF6() {
  var_0 = common_scripts\utility::_id_46B7("fireman_intro_explosion", "script_noteworthy");
  var_1 = var_0[0].origin;
  _id_0378::_id_8D74("well_explosion", var_1);
  _id_0378::_id_8D74("fireman_intro_scream", var_1);
  _id_0378::_id_8D74("aud_fireman_fire_emitters", var_1);
  level thread common_scripts\_exploder::_id_088E(215);

  foreach(var_3 in var_0) {
    _func_17F(0.3, 4, var_3.origin, 850);
    wait 0.4;
  }

  thread _id_6E18();
}

_id_6E18() {
  var_0 = _func_18E("move_cart_button_console", "targetname");
  _func_147(level._effect["zmb_com_room_fire_panel"], var_0, "tag_origin");
  wait 18;
  _func_148(level._effect["zmb_com_room_fire_panel"], var_0, "tag_origin");
}

_id_3BF7(var_0) {
  var_1 = common_scripts\utility::_id_46B5("first_fireman_flame_point", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  self._id_00CA = 1;
  self._id_5748 = 1;
  self._id_57E8 = 1;
  _id_053C::_id_06CE(var_1.origin);
  var_2 = gettime();
  var_3 = 0;

  for(;;) {
    var_4 = gettime();

    if(var_4 > var_2 + 5000) {
      var_3 = 1;
      break;
    }

    if(distance(self.origin, var_1.origin) > 16) {
      wait 0.1;
      continue;
    }

    break;
  }

  if(!var_3) {
    self _meth_83A2(1);
    self _meth_839C("anim deltas");
    self _meth_839B("face angle abs", var_1.angles, var_1.angles);
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "firemanintro");
    thread _id_3BF5();
    var_5 = common_scripts\utility::_id_A715("fireman_intro_finished", "damage");

    if(var_5 == "damage") {
      _func_148(level._effect["zombie_fireman_flamethrower_expensive"], self, "tag_flamethrower_fx");
      _id_0378::_id_8D74("flamethrower_stop", "tag_flamethrower_fx");
    }

    maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "firemanintro");
    self _meth_83A2(0);
  }

  var_6 = common_scripts\utility::_id_46B5("first_fireman_end_point", "targetname");

  if(isDefined(var_6)) {
    _id_053C::_id_06CE(var_6.origin);

    for(;;) {
      if(distance(self.origin, var_6.origin) > 16) {
        wait 0.1;
        continue;
      }

      break;
    }
  }

  self._id_00CA = 0;
  self._id_5748 = 0;
  self._id_57E8 = 0;
  self _meth_855C();
}

_id_3BF5() {
  self endon("damage");
  maps\mp\agents\_scripted_agent_anim_util::_id_8415("s2_fireman_intro_flame", 0, 1);
  wait 2.33333;
  _func_147(level._effect["zombie_fireman_flamethrower_expensive"], self, "tag_flamethrower_fx");
  _id_0378::_id_8D74("flamethrower_start", "tag_flamethrower_fx");
  wait 2.66667;
  _func_148(level._effect["zombie_fireman_flamethrower_expensive"], self, "tag_flamethrower_fx");
  _id_0378::_id_8D74("flamethrower_stop", "tag_flamethrower_fx");
  wait 0.333333;
  self notify("fireman_intro_finished");
}

_id_3BFC() {
  var_0 = _func_21F("fireman_intro", "targetname");

  foreach(var_2 in var_0)
  var_2 _meth_83FA("heat", "enable");

  wait 2.3;

  foreach(var_2 in var_0)
  var_2 _meth_83FA("heat", "die");
}

_id_3BFA() {
  level endon("com_entered_by_player");

  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      level notify("com_entered_by_player", var_0);
      break;
    }

    wait 0.5;
  }
}

_id_347A() {
  var_0 = _func_18E("disable_clocktower_jumpscare", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isPlayer(var_1) && level._id_2F29 == 0)
      level._id_2F29 = 1;
  }
}

_id_666B() {
  var_0 = 1000000;
  var_1 = _id_0547::_id_4282(self);
  var_2 = var_1["ignoreBlimp"];

  if(common_scripts\utility::_id_562E(var_2))
    return 1;

  if(isDefined(level._id_179A) && _func_211(self.origin, level._id_179A.origin) < var_0)
    return 1;
  else
    return 0;
}

_id_4D48(var_0) {
  common_scripts\utility::_id_A70B(var_0._id_3678, "open");
  level notify("disable_initial_door_highlight");

  if(isDefined(var_0._id_5E61)) {
    var_0._id_5E61 _meth_83FF();
    var_0._id_5E61 delete();
  }
}

_id_4D49(var_0) {
  level endon("disable_initial_door_highlight");
  var_1 = self;

  while(var_0._id_3290.size) {
    var_1 waittill("money_update");

    foreach(var_3 in var_0._id_3290) {
      if(var_1._id_62D6 < var_3._id_267B) {
        if(isDefined(var_0._id_5E61) && common_scripts\utility::_id_562E(var_0._id_5E61._id_5594)) {
          var_0._id_5E61._id_5594 = 0;
          var_0._id_5E61 _meth_8428(var_1);
        }

        continue;
      }

      if(isDefined(var_0._id_5E61) && !common_scripts\utility::_id_562E(var_0._id_5E61._id_5594)) {
        var_0._id_5E61 _meth_8427(var_1, 0, 0);
        var_0._id_5E61._id_5594 = 1;
      }
    }
  }
}

_id_415E(var_0) {
  var_1 = [];

  while(!isDefined(level._id_AC1D))
    waitframe();

  foreach(var_3 in level._id_AC1D) {
    if(!isDefined(var_3._id_819A) || !common_scripts\utility::_id_0F79(var_0, var_3._id_819A)) {
      continue;
    }
    var_1 = common_scripts\utility::_id_0F6F(var_1, var_3);
  }

  return var_1;
}

_id_4D47() {
  var_0 = _id_415E(["start_to_gallows"]);
  var_1 = _func_18E("first_door_lock", "targetname");
  var_2 = _id_415E(["start_to_bridge", "start_to_gallows", "start_to_riverside"]);
  var_3 = spawnStruct();
  var_3._id_3290 = var_0;
  var_3._id_5E61 = var_1;
  var_3._id_3678 = var_2;
  level thread _id_4D48(var_3);
  level endon("disable_initial_door_highlight");
  level childthread maps\mp\_utility::_id_6F74(::_id_4D49, var_3);
}