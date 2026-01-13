/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3825.gsc
*********************************************/

func_9739() {
  level.var_FDBE = spawnStruct();
  level.var_FDBE func_985A();
  level.var_FDBE func_9854();
}

func_789F(var_0) {
  self endon("death");
  if(!isDefined(level.var_FDBE)) {
    func_9739();
  }

  if(isDefined(var_0)) {
    var_1 = func_7C05(var_0);
    return var_1;
  }

  var_1 = func_7A8C(self);
  return var_1;
}

func_7BF4(var_0) {
  var_1 = func_789F(var_0);
  var_2 = func_7BEA(var_1);
  return var_2;
}

func_173F() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_slt_sir";
  var_0[var_0.size] = "shipcrib_slt_captain";
  var_0[var_0.size] = "shipcrib_slt_raider";
  self.var_A594["salter"] = var_0;
  var_0 = [];
  var_0[var_0.size] = "shipcrib_slt_sir";
  var_0[var_0.size] = "shipcrib_slt_captain";
  var_0[var_0.size] = "shipcrib_slt_raider";
  self.var_A594["salter_downbeat"] = var_0;
  var_0 = [];
  var_0[var_0.size] = "shipcrib_slt_sir";
  var_0[var_0.size] = "shipcrib_slt_captain";
  var_0[var_0.size] = "shipcrib_slt_raider";
  self.var_A594["salter_serious"] = var_0;
  var_0 = [];
  var_0[var_0.size] = "shipcrib_slt_sir";
  var_0[var_0.size] = "shipcrib_slt_raider";
  self.var_A594["salter_moon"] = var_0;
}

func_16D2() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_eth_sir";
  var_0[var_0.size] = "shipcrib_eth_captain";
  self.var_A594["ethan"] = var_0;
}

func_16D3() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_eth_sir";
  self.var_A594["ethan_moon"] = var_0;
}

func_1724() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_omr_captain";
  self.var_A594["omar"] = var_0;
}

func_1702() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_ksh_sir";
  var_0[var_0.size] = "shipcrib_ksh_captain1";
  var_0[var_0.size] = "shipcrib_ksh_captain2";
  self.var_A594["kash"] = var_0;
}

func_1703() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_ksh_sir";
  self.var_A594["kash_moon"] = var_0;
}

func_16A7() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_brk_sir";
  var_0[var_0.size] = "shipcrib_brk_captain";
  var_0[var_0.size] = "shipcrib_brk_captainreyes";
  var_0[var_0.size] = "shipcrib_brk_sir2";
  var_0[var_0.size] = "shipcrib_brk_captain2";
  var_0[var_0.size] = "shipcrib_brk_captainreyes2";
  self.var_A594["brooks"] = var_0;
}

func_16E3() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_gbs_sir2";
  var_0[var_0.size] = "shipcrib_gbs_captain2";
  var_0[var_0.size] = "shipcrib_gbs_captainreyes2";
  self.var_A594["gibson"] = var_0;
  var_0 = [];
  var_0[var_0.size] = "shipcrib_gbs_sir2";
  var_0[var_0.size] = "shipcrib_gbs_captain2";
  var_0[var_0.size] = "shipcrib_gbs_captainreyes2";
  self.var_A594["gibson_downbeat"] = var_0;
  var_0 = [];
  var_0[var_0.size] = "shipcrib_gbs_sir";
  var_0[var_0.size] = "shipcrib_gbs_captain";
  var_0[var_0.size] = "shipcrib_gbs_captainreyes";
  self.var_A594["gibson_upbeat"] = var_0;
}

func_16E4() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_gbs_sir2";
  self.var_A594["gibson_moon"] = var_0;
}

func_1708() {
  var_0 = [];
  var_0[var_0.size] = "Kloos Alias1";
  var_0[var_0.size] = "Kloos Alias2";
  var_0[var_0.size] = "Kloos Alias3";
  self.var_A594["kloos"] = var_0;
}

func_16DF() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_nav_sir";
  var_0[var_0.size] = "shipcrib_nav_captain";
  var_0[var_0.size] = "shipcrib_nav_commander";
  self.var_A594["gator"] = var_0;
}

func_171C() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_dpo_captainreyes";
  var_0[var_0.size] = "shipcrib_dpo_captain";
  var_0[var_0.size] = "shipcrib_dpo_sir";
  self.var_A594["drop_officer"] = var_0;
}

func_16A0() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_bts_captainreyes";
  var_0[var_0.size] = "shipcrib_bts_sir";
  var_0[var_0.size] = "shipcrib_bts_captain";
  self.var_A594["sotomura"] = var_0;
}

func_1743() {
  var_0 = [];
  var_0[var_0.size] = "Sipes Alias1";
  var_0[var_0.size] = "Sipes Alias2";
  var_0[var_0.size] = "Sipes Alias3";
  self.var_A594["sipes"] = var_0;
}

func_16B0() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_cmo_captain";
  var_0[var_0.size] = "shipcrib_cmo_commander";
  var_0[var_0.size] = "shipcrib_cmo_sir";
  self.var_A594["comms"] = var_0;
}

func_16E7() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_grf_sir1";
  var_0[var_0.size] = "shipcrib_grf_captain1";
  var_0[var_0.size] = "shipcrib_grf_captainreyes1";
  var_0[var_0.size] = "shipcrib_grf_sir2";
  var_0[var_0.size] = "shipcrib_grf_captain2";
  var_0[var_0.size] = "shipcrib_grf_captainreyes2";
  self.var_A594["griff"] = var_0;
}

func_16FD() {
  var_0 = [];
  var_0[var_0.size] = "Jack Alias1";
  var_0[var_0.size] = "Jack Alias2";
  var_0[var_0.size] = "Jack Alias3";
  self.var_A594["jack"] = var_0;
}

func_170B() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_mac_captainreyes";
  var_0[var_0.size] = "shipcrib_mac_sir";
  var_0[var_0.size] = "shipcrib_mac_commander";
  self.var_A594["mac"] = var_0;
}

func_16A2() {}

func_16A3() {
  var_0 = [];
  var_0[var_0.size] = "Broadcast PU2 Alias1";
  var_0[var_0.size] = "Broadcast PU2 Alias2";
  var_0[var_0.size] = "Broadcast PU2 Alias3";
  self.var_A594["broadcast_audience_pu2"] = var_0;
}

func_16A4() {
  var_0 = [];
  var_0[var_0.size] = "Broadcast3 Alias1";
  var_0[var_0.size] = "Broadcast3 Alias2";
  var_0[var_0.size] = "Broadcast3 Alias3";
  self.var_A594["broadcast_audience_03"] = var_0;
}

func_16A5() {
  var_0 = [];
  var_0[var_0.size] = "Broadcast4 Alias1";
  var_0[var_0.size] = "Broadcast4 Alias2";
  var_0[var_0.size] = "Broadcast4 Alias3";
  self.var_A594["broadcast_audience_04"] = var_0;
}

func_16A6() {
  var_0 = [];
  var_0[var_0.size] = "Broadcast9 Alias1";
  var_0[var_0.size] = "Broadcast9 Alias2";
  var_0[var_0.size] = "Broadcast9 Alias3";
  self.var_A594["broadcast_audience_09"] = var_0;
}

func_16E1() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_un1_captain2";
  var_0[var_0.size] = "shipcrib_un1_sir2";
  self.var_7741["male"]["generic_male_01"] = var_0;
  var_0 = [];
  var_0[var_0.size] = "shipcrib_un2_weregoodheresi";
  var_0[var_0.size] = "shipcrib_un2_sorrysirgotalottok";
  self.var_7741["male"]["generic_male_02"] = var_0;
  var_0 = [];
  var_0[var_0.size] = "shipcrib_un3_gotthingsundercon";
  var_0[var_0.size] = "shipcrib_un3_captain";
  self.var_7741["male"]["generic_male_03"] = var_0;
}

func_16E0() {
  var_0 = [];
  var_0[var_0.size] = "shipcrib_unf2_captain";
  var_0[var_0.size] = "shipcrib_unf2_youllhavetoexcus";
  self.var_7741["female"]["generic_female_01"] = var_0;
  var_0 = [];
  var_0[var_0.size] = "shipcrib_unf2_captain";
  var_0[var_0.size] = "shipcrib_unf2_youllhavetoexcus";
  self.var_7741["female"]["generic_female_02"] = var_0;
  var_0 = [];
  var_0[var_0.size] = "shipcrib_unf3_captainreyes";
  var_0[var_0.size] = "shipcrib_unf3_sir";
  self.var_7741["female"]["generic_female_03"] = var_0;
}

func_985A() {
  self.var_A594 = [];
  func_173F();
  func_16D2();
  func_16D3();
  func_1724();
  func_1702();
  func_1703();
  func_16A7();
  func_16E3();
  func_16E4();
  func_16DF();
  func_171C();
  func_16A0();
  func_1743();
  func_16E7();
  func_1708();
  func_16B0();
  func_16FD();
  func_170B();
  func_16A2();
  func_16A3();
  func_16A4();
  func_16A5();
  func_16A6();
}

func_9854() {
  self.var_7741 = [];
  self.var_7741["male"] = [];
  self.var_7741["female"] = [];
  func_16E1();
  func_16E0();
}

func_7C05(var_0) {
  if(isDefined(level.var_FDBE.var_A594[var_0])) {
    return level.var_FDBE.var_A594[var_0];
  }

  if(isDefined(level.var_FDBE.var_7741["male"][var_0])) {
    return level.var_FDBE.var_7741["male"][var_0];
  }

  if(isDefined(level.var_FDBE.var_7741["female"][var_0])) {
    return level.var_FDBE.var_7741["female"][var_0];
  }
}

func_7A8C(var_0) {
  if(isDefined(var_0.var_1FBB)) {
    if(var_0.var_1FBB == "generic") {
      var_1 = func_7BE9(var_0);
      return var_1;
    }

    if(isDefined(level.var_FDBE.var_A594[var_1.var_1FBB])) {
      var_1 = level.var_FDBE.var_A594[var_1.var_1FBB];
      return var_1;
    }

    var_1 = func_7BE9(var_1);
    return var_1;
  }
}

func_7BE9(var_0) {
  if(!isDefined(var_0.gender)) {
    var_0.gender = "male";
  }

  if(var_0.gender == "female") {
    var_1 = func_7BEA(level.var_FDBE.var_7741["female"]);
    return var_1;
  }

  var_1 = func_7BEA(level.var_FDBE.var_7741["male"]);
  scripts\engine\utility::waitframe();
  return var_1;
}

func_7BEA(var_0) {
  if(isarray(var_0)) {
    var_1 = randomint(var_0.size);
    if(!isDefined(var_0[var_1])) {
      var_2 = 0;
      foreach(var_4 in var_0) {
        if(var_2 == var_1) {
          return var_4;
        }

        var_2++;
      }

      return;
    }

    return var_4[var_5];
  }
}

func_7AED(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = lib_0EFB::func_7AF0();
  }

  if(isDefined(var_2)) {
    var_3 = func_7AEE(var_2);
    if(isDefined(var_3[var_0])) {
      return var_3[var_0];
    }

    return undefined;
  }

  return undefined;
}

func_7AEE(var_0) {
  if(!isDefined(level.var_FDC6)) {
    func_9865();
  }

  if(isDefined(var_0) && isDefined(level.var_FDC6[var_0])) {
    return level.var_FDC6[var_0];
  }

  return undefined;
}

func_7AEF() {
  var_0 = lib_0EFB::func_7C60();
  if(!isDefined(var_0)) {
    var_0 = lib_0EFB::func_7C5F();
  }

  var_1 = undefined;
  switch (var_0) {
    case "sa_vips":
      var_1 = "sa_vips";
      break;

    case "sa_empambush":
      var_1 = "sa_empambush";
      break;

    case "sa_assassination":
      var_1 = "sa_assassination";
      break;

    case "sa_wounded":
      var_1 = "sa_wounded";
      break;

    case "sa_jackalarena":
      var_1 = "sa_jackalarena";
      break;

    case "sa_moon":
      var_1 = "ml_moon";
      break;

    case "titan":
      var_1 = "ml_titan";
      break;

    case "rogue":
      var_1 = "ml_rogue";
      break;

    case "prisoner":
      var_1 = "ml_prisoner";
      break;

    case "ja_asteroid":
      var_1 = "ja_asteroid";
      break;

    case "ja_mining":
      var_1 = "ja_mining";
      break;

    case "ja_spacestation":
      var_1 = "ja_spacestation";
      break;

    case "ja_titan":
      var_1 = "ja_titan";
      break;

    case "ja_wreckage":
      var_1 = "ja_wreckage";
      break;
  }

  return var_1;
}

func_9865() {
  var_0 = [];
  var_0["sa_vips"] = func_173D();
  var_0["sa_empambush"] = func_173A();
  var_0["sa_assassination"] = func_1738();
  var_0["sa_wounded"] = func_173E();
  var_0["ja_asteroid"] = func_16F8();
  var_0["ja_mining"] = func_16F9();
  var_0["ja_spacestation"] = func_16FA();
  var_0["ja_titan"] = func_16FB();
  var_0["ja_wreckage"] = func_16FC();
  var_0["ml_moon"] = func_1712();
  var_0["ml_titan"] = func_1715();
  var_0["ml_rogue"] = func_1714();
  var_0["ml_prisoner"] = func_1713();
  level.var_FDC6 = var_0;
}

func_1738() {
  var_0 = [];
  var_0["armory_terminal_entrance"] = ["sc_wnd_grf_gotafullinvento_spk"];
  var_0["armory_terminal_entrance_griff"] = ["sc_wnd_grf_gotafullinvento"];
  var_0["armory_terminal"] = ["sc_asn_grf_illbegivinyousu_spk", "sc_asn_grf_andsetdefusesbo_spk", "sc_asn_grf_hacksandshockgr_spk"];
  var_0["armory_terminal_exit"] = ["sc_asn_grf_goodhuntinyoutw_spk"];
  var_0["jackal_launch"] = ["sc_asn_slt_oncewedebarkwes", "sc_asn_plr_rogerletshitit", "sc_asn_amb_scar1stoweradvi", "sc_asn_slt_check", "sc_asn_plr_copy", 4, "sc_asn_amb_scarsyouaregree", "sc_asn_plr_rogersendit", "sc_asn_amb_launchin321"];
  var_0["salter_elevator_exit"] = "assa_elevator_exit_alias";
  var_0["salter_walkntalk"] = ["assa_walkntalk_alias1", "assa_walkntalk_alias2"];
  var_0["salter_bridgedoor_reaction"] = "assa_bridgedoor_alias";
  var_0["welcome_line"] = ["sc_asn_nav_welcomebacksir", "sc_asn_slt_ibriefedeveryon"];
  var_0["gator_opsmap_reaction"] = "sc_asn_nav_youvegotthemrun";
  var_0["dropo_opsmap_reaction"] = "sc_asn_dpo_theyrestillprob";
  var_0["salter_opsmap_reaction"] = "sc_asn_slt_nexttimeyouandm";
  var_0["boats_opsmap_reaction"] = "assa_boats_opsmap_alias";
  var_0["commo_opsmap_reaction"] = "assa_commo_opsmap_alias";
  var_0["directfeedback1"] = ["assa_directfeedback1A_alias", "assa_directfeedback1B_alias"];
  var_0["directfeedback2"] = "assa_directfeedback2_alias";
  var_0["directfeedback3"] = "assa_directfeedback3_alias";
  var_0["directfeedback4"] = "assa_directfeedback4_alias";
  var_0["ambientfeedback1"] = ["sc_asn_cm3_iheardthathekil", "sc_asn_cm4_thewholecommand", "sc_asn_cm3_yeahsetdefmustb"];
  var_0["ambientfeedback2"] = "";
  return var_0;
}

func_173A() {
  var_0 = [];
  var_0["armory_terminal_entrance"] = ["sc_emp_grf_hardwarespreppe_spk"];
  var_0["armory_terminal_entrance_griff"] = ["sc_emp_grf_hardwarespreppe"];
  var_0["armory_terminal"] = ["sc_emp_grf_suppressedebrre_spk", "sc_emp_grf_trustmeyouwontg_spk"];
  var_0["armory_terminal_exit"] = ["sc_emp_grf_watchyourbackou_spk"];
  var_0["jackal_launch"] = ["sc_emp_nav_sirwevegotyouin", "sc_emp_plr_solidcopy", "sc_emp_slt_raiderhowwetaki", "sc_emp_plr_welldisablethec", "sc_emp_slt_rogerthatletspu", "sc_emp_amb_1112toweradvise", "sc_emp_slt_12", "sc_emp_plr_11", 2, "sc_emp_amb_scarsarelockedf", "sc_emp_plr_rogercountit", "sc_emp_amb_launchin321"];
  var_0["salter_elevator_exit"] = "emp_elevator_exit_alias";
  var_0["salter_walkntalk"] = ["emp_walkntalk_alias1", "emp_walkntalk_alias2"];
  var_0["salter_bridgedoor_reaction"] = "emp_bridgedoor_alias";
  var_0["welcome_line"] = "sc_emp_nav_thesdfcerberusw";
  var_0["gator_opsmap_reaction"] = ["sc_emp_slt_notabaddayswork", "sc_emp_nav_wellexecutedina"];
  var_0["dropo_opsmap_reaction"] = "sc_emp_dpo_gladyouandthelt";
  var_0["salter_opsmap_reaction"] = "sc_emp_slt_impressiveoutth";
  var_0["boats_opsmap_reaction"] = "emp_boats_opsmap_alias";
  var_0["commo_opsmap_reaction"] = "emp_commo_opsmap_alias";
  var_0["directfeedback1"] = "emp_directfeedback1_alias";
  var_0["directfeedback2"] = ["emp_directfeedback2A_alias", "emp_directfeedback2B_alias"];
  var_0["directfeedback3"] = "emp_directfeedback3_alias";
  var_0["directfeedback4"] = "emp_directfeedback4_alias";
  var_0["ambientfeedback1"] = ["sc_emp_cm3_hahahayepcaptai", "sc_emp_cm4_nicesoundsliket", "sc_emp_cm3_absolutelymeanw"];
  var_0["ambientfeedback2"] = "";
  return var_0;
}

func_173D() {
  var_0 = [];
  var_0["armory_terminal_entrance"] = ["sc_vips_grf_gotafreshbatcho_spk"];
  var_0["armory_terminal_entrance_griff"] = ["sc_vips_grf_gotafreshbatcho"];
  var_0["armory_terminal"] = ["sc_vips_grf_itackedonsuppre_spk"];
  var_0["armory_terminal_exit"] = ["sc_vips_grf_idsayyoutwoarer_spk"];
  var_0["jackal_launch"] = ["sc_vips_plr_youandkashallse", "sc_vips_slt_tightwerelit", "sc_vips_plr_brooks", "sc_vips_brk_thumbsupsir", "sc_vips_plr_towerscarsaregr", "sc_vips_eth_captainillbeyou", "sc_vips_plr_copythat", "sc_vips_amb_1112toweradvise", "sc_vips_slt_copy12", "sc_vips_plr_11copy", 2, "sc_vips_amb_scarsarelockedf", "sc_vips_plr_rogercountit", "sc_vips_amb_launchin321"];
  var_0["salter_elevator_exit"] = "vips_elevator_exit_alias";
  var_0["salter_walkntalk"] = ["vips_walkntalk_alias1", "vips_walkntalk_alias2"];
  var_0["salter_bridgedoor_reaction"] = "vips_bridgedoor_alias";
  var_0["welcome_line"] = "sc_vips_nav_thatdefinitelyp";
  var_0["welcome_line_failure"] = "sc_vips_nav_salutecaptainso";
  var_0["gator_opsmap_reaction"] = "shipcrib_nav_hellofaday";
  var_0["dropo_opsmap_reaction"] = "sc_vips_dpo_griffsbeenitchi";
  var_0["salter_opsmap_reaction"] = "sc_vips_slt_iwonderwhatothe";
  var_0["boats_opsmap_reaction"] = "vips_boats_opsmap_alias";
  var_0["commo_opsmap_reaction"] = "vips_commo_opsmap_alias";
  var_0["directfeedback1"] = ["vips_directfeedback1A_alias", "vips_directfeedback1B_alias"];
  var_0["directfeedback2"] = "vips_directfeedback2_alias";
  var_0["directfeedback3"] = "vips_directfeedback3_alias";
  var_0["directfeedback4"] = "vips_directfeedback4_alias";
  var_0["ambientfeedback1"] = ["sc_vips_cm3_imonmywaytoengi", "sc_vips_cm4_nohowdidyouseei", "sc_vips_cm3_oneofthebenefit"];
  var_0["ambientfeedback2"] = "";
  return var_0;
}

func_173E() {
  var_0 = [];
  var_0["armory_terminal_entrance"] = ["sc_wnd_amo_readytochooseyour_spk"];
  var_0["armory_terminal_entrance_griff"] = ["sc_wnd_amo_readytochooseyour"];
  var_0["armory_terminal"] = ["sc_wnd_grf_idrecommendalig_spk", "sc_wnd_grf_theycanlaydowns_spk", "sc_wnd_grf_getchaoutofapin_spk"];
  var_0["armory_terminal_exit"] = ["sc_wnd_grf_yourelockedandl_spk"];
  var_0["jackal_launch"] = ["sc_wnd_eth_captainivepulle", "sc_wnd_plr_roger", "sc_wnd_plr_feveryouset", "sc_wnd_slt_burninletsgo", 2, "sc_wnd_amb_scarstoweradvis", "sc_wnd_plr_roger11", "sc_wnd_slt_check12", 6, "sc_wnd_amb_scar11yourelock", "sc_wnd_plr_rogerweregreen", "sc_wnd_amb_launchin321"];
  var_0["salter_elevator_exit"] = "wound_elevator_exit_alias";
  var_0["salter_walkntalk"] = ["wound_walkntalk_alias1", "wound_walkntalk_alias2"];
  var_0["salter_bridgedoor_reaction"] = "wound_bridgedoor_alias";
  var_0["welcome_line"] = "sc_wnd_nav_roughskiesoutth";
  var_0["gator_opsmap_reaction"] = "sc_wnd_nav_thesuccessofthi";
  var_0["dropo_opsmap_reaction"] = "sc_wnd_dpo_thatwasabraveru";
  var_0["salter_opsmap_reaction"] = "sc_wnd_slt_nothinglikedrop";
  var_0["boats_opsmap_reaction"] = "wound_boats_opsmap_alias";
  var_0["commo_opsmap_reaction"] = "wound_commo_opsmap_alias";
  var_0["directfeedback1"] = ["wound_directfeedback1A_alias", "wound_directfeedback1B_alias"];
  var_0["directfeedback2"] = "wound_directfeedback2_alias";
  var_0["directfeedback3"] = "wound_directfeedback3_alias";
  var_0["directfeedback4"] = "wound_directfeedback4_alias";
  var_0["ambientfeedback1"] = ["sc_wnd_cm3_idontknowwordar", "sc_wnd_cm4_ohmanthatsahuge", "sc_wnd_cm3_exactlyimpretty"];
  var_0["ambientfeedback2"] = "";
  return var_0;
}

func_16F8() {
  var_0 = [];
  var_0["armory_terminal_entrance"] = [""];
  var_0["armory_terminal"] = [""];
  var_0["armory_terminal_exit"] = [""];
  var_0["jackal_launch"] = ["ja_ast_slt_thissoundslikea", "ja_ast_plr_letsnotjinxit", "ja_ast_slt_yougettinsupers", "ja_ast_plr_imgettincareful", "ja_ast_slt_rogerthat", "ja_ast_slt_firstthingwenee", "ja_ast_plr_affirmativeyoua", "ja_ast_slt_rogerthatraider", "ja_ast_amb_1112toweradvise", "ja_ast_plr_rog", "ja_ast_slt_12check", "ja_ast_amb_scarsarelocked", "ja_ast_plr_rogerweregreen", "ja_ast_amb_launchin321"];
  var_0["salter_elevator_exit"] = "ja_roid_elevator_exit_alias";
  var_0["salter_walkntalk"] = ["ja_roid_walkntalk_alias1", "ja_roid_walkntalk_alias2"];
  var_0["salter_bridgedoor_reaction"] = "ja_roid_bridgedoor_alias";
  var_0["welcome_line"] = "ja_ast_nav_welcomebacksirw";
  var_0["gator_opsmap_reaction"] = "ja_ast_nav_gladtohaveyouba";
  var_0["dropo_opsmap_reaction"] = "ja_ast_dpo_iwassecondsaway";
  var_0["salter_opsmap_reaction"] = "ja_ast_slt_fornowithinkits";
  var_0["boats_opsmap_reaction"] = "ja_roid_boats_opsmap_alias";
  var_0["commo_opsmap_reaction"] = "ja_roid_commo_opsmap_alias";
  var_0["directfeedback1"] = "ja_roid_directfeedback1_alias";
  var_0["directfeedback2"] = "ja_roid_directfeedback2_alias";
  var_0["directfeedback3"] = "ja_roid_directfeedback3_alias";
  var_0["directfeedback4"] = "ja_roid_directfeedback4_alias";
  var_0["ambientfeedback1"] = ["ja_ast_un1_lottapressureri", "ja_ast_un2_dontletthemgeti", "ja_ast_un1_yourerightcapta"];
  var_0["ambientfeedback2"] = "";
  return var_0;
}

func_16F9() {
  var_0 = [];
  var_0["armory_terminal_entrance"] = [""];
  var_0["armory_terminal"] = [""];
  var_0["armory_terminal_exit"] = [""];
  var_0["jackal_launch"] = ["ja_mining_plr_wegottwoenemies", "ja_mining_slt_nothinwecanthan", "ja_mining_eth_sirretributionw", "ja_mining_plr_copywhatsourtim", "ja_mining_eth_minutessirwells", "ja_mining_plr_thisonesforomar", "ja_mining_eth_hellyescaptain", "ja_mining_amb_scar1stoweradvi", "ja_mining_plr_check11", "ja_mining_slt_rog", "ja_mining_amb_launchin321"];
  var_0["salter_elevator_exit"] = "ja_mine_elevator_exit_alias";
  var_0["salter_walkntalk"] = ["ja_mine_walkntalk_alias1", "ja_mine_walkntalk_alias2"];
  var_0["salter_bridgedoor_reaction"] = "ja_mine_bridgedoor_alias";
  var_0["welcome_line"] = "ja_mining_nav_captainyouhadme";
  var_0["gator_opsmap_reaction"] = "ja_mining_nav_wheretonextsir";
  var_0["dropo_opsmap_reaction"] = "ja_mining_dpo_welcomebackcapt";
  var_0["salter_opsmap_reaction"] = "ja_mining_slt_readyformoreico";
  var_0["boats_opsmap_reaction"] = "ja_mine_boats_opsmap_alias";
  var_0["commo_opsmap_reaction"] = "ja_mine_commo_opsmap_alias";
  var_0["directfeedback1"] = "ja_mine_directfeedback1_alias";
  var_0["directfeedback2"] = "ja_mine_directfeedback2_alias";
  var_0["directfeedback3"] = "ja_mine_directfeedback3_alias";
  var_0["directfeedback4"] = "ja_mine_directfeedback4_alias";
  var_0["ambientfeedback1"] = ["ja_mining_un1_manittookgutsgo", "ja_mining_un2_idontthinkthere", "ja_mining_un1_thatshowscarsdo"];
  var_0["ambientfeedback2"] = ["ja_mining_un5_onestepupforthe", "ja_mining_un5_thewaythisshipa"];
  return var_0;
}

func_16FA() {
  var_0 = [];
  var_0["armory_terminal_entrance"] = [""];
  var_0["armory_terminal"] = [""];
  var_0["armory_terminal_exit"] = [""];
  var_0["jackal_launch"] = ["ja_spstation_slt_wellencounterhe", "ja_spstation_plr_goodcallwereput", "ja_spstation_slt_gatorsgotthecon", "ja_spstation_plr_readyforadogfig", "ja_spstation_slt_cantwait", "ja_spstation_nav_captainwererigh", "ja_spstation_plr_copythattellthe", "ja_spstation_nav_yessir", "ja_spstation_slt_tellthemthecavalry", "ja_spstation_amb_scar1stoweradvi", "ja_spstation_plr_check11", "ja_spstation_slt_12", "ja_spstation_amb_scar1syourelock", "ja_spstation_plr_roger", "ja_spstation_amb_launchin321"];
  var_0["salter_elevator_exit"] = "ja_station_elevator_exit_alias";
  var_0["salter_walkntalk"] = ["ja_station_walkntalk_alias1", "ja_station_walkntalk_alias2"];
  var_0["salter_bridgedoor_reaction"] = "ja_station_bridgedoor_alias";
  var_0["welcome_line"] = "ja_spstation_nav_captainhastheco";
  var_0["gator_opsmap_reaction"] = "ja_spstation_nav_wearestandingby";
  var_0["dropo_opsmap_reaction"] = "ja_spstation_dpo_largescalebattl";
  var_0["salter_opsmap_reaction"] = "ja_spstation_slt_letsgoseeifsdfi";
  var_0["boats_opsmap_reaction"] = "ja_station_boats_opsmap_alias";
  var_0["commo_opsmap_reaction"] = "ja_station_commo_opsmap_alias";
  var_0["directfeedback1"] = "ja_station_directfeedback1_alias";
  var_0["directfeedback2"] = "ja_station_directfeedback2_alias";
  var_0["directfeedback3"] = "ja_station_directfeedback3_alias";
  var_0["directfeedback4"] = "ja_station_directfeedback4_alias";
  var_0["ambientfeedback1"] = ["ja_spstation_un1_theyretryingtor", "ja_spstation_un2_olympusmonsistw", "ja_spstation_un1_everyshipsgotaw"];
  var_0["ambientfeedback2"] = "";
  return var_0;
}

func_16FB() {
  var_0 = [];
  var_0["armory_terminal_entrance"] = [""];
  var_0["armory_terminal"] = [""];
  var_0["armory_terminal_exit"] = [""];
  var_0["jackal_launch"] = ["ja_titan_slt_backtotitan", "ja_titan_plr_gottabedone", "ja_titan_slt_canyoutrytomake", "ja_titan_plr_youwerecaptainf", "ja_titan_slt_notmybag", "ja_titan_plr_toobadiwasgonna", "ja_titan_slt_dontyoudare", "ja_titan_eth_illbeyoureyesfr", "ja_titan_plr_copyethansetdef", "ja_titan_eth_paybacksir", "ja_titan_slt_damnstraighteth", "ja_titan_amb_scar1stoweradvi", "ja_titan_plr_roger11check", "ja_titan_slt_check12", "ja_titan_amb_scarsarelockeda", "ja_titan_plr_punchit", "ja_titan_amb_launchin321"];
  var_0["salter_elevator_exit"] = "ja_titan_elevator_exit_alias";
  var_0["salter_walkntalk"] = ["ja_titan_walkntalk_alias1", "ja_titan_walkntalk_alias2"];
  var_0["salter_bridgedoor_reaction"] = "ja_titan_bridgedoor_alias";
  var_0["welcome_line"] = "ja_titan_nav_jackpotsquareda";
  var_0["gator_opsmap_reaction"] = "ja_titan_nav_preppingtoleave";
  var_0["dropo_opsmap_reaction"] = "ja_titan_dpo_thanksforcleari";
  var_0["salter_opsmap_reaction"] = "ja_titan_slt_anothersetdeffl";
  var_0["boats_opsmap_reaction"] = "ja_titan_boats_opsmap_alias";
  var_0["commo_opsmap_reaction"] = "ja_titan_commo_opsmap_alias";
  var_0["directfeedback1"] = "ja_titan_directfeedback1_alias";
  var_0["directfeedback2"] = "ja_titan_directfeedback2_alias";
  var_0["directfeedback3"] = "ja_titan_directfeedback3_alias";
  var_0["directfeedback4"] = "ja_titan_directfeedback4_alias";
  var_0["ambientfeedback1"] = ["ja_titan_un2_iwonderwhathapp", "ja_titan_un1_itssetdefwhatdo", "ja_titan_un2_manimgladthecap", "ja_titan_un5_yeahyoudthinkwi", "ja_titan_un5_goodthingtooloo"];
  var_0["ambientfeedback2"] = "";
  return var_0;
}

func_16FC() {
  var_0 = [];
  var_0["armory_terminal_entrance"] = [""];
  var_0["armory_terminal"] = [""];
  var_0["armory_terminal_exit"] = [""];
  var_0["jackal_launch"] = ["ja_wreck_slt_thisshouldtakec", "ja_wreck_plr_thatswhatitscomedown", "ja_wreck_slt_wecantletsetdef", "ja_wreck_plr_idontthinktheyll", "ja_wreck_slt_rogerthat", "ja_wreck_nav_captainsdfskelters", "ja_wreck_plr_rogeranyintelon", "ja_wreck_nav_lotsofdebirs", "ja_wreck_slt_soundlikefun", "ja_wreck_amb_scarstoweradvis", "ja_wreck_plr_11check", "ja_wreck_slt_12check", "ja_wreck_amb_scar1syouregood", "ja_wreck_plr_copythat", "ja_wreck_amb_launchin321"];
  var_0["salter_elevator_exit"] = "ja_wreck_elevator_exit_alias";
  var_0["salter_walkntalk"] = ["ja_wreck_walkntalk_alias1", "ja_wreck_walkntalk_alias2"];
  var_0["salter_bridgedoor_reaction"] = "ja_wreck_bridgedoor_alias";
  var_0["welcome_line"] = "ja_wreck_nav_anotherjobwelld";
  var_0["gator_opsmap_reaction"] = "ja_wreck_nav_wehavenotyetsto";
  var_0["dropo_opsmap_reaction"] = "ja_wreck_dpo_thatdestroyerwa";
  var_0["salter_opsmap_reaction"] = "ja_wreck_slt_setdefcankeepma";
  var_0["boats_opsmap_reaction"] = "ja_wreck_boats_opsmap_alias";
  var_0["commo_opsmap_reaction"] = "ja_wreck_commo_opsmap_alias";
  var_0["directfeedback1"] = "ja_wreck_directfeedback1_alias";
  var_0["directfeedback2"] = "ja_wreck_directfeedback2_alias";
  var_0["directfeedback3"] = "ja_wreck_directfeedback3_alias";
  var_0["directfeedback4"] = "ja_wreck_directfeedback4_alias";
  var_0["ambientfeedback1"] = ["ja_wreck_un2_theyweregettini", "ja_wreck_un1_yeahtheystitche", "ja_wreck_un2_nahcapnknowshow"];
  var_0["ambientfeedback2"] = "";
  return var_0;
}

func_1712() {
  var_0 = [];
  var_0["armory_terminal_entrance"] = [""];
  var_0["armory_terminal"] = ["sc_moon_grf_youregoingtowalt", 1, "sc_moon_grf_gotsomeattach", 1, "sc_moon_grf_nowtoroundyou", "sc_moon_grf_igotfraggrenade"];
  var_0["armory_terminal_exit"] = [""];
  var_0["salter_elevator_exit"] = "moon_elevator_exit_alias";
  var_0["salter_walkntalk"] = ["moon_walkntalk_alias1", "moon_walkntalk_alias2"];
  var_0["salter_bridgedoor_reaction"] = "moon_bridgedoor_alias";
  var_0["welcome_line"] = "moon_welcome_alias";
  var_0["gator_opsmap_reaction"] = "moon_gator_opsmap_alias";
  var_0["boats_opsmap_reaction"] = "moon_boats_opsmap_alias";
  var_0["commo_opsmap_reaction"] = "moon_commo_opsmap_alias";
  var_0["dropo_opsmap_reaction"] = "moon_dropo_opsmap_alias";
  var_0["salter_opsmap_reaction"] = "moon_salter_opsmap_alias";
  var_0["directfeedback1"] = "moon_directfeedback1_alias";
  var_0["directfeedback2"] = "moon_directfeedback2_alias";
  var_0["ambientfeedback1"] = ["sc_europa_un3_imtellingyouthe", "sc_europa_un4_whenitblewitup", "sc_europa_un3_mightaswellvebe"];
  var_0["ambientfeedback2"] = "";
  return var_0;
}

func_1715() {
  var_0 = [];
  var_0["armory_terminal"] = ["sc_titan_grf_headedtotitanhu", 0.33, "sc_titan_grf_ashieldwillhelpsp"];
  var_0["armory_terminal_exit"] = [1.5, "sc_titan_grf_gearscominup", 1.8, "sc_titan_grf_themanknowswhat", 0.25, "sc_titan_grf_goodlucksir"];
  var_0["salter_elevator_exit"] = "titan_elevator_exit_alias";
  var_0["salter_walkntalk"] = ["titan_walkntalk_alias1", "titan_walkntalk_alias2"];
  var_0["salter_bridgedoor_reaction"] = "titan_bridgedoor_alias";
  var_0["welcome_line"] = "titan_welcome_alias";
  var_0["gator_opsmap_reaction"] = "titan_gator_opsmap_alias";
  var_0["boats_opsmap_reaction"] = "titan_boats_opsmap_alias";
  var_0["commo_opsmap_reaction"] = "titan_commo_opsmap_alias";
  var_0["dropo_opsmap_reaction"] = "titan_dropo_opsmap_alias";
  var_0["salter_opsmap_reaction"] = "titan_salter_opsmap_alias";
  var_0["directfeedback1"] = "titan_directfeedback1_alias";
  var_0["directfeedback2"] = ["titan_directfeedback2_alias", "titan_directfeedback2_alias", "titan_directfeedback2_alias"];
  var_0["directfeedback3"] = "titan_directfeedback3_alias";
  var_0["directfeedback4"] = "titan_directfeedback4_alias";
  var_0["ambientfeedback1"] = ["sc_rogue_un3_iheardwelostano", "sc_rogue_un4_youdidntgetther", "sc_rogue_un3_captainsgotnine"];
  var_0["ambientfeedback2"] = ["sc_rogue_un1_icantbelievethey", "sc_rogue_un2_rumorishes", "sc_rogue_un1_soundslikeweneed", "sc_rogue_un2_youknowwedallbe"];
  return var_0;
}

func_1714() {
  var_0 = [];
  var_0["armory_terminal"] = ["sc_rogue_grf_nothingbutclosequarters1", 1, "sc_rogue_grf_gotsomeofmacs", 3, "sc_rogue_grf_addedprotectionisalways1", "sc_rogue_grf_workerbotshelpminethe1"];
  var_0["armory_terminal_exit"] = "sc_rogue_grf_thatlldoyourig";
  var_0["salter_elevator_exit"] = "rogue_elevator_exit_alias";
  var_0["salter_walkntalk"] = ["rogue_walkntalk_alias1", "rogue_walkntalk_alias2"];
  var_0["salter_bridgedoor_reaction"] = "rogue_bridgedoor_alias";
  var_0["welcome_line"] = "rogue_welcome_alias";
  var_0["gator_opsmap_reaction"] = "rogue_gator_opsmap_alias";
  var_0["boats_opsmap_reaction"] = "rogue_boats_opsmap_alias";
  var_0["commo_opsmap_reaction"] = "rogue_commo_opsmap_alias";
  var_0["dropo_opsmap_reaction"] = "rogue_dropo_opsmap_alias";
  var_0["salter_opsmap_reaction"] = "rogue_salter_opsmap_alias";
  var_0["directfeedback1"] = "rogue_directfeedback1_alias";
  var_0["directfeedback2"] = "rogue_directfeedback2_alias";
  var_0["ambientfeedback1"] = ["sc_prisoner_un3_yougetyournexta", "sc_prisoner_un4_nonotyet", "sc_prisoner_un3_haventheardanyt", "sc_prisoner_un4_thatsnotlikehim"];
  var_0["ambientfeedback2"] = "";
  return var_0;
}

func_1713() {
  var_0 = [];
  var_0["armory_terminal"] = ["sc_prisoner_grf_genevastillhasp_spkr"];
  var_0["armory_terminal_exit"] = ["sc_prisoner_plr_thanksgriffyour", 1, "sc_prisoner_grf_staysafedownthe_spkr"];
  return var_0;
}