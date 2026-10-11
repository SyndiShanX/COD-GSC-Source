/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_41ffdbe01998b61a.gsc
*************************************************/

#using script_100adcc1cc11d2fa;
#using script_140b2a257b323303;
#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_1d43c78ad6bb95e2;
#using script_220d0eb95a8fab7d;
#using script_249b0a9054ceb230;
#using script_2cfe49cdd9a5a89a;
#using script_39d11000e476a42a;
#using script_3b78d23dad7ec5be;
#using script_3f9c618c4c35ed2;
#using script_41387eecc35b88bf;
#using script_41ffdbe01998b61a;
#using script_46c7c73b1a7e4773;
#using script_482376d10f69832c;
#using script_4e6e58ab5d96c2b0;
#using script_514a13029018133;
#using script_523e733991571416;
#using script_528320cb3630530d;
#using script_57bdd8aff28a4717;
#using script_58682e6578ce0515;
#using script_5d02d8723d456015;
#using script_6848353b07a74e84;
#using script_793f5fa29ca62c00;
#using script_7cfaa6fd841fb4dd;
#using script_7d3e27aa82b5d70b;
#using script_7e41e37180e554f;
#using script_7edf952f8921aa6b;
#using script_c6b9e8fb3a7de37;
#using script_ff16f9da6be790a;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_ob;
#using scripts\mp\mp_agent;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\points;
#using scripts\mp\weapons;
#namespace namespace_6faadab2b3f756a1;

function function_2dcca6d862cc31d5(params) {
  utility::function_3677f2be30fdd581("jup_ob_fx", "jup_ob_rift_run_fx");
  self.rift_run = 1;
  difficulty = "normal";

  if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
    difficulty = "hard";
  }

  self dlog_recordplayerevent("dlog_event_ob_player_rift_run", ["started", 1, "difficulty", difficulty]);

  if(getdvarint(@ "hash_8e03c888469910b0", 0)) {
    scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_ob::function_b60de1b748c7230f();
  }

  if(getdvarint(@ "ob_s3_rift_run", 0)) {
    thread function_b2082fcbe629a6f();
  }
}

function private function_4dd5d69d550c0999() {
  level endon("game_ended");
  scrambler = spawn("script_model", function_dc80e43dced96932());
  n_radius = int(default_to(function_868dda939525d6dd(), 10000));

  while(true) {
    if(!isDefined(level.players) || level.players.size < 1) {
      waitframe();
      continue;
    }

    owner = random(level.players);
    scrambler.team = owner.team;
    scrambler makescrambler(owner, undefined, n_radius, 1);
    owner waittill("disconnect");
    scrambler clearscrambler();
  }
}

function private function_dc80e43dced96932() {
  a_corners = getStructArray("minimap_corner", "targetname");
  v_loc = (0, 0, 0);

  if(a_corners.size) {
    foreach(corner in a_corners) {
      v_loc += corner.origin;
    }

    v_loc /= a_corners.size;
  }

  return v_loc;
}

function private function_868dda939525d6dd() {
  a_corners = getStructArray("minimap_corner", "targetname");

  if(a_corners.size > 1) {
    return (distance2d(a_corners[0].origin, a_corners[1].origin) / 1.9);
  }
}

function function_7e3b3e54fd85da26() {
  thread function_c449d50a557ece96();

  level._effect["spore_impact"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/vfx_spore_field_cocoon_weakpoint_imp.vfx");
  level._effect["heart_impact"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/vfx_spore_field_cocoon_heart_imp.vfx");
  level._effect["shield_impact"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_spore_field_shell_imp.vfx");
  level._effect["vision_effect"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_powerup_spawn_in_green.vfx");
  level._effect["rift_object_slowdown_on"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/zm_ai/movement/vfx_zmb_object_movement_slow_on.vfx");
  level._effect["rift_object_slowdown_off"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/zm_ai/movement/vfx_zmb_object_movement_slow_off.vfx");
  level._effect["rift_object_slowdown_on_mimic"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/zm_ai/movement/vfx_zmb_object_movement_slow_mimic_on.vfx");
  level._effect["rift_object_slowdown_off_mimic"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/zm_ai/movement/vfx_zmb_object_movement_slow_mimic_off.vfx");
  level._effect["rift_object_slowdown_on_mangler"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/zm_ai/movement/vfx_zmb_object_movement_slow_mangler_on.vfx");
  level._effect["rift_object_slowdown_off_mangler"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/zm_ai/movement/vfx_zmb_object_movement_slow_mangler_off.vfx");
  level._effect["rift_object_slowdown_on_hound"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/zm_ai/movement/vfx_zmb_object_movement_slow_hound_on.vfx");
  level._effect["rift_object_slowdown_off_hound"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/zm_ai/movement/vfx_zmb_object_movement_slow_hound_off.vfx");
  level._effect["rift_object_slowdown_on_disciple"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/zm_ai/movement/vfx_zmb_object_movement_slow_disciple_on.vfx");
  level._effect["rift_object_slowdown_off_disciple"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/zm_ai/movement/vfx_zmb_object_movement_slow_disciple_off.vfx");

  if(!getdvarint(@ "hash_1c2c174b18e6d9b8", 0)) {
    thread function_4dd5d69d550c0999();
  }

  if(!isDefined(level._effect["vfx_outbreak_tear_destabilizing_dust_ground_green"]) && getdvarint(@ "hash_383f11927e66fc37", 1)) {
    level._effect["vfx_outbreak_tear_destabilizing_dust_ground_green"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_loot_obj_speed_pickup.vfx");
  }

  level.var_e75e7ca73e94d4f7 = getdvarint(@ "hash_4c396a81425f649b", 0);
  thread namespace_b000de497fab9bf4::function_ccde446fe7425514(level.var_e75e7ca73e94d4f7);
  thread infil_music();
  level flag_wait("ai_spawn_director_initialized");
  namespace_22b8ba12655bf3f2::function_d589c49c4b9b50a0(&scripts\mp\gametypes\ob::function_91d032246bb24684);
  thread intro_vo();
  thread namespace_88d9f8b28d831818::function_ecd079f7925cc275();
  thread function_3d203d1752c3714c();
  namespace_b000de497fab9bf4::function_a13799ae222a8b48("exit_portal");
  thread function_d58ad4f904032ed0();
  thread weakpoint_setup();
  thread function_4bb2f4017b25f5d3();
  function_b5e57408c7878df7(&function_f7d395f2f09077dd);
  scripts\engine\scriptable::scriptable_addusedcallback(&function_6af4c434f6564f56);
  callback::add("player_item_pickup", &on_item_pickup);
  callback::add("player_item_drop", &on_item_drop);
  callback::add("on_turned", &on_brainrot);
  activity_common::function_8b5b2a3392fc7e2a("InstanceBegin", &function_6e96108f17efa162, "REV_OB_OUTLAST");
  activity_common::function_8b5b2a3392fc7e2a("InstanceBegin", &function_6e96108f17efa162, "REV_OB_BIGBOUNTY");
  activity_common::function_8b5b2a3392fc7e2a("InstanceBegin", &function_6e96108f17efa162, "REV_OB_ESCORT_ZOMBIES");
  activity_common::function_8b5b2a3392fc7e2a("ActivityBegin", &_contract_started, "REV_OB_OUTLAST");
  activity_common::function_8b5b2a3392fc7e2a("ActivityBegin", &_contract_started, "REV_OB_BIGBOUNTY");
  activity_common::function_8b5b2a3392fc7e2a("ActivityBegin", &_contract_started, "REV_OB_ESCORT_ZOMBIES");
  activity_common::function_8b5b2a3392fc7e2a("ActivitySuccess", &_contract_complete, "REV_OB_OUTLAST");
  activity_common::function_8b5b2a3392fc7e2a("ActivitySuccess", &_contract_complete, "REV_OB_BIGBOUNTY");
  activity_common::function_8b5b2a3392fc7e2a("ActivitySuccess", &_contract_complete, "REV_OB_ESCORT_ZOMBIES");
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&function_e31bb9a7109b02bb);
  thread namespace_72d85a5f3cb24eec::ob_ambient_zombie_waves_setup();

  childthread function_2476244023968f4b();

  thread namespace_c7b56f74bc8bd1ce::function_7eb3998d94066771();
  function_aee09905df73108();
}

function function_61aea37385c298a9(params) {
  self endon("death_or_disconnect");
  thread scripts\cp_mp\overlord::playevent("s3_rr_portal_spawn", [self], 0.5);
}

function function_6d274d4ea8783210(relevantinfostruct) {
  level endon("game_ended");
}

function function_6e96108f17efa162(relevantinfostruct) {
  flag_wait("obelisks_setup");

  switch (self.type) {
    case #"hash_17b1c4f2de901a59":
      level.obelisks["speedboost"].activityinstance = self;
      break;
    case #"hash_5253ef0f4683b778":
      level.obelisks["damage"].activityinstance = self;
      break;
    case #"hash_40d422a1ae5ecf0f":
      level.obelisks["vision"].activityinstance = self;
      break;
    default:
      break;
  }
}

function function_6af4c434f6564f56(instance, part, state, player, bautouse, usestring) {
  if(isDefined(player) && part == "nexus_activity_joiner_phone") {
    foreach(obelisk in level.obelisks) {
      if(obelisk.activityinstance.type == instance.activity_instance.type) {
        item = [[level.var_190c066f1b962111[obelisk.base.var_49833d40d310dcb8].var_50b449d2553ac489]](instance.origin, obelisk.base.var_49833d40d310dcb8);
        item = function_10097590634ee94b(item);
        thread item_liftoff(item);
        player scripts\cp_mp\loot\common_item::function_576728d3d4486bd6(item, 0, 0, 0);
        player thread scripts\mp\utility\points::doscoreevent(#"hash_816ee095be9d88bf");

        switch (obelisk.base.var_49833d40d310dcb8) {
          case #"hash_f8c8b1614db8389b":
            var_cd6b3ace7362b192 = "s3_rr_movement_object_found";
            break;
          case #"hash_1cc8a923a608c2a0":
            var_cd6b3ace7362b192 = "s3_rr_damage_object_found";
            break;
          case #"hash_9daa4e30cce5c489":
            var_cd6b3ace7362b192 = "s3_rr_vision_object_found";
            break;
        }

        break;
      }
    }

    if(isDefined(var_cd6b3ace7362b192)) {
      thread scripts\cp_mp\overlord::playevent(var_cd6b3ace7362b192, level.players, 4.5);
    }

    var_cd6b3ace7362b192 = undefined;
  }
}

function _contract_started(var_b6d035b4e3489246) {
  self.var_17a2361aa0beabb2[0] notify("contract_started");

  if(getdvarint(@ "hash_5c148cf6b38f7d09", 0)) {
    thread function_7c6ca3693ae0340e();
  }
}

function private function_7c6ca3693ae0340e() {
  level endon("<dev string:x1c>");
  wait 5;
  namespace_4fda5d7358015a06::endactivity(self, 1);
}

function _contract_complete(relevantinfostruct) {
  function_6d274d4ea8783210(relevantinfostruct);
  obelisk_completed(level.var_747eee71c41ccadc);
}

function intro_vo() {
  level endon("game_ended");
  level utility::flag_wait("ob_infil_completed");
  thread scripts\cp_mp\overlord::playevent("s3_rr_arrive", level.players, 7);
}

function infil_music() {
  level waittill_any_2("match_start_real_countdown", "match_start_timer_skip");
  level thread namespace_b3f32c8cb80b8124::function_aadc1c81b3fd1dd2(level.players);
}

function function_3d203d1752c3714c() {
  var_17fbc4ea1388535e = getStruct("heartspawn", "targetname");
  level.cyclone = utility::spawn_model("jup_zm_rift_run_cyclone", var_17fbc4ea1388535e.origin, var_17fbc4ea1388535e.angles);
}

function function_1457677100139213() {
  level.cyclone setscriptablepartstate("vortex", "off");
}

function function_d58ad4f904032ed0() {
  level.obelisks = [];
  level.var_833c19ce35f0fdc0 = 0;
  obelisk_structs = getStructArray("obeliskspawn", "targetname");
  beams = getscriptablearray("obeliskbeam", "targetname");

  foreach(obelisk_struct in obelisk_structs) {
    var_a01dfb6cde8f348e = obelisk_struct.script_noteworthy;
    level.obelisks[var_a01dfb6cde8f348e] = spawnStruct();
    level.obelisks[var_a01dfb6cde8f348e].base = spawnscriptable("jup_zm_rift_altar", obelisk_struct.origin, obelisk_struct.angles);
    level.obelisks[var_a01dfb6cde8f348e].base.var_49833d40d310dcb8 = var_a01dfb6cde8f348e;
    level.obelisks[var_a01dfb6cde8f348e].top = spawnscriptable("jup_zm_rift_altar_top", obelisk_struct.origin + (0, 0, 40), obelisk_struct.angles);
    level.obelisks[var_a01dfb6cde8f348e].completed = 0;
    level.obelisks[var_a01dfb6cde8f348e].activityinstance = [];
    level.obelisks[var_a01dfb6cde8f348e].base setscriptablepartstate("body", "default");
    level.obelisks[var_a01dfb6cde8f348e].base setscriptablepartstate("interact", "on");
    level.obelisks[var_a01dfb6cde8f348e].top setscriptablepartstate("body", "spawned");

    foreach(beam in beams) {
      if(beam.script_noteworthy == var_a01dfb6cde8f348e) {
        level.obelisks[var_a01dfb6cde8f348e].base.beam = beam;
        beam setscriptablepartstate("beam", "on");
      }
    }

    scripts\cp_mp\interaction::function_32645103f7520635(level.obelisks[var_a01dfb6cde8f348e].base, &activate_obelisk, undefined, &obelisk_gesture);
    level.obelisks[var_a01dfb6cde8f348e].base scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_dda97bcf0f20e53f);
    function_3dd6cf4f550e9f9d(var_a01dfb6cde8f348e);
  }

  thread function_a911ba043cf91b47();
  flag_set("obelisks_setup");
}

function activate_obelisk(player) {
  level.var_747eee71c41ccadc = self.var_49833d40d310dcb8;
  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_contract_action_loop");
  self setscriptablepartstate("body", "default");
  self setscriptablepartstate("interact", "off");
  self.beam setscriptablepartstate("beam", "off");
  level.obelisks[level.var_747eee71c41ccadc].top setscriptablepartstate("body", "destroyed");
  level.obelisks[level.var_747eee71c41ccadc].activityinstance notify("activate_activity_starter");
  item = level.obelisks[level.var_747eee71c41ccadc].activityinstance.var_17a2361aa0beabb2[0];
  item = function_10097590634ee94b(item);
  thread item_liftoff(item);
}

function obelisk_completed(var_747eee71c41ccadc) {
  level.obelisks[var_747eee71c41ccadc].completed = 1;
  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_contract_win");
  level.var_747eee71c41ccadc = "";
  level.var_6b879e3378fe4f93 = 0;
  level.var_b5c75487d8c13198 = 0;
  level.var_d27f8b283029b2d9 = 0;
  level.var_833c19ce35f0fdc0++;

  foreach(weakpoint in level.var_85a85964b56787d8) {
    weakpoint.shield dodamage(34, weakpoint.origin, level.players[0], undefined, undefined, "<explicitweaponnone>");
  }

  if(level.var_833c19ce35f0fdc0 >= level.obelisks.size) {
    level notify("obelisks_complete");
  }
}

function obelisk_gesture(player) {
  wait 1.15;

  if(player useButtonPressed()) {
    player forceplaygestureviewmodel("jup_ges_open_portal");
  }
}

function function_dda97bcf0f20e53f(interact, player) {
  if(isDefined(player)) {
    var_6ff9941006fb29cd = namespace_d886885225a713a7::function_553a690e1064cf0b(player);

    if(isDefined(var_6ff9941006fb29cd) && var_6ff9941006fb29cd.size > 0) {
      return {
        #string: &"", #type: "HINT_NOBUTTON"};
    }
  }

  return {
    #string: &"JUP_OB_S1/ACTIVATE_OBELISK", #type: "HINT_BUTTON"};
}

function item_liftoff(item) {
  item endon("contract_started");
  item endon("destroyed");
  var_a4bddd55aee55e46 = 3;
  var_c2d35eda877c6b2c = item.move.origin + (0, 0, 5);

  while(true) {
    var_a4bddd55aee55e46 *= -1;
    var_c2d35eda877c6b2c += (0, 0, var_a4bddd55aee55e46);
    item.move moveTo(var_c2d35eda877c6b2c, 1.5, 0.5, 0.5);
    item.move rotateby((0, 15, 0), 1.5, 0, 0);
    wait 1.5;
  }
}

function private function_a911ba043cf91b47() {
  level endon("game_ended");
  level waittill("obelisks_complete");
  thread function_1457677100139213();
  thread namespace_c7b56f74bc8bd1ce::function_a5b76e0f5024cc9a(level.rift_heart, "players_near_heart", 3000, 1, "weakpoints_defeated", 0, 0);
  thread function_9e433ff809422ffa();
}

function private function_3dd6cf4f550e9f9d(itemtype) {
  if(!isDefined(level.var_190c066f1b962111)) {
    level.var_190c066f1b962111 = [];
  }

  if(isDefined(level.var_190c066f1b962111[itemtype])) {
    println("<dev string:x2a>" + itemtype);
    return;
  }

  level.var_190c066f1b962111[itemtype] = spawnStruct();
  level.var_190c066f1b962111[itemtype].itemtype = itemtype;
  level.var_190c066f1b962111[itemtype].var_50b449d2553ac489 = &function_6c863f8d5cda37cf;

  switch (itemtype) {
    case #"hash_1cc8a923a608c2a0":
      level.var_190c066f1b962111[itemtype].var_b5931c8dfd329558 = &function_90e5471028a3f70d;
      level.var_190c066f1b962111[itemtype].item_bundle = getscriptbundle("itemspawnentry:" + "ob_jup_item_rift_object_season3_damage");
      break;
    case #"hash_9daa4e30cce5c489":
      level.var_190c066f1b962111[itemtype].var_cca36589b3a3d0b = &function_f39779415c996c01;
      level.var_190c066f1b962111[itemtype].var_b5931c8dfd329558 = &function_6a9147db5f7c2cda;
      level.var_190c066f1b962111[itemtype].item_bundle = getscriptbundle("itemspawnentry:" + "ob_jup_item_rift_object_season3_vision");
      break;
    case #"hash_f8c8b1614db8389b":
      level.var_190c066f1b962111[itemtype].var_cca36589b3a3d0b = &function_c9dbaecc900dbcfa;
      level.var_190c066f1b962111[itemtype].var_b5931c8dfd329558 = &function_f9ebd379912a3b01;
      level.var_190c066f1b962111[itemtype].item_bundle = getscriptbundle("itemspawnentry:" + "ob_jup_item_rift_object_season3_speed");
      break;
    default:
      println("<dev string:x7e>" + itemtype);
      break;
  }
}

function private function_6c863f8d5cda37cf(var_c2d35eda877c6b2c, var_76753b341c69cd90) {
  if(isDefined(level.var_190c066f1b962111[var_76753b341c69cd90]) && isDefined(level.var_190c066f1b962111) && isDefined(var_76753b341c69cd90) && isDefined(var_c2d35eda877c6b2c) && isDefined(level.var_190c066f1b962111[var_76753b341c69cd90].item_bundle)) {
    return scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(level.var_190c066f1b962111[var_76753b341c69cd90].item_bundle, var_c2d35eda877c6b2c, (0, 0, 0), 1, 1);
  } else {
    println("<dev string:xc1>" + var_76753b341c69cd90);
  }

  return undefined;
}

function private function_d5c05d240607cc07(var_6a01c1f62b0609c9, var_76753b341c69cd90) {
  function_89a2e0bb57f58e41(var_76753b341c69cd90);
  level.var_190c066f1b962111[var_76753b341c69cd90].var_7994f872ac0cd2cd = var_6a01c1f62b0609c9;

  if(isDefined(level.var_190c066f1b962111[var_76753b341c69cd90].var_cca36589b3a3d0b)) {
    var_6a01c1f62b0609c9[[level.var_190c066f1b962111[var_76753b341c69cd90].var_cca36589b3a3d0b]]();
  }
}

function private function_89a2e0bb57f58e41(var_76753b341c69cd90) {
  if(isDefined(var_76753b341c69cd90) && isDefined(level.var_190c066f1b962111[var_76753b341c69cd90].var_7994f872ac0cd2cd)) {
    if(isDefined(level.var_190c066f1b962111[var_76753b341c69cd90].var_b5931c8dfd329558)) {
      item = level.var_190c066f1b962111[var_76753b341c69cd90].var_7994f872ac0cd2cd[[level.var_190c066f1b962111[var_76753b341c69cd90].var_b5931c8dfd329558]]();
    }

    level.var_190c066f1b962111[var_76753b341c69cd90].var_7994f872ac0cd2cd = undefined;
  }
}

function private function_90e5471028a3f70d(var_4cc2d97638439d33) {
  if(isDefined(level.var_4f9f011ff619a4ec)) {
    if(isDefined(level.var_4f9f011ff619a4ec.targetenemy)) {
      if(!istrue(var_4cc2d97638439d33)) {
        level.var_4f9f011ff619a4ec.targetenemy notify("damage_object_target_removed");
      }

      level.var_4f9f011ff619a4ec.targetenemy callback::remove("on_zombie_ai_killed", &function_7f596f826857ba59);

      if(isDefined(level.var_4f9f011ff619a4ec.outlineid)) {
        outlinedisable(level.var_4f9f011ff619a4ec.outlineid, level.var_4f9f011ff619a4ec.targetenemy);
      }
    }

    level.var_4f9f011ff619a4ec = undefined;
  }
}

function function_e31bb9a7109b02bb(player) {
  foreach(zombieobject in level.var_190c066f1b962111) {
    if(isDefined(zombieobject.var_7994f872ac0cd2cd) && zombieobject.var_7994f872ac0cd2cd == player && isDefined(zombieobject.var_50b449d2553ac489)) {
      item = [[zombieobject.var_50b449d2553ac489]](player.origin, zombieobject.itemtype);
    }
  }
}

function function_ca68df9da171efc(var_76753b341c69cd90) {
  if(isDefined(level.var_190c066f1b962111[var_76753b341c69cd90])) {
    return level.var_190c066f1b962111[var_76753b341c69cd90].var_7994f872ac0cd2cd;
  }

  return undefined;
}

function function_e6bb772e7a019015(var_c774c853c747a633) {
  switch (var_c774c853c747a633) {
    case #"hash_4d6992e184382ec5":
      return "damage";
    case #"hash_9e5dd6d56c57a85f":
      return "speedboost";
    case #"hash_fcec23799985cc4":
      return "vision";
  }

  return undefined;
}

function on_item_pickup(params) {
  if(isDefined(params) && isDefined(self) && isDefined(params.itembundlename) && isPlayer(self)) {
    if(isDefined(params.item)) {
      params.item notify("destroyed");
    }

    var_76753b341c69cd90 = function_e6bb772e7a019015(params.itembundlename);

    if(isDefined(var_76753b341c69cd90)) {
      function_d5c05d240607cc07(self, var_76753b341c69cd90);
    }
  }
}

function on_item_drop(params) {
  if(isDefined(params) && isDefined(self) && isDefined(params.itembundlename) && isPlayer(self)) {
    var_76753b341c69cd90 = function_e6bb772e7a019015(params.itembundlename);

    if(isDefined(var_76753b341c69cd90)) {
      var_993f69b00adc22f = function_ca68df9da171efc(var_76753b341c69cd90);

      if(isDefined(var_993f69b00adc22f)) {
        if(var_993f69b00adc22f != self) {
          println("<dev string:x10d>" + var_76753b341c69cd90 + "<dev string:x13b>" + var_993f69b00adc22f + "<dev string:x143>" + self);
        }

        var_993f69b00adc22f notify("zombie_object_dropped_" + var_76753b341c69cd90);
        function_89a2e0bb57f58e41(var_76753b341c69cd90);
      }
    }
  }
}

function function_10097590634ee94b(item) {
  item.move_to_point = spawn("script_model", item.origin);
  item.move_to_point setModel("tag_origin");
  item.move = spawn("script_model", item.origin);
  item.move setModel("jup_zm_item_mover_invisible");
  item utility::scriptable_setparententity(item.move);
  return item;
}

function on_brainrot(params) {
  if(isDefined(level.var_4f9f011ff619a4ec) && isDefined(level.var_4f9f011ff619a4ec.targetenemy) && self == level.var_4f9f011ff619a4ec.targetenemy) {
    function_90e5471028a3f70d();
  }
}

function private function_f39779415c996c01() {
  if(isDefined(self)) {
    if(!isDefined(self.var_7cdda70396975627)) {
      self.var_7cdda70396975627 = [];
    }

    if(!isDefined(level.var_16f4d9b972fd3bc9)) {
      level.var_c12c807d41ad94ed = ["nuke"];
      level.var_16f4d9b972fd3bc9 = [];
      level thread zombie_object_vision_power_monitor();
    }

    function_8dbe147bb733cf46();
  }
}

function private function_6a9147db5f7c2cda() {
  if(isDefined(self)) {
    function_2af741558a616b2b();
  }
}

function private function_8dbe147bb733cf46() {
  foreach(var_b65e05f9dba0d8c0 in level.var_16f4d9b972fd3bc9) {
    if(isDefined(var_b65e05f9dba0d8c0.targetenemy)) {
      fx = playFXOnTag(level._effect["vision_effect"], var_b65e05f9dba0d8c0.targetenemy, "j_spine4");
    }
  }
}

function private function_2af741558a616b2b() {
  foreach(var_b65e05f9dba0d8c0 in level.var_16f4d9b972fd3bc9) {
    var_b65e05f9dba0d8c0.outlineid = stopFXOnTag(level._effect["vision_effect"], var_b65e05f9dba0d8c0.targetenemy, "j_spine4");
    wait 0.01;
  }
}

function private function_17c372b6ee7ca81c() {
  level endon("game_ended");

  foreach(var_b65e05f9dba0d8c0 in level.var_16f4d9b972fd3bc9) {
    if(var_b65e05f9dba0d8c0.targetenemy == self) {
      callback::remove("on_zombie_ai_killed", &function_80747402ae46e574);
      level.var_16f4d9b972fd3bc9 = array_remove(level.var_16f4d9b972fd3bc9, var_b65e05f9dba0d8c0);
    }
  }
}

function private zombie_object_vision_power_monitor() {
  self notify("zombie_object_vision_power_monitor");
  self endon("zombie_object_vision_power_monitor");
  level endon("game_ended");
  var_43775e026cdaebac = 500;

  while(true) {
    var_586c5d1a6d0188 = function_ca68df9da171efc("vision");

    if(isDefined(var_586c5d1a6d0188)) {
      characters = utility::charactersnear(var_586c5d1a6d0188.origin, var_43775e026cdaebac, 0);

      if(isDefined(characters) && characters.size > 0) {
        foreach(character in characters) {
          if(!isDefined(character)) {
            continue;
          }

          if(isagent(character) && isalive(character) && character.unittype != "soldier" && (character.subclass == "zombie_disciple" || character.subclass == "zombie_mimic" || character.subclass == "zombie_mangler") && !istrue(character.var_4f6f25187057642) && character.agent_type != "actor_jup_spawner_zombie_disciple_s3_rr") {
            character.var_4f6f25187057642 = 1;
            nextindex = level.var_16f4d9b972fd3bc9.size;
            level.var_16f4d9b972fd3bc9[nextindex] = spawnStruct();
            level.var_16f4d9b972fd3bc9[nextindex].targetenemy = character;
            level.var_16f4d9b972fd3bc9[nextindex].outlineid = playFXOnTag(level._effect["vision_effect"], character, "j_spine4");
            character callback::add("on_zombie_ai_killed", &function_80747402ae46e574);
            break;
          }
        }
      }
    }

    wait 30;
  }
}

function private function_80747402ae46e574(params) {
  if(self tagexists("j_spine4")) {
    killfxontag(level._effect["vision_effect"], self, "j_spine4");
  }

  var_586c5d1a6d0188 = function_ca68df9da171efc("vision");
  var_9c4e6c601cc02f34 = namespace_64135de19550f047::function_3bd4148272ae66ee(params);

  if(isDefined(self) && isDefined(var_586c5d1a6d0188) && isDefined(var_9c4e6c601cc02f34) && var_9c4e6c601cc02f34 == var_586c5d1a6d0188) {
    function_2f52cfcbc16f6617(self);
  }

  thread function_17c372b6ee7ca81c();
}

function private function_2f52cfcbc16f6617(var_95b54b56e5fedf) {
  str_powerup = random(level.var_c12c807d41ad94ed);
  root = scripts\common\powerups::function_ecdae672c660149e();
  offset = (0, 0, scripts\common\powerups::function_edeba0070ca0709e("drop_height_offset"));
  v_spawn_pos = var_95b54b56e5fedf.origin + offset - (0, 0, 8);

  if(isDefined(v_spawn_pos) && isDefined(scripts\common\powerups::function_519d44e54a9b8ae5(str_powerup))) {
    e_powerup = namespace_53fc9ddbb516e6e1::droppowerupsharedfunc(str_powerup, v_spawn_pos);
  }
}

function private function_c9dbaecc900dbcfa() {
  if(isDefined(self)) {
    self.var_26beacac25790313 = getdvarfloat(@ "hash_40da8928f49956a4", 0.3);
    scripts\mp\weapons::updatemovespeedscale();
    thread function_302f9bdb816ab814();
    thread function_e20a2ea1061978ac();
  }
}

function private function_f9ebd379912a3b01() {
  if(isDefined(self)) {
    self.var_26beacac25790313 = 0;
    scripts\mp\weapons::updatemovespeedscale();
    self notify("zombie_object_speed_removed");
    waitframe();

    if(isDefined(level.slowed_zombies) && level.slowed_zombies.size > 0) {
      foreach(agent in level.slowed_zombies) {
        agent childthread zombie_object_speed_enemy_stop_slowdown();
      }
    }
  }
}

function private function_302f9bdb816ab814() {
  self endon("zombie_object_dropped_" + "speedboost");
  self endon("zombie_object_speed_removed");
  level endon("game_ended");

  if(!isDefined(level.slowed_zombies)) {
    level.slowed_zombies = [];
  }

  var_43775e026cdaebac = getdvarfloat(@ "hash_779cbf976183884", 200);

  while(isDefined(self) && isPlayer(self) && isalive(self)) {
    characters = utility::charactersnear(self.origin, var_43775e026cdaebac, 0);
    var_43775e026cdaebac = getdvarfloat(@ "hash_779cbf976183884", 200);

    if(getdvarint(@ "hash_2dca309bcd066c61", 0)) {
      thread scripts\mp\utility\debug::drawsphere(self.origin, var_43775e026cdaebac, 0.5, (0, 1, 0));
    }

    if(isDefined(characters) && characters.size > 0) {
      foreach(character in characters) {
        if(!isDefined(character)) {
          continue;
        }

        if(isagent(character) && isalive(character) && !istrue(character.var_8b39a52e441b9740) && character.unittype != "soldier" && character.team != self.team && !function_c3d2fefa443b3a22(character)) {
          level.slowed_zombies = function_6d6af8144a5131f1(level.slowed_zombies, character);
        }

        if(isPlayer(character) && (!isDefined(character.var_26beacac25790313) || character.var_26beacac25790313 == 0)) {
          character thread zombie_object_player_speedup_monitor();
        }
      }
    }

    if(getdvarint(@ "hash_383f11927e66fc37", 0)) {
      playFXOnTag(getfx("vfx_outbreak_tear_destabilizing_dust_ground_green"), self, "tag_origin");
    }

    wait 0.5;
  }
}

function function_e20a2ea1061978ac() {
  self endon("zombie_object_dropped_" + "speedboost");
  self endon("zombie_object_speed_removed");
  level endon("game_ended");

  if(getdvarint(@ "hash_2dca309bcd066c61", 0)) {
    var_97cdc01a6f73c5aa = max(1, 0.5 / getframeduration());
  }

  while(true) {
    if(!isalive(self)) {
      break;
    }

    foreach(zombie in level.slowed_zombies) {
      var_30c031844816770d = function_ca68df9da171efc("speedboost");
      distsq = distancesquared(var_30c031844816770d.origin, zombie.origin);

      if(distsq <= squared(200) && !function_c3d2fefa443b3a22(zombie) && isalive(zombie)) {
        zombie function_43d5c03638e9115b();
      }

      if(distsq > squared(250) && isalive(zombie)) {
        zombie childthread zombie_object_speed_enemy_stop_slowdown();
        level.slowed_zombies = array_remove(level.slowed_zombies, zombie);
      }
    }

    if(isDefined(var_97cdc01a6f73c5aa)) {
      thread function_113e56c2e47f062b(int(var_97cdc01a6f73c5aa));
    }

    wait 0.5;
  }
}

function private function_c3d2fefa443b3a22(zombie) {
  assert(isDefined(zombie), "<dev string:x15a>");
  return zombie namespace_5e5b12854e72824d::has_slow("zombie_object_slowdown");
}

function private zombie_object_player_speedup_monitor() {
  self notify("zombie_object_player_speedup_monitor");
  self endon("zombie_object_player_speedup_monitor");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.var_26beacac25790313 = getdvarfloat(@ "hash_40da8928f49956a4", 0.3);
  scripts\mp\weapons::updatemovespeedscale();
  wait 0.5;
  self.var_26beacac25790313 = 0;
  scripts\mp\weapons::updatemovespeedscale();
}

function private function_43d5c03638e9115b() {
  var_5a159fa88e64333c = getdvarfloat(@ "hash_28a36546fbca6bb5", 0.5);
  var_30c031844816770d = function_ca68df9da171efc("speedboost");
  var_d17eff6f04f9dd24 = namespace_5e5b12854e72824d::slow("zombie_object_slowdown", var_5a159fa88e64333c, 9999, var_30c031844816770d);

  if(!var_d17eff6f04f9dd24) {
    var_82d9b5ec09fac56f = isDefined(self) && isDefined(self.classname) ? "<dev string:x19f>" + self.classname : "<dev string:x1ad>";
    println("<dev string:x1b1>" + var_82d9b5ec09fac56f);

    return;
  }

  if(self tagexists("j_spine4")) {
    playFXOnTag(function_1196210659239aa6(self, "on"), self, "j_spine4");
  } else {
    var_82d9b5ec09fac56f = isDefined(self) && isDefined(self.classname) ? "<dev string:x19f>" + self.classname : "<dev string:x1ad>";
    println("<dev string:x247>" + var_82d9b5ec09fac56f);
  }

  callback::add("on_zombie_ai_killed", &function_32fb4df113a38baf);
}

function private zombie_object_speed_enemy_stop_slowdown(var_be2983d06eac3257) {
  self notify("zombie_object_speed_enemy_stop_slowdown");

  if(!istrue(var_be2983d06eac3257)) {
    self endon("zombie_object_speed_enemy_stop_slowdown");
  }

  self endon("death");

  if(isDefined(self)) {
    if(self tagexists("j_spine4")) {
      stopFXOnTag(function_1196210659239aa6(self, "on"), self, "j_spine4");

      if(istrue(var_be2983d06eac3257)) {
        self.var_8b39a52e441b9740 = 1;
        var_ba9fcb4b59367a96 = self gettagorigin("j_spine4", 1, 0, 1);
        tagangles = self gettagangles("j_spine4", 1, 0, 1);

        if(isDefined(var_ba9fcb4b59367a96) && isDefined(tagangles)) {
          playFX(function_1196210659239aa6(self, "off"), var_ba9fcb4b59367a96, anglesToForward(tagangles), anglestoup(tagangles));
        }

        waitframe();
      } else {
        playFXOnTag(function_1196210659239aa6(self, "off"), self, "j_spine4");
      }

      callback::remove("on_zombie_ai_killed", &function_32fb4df113a38baf);
    }

    if(namespace_5e5b12854e72824d::is_slowed()) {
      namespace_5e5b12854e72824d::stop_slow("zombie_object_slowdown");
    }
  }
}

function private function_32fb4df113a38baf(params) {
  if(isDefined(self)) {
    zombie_object_speed_enemy_stop_slowdown(1);
    level.slowed_zombies = array_remove(level.slowed_zombies, self);
  }
}

function private function_1196210659239aa6(agent, type) {
  switch (agent.subclass) {
    case #"hash_2f5c52f1e6ef9284":
      if(type == "off") {
        return level._effect["rift_object_slowdown_off_mangler"];
      }

      if(type == "on") {
        return level._effect["rift_object_slowdown_on_mangler"];
      }

      break;
    case #"hash_3e4a9c816939eeef":
      if(type == "off") {
        return level._effect["rift_object_slowdown_off_disciple"];
      }

      if(type == "on") {
        return level._effect["rift_object_slowdown_on_disciple"];
      }

      break;
    case #"hash_99d5ac2f7a4d8083":
      if(type == "off") {
        return level._effect["rift_object_slowdown_off_hound"];
      }

      if(type == "on") {
        return level._effect["rift_object_slowdown_on_hound"];
      }

      break;
    case #"hash_59740dd906312a95":
      if(type == "off") {
        return level._effect["rift_object_slowdown_off_mimic"];
      }

      if(type == "on") {
        return level._effect["rift_object_slowdown_on_mimic"];
      }

      break;
    default:
      if(type == "off") {
        return level._effect["rift_object_slowdown_off"];
      }

      if(type == "on") {
        return level._effect["rift_object_slowdown_on"];
      }

      break;
  }
}

function private function_113e56c2e47f062b(var_54cb0c862c4b671e) {
  level endon("<dev string:x1c>");
  statustext = isDefined(self.status_effects) && isDefined(self.status_effects["<dev string:x2b1>"].size > 0) ? "<dev string:x2b9>" + self.status_effects["<dev string:x2b1>"].size : "<dev string:x2be>";
  debugtext = "<dev string:x2ca>" + statustext + "<dev string:x2d5>" + self.origin;
  pos = self.origin + (0, 0, 1);
  print3d(pos, debugtext, (0, 1, 0), 1, 0.25, var_54cb0c862c4b671e, 1);
}

function function_f7d395f2f09077dd(params) {
  if(!isDefined(params)) {
    return;
  }

  finaldamage = params.idamage;
  var_11027699bed08e27 = function_ca68df9da171efc("vision");

  if(isDefined(var_11027699bed08e27) && isDefined(params.eattacker) && params.eattacker == var_11027699bed08e27 && istrue(self.var_4f6f25187057642) && params.smeansofdeath == "MOD_MELEE" && self.health - params.idamage > 0) {
    finaldamage = self.health;
  } else {
    var_731a546b9d8af910 = function_ca68df9da171efc("damage");

    if(isDefined(self) && isDefined(var_731a546b9d8af910) && isDefined(params.smeansofdeath) && (params.smeansofdeath == "MOD_PISTOL_BULLET" || params.smeansofdeath == "MOD_RIFLE_BULLET" || params.smeansofdeath == "MOD_PROJECTILE" || params.smeansofdeath == "MOD_MELEE")) {
      var_44f17edf8b3e3676 = 0;

      if(isDefined(var_731a546b9d8af910) && isDefined(params.eattacker) && var_731a546b9d8af910 == params.eattacker) {
        if(!isDefined(level.var_4f9f011ff619a4ec) && self.health - params.idamage > 0 && !isDefined(self.brainrot_kills)) {
          level.var_4f9f011ff619a4ec = spawnStruct();
          level.var_4f9f011ff619a4ec.targetenemy = self;
          level.var_4f9f011ff619a4ec.outlineid = outlineenableforteam(self, params.eattacker.team, "outline_nodepth_yellow", "killstreak_personal");
          callback::add("on_zombie_ai_killed", &function_7f596f826857ba59);
          thread function_9ba961a6e3ab1626();
          var_44f17edf8b3e3676 = 1;
        }
      }

      if(!istrue(var_44f17edf8b3e3676) && isDefined(level.var_4f9f011ff619a4ec) && isDefined(params.eattacker) && isDefined(level.var_4f9f011ff619a4ec.targetenemy) && level.var_4f9f011ff619a4ec.targetenemy == self) {
        adjusteddamage = params.idamage * getdvarfloat(@ "hash_25304dae1b5c571d", 1.33);

        if(self.health - adjusteddamage <= 0) {
          if(isDefined(params.shitloc) && isDefined(params.smeansofdeath) && isDefined(params.vpoint) && damage_utility::isheadshot(params.shitloc, params.smeansofdeath, params.eattacker)) {
            object = magicgrenademanual("jup_frag_grenade_ob_s3rr", params.vpoint, (0, 0, -10), 0.1, params.eattacker);
            object.var_6e0c7f83386c8ba8 = 1;
          }
        }

        finaldamage = adjusteddamage;
      }
    }
  }

  if(!isDefined(adjusteddamage)) {
    adjusteddamage = finaldamage;
  }

  if(function_c3d2fefa443b3a22(self) && !istrue(params.var_feef4b237a6beb07) && (params.shitloc == "head" || params.shitloc == "neck" || params.shitloc == "helmet") && params.smeansofdeath != "MOD_MELEE") {
    if(params.idflags & 262144) {
      weapondamagetype = 2;
    } else {
      weapondamagetype = 0;
    }

    dmgmodifier = function_59957d924fbc58e0(params.objweapon, params.shitloc, weapondamagetype);

    if(isDefined(dmgmodifier) && dmgmodifier != 0) {
      adjusteddamage /= dmgmodifier;
    }
  }

  return finaldamage;
}

function function_9ba961a6e3ab1626() {
  level endon("game_ended");
  self endon("damage_object_target_removed");
  self endon("death");
  waitduration = getdvarfloat(@ "hash_3ab76cf18de32a3d", 25);
  wait waitduration;

  if(function_86ad25ccb2d7b424(self)) {
    thread function_aed2b6f8e6517b8d();
  }
}

function function_86ad25ccb2d7b424(var_230b78108b98d0fd) {
  return isDefined(var_230b78108b98d0fd) && isDefined(level.var_4f9f011ff619a4ec) && isDefined(level.var_4f9f011ff619a4ec.targetenemy) && var_230b78108b98d0fd == level.var_4f9f011ff619a4ec.targetenemy;
}

function private function_7f596f826857ba59(params) {
  if(function_86ad25ccb2d7b424(self)) {
    thread function_aed2b6f8e6517b8d();
  }
}

function private function_aed2b6f8e6517b8d() {
  level endon("game_ended");
  self endon("damage_object_target_removed");
  wait 0.5;

  if(isDefined(level.var_4f9f011ff619a4ec)) {
    function_90e5471028a3f70d(1);
  }
}

function function_aee09905df73108() {
  level.var_e0eabcf3e2b9c0da = getStruct("rr_damage_object_proximity_spawn", "targetname");
  level.var_5a23243b27ec2602 = getStruct("rr_movement_object_proximity_spawn", "targetname");
  level.var_49a91aa847fad815 = getStruct("rr_vision_object_proximity_spawn", "targetname");
  var_af3f89771327058a = getnoentvolumearray("rr_damage_object_proximity_trigger", "targetname");
  var_fd36a7d73b0695a2 = getnoentvolumearray("rr_movement_object_proximity_trigger", "targetname");
  var_af610f07aac25c21 = getnoentvolumearray("rr_vision_object_proximity_trigger", "targetname");

  if(isarray(var_af3f89771327058a) && var_af3f89771327058a.size > 0) {
    foreach(var_e49ce046b0ea3e3d in var_af3f89771327058a) {
      thread function_67a4fbdf5f4c5d94(var_af3f89771327058a[0]);
      break;
    }
  }

  if(isarray(var_fd36a7d73b0695a2) && var_fd36a7d73b0695a2.size > 0) {
    foreach(var_ed6902a570df45a5 in var_fd36a7d73b0695a2) {
      thread function_c783cee7dbc9575c(var_fd36a7d73b0695a2[0]);
      break;
    }
  }

  if(isarray(var_af610f07aac25c21) && var_af610f07aac25c21.size > 0) {
    foreach(var_6ccb60434f6c1c28 in var_af610f07aac25c21) {
      thread function_eb6c4f407b06d7d7(var_af610f07aac25c21[0]);
      break;
    }
  }
}

function function_67a4fbdf5f4c5d94(var_e49ce046b0ea3e3d) {
  level endon("game_ended");
  self endon("death");

  while(true) {
    var_e49ce046b0ea3e3d waittill("trigger", ent);

    if(isPlayer(ent)) {
      if(!istrue(self.var_e7d1ea8c5f5eae24)) {
        self.var_e7d1ea8c5f5eae24 = 1;
        var_9919b2cae1b0b78 = ai_spawn_director::spawn_request("ai_encounter:" + "enc_ob_s3_hydro_rift_run_damage", level.var_e0eabcf3e2b9c0da.origin, level.var_e0eabcf3e2b9c0da.radius, 0, 1);
        function_fc38783a3da0bc71(var_9919b2cae1b0b78, 1);
        break;
      }
    }

    wait 0.1;
  }
}

function function_c783cee7dbc9575c(var_ed6902a570df45a5) {
  level endon("game_ended");
  self endon("death");

  while(true) {
    var_ed6902a570df45a5 waittill("trigger", ent);

    if(isPlayer(ent)) {
      if(!istrue(self.var_883d2ecf94f85a5f)) {
        self.var_883d2ecf94f85a5f = 1;
        var_564b8996b53e8223 = ai_spawn_director::spawn_request("ai_encounter:" + "enc_ob_s3_hydro_rift_run_movement", level.var_5a23243b27ec2602.origin, level.var_5a23243b27ec2602.radius, 0, 1);
        function_fc38783a3da0bc71(var_564b8996b53e8223, 1);
        break;
      }
    }

    wait 0.1;
  }
}

function function_eb6c4f407b06d7d7(var_6ccb60434f6c1c28) {
  level endon("game_ended");
  self endon("death");

  while(true) {
    var_6ccb60434f6c1c28 waittill("trigger", ent);

    if(isPlayer(ent)) {
      if(!istrue(self.var_4b0148bc226207d2)) {
        self.var_4b0148bc226207d2 = 1;
        var_2145bda107ad1c2a = ai_spawn_director::spawn_request("ai_encounter:" + "enc_ob_s3_hydro_rift_run_vision", level.var_49a91aa847fad815.origin, level.var_49a91aa847fad815.radius, 0, 1);
        function_fc38783a3da0bc71(var_2145bda107ad1c2a, 1);
        break;
      }
    }

    wait 0.1;
  }
}

function weakpoint_setup() {
  weakpoint_structs = getStructArray("arteryspawn", "targetname");
  level.var_85a85964b56787d8 = [];
  level.weakpoints_destroyed = 0;

  foreach(struct in weakpoint_structs) {
    navmesh_pos = getclosestpointonnavmesh(struct.origin);
    ground_pos = getgroundposition(navmesh_pos, 1);
    rayinfo = trace::ray_trace(ground_pos + (0, 0, 12), ground_pos - (0, 0, 999));
    raynormal = rayinfo["normal"];
    weakpoint = spawnscriptable("jup_zm_rift_weakpoint", ground_pos - (0, 0, 1), raynormal);
    weakpoint setscriptablepartstate("body", "spawned");
    weakpoint.shield = utility::spawn_model("jup_zm_weakpoint_shell", ground_pos - (0, 0, 1), raynormal);
    weakpoint.shield solid();
    weakpoint.shield.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_rift_weakpoint_healthbar");
    weakpoint.shield.subclass_scriptbundle = getscriptbundle(%"hash_1e1140be0648fb42");
    weakpoint.shield.subclass = weakpoint.shield.subclass_scriptbundle.name;
    weakpoint.shield setCanDamage(1);
    weakpoint.shield.health = 100;
    weakpoint.shield.navobstacleid = createnavobstaclebyent(weakpoint.shield);
    weakpoint thread function_dd1de37a34de7820(weakpoint.shield);
    weakpoint.spore_base = spawnscriptable("jup_ob_zombie_control_spore_base", ground_pos, raynormal);
    level.var_85a85964b56787d8 = array_add(level.var_85a85964b56787d8, weakpoint);
    weakpoint.shield.identifier = "jup_zm_rift_weakpoint";
    weakpoint.shield.weakpoint = weakpoint;
    weakpoint callback::add("shield_damaged", &function_14a1d8fbf92cd97);
    weakpoint.health = 3500;
    weakpoint setscriptablepartstate("health", "damage_detect");
    weakpoint function_2ade3efda3f3e3bc();
  }
}

function function_dd1de37a34de7820(e_shield) {
  self endon("death");

  while(isalive(e_shield)) {
    e_shield waittill("damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, weapon, sorigin, angles, normal, einflictor, eventid);
    e_shield.health = 100;
    thread weakpoint_damage(einflictor, attacker, self, damage, idflags, smeansofdeath, weapon, normal, point);
  }
}

function function_14a1d8fbf92cd97(params) {
  if(isDefined(params.instance.shield_health) && params.instance.shield_health > 0) {
    if(!isPlayer(params.eattacker)) {
      return;
    }

    params.instance.shield_health -= params.idamage;

    if(mp_agent_damage::function_87c3b43d00319847()) {
      mp_agent_damage::function_c54b2cc2e762c201(params.eattacker, params.instance.shield, "none", "MOD_BULLET", params.einflictor.weapon_object, int(params.idamage), undefined, 0, undefined, 0, 1);
    }

    params.eattacker scripts\cp_mp\damagefeedback::updatehitmarker("hitresolute", params.instance.health <= 0, 0, 0, undefined);
    params.instance.shield setscriptablepartstate("shell_damage", "impact");

    if(params.instance.shield_health >= 75 && params.instance.shield_health < 100) {
      params.instance.shield setscriptablepartstate("damage_states", "damage_state_1");
    } else if(params.instance.shield_health >= 50 && params.instance.shield_health < 75) {
      params.instance.shield setscriptablepartstate("damage_states", "damage_state_2");
    }

    if(params.instance.shield_health >= 25 && params.instance.shield_health < 50) {
      params.instance.shield setscriptablepartstate("damage_states", "damage_state_3");
    }

    if(params.instance.shield_health <= 0) {
      params.instance function_fcdc6d558cd9541b();
    }
  }
}

function weakpoint_damage(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  level endon("game_ended");
  instance endon("death");

  if(!utility::is_equal(instance.type, "jup_zm_rift_weakpoint") || istrue(instance.destroyed)) {
    return;
  }

  if(!isPlayer(eattacker) && isPlayer(eattacker.owner)) {
    eattacker = eattacker.owner;
  }

  if(isDefined(instance.shield_health) && instance.shield_health > 0) {
    playFX(level._effect["shield_impact"], shitloc, vdir);
    instance setscriptablepartstate("spore_damage", "impact_nodamage");
  }

  if(!function_80f3ebd3a5b5b432() && is_equal(instance.type, "jup_zm_rift_weakpoint")) {
    immune_feedback(eattacker, instance, smeansofdeath, objweapon);
    return;
  }

  if(isDefined(objweapon) && weapon::iswonderweapon(objweapon)) {
    idamage = function_52ea26c480070741(idamage);
  }

  if(function_80f3ebd3a5b5b432() && is_equal(instance.type, "jup_zm_rift_weakpoint")) {
    if(instance.shielded_state == "active") {
      if(isDefined(instance.health) && isDefined(einflictor) && einflictor.classname == "worldspawn" && !isDefined(objweapon)) {
        params = spawnStruct();
        params.eattacker = eattacker;
        params.einflictor = einflictor;
        params.idamage = 34;
        params.instance = instance;
        instance scripts\common\callbacks::callback("shield_damaged", params);
        return;
      }

      immune_feedback(eattacker, instance, smeansofdeath, objweapon);
      return;
    }

    instance.health -= idamage;

    if(instance.health <= 0) {
      instance.health = 0;
      instance.shield.var_1e0eb63ecb3f1e2 = 0;
      instance.destroyed = 1;
      instance setscriptablepartstate("body", "destroyed");
      instance setscriptablepartstate("ground_vfx", "disabled");
      instance scripts\cp_mp\calloutmarkerping::function_6bc4f6b579285f79();
      instance.shield notsolid();
      level.weakpoints_destroyed++;
      wait 0.1;
      var_29b6154315f4469 = 500;
      var_a4bdc2718d388075 = instance.origin;
      radiusdamage(var_a4bdc2718d388075, var_29b6154315f4469, 200, 100);
      var_e724d95f4de4fdb5 = getaiarrayinradius(var_a4bdc2718d388075, var_29b6154315f4469, "team_two_hundred");

      foreach(ai in var_e724d95f4de4fdb5) {
        ai namespace_db1ce2c035564e2c::knockdown_ai(var_a4bdc2718d388075);
      }

      if(level.weakpoints_destroyed >= level.var_85a85964b56787d8.size) {
        level notify("weakpoints_completed");
        level.rift_heart function_f9d964480130473f();
      } else {
        level.rift_heart.shield setscriptablepartstate("damage_states", "damage_state_" + level.weakpoints_destroyed + 1);
      }
    }

    instance.shield.fake_health = instance.health;
    instance setscriptablepartstate("spore_damage", "impact");

    if(isPlayer(eattacker)) {
      if(mp_agent_damage::function_87c3b43d00319847()) {
        mp_agent_damage::function_c54b2cc2e762c201(eattacker, instance.shield, "none", smeansofdeath, objweapon, int(idamage), undefined, 0, undefined, 0, 0);
      }

      eattacker scripts\cp_mp\damagefeedback::updatehitmarker("standard", instance.health <= 0, 0, 0, undefined);
    }

    playFX(level._effect["spore_impact"], shitloc, vdir);
    return;
  }
}

function function_fcdc6d558cd9541b() {
  self endon("death");
  self notify("unshielded");
  self.shield solid();
  self.shield setscriptablepartstate("damage_states", "damage_state_4");
  self.shielded_state = "inactive";
  self.shield setscriptablepartstate("shield", "destroyed");
  self setscriptablepartstate("shield", "unshielded");
  self setscriptablepartstate("ground_vfx", "active");
  self.shield.var_1e0eb63ecb3f1e2 = 1;
  self.shield.var_4919d15787f01154 = 1;
  self.shield.fake_health = 3500;
  self.shield.health = self.shield.fake_health;
  self.shield.max_fake_health = 3500;
}

function function_2ade3efda3f3e3bc() {
  self endon("death");
  function_d584abd69d6909cc();
  self.shield.health = 100;
}

function function_d584abd69d6909cc() {
  self endon("death");
  self.shield endon("death");

  if(!isDefined(self.shield)) {
    return;
  }

  self notify("shielded");
  self.shield solid();
  self.shielded_state = "active";
  self.shield_health = 100;
  self.shield setscriptablepartstate("shield", "shielded");
  self setscriptablepartstate("shield", "shielded");
  self.shield.var_4919d15787f01154 = 0;
  self.shield.var_1e0eb63ecb3f1e2 = 0;
  self.shield.fake_health = 100;
  self.shield.max_fake_health = 100;
}

function private function_80f3ebd3a5b5b432() {
  return true;
}

function function_4bb2f4017b25f5d3() {
  heart_struct = getStruct("heartspawn", "targetname");
  navmesh_pos = getclosestpointonnavmesh(heart_struct.origin);
  ground_pos = getgroundposition(navmesh_pos, 1);
  rayinfo = trace::ray_trace(ground_pos + (0, 0, 12), ground_pos - (0, 0, 999));
  raynormal = rayinfo["normal"];
  rift_heart = spawnscriptable("jup_zm_rift_heart", ground_pos - (0, 0, 1), raynormal);
  rift_heart setscriptablepartstate("body", "spawned");
  rift_heart.shield = utility::spawn_model("jup_zm_heart_shell", ground_pos - (0, 0, 1), raynormal);
  rift_heart.shield solid();
  rift_heart.shield.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_rift_heart_healthbar");
  rift_heart.shield.subclass_scriptbundle = getscriptbundle(%"hash_29ceeef6c31e0bfb");
  rift_heart.shield.subclass = rift_heart.shield.subclass_scriptbundle.name;
  rift_heart.shield setCanDamage(1);
  rift_heart.shield.health = 7000;
  rift_heart.shield.navobstacleid = createnavobstaclebyent(rift_heart.shield);
  rift_heart thread function_efa5b8e5e2cb6d3c(rift_heart.shield);
  rift_heart.spore_base = spawnscriptable("jup_ob_zombie_control_spore_base", ground_pos, raynormal);
  level.rift_heart = rift_heart;
  rift_heart.shield.identifier = "jup_zm_rift_heart";
  rift_heart.shield.weakpoint = rift_heart;
  rift_heart callback::add("heart_shield_damaged", &function_8d1334d4c835a5b);
  rift_heart.health = 8000;
  rift_heart setscriptablepartstate("health", "damage_detect");
  rift_heart function_4205fad7b0bab020();
  rift_heart thread function_8ebaa43ed2640274();
}

function function_8ebaa43ed2640274() {
  level endon("game_ended");
  level waittill("weakpoints_completed");
  level.rift_heart setscriptablepartstate("ground_vfx", "active");
  level waittill("heart_destroyed");
  level.rift_heart setscriptablepartstate("ground_vfx", "disabled");
  a_players = level.players[0] scripts\cp_mp\utility\squad_utility::getsquadmembers();

  foreach(player in a_players) {
    player thread scripts\mp\utility\points::doscoreevent(#"hash_8b55b9bb7da6faf9");
  }

  thread function_eb58b3302b0dcfb8();
}

function function_efa5b8e5e2cb6d3c(e_shield) {
  self endon("death");

  while(isalive(e_shield)) {
    e_shield waittill("damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, weapon, sorigin, angles, normal, einflictor, eventid);
    e_shield.health = 7000;
    thread function_5afb26d090949fc3(einflictor, attacker, self, damage, idflags, smeansofdeath, weapon, normal, point);
  }
}

function function_8d1334d4c835a5b(params) {
  if(isDefined(params.instance.shield_health) && params.instance.shield_health > 0) {
    if(!isPlayer(params.eattacker)) {
      return;
    }

    params.instance.shield_health -= params.idamage;

    if(mp_agent_damage::function_87c3b43d00319847()) {
      mp_agent_damage::function_c54b2cc2e762c201(params.eattacker, params.instance.shield, "none", "MOD_BULLET", params.einflictor.weapon_object, int(params.idamage), undefined, 0, undefined, 0, 1);
    }

    params.eattacker scripts\cp_mp\damagefeedback::updatehitmarker("hitresolute", params.instance.health <= 0, 0, 0, undefined);
    params.instance.shield setscriptablepartstate("shell_damage", "impact");

    if(params.instance.shield_health >= 5250 && params.instance.shield_health < 7000) {
      params.instance.shield setscriptablepartstate("damage_states", "damage_state_1");
    } else if(params.instance.shield_health >= 3500 && params.instance.shield_health < 5250) {
      params.instance.shield setscriptablepartstate("damage_states", "damage_state_2");
    }

    if(params.instance.shield_health >= 1750 && params.instance.shield_health < 3500) {
      params.instance.shield setscriptablepartstate("damage_states", "damage_state_3");
    }

    if(params.instance.shield_health <= 0) {
      params.instance function_f9d964480130473f();
    }
  }
}

function function_5afb26d090949fc3(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  level endon("game_ended");
  instance endon("death");

  if(!utility::is_equal(instance.type, "jup_zm_rift_heart") || istrue(instance.destroyed)) {
    return;
  }

  if(!isPlayer(eattacker) && isPlayer(eattacker.owner)) {
    eattacker = eattacker.owner;
  }

  if(instance.shielded_state == "active") {
    playFX(level._effect["shield_impact"], shitloc, vdir);
    instance setscriptablepartstate("spore_damage", "impact_nodamage");
  }

  if(!function_86305a10c0580c9() && is_equal(instance.type, "jup_zm_rift_heart")) {
    immune_feedback(eattacker, instance, smeansofdeath, objweapon);
    return;
  }

  if(isDefined(objweapon) && weapon::iswonderweapon(objweapon)) {
    idamage = function_52ea26c480070741(idamage);
  }

  if(function_86305a10c0580c9() && is_equal(instance.type, "jup_zm_rift_heart")) {
    if(instance.shielded_state == "active") {
      params = spawnStruct();
      params.eattacker = eattacker;
      params.einflictor = einflictor;
      params.idamage = idamage > 300 ? 300 : idamage;
      params.instance = instance;
      instance scripts\common\callbacks::callback("heart_shield_damaged", params);
      return;
    }

    instance.health -= idamage;

    if(instance.health <= 0) {
      instance.health = 0;
      instance.shield.var_1e0eb63ecb3f1e2 = 0;
      instance.destroyed = 1;
      instance setscriptablepartstate("body", "destroyed");
      instance scripts\cp_mp\calloutmarkerping::function_6bc4f6b579285f79();
      level notify("heart_destroyed");
      instance.shield notsolid();
      wait 0.1;
      var_47a1c3b9ba11cdeb = 1000;
      var_6c50b9f4f4172857 = instance.origin;
      radiusdamage(var_6c50b9f4f4172857, var_47a1c3b9ba11cdeb, 400, 200);
      var_227c6710f39c1f7 = getaiarrayinradius(var_6c50b9f4f4172857, var_47a1c3b9ba11cdeb, "team_two_hundred");

      foreach(ai in var_227c6710f39c1f7) {
        ai namespace_db1ce2c035564e2c::knockdown_ai(var_6c50b9f4f4172857);
      }
    }

    instance.shield.fake_health = instance.health;
    instance setscriptablepartstate("spore_damage", "impact");

    if(isPlayer(eattacker)) {
      if(mp_agent_damage::function_87c3b43d00319847()) {
        mp_agent_damage::function_c54b2cc2e762c201(eattacker, instance.shield, "none", smeansofdeath, objweapon, int(idamage), undefined, 0, undefined, 0, 0);
      }

      eattacker scripts\cp_mp\damagefeedback::updatehitmarker("standard", instance.health <= 0, 0, 0, undefined);
    }

    playFX(level._effect["heart_impact"], shitloc, vdir);
    return;
  }
}

function function_f9d964480130473f() {
  self endon("death");
  self notify("unshielded");
  self.shield solid();
  self.shield setscriptablepartstate("damage_states", "damage_state_4");
  self.shielded_state = "inactive";
  self.shield setscriptablepartstate("shield", "destroyed");
  self setscriptablepartstate("shield", "unshielded");
  self.shield.var_1e0eb63ecb3f1e2 = 1;
  self.shield.var_4919d15787f01154 = 1;
  self.shield.fake_health = 8000;
  self.shield.health = self.shield.fake_health;
  self.shield.max_fake_health = 8000;
}

function function_9e433ff809422ffa() {
  level endon("game_ended");
  self endon("weakpoints_defeated");
  level waittill("players_near_heart");
  thread scripts\cp_mp\overlord::playevent("s3_rr_heart_exposed", level.players, 0.5);
}

function function_4205fad7b0bab020() {
  self endon("death");
  function_d62cb671e89b8e98();
  self.shield.health = 7000;
}

function function_d62cb671e89b8e98() {
  self endon("death");
  self.shield endon("death");

  if(!isDefined(self.shield)) {
    return;
  }

  self notify("shielded");
  self.shield solid();
  self.shielded_state = "active";
  self.shield_health = 7000;
  self.shield setscriptablepartstate("shield", "shielded");
  self setscriptablepartstate("shield", "shielded");
  self.shield.var_4919d15787f01154 = 0;
  self.shield.var_1e0eb63ecb3f1e2 = 0;
  self.shield.fake_health = 7000;
  self.shield.max_fake_health = 7000;
}

function private function_86305a10c0580c9() {
  if(level.weakpoints_destroyed >= level.var_85a85964b56787d8.size) {
    return 1;
  }

  return 0;
}

function immune_feedback(eattacker, instance, smeansofdeath, objweapon) {
  if(isPlayer(eattacker)) {
    if(mp_agent_damage::function_73075c88c97d2d50() && mp_agent_damage::function_87c3b43d00319847()) {
      mp_agent_damage::function_c54b2cc2e762c201(eattacker, instance.shield, "none", smeansofdeath, objweapon, int(0), undefined, 1, undefined, 0, 0);
      eattacker scripts\cp_mp\damagefeedback::updatehitmarker("standard", instance.health <= 0, 0, 0, undefined);
      return;
    }

    eattacker damagefeedback::updatedamagefeedback("hitimmune", instance.health <= 0, 0);
  }
}

function function_52ea26c480070741(idamage) {
  return int(max(idamage, 500));
}

function function_eb58b3302b0dcfb8() {
  spawnloc = getStructArray("exfil_loc", "targetname");
  agent = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_disciple_s3_rr", level.rift_heart.origin, level.rift_heart.angles, "team_two_hundred");
  level.var_7f26f0ab75172e97 = agent;
  waitframe();
  agent.var_e23d72f180832aa = 1;
  agent function_65cdab0fc78aba8f(level.rift_heart.origin, 4096);
  agent.var_667de86d25eebb9b = 0;
  agent scripts\common\callbacks::add("on_zombie_ai_damaged", &function_904e96c563b1581d);
  agent scripts\common\callbacks::add("on_zombie_ai_killed", &function_157eba852e9f6ccc);
  agent thread[[level.var_a12f0fa2ac033f69]]();
  thread scripts\cp_mp\overlord::playevent("s3_rr_disciple_spawned", level.players, 2.5);

  if(getdvarint(@ "hash_a84538c8ec05d4b5", 0)) {
    thread function_cc7e826eea2852c0(agent);
  }
}

function private function_cc7e826eea2852c0(agent) {
  level endon("<dev string:x1c>");
  agent endon("<dev string:x2e2>");
  wait 5;
  agent dodamage(agent.health - 10, agent.origin);
}

function function_157eba852e9f6ccc(data, isdebug) {
  if(!istrue(isdebug)) {
    self thread[[level.var_104dfa63c8e33c5a]]();
  }

  var_8232fe13bffb624 = istrue(isdebug) ? level.players[0].origin : level.rift_heart.origin;
  reward_placement = namespace_71ca15b739deab72::function_3ae7f99339b96499(var_8232fe13bffb624);
  a_players = level.players[0] scripts\cp_mp\utility\squad_utility::getsquadmembers();
  var_3c99a2a84c4b850f = spawnStruct();
  reward_groups = [];

  foreach(player in a_players) {
    reward_groups[reward_groups.size] = [player];
    player namespace_838b439602b3acc7::function_9db4c37d4f1415f("rift_run_contract_completed", 3);

    if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
      player namespace_838b439602b3acc7::function_9db4c37d4f1415f("rift_run_hard_contract_completed", 3);
    }
  }

  namespace_e8853d3344e33cf6::function_863be9e39e19fe2f(reward_groups, reward_placement, &function_e01530991969a465, undefined, var_3c99a2a84c4b850f);

  if(!istrue(isdebug)) {
    var_3c99a2a84c4b850f waittill("managed_reward_cache_spawn_done", var_e10194ca6271ac0a);
    var_e10194ca6271ac0a waittill("managed_reward_cache_despawned");
  }
}

function function_904e96c563b1581d(sparams) {
  if(istrue(isPlayer(sparams.einflictor)) && istrue(sparams.einflictor.isjuggernaut)) {
    sparams.idamage *= 10;
  }

  if(isDefined(level.var_186478f460903bc9)) {
    foreach(player in level.players) {
      newhealth = self.health - int(sparams.idamage);
      player[[level.var_186478f460903bc9]](newhealth, self.maxhealth);
      player[[level.var_2a85f1809bcaec82]](newhealth);
    }
  }

  if(!istrue(self.var_667de86d25eebb9b) && self.health <= self.maxhealth * 0.33) {
    self.var_667de86d25eebb9b = 1;
    scripts\cp_mp\overlord::playevent("s3_rr_disciple_low_health", level.players);
  }
}

function function_d6be862ee76f002c() {
  level flag_wait("ob_infil_completed");
  level flag_wait("rift_contracts_setup");
  var_3ba758145a58afe0 = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "nexus_activity_joiner_phone");

  foreach(scriptable in var_3ba758145a58afe0) {
    if(scriptable getscriptablehaspart("nexus_activity_joiner_phone")) {
      scriptable setscriptablepartstate("nexus_activity_joiner_phone", "visible_rift_run_s3");
    }
  }
}

function function_3b588416e348d52a(player) {
  self setscriptablepartstate("nexus_activity_joiner_phone", "hidden");
}

function function_6ac5f072c4c17d83(params) {
  namespace_98c7625238714297::function_447c6ab4bea16b52("global", "REV_OB_DOGHOUSE", &namespace_f82e883a38a92b9a::function_58fb23fc08762d69, &namespace_598cc82c0086edc2::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("global", "REV_OB_TURRET_TRAP", &namespace_47d96238dd467828::function_3d88cdeba8222b15, &namespace_f8f9b4e3bd129246::function_fd69cf02ba4d90a2);
}

function function_19986c800d077a36(params) {
  namespace_98c7625238714297::function_447c6ab4bea16b52("contract", "REV_OB_OUTLAST", &namespace_edd624734aa27359::function_42696fef39309a29, &namespace_b891994888212992::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("contract", "REV_OB_BIGBOUNTY", &namespace_1b69156531898c9d::function_d745018e64b6b902, &namespace_af7a8f2b3f9c385::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("contract", "REV_OB_ESCORT_ZOMBIES", &namespace_d38a1af3e02dea2f::function_de62bc27675c1bfc, &namespace_2dce538e06784808::function_fd69cf02ba4d90a2);
  level flag_set("rift_contracts_setup");
}

function function_f0e3823c8c30d665(params) {
  namespace_a877d9296c931711::main();
  function_79eeaeaaa71ade27();

  if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {}
}

function function_e01530991969a465(infostruct) {
  cache = spawnStruct();

  if(getdvarint(@ "hash_bc2abb9e5752e088", 0)) {
    items = function_bc2f4857c90f5344("ob_jup_items_contracts_riftrun_boss_hard_s3", 3);
    common_cache::function_fd95ef820bb2b980(items, cache);
  } else {
    items = function_bc2f4857c90f5344("ob_jup_items_contracts_riftrun_boss_normal_s3", 4);
    common_cache::function_fd95ef820bb2b980(items, cache);
  }

  return cache.contents;
}

function function_79eeaeaaa71ade27() {
  var_f8bf483b77217871 = getStructArray("ob_floater", "targetname");

  foreach(var_5309b78f7ad7d3c4 in var_f8bf483b77217871) {
    if(isDefined(var_5309b78f7ad7d3c4.script_noteworthy)) {
      e_floater = spawn("script_model", var_5309b78f7ad7d3c4.origin);
      e_floater.angles = var_5309b78f7ad7d3c4.angles;
      e_floater.var_fafa04e766ba2e01 = e_floater.origin;
      e_floater.var_3527bee7b3a69a0f = e_floater.angles;
      e_floater.radius = int(default_to(var_5309b78f7ad7d3c4.radius, 200));
      e_floater setModel(var_5309b78f7ad7d3c4.script_noteworthy);
      e_floater thread function_25ec394f5469ed5b();
      e_floater thread function_18954968a63cc736();
      waitframe();
    }
  }
}

function function_25ec394f5469ed5b() {
  self endon("death");
  self endon("pause_floater");
  level endon("game_ended");
  level flag_wait("begin_floater_movement");

  if(self.origin != self.var_fafa04e766ba2e01) {
    self moveTo(self.var_fafa04e766ba2e01, 8, 3, 3);
    wait 8.2;
  }

  while(true) {
    n_move = randomfloatrange(50, 150);
    n_time = randomfloatrange(8, 11);
    self movez(n_move, n_time, 3, 3);
    wait n_time + 0.2;
    n_time = randomfloatrange(8, 11);
    self movez(n_move * -1, n_time, 3, 3);
    wait n_time + 0.2;
  }
}

function function_18954968a63cc736() {
  self endon("death");
  self endon("pause_floater");
  level endon("game_ended");
  level flag_wait("begin_floater_movement");
  wait randomfloatrange(2, 5);

  while(true) {
    n_rotate = randomfloatrange(10, 25);
    n_time = randomfloatrange(8, 11);

    if(utility::cointoss()) {
      n_rotate *= -1;
    }

    self rotateby((n_rotate, n_rotate, n_rotate), n_time);
    wait n_time + 0.2;
    n_time = randomfloatrange(8, 11);
    self rotateby((n_rotate, n_rotate, n_rotate) * -1, n_time);
    wait n_time + 0.2;
  }
}

function function_8814bf1a3819a8de() {
  level flag_wait("drop_powerups");
  var_f6e2fa7c17f84498 = getStructArray("ob_floater_powerup", "targetname");
  offset = scripts\common\powerups::function_edeba0070ca0709e("drop_height_offset");

  foreach(powerup_spawn in var_f6e2fa7c17f84498) {
    if(isDefined(powerup_spawn.script_noteworthy)) {
      var_7c5f128ad799ba66 = anglestoup(powerup_spawn.angles) * offset;
      level scripts\common\powerups::function_d4be622286a198(powerup_spawn.script_noteworthy, powerup_spawn.origin + var_7c5f128ad799ba66, powerup_spawn.angles);
      waitframe();
    }
  }

  level flag_set("begin_floater_movement");
}

function ob_ambient_zombie_waves_setup(difficulty) {
  level notify("ob_ambient_zombie_waves_setup");
  level endon("ob_ambient_zombie_waves_setup");
  level endon("game_ended");
  level endon("end_ambient_zombie_wave_spawn");
  level flag_wait("ob_infil_completed");
  level flag_wait("ai_spawn_director_ambient_setup_done");
  level flag_wait("ob_ambient_spawn_zombie_waves");
  circle_struct = getStruct("ob_circle_start", "targetname");

  if(isDefined(circle_struct) && !isDefined(level.var_c9f71ccc98610c37)) {
    level.var_c9f71ccc98610c37 = scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:enc_ob_s3_hydro_rift_run_ambient_zombie_waves", circle_struct.origin, circle_struct.radius, 1, 0, 0);
    scripts\cp_mp\agents\ai_spawn_director::function_e4a67fe4ddca7ed5(level.var_c9f71ccc98610c37, &function_b6ac8ea8edc4fd12);
    scripts\cp_mp\agents\ai_spawn_director::function_f0cc0f2e6e1d085e(level.var_c9f71ccc98610c37, &function_5b07f0df3762790f);
    scripts\cp_mp\agents\ai_spawn_director::function_f81b7c3f18ef98be(level.var_c9f71ccc98610c37, &function_8894dff666d97dd4);
    function_adcc96a7d541aa36(level.var_c9f71ccc98610c37, 0);

    if(!isDefined(difficulty)) {
      difficulty = "normal";

      if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
        difficulty = "hard";
      }
    }

    function_c27c2d10a4d56c3c(difficulty);
  }
}

function function_c27c2d10a4d56c3c(difficulty) {
  if(isDefined(difficulty)) {
    switch (difficulty) {
      case #"hash_84fcf5e68d7230b2":
      case #"hash_9cecba889d9c8a92":
      default:
        if(isDefined(level.var_c9f71ccc98610c37)) {
          function_d37068aac7785c04(level.var_c9f71ccc98610c37, "ob_rift_run_normal", 1);
          function_d37068aac7785c04(level.var_c9f71ccc98610c37, "ob_rift_run_hard", 0);
        }

        break;
      case #"hash_2cf581a0a28b81c":
      case #"hash_cc9157548a55043c":
        if(isDefined(level.var_c9f71ccc98610c37)) {
          function_d37068aac7785c04(level.var_c9f71ccc98610c37, "ob_rift_run_normal", 0);
          function_d37068aac7785c04(level.var_c9f71ccc98610c37, "ob_rift_run_hard", 1);
        }

        break;
    }
  }
}

function function_bdeae19c34b2be71() {
  if(isDefined(level.var_c9f71ccc98610c37)) {
    function_9950e6e485bf5261(level.var_c9f71ccc98610c37, 0);
  }
}

function function_9a38b0d80b42e271() {
  level endon("game_ended");
  level waittill("heart_destroyed");
  function_bdeae19c34b2be71();
}

function function_b6ac8ea8edc4fd12(requestid, instance, agent, ai_data) {
  circle_struct = getStruct("ob_circle_start", "targetname");

  if(isDefined(circle_struct)) {
    agent function_65cdab0fc78aba8f(circle_struct.origin, circle_struct.radius);
    return;
  }

  agent function_65cdab0fc78aba8f(agent.origin, getdvarint(@ "hash_436fc10ebca82d41", 2048));
}

function function_5b07f0df3762790f(requestid, userdata) {
  requestinfo = function_9a39e23c3c52c2af(requestid);

  if(isDefined(requestinfo.var_a0e7c1e4fa26235e)) {
    if(isDefined(level.var_85a85964b56787d8)) {
      foreach(weakpoint in level.var_85a85964b56787d8) {}
    }
  }

  function_a39e9894083f4513(requestid);
}

function function_8894dff666d97dd4(requestid, userdata, var_9f82bb66fd374ef5) {
  requestdata = function_9a39e23c3c52c2af(requestid);

  if(isDefined(var_9f82bb66fd374ef5) && isDefined(requestdata)) {
    startindex = requestdata.ai.size - var_9f82bb66fd374ef5;
    var_e2a261a9687c87f0 = [];
    aitypes = [];
    currentwave = requestdata.var_a0e7c1e4fa26235e + 1;

    for(i = startindex; i < requestdata.ai.size; i++) {
      aitype = requestdata.ai[i].subclass;

      if(!isDefined(var_e2a261a9687c87f0[aitype])) {
        aitypes[aitypes.size] = aitype;
        var_e2a261a9687c87f0[aitype] = 0;
      }

      var_e2a261a9687c87f0[aitype]++;
    }

    if(!isDefined(level.var_c45e3dbe3f74f8bc)) {
      level.var_c45e3dbe3f74f8bc = spawnStruct();
    }

    level.var_c45e3dbe3f74f8bc.currentwave = currentwave;
    level.var_c45e3dbe3f74f8bc.aitypes = aitypes;
    level.var_c45e3dbe3f74f8bc.var_e2a261a9687c87f0 = var_e2a261a9687c87f0;
  }
}

function function_b2082fcbe629a6f() {
  level endon("game_ended");
  level endon("ob_ambient_spawn_zombie_waves");
  self endon("death");
  self endon("disconnect");

  if(istrue(level.var_cd6e6c63b5805c8e)) {
    return;
  }

  flag_wait("ob_infil_completed");
  filtered_volumes = getnoentvolumearray("rr_starting_platform_trigger", "targetname");

  if(filtered_volumes.size > 0) {
    while(self istouching(filtered_volumes[0])) {
      wait 5;
    }
  }

  level flag_set("ob_ambient_spawn_zombie_waves");
  level.var_cd6e6c63b5805c8e = 1;
  level notify("ob_ambient_spawn_zombie_waves");
}

function function_6c9dbd2f5d5a6f02(msg) {
  if(!isDefined(level.var_e2216b22d5983e18)) {
    level.var_e2216b22d5983e18 = 0;
  }

  x = 10;
  y = 550;
  y += level.var_e2216b22d5983e18 * 15;
  printtoscreen2d(x, y, msg, (1, 1, 1), 1.25);
  level.var_e2216b22d5983e18++;
}

function function_f561c59516243308() {
  level.var_e2216b22d5983e18 = 0;
}

function function_2476244023968f4b() {
  level notify("<dev string:x2eb>");
  level endon("<dev string:x2eb>");
  level endon("<dev string:x1c>");
  level endon("<dev string:x30c>");
  self endon("<dev string:x32d>");
  self endon("<dev string:x2e2>");

  if(!getdvarint(@ "hash_adeb1a5eaaee08ad", 0)) {
    return;
  }

  while(true) {
    waitframe();

    if(!isDefined(level.var_c45e3dbe3f74f8bc)) {
      function_6c9dbd2f5d5a6f02("<dev string:x33b>");
      function_6c9dbd2f5d5a6f02("<dev string:x34d>");
    } else {
      function_6c9dbd2f5d5a6f02("<dev string:x33b>");
      function_6c9dbd2f5d5a6f02("<dev string:x360>" + level.var_c45e3dbe3f74f8bc.currentwave);

      foreach(aitype in level.var_c45e3dbe3f74f8bc.aitypes) {
        function_6c9dbd2f5d5a6f02("<dev string:x371>");
        function_6c9dbd2f5d5a6f02("<dev string:x377>" + aitype + "<dev string:x385>");
        function_6c9dbd2f5d5a6f02("<dev string:x38a>" + level.var_c45e3dbe3f74f8bc.var_e2a261a9687c87f0[aitype]);
      }
    }

    function_f561c59516243308();
  }
}

function function_c449d50a557ece96() {
  level endon("<dev string:x1c>");

  while(true) {
    if(getdvarint(@ "hash_f8526b8d4f7d0390", 0)) {
      function_32d14a03db893f0e();
    }

    if(getdvarint(@ "hash_4e43f13fea4f9cf5", 0)) {
      function_74d9203bdd4fbf1d();
    }

    if(getdvarint(@ "hash_e69fe840f5240665", 0)) {
      function_15ec8cd9c44f4218();
    }

    setDvar(@ "hash_f8526b8d4f7d0390", 0);
    setDvar(@ "hash_4e43f13fea4f9cf5", 0);
    setDvar(@ "hash_e69fe840f5240665", 0);
    wait 0.1;
  }
}

function function_32d14a03db893f0e() {
  level.players[0] scripts\cp_mp\loot\common_inventory::function_4b5b6b5953138fe7(getscriptbundle("<dev string:x396>" + "<dev string:x3a9>"), 1);
  level.players[0] scripts\cp_mp\loot\common_inventory::function_4b5b6b5953138fe7(getscriptbundle("<dev string:x396>" + "<dev string:x3d3>"), 1);
  level.players[0] scripts\cp_mp\loot\common_inventory::function_4b5b6b5953138fe7(getscriptbundle("<dev string:x396>" + "<dev string:x3fc>"), 1);
  params = spawnStruct();
  params.itembundlename = "<dev string:x3a9>";
  level.players[0] on_item_pickup(params);
  params.itembundlename = "<dev string:x3d3>";
  level.players[0] on_item_pickup(params);
  params.itembundlename = "<dev string:x3fc>";
  level.players[0] on_item_pickup(params);

  foreach(obelisk in level.obelisks) {
    obelisk.base activate_obelisk(level.players[0]);
    wait 0.5;
  }
}

function function_74d9203bdd4fbf1d() {
  foreach(weakpoint in level.var_85a85964b56787d8) {
    weakpoint.shield solid();
    weakpoint.shield setscriptablepartstate("<dev string:x426>", "<dev string:x437>");
    weakpoint.shielded_state = "<dev string:x449>";
    weakpoint.shield setscriptablepartstate("<dev string:x455>", "<dev string:x45f>");
    weakpoint setscriptablepartstate("<dev string:x455>", "<dev string:x46c>");
    weakpoint.health = 0;
    weakpoint.shield.var_1e0eb63ecb3f1e2 = 0;
    weakpoint.destroyed = 1;
    weakpoint setscriptablepartstate("<dev string:x47a>", "<dev string:x45f>");
    weakpoint setscriptablepartstate("<dev string:x482>", "<dev string:x2be>");
    level.weakpoints_destroyed++;
    level notify("<dev string:x490>");
  }
}

function function_15ec8cd9c44f4218() {
  function_157eba852e9f6ccc(undefined, 1);
}

# /