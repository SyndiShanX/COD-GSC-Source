/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter.gsc
******************************************/

#using script_433d8f78f7e5fb;
#using scripts\anim\battlechatter_ai;
#using scripts\anim\battlechatter_events;
#using scripts\anim\dialogue;
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#namespace battlechatter;

function init_battlechatter() {
  if(getdvarint(@ "bcs_enable", 1) != 1) {
    return;
  }

  if(isbattlechatterenabled()) {
    if(level.battlechatterinit) {
      return;
    }

    level.battlechatterinit = 1;
    level callback::add(#"on_ai_damaged", &ondamaged);
    level callback::add(#"player_damaged", &ondamaged);
    level callback::add(#"on_ai_killed", &onkilled);
    level callback::add(#"player_death", &onkilled);
    level callback::add(#"player_laststand", &onkilled);
    level callback::add(#"hash_10831fc4ff641282", &function_20c3b78415f5d631);
    level thread function_5badabdd0907701d();
    return;
  }

  setdvarifuninitialized(@ "bcs_enable", 1);
  setdvarifuninitialized(@ "bcs_debug", 0);
  setdvarifuninitialized(@ "bcs_loopdebug", 0);
  setdvarifuninitialized(@ "hash_350b154807f4d745", 0);
  setdvarifuninitialized(@ "hash_4b7858e66804e305", 0);
  setdvarifuninitialized(@ "hash_5aea525f549d2546", 0);

  if(isDefined(level.battlechatter)) {
    return;
  }

  level.battlechatter = spawnStruct();
  level.battlechatter.states = [];
  level.battlechatter.delays = [];
  level.battlechatter.names = [];
  level.battlechatter.events = [];
  level.battlechatter.variations = [];
  setdvarifuninitialized(@ "hash_495535a4877b324d", "off");
  setdvarifuninitialized(@ "hash_87dca5163728ce02", "off");
  setdvarifuninitialized(@ "hash_ce7cfdf8678edb2", "off");
  setdvarifuninitialized(@ "hash_70aaec0e43322fea", "off");
  setdvarifuninitialized(@ "hash_6f38327ed1f7340f", "off");
  setdvarifuninitialized(@ "hash_702217ae066916b9", "");
  setdvarifuninitialized(@ "hash_21778f568437cd09", "");
  setdvarifuninitialized(@ "debug_bcprint", "off");
  setdvarifuninitialized(@ "debug_bcprintscreen", "off");
  setdvarifuninitialized(@ "debug_bcprintdump", "off");
  setdvarifuninitialized(@ "debug_bcprintdumptype", "csv");
  setdvarifuninitialized(@ "hash_ef12a290c14c553f", "off");
  anim.bcprintfailprefix = "^1***** BCS FAILURE: ";
  anim.bcprintwarnprefix = "^3***** BCS WARNING: ";
  battlechatter_events::event_init();
  function_e4b05c2557b90c3e();
  function_9e01c01a8c874beb();

  if(getprojectname() == "T10") {
    function_18c45c9c1dafc921();
  } else if(getprojectname() == "JUP") {
    function_6fe2c52868802607();
  }

  if(isDefined(level.var_2455b11118b14695)) {
    [[level.var_2455b11118b14695]]();
  }

  addloopstate("idle", &battlechatter_events::function_c1dca3ae9b4dd47e);
  addloopstate("investigate", &battlechatter_events::function_69a7d2c4525e307d);
  addloopstate("hunt", &battlechatter_events::function_8b75abd29a184ebf);
  addloopstate("combat", &battlechatter_events::function_66fb0aa6e7887b38);
  setchatterdelay("default", level.battlechatteroverrides.idlemindelay, level.battlechatteroverrides.idlemaxdelay);
  setchatterdelay("idle", level.battlechatteroverrides.idlemindelay, level.battlechatteroverrides.idlemaxdelay);
  setchatterdelay("hunt", level.battlechatteroverrides.huntmindelay, level.battlechatteroverrides.huntmaxdelay);
  setchatterdelay("combat", level.battlechatteroverrides.combatmindelay, level.battlechatteroverrides.combatmaxdelay);
  addeventfunc("announce", &battlechatter_events::announceevent);
  addeventfunc("return_to_idle", &battlechatter_events::function_6cc3a5d13a9ed019);
  addeventfunc("enter_hunt", &battlechatter_events::function_60a8c67006abef53);
  addeventfunc("join_combat", &battlechatter_events::joincombatevent);
  addeventfunc("enter_combat", &battlechatter_events::entercombatevent);
  addeventfunc("red_alert", &battlechatter_events::function_11bba4f1dd5d04d7);

  foreach(deck in level.battlechatter.events) {
    deck utility::deck_shuffle();
  }

  if(!isDefined(level.bcs_mindist)) {
    level.bcs_mindist = 200;
  }

  if(!isDefined(level.var_deceff995bc40063)) {
    level.var_deceff995bc40063 = squared(level.bcs_mindist);
  }

  if(!isDefined(level.bcs_neardist)) {
    level.bcs_neardist = 650;
  }

  if(!isDefined(level.var_822444fd128d6523)) {
    level.var_822444fd128d6523 = squared(level.bcs_neardist);
  }

  if(!isDefined(level.var_d9e54908db3a5ba3)) {
    level.var_d9e54908db3a5ba3 = 850;
  }

  if(!isDefined(level.var_38a0031c43023615)) {
    level.var_38a0031c43023615 = squared(level.var_d9e54908db3a5ba3);
  }

  if(!isDefined(level.bcs_fardist)) {
    level.bcs_fardist = 1400;
  }

  if(!isDefined(level.var_abf4710b2183b7ee)) {
    level.var_abf4710b2183b7ee = squared(level.bcs_fardist);
  }

  setsaveddvar(@ "hash_ab202f8049b3210a", level.bcs_fardist);

  if(!isDefined(level.bcs_maxdist)) {
    level.bcs_maxdist = 2000;
  }

  if(!isDefined(level.bcs_maxdistsqrd)) {
    level.bcs_maxdistsqrd = squared(level.bcs_maxdist);
  }

  if(!isDefined(level.var_b0ea930c0b776ea)) {
    level.var_b0ea930c0b776ea = 300;
  }

  if(!isDefined(level.var_1d73f5d7bc63e580)) {
    level.var_1d73f5d7bc63e580 = squared(level.var_b0ea930c0b776ea);
  }

  if(!isDefined(level.var_310b9df621efc830)) {
    level.var_310b9df621efc830 = 590;
  }

  if(!isDefined(level.var_26a599e8b70f7e2e)) {
    level.var_26a599e8b70f7e2e = squared(level.var_310b9df621efc830);
  }

  if(!isDefined(level.var_a10c1a92d596bcd7)) {
    level.var_a10c1a92d596bcd7 = level.bcs_neardist;
  }

  if(!isDefined(level.var_40957c5b94fc5b91)) {
    level.var_40957c5b94fc5b91 = squared(level.var_a10c1a92d596bcd7);
  }

  if(!isDefined(level.var_94db8a156aebbf80)) {
    level.var_94db8a156aebbf80 = 360;
  }

  if(!isDefined(level.var_99abab0c8b7b991e)) {
    level.var_99abab0c8b7b991e = squared(level.var_94db8a156aebbf80);
  }

  if(!isDefined(level.var_1944a83fd1835aa9)) {
    level.var_1944a83fd1835aa9 = 650;
  }

  if(!isDefined(level.var_2669df2a353bf04b)) {
    level.var_2669df2a353bf04b = squared(level.var_1944a83fd1835aa9);
  }

  if(!isDefined(level.var_79b689f7a1d9a2c)) {
    level.var_79b689f7a1d9a2c = 120;
  }

  level.var_a99c5a25405545fc = 10;

  if(isDefined(anim.squads)) {
    foreach(squad in anim.squads) {
      squad init_squadbattlechatter();
    }
  }

  anim.squadcreatefunc = &init_squadbattlechatter;

  if(!isDefined(anim.bcs_locations)) {
    bcs_init_locations();
  }

  namespace_326cae52b2158981::bcs_setup_countryids();

  thread function_1885b87626c9fc2a();

  level thread bcs_loop();
  level thread bcs_waittill();
}

function private function_5badabdd0907701d() {
  while(true) {
    level waittill("bc_notify", data_array);

    foreach(data in data_array) {
      if(!(isDefined(data.entity) && isDefined(data.category))) {
        continue;
      }

      if(data.category == "nothing") {
        continue;
      }

      var_3aec0c6defed4e13 = [data.entity];

      if(isendstr(data.category, "radio")) {
        var_3aec0c6defed4e13[var_3aec0c6defed4e13.size] = data.entity;
      } else if(isDefined(data.otherentity)) {
        var_3aec0c6defed4e13[var_3aec0c6defed4e13.size] = data.otherentity;
      }

      conversation = function_833d9fb17742b565(data.category, var_3aec0c6defed4e13);
      dlog_recordevent("dlog_event_bc_tree_conversation", ["conversation", data.category, "conversation_defined", isDefined(conversation), "agent_1_entity_number", data.entity getentitynumber(), "agent_2_entity_number", isDefined(data.otherentity) ? data.otherentity getentitynumber() : 0, "agent_1_origin_x", data.entity.origin[0], "agent_1_origin_y", data.entity.origin[1], "agent_1_origin_z", data.entity.origin[2], "agent_2_origin_x", data.otherentity.origin[0] ?? 0, "agent_2_origin_y", data.otherentity.origin[1] ?? 0, "agent_2_origin_z", data.otherentity.origin[2] ?? 0]);

      if(conversation) {
        data.entity.conversation = conversation;

        if(data.otherentity) {
          data.otherentity.conversation = conversation;
        }
      }

      foreach(entity in isDefined(data.otherentity) ? [data.entity, data.otherentity] : [data.entity]) {
        entity debug_say(data.category, (0, 0, 1));
      }

      if(getdvarint(@ "hash_405ab2103bec04b0", 0) == 1 && isDefined(data.otherentity)) {
        level thread debug::line(data.entity, data.otherentity, (1, 1, 1), 5);
      }
    }
  }
}

function clear_flag(flag) {
  self notify("SetBattlechatterFlag " + flag);
  self setbattlechatterflag(flag, 0);
}

function private debug_say(thing, color) {
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(getdvarint(@ "hash_405ab2103bec04b0", 0) == 1) {
    if(!isDefined(self.debugoffset)) {
      self.debugoffset = 0;
    }

    print3d(self.origin + (0, 0, 80 + 15 * self.debugoffset), self.debugoffset + "<dev string:x24>" + thing, color, 1, 1, 400, 1);
    self.debugoffset = (self.debugoffset + 1) % 10;
  }
}

function private ondamaged(params) {
  if(isagent(params.eattacker) || isactor(params.eattacker)) {
    params.eattacker setbattlechatterflag("damaged_enemy", 1, 3);
  }

  if(isagent(self)) {
    self setbattlechatterflag("damaged_recently", 1, 3);

    if(params.var_e978b810a3f209c4 > self.helmethealth) {
      if(self.helmethealth > 0) {
        self setbattlechatterflag("hit_helmet", 1, 3);
      } else if(params.var_e978b810a3f209c4 > 0) {
        self setbattlechatterflag("broke_helmet", 1, 3);
      }
    }

    if(params.var_426913ab397d3d28 > self.armorhealth) {
      if(self.armorhealth > 0) {
        self setbattlechatterflag("hit_armor", 1, 3);
        return;
      }

      if(params.var_426913ab397d3d28 > 0) {
        self setbattlechatterflag("broke_armor", 1, 3);
      }
    }
  }
}

function private onkilled(params) {
  attacker = params.eattacker ?? params.attacker;

  if(isagent(attacker) || isactor(attacker)) {
    attacker setbattlechatterflag("killed_enemy", 1, 3);

    if(isagent(attacker.boss) || isactor(attacker.boss)) {
      attacker.boss setbattlechatterflag("killed_enemy", 1, 3);
    }

    foreach(agent in utility::agentsnear(self.origin, 600)) {
      agent setbattlechatterflag("near_killed_enemy", 1, 12);
    }
  }

  if((isagent(self) || isactor(self)) && self.conversation) {
    function_82faa0d0c4b6397(self.conversation, 1);
    self.conversation = undefined;
  }
}

function private function_20c3b78415f5d631(params) {
  foreach(state, flag in [4: "from_unset", 3: "from_combat", "from_hunt", 1: "from_investigate", 0: "from_idle"]) {
    self setbattlechatterflag(flag, params.fromstate == state);
  }

  if(params.tostate == 3) {
    self setbattlechatterflag("out_of_combat_for_30_seconds", 0);
  } else if(params.tostate == 0) {
    self setbattlechatterflag("out_of_combat_for_30_seconds", 1);
  }

  if(params.tostate > params.fromstate && self.conversation) {
    function_82faa0d0c4b6397(self.conversation, 1);
    self.conversation = undefined;
  }

  foreach(combattype in ["first_combat", "combat", "join_combat"]) {
    self setbattlechatterflag(combattype, params.combattype == combattype);
  }

  if(params.tostate == 3) {
    return;
  }

  self endon("stealth_state_change");
  self endon("death");
  wait 30;
  self setbattlechatterflag("out_of_combat_for_30_seconds", 1);
}

function private function_9e01c01a8c874beb() {
  level.battlechatter.settings["coverme"] = [0.1, 1, 10];
  level.battlechatter.settings["coverfire"] = [0.1, 1, 10];
  level.battlechatter.settings["lost_target"] = [0, 2, 5];
  level.battlechatter.settings["cease_fire"] = [0, 2, 5];
  level.battlechatter.settings["combat_hunt"] = [0.9, 2, 5];
  level.battlechatter.settings["hunt"] = [0.9, 2, 5];
  level.battlechatter.settings["reacquire_push_towards"] = [0.4, 2, 10];
  level.battlechatter.settings["combat_unaware"] = [0.9, 2, 5];
  level.battlechatter.settings["incoming_vehicle_response"] = [0, 0, 20];
  level.battlechatter.settings["_interrupt"] = [0.9, 0, 1];
  level.battlechatter.settings["aquired_target"] = [0.5, 2, 15];
  level.battlechatter.settings["order_attack"] = [0.6, 2, 15];
  level.battlechatter.settings["enemy_direction"] = [0, 2, 15];
  level.battlechatter.settings["getting_cover"] = [0.4, 2, 15];
  level.battlechatter.settings["enemy_getting_cover"] = [0.4, 2, 15];
  level.battlechatter.settings["target_getting_cover"] = [0.4, 2, 15];
  level.battlechatter.settings["ally_exposure"] = [0, 1, 15];
  level.battlechatter.settings["combat_status"] = [0, 1, 15];
  level.battlechatter.settings["enemy_weapon"] = [0.3, 1, 15];
  level.battlechatter.settings["hostile_burst"] = [0, 1, 20];
  level.battlechatter.settings["use_"] = [0.2, 1, 10];
  level.battlechatter.settings["enemy_using_"] = [0.3, 0.5, 10];
  level.battlechatter.settings["grenade_danger"] = [0.8, 0.5, 10];
  level.battlechatter.settings["hurt_by_"] = [0.8, 0.5, 10];
  level.battlechatter.settings["attacking"] = [0.5, 1, 15];
  level.battlechatter.settings["enemy_reloading"] = [0.6, 1, 10];
  level.battlechatter.settings["reloading"] = [0.3, 1, 15];
  level.battlechatter.settings["ammo_status"] = [0.1, 1, 15];
  level.battlechatter.settings["enemy_movement"] = [0.3, 1, 15];
  level.battlechatter.settings["enemy_movement_moving"] = [0.2, 1, 15];
  level.battlechatter.settings["enemy_movement_climbing_up"] = [0.2, 1, 20];
  level.battlechatter.settings["enemy_movement_moving_up"] = [0.2, 1, 20];
  level.battlechatter.settings["ally_movement"] = [0, 1, 15];
  level.battlechatter.settings["killfirm"] = [0, 2, 15];
  level.battlechatter.settings["player_killfirm"] = [0, 2, 30];
  level.battlechatter.settings["casualties"] = [0.3, 3, 15];
  level.battlechatter.settings["casualty"] = [0.3, 2, 15];
  level.battlechatter.settings["friendlyfire"] = [1, 0, 3];
  level.battlechatter.settings["idle_convo"] = [0.3, 1, 60];
  level.battlechatter.settings["idle"] = [0.2, 1, 60];
  level.battlechatter.settings["patrol_curious"] = [0.3, 0, 15];
  level.battlechatter.settings["investigate_start"] = [0.5, 2, 15];
  level.battlechatter.settings["investigate_pos_reached"] = [0.5, 2, 15];
  level.battlechatter.settings["saw_corpse_1"] = [0.6, 0, 10];
  level.battlechatter.settings["saw_corpse_2"] = [0.6, 0, 10];
  level.battlechatter.settings["found_corpse"] = [0.8, 1, 10];
  level.battlechatter.settings["found_corpse_1"] = "found_corpse";
  level.battlechatter.settings["found_corpse_2"] = "found_corpse";
  level.battlechatter.settings["found_corpse_3"] = "found_corpse";
  level.battlechatter.settings["announce_"] = [0.8, 1, 10];
  level.battlechatter.settings["return_to_idle"] = [0.2, 2, 15];
  level.battlechatter.settings["returned_to_idle_pos"] = [0.2, 2, 15];
  level.battlechatter.settings["enter_hunt_1"] = [0.9, 0.5, 10];
  level.battlechatter.settings["enter_hunt_2"] = "enter_hunt_1";
  level.battlechatter.settings["enter_hunt_3"] = "enter_hunt_1";
  level.battlechatter.settings["enter_hunt_4"] = "enter_hunt_1";
  level.battlechatter.settings["enter_hunt_5"] = "enter_hunt_1";
  level.battlechatter.settings["enter_hunt_6"] = "enter_hunt_1";
  level.battlechatter.settings["hunt_ask_found"] = "enter_hunt_1";
  level.battlechatter.settings["hunt_solo"] = "enter_hunt_1";
  level.battlechatter.settings["enter_hunt_followup"] = "enter_hunt_1";
  level.battlechatter.settings["initial_combat"] = [0.9, 0.5, 20];
  level.battlechatter.settings["initial_combat_2"] = "initial_combat";
  level.battlechatter.settings["initial_combat_N"] = "initial_combat";
  level.battlechatter.settings["initial_combat_nonshot_1"] = "initial_combat";
  level.battlechatter.settings["initial_combat_nonshot_2"] = "initial_combat";
  level.battlechatter.settings["initial_combat_nonshot_N"] = "initial_combat";
  level.battlechatter.settings["comb_rs_saw_enemy_on_pos"] = "initial_combat";
  level.battlechatter.settings["comb_rs_saw_enemy_out_pos"] = "initial_combat";
  level.battlechatter.settings["comb_rs_saw_shot_but_enemy_hid"] = "initial_combat";
  level.battlechatter.settings["comb_full_default"] = "initial_combat";
  level.battlechatter.settings["comb_full_unaware_sniper"] = "initial_combat";
  level.battlechatter.settings["comb_full_unaware_lmg"] = "initial_combat";
  level.battlechatter.settings["comb_full_unaware_shotgun"] = "initial_combat";
  level.battlechatter.settings["comb_full_aware_sniper"] = "initial_combat";
  level.battlechatter.settings["comb_full_aware_lmg"] = "initial_combat";
  level.battlechatter.settings["comb_full_aware_shotgun"] = "initial_combat";
  level.battlechatter.settings["comb_fulld_didnt_see_shooting"] = "initial_combat";
  level.battlechatter.settings["comb_fulld_enemy_open"] = "initial_combat";
  level.battlechatter.settings["comb_fulld_enemy_cover"] = "initial_combat";
  level.battlechatter.settings["comb_fulld_enemies_open"] = "initial_combat";
  level.battlechatter.settings["comb_fulld_enemies_cover"] = "initial_combat";
  level.battlechatter.settings["enter_combat"] = [0.9, 0.5, 15];
  level.battlechatter.settings["join_combat"] = [0.5, 3, 15];
  level.battlechatter.settings["losing_target_water"] = [0, 2, 5];
  level.battlechatter.settings["losing_target"] = [0.6, 2, 5];
  level.battlechatter.settings["status_report"] = [0.1, 1, 35];
  level.battlechatter.settings["corpse_status_report"] = [0, 1, 120];
  level.battlechatter.settings["red_alert_1"] = [1, 5, 10];
  level.battlechatter.settings["red_alert_N"] = "red_alert_1";
  level.battlechatter.settings["react_first_combat"] = [0.9, 0.5, 20];
  level.battlechatter.settings["flanked_1"] = [1, 0, 5];
  level.battlechatter.settings["flanked_N"] = "flanked_1";
  level.battlechatter.settings["enemy_sighted_1"] = [0.9, 0, 5];
  level.battlechatter.settings["enemy_sighted_N"] = "enemy_sighted_1";
  level.battlechatter.settings["target_wounded"] = [0.2, 1, 15];
  level.battlechatter.settings["target_unhurt"] = [0.2, 1, 15];
  level.battlechatter.settings["wounded"] = [0.2, 1, 15];
  level.battlechatter.settings["cover_destroyed"] = [0.5, 0, 10];
  var_4261db766ae013d6 = getdvarint(@ "hash_2e9b4d77df5b8514") * 0.001;
  level.battlechatter.settings["lost_target_elapsed_1"] = [0.6, 0.5, var_4261db766ae013d6];
  level.battlechatter.settings["lost_target_elapsed_2"] = [0.6, 0.5, var_4261db766ae013d6];
  level.battlechatter.settings["hunt_initial"] = [0.9, 0.5, 10];
  level.battlechatter.settings["hunt_solo_enter"] = "hunt_initial";
  level.battlechatter.settings["hunt_solo_loop"] = "hunt_initial";
  level.battlechatter.settings["hunt_duo_enter"] = "hunt_initial";
  level.battlechatter.settings["hunt_duo_loop_near"] = "hunt_initial";
  level.battlechatter.settings["hunt_duo_loop_far_1"] = "hunt_initial";
  level.battlechatter.settings["hunt_duo_loop_far_2"] = "hunt_initial";
  level.battlechatter.settings["semtex_stuck"] = [0.9, 0.5, 10];
}

function private function_6fe2c52868802607() {
  level.battlechatter.settings["investigate_loop"] = [0, 2, 5];
}

function private function_18c45c9c1dafc921() {
  level.battlechatter.settings["killfirm"] = [0, 2, 20];
  level.battlechatter.settings["enemy_using_rpg"] = [0.3, 0.5, 30];
  level.battlechatter.settings["enemy_sniper"] = [0.3, 0.5, 30];
  level.battlechatter.settings["target_wounded"] = [0.2, 1, 60];
  level.battlechatter.settings["target_unhurt"] = [0.2, 1, 60];
  level.battlechatter.settings["wounded"] = [0.2, 1, 60];
  level.battlechatter.settings["aquired_target"] = [0.5, 2, 60];
  level.battlechatter.settings["ally_movement"] = [0, 1, 60];
  level.battlechatter.settings["order_attack"] = [0.5, 1, 60];
  level.battlechatter.settings["enemy_reloading"] = [0.6, 1, 30];
  level.battlechatter.settings["attacking"] = [0.5, 1, 30];
  level.battlechatter.settings["reloading"] = [0.3, 1, 30];
  level.battlechatter.settings["ammo_status"] = [0.1, 1, 30];
  level.battlechatter.settings["enemy_movement"] = [0.3, 1, 30];
  level.battlechatter.settings["enemy_movement_moving"] = [0.2, 1, 30];
  level.battlechatter.settings["ally_movement"] = [0, 1, 30];
  level.battlechatter.settings["enemy_movement_climbing_up"] = [0.2, 1, 40];
  level.battlechatter.settings["enemy_movement_moving_up"] = [0.2, 1, 40];
  level.battlechatter.settings["investigate_loop"] = [0, 2, 5];
  level.battlechatter.settings["ae_entered_area"] = [0.85, 5, 6];
  level.battlechatter.settings["ae_entered_area_personal"] = [0.8, 5, 6];
  level.battlechatter.settings["ae_thrown_out"] = [0.5, 0.4, 8];
  level.battlechatter.settings["ae_special_success"] = [0.3, 0.4, 8];
  level.battlechatter.settings["ae_grunt_pickup_armor"] = [0.3, 0.4, 6];
  level.battlechatter.settings["ae_request_armor"] = [0.3, 0.4, 6];
  level.battlechatter.settings["ae_charge_gas"] = [0.5, 0.2, 6];
  level.battlechatter.settings["ae_flavor"] = [0, 0.2, 10];
  level.battlechatter.settings["ae_dm_spinup"] = [0.1, 0.2, 10];
  level.battlechatter.settings["ae_general"] = [0.1, 0.2, 6];
  level.battlechatter.settings["ae_dm_close"] = "ae_general";
  level.battlechatter.settings["ae_riotshield_block"] = "ae_general";
  level.battlechatter.settings["ae_seeker_close"] = "ae_general";
  level.battlechatter.settings["ae_seeker_shot_player"] = "ae_general";
}

function bcs_waittill() {
  level endon("battlechatter disabled");

  while(true) {
    level waittill("bc_notify", data_array);

    foreach(data in data_array) {
      if(!(isDefined(data.entity) && isDefined(data.category))) {
        continue;
      }

      if(getdvarint(@ "hash_350b154807f4d745")) {
        if(isDefined(data.subcategory) && data.category != data.subcategory) {
          text = data.category + "<dev string:x2a>" + data.subcategory;
        } else {
          text = data.category;
        }

        if(utility::issharedfuncdefined(#"stealth_debug", #"hash_443faf8f48737297")) {
          data.entity thread[[utility::getsharedfunc(#"stealth_debug", #"hash_443faf8f48737297")]]("<dev string:x31>" + data.category, (0, 1, 0), 1, 0.5, (0, 0, 40), 5);
        }
      }

      notifyhandled = function_df70a19285f4de71(data);

      if(!notifyhandled && chatterallowed(data.entity, 1, data.category)) {
        notifyhandled = function_321d2815afe991f5(data);
      }

      function_4c3d5af8f9c8b650(data, notifyhandled);
    }
  }
}

function function_321d2815afe991f5(data) {
  assert(isDefined(data));
  assert(isDefined(data.entity));
  assert(isDefined(data.category));

  if(data.entity executeevent(data.category, data.params)) {
    return 1;
  }

  switch (data.category) {
    case #"hash_4c8ad9f2942ea5b":
      data.entity thread bcs_stateChange(data);
      break;
    case #"hash_1044d327487d801a":
    case #"hash_184bba7053cc1c15":
    case #"hash_20cd76d83c2f7487":
      if(getprojectname() == "T10") {
        if(!data.entity check_cooldown("ally_movement")) {
          return 0;
        }
      }

      data.entity clear_cooldown("ally_movement");
      data.entity thread battlechatter_events::moveevent();
      break;
    case #"hash_d6c61718f24df768":
      data.entity thread battlechatter_events::targetmoveevent(data.otherentity, data.subcategory);
      break;
    case #"hash_5a5c93f2debb75c":
      data.entity thread battlechatter_events::initialcombatevent(data.params[1], data.params[2]);
      break;
    case #"hash_3ee703de5a8989c6":
      data.entity thread battlechatter_events::firstcombatevent();
      break;
    case #"hash_eeed4ce2a5de2aa5":
      if(data.subcategory == "losing_target") {
        data.entity thread battlechatter_events::function_4cac457f943a8c93(data.otherentity);
      } else if(data.subcategory == "lost_target") {
        data.entity function_8e55175c05f5c74c("lost_target", "ask_target_location");
      } else if(data.subcategory == "cease_fire") {
        data.entity function_8e55175c05f5c74c("cease_fire", "hunt_order_hold");
      } else if(data.subcategory == "lost_target_elapsed") {
        data.entity thread battlechatter_events::function_afa3372bcb718c00(data.otherentity);
      }

      break;
    case #"hash_37bb23543c319104":
      if(data.subcategory == "hunt") {
        data.entity thread battlechatter_events::function_2a54054a9b4db4f9();
      }

      break;
    case #"hash_bb388ae078895394":
      data.entity thread battlechatter_events::function_47f346f1883ddebb();
      break;
    case #"hash_3f894d6ee31df868":
      if(data.subcategory == "combat_unaware") {
        data.entity function_8e55175c05f5c74c("combat_unaware", "hunt_reactions");
      }

      break;
    case #"hash_1fe1f9ada345556c":
      if(data.subcategory == "investigateposreached") {
        if(isDefined(data.params[2]) && data.params[2] == "saw_corpse") {
          return;
        }

        data.entity thread battlechatter_events::function_40f23048eea1f156();
      }

      break;
    case #"hash_1879579c479117e0":
      if(data.subcategory == "dodge_vehicle_start") {
        data.entity function_8e55175c05f5c74c("incoming_vehicle_response", utility::random(["hunt_reactions", "cmb_reactions"]));
      }

      break;
    case #"hash_124fc72bb55490ec":
      data.entity thread battlechatter_events::reloadevent();
      break;
    case #"hash_ecb83a34dd571174":
      data.entity thread battlechatter_events::moveevent(data.subcategory);
      break;
    case #"hash_661532715a742ebf":
      data.entity thread battlechatter_events::friendlyfireevent();
      break;
    case #"hash_58018e5cda140b2d":
      data.entity thread battlechatter_events::function_8e395f0842773dd3();
      break;
    case #"hash_c718a89b94ffdc2":
      data.entity thread battlechatter_events::function_64413ad08f9e3672();
      break;
    case #"hash_2d1406e602f0875d":
      data.entity thread battlechatter_events::attackevent();
      data.entity thread battlechatter_events::function_d287030420cc6ee2();
      break;
    case #"hash_ab2e692ee80521f8":
      data.entity thread battlechatter_events::burnevent(data.subcategory);
      break;
    case #"hash_8f9bb78729a54b2c":
    case #"hash_fbd5bcbb1cbe3154":
      data.entity thread battlechatter_events::function_4790a4ccd4fe3746(data.otherentity);
      break;
    case #"hash_a0721fe4fd9580f5":
      data.entity thread battlechatter_events::shootevent(data.subcategory);
      break;
    case #"hash_57203b1e53d3a619":
      if(isalive(data.entity)) {
        data.entity function_8e55175c05f5c74c("wounded", "wounded");
      }

      break;
    case #"hash_7a09a268a01b5f84":
      data.entity thread battlechatter_events::function_745bf8f1071be2bc();
      break;
    case #"hash_affe6c9db8e997d3":
      data.entity thread battlechatter_events::gettingcoverevent();
      data.entity thread battlechatter_events::function_98586cfd4d082843();
      break;
    case #"hash_278c7959b357bf3e":
      data.entity thread battlechatter_events::function_136b9fca48877622();
      break;
    case #"hash_2be091d2ce1d5a7d":
      data.entity battlechatter_events::curiousevent(data.params[0], data.otherentity);
      break;
    default:
      return 0;
  }

  return 1;
}

function function_df70a19285f4de71(data) {
  assert(isDefined(data));
  assert(isDefined(data.entity));
  assert(isDefined(data.category));

  switch (data.category) {
    case #"hash_631f416c3d8360d4":
      data.entity thread battlechatter_events::useevent(data.subcategory, utility::cointoss());
      break;
    case #"hash_12cb1aa4c57395":
      data.entity thread battlechatter_events::grenadedangerevent(data.otherentity);
      break;
    case #"hash_9a35360cb2dc98e6":
      data.entity thread battlechatter_events::useevent(data.subcategory, 1);
      break;
    default:
      return false;
  }

  return true;
}

function bcs_stateChange(data) {
  previousstate = data.params[0];
  currentstate = data.params[1];
  ai_event = data.params[2];
  var_ad9711912754c77e = function_e02d101943406091(data.otherentity);

  if(previousstate == 4) {
    return;
  }

  if(previousstate == currentstate) {
    return;
  }

  self notify("bcs_stateChange", previousstate, currentstate);

  switch (currentstate) {
    case 0:
      return battlechatter_events::function_6cc3a5d13a9ed019(previousstate);
    case 1:
      if(var_ad9711912754c77e) {
        return battlechatter_events::function_3e0ffbbb5ac53efe();
      } else {
        return battlechatter_events::enterinvestigateevent(ai_event);
      }
    case 2:
      return battlechatter_events::function_60a8c67006abef53();
    case 3:
      battlechatter_events::function_cd57bb745df5f738();

      if(previousstate <= 2) {
        self.var_8ce29ad1168f36c5 = gettime();
      }

      if(previousstate < 2) {
        if(var_ad9711912754c77e) {
          return battlechatter_events::function_554ecda4a99dea75();
        } else {
          return battlechatter_events::function_59b6754d05797405(previousstate, ai_event);
        }
      } else {
        return battlechatter_events::entercombatevent();
      }

      break;
  }
}

function function_c466723bbd1d42d(dist) {
  level.bcs_maxdist = 2048;
  level.bcs_maxdistsqrd = squared(level.bcs_maxdist);
}

function init_battlechatteroverrides(overrides) {
  level.battlechatteroverrides = overrides;
}

function function_e4b05c2557b90c3e() {
  if(!isDefined(level.battlechatteroverrides)) {
    level.battlechatteroverrides = spawnStruct();
    level.battlechatteroverrides.idlemindelay = 10;
    level.battlechatteroverrides.idlemaxdelay = 16;
    level.battlechatteroverrides.huntmindelay = 4;
    level.battlechatteroverrides.huntmaxdelay = 12;
    level.battlechatteroverrides.combatmindelay = 1;
    level.battlechatteroverrides.combatmaxdelay = 2;
    return;
  }
}

function init_squadbattlechatter() {
  squad = self;
  squad.chatinitialized = 1;
  squad notify("squad chat initialized");
}

function bcsenabled() {
  return isDefined(level.battlechatter);
}

function bcs_setup_voice(voice, countryid, numvoices, var_24271cf266aff0bf, combatmapid, stealthmapid) {
  if(!isDefined(var_24271cf266aff0bf)) {
    var_24271cf266aff0bf = 0;
  }

  anim.usedids[voice] = [];

  for(i = 0; i < numvoices; i++) {
    anim.usedids[voice][i] = spawnStruct();
    anim.usedids[voice][i].count = 0;
    anim.usedids[voice][i].npcid = "" + i + 1;
  }

  anim.countryids[voice] = countryid;
  anim.var_4ef5299ac30c33e6[countryid] = combatmapid;
  anim.var_c285202ed79ffced[countryid] = stealthmapid;
}

function bcs_init_locations() {
  assert(!isDefined(anim.bcs_locations));
  triggers = getEntArray("trigger_multiple", #code_classname);
  location_triggers = [];

  foreach(trigger in triggers) {
    if(!issubstr(trigger.classname, "trigger_multiple_bcs")) {
      continue;
    }

    location_triggers[location_triggers.size] = trigger;
    trigger.location = getsubstr(trigger.classname, 24, trigger.classname.size);

    if(trigger.spawnflags & 1) {
      trigger.islandmark = 1;
    }
  }

  level.battlechatter.location_triggers = location_triggers;
}

function shutdown_battlechatter() {
  level.battlechatter = undefined;
  level notify("battlechatter disabled");
}

function bcs_loop() {
  level endon("battlechatter disabled");
  wait 1;

  for(;;) {
    if(!isDefined(level.players) || level.players.size < 1) {} else {
      players = level.players;
      var_f4ef5b0da10c23ca = throttle::throttle_initialize_gate("bscProcessPlayer", 2);

      for(p = 0; p < players.size; p++) {
        player = players[p];

        if(!isDefined(player) || !isalive(player) || !isDefined(player.origin)) {
          continue;
        }

        if(player.bcs_isprocessing) {
          continue;
        }

        player thread function_b5f83d119f8258e5();
        throttle::function_793863e476bf1524(var_f4ef5b0da10c23ca);
      }
    }

    waitframe();
  }
}

function function_b5f83d119f8258e5() {
  self endon("death_or_disconnect");

  if(!self.bcs_init) {
    thread bcs_initPlayer();
    self.bcs_init = 1;
  }

  nearby_ai = getaiinrange(self.origin, level.var_d9e54908db3a5ba3);

  if(nearby_ai.size <= 0) {
    return;
  }

  self.bcs_isprocessing = 1;
  nearby_ai = sortbydistance(nearby_ai, self.origin);
  count = min(nearby_ai.size, 10);

  for(i = 0; i < count; i++) {
    waitframe();
    count_ratio = (i + 1) / count;

    if(utility::percent_chance((1 - count_ratio) * 15)) {
      continue;
    }

    guy = nearby_ai[i];

    if(!isalive(guy) || !isDefined(guy.battlechatter) || guy.battlechatter.executingloop) {
      continue;
    }

    team = guy.team;
    origin = guy.origin;

    if(!(isDefined(team) && isDefined(origin)) || team == "neutral") {
      continue;
    }

    if(isDefined(guy.battlechatter.nextlooptime) && gettime() < guy.battlechatter.nextlooptime) {
      if(getdvarint(@ "bcs_loopdebug")) {
        print3d(origin + (0, 0, 80), "<dev string:x3a>", (1, 1, 1), 1, 0.3, 1, 1);
      }

      continue;
    }

    state = guy getcombatstate();

    if(!isDefined(state)) {
      continue;
    }

    if(state == "dead") {
      continue;
    }

    if(state == "combat" && guy function_3146b0fcae68998f()) {
      continue;
    }

    if(getdvarint(@ "bcs_loopdebug")) {
      bcs_debug_print("<dev string:x4f>" + "<dev string:x58>" + state + "<dev string:x66>" + "<dev string:x6f>");
      print3d(origin + (0, 0, 100), "<dev string:x78>", (1, 1, 1), 1, 0.3, 20, 1);
    }

    guy thread executeloopstate(state);

    if(utility::issp()) {
      guy function_6240e9af090bfb1();
    } else {
      guy function_4af9773d268acf12();
    }

    break;
  }

  self.bcs_isprocessing = 0;
}

function function_1d3591529c0364a9(var_30c44076b011eecc) {
  return isstring(var_30c44076b011eecc) && arraycontains(["frag_grenade", "semtex"], var_30c44076b011eecc);
}

function bcs_initPlayer() {
  self endon("death");
  self notify("bcs_initPlayer");
  self endon("bcs_initPlayer");
  childthread function_d9f87bceb3f6d07c();
  childthread function_8f242cbb1c70bdc6();
  childthread function_4f4f1017a3d6750();
}

function function_d9f87bceb3f6d07c() {
  self endon("disconnect");

  while(true) {
    self waittill("weapon_fired", weapon);
    self.last_weapon_fired_time = gettime();
    self.last_weapon_fired = weapon;
  }
}

function function_8f242cbb1c70bdc6() {
  while(true) {
    self waittill("grenade_fire", grenade);

    if(isDefined(grenade.weapon_object)) {
      bcs_subcategory = battlechatter_events::function_e08b029c30762ab3(grenade.weapon_object);

      if(isDefined(bcs_subcategory)) {
        addbattlechatternotify(self, undefined, "grenade_throw", bcs_subcategory);

        if(function_1d3591529c0364a9(bcs_subcategory)) {
          addbattlechatternotify(self, grenade, "grenade_danger");
        }
      }
    }
  }
}

function function_4f4f1017a3d6750() {
  while(true) {
    self waittill("missile_fire", missile, objweapon);
    bcs_subcategory = battlechatter_events::function_e08b029c30762ab3(objweapon);

    if(isDefined(bcs_subcategory)) {
      addbattlechatternotify(self, undefined, "use", bcs_subcategory);
    }
  }
}

function function_731b7eef54fdd8d2() {
  self endon("<dev string:x85>");
  self.var_731b7eef54fdd8d2 = 1;

  while(isDefined(level.players[0]) && isDefined(self.origin) && isDefined(level.players[0].origin)) {
    print3d(self.origin + (0, 0, 60), floor(distance(level.players[0].origin, self.origin)), (1, 1, 1), 1, 0.5, 1, 1);
    waitframe();
  }

  self.var_731b7eef54fdd8d2 = undefined;
}

function function_6240e9af090bfb1(seconds, shoulddisablecombat) {
  if(!isDefined(seconds)) {
    seconds = function_8f6e6ce3c52b4136(getcombatstate()) / 1000;
  }

  if(!(isDefined(self.origin) && isDefined(self.team))) {
    return function_4af9773d268acf12(seconds, shoulddisablecombat);
  }

  foreach(ai in getaiinrange(self.origin, level.bcs_neardist, self.team)) {
    ai function_4af9773d268acf12(seconds, shoulddisablecombat);
  }
}

function function_4af9773d268acf12(seconds, shoulddisablecombat) {
  if(!isDefined(self.battlechatter)) {
    return;
  }

  if(!isDefined(seconds)) {
    delay_ms = function_8f6e6ce3c52b4136(getcombatstate());
  } else {
    delay_ms = seconds * 1000;
  }

  self.battlechatter.nextlooptime = gettime() + delay_ms;

  if(shoulddisablecombat) {
    self.battlechatter.var_8568b6a2b1bdc9a2 = gettime() + delay_ms;
  }
}

function setchatterdelay(state, min_delay, max_delay) {
  assert(isnumber(min_delay), "<dev string:x8e>");
  assert(isnumber(max_delay), "<dev string:xac>");
  assert(min_delay <= max_delay, "<dev string:xca>");
  level.battlechatter.delays[state] = [min_delay, max_delay];
}

function function_8f6e6ce3c52b4136(state) {
  range = level.battlechatter.delays[state];

  if(!isDefined(range)) {
    range = level.battlechatter.delays["default"];
  }

  return randomfloatrange(range[0], range[1]) * 1000;
}

function addloopstate(state, func) {
  if(!isDefined(level.battlechatter)) {
    return;
  }

  assert(isDefined(level.battlechatter.states));
  level.battlechatter.states[state] = func;
}

function executeloopstate(state) {
  self endon("death");

  if(!isDefined(level.battlechatter)) {
    return;
  }

  assert(isDefined(level.battlechatter.states));
  func = level.battlechatter.states[state];

  if(!isDefined(func)) {
    return;
  }

  self.battlechatter.executingloop = 1;
  result = self[[func]]();
  self.battlechatter.executingloop = undefined;
  return result;
}

function addevent(event_name, sequence, priority, timeout, cooldown, endons) {
  if(!isDefined(level.battlechatter.events[event_name])) {
    level.battlechatter.events[event_name] = utility::create_deck();
  }

  event = spawnStruct();
  event.sequence = sequence;
  event.priority = priority;
  event.timeout = timeout;
  event.cooldown = cooldown;
  event.endons = endons;
  index = level.battlechatter.events[event_name].items.size;
  level.battlechatter.events[event_name].items[index] = event;
}

function addeventfunc(event_name, func) {
  if(!isDefined(level.battlechatter.events[event_name])) {
    level.battlechatter.events[event_name] = utility::create_deck();
  }

  index = level.battlechatter.events[event_name].items.size;
  level.battlechatter.events[event_name].items[index] = func;
}

function removeevent(event_name, var_ff30c6ef2e28a78) {
  if(!isDefined(level.battlechatter.events)) {
    return;
  }

  if(!isDefined(level.battlechatter.events[event_name])) {
    return;
  }

  new_items = [];

  foreach(index, var_d0c4787c4209e80f in level.battlechatter.events[event_name].items) {
    if(var_d0c4787c4209e80f == var_ff30c6ef2e28a78) {
      if(level.battlechatter.events[event_name].index > index) {
        level.battlechatter.events[event_name].index--;
      }

      continue;
    }

    new_items[new_items.size] = var_d0c4787c4209e80f;
  }

  level.battlechatter.events[event_name].items = new_items;
}

function executeevent(event_name, params) {
  if(!chatterallowed(self)) {
    return true;
  }

  if(!isDefined(level.battlechatter.events[event_name])) {
    return false;
  }

  event = level.battlechatter.events[event_name] utility::deck_draw();

  if(isarray(params)) {
    params = function_5713d46873b29625(params);
  }

  if(isfunction(event)) {
    thread dialogue::call_with_params_script(event, params);
  } else {
    thread function_b63bed8df8e4202a(event_name, event.sequence, event.priority, event.timeout, event.cooldown, event.endons);
  }

  return true;
}

function getallteams() {
  return ["axis", "allies", "neutral", "team3"];
}

function getcombatteams() {
  return ["axis", "allies", "team3"];
}

function getenemyteams() {
  return ["axis", "team3"];
}

function function_f124e89229d237d() {
  return ["allies", "neutral"];
}

function function_b63bed8df8e4202a(bcs_chatter_name, sequence, priority, timeout, cooldown, endons) {
  chatter = createchatter(bcs_chatter_name, sequence, priority, timeout, cooldown, endons);
  return playchatter(chatter);
}

function function_8e55175c05f5c74c(bcs_chatter_name, sequence, bcs_chatter_settings, endons) {
  if(!isDefined(bcs_chatter_settings)) {
    bcs_chatter_settings = level.battlechatter.settings[bcs_chatter_name];
  }

  if(isstring(bcs_chatter_settings)) {
    bcs_chatter_settings = level.battlechatter.settings[bcs_chatter_settings];
  }

  if(!isDefined(bcs_chatter_settings)) {
    iprintlnbold("<dev string:xff>" + bcs_chatter_name);

    return;
  }

  return function_b63bed8df8e4202a(bcs_chatter_name, sequence, bcs_chatter_settings[0], bcs_chatter_settings[1], bcs_chatter_settings[2], endons);
}

function private playchatter(chatter) {
  retstruct = undefined;
  speaker = self.vo_parent ?? self;

  if(getdvarint(@ "bcs_debug") == 1 || getdvarint(@ "bcs_debug") == 2) {
    retstruct = spawnStruct();
  }

  if(!chatter.forced && !speaker canchatter(undefined, undefined, retstruct)) {
    if(getdvarint(@ "bcs_debug") == 2) {
      bcs_debug_print("<dev string:x11d>" + (chatter.name ?? "<dev string:x133>") + "<dev string:x142>" + function_5082101982db4c30(speaker) + "<dev string:x142>" + (retstruct.text ?? "<dev string:x147>"));
    }

    chatter.finished_or_cancelled = 1;
    chatter notify("finished_or_cancelled");
    return 0;
  }

  if(isDefined(chatter.name) && !check_cooldown(chatter.name)) {
    if(getdvarint(@ "bcs_debug") == 2) {
      var_1b7171454d9016c5 = function_b1fcddf5ab7db4d8(chatter.name);
      extra = "<dev string:x147>";

      if(var_1b7171454d9016c5 != chatter.name) {
        extra = "<dev string:x14b>" + var_1b7171454d9016c5;
      }

      bcs_debug_print("<dev string:x15e>" + chatter.name + "<dev string:x142>" + function_5082101982db4c30(speaker) + extra);
    }

    chatter.finished_or_cancelled = 1;
    chatter notify("finished_or_cancelled");
    return 0;
  }

  if(utility::issp()) {
    speaker function_6240e9af090bfb1();
  } else {
    speaker function_4af9773d268acf12();
  }

  speaker set_cooldown(chatter.name, chatter.cooldown);
  level.battlechatter notify("chatter_added", chatter);
  chatter thread function_c383bd09ff253af8();
  return chatter;
}

function function_a0286b4f2f02e98d(name, sequence, priority, timeout, cooldown, endons) {
  chatter = createchatter(name, sequence, priority, timeout, cooldown, endons);
  return waitplaychatter(chatter);
}

function waitplaychatter(chatter) {
  playchatter(chatter);
  waitchatter(chatter);
}

function waitchatter(chatter) {
  if(!isDefined(chatter) || !isstruct(chatter)) {
    return;
  }

  if(!chatter.finished_or_cancelled) {
    chatter waittill("finished_or_cancelled");
  }

  var_7237854e3be197ca = chatter.finished;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }
}

function function_c383bd09ff253af8() {
  self.finished = 0;
  self.finished_or_cancelled = 0;
  self.speaker.var_e4fec99876f6a732 = self.scope;
  self.speaker notify("started_queue_wait", self);
  cancelled = self.scope_ents[self.scope] dialogue::wait_vo_queue(self, self.timeout, self.endons);
  self.speaker notify("finished_queue_wait", self, cancelled);
  speaker = self.speaker.vo_parent ?? self.speaker;

  if(!cancelled && (self.forced || speaker canchatter())) {
    level.battlechatter notify("chatter_started", self);
    self.speaker.var_569f79b89b587aba = self.priority;

    foreach(ent in self.scope_ents) {
      ent dialogue::add_vo_data(self);
    }

    self notify("proceeded");

    while(isDefined(self.finished) && !self.finished) {
      self.finished = function_80199f905399605b();
    }

    if(utility::is_dead_or_dying(self.speaker)) {
      self.speaker dialogue::stop_dialogue();

      if(isDefined(self.noreply_seq)) {
        self.listener function_8e55175c05f5c74c(self.name + "_interrupt", self.noreply_seq, level.battlechatter.settings["_interrupt"]);
      }
    }

    if(self.finished) {
      if(self.name == "idle_convo" || self.name == "idle") {
        self.speaker set_cooldown(self.name, level.var_a99c5a25405545fc);
      } else {
        self.speaker set_cooldown(self.name, self.cooldown);
      }
    }

    foreach(ent in self.scope_ents) {
      ent dialogue::remove_vo_data(self);
    }
  } else {
    self notify("proceeded");

    if(getdvarint(@ "bcs_debug") == 2 && self.speaker canchatter()) {
      bcs_debug_print("<dev string:x172>" + (self.name ?? "<dev string:x133>") + "<dev string:x142>" + function_5082101982db4c30(self.speaker));
    } else if(getdvarint(@ "bcs_debug") == 2) {
      bcs_debug_print("<dev string:x185>" + (self.name ?? "<dev string:x133>") + "<dev string:x142>" + function_5082101982db4c30(self.speaker));
    }
  }

  dialogue::function_d621ed37c021620a(self.scope_ents);
  self.speaker notify("chatter_finished_or_cancelled", self);
  level.battlechatter notify("chatter_finished_or_cancelled", self);
  self.finished_or_cancelled = 1;
  self notify("finished_or_cancelled");
}

function function_80199f905399605b() {
  dead_or_dying = utility::is_dead_or_dying(self.speaker);
  in_takedown = self.speaker function_8a9e492c66066776();

  if(dead_or_dying || in_takedown) {
    if(isDefined(self.noreply_seq)) {
      switchspeaker();
      self.sequence = self.noreply_seq;
      self.index = 0;
      self.noreply_seq = undefined;
    } else {
      if(getdvarint(@ "bcs_debug")) {
        if(dead_or_dying) {
          bcs_debug_print("<dev string:x1a6>" + (self.name ?? "<dev string:x133>") + "<dev string:x142>" + debug::function_a8ee5e70fb7d68d0(self.speaker));
          return;
        }

        bcs_debug_print("<dev string:x1bc>" + (self.name ?? "<dev string:x133>") + "<dev string:x142>" + debug::function_a8ee5e70fb7d68d0(self.speaker));
      }

      return;
    }
  }

  self.speaker notify("stop_bcs_sequence");
  self.speaker endon("death");
  self.speaker endon("stop_bcs_sequence");
  self.speaker endon("removed from battleChatter");
  endon_ent = self.speaker;

  foreach(endon_data in self.endons) {
    if(isent(endon_data) || isstruct(endon_data)) {
      endon_ent = endon_data;
      continue;
    }

    if(isstring(endon_data)) {
      endon_ent endon(endon_data);
    }
  }

  if(!(isDefined(self.sequence) && isDefined(self.index))) {
    if(getdvarint(@ "bcs_debug")) {
      bcs_debug_print("<dev string:x1d9>" + (self.name ?? "<dev string:x133>"));
    }

    return;
  }

  vo_queue = level.vo_teams[self.speaker.team].vo_queue;

  if(vo_queue.size > 0 && vo_queue[0].priority > self.priority) {
    if(getdvarint(@ "bcs_debug")) {
      bcs_debug_print("<dev string:x1fb>" + (self.name ?? "<dev string:x133>") + "<dev string:x211>" + self.priority + "<dev string:x216>" + (vo_queue[0].name ?? "<dev string:x133>") + "<dev string:x211>" + vo_queue[0].priority);
    }

    return;
  }

  if(self.index >= self.sequence.size) {
    return 1;
  }

  self.alias = undefined;

  if(utility::issp()) {
    self.speaker function_6240e9af090bfb1();
  } else {
    self.speaker function_4af9773d268acf12();
  }

  segment = self.sequence[self.index];
  self.index++;

  if(isstring(segment)) {
    self.alias = constructalias(segment);

    self.sequence[self.index - 1] = self.alias;

    if(!soundexists(self.alias)) {
      if(self.var_e766c94762317eec) {
        self.var_e766c94762317eec = undefined;
        return 0;
      }

      if(getdvarint(@ "bcs_debug")) {
        if(!isDefined(self.speaker.battlechatter.countryid)) {
          bcs_debug_print("<dev string:x21d>" + (self.name ?? "<dev string:x133>") + "<dev string:x231>" + self.speaker getentitynumber() + "<dev string:x23a>" + (anim.countryids[self.speaker.voice] ?? "<dev string:x147>") + "<dev string:x252>" + (self.speaker.voice ?? "<dev string:x147>"));
        } else if(self.alias == "<dev string:x147>") {
          bcs_debug_print("<dev string:x25c>" + (self.name ?? "<dev string:x133>") + "<dev string:x27b>" + self.speaker.battlechatter.countryid + "<dev string:x282>" + segment + "<dev string:x288>");

          if(!isDefined(level.battlechatter.var_63a95eda8c446908)) {
            level.battlechatter.var_63a95eda8c446908 = [];
          }

          if(!isDefined(level.battlechatter.var_63a95eda8c446908[segment]) && (!isai(self.speaker) || self.speaker.team == "<dev string:x28d>" || !level.var_5c667f1aff59def9)) {
            if(!isDefined(level.battlechatter.var_2f0e16fc6b6dd046)) {
              level.battlechatter.var_2f0e16fc6b6dd046 = [];
            }

            if(!isDefined(level.battlechatter.var_2f0e16fc6b6dd046[segment])) {
              level.battlechatter.var_2f0e16fc6b6dd046[segment] = 0;
            }

            level.battlechatter.var_2f0e16fc6b6dd046[segment]++;
            thread function_b036621f1a4d4177();
          }
        } else {
          bcs_debug_print("<dev string:x295>" + (self.name ?? "<dev string:x133>") + "<dev string:x2af>" + self.alias + "<dev string:x2b6>" + "<dev string:x2c1>" + self.speaker.battlechatter.countryid + "<dev string:x282>" + segment + "<dev string:x288>");

          if(!isDefined(level.battlechatter.missingsoundalias)) {
            level.battlechatter.missingsoundalias = [];
          }

          if(!isDefined(level.battlechatter.var_63a95eda8c446908)) {
            level.battlechatter.var_63a95eda8c446908 = [];
          }

          if(!isDefined(level.battlechatter.missingsoundalias[self.alias])) {
            level.battlechatter.missingsoundalias[self.alias] = 0;
          }

          level.battlechatter.missingsoundalias[self.alias]++;
          thread function_b036621f1a4d4177();
        }

        return 0;
      }

      return;
    }

    if(getdvarint(@ "bcs_debug") == 1 || getdvarint(@ "bcs_debug") == 2) {
      retstruct = spawnStruct();
    }

    speaker = self.speaker.vo_parent ?? self.speaker;

    if(!self.forced && !speaker canchatter(undefined, undefined, retstruct)) {
      if(getdvarint(@ "bcs_debug")) {
        bcs_debug_print("<dev string:x2c6>" + (self.name ?? "<dev string:x133>") + "<dev string:x142>" + function_5082101982db4c30(self.speaker.vo_parent ?? self.speaker) + "<dev string:x142>" + (retstruct.text ?? undefined));
      }

      return;
    }

    if(!dialogue::has_priority(self.scope_ents[self.scope].vo_active, 1)) {
      if(getdvarint(@ "bcs_debug")) {
        bcs_debug_print("<dev string:x2e0>" + (self.name ?? "<dev string:x133>"));
      }

      return;
    }

    if(getdvarint(@ "bcs_debug") && !self.debug_first_print) {
      self.debug_first_print = 1;
      bcs_debug_print("<dev string:x2f7>" + (self.name ?? "<dev string:x133>") + "<dev string:x142>" + function_5082101982db4c30(self.owner));
    }

    finished = self.speaker dialogue::say_dialogue(self.alias, self.receivers);

    if(!finished) {
      if(getdvarint(@ "bcs_debug")) {
        bcs_debug_print("<dev string:x305>" + (self.name ?? "<dev string:x133>"));
      }

      return;
    }

    return 0;
  } else if(isnumber(segment)) {
    if(segment <= 0) {
      return 0;
    }

    wait segment;
    return 0;
  } else if(isent(segment) || isstruct(segment)) {
    result = switchspeaker(segment);

    if(isint(result) && result == 0) {
      if(getdvarint(@ "bcs_debug")) {
        bcs_debug_print("<dev string:x31e>" + (self.name ?? "<dev string:x133>"));
      }

      return;
    } else {
      return 0;
    }
  } else if(isfunction(segment)) {
    result = self[[segment]]();

    if(isDefined(result)) {
      if(isint(result) && result == 0) {
        if(getdvarint(@ "bcs_debug")) {
          bcs_debug_print("<dev string:x33c>" + (self.name ?? "<dev string:x133>") + "<dev string:x359>" + self.index - 1 + "<dev string:x288>");
        }

        return;
      }

      if(isarray(result)) {
        self.sequence = utility::array_insert_array(self.sequence, result, self.index);
      } else {
        arrayinsert(self.sequence, result, self.index);
      }
    }

    return 0;
  } else if(isarray(segment)) {
    self.sequence = utility::array_insert_array(self.sequence, segment, self.index);
    return 0;
  }

  if(getdvarint(@ "bcs_debug")) {
    bcs_debug_print("<dev string:x366>" + self.index + "<dev string:x383>" + (self.name ?? "<dev string:x133>"));
  }
}

function bcs_debug_print(text, var_b668a74ff68f069c) {
  if(isDefined(var_b668a74ff68f069c)) {
    var_b668a74ff68f069c.text = text;
    return;
  }

  debug::function_9d6fee9cf5908ddc(text);
  println(text);
}

function function_1885b87626c9fc2a() {
  level endon("<dev string:x391>");
  player = undefined;

  for(;;) {
    if(!getdvarint(@ "bcs_debug") || !(isDefined(level.battlechatter) && isDefined(level.vo_active))) {} else {
      vid_width = getdvarint(@ "vid_width", 1920);
      vid_height = getdvarint(@ "vid_height", 1080);
      vid_width_ratio = getdvarint(@ "vid_width") / 1920;
      vid_height_ratio = getdvarint(@ "vid_height") / 1080;
      setdvarifuninitialized(@ "bcs_debug_x", 350);
      setdvarifuninitialized(@ "bcs_debug_y", 250);
      setdvarifuninitialized(@ "bcs_debug_scale", 0.8);
      base_x = getdvarint(@ "bcs_debug_x") * vid_width_ratio;
      base_y = getdvarint(@ "bcs_debug_y") * vid_height_ratio;
      base_scale = getdvarfloat(@ "bcs_debug_scale") * vid_height_ratio;
      ln_height = 0;

      for(k = 0; k < level.vo_active.size; k++) {
        if(!level.vo_active[k].ischatter) {
          continue;
        }

        chatter = level.vo_active[k];
        sequence = chatter.sequence;

        if(isDefined(chatter.name)) {
          speaker = chatter.speaker.vo_parent ?? chatter.speaker;

          if(isstruct(chatter.speaker) && isDefined(chatter.speaker.vo_parent)) {
            speaker_text = "<dev string:x3ab>" + speaker getentitynumber() + "<dev string:x3b1>";
          } else if(isstruct(chatter.speaker)) {
            speaker_text = "<dev string:x3ab>" + "<dev string:x3bb>" + "<dev string:x3b1>";
          } else {
            speaker_text = "<dev string:x3ab>" + speaker getentitynumber();
          }

          event_info = "<dev string:x3c3>" + speaker_text + "<dev string:x24>" + chatter.name + "<dev string:x3ca>";

          if(!isDefined(speaker.team)) {
            color = (1, 1, 1);
          } else {
            color = speaker.team == "<dev string:x3d1>" ? (0.1, 0.9, 0.1) : (1, 0.2, 0.2);
          }

          pos_y = base_y + ln_height;
          printtoscreen2d(base_x + 2, pos_y, event_info, (0, 0, 0), 1.75 * base_scale);
          printtoscreen2d(base_x, pos_y + 2, event_info, (0, 0, 0), 1.75 * base_scale);
          printtoscreen2d(base_x, pos_y, event_info, color, 1.75 * base_scale);

          if(!isDefined(player)) {
            player = getclosestplayer((0, 0, 0));
          }

          if(isDefined(player)) {
            cam_x = mapfloat(0, vid_width, 380, -380, base_x * 0.5);
            cam_y = mapfloat(0, vid_height, -240, 240, pos_y * 0.5);
            var_5c6dd671289b46c4 = player function_bdb033038ede75bf((cam_x, cam_y, 0), 65, 5, 1);
            line(speaker.origin, var_5c6dd671289b46c4, color);
            debugstar(speaker.origin, color, 1, speaker_text);
          }

          ln_height += 30 * base_scale;
        }

        for(i = 0; i < sequence.size; i++) {
          display_ln = undefined;
          segment = sequence[i];

          if(isstring(segment)) {
            if(!isstartstr(segment, "<dev string:x3db>")) {
              alias = segment;
            } else {
              alias = chatter constructalias(segment);
              alias = getsubstr(alias, 6, alias.size);
            }

            display_ln = "<dev string:x3e2>" + (alias ?? segment);
          } else if(isnumber(segment)) {
            display_ln = "<dev string:x3eb>" + segment + "<dev string:x3f5>";
          } else if(isent(segment)) {
            ent_num = "<dev string:x3ab>" + segment getentitynumber();
            display_ln = "<dev string:x3fd>";

            if(isDefined(segment.animname)) {
              display_ln += segment.animname + "<dev string:x414>" + ent_num + "<dev string:x41a>";
            } else {
              display_ln += ent_num;
            }
          } else if(isstruct(segment) && isDefined(segment.vo_parent)) {
            ent_num = "<dev string:x3ab>" + segment.vo_parent getentitynumber();
            display_ln = "<dev string:x3fd>";

            if(isDefined(segment.vo_parent.animname)) {
              display_ln += segment.vo_parent.animname + "<dev string:x41f>" + ent_num + "<dev string:x41a>";
            } else {
              display_ln += ent_num + "<dev string:x42d>";
            }
          } else if(isfunction(segment)) {
            display_ln = "<dev string:x439>";
          }

          if(isDefined(display_ln)) {
            is_index = i == chatter.index - 1;
            color = is_index ? (1, 1, 0) : (1, 1, 1);
            space = (is_index ? 32 : 25) * base_scale;
            scale = (is_index ? 1.85 : 1.5) * base_scale;
            printtoscreen2d(base_x + 2, base_y + 2 + ln_height + is_index * 10 * base_scale, display_ln, (0, 0, 0), scale);
            printtoscreen2d(base_x + 2, base_y + 2 + ln_height + is_index * 10 * base_scale, display_ln, (0, 0, 0), scale);
            printtoscreen2d(base_x, base_y + ln_height + is_index * 10 * base_scale, display_ln, color, scale);
            ln_height += space;
          }
        }

        if(k < level.vo_active.size - 1) {
          printtoscreen2d(base_x, base_y + ln_height, "<dev string:x44a>", (1, 1, 1), 1.5 * base_scale);
          ln_height += 30 * base_scale;
        }
      }
    }

    waitframe();
  }
}

function private createchatter(name, sequence, priority, timeout, cooldown, endons) {
  chatter = spawnStruct();
  chatter.name = name;
  chatter.scope = level.battlechatter.scope ?? "team";
  chatter.owner = self;
  chatter.speaker = self;
  chatter.scope_ents = dialogue::function_bf5715bcec0f160a();
  chatter.ischatter = 1;

  if(!isarray(sequence)) {
    sequence = [sequence];
  }

  chatter.index = 0;
  chatter.sequence = sequence;
  chatter.forced = isDefined(level.battlechatter) && isDefined(self.battlechatter) && self.battlechatter.friendlyfire_force && name == "friendlyfire";
  chatter.priority = priority ?? 0;
  chatter.timeout = timeout ?? 1;
  chatter.cooldown = cooldown ?? 0;
  chatter.endons = endons ?? [];
  chatter.overlap = 1;

  if(!isarray(chatter.endons)) {
    chatter.endons = [chatter.endons];
  }

  return chatter;
}

function function_79675a6fd5f1a905(sequence) {
  foreach(segment in sequence) {
    if(isarray(segment)) {
      var_7237854e3be197ca = function_79675a6fd5f1a905(segment);

      if(isDefined(var_7237854e3be197ca)) {
        return var_7237854e3be197ca;
      }
    }

    if(isent(segment)) {
      return segment;
    }
  }
}

function getfirststring(sequence) {
  foreach(segment in sequence) {
    if(isarray(segment)) {
      var_7237854e3be197ca = getfirststring(segment);

      if(isDefined(var_7237854e3be197ca)) {
        return var_7237854e3be197ca;
      }
    }

    if(isstring(segment)) {
      return segment;
    }
  }
}

function constructalias(event_string) {
  if(isstartstr(event_string, "dx_")) {
    return event_string;
  }

  if(!isstartstr(event_string, "~") && !isstartstr(event_string, "c_") && !isstartstr(event_string, "s_")) {
    event_string = self.speaker battlechatter_events::event_lookup(event_string);
  }

  if(!isDefined(event_string)) {
    return "";
  }

  if(isarray(event_string)) {
    if(event_string.size > 0) {
      event_string = event_string[0];
    } else {
      return "";
    }
  }

  if(isstartstr(event_string, "dx_")) {
    return event_string;
  }

  if(!(isDefined(self.speaker) && isDefined(self.speaker.battlechatter))) {
    return "";
  }

  segs = strtok(event_string, "_");
  char = function_c34193e3513bfac2(self.speaker) ?? "";
  countryid = self.speaker.battlechatter.countryid ?? "";

  if(isDefined(self.speaker.battlechatter.countryidoverride)) {
    countryid = self.speaker.battlechatter.countryidoverride;
  }

  if(segs.size > 2) {
    if(isDefined(countryid)) {
      if(segs[0] == "s") {
        segs[0] = anim.var_c285202ed79ffced[countryid];
      } else {
        segs[0] = anim.var_4ef5299ac30c33e6[countryid];
      }
    }

    if(!(isDefined(countryid) && isDefined(segs[0]))) {
      if(getprojectname() == "T10") {
        segs[0] = "hcom";
      } else if(isstartstr(event_string, "c")) {
        segs[0] = "hrbc";
      } else {
        segs[0] = "hrcm";
      }
    }
  }

  switch (segs.size) {
    case 4:
      return ("dx_bc_" + segs[0] + "_" + segs[1] + "_" + char + "_" + segs[2] + "_" + segs[3]);
    case 3:
      return ("dx_bc_" + segs[0] + "_" + segs[1] + "_" + char + "_" + segs[2]);
    case 2:
      return ("dx_bc_" + segs[0] + "_" + char + "_" + segs[1]);
    case 1:
      if(self.speaker.battlechatter.isleader) {
        return ("dx_guid" + segs[0]);
      } else {
        return ("dx_guid" + segs[0] + "_" + char);
      }
    default:
      assertmsg("<dev string:x46f>" + event_string + "<dev string:x490>");
      break;
  }
}

function lookupchatter(event_string) {
  if(!isDefined(level.battlechatter.event_decks)) {
    createeventdecks();
  }

  if(isDefined(level.battlechatter.event_decks[event_string])) {
    return level.battlechatter.event_decks[event_string] utility::deck_draw();
  }

  return event_string;
}

function createeventdecks() {
  level.battlechatter.event_decks = [];
}

function function_c34193e3513bfac2(speaker) {
  if(isDefined(speaker.battlechatter.charoverride)) {
    return tolower(speaker.battlechatter.charoverride);
  }

  npcid = speaker.battlechatter.npcid ?? "";

  if(npcid.size == 4) {
    return tolower(npcid);
  }

  countryid = speaker.battlechatter.countryid ?? "";

  if(isDefined(speaker.battlechatter.countryidoverride)) {
    countryid = speaker.battlechatter.countryidoverride;
  }

  if(countryid == "RU") {
    return tolower(countryid + "0" + npcid);
  }

  return tolower(countryid + npcid);
}

function getmodeprefix(type = "stealth") {
  switch (type) {
    case #"hash_3d5f49f17b95335c":
      otn = getDvar(@ "hash_495535a4877b324d") != "off";
      return (otn ? "otn_" : "cst_");
    case #"hash_44e999799ff10fce":
      return "vom_";
    default:
      otn = getDvar(@ "hash_87dca5163728ce02") != "off";
      return (otn ? "otn_" : "cbc_");
  }
}

function getgamemode() {
  var_7237854e3be197ca = level.gamemode;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  mapname = getDvar(@ "mapname");

  switch (getsubstr(mapname, 0, 3)) {
    case #"hash_2865036c1ee43ae5":
      if(getsubstr(mapname, 0, 6) == "mp_br_") {
        level.gamemode = "br";
      } else {
        level.gamemode = "mp";
      }

      break;
    default:
      level.gamemode = "sp";
      break;
  }

  return level.gamemode;
}

function getlocation() {
  if(!isDefined(level.battlechatter.location_triggers)) {
    return;
  }

  location_triggers = self getistouchingentities(level.battlechatter.location_triggers);

  if(location_triggers.size == 0) {
    return;
  }

  locations = [];

  foreach(trigger in location_triggers) {
    player_inside_landmark = isDefined(trigger.islandmark) && level.player istouching(trigger);

    if(player_inside_landmark || !isDefined(trigger.location)) {
      continue;
    }

    locations[locations.size] = trigger.location;
  }

  return utility::random(locations);
}

function chatterallowed(guy, do_debug, debug_chatter_name) {
  if(!(isDefined(level.battlechatter) && isDefined(guy.battlechatter))) {
    if(do_debug && getdvarint(@ "bcs_debug") >= 2) {
      bcs_debug_print("<dev string:x11d>" + (debug_chatter_name ?? "<dev string:x133>") + "<dev string:x142>" + function_5082101982db4c30(guy) + "<dev string:x495>");
    }

    return false;
  }

  if(level.battlechatterdisabled) {
    if(do_debug && getdvarint(@ "bcs_debug") >= 2) {
      bcs_debug_print("<dev string:x11d>" + (debug_chatter_name ?? "<dev string:x133>") + "<dev string:x142>" + function_5082101982db4c30(guy) + "<dev string:x4cd>");
    }

    return false;
  }

  if(!guy.battlechatterallowed) {
    if(do_debug && getdvarint(@ "bcs_debug") >= 2) {
      bcs_debug_print("<dev string:x11d>" + (debug_chatter_name ?? "<dev string:x133>") + "<dev string:x142>" + function_5082101982db4c30(guy) + "<dev string:x4f4>");
    }

    return false;
  }

  if(isDefined(level.battlechatterdisabledteams)) {
    team = guy.team ?? "";

    if(level.battlechatterdisabledteams[team]) {
      if(do_debug && getdvarint(@ "bcs_debug") >= 2) {
        bcs_debug_print("<dev string:x11d>" + (debug_chatter_name ?? "<dev string:x133>") + "<dev string:x142>" + function_5082101982db4c30(guy) + "<dev string:x519>" + team + "<dev string:x53e>");
      }

      return false;
    }
  }

  return true;
}

function function_8a9e492c66066776() {
  if(!isDefined(self)) {
    return 0;
  }

  if(isai(self)) {
    if(utility::issharedfuncdefined(#"executions", #"is_in_takedown")) {
      return self[[utility::getsharedfunc(#"executions", #"is_in_takedown")]]();
    }
  }

  return 0;
}

function canchatter(requiredstate, sighttarget, var_b668a74ff68f069c, lastsighttime) {
  if(utility::is_dead_or_dying(self) || !(isDefined(self.team) && isDefined(self.origin)) || !chatterallowed(self)) {
    if(getdvarint(@ "bcs_debug") == 3 || isDefined(var_b668a74ff68f069c)) {
      bcs_debug_print("<dev string:x54c>", var_b668a74ff68f069c);
    }

    return false;
  }

  if(function_8a9e492c66066776()) {
    if(getdvarint(@ "bcs_debug") == 3 || isDefined(var_b668a74ff68f069c)) {
      bcs_debug_print("<dev string:x57b>", var_b668a74ff68f069c);
    }
  }

  if(isDefined(requiredstate) && getcombatstate() != requiredstate) {
    if(getdvarint(@ "bcs_debug") == 3 || isDefined(var_b668a74ff68f069c)) {
      bcs_debug_print("<dev string:x58a>", var_b668a74ff68f069c);
    }

    return false;
  }

  if(isDefined(sighttarget)) {
    if(!isDefined(lastsighttime)) {
      lastsighttime = 2;
    }

    if(!self seerecently(sighttarget, lastsighttime)) {
      if(getdvarint(@ "bcs_debug") == 3 || isDefined(var_b668a74ff68f069c)) {
        bcs_debug_print("<dev string:x5bb>", var_b668a74ff68f069c);
      }

      return false;
    }
  }

  if(self.in_melee_death) {
    if(getdvarint(@ "bcs_debug") == 3 || isDefined(var_b668a74ff68f069c)) {
      bcs_debug_print("<dev string:x5e3>", var_b668a74ff68f069c);
    }

    return false;
  }

  if(self._animactive && !self.battlechatter.allowanimactive) {
    if(getdvarint(@ "bcs_debug") == 3 || isDefined(var_b668a74ff68f069c)) {
      bcs_debug_print("<dev string:x5f5>", var_b668a74ff68f069c);
    }

    return false;
  }

  if(isPlayer(self)) {
    return true;
  }

  if(!getplayersinrange(self.origin, level.bcs_fardist).size > 0) {
    if(isDefined(var_b668a74ff68f069c)) {
      bcs_debug_print("<dev string:x607>", var_b668a74ff68f069c);
    }

    return false;
  }

  return true;
}

function bc_prefix(type) {
  return "dx_" + getmodeprefix(type) + function_c34193e3513bfac2(self) + "_";
}

function private function_b1fcddf5ab7db4d8(chatter_name) {
  chatter_settings = level.battlechatter.settings[chatter_name];

  if(isstring(chatter_settings)) {
    return chatter_settings;
  }

  return chatter_name;
}

function check_cooldown(name, players) {
  name = function_b1fcddf5ab7db4d8(name);

  if(!isDefined(players)) {
    if(utility::issp()) {
      players = [level.player];
    } else {
      players = getplayersinrange(self.origin, level.bcs_fardist);
    }
  }

  foreach(player in players) {
    if(!(isDefined(player.bcs_cooldowns) && isDefined(player.bcs_cooldowns[self.team]))) {
      continue;
    }

    if(!isDefined(player.bcs_cooldowns[self.team][name])) {
      continue;
    }

    if(gettime() < player.bcs_cooldowns[self.team][name]) {
      return false;
    }
  }

  return true;
}

function function_bff9aef8d7c8e8a9(name, duration, players) {
  name = function_b1fcddf5ab7db4d8(name);

  if(!check_cooldown(name, players)) {
    return false;
  }

  set_cooldown(name, duration, players);
  return true;
}

function set_cooldown(name, duration, players) {
  if(!(isDefined(duration) && isDefined(name) && isDefined(self.origin))) {
    return;
  }

  name = function_b1fcddf5ab7db4d8(name);

  if(!isDefined(players)) {
    if(utility::issp()) {
      players = [level.player];
    } else {
      players = getplayersinrange(self.origin, level.bcs_fardist);
    }
  }

  foreach(player in players) {
    if(!isDefined(player.bcs_cooldowns)) {
      player.bcs_cooldowns = [];
    }

    if(!isDefined(player.bcs_cooldowns[self.team])) {
      player.bcs_cooldowns[self.team] = [];
    }

    player.bcs_cooldowns[self.team][name] = gettime() + duration * 1000;

    if(utility::ismp()) {
      player.bcs_cooldowns[self.team] = function_60af3649d76450da(player.bcs_cooldowns[self.team], 5);
    }
  }
}

function clear_cooldown(name) {
  if(!(isDefined(name) && isDefined(self.origin))) {
    return;
  }

  name = function_b1fcddf5ab7db4d8(name);

  if(utility::issp()) {
    players = [level.player];
  } else {
    players = getplayersinrange(self.origin, level.bcs_fardist);
  }

  foreach(player in players) {
    if(!isDefined(player.bcs_cooldowns)) {
      continue;
    }

    if(!isDefined(player.bcs_cooldowns[self.team])) {
      continue;
    }

    player.bcs_cooldowns[self.team][name] = undefined;
  }
}

function switchspeaker(new_speaker) {
  if(!isDefined(new_speaker)) {
    new_speaker = self.listener;
  }

  if(!isDefined(new_speaker)) {
    new_speaker = function_cafa639f15ad2523();
  }

  if(isint(new_speaker) && new_speaker == 0) {
    return 0;
  }

  foreach(ent in self.scope_ents) {
    ent dialogue::remove_vo_data(self);
  }

  self.listener = self.speaker;
  self.speaker = new_speaker;
  self.speaker.var_569f79b89b587aba = self.priority;
  self.scope_ents = self.speaker dialogue::function_bf5715bcec0f160a();

  foreach(ent in self.scope_ents) {
    ent dialogue::add_vo_data(self);
  }
}

function function_cafa639f15ad2523() {
  var_7237854e3be197ca = self.speaker function_e2914765523651ec();

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  return 0;
}

function function_a11a364f995e0267() {
  var_7237854e3be197ca = self.speaker getclosestfriendlyspeaker();

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  return 0;
}

function function_719609ee364b3a79() {
  var_7237854e3be197ca = self.speaker function_35122f7ab1b5d14f();

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  return 0;
}

function function_9619ea8607ade59d() {
  var_7237854e3be197ca = function_b394d5ccfe1e9f93(self.speaker);

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  return 0;
}

function function_26e971b16e545fce() {
  var_7237854e3be197ca = function_430ce31cc09b55c0(self.speaker);

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  return 0;
}

function getsubordinates() {
  rank = getrankvalue();

  if(!isDefined(rank)) {
    return getaiarray(self.team);
  }

  subordinates = [];

  foreach(guy in getaiarray(self.team)) {
    if(guy == self) {
      continue;
    }

    guy_rank = guy getrankvalue();

    if(isDefined(guy_rank) && guy_rank < rank) {
      subordinates[subordinates.size] = guy;
    }
  }

  return subordinates;
}

function getsuperiors() {
  rank = getrankvalue();

  if(!isDefined(rank)) {
    return getaiarray(self.team);
  }

  superiors = [];

  foreach(guy in getaiarray(self.team)) {
    if(guy == self) {
      continue;
    }

    guy_rank = guy getrankvalue();

    if(isDefined(guy_rank) && guy_rank > rank) {
      superiors[superiors.size] = guy;
    }
  }

  return superiors;
}

function function_346592950fc5f27e() {
  return self.team == "axis" || self.team == "team3" ? "allies" : "bad_guys";
}

function function_1272ffe375c8a106() {
  npcid = undefined;

  if(isDefined(self.battlechatter)) {
    npcid = self.battlechatter.npcid;
  }

  new_speaker = function_d3900dfe78938e4f(self.origin, getsubordinates(), npcid);

  if(!isDefined(new_speaker)) {
    new_speaker = getclosestfriendlyspeaker(self.team);
  }

  return new_speaker;
}

function function_4c093965853024b() {
  npcid = undefined;

  if(isDefined(self.battlechatter)) {
    npcid = self.battlechatter.npcid;
  }

  new_speaker = function_d3900dfe78938e4f(self.origin, getsuperiors(), npcid);

  if(!isDefined(new_speaker)) {
    new_speaker = getclosestfriendlyspeaker(self.team);
  }

  return new_speaker;
}

function function_35122f7ab1b5d14f() {
  npcid = undefined;

  if(isDefined(self.battlechatter)) {
    npcid = self.battlechatter.npcid;
  }

  new_speaker = function_ce7df4ebf491561c(getsubordinates(), npcid);

  if(!isDefined(new_speaker)) {
    new_speaker = function_e2914765523651ec(self.team);
  }

  return new_speaker;
}

function function_c94619f57e9621c0() {
  npcid = undefined;

  if(isDefined(self.battlechatter)) {
    npcid = self.battlechatter.npcid;
  }

  new_speaker = function_ce7df4ebf491561c(getsuperiors(), npcid);

  if(!isDefined(new_speaker)) {
    new_speaker = function_e2914765523651ec(self.team);
  }

  return new_speaker;
}

function getclosestfriendlyspeaker(team = self.team, requiredstate, requiresight, maxdist = level.bcs_neardist) {
  if(!isDefined(team) || team == "dead") {
    return;
  }

  if(!isDefined(self.origin)) {
    return;
  }

  npcid = undefined;

  if(isDefined(self.battlechatter.npcid)) {
    npcid = self.battlechatter.npcid;
  }

  return function_d3900dfe78938e4f(self.origin, getaiinrange(self.origin, maxdist, team), npcid, requiredstate, requiresight);
}

function getclosestenemyspeaker(team, requiredstate, requiresight, maxdist) {
  if(!(isDefined(self.enemy) && isDefined(self.enemy.team))) {
    return;
  }

  if(!isDefined(team)) {
    team = self.enemy.team;
  }

  if(!isDefined(maxdist)) {
    maxdist = level.bcs_neardist;
  }

  return function_d3900dfe78938e4f(self.origin, getaiinrange(self.origin, maxdist, team), undefined, requiredstate, requiresight);
}

function function_e2914765523651ec(team = self.team, requiredstate, requiresight, maxdist = level.bcs_neardist) {
  npcid = undefined;

  if(isDefined(self.battlechatter)) {
    npcid = self.battlechatter.npcid;
  }

  return function_ce7df4ebf491561c(getaiinrange(self.origin, maxdist, team), npcid, requiredstate, requiresight);
}

function function_488fbba7b008e1e5(team, requiredstate, requiresight, maxdist, lastsighttime) {
  if(!(isDefined(self.enemy) && isDefined(self.enemy.team))) {
    return;
  }

  if(!isDefined(team)) {
    team = self.enemy.team;
  }

  if(!isDefined(maxdist)) {
    maxdist = level.bcs_neardist;
  }

  return function_ce7df4ebf491561c(getaiinrange(self.enemy.origin, maxdist, team), undefined, requiredstate, requiresight, lastsighttime);
}

function function_d3900dfe78938e4f(origin, possible_speakers, excludeid, requiredstate, requiresight) {
  closest_distsq = undefined;
  closest_guy = undefined;
  sighttarget = undefined;

  if(requiresight) {
    sighttarget = self;
  }

  foreach(guy in possible_speakers) {
    if(issentient(self) && guy == self) {
      continue;
    }

    if(guy dialogue::function_ef3bb46d2024effd() || !guy canchatter(requiredstate, sighttarget) || guy.battlechatter.npcid == excludeid) {
      continue;
    }

    if(isDefined(guy.battlechatter) && guy.battlechatter.ishero) {
      continue;
    }

    if(isDefined(guy.battlechatter.countryid) && isDefined(self.battlechatter.countryid) && guy.battlechatter.countryid != self.battlechatter.countryid) {
      continue;
    }

    distsq = distance2dsquared(guy.origin, origin);

    if(!isDefined(closest_distsq) || distsq < closest_distsq) {
      closest_distsq = distsq;
      closest_guy = guy;
    }
  }

  return closest_guy;
}

function function_ce7df4ebf491561c(possible_speakers, excludeid, requiredstate, requiresight, lastsighttime) {
  best_guy = undefined;
  sighttarget = undefined;

  if(requiresight) {
    sighttarget = self;
  }

  isselfsentient = issentient(self);

  foreach(guy in possible_speakers) {
    if(isselfsentient && guy == self) {
      continue;
    }

    if(isDefined(guy.battlechatter.countryid) && guy.team === self.team && isDefined(self.battlechatter.countryid) && guy.battlechatter.countryid != self.battlechatter.countryid) {
      continue;
    }

    if(1 && isDefined(guy._blackboard.currentvehicle)) {
      continue;
    }

    if(guy dialogue::function_ef3bb46d2024effd() || !guy canchatter(requiredstate, sighttarget, undefined, lastsighttime)) {
      continue;
    }

    if(isDefined(guy.battlechatter) && guy.battlechatter.npcid == excludeid) {
      continue;
    }

    if(!isDefined(guy.var_861991271473c76)) {
      return guy;
    }

    if(!isDefined(best_guy) || guy.var_861991271473c76 < best_guy.var_861991271473c76) {
      best_guy = guy;
    }
  }

  return best_guy;
}

function getspeakers(team = self.team) {
  possible_speakers = [];

  foreach(guy in getaiarray(team)) {
    if(guy canchatter()) {
      possible_speakers[possible_speakers.size] = guy;
    }
  }

  return possible_speakers;
}

function getplayersinrange(origin, radius) {
  assert(isDefined(origin) && isDefined(radius));

  if(utility::issp() && distancesquared(origin, level.player.origin) < squared(radius)) {
    return [level.player];
  }

  if(isDefined(level.var_417561f3a462d6c3)) {
    return [[level.var_417561f3a462d6c3]](origin, radius);
  }

  return [];
}

function getaiinrange(origin, radius, team) {
  if(isDefined(level.var_8e07c78f18ec732d)) {
    return [[level.var_8e07c78f18ec732d]](origin, radius, team);
  }

  if(isDefined(team)) {
    return getaiarrayinradius(origin, radius, team);
  }

  return getaiarrayinradius(origin, radius);
}

function getenemiesinrange(radius) {
  if(!(isDefined(self.enemy.origin) && isDefined(self.enemy) && isDefined(self.enemy.team))) {
    return [];
  }

  if(!isDefined(radius)) {
    radius = level.bcs_maxdist;
  }

  enemies = getaiinrange(self.enemy.origin, radius, self.enemy.team);

  if(isDefined(self.team) && self.team != "allies" && self.team != "neutral") {
    players = getplayersinrange(self.enemy.origin, radius);
    enemies = arraycombine(enemies, players);
  }

  return enemies;
}

function function_1d2c927ed696138b(origin, radius, my_team) {
  enemiesinrange = [];

  if(isDefined(my_team) && isDefined(origin)) {
    if(!isDefined(radius)) {
      radius = level.bcs_maxdist;
    }

    aiinrange = getaiinrange(origin, radius);

    if(isDefined(aiinrange)) {
      foreach(ai in aiinrange) {
        if(!isDefined(ai)) {
          continue;
        }

        if(isDefined(ai.team) && ai.team == my_team) {
          continue;
        }

        enemiesinrange[enemiesinrange.size] = ai;
      }
    }
  }

  return enemiesinrange;
}

function isnear(target, radius) {
  return distancesquared(target.origin, self.origin) < squared(radius);
}

function function_650fcb19271636b2(var_d8505586e0d897f5, var_f2c2e2068164d350) {
  if(isDefined(self.voice) && self hasfemalevoice()) {
    return var_f2c2e2068164d350;
  }

  return var_d8505586e0d897f5;
}

function function_b44fb00b1156ebd0(enemy, var_5d2ede05ccf2f3e8, var_5d385e0da3c3ca8f, enemies) {
  if(isDefined(self.battlechatter) && enemy == self.battlechatter.target) {
    return var_5d2ede05ccf2f3e8;
  }

  if(!utility::ismp() && !isDefined(enemies)) {
    enemies = getenemiesinrange();
  }

  if(!utility::ismp() && enemies.size > 1) {
    return var_5d385e0da3c3ca8f;
  }

  return var_5d2ede05ccf2f3e8;
}

function set_target(target) {
  guy = self;

  if(self.ischatter) {
    guy = self.speaker;
  }

  if(!isDefined(target)) {
    target = guy.enemy;
  }

  guy set_target_internal(target);
}

function clear_target() {
  set_target_internal(undefined);
}

function set_target_internal(target) {
  if(isDefined(self.origin) && isDefined(self.team)) {
    foreach(ally in getaiinrange(self.origin, level.bcs_maxdist, self.team)) {
      if(isDefined(ally.battlechatter)) {
        ally.battlechatter.target = target;
      }
    }

    return;
  }

  if(isDefined(self.battlechatter)) {
    self.battlechatter.target = target;
  }
}

function bcs_on_ai_killed(params) {
  thread function_89d01d6c378dcfc5();
}

function function_89d01d6c378dcfc5() {
  if(!(isDefined(level.battlechatter) && isDefined(self))) {
    return;
  }

  if(self.nocorpse) {
    return;
  }

  if(!(isDefined(self.battlechatter) && isDefined(self.battlechatter.countryid))) {
    return;
  }

  if(!isDefined(level.var_37c0365dad77223)) {
    return;
  }

  corpse = undefined;
  num_tries = 10;
  var_e4890a00d660c30f = 1.5;
  countryid = self.battlechatter.countryid;
  name = self.battlechatter.name;
  voice = self.voice;
  team = self.team;
  count = 0;

  while(count < num_tries && !isDefined(corpse)) {
    array = [[level.var_37c0365dad77223]](self.origin, level.bcs_neardist);

    foreach(corpseent in array) {
      if(corpseent.birthtime == gettime() && distancesquared(corpseent.origin, self.origin) <= var_e4890a00d660c30f) {
        corpse = corpseent;
        break;
      }
    }

    count++;
    waitframe();
  }

  if(!isDefined(corpse)) {
    return;
  }

  corpse.battlechatter = spawnStruct();
  corpse.battlechatter.countryid = countryid;
  corpse.battlechatter.name = name;
  corpse.voice = voice;
  corpse.battlechatterallowed = 1;
  corpse.team = team;

  if(isDefined(level.stealth)) {
    corpse thread battlechatter_ai::corpseloop();
  }
}

function select_random(array) {
  return array[randomint(array.size)];
}

function random_variation(base, count) {
  if(!isDefined(level.battlechatter.variations[base])) {
    array = [];

    for(i = 0; i < count; i++) {
      array[i] = base + i;
    }

    level.battlechatter.variations[base] = utility::create_deck(array, 1, 1, 1);
  }

  return level.battlechatter.variations[base] utility::deck_draw();
}

function getrankvalue() {
  if(!isDefined(self.airank)) {
    return undefined;
  }

  switch (self.airank) {
    case #"hash_f26abb676d8bacec":
      return 0;
    case #"hash_66b7b438a1ca57c2":
      return 1;
    case #"hash_7f4da8c6011cd2d4":
      return 2;
    case #"hash_1453ef0182122bcb":
      return 3;
    case #"hash_9400db43df3e85c2":
      return 4;
    case #"hash_bcc86315db6ecf35":
      return 5;
    case #"hash_f1891197c342b74b":
      return 6;
    default:
      return undefined;
  }
}

function function_735a51a18ea3f10e() {
  if(!isDefined(level.battlechatter.callsigns)) {
    callsigns = [];

    foreach(ai in getaiarray()) {
      if(isDefined(ai.callsign)) {
        callsigns[callsigns.size] = ai.callsign;
      }
    }

    if(callsigns.size > 0) {
      level.battlechatter.callsigns = utility::create_deck(callsigns);
    }
  }

  if(isDefined(level.battlechatter.callsigns)) {
    self.callsign = level.battlechatter.callsigns utility::deck_draw();
  }
}

function addeventplaybcs(type, name, modifier, delay, stealthevent, force) {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("cancel speaking");
  self endon("stop event play bcs");

  if(!isDefined(modifier)) {
    return;
  }

  if(isDefined(delay)) {
    wait delay;
  }

  if(name == "state_change") {
    executed = executeevent(modifier);
    return;
  }

  executed = executeevent("announce", [modifier, stealthevent]);
}

function function_97b58bd147bf0b06() {
  radio = self.speaker dialogue::get_radio_emitter();
  radio.battlechatter.npcid = "l1r";
  radio.name = "Team Leader (Radio)";
  return radio;
}

function function_b394d5ccfe1e9f93(guy, isleader) {
  if(!isDefined(guy)) {
    guy = self.speaker;
  }

  if(!(isDefined(guy.voice) && isDefined(guy.battlechatter))) {
    return;
  }

  radio = spawnStruct();
  radio.vo_parent = guy;
  radio.origin = guy.origin;
  radio.isradioemitter = 1;
  radio.battlechatterallowed = 1;
  radio.team = self.team ?? "allies";
  radio.battlechatter = spawnStruct();

  if(!isDefined(guy.battlechatter.countryid)) {
    guy.battlechatter.countryid = "AQS";
  }

  if(isleader) {
    radio.battlechatter.isleader = 1;
    radio.battlechatter.lookupid = guy.battlechatter.countryid + "_L";
    radio.battlechatter.name = "actual";

    switch (guy.battlechatter.countryid) {
      case #"hash_782a246ccf672edf":
        npcids = ["pmcl"];
        break;
      case #"hash_8a9636c94e6076d":
        npcids = ["crtl"];
        break;
      case #"hash_fab89df6bdd4bc00":
        npcids = ["rusl"];
        break;
      case #"hash_4438aa6cb42c06a3":
        npcids = ["konl"];
        break;
      case #"hash_7850676ccf85ad6c":
        npcids = ["panl"];
        break;
      case #"hash_e9a4756c844899c3":
        npcids = ["gtgl"];
        break;
      case #"hash_35a2bd6cac97d049":
        npcids = ["irql"];
        break;
      case #"hash_178adf6c9cb5b60c":
        npcids = ["musl"];
        break;
      case #"hash_8d55d6c9508903d":
        npcids = ["kgfl"];
      case #"hash_f8933b6c8c234a3c":
      default:
        npcids = ["aqld"];
        break;
    }
  } else {
    npcids = [];

    foreach(usedid in anim.usedids[guy.voice]) {
      if(usedid.npcid != guy.battlechatter.npcid) {
        npcids[npcids.size] = usedid.npcid;
      }
    }
  }

  radio.battlechatter.countryid = guy.battlechatter.countryid;
  radio.battlechatter.npcid = utility::random(npcids);
  return radio;
}

function function_430ce31cc09b55c0(guy) {
  return function_b394d5ccfe1e9f93(guy, 1);
}

function getname() {
  if(!(isDefined(self.battlechatter) && isDefined(self.battlechatter.countryid))) {
    return;
  }

  if(!isDefined(self.battlechatter.name)) {
    if(!isDefined(level.battlechatter.names[self.battlechatter.countryid])) {
      namespace_326cae52b2158981::function_b0cd39ab5c17dcba(self.battlechatter.countryid);

      if(!isDefined(level.battlechatter.names[self.battlechatter.countryid])) {
        return;
      }
    }

    self.battlechatter.name = level.battlechatter.names[self.battlechatter.countryid] utility::deck_draw();
  }

  return self.battlechatter.name;
}

function getclosestplayer(origin) {
  if(!isDefined(level.players)) {
    return level.player;
  } else if(level.players.size == 0) {
    return undefined;
  }

  return sortbydistance(level.players, origin)[0];
}

function function_a9b9bc2e9ae0ab49(origin) {
  if(!isDefined(origin)) {
    origin = self.origin;
  }

  region_trigs = getEntArray("bcs_region", #script_noteworthy);

  foreach(trig in region_trigs) {
    if(ispointinvolume(origin, trig) && isDefined(trig.targetname)) {
      return trig.targetname;
    }
  }

  return "none";
}

function getcombatstate() {
  if(utility::is_dead_or_dying(self)) {
    return "dead";
  }

  if(isDefined(self.battlechatter.stateoverride)) {
    result = self.battlechatter.stateoverride;

    if(isfunction(result)) {
      result = self[[result]]();
    }

    var_7237854e3be197ca = result;

    if(isDefined(var_7237854e3be197ca)) {
      return var_7237854e3be197ca;
    }
  }

  if(!isDefined(level.stealth)) {
    return (isai(self) && self iscurrentenemyvalid() ? "combat" : "idle");
  }

  if(isDefined(self.fnisinstealthidle) && [[self.fnisinstealthidle]]()) {
    return "idle";
  }

  if(isDefined(self.fnisinstealthinvestigate) && [[self.fnisinstealthinvestigate]]()) {
    return "investigate";
  }

  if(isDefined(self.fnisinstealthhunt) && [[self.fnisinstealthhunt]]()) {
    return "hunt";
  }

  if(isDefined(self.fnisinstealthcombat) && [[self.fnisinstealthcombat]]()) {
    return "combat";
  }

  return isai(self) && self iscurrentenemyvalid() ? "combat" : "unset";
}

function addcustombc(array, states, random) {}

function setcurrentcustombcevent(event, states, looping) {}

function function_399b48e93d70a156(state) {
  if(!(isDefined(level.battlechatter.customstealth) && isDefined(level.battlechatter.customstealth[state]))) {
    return false;
  }

  return level.battlechatter.customstealth[state].size > 0;
}

function function_c5edc4d3fdb3dea1(state) {
  assert(isDefined(level.battlechatter.customstealth), "<dev string:x621>");
  index = level.battlechatter.customstealthindexes[state];
  sequence = level.battlechatter.customstealth[state][index];
  index++;

  if(index >= level.battlechatter.customstealth[state].size) {
    level.battlechatter.customstealth[state] = [];
  }

  return sequence;
}

function function_82e45e3126ee778a(array, states, random) {
  if(!isDefined(level.battlechatter.customstealth)) {
    level.battlechatter.customstealth = [];
  }

  if(!isarray(states)) {
    states = [states];
  }

  foreach(state in states) {
    if(!isDefined(level.battlechatter.customstealth[state])) {
      level.battlechatter.customstealth[state] = [];
    }

    foreach(sequence in array) {
      size = level.battlechatter.customstealth[state].size;
      level.battlechatter.customstealth[state][size] = sequence;
    }
  }
}

function getrelativeangles(ent) {
  assert(isDefined(ent));
  angles = ent.angles;

  if(!isPlayer(ent)) {
    if(isDefined(self.node)) {
      angles = self.node.angles;
    }
  }

  return angles;
}

function sideisleftright(side) {
  return side == "left" || side == "right";
}

function getdirectionfacingflank(vorigin, vpoint, vfacing) {
  var_d2668318c7a0e07d = vectortoangles(vfacing);
  anglestopoint = vectortoangles(vpoint - vorigin);
  angle = var_d2668318c7a0e07d[1] - anglestopoint[1];
  angle += 360;
  angle = int(angle) % 360;

  if(angle > 315 || angle < 45) {
    direction = "front";
  } else if(angle < 135) {
    direction = "right";
  } else if(angle < 225) {
    direction = "rear";
  } else {
    direction = "left";
  }

  return direction;
}

function normalizecompassdirection(direction) {
  assert(isDefined(direction));
  new = undefined;

  switch (direction) {
    case #"hash_b9ff0a9f617355e4":
      new = "n";
      break;
    case #"hash_b66b59dcd06dfad3":
      new = "nw";
      break;
    case #"hash_a1e9b77432f55b0e":
      new = "w";
      break;
    case #"hash_abed5ad834825ff1":
      new = "sw";
      break;
    case #"hash_fbd39e4f5634905a":
      new = "s";
      break;
    case #"hash_8856b747c93e7793":
      new = "se";
      break;
    case #"hash_22ce3b03c1e51a9c":
      new = "e";
      break;
    case #"hash_493bfd7122639b31":
      new = "ne";
      break;
    case #"hash_c1ae739be788bf38":
      new = "impossible";
      break;
    default:
      assertmsg("<dev string:x66e>" + direction);
      return;
  }

  assert(isDefined(new));
  return new;
}

function getdirectioncompass(vorigin, vpoint) {
  angles = vectortoangles(vpoint - vorigin);
  angle = angles[1];
  northyaw = getnorthyaw();
  angle -= northyaw;

  if(angle < 0) {
    angle += 360;
  } else if(angle > 360) {
    angle -= 360;
  }

  if(angle < 22.5 || angle > 337.5) {
    direction = "north";
  } else if(angle < 67.5) {
    direction = "northwest";
  } else if(angle < 112.5) {
    direction = "west";
  } else if(angle < 157.5) {
    direction = "southwest";
  } else if(angle < 202.5) {
    direction = "south";
  } else if(angle < 247.5) {
    direction = "southeast";
  } else if(angle < 292.5) {
    direction = "east";
  } else if(angle < 337.5) {
    direction = "northeast";
  } else {
    direction = "impossible";
  }

  return direction;
}

function getdistancemeters(source, target) {
  distanceinches = distance2d(source, target);
  distancemeters = 0.0254 * distanceinches;
  return distancemeters;
}

function getdistancemetersnormalized(source, target) {
  distancemeters = getdistancemeters(source, target);

  if(distancemeters < 15) {
    return "10";
  }

  if(distancemeters < 25) {
    return "20";
  }

  if(distancemeters < 35) {
    return "30";
  }

  if(distancemeters < 45) {
    return "40";
  }

  if(distancemeters < 55) {
    return "50";
  }

  if(distancemeters < 65) {
    return "60";
  }

  if(distancemeters < 75) {
    return "70";
  }

  if(distancemeters < 85) {
    return "80";
  }

  if(distancemeters < 95) {
    return "90";
  }

  if(distancemeters < 125) {
    return "100";
  }

  return undefined;
}

function getdistancemiles(source, target) {
  distanceinches = distance2d(source, target);
  distancemiles = 1.57828e-05 * distanceinches;
  return distancemiles;
}

function getdistancemilesnormalized(source, target) {
  distancemiles = getdistancemiles(source, target);

  if(distancemiles < 5) {
    return "4";
  }

  if(distancemiles < 6) {
    return "5";
  }

  if(distancemiles < 7) {
    return "6";
  }

  if(distancemiles < 15) {
    return "10";
  }

  return "15";
}

function getfrontarcclockdirection(direction) {
  assert(isDefined(direction));
  fadirection = "undefined";

  if(direction == "10" || direction == "11") {
    fadirection = "10";
  } else if(direction == "12") {
    fadirection = direction;
  } else if(direction == "1" || direction == "2") {
    fadirection = "2";
  }

  return fadirection;
}

function getdirectionfacingclock(viewerangles, viewerorigin, targetorigin) {
  forward = anglesToForward(viewerangles);
  vfacing = vectorNormalize(forward);
  var_d2668318c7a0e07d = vectortoangles(vfacing);
  anglestopoint = vectortoangles(targetorigin - viewerorigin);
  angle = var_d2668318c7a0e07d[1] - anglestopoint[1];
  angle += 360;
  angle = int(angle) % 360;

  if(angle > 345 || angle < 15) {
    direction = "12";
  } else if(angle < 45) {
    direction = "1";
  } else if(angle < 75) {
    direction = "2";
  } else if(angle < 105) {
    direction = "3";
  } else if(angle < 135) {
    direction = "4";
  } else if(angle < 165) {
    direction = "5";
  } else if(angle < 195) {
    direction = "6";
  } else if(angle < 225) {
    direction = "7";
  } else if(angle < 255) {
    direction = "8";
  } else if(angle < 285) {
    direction = "9";
  } else if(angle < 315) {
    direction = "10";
  } else {
    direction = "11";
  }

  return direction;
}

function getdegreeselevation(viewerorigin, targetorigin) {
  ht = targetorigin[2] - viewerorigin[2];
  dist = distance2d(viewerorigin, targetorigin);
  angle = atan(ht / dist);

  if(angle < 15 || angle > 65) {
    return angle;
  }

  if(angle < 25) {
    return 20;
  }

  if(angle < 35) {
    return 30;
  }

  if(angle < 45) {
    return 40;
  }

  if(angle < 55) {
    return 50;
  }

  if(angle < 65) {
    return 60;
  }
}

function getvectorrightangle(vdir) {
  return (vdir[1], 0 - vdir[0], vdir[2]);
}

function getvectorarrayaverage(avangles) {
  var_cc4bc55d2af11847 = (0, 0, 0);

  for(i = 0; i < avangles.size; i++) {
    var_cc4bc55d2af11847 += avangles[i];
  }

  return (var_cc4bc55d2af11847[0] / avangles.size, var_cc4bc55d2af11847[1] / avangles.size, var_cc4bc55d2af11847[2] / avangles.size);
}

function function_e02d101943406091(otherent) {
  if(!isDefined(otherent)) {
    return false;
  }

  if(!otherent.disguised) {
    return false;
  }

  return true;
}

function get_text(segment) {}

function set_battlechatter_variable(team, val) {
  level.battlechatter[team] = val;
  update_battlechatter_hud();
}

function update_battlechatter_hud() {
  if(getdvarint(@ "loc_warnings", 0) == 1) {
    return;
  }

  if(getDvar(@ "hash_2f6380dc3031a0fc", "<dev string:x147>") != "<dev string:x147>") {
    return;
  }

  if(!isDefined(level.bcs_hud)) {
    x = -50;
    y = 460;
    x_offset = 22;
    hud = newhudelem();
    hud.x = x;
    hud.y = y;
    hud.color = (0.4, 0.55, 0.9);
    level.bcs_hud = hud;
  }

  if(getDvar(@ "debug_battlechatter") != "<dev string:x694>") {
    level.bcs_hud settext("<dev string:x147>");
    return;
  }

  msg = "<dev string:x69a>";
  count = 0;

  if(isDefined(level.battlechatter)) {
    teams = [];
    teams["<dev string:x3d1>"] = level.battlechatter["<dev string:x3d1>"];
    teams["<dev string:x28d>"] = level.battlechatter["<dev string:x28d>"];

    foreach(team, val in teams) {
      if(val) {
        msg = msg + team + "<dev string:x142>";
        count++;
      }
    }
  } else {
    msg += "<dev string:x6b5>";
    count++;
  }

  if(count == 0) {
    msg += "<dev string:x6d8>";
  }

  level.bcs_hud settext(msg);
}

function bcprint_info() {
  self endon("death");

  id = self.battlechatter.npcid;

  if(!isDefined(id)) {
    id = "<dev string:x147>";
  }

  countryid = self.battlechatter.countryid;

  if(!isDefined(countryid)) {
    countryid = "<dev string:x147>";
  }

  while(true) {
    if(battlechatter_canprint()) {
      if(!isDefined(self.battlechatterallowed) || self.battlechatter_removed) {
        print3d(self.origin + (0, 0, 24), "<dev string:x6e6>", (1, 0, 1), 1, 0.35, 1);
      } else if(self.battlechatterallowed) {
        print3d(self.origin + (0, 0, 24), "<dev string:x6f5>" + countryid + id, (0, 1, 0), 1, 0.35, 1);
      } else {
        print3d(self.origin + (0, 0, 24), "<dev string:x6f5>" + countryid + id, (1, 0, 0), 1, 0.35, 1);
      }
    }

    waitframe();
  }
}

function battlechatter_canprint() {
  if(getDvar(@ "debug_bcprint") == self.team || getDvar(@ "debug_bcprint") == "<dev string:x6fd>") {
    return true;
  }

  return false;
}

function battlechatter_canprintdump() {
  if(getDvar(@ "debug_bcprintdump") == self.team || getDvar(@ "debug_bcprintdump") == "<dev string:x6fd>") {
    return true;
  }

  return false;
}

function battlechatter_print(alias, color) {
  if(!battlechatter_canprint()) {
    return;
  }

  if(!isDefined(color)) {
    color = "<dev string:x704>";
  }

  colorkey = "<dev string:x704>";

  switch (color) {
    case #"hash_97430f6c58e61cbc":
      colorkey = "<dev string:x714>";
      break;
    case #"hash_2ac407c1cd5943a9":
      colorkey = "<dev string:x724>";
      break;
    case #"hash_6686d129776d649a":
      colorkey = "<dev string:x732>";
      break;
  }

  println(colorkey + self.origin + "<dev string:x738>" + self.name + "<dev string:x73e>" + alias);
}

function battlechatter_printdump(alias) {
  if(!battlechatter_canprintdump()) {
    return;
  }

  dumptype = getDvar(@ "debug_bcprintdumptype", "<dev string:x746>");

  if(dumptype != "<dev string:x746>" && dumptype != "<dev string:x74d>") {
    return;
  }

  var_8741cc0c336c78a0 = -1;

  if(isDefined(level.var_66f4410fa44c341)) {
    var_8741cc0c336c78a0 = (gettime() - level.var_66f4410fa44c341) / 1000;
  }

  level.var_66f4410fa44c341 = gettime();

  if(dumptype == "<dev string:x746>") {
    if(!utility::flag_exist("<dev string:x754>")) {
      utility::flag_init("<dev string:x754>");
    }

    if(!isDefined(level.var_a5b74b32d1fe356a)) {
      filepath = "<dev string:x76f>" + level.script + "<dev string:x793>";
      level.var_a5b74b32d1fe356a = openfile(filepath, "<dev string:x79b>");
    }

    aliastype = getaliastypefromsoundalias(alias);
    dumpstring = level.script + "<dev string:x7a4>" + self.operatorcustomization.voice + "<dev string:x7a4>" + aliastype;
    battlechatter_printdumpline(level.var_a5b74b32d1fe356a, dumpstring, "<dev string:x754>");
    return;
  }

  if(dumptype == "<dev string:x74d>") {
    if(!utility::flag_exist("<dev string:x7a9>")) {
      utility::flag_init("<dev string:x7a9>");
    }

    if(!isDefined(level.var_81dcfda6de38eb66)) {
      filepath = "<dev string:x76f>" + level.script + "<dev string:x7c4>";
      level.var_81dcfda6de38eb66 = openfile(filepath, "<dev string:x79b>");
    }

    dumpstring = "<dev string:x7cc>" + var_8741cc0c336c78a0 + "<dev string:x7d1>";
    dumpstring += alias;
    battlechatter_printdumpline(level.var_81dcfda6de38eb66, dumpstring, "<dev string:x7a9>");
  }
}

function battlechatter_debugprint(alias, color) {
  battlechatter_print(alias, color);
  thread battlechatter_printdump(alias);
}

function battlechatter_printdumpline(file, str, controlflag) {
  if(utility::flag(controlflag)) {
    utility::flag_wait(controlflag);
  }

  utility::flag_set(controlflag);
  fprintln(file, str);
  utility::flag_clear(controlflag);
}

function getaliastypefromsoundalias(alias) {
  if(getsubstr(alias, 0, 6) == "dx_vom") {
    aliastype = getsubstr(alias, 7, alias.size);
  } else {
    if(self == anim.player) {
      prefix = self.battlechatter.countryid + "_";
    } else if(getsubstr(alias, 0, 6) == "dx_sbc") {
      prefix = bc_prefix("stealth");
    } else {
      prefix = bc_prefix();
    }

    assert(issubstr(alias, prefix), "<dev string:x7dc>" + alias + "<dev string:x80b>" + prefix + "<dev string:x826>");
    aliastype = getsubstr(alias, prefix.size, alias.size);
  }

  return aliastype;
}

function function_8dbb97f7a0f85de2(seconds) {
  if(isDefined(self.battlechatter)) {
    self.battlechatter.var_8568b6a2b1bdc9a2 = gettime() + seconds * 1000;
  }
}

function function_3146b0fcae68998f() {
  if(!canchatter("combat")) {
    return true;
  }

  if(utility::issp() && !isalive(level.player)) {
    return true;
  }

  if(!function_333c924b7c149360(3)) {
    if(isDefined(self.battlechatter.var_788421b4784edf9a) || !isDefined(self._blackboard)) {
      return true;
    }

    if(!shotrecently(3)) {
      self.battlechatter.var_788421b4784edf9a = gettime();
    }

    return true;
  }

  if(!isDefined(self.battlechatter.var_8568b6a2b1bdc9a2)) {
    return false;
  }

  return self.battlechatter.var_8568b6a2b1bdc9a2 > gettime();
}

function function_333c924b7c149360(timeseconds, requiresight = 0) {
  if(self.pacifist || self.ignoreall || self.dontevershoot) {
    return false;
  }

  if(!isDefined(self.enemy) || utility::is_dead_or_dying(self.enemy)) {
    return false;
  }

  if(!utility::ismp() && requiresight && !self seerecently(self.enemy, timeseconds)) {
    return false;
  }

  if(isDefined(self.asmtrackasm) && asm::asm_currentstatehasflag(self.asmtrackasm, "aim")) {
    return true;
  }

  if(shotrecently(timeseconds)) {
    return true;
  }

  return false;
}

function shotrecently(timeseconds) {
  return self._blackboard.shootparams_lastshoottime > gettime() - timeseconds * 1000;
}

function function_60af3649d76450da(array, maxsize = array.size - 1) {
  foreach(key, item in array) {
    if(array.size <= maxsize) {
      return array;
    }

    array[key] = undefined;
  }
}

function function_a7582e7ca9b907c5() {
  level endon("<dev string:x82c>");
  level notify("<dev string:x83a>");
  level endon("<dev string:x83a>");

  while(true) {
    waittillframeend();
    function_2f9773629c3fb45c(1);
    waitframe();
  }
}

function function_2f9773629c3fb45c(debugdrawframeduration) {
  if(!getdvarint(@ "hash_4b7858e66804e305")) {
    return;
  }

  offsety = 20;
  debugposx = 50;
  debugposy = 500;
  debugtextcolor = (0, 1, 0);
  debugtextscale = 1;
  debugtext = "<dev string:x861>";
  printtoscreen2d(debugposx, debugposy, debugtext, debugtextcolor, debugtextscale, debugdrawframeduration);
  debugposy += offsety;

  if(!isDefined(level.var_7ae4edfde7c1a849) || utility::queue_isempty(level.var_7ae4edfde7c1a849)) {
    return;
  }

  index = level.var_7ae4edfde7c1a849.rear;

  while(index != level.var_7ae4edfde7c1a849.front) {
    debug_string = level.var_7ae4edfde7c1a849.array[index];

    if(!isDefined(debug_string)) {
      continue;
    }

    printtoscreen2d(debugposx, debugposy, debug_string, debugtextcolor, debugtextscale, debugdrawframeduration);
    debugposy += offsety;
    index--;

    if(index < 0) {
      index += level.var_7ae4edfde7c1a849.capacity;
    }
  }
}

function function_4c3d5af8f9c8b650(data, executed) {
  if(!(isDefined(data) && isDefined(data.category))) {
    return;
  }

  if(!isDefined(level.var_7ae4edfde7c1a849)) {
    level.var_7ae4edfde7c1a849 = utility::queue_create(20);
    level thread function_a7582e7ca9b907c5();
  }

  debug_string = "<dev string:x878>" + data.category;

  if(isDefined(data.subcategory)) {
    debug_string += "<dev string:x886>" + data.subcategory;
  }

  debug_string += "<dev string:x41a>";
  debug_string += "<dev string:x88b>" + istrue(executed) + "<dev string:x41a>";
  debug_string += "<dev string:x899>" + gettime() + "<dev string:x41a>";

  if(level.var_7ae4edfde7c1a849.array.size == level.var_7ae4edfde7c1a849.capacity) {
    level.var_7ae4edfde7c1a849 = utility::function_6aa5e41ca11dd304(level.var_7ae4edfde7c1a849);
  }

  level.var_7ae4edfde7c1a849 = utility::queue_enqueue(level.var_7ae4edfde7c1a849, debug_string);
}

function function_5082101982db4c30(var_f171ce7e894edf13) {
  if(isstruct(var_f171ce7e894edf13)) {
    if(isDefined(var_f171ce7e894edf13.vo_parent)) {
      return ("<dev string:x8a5>" + debug::function_a8ee5e70fb7d68d0(var_f171ce7e894edf13.vo_parent));
    } else {
      return "<dev string:x8ba>";
    }

    return;
  }

  return debug::function_a8ee5e70fb7d68d0(var_f171ce7e894edf13);
}

function function_b036621f1a4d4177() {
  self endon("<dev string:x8c9>");

  if(level.battlechatter.var_b036621f1a4d4177) {
    return;
  }

  if(!isDefined(level.battlechatter.missingsoundalias)) {
    level.battlechatter.missingsoundalias = [];
  }

  if(!isDefined(level.battlechatter.var_2f0e16fc6b6dd046)) {
    level.battlechatter.var_2f0e16fc6b6dd046 = [];
  }

  level.battlechatter.var_b036621f1a4d4177 = 1;
  charwidth = 8;
  currxoff = 0;
  currmissing = [0, 0];
  printtime = 0.05;
  frames = 1;
  var_3fd593d40e72df2e = 0;
  height = [750, 730];
  header = ["<dev string:x8e6>", "<dev string:x8ff>"];
  var_798d38e6e42161e5 = 20 * header.size;
  screenx = 185;
  scale = 1.4;
  var_fc4ddad9fe045399 = gettime();
  shift = 2;

  while(getdvarint(@ "bcs_debug")) {
    aliasarray = [level.battlechatter.var_2f0e16fc6b6dd046, level.battlechatter.missingsoundalias];

    for(i = 0; i < header.size; i++) {
      out = "<dev string:x147>";

      if(!aliasarray[i].size) {
        continue;
      }

      key = getarraykey(aliasarray[i], currmissing[i]);
      value = aliasarray[i][key];
      printtoscreen2d(20, height[i], header[i], (0, 1, 0), 1, frames);
      out = key + "<dev string:x916>" + value;
      printtoscreen2d(screenx - shift, height[i] - shift, out, (0, 0, 0), scale, frames);
      printtoscreen2d(screenx + shift, height[i] + shift, out, (0, 0, 0), scale, frames);
      printtoscreen2d(screenx, height[i], out, (0, 1, 0), scale, frames);
      var_3fd593d40e72df2e++;

      if(!(var_3fd593d40e72df2e % var_798d38e6e42161e5)) {
        currmissing[i]++;

        if(currmissing[i] >= aliasarray[i].size) {
          currmissing[i] = 0;
        }
      }
    }

    if(getdvarint(@ "hash_297223f9ffda9dec") && var_fc4ddad9fe045399 < gettime()) {
      var_fc4ddad9fe045399 = gettime() + 10000;

      for(i = 0; i < header.size; i++) {
        println(header[i]);

        foreach(key, value in aliasarray[i]) {
          println(key + "<dev string:x916>" + value);
        }
      }
    }

    wait printtime;
  }

  level.battlechatter.var_b036621f1a4d4177 = undefined;
}

# /