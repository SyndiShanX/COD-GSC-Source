/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
  var_0 = spawnStruct();
  var_0.origin = (5516, -5725.15, 140.268);
  var_0.angles = (0, 180, 0);
  level.struct_class_names["targetname"]["dlc4_poster"][level.struct_class_names["targetname"]["dlc4_poster"].size] = var_0;
}

initneilconsolehead() {
  var_0 = scripts\engine\utility::getstruct("console_neil_head", "targetname");
  var_0.entanglerangleupdate = ::updateneilheadangles;
  var_0.nextneilvotime = 0;
}

updateneilheadangles(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  var_3 = gettime();
  if(var_3 >= var_1.nextneilvotime) {
    if(scripts\engine\utility::cointoss()) {
      if(playneilvofromconsoleorhead("final_n31l_evil_quest_pap")) {
        var_1.nextneilvotime = var_3 + -5536;
      }
    } else if(playneilvofromconsoleorhead("final_n31l_evil_quest_pap_b")) {
      var_1.nextneilvotime = var_3 + -5536;
    }
  }

  var_4 = scripts\engine\utility::getstruct("pap_portal", "script_noteworthy");
  if(isDefined(var_2.pathtogoal)) {
    if(scripts\engine\utility::istrue(var_0.isfasttravelling)) {
      var_2.fasttravelling = 1;
      var_5 = var_0.origin;
    } else {
      var_6 = var_5.origin;
      var_7 = undefined;
      var_8 = var_2.pathtogoal;
      if(var_8.size > 1) {
        var_6 = var_8[1];
        var_7 = 1;
      }

      var_9 = var_0 findpath(var_2.origin, var_6, 1, 1);
      if(var_9.size > 1) {
        var_5 = var_9[1];
      } else {
        var_5 = var_6;
      }

      if(var_2.pathtogoal.size >= 1) {
        if(isDefined(var_7) && distance2dsquared(var_6, var_2.origin) <= 9216) {
          var_2.pathtogoal = scripts\cp\utility::array_remove_index(var_2.pathtogoal, var_7, 0);
        }
      }

      var_0A = scripts\engine\utility::getclosest(var_2.origin, level.allslidingdoors, 96);
      if(isDefined(var_0A)) {
        if(scripts\engine\utility::istrue(var_0A.var_4284)) {
          var_0B = anglesToForward(var_0.angles);
          var_0C = 0;
          if(!var_0C && vectordot(vectornormalize(var_6 - var_0.origin), var_0B) > 0.75 && vectordot(vectornormalize(var_0A.origin - var_0.origin), var_0B) > 0.75) {
            if(distance(var_0.origin, var_6) > distance(var_0.origin, var_2.origin)) {
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

    if(isDefined(var_5)) {
      return var_5;
    }

    return vectortoangles(var_0.origin - var_2.origin);
  }

  return vectortoangles(var_0.origin - var_2.origin);
}

initmedbaybutton() {
  var_0 = scripts\engine\utility::getstruct("button_entangle_target", "targetname");
  if(isDefined(var_0.model)) {
    var_0.model scripts\cp\cp_weapon::placeequipmentfailed("pillage", 1, var_0.model.origin);
    var_0.model delete();
  }

  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("electrical_airlock_cycle_button_dlc4");
  var_0.model = var_1;
  scripts\engine\utility::flag_wait("fuse_puzzle_completed");
  thread scripts\cp\crafted_entangler::outlineitemforplayers(var_0, var_1);
  thread scripts\cp\crafted_entangler::watchforentanglerdamage(var_0, var_1);
  var_1.collisionfunc = ::checkbuttoncollision;
}

checkbuttoncollision(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 waittill("collision");
  var_3 = var_0.origin;
  var_4 = scripts\engine\utility::getstructarray("dlc4_poster", "targetname");
  var_0 notify("end_entangler_funcs");
  var_5 = scripts\engine\utility::getclosest(var_3, var_4);
  if(distance(var_3, var_5.origin) <= 36) {
    if(isDefined(var_2)) {
      playFX(level._effect["energy_door_impact"], var_5.origin, vectortoangles(var_5.origin - var_2.origin) * 6, anglestoup(var_5.angles));
    } else {
      playFX(level._effect["energy_door_impact"], var_5.origin, anglesToForward(var_5.angles) * 6, anglestoup(var_5.angles));
    }

    scripts\engine\utility::flag_set("button_entered_poster");
    var_0 delete();
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
  foreach(var_1 in level.players) {
    var_1 scripts\cp\utility::allow_player_interactions(1);
    var_1.kicked_out = undefined;
  }

  level notify("add_hidden_song_to_playlist");
  scripts\cp\maps\cp_final\cp_final::disablepas();
  scripts\cp\maps\cp_final\cp_final::enablepa("pa_facility_rhino_room");
  scripts\cp\maps\cp_final\cp_final_rhino_boss::start_rhino_fight();
}

debugcompleteenterbossfight() {
  scripts\engine\utility::flag_set("players_triggered_bossfight");
}

finalqueststepregistration(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.var_13F4D[var_0])) {
    level.var_13F4D[var_0] = [];
  }

  if(!isDefined(var_1)) {
    var_1 = level.var_13F4D[var_0].size;
  }

  if(!isDefined(level.var_13F4C[var_0])) {
    level.var_13F4C[var_0] = -1;
  }

  var_8 = spawnStruct();
  var_8.init_func = var_2;
  var_8.var_DB5D = var_3;
  var_8.var_446D = var_4;
  var_8.var_4EB1 = var_5;
  var_8.step_description = var_7;
  level.var_13F4D[var_0][var_1] = var_8;
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
  var_0 = scripts\engine\utility::getstructarray("neil_head_final_pos", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.custom_search_dist = 96;
  }
}

neilheadfinalusefunc(var_0, var_1) {
  if(!isDefined(var_0.var_127C9)) {
    var_0.var_127C9 = [];
  }

  scripts\cp\utility::playsoundatpos_safe(var_0.origin, "item_placed");
  var_1 thread playeractivatedbossfight(var_0, var_1);
}

playeractivatedbossfight(var_0, var_1) {
  level endon("game_ended");
  var_1 notify("playerActivatedBossFight");
  var_1 endon("playerActivatedBossFight");
  var_1 endon("disconnect");
  if(!scripts\engine\utility::array_contains(var_0.var_127C9, var_1)) {
    var_0.var_127C9 = scripts\engine\utility::array_add(var_0.var_127C9, var_1);
  }

  var_0.var_127C9 = scripts\engine\utility::array_remove_duplicates(var_0.var_127C9);
  if(var_0.var_127C9.size >= level.players.size) {
    deactivateinteractionsbynoteworthy(var_0.script_noteworthy);
    foreach(var_3 in level.players) {
      var_3 notify("left_hidden_room_early");
      var_3.kicked_out = 1;
      var_3 scripts\cp\utility::allow_player_interactions(0);
    }

    wait(2);
    completeneilfinalspot();
    return;
  }

  var_1 scripts\engine\utility::waittill_any_timeout_1(2, "left_hidden_room_early", "kicked_out", "last_stand");
  if(scripts\engine\utility::array_contains(var_0.var_127C9, var_1)) {
    var_0.var_127C9 = scripts\engine\utility::array_remove(var_0.var_127C9, var_1);
  }

  if(var_0.var_127C9.size <= 0) {
    var_0.var_127C9 = [];
  }
}

completeneilfinalspot() {
  scripts\engine\utility::flag_set("players_triggered_bossfight");
  deactivateinteractionsbynoteworthy("neil_head_final_pos");
}

usepuzzlebutton(var_0, var_1) {
  if(scripts\engine\utility::flag("fuse_puzzle_completed") && scripts\engine\utility::flag("button_entered_poster") && !var_1 isjumping() && var_1 getstance() != "stand") {
    scripts\cp\utility::playsoundatpos_safe(var_0.origin, "zmb_mpq_puzzle_turn");
    scripts\engine\utility::flag_set("toggle_puzzle_button_pressed");
    deactivateinteractionsbynoteworthy("puzzle_door_button");
    var_2 = scripts\engine\utility::getstruct("entangler_button", "script_noteworthy");
    scripts\cp\utility::playsoundatpos_safe(var_2.origin, "zmb_rhino_door_explo");
  }
}

startairventfx() {
  var_0 = scripts\engine\utility::getstructarray("air_suck_loc", "targetname");
  foreach(var_2 in var_0) {
    thread playventfx(var_2);
  }
}

playventfx(var_0) {
  level endon("end_vent_fx");
  level endon("game_ended");
  var_1 = level._effect["air_vent_in"];
  for(;;) {
    var_2 = 5;
    playFX(var_1, var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
    wait(0.5);
    thread checkfornearbydisk(var_0);
    level scripts\engine\utility::waittill_any_timeout_1(var_2 - 0.5, "vent_fx");
  }
}

checkfornearbydisk(var_0) {
  level endon("game_ended");
  level notify("checkForNearbyDisk");
  level endon("checkForNearbyDisk");
  level endon("end_vent_fx");
  for(;;) {
    if(isDefined(level.undergratepuzzlepiece)) {
      var_1 = distance(var_0.origin, level.undergratepuzzlepiece.origin);
      if(scripts\engine\utility::istrue(level.undergratepuzzlepiece.hasbeenthrown) && var_1 <= 96) {
        var_0 notify("stop_watching_for_entangler_damage");
        var_2 = 750;
        var_3 = var_1 / var_2;
        if(var_3 < 0.25) {
          var_3 = 0.25;
        }

        level.undergratepuzzlepiece moveto(var_0.origin, var_3, var_3 - 0.15, 0);
        wait(var_3);
        var_0 notify("vent_grabbed_puzzle_piece");
        level notify("vent_grabbed_puzzle_piece", level.undergratepuzzlepiece);
        break;
      }
    }

    wait(0.1);
  }
}

initneilmonitors() {
  level.currentneilstate = "neutral";
  var_0 = scripts\engine\utility::getstructarray("neil_monitors", "script_noteworthy");
  level.special_mode_activation_funcs["neil_monitors"] = ::setneilstatepent;
  level.normal_mode_activation_funcs["neil_monitors"] = ::setneilstatepent;
  foreach(var_2 in var_0) {
    scripts\cp\maps\cp_final\cp_final::addtopersonalinteractionlist(var_2);
  }
}

setneilstatepent(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = getmodelfromstruct(var_1);
  switch (level.currentneilstate) {
    case "happy":
      var_0 setModel(var_5 + "_happy");
      break;

    case "straight":
      var_0 setModel(var_5 + "_o_face");
      var_0 playLoopSound("neil_alarm", 1);
      var_0.playingsound = "neil_alarm";
      var_0 thread cleanupsoundsonrelease(var_0, var_3);
      break;

    case "angry":
      var_0 setModel(var_5 + "_angry");
      break;

    case "large_happy":
      var_0 setModel(var_5 + "_happy");
      break;

    case "large_angry":
      var_0 setModel(var_5 + "_angry");
      break;

    case "large_blank":
      var_0 setModel("cp_final_monitor_large_screen");
      break;

    default:
      var_0 setModel("cp_final_monitor_small");
      break;
  }
}

getmodelfromstruct(var_0) {
  if(isDefined(var_0.script_label)) {
    return var_0.script_label;
  }

  return "cp_final_monitor_small";
}

cleanupsoundsonrelease(var_0, var_1) {
  var_0 notify("cleanUpSoundsOnRelease");
  var_0 endon("cleanUpSoundsOnRelease");
  var_2 = scripts\engine\utility::waittill_any_ents(var_1, "disconnect", var_0, "p_ent_reset", var_1, "zone_change", var_1, "rave_status_changed", var_1, "rave_interactions_updated", level, "game_ended");
  if(isDefined(var_0.playingsound)) {
    var_0 stoploopsound();
  }

  var_0.playingsound = undefined;
}

initpuzzlebutton() {
  thread initpuzzlebuttoninternal();
}

initpuzzlebuttoninternal() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("button_entered_poster");
  var_0 = scripts\engine\utility::getstructarray("puzzle_door_button", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.target)) {
      var_3 = scripts\engine\utility::getstructarray(var_2.target, "targetname")[0];
    } else {
      var_3 = var_2;
    }

    var_4 = spawn("script_model", var_3.origin);
    if(isDefined(var_3.angles)) {
      var_4.angles = var_3.angles;
    }

    var_4 setModel("electrical_airlock_cycle_button_dlc4");
  }
}

initentanglerspawner() {
  var_0 = scripts\engine\utility::getstruct("entangler_spawner", "script_noteworthy");
  var_0.groupname = "locOverride";
}

useentanglerweaponhint(var_0, var_1) {
  return "";
}

useentanglerweapon(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_1.hascollectedentangler)) {
    var_1 playlocalsound("zmb_item_pickup");
    scripts\cp\crafted_entangler::give_crafted_entangler(var_0, var_1);
  }
}

entanglerbuttonhint(var_0, var_1) {
  if(scripts\engine\utility::flag("toggle_puzzle_doors_opened")) {
    thread watchforplayerlookat(var_1);
    if(isDefined(var_1.current_button)) {
      return "";
    }

    return "";
  }

  return "";
}

entanglerbuttonuse(var_0, var_1) {
  if(scripts\engine\utility::flag("toggle_puzzle_doors_opened")) {
    if(isDefined(var_1.current_button)) {
      var_2 = gettime();
      if(var_2 >= var_0.nextneilvotime) {
        if(playneilvo("final_n31l_evil_hacked", var_1.vo_prefix)) {
          var_0.nextneilvotime = var_2 + 10000;
        }
      }

      var_1 notify("stop_interaction_logic");
      var_1.last_interaction_point = undefined;
      var_3 = var_1.current_button;
      var_1.current_button hudoutlinedisableforclient(var_1);
      scripts\cp\utility::playsoundatpos_safe(var_0.origin, "zmb_mpq_killswitch_placement");
      runbuttonrules(var_0, var_3);
      runtogglepuzzlevalidation(var_0, var_1);
      return;
    }

    var_1 scripts\cp\cp_interaction::refresh_interaction();
  }
}

setneilstate(var_0) {
  level.currentneilstate = var_0;
  foreach(var_2 in level.players) {
    var_2 thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(var_2);
  }

  switch (var_0) {
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

disabledoorswhenentangled(var_0, var_1) {
  level endon("game_ended");
  level endon("inFinalPosition");
  var_1 endon("end_entangler_funcs");
  var_1 notify("disableDoorsWhenEntangled");
  var_1 endon("disableDoorsWhenEntangled");
  var_0 endon("entangler_removed");
  var_0 endon("disconnect");
  var_1 endon("released");
  var_1 endon("launched");
  var_1 waittill("item_entangled");
  thread neilclosedoors();
  disableslidingdoorinteractions();
}

watchforitemdeleted(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("reset");
  var_1 endon("inFinalPosition");
  level endon("inFinalPosition");
  var_1 waittill("cancel_entangler");
  thread resetneilhead(var_0, var_1);
}

resetneilhead(var_0, var_1) {
  var_1 notify("end_entangler_funcs");
  var_1 notify("reset");
  var_1 endon("inFinalPosition");
  level endon("inFinalPosition");
  var_1 notify("end_entangler_funcs");
  var_1.carriedby = undefined;
  var_1.entangled = undefined;
  var_1.entangled = undefined;
  var_1 setCanDamage(0);
  var_1.origin = var_1.ogorigin;
  var_1.angles = var_1.var_C3A0;
  var_1.launched = undefined;
  var_1.reachedfirstdoor = undefined;
  var_1.reachedseconddoor = undefined;
  level.var_BEC5 stopsounds();
  unsetwavenumoverride();
  unsetzombiemovespeed();
  unsetspawndelayoverride();
  restorewavespawningcounters();
  unpausenormalwavespawning();
  resetslidingdoorstonormalstate();
  resume_spawn_wave();
  getneilheadpath(var_0, var_1);
  thread reenableneilheadentangleitem(var_0, var_1);
}

disableslidingdoorinteractions(var_0) {
  foreach(var_2 in level.allslidingdoors) {
    if(scripts\engine\utility::istrue(var_0) && !scripts\engine\utility::istrue(var_2.player_opened)) {
      continue;
    }

    var_2.nointeraction = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
  }
}

resetslidingdoorstonormalstate() {
  foreach(var_1 in level.allslidingdoors) {
    var_1.nointeraction = undefined;
    if(scripts\engine\utility::istrue(var_1.var_4284)) {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
    }
  }
}

watchforitementangled(var_0, var_1) {
  level endon("game_ended");
  var_1 notify("watchForItemEntangled");
  var_1 endon("watchForItemEntangled");
  var_1 endon("reset");
  var_1 endon("inFinalPosition");
  level endon("inFinalPosition");
  scripts\engine\utility::flag_waitopen("disable_evil_neil");
  if(scripts\engine\utility::istrue(var_1.entangled)) {
    var_1 notify("end_entangle_move_to_logic");
    var_1 notify("released");
    var_1.sendbacktospawn = 1;
    thread resetneilhead(var_0, var_1);
  }
}

neilheadlaunchfunc(var_0, var_1, var_2) {
  var_1 notify("launched");
  var_1 endon("reset");
  var_1 endon("inFinalPosition");
  level endon("inFinalPosition");
  var_1 endon("released");
  if(scripts\engine\utility::istrue(var_1.sendbacktospawn)) {
    var_0.entangledmodel = undefined;
    thread resetneilhead(var_0, var_1);
    return;
  }

  scripts\cp\crafted_entangler::launchitem(var_0, var_1, var_2);
}

reenableneilheadentangleitem(var_0, var_1) {
  level endon("game_ended");
  var_1 notify("reenableNeilHeadEntangleItem");
  var_1 endon("reenableNeilHeadEntangleItem");
  var_1 endon("inFinalPosition");
  level endon("inFinalPosition");
  var_1 hide();
  level.var_BEC5 setscriptablepartstate("angry", "show", 1);
  var_1.sendbacktospawn = undefined;
  wait(0.1);
  var_1 show();
  level waittill("wave_starting");
  if(scripts\engine\utility::flag("disable_evil_neil") && level.currentneilstate != "straight") {
    level.var_BEC5 setscriptablepartstate("happy", "show", 1);
  } else {
    scripts\engine\utility::flag_wait("disable_evil_neil");
  }

  var_2 = scripts\engine\utility::getstruct("console_neil_head", "targetname");
  itemallowentangle(var_2, var_1);
  thread disabledoorswhenentangled(var_0, var_1);
  thread watchforitementangled(var_0, var_1);
  thread watchforitemdeleted(var_0, var_1);
}

itemallowentangle(var_0, var_1) {
  thread scripts\cp\crafted_entangler::outlineitemforplayers(var_0, var_1);
  thread scripts\cp\crafted_entangler::watchforentanglerdamage(var_0, var_1);
}

checkneilheadcollision(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 waittill("collision");
  var_3 = var_0.origin;
  var_4 = scripts\engine\utility::getstruct("neil_head_final_pos", "script_noteworthy");
  var_5 = scripts\engine\utility::getstruct(var_4.target, "targetname");
  var_0 notify("end_entangler_funcs");
  if(distance(var_3, var_5.origin) <= 48) {
    deactivateinteractionsbynoteworthy("entangler_button");
    playsoundatpos(var_3, "zmb_neil_head_placement_mpq");
    level notify("neil_doing_something_evil");
    level notify("inFinalPosition");
    var_0 notify("inFinalPosition");
    scripts\engine\utility::flag_set("disable_evil_neil");
    if(isDefined(var_2)) {
      playFX(level._effect["energy_door_impact"], var_5.origin, vectortoangles(var_5.origin - var_2.origin) * 8, anglestoup(var_5.angles));
    } else {
      playFX(level._effect["energy_door_impact"], var_5.origin, anglesToForward(var_5.angles) * 8, anglestoup(var_5.angles));
    }

    scripts\engine\utility::flag_set("neils_head_placed_in_pap");
    var_0 physicsstopserver();
    var_0.origin = var_5.origin;
    var_0.angles = var_5.angles;
    resetslidingdoorstonormalstate();
    unsetwavenumoverride();
    unsetzombiemovespeed();
    unsetspawndelayoverride();
    restorewavespawningcounters();
    unpausenormalwavespawning();
    resume_spawn_wave();
    return;
  }

  playneilvo("final_n31l_evil_activate_walls", var_2.vo_prefix);
  var_0 scripts\cp\cp_weapon::placeequipmentfailed("pillage", 1, var_0.origin);
  playsoundatpos(var_3, "zmb_neil_head_explode");
  var_0 physicsstopserver();
  thread resetplaceneilshead(var_0, var_1, var_2);
  setneilstate("angry");
  var_6 = spawn("script_model", level.players[0].origin);
  var_6 setModel("tag_origin");
  var_6.team = "allies";
  level.forced_nuke = 1;
  scripts\cp\loot::process_loot_content(level.players[0], "kill_50", var_6, 0);
}

resetplaceneilshead(var_0, var_1, var_2) {
  var_0 endon("reset");
  var_0 endon("inFinalPosition");
  level endon("inFinalPosition");
  thread resetneilhead(var_2, var_0);
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
  foreach(var_1 in level.players) {
    var_1 scripts\cp\cp_merits::processmerit("mt_dlc4_hack_neil");
  }

  var_3 = scripts\engine\utility::ter_op(level.players[0] scripts\cp\utility::isplayingsolo() || level.only_one_player, int(240), int(180));
  var_4 = level scripts\engine\utility::waittill_any_timeout_1(var_3 - 5, "makeNeilEvil");
  setneilstate("straight");
  if(isDefined(var_4) && var_4 != "makeNeilEvil") {
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

runtogglepuzzlevalidation(var_0, var_1) {
  if(validatepuzzle(var_0)) {
    scripts\engine\utility::flag_set("completed_toggle_puzzle_once");
    thread deactivateneil();
    var_2 = scripts\engine\utility::getstruct("console_neil_head", "targetname");
    thread scripts\cp\crafted_entangler::outlineitemforplayers(var_2, var_2.headmodel);
    thread scripts\cp\crafted_entangler::watchforentanglerdamage(var_2, var_2.headmodel);
    getneilheadpath(var_1, var_2.headmodel);
    thread disabledoorswhenentangled(var_1, var_2.headmodel);
    thread watchforitementangled(var_1, var_2.headmodel);
    thread watchforitemdeleted(var_1, var_2.headmodel);
    scripts\cp\utility::playsoundatpos_safe(level.neil_console.origin, "zmb_mpq_puzzle_success");
  }
}

validatepuzzle(var_0) {
  var_1 = var_0.var_32F7[0].color;
  foreach(var_4, var_3 in var_0.var_32F7) {
    if(var_4 < 1) {
      continue;
    }

    if(var_3.color != var_1) {
      return 0;
    }
  }

  var_0.currentcolorstate = var_1;
  return 1;
}

togglebutton(var_0) {
  switch (var_0.color) {
    case "horizontal":
      var_0.color = "vertical";
      var_0 rotateto((0, 90, 90), 0.1);
      break;

    case "vertical":
      var_0.color = "horizontal";
      var_0 rotateto((0, 90, 0), 0.1);
      break;
  }
}

initentanglerbutton() {
  var_0 = scripts\engine\utility::getstruct("entangler_button", "script_noteworthy");
  var_0.nextneilvotime = 0;
  var_0.dontdelaytrigger = 1;
  var_1 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  assignbuttonindex(var_1, var_0);
  var_0.var_32F7 = [];
  var_1 = scripts\engine\utility::array_randomize_objects(var_1);
  var_0.currentcolorstate = undefined;
  foreach(var_6, var_3 in var_1) {
    var_4 = undefined;
    if(!isDefined(var_3.var_32D9)) {
      var_4 = spawn("script_model", var_3.origin);
      if(isDefined(var_3.angles)) {
        var_4.angles = var_3.angles;
      }
    } else {
      var_4 = var_3.var_32D9;
    }

    var_5 = "cp_final_pod_wall_handle";
    if(var_6 < 8) {
      var_4.color = "horizontal";
      var_4 rotateto((0, 90, 0), 0.1);
    } else {
      var_4.color = "vertical";
      var_4 rotateto((0, 90, 90), 0.1);
    }

    var_4 setModel(var_5);
    var_3.var_32D9 = var_4;
    var_0.var_32F7[var_0.var_32F7.size] = var_4;
    var_4.rulegroup = var_3.rulegroup;
    var_4.ruletouse = var_3.ruletouse;
  }
}

solvetogglepuzzle() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstruct("entangler_button", "script_noteworthy");
  var_1 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  foreach(var_3 in var_1) {
    var_3.var_32D9.color = "horizontal";
    var_3.var_32D9 rotateto((0, 90, 0), 0.1);
  }

  wait(0.25);
  runtogglepuzzlevalidation(var_0, level.players[0]);
}

choosedoordecoys(var_0) {
  var_0.reachedfirstdoor = undefined;
  var_0.reachedseconddoor = undefined;
  var_1 = level.allslidingdoors;
  var_1 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_1, undefined, undefined, undefined, 512);
  var_2 = scripts\engine\utility::random(var_1);
  var_1 = scripts\engine\utility::array_remove(var_1, var_2);
  var_3 = scripts\engine\utility::random(var_1);
  var_1 = scripts\engine\utility::array_remove(var_1, var_3);
  var_4 = scripts\engine\utility::random(var_1);
  var_5 = sortbydistance([var_2, var_3, var_4], var_0.origin);
  var_0.firstdoorpath = var_5[0];
  var_0.seconddoorpath = var_5[1];
  var_0.thirddoorpath = var_5[2];
}

getneilheadpath(var_0, var_1) {
  choosedoordecoys(var_1);
  var_2 = scripts\engine\utility::getstruct("pap_portal", "script_noteworthy");
  var_3 = scripts\engine\utility::getstruct("neil_head_final_pos", "script_noteworthy");
  var_4 = buildpath(level.players[0], var_1.origin, var_1.firstdoorpath.origin);
  var_5 = buildpath(level.players[0], var_4[var_4.size - 1], var_1.seconddoorpath.origin);
  var_6 = buildpath(level.players[0], var_5[var_5.size - 1], var_1.thirddoorpath.origin);
  var_7 = buildpath(level.players[0], var_6[var_6.size - 1], var_2.origin);
  var_8 = scripts\engine\utility::array_combine(var_4, var_5, var_6, var_7);
  var_8 = scripts\engine\utility::array_add(var_8, var_3.origin);
  var_1.pathtogoal = var_8;
}

buildpath(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = level.allslidingdoors;
  var_5 = 0;
  var_6 = undefined;
  for(;;) {
    if(!isDefined(var_0)) {
      var_0 = level.players[0];
    }

    if(var_3.size == 0) {
      var_3 = var_0 findpath(var_1, var_2, 1, 1);
    } else {
      var_7 = var_0 findpath(var_3[var_3.size - 1], var_2, 1, 1);
      var_3 = scripts\engine\utility::array_combine(var_3, var_7);
    }

    if(distance2dsquared(var_2, var_3[var_3.size - 1]) <= 4096) {
      return var_3;
    }

    var_4 = sortbydistance(var_4, var_3[var_3.size - 1]);
    var_8 = [];
    var_9 = undefined;
    foreach(var_0B in var_4) {
      if(var_5 && var_0B == var_4[0] || var_0B == var_6) {
        continue;
      }

      var_8 = var_0 findpath(var_3[var_3.size - 1], var_0B.origin, 1, 1);
      if(distance2dsquared(var_0B.origin, var_8[var_8.size - 1]) <= 4096) {
        var_9 = var_0B;
        break;
      }
    }

    if(!var_5) {
      var_5 = 1;
    }

    if(!isDefined(var_9)) {
      return var_3;
    } else {
      var_6 = var_9;
    }

    if(isDefined(var_9.target)) {
      var_8 = [];
      var_8[var_8.size] = var_9.origin;
      var_0D = scripts\engine\utility::getstruct(var_9.target, "targetname");
      if(isstruct(var_0D)) {
        var_8[var_8.size] = var_0D.origin;
        var_3 = scripts\engine\utility::array_combine(var_3, var_8);
      } else {
        return var_3;
      }

      continue;
    }

    return var_3;
  }
}

assignbuttonindex(var_0, var_1) {
  var_2 = [-472.8, -486.8, -500.8, -514.8];
  var_3 = [128.8, 114.8, 100.8, 86.8];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = [];
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
  foreach(var_1D in var_0) {
    var_1E = var_1D.origin[0];
    var_1F = var_1D.origin[2];
    var_1D.id = 1;
    var_1D.rulegroup = [];
    if(isDefined(var_1D.script_noteworthy)) {
      var_1D.id = int(var_1D.script_noteworthy);
    }

    switch (var_1D.id) {
      case 1:
        var_5[var_5.size] = var_1D;
        var_6[var_6.size] = var_1D;
        var_8[var_8.size] = var_1D;
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
        var_4[var_4.size] = var_1D;
        var_7[var_7.size] = var_1D;
        var_9[var_9.size] = var_1D;
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
        var_6[var_6.size] = var_1D;
        var_7[var_7.size] = var_1D;
        var_8[var_8.size] = var_1D;
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
        var_4[var_4.size] = var_1D;
        var_5[var_5.size] = var_1D;
        var_9[var_9.size] = var_1D;
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
        var_6[var_6.size] = var_1D;
        var_7[var_7.size] = var_1D;
        var_9[var_9.size] = var_1D;
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
        var_4[var_4.size] = var_1D;
        var_5[var_5.size] = var_1D;
        var_8[var_8.size] = var_1D;
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
        var_5[var_5.size] = var_1D;
        var_6[var_6.size] = var_1D;
        var_9[var_9.size] = var_1D;
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
        var_4[var_4.size] = var_1D;
        var_7[var_7.size] = var_1D;
        var_8[var_8.size] = var_1D;
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
        var_6[var_6.size] = var_1D;
        var_7[var_7.size] = var_1D;
        var_8[var_8.size] = var_1D;
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
        var_4[var_4.size] = var_1D;
        var_5[var_5.size] = var_1D;
        var_9[var_9.size] = var_1D;
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
        var_5[var_5.size] = var_1D;
        var_6[var_6.size] = var_1D;
        var_8[var_8.size] = var_1D;
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
        var_4[var_4.size] = var_1D;
        var_7[var_7.size] = var_1D;
        var_9[var_9.size] = var_1D;
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
        var_5[var_5.size] = var_1D;
        var_6[var_6.size] = var_1D;
        var_9[var_9.size] = var_1D;
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
        var_4[var_4.size] = var_1D;
        var_7[var_7.size] = var_1D;
        var_8[var_8.size] = var_1D;
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
        var_6[var_6.size] = var_1D;
        var_7[var_7.size] = var_1D;
        var_9[var_9.size] = var_1D;
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
        var_4[var_4.size] = var_1D;
        var_5[var_5.size] = var_1D;
        var_8[var_8.size] = var_1D;
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

  var_1.group1 = var_4;
  var_1.group2 = var_5;
  var_1.group3 = var_6;
  var_1.group4 = var_7;
  var_1.group5 = var_8;
  var_1.group6 = var_9;
  var_1.group7 = var_0A;
  var_1.group8 = var_0B;
  var_1.group9 = var_0C;
  var_1.group10 = var_0D;
  var_1.group11 = var_0E;
  var_1.group12 = var_0F;
  var_1.group13 = var_10;
  var_1.group14 = var_11;
  var_1.group15 = var_12;
  var_1.group16 = var_13;
  var_1.group17 = var_14;
  var_1.group18 = var_15;
  var_1.group19 = var_16;
  var_1.group20 = var_17;
  var_1.group21 = var_18;
  var_1.group22 = var_19;
  var_1.group23 = var_1A;
  var_1.group24 = var_1B;
  thread assignbuttonrules(var_0, var_1);
}

assignbuttonrules(var_0, var_1) {
  var_2 = randomint(6);
  foreach(var_4 in var_0) {
    switch (var_4.id) {
      case 1:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group1;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group8;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group10;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group13;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group17;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group23;
        break;

      case 2:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group2;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group8;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group12;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group16;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group20;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group22;
        break;

      case 3:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group2;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group8;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group9;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group16;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group19;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group21;
        break;

      case 4:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group3;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group8;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group9;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group14;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group18;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group23;
        break;

      case 5:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group1;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group5;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group12;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group15;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group20;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group21;
        break;

      case 6:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group4;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group6;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group12;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group13;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group17;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group24;
        break;

      case 7:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group4;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group5;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group12;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group14;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group18;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group24;
        break;

      case 8:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group3;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group6;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group9;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group15;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group19;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group22;
        break;

      case 9:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group1;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group6;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group11;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group15;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group20;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group22;
        break;

      case 10:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group4;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group5;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group11;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group14;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group17;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group23;
        break;

      case 11:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group4;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group6;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group11;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group13;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group18;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group23;
        break;

      case 12:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group3;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group5;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group10;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group15;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group19;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group21;
        break;

      case 13:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group1;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group7;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group9;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group14;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group17;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group24;
        break;

      case 14:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group2;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group7;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group11;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group16;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group20;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group21;
        break;

      case 15:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group2;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group7;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group10;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group16;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group19;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group22;
        break;

      case 16:
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group3;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group7;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group10;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group13;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group18;
        var_4.rulegroup[var_4.rulegroup.size] = var_1.group24;
        break;
    }

    if(scripts\engine\utility::flag("completed_toggle_puzzle_once")) {
      var_4.ruletouse = var_4.rulegroup[var_2];
      continue;
    }

    var_4.ruletouse = var_4.rulegroup[0];
  }
}

runbuttonrules(var_0, var_1) {
  togglebutton(var_1);
  var_2 = var_1.ruletouse;
  foreach(var_4 in var_2) {
    var_5 = var_4.var_32D9;
    if(var_5 == var_1) {
      continue;
    }

    togglebutton(var_5);
  }
}

buttonrule2(var_0, var_1) {
  togglebutton(var_1);
  foreach(var_3 in var_0.group2) {
    var_4 = var_3.var_32D9;
    if(var_4 == var_1) {
      continue;
    }

    togglebutton(var_4);
  }
}

buttonrule3(var_0, var_1) {
  togglebutton(var_1);
  foreach(var_3 in var_0.group3) {
    var_4 = var_3.var_32D9;
    if(var_4 == var_1) {
      continue;
    }

    togglebutton(var_4);
  }
}

buttonrule4(var_0, var_1) {
  togglebutton(var_1);
  foreach(var_3 in var_0.group4) {
    var_4 = var_3.var_32D9;
    if(var_4 == var_1) {
      continue;
    }

    togglebutton(var_4);
  }
}

watchforplayerlookat(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("watchForPlayerLookat");
  var_0 endon("stop_interaction_logic");
  var_0 thread unsetplayerlookat(var_0);
  var_1 = scripts\engine\utility::getstruct("entangler_button", "script_noteworthy");
  var_2 = var_1.var_32F7;
  var_3 = undefined;
  var_4 = undefined;
  for(;;) {
    var_5 = 0;
    foreach(var_7 in var_2) {
      if(var_0 worldpointinreticle_circle(var_7.origin, 65, 20)) {
        var_5 = 1;
        var_0.current_button = var_7;
        var_4 = 2;
        if(isDefined(var_3)) {
          if(var_3 != var_7) {
            var_3 hudoutlinedisableforclient(var_0);
            var_7 hudoutlineenableforclient(var_0, var_4, 0, 0);
          }
        } else {
          var_7 hudoutlineenableforclient(var_0, var_4, 0, 0);
        }

        var_3 = var_7;
      }
    }

    if(!scripts\engine\utility::istrue(var_5)) {
      if(isDefined(var_3)) {
        var_3 hudoutlinedisableforclient(var_0);
      }

      var_0.current_button = undefined;
      var_3 = undefined;
    }

    wait(0.05);
  }
}

unsetplayerlookat(var_0) {
  var_0 endon("disconnect");
  var_0 endon("watchForPlayerLookat");
  var_0 waittill("stop_interaction_logic");
  if(isDefined(var_0.current_button)) {
    var_0.current_button hudoutlinedisableforclient(var_0);
    var_0.current_button = undefined;
  }
}

watchforentanglerdamage(var_0) {
  level endon("game_ended");
  level endon("endMonitorDamageLoop");
  scripts\engine\utility::flag_wait("restorepower_step1");
  for(;;) {
    level waittill("entangler_item_collision", var_1);
    if(distance(var_1, sortbydistance(var_0, var_1)[0].origin) <= 56) {
      foreach(var_3 in var_0) {
        var_3 setModel("cp_final_monitor_large_screen_cracked");
      }

      break;
    }
  }

  scripts\engine\utility::flag_set("security_doors_deactivated");
  level notify("endMonitorDamageLoop");
}

initneilconsole() {
  foreach(var_1 in scripts\engine\utility::getstructarray("neil_console", "script_noteworthy")) {
    var_1.nextneilvotime = 0;
  }

  deactivateinteractionsbynoteworthy("neil_console");
}

initfusepuzzleinteraction() {
  deactivateinteractionsbynoteworthy("fuse_puzzle");
  deactivateinteractionsbynoteworthy("puzzle_pieces");
}

deactivateinteractionsbynoteworthy(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "script_noteworthy");
  foreach(var_3 in var_1) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
  }
}

deletemodelsbynoteworthy(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "script_noteworthy");
  foreach(var_3 in var_1) {
    if(isDefined(var_3.model)) {
      var_3.model delete();
    }
  }
}

activateinteractionsbynoteworthy(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "script_noteworthy");
  foreach(var_3 in var_1) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_3);
  }
}

initpuzzlecombinations() {
  var_0 = "cp\zombies\cp_final_puzzle_combos.csv";
  level.puzzle_combinations = [];
  level.insertedpieces = [];
  var_1 = 0;
  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);
    if(var_2 == "") {
      break;
    }

    level.puzzle_combinations[level.puzzle_combinations.size] = var_2;
    var_1++;
  }
}

spawnmodelatstruct(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "tag_origin";
  }

  var_2 = spawn("script_model", var_0.origin);
  if(isDefined(var_0.angles)) {
    var_2.angles = var_0.angles;
  } else {
    var_2.angles = (0, 0, 0);
  }

  var_2 setModel(var_1);
  return var_2;
}

initmedbaymonitors() {
  var_0 = scripts\engine\utility::getstructarray("med_bay_monitors", "targetname");
  var_1 = [];
  foreach(var_3 in var_0) {
    var_4 = spawn("script_model", var_3.origin);
    if(isDefined(var_3.angles)) {
      var_4.angles = var_3.angles;
    }

    if(isDefined(var_3.script_modelname)) {
      var_4 setModel(var_3.script_modelname);
    }

    var_1[var_1.size] = var_4;
  }

  level thread watchforentanglerdamage(var_1);
}

spawnpuzzlepieces() {
  var_0 = scripts\engine\utility::getstructarray("puzzle_pieces", "script_noteworthy");
  level.puzzlestates = getvalidpuzzlestates();
  level.phantomdisk = level.puzzlestates[level.puzzlestates.size - 1];
  foreach(var_3, var_2 in var_0) {
    spawnpuzzlepiece(var_3, var_2);
  }
}

spawnpuzzlepiece(var_0, var_1) {
  if(isDefined(var_1.model)) {
    var_1.model delete();
  }

  if(isDefined(var_1.screenmodel)) {
    var_1.screenmodel delete();
  }

  if(isDefined(var_1.target)) {
    var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");
  } else {
    var_2 = var_2;
  }

  var_3 = spawn("script_model", var_2.origin);
  var_4 = level.puzzlestates[var_0];
  switch (int(var_4)) {
    case 1:
      var_3 setModel("cp_final_floppydisk_01");
      break;

    case 2:
      var_3 setModel("cp_final_floppydisk_02");
      break;

    case 3:
      var_3 setModel("cp_final_floppydisk_03");
      break;

    case 4:
      var_3 setModel("cp_final_floppydisk_04");
      break;

    case 5:
      var_3 setModel("cp_final_floppydisk_05");
      break;

    case 6:
      var_3 setModel("cp_final_floppydisk_06");
      break;

    case 7:
      var_3 setModel("cp_final_floppydisk_07");
      break;

    case 8:
      var_3 setModel("cp_final_floppydisk_08");
      break;

    case 9:
      var_3 setModel("cp_final_floppydisk_09");
      break;

    case 10:
      var_3 setModel("cp_final_floppydisk_10");
      break;

    case 11:
      var_3 setModel("cp_final_floppydisk_11");
      break;

    case 12:
      var_3 setModel("cp_final_floppydisk_12");
      break;
  }

  if(isDefined(var_2.angles)) {
    var_3.angles = var_2.angles;
  }

  var_1.id = var_0;
  var_1.model = var_3;
  var_1.state = level.puzzlestates[var_0];
  if(isDefined(var_1.groupname)) {
    var_3.hasbeenthrown = undefined;
    var_1 notify("new_model_created");
    var_1.entanglemodel = var_3;
    var_3.parent_struct = var_1;
    thread scripts\cp\crafted_entangler::outlineitemforplayers(var_1, var_1.model);
    thread scripts\cp\crafted_entangler::watchforentanglerdamage(var_1, var_1.model);
    var_1.var_1088C = ::spawnpuzzlepiece;
    var_1.entanglemovetofunc = ::entanglemovetocheckforcollision;
    var_3.collisionfunc = ::diskcustomcollisionfunc;
    var_1 thread disableaftermovethroughvent(var_1);
  }
}

disableaftermovethroughvent(var_0) {
  var_0 endon("new_model_created");
  level waittill("vent_grabbed_puzzle_piece", var_1);
  level.undergratepuzzlepiece = undefined;
  var_2 = level.struct_class_names["targetname"]["interaction"];
  var_3 = level.struct_class_names["script_noteworthy"]["puzzle_pieces"];
  var_2 = scripts\engine\utility::array_remove(var_2, var_0);
  var_3 = scripts\engine\utility::array_remove(var_3, var_0);
  level.struct_class_names["targetname"]["interaction"] = var_2;
  level.struct_class_names["script_noteworthy"]["puzzle_pieces"] = var_3;
  var_4 = level._effect["air_vent_out"];
  var_5 = scripts\engine\utility::getstructarray("puzzle_piece_landing", "targetname");
  var_6 = scripts\engine\utility::random(var_5);
  playFX(var_4, var_6.origin, anglesToForward(var_6.angles), anglestoup(var_6.angles));
  var_1 notify("end_entangler_funcs");
  var_1 setCanDamage(0);
  var_1 dontinterpolate();
  var_1.origin = var_6.origin;
  var_1.angles = var_6.angles;
  var_7 = scripts\engine\utility::getstruct(var_6.target, "targetname");
  var_1 moveto(var_7.origin, 0.5, 0.1, 0);
  var_1 rotateto(var_7.angles, 0.5);
  var_7.model = var_1;
  var_7.script_noteworthy = "puzzle_pieces";
  var_7.var_336 = "interaction";
  var_7.requires_power = 0;
  var_7.powered_on = 1;
  var_7.script_parameters = "default";
  var_7.state = var_0.state;
  level.struct_class_names["targetname"]["interaction"][level.struct_class_names["targetname"]["interaction"].size] = var_7;
  level.struct_class_names["script_noteworthy"]["puzzle_pieces"][level.struct_class_names["script_noteworthy"]["puzzle_pieces"].size] = var_7;
  if(scripts\engine\utility::flag("neil_head_placed")) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_7);
  }

  wait(0.5);
  level notify("end_vent_fx");
}

diskcustomcollisionfunc(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = scripts\engine\utility::getstructarray("air_suck_loc", "targetname");
  for(var_4 = 0; var_4 <= 100; var_4++) {
    var_5 = var_0.origin;
    var_6 = var_0.angles;
    var_0 scripts\engine\utility::waittill_any_timeout_1(0.1, "collision");
    level notify("entangler_item_collision", var_0.origin);
    if(distance(var_5, var_0.origin) < 1 && var_6 == var_0.angles) {
      break;
    }
  }

  if(var_4 >= 100) {
    var_0.forcedrespawn = 1;
  }

  var_0.hasbeenthrown = 1;
  var_0.launched = undefined;
  foreach(var_8 in var_3) {
    if(distance(var_8.origin, var_0.origin) <= 96) {
      var_0 notify("released", undefined, 1, 36);
      return;
    }
  }

  var_0 notify("released", 1);
}

entanglemovetocheckforcollision(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::array_combine(level.players, [var_2]);
  var_5 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 0, 1);
  var_6 = scripts\common\trace::capsule_trace((var_0.origin[0], var_0.origin[1], var_3.origin[2]), var_3.origin, 16, 32, undefined, var_4, var_5, 24);
  var_7 = var_6["hittype"];
  if(isDefined(var_7) && var_7 != "hittype_none") {
    return 0;
  }

  return 1;
}

getvalidpuzzlestates() {
  var_0 = randomint(level.puzzle_combinations.size);
  var_1 = strtok(level.puzzle_combinations[var_0], ",");
  level.correctneilpuzzleanswer = var_1;
  return scripts\engine\utility::array_randomize_objects(var_1);
}

spawnn31lhead() {
  var_0 = scripts\engine\utility::getstructarray("neil_head", "script_noteworthy");
  var_0 = scripts\engine\utility::array_randomize_objects(var_0);
  var_1 = var_0[0];
  if(isDefined(var_1.target)) {
    var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");
  } else {
    var_2 = var_2;
  }

  var_3 = spawnmodelatstruct(var_2, "final_kevin_head_blank");
  var_1.headmodel = var_3;
  var_1.nextneilvotime = 0;
  level.var_BEC5 = var_3;
  foreach(var_5 in var_0) {
    if(var_5 == var_1) {
      continue;
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_5);
  }
}

consolehintfunc(var_0, var_1) {
  if(scripts\engine\utility::flag("neil_head_placed") && !scripts\engine\utility::flag("fuse_puzzle_completed")) {
    var_2 = gettime();
    if(var_2 >= var_0.nextneilvotime) {
      if(playneilvofromconsoleorhead("final_n31l_misc_reaction", 1)) {
        var_0.nextneilvotime = var_0.nextneilvotime + 10000;
      }
    }
  }

  return "";
}

headhintfunc(var_0, var_1) {
  var_2 = gettime();
  if(var_2 >= var_0.nextneilvotime) {
    if(playneilvofromconsoleorhead("final_n31l_found")) {
      var_0.nextneilvotime = var_2 + 10000;
    }
  }

  return &"CP_FINAL_PICKUP_ITEM";
}

puzzlepiecehintfunc(var_0, var_1) {
  if(!isDefined(var_1.haspuzzlepiece) || isDefined(var_1.haspuzzlepiece) && var_1.haspuzzlepiece != var_0.state) {
    if(isDefined(level.phantomdisk) && var_0.state == level.phantomdisk) {
      return &"CP_FINAL_PICKUP_ITEM";
    }

    return "";
  }

  return "";
}

puzzlepieceusefunc(var_0, var_1) {
  if(!isDefined(var_1.haspuzzlepiece) || isDefined(var_1.haspuzzlepiece) && var_1.haspuzzlepiece != var_0.state) {
    if(isDefined(var_0.target)) {
      var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    } else {
      var_2 = var_1;
    }

    var_1.haspuzzlepiece = var_0.state;
    var_1 playlocalsound("zmb_item_pickup");
    playFX(level._effect["generic_pickup"], var_2.origin);
    var_1 setclientomnvar("zm_hud_inventory_1", int(var_0.state));
  }
}

consoleusefunc(var_0, var_1) {
  if(!scripts\engine\utility::flag("neil_head_placed")) {
    scripts\engine\utility::flag_set("neil_head_placed");
    scripts\cp\utility::playsoundatpos_safe(var_0.origin, "zmb_neil_head_placement");
    if(level.players.size >= 4) {
      if(scripts\engine\utility::cointoss()) {
        level thread foundpowervo(var_1);
        return;
      }

      if(scripts\engine\utility::cointoss()) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_head_place", "zmb_comment_vo");
        return;
      }

      playneilvofromconsoleorhead("final_n31l_back_to_console", 1);
      return;
    }

    if(scripts\engine\utility::cointoss()) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_head_place", "zmb_comment_vo");
      return;
    }

    playneilvofromconsoleorhead("final_n31l_back_to_console", 1);
    return;
  }
}

foundpowervo(var_0) {
  if(isDefined(var_0.vo_prefix)) {
    switch (var_0.vo_prefix) {
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

validatepuzzleslot(var_0, var_1) {
  for(var_2 = 0; var_2 < level.correctneilpuzzleanswer.size; var_2++) {
    if(level.correctneilpuzzleanswer[var_2] != level.insertedpieces[var_2]) {
      return 0;
    }
  }

  return 1;
}

headusefunc(var_0, var_1) {
  scripts\engine\utility::flag_set("neil_head_found");
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_head_find", "zmb_comment_vo");
  scripts\cp\maps\cp_final\cp_final_interactions::generic_pickup_gesture_and_fx(var_1, var_0.headmodel.origin);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

fusepuzzlehintfunc(var_0, var_1) {
  if(isDefined(var_1.haspuzzlepiece)) {
    var_1.interaction_trigger sethintstringparams(int(var_0.name));
    return &"CP_FINAL_INSERT_DISK";
  }

  var_1 thread scripts\cp\cp_vo::try_to_play_vo("missing_item_misc", "zmb_comment_vo");
  return "";
}

fusepuzzleusefunc(var_0, var_1) {
  if(isDefined(var_1.haspuzzlepiece)) {
    scripts\cp\utility::set_quest_icon(11);
    var_1 setclientomnvar("zm_hud_inventory_1", 0);
    var_2 = var_1.haspuzzlepiece;
    var_3 = "disk_slot_" + var_0.name;
    switch (int(var_2)) {
      case 1:
        level.neil_console setscriptablepartstate(var_3, "disk01");
        break;

      case 2:
        level.neil_console setscriptablepartstate(var_3, "disk02");
        break;

      case 3:
        level.neil_console setscriptablepartstate(var_3, "disk03");
        break;

      case 4:
        level.neil_console setscriptablepartstate(var_3, "disk04");
        break;

      case 5:
        level.neil_console setscriptablepartstate(var_3, "disk05");
        break;

      case 6:
        level.neil_console setscriptablepartstate(var_3, "disk06");
        break;

      case 7:
        level.neil_console setscriptablepartstate(var_3, "disk07");
        break;

      case 8:
        level.neil_console setscriptablepartstate(var_3, "disk08");
        break;

      case 9:
        level.neil_console setscriptablepartstate(var_3, "disk09");
        break;

      case 10:
        level.neil_console setscriptablepartstate(var_3, "disk10");
        break;

      case 11:
        level.neil_console setscriptablepartstate(var_3, "disk11");
        break;

      case 12:
        level.neil_console setscriptablepartstate(var_3, "disk12");
        break;
    }

    scripts\cp\utility::playsoundatpos_safe(var_0.origin, "zmb_floppy_disc_insert");
    var_4 = int(var_0.name) - 1;
    removeinvalidpuzzlepieces(var_2);
    var_1.haspuzzlepiece = undefined;
    level.insertedpieces[var_4] = var_2;
    var_1 setclientomnvar("zm_special_item", 0);
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    setomnvar("zm_floppy_count", level.insertedpieces.size);
    if(level.insertedpieces.size == 4) {
      if(!validatepuzzleslot(var_0, var_1)) {
        playsoundatpos(var_0.origin, "mpq_fail_buzzer");
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
      scripts\cp\utility::playsoundatpos_safe(var_0.origin, "zmb_floppy_quest_complete");
      deactivateinteractionsbynoteworthy("puzzle_pieces");
      scripts\engine\utility::flag_set("fuse_puzzle_completed");
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_part_" + level.insertedpieces.size, "zmb_comment_vo");
      playneilvofromconsoleorhead("final_n31l_return_part_4", 1);
      return;
    }

    var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_n31l_part_" + level.insertedpieces.size, "zmb_comment_vo");
    var_5 = gettime();
    if(var_5 >= level.neil_console.nextneilvotime) {
      if(playneilvofromconsoleorhead(scripts\engine\utility::random(["final_n31l_return_part_1", "final_n31l_return_part_2", "final_n31l_return_part_3"]), 1)) {
        level.neil_console.nextneilvotime = var_5 + 15000;
        return;
      }

      return;
    }
  }
}

removeinvalidpuzzlepieces(var_0) {
  var_1 = scripts\engine\utility::getstructarray("puzzle_pieces", "script_noteworthy");
  foreach(var_3 in var_1) {
    if(var_0 == var_3.state) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
    }
  }

  foreach(var_6 in level.players) {
    if(isDefined(var_6.haspuzzlepiece) && var_6.haspuzzlepiece == var_0) {
      var_6 setclientomnvar("zm_hud_inventory_1", 0);
      var_6.haspuzzlepiece = undefined;
    }
  }
}

blank(var_0, var_1) {}

retrieveneilshead() {
  scripts\engine\utility::flag_wait("neil_head_found");
}

completeretrieveneilshead() {
  scripts\cp\utility::set_quest_icon(6);
  activateinteractionsbynoteworthy("neil_console");
  var_0 = scripts\engine\utility::getstructarray("neil_head", "script_noteworthy");
  deactivateinteractionsbynoteworthy("neil_head");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.headmodel)) {
      var_2.headmodel delete();
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
  var_0 = scripts\engine\utility::getstruct("console_neil_head", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("final_kevin_head_dynamic");
  var_1.ogorigin = var_0.origin;
  var_1.var_C3A0 = var_0.angles;
  var_1.customlaunchfunc = ::neilheadlaunchfunc;
  var_1.collisionfunc = ::checkneilheadcollision;
  var_0.headmodel = var_1;
  var_1.parent_struct = var_0;
  level.var_BEC5 = var_1;
  scripts\cp\maps\cp_final\cp_final::enablepa("pa_facility");
  wait(0.5);
  setneilstate("happy");
  foreach(var_3 in level.players) {
    var_3 scripts\cp\cp_merits::processmerit("mt_dlc4_neil_upgrade");
  }

  thread playneilnag(["final_n31l_nag_missing_pieces", "final_n31l_request_pieces"], "fuse_puzzle_completed");
}

debugplaceneilshead() {
  scripts\engine\utility::flag_set("neil_head_placed");
}

playneilnag(var_0, var_1) {
  level endon("game_ended");
  level notify("playNeilNag");
  level endon("playNeilNag");
  while(isDefined(var_1) && !scripts\engine\utility::flag(var_1)) {
    wait(randomintrange(30, 60));
    var_2 = scripts\engine\utility::random(var_0);
    var_3 = gettime();
    if(var_3 >= level.neilvotime) {
      foreach(var_5 in level.players) {
        if(isDefined(var_5.currentlocation) && var_5.currentlocation == "facility") {
          var_5 scripts\cp\utility::playlocalsound_safe(var_2);
        }
      }

      var_7 = lookupsoundlength(var_2);
      setnextneilvotime(var_7);
    }
  }
}

playneilvo(var_0, var_1) {
  var_2 = gettime();
  if(var_2 >= level.neilvotime) {
    foreach(var_4 in level.players) {
      if(isDefined(var_4.currentlocation) && var_4.currentlocation == "facility") {
        var_4 scripts\cp\utility::playlocalsound_safe(var_0);
      }
    }

    var_6 = lookupsoundlength(var_0);
    if(isDefined(var_1)) {
      var_7 = getsoundaliasfromvoprefix(var_1, 1);
      thread playplayernameaftertime(var_6, var_7);
      var_6 = var_6 + lookupsoundlength(var_7);
    }

    setnextneilvotime(var_6);
    return 1;
  }

  return 0;
}

getsoundaliasfromvoprefix(var_0, var_1) {
  switch (var_0) {
    case "p1_":
      if(scripts\engine\utility::istrue(var_1)) {
        return "final_n31l_name_sally_pa";
      } else {
        return "final_n31l_name_sally";
      }

      break;

    case "p2_":
      if(scripts\engine\utility::istrue(var_1)) {
        return "final_n31l_name_poindexter_pa";
      } else {
        return "final_n31l_name_poindexter";
      }

      break;

    case "p3_":
      if(scripts\engine\utility::istrue(var_1)) {
        return "final_n31l_name_andre_pa";
      } else {
        return "final_n31l_name_andre";
      }

      break;

    case "p4_":
      if(scripts\engine\utility::istrue(var_1)) {
        return "final_n31l_name_aj_pa";
      }
      return "final_n31l_name_aj";
  }
}

playplayernameaftertime(var_0, var_1) {
  level endon("game_ended");
  wait(var_0 / 1000);
  foreach(var_3 in level.players) {
    if(isDefined(var_3.currentlocation) && var_3.currentlocation == "facility") {
      var_3 scripts\cp\utility::playlocalsound_safe(var_1);
    }
  }
}

playneilvofromconsoleorhead(var_0, var_1, var_2) {
  var_3 = gettime();
  if(var_3 >= level.neilvotime) {
    if(scripts\engine\utility::istrue(var_1)) {
      if(isDefined(level.neil_console)) {
        level.neil_console stopsounds();
        level.neil_console playSound(var_0);
        var_4 = lookupsoundlength(var_0);
        if(isDefined(var_2)) {
          var_5 = getsoundaliasfromvoprefix(var_2);
          thread playplayernameaftertime(var_4, var_5);
          var_4 = var_4 + lookupsoundlength(var_5);
        }

        setnextneilvotime(var_4);
        return 1;
      }

      return 0;
    }

    if(isDefined(level.var_BEC5)) {
      level.var_BEC5 stopsounds();
      level.var_BEC5 playSound(var_1);
      var_4 = lookupsoundlength(var_1);
      if(isDefined(var_2)) {
        var_5 = getsoundaliasfromvoprefix(var_2);
        thread playplayernameaftertime(var_4, var_5);
        var_4 = var_4 + lookupsoundlength(var_5);
      }

      setnextneilvotime(var_4);
      return 1;
    }

    return 0;
  }

  return 0;
}

setnextneilvotime(var_0) {
  level.neilvotime = gettime() + var_0;
}

turnonfacilitypower() {
  level notify("power_on");
  scripts\engine\utility::flag_set("restorepower_step1");
  scripts\engine\utility::flag_set("power_on");
  level.var_D746 = 1;
  var_0 = getEntArray("spawn_volume", "targetname");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.basename)) {
      var_3 = var_2.basename;
    } else {
      continue;
    }

    level notify(var_3 + " power_on");
    if(scripts\engine\utility::flag_exist(var_3 + " power_on")) {
      scripts\engine\utility::flag_set(var_3 + " power_on");
    }
  }
}

initpuzzledoors() {
  var_0 = scripts\engine\utility::getstructarray("toggle_puzzle_doors", "targetname");
  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin);
    var_3.angles = var_2.angles;
    var_3 setModel("building_pod_wall_panel_01_thin");
    var_2.doormodel = var_3;
  }
}

waitforsecuritydoorsdestroyed() {
  scripts\engine\utility::flag_wait("security_doors_deactivated");
}

securitydoorsdestroyed() {
  level notify("kill_energy_doors");
  foreach(var_1 in level.all_quest_doors) {
    playsoundatpos(var_1.origin, "zmb_forcefield_destroyed");
    var_1 delete();
  }

  var_3 = getent("med_bay_door_clip", "targetname");
  var_3 notsolid();
  activateinteractionsbynoteworthy("entangler_button");
}

openpuzzledoors() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstructarray("toggle_puzzle_doors", "targetname");
  foreach(var_2 in var_0) {
    var_2.doormodel delete();
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
  foreach(var_1 in level.players) {
    var_1 scripts\cp\utility::stoplocalsound_safe("final_n31l_nag_missing_pieces");
  }

  scripts\engine\utility::flag_set("fuse_puzzle_completed");
  thread neildoevilstuff();
  scripts\cp\utility::set_quest_icon(10);
  setneilstate("straight");
  foreach(var_1 in level.players) {
    var_1 scripts\cp\zombies\achievement::update_achievement("FRIENDS_FOREVER", 1);
  }

  deactivateinteractionsbynoteworthy("fuse_puzzle");
  deactivateinteractionsbynoteworthy("puzzle_pieces");
  var_5 = scripts\engine\utility::getstructarray("puzzle_pieces", "script_noteworthy");
  foreach(var_7 in var_5) {
    if(isDefined(var_7.model)) {
      var_7.model delete();
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
  var_0 = scripts\engine\utility::getstructarray("pap_bridge", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.name = "pap_quest";
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel("debris_exterior_damaged_metal_panels_08_scl50");
    var_3.angles = var_2.angles;
    var_3.var_336 = "pap_bridge_model";
  }

  scripts\engine\utility::flag_init("bridge_pieces_collected");
}

spawnastronauts() {
  level.astronautsshot = 0;
  var_0 = scripts\engine\utility::getstructarray("hidden_song_nick", "script_noteworthy");
  var_0 = sortbydistance(var_0, (5715, -4040, 131));
  level.astronaut_structs = [];
  foreach(var_4, var_2 in var_0) {
    if(var_4 == 0) {
      continue;
    }

    level.astronaut_structs[level.astronaut_structs.size] = var_2;
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel("zmb_arcade_toy_astronaut_white");
    var_3.angles = var_2.angles;
    var_3.script_noteworthy = "astronaut_model";
    if(isDefined(var_2.var_336)) {
      var_3.var_336 = var_2.var_336 + "_model";
    }

    var_3 thread astronautwatchfordamage();
  }

  var_5 = getent("astronaut_aide_trigger", "script_noteworthy");
  if(isDefined(var_5)) {
    var_5 thread astronautaidetriggerwatch(var_5);
  }
}

astronautwatchfordamage() {
  level endon("game_ended");
  self endon("released");
  self.health = 9999999;
  self.maxhealth = 9999999;
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_0, var_0, var_0, var_0, var_5);
    tryreleaseastronaut(var_1, var_5);
  }
}

astronautaidetriggerwatch(var_0) {
  var_0 = getent(self.target + "_model", "targetname");
  var_0 endon("released");
  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_1, var_1, var_1, var_1, var_6);
    if(isDefined(var_0)) {
      thread scripts\cp\utility::debugprintline("release");
      var_0 tryreleaseastronaut(var_2, var_6);
    }
  }
}

tryreleaseastronaut(var_0, var_1) {
  if(isplayer(var_0)) {
    wait(0.2);
    level.astronautsshot++;
    if(isDefined(var_0)) {
      thread generic_interaction_no_gesture(var_0, self);
    }

    self.released = 1;
    self hide();
    if(level.astronautsshot >= level.astronaut_structs.size) {
      foreach(var_3 in level.players) {
        var_3 thread scripts\cp\cp_vo::try_to_play_vo("song_quest_success", "final_comment_vo");
        var_3 scripts\cp\zombies\achievement::update_achievement("BROKEN_RECORD", 1);
      }

      if(isDefined(var_0)) {
        built_bridge_feedback(var_0);
      }

      level notify("add_hidden_song_to_playlist");
      scripts\cp\maps\cp_final\cp_final::enablepas();
      level thread play_hidden_song((1785, -2077, 211), "mus_pa_final_hidden_track");
      level notify("song_ee_achievement_given");
    }

    self notify("released");
  }
}

play_hidden_song(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    level endon("game_ended");
  }

  if(var_1 == "mus_pa_final_hidden_track") {
    level endon("add_hidden_song_to_playlist");
  }

  if(soundexists(var_1)) {
    wait(2.5);
    if(var_1 == "mus_pa_final_hidden_track") {
      foreach(var_4 in level.players) {
        var_4 thread scripts\cp\cp_vo::try_to_play_vo("song_quest_start", "final_comment_vo");
        if(scripts\engine\utility::istrue(level.onlinegame)) {
          var_4 setplayerdata("cp", "hasSongsUnlocked", "any_song", 1);
          if(var_1 == "mus_pa_final_hidden_track") {
            var_4 setplayerdata("cp", "hasSongsUnlocked", "song_6", 1);
          }
        }
      }
    }

    var_6 = undefined;
    if(isDefined(var_6)) {
      level thread scripts\cp\cp_vo::try_to_play_vo(var_6, "zmb_dj_vo", "high", 60, 1, 0, 1);
      var_7 = lookupsoundlength(var_6) / 1000;
      wait(var_7);
    }

    scripts\engine\utility::play_sound_in_space("zmb_jukebox_on", var_0);
    var_8 = spawn("script_origin", var_0);
    var_9 = "ee";
    var_0A = 1;
    foreach(var_4 in level.players) {
      var_4 scripts\cp\cp_persistence::give_player_xp(2000, 1);
    }

    var_8 playLoopSound(var_1);
    var_8 thread scripts\cp\zombies\zombie_jukebox::earlyendon(var_8);
    var_0D = lookupsoundlength(var_1) / 1000;
    if(!isDefined(var_2)) {
      level scripts\engine\utility::waittill_any_timeout_1(var_0D, "skip_song");
    } else {
      level waittill("game_ended");
      var_8 stoploopsound();
      var_8 delete();
      return;
    }

    var_8 stoploopsound();
    var_8 delete();
  } else {
    wait(2);
  }

  scripts\cp\maps\cp_final\cp_final::disablepas();
  scripts\cp\maps\cp_final\cp_final::enablepa("pa_facility");
  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start(var_0, 1);
}

generic_interaction_no_gesture(var_0, var_1) {
  var_0 endon("disconnect");
  if(isent(var_1) || !isvector(var_1)) {
    var_1 = var_1.origin;
  }

  playFX(level._effect["generic_pickup"], var_1);
  var_0 playlocalsound("part_pickup");
}

trigger_goon_event(var_0) {
  foreach(var_2 in level.players) {
    if(distancesquared(var_2.origin, var_0) > 6000) {
      continue;
    }

    thread trigger_goon_event_single(var_0);
  }
}

trigger_goon_event_single(var_0, var_1) {
  level endon("game_ended");
  if(!isDefined(var_1)) {
    var_1 = 3;
  }

  var_2 = 0;
  while(var_2 < var_1) {
    var_3 = scripts\cp\zombies\cp_final_spawning::get_scored_goon_spawn_location();
    var_4 = var_3 scripts\cp\zombies\cp_final_spawning::spawn_brute_wave_enemy("alien_goon");
    if(isDefined(var_4)) {
      var_2++;
    }

    wait(0.3);
  }
}

pickupbridgepiece(var_0, var_1) {
  var_0 scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_2 = getEntArray("pap_bridge_model", "targetname");
  var_3 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2, undefined, 2);
  scripts\cp\maps\cp_final\cp_final_interactions::generic_pickup_gesture_and_fx(var_1, var_3[0].origin);
  incrementbridgequest(var_3, var_1);
  trigger_goon_event(var_0.origin);
}

incrementbridgequest(var_0, var_1) {
  if(!isDefined(level.bridgepiecesfound)) {
    level.bridgepiecesfound = [];
  }

  if(!isDefined(var_0)) {
    var_2 = "debugPiece";
  } else {
    var_2 = var_1[0].model;
    var_0[0] hide();
    var_0[0] hide();
    var_0[0] hide();
  }

  level.bridgepiecesfound = scripts\engine\utility::array_add_safe(level.bridgepiecesfound, var_2);
  var_3 = level.bridgepiecesfound.size;
  scripts\cp\utility::set_quest_icon(6 + var_3);
  setomnvar("zm_scrap_count", var_3);
  if(isDefined(var_1) && isplayer(var_1)) {
    switch (int(var_3)) {
      case 1:
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_bridge_piece_1", "zmb_comment_vo");
        break;

      case 2:
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_bridge_piece_2", "zmb_comment_vo");
        break;

      case 3:
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_bridge_piece_3", "zmb_comment_vo");
        break;
    }
  }

  if(var_3 >= 3) {
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
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("cp_final_brute_mascot_mask");
  var_0.script_parameters = "heavy_helmet";
  var_0 hide();
  level.helmet_on_brute = var_0;
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

constructbridgehint(var_0, var_1) {
  if(!isDefined(level.bridgepiecesfound)) {
    level.bridgepiecesfound = [];
  }

  if(level.bridgepiecesfound.size >= 3) {
    return &"CP_FINAL_INTERACTIONS_FINISH_BRIDGE";
  }

  if(level.bridgepiecesfound.size > level.bridgepiecesplaced) {
    return &"CP_FINAL_INTERACTIONS_ADD_BRIDGE_PIECE";
  }

  var_1 thread scripts\cp\cp_vo::try_to_play_vo("missing_item_misc", "zmb_comment_vo");
  return &"CP_FINAL_INTERACTIONS_NEED_PIECES";
}

bridgeconstructionfeedback(var_0, var_1) {
  var_2 = scripts\engine\utility::getstruct("construction_point_" + var_0, "targetname");
  playFX(level._effect["bridge_place"], var_2.origin, anglesToForward(var_2.angles));
  wait(1.2);
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("debris_exterior_damaged_metal_panels_08_scl50");
  var_3.angles = var_2.angles;
  var_4 = (60, 60, 0);
  var_5 = getent("bridge_blocker", "targetname");
  var_5.origin = var_5.origin + var_4;
  var_1.origin = var_1.origin + var_4 + (8, 4, 0);
  playsoundatpos(var_1.origin, "zmb_bridge_build_01");
  var_5 connectpaths();
  level.bridgepiecesplaced++;
}

constructbridgeuse(var_0, var_1) {
  var_1 endon("disconnect");
  var_2 = level.bridgepiecesfound.size - level.bridgepiecesplaced;
  if(var_2 > 0) {
    scripts\cp\maps\cp_final\cp_final_interactions::generic_place_gesture_and_fx(var_1, var_0.origin + (30, 45, 0));
    for(var_3 = level.bridgepiecesplaced; var_3 < level.bridgepiecesplaced + var_2; var_3++) {
      thread bridgeconstructionfeedback(var_3 + 1, var_0);
    }

    wait(1.205);
    if(scripts\engine\utility::flag("bridge_pieces_collected")) {
      openbridge();
      built_bridge_feedback(var_1);
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_bridge_build", "zmb_comment_vo");
      wait(lookupsoundlength(var_1.vo_prefix + "quest_pap_bridge_build"));
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("pap_quest_success", "zmb_comment_vo");
    }
  }
}

openbridge() {
  var_0 = getent("bridge_blocker", "targetname");
  var_0 notsolid();
  var_0 connectpaths();
  scripts\engine\utility::flag_set("bridge_constructed");
  level thread bridgeconstructedvo();
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name("pap_island");
  scripts\cp\zombies\zombies_spawning::update_volume_adjacency_by_name("pap_island", "planet_outside");
  scripts\cp\zombies\zombies_spawning::update_volume_adjacency_by_name("planet_outside", "pap_island");
}

bridgeconstructedvo() {
  var_0 = scripts\engine\utility::random(level.players);
  if(isDefined(var_0.vo_prefix)) {
    switch (var_0.vo_prefix) {
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
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("zm_special_item", 5);
  }
}

built_bridge_feedback(var_0) {
  if(isDefined(var_0) && isplayer(var_0)) {
    var_1 = ["fistpump", "fingercrossed", "kissfist"];
    var_2 = scripts\engine\utility::random(var_1);
    var_3 = "iw7_" + var_2 + "_zm";
    var_0 thread scripts\cp\utility::usegrenadegesture(var_0, var_3);
  }
}

spawnenergydoor() {
  var_0 = [(16, 5583, 115), (144, 6168, 115)];
  var_1 = [(0, 0, 0), (0, 90, 0)];
  level.all_quest_doors = [];
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = scripts\engine\utility::drop_to_ground(var_0[var_2], 12, -400);
    var_4 = spawn("script_model", var_3);
    var_4.angles = var_1[var_2];
    var_4 setModel("door_sized_collision");
    var_4 setscriptablepartstate("door_effect", "active");
    level.all_quest_doors[level.all_quest_doors.size] = var_4;
    thread watchfordamageondoor(var_4);
  }
}

watchfordamageondoor(var_0) {
  level endon("game_ended");
  level endon("kill_energy_doors");
  var_1 = getent("med_bay_door_clip", "targetname");
  var_1.health = 9999999;
  var_1.maxhealth = 9999999;
  var_1 setCanDamage(1);
  var_1.next_block_fx_time = 0;
  for(;;) {
    var_1 waittill("damage", var_2, var_3, var_4, var_5, var_2, var_2, var_2, var_2, var_2, var_6);
    var_7 = gettime();
    if(isDefined(var_1.next_block_fx_time) && isDefined(var_5) && isDefined(var_4) && var_7 >= var_1.next_block_fx_time) {
      var_1.next_block_fx_time = var_7 + 250;
      playFX(level._effect["energy_door_impact"], var_5 + var_4 * -5, var_4 * -150);
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

watchfornearbyzombies(var_0) {
  var_0 notify("watchForNearbyZombies");
  var_0 endon("watchForNearbyZombies");
  level endon("game_ended");
  level endon("deactivateNeil");
  level endon("neilIsEvil");
  level endon("inFinalPosition");
  level endon("neil_doing_something_evil");
  for(;;) {
    var_1 = sortbydistance(scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"), var_0.origin);
    if(var_1.size > 0 && distance(var_1[0].origin, var_0.origin) <= 72) {
      if(scripts\engine\utility::istrue(var_0.var_4284)) {
        thread[[level.interactions[var_0.script_noteworthy].activation_func]](var_0, undefined);
        break;
      }
    }

    wait(0.25);
  }
}

pausenormalwavespawning(var_0) {
  scripts\engine\utility::flag_set("pause_wave_progression");
  if(scripts\engine\utility::istrue(var_0)) {
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
  var_0 = spawnStruct();
  var_0.cop_spawn_percent = level.cop_spawn_percent;
  var_0.current_enemy_deaths = level.current_enemy_deaths;
  var_0.max_static_spawned_enemies = level.max_static_spawned_enemies;
  var_0.desired_enemy_deaths_this_wave = level.desired_enemy_deaths_this_wave;
  var_0.wave_num = level.wave_num;
  level.storedspawncounters = var_0;
}

restorewavespawningcounters() {
  if(isDefined(level.storedspawncounters)) {
    var_0 = level.storedspawncounters;
    if(level.wave_num == var_0.wave_num) {
      level.current_enemy_deaths = var_0.current_enemy_deaths;
      level.max_static_spawned_enemies = var_0.max_static_spawned_enemies;
      level.desired_enemy_deaths_this_wave = var_0.desired_enemy_deaths_this_wave;
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
  var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_2 in var_0) {
    var_2.died_poorly = 1;
    var_2.nocorpse = 1;
    var_2 suicide();
  }
}

get_max_static_enemies(var_0) {
  if(scripts\cp\utility::is_escape_gametype() && var_0 < 5) {
    var_1 = level.players.size * 6;
    var_2 = [0, 0.25, 0.3, 0.5, 0.7, 0.9];
    var_3 = 1;
    var_4 = 1;
    var_3 = var_2[var_0];
    var_5 = level.players.size - 1;
    if(var_5 < 1) {
      var_5 = 0.5;
    }

    var_6 = 24 + var_5 * 6 * var_4 * var_3;
    return int(min(var_1, var_6));
  }

  return 24;
}

get_total_spawned_enemies(var_0) {
  if(scripts\cp\utility::is_escape_gametype()) {
    return 9000;
  }

  var_1 = [0, 0.25, 0.3, 0.5, 0.7, 0.9];
  var_2 = 1;
  var_3 = 1;
  if(var_0 < 6) {
    var_2 = var_1[var_0];
  } else if(var_0 < 10) {
    var_3 = var_0 / 5;
  } else {
    var_3 = squared(var_0) * 0.03;
  }

  var_4 = level.players.size - 1;
  if(var_4 < 1) {
    var_4 = 0.5;
  }

  var_5 = 24 + var_4 * 6 * var_3 * var_2;
  return int(var_5);
}

setwavenumoverride(var_0) {
  level.wave_num_override = var_0;
}

unsetwavenumoverride(var_0) {
  level.wave_num_override = undefined;
}

setspawndelayoverride(var_0) {
  level.spawndelayoverride = var_0;
}

unsetspawndelayoverride(var_0) {
  level.spawndelayoverride = undefined;
}

unsetzombiemovespeed() {
  level notify("unsetZombieMoveSpeed");
}

setzombiemovespeed(var_0) {
  level endon("game_ended");
  level notify("unsetZombieMoveSpeed");
  level endon("unsetZombieMoveSpeed");
  foreach(var_2 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    if(isDefined(var_2.agent_type) && var_2.agent_type != "ratking") {
      var_3 = scripts\engine\utility::random(var_0);
      var_2 thread adjustmovespeed(var_2, 0, var_3);
    }
  }

  for(;;) {
    level waittill("agent_spawned", var_5);
    var_3 = scripts\engine\utility::random(var_0);
    var_5 thread adjustmovespeed(var_5, 1, var_3);
  }
}

adjustmovespeed(var_0, var_1, var_2) {
  var_0 endon("death");
  if(isDefined(var_0.agent_type) && var_0.agent_type == "ratking") {
    return;
  }

  if(scripts\engine\utility::istrue(var_0.is_suicide_bomber)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1)) {
    wait(0.5);
  }

  var_0 scripts\asm\asm_bb::bb_requestmovetype(var_2);
}

neiltriggertrap() {
  var_0 = scripts\engine\utility::getstructarray("laser_trap", "script_noteworthy");
  var_1 = scripts\engine\utility::getstructarray("electric_trap", "script_noteworthy");
  var_2 = scripts\engine\utility::getstructarray("acid_rain_trap", "script_noteworthy");
  level thread scripts\cp\maps\cp_final\cp_final_traps::use_lasers_trap(var_0[0], undefined);
  level thread scripts\cp\maps\cp_final\cp_final_traps::electric_trap_use(var_1[0], undefined);
  level thread scripts\cp\maps\cp_final\cp_final_traps::use_rain_trap(var_2[0], undefined);
}

neildoevilstuff() {
  level notify("neilIsEvil");
  level endon("neilIsEvil");
  level endon("game_ended");
  level endon("deactivateNeil");
  level endon("inFinalPosition");
  var_0 = ["laser_trap", "electric_trap", "acid_rain_trap"];
  var_1 = scripts\engine\utility::getstructarray("laser_trap", "script_noteworthy");
  var_2 = scripts\engine\utility::getstructarray("electric_trap", "script_noteworthy");
  var_3 = scripts\engine\utility::getstructarray("acid_rain_trap", "script_noteworthy");
  var_4 = scripts\engine\utility::array_combine(var_1, var_2, var_3);
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
      var_5 = 2000;
      var_6 = undefined;
      foreach(var_8 in level.players) {
        var_9 = scripts\engine\utility::getclosest(var_8.origin, var_4, 1000);
        if(isDefined(var_9) && distance(var_8.origin, var_9.origin) < var_5) {
          if(scripts\engine\utility::array_contains(level.current_interaction_structs, var_9)) {
            var_6 = var_9;
          }
        }
      }

      if(isDefined(var_6)) {
        resetslidingdoorstonormalstate();
        playneilvo("final_n31l_evil_manipulate_cost");
        switch (var_6.script_noteworthy) {
          case "laser_trap":
            level thread scripts\cp\maps\cp_final\cp_final_traps::use_lasers_trap(var_1[0], undefined);
            break;

          case "electric_trap":
            level thread scripts\cp\maps\cp_final\cp_final_traps::electric_trap_use(var_2[0], undefined);
            break;

          case "acid_rain_trap":
            level thread scripts\cp\maps\cp_final\cp_final_traps::use_rain_trap(var_3[0], undefined);
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
    var_0 = scripts\engine\utility::random(level.players);
    if(isDefined(var_0.vo_prefix)) {
      switch (var_0.vo_prefix) {
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
  var_0 = randomintrange(45, 60);
  level scripts\engine\utility::waittill_any_timeout_1(var_0 - 5, "makeNeilEvil");
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
  foreach(var_1 in level.allslidingdoors) {
    if(scripts\engine\utility::istrue(var_1.player_opened) && scripts\engine\utility::istrue(var_1.var_4284)) {
      thread[[level.interactions[var_1.script_noteworthy].activation_func]](var_1, undefined);
    }
  }
}

closealldoors(var_0) {
  foreach(var_2 in level.allslidingdoors) {
    if(scripts\engine\utility::istrue(var_2.player_opened) && scripts\engine\utility::istrue(var_2.opened)) {
      if(scripts\engine\utility::istrue(var_0)) {
        thread watchfornearbyzombies(var_2);
      }

      thread scripts\cp\maps\cp_final\cp_final_interactions::closeslidingdoor(var_2, undefined);
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

questdevguientries(var_0, var_1, var_2, var_3) {}