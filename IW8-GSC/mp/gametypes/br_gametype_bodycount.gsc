/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_bodycount.gsc
**************************************************/

activate_punchcard() {}

activate_gas_trap() {}

activate_laser_trap_parent() {}

init() {
  test_anim_ai();
  level thread test_train_array();
  level thread terminal_pusher();
  level thread testaccessoryvfx();
  level thread teamstarttime();
  level thread toggleusbstickinhand();
  level thread subtract_from_spawn_count_from_group();
  level thread init_locations();
  level._id_13364 = 1;
  level.openrequested = [];
}

test_anim_ai() {
  level.copy_wave_settings_from_module = spawnStruct();
  level.copy_wave_settings_from_module.juggernaut_setupexecute = getdvarint("_encstr_A5D92537D89CF5987B32E51BBD5DCD8EAF23B299C257B147BE93AC9B38C2EE9BEB86564BEC1A8E");

  if(isDefined(level.copy_wave_settings_from_module.juggernaut_setupexecute) && level.copy_wave_settings_from_module.juggernaut_setupexecute > 0)
    level._id_12CA7 = level.copy_wave_settings_from_module.juggernaut_setupexecute;

  level.copy_wave_settings_from_module._id_127B6 = getdvarfloat("_encstr_A9A221B673DBFEDDC562E028CA1B8DD31708B12DC62B6105E72B58B851376DC9578EC5", 0.3);
  level.copy_wave_settings_from_module._id_127B5 = getdvarfloat("_encstr_91DD206E8D937D31DB8C2F1B7BAEB9E8FA1CB15DCD32952711277BE0A05BDBBADC8E", 0);
  level.copy_wave_settings_from_module._id_127BE = getdvarfloat("_encstr_81DE2113A7F0B1E3D8F9EBB2602D1BB34129B49D252847FBE2F1228BAF0D132E38ED24", 0.6);
  level.copy_wave_settings_from_module._id_12C9A = getdvarfloat("_encstr_8B9D2377A0F39FE217FD8806501B1A7CFEB0A78FD0490F6A1F8D94BD4DA77235A1807F7B48", 5);
  level.copy_wave_settings_from_module._id_12C99 = getdvarfloat("_encstr_92482AAB807D411B60B5F91BD8CBE353FFA07223803303735EA5E11DE5D6A71F2131ABDAF8F7FEA79306FC0D", 2);
  level.copy_wave_settings_from_module._id_1385A = getdvarint("_encstr_AF152BB812BA97618F5C83F63F8FA899A9BB38A09BD33338977F0EFD1B43B1574D01B048E22F45566F679560F4", 1);
  level.copy_wave_settings_from_module._id_13857 = getDvar("_encstr_939B28C23F6B9F2D9861086728C5406B971BE44B23E348A00AA7E19D21133F23F5290747EF934F1DF1B1", "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  level.copy_wave_settings_from_module._id_13858 = getDvar("_encstr_AB9B28700EB32EBA07F4C929D0536834B7B7EB80B3BC9BB5570F68A2681DD7AB4889A39709614AAD302F", "_encstr_B805127C9C59D94398C193AE10710632593B0577");
  level.copy_wave_settings_from_module._id_13856 = getDvar("_encstr_91FE26D6B64BD7290FCB9850FF4DE0C9E1DACD574A836350EF0F3838AF741833FB4949ED239A3B58", "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B");
  level.copy_wave_settings_from_module._id_11FD6 = getdvarint("_encstr_968D2DCD6CC9D7C4ED19BCD8F657E61DEBB7DCBE91F6761D16B3FAC1B46C5BBAE07D86AC2C1B1D1AAFC9CA9996B136", 1);
  level.copy_wave_settings_from_module._id_11FD5 = getdvarint("_encstr_A3572CBE6BC3E6D5CD5AE830C26395DB1F1F4820C40F2931B672E1B0DABE57337B87472E55E7331F5ABA2070A295", 1);
  level.copy_wave_settings_from_module._id_11FD4 = getdvarint("_encstr_ACB42B43213059FAC8B998620A5B1EFBE7D79668ED72A770A92A4E4BDFBBFA9D0286B0076DC7A02555C86499E8", 1);
  level.copy_wave_settings_from_module._id_11FD8 = getdvarint("_encstr_88152E5F88DBC7BA7F95F06E082332940680B36708D03723BB3C71A26337BA5D4B994F63E8496CD98340465A5DDB7315", 1);
  level.copy_wave_settings_from_module._id_11FD7 = getdvarfloat("_encstr_A66232833760217348899B22F09D8B23B187062741E077136701F11B18FEC7DB207F8F76EBD07F431B1BAAD1C1CD6B9658FB37E6", 6);

  if(scripts\cp_mp\utility\game_utility::turretdisabled())
    level.copy_wave_settings_from_module.old_load_hvt = getdvarint("_encstr_9A83297B570256FEE791A3300F93C823E787A3BF3893BE9D7B3D43F63BBB57DFFBE39ED275B15FD84B2DDB", 5);
  else
    level.copy_wave_settings_from_module.old_load_hvt = getdvarint("_encstr_9A83297B570256FEE791A3300F93C823E787A3BF3893BE9D7B3D43F63BBB57DFFBE39ED275B15FD84B2DDB", 6);

  level.copy_wave_settings_from_module.old_goalheight = getdvarfloat("_encstr_BD8527CDD8E4EB26B723BC1BED5DDCE8AFB21E33A51BEB23CAC62C5EFA89B2CC7BC9B2F5CD8316BB9B", 90.0);
  level.copy_wave_settings_from_module.oldlatespawnplayer = getdvarfloat("_encstr_AA6F22FF6F73CE8118AD91DE306DDAA32E608B9A5879213AADCB786FFA7B20B6D3B7E28F", 20.0);
  level.copy_wave_settings_from_module.old_accuracy = getdvarfloat("_encstr_BD6928A643EBCEEDF572F058BA0BBDE307EDAB94D17B36371CEAB0C832E227796389A09B3E0F1B6B8552", 15.0);
  level.copy_wave_settings_from_module.omnvar_bit = getdvarfloat("_encstr_ABC827376C9CFA26DEC8BC8DBD5D733A7DCAE1992DB1BEB4378E4EEDF5CD381B2C370DAF3256B116F2", 3.0);
  level.copy_wave_settings_from_module.oncrankedhit = getdvarint("_encstr_A7141B9F481B077ABF5530AEC86372D446902B43A0704F03FB7D3C232E", 250);
  level.copy_wave_settings_from_module.oilfire_burning_player_watch = getdvarint("_encstr_9B5F2116768B17E9CF0B58903F0DA089A11F0B144CC24FB1A9733828A335DEF16A850D", 12.5);
  level.copy_wave_settings_from_module._id_14199 = getdvarvector("_encstr_BE342590877AEEC50AEF535605831533EF7BB8C0D703C0F3D15441E79B6A77D907E330E00BD7DB", (0, 0, 0.5));
  level.copy_wave_settings_from_module._id_14198 = getdvarfloat("_encstr_A26128363AF357AAF7D9DBDEA0B30A209F56EB43CB7F4C17D860395B5B8D92C78105EBB7E5E759BBA9B2", 150.0);

  switch (getdvarint("_encstr_B6841B6E8D937D4CBDC8E51BF6EA738EF51BA5C9B1B1CABE37E0959519", 1)) {
    case 0:
      level.copy_wave_settings_from_module.groundentity = [0, 120, 90, 75, 60, 45, 30, 0];
      level.copy_wave_settings_from_module.ground_spawners = [1, 150, 120, 120, 105, 105, 150, 10];
      break;
    case 2:
      level.copy_wave_settings_from_module.groundentity = [0, 120, 90, 60, 45, 45, 30, 0];
      level.copy_wave_settings_from_module.ground_spawners = [1, 150, 120, 90, 90, 90, 150, 10];
      break;
    case 3:
      level.copy_wave_settings_from_module.groundentity = [0, 30, 10, 10, 10, 10, 30, 0];
      level.copy_wave_settings_from_module.ground_spawners = [1, 20, 10, 10, 10, 10, 150, 10];
      break;
    case 4:
      level.copy_wave_settings_from_module.groundentity = [0, 90, 75, 60, 45, 30, 0];
      level.copy_wave_settings_from_module.ground_spawners = [1, 120, 120, 105, 90, 150, 10];
      break;
    case 5:
      level.copy_wave_settings_from_module.groundentity = [0, 30, 10, 10, 10, 30, 0];
      level.copy_wave_settings_from_module.ground_spawners = [1, 20, 10, 10, 10, 150, 10];
      break;
    case 1:
    default:
      level.copy_wave_settings_from_module.groundentity = [0, 120, 90, 75, 60, 45, 45, 0];
      level.copy_wave_settings_from_module.ground_spawners = [1, 150, 135, 120, 105, 105, 150, 10];
      break;
  }

  if(getdvarint("_encstr_A62B298AE6BDA902884897F7F823F6E30F8B9786D4F3614D11D0D73B81FBB1ABC3881B7DBD4DDABCF840B3", 0))
    level.delaystreamtomovingplane = 1;

  if(getdvarint("_encstr_998728CDD8277D13ED19E5C6DBD5738ED72316E6D92B39727B47A533BC1AABDC3AF6AD96E92CA3A57BDC", 1)) {
    level.isbotpracticematch = getdvarfloat("_encstr_A10E2338923A17E10FDC0376BF0F2819294A10584A1785BC37D403FC910FF0E74D32E80832", 20);
    level.isbrgametypefuncdefined = [];
  }

  setDvar("_encstr_994C161B30CDF1AB53B87566CDD853076FE852B2805937CB", 1);
}

test_train_array() {
  _setdomflagiconinfo("_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", 0);
  _setdomflagiconinfo("_encstr_859A1183D94B3B2548D56447E7202A93F5133A", "_encstr_88BF06FD784A6393", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", 0);
  _setdomflagiconinfo("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", 0);
  _setdomflagiconinfo("_encstr_A9E313D3A8538227B8B8FCDF45C1FB0F9518BAFA30", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", 0);
  _setdomflagiconinfo("_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509", "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", 1);
  _setdomflagiconinfo("_encstr_B40710E36BBF4F179FCD9CC8C9B1F3836012", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", 1);
  _setdomflagiconinfo("_encstr_8202100F51F881C7C0F2255890A5865376FF", "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", 1);
  level._effect["_encstr_AA501593CAB89746E80FC7EB9787C27BC83987D02F08A6"] = loadfx("_encstr_8C4525D999E1E596DD0EFAB183BC0727DEC1E53B99F0FA9B5BB5EBCD2DD99B16C6EBD9C995959B");
  _encstr_BD8926CDD8E42D073A9B976B0ECBCEC2B6B21DCBC1596E79C427EB197BB5AF2EAB95B947B83B37B1::_id_13239();
  level thread _id_13BB1();
}

_id_13BB1() {
  level waittill("_encstr_970E16454B71B5C0F18D704979D1B07B9B4F3BD1BF8B8D70");
  level.disableinitplayergameobjects = 0;
}

terminal_pusher() {
  level.make_place_c4_interact = [];
  level.make_place_c4_interact[1] = make_silencer_pick_up_interact(1, ::make_usb_model_usable);
  level.make_place_c4_interact[2] = make_silencer_pick_up_interact(2, ::make_outline_ents);
  level.make_place_c4_interact[3] = make_silencer_pick_up_interact(3, ::make_javelin_model);
  level.make_place_c4_interact[4] = make_silencer_pick_up_interact(4, ::make_javelin_ammo_refill_interact);
  level.make_place_c4_interact[5] = make_silencer_pick_up_interact(5, ::make_intel_model_usable);
  level.make_place_c4_interact[6] = make_silencer_pick_up_interact(6, ::make_headicon_on_ai);
  level.make_place_c4_interact[7] = make_silencer_pick_up_interact(7, ::make_pilot_invincible);
  level.make_place_c4_interact[8] = make_silencer_pick_up_interact(8, ::make_solution_struct);
  level.make_place_c4_interact[9] = make_silencer_pick_up_interact(9, ::make_heli_blade_patch_clip);
}

teamstarttime() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_85DC0CB2A8BE0795B831C9C57B28", ::circletimer);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8A38163B98D17952EDA44F0596EFEA2D3FE0C30708A8DDFB", ::_id_126F1);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_9B301516FE3D63ED424F23FBBB303F938931ABCE2B26B3", ::init_relic_aggressive_melee);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_B1130F58C89145BD6813990CA473335A36", ::being_hacked);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_81EC15B516C11A959B1D9527645ACDC28D68D2E48D36B2", ::_id_12181);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_96F01524FD4B55733DBAD0A152521F686743BD2844D71B", ::_id_12181);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_938917C18D85CB56391DAE8D85D928AED17B5DA5735D16D28E", ::_id_125BD);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AB11161D39D23B76954E29AC6E832CEE377ACE95E436C2F2", ::_id_13DCB);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_86342022A8D774B7E8B66875B67377FB0758F95A01692FEFC387546DC7583FC04BF0", ::assignspectatortospectateplayer);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8F351F39D6AB5F8FECFFB840AB1923CBF27CA1B36DF23911CCAF0839EF5C98339A", ::_id_11B16);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_992B1791C362CB50F215A1F8C7CC91863A1B71278F5A98E82C", ::_id_12604);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A549125D02CF7BE7E581E8980BFF55355FB9DDC3", ::droponplayerdeath);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8A4319E0710B51CAC6649BE8B2B33B4DD36D17ABDC83956D875BD0", ::playerdropplunderondeath);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  level thread _id_14148();
  scripts\engine\scriptable::scriptable_addusedcallback(::copycirclearraystartingat);
  scripts\engine\scriptable::_id_12F57(::copycirclearraystartingat);
}

_id_126F1(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 1;
  self waittill("_encstr_8F9C0E528823754F286C8799F07117BD");
  scripts\mp\hud_message::showsplash("_encstr_88AF1EF02BBF311B0297FD03AAFA1FD9E7EBA040F74DE8F9093B7D814672B3E1");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A5F909EC0B5B2B8EF20ECA", self, 0);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8EA412AB830729900AE9375F1AF448E69BAAE3B1", self, 0);

  if(istrue(self.tutorial_usingparachute))
    level _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_872514BBE31FE24FD0FED25A53F88C29F90B37335B46", self, 1, 0, 4.5);
}

iscarriablescriptable() {
  self waittill("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_1 in level.players) {
    if(isDefined(var_1))
      onplayerdisconnect(var_1);
  }

  foreach(var_4 in level._id_13748) {
    if(isDefined(level._id_13457)) {
      [[level._id_13457._id_13738]](var_4.total, var_4.bridge_three_death_func, var_4.node_targetname);
      [[level._id_13457._id_1373B]](var_4._id_12D24);
    }
  }

  if(istrue(level._id_145C1) && isDefined(level._id_13457))
    [[level._id_13457._id_145C1]]();
}

onplayerdisconnect(var_0) {
  var_1 = var_0 getentitynumber();

  if(isDefined(level._id_126C2[var_1])) {
    var_2 = level._id_126C2[var_1];
    var_2.total = var_0 propgiveteamscore();
    var_2.bridge_three_death_func = var_0 prespawnspawn();
    var_2.node_targetname = var_0 propminigameupdates();
    var_2._id_12D24 = var_0 propgetlocation();

    if(!isDefined(var_0.spectatetestonprematchfadedone))
      var_2._id_122EF = 1;
    else
      var_2._id_122EF = var_0.spectatetestonprematchfadedone;

    if(!isDefined(var_0.spawntimestamp))
      var_2.openrightblimadoor = 0;
    else
      var_2.openrightblimadoor = var_0.spawntimestamp;
  } else {
    var_2 = spawnStruct();
    var_2.total = var_0 propgiveteamscore();
    var_2.bridge_three_death_func = var_0 prespawnspawn();
    var_2.node_targetname = var_0 propminigameupdates();
    var_2._id_12D24 = var_0 propgetlocation();

    if(!isDefined(var_0.spectatetestonprematchfadedone))
      var_2._id_122EF = 1;
    else
      var_2._id_122EF = var_0.spectatetestonprematchfadedone;

    if(!isDefined(var_0.spawntimestamp))
      var_2.openrightblimadoor = 0;
    else
      var_2.openrightblimadoor = var_0.spawntimestamp;
  }

  if(isDefined(level._id_13748[var_0.team])) {
    var_3 = level._id_13748[var_0.team];
    var_3.total = var_3.total + var_2.total;
    var_3.bridge_three_death_func = var_3.bridge_three_death_func + var_2.bridge_three_death_func;
    var_3.node_targetname = var_3.node_targetname + var_2.node_targetname;

    if(var_2._id_12D24 > var_3._id_12D24)
      var_3._id_12D24 = var_2._id_12D24;
  } else {
    var_3 = spawnStruct();
    var_3.total = var_2.total;
    var_3.bridge_three_death_func = var_2.bridge_three_death_func;
    var_3.node_targetname = var_2.node_targetname;
    var_3._id_12D24 = var_2._id_12D24;
  }

  level._id_126C2[var_1] = var_2;
  level._id_13748[var_0.team] = var_3;

  if(isDefined(level._id_13457)) {
    [[level._id_13457._id_12540]](var_0, var_2.total, var_2.bridge_three_death_func, var_2.node_targetname);
    [[level._id_13457._id_12650]](var_0, var_2._id_12D24);
    [[level._id_13457._id_125D1]](var_0, var_2._id_122EF);
    [[level._id_13457._id_12556]](var_0, var_2.openrightblimadoor);
  }
}

copycirclearraystartingat(var_0, var_1, var_2, var_3, var_4) {
  switch (var_0.type) {
    case "_encstr_848D140A8D91F6CF4552B27A3BA87B61E00F8784C328":
      var_0.entity makedroneguardscrambler(var_3);
      break;
    case "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F":
      var_0 makecrateusableforplayer(var_3);
      break;
    case "_encstr_91BA1631E41BBDB747D7B9BD58BEE0DEEEAF8CBDD9A3C2B3":
      var_0 makecrateusableforplayer(var_3);
      break;
    case "_encstr_A2FF1CCAA3D94F2D58BF6A7FD1E8F687FD98238129AB7B22D8576C71FD60":
      var_3 start_mine_caves();
      break;
  }
}

testaccessoryvfx() {
  if(getdvarint("_encstr_AB53196ED893D713E4C4F6465E8DDBEACDE87DC163C22F47B237D1", 0))
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE");

  level.decoyassists = ::groundz;
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_84EC163339208BC548FB4A5DC74BCAEF59D1B8CA6085477A");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A5D50F0ED8C2DC9535E616E051F6F4D312");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A9C319ABE6958ADBB6CAE651DB94ACECD2D995A29585D6B5B03AAC");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_97C92259EBD4B00CB16F0D0577CBDE286303C073172C0837DA0F2309AF239D711D9D8929");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_97CE0D72D84DC423792EE1F2C6E0F7");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_8C100FC793A0BFF07F07F30773956AE520");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A1B50F226F23E2F0A1FB78932245C75325");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_A92C15EAC13B1A65AF90871768635B829B7636673B4B83");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_913C1133FB03C75D8B11220B40EBDAD3D9DEAC");
}

toggleusbstickinhand() {
  level thread _encstr_8E6A24A7203BB7AB6BC8378D3AC8BFD649956B70FFFF0ADD6096DB295F7BD0CBD918C827A8F6::init();
  waittillframeend;
  level thread _id_127F7();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
}

_id_127F7() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");

  if(!istrue(level.tryupdategenericprogress)) {
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8CDB0F17758F62C1503912545010040A7D", ::onplayerkilled);
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_97D311FBD1FDFCADD2C9E888A7D50FD3890F07", ::dangercircletick);
    level thread _encstr_8ACF2EEE8E7383433C8F4258EB0FF9CB2AB7E573A2FA7F601293B96887991333515BD5F73AF23D56FCBB30A042B7CBBF::init();
  }

  success_zone_width();
  level._id_126C2 = [];
  level._id_13748 = [];

  foreach(var_1 in level.players) {
    var_1 _id_13F79();
    var_2 = var_1 getentitynumber();
    level._id_126C2[var_2] = spawnStruct();
    level._id_126C2[var_2].total = var_1 propgiveteamscore();
    level._id_126C2[var_2].bridge_three_death_func = var_1 prespawnspawn();
    level._id_126C2[var_2].node_targetname = var_1 propminigameupdates();
    level._id_126C2[var_2]._id_12D24 = var_1 propgetlocation();
    level._id_126C2[var_2]._id_122EF = 0;
    level._id_126C2[var_2].openrightblimadoor = 0;

    if(!isDefined(level._id_13748[var_1.team])) {
      level._id_13748[var_1.team] = spawnStruct();
      level._id_13748[var_1.team].total = 0;
      level._id_13748[var_1.team].bridge_three_death_func = 0;
      level._id_13748[var_1.team].node_targetname = 0;
      level._id_13748[var_1.team]._id_12D24 = 0;
    }

    var_1 _id_12604();
  }

  level thread iscarriablescriptable();
}

subtract_from_spawn_count_from_group() {
  wait 1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_B6C613CE2CDAB2D1F2072BF5E0EDDD959C3B39C298";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8EA412AB830729900AE9375F1AF448E69BAAE3B1"] = "_encstr_B89714387BEEACE4CE9CB013F56BED23B27DC856B936";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B4990E4ECA370EC2EECDEB364E583AAC"] = "_encstr_B21714B2EC5637D1EBE4ACB9E00BBB37AFB14E583A2B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA290F923A2D10B1C695C06DA81A2853B2"] = "_encstr_B89313C1EDDDCA9C76E41631F556DC56DA2FBE4D81";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB8D12124A74EF55A9930E0DABB0515FA5819B8B"] = "_encstr_B4421869E567E335CF0A5B71EFBA60388D2F8017F2E3E55D05BA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9ABE1089384E6019C1AF9D83E7CBC8C8E915"] = "_encstr_85DD1883683C1F12A87DC1CA0F905D4769C2093BB39ECF0FF067";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BD300C9587334B63F5E495C29197"] = "_encstr_B85618BF5DF34B331FBB607027354AF5BA05A046F3CA1539C26F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A523129732A172B131614DF4578A95A543272B63"] = "_encstr_ACDD1607BDDDAC273B935826F566274B569B8C635EEBD460";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D0115591E994BB1D733C95ACAE623D85EF5CD470BE4A3"] = "_encstr_919A1B09873BC8E647F3E189492B9ED0D7EEB9B929E930A7C3AB7BF3F2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A73213B8806577588F73CA39EB4E235520114BEB38"] = "_encstr_9B3E1BC1BDDDB293EC932C267DCC9CB42BE6238DCBFADC57C68D5637DC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8A3B0C4380167252EF374EC310D7"] = "_encstr_8D5214839F0707935F8579B64F32CD28031A6BDD71DB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_92EE0E097FB2FDC0B70193493399903D"] = "_encstr_A6C8111CEDDDCAC9B3C98531FAEADC36BD366D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_913F1133F8C0FB1F8798C1DA98C5D9D3D954AB"] = "_encstr_87591338DEDDAC27EC4E8589F5977BAEE4F5D1C2B3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D861089DB8FC7E017163810235367EB7553"] = "_encstr_B65E1783DEBBB239ECE4584CD79EED73CA7D6C7BE61DCA9B1D";
}

achievementtrackerforkills() {}

dangercircletick(var_0, var_1) {
  var_2 = var_1 * var_1;

  foreach(var_4 in level.dogtags) {
    if(distance2dsquared(var_4.origin, var_0) > var_2)
      var_4 thread removetags();
  }

  foreach(var_7 in level.openrequested) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(distance2dsquared(var_7.origin, var_0) > var_2)
      var_7 thread opened_position();
  }

  foreach(var_7 in level.shutdownattractionicontrigger) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(distance2dsquared(var_7.origin, var_0) > var_2)
      var_7 _encstr_8ACF2EEE8E7383433C8F4258EB0FF9CB2AB7E573A2FA7F601293B96887991333515BD5F73AF23D56FCBB30A042B7CBBF::shut_down_laser_trap();
  }
}

_id_11B16() {
  return 0;
}

_id_125BD(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_0)) {
    if(level.copy_wave_settings_from_module._id_12C9A) {
      self.chopper_boss_combat_actions = 1;
      var_2 = level.copy_wave_settings_from_module._id_12C9A;
      wait 3;

      while(istrue(self.killcam))
        waitframe();

      thread _id_1336E(var_2);
      thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::spawnspectator(self, 0, 1);
      wait(var_2);
      self.chopper_boss_combat_actions = undefined;
      return 1;
    }
  }

  return 0;
}

_id_13DCB(var_0) {
  return 1;
}

assignspectatortospectateplayer(var_0, var_1) {
  var_0 notify("_encstr_B43F2B467380716238AFC36F37DDCAA4B8FBB34DEFF0057A0DE3DB677989B2F14003FB56C068EE726691876F1B");

  if(istrue(level.endmatchcameratransitions))
    return 0;

  if(!isDefined(var_1) || !isPlayer(var_1) || !isalive(var_1) && !isDefined(var_1._id_1391A))
    return 0;

  if(var_0.team == var_1.team)
    return 0;

  if(!scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_8A2A0B936CCCC3078547970A8B"))
    return 0;

  var_2 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 1);

  if(var_2.size == 0)
    return 0;

  thread cargo_truck_mg_mp_init(var_0);
  return 1;
}

cargo_truck_mg_mp_init(var_0) {
  level endon("_encstr_918D15899CA638B0DDB982D8B0CBB2273715DC8C4BB93B");
  var_0 endon("_encstr_B43F2B467380716238AFC36F37DDCAA4B8FBB34DEFF0057A0DE3DB677989B2F14003FB56C068EE726691876F1B");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_126AB();
  var_0 setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", var_0 getentitynumber());
  wait 1.0;
  var_1 = _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::regive_killstreak_after_use(var_0);
  thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::assignspectatortospectateplayer(var_0, var_1);
}

onplayerspawned() {
  thread _id_14012();
}

onplayerkilled(var_0) {
  if(self.spawnsystem_init <= 0)
    self.attacker thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BED221F65A310F91D52708685BF56EBD9A47F38EF54BD57BBF53F8E80704A6E782EDE1");

  thread juggerbear();
  var_1 = var_0.inflictor;
  var_2 = var_0.attacker;

  if(isDefined(var_2) && (!isDefined(var_1) || var_1.classname != "_encstr_A70911F16A4C28BC9F231658BB53ED80A2DC6B" && var_1.classname != "_encstr_85FE0DD5727A27098513298817CA23")) {
    var_3 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
    level thread spawndogtags(self, var_2, var_3);
  }
}

_id_14148() {
  while(!isDefined(level.vehicles) || !isDefined(level.vehicles.damagecallbacks))
    wait 0.1;

  scripts\mp\vehicles\damage::set_post_mod_damage_callback("_encstr_8C190467402B", ::_id_14202);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", ::_id_14202);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback("_encstr_85DE05A6B2AC0E", ::_id_14202);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback("_encstr_9A120A1D8536F5E4ED3BB293", ::_id_14202);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", ::_id_14202);
}

_id_14202(var_0) {
  if(isDefined(var_0.direction_vec) && isDefined(var_0.meansofdeath) && isexplosivedamagemod(var_0.meansofdeath)) {
    var_1 = level.copy_wave_settings_from_module._id_14199;
    var_2 = level.copy_wave_settings_from_module._id_14198;
    self _meth_87C1(var_0.direction_vec + var_1, var_2);
  }

  return 1;
}

_id_12604() {
  if(!isDefined(self._id_12EB0)) {
    var_0 = getcompleteweaponname(level.copy_wave_settings_from_module._id_13857);
    var_1 = scripts\mp\class::fixcollision(level.copy_wave_settings_from_module._id_13858, "_encstr_96C8098FDBB937AFFB32F2", undefined, -1);
    var_2 = getcompleteweaponname(level.copy_wave_settings_from_module._id_13856);
    var_3 = scripts\mp\equipment::getequipmentreffromweapon(var_2);
    self giveweapon(var_0);
    self giveweapon(var_1);
    self switchtoweaponimmediate(var_1);
    self assignweaponprimaryslot(var_1);
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_give_type(self, "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9", var_1.clipsize * 2);
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_update_weapons(self);
    self notify("_encstr_B2110C63C02DC5E92388229F9D75");
    scripts\mp\equipment::giveequipment(var_3, "_encstr_BA7F0830B3A7859B60B0");
    scripts\mp\weapons::fixupplayerweapons(self, var_1);
  } else
    _id_125FB();

  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::scriptablescurid(150);
}

activate_escape_maze() {}

spawndogtags(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isagent(var_0)) {
    return;
  }
  if(isagent(var_1))
    var_1 = var_1.owner;

  var_3 = 14;
  var_4 = (0, 0, 0);
  var_5 = var_0.angles;

  if(var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var_5 = self getworldupreferenceangles();
    var_4 = anglestoup(var_5);

    if(var_4[2] < 0)
      var_3 = -14;
  }

  var_6 = var_0.origin + (0, 0, var_3);
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6);
  var_7 setModel("_encstr_8A231E6B4BC62DA3B039CBD732F6D9472C9DE6D78993EB13B719971BBDEAB9D1");
  var_7 setotherent(var_0);
  var_7 hudoutlineenable("_encstr_AAA514372003FC02452D71B705218BB00E48A3B78099");
  var_7.team = var_0.team;
  getclocksoundaliasfortimeleft();
  var_8 = "_encstr_B40101" + var_7 getentitynumber();
  var_7.start_reach_wind_room = var_8;
  level.dogtags[var_8] = var_7;
  var_7 setasgametypeobjective();
  var_7.victim = var_0;
  var_7.victimteam = var_0.team;
  var_7.attacker = var_1;
  var_7.attackerteam = var_1.team;
  var_7.ownerteam = var_0.team;
  var_7.spawntime = gettime();
  var_7 thread _id_13B4C(var_0, var_2);
  var_7.offset3d = (0, 0, 16);
  var_7.curorigin = var_7.origin;
  var_7 scripts\mp\gameobjects::requestid(1, 1);
  var_7.type = "_encstr_8CC00AABB9599E984D2BD81D";
  var_7.numtouching["_encstr_8E8405EA382B2A"] = 0;
  var_7.numtouching["_encstr_9A8507BA4040188D08"] = 0;

  if(isDefined(level.dogtags[var_8].objidnum)) {
    if(level.dogtags[var_8].objidnum != -1) {
      var_9 = level.dogtags[var_8].objidnum;
      scripts\mp\objidpoolmanager::update_objective_state(var_9, "_encstr_AF5A081BBAC993AC73A3");
      scripts\mp\objidpoolmanager::update_objective_onentity(var_9, level.dogtags[var_8]);
      scripts\mp\objidpoolmanager::update_objective_setzoffset(var_9, 22);
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_9, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(level.dogtags[var_8].objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(level.dogtags[var_8].objidnum, 0);
      level.dogtags[var_8] scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8D701AD8D9A3D7CD4C1A2C4F6BC02F0B49DF82890FABA35586805851", "_encstr_8ECD1123407BEFC751BD31889F2789592B50D7");
      level.dogtags[var_8] scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
      getbnetigrbattlepassxpmultiplier(var_9, 8858, 9843);
      getscriptcachecontents(var_9, 0.5, 1.0);
    }
  }

  playsoundatpos(var_6, "_encstr_A28719B5E0F55B5A36D86CDBDC995A39DAEB3A0BEC37BE91C9DB0E");
}

getclocksoundaliasfortimeleft() {
  if(level.dogtags.size > 60) {
    var_0 = undefined;

    foreach(var_2 in level.dogtags) {
      if(!isDefined(var_0) || var_2.spawntime < var_0.spawntime)
        var_0 = var_2;
    }

    var_0 thread removetags();
  }
}

_id_13B4C(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, self.origin, self.angles, var_0, undefined, undefined, undefined, 1);
  var_3 = var_2.origin;
  var_4 = abs(self.origin[2] - var_3[2]);
  var_5 = getdvarint("_encstr_979A08F619C1EA8361C7", 800);
  var_6 = sqrt(2 * var_4 / var_5) + 0.5;
  var_7 = trajectorycalculateinitialvelocity(self.origin, var_3, (0, 0, -1 * var_5), var_6);
  self movegravity(var_7, var_6);
  wait(var_6);
  self.origin = var_3;

  if(isDefined(var_2.set_force_aitype_armored)) {
    self linkTo(var_2.set_force_aitype_armored);
    self.set_force_aitype_armored = var_2.set_force_aitype_armored;
  }
}

makedroneguardscrambler(var_0) {
  if(isDefined(var_0.owner))
    var_0 = var_0.owner;

  if(getdvarint("_encstr_B8B00BCDB1BEE60DBCD0C1F0E1", 0) == 6)
    var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_835A301B18AF4A9931528577421FA10F81909A99996323E9EDBFAFEF5BF9AF9B610C05DDAF771E161327DA65E7FD5B29E3D0", 1);

  if(var_0.pers["_encstr_8AEF05472BC2D6"] == self.victimteam) {
    self playSound("_encstr_8B87194A804F1F52CD40A960587D7C4E09270DFF7A4F28C1584B7B");
    var_0 scripts\mp\rank::giverankxp("_encstr_82780B3A2C76BE46CAE6A5B219", 25);
    var_0 scripts\mp\utility\stats::incpersstat("_encstr_B64E070F391562989D", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B64E070F391562989D", var_0.pers["_encstr_B64E070F391562989D"]);
    var_0 thread make_emp_config();
    _encstr_8E6A24A7203BB7AB6BC8378D3AC8BFD649956B70FFFF0ADD6096DB295F7BD0CBD918C827A8F6::allyonuse(var_0);

    if(var_0 == self.victim)
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_913F1133F8C0FB1F8798C1DA98C5D9D3D954AB", var_0);

    if(isDefined(level.dogtagallyonusecb) && !level.gameended)
      self thread[[level.dogtagallyonusecb]](var_0);

    var_0 start_link_logic_on_players();
  } else {
    self playSound("_encstr_B6521B4D9B5942F899A0A3B5E68C228ABFA11D7BC773196398A7DBE579");
    var_0 scripts\mp\utility\stats::incpersstat("_encstr_820E0A2AE8981DBA528588DC", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_820E0A2AE8981DBA528588DC", var_0.pers["_encstr_820E0A2AE8981DBA528588DC"]);
    _encstr_8E6A24A7203BB7AB6BC8378D3AC8BFD649956B70FFFF0ADD6096DB295F7BD0CBD918C827A8F6::enemyonuse(var_0);

    if(isDefined(level.dogtagenemyonusecb) && !level.gameended)
      self thread[[level.dogtagenemyonusecb]](var_0);

    var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_12003();
    var_0 make_hb_pick_up_interact();
    var_0 start_marquee();
  }

  self.victim notify("_encstr_96640CDC1749DF0253F87AE350B9");
  thread removetags();
}

makecrateusableforplayer(var_0) {
  if(isDefined(var_0.owner))
    var_0 = var_0.owner;

  if(getdvarint("_encstr_B8B00BCDB1BEE60DBCD0C1F0E1", 0) == 6)
    var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_835A301B18AF4A9931528577421FA10F81909A99996323E9EDBFAFEF5BF9AF9B610C05DDAF771E161327DA65E7FD5B29E3D0", 1);

  var_1 = self.origin;
  playsoundatpos(var_1, "_encstr_B6521B4D9B5942F899A0A3B5E68C228ABFA11D7BC773196398A7DBE579");
  var_0 scripts\mp\utility\stats::incpersstat("_encstr_820E0A2AE8981DBA528588DC", 1);
  var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_820E0A2AE8981DBA528588DC", var_0.pers["_encstr_820E0A2AE8981DBA528588DC"]);
  var_0 _encstr_8E6A24A7203BB7AB6BC8378D3AC8BFD649956B70FFFF0ADD6096DB295F7BD0CBD918C827A8F6::ontagpickupevent("_encstr_96590EE82CB3D71BDE36B1ACD88E598C");
  var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_12003();
  var_0 make_hb_pick_up_interact();
}

removetags() {
  playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], self.origin);
  self notify("_encstr_88F20627959BCAE8");
  waitframe();

  if(isDefined(self)) {
    self notify("_encstr_AD75063D571AE108");

    if(isDefined(level.dogtags[self.start_reach_wind_room])) {
      if(!isDefined(level.dogtags[self.start_reach_wind_room].skipminimapids)) {
        level.dogtags[self.start_reach_wind_room] scripts\mp\gameobjects::releaseid();
        self notify("_encstr_8BE208E31FA8E1631D65");
      }

      level.dogtags[self.start_reach_wind_room] = undefined;
    }

    self delete();
  }
}

make_silencer_pick_up_interact(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.spotlight_sweep_to_loc_safe = var_0;
  var_2.playerwaittillstreamhintcomplete = var_1;
  return var_2;
}

make_hb_pick_up_interact() {
  thread make_emp_config();
  start_loc();
  var_0 = propgiveteamscore();

  for(var_1 = 1; var_1 <= level.make_place_c4_interact.size; var_1++) {
    if(var_0 == level.make_place_c4_interact[var_1].spotlight_sweep_to_loc_safe) {
      self[[level.make_place_c4_interact[var_1].playerwaittillstreamhintcomplete]]();
      self.spawnropeandbag = var_1;
      _id_13F79();
    }
  }
}

make_emp_config() {
  if(!isDefined(self.vehicle)) {
    if(level.copy_wave_settings_from_module._id_11FD8 == 1)
      thread _id_124EE();
  }

  scripts\mp\rank::giverankxp("_encstr_96590EE82CB3D71BDE36B1ACD88E598C", 25);

  if(level.copy_wave_settings_from_module._id_11FD4 == 1)
    thread make_focus_fire_icon_anchor();

  if(level.copy_wave_settings_from_module._id_11FD6 == 1)
    self.health = self.maxhealth;

  if(level.copy_wave_settings_from_module._id_11FD5 == 1) {
    self.br_armorhealth = self.br_maxarmorhealth;
    self setclientomnvar("_encstr_BD71131B60E0DBCAA1A31A1DA710590B1718D2A249", 1);
    scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
  }

  thread _id_124EF();
}

make_focus_fire_icon_anchor() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  thread scripts\mp\equipment::givescavengerammo();
  scripts\mp\weapons::scavengergiveammo(self);
  waitframe();
  scripts\mp\weapons::scavengergiveammo(self);
}

make_usb_model_usable(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"_encstr_BAD61D95F9A7F6A9DF914727E5353918BB206EDFB17BBDB1A6B2410FCD2ED1";
    return;
  }

  make_laser_shutdown_interact("_encstr_851904B59B34");
}

make_outline_ents(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"_encstr_A2012F7141B1ED846321DE20C5A32FEF2D981949099AABDF4F325520E4D73573857059E1016177552718C8B09FFB5FDF7A";
    return;
  }

  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(self, "_encstr_B8AD206D636A18C8CC6928014F88E0C0426FE3F99B425060F5BF3038357C2306AABB", 1);
  thread scripts\mp\hud_message::showsplash("_encstr_B26624266E36E59823399F8F97836B5DA620315FDFC05017E0C10197696782504EC95F9288E3");
}

make_javelin_ammo_refill_interact(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"_encstr_8FA62835FB4196C18490A53C8BA65168E80F99913779CD39D93A4D36265C81EE2197057FAF410E013BC7";
    return;
  }

  make_laser_shutdown_interact("_encstr_A2E60C6BC099B7E1A0A93A398F48");
}

make_headicon_on_ai(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"_encstr_A25E2B2111E1BDD45311EEF03553FFDF1DC86919394A7BEF1F6265F03983674B7530096191572BA78F559FCEDB";
    return;
  }

  thread scripts\mp\hud_message::showsplash("_encstr_86E02026397D31DE8CCBEBC67BABCDE8FA93B2BB162746CA467DCE16E6EBD6C26ED6");
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(self, "_encstr_84E81D13DB7CE0D743294557BB4A312EDF2F9BE0FF1B38FF6A4BC657567253", 1);
}

make_intel_model_usable(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"_encstr_88DE27F52E7633B7C1093E090BD0A9CFF41D3E2CD886C39FA1DF6C899122A3A1D9E1DF1019DD748FB4";
    return;
  }

  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(self, "_encstr_B6C113D67689A237D399ABC3700BF56949B79B0ED3", 1);
}

make_pilot_invincible(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"_encstr_96592D844AAF907A88AC0DE955C915E5C92AB02ABE4A545D5025447D2825A8D0A46A52E993D705294AA9A829A42D15";
    return;
  }

  make_laser_shutdown_interact("_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895");
}

make_javelin_model(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"_encstr_8A5324F52A9FD16088B75F7FBF10D57256773ECF813A5124B0F3595717991DC1315924E47F55";
    return;
  }

  thread scripts\mp\hud_message::showsplash("_encstr_84E92213DB4F41D742A0585E3D8B0D4BE763B030FF1AD98B6AC14DDBD3935B960CE71028");
  start_mine_caves();
}

make_solution_struct(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"_encstr_8C0C244E97219A20ED7BCF871B80D9BFF1DD7043AEA165795745DBCF3F57300B6125FD9CC729";
    return;
  }

  thread scripts\mp\hud_message::showsplash("_encstr_A6B7223B205EDA4A097B190E68031274E688BFE7401314D251AF1AC245D7BA29E8C86F13");
  scripts\mp\perks\perks::bears();
}

make_heli_blade_patch_clip(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"_encstr_813626453D71A2A021B9D73153D619E20C5DF83929BF814797CA6817C9B8F5060DD5C5B4CFE389A7";
    return;
  }

  make_laser_shutdown_interact("_encstr_8FFA10EB3033E5B2613B4D05176949BDF950");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_92EE0E097FB2FDC0B70193493399903D", self, undefined, undefined, 1);
}

make_laser_shutdown_interact(var_0) {
  var_1 = isDefined(self.streakdata.streaks[1]);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::playerpackdataintogulagomnvar(var_0, var_1, 1);

  if(!level.gameended)
    thread scripts\mp\hud_message::showkillstreaksplash(var_0);
}

propgiveteamscore() {
  if(!isDefined(self.spawnscavengerlootcache))
    self.spawnscavengerlootcache = 0;

  return self.spawnscavengerlootcache;
}

prespawnspawn() {
  if(!isDefined(self.spawnpoint_is_within_sight))
    self.spawnpoint_is_within_sight = 0;

  return self.spawnpoint_is_within_sight;
}

propminigameupdates() {
  if(!isDefined(self.spawnselectionafktime))
    self.spawnselectionafktime = 0;

  return self.spawnselectionafktime;
}

start_loc() {
  self.spawnscavengerlootcache = propgiveteamscore();
  self.spawnscavengerlootcache++;
  _id_13F79();
}

start_link_logic_on_players() {
  self.spawnpoint_is_within_sight = prespawnspawn();
  self.spawnpoint_is_within_sight++;
  _id_13F79();
}

start_marquee() {
  self.spawnselectionafktime = propminigameupdates();
  self.spawnselectionafktime++;
  _id_13F79();
}

_id_13F79() {
  var_0 = propgiveteamscore();
  var_1 = propgetlocation();
  var_2 = propremovefromcircle();
  var_3 = 0;
  var_3 = var_3 + var_0 * 100;
  var_3 = var_3 + var_1 * 10;
  var_3 = var_3 + var_2;
  self setclientomnvar("_encstr_A1DA1C1B2BF1B69DC8C1C8D7AF3EF7689B41A12291E7F73BA5F7B81B93F9", var_3);
}

propgetlocation() {
  if(!isDefined(self.spawnropeandbag))
    self.spawnropeandbag = 0;

  return self.spawnropeandbag;
}

activate_battle_station() {}

init_locations() {
  if(level.mapname == "_encstr_8CD508CA98A70FAFC01D" || level.mapname == "_encstr_A3F50BC8631F6D20CD64F7A155") {
    _id_12AD7("_encstr_A60108C05863AB184BF8", 1, (-17654, 20472, 0));
    _id_12AD7("_encstr_91B606B0E49C0B5E", 1, (27262, 19562, 0));
    _id_12AD7("_encstr_883009BD28232B4B688B98", 1, (30451, -8704, 0));
    _id_12AD7("_encstr_BD0208BE67B903152D08", 1, (-5201, 7260, 0));
    _id_12AD7("_encstr_B19B09E057A26011D22585", 1, (46307, -11229, 0));
    _id_12AD7("_encstr_A6590AE09CED6BBE2B2CE6D1", 1, (10312, -23257, 0));
    _id_12AD7("_encstr_BEE10AF3BB404F29B8C3636C", 1, (-19091, -33444, 0));
    _id_12AD7("_encstr_B6A2056BD2E659", 1, (34541, 41465, 0));
    _id_12AD7("_encstr_A77808BB284B9F27D3C1", 1, (29411, 2720, 0));
    _id_12AD7("_encstr_A19407CB0D1807F441", 1, (-28903, 49517, 0));
    _id_12AD7("_encstr_877D06BB570F2B5E", 1, (18376, -14868, 0));
  } else if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    _id_12AD7("_encstr_AF6B0E826B30078F1348325A4971C61B", 1, (-1585, 10202, 0));
    _id_12AD7("_encstr_BEAC1599B8375F1823A7BBE7F7303F3996C0F578717037", 1, (589, 8411, 0));
    _id_12AD7("_encstr_8DE1070D169C137BC9", 1, (3285, 953, 0));
    _id_12AD7("_encstr_8E5C0AB9E82C4BC91B0B9BCA", 1, (2364, -2407, 0));
    _id_12AD7("_encstr_8E07030349", 1, (102, -2075, 0));
    _id_12AD7("_encstr_B6010D87222A5F58DED7B0F82FEB10", 1, (-1301, 2339, 0));
    _id_12AD7("_encstr_83B90FEAA005CB1B20F19FDB1D684BD765", 1, (-2187, -3390, 0));
    _id_12AD7("_encstr_A67B0E2BB1AEF7BA60D9411F8BC007EF", 1, (-1259, -10892, 0));
    _id_12AD7("_encstr_8748062B40B57BAF", 1, (-474, -5781, 0));
  } else
    _id_12AD7("_encstr_8B1608EC43B8D647A113", 1, (0, 0, 0));
}

_id_12AD7(var_0, var_1, var_2) {
  if(!isDefined(level.copy_wave_settings_from_module.area_structs))
    level.copy_wave_settings_from_module.area_structs = [];

  var_1 = getdvarint("_encstr_B2161FB9C627AF89EDC82FB1DEAB733AAF36EDD8B0A3A5BD9BBEEE565AD9343A7D" + var_0, var_1);

  if(var_1 <= 0) {
    return;
  }
  var_3 = spawnStruct();
  var_3._id_13902 = var_0;
  var_3.spotlights = var_1;
  var_3._id_140B7 = var_2;
  level.copy_wave_settings_from_module.area_structs[var_0] = var_3;
}

groundz() {
  _id_12FDC();
  level thread bindingpc();

  if(istrue(level.copy_wave_settings_from_module._id_1409D))
    level.grouptorewards = (0, 0, 0);

  level.br_level.br_circledelaytimes = level.copy_wave_settings_from_module.groundentity;
  level.br_level.br_circleclosetimes = level.copy_wave_settings_from_module.ground_spawners;

  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    level.br_level.br_circleradii = [16000, 16000, 12500, 9500, 6500, 2000, 300, 0];
    level.br_level.br_circleminimapradii = [9000, 9000, 7750, 6500, 4500, 3500, 2500];
    level.br_level.default_player_connect_black_screen = [0, 0, 0, 0, 0, 0, 0];
    level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0, 0];
  } else {
    level.br_level.br_circleradii = [72500, 72500, 50000, 32500, 17500, 7500, 2000, 300, 0];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500, 9000, 8000, 6500, 5500, 5500];
    level.br_level.default_player_connect_black_screen = [0, 0, 0, 0, 0, 0, 0, 0];
    level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0, 0, 0];
  }
}

_id_12FDC() {
  level.copy_wave_settings_from_module._id_12E2C = _id_12D7F();
  level.grouptorewards = level.copy_wave_settings_from_module._id_12E2C._id_140B7;
  level.chopper_boss = level.copy_wave_settings_from_module._id_12E2C._id_13902 == "_encstr_883009BD28232B4B688B98";
}

_id_12D7F() {
  if(isDefined(level.copy_wave_settings_from_module._id_13903) && level.copy_wave_settings_from_module._id_13903 != "_encstr_A31207CBF788523281") {
    foreach(var_2, var_1 in level.copy_wave_settings_from_module.area_structs) {
      if(level.copy_wave_settings_from_module._id_13903 == var_2)
        return var_1;
    }
  }

  if(level.copy_wave_settings_from_module.area_structs.size == 1)
    return level.copy_wave_settings_from_module.area_structs[0];

  var_3 = 0;

  foreach(var_1 in level.copy_wave_settings_from_module.area_structs)
  var_3 = var_3 + var_1.spotlights;

  var_6 = randomintrange(0, var_3);

  foreach(var_1 in level.copy_wave_settings_from_module.area_structs) {
    if(var_6 < var_1.spotlights)
      return var_1;

    var_6 = var_6 - var_1.spotlights;
  }

  level.copy_wave_settings_from_module.area_structs = scripts\engine\utility::array_randomize(level.copy_wave_settings_from_module.area_structs);
  return level.copy_wave_settings_from_module.area_structs[0];
}

bindingpc() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_855514074BB1B2DF6058F2BED078170A9DFDC3971566");

  if(scripts\cp_mp\utility\game_utility::turretdisabled())
    level.br_level.default_class_chosen[1] = (0, 0, 0);

  level.br_level.default_class_chosen[0] = level.br_level.default_class_chosen[1];
  level.br_level.default_class_chosen[level.copy_wave_settings_from_module.old_load_hvt + 1] = level.br_level.default_class_chosen[level.copy_wave_settings_from_module.old_load_hvt + 2];
  level.br_level.default_class_chosen[level.copy_wave_settings_from_module.old_load_hvt] = level.br_level.default_class_chosen[level.copy_wave_settings_from_module.old_load_hvt + 2];
  level.copy_wave_settings_from_module._id_140B6 = level.br_level.default_class_chosen[level.copy_wave_settings_from_module.old_load_hvt];
}

_id_12181() {
  var_0 = getdvarvector("_encstr_8E141949237FCCB06D91315FBB9450061BCA66900BCF7EA0446C3B", level.grouptorewards);
  return var_0;
}

init_relic_aggressive_melee() {
  var_0 = (level.br_level.default_class_chosen[1][0], level.br_level.default_class_chosen[1][1], 0);
  var_1 = level.br_level.br_circleradii[1];
  var_2 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::createtestc130path(var_0, var_1);
  return var_2;
}

being_hacked() {
  thread vehomn_getleveldata();
}

vehomn_getleveldata() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = distance(self._id_12205.startpt, self._id_12205.neurotoxin_damage_monitor);
  var_1 = var_0 / _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::getc130speed() - 5;
  wait(var_1);

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_3.br_infil_type) && var_3.br_infil_type == "_encstr_969105B1C4CC81" && !isDefined(var_3.jumptype)) {
      var_3.jumptype = "_encstr_8A720C58B3AB7729A26778B853CB";
      var_3 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
    }
  }
}

circletimer(var_0) {
  if(var_0 >= 2)
    level.copy_wave_settings_from_module._id_12C9A = level.copy_wave_settings_from_module._id_12C9A + level.copy_wave_settings_from_module._id_12C99;

  if(var_0 < level.copy_wave_settings_from_module.old_load_hvt) {
    openelevatordoors(var_0);
    return 0;
  }

  if(var_0 == level.copy_wave_settings_from_module.old_load_hvt) {
    if((level.mapname == "_encstr_8CD508CA98A70FAFC01D" || level.mapname == "_encstr_A3F50BC8631F6D20CD64F7A155") && !level.chopper_boss)
      level._id_12CA7 = 7500;

    level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::generate_solution();
    level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::little_bird_mg_mp_enterendinternal();
    level thread ondamagerelicsteelballs(level.copy_wave_settings_from_module.old_goalheight);

    foreach(var_2 in level.players) {
      if(isalive(var_2) || istrue(var_2.chopper_boss_combat_actions)) {
        if(getdvarint("_encstr_B8B00BCDB1BEE60DBCD0C1F0E1", 0) == 6)
          var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_91963201D131F8EBA7A240289A37916112E5B3A738E918A3BBFA5856922F56482D7D4715D70A89F6E6F17B5EDABB8578C3EF6FA5", 1);
      }
    }

    return 0;
  }

  if(var_0 == level.copy_wave_settings_from_module.old_load_hvt + 1) {
    level.br_circle.dangercircleui.origin = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin() + (0, 0, _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius());
    _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::setstaticuicircles(500, level.br_circle.safecircleui, level.br_circle.dangercircleui, 0);
  }

  return 1;
}

success_zone_width() {
  if(scripts\cp_mp\utility\game_utility::turretdisabled())
    level.copy_wave_settings_from_module.arena_bot_think_seek_dropped_weapons = [(-865, -11255, 242), (-1896, -8692, 210), (-2890, -5367, 756), (383, -5884, 756), (2330, -7363, 758), (2660, -3249, 895), (-2062, -2682, 1041), (797, -2415, 1418), (-3666, -903, 746), (-566, 75, 1818), (2908, 70, 892), (5192, -3942, 198), (-6002, -109, 142), (-2431, 1723, 1060), (826, 2159, 1258), (-4423, 3943, 675), (-969, 4627, 1130), (3597, 3145, 252), (2066, 5665, 537), (-634, 7038, 1119), (-3103, 8079, 530), (1726, 9290, 722), (-322, 9748, 818), (-1428, 9176, 762), (-3014, 9975, 638)];

  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_BAE911E54813B56117F37033BF7F79EDEAF36D");
  var_0.capturestring = &"_encstr_AF491E6A82CB8E51E4154A4A0DAF137A3DA8F568940A5151EBD0A0058AAA94A8";
  var_0.dummymodel = "_encstr_8E4023D6D21B4B1DB0E4F2AFC6854E9507858D5B5876ACD70C98AF899CAF272B37E0C2EEDC";
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.minimapicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 0;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.activatecallback = ::ownerxuid;
  var_0.capturecallback = ::p4_trigger;
  var_0.destroyoncapture = 1;
}

openelevatordoors(var_0) {
  if(var_0 == 2)
    level thread _id_1354E();
}

_id_1354E() {
  wait(randomintrange(10, 20));

  foreach(var_1 in level.players)
  var_1 scripts\mp\hud_message::showsplash("_encstr_AF13223003F1EDC0A34190F63F8FA899A9ABB030BB960F3877430EFF1C1776734BA26090");

  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_B4990E4ECA370EC2EECDEB364E583AAC");
  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_4 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  var_5 = randomfloat(120);
  var_6 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);

  for(var_7 = 0; var_7 < 3; var_7++) {
    var_8 = var_3 + anglesToForward((0, var_5 + var_6 * var_7 * 120, 0)) * (var_4 * 0.65);
    var_9 = proprange(var_8, var_4 * 0.35, 0.25, 0.75, 1);

    while(!_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_9)) {
      var_9 = proprange(var_3, var_4, 0.1, 0.9, 1);
      waitframe();
    }

    var_9 = var_9 + (0, 0, 2000);
    var_10 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "_encstr_BAE911E54813B56117F37033BF7F79EDEAF36D", var_9, (0, randomint(360), 0));
    level.openrequested[level.openrequested.size] = var_10;
    var_10 thread opennukecrate();
    var_10 thread openpos();
    wait(randomintrange(3, 10));
  }
}

proprange(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\cp_mp\utility\game_utility::turretdisabled())
    return previous_spawn_points();
  else
    return _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_0, var_1, var_2, var_3, var_4);
}

previous_spawn_points() {
  level.copy_wave_settings_from_module.arena_bot_think_seek_dropped_weapons = scripts\engine\utility::array_randomize(level.copy_wave_settings_from_module.arena_bot_think_seek_dropped_weapons);

  foreach(var_1 in level.copy_wave_settings_from_module.arena_bot_think_seek_dropped_weapons) {
    if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::ispointincurrentsafecircle(var_1))
      return var_1;
  }
}

ownerxuid(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80")]](self);
  }
}

p4_trigger(var_0) {
  level.openrequested = scripts\engine\utility::array_remove(level.openrequested, self);
  self notify("_encstr_B1CF098D5838A3D5C95623");
  var_1 = easepower("_encstr_A2FF1CCAA3D94F2D58BF6A7FD1E8F687FD98238129AB7B22D8576C71FD60", self.origin + (0, 0, 16));
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_1);

  if(isDefined(self.objectiveiconid))
    objective_delete(self.objectiveiconid);

  playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], self.molotov_delete_oldest_trigger.origin);
  self.molotov_delete_oldest_trigger delete();
}

opennukecrate() {
  var_0 = scripts\engine\utility::drop_to_ground(self.origin, 50, -3000, (0, 0, 1));
  self.molotov_delete_oldest_trigger = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 + (0, 0, 3));
  self.molotov_delete_oldest_trigger setModel("_encstr_AAD412E6C69CEBB9B6DBD659D7CE9C9537583256");
  wait 1.0;
  self.molotov_delete_oldest_trigger playLoopSound("_encstr_A12F1108A33F918142D2F590AE7BC5D8574B68");
  self.molotov_delete_oldest_trigger setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_AB0703DBB9");
}

openpos() {
  self setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_A20A088EDD77B3031B2A");
}

opened_position() {
  self.molotov_delete_oldest_trigger delete();
  playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], self.origin);
  level.openrequested = scripts\engine\utility::array_remove(level.openrequested, self);
  scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}

activate_gas_trap_puddles() {}

ondamagerelicsteelballs(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.copy_wave_settings_from_module.managevehiclehealthui = spawnStruct();
  var_2 = level.copy_wave_settings_from_module._id_140B6;

  if(isDefined(var_1))
    var_2 = var_1;

  var_3 = level.copy_wave_settings_from_module.oncrankedhit;
  var_4 = getgroundposition(var_2, 1);

  if(isDefined(var_0)) {
    var_5 = var_0 - level.copy_wave_settings_from_module.oldlatespawnplayer;

    if(var_5 > 0)
      wait(var_5);
    else
      wait 30;
  }

  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_A97F1DD8E5F94B57B25BA93FC79BB88B710DE0914CF12181C8167092DF6277");
  level thread ondroprelics(var_4);
  var_6 = frag_crate_player_at_max_ammo(700);

  if(var_6 < level.copy_wave_settings_from_module.old_accuracy)
    var_6 = level.copy_wave_settings_from_module.old_accuracy;

  var_5 = level.copy_wave_settings_from_module.oldlatespawnplayer - var_6;
  wait(var_5);
  var_7 = play_quarry_intro_vo();
  var_8 = undefined;

  if(isDefined(var_7)) {
    var_8 = var_7 thread _id_126A8(var_2, undefined, 5000, 700, 0, 0);
    var_8 thread outro_main();
  }

  var_5 = level.copy_wave_settings_from_module.old_accuracy - level.copy_wave_settings_from_module.omnvar_bit;
  wait(var_5);
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_B4481B3ABDA1C6DF5542814A683523BB490BA8862360C19708D8FA6231");

  foreach(var_10 in level.players)
  var_10 scripts\mp\utility\lower_message::setlowermessageomnvar(72, undefined, 10);

  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_BD300C9587334B63F5E495C29197");
  wait(level.copy_wave_settings_from_module.omnvar_bit);
  level.copy_wave_settings_from_module.managevehiclehealthui.trigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_4, 0, int(var_3), int(level.defend_wave_3));
  var_12 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(level.copy_wave_settings_from_module.managevehiclehealthui.trigger, "_encstr_A7A408B9CA5D1D4E2C63");
  var_12.onuse = ::oncapture;
  var_12.onbeginuse = ::omvar_code;
  var_12.onuseupdate = ::oncollectitem;
  var_12.onenduse = ::on_killed_tutorial;
  var_12.oncontested = ::on_execution_begin;
  var_12.onuncontested = ::onarmorboxusedbyplayer;
  var_12.onunoccupied = ::onattackerdamagenottracked;
  var_12.onpinnedstate = ::on_max;
  var_12.onunpinnedstate = ::oncacheopen;
  var_12._id_138B2 = ::on_min;
  var_12.stompprogressreward = ::onfieldupgradeend;
  var_12.gate_swings_open = 1;
  var_12.id = "_encstr_87D9083A6F628DDB5F1F";
  var_12.pinobj = 0;
  var_12.lockupdatingicons = 1;
  var_12 scripts\mp\gameobjects::setcapturebehavior("_encstr_92FC0B5BB01A6B73D09459526B");
  var_13 = level.copy_wave_settings_from_module.oilfire_burning_player_watch;
  var_12 scripts\mp\gameobjects::setusetime(var_13);
  var_12 onfieldupgradeendbuffer();
  playencryptedcinematicforall(var_12.objidnum, 1);
  level.copy_wave_settings_from_module.managevehiclehealthui.oil_puddles = var_12;
  level.objectivescaler = 1;

  foreach(var_10 in level.players) {
    var_10 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 17);
    var_10 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  }
}

ondamagepredamagemodrelicfocusfire(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isDefined(var_2.team)) {
      if(var_2.team == var_0) {
        var_2 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 18);
        continue;
      }

      var_2 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 19);
    }
  }
}

ondamagerelicfocusfire(var_0) {
  if(var_0 == "_encstr_B85C0AD87B9B8E95CD8E2B46")
    self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 20);
  else if(var_0 == "_encstr_ACFC091AE8AB2FCBE15119")
    self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 18);
  else
    self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 19);
}

onfirstlandcallback(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2))
      var_2 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_0);
  }
}

omnvardata(var_0) {
  self notify("_encstr_B1EC17B3C38FA8E01F3AD357108BB83FCD35185F3F32E74798");
  self endon("_encstr_B1EC17B3C38FA8E01F3AD357108BB83FCD35185F3F32E74798");

  if(isPlayer(var_0))
    var_1 = var_0.team;
  else
    var_1 = var_0;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_1)) {
      if(var_3.team == var_1) {
        var_3 thread ondamagerelicfocusfire("_encstr_ACFC091AE8AB2FCBE15119");
        var_3 thread scripts\mp\hud_message::showsplash("_encstr_92FA221002491EFF855BF1E268E09878276CD348FD1DD4A042AF99F8670F502710A4D91D");
        continue;
      }

      var_3 thread ondamagerelicfocusfire("_encstr_88BF06FD784A6393");
      var_3 thread scripts\mp\hud_message::showsplash("_encstr_93C71F4B502EAA3A196B093E5813E264F62B83DF3042DFD3630F8D39B5D15A31F8");
    }
  }

  _id_1242C(var_1, "_encstr_8D0115591E994BB1D733C95ACAE623D85EF5CD470BE4A3", "_encstr_AB8D12124A74EF55A9930E0DABB0515FA5819B8B");
}

oncapture(var_0) {
  var_1 = var_0.team;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var_1].size == 0 && isDefined(self.oldtouchlist))
    self.touchlist = self.oldtouchlist;

  _id_1242C(var_1, "_encstr_A73213B8806577588F73CA39EB4E235520114BEB38", "_encstr_9ABE1089384E6019C1AF9D83E7CBC8C8E915");
  onfirstlandcallback(1);
  thread oldest_targeted_by_chopper_time(var_1);
}

omvar_code(var_0) {
  if(!isDefined(self._id_11F63) || !self._id_11F63) {
    self._id_11F63 = 1;
    thread omnvardata(var_0);
    var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

    foreach(var_3 in var_1)
    var_3 notify("_encstr_91D9276C8563B1B75D8EAD0B936D95E4835AB9D9EBBB8527E9F673CAA55A1B36A2AE56E6D1A436DBCD");
  }
}

oncollectitem(var_0, var_1, var_2, var_3) {
  if(var_1 < 1.0 && !level.gameended && !istrue(self.get_current_bush_zone)) {
    onfirstlandcallback(var_1);
    _id_12427(var_1, var_0);
  }

  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify))
    self.didstatusnotify = 1;

  if(self.gate_swings_open && var_1 > 0.5) {
    self.gate_swings_open = 0;
    _id_1242C(var_0, "_encstr_A523129732A172B131614DF4578A95A543272B63", "_encstr_AA290F923A2D10B1C695C06DA81A2853B2");
  }
}

on_killed_tutorial(var_0, var_1, var_2) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend(var_0, var_1, var_2);
}

on_execution_begin() {
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8D861089DB8FC7E017163810235367EB7553");
  var_0 = scripts\mp\gameobjects::getownerteam();

  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isDefined(var_0))
      var_2 thread ondamagerelicfocusfire("_encstr_B85C0AD87B9B8E95CD8E2B46");
  }
}

onarmorboxusedbyplayer(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = scripts\mp\gameobjects::getownerteam();
  var_3 = undefined;
  var_4 = oldbranchents();

  if(var_4 <= 1) {
    foreach(var_6 in level.teamnamelist) {
      var_7 = self.teamprogress[var_6];

      if(var_7 > 0) {
        var_3 = var_6;
        break;
      }
    }

    if(isDefined(var_3)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_3);

      if(var_1)
        ondamagepredamagemodrelicfocusfire(var_3);
    } else if(var_2 != "_encstr_A7A408B9CA5D1D4E2C63")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_2);
    else if(var_0 != "_encstr_8BBA05185F8B99")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);

    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");

    if(isDefined(var_0) && (var_0 == "_encstr_8BBA05185F8B99" || var_2 == "_encstr_A7A408B9CA5D1D4E2C63"))
      self.didstatusnotify = 0;
  }
}

onattackerdamagenottracked() {
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63")
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1");
  else
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");

  self.didstatusnotify = 0;
}

on_max(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_A9E313D3A8538227B8B8FCDF45C1FB0F9518BAFA30", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");
}

oncacheopen(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && !self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");
}

on_min(var_0) {
  var_1 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    var_5 = self.teamprogress[var_4];

    if(var_5 > 0)
      var_2 = var_5 / self.usetime;
  }

  if(isDefined(var_2)) {
    onfirstlandcallback(var_2);

    if(var_2 <= 0.008)
      thread omnvardata(self.claimteam);

    if(!self.gate_swings_open && var_2 < 0.4)
      self.gate_swings_open = 1;
  }
}

onfieldupgradeend(var_0) {
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8E84100AE82D2133A3508787FD6923F77DB0");
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_A9E313D3A8538227B8B8FCDF45C1FB0F9518BAFA30", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");

  if(isDefined(self.lastprogressteam)) {
    thread omnvardata(var_0);
    self.lastprogressteam = undefined;
  }
}

_id_12427(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_2 = "_encstr_B40101";
    var_0 = int(floor(var_0 * 10));
    var_2 = "_encstr_856B180A5867CF6F6068A3D9972B4F12537312A1E0E3C6A71EC7" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
  }
}

oldest_targeted_by_chopper_time(var_0) {
  waitframe();

  if(istrue(level._id_13DC0)) {
    return;
  }
  level._id_13DC0 = 1;
  level._id_145C1 = 1;
  level thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
  var_1 = [];

  if(isDefined(var_0) && var_0 != "_encstr_8D19048EA595")
    var_1 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

  thread scripts\mp\music_and_dialog::_id_12789(var_1);
}

ondroprelics(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 - (0, 0, 3));
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  wait 1.0;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_AA501593CAB89746E80FC7EB9787C27BC83987D02F08A6"), var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

oldbranchents() {
  var_0 = 0;

  foreach(var_3, var_2 in self.numtouching) {
    if(var_2 > 0 && (!isstring(var_3) || var_3 != "_encstr_8BBA05185F8B99"))
      var_0++;
  }

  return var_0;
}

onfieldupgradeendbuffer() {
  scripts\mp\objidpoolmanager::update_objective_setneutrallabel(self.objidnum, "_encstr_84E1136807E05B8579D32B3FD3F19B2605BEA0406C");
}

active_fob_think() {}

_id_124EE() {
  if(!isDefined(self.operatorcustomization) || !isDefined(self.operatorcustomization.suit)) {
    return;
  }
  if(self.operatorcustomization.suit == "_encstr_B6C10E16FEB9C2379020FFBB7B6EFD9B") {
    thread _id_1247E();
    return;
  }

  self._id_12147 = self.operatorcustomization.suit;
  self.operatorcustomization.suit = "_encstr_B6C10E16FEB9C2379020FFBB7B6EFD9B";
  scripts\mp\utility\player::_setsuit("_encstr_B6C10E16FEB9C2379020FFBB7B6EFD9B");
  thread _id_1247E();
}

_id_1247E() {
  self notify("_encstr_880812DE335B81880D27C8E0E74CC6C7535ECEDD");
  self endon("_encstr_880812DE335B81880D27C8E0E74CC6C7535ECEDD");
  scripts\engine\utility::_id_143B9(level.copy_wave_settings_from_module._id_11FD7, "_encstr_AD75063D571AE108");
  self.operatorcustomization.suit = self._id_12147;
  scripts\mp\utility\player::_setsuit(self._id_12147);
  self._id_12147 = undefined;
}

_id_124EF() {
  self notify("_encstr_873521DB506F07BF784F8B65E1E944930468B272FB35E7726839957A9FA04ABB3B608B");
  self endon("_encstr_873521DB506F07BF784F8B65E1E944930468B272FB35E7726839957A9FA04ABB3B608B");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self refreshsprinttime();
  var_0 = 0;
  thread make_focus_fire_objective();
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("_encstr_8B880E3B782B3B528F416928DF5B3D4D");

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
    scripts\mp\utility\perk::giveperk("_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862");
    scripts\mp\utility\perk::giveperk("_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27");
    scripts\mp\utility\perk::giveperk("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
  }

  while(var_0 < level.copy_wave_settings_from_module._id_11FD7) {
    if(self issupersprinting())
      self refreshsprinttime();

    wait 0.1;
    var_0 = var_0 + 0.1;
  }

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
    if(isDefined(self.perks["_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862"]))
      scripts\mp\utility\perk::removeperk("_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862");

    if(isDefined(self.perks["_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27"]))
      scripts\mp\utility\perk::removeperk("_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27");

    if(isDefined(self.perks["_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218"]))
      scripts\mp\utility\perk::removeperk("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
  }

  self.movespeedscaler = 1;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");
}

make_focus_fire_objective() {
  self notify("_encstr_A17D0C78BA323B7B8774B3B97DEB");
  waitframe();
  self setclientomnvar("_encstr_8C1F1B1BF3F74B2278E8E7BB58D1FEC27D9569D36B2B526AC6E0BFB3A0", 4);
  var_0 = level.copy_wave_settings_from_module._id_11FD7;
  var_1 = gettime() + var_0 * 1000;
  self setclientomnvar("_encstr_96FC169BD7814FE8E91BA11BC7CDB30D2A0B5711AFCA9DD0", var_1);
  scripts\engine\utility::_id_143BA(level.copy_wave_settings_from_module._id_11FD7, "_encstr_A17D0C78BA323B7B8774B3B97DEB", "_encstr_AD75063D571AE108");
  self setclientomnvar("_encstr_8C1F1B1BF3F74B2278E8E7BB58D1FEC27D9569D36B2B526AC6E0BFB3A0", 0);
}

_id_14012() {
  if(propremovefromcircle()) {
    if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasrespawntoken())
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::addrespawntoken(1);
  } else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasrespawntoken())
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::removerespawntoken();
}

_id_1336E(var_0) {
  waittillframeend;
  scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_0 * 1000));
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_131A2(1);
  thread spawn_drones(var_0);
}

spawn_drones(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0))
    wait(var_0);

  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_131A2(0);
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

propremovefromcircle() {
  if(!isDefined(self.spawnsystem_init))
    self.spawnsystem_init = level.copy_wave_settings_from_module._id_1385A;

  return self.spawnsystem_init;
}

start_mine_caves() {
  self.spawnsystem_init = propremovefromcircle();
  self.spawnsystem_init++;

  if(!isDefined(self.spectatetestonprematchfadedone))
    self.spectatetestonprematchfadedone = self.spawnsystem_init;
  else if(self.spawnsystem_init > self.spectatetestonprematchfadedone)
    self.spectatetestonprematchfadedone = self.spawnsystem_init;

  _id_14012();
  _id_13F79();
}

juggerbear() {
  self.spawnsystem_init = propremovefromcircle();
  self.spawnsystem_init--;

  if(!isDefined(self.spawntimestamp))
    self.spawntimestamp = 1;
  else
    self.spawntimestamp++;

  if(self.spawnsystem_init < 0)
    self.spawnsystem_init = 0;
}

radar_sweeps(var_0, var_1) {
  var_2 = (randomfloat(1) - 0.5, randomfloat(1) - 0.5, 0);

  if(!istrue(var_1))
    var_2[2] = randomfloat(1) - 0.5;

  var_3 = var_0 * vectorNormalize(var_2);
  return var_3;
}

_setdomflagiconinfo(var_0, var_1, var_2, var_3) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 1;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = "_encstr_A22F2FEA4BEBD683EB1393EB6BB038ADCA73EAAF96D8DEB9EBCEAEC658ECBEDBEC9527E8A56B2BAFDE31A9956C3A4BCECA";
  level.waypointpulses[var_0] = var_3;
}

_id_125FC() {
  var_0 = spawnStruct();
  var_0._id_12889 = [];
  var_0.brtdm_config = [];
  var_0.brtruck_cleanupents = [];
  var_0.brtruck_ontimelimit = [];
  var_0.offhands = [];
  var_0.nvidiaansel_overridecollisionradius = [];
  var_0.should_use_velo_forward = self.should_use_velo_forward;
  var_0.callprecisionairstrikeonlocation = scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A");
  var_1 = [];
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var_4) && !issubstr(var_4.basename, "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") && !scripts\mp\utility\weapon::unset_relic_mythic(var_4.basename))
      var_1[var_1.size] = var_4;
  }

  foreach(var_7 in var_1) {
    var_8 = createheadicon(var_7);

    if(var_7.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB" || var_7.basename == "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0") {
      var_0.brtdm_config[var_8] = self getweaponammoclip(var_7);
      var_0.brtruck_ontimelimit[var_8] = self getweaponammostock(var_7);
    } else {
      var_0.brtdm_config[var_8] = weaponclipsize(var_7);
      var_0.brtruck_ontimelimit[var_8] = int(max(self getweaponammostock(var_7), weaponclipsize(var_7)));
    }

    if(scripts\mp\utility\weapon::turnexfiltoside(var_7))
      var_0.brtruck_cleanupents[var_8] = weaponclipsize(var_7);

    if(getsubstr(var_8, 0, 4) == "_encstr_9B83050BD88EF5") {
      continue;
    }
    var_0._id_12889[var_0._id_12889.size] = var_7;
  }

  var_10 = self getweaponslistoffhands();

  foreach(var_12 in var_10) {
    if(var_12.basename == "_encstr_A51B0B2BD260444AAFCD6F86E2") {
      continue;
    }
    var_13 = self getweaponammoclip(var_12);

    if(var_13 <= 0) {
      continue;
    }
    var_0.offhands[var_0.offhands.size] = var_12;
    var_14 = createheadicon(var_12);
    var_0.brtdm_config[var_14] = var_13;
  }

  foreach(var_18, var_17 in self.equipment)
  var_0.nvidiaansel_overridecollisionradius[var_17] = var_18;

  var_0.super = undefined;

  if(isDefined(self.super) && !self.super.usepercent)
    var_0.super = self.equipment["_encstr_BEB406F03B72BB3B"];

  if(isDefined(self.streakdata.streaks[1]))
    var_0.vo_one_remain = self.streakdata.streaks[1].streakname;

  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    var_0.gasmaskhealth = self.gasmaskhealth;
    var_0.plunderpads = self.plunderpads;
    var_0.plundersilentcountdownendtime = self.plundersilentcountdownendtime;
  }

  self._id_12EB0 = var_0;
}

_id_125FB() {
  _unlinkcorpsefromvehicle::_id_125FB();
  thread _id_13FAB();
  thread _id_12CC3();
}

_id_13FAB() {
  self endon("_encstr_AD75063D571AE108");
  wait 1;
  _id_13F79();
  self.spawnsystem_init = propremovefromcircle();

  if(self.spawnsystem_init == 0)
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8A3B0C4380167252EF374EC310D7", self);
}

_id_12CC3() {
  var_0 = propgiveteamscore();

  if(var_0 >= 8)
    scripts\mp\perks\perks::bears();
}

droponplayerdeath(var_0) {
  _id_125FC();
  var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::minplunderextractions(var_1);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::missiontime(var_1);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::mintokensdropondeath(var_1);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::missedinfilplayerhandler(var_1);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::hangar_doors_opening_quadrace();
  return 1;
}

playerdropplunderondeath(var_0, var_1) {
  if(scripts\mp\utility\game::updatehistoryhud(self))
    return 1;

  if(istrue(level.gameended))
    return 1;

  if(isDefined(self.plundercount) && self.plundercount > 0)
    var_2 = self.plundercount;
  else
    var_2 = 0;

  if(istrue(self.unicornpoints)) {
    var_3 = 0;
    var_4 = level.endgametutorial_func._id_127B5;
  } else {
    var_3 = int(var_2 * level.copy_wave_settings_from_module._id_127BE + 0.5);
    var_4 = int(level.copy_wave_settings_from_module._id_127B5 + var_2 * level.copy_wave_settings_from_module._id_127B6 + 0.5);
  }

  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(var_3);

  if(var_4 <= 0) {
    return;
  }
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::ml_p3_func(var_4, var_0);
  return 1;
}

_id_1242C(var_0, var_1, var_2) {
  foreach(var_4 in level.teamnamelist) {
    if(var_4 == var_0) {
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback(var_1, var_4);
      continue;
    }

    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback(var_2, var_4);
  }
}

_id_126A8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0;
  var_7 = var_6 + (0, 0, 2500);
  var_8 = play_skit_and_watch_for_endons(var_7, var_1);
  var_9 = (0, var_8, 0);
  var_10 = undefined;
  var_11 = undefined;

  if(isDefined(var_2)) {
    var_10 = var_7 + -1 * anglesToForward(var_9) * var_2;
    var_11 = var_7 + anglesToForward(var_9) * var_2;
  } else {
    var_10 = var_7 + -1 * anglesToForward(var_9) * 5000;
    var_11 = var_7 + anglesToForward(var_9) * 5000;
  }

  var_12 = spawnheli(self, var_10, var_7, var_11, var_3, var_4, var_5);
  return var_12;
}

play_quarry_intro_vo() {
  var_0 = getarraykeys(level.teamdata);

  foreach(var_2 in var_0) {
    if(level.teamdata[var_2]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"].size > 0)
      return level.teamdata[var_2]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"][0];
  }

  return undefined;
}

play_skit_and_watch_for_endons(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.player_respawn))
    return var_1.player_respawn;

  var_2 = 10;
  var_3 = scripts\engine\trace::create_world_contents();

  for(var_4 = 0; var_4 < 360; var_4 = var_4 + var_2) {
    var_5 = (0, var_4, 0);
    var_6 = var_0 + -1 * anglesToForward(var_5) * 5000;
    var_7 = var_0 + anglesToForward(var_5) * 5000;
    var_8 = scripts\engine\trace::sphere_trace(var_0, var_7, 100, undefined, var_3, 1);

    if(var_8["_encstr_A53009A25003666B9818C6"] == 1) {
      if(isDefined(var_1))
        var_1.player_respawn = var_4;

      return var_4;
    }

    if(var_4 % 3 == 0)
      waitframe();
  }

  var_4 = randomfloat(360);

  if(isDefined(var_1))
    var_1.player_respawn = var_4;

  return var_4;
}

outro_main() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  var_0 = _id_13C30(self.pathgoal, self.hoverheight);
  var_1 = self.pathgoal[2] - var_0;
  self.player_weapon_fired_monitor = frag_crate_player_at_max_ammo(var_1);
  sortplayerplunderscores(1, self.player_weapon_fired_monitor);
  self waittill("_encstr_8B7205D9ED5958");
  thread heliwatchgameendleave();
  thread snapshot_crate_spawn();
  helidescend(self.endpoint, var_0);
  soldier_agent_lwfn0();
  helicleanupextract();
  thread sol_3_4_pool();
}

spawnheli(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = vectortoangles(var_2 - var_1);
  var_8 = 99;
  var_9 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_1, var_7, "_encstr_A215169359C387A680CB7370EBD12AF3F5902A2AC33007DA", "_encstr_B2681F23E5D0519E0729F97F8B2D1BC8E008509FEFB8B208F0D4A3F34965024858");

  if(!isDefined(var_9)) {
    return;
  }
  var_10 = var_2 * (1, 1, 0);
  var_9.speed = 50;
  var_9.accel = 125;
  var_9.health = 1000;
  var_9.maxhealth = var_9.health;
  var_9.team = var_0.team;
  var_9.owner = var_0;
  var_9.defendloc = var_2;
  var_9.lifeid = 0;
  var_9.flaresreservecount = var_8;
  var_9.pathgoal = var_2;
  var_9._id_121FF = var_3;
  var_9.endpoint = var_10;
  var_9.select_mountain_two_spawners = var_7[1];
  var_9.canuse = var_6;
  var_9.hoverheight = var_4;
  var_9.vehiclename = "_encstr_9BEF16359B67FDA671371305E0BDB293E166C898324FA18B";

  if(istrue(var_5))
    var_9 setCanDamage(1);
  else
    var_9 setCanDamage(0);

  var_9 setmaxpitchroll(10, 25);
  var_9 vehicle_setspeed(var_9.speed, var_9.accel);
  var_9 sethoverparams(50, 100, 50);
  var_9 setturningability(0.05);
  var_9 setyawspeed(45, 25, 25, 0.5);
  var_9 setotherent(var_0);
  var_9 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  return var_9;
}

frag_crate_player_at_max_ammo(var_0) {
  var_1 = frag_crate_spawn(5000, 100, 125);
  var_2 = frag_crate_spawn(var_0, 25.0, 31.25);
  var_3 = var_1 + var_2;
  return var_3;
}

_id_13C30(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1))
    var_2 = var_1;
  else
    var_2 = 256;

  var_3 = tracegroundpoint(var_0, 100, [self]);
  var_4 = var_3[2];
  var_5 = var_4 + var_2;
  return var_5;
}

sortplayerplunderscores(var_0, var_1) {
  var_2 = gettime() + int(var_1 * 1000);
  var_3 = level.teamdata[self.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"];

  foreach(var_5 in var_3) {
    var_5 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_8B061CAEA5EBC493EBC163ABE6462B93AF56E1D1932C8D8E7DCD8E2CD1AC", var_0);
    var_5 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_AB2C1FAB5C571836E1DBF9C38B7AF5C03F37720302D1D8ED1997C5F93723CBF0DD", var_2);
  }
}

heliwatchgameendleave() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread sol_3_4_pool();
}

snapshot_crate_spawn() {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(self.vfxent)) {
    return;
  }
  self.vfxent endon("_encstr_AD75063D571AE108");
  wait 5;
  self.vfxent setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_8FA70A7917830EF0B09E4379");
  self.vfxent playSound("_encstr_88741E3B933094C7F831728A58C65BCF300FB4B13390D18B9B2B6BE283171387");
  wait 1;
  self.vfxent stoploopsound();
  wait 4.5;
  self.vfxent delete();
}

helidescend(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = var_0[0];
  var_3 = var_0[1];
  var_4 = (var_2, var_3, var_1);
  self setvehgoalpos(var_4, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self vehicle_setspeed(25.0, 31.25);
  thread snapplayertotoppos();
  thread snappointtooutofboundstriggertrace();
  self waittill("_encstr_8B7205D9ED5958");
  self sethoverparams(1, 1);
  wait 1;
  self sethoverparams(25, 20, 10);
}

soldier_agent_lwfn0() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  thread smoke_init();
  sortplayerplunderscores(2, 300);
  wait 300;
  self.isdepot = 0;
  heliusecleanup();
}

heliusecleanup() {
  if(isDefined(self.usable)) {
    level.br_depots = scripts\engine\utility::array_remove(level.br_depots, self.usable);
    self.usable = undefined;
  }
}

smoke_init(var_0) {
  scripts\engine\utility::waittill_either("_encstr_BA2D081B2B58B32D37EC", "_encstr_AD75063D571AE108");
  heliusecleanup();
}

helicleanupextract(var_0) {
  if(isDefined(self.vfxent)) {
    self.vfxent stoploopsound();
    self.vfxent delete();
  }

  if(istrue(var_0) && isDefined(self.site))
    self.site setscriptablepartstate(self.site.type, self.site.audio_shf_kill_hangar_lights);
}

sol_3_4_pool() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_BA2D081B2B58B32D37EC");
  self.leaving = 1;
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  sortplayerplunderscores(3, self.player_weapon_fired_monitor);
  self waittill("_encstr_8B7205D9ED5958");
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(self._id_121FF, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self waittill("_encstr_8B7205D9ED5958");
  self stoploopsound();
  sortplayerplunderscores(0, 0);
  self notify("_encstr_A9B60A3495C6A5F5D9DEB92B");
  smuggler_killed_early();
}

tracegroundpoint(var_0, var_1, var_2) {
  var_3 = -99999;
  var_4 = (var_0[0], var_0[1], var_3);
  var_5 = scripts\engine\trace::create_world_contents();
  var_6 = undefined;

  if(isDefined(var_1))
    var_6 = scripts\engine\trace::sphere_trace(var_0, var_4, var_1, var_2, var_5);
  else
    var_6 = scripts\engine\trace::ray_trace(var_0, var_4, var_2, var_5);

  return var_6["_encstr_BD260953AA97E3F014279D"];
}

frag_crate_spawn(var_0, var_1, var_2) {
  var_3 = var_0 * 0.0000157828;
  var_4 = 0.5 * var_2;
  var_5 = var_1;
  var_6 = -1 * var_3;
  var_7 = (-1 * var_5 + sqrt(var_5 * var_5 - 4 * var_4 * var_6)) / (2 * var_4);
  var_7 = var_7 * 3600;
  var_7 = var_7 + 1.5;
  return var_7;
}

snapplayertotoppos() {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8D7D06302FE5E159", var_0);

    if(isDefined(var_0) && var_0 nuke_vault_suicidebomber_internal())
      var_0 dodamage(var_0.health, self.origin, var_0, var_0, "_encstr_8D4E0A501FCB898912CB3FA3");
  }
}

snappointtooutofboundstriggertrace() {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 70;
  var_1 = -80;
  var_2 = 150;
  var_3 = 25;
  var_4 = -100;

  for(;;) {
    var_5 = getentarrayinradius("_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56", "_encstr_AC110A7F14873B5B3D073009", self.origin, getdvarfloat("_encstr_88DE0C99B5F3EBF77031AD38034E", 400));

    if(var_5.size <= 1) {
      wait 0.5;
      continue;
    }

    var_6 = scripts\engine\trace::create_vehicle_contents();
    var_7 = anglesToForward(self.angles);
    var_8 = self.origin + var_7 * getdvarfloat("_encstr_8CDC077B631EE3FFA8", var_2) + (0, 0, getdvarfloat("_encstr_BADC07F043CB4C1733", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_10) && var_10 nuke_vault_suicidebomber_internal()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "_encstr_8D4E0A501FCB898912CB3FA3");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("_encstr_86DC073AACE647FAD6", var_3) + (0, 0, getdvarfloat("_encstr_BADC07F043CB4C1733", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_10) && var_10 nuke_vault_suicidebomber_internal()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "_encstr_8D4E0A501FCB898912CB3FA3");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("_encstr_A2DC078ECACD3A7D89", var_4) + (0, 0, getdvarfloat("_encstr_BADC07F043CB4C1733", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_10) && var_10 nuke_vault_suicidebomber_internal()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "_encstr_8D4E0A501FCB898912CB3FA3");
      waitframe();
      continue;
    }

    waitframe();
  }
}

smuggler_killed_early() {
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56");
}

activate_emp_drone_pick_up() {}