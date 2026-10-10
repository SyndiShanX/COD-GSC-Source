/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_respawn.gsc
**************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\weapon;
#namespace br_respawn;

function init() {
  setdvarifuninitialized(@ "hash_4c86ec08060dc308", 0);
  level.br_respawn_enabled = getdvarint(@ "hash_4c86ec08060dc308", 0) != 0;

  if(!istrue(level.br_respawn_enabled)) {
    removeambulances();
    return;
  }

  level._effect["ambulance_light"] = loadfx("vfx/iw8/level/stpetersburg/vfx_stpburg_police_lights.vfx");
  level.br_respawnambulances = [];
  scripts\mp\gametypes\br_circle::registercirclecallbacks(6, &dangercircletick);
  thread setuphud();

  thread debugrespawn();
}

function removeambulances() {
  var_aa43b883cba2c7fd = getStructArray("br_respawn_station", "targetname");

  for(i = 0; i < var_aa43b883cba2c7fd.size; i++) {
    collision = getEnt(var_aa43b883cba2c7fd[i].target, "targetname");

    if(isDefined(collision)) {
      collision delete();
    }
  }
}

function spawnambulance(struct) {
  if(!istrue(level.br_respawn_enabled)) {
    return undefined;
  }

  ambulance = spawn("script_model", struct.origin);

  if(isDefined(struct.angles)) {
    ambulance.angles = struct.angles;
  } else {
    ambulance.angles = (0, 0, 0);
  }

  ambulance setModel("veh8_civ_lnd_palfa_ambulance_ukraine");
  ambulance.struct = struct;
  ambulance ambulancesetup(struct);
  ambulance thread ambulancethink();
  level.br_respawnambulances[level.br_respawnambulances.size] = ambulance;
  return ambulance;
}

function ambulancesetup(struct) {
  thread ambulancelights();
  def_struct = getStruct(struct.target, "targetname");

  if(!isDefined(self.defibrillator)) {
    defibrillator = spawn("script_model", def_struct.origin);

    if(isDefined(def_struct.angles)) {
      defibrillator.angles = def_struct.angles;
    }

    defibrillator setModel("medical_defibrillator_wall_01");
    defibrillator makeusable();
    defibrillator setCursorHint("HINT_NOICON");
    defibrillator setuseholdduration("duration_medium");
    defibrillator sethintdisplayfov(120);
    defibrillator setusefov(120);
    defibrillator setuserange(80);
    defibrillator setHintString(&"MP/BR_RESPAWN_TAKE");
    defibrillator hudoutlineenable("outline_depth_red");
    defibrillator setusepriority(-1);
    defibrillator setasgametypeobjective();
    self.defibrillator = defibrillator;
  }

  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  self.objectiveiconid = objectiveiconid;

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "invisible", (0, 0, 0));
    scripts\mp\objidpoolmanager::update_objective_onentity(objectiveiconid, self);
    scripts\mp\objidpoolmanager::update_objective_state(objectiveiconid, "active");
    scripts\mp\objidpoolmanager::update_objective_icon(objectiveiconid, "hud_icon_respawn");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
  }
}

function ambulancelights() {
  wait 1;
  dir = anglesToForward(self.angles);
  self.fx = spawnfx(getfx("ambulance_light"), self.origin + (0, 0, 75), dir, (0, 0, 1));
  triggerfx(self.fx);
}

function ambulancethink() {
  self endon("death");

  while(true) {
    self.defibrillator waittill("trigger", player);
    ambulancedefibrillator(player);
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

function hideallambulancesforteam(team, var_7a6a0b6777c25197) {
  if(istrue(var_7a6a0b6777c25197)) {
    respawnableplayers = getrespawnableplayers(team);

    if(respawnableplayers.size > 0) {
      return;
    }
  }

  foreach(player in level.teamdata[team]["players"]) {
    if(isDefined(player)) {
      hideallambulancesforplayer(player);
    }
  }
}

function hideallambulancesforplayer(player) {
  for(i = 0; i < level.br_respawnambulances.size; i++) {
    ambulance = level.br_respawnambulances[i];

    if(isDefined(ambulance) && !istrue(ambulance.disabled)) {
      ambulance ambulancehidefromplayer(player);
    }
  }
}

function ambulancehidefromplayer(player) {
  if(isDefined(self.defibrillator)) {
    self.defibrillator hudoutlinedisableforclient(player);
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objectiveiconid, player);
}

function disableallambulancesforplayer(player) {
  for(i = 0; i < level.br_respawnambulances.size; i++) {
    ambulance = level.br_respawnambulances[i];

    if(isDefined(ambulance) && !istrue(ambulance.disabled)) {
      ambulance ambulancemakeunusabletoplayer(player);
    }
  }
}

function ambulancemakeunusabletoplayer(player) {
  if(isDefined(self.defibrillator)) {
    self.defibrillator disableplayeruse(player);
  }
}

function showallambulancesforteam(team) {
  foreach(player in level.teamdata[team]["players"]) {
    if(isDefined(player)) {
      showallambulancesforplayer(player);
    }
  }
}

function showallambulancesforplayer(player) {
  for(i = 0; i < level.br_respawnambulances.size; i++) {
    ambulance = level.br_respawnambulances[i];

    if(isDefined(ambulance) && !istrue(ambulance.disabled)) {
      ambulance ambulanceshowtoplayer(player);
    }
  }
}

function ambulanceshowtoplayer(player) {
  self.defibrillator hudoutlineenableforclient(player, "outline_depth_red");
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objectiveiconid, player);
}

function ambulanceenabletoteam(team) {
  foreach(player in level.teamdata[team]["players"]) {
    if(isDefined(player)) {
      ambulancemakeusabletoplayer(player);
    }
  }
}

function ambulancedisabletoteam(team) {
  foreach(player in level.teamdata[team]["players"]) {
    if(isDefined(player)) {
      ambulancemakeunusabletoplayer(player);
    }
  }
}

function ambulancemakeusabletoplayer(player) {
  self.defibrillator enableplayeruse(player);
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
  }
}

function ambulancemakeunsabletoall() {
  self.defibrillator setHintString(&"MP/BR_RESPAWN_CHARGING");
  self.defibrillator setuseholdduration("duration_none");
}

function ambulancemakeusable() {
  self.defibrillator setHintString(&"MP/BR_RESPAWN_TAKE");
  self.defibrillator setuseholdduration("duration_medium");
  players = getallrespawnableplayers();

  foreach(player in players) {
    player.respawnent useentsetupcloseambulance(player.team);
  }
}

function anyambulancesavailable() {
  for(i = 0; i < level.br_respawnambulances.size; i++) {
    ambulance = level.br_respawnambulances[i];

    if(isDefined(ambulance) && !istrue(ambulance.disabled)) {
      return true;
    }
  }

  return false;
}

function dangercircletick(dangercircleorigin, dangercircleradius, thresholdradius) {
  var_52d59c928eb97c81 = dangercircleradius + thresholdradius;

  if(!istrue(level.br_respawn_enabled)) {
    return;
  }

  for(i = 0; i < level.br_respawnambulances.size; i++) {
    ambulance = level.br_respawnambulances[i];

    if(isDefined(ambulance) && !istrue(ambulance.disabled) && distance2dsquared(dangercircleorigin, ambulance.origin) > var_52d59c928eb97c81 * var_52d59c928eb97c81) {
      ambulance ambulancedisable();
      disablerespawnscenarios(ambulance);
    }
  }
}

function disablerespawnscenarios(ambulance) {
  disableall = !anyambulancesavailable();

  if(!disableall && !isDefined(ambulance)) {
    return;
  }

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(isDefined(player.respawnent) && disableall) {
      player.respawnent notify("respawnComplete", 0);
      continue;
    }

    if(isDefined(ambulance) && isDefined(player.usedambulance) && player.usedambulance == ambulance) {
      player notify("defibrillator_done");
      player notify("portable_defibrillator_done");
    }
  }
}

function playershoulddofauxdeath() {
  return istrue(level.br_respawn_enabled) && anyambulancesavailable() && (istrue(self.brwasinlaststand) || isDefined(self.respawnent));
}

function playersetinlaststand() {
  self.brwasinlaststand = 1;
  scripts\mp\gametypes\br_public::setplayerdownedextrainfo(1);
}

function playerdied(attacker, objweapon) {
  if(!istrue(level.br_respawn_enabled)) {
    return;
  }

  if(isDefined(attacker)) {
    attacker playertrytakedefibrillator(objweapon);
  }

  if(!anyambulancesavailable()) {
    if(istrue(self.fauxdead)) {
      thread scripts\mp\playerlogic::spawnspectator(self.origin, self.angles);
    }

    return;
  }

  self.brwasinlaststand = undefined;
  team = self.team;

  if(getdvarint(@ "hash_f315dc496ea2abba", 0) != 0) {
    host = scripts\mp\gamelogic::gethostplayer();
    team = host.team;
  }

  if(level.teamdata[team]["alivePlayers"].size == 0) {
    foreach(player in level.teamdata[team]["players"]) {
      if(!isDefined(player)) {
        continue;
      }

      if(isDefined(player.respawnent)) {
        player.respawnent notify("respawnComplete", 0);
      }
    }

    return;
  }

  if(isDefined(self.body)) {
    self.body delete();
  } else {
    self.nocorpse = 1;
  }

  function_a593971d75d82113();
  function_379bb555405c16bb("br_respawn::playerDied()");
  self.health = 1;
  thread playerkeeploadingstreamedassets();
  useent = createpickupuseent(self.origin, team);
  useent.timerhud = createplayerdeadcountdownhud(team, 180);
  updatecountdownhudlist(useent.timerhud);
  useent.drophud = createdropplayerhud(team);
  useent thread useentrespawntimeout(180, self, team);
  useent thread useentrespawncomplete(self, team);
  useent thread useentpickupbody(self, team);
  useent useentsetupcloseambulance(team);
  self.respawnent = useent;
  playerfakespectate(1);
}

function updatecountdownhudlist(timerhud) {
  var_85ae1e2ec737a227 = -50;
  var_85ae1d2ec7379ff4 = -100;
  var_88939a74db0edc4e = -15;

  if(isDefined(timerhud)) {
    level.br_deadcountdownhud[level.br_deadcountdownhud.size] = timerhud;
  }

  for(i = 1; i < level.br_deadcountdownhud.size; i++) {
    huditem = level.br_deadcountdownhud[i];

    for(j = i - 1; j >= 0 && getsoonerhud(huditem, level.br_deadcountdownhud[j]) == huditem; j--) {
      level.br_deadcountdownhud[j + 1] = level.br_deadcountdownhud[j];
    }

    level.br_deadcountdownhud[j + 1] = huditem;
  }

  for(i = 0; i < level.br_deadcountdownhud.size; i++) {
    huditem = level.br_deadcountdownhud[i];

    if(isDefined(huditem)) {
      huditem scripts\mp\hud_util::setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", var_85ae1e2ec737a227, var_85ae1d2ec7379ff4 + var_88939a74db0edc4e * i);
    }
  }
}

function getsoonerhud(huda, hudb) {
  if(!isDefined(hudb)) {
    return huda;
  }

  if(!isDefined(huda)) {
    return hudb;
  }

  if(huda.starttime <= hudb.starttime) {
    return huda;
  }

  return hudb;
}

function playerfakespectate(enabled) {
  allowactions = !enabled;
  self allowmelee(allowactions);
  self allowads(allowactions);
  self allowfire(allowactions);
  self allowcrouch(allowactions);
  self allowprone(allowactions);
  self allowreload(allowactions);
  self setCanDamage(allowactions);

  if(allowactions) {
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
  var_e4087badb9bb99d1 = undefined;

  while(true) {
    next = self fragButtonPressed();
    prev = self secondaryoffhandbuttonPressed();

    if(next || prev || !isDefined(var_e4087badb9bb99d1) || !isalive(var_e4087badb9bb99d1) || isDefined(var_e4087badb9bb99d1.respawnent) || istrue(var_e4087badb9bb99d1.fauxdead)) {
      var_d7487bbe79134c02 = getplayertospectate(self.team, var_e4087badb9bb99d1, next || !isDefined(var_e4087badb9bb99d1));

      if(!isDefined(var_e4087badb9bb99d1) || var_e4087badb9bb99d1 != var_d7487bbe79134c02) {
        var_e4087badb9bb99d1 = var_d7487bbe79134c02;
        self playerlinktodelta(var_e4087badb9bb99d1, "tag_eye");
        self setclientomnvar("ui_show_spectateHud", var_e4087badb9bb99d1 getentitynumber());
        function_a593971d75d82113();
        function_379bb555405c16bb("br_respawn::playerFakeSpectateControls()");
      }

      if(next) {
        while(self fragButtonPressed()) {
          waitframe();
        }
      } else if(prev) {
        while(self secondaryoffhandbuttonPressed()) {
          waitframe();
        }
      }
    }

    waitframe();
  }
}

function getplayertospectate(team, current, getnext) {
  curindex = 0;

  if(isDefined(current)) {
    for(i = 0; i < level.teamdata[team]["alivePlayers"].size; i++) {
      player = level.teamdata[team]["alivePlayers"][i];

      if(player == current) {
        curindex = i;
        break;
      }
    }
  }

  if(getnext) {
    curindex = (curindex + 1) % level.teamdata[team]["alivePlayers"].size;
  } else {
    curindex--;

    if(curindex < 0) {
      curindex = level.teamdata[team]["alivePlayers"].size - 1;
    }
  }

  return level.teamdata[team]["alivePlayers"][curindex];
}

function playerkeeploadingstreamedassets() {
  self endon("disconnect");
  self waittill("spawned");
  self endon("spawned");

  while(true) {
    loadoutstruct = scripts\mp\class::preloadandqueueclass(self.class, 1);
    playerassets = scripts\mp\playerlogic::getplayerassets(loadoutstruct);

    while(!scripts\mp\playerlogic::allplayershaveassetsloaded(playerassets)) {
      wait 0.1;
    }

    while(scripts\mp\playerlogic::allplayershaveassetsloaded(playerassets)) {
      wait 1;
    }
  }
}

function playertrytakedefibrillator(objweapon) {
  if(isalive(self) && isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "iw8_defibrillator_mp" && self hasweapon("iw8_defibrillator_mp")) {
    self takeweapon("iw8_defibrillator_mp");
    weapons = self getweaponslistprimaries();

    if(weapons.size > 0 && !scripts\mp\utility\weapon::ismeleeoverrideweapon(weapons[0])) {
      self switchtoweapon(weapons[0]);
    } else if(weapons.size > 1 && !scripts\mp\utility\weapon::ismeleeoverrideweapon(weapons[1])) {
      self switchtoweapon(weapons[1]);
    } else if(self hasweapon("iw9_me_fists_mp")) {
      self switchtoweapon("iw9_me_fists_mp");
    } else {
      self giveweapon("iw9_me_fists_mp");
      self switchtoweapon("iw9_me_fists_mp");
    }

    self notify("defibrillator_done");
    self notify("portable_defibrillator_done");
  }
}

function useentrespawntimeout(countdowntime, deadplayer, team) {
  self endon("respawnComplete");
  deadplayer waittill_any_timeout_no_endon_death_1(countdowntime, "disconnect");
  self notify("timeout");
  waittillframeend();

  foreach(player in level.teamdata[team]["players"]) {
    if(isDefined(player) && isDefined(player.usedambulance) && isDefined(self.ambulance) && player.usedambulance == self.ambulance) {
      player notify("defibrillator_done");
    }
  }

  if(isDefined(deadplayer)) {
    deadplayer playerfakespectate(0);
    deadplayer thread scripts\mp\playerlogic::spawnspectator(deadplayer.respawnent.origin, deadplayer.respawnent.angles);
  }

  cleanupbodydrop(self, team);
}

function useentrespawncomplete(deadplayer, team) {
  self endon("timeout");
  deadplayer endon("disconnect");
  self waittill("respawnComplete", result);

  if(istrue(result)) {
    if(isDefined(deadplayer.body)) {
      deadplayer.body delete();
    }

    deadplayer playerrespawn(self.origin, self.angles);
  } else if(isDefined(deadplayer)) {
    deadplayer playerfakespectate(0);
    deadplayer thread scripts\mp\playerlogic::spawnspectator(deadplayer.respawnent.origin, deadplayer.respawnent.angles);
  }

  waittillframeend();
  cleanupbodydrop(self, team);
}

function playerrespawn(origin, angles) {
  playerfakespectate(0);
  self.forcespawnorigin = origin;
  self.forcespawnangles = angles;
  self.isrespawn = 1;
  self.alreadyaddedtoalivecount = 1;
  scripts\mp\playerlogic::spawnplayer(0, 0);
}

function useentpickupbody(deadplayer, team) {
  self endon("respawnComplete");
  self endon("timeout");
  deadplayer endon("disconnect");

  while(true) {
    self waittill("trigger", player);

    if(isDefined(deadplayer.body)) {
      deadplayer.body delete();
    }

    if(player.team != team) {
      continue;
    }

    useenthide(team);
    player playerpickupbody(self, team);
    useentshow(team);
  }
}

function useenthide(team) {
  self makeunusable();
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
}

function useentshow(team) {
  self makeusable();
  scripts\mp\objidpoolmanager::objective_teammask_single(self.objectiveiconid, team);
  objective_setplayintro(self.objectiveiconid, 0);
}

function playerpickupbody(useent, team) {
  self endon("droppedBody");
  holdingbodyhud = scripts\mp\hud_util::createfontstring("default", 1.5);
  holdingbodyhud scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 120);
  holdingbodyhud.label = &"MP/BR_RESPAWN_BODY";
  self.holdingbodyhud = holdingbodyhud;

  if(isDefined(useent.ambulance)) {
    useent.ambulance ambulancedisabletoteam(team);
    useent.ambulance = undefined;
  }

  useent scriptmodelplayanim("sdr_cp_hostage_walk_hostage");
  useent linkTo(self, "j_clavicle_le", (0, 0, 0), (0, 0, 0));
  useent thread useentdropbodyonplayerdone(self, holdingbodyhud, team);
  useent thread useentdropbodywhencomplete(self, holdingbodyhud, team);
  useent thread useentmonitorambulances(team);
  self allowads(0);
  self allowcrouch(0);
  self allowprone(0);
  self allowjump(0);
  playersetcarryteammates(1);
  showallambulancesforteam(team);

  foreach(player in level.teamdata[team]["players"]) {
    if(isDefined(player)) {
      player notify("defibrillator_done");
      player thread scripts\mp\hud_message::showsplash("br_respawn_start");
    }
  }

  while(!self stancebuttonPressed() || !self isonground()) {
    waitframe();
  }

  dropbody(useent, self, holdingbodyhud, team);
}

function playersetcarryteammates(carrying) {
  self.carrying = carrying;
  teammates = level.teamdata[self.team]["players"];

  if(getdvarint(@ "hash_f315dc496ea2abba", 0) != 0) {
    teammates = level.players;
  }

  foreach(player in teammates) {
    if(isDefined(player.respawnent)) {
      if(!carrying) {
        player.respawnent enableplayeruse(self);
        continue;
      }

      player.respawnent disableplayeruse(self);
    }
  }
}

function useentdropbodyonplayerdone(playerholding, holdingbodyhud, team) {
  self endon("droppedBody");
  playerholding waittill_any_3("disconnect", "death", "last_stand_start");
  dropbody(self, playerholding, holdingbodyhud, team);
}

function useentdropbodywhencomplete(playerholding, holdingbodyhud, team) {
  self endon("droppedBody");
  waittill_any_2("timeout", "respawnComplete");
  dropbody(self, playerholding, holdingbodyhud, team);
}

function dropbody(useent, playerholding, holdingbodyhud, team) {
  if(isDefined(playerholding)) {
    playerholding allowads(1);
    playerholding allowcrouch(1);
    playerholding allowprone(1);
    playerholding allowjump(1);
    playerholding playersetcarryteammates(0);
  }

  if(isDefined(holdingbodyhud)) {
    holdingbodyhud destroy();
  }

  if(useent islinked()) {
    useent unlink();
  }

  origin = undefined;

  if(isDefined(playerholding)) {
    useent.angles = playerholding.angles;
    origin = playerholding.origin;
    useent.origin = origin + (0, 0, 40);
  } else {
    origin = useent.origin;
    useent.origin = origin + (0, 0, 40);
  }

  useent.drophud.alpha = 0;
  useent useentsetupcloseambulance(team);
  useent scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  useent scriptmodelpauseanim(1);
  useent.origin = origin + (0, 0, 1);
  useent notify("droppedBody");
}

function useentsetupcloseambulance(team) {
  ambulance = getcloseambulance(self.origin);

  if(isDefined(ambulance)) {
    self.ambulance = ambulance;
    ambulance ambulanceenabletoteam(team);
  }
}

function createpickupuseent(origin, team) {
  useent = spawn("script_model", origin + (0, 0, 1));
  useent setModel("fullbody_usmc_ar_scriptmover");
  useent scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  useent scriptmodelpauseanim(1);
  useent makeusable();
  useent setCursorHint("HINT_NOICON");
  useent setuseholdduration("duration_medium");
  useent setuserange(120);
  useent setHintString(&"MP/BR_PICKUP_PLAYER");
  useent setusepriority(0);
  useent hudoutlineenable("outlinefill_nodepth_red");

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(player.team == team) {
      useent hudoutlineenableforclient(player, "outlinefill_nodepth_red");

      if(!istrue(player.carrying)) {
        useent enableplayeruse(player);
      }

      continue;
    }

    useent disableplayeruse(player);
    useent hudoutlinedisableforclient(player);
  }

  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  useent.objectiveiconid = objectiveiconid;

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "invisible", (0, 0, 0));
    scripts\mp\objidpoolmanager::update_objective_onentity(objectiveiconid, useent);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(objectiveiconid, 40);
    scripts\mp\objidpoolmanager::update_objective_state(objectiveiconid, "current");
    scripts\mp\objidpoolmanager::update_objective_icon(objectiveiconid, "passive_icon_health_on_kill");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_teammask_single(objectiveiconid, team);
  }

  return useent;
}

function createplayerdeadcountdownhud(team, countdowntime) {
  timerhud = scripts\mp\hud_util::createservertimer("objective", 1.4, team);
  timerhud.label = &"MP/BR_RESPAWN_DEATH_COUNTDOWN";
  timerhud settimer(countdowntime);
  timerhud.starttime = gettime();
  thread countdownhudpulse(timerhud);
  return timerhud;
}

function countdownhudpulse(timerhud) {
  var_cc2c2f3eac3c7bd2 = 0.5;
  var_5f2809f4e8852c13 = 2;
  originalscale = timerhud.fontscale;
  timerhud changefontscaleovertime(var_cc2c2f3eac3c7bd2);
  timerhud.fontscale = var_5f2809f4e8852c13;
  wait var_cc2c2f3eac3c7bd2;

  if(isDefined(timerhud)) {
    timerhud changefontscaleovertime(var_cc2c2f3eac3c7bd2);
    timerhud.fontscale = originalscale;
  }
}

function cleanupbodydrop(useent, team) {
  if(isDefined(useent.timerhud)) {
    useent.timerhud destroy();
  }

  updatecountdownhudlist();

  if(isDefined(useent.drophud)) {
    useent.drophud destroy();
  }

  if(isDefined(useent.ambulance)) {
    useent.ambulance ambulancedisabletoteam(team);
    useent.ambulance = undefined;
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  useent delete();
  hideallambulancesforteam(team, 1);
}

function useentmonitorambulances(team) {
  self endon("droppedBody");
  var_a9b8b5ab4910cb48 = 0;

  while(true) {
    anyoneclose = 0;

    for(i = 0; i < level.br_respawnambulances.size; i++) {
      ambulance = level.br_respawnambulances[i];

      if(!isDefined(ambulance) || istrue(ambulance.disabled)) {
        continue;
      }

      org = ambulance.origin;

      foreach(player in level.teamdata[team]["players"]) {
        if(!isDefined(player)) {
          continue;
        }

        distsq = distancesquared(org, player.origin);

        if(distsq < 65536) {
          anyoneclose = 1;
          break;
        }
      }

      if(anyoneclose) {
        break;
      }
    }

    if(!var_a9b8b5ab4910cb48 && anyoneclose) {
      self.drophud.alpha = 1;
    } else if(var_a9b8b5ab4910cb48 && !anyoneclose) {
      self.drophud.alpha = 0;
    }

    var_a9b8b5ab4910cb48 = anyoneclose;
    wait 0.1;
  }
}

function createdropplayerhud(team) {
  fontscale = 1.3;
  fontelem = newteamhudelem(team);
  fontelem.elemtype = "font";
  fontelem.font = "default";
  fontelem.fontscale = fontscale;
  fontelem.basefontscale = fontscale;
  fontelem.x = 0;
  fontelem.y = 0;
  fontelem.width = 0;
  fontelem.height = int(level.fontheight * fontscale);
  fontelem.xoffset = 0;
  fontelem.yoffset = 0;
  fontelem.children = [];
  fontelem scripts\mp\hud_util::setparent(level.uiparent);
  fontelem.hidden = 0;
  fontelem.alpha = 0;
  fontelem scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 100);
  fontelem.label = &"MP/BR_RESPAWN_DROP_BODY";
  return fontelem;
}

function getrespawnableplayers(team) {
  teammates = level.teamdata[team]["players"];

  if(getdvarint(@ "hash_f315dc496ea2abba", 0) != 0) {
    teammates = level.players;
  }

  respawnableplayers = [];

  foreach(player in teammates) {
    if(isDefined(player.respawnent)) {
      respawnableplayers[respawnableplayers.size] = player;
    }
  }

  return respawnableplayers;
}

function getallrespawnableplayers() {
  respawnableplayers = [];

  foreach(player in level.players) {
    if(isDefined(player.respawnent)) {
      respawnableplayers[respawnableplayers.size] = player;
    }
  }

  return respawnableplayers;
}

function getcloseambulance(point) {
  for(i = 0; i < level.br_respawnambulances.size; i++) {
    ambulance = level.br_respawnambulances[i];

    if(!isDefined(ambulance) || istrue(ambulance.disabled)) {
      continue;
    }

    distsq = distancesquared(ambulance.origin, point);

    if(distsq < 65536) {
      return ambulance;
    }
  }
}

function ambulancedefibrillator(player) {
  if(player hasweapon("iw8_defibrillator_mp")) {
    player switchtoweapon("iw8_defibrillator_mp");
    return;
  }

  thread ambulancedosiren();
  player.usedambulance = self;
  self.defibrillator hide();
  teammaterevived = player playergivedefibrillator(self);

  if(isDefined(player)) {
    player notify("defibrillator_done");
    player.usedambulance = undefined;
  }

  self.defibrillator show();

  if(isDefined(teammaterevived)) {
    teammaterevived.respawnent notify("respawnComplete", 1);
    ambulancedelayreuse();
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

function playergivedefibrillator(ambulance) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");
  deadteammates = getrespawnableplayers(self.team);

  if(deadteammates.size == 0) {
    self iprintlnbold("No dead teammates");
    return;
  }

  self.lastweaponrespawn = self getcurrentprimaryweapon();
  var_5b1c712938e3abf = makeweapon("iw8_defibrillator_mp");
  self giveweapon(var_5b1c712938e3abf);
  self switchtoweapon(var_5b1c712938e3abf);
  thread playermonitorweaponchange(var_5b1c712938e3abf);
  thread playertakeawaydefibrillator(var_5b1c712938e3abf);
  thread playermonitordistancefromambulance(ambulance);
  return playerdodefibrillator(1);
}

function playerdodefibrillator(var_7a30df5c798ab7ee) {
  while(true) {
    self waittill("melee_fired", objweapon);
    var_ffc368c1d2a95b7b = 0;

    if(objweapon.basename != "iw8_defibrillator_mp") {
      if(!self hasweapon("iw8_defibrillator_mp")) {
        return;
      }

      continue;
    }

    eye = self getEye();
    dirfacing = anglesToForward(self getplayerangles());
    deadteammates = getrespawnableplayers(self.team);
    var_de0a18979ff9a55e = 0;

    for(i = 0; i < deadteammates.size; i++) {
      teammate = deadteammates[i];

      if(!isDefined(teammate) || !isDefined(teammate.respawnent)) {
        continue;
      }

      var_de0a18979ff9a55e = 1;
      origin = teammate.respawnent.origin + (0, 0, 40);
      var_16cbde366e22c3ad = vectorNormalize(origin - eye);
      dot = vectordot(var_16cbde366e22c3ad, dirfacing);

      if(dot < 0.5) {
        continue;
      }

      distsq = distancesquared(self.origin, origin);

      if(distsq > 10000) {
        continue;
      }

      return teammate;
    }

    if(!var_de0a18979ff9a55e && istrue(var_7a30df5c798ab7ee)) {
      self iprintlnbold("No teammates to revive");
      return;
    }
  }
}

function playermonitorweaponchange(var_5b1c712938e3abf) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");

  while(true) {
    self waittill("weapon_change", newweapon);

    if(!issameweapon(var_5b1c712938e3abf, newweapon)) {
      self notify("defibrillator_done");
      return;
    }
  }
}

function playertakeawaydefibrillator(var_5b1c712938e3abf) {
  waittill_any_4("death", "disconnect", "last_stand_start", "defibrillator_done");

  if(isDefined(self) && self hasweapon(var_5b1c712938e3abf)) {
    self takeweapon(var_5b1c712938e3abf);
    self switchtoweapon(self.lastweaponrespawn);
  }
}

function playermonitordistancefromambulance(ambulance) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");

  while(true) {
    distsq = distancesquared(ambulance.origin, self.origin);

    if(distsq > 65536) {
      self notify("defibrillator_done");
      return;
    }

    wait 0.1;
  }
}

function giveweaponpickup(weaponname) {
  self endon("death");
  self endon("disconnect");

  if(!istrue(level.br_respawn_enabled)) {
    return;
  }

  if(weaponname != "iw8_defibrillator_mp") {
    return;
  }

  teammate = playerdoportabledefibrillator();

  if(isDefined(teammate)) {
    if(isDefined(teammate.body)) {
      teammate.body delete();
    }

    teammate.respawnent notify("respawnComplete", 1);
  }

  var_5b1c712938e3abf = makeweapon("iw8_defibrillator_mp");
  playertrytakedefibrillator(var_5b1c712938e3abf);
}

function playerdoportabledefibrillator() {
  self endon("portable_defibrillator_done");
  return playerdodefibrillator();
}

function debugrespawn() {
  setdvarifuninitialized(@ "hash_f315dc496ea2abba", 0);
  setdvarifuninitialized(@ "hash_17d2b0226f2a84db", "<dev string:x1c>");

  while(true) {
    cmd = getDvar(@ "hash_17d2b0226f2a84db", "<dev string:x1c>");

    if(cmd != "<dev string:x1c>") {
      setDvar(@ "hash_17d2b0226f2a84db", "<dev string:x1c>");

      if(cmd == "<dev string:x20>") {
        for(i = 0; i < level.br_respawnambulances.size; i++) {
          ambulance = level.br_respawnambulances[i];

          if(isDefined(ambulance) && !istrue(ambulance.disabled)) {
            ambulance ambulancedisable();
            disablerespawnscenarios(ambulance);
          }
        }
      } else if(cmd == "<dev string:x36>") {
        for(i = 0; i < level.br_respawnambulances.size; i++) {
          ambulance = level.br_respawnambulances[i];

          if(isDefined(ambulance) && istrue(ambulance.disabled)) {
            ambulance.disabled = undefined;
            ambulance ambulancesetup(ambulance.struct);
          }
        }
      } else if(cmd == "<dev string:x4b>") {
        host = scripts\mp\gamelogic::gethostplayer();
        bot = getbot(host);

        if(isDefined(bot) && isDefined(host.respawnent)) {
          host.respawnent notify("<dev string:x55>", bot);
        }
      } else if(cmd == "<dev string:x60>") {
        host = scripts\mp\gamelogic::gethostplayer();

        if(isDefined(host.respawnent)) {
          host.respawnent notify("<dev string:x6b>", 1);
        }
      } else if(cmd == "<dev string:x7e>") {
        host = scripts\mp\gamelogic::gethostplayer();
        bot = getbot(host);

        if(isDefined(host.respawnent) && istrue(bot.carrying)) {
          thread dropbody(host.respawnent, bot, bot.holdingbodyhud, host.team);
        }
      } else if(cmd == "<dev string:x86>") {
        host = scripts\mp\gamelogic::gethostplayer();
        botfriend = getbot(host, 0, 1);
        botenemy = getbot(host, 1);
        botfriend.donotmodifydamage = 1;
        botfriend dodamage(150, botenemy.origin, botenemy, botenemy, "<dev string:x8e>");
        botfriend.donotmodifydamage = undefined;
      } else if(cmd == "<dev string:x9b>") {
        host = scripts\mp\gamelogic::gethostplayer();
        botenemy = getbot(host, 1);
        var_5b1c712938e3abf = makeweapon("<dev string:xa7>");
        host.donotmodifydamage = 1;
        host dodamage(150, host.origin, botenemy, botenemy, "<dev string:x8e>", var_5b1c712938e3abf);
        host.donotmodifydamage = undefined;
      }
    }

    wait 0.1;
  }
}

function getbot(host, oppositeteam, alive) {
  foreach(player in level.players) {
    if(!isDefined(player) || istrue(alive) && (isDefined(player.respawnent) || istrue(player.fauxdead))) {
      continue;
    }

    if(isbot(player) || istestclient(player)) {
      if(!istrue(oppositeteam) && player.team == host.team || istrue(oppositeteam) && player.team != host.team) {
        return player;
      }
    }
  }
}

# /