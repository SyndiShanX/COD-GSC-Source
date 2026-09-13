/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rescue.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 3, 0, 12);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 150);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 200);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 500);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinbytwoenableddvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinbytwomaxroundsdvar(scripts\mp\utility\game::getgametype(), 4);
    scripts\mp\utility\game::registernumrevivesdvar(scripts\mp\utility\game::getgametype(), 0);
    setDvar("scr_player_lastStand", 2);
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.nobuddyspawns = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerconnect = ::onplayerconnect;
  level.onobjectivecomplete = ::onflagcapture;
  level.ondeadevent = ::ondeadevent;
  level.ontimelimit = ::ontimelimit;
  level.endgame = ::_id_F6E1C54F449C2C6F;
  level.onteamscore = ::_id_E462B877CEDEA7F7;
  level._id_A12EC32A24E1A367 = ::_id_A12EC32A24E1A367;
  level.onmaprestart = ::_id_CF8B96B6503D9F31;
  level.gamemodemaydropweapon = ::_id_824AADC5E0A8E202;
  level._id_CA4E08767CBDAE12 = ::_id_C95D2A5F442A6BFE;
  level._id_91F947790DF03886 = getdvarint("dvar_7798BE18E3F3AD91", 0);
  level._id_E181FDCC8E4E5173 = getdvarint("dvar_71C04CB18CAD67CD", 0);
  level._id_F224E09983EF4B2A = getdvarint("dvar_20103D7A5A56AAC8", 20);
  level._id_681EABE436C0029D = getdvarint("dvar_7E0C25F71D807534", 1);
  _id_F21C2225770DCA31();
  level._id_4F4F5BEAC3BCCC69 = 1;
  level.flagcapturetime = 0;
  level._id_500370E4F476FAA9 = 0;
  level._id_319544F76C37154B["axis"] = 0;
  level._id_319544F76C37154B["allies"] = 0;
  level._id_9A8E3EB5BC672807 = 1;
  level._id_37BAAB13A0CF00E3 = getdvarint("dvar_BBBBF0150D760B11", 1);
  level.allowlatecomers = 0;
  game["canScoreOnTie"] = 1;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_rscu_mode_uktl_rnt1";
  else
    game["dialog"]["gametype"] = "iw9_rscu_mode_uktl_name";

  if(!isDefined(game["roundsPlayed"])) {
    _id_20EE2C907DD89357 = "iw9_rscu_mode_uktl_bstd";
    _id_9016B7D396FFBDBB = "iw9_rscu_mode_uktl_bsta";
  } else {
    _id_20EE2C907DD89357 = "iw9_rscu_mode_uktl_bstd";
    _id_9016B7D396FFBDBB = "iw9_rscu_mode_uktl_bsta";
  }

  game["dialog"]["offense_obj"] = _id_20EE2C907DD89357;
  game["dialog"]["defense_obj"] = _id_9016B7D396FFBDBB;
  game["dialog"]["dropped_hostage_defend"] = "iw9_rscu_mode_uktl_rsde";
  game["dialog"]["dropped_hostage_retrieve"] = "iw9_rscu_mode_uktl_rsdh";
  game["dialog"]["hostage_taken_friendly"] = "iw9_rscu_mode_uktl_rseh";
  game["dialog"]["hostage_taken_enemy"] = "iw9_rscu_mode_uktl_rset";
  game["dialog"]["hostage_extraected_friendly"] = "iw9_rscu_mode_uktl_rsex";
  game["dialog"]["hostage_extracted_enemy"] = "iw9_rscu_mode_uktl_rsee";
  game["dialog"]["lead_lost"] = "gamestate_leadlost";
  game["dialog"]["lead_taken"] = "gamestate_leadtaken";
  scripts\mp\outofbounds::registeroobentercallback("rescue", ::_id_B9962C5A08FD9AB7);
  scripts\mp\outofbounds::registeroobexitcallback("rescue", ::_id_D50CCE29BBB9D457);
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("dvar_C44109000ED1922D", getmatchrulesdata("carryData", "manualDropEnabled"));
  setdynamicdvar("dvar_B68209D1C9D3B09F", 0);
  scripts\mp\utility\game::registerhalftimedvar("rescue", 0);
}

_id_F21C2225770DCA31() {
  switch (level._id_E181FDCC8E4E5173) {
    case 0:
      level._id_0C8B917BF9D0B1D1 = 2;
      level._id_385BB8FDAB525E2B = 0;
      level.numextractions = 1;
      level.showenemycarrier = 0;
      break;
    case 1:
      level._id_0C8B917BF9D0B1D1 = 1;
      level._id_385BB8FDAB525E2B = 0;
      level.numextractions = 1;
      level.showenemycarrier = 0;
      break;
    case 2:
      level._id_0C8B917BF9D0B1D1 = 1;
      level._id_385BB8FDAB525E2B = 1;
      level.numextractions = 2;
      level.showenemycarrier = 0;
      break;
    case 3:
      level._id_0C8B917BF9D0B1D1 = 2;
      level._id_385BB8FDAB525E2B = 1;
      level.numextractions = 2;
      level.showenemycarrier = 0;
      break;
    case 4:
      level._id_0C8B917BF9D0B1D1 = 2;
      level._id_385BB8FDAB525E2B = 0;
      level.numextractions = 1;
      level.showenemycarrier = 0;
      break;
    default:
      break;
  }
}

onstartgametype() {
  level._id_974E9F26A695CD24 = 200;
  level._id_D2574C87EE723D10 = 100;

  if(level._id_0C8B917BF9D0B1D1 == 1) {
    scripts\mp\utility\dvars::setoverridewatchdvar("scorelimit", 100);
    level.scorelimit = 100;
    level.scorelimitoverride = 100;
    level.roundscorelimit = 100 * (game["roundsPlayed"] + 1);
    level._id_974E9F26A695CD24 = 100;
    level._id_D2574C87EE723D10 = 50;
    scripts\mp\utility\dvars::setoverridewatchdvar("winlimit", 250);
    level.winlimit = 250;
  }

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  setclientnamemode("manual_change");
  scripts\mp\utility\game::setobjectivetext(game["attackers"], &"OBJECTIVES/RESCUE_DEFENDERS");
  scripts\mp\utility\game::setobjectivetext(game["defenders"], &"OBJECTIVES/RESCUE_ATTACKERS");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES/RESCUE_DEFENDERS");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES/RESCUE_ATTACKERS");
  } else {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES/RESCUE_SCORE_DEFENDERS");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES/RESCUE_SCORE_ATTACKERS");
  }

  scripts\mp\utility\game::setobjectivehinttext(game["attackers"], &"OBJECTIVES/RESCUE_SCORE_DEFENDERS");
  scripts\mp\utility\game::setobjectivehinttext(game["defenders"], &"OBJECTIVES/RESCUE_SCORE_ATTACKERS");
  initanims();
  seticonnames();
  _id_65DDEE84A30ACA2A();
  _id_F8C926CDEB59F116();
  _id_B924BA876AE5B152();
  thread _id_E94CF520D98CE0E1();
  initspawns();
  level._id_319544F76C37154B["axis"] = 0;
  level._id_319544F76C37154B["allies"] = 0;
  level thread _id_189D41172D946149();
  _id_1010C350ABCC5FEC = scripts\engine\utility::ter_op(game["defenders"] == "axis", 1, 0);

  foreach(player in level.players)
  player setclientomnvar("ui_rescue_hostage_active", 0);

  setomnvar("ui_rescue_axis_attacking", _id_1010C350ABCC5FEC);
  scripts\mp\teamrevive::_id_5343ECB486B66BF1("rescue", ::_id_D23F4D7BFE21F9DA);
}

seticonnames() {
  level.iconrecover = "rescue_recover";
  level.iconescort = "rescue_escort";
  level._id_E8891F63E5A412C2 = "rescue_escort_return";
  level.iconextract = "rescue_taking_extract";
  level.icondefendextract = "rescue_defend_extract";
  level.iconcaptureextract = "rescue_capture_extract";
  level.iconlosing = "rescue_defend_extract";
  level.icontaking = "rescue_taking_extract";
  level.iconneutral = "rescue_capture_extract";
  level.iconcapture = "rescue_capture_extract";
  level.icondefending = "rescue_defend_extract";
  level.iconcontested = "rescue_stopping_extract";
  level.icondefend = "rescue_defend_extract";
}

_id_65DDEE84A30ACA2A() {
  scripts\mp\gamelogic::setwaypointiconinfo("rescue_recover", 0, "friendly", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_hostage_captive", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("rescue_escort", 0, "enemy", &"MP_INGAME_ONLY/OBJ_RESCUE_CAPS", "icon_waypoint_hostage", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("rescue_escort_return", 0, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_hostage", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_a", 0, "enemy", &"MP_INGAME_ONLY/OBJ_RESCUE_CAPS", "icon_waypoint_hostage", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_b", 0, "enemy", &"MP_INGAME_ONLY/OBJ_RESCUE_CAPS", "icon_waypoint_hostage", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_c", 0, "enemy", &"MP_INGAME_ONLY/OBJ_RESCUE_CAPS", "icon_waypoint_hostage", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hostage_captive", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hostage_captive", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_c", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hostage_captive", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_kill", 0, "friendly", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("rescue_kill_carrier", 0, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("rescue_taking_extract", 1, "friendly", &"MP_INGAME_ONLY/OBJ_EXTRACT_CAPS", "ui_map_icon_extraction", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("rescue_defend_extract", 1, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "ui_map_icon_extraction", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("rescue_capture_extract", 0, "neutral", "MP_INGAME_ONLY/OBJ_NEXT_CAPS", "icon_waypoint_hostage", 0);
}

updategametypedvars() {
  setdvarifuninitialized("dvar_5AD4B38EB8B556F1", 0);
  _id_0FD32F08E72B657F::updatecommongametypedvars();
}

#using_animtree("script_model");

initanims() {
  level.scr_animtree["player_pickup_hostage"] = #animtree;
  level.scr_anim["player_pickup_hostage"]["pickup_front_crouch"] = % iw9_mp_hostage_pickup_crouch_8;
  level.scr_animname["player_pickup_hostage"]["pickup_front_crouch"] = "iw9_mp_hostage_pickup_crouch_8";
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_crouch"] = "pickup_front_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_front_stand"] = % iw9_mp_hostage_pickup_stand_8;
  level.scr_animname["player_pickup_hostage"]["pickup_front_stand"] = "iw9_mp_hostage_pickup_stand_8";
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_stand"] = "pickup_front_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_back_crouch"] = % iw9_mp_hostage_pickup_crouch_2;
  level.scr_animname["player_pickup_hostage"]["pickup_back_crouch"] = "iw9_mp_hostage_pickup_crouch_2";
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_crouch"] = "pickup_back_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_back_stand"] = % iw9_mp_hostage_pickup_stand_2;
  level.scr_animname["player_pickup_hostage"]["pickup_back_stand"] = "iw9_mp_hostage_pickup_stand_2";
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_stand"] = "pickup_back_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_right_crouch"] = % iw9_mp_hostage_pickup_crouch_6;
  level.scr_animname["player_pickup_hostage"]["pickup_right_crouch"] = "iw9_mp_hostage_pickup_crouch_6";
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_crouch"] = "pickup_right_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_right_stand"] = % iw9_mp_hostage_pickup_stand_6;
  level.scr_animname["player_pickup_hostage"]["pickup_right_stand"] = "iw9_mp_hostage_pickup_stand_6";
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_stand"] = "pickup_right_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_left_crouch"] = % iw9_mp_hostage_pickup_crouch_4;
  level.scr_animname["player_pickup_hostage"]["pickup_left_crouch"] = "iw9_mp_hostage_pickup_crouch_4";
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_crouch"] = "pickup_left_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_left_stand"] = % iw9_mp_hostage_pickup_stand_4;
  level.scr_animname["player_pickup_hostage"]["pickup_left_stand"] = "iw9_mp_hostage_pickup_stand_4";
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_stand"] = "pickup_left_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_front_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_8;
  level.scr_animname["player_pickup_hostage"]["pickup_front_crouch_vm"] = "iw9_mp_hostage_vm_pickup_crouch_8";
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_crouch_vm"] = "pickup_front_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_front_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_8;
  level.scr_animname["player_pickup_hostage"]["pickup_front_stand_vm"] = "iw9_mp_hostage_vm_pickup_stand_8";
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_stand_vm"] = "pickup_front_stand_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_back_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_2;
  level.scr_animname["player_pickup_hostage"]["pickup_back_crouch_vm"] = "iw9_mp_hostage_vm_pickup_crouch_2";
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_crouch_vm"] = "pickup_back_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_back_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_2;
  level.scr_animname["player_pickup_hostage"]["pickup_back_stand_vm"] = "iw9_mp_hostage_vm_pickup_stand_2";
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_stand_vm"] = "pickup_back_stand_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_right_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_6;
  level.scr_animname["player_pickup_hostage"]["pickup_right_crouch_vm"] = "iw9_mp_hostage_vm_pickup_crouch_6";
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_crouch_vm"] = "pickup_right_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_right_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_6;
  level.scr_animname["player_pickup_hostage"]["pickup_right_stand_vm"] = "iw9_mp_hostage_vm_pickup_stand_6";
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_stand_vm"] = "pickup_right_stand_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_left_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_4;
  level.scr_animname["player_pickup_hostage"]["pickup_left_crouch_vm"] = "iw9_mp_hostage_vm_pickup_crouch_4";
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_crouch_vm"] = "pickup_left_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_left_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_4;
  level.scr_animname["player_pickup_hostage"]["pickup_left_stand_vm"] = "iw9_mp_hostage_vm_pickup_stand_4";
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_stand_vm"] = "pickup_left_stand_vm";
  level.scr_animtree["hostage_pickup"] = #animtree;
  level.scr_anim["hostage_pickup"]["pickup_front_crouch"] = % iw9_mp_hostage_pickedup_crouch_8;
  level.scr_animname["hostage_pickup"]["pickup_front_crouch"] = "iw9_mp_hostage_pickedup_crouch_8";
  level.scr_eventanim["hostage_pickup"]["pickup_front_crouch"] = "hostage_pickup_front_crouch";
  level.scr_anim["hostage_pickup"]["pickup_front_stand"] = % iw9_mp_hostage_pickedup_stand_8;
  level.scr_animname["hostage_pickup"]["pickup_front_stand"] = "iw9_mp_hostage_pickedup_stand_8";
  level.scr_eventanim["hostage_pickup"]["pickup_front_stand"] = "hostage_pickup_front_stand";
  level.scr_anim["hostage_pickup"]["pickup_back_crouch"] = % iw9_mp_hostage_pickedup_crouch_2;
  level.scr_animname["hostage_pickup"]["pickup_back_crouch"] = "iw9_mp_hostage_pickedup_crouch_2";
  level.scr_eventanim["hostage_pickup"]["pickup_back_crouch"] = "hostage_pickup_back_crouch";
  level.scr_anim["hostage_pickup"]["pickup_back_stand"] = % iw9_mp_hostage_pickedup_stand_2;
  level.scr_animname["hostage_pickup"]["pickup_back_stand"] = "iw9_mp_hostage_pickedup_stand_2";
  level.scr_eventanim["hostage_pickup"]["pickup_back_stand"] = "hostage_pickup_back_stand";
  level.scr_anim["hostage_pickup"]["pickup_right_crouch"] = % iw9_mp_hostage_pickedup_crouch_6;
  level.scr_animname["hostage_pickup"]["pickup_right_crouch"] = "iw9_mp_hostage_pickedup_crouch_6";
  level.scr_eventanim["hostage_pickup"]["pickup_right_crouch"] = "hostage_pickup_right_crouch";
  level.scr_anim["hostage_pickup"]["pickup_right_stand"] = % iw9_mp_hostage_pickedup_stand_6;
  level.scr_animname["hostage_pickup"]["pickup_right_stand"] = "iw9_mp_hostage_pickedup_stand_6";
  level.scr_eventanim["hostage_pickup"]["pickup_right_stand"] = "hostage_pickup_right_stand";
  level.scr_anim["hostage_pickup"]["pickup_left_crouch"] = % iw9_mp_hostage_pickedup_crouch_4;
  level.scr_animname["hostage_pickup"]["pickup_left_crouch"] = "iw9_mp_hostage_pickedup_crouch_4";
  level.scr_eventanim["hostage_pickup"]["pickup_left_crouch"] = "hostage_pickup_left_crouch";
  level.scr_anim["hostage_pickup"]["pickup_left_stand"] = % iw9_mp_hostage_pickedup_stand_4;
  level.scr_animname["hostage_pickup"]["pickup_left_stand"] = "iw9_mp_hostage_pickedup_stand_4";
  level.scr_eventanim["hostage_pickup"]["pickup_left_stand"] = "hostage_pickup_left_stand";
  level.scr_anim["hostage_pickup"]["pickup_front_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_8;
  level.scr_animname["hostage_pickup"]["pickup_front_crouch_vm"] = "iw9_mp_hostage_vm_pickedup_crouch_8";
  level.scr_eventanim["hostage_pickup"]["pickup_front_crouch_vm"] = "hostage_pickup_front_crouch_vm";
  level.scr_anim["hostage_pickup"]["pickup_front_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_8;
  level.scr_animname["hostage_pickup"]["pickup_front_stand_vm"] = "iw9_mp_hostage_vm_pickedup_stand_8";
  level.scr_eventanim["hostage_pickup"]["pickup_front_stand_vm"] = "hostage_pickup_front_stand_vm";
  level.scr_anim["hostage_pickup"]["pickup_back_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_2;
  level.scr_animname["hostage_pickup"]["pickup_back_crouch_vm"] = "iw9_mp_hostage_vm_pickedup_crouch_2";
  level.scr_eventanim["hostage_pickup"]["pickup_back_crouch_vm"] = "hostage_pickup_back_crouch_vm";
  level.scr_anim["hostage_pickup"]["pickup_back_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_2;
  level.scr_animname["hostage_pickup"]["pickup_back_stand_vm"] = "iw9_mp_hostage_vm_pickedup_stand_2";
  level.scr_eventanim["hostage_pickup"]["pickup_back_stand_vm"] = "hostage_pickup_back_stand_vm";
  level.scr_anim["hostage_pickup"]["pickup_right_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_6;
  level.scr_animname["hostage_pickup"]["pickup_right_crouch_vm"] = "iw9_mp_hostage_vm_pickedup_crouch_6";
  level.scr_eventanim["hostage_pickup"]["pickup_right_crouch_vm"] = "hostage_pickup_right_crouch_vm";
  level.scr_anim["hostage_pickup"]["pickup_right_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_6;
  level.scr_animname["hostage_pickup"]["pickup_right_stand_vm"] = "iw9_mp_hostage_vm_pickedup_stand_6";
  level.scr_eventanim["hostage_pickup"]["pickup_right_stand_vm"] = "hostage_pickup_right_stand_vm";
  level.scr_anim["hostage_pickup"]["pickup_left_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_4;
  level.scr_animname["hostage_pickup"]["pickup_left_crouch_vm"] = "iw9_mp_hostage_vm_pickedup_crouch_4";
  level.scr_eventanim["hostage_pickup"]["pickup_left_crouch_vm"] = "hostage_pickup_left_crouch_vm";
  level.scr_anim["hostage_pickup"]["pickup_left_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_4;
  level.scr_animname["hostage_pickup"]["pickup_left_stand_vm"] = "iw9_mp_hostage_vm_pickedup_stand_4";
  level.scr_eventanim["hostage_pickup"]["pickup_left_stand_vm"] = "hostage_pickup_left_stand_vm";
}

_id_D527FA212314E504() {
  if(isDefined(level.mapname) && getdvarint("dvar_BF1B18B4B2448E99", 1)) {
    switch (level.mapname) {
      case "mp_shipment_iw9_xmas":
      case "mp_shipment_iw9":
        return [game["attackers"], game["defenders"]];
      default:
        return [game["defenders"], game["attackers"]];
    }
  }

  return [game["defenders"], game["attackers"]];
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  [_id_694AC8737C6FEF29, _id_ADAE79C9E323184D] = _id_D527FA212314E504();
  scripts\mp\spawnlogic::addstartspawnpoints("mp_rescue_spawn_attacker");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_rescue_spawn_defender");
  scripts\mp\spawnlogic::addspawnpoints(_id_694AC8737C6FEF29, "mp_rescue_spawn_attacker");
  scripts\mp\spawnlogic::addspawnpoints(_id_ADAE79C9E323184D, "mp_rescue_spawn_defender");

  if(level.mapname == "mp_m_speedball" || level.mapname == "mp_m_overunder" || level.mapname == "mp_m_overwinter") {
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_defender");
    _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_attacker");
  } else if(level.mapname == "mp_petrograd") {
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_attacker");
    _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_defender", 1);
  } else if(istrue(level._id_F1C340DAE77CA15D)) {
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_attacker", 1);
    _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_defender", 1);
  } else {
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_attacker");
    _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_rescue_spawn_defender");
  }

  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
  spawnteam = self.pers["team"];
  spawnpoint = undefined;
  [_id_694AC8737C6FEF29, _id_ADAE79C9E323184D] = _id_D527FA212314E504();
  _id_5D57963B098879CF = _id_ADAE79C9E323184D;
  _id_997B6614F3B296B7 = _id_694AC8737C6FEF29;

  if(level._id_385BB8FDAB525E2B) {
    _id_5D57963B098879CF = _id_694AC8737C6FEF29;
    _id_997B6614F3B296B7 = _id_ADAE79C9E323184D;
  }

  if(spawnteam == _id_997B6614F3B296B7) {
    scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
  } else {
    scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
  }

  return spawnpoint;
}

_id_45F0BD1189BA467C(mapname) {
  _id_0A65297A455514E0 = [];

  switch (mapname) {
    case "mp_farm_18":
      _id_0A65297A455514E0[0] = (-935, 588, 12);
      _id_0A65297A455514E0[1] = (664, 840, 8);
      return _id_0A65297A455514E0;
    case "mp_grandprix_pm_2":
      _id_0A65297A455514E0[0] = (98, -1, 2);
      _id_0A65297A455514E0[1] = (-1709, 285, 48);
      return _id_0A65297A455514E0;
    case "mp_luxury":
      _id_0A65297A455514E0[0] = (-567, 1822, 2);
      _id_0A65297A455514E0[1] = (1633, 1632, 80);
      return _id_0A65297A455514E0;
    case "mp_musuem":
      _id_0A65297A455514E0[0] = (-390, 1992, 546);
      _id_0A65297A455514E0[1] = (-2089, 1093, 570);
      return _id_0A65297A455514E0;
    case "mp_swap_meet":
      _id_0A65297A455514E0[0] = (28969, -28273, 3174);
      _id_0A65297A455514E0[1] = (29413, -30139, 3174);
      return _id_0A65297A455514E0;
    case "mp_fort":
      _id_0A65297A455514E0[0] = (17728, -54048, 1025);
      _id_0A65297A455514E0[1] = (15968, -53632, 1136);
      return _id_0A65297A455514E0;
    case "mp_hydro":
      _id_0A65297A455514E0[0] = (-9394.5, 7968.5, 304);
      _id_0A65297A455514E0[1] = (-10280, 8656, 344);
      return _id_0A65297A455514E0;
    case "mp_wartorn":
      _id_0A65297A455514E0[0] = (-9901.26, 43167.5, 234.159);
      _id_0A65297A455514E0[1] = (-7713.92, 44422.1, 241.991);
      return _id_0A65297A455514E0;
    case "mp_oilfield_gw":
    case "mp_observe_gw":
    case "mp_lone_gw":
    case "mp_historic_gw2":
    case "mp_dogtown_gw":
    case "mp_caves_gw":
    case "mp_sunken_gw":
    case "mp_regional_gw":
    case "mp_forsaken_gw":
    case "mp_nogales_gw2":
    case "mp_fishtown_gw":
    case "mp_sira_gw":
    case "mp_wartorn_gw":
      if(isDefined(level._id_D27F667E6320D465)) {
        _id_807596236EB20C21 = scripts\engine\utility::getStruct(level._id_D27F667E6320D465._id_7FDCF3BD51650CF2, "script_noteworthy");
        _id_807593236EB20588 = scripts\engine\utility::getStruct(level._id_D27F667E6320D465._id_7FDCF2BD51650ABF, "script_noteworthy");
      } else {
        _id_807596236EB20C21 = scripts\engine\utility::getStruct("hostage_a", "script_noteworthy");
        _id_807593236EB20588 = scripts\engine\utility::getStruct("hostage_b", "script_noteworthy");
      }

      if(isDefined(_id_807596236EB20C21) && isDefined(_id_807593236EB20588))
        return [scripts\engine\utility::drop_to_ground(_id_807596236EB20C21.origin, 10, -10), scripts\engine\utility::drop_to_ground(_id_807593236EB20588.origin, 10, -10)];

      break;
    default:
      break;
  }

  return undefined;
}

_id_F8C926CDEB59F116() {
  hostages = getEntArray("hostage_group_01", "target");
  _id_6085A8DF9C0E33EB = [];

  if(hostages.size > 0) {
    _id_6085A8DF9C0E33EB = hostages;

    if(level._id_0C8B917BF9D0B1D1 == 1)
      _id_6085A8DF9C0E33EB = scripts\engine\utility::array_randomize(_id_6085A8DF9C0E33EB);
  } else
    _id_6085A8DF9C0E33EB = getEntArray("hostage_trigger", "targetname");

  level._id_826175089E4669D6 = 0;

  if(_id_6085A8DF9C0E33EB.size == 0) {
    level._id_826175089E4669D6 = 1;
    level._id_CA4E08767CBDAE12 = ::_id_15A66746E75CC48A;
    _id_807596236EB20C21 = scripts\engine\utility::getStruct("hostage_a", "script_noteworthy");

    if(isDefined(_id_807596236EB20C21)) {
      trigger = spawn("script_model", scripts\engine\utility::drop_to_ground(_id_807596236EB20C21.origin, 10, -20));
      trigger.angles = _id_807596236EB20C21.angles;
      trigger.objectivekey = "_a";
      trigger.iconname = "_a";
      _id_6085A8DF9C0E33EB[_id_6085A8DF9C0E33EB.size] = trigger;
    }

    _id_807593236EB20588 = scripts\engine\utility::getStruct("hostage_b", "script_noteworthy");

    if(isDefined(_id_807593236EB20588)) {
      trigger = spawn("script_model", scripts\engine\utility::drop_to_ground(_id_807593236EB20588.origin, 10, -20));
      trigger.angles = _id_807593236EB20588.angles;
      trigger.objectivekey = "_b";
      trigger.iconname = "_b";
      _id_6085A8DF9C0E33EB[_id_6085A8DF9C0E33EB.size] = trigger;
    }
  }

  _id_0A65297A455514E0 = undefined;

  if(getdvarint("dvar_9F5FA1A2BEE6620E", 1) && !istrue(level._id_826175089E4669D6))
    _id_0A65297A455514E0 = _id_45F0BD1189BA467C(level.mapname);

  level.planttime = 5;
  _id_3800A132040816D1 = 0;

  foreach(trigger in _id_6085A8DF9C0E33EB) {
    if(_id_3800A132040816D1 >= level._id_0C8B917BF9D0B1D1) {
      break;
    }

    if(isDefined(_id_0A65297A455514E0))
      trigger.origin = _id_0A65297A455514E0[_id_3800A132040816D1];

    visuals[0] = spawn("script_model", trigger.origin);
    visuals[0] setModel("body_civ_me_male_1_1");
    visuals[0] setasgametypeobjective();
    head = spawn("script_model", visuals[0].origin);

    if(istrue(level._id_826175089E4669D6)) {
      visuals[0].angles = trigger.angles;
      head.linktoenabledflag = 1;
      head makeusable();
      head._id_02768447445DB282 = 1;
      hostage = scripts\mp\gameobjects::createcarryobject(game["attackers"], head, visuals, (0, 0, 16), undefined, 1);
    } else
      hostage = scripts\mp\gameobjects::createcarryobject(game["attackers"], trigger, visuals, (0, 0, 16), undefined, 1);

    head setModel("head_hostage_hood_01");
    head linkTo(visuals[0], "j_neck", (-9, 1, 0), (0, 0, 0));
    hostage.head = head;
    hostage.body = visuals[0];
    hostage.body solid();
    hostage.head solid();
    tracestart = visuals[0].origin + (0, 0, 32);
    _id_8B39E5984DA1FFAF = visuals[0].origin + (0, 0, -100);
    contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1);
    ignoreents = [visuals[0], trigger];
    trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);

    if(trace["fraction"] < 1)
      visuals[0].origin = trace["position"] + (0, 0, 2);

    hostage.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
    hostage scripts\mp\gameobjects::requestid(1, 1);
    hostage scripts\mp\gameobjects::allowuse("enemy");
    hostage.cancontestclaim = 0;
    hostage.stalemate = 0;
    hostage.wasstalemate = 1;
    hostage._id_C5C106D22C19BC92 = 0;
    hostage.usetime = 0;
    hostage.userate = 1;
    hostage.id = "care_package";
    hostage.exclusiveuse = 0;
    hostage.skiptouching = 1;
    hostage.skipminimapids = 1;
    hostage.curorigin = hostage.body.origin;
    hostage.offset3d = (0, 0, 30);

    if(istrue(level._id_826175089E4669D6)) {
      head setHintString(&"MP/HOLD_TO_ESCORT_HOSTAGE");
      head setusepriority(-4);
    } else {
      hostage.trigger setHintString(&"MP/HOLD_TO_ESCORT_HOSTAGE");
      hostage.trigger setusepriority(-4);
    }

    hostage scripts\mp\gameobjects::setusetime(0);
    hostage scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
    hostage.allowweapons = 1;
    hostage.onpickup = ::_id_DC87FDD9E74E945E;
    hostage.ondrop = ::_id_13DB2131B3F0851F;
    hostage.onreset = ::_id_3CAC51C950D63E5D;
    hostage.pickupchecks = [::_id_6201C84E805AB787, ::_id_A4BEDA038141B8F8, ::_id_FDA15D11F6BAF729, ::_id_5C8CF2EEE42128C8, ::_id_ED073D24CD8ED3C5];
    hostage.onpickupfailed = ::_id_23456BCBF6DD329F;
    hostage._id_4BCC694316C44D94 = ::_id_5C749561016BC2B2;
    hostage.carryobjectasset = "hostage_rescue";

    if(getdvarint("dvar_C44109000ED1922D") != 0)
      hostage scripts\mp\gameobjects::_id_316D9DA870E12A03([visuals[0], hostage.head], undefined, undefined, 32.0, 180.0, undefined, 0);

    if(isDefined(trigger.objectivekey))
      hostage.objectivekey = trigger.objectivekey;
    else
      hostage.objectivekey = trigger.script_label;

    hostage scripts\mp\gameobjects::setvisibleteam("none");
    hostage._id_EA5E94E328A4B626.pickupchecks[hostage._id_EA5E94E328A4B626.pickupchecks.size] = ::_id_ADCEC6D9047E4E62;
    hostage.objidpingfriendly = 0;
    hostage.objidpingenemy = 0;
    hostage.objpingdelay = 0.05;
    _id_220BE32C83520117 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    hostage._id_081121FB99D0A00B = _id_220BE32C83520117;
    scripts\mp\objidpoolmanager::objective_add_objective(_id_220BE32C83520117, "done", hostage.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(_id_220BE32C83520117, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(_id_220BE32C83520117, 0);
    hostage scripts\mp\gameobjects::setvisibleteam("none", _id_220BE32C83520117);
    objective_setownerteam(_id_220BE32C83520117, game["defenders"]);
    hostage.objidpingfriendly = 0;
    hostage.objidpingenemy = 0;
    hostage.objpingdelay = 0.05;
    _id_220BE32C83520117 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    hostage._id_BD657A84755765DE = _id_220BE32C83520117;
    scripts\mp\objidpoolmanager::objective_add_objective(_id_220BE32C83520117, "done", hostage.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(_id_220BE32C83520117, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(_id_220BE32C83520117, 0);
    hostage scripts\mp\gameobjects::setvisibleteam("none", _id_220BE32C83520117);
    objective_setownerteam(_id_220BE32C83520117, game["attackers"]);
    hostage thread _id_A5B7C34A5C2D56D2();

    if(!isDefined(level.hostages))
      level.hostages = [];

    level.hostages[hostage.objidnum] = hostage;

    if(level._id_91F947790DF03886)
      _id_7D3DBBB99EE466E0(trigger, hostage);

    _id_3800A132040816D1++;
  }
}

_id_ADCEC6D9047E4E62(player) {
  if(!isDefined(player))
    return 0;

  if(scripts\mp\outofbounds::isoob(player))
    return 0;

  return 1;
}

_id_5C749561016BC2B2(hostage) {
  hostage scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend" + hostage.objectivekey, "waypoint_capture" + hostage.objectivekey);
  hostage scripts\mp\gameobjects::setvisibleteam("any");
  objective_state(hostage._id_081121FB99D0A00B, "current");
  hostage scripts\mp\gameobjects::updatecompassicon("enemy", hostage._id_081121FB99D0A00B);
  objective_icon(hostage._id_081121FB99D0A00B, "icon_waypoint_hostage");
}

_id_E94CF520D98CE0E1() {
  level endon("game_ended");

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");

  if(game["switchedsides"])
    setomnvar("ui_rescue_swapped_sides", 1);
  else
    setomnvar("ui_rescue_swapped_sides", 0);

  foreach(hostage in level.hostages) {
    _id_5C749561016BC2B2(hostage);
    hostage scripts\mp\objidpoolmanager::objective_set_play_intro(hostage.objidnum, 0);
    hostage scripts\mp\objidpoolmanager::objective_set_play_outro(hostage.objidnum, 0);
    hostage scripts\mp\objidpoolmanager::objective_set_pulsate(hostage.objidnum, 1);
  }

  if(level._id_385BB8FDAB525E2B) {
    foreach(_id_9CC712DF12A78D2A in level._id_F57A27B32E66A765) {
      _id_9CC712DF12A78D2A scripts\mp\gameobjects::allowuse("none");
      _id_9CC712DF12A78D2A scripts\mp\gameobjects::setvisibleteam("enemy");
      _id_9CC712DF12A78D2A scripts\mp\gameobjects::setobjectivestatusicons(level.iconextract, level.icondefendextract);
      _id_9CC712DF12A78D2A scripts\mp\objidpoolmanager::objective_set_play_intro(_id_9CC712DF12A78D2A.objidnum, 0);
      _id_9CC712DF12A78D2A scripts\mp\objidpoolmanager::objective_set_play_outro(_id_9CC712DF12A78D2A.objidnum, 0);
      _id_9CC712DF12A78D2A scripts\mp\objidpoolmanager::objective_set_pulsate(_id_9CC712DF12A78D2A.objidnum, 1);
    }
  }

  waittime = scripts\engine\utility::ter_op(isDefined(level.prematchperiodend), level.prematchperiodend, 10);
  wait(waittime);

  foreach(hostage in level.hostages)
  hostage scripts\mp\objidpoolmanager::objective_set_pulsate(hostage.objidnum, 0);

  if(level._id_385BB8FDAB525E2B) {
    foreach(_id_9CC712DF12A78D2A in level._id_F57A27B32E66A765)
    _id_9CC712DF12A78D2A scripts\mp\objidpoolmanager::objective_set_pulsate(_id_9CC712DF12A78D2A.objidnum, 0);
  }
}

_id_47C4DD8E0C76B446() {
  switch (level.mapname) {
    case "mp_hydro_gw":
      _id_F57A35B32E66C62F = spawnStruct();
      _id_F57A36B32E66C862 = spawnStruct();
      _id_F57A35B32E66C62F.origin = (-10275, 12623, 523);
      _id_F57A36B32E66C862.origin = (-6126, 12958, 482);
      return [_id_F57A35B32E66C62F, _id_F57A36B32E66C862];
    case "mp_brobison_test01":
      _id_F57A35B32E66C62F = spawnStruct();
      _id_F57A35B32E66C62F.origin = (-402, 114, 0);
      return [_id_F57A35B32E66C62F];
    case "mp_oilfield_gw":
    case "mp_observe_gw":
    case "mp_lone_gw":
    case "mp_historic_gw2":
    case "mp_dogtown_gw":
    case "mp_caves_gw":
    case "mp_sunken_gw":
    case "mp_regional_gw":
    case "mp_forsaken_gw":
    case "mp_nogales_gw2":
    case "mp_fishtown_gw":
    case "mp_sira_gw":
    case "mp_wartorn_gw":
      if(isDefined(level._id_D27F667E6320D465))
        _id_4293650F0C1037D2 = scripts\engine\utility::getStruct(level._id_D27F667E6320D465._id_4CB3562E52DD45B8, "script_noteworthy");
      else
        _id_4293650F0C1037D2 = scripts\engine\utility::getStruct("hr_extraction_zone", "script_noteworthy");

      if(isDefined(_id_4293650F0C1037D2)) {
        _id_F57A35B32E66C62F = spawnStruct();
        _id_F57A35B32E66C62F.origin = scripts\engine\utility::drop_to_ground(_id_4293650F0C1037D2.origin, 10, -20);
        return [_id_F57A35B32E66C62F];
      }

      break;
    default:
      break;
  }

  return undefined;
}

_id_7D7B80B0DAB99AE0(mapname) {
  switch (mapname) {
    case "mp_grandprix_pm_2":
      _id_9CC712DF12A78D2A = spawnStruct();
      _id_9CC712DF12A78D2A.origin = (-1178, 3116, 4);
      return [_id_9CC712DF12A78D2A];
    case "mp_swap_meet":
      _id_9CC712DF12A78D2A = spawnStruct();
      _id_9CC712DF12A78D2A.origin = (26840, -30893, 3124);
      return [_id_9CC712DF12A78D2A];
    case "mp_wartorn":
      _id_9CC712DF12A78D2A = spawnStruct();
      _id_9CC712DF12A78D2A.origin = (-6708, 42009, 209);
      return [_id_9CC712DF12A78D2A];
    default:
      return undefined;
  }

  return undefined;
}

_id_B924BA876AE5B152() {
  triggers = undefined;

  if(getdvarint("dvar_9F5FA1A2BEE6620E", 1))
    triggers = _id_7D7B80B0DAB99AE0(level.mapname);

  if(getdvarint("dvar_0F41985DC2241F4A", 1) && !isDefined(triggers))
    triggers = _id_47C4DD8E0C76B446();

  if(!isDefined(triggers))
    triggers = getEntArray("hostage_extract", "targetname");

  _id_0DEC7F03EE8E5150 = ["_a", "_b", "_c"];
  _id_D3BEF8FC9CA1DE3B = 0;

  foreach(trigger in triggers) {
    _id_C8A41AE10DD3B1D2 = game["defenders"];
    visuals[0] = spawn("script_model", trigger.origin);
    exfilgoaltrigger = spawn("trigger_radius", trigger.origin, 0, 120, 60);
    droppoint = exfilgoaltrigger.origin;
    contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 1, 1);
    ignoreents = [];
    trace = scripts\engine\trace::ray_trace(visuals[0].origin + (0, 0, 20), visuals[0].origin - (0, 0, 4000), ignoreents, contentoverride, 0);

    if(isPlayer(trace["entity"]))
      trace["entity"] = undefined;

    _id_2B5A1E993BB88C21 = undefined;

    if(isDefined(trace)) {
      droporigin = trace["position"];

      if(isDefined(self.visualgroundoffset))
        droporigin = droporigin + self.visualgroundoffset;

      _id_2B5A1E993BB88C21 = spawnscriptable("rescue_extract", droporigin);
      upangles = vectortoangles(trace["normal"]);
      baseeffectforward = anglesToForward(upangles);
      _id_2B5A1E993BB88C21.angles = generateaxisanglesfromforwardvector(baseeffectforward, _id_2B5A1E993BB88C21.angles);
    }

    exfilgoaltrigger.objectivekey = _id_0DEC7F03EE8E5150[_id_D3BEF8FC9CA1DE3B];
    level._id_0393D50BC6A378DC = 1;
    extractzone = _id_6663215F917210AE::setupobjective(exfilgoaltrigger, _id_C8A41AE10DD3B1D2, 1, 1, 1);
    extractzone scripts\mp\gameobjects::requestid(1, 1);
    extractzone scripts\mp\gameobjects::setownerteam(game["defenders"]);
    extractzone scripts\mp\gameobjects::allowuse("none");
    extractzone.pinobj = 0;
    extractzone.onuse = ::extractzone_onuse;
    extractzone.onbeginuse = ::extractzone_onusebegin;
    extractzone.usecondition = ::_id_76BA7E56087A12FD;
    extractzone._id_F56EDB5DF74AE868 = ::_id_846B74EC142BDC18;

    if(isDefined(_id_2B5A1E993BB88C21))
      extractzone._id_2B5A1E993BB88C21 = _id_2B5A1E993BB88C21;

    if(!isDefined(level._id_F57A27B32E66A765))
      level._id_F57A27B32E66A765 = [];

    level._id_F57A27B32E66A765[level._id_F57A27B32E66A765.size] = extractzone;
    _id_D3BEF8FC9CA1DE3B++;

    if(_id_D3BEF8FC9CA1DE3B >= level._id_681EABE436C0029D) {
      break;
    }
  }
}

_id_7D3DBBB99EE466E0(trigger, hostage) {
  _id_7EF5D520C8F71475 = spawn("trigger_radius", trigger.origin, 0, 120, 80);
  _id_081D9EF9289A3921 = scripts\mp\gameobjects::createuseobject(game["defenders"], _id_7EF5D520C8F71475, [], undefined, undefined, 1);
  _id_081D9EF9289A3921.onuse = ::_id_CCF456CD84B96382;
  _id_081D9EF9289A3921.usetime = 0;
  _id_081D9EF9289A3921 scripts\mp\gameobjects::requestid(1, 1);
  _id_081D9EF9289A3921 scripts\mp\gameobjects::setownerteam(game["defenders"]);
  _id_081D9EF9289A3921 scripts\mp\gameobjects::allowuse("none");
  _id_081D9EF9289A3921 scripts\mp\gameobjects::setvisibleteam("none");

  if(!isDefined(level._id_735DEFF44B2C0F56))
    level._id_735DEFF44B2C0F56 = [];

  level._id_735DEFF44B2C0F56[hostage.objidnum] = _id_081D9EF9289A3921;
}

_id_8C59ADA73FB15ED7(player, _id_CFE3C08991268E70) {
  self notify("head_icon_watch");
  self endon("head_icon_watch");
  self endon("hostage_extracted");
  self endon("dropped");
  player endon("death");
  _id_D8CB6D243B0C5AF4 = 0;
  _id_B6B08A6A6F96B5C4 = getdvarfloat("dvar_04A679C3FEA6CCCF", 4.0);

  if(!isalive(player) || scripts\mp\utility\player::isinlaststand(player) || !istrue(player._id_5B3C77E2EAFAB370)) {
    return;
  }
  self.offset3d = (0, 0, 0);
  self.origin = self.curorigin;
  trackedobject = scripts\mp\gameobjects::createtrackedobject(player, (0, 0, 100));
  scripts\mp\objidpoolmanager::objective_set_play_intro(trackedobject.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(trackedobject.objidnum, 0);
  trackedobject.objidpingfriendly = 1;
  trackedobject.objidpingenemy = 0;
  trackedobject.objpingdelay = _id_B6B08A6A6F96B5C4;
  trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level._id_E8891F63E5A412C2);
  trackedobject scripts\mp\gameobjects::setvisibleteam("friendly");
  self.trackedobject = trackedobject;

  if(level.showenemycarrier) {
    trackedobject.pingobjidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    scripts\mp\objidpoolmanager::objective_add_objective(trackedobject.pingobjidnum, "current", player.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(trackedobject.pingobjidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(trackedobject.pingobjidnum, 0);
    objective_setownerteam(trackedobject.pingobjidnum, player.team);
    trackedobject scripts\mp\gameobjects::updatecompassicon("enemy", trackedobject.pingobjidnum);
    objective_icon(trackedobject.pingobjidnum, level.waypointshader["rescue_kill_carrier"]);
    scripts\mp\objidpoolmanager::update_objective_setenemylabel(trackedobject.pingobjidnum, level.waypointstring["rescue_kill_carrier"]);
    objective_state(trackedobject.pingobjidnum, "current");
  }

  thread _id_DA3DA0004950E970(trackedobject, 2);
}

_id_8277F49F79BFF530(animname, spawnpos, _id_B7850001037AA074) {
  self.animname = animname;

  if(!isDefined(spawnpos))
    spawnpos = (0, 0, 0);

  if(!isDefined(_id_B7850001037AA074))
    _id_B7850001037AA074 = (0, 0, 0);

  if(isPlayer(self))
    self _meth_B88C89BB7CD1AB8E(spawnpos);

  _id_0E3BDA5BE1DB297F = spawn("script_arms", spawnpos, 0, 0, self);
  _id_0E3BDA5BE1DB297F.angles = _id_B7850001037AA074;
  _id_0E3BDA5BE1DB297F.player = self;
  self._id_0E3BDA5BE1DB297F = _id_0E3BDA5BE1DB297F;
  self._id_0E3BDA5BE1DB297F.animname = animname;
  self._id_0E3BDA5BE1DB297F useanimtree(#animtree);
  self._id_0E3BDA5BE1DB297F.updatedversion = 1;
  self playerlinktoabsolute(self._id_0E3BDA5BE1DB297F, "tag_player");
  self notify("rig_created");
  scripts\engine\utility::waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(self)) {
    self unlink();
    scripts\mp\utility\player::_id_5471A04FAAD16A00();
    thread scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();
  }

  if(isDefined(_id_0E3BDA5BE1DB297F))
    _id_0E3BDA5BE1DB297F delete();
}

_id_A3A4A2CDCA554483(animname, spawnpos, _id_B7850001037AA074) {
  self.animname = animname;

  if(!isDefined(spawnpos))
    spawnpos = (0, 0, 0);

  if(!isDefined(_id_B7850001037AA074))
    _id_B7850001037AA074 = (0, 0, 0);

  if(isPlayer(self))
    self _meth_B88C89BB7CD1AB8E(spawnpos);

  _id_54D7B76A2A71E284 = spawn("script_arms", spawnpos, 0, 0, self);
  _id_54D7B76A2A71E284.angles = _id_B7850001037AA074;
  _id_54D7B76A2A71E284.player = self;
  self._id_54D7B76A2A71E284 = _id_54D7B76A2A71E284;
  self._id_54D7B76A2A71E284.animname = animname;
  self._id_54D7B76A2A71E284 useanimtree(#animtree);
  self._id_54D7B76A2A71E284.updatedversion = 1;
  self playerlinktoblend(self._id_54D7B76A2A71E284, "tag_player", 0.5, 0.0, 0.25);
  self notify("rig_created");
  scripts\engine\utility::waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(self)) {
    self unlink();
    scripts\mp\utility\player::_id_5471A04FAAD16A00();
    thread scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();
  }

  if(isDefined(_id_54D7B76A2A71E284))
    _id_54D7B76A2A71E284 delete();
}

_id_8F65AC94AAFE5D3E(animname, spawnpos, _id_B7850001037AA074) {
  self.animname = animname;

  if(!isDefined(spawnpos))
    spawnpos = (0, 0, 0);

  if(!isDefined(_id_B7850001037AA074))
    _id_B7850001037AA074 = (0, 0, 0);

  _id_FC77A3EE1C3E72B5 = spawn("script_model", spawnpos);
  _id_FC77A3EE1C3E72B5.angles = _id_B7850001037AA074;
  _id_FC77A3EE1C3E72B5 setModel("body_civ_me_male_1_1");
  self._id_FC77A3EE1C3E72B5 = _id_FC77A3EE1C3E72B5;
  self._id_FC77A3EE1C3E72B5.animname = animname;
  self._id_FC77A3EE1C3E72B5 useanimtree(#animtree);
  self._id_FC77A3EE1C3E72B5.updatedversion = 1;
  head = spawn("script_model", spawnpos);
  head setModel("head_hostage_hood_01");
  self._id_FC77A3EE1C3E72B5.head = head;
  self notify("rig_created");
  scripts\engine\utility::waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(head)) {
    head unlink();
    head delete();
  }

  if(isDefined(_id_FC77A3EE1C3E72B5))
    _id_FC77A3EE1C3E72B5 delete();
}

_id_3B8913DC82881267(player) {
  animlength = 0;
  stance = player getstance();

  if(stance == "prone") {
    player setstance("crouch", 1, 1);
    stance = "crouch";
  }

  player._id_280ABCD08CBDCC79 = player getcurrentweapon();
  _id_2B1D0E57C66A43D0 = makeweapon("iw9_gunless_mp");
  player giveweapon(_id_2B1D0E57C66A43D0);
  player._id_73F4B954751A8643 = _id_2B1D0E57C66A43D0;
  player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(_id_2B1D0E57C66A43D0, 1, 1);
  _id_7C4E2C6A50914434 = (self.body.origin[0], self.body.origin[1], player.origin[2]);
  _id_CEBE2632E00D0E2D = vectorNormalize(player.origin - _id_7C4E2C6A50914434);
  _id_82B4F01CE94ED444 = vectordot(_id_CEBE2632E00D0E2D, anglesToForward(self.body.angles));
  _id_8288E81CE91E5C46 = vectordot(_id_CEBE2632E00D0E2D, anglestoright(self.body.angles));
  self.body scriptmodelclearanim();
  _id_14AEA8523FA938BA = (player.origin[0], player.origin[1], self.body.origin[2]);
  _id_F514603FEAF5C1E2 = player getmovingplatformparent();
  _id_8A9148BE19028AFA = isDefined(_id_F514603FEAF5C1E2) && scripts\cp_mp\utility\killstreak_utility::_id_63BDC8C411A85475(_id_F514603FEAF5C1E2);

  if(_id_8A9148BE19028AFA)
    _id_14AEA8523FA938BA = (player.origin[0], player.origin[1], player.origin[2]);

  self.body.origin = _id_14AEA8523FA938BA + anglesToForward(player.angles) * 34.672;
  anime = "pickup_back_stand";
  _id_CF13EDFFB05EFCD8 = "pickup_back_stand_vm";

  if(_id_82B4F01CE94ED444 >= 0.707) {
    anime = "pickup_front_" + stance;
    _id_CF13EDFFB05EFCD8 = "pickup_front_" + stance + "_vm";
    _id_636EC99138E1950A = vectorNormalize(player.origin - self.body.origin);
    _id_318EEA579595B65E = scripts\mp\utility\script::vectortoanglessafe(_id_636EC99138E1950A, anglestoup(self.body.angles));
    self.body.angles = _id_318EEA579595B65E;
  } else if(_id_82B4F01CE94ED444 <= -0.707) {
    anime = "pickup_back_" + stance;
    _id_CF13EDFFB05EFCD8 = "pickup_back_" + stance + "_vm";
    _id_81554C014CE7839C = vectorNormalize(self.body.origin - player.origin);
    _id_318EEA579595B65E = scripts\mp\utility\script::vectortoanglessafe(_id_81554C014CE7839C, anglestoup(self.body.angles));
    self.body.angles = _id_318EEA579595B65E;
  } else if(_id_8288E81CE91E5C46 >= 0.707) {
    anime = "pickup_right_" + stance;
    _id_CF13EDFFB05EFCD8 = "pickup_right_" + stance + "_vm";
    _id_81554C014CE7839C = vectorcross(vectorNormalize(self.body.origin - player.origin), anglestoup(self.body.angles));
    _id_318EEA579595B65E = scripts\mp\utility\script::vectortoanglessafe(_id_81554C014CE7839C, anglestoup(self.body.angles));
    self.body.angles = _id_318EEA579595B65E;
  } else if(_id_8288E81CE91E5C46 <= -0.707) {
    anime = "pickup_left_" + stance;
    _id_CF13EDFFB05EFCD8 = "pickup_left_" + stance + "_vm";
    _id_636EC99138E1950A = vectorcross(vectorNormalize(player.origin - self.body.origin), anglestoup(self.body.angles));
    _id_318EEA579595B65E = scripts\mp\utility\script::vectortoanglessafe(_id_636EC99138E1950A, anglestoup(self.body.angles));
    self.body.angles = _id_318EEA579595B65E;
  }

  player thread _id_8277F49F79BFF530("player_pickup_hostage", player.origin, player.angles);
  player._id_0E3BDA5BE1DB297F hide();
  player thread _id_A3A4A2CDCA554483("player_pickup_hostage", player.origin, player.angles);

  if(player _meth_C1092F42B6BBE490())
    player._id_54D7B76A2A71E284 hide();
  else
    player._id_54D7B76A2A71E284 showonlytoplayer(player);

  thread _id_8F65AC94AAFE5D3E("hostage_pickup", self.body.origin, self.body.angles);
  self._id_FC77A3EE1C3E72B5 hide();
  self._id_FC77A3EE1C3E72B5 showonlytoplayer(player);

  if(isDefined(self._id_FC77A3EE1C3E72B5.head)) {
    self._id_FC77A3EE1C3E72B5.head hide();
    self._id_FC77A3EE1C3E72B5.head showonlytoplayer(player);
    self._id_FC77A3EE1C3E72B5.head linkTo(self._id_FC77A3EE1C3E72B5, "j_neck", (-9, 1, 0), (0, 0, 0));
  }

  self.body.animname = "hostage_pickup";
  self.body useanimtree(level.scr_animtree["hostage_pickup"]);
  self.body._id_62AA114A2C4E5E62 = 1;
  self.body hidefromplayer(player);
  self.head hidefromplayer(player);
  animstruct = spawnStruct();
  animstruct.origin = player.origin;
  animstruct.angles = player.angles;

  if(_id_8A9148BE19028AFA) {
    self._id_FC77A3EE1C3E72B5 linkTo(_id_F514603FEAF5C1E2);
    player._id_54D7B76A2A71E284 linkTo(_id_F514603FEAF5C1E2);
    player playerlinkedoffsetenable();
  }

  animstruct thread scripts\mp\anim::anim_player_solo(player, player._id_0E3BDA5BE1DB297F, anime);
  animstruct thread scripts\common\anim::anim_single_solo(player._id_54D7B76A2A71E284, _id_CF13EDFFB05EFCD8);
  self.body thread scripts\common\anim::anim_single_solo(self.body, anime);
  self._id_FC77A3EE1C3E72B5 thread scripts\common\anim::anim_single_solo(self._id_FC77A3EE1C3E72B5, _id_CF13EDFFB05EFCD8);
  wait(getanimlength(level.scr_anim["player_pickup_hostage"][_id_CF13EDFFB05EFCD8]));

  if(_id_8A9148BE19028AFA) {
    self._id_FC77A3EE1C3E72B5 unlink();
    player._id_54D7B76A2A71E284 unlink();
    player _meth_1BBFE4913FD10C4A();
  }

  player notify("remove_rig");
  self notify("remove_rig");
  self.body stopuseanimtree();
  self.body._id_62AA114A2C4E5E62 = undefined;
  player._id_73F4B954751A8643 = undefined;
  player takeweapon(_id_2B1D0E57C66A43D0);
}

_id_DC87FDD9E74E945E(player, _id_5760E0F038D1BAA3, defused) {
  player._id_C47EBA4C148AFA86 = 1;
  thread _id_D2EE5EF1475DC79B(player, _id_5760E0F038D1BAA3, defused);
}

_id_D2EE5EF1475DC79B(player, _id_5760E0F038D1BAA3, defused) {
  self notify("hostage_pickup");
  player endon("death_or_disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("hostage_pickup");
  player._id_5B3C77E2EAFAB370 = 1;
  self.carrier = player;
  player setclientomnvar("ui_rescue_carrying_hostage", 1);

  if(!isDefined(level._id_7FCC5417218AD4C8))
    level._id_7FCC5417218AD4C8 = [];

  if(level._id_7FCC5417218AD4C8.size == 0) {
    foreach(_id_2AD1E3D925C26B64 in level.players) {
      if(_id_2AD1E3D925C26B64.team == player.team) {
        _id_2AD1E3D925C26B64 setclientomnvar("ui_rescue_hostage_active", 1);
        continue;
      }

      _id_2AD1E3D925C26B64 setclientomnvar("ui_rescue_hostage_active", 2);
    }
  }

  level._id_7FCC5417218AD4C8[self.objidnum] = self;
  self.body show();
  self.head show();
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carry");
  player _id_3B64EB40368C1450::set("carry", "equipment_secondary", 0);
  player _id_3B64EB40368C1450::set("carry", "equipment_primary", 0);
  player _id_3B64EB40368C1450::set("carry", "supers", 0);
  player _id_3B64EB40368C1450::set("carry", "killstreaks", 0);
  player _id_3B64EB40368C1450::set("carry", "melee", 0);
  player _id_3B64EB40368C1450::set("carry", "prone", 0);
  player _id_3B64EB40368C1450::set("carry", "slide", 0);
  player _id_3B64EB40368C1450::set("carry", "supersprint", 0);
  player _id_3B64EB40368C1450::set("carry", "mount_side", 0);
  player _id_3B64EB40368C1450::set("carry", "mount_top", 0);
  player _id_3B64EB40368C1450::set("carry", "mantle", 0);
  player _id_3B64EB40368C1450::set("carry", "swimming_underwater", 0);
  player _id_3B64EB40368C1450::set("carry", "dtp", 0);
  player _id_3B64EB40368C1450::set("carry", "ladder", 0);
  player _id_3B64EB40368C1450::set("carry", "weapon_pickup", 0);
  player _id_3B64EB40368C1450::set("carry", "weapon_switch", 0);
  player _id_3B64EB40368C1450::set("carry", "weapon_switch_clip", 0);
  player _id_3B64EB40368C1450::set("carry", "execution_victim", 0);
  player _id_3B64EB40368C1450::set("carry", "ads", 1);
  self._id_44206360497F15C2 = 1;
  _id_3B8913DC82881267(player);
  self._id_44206360497F15C2 = undefined;

  foreach(hostage in level.hostages) {
    if(hostage.objectivekey != self.objectivekey)
      hostage.trigger disableplayeruse(player);
  }

  self.body scriptmodelclearanim();
  self.body hide();
  self.head hide();
  _id_83DFC273B8E7EFED(player);
  player setcarryobject(self.carryobjectasset);
  team = player.pers["team"];
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::setvisibleteam("none", self._id_081121FB99D0A00B);
  scripts\mp\gameobjects::setownerteam(player.team);
  _id_CFE3C08991268E70 = getdvarint("dvar_4CB6C41A033BABA9", 0);
  thread _id_8C59ADA73FB15ED7(player, _id_CFE3C08991268E70);

  if(isDefined(level.revivetriggers)) {
    foreach(_id_B25CA392892D7A80 in level.revivetriggers)
    _id_B25CA392892D7A80 disablescriptableplayeruse(player);
  }

  if(!player scripts\mp\utility\killstreak::isjuggernaut()) {
    player.playerstreakspeedscale = -0.15;
    player setmovespeedscale(0.85);
  }

  thread _id_7BC240FC69EA5205(player);
  thread scripts\mp\hud_util::_id_7B2653A588F28E29(player, "rescue_player_hostage", "rescue_team_hostage", "rescue_took_hostage");

  if(team == game["defenders"] && level._id_91F947790DF03886) {
    level._id_8F21D2090CBC3B2A = 0;

    foreach(_id_9CC712DF12A78D2A in level._id_F57A27B32E66A765) {
      if(isDefined(_id_9CC712DF12A78D2A._id_53D907BF6D19394E) && isDefined(_id_9CC712DF12A78D2A._id_53D907BF6D19394E[self.objidnum])) {
        _id_9CC712DF12A78D2A._id_53D907BF6D19394E[self.objidnum] = undefined;
        _id_9CC712DF12A78D2A.numtouching[game["attackers"]]--;

        if(_id_9CC712DF12A78D2A._id_53D907BF6D19394E.size <= 0) {
          _id_9CC712DF12A78D2A scripts\mp\gameobjects::allowuse("none");
          _id_9CC712DF12A78D2A scripts\mp\gameobjects::setvisibleteam("none");
        }

        break;
      }
    }

    level._id_735DEFF44B2C0F56[self.objidnum] scripts\mp\objidpoolmanager::objective_set_play_intro(level._id_735DEFF44B2C0F56[self.objidnum].objidnum, 0);
    level._id_735DEFF44B2C0F56[self.objidnum] scripts\mp\objidpoolmanager::objective_set_play_outro(level._id_735DEFF44B2C0F56[self.objidnum].objidnum, 0);
    level._id_735DEFF44B2C0F56[self.objidnum] scripts\mp\gameobjects::setvisibleteam("friendly");
    level._id_735DEFF44B2C0F56[self.objidnum] scripts\mp\gameobjects::allowuse("friendly");
    level._id_735DEFF44B2C0F56[self.objidnum] scripts\mp\gameobjects::setobjectivestatusicons(level._id_E8891F63E5A412C2);
    return;
  }

  foreach(_id_9CC712DF12A78D2A in level._id_F57A27B32E66A765) {
    if(!istrue(level._id_7F1C1334377DAAD5)) {
      _id_9CC712DF12A78D2A scripts\mp\objidpoolmanager::objective_set_play_intro(_id_9CC712DF12A78D2A.objidnum, 1);
      _id_9CC712DF12A78D2A scripts\mp\objidpoolmanager::objective_set_play_outro(_id_9CC712DF12A78D2A.objidnum, 1);
    } else {
      _id_9CC712DF12A78D2A scripts\mp\objidpoolmanager::objective_set_play_intro(_id_9CC712DF12A78D2A.objidnum, 0);
      _id_9CC712DF12A78D2A scripts\mp\objidpoolmanager::objective_set_play_outro(_id_9CC712DF12A78D2A.objidnum, 0);
    }

    _id_9CC712DF12A78D2A scripts\mp\gameobjects::allowuse("friendly");
    _id_9CC712DF12A78D2A scripts\mp\gameobjects::setvisibleteam("any");
    _id_9CC712DF12A78D2A scripts\mp\gameobjects::setobjectivestatusicons(level.iconextract, level.icondefendextract);
    _id_9CC712DF12A78D2A._id_2B5A1E993BB88C21 setscriptablepartstate("rescue_extract", "idle");
    thread _id_DA3DA0004950E970(_id_9CC712DF12A78D2A, 2);
  }

  level._id_7F1C1334377DAAD5 = 1;

  if(getdvarint("dvar_A75075FF09347A5A", 1))
    thread _id_6D799E269B621800(player);

  player._id_C47EBA4C148AFA86 = undefined;
}

_id_23456BCBF6DD329F(player) {
  player scripts\mp\hud_message::showerrormessage("MP/DENY_CARRY_OBJECT");
}

_id_7BC240FC69EA5205(player) {
  self notify("rescue_trigger_pickup_sound");
  self endon("rescue_trigger_pickup_sound");
  self endon("dropped");
  level endon("game_ended");

  if(isDefined(player)) {
    team = player.pers["team"];
    otherteam = scripts\mp\utility\game::getotherteam(team)[0];
    scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, "iw9_mp_prisoner_pickup", "iw9_mp_prisoner_taken", player);
    waittime = getdvarfloat("dvar_9AE09C23FDC10452", 0.5);

    if(waittime > 0)
      wait(waittime);

    if(!istrue(level.gameended)) {
      if(isDefined(team))
        scripts\mp\utility\dialog::leaderdialog("hostage_taken_friendly", team);

      if(isDefined(otherteam))
        scripts\mp\utility\dialog::leaderdialog("hostage_taken_enemy", otherteam);
    }
  }
}

_id_6D799E269B621800(_id_BFAC34A0D9424099) {
  _id_BFAC34A0D9424099 endon("death_or_disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("hostage_pickup");
  self endon("hostage_extracted");
  _id_7EBE382BCACFE466 = getdvarint("dvar_8C20D20855246445", 2);
  _id_460D919302CEA625 = getdvarint("dvar_397DB1642965B6EF", 0);
  _id_5621F114739B01B9 = getdvarint("dvar_85DFE5454EF66256", 1);

  if(_id_460D919302CEA625) {
    foreach(player in level.players) {
      if(player.pers["team"] == _id_BFAC34A0D9424099.team)
        player.radarshowenemydirection = 1;
    }
  }

  while(_id_7EBE382BCACFE466 > 0 || _id_5621F114739B01B9) {
    if(getdvarint("dvar_F45C0A46B4A12087", 1))
      triggerportableradarpingteam(_id_BFAC34A0D9424099.origin, _id_BFAC34A0D9424099.team, 1000);
    else
      triggerportableradarping(_id_BFAC34A0D9424099.origin, _id_BFAC34A0D9424099, 1000);

    _id_7EBE382BCACFE466--;
    wait 2;
  }

  if(_id_460D919302CEA625) {
    foreach(player in level.players) {
      if(player.pers["team"] == _id_BFAC34A0D9424099.team)
        player.radarshowenemydirection = 0;
    }
  }
}

_id_83DFC273B8E7EFED(player) {
  _id_849C1DF4114E0A37 = player getweaponslistprimaries();
  pistol = undefined;

  foreach(_id_DE88CD14114C1E24 in _id_849C1DF4114E0A37) {
    if(scripts\mp\utility\weapon::getweapongroup(_id_DE88CD14114C1E24) == "weapon_pistol" && !scripts\mp\utility\weapon::isakimbo(_id_DE88CD14114C1E24)) {
      pistol = _id_DE88CD14114C1E24;
      break;
    }
  }

  if(isDefined(pistol)) {
    player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(pistol, undefined, 1);
    player._id_280ABCD08CBDCC79 = pistol;
  } else {
    if(!player hasweapon("iw9_me_fists_mp")) {
      _id_1199FE671D6A5653 = makeweapon("iw9_me_fists_mp");
      player giveweapon(_id_1199FE671D6A5653);
      player._id_7EBBB0DC14346EAA = _id_1199FE671D6A5653;
    } else
      _id_1199FE671D6A5653 = "iw9_me_fists_mp";

    player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(_id_1199FE671D6A5653, undefined, 1);
    scripts\mp\weapons::fixupplayerweapons(player, _id_1199FE671D6A5653);
  }
}

_id_524F22FE698EEB0F(player) {
  player endon("death_or_disconnect");
  player _id_3B64EB40368C1450::set("carry", "weapon_switch", 1);
  player forceplaygestureviewmodel("iw9_ges_hostage_pickup_out", undefined, 0, undefined, 1, 1);
  player resetcarryobject();

  while(istrue(player._id_12BFB031C0A0EFD8))
    waitframe();

  gunless = makeweapon("iw9_gunless_mp");
  player giveweapon(gunless);
  player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, undefined, 1);

  if(isDefined(player._id_7EBBB0DC14346EAA)) {
    player takeweapon(player._id_7EBBB0DC14346EAA);
    player._id_7EBBB0DC14346EAA = undefined;
    player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(player._id_280ABCD08CBDCC79);
  } else
    player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(player._id_280ABCD08CBDCC79);

  if(isDefined(player._id_280ABCD08CBDCC79))
    player._id_280ABCD08CBDCC79 = undefined;

  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carry");
  player takeweapon(gunless);
}

_id_13DB2131B3F0851F(player, _id_20034B7333F48B8C, _id_0C3018ADEACDD826) {
  player._id_C47EBA4C148AFA86 = undefined;
  thread _id_3D86750123DC1F90(player, _id_20034B7333F48B8C, istrue(self._id_0C3018ADEACDD826));
}

_id_3D86750123DC1F90(player, _id_20034B7333F48B8C, _id_0C3018ADEACDD826) {
  self notify("prompt_cleanup");
  player notify("remove_rig");
  self notify("remove_rig");
  self notify("hostage_pickup");
  self endon("death");
  self endon("hostage_extracted");
  level endon("game_ended");

  if(isDefined(player) && !player scripts\mp\utility\killstreak::isjuggernaut()) {
    player.playerstreakspeedscale = 0;
    player setmovespeedscale(1);
  }

  if(!istrue(_id_0C3018ADEACDD826) && !istrue(_id_20034B7333F48B8C)) {
    scripts\mp\utility\dialog::leaderdialog("dropped_hostage_defend", game["attackers"]);
    scripts\mp\utility\dialog::leaderdialog("dropped_hostage_retrieve", game["defenders"]);
  }

  scripts\mp\gameobjects::setownerteam(game["attackers"]);
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::setvisibleteam("none", self._id_081121FB99D0A00B);

  if(isDefined(self.trackedobject)) {
    if(isDefined(self.trackedobject.pingobjidnum)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(self.trackedobject.pingobjidnum);
      self.trackedobject.pingobjidnum = undefined;
    }

    self.trackedobject scripts\mp\gameobjects::deletetrackedobject();
    self.trackedobject = undefined;
  }

  if(isDefined(player)) {
    foreach(hostage in level.hostages)
    hostage.trigger enableplayeruse(player);
  }

  if(isDefined(player)) {
    if(scripts\mp\utility\player::isreallyalive(player))
      thread _id_524F22FE698EEB0F(player);
    else {
      player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carry");

      if(isDefined(player._id_7EBBB0DC14346EAA)) {
        player takeweapon(player._id_7EBBB0DC14346EAA);
        player._id_7EBBB0DC14346EAA = undefined;
      }

      if(isDefined(player._id_280ABCD08CBDCC79))
        player._id_280ABCD08CBDCC79 = undefined;

      player resetcarryobject();
    }

    player._id_5B3C77E2EAFAB370 = undefined;
    player setclientomnvar("ui_rescue_carrying_hostage", 0);

    if(isDefined(level.revivetriggers)) {
      foreach(_id_B25CA392892D7A80 in level.revivetriggers) {
        if(isDefined(_id_B25CA392892D7A80.ownerteam) && _id_B25CA392892D7A80.ownerteam == player.team)
          _id_B25CA392892D7A80 enablescriptableplayeruse(player);
      }
    }
  }

  if(isDefined(level._id_7FCC5417218AD4C8) && isDefined(level._id_7FCC5417218AD4C8[self.objidnum]))
    level._id_7FCC5417218AD4C8[self.objidnum] = undefined;

  if(isDefined(level._id_7FCC5417218AD4C8) && level._id_7FCC5417218AD4C8.size <= 0) {
    foreach(_id_2AD1E3D925C26B64 in level.players)
    _id_2AD1E3D925C26B64 setclientomnvar("ui_rescue_hostage_active", 0);

    foreach(_id_9CC712DF12A78D2A in level._id_F57A27B32E66A765) {
      _id_9CC712DF12A78D2A scripts\mp\gameobjects::allowuse("none");

      if(level._id_385BB8FDAB525E2B) {
        _id_9CC712DF12A78D2A scripts\mp\gameobjects::setvisibleteam("enemy");
        level thread _id_DA3DA0004950E970(_id_9CC712DF12A78D2A, 2.0);
        continue;
      }

      _id_9CC712DF12A78D2A scripts\mp\gameobjects::setvisibleteam("none");
      _id_9CC712DF12A78D2A._id_2B5A1E993BB88C21 setscriptablepartstate("rescue_extract", "off");
    }
  }

  thread _id_A5B7C34A5C2D56D2();

  if(istrue(self._id_44206360497F15C2) || !isDefined(player)) {
    self._id_44206360497F15C2 = undefined;
    self.body scriptmodelclearanim();
    scripts\mp\gameobjects::allowuse("enemy");
    _id_5C749561016BC2B2(self);

    if(isDefined(player) && isDefined(player._id_73F4B954751A8643))
      player takeweapon(player._id_73F4B954751A8643);

    waitframe();

    if(!istrue(self._id_1D85141D8703F5D4)) {
      self.head show();

      if(istrue(self.body._id_62AA114A2C4E5E62)) {
        self.body stopuseanimtree();
        self.body._id_62AA114A2C4E5E62 = undefined;
      }

      self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
    }

    return;
  }

  animlength = undefined;

  if(!istrue(self._id_1D85141D8703F5D4)) {
    _id_A2731E6D9AF15254 = player getmovingplatformparent();

    if(isDefined(player) && scripts\cp_mp\utility\killstreak_utility::_id_3C5C5D86EF14420E(_id_A2731E6D9AF15254)) {
      self._id_90758EFDE9B783B7 = spawn("script_origin", self.body.origin);
      self._id_90758EFDE9B783B7 linkTo(_id_A2731E6D9AF15254);
      self.body linkTo(self._id_90758EFDE9B783B7);
      thread _id_333F22BA123F0470(player);
    }

    self.body.angles = player.angles;
    self.body.origin = player.origin;

    if(istrue(level._id_826175089E4669D6))
      self.head linkTo(self.body, "j_neck", (-9, 1, 0), (0, 0, 0));

    self.head show();
    self.body scriptmodelclearanim();

    if(player getstance() == "stand") {
      if(istrue(self.body._id_62AA114A2C4E5E62)) {
        self.body stopuseanimtree();
        self.body._id_62AA114A2C4E5E62 = undefined;
      }

      self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_dropped_stand");
      animlength = getanimlength(%iw9_mp_hostage_dropped_stand) - 1;
    } else if(player getstance() == "crouch") {
      if(istrue(self.body._id_62AA114A2C4E5E62)) {
        self.body stopuseanimtree();
        self.body._id_62AA114A2C4E5E62 = undefined;
      }

      self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_dropped_crouch");
      animlength = getanimlength(%iw9_mp_hostage_dropped_crouch) - 1;
    }
  }

  if(isDefined(animlength))
    wait(animlength);

  self.curorigin = self.body.origin;
  self.offset3d = (0, 0, 30);
  scripts\mp\gameobjects::allowuse("enemy");
  _id_5C749561016BC2B2(self);
  self.head show();

  if(istrue(self.body._id_62AA114A2C4E5E62)) {
    self.body stopuseanimtree();
    self.body._id_62AA114A2C4E5E62 = undefined;
  }

  self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
}

_id_333F22BA123F0470(player) {
  self endon("hostage_pickup");
  thread _id_A29878FB7AFFBC16(player);

  for(;;) {
    self.trigger.origin = self._id_90758EFDE9B783B7.origin;
    wait 0.01;
  }
}

_id_A29878FB7AFFBC16(player) {
  level endon("disconnect");
  self waittill("hostage_pickup");
  self._id_90758EFDE9B783B7 unlink();
  self.body unlink();
  self._id_90758EFDE9B783B7 delete();
}

_id_4988B37643F2672F(player) {
  self notify("prompt_cleanup");
  player notify("remove_rig");
  self notify("remove_rig");
  self notify("hostage_pickup");
  isoob = undefined;

  if(isDefined(level.outofboundstriggers)) {
    foreach(trigger in level.outofboundstriggers) {
      if(istrue(self.allowedintrigger)) {
        break;
      }

      if(!self.visuals[0] istouching(trigger)) {
        continue;
      }
      self.body scriptmodelclearanim();
      isoob = 1;
      break;
    }
  }

  foreach(trigger in level.hurttriggers) {
    if(!self.visuals[0] istouching(trigger)) {
      continue;
    }
    isoob = 1;
    break;
  }

  if(isDefined(player) && !player scripts\mp\utility\killstreak::isjuggernaut()) {
    player.playerstreakspeedscale = 0;
    player setmovespeedscale(1);
  }

  if(istrue(isoob) && getdvarint("dvar_6E4B1F8AADDCC6F5", 1) == 1) {
    self.head show();
    self.body show();
    _id_A9706ADAF7C52E27 = getclosestpointonnavmesh(self.visuals[0].origin);
    self.body.origin = _id_A9706ADAF7C52E27;
    self.body.angles = (0, self.body.angles[1], 0);
    self.body scriptmodelclearanim();

    if(istrue(self.body._id_62AA114A2C4E5E62)) {
      self.body stopuseanimtree();
      self.body._id_62AA114A2C4E5E62 = undefined;
    }

    self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
  }

  scripts\mp\gameobjects::setownerteam(game["attackers"]);
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::setvisibleteam("none", self._id_081121FB99D0A00B);

  if(isDefined(self.trackedobject)) {
    if(isDefined(self.trackedobject.pingobjidnum)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(self.trackedobject.pingobjidnum);
      self.trackedobject.pingobjidnum = undefined;
    }

    self.trackedobject scripts\mp\gameobjects::deletetrackedobject();
    self.trackedobject = undefined;
  }

  if(isDefined(player)) {
    foreach(hostage in level.hostages)
    hostage.trigger enableplayeruse(player);
  }

  if(isDefined(player)) {
    if(scripts\mp\utility\player::isreallyalive(player))
      thread _id_524F22FE698EEB0F(player);
    else {
      player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carry");

      if(isDefined(player._id_7EBBB0DC14346EAA)) {
        player takeweapon(player._id_7EBBB0DC14346EAA);
        player._id_7EBBB0DC14346EAA = undefined;
      }

      if(isDefined(player._id_280ABCD08CBDCC79))
        player._id_280ABCD08CBDCC79 = undefined;

      player resetcarryobject();
    }

    player._id_5B3C77E2EAFAB370 = undefined;
    player setclientomnvar("ui_rescue_carrying_hostage", 0);

    if(isDefined(level.revivetriggers)) {
      foreach(_id_B25CA392892D7A80 in level.revivetriggers)
      _id_B25CA392892D7A80 enablescriptableplayeruse(player);
    }
  }

  if(isDefined(level._id_7FCC5417218AD4C8) && isDefined(level._id_7FCC5417218AD4C8[self.objidnum]))
    level._id_7FCC5417218AD4C8[self.objidnum] = undefined;

  if(isDefined(level._id_7FCC5417218AD4C8) && level._id_7FCC5417218AD4C8.size <= 0) {
    foreach(_id_2AD1E3D925C26B64 in level.players)
    _id_2AD1E3D925C26B64 setclientomnvar("ui_rescue_hostage_active", 0);

    foreach(_id_9CC712DF12A78D2A in level._id_F57A27B32E66A765) {
      _id_9CC712DF12A78D2A scripts\mp\gameobjects::allowuse("none");

      if(level._id_385BB8FDAB525E2B) {
        _id_9CC712DF12A78D2A scripts\mp\gameobjects::setvisibleteam("enemy");
        level thread _id_DA3DA0004950E970(_id_9CC712DF12A78D2A, 2.0);
        continue;
      }

      _id_9CC712DF12A78D2A scripts\mp\gameobjects::setvisibleteam("none");
      _id_9CC712DF12A78D2A._id_2B5A1E993BB88C21 setscriptablepartstate("rescue_extract", "off");
    }
  }

  thread _id_A5B7C34A5C2D56D2();

  if(istrue(self._id_44206360497F15C2) || !isDefined(player)) {
    self._id_44206360497F15C2 = undefined;
    self.body scriptmodelclearanim();
    self.curorigin = self.body.origin;
    self.offset3d = (0, 0, 30);
    scripts\mp\gameobjects::allowuse("enemy");
    _id_5C749561016BC2B2(self);

    if(isDefined(player) && isDefined(player._id_73F4B954751A8643))
      player takeweapon(player._id_73F4B954751A8643);

    waitframe();

    if(!istrue(isoob)) {
      self.head show();

      if(istrue(self.body._id_62AA114A2C4E5E62)) {
        self.body stopuseanimtree();
        self.body._id_62AA114A2C4E5E62 = undefined;
      }

      self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
    }

    return;
  }

  _id_A2731E6D9AF15254 = player getmovingplatformparent();

  if(isDefined(player) && scripts\cp_mp\utility\killstreak_utility::_id_3C5C5D86EF14420E(_id_A2731E6D9AF15254)) {
    self._id_90758EFDE9B783B7 = spawn("script_origin", self.body.origin);
    self._id_90758EFDE9B783B7 linkTo(_id_A2731E6D9AF15254);
    self.body linkTo(self._id_90758EFDE9B783B7);
    thread _id_333F22BA123F0470(player);
  }

  self.curorigin = self.body.origin;
  self.offset3d = (0, 0, 30);
  scripts\mp\gameobjects::allowuse("enemy");
  _id_5C749561016BC2B2(self);

  if(!istrue(isoob)) {
    self.head show();

    if(istrue(self.body._id_62AA114A2C4E5E62)) {
      self.body stopuseanimtree();
      self.body._id_62AA114A2C4E5E62 = undefined;
    }

    self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
  }
}

_id_C7EDFF9E8AEBCC86(player, _id_EA5E94E328A4B626) {
  _id_C3248B9962FE3B35 = _id_EA5E94E328A4B626._id_5338AB800FA9B63A;
  _id_20F30C47C5442258 = _id_EA5E94E328A4B626._id_20F30C47C5442258;
  ignoreents = [];

  if(isDefined(_id_EA5E94E328A4B626.ignoreents))
    ignoreents = _id_EA5E94E328A4B626.ignoreents;

  ignoreents[ignoreents.size] = player;
  trace = undefined;
  height = player getEye()[2] - player.origin[2];
  end = player.origin + (0, 0, height / 2);
  forward = anglesToForward(player getplayerangles());
  x = forward[0] * cos(_id_C3248B9962FE3B35) - forward[1] * sin(_id_C3248B9962FE3B35);
  y = forward[0] * sin(_id_C3248B9962FE3B35) + forward[1] * cos(_id_C3248B9962FE3B35);
  _id_85CDA59B0F7F2FF2 = (x, y, 0);
  _id_23596220A6C8C97D = _id_20F30C47C5442258 * vectorNormalize(_id_85CDA59B0F7F2FF2);
  height = player getEye()[2] - player.origin[2];
  start = player.origin + (0, 0, height / 2);
  end = start + _id_23596220A6C8C97D;
  trace = scripts\engine\trace::sphere_trace(start, end, height / 2 - 1, ignoreents);

  if(!isDefined(trace))
    return 0;

  if(trace["fraction"] < 1)
    return 0;

  _id_9D0D801EAB27109A = scripts\engine\trace::ray_trace(end, end - (0, 0, height), ignoreents);

  if(isDefined(_id_9D0D801EAB27109A["position"]) && scripts\mp\outofbounds::ispointinoutofbounds(_id_9D0D801EAB27109A["position"]))
    return 0;

  if(vectordot(_id_9D0D801EAB27109A["normal"], (0, 0, 1)) > 0.8)
    return 1;

  return 0;
}

_id_3CAC51C950D63E5D() {
  self.head show();
  self.body show();

  if(istrue(self.body._id_62AA114A2C4E5E62)) {
    self.body stopuseanimtree();
    self.body._id_62AA114A2C4E5E62 = undefined;
  }

  self.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
}

_id_846B74EC142BDC18() {
  team = self.claimteam;
  _id_ADE7A7F9806809FB = self.claimplayer;

  if(self.touchlist[team].size > 0) {
    players = getarraykeys(self.touchlist[team]);

    for(index = 0; index < players.size; index++) {
      _id_E29BB013735AF9BC = self.touchlist[team][players[index]];

      if(isDefined(_id_E29BB013735AF9BC.player) && scripts\mp\utility\player::isreallyalive(_id_E29BB013735AF9BC.player) && istrue(_id_E29BB013735AF9BC.player._id_5B3C77E2EAFAB370))
        return _id_E29BB013735AF9BC.player;
    }
  }

  return _id_ADE7A7F9806809FB;
}

extractzone_onuse(_id_22282E7D48CA3400, team) {
  if(!isDefined(_id_22282E7D48CA3400) || !scripts\mp\utility\player::isreallyalive(_id_22282E7D48CA3400) || !istrue(_id_22282E7D48CA3400._id_5B3C77E2EAFAB370)) {
    return;
  }
  if(!isDefined(team))
    team = _id_22282E7D48CA3400.team;

  _id_22282E7D48CA3400 notify("manual_drop_cleanup");
  hostage = _id_22282E7D48CA3400.carryobject;
  hostage notify("hostage_extracted");
  hostage notify("manual_drop_cleanup");
  thread _id_524F22FE698EEB0F(_id_22282E7D48CA3400);

  if(isDefined(hostage.trackedobject)) {
    if(isDefined(hostage.trackedobject.pingobjidnum)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(hostage.trackedobject.pingobjidnum);
      hostage.trackedobject.pingobjidnum = undefined;
    }

    hostage.trackedobject scripts\mp\gameobjects::deletetrackedobject();
    hostage.trackedobject = undefined;
  }

  hostage notify("prompt_cleanup");
  _id_22282E7D48CA3400 _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carry");

  if(!_id_22282E7D48CA3400 scripts\mp\utility\killstreak::isjuggernaut()) {
    _id_22282E7D48CA3400.playerstreakspeedscale = 0;
    _id_22282E7D48CA3400 setmovespeedscale(1);
  }

  objective_state(hostage._id_BD657A84755765DE, "done");
  objective_state(hostage._id_081121FB99D0A00B, "done");
  _id_22282E7D48CA3400._id_5B3C77E2EAFAB370 = 0;
  level.hostages[hostage.objidnum] = undefined;
  level._id_7FCC5417218AD4C8[hostage.objidnum] = undefined;
  level._id_3CF50BAE86B4BEAE = 1;
  hostage.body delete();
  hostage.head delete();
  hostage scripts\mp\gameobjects::deletetrackedobject();
  _id_22282E7D48CA3400.carryobject = undefined;
  level._id_500370E4F476FAA9 = level._id_500370E4F476FAA9 + 100;
  level._id_319544F76C37154B[team] = level._id_319544F76C37154B[team] + 100;
  _id_22282E7D48CA3400 setclientomnvar("ui_rescue_carrying_hostage", 0);

  if(isDefined(level._id_7FCC5417218AD4C8) && level._id_7FCC5417218AD4C8.size <= 0) {
    foreach(player in level.players)
    player setclientomnvar("ui_rescue_hostage_active", 0);
  }

  if(isDefined(level.revivetriggers)) {
    foreach(_id_B25CA392892D7A80 in level.revivetriggers) {
      if(isDefined(_id_B25CA392892D7A80.ownerteam) && _id_B25CA392892D7A80.ownerteam == _id_22282E7D48CA3400.team)
        _id_B25CA392892D7A80 enablescriptableplayeruse(_id_22282E7D48CA3400);
    }
  }

  _id_1FBF6AAA31163FEB = _id_22282E7D48CA3400.team;
  otherteam = undefined;

  if(team == "allies")
    otherteam = "axis";
  else
    otherteam = "allies";

  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.player = _id_22282E7D48CA3400;
  _id_7E2C53B0BCF117D9.eventname = "capture";
  _id_7E2C53B0BCF117D9.position = _id_22282E7D48CA3400.origin;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
  scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_prisoner_extracted_sfx", "mp_prisoner_lost_sfx", _id_22282E7D48CA3400);
  _id_22282E7D48CA3400 scripts\mp\utility\stats::incpersstat("captures", 1);
  _id_22282E7D48CA3400 scripts\mp\persistence::statsetchild("round", "captures", _id_22282E7D48CA3400.pers["captures"]);
  _id_22282E7D48CA3400 scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(15, 1);
  thread scripts\mp\hud_util::_id_7B2653A588F28E29(_id_22282E7D48CA3400, "rescue_cap_hostage", "rescue_cap_hostage", "rescue_enemy_cap_hostage");
  _id_22282E7D48CA3400 thread scripts\mp\rank::scoreeventpopup("stat_032C5F215F3EC3B3");
  _id_22282E7D48CA3400 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D6568E59815732D");

  if(level.hostages.size <= 0)
    level._id_4817BAC75A8B9EFF = "all_hostage_extracted";

  _id_EC15CE3E7A9D1D86 = _id_CBE00CAA24DA0F0E();
  scripts\mp\gamescore::giveteamscoreforobjective(team, 100, 0, undefined, 1, _id_EC15CE3E7A9D1D86);
  level._id_4817BAC75A8B9EFF = undefined;

  if(level.hostages.size <= 0) {
    if(!_id_808D5C4AAFED7F2E(game["defenders"]) && getdvarint("dvar_5AD4B38EB8B556F1", 0))
      level.forceend = 1;

    level._id_500370E4F476FAA9 = level._id_974E9F26A695CD24;
    thread scripts\mp\gamelogic::endgame(team, game["end_reason"]["all_hostage_extracted"]);
    level._id_D0B7DFA3E29555A1 = undefined;
  } else if(game["teamScores"][team] < level.roundscorelimit) {
    scripts\mp\utility\dialog::leaderdialog("hostage_extraected_friendly", _id_1FBF6AAA31163FEB);
    scripts\mp\utility\dialog::leaderdialog("hostage_extraected_enemy", otherteam);
    level thread _id_52CBCDF9241FD4BF();
  }

  if(level._id_7FCC5417218AD4C8.size > 0) {
    foreach(hostage in level._id_7FCC5417218AD4C8) {
      if(hostage.carrier.team != game["attackers"]) {
        foreach(_id_9CC712DF12A78D2A in level._id_F57A27B32E66A765) {
          _id_9CC712DF12A78D2A scripts\mp\gameobjects::allowuse("friendly");
          _id_9CC712DF12A78D2A scripts\mp\gameobjects::setvisibleteam("any");
          _id_9CC712DF12A78D2A._id_2B5A1E993BB88C21 setscriptablepartstate("rescue_extract", "idle");
        }

        return;
      }
    }
  }

  foreach(_id_9CC712DF12A78D2A in level._id_F57A27B32E66A765) {
    _id_9CC712DF12A78D2A scripts\mp\gameobjects::allowuse("none");
    _id_9CC712DF12A78D2A scripts\mp\gameobjects::setvisibleteam("none");
    _id_9CC712DF12A78D2A._id_2B5A1E993BB88C21 setscriptablepartstate("rescue_extract", "off");
  }

  foreach(hostage in level.hostages)
  hostage.trigger enableplayeruse(_id_22282E7D48CA3400);
}

_id_52CBCDF9241FD4BF() {
  level endon("game_ended");

  if(!isDefined(level._id_D0B7DFA3E29555A1)) {
    wait 2;

    foreach(player in level.players) {
      if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
        _id_C707AC6F8594811D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("prisoner_carry_music_classic");
        player setplayermusicstate(_id_C707AC6F8594811D);
        continue;
      }

      _id_C707AC6F8594811D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("prisoner_carry_music");
      player setplayermusicstate(_id_C707AC6F8594811D);
    }

    level._id_D0B7DFA3E29555A1 = 1;
  }
}

extractzone_onusebegin(player) {
  if(!istrue(player._id_5B3C77E2EAFAB370)) {
    return;
  }
  if(level.flagcapturetime <= 0) {
    return;
  }
  if(!isDefined(self._id_53D907BF6D19394E))
    self._id_53D907BF6D19394E = [];

  hostage = player.carryobject;
  self._id_53D907BF6D19394E[hostage.objidnum] = hostage;
  self.numtouching[player.team]++;
  player._id_5B3C77E2EAFAB370 = 0;
  self.carrier = undefined;
  level._id_7FCC5417218AD4C8[hostage.objidnum] = undefined;
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == player.team)
    _id_024C76FC549F7FD9 = 1;
  else
    _id_024C76FC549F7FD9 = 0;

  if(isPlayer(player))
    player setclientomnvar("ui_objective_pinned_text_param", _id_024C76FC549F7FD9);

  if(!isDefined(self.statusnotifytime))
    self.statusnotifytime = gettime();

  if(self.statusnotifytime > self.statusnotifytime + 5000) {
    self.didstatusnotify = 0;
    self.statusnotifytime = gettime();
  }

  usetime = level.flagcapturetime;

  if(usetime > 0)
    scripts\mp\gameobjects::setobjectivestatusicons(level.icontaking, level.icontaking);

  hostage.safeorigin = self.trigger.origin;
  hostage thread scripts\mp\gameobjects::setdropped(0);
  hostage.head show();

  if(istrue(hostage.body._id_62AA114A2C4E5E62)) {
    hostage.body stopuseanimtree();
    hostage.body._id_62AA114A2C4E5E62 = undefined;
  }

  hostage.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
  hostage scripts\mp\gameobjects::setownerteam(player.team);
  hostage scripts\mp\gameobjects::allowuse("enemy");
  hostage scripts\mp\gameobjects::setvisibleteam("enemy");

  foreach(hostage in level.hostages)
  hostage.trigger enableplayeruse(player);

  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carry");

  if(!player scripts\mp\utility\killstreak::isjuggernaut()) {
    player.playerstreakspeedscale = 0;
    player setmovespeedscale(1);
  }
}

_id_76BA7E56087A12FD(player) {
  if(player.team == game["attackers"])
    return 0;

  if(!isDefined(level._id_7FCC5417218AD4C8))
    return 0;

  if(level._id_7FCC5417218AD4C8.size <= 0)
    return 0;

  return 1;
}

_id_CCF456CD84B96382(player, team) {
  if(!istrue(level._id_8F21D2090CBC3B2A) && isDefined(player.carryobject)) {
    level._id_8F21D2090CBC3B2A = 1;
    hostage = player.carryobject;
    level._id_735DEFF44B2C0F56[hostage.objidnum] scripts\mp\gameobjects::setvisibleteam("none");
    level._id_735DEFF44B2C0F56[hostage.objidnum] scripts\mp\gameobjects::allowuse("none");
    hostage = player.carryobject;
    hostage.safeorigin = self.trigger.origin;
    hostage thread scripts\mp\gameobjects::setdropped(0);
    hostage _id_13DB2131B3F0851F(player, 1);
  }
}

_id_6201C84E805AB787(player) {
  if(player isthrowingbackgrenade() || player isthrowinggrenade())
    return 0;

  return 1;
}

_id_A4BEDA038141B8F8(player) {
  if(istrue(player._id_12BFB031C0A0EFD8))
    return 0;

  return 1;
}

_id_FDA15D11F6BAF729(player) {
  _id_1AFED0877937F203 = player getcurrentweapon();

  if(!scripts\mp\utility\weapon::isprimaryweapon(_id_1AFED0877937F203))
    return 0;

  return 1;
}

_id_5C8CF2EEE42128C8(player) {
  return !player isreloading();
}

_id_ED073D24CD8ED3C5(player) {
  if(self.body islinked())
    return abs(player.origin[2] - self._id_90758EFDE9B783B7.origin[2]) < level._id_F224E09983EF4B2A;

  _id_52CB5824A2C14EEB = abs(player.origin[2] - self.body.origin[2]);
  _id_E98D5D032AA3785D = level._id_F224E09983EF4B2A;
  _id_9D113850FD61075D = abs(player.origin[2] - self.body.origin[2]) < level._id_F224E09983EF4B2A;
  return abs(player.origin[2] - self.body.origin[2]) < level._id_F224E09983EF4B2A;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  if(istrue(self._id_F44AA740D81A25DA))
    self notify("last_stand_finished");

  if(level._id_826175089E4669D6 && isDefined(self.team)) {
    if(self.team == game["attackers"]) {
      foreach(hostage in level.hostages)
      hostage.trigger disableplayeruse(self);
    } else {
      foreach(hostage in level.hostages)
      hostage.trigger enableplayeruse(self);
    }
  }
}

onplayerconnect(player) {
  if(!isDefined(player)) {
    return;
  }
  scripts\mp\outofbounds::registerentforoob(player, "rescue");
}

_id_B9962C5A08FD9AB7(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype) {
  if(!isDefined(self)) {
    return;
  }
  self._id_1D85141D8703F5D4 = 1;
  self notify("force_manual_drop");
}

_id_D50CCE29BBB9D457(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  if(!isDefined(self)) {
    return;
  }
  self._id_1D85141D8703F5D4 = undefined;
}

_id_A12EC32A24E1A367(victim) {
  if(!istrue(victim._id_5B3C77E2EAFAB370)) {
    return;
  }
  if(!isDefined(victim._id_7EBBB0DC14346EAA)) {
    return;
  }
  victim takeweapon(victim._id_7EBBB0DC14346EAA);
  self.lastcacweaponobj = victim._id_280ABCD08CBDCC79;
  victim._id_7EBBB0DC14346EAA = undefined;
}

_id_824AADC5E0A8E202(objweapon) {
  if(isDefined(level.hostages)) {
    foreach(hostage in level.hostages) {
      if(self istouching(hostage.trigger))
        return 0;
    }
  }

  return 1;
}

_id_C95D2A5F442A6BFE(point) {
  if(isDefined(level.hostages)) {
    foreach(hostage in level.hostages) {
      if(isDefined(point)) {
        if(scripts\engine\utility::ispointinsidecircle(point, hostage.curorigin, 40))
          return 0;
      } else if(self istouching(hostage.trigger))
        return 0;
    }
  }

  return 1;
}

_id_15A66746E75CC48A(point) {
  if(isDefined(level.hostages)) {
    foreach(hostage in level.hostages) {
      distsqrd = distancesquared(hostage.trigger.origin, self.origin);

      if(3600 >= distsqrd)
        return 0;
    }
  }

  return 1;
}

_id_189D41172D946149() {
  level endon("game_ended");

  if(!getdvarint("dvar_38C9581A2665C1AA", 1)) {
    return;
  }
  for(;;) {
    validplayers = [];

    foreach(player in level.players) {
      if(isDefined(player.team) && player.team == game["defenders"])
        validplayers[validplayers.size] = player;
    }

    level._id_0FCBB998D4A3F2DA = scripts\engine\utility::_id_21A6A1C613B50A28(validplayers, 700);
    wait 1;
  }
}

_id_A5B7C34A5C2D56D2() {
  self notify("watch_mines");
  self endon("death");
  self endon("watch_mines");
  self endon("hostage_pickup");

  if(!getdvarint("dvar_38C9581A2665C1AA", 1)) {
    return;
  }
  for(;;) {
    if(!isDefined(level._id_0FCBB998D4A3F2DA)) {
      waitframe();
      continue;
    }

    _id_83451E7F85547EE0 = [];

    foreach(_id_BAB0D10E51188531 in level._id_0FCBB998D4A3F2DA scripts\engine\utility::_id_0DF633F460888A47(self.curorigin)) {
      foreach(player in _id_BAB0D10E51188531) {
        if(!isalive(player)) {
          continue;
        }
        _id_83451E7F85547EE0[_id_83451E7F85547EE0.size] = player;
      }
    }

    if(_id_83451E7F85547EE0.size == 0) {
      waitframe();
      continue;
    }

    scripts\cp_mp\utility\game_utility::_id_F5E8B13ACC5B4E24();

    foreach(targetarray in level._id_715AA7F8DE54C394 scripts\engine\utility::_id_0DF633F460888A47(self.curorigin)) {
      foreach(target in targetarray) {
        if(!isDefined(target)) {
          continue;
        }
        if(!isDefined(target.team)) {
          continue;
        }
        if(target.team == game["defenders"] && !getdvarint("dvar_8D4D3E5A116EA626", 0)) {
          continue;
        }
        if(!_id_391D759D20BE6374(target.equipmentref)) {
          continue;
        }
        if(scripts\mp\weapons::isplantedequipment(target) && distance2dsquared(target.origin, self.curorigin) < 160000) {
          voice = 1;

          if(self.objectivekey == "_b")
            voice = 2;

          _id_90E6BC3A37537C77 = "dx_mp_rscu_mode_cvm" + voice + "_rhda";

          foreach(player in _id_83451E7F85547EE0)
          self.head playsoundtoplayer(_id_90E6BC3A37537C77, player, self.head);

          _id_40CDBACDA5CCA105 = lookupsoundlength(_id_90E6BC3A37537C77, 1);
          wait(_id_40CDBACDA5CCA105 / 1000 + 25);
        }
      }
    }

    waitframe();
  }
}

_id_391D759D20BE6374(_id_FBAF0295A16D4C79) {
  if(!isDefined(_id_FBAF0295A16D4C79))
    return 0;

  return _id_FBAF0295A16D4C79 == "equip_at_mine" || _id_FBAF0295A16D4C79 == "equip_c4" || _id_FBAF0295A16D4C79 == "equip_claymore";
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
  score = scripts\mp\rank::getscoreinfovalue("stat_EF9582D72160F199");

  if(isDefined(attacker.laststanding) && attacker.laststanding)
    attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_4BC4AED7D23221B3");

  if(istrue(victim._id_5B3C77E2EAFAB370)) {
    attacker scripts\mp\utility\stats::incpersstat("defends", 1);
    attacker scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(15, 1);
    attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
    attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
  }

  if(isDefined(level._id_7FCC5417218AD4C8) && level._id_7FCC5417218AD4C8.size > 0) {
    if(isDefined(attacker) && isPlayer(attacker) && attacker.pers["team"] != victim.pers["team"]) {
      foreach(hostage in level._id_7FCC5417218AD4C8) {
        if(attacker.pers["team"] == hostage.carrier.team && attacker != hostage.carrier) {
          _id_DB36F135F40E7940 = distancesquared(hostage.carrier.origin, attacker.origin);

          if(_id_DB36F135F40E7940 < 105625) {
            attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
            attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
            attacker scripts\mp\utility\stats::incpersstat("defends", 1);
            attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
            thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, lifeid, "defending");
          }
        }
      }
    }
  }
}

_id_D23F4D7BFE21F9DA() {
  if(isDefined(level._id_7FCC5417218AD4C8)) {
    foreach(hostage in level._id_7FCC5417218AD4C8)
    self disablescriptableplayeruse(hostage.carrier);
  }
}

onflagcapture(_id_3985F515E9F06D2C, label, _id_22282E7D48CA3400, team, _id_8A04AA0E0755E7E3, _id_579DA7B2997DEC60) {}

_id_5F4409E5A953C368(_id_3FB18BF245471D0B, _id_8ADEFCC4F43864FF) {
  _id_ADBDCD3370CC708D = game["roundsWon"][game["attackers"]] + _id_3FB18BF245471D0B;
  _id_E92034AEF3A4B991 = game["roundsWon"][game["defenders"]] + _id_8ADEFCC4F43864FF;

  if(_id_ADBDCD3370CC708D < level.winlimit)
    return 0;

  if(_id_E92034AEF3A4B991 < level.winlimit)
    return 0;

  if(_id_ADBDCD3370CC708D != _id_E92034AEF3A4B991) {
    if(_id_ADBDCD3370CC708D > _id_E92034AEF3A4B991)
      return 1;

    return 2;
  }

  return 3;
}

ontimelimit() {
  _id_EC15CE3E7A9D1D86 = "tie";
  _id_8ADEFCC4F43864FF = 0;
  _id_7FCC5417218AD4C8 = 0;

  if(isDefined(level._id_7FCC5417218AD4C8)) {
    _id_7FCC5417218AD4C8 = level._id_7FCC5417218AD4C8.size;
    _id_8ADEFCC4F43864FF = 100 * _id_7FCC5417218AD4C8;
    level._id_319544F76C37154B[game["defenders"]] = level._id_319544F76C37154B[game["defenders"]] + 100 * _id_7FCC5417218AD4C8;
  }

  _id_DDD6E7CAC66011BA = 50 * (level.hostages.size - _id_7FCC5417218AD4C8);
  level._id_319544F76C37154B[game["attackers"]] = level._id_319544F76C37154B[game["attackers"]] + 50 * (level.hostages.size - _id_7FCC5417218AD4C8);
  level._id_FB257BAFBF772E21 = [];
  level._id_FB257BAFBF772E21[game["attackers"]] = _id_DDD6E7CAC66011BA;
  level._id_FB257BAFBF772E21[game["defenders"]] = _id_8ADEFCC4F43864FF;
  result = _id_5F4409E5A953C368(_id_DDD6E7CAC66011BA, _id_8ADEFCC4F43864FF);

  if(result == 1) {
    _id_EC15CE3E7A9D1D86 = game["attackers"];
    scripts\mp\gamescore::giveteamscoreforobjective(game["attackers"], _id_DDD6E7CAC66011BA, 1, undefined, 1, _id_EC15CE3E7A9D1D86);
    scripts\mp\gamescore::giveteamscoreforobjective(game["defenders"], _id_8ADEFCC4F43864FF, 1, undefined, 1, _id_EC15CE3E7A9D1D86);
  } else if(result == 2) {
    _id_EC15CE3E7A9D1D86 = game["defenders"];
    scripts\mp\gamescore::giveteamscoreforobjective(game["defenders"], _id_8ADEFCC4F43864FF, 1, undefined, 1, _id_EC15CE3E7A9D1D86);
    scripts\mp\gamescore::giveteamscoreforobjective(game["attackers"], _id_DDD6E7CAC66011BA, 1, undefined, 1, _id_EC15CE3E7A9D1D86);
  } else if(result == 3) {
    _id_EC15CE3E7A9D1D86 = "tie";
    scripts\mp\gamescore::giveteamscoreforobjective(game["defenders"], _id_8ADEFCC4F43864FF, 1, undefined, 1, _id_EC15CE3E7A9D1D86);
    scripts\mp\gamescore::giveteamscoreforobjective(game["attackers"], _id_DDD6E7CAC66011BA, 1, undefined, 1, _id_EC15CE3E7A9D1D86);
  } else {
    scripts\mp\gamescore::giveteamscoreforobjective(game["defenders"], _id_8ADEFCC4F43864FF, 1, undefined, 1, _id_EC15CE3E7A9D1D86);
    scripts\mp\gamescore::giveteamscoreforobjective(game["attackers"], _id_DDD6E7CAC66011BA, 1, undefined, 1, _id_EC15CE3E7A9D1D86);
  }

  thread scripts\mp\gamelogic::endgame(_id_EC15CE3E7A9D1D86, game["end_reason"]["time_limit_reached"]);
}

ondeadevent(team) {
  if(team == "all") {
    _id_EC15CE3E7A9D1D86 = "tie";

    if(!_id_808D5C4AAFED7F2E(game["attackers"]) && getdvarint("dvar_5AD4B38EB8B556F1", 0)) {
      level.forcedend = 1;
      _id_EC15CE3E7A9D1D86 = game["defenders"];
    }

    if(!_id_808D5C4AAFED7F2E(game["defenders"]) && getdvarint("dvar_5AD4B38EB8B556F1", 0)) {
      level.forcedend = 1;
      _id_EC15CE3E7A9D1D86 = game["attackers"];
    }

    level._id_500370E4F476FAA9 = 0;
    _id_EC15CE3E7A9D1D86 = _id_CBE00CAA24DA0F0E();
    level thread scripts\mp\gamelogic::endgame(_id_EC15CE3E7A9D1D86, game["end_reason"]["tie"]);
  } else if(team == game["attackers"]) {
    score = 50;

    if(isDefined(level._id_7FCC5417218AD4C8) && level._id_7FCC5417218AD4C8.size > 0) {
      _id_C538365EE9199F8C = level._id_7FCC5417218AD4C8.size * 100;
      score = int(clamp(_id_C538365EE9199F8C + 50, 50, level._id_974E9F26A695CD24));
    }

    if(score + level._id_319544F76C37154B[game["defenders"]] >= level._id_974E9F26A695CD24)
      score = level._id_974E9F26A695CD24 - level._id_319544F76C37154B[game["defenders"]];

    level._id_500370E4F476FAA9 = score;
    level._id_319544F76C37154B[game["defenders"]] = level._id_319544F76C37154B[game["defenders"]] + score;
    _id_EC15CE3E7A9D1D86 = _id_CBE00CAA24DA0F0E();
    scripts\mp\gamescore::giveteamscoreforobjective(game["defenders"], score, 0, undefined, 1, _id_EC15CE3E7A9D1D86);

    if(!_id_808D5C4AAFED7F2E(game["attackers"]) && getdvarint("dvar_5AD4B38EB8B556F1", 0))
      level.forcedend = 1;

    level thread scripts\mp\gamelogic::endgame(_id_EC15CE3E7A9D1D86, game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  } else if(team == game["defenders"]) {
    level._id_500370E4F476FAA9 = 50 * level.hostages.size;
    level._id_319544F76C37154B[game["attackers"]] = level._id_319544F76C37154B[game["attackers"]] + level._id_500370E4F476FAA9;
    _id_EC15CE3E7A9D1D86 = _id_CBE00CAA24DA0F0E();
    scripts\mp\gamescore::giveteamscoreforobjective(game["attackers"], level._id_500370E4F476FAA9, 0, undefined, 1, _id_EC15CE3E7A9D1D86);

    if(!_id_808D5C4AAFED7F2E(game["defenders"]) && getdvarint("dvar_5AD4B38EB8B556F1", 0))
      level.forcedend = 1;

    level thread scripts\mp\gamelogic::endgame(_id_EC15CE3E7A9D1D86, game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
  }
}

_id_F6E1C54F449C2C6F(winner, _id_F0500919D8C387B9, nukedetonated) {
  _id_FB257BAFBF772E21 = undefined;

  if(isDefined(level._id_FB257BAFBF772E21))
    _id_FB257BAFBF772E21 = level._id_FB257BAFBF772E21;

  level thread scripts\mp\gamelogic::endgame_regularmp(winner, _id_F0500919D8C387B9, undefined, nukedetonated, level._id_500370E4F476FAA9, _id_FB257BAFBF772E21);
}

_id_E462B877CEDEA7F7(team, score, _id_F0FA3B7B27926553) {
  if(score >= level.winlimit) {
    level.forcedend = 1;
    _id_F6E1C54F449C2C6F(team, game["end_reason"]["score_limit_reached"]);
  }
}

_id_CBE00CAA24DA0F0E() {
  if(level._id_319544F76C37154B["axis"] == level._id_319544F76C37154B["allies"])
    return "tie";

  _id_EC15CE3E7A9D1D86 = scripts\engine\utility::ter_op(level._id_319544F76C37154B["axis"] > level._id_319544F76C37154B["allies"], "axis", "allies");
  return _id_EC15CE3E7A9D1D86;
}

_id_808D5C4AAFED7F2E(team) {
  if(!isDefined(game["roundsPlayed"]))
    return 1;

  if(game["roundsPlayed"] == level.roundlimit - 1)
    return 1;

  if(level.roundlimit == 0)
    return 1;

  _id_79652AF780655345 = level.roundlimit - (game["roundsPlayed"] + 1);
  _id_2F4D10673C0D5578 = floor(float(_id_79652AF780655345) / 2.0);

  if(_id_79652AF780655345 % 2 != 0) {
    if(team == game["attackers"]) {
      _id_D414BA671EB56685 = level._id_D2574C87EE723D10 * (1 + _id_2F4D10673C0D5578) + level._id_974E9F26A695CD24 * _id_2F4D10673C0D5578;

      if(_id_D414BA671EB56685 < game["teamScores"][game["defenders"]])
        return 0;

      return 1;
    }

    _id_D414BA671EB56685 = level._id_974E9F26A695CD24 * (1 + _id_2F4D10673C0D5578) + level._id_D2574C87EE723D10 * _id_2F4D10673C0D5578;

    if(_id_D414BA671EB56685 < game["teamScores"][game["attackers"]])
      return 0;

    return 1;
  } else {
    _id_D414BA671EB56685 = level._id_D2574C87EE723D10 * _id_2F4D10673C0D5578 + level._id_974E9F26A695CD24 * _id_2F4D10673C0D5578;

    if(team == game["attackers"]) {
      if(_id_D414BA671EB56685 < game["teamScores"][game["defenders"]])
        return 0;

      return 1;
    }

    if(_id_D414BA671EB56685 < game["teamScores"][game["attackers"]])
      return 0;

    return 1;
  }
}

_id_DA3DA0004950E970(objective, time) {
  objective notify("pulsing");
  objective endon("pulsing");
  objective endon("death");
  objective endon("gameobject_deleted");
  level endon("game_ended");
  objective scripts\mp\objidpoolmanager::objective_set_pulsate(objective.objidnum, 1);
  wait(time);
  objective scripts\mp\objidpoolmanager::objective_set_pulsate(objective.objidnum, 0);
}

_id_CF8B96B6503D9F31() {
  scripts\mp\codcasterclientmatchdata::_id_0EDBA1EE7C2375A5();
}