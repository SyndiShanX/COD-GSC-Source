/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\exfil.gsc
***********************************************/

function exfilinit() {
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
}

function onexfilstart(var0, var1, var2, var3) {
  level.getexfilloccallback = var1;
  level.onexfilfinishedcallback = var2;
  level.onexfilkilledcallback = var3;
  level.exfilgoaltrigger = getEnt(var0 + "_exfil_trigger", "targetname");
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
  var4 = level.exfilactivetimer + level.exfilextracttimer;
  var5 = "scr_" + scripts\mp\utility\game::getgametype() + "_timelimit";
  level.watchdvars[var5].value = var4;
  level.overridewatchdvars[var5] = var4;
  runexfil(var0, var3);
}

function removeallobjids() {
  foreach(var1 in level.objectives) {
    if(isDefined(var1.objidnum)) {
      var1 scripts\mp\gameobjects::releaseid();
    }

    if(isDefined(var1.trigger) && isDefined(var1.trigger.objidnum)) {
      var1.trigger scripts\mp\gameobjects::releaseid();
    }
  }
}

function runexfil(var0, var1) {
  level thread scripts\mp\hud_message::notifyteam("callout_exfil_winners", "callout_exfil_losers", var0);
  thread spawnexfilzone(level);
  thread spawnexfilplayers(level);
  scripts\mp\utility\dialog::leaderdialog("enemy_exfil", scripts\mp\utility\game::getotherteam(var0)[0], "status");
  scripts\mp\utility\dialog::leaderdialog("friendly_exfil", var0, "status");
  level.timelimitoverride = 0;
  wait 1;
  level.ontimelimit = &onexfiltimelimit;
}

function spawnexfilplayers(var0) {
  var1 = "scr_" + scripts\mp\utility\game::getgametype() + "_numlives";
  level.watchdvars[var1].value = 1;
  level.overridewatchdvars[var1] = 1;
  level notify("extract_players_spawned");
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var0, 8, 7);
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

function spawnexfilzone(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = scripts\mp\utility\game::getotherteam(var0)[0];

  if(!isDefined(level.exfilgoaltrigger)) {
    var2 = getEntArray("flag_primary", "targetname");
    var3 = [];

    for(var4 = 0; var4 < var2.size; var4++) {
      var3 = var2[var4];
    }

    foreach(var6 in var3) {
      if(var6.script_label == "_b") {
        var6.script_label = "_b";
        level.exfilgoaltrigger = var6;

        if(!isDefined(level.exfilgoaltrigger)) {
          level notify("exfil_continue_game_end");
          return;
        }
      }
    }
  }

  level.exfilgoalent = spawn("script_model", level.exfilgoaltrigger.origin);
  level.exfilgoalent.angles = (0, 270, 0);
  level.exfilgoalent.team = var1;
  level.exfilgoalent.visibleteam = "any";
  level.exfilgoalent.ownerteam = var1;
  level.exfilgoalent.type = "";
  var8 = level.exfilgoaltrigger.origin;
  var9 = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 1, 1);
  var10 = [];
  var11 = scripts\engine\trace::ray_trace(level.exfilgoalent.origin + (0, 0, 20), level.exfilgoalent.origin - (0, 0, 4000), var10, var9, 0);

  if(isPlayer(var11["entity"])) {
    var11["entity"] = undefined;
  }

  if(isDefined(var11)) {
    var12 = randomfloat(360);
    var13 = var11["position"];

    if(isDefined(self.visualgroundoffset)) {
      var13 += self.visualgroundoffset;
    }

    var14 = (cos(var12), sin(var12), 0);
    var14 = vectorNormalize(var14 - var11["normal"] * vectordot(var14, var11["normal"]));
    var15 = vectortoangles(var14);
    level.exfilgoalent.origin = var13;
    level.exfilgoalent setModel("cop_marker_scriptable");
    level.exfilgoalent setscriptablepartstate("marker", "red");
    level.exfilgoalent playLoopSound("mp_flare_burn_lp");
  }

  thread goaltriggerwatcher(level.exfilgoaltrigger);
  level.exfilobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(level.exfilobjid != -1) {
    var16 = "current";
    scripts\mp\objidpoolmanager::objective_add_objective(level.exfilobjid, var16, level.exfilgoaltrigger.origin + (0, 0, 60));
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

function goaltriggerwatcher(var0) {
  level endon("game_ended");
  self notify("trigger_start");
  self endon("trigger_start");
  level waittill("extract_trigger_active");

  for(;;) {
    self waittill("trigger", var0);

    if(var0.team == level.exfilgoalent.team && !istrue(var0.extracted)) {
      thread onexfilsuccess(level);
    }
  }
}

function watchforexfilactive(var0) {
  level endon("game_ended");
  thread runexfilnotactivefill(level);
  thread runexfilwaitactiveunfill(level);
  var1 = level.exfilactivetimer;
  wait var1;
  level.exfilnotactive = 0;
  level notify("extract_trigger_active");
  level.exfilgoalent scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil", level.exfilobjid);
}

function runexfilnotactivefill(var0) {
  level endon("game_ended");
  level.exfilnotactive = 1;
  var1 = level.framedurationseconds;
  var2 = var1 * 1000;
  var3 = level.exfilactivetimer;
  var3 *= 1000;
  var4 = var2;

  while(level.exfilnotactive) {
    if(var4 != 0) {
      var5 = min(var4 / var3, 1);
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.exfilobjid, undefined);
      scripts\mp\objidpoolmanager::objective_show_progress(self.exfilobjid, 1);
      scripts\mp\objidpoolmanager::objective_set_progress(self.exfilobjid, var5);
      var4 = min(var4 + var2, var3);
    }

    waitframe();
  }

  scripts\mp\utility\dialog::leaderdialog("exfilarrive_enemy", scripts\mp\utility\game::getotherteam(var0)[0], "status");
  scripts\mp\utility\dialog::leaderdialog("exfilarrive_friendly", var0, "status");
}

function runexfilwaitactiveunfill(var0) {
  level endon("game_ended");
  level waittill("extract_trigger_active");
  level.exfilactive = 1;
  var1 = level.framedurationseconds;
  var2 = var1 * 1000;
  var3 = level.exfilextracttimer;
  var3 *= 1000;
  var4 = var3 - var2;

  while(level.exfilactive) {
    var5 = var4 / var3;
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.exfilobjid, scripts\mp\utility\game::getotherteam(var0)[0]);
    scripts\mp\objidpoolmanager::objective_show_progress(self.exfilobjid, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.exfilobjid, var5);
    var4 = max(var4 - var2, 1);
    waitframe();
  }

  scripts\mp\utility\dialog::leaderdialog("exfilend_enemy", scripts\mp\utility\game::getotherteam(var0)[0], "status");
  scripts\mp\utility\dialog::leaderdialog("exfilend_friendly", var0, "status");
}

function switchtoexfilweapons(var0, var1) {
  level waittill("extract_players_spawned");
  var2 = scripts\mp\utility\game::getotherteam(var0)[0];

  if(var2 != "tie") {
    foreach(var4 in level.players) {
      if(var4.team == var2) {
        var4 takeallweapons();
        var4 scripts\cp_mp\utility\inventory_utility::_giveweapon(var1, undefined, undefined, 1);
        thread switchtoexfilweapon(var4);
        var4 scripts\mp\equipment::giveequipment("equip_throwing_knife", "primary");
      }
    }

    return;
  }
}

function switchtoexfilweapon(var0) {
  self endon("death_or_disconnect");
  self endon("end_switchToFists");

  while(scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var0, 1) == 0) {
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

function onexfilsuccess(var0) {
  level endon("game_ended");
  var0.extracted = 1;
  var0.spawnprotection = 1;
  var0 scripts\mp\lightarmor::setlightarmorvalue(var0, 1000, undefined, 0);
  var0 scripts\mp\playeractions::registeractionset("exfil_success", ["usability", "offhand_weapons", "killstreaks", "supers", "gesture", "weapon", "weapon_switch"]);
  var0 scripts\mp\playeractions::allowactionset("exfil_success", 0);
  var0 thread scripts\mp\hud_message::showsplash("callout_exfil_success");

  while(!var0 isonground()) {
    waitframe();
  }

  var0 allowmovement(0);
  var1 = spawn("script_origin", var0.origin);
  var1 setModel("tag_origin");
  var0 playerlinkTo(var1);
  var1 moveTo(var1.origin + (0, 0, 10000), 5, 2, 2);
}

function stopunfillthread(var0) {
  wait var0;
  self.exfilactive = 0;
}

function assignhelitoexfilpoint(var0, var1, var2) {
  wait var1 + randomint(10);
  var3 = level.players[0] scripts\mp\gametypes\br_extract_chopper::spawnextractchopper(self, self.origin, var0, 10 + var1);
  var3 playLoopSound("br_exfil_lbravo_engine_temp");
  var4 = getEnt("clip64x64x256", "targetname");
  var5 = spawn("script_model", var3 gettagorigin("tag_origin"));
  var5 dontinterpolate();
  var5.angles = (-90, 0, 0);
  var5 clonebrushmodeltoscriptmodel(var4);
  var6 = anglesToForward(var3.angles * (1, 0, 0));
  var7 = vectorNormalize(var6) * 85;
  var5 linkTo(var3, "tag_origin", var7 + (0, 0, -60), var5.angles);
  var3.colmodelent = var5;
  var3 sethoverparams(5, 10, 5);
  self.choppers[self.choppers.size] = var3;
  var3.extractzone = self;

  if(!isDefined(var2)) {
    var2 = self.team;
  }

  var3.team = var2;
  var3.exfilspace = 6;
  var3.passengers[0] = self;
  var3.passengers[1] = self;
  var3.passengers[2] = self;
  var3.passengers[3] = self;
  var3.passengers[4] = self;
  var3.passengers[5] = self;
  self.curorigin = self.origin;
  self.offset3d = (0, 0, 30);
  init_useprompt_interactions(var3);
  thread bugoutontimeout(var3);
  var3.scene_node = undefined;
  var8 = undefined;
  thread exfilpilotactorthink(var3, var2, var3.scene_node);
}

function createextractvfx() {
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), self.vfxent, "tag_origin");
}

function exfilpilotactorthink(var0, var1, var2, var3) {
  level endon("game_ended");
  self.actors = thread spawnexfilpilotactors(var0, var2, var3);
  scripts\common\anim::anim_first_frame(self.actors, "lbravo_exfil", "origin_animate_jnt");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\mp\utility\infilexfil::showactors();

  if(isDefined(self.path)) {
    exfilactorthinkpath(var0, var1, var2, var3);
    return;
  }

  exfilactorthinkanim(var0, var1, var2, var3);
}

function exfilactorthinkpath(var0, var1, var2, var3) {
  thread exfilactorloopthink(self.actors[0]);
  thread exfilactorloopthink(self.actors[1]);
}

function exfilactorloopthink(var0) {
  exfilactorloop(var0);
  scripts\common\anim::anim_single_solo(var0, "lbravo_exfil_loop_exit", "origin_animate_jnt");
}

function exfilactorloop(var0) {
  self endon("unload");

  for(;;) {
    scripts\common\anim::anim_single_solo(var0, "lbravo_exfil_loop", "origin_animate_jnt");
  }
}

function exfilactorthinkanim(var0, var1, var2, var3) {
  thread scripts\common\anim::anim_single(self.actors, "lbravo_exfil", "origin_animate_jnt");
  var4 = getanimlength(level.scr_anim["pilot"]["lbravo_exfil"]);
  wait var4;

  foreach(var6 in self.actors) {
    var6 delete();
  }

  self.actors = undefined;
}

function spawnexfilpilotactors(var0, var1, var2) {
  var3 = [];
  GscBinSkip0(0x2e, var3.size, exfil_spawn_anim_model("pilot", "origin_animate_jnt", "fullbody_ppilot_crew_a"));
}

function exfil_spawn_anim_model(var0, var1, var2, var3, var4) {
  var5 = spawn("script_model", (0, 0, 0));
  var5 setModel(var2);

  if(isDefined(var3)) {
    var6 = spawn("script_model", (0, 0, 0));
    var6 setModel(var3);
    var6 linkTo(var5, "j_spine4", (0, 0, 0), (0, 0, 0));
    var5.head = var6;
    var5 thread scripts\engine\utility::delete_on_death(var6);
  }

  if(isDefined(var4)) {
    var7 = spawn("script_model", (0, 0, 0));
    var7 setModel(var4);
    var7 linkTo(var5, "j_gun", (0, 0, 0), (0, 0, 0));
    var5 thread scripts\engine\utility::delete_on_death(var7);
    var5.weapon = var7;
  }

  var5.animname = var0;
  var5 scripts\common\anim::setanimtree();

  if(isDefined(var1)) {
    thread scripts\engine\utility::delete_on_death(var5);
    var5 linkTo(self, var1, (0, 0, 0), (0, 0, 0));
  }

  return var5;
}

function bugoutontimeout(var0) {
  level scripts\engine\utility::waittill_any_two("exfil_continue_game_end", "exfil_on_nuke_arrival");
  scripts\mp\objidpoolmanager::returnobjectiveid(self.exfilgoalent.exfilobjid);
  thread forcelinkgoaltriggerwatcher(var0);
  thread exfilleavesequence(var0);
}

function forcelinkgoaltriggerwatcher(var0) {
  level endon("game_ended");
  self notify("trigger_start");
  self endon("trigger_start");

  for(;;) {
    self waittill("trigger", var1);
    jumpiffalse(var1.team == self.exfilgoalent.team && !istrue(var1.extracted)) LOC_00000069;
    thread playeranimlinktochopper(var1);
    var0.exfilspace--;
  }
}

function exfilusetriggerused(var0, var1, var2) {
  if(!isDefined(self.exfilspace)) {
    self.exfilspace = 6;
  }

  if(self.exfilspace > 0) {
    playerlinktochopper(var0, self, self.exfilspace);
    thread disableotherseats(var0, var1, var2);
    self.exfilspace--;
    return;
  }

  thread exfilleavesequence();
  scripts\mp\objidpoolmanager::returnobjectiveid(self.extractzone.exfilgoalent.exfilobjid);
}

function waitforsquadthenleave(var0) {
  var1 = level.teamdata[var0.team]["players"];

  foreach(var3 in var1) {
    if(var3 != var0) {
      var3 thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/GET_ON_CHOPPER", 10);
      continue;
    }

    var3 thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/CHOPPER_LEAVING_SOON", 10);
  }

  wait 10;
  thread exfilleavesequence(undefined, 1);
}

function disableotherseats(var0, var1, var2) {
  foreach(var4 in self.interactiontriggers) {
    var4 disableplayeruse(var0);
  }

  if(isDefined(var2)) {
    thread enableexitprompt(var0, var1, self);
    return;
  }
}

function enableexitprompt(var0, var1, var2) {
  var3 = spawn("script_model", self.origin);
  var3 setModel("tag_origin");
  var3 linkTo(self);
  var3 setHintString(&"MP/HOLD_TO_GET_OFF_CHOPPER");
  var3 setCursorHint("HINT_NOICON");
  var3 sethintdisplayrange(200);
  var3 sethintdisplayfov(90);
  var3 setuserange(200);
  var3 setusefov(360);
  var3 sethintonobstruction("hide");
  var3 setuseholdduration("duration_short");
  thread exfil_hopoff_think(var3, var1, self, var0);
  var1.exitinteract = var3;
}

function exfil_hopoff_think(var0, var1, var2, var3) {
  makechopperseatplayerusable(var1);

  for(;;) {
    self waittill("trigger", var1);
    self makeunusable();
    var1 stopanimscriptsceneevent();
    var0 scripts\mp\anim::anim_player_solo(var1, var1.player_rig, "lbravo_exfil_loop_exit", "origin_animate_jnt");
    var1.player_rig unlink();
    var1 unlink();
    makechopperseatteamusable(var3, var0.team);

    foreach(var5 in var0.interactiontriggers) {
      var5 enableplayeruse(var1);
    }

    var0 notify("unloaded");
    self delete();
  }
}

function playerlinktochopper(var0, var1, var2) {
  level endon("game_ended");
  var0.extracted = 1;
  var0.spawnprotection = 1;
  var0 scripts\mp\lightarmor::setlightarmorvalue(var0, 1000, undefined, 0);
  var0 thread scripts\mp\hud_message::showsplash("callout_exfil_success");

  while(!var0 isonground()) {
    waitframe();
  }

  var0 allowmovement(0);
  var0 playerlinkTo(var1, "tag_passenger" + var2, 1, 180, -180, 180, 180, 0);
}

function playeranimlinktochopper(var0, var1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(!isDefined(var1)) {
    for(var2 = 0; var2 < var0.passengers.size; var2++) {
      if(var0.passengers[var2] == var0.extractzone) {
        var0.passengers[var2] = self;
        var1 = var2;
      }
    }

    thread disableotherseats(var0);
  }

  thread scripts\mp\infilexfil\infilexfil::infil_player_rig("slot_" + var1, "viewhands_base_iw8");
  self.player_rig linkTo(var0, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));

  switch (var1) {
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
  rideloop(var0);
}

function rideloop(var0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  var0 endon("unload");

  while(isDefined(var0)) {
    var0 scripts\mp\anim::anim_player_solo(self, self.player_rig, "lbravo_exfil_loop", "origin_animate_jnt");
  }
}

function exfilleavesequence(var0, var1) {
  if(isDefined(self.exitinteract)) {
    self.exitinteract makeunusable();
  }

  thread scripts\mp\gametypes\br_extract_chopper::littlebirdleave();
  playannouncerbattlechatter(self.team, "extract_littlebird_leaving_a_friendly", 10);
  thread doexfilsplashforpassengers();

  if(isDefined(level.onexfilfinishedcallback)) {
    self[[level.onexfilfinishedcallback]](var0);
  }

  if(isDefined(var1)) {
    waitthenendgame(self.team);
    return;
  }
}

function waitthenendgame(var0) {
  wait 5;
  thread scripts\mp\gamelogic::endgame(var0, game["end_reason"]["objective_completed"]);
}

function doexfilsplashforpassengers() {
  wait 1;

  for(var0 = 0; var0 < self.passengers.size; var0++) {
    if(self.passengers[var0] != self.extractzone) {
      self.passengers[var0] thread scripts\mp\hud_message::showsplash("callout_exfil_success");
    }
  }
}

function init_useprompt_interactions(var0) {
  self.interactiontriggers = [];
  var1 = self gettagorigin("tag_passenger1");
  var2 = self gettagorigin("tag_passenger2");
  var3 = self gettagorigin("tag_passenger3");
  var4 = self gettagorigin("tag_passenger4");
  var5 = self gettagorigin("tag_passenger5");
  var6 = self gettagorigin("tag_passenger6");
  create_exfil_interaction(var1, &"MP/HOLD_TO_GET_ON_CHOPPER", 0, var0);
  create_exfil_interaction(var2, &"MP/HOLD_TO_GET_ON_CHOPPER", 2, var0);
  create_exfil_interaction(var3, &"MP/HOLD_TO_GET_ON_CHOPPER", 4, var0);
  create_exfil_interaction(var4, &"MP/HOLD_TO_GET_ON_CHOPPER", 1, var0);
  create_exfil_interaction(var5, &"MP/HOLD_TO_GET_ON_CHOPPER", 3, var0);
  create_exfil_interaction(var6, &"MP/HOLD_TO_GET_ON_CHOPPER", 5, var0);
}

function create_exfil_interaction(var0, var1, var2, var3) {
  var4 = spawn("script_model", var0);
  var4 setModel("tag_origin");
  var4 linkTo(self);
  var4 setHintString(var1);
  var4 setCursorHint("HINT_BUTTON");
  var4 sethintdisplayrange(200);
  var4 sethintdisplayfov(90);
  var4 setuserange(72);
  var4 setusefov(90);
  var4 sethintonobstruction("hide");
  var4 setuseholdduration("duration_short");
  thread exfil_use_think(var4, self, var2);
  self.interactiontriggers[self.interactiontriggers.size] = var4;
}

function exfil_use_think(var0, var1, var2) {
  if(isDefined(var2)) {
    makechopperseatplayerusable(var2);
  } else {
    makechopperseatteamusable(var0.team);
  }

  for(;;) {
    self waittill("trigger", var2);
    self makeunusable();
    exfilusetriggerused(var0, var2, var1, self);
  }
}

function makechopperseatteamusable(var0) {
  self makeusable();
  thread _updatechopperseatteamusable(var0);
}

function makechopperseatplayerusable(var0) {
  self makeusable();
  thread _updatechopperseatplayerusable(var0);
}

function _updatechopperseatteamusable(var0) {
  self endon("death");

  for(;;) {
    foreach(var2 in level.players) {
      if(var2.team == var0) {
        self showtoplayer(var2);
        self enableplayeruse(var2);
        continue;
      }

      self disableplayeruse(var2);
      self hidefromplayer(var2);
    }

    level waittill("joined_team");
  }
}

function _updatechopperseatplayerusable(var0) {
  self endon("death");

  for(;;) {
    foreach(var2 in level.players) {
      if(var2 == var0) {
        self showtoplayer(var2);
        self enableplayeruse(var2);
        continue;
      }

      self disableplayeruse(var2);
      self hidefromplayer(var2);
    }

    level waittill("joined_team");
  }
}

function playannouncerbattlechatter(var0, var1, var2) {
  level endon("game_ended");
  var3 = "ustl";
  var4 = "dx_mpa_" + var3 + "_" + var1 + "_" + var2;

  if(soundexists(var4)) {
    foreach(var6 in level.players) {
      if(var6.team == var0) {
        var6 queuedialogforplayer(var4, var1, 2);
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

function commander_play_sound_func(var0, var1, var2) {
  foreach(var4 in self.infil.players) {
    self playsoundtoplayer(var0, var4);
  }
}

function script_model_exfil_anims() {}