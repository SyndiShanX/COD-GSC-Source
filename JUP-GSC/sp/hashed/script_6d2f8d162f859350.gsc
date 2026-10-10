/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6d2f8d162f859350.gsc
*************************************************/

#using script_4ab4bd3ef85fb34c;
#using script_71b48ffe76b07d2;
#using scripts\anim\dialogue;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#using scripts\common\ai_lookat;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_paths;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\ai_armor;
#using scripts\sp\anim;
#using scripts\sp\fakeactor;
#using scripts\sp\friendlyfire;
#using scripts\sp\hud_util;
#using scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_lighting;
#using scripts\sp\names;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_death;
#using scripts\sp\starts;
#using scripts\sp\utility;
#namespace namespace_83c86e626c8ec2af;

function ai_cleanup() {
  all = getaiarray();

  foreach(ai in all) {
    if(is_equal(level.price, ai)) {
      continue;
    }

    if(isDefined(ai.magic_bullet_shield)) {
      ai stop_magic_bullet_shield();
    }

    ai delete();
  }
}

function function_af0a8347f91f668b() {
  namespace_47819225b08b445d::spawn_price();
  set_start_location("ambulance_crash__start", [level.price, level.player]);

  foreach(transient in level.var_4291dad1008f93e6) {
    settransientvisibility(transient, 0);
  }
}

function function_9835a9c3e3bb25a7() {
  thread ai_cleanup();
  thread scripted_out_of_bounds();
  thread function_a8895ef20ea2770f();
  stop_exploder("inside_stadium_fx");
  level.player setsoundsubmix("sp_jup_flashback_lower_garage", 3.5);
  function_ead50352908eff14();
  thread price_move();
  thread function_93efb2ca600badef();
  thread function_674ee0e5a75feb4();
  delaythread(1, &function_f638da6fa9cb3ddc);
  function_f26a842bfe69ba4f(&function_1bd6315e1a8930aa);
  function_f26a842bfe69ba4f(&function_379e8db06da9ef7a);
  flag_wait("ambulance_player_interact");
  level notify("player_corrected");
}

function function_a8895ef20ea2770f() {
  level.price function_fc0eb6b81c66c661(1, "dx_sp_flas_mblc_pric_eyespeeledformakarov");
  flag_wait("tunnel_arrive_moveup");
  level.var_74ff7670993d1557 say_delayed(4, "dx_sp_flas_mblc_pric_checkfirethatsacivil");
  level.var_74ff7670993d1557 say_delayed(0.5, "dx_sp_flas_mblc_pric_gettosafetygo");
  flag_wait("ambulance_moveup");
  wait 1;

  if(function_5a7af7691d0b6068()) {
    level.player say_team("dx_sp_flas_mblc_soap_vehicleincoming");
  } else {
    level.price say_team("dx_sp_flas_mblc_pric_vehicleincoming");
  }

  level.price ent_flag_set("doing_nags");
  function_42d02ae823106946();
  wait 0.6;

  if(function_5a7af7691d0b6068()) {
    level.player say_team("dx_sp_flas_mblc_soap_incoming");
  } else {
    level.price say_team("dx_sp_flas_mblc_pric_incoming");
  }

  flag_wait("ambulance_impact");
  wait 2.3;

  if(function_5a7af7691d0b6068()) {
    level.player say_team("dx_sp_flas_mblc_pric_itsdown");
  } else {
    level.price say_team("dx_sp_flas_mblc_soap_itsdown");
  }

  wait 0.6;
  level.price say_team("dx_sp_flas_mblc_pric_movetosecure");
  function_887d5e08f70ba097();
}

function function_887d5e08f70ba097() {
  flag_wait("price_at_ambulance");

  if(flag("ambulance_player_interact")) {
    return;
  }

  level endon("ambulance_player_interact");
  var_e687bba1d1cae639 = create_deck(["dx_sp_flas_mblc_pric_holdingattheambulanc", "dx_sp_flas_mblc_pric_soapgettotheambulanc", "dx_sp_flas_mblc_pric_ineedyouoverhereserg"]);
  var_d8b5ec1d530687e0 = create_deck(["dx_sp_flas_mblc_pric_openit", "dx_sp_flas_mblc_pric_getthedoorillcover", "dx_sp_flas_mblc_pric_openthedoorsoap", "dx_sp_flas_mblc_pric_getitopensergeantmak"]);

  while(true) {
    var_bb1f50a4748e192c = distancesquared(level.player.origin, level.crash_ambulance.origin) < 122500 ? var_d8b5ec1d530687e0 : var_e687bba1d1cae639;
    level.price say_team(var_bb1f50a4748e192c utility::deck_draw());

    if(var_bb1f50a4748e192c == var_e687bba1d1cae639) {
      start = gettime();

      while(true) {
        if(distancesquared(level.player.origin, level.crash_ambulance.origin) < 119025) {
          break;
        }

        if(time_has_passed(start, 7)) {
          break;
        }

        wait 0.15;
      }

      continue;
    }

    wait 7;
  }
}

function function_5a7af7691d0b6068() {
  closest = sortbydistance([level.player, level.price], level.crash_ambulance.origin)[0];
  return closest == level.player && utility::within_fov(level.player.origin, level.player.angles, level.crash_ambulance.origin, 0.5);
}

function function_42d02ae823106946() {
  if(flag("ambulance_go")) {
    return;
  }

  level endon("ambulance_go");
  level childthread function_f1fad21bc27a0976();
  wait 1.6;
  level.price say_team("dx_sp_flas_mblc_pric_gettocover");
  wait 1;
  level.price say_team("dx_sp_flas_mblc_pric_itcouldbemakarov");
  wait 1.6;
  level.price say_team("dx_sp_flas_mblc_pric_stepoutofthevehicle");
  wait 1;
  level.price say_team("dx_sp_flas_mblc_pric_outofthevehiclenow");
}

function function_f1fad21bc27a0976() {
  deck = utility::create_deck(["dx_sp_flas_mblc_pric_maintaindistancesoap", "dx_sp_flas_mblc_pric_holdyourpositionserg", "dx_sp_flas_mblc_pric_soapfallback"]);

  while(true) {
    utility::player_moves(150);
    closest = sortbydistance([level.player, level.price], level.crash_ambulance.origin)[0];

    if(closest == level.player && distancesquared(level.player.origin, level.crash_ambulance.origin) < 144000000) {
      level.price dialogue::say_team(deck deck_draw(), 1, 0.05);
    }
  }
}

function function_f638da6fa9cb3ddc() {
  spot = (26511, 4563, -929.5);
  runto = (28689, 5365, -929.5);
  civ = escort_civ(spot, runto);
  flag_wait("tunnel_arrive_moveup");
  civ notify("flee");
}

function escort_civ(var_8f1b7542d7fdc179, runto, gender) {
  var_fa15d01b439ee739 = randomint(100) < 50 ? "actor_jup_civilian_rus_male_flashback" : "actor_jup_civilian_rus_female_flashback";

  if(isDefined(gender)) {
    assert(gender == "male" || gender == "female");
    classname = gender == "male" ? "actor_jup_civilian_rus_male_flashback" : "actor_jup_civilian_rus_female_flashback";
  } else {
    classname = var_fa15d01b439ee739;
  }

  civ = spawn_aitype(classname, var_8f1b7542d7fdc179, (0, 0, 0), 1, 0, 0, "ambulance_crash_civ");
  civ function_b661b022700ba72f("script", 1);
  civ function_d5cda8a759cc36bc("scared");
  civ function_fcb4c5a996517164();
  civ thread function_247c2418fde94da1(runto);
  return civ;
}

function function_247c2418fde94da1(runto) {
  self endon("death");
  thread namespace_47819225b08b445d::injured_dmg_death_logic();
  self.attackeraccuracy = 100;
  self.health = 1;
  self waittill("flee");
  speed = randomintrange(175, 186);
  set_movement_speed(speed);
  self.maystumble = 0;
  self function_d5cda8a759cc36bc("flee");
  self setgoalpos(runto);
  thread namespace_47819225b08b445d::function_e29483c00b1210fa();
  level delaythread(15, &utility::ai_delete_when_out_of_sight, [self], 800);
  ismale = self.animsetname == "civilian_react";

  if(ismale) {
    prefix = "civ_panic_male_";
    maxnum = 48;
  } else {
    prefix = "civ_panic_female_";
    maxnum = 40;
  }

  say(prefix + randomintrange(1, maxnum));
}

function function_591183fb3a1c7ad1() {
  flag_wait("scriptables_ready");
  level.var_96e7e6879c069e8e = {
    #angles: (0, 0, 0), #origin: (25780, 3730, -936)
  };
  animnames = function_df57c8a03e293db4("ambulance_crash");
  temp = [];

  foreach(animname in animnames) {
    if(animname == "makarov_ambulance" || animname == "price" || animname == "vehicle01_scriptable") {
      continue;
    }

    if(animname == "vehicle01") {
      scriptable = getscriptablearray("ambulance_crash_vehicle01", "targetname")[0];

      if(isDefined(scriptable)) {
        scriptable thread function_76d9365128b15c68();
        level.scr_anim["vehicle01"]["ambulance_crash"] = undefined;
        continue;
      }
    }

    model = spawn_anim_model(animname, (0, 0, 0), (0, 0, 0));
    var_5b2f887c99562566 = animname == "makarov_ambulance" ? "ambulance_intro" : "ambulance_crash";
    level.var_96e7e6879c069e8e anim_first_frame_solo(model, var_5b2f887c99562566);
    temp[animname] = model;
  }

  level.var_96e7e6879c069e8e.models = temp;
  var_15134ddef501f87d = getEnt("makarov_umbalnce_end_coll", "targetname");
  var_15134ddef501f87d notsolid();
  flag_set("ambulance_crash_ready");
}

function function_76d9365128b15c68() {
  self.animname = "vehicle01_scriptable";
  self.origin = getstartorigin(level.var_96e7e6879c069e8e.origin, level.var_96e7e6879c069e8e.angles, getanim("ambulance_crash"));
  self.angles = getstartangles(level.var_96e7e6879c069e8e.origin, level.var_96e7e6879c069e8e.angles, getanim("ambulance_crash"));
  self.animname = undefined;
}

function function_8f6199877eaccf27() {
  level endon("ambulance_go");

  while(true) {
    level.player waittill("attack_pressed");
    level.player.lastshoottime = gettime();
  }
}

function function_1bd6315e1a8930aa() {
  return level.player.origin[0] > 27773 && level.player.origin[1] > 3769;
}

function function_379e8db06da9ef7a() {
  return level.player.origin[1] < 3422;
}

function function_51d26e60e48555bb() {
  visionsetnaked("sp_jup_flashback_dark_tunnels", 0.05);
}

function function_ead50352908eff14() {
  if(!namespace_47819225b08b445d::using_flashlight()) {
    return;
  }

  thread namespace_47819225b08b445d::function_6ed0dee1084e9ab7();
  level.price thread namespace_47819225b08b445d::function_99d87f0bb8ac7c26();
}

function function_48ad48a5df1de4cd(enabled) {
  if(!namespace_47819225b08b445d::using_flashlight()) {
    return;
  }

  if(isendstr(self.classname, "rov")) {
    return;
  }

  if(isendstr(self.classname, "shield")) {
    return;
  }

  self.flashlightfxoverride = "npc_flashlight_flare";
  enable_flashlight(enabled);
}

function function_674ee0e5a75feb4() {
  level endon("ambulance_player_interact");
  array = ["dx_sp_flas_mblc_pric_keepupsoap", "dx_sp_flas_mblc_pric_thiswaysoap", "dx_sp_flas_mblc_pric_withmesergeant"];
  deck = create_deck(array, 1, 1, 1);
  count = 0;
  nagtime = undefined;
  donag = undefined;
  var_57eada3bb39773ee = 0;

  while(true) {
    if(function_58973ea21c6181e3()) {
      donag = 0;

      if(!isDefined(nagtime)) {
        donag = 1;
      }

      if(isDefined(nagtime) && gettime() - nagtime >= 6000) {
        donag = 1;
      }

      if(donag) {
        count++;

        if(!level.price ent_flag("doing_nags")) {
          level.price say_team(deck deck_draw());
        }

        nagtime = gettime();
        divisor = 2;

        if(count % divisor == 0) {
          var_57eada3bb39773ee = 1;
          player::focus_display_hint(undefined, undefined, level, "player_corrected");
        }
      }
    }

    wait 0.15;
  }
}

function function_58973ea21c6181e3() {
  var_1b4d1a4216db504b = distancesquared(level.player.origin, level.price.origin);

  if(var_1b4d1a4216db504b <= 378225) {
    return false;
  }

  var_ea5cfde6271499f4 = distancesquared(level.player.origin, level.crash_ambulance.origin);
  wait 0.5;
  var_7f1c2727f24e2e72 = distancesquared(level.player.origin, level.crash_ambulance.origin);
  var_e5e138584451fa1b = distancesquared(level.player.origin, level.price.origin);

  if(var_ea5cfde6271499f4 == var_7f1c2727f24e2e72 && var_1b4d1a4216db504b == var_e5e138584451fa1b) {
    return true;
  }

  return var_ea5cfde6271499f4 < var_7f1c2727f24e2e72 && var_1b4d1a4216db504b < var_e5e138584451fa1b;
}

function function_da896f70a474264() {
  flag_set("ambulance_player_interact");
  thread scripted_out_of_bounds();
}

function function_19dcebfa87749ed5() {
  namespace_47819225b08b445d::spawn_price();
  function_5e11b2ae0c4caefd();
  level.crash_ambulance ambulance_lights();
  temp = [level.price, level.player];
  set_start_location("ai_drag_begin", temp);
  thread function_9ec45d407a48d59d();

  foreach(transient in level.var_4291dad1008f93e6) {
    settransientvisibility(transient, 0);
  }

  exploder("ambulance_crash_amb_fx");
  level.player setsoundsubmix("sp_jup_flashback_lower_garage", 3.5);
}

function function_12396386fb4393e5() {
  namespace_47819225b08b445d::function_f1864fb398798ed6(0);
  var_ac9a315436d61250 = getEnt("ambulance_interior", "targetname");
  var_ac9a315436d61250 show();
  prop = getEnt("ambulance_dangle", "targetname");

  if(isDefined(prop)) {
    prop show();
    prop thread prop_dangle();
  }

  level.player player::focusdisable();
  function_4025e30e9b1864a1();
  level.player player::focusenable();

  if(isDefined(prop)) {
    prop delete();
  }

  stopFXOnTag(getfx("vfx_flashback_flashlight_midtro"), level.price.flashlight, "tag_origin");
  level.price.flashlight delaycall(0.05, &delete);
  namespace_47819225b08b445d::function_f1864fb398798ed6(1);
  autosave_by_name();
}

function prop_dangle() {
  self endon("death");
  time = 0.8;
  offset = 10;
  toggle = 0;

  while(true) {
    degrees = toggle == 1 ? offset : offset * -1;
    self rotatepitch(degrees, time, time / 2, time / 2);
    toggle = toggle == 1 ? 0 : 1;
    wait time;
  }
}

function function_5e11b2ae0c4caefd() {
  model = getEnt("makarov_ambulance", "targetname");
  model assign_animtree("makarov_ambulance");
  guy = fakeactor::function_d9469562fdbb08bc("actor_jup_enemy_paramedic_ar", (0, 0, 0), (0, 0, 0));
  guy.animname = "driver";
  model.driver = guy;
  level.crash_ambulance = model;
}

function function_9ab8eb99a319d0fa() {
  flag_set("ambulance_cinematic_done");
}

function function_9ec45d407a48d59d() {
  setdvarifuninitialized(@ "hash_2e87db4c53d3c103", 0);
  node = {
    #targetname: "ambulance_cinematic_node", #angles: (0, 0, 0), #origin: (25780, 3730, -936)
  };
  level.player_rig = spawn_anim_model("player_rig");
  level.player_rig hide();
  namespace_47819225b08b445d::function_dc2aa213aa5830aa();
  level.makarov invisiblenotsolid();
  level.actors = [];

  for(i = 1; i < 3; i++) {
    level.actors["group" + i] = function_a2e7162f064dd3c7();
  }

  level.makarov.name = "";
  var_f70033a707804f76 = array_combine(level.actors["group1"], [level.crash_ambulance, level.player_rig]);
  node.corpses = [];
  guy = fakeactor::function_d9469562fdbb08bc("actor_jup_enemy_paramedic_ar", (0, 0, 0), (0, 0, 0));
  guy.animname = "enemy01";
  node anim_first_frame_solo(guy, "ambulance_10_dead");
  node.corpses[node.corpses.size] = guy;
  guy = fakeactor::function_d9469562fdbb08bc("actor_jup_enemy_paramedic_ar", (0, 0, 0), (0, 0, 0));
  guy.animname = "enemy02";
  node anim_first_frame_solo(guy, "ambulance_10_dead");
  node.corpses[node.corpses.size] = guy;
  node anim_first_frame(var_f70033a707804f76, "ambulance_10");
  node anim_first_frame(level.actors["group2"], "ambulance_15");
  level.var_287a1b230c8bd4f = node;
  level.price.flashlight = spawn_tag_origin();
  level.price.flashlight dontcastshadows();
  level.price.flashlight show();
  flag_set("ambulance_open_scene_ready");
}

function function_a2e7162f064dd3c7() {
  temp = [];
  guy1 = fakeactor::function_d9469562fdbb08bc("actor_jup_ally_hero_price_bravo", (0, 0, 0), (0, 0, 0));
  guy1.animname = "price";
  guy1.team = "Allies";
  guy1 utility::make_weapon_and_attach(level.price.weapon.basename, level.price.weapon.attachments, "tag_weapon_right");
  temp["price"] = guy1;
  guy2 = fakeactor::function_d9469562fdbb08bc("jup_enemy_villain_makarov_bravo", (0, 0, 0), (0, 0, 0));
  guy2.animname = "makarov";
  guy2 function_2ee5223e6183096();
  temp["makarov"] = guy2;
  guy3 = namespace_47819225b08b445d::function_320fe24554ccda96();
  guy3 namespace_47819225b08b445d::function_d111c8d7496572c1();
  temp["soap"] = guy3;
  utility::array_call([guy1, guy2, guy3], &hide);
  return temp;
}

function function_2ee5223e6183096() {
  gunmodel = getweaponmodel(level.makarov.sidearm);
  ent = spawn("script_model", (0, 0, 0));
  ent setModel(gunmodel);
  attachments = getweaponattachmentworldmodels(level.makarov.sidearm);

  foreach(attachment in attachments) {
    ent attach(attachment);
  }

  ent hide();
  ent linkTo(self, "tag_inhand", (0, 0, 0), (0, 0, 0));
  self.fake_pistol = ent;
}

function function_41b0e0e502cc236f() {
  self.fake_pistol delete();
}

function function_4025e30e9b1864a1() {
  flag_wait("ambulance_open_scene_ready");
  flag_wait("price_spawned");
  node = level.var_287a1b230c8bd4f;
  setsaveddvar(@ "r_spotlightentityshadows", 1);
  level.price invisiblenotsolid();
  prefix = "ambulance_";
  xanim_array = function_62c968418d0134c4();
  directional_anim = namespace_47819225b08b445d::function_fbca877c7dca5b38(node, xanim_array);

  if(level.scr_anim["player_rig"]["ambulance_10"] != directional_anim) {
    var_c105d4ba0c0c5ed6 = level.actors["group1"]["soap"];
    level.scr_anim["player_rig"]["ambulance_10"] = directional_anim;
    node anim_first_frame_solo(level.player_rig, "ambulance_10");
    function_891dd89c467830ed(directional_anim);
    node animation::anim_first_frame([var_c105d4ba0c0c5ed6, level.player_rig], "ambulance_10");
  }

  level.player setsoundsubmix("sp_jup_flashback_midtro", 0.5);
  dialogue::function_54d3bd59bff7e908();
  scripts\sp\anim::igc_camera(1);
  scripts\sp\anim::letterbox_enable(1);
  namespace_47819225b08b445d::function_8da3daaa6d7ab1a1({
    #rightarc: 0, #leftarc: 0, #bottomarc: 0, #toparc: 0
  }, 1);
  thread function_b5593ec7d6faa56e();
  i = 10;

  while(i < 85) {
    scenename = prefix + i;

    if(!isDefined(level.scr_anim["soap"][scenename])) {} else {
      var_1d85cf3f05ad42c1 = i % 10 == 0 ? level.actors["group1"] : level.actors["group2"];
      var_b575b18e0e6d1375 = [];

      if(i == 80) {
        var_1d85cf3f05ad42c1 = [level.makarov, level.price, level.player_rig, level.actors["group2"]["soap"]];
      }

      foreach(actor in var_1d85cf3f05ad42c1) {
        if(isDefined(level.scr_anim[actor.animname][scenename])) {
          var_b575b18e0e6d1375[var_b575b18e0e6d1375.size] = actor;
        }

        if(i == 10) {
          var_b575b18e0e6d1375[var_b575b18e0e6d1375.size] = level.crash_ambulance;
          var_b575b18e0e6d1375[var_b575b18e0e6d1375.size] = level.player_rig;

          foreach(corpse in node.corpses) {
            node thread anim_single_solo(corpse, "ambulance_10_dead");
          }
        }

        if(i == 15) {
          node delaythread(2, &animation::anim_first_frame_solo, level.player_rig, "ambulance_80");
        }

        if(actor.animname == "price") {
          level.price.flashlight linkTo(actor, "tag_accessory_right", (0, 0, 0), (0, 0, 0), 1);
        }

        if(i == 40 && actor.animname == "makarov") {
          actor thread pistol_take();
        }
      }

      if(i == 75) {
        var_b575b18e0e6d1375[var_b575b18e0e6d1375.size] = level.crash_ambulance.driver;
        node animation::anim_first_frame_solo(level.crash_ambulance.driver, scenename);
      }

      thread fb_lighting::function_b0a2ca3b6db38274(scenename);
      thread function_9024f987045371b7(scenename);

      foreach(actor in var_b575b18e0e6d1375) {
        level.scr_goaltime[actor.animname][scenename] = 0;

        if(actor != level.player_rig) {
          actor namespace_47819225b08b445d::show_me();
        }

        if(isDefined(actor.fake_pistol)) {
          actor.fake_pistol show();
        }

        actor utility::delaythread(0.25, &function_d93019dd0c2a75e, i);
      }

      if(i == 80) {
        level thread release_player();
        level.makarov thread function_cfc1a89ce6f81bd1();
        node thread animation::anim_first_frame([level.makarov, level.price], scenename);

        foreach(actor in var_b575b18e0e6d1375) {
          node thread animation::anim_single_solo(actor, scenename);
        }
      } else {
        node animation::anim_single(var_b575b18e0e6d1375, scenename);
      }

      if(i > 10) {
        level.player_rig hide();
      }
    }

    i += 5;
  }

  level.player clearsoundsubmix("sp_jup_flashback_midtro", 6);
  scripts\sp\anim::igc_camera(0);
  scripts\sp\anim::letterbox_enable(0);
}

function function_b5593ec7d6faa56e() {
  level.player enablephysicaldepthoffieldscripting();
  level.player dof_enable(2.8, 50);
  wait 1.5;
  level.player dof_enable(2.8, 30, undefined, 10, 10);
  wait 1;
  level.player dof_enable(2.5, 200, undefined, 10, 10);
  wait 2;
  level.player dof_disable();
}

function function_9024f987045371b7(anime) {
  switch (anime) {
    case #"hash_6f7c9dfd5086c4bf":
      level.player playSound("scn_fbk_midtro_sh_01_lr");
      break;
    case #"hash_6f7c98fd5086bce0":
      break;
    case #"hash_6f732bfd507f5584":
      break;
    case #"hash_6f7328fd507f50cb":
      break;
    case #"hash_6f7631fd50819d8d":
      level.player playSound("scn_fbk_midtro_sh_05_lr");
      break;
    case #"hash_6f762cfd508195ae":
      break;
    case #"hash_6f6c9ffd5079fbf2":
      level.player playSound("scn_fbk_midtro_sh_07_lr");
      break;
    case #"hash_6f6c9cfd5079f739":
      break;
    case #"hash_6f7025fd507d0d7b":
      break;
    case #"hash_6f7028fd507d1234":
      level.player playSound("scn_fbk_midtro_sh_10_lr");
      break;
    case #"hash_6f6693fd50756be0":
      level.player playSound("scn_fbk_midtro_sh_11_lr");
      break;
    case #"hash_6f6698fd507573bf":
      level.player playSound("scn_fbk_midtro_sh_12_lr");
      break;
    case #"hash_6f6999fd5077b3e9":
      break;
    case #"hash_6f699cfd5077b8a2":
      level.player playSound("scn_fbk_midtro_sh_14_lr");
      break;
    case #"hash_6f92a7fd50981d9e":
      level.player playSound("scn_fbk_midtro_sh_15_lr");
      break;
    default:
      break;
  }
}

function function_d93019dd0c2a75e(current_index) {
  if(self == level.crash_ambulance || self == level.player_rig || self == level.price || self == level.makarov) {
    return;
  }

  if(self.animname == "driver") {
    return;
  }

  self waittillmatch("single anim", "end");
  namespace_47819225b08b445d::hide_me();

  if(isDefined(self.fake_pistol)) {
    self.fake_pistol hide();
  }

  next_index = current_index + 10;
  var_d7fa5947491a853e = undefined;
  i = next_index;

  while(i < 80) {
    if(isDefined(level.scr_anim[self.animname]["ambulance_" + i])) {
      var_d7fa5947491a853e = "ambulance_" + i;
      break;
    }

    i += 10;
  }

  if(isDefined(var_d7fa5947491a853e)) {
    level.var_287a1b230c8bd4f animation::anim_first_frame_solo(self, var_d7fa5947491a853e);

    if(self.animname == "makarov" && next_index == 45) {
      function_41b0e0e502cc236f();
    }

    return;
  }

  if(isDefined(self)) {
    self delete();
  }
}

function release_player() {
  level.player_rig waittillmatch("single anim", "end");
  namespace_47819225b08b445d::unlink_player_from_rig();
  level.price visiblesolid();
  setsaveddvar(@ "r_spotlightentityshadows", 0);
  flag_set("ambulance_cinematic_done");
}

function pistol_take() {
  self waittillmatch("single anim", "pistol_take");
  function_41b0e0e502cc236f();
}

function function_cfc1a89ce6f81bd1() {
  script_func("anim_placeweaponon", self.sidearm, "none");
  var_8a2ffa59e710efb8 = (25384.6, 2993.22, -919);
  self setgoalpos(var_8a2ffa59e710efb8);
  self.goalradius = 32;
  self waittillmatch("single anim", "end");
  wait 0.5;
  function_fcb4c5a996517164();
  self.name = self.script_friendname;
}

function price_move() {
  autosave_by_name();
  level.price.ignoreplayersuppressionlines = 1;
  activate_trigger_with_targetname("price_to_ambulance_corner");
  trigger_wait_targetname("price_to_ambulance_street");
  trig = getEnt("price_to_ambulance_street", "targetname");
  flag_set("tunnel_arrive_moveup");
  level.price utility::enable_cqbwalk();
  level thread function_30a4281385b4c7f7();
  trig delete();
  struct = getStruct("ambulance_enter", "targetname");
  go = 0;

  while(true) {
    dist = distancesquared(level.player.origin, struct.origin);

    if(dist < 4840000) {
      if(within_fov(level.player.origin, level.player.angles, struct.origin, 0.766044)) {
        go = 1;
      }
    } else if(dist < 3610000) {
      go = 1;
    }

    if(go) {
      break;
    }

    waitframe();
  }

  autosave_by_name();
  flag_set("ambulance_moveup");
  thread function_a79a5eeba2585f58();
  flag_wait("ambulance_go");
  level.price thread function_221bd6222e436c78();
  wait 2;
  level.price waittillmatch("single anim", "end");
  level.price enable_ai_color();
  activate_trigger_with_targetname("price_to_ambulance");
  level.price namespace_47819225b08b445d::function_9759891d24e704e7("price_lead_player");
  level.price scripts\sp\utility::enable_stayahead(level.player);
  level.price.ignoreplayersuppressionlines = 0;
  level delaythread(2, &function_610cafacf39b54a5);
  function_2d090b0af3750f68();
  level.price scripts\sp\utility::disable_stayahead();
}

function function_a79a5eeba2585f58() {
  setmusicstate("mx_flashback_ambulancecrash");
}

function function_221bd6222e436c78() {
  wait 0.6;

  for(i = 0; i < 9; i++) {
    self shoot();
    wait randomfloat(0.15) + randomfloat(0.25);
  }
}

function function_30a4281385b4c7f7() {
  level endon("ambulance_go");
  level.var_96e7e6879c069e8e anim_reach_solo(level.price, "ambulance_crash_arrive");

  if(!flag("ambulance_moveup")) {
    flag_wait("ambulance_moveup");
    wait 1;
  }

  level.var_96e7e6879c069e8e anim_single_solo(level.price, "ambulance_crash_arrive");
  flag_set("price_in_crash_position");
  level.var_96e7e6879c069e8e thread anim_loop_solo(level.price, "ambulance_crash_idle");
}

function function_2d090b0af3750f68() {
  level endon("ambulance_player_interact");
  flag_wait("ambulance_crashed");
  autosave_by_name();
  node = getnode("price_ambulance", "targetname");
  level.price namespace_47819225b08b445d::function_8933b56ed3affd76(node);
  flag_set("price_at_ambulance");
}

function function_93efb2ca600badef() {
  function_591183fb3a1c7ad1();
  model = getEnt("makarov_ambulance", "targetname");
  model function_1207da732bc111d8();
  level.var_96e7e6879c069e8e.models[model.animname] = model;
  level.var_96e7e6879c069e8e anim_first_frame_solo(model, "ambulanbce_intro");
  flag_wait("ambulance_moveup");
  flag_set("ambulance_enters");
  level thread function_8f6199877eaccf27();
  playFXOnTag(getfx("vfx_flashback_ambulance_sil_light"), model, "tag_body");
  model thread play_sound_on_entity("scn_fb_crash_ambulance_intro_temp");
  level.var_96e7e6879c069e8e anim_single_solo(model, "ambulanbce_intro");
  flag_wait("price_in_crash_position");

  if(!isDefined(level.player.lastshoottime)) {
    level.var_96e7e6879c069e8e thread anim_loop_solo(model, "ambulanbce_idle");
    function_41c0e04a3082fcb1();
  }

  flag_set("ambulance_go");
  model thread function_1f431fdab00c6c0b();
  level.var_96e7e6879c069e8e notify("stop_loop");
  var_18da1f6277f896fc = getscriptablearray("ambulance_crash_vehicle01", "targetname")[0];

  if(isDefined(var_18da1f6277f896fc)) {
    var_18da1f6277f896fc thread function_111b5b53f7e67091();
  }

  temparray = array_add(level.var_96e7e6879c069e8e.models, level.price);

  foreach(item in temparray) {
    level.var_96e7e6879c069e8e thread anim_single_solo(item, "ambulance_crash");
  }

  level utility::delaythread(6.5, &function_c55440546d9842ee);
  level.crash_ambulance.var_cca4d6f4bf39ed3e delaycall(7, &delete);
  model waittillmatch("single anim", "end");
  thread function_9ec45d407a48d59d();
  flag_set("ambulance_crashed");
  struct = getStruct("ambulance_interact", "targetname");
  struct scripts\sp\player\cursor_hint::create_cursor_hint();
  waitframe();
  struct.cursor_hint_ent sethintonobstruction("hide");
  struct.cursor_hint_ent sethintdisplayfov(180);
  struct.cursor_hint_ent setuserange(50);
  struct.cursor_hint_ent setusefov(70);
  level.ambulance_interact = struct;
  struct waittill("trigger");
  flag_set("ambulance_player_interact");
  thread function_828b227204e0c338();
  level.price ent_flag_clear("doing_nags");
}

function function_828b227204e0c338() {
  stopmusicstate("mx_flashback_ambulancecrash");
}

function function_c55440546d9842ee() {
  var_15134ddef501f87d = getEnt("makarov_umbalnce_end_coll", "targetname");
  var_15134ddef501f87d solid();
}

function function_1f431fdab00c6c0b() {
  thread function_d55c27593d4798d4();
  var_ce172d6fffe01998 = "scn_fb_crash_ambulance_accelerate_normal_temp";
  time = lookupsoundlength(var_ce172d6fffe01998);
  self playSound(var_ce172d6fffe01998);
  start = gettime();
  flag_wait_or_timeout("player_shot_ambulance_driver", time / 1000);

  if(flag("player_shot_ambulance_driver")) {
    self scalevolume(0, 1);
    newent = spawn_tag_origin();
    newent linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
    newent playSound("scn_fb_crash_ambulance_accelerate_plr_temp");
    newent delaycall(0.5, &playsound, "scn_fb_crash_ambulance_death_horn_temp");
    flag_wait("jump");
    newent sound_fade_and_delete(0.2);
  }
}

function function_d55c27593d4798d4() {
  self waittillmatch("single anim", "jump");
  wait 1;
  flag_set("jump");
}

function function_41c0e04a3082fcb1() {
  start = gettime();

  while(true) {
    if(isDefined(level.player.lastshoottime)) {
      return;
    }

    if(flag("player_shot_ambulance")) {
      return;
    }

    if(time_has_passed(start, 6)) {
      return;
    }

    if(distancesquared(level.player.origin, level.crash_ambulance.origin) < 490000) {
      return;
    }

    waitframe();
  }
}

function function_1207da732bc111d8() {
  var_2a84582224bf3b7e = "vfxsiren::" + self.model;
  self setModel(var_2a84582224bf3b7e);
  ents = getEntArray(self.target, "targetname");

  foreach(ent in ents) {
    if(is_equal(ent.classname, "trigger_damage")) {
      self.dmg_trig = ent;
      self.dmg_trig.health = 99999;
      self.dmg_trig enablelinkTo();
      self.dmg_trig linkTo(self);
      continue;
    }

    if(is_equal(ent.script_noteworthy, "player_collide")) {
      self.var_cca4d6f4bf39ed3e = ent;
      self.var_cca4d6f4bf39ed3e enablelinkTo();
      self.var_cca4d6f4bf39ed3e linkTo(self);
    }
  }

  level.crash_ambulance = self;
  temp = getStruct(self.target, "targetname");
  self.var_a2e1e484c9fef58e = temp spawn_tag_origin();
  self.var_a2e1e484c9fef58e linkTo(self);
  guy = spawn_aitype("actor_jup_enemy_paramedic_ar", (0, 0, 0), (0, 0, 0), 1, 0, 0, "mak_ambulance_driver");
  guy thread magic_bullet_shield();
  guy.ignoreall = 1;
  guy.ignoreme = 1;
  guy gun_remove();
  guy.animname = "ambulance_driver";
  self.driver = guy;
  thread anim_loop_solo(guy, "driving", "stop_driver_loop", "tag_body");
  waitframe();
  guy linkTo(self, "tag_body");
  thread ambulance_lights();
  thread function_c658d3a0e101daca();
  thread function_1dec329802b7eea3();
  thread function_267d85764b7c5014();
  thread function_65c15fd3db60074b();
  assign_animtree("makarov_ambulance");
}

function ambulance_lights() {
  playFXOnTag(getfx("vfx_flashback_ambulance_lights"), self, "tag_body");
}

function function_5b51b9e712c8a25a() {
  model = getEnt("makarov_ambulance", "targetname");
  struct = getStruct("makrrov_ambulance_crash_end", "targetname");
  model.origin = struct.origin;
  model.angles = struct.angles;
}

function function_c658d3a0e101daca() {
  self.var_cca4d6f4bf39ed3e endon("entitydeleted");

  while(true) {
    self.var_cca4d6f4bf39ed3e waittill("trigger", who);

    if(is_equal(who, level.player)) {
      level.player playSound("gib_fullbody");
      level.player do_damage(99999, level.player getEye(), undefined, undefined, "MOD_CRUSH");
      return;
    }
  }
}

#using_animtree("generic_human");

function function_267d85764b7c5014() {
  flag_wait_any("ambulance_impact", "player_shot_ambulance_driver");
  self notify("stop_driver_loop");
  anim_single_solo(self.driver, "driving_death");
  thread anim_loop_solo(self.driver, "driving_death_pose", "stop_driver_loop");
  waitframe();
  self.driver setanimrate(level.scr_anim[self.driver.animname]["driving_death_pose"][0], 0, 0);
  flag_wait("ambulance_crashed");
  function_b473d78deea53ba2();
  body = self.driver.model;
  head = self.driver.headmodel;
  dummy = spawn("script_model", (0, 0, 0));
  dummy setModel(body);
  dummy attach(head);
  dummy.animname = self.driver.animname;
  dummy useanimtree(#animtree);
  self.driver stop_magic_bullet_shield();
  self.driver delete();
  self.driver = dummy;
  self.driver.animname = "driver";
  level.var_96e7e6879c069e8e thread animation::anim_last_frame_solo(self.driver, "ambulance_75");
}

function function_b473d78deea53ba2() {
  level endon("ambulance_player_interact");

  while(level.crash_ambulance math::is_point_in_front(level.player.origin)) {
    wait 0.4;
  }
}

function function_65c15fd3db60074b() {
  level endon("ambulance_crashed");

  while(true) {
    self.driver waittill("damage", amount, attacker);

    if(is_equal(attacker, level.player)) {
      flag_set("player_shot_ambulance_driver");
      flag_set("player_shot_ambulance");

      if(self tagexists("tag_windshield_front_pristine")) {
        self hidepart("tag_windshield_front_pristine");

        if(self tagexists("tag_windshield_front_web")) {
          self showpart("tag_windshield_front_web");
        }

        waitframe();
      }

      playFXOnTag(getfx("vfx_flashback_ambulance_blood"), self, "tag_body");
      return;
    }
  }
}

function function_1dec329802b7eea3() {
  level endon("ambulance_crashed");

  while(true) {
    self.dmg_trig waittill("trigger", blah);
    flag_set("player_shot_ambulance");
  }
}

function move_and_rotate_to(item, time) {
  self moveTo(item.origin, time);
  self rotateTo(item.angles, time);
  wait time;
}

function function_6dc233293495d867() {
  function_5b51b9e712c8a25a();
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_dc2aa213aa5830aa();
  temp = [level.price, level.player, level.makarov];
  set_start_location("ai_drag_begin", temp);

  foreach(transient in level.var_4291dad1008f93e6) {
    settransientvisibility(transient, 0);
  }

  level.player setsoundsubmix("sp_jup_flashback_lower_garage", 3.5);
}

function function_45351905e074231d() {
  return level.player.origin[0] > 26186 && level.player.origin[1] > 4784;
}

function function_775d0c9c633b4f56() {
  return level.player.origin[0] > 28662 && level.player.origin[1] > -1271;
}

function function_c854aaef8a00d1c3() {
  function_93d575c8ee714d11();
  function_3e0c60d24ecd7e91();
  thread battlechatter_on();
  var_d87fbb7f6e0e991 = {
    #angles: (0, 180, 0), #origin: (26705, 517.5, -936)
  };
  utility::function_1a9f269761ab7db1(var_d87fbb7f6e0e991);
  function_54b30ac738a29c76();
  function_f26a842bfe69ba4f(&function_45351905e074231d);
  array_spawn_function_targetname("tunnel_exit_guard", &function_cd8a220fc8019b33);
  add_global_spawn_function("axis", &tunnel_enemy);
  level.autosave.enemydistcheck = 0;
  function_d2496391c12096d4();
  level delaythread(2, &stairs_weapon);
  level delaythread(0.25, &escort_cover, 1);
  level thread function_2d636fbc6e135122();
  level thread function_7a7541d0d9745eae();
  flagwaitthread("ambulance_cinematic_done", &function_f60ad9dd45434e63);
  level.var_10507280da552635 = spawn("script_origin", (27530, 296, -860));

  if(isDefined(level.var_10507280da552635)) {
    level.var_10507280da552635 thread sound_fade_in("walla_civ_crying_bus_onboard_lp", 1, 6, 1);
  }

  exploder("car_fire");
  thread function_8fc28ad4eae67966();
  thread function_6a763062d5f8d022();
  thread function_95594b12d8ad65ed();
  trig = getEnt("early_enemy_trigger", "script_noteworthy");
  trig waittill("trigger");
  thread function_2a5f56f0cf98ee4e();

  foreach(transient in level.var_1cdebbdf0e614d2d) {
    settransientvisibility(transient, 1);
  }

  flag_wait("escort1_complete");
}

function stairs_weapon() {
  origin = (26224.5, 2097, -669);
  basename = "jup_jp01_ar_golf36_sp";
  rec = "jup_golf36_rec";
  front = "jup_jp01_ar_golf36_bar";
  back = "jup_jp01_ar_golf36_stock_tac";
  mag = "jup_jp01_ar_golf36_mag_30_556n";
  scope = "fourx01";
  ub = "ub_gl01";
  muz = "flash_ar_04";
  rgrip = "jup_jp01_ar_golf36_pgrip_tac";
  trig = "grip_angled01";
  var_7701542b2c200822 = "jup_laslight_box_01";
  attachments = [rec, front, back, mag, scope, ub, muz, rgrip, trig, var_7701542b2c200822];
  gun = utility::function_ec8a443fe8165fe4(basename, origin, attachments, (0, randomint(270), 0));
}

function function_610cafacf39b54a5() {
  hint_wait();

  if(flag("player_switched_fire_mode")) {
    return;
  }

  flag_set("doing_firemode_hint");
  level.player notifyonplayercommand("toggle_weap_alt", "+toggleweapalt");
  endons = ["toggle_weap_alt", "actionslot3", "attack_pressed", "stop_select_fire_hint"];
  level.player thread namespace_47819225b08b445d::function_8af47a1c024d7116(endons);
  currentgun = level.player getcurrentweapon();

  if(level.player isalternatemode(currentgun, 1)) {
    display_hint("select_fire_mode", 4, 1, level.player, endons);
  }
}

function hint_wait() {
  while(true) {
    if(within_fov(level.player.origin, level.player.angles, level.crash_ambulance.origin, 0.642788)) {
      return;
    }

    if(distancesquared(level.player.origin, level.crash_ambulance.origin) < 722500) {
      return;
    }

    wait 1;
  }
}

function function_95594b12d8ad65ed() {
  while(level.player.origin[1] > 3050) {
    wait 0.25;
  }

  thread play_sound_in_space("civ_panic_male_13", (26498, 949, -900));
}

function function_6a763062d5f8d022() {
  spot1 = (26211.5, 1907, -908.5);
  runto = (26790.5, 407, -926.5);
  civ1 = escort_civ(spot1, runto, "female");
  spot2 = (26420, 995.5, -917.5);
  runto = (27447.5, 464, -933.5);
  civ2 = escort_civ(spot2, runto, "male");

  while(distancesquared(level.player.origin, spot1) > 810000) {
    wait 0.25;
  }

  civ1 notify("flee");
  wait 1;
  civ2 notify("flee");
}

function civ_team() {
  self.team = "allies";
  wait 6;

  if(isalive(self)) {
    self.team = "neutral";
  }
}

function function_eb172c13f9a341f9() {
  var_158f1ddda2c2ff64 = (26591.7, 548.58, -936);
  var_bbd25ffe8d01e2ab = (26246.5, 3967.5, -929.5);
  audioent = spawn_script_origin(var_158f1ddda2c2ff64, (0, 0, 0));
  audioent thread function_aaa856e19658a611();
  segmentstart = (26771.5, 1367, -911.5);
  segmentend = (26289.5, 879, -911.5);
  namespace_47819225b08b445d::function_143bd083c342d51c(segmentstart, segmentend, 180);
  utility::flag_set("server_room_civ_spawned");
  audioent stopsounds();
  audioent delaycall(0.1, &delete);
  civ = spawn_aitype("actor_jup_civilian_rus_female_flashback", var_158f1ddda2c2ff64, (0, 0, 0), 1, 0, 0, "sevrer_room_civ");
  civ function_b661b022700ba72f("script", 1);
  civ function_d5cda8a759cc36bc("flee");
  civ thread namespace_47819225b08b445d::injured_dmg_death_logic();
  civ set_movement_speed(160 + randomintrange(10, 20));
  civ.maystumble = 1;
  civ.goalradius = 32;
  civ setgoalpos(var_bbd25ffe8d01e2ab);
  civ thread namespace_47819225b08b445d::function_e29483c00b1210fa();
  level delaythread(10, &utility::ai_delete_when_out_of_sight, [civ], 1000);
}

function function_aaa856e19658a611() {
  level endon("server_room_civ_spawned");
  var_44e5a5badbb2509b = "dx_sp_bord_cvhs_cvf1_sobbing_Copy";
  time = lookupsoundlength(var_44e5a5badbb2509b) / 1000;

  while(true) {
    self playSound(var_44e5a5badbb2509b);
    wait time;
  }
}

function function_ab81e56c1855d8bd(spot) {
  var_9fc96f19e4a49199 = level.player;
  lasertag = spawn("script_model", spot);
  lasertag setModel("tag_laser");
  lasertag notsolid();
  lasertag.team = "axis";
  temp = makeweapon("iw9_ar_akilo74_sp");
  lasertag setmoverlaserweapon(temp);
  tooclose = 360000;
  cosfov = cos(getdvarint(@ "hash_b38fcf293d1e91a8"));
  lasertag laserforceon();

  for(i = 0; i < 80; i++) {
    if(within_fov(var_9fc96f19e4a49199.origin, var_9fc96f19e4a49199.angles, lasertag.origin, cosfov)) {
      to = var_9fc96f19e4a49199.origin + (0, 0, 40);
    } else {
      i--;
      to = var_9fc96f19e4a49199 getEye() + anglestoleft(var_9fc96f19e4a49199.angles) * 25;
    }

    to += randomvectorrange(1, 2);
    lasertag.angles = vectortoangles(to - lasertag.origin);

    if(distancesquared(level.player.origin, spot) < tooclose) {
      break;
    }

    waitframe();
  }

  lasertag delete();
}

function function_93d575c8ee714d11() {
  level.var_a37f75bc10a31a02 = {
    #angles: (0, 0, 0), #origin: (25802, 1720, -936)
  };
  flag_set("price_mak_cover_ready");
}

function function_b173d63abff7f47e() {
  assert(flag("price_mak_cover_ready"));
  node = level.var_a37f75bc10a31a02;
  level.price enable_cqbwalk();
  level.price.goalradius = 32;
  var_8a2ffa59e710efb8 = getclosestpointonnavmesh((25384.6, 2993.22, -919));
  level.price setgoalpos(var_8a2ffa59e710efb8);
  wait 3;
  node anim_sp::anim_reach_solo(level.price, "cover_arrive");

  if(flag("mak_arrived_at_first_cover")) {
    return;
  }

  node animation::anim_single_solo(level.price, "cover_arrive");

  if(flag("mak_arrived_at_first_cover")) {
    return;
  }

  node thread animation::anim_loop_solo_with_nags(level.price, "cover_arrive_idle");
  flag_set("price_at_cover");
}

function function_84609d1094cd52ac() {
  level.makarov function_fab94f5af62a2ab5();
  level delaythread(4, &function_1364a91cb10e50e8);
  level.makarov.interact waittill("trigger");
  flag_set("mak_moving_to_car");
  level.makarov ent_flag_set("mak_moving");
  assert(flag("price_mak_cover_ready"));
  node = level.var_a37f75bc10a31a02;

  while(level.makarov namespace_47819225b08b445d::function_fe5fb53651d57aa2() || istrue(int(length(level.makarov.velocity)))) {
    waitframe();
  }

  var_8a2ffa59e710efb8 = (25384.6, 2993.22, -919);
  level.makarov setgoalpos(var_8a2ffa59e710efb8);
  wait 5;
  node function_375622c1ffabbee4("cover_together");
  flag_set("mak_arrived_at_first_cover");
  node notify("stop_loop");
  level thread function_fd0d98b939048fb8();
  node animation::anim_single([level.price, level.makarov], "cover_together");
  node thread animation::anim_loop([level.makarov, level.price], "cover_together_idle");
  level.makarov ent_flag_clear("mak_moving");
  flag_set("mak_at_cover");

  if(!flag("price_at_cover")) {
    flag_set("price_at_cover");
  }
}

function function_fd0d98b939048fb8() {
  if(!flag("tunnel_enemies_spawned")) {
    aliases = ["dx_sp_flas_mks1_pric_rallyupsergeantwenee", "dx_sp_flas_mks1_pric_makarovswithmegetuph"];
    level.price dialogue::nag_wait("tunnel_enemies_spawned", aliases, 6, 5);
  }

  level.price say_team("dx_sp_flas_mks1_pric_contact", 1, 0);
  level thread function_6fa629bb0710ee51();
}

function function_6fa629bb0710ee51() {
  level endon("escort1_enemies_dead");
  array = [];
  array[array.size] = "dx_sp_flas_mks1_pric_ivegotmakarovreturnf";
  array[array.size] = "dx_sp_flas_mks1_maka_imhere";
  array[array.size] = "dx_sp_flas_mks1_maka_werebehindthecar";
  array[array.size] = "dx_sp_flas_mks1_maka_therearetwoofthem";

  foreach(callout in array) {
    wait 1.5 + randomfloat(2);
    level.makarov say_team(callout);
  }
}

function function_375622c1ffabbee4(anime) {
  pos = getstartorigin(self.origin, self.angles, level.scr_anim["makarov"][anime]);
  level.makarov.disablearrivals = 1;
  level.makarov.goalradius = 0;
  level.makarov.stopanimdistsq = squared(120);
  level.makarov setgoalpos(pos);
  thread function_f8f1a65c64872888(pos);

  while(distancesquared(level.makarov.origin, pos) > 16) {
    waitframe();
  }

  level.makarov.disablearrivals = 0;
  level.makarov.goalradius = 32;
  level.makarov.stopanimdistsq = 0;
}

function function_f731342ce2780a4f() {
  level thread function_5712ad4a645592c8();

  if(flag("escort1_enemies_dead")) {
    return;
  }

  level endon("price_mak_exit_first_cover");
  flag_wait_all("price_at_cover", "mak_at_cover");
  thread function_f2424b3d6b0bda22();
  node = level.var_a37f75bc10a31a02;
  node.var_fa8c6ee684b9e0ff = gettime() + 99999;

  while(true) {
    if(function_291b3a3522dbb105(node)) {
      node notify("stop_loop");
      node animation::anim_single([level.makarov, level.price], "cover_shoot");
      node thread animation::anim_loop([level.makarov, level.price], "cover_together_idle");
      node.var_fa8c6ee684b9e0ff = gettime();
    }

    waitframe();
  }
}

function function_f2424b3d6b0bda22() {
  stopmusicstate("mx_flashback_makarovescort");
}

function function_a2bbf9b7579b77af() {
  while(true) {
    level.price waittillmatch("single anim", "scripted_fire");
    level.price thread pistol_burst();
  }
}

function pistol_burst() {
  num = randomintrange(3, 4);

  for(i = 0; i < num; i++) {
    self shoot();
    wait randomfloatrange(0.2, 0.6);
  }
}

function function_5712ad4a645592c8() {
  flag_wait_all("price_at_cover", "mak_at_cover");
  flag_wait("escort1_enemies_dead");
  wait 2;
  level.var_74ff7670993d1557 say_team("dx_sp_flas_mks1_pric_weclear");
  level.player thread function_fc0eb6b81c66c661(1, "dx_sp_flas_mks1_soap_afirm");
  thread function_5c4d2e2602513b1c();
  node = level.var_a37f75bc10a31a02;
  flag_set("price_mak_exit_first_cover");
  node notify("stop_loop");
  level.price thread function_fc0eb6b81c66c661(1, "dx_sp_flas_mks1_pric_grabmakarovandletsmo");
  node anim_sp::anim_single([level.makarov, level.price], "cover_exit");
  node thread animation::anim_loop_solo(level.makarov, "coverexit_idle");
  node thread animation::anim_loop_solo_with_nags(level.price, "coverexit_idle");
  var_fa6d32f6152e2ce0 = 12100;

  if(distancesquared(level.player.origin, level.makarov.origin) > var_fa6d32f6152e2ce0) {
    array = ["dx_sp_flas_mks1_pric_soaptakehim", "dx_sp_flas_mks1_pric_takemakarovsergeant", "dx_sp_flas_mks1_pric_illleadyouguardmakar", "dx_sp_flas_mks1_pric_grabmakarovandletsmo"];
    deck = create_deck(array, 0, 0, 1);
    level.price thread dialogue::nagtill("player_at_makarov", deck, 11, 5);

    while(distancesquared(level.player.origin, level.makarov.origin) > var_fa6d32f6152e2ce0) {
      waitframe();
    }

    level.price notify("player_at_makarov");
  }

  node notify("stop_loop");
  level.var_f272f31decd921e9 = gettime();
  level thread function_f4fcfb9b2b5ad8eb();
  node animation::anim_single([level.makarov, level.price], "cover_release");
  level.makarov function_fcb4c5a996517164();
  flag_set("mak_exited_car_cover");
}

function function_f4fcfb9b2b5ad8eb() {
  level.player say_team("dx_sp_flas_mks1_soap_illtakehim");
  wait 0.3;
  level.var_74ff7670993d1557 say("dx_sp_flas_mks1_pric_itsnotsafehereweneed");
  wait 0.2;
  level.makarov say("dx_sp_flas_mks1_maka_yourenotsafeanywhere");
}

function function_5c4d2e2602513b1c() {
  setmusicstate("mx_flashback_makarovescort");
}

function function_291b3a3522dbb105(node) {
  if(abs(gettime() - node.var_fa8c6ee684b9e0ff) < 3000) {
    return false;
  }

  guys = getaiarrayinradius(level.price.origin, 1500, "axis");

  if(guys.size > 1) {
    foreach(guy in guys) {
      if(guy != level.makarov && level.price math::is_point_in_front(guy.origin)) {
        if(trace::ray_trace_passed(level.price getEye(), guy getEye(), [guy, level.price])) {
          return true;
        }
      }
    }
  }

  return false;
}

function function_5625106aaef37b04() {
  while(true) {
    level.price waittillmatch("single anim", "scripted_fire");
    guys = getaiarrayinradius(level.price.origin, 1500, "axis");

    if(guys.size > 1) {
      foreach(guy in guys) {
        if(guy == level.makarov) {
          continue;
        }

        if(!isalive(guy)) {
          continue;
        }

        var_ca5a7b0ed9631521 = guy getEye();
        var_1e6632c5c01bdc4 = level.price gettagorigin("tag_flash");

        if(within_fov(var_1e6632c5c01bdc4, level.price gettagangles("tag_flash"), var_ca5a7b0ed9631521, 0.939693)) {
          if(trace::ray_trace_passed(var_1e6632c5c01bdc4, var_ca5a7b0ed9631521, [guy, level.price])) {
            guy dodamage(70, guy getEye(), level.price, undefined, "MOD_PISTOL_BULLET", level.price.sidearm);
            wait 15;
          }
        }
      }
    }
  }
}

function function_2a5f56f0cf98ee4e() {
  while(getaiarray("axis").size < 2) {
    wait 1.5;
  }

  for(i = 0; i < 2; i++) {
    level waittill("ai_killed");
    wait 2;
    function_e13f1533c5021797(i);
  }

  level thread last_enemy();

  while(getaiarray("axis").size > 1) {
    wait 1;
  }

  flag_set("escort1_enemies_dead");
  autosave_by_name();
}

function function_e13f1533c5021797(i) {
  struct1 = {
    #angles: (0, 47.4992, 0), #origin: (26473.5, 1934.5, -795)
  };
  struct2 = {
    #angles: (0, 137.499, 0), #origin: (26363.5, 933.5, -929)
  };
  structs = i == 0 ? [struct1, struct2] : [struct2, struct1];

  foreach(struct in structs) {
    if(!trace::ray_trace_passed(level.player getEye(), struct.origin + (0, 0, 60))) {
      guy = spawn_aitype("actor_jup_enemy_police_ar", struct.origin, struct.angles, 1, 1, 0, "escort1_backup");
      guy.goalradius = 440;
      guy.baseaccuracy = 1.15;
      guy getenemyinfo(level.player);
      guy.lastenemysightpos = level.player.origin;
      guy setgoalpos((26284.5, 1680.5, -934.5));
      return;
    }
  }
}

function function_3e0c60d24ecd7e91() {
  trigs = getEntArray("tunnels_enemy_trigger", "targetname");
  array_thread(trigs, &function_729940967ba21de3);
}

function function_729940967ba21de3() {
  trigger = self;

  while(true) {
    trigger waittill("trigger", who);

    if(who == level.player) {
      target = trigger.target;
      trigger script_delay();
      spawners = getspawnerarray(target);

      foreach(spawner in spawners) {
        spawner thread spawn_ai();
      }

      return;
    }
  }
}

function tunnel_enemy() {
  if(isendstr(self.classname, "rov")) {
    return;
  }

  if(!flag("tunnel_enemies_spawned")) {
    flag_set("tunnel_enemies_spawned");
  }

  self endon("death");
  self.var_70beb323dd9e1ac5 = 1;
  disable_long_death();
  self.grenadesafedist = 1;
  self.maxfaceenemydist = 800;
  thread function_ab22bfb978385df4();
  thread function_6187ed959e0a124e();

  if(!flag("escort1_enemies_dead")) {
    namespace_47819225b08b445d::function_503436a5bb72ad19(1);
  }

  waitframe();
  grenade = "molotov";
  self.grenadeweapon = makeweapon(grenade);

  if(weaponclass(self.weapon) == "spread") {
    namespace_47819225b08b445d::function_17177a175dd8f243("iw9_sh_mbravo_sp_dragons_breath");
    waitframe();
  }

  if(!flag("escort1_enemies_dead")) {
    set_gunpose("ads");
    thread function_59803dcae900ff5a();
    return;
  }

  function_69b58d7063cf0a46();
}

function function_6187ed959e0a124e() {
  self endon("death");

  while(true) {
    if(function_e58250515688f1e()) {
      namespace_47819225b08b445d::function_e59f66b2ecf3471f();

      while(function_e58250515688f1e()) {
        wait 2;
      }

      namespace_47819225b08b445d::function_363c08ddb86b8493();
    }

    wait 1.5;
  }
}

function function_e58250515688f1e() {
  return isDefined(self.enemy) && distancesquared(self.enemy.origin, level.makarov.origin) < 14400;
}

function function_59803dcae900ff5a() {
  temp = spawn_tag_origin();
  temp linkTo(self, "tag_flash", (0, 0, 0), (0, 0, 0));
  playFXOnTag(getfx("vfx_flashlight_npc_perf"), temp, "tag_origin");
  self waittill("death");
  stopFXOnTag(getfx("vfx_flashlight_npc_perf"), temp, "tag_origin");
  waitframe();
  temp delete();
}

function function_69b58d7063cf0a46() {
  self endon("death");
  namespace_47819225b08b445d::function_65ec687cb4356c31(self.weapon);
  waitframe();
  waitframe();
  self laserforceon();
  set_gunpose("ads");
  enable_cqbwalk();
  wait 5;
  reset_gunpose();
  disable_cqbwalk();
}

function function_7a7541d0d9745eae() {
  level thread function_8fe00181eb04ba69();

  if(is_equal(level.start_point, "makarov_escort_1")) {
    level.price say_team("dx_sp_flas_mks1_pric_illleadyouguardmakar");
  }

  thread function_a2a60eb4c43f51da();
  flag_wait("to_squeeze");
  level.price say_team("dx_sp_flas_mks1_pric_foundawaythroughserg");
}

function function_a2a60eb4c43f51da() {
  setmusicstate("mx_flashback_makarovescort");
}

function function_1364a91cb10e50e8() {
  level endon("mak_attack");

  while(level.makarov namespace_47819225b08b445d::function_fe5fb53651d57aa2()) {
    waitframe();
  }

  if(level.makarov ent_flag("mak_moving")) {
    return;
  }

  level.makarov.interact endon("trigger");
  level childthread function_77dc0ca600a05846();
  aliases = ["dx_sp_flas_mks1_pric_keepmakarovmoving", "dx_sp_flas_mks1_pric_bringmakarovweremovi", "dx_sp_flas_mks2_pric_bringmakarovexitsthi", "dx_sp_flas_mks1_pric_itsclearbringhimup"];
  level.price childthread dialogue::nagtill([level.makarov.interact, "trigger"], aliases, 11, 1);
  level.player display_hint("mak_move");
  wait 10;

  if(level.player ent_flag("global_hint_in_use")) {
    if(is_equal(level.player.current_global_hint, &"SP_JUP_FLASHBACK/MAK_MOVE")) {
      level.player notify("new_hint");
      level.player display_hint("mak_move_button");
    }
  }
}

function function_77dc0ca600a05846() {
  var_7b0ef288e637af65 = utility::create_deck(["dx_sp_flas_mks1_maka_yourewalkingintoatra", "dx_sp_flas_mks1_maka_youwontmakeitoutofhe", "dx_sp_flas_mks1_maka_mymenwontletyouleave"]);
  firsttime = 1;

  while(true) {
    level.price waittill("nag_done_or_cancelled");
    var_3f236c009dabea9f = 0;

    if(firsttime) {
      var_3f236c009dabea9f = 1;
      firsttime = 0;
    } else if(randomint(100) < 65) {
      var_3f236c009dabea9f = 1;
    }

    if(var_3f236c009dabea9f) {
      wait 0.25;
      level.makarov say_global(var_7b0ef288e637af65 utility::deck_draw());
    }
  }
}

function player_attacker_accuracy() {
  level.player endon("death");
  level endon("stop_player_accuracy_modifier");
  var_7c5448d7e2eaa25c = 200;
  var_82d090b812f2370a = 0;
  var_afe7c00cdf190b1c = 200;
  var_84e0847f289d192a = 0.1;
  var_c62bd0f0e41e03e4 = 1;
  var_eda79149b52e562c = 1;

  while(true) {
    wait 0.33;
    currdist = distance2d(level.dragged_ai.origin, level.player.origin);

    if(currdist <= var_7c5448d7e2eaa25c) {
      if(level.player.scriptedattackeraccuracy != 1) {
        level.player set_attackeraccuracy(1);
        continue;
      }

      continue;
    }

    var_b5dcf61276f7de08 = currdist - var_7c5448d7e2eaa25c;
    var_8dd1ee5da99fa3e8 = math::normalize_value(var_82d090b812f2370a, var_afe7c00cdf190b1c, var_b5dcf61276f7de08);
    accuracy_addition = math::factor_value(var_84e0847f289d192a, var_c62bd0f0e41e03e4, var_8dd1ee5da99fa3e8);
    level.player set_attackeraccuracy(1 + accuracy_addition);
  }
}

function function_c88949c938e12ebe(var_5b8fbe172deee2a7, amount) {
  spawners = getspawnerarray("dynamic_spawner");
  temp = [];
  var_d366eb282390604a = (0, 313, 0);
  marker = spawnStruct();
  marker.origin = level.makarov.origin;
  marker.angles = var_d366eb282390604a;

  foreach(spawner in spawners) {
    if(istrue(var_5b8fbe172deee2a7)) {
      if(!marker math::is_point_in_front(spawner.origin)) {
        temp[temp.size] = spawner;
      }

      continue;
    }

    if(marker math::is_point_in_front(spawner.origin)) {
      temp[temp.size] = spawner;
    }
  }

  temp = sortbydistance(temp, level.player.origin);
  spawned = 0;
  warn_behind = 0;
  guys = [];
  start = gettime();
  stop_spawning = 0;
  var_31a6216fbf7e8cc3 = isDefined(amount) == 1 ? amount : 3;

  while(true) {
    foreach(sorted_spawner in temp) {
      if(should_spawn(sorted_spawner)) {
        if(!warn_behind && !level.player math::is_point_in_front(sorted_spawner.origin)) {
          warn_behind = 1;

          iprintlnbold("<dev string:x1c>");

          thread function_74eb8bcd079cef83(sorted_spawner.origin);
        }

        guy = sorted_spawner spawn_ai();

        if(!spawn_failed(guy)) {
          guy thread function_dfed2af066b8c157(var_5b8fbe172deee2a7);
          guys[guys.size] = guy;
        }

        if(guys.size == var_31a6216fbf7e8cc3) {
          stop_spawning = 1;
          break;
        }

        waitframe();
      }
    }

    if(stop_spawning) {
      break;
    }

    if(time_has_passed(start, 4)) {
      break;
    }

    waitframe();
  }

  return guys;
}

function function_74eb8bcd079cef83(behind_origin) {
  if(level.player ent_flag("player_invulnerable")) {
    iprintln("<dev string:x35>");

    return;
  }

  level.player ent_flag_set("player_invulnerable");
  level.player enableinvulnerability();
  start = gettime();

  while(true) {
    if(within_fov(level.player.origin, level.player.angles, behind_origin, 0.5)) {
      break;
    }

    if(time_has_passed(start, 5)) {
      break;
    }

    waitframe();
  }

  level.player disableinvulnerability();
  level.player ent_flag_clear("player_invulnerable");
}

function function_3aea264a5f522d1f() {
  nodetargetname = "stadium_infil_veh_exit_head_on";
  spawner = utility::getvehiclespawner("escort2_enemy_veh", "targetname");
  veh = spawner utility::spawn_vehicle();
  veh scripts\common\vehicle::vehicle_lights_on();
  var_5a22d89fddb19d48 = 400;
  veh function_77320e794d35465a("path", "radiusToStep", var_5a22d89fddb19d48);
}

function should_spawn(spawner) {
  if(distancesquared(spawner.origin, level.makarov.origin) < 360000) {
    return false;
  }

  if(distancesquared(spawner.origin, level.player.origin) > 3240000) {
    return false;
  }

  if(function_abb3b74d310505bf(spawner)) {
    return false;
  }

  return true;
}

function function_abb3b74d310505bf(item) {
  trace = undefined;
  var_6db7d3fcfba74403 = function_2f418ef8dd27221d();
  fov = cos(var_6db7d3fcfba74403);

  if(within_fov(level.player.origin, level.player.angles, item.origin, fov)) {
    trace = trace::capsule_trace(level.player getEye(), item.origin + (0, 0, 66), 4, 8, (0, 0, 0), level.player, trace::create_contents(1, 1, 0, 1, 0, 1, 1, 1, 0, 0));

    if(trace["fraction"] > 0.9) {
      return true;
    }
  }

  return false;
}

function function_dfed2af066b8c157(var_5b8fbe172deee2a7) {
  self endon("death");
  disable_long_death();
  self.grenadeweapon = makeweapon("molotov");
  waitframe();
  namespace_47819225b08b445d::function_503436a5bb72ad19(1);
  vol = function_ec7a186825cb7dc7();

  if(!istrue(var_5b8fbe172deee2a7) && isDefined(vol)) {
    self setgoalvolumeauto(vol);
    return;
  }

  if(!istrue(var_5b8fbe172deee2a7) && !isDefined(vol)) {
    self setgoalpos(level.var_43f73f13b8e41eb5.origin);
    function_71f9a2e975fa8480();
    return;
  }

  if(istrue(var_5b8fbe172deee2a7)) {
    self setgoalpos(level.player.origin);
    function_71f9a2e975fa8480();
  }
}

function function_ec7a186825cb7dc7() {
  if(isDefined(level.var_43f73f13b8e41eb5.script_goalvolume)) {
    return level.goalvolumes[level.var_43f73f13b8e41eb5.script_goalvolume];
  }

  return undefined;
}

function function_931e1e565fd1ee36() {
  while(true) {
    self waittill("<dev string:x57>");
    print3d(level.makarov.origin + (0, 0, 40), "<dev string:x5c>" + level.makarov.goalradius, (1, 1, 0), 1, 0.3, 1, 1);
  }
}

function function_2d636fbc6e135122() {
  escort_globals();
  level.makarov.goalradius = 32;

  if(level.start_point == "makarov_escort_1") {
    level.makarov setgoalpos(level.makarov.origin);
  }

  flag_set("makarov_escort1_begin");
  level delaythread(5, &function_df3cdc2457382cf3);
  level thread function_b173d63abff7f47e();
  wait 1;
  level thread function_84609d1094cd52ac();
  level thread function_f731342ce2780a4f();
  flag_wait("mak_exited_car_cover");
  civs = utility::get_living_ai_array("ambulance_crash_civ", "targetname");

  if(istrue(civs.size)) {
    utility::array_delete(civs);
  }

  function_a7ce2f38957f7652();
  autosave_by_name();
  array_thread([level.price, level.makarov], &function_3c71d8a7fd9c8a7c);
  level delaythread(5, &function_4038f4baaddfdc3b);
  flag_wait_all("price_at_squeeze", "makarov_at_squeeze");
  autosave_by_name();
  level thread function_56b40b5937fc6572();
  namespace_47819225b08b445d::function_f1864fb398798ed6(0);
  function_c1f307fe66aa506a();
  flag_set("escort1_complete");
}

function function_56b40b5937fc6572() {
  flag_set("squeeze_nags_start");
  level endon("escort1_complete");
  aliases = [];
  aliases[aliases.size] = "dx_sp_flas_tnlp_pric_onme";
  aliases[aliases.size] = "dx_sp_flas_tnlp_pric_weneedtohitextractio";
  aliases[aliases.size] = "dx_sp_flas_tnlp_pric_tightenupsoapweneedt";
  var_dd05b4f65490f33c = utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_sp_flas_tnlp_maka_takeyourtime";
  aliases[aliases.size] = "dx_sp_flas_tnlp_maka_hesgoingtogetyoukill";
  aliases[aliases.size] = "dx_sp_flas_tnlp_maka_dontlistentohimserge";
  var_3dccb429576375b3 = utility::create_deck(aliases, 1, 1);

  while(true) {
    level.price say_global(var_dd05b4f65490f33c utility::deck_draw(), 0, [level, "escort1_complete"]);
    wait 0.3;
    level.makarov say_global(var_3dccb429576375b3 utility::deck_draw(), 0, [level, "escort1_complete"]);
    wait 7;
  }
}

function function_df3cdc2457382cf3() {
  spot1 = (25753, 2358, -927.5);
  spot2 = (25406.5, 2021.5, -927.5);
  namespace_47819225b08b445d::function_143bd083c342d51c(spot1, spot2, 100);
  autosave_by_name();
}

function function_a7ce2f38957f7652() {
  node = getnode("makarov_stop_pre_squeeze", "script_noteworthy");
  level.var_43f73f13b8e41eb5 = node;
  level function_b1853f791f900c4e(node);
  level thread function_f8f1a65c64872888(node);
  level.makarov function_fab94f5af62a2ab5();

  if(level.player.var_84ffdf3134508ee9 < level.var_f272f31decd921e9) {
    level delaythread(4, &function_1364a91cb10e50e8);
    level.makarov.interact waittill("trigger");
  }

  autosave_by_name();
  level.makarov ent_flag_set("mak_moving");
  level thread function_b9e789c510bf7c29();
  var_3d1c44f8288a28b9 = (25977.5, 1551.5, -931.5);
  closeenough = 12100;
  level.makarov setgoalpos(var_3d1c44f8288a28b9);

  while(distancesquared(level.makarov.origin, var_3d1c44f8288a28b9) > closeenough) {
    waitframe();
  }

  level.makarov setgoalnode(node);
  level thread function_eb172c13f9a341f9();

  while(distancesquared(level.makarov.origin, node.origin) > 22500) {
    waitframe();
  }

  flag_set("to_squeeze");
  level.var_43f73f13b8e41eb5 = undefined;
}

function function_b9e789c510bf7c29() {
  level endon("mak_moving_to_squeeze");
  aliases = [];
  wait 1;
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_yourlucksrunningdrym";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_idontbelieveinluckib";
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_whatpartofyourplanin";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_amancanbelockedupani";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_wearemenofactionourp";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_youwillhavetohuntusa";
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_weregoodatthat";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_certainmenhaveanenth";

  foreach(i, alias in aliases) {
    name = strtok(alias, "_")[4];
    speaker = name == "maka" ? level.makarov : level.player;

    while(!function_6813889c0924e71a(speaker)) {
      wait 0.25;
    }

    speaker say_global(alias, 0, [level, "mak_moving_to_squeeze"]);
    wait 0.25 + randomfloatrange(0.2, 0.4) + randomfloatrange(0.1, 0.3);

    if(i == 3 || i == 6) {
      wait 0.6;
    }
  }
}

function function_f8f1a65c64872888(node) {
  level notify("mak_node_approach_save");
  level endon("mak_node_approach_save");

  if(isvector(node)) {
    temp = {
      #origin: node
    };
    node = temp;
  }

  while(distancesquared(level.makarov.origin, node.origin) > 202500) {
    wait 0.15;
  }

  autosave_by_name();
}

function function_c1f307fe66aa506a() {
  temp = level.makarov spawn_tag_origin();
  temp linkTo(level.makarov, "j_spine4", (0, 10, 0), (0, 0, 0));
  temp cursor_hint::create_cursor_hint();
  temp sethintonobstruction("show");
  function_fab94f5af62a2ab5();
  waittill_any_ents(level.makarov.interact, "trigger", temp, "trigger");
  waitframe();
  level.makarov function_3592d29556865d92();
  temp cursor_hint::remove_cursor_hint();
}

function function_3c71d8a7fd9c8a7c() {
  if(self == level.makarov) {
    ent_flag_set("disable_triggered_movement");

    if(distancesquared(level.player.origin, self.origin) > 62500) {
      level.makarov ent_flag_clear("mak_moving");
      level delaythread(2, &function_1364a91cb10e50e8);
      self.interact waittill("trigger");
      level.makarov ent_flag_set("mak_moving");
    }

    function_3592d29556865d92();
  }

  if(self == level.price) {
    delaythread(0.15, &function_e553c53012cc2e1a);
  }

  if(self == level.price) {
    level.var_fc26b4515adb7888 anim_reach_solo(self, "squeeze_arrive");
  } else {
    thread function_544c4eb0cf85a671();
    flag_set("mak_moving_to_squeeze");
    level.var_fc26b4515adb7888 function_375622c1ffabbee4("squeeze_arrive");
  }

  level.var_fc26b4515adb7888 anim_single_solo(self, "squeeze_arrive");

  if(self == level.price) {
    level.var_fc26b4515adb7888 thread anim_loop_solo_with_nags(self, "squeeze_arrive_idle");
  } else {
    level.makarov ent_flag_clear("mak_moving");
    level.var_fc26b4515adb7888 thread anim_loop_solo(self, "squeeze_arrive_idle");
  }

  flag_set(self.animname + "_at_squeeze");
}

function function_4038f4baaddfdc3b() {
  flag_wait("price_at_squeeze");
  spot = (27747, 251, -932);
  var_ea233b4d0578ebea = distance2dsquared(level.player.origin, spot);
  var_396083e54c61c6a4 = distance2dsquared(level.price.origin, spot);

  if(var_ea233b4d0578ebea < var_396083e54c61c6a4) {
    level.price visiblenotsolid();

    while(true) {
      var_ea233b4d0578ebea = distance2dsquared(level.player.origin, spot);
      var_396083e54c61c6a4 = distance2dsquared(level.price.origin, spot);

      if(var_ea233b4d0578ebea > var_396083e54c61c6a4) {
        level.price visiblesolid();
        return;
      }

      wait 1;
    }
  }
}

function function_544c4eb0cf85a671() {
  level endon("squeeze_nags_start");
  aliases = ["dx_sp_flas_mks1_maka_ibestowmyblessingson", "dx_sp_flas_mks1_soap_worryaboutyourself", "dx_sp_flas_mks1_maka_everymanisreplaceabl"];

  foreach(alias in aliases) {
    name = strtok(alias, "_")[4];
    speaker = name == "maka" ? level.makarov : level.player;

    while(!function_6813889c0924e71a(speaker)) {
      wait 0.25;
    }

    speaker say_global(alias, 0, [level, "squeeze_nags_start"]);
    wait 0.25 + randomfloatrange(0.2, 0.4) + randomfloatrange(0.1, 0.3);
  }
}

function escort_globals() {
  flag_wait_all("price_spawned", "makarov_spawned");

  if(flag("escort_globals")) {
    return;
  }

  flag_set("escort_globals");
  level.makarov function_60c47ca07ab2292d();
  level.price disable_ai_color();
  level.price namespace_47819225b08b445d::function_74908bfd4c865b11();
  level.price.ignoreplayersuppressionlines = 1;
  level.price.dontgrenademe = 1;
  level.price.ignoreme = 1;
  level thread makattack_watcher();
  level thread function_c33d2aabc6d080af();
}

function function_3d613d1414610b4d(node, i) {}

function function_71eadc51cd90d4f0() {
  if(distancesquared(level.player.origin, level.makarov.origin) > 202500) {
    nags = ["Soap need you close beforer we can move!", "Soap get over here and let's move together."];
    level.price thread nagtill("player_at_makarov", nags, 6, 0.01);

    while(distancesquared(level.player.origin, level.makarov.origin) > 202500) {
      waitframe();
    }

    level.price notify("player_at_makarov");
  }
}

function function_a719f974aa52a614(node) {
  while(distancesquared(level.makarov.origin, node.origin) > 100) {
    waitframe();
  }
}

function function_fbb289d0b3ad4df0() {
  self.fake_enemy = spawn_tag_origin();
  self.fake_enemy setModel("tag_origin_only_collision");
  self.fake_enemy.origin = self getEye() + anglesToForward(self.angles) * 500;
  set_favoriteenemy(self.fake_enemy);
  self.fake_enemy notsolid();
}

function function_daabc49973090578() {
  flag_set("escort1_enemies_dead");
  flag_set("escort1_complete");
  thread function_d2496391c12096d4();
  level delaythread(0.25, &escort_cover, 1);
  thread function_3e0c60d24ecd7e91();
  level.autosave.enemydistcheck = 0;
  add_global_spawn_function("axis", &tunnel_enemy);
  battlechatter_on();

  if(!starts::is_after_start("makarov_escort_3")) {
    exploder("car_fire");
  }
}

function function_d2496391c12096d4() {
  flag_wait("price_spawned");
  level.price set_grenadeammo(0);
  level.price.baseaccuracy = 0.5;
  level.price utility::disable_pain();
  level.price.grenadeawareness = 0;
}

function function_d89962c8032a1a89() {
  function_f60ad9dd45434e63();
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_dc2aa213aa5830aa();
  level.var_fc26b4515adb7888 anim_first_frame_solo(level.price, "squeeze_through");
  level.var_fc26b4515adb7888 anim_first_frame_solo(level.makarov, "squeeze_01");
  level.player setOrigin(level.player_rig.origin);
  level.player setplayerangles(level.player_rig.angles);
  flag_set("squeeze_start_ready");
  var_1385824410cbe0e2 = array_remove_array(level.var_4291dad1008f93e6, level.var_1cdebbdf0e614d2d);

  foreach(transient in var_1385824410cbe0e2) {
    settransientvisibility(transient, 0);
  }

  level.var_10507280da552635 = spawn("script_origin", (27530, 296, -860));

  if(isDefined(level.var_10507280da552635)) {
    level.var_10507280da552635 thread sound_fade_in("walla_civ_crying_bus_onboard_lp", 1, 6, 1);
  }

  level.player setsoundsubmix("sp_jup_flashback_lower_garage", 3.5);
}

function function_f60ad9dd45434e63() {
  if(level.start_point != "squeeze_through") {
    wait 2;
  }

  temp = {
    #angles: (0, 0, 0), #origin: (27747, 251, -932)
  };
  names = ["squeeze_bus", "squeeze_truck"];
  vehicles = [];

  foreach(name in names) {
    ent = getEnt(name, "targetname");
    ent assign_animtree(name);
    vehicles[name] = ent;
  }

  temp anim_first_frame(vehicles, "squeeze_through");
  level.player_rig = spawn_anim_model("player_rig");
  temp anim_first_frame_solo(level.player_rig, "squizz_sc1");
  level.player_rig hide();
  civs = [];

  for(i = 1; i < 5; i++) {
    guy = fakeactor::function_d9469562fdbb08bc("actor_jup_civilian_rus_male_flashback", (0, 0, 0), (0, 0, 0));
    guy.animname = "civ0" + i;
    temp anim_first_frame_solo(guy, "squeeze_through");
    civs[civs.size] = guy;
  }

  temp.civs = civs;
  temp.vehicles = vehicles;
  level.var_fc26b4515adb7888 = temp;
  flag_set("squeeze_through_setup");
}

function function_777f153f1d741519() {
  function_e2f4c72a20b9eced();
}

function function_ec326b8fff2f2e9() {
  thread utility::dyndofexp(2.8, 0.05, 0.05);
}

function function_e2f4c72a20b9eced() {
  autosave_by_name();

  if(level.start_point == "squeeze_through") {
    flag_wait("squeeze_start_ready");
  } else {
    flag_wait("squeeze_through_setup");
  }

  level.player setsoundsubmix("sp_jup_flashback_lower_garage_squeeze", 9);
  dialogue::function_54d3bd59bff7e908();
  thread namespace_47819225b08b445d::player_pov_animated(1);
  level.var_fc26b4515adb7888 notify("stop_loop");
  temp = {
    #bottomarc: 10, #toparc: 20, #leftarc: 18, #rightarc: 15
  };
  namespace_47819225b08b445d::function_8da3daaa6d7ab1a1(temp);
  actors = [level.player_rig, level.makarov, level.price];
  level.player modifybasefov(55, 2);
  truck = level.var_fc26b4515adb7888.vehicles["squeeze_truck"];
  array_thread(level.var_fc26b4515adb7888.civs, &function_47c273b5c3d1c7c3, level.var_fc26b4515adb7888);
  thread function_ec326b8fff2f2e9();

  for(i = 1; i < 5; i++) {
    anime = "squizz_sc" + i;

    if(level.player ent_flag("pushed_fwd")) {
      level.player ent_flag_clear("pushed_fwd");
    }

    if(level.player ent_flag("squeeze_hint")) {
      level.player clearhudtutorialmessage();
      function_1ae8f046dee579e0(1);
      level.player ent_flag_clear("squeeze_hint");
    }

    if(i == 4) {
      level.player modifybasefov(65, 2);
    }

    if(!function_7a45b87cd31ceaab(i)) {
      if(anime == "squizz_sc2") {
        level.var_fc26b4515adb7888 thread anim_single_solo(truck, anime);
      }

      if(i == 4) {
        level.var_fc26b4515adb7888 thread anim_single_solo(level.price, anime);
        actors = [level.player_rig, level.makarov];
        level.price thread function_307b354f1815f554();
      }

      level.var_fc26b4515adb7888 anim_single(actors, anime);
      continue;
    }

    level thread function_bee58803e04404();
    enter = anime + "_alt_enter";
    idle = anime + "_alt_idle";
    exit = anime + "_alt_exit";
    level.var_fc26b4515adb7888 anim_single(actors, enter);

    if(!level.player ent_flag("pushed_fwd")) {
      idle_sequence();
      level notify("stop_loop_anim_single");
    }

    if(anime == "squizz_sc2") {
      level.var_fc26b4515adb7888 thread anim_single_solo(truck, exit);
    }

    level.player thread play_sound_on_entity("male_effort");
    level.var_fc26b4515adb7888 anim_single(actors, exit);
  }

  if(isDefined(level.var_10507280da552635)) {
    level.var_10507280da552635 thread sound_fade_and_delete(15, 1);
  }

  level.player clearsoundsubmix("sp_jup_flashback_lower_garage_squeeze", 6.5);
  thread dyndofexp_disable();
  thread namespace_47819225b08b445d::player_pov_animated(0);
  namespace_47819225b08b445d::unlink_player_from_rig();
  level.makarov ent_flag_clear("disable_triggered_movement");
  namespace_47819225b08b445d::function_f1864fb398798ed6(1);
  autosave_by_name();
}

function function_47c273b5c3d1c7c3(node) {
  node animation::anim_single_solo(self, "squeeze_through");
  node animation::anim_last_frame_solo(self, "squeeze_through");
  flag_wait("gate_scene_begin");
  self delete();
}

function idle_sequence() {
  level.player endon("pushed_fwd");
  firsttime = 1;
  actors = [level.price, level.makarov, level.player_rig];
  var_86cb2b01602e6632 = utility::create_deck([2, 1, 3]);

  while(true) {
    nagindex = var_86cb2b01602e6632 utility::deck_draw();
    nag = "squizz_sc2_alt_loop_nag0" + nagindex;
    level.var_fc26b4515adb7888 anim_single(actors, nag);
    firsttime = 0;
    nagindex = nagindex < 3 ? nagindex + 1 : 1;
    level thread loop_anim_single();
    waittime = 4;
    wait waittime;
    level notify("stop_loop_anim_single");
  }
}

function loop_anim_single() {
  level endon("stop_loop_anim_single");
  loop = "squizz_sc2_alt_loop";

  while(true) {
    level.var_fc26b4515adb7888 anim_single([level.price, level.makarov, level.player_rig], loop);
  }
}

function function_307b354f1815f554() {
  self waittillmatch("single anim", "end");
  level thread function_d9584fc3b7b92217();
}

function function_bee58803e04404() {
  level.player endon("pushed_fwd");
  level.player childthread squeeze_hint();

  while(player_inactive()) {
    waitframe();
  }

  level.player ent_flag_set("pushed_fwd");
}

function function_7a45b87cd31ceaab(i) {
  if(i != 2) {
    return false;
  }

  if(player_inactive()) {
    return true;
  }

  return false;
}

function player_inactive() {
  return level.player getnormalizedmovement()[0] == 0 && !level.player meleeButtonPressed();
}

function squeeze_hint() {
  wait 5;
  level.player ent_flag_set("squeeze_hint");
  function_1ae8f046dee579e0(0);
  level.player sethudtutorialmessage(&"SP_JUP_FLASHBACK/MAK_MOVE_BUTTON", 1);
}

function function_71bd9fb25d978256() {}

function function_dde4441415c2c7d6() {
  array_spawn_function_targetname("tunnel_exit_guard", &function_cd8a220fc8019b33);
  thread function_8fc28ad4eae67966();
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_dc2aa213aa5830aa();
  temp = [level.price, level.player, level.makarov];
  set_start_location("escort2_start", temp);
  var_1385824410cbe0e2 = array_remove_array(level.var_4291dad1008f93e6, level.var_1cdebbdf0e614d2d);

  foreach(transient in var_1385824410cbe0e2) {
    settransientvisibility(transient, 0);
  }

  thread function_d9584fc3b7b92217();
  level.player setsoundsubmix("sp_jup_flashback_lower_garage", 3.5);
}

function function_b287a28ff875c4c8() {
  function_54b30ac738a29c76();
  function_f26a842bfe69ba4f(&function_bd52be73947866cd);
  thread function_c95af5e46488d568();
  thread function_7a7540d0d9745c7b();
  thread function_a9a06f72b4a0fb4c();
  thread function_c0a779c8daff18bd();
  thread headlights();
  delaythread(0.3, &function_e5abc0c141bdc889);
  function_ff744f54a2d46dcd();
  level.price thread price_gate();
  flag_wait("gate_scene_begin");

  if(isDefined(level.var_10507280da552635)) {
    level.var_10507280da552635 thread sound_fade_and_delete(10, 1);
  }
}

function headlights() {
  level endon("gate_scene_begin");
  flag_wait("scriptables_ready");
  car = getscriptablearray("lights_car", "targetname")[0];

  if(!isDefined(car)) {
    return;
  }

  light_left = getEnt("lights_car_left", "script_noteworthy");
  light_right = getEnt("lights_car_right", "script_noteworthy");
  lightsout = 0;
  left_out = 0;
  right_out = 0;

  while(true) {
    car waittill("damage", dmg, attacker, dir, point, mod, modelname, tagname, partname, idflags, weapobj);

    if(!left_out && utility::is_equal(partname, function_3db00f01cdba4538("tag_light_front_left"))) {
      left_out = 1;
      light_left setlightintensity(0);
    }

    if(!right_out && utility::is_equal(partname, function_3db00f01cdba4538("tag_light_front_right"))) {
      right_out = 1;
      light_right setlightintensity(0);
    }

    wait 0.1;

    if(isendstr(car.model, "dst")) {
      if(!right_out) {
        right_out = 1;
        light_right setlightintensity(0);
      }

      if(!left_out) {
        left_out = 1;
        light_left setlightintensity(0);
      }
    }

    if(left_out && right_out) {
      return;
    }
  }
}

function function_43591d0156774a23(lights) {}

function function_bd52be73947866cd() {
  return level.player.origin[0] > 28202 && level.player.origin[1] < -390;
}

function function_c0a779c8daff18bd() {
  level.player endon("facing_forward");
  level endon("ambush_enemies_spawned");
  var_8f1b7542d7fdc179 = (26414, -1743.5, -844);
  runto = [(25714.5, -1414, -857.5)];

  while(true) {
    classname = randomint(100) < 50 ? "actor_jup_civilian_rus_male_flashback" : "actor_jup_civilian_rus_female_flashback";
    civ = spawn_aitype(classname, var_8f1b7542d7fdc179, (0, 0, 0), 1, 0, 0, "escort2_outside_civ");
    civ._blackboard.skiptransition = 1;
    civ function_b661b022700ba72f("script", 1);
    civ function_d5cda8a759cc36bc("flee");
    civ.goalradius = 32;
    civ set_movement_speed(160 + randomint(20));
    civ setgoalpos(runto[randomint(runto.size)]);
    civ thread namespace_47819225b08b445d::injured_dmg_death_logic();
    civ thread delete_on_notify("goal");
    wait 0.6 + randomfloatrange(0.5, 0.9);
  }
}

function function_a9a06f72b4a0fb4c() {
  wait 2;
  spot = (29541, -1155.5, -909);
  thread play_sound_in_space("civ_panic_female_6", spot);
  level.player waittill("facing_forward");
  thread play_sound_in_space("civ_panic_male_2", (26414, -1743.5, -844));
}

function axis_badplace() {
  angles = (0, 44.2545, 0);
  origin = (26852.5, -1177.5, -889);
  distfromcenter = 220;
  team = "axis";
  halfheight = 70;
  badplace = createnavobstaclebyshape(origin, angles, 4, distfromcenter, halfheight, team, team);
}

function function_ff744f54a2d46dcd() {
  struct = getStruct("tunnel_rear", "targetname");

  while(true) {
    if(function_a474e546411383af(struct)) {
      break;
    }

    wait 0.65;
  }

  function_8e6cad2c98b831ef();
}

function function_a474e546411383af(struct) {
  if(!flag("mak_at_truck")) {
    return false;
  }

  if(!flag("price_at_truck")) {
    return false;
  }

  if(!struct math::is_point_in_front(level.player.origin)) {
    return false;
  }

  return true;
}

function function_eccfbf539b496034(struct) {
  return struct math::is_point_in_front(level.player.origin);
}

function function_8e6cad2c98b831ef() {
  gate = getEnt("escort_gate", "targetname");

  while(distance2dsquared(gate.origin, level.player.origin) > 250000) {
    wait 0.3;
  }

  flag_set("escort2_ambush_begin");
  thread function_f7144a944b4894cc();
  level.makarov dialogue::stop_dialogue();
  autosave_by_name();
  thread play_sound_in_space("fb_vehicle_tire_screech", (27841.5, -56, -916));
  struct = getStruct("tunnel_rear", "targetname");
  array_spawn_function_targetname("tunnel_exit_enemy", &function_5988e596b24c5666);
  thread function_b9814d4db958839f();
  spawners = getspawnerarray("tunnel_exit_enemy");
  level delaythread(6, &function_96bdfa1ebedf8404);
  var_807f71029a180d63 = undefined;

  for(i = 0; i < 6; i++) {
    while(!function_eccfbf539b496034(struct)) {
      wait 0.15;
    }

    if(!isDefined(var_807f71029a180d63)) {
      spawner = spawners[randomint(spawners.size)];
    } else {
      spawners = array_randomize(spawners);

      foreach(candidate in spawners) {
        if(distance2dsquared(var_807f71029a180d63.origin, candidate.origin) > 90000) {
          spawner = candidate;
          break;
        }
      }
    }

    var_807f71029a180d63 = spawner;
    spawner.count += 1;
    guy = undefined;

    if(i == 0) {
      flag_set("ambush_enemies_spawned");
    }

    if(i == 5) {
      classname = "actor_jup_enemy_police_dmr";
      guy = spawn_aitype(classname, spawner.origin, spawner.angles, 1, 1, 1, "tunnel_dmr_enemy");
      guy thread function_97ab430443f8c7ac();
    } else {
      guy = spawner stalingradspawn();
    }

    if(isalive(guy)) {
      guy waittill_notify_or_timeout("death", 3);
      continue;
    }

    wait 1;
  }

  while(getaiarray("axis").size > 1) {
    wait 0.15;
  }

  function_d864dcbe651a8bf5();
  level.makarov set_movement_speed(60);
  autosave_by_name();
  flag_set("tunnel_ambush_complete");
}

function function_ecebb0cce3b57ec8() {
  spawners = getspawnerarray("tunnel_exit_enemy");
  spawners = sortbydistance(spawners, level.player.origin);

  foreach(spawner in spawners) {
    if(!function_abb3b74d310505bf(spawner)) {
      return spawner;
    }
  }

  return undefined;
}

function function_cb192656e8c688a4() {
  struct = getStruct("tunnel_rear", "targetname");
  classname = "actor_jup_enemy_police_dmr";
  spawner = undefined;

  while(true) {
    if(function_eccfbf539b496034(struct)) {
      spawner = function_ecebb0cce3b57ec8();
    }

    if(isDefined(spawner)) {
      break;
    }

    wait 0.45;
  }

  var_90abb1165a19191f = spawn_aitype(classname, spawner.origin, spawner.angles, 1, 1, 1, "tunnel_dmr_enemy");
  var_90abb1165a19191f thread function_97ab430443f8c7ac();
}

function function_97ab430443f8c7ac() {
  self endon("death");
  self.goalradius = 32;
  nodes = getnodearray("tunnel_rear_enemy", "targetname");

  if(!isDefined(nodes)) {
    self setgoalpos((27676, -21.5, -926));
  } else {
    self setgoalnode(nodes[0]);
  }

  waitframe();
  self waittill("goal");
  self.goalradius = 150;
}

function function_d864dcbe651a8bf5() {
  wait 5;
  level.player say_team("dx_sp_flas_mks2_soap_wereclear");
  wait 1;
}

function function_b9814d4db958839f() {
  spot = (27655, 18, -835);

  if(within_fov(level.player.origin, level.player.angles, spot, 0.34202)) {
    return;
  }

  thread fake_damage(spot);
  level.player enableinvulnerability();
  start = gettime();
  level delaythread(7, &function_7e6f9f5d2c2fe084, spot);

  while(true) {
    var_cb921a53291703e4 = within_fov(level.player.origin, level.player.angles, spot, 0.34202);
    var_5c7b25da3422425f = level.player player::function_693be821d14ede2f();

    if(var_cb921a53291703e4 && !var_5c7b25da3422425f) {
      break;
    }

    if(time_has_passed(start, 5)) {
      break;
    }

    wait 0.25;
  }

  level.player notify("facing_forward");
  level.player disableinvulnerability();
}

function function_7e6f9f5d2c2fe084(spot) {
  if(!within_fov(level.player.origin, level.player.angles, spot, 0.34202)) {
    level.price thread function_fc0eb6b81c66c661(0.05, "dx_sp_flas_stcn_pric_contactrear", 1, 2, 0);
  }
}

function fake_damage(spot) {
  level.player endon("facing_forward");
  temp = makeweapon("iw9_lm_kilo21_sp");

  while(true) {
    wait 2;
    magicbullet(temp, spot, level.player getEye() + (0, 0, 20));
    waitframe();
    level.player player::damagebloodoverlay(spot, 0.07, "MOD_RIFLE_BULLET");
    wait 2 + randomfloat(1);
  }
}

function function_f7144a944b4894cc() {
  stopmusicstate("mx_flashback_makarovescort");
}

function function_5988e596b24c5666() {
  self setgoalvolumeauto(level.goalvolumes["tunnel_exit"]);
}

function function_cd8a220fc8019b33() {
  spot = (27135.5, -515.5, -908.5);
  self.goalradius = 32;
  disable_long_death();
  self setgoalpos(getclosestpointonnavmesh(spot));
  set_movement_speed(50);
  self waittill("goal");
  self.goalradius = 1000;
  clear_movement_speed();
}

function function_c95af5e46488d568() {
  if(!isDefined(level.gate_node)) {
    level.gate_node = {
      #targetname: "gate_anim_node", #angles: (0, -135, 0), #origin: (26522, -1197, -920)
    };
  }

  gate = getEnt("escort_gate", "targetname");
  gate assign_animtree("gate");
  model = spawn_anim_model("player_rig");
  model hide();
  level.gate_node anim_first_frame([model, gate], "gate_open");
  level.player_rig = model;
  level.gate_node.models = [gate, level.player_rig];
  flag_set("gate_scene_initialized");
}

function function_33a93d33f8b7fc5a() {
  level endon("escort2_ambush_begin");
  aliases = [];
  aliases[aliases.size] = "dx_sp_flas_mks2_soap_timeforyoutomeetsome";
  aliases[aliases.size] = "dx_sp_flas_mks2_maka_wherearethey";
  aliases[aliases.size] = "dx_sp_flas_mks2_soap_close";
  aliases[aliases.size] = "dx_sp_flas_mks2_maka_soaremine";
  aliases[aliases.size] = "dx_sp_flas_mks2_soap_youshouldknowwhenyou";
  aliases[aliases.size] = "dx_sp_flas_mks2_maka_yourestillthinkingab";
  aliases[aliases.size] = "dx_sp_flas_mks2_maka_thewickedprosperthey";
  aliases[aliases.size] = "dx_sp_flas_mks2_soap_whenpeopleseewhatyou";
  aliases[aliases.size] = "dx_sp_flas_mks2_maka_revengeislikeaghost";
  aliases[aliases.size] = "dx_sp_flas_mks2_soap_youllmeethimtoo";

  foreach(alias in aliases) {
    name = strtok(alias, "_")[4];
    speaker = name == "maka" ? level.makarov : level.player;

    while(!function_6813889c0924e71a(speaker)) {
      wait 0.25;
    }

    speaker say_global(alias, 0, [level, "escort2_ambush_begin"]);
    wait 0.25 + randomfloatrange(0.2, 0.4) + randomfloatrange(0.1, 0.3);

    if(i == 3) {
      wait 1;
    }
  }
}

function function_e5abc0c141bdc889() {
  assertex(flag("<dev string:x6b>") == 1, "<dev string:x7c>");
  escort_globals();
  level.makarov function_fcb4c5a996517164();
  flag_set("mak_escort2_begin");
  function_4e93a17987831a75();
  function_6c966eef1201a970();
  function_3592d29556865d92();
  flag_set("escort2_done");
}

function function_6c966eef1201a970() {
  level endon("tunnel_ambush_complete");
  thread play_sound_in_space("sniper_crack_med_near", level.player getEye());
  level.gate_node animation::anim_single([level.price, level.makarov], "truck_cover_arrive");
  level.gate_node thread animation::anim_loop([level.price, level.makarov], "truck_cover_idle");
  thread axis_badplace();
  toggle = 1;

  while(true) {
    var_c7f707ded6dbfcca = function_c17e117bdc6dee66();

    if(isDefined(var_c7f707ded6dbfcca)) {
      level.gate_node notify("stop_loop");
      level childthread function_aaf7619aa3c17d6(var_c7f707ded6dbfcca);
      level.gate_node animation::anim_single([level.price, level.makarov], "truck_cover_shoot");
      level.gate_node thread animation::anim_loop([level.price, level.makarov], "truck_cover_idle");
      wait 4;
    }

    wait 0.35;
  }
}

function function_386a3c897bf0db5b() {
  wait 1;
  level.price say_global("dx_sp_flas_mks2_pric_incoming", 1, 1);
  wait 0.15;
  level.price say_global("dx_sp_flas_mks2_pric_ivegotmakarovclearem", 1, 1);
}

function function_aaf7619aa3c17d6(guy) {
  if(!isalive(guy)) {
    return;
  }

  level.price notify("shooting_from_truck");
  level.price endon("shooting_from_truck");

  for(i = 0; i < 3; i++) {
    level.price waittillmatch("single anim", "pistol_fire");

    if(i == 1) {
      continue;
    }

    if(i == 2 && randomint(100) < 40) {
      continue;
    }

    level.price shoot();
    waitframe();

    if(!flag("price_killed_truck_enemy") && isalive(guy) && trace::ray_trace_passed(level.price gettagorigin("tag_flash"), guy getEye(), [guy, level.price])) {
      guy dodamage(70, guy getEye(), level.price, undefined, "MOD_PISTOL_BULLET", level.price.sidearm);
      flag_set("price_killed_truck_enemy");
    }
  }
}

function function_c17e117bdc6dee66() {
  p1 = (26808, -1151.5, -914);
  p2 = (27678.5, -237.5, -910);

  foreach(guy in getaiarray("axis")) {
    if(guy == level.makarov) {
      continue;
    }

    var_b0e57d35ef9cee89 = pointonsegmentnearesttopoint(p1, p2, guy.origin);
    var_d66214fe8e10d496 = distance2dsquared(guy.origin, var_b0e57d35ef9cee89);

    if(var_d66214fe8e10d496 < 3600) {
      return guy;
    }
  }

  return undefined;
}

function function_d9584fc3b7b92217() {
  if(!isDefined(level.gate_node)) {
    level.gate_node = {
      #targetname: "gate_anim_node", #angles: (0, -135, 0), #origin: (26522, -1197, -920)
    };
  }

  spot = getstartorigin(level.gate_node.origin, level.gate_node.angles, level.price getanim("truck_cover_arrive"));
  angles = getstartangles(level.gate_node.origin, level.gate_node.angles, level.price getanim("truck_cover_arrive"));
  newnode = spawncovernode(spot, angles, "Exposed", 8, "truck_cover_arrive_exposed_node");
  level.price utility::enable_cqbwalk();
  level.price set_movement_speed(100);
  level.price.goalradius = 32;
  var_59cb0ccc327926f4 = (27200, -451, -922);
  level.price setgoalpos(var_59cb0ccc327926f4);

  while(distancesquared(level.price.origin, var_59cb0ccc327926f4) > 6400) {
    wait 0.1;
  }

  level.price setgoalnode(newnode);
  level.price namespace_47819225b08b445d::function_8933b56ed3affd76(newnode);
  flag_set("price_at_truck");
  wait 1;
  level.price forceteleport(newnode.origin, newnode.angles, 999, 1);
}

function function_4e93a17987831a75() {
  level.makarov function_fab94f5af62a2ab5();
  level delaythread(4, &function_1364a91cb10e50e8);
  level.makarov.interact waittill("trigger");
  level.makarov ent_flag_set("mak_moving");

  while(level.makarov namespace_47819225b08b445d::function_fe5fb53651d57aa2()) {
    waitframe();
  }

  level.makarov.goalradius = 32;
  spot = getstartorigin(level.gate_node.origin, level.gate_node.angles, level.makarov getanim("truck_cover_arrive"));
  angles = getstartangles(level.gate_node.origin, level.gate_node.angles, level.makarov getanim("truck_cover_arrive"));
  newnode = spawncovernode(spot, angles, "Exposed", 8, "truck_cover_arrive_exposed_node");
  var_59cb0ccc327926f4 = (27200, -451, -922);
  level.makarov setgoalpos(var_59cb0ccc327926f4);

  while(distancesquared(level.makarov.origin, var_59cb0ccc327926f4) > 6400) {
    wait 0.1;
  }

  level.makarov setgoalnode(newnode);

  while(distancesquared(level.makarov.origin, newnode.origin) > 6400) {
    wait 0.1;
  }

  struct = getStruct("tunnel_rear", "targetname");

  while(!function_eccfbf539b496034(struct)) {
    waitframe();
  }

  flag_set("mak_at_truck");
  level.gate_node function_375622c1ffabbee4("truck_cover_arrive");
  level.makarov ent_flag_clear("mak_moving");
  flag_wait("price_at_truck");
}

function price_gate() {
  if(flag("gate_scene_begin")) {
    return;
  }

  level endon("gate_scene_begin");
  flag_set("pause_mak_attack");
  function_3592d29556865d92();
  namespace_47819225b08b445d::function_f1864fb398798ed6(0);
  thread function_6f6d387deb9ad9c8();
  aliases = [];
  aliases[aliases.size] = "dx_sp_flas_mks2_pric_getonthegatesergeant";
  aliases[aliases.size] = "dx_sp_flas_mks2_pric_letsgetthisgateopen";
  aliases[aliases.size] = "dx_sp_flas_mks2_pric_liftthegatesoaptimet";
  level.price thread nag_wait("gate_scene_begin", aliases, 13, 7);
  level thread function_c01d8d1176e35ed8();
  level.gate_node notify("stop_loop");
  level.gate_node animation::anim_single([level.price, level.makarov], "gate_arrive");
  level.gate_node thread animation::anim_loop_solo_with_nags(level.price, "gate_arrive_idle");
  level.gate_node thread animation::anim_loop_solo(level.makarov, "gate_arrive_idle");
}

function function_c01d8d1176e35ed8() {
  level.price ent_flag_set("pistol_out");
}

function function_76fee1bbca1cbd31() {
  flag_set("pause_mak_attack");
  flag_set("escort2_done");
  flag_set("mak_at_truck");
}

function function_2baa4207f261ebd4() {
  thread namespace_47819225b08b445d::spawn_price();
  thread namespace_47819225b08b445d::function_dc2aa213aa5830aa();
  flag_wait_all("price_spawned", "makarov_spawned");
  set_start_location("escort_stadium_exit_start", [level.player, level.makarov, level.price]);
  thread function_c95af5e46488d568();
  var_1385824410cbe0e2 = array_remove_array(level.var_4291dad1008f93e6, level.var_1cdebbdf0e614d2d);

  foreach(transient in var_1385824410cbe0e2) {
    settransientvisibility(transient, 0);
  }
}

function function_8dd8339057b31e02() {
  noself_delaycall(0.6, &setsaveddvar, @ "hash_dab366f405822e6c", 0.006);
  thread heli_flyby();
  thread function_e708dc41011ece0e();
  function_1c5f39d71c39d2fb();
}

function function_5e1d3677756c3fd3() {
  flag_set("escort_gate_complete");
  noself_delaycall(0.6, &setsaveddvar, @ "hash_dab366f405822e6c", 0.006);
}

function function_1c5f39d71c39d2fb() {
  flag_wait("gate_scene_initialized");
  settransientvisibility("sp_jup_flashback_vista_tr", 1);
  thread namespace_47819225b08b445d::player_pov_animated(1);
  namespace_47819225b08b445d::function_8da3daaa6d7ab1a1({
    #rightarc: 9, #leftarc: 9, #bottomarc: 0, #toparc: 30
  });
  level.gate_node notify("stop_loop");

  if(level.price isinscriptedstate()) {
    level.price stopanimScripted();
  }

  if(level.price ent_flag("pistol_out")) {}

  level.player clearsoundsubmix("sp_jup_flashback_lower_garage", 3.5);
  level.player setsoundsubmix("sp_jup_flashback_exit_garage", 3.5);
  everyone = array_combine(level.gate_node.models, [level.price, level.makarov]);
  level.gate_node thread anim_single(everyone, "gate_open");
  level.player_rig waittillmatch("single anim", "end");
  thread namespace_47819225b08b445d::player_pov_animated(0);
  namespace_47819225b08b445d::unlink_player_from_rig();
  waitframe();
  level.player setOrigin(getclosestpointonnavmesh(level.player.origin));
  flag_set("escort_gate_complete");
}

function function_fbbfc37c1a1dc676() {}

function function_6f6d387deb9ad9c8() {
  gate = getEnt("escort_gate", "targetname");
  collision = getEnt(gate.target, "targetname");
  collision connectpaths();
  interact = {
    #angles: (0, 0, 0), #origin: (26556.5, -1225.5, -903)
  };
  interact scripts\sp\player\cursor_hint::create_cursor_hint();
  level.gate_interact = interact;
  interact waittill("trigger");
  flag_set("gate_scene_begin");
}

function function_87efde534fc49cd9() {
  thread heli_flyby();
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_dc2aa213aa5830aa();
  temp = [level.price, level.player, level.makarov];
  set_start_location("escort3_start", temp);
  level.makarov delaythread(0.05, &function_fcb4c5a996517164);
  var_1385824410cbe0e2 = array_remove_array(level.var_4291dad1008f93e6, level.var_1cdebbdf0e614d2d);

  foreach(transient in var_1385824410cbe0e2) {
    settransientvisibility(transient, 0);
  }

  level.player setsoundsubmix("sp_jup_flashback_exit_garage", 3.5);
}

function function_7ef72faa51a3bc49() {
  autosave_by_name("escort3_start");
  escort_globals();
  thread function_7a753fd0d9745a48();
  thread function_fce3c7b305febb89();

  if(level.start_point != "makarov_escort_3") {
    namespace_47819225b08b445d::function_f1864fb398798ed6(1);
  }

  level.price notify_delay("flashlight_off", 0.1);
  level thread function_4f30c040a96738ea();
  level thread function_c96bac5f0291ea4c();
  level thread function_a4485a6751644cf7();
  flagwaitthread("last_bus_enemy", &exfil_heli);
  function_184e1e69e4ddf828();
  level.player setsoundsubmix("sp_jup_flashback_pre_outro", 3.5);
}

function function_7a753fd0d9745a48() {
  level.price say_global("dx_sp_flas_mks3_pric_goldeagleactualweree");
  flag_wait("blima_flyby");
  level.shepherd say_global("dx_sp_flas_mks3_shep_bravo6wereonstationb");
  wait 0.3;
  level.price say_global("dx_sp_flas_mks3_pric_copywellmeetyouatpri");
  wait 0.3;
  level.price say_global("dx_sp_flas_mks3_pric_illhandlemakarovyouc");
  flag_set("flyby_heli_complete");
  thread function_1e57892705d7304f();
}

function function_1e57892705d7304f() {
  wait 1.5;
  setmusicstate("mx_flashback_finalescort");
}

function function_fce3c7b305febb89() {
  flag_wait("parking_enter");
  function_54b30ac738a29c76();
  function_f26a842bfe69ba4f(&function_c98ca3e987c4efc7);
}

function function_c98ca3e987c4efc7() {
  return level.player.origin[0] > 29301;
}

function function_a4485a6751644cf7() {
  flag_wait("price_spawned");
  node = getnode("makarov_escort3", "targetname");
  level.makarov.goalradius = 32;
  level.makarov setgoalnode(node);
  spot = node.origin + anglesToForward(node.angles) * -70;
  level.price setgoalpos(spot);
  level.price.goalradius = 32;
  level.price set_movement_speed(45);
  wait 4;
  level.price thread function_c5ba10c4d4bed413();
  thread function_2bbd12be32ea70f5(1);
  flag_wait("flyby_heli_complete");
  level thread function_6754d636e9823568();
  node = getnode("mak_bus", "targetname");
  level.makarov.goalradius = 32;
  level.makarov setgoalnode(node);

  while(distancesquared(level.makarov.origin, node.origin) > 28900) {
    wait 0.15;
  }

  level.price function_b0abd436448388f0();
  thread function_2bbd12be32ea70f5(0);
  node = getnode("price_bus", "targetname");
  level.price.goalradius = 32;
  level.price setgoalnode(node);
  thread function_16b05ada8130482();
}

function function_16b05ada8130482() {
  var_93c2e36bd6bd001e = 412;
  var_2679a54a79333ba1 = 25;
  var_f4b307a451302ee0 = 50;
  origin = (26489, -2176, -854);
  angles = (0, 45, 0);
  temp = createnavobstaclebybounds(origin, (var_93c2e36bd6bd001e, var_2679a54a79333ba1, var_f4b307a451302ee0), angles, "axis");
  flag_wait("lz_clear");
  destroynavobstacle(temp);
}

function function_4f30c040a96738ea() {
  trig = getEnt("escort3_bus_enemy_rear", "target");
  trig waittill("trigger");
  flag_set("escort3_bus_enemy_rear_trig");
}

function function_dfa6c176a2987719() {
  level endon("lz_clear");
  var_c831e24d8b8dea68 = 0;

  while(true) {
    level.makarov waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon);

    if(is_equal(attacker, level.player)) {
      if(is_equal(meansofdeath, "MOD_MELEE")) {
        node = getnode("mak_bus", "targetname");
        level.makarov.goalradius = 32;
        level.makarov setgoalnode(node);
        return;
      }
    }
  }
}

function function_c96bac5f0291ea4c() {
  thread set_flag_on_targetname_trigger("escort3_bus_enemy_first_trig");
  thread flagwaitthread("escort3_bus_enemy_first_trig", &autosave_by_name);
  thread flagwaitthread("escort3_bus_enemy_first_trig", &function_2bbd12be32ea70f5, 0);
  function_4569607e759bc859();
  add_global_spawn_function("axis", &set_grenadeammo, 0);
  array_spawn_function_noteworthy("bus_enemy", &function_ce4297788a90466b);
  level thread function_2a6efec918f82a8a();
  trig = getEnt("escort3_bus_enemy_rear", "target");
  trig waittill("trigger");
  autosave_by_name();
  flag_set("last_bus_enemies_spawned");
  wait 1;
  thread function_241a247d7366abb0();
  thread last_bus_enemy();

  while(getaiarray("axis").size > 1) {
    waitframe();
  }

  wait 3;
  flag_set("lz_clear");
  thread function_156d837f59ad5d41();
}

function function_156d837f59ad5d41() {
  level.ghost say_team("dx_sp_flas_mks3_ghos_wereclearnovisibleth");
}

function function_4569607e759bc859() {
  spawners = get_spawner_array("bus_enemy", "script_noteworthy");

  foreach(spawner in spawners) {
    if(issubstr(spawner.classname, "swat") && !isDefined(spawner.subclass) && !isendstr(spawner.classname, "eld")) {
      spawner.subclass = "tier3";
    }
  }
}

function function_1d2c2b9af2953d35() {
  level endon("stop_magic_shooting");
  weapons = ["iw9_lm_kilo21_sp", "iw9_ar_akilo_sp", "iw9_ar_mike4_sp"];
  spawners = [];
  spawners[spawners.size] = {
    #origin: (28371, -3482, -775)
  };
  spawners[spawners.size] = {
    #origin: (28365, -3264, -775)
  };
  spawners[spawners.size] = {
    #origin: (28686, -3208, -775)
  };

  while(true) {
    if(flag("stop_magic_shooting")) {
      return;
    }

    if(getaiarray("axis").size == 1) {
      spawner = spawners[randomint(spawners.size)];
      weapon = makeweapon(weapons[randomint(weapons.size)]);
      burst = randomintrange(15, 25);

      for(i = 0; i < burst; i++) {
        magicbullet(weapon, spawner.origin, level.var_e3554f139b424f57.origin + randomvectorrange(150, 300));
        wait 0.05;

        if(randomint(100) < 33) {
          wait 0.05;
        }
      }

      wait 2 + randomfloat(1);
      var_48affd8a9c0d3134 = undefined;
    }

    wait 0.5;
  }
}

function function_ece5191ca2a751c1(spawners, var_c11437d0f8331e0c) {
  foreach(spawner in spawners) {
    var_cdb04c080afe851f = distancesquared(spawner.origin, level.player.origin);
    var_a1e9007122c0bbd6 = distancesquared(spawner.origin, var_c11437d0f8331e0c);
    var_e53ab6e270979035 = distancesquared(level.player.origin, var_c11437d0f8331e0c);

    if(var_cdb04c080afe851f > 122500 && var_cdb04c080afe851f < 562500 && var_a1e9007122c0bbd6 < var_e53ab6e270979035) {
      if(!function_abb3b74d310505bf(spawner)) {
        return spawner;
      }
    }
  }

  return undefined;
}

function function_ce4297788a90466b() {
  if(isendstr(self.classname, "shield")) {
    return;
  }

  self endon("death");
  self.post_wait_func = &bus_enemy_wait;
  namespace_47819225b08b445d::function_15e8419bc7722d0b();
  childthread function_9cc49c07012d80ef();
  thread fake_stealth::fake_stealth();
}

function bus_enemy_wait(node) {
  if(!is_equal(node.script_noteworthy, "bus_enemy_wait")) {
    return;
  }

  self endon("death");
  time = randomintrange(6, 10);
  wait time;
}

function function_9cc49c07012d80ef() {
  self endon("death");
  self endon("stop_fake_stealth");
  self function_9f82c74eb1b7caf9(0);
  self.fake_enemy endon("death");
  z_value = self.origin[2] + 100;

  while(true) {
    self.fake_enemy.health = 999;
    angles = vectortoangles(level.var_e3554f139b424f57.origin - self.origin);
    spot = self.origin + anglesToForward(angles) * 200;
    self.fake_enemy.origin = (spot[0], spot[1], z_value);
    self cansee(self.fake_enemy, 0);
    wait 1.3;
  }
}

function function_19c9fd06778eaba() {
  level endon("lz_clear");
  aliases = [];
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_thatonewasmine";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_ihadthatone";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_nevermind";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_movingonthen";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_hewasmine";
  var_31eda751e4944505 = create_deck(aliases);

  while(true) {
    guys = sortbydistance(getaiarray("axis"), level.player.origin);

    foreach(guy in guys) {
      if(function_9e15a2d034dc62ea(guy)) {
        var_2ea92483572aad1c = ghost_snipe(guy);

        if(!var_2ea92483572aad1c) {
          level.ghost say_team(var_31eda751e4944505 deck_draw());
          continue;
        }

        function_4f1ea307a1636bed();
      }
    }

    wait 0.25;
  }
}

function function_4f1ea307a1636bed() {
  outcome = level waittill_notify_or_timeout_return("ai_killed", 30);

  if(outcome == "ai_killed") {
    wait 1;
  }
}

function function_9e15a2d034dc62ea(guy) {
  if(!isalive(guy)) {
    return false;
  }

  if(guy == level.makarov) {
    return false;
  }

  if(distance2dsquared(guy.origin, level.player.origin) > 360000) {
    return false;
  }

  if(!fake_stealth::function_6768c387fe224b2(guy, 1)) {
    return false;
  }

  if(!trace::ray_trace_passed(level.ghost getshootfrompos(), guy getEye(), [guy, level.ghost])) {
    return false;
  }

  return true;
}

function function_f13a036e61e319e5() {
  if(isDefined(level.var_82adf86fb31f3513)) {
    if(gettime() - level.var_82adf86fb31f3513 < 9000) {
      return;
    }
  }

  level.var_82adf86fb31f3513 = gettime();
  level.ghost say_team("I don't have a shot Soap!");
}

function ghost_snipe(guy) {
  if(!isDefined(level.ghost.var_3899d8bb3c7a255f)) {
    aliases = [];
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_sendingrounds";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_takingtheshot";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_sending";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_shotout";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_firing";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_roundincoming";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_shotinbound";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_engaging";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_targetspotted";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_gotatarget";
    level.ghost.var_3899d8bb3c7a255f = create_deck(aliases, 1, 1, 1);
  }

  level.ghost thread say_team(level.ghost.var_3899d8bb3c7a255f deck_draw());
  thread function_6d6fdc1a63d22010(guy);
  wait 0.5;

  if(!isalive(guy) && guy fake_stealth::function_d96c4b7d95d409c5()) {
    return false;
  }

  guy_eye = guy getEye();
  num = randomintrange(1, 7);
  thread play_sound_in_space("generic_explodeath_enemy_" + num, guy_eye);
  magicbullet(level.ghost.weapon, level.ghost getshootfrompos(), guy_eye, level.ghost, level.ghost);

  if(guy ai_armor::istier3()) {
    playFXOnTag(guy.var_fbf555896f954157, guy, "j_head");
    guy thread ai_armor::ai_attachhead();
  } else {
    playFXOnTag(level.g_effect["human_gib_head"], guy, "j_head");
  }

  waitframe();
  level delaythread(0.2, &play_sound_in_space, "sniper_crack_med_near", guy_eye);

  if(isalive(guy)) {
    guy dodamage(guy.health + 1, guy getEye(), level.ghost);
  }

  wait 0.7;

  if(!isDefined(level.ghost.killfirm)) {
    aliases = [];
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_droppedone";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_onesdown";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_dumpedone";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_chalkedem";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_theyredown";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_targeteliminated";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_gotthatone";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_xraydown";
    aliases[aliases.size] = "dx_sp_flas_mks3_ghos_dustedem";
    level.ghost.killfirm = utility::create_deck(aliases, 1, 1, 1);
  }

  level.ghost thread say_team(level.ghost.killfirm deck_draw());
  return true;
}

function function_c928509c26a2495b() {
  aliases = [];
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_watcheast";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_eastsidetheyreflanki";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_checkyoureastflank";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_checkwest";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_westflank";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_theyreflankingwestsi";
}

function function_6d6fdc1a63d22010(guy) {
  lasertag = level.ghost.lasertag;
  var_ff8224b52138466c = 10;

  for(i = 0; i < var_ff8224b52138466c; i++) {
    from = level.ghost gettagorigin("tag_flash");
    lasertag.origin = from;
    start = guy.origin;
    end = guy getEye();
    normalizedtime = normalize_value(0, var_ff8224b52138466c, i);
    endvector = factor_value(guy.origin, guy getEye(), normalizedtime);
    to = endvector;
    lasertag.angles = vectortoangles(to - from);
    waitframe();

    if(i == 0) {
      lasertag laserforceon();
    }
  }

  targetorigin = guy getEye();
  var_8e1060ec0682d1af = targetorigin;
  seconds = 1;
  frames = seconds * 20;

  for(i = 0; i < frames; i++) {
    from = level.ghost gettagorigin("tag_flash");
    lasertag.origin = from;
    to = isalive(guy) ? guy getEye() : var_8e1060ec0682d1af;
    to += randomvectorrange(1, 2);
    lasertag.angles = vectortoangles(to - from);
    waitframe();
  }

  zoffset = 12;
  var_61aba1c4b2487ad0 = zoffset;
  accel = 0;

  for(i = 0; i < 40; i++) {
    from = level.ghost gettagorigin("tag_flash");
    lasertag.origin = from;
    to = var_8e1060ec0682d1af + (0, 0, var_61aba1c4b2487ad0);
    to += randomvectorrange(1, 2);
    lasertag.angles = vectortoangles(to - from);
    waitframe();
    accel += 3;
    var_61aba1c4b2487ad0 += zoffset + accel;
  }

  lasertag laserforceoff();
}

function function_f65dfd824503ceab() {
  self.var_e31ee88092e41cc8 = 1;
}

function function_36854777502b86cd() {
  if(isendstr(self.classname, "shield")) {
    thread shield_guy();
    return;
  }

  function_d5a6dfb27ac0789b();
}

function shield_guy() {
  self endon("death");

  if(!flag("shield_guys_spawned")) {
    flag_set("shield_guys_spawned");
  }

  self.var_c833409fb72d15fb = 1;
  set_movement_speed(65);
  waittill_2("reached_path_end", "bullethit");
  self.var_c833409fb72d15fb = 0;
  utility::clear_movement_speed();
}

function function_d5a6dfb27ac0789b() {
  self.lastenemysightpos = level.player.origin;
  self getenemyinfo(level.player);
  self forcethreatupdate();
}

function last_bus_enemy() {
  last_enemy("last_bus_enemy");
}

function last_enemy(var_f9788b8e98c2aa1e) {
  level.player endon("death");

  while(getaiarray("axis").size > 2) {
    waitframe();
  }

  var_12bf53e8bd9f57d0 = undefined;

  foreach(guy in getaiarray("axis")) {
    if(guy == level.makarov) {
      continue;
    }

    if(isalive(guy)) {
      var_12bf53e8bd9f57d0 = guy;
    }
  }

  if(isDefined(var_f9788b8e98c2aa1e)) {
    flag_set(var_f9788b8e98c2aa1e);
  }

  if(!isalive(var_12bf53e8bd9f57d0)) {
    return;
  }

  if(isendstr(var_12bf53e8bd9f57d0.classname, "shield")) {
    return;
  }

  var_12bf53e8bd9f57d0 endon("death");

  while(true) {
    if(flag("last_bus_enemy")) {
      playergroundpos = (level.player.origin[0], level.player.origin[1], -804);
      points = function_87cd346268b29531(playergroundpos, 150, 270, 70, 40);

      if(istrue(points.size)) {
        foreach(point in points) {
          if(level.player math::is_point_in_front(point)) {
            var_32d00b5d5e121172 = point;
            break;
          }
        }
      }

      if(!isDefined(var_32d00b5d5e121172)) {
        wait 0.15;
        continue;
      }
    } else {
      spot = level.player.origin;
      var_32d00b5d5e121172 = getrandomnavpoint(spot, 70);

      if(!isDefined(var_32d00b5d5e121172)) {
        wait 0.5;
        continue;
      }
    }

    var_12bf53e8bd9f57d0.goalradius = 40;
    var_12bf53e8bd9f57d0 setgoalpos(var_32d00b5d5e121172);
    waittill_player_moves_or_timeout(3);
  }
}

function waittill_player_moves_or_timeout(timeout) {
  level.player endon("death");
  start = gettime();

  while(true) {
    waitframe();

    if(length(level.player getvelocity()) > 30) {
      return;
    }

    if(utility::time_has_passed(start, timeout)) {
      return;
    }
  }
}

function tac_test() {
  while(true) {
    points = function_87cd346268b29531(level.player.origin, 150, 270, 70, 40);

    if(istrue(points.size)) {
      foreach(point in points) {
        color = (1, 0, 0);

        if(level.player math::is_point_in_front(point)) {
          color = (0, 1, 0);
        }

        line(point, point + (0, 0, 500), color, 1, 0, 20);
      }
    }

    wait 1;
  }
}

function function_241a247d7366abb0() {
  level endon("lz_clear");
  wait 2.5;
  callout = [];
  callout[5] = "dx_sp_flas_mks3_ghos_fivethreatsremaining";
  callout[4] = "dx_sp_flas_mks3_ghos_fourxraysstillmoving";
  callout[3] = "dx_sp_flas_mks3_ghos_visualonthreexrays";
  callout[2] = "dx_sp_flas_mks3_ghos_twothreatsremaining";
  callout[1] = "dx_sp_flas_mks3_ghos_onethreatsstilldownt";

  while(true) {
    level waittill("ai_killed");
    wait 1;
    var_6f5fb38edc936b0d = getaiarray("axis").size;

    if(var_6f5fb38edc936b0d > 1) {
      var_f8224da142fed1e0 = var_6f5fb38edc936b0d - 1;

      if(var_f8224da142fed1e0 < 3 && !flag("stop_magic_shooting")) {
        flag_set("stop_magic_shooting");
      }

      if(isDefined(callout[var_f8224da142fed1e0])) {
        level.player say_team(callout[var_f8224da142fed1e0], 0, 1);
      }

      continue;
    }

    return;
  }
}

function function_2a6efec918f82a8a() {
  level endon("lz_clear");
  aliases = [];
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_watchyourleft";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_checkleft";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_onyourleft";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_xraysleftside";
  left_deck = utility::create_deck(aliases, 1, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_watchright";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_rightside";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_checkyourright";
  aliases[aliases.size] = "dx_sp_flas_mks3_ghos_targetsonyourright";
  right_deck = utility::create_deck(aliases, 1, 1, 1);

  while(true) {
    enemies = getaiarray("axis");

    foreach(guy in enemies) {
      if(guy == level.makarov) {
        continue;
      }

      if(!isalive(guy)) {
        continue;
      }

      if(guy canshoot(level.player getEye())) {
        deck = undefined;
        dir = function_968a8fa9191dd675(level.player.angles, level.player.origin, guy.origin);

        if(dir == "left") {
          deck = left_deck;
        } else if(dir == "right") {
          deck = right_deck;
        }

        if(isDefined(deck)) {
          level.player dialogue::say_team(deck deck_draw(), 1, 0, 0, 0.05);
          wait 5;
          break;
        }
      }
    }

    wait 1;
  }
}

function function_fb7308473dadc4b5() {
  autosave_by_name();
  struct1 = getStruct("bus_player_up", "targetname");
  struct2 = getStruct(struct1.target, "targetname");
  mover = level.player spawn_tag_origin();
  level.player playerlinktoabsolute(mover);
  mover move_and_rotate_to(struct1, 2);
  mover move_and_rotate_to(struct2, 0.65);
  level.player unlink();
  mover delete();
}

function stairs_guy() {
  weapon = make_weapon("iw9_ar_mike4_sp", ["ammo_556n", "bar_ar_short_p01_mike4", "grip_vert02", "iw9_rec_mike4", "selectsemi_mike4", "laserbox_ads01", "mag_ar_p01", "pgrip_p01", "fourx02", "stock_ar_p01_mike4"]);
  namespace_47819225b08b445d::function_17177a175dd8f243(weapon);
}

function function_184e1e69e4ddf828() {
  flag_wait("lz_clear");
  flag_set("stop_magic_shooting");
}

function function_6754d636e9823568() {
  level endon("lz_clear");
  wait 5;
  trig = getEnt("escort3_bus_enemy_rear", "target");
  aliases = [];
  aliases[aliases.size] = "dx_sp_flas_mks3_pric_securetheareasergean";
  aliases[aliases.size] = "dx_sp_flas_mks3_pric_makesureitsclearupah";
  aliases[aliases.size] = "dx_sp_flas_mks3_pric_soapgetthisareaclear";
  aliases[aliases.size] = "dx_sp_flas_mks3_pric_illhandlemakarovyouc";
  deck = create_deck(aliases);
  votime = undefined;
  var_1d652fb2ebe872f4 = 115600;

  while(true) {
    var_d0da474964a534a0 = 1;
    var_efd68b721f987a57 = 0;
    var_35af703ad9007a91 = distancesquared(level.player.origin, level.price.origin);

    if(var_35af703ad9007a91 < var_1d652fb2ebe872f4) {
      if(fake_stealth::function_6768c387fe224b2(level.makarov, 1) || fake_stealth::function_6768c387fe224b2(level.price, 1)) {
        var_d0da474964a534a0 = 0;
      }
    }

    if(!var_d0da474964a534a0) {
      if(!isDefined(votime)) {
        var_efd68b721f987a57 = 1;
      } else if(gettime() - votime > 5000) {
        var_efd68b721f987a57 = 1;
      }

      if(var_efd68b721f987a57) {
        level.price say_team(deck deck_draw());
        votime = gettime();
      }
    }

    wait 0.25;
  }
}

function function_530c0fcf8f478a46() {
  flag_set("flyby_heli_complete");
  flag_set("lz_clear");
}

function function_96bdfa1ebedf8404() {
  struct = getStruct("flyby_start", "targetname");
  temp = struct spawn_script_origin();
  temp playLoopSound("jup_flashback_helicopter_exfil_patrol_engine_lp");
  temp scalevolume(0, 0.01);
  waitframe();
  temp scalevolume(1, 9);
  level.var_9a805a1c48fc2918 = temp;
}

function heli_flyby() {
  struct = getStruct("flyby_start", "targetname");

  if(level.start_point == "escort_stadium_exit" || level.start_point == "makarov_escort_3") {
    function_96bdfa1ebedf8404();
  }

  if(level.start_point != "makarov_escort_3") {
    wait 9;
  }

  level.var_9a805a1c48fc2918 thread utility::sound_fade_and_delete(1, 1);
  level.var_e3554f139b424f57 = function_cf86f524a9bd6a64(struct);
  thread namespace_2742a0505262fe0e::function_3d9e1164d143c3c2();

  if(namespace_47819225b08b445d::using_flashlight()) {
    visionsetnaked("", 1);
  }

  flag_set("blima_flyby");
  level.var_e3554f139b424f57 thread scripts\common\vehicle_paths::_vehicle_paths(struct);
  turn = (25133.7, -4751.63, 444.5);

  while(distancesquared(level.var_e3554f139b424f57.origin, turn) > 1000000) {
    waitframe();
  }

  level.var_e3554f139b424f57 thread function_e53dfdbdb6c41de5();
  level thread function_1d2c2b9af2953d35();
  level thread function_19c9fd06778eaba();
  playFXOnTag(getfx("vfx_flashback_heli_vector_field_01"), level.var_e3554f139b424f57, "tag_body");
}

function function_e53dfdbdb6c41de5() {
  self notify("newpath");
  self endon("start_exfil");
  thread heli_smoke_swirl();
  structs = [];
  structs[structs.size] = {
    #angles: (0, 81, 0), #origin: (30341.5, -3127.5, 540.5)
  };
  structs[structs.size] = {
    #angles: (0, 71, 0), #origin: (29771, -4445.5, 633)
  };
  structs[structs.size] = {
    #angles: (0, 50, 0), #origin: (29143, -5816, 540.5)
  };
  var_4c849e239d108bb9 = 10;
  var_44ea4fba6d368a25 = 1;

  while(true) {
    foreach(struct in structs) {
      self setvehgoalpos(struct.origin, 1);
      self setgoalyaw(struct.angles[1]);

      if(istrue(var_44ea4fba6d368a25)) {
        var_44ea4fba6d368a25 = 0;
        thread function_77b25820ec4e1fea(struct.origin);
        temp = spawn_tag_origin();
        temp.origin = (30999, -2566.5, 754);
        self setlookatent(temp);
      }

      while(distancesquared(self.origin, struct.origin) > 202500) {
        waitframe();
      }

      wait randomfloatrange(2.5, 4.5);
    }
  }
}

function heli_smoke_swirl() {
  level endon("exfil_heli_landed");
  spot = (28859, -2724, 266);
  closedist = 3062500;

  while(true) {
    if(distancesquared(self.origin, spot) <= closedist) {
      exploder("heli_smoke_swirl");
      wait 6;
    }

    wait 1;
  }
}

function function_77b25820ec4e1fea(origin) {
  while(distancesquared(self.origin, origin) > 1000000) {
    waitframe();
  }

  self vehicle_setspeed(20, 10, 10);
}

function function_7a7540d0d9745c7b() {
  level.price say_global("dx_sp_flas_mks2_pric_visualontheexitthisw");
  level.makarov ent_flag_wait("mak_moving");
  wait 2;
  level thread function_33a93d33f8b7fc5a();
}

function function_c3ae60ce78a6e109() {
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_dc2aa213aa5830aa();
  escort_globals();
  trigs = getEntArray("trigger_multiple_spawn", "classname");
  array_delete(trigs);
  playerspot = (28563, -3436, -864);
  level.player setOrigin(playerspot);
  level.player setplayerangles((0, 0, 0));
  var_1385824410cbe0e2 = array_remove_array(level.var_4291dad1008f93e6, level.var_1cdebbdf0e614d2d);

  foreach(transient in var_1385824410cbe0e2) {
    settransientvisibility(transient, 0);
  }

  thread exfil_heli();
}

function function_c491ef4666deb499() {
  autosave_by_name();
  thread function_c9cc66db28acc040();
  thread function_2f96fcbbfb50889d();
  thread function_b6c96b7d5b56b154();
  flag_wait("exfil_heli_entered");
  utility::play_skippable_cinematic("sp_jup_flashback_cine_outro", undefined, undefined, 0, 1);
  nextmission();
}

function function_b6c96b7d5b56b154() {
  flag_wait("scriptables_ready");
  wait 2;
  stopcinematicingame();
}

function function_2f96fcbbfb50889d() {
  flag_wait("shepherd_spawned");
  thread function_82e52e948b7b7b67();
  level.shepherd say_team("dx_sp_flas_mks3_shep_bravo6wereinboundtot");
  wait 0.6;
  level.price say_team("dx_sp_flas_mks3_pric_solidcopyweremoving");
  flag_wait("exfil_heli_interact");
  level.ghost say_team("dx_sp_flas_xfil_ghos_letsmoveletsmove");
  aliases = [];
  aliases[aliases.size] = "dx_sp_flas_xfil_shep_timetogosergeant";
  aliases[aliases.size] = "dx_sp_flas_xfil_shep_getonthebirdletsgo";
  aliases[aliases.size] = "dx_sp_flas_xfil_shep_moveyourasssergeantg";
  level.shepherd nag_wait("exfil_scene_started", aliases, 7, 7);
}

function function_82e52e948b7b7b67() {
  stopmusicstate("mx_flashback_finalescort");
}

function function_2648381f838e5aae() {
  thread function_d02ec7ff94a3456f();
  function_74b86eedd600a7ec();
  waitframe();
  flag_set("exfil_heli_setup");
}

function function_f067de06a9feecd9() {
  temp = [];
  namespace_47819225b08b445d::function_6d3328a601ec7b66();
  level.shepherd namespace_47819225b08b445d::hide_me();
  temp[temp.size] = level.shepherd;
  level.soap = namespace_47819225b08b445d::function_320fe24554ccda96();
  level.soap namespace_47819225b08b445d::hide_me();
  temp[temp.size] = level.soap;
  temp[temp.size] = level.ghost;
  level.exfil_heli anim_first_frame([level.soap], "exfil");
  level.ghost unlink();
  waitframe();
  level.exfil_heli anim_first_frame([level.shepherd, level.ghost], "heli_open_idle", "tag_body");
  waitframe();
  array_call(temp, &linkto, self, "tag_body");
  waitframe();
  array_thread([level.ghost, level.shepherd], &namespace_47819225b08b445d::show_me);
}

function function_74b86eedd600a7ec() {
  spawner = getvehiclespawner("blima_physics_spawner", "targetname");
  temp = {
    #angles: (0, 135.29, 0), #origin: (17933.5, -11177.5, 2714.5)
  };
  offset = rotatevectorinverted(temp.origin - spawner.origin, spawner.angles);
  var_c2c8c70028c55fe4 = self.origin + rotatevector(offset, self.angles);
  var_2c489790a1142b26 = self.angles + (0, 90, 0);
  temp = spawn_tag_origin(var_c2c8c70028c55fe4, var_2c489790a1142b26);
  temp linkTo(self, "tag_body");
  self.var_995d34cdeeb700fa = temp;
  namespace_47819225b08b445d::spawn_ghost();
  level.ghost linkTo(self.var_995d34cdeeb700fa, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.ghost allowedstances("crouch");
  level.ghost set_gunpose("ads");
  level.ghost.sidearm = nullweapon();
  level.ghost delaythread(2, &ghost_laser);
}

function ghost_laser() {
  self.lasertag = spawn("script_model", (0, 0, 0));
  self.lasertag setModel("tag_laser");
  self.lasertag notsolid();
  temp = makeweapon("jup_green_beam_flashback");
  self.lasertag setmoverlaserweapon(temp);
}

function function_1e03354e74d3c54() {
  thread anim_loop_solo(level.ghost, "heli_landed_idle");
  thread anim_loop_solo_with_nags(level.shepherd, "heli_landed_idle");
  flag_set("exfil_heli_ready");
}

function function_fc13141d330a0ea0() {
  flag_wait("exfil_heli_setup");
  level.price notify("stop_escorting");
  namespace_47819225b08b445d::function_f1864fb398798ed6(0);
  level.player_rig = spawn_anim_model("player_rig");
  level.player_rig namespace_47819225b08b445d::hide_me();
  level.var_bf027cb717ac1ca4 notify("stop_loop");
  level.var_bf027cb717ac1ca4 anim_first_frame([level.price, level.makarov, level.player_rig], "exfil");
  dialogue::function_54d3bd59bff7e908();
  scripts\sp\anim::igc_camera(1);
  scripts\sp\anim::letterbox_enable(1);
  level.price visiblenotsolid();
  level.ghost visiblenotsolid();
  level.shepherd visiblenotsolid();
  level.makarov visiblenotsolid();
  var_b1e49ac1b4ff6df7 = {
    #bottomarc: 0, #toparc: 0, #leftarc: 0, #rightarc: 0
  };
  namespace_47819225b08b445d::function_8da3daaa6d7ab1a1(var_b1e49ac1b4ff6df7);
  var_20a45bdf9b4d6cfe = [level.soap, level.price, level.player_rig, level.ghost, level.exfil_heli, level.makarov, level.shepherd];
  var_1d174456e05e998b = [level.soap];
  array_thread(var_1d174456e05e998b, &namespace_47819225b08b445d::show_me);
  array_thread(var_20a45bdf9b4d6cfe, &function_89af8e32c81a21d2);
  level.var_bf027cb717ac1ca4 notify("stop_loop");
  level.exfil_heli solid();
  level.var_bf027cb717ac1ca4 anim_single(var_20a45bdf9b4d6cfe, "exfil");
}

function function_89af8e32c81a21d2() {
  self waittillmatch("single anim", "end");
  level.var_bf027cb717ac1ca4 anim_last_frame_solo(self, "exfil");
}

function exfil_heli() {
  var_880ea55eabc0f3d1 = getStruct("exfil_land", "script_noteworthy");

  if(isDefined(level.var_e3554f139b424f57)) {
    level.exfil_heli = level.var_e3554f139b424f57;
    level.exfil_heli notify("newpath");
    level.exfil_heli notify("start_exfil");
  } else {
    structs = [];
    structs[structs.size] = {
      #angles: (0, 81, 0), #origin: (30341.5, -3127.5, 540.5)
    };
    structs[structs.size] = {
      #angles: (0, 71, 0), #origin: (29771, -4445.5, 633)
    };
    structs[structs.size] = {
      #angles: (0, 50, 0), #origin: (29143, -5816, 540.5)
    };
    level.exfil_heli = function_cf86f524a9bd6a64(random(structs));
  }

  function_48de81aa8f550174();
  level.exfil_heli notsolid();
  level.var_bf027cb717ac1ca4 thread function_1e03354e74d3c54();
  flag_set("exfil_heli_landed");
  flag_wait("exfil_heli_ready");
  level.player clearhudtutorialmessage();
  level thread function_e9e65c4a674dcdb3();
  spot = level.exfil_heli gettagorigin("side_door_l_jnt");
  spot += (0, 50, -25);
  level.shepherd scripts\sp\player\cursor_hint::create_cursor_hint("j_wrist_ri");
  level.exfil_heli_interact = level.shepherd;
  namespace_47819225b08b445d::function_f1864fb398798ed6(0);
  flag_set("exfil_heli_interact");
  level.exfil_heli_interact waittill("trigger");
  level.player setsoundsubmix("sp_jup_flashback_outro", 1);
  level.player clearsoundsubmix("sp_jup_flashback_pre_outro", 1.5);
  level.player clearsoundsubmix("sp_jup_flashback_exit_garage", 1.5);
  thread function_8615a6b7cd263577();
  flag_set("exfil_scene_started");
  function_fc13141d330a0ea0();
  flag_set("exfil_heli_entered");
}

function function_37de6f0bb70d8c45() {
  script_origin = getEnt("blima_player_coll_root", "targetname");

  if(isDefined(script_origin)) {
    script_brushmodel = getEnt(script_origin.target, "targetname");
    script_brushmodel linkTo(script_origin);
    script_origin linkTo(level.exfil_heli, "tag_origin", (0, 0, 0), (0, 0, 0));
  }
}

function function_48de81aa8f550174() {
  nodepos = (28983.3, -3511.4, -748);
  nodeangles = (0, 80, 0);
  var_bf027cb717ac1ca4 = {
    #angles: nodeangles, #origin: nodepos
  };
  level.var_bf027cb717ac1ca4 = var_bf027cb717ac1ca4;
  level.exfil_heli.animname = "heli";
  level.exfil_heli scripts\common\vehicle::vehicle_lights_off();
  startpos = getstartorigin(nodepos, nodeangles, level.exfil_heli getanim("land"));
  startangles = getstartangles(nodepos, nodeangles, level.exfil_heli getanim("land"));
  level.exfil_heli function_488ba3c1dd47ae93();
  waitframe();
  level.exfil_heli clearlookatent();
  var_f4047c091b96e51b = startpos + (0, 0, 150);
  level.exfil_heli setturningability(1);
  level.exfil_heli setvehgoalpos(var_f4047c091b96e51b, 1);
  level.exfil_heli vehicle_setspeed(30, 5, 5);
  level.exfil_heli sethoverparams(0, 0, 0);
  level.exfil_heli delaycall(2, &setgoalyaw, startangles[1]);
  level.exfil_heli delaycall(2, &settargetyaw, startangles[1]);
  var_1d652fb2ebe872f4 = 3600;

  while(distancesquared(level.exfil_heli.origin, var_f4047c091b96e51b) > var_1d652fb2ebe872f4) {
    waitframe();
  }

  while(abs(level.exfil_heli.angles[1] - startangles[1]) > 3) {
    waitframe();
  }

  flag_wait("lz_clear");
  level thread function_e5303500f4d98669();
  thread function_26dacc8f0e31a7ec();
  var_f4047c091b96e51b = startpos;
  level.exfil_heli setvehgoalpos(var_f4047c091b96e51b, 1);
  level.exfil_heli vehicle_setspeed(10, 8);
  var_1d652fb2ebe872f4 = 9;

  while(distancesquared(level.exfil_heli.origin, var_f4047c091b96e51b) > var_1d652fb2ebe872f4) {
    waitframe();
  }

  exploder("heli_dust");
  delaythread(1.5, &function_37de6f0bb70d8c45);
  level.exfil_heli setvehiclelookattext("", &"");
  dummy = spawn("script_model", level.exfil_heli.origin);
  dummy.angles = level.exfil_heli.angles;
  dummy setModel(level.exfil_heli.model);
  dummy.animname = level.exfil_heli.animname;
  dummy function_fa51684927851b1c();
  dummy heli_pilot();
  dummy setscriptablepartstate("engine", "on", 0);
  dummy setscriptablepartstate("vector_field", "on", 0);
  level.exfil_heli hide();
  level.exfil_heli = dummy;
  fb_lighting::function_9985ab0a5b897efb(level.exfil_heli, "exfil_heli");
  array_call([level.ghost, level.shepherd], &unlink);
  level notify("sfx_heli_anim");
  var_bf027cb717ac1ca4 animation::anim_single([level.exfil_heli, level.ghost, level.shepherd], "land");
  var_bf027cb717ac1ca4 thread animation::anim_loop_solo(level.exfil_heli, "land_idle");
}

function function_26dacc8f0e31a7ec() {
  level.exfil_heli sound_fade_and_delete(8);
  soundorg = spawn("script_origin", level.exfil_heli.origin);
  soundorg linkTo(level.exfil_heli);
  soundorg playSound("scn_jup_flashback_heli_descend_01");
  level waittill("sfx_heli_anim");
  var_8f140e0a51f8236c = spawn("script_origin", level.exfil_heli.origin);
  var_8f140e0a51f8236c linkTo(level.exfil_heli);
  var_8f140e0a51f8236c playSound("scn_jup_flashback_heli_descend_02");
  var_8f140f0a51f8259f = spawn("script_origin", level.exfil_heli.origin);
  var_8f140f0a51f8259f linkTo(level.exfil_heli);
  var_8f140f0a51f8259f playLoopSound("scn_jup_flashback_heli_debris_lp");
  wait 9.5;
  var_8f140c0a51f81f06 = spawn("script_origin", level.exfil_heli.origin);
  var_8f140c0a51f81f06 linkTo(level.exfil_heli);
  var_8f140c0a51f81f06 playLoopSound("scn_jup_flashback_heli_grnd_idle_lp");
  flag_wait("exfil_heli_entered");
  soundorg delete();
  var_8f140e0a51f8236c delete();
  var_8f140f0a51f8259f thread sound_fade_and_delete(0.3, 1);
  var_8f140c0a51f81f06 thread sound_fade_and_delete(0.3, 1);
}

function function_e5303500f4d98669() {
  level endon("exfil_heli_landed");
  pt1 = (29016, -3315, -858.5);
  pt2 = (28905.5, -3952, -858.5);
  var_bdf2c1e712001b89 = 0;
  cutoff = 6400;

  while(true) {
    var_e0f9ee0fce02500b = pointonsegmentnearesttopoint(pt1, pt2, level.player.origin);
    inzone = distancesquared(var_e0f9ee0fce02500b, level.player.origin) <= cutoff;

    if(inzone && isDefined(level.player.last_unresolved_collision_time)) {
      level.player.health = 1;
      level.player player::damagebloodoverlay(level.exfil_heli.origin, 0.9, "MOD_RIFLE_BULLET");
      level.player playSound("hero_explodeath_soap_1");
      level.player playSound("scn_flashback_heli_plr_kill");
      wait 0.1;
      utility::fade_out();
      utility::default_unresolved_collision_handler();
      return;
    }

    if(inzone && !var_bdf2c1e712001b89) {
      var_bdf2c1e712001b89 = 1;
      level.player sethudtutorialmessage(&"SP_JUP_FLASHBACK/LANDING_HINT", 1);
    } else if(!inzone && var_bdf2c1e712001b89) {
      var_bdf2c1e712001b89 = 0;
      level.player clearhudtutorialmessage();
    }

    waitframe();
  }
}

function function_e9e65c4a674dcdb3() {
  level endon("exfil_scene_started");
  origin = (28983.5, -3511, -748);
  radiussqrd = 134689;
  height = 60;
  up = (0, 0, 1);

  while(true) {
    while(level.player isonground()) {
      waitframe();
    }

    if(math::pointvscylinder(level.player.origin, radiussqrd, 30, origin, up)) {
      level.player dodamage(9999, level.player.origin, undefined, undefined, "MOD_IMPACT");
      return;
    }

    waitframe();
  }
}

function function_488ba3c1dd47ae93() {
  function_f067de06a9feecd9();
  sniper = level.ghost.weapon;
  level.ghost script_func("anim_placeweaponon", sniper, "chest");
  level.ghost script_func("anim_placeweaponon", level.ghost.secondary, "right");
  level.ghost script_func("anim_placeweaponon", sniper, "back");
}

function heli_pilot() {
  level.pilot = namespace_47819225b08b445d::function_350377b71c3dfd2e();
  level.pilot detach(level.pilot.headmodel);
  level.pilot.headmodel = "head_russian_helicopter_pilot";
  level.pilot attach(level.pilot.headmodel);
  level.pilot.animname = "pilot";
  level.pilot.script_friendname = undefined;
  level.pilot.name = undefined;
  level.pilot scripts\sp\names::get_name();
  level.pilot utility::function_ab35ae296c8f8609("Bubba");
  animation::anim_first_frame_solo(level.pilot, "idle", "tag_seat_0");
  waitframe();
  level.pilot linkTo(self, "tag_seat_0");
  level.pilot setanim(level.pilot utility::getanim("idle"), 1, 0.05);
}

function function_8615a6b7cd263577() {
  setmusicstate("mx_flashback_exfil");
}

function function_c9cc66db28acc040() {
  lower_location = {
    #targetname: "lower", #angles: (0, 335, 0), #origin: (28020, -2930, -862)
  };
  level.price say_team("dx_sp_flas_mks3_pric_movingupwithmakarov");

  if(level.start_point != "exfil") {
    level.makarov.goalradius = 32;
    level.makarov setgoalpos(lower_location.origin);
    level.price thread function_c5ba10c4d4bed413();
    thread function_2bbd12be32ea70f5(1);
  }

  while(!should_teleport(lower_location)) {
    wait 0.2;
  }

  level.price forceteleport(lower_location.origin, lower_location.angles, 9999);
  level.price delaythread(0.05, &function_fcb4c5a996517164);
  spot = lower_location.origin + anglesToForward(lower_location.angles) * 70;
  level.makarov forceteleport(spot, lower_location.angles, 9999);
  level.makarov delaythread(0.05, &function_fcb4c5a996517164);
  flag_set("price_ready_to_exfil");
  wait 0.1;
  level.makarov function_999503858b0cfd1();
  level.price thread function_c5ba10c4d4bed413();
  level.price function_2bbd12be32ea70f5(1);
}

function should_teleport(struct) {
  if(!struct math::is_point_in_front(level.player.origin)) {
    return false;
  }

  if(distancesquared(level.player.origin, struct.origin) < 90000) {
    return false;
  }

  var_6db7d3fcfba74403 = function_2f418ef8dd27221d();

  if(within_fov(level.player.origin, level.player.angles, level.makarov.origin, cos(var_6db7d3fcfba74403))) {
    if(function_42a35aa092d8a05a()) {
      return false;
    }
  }

  if(function_abb3b74d310505bf(struct)) {
    return false;
  }

  start = struct.origin + (0, 0, 40);
  right = start + anglestoright(struct.angles) * 30;

  if(within_fov(level.player.origin, level.player.angles, struct.origin, cos(var_6db7d3fcfba74403))) {
    if(trace::ray_trace_passed(level.player getEye(), right)) {
      return false;
    }
  }

  return true;
}

function function_999503858b0cfd1() {
  origin = self == level.price ? (28738.5, -3496, -848.5) : (28812, -3484.5, -848.5);
  angles = (0, 0, 0);
  newnode = spawncovernode(origin, angles, "Exposed", 8, self.animname + "_exfil_node");
  self.goalradius = 32;
  self setgoalnode(newnode);
}

function function_6da48ae496824cd6() {}

function function_60c47ca07ab2292d() {
  if(isDefined(self.follow_ent)) {
    return;
  }

  disable_pain();
  self.ignoreme = 1;
  self.ignoreall = 1;
  self function_9f82c74eb1b7caf9(0);
  self.grenadeawareness = 0;

  if(scripts\sp\friendlyfire::iscivilian()) {
    self function_b661b022700ba72f("systemic", 0);
    self function_b661b022700ba72f("script", 1);
  }

  self.pushable = 1;
  spot = self.origin + anglesToForward((0, self.angles[1], 0)) * -70;
  self.follow_ent = spawn("script_origin", spot);
  self.follow_ent.angles = self.angles;
  self.follow_ent linkTo(self);
  set_movement_speed(60);
  thread function_50ce7ac8d8fc56ca();
  level.dragged_ai = self;
}

function function_2bbd12be32ea70f5(bool) {
  level.price.dontevershoot = bool;
  level.makarov.ignoreme = !bool;
}

function function_b1853f791f900c4e(node) {
  level notify("new_makarov_node");
  level endon("new_makarov_node");
  var_82474633ebdcb6e2 = getnode(node.target, "targetname");
  level childthread function_3fc4342abeac0064(var_82474633ebdcb6e2);
}

function function_e553c53012cc2e1a() {
  if(!isDefined(self.stayahead)) {
    namespace_47819225b08b445d::function_9759891d24e704e7("price_lead");
    scripts\sp\utility::enable_stayahead(level.makarov);
  }

  outcome = waittill_any_return_3("goal", "shooting");
  scripts\sp\utility::disable_stayahead();
}

function function_92d7927591bba29() {
  max_axis = 0;

  if(level.makarov.team == "axis") {
    max_axis = 1;
  }

  if(getaiarray("axis").size > max_axis) {
    return true;
  }

  if(distancesquared(level.player.origin, self.origin) > 62500) {
    return true;
  }

  if(self isinscriptedstate()) {
    return true;
  }

  return false;
}

function function_3fc4342abeac0064(node) {
  level.price utility::enable_cqbwalk();
  level.price.goalradius = 32;
  level.price setgoalnode(node);
  level.price waittill("goal");
  level.price.goalradius = 150;
}

function function_c75b8c8f91187c0f(dragged_ai) {
  self.goalradius = 10;
  self setgoalentity(dragged_ai.follow_ent);
  waitframe();
  self waittill("goal");
}

function function_c5ba10c4d4bed413() {
  self notify("stop_escorting");
  self endon("stop_escorting");
  dragged_ai = level.makarov;
  self.goalradius = 10;
  self setgoalentity(dragged_ai.follow_ent);
  maxdist = 300;
  mindist = 150;
  maxspeedextra = 15;
  var_4e6dfedfe968ed2c = 6;
  self.disablearrivals = 1;
  self.disableexits = 1;

  while(true) {
    speed = length(dragged_ai.velocity);

    if(speed > 200) {
      waitframe();
      continue;
    }

    dist = int(distance2d(self.origin, dragged_ai.origin));

    if(dist > 130 && speed < 5) {
      speed = 90;
    }

    dist_normalized = math::normalize_value(mindist, maxdist, dist);
    speedextra = math::factor_value(var_4e6dfedfe968ed2c, maxspeedextra, dist_normalized);
    set_movement_speed(speed + int(speedextra));
    wait 0.15;
  }
}

function function_b0abd436448388f0() {
  level.price notify("stop_escorting");
  level.price.disablearrivals = 0;
  level.price.disableexits = 0;
  level.price utility::clear_movement_speed();
}

function geyser_spawner(spawner_name, ai_amount, forcespawn) {
  if(isstring(spawner_name)) {
    spawner = getspawner(spawner_name, "targetname");
  } else {
    spawner = spawner_name;
  }

  if(!isDefined(spawner)) {
    return;
  }

  spawner.count = ai_amount + 1;
  guys = [];

  for(i = 0; i < ai_amount; i++) {
    guy = spawner spawn_ai(forcespawn);

    if(!spawn_failed(guy)) {
      guys[guys.size] = guy;
    } else {
      continue;
    }

    if(ai_amount > 1) {
      start = guy.origin;

      while(distance(guy.origin, start) < 40) {
        waitframe();
      }
    }
  }

  if(guys.size < ai_amount) {
    println("<dev string:xa5>" + ai_amount + "<dev string:xc1>" + guys.size);
  }

  return guys;
}

function function_71f9a2e975fa8480() {
  if(isnullweapon(self.weapon)) {
    return undefined;
  }

  switch (weaponclass(self.weapon)) {
    case #"hash_6191aaef9f922f96":
    case #"hash_61e969dacaaf9881":
      radius = 1500;
      break;
    case #"hash_8cdaf2e4ecfe5b51":
    case #"hash_fa24dff6bd60a12d":
      radius = 800;
      break;
    case #"hash_719417cb1de832b6":
    case #"hash_900cb96c552c5e8e":
      radius = 650;
      break;
    case #"hash_690c0d6a821b42e":
      radius = 450;
      break;
  }

  assert(isDefined(radius));
  self.goalradius = radius;
}

function escort_cover(bool) {
  flag_wait("scriptables_ready");
  ents = getEntArray("escort_cover", "targetname");
  scriptables = getscriptablearray("escort_cover", "targetname");
  ents = array_combine(ents, scriptables);
  gate = getEnt("escort_gate", "targetname");
  var_f2feac4ac119e9ed = getEnt("car_corpse", "targetname");
  var_ae2cb8519d6ee23 = getEnt("escort_cover_ai_blocker", "targetname");
  ents[ents.size] = getEnt("police_road_block", "targetname");
  ents[ents.size] = getEnt("lights_car", "targetname");

  if(isDefined(var_ae2cb8519d6ee23)) {
    if(istrue(bool)) {
      var_ae2cb8519d6ee23 disconnectPaths();
    } else {
      var_ae2cb8519d6ee23 connectpaths();
    }
  }

  if(!istrue(bool)) {
    gate hide();
    var_f2feac4ac119e9ed hide();

    foreach(item in ents) {
      if(isDefined(item.spawnflags) && item.spawnflags & 1) {
        item connectpaths();
      }

      if(isDefined(item.target)) {
        clip = getEnt(item.target, "targetname");
        clip notsolid();

        if(clip.spawnflags & 1) {
          clip connectpaths();
        }
      }

      if(item isscriptable()) {
        item.origin -= (0, 0, 200);
        continue;
      }

      item hide();
      item notsolid();
    }

    return;
  }

  gate show();
  var_f2feac4ac119e9ed show();
  var_f2feac4ac119e9ed thread function_ee1ad0a843d2dce7();

  foreach(item in ents) {
    if(isDefined(item.spawnflags) && item.spawnflags & 1) {
      item disconnectPaths();
    }

    if(isDefined(item.target)) {
      clip = getEnt(item.target, "targetname");
      clip solid();

      if(clip.spawnflags & 1) {
        clip disconnectPaths();
      }
    }

    if(item isscriptable()) {
      item.origin += (0, 0, 200);
      continue;
    }

    item show();
    item solid();
  }

  structs = getStructArray("tunel_exit_civ_corpse", "targetname");
  array_thread(structs, &namespace_47819225b08b445d::function_66d93860c587390b);
}

function function_ee1ad0a843d2dce7() {
  struct = getStruct(self.target, "targetname");
  body = spawn_anim_model("burnt_body");
  struct anim_single_solo(body, "death");
}

function function_50ce7ac8d8fc56ca() {
  level endon("escort2_done");
  function_a98442bae2591402();
  childthread function_d1a1e5a8d7ec74fa();
  level function_f738af1ded4011f1();
  level function_7cfbe06ab619cfda();
  level thread player_gesture_melee();

  while(true) {
    function_fab94f5af62a2ab5();
    self.interact waittill("trigger", data);
    function_3592d29556865d92();
    level.var_14ef7af800bfa3a4 = gettime();

    while(level.player meleeButtonPressed()) {
      waitframe();
    }

    wait 0.35;
  }
}

function function_935e703667d646a8() {
  if(isDefined(level.makarov)) {
    if(level.makarov namespace_47819225b08b445d::function_ba89deba9a62fafb()) {
      return true;
    }

    if(function_7fc92f3278e306a7()) {
      return true;
    }
  }

  return false;
}

function function_7fc92f3278e306a7() {
  return isDefined(level.var_14ef7af800bfa3a4) && gettime() - level.var_14ef7af800bfa3a4 < 1000;
}

function player_gesture_melee() {
  level endon("stop_player_gesture_melee");
  level childthread function_ea577a884f6de6de();
  level.player.allow_melee = 1;

  while(true) {
    if(!function_afaaaca2c35aca6a()) {
      level.player val::set("makarov_escort", "melee", 0);
      level.player.allow_melee = 0;

      while(!function_afaaaca2c35aca6a()) {
        waitframe();
      }

      level.player val::set("makarov_escort", "melee", 1);
      level.player.allow_melee = 1;
    }

    waitframe();
  }
}

function function_ea577a884f6de6de() {
  gesturename = "fbk_gesture_makarov_shove";
  temp = spawn_tag_origin();
  temp linkTo(level.makarov, "j_spine4", (0, 0, 0), (0, 0, 0));
  var_a07c8a34027231b5 = create_deck(["dx_sp_flas_mks1_pric_ivegotmakarovmoveup", "dx_sp_flas_mks3_pric_illhandlemakarovyouc"]);

  while(true) {
    if(level.player meleeButtonPressed() && !level.player.allow_melee && function_c40e4448d7a73ff5()) {
      success = level.player forceplaygestureviewmodel(gesturename, temp, 0.2, undefined, undefined, undefined, undefined);

      if(success) {
        screenshake(level.player.origin, 7, 0, 7, 0.5, 0.3, 0.2, 0, 1, 1, 1);
        wait 0.25;
        level.player playSound("fbk_makarov_push_shove");
        level.makarov.interact notify("trigger", "shove");
        level.player playRumbleOnEntity("damage_heavy");
        earthquake(0.4, 0.4, level.player.origin, 50);
        level.player.var_84ffdf3134508ee9 = gettime();

        if(level.makarov isinscriptedstate()) {
          wait 0.8;
          continue;
        }

        if(!isDefined(level.player.var_8b3b33d47adcd2d9) || time_has_passed(level.player.var_8b3b33d47adcd2d9, 1)) {
          if(function_83b118639b208999()) {
            var_38a48c09bd76d8f5 = 0;

            if(!flag("mak_at_truck")) {
              var_38a48c09bd76d8f5 = 1;
              level.player thread say_self(level.var_1f52a9d512331fa8 deck_draw(), 1, 0.25);
            } else if(!level.price dialogue::function_ed8a0ba27b9104c5()) {
              var_38a48c09bd76d8f5 = 1;
              level.price thread say_team(var_a07c8a34027231b5 utility::deck_draw());
            }

            if(var_38a48c09bd76d8f5) {
              level.var_a7d3fb4cd387e8df = gettime();
            }
          }

          level.player.var_8b3b33d47adcd2d9 = gettime();
          level.makarov thread function_f9a969e3f758caf7();
        }

        while(level.player isgestureplaying(gesturename)) {
          waitframe();
        }
      }
    }

    waitframe();
  }
}

function function_83b118639b208999() {
  if(level.makarov dialogue::function_ed8a0ba27b9104c5()) {
    return false;
  }

  if(level.player dialogue::function_ed8a0ba27b9104c5()) {
    return false;
  }

  if(!isDefined(level.var_a7d3fb4cd387e8df)) {
    return true;
  } else if(utility::time_has_passed(level.var_a7d3fb4cd387e8df, 6)) {
    return true;
  }

  return false;
}

function function_f9a969e3f758caf7() {
  self notify("shoved");
  self endon("shoved");
  dir = function_968a8fa9191dd675(level.makarov.angles, level.makarov.origin, level.player.origin);

  if(!isDefined(level.var_5b52abebbf959ae7)) {
    level.var_5b52abebbf959ae7 = [];
    level.var_5b52abebbf959ae7["front"] = % mkr_cuffed_exp_stand_push_react01_8_add;
    level.var_5b52abebbf959ae7["right"] = % mkr_cuffed_exp_stand_push_react01_6_add;
    level.var_5b52abebbf959ae7["back"] = % mkr_cuffed_exp_stand_push_react01_2_add;
    level.var_5b52abebbf959ae7["left"] = % mkr_cuffed_exp_stand_push_react01_4_add;
  }

  var_855deb442a8a3a70 = length(level.makarov.velocity);

  if(var_855deb442a8a3a70 > 20) {
    level.makarov playSound("scn_fbk_makarov_push_stumble_fs");
  } else {
    level.makarov playSound("scn_fbk_makarov_push_stumble_fs_slow");
  }

  assertex(isDefined(level.var_5b52abebbf959ae7[dir]), "<dev string:xde>");
  self setanimknoballrestart(level.var_5b52abebbf959ae7[dir], %makarov_pushed, 1, 0.1, 1);
  wait 0.1;
  self setanim(level.var_5b52abebbf959ae7[dir], 1, 0.01, 1);
  set_movement_speed(170);
  wait 0.6;
  set_movement_speed(60);
}

function function_968a8fa9191dd675(var_c99a285cabf7ec7b, var_88daf353e30acf25, targetorigin) {
  clock = function_41c948d469bde909(var_c99a285cabf7ec7b, var_88daf353e30acf25, targetorigin);
  dir = undefined;

  if(clock < 2 || clock > 10) {
    dir = "front";
  } else if(clock > 1 && clock < 5) {
    dir = "right";
  } else if(clock > 4 && clock < 8) {
    dir = "back";
  } else if(clock > 7 && clock < 11) {
    dir = "left";
  }

  return dir;
}

function function_41c948d469bde909(var_c99a285cabf7ec7b, var_88daf353e30acf25, targetorigin) {
  forward = anglesToForward(var_c99a285cabf7ec7b);
  vfacing = vectorNormalize(forward);
  var_7004ba7d94d78df6 = vectortoangles(vfacing);
  anglestopoint = vectortoangles(targetorigin - var_88daf353e30acf25);
  angle = var_7004ba7d94d78df6[1] - anglestopoint[1];
  angle += 360;
  angle = int(angle) % 360;

  if(angle > 345 || angle < 15) {
    direction = 12;
  } else if(angle < 45) {
    direction = 1;
  } else if(angle < 75) {
    direction = 2;
  } else if(angle < 105) {
    direction = 3;
  } else if(angle < 135) {
    direction = 4;
  } else if(angle < 165) {
    direction = 5;
  } else if(angle < 195) {
    direction = 6;
  } else if(angle < 225) {
    direction = 7;
  } else if(angle < 255) {
    direction = 8;
  } else if(angle < 285) {
    direction = 9;
  } else if(angle < 315) {
    direction = 10;
  } else {
    direction = 11;
  }

  return direction;
}

function function_c40e4448d7a73ff5() {
  if(isnullweapon(level.player getcurrentweapon())) {
    return false;
  }

  if(level.player isswitchingweapon()) {
    return false;
  }

  if(level.player isreloading()) {
    return false;
  }

  if(level.player isthrowinggrenade()) {
    return false;
  }

  if(level.player isthrowingbackgrenade()) {
    return false;
  }

  if(level.player islinked()) {
    return false;
  }

  if(level.player ismeleeing()) {
    return false;
  }

  return true;
}

function function_afaaaca2c35aca6a() {
  if(level.player isgestureplaying("fbk_gesture_makarov_shove")) {
    return false;
  }

  if(level.player islinked()) {
    return false;
  }

  if(isnullweapon(level.player getcurrentweapon())) {
    return false;
  }

  if(distancesquared(level.player.origin, level.makarov.origin) < 6400) {
    if(utility::within_fov(level.player.origin, level.player.angles, level.makarov.origin, 0.819152)) {
      return false;
    }
  }

  return true;
}

function function_cb05119524e25211() {
  self.var_9aa77ab756fdca82 = 10000;
  self.var_43e2ad424676b8d4 = 200;
  enable_pain();
  delaythread(0.1, &scripts\engine\utility::disable_pain);
  self dodamage(1, level.player.origin, level.player, undefined, "MOD_MELEE");
}

function function_c0495fd5b3c6cdc4() {
  level.makarov thread play_sound_on_entity("melee_character_gun_fatal_layer_plr");
  level.makarov play_sound_on_entity("generic_pain_bodyslam_1");
}

function function_fab94f5af62a2ab5() {
  if(!level.makarov ent_flag("interact_disabled")) {
    return;
  }

  level.makarov ent_flag_clear("interact_disabled");
}

function function_ca6673063e90e8be() {
  var_c831e24d8b8dea68 = 0;

  while(true) {
    level.makarov waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon);

    if(is_equal(attacker, level.player)) {
      if(is_equal(meansofdeath, "MOD_MELEE")) {
        level.makarov.interact notify("trigger");
        continue;
      }

      var_c831e24d8b8dea68 += damage;
      scripts\sp\player_death::set_custom_death_quote(512, 0);
      waitframe();
      level.player missionfailedwrapper();
    }
  }
}

function function_b3a7816a90a4e809() {
  while(true) {
    level.player waittill("weapon_fired");

    if(within_fov(level.player.origin, level.player getplayerangles(), level.makarov.origin, 0.819152)) {
      start = level.player getEye();
      trace = trace::ray_trace(start, start + anglesToForward(level.player getplayerangles()) * 500, level.player);
      spot = trace["position"];

      if(distancesquared(spot, level.makarov.origin) < 8100) {
        level.makarov.interact notify("trigger", "dance");
        wait 2;
      }
    }
  }
}

function function_3592d29556865d92() {
  if(level.makarov ent_flag("interact_disabled")) {
    return;
  }

  level.makarov ent_flag_set("interact_disabled");
  level.makarov.interact unlink();
  level.makarov.interact.origin -= (0, 0, 1000);
}

function function_a98442bae2591402() {
  if(isDefined(self.interact)) {
    return;
  }

  originoffset = (8, 0, 0);
  displayfov = 7;
  usefov = 60;
  display_distance = 500;
  userange = 120;
  var_ba6d09b472221655 = "+melee";
  hintent = spawn_tag_origin((0, 0, 0));
  hintent makeusable();
  hintent setCursorHint("HINT_BUTTON");
  hintent setHintString("");
  hintent sethintdisplayfov(displayfov);
  hintent setusefov(usefov);
  hintent sethintdisplayrange(display_distance);
  hintent setuserange(userange);
  hintent sethintonobstruction("hide");
  hintent setuseholdduration(100);
  hintent setusecommand(var_ba6d09b472221655);
  level thread function_b3a7816a90a4e809();
  level thread function_ca6673063e90e8be();
  self.interact = hintent;
}

function function_d1a1e5a8d7ec74fa() {
  self.is_stopped = 1;

  while(true) {
    while(!namespace_47819225b08b445d::function_ba89deba9a62fafb()) {
      wait 0.15;
    }

    self.is_stopped = 0;

    while(namespace_47819225b08b445d::function_ba89deba9a62fafb()) {
      wait 0.15;
    }

    self.is_stopped = 1;
  }
}

function function_f738af1ded4011f1() {
  aliases = [];
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_move";
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_go";
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_walk";
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_moveyourass";
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_isaidmove";
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_keepwalking";
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_getmoving";
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_moveit";
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_getupthere";
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_letsgo";
  level.var_1f52a9d512331fa8 = create_deck(aliases, 0, 0, 1);
  aliases = [];
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_shovedreaction";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_shovedreaction";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_shovedreaction";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_shovedreaction";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_shovedreaction";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_shovedreaction";
  level.var_ac9d3e18214a8685 = create_deck(aliases, 0, 0, 1);
}

function function_7cfbe06ab619cfda() {
  a = ["Get down!", "Down!", "Get the fuck down!", "Hold here!"];
  level.var_f9da8c88fc765e6b = create_deck(a, 0, 0, 1);
}

function function_8fe00181eb04ba69() {
  level endon("tunnel_enemies_spawned");
  level.makarov.interact waittill("trigger");
  wait 2;
  aliases = [];
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_youthinkyoulljustwal";
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_wecandragyouaswell";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_capturingmeitmeansno";
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_itmeanswebeatyouvlad";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_dontbeafool";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_youcantbeatmeunlessy";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_youwilldiebythedozen";
  aliases[aliases.size] = "dx_sp_flas_mks1_soap_saysthemadmanwhoslau";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_thosewhocameheretoda";
  aliases[aliases.size] = "dx_sp_flas_mks1_maka_eastandwestsidebysid";

  foreach(i, alias in aliases) {
    name = strtok(alias, "_")[4];
    speaker = name == "maka" ? level.makarov : level.player;

    while(!function_6813889c0924e71a(speaker)) {
      wait 0.25;
    }

    if(speaker == level.makarov) {
      speaker thread function_748f51d06333c744("tunnel_enemies_spawned");
    }

    speaker say_global(alias, 0, [level, "tunnel_enemies_spawned"]);
    wait 0.25 + randomfloatrange(0.2, 0.4) + randomfloatrange(0.1, 0.3);

    if(i == 1 || i == 4) {
      wait 1;
    }
  }
}

function function_748f51d06333c744(endon_string) {
  ai_lookat::enablelookatplayer(0.7, 1);
  waittill_any_ents(self, "vo_done_or_cancelled", level, endon_string);
  ai_lookat::disablelookatplayer();
}

function function_6813889c0924e71a(speaker) {
  if(flag("mak_attack")) {
    return 0;
  }

  if(!function_90524b9eff01d882()) {
    if(speaker == level.player) {
      return function_280e3cca1942f597();
    } else {
      return function_bdb05924abca295d();
    }
  }

  return 0;
}

function function_280e3cca1942f597() {
  if(level.player ent_flag("neglecting_makarov")) {
    return false;
  }

  if(level.player dialogue::function_ed8a0ba27b9104c5()) {
    return false;
  }

  if(!level.makarov ent_flag("mak_moving")) {
    return false;
  }

  if(distancesquared(level.player.origin, level.makarov.origin) > 202500) {
    return false;
  }

  return true;
}

function function_bdb05924abca295d() {
  if(distancesquared(level.player.origin, level.makarov.origin) > 250000) {
    return false;
  }

  if(level.makarov dialogue::function_ed8a0ba27b9104c5()) {
    return false;
  }

  if(!level.makarov ent_flag("mak_moving")) {
    return false;
  }

  return true;
}

function function_90524b9eff01d882() {
  return level.price dialogue::function_ed8a0ba27b9104c5();
}

function function_ede1165f87756480() {}

function print_velocity() {
  self endon("death");

  while(true) {
    value = int(length(self.velocity));

    print3d(self getEye() + (0, 0, 10), value, (1, 1, 1), 1, 1, 1, 1);

    waitframe();
  }
}

function function_8fc28ad4eae67966() {}

function function_cd3fa79e814c2459() {
  if(level.player ent_flag("neglecting_makarov")) {
    return false;
  }

  if(flag("mak_attack")) {
    return false;
  }

  return true;
}

function function_1001b2d51b81310c() {
  while(true) {
    if(flag("game_saving")) {
      wait 2;
      continue;
    }

    utility::autosave_by_name();
  }
}

function makattack_watcher() {
  setdvarifuninitialized(@ "hash_8cd2b2e75493773a", "<dev string:xfe>");

  level endon("mak_attack");
  level.player endon("death");
  level endon("stop_makattack_watcher");
  utility::add_extra_autosave_check("mak_attack", &function_cd3fa79e814c2459, "Player may be attacked by Makarov");
  var_3120e732b06edbae = undefined;
  lastorigin = undefined;
  lastyaw = undefined;
  level childthread function_1be999ca64340710();
  level thread function_bffff68002b0acd8();
  wait 3;

  while(true) {
    if(function_2d46c5431b1d52b9()) {
      if(!level.player ent_flag("neglecting_makarov")) {
        level.player ent_flag_set("neglecting_makarov");

        if(level.var_bffff68002b0acd8.origin != level.makarov.origin) {
          level.var_bffff68002b0acd8.origin = level.makarov.origin;
          level.var_bffff68002b0acd8.angles = level.makarov.angles;
        }
      }

      if(!isDefined(lastorigin) || function_3fb7d93311a6b73(lastorigin, lastyaw)) {
        if(function_184c3272f9addda4()) {
          iprintln("<dev string:x100>");
        }

        level.var_bffff68002b0acd8 notify("new_path_to_player");
        thread function_fc242f873639a4f5();
        lastorigin = level.player.origin;
        lastyaw = level.player.angles[1];

        while(!function_3fb7d93311a6b73(lastorigin, lastyaw) && function_2d46c5431b1d52b9()) {
          wait 0.15;
        }
      }
    } else if(level.player ent_flag("neglecting_makarov")) {
      level.player ent_flag_clear("neglecting_makarov");
      level.makarov notify("player_sees_me");

      if(level.var_bffff68002b0acd8.origin != level.makarov.origin) {
        level.var_bffff68002b0acd8.origin = level.makarov.origin;
        level.var_bffff68002b0acd8.angles = level.makarov.angles;
      }
    }

    wait 0.15;
  }
}

function function_bffff68002b0acd8() {
  level.var_bffff68002b0acd8 = spawn("script_model", level.makarov.origin + anglesToForward(level.makarov.angles) * 40);
  level.var_bffff68002b0acd8 setModel(level.makarov.model);
  level.var_bffff68002b0acd8 dontinterpolate();

  if(function_184c3272f9addda4()) {
    scripts\engine\sp\utility::hudoutline_add_channel("<dev string:x119>");
    level.var_bffff68002b0acd8 thread utility::hudoutline_enable_new("<dev string:x122>", "<dev string:x119>");
    return;
  }

  level.var_bffff68002b0acd8 hide();
}

function function_3fb7d93311a6b73(lastorigin, lastyaw) {
  if(distancesquared(lastorigin, level.player.origin) > 1024) {
    return true;
  }

  if(abs(level.player.angles[1] - lastyaw) > 20) {
    return true;
  }

  if(abs(level.player getnormalizedcameramovement()[1]) > 0.15) {
    return true;
  }

  return false;
}

function function_1be999ca64340710() {
  aliases = [];
  aliases[aliases.size] = "dx_sp_flas_mks1_pric_donttakeyoureyesoffm";
  aliases[aliases.size] = "dx_sp_flas_mks1_pric_keepyoureyesonhimser";
  aliases[aliases.size] = "dx_sp_flas_mks1_pric_keepmakarovinfrontof";
  var_e74632924bf4cd7d = utility::create_deck(aliases);

  while(true) {
    level.player ent_flag_wait("neglecting_makarov");
    wait 2;

    if(level.player ent_flag("neglecting_makarov")) {
      level.price say_team(var_e74632924bf4cd7d utility::deck_draw());
      wait 7;
    }
  }
}

function function_fc242f873639a4f5() {
  if(flag("mak_attack")) {
    return;
  }

  level endon("mak_attack");
  level.var_bffff68002b0acd8 endon("new_path_to_player");
  level.makarov endon("player_sees_me");
  level.player endon("death");
  level.var_bffff68002b0acd8 childthread function_773da703f9f11ade();
  var_dcad0d22ab671e80 = undefined;

  while(true) {
    if(isDefined(var_dcad0d22ab671e80)) {
      while(gettime() - var_dcad0d22ab671e80 < 500) {
        waitframe();
      }
    }

    level.var_ac11a5241fa4dfda = undefined;
    points = undefined;
    points = level.makarov findpath(level.var_bffff68002b0acd8.origin, level.player.origin + anglesToForward(level.player.angles) * -30);

    if(!isDefined(points)) {
      continue;
    }

    var_dcad0d22ab671e80 = gettime();

    foreach(point in points) {
      if(distancesquared(level.player.origin, point) > 10000 && !function_abb3b74d310505bf({
          #origin: point
        })) {
        level.var_ac11a5241fa4dfda = point;
        continue;
      }

      break;
    }

    level thread function_37c866d92464400f(points);
    outcome = level.var_bffff68002b0acd8 utility::waittill_any_return_2("spotted", "reached_player");

    if(outcome == "spotted") {
      if(isDefined(level.var_ac11a5241fa4dfda)) {
        level.var_bffff68002b0acd8.origin = level.var_ac11a5241fa4dfda;
      } else {
        level.var_bffff68002b0acd8.origin = level.makarov.origin;
      }

      while(istrue(level.var_bffff68002b0acd8.spotted)) {
        waitframe();
      }

      continue;
    }

    if(outcome == "reached_player") {
      if(function_e472a220ac7d24c8()) {
        level thread function_dfb8f14d04481298();
      }
    }
  }
}

function function_773da703f9f11ade() {
  level.var_bffff68002b0acd8.spotted = undefined;

  while(true) {
    if(function_abb3b74d310505bf(self)) {
      level.var_bffff68002b0acd8 notify("spotted");
      level.var_bffff68002b0acd8.spotted = 1;
    } else if(istrue(level.var_bffff68002b0acd8.spotted)) {
      level.var_bffff68002b0acd8.spotted = undefined;
    }

    wait 0.1;
  }
}

function function_37c866d92464400f(points) {
  level endon("mak_attack");
  level.var_bffff68002b0acd8 notify("moveto_player");
  level.var_bffff68002b0acd8 endon("moveto_player");
  level.var_bffff68002b0acd8 endon("spotted");
  level.makarov endon("player_sees_me");
  function_4ae6e647f5c69ff8(points[0]);

  foreach(i, point in points) {
    if(isDefined(points[i + 1])) {
      function_4ae6e647f5c69ff8(points[i + 1]);
    }
  }

  level.var_bffff68002b0acd8 notify("reached_player");
}

function function_4ae6e647f5c69ff8(point) {
  color = (randomfloat(1), randomfloat(1), randomfloat(1));
  speed = 75;
  dist = distance(level.var_bffff68002b0acd8.origin, point);

  if(dist < 15) {
    return;
  }

  time = dist / speed;

  level.var_bffff68002b0acd8.angles = vectortoangles(point - level.var_bffff68002b0acd8.origin);
  level.var_bffff68002b0acd8 moveTo(point, time);
  wait time;
}

function function_7efd75f78b7db090() {
  while(true) {
    wait 0.35;
    distfromplayer = distancesquared(level.player.origin, level.var_bffff68002b0acd8.origin);

    if(function_184c3272f9addda4()) {
      if(isDefined(level.var_ac11a5241fa4dfda)) {
        line(level.var_bffff68002b0acd8.origin + (0, 0, 40), level.var_ac11a5241fa4dfda, (1, 0, 0), 1, 0, 15);
      }

      iprintln("<dev string:x13a>" + int(sqrt(distfromplayer)));
    }

    if(distfromplayer > 2025) {
      level.var_bffff68002b0acd8 playsurfacesound("step_default_npc_walk", "user_terrain_3");
    }
  }
}

function function_e472a220ac7d24c8() {
  if(flag("game_saving")) {
    if(function_184c3272f9addda4()) {
      iprintln("<dev string:x14b>");
    }

    return 0;
  }

  if(issaverecentlyloaded()) {
    if(function_184c3272f9addda4()) {
      iprintln("<dev string:x15b>");
    }

    return 0;
  }

  if(!ispointonnavmesh(level.player.origin)) {
    if(function_184c3272f9addda4()) {
      iprintln("<dev string:x180>");
    }

    return 0;
  }

  var_740a5f1d5375eba6 = 36;
  var_3fdcac526da3bf02 = (-19.5, -14, 37);
  var_c47e835a0c020b68 = level.player.origin + var_3fdcac526da3bf02;
  var_162bd509711885f9 = var_c47e835a0c020b68 + anglesToForward(level.player.angles) * -63;
  trace = trace::sphere_trace(var_c47e835a0c020b68, var_162bd509711885f9, var_740a5f1d5375eba6, [level.player, level.makarov, level.var_bffff68002b0acd8]);
  doanim = trace["fraction"] >= 0.95;

  if(!doanim && function_184c3272f9addda4()) {
    iprintln("<dev string:x19b>");
    thread trace::draw_trace(trace, (1, 0, 0), 1, 100);
  }

  return doanim;
}

function function_e8778d70dbcacc05(anime) {
  origin = (0, 0, 0);
  angles = (0, 0, 0);
  victimpos = getstartorigin(origin, angles, level.scr_anim["soap"][anime]);
  offset = rotatevectorinverted(origin - victimpos, angles);
  return offset;
}

function function_184c3272f9addda4() {
  return getdvarint(@ "hash_8cd2b2e75493773a");
}

function function_143069d13c9ea088(anime) {
  setdvarifuninitialized(@ "hash_671fd7b8ca674e9a", 1);
  level.player clearhudtutorialmessage(1);

  if(getdvarint(@ "hash_671fd7b8ca674e9a")) {
    function_dfb8f14d04481298();
    return;
  }

  var_a00fc997ca8ad1e7 = namespace_47819225b08b445d::function_320fe24554ccda96();
  var_a00fc997ca8ad1e7 hide();
  anim_first_frame([var_a00fc997ca8ad1e7, level.makarov], anime);
  level.player modifybasefov(65, 0.5);
  level.player lerpfovscalefactor(0, 0.5);
  scripts\anim\dialogue::function_54d3bd59bff7e908();
  scripts\sp\anim::igc_camera(1);
  var_a00fc997ca8ad1e7 show();
  thread anim_single([var_a00fc997ca8ad1e7, level.makarov], anime);
  level delaythread(0.95, &scripts\engine\utility::play_sound_in_space, "hero_meleeattack_soap_1", level.player.origin);
  level delaythread(1.9, &scripts\engine\utility::play_sound_in_space, "hero_explodeath_soap_1", level.player.origin);
  wait 2.9;
  level.player setOrigin(var_a00fc997ca8ad1e7 gettagorigin("tag_eye"));
  level.player setplayerangles(vectortoangles(var_a00fc997ca8ad1e7 gettagorigin("tag_eye") - level.makarov.origin));
  level.player disableinvulnerability();
  scripts\sp\player_death::set_custom_death_quote(509, 0);
  waitframe();
  level.player die();
  return 1;
}

function function_dfb8f14d04481298() {
  flag_set("mak_attack");
  level.player clearhudtutorialmessage(1);
  level.player enableinvulnerability();
  level.player modifybasefov(65, 0.5);
  level.player lerpfovscalefactor(0, 0.5);
  level.player enablequickweaponswitch(1);
  scripts\anim\dialogue::function_54d3bd59bff7e908();
  node = {
    #targetname: "first_person_mak_attack_anim_node", #angles: level.player.angles, #origin: level.player.origin
  };
  level.player_rig = spawn_anim_model("player_rig");
  level.player_rig hide();
  node anim_first_frame([level.player_rig, level.makarov], "first_person_mak_attack");

  if(level.player getstance() != "stand") {
    level.player setstance("stand", 1, 0, 0);
    waitframe();
  }

  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player delaycall(0.5, &lerpviewangleclamp, 0.5, 0.25, 0.25, 10, 10, 10, 10);
  level.player_rig delaycall(0.5, &show);
  level thread play_sound_in_space("hero_meleeattack_soap_1", level.player.origin);
  node thread anim_single([level.makarov, level.player_rig], "first_person_mak_attack");
  level.player disableweapons();
  level.player_rig waittillmatch("single anim", "hit_floor");
  earthquake_and_rumble(level.player.origin);
  level.player playsurfacesound("bodyfall_torso", "concrete_dry");
  level.player shellshock("default_nosound", 1);
  earthquake(0.7, 0.6, level.player.origin, 100);
  level.player_rig waittillmatch("single anim", "first_kick");
  level.player player::damagebloodoverlay(level.makarov.origin, 0.07, "MOD_RIFLE_BULLET");
  level.player playSound("hero_explodeath_soap_1");
  level.player playSound("melee_character_gun_fatal_layer_plr");
  level.player shellshock("default_nosound", 1);
  earthquake(0.7, 0.6, level.player.origin, 100);
  level.player_rig waittillmatch("single anim", "second_kick");
  level.player player::damagebloodoverlay(level.makarov.origin, 0.15, "MOD_RIFLE_BULLET");
  level.player playSound("gib_fullbody");
  level scripts\sp\hud_util::fade_out(0);
  scripts\sp\player_death::set_custom_death_quote(509, 0);
  waitframe();
  level.player disableinvulnerability();
  level.player die();
  return true;
}

function function_2d46c5431b1d52b9() {
  if(flag("pause_mak_attack")) {
    return false;
  }

  if(level.makarov isflashed()) {
    return false;
  }

  var_35af703ad9007a91 = distancesquared(level.makarov.origin, level.price.origin);

  if(var_35af703ad9007a91 < 22500) {
    return false;
  }

  if(function_cc76845a8b8abd2f()) {
    return true;
  }

  if(flag("tunnel_enemies_spawned") && !flag("mak_moving_to_car")) {
    return true;
  }

  guys = getaiarray("axis");
  var_cc415d003fe65e16 = level.makarov.team == "axis" ? 1 : 0;
  return guys.size > var_cc415d003fe65e16;
}

function function_cc76845a8b8abd2f() {
  var_e282648ab45a666f = int(distance2d(level.player.origin, level.makarov.origin));
  dist_normalized = math::normalize_value(30, 300, var_e282648ab45a666f);
  var_1a6206a0a430b4e = math::factor_value(0, -10, dist_normalized);
  var_1a6206a0a430b4e = round(var_1a6206a0a430b4e);
  var_6db7d3fcfba74403 = function_2f418ef8dd27221d(var_1a6206a0a430b4e);
  inplayerfov = within_fov(level.player.origin, level.player.angles, level.makarov.origin, cos(var_6db7d3fcfba74403));
  var_c42a4d5340ec3034 = undefined;

  if(inplayerfov) {
    var_c42a4d5340ec3034 = function_42a35aa092d8a05a();
  } else {
    var_c42a4d5340ec3034 = inplayerfov;
  }

  if(var_e282648ab45a666f > 700 && !var_c42a4d5340ec3034) {
    if(!isDefined(level.var_710d52bec8bc35ac)) {
      level.var_710d52bec8bc35ac = gettime();
    } else if(gettime() - level.var_710d52bec8bc35ac > 5000) {
      scripts\sp\player_death::set_custom_death_quote(525, 0);
      utility::missionfailedwrapper();
      level waittill("forever");
    }
  } else {
    level.var_710d52bec8bc35ac = undefined;
  }

  return !var_c42a4d5340ec3034;
}

function function_42a35aa092d8a05a() {
  contents = trace::create_ainosight_contents();
  contents += trace::create_item_contents();
  contents += trace::create_itemclip_contents();
  contents += trace::create_playerclip_contents();
  ignore = [level.player, level.makarov];

  if(trace::ray_trace_passed(level.player getEye(), level.makarov gettagorigin("j_helmet"), ignore, contents)) {
    if(function_184c3272f9addda4()) {
      line(level.player getEye(), level.makarov gettagorigin("<dev string:x1bd>"), (0, 1, 0), 1, 0, 10);
    }

    return true;
  } else {
    if(function_184c3272f9addda4()) {
      line(level.player getEye(), level.makarov gettagorigin("<dev string:x1bd>"), (1, 0, 0), 1, 0, 10);
    }
  }

  if(trace::ray_trace_passed(level.player getEye(), level.makarov gettagorigin("tag_eye"), ignore, contents)) {
    if(function_184c3272f9addda4()) {
      line(level.player getEye(), level.makarov gettagorigin("<dev string:x1c6>"), (0, 1, 0), 1, 0, 10);
    }

    return true;
  } else {
    if(function_184c3272f9addda4()) {
      line(level.player getEye(), level.makarov gettagorigin("<dev string:x1c6>"), (1, 0, 0), 1, 0, 10);
    }
  }

  var_8ef8e54c1c0ff4a9 = level.makarov gettagorigin("j_neck") + anglestoright(level.makarov.angles) * 14;

  if(trace::ray_trace_passed(level.player getEye(), var_8ef8e54c1c0ff4a9, ignore, contents)) {
    if(function_184c3272f9addda4()) {
      line(level.player getEye(), var_8ef8e54c1c0ff4a9, (0, 1, 0), 1, 0, 10);
    }
  } else {
    if(function_184c3272f9addda4()) {
      line(level.player getEye(), var_8ef8e54c1c0ff4a9, (1, 0, 0), 1, 0, 10);
    }
  }

  var_37793a7b39ebc6fc = level.makarov gettagorigin("j_neck") + anglestoleft(level.makarov.angles) * 14;

  if(trace::ray_trace_passed(level.player getEye(), var_37793a7b39ebc6fc, ignore, contents)) {
    if(function_184c3272f9addda4()) {
      line(level.player getEye(), var_37793a7b39ebc6fc, (0, 1, 0), 1, 0, 10);
    }

    return true;
  } else {
    if(function_184c3272f9addda4()) {
      line(level.player getEye(), var_37793a7b39ebc6fc, (1, 0, 0), 1, 0, 10);
    }
  }

  mid = level.makarov.origin + (0, 0, 30);
  var_bbf9a5560509e51a = mid + anglestoright(level.makarov.angles) * 14;

  if(trace::ray_trace_passed(level.player getEye(), var_bbf9a5560509e51a, ignore, contents)) {
    if(function_184c3272f9addda4()) {
      line(level.player getEye(), var_bbf9a5560509e51a, (0, 1, 0), 1, 0, 10);
    }

    return true;
  } else {
    if(function_184c3272f9addda4()) {
      line(level.player getEye(), var_bbf9a5560509e51a, (1, 0, 0), 1, 0, 10);
    }
  }

  var_8e56faf1f53a36cd = mid + anglestoleft(level.makarov.angles) * 14;

  if(trace::ray_trace_passed(level.player getEye(), var_8e56faf1f53a36cd, ignore, contents)) {
    if(function_184c3272f9addda4()) {
      line(level.player getEye(), var_8e56faf1f53a36cd, (0, 1, 0), 1, 0, 10);
    }

    return true;
  } else {
    if(function_184c3272f9addda4()) {
      line(level.player getEye(), var_8e56faf1f53a36cd, (1, 0, 0), 1, 0, 10);
    }
  }

  if(trace::ray_trace_passed(level.player getEye(), level.makarov.origin, ignore, contents)) {
    if(function_184c3272f9addda4()) {
      line(level.player getEye(), level.makarov.origin, (0, 1, 0), 1, 0, 10);
    }

    return true;
  } else {
    if(function_184c3272f9addda4()) {
      line(level.player getEye(), level.makarov.origin, (1, 0, 0), 1, 0, 10);
    }
  }

  return false;
}

function function_2f418ef8dd27221d(additional_degrees) {
  num = istrue(additional_degrees) == 1 ? additional_degrees : 0;
  return getdvarint(@ "cg_fov") + num;
}

function function_fcb4c5a996517164() {
  self.goalradius = 32;
  self setgoalpos(self.origin);
}

function function_f02c26effc2ccda6() {
  var_ee27402d1eee9e6b = spawn("script_origin", (0, 0, 0));
  var_ee27402d1eee9e6b.team = "allies";
  var_ee27402d1eee9e6b.name = "Pilot";
  return var_ee27402d1eee9e6b;
}

function scripted_out_of_bounds() {
  level endon("stop_scripted_out_of_bounds");
  utility::add_extra_autosave_check("scripted_oob", &function_1e66059f01f86438, "Player out of bounds");
  level.var_133dfbfb40161507 = [];
  flag_set("scripted_out_of_bounds_initialized");
  starttime = undefined;
  maxoutofboundstime = 7000;

  while(true) {
    outofbounds = 0;

    foreach(func in level.var_133dfbfb40161507) {
      result = [[func]]();

      if(istrue(result)) {
        outofbounds = 1;
        break;
      }
    }

    if(istrue(outofbounds)) {
      if(!flag("scripted_out_of_bounds")) {
        flag_set("scripted_out_of_bounds");
        setomnvar("ui_out_of_bounds_countdown", 1);
      }

      if(!isDefined(starttime)) {
        starttime = gettime();
      } else if(gettime() - starttime >= maxoutofboundstime) {
        setomnvar("ui_out_of_bounds_countdown", 0);
        scripts\sp\player_death::set_custom_death_quote(29);
        missionfailedwrapper();
        level waittill("forever");
      }
    } else if(flag("scripted_out_of_bounds")) {
      level.var_b21f85cbf98fd1e1 = gettime();
      flag_clear("scripted_out_of_bounds");
      setomnvar("ui_out_of_bounds_countdown", 0);
      starttime = undefined;
    }

    waitframe();
  }
}

function function_1e66059f01f86438() {
  if(flag("scripted_out_of_bounds")) {
    return false;
  } else if(isDefined(level.var_b21f85cbf98fd1e1) && gettime() - level.var_b21f85cbf98fd1e1 < 1500) {
    return false;
  }

  return true;
}

function function_f26a842bfe69ba4f(addfunc) {
  flag_wait("scripted_out_of_bounds_initialized");
  level.var_133dfbfb40161507[level.var_133dfbfb40161507.size] = addfunc;
}

function function_b901437dfc65cb84(removefunc) {
  flag_wait("scripted_out_of_bounds_initialized");
  temp = [];
  var_d80b969c88570fd1 = 0;

  foreach(func in level.var_133dfbfb40161507) {
    if(func != removefunc) {
      temp[temp.size] = func;
      continue;
    }

    var_d80b969c88570fd1 = 1;
  }

  if(istrue(var_d80b969c88570fd1)) {
    level.var_133dfbfb40161507 = temp;
  }
}

function function_54b30ac738a29c76() {
  flag_wait("scripted_out_of_bounds_initialized");
  level.var_133dfbfb40161507 = [];
}

function function_cf86f524a9bd6a64(struct) {
  spawner = utility::getvehiclespawner("blima_physics_spawner", "targetname");

  if(!isDefined(spawner)) {
    return undefined;
  }

  heli = spawn_vehicle_from_targetname("blima_physics_spawner");
  heli scripts\common\vehicle::godon();
  heli setvehiclelookattext("Raider 1-1", &"");
  heli vehicle_teleport(struct.origin, struct.angles);
  waitframe();
  level thread function_6cd6e856546de491();
  heli function_2648381f838e5aae();
  return heli;
}

function function_6cd6e856546de491() {
  setsaveddvar(@ "hash_71fe8b216d50a24c", 3);
  setsaveddvar(@ "hash_402173c7dbee15d9", 2);
  setsaveddvar(@ "hash_656131a98e0d2c9d", 50);
  setsaveddvar(@ "hash_6a4705943fd574b8", 1);
  setsaveddvar(@ "hash_d0658156fb7f2311", 2);
}

#using_animtree("player");

function function_62c968418d0134c4() {
  return [%fbk_0500_igc_capture_sh010_front_plr, %fbk_0500_igc_capture_sh010_left_plr, %fbk_0500_igc_capture_sh010_right_plr];
}

#using_animtree("vehicles");

function function_d02ec7ff94a3456f() {
  function_fa51684927851b1c();

  if(istrue(self.dooropen)) {
    return;
  }

  self.dooropen = 1;
  self setanim(%fbk_1000_igc_outro_open_heli, 1, 0.2, 1);
}

function function_ad369c049916a6b() {
  function_fa51684927851b1c();
  self.dooropen = 0;
  self setanimtime(%fbk_1000_igc_outro_open_heli, 0);
  self setanimrate(%fbk_1000_igc_outro_open_heli, 0);
  waitframe();
}

function function_fa51684927851b1c() {
  self useanimtree(#animtree);
}

function function_b68fadb268f988a6() {
  self clearanim(%root, 0.02);
}

function function_ab22bfb978385df4() {
  self endon("death");

  while(true) {
    self waittill("grenade_fire", grenade, weapon);
    var_6967c6636f26c4c = 0;
    myenemy = self.enemy;

    if(!isDefined(myenemy)) {
      var_6967c6636f26c4c = 1;
    } else if(!var_6967c6636f26c4c && is_equal(myenemy, level.player)) {
      if(function_57bf05496328ee1f()) {
        var_6967c6636f26c4c = 1;
      }
    } else if(!var_6967c6636f26c4c && myenemy == level.makarov || myenemy == level.price) {
      var_6967c6636f26c4c = 1;
    }

    if(var_6967c6636f26c4c) {
      grenade delete();
      continue;
    }

    level notify("molotv_out");
  }
}

function function_c33d2aabc6d080af() {
  hints = ["dx_sp_flas_mks1_pric_molotov", "dx_sp_flas_mks1_pric_theyreusingmolotovs", "dx_sp_flas_mks1_pric_molotovincoming"];

  foreach(hint in hints) {
    level waittill("molotv_out");
    level.price say_team(hint, 1, 0.5, 1, 0);
  }
}

function function_57bf05496328ee1f() {
  if(distancesquared(level.makarov.origin, level.player.origin) < 40000) {
    return true;
  }

  if(distancesquared(level.makarov.origin, level.player.origin) < 40000) {
    return true;
  }

  return false;
}

#using_animtree("scriptables");

function function_111b5b53f7e67091() {
  self setflaggedanimknoball("single anim", %fbk_0420_garage_crash_car01, %root, 1, 0);
  wait 4.75;
  flag_set("ambulance_impact");
  spot = self gettagorigin("tag_hood");
  self radiusdamage(spot, 70, 100, 90);
}

#using_animtree("player");

function function_891dd89c467830ed(var_85afd6338480ffac) {
  if(var_85afd6338480ffac == % fbk_0500_igc_capture_sh010_left_plr) {
    new_dir = "left";
  } else {
    new_dir = "right";
  }

  function_c55858f3e83e7c1(new_dir);
}

#using_animtree("generic_human");

function function_c55858f3e83e7c1(str_dir) {
  if(str_dir == "left") {
    xanim = % fbk_0500_igc_capture_sh010_left_soap;
  } else if(str_dir == "right") {
    xanim = % fbk_0500_igc_capture_sh010_right_soap;
  }

  level.scr_anim["soap"]["ambulance_10"] = xanim;
}

function function_e708dc41011ece0e() {
  level.var_98456c1c93b5dcc5 = spawn("script_origin", (28221, -2209, 27));
  level.var_98456c1c93b5dcc5 sound_fade_in("emt_outside_stadium_fire_lg_lp", 1, 15, 1);
  thread function_5292173c7662052d();
}

function function_5292173c7662052d() {
  pos1 = (28317.8, -2274.24, 179.58);
  pos2 = (29067.5, -2379.16, 135.54);
  pos3 = (27959.2, -1921.35, 12.4201);
  position = [pos1, pos2, pos3];
  sndalias = ["emt_metal_debris_medium", "emt_metal_debris_lg"];

  while(true) {
    play_sound_in_space(random(sndalias), random(position));
    wait randomfloatrange(3, 10);
  }
}