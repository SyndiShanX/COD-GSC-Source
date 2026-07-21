/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_dwn_twn\cp_dwntwn_rooftop.gsc
****************************************************/

main() {
  level.rooftop_obj_func = ::register_objectives;
}

register_objectives() {
  scripts\cp\cp_objectives::registerobjective("_encstr_A1AD0DAE3FD7A2B0A8DB49A30F6F32", ::add_module_ai_spawn_func_to_module, ::analytics_lui_mission_end_dlog, ::add_module_ai_spawn_func_to_module, ::add_module_ai_spawn_func_to_module, ::adjustmatchtimerpausedstatefromscore);
  scripts\cp\cp_objectives::registerobjective("_encstr_A939125BCFC5500BEA10775BAF1FA8CE7B959D34", ::add_module_ai_spawn_func_to_module, ::angle_molotov_mortar, ::add_module_ai_spawn_func_to_module, ::add_module_ai_spawn_func_to_module, ::adjustlootleadermarkcount);
  scripts\cp\cp_objectives::registerobjective("_encstr_B1941A9CBDBD661DBDC1BE9C5896917D58B147A59D85D1B23785E8DC", ::add_module_ai_spawn_func_to_module, ::anglesoffset, ::add_module_ai_spawn_func_to_module, ::add_module_ai_spawn_func_to_module, ::adjusteventdistributionpadding);
  scripts\cp\cp_objectives::registerobjective("_encstr_8877133A9730D783E053914B59CB1B418841A6B939", ::add_module_ai_spawn_func_to_module, ::anchoredwidgetid, ::add_module_ai_spawn_func_to_module, ::add_module_ai_spawn_func_to_module, ::adjustmatchtimerpausedstatefromleadchange);
  level._id_1404B = 1;
}

add_module_ai_spawn_func_to_module(var_0, var_1) {}

adjustmatchtimerpausedstatefromscore(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("_encstr_8ED419BE0BE6CB5855CB1B4AE07BA750572DD2EA3FF77A35F88805");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_86C515279D704B8573E965B8C71C43C73BC972B8C767DD");
}

adjustlootleadermarkcount(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("_encstr_8ED419BE0BE6CB5855CB1B4AE07BA750572DD2EA3FF77A35F88805");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_AB1E1B8B9F885A4C4823F18239406401DF014F5F63AE7103F869B20B93");
}

adjusteventdistributionpadding(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("_encstr_8ED419BE0BE6CB5855CB1B4AE07BA750572DD2EA3FF77A35F88805");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_AB1E1B8B9F885A4C4823F18239406401DF014F5F63AE7103F869B20B93");
  setup_flags();
  level.sats_connected = 0;
  setDvar("_encstr_87C80E070FFE31B3B03B79BF3180FD0A", 1);
  _id_12E95();
  trigger_spawn_init();
  register_spawn_groups();
  level thread playtutsound();
  level.rooftop1_sat = sat_setup(1);
  level.rooftop2_sat = sat_setup(2);
  level.rooftop3_sat = sat_setup(3);
  level.rooftop1_sat.power_switch.alarm_box notify("_encstr_8F5C086405E70FBA4B4A", level.players[0]);
  wait 1;
  level.rooftop2_sat.power_switch.alarm_box notify("_encstr_8F5C086405E70FBA4B4A", level.players[0]);
  wait 1;
  level.rooftop3_sat.power_switch.alarm_box notify("_encstr_8F5C086405E70FBA4B4A", level.players[0]);
  wait 7;
}

adjustmatchtimerpausedstatefromleadchange(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("_encstr_8ED419BE0BE6CB5855CB1B4AE07BA750572DD2EA3FF77A35F88805");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_86C515279D704B8573E965B8C71C43C73BC972B8C767DD");
}

anchoredwidgetid(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("_encstr_8ED419BE0BE6CB5855CB1B4AE07BA750572DD2EA3FF77A35F88805");
  objective_state(level.rooftop1_sat.objective_id, "_encstr_8267056410C669");
  objective_state(level.rooftop2_sat.objective_id, "_encstr_8267056410C669");
  objective_state(level.rooftop3_sat.objective_id, "_encstr_8267056410C669");
  objective_position(var_0.objectiveindex, scripts\engine\utility::getStruct("_encstr_BE310D20BB6DCBC3BB2DD64805F21D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin);
  level.rooftop1_sat.computer makeunusable();
  level.rooftop2_sat.computer makeunusable();
  level.rooftop3_sat.computer makeunusable();
  minigun_should_keep_firing();
  var_1 = fixupsupersandtacticalsforgunfightmaps();
  var_1 flag_bot_attacker_limit_for_team();
  var_1 setModel("_encstr_93552C2B2B7D32DEEDE4D7BBB7B746BE6E3AB0B4DCCA8CEBB4B91DEB8198F5B559CB831646F5D573B1DB1BDA59C8");
  level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
}

anglesoffset(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("_encstr_8ED419BE0BE6CB5855CB1B4AE07BA750572DD2EA3FF77A35F88805");
  setomnvar("_encstr_83351455B4190FC88763D8A8BFCB2345C21DC45D4C57", level.rooftop1_sat._id_13393);
  setomnvar("_encstr_8B3514BB584872AA4CD539B3B72E2825A9B0E739C803", level.rooftop2_sat._id_13393);
  setomnvar("_encstr_86351463788FF28FC928797CA893237A13B8CAEBD8EF", level.rooftop3_sat._id_13393);
  var_1 = (level.rooftop1_sat._id_13393 + level.rooftop2_sat._id_13393 + level.rooftop3_sat._id_13393) / 3;
  var_1 = int(max(1, var_1));
  setomnvar("_encstr_BE021993E031BB520C65371B1F2ECBF258A88F5B38D9640ADD130B", var_1);
  _id_12EA3();

  foreach(var_3 in level.players)
  var_3 sethudtutorialmessage(&"_encstr_8B5D2DD014AF22EA9CFAA85D93BEE948298AA12A5259A2359792F47AC88A3D0AD78A4982399AF50D9EA6821351A82A");

  wait 5;

  foreach(var_3 in level.players)
  var_3 clearhudtutorialmessage();
}

angle_molotov_mortar(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("_encstr_8ED419BE0BE6CB5855CB1B4AE07BA750572DD2EA3FF77A35F88805");
  level.teamnamelist = ["_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08"];
  level.get_mortar_impact_pos = ::_id_11D2D;
  level.sixthsenselastvotime = ::sixthsense_shouldwarnaboutotherplayer;
  var_1 = scripts\engine\utility::getStruct("_encstr_8D05199CDBBD33D1DB387D9CC29623BE1CC685972BE4FA1A2B1BD2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.player_lb = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_1);
  level.player_lb thread scripts\cp\cp_vehicles::waiting_for_disable();
  level.player_lb scripts\cp\utility::make_entity_sentient_cp("_encstr_9A8507BA4040188D08", 0);
  level.player_lb.maxhealth = 5000;
  level.player_lb.health = 5000;
  analytics_lui_mission_end_dlog(var_0);
}

analytics_lui_mission_end_dlog(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("_encstr_8ED419BE0BE6CB5855CB1B4AE07BA750572DD2EA3FF77A35F88805");
  level._id_12D8B = 1;
  level.dogtag_revive = 0;
  setDvar("_encstr_87C80E070FFE31B3B03B79BF3180FD0A", 0);
  scripts\cp\cp_spawning_util::_id_13BBD(1);
  level thread playtutsound();
  setup_flags();
  trigger_spawn_init();
  register_spawn_groups();
  level thread _id_11D2F();
  level.rooftop1_sat = sat_setup(1);
  level.rooftop2_sat = sat_setup(2);
  level.rooftop3_sat = sat_setup(3);
  _id_12E95();
  level thread wait_for_any_sat_death(var_0);
  level.sats_connected = 0;
  scripts\cp\utility::objective_update("_encstr_A939125BCFC5500BEA10775BAF1FA8CE7B959D34", undefined, undefined, undefined, undefined, level.sats_connected);

  foreach(var_2 in level.players)
  var_2 scripts\cp\utility::brjugg_playerwelcomesplashes(1);

  level waittill("_encstr_8C750FE211984BC19EF79BA3DBB6BB95C0");
  wait 1;
}

sat_setup(var_0) {
  var_1 = getEnt("_encstr_A16E0952A8F0830BCF88F1" + var_0 + "_encstr_92060B4FB621DB5FD99862ABC8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1._id_13393 = 1;
  var_1._id_13394 = 0;
  var_1.computer = getEnt("_encstr_A16E0952A8F0830BCF88F1" + var_0 + "_encstr_952D09F0824AB1BE33F728", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1.computer setModel("_encstr_8FA928CD806C343819BBC8CF2BB7F7EE6A21E8ED8142D3E1E393B7A059C7F7E277FDE03625F3B38DF5A7");
  var_1.computer._id_12A45 = scripts\engine\utility::getclosest(var_1.computer.origin, getEntArray("_encstr_ABF307BB58591C2A65", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));

  switch (var_0) {
    case 1:
      var_1.computer._id_12A45._id_1281E = "_encstr_B4A31E285AF8835D379213013B9D181AA023613173D361C42A3B21F1B3901726";
      init_freight_lift("_encstr_932906F74A6F1818", var_1.computer._id_12A45);
      var_1.computer._id_12A45.onsoccerballreset.get_total_successful_vehicle_spawns_from_module = "_encstr_81E0140785483FD3C0182A13E1276BB7410FB99A1DC0";
      break;
    case 2:
      var_1.computer._id_12A45._id_1281E = "_encstr_84F81C98579CC001F2426B601CEA43C9F9435891932D19E95A6A70FEF7D2";
      init_freight_lift("_encstr_8419044EB232", var_1.computer._id_12A45);
      var_1.computer._id_12A45.onsoccerballreset.get_total_successful_vehicle_spawns_from_module = "_encstr_91221202B81CD61F6F68BA11DBFDA170D3550AD3";
      break;
    case 3:
      var_1.computer._id_12A45._id_1281E = "_encstr_8DBE1DDA2DC6D28E1693BCFADA56E5B1169C19BE3959168CB29CD7988DAEAC";
      init_freight_lift("_encstr_B29B0550F33591", var_1.computer._id_12A45);
      var_1.computer._id_12A45.onsoccerballreset.get_total_successful_vehicle_spawns_from_module = "_encstr_856F13C4B1AB59BED62BF236B093C8F5B1854E932F";
      break;
  }

  var_1.radar = _id_12E8B("_encstr_A33811CF6223A3CBCC2DA1C001534883F8D919" + var_0, "_encstr_8D2231C23821BF0328CD496789604AD3D8529ABA200DAF3AF0F94D2C8138933F68AB1262695EF73298377F3BA7B0DD6725A09A");
  var_1.radio = _id_12E8B("_encstr_A33811CF6223A3CBCC2DA1C001534883F8D919" + var_0, "_encstr_A22D31DA4B8D96A32C93CBEB23B2388DDECBC231C659BECD2CE8ACC61B2DE859BEC916C8A57BFA39D2B37DCD6DB263ACE8F6E6");
  var_1.buy_point_loop = _id_12E8B("_encstr_A33811CF6223A3CBCC2DA1C001534883F8D919" + var_0, "_encstr_8F2833C803552B1CEFEB38A780E3494AD2AB31B94163B9CB2154C5E3E9E013D8AE40C88379409A1B675B2D1A990AA7D2F847A980C6");
  var_1.buy_point_loop.get_total_successful_vehicle_spawns_from_module = "_encstr_83D116DC163A95C636A54795D74E2C32B027F5C60B4EE4F2";
  var_1.radio.get_total_successful_vehicle_spawns_from_module = "_encstr_99301BBFDF1BED630434FBD151F3E090F30B0F3943522ED1230E23CBC0";
  var_1.radar.get_total_successful_vehicle_spawns_from_module = "_encstr_858D18D75E9BBB9370B0F375098ABA1353F81539A123278BE260";
  var_1.flagname = "_encstr_844C029C" + var_0 + "_encstr_8A040B1189505375D83F746DD9";
  var_1.computer.flagname = var_1.flagname;
  var_1.power_switch = scripts\engine\utility::getStruct("_encstr_928808AB60380B8BE041" + var_0 + "_encstr_8308074993E0EFC2B6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::initialize_alarm_box(var_1.power_switch, 0);
  var_1 thread sat_damage_monitor(var_0);
  sat_computer_init(var_1, var_0);
  thread _id_12E96(var_1, var_0);
  return var_1;
}

init_freight_lift(var_0, var_1) {
  var_1.get_destinations_in_current_circle = var_1.origin + (0, 0, 9.5) + anglestoleft(var_1.angles) * 1.5;
  var_1.get_destination_in_current_circle = var_1.angles + (90, 0, 90);
  var_1.onsoccerballreset = previous_bullet_weapon(var_1);
  var_2 = var_1.onsoccerballreset _id_12FF8();

  if(isDefined(var_2)) {
    var_1.onsoccerballreset.origin = var_2.origin;
    var_1.onsoccerballreset.angles = var_2.angles;
  }
}

update_computer_hint(var_0, var_1, var_2) {
  var_0 setHintString(var_1);
  var_0 sethinttag(var_2);
}

sat_wait_for_all_connected() {
  scripts\engine\utility::flag_wait_all("_encstr_BA7E0D20DB7F06878075F1869930A0", "_encstr_8B330DCB334876CAC8D53D8F1B25A8", "_encstr_91DB0D4ECCFA8DB79BCDAC1BA3AC91");

  while(!istrue(level.rooftop1_sat.activated) || !istrue(level.rooftop2_sat.activated) || !istrue(level.rooftop3_sat.activated))
    wait 1;

  level notify("_encstr_8C750FE211984BC19EF79BA3DBB6BB95C0");
  wait 2;
}

wait_for_any_sat_death(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_93940A9ED80B0F7098118B70");
  logevent_servermatchstart(18);
  level thread[[level.endgame]]("_encstr_AD830516C68DE5", level.end_game_string_index["_encstr_BA19049B7723"]);
}

sat_damage_monitor(var_0) {
  get_sat_objective(self, var_0);
  objective_state(self.objective_id, "_encstr_AF5A081BBAC993AC73A3");
  objective_setprogress(self.objective_id, 0);
  objective_setshowprogress(self.objective_id, 1);
  var_1 = scripts\engine\utility::getclosest(self.origin, level.rooftop_triggers);
  var_1 scripts\engine\utility::trigger_on();
  scripts\engine\utility::flag_wait("_encstr_8ED9159B93B373974BBCB320771A18E748CB17B84420CB");
  thread bomb_plant_think();
}

get_sat_objective(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::requestworldid("_encstr_A2320D5D273203A0AC9F26F8068780", 20);
  objective_setplayintro(var_2, 1);
  objective_onentity(var_2, var_0);
  objective_setzoffset(var_2, 75);
  var_0.objective_id = var_2;
  objective_icon(var_2, self.script_noteworthy);
}

bomb_plant_think() {
  self.bombplantent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", scripts\engine\utility::getStruct(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin);
  self.bombplantent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.bombplantent.angles = scripts\engine\utility::getStruct(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles;
  level.cpoperationcratecapturecallback = 1;

  for(;;) {
    if(!istrue(level.cpoperationcratecapturecallback)) {
      wait 1;
      continue;
    }

    if(!isDefined(self._id_11E6E) || gettime() > self._id_11E6E) {
      level.cpoperationcratecapturecallback = 0;
      _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::attract_agent_to_bomb_plant(self.bombplantent);
    }

    if(istrue(self.bombplantent.planted)) {
      self.bombplantent notify("_encstr_8DC91067F4A5F8D8F72BEB1342C70578BD7F");
      thread cprooftopcratecapturecallback();

      while(istrue(self.bombplantent.planted))
        wait 1;

      footprint_mask_clipheight();
      self._id_11E6E = gettime() + randomintrange(30000, 45000);
    }

    level.cpoperationcratecapturecallback = 1;
    wait 1;
  }
}

cprooftopcratecapturecallback() {
  var_0 = self.objective_id;
  var_1 = self.bombplantent.charge;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1.leave_pool_behind_after_deactivation = 30;
  var_1 follow_players_when_close(var_0);
  var_1 thread focus_fire_icon_objective_id(var_0);
  var_2 = &"_encstr_BD30110D05AF9AA225922D8ABC44A291556A51";
  var_1 setHintString(var_2);
  var_1 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_1 sethintdisplayrange(128);
  var_1 sethintdisplayfov(65);
  var_1 setuserange(64);
  var_1 setusefov(65);
  var_1 sethintonobstruction("_encstr_BD1805CB69C063");
  var_1 setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
  var_1 makeusable();
  var_1 endon("_encstr_AC8F0AC94174F85AFA901D30");
  var_1 endon("_encstr_AD75063D571AE108");
  thread keypad_confirm_code_correct(var_1);
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_AA6822A72946F4C12510D31BF05F18BA4C392F63099F2D49CF85EF4745AF701F1501AFB3", "_encstr_9A8507BA4040188D08", 5);
  var_1 hudoutlineenable("_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8");

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(isDefined(var_3) && isPlayer(var_3)) {
      break;
    }
  }

  var_1 notify("_encstr_9A7B088CCA335D37CA91");

  if(isDefined(self.bombplantent.planted))
    self.bombplantent.planted = undefined;

  var_1 hudoutlinedisable();
  var_1 delete();
}

keypad_confirm_code_correct(var_0) {
  var_0 endon("_encstr_B42407393D47BEC9F4");
  var_0 endon("_encstr_AC8F0AC94174F85AFA901D30");

  for(;;) {
    objective_setpulsate(self.objective_id, 1);
    wait 3;
    objective_setpulsate(self.objective_id, 0);
    wait 3;
  }
}

follow_players_when_close(var_0) {
  scripts\cp\cp_objectives::objective_set_play_intro(var_0, 1);
  objective_setlabel(var_0, &"_encstr_BD30110D05AF9AA225922D8ABC44A291556A51");
  objective_setshowprogress(var_0, 1);
  objective_setprogress(var_0, 1);
  objective_setownerteam(var_0, "_encstr_8E8405EA382B2A");
  objective_setpulsate(var_0, 1);
}

footprint_mask_clipheight() {
  objective_setpulsate(self.objective_id, 0);
  objective_setprogress(self.objective_id, 0);
  objective_setlabel(self.objective_id, "_encstr_B40101");
  objective_setownerteam(self.objective_id, "_encstr_9A8507BA4040188D08");
}

focus_fire_icon_objective_id(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9A7B088CCA335D37CA91");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self.leave_pool_behind_after_deactivation;
  var_2 = var_1;
  var_3 = var_1;

  if(soundexists("_encstr_B8F21E70D3818353E737D4C6F43B7E65756AD821BA65DB88DF2051CFF6636121")) {
    foreach(var_5 in level.players)
    var_5 playlocalsound("_encstr_B8F21E70D3818353E737D4C6F43B7E65756AD821BA65DB88DF2051CFF6636121");
  }

  wait 3;

  while(var_3 > 0) {
    var_3--;
    objective_setprogress(var_0, var_3 / var_2);

    if(soundexists("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E")) {
      foreach(var_5 in level.players)
      var_5 playlocalsound("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E");
    }

    wait 1;
  }

  var_9 = "_encstr_8A78055C8D488C";
  var_10 = 0.1;
  var_11 = magicgrenademanual(var_9, self.origin + (0, 0, 6), (0, 0, 0), var_10);
  var_11.angles = self.angles;
  self notify("_encstr_AC8F0AC94174F85AFA901D30");

  if(isDefined(self.planted))
    self.planted = undefined;

  if(isDefined(self.outlineid))
    scripts\cp\cp_outline_utility::outlinedisable(self.outlineid, self);

  playFX(level._effect["_encstr_848F0B1AB770B4E74D96D20B9B"], self.origin);
  self playSound("_encstr_9A6C0FE238E127DF698122EBE08195D399");
  earthquake(0.45, 3, self.origin, 1024);
  self hide();
  level notify("_encstr_93940A9ED80B0F7098118B70");
}

setup_flags() {
  scripts\engine\utility::flag_init("_encstr_8ED9159B93B373974BBCB320771A18E748CB17B84420CB");
  scripts\engine\utility::flag_init("_encstr_BD8F16C3E623029B40B837CF40F84ED9FFF00D7A4143DBD5");
  scripts\engine\utility::flag_init("_encstr_BA7E0D20DB7F06878075F1869930A0");
  scripts\engine\utility::flag_init("_encstr_8B330DCB334876CAC8D53D8F1B25A8");
  scripts\engine\utility::flag_init("_encstr_91DB0D4ECCFA8DB79BCDAC1BA3AC91");
}

register_spawn_groups() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_91761B6E82D8A8F3BFFD2EE338BD6E705F7345381740C79B33082B357E", 3, 3, 3, 0.1, undefined, "_encstr_91761B6E82D8A8F3BFFD2EE338BD6E705F7345381740C79B33082B357E");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_84E31D6B6BE0D78A40AB0614B3105953159822B208CE874758830E0C77514A", 3, 3, 3, 0.1, undefined, "_encstr_91761B6E82D8A8F3BFFD2EE338BD6E705F7345381740C79B33082B357E");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_93511E9E99D7A3732AAA605822050959CB4F269D29EBA9A7129290B8BA9DC953", 3, 3, 3, 0.1, undefined, "_encstr_93511E9E99D7A3732AAA605822050959CB4F269D29EBA9A7129290B8BA9DC953");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_ACEC209B33E04B29D0112BB2C8606052CE57135F6B90F2EFF839677DA180AC8B30E5", 3, 3, 3, 0.1, undefined, "_encstr_ACEC209B33E04B29D0112BB2C8606052CE57135F6B90F2EFF839677DA180AC8B30E5");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_91EC204E89F5830B4E858E93DEF6385639AF9C952D7333DEC9362B5BCAE68EDCFA66", 3, 3, 3, 0.1, undefined, "_encstr_91EC204E89F5830B4E858E93DEF6385639AF9C952D7333DEC9362B5BCAE68EDCFA66");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9669129392BFA0552A5747E59F82281857DA39C9", 4, 4, 5, 0.1, undefined, "_encstr_9669129392BFA0552A5747E59F82281857DA39C9", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BE341498CE5708CB3AAC40DE87421571DF6B88A80F52", 4, 4, 5, 0.1, undefined, "_encstr_BE341498CE5708CB3AAC40DE87421571DF6B88A80F52", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_828A1BBB7AA7F046329FCDD1B70B98D03504A0B155D2A8750A67D5C9F7", 3, 3, 3, 0.1, undefined, "_encstr_828A1BBB7AA7F046329FCDD1B70B98D03504A0B155D2A8750A67D5C9F7");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8BB51D580297E9278AEF9895C7B3373315C720708F526133329780A55A9935", 3, 3, 3, 0.1, undefined, "_encstr_828A1BBB7AA7F046329FCDD1B70B98D03504A0B155D2A8750A67D5C9F7");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A7C91E3B6A1FFF4F9D10611B40B792421B3935974F4E174F23F74088A16DB1EA", 3, 3, 3, 0.1, undefined, "_encstr_A7C91E3B6A1FFF4F9D10611B40B792421B3935974F4E174F23F74088A16DB1EA");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B68C209C23FAE016E4163AC9F6EDC12B27FA39B2A573CC7BC9C695ADCAE6D16E7DC8", 3, 3, 3, 0.1, undefined, "_encstr_B68C209C23FAE016E4163AC9F6EDC12B27FA39B2A573CC7BC9C695ADCAE6D16E7DC8");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B48C200AD369E09ABE43ABBBB7E8532DA8C68257D098BE32965F17DF9B375B7319A3", 3, 3, 3, 0.1, undefined, "_encstr_B48C200AD369E09ABE43ABBBB7E8532DA8C68257D098BE32965F17DF9B375B7319A3");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8CCD144E19BE34591B2DD7272B4B73CCDB9C8D597D23", 4, 4, 4, 0.1, undefined, "_encstr_8CCD144E19BE34591B2DD7272B4B73CCDB9C8D597D23", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_924D12BB0A278C078D33DF0ADD48E3D79FA01242", 4, 4, 4, 0.1, undefined, "_encstr_924D12BB0A278C078D33DF0ADD48E3D79FA01242", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AC961B3A0691383621F5B041F29240DA414B7D721F5ED85FED19E5934F", 3, 3, 3, 0.1, undefined, "_encstr_AC961B3A0691383621F5B041F29240DA414B7D721F5ED85FED19E5934F");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AC871D1B4A3EB9EB275575EF4DEDE1528170F3C31033F3F2637D7DE3AE8F6F", 3, 3, 3, 0.1, undefined, "_encstr_AC961B3A0691383621F5B041F29240DA414B7D721F5ED85FED19E5934F");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_81131E22131181F73AF0BB7B4288208788C10B770AC5D668037767687DEA4C27", 3, 3, 3, 0.1, undefined, "_encstr_81131E22131181F73AF0BB7B4288208788C10B770AC5D668037767687DEA4C27");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B1EC209D77C18B88ABCAF15D128D7B3FCD07A05F7C3E645FBB23670D354E849737BA", 3, 3, 3, 0.1, undefined, "_encstr_B1EC209D77C18B88ABCAF15D128D7B3FCD07A05F7C3E645FBB23670D354E849737BA");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A2EC20207EEFA36B83C6ADB65D8A91C92A37A82BBF66393FEB6E2D3137B2D1735F2E", 3, 3, 3, 0.1, undefined, "_encstr_A2EC20207EEFA36B83C6ADB65D8A91C92A37A82BBF66393FEB6E2D3137B2D1735F2E");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_830112C9CCFA1A951BD27D27B2B49B66F6E4C62B", 4, 4, 4, 0.1, undefined, "_encstr_830112C9CCFA1A951BD27D27B2B49B66F6E4C62B", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_933D144BF2D77CF7D0E30F3A8D189387CF90C2B229A5", 4, 4, 4, 0.1, undefined, "_encstr_933D144BF2D77CF7D0E30F3A8D189387CF90C2B229A5", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_91761B6E82D8A8F3BFFD2EE338BD6E705F7345381740C79B33082B357E", ::canplaykillstreakdialog);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_84E31D6B6BE0D78A40AB0614B3105953159822B208CE874758830E0C77514A", ::canplaykillstreakdialog);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_828A1BBB7AA7F046329FCDD1B70B98D03504A0B155D2A8750A67D5C9F7", ::canplaykillstreakdialog);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8BB51D580297E9278AEF9895C7B3373315C720708F526133329780A55A9935", ::canplaykillstreakdialog);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AC961B3A0691383621F5B041F29240DA414B7D721F5ED85FED19E5934F", ::canplaykillstreakdialog);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AC871D1B4A3EB9EB275575EF4DEDE1528170F3C31033F3F2637D7DE3AE8F6F", ::canplaykillstreakdialog);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A5C11420608A33B9B347BA3BD18AF173267CF88AF10D", 3, 3, undefined, [::wave_reinforce, 0.5, 25, 3], undefined, "_encstr_A5C11420608A33B9B347BA3BD18AF173267CF88AF10D");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A5C11420608A33B9B347BA3BD18AF173267CF88AF10D", ::canprogressingunrank);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_85BC146B608D3EB313E03F388D7B57C2CD48F3B24027", 3, 3, 3, 0.5, 0, "_encstr_85BC146B608D3EB313E03F388D7B57C2CD48F3B24027");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AA050DD017BB790D8A9F861832A357", 3, 3, 3, 0.5, undefined, "_encstr_AA050DD017BB790D8A9F861832A357");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AA050DD017BB790D8A9F861832A357", ::canplaykillstreakdialog);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BD7F12E99C97887D127F5F0D676A30204FB251E1", 4, 4, 4, 0.1, undefined, "_encstr_BD7F12E99C97887D127F5F0D676A30204FB251E1", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AB1314B02DF51A9536D2BE3995963733B74E3659BE19", 4, 4, 4, 0.1, undefined, "_encstr_AB1314B02DF51A9536D2BE3995963733B74E3659BE19", undefined, undefined, 15);
  var_0 = getEnt("_encstr_A1F310584B7D27BDF6CC1DB7387DA327B476", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 thread _id_12B4B(["_encstr_85BC146B608D3EB313E03F388D7B57C2CD48F3B24027", "_encstr_BD7F12E99C97887D127F5F0D676A30204FB251E1", "_encstr_AB1314B02DF51A9536D2BE3995963733B74E3659BE19", "_encstr_AA050DD017BB790D8A9F861832A357"], 4);
}

wave_reinforce(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0.groupspawned))
    var_0.groupspawned = 0;

  if(!isDefined(var_0.num_waves))
    var_0.num_waves = 1;

  if(var_0.currentmodulekills >= var_3 * var_0.num_waves) {
    var_0.num_waves++;
    return var_2;
  }

  if(var_0.activecount <= var_0.min_size) {
    var_0.groupspawned++;

    if(var_0.groupspawned < 3)
      return var_1;
    else {
      var_0.groupspawned = 0;
      return 4;
    }
  }

  if(var_0.activecount >= var_0.max_size) {
    while(var_0.activecount >= var_0.min_size)
      wait 0.25;

    var_0.num_waves++;
    return var_2;
  }

  var_0.groupspawned++;

  if(var_0.groupspawned < 3)
    return var_1;
  else {
    var_0.groupspawned = 0;
    return 4;
  }
}

_id_11D2D(var_0) {
  if(!isDefined(var_0.targets))
    return undefined;

  var_1 = scripts\engine\utility::random(var_0.targets);
  var_2 = var_1.origin + (randomintrange(-100, 100), randomintrange(-100, 100), 0);
  var_3 = scripts\engine\trace::ray_trace(var_2 + (0, 0, 500), var_2);
  return var_3["_encstr_BD260953AA97E3F014279D"];
}

_id_11D2F() {
  _id_11D2E("_encstr_A38611B3256F303DFAD3A74357E288D82C3E3B", 1);
  _id_11D2E("_encstr_A5DD1127DBDB661D7B387D917D5BED4E3A0B39", 2);
  _id_11D2E("_encstr_845E1163F55F330DCA83F73727B2D8E8FCCEEB", 3);
  var_0 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A5C11420608A33B9B347BA3BD18AF173267CF88AF10D");
}

_id_11D2E(var_0, var_1) {
  var_2 = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 hidepart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159", "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
  var_2 thread mortar_think(var_1);
}

mortar_think(var_0) {
  self.targets = undefined;

  for(;;) {
    var_1 = get_players_on_rooftop(var_0);

    if(var_1.size) {
      self.targets = var_1;
      _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::attract_agent_to_mortar(self);
      self.targets = undefined;
      wait(randomintrange(15, 25));
      continue;
    }

    wait 1;
  }
}

get_players_on_rooftop(var_0) {
  var_1 = getEnt("_encstr_A16E0952A8F0830BCF88F1" + var_0 + "_encstr_A3500680330BFBC9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!var_4 scripts\cp\utility::is_valid_player() || !var_4 isonground() || var_4 isonladder()) {
      continue;
    }
    if(var_4 istouching(var_1))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_12E95() {
  scripts\engine\utility::array_thread(getEntArray("_encstr_81F90A75E710D19B36387B72", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), ::_id_12E94);
}

_id_12E94() {
  self setHintString(&"_encstr_814A22C5F9901D2C681611F7C141B0460D4103B1576E856655F6CD90D7A4C798239161C8");
  self setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  self sethintdisplayrange(128);
  self sethintdisplayfov(65);
  self setuserange(96);
  self setusefov(65);
  self sethintonobstruction("_encstr_BD1805CB69C063");
  self setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  self makeusable();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(isDefined(var_0.armorweapon)) {
      if(getdvarint("_encstr_83E5104333423030CF4EB1EBB7E75874CA2B") > 0)
        var_0 _id_139C0(self);
      else {
        var_0 scripts\cp\utility::setlowermessage("_encstr_9B910C2C8D272B0B9197D085D995", &"_encstr_870227ADC1BF9D0125EF010FD659F956430825B7B843A5691589293DC53669836F70FD7FC00FE5B196", 5);
        var_0 playlocalsound("_encstr_95C80F7737B949282E37D503E07B1D60CB");
        continue;
      }
    }

    var_0 playlocalsound("_encstr_8ED215BE0BE6C7C8558FBB3AFECFDB4896A672ADD7830B");
    self.get_track_location_index = scripts\cp\utility::_id_13070(var_0, self.get_total_successful_vehicle_spawns_from_module);
    var_0.armorweapon = self;
    var_0 thread _id_12C37();
    self makeunusable();
    self hide();
    return;
  }
}

_id_139C0(var_0) {
  var_1 = self.armorweapon;
  var_2 = var_1.get_track_location_index;

  if(isDefined(self))
    scripts\cp\utility::_id_12BC6(self, var_2.slot);

  var_0 hide();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.get_track_location_index = undefined;
  var_1 show();
  var_1 scripts\engine\utility::delaythread(1, ::_id_12E94);
}

_id_12C37() {
  self endon("_encstr_B1EC0C99824EE9A8F329DF7BC34F");
  var_0 = self.armorweapon;
  var_1 = var_0.get_track_location_index;
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self))
    scripts\cp\utility::_id_12BC6(self, var_1.slot);

  var_0 show();
  var_0 thread _id_12E94();
}

_id_12C38(var_0, var_1, var_2, var_3) {
  self endon("_encstr_A30111491BBA1E98DC69ABE1CBBF6843529FEB");
  var_4 = self._id_12E91;
  var_5 = var_4.get_track_location_index;
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self))
    scripts\cp\utility::_id_12BC6(self, var_5.slot);

  thread _id_12E92(var_0, var_1, var_2, var_3);
  var_4 show();
}

trigger_spawn_init() {
  level.rooftop_triggers = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_868A17B09F4FD1F1E212A84C6A1A0BDBF9C708082F1F899B1B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2.origin, 0, int(var_2.radius), int(var_2.height));
    var_3.target = var_2.target;
    var_3.script_noteworthy = var_2.script_noteworthy;

    if(var_3.script_noteworthy == "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1")
      var_3.rooftopid = 1;
    else if(var_3.script_noteworthy == "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3")
      var_3.rooftopid = 2;
    else
      var_3.rooftopid = 3;

    var_3.targetname = "_encstr_A16E0952A8F0830BCF88F1" + var_3.rooftopid + "_encstr_A3500680330BFBC9";
    level.rooftop_triggers[level.rooftop_triggers.size] = var_3;
    canplaygasmaskgesturebr("_encstr_8D1F09027BA68F8523E342", var_3.origin);
    canplaygasmaskgesturebr("_encstr_9B280AF2190E37E7B001B5AA", var_3.origin);
    var_4 = scripts\engine\utility::getStructArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").size;
    scripts\cp\cp_modular_spawning::registerambientgroup(var_3.target, var_4, var_4, var_4, 0.5, undefined, var_3.target);
    var_3 thread trigger_spawn();
    var_3 scripts\engine\utility::trigger_off();
  }
}

trigger_spawn() {
  self endon("_encstr_8F110E9BE8DB83EBB90785DDB95A9B76");
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
  var_1 = self.target;
  var_2 = scripts\cp\cp_modular_spawning::run_spawn_module(var_1);
  wait 60;
  _id_12B4B(["_encstr_844C029C" + self.rooftopid + "_encstr_96F31938F957F16B3DEA9828315213C84B66B82653D7F8A3E5D330", "_encstr_844C029C" + self.rooftopid + "_encstr_993F1BF90BEFDE9730C5959A709B5FE46D9062A368AB15AFE8358BBFDE", "_encstr_844C029C" + self.rooftopid + "_encstr_91FF1CC0727A8D4914932830835D639F335F43D04F3255F1EDC77030FB63", "_encstr_844C029C" + self.rooftopid + "_encstr_95EE1E78AB5F3B79899DC72F3F716B864B0930BB28F5D31699D32D4DE8C229D2", "_encstr_844C029C" + self.rooftopid + "_encstr_A2EE1E4973D1E36BE30220389A2A958E2ADF70588367BB279AED2DB07363877B", "_encstr_844C029C" + self.rooftopid + "_encstr_959610BE1A56D85AAF4E562DDC99BDE4B195", "_encstr_844C029C" + self.rooftopid + "_encstr_997812AF862BB15A7D93ACB4E6CCEDE48DB27D64"], 1, 1);
}

kill_rate_too_slow() {
  wait 2;
  self makeusable();
}

_id_12E8C(var_0) {
  var_1 = int(100 - anglesdelta((0, var_0.buy_point_loop.angles[1], 0), (0, var_0._id_13394, 0)));

  if(var_1 > 100)
    var_1 = 100;

  if(var_1 < 1)
    var_1 = 1;

  return var_1;
}

_id_12EA3() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.hack_duration = 120;
  level thread _id_12E98();
  level thread _id_12EA4();
  var_0 = 0;

  while(var_0 < level.hack_duration) {
    var_1 = _id_12E8C(level.rooftop1_sat);
    var_2 = _id_12E8C(level.rooftop2_sat);
    var_3 = _id_12E8C(level.rooftop3_sat);
    var_4 = (var_1 + var_2 + var_3) / 3;
    var_4 = int(max(1, var_4));

    if(var_4 < 80) {
      thread _id_12E97();
      level.hacking_paused = 1;
    } else {
      if(!scripts\engine\utility::flag("_encstr_8ED9159B93B373974BBCB320771A18E748CB17B84420CB"))
        scripts\engine\utility::flag_set("_encstr_8ED9159B93B373974BBCB320771A18E748CB17B84420CB");

      level notify("_encstr_836F10A06FD8F82B1807DF43A5BF35B0BF32");
      level.hacking_paused = 0;
    }

    setomnvar("_encstr_BE021993E031BB520C65371B1F2ECBF258A88F5B38D9640ADD130B", var_4);
    wait 0.25;

    if(!level.hacking_paused)
      var_0 = var_0 + 0.25;
  }

  level notify("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC");
  scripts\engine\utility::flag_set("_encstr_BD8F16C3E623029B40B837CF40F84ED9FFF00D7A4143DBD5");
}

_id_12EA4() {
  scripts\engine\utility::flag_wait("_encstr_8ED9159B93B373974BBCB320771A18E748CB17B84420CB");
  level scripts\cp\cp_hacking::hacking_init();
  level thread scripts\cp\cp_hacking::hacking_objective_time();
  level thread _id_12E8D();
  scripts\cp\utility::objective_update("_encstr_A5F020F25D98E29BB071B702C720C9373A2F9DD39B768D292A976B783823EC119060");
}

_id_12E97() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!scripts\engine\utility::flag("_encstr_8ED9159B93B373974BBCB320771A18E748CB17B84420CB")) {
    return;
  }
  if(istrue(level._id_13392)) {
    return;
  }
  level._id_13392 = 1;

  while(level.hacking_paused) {
    foreach(var_1 in level.players)
    var_1 sethudtutorialmessage(&"_encstr_8D793289D3CF052760A95DC4F5A9CF0D723F01A9DFBE7D675E83D54D9D118BD5ACBF31A9670C347730792EFF2358793CC10B0161");

    wait 5;

    foreach(var_1 in level.players)
    var_1 clearhudtutorialmessage();

    wait 15;

    if(!level.hacking_paused) {
      scripts\cp\cp_objectives::reset_objective_timers();
      thread scripts\cp\utility::objective_update("_encstr_A5F020F25D98E29BB071B702C720C9373A2F9DD39B768D292A976B783823EC119060");
      level._id_13392 = 0;
      return;
    }
  }

  scripts\cp\cp_objectives::reset_objective_timers();
  thread scripts\cp\utility::objective_update("_encstr_A5F020F25D98E29BB071B702C720C9373A2F9DD39B768D292A976B783823EC119060");
  level._id_13392 = 0;
}

_id_12E87(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 forceusehinton(&"_encstr_AA4D2643D716EB236D11A1A9A1776DBBEC35CB2CC39F57FA47417830191FD67B048543A460C78F73");
  var_0 playerlinkTo(self);
  var_0 playerlinkedoffsetenable();

  while(!istrue(var_0._id_140AE))
    wait 0.05;

  for(;;) {
    if(!istrue(var_0._id_140AE) || istrue(var_0.inlaststand)) {
      var_0 forceusehintoff();
      var_0 unlink();
      var_0 notify("_encstr_83DA0F3FAC0D50604F82F01B9B7323F8A7");
      thread kill_rate_too_slow();
      var_1._id_12746 = undefined;
      var_1.buy_point_loop stoploopsound();
      var_1 notify("_encstr_95FC0C9B8E7B1CFADCDE57E619CD");
      return;
    }

    if(var_0 scripts\engine\utility::is_player_gamepad_enabled() && var_0 fragButtonPressed() || !var_0 scripts\engine\utility::is_player_gamepad_enabled() && var_0 meleeButtonPressed()) {
      var_1.buy_point_loop rotateYaw(-1.25, 0.05);

      if(!isDefined(var_1._id_12746))
        var_1 thread _id_12E99();
    } else if(var_0 secondaryoffhandbuttonPressed()) {
      var_1.buy_point_loop rotateYaw(1.25, 0.05);

      if(!isDefined(var_1._id_12746))
        var_1 thread _id_12E99();
    } else if(isDefined(var_1._id_12746)) {
      var_1 notify("_encstr_95FC0C9B8E7B1CFADCDE57E619CD");
      var_1.buy_point_loop stopsounds();
      waitframe();
      var_1.buy_point_loop stoploopsound();
      var_1.buy_point_loop playSound("_encstr_97F01D28822D07D103977667947F78D9545B2BC1DAC5CF2B57D568668CAF23");
      var_1._id_12746 = undefined;
    }

    wait 0.05;

    if(!isDefined(var_3)) {
      continue;
    }
    var_1._id_13393 = _id_12E8C(var_1);
    setomnvar(var_3, var_1._id_13393);
  }
}

_id_12E99() {
  self endon("_encstr_95FC0C9B8E7B1CFADCDE57E619CD");
  self._id_12746 = 1;
  self.buy_point_loop stopsounds();
  waitframe();
  self.buy_point_loop playSound("_encstr_B6961ECDC6E6F53683BEB916A395B1C6D247567DD2B9F5AEDC59BEE68EB093A3");
  wait 0.5;
  self.buy_point_loop playLoopSound("_encstr_91201B428816D60F3B59BB11BB7D6D08C3591DC011DD81B32F2377304B");
}

_id_12E8E(var_0) {
  var_0 endon("_encstr_83DA0F3FAC0D50604F82F01B9B7323F8A7");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  thread kill_rate_too_slow();
}

_id_12E98() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC");

  if(level.hack_duration < 10) {
    return;
  }
  var_0 = [level.rooftop1_sat, level.rooftop2_sat, level.rooftop3_sat];
  var_1 = [125, 285, 75, 185, 300];
  var_2 = 0;
  var_3 = level.hack_duration;
  var_4 = 0;
  var_5 = randomintrange(int(level.hack_duration * 0.4), int(level.hack_duration * 0.7));

  for(;;) {
    while(istrue(level.hacking_paused))
      wait 0.05;

    wait 1;
    var_2 = var_2 + 1;

    if(var_2 == var_5) {
      var_6 = scripts\engine\utility::random(var_0);
      var_6._id_13394 = scripts\engine\utility::random(var_1);
      var_6._id_13393 = _id_12E8C(var_6);
      setomnvar(var_6._id_13395, var_6._id_13393);
      var_4++;

      if(var_4 == 1)
        return;
    }
  }
}

_id_12E8D() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC");

  for(;;) {
    if(istrue(level.hacking_paused)) {
      thread scripts\cp\utility::objective_update("_encstr_9612209B50085BDBB03187922BB8E777A74973D29BD7ABD7387BA49BBF30AA9BD8C3", 60, 20, 10);
      thread path_data_ordered(60);

      while(istrue(level.hacking_paused))
        wait 0.05;

      scripts\cp\cp_objectives::reset_objective_timers();
      thread scripts\cp\utility::objective_update("_encstr_A5F020F25D98E29BB071B702C720C9373A2F9DD39B768D292A976B783823EC119060");
    }

    wait 0.05;
  }
}

path_data_ordered(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_836F10A06FD8F82B1807DF43A5BF35B0BF32");
  wait 60;
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_ACD4326B0FCE33CB85E94971894F35D3841DF3F42BB77F821F4180C9795B7DAB9E747951D17DA359C1D10810513B2407774B8FDE", "_encstr_9A8507BA4040188D08", 5);
  wait 3;
  logevent_servermatchstart(17);
  level thread[[level.endgame]]("_encstr_AD830516C68DE5", level.end_game_string_index["_encstr_BA19049B7723"]);
}

playtutsound() {
  for(var_0 = 5; var_0 > 0; var_0--)
    wait 1;

  level thread plundercountdownplayers();
  var_1 = scripts\engine\utility::getStruct("_encstr_8D05199CDBBD33D1DB387D9CC29623BE1CC685972BE4FA1A2B1BD2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1.origin + (-2000, 0, 0);
  var_3 = var_1.angles[1];
  level thread playvointernal(var_2, var_3);
  wait(randomintrange(3, 6));
  var_2 = var_1.origin + (2000, 0, 0);
  level thread playvointernal(var_2, var_3);
}

plundercountdownplayers() {
  level waittill("_encstr_B64414CF67A3E9507D8B478607B767FD693558320FDF");
  wait 5;
  var_0 = getEnt("_encstr_87540CB3C2DCEB474E2D9D9D5627", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread plunder_value_picked_up(var_0, "_encstr_8D2C186818393563670FBB5F6F331EDF0A49D73355F8F9BD78F7");
  var_1 = scripts\engine\utility::getStructArray("_encstr_ABAF09DD07FAE607B7A39B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    var_3.plunder_playercanuserepository = spawnfx(level._effect["_encstr_92A9097773A497E16779CA"], var_3.origin);
    waitframe();
    triggerfx(var_3.plunder_playercanuserepository);
    waitframe();
  }

  var_5 = (15390, 18406, 1200);
  var_6 = 3250;
  var_7 = 5;
  var_8 = [];
  var_9 = var_5 - (0, 0, 800);
  level thread _id_13EB3(var_9, var_6, 800, 60);
  var_10 = 0;
  var_11 = (var_6, 0, 0);

  for(var_12 = 0; var_12 < var_7 + 1; var_12++) {
    var_13 = var_5 + rotatevector(var_11, (0, var_10, 0));
    var_13 = getgroundposition(var_13, 8, 12000, 12000);
    var_14 = spawnfx(level._effect["_encstr_92A9097773A497E16779CA"], var_13);
    waitframe();
    triggerfx(var_14);
    waitframe();
    var_8[var_12] = var_14;
    var_10 = var_10 + 360 / var_7;
  }
}

_id_13EB3(var_0, var_1, var_2, var_3) {
  var_4 = var_0 - (0, 0, 1000);
  var_5 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_4, 0, 7000, 1000);

  if(istrue(1)) {
    var_5.is_cp_raid = 25;
    level thread plunder_value_picked_up(var_5, "_encstr_8D2C186818393563670FBB5F6F331EDF0A49D73355F8F9BD78F7");
  }

  var_6 = 0.1;
  var_7 = 5;
  var_8 = var_7;
  var_9 = var_2 / (var_3 / var_6);
  var_10 = spawnfx(level._effect["_encstr_92A9097773A497E16779CA"], var_0);
  waitframe();
  triggerfx(var_10);
  waitframe();

  while(var_3 > 0) {
    var_5.origin = var_5.origin + (0, 0, var_9);
    var_0 = var_0 + (0, 0, var_9);
    var_3 = var_3 - var_6;
    var_8 = var_8 - var_6;

    if(var_8 <= 0) {
      var_10 delete();
      waitframe();
      var_10 = spawnfx(level._effect["_encstr_92A9097773A497E16779CA"], var_0);
      waitframe();
      triggerfx(var_10);
      var_8 = var_7;
    }

    wait(var_6);
  }
}

plunder_value_picked_up(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    if(isDefined(var_2.plunder_seventyfivepercent_music)) {
      continue;
    }
    var_2.plunder_seventyfivepercent_music = 1;

    if(!scripts\engine\utility::flag("_encstr_BD8F16C3E623029B40B837CF40F84ED9FFF00D7A4143DBD5"))
      var_2.shouldskiplaststand = 1;

    var_2 thread plunder_value_dropped(var_0, var_1);
  }
}

plunder_value_dropped(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  var_2 = 0.2;
  var_3 = 50;
  self visionsetnakedforplayer(var_1, 3);

  if(!istrue(self.gasmaskequipped) && var_1 != "_encstr_B40101") {
    self notify("_encstr_933D0F2B10A7BFD3F1F837298698AFC2C7");
    wait 0.6;
  }

  for(;;) {
    if(isDefined(var_0.is_cp_raid))
      var_3 = var_0.is_cp_raid;

    if(self istouching(var_0)) {
      if(!istrue(self.gasmaskequipped)) {
        self dodamage(int(var_2 * var_3), self.origin, self, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3");
        plundercountdownmessagedata();
        scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_A79B156C86EB6739A25FB0B023CD7641D22E5CEB91E2C1", "_encstr_9B1804C793EB", 0.2, 0);
      }

      wait(var_2);
      continue;
    } else
      break;
  }

  self.plunder_seventyfivepercent_music = undefined;
  wait 0.5;

  if(isDefined(self.plunder_seventyfivepercent_music)) {
    return;
  }
  if(istrue(self.gasmaskequipped) && var_1 != "_encstr_B40101")
    self notify("_encstr_933D0F2B10A7BFD3F1F837298698AFC2C7");

  self visionsetnakedforplayer("_encstr_B40101", 1);

  if(!scripts\engine\utility::flag("_encstr_BD8F16C3E623029B40B837CF40F84ED9FFF00D7A4143DBD5"))
    self.shouldskiplaststand = undefined;
}

plundercountdownmessagedata() {
  var_0 = self;

  if(!isalive(var_0)) {
    return;
  }
  if(isDefined(var_0.did_ads_hint) && gettime() < var_0.did_ads_hint) {
    return;
  }
  var_0.did_ads_hint = gettime() + randomintrange(5000, 7000);

  if(!isai(var_0))
    var_0 playsoundtoplayer("_encstr_AC1F11299EBB31F7125F13233B09B66855F730", var_0, var_0);

  var_1 = "_encstr_95601258368D2D9537EBD60B36B2BE36DEBACE86";
  var_2 = var_0.defaultoperatorteam;
  var_3 = var_0.operatorcustomization.gender;

  if(var_2 == "_encstr_8E8405EA382B2A") {
    if(isDefined(var_3) && var_3 == "_encstr_B82907C2887BC62B39")
      var_1 = "_encstr_8A8212C848BAAF6F561DB0DB718B408E65EF17CB";
    else
      var_1 = "_encstr_B2A11071DBFFEEA9152999F36FFE60B59F72";
  } else if(isDefined(var_3) && var_3 == "_encstr_B82907C2887BC62B39")
    var_1 = "_encstr_92E414E9DDA4807DE3A72D2347EA31387FF6D0E38718";
  else
    var_1 = "_encstr_95601258368D2D9537EBD60B36B2BE36DEBACE86";

  var_4 = randomint(game["_encstr_B85109BAD04FB3DD30FB7D"][var_1].size);
  var_5 = game["_encstr_B85109BAD04FB3DD30FB7D"][var_1][var_4];
  var_0 playsoundonmovingent(var_5);
}

sat_computer_init(var_0, var_1) {
  var_0.computer makeusable();
  var_0.computer setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_0.computer sethintdisplayrange(256);
  var_0.computer sethintdisplayfov(90);
  var_0.computer setuserange(72);
  var_0.computer setusefov(90);
  var_0.computer sethinttag("_encstr_BAA7174128938F8DCD0BF1DB8801095BE90ECDC7B298C7D5D1");
  var_0.computer sethintonobstruction("_encstr_BECC055CF3811A");
  var_0.computer setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_0.computer setusepriority(-10);
  var_0.computer.has_antennae = 1;
  var_0.computer.has_dongle = 0;

  if(getdvarint("_encstr_87C80E070FFE31B3B03B79BF3180FD0A") > 0)
    var_0.computer.has_dongle = 1;

  var_0.computer._id_11E3B = 1;
  var_0.computer thread _id_12E89(var_1, var_0);
}

_id_12E89(var_0, var_1) {
  var_1._id_13395 = "_encstr_A96513EAB4FA37B49D3716367DB9A3C9B2CDB3E843" + var_0;

  if(istrue(self.has_antennae)) {
    if(istrue(self._id_11E3B))
      _id_12EA0(var_1);
    else
      var_1.computer._id_12A45 setModel(var_1.computer._id_12A45._id_1281E);

    if(!istrue(self.has_dongle))
      _id_12E9A(var_1, var_0);
    else {
      self setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_B1E20A7BCDAFDCF64B32B1CA");
      scripts\engine\utility::flag_set(self.flagname);
      level.sats_connected++;

      if(!istrue(var_1.activated) && (!istrue(var_1.radio.connected) || !istrue(var_1.buy_point_loop.connected) || !istrue(var_1.radar.connected)))
        var_1.computer thread _id_12E9B();
      else
        var_1.computer setHintString(&"_encstr_813F22DF088171E473B1B7DFC85FB0196CB56779893BB12ECE696DA7E1A77F89B3C1F5C7");

      while(!istrue(var_1.activated))
        wait 1;

      scripts\cp\utility::objective_update("_encstr_A939125BCFC5500BEA10775BAF1FA8CE7B959D34", undefined, undefined, undefined, undefined, level.sats_connected);
      objective_setownerteam(var_1.objective_id, "_encstr_9A8507BA4040188D08");
    }
  }

  var_1.computer setHintString(&"_encstr_813F22DF088171E473B1B7DFC85FB0196CB56779893BB12ECE696DA7E1A77F89B3C1F5C7");
  wait 6;
  self makeusable();
  var_1._id_13393 = _id_12E8C(var_1);
  setomnvar("_encstr_A96513EAB4FA37B49D3716367DB9A3C9B2CDB3E843" + var_0, var_1._id_13393);
  var_1.computer setHintString(&"_encstr_813F22DF088171E473B1B7DFC85FB0196CB56779893BB12ECE696DA7E1A77F89B3C1F5C7");
  var_1.computer thread _id_12E9D();
  sat_wait_for_all_connected();
  var_1.computer setHintString(&"_encstr_A60C2285D37FB987A166C34BC8C0D7023A2861B321AB7957822029FA410FDB5904D3C194");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self makeunusable();
    thread _id_12E87(var_2, var_1, undefined, "_encstr_A96513EAB4FA37B49D3716367DB9A3C9B2CDB3E843" + var_0);
    thread _id_12E8E(var_2);
    scripts\cp\cp_computerscreen::hit_by_emp_monitor(var_2);
  }
}

_id_12E8B(var_0, var_1) {
  var_2 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    if(var_4.model == var_1)
      return var_4;
  }
}

_id_12EA0(var_0) {
  update_computer_hint(self, &"_encstr_BAA3256337F60BC38DF1418981570DDB8C15EBCC23BF779A67B158E17153329F07E0605F4465E3", "_encstr_B16D0DA211E81D2258D7CBE783707B");
  var_0.power_switch.alarm_box thread _id_12EA1(var_0.computer);
  var_0.power_switch.alarm_box scripts\engine\utility::ent_flag_wait("_encstr_85390A0F377AD5E89029E8C0");
  var_0.power_switch.alarm_box makeunusable();
  var_0.powered_on = 1;
  var_0.computer._id_12A45 setModel(var_0.computer._id_12A45._id_1281E);
}

_id_12EA1(var_0) {
  self endon("_encstr_85390A0F377AD5E89029E8C0");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    var_0 makeunusable();
    var_0 thread kill_rate_too_slow();
    var_1 scripts\cp\utility::setlowermessage("_encstr_99C808DAB46EB9B4CDEC", &"_encstr_BAA3256337F60BC38DF1418981570DDB8C15EBCC23BF779A67B158E17153329F07E0605F4465E3", 5);
    var_1 playlocalsound("_encstr_95C80F7737B949282E37D503E07B1D60CB");
  }
}

_id_12E9B() {
  self endon("_encstr_AD3A0EFBE1F5AF8EC00981863BA0578B");
  update_computer_hint(self, &"_encstr_8AD026F642A1D9A7063F9989137FFC8D58BF7EE5ECC913EF5F1749896FB4F45D105144E774C06B35", "_encstr_B16D0DA211E81D2258D7CBE783707B");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
    self makeunusable();
    thread kill_rate_too_slow();
    var_0 scripts\cp\utility::setlowermessage("_encstr_99C808DAB46EB9B4CDEC", &"_encstr_8AD026F642A1D9A7063F9989137FFC8D58BF7EE5ECC913EF5F1749896FB4F45D105144E774C06B35", 5);
    var_0 playlocalsound("_encstr_95C80F7737B949282E37D503E07B1D60CB");
  }
}

_id_12E9D() {
  level endon("_encstr_8C750FE211984BC19EF79BA3DBB6BB95C0");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
    self makeunusable();
    thread kill_rate_too_slow();
    var_0 scripts\cp\utility::setlowermessage("_encstr_99C808DAB46EB9B4CDEC", &"_encstr_813F22DF088171E473B1B7DFC85FB0196CB56779893BB12ECE696DA7E1A77F89B3C1F5C7", 5);
    var_0 playlocalsound("_encstr_95C80F7737B949282E37D503E07B1D60CB");
  }
}

_id_12E9A(var_0, var_1) {
  self makeunusable();
  var_0.computer._id_12A45 setHintString(&"_encstr_A66F25C67291E9B7162FE9F9036FCC9DA8AF4EF59CD923FFAF5F19A16F41245F4187D070E7D07B");
  var_0.computer._id_12A45 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_0.computer._id_12A45 sethintdisplayrange(96);
  var_0.computer._id_12A45 sethintdisplayfov(65);
  var_0.computer._id_12A45 setuserange(96);
  var_0.computer._id_12A45 setusefov(65);
  var_0.computer._id_12A45 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0.computer._id_12A45 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_0.computer._id_12A45 makeusable();
  var_0.computer._id_12A45 setusepriority(-10);

  for(;;) {
    var_0.computer._id_12A45 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    var_0.computer._id_12A45 makeunusable();

    if(!isDefined(var_2.armorweapon) && !istrue(getdvarint("_encstr_8FAD10D3D072B99B19A341130F34CDEFED80") > 0)) {
      var_2 scripts\cp\utility::setlowermessage("_encstr_99C808DAB46EB9B4CDEC", &"_encstr_AA521EC0A9818C54F1DFD1A90BF7D03DF9BF8EE19F918D6E089DE187A749DB6C", 5);
      var_2 playlocalsound("_encstr_95C80F7737B949282E37D503E07B1D60CB");
      wait 1;
      var_0.computer._id_12A45 makeusable();
      continue;
    } else {
      if(!istrue(getdvarint("_encstr_8FAD10D3D072B99B19A341130F34CDEFED80") > 0) && var_2.armorweapon != var_0.computer._id_12A45.onsoccerballreset) {
        var_2 scripts\cp\utility::setlowermessage("_encstr_99C808DAB46EB9B4CDEC", &"_encstr_8DD02346B897655F6509A1B1F0C9B77D6B15FE45C9CB0D1F05916969C897DFF5A7F674D15D", 5);
        var_2 playlocalsound("_encstr_95C80F7737B949282E37D503E07B1D60CB");
        wait 1;
        var_0.computer._id_12A45 makeusable();
        continue;
      }

      if(istrue(getdvarint("_encstr_8FAD10D3D072B99B19A341130F34CDEFED80") > 0))
        var_2.armorweapon = var_0.computer._id_12A45.onsoccerballreset;

      var_2 scripts\cp\utility::setlowermessage("_encstr_99C808DAB46EB9B4CDEC", &"_encstr_966825B5CABFC14C088F51AF33E1B83972173DEF24DEB10636D76FAD6B68F6D1CFBF2424DF7C79", 5);
      var_2 notify("_encstr_B1EC0C99824EE9A8F329DF7BC34F");
      var_2 playlocalsound("_encstr_A91D1407B069A0B707AB0B13C243D0E83B3B8FF35BCA");
      scripts\engine\utility::flag_set(self.flagname);
      level.sats_connected++;
      var_2.armorweapon.origin = var_0.computer._id_12A45.get_destinations_in_current_circle;
      var_2.armorweapon.angles = var_0.computer._id_12A45.get_destination_in_current_circle;
      var_2.armorweapon show();
      var_2.armorweapon makeunusable();
      var_3 = var_2.armorweapon.get_track_location_index;
      var_2.armorweapon = undefined;
      wait 1;
      self setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_B1E20A7BCDAFDCF64B32B1CA");
      self makeusable();
      var_0.setupzombiepowers = 1;

      if(!istrue(getdvarint("_encstr_8FAD10D3D072B99B19A341130F34CDEFED80") > 0))
        scripts\cp\utility::_id_12BC6(var_2, var_3.slot);

      if(!istrue(var_0.activated) && (!istrue(var_0.radio.connected) || !istrue(var_0.buy_point_loop.connected) || !istrue(var_0.radar.connected)))
        var_0.computer thread _id_12E9B();
      else
        var_0.computer setHintString(&"_encstr_813F22DF088171E473B1B7DFC85FB0196CB56779893BB12ECE696DA7E1A77F89B3C1F5C7");

      while(!istrue(var_0.activated))
        wait 1;

      var_0.computer notify("_encstr_AD3A0EFBE1F5AF8EC00981863BA0578B");
      scripts\cp\utility::objective_update("_encstr_A939125BCFC5500BEA10775BAF1FA8CE7B959D34", undefined, undefined, undefined, undefined, level.sats_connected);
      objective_setownerteam(var_0.objective_id, "_encstr_9A8507BA4040188D08");
      return;
    }
  }
}

_id_12E96(var_0, var_1) {
  var_2 = _id_12E88();

  switch (var_2) {
    case "_encstr_BE5B0B663F55B3039DC162C345":
      var_0._id_11E3A = 1;
      var_0._id_11E39 = 0;
      var_0._id_11E3C = 0;
      break;
    case "_encstr_BD1106229198D993":
      var_0._id_11E3A = 0;
      var_0._id_11E39 = 0;
      var_0._id_11E3C = 1;
      break;
    case "_encstr_85D008BF48B325A295FF":
      var_0._id_11E3A = 0;
      var_0._id_11E39 = 1;
      var_0._id_11E3C = 0;
      break;
    case "_encstr_8E75065022EE9391":
      var_0._id_11E3A = 0;
      var_0._id_11E39 = 0;
      var_0._id_11E3C = 0;
  }

  if(istrue(var_0._id_11E39))
    thread _id_12E9C(var_0);
  else if(!istrue(var_0._id_11E39)) {
    var_0.buy_point_loop linkTo(var_0, "_encstr_8D5A10A6EB58378EB2E69B0BAF0E2DECDBD1", (0, 0, 0), (0, 0, 0));
    var_0.buy_point_loop show();
    var_0.buy_point_loop.connected = 1;
  }

  if(istrue(var_0._id_11E3A))
    thread _id_12E9E(var_0);
  else {
    var_0.radio.origin = var_0 gettagorigin("_encstr_A22D0ED4FACC270BAD2BFA0E4B3BB78E");
    var_0.radio.angles = var_0 gettagangles("_encstr_A22D0ED4FACC270BAD2BFA0E4B3BB78E");
    var_0.radio linkTo(var_0);
    var_0.radio scriptmodelplayanim("_encstr_97D01E92201F421F1B3DE4ECC3E3F7818BB82B0A983BFB07D308F61769C9BF17");
    var_0.radio show();
    var_0.radio.connected = 1;
  }

  if(istrue(var_0._id_11E3C))
    thread _id_12EA2(var_0);
  else if(!istrue(var_0._id_11E39)) {
    var_0.radar linkTo(var_0, "_encstr_8E260F9AD7E40BC8B027F593BDD1AF0C4C", (0, 0, 0), (0, 0, 0));
    var_0.radar show();
    var_0.radar.connected = 1;
  }

  while(!istrue(var_0.radio.connected) || !istrue(var_0.buy_point_loop.connected) || !istrue(var_0.radar.connected) || !istrue(var_0.powered_on) || !istrue(var_0.setupzombiepowers))
    wait 1;

  wait 1;
  var_0.activated = 1;
  _id_12E86(var_0);
  _id_12E8F(var_0);
}

_id_12E92(var_0, var_1, var_2, var_3) {
  self setHintString(var_0);
  self setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  self sethintdisplayrange(96);
  self sethintdisplayfov(65);
  self setuserange(96);
  self setusefov(65);
  self sethintonobstruction("_encstr_BD1805CB69C063");
  self setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  self makeusable();
  self setusepriority(-10);

  if(isDefined(var_3))
    self sethinttag(var_3);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_4);

    if(!var_4 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(isDefined(var_4._id_12E91)) {
      var_4 scripts\cp\utility::setlowermessage("_encstr_82A9084471E83D4278A1", &"_encstr_AF06255D22671994A037F9F75B99D091DACFC5379CB6D9AEEE13CBCD6F6106C1BCD12F6C37CB81", 5);
      var_4 playlocalsound("_encstr_95C80F7737B949282E37D503E07B1D60CB");
      continue;
    }

    var_4 playlocalsound("_encstr_8ED215BE0BE6C7C8558FBB3AFECFDB4896A672ADD7830B");
    var_4._id_12E91 = self;
    var_4 thread _id_12C38(var_0, var_1, var_2, var_3);
    self.get_track_location_index = scripts\cp\utility::_id_13070(var_4, self.get_total_successful_vehicle_spawns_from_module);
    break;
  }

  self makeunusable();
  self hide();

  if(isDefined(var_2)) {
    foreach(var_6 in var_2)
    var_6 hide();
  }
}

_id_12E9C(var_0, var_1) {
  var_0.radar linkTo(var_0.buy_point_loop, "_encstr_8E260F9AD7E40BC8B027F593BDD1AF0C4C", (0, 0, 0), (0, 0, 0));
  var_0.radar.connected = 1;
  var_0.buy_point_loop thread _id_12E92(&"_encstr_A1D72386A0EB88EA27AF8A7539F5D348A42A342A52CA2A4D9782946896AAA0F549A0110A29", var_0, [var_0.radar]);
  var_2 = anglestoleft(var_0.angles);
  var_2 = var_0.origin + var_2 * 35 + (0, 0, 25);
  var_3 = _id_12E8A(var_2);
  var_3 setHintString(&"_encstr_84E62209534F85A7E029DD4475294F8DF2BF81295F3EFDE7DE02D9471EE0273721532991");
  _id_12E9F(var_3, var_0.buy_point_loop);
  var_3 delete();
  var_0.buy_point_loop linkTo(var_0, "_encstr_8D5A10A6EB58378EB2E69B0BAF0E2DECDBD1", (0, 0, 0), (0, 0, 0));
  var_0.buy_point_loop show();
  var_0.buy_point_loop.connected = 1;
  var_0.radar linkTo(var_0, "_encstr_8E260F9AD7E40BC8B027F593BDD1AF0C4C", (0, 0, 0), (0, 0, 0));
  var_0.radar show();
}

_id_12E9E(var_0) {
  var_0.radio thread _id_12E92(&"_encstr_A55128D5B9C795093DF70937DE51014E4B542DBFB04B5D711D903B17330BC18807180427A9576141AF8A", var_0, undefined, "_encstr_86AD10A9F5B17BCD3AE4BDD863AC39EB18C4");
  var_1 = anglestoleft(var_0.angles);
  var_1 = var_0.origin + var_1 * 14 + (0, 0, 25);
  var_2 = _id_12E8A(var_1);
  var_2 setHintString(&"_encstr_B2B7277989B81F931E8E09E3AB2185565A07E049E88168415A93DDC35857C9606C2EFC973418E93781");
  _id_12E9F(var_2, var_0.radio);
  var_0.radio.origin = var_0 gettagorigin("_encstr_A22D0ED4FACC270BAD2BFA0E4B3BB78E");
  var_0.radio.angles = var_0 gettagangles("_encstr_A22D0ED4FACC270BAD2BFA0E4B3BB78E");
  var_0.radio linkTo(var_0);
  var_0.radio scriptmodelplayanim("_encstr_97D01E92201F421F1B3DE4ECC3E3F7818BB82B0A983BFB07D308F61769C9BF17");
  var_0.radio show();
  var_0.radio.connected = 1;
  var_2 delete();
}

_id_12EA2(var_0) {
  var_0.buy_point_loop linkTo(var_0, "_encstr_8D5A10A6EB58378EB2E69B0BAF0E2DECDBD1", (0, 0, 0), (0, 0, 0));
  var_0.buy_point_loop.connected = 1;
  var_0.radar thread _id_12E92(&"_encstr_8BE0217FCBCEC5EF88F8293746594D8D0C9F5399139FD5D160132105B77921F738A99B", var_0);
  var_1 = anglestoleft(var_0.angles);
  var_1 = var_0.origin + var_1 * 45 + (0, 0, 15);
  var_2 = _id_12E8A(var_1);
  var_2 setHintString(&"_encstr_AD82223405EB11BA72EB45D59CAF9E0925A21A8A4A652AD4799A294D354A271DBE0A9CA2");
  _id_12E9F(var_2, var_0.radar);
  var_2 delete();
  var_0.radar linkTo(var_0, "_encstr_8E260F9AD7E40BC8B027F593BDD1AF0C4C", (0, 0, 0), (0, 0, 0));
  var_0.radar show();
  var_0.radar.connected = 1;
}

_id_12E9F(var_0, var_1) {
  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(isDefined(var_2._id_12E91) && var_2._id_12E91 == var_1 || istrue(getdvarint("_encstr_8FAD10D3D072B99B19A341130F34CDEFED80") > 0)) {
      var_2 playlocalsound("_encstr_8ED215BE0BE6C7C8558FBB3AFECFDB4896A672ADD7830B");
      var_2 notify("_encstr_A30111491BBA1E98DC69ABE1CBBF6843529FEB");

      if(!istrue(getdvarint("_encstr_8FAD10D3D072B99B19A341130F34CDEFED80") > 0))
        scripts\cp\utility::_id_12BC6(var_2, var_2._id_12E91.get_track_location_index.slot);
      else
        var_1 makeunusable();

      var_2._id_12E91 = undefined;
      break;
    } else {
      var_2 scripts\cp\utility::setlowermessage("_encstr_82A9084471E83D4278A1", &"_encstr_AA521EC0A9818C54F1DFD1A90BF7D03DF9BF8EE19F918D6E089DE187A749DB6C", 5);
      var_2 playlocalsound("_encstr_95C80F7737B949282E37D503E07B1D60CB");
      continue;
    }
  }
}

_id_12E8A(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_1 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_1 sethintdisplayrange(256);
  var_1 sethintdisplayfov(180);
  var_1 setuserange(96);
  var_1 setusefov(180);
  var_1 sethintonobstruction("_encstr_BD1805CB69C063");
  var_1 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_1 makeusable();
  var_1 setusepriority(-10);
  return var_1;
}

_id_12E86(var_0) {
  var_0.power_switch.alarm_box scripts\engine\utility::ent_flag_wait("_encstr_85390A0F377AD5E89029E8C0");
  thread _id_12E93(var_0);
  var_0.radio scriptmodelplayanim("_encstr_966C1E373856B3D2217DCDC55319AA5739A0F3C7C0490CDB4718937DCCC7F234");
  var_0.buy_point_loop scriptmodelplayanim("_encstr_966C1E373856B3D2217DCDC55319AA5739A0F3C7C0490CDB4718937DCCC7F234");
  var_0.radar scriptmodelplayanim("_encstr_966C1E373856B3D2217DCDC55319AA5739A0F3C7C0490CDB4718937DCCC7F234");
  var_0 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_81DE0715BD50BDDB5D");
  wait 6.65;
}

_id_12E93(var_0) {
  var_0 playSound("_encstr_BAF51ECD6C9BD7D838BE6E1647AC8D8D2D47B2AFAE9BCCBD3646EB37E8854E47");
  wait 0.25;
  var_0 playLoopSound("_encstr_88C61B37B173FA1B1CD7E60B47958D1B5AA359D757DC33BD8D91FA8D83");
  wait 4;
  var_0 stoploopsound();
  var_0 playSound("_encstr_85A51DD2BECDE17B13D9E7B798E93C9ABB4DDF411D65AA8F78285FF7F080F8");
  wait 0.5;
  var_0.radar playLoopSound("_encstr_B6A7169BC6E6D7C6C1BEE6583A59638D963A2BEB4B3236AC");
}

_id_12E8F(var_0) {
  var_0.buy_point_loop scriptmodelplayanim("_encstr_8D4E1CB2E3A782989BABD8B12334CD49120BAAC3A3F18B6BF091E3BF9F80");
  var_0.radar linkTo(var_0.buy_point_loop, "_encstr_8E260F9AD7E40BC8B027F593BDD1AF0C4C");
  var_0.buy_point_loop.angles = var_0.angles + (0, 45, -15);
  var_0.buy_point_loop unlink();
}

_id_12E88() {
  if(getdvarint("_encstr_87C80E070FFE31B3B03B79BF3180FD0A") > 0)
    return "_encstr_8E75065022EE9391";

  if(!isDefined(level._id_12E90))
    level._id_12E90 = ["_encstr_BE5B0B663F55B3039DC162C345", "_encstr_BD1106229198D993", "_encstr_85D008BF48B325A295FF"];

  var_0 = scripts\engine\utility::random(level._id_12E90);
  level._id_12E90 = scripts\engine\utility::array_remove(level._id_12E90, var_0);
  return var_0;
}

previous_bullet_weapon(var_0) {
  var_1 = getEntArray("_encstr_81F90A75E710D19B36387B72", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    switch (var_0._id_1281E) {
      case "_encstr_B4A31E285AF8835D379213013B9D181AA023613173D361C42A3B21F1B3901726":
        if(var_3.model == "_encstr_83B5248AB8130E038370AED11ECBE7544BB85242D0F9C9B739ECA1D32596A20A9730CB9A8055")
          return var_3;

        break;
      case "_encstr_84F81C98579CC001F2426B601CEA43C9F9435891932D19E95A6A70FEF7D2":
        if(var_3.model == "_encstr_ADF722B7D93BC28CB378B3B71B4B6F8A83EBBE2EBE5159AF19D8A79718A658971F8687E7")
          return var_3;

        break;
      case "_encstr_8DBE1DDA2DC6D28E1693BCFADA56E5B1169C19BE3959168CB29CD7988DAEAC":
        if(var_3.model == "_encstr_B4811E8750F0BB93F6177B1F771E69FBA85ABE0E0B107FFAC42D6F3F53D06779")
          return var_3;

        break;
    }
  }
}

_id_12FF8() {
  var_0 = undefined;

  switch (self.model) {
    case "_encstr_83B5248AB8130E038370AED11ECBE7544BB85242D0F9C9B739ECA1D32596A20A9730CB9A8055":
      var_0 = "_encstr_932906F74A6F1818";
      break;
    case "_encstr_ADF722B7D93BC28CB378B3B71B4B6F8A83EBBE2EBE5159AF19D8A79718A658971F8687E7":
      var_0 = "_encstr_8419044EB232";
      break;
    case "_encstr_B4811E8750F0BB93F6177B1F771E69FBA85ABE0E0B107FFAC42D6F3F53D06779":
      var_0 = "_encstr_B29B0550F33591";
      break;
  }

  var_1 = scripts\engine\utility::getStructArray("_encstr_86AB0DAD56BC1B2C39C87DD87B6CAF" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_1.size > 0)
    return scripts\engine\utility::random(var_1);

  return undefined;
}

canplaykillstreakdialog(var_0, var_1) {
  self.fnmeleecharge_init = ::bisthread;
  var_2 = undefined;

  switch (var_0.group_name) {
    case "_encstr_84E31D6B6BE0D78A40AB0614B3105953159822B208CE874758830E0C77514A":
    case "_encstr_91761B6E82D8A8F3BFFD2EE338BD6E705F7345381740C79B33082B357E":
      var_2 = "_encstr_868517C989D7392B2DB9CC7B39D8B2F583DBDCD21DD2B79BB9";
      break;
    case "_encstr_8BB51D580297E9278AEF9895C7B3373315C720708F526133329780A55A9935":
    case "_encstr_828A1BBB7AA7F046329FCDD1B70B98D03504A0B155D2A8750A67D5C9F7":
      var_2 = "_encstr_AA9B173923D7932B4BB966F6E46C2BBE83DB379647B47BE69B";
      break;
    case "_encstr_AC871D1B4A3EB9EB275575EF4DEDE1528170F3C31033F3F2637D7DE3AE8F6F":
    case "_encstr_AC961B3A0691383621F5B041F29240DA414B7D721F5ED85FED19E5934F":
      var_2 = "_encstr_B16E17E21B810A22DBB5FBE7B5F66A6FA0F8DAAC6B98AF4A2E";
      break;
  }

  thread lootcontentsadjustkillchain(var_2);
}

canprogressingunrank(var_0) {
  self.fnmeleecharge_init = ::bisthread;
  var_1 = scripts\engine\utility::random(["_encstr_BE9713FB9F031D2042E133A89231C0DB8A337F1772", "_encstr_929713D6B7393A2CC9F51CDB37A5475ABD37CDF513"]);
  thread lootcontentsadjustkillchain(var_1);
}

lootcontentsadjustkillchain(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\mp\vehicles\little_bird_mg_mp::bloadinghvt(self.origin);
  scripts\mp\vehicles\little_bird_mg_mp::blockade_gate_explode_sequence("_encstr_87070365F7", var_1);

  if(isDefined(var_0)) {
    var_2 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"));
    self setgoalpos(var_2.origin);
  }
}

bisthread(var_0) {
  self.meleechargedistvsplayer = 2000;
  self.melee.bignoretimeout = 1;
  self.melee.bignoretargetflee = 1;
}

logevent_servermatchstart(var_0) {
  foreach(var_2 in level.players)
  var_2 setclientomnvar("_encstr_8FCB19BAA5BE3607BEDA969B6E4BDBDCEB66B096D8F5A57332AC0F", var_0);
}

canplaygasmaskgesturebr(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 256;

  if(var_0 == "_encstr_8D1F09027BA68F8523E342")
    var_3 = scripts\mp\vehicles\little_bird_mg_mp::bloadinghvt(var_1);
  else
    var_3 = scripts\mp\vehicles\little_bird_mg_mp::blockachievementstimestamp(var_1);

  var_4 = getentitylessscriptablearrayinradius("_encstr_8E931C26EBE6B4C3BB82D5693779ABF7150A57CB4A6B1347A883FF9B07A9" + var_0, "_encstr_AC110A7F14873B5B3D073009", var_3.origin, var_2);
  var_5 = var_4[0];
  var_5 setscriptablepartstate("_encstr_8D1F09027BA68F8523E342", "_encstr_8698096D1870821A51010B");
}

minigun_should_keep_firing() {
  level._id_12D8C = ::init_ai_spawns;
  var_0 = scripts\engine\utility::getStructArray("_encstr_B8610B0E9BD8A49A6809730F49", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_3 = scripts\cp\crate_drops\cp_crate_drops::dropcarepackage(var_2, undefined, "_encstr_87141136F8F7C34F4DFAA3D0B3690F9B67844D");
}

init_ai_spawns(var_0) {
  var_0 _id_1234D();
}

_id_1234D() {
  self playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
  scripts\cp_mp\gasmask::init();
  thread headequiptoggleloop();
  self.plundermusicsecond = scripts\cp\utility::_id_13070(self, "_encstr_88EA08EC2CCDDAB037B5");
}

headequiptoggleloop() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    self waittill("_encstr_933D0F2B10A7BFD3F1F837298698AFC2C7");

    if(!istrue(self.gasmaskequipped)) {
      thread scripts\cp_mp\gasmask::equipgasmask();
      continue;
    }

    thread scripts\cp_mp\gasmask::removegasmask();
  }
}

fixupsupersandtacticalsforgunfightmaps() {
  var_0 = getEnt("_encstr_8A16120D51C9BB06B1286BB170ED3B8F434F9394", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 setHintString(&"_encstr_8259280D827D11BA937DA2AB72EBF412522A1A45A4AC156AF22A895195A015A7497D240A9AA235A2C9A8");
  var_0 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_0 sethintdisplayrange(128);
  var_0 sethintdisplayfov(65);
  var_0 setuserange(96);
  var_0 setusefov(65);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_0 makeusable();
  return var_0;
}

flag_bot_attacker_limit_for_team() {
  self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
  self makeunusable();
}

_id_12B4B(var_0, var_1, var_2) {
  level endon("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC");

  foreach(var_4 in var_0) {
    if(isDefined(level.ambientgroups[var_4])) {
      continue;
    }
    var_0 = scripts\engine\utility::array_remove(var_0, var_4);
  }

  var_6 = 30;
  var_7 = 40;
  var_8 = 10;
  var_9 = 15;

  for(;;) {
    var_4 = _id_135BE(var_0);
    var_10 = [];

    if(issubstr(var_4, "_encstr_B6CC0586B28D96")) {
      var_10 = scripts\engine\utility::array_remove(var_0, var_4);

      foreach(var_12 in var_0) {
        if(issubstr(var_12, "_encstr_B6CC0586B28D96"))
          var_10 = scripts\engine\utility::array_remove(var_10, var_12);
      }
    } else
      var_10 = scripts\engine\utility::array_remove(var_0, var_4);

    wait(randomintrange(var_8, var_9));
    var_4 = _id_135BE(var_10);
    _id_14328();
    _id_14327(var_1);
    wait(randomintrange(var_6, var_7));
  }
}

_id_135BE(var_0) {
  var_1 = _id_13E01(var_0);

  if(!isDefined(var_1)) {
    foreach(var_1 in var_0) {
      if(issubstr(var_1, "_encstr_B6CC0586B28D96"))
        var_0 = scripts\engine\utility::array_remove(var_0, var_1);
    }

    var_1 = scripts\engine\utility::random(var_0);
  }

  if(issubstr(var_1, "_encstr_8F0D0583C29C0B"))
    scripts\cp\cp_aiparachute::request_paratroopers(var_1, undefined, (-13512, 66432, 5904));
  else {
    if(issubstr(var_1, "_encstr_8439088EF829B89AF113"))
      level.skipburndown[var_1] = gettime() + 180000;
    else if(issubstr(var_1, "_encstr_B6CC0586B28D96"))
      level.skipburndown[var_1] = gettime() + 30000;

    scripts\cp\cp_modular_spawning::run_spawn_module(var_1);
  }

  return var_1;
}

gcd(var_0) {
  if(!isDefined(level.skipequippedstreakcheck))
    level.skipequippedstreakcheck = getEntArray("_encstr_B6E2150D95B9C0F7D9E72E4BFBA609C935AAE425AD58A6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(level._id_124B2))
    level._id_124B2 = [];

  if(!isDefined(level.skipburndown))
    level.skipburndown = [];

  if(!isDefined(level.skipburndown[var_0]))
    level.skipburndown[var_0] = 0;

  if(gettime() < level.skipburndown[var_0])
    return 0;

  var_1 = 1;
  var_2 = getEnt(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_4 in level._id_124B2) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4 istouching(var_2))
      var_1 = 0;
  }

  return var_1;
}

_id_14327(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  for(;;) {
    var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(var_4 istouching(self))
        var_2++;
    }

    if(var_2 > var_0) {
      wait 1;
      continue;
    }

    return;
  }
}

_id_14328() {
  for(;;) {
    var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(var_3 istouching(self))
        var_1++;
    }

    if(var_1 < 1) {
      wait 1;
      continue;
    }

    wait 10;
    return;
  }
}

sixthsense_shouldwarnaboutotherplayer(var_0) {
  var_1 = spawnStruct();
  var_1.angles = var_0.angles;
  var_1.origin = var_0.origin;
  var_2 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_1);
  var_2 thread scripts\cp\cp_vehicles::waiting_for_disable();
  var_2.invulnerable = 1;
  var_2.maxhealth = 5000;
  var_2.health = 5000;
  var_2.vehicle_specific_onentervehicle = ::_id_14209;
  var_2 thread _id_12BD6(30);
  level._id_124B2[level._id_124B2.size] = var_2;
  var_0 scripts\cp\cp_vehicles::delete_nav_obstacle();
  var_0 delete();
}

_id_12BD6(var_0) {
  self notify("_encstr_85DC13A329313713B84BCEDE5BD85D47E6C1DACAB1");
  self endon("_encstr_85DC13A329313713B84BCEDE5BD85D47E6C1DACAB1");
  self endon("_encstr_AD75063D571AE108");
  self.health = self.maxhealth;

  if(var_0 > 0)
    scripts\engine\utility::_id_143B9(var_0, "_encstr_81A31964CB7817B720F1D11AD809FB0CF8A3EFFE1F909E6F5FE94A");

  self.invulnerable = undefined;
  self notify("_encstr_85DC13A329313713B84BCEDE5BD85D47E6C1DACAB1");
}

_id_14209(var_0, var_1, var_2, var_3) {
  var_0 notify("_encstr_85DC13A329313713B84BCEDE5BD85D47E6C1DACAB1");
  var_0.health = var_0.maxhealth;
  var_0.invulnerable = undefined;
}

_id_13E01(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(issubstr(var_3, "_encstr_B6CC0586B28D96")) {
      if(!gcd(var_3)) {
        continue;
      }
      var_1[var_1.size] = var_3;
    }
  }

  if(var_1.size == 0)
    return undefined;

  return scripts\engine\utility::random(var_1);
}

playvointernal(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2.team = "_encstr_9A8507BA4040188D08";
  var_2.angles = (0, 0, 0);
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3 = var_2 plunder_overtime_music(var_0, var_1);

  if(!isDefined(var_3))
    return 0;

  var_3 thread plunder_repositoryenableuserestrictions();
}

plunder_overtime_music(var_0, var_1) {
  var_2 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_3 = 20000;
  var_4 = 5000;
  var_5 = 1500;
  var_6 = 1500;
  var_7 = (0, var_1, 0);

  if(!isDefined(var_2))
    var_5 = var_5 + 1800;
  else {
    var_5 = var_2.origin[2] + 1800;
    var_6 = scripts\cp_mp\killstreaks\airstrike::getexplodedistance(var_5);
  }

  var_8 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var_0, var_7, var_3, var_2, var_5, var_4, var_6);
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_8["_encstr_B18C0B5E9C6FA319E20A487853"]);
  var_9.angles = var_7;
  var_9.flightpath = var_8;
  var_9.speed = var_4;
  var_9.owner = self;
  var_9.team = self.team;
  var_9 setModel("_encstr_99331DB5CFDA43990534F896DEF9080883170D336BF22E40721B866BC7CB70");
  return var_9;
}

plunder_repositoryenableuserestrictions() {
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.flightpath["_encstr_B18C0B5E9C6FA319E20A487853"];
  var_1 = self.flightpath["_encstr_ACB7092280809AF7F8F8DB"];
  var_2 = self.flightpath["_encstr_B602088CA52B1198DD3F"];
  var_3 = var_0 + anglesToForward(self.angles) * 10000;
  var_4 = var_1 - anglesToForward(self.angles) * 10000;
  var_5 = length(var_3 - var_4);
  var_6 = 30;
  self moveTo(var_1, var_2);
  self setscriptablepartstate("_encstr_B6C907C4EDC8BC19B0", "_encstr_AB0703DBB9", 0);
  self scriptmodelplayanim("_encstr_911C145D5321E22B70F8ADB21BCAF2BB36554B1B0B62");
  thread wp_enterpayloadaudio();
  thread wp_exitpayloadaudio(var_1, var_2);
  var_7 = 3;
  scripts\cp_mp\killstreaks\white_phosphorus::wp_handlepayloadtyperelease(::wp_fireairburst, var_0, var_3, var_5, var_6, 4000, var_7, 1);
  scripts\cp_mp\killstreaks\white_phosphorus::wp_handlepayloadtyperelease(::wp_firesmoke, var_0, var_3, var_5, var_6, 4000, 3, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  self stopsounds();
  self scriptmodelplayanimdeltamotion("_encstr_81AF13C8027FF2332648881FB047AAA3B7E9016953");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5.33);
  self delete();
}

wp_enterpayloadaudio() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  waitframe();
  self playsoundonmovingent("_encstr_863F1DD3DF87A86060C1F328744C68E05BCBA76FE79B0542DD29D9A01802B0");
}

wp_exitpayloadaudio(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  playsoundatpos(var_0, "_encstr_BE7F1C2F308ACF4279307BB403299A87EBB0BFDFD95B3D7F1B28C7A87B01");
}

wp_fireairburst(var_0, var_1, var_2) {
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = var_0 - var_1 * 3000;
  var_4 = var_0 - var_1 * 2000;
  var_5 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  playFX(level._effect["_encstr_B4EE0E3F632669F1E0A1DCE29E401853"], var_3, var_1);
  playsoundatpos(var_4, "_encstr_BA4B1FE96F42513FB77EEB22808D57195839977BA74064C3D750B35969E33B0D48");
}

wp_firesmoke(var_0, var_1, var_2, var_3) {
  wait(var_2);
  level notify("_encstr_B64414CF67A3E9507D8B478607B767FD693558320FDF");
}