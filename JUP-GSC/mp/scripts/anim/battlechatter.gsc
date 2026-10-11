/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\anim\battlechatter.gsc
***********************************************/

#using script_433d8f78f7e5fb;
#using scripts\anim\battlechatter_ai;
#using scripts\anim\battlechatter_events;
#using scripts\anim\battlechatter_table;
#using scripts\anim\dialogue;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace battlechatter;

function init_battlechatter() {
  setdvarifuninitialized(@ "hash_ab3249fe50b0f590", 1);
  setdvarifuninitialized(@ "hash_864d3ab12f741516", 0);
  setdvarifuninitialized(@ "hash_44ef18550505e010", 0);
  setdvarifuninitialized(@ "hash_350b154807f4d745", 0);
  setdvarifuninitialized(@ "hash_4b7858e66804e305", 0);
  setdvarifuninitialized(@ "hash_5aea525f549d2546", 0);

  if(isDefined(level.battlechatter) || getdvarint(@ "hash_ab3249fe50b0f590") == 0) {
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
  setdvarifuninitialized(@ "hash_611f04c407c3f644", "off");
  setdvarifuninitialized(@ "hash_1c663353dae9fab0", "off");
  setdvarifuninitialized(@ "hash_9627c73338f91622", "off");
  setdvarifuninitialized(@ "hash_3cb0b3f110a54cf2", "csv");
  setdvarifuninitialized(@ "hash_ef12a290c14c553f", "off");
  anim.bcprintfailprefix = "^1***** BCS FAILURE: ";
  anim.bcprintwarnprefix = "^3***** BCS WARNING: ";
  event_init();
  function_2f7fd2639db2a57b();
  function_2e88374b2f067e46();

  if(getprojectname() == "T10") {
    function_5430999882251a0c();
  } else if(getprojectname() == "JUP") {
    function_676ba319b8273e9e();
  }

  if(isDefined(level.var_aa78677d2156e18)) {
    [[level.var_aa78677d2156e18]]();
  }

  addloopstate("idle", &function_f06007e1f432ce27);
  addloopstate("investigate", &function_f6c7d545b09f9f0a);
  addloopstate("hunt", &function_7ce36b78c85185c2);
  addloopstate("combat", &function_f5154a3d477820d9);
  setchatterdelay("default", level.battlechatteroverrides.idlemindelay, level.battlechatteroverrides.idlemaxdelay);
  setchatterdelay("idle", level.battlechatteroverrides.idlemindelay, level.battlechatteroverrides.idlemaxdelay);
  setchatterdelay("hunt", level.battlechatteroverrides.huntmindelay, level.battlechatteroverrides.huntmaxdelay);
  setchatterdelay("combat", level.battlechatteroverrides.combatmindelay, level.battlechatteroverrides.combatmaxdelay);
  addeventfunc("curious", &curiousevent);
  addeventfunc("announce", &announceevent);
  addeventfunc("return_to_idle", &function_e64dbaaae396fbb8);
  addeventfunc("enter_hunt", &function_f4671f61a3031990);
  addeventfunc("join_combat", &joincombatevent);
  addeventfunc("enter_combat", &entercombatevent);
  addeventfunc("red_alert", &function_3dac2e167dc9be7a);

  foreach(deck in level.battlechatter.events) {
    deck deck_shuffle();
  }

  level.bcs_mindist = default_to(level.bcs_mindist, 200);
  level.var_fde5b385cc96729a = default_to(level.var_fde5b385cc96729a, squared(level.bcs_mindist));
  level.bcs_neardist = default_to(level.bcs_neardist, 650);
  level.var_c1ed820e79e07b7c = default_to(level.var_c1ed820e79e07b7c, squared(level.bcs_neardist));
  level.var_8893859de4351996 = default_to(level.var_8893859de4351996, 850);
  level.var_e4b1ac8399c73f44 = default_to(level.var_e4b1ac8399c73f44, squared(level.var_8893859de4351996));
  level.bcs_fardist = default_to(level.bcs_fardist, 1400);
  level.var_defb33e34eb9dee7 = default_to(level.var_defb33e34eb9dee7, squared(level.bcs_fardist));
  setsaveddvar(@ "hash_ab202f8049b3210a", level.bcs_fardist);
  level.bcs_maxdist = default_to(level.bcs_maxdist, 2000);
  level.bcs_maxdistsqrd = default_to(level.bcs_maxdistsqrd, squared(level.bcs_maxdist));
  level.var_dd332b4f1c13f7d5 = default_to(level.var_dd332b4f1c13f7d5, 300);
  level.var_27a93e38d913ff2f = default_to(level.var_27a93e38d913ff2f, squared(level.var_dd332b4f1c13f7d5));
  level.var_3c8c2ca8a1d0e8a7 = default_to(level.var_3c8c2ca8a1d0e8a7, 590);
  level.var_e49b54322cbd63c1 = default_to(level.var_e49b54322cbd63c1, squared(level.var_3c8c2ca8a1d0e8a7));
  level.var_8b1a7cec63f2e832 = default_to(level.var_8b1a7cec63f2e832, level.bcs_neardist);
  level.var_b1835eb671fbdac8 = default_to(level.var_b1835eb671fbdac8, squared(level.var_8b1a7cec63f2e832));
  level.var_1c60ace9b9fff6ff = default_to(level.var_1c60ace9b9fff6ff, 360);
  level.var_85b48a519a69f1b9 = default_to(level.var_85b48a519a69f1b9, squared(level.var_1c60ace9b9fff6ff));
  level.var_d809dc9f8a466642 = default_to(level.var_d809dc9f8a466642, 650);
  level.var_fe8551579a9d6778 = default_to(level.var_fe8551579a9d6778, squared(level.var_d809dc9f8a466642));
  level.var_8e8e487a64d9aa1b = default_to(level.var_8e8e487a64d9aa1b, 120);
  level.var_dafa42d7384e9ef5 = 10;

  if(isDefined(anim.squads)) {
    foreach(squad in anim.squads) {
      squad init_squadbattlechatter();
    }
  }

  anim.squadcreatefunc = &init_squadbattlechatter;

  if(!isDefined(anim.bcs_locations)) {
    function_2faee9e4cf862d61();
  }

  bcs_setup_countryids();

  thread function_a8c755adb8698257();

  level thread bcs_loop();
  level thread bcs_waittill();
}

function private function_2e88374b2f067e46() {
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
  var_69f88410d1c9e28b = getdvarint(@ "hash_2e9b4d77df5b8514") * 0.001;
  level.battlechatter.settings["lost_target_elapsed_1"] = [0.6, 0.5, var_69f88410d1c9e28b];
  level.battlechatter.settings["lost_target_elapsed_2"] = [0.6, 0.5, var_69f88410d1c9e28b];
  level.battlechatter.settings["hunt_initial"] = [0.9, 0.5, 10];
  level.battlechatter.settings["hunt_solo_enter"] = "hunt_initial";
  level.battlechatter.settings["hunt_solo_loop"] = "hunt_initial";
  level.battlechatter.settings["hunt_duo_enter"] = "hunt_initial";
  level.battlechatter.settings["hunt_duo_loop_near"] = "hunt_initial";
  level.battlechatter.settings["hunt_duo_loop_far_1"] = "hunt_initial";
  level.battlechatter.settings["hunt_duo_loop_far_2"] = "hunt_initial";
  level.battlechatter.settings["semtex_stuck"] = [0.9, 0.5, 10];
}

function private function_676ba319b8273e9e() {
  level.battlechatter.settings["investigate_loop"] = [0, 2, 5];
}

function private function_5430999882251a0c() {}

function bcs_waittill() {
  level endon("battlechatter disabled");

  while(true) {
    level waittill("bc_notify", data_array);

    foreach(data in data_array) {
      if(!isDefined(data.entity)) {
        continue;
      }

      assert(isDefined(data.category));

      if(getdvarint(@ "hash_350b154807f4d745")) {
        if(isDefined(data.subcategory) && data.category != data.subcategory) {
          text = data.category + "<dev string:x1c>" + data.subcategory;
        } else {
          text = data.category;
        }

        if(issharedfuncdefined("<dev string:x23>", "<dev string:x34>")) {
          data.entity thread[[getsharedfunc("<dev string:x23>", "<dev string:x34>")]]("<dev string:x4a>" + data.category, (0, 1, 0), 1, 0.5, (0, 0, 40), 5);
        }
      }

      notifyhandled = function_955ca8d297928838(data);

      if(!notifyhandled && chatterallowed(data.entity, 1, data.category)) {
        notifyhandled = function_6c731b5fab9c2494(data);
      }

      function_fdb8454d071bcf5b(data, notifyhandled);
    }
  }
}

function function_6c731b5fab9c2494(data) {
  assert(isDefined(data));
  assert(isDefined(data.entity));
  assert(isDefined(data.category));

  if(data.entity executeevent(data.category, data.params)) {
    return 1;
  }

  switch (data.category) {
    case #"hash_4c8ad9f2942ea5b":
      data.entity thread bcs_statechange(data);
      break;
    case #"hash_1044d327487d801a":
    case #"hash_184bba7053cc1c15":
    case #"hash_20cd76d83c2f7487":
      data.entity clear_cooldown("ally_movement");
      data.entity thread moveevent();
      break;
    case #"hash_d6c61718f24df768":
      data.entity thread targetmoveevent(data.otherentity, data.subcategory);
      break;
    case #"hash_5a5c93f2debb75c":
      data.entity thread initialcombatevent(data.params[1], data.params[2]);
      break;
    case #"hash_3ee703de5a8989c6":
      data.entity thread firstcombatevent();
      break;
    case #"hash_eeed4ce2a5de2aa5":
      if(data.subcategory == "losing_target") {
        data.entity thread function_e2d4e5c64d62278e(data.otherentity);
      } else if(data.subcategory == "lost_target") {
        data.entity function_93b4f17e4a3474b("lost_target", "ask_target_location");
      } else if(data.subcategory == "cease_fire") {
        data.entity function_93b4f17e4a3474b("cease_fire", "hunt_order_hold");
      } else if(data.subcategory == "lost_target_elapsed") {
        data.entity thread function_da9e3311b63335e1(data.otherentity);
      }

      break;
    case #"hash_37bb23543c319104":
      if(data.subcategory == "hunt") {
        data.entity thread function_facb9692c3fba174();
      }

      break;
    case #"hash_bb388ae078895394":
      data.entity thread function_7825e0643a6c5600();
      break;
    case #"hash_3f894d6ee31df868":
      if(data.subcategory == "combat_unaware") {
        data.entity function_93b4f17e4a3474b("combat_unaware", "hunt_reactions");
      }

      break;
    case #"hash_1fe1f9ada345556c":
      if(data.subcategory == "investigateposreached") {
        if(isDefined(data.params[2]) && data.params[2] == "saw_corpse") {
          return;
        }

        data.entity thread function_e46d9fd4c3250863();
      }

      break;
    case #"hash_1879579c479117e0":
      if(data.subcategory == "dodge_vehicle_start") {
        data.entity function_93b4f17e4a3474b("incoming_vehicle_response", random(["hunt_reactions", "cmb_reactions"]));
      }

      break;
    case #"hash_124fc72bb55490ec":
      data.entity thread reloadevent();
      break;
    case #"hash_ecb83a34dd571174":
      data.entity thread moveevent(data.subcategory);
      break;
    case #"hash_661532715a742ebf":
      data.entity thread friendlyfireevent();
      break;
    case #"hash_58018e5cda140b2d":
      data.entity thread function_e906749f6343f822();
      break;
    case #"hash_c718a89b94ffdc2":
      data.entity thread function_4dffa550c687b071();
      break;
    case #"hash_2d1406e602f0875d":
      data.entity thread attackevent();
      data.entity thread function_3aab8d98361f6ecf();
      break;
    case #"hash_ab2e692ee80521f8":
      data.entity thread burnevent(data.subcategory);
      break;
    case #"hash_8f9bb78729a54b2c":
    case #"hash_fbd5bcbb1cbe3154":
      data.entity thread function_a364b61121ab136f(data.otherentity);
      break;
    case #"hash_a0721fe4fd9580f5":
      data.entity thread shootevent(data.subcategory);
      break;
    case #"hash_57203b1e53d3a619":
      if(isalive(data.entity)) {
        data.entity function_93b4f17e4a3474b("wounded", "wounded");
      }

      break;
    case #"hash_7a09a268a01b5f84":
      data.entity thread function_71da86464a72718d();
      break;
    case #"hash_affe6c9db8e997d3":
      data.entity thread function_402ee78fe1df3ace();
      data.entity thread function_771bace1bff17684();
      break;
    case #"hash_278c7959b357bf3e":
      data.entity thread function_45eb140ec25c64a1();
      break;
    default:
      return 0;
  }

  return 1;
}

function function_955ca8d297928838(data) {
  assert(isDefined(data));
  assert(isDefined(data.entity));
  assert(isDefined(data.category));

  switch (data.category) {
    case #"hash_631f416c3d8360d4":
      data.entity thread useevent(data.subcategory, 0);
      break;
    case #"hash_12cb1aa4c57395":
      data.entity thread grenadedangerevent(data.otherentity);
      break;
    case #"hash_9a35360cb2dc98e6":
      data.entity thread useevent(data.subcategory, 1);
      break;
    default:
      return false;
  }

  return true;
}

function bcs_statechange(data) {
  previousstate = data.params[0];
  currentstate = data.params[1];
  ai_event = data.params[2];
  var_2a130b858db198cb = function_a07abd440b7a33fe(data.otherentity);

  if(previousstate == 4) {
    return;
  }

  if(previousstate == currentstate) {
    return;
  }

  self notify("bcs_stateChange", previousstate, currentstate);

  switch (currentstate) {
    case 0:
      return function_e64dbaaae396fbb8(previousstate);
    case 1:
      if(var_2a130b858db198cb) {
        return function_23a29830a84af4cf();
      } else {
        return enterinvestigateevent();
      }
    case 2:
      return function_f4671f61a3031990();
    case 3:
      function_65f8179711192d2b();

      if(previousstate <= 2) {
        self.var_ea9ad73c9a583d4c = gettime();
      }

      if(previousstate < 2) {
        if(var_2a130b858db198cb) {
          return function_64e63285a83e3efe();
        } else {
          return function_80bfded61c19c9cc(previousstate, ai_event);
        }
      } else {
        return entercombatevent();
      }

      break;
  }
}

function function_45a69522dd934d18(dist) {
  level.bcs_maxdist = 2048;
  level.bcs_maxdistsqrd = squared(level.bcs_maxdist);
}

function init_battlechatteroverrides(overrides) {
  level.battlechatteroverrides = overrides;
}

function function_2f7fd2639db2a57b() {
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

function bcs_setup_voice(voice, countryid, numvoices, var_790e7a69f5c40b30, combatmapid, stealthmapid) {
  if(!isDefined(var_790e7a69f5c40b30)) {
    var_790e7a69f5c40b30 = 0;
  }

  anim.usedids[voice] = [];

  for(i = 0; i < numvoices; i++) {
    anim.usedids[voice][i] = spawnStruct();
    anim.usedids[voice][i].count = 0;
    anim.usedids[voice][i].npcid = "" + i + 1;
  }

  anim.countryids[voice] = countryid;
  anim.var_6d557183af1d1db5[countryid] = combatmapid;
  anim.var_7f532a5dc6603698[countryid] = stealthmapid;
}

function function_2faee9e4cf862d61() {
  assert(!isDefined(anim.bcs_locations));
  triggers = getEntArray("trigger_multiple", "code_classname");
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
      players_processed = 0;

      for(p = 0; p < players.size; p++) {
        player = players[p];

        if(!isDefined(player) || !isalive(player) || !isDefined(player.origin)) {
          continue;
        }

        if(istrue(player.bcs_isprocessing)) {
          continue;
        }

        player thread function_f46983dffe232870();
        players_processed++;

        if(players_processed >= 5) {
          players_processed = 0;
          waitframe();
        }
      }
    }

    waitframe();
  }
}

function function_f46983dffe232870() {
  self endon("death_or_disconnect");
  self.bcs_isprocessing = 1;

  if(!istrue(self.bcs_init)) {
    thread bcs_initplayer();
    self.bcs_init = 1;
  }

  nearby_ai = getaiinrange(self.origin, level.var_8893859de4351996);
  nearby_ai = sortbydistance(nearby_ai, self.origin);
  count = min(nearby_ai.size, 10);

  for(i = 0; i < count; i++) {
    waitframe();
    count_ratio = (i + 1) / count;

    if(percent_chance((1 - count_ratio) * 15)) {
      continue;
    }

    guy = nearby_ai[i];

    if(!isalive(guy) || !isDefined(guy.battlechatter) || istrue(guy.battlechatter.executingloop)) {
      continue;
    }

    team = guy.team;
    origin = guy.origin;

    if(!isDefined(team) || !isDefined(origin)) {
      continue;
    }

    if(isDefined(guy.battlechatter.nextlooptime) && gettime() < guy.battlechatter.nextlooptime) {
      if(getdvarint(@ "hash_44ef18550505e010")) {
        print3d(origin + (0, 0, 80), "<dev string:x53>", (1, 1, 1), 1, 0.3, 1, 1);
      }

      continue;
    }

    state = guy getcombatstate();

    if(!isDefined(state) || !isDefined(guy.team)) {
      continue;
    }

    if(state == "dead" || guy.team == "neutral") {
      continue;
    }

    if(state == "combat" && guy function_8f59caa9212fcc56()) {
      continue;
    }

    if(getdvarint(@ "hash_44ef18550505e010")) {
      function_51c8ea07cf76cbd7("<dev string:x68>" + "<dev string:x71>" + state + "<dev string:x7f>" + "<dev string:x88>");
      print3d(origin + (0, 0, 100), "<dev string:x91>", (1, 1, 1), 1, 0.3, 20, 1);
    }

    guy thread executeloopstate(state);

    if(utility::issp()) {
      guy function_af3a6677d4327aae();
    } else {
      guy function_b145367392d5843d();
    }

    break;
  }

  self.bcs_isprocessing = 0;
}

function function_8f8de1d6f307f960(var_a434cd7944a162af) {
  return isDefined(var_a434cd7944a162af) && isstring(var_a434cd7944a162af) && function_5b7e9a4c946f3a13(var_a434cd7944a162af, ["frag_grenade", "semtex"]);
}

function bcs_initplayer() {
  self endon("death");
  self notify("bcs_initPlayer");
  self endon("bcs_initPlayer");
  childthread function_1d7ef730acb50079();
  childthread function_c3307723c588c6e5();
  childthread function_c47965a0917525b3();
}

function function_1d7ef730acb50079() {
  self endon("disconnect");

  while(true) {
    self waittill("weapon_fired", weapon);
    self.last_weapon_fired_time = gettime();
    self.last_weapon_fired = weapon;
  }
}

function function_c3307723c588c6e5() {
  while(true) {
    self waittill("grenade_fire", grenade);

    if(isDefined(grenade) && isDefined(grenade.weapon_object)) {
      bcs_subcategory = function_c666e714b2411844(grenade.weapon_object);

      if(isDefined(bcs_subcategory)) {
        addbattlechatternotify(self, undefined, "grenade_throw", bcs_subcategory);

        if(function_8f8de1d6f307f960(bcs_subcategory)) {
          addbattlechatternotify(self, grenade, "grenade_danger");
        }
      }
    }
  }
}

function function_c47965a0917525b3() {
  while(true) {
    self waittill("missile_fire", missile, objweapon);
    bcs_subcategory = function_c666e714b2411844(objweapon);

    if(isDefined(bcs_subcategory)) {
      addbattlechatternotify(self, undefined, "use", bcs_subcategory);
    }
  }
}

function function_8d7aee019b12c98f() {
  self endon("<dev string:x9e>");
  self.var_8d7aee019b12c98f = 1;

  while(isDefined(self.origin) && isDefined(level.players[0]) && isDefined(level.players[0].origin)) {
    print3d(self.origin + (0, 0, 60), floor(distance(level.players[0].origin, self.origin)), (1, 1, 1), 1, 0.5, 1, 1);
    waitframe();
  }

  self.var_8d7aee019b12c98f = undefined;
}

function function_af3a6677d4327aae(seconds, shoulddisablecombat) {
  if(!isDefined(seconds)) {
    seconds = function_42a6e01190025613(getcombatstate()) / 1000;
  }

  if(!isDefined(self.origin) || !isDefined(self.team)) {
    return function_b145367392d5843d(seconds, shoulddisablecombat);
  }

  foreach(ai in getaiinrange(self.origin, level.bcs_neardist, self.team)) {
    ai function_b145367392d5843d(seconds, shoulddisablecombat);
  }
}

function function_b145367392d5843d(seconds, shoulddisablecombat) {
  if(!isDefined(self.battlechatter)) {
    return;
  }

  if(!isDefined(seconds)) {
    delay_ms = function_42a6e01190025613(getcombatstate());
  } else {
    delay_ms = seconds * 1000;
  }

  self.battlechatter.nextlooptime = gettime() + delay_ms;

  if(istrue(shoulddisablecombat)) {
    self.battlechatter.var_3c94d4874d436201 = gettime() + delay_ms;
  }
}

function setchatterdelay(state, min_delay, max_delay) {
  assertex(isnumber(min_delay), "<dev string:xa7>");
  assertex(isnumber(max_delay), "<dev string:xc5>");
  assertex(min_delay <= max_delay, "<dev string:xe3>");
  level.battlechatter.delays[state] = [min_delay, max_delay];
}

function function_42a6e01190025613(state) {
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
    level.battlechatter.events[event_name] = create_deck();
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
    level.battlechatter.events[event_name] = create_deck();
  }

  index = level.battlechatter.events[event_name].items.size;
  level.battlechatter.events[event_name].items[index] = func;
}

function removeevent(event_name, var_d93390a0d7e03633) {
  if(!isDefined(level.battlechatter.events)) {
    return;
  }

  if(!isDefined(level.battlechatter.events[event_name])) {
    return;
  }

  new_items = [];

  foreach(index, var_4e26918d4dd88782 in level.battlechatter.events[event_name].items) {
    if(var_4e26918d4dd88782 == var_d93390a0d7e03633) {
      if(level.battlechatter.events[event_name].index > index) {
        level.battlechatter.events[event_name].index--;
      }

      continue;
    }

    new_items[new_items.size] = var_4e26918d4dd88782;
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

  event = level.battlechatter.events[event_name] deck_draw();

  if(isarray(params)) {
    params = array_removeundefined(params);
  }

  if(isfunction(event)) {
    thread call_with_params_script(event, params);
  } else {
    thread function_d54e84a9513b0e45(event_name, event.sequence, event.priority, event.timeout, event.cooldown, event.endons);
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

function function_2b3a4945ae9faf96() {
  return ["allies", "neutral"];
}

function function_d54e84a9513b0e45(var_c5dc0e000c5b1c69, sequence, priority, timeout, cooldown, endons) {
  chatter = createchatter(var_c5dc0e000c5b1c69, sequence, priority, timeout, cooldown, endons);
  return playchatter(chatter);
}

function function_93b4f17e4a3474b(var_c5dc0e000c5b1c69, sequence, var_7e4b3bd714b23bc7, endons) {
  if(!isDefined(var_7e4b3bd714b23bc7)) {
    var_7e4b3bd714b23bc7 = level.battlechatter.settings[var_c5dc0e000c5b1c69];
  }

  if(isstring(var_7e4b3bd714b23bc7)) {
    var_7e4b3bd714b23bc7 = level.battlechatter.settings[var_7e4b3bd714b23bc7];
  }

  if(!isDefined(var_7e4b3bd714b23bc7)) {
    iprintlnbold("<dev string:x118>" + var_c5dc0e000c5b1c69);

    return;
  }

  return function_d54e84a9513b0e45(var_c5dc0e000c5b1c69, sequence, var_7e4b3bd714b23bc7[0], var_7e4b3bd714b23bc7[1], var_7e4b3bd714b23bc7[2], endons);
}

function private playchatter(chatter) {
  retstruct = undefined;
  speaker = default_to(self.vo_parent, self);

  if(getdvarint(@ "hash_864d3ab12f741516") == 1 || getdvarint(@ "hash_864d3ab12f741516") == 2) {
    retstruct = spawnStruct();
  }

  if(!istrue(chatter.forced) && !speaker canchatter(undefined, undefined, retstruct)) {
    if(getdvarint(@ "hash_864d3ab12f741516") == 2) {
      function_51c8ea07cf76cbd7("<dev string:x136>" + default_to(chatter.name, "<dev string:x14c>") + "<dev string:x15b>" + function_55f43964ccdb5b95(speaker) + "<dev string:x15b>" + default_to(retstruct.text, "<dev string:x160>"));
    }

    chatter.finished_or_cancelled = 1;
    chatter notify("finished_or_cancelled");
    return 0;
  }

  if(isDefined(chatter.name) && !check_cooldown(chatter.name)) {
    if(getdvarint(@ "hash_864d3ab12f741516") == 2) {
      var_724d97199668ae7e = function_ea8354c6061a8b67(chatter.name);
      extra = "<dev string:x160>";

      if(var_724d97199668ae7e != chatter.name) {
        extra = "<dev string:x164>" + var_724d97199668ae7e;
      }

      function_51c8ea07cf76cbd7("<dev string:x177>" + chatter.name + "<dev string:x15b>" + function_55f43964ccdb5b95(speaker) + extra);
    }

    chatter.finished_or_cancelled = 1;
    chatter notify("finished_or_cancelled");
    return 0;
  }

  if(utility::issp()) {
    speaker function_af3a6677d4327aae();
  } else {
    speaker function_b145367392d5843d();
  }

  speaker set_cooldown(chatter.name, chatter.cooldown);
  level.battlechatter notify("chatter_added", chatter);
  chatter thread function_ac907769b9d391cb();
  return chatter;
}

function function_b9cc4ff760926456(name, sequence, priority, timeout, cooldown, endons) {
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

  if(!istrue(chatter.finished_or_cancelled)) {
    chatter waittill("finished_or_cancelled");
  }

  if(isDefined(chatter.finished)) {
    return chatter.finished;
  }
}

function function_ac907769b9d391cb() {
  self.finished = 0;
  self.finished_or_cancelled = 0;
  self.speaker.var_44e1869b50a57309 = self.scope;
  self.speaker notify("started_queue_wait", self);
  cancelled = self.scope_ents[self.scope] function_f2a79001721945a(self, self.timeout, self.endons);
  self.speaker notify("finished_queue_wait", self, cancelled);

  if(!istrue(cancelled) && (istrue(self.forced) || default_to(self.speaker.vo_parent, self.speaker) canchatter())) {
    level.battlechatter notify("chatter_started", self);
    self.speaker.var_ec9f57e7698baffb = self.priority;

    foreach(ent in self.scope_ents) {
      ent function_797820cad48747ef(self);
    }

    self notify("proceeded");

    while(isDefined(self.finished) && !self.finished) {
      self.finished = function_a9c351ded2cf6ce4();
    }

    if(is_dead_or_dying(self.speaker)) {
      self.speaker stop_dialogue();

      if(isDefined(self.var_b1cc80f4b3875f46)) {
        self.listener function_93b4f17e4a3474b(self.name + "_interrupt", self.var_b1cc80f4b3875f46, level.battlechatter.settings["_interrupt"]);
      }
    }

    if(istrue(self.finished)) {
      if(self.name == "idle_convo" || self.name == "idle") {
        self.speaker set_cooldown(self.name, level.var_dafa42d7384e9ef5);
      } else {
        self.speaker set_cooldown(self.name, self.cooldown);
      }
    }

    foreach(ent in self.scope_ents) {
      ent remove_vo_data(self);
    }
  } else {
    self notify("proceeded");

    if(getdvarint(@ "hash_864d3ab12f741516") == 2 && self.speaker canchatter()) {
      function_51c8ea07cf76cbd7("<dev string:x18b>" + default_to(self.name, "<dev string:x14c>") + "<dev string:x15b>" + function_55f43964ccdb5b95(self.speaker));
    } else if(getdvarint(@ "hash_864d3ab12f741516") == 2) {
      function_51c8ea07cf76cbd7("<dev string:x19e>" + default_to(self.name, "<dev string:x14c>") + "<dev string:x15b>" + function_55f43964ccdb5b95(self.speaker));
    }
  }

  function_ab8711048f02259d(self.scope_ents);
  self.speaker notify("chatter_finished_or_cancelled", self);
  level.battlechatter notify("chatter_finished_or_cancelled", self);
  self.finished_or_cancelled = 1;
  self notify("finished_or_cancelled");
}

function function_a9c351ded2cf6ce4() {
  dead_or_dying = is_dead_or_dying(self.speaker);
  in_takedown = self.speaker function_73eca19eaeb08e4d();

  if(dead_or_dying || in_takedown) {
    if(isDefined(self.var_b1cc80f4b3875f46)) {
      switchspeaker();
      self.sequence = self.var_b1cc80f4b3875f46;
      self.index = 0;
      self.var_b1cc80f4b3875f46 = undefined;
    } else {
      if(getdvarint(@ "hash_864d3ab12f741516")) {
        if(dead_or_dying) {
          function_51c8ea07cf76cbd7("<dev string:x1bf>" + default_to(self.name, "<dev string:x14c>") + "<dev string:x15b>" + function_600b37e8cf3f2de9(self.speaker));
          return;
        }

        function_51c8ea07cf76cbd7("<dev string:x1d5>" + default_to(self.name, "<dev string:x14c>") + "<dev string:x15b>" + function_600b37e8cf3f2de9(self.speaker));
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

  if(!isDefined(self.sequence) || !isDefined(self.index)) {
    if(getdvarint(@ "hash_864d3ab12f741516")) {
      function_51c8ea07cf76cbd7("<dev string:x1f2>" + default_to(self.name, "<dev string:x14c>"));
    }

    return;
  }

  vo_queue = level.vo_teams[self.speaker.team].vo_queue;

  if(vo_queue.size > 0 && vo_queue[0].priority > self.priority) {
    if(getdvarint(@ "hash_864d3ab12f741516")) {
      function_51c8ea07cf76cbd7("<dev string:x214>" + default_to(self.name, "<dev string:x14c>") + "<dev string:x22a>" + self.priority + "<dev string:x22f>" + default_to(vo_queue[0].name, "<dev string:x14c>") + "<dev string:x22a>" + vo_queue[0].priority);
    }

    return;
  }

  if(self.index >= self.sequence.size) {
    return 1;
  }

  self.alias = undefined;

  if(utility::issp()) {
    self.speaker function_af3a6677d4327aae();
  } else {
    self.speaker function_b145367392d5843d();
  }

  segment = self.sequence[self.index];
  self.index++;

  if(isstring(segment)) {
    self.alias = constructalias(segment);

    self.sequence[self.index - 1] = self.alias;

    if(!soundexists(self.alias)) {
      if(istrue(self.var_b7b89212841eaa3f)) {
        self.var_b7b89212841eaa3f = undefined;
        return 0;
      }

      if(getdvarint(@ "hash_864d3ab12f741516")) {
        if(!isDefined(self.speaker.battlechatter.countryid)) {
          function_51c8ea07cf76cbd7("<dev string:x236>" + default_to(self.name, "<dev string:x14c>") + "<dev string:x24a>" + self.speaker getentitynumber() + "<dev string:x253>" + default_to(anim.countryids[self.speaker.voice], "<dev string:x160>") + "<dev string:x26b>" + default_to(self.speaker.voice, "<dev string:x160>"));
          return;
        }

        if(self.alias == "<dev string:x160>") {
          function_51c8ea07cf76cbd7("<dev string:x275>" + default_to(self.name, "<dev string:x14c>") + "<dev string:x294>" + self.speaker.battlechatter.countryid + "<dev string:x29b>" + segment + "<dev string:x2a1>");
          return;
        }

        function_51c8ea07cf76cbd7("<dev string:x2a6>" + default_to(self.name, "<dev string:x14c>") + "<dev string:x2c0>" + self.alias + "<dev string:x2c7>" + "<dev string:x2d2>" + self.speaker.battlechatter.countryid + "<dev string:x29b>" + segment + "<dev string:x2a1>");
      }

      return;
    }

    if(getdvarint(@ "hash_864d3ab12f741516") == 1 || getdvarint(@ "hash_864d3ab12f741516") == 2) {
      retstruct = spawnStruct();
    }

    if(!istrue(self.forced) && !default_to(self.speaker.vo_parent, self.speaker) canchatter(undefined, undefined, retstruct)) {
      if(getdvarint(@ "hash_864d3ab12f741516")) {
        function_51c8ea07cf76cbd7("<dev string:x2d7>" + default_to(self.name, "<dev string:x14c>") + "<dev string:x15b>" + function_55f43964ccdb5b95(default_to(self.speaker.vo_parent, self.speaker)) + "<dev string:x15b>" + default_to(retstruct.text));
      }

      return;
    }

    if(!has_priority(self.scope_ents[self.scope].vo_active, 1)) {
      if(getdvarint(@ "hash_864d3ab12f741516")) {
        function_51c8ea07cf76cbd7("<dev string:x2f1>" + default_to(self.name, "<dev string:x14c>"));
      }

      return;
    }

    if(getdvarint(@ "hash_864d3ab12f741516") && !istrue(self.var_589023656a9e531)) {
      self.var_589023656a9e531 = 1;
      function_51c8ea07cf76cbd7("<dev string:x308>" + default_to(self.name, "<dev string:x14c>") + "<dev string:x15b>" + function_55f43964ccdb5b95(self.owner));
    }

    finished = self.speaker say_dialogue(self.alias, self.overlap, self.scope_ents[self.scope], self.receivers);

    if(!istrue(finished)) {
      if(getdvarint(@ "hash_864d3ab12f741516")) {
        function_51c8ea07cf76cbd7("<dev string:x316>" + default_to(self.name, "<dev string:x14c>"));
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
      if(getdvarint(@ "hash_864d3ab12f741516")) {
        function_51c8ea07cf76cbd7("<dev string:x32f>" + default_to(self.name, "<dev string:x14c>"));
      }

      return;
    } else {
      return 0;
    }
  } else if(isfunction(segment)) {
    result = self[[segment]]();

    if(isDefined(result)) {
      if(isint(result) && result == 0) {
        if(getdvarint(@ "hash_864d3ab12f741516")) {
          function_51c8ea07cf76cbd7("<dev string:x34d>" + default_to(self.name, "<dev string:x14c>") + "<dev string:x36a>" + self.index - 1 + "<dev string:x2a1>");
        }

        return;
      }

      if(isarray(result)) {
        self.sequence = function_ef4b3df86351aa00(self.sequence, result, self.index);
      } else {
        self.sequence = array_insert(self.sequence, result, self.index);
      }
    }

    return 0;
  } else if(isarray(segment)) {
    self.sequence = function_ef4b3df86351aa00(self.sequence, segment, self.index);
    return 0;
  }

  if(getdvarint(@ "hash_864d3ab12f741516")) {
    function_51c8ea07cf76cbd7("<dev string:x377>" + self.index + "<dev string:x394>" + default_to(self.name, "<dev string:x14c>"));
  }
}

function function_51c8ea07cf76cbd7(text, var_73a14d94e40a8d15) {
  if(isDefined(var_73a14d94e40a8d15)) {
    var_73a14d94e40a8d15.text = text;
    return;
  }

  scripts\common\debug::function_7320cd1e4f724899(text);
  println(text);
}

function function_a8c755adb8698257() {
  level endon("<dev string:x3a2>");
  player = undefined;

  for(;;) {
    if(!getdvarint(@ "hash_864d3ab12f741516") || !isDefined(level.battlechatter) || !isDefined(level.vo_active)) {} else {
      vid_width = getdvarint(@ "hash_b7c9a158890bce5a", 1920);
      vid_height = getdvarint(@ "hash_9139b4ad2f235c95", 1080);
      var_39c991ead8822d9b = getdvarint(@ "hash_b7c9a158890bce5a") / 1920;
      var_3f109f5aaf427a = getdvarint(@ "hash_9139b4ad2f235c95") / 1080;
      setdvarifuninitialized(@ "hash_91d2bfdbf8875369", 350);
      setdvarifuninitialized(@ "hash_91d2bedbf8875136", 250);
      setdvarifuninitialized(@ "hash_4fd3148b1459a83", 0.8);
      base_x = getdvarint(@ "hash_91d2bfdbf8875369") * var_39c991ead8822d9b;
      base_y = getdvarint(@ "hash_91d2bedbf8875136") * var_3f109f5aaf427a;
      base_scale = getdvarfloat(@ "hash_4fd3148b1459a83") * var_3f109f5aaf427a;
      ln_height = 0;

      for(k = 0; k < level.vo_active.size; k++) {
        if(!istrue(level.vo_active[k].ischatter)) {
          continue;
        }

        chatter = level.vo_active[k];
        sequence = chatter.sequence;

        if(isDefined(chatter.name)) {
          speaker = default_to(chatter.speaker.vo_parent, chatter.speaker);

          if(isstruct(chatter.speaker) && isDefined(chatter.speaker.vo_parent)) {
            speaker_text = "<dev string:x3bc>" + speaker getentitynumber() + "<dev string:x3c2>";
          } else if(isstruct(chatter.speaker)) {
            speaker_text = "<dev string:x3bc>" + "<dev string:x3cc>" + "<dev string:x3c2>";
          } else {
            speaker_text = "<dev string:x3bc>" + speaker getentitynumber();
          }

          event_info = "<dev string:x3d4>" + speaker_text + "<dev string:x3db>" + chatter.name + "<dev string:x3e1>";

          if(!isDefined(speaker.team)) {
            color = (1, 1, 1);
          } else {
            color = ter_op(speaker.team == "<dev string:x3e8>", (0.1, 0.9, 0.1), (1, 0.2, 0.2));
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
            var_796003daa202b1f3 = player screenpostoworldpoint((cam_x, cam_y, 0), 65, 5, 1);
            line(speaker.origin, var_796003daa202b1f3, color);
            debugstar(speaker.origin, color, 1, speaker_text);
          }

          ln_height += 30 * base_scale;
        }

        for(i = 0; i < sequence.size; i++) {
          display_ln = undefined;
          segment = sequence[i];

          if(isstring(segment)) {
            if(!isstartstr(segment, "<dev string:x3f2>")) {
              alias = segment;
            } else {
              alias = chatter constructalias(segment);
              alias = getsubstr(alias, 6, alias.size);
            }

            display_ln = "<dev string:x3f9>" + ter_op(isDefined(alias), alias, segment);
          } else if(isnumber(segment)) {
            display_ln = "<dev string:x402>" + segment + "<dev string:x40c>";
          } else if(isent(segment)) {
            ent_num = "<dev string:x3bc>" + segment getentitynumber();
            display_ln = "<dev string:x414>";

            if(isDefined(segment.animname)) {
              display_ln += segment.animname + "<dev string:x42b>" + ent_num + "<dev string:x431>";
            } else {
              display_ln += ent_num;
            }
          } else if(isstruct(segment) && isDefined(segment.vo_parent)) {
            ent_num = "<dev string:x3bc>" + segment.vo_parent getentitynumber();
            display_ln = "<dev string:x414>";

            if(isDefined(segment.vo_parent.animname)) {
              display_ln += segment.vo_parent.animname + "<dev string:x436>" + ent_num + "<dev string:x431>";
            } else {
              display_ln += ent_num + "<dev string:x444>";
            }
          } else if(isfunction(segment)) {
            display_ln = "<dev string:x450>";
          }

          if(isDefined(display_ln)) {
            is_index = i == chatter.index - 1;
            color = ter_op(is_index, (1, 1, 0), (1, 1, 1));
            space = ter_op(is_index, 32, 25) * base_scale;
            scale = ter_op(is_index, 1.85, 1.5) * base_scale;
            printtoscreen2d(base_x + 2, base_y + 2 + ln_height + is_index * 10 * base_scale, display_ln, (0, 0, 0), scale);
            printtoscreen2d(base_x + 2, base_y + 2 + ln_height + is_index * 10 * base_scale, display_ln, (0, 0, 0), scale);
            printtoscreen2d(base_x, base_y + ln_height + is_index * 10 * base_scale, display_ln, color, scale);
            ln_height += space;
          }
        }

        if(k < level.vo_active.size - 1) {
          printtoscreen2d(base_x, base_y + ln_height, "<dev string:x461>", (1, 1, 1), 1.5 * base_scale);
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
  chatter.scope = default_to(level.battlechatter.scope, "team");
  chatter.owner = self;
  chatter.speaker = self;
  chatter.scope_ents = function_28e38eefd3cc4ab();
  chatter.ischatter = 1;

  if(!isarray(sequence)) {
    sequence = [sequence];
  }

  chatter.index = 0;
  chatter.sequence = sequence;
  chatter.forced = isDefined(level.battlechatter) && isDefined(self.battlechatter) && istrue(self.battlechatter.friendlyfire_force) && name == "friendlyfire";
  chatter.priority = default_to(priority, 0);
  chatter.timeout = default_to(timeout, 1);
  chatter.cooldown = default_to(cooldown, 0);
  chatter.endons = default_to(endons, []);
  chatter.overlap = 1;

  if(!isarray(chatter.endons)) {
    chatter.endons = [chatter.endons];
  }

  return chatter;
}

function function_a4ba1099ac49c74(sequence) {
  foreach(segment in sequence) {
    if(isarray(segment)) {
      result = function_a4ba1099ac49c74(segment);

      if(isDefined(result)) {
        return result;
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
      result = getfirststring(segment);

      if(isDefined(result)) {
        return result;
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
    event_string = self.speaker event_lookup(event_string);
  }

  if(!isDefined(event_string)) {
    return "";
  }

  if(isstartstr(event_string, "dx_")) {
    return event_string;
  }

  if(!isDefined(self.speaker) || !isDefined(self.speaker.battlechatter)) {
    return "";
  }

  segs = strtok(event_string, "_");
  char = default_to(function_8af9f89d6344a3df(self.speaker), "");
  countryid = default_to(self.speaker.battlechatter.countryid, "");

  if(isDefined(self.speaker.battlechatter.countryidoverride)) {
    countryid = self.speaker.battlechatter.countryidoverride;
  }

  if(segs.size > 2) {
    if(isDefined(countryid)) {
      if(segs[0] == "s") {
        segs[0] = anim.var_7f532a5dc6603698[countryid];
      } else {
        segs[0] = anim.var_6d557183af1d1db5[countryid];
      }
    }

    if(!isDefined(countryid) || !isDefined(segs[0])) {
      if(isstartstr(event_string, "c")) {
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
      if(istrue(self.speaker.battlechatter.isleader)) {
        return ("dx_guid" + segs[0]);
      } else {
        return ("dx_guid" + segs[0] + "_" + char);
      }
    default:
      assertmsg("<dev string:x486>" + event_string + "<dev string:x4a7>");
      break;
  }
}

function lookupchatter(event_string) {
  if(!isDefined(level.battlechatter.event_decks)) {
    createeventdecks();
  }

  if(isDefined(level.battlechatter.event_decks[event_string])) {
    return level.battlechatter.event_decks[event_string] deck_draw();
  }

  return event_string;
}

function createeventdecks() {
  level.battlechatter.event_decks = [];
}

function function_8af9f89d6344a3df(speaker) {
  if(isDefined(speaker.battlechatter.charoverride)) {
    return tolower(speaker.battlechatter.charoverride);
  }

  npcid = default_to(speaker.battlechatter.npcid, "");

  if(npcid.size == 4) {
    return tolower(npcid);
  }

  countryid = default_to(speaker.battlechatter.countryid, "");

  if(isDefined(speaker.battlechatter.countryidoverride)) {
    countryid = speaker.battlechatter.countryidoverride;
  }

  if(countryid == "RU") {
    return tolower(countryid + "0" + npcid);
  }

  return tolower(countryid + npcid);
}

function getmodeprefix(type) {
  type = default_to(type, "stealth");

  switch (type) {
    case #"hash_3d5f49f17b95335c":
      otn = getDvar(@ "hash_495535a4877b324d") != "off";
      return ter_op(otn, "otn_", "cst_");
    case #"hash_44e999799ff10fce":
      return "vom_";
    default:
      otn = getDvar(@ "hash_87dca5163728ce02") != "off";
      return ter_op(otn, "otn_", "cbc_");
  }
}

function getgamemode() {
  if(isDefined(level.gamemode)) {
    return level.gamemode;
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
    case #"hash_1a50316c17b5a73b":
      level.gamemode = "cp";
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
    var_2dab9fb88c214a2e = isDefined(trigger.islandmark) && level.player istouching(trigger);

    if(var_2dab9fb88c214a2e || !isDefined(trigger.location)) {
      continue;
    }

    locations[locations.size] = trigger.location;
  }

  return random(locations);
}

function chatterallowed(guy, do_debug, var_5499de48ce486044) {
  if(!isDefined(level.battlechatter) || !isDefined(guy.battlechatter)) {
    if(istrue(do_debug) && getdvarint(@ "hash_864d3ab12f741516") >= 2) {
      function_51c8ea07cf76cbd7("<dev string:x136>" + default_to(var_5499de48ce486044, "<dev string:x14c>") + "<dev string:x15b>" + function_55f43964ccdb5b95(guy) + "<dev string:x4ac>");
    }

    return false;
  }

  if(istrue(level.battlechatterdisabled)) {
    if(istrue(do_debug) && getdvarint(@ "hash_864d3ab12f741516") >= 2) {
      function_51c8ea07cf76cbd7("<dev string:x136>" + default_to(var_5499de48ce486044, "<dev string:x14c>") + "<dev string:x15b>" + function_55f43964ccdb5b95(guy) + "<dev string:x4e4>");
    }

    return false;
  }

  if(!istrue(guy.battlechatterallowed)) {
    if(istrue(do_debug) && getdvarint(@ "hash_864d3ab12f741516") >= 2) {
      function_51c8ea07cf76cbd7("<dev string:x136>" + default_to(var_5499de48ce486044, "<dev string:x14c>") + "<dev string:x15b>" + function_55f43964ccdb5b95(guy) + "<dev string:x50b>");
    }

    return false;
  }

  if(isDefined(level.battlechatterdisabledteams)) {
    team = default_to(guy.team, "");

    if(istrue(level.battlechatterdisabledteams[team])) {
      if(istrue(do_debug) && getdvarint(@ "hash_864d3ab12f741516") >= 2) {
        function_51c8ea07cf76cbd7("<dev string:x136>" + default_to(var_5499de48ce486044, "<dev string:x14c>") + "<dev string:x15b>" + function_55f43964ccdb5b95(guy) + "<dev string:x530>" + team + "<dev string:x555>");
      }

      return false;
    }
  }

  return true;
}

function function_73eca19eaeb08e4d() {
  if(!isDefined(self)) {
    return 0;
  }

  if(isai(self)) {
    if(issharedfuncdefined("executions", "is_in_takedown")) {
      return self[[getsharedfunc("executions", "is_in_takedown")]]();
    }
  }

  return 0;
}

function canchatter(requiredstate, sighttarget, var_73a14d94e40a8d15, lastsighttime) {
  if(is_dead_or_dying(self) || !isDefined(self.team) || !isDefined(self.origin) || !chatterallowed(self)) {
    if(getdvarint(@ "hash_864d3ab12f741516") == 3 || isDefined(var_73a14d94e40a8d15)) {
      function_51c8ea07cf76cbd7("<dev string:x563>", var_73a14d94e40a8d15);
    }

    return false;
  }

  if(function_73eca19eaeb08e4d()) {
    if(getdvarint(@ "hash_864d3ab12f741516") == 3 || isDefined(var_73a14d94e40a8d15)) {
      function_51c8ea07cf76cbd7("<dev string:x592>", var_73a14d94e40a8d15);
    }
  }

  if(isDefined(requiredstate) && getcombatstate() != requiredstate) {
    if(getdvarint(@ "hash_864d3ab12f741516") == 3 || isDefined(var_73a14d94e40a8d15)) {
      function_51c8ea07cf76cbd7("<dev string:x5a1>", var_73a14d94e40a8d15);
    }

    return false;
  }

  if(isDefined(sighttarget)) {
    lastsighttime = default_to(lastsighttime, 2);

    if(!self seerecently(sighttarget, lastsighttime)) {
      if(getdvarint(@ "hash_864d3ab12f741516") == 3 || isDefined(var_73a14d94e40a8d15)) {
        function_51c8ea07cf76cbd7("<dev string:x5d2>", var_73a14d94e40a8d15);
      }

      return false;
    }
  }

  if(istrue(self.in_melee_death)) {
    if(getdvarint(@ "hash_864d3ab12f741516") == 3 || isDefined(var_73a14d94e40a8d15)) {
      function_51c8ea07cf76cbd7("<dev string:x5fa>", var_73a14d94e40a8d15);
    }

    return false;
  }

  if(istrue(self._animactive) && !istrue(self.battlechatter.allowanimactive)) {
    if(getdvarint(@ "hash_864d3ab12f741516") == 3 || isDefined(var_73a14d94e40a8d15)) {
      function_51c8ea07cf76cbd7("<dev string:x60c>", var_73a14d94e40a8d15);
    }

    return false;
  }

  if(isPlayer(self)) {
    return true;
  }

  if(!getplayersinrange(self.origin, level.bcs_fardist).size > 0) {
    if(isDefined(var_73a14d94e40a8d15)) {
      function_51c8ea07cf76cbd7("<dev string:x61e>", var_73a14d94e40a8d15);
    }

    return false;
  }

  return true;
}

function bc_prefix(type) {
  return "dx_" + getmodeprefix(type) + function_8af9f89d6344a3df(self) + "_";
}

function private function_ea8354c6061a8b67(chatter_name) {
  chatter_settings = level.battlechatter.settings[chatter_name];

  if(isDefined(chatter_settings) && isstring(chatter_settings)) {
    return chatter_settings;
  }

  return chatter_name;
}

function check_cooldown(name, players) {
  name = function_ea8354c6061a8b67(name);

  if(!isDefined(players)) {
    if(utility::issp()) {
      players = [level.player];
    } else {
      players = getplayersinrange(self.origin, level.bcs_fardist);
    }
  }

  foreach(player in players) {
    if(!isDefined(player.bcs_cooldowns) || !isDefined(player.bcs_cooldowns[self.team])) {
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

function function_161bd3732c0afbce(name, duration, players) {
  name = function_ea8354c6061a8b67(name);

  if(!check_cooldown(name, players)) {
    return false;
  }

  set_cooldown(name, duration, players);
  return true;
}

function set_cooldown(name, duration, players) {
  if(!isDefined(name) || !isDefined(duration) || !isDefined(self.origin)) {
    return;
  }

  name = function_ea8354c6061a8b67(name);

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
      player.bcs_cooldowns[self.team] = function_ab7df904aa60d433(player.bcs_cooldowns[self.team], 5);
    }
  }
}

function clear_cooldown(name) {
  if(!isDefined(name) || !isDefined(self.origin)) {
    return;
  }

  name = function_ea8354c6061a8b67(name);

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
    new_speaker = function_132875639c660348();
  }

  if(isint(new_speaker) && new_speaker == 0) {
    return 0;
  }

  foreach(ent in self.scope_ents) {
    ent remove_vo_data(self);
  }

  self.listener = self.speaker;
  self.speaker = new_speaker;
  self.speaker.var_ec9f57e7698baffb = self.priority;
  self.scope_ents = self.speaker function_28e38eefd3cc4ab();

  foreach(ent in self.scope_ents) {
    ent function_797820cad48747ef(self);
  }
}

function function_132875639c660348() {
  newspeaker = self.speaker function_d8c3c539bc71c7af();

  if(isDefined(newspeaker)) {
    return newspeaker;
  }

  return 0;
}

function function_12014207b3e66976() {
  newspeaker = self.speaker getclosestfriendlyspeaker();

  if(isDefined(newspeaker)) {
    return newspeaker;
  }

  return 0;
}

function function_2a9c2c2765055f10() {
  newspeaker = self.speaker function_6b500fae7c3e61da();

  if(isDefined(newspeaker)) {
    return newspeaker;
  }

  return 0;
}

function function_ce07522e02781160() {
  newspeaker = function_573b9ff9ed152518(self.speaker);

  if(isDefined(newspeaker)) {
    return newspeaker;
  }

  return 0;
}

function function_afd322664ba54fa7() {
  newspeaker = function_592f13f1a0e078ff(self.speaker);

  if(isDefined(newspeaker)) {
    return newspeaker;
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

function function_401ec0642c92d2eb() {
  return ter_op(self.team == "axis" || self.team == "team3", "allies", "bad_guys");
}

function function_6e80d82709faefd() {
  npcid = undefined;

  if(isDefined(self.battlechatter)) {
    npcid = self.battlechatter.npcid;
  }

  new_speaker = function_248a7374a1a0605a(self.origin, getsubordinates(), npcid);

  if(!isDefined(new_speaker)) {
    new_speaker = getclosestfriendlyspeaker(self.team);
  }

  return new_speaker;
}

function function_a271b08319ea86ae() {
  npcid = undefined;

  if(isDefined(self.battlechatter)) {
    npcid = self.battlechatter.npcid;
  }

  new_speaker = function_248a7374a1a0605a(self.origin, getsuperiors(), npcid);

  if(!isDefined(new_speaker)) {
    new_speaker = getclosestfriendlyspeaker(self.team);
  }

  return new_speaker;
}

function function_6b500fae7c3e61da() {
  npcid = undefined;

  if(isDefined(self.battlechatter)) {
    npcid = self.battlechatter.npcid;
  }

  new_speaker = function_b1ab02cfbfd12e43(getsubordinates(), npcid);

  if(!isDefined(new_speaker)) {
    new_speaker = function_d8c3c539bc71c7af(self.team);
  }

  return new_speaker;
}

function function_e5e9db75fe72e36f() {
  npcid = undefined;

  if(isDefined(self.battlechatter)) {
    npcid = self.battlechatter.npcid;
  }

  new_speaker = function_b1ab02cfbfd12e43(getsuperiors(), npcid);

  if(!isDefined(new_speaker)) {
    new_speaker = function_d8c3c539bc71c7af(self.team);
  }

  return new_speaker;
}

function getclosestfriendlyspeaker(team, requiredstate, requiresight, maxdist) {
  team = default_to(team, self.team);
  maxdist = default_to(maxdist, level.bcs_neardist);

  if(!isDefined(team) || team == "dead") {
    return;
  }

  if(!isDefined(self.origin)) {
    return;
  }

  npcid = undefined;

  if(isDefined(self.battlechatter) && isDefined(self.battlechatter.npcid)) {
    npcid = self.battlechatter.npcid;
  }

  return function_248a7374a1a0605a(self.origin, getaiinrange(self.origin, maxdist, team), npcid, requiredstate, requiresight);
}

function getclosestenemyspeaker(team, requiredstate, requiresight, maxdist) {
  if(!isDefined(self.enemy) || !isDefined(self.enemy.team)) {
    return;
  }

  team = default_to(team, self.enemy.team);
  maxdist = default_to(maxdist, level.bcs_neardist);
  return function_248a7374a1a0605a(self.origin, getaiinrange(self.origin, maxdist, team), undefined, requiredstate, requiresight);
}

function function_d8c3c539bc71c7af(team, requiredstate, requiresight, maxdist) {
  team = default_to(team, self.team);
  maxdist = default_to(maxdist, level.bcs_neardist);
  npcid = undefined;

  if(isDefined(self.battlechatter)) {
    npcid = self.battlechatter.npcid;
  }

  return function_b1ab02cfbfd12e43(getaiinrange(self.origin, maxdist, team), npcid, requiredstate, requiresight);
}

function function_8db2aa6f0377958(team, requiredstate, requiresight, maxdist, lastsighttime) {
  if(!isDefined(self.enemy) || !isDefined(self.enemy.team)) {
    return;
  }

  team = default_to(team, self.enemy.team);
  maxdist = default_to(maxdist, level.bcs_neardist);
  return function_b1ab02cfbfd12e43(getaiinrange(self.origin, maxdist, team), undefined, requiredstate, requiresight, lastsighttime);
}

function function_248a7374a1a0605a(origin, possible_speakers, excludeid, requiredstate, requiresight) {
  closest_distsq = undefined;
  closest_guy = undefined;
  sighttarget = undefined;

  if(istrue(requiresight)) {
    sighttarget = self;
  }

  foreach(guy in possible_speakers) {
    if(issentient(self) && guy == self) {
      continue;
    }

    if(guy function_754c9897f3b89964() || !guy canchatter(requiredstate, sighttarget) || is_equal(guy.battlechatter.npcid, excludeid)) {
      continue;
    }

    if(isDefined(guy.battlechatter) && istrue(guy.battlechatter.ishero)) {
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

function function_b1ab02cfbfd12e43(possible_speakers, excludeid, requiredstate, requiresight, lastsighttime) {
  best_guy = undefined;
  sighttarget = undefined;

  if(istrue(requiresight)) {
    sighttarget = self;
  }

  isselfsentient = isDefined(self) && issentient(self);

  foreach(guy in possible_speakers) {
    if(isselfsentient && guy == self) {
      continue;
    }

    if(1 && isDefined(guy._blackboard) && isDefined(guy._blackboard.currentvehicle)) {
      continue;
    }

    if(guy function_754c9897f3b89964() || !guy canchatter(requiredstate, sighttarget, undefined, lastsighttime)) {
      continue;
    }

    if(isDefined(guy.battlechatter) && is_equal(guy.battlechatter.npcid, excludeid)) {
      continue;
    }

    if(!isDefined(guy.var_e5cf232129f9ec01)) {
      return guy;
    }

    if(!isDefined(best_guy) || guy.var_e5cf232129f9ec01 < best_guy.var_e5cf232129f9ec01) {
      best_guy = guy;
    }
  }

  return best_guy;
}

function getspeakers(team) {
  team = default_to(team, self.team);
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

  if(isDefined(level.var_c3d9ceba74248998)) {
    return [[level.var_c3d9ceba74248998]](origin, radius);
  }

  return [];
}

function getaiinrange(origin, radius, team) {
  if(isDefined(level.var_1da0697a602f5a04)) {
    return [[level.var_1da0697a602f5a04]](origin, radius, team);
  }

  if(isDefined(team)) {
    return getaiarrayinradius(origin, radius, team);
  }

  return getaiarrayinradius(origin, radius);
}

function getenemiesinrange(radius) {
  if(!isDefined(self.enemy) || !isDefined(self.enemy.origin) || !isDefined(self.enemy.team)) {
    return [];
  }

  radius = default_to(radius, level.bcs_maxdist);
  enemies = getaiinrange(self.enemy.origin, radius, self.enemy.team);

  if(isDefined(self.team) && self.team != "allies" && self.team != "neutral") {
    players = getplayersinrange(self.enemy.origin, radius);
    enemies = array_combine(enemies, players);
  }

  return enemies;
}

function function_74b5af7f20c85724(origin, radius, my_team) {
  enemiesinrange = [];

  if(isDefined(my_team) && isDefined(origin)) {
    radius = default_to(radius, level.bcs_maxdist);
    aiinrange = getaiinrange(origin, radius);

    if(isDefined(aiinrange)) {
      foreach(ai in aiinrange) {
        if(!isDefined(ai)) {
          continue;
        }

        if(isDefined(ai.team) && ai.team == my_team) {
          continue;
        }

        enemiesinrange = array_add(enemiesinrange, ai);
      }
    }
  }

  return enemiesinrange;
}

function isnear(target, radius) {
  return distancesquared(target.origin, self.origin) < squared(radius);
}

function function_cd250b4591e6bc01(var_595b006b359c3dde, var_3ab040f5cfcefbbb) {
  if(isDefined(self.voice) && self hasfemalevoice()) {
    return var_3ab040f5cfcefbbb;
  }

  return var_595b006b359c3dde;
}

function function_1609ef297b7a32cf(enemy, var_646a5cd9726e8b01, var_8b254bbef9b6b110, enemies) {
  if(isDefined(self.battlechatter) && is_equal(enemy, self.battlechatter.target)) {
    return var_646a5cd9726e8b01;
  }

  if(!ismp() && !isDefined(enemies)) {
    enemies = getenemiesinrange();
  }

  if(!ismp() && enemies.size > 1) {
    return var_8b254bbef9b6b110;
  }

  return var_646a5cd9726e8b01;
}

function set_target(target) {
  guy = self;

  if(istrue(self.ischatter)) {
    guy = self.speaker;
  }

  target = default_to(target, guy.enemy);
  guy function_11bcc851afaf707(target);
}

function clear_target() {
  function_11bcc851afaf707(undefined);
}

function function_11bcc851afaf707(target) {
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

function function_d6731c6d074dc7d0(params) {
  thread function_87ee4a2ecd6546fc();
}

function function_87ee4a2ecd6546fc() {
  if(!isDefined(level.battlechatter) || !isDefined(self)) {
    return;
  }

  if(!isDefined(self.battlechatter) || !isDefined(self.battlechatter.countryid)) {
    return;
  }

  if(!isDefined(level.var_276311a22caaf5ac)) {
    return;
  }

  corpse = undefined;
  num_tries = 10;
  var_30d6320d769d3f2c = 1.5;
  countryid = self.battlechatter.countryid;
  name = self.battlechatter.name;
  voice = self.voice;
  team = self.team;
  count = 0;

  while(count < num_tries && !isDefined(corpse)) {
    array = [[level.var_276311a22caaf5ac]](self.origin, level.bcs_neardist);

    foreach(corpseent in array) {
      if(corpseent.birthtime == gettime() && distancesquared(corpseent.origin, self.origin) <= var_30d6320d769d3f2c) {
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
    corpse thread corpseloop();
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

    level.battlechatter.variations[base] = create_deck(array, 1, 1, 1);
  }

  return level.battlechatter.variations[base] deck_draw();
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

function function_b6b75579e4dbc957() {
  if(!isDefined(level.battlechatter.callsigns)) {
    callsigns = [];

    foreach(ai in getaiarray()) {
      if(isDefined(ai.callsign)) {
        callsigns[callsigns.size] = ai.callsign;
      }
    }

    if(callsigns.size > 0) {
      level.battlechatter.callsigns = create_deck(callsigns);
    }
  }

  if(isDefined(level.battlechatter.callsigns)) {
    self.callsign = level.battlechatter.callsigns deck_draw();
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

function function_2a14e530337dedc3() {
  radio = self.speaker get_radio_emitter();
  radio.battlechatter.npcid = "l1r";
  radio.name = "Team Leader (Radio)";
  return radio;
}

function function_573b9ff9ed152518(guy, isleader) {
  if(!isDefined(guy)) {
    guy = self.speaker;
  }

  if(!isDefined(guy.voice) || !isDefined(guy.battlechatter)) {
    return;
  }

  radio = spawnStruct();
  radio.vo_parent = guy;
  radio.origin = guy.origin;
  radio.isradioemitter = 1;
  radio.battlechatterallowed = 1;
  radio.team = default_to(self.team, "allies");
  radio.battlechatter = spawnStruct();

  if(!isDefined(guy.battlechatter.countryid)) {
    guy.battlechatter.countryid = "AQS";
  }

  if(istrue(isleader)) {
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
      if(!is_equal(usedid.npcid, guy.battlechatter.npcid)) {
        npcids[npcids.size] = usedid.npcid;
      }
    }
  }

  radio.battlechatter.countryid = guy.battlechatter.countryid;
  radio.battlechatter.npcid = random(npcids);
  return radio;
}

function function_592f13f1a0e078ff(guy) {
  return function_573b9ff9ed152518(guy, 1);
}

function getname() {
  if(!isDefined(self.battlechatter) || !isDefined(self.battlechatter.countryid)) {
    return;
  }

  if(!isDefined(self.battlechatter.name)) {
    if(!isDefined(level.battlechatter.names[self.battlechatter.countryid])) {
      function_793f0c4da1ff138f(self.battlechatter.countryid);

      if(!isDefined(level.battlechatter.names[self.battlechatter.countryid])) {
        return;
      }
    }

    self.battlechatter.name = level.battlechatter.names[self.battlechatter.countryid] deck_draw();
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

function function_b98b7a9053d0bcb6(origin) {
  if(!isDefined(origin)) {
    origin = self.origin;
  }

  region_trigs = getEntArray("bcs_region", "script_noteworthy");

  foreach(trig in region_trigs) {
    if(ispointinvolume(origin, trig) && isDefined(trig.targetname)) {
      return trig.targetname;
    }
  }

  return "none";
}

function getcombatstate() {
  if(is_dead_or_dying(self)) {
    return "dead";
  }

  if(isDefined(self.battlechatter.stateoverride)) {
    result = self.battlechatter.stateoverride;

    if(isfunction(result)) {
      result = self[[result]]();
    }

    if(isDefined(result)) {
      return result;
    }
  }

  if(!isDefined(level.stealth)) {
    return ter_op(isai(self) && self iscurrentenemyvalid(), "combat", "idle");
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

  return "unset";
}

function addcustombc(array, states, random) {}

function setcurrentcustombcevent(event, states, looping) {}

function function_5eef3c6f7b003167(state) {
  if(!isDefined(level.battlechatter.customstealth) || !isDefined(level.battlechatter.customstealth[state])) {
    return false;
  }

  return level.battlechatter.customstealth[state].size > 0;
}

function function_37569a0bddd31694(state) {
  assertex(isDefined(level.battlechatter.customstealth), "<dev string:x638>");
  index = level.battlechatter.customstealthindexes[state];
  sequence = level.battlechatter.customstealth[state][index];
  index++;

  if(index >= level.battlechatter.customstealth[state].size) {
    level.battlechatter.customstealth[state] = [];
  }

  return sequence;
}

function function_ac31838f9edde417(array, states, random) {
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
  anglestofacing = vectortoangles(vfacing);
  anglestopoint = vectortoangles(vpoint - vorigin);
  angle = anglestofacing[1] - anglestopoint[1];
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
      assertmsg("<dev string:x685>" + direction);
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
  assertex(isDefined(direction));
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
  anglestofacing = vectortoangles(vfacing);
  anglestopoint = vectortoangles(targetorigin - viewerorigin);
  angle = anglestofacing[1] - anglestopoint[1];
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
  vdominantdir = (0, 0, 0);

  for(i = 0; i < avangles.size; i++) {
    vdominantdir += avangles[i];
  }

  return (vdominantdir[0] / avangles.size, vdominantdir[1] / avangles.size, vdominantdir[2] / avangles.size);
}

function function_a07abd440b7a33fe(otherent) {
  if(!isDefined(otherent)) {
    return false;
  }

  if(!istrue(otherent.disguised)) {
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
  if(getDvar(@ "loc_warnings", 0) == "<dev string:x6ab>") {
    return;
  }

  if(getDvar(@ "hash_2f6380dc3031a0fc") != "<dev string:x160>") {
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

  if(getDvar(@ "debug_battlechatter") != "<dev string:x6b0>") {
    level.bcs_hud settext("<dev string:x160>");
    return;
  }

  msg = "<dev string:x6b6>";
  count = 0;

  if(isDefined(level.battlechatter)) {
    teams = [];
    teams["<dev string:x3e8>"] = level.battlechatter["<dev string:x3e8>"];
    teams["<dev string:x6d1>"] = level.battlechatter["<dev string:x6d1>"];

    foreach(team, val in teams) {
      if(val) {
        msg = msg + team + "<dev string:x15b>";
        count++;
      }
    }
  } else {
    msg += "<dev string:x6d9>";
    count++;
  }

  if(count == 0) {
    msg += "<dev string:x6fc>";
  }

  level.bcs_hud settext(msg);
}

function bcprint_info() {
  self endon("death");

  id = self.battlechatter.npcid;

  if(!isDefined(id)) {
    id = "<dev string:x160>";
  }

  countryid = self.battlechatter.countryid;

  if(!isDefined(countryid)) {
    countryid = "<dev string:x160>";
  }

  while(true) {
    if(battlechatter_canprint()) {
      if(!isDefined(self.battlechatterallowed) || istrue(self.battlechatter_removed)) {
        print3d(self.origin + (0, 0, 24), "<dev string:x70a>", (1, 0, 1), 1, 0.35, 1);
      } else if(self.battlechatterallowed) {
        print3d(self.origin + (0, 0, 24), "<dev string:x719>" + countryid + id, (0, 1, 0), 1, 0.35, 1);
      } else {
        print3d(self.origin + (0, 0, 24), "<dev string:x719>" + countryid + id, (1, 0, 0), 1, 0.35, 1);
      }
    }

    waitframe();
  }
}

function battlechatter_canprint() {
  if(getDvar(@ "hash_611f04c407c3f644") == self.team || getDvar(@ "hash_611f04c407c3f644") == "<dev string:x721>") {
    return true;
  }

  return false;
}

function battlechatter_canprintdump() {
  if(getDvar(@ "hash_9627c73338f91622") == self.team || getDvar(@ "hash_9627c73338f91622") == "<dev string:x721>") {
    return true;
  }

  return false;
}

function battlechatter_print(alias, color) {
  if(!battlechatter_canprint()) {
    return;
  }

  if(!isDefined(color)) {
    color = "<dev string:x728>";
  }

  colorkey = "<dev string:x728>";

  switch (color) {
    case #"hash_97430f6c58e61cbc":
      colorkey = "<dev string:x738>";
      break;
    case #"hash_2ac407c1cd5943a9":
      colorkey = "<dev string:x748>";
      break;
    case #"hash_6686d129776d649a":
      colorkey = "<dev string:x756>";
      break;
  }

  println(colorkey + self.origin + "<dev string:x75c>" + self.name + "<dev string:x762>" + alias);
}

function battlechatter_printdump(alias) {
  if(!battlechatter_canprintdump()) {
    return;
  }

  dumptype = getDvar(@ "hash_3cb0b3f110a54cf2", "<dev string:x76a>");

  if(dumptype != "<dev string:x76a>" && dumptype != "<dev string:x771>") {
    return;
  }

  secssincelastdump = -1;

  if(isDefined(level.lastdumptime)) {
    secssincelastdump = (gettime() - level.lastdumptime) / 1000;
  }

  level.lastdumptime = gettime();

  if(dumptype == "<dev string:x76a>") {
    if(!flag_exist("<dev string:x778>")) {
      flag_init("<dev string:x778>");
    }

    if(!isDefined(level.var_b363a2868472ded1)) {
      filepath = "<dev string:x793>" + level.script + "<dev string:x7b7>";
      level.var_b363a2868472ded1 = openfile(filepath, "<dev string:x7bf>");
    }

    aliastype = getaliastypefromsoundalias(alias);
    dumpstring = level.script + "<dev string:x7c8>" + self.operatorcustomization.voice + "<dev string:x7c8>" + aliastype;
    battlechatter_printdumpline(level.var_b363a2868472ded1, dumpstring, "<dev string:x778>");
    return;
  }

  if(dumptype == "<dev string:x771>") {
    if(!flag_exist("<dev string:x7cd>")) {
      flag_init("<dev string:x7cd>");
    }

    if(!isDefined(level.var_97ef0a827c8a39d1)) {
      filepath = "<dev string:x793>" + level.script + "<dev string:x7e8>";
      level.var_97ef0a827c8a39d1 = openfile(filepath, "<dev string:x7bf>");
    }

    dumpstring = "<dev string:x7f0>" + secssincelastdump + "<dev string:x7f5>";
    dumpstring += alias;
    battlechatter_printdumpline(level.var_97ef0a827c8a39d1, dumpstring, "<dev string:x7cd>");
  }
}

function battlechatter_debugprint(alias, color) {
  battlechatter_print(alias, color);
  thread battlechatter_printdump(alias);
}

function battlechatter_printdumpline(file, str, controlflag) {
  if(flag(controlflag)) {
    flag_wait(controlflag);
  }

  flag_set(controlflag);
  fprintln(file, str);
  flag_clear(controlflag);
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

    assertex(issubstr(alias, prefix), "<dev string:x800>" + alias + "<dev string:x82f>" + prefix + "<dev string:x84a>");
    aliastype = getsubstr(alias, prefix.size, alias.size);
  }

  return aliastype;
}

function function_2b9bf190120a5233(seconds) {
  if(isDefined(self.battlechatter)) {
    self.battlechatter.var_3c94d4874d436201 = gettime() + seconds * 1000;
  }
}

function function_8f59caa9212fcc56() {
  if(!canchatter("combat")) {
    return true;
  }

  if(utility::issp() && !isalive(level.player)) {
    return true;
  }

  if(!function_45f570789ff9a0fd(3)) {
    if(isDefined(self.battlechatter.var_20e68057b05a543) || !isDefined(self._blackboard)) {
      return true;
    }

    if(!shotrecently(3)) {
      self.battlechatter.var_20e68057b05a543 = gettime();
    }

    return true;
  }

  if(!isDefined(self.battlechatter.var_3c94d4874d436201)) {
    return false;
  }

  return self.battlechatter.var_3c94d4874d436201 > gettime();
}

function function_45f570789ff9a0fd(timeseconds, requiresight) {
  requiresight = default_to(requiresight, 0);

  if(istrue(self.pacifist) || istrue(self.ignoreall) || istrue(self.dontevershoot)) {
    return false;
  }

  if(!isDefined(self.enemy) || is_dead_or_dying(self.enemy)) {
    return false;
  }

  if(!ismp() && requiresight && !self seerecently(self.enemy, timeseconds)) {
    return false;
  }

  if(isDefined(self.asmtrackasm) && scripts\asm\asm::asm_currentstatehasflag(self.asmtrackasm, "aim")) {
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

function function_ab7df904aa60d433(array, maxsize) {
  maxsize = default_to(maxsize, array.size - 1);

  foreach(key, item in array) {
    if(array.size <= maxsize) {
      return array;
    }

    array[key] = undefined;
  }
}

function function_ecf957dba5b9cc50() {
  level endon("<dev string:x850>");
  level notify("<dev string:x85e>");
  level endon("<dev string:x85e>");

  while(true) {
    waittillframeend();
    function_c3b1c38b7230b341(1);
    waitframe();
  }
}

function function_c3b1c38b7230b341(debugdrawframeduration) {
  if(!getdvarint(@ "hash_4b7858e66804e305")) {
    return;
  }

  offsety = 20;
  debugposx = 50;
  debugposy = 500;
  debugtextcolor = (0, 1, 0);
  debugtextscale = 1;
  debugtext = "<dev string:x885>";
  printtoscreen2d(debugposx, debugposy, debugtext, debugtextcolor, debugtextscale, debugdrawframeduration);
  debugposy += offsety;

  if(!isDefined(level.var_426f5978d3aea5c2) || queue_isempty(level.var_426f5978d3aea5c2)) {
    return;
  }

  index = level.var_426f5978d3aea5c2.rear;

  while(index != level.var_426f5978d3aea5c2.front) {
    debug_string = level.var_426f5978d3aea5c2.array[index];

    if(!isDefined(debug_string)) {
      continue;
    }

    printtoscreen2d(debugposx, debugposy, debug_string, debugtextcolor, debugtextscale, debugdrawframeduration);
    debugposy += offsety;
    index--;

    if(index < 0) {
      index += level.var_426f5978d3aea5c2.capacity;
    }
  }
}

function function_fdb8454d071bcf5b(data, executed) {
  if(!isDefined(data) || !isDefined(data.category)) {
    return;
  }

  if(!isDefined(level.var_426f5978d3aea5c2)) {
    level.var_426f5978d3aea5c2 = queue_create(20);
    level thread function_ecf957dba5b9cc50();
  }

  debug_string = "<dev string:x89c>" + data.category;

  if(isDefined(data.subcategory)) {
    debug_string += "<dev string:x8aa>" + data.subcategory;
  }

  debug_string += "<dev string:x431>";
  debug_string += "<dev string:x8af>" + istrue(executed) + "<dev string:x431>";
  debug_string += "<dev string:x8bd>" + gettime() + "<dev string:x431>";

  if(level.var_426f5978d3aea5c2.array.size == level.var_426f5978d3aea5c2.capacity) {
    level.var_426f5978d3aea5c2 = function_93def91a50927481(level.var_426f5978d3aea5c2);
  }

  level.var_426f5978d3aea5c2 = function_6cf786a6cf335cb9(level.var_426f5978d3aea5c2, debug_string);
}

function function_55f43964ccdb5b95(var_d58ba359bfb14d3e) {
  if(isstruct(var_d58ba359bfb14d3e)) {
    if(isDefined(var_d58ba359bfb14d3e.vo_parent)) {
      return ("<dev string:x8c9>" + function_600b37e8cf3f2de9(var_d58ba359bfb14d3e.vo_parent));
    } else {
      return "<dev string:x8de>";
    }

    return;
  }

  return function_600b37e8cf3f2de9(var_d58ba359bfb14d3e);
}

# /