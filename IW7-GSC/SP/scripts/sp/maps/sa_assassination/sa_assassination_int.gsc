/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_assassination\sa_assassination_int.gsc
*********************************************************************/

_id_2394() {
  precacheshader("assassination_disguise_overlay");
  precacheitem("iw7_knife_assassin");
  scripts\engine\utility::flag_init("flag_near_keel_relay");
  scripts\engine\utility::flag_init("player_in_keel");
  scripts\engine\utility::flag_init("keel_guy_alerted");
  scripts\engine\utility::flag_init("flag_spawn_doorpeek_enemy");
  scripts\engine\utility::flag_init("flag_near_barracks");
  scripts\engine\utility::flag_init("start_threat_sight_hint");
  scripts\engine\utility::flag_init("flag_stealth_tutorial");
  scripts\engine\utility::flag_init("flag_auto_crouch");
  scripts\engine\utility::flag_init("flag_player_opening_grate");
  scripts\engine\utility::flag_init("flag_being_barracks_objectives");
  scripts\engine\utility::flag_init("flag_player_enters_barracks");
  scripts\engine\utility::flag_init("flag_disguise_objective");
  scripts\engine\utility::flag_init("flag_barracks_hot");
  scripts\engine\utility::flag_init("flag_got_disguise");
  scripts\engine\utility::flag_init("flag_enter_hubstern");
  scripts\engine\utility::flag_init("flag_fade_out");
  scripts\engine\utility::flag_init("flag_fade_in");
  scripts\engine\utility::flag_init("flag_disguise_vo_done");
  scripts\engine\utility::flag_init("flag_helmet_on");
  scripts\engine\utility::flag_init("flag_hub_halfway");
  scripts\engine\utility::flag_init("flag_located_tech_officer");
  scripts\engine\utility::flag_init("flag_tech_officer_spawned");
  scripts\engine\utility::flag_init("flag_mark_tech_officer");
  scripts\engine\utility::flag_init("flag_kill_tech_officer");
  scripts\engine\utility::flag_init("flag_tech_officer_killed");
  scripts\engine\utility::flag_init("flag_hub_bow");
  scripts\engine\utility::flag_init("flag_hub_bow_conv2");
  scripts\engine\utility::flag_init("flag_in_ordinance");
  scripts\engine\utility::flag_init("flag_in_hubbow");
  scripts\engine\utility::flag_init("flag_in_conf_halls");
  scripts\engine\utility::flag_init("flag_armory_conv2");
  scripts\engine\utility::flag_init("flag_boxer_wakeup");
  scripts\engine\utility::flag_init("flag_in_armory");
  scripts\engine\utility::flag_init("flag_near_conference");
  scripts\engine\utility::flag_init("flag_handscanner_used");
  scripts\engine\utility::flag_init("flag_in_conference");
  scripts\engine\utility::flag_init("flag_conference_center_obj");
  scripts\engine\utility::flag_init("flag_plant_gas_event");
  scripts\engine\utility::flag_init("flag_gas_objective_start");
  scripts\engine\utility::flag_init("flag_commanders_killed");
  scripts\engine\utility::flag_init("flag_kill_commanders_event2");
  scripts\engine\utility::flag_init("a_commander_dead");
  scripts\engine\utility::flag_init("commanders_alerted");
  scripts\engine\utility::flag_init("flag_conference_room_hot");
  scripts\engine\utility::flag_init("flag_gas_venting");
  scripts\engine\utility::flag_init("sa_barracks_vol_cleared");
  scripts\engine\utility::flag_init("flag_post_gas_enemies_killed");
  scripts\engine\utility::flag_init("flag_hand_bink");
  scripts\engine\utility::flag_init("flag_hand_bink_end");
  scripts\engine\utility::flag_init("flag_player_in_rafters");
  scripts\engine\utility::flag_init("flag_access_rafters");
  scripts\engine\utility::flag_init("flag_player_down_rafters");
  scripts\engine\utility::flag_init("flag_conference_room_gas_hot");
  scripts\engine\utility::flag_init("flag_setup_hvac_use");
  scripts\engine\utility::flag_init("flag_all_reacting_grunts_spawned");
  scripts\engine\utility::flag_init("flag_grunts_react_gas_vo_done");
  scripts\engine\utility::flag_init("flag_conf_cursor_triggered");
  scripts\engine\utility::flag_init("flag_gren_pin_pulled");
  scripts\engine\utility::flag_init("flag_clear_hubbow");
  scripts\engine\utility::flag_init("flag_conf_gun1_recall");
  scripts\engine\utility::flag_init("flag_conf_gun2_recall");
  scripts\engine\utility::flag_init("flag_conf_gun3_recall");
  scripts\engine\utility::flag_init("flag_player_in_server");
  scripts\engine\utility::flag_init("flag_salter_exfil_vo");
  scripts\engine\utility::flag_init("flag_salter_spawned");
  scripts\engine\utility::flag_init("flag_salter_exfil_enemies2");
  scripts\engine\utility::flag_init("flag_commander_combat");
  scripts\engine\utility::flag_init("flag_salter_meetup_moment");
  scripts\engine\utility::flag_init("death_salter_enemies");
  scripts\engine\utility::flag_init("flag_at_sdf_meetup");
  scripts\engine\utility::flag_init("flag_exfil_salter_airlock");
  scripts\engine\utility::flag_init("flag_exfil_near_airlock");
  scripts\engine\utility::flag_init("flag_at_salter");
  scripts\engine\utility::flag_init("flag_to_salter_hot");
  scripts\engine\utility::flag_init("flag_rescued_salter");
  scripts\engine\utility::flag_init("flag_red_alert");
  scripts\engine\utility::flag_init("flag_exfil_hallway_combat");
  scripts\engine\utility::flag_init("flag_post_gas_enemies1");
  scripts\engine\utility::flag_init("flag_hubbow_post_gas");
  scripts\engine\utility::flag_init("flag_hubbow_post_gas_runners");
  scripts\engine\utility::flag_init("flag_hubbow_post_gas_1");
  scripts\engine\utility::flag_init("flag_hubbow_post_gas_2");
  scripts\engine\utility::flag_init("flag_hubbow_post_gas_3");
  scripts\engine\utility::flag_init("flag_salter_exfil_enemies1");
  scripts\engine\utility::flag_init("flag_assist_salter_complete");
  scripts\engine\utility::flag_init("death_post_gas_enemies1");
  scripts\engine\utility::flag_init("death_post_gas_enemies2");
  scripts\engine\utility::flag_init("flag_airlock_escape");
}

_id_8936(var_0) {
  switch (var_0) {
    case "int_start":
      _id_A567();
      _id_2828();
      _id_A61C();
      _id_451A();
      assignvehicleminimumsforvolume();
      _id_6706();
      break;
    case "get_disguise":
      _id_2828();
      _id_A61C();
      _id_451A();
      assignvehicleminimumsforvolume();
      _id_6706();
      break;
    case "got_disguise":
      _id_A61C();
      _id_451A();
      assignvehicleminimumsforvolume();
      _id_6706();
      break;
    case "conference_room":
      _id_451A();
      assignvehicleminimumsforvolume();
      _id_6706();
      break;
    case "assist":
      assignvehicleminimumsforvolume();
      _id_6706();
      break;
    case "escape":
      _id_6706();
      break;
  }
}

_id_A567() {
  thread _id_A565();
  thread _id_13288();
  thread _id_D04E();
  _id_A56B();
  thread _id_88C1();
  scripts\engine\utility::flag_wait("flag_being_barracks_objectives");
  thread scripts\sp\utility::_id_2679();
}

_id_2828() {
  var_0 = getEnt("obj_disguise", "targetname");
  var_1 = scripts\sp\utility::_id_C264("DISGUISE");
  objective_add(var_1, "current", &"SA_ASSASSINATION_ACQUIRE_SDF_DISGUISE");
  scripts\engine\utility::flag_wait("flag_disguise_objective");
  _id_0F16::_id_C278(var_1);
  thread _id_88D5(var_1);
  scripts\engine\utility::flag_wait("flag_got_disguise");
  thread scripts\sp\utility::_id_2679();
  thread _id_0F16::_id_88EC();
  level._id_DBBE = getEntArray("missile_racks", "targetname");
  scripts\engine\utility::array_thread(level._id_DBBE, _id_0EFC::_id_F9D7);
  thread _id_F02B();
  thread _id_6615();
  wait 1.5;
  level._id_E99E["trig_barracks_door_exit"] _id_0F05::_id_12BD3(1);
}

_id_A61C() {
  scripts\engine\utility::flag_wait("flag_kill_tech_officer");
  thread _id_21CA();
  thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_8951("flag_in_ordinance", "hub_stern");
  var_0 = getEnt("obj_assassinate_tech_officer", "targetname");
  thread _id_0F16::_id_2635(var_0, undefined, "sa_armory_start");
  level._id_E99E["trig_armory_door_exit"] _id_0F05::_id_AED6(0);
  var_1 = scripts\sp\utility::_id_C264("OBJ_TECH_KILL");
  objective_add(var_1, "current", &"SA_ASSASSINATION_ACQUIRE_TECH_OFFICERS");
  scripts\engine\utility::flag_wait_all("flag_tech_officer_spawned", "flag_in_armory");
  thread _id_6606();
  scripts\engine\utility::flag_wait("flag_mark_tech_officer");
  level._id_115F7 scripts\sp\utility::_id_9196(5, 0, 0);
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(level._id_115F7, "tag_origin", (0, 0, 82), (0, 0, 0));
  objective_onentity(var_1, var_0);
  objective_setpointertextoverride(var_1, &"SA_ASSASSINATION_TECH_OFFICER");
  _func_2F7(var_1, 0);
  _func_2E9(var_1, 1);
  scripts\engine\utility::flag_wait("flag_tech_officer_killed");
  objective_onentity(var_1, level._id_3A1C);
  objective_setpointertextoverride(var_1, &"SA_ASSASSINATION_CREDENTIALS");
  scripts\engine\utility::flag_wait("captain_key_card_picked_up");
  level.player playSound("intelligence_pickup");
  scripts\sp\utility::_id_C27C(var_1);
  thread scripts\sp\utility::_id_2679();
}

_id_451A() {
  thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_8951("flag_hub_bow", "armory");
  thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_8951("flag_near_conference", "hub_bow");
  thread _id_88C7();
  var_0 = scripts\engine\utility::getStruct("use_handscanner_conf", "targetname");
  thread _id_0F16::_id_2635(var_0, undefined, "sac_bowupper_start");
  thread _id_661B();
  var_0 = scripts\engine\utility::getStruct("use_handscanner_conf", "targetname");
  objective_add(scripts\sp\utility::_id_C264("BYPASS_SECURITY_TERMINAL"), "current", &"SA_ASSASSINATION_ACCESS_CONFERENCE_CENTER");
  scripts\engine\utility::flag_wait("flag_near_conference");
  objective_position(scripts\sp\utility::_id_C264("BYPASS_SECURITY_TERMINAL"), var_0.origin);
  _id_0F16::_id_C278(scripts\sp\utility::_id_C264("BYPASS_SECURITY_TERMINAL"));
  scripts\engine\utility::flag_wait("sa_bowupper_roomb_start");

  if(isDefined(level._id_DBBE))
    scripts\engine\utility::array_thread(level._id_DBBE, _id_0EFC::_id_4097);

  thread scripts\sp\utility::_id_2679();
  var_1 = scripts\sp\utility::_id_C264("KILL_COMMANDERS");
  objective_add(var_1, "current", &"SA_ASSASSINATION_KILL_SDF_COMMANDERS");
  thread _id_C266(var_1);
  _id_0F16::_id_C278(var_1);
  thread _id_894B(var_1);
  scripts\engine\utility::flag_wait("flag_commanders_killed");
}

_id_894B(var_0) {
  level endon("gone_hot");
  var_1 = scripts\engine\utility::getStruct("obj_rafters", "targetname");
  objective_position(var_0, var_1.origin);
  scripts\engine\utility::flag_wait("flag_access_rafters");
  var_2 = scripts\engine\utility::getStruct("trig_plant_gas", "targetname");
  objective_position(var_0, var_2.origin);
  scripts\engine\utility::flag_wait("flag_plant_gas_event");
  var_3 = scripts\engine\utility::getStruct("obj_kill_comm2", "targetname");
  objective_position(var_0, var_3.origin);
}

_id_C266(var_0) {
  scripts\engine\utility::flag_wait("flag_commanders_killed");
  scripts\sp\utility::_id_C27C(var_0);
}

_id_661B() {
  scripts\engine\utility::flag_wait("flag_hub_bow");
  thread _id_1D8A();
  thread _id_1D8B();
  level._id_E99E["hub_bow_exit_door"] _id_0F05::_id_AED6(0);

  if(!scripts\engine\utility::flag("ship_in_lockdown")) {
    scripts\sp\utility::_id_10350("asn_slt_sofarsogood");
    wait 1;
    scripts\sp\utility::_id_10350("asn_slt_temptingtogohot");
    wait 0.5;
    level.player scripts\sp\utility::_id_1034D("asn_plr_affirmative");
    wait 0.5;
    scripts\sp\utility::_id_10350("asn_slt_dontdoit");
  }
}

_id_1D8A() {
  level endon("ship_in_lockdown");
  level endon("cleaned_up_sa_hubbow_vol");
  wait 3;
  var_0 = getEnt("hub_bow_conv1_vol", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_77E3();

  for(;;) {
    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_ijustreadthe");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_thatsthesecondtime");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_thereporttestifiesthat");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_earlyearthhowearly");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_oldenoughthatthe");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_couldhavebeenone");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_theyranthesignal");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_whatthehellhappened");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_theemergencytransmissionfrom");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_whatdidtheydo");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_theyplayeditmusic");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_thelegionsheardthe");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_theywerebroadcastship");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_whatdidhighcommand");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_thevalliswasordered");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_asamatterof");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_butvallisdidntarrive");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_theymusthavedefected");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_thatsthepointof");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_youareanimbecile");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_iamcarefulto");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_ifthereisdefection");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_youdonotdecide");

    scripts\engine\utility::waitframe();
  }
}

_id_1D8B() {
  level endon("ship_in_lockdown");
  level endon("cleaned_up_sa_hubbow_vol");
  scripts\engine\utility::flag_wait("flag_hub_bow_conv2");
  var_0 = getEnt("hub_bow_conv2_vol", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_77E3();

  for(;;) {
    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_hasnegretecheckedin");

    wait 1;

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_noisentthe");

    wait 1;

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_imlookingitup");

    wait 1;

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_sendhavillsteamto");

    wait 1;

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_copythat42462out");

    wait(randomintrange(17, 25));
  }
}

_id_1D8E() {
  level endon("ship_in_lockdown");
  var_0 = getEnt("pre_conf_conv1_vol", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_77E3();

  for(;;) {
    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf3_hasthemeetingstarted");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_ithinksoi");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_yeskashiksaidtheyve");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf3_whyhavewenot");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_aftertheconferencefurther");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf3_butwhymeethere");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_therecouldbereconnaissance");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf3_therehavebeencounterattacks");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_lowerrankingguardsmanwanting");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf3_theearthbornhave");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_manyinthelegions");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf3_youreclaimingthecouncil");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_lowerrankingguardsmanwanting");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_ididntsaythey");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf3_youcanfinishthe");

    scripts\engine\utility::waitframe();
  }
}

assignvehicleminimumsforvolume() {
  var_0 = scripts\sp\utility::_id_C264("ESCAPE_SHIP");
  objective_add(var_0, "current", &"SA_ASSASSINATION_ESCAPE_SHIP");
  thread _id_C292(var_0);
  level._id_E99E["hub_bow_exit_door"] _id_0F05::_id_12BD3(1);
  level._id_E99E["trig_door_to_conf_hall"] _id_0F05::_id_12BD3(1);
  var_1 = scripts\engine\utility::getStruct("sa02_hub_chaos", "targetname");
  thread _id_0F16::_id_2635(var_1, undefined, "flag_hubbow_post_gas");
  scripts\engine\utility::flag_wait("flag_salter_spawned");
  scripts\engine\utility::flag_wait("flag_rescued_salter");
}

_id_C292(var_0) {
  scripts\engine\utility::flag_wait("flag_move_on_to_salter");
  thread _id_6E3C();

  if(isDefined(level._id_9126) && isalive(level._id_9126)) {
    var_1 = scripts\engine\utility::spawn_tag_origin();
    var_1 linkTo(level._id_9126, "tag_origin", (0, 0, 60), (0, 0, 0));
    objective_onentity(var_0, var_1);
    objective_setpointertextoverride(var_0, &"SA_ASSASSINATION_FOLLOW");
    _id_0F16::_id_C278(var_0);
    level._id_9126 scripts\engine\utility::waittill_any("death", "near_salter");
  }

  var_2 = scripts\engine\utility::getStruct("sa02_salter_obj", "targetname");
  thread _id_0F16::_id_2635(level._id_EA2C, undefined, "flag_assist_salter_complete");
}

_id_6E3C() {
  scripts\engine\utility::flag_wait("flag_near_salter");
  level notify("near_salter");
}

_id_6706() {
  var_0 = scripts\engine\utility::getStruct("sa02_escape_obj", "targetname");
  thread _id_0F16::_id_2635(var_0, "sa02_escape_obj", "flag_airlock_escape");
  objective_onentity(scripts\sp\utility::_id_C264("ESCAPE_SHIP"), level._id_EA2C, (0, 0, 60));
  objective_setpointertextoverride(scripts\sp\utility::_id_C264("ESCAPE_SHIP"), &"SA_ASSASSINATION_SUPPORT");
  objective_current(scripts\sp\utility::_id_C264("ESCAPE_SHIP"));
  _id_0F16::_id_C278(scripts\sp\utility::_id_C264("ESCAPE_SHIP"));
}

_id_13288() {
  var_0 = getEnt("vent_crouch", "targetname");
  var_0 waittill("trigger");
  level.player setstance("crouch");
  thread _id_13288();
}

_id_A565() {
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_1086E("keel_guy", ::_id_F9B9);
  level waittill("door_peek_start");
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C1(1);
  var_0 = getspawner("keel_guy", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1, 0);
  thread _id_117C8(var_1);
}

_id_F9B9() {
  thread cleanup_keel_guy();
  self._id_1FBB = "generic";
  scripts\sp\utility::_id_F2A8(1);
  thread _id_0E45::_id_F309("context_melee_kill_02_back");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 thread scripts\sp\anim::_id_1EEA(self, "keel_repair_guy", "stop_loop");
  level scripts\engine\utility::waittill_either("door_peek_bash_open", "door_peek_kick");
  self notify("stealth_alerted");
}

cleanup_keel_guy() {
  self endon("death");
  scripts\engine\utility::flag_wait("flag_player_opening_grate");
  self delete();
}

_id_A56B() {
  wait 8;
  level._id_EA2C scripts\sp\utility::_id_10346("asn_slt_thekeelrelayis");
  level.player thread scripts\sp\utility::_id_1034D("asn_plr_check");
  scripts\engine\utility::flag_wait("flag_got_gas_device");
}

_id_BE35() {
  var_0 = [];
  var_0[var_0.size] = "asn_slt_getmoving";
  var_0[var_0.size] = "This will take me a while, get to the barracks.";

  for(;;) {
    if(scripts\engine\utility::flag("player_in_keel")) {
      var_1 = scripts\engine\utility::array_randomize(var_0);
      wait 5;
      thread scripts\sp\utility::_id_16C5("SALTER", var_1[0], "yellow");
      wait 2;
    }

    wait 0.5;
  }
}

_id_E082() {
  var_0 = level.player getweaponslist("primary");
  level.player takeweapon(var_0[1]);
}

_id_5D18(var_0) {
  var_1 = var_0 scripts\engine\utility::waittill_any_return("death", "start_context_melee", "stealth_override_goal");
  self unlink();
  self physicslaunchserver(self.origin, (0, 0, 0));
}

_id_F8C7() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "barracks_guy1") {
    var_0 = spawnStruct();
    var_0.pos = scripts\engine\utility::getStruct("struct_barracks_panel", "targetname");
    level._id_2822 = self;
    var_0._id_872A = self;
    var_0._id_872A._id_1FBB = "generic";
    var_0._id_872A._id_4592 = 1;
    var_0._id_872A._id_4591 = self.origin;
    var_0._id_872A scripts\sp\utility::_id_B14F(1);
    var_0._id_872A scripts\sp\utility::_id_F2DA(0);
    var_0._id_872A scripts\sp\utility::_id_5564();
    var_0._id_872A scripts\sp\utility::_id_2011(1);
    var_0._id_2760 = scripts\sp\utility::_id_10639("prop_duffle", var_0.pos.origin, var_0.pos.angles);
    var_0.joint1 = scripts\sp\utility::_id_10639("j_prop_barracks_guy1", var_0.pos.origin, var_0.pos.angles);
    var_0.joint1._id_1FBB = "j_prop_barracks_guy1";
    var_0._id_2760 linkTo(var_0.joint1, "J_prop_1", (0, 0, 0), (0, 0, 0));
    var_0._id_872A thread _id_7373(var_0);
    var_0._id_DD29 = "guy1_barracks_kill_react";
    var_0._id_B036 = "guy1_barracks_kill_loop";
    var_0._id_1684 = [];
    var_0._id_1684[var_0._id_1684.size] = var_0.joint1;
    var_0._id_1684[var_0._id_1684.size] = var_0._id_872A;
    var_0.pos thread scripts\sp\anim::_id_1EE7(var_0._id_1684, var_0._id_B036);
    var_0._id_872A thread scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132D5();
    var_0._id_872A thread _id_0E45::_id_F309("guy1_barracks_kill");
    var_0._id_872A._id_4591 = var_0.pos.origin;
    var_0._id_872A._id_4583 = var_0.pos.angles;
    var_0._id_872A thread _id_88B1(var_0);
    wait 0.05;
    var_0._id_872A scripts\sp\utility::_id_65E1("stealth_hold_position");
    var_0._id_872A scripts\engine\utility::waittill_either("stealth_alertlevel_change", "death");
    wait 0.75;
    waittillframeend;

    if(isDefined(var_0._id_872A) && isalive(var_0._id_872A) && !scripts\engine\utility::is_true(var_0._id_872A._id_939E)) {
      var_0._id_872A._id_4591 = undefined;
      var_0._id_872A._id_4583 = undefined;
      var_0._id_872A _id_0E45::_id_F309(undefined, undefined);
    }
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "barracks_guy2") {
    var_0 = spawnStruct();
    var_1 = scripts\engine\utility::getStruct("struct_barracks_panel", "targetname");
    var_0.pos = spawnStruct();
    var_0.pos.origin = var_1.origin;
    var_0.pos.angles = var_1.angles;
    level._id_2823 = self;
    var_0._id_872A = self;
    var_0._id_872A._id_1FBB = "barracks_guy2";
    var_0._id_872A._id_10E6D._id_4C96 = 1;
    var_0._id_872A thread _id_1D79();
    var_0._id_872A scripts\sp\utility::_id_72EC("iw7_sdfar", "primary");
    var_0._id_872A scripts\sp\utility::_id_86E4();
    var_0._id_872A scripts\sp\utility::_id_B14F(1);
    var_0._id_872A scripts\sp\utility::_id_F2DA(0);
    var_0._id_872A scripts\sp\utility::_id_5564();
    var_0._id_872A scripts\sp\utility::_id_2011(1);
    var_0.weight = scripts\sp\utility::_id_10639("prop_weight", var_0.pos.origin, var_0.pos.angles);
    var_0.gun = scripts\sp\utility::_id_10639("prop_gun", var_0.pos.origin, var_0.pos.angles);
    var_0.joint1 = scripts\sp\utility::_id_10639("guy2_weight", var_0.pos.origin, var_0.pos.angles);
    var_0.joint1._id_1FBB = "guy2_weight";
    var_0.weight linkTo(var_0.joint1, "J_prop_1", (0, 0, 0), (0, 0, 0));
    var_0.gun linkTo(var_0.joint1, "J_prop_2", (0, 0, 0), (0, 0, 0));
    var_0.weight thread _id_5D18(self);
    var_0._id_B036 = "guy2_lifting_loop";
    var_0._id_DD29 = "guy2_lifting_react";
    var_0.death = "guy2_lifting_death";
    var_0._id_1684 = [];
    var_0._id_1684[var_0._id_1684.size] = var_0.joint1;
    var_0._id_1684[var_0._id_1684.size] = var_0._id_872A;
    var_0.pos thread scripts\sp\anim::_id_1EE7(var_0._id_1684, var_0._id_B036);
    var_0._id_872A thread _id_0E45::_id_F309("melee_neck_snap");
    var_0._id_872A thread _id_88B1(var_0);
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "barracks_guy3")
    thread _id_88D6();
}

#using_animtree("generic_human");

_id_88D6() {
  self endon("damage");
  var_0 = spawnStruct();
  var_1 = scripts\engine\utility::getStruct("struct_barracks_panel", "targetname");
  var_0.pos = spawnStruct();
  var_0.pos.origin = var_1.origin;
  var_0.pos.angles = var_1.angles;
  level._id_2824 = self;
  var_0._id_872A = self;
  var_0._id_872A._id_1FBB = "barracks_guy3";
  var_0._id_872A._id_10E6D._id_4C96 = 1;
  var_0._id_872A thread _id_1D79();
  var_0._id_872A scripts\sp\utility::_id_F2A8(1);
  var_0._id_872A scripts\sp\utility::_id_F2DA(0);
  var_0._id_872A scripts\sp\utility::_id_2011(1);
  var_0._id_872A thread _id_F5B3();
  var_0._id_872A thread _id_0E45::_id_F309("context_melee_kill_02_back");
  var_0._id_AF03 = scripts\sp\utility::_id_10639("prop_locker");
  var_0.joint1 = scripts\sp\utility::_id_10639("j_prop_locker", var_0.pos.origin, var_0.pos.angles);
  var_0.joint1._id_1FBB = "j_prop_locker";
  var_0._id_AF03 linkTo(var_0.joint1, "J_prop_2", (0, 0, 0), (0, 0, 0));
  var_0.start = "guy3_barracks_kill";
  var_0._id_B036 = "guy3_barracks_kill_loop";
  var_0._id_DD29 = "guy3_barracks_kill_react";
  var_0.death = "guy3_barracks_kill_death";
  var_0._id_1684 = [];
  var_0._id_1684[var_0._id_1684.size] = var_0.joint1;
  var_0._id_1684[var_0._id_1684.size] = var_0._id_872A;
  var_0.pos thread scripts\sp\anim::_id_1F2C(var_0._id_1684, var_0.start);
  var_2 = getanimlength(%sa_assassin_enter_barracks_sdf_start);
  wait(var_2);

  if(isDefined(self) && isalive(self))
    thread _id_88D7(var_0);
}

_id_F5B3() {
  scripts\sp\utility::_id_65E0("ent_stealth_alert");
  self waittill("stealth_react");
  scripts\sp\utility::_id_65E1("ent_stealth_alert");
}

_id_88D7(var_0) {
  self endon("damage");

  if(!scripts\sp\utility::_id_65DB("ent_stealth_alert")) {
    var_0.pos thread scripts\sp\anim::_id_1EEA(var_0._id_872A, var_0._id_B036);
    var_0._id_872A scripts\sp\utility::_id_F2A8(0);
    var_0._id_872A scripts\sp\utility::_id_B14F(1);
    var_0._id_872A scripts\sp\utility::_id_5564();
    var_0._id_872A thread _id_88B1(var_0);
  }
}

_id_88B1(var_0) {
  var_1 = scripts\engine\utility::waittill_any_return("damage", "death", "stealth_react");

  switch (var_1) {
    case "stealth_react":
      level notify("stealth_react");

      if(isDefined(self.script_noteworthy) && self.script_noteworthy == "barracks_guy1") {
        _id_F8BB(var_0, "react");
        break;
      }

      if(isDefined(self.script_noteworthy) && self.script_noteworthy == "barracks_guy2") {
        _id_F8BB(var_0, "react");
        break;
      }

      if(isDefined(self.script_noteworthy) && self.script_noteworthy == "barracks_guy3") {
        scripts\sp\utility::_id_65E1("ent_stealth_alert");
        _id_F8BB(var_0, "react");
        break;
      }

      break;
    case "damage":
      if(isDefined(self.script_noteworthy) && self.script_noteworthy == "barracks_guy1") {
        _id_F8BB(var_0, "death");
        break;
      }

      if(isDefined(self.script_noteworthy) && self.script_noteworthy == "barracks_guy2") {
        _id_F8BB(var_0, "death");
        break;
      }

      if(isDefined(self.script_noteworthy) && self.script_noteworthy == "barracks_guy3") {
        _id_F8BB(var_0, "death");
        break;
      }

      break;
  }
}

_id_F8BB(var_0, var_1) {
  switch (var_1) {
    case "death":
      var_0._id_872A notify("fake_death");
      var_0.pos notify("stop_loop");
      var_0._id_872A._id_10265 = 1;
      var_0._id_872A.a.nodeath = 1;
      var_0._id_872A scripts\sp\utility::anim_stopanimScripted();
      var_0._id_872A scripts\sp\utility::_id_65DD("stealth_enabled");
      var_0._id_872A stopsounds();
      waittillframeend;

      switch (var_0._id_872A.script_noteworthy) {
        case "barracks_guy1":
          var_0._id_872A scripts\sp\utility::_id_1101B();
          var_0._id_872A._id_10265 = undefined;
          var_0._id_872A.a.nodeath = 0;
          var_0._id_872A _meth_81D0(var_0._id_872A.origin, level.player);
          scripts\engine\utility::flag_set("custom_barracks_death1");
          break;
        case "barracks_guy2":
          var_0.pos thread scripts\sp\anim::_id_1F35(var_0.joint1, var_0.death);
          var_0._id_872A._id_BFE4 = 1;
          var_0.pos scripts\sp\anim::_id_1F35(var_0._id_872A, var_0.death);
          var_0.pos scripts\sp\anim::_id_1EE0(var_0._id_872A, var_0.death);
          var_0._id_872A scripts\sp\utility::_id_1101B();
          var_0._id_872A.team = "neutral";
          var_0._id_872A scripts\anim\death::_id_58CB();
          var_0._id_872A.health = 1;
          var_0._id_872A scripts\sp\utility::_id_54C6();
          scripts\engine\utility::flag_set("custom_barracks_death2");
          break;
        case "barracks_guy3":
          if(!scripts\sp\utility::_id_65DB("ent_stealth_alert")) {
            var_0._id_872A._id_BFE4 = 1;
            var_0.pos scripts\sp\anim::_id_1F35(var_0._id_872A, var_0.death);
            var_0.pos scripts\sp\anim::_id_1EE0(var_0._id_872A, var_0.death);
            var_0._id_872A scripts\sp\utility::_id_1101B();
            var_0._id_872A _meth_81D0(var_0._id_872A.origin, level.player);
            scripts\engine\utility::flag_set("custom_barracks_death3");
            break;
          }

          if(scripts\sp\utility::_id_65DB("ent_stealth_alert"))
            var_0._id_872A scripts\sp\utility::_id_1101B();
      }

      break;
    case "react":
      var_0._id_872A._id_E014 = 1;
      var_0._id_872A scripts\sp\utility::_id_1101B();
      var_0._id_872A scripts\sp\utility::_id_F2A8(1);
      var_0._id_872A stopsounds();

      switch (var_0._id_872A.script_noteworthy) {
        case "barracks_guy1":
          var_0.pos thread scripts\sp\anim::_id_1F35(var_0._id_872A, var_0._id_DD29);
          break;
        case "barracks_guy2":
          var_0.pos thread scripts\sp\anim::_id_1F2C(var_0._id_1684, var_0._id_DD29);
          var_0._id_872A thread drop_gun_on_death(var_0.gun);
          var_0._id_872A waittillmatch("single anim", "end");
          var_0.gun delete();
          var_0._id_872A scripts\sp\utility::_id_86E2();
          var_0._id_872A notify("live_ai");
          break;
        case "barracks_guy3":
          var_0.pos thread scripts\sp\anim::_id_1F35(var_0._id_872A, var_0._id_DD29);
          var_0._id_872A scripts\sp\utility::_id_F2A8(1);
          break;
      }

      var_0._id_872A scripts\sp\utility::_id_6224();
      break;
  }
}

drop_gun_on_death(var_0) {
  self endon("live_ai");
  self waittill("death");

  if(isDefined(var_0)) {
    var_0 unlink();
    var_0 physicslaunchserver(var_0.origin, (0, 0, 0));
  }
}

_id_896E(var_0) {
  self waittill("death");
  var_0.pos thread scripts\sp\anim::_id_1F35(var_0.joint1, var_0.death);
}

#using_animtree("script_model");

_id_7373(var_0) {
  scripts\engine\utility::waittill_any("damage", "death", "stealth_react");
  var_0.joint1 _meth_82B1(%sa_assassin_barrack_kills_loop_sdf01_bag, 0);
}

_id_D04E() {
  scripts\engine\utility::array_thread(getspawnerarray("barracks_guys"), scripts\sp\utility::_id_1747, ::_id_F8C7);
  var_0 = scripts\engine\utility::getStruct("trig_barracks_grate", "targetname");
  var_0 _id_0E46::_id_48C4(undefined, undefined, undefined, undefined, 256, 75, 1);
  var_0 waittill("trigger");
  scripts\engine\utility::flag_set("flag_player_opening_grate");
  setsaveddvar("cg_drawPlayerShadow", 1);
  level.player thread scripts\sp\utility::_id_1034D("asn_plr_saltimatthe");
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_EA4C();
  level._id_2825 = scripts\sp\utility::_id_22CD("barracks_guys", 1);
  level.player thread _id_0F24::_id_1DD2();
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_D85C();
  var_1 = spawnStruct();
  var_1.pos = scripts\engine\utility::getStruct("struct_barracks_panel", "targetname");
  var_1._id_84BD = getEnt("barracks_grate", "targetname");
  var_1._id_D267 = scripts\sp\utility::_id_10639("player_rig", var_1.pos.origin, var_1.pos.angles);
  var_1._id_D267 hide();
  var_1.joint1 = scripts\sp\utility::_id_10639("j_prop_barracks", var_1.pos.origin, var_1.pos.angles);
  var_1.joint1._id_1FBB = "j_prop_barracks";
  var_1._id_84BD linkTo(var_1.joint1, "J_prop_1", (0, 0, 0), (0, 0, 0));
  var_1.pos scripts\sp\anim::_id_1EC3(var_1._id_D267, "player_enter_barracks");
  var_1.pos scripts\sp\anim::_id_1EC3(var_1.joint1, "jprop_enter_barracks");
  level.player _meth_823C(var_1._id_D267, "tag_player", 0.5, 0.25);
  wait 0.5;
  level.player playerlinktodelta(var_1._id_D267, "tag_player", 1, 0, 0, 0, 0, 1);
  var_1._id_D267 show();
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_6607();
  _id_E082();
  level.player giveweapon("iw7_knife_assassin");
  level.player switchtoweapon("iw7_knife_assassin");
  var_1.pos thread scripts\sp\anim::_id_1F35(var_1._id_D267, "player_enter_barracks");
  var_1.pos thread scripts\sp\anim::_id_1F35(var_1.joint1, "jprop_enter_barracks");
  var_1._id_D267 waittillmatch("single anim", "end");
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C8(0);
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_DF3E();
  var_1._id_D267 delete();
  var_2 = getEnt("enter_barracks_clip", "targetname");
  var_2 delete();
  level._id_E99E["trig_barracks_door_exit"] _id_0F05::_id_AED6(0);
}

_id_1D79() {
  self endon("death");
  self endon("stealth_react");
  self endon("fake_death");
  wait 2.5;

  if(self.script_noteworthy == "barracks_guy2") {
    level._id_2823 scripts\sp\utility::_id_10346("asn_sdf2_haveyouseenthe");
    level notify("barracks_vo_cont");
  }

  if(self.script_noteworthy == "barracks_guy3") {
    level waittill("barracks_vo_cont");
    wait(randomfloatrange(0.85, 1.35));
    level._id_2824 scripts\sp\utility::_id_10346("asn_sdf3_overthebattlecast");
    level notify("barracks_vo_cont");
  }

  if(self.script_noteworthy == "barracks_guy2") {
    level waittill("barracks_vo_cont");
    wait(randomfloatrange(0.85, 1.35));
    level._id_2823 scripts\sp\utility::_id_10346("asn_sdf2_icariuswillbedeployed");
    level notify("barracks_vo_cont");
  }

  if(self.script_noteworthy == "barracks_guy3") {
    level waittill("barracks_vo_cont");
    wait(randomfloatrange(0.85, 1.35));
    level._id_2824 scripts\sp\utility::_id_10346("asn_sdf3_haveyoubeenbriefed");
    level notify("barracks_vo_cont");
  }

  if(self.script_noteworthy == "barracks_guy2") {
    level waittill("barracks_vo_cont");
    wait(randomfloatrange(0.85, 1.35));
    level._id_2823 scripts\sp\utility::_id_10346("asn_sdf2_thecouncilhaschosen");
    level notify("barracks_vo_cont");
  }

  if(self.script_noteworthy == "barracks_guy3") {
    level waittill("barracks_vo_cont");
    wait(randomfloatrange(0.85, 1.35));
    level._id_2824 scripts\sp\utility::_id_10346("asn_sdf3_ivepreparedmywhole");
    level notify("barracks_vo_cont");
  }

  if(self.script_noteworthy == "barracks_guy2") {
    level waittill("barracks_vo_cont");
    wait(randomfloatrange(0.85, 1.35));
    level._id_2823 scripts\sp\utility::_id_10346("asn_sdf2_yesregrettableifthe");
    level notify("barracks_vo_cont");
  }

  if(self.script_noteworthy == "barracks_guy3") {
    level waittill("barracks_vo_cont");
    wait(randomfloatrange(0.85, 1.35));
    level._id_2824 scripts\sp\utility::_id_10346("asn_sdf3_marsaeternum");
    level notify("barracks_vo_cont");
  }
}

_id_117C8(var_0) {
  wait 3.25;
  var_1 = scripts\engine\utility::getStruct("threat_sight_hint_struct", "targetname");
  scripts\sp\utility::_id_56BE("threat_meter", 6.0);
  var_2 = 0;

  while(isalive(var_0) && isalive(var_0)) {
    level.player thread _id_0F26::_id_117C4(var_1.origin, var_2);
    wait 0.05;
    var_2 = var_2 + 0.01;

    if(var_2 >= 1.0) {
      break;
    }
  }

  wait 0.5;
  level.player thread _id_0F26::_id_117C4(var_1.origin, 0);
}

_id_88C1() {
  scripts\engine\utility::flag_wait_all("custom_barracks_death1", "custom_barracks_death2", "custom_barracks_death3");
  wait 0.5;

  foreach(var_1 in level._id_2825) {
    if(isDefined(var_1) && isalive(var_1) && var_1.script_noteworthy != "barracks_guy2")
      var_1 scripts\sp\utility::_id_54C6();
  }

  wait 0.5;
  level.player scripts\sp\utility::_id_1034D("asn_plr_barracksclear");
  level.player thread _id_0F24::_id_1DD3();
  scripts\engine\utility::flag_set("flag_disguise_objective");
  thread _id_793F();
  scripts\sp\utility::_id_10350("asn_slt_enemycommsarequiet");
  wait 0.5;
  level.player scripts\sp\utility::_id_1034D("asn_plr_letskeepitthat");
}

_id_793F() {
  level endon("got_disguise");
  wait 10;
  scripts\sp\utility::_id_10350("asn_slt_youshouldbe");
  wait 10;
  scripts\sp\utility::_id_10350("asn_slt_shouldbefatiguesnearby");
  wait 12;
  scripts\sp\utility::_id_10350("asn_slt_youshouldbe");
  wait 20;
  scripts\sp\utility::_id_10350("asn_slt_shouldbefatiguesnearby");
}

_id_88D5(var_0) {
  var_1 = scripts\engine\utility::getStruct("trig_use_disguise", "targetname");
  var_1 _id_0E46::_id_48C4(undefined, undefined, &"SA_ASSASSINATION_DISGUISE", undefined, 256, 75, 1);
  var_1 _id_0E46::_id_9016();
  level notify("got_disguise");
  setsaveddvar("cg_drawPlayerShadow", 0);
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_DB2A();
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("DISGUISE"));
  objective_state(scripts\sp\utility::_id_C264("DISGUISE"), "invisible");
  thread _id_C1A0();
  thread _id_C19F();
  thread _id_2474("flag_helmet_on");
  setmusicstate("mx_195_assassination_levelstart");
  var_2 = [];
  var_2 = getEntArray("sa02_disguise", "targetname");
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_D85C();
  var_3 = spawnStruct();
  var_3.pos = scripts\engine\utility::getStruct("struct_barracks_panel", "targetname");
  var_3._id_D267 = scripts\sp\utility::_id_10639("player_rig", var_3.pos.origin, var_3.pos.angles);
  var_3._id_D267 hide();
  var_3._id_D267._id_1FBB = "player_rig";
  var_3.pos scripts\sp\anim::_id_1EC3(var_3._id_D267, "player_disguise_start");
  level.player playerlinkTo(var_3._id_D267, "tag_player");
  level.player _meth_823C(var_3._id_D267, "tag_player", 0.5, 0.25, 0.25);
  wait 0.5;
  var_3._id_D267 show();
  var_3.pos scripts\sp\anim::_id_1F35(var_3._id_D267, "player_disguise_start");
  var_3._id_D267 delete();
  wait 1.5;

  foreach(var_5 in var_2)
  var_5 delete();

  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_E986(1);
  var_3._id_D266 = scripts\sp\utility::_id_10639("player_rig_disguise", var_3.pos.origin, var_3.pos.angles);
  var_3._id_D266 hide();
  var_3._id_D266._id_1FBB = "player_rig_disguise";
  var_3.pos scripts\sp\anim::_id_1EC3(var_3._id_D266, "player_disguise_end");
  level.player _meth_823B(var_3._id_D266, "tag_player");
  var_7 = getEnt("disguise_weapon", "targetname");
  var_7 linkTo(var_3._id_D266, "tag_weapon_right");
  var_3._id_D266 show();
  scripts\engine\utility::delaythread(4.2, ::_id_5658);
  var_3.pos scripts\sp\anim::_id_1F35(var_3._id_D266, "player_disguise_end");
  var_3._id_D266 delete();
  var_7 delete();
  thread _id_5657();
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_DF3E();
  level.player scripts\sp\utility::_id_F526("relaxed");
  scripts\sp\utility::_id_C27C(var_0);
  scripts\engine\utility::flag_wait("flag_disguise_vo_done");
  scripts\sp\utility::_id_10350("asn_slt_youllneedcredentials");
  level.player scripts\sp\utility::_id_1034D("asn_plr_copysendit");
  scripts\engine\utility::flag_set("flag_kill_tech_officer");
  scripts\engine\utility::flag_set("flag_got_disguise");
  thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_9133(25, 116, 138, 184, "assassination_techofficer_id");
  wait 6;
  level.player notify("delete_hud_cinematic");
}

_id_5658() {
  level.player scripts\sp\utility::_id_1034D("asn_plr_uniformacquiredwhatsthe");
  scripts\sp\utility::_id_10350("asn_slt_threehvtshavetransferred");
  scripts\engine\utility::flag_set("flag_disguise_vo_done");
}

_id_5657() {
  level.player scripts\engine\utility::allow_doublejump(0);
  level.player scripts\engine\utility::allow_wallrun(0);
  level.player _meth_8081();
  level.player setviewmodel("viewmodel_mp_stryker_2");
  level.player _meth_8574("body_sdf_army_heavy_4_vm_legs");
  scripts\engine\utility::waitframe();
  var_0 = level.player getweaponslistall();

  foreach(var_2 in var_0) {
    if(weaponinventorytype(var_2) != "primary") {
      continue;
    }
    level.player takeweapon(var_2);
  }

  level.player giveweapon("iw7_sdfar+reflex");
  wait 0.5;
  level.player switchtoweapon("iw7_sdfar+reflex");
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_F406(255, 180, 86);
  _id_0F27::_id_F357(1);
  setomnvar("ui_hud_disguise", 1);
  setomnvar("ui_wrist_pc", 0);
}

_id_5654() {
  wait 1.25;
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame("assassination_disguise_bootup");
}

_id_2474(var_0) {
  if(isDefined(var_0)) {
    scripts\engine\utility::flag_wait("flag_helmet_on");
    thread _id_5654();
  }

  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_E986(1);
}

_id_6615() {
  scripts\engine\utility::flag_wait("sa_hubstern_start");
  thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_8951("flag_hub_halfway", "barracks");

  if(isDefined(level._id_EA2C) && isalive(level._id_EA2C)) {
    level._id_EA2C scripts\sp\utility::_id_1101B();
    level._id_EA2C delete();
  }

  thread _id_C14A();
  wait 1.75;
  thread _id_1D8C();
  thread _id_1D8D();
  scripts\sp\utility::_id_10350("asn_slt_dontshoot90_20");
  wait 0.75;
  scripts\sp\utility::_id_10350("asn_slt_keepyouhidden");
  scripts\engine\utility::flag_wait("flag_hub_halfway");

  if(!scripts\engine\utility::flag("ship_in_lockdown"))
    scripts\sp\utility::_id_10350("asn_slt_goodstealthchattersclean");
}

_id_F02B() {
  scripts\engine\utility::flag_wait("sa_hubstern_start");
  var_0 = scripts\sp\utility::_id_22CD("sdf_boxers", 1);
  var_1 = spawnStruct();
  var_1.pos = scripts\engine\utility::getStruct("scene_sdf_boxers", "targetname");

  foreach(var_3 in var_0) {
    var_3._id_1FBB = var_3.script_noteworthy;
    var_3 thread _id_1EA5(var_1);
    var_3 scripts\sp\utility::_id_F2A8(1);
    var_3.health = 1;
  }

  var_1._id_1684 = var_0;
  thread _id_2F2D(var_1._id_1684);
  var_1.pos thread scripts\sp\anim::_id_1EE7(var_1._id_1684, "sdf_boxers");
  scripts\engine\utility::flag_wait("ship_in_lockdown");
  var_1.pos notify("stop_loop");
}

_id_1EA5(var_0) {
  self waittill("sight");
  var_0.pos notify("stop_loop");
  level notify("stop_boxing_conv");
  self stopsounds();
}

_id_2F2D(var_0) {
  level endon("stop_boxing_conv");

  if(isDefined(var_0[0]) && isalive(var_0[0]))
    var_0[0] scripts\sp\utility::_id_10347("asn_sdf1_strongsuit");

  if(isDefined(var_0[1]) && isalive(var_0[1]))
    var_0[1] scripts\sp\utility::_id_10347("asn_sdf2_teachlesson");

  if(isDefined(var_0[2]) && isalive(var_0[2]))
    var_0[2] scripts\sp\utility::_id_10347("asn_sdf3_handtohand");

  if(isDefined(var_0[0]) && isalive(var_0[0]))
    var_0[0] scripts\sp\utility::_id_10347("asn_sdf1_guardup");

  if(isDefined(var_0[1]) && isalive(var_0[1]))
    var_0[1] scripts\sp\utility::_id_10347("asn_sdf3_lowstance");

  if(isDefined(var_0[2]) && isalive(var_0[2]))
    var_0[2] scripts\sp\utility::_id_10347("asn_sdf1_badposition");

  if(isDefined(var_0[0]) && isalive(var_0[0]))
    var_0[0] scripts\sp\utility::_id_10347("asn_sdf1_letsspar");
}

_id_BDAC(var_0) {
  if(scripts\engine\utility::is_true(level._id_10E6D._id_5659) && var_0._id_12AE9 == "sight") {
    thread _id_BDAD(var_0);
    return 1;
  }

  return 0;
}

_id_BDAD(var_0) {
  if(scripts\engine\utility::is_true(level._id_BDAC)) {
    return;
  }
  self notify("mulligan");
  level._id_BDAC = 1;
  level.player scripts\sp\utility::_id_F416(1);
  var_1 = randomintrange(1, 6);

  switch (var_1) {
    case 1:
      scripts\sp\utility::_id_10347("asn_sdf3_needsomething");
      break;
    case 2:
      scripts\sp\utility::_id_10347("asn_sdf2_getoutofmy");
      break;
    case 3:
      scripts\sp\utility::_id_10347("asn_sdf2_wheresyouroperatingid");
      break;
    case 4:
      scripts\sp\utility::_id_10347("asn_sdf1_youneedsecurityclearance");
      break;
    case 5:
      scripts\sp\utility::_id_10347("asn_sdf1_moveit");
      break;
    case 6:
      scripts\sp\utility::_id_10347("asn_sdf2_whatareyoudoing");
      break;
  }

  wait 2;
  level.player scripts\sp\utility::_id_F416(0);
  _id_0F27::_id_F397("combat", undefined);

  if(!scripts\engine\utility::flag("stealth_spotted"))
    self _meth_84F7("reset", self, self.origin);
}

_id_C126() {
  self endon("death");
  self endon("notice_player_thread");

  for(;;) {
    if(self cansee(level.player)) {
      var_0 = distance(self.origin, level.player.origin);

      if(var_0 < 128) {
        var_1 = randomintrange(1, 6);

        switch (var_1) {
          case 1:
            scripts\sp\utility::_id_10347("asn_sdf3_needsomething");
            break;
          case 2:
            scripts\sp\utility::_id_10347("asn_sdf2_getoutofmy");
            break;
          case 3:
            scripts\sp\utility::_id_10347("asn_sdf2_wheresyouroperatingid");
            break;
          case 4:
            scripts\sp\utility::_id_10347("asn_sdf1_youneedsecurityclearance");
            break;
          case 5:
            scripts\sp\utility::_id_10347("asn_sdf1_moveit");
            break;
          case 6:
            scripts\sp\utility::_id_10347("asn_sdf2_whatareyoudoing");
            break;
        }

        self notify("notice_player_thread");
      }
    }

    wait 0.25;
  }
}

_id_BDAB() {
  scripts\engine\utility::flag_wait("mulligan_guy_alerted");
  self notify("mulligan_breakout");
  level.player scripts\sp\utility::_id_F416(0);
}

_id_C14A() {
  scripts\engine\utility::flag_wait("ship_in_lockdown");
  level notify("ship_in_lockdown");
}

_id_1D8C() {
  level endon("ship_in_lockdown");
  level endon("cleaned_up_sa_hubstern_vol");
  var_0 = getEnt("hub_stern_conv1_vol", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_77E3();

  for(;;) {
    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_iheardweremoving");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf3_soundslikeitwe");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_anyideawherewere");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf3_idontthinkthey");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_theresnowaythe");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf3_noshitiheard");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_justlegionguardsblowing");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf3_imhopingweget");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_letsmakesurewere");

    scripts\engine\utility::waitframe();
  }
}

_id_1D8D() {
  level endon("ship_in_lockdown");
  level endon("cleaned_up_sa_hubstern_vol");
  var_0 = getEnt("hub_stern_conv2_vol", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_77E3();

  for(;;) {
    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf3_hasthemeetingstarted");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_ithinksoi");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[2] scripts\sp\utility::_id_10347("asn_sdf4_yeskashiksaidtheyve");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf3_whyhavewenot");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_aftertheconferencefurther");

    if(isDefined(var_1[2]) && isalive(var_1[2]))
      var_1[2] scripts\sp\utility::_id_10347("asn_sdf3_butwhymeethere");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_therecouldbereconnaissance");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf3_therehavebeencounterattacks");

    if(isDefined(var_1[2]) && isalive(var_1[2]))
      var_1[2] scripts\sp\utility::_id_10347("asn_sdf4_lowerrankingguardsmanwanting");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf3_theearthbornhave");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_manyinthelegions");

    if(isDefined(var_1[2]) && isalive(var_1[2]))
      var_1[2] scripts\sp\utility::_id_10347("asn_sdf3_youreclaimingthecouncil");

    if(isDefined(var_1[0]) && isalive(var_1[0]))
      var_1[0] scripts\sp\utility::_id_10347("asn_sdf4_lowerrankingguardsmanwanting");

    if(isDefined(var_1[1]) && isalive(var_1[1]))
      var_1[1] scripts\sp\utility::_id_10347("asn_sdf4_ididntsaythey");

    if(isDefined(var_1[2]) && isalive(var_1[2]))
      var_1[2] scripts\sp\utility::_id_10347("asn_sdf3_youcanfinishthe");

    scripts\engine\utility::waitframe();
  }
}

_id_C1A0() {
  scripts\engine\utility::flag_wait("flag_fade_out");
  scripts\sp\hud_util::_id_6AA3(0.45, "black");
}

_id_C19F() {
  scripts\engine\utility::flag_wait("flag_fade_in");
  scripts\sp\hud_util::_id_6A99(1, "black");
}

_id_6606() {
  level.player thread scripts\sp\utility::_id_1034D("asn_plr_imintargetvisual");
  scripts\engine\utility::flag_set("flag_mark_tech_officer");
  wait 2;
  thread scripts\sp\utility::_id_10350("asn_slt_copytryandisolate");
  thread _id_1D88();
  thread _id_1D89();
}

#using_animtree("generic_human");

_id_21CA() {
  self endon("end_thread");
  scripts\engine\utility::flag_wait("sa_armory_start");
  thread _id_88D3();
  var_0 = getspawner("cart_pusher", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1 scripts\sp\utility::_id_F2A8(1);
  var_1.health = 1;
  var_2 = spawnStruct();
  var_2.pos = scripts\engine\utility::getStruct("scene_armory_cart", "targetname");
  var_2._id_872A = var_1;
  var_2._id_872A._id_1FBB = "cart_pusher";
  var_2._id_3B04 = scripts\sp\utility::_id_10639("armory_cart");
  var_2._id_3B04._id_1FBB = "armory_cart";
  var_2._id_B7DC = scripts\sp\utility::_id_10639("armory_cart_missile");
  var_2._id_B7DC._id_1FBB = "armory_cart";
  thread _id_2FBE(var_2);
  thread _id_7375(var_2);
  var_2._id_1684 = [];
  var_2._id_1684[var_2._id_1684.size] = var_2._id_872A;
  var_2._id_1684[var_2._id_1684.size] = var_2._id_3B04;
  var_2.pos thread scripts\sp\anim::_id_1F2C(var_2._id_1684, "armory_cart_start");
  scripts\engine\utility::waitframe();
  var_2._id_3B05 = getEnt("cart_clip", "targetname");
  var_2._id_3B05 linkTo(var_2._id_3B04, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2._id_B7DC linkTo(var_2._id_3B04, "tag_missile", (0, 0, 0), (0, 0, 0));
  thread _id_8930(var_2._id_3B05);
  thread _id_21CB(var_2);
  var_2._id_872A thread _id_3B09();
  var_3 = getanimlength(%sa_assassin_armory_cart_cguy_start);
  wait(var_3);
  level notify("cart_stopped");

  if(isDefined(var_2._id_872A))
    var_2.pos thread scripts\sp\anim::_id_1EE7(var_2._id_1684, "armory_cart_loop");
}

_id_3B09() {
  self endon("death");
  scripts\engine\utility::flag_wait("flag_cart_guy_buddy");
  wait 0.5;
  scripts\sp\utility::_id_10346("asn_sdf1_readyforprocessing");
  level notify("cart_guy_response");
}

_id_3B08() {
  self endon("death");
  level waittill("cart_guy_response");
  wait 1.75;
  scripts\sp\utility::_id_10346("asn_sdf2_checkitout");
}

_id_8930(var_0) {
  level endon("ship_in_lockdown");
  level endon("cart_stopped");
  createnavrepulsor("cart_badplace", 0, var_0, 128, 1);

  for(;;) {
    var_1 = createnavobstaclebyent(var_0);
    wait 0.5;
    scripts\engine\utility::waitframe();
  }
}

#using_animtree("script_model");

_id_7375(var_0) {
  scripts\engine\utility::waittill_any("damage", "death", "stealth_react");
  var_0._id_B7DC linkTo(var_0._id_3B04, "tag_missile", (0, 0, 0), (0, 0, 0));
  var_0._id_3B04 _meth_82B1(%sa_assassin_armory_cart_mcart_start, 0);
}

_id_21CB(var_0) {
  scripts\engine\utility::flag_wait("flag_commanders_killed");

  if(isDefined(var_0._id_872A))
    var_0._id_872A delete();

  if(isDefined(var_0._id_3B04))
    var_0._id_3B04 delete();
}

_id_88D3() {
  level endon("ship_in_lockdown");
  self endon("end_thread");
  var_0 = getspawner("cart_director", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1 scripts\sp\utility::_id_F2A8(1);
  var_1.health = 1;
  var_1._id_1FBB = "cart_director";
  var_2 = spawnStruct();
  var_2.pos = scripts\engine\utility::getStruct("scene_armory_cart", "targetname");
  var_2._id_872A = var_1;
  thread _id_2FBE(var_2);
  var_2.pos thread scripts\sp\anim::_id_1EEA(var_2._id_872A, "typing_guy_loop");
  var_1 thread _id_3B08();
  scripts\engine\utility::flag_wait("flag_cart_guy_buddy");
  var_2.pos notify("stop_loop");
  var_2.pos scripts\sp\anim::_id_1F35(var_2._id_872A, "typing_guy_start");
  var_2.pos thread scripts\sp\anim::_id_1EEA(var_2._id_872A, "typing_guy_loop");
}

_id_2FBE(var_0) {
  var_0._id_872A scripts\engine\utility::waittill_any("damage", "ship_in_lockdown", "mulligan");
  var_0._id_872A notify("end_thread");
  var_0.pos notify("end_loop");
}

_id_1D88() {
  level endon("ship_in_lockdown");
  level endon("cleaned_up_sa_armory_room_vol");
  var_0 = getEnt("armory_conv1_vol", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_77E3();

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf2_nothingsshowingonmy");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf3_whatsthestatushere");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf2_starboardtaccontrolreports");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf3_youwantmeto");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf2_standbytheyre");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf3_tellemwesaw");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf2_wesawitlast");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf3_taccontrolteamsbeen");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf2_procreationpermitswillbe");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf3_foreverylegion");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf2_officerscouncilandhigh");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf3_theprocreassemblyshould");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf2_iknowhowyou");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf3_tellme");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf2_thatinformationwillcost");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf3_ivegotcreditsto");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf2_confirmedwellspeakin");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf3_pledged");

  scripts\engine\utility::waitframe();
}

_id_1D89() {
  level endon("ship_in_lockdown");
  level endon("cleaned_up_sa_armory_room_vol");
  scripts\engine\utility::flag_wait("flag_armory_conv2");
  var_0 = getEnt("armory_conv2_vol", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_77E3();

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_itwasrecountedto");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf2_thatsnotwhatis");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_ifyouhaveinformation");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf2_theunsamounteda");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_thisiswellknown");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf2_asmallscarteam");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_impossiblethatcannotbe");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf2_thereisrecordthat");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_therewerefireteamsand");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf2_theyfellallslain");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_youbelievethistale");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf2_imrecountingwhathas");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_youarespeakingof");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf2_forgivebutyouinquired");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_concurwhataboutthe");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf2_theyleftthevessel");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_thisintelligenceisdisreputable");

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1] scripts\sp\utility::_id_10347("asn_sdf2_whateverinbornfoolwas");

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0] scripts\sp\utility::_id_10347("asn_sdf1_enoughreturntoyour");

  scripts\engine\utility::waitframe();
}

_id_115F8() {
  level._id_115F7 = self;
  scripts\engine\utility::flag_set("flag_tech_officer_spawned");
  var_0 = scripts\engine\utility::getStruct("tech_officer_path", "targetname");
  wait 1.5;
  thread _id_0B77::_id_8409(var_0, undefined, _id_0F0C::_id_E9CF, undefined, undefined);
  self._id_1FBB = "generic";
  thread _id_8963();
}

_id_8963() {
  self waittill("death");
  level.player thread scripts\sp\utility::_id_1034D("asn_plr_targetdown");
  thread _id_134F2();
  var_0 = spawnStruct();
  var_0.origin = self.origin + anglesToForward(self.angles) * -16;
  var_0.angles = self.angles;
  var_0.model = "sdf_captain_keycard_01_static_nochain";
  level._id_3A1C = spawn("script_model", var_0.origin);
  level._id_3A1C setModel("sdf_captain_keycard_01_static_nochain");
  level._id_3A1C _id_0E46::_id_48C4(undefined, (0, 0, 16), undefined, undefined, 500, 75, 0);
  level._id_3A1C _id_0E46::_id_9016();
  scripts\engine\utility::flag_set("captain_key_card_picked_up");
  level notify("grabbed_keycard");
  level._id_3A1C delete();

  if(scripts\engine\utility::flag("stealth_spotted"))
    scripts\engine\utility::flag_waitopen("stealth_spotted");

  level._id_E99E["trig_armory_door_exit"] _id_0F05::_id_12BD3(1);
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132BE(1);
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C2(1);
  level.player scripts\sp\utility::_id_1034D("asn_plr_gottheidoverride");
  setmusicstate("mx_405_sass_catwalk");
  wait 1;
  scripts\sp\utility::_id_10350("asn_slt_onitmeetingsunderway");
}

_id_134F2() {
  level endon("grabbed_keycard");
  wait 3;
  scripts\sp\utility::_id_10350("asn_slt_findhiscredentialand");
  wait 6;
  scripts\sp\utility::_id_10350("asn_slt_dontleavewithoutthat");
  wait 12;
  scripts\sp\utility::_id_10350("asn_slt_findhiscredentialand");
  wait 20;
  scripts\sp\utility::_id_10350("asn_slt_dontleavewithoutthat");
}

_id_88C7() {
  scripts\engine\utility::flag_wait("flag_near_conference");
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C1(0);
  level._id_E99E["trig_conference_door"] _id_0F05::_id_AED6(0);
  thread _id_8908();
  disable_depricated_trigger_plantgas();
  thread scripts\sp\utility::_id_10350("asn_slt_idoverridesgoodto");
  wait 1.5;
  thread scripts\sp\utility::_id_10350("asn_slt_almostthereraider");
  scripts\engine\utility::flag_wait("sa_bowupper_roomb_start");
  level notify("end_pa_group");
  level.player thread _id_0F24::_id_1DD2();
  scripts\sp\utility::_id_22CA("conf_guys", ::_id_4512);
  scripts\sp\utility::_id_22CA("conf_grunts", ::_id_4512);
  scripts\sp\utility::_id_22CA("conf_grunts2a", ::_id_4512);
  scripts\sp\utility::_id_22CA("conf_grunts2b", ::_id_4512);
  setsaveddvar("ai_eventDistSilencedShot", 1000);
  level._id_4513 = scripts\sp\utility::_id_22CD("conf_guys", 1);
  level._id_4510 = scripts\sp\utility::_id_22CD("conf_grunts", 1);
  thread _id_1068D();
  thread _id_88F9();
  thread _id_894D();
  thread _id_8940();
  thread _id_4515();
  thread _id_4516();
  thread _id_4514();
  thread scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_758A();
  _id_119B5("on");
  scripts\engine\utility::flag_wait("flag_in_conference");

  if(!scripts\engine\utility::flag("ship_in_lockdown")) {
    scripts\sp\utility::_id_10350("asn_slt_reyesforceshavebeen");
    level.player scripts\sp\utility::_id_1034D("asn_plr_copy");
  }

  _id_0F0C::_id_E9D1("sac_bowupper_vol", "cleared");
}

disable_depricated_trigger_plantgas() {
  var_0 = getEntArray("trigger_use_flag_set", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_ED9A) && var_2._id_ED9A == "flag_plant_gas_event")
      var_2 scripts\engine\utility::trigger_off();
  }
}

_id_1068D() {
  scripts\engine\utility::flag_wait("flag_player_down_rafters");
  var_0 = scripts\sp\utility::_id_77DA("conf_grunt_patrol");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2))
      var_2 delete();
  }

  scripts\engine\utility::flag_wait("flag_kill_commanders_event");
  level._id_450E = scripts\sp\utility::_id_22CD("conf_grunts2a", 1);
  scripts\engine\utility::flag_wait("flag_kill_commanders_event2");
  level._id_450F = scripts\sp\utility::_id_22CD("conf_grunts2b", 1);
  scripts\engine\utility::flag_set("flag_all_reacting_grunts_spawned");
  level._id_E99E["trig_conference_door"].scripted = 1;
  level._id_E99E["trig_conference_door"] thread _id_0F05::_id_E9A2();
}

_id_88C6(var_0) {
  level endon("destroy_conf_cursor_hint_thread");
  var_1 = 0;

  for(;;) {
    if(!scripts\engine\utility::flag("ship_in_lockdown") && !var_1) {
      var_0 _id_0E46::_id_48C4(undefined, undefined, &"SA_ASSASSINATION_SECURITY_TERMINAL", 15, 600, 75, 0, 0, 0, undefined, 0, 0, undefined, 1);
      var_1 = 1;
      thread _id_4506(var_0);
    }

    if(scripts\engine\utility::flag("ship_in_lockdown") && var_1) {
      var_0 _id_0E46::_id_DFE3();
      level notify("destroy_conf_cursor_hint");
      var_1 = 0;
    }

    wait 0.25;
  }
}

_id_4506(var_0) {
  level endon("destroy_conf_cursor_hint");
  var_0 _id_0E46::_id_9016();
  scripts\engine\utility::flag_set("flag_conf_cursor_triggered");
  level notify("destroy_conf_cursor_hint_thread");
}

_id_8908() {
  var_0 = scripts\engine\utility::getStruct("use_handscanner_conf", "targetname");
  var_1 = getEnt("handscanner_screen_upper", "targetname");
  thread _id_88C6(var_0);
  scripts\engine\utility::flag_wait("flag_conf_cursor_triggered");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("BYPASS_SECURITY_TERMINAL"));
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_D85C();
  var_2 = spawnStruct();
  var_2.pos = scripts\engine\utility::getStruct("use_handscanner_conf", "targetname");
  var_2._id_D267 = scripts\sp\utility::_id_10639("player_rig_disguise", var_2.pos.origin, var_2.pos.angles);
  var_2._id_D267 hide();
  var_2._id_D267._id_1FBB = "player_rig_disguise";
  var_2.pos scripts\sp\anim::_id_1EC3(var_2._id_D267, "plr_handscanner");
  level.player playerlinkTo(var_2._id_D267, "tag_player");
  level.player _meth_823C(var_2._id_D267, "tag_player", 0.5, 0.25, 0.25);
  wait 0.5;
  var_2._id_D267 show();
  var_2.pos thread scripts\sp\anim::_id_1F35(var_2._id_D267, "plr_handscanner");
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_F0E4();
  scripts\engine\utility::flag_wait("flag_hand_bink");
  var_1 hide();
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame("assassination_handscanner");
  scripts\engine\utility::flag_wait("flag_hand_bink_end");
  var_2._id_D267 waittillmatch("single anim", "end");
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_DF3E();
  var_2._id_D267 delete();
  thread scripts\sp\utility::_id_2679();
  level._id_E99E["trig_conference_door"] _id_0F05::_id_12BD3(1);
  thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_8951("flag_in_conference", "conf_hallway");
  scripts\engine\utility::flag_set("flag_handscanner_used");
}

_id_8940() {
  level endon("gas_venting");
  level endon("player_down_rafters");
  var_0 = getEntArray("light_off_01", "targetname");

  for(;;) {
    if(scripts\engine\utility::flag("flag_player_in_rafters")) {
      if(level.player scripts\sp\utility::_id_7B8C() != "safe")
        level.player scripts\sp\utility::_id_F526("safe");

      foreach(var_2 in var_0)
      var_2 setlightintensity(50);
    }

    if(!scripts\engine\utility::flag("flag_player_in_rafters")) {
      if(level.player scripts\sp\utility::_id_7B8C() != "relaxed")
        level.player scripts\sp\utility::_id_F526("relaxed");

      foreach(var_2 in var_0)
      var_2 setlightintensity(0.01);
    }

    wait 1;
  }
}

player_in_server_room() {
  for(;;) {
    if(scripts\engine\utility::flag("flag_player_in_server")) {
      if(level.player scripts\sp\utility::_id_7B8C() != "safe")
        level.player scripts\sp\utility::_id_F526("safe");
    }

    if(!scripts\engine\utility::flag("flag_player_in_server")) {
      if(level.player scripts\sp\utility::_id_7B8C() != "normal")
        level.player scripts\sp\utility::_id_F526("normal");
    }

    wait 1;
  }
}

_id_4512() {
  if(self.script_noteworthy == "guy1") {
    level._id_4427 = self;
    _id_F91D("commander1_conf_loop", "commander1_conf_react", "commander1_conf_react_loop", "commander1_conf_startle", "conf_chair1", undefined, 30, 1);
  }

  if(self.script_noteworthy == "guy2") {
    level._id_4428 = self;
    _id_F91D("commander2_conf_loop", "commander2_conf_react", "commander2_conf_react_loop", "commander2_conf_startle", "conf_chair2", undefined, 30, 1);
  }

  if(self.script_noteworthy == "guy3") {
    level._id_4429 = self;
    _id_F91D("commander3_conf_loop", "commander3_conf_react", "commander3_conf_react_loop", "commander3_conf_startle", "conf_chair3", "conf_chair4", 30, 1);
  }

  if(self.script_noteworthy == "conf_grunt1") {
    level._id_4508 = self;
    thread _id_F91E("grunt1_conf_react", "grunt1_conf_loop", "grunt1_conf_loop2", undefined);
  }

  if(self.script_noteworthy == "conf_grunt2") {
    level._id_450A = self;
    thread _id_F91E("grunt2_conf_react", "grunt2_conf_loop", "grunt2_conf_loop2", undefined);
  }

  if(self.script_noteworthy == "conf_grunt3") {
    level._id_450C = self;
    thread _id_F91E("grunt3_conf_react", undefined, "grunt3_conf_loop2", "conf_panel");
  }

  if(self.script_noteworthy == "conf_grunt4") {
    level._id_450D = self;
    thread _id_F91E("grunt4_conf_react", undefined, "grunt4_conf_loop2", undefined);
  }

  if(self.script_noteworthy == "conf_grunt1_patrol") {
    level._id_4509 = self;
    thread _id_C126();
  }

  if(self.script_noteworthy == "conf_grunt2_patrol") {
    level._id_450B = self;
    thread _id_C126();
  }
}

_id_F91D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  var_9 = spawnStruct();
  var_9.node = scripts\engine\utility::getStruct("scn_gas_event", "targetname");
  var_9._id_872A = self;
  var_9._id_872A._id_1FBB = "generic_human";
  var_9._id_872A.health = var_6;
  var_9._id_872A scripts\sp\utility::_id_F2A8(1);
  var_9._id_DA93 = scripts\sp\utility::_id_10639(var_4);
  var_9._id_DA93._id_1F61 = var_4;
  thread _id_8922();

  if(isDefined(var_5)) {
    var_9._id_DA92 = scripts\sp\utility::_id_10639(var_5);
    var_9._id_DA92._id_1F61 = var_5;
  }

  if(isDefined(var_7) && scripts\engine\utility::is_true(var_7))
    var_9._id_872A scripts\sp\utility::_id_86E4();

  var_9._id_B036 = var_0;
  var_9._id_DD29 = var_1;
  var_9._id_DD5D = var_2;

  if(isDefined(var_3)) {
    var_9._id_10DBF = var_3;
    thread _id_88AC(var_9);
  }

  thread _id_88A8(var_9);
  thread _id_88AA(var_9);
  thread _id_4511();
}

_id_F91E(var_0, var_1, var_2, var_3) {
  self endon("death");
  level endon("gas_gone_hot");
  var_4 = spawnStruct();
  var_4.node = scripts\engine\utility::getStruct("scn_gas_event", "targetname");
  var_4._id_872A = self;
  var_4._id_872A._id_1FBB = "generic";
  var_4._id_872A scripts\sp\utility::_id_F2A8(1);

  if(isDefined(var_0))
    var_4._id_DD29 = var_0;

  if(isDefined(var_1))
    var_4._id_B036 = var_1;

  if(isDefined(var_2))
    var_4._id_B035 = var_2;

  if(var_4._id_872A.script_noteworthy == "conf_grunt1" || var_4._id_872A.script_noteworthy == "conf_grunt2") {
    scripts\engine\utility::flag_wait("flag_kill_commanders_event");
    wait 0.125;
    var_4._id_872A thread _id_86A6(var_4);
    var_4.node thread scripts\sp\anim::_id_1EEA(var_4._id_872A, var_4._id_B036, "end_loop");
    scripts\engine\utility::flag_wait_or_timeout("flag_kill_commanders_event2", 8);
    scripts\engine\utility::flag_set("flag_kill_commanders_event2");
    var_4.node notify("end_loop");
    var_4.node scripts\sp\anim::_id_1F35(var_4._id_872A, var_4._id_DD29);
    var_4.node scripts\sp\anim::_id_1EEA(var_4._id_872A, var_4._id_B035);
  }

  if(var_4._id_872A.script_noteworthy == "conf_grunt3" || var_4._id_872A.script_noteworthy == "conf_grunt4") {
    var_4._id_872A thread _id_86A6(var_4);
    scripts\engine\utility::flag_wait_or_timeout("flag_kill_commanders_event2", 8);
    scripts\engine\utility::flag_set("flag_kill_commanders_event2");

    if(isDefined(var_3) && var_4._id_872A.script_noteworthy == "conf_grunt3") {
      var_5 = scripts\sp\utility::_id_10639("conf_panel", var_4.node.origin, var_4.node.angles);
      var_5._id_1FBB = "conf_panel";
      var_6 = getEnt("conf_panel_rip", "targetname");
      var_6 linkTo(var_5, "J_prop_1", (0, 0, 0), (0, 0, 0));
      var_4.node thread scripts\sp\anim::_id_1EC3(var_5, "grunt3_conf_react");
      var_7 = [];
      var_7[var_7.size] = var_4._id_872A;
      var_7[var_7.size] = var_5;
      thread handle_grunt3_breakout(var_7, var_4);
      var_4.node scripts\sp\anim::_id_1F2C(var_7, "grunt3_conf_react");
      var_4.node scripts\sp\anim::_id_1EEA(var_4._id_872A, var_4._id_B035);
    }

    if(scripts\engine\utility::flag("flag_conference_room_gas_hot"))
      thread handle_grunt4_breakout(var_4._id_872A);

    var_4.node scripts\sp\anim::_id_1F35(var_4._id_872A, var_4._id_DD29);
    var_4.node scripts\sp\anim::_id_1EEA(var_4._id_872A, var_4._id_B035);
  }
}

handle_grunt3_breakout(var_0, var_1) {
  scripts\engine\utility::flag_wait("flag_conference_room_gas_hot");
  wait(randomintrange(1, 3));

  foreach(var_3 in var_0) {
    if(isDefined(var_3))
      var_3 scripts\sp\utility::anim_stopanimScripted();
  }
}

handle_grunt4_breakout(var_0) {
  wait(randomintrange(1, 3));
  var_0 scripts\sp\utility::anim_stopanimScripted();
}

_id_88A8(var_0) {
  var_0._id_872A endon("death");
  var_1 = [];
  var_1[var_1.size] = var_0._id_872A;
  var_1[var_1.size] = var_0._id_DA93;

  if(isDefined(var_0._id_DA92))
    var_1[var_1.size] = var_0._id_DA92;

  var_0.node scripts\sp\anim::_id_1EE7(var_1, var_0._id_B036, "stop_loop");
}

_id_88AA(var_0) {
  var_0._id_872A endon("death");
  level endon("startled_event");
  scripts\engine\utility::flag_wait("flag_kill_commanders_event");
  level notify("gas_venting");
  var_0._id_872A stopsounds();
  var_0._id_872A scripts\sp\utility::_id_B14F(1);
  var_0._id_872A.ignoreme = 1;
  var_0._id_872A.ignoreall = 1;
  var_0._id_872A.team = "neutral";
  _id_119B5("off");
  var_0.node notify("stop_loop");
  var_0._id_872A.a.nodeath = 1;
  var_1 = [];
  var_1[var_1.size] = var_0._id_872A;
  var_1[var_1.size] = var_0._id_DA93;

  if(isDefined(var_0._id_DA92))
    var_1[var_1.size] = var_0._id_DA92;

  var_0.node scripts\sp\anim::_id_1F2C(var_1, var_0._id_DD29);
  var_0.node scripts\sp\anim::_id_1EE7(var_1, var_0._id_DD5D);
}

_id_88AC(var_0) {
  var_0._id_872A endon("death");
  level endon("gas_venting");
  scripts\engine\utility::flag_wait("flag_conference_room_hot");
  level notify("startled_event");
  var_0._id_872A stopsounds();
  var_0.node notify("stop_loop");
  var_1 = [];
  var_1[var_1.size] = var_0._id_872A;
  var_1[var_1.size] = var_0._id_DA93;
  var_0._id_872A scripts\sp\utility::_id_86E2();
  var_0.node scripts\sp\anim::_id_1F2C(var_1, var_0._id_10DBF);
  var_0._id_872A _meth_82F1(getEnt("conf_room_vol", "targetname"));
}

_id_C5E8() {
  var_0 = getEnt("conf_door_clip_1", "targetname");
  var_1 = getEnt("conf_door_clip_2", "targetname");
  var_0 delete();
  var_1 delete();
  _id_119B5("off");
  var_2 = getEnt("conf_door_left_1", "targetname");
  var_3 = getEnt("conf_door_right_1", "targetname");
  var_4 = getEnt("conf_door_left_2", "targetname");
  var_5 = getEnt("conf_door_right_2", "targetname");
  var_6 = getEnt("move_conf_door_left_1", "targetname");
  var_7 = getEnt("move_conf_door_right_1", "targetname");
  var_8 = getEnt("move_conf_door_left_2", "targetname");
  var_9 = getEnt("move_conf_door_right_2", "targetname");
  var_2 moveTo(var_6.origin, 1, 0.2, 0.2);
  var_3 moveTo(var_7.origin, 1, 0.2, 0.2);
  var_4 moveTo(var_8.origin, 1, 0.2, 0.2);
  var_5 moveTo(var_9.origin, 1, 0.2, 0.2);
}

_id_119B5(var_0) {
  if(var_0 == "off") {
    var_1 = getEnt("conf_door_pad1_off", "targetname");
    var_1 show();
    var_2 = getEnt("conf_door_pad1_on", "targetname");
    var_2 hide();
    var_3 = getEnt("conf_door_pad2_off", "targetname");
    var_3 show();
    var_4 = getEnt("conf_door_pad2_on", "targetname");
    var_4 hide();
  }

  if(var_0 == "on") {
    var_1 = getEnt("conf_door_pad1_off", "targetname");
    var_1 hide();
    var_2 = getEnt("conf_door_pad1_on", "targetname");
    var_2 show();
    var_3 = getEnt("conf_door_pad2_off", "targetname");
    var_3 hide();
    var_4 = getEnt("conf_door_pad2_on", "targetname");
    var_4 show();
  }
}

cleanup_conference_room_ents() {
  var_0 = getEnt("conf_door_left_1", "targetname");
  var_1 = getEnt("conf_door_right_1", "targetname");
  var_2 = getEnt("conf_door_left_2", "targetname");
  var_3 = getEnt("conf_door_right_2", "targetname");
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 = getEnt("move_conf_door_left_1", "targetname");
  var_5 = getEnt("move_conf_door_right_1", "targetname");
  var_6 = getEnt("move_conf_door_left_2", "targetname");
  var_7 = getEnt("move_conf_door_right_2", "targetname");
  var_4 delete();
  var_5 delete();
  var_6 delete();
  var_7 delete();
  var_8 = getEnt("conf_door_pad1_off", "targetname");
  var_9 = getEnt("conf_door_pad1_on", "targetname");
  var_10 = getEnt("conf_door_pad2_off", "targetname");
  var_11 = getEnt("conf_door_pad2_on", "targetname");
  var_8 delete();
  var_9 delete();
  var_10 delete();
  var_11 delete();
}

_id_896D() {
  self endon("death");
  scripts\engine\utility::flag_wait_any("flag_conference_room_hot", "ship_in_lockdown", "flag_conference_room_gas_hot");
  level notify("ship_in_lockdown");
  scripts\sp\utility::anim_stopanimScripted();
  self _meth_82F1(getEnt("conf_room_vol", "targetname"));
}

_id_896C(var_0) {
  var_0._id_872A endon("death");
  scripts\engine\utility::flag_wait("flag_conference_room_gas_hot");
  var_0._id_872A _meth_83A1();
  var_0._id_872A scripts\sp\utility::anim_stopanimScripted();
  var_0.node notify("end_loop");
  var_0._id_872A notify("stop_loop");
  var_0._id_872A notify("single anim", "end");
  var_0._id_872A notify("looping anim", "end");
  var_0._id_872A notify("stop_animmode");
  var_0._id_872A _meth_82F1(getEnt("conf_room_vol", "targetname"));
}

_id_4442() {
  scripts\sp\utility::_id_86E2();
}

_id_4511() {
  self endon("gas_venting");
  self endon("death");
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("explode");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "ai_events");
  scripts\sp\utility::_id_57D6();
  scripts\engine\utility::flag_set("flag_conference_room_hot");
  level notify("gone_hot");
  self stopsounds();
}

_id_86A6(var_0) {
  thread _id_896C(var_0);
  self endon("death");
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("explode");
  self addaieventlistener("death");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "ai_events");
  scripts\sp\utility::_id_57D6();
  scripts\engine\utility::flag_set("flag_conference_room_gas_hot");
  level notify("gas_gone_hot");
}

_id_4516() {
  thread _id_4517();
  thread _id_4518();
}

_id_4517() {
  scripts\engine\utility::flag_wait("flag_player_in_rafters");
  level endon("gone_hot");
  level endon("gas_venting");
  wait 2;

  for(;;) {
    scripts\engine\utility::flag_wait("flag_player_in_rafters");

    if(isDefined(level._id_4427) && isalive(level._id_4427))
      level._id_4427 scripts\sp\utility::_id_10346("asn_sdl2_lookingatthelatest");

    scripts\engine\utility::flag_wait("flag_player_in_rafters");

    if(isDefined(level._id_4428) && isalive(level._id_4428))
      level._id_4428 scripts\sp\utility::_id_10346("asn_sdl3_thesefiguresdolend");

    scripts\engine\utility::flag_wait("flag_player_in_rafters");

    if(isDefined(level._id_4429) && isalive(level._id_4429))
      level._id_4429 scripts\sp\utility::_id_10346("asn_sdl1_ourobjectiveisplanet");

    scripts\engine\utility::flag_wait("flag_player_in_rafters");

    if(isDefined(level._id_4427) && isalive(level._id_4427))
      level._id_4427 scripts\sp\utility::_id_10346("asn_sdl2_wehaveintelligencethat");

    scripts\engine\utility::flag_wait("flag_player_in_rafters");

    if(isDefined(level._id_4428) && isalive(level._id_4428))
      level._id_4428 scripts\sp\utility::_id_10346("asn_sdl1_nowitisi");

    scripts\engine\utility::flag_wait("flag_player_in_rafters");

    if(isDefined(level._id_4429) && isalive(level._id_4429))
      level._id_4429 scripts\sp\utility::_id_10346("asn_sdl3_ourfleetdatais");

    scripts\engine\utility::flag_wait("flag_player_in_rafters");

    if(isDefined(level._id_4427) && isalive(level._id_4427))
      level._id_4427 scripts\sp\utility::_id_10346("asn_sdl2_weshouldinvestigateimmediately");

    scripts\engine\utility::flag_wait("flag_player_in_rafters");

    if(isDefined(level._id_4428) && isalive(level._id_4428))
      level._id_4428 scripts\sp\utility::_id_10346("asn_sdl1_tothecontrarywe");

    scripts\engine\utility::flag_wait("flag_player_in_rafters");

    if(isDefined(level._id_4429) && isalive(level._id_4429))
      level._id_4429 scripts\sp\utility::_id_10346("asn_sdl3_concurwecannotallow");

    scripts\engine\utility::flag_wait("flag_player_in_rafters");

    if(isDefined(level._id_4427) && isalive(level._id_4427))
      level._id_4427 scripts\sp\utility::_id_10346("asn_sdl2_irulewesend");

    scripts\engine\utility::waitframe();
  }
}

_id_4518() {
  level endon("gone_hot");
  level endon("gas_venting");
  wait 2;

  for(;;) {
    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4427) && isalive(level._id_4427))
      level._id_4427 scripts\sp\utility::_id_10346("asn_sdl1_theirdefensivepotencyis");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4427) && isalive(level._id_4427))
      level._id_4427 scripts\sp\utility::_id_10346("asn_sdl1_thegenevaconquestcannot");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4428) && isalive(level._id_4428))
      level._id_4428 scripts\sp\utility::_id_10346("asn_sdl2_earthforcesare");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4429) && isalive(level._id_4429))
      level._id_4429 scripts\sp\utility::_id_10346("asn_sdl3_satoispicking");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4427) && isalive(level._id_4427))
      level._id_4427 scripts\sp\utility::_id_10346("asn_sdl2_thatstrategyisnot");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4428) && isalive(level._id_4428))
      level._id_4428 scripts\sp\utility::_id_10346("asn_sdl1_agreedourresourcedominance");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4429) && isalive(level._id_4429))
      level._id_4429 scripts\sp\utility::_id_10346("asn_sdl3_theolympusmonsshould");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4427) && isalive(level._id_4427))
      level._id_4427 scripts\sp\utility::_id_10346("asn_sdl2_itisimperativethat");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4428) && isalive(level._id_4428))
      level._id_4428 scripts\sp\utility::_id_10346("asn_sdl3_tothatendmarss");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4429) && isalive(level._id_4429))
      level._id_4429 scripts\sp\utility::_id_10346("asn_sdl1_shipyardauthoritieswillscrap");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4427) && isalive(level._id_4427))
      level._id_4427 scripts\sp\utility::_id_10346("asn_sdl2_ifoughton");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4428) && isalive(level._id_4428))
      level._id_4428 scripts\sp\utility::_id_10346("asn_sdl1_amimistaken");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4429) && isalive(level._id_4429))
      level._id_4429 scripts\sp\utility::_id_10346("asn_sdl2_yourascensiontothe");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4427) && isalive(level._id_4427))
      level._id_4427 scripts\sp\utility::_id_10346("asn_sdl3_letusfocuson");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4428) && isalive(level._id_4428))
      level._id_4428 scripts\sp\utility::_id_10346("asn_sdl2_iconcurspreadingthe");

    scripts\engine\utility::flag_waitopen("flag_player_in_rafters");

    if(isDefined(level._id_4429) && isalive(level._id_4429))
      level._id_4429 scripts\sp\utility::_id_10346("asn_sdl1_currentsurveillancetestifiesthat");

    scripts\engine\utility::waitframe();
  }
}

_id_4514() {
  level endon("gas_gone_hot");
  scripts\engine\utility::flag_wait("flag_kill_commanders_event");
  thread _id_86A8();

  if(isDefined(level._id_4427) && isalive(level._id_4427))
    level._id_4427 scripts\sp\utility::_id_10346("asn_sdl2_whatisthat");

  if(isDefined(level._id_4428) && isalive(level._id_4428))
    level._id_4428 scripts\sp\utility::_id_10346("asn_sdl1_isthatsmoke");

  if(isDefined(level._id_4429) && isalive(level._id_4429))
    level._id_4429 scripts\sp\utility::_id_10346("asn_sdl3_whatthebluedeath");

  if(isDefined(level._id_4427) && isalive(level._id_4427))
    level._id_4427 scripts\sp\utility::_id_10346("asn_sdl1_werelockedin");

  if(isDefined(level._id_4428) && isalive(level._id_4428))
    level._id_4428 scripts\sp\utility::_id_10346("asn_sdl2_getusoutof");

  if(isDefined(level._id_4429) && isalive(level._id_4429))
    level._id_4429 scripts\sp\utility::_id_10346("asn_sdl1_icantbreath");

  if(isDefined(level._id_4427) && isalive(level._id_4427))
    level._id_4427 scripts\sp\utility::_id_10346("asn_sdl3_tryandbreakthe");

  if(isDefined(level._id_4428) && isalive(level._id_4428))
    level._id_4428 scripts\sp\utility::_id_10346("asn_sdl2_icantsee");

  if(isDefined(level._id_4429) && isalive(level._id_4429))
    level._id_4429 scripts\sp\utility::_id_10346("asn_sdl2_helpopenthedoors");
}

_id_86A8() {
  level endon("gas_gone_hot");
  scripts\engine\utility::flag_wait("flag_all_reacting_grunts_spawned");

  if(isDefined(level._id_450A) && isalive(level._id_450A))
    level._id_450A scripts\sp\utility::_id_10346("asn_sdf3_idontknow");

  if(isDefined(level._id_4508) && isalive(level._id_4508))
    level._id_4508 scripts\sp\utility::_id_10346("asn_sdf3_openthedoors");

  if(isDefined(level._id_450A) && isalive(level._id_450A))
    level._id_450A scripts\sp\utility::_id_10346("asn_sdf2_theyresealedicant");

  if(isDefined(level._id_4508) && isalive(level._id_4508))
    level._id_4508 scripts\sp\utility::_id_10346("asn_sdf1_isitsmoke");

  if(isDefined(level._id_450A) && isalive(level._id_450A))
    level._id_450A scripts\sp\utility::_id_10346("asn_sdf3_itscomingfromthe");

  scripts\engine\utility::flag_set("flag_red_alert");

  if(isDefined(level._id_4508) && isalive(level._id_4508))
    level._id_4508 scripts\sp\utility::_id_10346("asn_sdf2_thecouncilisin");

  if(isDefined(level._id_450A) && isalive(level._id_450A))
    level._id_450A scripts\sp\utility::_id_10346("asn_sdf1_shouldweshootthe");

  if(isDefined(level._id_4508) && isalive(level._id_4508))
    level._id_4508 scripts\sp\utility::_id_10346("asn_sdf2_itmightspreadthrough");

  if(isDefined(level._id_450A) && isalive(level._id_450A))
    level._id_450A scripts\sp\utility::_id_10346("asn_sdf3_contactthebridge");

  if(isDefined(level._id_4508) && isalive(level._id_4508))
    level._id_4508 scripts\sp\utility::_id_10346("asn_sdf2_wecantsavethem");
}

_id_4515() {
  level endon("gas_venting");
  scripts\engine\utility::flag_wait("flag_conference_room_gas_hot");

  if(isDefined(level._id_4509) && isalive(level._id_4509))
    level._id_4509 scripts\sp\utility::_id_10346("asn_sdf1_intruder");

  if(isDefined(level._id_450B) && isalive(level._id_450B))
    level._id_450B scripts\sp\utility::_id_10346("asn_sdf1_securethecommanders");

  if(isDefined(level._id_4509) && isalive(level._id_4509))
    level._id_4509 scripts\sp\utility::_id_10346("asn_sdf2_hesoneofours");

  if(isDefined(level._id_450B) && isalive(level._id_450B))
    level._id_450B scripts\sp\utility::_id_10346("asn_sdf2_shoottokill");

  if(isDefined(level._id_4509) && isalive(level._id_4509))
    level._id_4509 scripts\sp\utility::_id_10346("asn_sdf3_alertthebridgeshots");
}

_id_88F9() {
  level endon("ship_in_lockdown");
  level endon("gone_hot");
  thread _id_D235();
  scripts\engine\utility::flag_wait("flag_near_gas_event");
  thread _id_8919();
  thread scripts\sp\utility::_id_10350("asn_slt_readywhenyouare");
  scripts\engine\utility::flag_wait("flag_plant_gas_event");
  setmusicstate("mx_193_assassination_airlock");
  level.player scripts\sp\utility::_id_1034D("asn_plr_gasisinplace");
  scripts\sp\utility::_id_10350("asn_slt_copygetoutclean");
  thread scripts\sp\utility::_id_2679();
  scripts\engine\utility::flag_wait("flag_player_down_rafters");
  level notify("player_down_rafters");
  thread player_in_server_room();
  level.player scripts\sp\utility::_id_1034D("asn_plr_imdownreleaseit");
  scripts\engine\utility::flag_set("flag_kill_commanders_event");
  thread scripts\sp\utility::_id_10350("asn_slt_ventingnowrallyat");
  wait 1;
  scripts\engine\utility::flag_set("flag_commanders_killed");
}

_id_8919() {
  var_0 = scripts\engine\utility::getStruct("trig_plant_gas", "targetname");
  var_0 _id_0E46::_id_48C4(undefined, undefined, &"SA_ASSASSINATION_PLANT_EMP_DEVICE", undefined, 500, 80, 1);
  var_0 _id_0E46::_id_9016();
  scripts\engine\utility::flag_set("flag_setup_hvac_use");
}

_id_D235() {
  var_0 = spawnStruct();
  var_0.pos = getEnt("obj_gas_assassinate", "targetname");
  var_0._id_D267 = scripts\sp\utility::_id_10639("player_rig_disguise", var_0.pos.origin, var_0.pos.angles);
  var_0._id_D267 hide();
  var_0._id_D267._id_1FBB = "player_rig_disguise";
  var_0._id_91F8 = scripts\sp\utility::_id_10639("j_prop_hvac", var_0.pos.origin, var_0.pos.angles);
  var_0._id_91F8._id_1FBB = "j_prop_hvac";
  var_0._id_91F7 = scripts\sp\utility::_id_10639("prop_hvac", var_0.pos.origin, var_0.pos.angles);
  var_0._id_91F7._id_1FBB = "prop_hvac";
  var_0._id_91F7 linkTo(var_0._id_91F8, "J_prop_1", (0, 0, 0), (0, 0, 0));
  var_0.pos scripts\sp\anim::_id_1EC3(var_0._id_91F8, "plr_gasplant");
  scripts\engine\utility::flag_wait("flag_setup_hvac_use");

  if(scripts\sp\utility::_id_93A6())
    thread scripts\sp\specialist_MAYBE::_id_2683();

  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_D85D();
  var_0._id_76A5 = scripts\sp\utility::_id_10639("gasplant", var_0.pos.origin, var_0.pos.angles);
  var_0._id_76A5 hide();
  var_0._id_1684 = [];
  var_0._id_1684[0] = var_0._id_D267;
  var_0._id_1684[1] = var_0._id_76A5;
  var_0._id_1684[2] = var_0._id_91F8;
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_CC4F();
  var_0.pos scripts\sp\anim::_id_1EC3(var_0._id_D267, "plr_gasplant");
  level.player playerlinkTo(var_0._id_D267, "tag_player");
  level.player _meth_823C(var_0._id_D267, "tag_player", 0.5, 0.25, 0.25);
  wait 0.5;
  var_0._id_D267 show();
  var_0._id_76A5 show();
  var_0._id_76A5 thread _id_12983(0.5, 0);
  var_0._id_76A5 hidepart("tag_enabled", "weapon_gas_bomb_vm");
  var_0._id_76A5 hidepart("tag_armed", "weapon_gas_bomb_vm");
  var_0._id_76A5 thread _id_859B();
  var_0.pos scripts\sp\anim::_id_1F2C(var_0._id_1684, "plr_gasplant");
  var_0._id_D267 delete();
  level.player setstance("crouch");
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_DF3E();
  scripts\engine\utility::flag_set("flag_plant_gas_event");
}

_id_12983(var_0, var_1) {
  if(isDefined(var_0))
    wait(var_0);

  if(var_1 == 1)
    var_2 = scripts\engine\utility::getfx("vfx_light_emp_grenade_handoff");
  else
    var_2 = scripts\engine\utility::getfx("vfx_light_emp_grenade_blue");

  playFXOnTag(var_2, self, "tag_light");
}

_id_12956() {
  var_0 = scripts\engine\utility::getfx("vfx_light_emp_grenade_handoff");
  killfxontag(var_0, self, "tag_light");
}

_id_859B() {
  scripts\engine\utility::flag_wait("flag_gren_pin_pulled");
  var_0 = scripts\engine\utility::getfx("vfx_light_emp_grenade_blue");
  killfxontag(var_0, self, "tag_light");
  self showpart("tag_armed", "weapon_gas_bomb_vm");
  var_0 = scripts\engine\utility::getfx("vfx_light_emp_grenade_armed");
  playFXOnTag(var_0, self, "tag_light");
}

_id_894D() {
  scripts\engine\utility::flag_wait_any("flag_red_alert", "flag_conference_room_hot", "flag_salter_exfil_vo");
  thread _id_8946();
  _id_0F27::_id_10EDA();
  thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_8951("flag_move_on_to_salter", "conf_room");
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_DE0B();
  var_0 = getEntArray("redalert_klaxon", "targetname");

  foreach(var_2 in var_0)
  var_2 thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_E709(25);

  if(scripts\engine\utility::flag("flag_conference_room_hot")) {
    wait 2;

    if(!scripts\engine\utility::flag("flag_kill_commanders_event"))
      thread _id_C5E8();

    var_4 = scripts\sp\utility::_id_22CD("gone_hot_reinforcements");
  }
}

_id_8946() {
  thread _id_EA64();
  level._id_E99E["trig_armory_door_exit"] _id_0F05::_id_AED6(0);
  level._id_E99E["hub_bow_exit_door"].scripted = 1;
  level._id_E99E["hub_bow_exit_door"] thread _id_0F05::_id_E9A2();
  scripts\engine\utility::array_thread(getspawnerarray("post_gas_enemies1"), scripts\sp\utility::_id_1747, ::_id_FA20);
  scripts\engine\utility::array_thread(getspawnerarray("hubbow_post_gas_enemies"), scripts\sp\utility::_id_1747, ::_id_FA20);
  scripts\engine\utility::array_thread(getspawnerarray("hubbow_post_gas_runners"), scripts\sp\utility::_id_1747, ::_id_FA20, 1);
  scripts\engine\utility::array_thread(getspawnerarray("salter_exfil_enemies1"), scripts\sp\utility::_id_1747, ::_id_FA20);

  if(istransientloaded("sa_assassination_destroyer_keel_tr"))
    unloadtransient("sa_assassination_destroyer_keel_tr");

  scripts\engine\utility::flag_wait("flag_post_gas_enemies1");
  level.player scripts\sp\utility::_id_F416(1);
  var_0 = scripts\sp\utility::_id_22CD("post_gas_enemies1");
  scripts\engine\utility::flag_wait("flag_hubbow_post_gas");
  thread _id_F049();

  if(scripts\engine\utility::flag("death_post_gas_enemies1"))
    level.player scripts\sp\utility::_id_F416(1);

  var_1 = scripts\sp\utility::_id_22CD("hubbow_post_gas_enemies", 1, 1);
  var_2 = scripts\sp\utility::_id_22CD("hubbow_post_gas_runners", 1, 1);
  thread _id_895A();
  var_3 = getspawner("salter_exfil", "targetname");
  level._id_EA2C = var_3 scripts\sp\utility::_id_10619(1, 1);
  wait 0.2;
  level._id_EA2C._id_1FBB = "salter";
  level._id_EA2C _id_0F16::isfirstarmageddonmeteorhit("iw7_crb", "primary");
  level._id_EA2C scripts\sp\utility::_id_F39F();
  scripts\engine\utility::flag_wait("flag_salter_exfil_enemies1");

  if(scripts\engine\utility::flag("death_post_gas_enemies2"))
    level.player scripts\sp\utility::_id_F416(1);

  var_4 = scripts\sp\utility::_id_22CD("salter_exfil_enemies1");
  thread cleanup_conference_room_ents();
  scripts\engine\utility::flag_set("flag_salter_spawned");
  thread _id_8958();
}

_id_86A7() {
  self endon("death");
  self addaieventlistener("grenade danger");
  self addaieventlistener("explode");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "ai_events");
  scripts\sp\utility::_id_57D6();
  self notify("damaged_by_explosion_or_shotat");
}

_id_895A() {
  var_0 = scripts\engine\utility::getStruct("sa02_hub_chaos", "targetname");
  var_1 = [];
  var_1[var_1.size] = level._id_9126;
  var_1[var_1.size] = level._id_9129;
  var_1[var_1.size] = level._id_912A;

  foreach(var_3 in var_1)
  var_3 scripts\sp\utility::_id_F2A8(1);

  var_0 scripts\sp\anim::_id_1F2C(var_1, "sdf_meetup");
}

_id_EA64() {
  scripts\engine\utility::flag_wait_any("flag_salter_exfil_vo", "flag_conference_room_hot");

  if(scripts\engine\utility::flag("flag_conference_room_hot"))
    wait 2.5;

  scripts\sp\utility::_id_10350("asn_slt_reyesigotcompany");
  level.player scripts\sp\utility::_id_1034D("asn_plr_copymovingtosecondary");
  scripts\sp\utility::_id_10350("asn_slt_static1");
  level.player scripts\sp\utility::_id_1034D("asn_plr_fever");
  level.player scripts\sp\utility::_id_1034D("asn_plr_raidertofeverhow");
  scripts\sp\utility::_id_10350("asn_slt_static2");
}

_id_F049() {
  scripts\engine\utility::flag_wait("flag_move_on_to_salter");
  level.player _id_0E45::_id_5524();
  wait 4;

  if(isDefined(level._id_9126) && isalive(level._id_9126))
    level._id_9126 scripts\sp\utility::_id_10347("asn_sdf2_moveitwecant");

  level.player scripts\sp\utility::_id_1034D("asn_plr_comply");
  wait 3;
  level.player scripts\sp\utility::_id_1034D("asn_plr_comingtoyasalt");
  scripts\engine\utility::flag_wait("flag_near_salter");

  if(isDefined(level._id_9126) && isalive(level._id_9126))
    level._id_9126 scripts\sp\utility::_id_10347("asn_sdf2_weaponsready");
}

_id_FA20(var_0) {
  thread _id_86A7();
  scripts\sp\utility::_id_65E0("provoked");

  if(isDefined(var_0))
    thread _id_513B();

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "hub_captain") {
    level._id_9126 = self;
    level._id_9126._id_1FBB = "hub_captain";
    level._id_9126 thread _id_8948("captain9");
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "hub_grunt1") {
    level._id_9129 = self;
    level._id_9129._id_1FBB = "hub_grunt1";
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "hub_grunt2") {
    level._id_912A = self;
    level._id_912A._id_1FBB = "hub_grunt2";
  }

  thread _id_8915();
  thread _id_88CD();
  level.player notifyonplayercommand("player_attack", "+attack");
  level.player notifyonplayercommand("player_attack", "+attack_akimbo_accessible");
  thread waittill_damaged_by_player();
  thread waittill_attacked_by_player();
  level scripts\engine\utility::waittill_either("player_attacked", "_attacked_by_player");
  level.player scripts\sp\utility::_id_65DD("stealth_enabled");
  scripts\engine\utility::flag_set("flag_to_salter_hot");
  wait 0.5;

  if(isDefined(self) && isalive(self)) {
    scripts\sp\utility::_id_65E1("provoked");
    self notify("provoked");
    self setgoalpos(self.origin);
    scripts\engine\utility::waitframe();
    scripts\sp\utility::_id_D282();
  }

  level.player scripts\sp\utility::_id_F416(0);
  _id_E1E5();
  scripts\engine\utility::flag_clear("flag_conference_room_hot");
}

waittill_damaged_by_player() {
  level.player waittill("player_attack");
  level notify("player_attacked");
}

waittill_attacked_by_player() {
  self waittill("damaged_by_player");
  level notify("_attacked_by_player");
}

_id_88CD() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(var_1 == level.player) {
      break;
    }

    wait 0.2;
  }

  self notify("damaged_by_player");
}

_id_8904() {
  thread _id_8905();

  for(;;) {
    self waittill("gunshot", var_0);

    foreach(var_2 in var_0) {
      if(isDefined(var_2.entity) && var_2.entity == level.player) {
        break;
      }
    }

    wait 0.2;
  }

  self notify("gunshot_by_player");
}

_id_8905() {
  for(;;) {
    self waittill("silenced_shot", var_0);

    foreach(var_2 in var_0) {
      if(isDefined(var_2.entity) && var_2.entity == level.player) {
        break;
      }
    }

    wait 0.2;
  }

  self notify("gunshot_by_player");
}

_id_8915() {
  self endon("death");
  scripts\sp\utility::_id_65E3("provoked");
  scripts\sp\utility::anim_stopanimScripted();
  var_0 = randomintrange(1, 5);

  switch (var_0) {
    case 1:
      if(isDefined(self) && isalive(self))
        scripts\sp\utility::_id_10347("asn_sdf1_intruder");

      break;
    case 2:
      if(isDefined(self) && isalive(self))
        scripts\sp\utility::_id_10347("asn_sdf1_securethecommanders");

      break;
    case 3:
      if(isDefined(self) && isalive(self))
        scripts\sp\utility::_id_10347("asn_sdf2_hesoneofours");

      break;
    case 4:
      if(isDefined(self) && isalive(self))
        scripts\sp\utility::_id_10347("asn_sdf2_shoottokill");

      break;
    case 5:
      if(isDefined(self) && isalive(self))
        scripts\sp\utility::_id_10347("asn_sdf3_alertthebridgeshots");

      break;
  }
}

_id_513B() {
  self endon("death");
  self endon("provoked");
  self waittill("reached_path_end");
  self delete();
}

_id_8958() {
  scripts\engine\utility::flag_wait("flag_near_salter");
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132BE(1);
  level.player scripts\sp\utility::_id_1034D("asn_plr_salterimbehindem");

  if(!scripts\engine\utility::flag("flag_to_salter_hot")) {
    while(scripts\sp\utility::_id_77DB("salter_enemies") > 0)
      wait 0.2;
  }

  scripts\engine\utility::flag_set("flag_rescued_salter");
  scripts\engine\utility::flag_wait("flag_at_salter");
  level.player scripts\sp\utility::_id_F416(0);
  _id_E1E5();
  thread _id_E1BC();
  wait 1;
  level._id_EA2C scripts\sp\utility::_id_F3B5("r");
  level._id_EA2C scripts\sp\utility::_id_F39E();
  thread _id_8956();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_7413();
  scripts\sp\utility::_id_CF8D();
  level._id_E99E["exfil_door_interior"] _id_0F05::_id_12BD3(undefined, "tag_ui_back");
}

_id_E1E5() {
  if(!isDefined(level.player._id_4C29) || level.player._id_4C29.size == 0) {
    return;
  }
  foreach(var_1 in level.player._id_4C29) {
    var_1._id_5BD7 scripts\sp\utility::_id_F416(0);
    var_1._id_5BD7 scripts\sp\utility::_id_F415(0);
  }
}

_id_E1BC() {
  setmusicstate("mx_101_assassination_joinsalter");
  level.player scripts\sp\utility::_id_1034D("asn_plr_saltyoureclearits");
  level._id_EA2C scripts\sp\utility::_id_10346("asn_slt_ihatethatuniform");
  level._id_EA2C scripts\sp\utility::_id_10346("asn_slt_isetthebeacon");
  level.player scripts\sp\utility::_id_1034D("asn_plr_letsgettothe");
  level._id_EA2C scripts\sp\utility::_id_10346("asn_slt_onyou");
  _id_6931();
}

_id_6931() {
  scripts\engine\utility::flag_wait("flag_exfil_hallway_combat");
  level.player scripts\sp\utility::_id_1034D("asn_plr_retributionthisisactual");
  level._id_EA2C scripts\sp\utility::_id_10346("asn_slt_commsarestillin");
  scripts\engine\utility::flag_wait("flag_exfil_near_airlock");
  level._id_EA2C scripts\sp\utility::_id_10346("asn_slt_igotagreen");
  wait 0.5;
  level.player scripts\sp\utility::_id_1034D("asn_plr_wegottapushout");
}

_id_8956() {
  scripts\sp\utility::_id_15F5("escape_salter_colors1");
  scripts\engine\utility::flag_wait("flag_exfil_near_airlock");
  var_0 = scripts\sp\utility::_id_77DA("exfil_last_enemies");
  scripts\sp\utility::_id_13754(var_0);
  scripts\sp\utility::_id_15F5("trig_salter_goto_exfil");
}

_id_8922() {
  scripts\engine\utility::flag_wait("flag_commanders_killed");
  _id_0A2F::_id_DA45("captain0", 0.5);
  _id_0A2F::_id_DA45("captain2", 0.5);
  _id_0A2F::_id_DA45("captain4", 0.5);
}

_id_8948(var_0, var_1) {
  self waittill("death");

  if(!isDefined(var_1))
    var_1 = 0.5;

  _id_0A2F::_id_DA45(var_0, var_1);
}