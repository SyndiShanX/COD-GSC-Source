/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\coop_personal_ents.gsc
***********************************************/

assignpersonalmodelents(player) {
  if(getdvarint("dvar_0F043116157A9C2A", 0)) {
    if(!isDefined(player.personalents) || player.personalents.size < 1) {
      player.personalents = [];
      player scripts\engine\utility::ent_flag_init("personal_ents_updating");

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 35; _id_AC0E594AC96AA3A8++) {
        ent = spawn("script_model", (0, 0, -5000));
        ent.ogorigin = (0, 0, -5000);
        ent setModel("tag_origin");
        ent.claimed = 0;
        ent.used = 0;
        adjustmodelvis(player, ent);
        player.personalents[player.personalents.size] = ent;
      }
    }

    disableuseotherplayerspents(player);
    level thread deletepentsondisconnect(player);
    level thread deletepentsonrespawn(player);
  }
}

deletepentsonrespawn(player) {
  player notify("deletePEntsOnRespawn");
  player endon("deletePEntsOnRespawn");
  player endon("disconnect");
  level endon("game_ended");
  player waittill("respawn_player", _id_E3108E412AFB3811);

  if(!isDefined(player)) {
    return;
  }
  if(!isDefined(player.personalents)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < player.personalents.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(player.personalents[_id_AC0E594AC96AA3A8]))
      player.personalents[_id_AC0E594AC96AA3A8] delete();
  }

  player.personalents = [];
}

deletepentsondisconnect(player) {
  level endon("game_ended");
  player notify("deletePEntsOnDisconnect");
  player endon("deletePEntsOnDisconnect");
  player waittill("disconnect");

  if(!isDefined(player.personalents)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < player.personalents.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(player.personalents[_id_AC0E594AC96AA3A8]))
      player.personalents[_id_AC0E594AC96AA3A8] delete();
  }
}

registerpentparams(script_noteworthy, type, icon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  struct = spawnStruct();
  struct.type = type;
  struct.icon = icon;
  struct.hintstring = hintstring;
  struct.priority = priority;
  struct.duration = duration;
  struct.onobstruction = onobstruction;
  struct.hintdist = hintdist;
  struct.hintfov = hintfov;
  struct.usedist = usedist;
  struct.usefov = usefov;
  struct.hint_func = level.interactions[script_noteworthy].hint_func;
  struct.activation_func = level.interactions[script_noteworthy].activation_func;
  level.pentparams[script_noteworthy] = struct;
  level.interactions[script_noteworthy].hint_func = undefined;
  level.interactions[script_noteworthy].activation_func = undefined;
}

pentparamsdefined(script_noteworthy) {
  return isDefined(level.pentparams[script_noteworthy]);
}

getpentparams(script_noteworthy) {
  return level.pentparams[script_noteworthy];
}

createpenthintobj(_id_2D385BC9AD36A118, struct, _id_DBCE45A33308630D) {
  ent = scripts\cp\utility::createhintobject(struct.origin, _id_2D385BC9AD36A118.type, _id_2D385BC9AD36A118.icon, _id_2D385BC9AD36A118.hintstring, _id_2D385BC9AD36A118.priority, _id_2D385BC9AD36A118.duration, _id_2D385BC9AD36A118.onobstruction, _id_2D385BC9AD36A118.hintdist, _id_2D385BC9AD36A118.hintfov, _id_2D385BC9AD36A118.usedist, _id_2D385BC9AD36A118.usefov);
  return ent;
}

addtopersonalinteractionlist(_id_DF071553D0996FF9) {
  _id_DF071553D0996FF9 notify("addToPersonalInteractionList");

  if(!scripts\engine\utility::array_contains(level.current_personal_interaction_structs, _id_DF071553D0996FF9)) {
    level.current_personal_interaction_structs = scripts\engine\utility::array_add(level.current_personal_interaction_structs, _id_DF071553D0996FF9);

    if(scripts\engine\utility::flag_exist("personal_ent_zones_initialized") && scripts\engine\utility::flag("personal_ent_zones_initialized")) {
      if(isDefined(level.personal_ent_zones) && level.personal_ent_zones.size > 0) {
        foreach(zone in level.personal_ent_zones) {
          if(!isDefined(zone.attached_pents)) {
            continue;
          }
          if(!isDefined(_id_DF071553D0996FF9.p_ent_zones)) {
            continue;
          }
          if(ispointinvolume(_id_DF071553D0996FF9.origin, zone)) {
            zone.attached_pents[zone.attached_pents.size] = _id_DF071553D0996FF9;
            _id_DF071553D0996FF9.p_ent_zones[_id_DF071553D0996FF9.p_ent_zones.size] = zone;
            zone.attached_pents = scripts\engine\utility::array_remove_duplicates(zone.attached_pents);
          }
        }
      }
    }
  }

  update_special_mode_for_all_players(1);
}

removefrompersonalinteractionlist(_id_DF071553D0996FF9) {
  _id_DF071553D0996FF9 notify("removeFromPersonalInteractionList");

  if(scripts\engine\utility::array_contains(level.current_personal_interaction_structs, _id_DF071553D0996FF9)) {
    level.current_personal_interaction_structs = scripts\engine\utility::array_remove(level.current_personal_interaction_structs, _id_DF071553D0996FF9);

    if(scripts\engine\utility::flag_exist("personal_ent_zones_initialized") && scripts\engine\utility::flag("personal_ent_zones_initialized")) {
      if(isDefined(_id_DF071553D0996FF9.p_ent_zones)) {
        foreach(zone in _id_DF071553D0996FF9.p_ent_zones) {
          zone.attached_pents = scripts\engine\utility::array_remove(zone.attached_pents, _id_DF071553D0996FF9);
          zone.attached_pents = scripts\engine\utility::array_remove_duplicates(zone.attached_pents);
        }
      }
    }
  }

  update_special_mode_for_all_players(1);
}

delayed_remove_peent_interaction(_id_DF071553D0996FF9) {
  wait 0.25;
  removefrompersonalinteractionlist(_id_DF071553D0996FF9);
  _id_71332A5B74214116::remove_from_current_interaction_list(_id_DF071553D0996FF9);
}

movepentstostructs(player) {
  player endon("disconnect");
  player notify("movePEntsToStructs");
  player endon("movePEntsToStructs");

  if(!scripts\engine\utility::flag("init_interaction_done"))
    scripts\engine\utility::flag_wait("init_interaction_done");

  for(;;) {
    if(player scripts\engine\utility::ent_flag_exist("personal_ents_updating"))
      player scripts\engine\utility::ent_flag_set("personal_ents_updating");

    showlines = 0;
    _id_AFDE38A5342A3576 = 0;

    if(isDefined(player.all_available_pents))
      _id_9E4E1482CB40C9C5 = player.all_available_pents;
    else
      _id_9E4E1482CB40C9C5 = scripts\engine\utility::get_array_of_closest(player.origin, level.current_personal_interaction_structs, undefined, 100);

    if(_id_9E4E1482CB40C9C5.size > 0) {
      _id_9E4E1482CB40C9C5 = removeinvalidstructs(_id_9E4E1482CB40C9C5, player);
      player resetents(player, _id_9E4E1482CB40C9C5);

      foreach(struct in _id_9E4E1482CB40C9C5) {
        _id_CED0426E7E729ED5 = undefined;

        if(isDefined(struct.target))
          _id_CED0426E7E729ED5 = scripts\engine\utility::getStruct(struct.target, "targetname");

        if(struct hasplayerentattached(player, struct)) {
          ent = getattachedpersonalent(player, struct);

          if(isDefined(ent)) {
            if(isDefined(struct.pentmodel) && struct.pentmodel != ent.model)
              ent setModel(struct.pentmodel);

            if(istrue(player.force_p_ent_reset)) {
              if(struct_has_advanced_settings(struct))
                ent thread pentadvancedoptions(0, struct, ent, player, _id_CED0426E7E729ED5);
            }
          }

          continue;
        }

        ent = getunclaimedpersonalent(player, _id_9E4E1482CB40C9C5);

        if(isDefined(ent)) {
          if(player_can_see_p_ent(struct, player)) {
            continue;
          }
          struct.awaitingpent = 1;
          ent dontinterpolate();

          if(isDefined(_id_CED0426E7E729ED5)) {
            ent.origin = _id_CED0426E7E729ED5.origin;

            if(isDefined(_id_CED0426E7E729ED5.angles))
              ent.angles = _id_CED0426E7E729ED5.angles;
            else
              ent.angles = (0, 0, 0);
          } else {
            ent.origin = struct.origin;

            if(isDefined(struct.angles))
              ent.angles = struct.angles;
            else
              ent.angles = (0, 0, 0);
          }

          if(isDefined(struct.pentmodel))
            thread pentdelaysetModel(player, ent, struct);
          else {}

          if(struct_has_advanced_settings(struct))
            ent thread pentadvancedoptions(0, struct, ent, player, _id_CED0426E7E729ED5);
        }
      }
    }

    player.force_p_ent_reset = undefined;
    wait 0.25;

    if(player scripts\engine\utility::ent_flag_exist("personal_ents_updating"))
      player scripts\engine\utility::ent_flag_clear("personal_ents_updating");

    player notify("pEntsUpdated");
    player scripts\engine\utility::waittill_any_in_array_return_no_endon_death(["zone_change", "updatePEnts"]);
  }
}

player_can_see_p_ent(struct, player) {
  if(istrue(struct.p_ent_skip_fov))
    return 0;
  else if(isDefined(level.pentskipfov) && istrue(level.pentskipfov[struct.script_noteworthy]))
    return 0;
  else {
    _id_865048328835E385 = scripts\engine\utility::within_fov(player getEye(), player getplayerangles(), struct.origin, cos(65));

    if(_id_865048328835E385) {
      _id_D1F3388DB95FAB09 = scripts\engine\trace::ray_trace_passed(player getEye(), struct.origin, scripts\engine\utility::array_combine(level.players, player.personalents));

      if(_id_D1F3388DB95FAB09) {
        return 1;
        return;
      }

      return 0;
      return;
    } else
      return 0;
  }
}

struct_has_advanced_settings(struct) {
  if(isDefined(struct.script_noteworthy))
    key = struct.script_noteworthy;
  else
    return 0;

  if(istrue(struct.pentadvanced))
    return 1;
  else if(isDefined(level.normal_mode_activation_funcs[key]))
    return 1;
  else if(isDefined(level.special_mode_activation_funcs[key]))
    return 1;
  else if(pentparamsdefined(struct.script_noteworthy))
    return 1;
  else
    return 0;
}

pentdelaysetModel(player, ent, struct) {
  level endon("game_ended");
  player endon("disconnect");
  ent endon("p_ent_reset");
  ent.claimed = 1;
  ent.parentstruct = struct;

  if(!isDefined(struct.linkedpents))
    struct.linkedpents = [];

  struct.linkedpents[struct.linkedpents.size] = ent;
  ent.used = 1;

  if(player_can_see_p_ent(struct, player)) {
    ent resetpersonalent(ent, player);
    return;
  }

  wait 0.1;
  ent setModel(struct.pentmodel);

  if(isDefined(struct.expectedstate))
    ent setscriptablepartstate(struct.expectedstate[0], struct.expectedstate[1], 1);

  struct.awaitingpent = undefined;
}

update_special_mode_for_player(player, _id_A9F319E816EDC0A8) {
  level endon("game_ended");
  player endon("disconnect");
  player notify("update_special_mode_for_player");
  player endon("update_special_mode_for_player");

  if(istrue(_id_A9F319E816EDC0A8)) {}

  if(player scripts\engine\utility::ent_flag_exist("personal_ents_updating") && player scripts\engine\utility::ent_flag("personal_ents_updating"))
    player scripts\engine\utility::ent_flag_waitopen("personal_ents_updating");

  player notify("updatePEnts");
}

update_special_mode_for_all_players(_id_A9F319E816EDC0A8) {
  level endon("game_ended");

  foreach(player in level.players)
  thread update_special_mode_for_player(player, _id_A9F319E816EDC0A8);
}

resetents(player, _id_9E4E1482CB40C9C5) {
  _id_50F783A5617F8940 = [];
  noteworthy = undefined;
  struct = undefined;

  foreach(ent in player.personalents) {
    if(!isent(ent)) {
      continue;
    }
    _id_B076F2949CB48F5B = 0;

    foreach(struct in _id_9E4E1482CB40C9C5) {
      if(isDefined(struct.playeroffset) && isDefined(struct.playeroffset[player.name])) {
        if(ent.origin == struct.playeroffset[player.name]) {
          noteworthy = struct.script_noteworthy;
          _id_B076F2949CB48F5B = 1;
          break;
        }
      }

      if(isDefined(struct.target)) {
        _id_CED0426E7E729ED5 = scripts\engine\utility::getStruct(struct.target, "targetname");

        if(isDefined(_id_CED0426E7E729ED5) && ent.origin == _id_CED0426E7E729ED5.origin) {
          noteworthy = struct.script_noteworthy;
          _id_B076F2949CB48F5B = 1;
          break;
        } else if(ent.origin == struct.origin) {
          noteworthy = struct.script_noteworthy;
          _id_B076F2949CB48F5B = 1;
          break;
        }

        continue;
      }

      if(ent.origin == struct.origin) {
        noteworthy = struct.script_noteworthy;
        _id_B076F2949CB48F5B = 1;
        break;
      }
    }

    if(!_id_B076F2949CB48F5B) {
      if(isDefined(struct) && player_can_see_p_ent(struct, player)) {
        continue;
      }
      ent resetpersonalent(ent, player);
    }
  }

  wait 0.1;
}

removeinvalidstructs(_id_9E4E1482CB40C9C5, player) {
  _id_50F783A5617F8940 = [];
  _id_9E4E1482CB40C9C5 = sortbydistance(_id_9E4E1482CB40C9C5, player.origin);

  foreach(struct in _id_9E4E1482CB40C9C5) {
    if(isDefined(player.disabled_interactions) && scripts\engine\utility::array_contains(player.disabled_interactions, struct)) {
      continue;
    }
    if(isDefined(struct.in_array)) {
      if(!istrue(struct.in_array))
        continue;
    } else if(isDefined(level.current_interaction_structs) && !scripts\engine\utility::array_contains(level.current_interaction_structs, struct)) {
      continue;
    }
    if(isDefined(struct.target)) {
      _id_81CD6D6462BB16B5 = scripts\engine\utility::getStructArray(struct.targetname, "targetname");

      foreach(_id_A7B23DAE3BCFE5F8 in _id_81CD6D6462BB16B5) {
        if(isDefined(_id_A7B23DAE3BCFE5F8.target) && _id_A7B23DAE3BCFE5F8.target == struct.target)
          _id_9E4E1482CB40C9C5 = scripts\engine\utility::array_remove(_id_9E4E1482CB40C9C5, _id_A7B23DAE3BCFE5F8);
      }

      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = struct;

      if(_id_50F783A5617F8940.size >= 35) {
        break;
      }

      continue;
    }

    _id_50F783A5617F8940[_id_50F783A5617F8940.size] = struct;

    if(_id_50F783A5617F8940.size >= 35) {
      break;
    }
  }

  return _id_50F783A5617F8940;
}

hasplayerentattached(player, struct) {
  foreach(ent in player.personalents) {
    if(isDefined(struct.playeroffset) && isDefined(struct.playeroffset[player.name])) {
      if(ent.origin == struct.playeroffset[player.name]) {
        ent.used = 1;
        return 1;
      }
    }

    if(isDefined(struct.target)) {
      _id_CED0426E7E729ED5 = scripts\engine\utility::getStruct(struct.target, "targetname");

      if(isDefined(_id_CED0426E7E729ED5) && ent.origin == _id_CED0426E7E729ED5.origin) {
        ent.used = 1;
        return 1;
      }
    }

    if(ent.origin == struct.origin) {
      ent.used = 1;
      return 1;
    }
  }

  return 0;
}

adjustmodelvis(player, ent) {
  foreach(guy in level.players) {
    if(guy == player) {
      ent showtoplayer(guy);
      continue;
    }

    ent hidefromplayer(guy);
  }
}

resetpersonalent(ent, player) {
  ent setModel("tag_origin");
  ent.claimed = 0;
  ent.used = 0;
  ent dontinterpolate();
  ent.origin = ent.ogorigin;

  if(isDefined(ent.parentstruct)) {
    if(isDefined(ent.parentstruct.linkedpents)) {
      if(scripts\engine\utility::array_contains(ent.parentstruct.linkedpents, ent))
        ent.parentstruct.linkedpents = scripts\engine\utility::array_remove(ent.parentstruct.linkedpents, ent);
    }

    ent.parentstruct notify("p_ents_updated");
    ent.parentstruct = undefined;
  }

  ent notify("p_ent_reset");
}

getattachedpersonalent(player, struct) {
  _id_50F783A5617F8940 = [];

  foreach(ent in player.personalents) {
    if(isDefined(struct.playeroffset) && isDefined(struct.playeroffset[player.name])) {
      if(ent.origin == struct.playeroffset[player.name])
        return ent;
    }

    if(isDefined(struct.target)) {
      _id_CED0426E7E729ED5 = scripts\engine\utility::getStruct(struct.target, "targetname");

      if(isDefined(_id_CED0426E7E729ED5) && ent.origin == _id_CED0426E7E729ED5.origin)
        return ent;
    }

    if(ent.origin == struct.origin)
      return ent;
  }

  return undefined;
}

getunclaimedpersonalent(player, _id_9E4E1482CB40C9C5) {
  _id_50F783A5617F8940 = [];

  foreach(ent in player.personalents) {
    _id_B076F2949CB48F5B = 0;

    foreach(struct in _id_9E4E1482CB40C9C5) {
      if(isDefined(struct.playeroffset) && isDefined(struct.playeroffset[player.name])) {
        if(ent.origin == struct.playeroffset[player.name]) {
          _id_B076F2949CB48F5B = 1;
          break;
        }
      }

      if(isDefined(struct.target)) {
        _id_CED0426E7E729ED5 = scripts\engine\utility::getStruct(struct.target, "targetname");

        if(isDefined(_id_CED0426E7E729ED5) && ent.origin == _id_CED0426E7E729ED5.origin) {
          _id_B076F2949CB48F5B = 1;
          break;
        }
      }

      if(ent.origin == struct.origin) {
        _id_B076F2949CB48F5B = 1;
        break;
      }
    }

    if(!_id_B076F2949CB48F5B)
      return ent;
  }

  return undefined;
}

watchforplayerzonechange(player) {
  level endon("game_ended");
  player endon("disconnect");
  scripts\engine\utility::flag_wait("init_interaction_done");
  trigger = getEnt("zone_change", "targetname");

  if(isDefined(trigger)) {
    for(;;) {
      if(player istouching(trigger)) {
        player notify("rave_status_changed");
        wait 1;
        continue;
      } else
        wait 0.1;
    }
  }
}

pentadvancedoptions(_id_C00517B36EF68852, struct, ent, player, _id_CED0426E7E729ED5) {
  key = scripts\engine\utility::ter_op(isDefined(struct.name), struct.name, struct.script_noteworthy);

  if(isDefined(level.normal_mode_activation_funcs[key])) {
    if(isDefined(_id_CED0426E7E729ED5))
      ent[[level.normal_mode_activation_funcs[key]]](ent, _id_CED0426E7E729ED5, 0, player);
    else
      ent thread[[level.normal_mode_activation_funcs[key]]](ent, struct, 0, player);
  }

  if(pentparamsdefined(struct.script_noteworthy)) {
    hintobj = createpenthintobj(getpentparams(struct.script_noteworthy), struct, undefined);
    ent.hintobj = hintobj;

    foreach(guy in level.players) {
      if(guy == player) {
        hintobj enableplayeruse(player);
        continue;
      }

      hintobj disableplayeruse(guy);
    }

    thread watch_for_player_trigger(ent, struct, player, hintobj);
    thread reset_struct_when_pent_moves(ent, struct, player, hintobj);
    thread watch_for_hintstring_updates(ent, struct, player, hintobj);
  }
}

reset_struct_when_pent_moves(ent, struct, player, hintobj) {
  ent notify("reset_struct_when_pent_moves");
  ent endon("reset_struct_when_pent_moves");
  struct notify("reset_struct_when_pent_moves_" + player.name);
  struct endon("reset_struct_when_pent_moves_" + player.name);
  level endon("game_ended");
  scripts\engine\utility::waittill_any_ents(ent, "p_ent_reset", struct, "remove_from_current_interaction_list", player, "remove_from_current_interaction_list_for_player_" + player.name);

  if(isDefined(hintobj) && hintobj != ent)
    hintobj delete();
  else if(isDefined(hintobj))
    hintobj scripts\cp\utility::clearhintobject(hintobj);

  if(isDefined(ent.hintobj))
    ent.hintobj = undefined;

  if(isDefined(ent.collision))
    ent.collision delete();

  if(isDefined(struct.collision))
    struct.collision delete();

  _id_71332A5B74214116::add_to_current_interaction_list_for_player(struct, player);
  update_special_mode_for_all_players(1);
}

disableuseotherplayerspents(player) {
  foreach(guy in level.players) {
    if(guy == player) {
      continue;
    }
    if(isDefined(guy.personalents)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < guy.personalents.size; _id_AC0E594AC96AA3A8++) {
        if(isDefined(guy.personalents[_id_AC0E594AC96AA3A8])) {
          guy.personalents[_id_AC0E594AC96AA3A8] disableplayeruse(player);

          if(isDefined(guy.personalents[_id_AC0E594AC96AA3A8].hintobj))
            guy.personalents[_id_AC0E594AC96AA3A8].hintobj disableplayeruse(player);
        }
      }
    }
  }
}

watch_for_player_trigger(ent, struct, player, hintobj) {
  struct notify("watch_for_player_trigger_" + player.name);
  struct endon("watch_for_player_trigger_" + player.name);
  ent notify("watch_for_player_trigger");
  ent endon("watch_for_player_trigger");
  ent endon("p_ent_reset");
  use_func = getpentinteractionusefunc(struct);
  ent.hintobj = hintobj;

  if(isDefined(use_func)) {
    for(;;) {
      hintobj makeusable();

      foreach(guy in level.players) {
        if(guy == player) {
          hintobj enableplayeruse(player);
          continue;
        }

        hintobj disableplayeruse(guy);
      }

      hintobj waittill("trigger", _id_484CE98A6B8C62F3);

      if(isPlayer(_id_484CE98A6B8C62F3))
        level thread[[use_func]](struct, player);
    }
  }
}

getpentinteractionusefunc(_id_DF071553D0996FF9) {
  if(isDefined(level.pentparams[_id_DF071553D0996FF9.script_noteworthy].activation_func))
    return level.pentparams[_id_DF071553D0996FF9.script_noteworthy].activation_func;
  else if(isDefined(level.interactions[_id_DF071553D0996FF9.script_noteworthy].activation_func))
    return level.interactions[_id_DF071553D0996FF9.script_noteworthy].activation_func;
  else
    return undefined;
}

update_pent_hintstring(_id_DF071553D0996FF9, hintstring) {
  _id_DF071553D0996FF9.hintstring = hintstring;
  _id_DF071553D0996FF9 notify("pent_update_hint", hintstring);
}

watch_for_hintstring_updates(ent, struct, player, hintobj) {
  struct endon("watch_for_player_trigger_" + player.name);
  ent endon("watch_for_player_trigger");
  ent endon("p_ent_reset");

  for(;;) {
    struct waittill("pent_update_hint", hintstring);

    if(!hasplayerentattached(player, struct)) {
      return;
    }
    hintobj setHintString(hintstring);
  }
}

player_run_pent_updates(player) {
  if(isDefined(level.personal_ent_zones))
    thread update_pents_from_volumes(player);
  else
    thread update_pents_global(player);
}

update_pents_from_volumes(player) {
  level endon("game_ended");
  player notify("update_pents_from_volumes");
  player endon("update_pents_from_volumes");
  player endon("disconnect");

  if(!scripts\engine\utility::flag_exist("personal_ent_zones_initialized"))
    return;
  else
    scripts\engine\utility::flag_wait("personal_ent_zones_initialized");

  for(;;) {
    player.all_available_pents = [];

    foreach(zone in level.personal_ent_zones) {
      if(ispointinvolume(player.origin, zone))
        player.all_available_pents = scripts\engine\utility::array_combine(player.all_available_pents, zone.attached_pents);
    }

    wait 1;
    update_special_mode_for_player(player);
  }
}

update_pents_global(player) {
  level endon("game_ended");
  player notify("update_pents_from_volumes");
  player endon("update_pents_from_volumes");
  player endon("disconnect");

  if(!scripts\engine\utility::flag_exist("personal_ent_zones_initialized"))
    return;
  else
    scripts\engine\utility::flag_wait("personal_ent_zones_initialized");

  for(;;) {
    wait 1;
    update_special_mode_for_player(player);
  }
}

init_personal_ent_zones() {
  _id_D7D94E6F18E42B32 = level.current_personal_interaction_structs;
  personal_ent_zones = getEntArray("p_ent_zone", "targetname");

  foreach(zone in personal_ent_zones) {
    zone.attached_pents = [];

    foreach(struct in _id_D7D94E6F18E42B32) {
      if(!isDefined(struct.p_ent_zones))
        struct.p_ent_zones = [];

      if(ispointinvolume(struct.origin, zone)) {
        zone.attached_pents[zone.attached_pents.size] = struct;
        struct.p_ent_zones[struct.p_ent_zones.size] = zone;
      }
    }
  }

  if(personal_ent_zones.size > 0)
    level.personal_ent_zones = personal_ent_zones;

  scripts\engine\utility::flag_set("personal_ent_zones_initialized");
}