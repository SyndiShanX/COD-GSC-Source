/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\townhoused\townhoused_outer.gsc
***************************************************/

apc_exit_sequence(var_0, var_1, var_2) {
  var_0 thread scripts\common\anim::anim_single_solo(var_2, "apc_ride_exit");
  level.apc_exit_counter = var_1.size;
  thread apc_exit_vo();
  scripts\engine\utility::array_thread(var_1, ::apc_exit_thread, var_0);
}

apc_exit_vo() {
  wait 6;
  var_0 = scripts\engine\sp\utility::get_living_ai_array("barrier_cops", "script_noteworthy");
  var_0 = sortbydistance(var_0, level.price.origin);
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_intro_street_20");
  var_0[0] scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_30");
}

apc_exit_thread(var_0) {
  var_0 scripts\common\anim::anim_single_solo(self, "apc_ride_exit");
  self unlink();
  scripts\engine\utility::flag_set("apc_exited");

  if(!scripts\engine\utility::flag("player_passed_barrier")) {
    if(self == level.price) {
      var_1 = ["dx_vom_sastl_intro_street_380", "dx_vom_sastl_intro_street_390"];
      thread scripts\sp\maps\townhoused\townhoused_code.gsc::nag(var_1, "player_passed_barrier");
    }

    var_0 scripts\common\anim::anim_single_solo(self, "apc_ride_exit_into_loop");
    var_0 thread scripts\common\anim::anim_loop_solo(self, "apc_ride_exit_loop", "stop_loop_" + self.animname);
    scripts\engine\utility::flag_wait("player_passed_barrier");

    if(self == level.price) {
      level.price stopsounds();
      var_2 = ["dx_vom_sastl_intro_street_400", "dx_vom_sastl_intro_street_410", "dx_vom_sastl_intro_street_420"];
      level.price thread scripts\engine\sp\utility::smart_dialogue(var_2[randomint(var_2.size)]);
    }

    var_0 notify("stop_loop_" + self.animname);
    var_0 scripts\common\anim::anim_single_solo(self, "apc_ride_exit_outof_loop");
  } else
    var_0 scripts\common\anim::anim_single_solo(self, "apc_ride_exit_into_movement");

  if(self.animname == "bravo1")
    thread bravo1_street_movement();

  thread street_movement_completed();
  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(self, "street_movement", "gate_approach_pre_idle", "stop_loop_gate_approach");
}

street_movement_completed() {
  self waittillmatch("single anim", "end");
  level.apc_exit_counter--;

  if(level.apc_exit_counter == 0) {
    level.apc_exit_counter = undefined;
    scripts\engine\utility::flag_set("street_movement_done");
  }
}

bravo1_street_movement() {
  level.bravo1 waittillmatch("single anim", "end");
  level.bravo1.goalradius = 32;
  level.bravo1 setgoalpos(level.bravo1.origin);
  scripts\engine\utility::flag_wait_all("apc_exited", "player_approaching_alley_gate");
  var_0 = getnode("bravo1_street_node", "targetname");
  level.bravo1.goalradius = 32;
  level.bravo1 setgoalnode(var_0);
}

apc_exit_cops_sequence(var_0, var_1, var_2) {
  var_1[0] thread scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_10");

  foreach(var_4 in var_2)
  var_0 thread scripts\common\anim::anim_single_solo(var_4, "open_barrier");

  foreach(var_7 in var_1)
  var_0 thread scripts\common\anim::anim_single_solo(var_7, "open_barrier");

  var_7 = scripts\sp\maps\townhoused\townhoused_code.gsc::get_longest_anim_ent(var_1, "open_barrier");
  var_7 waittillmatch("single anim", "end");

  foreach(var_7 in var_1)
  var_0 thread scripts\common\anim::anim_loop_solo(var_7, "open_barrier_loop", "stop_open_barrier_loop");

  scripts\engine\utility::flag_wait("player_passed_barrier");

  foreach(var_4 in var_2)
  var_0 thread scripts\common\anim::anim_single_solo(var_4, "close_barrier");

  foreach(var_7 in var_1) {
    var_0 notify("stop_open_barrier_loop");
    var_7 scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(var_7, "close_barrier", "close_barrier_loop", "stop_barrier_cop_idle");
  }

  scripts\engine\utility::flag_wait("player_in_backyard");
  var_0 notify("stop_barrier_cop_idle");
  scripts\engine\utility::array_delete(var_1);
}

get_cop_barriers() {
  var_0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var_1 = [];

  for(var_2 = 1; var_2 <= 2; var_2++) {
    var_3 = scripts\engine\sp\utility::spawn_anim_model("barrier" + var_2);
    var_1[var_1.size] = var_3;
  }

  foreach(var_5 in var_1)
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_5, "open_barrier");

  return var_1;
}

extra_street_alles_movement() {
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("extra_street_allies");
  var_1 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var_2 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["extra1"]["approach_alley"]);
  var_0 = sortbydistance(var_0, var_2);

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_0[var_3].animname = "extra" + (var_3 + 1);
    var_0[var_3] thread extra_street_alles_movement_internal(var_1);
  }
}

extra_street_alles_movement_internal(var_0) {
  var_1 = "approach_alley";
  var_0 scripts\sp\anim::anim_reach_solo(self, var_1);
  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(self, var_1, undefined, "stop_approach_alley_loop");
}

spawn_padlock() {
  level.gatelock = scripts\engine\sp\utility::spawn_anim_model("gate_lock");
  var_0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var_0 scripts\common\anim::anim_first_frame_solo(level.gatelock, "gate_cut");
}

init_bravo_gate() {
  var_0 = scripts\engine\utility::getStruct("bravo_gate_animnode", "targetname");
  var_1 = getEntArray("bravo_gates", "targetname");

  foreach(var_3 in var_1)
  var_3 scripts\engine\sp\utility::assign_animtree(var_3.script_animname);

  var_0 scripts\common\anim::anim_first_frame(var_1, "bravo_apc_entry");
  var_5 = scripts\engine\sp\utility::array_spawn_noteworthy("bravo_gate_cops");

  foreach(var_7 in var_5) {
    var_7 scripts\common\ai::gun_remove();
    scripts\engine\sp\utility::add_cleanup_ent(var_7, "street");
  }

  thread bravo_gate_vo(var_5);
  var_0 thread scripts\common\anim::anim_loop(var_5, "bravo_apc_start_loop");
  scripts\engine\utility::flag_set("bravo_gate_setup");
}

bravo_gate_open() {
  if(!scripts\engine\utility::flag("bravo_gate_setup"))
    init_bravo_gate();

  var_0 = scripts\engine\utility::getStruct("bravo_gate_animnode", "targetname");
  var_0 notify("stop_loop");
  var_1 = scripts\engine\sp\utility::get_living_ai_array("bravo_gate_cops", "script_noteworthy");
  var_2 = getEntArray("bravo_gates", "targetname");
  var_3 = scripts\engine\utility::array_combine(var_1, var_2);
  thread bravo_gate_vo_open(var_1);
  var_0 scripts\common\anim::anim_single(var_3, "bravo_apc_entry");
  var_0 thread scripts\common\anim::anim_loop(var_1, "bravo_apc_end_loop");
}

bravo_gate_vo(var_0) {
  level endon("stop_bravo_gate_vo");
  scripts\engine\utility::flag_wait("player_passed_barrier");
  var_0[0] scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_430");
  wait 0.5;
  var_0[1] scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_440");
  wait 0.4;
  var_0[0] scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_450");
  wait 0.2;
  var_0[1] scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_460");
}

bravo_gate_vo_open(var_0) {
  level notify("stop_bravo_gate_vo");
  var_0[0] stopsounds();
  var_0[1] stopsounds();
  waitframe();
  var_0[1] scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_470");
  wait 11.5;
  var_0[1] scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_480");
}

postspawn_barrier_cop() {
  scripts\common\ai::gun_remove();
  scripts\engine\sp\utility::add_cleanup_ent(self, "street");
}

apc_bravo_sounds_start() {
  wait 5.3;
  self playSound("sp_lvl_townhouse_bear_cat_2_pullup");
  wait 4;
  self playSound("sp_lvl_townhouse_bear_cat_2_door_open");
  wait 2.5;
  self playSound("sp_lvl_townhouse_bear_cat_2_door_close");
}

street_jogger() {
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("jogger", 1);
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    scripts\engine\sp\utility::add_cleanup_ent(var_4, "street");

    if(var_4.animname == "jogger") {
      var_1 = var_4;
      continue;
    }

    var_2 = var_4;
  }

  scripts\engine\utility::array_thread(var_0, scripts\common\ai::gun_remove);
  var_6 = scripts\engine\utility::getStruct("jogger_animnode", "targetname");
  var_6 scripts\common\anim::anim_first_frame(var_0, "jog");
  scripts\engine\utility::flag_wait("start_player_exit_apc");
  wait 4;
  thread street_jogger_vo(var_2, var_1);
  var_6 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop(var_0, "jog");
}

street_jogger_vo(var_0, var_1) {
  wait 5.5;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_310");
  wait 1;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm3_intro_street_320");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_330");
  wait 1;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm3_intro_street_340");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_350");
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm3_intro_street_360");
  wait 0.4;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_370");
}

street_knocknock() {
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("door_knocker", 1);
  var_1 = scripts\engine\utility::getStruct("knock_knock_animnode", "targetname");
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    if(var_5.animname == "cop")
      var_2 = var_5;
    else
      var_3 = var_5;

    var_5 scripts\common\ai::gun_remove();
    scripts\engine\sp\utility::add_cleanup_ent(var_5, "street");
  }

  var_7 = getEnt("knock_knock_door", "targetname");
  var_7 scripts\engine\sp\utility::assign_animtree("door");
  var_1 scripts\common\anim::anim_first_frame_solo(var_7, "knock_knock");
  var_1 scripts\common\anim::anim_first_frame(var_0, "knock_knock");
  var_8 = scripts\engine\utility::array_add(var_0, var_7);
  scripts\engine\utility::flag_wait("start_player_exit_apc");
  wait 4;
  thread street_knocknock_vo(var_2, var_3);
  var_1 thread scripts\common\anim::anim_single(var_8, "knock_knock");
  var_3 thread delete_on_animend();
  var_2 waittillmatch("single anim", "end");
  var_1 thread scripts\common\anim::anim_loop_solo(var_2, "knock_knock_loop");
}

street_knocknock_vo(var_0, var_1) {
  wait 15;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_140");
  wait 0.4;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm3_intro_street_150");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_160");
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm3_intro_street_170");
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm3_intro_street_180");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_190");
}

woman_onlooker() {
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("woman_onlooker", 1);
  var_1 = scripts\engine\utility::getStruct("woman_onlooker_animnode", "targetname");
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    if(var_5.animname == "cop")
      var_2 = var_5;
    else {
      var_3 = var_5;
      var_3 attach("p7_cup_coffee_mug", "tag_accessory_right");
    }

    var_5 scripts\common\ai::gun_remove();
    scripts\engine\sp\utility::add_cleanup_ent(var_5, "street");
  }

  var_7 = getEnt("woman_onlooker_door", "targetname");
  var_7 scripts\engine\sp\utility::assign_animtree("door");
  var_1 scripts\common\anim::anim_first_frame_solo(var_7, "drink_tea_back");
  var_1 scripts\common\anim::anim_first_frame(var_0, "drink_tea");
  var_8 = scripts\engine\utility::array_add(var_0, var_7);
  scripts\engine\utility::flag_wait("player_exited_apc");
  thread woman_onlooker_vo(var_2, var_3);
  var_1 scripts\common\anim::anim_single(var_0, "drink_tea");
  var_1 thread scripts\common\anim::anim_loop(var_0, "drink_tea_loop");
  scripts\engine\utility::flag_wait("player_half_street");
  wait(randomfloat(2.5));
  thread woman_onlook_vo2(var_2, var_3);
  wait 2;
  var_1 thread scripts\common\anim::anim_single(var_8, "drink_tea_back");
  var_3 thread delete_on_animend();
  var_2 waittillmatch("single anim", "end");
  var_1 notify("stop_loop");
  var_1 thread scripts\common\anim::anim_loop_solo(var_2, "drink_tea_end_loop");
}

woman_onlooker_vo(var_0, var_1) {
  level endon("stop_onlooker_vo");
  wait 7;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvf1_intro_street_200");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_210");
  wait 1;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvf1_intro_street_220");
  wait 0.3;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_230");
  wait 0.5;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvf1_intro_street_240");
}

woman_onlook_vo2(var_0, var_1) {
  level notify("stop_onlooker_vo");
  var_0 stopsounds();
  var_1 stopsounds();
  waitframe();
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_250");
  thread woman_onlook_vo2_thread(var_0, var_1);
}

woman_onlook_vo2_thread(var_0, var_1) {
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvf1_intro_street_260");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_270");
  wait 1;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvf1_intro_street_280");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_290");
}

delete_on_animend() {
  self endon("death");
  self waittillmatch("single anim", "end");
  self delete();
}

init_onlookers() {
  var_0 = scripts\engine\utility::getStructArray("onlooker", "targetname");
  scripts\engine\utility::array_thread(var_0, ::onlooker);
}

onlooker(var_0) {
  scripts\engine\utility::script_delay();
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(self.script_light)) {
    var_1 = getEnt(self.script_light, "targetname");
    var_2 = var_1 getlightintensity();
    var_1 setlightintensity(0);
  }

  if(isDefined(self.script_flag_wait))
    scripts\engine\utility::flag_wait(self.script_flag_wait);

  if(isDefined(var_1))
    var_1 setlightintensity(var_2);

  var_3 = getspawnerarray(self.target);
  var_4 = scripts\engine\sp\utility::array_spawn(var_3, 1);
  scripts\engine\utility::array_thread(var_4, ::delete_on_animend);
  thread onlooker_vo(self.script_animation);
  thread scripts\common\anim::anim_single(var_4, self.script_animation);
}

onlooker_vo(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "window1":
      var_1 = [];
      var_1[0] = ["dx_vom_cvm1_intro_street_40", 1];
      var_1[1] = ["dx_vom_cvm2_intro_street_50", 1];
      var_1[2] = ["dx_vom_cvm1_intro_street_60", 1];
      var_1[3] = ["dx_vom_cvm2_intro_street_70"];
      break;
    case "window2":
      wait 7;
      var_1[0] = ["dx_vom_cvf1_intro_street_80", 1];
      var_1[1] = ["dx_vom_cvm3_intro_street_90", 0.2];
      var_1[2] = ["dx_vom_cvf1_intro_street_100", 2];
      var_1[3] = ["dx_vom_cvm3_intro_street_110", 0.5];
      var_1[4] = ["dx_vom_cvf1_intro_street_120", 2];
      var_1[5] = ["dx_vom_cvf1_intro_street_130"];
      break;
  }

  onlooker_vo_thread(var_1);
}

onlooker_vo_thread(var_0) {
  var_1 = spawn("script_origin", self.origin);
  var_1 scalevolume(0.2);

  foreach(var_3 in var_0) {
    var_1 playSound(var_3[0], "sounddone");
    var_1 waittill("sounddone");

    if(isDefined(var_3[1]))
      wait(var_3[1]);
  }
}

alley_gate_open(var_0) {
  scripts\engine\utility::delaythread(5, scripts\sp\maps\townhoused\townhoused_code.gsc::train_go, "south");
  level.price thread alley_price_anim(var_0);
  thread scripts\engine\utility::play_sound_in_space("sp_lvl_townhouse_cut_fence", (-1593, -234, -388));
  level.alpha1.boltcutters unlink();
  var_1 = get_alley_gate();
  var_2 = [level.alpha1, level.gatelock, level.alpha1.boltcutters, var_1];

  foreach(var_4 in var_2)
  var_0 thread scripts\common\anim::anim_single_solo(var_4, "gate_cut");

  level.alpha1 waittillmatch("single anim", "end");
  var_0 notify("stop_loop_gate_approach_alpha1");
  var_0 thread scripts\common\anim::anim_loop_solo(level.alpha1, "gate_cut_post_idle", "stop_loop_alpha1_through_gate");
}

get_alley_gate() {
  var_0 = getEnt("alley_gate", "targetname");

  if(!isDefined(var_0.clip)) {
    var_0 scripts\engine\sp\utility::assign_animtree("gate");
    var_0.clip = getEnt("alley_gate_clip", "targetname");
    var_0.clip linkTo(var_0);
    var_0.pivot = getEnt(var_0.target, "targetname");
    var_0.pivot delete();
  }

  return var_0;
}

close_alley_gate() {
  var_0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var_1 = get_alley_gate();
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "gate_cut");
}

alley_price_anim(var_0) {
  level endon("warehouse_entrance_price_teleported");
  level.price scripts\engine\utility::delaythread(0.2, scripts\engine\sp\utility::smart_dialogue, "dx_vom_sastl_intro_alley_20");
  level.price scripts\engine\utility::delaythread(4.5, scripts\engine\sp\utility::smart_dialogue, "dx_vom_sastl_intro_alley_30");
  level.price scripts\engine\utility::delaythread(10, scripts\engine\sp\utility::smart_dialogue, "dx_vom_sastl_intro_alley_50");
  level.price scripts\engine\utility::delaythread(17, scripts\engine\sp\utility::smart_dialogue, "dx_vom_sastl_intro_alley_60");
  var_0 scripts\common\anim::anim_single_solo(self, "alley_move");

  if(!scripts\engine\utility::flag("cellphone_guy_executed"))
    level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_garage_ext_80");

  var_0 thread scripts\common\anim::anim_loop_solo(self, "alley_end_idle", "stop_loop_price_alley_end");
  scripts\engine\utility::flag_set("price_at_end_of_alley");
}

alley_ctbuddy_anim(var_0) {
  level endon("move_bravo_through_gate");
  var_0 scripts\common\anim::anim_single_solo(self, "alley_enter");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "alley_enter_loop", "stop_loop_ctbuddy");
}

alley_approach_garage(var_0) {
  scripts\engine\utility::flag_wait_all("price_at_end_of_alley", "player_at_end_of_alley", "cellphone_guy_executed");
  var_0 notify("stop_loop_price_alley_end");
  thread garage_approach_vo();
  var_0 scripts\common\anim::anim_single_solo(level.price, "garage_entry_arrive");
  var_0 thread scripts\common\anim::anim_loop_solo(level.price, "garage_entry_arrive_loop", "stop_loop_price_warehouse");
  scripts\engine\utility::flag_set("price_ready_for_garage_entry");
}

garage_approach_vo() {
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_a21_garage_ext_10");
  wait 0.3;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_brv2_garage_ext_20");
}

postspawn_cellphone_guy() {
  var_0 = scripts\engine\utility::getStruct("garage_door_animnode", "targetname");
  scripts\anim\shared.gsc::forceuseweapon(self.sidearm, "primary");
  scripts\common\ai::gun_remove();
  scripts\sp\utility::context_melee_allow(0);
  self.script_forcegoal = 1;
  self.goalradius = 64;
  self.skipdeathanim = 1;
  self.allowdeath = 1;
  self.animnode = var_0;
  self.cellphone = scripts\engine\sp\utility::spawn_anim_model("cellphone_on");
  self.cellphone linkTo(self, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  level thread kill_cellphone_guy(self);
  level thread cellphone_guy_ondeath(self);
  thread cellphone_guy_vo();
  var_0 scripts\sp\anim::anim_react([self], "cellphone", ::cellphone_react);
}

cellphone_react(var_0) {
  self endon("death");

  if(var_0 != "death") {
    var_1 = scripts\engine\utility::getanim("cellphone_react");
    scripts\common\ai::gun_recall();
    thread scripts\common\anim::anim_single_solo(self, "cellphone_react");
    var_2 = getanimlength(var_1);
    var_3 = 2.5 / var_2;
    waitframe();
    self setanimtime(var_1, var_3);
    self.radius = 100;
    self setgoalpos(self.origin);
    self waittillmatch("single anim", "end");
    return "skip_reaction";
  }
}

cellphone_guy_vo() {
  self endon("damage");
  self endon("death");
  wait 2;
  scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_garage_ext_30");
  wait 2;
  scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_garage_ext_40");
  wait 4;
  scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_garage_ext_50");
  wait 3;
  scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_garage_ext_60");
  wait 2;
  scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_garage_ext_70");
}

kill_cellphone_guy(var_0) {
  var_0 endon("death");
  var_0 waittillmatch("single anim", "end");
  var_1 = scripts\engine\utility::getStruct("garage_door_animnode", "targetname");
  scripts\engine\utility::flag_wait("execute_cellphone_guy");
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_garage_ext_90");
  wait 2;
  level.price thread scripts\sp\maps\townhoused\townhoused_code.gsc::ally_shoot_enemy(var_0, undefined, "tag_eye");
}

cellphone_guy_ondeath(var_0) {
  var_0 waittill("death");
  scripts\engine\utility::flag_set("cellphone_guy_executed");
}

cellphone_use_deathanim(var_0) {
  var_0.skipdeathanim = undefined;
  var_0.deathfunction = ::cellphone_deathanim;
}

cellphone_deathanim() {
  var_0 = "cellphone_death";
  self.animnode thread scripts\common\anim::anim_single(level.tire_rigs, "cellphone_death");
  self.disabledeathorient = 1;
  scripts\sp\maps\townhoused\townhoused_code.gsc::scripted_deathanim("cellphone_death", self.animnode);
}

garage_tires() {
  var_0 = scripts\engine\utility::getStruct("garage_door_animnode", "targetname");
  var_1 = "com_junktire";
  var_2 = 26;
  var_3 = 12;
  var_4 = var_2 / var_3;
  level.tire_rigs = [];
  var_5 = 0;

  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_7 = scripts\engine\sp\utility::spawn_anim_model("tires", var_0.origin, var_0.angles);
    level.tire_rigs[level.tire_rigs.size] = var_7;

    for(var_8 = 1; var_8 <= var_3; var_8++) {
      var_5++;

      if(var_5 > var_2) {
        break;
      }

      if(var_5 < 10)
        var_9 = "0" + var_5;
      else
        var_9 = var_5;

      var_10 = "j_tire" + var_9;
      var_7 attach(var_1, var_10, 1);
    }
  }

  var_0 scripts\common\anim::anim_first_frame(level.tire_rigs, "cellphone_death");
}

postspawn_garage_enemy() {
  self.allowdeath = 1;

  if(self.animname == "bombmaker") {
    var_0 = scripts\engine\sp\utility::spawn_anim_model("garage_bombmaker_chair", self.origin, self.angles);
    self.animents = [var_0];
  } else {
    var_1 = get_garage_milk_crate();
    var_1.parenttag = "tag_accessory_left";
    var_1 linkTo(self, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
    var_1.overridevelocity = anglesToForward((90, 20, 120)) * 50;
    self.animreactrelative = 1;
    self.linkedaniments = [var_1];
    self.radius = 10;
  }

  thread garage_enemy_going_hot();
}

garage_enemy_going_hot() {
  self endon("death");
  self waittill("shooting");
  scripts\engine\utility::flag_set("garage_hot");
  scripts\engine\utility::flag_set("player_near_garage_office");
}

precache_garage_milk_crate() {
  var_0 = scripts\engine\utility::getStruct("garage_milk_crate", "targetname");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_1[var_1.size] = var_0;

  foreach(var_3 in var_1)
  precachemodel(var_3.script_modelname);
}

get_garage_milk_crate() {
  var_0 = scripts\engine\utility::getStruct("garage_milk_crate", "targetname");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel(var_0.script_modelname);
  var_2.children = [];

  foreach(var_4 in var_1) {
    var_5 = spawn("script_model", var_4.origin);
    var_5 setModel(var_4.script_modelname);
    var_5.angles = var_4.angles;
    var_5 linkTo(var_2);
    var_2.children[var_2.children.size] = var_5;
  }

  return var_2;
}

garage_knock() {
  scripts\engine\utility::flag_wait("price_ready_for_garage_entry");
  var_0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var_0 notify("stop_loop_price_warehouse");
  var_1 = scripts\engine\sp\utility::spawn_targetname("garage_knock_enemy");
  level.garage_knock_enemy = var_1;
  var_1 scripts\common\ai::gun_remove();
  var_1.allowdeath = 1;
  var_1 scripts\sp\utility::context_melee_allow(0);
  var_2 = [level.price, var_1];
  var_0 = scripts\engine\utility::getStruct("garage_door_animnode", "targetname");
  var_3 = scripts\sp\door::get_interactive_door("warehouse_entrance_door");
  thread garage_knock_vo();
  var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_door(var_3, "garage_knock");
  var_0 thread scripts\common\anim::anim_single(var_2, "garage_knock");
  wait 12;
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  var_4 = scripts\engine\utility::getStruct("garage_entry_price_start", "targetname");
  level.price scripts\engine\utility::set_movement_speed(110);
  level.price.goalradius = 32;
  level.price setgoalpos(var_4.origin);
  level.price waittill("goal");
  scripts\engine\utility::flag_set("price_inside_garage");
  thread scripts\engine\utility::add_dialogue_line("Price", "This place is filled with explosives.");
  wait 2;
  thread scripts\engine\utility::add_dialogue_line("Price", "Watch your fire...");
  wait 1;
  thread scripts\engine\utility::add_dialogue_line("Price", "Uhh. Put your nods on. They have IR tripwires in here.");
  wait 2;
  level.price scripts\asm\gesture::ai_request_gesture("nvg_on");
  wait 2;
  var_5 = getnode("warehouse_entrance_alpha2", "targetname");
  level.price setgoalnode(var_5);
  level.price waittill("goal");
  var_0 = scripts\engine\utility::getStruct("garage_animnode", "targetname");
  thread garage_entry_dialog(var_0);
  level.price scripts\engine\sp\utility::set_force_color("y");
  scripts\engine\sp\utility::activate_trigger("garage_colors", "targetname");
}

garage_entry_dialog(var_0) {
  var_0 endon("anim_condition_react");
  wait 1;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_garage_mount_90");
}

garage_knock_vo() {
  wait 1;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_garage_ext_100");
  wait 0.5;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_garage_ext_110");
}

garage_tv() {
  setsaveddvar("MMRNLMPPLT", "0");
  cinematicingameloop("sp_townhouse_propaganda_temp");
  var_0 = scripts\engine\utility::getStruct("garage_tv_speaker", "targetname");
  var_1 = scripts\engine\utility::play_loopsound_in_space("sp_lvl_townhouse_propaganda_garage", var_0.origin);
  var_2 = getscriptablearray("garage_tv_01", "targetname");
  var_2[0] waittill("death");
  var_1 delete();

  if(iscinematicplaying())
    stopcinematicingame();
}

postspawn_garage_office_enemy() {
  thread garage_ambusher();
}

postspawn_garage_office_alerter() {
  level thread garage_office_alert_thread(self);
}

garage_office_alert_thread(var_0) {
  garage_office_alert_wait(var_0);
  scripts\engine\utility::flag_set("garage_hot");
}

garage_office_alert_wait(var_0) {
  level endon("player_near_garage_office");
  var_0 scripts\engine\utility::waittill_any("reached_path_end", "death", "enemy");
}

garage_ambusher(var_0) {
  self endon("death");
  thread garage_ambush_thread(var_0);
  scripts\engine\sp\utility::disable_surprise();
  var_1 = scripts\engine\utility::get_target_array(self.target);

  for(var_2 = var_1[randomint(var_1.size)]; isDefined(var_2); var_2 = scripts\engine\utility::get_target_ent(var_2.target)) {
    if(isDefined(var_2.radius))
      self.goalradius = var_2.radius;

    if(isstruct(var_2))
      self setgoalpos(var_2.origin);
    else if(isnode(var_2))
      self setgoalnode(var_2);
    else if(var_2.code_classname == "info_volume") {
      scripts\engine\utility::ent_flag_wait("leave_cover");
      self setgoalvolumeauto(var_2);
    }

    self waittill("goal");

    if(!isDefined(var_2.target)) {
      break;
    }
  }
}

garage_ambush_thread(var_0) {
  self endon("death");
  scripts\engine\utility::ent_flag_init("leave_cover");
  scripts\engine\utility::waittill_any("damage", "enemy_visible");

  if(istrue(var_0))
    scripts\engine\utility::flag_set("garage2_light_off");

  self.goalradius = 2048;
}

garage2_temp_sounds() {}

postspawn_garage2_enemy() {
  var_0 = 1;

  if(isDefined(self.script_parameters)) {
    if(self.script_parameters == "noflag")
      var_0 = 0;
  }

  thread garage_ambusher(var_0);
}

garage2_train() {
  wait(randomfloatrange(1, 5));
  var_0 = scripts\engine\utility::getStruct("train_earthquake_org", "targetname");
  level thread scripts\sp\maps\townhoused\townhoused_code.gsc::train_go("south");
}

garage2_scene() {
  thread garage2_lifted_taxi();
}

garage2_lifted_taxi() {}

garage2_carjack(var_0) {
  var_1 = getEnt("garage_carjack_clip", "targetname");
  var_1 setCanDamage(1);
  var_1.health = 100;
  var_1 waittill("damage");
  var_0 thread garage2_lower_carjack();
}

garage2_lower_carjack() {
  garage2_force_combat();
  scripts\engine\utility::flag_set("garage2_lower_carjack");
  var_0 = "lower_carjack";
  var_1 = scripts\engine\utility::getanim(var_0);
  thread scripts\common\anim::anim_single_solo(self, var_0);
}

garage2_easy_light() {
  var_0 = getEnt("garage2_easy_light", "targetname");
  var_0.health = 1000;
  var_0 setCanDamage(1);
  var_1 = getEnt("garage2_aimassist_light", "targetname");
  var_1 enableaimassist();
  var_0 waittill("damage");
  var_2 = getscriptablearray("garage2_lights", "targetname");
  var_3 = var_2[0];

  if(var_3 getscriptablepartstate("onoff") == "death" || var_3 getscriptablepartstate("onoff") == "off") {
    return;
  }
  var_3 scripts\sp\utility::do_damage(100, level.player.origin);
  var_4 = getEntArray("garage2_light_clip", "script_noteworthy");
  scripts\engine\utility::array_delete(var_4);
}

garage2_is_light_off() {
  var_0 = getscriptablearray("garage2_lights", "targetname");
  var_1 = var_0[0];

  if(var_1 getscriptablepartstate("onoff") == "death" || var_1 getscriptablepartstate("onoff") == "off")
    return 1;

  return 0;
}

garage2_force_combat() {}

garage2_price_exit() {
  level.price scripts\engine\sp\utility::disable_ai_color();
  var_0 = scripts\engine\utility::getStruct("scaffolding_animnode", "targetname");
  var_0 scripts\sp\anim::anim_reach_solo(level.price, "garage2_end_loop");
  var_0 thread scripts\common\anim::anim_loop_solo(level.price, "garage2_end_loop", "stop_price_loop");
  var_1 = scripts\sp\door::get_interactive_door("door_garage2_exit");
  var_2 = var_1.cam_structs[0];

  while(var_2.door.snakecam_active)
    waitframe();

  var_3 = getEntArray("garage2_light_clip", "script_noteworthy");
  scripts\engine\utility::array_delete(var_3);
  level.price scripts\engine\sp\utility::set_force_color("r");
  scripts\engine\sp\utility::array_spawn_targetname("bravo2");
}

garage2_exit_vo() {
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_a11_overwatch_scaffold_10");
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_kyle_overwatch_scaffold_20");
}

garage_explosives_init() {
  level.lastgarageexplosion = gettime();
  var_0 = getEntArray("garage_explosive", "targetname");
  scripts\engine\utility::array_thread(var_0, ::garage_explosive_thread);
}

garage_explosive_thread() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isPlayer(var_1)) {
      break;
    }

    if(scripts\sp\maps\townhoused\townhoused_code.gsc::is_explosivedamage(var_4, var_9)) {
      break;
    }
  }

  var_10 = 0;

  if(gettime() - level.lastgarageexplosion < 0.1)
    var_10 = 0.2;

  level.lastgarageexplosion = gettime();
  var_11 = scripts\engine\utility::getStructArray(self.target, "targetname");

  for(var_12 = 0; var_12 < var_11.size; var_12++)
    var_11[var_12] thread garage_explosive_explode(var_10 + var_12 * 0.05);
}

garage_explosive_explode(var_0) {
  if(var_0 > 0)
    wait(var_0);

  var_1 = "c4";

  if(isDefined(self.script_type))
    var_1 = self.script_type;

  playFX(scripts\engine\utility::getfx("c4_explosion"), self.origin);
  radiusdamage(self.origin, 500, 500, 500, undefined, "MOD_EXPLOSIVE");
  thread scripts\engine\utility::play_sound_in_space("claymore_expl_atmo", self.origin);
}

garage_tripwire_init() {
  var_0 = scripts\engine\utility::getStructArray("garage_trip_wire", "targetname");
  scripts\engine\utility::array_thread(var_0, ::tripwire_thread);
}

tripwire_thread() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel(scripts\engine\sp\utility::getmodel("tripwire"));
  var_0.targetname = "tripwire";
  var_1 = "Defuse";
  var_2 = 45;
  var_3 = 80;
  var_4 = 50;
  var_5 = 1;
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), var_1, var_2, var_3, var_4, var_5);
  var_0 thread tripwire_defuse_thread();
  var_0 endon("death");
  var_6 = scripts\engine\utility::getStruct(self.target, "targetname");
  var_0.angles = vectortoangles(var_6.origin - self.origin);
  var_0.length = distance(var_6.origin, self.origin);
  var_7 = var_0.origin + anglesToForward(var_0.angles) * (var_0.length * 0.5);
  var_0.trigger = spawn("trigger_rotatable_radius", var_7, 0, 4, var_0.length);
  var_0.trigger.angles = var_0.angles;
  var_0.trigger endon("death");
  var_0 thread tripwire_trigger_thread();
  var_8 = 0;

  for(;;) {
    var_9 = level.player scripts\sp\nvg\nvg_player::is_nvg_on();

    if(!var_8 && var_9) {
      var_8 = 1;
      var_0 laserforceon();
    } else if(var_8 && !var_9) {
      var_8 = 0;
      var_0 laserforceoff();
    }

    waitframe();
  }
}

tripwire_defuse_thread() {
  self endon("death");
  self waittill("trigger");
  self laserforceoff();
  tripwire_delete_cleanup();
}

tripwire_trigger_thread(var_0) {
  self endon("death");
  self.trigger endon("death");
  self.trigger waittill("trigger");
  playFX(scripts\engine\utility::getfx("c4_explosion"), self.origin);
  radiusdamage(self.origin, 500, 500, 500, undefined, "MOD_EXPLOSIVE");
  thread scripts\engine\utility::play_sound_in_space("claymore_expl_atmo", self.origin);
  tripwire_delete_cleanup(1);
}

tripwire_delete_cleanup(var_0) {
  if(isDefined(self.trigger))
    self.trigger delete();

  if(istrue(var_0))
    self delete();
}

quick_fadeout_in() {
  scripts\sp\hud_util::fade_out(0.05);
  scripts\engine\utility::delaythread(0.2, scripts\sp\hud_util::fade_in, 0.2);
}

switch_to_ground_player_disable(var_0) {
  if(var_0) {
    level.player playerdisabletriggers();
    level.player cleardamageindicators();
    level.player freezecontrols(1);
    level.player takeallweapons();
    level.player hidelegsandshadow();
  } else {
    level.player freezecontrols(0);
    level.player showlegsandshadow();
    level.player playerenabletriggers();
  }
}

switch_to_ground_player_setup() {
  level.player takeallweapons();
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("backyard");
}

cam_fly_up() {
  level.player setstance("stand");
  level.player nightvisiongogglesforceoff();
  switch_to_ground_player_disable(1);
  create_fly_cam();
  var_0 = get_flight_path_up();
  level.player playerlinktoabsolute(level.cammover.mover, "tag_origin");
  cam_fly_path(var_0);
  setsaveddvar("MMRNLMPPLT", "1");
  setsaveddvar("RKMNLRNS", "1");
  cinematicingame("townhouse_temp_transition");
}

cam_fly_down() {
  level.player scripts\common\utility::allow_cinematic_motion(0, "fly_down");
  level.player setstance("stand");
  level.player nightvisiongogglesforceoff();
  switch_to_ground_player_disable(1);
  create_fly_cam();
  var_0 = get_flight_path_down();
  level.player playerlinktoabsolute(level.cammover.mover, "tag_origin");
  cam_fly_path(var_0, 1);
  level.player unlink();
  level.player scripts\common\utility::allow_cinematic_motion(1, "fly_down");
  switch_to_ground_player_disable(0);
  switch_to_ground_player_setup();
}

create_fly_cam() {
  if(isDefined(level.cammover)) {
    return;
  }
  var_0 = (0, level.player getplayerangles()[1], 0);
  var_1 = scripts\engine\utility::spawn_tag_origin(level.player getEye(), var_0);
  var_1.mover = scripts\engine\utility::spawn_tag_origin(level.player.origin, var_0);
  var_1.mover linkTo(var_1);
  var_1.angles = level.player getplayerangles();
  level.cammover = var_1;
}

cam_fly_path(var_0, var_1) {
  var_2 = level.cammover;
  var_3 = 5;
  var_4 = 0;

  if(istrue(var_1)) {
    var_2.origin = var_0[0].origin;
    var_2.angles = var_0[0].angles;
    var_4 = 1;
    var_3 = 3000;
    wait 0.1;

    while(iscinematicplaying())
      waitframe();
  }

  for(var_5 = var_4; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];
    var_7 = var_2.origin;
    var_8 = gettime();
    var_9 = distance(var_6.origin, var_2.origin);
    var_10 = (squared(var_6.speed) - squared(var_3)) / (2 * var_9);

    if(var_10 != 0)
      var_11 = (var_6.speed - var_3) / var_10;
    else
      var_11 = var_9 / var_3;

    var_12 = var_8 + var_11 * 1000;
    var_13 = vectorNormalize(var_6.origin - var_7);
    var_2 rotateTo(var_6.angles, var_11);

    while(gettime() < var_12) {
      waitframe();
      var_14 = (gettime() - var_8) * 0.001;
      var_15 = var_7 + var_13 * (var_3 * var_14 + 0.5 * var_10 * squared(var_14));
      var_2.origin = var_15;
    }

    var_3 = var_6.speed;
  }
}

get_flight_path_up() {
  var_0 = level.cammover;
  var_1 = scripts\engine\utility::getStruct("garage_exit_struct", "targetname");
  var_2 = [];
  var_3 = level.player getEye();
  var_4 = level.player getplayerangles();
  var_5 = var_3[1] + (var_1.origin[1] - var_3[1]) * 0.5;
  var_6 = (var_3[0], var_5, var_3[2]);
  var_7 = length(level.player getvelocity());
  var_7 = max(var_7, 30);
  var_2[var_2.size] = create_path_data(var_6, (7, 90, 0), var_7);
  var_8 = (var_3[0], var_1.origin[1], var_3[2]);
  var_6 = var_8;
  var_2[var_2.size] = create_path_data(var_6, (7, 90, 0), 30);
  var_6 = var_8 + (0, 0, 300);
  var_2[var_2.size] = create_path_data(var_6, (90, 90, 0), 300);
  var_6 = var_8 + (0, -300, 2500);
  var_2[var_2.size] = create_path_data(var_6, (75, 90, 0), 3000);
  return var_2;
}

get_flight_path_down() {
  var_0 = level.cammover;
  var_1 = scripts\engine\utility::getStructArray("start_backyard", "targetname");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "player")
      var_2 = var_4;
  }

  var_6 = level.player_rig gettagangles("tag_camera");
  var_7 = anglesToForward(level.player_rig gettagangles("tag_camera"));
  var_8 = [];
  var_9 = 5000;
  var_10 = 60;
  var_11 = anglesToForward((var_10, var_2.angles[1], 0)) * var_9 * -1;
  var_12 = var_2.origin + var_11;
  var_13 = (var_10, var_2.angles[1], 0);
  var_8[var_8.size] = create_path_data(var_12, var_13, 3000);
  var_9 = 400;
  var_11 = anglesToForward((var_10, var_2.angles[1], 0)) * var_9 * -1;
  var_12 = var_2.origin + var_11;
  var_13 = (var_10, var_2.angles[1], 0);
  var_8[var_8.size] = create_path_data(var_12, var_13, 1000);
  var_9 = 60;
  var_11 = anglesToForward((var_10, var_2.angles[1], 0)) * var_9 * -1;
  var_12 = var_2.origin + (0, 0, 60);
  var_13 = (0, var_2.angles[1], 0);
  var_8[var_8.size] = create_path_data(var_12, var_13, 1);
  return var_8;
}

switch_to_ground_fly() {
  level.player setstance("stand");
  level.player nightvisiongogglesforceoff();
  switch_to_ground_player_disable(1);
  var_0 = scripts\engine\utility::getStruct("snipe_car_animnode", "targetname");
  var_0 scripts\common\anim::anim_first_frame_solo(level.player_rig, "backyard_entry");
  var_1 = getEnt("sniper", "targetname");
  var_2 = scripts\engine\sp\utility::dronespawn_bodyonly(var_1);
  var_2.origin = level.player.origin;
  var_2.angles = level.player.angles;
  waitframe();
  var_3 = (0, level.player getplayerangles()[1], 0);
  var_4 = scripts\engine\utility::spawn_tag_origin(level.player getEye(), var_3);
  var_5 = scripts\engine\utility::spawn_tag_origin(level.player.origin, var_3);
  var_5 linkTo(var_4);
  var_4.origin = var_4.origin + (0, 0, 100);
  var_4.angles = (90, var_3[1], 0);
  var_6 = get_flight_path(var_4);
  level.player playerlinktoabsolute(var_5, "tag_origin");
  var_7 = 0;
  var_8 = 50;
  var_9 = 5;
  var_10 = 5;

  foreach(var_12 in var_6) {
    var_13 = var_4.origin;
    var_14 = gettime();
    var_15 = distance(var_12.origin, var_4.origin);
    var_16 = (squared(var_12.speed) - squared(var_10)) / (2 * var_15);

    if(var_16 != 0)
      var_17 = (var_12.speed - var_10) / var_16;
    else
      var_17 = var_15 / var_10;

    var_18 = var_14 + var_17 * 1000;
    var_19 = vectorNormalize(var_12.origin - var_13);
    var_4 rotateTo(var_12.angles, var_17);

    while(gettime() < var_18) {
      waitframe();
      var_20 = (gettime() - var_14) * 0.001;
      var_21 = var_13 + var_19 * (var_10 * var_20 + 0.5 * var_16 * squared(var_20));
      var_4.origin = var_21;
    }

    var_10 = var_12.speed;
  }

  var_2 delete();
  level.kyledrone delete();
  var_4 notify("stop_tracking");
  level.player unlink();
  var_5 delete();
  var_4 delete();
  switch_to_ground_player_disable(0);
  switch_to_ground_player_setup();
  level notify("team_switch_fadein");
}

camangle(var_0, var_1) {
  var_2 = (var_0 - var_1) * 0.2;
  return (angleclamp180(var_2[0]), angleclamp180(var_2[1]), angleclamp180(var_2[2]));
}

get_flight_path(var_0) {
  var_1 = 100;
  var_2 = var_0.angles;
  var_3 = var_0.origin;
  var_4 = level.player_rig gettagorigin("tag_camera");
  var_5 = vectorNormalize(var_4 - var_3);
  var_6 = vectortoangles(var_5);
  var_7 = level.player_rig gettagangles("tag_camera");
  var_8 = anglesToForward(level.player_rig gettagangles("tag_camera"));
  var_9 = [];
  var_10 = [];
  var_9[var_9.size] = create_path_data(var_3 + (0, 0, 200), (90, 0, 0), 400);
  var_9[var_9.size] = create_path_data(var_3 + (0, 0, 1000), (90, 0, 0), 600);
  var_9[var_9.size] = create_path_data(var_3 + (0, 0, 1200), (90, 0, 0), 100);
  var_11 = var_3 + (var_4 - var_3) / 2;
  var_9[var_9.size] = create_path_data(var_11 + (0, 0, 1200), (90, 0, 0), 600);
  var_9[var_9.size] = create_path_data(var_4 + (0, 0, 1200), (90, 0, 0), 100);
  var_9[var_9.size] = create_path_data(var_4 + (0, 0, 1000), (90, 0, 0), 600);
  var_9[var_9.size] = create_path_data(var_4 + (0, 0, 100), (90, 0, 0), 600);
  var_9[var_9.size] = create_path_data(var_4, var_7, 1);
  return var_9;
}

create_path_data(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = var_1;
  var_3.speed = var_2;
  return var_3;
}

anglesclamp180_lerp(var_0, var_1, var_2) {
  var_3 = angleclamp180(var_0[0] + angleclamp180(var_1[0] - var_0[0]) * var_2);
  var_4 = angleclamp180(var_0[1] + angleclamp180(var_1[1] - var_0[1]) * var_2);
  var_5 = angleclamp180(var_0[2] + angleclamp180(var_1[2] - var_0[2]) * var_2);
  return (var_3, var_4, var_5);
}

track_pos(var_0) {
  self endon("stop_tracking");

  for(;;) {
    self.angles = vectortoangles(var_0 - self.origin);
    waitframe();
  }
}