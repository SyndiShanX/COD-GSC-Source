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
  var0 = scripts\engine\utility::getStructArray("br_respawn_station", "targetname");

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = getEnt(var0[var1].target, "targetname");

    if(isDefined(var2)) {
      var2 delete();
    }
  }
}

function spawnambulance(var0) {
  if(!istrue(level.br_respawn_enabled)) {
    return undefined;
  }

  var1 = spawn("script_model", var0.origin);

  if(isDefined(var0.angles)) {
    var1.angles = var0.angles;
  } else {
    var1.angles = (0, 0, 0);
  }

  var1 setModel("veh8_civ_lnd_palfa_ambulance_ukraine");
  var1.struct = var0;
  ambulancesetup(var1, var0);
  thread ambulancethink();
  level.br_respawnambulances[level.br_respawnambulances.size] = var1;
  return var1;
}

function ambulancesetup(var0) {
  thread ambulancelights();
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");

  if(!isDefined(self.defibrillator)) {
    var2 = spawn("script_model", var1.origin);

    if(isDefined(var1.angles)) {
      var2.angles = var1.angles;
    }

    var2 setModel("medical_defibrillator_wall_01");
    var2 makeusable();
    var2 setCursorHint("HINT_NOICON");
    var2 setuseholdduration("duration_medium");
    var2 sethintdisplayfov(120);
    var2 setusefov(120);
    var2 setuserange(80);
    var2 setHintString(&"MP/BR_RESPAWN_TAKE");
    var2 hudoutlineenable("outline_depth_red");
    var2 setusepriority(-1);
    var2 setasgametypeobjective();
    self.defibrillator = var2;
  }

  var3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  self.objectiveiconid = var3;

  if(var3 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var3, "invisible", (0, 0, 0));
    scripts\mp\objidpoolmanager::update_objective_onentity(var3, self);
    scripts\mp\objidpoolmanager::update_objective_state(var3, "active");
    scripts\mp\objidpoolmanager::update_objective_icon(var3, "hud_icon_respawn");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var3, 1);
    return;
  }
}

function ambulancelights() {
  wait 1;
  var0 = anglesToForward(self.angles);
  self.fx = spawnfx(scripts\engine\utility::getfx("ambulance_light"), self.origin + (0, 0, 75), var0, (0, 0, 1));
  triggerfx(self.fx);
}

function ambulancethink() {
  self endon("death");

  for(;;) {
    self.defibrillator waittill("trigger", var0);
    ambulancedefibrillator(var0);
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

function hideallambulancesforteam(var0, var1) {
  if(istrue(var1)) {
    var2 = getrespawnableplayers(var0);

    if(var2.size > 0) {
      return;
    }
  }

  foreach(var4 in level.teamdata[var0]["players"]) {
    if(isDefined(var4)) {
      hideallambulancesforplayer(var4);
    }
  }
}

function hideallambulancesforplayer(var0) {
  for(var1 = 0; var1 < level.br_respawnambulances.size; var1++) {
    var2 = level.br_respawnambulances[var1];

    if(isDefined(var2) && !istrue(var2.disabled)) {
      ambulancehidefromplayer(var2, var0);
    }
  }
}

function ambulancehidefromplayer(var0) {
  if(isDefined(self.defibrillator)) {
    self.defibrillator hudoutlinedisableforclient(var0);
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objectiveiconid, var0);
}

function disableallambulancesforplayer(var0) {
  for(var1 = 0; var1 < level.br_respawnambulances.size; var1++) {
    var2 = level.br_respawnambulances[var1];

    if(isDefined(var2) && !istrue(var2.disabled)) {
      ambulancemakeunusabletoplayer(var2, var0);
    }
  }
}

function ambulancemakeunusabletoplayer(var0) {
  if(isDefined(self.defibrillator)) {
    self.defibrillator disableplayeruse(var0);
    return;
  }
}

function showallambulancesforteam(var0) {
  foreach(var2 in level.teamdata[var0]["players"]) {
    if(isDefined(var2)) {
      showallambulancesforplayer(var2);
    }
  }
}

function showallambulancesforplayer(var0) {
  for(var1 = 0; var1 < level.br_respawnambulances.size; var1++) {
    var2 = level.br_respawnambulances[var1];

    if(isDefined(var2) && !istrue(var2.disabled)) {
      ambulanceshowtoplayer(var2, var0);
    }
  }
}

function ambulanceshowtoplayer(var0) {
  self.defibrillator hudoutlineenableforclient(var0, "outline_depth_red");
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objectiveiconid, var0);
}

function ambulanceenabletoteam(var0) {
  foreach(var2 in level.teamdata[var0]["players"]) {
    if(isDefined(var2)) {
      ambulancemakeusabletoplayer(var2);
    }
  }
}

function ambulancedisabletoteam(var0) {
  foreach(var2 in level.teamdata[var0]["players"]) {
    if(isDefined(var2)) {
      ambulancemakeunusabletoplayer(var2);
    }
  }
}

function ambulancemakeusabletoplayer(var0) {
  self.defibrillator enableplayeruse(var0);
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
  var0 = getallrespawnableplayers();

  foreach(var2 in var0) {
    useentsetupcloseambulance(var2.respawnent, var2.team);
  }
}

function anyambulancesavailable() {
  for(var0 = 0; var0 < level.br_respawnambulances.size; var0++) {
    var1 = level.br_respawnambulances[var0];

    if(isDefined(var1) && !istrue(var1.disabled)) {
      return true;
    }
  }

  return false;
}

function dangercircletick(var0, var1) {
  if(!istrue(level.br_respawn_enabled)) {
    return;
  }

  for(var2 = 0; var2 < level.br_respawnambulances.size; var2++) {
    var3 = level.br_respawnambulances[var2];

    if(isDefined(var3) && !istrue(var3.disabled) && distance2dsquared(var0, var3.origin) > var1 * var1) {
      ambulancedisable(var3);
      disablerespawnscenarios(var3);
    }
  }
}

function disablerespawnscenarios(var0) {
  var1 = !anyambulancesavailable();

  if(!var1 && !isDefined(var0)) {
    return;
  }

  foreach(var3 in level.players) {
    if(!isDefined(var3)) {
      continue;
    }

    if(isDefined(var3.respawnent) && var1) {
      var3.respawnent notify("respawnComplete", 0);
      continue;
    }

    if(isDefined(var0) && isDefined(var3.usedambulance) && var3.usedambulance == var0) {
      var3 notify("defibrillator_done");
      var3 notify("portable_defibrillator_done");
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

function playerdied(var0, var1) {
  if(!istrue(level.br_respawn_enabled)) {
    return;
  }

  if(isDefined(var0)) {
    playertrytakedefibrillator(var0, var1);
  }

  if(!anyambulancesavailable()) {
    if(istrue(self.fauxdead)) {
      thread scripts\mp\playerlogic::spawnspectator(self.origin, self.angles);
    }

    return;
  }

  self.brwasinlaststand = undefined;
  var2 = self.team;

  if(level.teamdata[var2]["alivePlayers"].size == 0) {
    foreach(var6, var5 in level.teamdata[var2]["players"]) {
      if(!isDefined(var5)) {
        continue;
      }

      if(isDefined(var5.respawnent)) {
        var5.respawnent notify("respawnComplete", 0);
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
  var7 = createpickupuseent(self.origin, var6);
  var7.timerhud = createplayerdeadcountdownhud(var6, 180);
  updatecountdownhudlist(var7.timerhud);
  var7.drophud = createdropplayerhud(var6);
  thread useentrespawntimeout(var7, 180, self);
  thread useentrespawncomplete(var7, self);
  thread useentpickupbody(var7, self);
  useentsetupcloseambulance(var7, var6);
  self.respawnent = var7;
  playerfakespectate(1);
}

function updatecountdownhudlist(var0) {
  var1 = -50;
  var2 = -100;
  var3 = -15;

  if(isDefined(var0)) {
    level.br_deadcountdownhud[level.br_deadcountdownhud.size] = var0;
  }

  for(var4 = 1; var4 < level.br_deadcountdownhud.size; var4++) {
    var5 = level.br_deadcountdownhud[var4];

    for(var6 = var4 - 1; var6 >= 0 && getsoonerhud(var5, level.br_deadcountdownhud[var6]) == var5; var6--) {
      level.br_deadcountdownhud[var6 + 1] = level.br_deadcountdownhud[var6];
    }

    level.br_deadcountdownhud[var6 + 1] = var5;
  }

  for(var4 = 0; var4 < level.br_deadcountdownhud.size; var4++) {
    var5 = level.br_deadcountdownhud[var4];

    if(isDefined(var5)) {
      var5 scripts\mp\hud_util::setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", var1, var2 + var3 * var4);
    }
  }
}

function getsoonerhud(var0, var1) {
  if(!isDefined(var1)) {
    return var0;
  }

  if(!isDefined(var0)) {
    return var1;
  }

  if(var0.starttime <= var1.starttime) {
    return var0;
  }

  return var1;
}

function playerfakespectate(var0) {
  var1 = !var0;
  self allowmelee(var1);
  self allowads(var1);
  self allowfire(var1);
  self allowcrouch(var1);
  self allowprone(var1);
  self allowreload(var1);
  self setCanDamage(var1);

  if(var1) {
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
  var0 = undefined;

  for(;;) {
    var1 = self fragButtonPressed();
    var2 = self secondaryoffhandbuttonPressed();

    if(var1 || var2 || !isDefined(var0) || !isalive(var0) || isDefined(var0.respawnent) || istrue(var0.fauxdead)) {
      var3 = getplayertospectate(self.team, var0, var1 || !isDefined(var0));

      if(!isDefined(var0) || var0 != var3) {
        var0 = var3;
        self playerlinktodelta(var0, "tag_eye");
        self setclientomnvar("ui_show_spectateHud", var0 getentitynumber());
        self playerhide();
      }

      if(var1) {
        while(self fragButtonPressed()) {
          waitframe();
        }
      } else if(var2) {
        while(self secondaryoffhandbuttonPressed()) {
          waitframe();
        }
      }
    }

    waitframe();
  }
}

function getplayertospectate(var0, var1, var2) {
  var3 = 0;

  if(isDefined(var1)) {
    for(var4 = 0; var4 < level.teamdata[var0]["alivePlayers"].size; var4++) {
      var5 = level.teamdata[var0]["alivePlayers"][var4];

      if(var5 == var1) {
        var3 = var4;
        break;
      }
    }
  }

  if(var2) {
    var3 = (var3 + 1) % level.teamdata[var0]["alivePlayers"].size;
  } else {
    var3--;

    if(var3 < 0) {
      var3 = level.teamdata[var0]["alivePlayers"].size - 1;
    }
  }

  return level.teamdata[var0]["alivePlayers"][var3];
}

function playerkeeploadingstreamedassets() {
  self endon("disconnect");
  self waittill("spawned");
  self endon("spawned");

  for(;;) {
    var0 = scripts\mp\class::preloadandqueueclass(self.class, 1);
    var1 = scripts\mp\playerlogic::getplayerassets(var0);

    while(!scripts\mp\playerlogic::allplayershaveassetsloaded(var1)) {
      wait 0.1;
    }

    while(scripts\mp\playerlogic::allplayershaveassetsloaded(var1)) {
      wait 1;
    }
  }
}

function playertrytakedefibrillator(var0) {
  if(isalive(self) && isDefined(var0) && isDefined(var0.basename) && var0.basename == "iw8_defibrillator_mp" && self hasweapon("iw8_defibrillator_mp")) {
    self takeweapon("iw8_defibrillator_mp");
    var1 = self getweaponslistprimaries();

    if(var1.size > 0 && !scripts\mp\utility\weapon::update_health_bar_to_player(var1[0])) {
      self switchtoweapon(var1[0]);
    } else if(var1.size > 1 && !scripts\mp\utility\weapon::update_health_bar_to_player(var1[1])) {
      self switchtoweapon(var1[1]);
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

function useentrespawntimeout(var0, var1, var2) {
  self endon("respawnComplete");
  var1 scripts\engine\utility::ref_143bf(var0, "disconnect");
  self notify("timeout");
  waittillframeend();

  foreach(var4 in level.teamdata[var2]["players"]) {
    if(isDefined(var4) && isDefined(var4.usedambulance) && isDefined(self.ambulance) && var4.usedambulance == self.ambulance) {
      var4 notify("defibrillator_done");
    }
  }

  if(isDefined(var1)) {
    playerfakespectate(var1, 0);
    var1 thread scripts\mp\playerlogic::spawnspectator(var1.respawnent.origin, var1.respawnent.angles);
  }

  cleanupbodydrop(self, var2);
}

function useentrespawncomplete(var0, var1) {
  self endon("timeout");
  var0 endon("disconnect");
  self waittill("respawnComplete", var2);

  if(istrue(var2)) {
    if(isDefined(var0.body)) {
      var0.body delete();
    }

    playerrespawn(var0, self.origin, self.angles);
  } else if(isDefined(var0)) {
    playerfakespectate(var0, 0);
    var0 thread scripts\mp\playerlogic::spawnspectator(var0.respawnent.origin, var0.respawnent.angles);
  }

  waittillframeend();
  cleanupbodydrop(self, var1);
}

function playerrespawn(var0, var1) {
  playerfakespectate(0);
  self.forcespawnorigin = var0;
  self.forcespawnangles = var1;
  self.isrespawn = 1;
  self.alreadyaddedtoalivecount = 1;
  scripts\mp\playerlogic::spawnplayer(0, 0);
}

function useentpickupbody(var0, var1) {
  self endon("respawnComplete");
  self endon("timeout");
  var0 endon("disconnect");

  for(;;) {
    self waittill("trigger", var2);

    if(isDefined(var0.body)) {
      var0.body delete();
    }

    if(var2.team != var1) {
      continue;
    }

    useenthide(var1);
    playerpickupbody(var2, self, var1);
    useentshow(var1);
  }
}

function useenthide(var0) {
  self makeunusable();
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
}

function useentshow(var0) {
  self makeusable();
  scripts\mp\objidpoolmanager::objective_teammask_single(self.objectiveiconid, var0);
  objective_setplayintro(self.objectiveiconid, 0);
}

function playerpickupbody(var0, var1) {
  self endon("droppedBody");
  var2 = scripts\mp\hud_util::createfontstring("default", 1.5);
  var2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 120);
  var2.label = &"MP/BR_RESPAWN_BODY";
  self.holdingbodyhud = var2;

  if(isDefined(var0.ambulance)) {
    ambulancedisabletoteam(var0.ambulance, var1);
    var0.ambulance = undefined;
  }

  var0 scriptmodelplayanim("sdr_cp_hostage_walk_hostage");
  var0 linkTo(self, "j_clavicle_le", (0, 0, 0), (0, 0, 0));
  thread useentdropbodyonplayerdone(var0, self, var2);
  thread useentdropbodywhencomplete(var0, self, var2);
  thread useentmonitorambulances(var0);
  self allowads(0);
  self allowcrouch(0);
  self allowprone(0);
  self allowjump(0);
  playersetcarryteammates(1);
  showallambulancesforteam(var1);

  foreach(var4 in level.teamdata[var1]["players"]) {
    if(isDefined(var4)) {
      var4 notify("defibrillator_done");
      var4 thread scripts\mp\hud_message::showsplash("br_respawn_start");
    }
  }

  while(!self stancebuttonPressed() || !self isonground()) {
    waitframe();
  }

  dropbody(var0, self, var2, var1);
}

function playersetcarryteammates(var0) {
  self.carrying = var0;
  var1 = level.teamdata[self.team]["players"];

  foreach(var3 in var1) {
    if(isDefined(var3.respawnent)) {
      if(!var0) {
        var3.respawnent enableplayeruse(self);
        continue;
      }

      var3.respawnent disableplayeruse(self);
    }
  }
}

function useentdropbodyonplayerdone(var0, var1, var2) {
  self endon("droppedBody");
  var0 scripts\engine\utility::ref_143a6("disconnect", "death", "last_stand_start");
  dropbody(self, var0, var1, var2);
}

function useentdropbodywhencomplete(var0, var1, var2) {
  self endon("droppedBody");
  scripts\engine\utility::ref_143a5("timeout", "respawnComplete");
  dropbody(self, var0, var1, var2);
}

function dropbody(var0, var1, var2, var3) {
  if(isDefined(var1)) {
    var1 allowads(1);
    var1 allowcrouch(1);
    var1 allowprone(1);
    var1 allowjump(1);
    playersetcarryteammates(var1, 0);
  }

  if(isDefined(var2)) {
    var2 destroy();
  }

  if(var0 islinked()) {
    var0 unlink();
  }

  var4 = undefined;

  if(isDefined(var1)) {
    var0.angles = var1.angles;
    var4 = var1.origin;
    var0.origin = var4 + (0, 0, 40);
  } else {
    var4 = var0.origin;
    var0.origin = var4 + (0, 0, 40);
  }

  var0.drophud.alpha = 0;
  useentsetupcloseambulance(var0, var3);
  var0 scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  var0 scriptmodelpauseanim(1);
  var0.origin = var4 + (0, 0, 1);
  var0 notify("droppedBody");
}

function useentsetupcloseambulance(var0) {
  var1 = getcloseambulance(self.origin);

  if(isDefined(var1)) {
    self.ambulance = var1;
    ambulanceenabletoteam(var1, var0);
    return;
  }
}

function createpickupuseent(var0, var1) {
  var2 = spawn("script_model", var0 + (0, 0, 1));
  var2 setModel("fullbody_usmc_ar_scriptmover");
  var2 scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  var2 scriptmodelpauseanim(1);
  var2 makeusable();
  var2 setCursorHint("HINT_NOICON");
  var2 setuseholdduration("duration_medium");
  var2 setuserange(120);
  var2 setHintString(&"MP/BR_PICKUP_PLAYER");
  var2 setusepriority(0);
  var2 hudoutlineenable("outlinefill_nodepth_red");

  foreach(var4 in level.players) {
    if(!isDefined(var4)) {
      continue;
    }

    if(var4.team == var1) {
      var2 hudoutlineenableforclient(var4, "outlinefill_nodepth_red");

      if(!istrue(var4.carrying)) {
        var2 enableplayeruse(var4);
      }

      continue;
    }

    var2 disableplayeruse(var4);
    var2 hudoutlinedisableforclient(var4);
  }

  var6 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  var2.objectiveiconid = var6;

  if(var6 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var6, "invisible", (0, 0, 0));
    scripts\mp\objidpoolmanager::update_objective_onentity(var6, var2);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var6, 40);
    scripts\mp\objidpoolmanager::update_objective_state(var6, "current");
    scripts\mp\objidpoolmanager::update_objective_icon(var6, "passive_icon_health_on_kill");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var6, 1);
    scripts\mp\objidpoolmanager::objective_teammask_single(var6, var1);
  }

  return var2;
}

function createplayerdeadcountdownhud(var0, var1) {
  var2 = scripts\mp\hud_util::createservertimer("objective", 1.4, var0);
  var2.label = &"MP/BR_RESPAWN_DEATH_COUNTDOWN";
  var2 settimer(var1);
  var2.starttime = gettime();
  thread countdownhudpulse(var2);
  return var2;
}

function countdownhudpulse(var0) {
  var1 = 0.5;
  var2 = 2;
  var3 = var0.fontscale;
  var0 changefontscaleovertime(var1);
  var0.fontscale = var2;
  wait var1;

  if(isDefined(var0)) {
    var0 changefontscaleovertime(var1);
    var0.fontscale = var3;
    return;
  }
}

function cleanupbodydrop(var0, var1) {
  if(isDefined(var0.timerhud)) {
    var0.timerhud destroy();
  }

  updatecountdownhudlist();

  if(isDefined(var0.drophud)) {
    var0.drophud destroy();
  }

  if(isDefined(var0.ambulance)) {
    ambulancedisabletoteam(var0.ambulance, var1);
    var0.ambulance = undefined;
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  var0 delete();
  hideallambulancesforteam(var1, 1);
}

function useentmonitorambulances(var0) {
  self endon("droppedBody");
  var1 = 0;

  for(;;) {
    var2 = 0;

    for(var3 = 0; var3 < level.br_respawnambulances.size; var3++) {
      var4 = level.br_respawnambulances[var3];

      if(!isDefined(var4) || istrue(var4.disabled)) {
        continue;
      }

      var5 = var4.origin;

      foreach(var7 in level.teamdata[var0]["players"]) {
        if(!isDefined(var7)) {
          continue;
        }

        var8 = distancesquared(var5, var7.origin);

        if(var8 < 65536) {
          var2 = 1;
          break;
        }
      }

      if(var2) {
        break;
      }
    }

    if(!var1 && var2) {
      self.drophud.alpha = 1;
    } else if(var1 && !var2) {
      self.drophud.alpha = 0;
    }

    var1 = var2;
    wait 0.1;
  }
}

function createdropplayerhud(var0) {
  var1 = 1.3;
  var2 = newteamhudelem(var0);
  var2.elemtype = "font";
  var2.font = "default";
  var2.fontscale = var1;
  var2.basefontscale = var1;
  var2.x = 0;
  var2.y = 0;
  var2.width = 0;
  var2.height = int(level.fontheight * var1);
  var2.xoffset = 0;
  var2.yoffset = 0;
  var2.children = [];
  var2 scripts\mp\hud_util::setparent(level.uiparent);
  var2.hidden = 0;
  var2.alpha = 0;
  var2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 100);
  var2.label = &"MP/BR_RESPAWN_DROP_BODY";
  return var2;
}

function getrespawnableplayers(var0) {
  var1 = level.teamdata[var0]["players"];
  var2 = [];

  foreach(var4 in var1) {
    if(isDefined(var4.respawnent)) {
      var2 = var4;
    }
  }

  return var2;
}

function getallrespawnableplayers() {
  var0 = [];

  foreach(var2 in level.players) {
    if(isDefined(var2.respawnent)) {
      var0 = var2;
    }
  }

  return var0;
}

function getcloseambulance(var0) {
  for(var1 = 0; var1 < level.br_respawnambulances.size; var1++) {
    var2 = level.br_respawnambulances[var1];

    if(!isDefined(var2) || istrue(var2.disabled)) {
      continue;
    }

    var3 = distancesquared(var2.origin, var0);

    if(var3 < 65536) {
      return var2;
    }
  }
}

function ambulancedefibrillator(var0) {
  if(var0 hasweapon("iw8_defibrillator_mp")) {
    var0 switchtoweapon("iw8_defibrillator_mp");
    return;
  }

  thread ambulancedosiren();
  var0.usedambulance = self;
  self.defibrillator hide();
  var1 = playergivedefibrillator(var0, self);

  if(isDefined(var0)) {
    var0 notify("defibrillator_done");
    var0.usedambulance = undefined;
  }

  self.defibrillator show();

  if(isDefined(var1)) {
    var1.respawnent notify("respawnComplete", 1);
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

function playergivedefibrillator(var0) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");
  var1 = getrespawnableplayers(self.team);

  if(var1.size == 0) {
    self iprintlnbold("No dead teammates");
    return;
  }

  self.lastweaponrespawn = self getcurrentprimaryweapon();
  var2 = getcompleteweaponname("iw8_defibrillator_mp");
  self giveweapon(var2);
  self switchtoweapon(var2);
  thread playermonitorweaponchange(var2);
  thread playertakeawaydefibrillator(var2);
  thread playermonitordistancefromambulance(var0);
  return playerdodefibrillator(1);
}

function playerdodefibrillator(var0) {
  for(;;) {
    self waittill("melee_fired", var1);
    var2 = 0;

    if(var1.basename != "iw8_defibrillator_mp") {
      if(!self hasweapon("iw8_defibrillator_mp")) {
        return;
      }

      continue;
    }

    var3 = self getEye();
    var4 = anglesToForward(self getplayerangles());
    var5 = getrespawnableplayers(self.team);
    var6 = 0;

    for(var7 = 0; var7 < var5.size; var7++) {
      var8 = var5[var7];

      if(!isDefined(var8) || !isDefined(var8.respawnent)) {
        continue;
      }

      var6 = 1;
      var9 = var8.respawnent.origin + (0, 0, 40);
      var10 = vectorNormalize(var9 - var3);
      var11 = vectordot(var10, var4);

      if(var11 < 0.5) {
        continue;
      }

      var12 = distancesquared(self.origin, var9);

      if(var12 > 10000) {
        continue;
      }

      return var8;
    }

    if(!var6 && istrue(var0)) {
      self iprintlnbold("No teammates to revive");
      return;
    }
  }
}

function playermonitorweaponchange(var0) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");

  for(;;) {
    self waittill("weapon_change", var1);

    if(!isnullweapon(var0, var1)) {
      self notify("defibrillator_done");
      return;
    }
  }
}

function playertakeawaydefibrillator(var0) {
  scripts\engine\utility::ref_143a6("death", "disconnect", "last_stand_start", "defibrillator_done");

  if(isDefined(self) && self hasweapon(var0)) {
    self takeweapon(var0);
    self switchtoweapon(self.lastweaponrespawn);
    return;
  }
}

function playermonitordistancefromambulance(var0) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");

  for(;;) {
    var1 = distancesquared(var0.origin, self.origin);

    if(var1 > 65536) {
      self notify("defibrillator_done");
      return;
    }

    wait 0.1;
  }
}

function giveweaponpickup(var0) {
  self endon("death");
  self endon("disconnect");

  if(!istrue(level.br_respawn_enabled)) {
    return;
  }

  if(var0 != "iw8_defibrillator_mp") {
    return;
  }

  var1 = playerdoportabledefibrillator();

  if(isDefined(var1)) {
    if(isDefined(var1.body)) {
      var1.body delete();
    }

    var1.respawnent notify("respawnComplete", 1);
  }

  var2 = getcompleteweaponname("iw8_defibrillator_mp");
  playertrytakedefibrillator(var2);
}

function playerdoportabledefibrillator() {
  self endon("portable_defibrillator_done");
  return playerdodefibrillator();
}