/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\exfil.gsc
***********************************************/

function exfilinit() {
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
}

function onexfilstart(var_0, var_1, var_2, var_3) {
  level.getexfilloccallback = var_1;
  level.onexfilfinishedcallback = var_2;
  level.onexfilkilledcallback = var_3;
  level.exfilgoaltrigger = getEnt(var_0 + "_exfil_trigger", "targetname");
  level.exfilstarted = 1;

  if(isDefined(level.onexfilstarted)) {
    [[level.onexfilstarted]]();
  }

  if(isDefined(level.objectives) && level.objectives.size > 0) {
    thread removeallobjids();
  }

  level.ignorescoring = 1;
  scripts\mp\gamelogic::resumetimer();
  level.starttime = gettime();
  level.discardtime = 0;
  level.timerpausetime = 0;
  var_4 = level.exfilactivetimer + level.exfilextracttimer;
  var_5 = "scr_" + scripts\mp\utility\game::getgametype() + "_timelimit";
  level.watchdvars[var_5].value = var_4;
  level.overridewatchdvars[var_5] = var_4;
  runexfil(var_0, var_3);
}

function removeallobjids() {
  foreach(var_1 in level.objectives) {
    if(isDefined(var_1.objidnum)) {
      var_1 scripts\mp\gameobjects::releaseid();
    }

    if(isDefined(var_1.trigger) && isDefined(var_1.trigger.objidnum)) {
      var_1.trigger scripts\mp\gameobjects::releaseid();
    }
  }
}

function runexfil(var_0, var_1) {
  level thread scripts\mp\hud_message::notifyteam("callout_exfil_winners", "callout_exfil_losers", var_0);
  thread spawnexfilzone(level);
  thread spawnexfilplayers(level);
  scripts\mp\utility\dialog::leaderdialog("enemy_exfil", scripts\mp\utility\game::getotherteam(var_0)[0], "status");
  scripts\mp\utility\dialog::leaderdialog("friendly_exfil", var_0, "status");
  level.timelimitoverride = 0;
  wait 1;
  level.ontimelimit = &onexfiltimelimit;
}

function spawnexfilplayers(var_0) {
  var_1 = "scr_" + scripts\mp\utility\game::getgametype() + "_numlives";
  level.watchdvars[var_1].value = 1;
  level.overridewatchdvars[var_1] = 1;
  level notify("extract_players_spawned");
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_0, 8, 7);
}

function skipkillcamandspawn() {
  self notify("abort_killcam");
  self.cancelkillcam = 1;
  waitframe();
  thread scripts\mp\playerlogic::spawnplayer(0, 1);

  if(scripts\mp\utility\game::isteamreviveenabled() && isDefined(level.revivetriggers[self.guid])) {
    level.revivetriggers[self.guid].victim thread scripts\mp\teamrevive::removetrigger(level.revivetriggers[self.guid].victim.guid);
    return;
  }
}

function spawnexfilzone(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(!isDefined(level.exfilgoaltrigger)) {
    var_2 = getEntArray("flag_primary", "targetname");
    var_3 = [];

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_3 = var_2[var_4];
    }

    foreach(var_6 in var_3) {
      if(var_6.script_label == "_b") {
        var_6.script_label = "_b";
        level.exfilgoaltrigger = var_6;

        if(!isDefined(level.exfilgoaltrigger)) {
          level notify("exfil_continue_game_end");
          return;
        }
      }
    }
  }

  level.exfilgoalent = spawn("script_model", level.exfilgoaltrigger.origin);
  level.exfilgoalent.angles = (0, 270, 0);
  level.exfilgoalent.team = var_1;
  level.exfilgoalent.visibleteam = "any";
  level.exfilgoalent.ownerteam = var_1;
  level.exfilgoalent.type = "";
  var_8 = level.exfilgoaltrigger.origin;
  var_9 = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 1, 1);
  var_10 = [];
  var_11 = scripts\engine\trace::ray_trace(level.exfilgoalent.origin + (0, 0, 20), level.exfilgoalent.origin - (0, 0, 4000), var_10, var_9, 0);

  if(isPlayer(var_11["entity"])) {
    var_11["entity"] = undefined;
  }

  if(isDefined(var_11)) {
    var_12 = randomfloat(360);
    var_13 = var_11["position"];

    if(isDefined(self.visualgroundoffset)) {
      var_13 += self.visualgroundoffset;
    }

    var_14 = (cos(var_12), sin(var_12), 0);
    var_14 = vectorNormalize(var_14 - var_11["normal"] * vectordot(var_14, var_11["normal"]));
    var_15 = vectortoangles(var_14);
    level.exfilgoalent.origin = var_13;
    level.exfilgoalent setModel("cop_marker_scriptable");
    level.exfilgoalent setscriptablepartstate("marker", "red");
    level.exfilgoalent playLoopSound("mp_flare_burn_lp");
  }

  thread goaltriggerwatcher(level.exfilgoaltrigger);
  level.exfilobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(level.exfilobjid != -1) {
    var_16 = "current";
    scripts\mp\objidpoolmanager::objective_add_objective(level.exfilobjid, var_16, level.exfilgoaltrigger.origin + (0, 0, 60));
    scripts\mp\objidpoolmanager::objective_set_play_intro(level.exfilobjid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_outro(level.exfilobjid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(level.exfilobjid);
    self.showworldicon = 1;
  }

  level.exfilgoalent scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil", level.exfilobjid);
  objective_sethot(level.exfilobjid, 1);
  thread watchforexfilactive(level);
  waitframe();
  playFXOnTag(level._effect["vfx_smk_signal"], level.exfilgoalent, "tag_origin");
}

function goaltriggerwatcher(var_0) {
  level endon("game_ended");
  self notify("trigger_start");
  self endon("trigger_start");
  level waittill("extract_trigger_active");

  for(;;) {
    self waittill("trigger", var_0);

    if(var_0.team == level.exfilgoalent.team && !istrue(var_0.extracted)) {
      thread onexfilsuccess(level);
    }
  }
}

function watchforexfilactive(var_0) {
  level endon("game_ended");
  thread runexfilnotactivefill(level);
  thread runexfilwaitactiveunfill(level);
  var_1 = level.exfilactivetimer;
  wait var_1;
  level.exfilnotactive = 0;
  level notify("extract_trigger_active");
  level.exfilgoalent scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil", level.exfilobjid);
}

function runexfilnotactivefill(var_0) {
  level endon("game_ended");
  level.exfilnotactive = 1;
  var_1 = level.framedurationseconds;
  var_2 = var_1 * 1000;
  var_3 = level.exfilactivetimer;
  var_3 *= 1000;
  var_4 = var_2;

  while(level.exfilnotactive) {
    if(var_4 != 0) {
      var_5 = min(var_4 / var_3, 1);
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.exfilobjid, undefined);
      scripts\mp\objidpoolmanager::objective_show_progress(self.exfilobjid, 1);
      scripts\mp\objidpoolmanager::objective_set_progress(self.exfilobjid, var_5);
      var_4 = min(var_4 + var_2, var_3);
    }

    waitframe();
  }

  scripts\mp\utility\dialog::leaderdialog("exfilarrive_enemy", scripts\mp\utility\game::getotherteam(var_0)[0], "status");
  scripts\mp\utility\dialog::leaderdialog("exfilarrive_friendly", var_0, "status");
}

function runexfilwaitactiveunfill(var_0) {
  level endon("game_ended");
  level waittill("extract_trigger_active");
  level.exfilactive = 1;
  var_1 = level.framedurationseconds;
  var_2 = var_1 * 1000;
  var_3 = level.exfilextracttimer;
  var_3 *= 1000;
  var_4 = var_3 - var_2;

  while(level.exfilactive) {
    var_5 = var_4 / var_3;
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.exfilobjid, scripts\mp\utility\game::getotherteam(var_0)[0]);
    scripts\mp\objidpoolmanager::objective_show_progress(self.exfilobjid, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.exfilobjid, var_5);
    var_4 = max(var_4 - var_2, 1);
    waitframe();
  }

  scripts\mp\utility\dialog::leaderdialog("exfilend_enemy", scripts\mp\utility\game::getotherteam(var_0)[0], "status");
  scripts\mp\utility\dialog::leaderdialog("exfilend_friendly", var_0, "status");
}

function switchtoexfilweapons(var_0, var_1) {
  level waittill("extract_players_spawned");
  var_2 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(var_2 != "tie") {
    foreach(var_4 in level.players) {
      if(var_4.team == var_2) {
        var_4 takeallweapons();
        var_4 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
        thread switchtoexfilweapon(var_4);
        var_4 scripts\mp\equipment::giveequipment("equip_throwing_knife", "primary");
      }
    }

    return;
  }
}

function switchtoexfilweapon(var_0) {
  self endon("death_or_disconnect");
  self endon("end_switchToFists");

  while(scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1) == 0) {
    waitframe();
  }
}

function onexfiltimelimit() {
  level.exfilactive = 0;

  if(level.exfilactive) {
    level notify("exfil_continue_game_end");
    return;
  }
}

function onexfilsuccess(var_0) {
  level endon("game_ended");
  var_0.extracted = 1;
  var_0.spawnprotection = 1;
  var_0 scripts\mp\lightarmor::setlightarmorvalue(var_0, 1000, undefined, 0);
  var_0 scripts\mp\playeractions::registeractionset("exfil_success", ["usability", "offhand_weapons", "killstreaks", "supers", "gesture", "weapon", "weapon_switch"]);
  var_0 scripts\mp\playeractions::allowactionset("exfil_success", 0);
  var_0 thread scripts\mp\hud_message::showsplash("callout_exfil_success");

  while(!var_0 isonground()) {
    waitframe();
  }

  var_0 allowmovement(0);
  var_1 = spawn("script_origin", var_0.origin);
  var_1 setModel("tag_origin");
  var_0 playerlinkTo(var_1);
  var_1 moveTo(var_1.origin + (0, 0, 10000), 5, 2, 2);
}

function stopunfillthread(var_0) {
  wait var_0;
  self.exfilactive = 0;
}

function assignhelitoexfilpoint(var_0, var_1, var_2) {
  wait var_1 + randomint(10);
  var_3 = level.players[0] scripts\mp\gametypes\br_extract_chopper::spawnextractchopper(self, self.origin, var_0, 10 + var_1);
  var_3 playLoopSound("br_exfil_lbravo_engine_temp");
  var_4 = getEnt("clip64x64x256", "targetname");
  var_5 = spawn("script_model", var_3 gettagorigin("tag_origin"));
  var_5 dontinterpolate();
  var_5.angles = (-90, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = anglesToForward(var_3.angles * (1, 0, 0));
  var_7 = vectorNormalize(var_6) * 85;
  var_5 linkTo(var_3, "tag_origin", var_7 + (0, 0, -60), var_5.angles);
  var_3.colmodelent = var_5;
  var_3 sethoverparams(5, 10, 5);
  self.choppers[self.choppers.size] = var_3;
  var_3.extractzone = self;

  if(!isDefined(var_2)) {
    var_2 = self.team;
  }

  var_3.team = var_2;
  var_3.exfilspace = 6;
  var_3.passengers[0] = self;
  var_3.passengers[1] = self;
  var_3.passengers[2] = self;
  var_3.passengers[3] = self;
  var_3.passengers[4] = self;
  var_3.passengers[5] = self;
  self.curorigin = self.origin;
  self.offset3d = (0, 0, 30);
  init_useprompt_interactions(var_3);
  thread bugoutontimeout(var_3);
  var_3.scene_node = undefined;
  var_8 = undefined;
  thread exfilpilotactorthink(var_3, var_2, var_3.scene_node);
}

function createextractvfx() {
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), self.vfxent, "tag_origin");
}

function exfilpilotactorthink(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self.actors = thread spawnexfilpilotactors(var_0, var_2, var_3);
  scripts\common\anim::anim_first_frame(self.actors, "lbravo_exfil", "origin_animate_jnt");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\mp\utility\infilexfil::showactors();

  if(isDefined(self.path)) {
    exfilactorthinkpath(var_0, var_1, var_2, var_3);
    return;
  }

  exfilactorthinkanim(var_0, var_1, var_2, var_3);
}

function exfilactorthinkpath(var_0, var_1, var_2, var_3) {
  thread exfilactorloopthink(self.actors[0]);
  thread exfilactorloopthink(self.actors[1]);
}

function exfilactorloopthink(var_0) {
  exfilactorloop(var_0);
  scripts\common\anim::anim_single_solo(var_0, "lbravo_exfil_loop_exit", "origin_animate_jnt");
}

function exfilactorloop(var_0) {
  self endon("unload");

  for(;;) {
    scripts\common\anim::anim_single_solo(var_0, "lbravo_exfil_loop", "origin_animate_jnt");
  }
}

function exfilactorthinkanim(var_0, var_1, var_2, var_3) {
  thread scripts\common\anim::anim_single(self.actors, "lbravo_exfil", "origin_animate_jnt");
  var_4 = getanimlength(level.scr_anim["pilot"]["lbravo_exfil"]);
  wait var_4;

  foreach(var_6 in self.actors) {
    var_6 delete();
  }

  self.actors = undefined;
}

function spawnexfilpilotactors(var_0, var_1, var_2) {
  var_3 = [];
  GscBinSkip0(0x2e, var_3.size, exfil_spawn_anim_model("pilot", "origin_animate_jnt", "fullbody_ppilot_crew_a"));
}

function exfil_spawn_anim_model(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", (0, 0, 0));
  var_5 setModel(var_2);

  if(isDefined(var_3)) {
    var_6 = spawn("script_model", (0, 0, 0));
    var_6 setModel(var_3);
    var_6 linkTo(var_5, "j_spine4", (0, 0, 0), (0, 0, 0));
    var_5.head = var_6;
    var_5 thread scripts\engine\utility::delete_on_death(var_6);
  }

  if(isDefined(var_4)) {
    var_7 = spawn("script_model", (0, 0, 0));
    var_7 setModel(var_4);
    var_7 linkTo(var_5, "j_gun", (0, 0, 0), (0, 0, 0));
    var_5 thread scripts\engine\utility::delete_on_death(var_7);
    var_5.weapon = var_7;
  }

  var_5.animname = var_0;
  var_5 scripts\common\anim::setanimtree();

  if(isDefined(var_1)) {
    thread scripts\engine\utility::delete_on_death(var_5);
    var_5 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_5;
}

function bugoutontimeout(var_0) {
  level scripts\engine\utility::waittill_any_two("exfil_continue_game_end", "exfil_on_nuke_arrival");
  scripts\mp\objidpoolmanager::returnobjectiveid(self.exfilgoalent.exfilobjid);
  thread forcelinkgoaltriggerwatcher(var_0);
  thread exfilleavesequence(var_0);
}

function forcelinkgoaltriggerwatcher(var_0) {
  level endon("game_ended");
  self notify("trigger_start");
  self endon("trigger_start");

  for(;;) {
    self waittill("trigger", var_1);
    jumpiffalse(var_1.team == self.exfilgoalent.team && !istrue(var_1.extracted)) LOC_00000069;
    thread playeranimlinktochopper(var_1);
    var_0.exfilspace--;
  }
}

function exfilusetriggerused(var_0, var_1, var_2) {
  if(!isDefined(self.exfilspace)) {
    self.exfilspace = 6;
  }

  if(self.exfilspace > 0) {
    playerlinktochopper(var_0, self, self.exfilspace);
    thread disableotherseats(var_0, var_1, var_2);
    self.exfilspace--;
    return;
  }

  thread exfilleavesequence();
  scripts\mp\objidpoolmanager::returnobjectiveid(self.extractzone.exfilgoalent.exfilobjid);
}

function waitforsquadthenleave(var_0) {
  var_1 = level.teamdata[var_0.team]["players"];

  foreach(var_3 in var_1) {
    if(var_3 != var_0) {
      var_3 thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/GET_ON_CHOPPER", 10);
      continue;
    }

    var_3 thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/CHOPPER_LEAVING_SOON", 10);
  }

  wait 10;
  thread exfilleavesequence(undefined, 1);
}

function disableotherseats(var_0, var_1, var_2) {
  foreach(var_4 in self.interactiontriggers) {
    var_4 disableplayeruse(var_0);
  }

  if(isDefined(var_2)) {
    thread enableexitprompt(var_0, var_1, self);
    return;
  }
}

function enableexitprompt(var_0, var_1, var_2) {
  var_3 = spawn("script_model", self.origin);
  var_3 setModel("tag_origin");
  var_3 linkTo(self);
  var_3 setHintString(&"MP/HOLD_TO_GET_OFF_CHOPPER");
  var_3 setCursorHint("HINT_NOICON");
  var_3 sethintdisplayrange(200);
  var_3 sethintdisplayfov(90);
  var_3 setuserange(200);
  var_3 setusefov(360);
  var_3 sethintonobstruction("hide");
  var_3 setuseholdduration("duration_short");
  thread exfil_hopoff_think(var_3, var_1, self, var_0);
  var_1.exitinteract = var_3;
}

function exfil_hopoff_think(var_0, var_1, var_2, var_3) {
  makechopperseatplayerusable(var_1);

  for(;;) {
    self waittill("trigger", var_1);
    self makeunusable();
    var_1 stopanimscriptsceneevent();
    var_0 scripts\mp\anim::anim_player_solo(var_1, var_1.player_rig, "lbravo_exfil_loop_exit", "origin_animate_jnt");
    var_1.player_rig unlink();
    var_1 unlink();
    makechopperseatteamusable(var_3, var_0.team);

    foreach(var_5 in var_0.interactiontriggers) {
      var_5 enableplayeruse(var_1);
    }

    var_0 notify("unloaded");
    self delete();
  }
}

function playerlinktochopper(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0.extracted = 1;
  var_0.spawnprotection = 1;
  var_0 scripts\mp\lightarmor::setlightarmorvalue(var_0, 1000, undefined, 0);
  var_0 thread scripts\mp\hud_message::showsplash("callout_exfil_success");

  while(!var_0 isonground()) {
    waitframe();
  }

  var_0 allowmovement(0);
  var_0 playerlinkTo(var_1, "tag_passenger" + var_2, 1, 180, -180, 180, 180, 0);
}

function playeranimlinktochopper(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(!isDefined(var_1)) {
    for(var_2 = 0; var_2 < var_0.passengers.size; var_2++) {
      if(var_0.passengers[var_2] == var_0.extractzone) {
        var_0.passengers[var_2] = self;
        var_1 = var_2;
      }
    }

    thread disableotherseats(var_0);
  }

  thread scripts\mp\infilexfil\infilexfil::infil_player_rig("slot_" + var_1, "viewhands_base_iw8");
  self.player_rig linkTo(var_0, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));

  switch (var_1) {
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
  rideloop(var_0);
}

function rideloop(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  var_0 endon("unload");

  while(isDefined(var_0)) {
    var_0 scripts\mp\anim::anim_player_solo(self, self.player_rig, "lbravo_exfil_loop", "origin_animate_jnt");
  }
}

function exfilleavesequence(var_0, var_1) {
  if(isDefined(self.exitinteract)) {
    self.exitinteract makeunusable();
  }

  thread scripts\mp\gametypes\br_extract_chopper::littlebirdleave();
  playannouncerbattlechatter(self.team, "extract_littlebird_leaving_a_friendly", 10);
  thread doexfilsplashforpassengers();

  if(isDefined(level.onexfilfinishedcallback)) {
    self[[level.onexfilfinishedcallback]](var_0);
  }

  if(isDefined(var_1)) {
    waitthenendgame(self.team);
    return;
  }
}

function waitthenendgame(var_0) {
  wait 5;
  thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["objective_completed"]);
}

function doexfilsplashforpassengers() {
  wait 1;

  for(var_0 = 0; var_0 < self.passengers.size; var_0++) {
    if(self.passengers[var_0] != self.extractzone) {
      self.passengers[var_0] thread scripts\mp\hud_message::showsplash("callout_exfil_success");
    }
  }
}

function init_useprompt_interactions(var_0) {
  self.interactiontriggers = [];
  var_1 = self gettagorigin("tag_passenger1");
  var_2 = self gettagorigin("tag_passenger2");
  var_3 = self gettagorigin("tag_passenger3");
  var_4 = self gettagorigin("tag_passenger4");
  var_5 = self gettagorigin("tag_passenger5");
  var_6 = self gettagorigin("tag_passenger6");
  create_exfil_interaction(var_1, &"MP/HOLD_TO_GET_ON_CHOPPER", 0, var_0);
  create_exfil_interaction(var_2, &"MP/HOLD_TO_GET_ON_CHOPPER", 2, var_0);
  create_exfil_interaction(var_3, &"MP/HOLD_TO_GET_ON_CHOPPER", 4, var_0);
  create_exfil_interaction(var_4, &"MP/HOLD_TO_GET_ON_CHOPPER", 1, var_0);
  create_exfil_interaction(var_5, &"MP/HOLD_TO_GET_ON_CHOPPER", 3, var_0);
  create_exfil_interaction(var_6, &"MP/HOLD_TO_GET_ON_CHOPPER", 5, var_0);
}

function create_exfil_interaction(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0);
  var_4 setModel("tag_origin");
  var_4 linkTo(self);
  var_4 setHintString(var_1);
  var_4 setCursorHint("HINT_BUTTON");
  var_4 sethintdisplayrange(200);
  var_4 sethintdisplayfov(90);
  var_4 setuserange(72);
  var_4 setusefov(90);
  var_4 sethintonobstruction("hide");
  var_4 setuseholdduration("duration_short");
  thread exfil_use_think(var_4, self, var_2);
  self.interactiontriggers[self.interactiontriggers.size] = var_4;
}

function exfil_use_think(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    makechopperseatplayerusable(var_2);
  } else {
    makechopperseatteamusable(var_0.team);
  }

  for(;;) {
    self waittill("trigger", var_2);
    self makeunusable();
    exfilusetriggerused(var_0, var_2, var_1, self);
  }
}

function makechopperseatteamusable(var_0) {
  self makeusable();
  thread _updatechopperseatteamusable(var_0);
}

function makechopperseatplayerusable(var_0) {
  self makeusable();
  thread _updatechopperseatplayerusable(var_0);
}

function _updatechopperseatteamusable(var_0) {
  self endon("death");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self showtoplayer(var_2);
        self enableplayeruse(var_2);
        continue;
      }

      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }

    level waittill("joined_team");
  }
}

function _updatechopperseatplayerusable(var_0) {
  self endon("death");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2 == var_0) {
        self showtoplayer(var_2);
        self enableplayeruse(var_2);
        continue;
      }

      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }

    level waittill("joined_team");
  }
}

function playannouncerbattlechatter(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = "ustl";
  var_4 = "dx_mpa_" + var_3 + "_" + var_1 + "_" + var_2;

  if(soundexists(var_4)) {
    foreach(var_6 in level.players) {
      if(var_6.team == var_0) {
        var_6 queuedialogforplayer(var_4, var_1, 2);
      }
    }

    return;
  }
}

function votimeendingsoon() {
  level endon("game_ended");
  level waittill("match_ending_very_soon");
  playannouncerbattlechatter(game["attackers"], "extract_littlebird_leaving_soon_a_friendly", 10);
}

function commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players) {
    self playsoundtoplayer(var_0, var_4);
  }
}

function script_model_exfil_anims() {}