/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\townhoused\townhoused_outer.gsc
***********************************************************/

function apc_exit_sequence(var0, var1, var2) {
  var0 thread scripts\common\anim::anim_single_solo(var2, "apc_ride_exit");
  level.apc_exit_counter = var1.size;
  thread apc_exit_vo();
  scripts\engine\utility::array_thread(var1, &apc_exit_thread, var0);
}

function apc_exit_vo() {
  wait 6;
  var0 = scripts\engine\sp\utility::get_living_ai_array("barrier_cops", "script_noteworthy");
  var0 = sortbydistance(var0, level.price.origin);
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_intro_street_20");
  var0[0] scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_30");
}

function apc_exit_thread(var0) {
  var0 scripts\common\anim::anim_single_solo(self, "apc_ride_exit");
  self unlink();
  scripts\engine\utility::flag_set("apc_exited");

  if(!scripts\engine\utility::flag("player_passed_barrier")) {
    if(self == level.price) {
      var1 = ["dx_vom_sastl_intro_street_380", "dx_vom_sastl_intro_street_390"];
      thread scripts\sp\maps\townhoused\townhoused_code::nag(var1, "player_passed_barrier");
    }

    var0 scripts\common\anim::anim_single_solo(self, "apc_ride_exit_into_loop");
    var0 thread scripts\common\anim::anim_loop_solo(self, "apc_ride_exit_loop", "stop_loop_" + self.animname);
    scripts\engine\utility::flag_wait("player_passed_barrier");

    if(self == level.price) {
      level.price stopsounds();
      var2 = ["dx_vom_sastl_intro_street_400", "dx_vom_sastl_intro_street_410", "dx_vom_sastl_intro_street_420"];
      level.price thread scripts\engine\sp\utility::smart_dialogue(var2[randomint(var2.size)]);
    }

    var0 notify("stop_loop_" + self.animname);
    var0 scripts\common\anim::anim_single_solo(self, "apc_ride_exit_outof_loop");
  } else {
    var0 scripts\common\anim::anim_single_solo(self, "apc_ride_exit_into_movement");
  }

  if(self.animname == "bravo1") {
    thread bravo1_street_movement();
  }

  thread street_movement_completed();
  var0 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(self, "street_movement", "gate_approach_pre_idle", "stop_loop_gate_approach");
}

function street_movement_completed() {
  self waittillmatch("single anim", "end");
  level.apc_exit_counter--;

  if(level.apc_exit_counter == 0) {
    level.apc_exit_counter = undefined;
    scripts\engine\utility::flag_set("street_movement_done");
    return;
  }
}

function bravo1_street_movement() {
  level.bravo1 waittillmatch("single anim", "end");
  level.bravo1.goalradius = 32;
  level.bravo1 setgoalpos(level.bravo1.origin);
  scripts\engine\utility::flag_wait_all("apc_exited", "player_approaching_alley_gate");
  var0 = getnode("bravo1_street_node", "targetname");
  level.bravo1.goalradius = 32;
  level.bravo1 setgoalnode(var0);
}

function apc_exit_cops_sequence(var0, var1, var2) {
  var1[0] thread scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_10");

  foreach(var4 in var2) {
    var0 thread scripts\common\anim::anim_single_solo(var4, "open_barrier");
  }

  foreach(var7 in var1) {
    var0 thread scripts\common\anim::anim_single_solo(var7, "open_barrier");
  }

  var7 = scripts\sp\maps\townhoused\townhoused_code::get_longest_anim_ent(var1, "open_barrier");
  var7 waittillmatch("single anim", "end");

  foreach(var7 in var1) {
    var0 thread scripts\common\anim::anim_loop_solo(var7, "open_barrier_loop", "stop_open_barrier_loop");
  }

  scripts\engine\utility::flag_wait("player_passed_barrier");

  foreach(var4 in var2) {
    var0 thread scripts\common\anim::anim_single_solo(var4, "close_barrier");
  }

  foreach(var7 in var1) {
    var0 notify("stop_open_barrier_loop");
    var7 scripts\engine\sp\utility::anim_stopanimScripted();
    var0 thread scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(var7, "close_barrier", "close_barrier_loop", "stop_barrier_cop_idle");
  }

  scripts\engine\utility::flag_wait("player_in_backyard");
  var0 notify("stop_barrier_cop_idle");
  scripts\engine\utility::array_delete(var1);
}

function get_cop_barriers() {
  var0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var1 = [];

  for(var2 = 1; var2 <= 2; var2++) {
    var3 = scripts\engine\sp\utility::spawn_anim_model("barrier" + var2);
    var1 = var3;
  }

  foreach(var5 in var1) {
    var0 thread scripts\common\anim::anim_first_frame_solo(var5, "open_barrier");
  }

  return var1;
}

function extra_street_alles_movement() {
  var0 = scripts\engine\sp\utility::array_spawn_targetname("extra_street_allies");
  var1 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var2 = getstartorigin(var1.origin, var1.angles, level.scr_anim["extra1"]["approach_alley"]);
  var0 = sortbydistance(var0, var2);

  for(var3 = 0; var3 < var0.size; var3++) {
    var0[var3].animname = "extra" + var3 + 1;
    thread extra_street_alles_movement_internal(var0[var3]);
  }
}

function extra_street_alles_movement_internal(var0) {
  var1 = "approach_alley";
  var0 scripts\sp\anim::anim_reach_solo(self, var1);
  var0 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(self, var1, undefined, "stop_approach_alley_loop");
}

function spawn_padlock() {
  level.gatelock = scripts\engine\sp\utility::spawn_anim_model("gate_lock");
  var0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var0 scripts\common\anim::anim_first_frame_solo(level.gatelock, "gate_cut");
}

function init_bravo_gate() {
  var0 = scripts\engine\utility::getStruct("bravo_gate_animnode", "targetname");
  var1 = getEntArray("bravo_gates", "targetname");

  foreach(var3 in var1) {
    var3 scripts\engine\sp\utility::assign_animtree(var3.script_animname);
  }

  var0 scripts\common\anim::anim_first_frame(var1, "bravo_apc_entry");
  var5 = scripts\engine\sp\utility::array_spawn_noteworthy("bravo_gate_cops");

  foreach(var7 in var5) {
    var7 scripts\common\ai::gun_remove();
    scripts\engine\sp\utility::add_cleanup_ent(var7, "street");
  }

  thread bravo_gate_vo(var5);
  var0 thread scripts\common\anim::anim_loop(var5, "bravo_apc_start_loop");
  scripts\engine\utility::flag_set("bravo_gate_setup");
}

function bravo_gate_open() {
  if(!scripts\engine\utility::flag("bravo_gate_setup")) {
    init_bravo_gate();
  }

  var0 = scripts\engine\utility::getStruct("bravo_gate_animnode", "targetname");
  var0 notify("stop_loop");
  var1 = scripts\engine\sp\utility::get_living_ai_array("bravo_gate_cops", "script_noteworthy");
  var2 = getEntArray("bravo_gates", "targetname");
  var3 = scripts\engine\utility::array_combine(var1, var2);
  thread bravo_gate_vo_open(var1);
  var0 scripts\common\anim::anim_single(var3, "bravo_apc_entry");
  var0 thread scripts\common\anim::anim_loop(var1, "bravo_apc_end_loop");
}

function bravo_gate_vo(var0) {
  level endon("stop_bravo_gate_vo");
  scripts\engine\utility::flag_wait("player_passed_barrier");
  var0[0] scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_430");
  wait 0.5;
  var0[1] scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_440");
  wait 0.4;
  var0[0] scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_450");
  wait 0.2;
  var0[1] scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_460");
}

function bravo_gate_vo_open(var0) {
  level notify("stop_bravo_gate_vo");
  var0[0] stopsounds();
  var0[1] stopsounds();
  waitframe();
  var0[1] scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_470");
  wait 11.5;
  var0[1] scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_480");
}

function postspawn_barrier_cop() {
  scripts\common\ai::gun_remove();
  scripts\engine\sp\utility::add_cleanup_ent(self, "street");
}

function apc_bravo_sounds_start() {
  wait 5.3;
  self playSound("sp_lvl_townhouse_bear_cat_2_pullup");
  wait 4;
  self playSound("sp_lvl_townhouse_bear_cat_2_door_open");
  wait 2.5;
  self playSound("sp_lvl_townhouse_bear_cat_2_door_close");
}

function street_jogger() {
  var0 = scripts\engine\sp\utility::array_spawn_targetname("jogger", 1);
  var1 = undefined;
  var2 = undefined;

  foreach(var4 in var0) {
    scripts\engine\sp\utility::add_cleanup_ent(var4, "street");

    if(var4.animname == "jogger") {
      var1 = var4;
      continue;
    }

    var2 = var4;
  }

  scripts\engine\utility::array_thread(var0, &scripts\common\ai::gun_remove);
  var6 = scripts\engine\utility::getStruct("jogger_animnode", "targetname");
  var6 scripts\common\anim::anim_first_frame(var0, "jog");
  scripts\engine\utility::flag_wait("start_player_exit_apc");
  wait 4;
  thread street_jogger_vo(var2, var1);
  var6 thread scripts\sp\maps\townhoused\townhoused_code::anim_then_loop(var0, "jog");
}

function street_jogger_vo(var0, var1) {
  wait 5.5;
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_310");
  wait 1;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm3_intro_street_320");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_330");
  wait 1;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm3_intro_street_340");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_350");
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm3_intro_street_360");
  wait 0.4;
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_370");
}

function street_knocknock() {
  var0 = scripts\engine\sp\utility::array_spawn_targetname("door_knocker", 1);
  var1 = scripts\engine\utility::getStruct("knock_knock_animnode", "targetname");
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in var0) {
    if(var5.animname == "cop") {
      var2 = var5;
    } else {
      var3 = var5;
    }

    var5 scripts\common\ai::gun_remove();
    scripts\engine\sp\utility::add_cleanup_ent(var5, "street");
  }

  var7 = getEnt("knock_knock_door", "targetname");
  var7 scripts\engine\sp\utility::assign_animtree("door");
  var1 scripts\common\anim::anim_first_frame_solo(var7, "knock_knock");
  var1 scripts\common\anim::anim_first_frame(var0, "knock_knock");
  var8 = scripts\engine\utility::array_add(var0, var7);
  scripts\engine\utility::flag_wait("start_player_exit_apc");
  wait 4;
  thread street_knocknock_vo(var2, var3);
  var1 thread scripts\common\anim::anim_single(var8, "knock_knock");
  thread delete_on_animend();
  var2 waittillmatch("single anim", "end");
  var1 thread scripts\common\anim::anim_loop_solo(var2, "knock_knock_loop");
}

function street_knocknock_vo(var0, var1) {
  wait 15;
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_140");
  wait 0.4;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm3_intro_street_150");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_160");
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm3_intro_street_170");
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm3_intro_street_180");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po2_intro_street_190");
}

function woman_onlooker() {
  var0 = scripts\engine\sp\utility::array_spawn_targetname("woman_onlooker", 1);
  var1 = scripts\engine\utility::getStruct("woman_onlooker_animnode", "targetname");
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in var0) {
    if(var5.animname == "cop") {
      var2 = var5;
    } else {
      var3 = var5;
      var3 attach("p7_cup_coffee_mug", "tag_accessory_right");
    }

    var5 scripts\common\ai::gun_remove();
    scripts\engine\sp\utility::add_cleanup_ent(var5, "street");
  }

  var7 = getEnt("woman_onlooker_door", "targetname");
  var7 scripts\engine\sp\utility::assign_animtree("door");
  var1 scripts\common\anim::anim_first_frame_solo(var7, "drink_tea_back");
  var1 scripts\common\anim::anim_first_frame(var0, "drink_tea");
  var8 = scripts\engine\utility::array_add(var0, var7);
  scripts\engine\utility::flag_wait("player_exited_apc");
  thread woman_onlooker_vo(var2, var3);
  var1 scripts\common\anim::anim_single(var0, "drink_tea");
  var1 thread scripts\common\anim::anim_loop(var0, "drink_tea_loop");
  scripts\engine\utility::flag_wait("player_half_street");
  wait randomfloat(2.5);
  thread woman_onlook_vo2(var2, var3);
  wait 2;
  var1 thread scripts\common\anim::anim_single(var8, "drink_tea_back");
  thread delete_on_animend();
  var2 waittillmatch("single anim", "end");
  var1 notify("stop_loop");
  var1 thread scripts\common\anim::anim_loop_solo(var2, "drink_tea_end_loop");
}

function woman_onlooker_vo(var0, var1) {
  level endon("stop_onlooker_vo");
  wait 7;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvf1_intro_street_200");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_210");
  wait 1;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvf1_intro_street_220");
  wait 0.3;
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_230");
  wait 0.5;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvf1_intro_street_240");
}

function woman_onlook_vo2(var0, var1) {
  level notify("stop_onlooker_vo");
  var0 stopsounds();
  var1 stopsounds();
  waitframe();
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_250");
  thread woman_onlook_vo2_thread(var0, var1);
}

function woman_onlook_vo2_thread(var0, var1) {
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvf1_intro_street_260");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_270");
  wait 1;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvf1_intro_street_280");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_po3_intro_street_290");
}

function delete_on_animend() {
  self endon("death");
  self waittillmatch("single anim", "end");
  self delete();
}

function init_onlookers() {
  var0 = scripts\engine\utility::getStructArray("onlooker", "targetname");
  scripts\engine\utility::array_thread(var0, &onlooker);
}

function onlooker(var0) {
  scripts\engine\utility::script_delay();
  var1 = undefined;
  var2 = undefined;

  if(isDefined(self.script_light)) {
    var1 = getEnt(self.script_light, "targetname");
    var2 = var1 getlightintensity();
    var1 setlightintensity(0);
  }

  if(isDefined(self.script_flag_wait)) {
    scripts\engine\utility::flag_wait(self.script_flag_wait);
  }

  if(isDefined(var1)) {
    var1 setlightintensity(var2);
  }

  var3 = getspawnerarray(self.target);
  var4 = scripts\engine\sp\utility::array_spawn(var3, 1);
  scripts\engine\utility::array_thread(var4, &delete_on_animend);
  thread onlooker_vo(self.script_animation);
  thread scripts\common\anim::anim_single(var4, self.script_animation);
}

function onlooker_vo(var0) {
  var1 = undefined;

  switch (var0) {
    case "window1":
      var1 = [];
      GscBinSkip0(0x2e, 0, ["dx_vom_cvm1_intro_street_40", 1]);

    case "window2":
      wait 7;
      GscBinSkip0(0x2e, 0, ["dx_vom_cvf1_intro_street_80", 1]);
  }

  onlooker_vo_thread(var1);
}

function onlooker_vo_thread(var0) {
  var1 = spawn("script_origin", self.origin);
  var1 scalevolume(0.2);

  foreach(var3 in var0) {
    var1 playSound(var3[0], "sounddone");
    var1 waittill("sounddone");

    if(isDefined(var3[1])) {
      wait var3[1];
    }
  }
}

function alley_gate_open(var0) {
  scripts\engine\utility::delaythread(5, &scripts\sp\maps\townhoused\townhoused_code::train_go, "south");
  thread alley_price_anim(level.price);
  thread scripts\engine\utility::play_sound_in_space("sp_lvl_townhouse_cut_fence", (-1593, -234, -388));
  level.alpha1.boltcutters unlink();
  var1 = get_alley_gate();
  var2 = [level.alpha1, level.gatelock, level.alpha1.boltcutters, var1];

  foreach(var4 in var2) {
    var0 thread scripts\common\anim::anim_single_solo(var4, "gate_cut");
  }

  level.alpha1 waittillmatch("single anim", "end");
  var0 notify("stop_loop_gate_approach_alpha1");
  var0 thread scripts\common\anim::anim_loop_solo(level.alpha1, "gate_cut_post_idle", "stop_loop_alpha1_through_gate");
}

function get_alley_gate() {
  var0 = getEnt("alley_gate", "targetname");

  if(!isDefined(var0.clip)) {
    var0 scripts\engine\sp\utility::assign_animtree("gate");
    var0.clip = getEnt("alley_gate_clip", "targetname");
    var0.clip linkTo(var0);
    var0.pivot = getEnt(var0.target, "targetname");
    var0.pivot delete();
  }

  return var0;
}

function close_alley_gate() {
  var0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var1 = get_alley_gate();
  var0 scripts\common\anim::anim_first_frame_solo(var1, "gate_cut");
}

function alley_price_anim(var0) {
  level endon("warehouse_entrance_price_teleported");
  level.price scripts\engine\utility::delaythread(0.2, &scripts\engine\sp\utility::smart_dialogue, "dx_vom_sastl_intro_alley_20");
  level.price scripts\engine\utility::delaythread(4.5, &scripts\engine\sp\utility::smart_dialogue, "dx_vom_sastl_intro_alley_30");
  level.price scripts\engine\utility::delaythread(10, &scripts\engine\sp\utility::smart_dialogue, "dx_vom_sastl_intro_alley_50");
  level.price scripts\engine\utility::delaythread(17, &scripts\engine\sp\utility::smart_dialogue, "dx_vom_sastl_intro_alley_60");
  var0 scripts\common\anim::anim_single_solo(self, "alley_move");

  if(!scripts\engine\utility::flag("cellphone_guy_executed")) {
    level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_garage_ext_80");
  }

  var0 thread scripts\common\anim::anim_loop_solo(self, "alley_end_idle", "stop_loop_price_alley_end");
  scripts\engine\utility::flag_set("price_at_end_of_alley");
}

function alley_ctbuddy_anim(var0) {
  level endon("move_bravo_through_gate");
  var0 scripts\common\anim::anim_single_solo(self, "alley_enter");
  var0 thread scripts\common\anim::anim_loop_solo(self, "alley_enter_loop", "stop_loop_ctbuddy");
}

function alley_approach_garage(var0) {
  scripts\engine\utility::flag_wait_all("price_at_end_of_alley", "player_at_end_of_alley", "cellphone_guy_executed");
  var0 notify("stop_loop_price_alley_end");
  thread garage_approach_vo();
  var0 scripts\common\anim::anim_single_solo(level.price, "garage_entry_arrive");
  var0 thread scripts\common\anim::anim_loop_solo(level.price, "garage_entry_arrive_loop", "stop_loop_price_warehouse");
  scripts\engine\utility::flag_set("price_ready_for_garage_entry");
}

function garage_approach_vo() {
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_a21_garage_ext_10");
  wait 0.3;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_brv2_garage_ext_20");
}

function postspawn_cellphone_guy() {
  var0 = scripts\engine\utility::getStruct("garage_door_animnode", "targetname");
  scripts\anim\shared::forceuseweapon(self.sidearm, "primary");
  scripts\common\ai::gun_remove();
  scripts\sp\utility::context_melee_allow(0);
  self.script_forcegoal = 1;
  self.goalradius = 64;
  self.skipdeathanim = 1;
  self.allowdeath = 1;
  self.animnode = var0;
  self.cellphone = scripts\engine\sp\utility::spawn_anim_model("cellphone_on");
  self.cellphone linkTo(self, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  thread kill_cellphone_guy(level);
  thread cellphone_guy_ondeath(level);
  thread cellphone_guy_vo();
  var0 scripts\sp\anim::anim_react([self], "cellphone", &cellphone_react);
}

function cellphone_react(var0) {
  self endon("death");

  if(var0 != "death") {
    var1 = scripts\engine\utility::getanim("cellphone_react");
    scripts\common\ai::gun_recall();
    thread scripts\common\anim::anim_single_solo(self, "cellphone_react");
    var2 = getanimlength(var1);
    var3 = 2.5 / var2;
    waitframe();
    self setanimtime(var1, var3);
    self.radius = 100;
    self setgoalpos(self.origin);
    self waittillmatch("single anim", "end");
    return "skip_reaction";
  }
}

function cellphone_guy_vo() {
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

function kill_cellphone_guy(var0) {
  var0 endon("death");
  var0 waittillmatch("single anim", "end");
  var1 = scripts\engine\utility::getStruct("garage_door_animnode", "targetname");
  scripts\engine\utility::flag_wait("execute_cellphone_guy");
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_garage_ext_90");
  wait 2;
  level.price thread scripts\sp\maps\townhoused\townhoused_code::ally_shoot_enemy(var0, undefined, "tag_eye");
}

function cellphone_guy_ondeath(var0) {
  var0 waittill("death");
  scripts\engine\utility::flag_set("cellphone_guy_executed");
}

function cellphone_use_deathanim(var0) {
  var0.skipdeathanim = undefined;
  var0.deathfunction = &cellphone_deathanim;
}

function cellphone_deathanim() {
  var0 = "cellphone_death";
  self.animnode thread scripts\common\anim::anim_single(level.tire_rigs, "cellphone_death");
  self.disabledeathorient = 1;
  scripts\sp\maps\townhoused\townhoused_code::scripted_deathanim("cellphone_death", self.animnode);
}

function garage_tires() {
  var0 = scripts\engine\utility::getStruct("garage_door_animnode", "targetname");
  var1 = "com_junktire";
  var2 = 26;
  var3 = 12;
  var4 = var2 / var3;
  level.tire_rigs = [];
  var5 = 0;

  for(var6 = 0; var6 < var4; var6++) {
    var7 = scripts\engine\sp\utility::spawn_anim_model("tires", var0.origin, var0.angles);
    level.tire_rigs[level.tire_rigs.size] = var7;

    for(var8 = 1; var8 <= var3; var8++) {
      var5++;

      if(var5 > var2) {
        break;
      }

      if(var5 < 10) {
        var9 = "0" + var5;
      } else {
        var9 = var5;
      }

      var10 = "j_tire" + var9;
      var7 attach(var1, var10, 1);
    }
  }

  var0 scripts\common\anim::anim_first_frame(level.tire_rigs, "cellphone_death");
}

function postspawn_garage_enemy() {
  self.allowdeath = 1;

  if(self.animname == "bombmaker") {
    var0 = scripts\engine\sp\utility::spawn_anim_model("garage_bombmaker_chair", self.origin, self.angles);
    self.animents = [var0];
  } else {
    var1 = get_garage_milk_crate();
    var1.parenttag = "tag_accessory_left";
    var1 linkTo(self, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
    var1.overridevelocity = anglesToForward((90, 20, 120)) * 50;
    self.animreactrelative = 1;
    self.linkedaniments = [var1];
    self.radius = 10;
  }

  thread garage_enemy_going_hot();
}

function garage_enemy_going_hot() {
  self endon("death");
  self waittill("shooting");
  scripts\engine\utility::flag_set("garage_hot");
  scripts\engine\utility::flag_set("player_near_garage_office");
}

function precache_garage_milk_crate() {
  var0 = scripts\engine\utility::getStruct("garage_milk_crate", "targetname");
  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  GscBinSkip0(0x2e, var1.size, var0);
}

function get_garage_milk_crate() {
  var0 = scripts\engine\utility::getStruct("garage_milk_crate", "targetname");
  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  var2 = spawn("script_model", var0.origin);
  var2 setModel(var0.script_modelname);
  var2.children = [];

  foreach(var4 in var1) {
    var5 = spawn("script_model", var4.origin);
    var5 setModel(var4.script_modelname);
    var5.angles = var4.angles;
    var5 linkTo(var2);
    var2.children[var2.children.size] = var5;
  }

  return var2;
}

function garage_knock() {
  scripts\engine\utility::flag_wait("price_ready_for_garage_entry");
  var0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var0 notify("stop_loop_price_warehouse");
  var1 = scripts\engine\sp\utility::spawn_targetname("garage_knock_enemy");
  level.garage_knock_enemy = var1;
  var1 scripts\common\ai::gun_remove();
  var1.allowdeath = 1;
  var1 scripts\sp\utility::context_melee_allow(0);
  var2 = [level.price, var1];
  var0 = scripts\engine\utility::getStruct("garage_door_animnode", "targetname");
  var3 = scripts\sp\door::get_interactive_door("warehouse_entrance_door");
  thread garage_knock_vo();
  var0 thread scripts\sp\maps\townhoused\townhoused_code::anim_door(var3, "garage_knock");
  var0 thread scripts\common\anim::anim_single(var2, "garage_knock");
  wait 12;
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  var4 = scripts\engine\utility::getStruct("garage_entry_price_start", "targetname");
  level.price scripts\engine\utility::set_movement_speed(110);
  level.price.goalradius = 32;
  level.price setgoalpos(var4.origin);
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
  var5 = getnode("warehouse_entrance_alpha2", "targetname");
  level.price setgoalnode(var5);
  level.price waittill("goal");
  var0 = scripts\engine\utility::getStruct("garage_animnode", "targetname");
  thread garage_entry_dialog(var0);
  level.price scripts\engine\sp\utility::set_force_color("y");
  scripts\engine\sp\utility::activate_trigger("garage_colors", "targetname");
}

function garage_entry_dialog(var0) {
  var0 endon("anim_condition_react");
  wait 1;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_garage_mount_90");
}

function garage_knock_vo() {
  wait 1;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_garage_ext_100");
  wait 0.5;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_garage_ext_110");
}

function garage_tv() {
  setsaveddvar("MMRNLMPPLT", "0");
  cinematicingameloop("sp_townhouse_propaganda_temp");
  var0 = scripts\engine\utility::getStruct("garage_tv_speaker", "targetname");
  var1 = scripts\engine\utility::play_loopsound_in_space("sp_lvl_townhouse_propaganda_garage", var0.origin);
  var2 = getscriptablearray("garage_tv_01", "targetname");
  var2[0] waittill("death");
  var1 delete();

  if(iscinematicplaying()) {
    stopcinematicingame();
    return;
  }
}

function postspawn_garage_office_enemy() {
  thread garage_ambusher();
}

function postspawn_garage_office_alerter() {
  thread garage_office_alert_thread(level);
}

function garage_office_alert_thread(var0) {
  garage_office_alert_wait(var0);
  scripts\engine\utility::flag_set("garage_hot");
}

function garage_office_alert_wait(var0) {
  level endon("player_near_garage_office");
  var0 scripts\engine\utility::waittill_any("reached_path_end", "death", "enemy");
}

function garage_ambusher(var0) {
  self endon("death");
  thread garage_ambush_thread(var0);
  scripts\engine\sp\utility::disable_surprise();
  var1 = scripts\engine\utility::get_target_array(self.target);

  for(var2 = var1[randomint(var1.size)]; isDefined(var2); var2 = scripts\engine\utility::get_target_ent(var2.target)) {
    if(isDefined(var2.radius)) {
      self.goalradius = var2.radius;
    }

    if(isstruct(var2)) {
      self setgoalpos(var2.origin);
    } else if(isnode(var2)) {
      self setgoalnode(var2);
    } else if(var2.code_classname == "info_volume") {
      scripts\engine\utility::ent_flag_wait("leave_cover");
      self setgoalvolumeauto(var2);
    }

    self waittill("goal");

    if(!isDefined(var2.target)) {
      break;
    }
  }
}

function garage_ambush_thread(var0) {
  self endon("death");
  scripts\engine\utility::ent_flag_init("leave_cover");
  scripts\engine\utility::waittill_any("damage", "enemy_visible");

  if(istrue(var0)) {
    scripts\engine\utility::flag_set("garage2_light_off");
  }

  self.goalradius = 2048;
}

function garage2_temp_sounds() {}

function postspawn_garage2_enemy() {
  var0 = 1;

  if(isDefined(self.script_parameters)) {
    if(self.script_parameters == "noflag") {
      var0 = 0;
    }
  }

  thread garage_ambusher(var0);
}

function garage2_train() {
  wait randomfloatrange(1, 5);
  var0 = scripts\engine\utility::getStruct("train_earthquake_org", "targetname");
  level thread scripts\sp\maps\townhoused\townhoused_code::train_go("south");
}

function garage2_scene() {
  thread garage2_lifted_taxi();
}

function garage2_lifted_taxi() {}

function garage2_carjack(var0) {
  var1 = getEnt("garage_carjack_clip", "targetname");
  var1 setCanDamage(1);
  var1.health = 100;
  var1 waittill("damage");
  thread garage2_lower_carjack();
}

function garage2_lower_carjack() {
  garage2_force_combat();
  scripts\engine\utility::flag_set("garage2_lower_carjack");
  var0 = "lower_carjack";
  var1 = scripts\engine\utility::getanim(var0);
  thread scripts\common\anim::anim_single_solo(self, var0);
}

function garage2_easy_light() {
  var0 = getEnt("garage2_easy_light", "targetname");
  var0.health = 1000;
  var0 setCanDamage(1);
  var1 = getEnt("garage2_aimassist_light", "targetname");
  var1 enableaimassist();
  var0 waittill("damage");
  var2 = getscriptablearray("garage2_lights", "targetname");
  var3 = var2[0];

  if(var3 getscriptablepartstate("onoff") == "death" || var3 getscriptablepartstate("onoff") == "off") {
    return;
  }

  var3 scripts\sp\utility::do_damage(100, level.player.origin);
  var4 = getEntArray("garage2_light_clip", "script_noteworthy");
  scripts\engine\utility::array_delete(var4);
}

function garage2_is_light_off() {
  var0 = getscriptablearray("garage2_lights", "targetname");
  var1 = var0[0];

  if(var1 getscriptablepartstate("onoff") == "death" || var1 getscriptablepartstate("onoff") == "off") {
    return true;
  }

  return false;
}

function garage2_force_combat() {}

function garage2_price_exit() {
  level.price scripts\engine\sp\utility::disable_ai_color();
  var0 = scripts\engine\utility::getStruct("scaffolding_animnode", "targetname");
  var0 scripts\sp\anim::anim_reach_solo(level.price, "garage2_end_loop");
  var0 thread scripts\common\anim::anim_loop_solo(level.price, "garage2_end_loop", "stop_price_loop");
  var1 = scripts\sp\door::get_interactive_door("door_garage2_exit");
  var2 = var1.cam_structs[0];

  while(var2.door.snakecam_active) {
    waitframe();
  }

  var3 = getEntArray("garage2_light_clip", "script_noteworthy");
  scripts\engine\utility::array_delete(var3);
  level.price scripts\engine\sp\utility::set_force_color("r");
  scripts\engine\sp\utility::array_spawn_targetname("bravo2");
}

function garage2_exit_vo() {
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_a11_overwatch_scaffold_10");
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_kyle_overwatch_scaffold_20");
}

function garage_explosives_init() {
  level.lastgarageexplosion = gettime();
  var0 = getEntArray("garage_explosive", "targetname");
  scripts\engine\utility::array_thread(var0, &garage_explosive_thread);
}

function garage_explosive_thread() {
  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isPlayer(var1)) {
      break;
    }

    if(scripts\sp\maps\townhoused\townhoused_code::is_explosivedamage(var4, var9)) {
      break;
    }
  }

  var10 = 0;

  if(gettime() - level.lastgarageexplosion < 0.1) {
    var10 = 0.2;
  }

  level.lastgarageexplosion = gettime();
  var11 = scripts\engine\utility::getStructArray(self.target, "targetname");

  for(var12 = 0; var12 < var11.size; var12++) {
    thread garage_explosive_explode(var11[var12]);
  }
}

function garage_explosive_explode(var0) {
  if(var0 > 0) {
    wait var0;
  }

  var1 = "c4";

  if(isDefined(self.script_type)) {
    var1 = self.script_type;
  }

  playFX(scripts\engine\utility::getfx("c4_explosion"), self.origin);
  radiusdamage(self.origin, 500, 500, 500, undefined, "MOD_EXPLOSIVE");
  thread scripts\engine\utility::play_sound_in_space("claymore_expl_atmo", self.origin);
}

function garage_tripwire_init() {
  var0 = scripts\engine\utility::getStructArray("garage_trip_wire", "targetname");
  scripts\engine\utility::array_thread(var0, &tripwire_thread);
}

function tripwire_thread() {
  var0 = spawn("script_model", self.origin);
  var0 setModel(scripts\engine\sp\utility::getmodel("tripwire"));
  var0.targetname = "tripwire";
  var1 = "Defuse";
  var2 = 45;
  var3 = 80;
  var4 = 50;
  var5 = 1;
  var0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), var1, var2, var3, var4, var5);
  thread tripwire_defuse_thread();
  var0 endon("death");
  var6 = scripts\engine\utility::getStruct(self.target, "targetname");
  var0.angles = vectortoangles(var6.origin - self.origin);
  var0.length = distance(var6.origin, self.origin);
  var7 = var0.origin + anglesToForward(var0.angles) * var0.length * 0.5;
  var0.trigger = spawn("trigger_rotatable_radius", var7, 0, 4, var0.length);
  var0.trigger.angles = var0.angles;
  var0.trigger endon("death");
  thread tripwire_trigger_thread();
  var8 = 0;

  for(;;) {
    var9 = level.player scripts\sp\nvg\nvg_player::is_nvg_on();

    if(!var8 && var9) {
      var8 = 1;
      var0 laserforceon();
    } else if(var8 && !var9) {
      var8 = 0;
      var0 laserforceoff();
    }

    waitframe();
  }
}

function tripwire_defuse_thread() {
  self endon("death");
  self waittill("trigger");
  self laserforceoff();
  tripwire_delete_cleanup();
}

function tripwire_trigger_thread(var0) {
  self endon("death");
  self.trigger endon("death");
  self.trigger waittill("trigger");
  playFX(scripts\engine\utility::getfx("c4_explosion"), self.origin);
  radiusdamage(self.origin, 500, 500, 500, undefined, "MOD_EXPLOSIVE");
  thread scripts\engine\utility::play_sound_in_space("claymore_expl_atmo", self.origin);
  tripwire_delete_cleanup(1);
}

function tripwire_delete_cleanup(var0) {
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  if(istrue(var0)) {
    self delete();
    return;
  }
}

function quick_fadeout_in() {
  scripts\sp\hud_util::fade_out(0.05);
  scripts\engine\utility::delaythread(0.2, &scripts\sp\hud_util::fade_in, 0.2);
}

function switch_to_ground_player_disable(var0) {
  if(var0) {
    level.player playerdisabletriggers();
    level.player cleardamageindicators();
    level.player freezecontrols(1);
    level.player takeallweapons();
    level.player hidelegsandshadow();
    return;
  }

  level.player freezecontrols(0);
  level.player showlegsandshadow();
  level.player playerenabletriggers();
}

function switch_to_ground_player_setup() {
  level.player takeallweapons();
  scripts\sp\maps\townhoused\townhoused_code::setup_player("backyard");
}

function cam_fly_up() {
  level.player setstance("stand");
  level.player nightvisiongogglesforceoff();
  switch_to_ground_player_disable(1);
  create_fly_cam();
  var0 = get_flight_path_up();
  level.player playerlinktoabsolute(level.cammover.mover, "tag_origin");
  cam_fly_path(var0);
  setsaveddvar("MMRNLMPPLT", "1");
  setsaveddvar("RKMNLRNS", "1");
  cinematicingame("townhouse_temp_transition");
}

function cam_fly_down() {
  level.player scripts\common\utility::allow_cinematic_motion(0, "fly_down");
  level.player setstance("stand");
  level.player nightvisiongogglesforceoff();
  switch_to_ground_player_disable(1);
  create_fly_cam();
  var0 = get_flight_path_down();
  level.player playerlinktoabsolute(level.cammover.mover, "tag_origin");
  cam_fly_path(var0, 1);
  level.player unlink();
  level.player scripts\common\utility::allow_cinematic_motion(1, "fly_down");
  switch_to_ground_player_disable(0);
  switch_to_ground_player_setup();
}

function create_fly_cam() {
  if(isDefined(level.cammover)) {
    return;
  }

  var0 = (0, level.player getplayerangles()[1], 0);
  var1 = scripts\engine\utility::spawn_tag_origin(level.player getEye(), var0);
  var1.mover = scripts\engine\utility::spawn_tag_origin(level.player.origin, var0);
  var1.mover linkTo(var1);
  var1.angles = level.player getplayerangles();
  level.cammover = var1;
}

function cam_fly_path(var0, var1) {
  var2 = level.cammover;
  var3 = 5;
  var4 = 0;

  if(istrue(var1)) {
    var2.origin = var0[0].origin;
    var2.angles = var0[0].angles;
    var4 = 1;
    var3 = 3000;
    wait 0.1;

    while(iscinematicplaying()) {
      waitframe();
    }
  }

  for(var5 = var4; var5 < var0.size; var5++) {
    var6 = var0[var5];
    var7 = var2.origin;
    var8 = gettime();
    var9 = distance(var6.origin, var2.origin);
    var10 = (squared(var6.speed) - squared(var3)) / 2 * var9;

    if(var10 != 0) {
      var11 = (var6.speed - var3) / var10;
    } else {
      var11 = var9 / var3;
    }

    var12 = var8 + var11 * 1000;
    var13 = vectorNormalize(var6.origin - var7);
    var2 rotateTo(var6.angles, var11);

    while(gettime() < var12) {
      waitframe();
      var14 = (gettime() - var8) * 0.001;
      var15 = var7 + var13 * (var3 * var14 + 0.5 * var10 * squared(var14));
      var2.origin = var15;
    }

    var3 = var6.speed;
  }
}

function get_flight_path_up() {
  var0 = level.cammover;
  var1 = scripts\engine\utility::getStruct("garage_exit_struct", "targetname");
  var2 = [];
  var3 = level.player getEye();
  var4 = level.player getplayerangles();
  var5 = var3[1] + (var1.origin[1] - var3[1]) * 0.5;
  var6 = (var3[0], var5, var3[2]);
  var7 = length(level.player getvelocity());
  var7 = max(var7, 30);
  var2 = create_path_data(var6, (7, 90, 0), var7);
  var8 = (var3[0], var1.origin[1], var3[2]);
  var6 = var8;
  var2 = create_path_data(var6, (7, 90, 0), 30);
  var6 = var8 + (0, 0, 300);
  var2 = create_path_data(var6, (90, 90, 0), 300);
  var6 = var8 + (0, -300, 2500);
  var2 = create_path_data(var6, (75, 90, 0), 3000);
  return var2;
}

function get_flight_path_down() {
  var0 = level.cammover;
  var1 = scripts\engine\utility::getStructArray("start_backyard", "targetname");
  var2 = undefined;

  foreach(var4 in var1) {
    if(isDefined(var4.script_noteworthy) && var4.script_noteworthy == "player") {
      var2 = var4;
    }
  }

  var6 = level.player_rig gettagangles("tag_camera");
  var7 = anglesToForward(level.player_rig gettagangles("tag_camera"));
  var8 = [];
  var9 = 5000;
  var10 = 60;
  var11 = anglesToForward((var10, var2.angles[1], 0)) * var9 * -1;
  var12 = var2.origin + var11;
  var13 = (var10, var2.angles[1], 0);
  var8 = create_path_data(var12, var13, 3000);
  var9 = 400;
  var11 = anglesToForward((var10, var2.angles[1], 0)) * var9 * -1;
  var12 = var2.origin + var11;
  var13 = (var10, var2.angles[1], 0);
  var8 = create_path_data(var12, var13, 1000);
  var9 = 60;
  var11 = anglesToForward((var10, var2.angles[1], 0)) * var9 * -1;
  var12 = var2.origin + (0, 0, 60);
  var13 = (0, var2.angles[1], 0);
  var8 = create_path_data(var12, var13, 1);
  return var8;
}

function switch_to_ground_fly() {
  level.player setstance("stand");
  level.player nightvisiongogglesforceoff();
  switch_to_ground_player_disable(1);
  var0 = scripts\engine\utility::getStruct("snipe_car_animnode", "targetname");
  var0 scripts\common\anim::anim_first_frame_solo(level.player_rig, "backyard_entry");
  var1 = getEnt("sniper", "targetname");
  var2 = scripts\engine\sp\utility::dronespawn_bodyonly(var1);
  var2.origin = level.player.origin;
  var2.angles = level.player.angles;
  waitframe();
  var3 = (0, level.player getplayerangles()[1], 0);
  var4 = scripts\engine\utility::spawn_tag_origin(level.player getEye(), var3);
  var5 = scripts\engine\utility::spawn_tag_origin(level.player.origin, var3);
  var5 linkTo(var4);
  var4.origin += (0, 0, 100);
  var4.angles = (90, var3[1], 0);
  var6 = get_flight_path(var4);
  level.player playerlinktoabsolute(var5, "tag_origin");
  var7 = 0;
  var8 = 50;
  var9 = 5;
  var10 = 5;

  foreach(var12 in var6) {
    var13 = var4.origin;
    var14 = gettime();
    var15 = distance(var12.origin, var4.origin);
    var16 = (squared(var12.speed) - squared(var10)) / 2 * var15;

    if(var16 != 0) {
      var17 = (var12.speed - var10) / var16;
    } else {
      var17 = var15 / var10;
    }

    var18 = var14 + var17 * 1000;
    var19 = vectorNormalize(var12.origin - var13);
    var4 rotateTo(var12.angles, var17);

    while(gettime() < var18) {
      waitframe();
      var20 = (gettime() - var14) * 0.001;
      var21 = var13 + var19 * (var10 * var20 + 0.5 * var16 * squared(var20));
      var4.origin = var21;
    }

    var10 = var12.speed;
  }

  var2 delete();
  level.kyledrone delete();
  var4 notify("stop_tracking");
  level.player unlink();
  var5 delete();
  var4 delete();
  switch_to_ground_player_disable(0);
  switch_to_ground_player_setup();
  level notify("team_switch_fadein");
}

function camangle(var0, var1) {
  var2 = (var0 - var1) * 0.2;
  return (angleclamp180(var2[0]), angleclamp180(var2[1]), angleclamp180(var2[2]));
}

function get_flight_path(var0) {
  var1 = 100;
  var2 = var0.angles;
  var3 = var0.origin;
  var4 = level.player_rig gettagorigin("tag_camera");
  var5 = vectorNormalize(var4 - var3);
  var6 = vectortoangles(var5);
  var7 = level.player_rig gettagangles("tag_camera");
  var8 = anglesToForward(level.player_rig gettagangles("tag_camera"));
  var9 = [];
  var10 = [];
  var9 = create_path_data(var3 + (0, 0, 200), (90, 0, 0), 400);
  var9 = create_path_data(var3 + (0, 0, 1000), (90, 0, 0), 600);
  var9 = create_path_data(var3 + (0, 0, 1200), (90, 0, 0), 100);
  var11 = var3 + (var4 - var3) / 2;
  var9 = create_path_data(var11 + (0, 0, 1200), (90, 0, 0), 600);
  var9 = create_path_data(var4 + (0, 0, 1200), (90, 0, 0), 100);
  var9 = create_path_data(var4 + (0, 0, 1000), (90, 0, 0), 600);
  var9 = create_path_data(var4 + (0, 0, 100), (90, 0, 0), 600);
  var9 = create_path_data(var4, var7, 1);
  return var9;
}

function create_path_data(var0, var1, var2) {
  var3 = spawnStruct();
  var3.origin = var0;
  var3.angles = var1;
  var3.speed = var2;
  return var3;
}

function anglesclamp180_lerp(var0, var1, var2) {
  var3 = angleclamp180(var0[0] + angleclamp180(var1[0] - var0[0]) * var2);
  var4 = angleclamp180(var0[1] + angleclamp180(var1[1] - var0[1]) * var2);
  var5 = angleclamp180(var0[2] + angleclamp180(var1[2] - var0[2]) * var2);
  return (var3, var4, var5);
}

function track_pos(var0) {
  self endon("stop_tracking");

  for(;;) {
    self.angles = vectortoangles(var0 - self.origin);
    waitframe();
  }
}