/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\exfil.gsc
***********************************************/

exfilinit() {
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
}

onexfilstart(winner, getexfilloccallback, _id_7C52B433F53D39EE, onexfilkilled) {
  level.getexfilloccallback = getexfilloccallback;
  level.onexfilfinishedcallback = _id_7C52B433F53D39EE;
  level.onexfilkilledcallback = onexfilkilled;
  level.exfilgoaltrigger = getEnt(winner + "_exfil_trigger", "targetname");
  level.exfilstarted = 1;

  if(isDefined(level.onexfilstarted))
    [[level.onexfilstarted]]();

  if(isDefined(level.objectives) && level.objectives.size > 0)
    thread removeallobjids();

  level.ignorescoring = 1;
  scripts\mp\gamelogic::resumetimer();
  level.starttime = gettime();
  level.discardtime = 0;
  level.timerpausetime = 0;
  timelimit = level.exfilactivetimer + level.exfilextracttimer;
  _id_B2FF82EC901486E4 = _func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_timelimit");
  level.watchdvars[_id_B2FF82EC901486E4].value = timelimit;
  level.overridewatchdvars[_id_B2FF82EC901486E4] = timelimit;
  runexfil(winner, onexfilkilled);
}

removeallobjids() {
  foreach(_id_AC0E5F4AC96AB0DA in level.objectives) {
    if(isDefined(_id_AC0E5F4AC96AB0DA.objidnum))
      _id_AC0E5F4AC96AB0DA scripts\mp\gameobjects::releaseid();

    if(isDefined(_id_AC0E5F4AC96AB0DA.trigger) && isDefined(_id_AC0E5F4AC96AB0DA.trigger.objidnum))
      _id_AC0E5F4AC96AB0DA.trigger scripts\mp\gameobjects::releaseid();
  }
}

runexfil(winner, onhelikilled) {
  level thread scripts\mp\hud_message::notifyteam("callout_exfil_winners", "callout_exfil_losers", winner);
  level thread spawnexfilzone(winner);
  level thread spawnexfilplayers(winner);
  scripts\mp\utility\dialog::leaderdialog("enemy_exfil", scripts\mp\utility\game::getotherteam(winner)[0], "status");
  scripts\mp\utility\dialog::leaderdialog("friendly_exfil", winner, "status");
  level.timelimitoverride = 0;
  wait 1;
  level.ontimelimit = ::onexfiltimelimit;
}

spawnexfilplayers(winner) {
  _id_B2FF82EC901486E4 = _func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_numlives");
  level.watchdvars[_id_B2FF82EC901486E4].value = 1;
  level.overridewatchdvars[_id_B2FF82EC901486E4] = 1;
  level notify("extract_players_spawned");
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(winner, "exfil_prevent", "exfil_go");
}

skipkillcamandspawn() {
  self notify("abort_killcam");
  self.cancelkillcam = 1;
  waitframe();
  thread scripts\mp\playerlogic::spawnplayer(0, 1);

  if(scripts\mp\utility\game::isteamreviveenabled() && isDefined(level.revivetriggers[self.guid]))
    level.revivetriggers[self.guid].victim thread scripts\mp\teamrevive::removetrigger(level.revivetriggers[self.guid].victim.guid);
}

spawnexfilzone(winner) {
  level endon("game_ended");
  self endon("death");
  _id_C8A41AE10DD3B1D2 = scripts\mp\utility\game::getotherteam(winner)[0];

  if(!isDefined(level.exfilgoaltrigger)) {
    primaryflags = getEntArray("flag_primary", "targetname");
    triggers = [];

    for(index = 0; index < primaryflags.size; index++)
      triggers[triggers.size] = primaryflags[index];

    foreach(trigger in triggers) {
      if(trigger.script_label == "_b") {
        trigger.script_label = "_b";
        level.exfilgoaltrigger = trigger;

        if(!isDefined(level.exfilgoaltrigger)) {
          level notify("exfil_continue_game_end");
          return;
        }
      }
    }
  }

  level.exfilgoalent = spawn("script_model", level.exfilgoaltrigger.origin);
  level.exfilgoalent.angles = (0, 270, 0);
  level.exfilgoalent.team = _id_C8A41AE10DD3B1D2;
  level.exfilgoalent.visibleteam = "any";
  level.exfilgoalent.ownerteam = _id_C8A41AE10DD3B1D2;
  level.exfilgoalent.type = "";
  droppoint = level.exfilgoaltrigger.origin;
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(level.exfilgoalent.origin + (0, 0, 20), level.exfilgoalent.origin - (0, 0, 4000), ignoreents, contentoverride, 0);

  if(isPlayer(trace["entity"]))
    trace["entity"] = undefined;

  if(isDefined(trace)) {
    _id_9CA1B8FD292FEFFA = randomfloat(360);
    droporigin = trace["position"];

    if(isDefined(self.visualgroundoffset))
      droporigin = droporigin + self.visualgroundoffset;

    forward = (cos(_id_9CA1B8FD292FEFFA), sin(_id_9CA1B8FD292FEFFA), 0);
    forward = vectorNormalize(forward - trace["normal"] * vectordot(forward, trace["normal"]));
    dropangles = vectortoangles(forward);
    level.exfilgoalent.origin = droporigin;
    level.exfilgoalent setModel("cop_marker_scriptable");
    level.exfilgoalent setscriptablepartstate("marker", "red");
    level.exfilgoalent playLoopSound("mp_flare_burn_lp");
  }

  level.exfilgoaltrigger thread goaltriggerwatcher(self);
  level.exfilobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(level.exfilobjid != -1) {
    _id_024C76FC549F7FD9 = "current";
    scripts\mp\objidpoolmanager::objective_add_objective(level.exfilobjid, _id_024C76FC549F7FD9, level.exfilgoaltrigger.origin + (0, 0, 60));
    scripts\mp\objidpoolmanager::objective_set_play_intro(level.exfilobjid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_outro(level.exfilobjid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(level.exfilobjid);
    self.showworldicon = 1;
  }

  level.exfilgoalent scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil", level.exfilobjid);
  objective_sethot(level.exfilobjid, 1);
  level thread watchforexfilactive(winner);
  waitframe();
  playFXOnTag(level._effect["vfx_smk_signal"], level.exfilgoalent, "tag_origin");
}

goaltriggerwatcher(player) {
  level endon("game_ended");
  self notify("trigger_start");
  self endon("trigger_start");
  level waittill("extract_trigger_active");

  for(;;) {
    self waittill("trigger", player);

    if(player.team == level.exfilgoalent.team && !istrue(player.extracted))
      level thread onexfilsuccess(player);
  }
}

watchforexfilactive(winner) {
  level endon("game_ended");
  level thread runexfilnotactivefill(winner);
  level thread runexfilwaitactiveunfill(winner);
  _id_68D24288E5C2A0B4 = level.exfilactivetimer;
  wait(_id_68D24288E5C2A0B4);
  level.exfilnotactive = 0;
  level notify("extract_trigger_active");
  level.exfilgoalent scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil", level.exfilobjid);
}

runexfilnotactivefill(winner) {
  level endon("game_ended");
  level.exfilnotactive = 1;
  _id_038FC7BD1495C4B2 = level.framedurationseconds;
  _id_A1DFE9D4920A43FA = _id_038FC7BD1495C4B2 * 1000;
  _id_68D24288E5C2A0B4 = level.exfilactivetimer;
  _id_68D24288E5C2A0B4 = _id_68D24288E5C2A0B4 * 1000;
  addtime = _id_A1DFE9D4920A43FA;

  while(level.exfilnotactive) {
    if(addtime != 0) {
      _id_5F6264F695308483 = min(addtime / _id_68D24288E5C2A0B4, 1);
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.exfilobjid, undefined);
      scripts\mp\objidpoolmanager::objective_show_progress(self.exfilobjid, 1);
      scripts\mp\objidpoolmanager::objective_set_progress(self.exfilobjid, _id_5F6264F695308483);
      addtime = min(addtime + _id_A1DFE9D4920A43FA, _id_68D24288E5C2A0B4);
    }

    waitframe();
  }

  scripts\mp\utility\dialog::leaderdialog("exfilarrive_enemy", scripts\mp\utility\game::getotherteam(winner)[0], "status");
  scripts\mp\utility\dialog::leaderdialog("exfilarrive_friendly", winner, "status");
}

runexfilwaitactiveunfill(winner) {
  level endon("game_ended");
  level waittill("extract_trigger_active");
  level.exfilactive = 1;
  _id_038FC7BD1495C4B2 = level.framedurationseconds;
  _id_A1DFE9D4920A43FA = _id_038FC7BD1495C4B2 * 1000;
  _id_75F51A7EB662FE97 = level.exfilextracttimer;
  _id_75F51A7EB662FE97 = _id_75F51A7EB662FE97 * 1000;
  _id_D3D9F3AD00693948 = _id_75F51A7EB662FE97 - _id_A1DFE9D4920A43FA;

  while(level.exfilactive) {
    _id_5F6264F695308483 = _id_D3D9F3AD00693948 / _id_75F51A7EB662FE97;
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.exfilobjid, scripts\mp\utility\game::getotherteam(winner)[0]);
    scripts\mp\objidpoolmanager::objective_show_progress(self.exfilobjid, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.exfilobjid, _id_5F6264F695308483);
    _id_D3D9F3AD00693948 = max(_id_D3D9F3AD00693948 - _id_A1DFE9D4920A43FA, 1);
    waitframe();
  }

  scripts\mp\utility\dialog::leaderdialog("exfilend_enemy", scripts\mp\utility\game::getotherteam(winner)[0], "status");
  scripts\mp\utility\dialog::leaderdialog("exfilend_friendly", winner, "status");
}

switchtoexfilweapons(winner, _id_996EAC0D7F6FE3AB) {
  level waittill("extract_players_spawned");
  _id_C8A41AE10DD3B1D2 = scripts\mp\utility\game::getotherteam(winner)[0];

  if(_id_C8A41AE10DD3B1D2 != "tie") {
    foreach(_id_AC0E424AC96A7113 in level.players) {
      if(_id_AC0E424AC96A7113.team == _id_C8A41AE10DD3B1D2) {
        _id_AC0E424AC96A7113 takeallweapons();
        _id_AC0E424AC96A7113 scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_996EAC0D7F6FE3AB, undefined, undefined, 1);
        _id_AC0E424AC96A7113 thread switchtoexfilweapon(_id_996EAC0D7F6FE3AB);
        _id_AC0E424AC96A7113 scripts\mp\equipment::giveequipment("equip_throwing_knife", "primary");
      }
    }
  }
}

switchtoexfilweapon(_id_996EAC0D7F6FE3AB) {
  self endon("death_or_disconnect");
  self endon("end_switchToFists");

  while(scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(_id_996EAC0D7F6FE3AB, 1) == 0)
    waitframe();
}

onexfiltimelimit() {
  level.exfilactive = 0;

  if(level.exfilactive)
    level notify("exfil_continue_game_end");
}

onexfilsuccess(player) {
  level endon("game_ended");
  player.extracted = 1;
  player.spawnprotection = 1;
  player scripts\mp\lightarmor::setlightarmorvalue(player, 1000, undefined, 0);
  player _id_3B64EB40368C1450::_id_2D6E7E0B80767910("exfil_success", ["usability", "offhand_weapons", "killstreaks", "supers", "gesture", "weapon", "weapon_switch"]);
  player _id_3B64EB40368C1450::_id_3633B947164BE4F3("exfil_success", 0);
  player thread scripts\mp\hud_message::showsplash("callout_exfil_success");

  while(!player isonground())
    waitframe();

  player allowmovement(0);
  _id_3EBCC9541185A5EE = spawn("script_origin", player.origin);
  _id_3EBCC9541185A5EE setModel("tag_origin");
  player playerlinkTo(_id_3EBCC9541185A5EE);
  _id_3EBCC9541185A5EE moveTo(_id_3EBCC9541185A5EE.origin + (0, 0, 10000), 5, 2, 2);
}

stopunfillthread(time) {
  wait(time);
  self.exfilactive = 0;
}

assignhelitoexfilpoint(onhelikilled, _id_35E197DC52CE8AF9, team) {
  wait(_id_35E197DC52CE8AF9 + randomint(10));
  vehicle = level.players[0] _id_556596FE1CBE7D24::spawnextractchopper(self, self.origin, onhelikilled, 10 + _id_35E197DC52CE8AF9);
  vehicle playLoopSound("br_exfil_lbravo_engine_temp");
  colmodel = getEnt("clip64x64x256", "targetname");
  colmodelent = spawn("script_model", vehicle gettagorigin("tag_origin"));
  colmodelent dontinterpolate();
  colmodelent.angles = (-90, 0, 0);
  colmodelent clonebrushmodeltoscriptmodel(colmodel);
  _id_118E33B11DF01435 = anglesToForward(vehicle.angles * (1, 0, 0));
  _id_2B67713C58007394 = vectorNormalize(_id_118E33B11DF01435) * 85;
  colmodelent linkTo(vehicle, "tag_origin", _id_2B67713C58007394 + (0, 0, -60), colmodelent.angles);
  vehicle.colmodelent = colmodelent;
  vehicle sethoverparams(5, 10, 5);
  self.choppers[self.choppers.size] = vehicle;
  vehicle.extractzone = self;

  if(!isDefined(team))
    team = self.team;

  vehicle.team = team;
  vehicle.exfilspace = 6;
  vehicle.passengers[0] = self;
  vehicle.passengers[1] = self;
  vehicle.passengers[2] = self;
  vehicle.passengers[3] = self;
  vehicle.passengers[4] = self;
  vehicle.passengers[5] = self;
  self.curorigin = self.origin;
  self.offset3d = (0, 0, 30);
  vehicle init_useprompt_interactions();
  thread bugoutontimeout(vehicle);
  vehicle.scene_node = undefined;
  _id_CA85A0DE365C6A63 = undefined;
  vehicle thread exfilpilotactorthink(team, vehicle.scene_node, _id_CA85A0DE365C6A63);
}

createextractvfx() {
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), self.vfxent, "tag_origin");
}

exfilpilotactorthink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  level endon("game_ended");
  self.actors = thread spawnexfilpilotactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  scripts\common\anim::anim_first_frame(self.actors, "lbravo_exfil", "origin_animate_jnt");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\mp\utility\infilexfil::showactors();

  if(isDefined(self.path))
    exfilactorthinkpath(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  else
    exfilactorthinkanim(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
}

exfilactorthinkpath(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  thread exfilactorloopthink(self.actors[0]);
  thread exfilactorloopthink(self.actors[1]);
}

exfilactorloopthink(actor) {
  exfilactorloop(actor);
  scripts\common\anim::anim_single_solo(actor, "lbravo_exfil_loop_exit", "origin_animate_jnt");
}

exfilactorloop(actor) {
  self endon("unload");

  for(;;)
    scripts\common\anim::anim_single_solo(actor, "lbravo_exfil_loop", "origin_animate_jnt");
}

exfilactorthinkanim(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  thread scripts\common\anim::anim_single(self.actors, "lbravo_exfil", "origin_animate_jnt");
  duration = getanimlength(level.scr_anim["pilot"]["lbravo_exfil"]);
  wait(duration);

  foreach(actor in self.actors)
  actor delete();

  self.actors = undefined;
}

spawnexfilpilotactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  actors = [];
  actors[actors.size] = exfil_spawn_anim_model("pilot", "origin_animate_jnt", "fullbody_ppilot_crew_a");
  actors[actors.size] = exfil_spawn_anim_model("copilot", "origin_animate_jnt", "fullbody_ppilot_crew_a");

  foreach(actor in actors)
  actor.infil = self;

  return actors;
}

exfil_spawn_anim_model(animname, _id_0609C1B125A13456, body, head, weapon) {
  guy = spawn("script_model", (0, 0, 0));
  guy setModel(body);

  if(isDefined(head)) {
    _id_F4246828592F1C0F = spawn("script_model", (0, 0, 0));
    _id_F4246828592F1C0F setModel(head);
    _id_F4246828592F1C0F linkTo(guy, "j_spine4", (0, 0, 0), (0, 0, 0));
    guy.head = _id_F4246828592F1C0F;
    guy thread scripts\engine\utility::delete_on_death(_id_F4246828592F1C0F);
  }

  if(isDefined(weapon)) {
    _id_E71CCB5E6023BCDD = spawn("script_model", (0, 0, 0));
    _id_E71CCB5E6023BCDD setModel(weapon);
    _id_E71CCB5E6023BCDD linkTo(guy, "j_gun", (0, 0, 0), (0, 0, 0));
    guy thread scripts\engine\utility::delete_on_death(_id_E71CCB5E6023BCDD);
    guy.weapon = _id_E71CCB5E6023BCDD;
  }

  guy.animname = animname;
  guy scripts\common\anim::setanimtree();

  if(isDefined(_id_0609C1B125A13456)) {
    thread scripts\engine\utility::delete_on_death(guy);
    guy linkTo(self, _id_0609C1B125A13456, (0, 0, 0), (0, 0, 0));
  }

  return guy;
}

bugoutontimeout(heli) {
  level scripts\engine\utility::waittill_any_two("exfil_continue_game_end", "exfil_on_nuke_arrival");
  scripts\mp\objidpoolmanager::returnobjectiveid(self.exfilgoalent.exfilobjid);
  thread forcelinkgoaltriggerwatcher(heli);
  heli thread exfilleavesequence(heli.origin);
}

forcelinkgoaltriggerwatcher(heli) {
  level endon("game_ended");
  self notify("trigger_start");
  self endon("trigger_start");

  for(;;) {
    self waittill("trigger", player);

    if(player.team == self.exfilgoalent.team && !istrue(player.extracted)) {
      player thread playeranimlinktochopper(heli);
      heli.exfilspace--;

      if(heli.exfilspace <= 0) {
        break;
      }
    }
  }
}

exfilusetriggerused(player, _id_3BF097B42BACE3A4, _id_7838D4D4A6F522D6) {
  if(!isDefined(self.exfilspace))
    self.exfilspace = 6;

  if(self.exfilspace > 0) {
    playerlinktochopper(player, self, self.exfilspace);
    thread disableotherseats(player, _id_3BF097B42BACE3A4, _id_7838D4D4A6F522D6);
    self.exfilspace--;
  } else {
    thread exfilleavesequence();
    scripts\mp\objidpoolmanager::returnobjectiveid(self.extractzone.exfilgoalent.exfilobjid);
  }
}

waitforsquadthenleave(player) {
  _id_A6AB8D0FDA441DC2 = level.teamdata[player.team]["players"];

  foreach(_id_AC0E424AC96A7113 in _id_A6AB8D0FDA441DC2) {
    if(_id_AC0E424AC96A7113 != player) {
      _id_AC0E424AC96A7113 thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/GET_ON_CHOPPER", 10);
      continue;
    }

    _id_AC0E424AC96A7113 thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/CHOPPER_LEAVING_SOON", 10);
  }

  wait 10;
  thread exfilleavesequence(undefined, 1);
}

disableotherseats(player, _id_642F32D0CBB64C85, _id_7838D4D4A6F522D6) {
  foreach(interact in self.interactiontriggers)
  interact disableplayeruse(player);

  if(isDefined(_id_7838D4D4A6F522D6))
    player thread enableexitprompt(_id_642F32D0CBB64C85, self, _id_7838D4D4A6F522D6);
}

enableexitprompt(_id_642F32D0CBB64C85, vehicle, _id_7838D4D4A6F522D6) {
  interaction = spawn("script_model", self.origin);
  interaction setModel("tag_origin");
  interaction linkTo(self);
  interaction setHintString(&"MP/HOLD_TO_GET_OFF_CHOPPER");
  interaction setCursorHint("HINT_NOICON");
  interaction sethintdisplayrange(200);
  interaction sethintdisplayfov(90);
  interaction setuserange(200);
  interaction setusefov(360);
  interaction sethintonobstruction("hide");
  interaction setuseholdduration("duration_short");
  interaction thread exfil_hopoff_think(vehicle, self, _id_642F32D0CBB64C85, _id_7838D4D4A6F522D6);
  vehicle.exitinteract = interaction;
}

exfil_hopoff_think(vehicle, player, _id_642F32D0CBB64C85, _id_7838D4D4A6F522D6) {
  makechopperseatplayerusable(player);

  for(;;) {
    self waittill("trigger", player);
    self makeunusable();
    player stopanimscriptsceneevent();
    vehicle scripts\mp\anim::anim_player_solo(player, player.player_rig, "lbravo_exfil_loop_exit", "origin_animate_jnt");
    player.player_rig unlink();
    player unlink();
    _id_7838D4D4A6F522D6 makechopperseatteamusable(vehicle.team);

    foreach(interact in vehicle.interactiontriggers)
    interact enableplayeruse(player);

    vehicle notify("unloaded");
    self delete();
  }
}

playerlinktochopper(player, heli, _id_54100CA480291B0C) {
  level endon("game_ended");
  player.extracted = 1;
  player.spawnprotection = 1;
  player scripts\mp\lightarmor::setlightarmorvalue(player, 1000, undefined, 0);
  player thread scripts\mp\hud_message::showsplash("callout_exfil_success");

  while(!player isonground())
    waitframe();

  player allowmovement(0);
  player playerlinkTo(heli, "tag_passenger" + _id_54100CA480291B0C, 1.0, 180, -180, 180, 180, 0);
}

playeranimlinktochopper(exfil, _id_E4B9CD561C7C0DE6) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(!isDefined(_id_E4B9CD561C7C0DE6)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < exfil.passengers.size; _id_AC0E594AC96AA3A8++) {
      if(exfil.passengers[_id_AC0E594AC96AA3A8] == exfil.extractzone) {
        exfil.passengers[_id_AC0E594AC96AA3A8] = self;
        _id_E4B9CD561C7C0DE6 = _id_AC0E594AC96AA3A8;
      }
    }

    exfil thread disableotherseats(self);
  }

  thread scripts\mp\infilexfil\infilexfil::infil_player_rig("slot_" + _id_E4B9CD561C7C0DE6, "viewhands_base_iw8");
  self.player_rig linkTo(exfil, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));

  switch (_id_E4B9CD561C7C0DE6) {
    case 0:
      self lerpviewangleclamp(1, 0.25, 0.25, 35, 180, 90, 45);
      break;
    case 1:
      self lerpviewangleclamp(1, 0.25, 0.25, 180, 35, 90, 45);
      break;
    case 4:
    case 2:
      self lerpviewangleclamp(1, 0.25, 0.25, 75, 135, 90, 45);
      break;
    case 5:
    case 3:
      self lerpviewangleclamp(1, 0.25, 0.25, 135, 45, 90, 45);
      break;
    default:
      self lerpviewangleclamp(1, 0.25, 0.25, 45, 45, 45, 45);
      break;
  }

  level endon("game_ended");
  self.extracted = 1;
  self.spawnprotection = 1;
  scripts\mp\lightarmor::setlightarmorvalue(self, 1000, undefined, 0);
  rideloop(exfil);
}

rideloop(exfil) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  exfil endon("unload");

  while(isDefined(exfil))
    exfil scripts\mp\anim::anim_player_solo(self, self.player_rig, "lbravo_exfil_loop", "origin_animate_jnt");
}

exfilleavesequence(_id_37C1299E74AAA6E7, endgame) {
  if(isDefined(self.exitinteract))
    self.exitinteract makeunusable();

  thread _id_556596FE1CBE7D24::littlebirdleave();
  playannouncerbattlechatter(self.team, "extract_littlebird_leaving_a_friendly", 10);
  thread doexfilsplashforpassengers();

  if(isDefined(level.onexfilfinishedcallback))
    self[[level.onexfilfinishedcallback]](_id_37C1299E74AAA6E7);

  if(isDefined(endgame))
    waitthenendgame(self.team);
}

waitthenendgame(_id_EC15CE3E7A9D1D86) {
  wait 5;
  thread scripts\mp\gamelogic::endgame(_id_EC15CE3E7A9D1D86, game["end_reason"]["objective_completed"]);
}

doexfilsplashforpassengers() {
  wait 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.passengers.size; _id_AC0E594AC96AA3A8++) {
    if(self.passengers[_id_AC0E594AC96AA3A8] != self.extractzone)
      self.passengers[_id_AC0E594AC96AA3A8] thread scripts\mp\hud_message::showsplash("callout_exfil_success");
  }
}

init_useprompt_interactions(player) {
  self.interactiontriggers = [];
  _id_5CAA739F456ADF7C = self gettagorigin("tag_passenger1");
  _id_5CAA769F456AE615 = self gettagorigin("tag_passenger2");
  _id_5CAA759F456AE3E2 = self gettagorigin("tag_passenger3");
  _id_5CAA709F456AD8E3 = self gettagorigin("tag_passenger4");
  _id_5CAA6F9F456AD6B0 = self gettagorigin("tag_passenger5");
  _id_5CAA729F456ADD49 = self gettagorigin("tag_passenger6");
  create_exfil_interaction(_id_5CAA739F456ADF7C, &"MP/HOLD_TO_GET_ON_CHOPPER", 0, player);
  create_exfil_interaction(_id_5CAA769F456AE615, &"MP/HOLD_TO_GET_ON_CHOPPER", 2, player);
  create_exfil_interaction(_id_5CAA759F456AE3E2, &"MP/HOLD_TO_GET_ON_CHOPPER", 4, player);
  create_exfil_interaction(_id_5CAA709F456AD8E3, &"MP/HOLD_TO_GET_ON_CHOPPER", 1, player);
  create_exfil_interaction(_id_5CAA6F9F456AD6B0, &"MP/HOLD_TO_GET_ON_CHOPPER", 3, player);
  create_exfil_interaction(_id_5CAA729F456ADD49, &"MP/HOLD_TO_GET_ON_CHOPPER", 5, player);
}

create_exfil_interaction(loc, hintstring, _id_3BF097B42BACE3A4, player) {
  interaction = spawn("script_model", loc);
  interaction setModel("tag_origin");
  interaction linkTo(self);
  interaction setHintString(hintstring);
  interaction setCursorHint("HINT_BUTTON");
  interaction sethintdisplayrange(200);
  interaction sethintdisplayfov(90);
  interaction setuserange(72);
  interaction setusefov(90);
  interaction sethintonobstruction("hide");
  interaction setuseholdduration("duration_short");
  interaction thread exfil_use_think(self, _id_3BF097B42BACE3A4, player);
  self.interactiontriggers[self.interactiontriggers.size] = interaction;
}

exfil_use_think(vehicle, _id_3BF097B42BACE3A4, player) {
  if(isDefined(player))
    makechopperseatplayerusable(player);
  else
    makechopperseatteamusable(vehicle.team);

  for(;;) {
    self waittill("trigger", player);
    self makeunusable();
    vehicle exfilusetriggerused(player, _id_3BF097B42BACE3A4, self);
  }
}

makechopperseatteamusable(team) {
  self makeusable();
  thread _updatechopperseatteamusable(team);
}

makechopperseatplayerusable(player) {
  self makeusable();
  thread _updatechopperseatplayerusable(player);
}

_updatechopperseatteamusable(team) {
  self endon("death");

  for(;;) {
    foreach(player in level.players) {
      if(player.team == team) {
        self showtoplayer(player);
        self enableplayeruse(player);
        continue;
      }

      self disableplayeruse(player);
      self hidefromplayer(player);
    }

    level waittill("joined_team");
  }
}

_updatechopperseatplayerusable(_id_FBA0376E0036DE8D) {
  self endon("death");

  for(;;) {
    foreach(player in level.players) {
      if(player == _id_FBA0376E0036DE8D) {
        self showtoplayer(player);
        self enableplayeruse(player);
        continue;
      }

      self disableplayeruse(player);
      self hidefromplayer(player);
    }

    level waittill("joined_team");
  }
}

playannouncerbattlechatter(team, _id_CB3339ECE72DBDEB, _id_0E4731409BD255E0) {
  level endon("game_ended");
  faction = "ustl";
  soundalias = "dx_mpa_" + faction + "_" + _id_CB3339ECE72DBDEB + "_" + _id_0E4731409BD255E0;

  if(soundexists(soundalias)) {
    foreach(player in level.players) {
      if(player.team == team)
        player queuedialogforplayer(soundalias, _id_CB3339ECE72DBDEB, 2);
    }
  }
}

votimeendingsoon() {
  level endon("game_ended");
  level waittill("match_ending_very_soon");
  playannouncerbattlechatter(game["attackers"], "extract_littlebird_leaving_soon_a_friendly", 10);
}

commander_play_sound_func(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self.infil.players)
  self playsoundtoplayer(alias, player);
}

script_model_exfil_anims() {}