/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\coop_personal_ents.gsc
***********************************************/

function assignpersonalmodelents(var0) {
  if(getdvarint("scr_use_personal_ents", 1)) {
    if(!isDefined(var0.personalents) || var0.personalents.size < 1) {
      var0.personalents = [];
      var0 scripts\engine\utility::ent_flag_init("personal_ents_updating");

      for(var1 = 0; var1 < 20; var1++) {
        var2 = spawn("script_model", (0, 0, -5000));
        var2.ogorigin = (0, 0, -5000);
        var2 setModel("tag_origin");
        var2.claimed = 0;
        var2.used = 0;
        adjustmodelvis(var0, var2);
        var0.personalents[var0.personalents.size] = var2;
      }
    }

    local_waittill_any_return_6(var0);
    thread deletepentsondisconnect(level);
    thread deletepentsonrespawn(level);
    return;
  }
}

function deletepentsonrespawn(var0) {
  var0 notify("deletePEntsOnRespawn");
  var0 endon("deletePEntsOnRespawn");
  var0 endon("disconnect");
  level endon("game_ended");
  var0 waittill("respawn_player", var1);

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var0.personalents)) {
    return;
  }

  for(var2 = 0; var2 < var0.personalents.size; var2++) {
    if(isDefined(var0.personalents[var2])) {
      var0.personalents[var2] delete();
    }
  }

  var0.personalents = [];
}

function deletepentsondisconnect(var0) {
  level endon("game_ended");
  var0 notify("deletePEntsOnDisconnect");
  var0 endon("deletePEntsOnDisconnect");
  var0 waittill("disconnect");

  if(!isDefined(var0.personalents)) {
    return;
  }

  for(var1 = 0; var1 < var0.personalents.size; var1++) {
    if(isDefined(var0.personalents[var1])) {
      var0.personalents[var1] delete();
    }
  }
}

function registerpentparams(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  var11 = spawnStruct();
  var11.type = var1;
  var11.icon = var2;
  var11.hintstring = var3;
  var11.priority = var4;
  var11.duration = var5;
  var11.onobstruction = var6;
  var11.hintdist = var7;
  var11.hintfov = var8;
  var11.usedist = var9;
  var11.usefov = var10;
  var11.hint_func = level.interactions[var0].hint_func;
  var11.activation_func = level.interactions[var0].activation_func;
  level.pentparams[var0] = var11;
  level.interactions[var0].hint_func = undefined;
  level.interactions[var0].activation_func = undefined;
}

function pentparamsdefined(var0) {
  return isDefined(level.pentparams[var0]);
}

function getpentparams(var0) {
  return level.pentparams[var0];
}

function createpenthintobj(var0, var1, var2) {
  var3 = scripts\cp\utility::createhintobject(var1.origin, var0.type, var0.icon, var0.hintstring, var0.priority, var0.duration, var0.onobstruction, var0.hintdist, var0.hintfov, var0.usedist, var0.usefov);
  return var3;
}

function addtopersonalinteractionlist(var0) {
  var0 notify("addToPersonalInteractionList");

  if(!scripts\engine\utility::array_contains(level.current_personal_interaction_structs, var0)) {
    level.current_personal_interaction_structs = scripts\engine\utility::array_add(level.current_personal_interaction_structs, var0);

    if(scripts\engine\utility::flag_exist("personal_ent_zones_initialized") && scripts\engine\utility::flag("personal_ent_zones_initialized")) {
      if(isDefined(level.personal_ent_zones) && level.personal_ent_zones.size > 0) {
        foreach(var2 in level.personal_ent_zones) {
          if(!isDefined(var2.attached_pents)) {
            continue;
          }

          if(!isDefined(var0.p_ent_zones)) {
            continue;
          }

          if(ispointinvolume(var0.origin, var2)) {
            var2.attached_pents[var2.attached_pents.size] = var0;
            var0.p_ent_zones[var0.p_ent_zones.size] = var2;
            var2.attached_pents = scripts\engine\utility::array_remove_duplicates(var2.attached_pents);
          }
        }
      }
    }
  }

  update_special_mode_for_all_players(1);
}

function removefrompersonalinteractionlist(var0) {
  var0 notify("removeFromPersonalInteractionList");

  if(scripts\engine\utility::array_contains(level.current_personal_interaction_structs, var0)) {
    level.current_personal_interaction_structs = scripts\engine\utility::array_remove(level.current_personal_interaction_structs, var0);

    if(scripts\engine\utility::flag_exist("personal_ent_zones_initialized") && scripts\engine\utility::flag("personal_ent_zones_initialized")) {
      if(isDefined(var0.p_ent_zones)) {
        foreach(var2 in var0.p_ent_zones) {
          var2.attached_pents = scripts\engine\utility::array_remove(var2.attached_pents, var0);
          var2.attached_pents = scripts\engine\utility::array_remove_duplicates(var2.attached_pents);
        }
      }
    }
  }

  update_special_mode_for_all_players(1);
}

function delayed_remove_peent_interaction(var0) {
  wait 0.25;
  removefrompersonalinteractionlist(var0);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var0);
}

function movepentstostructs(var0) {
  var0 endon("disconnect");
  var0 notify("movePEntsToStructs");
  var0 endon("movePEntsToStructs");
  jumpiftrue(scripts\engine\utility::flag("init_interaction_done")) LOC_00000031;
  scripts\engine\utility::flag_wait("init_interaction_done");

  for(;;) {
    if(var0 scripts\engine\utility::ent_flag_exist("personal_ents_updating")) {
      var0 scripts\engine\utility::ent_flag_set("personal_ents_updating");
    }

    var6 = 0;
    var7 = 0;

    if(isDefined(var0.all_available_pents)) {
      var8 = var0.all_available_pents;
    } else {
      var8 = scripts\engine\utility::get_array_of_closest(var0.origin, level.current_personal_interaction_structs, undefined, 100);
    }

    if(var8.size > 0) {
      var8 = removeinvalidstructs(var8, var0);
      resetents(var0, var0, var8);

      foreach(var10 in var8) {
        var11 = undefined;

        if(isDefined(var10.target)) {
          var11 = scripts\engine\utility::getStruct(var10.target, "targetname");
        }

        if(hasplayerentattached(var10, var0, var10)) {
          var12 = getattachedpersonalent(var0, var10);

          if(isDefined(var12)) {
            if(isDefined(var10.pentmodel) && var10.pentmodel != var12.model) {
              var12 setModel(var10.pentmodel);
            }

            if(istrue(var0.force_p_ent_reset)) {
              if(struct_has_advanced_settings(var10)) {
                thread pentadvancedoptions(var12, 0, var10, var12, var0);
              }
            }
          }

          continue;
        }

        var12 = getunclaimedpersonalent(var0, var8);

        if(isDefined(var12)) {
          var10.awaitingpent = 1;
          var12 dontinterpolate();

          if(isDefined(var11)) {
            var12.origin = var11.origin;

            if(isDefined(var11.angles)) {
              var12.angles = var11.angles;
            } else {
              var12.angles = (0, 0, 0);
            }
          } else {
            var12.origin = var10.origin;

            if(isDefined(var10.angles)) {
              var12.angles = var10.angles;
            } else {
              var12.angles = (0, 0, 0);
            }
          }

          if(isDefined(var10.pentmodel)) {
            thread pentdelaysetModel(var0, var12, var10);
          }

          if(struct_has_advanced_settings(var10)) {
            thread pentadvancedoptions(var12, 0, var10, var12, var0);
            LOC_0000022e:
          }
          LOC_0000022e:
        }
        LOC_0000022e:
      }
    }

    var0.force_p_ent_reset = undefined;
    wait 0.25;

    if(var0 scripts\engine\utility::ent_flag_exist("personal_ents_updating")) {
      var0 scripts\engine\utility::ent_flag_clear("personal_ents_updating");
    }

    var0 notify("pEntsUpdated");
    var0 scripts\engine\utility::waittill_any_in_array_return_no_endon_death(["zone_change", "updatePEnts"]);
  }
}

function player_can_see_p_ent(var0, var1) {
  if(istrue(var0.p_ent_skip_fov)) {
    return 0;
  }

  if(isDefined(level.pentskipfov) && istrue(level.pentskipfov[var0.script_noteworthy])) {
    return 0;
  }

  var2 = scripts\engine\utility::within_fov(var1 getEye(), var1 getplayerangles(), var0.origin, cos(65));

  if(var2) {
    var3 = scripts\engine\trace::ray_trace_passed(var1 getEye(), var0.origin, scripts\engine\utility::array_combine(level.players, var1.personalents));

    if(var3) {
      return 1;
    }

    return 0;
  }

  return 0;
}

function struct_has_advanced_settings(var0) {
  if(isDefined(var0.script_noteworthy)) {
    var1 = var0.script_noteworthy;
  } else {
    return 0;
  }

  if(istrue(var0.pentadvanced)) {
    return 1;
  }

  if(isDefined(level.normal_mode_activation_funcs[var1])) {
    return 1;
  }

  if(isDefined(level.special_mode_activation_funcs[var1])) {
    return 1;
  }

  if(pentparamsdefined(var0.script_noteworthy)) {
    return 1;
  }

  return 0;
}

function pentdelaysetModel(var0, var1, var2) {
  level endon("game_ended");
  var0 endon("disconnect");
  var1 endon("p_ent_reset");
  var1.claimed = 1;
  var1.parentstruct = var2;

  if(!isDefined(var2.linkedpents)) {
    var2.linkedpents = [];
  }

  var2.linkedpents[var2.linkedpents.size] = var1;
  var1.used = 1;

  if(player_can_see_p_ent(var2, var0)) {
    resetpersonalent(var1, var1, var0);
    return;
  }

  wait 0.1;
  var1 setModel(var2.pentmodel);

  if(isDefined(var2.expectedstate)) {
    var1 setscriptablepartstate(var2.expectedstate[0], var2.expectedstate[1], 1);
  }

  var2.awaitingpent = undefined;
}

function update_special_mode_for_player(var0, var1) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 notify("update_special_mode_for_player");
  var0 endon("update_special_mode_for_player");

  if(istrue(var1)) {}

  if(var0 scripts\engine\utility::ent_flag_exist("personal_ents_updating") && var0 scripts\engine\utility::ent_flag("personal_ents_updating")) {
    var0 scripts\engine\utility::ent_flag_waitopen("personal_ents_updating");
  }

  var0 notify("updatePEnts");
}

function update_special_mode_for_all_players(var0) {
  level endon("game_ended");

  foreach(var2 in level.players) {
    thread update_special_mode_for_player(var2, var0);
  }
}

function resetents(var0, var1) {
  var2 = [];
  var3 = undefined;
  var4 = undefined;

  foreach(var6 in var0.personalents) {
    if(!isent(var6)) {
      continue;
    }

    var7 = 0;

    foreach(var4 in var1) {
      if(isDefined(var4.playeroffset) && isDefined(var4.playeroffset[var0.name])) {
        if(var6.origin == var4.playeroffset[var0.name]) {
          var3 = var4.script_noteworthy;
          var7 = 1;
          break;
        }
      }

      if(isDefined(var4.target)) {
        var9 = scripts\engine\utility::getStruct(var4.target, "targetname");

        if(isDefined(var9) && var6.origin == var9.origin) {
          var3 = var4.script_noteworthy;
          var7 = 1;
          break;
        } else if(var5.origin == var3.origin) {
          var2 = var3.script_noteworthy;
          var6 = 1;
          break;
        }

        continue;
      }

      if(var4.origin == var2.origin) {
        var1 = var2.script_noteworthy;
        var5 = 1;
        break;
      }
    }

    var6 = undefined;
    var7 = undefined;

    if(!var5) {
      if(isDefined(var2) && player_can_see_p_ent(var2, < error > )) {
        continue;
      }

      resetpersonalent(var4, var4, < error > );
    }
  }

  var3 = undefined;
  var8 = undefined;
  wait 0.1;
}

function removeinvalidstructs(var0, var1) {
  var2 = [];
  var0 = sortbydistance(var0, var1.origin);

  foreach(var4 in var0) {
      if(isDefined(var1.disabled_interactions) && scripts\engine\utility::array_contains(var1.disabled_interactions, var4)) {
        continue;
      }

      if(isDefined(var4.in_array)) {
        if(!istrue(var4.in_array)) {
          continue;
        }
      } else if(isDefined(level.current_interaction_structs) && !scripts\engine\utility::array_contains(level.current_interaction_structs, var4)) {
        continue;
      }

      if(isDefined(var4.target)) {
        var5 = scripts\engine\utility::getStructArray(var4.targetname, "targetname");

        foreach(var7 in var5) {
          if(isDefined(var7.target) && var7.target == var4.target) {
            var0 = scripts\engine\utility::array_remove(var0, var7);
          }
        }

        var2 = var4;

        if(var2.size >= 20) {
          break;
        }

        continue;
      }

      <
      error > = var0;

      if( < error > .size >= 20) {
        break;
      }
    }

    <
    error > = undefined;
  var1 = undefined;
  return < error > ;
}

function hasplayerentattached(var0, var1) {
  foreach(var3 in var0.personalents) {
    if(isDefined(var1.playeroffset) && isDefined(var1.playeroffset[var0.name])) {
      if(var3.origin == var1.playeroffset[var0.name]) {
        var3.used = 1;
        return true;
      }
    }

    if(isDefined(var1.target)) {
      var4 = scripts\engine\utility::getStruct(var1.target, "targetname");

      if(isDefined(var4) && var3.origin == var4.origin) {
        var3.used = 1;
        return true;
      }
    }

    if(var3.origin == var1.origin) {
      var3.used = 1;
      return true;
    }
  }

  return false;
}

function adjustmodelvis(var0, var1) {
  foreach(var3 in level.players) {
    if(var3 == var0) {
      var1 showtoplayer(var3);
      continue;
    }

    var1 hidefromplayer(var3);
  }
}

function resetpersonalent(var0, var1) {
  var0 setModel("tag_origin");
  var0.claimed = 0;
  var0.used = 0;
  var0 dontinterpolate();
  var0.origin = var0.ogorigin;

  if(isDefined(var0.parentstruct)) {
    if(isDefined(var0.parentstruct.linkedpents)) {
      if(scripts\engine\utility::array_contains(var0.parentstruct.linkedpents, var0)) {
        var0.parentstruct.linkedpents = scripts\engine\utility::array_remove(var0.parentstruct.linkedpents, var0);
      }
    }

    var0.parentstruct notify("p_ents_updated");
    var0.parentstruct = undefined;
  }

  var0 notify("p_ent_reset");
}

function getattachedpersonalent(var0, var1) {
  var2 = [];

  foreach(var4 in var0.personalents) {
    if(isDefined(var1.playeroffset) && isDefined(var1.playeroffset[var0.name])) {
      if(var4.origin == var1.playeroffset[var0.name]) {
        return var4;
      }
    }

    if(isDefined(var1.target)) {
      var5 = scripts\engine\utility::getStruct(var1.target, "targetname");

      if(isDefined(var5) && var4.origin == var5.origin) {
        return var4;
      }
    }

    if(var4.origin == var1.origin) {
      return var4;
    }
  }

  return undefined;
}

function getunclaimedpersonalent(var0, var1) {
  var2 = [];

  foreach(var4 in var0.personalents) {
    var5 = 0;

    foreach(var7 in var1) {
      if(isDefined(var7.playeroffset) && isDefined(var7.playeroffset[var0.name])) {
        if(var4.origin == var7.playeroffset[var0.name]) {
          var5 = 1;
          break;
        }
      }

      if(isDefined(var7.target)) {
        var8 = scripts\engine\utility::getStruct(var7.target, "targetname");

        if(isDefined(var8) && var4.origin == var8.origin) {
          var5 = 1;
          break;
        }
      }

      if(var3.origin == var6.origin) {
        var4 = 1;
        break;
      }
    }

    var5 = undefined;
    var7 = undefined;

    if(!var4) {
      return var3;
    }
  }

  var2 = undefined;
  var9 = undefined;
  return undefined;
}

function watchforplayerzonechange(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  scripts\engine\utility::flag_wait("init_interaction_done");
  var1 = getEnt("zone_change", "targetname");

  if(isDefined(var1)) {
    for(;;) {
      if(var0 istouching(var1)) {
        var0 notify("rave_status_changed");
        wait 1;
        continue;
      }

      wait 0.1;
    }

    return;
  }
}

function pentadvancedoptions(var0, var1, var2, var3, var4) {
  var5 = scripts\engine\utility::ter_op(isDefined(var1.name), var1.name, var1.script_noteworthy);

  if(isDefined(level.normal_mode_activation_funcs[var5])) {
    if(isDefined(var4)) {
      var2[[level.normal_mode_activation_funcs[var5]]](var2, var4, 0, var3);
    } else {
      var2 thread[[level.normal_mode_activation_funcs[var5]]](var2, var1, 0, var3);
    }
  }

  if(pentparamsdefined(var1.script_noteworthy)) {
    var6 = createpenthintobj(getpentparams(var1.script_noteworthy), var1, undefined);
    var2.hintobj = var6;

    foreach(var8 in level.players) {
      if(var8 == var3) {
        var6 enableplayeruse(var3);
        continue;
      }

      var6 disableplayeruse(var8);
    }

    thread watch_for_player_trigger(var2, var1, var3, var6);
    thread reset_struct_when_pent_moves(var2, var1, var3, var6);
    thread watch_for_hintstring_updates(var2, var1, var3, var6);
    return;
  }
}

function reset_struct_when_pent_moves(var0, var1, var2, var3) {
  var0 notify("reset_struct_when_pent_moves");
  var0 endon("reset_struct_when_pent_moves");
  var1 notify("reset_struct_when_pent_moves_" + var2.name);
  var1 endon("reset_struct_when_pent_moves_" + var2.name);
  level endon("game_ended");
  scripts\engine\utility::waittill_any_ents(var0, "p_ent_reset", var1, "remove_from_current_interaction_list", var2, "remove_from_current_interaction_list_for_player_" + var2.name);

  if(isDefined(var3) && var3 != var0) {
    var3 delete();
  } else if(isDefined(var3)) {
    var3 scripts\cp\utility::clearhintobject(var3);
  }

  if(isDefined(var0.hintobj)) {
    var0.hintobj = undefined;
  }

  if(isDefined(var0.collision)) {
    var0.collision delete();
  }

  if(isDefined(var1.collision)) {
    var1.collision delete();
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var1, var2);
  update_special_mode_for_all_players(1);
}

function local_waittill_any_return_6(var0) {
  foreach(var2 in level.players) {
    if(var2 == var0) {
      continue;
    }

    if(isDefined(var2.personalents)) {
      for(var3 = 0; var3 < var2.personalents.size; var3++) {
        if(isDefined(var2.personalents[var3])) {
          var2.personalents[var3] disableplayeruse(var0);

          if(isDefined(var2.personalents[var3].hintobj)) {
            var2.personalents[var3].hintobj disableplayeruse(var0);
          }
        }
      }
    }
  }
}

function watch_for_player_trigger(var0, var1, var2, var3) {
  var1 notify("watch_for_player_trigger_" + var2.name);
  var1 endon("watch_for_player_trigger_" + var2.name);
  var0 notify("watch_for_player_trigger");
  var0 endon("watch_for_player_trigger");
  var0 endon("p_ent_reset");
  var4 = getpentinteractionusefunc(var1);
  var0.hintobj = var3;

  if(isDefined(var4)) {
    for(;;) {
      var3 makeusable();

      foreach(var6 in level.players) {
        if(var6 == var2) {
          var3 enableplayeruse(var2);
          continue;
        }

        var3 disableplayeruse(var6);
      }

      var3 waittill("trigger", var8);

      if(isPlayer(var8)) {
        level thread[[var4]](var1, var2);
      }
    }

    return;
  }
}

function getpentinteractionusefunc(var0) {
  if(isDefined(level.pentparams[var0.script_noteworthy].activation_func)) {
    return level.pentparams[var0.script_noteworthy].activation_func;
  }

  if(isDefined(level.interactions[var0.script_noteworthy].activation_func)) {
    return level.interactions[var0.script_noteworthy].activation_func;
  }

  return undefined;
}

function update_pent_hintstring(var0, var1) {
  var0.hintstring = var1;
  var0 notify("pent_update_hint", var1);
}

function watch_for_hintstring_updates(var0, var1, var2, var3) {
  var1 endon("watch_for_player_trigger_" + var2.name);
  var0 endon("watch_for_player_trigger");
  var0 endon("p_ent_reset");

  for(;;) {
    var1 waittill("pent_update_hint", var4);

    if(!hasplayerentattached(var2, var1)) {
      return;
    }

    var3 setHintString(var4);
  }
}

function player_run_pent_updates(var0) {
  if(isDefined(level.personal_ent_zones)) {
    thread update_pents_from_volumes(var0);
    return;
  }

  thread update_pents_global(var0);
}

function update_pents_from_volumes(var0) {
  level endon("game_ended");
  var0 notify("update_pents_from_volumes");
  var0 endon("update_pents_from_volumes");
  var0 endon("disconnect");

  if(!scripts\engine\utility::flag_exist("personal_ent_zones_initialized")) {
    return;
  }

  scripts\engine\utility::flag_wait("personal_ent_zones_initialized");

  for(;;) {
    var0.all_available_pents = [];

    foreach(var2 in level.personal_ent_zones) {
      if(ispointinvolume(var0.origin, var2)) {
        var0.all_available_pents = scripts\engine\utility::array_combine(var0.all_available_pents, var2.attached_pents);
      }
    }

    wait 1;
    update_special_mode_for_player(var0);
  }
}

function update_pents_global(var0) {
  level endon("game_ended");
  var0 notify("update_pents_from_volumes");
  var0 endon("update_pents_from_volumes");
  var0 endon("disconnect");

  if(!scripts\engine\utility::flag_exist("personal_ent_zones_initialized")) {
    return;
  } else {
    scripts\engine\utility::flag_wait("personal_ent_zones_initialized");
  }

  for(;;) {
    wait 1;
    update_special_mode_for_player(var0);
  }
}

function init_personal_ent_zones() {
  var0 = level.current_personal_interaction_structs;
  var1 = getEntArray("p_ent_zone", "targetname");

  foreach(var3 in var1) {
    var3.attached_pents = [];

    foreach(var5 in var0) {
      if(!isDefined(var5.p_ent_zones)) {
        var5.p_ent_zones = [];
      }

      if(ispointinvolume(var5.origin, var3)) {
        var3.attached_pents[var3.attached_pents.size] = var5;
        var5.p_ent_zones[var5.p_ent_zones.size] = var3;
      }
    }
  }

  if(var1.size > 0) {
    level.personal_ent_zones = var1;
  }

  scripts\engine\utility::flag_set("personal_ent_zones_initialized");
}