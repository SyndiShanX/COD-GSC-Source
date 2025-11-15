/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_mpq.gsc
*****************************************************/

mpq_init() {
  initmpqflags();
  thread initmpqsystems();
  mpqstepregistration();
  thread initmpqdebug();
  level.neilvotime = 0;
}

initmpqflags() {
  scripts\engine\utility::flag_init("neil_head_found");
  scripts\engine\utility::flag_init("neil_head_placed");
  scripts\engine\utility::flag_init("fuse_puzzle_completed");
  scripts\engine\utility::flag_init("toggle_puzzle_doors_opened");
  scripts\engine\utility::flag_init("toggle_puzzle_button_pressed");
  scripts\engine\utility::flag_init("security_doors_deactivated");
  scripts\engine\utility::flag_init("disable_evil_neil");
  scripts\engine\utility::flag_init("phantom_disk_drop");
  scripts\engine\utility::flag_init("button_entered_poster");
  scripts\engine\utility::flag_init("neils_head_placed_in_pap");
  scripts\engine\utility::flag_init("toggle_puzzle_completed_twice");
  scripts\engine\utility::flag_init("players_triggered_bossfight");
  scripts\engine\utility::flag_init("completed_toggle_puzzle_once");
}

initmpqsystems() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  level.neil_console = getent("neil_console", "targetname");
  level.neil_console.nextneilvotime = 0;
  spawnn31lhead();
  initpuzzlecombinations();
  spawnpuzzlepieces();
  initmedbaymonitors();
  initpuzzledoors();
  thread spawnenergydoor();
  thread startairventfx();
  thread initmedbaybutton();
  thread initneilconsolehead();
  deactivateinteractionsbynoteworthy("entangler_button");
  deactivateinteractionsbynoteworthy("entangler_spawner");
  deactivateinteractionsbynoteworthy("neil_head_final_pos");
  deactivateinteractionsbynoteworthy("portal_gun_button");
  var_00 = spawnStruct();
  var_00.origin = (5516, -5725.15, 140.268);
  var_00.angles = (0, 180, 0);
  level.struct_class_names["targetname"]["dlc4_poster"][level.struct_class_names["targetname"]["dlc4_poster"].size] = var_00;
}

initneilconsolehead() {
  var_00 = scripts\engine\utility::getstruct("console_neil_head", "targetname");
  var_00.entanglerangleupdate = ::updateneilheadangles;
  var_00.nextneilvotime = 0;
}

updateneilheadangles(param_00, param_01, param_02) {
  param_00 endon("disconnect");
  var_03 = gettime();
  if(var_03 >= param_01.nextneilvotime) {
    if(scripts\engine\utility::cointoss()) {
      if(playneilvofromconsoleorhead("final_n31l_evil_quest_pap")) {
        param_01.nextneilvotime = var_03 + -5536;
      }
    } else if(playneilvofromconsoleorhead("final_n31l_evil_quest_pap_b")) {
      param_01.nextneilvotime = var_03 + -5536;
    }
  }

  var_04 = scripts\engine\utility::getstruct("pap_portal", "script_noteworthy");
  if(isDefined(param_02.pathtogoal)) {
    if(scripts\engine\utility::istrue(param_00.isfasttravelling)) {
      param_02.fasttravelling = 1;
      var_05 = param_00.origin;
    } else {
      var_06 = var_05.origin;
      var_07 = undefined;
      var_08 = param_02.pathtogoal;
      if(var_08.size > 1) {
        var_06 = var_08[1];
        var_07 = 1;
      }

      var_09 = param_00 findpath(param_02.origin, var_06, 1, 1);
      if(var_09.size > 1) {
        var_05 = var_09[1];
      } else {
        var_05 = var_06;
      }

      if(param_02.pathtogoal.size >= 1) {
        if(isDefined(var_07) && distance2dsquared(var_06, param_02.origin) <= 9216) {
          param_02.pathtogoal = scripts\cp\utility::array_remove_index(param_02.pathtogoal, var_07, 0);
        }
      }

      var_0A = scripts\engine\utility::getclosest(param_02.origin, level.allslidingdoors, 96);
      if(isDefined(var_0A)) {
        if(scripts\engine\utility::istrue(var_0A.var_4284)) {
          var_0B = anglesToForward(param_00.angles);
          var_0C = 0;
          if(!var_0C && vectordot(vectornormalize(var_06 - param_00.origin), var_0B) > 0.75 && vectordot(vectornormalize(var_0A.origin - param_00.origin), var_0B) > 0.75) {
            if(distance(param_00.origin, var_06) > distance(param_00.origin, param_02.origin)) {
              if(scripts\engine\utility::istrue(var_0A.var_4284)) {
                var_0D = scripts\engine\utility::getstructarray(var_0A.script_noteworthy, "script_noteworthy");
                foreach(var_0F in var_0D) {
                  if(var_0F.target == var_0F.target) {
                    var_0F.nointeraction = undefined;
                  }
                }

                thread[[level.interactions[var_0A.script_noteworthy].activation_func]](var_0A, undefined);
              }
            }
          }
        }
      }
    }

    if(isDefined(var_05)) {
      return var_05;
    }

    return vectortoangles(param_00.origin - param_02.origin);
  }

  return vectortoangles(param_00.origin - param_02.origin);
}

initmedbaybutton() {
  var_00 = scripts\engine\utility::getstruct("button_entangle_target", "targetname");
  if(isDefined(var_00.model)) {
    var_00.model scripts\cp\cp_weapon::placeequipmentfailed("pillage", 1, var_00.model.origin);
    var_00.model delete();
  }

  var_01 = spawn("script_model", var_00.origin);
  var_01.angles = var_00.angles;
  var_01 setModel("electrical_airlock_cycle_button_dlc4");
  var_00.model = var_01;
  scripts\engine\utility::flag_wait("fuse_puzzle_completed");
  thread scripts\cp\crafted_entangler::outlineitemforplayers(var_00, var_01);
  thread scripts\cp\crafted_entangler::watchforentanglerdamage(var_00, var_01);
  var_01.collisionfunc = ::checkbuttoncollision;
}

checkbuttoncollision(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 waittill("collision");
  var_03 = param_00.origin;
  var_04 = scripts\engine\utility::getstructarray("dlc4_poster", "targetname");
  param_00 notify("end_entangler_funcs");
  var_05 = scripts\engine\utility::getclosest(var_03, var_04);
  if(distance(var_03, var_05.origin) <= 36) {
    if(isDefined(param_02)) {
      playFX(level._effect["energy_door_impact"], var_05.origin, vectortoangles(var_05.origin - param_02.origin) * 6, anglestoup(var_05.angles));
    } else {
      playFX(level._effect["energy_door_impact"], var_05.origin, anglesToForward(var_05.angles) * 6, anglestoup(var_05.angles));
    }

    scripts\engine\utility::flag_set("button_entered_poster");
    param_00 delete();
    return;
  }

  thread initmedbaybutton();
}

mpqstepregistration() {
  finalqueststepregistration("MPQ", undefined, ::blank, ::retrieveneilshead, ::completeretrieveneilshead, ::debugretrieveneilshead, 0, "Retrieve N31L\'s head");
  finalqueststepregistration("MPQ", undefined, ::blank, ::placeneilshead, ::completeplaceneilshead, ::debugplaceneilshead, 0, "Place Neil\'s Head");
  finalqueststepregistration("MPQ", undefined, ::blank, ::waitforsecuritydoorsdestroyed, ::securitydoorsdestroyed, ::debugsecuritydoorsdestroyed, 0, "Destroy Energy Doors");
  finalqueststepregistration("MPQ", undefined, ::blank, ::fusepuzzle, ::completefusepuzzle, ::debugfusepuzzle, 0, "Fuse Puzzle");
  finalqueststepregistration("MPQ", undefined, ::blank, ::entanglebutton, ::completeentanglebutton, ::debugcompleteentanglebutton, 0, "Entangle Button");
  finalqueststepregistration("MPQ", undefined, ::blank, ::pressbutton, ::completepressbutton, ::debugcompletepressbutton, 0, "Press Button");
  finalqueststepregistration("MPQ", undefined, ::blank, ::togglepuzzle, ::completetogglepuzzle, ::debugcompletetogglepuzzle, 0, "Complete Toggle Puzzle");
  finalqueststepregistration("MPQ", undefined, ::blank, ::enterbossfight, ::completeenterbossfight, ::debugcompleteenterbossfight, 0, "Enter Bossfight");
}

entanglebutton() {
  scripts\engine\utility::flag_wait("button_entered_poster");
}

completeentanglebutton() {
  activateinteractionsbynoteworthy("puzzle_door_button");
}

debugcompleteentanglebutton() {
  scripts\engine\utility::flag_set("button_entered_poster");
}

pressbutton() {
  scripts\engine\utility::flag_wait("toggle_puzzle_button_pressed");
}

completepressbutton() {
  openpuzzledoors();
}

debugcompletepressbutton() {
  scripts\engine\utility::flag_set("toggle_puzzle_button_pressed");
}

togglepuzzle() {
  scripts\engine\utility::flag_wait("neils_head_placed_in_pap");
}

completetogglepuzzle() {
  activateinteractionsbynoteworthy("neil_head_final_pos");
}

debugcompletetogglepuzzle() {
  scripts\engine\utility::flag_set("neils_head_placed_in_pap");
}

enterbossfight() {
  scripts\engine\utility::flag_wait("players_triggered_bossfight");
}

completeenterbossfight() {
  foreach(var_01 in level.players) {
    var_01 scripts\cp\utility::allow_player_interactions(1);
    var_01.kicked_out = undefined;
  }

  level notify("add_hidden_song_to_playlist");
  scripts\cp\maps\cp_final\cp_final::disablepas();
  scripts\cp\maps\cp_final\cp_final::enablepa("pa_facility_rhino_room");
  scripts\cp\maps\cp_final\cp_final_rhino_boss::start_rhino_fight();
}

debugcompleteenterbossfight() {
  scripts\engine\utility::flag_set("players_triggered_bossfight");
}

finalqueststepregistration(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(!isDefined(level.var_13F4D[param_00])) {
    level.var_13F4D[param_00] = [];
  }

  if(!isDefined(param_01)) {
    param_01 = level.var_13F4D[param_00].size;
  }

  if(!isDefined(level.var_13F4C[param_00])) {
    level.var_13F4C[param_00] = -1;
  }

  var_08 = spawnStruct();
  var_08.init_func = param_02;
  var_08.var_DB5D = param_03;
  var_08.var_446D = param_04;
  var_08.var_4EB1 = param_05;
  var_08.step_description = param_07;
  level.var_13F4D[param_00][param_01] = var_08;
}

registermpqinteractions() {
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "neil_head", undefined, undefined, ::headhintfunc, ::headusefunc, 0, 0, ::blank);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "neil_console", undefined, undefined, ::consolehintfunc, ::consoleusefunc, 0, 0, ::initneilconsole);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "fuse_puzzle", undefined, undefined, ::fusepuzzlehintfunc, ::fusepuzzleusefunc, 0, 0, ::initfusepuzzleinteraction);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "puzzle_pieces", undefined, undefined, ::puzzlepiecehintfunc, ::puzzlepieceusefunc, 0, 0, ::blank);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "entangler_button", undefined, undefined, ::entanglerbuttonhint, ::entanglerbuttonuse, 0, 0, ::initentanglerbutton);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "entangler_spawner", undefined, undefined, ::useentanglerweaponhint, ::useentanglerweapon, 0, 0, ::initentanglerspawner);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "puzzle_door_button", undefined, undefined, ::scripts\cp\maps\cp_final\cp_final_interactions::blankhintfunc, ::usepuzzlebutton, 0, 0, ::initpuzzlebutton);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "neil_head_final_pos", undefined, undefined, ::scripts\cp\maps\cp_final\cp_final_interactions::blankhintfunc, ::neilheadfinalusefunc, 0, 0, ::initneilfinalpos);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "neil_monitors", undefined, undefined, ::scripts\cp\maps\cp_final\cp_final_interactions::blankhintfunc, ::scripts\cp\maps\cp_final\cp_final_interactions::blankusefunc, 0, 0, ::initneilmonitors);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(0, "pap_bridge", undefined, undefined, ::scripts\cp\maps\cp_final\cp_final_interactions::blankhintfunc, ::pickupbridgepiece, 0, 0, ::initbridgepieces);
  spawnastronauts();
}

initneilfinalpos() {
  var_00 = scripts\engine\utility::getstructarray("neil_head_final_pos", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.custom_search_dist = 96;
  }
}

neilheadfinalusefunc(param_00, param_01) {
  if(!isDefined(param_00.var_127C9)) {
    param_00.var_127C9 = [];
  }

  scripts\cp\utility::playsoundatpos_safe(param_00.origin, "item_placed");
  param_01 thread playeractivatedbossfight(param_00, param_01);
}

playeractivatedbossfight(param_00, param_01) {
  level endon("game_ended");
  param_01 notify("playerActivatedBossFight");
  param_01 endon("playerActivatedBossFight");
  param_01 endon("disconnect");
  if(!scripts\engine\utility::array_contains(param_00.var_127C9, param_01)) {
    param_00.var_127C9 = scripts\engine\utility::array_add(param_00.var_127C9, param_01);
  }

  param_00.var_127C9 = scripts\engine\utility::array_remove_duplicates(param_00.var_127C9);
  if(param_00.var_127C9.size >= level.players.size) {
    deactivateinteractionsbynoteworthy(param_00.script_noteworthy);
    foreach(var_03 in level.players) {
      var_03 notify("left_hidden_room_early");
      var_03.kicked_out = 1;
      var_03 scripts\cp\utility::allow_player_interactions(0);
    }

    wait(2);
    completeneilfinalspot();
    return;
  }

  param_01 scripts\engine\utility::waittill_any_timeout_1(2, "left_hidden_room_early", "kicked_out", "last_stand");
  if(scripts\engine\utility::array_contains(param_00.var_127C9, param_01)) {
    param_00.var_127C9 = scripts\engine\utility::array_remove(param_00.var_127C9, param_01);
  }

  if(param_00.var_127C9.size <= 0) {
    param_00.var_127C9 = [];
  }
}

completeneilfinalspot() {
  scripts\engine\utility::flag_set("players_triggered_bossfight");
  deactivateinteractionsbynoteworthy("neil_head_final_pos");
}

usepuzzlebutton(param_00, param_01) {
  if(scripts\engine\utility::flag("fuse_puzzle_completed") && scripts\engine\utility::flag("button_entered_poster") && !param_01 isjumping() && param_01 getstance() != "stand") {
    scripts\cp\utility::playsoundatpos_safe(param_00.origin, "zmb_mpq_puzzle_turn");
    scripts\engine\utility::flag_set("toggle_puzzle_button_pressed");
    deactivateinteractionsbynoteworthy("puzzle_door_button");
    var_02 = scripts\engine\utility::getstruct("entangler_button", "script_noteworthy");
    scripts\cp\utility::playsoundatpos_safe(var_02.origin, "zmb_rhino_door_explo");
  }
}

startairventfx() {
  var_00 = scripts\engine\utility::getstructarray("air_suck_loc", "targetname");
  foreach(var_02 in var_00) {
    thread playventfx(var_02);
  }
}

playventfx(param_00) {
  level endon("end_vent_fx");
  level endon("game_ended");
  var_01 = level._effect["air_vent_in"];
  for(;;) {
    var_02 = 5;
    playFX(var_01, param_00.origin, anglesToForward(param_00.angles), anglestoup(param_00.angles));
    wait(0.5);
    thread checkfornearbydisk(param_00);
    level scripts\engine\utility::waittill_any_timeout_1(var_02 - 0.5, "vent_fx");
  }
}

checkfornearbydisk(param_00) {
  level endon("game_ended");
  level notify("checkForNearbyDisk");
  level endon("checkForNearbyDisk");
  level endon("end_vent_fx");
  for(;;) {
    if(isDefined(level.undergratepuzzlepiece)) {
      var_01 = distance(param_00.origin, level.undergratepuzzlepiece.origin);
      if(scripts\engine\utility::istrue(level.undergratepuzzlepiece.hasbeenthrown) && var_01 <= 96) {
        param_00 notify("stop_watching_for_entangler_damage");
        var_02 = 750;
        var_03 = var_01 / var_02;
        if(var_03 < 0.25) {
          var_03 = 0.25;
        }

        level.undergratepuzzlepiece moveto(param_00.origin, var_03, var_03 - 0.15, 0);
        wait(var_03);
        param_00 notify("vent_grabbed_puzzle_piece");
        level notify("vent_grabbed_puzzle_piece", level.undergratepuzzlepiece);
        break;
      }
    }

    wait(0.1);
  }
}

initneilmonitors() {
  level.currentneilstate = "neutral";
  var_00 = scripts\engine\utility::getstructarray("neil_monitors", "script_noteworthy");
  level.special_mode_activation_funcs["neil_monitors"] = ::setneilstatepent;
  level.normal_mode_activation_funcs["neil_monitors"] = ::setneilstatepent;
  foreach(var_02 in var_00) {
    scripts\cp\maps\cp_final\cp_final::addtopersonalinteractionlist(var_02);
  }
}

setneilstatepent(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  var_05 = getmodelfromstruct(param_01);
  switch (level.currentneilstate) {
    case "happy":
      param_00 setModel(var_05 + "_happy");
      break;

    case "straight":
      param_00 setModel(var_05 + "_o_face");
      param_00 playLoopSound("neil_alarm", 1);
      param_00.playingsound = "neil_alarm";
      param_00 thread cleanupsoundsonrelease(param_00, param_03);
      break;

    case "angry":
      param_00 setModel(var_05 + "_angry");
      break;

    case "large_happy":
      param_00 setModel(var_05 + "_happy");
      break;

    case "large_angry":
      param_00 setModel(var_05 + "_angry");
      break;

    case "large_blank":
      param_00 setModel("cp_final_monitor_large_screen");
      break;

    default:
      param_00 setModel("cp_final_monitor_small");
      break;
  }
}

getmodelfromstruct(param_00) {
  if(isDefined(param_00.script_label)) {
    return param_00.script_label;
  }

  return "cp_final_monitor_small";
}

cleanupsoundsonrelease(param_00, param_01) {
  param_00 notify("cleanUpSoundsOnRelease");
  param_00 endon("cleanUpSoundsOnRelease");
  var_02 = scripts\engine\utility::waittill_any_ents(param_01, "disconnect", param_00, "p_ent_reset", param_01, "zone_change", param_01, "rave_status_changed", param_01, "rave_interactions_updated", level, "game_ended");
  if(isDefined(param_00.playingsound)) {
    param_00 stoploopsound();
  }

  param_00.playingsound = undefined;
}

initpuzzlebutton() {
  thread initpuzzlebuttoninternal();
}

initpuzzlebuttoninternal() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("button_entered_poster");
  var_00 = scripts\engine\utility::getstructarray("puzzle_door_button", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.target)) {
      var_03 = scripts\engine\utility::getstructarray(var_02.target, "targetname")[0];
    } else {
      var_03 = var_02;
    }

    var_04 = spawn("script_model", var_03.origin);
    if(isDefined(var_03.angles)) {
      var_04.angles = var_03.angles;
    }

    var_04 setModel("electrical_airlock_cycle_button_dlc4");
  }
}

initentanglerspawner() {
  var_00 = scripts\engine\utility::getstruct("entangler_spawner", "script_noteworthy");
  var_00.groupname = "locOverride";
}

useentanglerweaponhint(param_00, param_01) {
  return "";
}

useentanglerweapon(param_00, param_01) {
  if(!scripts\engine\utility::istrue(param_01.hascollectedentangler)) {
    param_01 playlocalsound("zmb_item_pickup");
    scripts\cp\crafted_entangler::give_crafted_entangler(param_00, param_01);
  }
}

entanglerbuttonhint(param_00, param_01) {
  if(scripts\engine\utility::flag("toggle_puzzle_doors_opened")) {
    thread watchforplayerlookat(param_01);
    if(isDefined(param_01.current_button)) {
      return "";
    }

    return "";
  }

  return "";
}

entanglerbuttonuse(param_00, param_01) {
  if(scripts\engine\utility::flag("toggle_puzzle_doors_opened")) {
    if(isDefined(param_01.current_button)) {
      var_02 = gettime();
      if(var_02 >= param_00.nextneilvotime) {
        if(playneilvo("final_n31l_evil_hacked", param_01.vo_prefix)) {
          param_00.nextneilvotime = var_02 + 10000;
        }
      }

      param_01 notify("stop_interaction_logic");
      param_01.last_interaction_point = undefined;
      var_03 = param_01.current_button;
      param_01.current_button hudoutlinedisableforclient(param_01);
      scripts\cp\utility::playsoundatpos_safe(param_00.origin, "zmb_mpq_killswitch_placement");
      runbuttonrules(param_00, var_03);
      runtogglepuzzlevalidation(param_00, param_01);
      return;
    }

    param_01 scripts\cp\cp_interaction::refresh_interaction();
  }
}

setneilstate(param_00) {
  level.currentneilstate = param_00;
  foreach(var_02 in level.players) {
    var_02 thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(var_02);
  }

  switch (param_00) {
    case "happy":
      if(isDefined(level.var_BEC5)) {
        level.var_BEC5 setscriptablepartstate("happy", "show", 1);
      }

      setomnvar("zm_neil_state", 1);
      break;

    case "happy_line":
      if(isDefined(level.var_BEC5)) {
        level.var_BEC5 setscriptablepartstate("happy_line", "show", 1);
      }

      setomnvar("zm_neil_state", 1);
      break;

    case "straight":
      if(isDefined(level.var_BEC5)) {
        level.var_BEC5 setscriptablepartstate("oface", "show", 1);
      }

      setomnvar("zm_neil_state", 2);
      break;

    case "angry":
      if(isDefined(level.var_BEC5)) {
        level.var_BEC5 setscriptablepartstate("angry", "show", 1);
      }

      setomnvar("zm_neil_state", 3);
      break;

    case "angry_line":
      if(isDefined(level.var_BEC5)) {
        level.var_BEC5 setscriptablepartstate("angry_line", "show", 1);
      }

      setomnvar("zm_neil_state", 3);
      break;

    case "sad":
      if(isDefined(level.var_BEC5)) {
        level.var_BEC5 setscriptablepartstate("sad", "show", 1);
      }

      setomnvar("zm_neil_state", 3);
      break;

    default:
      if(isDefined(level.var_BEC5)) {
        if(scripts\engine\utility::cointoss()) {
          level.var_BEC5 setscriptablepartstate("happy", "show", 1);
        } else {
          level.var_BEC5 setscriptablepartstate("happy_line", "show", 1);
        }
      }

      setomnvar("zm_neil_state", 0);
      break;
  }
}

disabledoorswhenentangled(param_00, param_01) {
  level endon("game_ended");
  level endon("inFinalPosition");
  param_01 endon("end_entangler_funcs");
  param_01 notify("disableDoorsWhenEntangled");
  param_01 endon("disableDoorsWhenEntangled");
  param_00 endon("entangler_removed");
  param_00 endon("disconnect");
  param_01 endon("released");
  param_01 endon("launched");
  param_01 waittill("item_entangled");
  thread neilclosedoors();
  disableslidingdoorinteractions();
}

watchforitemdeleted(param_00, param_01) {
  param_01 endon("death");
  param_01 endon("reset");
  param_01 endon("inFinalPosition");
  level endon("inFinalPosition");
  param_01 waittill("cancel_entangler");
  thread resetneilhead(param_00, param_01);
}

resetneilhead(param_00, param_01) {
  param_01 notify("end_entangler_funcs");
  param_01 notify("reset");
  param_01 endon("inFinalPosition");
  level endon("inFinalPosition");
  param_01 notify("end_entangler_funcs");
  param_01.carriedby = undefined;
  param_01.entangled = undefined;
  param_01.entangled = undefined;
  param_01 setCanDamage(0);
  param_01.origin = param_01.ogorigin;
  param_01.angles = param_01.var_C3A0;
  param_01.launched = undefined;
  param_01.reachedfirstdoor = undefined;
  param_01.reachedseconddoor = undefined;
  level.var_BEC5 stopsounds();
  unsetwavenumoverride();
  unsetzombiemovespeed();
  unsetspawndelayoverride();
  restorewavespawningcounters();
  unpausenormalwavespawning();
  resetslidingdoorstonormalstate();
  resume_spawn_wave();
  getneilheadpath(param_00, param_01);
  thread reenableneilheadentangleitem(param_00, param_01);
}

disableslidingdoorinteractions(param_00) {
  foreach(var_02 in level.allslidingdoors) {
    if(scripts\engine\utility::istrue(param_00) && !scripts\engine\utility::istrue(var_02.player_opened)) {
      continue;
    }

    var_02.nointeraction = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_02);
  }
}

resetslidingdoorstonormalstate() {
  foreach(var_01 in level.allslidingdoors) {
    var_01.nointeraction = undefined;
    if(scripts\engine\utility::istrue(var_01.var_4284)) {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_01);
    }
  }
}

watchforitementangled(param_00, param_01) {
  level endon("game_ended");
  param_01 notify("watchForItemEntangled");
  param_01 endon("watchForItemEntangled");
  param_01 endon("reset");
  param_01 endon("inFinalPosition");
  level endon("inFinalPosition");
  scripts\engine\utility::flag_waitopen("disable_evil_neil");
  if(scripts\engine\utility::istrue(param_01.entangled)) {
    param_01 notify("end_entangle_move_to_logic");
    param_01 notify("released");
    param_01.sendbacktospawn = 1;
    thread resetneilhead(param_00, param_01);
  }
}

neilheadlaunchfunc(param_00, param_01, param_02) {
  param_01 notify("launched");
  param_01 endon("reset");
  param_01 endon("inFinalPosition");
  level endon("inFinalPosition");
  param_01 endon("released");
  if(scripts\engine\utility::istrue(param_01.sendbacktospawn)) {
    param_00.entangledmodel = undefined;
    thread resetneilhead(param_00, param_01);
    return;
  }

  scripts\cp\crafted_entangler::launchitem(param_00, param_01, param_02);
}

reenableneilheadentangleitem(param_00, param_01) {
  level endon("game_ended");
  param_01 notify("reenableNeilHeadEntangleItem");
  param_01 endon("reenableNeilHeadEntangleItem");
  param_01 endon("inFinalPosition");
  level endon("inFinalPosition");
  param_01 hide();
  level.var_BEC5 setscriptablepartstate("angry", "show", 1);
  param_01.sendbacktospawn = undefined;
  wait(0.1);
  param_01 show();
  level waittill("wave_starting");
  if(scripts\engine\utility::flag("disable_evil_neil") && level.currentneilstate != "straight") {
    level.var_BEC5 setscriptablepartstate("happy", "show", 1);
  } else {
    scripts\engine\utility::flag_wait("disable_evil_neil");
  }

  var_02 = scripts\engine\utility::getstruct("console_neil_head", "targetname");
  itemallowentangle(var_02, param_01);
  thread disabledoorswhenentangled(param_00, param_01);
  thread watchforitementangled(param_00, param_01);
  thread watchforitemdeleted(param_00, param_01);
}

itemallowentangle(param_00, param_01) {
  thread scripts\cp\crafted_entangler::outlineitemforplayers(param_00, param_01);
  thread scripts\cp\crafted_entangler::watchforentanglerdamage(param_00, param_01);
}

checkneilheadcollision(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 waittill("collision");
  var_03 = param_00.origin;
  var_04 = scripts\engine\utility::getstruct("neil_head_final_pos", "script_noteworthy");
  var_05 = scripts\engine\utility::getstruct(var_04.target, "targetname");
  param_00 notify("end_entangler_funcs");
  if(distance(var_03, var_05.origin) <= 48) {
    deactivateinteractionsbynoteworthy("entangler_button");
    playsoundatpos(var_03, "zmb_neil_head_placement_mpq");
    level notify("neil_doing_something_evil");
    level notify("inFinalPosition");
    param_00 notify("inFinalPosition");
    scripts\engine\utility::flag_set("disable_evil_neil");
    if(isDefined(param_02)) {
      playFX(level._effect["energy_door_impact"], var_05.origin, vectortoangles(var_05.origin - param_02.origin) * 8, anglestoup(var_05.angles));
    } else {
      playFX(level._effect["energy_door_impact"], var_05.origin, anglesToForward(var_05.angles) * 8, anglestoup(var_05.angles));
    }

    scripts\engine\utility::flag_set("neils_head_placed_in_pap");
    param_00 physicsstopserver();
    param_00.origin = var_05.origin;
    param_00.angles = var_05.angles;
    resetslidingdoorstonormalstate();
    unsetwavenumoverride();
    unsetzombiemovespeed();
    unsetspawndelayoverride();
    restorewavespawningcounters();
    unpausenormalwavespawning();
    resume_spawn_wave();
    return;
  }

  playneilvo("final_n31l_evil_activate_walls", param_02.vo_prefix);
  param_00 scripts\cp\cp_weapon::placeequipmentfailed("pillage", 1, param_00.origin);
  playsoundatpos(var_03, "zmb_neil_head_explode");
  param_00 physicsstopserver();
  thread resetplaceneilshead(param_00, param_01, param_02);
  setneilstate("angry");
  var_06 = spawn("script_model", level.players[0].origin);
  var_06 setModel("tag_origin");
  var_06.team = "allies";
  level.forced_nuke = 1;
  scripts\cp\loot::process_loot_content(level.players[0], "kill_50", var_06, 0);
}

resetplaceneilshead(param_00, param_01, param_02) {
  param_00 endon("reset");
  param_00 endon("inFinalPosition");
  level endon("inFinalPosition");
  thread resetneilhead(param_02, param_00);
}

deactivateneil() {
  level notify("deactivateNeil");
  level endon("deactivateNeil");
  level endon("game_ended");
  level endon("inFinalPosition");
  setneilstate("happy");
  resetslidingdoorstonormalstate();
  deactivateinteractionsbynoteworthy("entangler_button");
  scripts\engine\utility::flag_set("disable_evil_neil");
  foreach(var_01 in level.players) {
    var_01 scripts\cp\cp_merits::processmerit("mt_dlc4_hack_neil");
  }

  var_03 = scripts\engine\utility::ter_op(level.players[0] scripts\cp\utility::isplayingsolo() || level.only_one_player, int(240), int(180));
  var_04 = level scripts\engine\utility::waittill_any_timeout_1(var_03 - 5, "makeNeilEvil");
  setneilstate("straight");
  if(isDefined(var_04) && var_04 != "makeNeilEvil") {
    level scripts\engine\utility::waittill_any_timeout_1(5, "makeNeilEvil");
  }

  scripts\engine\utility::flag_clear("disable_evil_neil");
  if(isDefined(level.var_BEC5)) {
    level.var_BEC5 notify("end_entangler_funcs");
  }

  setneilstate("angry");
  activateinteractionsbynoteworthy("entangler_button");
  initentanglerbutton();
  thread neildoevilstuff();
}

runtogglepuzzlevalidation(param_00, param_01) {
  if(validatepuzzle(param_00)) {
    scripts\engine\utility::flag_set("completed_toggle_puzzle_once");
    thread deactivateneil();
    var_02 = scripts\engine\utility::getstruct("console_neil_head", "targetname");
    thread scripts\cp\crafted_entangler::outlineitemforplayers(var_02, var_02.headmodel);
    thread scripts\cp\crafted_entangler::watchforentanglerdamage(var_02, var_02.headmodel);
    getneilheadpath(param_01, var_02.headmodel);
    thread disabledoorswhenentangled(param_01, var_02.headmodel);
    thread watchforitementangled(param_01, var_02.headmodel);
    thread watchforitemdeleted(param_01, var_02.headmodel);
    scripts\cp\utility::playsoundatpos_safe(level.neil_console.origin, "zmb_mpq_puzzle_success");
  }
}

validatepuzzle(param_00) {
  var_01 = param_00.var_32F7[0].color;
  foreach(var_04, var_03 in param_00.var_32F7) {
    if(var_04 < 1) {
      continue;
    }

    if(var_03.color != var_01) {
      return 0;
    }
  }

  param_00.currentcolorstate = var_01;
  return 1;
}

togglebutton(param_00) {
  switch (param_00.color) {
    case "horizontal":
      param_00.color = "vertical";
      param_00 rotateto((0, 90, 90), 0.1);
      break;

    case "vertical":
      param_00.color = "horizontal";
      param_00 rotateto((0, 90, 0), 0.1);
      break;
  }
}

initentanglerbutton() {
  var_00 = scripts\engine\utility::getstruct("entangler_button", "script_noteworthy");
  var_00.nextneilvotime = 0;
  var_00.dontdelaytrigger = 1;
  var_01 = scripts\engine\utility::getstructarray(var_00.target, "targetname");
  assignbuttonindex(var_01, var_00);
  var_00.var_32F7 = [];
  var_01 = scripts\engine\utility::array_randomize_objects(var_01);
  var_00.currentcolorstate = undefined;
  foreach(var_06, var_03 in var_01) {
    var_04 = undefined;
    if(!isDefined(var_03.var_32D9)) {
      var_04 = spawn("script_model", var_03.origin);
      if(isDefined(var_03.angles)) {
        var_04.angles = var_03.angles;
      }
    } else {
      var_04 = var_03.var_32D9;
    }

    var_05 = "cp_final_pod_wall_handle";
    if(var_06 < 8) {
      var_04.color = "horizontal";
      var_04 rotateto((0, 90, 0), 0.1);
    } else {
      var_04.color = "vertical";
      var_04 rotateto((0, 90, 90), 0.1);
    }

    var_04 setModel(var_05);
    var_03.var_32D9 = var_04;
    var_00.var_32F7[var_00.var_32F7.size] = var_04;
    var_04.rulegroup = var_03.rulegroup;
    var_04.ruletouse = var_03.ruletouse;
  }
}

solvetogglepuzzle() {
  level endon("game_ended");
  var_00 = scripts\engine\utility::getstruct("entangler_button", "script_noteworthy");
  var_01 = scripts\engine\utility::getstructarray(var_00.target, "targetname");
  foreach(var_03 in var_01) {
    var_03.var_32D9.color = "horizontal";
    var_03.var_32D9 rotateto((0, 90, 0), 0.1);
  }

  wait(0.25);
  runtogglepuzzlevalidation(var_00, level.players[0]);
}

choosedoordecoys(param_00) {
  param_00.reachedfirstdoor = undefined;
  param_00.reachedseconddoor = undefined;
  var_01 = level.allslidingdoors;
  var_01 = scripts\engine\utility::get_array_of_closest(param_00.origin, var_01, undefined, undefined, undefined, 512);
  var_02 = scripts\engine\utility::random(var_01);
  var_01 = scripts\engine\utility::array_remove(var_01, var_02);
  var_03 = scripts\engine\utility::random(var_01);
  var_01 = scripts\engine\utility::array_remove(var_01, var_03);
  var_04 = scripts\engine\utility::random(var_01);
  var_05 = sortbydistance([var_02, var_03, var_04], param_00.origin);
  param_00.firstdoorpath = var_05[0];
  param_00.seconddoorpath = var_05[1];
  param_00.thirddoorpath = var_05[2];
}

getneilheadpath(param_00, param_01) {
  choosedoordecoys(param_01);
  var_02 = scripts\engine\utility::getstruct("pap_portal", "script_noteworthy");
  var_03 = scripts\engine\utility::getstruct("neil_head_final_pos", "script_noteworthy");
  var_04 = buildpath(level.players[0], param_01.origin, param_01.firstdoorpath.origin);
  var_05 = buildpath(level.players[0], var_04[var_04.size - 1], param_01.seconddoorpath.origin);
  var_06 = buildpath(level.players[0], var_05[var_05.size - 1], param_01.thirddoorpath.origin);
  var_07 = buildpath(level.players[0], var_06[var_06.size - 1], var_02.origin);
  var_08 = scripts\engine\utility::array_combine(var_04, var_05, var_06, var_07);
  var_08 = scripts\engine\utility::array_add(var_08, var_03.origin);
  param_01.pathtogoal = var_08;
}

buildpath(param_00, param_01, param_02) {
  var_03 = [];
  var_04 = level.allslidingdoors;
  var_05 = 0;
  var_06 = undefined;
  for(;;) {
    if(!isDefined(param_00)) {
      param_00 = level.players[0];
    }

    if(var_03.size == 0) {
      var_03 = param_00 findpath(param_01, param_02, 1, 1);
    } else {
      var_07 = param_00 findpath(var_03[var_03.size - 1], param_02, 1, 1);
      var_03 = scripts\engine\utility::array_combine(var_03, var_07);
    }

    if(distance2dsquared(param_02, var_03[var_03.size - 1]) <= 4096) {
      return var_03;
    }

    var_04 = sortbydistance(var_04, var_03[var_03.size - 1]);
    var_08 = [];
    var_09 = undefined;
    foreach(var_0B in var_04) {
      if(var_05 && var_0B == var_04[0] || var_0B == var_06) {
        continue;
      }

      var_08 = param_00 findpath(var_03[var_03.size - 1], var_0B.origin, 1, 1);
      if(distance2dsquared(var_0B.origin, var_08[var_08.size - 1]) <= 4096) {
        var_09 = var_0B;
        break;
      }
    }

    if(!var_05) {
      var_05 = 1;
    }

    if(!isDefined(var_09)) {
      return var_03;
    } else {
      var_06 = var_09;
    }

    if(isDefined(var_09.target)) {
      var_08 = [];
      var_08[var_08.size] = var_09.origin;
      var_0D = scripts\engine\utility::getstruct(var_09.target, "targetname");
      if(isstruct(var_0D)) {
        var_08[var_08.size] = var_0D.origin;
        var_03 = scripts\engine\utility::array_combine(var_03, var_08);
      } else {
        return var_03;
      }

      continue;
    }

    return var_03;
  }
}

assignbuttonindex(param_00, param_01) {
  var_02 = [-472.8, -486.8, -500.8, -514.8];
  var_03 = [128.8, 114.8, 100.8, 86.8];
  var_04 = [];
  var_05 = [];
  var_06 = [];
  var_07 = [];
  var_08 = [];
  var_09 = [];
  var_0A = [];
  var_0B = [];
  var_0C = [];
  var_0D = [];
  var_0E = [];
  var_0F = [];
  var_10 = [];
  var_11 = [];
  var_12 = [];
  var_13 = [];
  var_14 = [];
  var_15 = [];
  var_16 = [];
  var_17 = [];
  var_18 = [];
  var_19 = [];
  var_1A = [];
  var_1B = [];
  foreach(var_1D in param_00) {
    var_1E = var_1D.origin[0];
    var_1F = var_1D.origin[2];
    var_1D.id = 1;
    var_1D.rulegroup = [];
    if(isDefined(var_1D.script_noteworthy)) {
      var_1D.id = int(var_1D.script_noteworthy);
    }

    switch (var_1D.id) {
      case 1:
        var_05[var_05.size] = var_1D;
        var_06[var_06.size] = var_1D;
        var_08[var_08.size] = var_1D;
        var_0A[var_0A.size] = var_1D;
        var_0C[var_0C.size] = var_1D;
        var_0F[var_0F.size] = var_1D;
        var_11[var_11.size] = var_1D;
        var_12[var_12.size] = var_1D;
        var_16[var_16.size] = var_1D;
        var_17[var_17.size] = var_1D;
        var_18[var_18.size] = var_1D;
        var_19[var_19.size] = var_1D;
        break;

      case 2:
        var_04[var_04.size] = var_1D;
        var_07[var_07.size] = var_1D;
        var_09[var_09.size] = var_1D;
        var_0A[var_0A.size] = var_1D;
        var_0C[var_0C.size] = var_1D;
        var_0D[var_0D.size] = var_1D;
        var_10[var_10.size] = var_1D;
        var_12[var_12.size] = var_1D;
        var_14[var_14.size] = var_1D;
        var_15[var_15.size] = var_1D;
        var_18[var_18.size] = var_1D;
        var_1A[var_1A.size] = var_1D;
        break;

      case 3:
        var_06[var_06.size] = var_1D;
        var_07[var_07.size] = var_1D;
        var_08[var_08.size] = var_1D;
        var_0A[var_0A.size] = var_1D;
        var_0D[var_0D.size] = var_1D;
        var_0F[var_0F.size] = var_1D;
        var_11[var_11.size] = var_1D;
        var_12[var_12.size] = var_1D;
        var_14[var_14.size] = var_1D;
        var_15[var_15.size] = var_1D;
        var_19[var_19.size] = var_1D;
        var_1A[var_1A.size] = var_1D;
        break;

      case 4:
        var_04[var_04.size] = var_1D;
        var_05[var_05.size] = var_1D;
        var_09[var_09.size] = var_1D;
        var_0A[var_0A.size] = var_1D;
        var_0D[var_0D.size] = var_1D;
        var_0F[var_0F.size] = var_1D;
        var_10[var_10.size] = var_1D;
        var_12[var_12.size] = var_1D;
        var_16[var_16.size] = var_1D;
        var_17[var_17.size] = var_1D;
        var_18[var_18.size] = var_1D;
        var_19[var_19.size] = var_1D;
        break;

      case 5:
        var_06[var_06.size] = var_1D;
        var_07[var_07.size] = var_1D;
        var_09[var_09.size] = var_1D;
        var_0B[var_0B.size] = var_1D;
        var_0C[var_0C.size] = var_1D;
        var_0E[var_0E.size] = var_1D;
        var_10[var_10.size] = var_1D;
        var_13[var_13.size] = var_1D;
        var_14[var_14.size] = var_1D;
        var_15[var_15.size] = var_1D;
        var_1A[var_1A.size] = var_1D;
        var_1B[var_1B.size] = var_1D;
        break;

      case 6:
        var_04[var_04.size] = var_1D;
        var_05[var_05.size] = var_1D;
        var_08[var_08.size] = var_1D;
        var_0B[var_0B.size] = var_1D;
        var_0C[var_0C.size] = var_1D;
        var_0E[var_0E.size] = var_1D;
        var_11[var_11.size] = var_1D;
        var_13[var_13.size] = var_1D;
        var_16[var_16.size] = var_1D;
        var_17[var_17.size] = var_1D;
        var_18[var_18.size] = var_1D;
        var_1A[var_1A.size] = var_1D;
        break;

      case 7:
        var_05[var_05.size] = var_1D;
        var_06[var_06.size] = var_1D;
        var_09[var_09.size] = var_1D;
        var_0B[var_0B.size] = var_1D;
        var_0C[var_0C.size] = var_1D;
        var_0E[var_0E.size] = var_1D;
        var_10[var_10.size] = var_1D;
        var_13[var_13.size] = var_1D;
        var_16[var_16.size] = var_1D;
        var_17[var_17.size] = var_1D;
        var_18[var_18.size] = var_1D;
        var_1A[var_1A.size] = var_1D;
        break;

      case 8:
        var_04[var_04.size] = var_1D;
        var_07[var_07.size] = var_1D;
        var_08[var_08.size] = var_1D;
        var_0B[var_0B.size] = var_1D;
        var_0E[var_0E.size] = var_1D;
        var_0F[var_0F.size] = var_1D;
        var_11[var_11.size] = var_1D;
        var_13[var_13.size] = var_1D;
        var_14[var_14.size] = var_1D;
        var_15[var_15.size] = var_1D;
        var_1A[var_1A.size] = var_1D;
        var_1B[var_1B.size] = var_1D;
        break;

      case 9:
        var_06[var_06.size] = var_1D;
        var_07[var_07.size] = var_1D;
        var_08[var_08.size] = var_1D;
        var_0A[var_0A.size] = var_1D;
        var_0D[var_0D.size] = var_1D;
        var_0F[var_0F.size] = var_1D;
        var_11[var_11.size] = var_1D;
        var_13[var_13.size] = var_1D;
        var_14[var_14.size] = var_1D;
        var_15[var_15.size] = var_1D;
        var_1A[var_1A.size] = var_1D;
        var_1B[var_1B.size] = var_1D;
        break;

      case 10:
        var_04[var_04.size] = var_1D;
        var_05[var_05.size] = var_1D;
        var_09[var_09.size] = var_1D;
        var_0A[var_0A.size] = var_1D;
        var_0D[var_0D.size] = var_1D;
        var_0F[var_0F.size] = var_1D;
        var_10[var_10.size] = var_1D;
        var_13[var_13.size] = var_1D;
        var_16[var_16.size] = var_1D;
        var_17[var_17.size] = var_1D;
        var_19[var_19.size] = var_1D;
        var_1B[var_1B.size] = var_1D;
        break;

      case 11:
        var_05[var_05.size] = var_1D;
        var_06[var_06.size] = var_1D;
        var_08[var_08.size] = var_1D;
        var_0A[var_0A.size] = var_1D;
        var_0D[var_0D.size] = var_1D;
        var_0F[var_0F.size] = var_1D;
        var_11[var_11.size] = var_1D;
        var_13[var_13.size] = var_1D;
        var_16[var_16.size] = var_1D;
        var_17[var_17.size] = var_1D;
        var_19[var_19.size] = var_1D;
        var_1B[var_1B.size] = var_1D;
        break;

      case 12:
        var_04[var_04.size] = var_1D;
        var_07[var_07.size] = var_1D;
        var_09[var_09.size] = var_1D;
        var_0A[var_0A.size] = var_1D;
        var_0E[var_0E.size] = var_1D;
        var_0F[var_0F.size] = var_1D;
        var_10[var_10.size] = var_1D;
        var_13[var_13.size] = var_1D;
        var_14[var_14.size] = var_1D;
        var_15[var_15.size] = var_1D;
        var_1A[var_1A.size] = var_1D;
        var_1B[var_1B.size] = var_1D;
        break;

      case 13:
        var_05[var_05.size] = var_1D;
        var_06[var_06.size] = var_1D;
        var_09[var_09.size] = var_1D;
        var_0B[var_0B.size] = var_1D;
        var_0D[var_0D.size] = var_1D;
        var_0E[var_0E.size] = var_1D;
        var_10[var_10.size] = var_1D;
        var_12[var_12.size] = var_1D;
        var_16[var_16.size] = var_1D;
        var_17[var_17.size] = var_1D;
        var_18[var_18.size] = var_1D;
        var_19[var_19.size] = var_1D;
        break;

      case 14:
        var_04[var_04.size] = var_1D;
        var_07[var_07.size] = var_1D;
        var_08[var_08.size] = var_1D;
        var_0B[var_0B.size] = var_1D;
        var_0C[var_0C.size] = var_1D;
        var_0D[var_0D.size] = var_1D;
        var_11[var_11.size] = var_1D;
        var_12[var_12.size] = var_1D;
        var_14[var_14.size] = var_1D;
        var_15[var_15.size] = var_1D;
        var_19[var_19.size] = var_1D;
        var_1B[var_1B.size] = var_1D;
        break;

      case 15:
        var_06[var_06.size] = var_1D;
        var_07[var_07.size] = var_1D;
        var_09[var_09.size] = var_1D;
        var_0B[var_0B.size] = var_1D;
        var_0C[var_0C.size] = var_1D;
        var_0E[var_0E.size] = var_1D;
        var_10[var_10.size] = var_1D;
        var_12[var_12.size] = var_1D;
        var_14[var_14.size] = var_1D;
        var_15[var_15.size] = var_1D;
        var_18[var_18.size] = var_1D;
        var_1B[var_1B.size] = var_1D;
        break;

      case 16:
        var_04[var_04.size] = var_1D;
        var_05[var_05.size] = var_1D;
        var_08[var_08.size] = var_1D;
        var_0B[var_0B.size] = var_1D;
        var_0C[var_0C.size] = var_1D;
        var_0E[var_0E.size] = var_1D;
        var_11[var_11.size] = var_1D;
        var_12[var_12.size] = var_1D;
        var_16[var_16.size] = var_1D;
        var_17[var_17.size] = var_1D;
        var_18[var_18.size] = var_1D;
        var_19[var_19.size] = var_1D;
        break;
    }
  }

  param_01.group1 = var_04;
  param_01.group2 = var_05;
  param_01.group3 = var_06;
  param_01.group4 = var_07;
  param_01.group5 = var_08;
  param_01.group6 = var_09;
  param_01.group7 = var_0A;
  param_01.group8 = var_0B;
  param_01.group9 = var_0C;
  param_01.group10 = var_0D;
  param_01.group11 = var_0E;
  param_01.group12 = var_0F;
  param_01.group13 = var_10;
  param_01.group14 = var_11;
  param_01.group15 = var_12;
  param_01.group16 = var_13;
  param_01.group17 = var_14;
  param_01.group18 = var_15;
  param_01.group19 = var_16;
  param_01.group20 = var_17;
  param_01.group21 = var_18;
  param_01.group22 = var_19;
  param_01.group23 = var_1A;
  param_01.group24 = var_1B;
  thread assignbuttonrules(param_00, param_01);
}

assignbuttonrules(param_00, param_01) {
  var_02 = randomint(6);
  foreach(var_04 in param_00) {
    switch (var_04.id) {
      case 1:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group1;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group8;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group10;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group13;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group17;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group23;
        break;

      case 2:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group2;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group8;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group12;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group16;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group20;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group22;
        break;

      case 3:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group2;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group8;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group9;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group16;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group19;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group21;
        break;

      case 4:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group3;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group8;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group9;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group14;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group18;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group23;
        break;

      case 5:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group1;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group5;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group12;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group15;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group20;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group21;
        break;

      case 6:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group4;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group6;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group12;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group13;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group17;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group24;
        break;

      case 7:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group4;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group5;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group12;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group14;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group18;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group24;
        break;

      case 8:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group3;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group6;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group9;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group15;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group19;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group22;
        break;

      case 9:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group1;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group6;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group11;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group15;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group20;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group22;
        break;

      case 10:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group4;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group5;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group11;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group14;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group17;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group23;
        break;

      case 11:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group4;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group6;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group11;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group13;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group18;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group23;
        break;

      case 12:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group3;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group5;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group10;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group15;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group19;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group21;
        break;

      case 13:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group1;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group7;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group9;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group14;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group17;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group24;
        break;

      case 14:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group2;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group7;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group11;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group16;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group20;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group21;
        break;

      case 15:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group2;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group7;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group10;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group16;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group19;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group22;
        break;

      case 16:
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group3;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group7;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group10;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group13;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group18;
        var_04.rulegroup[var_04.rulegroup.size] = param_01.group24;
        break;
    }

    if(scripts\engine\utility::flag("completed_toggle_puzzle_once")) {
      var_04.ruletouse = var_04.rulegroup[var_02];
      continue;
    }

    var_04.ruletouse = var_04.rulegroup[0];
  }
}

runbuttonrules(param_00, param_01) {
  togglebutton(param_01);
  var_02 = param_01.ruletouse;
  foreach(var_04 in var_02) {
    var_05 = var_04.var_32D9;
    if(var_05 == param_01) {
      continue;
    }

    togglebutton(var_05);
  }
}

buttonrule2(param_00, param_01) {
  togglebutton(param_01);
  foreach(var_03 in param_00.group2) {
    var_04 = var_03.var_32D9;
    if(var_04 == param_01) {
      continue;
    }

    togglebutton(var_04);
  }
}

buttonrule3(param_00, param_01) {
  togglebutton(param_01);
  foreach(var_03 in param_00.group3) {
    var_04 = var_03.var_32D9;
    if(var_04 == param_01) {
      continue;
    }

    togglebutton(var_04);
  }
}

buttonrule4(param_00, param_01) {
  togglebutton(param_01);
  foreach(var_03 in param_00.group4) {
    var_04 = var_03.var_32D9;
    if(var_04 == param_01) {
      continue;
    }

    togglebutton(var_04);
  }
}

watchforplayerlookat(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("watchForPlayerLookat");
  param_00 endon("stop_interaction_logic");
  param_00 thread unsetplayerlookat(param_00);
  var_01 = scripts\engine\utility::getstruct("entangler_button", "script_noteworthy");
  var_02 = var_01.var_32F7;
  var_03 = undefined;
  var_04 = undefined;
  for(;;) {
    var_05 = 0;
    foreach(var_07 in var_02) {
      if(param_00 worldpointinreticle_circle(var_07.origin, 65, 20)) {
        var_05 = 1;
        param_00.current_button = var_07;
        var_04 = 2;
        if(isDefined(var_03)) {
          if(var_03 != var_07) {
            var_03 hudoutlinedisableforclient(param_00);
            var_07 hudoutlineenableforclient(param_00, var_04, 0, 0);
          }
        } else {
          var_07 hudoutlineenableforclient(param_00, var_04, 0, 0);
        }

        var_03 = var_07;
      }
    }

    if(!scripts\engine\utility::istrue(var_05)) {
      if(isDefined(var_03)) {
        var_03 hudoutlinedisableforclient(param_00);
      }

      param_00.current_button = undefined;
      var_03 = undefined;
    }

    wait(0.05);
  }
}

unsetplayerlookat(param_00) {
  param_00 endon("disconnect");
  param_00 endon("watchForPlayerLookat");
  param_00 waittill("stop_interaction_logic");
  if(isDefined(param_00.current_button)) {
    param_00.current_button hudoutlinedisableforclient(param_00);
    param_00.current_button = undefined;
  }
}

watchforentanglerdamage(param_00) {
  level endon("game_ended");
  level endon("endMonitorDamageLoop");
  scripts\engine\utility::flag_wait("restorepower_step1");
  for(;;) {
    level waittill("entangler_item_collision", var_01);
    if(distance(var_01, sortbydistance(param_00, var_01)[0].origin) <= 56) {
      foreach(var_03 in param_00) {
        var_03 setModel("cp_final_monitor_large_screen_cracked");
      }

      break;
    }
  }

  scripts\engine\utility::flag_set("security_doors_deactivated");
  level notify("endMonitorDamageLoop");
}

initneilconsole() {
  foreach(var_01 in scripts\engine\utility::getstructarray("neil_console", "script_noteworthy")) {
    var_01.nextneilvotime = 0;
  }

  deactivateinteractionsbynoteworthy("neil_console");
}

initfusepuzzleinteraction() {
  deactivateinteractionsbynoteworthy("fuse_puzzle");
  deactivateinteractionsbynoteworthy("puzzle_pieces");
}

deactivateinteractionsbynoteworthy(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00, "script_noteworthy");
  foreach(var_03 in var_01) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_03);
  }
}

deletemodelsbynoteworthy(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00, "script_noteworthy");
  foreach(var_03 in var_01) {
    if(isDefined(var_03.model)) {
      var_03.model delete();
    }
  }
}

activateinteractionsbynoteworthy(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00, "script_noteworthy");
  foreach(var_03 in var_01) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_03);
  }
}

initpuzzlecombinations() {
  var_00 = "cp\zombies\cp_final_puzzle_combos.csv";
  level.puzzle_combinations = [];
  level.insertedpieces = [];
  var_01 = 0;
  for(;;) {
    var_02 = tablelookupbyrow(var_00, var_01, 0);
    if(var_02 == "") {
      break;
    }

    level.puzzle_combinations[level.puzzle_combinations.size] = var_02;
    var_01++;
  }
}

spawnmodelatstruct(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = "tag_origin";
  }

  var_02 = spawn("script_model", param_00.origin);
  if(isDefined(param_00.angles)) {
    var_02.angles = param_00.angles;
  } else {
    var_02.angles = (0, 0, 0);
  }

  var_02 setModel(param_01);
  return var_02;
}

initmedbaymonitors() {
  var_00 = scripts\engine\utility::getstructarray("med_bay_monitors", "targetname");
  var_01 = [];
  foreach(var_03 in var_00) {
    var_04 = spawn("script_model", var_03.origin);
    if(isDefined(var_03.angles)) {
      var_04.angles = var_03.angles;
    }

    if(isDefined(var_03.script_modelname)) {
      var_04 setModel(var_03.script_modelname);
    }

    var_01[var_01.size] = var_04;
  }

  level thread watchforentanglerdamage(var_01);
}

spawnpuzzlepieces() {
  var_00 = scripts\engine\utility::getstructarray("puzzle_pieces", "script_noteworthy");
  level.puzzlestates = getvalidpuzzlestates();
  level.phantomdisk = level.puzzlestates[level.puzzlestates.size - 1];
  foreach(var_03, var_02 in var_00) {
    spawnpuzzlepiece(var_03, var_02);
  }
}

spawnpuzzlepiece(param_00, param_01) {
  if(isDefined(param_01.model)) {
    param_01.model delete();
  }

  if(isDefined(param_01.screenmodel)) {
    param_01.screenmodel delete();
  }

  if(isDefined(param_01.target)) {
    var_02 = scripts\engine\utility::getstruct(param_01.target, "targetname");
  } else {
    var_02 = var_02;
  }

  var_03 = spawn("script_model", var_02.origin);
  var_04 = level.puzzlestates[param_00];
  switch (int(var_04)) {
    case 1:
      var_03 setModel("cp_final_floppydisk_01");
      break;

    case 2:
      var_03 setModel("cp_final_floppydisk_02");
      break;

    case 3:
      var_03 setModel("cp_final_floppydisk_03");
      break;

    case 4:
      var_03 setModel("cp_final_floppydisk_04");
      break;

    case 5:
      var_03 setModel("cp_final_floppydisk_05");
      break;

    case 6:
      var_03 setModel("cp_final_floppydisk_06");
      break;

    case 7:
      var_03 setModel("cp_final_floppydisk_07");
      break;

    case 8:
      var_03 setModel("cp_final_floppydisk_08");
      break;

    case 9:
      var_03 setModel("cp_final_floppydisk_09");
      break;

    case 10:
      var_03 setModel("cp_final_floppydisk_10");
      break;

    case 11:
      var_03 setModel("cp_final_floppydisk_11");
      break;

    case 12:
      var_03 setModel("cp_final_floppydisk_12");
      break;
  }

  if(isDefined(var_02.angles)) {
    var_03.angles = var_02.angles;
  }

  param_01.id = param_00;
  param_01.model = var_03;
  param_01.state = level.puzzlestates[param_00];
  if(isDefined(param_01.groupname)) {
    var_03.hasbeenthrown = undefined;
    param_01 notify("new_model_created");
    param_01.entanglemodel = var_03;
    var_03.parent_struct = param_01;
    thread scripts\cp\crafted_entangler::outlineitemforplayers(param_01, param_01.model);
    thread scripts\cp\crafted_entangler::watchforentanglerdamage(param_01, param_01.model);
    param_01.var_1088C = ::spawnpuzzlepiece;
    param_01.entanglemovetofunc = ::entanglemovetocheckforcollision;
    var_03.collisionfunc = ::diskcustomcollisionfunc;
    param_01 thread disableaftermovethroughvent(param_01);
  }
}

disableaftermovethroughvent(param_00) {
  param_00 endon("new_model_created");
  level waittill("vent_grabbed_puzzle_piece", var_01);
  level.undergratepuzzlepiece = undefined;
  var_02 = level.struct_class_names["targetname"]["interaction"];
  var_03 = level.struct_class_names["script_noteworthy"]["puzzle_pieces"];
  var_02 = scripts\engine\utility::array_remove(var_02, param_00);
  var_03 = scripts\engine\utility::array_remove(var_03, param_00);
  level.struct_class_names["targetname"]["interaction"] = var_02;
  level.struct_class_names["script_noteworthy"]["puzzle_pieces"] = var_03;
  var_04 = level._effect["air_vent_out"];
  var_05 = scripts\engine\utility::getstructarray("puzzle_piece_landing", "targetname");
  var_06 = scripts\engine\utility::random(var_05);
  playFX(var_04, var_06.origin, anglesToForward(var_06.angles), anglestoup(var_06.angles));
  var_01 notify("end_entangler_funcs");
  var_01 setCanDamage(0);
  var_01 dontinterpolate();
  var_01.origin = var_06.origin;
  var_01.angles = var_06.angles;
  var_07 = scripts\engine\utility::getstruct(var_06.target, "targetname");
  var_01 moveto(var_07.origin, 0.5, 0.1, 0);
  var_01 rotateto(var_07.angles, 0.5);
  var_07.model = var_01;
  var_07.script_noteworthy = "puzzle_pieces";
  var_07.var_336 = "interaction";
  var_07.requires_power = 0;
  var_07.powered_on = 1;
  var_07.script_parameters = "default";
  var_07.state = param_00.state;
  level.struct_class_names["targetname"]["interaction"][level.struct_class_names["targetname"]["interaction"].size] = var_07;
  level.struct_class_names["script_noteworthy"]["puzzle_pieces"][level.struct_class_names["script_noteworthy"]["puzzle_pieces"].size] = var_07;
  if(scripts\engine\utility::flag("neil_head_placed")) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_07);
  }

  wait(0.5);
  level notify("end_vent_fx");
}

diskcustomcollisionfunc(param_00, param_01, param_02) {
  level endon("game_ended");
  var_03 = scripts\engine\utility::getstructarray("air_suck_loc", "targetname");
  for(var_04 = 0; var_04 <= 100; var_04++) {
    var_05 = param_00.origin;
    var_06 = param_00.angles;
    param_00 scripts\engine\utility::waittill_any_timeout_1(0.1, "collision");
    level notify("entangler_item_collision", param_00.origin);
    if(distance(var_05, param_00.origin) < 1 && var_06 == param_00.angles) {
      break;
    }
  }

  if(var_04 >= 100) {
    param_00.forcedrespawn = 1;
  }

  param_00.hasbeenthrown = 1;
  param_00.launched = undefined;
  foreach(var_08 in var_03) {
    if(distance(var_08.origin, param_00.origin) <= 96) {
      param_00 notify("released", undefined, 1, 36);
      return;
    }
  }

  param_00 notify("released", 1);
}

entanglemovetocheckforcollision(param_00, param_01, param_02, param_03) {
  var_04 = scripts\engine\utility::array_combine(level.players, [param_02]);
  var_05 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 0, 1);
  var_06 = scripts\common\trace::capsule_trace((param_00.origin[0], param_00.origin[1], param_03.origin[2]), param_03.origin, 16, 32, undefined, var_04, var_05, 24);
  var_07 = var_06["hittype"];
  if(isDefined(var_07) && var_07 != "hittype_none") {
    return 0;
  }

  return 1;
}

getvalidpuzzlestates() {
  var_00 = randomint(level.puzzle_combinations.size);
  var_01 = strtok(level.puzzle_combinations[var_00], ",");
  level.correctneilpuzzleanswer = var_01;
  return scripts\engine\utility::array_randomize_objects(var_01);
}

spawnn31lhead() {
  var_00 = scripts\engine\utility::getstructarray("neil_head", "script_noteworthy");
  var_00 = scripts\engine\utility::array_randomize_objects(var_00);
  var_01 = var_00[0];
  if(isDefined(var_01.target)) {
    var_02 = scripts\engine\utility::getstruct(var_01.target, "targetname");
  } else {
    var_02 = var_02;
  }

  var_03 = spawnmodelatstruct(var_02, "final_kevin_head_blank");
  var_01.headmodel = var_03;
  var_01.nextneilvotime = 0;
  level.var_BEC5 = var_03;
  foreach(var_05 in var_00) {
    if(var_05 == var_01) {
      continue;
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_05);
  }
}

consolehintfunc(param_00, param_01) {
  if(scripts\engine\utility::flag("neil_head_placed") && !scripts\engine\utility::flag("fuse_puzzle_completed")) {
    var_02 = gettime();
    if(var_02 >= param_00.nextneilvotime) {
      if(playneilvofromconsoleorhead("final_n31l_misc_reaction", 1)) {
        param_00.nextneilvotime = param_00.nextneilvotime + 10000;
      }
    }
  }

  return "";
}

headhintfunc(param_00, param_01) {
  var_02 = gettime();
  if(var_02 >= param_00.nextneilvotime) {
    if(playneilvofromconsoleorhead("final_n31l_found")) {
      param_00.nextneilvotime = var_02 + 10000;
    }
  }

  return & "CP_FINAL_PICKUP_ITEM";
}

puzzlepiecehintfunc(param_00, param_01) {
  if(!isDefined(param_01.haspuzzlepiece) || isDefined(param_01.haspuzzlepiece) && param_01.haspuzzlepiece != param_00.state) {
    if(isDefined(level.phantomdisk) && param_00.state == level.phantomdisk) {
      return & "CP_FINAL_PICKUP_ITEM";
    }

    return "";
  }

  return "";
}

puzzlepieceusefunc(param_00, param_01) {
  if(!isDefined(param_01.haspuzzlepiece) || isDefined(param_01.haspuzzlepiece) && param_01.haspuzzlepiece != param_00.state) {
    if(isDefined(param_00.target)) {
      var_02 = scripts\engine\utility::getstruct(param_00.target, "targetname");
    } else {
      var_02 = param_01;
    }

    param_01.haspuzzlepiece = param_00.state;
    param_01 playlocalsound("zmb_item_pickup");
    playFX(level._effect["generic_pickup"], var_02.origin);
    param_01 setclientomnvar("zm_hud_inventory_1", int(param_00.state));
  }
}

consoleusefunc(param_00, param_01) {
  if(!scripts\engine\utility::flag("neil_head_placed")) {
    scripts\engine\utility::flag_set("neil_head_placed");
    scripts\cp\utility::playsoundatpos_safe(param_00.origin, "zmb_neil_head_placement");
    if(level.players.size >= 4) {
      if(scripts\engine\utility::cointoss()) {
        level thread foundpowervo(param_01);
        return;
      }

      if(scripts\engine\utility::cointoss()) {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_head_place", "zmb_comment_vo");
        return;
      }

      playneilvofromconsoleorhead("final_n31l_back_to_console", 1);
      return;
    }

    if(scripts\engine\utility::cointoss()) {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_head_place", "zmb_comment_vo");
      return;
    }

    playneilvofromconsoleorhead("final_n31l_back_to_console", 1);
    return;
  }
}

foundpowervo(param_00) {
  if(isDefined(param_00.vo_prefix)) {
    switch (param_00.vo_prefix) {
      case "p1_":
        if(!isDefined(level.completed_dialogues["conv_poweron_sally_1_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_poweron_sally_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_poweron_sally_1_1"] = 1;
        }
        break;

      case "p2_":
        if(!isDefined(level.completed_dialogues["conv_poweron_pdex_1_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_poweron_pdex_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_poweron_pdex_1_1"] = 1;
        }
        break;

      case "p3_":
        if(!isDefined(level.completed_dialogues["conv_poweron_andre_1_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_poweron_andre_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_poweron_andre_1_1"] = 1;
        }
        break;

      case "p4_":
        if(!isDefined(level.completed_dialogues["conv_poweron_aj_1_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_poweron_aj_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_poweron_aj_1_1"] = 1;
        }
        break;
    }
  }
}

validatepuzzleslot(param_00, param_01) {
  for(var_02 = 0; var_02 < level.correctneilpuzzleanswer.size; var_02++) {
    if(level.correctneilpuzzleanswer[var_02] != level.insertedpieces[var_02]) {
      return 0;
    }
  }

  return 1;
}

headusefunc(param_00, param_01) {
  scripts\engine\utility::flag_set("neil_head_found");
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_head_find", "zmb_comment_vo");
  scripts\cp\maps\cp_final\cp_final_interactions::generic_pickup_gesture_and_fx(param_01, param_00.headmodel.origin);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
}

fusepuzzlehintfunc(param_00, param_01) {
  if(isDefined(param_01.haspuzzlepiece)) {
    param_01.interaction_trigger sethintstringparams(int(param_00.name));
    return & "CP_FINAL_INSERT_DISK";
  }

  param_01 thread scripts\cp\cp_vo::try_to_play_vo("missing_item_misc", "zmb_comment_vo");
  return "";
}

fusepuzzleusefunc(param_00, param_01) {
  if(isDefined(param_01.haspuzzlepiece)) {
    scripts\cp\utility::set_quest_icon(11);
    param_01 setclientomnvar("zm_hud_inventory_1", 0);
    var_02 = param_01.haspuzzlepiece;
    var_03 = "disk_slot_" + param_00.name;
    switch (int(var_02)) {
      case 1:
        level.neil_console setscriptablepartstate(var_03, "disk01");
        break;

      case 2:
        level.neil_console setscriptablepartstate(var_03, "disk02");
        break;

      case 3:
        level.neil_console setscriptablepartstate(var_03, "disk03");
        break;

      case 4:
        level.neil_console setscriptablepartstate(var_03, "disk04");
        break;

      case 5:
        level.neil_console setscriptablepartstate(var_03, "disk05");
        break;

      case 6:
        level.neil_console setscriptablepartstate(var_03, "disk06");
        break;

      case 7:
        level.neil_console setscriptablepartstate(var_03, "disk07");
        break;

      case 8:
        level.neil_console setscriptablepartstate(var_03, "disk08");
        break;

      case 9:
        level.neil_console setscriptablepartstate(var_03, "disk09");
        break;

      case 10:
        level.neil_console setscriptablepartstate(var_03, "disk10");
        break;

      case 11:
        level.neil_console setscriptablepartstate(var_03, "disk11");
        break;

      case 12:
        level.neil_console setscriptablepartstate(var_03, "disk12");
        break;
    }

    scripts\cp\utility::playsoundatpos_safe(param_00.origin, "zmb_floppy_disc_insert");
    var_04 = int(param_00.name) - 1;
    removeinvalidpuzzlepieces(var_02);
    param_01.haspuzzlepiece = undefined;
    level.insertedpieces[var_04] = var_02;
    param_01 setclientomnvar("zm_special_item", 0);
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    setomnvar("zm_floppy_count", level.insertedpieces.size);
    if(level.insertedpieces.size == 4) {
      if(!validatepuzzleslot(param_00, param_01)) {
        playsoundatpos(param_00.origin, "mpq_fail_buzzer");
        wait(1);
        setomnvar("zm_floppy_count", 0);
        scripts\cp\utility::unset_zm_quest_icon(11);
        level.insertedpieces = [];
        activateinteractionsbynoteworthy("fuse_puzzle");
        activateinteractionsbynoteworthy("puzzle_pieces");
        spawnpuzzlepieces();
        level.neil_console setscriptablepartstate("disk_slot_1", "neutral");
        level.neil_console setscriptablepartstate("disk_slot_2", "neutral");
        level.neil_console setscriptablepartstate("disk_slot_3", "neutral");
        level.neil_console setscriptablepartstate("disk_slot_4", "neutral");
        level thread trigger_goon_event_single(5);
        playneilvo("final_n31l_puzzle_fail");
        return;
      }

      wait(1);
      scripts\cp\utility::playsoundatpos_safe(param_00.origin, "zmb_floppy_quest_complete");
      deactivateinteractionsbynoteworthy("puzzle_pieces");
      scripts\engine\utility::flag_set("fuse_puzzle_completed");
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_part_" + level.insertedpieces.size, "zmb_comment_vo");
      playneilvofromconsoleorhead("final_n31l_return_part_4", 1);
      return;
    }

    param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_part_" + level.insertedpieces.size, "zmb_comment_vo");
    var_05 = gettime();
    if(var_05 >= level.neil_console.nextneilvotime) {
      if(playneilvofromconsoleorhead(scripts\engine\utility::random(["final_n31l_return_part_1", "final_n31l_return_part_2", "final_n31l_return_part_3"]), 1)) {
        level.neil_console.nextneilvotime = var_05 + 15000;
        return;
      }

      return;
    }
  }
}

removeinvalidpuzzlepieces(param_00) {
  var_01 = scripts\engine\utility::getstructarray("puzzle_pieces", "script_noteworthy");
  foreach(var_03 in var_01) {
    if(param_00 == var_03.state) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_03);
    }
  }

  foreach(var_06 in level.players) {
    if(isDefined(var_06.haspuzzlepiece) && var_06.haspuzzlepiece == param_00) {
      var_06 setclientomnvar("zm_hud_inventory_1", 0);
      var_06.haspuzzlepiece = undefined;
    }
  }
}

blank(param_00, param_01) {}

retrieveneilshead() {
  scripts\engine\utility::flag_wait("neil_head_found");
}

completeretrieveneilshead() {
  scripts\cp\utility::set_quest_icon(6);
  activateinteractionsbynoteworthy("neil_console");
  var_00 = scripts\engine\utility::getstructarray("neil_head", "script_noteworthy");
  deactivateinteractionsbynoteworthy("neil_head");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.headmodel)) {
      var_02.headmodel delete();
    }
  }
}

debugretrieveneilshead() {
  scripts\engine\utility::flag_set("neil_head_found");
}

placeneilshead() {
  scripts\engine\utility::flag_wait("neil_head_placed");
}

completeplaceneilshead() {
  turnonfacilitypower();
  scripts\engine\utility::flag_set("canFiresale");
  activateinteractionsbynoteworthy("fuse_puzzle");
  activateinteractionsbynoteworthy("puzzle_pieces");
  activateinteractionsbynoteworthy("portal_gun_button");
  var_00 = scripts\engine\utility::getstruct("console_neil_head", "targetname");
  var_01 = spawn("script_model", var_00.origin);
  var_01.angles = var_00.angles;
  var_01 setModel("final_kevin_head_dynamic");
  var_01.ogorigin = var_00.origin;
  var_01.var_C3A0 = var_00.angles;
  var_01.customlaunchfunc = ::neilheadlaunchfunc;
  var_01.collisionfunc = ::checkneilheadcollision;
  var_00.headmodel = var_01;
  var_01.parent_struct = var_00;
  level.var_BEC5 = var_01;
  scripts\cp\maps\cp_final\cp_final::enablepa("pa_facility");
  wait(0.5);
  setneilstate("happy");
  foreach(var_03 in level.players) {
    var_03 scripts\cp\cp_merits::processmerit("mt_dlc4_neil_upgrade");
  }

  thread playneilnag(["final_n31l_nag_missing_pieces", "final_n31l_request_pieces"], "fuse_puzzle_completed");
}

debugplaceneilshead() {
  scripts\engine\utility::flag_set("neil_head_placed");
}

playneilnag(param_00, param_01) {
  level endon("game_ended");
  level notify("playNeilNag");
  level endon("playNeilNag");
  while(isDefined(param_01) && !scripts\engine\utility::flag(param_01)) {
    wait(randomintrange(30, 60));
    var_02 = scripts\engine\utility::random(param_00);
    var_03 = gettime();
    if(var_03 >= level.neilvotime) {
      foreach(var_05 in level.players) {
        if(isDefined(var_05.currentlocation) && var_05.currentlocation == "facility") {
          var_05 scripts\cp\utility::playlocalsound_safe(var_02);
        }
      }

      var_07 = lookupsoundlength(var_02);
      setnextneilvotime(var_07);
    }
  }
}

playneilvo(param_00, param_01) {
  var_02 = gettime();
  if(var_02 >= level.neilvotime) {
    foreach(var_04 in level.players) {
      if(isDefined(var_04.currentlocation) && var_04.currentlocation == "facility") {
        var_04 scripts\cp\utility::playlocalsound_safe(param_00);
      }
    }

    var_06 = lookupsoundlength(param_00);
    if(isDefined(param_01)) {
      var_07 = getsoundaliasfromvoprefix(param_01, 1);
      thread playplayernameaftertime(var_06, var_07);
      var_06 = var_06 + lookupsoundlength(var_07);
    }

    setnextneilvotime(var_06);
    return 1;
  }

  return 0;
}

getsoundaliasfromvoprefix(param_00, param_01) {
  switch (param_00) {
    case "p1_":
      if(scripts\engine\utility::istrue(param_01)) {
        return "final_n31l_name_sally_pa";
      } else {
        return "final_n31l_name_sally";
      }

      break;

    case "p2_":
      if(scripts\engine\utility::istrue(param_01)) {
        return "final_n31l_name_poindexter_pa";
      } else {
        return "final_n31l_name_poindexter";
      }

      break;

    case "p3_":
      if(scripts\engine\utility::istrue(param_01)) {
        return "final_n31l_name_andre_pa";
      } else {
        return "final_n31l_name_andre";
      }

      break;

    case "p4_":
      if(scripts\engine\utility::istrue(param_01)) {
        return "final_n31l_name_aj_pa";
      }
      return "final_n31l_name_aj";
  }
}

playplayernameaftertime(param_00, param_01) {
  level endon("game_ended");
  wait(param_00 / 1000);
  foreach(var_03 in level.players) {
    if(isDefined(var_03.currentlocation) && var_03.currentlocation == "facility") {
      var_03 scripts\cp\utility::playlocalsound_safe(param_01);
    }
  }
}

playneilvofromconsoleorhead(param_00, param_01, param_02) {
  var_03 = gettime();
  if(var_03 >= level.neilvotime) {
    if(scripts\engine\utility::istrue(param_01)) {
      if(isDefined(level.neil_console)) {
        level.neil_console stopsounds();
        level.neil_console playSound(param_00);
        var_04 = lookupsoundlength(param_00);
        if(isDefined(param_02)) {
          var_05 = getsoundaliasfromvoprefix(param_02);
          thread playplayernameaftertime(var_04, var_05);
          var_04 = var_04 + lookupsoundlength(var_05);
        }

        setnextneilvotime(var_04);
        return 1;
      }

      return 0;
    }

    if(isDefined(level.var_BEC5)) {
      level.var_BEC5 stopsounds();
      level.var_BEC5 playSound(param_01);
      var_04 = lookupsoundlength(param_01);
      if(isDefined(param_02)) {
        var_05 = getsoundaliasfromvoprefix(param_02);
        thread playplayernameaftertime(var_04, var_05);
        var_04 = var_04 + lookupsoundlength(var_05);
      }

      setnextneilvotime(var_04);
      return 1;
    }

    return 0;
  }

  return 0;
}

setnextneilvotime(param_00) {
  level.neilvotime = gettime() + param_00;
}

turnonfacilitypower() {
  level notify("power_on");
  scripts\engine\utility::flag_set("restorepower_step1");
  scripts\engine\utility::flag_set("power_on");
  level.var_D746 = 1;
  var_00 = getEntArray("spawn_volume", "targetname");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.basename)) {
      var_03 = var_02.basename;
    } else {
      continue;
    }

    level notify(var_03 + " power_on");
    if(scripts\engine\utility::flag_exist(var_03 + " power_on")) {
      scripts\engine\utility::flag_set(var_03 + " power_on");
    }
  }
}

initpuzzledoors() {
  var_00 = scripts\engine\utility::getstructarray("toggle_puzzle_doors", "targetname");
  foreach(var_02 in var_00) {
    var_03 = spawn("script_model", var_02.origin);
    var_03.angles = var_02.angles;
    var_03 setModel("building_pod_wall_panel_01_thin");
    var_02.doormodel = var_03;
  }
}

waitforsecuritydoorsdestroyed() {
  scripts\engine\utility::flag_wait("security_doors_deactivated");
}

securitydoorsdestroyed() {
  level notify("kill_energy_doors");
  foreach(var_01 in level.all_quest_doors) {
    playsoundatpos(var_01.origin, "zmb_forcefield_destroyed");
    var_01 delete();
  }

  var_03 = getent("med_bay_door_clip", "targetname");
  var_03 notsolid();
  activateinteractionsbynoteworthy("entangler_button");
}

openpuzzledoors() {
  level endon("game_ended");
  var_00 = scripts\engine\utility::getstructarray("toggle_puzzle_doors", "targetname");
  foreach(var_02 in var_00) {
    var_02.doormodel delete();
  }

  scripts\engine\utility::flag_set("toggle_puzzle_doors_opened");
}

debugsecuritydoorsdestroyed() {
  scripts\engine\utility::flag_set("security_doors_deactivated");
}

fusepuzzle() {
  scripts\engine\utility::flag_wait("fuse_puzzle_completed");
}

completefusepuzzle() {
  foreach(var_01 in level.players) {
    var_01 scripts\cp\utility::stoplocalsound_safe("final_n31l_nag_missing_pieces");
  }

  scripts\engine\utility::flag_set("fuse_puzzle_completed");
  thread neildoevilstuff();
  scripts\cp\utility::set_quest_icon(10);
  setneilstate("straight");
  foreach(var_01 in level.players) {
    var_01 scripts\cp\zombies\achievement::update_achievement("FRIENDS_FOREVER", 1);
  }

  deactivateinteractionsbynoteworthy("fuse_puzzle");
  deactivateinteractionsbynoteworthy("puzzle_pieces");
  var_05 = scripts\engine\utility::getstructarray("puzzle_pieces", "script_noteworthy");
  foreach(var_07 in var_05) {
    if(isDefined(var_07.model)) {
      var_07.model delete();
    }
  }

  foreach(var_0C, var_0A in level.correctneilpuzzleanswer) {
    var_0B = "disk_slot_" + var_0C + 1;
    switch (int(var_0A)) {
      case 1:
        level.neil_console setscriptablepartstate(var_0B, "disk01");
        break;

      case 2:
        level.neil_console setscriptablepartstate(var_0B, "disk02");
        break;

      case 3:
        level.neil_console setscriptablepartstate(var_0B, "disk03");
        break;

      case 4:
        level.neil_console setscriptablepartstate(var_0B, "disk04");
        break;

      case 5:
        level.neil_console setscriptablepartstate(var_0B, "disk05");
        break;

      case 6:
        level.neil_console setscriptablepartstate(var_0B, "disk06");
        break;

      case 7:
        level.neil_console setscriptablepartstate(var_0B, "disk07");
        break;

      case 8:
        level.neil_console setscriptablepartstate(var_0B, "disk08");
        break;

      case 9:
        level.neil_console setscriptablepartstate(var_0B, "disk09");
        break;

      case 10:
        level.neil_console setscriptablepartstate(var_0B, "disk10");
        break;

      case 11:
        level.neil_console setscriptablepartstate(var_0B, "disk11");
        break;

      case 12:
        level.neil_console setscriptablepartstate(var_0B, "disk12");
        break;
    }

    level.insertedpieces[level.insertedpieces.size] = var_0A;
  }
}

debugfusepuzzle() {
  scripts\engine\utility::flag_set("fuse_puzzle_completed");
}

initbridgepieces() {
  var_00 = scripts\engine\utility::getstructarray("pap_bridge", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.name = "pap_quest";
    var_03 = spawn("script_model", var_02.origin);
    var_03 setModel("debris_exterior_damaged_metal_panels_08_scl50");
    var_03.angles = var_02.angles;
    var_03.var_336 = "pap_bridge_model";
  }

  scripts\engine\utility::flag_init("bridge_pieces_collected");
}

spawnastronauts() {
  level.astronautsshot = 0;
  var_00 = scripts\engine\utility::getstructarray("hidden_song_nick", "script_noteworthy");
  var_00 = sortbydistance(var_00, (5715, -4040, 131));
  level.astronaut_structs = [];
  foreach(var_04, var_02 in var_00) {
    if(var_04 == 0) {
      continue;
    }

    level.astronaut_structs[level.astronaut_structs.size] = var_02;
    var_03 = spawn("script_model", var_02.origin);
    var_03 setModel("zmb_arcade_toy_astronaut_white");
    var_03.angles = var_02.angles;
    var_03.script_noteworthy = "astronaut_model";
    if(isDefined(var_02.var_336)) {
      var_03.var_336 = var_02.var_336 + "_model";
    }

    var_03 thread astronautwatchfordamage();
  }

  var_05 = getent("astronaut_aide_trigger", "script_noteworthy");
  if(isDefined(var_05)) {
    var_05 thread astronautaidetriggerwatch(var_05);
  }
}

astronautwatchfordamage() {
  level endon("game_ended");
  self endon("released");
  self.health = 9999999;
  self.maxhealth = 9999999;
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_00, var_00, var_00, var_00, var_05);
    tryreleaseastronaut(var_01, var_05);
  }
}

astronautaidetriggerwatch(param_00) {
  param_00 = getent(self.target + "_model", "targetname");
  param_00 endon("released");
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_01, var_01, var_01, var_01, var_06);
    if(isDefined(param_00)) {
      thread scripts\cp\utility::debugprintline("release");
      param_00 tryreleaseastronaut(var_02, var_06);
    }
  }
}

tryreleaseastronaut(param_00, param_01) {
  if(isplayer(param_00)) {
    wait(0.2);
    level.astronautsshot++;
    if(isDefined(param_00)) {
      thread generic_interaction_no_gesture(param_00, self);
    }

    self.released = 1;
    self hide();
    if(level.astronautsshot >= level.astronaut_structs.size) {
      foreach(var_03 in level.players) {
        var_03 thread scripts\cp\cp_vo::try_to_play_vo("song_quest_success", "final_comment_vo");
        var_03 scripts\cp\zombies\achievement::update_achievement("BROKEN_RECORD", 1);
      }

      if(isDefined(param_00)) {
        built_bridge_feedback(param_00);
      }

      level notify("add_hidden_song_to_playlist");
      scripts\cp\maps\cp_final\cp_final::enablepas();
      level thread play_hidden_song((1785, -2077, 211), "mus_pa_final_hidden_track");
      level notify("song_ee_achievement_given");
    }

    self notify("released");
  }
}

play_hidden_song(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    level endon("game_ended");
  }

  if(param_01 == "mus_pa_final_hidden_track") {
    level endon("add_hidden_song_to_playlist");
  }

  if(soundexists(param_01)) {
    wait(2.5);
    if(param_01 == "mus_pa_final_hidden_track") {
      foreach(var_04 in level.players) {
        var_04 thread scripts\cp\cp_vo::try_to_play_vo("song_quest_start", "final_comment_vo");
        if(scripts\engine\utility::istrue(level.onlinegame)) {
          var_04 setplayerdata("cp", "hasSongsUnlocked", "any_song", 1);
          if(param_01 == "mus_pa_final_hidden_track") {
            var_04 setplayerdata("cp", "hasSongsUnlocked", "song_6", 1);
          }
        }
      }
    }

    var_06 = undefined;
    if(isDefined(var_06)) {
      level thread scripts\cp\cp_vo::try_to_play_vo(var_06, "zmb_dj_vo", "high", 60, 1, 0, 1);
      var_07 = lookupsoundlength(var_06) / 1000;
      wait(var_07);
    }

    scripts\engine\utility::play_sound_in_space("zmb_jukebox_on", param_00);
    var_08 = spawn("script_origin", param_00);
    var_09 = "ee";
    var_0A = 1;
    foreach(var_04 in level.players) {
      var_04 scripts\cp\cp_persistence::give_player_xp(2000, 1);
    }

    var_08 playLoopSound(param_01);
    var_08 thread scripts\cp\zombies\zombie_jukebox::earlyendon(var_08);
    var_0D = lookupsoundlength(param_01) / 1000;
    if(!isDefined(param_02)) {
      level scripts\engine\utility::waittill_any_timeout_1(var_0D, "skip_song");
    } else {
      level waittill("game_ended");
      var_08 stoploopsound();
      var_08 delete();
      return;
    }

    var_08 stoploopsound();
    var_08 delete();
  } else {
    wait(2);
  }

  scripts\cp\maps\cp_final\cp_final::disablepas();
  scripts\cp\maps\cp_final\cp_final::enablepa("pa_facility");
  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start(param_00, 1);
}

generic_interaction_no_gesture(param_00, param_01) {
  param_00 endon("disconnect");
  if(isent(param_01) || !isvector(param_01)) {
    param_01 = param_01.origin;
  }

  playFX(level._effect["generic_pickup"], param_01);
  param_00 playlocalsound("part_pickup");
}

trigger_goon_event(param_00) {
  foreach(var_02 in level.players) {
    if(distancesquared(var_02.origin, param_00) > 6000) {
      continue;
    }

    thread trigger_goon_event_single(param_00);
  }
}

trigger_goon_event_single(param_00, param_01) {
  level endon("game_ended");
  if(!isDefined(param_01)) {
    param_01 = 3;
  }

  var_02 = 0;
  while(var_02 < param_01) {
    var_03 = scripts\cp\zombies\cp_final_spawning::get_scored_goon_spawn_location();
    var_04 = var_03 scripts\cp\zombies\cp_final_spawning::spawn_brute_wave_enemy("alien_goon");
    if(isDefined(var_04)) {
      var_02++;
    }

    wait(0.3);
  }
}

pickupbridgepiece(param_00, param_01) {
  param_00 scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  var_02 = getEntArray("pap_bridge_model", "targetname");
  var_03 = scripts\engine\utility::get_array_of_closest(param_00.origin, var_02, undefined, 2);
  scripts\cp\maps\cp_final\cp_final_interactions::generic_pickup_gesture_and_fx(param_01, var_03[0].origin);
  incrementbridgequest(var_03, param_01);
  trigger_goon_event(param_00.origin);
}

incrementbridgequest(param_00, param_01) {
  if(!isDefined(level.bridgepiecesfound)) {
    level.bridgepiecesfound = [];
  }

  if(!isDefined(param_00)) {
    var_02 = "debugPiece";
  } else {
    var_02 = param_01[0].model;
    param_00[0] hide();
    param_00[0] hide();
    param_00[0] hide();
  }

  level.bridgepiecesfound = scripts\engine\utility::array_add_safe(level.bridgepiecesfound, var_02);
  var_03 = level.bridgepiecesfound.size;
  scripts\cp\utility::set_quest_icon(6 + var_03);
  setomnvar("zm_scrap_count", var_03);
  if(isDefined(param_01) && isplayer(param_01)) {
    switch (int(var_03)) {
      case 1:
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_bridge_piece_1", "zmb_comment_vo");
        break;

      case 2:
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_bridge_piece_2", "zmb_comment_vo");
        break;

      case 3:
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_bridge_piece_3", "zmb_comment_vo");
        break;
    }
  }

  if(var_03 >= 3) {
    scripts\engine\utility::flag_set("bridge_pieces_collected");
  }
}

showbridgepieces() {
  scripts\engine\utility::array_thread(scripts\engine\utility::getstructarray("pap_bridge", "script_noteworthy"), ::draw_debug_sphere);
}

draw_debug_sphere() {}

givehelmetdebug() {
  scripts\engine\utility::flag_set("has_film_reel");
  scripts\engine\utility::flag_set("set_movie_spaceland");
  scripts\engine\utility::flag_set("pulled_out_helmet");
  scripts\engine\utility::flag_set("obtained_brute_helmet");
  scripts\cp\utility::set_quest_icon(1);
  var_00 = spawn("script_model", (0, 0, 0));
  var_00 setModel("cp_final_brute_mascot_mask");
  var_00.script_parameters = "heavy_helmet";
  var_00 hide();
  level.helmet_on_brute = var_00;
}

movieswapdebug() {
  scripts\engine\utility::flag_set("has_film_reel");
  scripts\engine\utility::flag_set("set_movie_spaceland");
}

constructbridgeinit() {
  scripts\engine\utility::flag_init("bridge_constructed");
  level.bridgepiecesplaced = 0;
  scripts\engine\utility::getstruct("construct_bridge", "script_noteworthy").name = "construct_bridge";
}

constructbridgehint(param_00, param_01) {
  if(!isDefined(level.bridgepiecesfound)) {
    level.bridgepiecesfound = [];
  }

  if(level.bridgepiecesfound.size >= 3) {
    return & "CP_FINAL_INTERACTIONS_FINISH_BRIDGE";
  }

  if(level.bridgepiecesfound.size > level.bridgepiecesplaced) {
    return & "CP_FINAL_INTERACTIONS_ADD_BRIDGE_PIECE";
  }

  param_01 thread scripts\cp\cp_vo::try_to_play_vo("missing_item_misc", "zmb_comment_vo");
  return & "CP_FINAL_INTERACTIONS_NEED_PIECES";
}

bridgeconstructionfeedback(param_00, param_01) {
  var_02 = scripts\engine\utility::getstruct("construction_point_" + param_00, "targetname");
  playFX(level._effect["bridge_place"], var_02.origin, anglesToForward(var_02.angles));
  wait(1.2);
  var_03 = spawn("script_model", var_02.origin);
  var_03 setModel("debris_exterior_damaged_metal_panels_08_scl50");
  var_03.angles = var_02.angles;
  var_04 = (60, 60, 0);
  var_05 = getent("bridge_blocker", "targetname");
  var_05.origin = var_05.origin + var_04;
  param_01.origin = param_01.origin + var_04 + (8, 4, 0);
  playsoundatpos(param_01.origin, "zmb_bridge_build_01");
  var_05 connectpaths();
  level.bridgepiecesplaced++;
}

constructbridgeuse(param_00, param_01) {
  param_01 endon("disconnect");
  var_02 = level.bridgepiecesfound.size - level.bridgepiecesplaced;
  if(var_02 > 0) {
    scripts\cp\maps\cp_final\cp_final_interactions::generic_place_gesture_and_fx(param_01, param_00.origin + (30, 45, 0));
    for(var_03 = level.bridgepiecesplaced; var_03 < level.bridgepiecesplaced + var_02; var_03++) {
      thread bridgeconstructionfeedback(var_03 + 1, param_00);
    }

    wait(1.205);
    if(scripts\engine\utility::flag("bridge_pieces_collected")) {
      openbridge();
      built_bridge_feedback(param_01);
      scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_bridge_build", "zmb_comment_vo");
      wait(lookupsoundlength(param_01.vo_prefix + "quest_pap_bridge_build"));
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("pap_quest_success", "zmb_comment_vo");
    }
  }
}

openbridge() {
  var_00 = getent("bridge_blocker", "targetname");
  var_00 notsolid();
  var_00 connectpaths();
  scripts\engine\utility::flag_set("bridge_constructed");
  level thread bridgeconstructedvo();
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name("pap_island");
  scripts\cp\zombies\zombies_spawning::update_volume_adjacency_by_name("pap_island", "planet_outside");
  scripts\cp\zombies\zombies_spawning::update_volume_adjacency_by_name("planet_outside", "pap_island");
}

bridgeconstructedvo() {
  var_00 = scripts\engine\utility::random(level.players);
  if(isDefined(var_00.vo_prefix)) {
    switch (var_00.vo_prefix) {
      case "p1_":
        if(!isDefined(level.completed_dialogues["conv_pap_ee_sally_1_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_pap_ee_sally_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_pap_ee_sally_1_1"] = 1;
        }
        break;

      case "p2_":
        if(!isDefined(level.completed_dialogues["conv_pap_ee_pdex_1_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_pap_ee_pdex_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_pap_ee_pdex_1_1"] = 1;
        }
        break;

      case "p3_":
        if(!isDefined(level.completed_dialogues["conv_pap_ee_andre_1_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_pap_ee_andre_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_pap_ee_andre_1_1"] = 1;
        }
        break;

      case "p4_":
        if(!isDefined(level.completed_dialogues["conv_pap_ee_aj_1_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_pap_ee_aj_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_pap_ee_aj_1_1"] = 1;
        }
        break;
    }
  }
}

givefuses() {
  scripts\engine\utility::flag_set("picked_up_uncharged_fuses");
  foreach(var_01 in level.players) {
    var_01 setclientomnvar("zm_special_item", 5);
  }
}

built_bridge_feedback(param_00) {
  if(isDefined(param_00) && isplayer(param_00)) {
    var_01 = ["fistpump", "fingercrossed", "kissfist"];
    var_02 = scripts\engine\utility::random(var_01);
    var_03 = "iw7_" + var_02 + "_zm";
    param_00 thread scripts\cp\utility::usegrenadegesture(param_00, var_03);
  }
}

spawnenergydoor() {
  var_00 = [(16, 5583, 115), (144, 6168, 115)];
  var_01 = [(0, 0, 0), (0, 90, 0)];
  level.all_quest_doors = [];
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    var_03 = scripts\engine\utility::drop_to_ground(var_00[var_02], 12, -400);
    var_04 = spawn("script_model", var_03);
    var_04.angles = var_01[var_02];
    var_04 setModel("door_sized_collision");
    var_04 setscriptablepartstate("door_effect", "active");
    level.all_quest_doors[level.all_quest_doors.size] = var_04;
    thread watchfordamageondoor(var_04);
  }
}

watchfordamageondoor(param_00) {
  level endon("game_ended");
  level endon("kill_energy_doors");
  var_01 = getent("med_bay_door_clip", "targetname");
  var_01.health = 9999999;
  var_01.maxhealth = 9999999;
  var_01 setCanDamage(1);
  var_01.next_block_fx_time = 0;
  for(;;) {
    var_01 waittill("damage", var_02, var_03, var_04, var_05, var_02, var_02, var_02, var_02, var_02, var_06);
    var_07 = gettime();
    if(isDefined(var_01.next_block_fx_time) && isDefined(var_05) && isDefined(var_04) && var_07 >= var_01.next_block_fx_time) {
      var_01.next_block_fx_time = var_07 + 250;
      playFX(level._effect["energy_door_impact"], var_05 + var_04 * -5, var_04 * -150);
    }
  }
}

neilclosedoors() {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    thread setzombiemovespeed(["walk"]);
    setspawndelayoverride(0.5);
  } else {
    if(level.players.size >= 3) {
      thread setzombiemovespeed(["run", "sprint"]);
    } else {
      thread setzombiemovespeed(["walk", "run"]);
    }

    setspawndelayoverride(0.15);
  }

  setwavenumoverride(30);
  storewavespawningcounters();
  stop_spawn_wave();
  level.respawn_enemy_list = [];
  level.respawn_data = undefined;
  closealldoors(1);
  level.desired_enemy_deaths_this_wave = 500;
  level.max_static_spawned_enemies = 24;
  waitforvalidwavepause();
  pausenormalwavespawning(0);
}

watchfornearbyzombies(param_00) {
  param_00 notify("watchForNearbyZombies");
  param_00 endon("watchForNearbyZombies");
  level endon("game_ended");
  level endon("deactivateNeil");
  level endon("neilIsEvil");
  level endon("inFinalPosition");
  level endon("neil_doing_something_evil");
  for(;;) {
    var_01 = sortbydistance(scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"), param_00.origin);
    if(var_01.size > 0 && distance(var_01[0].origin, param_00.origin) <= 72) {
      if(scripts\engine\utility::istrue(param_00.var_4284)) {
        thread[[level.interactions[param_00.script_noteworthy].activation_func]](param_00, undefined);
        break;
      }
    }

    wait(0.25);
  }
}

pausenormalwavespawning(param_00) {
  scripts\engine\utility::flag_set("pause_wave_progression");
  if(scripts\engine\utility::istrue(param_00)) {
    level.zombies_paused = 1;
    return;
  }

  level.zombies_paused = 0;
}

resume_spawn_wave() {
  level.dont_resume_wave_after_solo_afterlife = undefined;
  level.zombies_paused = 0;
  scripts\engine\utility::flag_clear("pause_wave_progression");
}

storewavespawningcounters() {
  var_00 = spawnStruct();
  var_00.cop_spawn_percent = level.cop_spawn_percent;
  var_00.current_enemy_deaths = level.current_enemy_deaths;
  var_00.max_static_spawned_enemies = level.max_static_spawned_enemies;
  var_00.desired_enemy_deaths_this_wave = level.desired_enemy_deaths_this_wave;
  var_00.wave_num = level.wave_num;
  level.storedspawncounters = var_00;
}

restorewavespawningcounters() {
  if(isDefined(level.storedspawncounters)) {
    var_00 = level.storedspawncounters;
    if(level.wave_num == var_00.wave_num) {
      level.current_enemy_deaths = var_00.current_enemy_deaths;
      level.max_static_spawned_enemies = var_00.max_static_spawned_enemies;
      level.desired_enemy_deaths_this_wave = var_00.desired_enemy_deaths_this_wave;
    } else {
      level.current_enemy_deaths = 0;
      level.max_static_spawned_enemies = get_max_static_enemies(level.wave_num);
      level.desired_enemy_deaths_this_wave = get_total_spawned_enemies(level.wave_num);
    }

    level.storedspawncounters = undefined;
  }
}

stop_spawn_wave() {
  level.current_enemy_deaths = 0;
  scripts\engine\utility::flag_set("pause_wave_progression");
  level.zombies_paused = 1;
  level.dont_resume_wave_after_solo_afterlife = 1;
}

unpausenormalwavespawning() {
  scripts\engine\utility::flag_clear("pause_wave_progression");
  level.zombies_paused = 0;
}

waitforvalidwavepause() {
  while(level.current_enemy_deaths == level.desired_enemy_deaths_this_wave) {
    wait(0.05);
  }
}

clearexistingenemies() {
  var_00 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_02 in var_00) {
    var_02.died_poorly = 1;
    var_02.nocorpse = 1;
    var_02 suicide();
  }
}

get_max_static_enemies(param_00) {
  if(scripts\cp\utility::is_escape_gametype() && param_00 < 5) {
    var_01 = level.players.size * 6;
    var_02 = [0, 0.25, 0.3, 0.5, 0.7, 0.9];
    var_03 = 1;
    var_04 = 1;
    var_03 = var_02[param_00];
    var_05 = level.players.size - 1;
    if(var_05 < 1) {
      var_05 = 0.5;
    }

    var_06 = 24 + var_05 * 6 * var_04 * var_03;
    return int(min(var_01, var_06));
  }

  return 24;
}

get_total_spawned_enemies(param_00) {
  if(scripts\cp\utility::is_escape_gametype()) {
    return 9000;
  }

  var_01 = [0, 0.25, 0.3, 0.5, 0.7, 0.9];
  var_02 = 1;
  var_03 = 1;
  if(param_00 < 6) {
    var_02 = var_01[param_00];
  } else if(param_00 < 10) {
    var_03 = param_00 / 5;
  } else {
    var_03 = squared(param_00) * 0.03;
  }

  var_04 = level.players.size - 1;
  if(var_04 < 1) {
    var_04 = 0.5;
  }

  var_05 = 24 + var_04 * 6 * var_03 * var_02;
  return int(var_05);
}

setwavenumoverride(param_00) {
  level.wave_num_override = param_00;
}

unsetwavenumoverride(param_00) {
  level.wave_num_override = undefined;
}

setspawndelayoverride(param_00) {
  level.spawndelayoverride = param_00;
}

unsetspawndelayoverride(param_00) {
  level.spawndelayoverride = undefined;
}

unsetzombiemovespeed() {
  level notify("unsetZombieMoveSpeed");
}

setzombiemovespeed(param_00) {
  level endon("game_ended");
  level notify("unsetZombieMoveSpeed");
  level endon("unsetZombieMoveSpeed");
  foreach(var_02 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    if(isDefined(var_02.agent_type) && var_02.agent_type != "ratking") {
      var_03 = scripts\engine\utility::random(param_00);
      var_02 thread adjustmovespeed(var_02, 0, var_03);
    }
  }

  for(;;) {
    level waittill("agent_spawned", var_05);
    var_03 = scripts\engine\utility::random(param_00);
    var_05 thread adjustmovespeed(var_05, 1, var_03);
  }
}

adjustmovespeed(param_00, param_01, param_02) {
  param_00 endon("death");
  if(isDefined(param_00.agent_type) && param_00.agent_type == "ratking") {
    return;
  }

  if(scripts\engine\utility::istrue(param_00.is_suicide_bomber)) {
    return;
  }

  if(scripts\engine\utility::istrue(param_01)) {
    wait(0.5);
  }

  param_00 scripts\asm\asm_bb::bb_requestmovetype(param_02);
}

neiltriggertrap() {
  var_00 = scripts\engine\utility::getstructarray("laser_trap", "script_noteworthy");
  var_01 = scripts\engine\utility::getstructarray("electric_trap", "script_noteworthy");
  var_02 = scripts\engine\utility::getstructarray("acid_rain_trap", "script_noteworthy");
  level thread scripts\cp\maps\cp_final\cp_final_traps::use_lasers_trap(var_00[0], undefined);
  level thread scripts\cp\maps\cp_final\cp_final_traps::electric_trap_use(var_01[0], undefined);
  level thread scripts\cp\maps\cp_final\cp_final_traps::use_rain_trap(var_02[0], undefined);
}

neildoevilstuff() {
  level notify("neilIsEvil");
  level endon("neilIsEvil");
  level endon("game_ended");
  level endon("deactivateNeil");
  level endon("inFinalPosition");
  var_00 = ["laser_trap", "electric_trap", "acid_rain_trap"];
  var_01 = scripts\engine\utility::getstructarray("laser_trap", "script_noteworthy");
  var_02 = scripts\engine\utility::getstructarray("electric_trap", "script_noteworthy");
  var_03 = scripts\engine\utility::getstructarray("acid_rain_trap", "script_noteworthy");
  var_04 = scripts\engine\utility::array_combine(var_01, var_02, var_03);
  wait(5);
  for(;;) {
    level notify("neil_doing_something_evil");
    setneilstate("angry");
    if(scripts\engine\utility::cointoss()) {
      if(scripts\engine\utility::cointoss()) {
        thread activatedoorsastraps();
        level thread play_bad_neil_dialogues();
      } else {
        resetslidingdoorstonormalstate();
        playneilvo("final_n31l_evil_deactivate_machine");
        closealldoors(1);
        level thread play_bad_neil_dialogues();
      }
    } else {
      var_05 = 2000;
      var_06 = undefined;
      foreach(var_08 in level.players) {
        var_09 = scripts\engine\utility::getclosest(var_08.origin, var_04, 1000);
        if(isDefined(var_09) && distance(var_08.origin, var_09.origin) < var_05) {
          if(scripts\engine\utility::array_contains(level.current_interaction_structs, var_09)) {
            var_06 = var_09;
          }
        }
      }

      if(isDefined(var_06)) {
        resetslidingdoorstonormalstate();
        playneilvo("final_n31l_evil_manipulate_cost");
        switch (var_06.script_noteworthy) {
          case "laser_trap":
            level thread scripts\cp\maps\cp_final\cp_final_traps::use_lasers_trap(var_01[0], undefined);
            break;

          case "electric_trap":
            level thread scripts\cp\maps\cp_final\cp_final_traps::electric_trap_use(var_02[0], undefined);
            break;

          case "acid_rain_trap":
            level thread scripts\cp\maps\cp_final\cp_final_traps::use_rain_trap(var_03[0], undefined);
            break;
        }

        level thread play_bad_neil_dialogues();
      } else {
        if(scripts\engine\utility::cointoss()) {
          thread activatedoorsastraps();
        } else {
          playneilvo("final_n31l_evil_deactivate_machine");
          resetslidingdoorstonormalstate();
          closealldoors(1);
        }

        level thread play_bad_neil_dialogues();
      }
    }

    waittoreactivate();
  }
}

play_bad_neil_dialogues() {
  wait(7);
  if(!scripts\engine\utility::istrue(level.played_bad_neil_vo)) {
    level.played_bad_neil_vo = 1;
    var_00 = scripts\engine\utility::random(level.players);
    if(isDefined(var_00.vo_prefix)) {
      switch (var_00.vo_prefix) {
        case "p1_":
          if(!isDefined(level.completed_dialogues["conv_bad_n31l_sally_1_1"])) {
            level thread scripts\cp\cp_vo::try_to_play_vo("conv_bad_n31l_sally_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["conv_bad_n31l_sally_1_1"] = 1;
          }
          break;

        case "p2_":
          if(!isDefined(level.completed_dialogues["conv_bad_n31l_pdex_1_1"])) {
            level thread scripts\cp\cp_vo::try_to_play_vo("conv_bad_n31l_pdex_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["conv_bad_n31l_pdex_1_1"] = 1;
          }
          break;

        case "p3_":
          if(!isDefined(level.completed_dialogues["conv_bad_n31l_andre_1_1"])) {
            level thread scripts\cp\cp_vo::try_to_play_vo("conv_bad_n31l_andre_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["conv_bad_n31l_andre_1_1"] = 1;
          }
          break;

        case "p4_":
          if(!isDefined(level.completed_dialogues["conv_bad_n31l_aj_1_1"])) {
            level thread scripts\cp\cp_vo::try_to_play_vo("conv_bad_n31l_aj_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["conv_bad_n31l_aj_1_1"] = 1;
          }
          break;
      }
    }
  }
}

waittoreactivate() {
  level endon("game_ended");
  level endon("makeNeilEvil");
  level endon("deactivateNeil");
  var_00 = randomintrange(45, 60);
  level scripts\engine\utility::waittill_any_timeout_1(var_00 - 5, "makeNeilEvil");
  setneilstate("straight");
  level scripts\engine\utility::waittill_any_timeout_1(5, "makeNeilEvil");
}

activatedoorsastraps() {
  level notify("activateDoorsAsTraps");
  level endon("activateDoorsAsTraps");
  level endon("game_ended");
  playneilvo("final_n31l_evil_activate_trap");
  rundoorsastrapsloop();
  resetslidingdoorstonormalstate();
}

openalldoors() {
  foreach(var_01 in level.allslidingdoors) {
    if(scripts\engine\utility::istrue(var_01.player_opened) && scripts\engine\utility::istrue(var_01.var_4284)) {
      thread[[level.interactions[var_01.script_noteworthy].activation_func]](var_01, undefined);
    }
  }
}

closealldoors(param_00) {
  foreach(var_02 in level.allslidingdoors) {
    if(scripts\engine\utility::istrue(var_02.player_opened) && scripts\engine\utility::istrue(var_02.opened)) {
      if(scripts\engine\utility::istrue(param_00)) {
        thread watchfornearbyzombies(var_02);
      }

      thread scripts\cp\maps\cp_final\cp_final_interactions::closeslidingdoor(var_02, undefined);
    }
  }
}

rundoorsastrapsloop() {
  level endon("game_ended");
  level endon("neil_doing_something_evil");
  level endon("deactivateNeil");
  level endon("inFinalPosition");
  while(!scripts\engine\utility::flag("disable_evil_neil")) {
    disableslidingdoorinteractions(1);
    thread closealldoors();
    wait(1.5);
    disableslidingdoorinteractions(1);
    thread openalldoors();
    wait(randomfloatrange(1.75, 5));
  }
}

initmpqdebug() {
  scripts\engine\utility::flag_wait("interactions_initialized");
}

questdevguientries(param_00, param_01, param_02, param_03) {}