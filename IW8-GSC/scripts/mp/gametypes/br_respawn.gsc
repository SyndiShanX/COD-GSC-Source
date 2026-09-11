/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_respawn.gsc
***********************************************/

function init() {
  setdvarifuninitialized("scr_br_respawn", 0);
  level.br_respawn_enabled = getdvarint("scr_br_respawn", 0) != 0;

  if(!istrue(level.br_respawn_enabled)) {
    removeambulances();
    return;
  }

  level._effect["ambulance_light"] = loadfx("vfx/iw8/level/stpetersburg/vfx_stpburg_police_lights.vfx");
  level.br_respawnambulances = [];
  thread setuphud();
}

function removeambulances() {
  var_0 = scripts\engine\utility::getStructArray("br_respawn_station", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = getEnt(var_0[var_1].target, "targetname");

    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

function spawnambulance(var_0) {
  if(!istrue(level.br_respawn_enabled)) {
    return undefined;
  }

  var_1 = spawn("script_model", var_0.origin);

  if(isDefined(var_0.angles)) {
    var_1.angles = var_0.angles;
  } else {
    var_1.angles = (0, 0, 0);
  }

  var_1 setModel("veh8_civ_lnd_palfa_ambulance_ukraine");
  var_1.struct = var_0;
  ambulancesetup(var_1, var_0);
  thread ambulancethink();
  level.br_respawnambulances[level.br_respawnambulances.size] = var_1;
  return var_1;
}

function ambulancesetup(var_0) {
  thread ambulancelights();
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");

  if(!isDefined(self.defibrillator)) {
    var_2 = spawn("script_model", var_1.origin);

    if(isDefined(var_1.angles)) {
      var_2.angles = var_1.angles;
    }

    var_2 setModel("medical_defibrillator_wall_01");
    var_2 makeusable();
    var_2 setCursorHint("HINT_NOICON");
    var_2 setuseholdduration("duration_medium");
    var_2 sethintdisplayfov(120);
    var_2 setusefov(120);
    var_2 setuserange(80);
    var_2 setHintString(&"MP/BR_RESPAWN_TAKE");
    var_2 hudoutlineenable("outline_depth_red");
    var_2 setusepriority(-1);
    var_2 setasgametypeobjective();
    self.defibrillator = var_2;
  }

  var_3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  self.objectiveiconid = var_3;

  if(var_3 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_3, "invisible", (0, 0, 0));
    scripts\mp\objidpoolmanager::update_objective_onentity(var_3, self);
    scripts\mp\objidpoolmanager::update_objective_state(var_3, "active");
    scripts\mp\objidpoolmanager::update_objective_icon(var_3, "hud_icon_respawn");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_3, 1);
    return;
  }
}

function ambulancelights() {
  wait 1;
  var_0 = anglesToForward(self.angles);
  self.fx = spawnfx(scripts\engine\utility::getfx("ambulance_light"), self.origin + (0, 0, 75), var_0, (0, 0, 1));
  triggerfx(self.fx);
}

function ambulancethink() {
  self endon("death");

  for(;;) {
    self.defibrillator waittill("trigger", var_0);
    ambulancedefibrillator(var_0);
  }
}

function setuphud() {
  level.br_deadcountdownhud = [];
}

function initplayer() {
  if(!istrue(level.br_respawn_enabled)) {
    return;
  }

  hideallambulancesforplayer(self);
  disableallambulancesforplayer(self);
}

function hideallambulancesforteam(var_0, var_1) {
  if(istrue(var_1)) {
    var_2 = getrespawnableplayers(var_0);

    if(var_2.size > 0) {
      return;
    }
  }

  foreach(var_4 in level.teamdata[var_0]["players"]) {
    if(isDefined(var_4)) {
      hideallambulancesforplayer(var_4);
    }
  }
}

function hideallambulancesforplayer(var_0) {
  for(var_1 = 0; var_1 < level.br_respawnambulances.size; var_1++) {
    var_2 = level.br_respawnambulances[var_1];

    if(isDefined(var_2) && !istrue(var_2.disabled)) {
      ambulancehidefromplayer(var_2, var_0);
    }
  }
}

function ambulancehidefromplayer(var_0) {
  if(isDefined(self.defibrillator)) {
    self.defibrillator hudoutlinedisableforclient(var_0);
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objectiveiconid, var_0);
}

function disableallambulancesforplayer(var_0) {
  for(var_1 = 0; var_1 < level.br_respawnambulances.size; var_1++) {
    var_2 = level.br_respawnambulances[var_1];

    if(isDefined(var_2) && !istrue(var_2.disabled)) {
      ambulancemakeunusabletoplayer(var_2, var_0);
    }
  }
}

function ambulancemakeunusabletoplayer(var_0) {
  if(isDefined(self.defibrillator)) {
    self.defibrillator disableplayeruse(var_0);
    return;
  }
}

function showallambulancesforteam(var_0) {
  foreach(var_2 in level.teamdata[var_0]["players"]) {
    if(isDefined(var_2)) {
      showallambulancesforplayer(var_2);
    }
  }
}

function showallambulancesforplayer(var_0) {
  for(var_1 = 0; var_1 < level.br_respawnambulances.size; var_1++) {
    var_2 = level.br_respawnambulances[var_1];

    if(isDefined(var_2) && !istrue(var_2.disabled)) {
      ambulanceshowtoplayer(var_2, var_0);
    }
  }
}

function ambulanceshowtoplayer(var_0) {
  self.defibrillator hudoutlineenableforclient(var_0, "outline_depth_red");
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objectiveiconid, var_0);
}

function ambulanceenabletoteam(var_0) {
  foreach(var_2 in level.teamdata[var_0]["players"]) {
    if(isDefined(var_2)) {
      ambulancemakeusabletoplayer(var_2);
    }
  }
}

function ambulancedisabletoteam(var_0) {
  foreach(var_2 in level.teamdata[var_0]["players"]) {
    if(isDefined(var_2)) {
      ambulancemakeunusabletoplayer(var_2);
    }
  }
}

function ambulancemakeusabletoplayer(var_0) {
  self.defibrillator enableplayeruse(var_0);
}

function ambulancedisable() {
  self notify("disabled");
  self.disabled = 1;
  self.defibrillator makeunusable();
  self.defibrillator hudoutlinedisable();
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);

  if(isDefined(self.fx)) {
    self.fx delete();
    return;
  }
}

function ambulancemakeunsabletoall() {
  self.defibrillator setHintString(&"MP/BR_RESPAWN_CHARGING");
  self.defibrillator setuseholdduration("duration_none");
}

function ambulancemakeusable() {
  self.defibrillator setHintString(&"MP/BR_RESPAWN_TAKE");
  self.defibrillator setuseholdduration("duration_medium");
  var_0 = getallrespawnableplayers();

  foreach(var_2 in var_0) {
    useentsetupcloseambulance(var_2.respawnent, var_2.team);
  }
}

function anyambulancesavailable() {
  for(var_0 = 0; var_0 < level.br_respawnambulances.size; var_0++) {
    var_1 = level.br_respawnambulances[var_0];

    if(isDefined(var_1) && !istrue(var_1.disabled)) {
      return true;
    }
  }

  return false;
}

function dangercircletick(var_0, var_1) {
  if(!istrue(level.br_respawn_enabled)) {
    return;
  }

  for(var_2 = 0; var_2 < level.br_respawnambulances.size; var_2++) {
    var_3 = level.br_respawnambulances[var_2];

    if(isDefined(var_3) && !istrue(var_3.disabled) && distance2dsquared(var_0, var_3.origin) > var_1 * var_1) {
      ambulancedisable(var_3);
      disablerespawnscenarios(var_3);
    }
  }
}

function disablerespawnscenarios(var_0) {
  var_1 = !anyambulancesavailable();

  if(!var_1 && !isDefined(var_0)) {
    return;
  }

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(isDefined(var_3.respawnent) && var_1) {
      var_3.respawnent notify("respawnComplete", 0);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_3.usedambulance) && var_3.usedambulance == var_0) {
      var_3 notify("defibrillator_done");
      var_3 notify("portable_defibrillator_done");
    }
  }
}

function playershoulddofauxdeath() {
  return istrue(level.br_respawn_enabled) && anyambulancesavailable() && (istrue(self.brwasinlaststand) || isDefined(self.respawnent));
}

function playersetinlaststand() {
  self.brwasinlaststand = 1;
  _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("laststand");
  scripts\mp\gametypes\br_public::ref_1319e(1);
}

function playerdied(var_0, var_1) {
  if(!istrue(level.br_respawn_enabled)) {
    return;
  }

  if(isDefined(var_0)) {
    playertrytakedefibrillator(var_0, var_1);
  }

  if(!anyambulancesavailable()) {
    if(istrue(self.fauxdead)) {
      thread scripts\mp\playerlogic::spawnspectator(self.origin, self.angles);
    }

    return;
  }

  self.brwasinlaststand = undefined;
  var_2 = self.team;

  if(level.teamdata[var_2]["alivePlayers"].size == 0) {
    foreach(var_6, var_5 in level.teamdata[var_2]["players"]) {
      if(!isDefined(var_5)) {
        continue;
      }

      if(isDefined(var_5.respawnent)) {
        var_5.respawnent notify("respawnComplete", 0);
      }
    }

    return;
  }

  if(isDefined(self.body)) {
    self.body delete();
  } else {
    self.nocorpse = 1;
  }

  self playerhide();
  self.health = 1;
  thread playerkeeploadingstreamedassets();
  var_7 = createpickupuseent(self.origin, var_6);
  var_7.timerhud = createplayerdeadcountdownhud(var_6, 180);
  updatecountdownhudlist(var_7.timerhud);
  var_7.drophud = createdropplayerhud(var_6);
  thread useentrespawntimeout(var_7, 180, self);
  thread useentrespawncomplete(var_7, self);
  thread useentpickupbody(var_7, self);
  useentsetupcloseambulance(var_7, var_6);
  self.respawnent = var_7;
  playerfakespectate(1);
}

function updatecountdownhudlist(var_0) {
  var_1 = -50;
  var_2 = -100;
  var_3 = -15;

  if(isDefined(var_0)) {
    level.br_deadcountdownhud[level.br_deadcountdownhud.size] = var_0;
  }

  for(var_4 = 1; var_4 < level.br_deadcountdownhud.size; var_4++) {
    var_5 = level.br_deadcountdownhud[var_4];

    for(var_6 = var_4 - 1; var_6 >= 0 && getsoonerhud(var_5, level.br_deadcountdownhud[var_6]) == var_5; var_6--) {
      level.br_deadcountdownhud[var_6 + 1] = level.br_deadcountdownhud[var_6];
    }

    level.br_deadcountdownhud[var_6 + 1] = var_5;
  }

  for(var_4 = 0; var_4 < level.br_deadcountdownhud.size; var_4++) {
    var_5 = level.br_deadcountdownhud[var_4];

    if(isDefined(var_5)) {
      var_5 scripts\mp\hud_util::setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", var_1, var_2 + var_3 * var_4);
    }
  }
}

function getsoonerhud(var_0, var_1) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  if(!isDefined(var_0)) {
    return var_1;
  }

  if(var_0.starttime <= var_1.starttime) {
    return var_0;
  }

  return var_1;
}

function playerfakespectate(var_0) {
  var_1 = !var_0;
  self allowmelee(var_1);
  self allowads(var_1);
  self allowfire(var_1);
  self allowcrouch(var_1);
  self allowprone(var_1);
  self allowreload(var_1);
  self setCanDamage(var_1);

  if(var_1) {
    self enableusability();
    self enableoffhandweapons();
    self unlink();
    self setcamerathirdperson(0);
    self notify("stopFakeSpectate");
    self setclientomnvar("ui_show_spectateHud", -1);
    return;
  }

  self disableusability();
  self disableoffhandweapons();
  thread playerfakespectatecontrols();
  self setcamerathirdperson(1);
}

function playerfakespectatecontrols() {
  self endon("death_or_disconnect");
  self endon("stopFakeSpectate");
  var_0 = undefined;

  for(;;) {
    var_1 = self fragButtonPressed();
    var_2 = self secondaryoffhandbuttonPressed();

    if(var_1 || var_2 || !isDefined(var_0) || !isalive(var_0) || isDefined(var_0.respawnent) || istrue(var_0.fauxdead)) {
      var_3 = getplayertospectate(self.team, var_0, var_1 || !isDefined(var_0));

      if(!isDefined(var_0) || var_0 != var_3) {
        var_0 = var_3;
        self playerlinktodelta(var_0, "tag_eye");
        self setclientomnvar("ui_show_spectateHud", var_0 getentitynumber());
        self playerhide();
      }

      if(var_1) {
        while(self fragButtonPressed()) {
          waitframe();
        }
      } else if(var_2) {
        while(self secondaryoffhandbuttonPressed()) {
          waitframe();
        }
      }
    }

    waitframe();
  }
}

function getplayertospectate(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_1)) {
    for(var_4 = 0; var_4 < level.teamdata[var_0]["alivePlayers"].size; var_4++) {
      var_5 = level.teamdata[var_0]["alivePlayers"][var_4];

      if(var_5 == var_1) {
        var_3 = var_4;
        break;
      }
    }
  }

  if(var_2) {
    var_3 = (var_3 + 1) % level.teamdata[var_0]["alivePlayers"].size;
  } else {
    var_3--;

    if(var_3 < 0) {
      var_3 = level.teamdata[var_0]["alivePlayers"].size - 1;
    }
  }

  return level.teamdata[var_0]["alivePlayers"][var_3];
}

function playerkeeploadingstreamedassets() {
  self endon("disconnect");
  self waittill("spawned");
  self endon("spawned");

  for(;;) {
    var_0 = scripts\mp\class::preloadandqueueclass(self.class, 1);
    var_1 = scripts\mp\playerlogic::getplayerassets(var_0);

    while(!scripts\mp\playerlogic::allplayershaveassetsloaded(var_1)) {
      wait 0.1;
    }

    while(scripts\mp\playerlogic::allplayershaveassetsloaded(var_1)) {
      wait 1;
    }
  }
}

function playertrytakedefibrillator(var_0) {
  if(isalive(self) && isDefined(var_0) && isDefined(var_0.basename) && var_0.basename == "iw8_defibrillator_mp" && self hasweapon("iw8_defibrillator_mp")) {
    self takeweapon("iw8_defibrillator_mp");
    var_1 = self getweaponslistprimaries();

    if(var_1.size > 0 && !scripts\mp\utility\weapon::update_health_bar_to_player(var_1[0])) {
      self switchtoweapon(var_1[0]);
    } else if(var_1.size > 1 && !scripts\mp\utility\weapon::update_health_bar_to_player(var_1[1])) {
      self switchtoweapon(var_1[1]);
    } else if(self hasweapon("iw8_fists_mp")) {
      self switchtoweapon("iw8_fists_mp");
    } else {
      self giveweapon("iw8_fists_mp");
      self switchtoweapon("iw8_fists_mp");
    }

    self notify("defibrillator_done");
    self notify("portable_defibrillator_done");
    return;
  }
}

function useentrespawntimeout(var_0, var_1, var_2) {
  self endon("respawnComplete");
  var_1 scripts\engine\utility::ref_143bf(var_0, "disconnect");
  self notify("timeout");
  waittillframeend();

  foreach(var_4 in level.teamdata[var_2]["players"]) {
    if(isDefined(var_4) && isDefined(var_4.usedambulance) && isDefined(self.ambulance) && var_4.usedambulance == self.ambulance) {
      var_4 notify("defibrillator_done");
    }
  }

  if(isDefined(var_1)) {
    playerfakespectate(var_1, 0);
    var_1 thread scripts\mp\playerlogic::spawnspectator(var_1.respawnent.origin, var_1.respawnent.angles);
  }

  cleanupbodydrop(self, var_2);
}

function useentrespawncomplete(var_0, var_1) {
  self endon("timeout");
  var_0 endon("disconnect");
  self waittill("respawnComplete", var_2);

  if(istrue(var_2)) {
    if(isDefined(var_0.body)) {
      var_0.body delete();
    }

    playerrespawn(var_0, self.origin, self.angles);
  } else if(isDefined(var_0)) {
    playerfakespectate(var_0, 0);
    var_0 thread scripts\mp\playerlogic::spawnspectator(var_0.respawnent.origin, var_0.respawnent.angles);
  }

  waittillframeend();
  cleanupbodydrop(self, var_1);
}

function playerrespawn(var_0, var_1) {
  playerfakespectate(0);
  self.forcespawnorigin = var_0;
  self.forcespawnangles = var_1;
  self.isrespawn = 1;
  self.alreadyaddedtoalivecount = 1;
  scripts\mp\playerlogic::spawnplayer(0, 0);
}

function useentpickupbody(var_0, var_1) {
  self endon("respawnComplete");
  self endon("timeout");
  var_0 endon("disconnect");

  for(;;) {
    self waittill("trigger", var_2);

    if(isDefined(var_0.body)) {
      var_0.body delete();
    }

    if(var_2.team != var_1) {
      continue;
    }

    useenthide(var_1);
    playerpickupbody(var_2, self, var_1);
    useentshow(var_1);
  }
}

function useenthide(var_0) {
  self makeunusable();
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
}

function useentshow(var_0) {
  self makeusable();
  scripts\mp\objidpoolmanager::objective_teammask_single(self.objectiveiconid, var_0);
  objective_setplayintro(self.objectiveiconid, 0);
}

function playerpickupbody(var_0, var_1) {
  self endon("droppedBody");
  var_2 = scripts\mp\hud_util::createfontstring("default", 1.5);
  var_2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 120);
  var_2.label = &"MP/BR_RESPAWN_BODY";
  self.holdingbodyhud = var_2;

  if(isDefined(var_0.ambulance)) {
    ambulancedisabletoteam(var_0.ambulance, var_1);
    var_0.ambulance = undefined;
  }

  var_0 scriptmodelplayanim("sdr_cp_hostage_walk_hostage");
  var_0 linkTo(self, "j_clavicle_le", (0, 0, 0), (0, 0, 0));
  thread useentdropbodyonplayerdone(var_0, self, var_2);
  thread useentdropbodywhencomplete(var_0, self, var_2);
  thread useentmonitorambulances(var_0);
  self allowads(0);
  self allowcrouch(0);
  self allowprone(0);
  self allowjump(0);
  playersetcarryteammates(1);
  showallambulancesforteam(var_1);

  foreach(var_4 in level.teamdata[var_1]["players"]) {
    if(isDefined(var_4)) {
      var_4 notify("defibrillator_done");
      var_4 thread scripts\mp\hud_message::showsplash("br_respawn_start");
    }
  }

  while(!self stancebuttonPressed() || !self isonground()) {
    waitframe();
  }

  dropbody(var_0, self, var_2, var_1);
}

function playersetcarryteammates(var_0) {
  self.carrying = var_0;
  var_1 = level.teamdata[self.team]["players"];

  foreach(var_3 in var_1) {
    if(isDefined(var_3.respawnent)) {
      if(!var_0) {
        var_3.respawnent enableplayeruse(self);
        continue;
      }

      var_3.respawnent disableplayeruse(self);
    }
  }
}

function useentdropbodyonplayerdone(var_0, var_1, var_2) {
  self endon("droppedBody");
  var_0 scripts\engine\utility::ref_143a6("disconnect", "death", "last_stand_start");
  dropbody(self, var_0, var_1, var_2);
}

function useentdropbodywhencomplete(var_0, var_1, var_2) {
  self endon("droppedBody");
  scripts\engine\utility::ref_143a5("timeout", "respawnComplete");
  dropbody(self, var_0, var_1, var_2);
}

function dropbody(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_1 allowads(1);
    var_1 allowcrouch(1);
    var_1 allowprone(1);
    var_1 allowjump(1);
    playersetcarryteammates(var_1, 0);
  }

  if(isDefined(var_2)) {
    var_2 destroy();
  }

  if(var_0 islinked()) {
    var_0 unlink();
  }

  var_4 = undefined;

  if(isDefined(var_1)) {
    var_0.angles = var_1.angles;
    var_4 = var_1.origin;
    var_0.origin = var_4 + (0, 0, 40);
  } else {
    var_4 = var_0.origin;
    var_0.origin = var_4 + (0, 0, 40);
  }

  var_0.drophud.alpha = 0;
  useentsetupcloseambulance(var_0, var_3);
  var_0 scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  var_0 scriptmodelpauseanim(1);
  var_0.origin = var_4 + (0, 0, 1);
  var_0 notify("droppedBody");
}

function useentsetupcloseambulance(var_0) {
  var_1 = getcloseambulance(self.origin);

  if(isDefined(var_1)) {
    self.ambulance = var_1;
    ambulanceenabletoteam(var_1, var_0);
    return;
  }
}

function createpickupuseent(var_0, var_1) {
  var_2 = spawn("script_model", var_0 + (0, 0, 1));
  var_2 setModel("fullbody_usmc_ar_scriptmover");
  var_2 scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  var_2 scriptmodelpauseanim(1);
  var_2 makeusable();
  var_2 setCursorHint("HINT_NOICON");
  var_2 setuseholdduration("duration_medium");
  var_2 setuserange(120);
  var_2 setHintString(&"MP/BR_PICKUP_PLAYER");
  var_2 setusepriority(0);
  var_2 hudoutlineenable("outlinefill_nodepth_red");

  foreach(var_4 in level.players) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(var_4.team == var_1) {
      var_2 hudoutlineenableforclient(var_4, "outlinefill_nodepth_red");

      if(!istrue(var_4.carrying)) {
        var_2 enableplayeruse(var_4);
      }

      continue;
    }

    var_2 disableplayeruse(var_4);
    var_2 hudoutlinedisableforclient(var_4);
  }

  var_6 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  var_2.objectiveiconid = var_6;

  if(var_6 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_6, "invisible", (0, 0, 0));
    scripts\mp\objidpoolmanager::update_objective_onentity(var_6, var_2);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var_6, 40);
    scripts\mp\objidpoolmanager::update_objective_state(var_6, "current");
    scripts\mp\objidpoolmanager::update_objective_icon(var_6, "passive_icon_health_on_kill");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_6, 1);
    scripts\mp\objidpoolmanager::objective_teammask_single(var_6, var_1);
  }

  return var_2;
}

function createplayerdeadcountdownhud(var_0, var_1) {
  var_2 = scripts\mp\hud_util::createservertimer("objective", 1.4, var_0);
  var_2.label = &"MP/BR_RESPAWN_DEATH_COUNTDOWN";
  var_2 settimer(var_1);
  var_2.starttime = gettime();
  thread countdownhudpulse(var_2);
  return var_2;
}

function countdownhudpulse(var_0) {
  var_1 = 0.5;
  var_2 = 2;
  var_3 = var_0.fontscale;
  var_0 changefontscaleovertime(var_1);
  var_0.fontscale = var_2;
  wait var_1;

  if(isDefined(var_0)) {
    var_0 changefontscaleovertime(var_1);
    var_0.fontscale = var_3;
    return;
  }
}

function cleanupbodydrop(var_0, var_1) {
  if(isDefined(var_0.timerhud)) {
    var_0.timerhud destroy();
  }

  updatecountdownhudlist();

  if(isDefined(var_0.drophud)) {
    var_0.drophud destroy();
  }

  if(isDefined(var_0.ambulance)) {
    ambulancedisabletoteam(var_0.ambulance, var_1);
    var_0.ambulance = undefined;
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  var_0 delete();
  hideallambulancesforteam(var_1, 1);
}

function useentmonitorambulances(var_0) {
  self endon("droppedBody");
  var_1 = 0;

  for(;;) {
    var_2 = 0;

    for(var_3 = 0; var_3 < level.br_respawnambulances.size; var_3++) {
      var_4 = level.br_respawnambulances[var_3];

      if(!isDefined(var_4) || istrue(var_4.disabled)) {
        continue;
      }

      var_5 = var_4.origin;

      foreach(var_7 in level.teamdata[var_0]["players"]) {
        if(!isDefined(var_7)) {
          continue;
        }

        var_8 = distancesquared(var_5, var_7.origin);

        if(var_8 < 65536) {
          var_2 = 1;
          break;
        }
      }

      if(var_2) {
        break;
      }
    }

    if(!var_1 && var_2) {
      self.drophud.alpha = 1;
    } else if(var_1 && !var_2) {
      self.drophud.alpha = 0;
    }

    var_1 = var_2;
    wait 0.1;
  }
}

function createdropplayerhud(var_0) {
  var_1 = 1.3;
  var_2 = newteamhudelem(var_0);
  var_2.elemtype = "font";
  var_2.font = "default";
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 scripts\mp\hud_util::setparent(level.uiparent);
  var_2.hidden = 0;
  var_2.alpha = 0;
  var_2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 100);
  var_2.label = &"MP/BR_RESPAWN_DROP_BODY";
  return var_2;
}

function getrespawnableplayers(var_0) {
  var_1 = level.teamdata[var_0]["players"];
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.respawnent)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function getallrespawnableplayers() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(isDefined(var_2.respawnent)) {
      var_0 = var_2;
    }
  }

  return var_0;
}

function getcloseambulance(var_0) {
  for(var_1 = 0; var_1 < level.br_respawnambulances.size; var_1++) {
    var_2 = level.br_respawnambulances[var_1];

    if(!isDefined(var_2) || istrue(var_2.disabled)) {
      continue;
    }

    var_3 = distancesquared(var_2.origin, var_0);

    if(var_3 < 65536) {
      return var_2;
    }
  }
}

function ambulancedefibrillator(var_0) {
  if(var_0 hasweapon("iw8_defibrillator_mp")) {
    var_0 switchtoweapon("iw8_defibrillator_mp");
    return;
  }

  thread ambulancedosiren();
  var_0.usedambulance = self;
  self.defibrillator hide();
  var_1 = playergivedefibrillator(var_0, self);

  if(isDefined(var_0)) {
    var_0 notify("defibrillator_done");
    var_0.usedambulance = undefined;
  }

  self.defibrillator show();

  if(isDefined(var_1)) {
    var_1.respawnent notify("respawnComplete", 1);
    ambulancedelayreuse();
    return;
  }
}

function ambulancedelayreuse() {
  self endon("disabled");
  ambulancemakeunsabletoall();
  wait 30;
  ambulancemakeusable();
}

function ambulancedosiren() {
  self notify("ambulanceDoSiren");
  self endon("ambulanceDoSiren");
  self playLoopSound("siren_ambulance_lp");
  wait 30;
  self stoploopsound();
}

function playergivedefibrillator(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");
  var_1 = getrespawnableplayers(self.team);

  if(var_1.size == 0) {
    self iprintlnbold("No dead teammates");
    return;
  }

  self.lastweaponrespawn = self getcurrentprimaryweapon();
  var_2 = getcompleteweaponname("iw8_defibrillator_mp");
  self giveweapon(var_2);
  self switchtoweapon(var_2);
  thread playermonitorweaponchange(var_2);
  thread playertakeawaydefibrillator(var_2);
  thread playermonitordistancefromambulance(var_0);
  return playerdodefibrillator(1);
}

function playerdodefibrillator(var_0) {
  for(;;) {
    self waittill("melee_fired", var_1);
    var_2 = 0;

    if(var_1.basename != "iw8_defibrillator_mp") {
      if(!self hasweapon("iw8_defibrillator_mp")) {
        return;
      }

      continue;
    }

    var_3 = self getEye();
    var_4 = anglesToForward(self getplayerangles());
    var_5 = getrespawnableplayers(self.team);
    var_6 = 0;

    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      var_8 = var_5[var_7];

      if(!isDefined(var_8) || !isDefined(var_8.respawnent)) {
        continue;
      }

      var_6 = 1;
      var_9 = var_8.respawnent.origin + (0, 0, 40);
      var_10 = vectorNormalize(var_9 - var_3);
      var_11 = vectordot(var_10, var_4);

      if(var_11 < 0.5) {
        continue;
      }

      var_12 = distancesquared(self.origin, var_9);

      if(var_12 > 10000) {
        continue;
      }

      return var_8;
    }

    if(!var_6 && istrue(var_0)) {
      self iprintlnbold("No teammates to revive");
      return;
    }
  }
}

function playermonitorweaponchange(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");

  for(;;) {
    self waittill("weapon_change", var_1);

    if(!isnullweapon(var_0, var_1)) {
      self notify("defibrillator_done");
      return;
    }
  }
}

function playertakeawaydefibrillator(var_0) {
  scripts\engine\utility::ref_143a6("death", "disconnect", "last_stand_start", "defibrillator_done");

  if(isDefined(self) && self hasweapon(var_0)) {
    self takeweapon(var_0);
    self switchtoweapon(self.lastweaponrespawn);
    return;
  }
}

function playermonitordistancefromambulance(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");

  for(;;) {
    var_1 = distancesquared(var_0.origin, self.origin);

    if(var_1 > 65536) {
      self notify("defibrillator_done");
      return;
    }

    wait 0.1;
  }
}

function giveweaponpickup(var_0) {
  self endon("death");
  self endon("disconnect");

  if(!istrue(level.br_respawn_enabled)) {
    return;
  }

  if(var_0 != "iw8_defibrillator_mp") {
    return;
  }

  var_1 = playerdoportabledefibrillator();

  if(isDefined(var_1)) {
    if(isDefined(var_1.body)) {
      var_1.body delete();
    }

    var_1.respawnent notify("respawnComplete", 1);
  }

  var_2 = getcompleteweaponname("iw8_defibrillator_mp");
  playertrytakedefibrillator(var_2);
}

function playerdoportabledefibrillator() {
  self endon("portable_defibrillator_done");
  return playerdodefibrillator();
}