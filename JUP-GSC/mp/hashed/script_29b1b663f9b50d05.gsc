/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_29b1b663f9b50d05.gsc
*************************************************/

#using script_1311c5c284dd1537;
#using script_358a96f6175cecc1;
#using script_46fac2e4a783a004;
#using script_66f420400fe7947e;
#using script_79efbd5faf9800b2;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\anim;
#using scripts\mp\animation_suite;
#using scripts\mp\compass;
#using scripts\mp\equipment\at_mine;
#using scripts\mp\equipment\claymore;
#using scripts\mp\equipment\support_box;
#using scripts\mp\equipment\tac_insert;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\equipment\trophy_system;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#namespace mp_grandprix_pm_2;

function main() {
  namespace_484f39bc28c4790f::main();
  namespace_a9c76686b1dafd5e::main();
  namespace_d58b02724ad4110c::main();
  namespace_1e316f64ce872d7a::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_grandprix_pm_2");
  namespace_5633828963c62e57::function_57d6a393b90824dc(300);
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level function_3c37e8e4377aa2b3();
  thread scripts\mp\animation_suite::animationsuite();

  if(getdvarint(@ "hash_8610ccd25560c117") == 0) {
    thread function_22d068ce810e9e17();
    thread function_1369fbf85a2de7bd();
    thread play_movie("mp_grandprix_pm_screens");
    thread setup_vista_driving_boats();
    thread audio_panodes();
  }

  level.var_b6e3760a75368efc = &function_39c509138c3a65db;
  level.var_d39aa4b67cefa0d6 = "sfx_grandprix_car_kill_cam";
  level.var_e583f93d55f32680 = 0;
  level.var_1c6c30ed2a88578b = 0;
  level.var_1c4946ed2a624035 = 6;
  function_4607c63644347235();
  function_d7517c880a88d114();
}

function function_4607c63644347235() {
  var_20ed61b3a7e08776 = getEntArray("prix_sign_bink", "targetname");

  for(i = 0; i < var_20ed61b3a7e08776.size; i++) {
    var_20ed61b3a7e08776[i] hide();
  }
}

function function_1682cf22619a5e55() {
  level waittill("infil_setup_complete");
  var_6120df12544987e8 = getEnt("static_infil_van", "targetname");

  if(gameflag("infil_will_run") && isDefined(var_6120df12544987e8)) {
    var_6120df12544987e8 hide();
  }
}

function play_movie(bink) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

  while(true) {
    if(flag("nuke_bink_done")) {
      break;
    }

    setDvar(@ "hash_d3ee5a6578fe61de", "0");
    playcinematicforalllooping(bink);
    wait 30;
  }
}

#using_animtree("script_model");

function function_22d068ce810e9e17() {
  level.scr_animtree["race_car"] = #animtree;
  level.scr_anim["race_car"]["mp_grandprix_racecar_anim_01"] = % iw9_mp_prop_grandprix_car_01;
  level.scr_anim["race_car"]["mp_grandprix_racecar_anim_02"] = % iw9_mp_prop_grandprix_car_02;
  level.scr_anim["race_car"]["mp_grandprix_racecar_anim_03"] = % iw9_mp_prop_grandprix_car_03;
  level.scr_anim["race_car"]["mp_grandprix_racecar_anim_04"] = % iw9_mp_prop_grandprix_car_04;
  level.scr_anim["race_car"]["mp_grandprix_racecar_anim_05"] = % iw9_mp_prop_grandprix_car_05;
  level.scr_anim["race_car"]["mp_grandprix_racecar_anim_06"] = % iw9_mp_prop_grandprix_car_06;
  level.scr_animtree["driver"] = #animtree;
  level.scr_anim["driver"]["mp_grandprix_racecar_anim_01"] = % iw9_mp_f1_car_driver;
  level.scr_anim["driver"]["mp_grandprix_racecar_anim_02"] = % iw9_mp_f1_car_driver;
  level.scr_anim["driver"]["mp_grandprix_racecar_anim_03"] = % iw9_mp_f1_car_driver;
  level.scr_anim["driver"]["mp_grandprix_racecar_anim_04"] = % iw9_mp_f1_car_driver;
  level.scr_anim["driver"]["mp_grandprix_racecar_anim_05"] = % iw9_mp_f1_car_driver;
  level.scr_anim["driver"]["mp_grandprix_racecar_anim_06"] = % iw9_mp_f1_car_driver;
  addnotetrack_customfunction("race_car", "rumble_ground", &function_ae7105a022f1e8b6, "mp_grandprix_racecar_anim_01");
  addnotetrack_customfunction("race_car", "rumble_ground_light", &function_f9d9efc3970116b5, "mp_grandprix_racecar_anim_01");
  addnotetrack_customfunction("race_car", "rumble_ground_medium", &function_39f4a49d854dcb4, "mp_grandprix_racecar_anim_01");
  addnotetrack_customfunction("race_car", "rumble_ground", &function_ae7105a022f1e8b6, "mp_grandprix_racecar_anim_02");
  addnotetrack_customfunction("race_car", "rumble_ground_light", &function_f9d9efc3970116b5, "mp_grandprix_racecar_anim_02");
  addnotetrack_customfunction("race_car", "rumble_ground_medium", &function_39f4a49d854dcb4, "mp_grandprix_racecar_anim_02");
  addnotetrack_customfunction("race_car", "rumble_ground", &function_ae7105a022f1e8b6, "mp_grandprix_racecar_anim_03");
  addnotetrack_customfunction("race_car", "rumble_ground_light", &function_f9d9efc3970116b5, "mp_grandprix_racecar_anim_03");
  addnotetrack_customfunction("race_car", "rumble_ground_medium", &function_39f4a49d854dcb4, "mp_grandprix_racecar_anim_03");
  addnotetrack_customfunction("race_car", "rumble_ground", &function_ae7105a022f1e8b6, "mp_grandprix_racecar_anim_04");
  addnotetrack_customfunction("race_car", "rumble_ground_light", &function_f9d9efc3970116b5, "mp_grandprix_racecar_anim_04");
  addnotetrack_customfunction("race_car", "rumble_ground_medium", &function_39f4a49d854dcb4, "mp_grandprix_racecar_anim_04");
  addnotetrack_customfunction("race_car", "rumble_ground", &function_ae7105a022f1e8b6, "mp_grandprix_racecar_anim_05");
  addnotetrack_customfunction("race_car", "rumble_ground_light", &function_f9d9efc3970116b5, "mp_grandprix_racecar_anim_05");
  addnotetrack_customfunction("race_car", "rumble_ground_medium", &function_39f4a49d854dcb4, "mp_grandprix_racecar_anim_05");
  addnotetrack_customfunction("race_car", "rumble_ground", &function_ae7105a022f1e8b6, "mp_grandprix_racecar_anim_06");
  addnotetrack_customfunction("race_car", "rumble_ground_light", &function_f9d9efc3970116b5, "mp_grandprix_racecar_anim_06");
  addnotetrack_customfunction("race_car", "rumble_ground_medium", &function_39f4a49d854dcb4, "mp_grandprix_racecar_anim_06");
}

function function_1369fbf85a2de7bd() {
  wait 5;
  setdvarifuninitialized(@ "hash_9a27ef3d3730a41c", 0);
  setdvarifuninitialized(@ "hash_9a27f03d3730a64f", 1);
  setdvarifuninitialized(@ "hash_9a27ed3d37309fb6", 0);
  setdvarifuninitialized(@ "hash_9a27ee3d3730a1e9", 0);
  setdvarifuninitialized(@ "hash_9a27eb3d37309b50", 0);
  level.var_78eaad6c11cf5ac3 = getEntArray("race_car", "targetname");

  setdevdvarifuninitialized(@ "hash_9eccbb3e1dce703", 0);

  if(getdvarint(@ "hash_9eccbb3e1dce703", 0) == 1) {
    level.var_78eaad6c11cf5ac3 = [level.var_78eaad6c11cf5ac3[0]];
  }

  var_cb8b2044f93c5c3c = 1;

  for(i = 0; i < level.var_78eaad6c11cf5ac3.size; i++) {
    car = level.var_78eaad6c11cf5ac3[i];
    car.models = getEntArray(car.script_label, "targetname");

    foreach(var_872fe47787e8589a in car.models) {
      var_872fe47787e8589a linkTo(car);
    }

    car.models[0].damagetrigger = getEnt(car.script_noteworthy, "targetname");
    car.models[0].damagetrigger enablelinkTo();
    car.models[0].damagetrigger linkTo(car.models[0], "tag_origin", (0, -10, -15), (0, 0, 0));
    car.models[0].damagetrigger.var_26fb072855fd4772 = 1;
    car.models[0].damagetrigger.racecar = car.models[0];
    car.models[0].damagetrigger.objweapon = makeweaponfromstring("iw9_racecar_mp");
    car.models[0].guid = "race_car";
    car.models[0] playLoopSound("sfx_grandprix_car_tires");
    car.origin = (1144, 168, 0);
    car.models[0].origin = car.origin;
    car.num = var_cb8b2044f93c5c3c;
    var_cb8b2044f93c5c3c++;
    car.models[0] thread function_222613941733a387();
    driver = function_a4862756ad873b3d(car.models[0].targetname);
    car.models[0].driver = car.models[0] spawn_anim_model("driver", "TAG_BODY_ANIMATE", driver);
    car.models[0].driver thread function_e6e40836892a4992();
    car.models[0] thread setupkillcament();
    car.models[0] thread function_29e181f3b6d3f79b(car);
  }

  level thread function_d77ea4eac011b443();
}

function function_d7517c880a88d114() {
  createnavobstaclebybounds((-1819, 2655, 90), (2, 18, 90), (0, 0, 0));
  createnavobstaclebybounds((-1681, 2655, 90), (2, 18, 90), (0, 0, 0));
  createnavobstaclebybounds((-1819, 2200, 90), (2, 18, 90), (0, 0, 0));
  createnavobstaclebybounds((-1681, 2200, 90), (2, 18, 90), (0, 0, 0));
  createnavobstaclebybounds((-2010, 2646, 80), (18, 2, 79), (0, 0, 0));
  createnavobstaclebybounds((-2010, 2217, 80), (18, 2, 79), (0, 0, 0));
  createnavobstaclebybounds((-2015, 1483, 80), (18, 2, 79), (0, 0, 0));
  createnavobstaclebybounds((-2015, 1213, 80), (18, 2, 79), (0, 0, 0));
}

function function_a4862756ad873b3d(var_75ffed1210f37c40) {
  switch (var_75ffed1210f37c40) {
    case #"hash_ee19ed7e6375623e":
      return "body_civ_driver_hancock_1_1";
    case #"hash_ee19ec7e637560ab":
      return "body_civ_driver_rohan_oil_1_1";
    case #"hash_ee19eb7e63755f18":
      return "body_civ_driver_nejera_1_1";
    case #"hash_ee19f27e63756a1d":
      return "body_civ_driver_hong_energy_1_1";
    case #"hash_ee19f17e6375688a":
      return "body_civ_driver_cyclosa_1_1";
    case #"hash_ee19f07e637566f7":
      return "body_civ_driver_rohan_oil_1_2";
    default:
      return "body_civ_driver_hancock_1_1";
  }
}

function spawn_anim_model(animname, linkto_ent, body, head, weapon) {
  male = 1;

  if(cointoss()) {
    male = 0;
  }

  guy = spawn("script_model", (0, 0, 0));
  guy setModel(body);
  guy.animname = animname;
  guy setanimtree();

  if(isDefined(linkto_ent)) {
    guy linkTo(self, linkto_ent, (0, 0, 0), (0, 0, 0));
  }

  return guy;
}

function function_222613941733a387() {
  self.animname = "race_car";
  self useanimtree(level.scr_animtree["race_car"]);
  self forcenetfieldhighlod(1);
  self setmoveroptimized(1);
  self setmoverantilagged(1);
  self markkeyframedmover();
  thread function_dc5946b409cbe7bc();
  thread function_79148c48a2ad61c1();
  thread function_ff213d6711860e73();
}

function function_e6e40836892a4992() {
  self.animname = "driver";
  self useanimtree(level.scr_animtree["driver"]);
  self forcenetfieldhighlod(1);
  self setmoveroptimized(1);
  self setmoverantilagged(1);
  self markkeyframedmover();
}

function function_d77ea4eac011b443() {
  wait 1;
  level notify("endRaceCarsAnim");
  level endon("endRaceCarsAnim");
  animlength = getanimlength(level.scr_anim["race_car"]["mp_grandprix_racecar_anim_01"]);
  waittime = animlength + 1;

  while(true) {
    level thread function_ce9ff82618a76813(waittime);
    level.var_e583f93d55f32680 = 0;

    if(isDefined(level.var_1c4946ed2a624035) && isDefined(level.var_1c6c30ed2a88578b)) {
      level.var_e583f93d55f32680 = randomintrange(level.var_1c6c30ed2a88578b, level.var_1c4946ed2a624035);
    }

    foreach(car in level.var_78eaad6c11cf5ac3) {
      var_1193748b3fe9d956 = string(car.num);
      car thread scripts\common\anim::anim_single_solo(car.models[0], "mp_grandprix_racecar_anim_0" + var_1193748b3fe9d956);
      car.models[0] thread scripts\common\anim::anim_single_solo(car.models[0].driver, "mp_grandprix_racecar_anim_0" + var_1193748b3fe9d956, "TAG_BODY_ANIMATE");

      if(isDefined(car.var_93fe105a9275bd0f)) {
        car.var_93fe105a9275bd0f notify("link_sfx");
      }

      wait getdvarfloat(hashcat(@ "hash_960b89febe9ec746", var_1193748b3fe9d956), 0);
    }

    level waittill_any_timeout_1(waittime, "carFinishedLap");
    wait level.var_e583f93d55f32680;
  }
}

function function_29e181f3b6d3f79b(car) {
  wait 1;
  sndalias = "sfx_grandprix_car_";
  animlength = getanimlength(level.scr_anim["race_car"]["mp_grandprix_racecar_anim_01"]);
  waittime = animlength + 1;
  var_dfe13dccd8f66a73 = 0;
  wait waittime - 1.3;

  while(true) {
    if(soundexists(sndalias + car.num)) {
      level.var_dfe13dccd8f66a73 = var_dfe13dccd8f66a73 % 2;
      var_dfe13dccd8f66a73++;
      var_a6afea87679e66d7 = (-12223, -2985, 58);

      if(!isDefined(car.sfx1)) {
        car.sfx1 = spawn("script_model", var_a6afea87679e66d7);
        car.sfx2 = spawn("script_model", var_a6afea87679e66d7);
      }

      if(var_dfe13dccd8f66a73 > 0) {
        car.var_93fe105a9275bd0f = car.sfx1;
      } else {
        car.var_93fe105a9275bd0f = car.sfx2;
      }

      car.var_93fe105a9275bd0f moveTo(var_a6afea87679e66d7, 0.1);
      car.var_93fe105a9275bd0f playsoundonmovingent(sndalias + car.num);
      car.var_93fe105a9275bd0f waittill("link_sfx");
      wait 0.4;
      car.var_93fe105a9275bd0f moveTo(self.origin, 0.05);
      car.var_93fe105a9275bd0f linkTo(self);
      wait waittime + level.var_e583f93d55f32680 - 2;
      car.var_93fe105a9275bd0f unlink();
      car.var_93fe105a9275bd0f moveTo((-3554.84, 7727.81, 29.056), 0.1);
    }

    wait 0.1;
  }
}

function function_ce9ff82618a76813(waittime) {
  wait waittime + 1;
  waitframe();
  level notify("carFinishedLap");
}

function function_ae7105a022f1e8b6(racecar) {
  nearbyplayers = utility::playersincylinder(racecar.origin, 165, undefined);

  foreach(player in nearbyplayers) {
    player earthquakeforplayer(0.2, 1, player.origin, 165);
    player setclientomnvar("ui_hud_shake", 1);
    player playrumbleonpositionforclient("artillery_rumble", player.origin);
  }
}

function function_39f4a49d854dcb4(racecar) {
  nearbyplayers = utility::playersincylinder(racecar.origin, 200, undefined);

  foreach(player in nearbyplayers) {
    player earthquakeforplayer(0.2, 1, player.origin, 200);
    player setclientomnvar("ui_hud_shake", 1);
    player playrumbleonpositionforclient("artillery_rumble_light", player.origin);
  }
}

function function_f9d9efc3970116b5(racecar) {
  nearbyplayers = utility::playersincylinder(racecar.origin, 500, undefined);

  foreach(player in nearbyplayers) {
    player earthquakeforplayer(0.15, 1, player.origin, 500);
    player setclientomnvar("ui_hud_shake", 1);
    player playrumbleonpositionforclient("artillery_rumble_light", player.origin);
  }
}

function audio_panodes() {
  level endon("game_ended");
  level waittill("connected", player);
  minwaittime = 35;
  maxwaittime = 50;
  audioent = spawn("script_origin", (0, 0, 0));
  enablepaspeaker("grandprix_pa");
  wait 5;

  while(true) {
    audioent playSound("dx_mp_grpx_annc_paan_theracehasbeencancel");
    wait randomfloatrange(minwaittime, maxwaittime);
  }
}

function function_79148c48a2ad61c1() {
  level endon("game_ended");
  racecar = self;
  var_3acea7edc0cff4e9 = racecar getentitynumber();
  var_27b0eea8c969d034 = 65;

  if(getdvarfloat(@ "hash_126b89249d651b7b", 65) != 65) {
    var_27b0eea8c969d034 = getdvarfloat(@ "hash_126b89249d651b7b", 65);
  }

  itemcontents = physics_createcontents(["physicscontents_item"]);
  radiusvector = (var_27b0eea8c969d034, var_27b0eea8c969d034, 65);
  var_646389193279e8ec = [racecar];

  while(true) {
    pointtocheck = racecar.origin + rotatevector((25, 0, -25), racecar.angles);
    aabbmin = pointtocheck - radiusvector;
    aabbmax = pointtocheck + radiusvector;
    var_c857eed1363ba9d = physics_aabbbroadphasequery(aabbmin, aabbmax, itemcontents, var_646389193279e8ec);

    foreach(ent in var_c857eed1363ba9d) {
      if(isDefined(ent.code_classname) && ent.code_classname == "worldspawn") {
        var_c857eed1363ba9d = array_remove(var_c857eed1363ba9d, ent);
      }
    }

    for(i = 0; i < var_c857eed1363ba9d.size; i++) {
      var_424a9176df4df0f4 = var_c857eed1363ba9d[i];

      if(istrue(var_424a9176df4df0f4.markedfordelete)) {
        continue;
      }

      if(isDefined(var_424a9176df4df0f4.var_277487e709ea8386) && isDefined(var_424a9176df4df0f4.var_277487e709ea8386.size)) {
        if(var_424a9176df4df0f4.var_277487e709ea8386.size > 0) {
          if(isDefined(var_424a9176df4df0f4.var_277487e709ea8386[var_3acea7edc0cff4e9])) {
            continue;
          }
        }
      }

      if(isDefined(var_424a9176df4df0f4.equipmentref) && var_424a9176df4df0f4.equipmentref == "equip_tac_cover") {
        if(!var_424a9176df4df0f4 istouching(racecar) && !var_424a9176df4df0f4 istouching(racecar.damagetrigger)) {
          continue;
        }

        var_424a9176df4df0f4 scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 0);
        var_424a9176df4df0f4.markedfordelete = 1;
        continue;
      }

      if(isDefined(var_424a9176df4df0f4.cratetype) && (var_424a9176df4df0f4.cratetype == "killstreak" || var_424a9176df4df0f4.cratetype == "juggernaut")) {
        var_424a9176df4df0f4 scripts\cp_mp\killstreaks\airdrop::destroycrate();
        var_424a9176df4df0f4.markedfordelete = 1;
      }

      if(!var_424a9176df4df0f4 istouching(racecar) && !var_424a9176df4df0f4 istouching(racecar.damagetrigger)) {
        continue;
      }

      if(isDefined(var_424a9176df4df0f4.cratetype) && (var_424a9176df4df0f4.cratetype == "killstreak" || var_424a9176df4df0f4.cratetype == "juggernaut")) {
        function_7c32ec07e4129be9(var_424a9176df4df0f4, racecar, pointtocheck);
        continue;
      }

      if(scripts\mp\utility\entity::isturret(var_424a9176df4df0f4)) {
        if(istrue(var_424a9176df4df0f4.isshuttingdown)) {
          continue;
        }

        var_424a9176df4df0f4 notify("kill_turret", 1);
        var_424a9176df4df0f4.markedfordelete = 1;
      }
    }

    waitframe();
  }
}

function function_cb14f1c7ad456a44(var_424a9176df4df0f4) {
  if(!isDefined(var_424a9176df4df0f4.weapon_name)) {
    return false;
  }

  var_5511188bede8e67a = 0;

  switch (var_424a9176df4df0f4.weapon_name) {
    case #"hash_b82bf6dc767609aa":
    case #"hash_f2e793d6a4fe013e":
    case #"hash_fc6112d8c68cacc6":
      var_5511188bede8e67a = 1;
      break;
  }

  if(var_5511188bede8e67a) {
    return true;
  }

  return false;
}

function item_collision_ignorefutureevent(itement, racecar, duration) {
  if(!isDefined(itement.var_277487e709ea8386)) {
    itement.var_277487e709ea8386 = [];
  }

  var_bb5c27ab2ae871cf = racecar getentitynumber();
  itement.var_277487e709ea8386[var_bb5c27ab2ae871cf] = racecar;
  wait duration;

  if(isDefined(itement) && isDefined(itement.var_277487e709ea8386)) {
    itement.var_277487e709ea8386[var_bb5c27ab2ae871cf] = undefined;
  }

  if(isDefined(itement) && isDefined(itement.var_277487e709ea8386) && itement.var_277487e709ea8386.size == 0) {
    itement.var_277487e709ea8386 = undefined;
  }
}

function function_7c32ec07e4129be9(var_424a9176df4df0f4, racecar, pointtocheck) {
  var_424a9176df4df0f4 scripts\cp_mp\killstreaks\airdrop::destroycrate();
  var_424a9176df4df0f4.markedfordelete = 1;
}

function function_ff213d6711860e73() {
  level endon("game_ended");

  if(!isDefined(level.mines)) {
    level.mines = [];
  }

  racecar = self;
  var_3acea7edc0cff4e9 = racecar getentitynumber();
  var_27b0eea8c969d034 = 150;

  if(getdvarfloat(@ "hash_126b89249d651b7b", 65) != 65) {
    var_27b0eea8c969d034 = getdvarfloat(@ "hash_126b89249d651b7b", 65);
  }

  maxdist = var_27b0eea8c969d034 - 25;
  maxdistsq = maxdist * maxdist;

  while(true) {
    all_mines = level.mines;

    if(all_mines.size > 0) {
      pointtocheck = racecar.origin + rotatevector((375, 0, -100), racecar.angles);

      foreach(mine in all_mines) {
        if(!isDefined(mine)) {
          continue;
        }

        if(istrue(mine.markedfordelete)) {
          continue;
        }

        if(distance2dsquared(mine.origin, pointtocheck) > maxdistsq) {
          continue;
        }

        if(distancesquared(mine.origin, pointtocheck) > maxdistsq) {
          continue;
        }

        if(isDefined(mine.weapon_name)) {
          if(mine.weapon_name == "trophy_mp") {
            mine scripts\mp\equipment\trophy_system::sweeptrophy();
            mine.markedfordelete = 1;
            continue;
          }

          if(mine.weapon_name == "claymore_mp") {
            mine scripts\mp\equipment\claymore::sweepclaymore();
            mine.markedfordelete = 1;
            continue;
          }

          if(mine.weapon_name == "at_mine_mp") {
            mine scripts\mp\equipment\at_mine::at_mine_destroy();
            mine.markedfordelete = 1;
            continue;
          }

          if(mine.weapon_name == "tac_insert_trigger") {
            mine scripts\mp\equipment\tac_insert::deletetacinsert();
            mine.markedfordelete = 1;
            continue;
          }

          if(mine.weapon_name == "armor_box_mp" || mine.weapon_name == "blastshield_box_mp") {
            mine thread scripts\mp\equipment\support_box::supportbox_destroy();
            mine.markedfordelete = 1;
            continue;
          }

          if(mine.weapon_name == "support_box_mp") {
            mine thread scripts\mp\equipment\support_box::supportbox_destroy();
            mine.markedfordelete = 1;
          }
        }
      }
    }

    waitframe();
  }
}

function function_dc5946b409cbe7bc() {
  level endon("game_ended");
  self endon("death");
  self.velocity = (0, 0, 0);

  while(true) {
    self.lastorigin = self.origin;
    wait 0.05;
    self.velocity = (self.origin - self.lastorigin) / 0.05;
  }
}

function function_39c509138c3a65db(var_4c9db30e60a87779, victim) {
  var_4c9db30e60a87779.racecar.owner = victim;
  var_4c9db30e60a87779.owner = victim;
  return victim;
}

function setupkillcament() {
  setdvarifuninitialized(@ "hash_1a5e4af153d0e5bb", 5);
  waitframe();
  campos = self.origin;
  var_349802e026879951 = anglesToForward(self.angles);
  var_5474ce5e528e0c16 = self.origin + var_349802e026879951 * 100;

  if(getdvarint(@ "hash_1a5e4af153d0e5bb", 1) == 1) {
    self.damagetrigger.killcament = self;
    self.damagetrigger.killcamentnum = self.damagetrigger.killcament getentitynumber();
  } else if(getdvarint(@ "hash_1a5e4af153d0e5bb", 1) == 2 || getdvarint(@ "hash_1a5e4af153d0e5bb", 1) == 3) {
    if(getdvarint(@ "hash_1a5e4af153d0e5bb", 1) == 2) {
      var_d1011739f3783b83 = (1422.37, -894.271, 0.0170574);
    } else {
      var_d1011739f3783b83 = (2415.92, -6.72316, 401.567);
    }

    killcament = spawn("script_model", var_d1011739f3783b83);
    killcament setModel("script_model");
    killcament setscriptmoverkillcam("explosive");
    self.damagetrigger.killcament = killcament;
  } else if(getdvarint(@ "hash_1a5e4af153d0e5bb", 1) == 4) {
    function_158a4eddf949ce45(60, -500, 50);
  } else if(getdvarint(@ "hash_1a5e4af153d0e5bb", 1) == 5) {
    function_158a4eddf949ce45(0, -50, 15);
  } else {
    var_7f256d9f9cd2e337 = spawn("script_model", var_5474ce5e528e0c16);
    var_7f256d9f9cd2e337 setModel("script_model");
    var_7f256d9f9cd2e337 setscriptmoverkillcam("missile");
    var_7f256d9f9cd2e337 linkTo(self, "tag_origin");
    var_7f256d9f9cd2e337 fixlinktointerpolationbug(1);
    self.damagetrigger.killcament = var_7f256d9f9cd2e337;
    self.damagetrigger.killcamentnum = var_7f256d9f9cd2e337 getentitynumber();
    self.damagetrigger.var_7f256d9f9cd2e337 = self.damagetrigger.killcament;
  }

  self.damagetrigger.killcament thread debugkillcament(self);
}

function function_158a4eddf949ce45(rightoffset, fwdoffset, zoffset) {
  var_349802e026879951 = anglesToForward(self.angles);
  var_c875b0ee9f8e5f56 = anglestoright(self.angles);
  var_5474ce5e528e0c16 = self.origin + var_c875b0ee9f8e5f56 * rightoffset + var_349802e026879951 * fwdoffset + (0, 0, zoffset);
  killcament = spawn("script_model", var_5474ce5e528e0c16);
  killcament setModel("script_model");
  killcament setscriptmoverkillcam("missile");
  killcament linkTo(self, "tag_origin");
  killcament fixlinktointerpolationbug(1);
  self.damagetrigger.killcament = killcament;
  self.damagetrigger.killcamentnum = self.damagetrigger.killcament getentitynumber();
}

function debugkillcament(visual) {
  self endon("<dev string:x1c>");
  level endon("<dev string:x25>");
  visual endon("<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_3f3a15fb7e7c9b0", 0);

  while(true) {
    if(getdvarint(@ "hash_3f3a15fb7e7c9b0") > 0) {
      line(self.origin, self.origin + anglesToForward(self.angles) * 10, (1, 0, 0));
      line(self.origin, self.origin + anglestoright(self.angles) * 10, (0, 1, 0));
      line(self.origin, self.origin + anglestoup(self.angles) * 10, (0, 0, 1));
      line(visual.origin + (0, 0, 5), self.origin, (0, 0, 1));
      line(visual.origin, visual.origin + anglesToForward(visual.angles) * 10, (1, 0, 0));
      line(visual.origin, visual.origin + anglestoright(visual.angles) * 10, (0, 1, 0));
      line(visual.origin, visual.origin + anglestoup(visual.angles) * 10, (0, 0, 1));

      if(isDefined(visual.damagetrigger.var_7f256d9f9cd2e337)) {
        sphere(visual.damagetrigger.var_7f256d9f9cd2e337.origin, 16, (1, 1, 1));
      }
    }

    waitframe();
  }
}

function setup_vista_driving_boats() {
  wait 10;
  boats = getEntArray("boat_vista", "targetname");
  boatspeed = 0.0125;
  var_530a640121d04623 = 0.0166667;
  wait 2;

  foreach(boat in boats) {
    boat.boatfx = spawn_tag_origin();
    boat.boatfx.origin = boat.origin;
    boat.boatfx.angles = boat.angles;
    boat.boatfx.targetname = "boatFX";
    boat.boatfx show();
    boat.boatfx linkTo(boat);
    wait 0.1;
    thread vista_boat_drive(boat, boatspeed);
    playFXOnTag(level._effect["vfx_grandprix_boat_wake_01"], boat.boatfx, "tag_origin");
  }
}

function vista_boat_drive(boat, boatspeed) {
  currentdest = getStruct(boat.target, "targetname");

  while(true) {
    boatmovetime = abs(distance(boat.origin, currentdest.origin) * boatspeed);
    boat moveTo(currentdest.origin, boatmovetime, 0, 0);
    boat rotateTo(currentdest.angles, boatmovetime, 0, 0);
    currentdest = getStruct(currentdest.target, "targetname");
    wait boatmovetime;
  }
}

function function_3c37e8e4377aa2b3() {
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((-806, 630, 0), 1);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((-806, 366, 0), 1);
}