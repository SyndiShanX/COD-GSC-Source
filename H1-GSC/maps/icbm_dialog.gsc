/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\icbm_dialog.gsc
********************************/

dialog_intro() {
  common_scripts\utility::flag_wait("landed");
  wait 1;
  level.price maps\_anim::anim_single_queue(level.price, "regrouponme");
  wait 6;
  level.price maps\_anim::anim_single_queue(level.price, "wheresgriggs");
  wait 0.5;
  level.gaz maps\_anim::anim_single_queue(level.gaz, "noidea");
  wait 1;
  level.player playsound("icbm_hqr_gettingabortcodes");
  wait 6;
  level.price maps\_anim::anim_single_queue(level.price, "wereonourway");
  common_scripts\utility::flag_set("intro_dialog_done");
}

dialog_intro_h1() {
  var_0[0] = level.price;
  var_0[1] = level.gaz;

  if(isdefined(level.soldier))
    var_0[2] = level.soldier;

  foreach(var_2 in var_0) {
    if(isdefined(var_2))
      var_2.keepnodeduringscriptedanim = 1;
  }

  var_4 = spawn("script_origin", (9037.58, -21616.8, -683.706));
  var_4.angles = (0, -104.433, 0);
  common_scripts\utility::flag_wait("landed");
  var_4 thread maps\_anim::anim_first_frame(var_0, "intro_briefing");
  wait 1.9;
  var_4 thread maps\_anim::anim_single(var_0, "intro_briefing");
  level.price waittillmatch("single anim", "dialog");
  level.price waittillmatch("single anim", "dialog");
  level.gaz waittillmatch("single anim", "dialog");
  level.soldier waittillmatch("single anim", "radio_guy");
  level.player playsound("icbm_hqr_gettingabortcodes");
  level.price waittillmatch("single anim", "dialog");

  foreach(var_2 in var_0) {
    if(isdefined(var_2))
      var_2.keepnodeduringscriptedanim = 0;
  }

  common_scripts\utility::flag_set("intro_dialog_done");
}

dialog_price_finds_griggs() {
  level.griggs maps\_anim::anim_single_queue(level.griggs, "leavemebehind");
  wait 0.5;
  level.price maps\_anim::anim_single_queue(level.price, "firstthought");
}

dialog_griggs_is_good() {
  level.price maps\_anim::anim_single_queue(level.price, "youallright");
  level.griggs maps\_anim::anim_single_queue(level.griggs, "goodtogo");
  wait 1;
  level.price maps\_anim::anim_single_queue(level.price, "gotgriggs");
}

dialog_check_houses() {
  level.price maps\_anim::anim_single_queue(level.price, "griggsinhouses");
  wait 1;
  level.price maps\_anim::anim_single_queue(level.price, "keepitquiet");
  common_scripts\utility::flag_set("music_endon_start_rescue");
  thread maps\icbm_code::music_tension_loop("music_endon_tower_collapse", "icbm_launch_tension_music", 103);
  level.ambient_track["amb_day_intensity0"] = "ambient_icbm_ext0";
}

dialog_ambush_finished() {
  var_0 = maps\icbm_code::get_a_generic_friendly();
  var_0 maps\_anim::anim_single_queue(var_0, "tangodown");
  wait 1;
  level.price maps\_anim::anim_single_queue(level.price, "move");
}

dialog_post_knife_kill() {
  maps\_utility::trigger_wait("gaz_floor_clear", "targetname");

  if(!common_scripts\utility::flag("house1_cleared"))
    level.gaz maps\_anim::anim_single_queue(level.gaz, "roomclear");

  wait 2;

  if(!common_scripts\utility::flag("house1_cleared"))
    level.gaz maps\_anim::anim_single_queue(level.gaz, "floorsclear");
}

dialog_proceed_upstairs() {
  level.gaz maps\_anim::anim_single_queue(level.gaz, "proceedupstairs");
}

dialog_rescue_breach() {
  level.player playsound("icbm_pri_thisisplace");
  wait 3;
  level.player playsound("icbm_pri_readytobreach");
}

tower_nag() {
  level endon("tower_destroyed");

  if(common_scripts\utility::flag("tower_destroyed")) {
    return;
  }
  for (;;) {
    wait 30;
    level.price maps\_anim::anim_single_queue(level.price, "doit");
  }
}

fence1_nag() {
  level endon("cut_fence1");

  for (;;) {
    wait 50;
    level.price maps\_anim::anim_single_queue(level.price, "jacksonregroup");
  }
}

dialog_rescue() {
  wait 2;

  if(getdvarint("use_old_griggs_rescue") == 1) {
    level.gaz maps\_anim::anim_single_queue(level.gaz, "allclear");
    wait 1;
    level.price maps\_anim::anim_single_queue(level.price, "cutloose");
    wait 1;
    objective_string(2, & "ICBM_UNTIE_GRIGGS");
    wait 3;
    dialog_price_finds_griggs();
    wait 1;
    common_scripts\utility::flag_wait("griggs_loose");
    dialog_griggs_is_good();
  } else {
    maps\icbm_code::price_rescue_anims();
    wait 0.5;
    objective_string(2, & "ICBM_UNTIE_GRIGGS");
  }
}

griggs_say_leavemebehind(var_0) {
  level.griggs maps\_anim::anim_single_queue(level.griggs, "leavemebehind");
}

dialog_grigs_guys_jibjab() {
  level endon("breach_started");
  level endon("player_shooting_interogators");
  level.ru1 maps\_anim::anim_single_queue(level.ru1, "whereothers");
  wait 1;
  level.griggs maps\_anim::anim_single_queue(level.griggs, "grg_678452056");
  wait 1;
  level.ru1 maps\_anim::anim_single_queue(level.ru1, "tovarisch");
  wait 1;
  level.ru1 maps\_anim::anim_single_queue(level.ru1, "howmany");
  wait 1;
  level.griggs maps\_anim::anim_single_queue(level.griggs, "grg_678");
  level.ru1 maps\_anim::anim_single_queue(level.ru1, "whoisofficer");
  common_scripts\utility::flag_set("get_yer_ass");
  level.griggs maps\_anim::anim_single_queue(level.griggs, "blowme");
  wait 2;
  level.ru1 maps\_anim::anim_single_queue(level.ru1, "whereshacksaw");
  wait 1;
  level.ru1 maps\_anim::anim_single_queue(level.ru1, "youhadit");
  wait 0.5;
  level.ru1 maps\_anim::anim_single_queue(level.ru1, "ifihad");
}

dialog_enemy_vehicle() {
  self waittill("trigger");
  wait 3;
  common_scripts\utility::flag_wait("intro_dialog_done");

  if(!common_scripts\utility::flag("truckguys dead"))
    level.gaz maps\_anim::anim_single_queue(level.gaz, "enemyvehicle");

  common_scripts\utility::flag_set("truck_spotted");
}

dialog_blow_up_tower() {
  var_0 = getent("tower_dialog", "targetname");

  if(isdefined(var_0))
    var_0 waittill("trigger");

  wait 0.5;
  level.price maps\_anim::anim_single_queue(level.price, "blowuptower");
}

dialog_contacts_in_the_woods() {
  while (distance(level.player.origin, self.origin) > 2000) {
    wait 1;

    if(!isalive(self)) {
      break;
    }
  }

  if(common_scripts\utility::flag("contacts_in_the_woods")) {
    return;
  }
  common_scripts\utility::flag_set("contacts_in_the_woods");
  var_0 = maps\icbm_code::get_a_generic_friendly();

  if(isalive(var_0))
    var_0 maps\_anim::anim_single_queue(var_0, "insight");
}

dialog_jackson_do_it() {
  level endon("tower_destroyed");
  var_0 = getent("tower", "targetname");
  var_1 = getaiarray("allies");
  var_1[var_1.size] = level.player;

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isalive(var_1[var_2])) {
      continue;
    }
    while (distance(var_1[var_2].origin, var_0.origin) < 460)
      wait 0.5;
  }

  level.price maps\_anim::anim_single_queue(level.price, "doit");
  level thread tower_nag();
}

dialog_tango_down() {
  self waittill("death", var_0);

  if(!isdefined(var_0)) {
    return;
  }
  if(isplayer(var_0)) {
    return;
  }
  if(!isdefined(var_0.animname)) {
    return;
  }
  if(level.tango_down_dialog) {
    if(randomint(2) > 0)
      return;
  }

  dialog_enemy_kills(var_0);
  level.tango_down_dialog = 1;
}

dialog_enemy_kills(var_0) {
  var_1["price"] = "UK_pri_inform_killfirm_generic_s";
  var_1["generic"] = "UK_0_inform_killfirm_generic_s";
  var_1["gaz"] = "UK_2_inform_killfirm_generic_s";
  var_0 playsound(var_1[var_0.animname]);
}

dialog_get_fence_open() {
  level.price maps\_anim::anim_single_queue(level.price, "getfenceopen");
  musicstop(10);
}

dialog_enemy_helicopters() {
  var_0 = getent("move_to_oldbase01", "targetname");
  var_0 waittill("trigger");
  var_0 common_scripts\utility::trigger_off();
  level.gaz maps\_anim::anim_single_queue(level.gaz, "enemyhelicopters");
  wait 1;
  level.griggs maps\_anim::anim_single_queue(level.griggs, "getbusy2");
}

dialog_trucks_with_shooters() {
  var_0 = getent("move_to_oldbase02", "targetname");
  var_0 waittill("trigger");
  var_0 common_scripts\utility::trigger_off();
  level.price maps\_anim::anim_single_queue(level.price, "truckswithshooters");
  wait 0.5;
  level.price maps\_anim::anim_single_queue(level.price, "approachingbase");
}

dialog_rpgs_on_rooftops() {
  maps\_utility::trigger_wait("rpgs_on_roof_top", "targetname");
  wait 4;
  level.gaz maps\_anim::anim_single_queue(level.gaz, "rpgsonrooftop");
}

dialog_rpgs_on_rooftops2() {
  maps\_utility::trigger_wait("rpgs_on_roof_top2", "targetname");
  level.gaz maps\_anim::anim_single_queue(level.gaz, "rpgsonrooftop2");
}

dialog_choppers_dropping() {
  maps\_utility::trigger_wait("chopper_dialog1", "targetname");
  level.gaz maps\_anim::anim_single_queue(level.gaz, "choppersinbound");
  wait 6;
  level.price maps\_anim::anim_single_queue(level.price, "droppingin");
}

dialog_first_fight_clear_and_move() {
  level endon("second_fight_started");
  common_scripts\utility::flag_wait("first_fight_clear");
  wait 2;
  level.gaz maps\_anim::anim_single_queue(level.gaz, "allclear");
  wait 0.3;
  maps\_utility::activate_trigger_with_targetname("first_fight_clear_nodes");
  maps\_utility::autosave_by_name("all_clear");
}

dialog_second_fight_clear_and_move() {
  level endon("third_fight_started");
  common_scripts\utility::flag_wait("second_fight_cleared");
  wait 2;
  level.gaz maps\_anim::anim_single_queue(level.gaz, "allclear");
  wait 0.3;
  maps\_utility::activate_trigger_with_targetname("second_fight_friendly_nodes");
  maps\_utility::autosave_by_name("all_clear");
}