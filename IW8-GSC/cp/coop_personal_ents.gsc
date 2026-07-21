/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\coop_personal_ents.gsc
***********************************************/

assignpersonalmodelents(var_0) {
  if(getdvarint("_encstr_B16A16F79F33B8B0537FC63B673AC8E88AFF51273F5AF578", 1)) {
    if(!isDefined(var_0.personalents) || var_0.personalents.size < 1) {
      var_0.personalents = [];
      var_0 scripts\engine\utility::ent_flag_init("_encstr_918F17C159E4B9B79B8563BEB2733A37F5D5E08C0BD14BDCD9");

      for(var_1 = 0; var_1 < 20; var_1++) {
        var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, -5000));
        var_2.ogorigin = (0, 0, -5000);
        var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
        var_2.claimed = 0;
        var_2.used = 0;
        adjustmodelvis(var_0, var_2);
        var_0.personalents[var_0.personalents.size] = var_2;
      }
    }

    local_waittill_any_return_6(var_0);
    level thread deletepentsondisconnect(var_0);
    level thread deletepentsonrespawn(var_0);
  }
}

deletepentsonrespawn(var_0) {
  var_0 notify("_encstr_873A153F8940455BA5B11FBB115610B659117282A1C006");
  var_0 endon("_encstr_873A153F8940455BA5B11FBB115610B659117282A1C006");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_956C0F7507A3AF90D73D46BBA5A9186DCB", var_1);

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.personalents)) {
    return;
  }
  for(var_2 = 0; var_2 < var_0.personalents.size; var_2++) {
    if(isDefined(var_0.personalents[var_2]))
      var_0.personalents[var_2] delete();
  }

  var_0.personalents = [];
}

deletepentsondisconnect(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_8484188BD3214264200FAF6D6378972A9D636F1F5F58BA2D2893");
  var_0 endon("_encstr_8484188BD3214264200FAF6D6378972A9D636F1F5F58BA2D2893");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_0.personalents)) {
    return;
  }
  for(var_1 = 0; var_1 < var_0.personalents.size; var_1++) {
    if(isDefined(var_0.personalents[var_1]))
      var_0.personalents[var_1] delete();
  }
}

registerpentparams(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = spawnStruct();
  var_11.type = var_1;
  var_11.icon = var_2;
  var_11.hintstring = var_3;
  var_11.priority = var_4;
  var_11.duration = var_5;
  var_11.onobstruction = var_6;
  var_11.hintdist = var_7;
  var_11.hintfov = var_8;
  var_11.usedist = var_9;
  var_11.usefov = var_10;
  var_11.hint_func = level.interactions[var_0].hint_func;
  var_11.activation_func = level.interactions[var_0].activation_func;
  level.pentparams[var_0] = var_11;
  level.interactions[var_0].hint_func = undefined;
  level.interactions[var_0].activation_func = undefined;
}

pentparamsdefined(var_0) {
  return isDefined(level.pentparams[var_0]);
}

getpentparams(var_0) {
  return level.pentparams[var_0];
}

createpenthintobj(var_0, var_1, var_2) {
  var_3 = scripts\cp\utility::createhintobject(var_1.origin, var_0.type, var_0.icon, var_0.hintstring, var_0.priority, var_0.duration, var_0.onobstruction, var_0.hintdist, var_0.hintfov, var_0.usedist, var_0.usefov);
  return var_3;
}

addtopersonalinteractionlist(var_0) {
  var_0 notify("_encstr_829B1D879F90F3587127ADC030FDE8D817BE98173D9E506363B01814BA2B23");

  if(!scripts\engine\utility::array_contains(level.current_personal_interaction_structs, var_0)) {
    level.current_personal_interaction_structs = scripts\engine\utility::array_add(level.current_personal_interaction_structs, var_0);

    if(scripts\engine\utility::flag_exist("_encstr_9B931F0EAC279B7BB916D87D95B9A3EB4FB7CDAC9BF52D9B968E4BB01B964F598C") && scripts\engine\utility::flag("_encstr_9B931F0EAC279B7BB916D87D95B9A3EB4FB7CDAC9BF52D9B968E4BB01B964F598C")) {
      if(isDefined(level.personal_ent_zones) && level.personal_ent_zones.size > 0) {
        foreach(var_2 in level.personal_ent_zones) {
          if(!isDefined(var_2.attached_pents)) {
            continue;
          }
          if(!isDefined(var_0.p_ent_zones)) {
            continue;
          }
          if(ispointinvolume(var_0.origin, var_2)) {
            var_2.attached_pents[var_2.attached_pents.size] = var_0;
            var_0.p_ent_zones[var_0.p_ent_zones.size] = var_2;
            var_2.attached_pents = scripts\engine\utility::array_remove_duplicates(var_2.attached_pents);
          }
        }
      }
    }
  }

  update_special_mode_for_all_players(1);
}

removefrompersonalinteractionlist(var_0) {
  var_0 notify("_encstr_8263229359B6ED6759C8E4DEADA0569CB9DB9B2C6392B9E8AC4EC28DE8967B9B98B4DCD1");

  if(scripts\engine\utility::array_contains(level.current_personal_interaction_structs, var_0)) {
    level.current_personal_interaction_structs = scripts\engine\utility::array_remove(level.current_personal_interaction_structs, var_0);

    if(scripts\engine\utility::flag_exist("_encstr_9B931F0EAC279B7BB916D87D95B9A3EB4FB7CDAC9BF52D9B968E4BB01B964F598C") && scripts\engine\utility::flag("_encstr_9B931F0EAC279B7BB916D87D95B9A3EB4FB7CDAC9BF52D9B968E4BB01B964F598C")) {
      if(isDefined(var_0.p_ent_zones)) {
        foreach(var_2 in var_0.p_ent_zones) {
          var_2.attached_pents = scripts\engine\utility::array_remove(var_2.attached_pents, var_0);
          var_2.attached_pents = scripts\engine\utility::array_remove_duplicates(var_2.attached_pents);
        }
      }
    }
  }

  update_special_mode_for_all_players(1);
}

delayed_remove_peent_interaction(var_0) {
  wait 0.25;
  removefrompersonalinteractionlist(var_0);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

movepentstostructs(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_9B8413ADDB9DCA05519B8E9B51F6358E4E5DB1A39B");
  var_0 endon("_encstr_9B8413ADDB9DCA05519B8E9B51F6358E4E5DB1A39B");

  if(!scripts\engine\utility::flag("_encstr_8BA416297AC063070845C4D98B2F7FA1BBF78297FD679EAF"))
    scripts\engine\utility::flag_wait("_encstr_8BA416297AC063070845C4D98B2F7FA1BBF78297FD679EAF");

  for(;;) {
    if(var_0 scripts\engine\utility::ent_flag_exist("_encstr_918F17C159E4B9B79B8563BEB2733A37F5D5E08C0BD14BDCD9"))
      var_0 scripts\engine\utility::ent_flag_set("_encstr_918F17C159E4B9B79B8563BEB2733A37F5D5E08C0BD14BDCD9");

    var_6 = 0;
    var_7 = 0;

    if(isDefined(var_0.all_available_pents))
      var_8 = var_0.all_available_pents;
    else
      var_8 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.current_personal_interaction_structs, undefined, 100);

    if(var_8.size > 0) {
      var_8 = removeinvalidstructs(var_8, var_0);
      var_0 resetents(var_0, var_8);

      foreach(var_10 in var_8) {
        var_11 = undefined;

        if(isDefined(var_10.target))
          var_11 = scripts\engine\utility::getStruct(var_10.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

        if(var_10 hasplayerentattached(var_0, var_10)) {
          var_12 = getattachedpersonalent(var_0, var_10);

          if(isDefined(var_12)) {
            if(isDefined(var_10.pentmodel) && var_10.pentmodel != var_12.model)
              var_12 setModel(var_10.pentmodel);

            if(istrue(var_0.force_p_ent_reset)) {
              if(struct_has_advanced_settings(var_10))
                var_12 thread pentadvancedoptions(0, var_10, var_12, var_0, var_11);
            }
          }

          continue;
        }

        var_12 = getunclaimedpersonalent(var_0, var_8);

        if(isDefined(var_12)) {
          if(player_can_see_p_ent(var_10, var_0)) {
            continue;
          }
          var_10.awaitingpent = 1;
          var_12 dontinterpolate();

          if(isDefined(var_11)) {
            var_12.origin = var_11.origin;

            if(isDefined(var_11.angles))
              var_12.angles = var_11.angles;
            else
              var_12.angles = (0, 0, 0);
          } else {
            var_12.origin = var_10.origin;

            if(isDefined(var_10.angles))
              var_12.angles = var_10.angles;
            else
              var_12.angles = (0, 0, 0);
          }

          if(isDefined(var_10.pentmodel))
            thread pentdelaysetModel(var_0, var_12, var_10);
          else {}

          if(struct_has_advanced_settings(var_10))
            var_12 thread pentadvancedoptions(0, var_10, var_12, var_0, var_11);
        }
      }
    }

    var_0.force_p_ent_reset = undefined;
    wait 0.25;

    if(var_0 scripts\engine\utility::ent_flag_exist("_encstr_918F17C159E4B9B79B8563BEB2733A37F5D5E08C0BD14BDCD9"))
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_918F17C159E4B9B79B8563BEB2733A37F5D5E08C0BD14BDCD9");

    var_0 notify("_encstr_96DA0D83A8CDE8E6AA1C91B01D5623");
    var_0 scripts\engine\utility::waittill_any_in_array_return_no_endon_death(["_encstr_9B9E0C7347A0C2CF908826ED8148", "_encstr_B6350C15209BCBD995773FB8792A"]);
  }
}

player_can_see_p_ent(var_0, var_1) {
  if(istrue(var_0.p_ent_skip_fov))
    return 0;
  else if(isDefined(level.pentskipfov) && istrue(level.pentskipfov[var_0.script_noteworthy]))
    return 0;
  else {
    var_2 = scripts\engine\utility::within_fov(var_1 getEye(), var_1 getplayerangles(), var_0.origin, cos(65));

    if(var_2) {
      var_3 = scripts\engine\trace::ray_trace_passed(var_1 getEye(), var_0.origin, scripts\engine\utility::array_combine(level.players, var_1.personalents));

      if(var_3) {
        return 1;
        return;
      }

      return 0;
      return;
    } else
      return 0;
  }
}

struct_has_advanced_settings(var_0) {
  if(isDefined(var_0.script_noteworthy))
    var_1 = var_0.script_noteworthy;
  else
    return 0;

  if(istrue(var_0.pentadvanced))
    return 1;
  else if(isDefined(level.normal_mode_activation_funcs[var_1]))
    return 1;
  else if(isDefined(level.special_mode_activation_funcs[var_1]))
    return 1;
  else if(pentparamsdefined(var_0.script_noteworthy))
    return 1;
  else
    return 0;
}

pentdelaysetModel(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_BA890CBF87C5E8C359A32FE7299B");
  var_1.claimed = 1;
  var_1.parentstruct = var_2;

  if(!isDefined(var_2.linkedpents))
    var_2.linkedpents = [];

  var_2.linkedpents[var_2.linkedpents.size] = var_1;
  var_1.used = 1;

  if(player_can_see_p_ent(var_2, var_0)) {
    var_1 resetpersonalent(var_1, var_0);
    return;
  }

  wait 0.1;
  var_1 setModel(var_2.pentmodel);

  if(isDefined(var_2.expectedstate))
    var_1 setscriptablepartstate(var_2.expectedstate[0], var_2.expectedstate[1], 1);

  var_2.awaitingpent = undefined;
}

update_special_mode_for_player(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_813D1FB3284F5875DFB1533B7AAFA30BE5AF3B0FA4F761B4CF7BAE23D27F63E83A");
  var_0 endon("_encstr_813D1FB3284F5875DFB1533B7AAFA30BE5AF3B0FA4F761B4CF7BAE23D27F63E83A");

  if(istrue(var_1)) {}

  if(var_0 scripts\engine\utility::ent_flag_exist("_encstr_918F17C159E4B9B79B8563BEB2733A37F5D5E08C0BD14BDCD9") && var_0 scripts\engine\utility::ent_flag("_encstr_918F17C159E4B9B79B8563BEB2733A37F5D5E08C0BD14BDCD9"))
    var_0 scripts\engine\utility::ent_flag_waitopen("_encstr_918F17C159E4B9B79B8563BEB2733A37F5D5E08C0BD14BDCD9");

  var_0 notify("_encstr_B6350C15209BCBD995773FB8792A");
}

update_special_mode_for_all_players(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_2 in level.players)
  thread update_special_mode_for_player(var_2, var_0);
}

resetents(var_0, var_1) {
  var_2 = [];
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_0.personalents) {
    if(!isent(var_6)) {
      continue;
    }
    var_7 = 0;

    foreach(var_4 in var_1) {
      if(isDefined(var_4.playeroffset) && isDefined(var_4.playeroffset[var_0.name])) {
        if(var_6.origin == var_4.playeroffset[var_0.name]) {
          var_3 = var_4.script_noteworthy;
          var_7 = 1;
          break;
        }
      }

      if(isDefined(var_4.target)) {
        var_9 = scripts\engine\utility::getStruct(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

        if(isDefined(var_9) && var_6.origin == var_9.origin) {
          var_3 = var_4.script_noteworthy;
          var_7 = 1;
          break;
        } else if(var_6.origin == var_4.origin) {
          var_3 = var_4.script_noteworthy;
          var_7 = 1;
          break;
        }

        continue;
      }

      if(var_6.origin == var_4.origin) {
        var_3 = var_4.script_noteworthy;
        var_7 = 1;
        break;
      }
    }

    if(!var_7) {
      if(isDefined(var_4) && player_can_see_p_ent(var_4, var_0)) {
        continue;
      }
      var_6 resetpersonalent(var_6, var_0);
    }
  }

  wait 0.1;
}

removeinvalidstructs(var_0, var_1) {
  var_2 = [];
  var_0 = sortbydistance(var_0, var_1.origin);

  foreach(var_4 in var_0) {
    if(isDefined(var_1.disabled_interactions) && scripts\engine\utility::array_contains(var_1.disabled_interactions, var_4)) {
      continue;
    }
    if(isDefined(var_4.in_array)) {
      if(!istrue(var_4.in_array))
        continue;
    } else if(isDefined(level.current_interaction_structs) && !scripts\engine\utility::array_contains(level.current_interaction_structs, var_4)) {
      continue;
    }
    if(isDefined(var_4.target)) {
      var_5 = scripts\engine\utility::getStructArray(var_4.targetname, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      foreach(var_7 in var_5) {
        if(isDefined(var_7.target) && var_7.target == var_4.target)
          var_0 = scripts\engine\utility::array_remove(var_0, var_7);
      }

      var_2[var_2.size] = var_4;

      if(var_2.size >= 20) {
        break;
      }

      continue;
    }

    var_2[var_2.size] = var_4;

    if(var_2.size >= 20) {
      break;
    }
  }

  return var_2;
}

hasplayerentattached(var_0, var_1) {
  foreach(var_3 in var_0.personalents) {
    if(isDefined(var_1.playeroffset) && isDefined(var_1.playeroffset[var_0.name])) {
      if(var_3.origin == var_1.playeroffset[var_0.name]) {
        var_3.used = 1;
        return 1;
      }
    }

    if(isDefined(var_1.target)) {
      var_4 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(isDefined(var_4) && var_3.origin == var_4.origin) {
        var_3.used = 1;
        return 1;
      }
    }

    if(var_3.origin == var_1.origin) {
      var_3.used = 1;
      return 1;
    }
  }

  return 0;
}

adjustmodelvis(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 == var_0) {
      var_1 showtoplayer(var_3);
      continue;
    }

    var_1 hidefromplayer(var_3);
  }
}

resetpersonalent(var_0, var_1) {
  var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0.claimed = 0;
  var_0.used = 0;
  var_0 dontinterpolate();
  var_0.origin = var_0.ogorigin;

  if(isDefined(var_0.parentstruct)) {
    if(isDefined(var_0.parentstruct.linkedpents)) {
      if(scripts\engine\utility::array_contains(var_0.parentstruct.linkedpents, var_0))
        var_0.parentstruct.linkedpents = scripts\engine\utility::array_remove(var_0.parentstruct.linkedpents, var_0);
    }

    var_0.parentstruct notify("_encstr_B1B20F51EFF7D89D6F693B83C2FF55484F");
    var_0.parentstruct = undefined;
  }

  var_0 notify("_encstr_BA890CBF87C5E8C359A32FE7299B");
}

getattachedpersonalent(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0.personalents) {
    if(isDefined(var_1.playeroffset) && isDefined(var_1.playeroffset[var_0.name])) {
      if(var_4.origin == var_1.playeroffset[var_0.name])
        return var_4;
    }

    if(isDefined(var_1.target)) {
      var_5 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(isDefined(var_5) && var_4.origin == var_5.origin)
        return var_4;
    }

    if(var_4.origin == var_1.origin)
      return var_4;
  }

  return undefined;
}

getunclaimedpersonalent(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0.personalents) {
    var_5 = 0;

    foreach(var_7 in var_1) {
      if(isDefined(var_7.playeroffset) && isDefined(var_7.playeroffset[var_0.name])) {
        if(var_4.origin == var_7.playeroffset[var_0.name]) {
          var_5 = 1;
          break;
        }
      }

      if(isDefined(var_7.target)) {
        var_8 = scripts\engine\utility::getStruct(var_7.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

        if(isDefined(var_8) && var_4.origin == var_8.origin) {
          var_5 = 1;
          break;
        }
      }

      if(var_4.origin == var_7.origin) {
        var_5 = 1;
        break;
      }
    }

    if(!var_5)
      return var_4;
  }

  return undefined;
}

watchforplayerzonechange(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::flag_wait("_encstr_8BA416297AC063070845C4D98B2F7FA1BBF78297FD679EAF");
  var_1 = getEnt("_encstr_9B9E0C7347A0C2CF908826ED8148", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1)) {
    for(;;) {
      if(var_0 istouching(var_1)) {
        var_0 notify("_encstr_B2F014CBDEFEA020A34B6341678B68C888B630E14754");
        wait 1;
        continue;
      } else
        wait 0.1;
    }
  }
}

pentadvancedoptions(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::ter_op(isDefined(var_1.name), var_1.name, var_1.script_noteworthy);

  if(isDefined(level.normal_mode_activation_funcs[var_5])) {
    if(isDefined(var_4))
      var_2[[level.normal_mode_activation_funcs[var_5]]](var_2, var_4, 0, var_3);
    else
      var_2 thread[[level.normal_mode_activation_funcs[var_5]]](var_2, var_1, 0, var_3);
  }

  if(pentparamsdefined(var_1.script_noteworthy)) {
    var_6 = createpenthintobj(getpentparams(var_1.script_noteworthy), var_1, undefined);
    var_2.hintobj = var_6;

    foreach(var_8 in level.players) {
      if(var_8 == var_3) {
        var_6 enableplayeruse(var_3);
        continue;
      }

      var_6 disableplayeruse(var_8);
    }

    thread watch_for_player_trigger(var_2, var_1, var_3, var_6);
    thread reset_struct_when_pent_moves(var_2, var_1, var_3, var_6);
    thread watch_for_hintstring_updates(var_2, var_1, var_3, var_6);
  }
}

reset_struct_when_pent_moves(var_0, var_1, var_2, var_3) {
  var_0 notify("_encstr_8A831D50A01B83C36F1678FD4387D581639B97D391E7E3B6D561BBAFB4918F");
  var_0 endon("_encstr_8A831D50A01B83C36F1678FD4387D581639B97D391E7E3B6D561BBAFB4918F");
  var_1 notify("_encstr_91841E93ACB9B23ABECDE839D56CE87DBBA1B2DCFA1C2B37D17DB67BECB2377D" + var_2.name);
  var_1 endon("_encstr_91841E93ACB9B23ABECDE839D56CE87DBBA1B2DCFA1C2B37D17DB67BECB2377D" + var_2.name);
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::waittill_any_ents(var_0, "_encstr_BA890CBF87C5E8C359A32FE7299B", var_1, "_encstr_86C12526DF102A0C2FE94D1BC799EFCB9BA032ADFB64BF73602C45485FFE98B397B8D1FCB0D0AB", var_2, "_encstr_A28C3193CA5BBDD9B2FA33C9BDDAAFB157C9E4B2B9A3EBA5DC47599CC28DD14B7B73D7B1D29B1DFACCF6E4BE83D816CB59C9FA" + var_2.name);

  if(isDefined(var_3) && var_3 != var_0)
    var_3 delete();
  else if(isDefined(var_3))
    var_3 scripts\cp\utility::clearhintobject(var_3);

  if(isDefined(var_0.hintobj))
    var_0.hintobj = undefined;

  if(isDefined(var_0.collision))
    var_0.collision delete();

  if(isDefined(var_1.collision))
    var_1.collision delete();

  scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_1, var_2);
  update_special_mode_for_all_players(1);
}

local_waittill_any_return_6(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }
    if(isDefined(var_2.personalents)) {
      for(var_3 = 0; var_3 < var_2.personalents.size; var_3++) {
        if(isDefined(var_2.personalents[var_3])) {
          var_2.personalents[var_3] disableplayeruse(var_0);

          if(isDefined(var_2.personalents[var_3].hintobj))
            var_2.personalents[var_3].hintobj disableplayeruse(var_0);
        }
      }
    }
  }
}

watch_for_player_trigger(var_0, var_1, var_2, var_3) {
  var_1 notify("_encstr_81D51AEE2CA3B186F5997B9CFA388D85BC9593FA1D9C4BB376594EF5" + var_2.name);
  var_1 endon("_encstr_81D51AEE2CA3B186F5997B9CFA388D85BC9593FA1D9C4BB376594EF5" + var_2.name);
  var_0 notify("_encstr_A623195F880BEB0A2FA4453AAF5902B1F2C03377B8632922A7CD0A");
  var_0 endon("_encstr_A623195F880BEB0A2FA4453AAF5902B1F2C03377B8632922A7CD0A");
  var_0 endon("_encstr_BA890CBF87C5E8C359A32FE7299B");
  var_4 = getpentinteractionusefunc(var_1);
  var_0.hintobj = var_3;

  if(isDefined(var_4)) {
    for(;;) {
      var_3 makeusable();

      foreach(var_6 in level.players) {
        if(var_6 == var_2) {
          var_3 enableplayeruse(var_2);
          continue;
        }

        var_3 disableplayeruse(var_6);
      }

      var_3 waittill("_encstr_8F5C086405E70FBA4B4A", var_8);

      if(isPlayer(var_8))
        level thread[[var_4]](var_1, var_2);
    }
  }
}

getpentinteractionusefunc(var_0) {
  if(isDefined(level.pentparams[var_0.script_noteworthy].activation_func))
    return level.pentparams[var_0.script_noteworthy].activation_func;
  else if(isDefined(level.interactions[var_0.script_noteworthy].activation_func))
    return level.interactions[var_0.script_noteworthy].activation_func;
  else
    return undefined;
}

update_pent_hintstring(var_0, var_1) {
  var_0.hintstring = var_1;
  var_0 notify("_encstr_8A1E11832BE68EFABA3823583A56D7862DB9E8", var_1);
}

watch_for_hintstring_updates(var_0, var_1, var_2, var_3) {
  var_1 endon("_encstr_81D51AEE2CA3B186F5997B9CFA388D85BC9593FA1D9C4BB376594EF5" + var_2.name);
  var_0 endon("_encstr_A623195F880BEB0A2FA4453AAF5902B1F2C03377B8632922A7CD0A");
  var_0 endon("_encstr_BA890CBF87C5E8C359A32FE7299B");

  for(;;) {
    var_1 waittill("_encstr_8A1E11832BE68EFABA3823583A56D7862DB9E8", var_4);

    if(!hasplayerentattached(var_2, var_1)) {
      return;
    }
    var_3 setHintString(var_4);
  }
}

player_run_pent_updates(var_0) {
  if(isDefined(level.personal_ent_zones))
    thread update_pents_from_volumes(var_0);
  else
    thread update_pents_global(var_0);
}

update_pents_from_volumes(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_A5111A53E264083D5A6FF9EB937386B13EFA982841DEC0F9B34FDBCF");
  var_0 endon("_encstr_A5111A53E264083D5A6FF9EB937386B13EFA982841DEC0F9B34FDBCF");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!scripts\engine\utility::flag_exist("_encstr_9B931F0EAC279B7BB916D87D95B9A3EB4FB7CDAC9BF52D9B968E4BB01B964F598C"))
    return;
  else
    scripts\engine\utility::flag_wait("_encstr_9B931F0EAC279B7BB916D87D95B9A3EB4FB7CDAC9BF52D9B968E4BB01B964F598C");

  for(;;) {
    var_0.all_available_pents = [];

    foreach(var_2 in level.personal_ent_zones) {
      if(ispointinvolume(var_0.origin, var_2))
        var_0.all_available_pents = scripts\engine\utility::array_combine(var_0.all_available_pents, var_2.attached_pents);
    }

    wait 1;
    update_special_mode_for_player(var_0);
  }
}

update_pents_global(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_A5111A53E264083D5A6FF9EB937386B13EFA982841DEC0F9B34FDBCF");
  var_0 endon("_encstr_A5111A53E264083D5A6FF9EB937386B13EFA982841DEC0F9B34FDBCF");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!scripts\engine\utility::flag_exist("_encstr_9B931F0EAC279B7BB916D87D95B9A3EB4FB7CDAC9BF52D9B968E4BB01B964F598C"))
    return;
  else
    scripts\engine\utility::flag_wait("_encstr_9B931F0EAC279B7BB916D87D95B9A3EB4FB7CDAC9BF52D9B968E4BB01B964F598C");

  for(;;) {
    wait 1;
    update_special_mode_for_player(var_0);
  }
}

init_personal_ent_zones() {
  var_0 = level.current_personal_interaction_structs;
  var_1 = getEntArray("_encstr_8D050B1CD79573D1D73DBD9BCA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    var_3.attached_pents = [];

    foreach(var_5 in var_0) {
      if(!isDefined(var_5.p_ent_zones))
        var_5.p_ent_zones = [];

      if(ispointinvolume(var_5.origin, var_3)) {
        var_3.attached_pents[var_3.attached_pents.size] = var_5;
        var_5.p_ent_zones[var_5.p_ent_zones.size] = var_3;
      }
    }
  }

  if(var_1.size > 0)
    level.personal_ent_zones = var_1;

  scripts\engine\utility::flag_set("_encstr_9B931F0EAC279B7BB916D87D95B9A3EB4FB7CDAC9BF52D9B968E4BB01B964F598C");
}