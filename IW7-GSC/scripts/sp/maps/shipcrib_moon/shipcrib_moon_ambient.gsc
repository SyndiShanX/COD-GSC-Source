/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_moon\shipcrib_moon_ambient.gsc
*******************************************************************/

_id_1DBF() {
  scripts\engine\utility::flag_wait("shipcrib_moon_prime_in_tr_loaded");
  level thread _id_1DC6();
  level thread _id_E46D();
  scripts\engine\utility::flag_wait("shipcrib_moon_ambient_tr_loaded");
  level thread _id_1E02();
  level thread _id_1E06();
  level thread _id_1DFD();
  level thread _id_1E03();
  level thread _id_1E01();
}

_id_E46D() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_return_elevator_2f");

    if(isDefined(level._id_FD6E.jackals)) {
      foreach(var_1 in level._id_FD6E.jackals) {
        var_1 _id_0BDC::_id_A2DA();
      }
    }

    _id_0EFB::_id_FDE8(level._id_FD6E.jackals);
    _id_0EFB::_id_FDE8(level._id_FD6E._id_7316);
    _id_0EFB::_id_FDE8(level._id_E44C);
    level thread scripts\sp\utility::_id_12651(["shipcrib_moon_hangar_tr", "shipcrib_moon_jackal_tr", "shipcrib_moon_jackale_tr", "shipcrib_moon_mezz_tr"]);
    level thread scripts\sp\utility::_id_12643(["shipcrib_moon_bridge_tr", "shipcrib_moon_bridgee_tr", "shipcrib_moon_exterior_tr", "shipcrib_moon_vr_tr"]);
    _id_0EE4::_id_6E5E("ambient_return_elevator_2f");
  }
}

_id_1DC6() {
  if(level._id_10CDA == "moon start") {
    _id_ADD5();
    level waittill("jackal_elevator_finished");
    _id_408D();
  }
}

_id_1E02() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_hangar");
    _id_0EE4::_id_6E5E("ambient_zone_hangar");
    _id_0EFB::_id_FDBB("return_deck");
    _id_10AB::_id_404E("return_deck");
    level thread _id_10A2::_id_1A5E();
    level thread _id_10A4::_id_3B9E();
  }
}

_id_1E06() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_returne");
    _id_0EFB::_id_FDBB("valet");
    level _id_10A6::_id_888A();
    level thread[[level._id_FDA2["elevator_up_func"]]]();
    _id_0EE4::_id_6E5E("ambient_zone_returne");
    level thread _id_10A6::_id_888B();
  }
}

_id_1DFD() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_bridgef");
    _id_ADD7();
    _id_0EFB::_id_FDBA(level._id_828C);
    _id_0EFB::_id_FDBA(level._id_6754);
    _id_0EE4::_id_6E5E("ambient_zone_bridgef");
    _id_4093();
  }
}

_id_1E03() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_bridgee");
    level _id_10A6::_id_888A();
    level thread[[level._id_FDA2["elevator_down_func"]]]();
    _id_0EE4::_id_6E5E("ambient_zone_bridgee");
    _id_0EFB::_id_FDBB("bridge_crew");
    _id_0EFB::_id_FDBA(level._id_C47F);
    _id_0EFB::_id_FDBA(level._id_30F6);
    _id_0EFB::_id_FDBA(level._id_A538);
    _id_0EFB::_id_FDBA(level._id_B33A);
    _id_0EFB::_id_FDBA(level._id_C24B);
    _id_0EFB::_id_FDBA(level._id_76FB);
    _id_0EFB::_id_FDBA(level._id_6BD5);
    level thread _id_0EDE::_id_C650();
    level thread _id_10A6::_id_888B();
  }
}

_id_1E01() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_gravity");
    _id_0EE4::_id_6E5E("ambient_zone_gravity");
  }
}

_id_ADD5() {
  _id_10AB::_id_ADAD("sc_europa_ambient_jackalcontrol", ::_id_ADDA, ::_id_CDA0);
}

_id_408D() {
  _id_0EFB::_id_FDBB("jackalcontrol");
}

_id_CDA0(var_0) {
  var_1 = var_0["jackalcontrol_guy_01"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.28);
  var_1 = var_0["jackalcontrol_guy_02"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.28);
  var_1 = var_0["jackalcontrol_guy_03"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.28);
  var_1 = var_0["jackalcontrol_guy_04"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.28);
}

#using_animtree("generic_human");

_id_ADDA() {
  level._id_EC85["generic"]["shipcrib_grav_jackal_control_ally01_idle01"][0] = % shipcrib_grav_jackal_control_ally01_idle01;
  level._id_EC85["generic"]["shipcrib_grav_jackal_control_ally02_idle01"][0] = % shipcrib_grav_jackal_control_ally02_idle01;
}

_id_CDA3(var_0) {
  var_1 = getarraykeys(var_0);

  foreach(var_3 in var_1) {
    if(isDefined(var_0[var_3])) {
      var_4 = var_0[var_3];

      switch (var_3) {
        case "return_deck_6":
          var_4 thread _id_10AB::_id_1F5E(5.0, 0.0);
          break;
        case "return_deck_7":
          var_4 thread _id_10AB::_id_1F5E(5.5, 0.3);
          break;
        case "return_deck_10":
          var_4 thread _id_10AB::_id_1F5E(9.0, 0.3);
          break;
        case "return_deck_11":
          var_4 thread _id_10AB::_id_1F5E(11.0, 0.0);
          break;
        case "return_deck_12":
          var_4 thread _id_10AB::_id_1F5E(3.75, 0.0);
          break;
        case "return_deck_13":
          var_4 thread _id_10AB::_id_1F5E(4.25, 0.3);
          break;
        case "return_deck_14":
          var_4 thread _id_BB39();
        case "return_deck_15":
          var_4 thread _id_10AB::_id_CC87(15, 0, "landing_on_returndeck", 1);
          break;
        case "return_deck_16":
          var_4 thread _id_BB3A();
          var_4 thread _id_10AB::_id_CC87(4, 0, "landing_on_returndeck", 1);
          break;
        case "return_deck_17":
          var_4 thread _id_BB3B();
          var_4 thread _id_10AB::_id_CC87(4, 0, "landing_on_returndeck", 1);
          break;
        case "return_deck_23":
        case "return_deck_22":
          var_4 thread _id_10AB::_id_CC87(1, 0, "landing_on_returndeck", 1);
          break;
        case "return_deck_26":
        case "return_deck_25":
          var_4 thread _id_10AB::_id_CC87(3, 0, "landing_on_returndeck", 1);
          break;
        case "return_deck_31":
        case "return_deck_30":
          var_4 thread _id_10AB::_id_CC87(0, 0, "landing_on_returndeck", 1);
          break;
        case "return_deck_32":
          var_4 thread _id_10AB::_id_1F5E(1, 0, "landing_on_returndeck");
          break;
        case "return_deck_39":
          var_4 thread _id_10AB::_id_1F5E(0, 0.3);
          break;
        case "return_deck_43":
        case "return_deck_42":
          var_4 thread _id_10AB::_id_CC87(0, 0, "landing_on_returndeck", 1);
          break;
        default:
          var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
      }
    }
  }
}

_id_BB39() {
  self endon("death");
  scripts\engine\utility::flag_wait("landing_on_returndeck");
  wait(randomfloatrange(2.0, 4.5));
  scripts\sp\utility::_id_10347("sc_moon_crw3_wheresthemedic");
  wait 12;
  scripts\sp\utility::_id_10347("sc_moon_crw1_cmonletsgo");
}

_id_BB3A() {
  self endon("death");
  scripts\engine\utility::flag_wait("landing_on_returndeck");
  wait 6.0;
  scripts\sp\utility::_id_10347("sc_moon_med1_okayarmsfirst");
  wait 8;
  scripts\sp\utility::_id_10347("sc_moon_med1_lookatme");
}

_id_BB3B() {
  self endon("death");
  scripts\engine\utility::flag_wait("landing_on_returndeck");
  wait 8.0;
  scripts\sp\utility::_id_10347("sc_moon_un2_rrrghhhshit");
  wait 4;
  scripts\sp\utility::_id_10347("sc_moon_crw1_arrhh");
}

_id_CDA1(var_0) {
  var_1 = getarraykeys(var_0);

  foreach(var_3 in var_1) {
    if(isDefined(var_0[var_3])) {
      var_4 = var_0[var_3];

      switch (var_3) {
        case "leave_deck_1":
          var_4 thread _id_10AB::_id_1F5E(0, 0.0);
          break;
        case "leave_deck_2":
          var_4 thread _id_10AB::_id_1F5E(0, 0.3);
          break;
        case "leave_deck_3":
          var_4 thread _id_10AB::_id_1F5E(9.0, 0.3);
          break;
        case "leave_deck_crouch":
          var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
          break;
        case "leave_deck_run":
          var_4 thread _id_10AB::_id_1F5E(7, 0.0);
          break;
        default:
          var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
      }
    }
  }
}

_id_ADDC() {
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_01"][0] = % shipcribmoon_elevator_injured_loop_01;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_02"][0] = % shipcribmoon_elevator_injured_loop_02;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_03"][0] = % shipcribmoon_elevator_injured_loop_03;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_04"][0] = % shipcribmoon_elevator_injured_loop_04;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_05"][0] = % shipcribmoon_elevator_injured_loop_05;
  level._id_EC85["generic"]["shipcrib_chillwalll_idle_02"][0] = % shipcrib_chillwalll_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_table_01_A"][0] = % shipcrib_moon_injured_table_01_a;
  level._id_EC85["generic"]["shipcrib_moon_injured_table_01_B"][0] = % shipcrib_moon_injured_table_01_b;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_injured_A"][0] = % shipcrib_moon_injured_grnd_01_idle_injured_a;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_injured_B"][0] = % shipcrib_moon_injured_grnd_01_idle_injured_b;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_death_A"][0] = % shipcrib_moon_injured_grnd_01_idle_death_a;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_death_B"][0] = % shipcrib_moon_injured_grnd_01_idle_death_b;
  level._id_EC85["generic"]["shipcrib_moon_coughing"][0] = % shipcrib_moon_coughing;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded01"][0] = % shipcrib_moon_wall_wounded01;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded02"][0] = % shipcrib_moon_wall_wounded02;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded03"][0] = % shipcrib_moon_wall_wounded03;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded04"][0] = % shipcrib_moon_wall_wounded04;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_A"][0] = % shipcrib_moon_lying_down_a;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_B"][0] = % shipcrib_moon_lying_down_b;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_C"][0] = % shipcrib_moon_lying_down_c;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_D"][0] = % shipcrib_moon_lying_down_d;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_E"][0] = % shipcrib_moon_lying_down_e;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_F"][0] = % shipcrib_moon_lying_down_f;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_G"][0] = % shipcrib_moon_lying_down_g;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_H"][0] = % shipcrib_moon_lying_down_h;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_J"][0] = % shipcrib_moon_lying_down_j;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyA_set01_idle_02"][0] = % shipcrib_prisoner_wounded_guya_set01_idle_02;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyB_set01_idle_02"][0] = % shipcrib_prisoner_wounded_guyb_set01_idle_02;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyA_set03_idle_02"][0] = % shipcrib_prisoner_wounded_guya_set03_idle_02;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyB_set03_idle_02"][0] = % shipcrib_prisoner_wounded_guyb_set03_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_organizer_idle"][0] = % shipcrib_moon_injured_organizer_idle;
  level._id_EC85["generic"]["shipcrib_moon_injured_guyA_idle_01"][0] = % shipcrib_moon_injured_guya_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_guyA_idle_02"][0] = % shipcrib_moon_injured_guya_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_guyA_idle_03"][0] = % shipcrib_moon_injured_guya_idle_03;
  level._id_EC85["generic"]["Shipcribgrav_jackal_serv_frantic_A_guy_01"][0] = % shipcribgrav_jackal_serv_frantic_a_guy_01;
  level._id_EC85["generic"]["Shipcribgrav_jackal_serv_frantic_B_guy_01"][0] = % shipcribgrav_jackal_serv_frantic_b_guy_01;
  level._id_EC85["generic"]["shipcribgrav_elevator_secA_1_guyA"] = % shipcribgrav_elevator_seca_1_guya;
  level._id_EC85["generic"]["shipcribgrav_elevator_secA_2_guyA"] = % shipcribgrav_elevator_seca_2_guya;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag01_guyB_idle_01"][0] = % shipcrib_moon_injured_drag01_guyb_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag01_guyB_idle_02"][0] = % shipcrib_moon_injured_drag01_guyb_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag01_guyB"] = % shipcrib_moon_injured_drag01_guyb;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag01_guyC_idle_01"][0] = % shipcrib_moon_injured_drag01_guyc_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag01_guyC_idle_02"][0] = % shipcrib_moon_injured_drag01_guyc_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag01_guyC"] = % shipcrib_moon_injured_drag01_guyc;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag02_guyB_idle_01"][0] = % shipcrib_moon_injured_drag02_guyb_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag02_guyB_idle_02"][0] = % shipcrib_moon_injured_drag02_guyb_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag02_guyB"] = % shipcrib_moon_injured_drag02_guyb;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag02_guyC_idle_01"][0] = % shipcrib_moon_injured_drag02_guyc_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag02_guyC_idle_02"][0] = % shipcrib_moon_injured_drag02_guyc_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag02_guyC"] = % shipcrib_moon_injured_drag02_guyc;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag03_guyB_idle_01"][0] = % shipcrib_moon_injured_drag03_guyb_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag03_guyB_idle_02"][0] = % shipcrib_moon_injured_drag03_guyb_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag03_guyB"] = % shipcrib_moon_injured_drag03_guyb;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag03_guyC_idle_01"][0] = % shipcrib_moon_injured_drag03_guyc_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag03_guyC_idle_02"][0] = % shipcrib_moon_injured_drag03_guyc_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag03_guyC"] = % shipcrib_moon_injured_drag03_guyc;
  level._id_EC85["generic"]["shipcrib_moon_extinguisher_guy01_idle"][0] = % shipcrib_moon_extinguisher_guy01_idle;
  level._id_EC85["generic"]["shipcrib_moon_extinguisher_guy02_idle"][0] = % shipcrib_moon_extinguisher_guy02_idle;
  level._id_EC85["generic"]["shipcrib_moon_extinguisher_guy04_idle"][0] = % shipcrib_moon_extinguisher_guy04_idle;
  level._id_EC85["generic"]["shipcrib_moon_extinguisher_guy01_run_in"] = % shipcrib_moon_extinguisher_guy01_run_in;
  level._id_EC85["generic"]["shipcrib_hangar_ramp_agent_loop"][0] = % shipcrib_hangar_ramp_agent_loop;
}

_id_ADD7() {
  _id_0EDD::_id_5552();
  _id_0EDD::_id_5553();
  _id_10AB::_id_ADAD("sc_ambient_lounge_moon", ::_id_ADDB, ::_id_CDA2);
}

_id_4093() {
  _id_0EFB::_id_FDBB("lounge");
}

_id_CDA2(var_0) {
  var_1 = getarraykeys(var_0);

  foreach(var_3 in var_1) {
    var_4 = var_0[var_3];
    var_4 _id_0EF8::_id_FDFF();

    switch (var_3) {
      case "moon_lounge_4":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
        var_4 dontcastshadows();
        break;
      case "moon_lounge_5":
        _id_0EFB::_id_FDBA(var_4);
        break;
      case "moon_lounge_6":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.4);
        break;
      case "moon_lounge_10":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
        var_4 dontcastshadows();
        break;
      case "moon_lounge_11":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
        var_4 dontcastshadows();
        break;
      case "moon_lounge_12":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
        var_4 dontcastshadows();
        break;
      case "moon_lounge_13":
        var_4 thread _id_BB26();
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
        break;
      case "moon_lounge_14":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.4);
        break;
      case "moon_lounge_15":
        var_4 thread _id_BB27();
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
        var_4 dontcastshadows();
        break;
      case "moon_lounge_16":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.5);
        break;
      case "moon_lounge_17":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
        var_4 dontcastshadows();
        break;
      case "moon_lounge_25":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
        var_4 dontcastshadows();
        break;
      case "moon_lounge_31":
        var_4 thread _id_10AB::_id_1F5E(1.0, 0.0);
        break;
      case "moon_lounge_33":
        var_4 thread _id_10AB::_id_1F5E(1.0, 0.5);
        var_4 dontcastshadows();
        break;
      default:
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
    }

    if(issubstr(var_4._id_1D77, "lying")) {
      var_4 thread _id_10319();
    }
  }
}

_id_BB26() {
  self endon("death");
  wait 8;
  scripts\sp\utility::_id_10347("sc_moon_med2_millerpassme");
  wait 3;
  scripts\sp\utility::_id_10347("sc_moon_med2_shit");
}

_id_BB27() {
  self endon("death");
  wait 10;
  scripts\sp\utility::_id_10347("sc_moon_med1_wereout");
}

_id_10319() {
  self endon("death");

  while(isDefined(self)) {
    var_0 = scripts\sp\utility::_id_7ECF(self._id_1D77);
    var_1 = getanimlength(var_0[0]);
    var_2 = 0.25;
    scripts\engine\utility::delaycall(0.1, ::_meth_82B1, var_0[0], var_2);
    wait(var_1 / var_2);
  }
}

_id_ADDB() {
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_01"][0] = % shipcribmoon_elevator_injured_loop_01;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_02"][0] = % shipcribmoon_elevator_injured_loop_02;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_03"][0] = % shipcribmoon_elevator_injured_loop_03;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_04"][0] = % shipcribmoon_elevator_injured_loop_04;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_05"][0] = % shipcribmoon_elevator_injured_loop_05;
  level._id_EC85["generic"]["shipcrib_chillwalll_idle_02"][0] = % shipcrib_chillwalll_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_table_01_A"][0] = % shipcrib_moon_injured_table_01_a;
  level._id_EC85["generic"]["shipcrib_moon_injured_table_01_B"][0] = % shipcrib_moon_injured_table_01_b;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_injured_A"][0] = % shipcrib_moon_injured_grnd_01_idle_injured_a;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_injured_B"][0] = % shipcrib_moon_injured_grnd_01_idle_injured_b;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_death_A"][0] = % shipcrib_moon_injured_grnd_01_idle_death_a;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_death_B"][0] = % shipcrib_moon_injured_grnd_01_idle_death_b;
  level._id_EC85["generic"]["shipcrib_moon_coughing"][0] = % shipcrib_moon_coughing;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded01"][0] = % shipcrib_moon_wall_wounded01;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded02"][0] = % shipcrib_moon_wall_wounded02;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded03"][0] = % shipcrib_moon_wall_wounded03;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded04"][0] = % shipcrib_moon_wall_wounded04;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_A"][0] = % shipcrib_moon_lying_down_a;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_B"][0] = % shipcrib_moon_lying_down_b;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_C"][0] = % shipcrib_moon_lying_down_c;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_D"][0] = % shipcrib_moon_lying_down_d;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_E"][0] = % shipcrib_moon_lying_down_e;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_F"][0] = % shipcrib_moon_lying_down_f;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_G"][0] = % shipcrib_moon_lying_down_g;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_H"][0] = % shipcrib_moon_lying_down_h;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_J"][0] = % shipcrib_moon_lying_down_j;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyA_set01_idle_02"][0] = % shipcrib_prisoner_wounded_guya_set01_idle_02;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyB_set01_idle_02"][0] = % shipcrib_prisoner_wounded_guyb_set01_idle_02;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyA_set03_idle_02"][0] = % shipcrib_prisoner_wounded_guya_set03_idle_02;
  level._id_EC85["generic"]["shipcrib_prisoner_wounded_guyB_set03_idle_02"][0] = % shipcrib_prisoner_wounded_guyb_set03_idle_02;
  level._id_EC85["generic"]["hm_grnd_grn_kneel_idle_01"][0] = % hm_grnd_grn_kneel_idle_01;
}

_id_ADB1() {
  _id_10AB::_id_ADAD("sc_moon_armoryhallway_ambient", ::_id_ADB2, ::_id_CC9D);
}

_id_4054() {}

_id_ADB2() {
  level._id_EC85["generic"]["shipcrib_inspection_90_high_idle"][0] = % shipcrib_inspection_90_high_idle;
  level._id_EC85["generic"]["shipcrib_europa_bridge_hall_repair_ladder_01"][0] = % shipcrib_europa_bridge_hall_repair_ladder_01;
}

_id_CC9D(var_0) {
  var_1 = getarraykeys(var_0);
  level._id_2208 = [];

  foreach(var_3 in var_1) {
    var_4 = var_0[var_3];

    if(var_3 == "tablet_supervisor") {
      var_4 _id_174F();
    }

    var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
    level._id_2208[level._id_2208.size] = var_4;
  }
}

_id_174F() {
  self._id_247B = spawn("script_model", self.origin);
  self._id_247B setModel("p7_desk_metal_military_03_tablet");
  self._id_247B linkTo(self, "tag_inhand", (0, 0, 0), (0, 0, 0));
  self._id_247B thread _id_40A1(self);
}

_id_40A1(var_0) {
  var_0 waittill("death");

  if(isDefined(self)) {
    self delete();
  }
}

_id_ADA9() {
  _id_10AB::_id_ADAD("sc_moon_airboss_ambient", ::_id_ADAA, ::_id_CC78);
}

_id_404B() {}

_id_ADAA() {
  level._id_EC85["generic"]["shipcrib_hangar_phone_idle_01"][0] = % shipcrib_hangar_phone_idle_01;
  level._id_EC85["generic"]["shipcrib_hangar_sweeping_01_guy"][0] = % shipcrib_hangar_sweeping_01_guy;
  level._id_EC85["generic"]["Shipcrib_hangar_scrubbing_02_guy"][0] = % shipcrib_hangar_scrubbing_02_guy;
  level._id_EC85["generic"]["shipcrib_air_control_window_3_guyB"][0] = % shipcrib_air_control_window_3_guyb;
  level._id_EC85["generic"]["shipcrib_drill_sargent_02"][0] = % shipcrib_drill_sargent_02;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_03"][0] = % shipcrib_stand_stationary_talk_idle_03;
  level._id_EC85["generic"]["shipcrib_hangar_crate_move01_walk_guyA"] = % shipcrib_hangar_crate_move01_walk_guya;
  level._id_EC85["generic"]["shipcrib_hangar_crate_move01_walk_guyB"] = % shipcrib_hangar_crate_move01_walk_guyb;
  _id_ADAB();
}

#using_animtree("script_model");

_id_ADAB() {
  level._id_EC8C["broom"] = "equipment_push_broom_01";
  level._id_EC87["broom"] = #animtree;
  level._id_EC85["broom"]["shipcrib_hangar_sweeping_01_guy"][0] = % shipcrib_hangar_sweeping_01_broom;
  level._id_EC8C["brush"] = "misc_scrub_brush";
  level._id_EC87["brush"] = #animtree;
  level._id_EC85["brush"]["Shipcrib_hangar_scrubbing_02_guy"][0] = % shipcrib_hangar_scrubbing_02_brush;
  level._id_EC87["crate_a"] = #animtree;
  level._id_EC8C["crate_a"] = "crates_plastic_tech_01";
  level._id_EC85["crate_a"]["shipcrib_hangar_crate_move01_walk_guyA"] = % shipcrib_hangar_crate_move01_walk_boxa;
  level._id_EC87["crate_b"] = #animtree;
  level._id_EC8C["crate_b"] = "crates_plastic_tech_01";
  level._id_EC85["crate_b"]["shipcrib_hangar_crate_move01_walk_guyA"] = % shipcrib_hangar_crate_move01_walk_boxb;
}

_id_CC78(var_0) {
  var_1 = getarraykeys(var_0);

  foreach(var_3 in var_1) {
    var_4 = var_0[var_3];

    switch (var_3) {
      case "hallway_bully":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
        break;
      case "hallway_victim":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
        break;
      case "hallway_phoneguy":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
        break;
      case "hallway_boxguy1":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.07);
        break;
      case "hallway_boxguy2":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.07);
        break;
      case "hallway_sweeper":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
        break;
      case "hallway_observer1":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.3);
        break;
      case "hallway_observer2":
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
        break;
      default:
        var_4 thread _id_10AB::_id_1F5E(0.0, 0.0);
    }
  }
}

_id_8AB4() {
  scripts\engine\utility::flag_wait("shipcrib_moon_prime_tr_loaded");
  level thread _id_10A4::_id_3B9D(1, 1, 1, 1, 0, 0, 0, 0, 0, 0);
  level._id_E35D._id_47D9._id_67A7 = _id_0EFB::_id_7CBE("hangar_crane_pos", "targetname", "europa_leaving");
  level._id_E35D._id_47D9 moveTo(level._id_E35D._id_47D9._id_67A7.origin, 0.05);
  _id_0EDF::_id_E38E("basket_open", 0.05);
  level._id_E35D._id_47D9 _meth_82A2(%crane_hangar_large_02_down, 0.5, 0.05);
  _id_10AB::_id_ADAD("sc_moon_ambient_returndeck", ::_id_ADDC, ::_id_CDA3);
  scripts\engine\utility::flag_wait("shipcrib_moon_prime_tr_loaded");
  level thread _id_8AB8();
}

_id_8AB8() {
  _id_ADDC();
  level._id_E44C = [];
  var_0 = [];
  var_1 = scripts\engine\utility::getStructArray("sc_moon_ambient_returndeck_fire", "targetname");

  foreach(var_3 in var_1) {
    switch (var_3.script_parameters) {
      case "flightdeck_red":
        var_4 = _id_0EF8::_id_FDFC("spawner_flightdeck_ordnance", var_3, "cheap");
        var_4.struct = var_3;
        var_0[var_0.size] = var_4;
        break;
      case "flightdeck_green":
        var_4 = _id_0EF8::_id_FDFC("spawner_flightdeck_maintenance", var_3, "cheap");
        var_4.struct = var_3;
        var_0[var_0.size] = var_4;
        break;
      case "flightdeck_blue":
        var_4 = _id_0EF8::_id_FDFC("spawner_flightdeck_handler", var_3, "cheap");
        var_4.struct = var_3;
        var_0[var_0.size] = var_4;
        break;
    }
  }

  foreach(var_7 in var_0) {
    var_7 _id_0EFB::_id_FD6F("return_deck");
    var_7._id_6A41 = scripts\sp\utility::_id_10639("extinguisher");
    level._id_E44C = scripts\engine\utility::array_add(level._id_E44C, var_7._id_6A41);

    switch (var_7.struct.animation) {
      case "shipcrib_moon_extinguisher_guy01_run_in":
        var_7 thread _id_8AB9();
        break;
      case "shipcrib_moon_extinguisher_guy02_idle":
        var_7 thread _id_8ABA();
      case "shipcrib_moon_extinguisher_guy04_idle":
        var_7.struct thread scripts\sp\anim::_id_1EEA(var_7, var_7.struct.animation, "stop_loop");
        var_7.struct thread scripts\sp\anim::_id_1EEA(var_7._id_6A41, var_7.struct.animation, "stop_loop");
        break;
    }
  }
}

_id_8ABA() {
  self endon("death");
  scripts\engine\utility::flag_wait("landing_on_returndeck");
  scripts\sp\utility::_id_10347("sc_moon_crw1_getthatfireout");
  wait 5;
  scripts\sp\utility::_id_10347("sc_moon_crw2_weneeddcteams");
  wait 10;
  scripts\sp\utility::_id_10347("sc_moon_crw2_cutthefuellines");
}

_id_8AB9() {
  self endon("death");
  var_0 = scripts\engine\utility::spawn_script_origin();
  var_0.angles = var_0.angles + (0, -90, 0);
  var_0 thread scripts\sp\anim::_id_1EEA(self, "stand_idle", "stop_loop");
  level waittill("return_door_closed");
  wait 10;
  var_0 notify("stop_loop");
  var_0 delete();
  self _meth_83A1();
  self.struct thread scripts\sp\anim::_id_1F35(self._id_6A41, self.struct.animation);
  self.struct scripts\sp\anim::_id_1F35(self, self.struct.animation);
  self.struct thread scripts\sp\anim::_id_1EEA(self, "shipcrib_moon_extinguisher_guy01_idle", "stop_loop");
  self.struct thread scripts\sp\anim::_id_1EEA(self._id_6A41, "shipcrib_moon_extinguisher_guy01_idle", "stop_loop");
}

_id_8A7F(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "";
  }

  level thread _id_10A2::_id_1A5D();
  level thread _id_10A4::_id_3B9D();
  _id_0EDF::_id_E38E("unload", 0.05);

  if(var_0 == "armory") {} else {
    level thread _id_8A93();
    level thread _id_10AB::_id_ADAD("sc_moon_ambient_leavedeck", ::_id_ADDC, ::_id_CDA1);
    _id_0EF9::_id_FE03("apc", "hangar_apc");
    var_1 = getvehiclenode("hangar_apc", "targetname");
    level._id_FD6E._id_209C["hangar_apc"] vehicle_teleport(var_1.origin, var_1.angles);
    level._id_FD6E._id_209C["hangar_apc"] vehicle_setspeedimmediate(1.5, 1, 1);
    level._id_FD6E._id_209C["hangar_apc"] startpath(var_1);
  }

  _id_0EEB::_id_7976("gravity") waittill("move_finished");
  scripts\engine\utility::waitframe();
  _id_0EEB::_id_7976("gravity") waittill("move_finished");
  _id_0EFB::_id_FDBB("leave_deck");
  _id_0EFB::_id_FDE8(level._id_FD6E._id_7316);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_209C);
}

_id_8A93() {
  var_0 = _id_0EF9::_id_FE03("forklift", "airboss_forklift_b");
  var_0 endon("entitydeleted");
  wait 6;
  var_0 _id_0EED::_id_7309("airboss_forklift_b_cargo");
  var_0 _id_0EED::_id_730A("airboss_forklift_b");
}