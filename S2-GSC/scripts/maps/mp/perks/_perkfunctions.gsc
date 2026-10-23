/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\perks\_perkfunctions.gsc
****************************************************/

setcrouchmovement() {
  thread crouchstatelistener();
}

crouchstatelistener() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetCrouchMovement");

  for(;;) {
    _id_0513::updatemovespeedscale();
    waitframe();
  }
}

unsetcrouchmovement() {
  self notify("unsetCrouchMovement");
  _id_0513::updatemovespeedscale();
}

setpersonaluav() {
  var_0 = spawn("script_model", self.origin);
  var_0.team = self.team;
  var_0 makeportableradar(self);
  self.personalradar = var_0;
  thread radarmover(var_0);
}

radarmover(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("personal_uav_remove");
  self endon("personal_uav_removed");

  for(;;) {
    var_0 moveTo(self.origin, 0.05);
    waitframe();
  }
}

unsetpersonaluav() {
  if(isDefined(self.personalradar)) {
    self notify("personal_uav_removed");
    level _id_04F1::deleteportableradar(self.personalradar);
    self.personalradar = undefined;
  }
}

setoverkillpro() {}

unsetoverkillpro() {}

setempimmune() {}

unsetempimmune() {}

setregenspeed() {}

unsetregenspeed() {}

setsharpfocus() {
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    self setviewkickscale(0.0);
  } else {
    thread monitorsharpfocus();
  }
}

monitorsharpfocus() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("stopSharpFocusMonitor");
  self endon("stopSharpFocusMonitor");
  scaleflinchbasedonweapon(self getcurrentweapon());

  for(;;) {
    self waittill("weapon_change", var_0);
    scaleflinchbasedonweapon(var_0);
  }
}

scaleflinchbasedonweapon(var_0) {
  if(maps\mp\_utility::getweaponclass(var_0) == "weapon_sniper") {
    self setviewkickscale(0.35);
  } else {
    self setviewkickscale(0.9);
  }
}

unsetsharpfocus() {
  self notify("stopSharpFocusMonitor");
  self setviewkickscale(1);
}

setdoubleload() {
  self endon("death");
  self endon("disconnect");
  self endon("endDoubleLoad");
  level endon("game_ended");

  for(;;) {
    self waittill("reload");
    var_0 = self getweaponslist("primary");

    foreach(var_2 in var_0) {
      var_3 = self getweaponammoclip(var_2);
      var_4 = _weaponclipsize(var_2);
      var_5 = var_4 - var_3;
      var_6 = self getweaponammostock(var_2);

      if(var_3 != var_4 && var_6 > 0) {
        if(var_3 + var_6 >= var_4) {
          self setweaponammoclip(var_2, var_4);
          self setweaponammostock(var_2, var_6 - var_5);
          continue;
        }

        self setweaponammoclip(var_2, var_3 + var_6);

        if(var_6 - var_5 > 0) {
          self setweaponammostock(var_2, var_6 - var_5);
          continue;
        }

        self setweaponammostock(var_2, 0);
      }
    }
  }
}

unsetdoubleload() {
  self notify("endDoubleLoad");
}

setmarksman(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_0)) {
    var_0 = 10;
  } else {
    var_0 = int(var_0) * 2;
  }

  maps\mp\_utility::setrecoilscale(var_0);
  self.recoilscale = var_0;
}

unsetmarksman() {
  maps\mp\_utility::setrecoilscale(0);
  self.recoilscale = 0;
}

setstunresistance(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_0)) {
    self.stunscaler = 0.5;
  } else {
    self.stunscaler = int(var_0) / 10;
  }
}

unsetstunresistance() {
  self.stunscaler = 1;
}

setsteadyaimpro() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self setaimspreadmovementscale(0.5);
}

unsetsteadyaimpro() {
  self notify("end_SteadyAimPro");
  self setaimspreadmovementscale(1.0);
}

perkusedeathtracker() {
  self endon("disconnect");
  self waittill("death");
  self._id_073B = undefined;
}

setrearview() {}

unsetrearview() {
  self notify("end_perkUseTracker");
}

setendgame() {
  if(isDefined(self.endgame)) {
    return;
  }
  self.maxhealth = _id_0511::gettweakablevalue("player", "maxhealth") * 4;
  self.health = self.maxhealth;
  self.endgame = 1;
  self.attackertable[0] = "";
  self visionsetnakedforplayer("end_game", 5);
  thread endgamedeath(7);
  self.hasdonecombat = 1;
}

unsetendgame() {
  self notify("stopEndGame");
  self.endgame = undefined;
  maps\mp\_utility::revertvisionsetforplayer();

  if(!isDefined(self.endgametimer)) {
    return;
  }
  self.endgametimer maps\mp\gametypes\_hud_util::destroyelem();
  self.endgameicon maps\mp\gametypes\_hud_util::destroyelem();
}

endgamedeath(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self endon("stopEndGame");
  wait(var_0 + 1);
  maps\mp\_utility::_suicide();
}

stancestatelistener() {
  self endon("death");
  self endon("disconnect");
  self notifyonplayercommand("adjustedStance", "+stance");

  for(;;) {
    self waittill("adjustedStance");

    if(self.movespeedscaler != 0) {
      continue;
    }
    unsetsiege();
  }
}

jumpstatelistener() {
  self endon("death");
  self endon("disconnect");
  self notifyonplayercommand("jumped", "+goStand");

  for(;;) {
    self waittill("jumped");

    if(self.movespeedscaler != 0) {
      continue;
    }
    unsetsiege();
  }
}

unsetsiege() {
  self.movespeedscaler = level.baseplayermovescale;
  self resetspreadoverride();
  _id_0513::updatemovespeedscale();
  self playerrecoilscaleoff();
  self allowjump(1);
}

setimprovedobjectives() {
  self.objectivescaler = 1.5;
}

unsetimprovedobjectives() {
  self.objectivescaler = 1;
}

disableaudiozoom() {
  self.killstreakscaler = 1.5;
}

unsetblackbox() {
  self.killstreakscaler = 1;
}

setsteelnerves() {
  maps\mp\_utility::giveperk("specialty_bulletaccuracy");
  maps\mp\_utility::giveperk("specialty_holdbreath");
}

unsetsteelnerves() {
  maps\mp\_utility::_id_0735("specialty_bulletaccuracy");
  maps\mp\_utility::_id_0735("specialty_holdbreath");
}

setdelaymine() {}

unsetdelaymine() {}

setlocaljammer() {
  if(!maps\mp\_utility::_id_56D7()) {
    self setmotiontrackervisible(0);
  }
}

unsetlocaljammer() {
  self setmotiontrackervisible(1);
}

setthermal() {
  self thermalvisionon();
}

unsetthermal() {
  self thermalvisionoff();
}

setonemanarmy() {
  thread onemanarmyweaponchangetracker();
}

unsetonemanarmy() {
  self notify("stop_oneManArmyTracker");
}

onemanarmyweaponchangetracker() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("stop_oneManArmyTracker");

  for(;;) {
    self waittill("weapon_change", var_0);

    if(var_0 != "onemanarmy_mp") {
      continue;
    }
    thread selectonemanarmyclass();
  }
}

isonemanarmymenu(var_0) {
  if(var_0 == game["menu_onemanarmy"]) {
    return 1;
  }

  if(isDefined(game["menu_onemanarmy_defaults_splitscreen"]) && var_0 == game["menu_onemanarmy_defaults_splitscreen"]) {
    return 1;
  }

  if(isDefined(game["menu_onemanarmy_custom_splitscreen"]) && var_0 == game["menu_onemanarmy_custom_splitscreen"]) {
    return 1;
  }

  return 0;
}

selectonemanarmyclass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  common_scripts\utility::_id_0603();
  common_scripts\utility::_disableoffhandweapons();
  common_scripts\utility::_id_0601();
  self openpopupmenu(game["menu_onemanarmy"]);
  thread closeomamenuondeath();
  self waittill("menuresponse", var_0, var_1);
  common_scripts\utility::_id_0617();
  common_scripts\utility::_id_0614();
  common_scripts\utility::_id_0615();

  if(var_1 == "back" || !isonemanarmymenu(var_0) || maps\mp\_utility::isusingremote()) {
    if(self getcurrentweapon() == "onemanarmy_mp") {
      common_scripts\utility::_id_0603();
      common_scripts\utility::_disableoffhandweapons();
      common_scripts\utility::_id_0601();
      self switchtoweapon(common_scripts\utility::getlastweapon());
      self waittill("weapon_change");
      common_scripts\utility::_id_0617();
      common_scripts\utility::_id_0614();
      common_scripts\utility::_id_0615();
    }

    return;
  }

  thread giveonemanarmyclass(var_1);
}

closeomamenuondeath() {
  self endon("menuresponse");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  common_scripts\utility::_id_0617();
  common_scripts\utility::_id_0614();
  common_scripts\utility::_id_0615();
  self closepopupmenu();
}

giveonemanarmyclass(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(maps\mp\_utility::_hasperk("specialty_omaquickchange")) {
    var_1 = 3.0;
    self playlocalsound("foly_onemanarmy_bag3_plr");
    self playsoundtoteam("foly_onemanarmy_bag3_npc", "allies", self);
    self playsoundtoteam("foly_onemanarmy_bag3_npc", "axis", self);
  } else {
    var_1 = 6.0;
    self playlocalsound("foly_onemanarmy_bag6_plr");
    self playsoundtoteam("foly_onemanarmy_bag6_npc", "allies", self);
    self playsoundtoteam("foly_onemanarmy_bag6_npc", "axis", self);
  }

  thread omausebar(var_1);
  common_scripts\utility::_id_0602();
  common_scripts\utility::_disableoffhandweapons();
  common_scripts\utility::_id_0601();
  wait(var_1);
  common_scripts\utility::_id_0616();
  common_scripts\utility::_id_0614();
  common_scripts\utility::_id_0615();
  maps\mp\gametypes\_class::giveandapplyloadout(self.pers["team"], var_0, 0);

  if(isDefined(self.carryflag)) {
    self attach(self.carryflag, "J_spine4", 1);
  }

  self notify("changed_kit");
  level notify("changed_kit");
}

omausebar(var_0) {
  self endon("disconnect");
  var_1 = maps\mp\gametypes\_hud_util::_id_2821(0, -25);
  var_2 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0, -25);
  var_2 settext(&"MPUI_CHANGING_KIT");
  var_1 maps\mp\gametypes\_hud_util::updatebar(0, 1 / var_0);

  for(var_3 = 0; var_3 < var_0 && isalive(self) && !level.gameended; var_3 = var_3 + 0.05) {
    waitframe();
  }

  var_1 maps\mp\gametypes\_hud_util::destroyelem();
  var_2 maps\mp\gametypes\_hud_util::destroyelem();
}

eqon() {
  self setweaponhudiconoverride("primaryoffhand", "specialty_s1_temp");
}

unsetblastshield() {
  self setweaponhudiconoverride("primaryoffhand", "none");
}

setfreefall() {
  self._id_3A0F = 0;
}

unsetfreefall() {
  self._id_3A0F = 1;
}

settacticalinsertion() {
  maps\mp\_utility::_giveweapon("s2_tactical_insertion_device_mp");
  self givestartammo("s2_tactical_insertion_device_mp");
  thread monitortiuse();
}

clearprevioustispawnpoint() {
  self notify("clearPreviousTISpawnpointStarted");
  self endon("clearPreviousTISpawnpointStarted");
  common_scripts\utility::waittill_any("disconnect", "joined_team", "joined_spectators");

  if(isDefined(self.setspawnpoint)) {
    deleteti(self.setspawnpoint);
  }
}

_id_A17C() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  while(maps\mp\_utility::isreallyalive(self)) {
    var_0 = _getnodesinradiussorted(self.origin, 128, 0, 64);
    self.tispawnposition = undefined;

    foreach(var_2 in var_0) {
      if(isDefined(var_2) && _nodeexposedtosky(var_2, 1)) {
        var_3 = var_2.origin + (0, 0, 10);
        var_4 = bulletTrace(self getEye(), var_3, 0, self);

        if(_bullettracepassed(self getEye(), var_3, 0, self)) {
          if(isvalidtispawnposition(var_3)) {
            self.tispawnposition = var_3;
            break;
          }
        }
      }
    }

    waitframe();
  }
}

isvalidtispawnposition(var_0) {
  if(_canspawn(var_0) && self isonground()) {
    return 1;
  } else {
    return 0;
  }
}

monitortiuse() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  thread clearprevioustispawnpoint();
  thread _id_A17C();

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 != "s2_tactical_insertion_device_mp") {
      continue;
    }
    if(isDefined(self.setspawnpoint)) {
      deleteti(self.setspawnpoint);
    }

    if(!isDefined(self.tispawnposition)) {
      self iprintlnbold("Invalid spawn location");
      self givestartammo("s2_tactical_insertion_device_mp");
      continue;
    }

    if(maps\mp\_utility::touchingbadtrigger()) {
      continue;
    }
    var_2 = _playerphysicstrace(self.tispawnposition + (0, 0, 16), self.tispawnposition - (0, 0, 2048)) + (0, 0, 1);
    var_3 = spawn("script_model", var_2);
    var_3.angles = self.angles;
    var_3.team = self.team;
    var_3._id_0117 = self;
    var_3.enemytrigger = spawn("script_origin", var_2);
    var_3 thread glowsticksetupandwaitfordeath(self);
    var_3.playerspawnpos = self.tispawnposition;
    var_3 setotherent(self);
    var_3 common_scripts\utility::make_entity_sentient_mp(self.team, 1);
    var_3 playLoopSound("tac_insert_spark_lp");
    thread _id_A950();
    self.setspawnpoint = var_3;
    return;
  }
}

monitorthirdpersonmodel() {
  self notify("third_person_ti");
  self endon("third_person_ti");

  for(;;) {
    if(isDefined(self.attachmodelti)) {
      self detach("npc_usa_emergency_flare", "tag_inhand");
      self.attachmodelti = undefined;
    }

    self waittillmatch("grenade_pullback", "s2_tactical_insertion_device_mp");
    self attach("npc_usa_emergency_flare", "tag_inhand", 1);
    self.attachmodelti = "npc_usa_emergency_flare";
    maps\mp\_utility::waitfortimeornotify(3, "death");
    self detach("npc_usa_emergency_flare", "tag_inhand");
    self.attachmodelti = undefined;
  }
}

glowsticksetupandwaitfordeath(var_0) {
  self setModel(level.spawnglowmodel["enemy"]);
  thread maps\mp\gametypes\_damage::setentitydamagecallback(100, undefined, ::ondeathti, undefined, 0);
  thread glowstickenemyuselistener(var_0);
  thread glowstickuselistener(var_0);
  thread glowstickteamupdater(self.team, level.spawnglow["enemy"], var_0);
  var_1 = spawn("script_model", self.origin + (0, 0, 0));
  var_1.angles = self.angles;
  var_1 setModel(level.spawnglowmodel["friendly"]);
  var_1 _meth_80B1();
  var_1 thread glowstickteamupdater(self.team, level.spawnglow["friendly"], var_0);
  var_1 playLoopSound("tac_insert_spark_lp");
  self waittill("death");
  var_1 stoploopsound();
  var_1 delete();
}

glowstickteamupdater(var_0, var_1, var_2) {
  self endon("death");
  waitframe();
  var_3 = self gettagangles("tag_fx");
  var_4 = _spawnfx(var_1, self gettagorigin("tag_fx"), anglesToForward(var_3), anglestoup(var_3));
  _triggerfx(var_4);
  thread perk_deleteondeath(var_4);

  for(;;) {
    self hide();
    var_4 hide();

    foreach(var_6 in level.players) {
      if(var_6.team == var_0 && level.teambased && var_1 == level.spawnglow["friendly"]) {
        self showtoplayer(var_6);
        var_4 showtoplayer(var_6);
        continue;
      }

      if(var_6.team != var_0 && level.teambased && var_1 == level.spawnglow["enemy"]) {
        self showtoplayer(var_6);
        var_4 showtoplayer(var_6);
        continue;
      }

      if(!level.teambased && var_6 == var_2 && var_1 == level.spawnglow["friendly"]) {
        self showtoplayer(var_6);
        var_4 showtoplayer(var_6);
        continue;
      }

      if(!level.teambased && var_6 != var_2 && var_1 == level.spawnglow["enemy"]) {
        self showtoplayer(var_6);
        var_4 showtoplayer(var_6);
      }
    }

    level common_scripts\utility::waittill_either("joined_team", "player_spawned");
  }
}

perk_deleteondeath(var_0) {
  self waittill("death");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

ondeathti(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_0117) && var_0 != self._id_0117) {
    var_0 notify("destroyed_explosive");
    var_0 thread maps\mp\gametypes\_missions::processchallenge("ch_darkbringer");
  }

  playFX(level.spawnfire, self.origin);
  self._id_0117 thread maps\mp\_utility::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);
  var_0 thread deleteti(self);
}

glowstickuselistener(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  self setCursorHint("HINT_NOICON");
  self setHintString(&"MP_PICKUP_TI");
  thread updateenemyuse(var_0);

  for(;;) {
    self waittill("trigger", var_1);
    var_1 playSound("tac_insert_pickup_plr");
    var_1 thread settacticalinsertion();
    var_1 thread deleteti(self);
  }
}

updateenemyuse(var_0) {
  self endon("death");

  for(;;) {
    maps\mp\_utility::setselfusable(var_0);
    level common_scripts\utility::waittill_either("joined_team", "player_spawned");
  }
}

deleteti(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0._id_0117)) {
    var_0._id_0117._id_6E6E = 0;
    var_0._id_0117 notify("stop_watchTISpawn");
  }

  if(isDefined(var_0.enemytrigger)) {
    var_0.enemytrigger delete();
  }

  if(isDefined(var_0.trigger)) {
    var_0.trigger delete();
  }

  if(isDefined(var_0.effect["friendly"])) {
    var_0.effect["friendly"] delete();
  }

  if(isDefined(var_0.effect["enemy"])) {
    var_0.effect["enemy"] delete();
  }

  if(isDefined(var_0._id_0117)) {
    var_0._id_0117.setspawnpoint = undefined;
  }

  var_0 stoploopsound();
  var_0 delete();
}

glowstickenemyuselistener(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  self.enemytrigger setCursorHint("HINT_NOICON");
  self.enemytrigger setHintString(&"MP_DESTROY_TI");
  self.enemytrigger maps\mp\_utility::makeenemyusable(var_0);

  for(;;) {
    self.enemytrigger waittill("trigger", var_1);
    var_1 notify("destroyed_explosive");
    level thread maps\mp\gametypes\_rank::awardgameevent("tac_insert_enemy_destroyed", var_1);
    level thread maps\mp\gametypes\_rank::awardgameevent("tac_insert_destroyed", var_0);
    var_1 maps\mp\gametypes\_missions::processchallenge("ch_boot_field");

    if(var_1 maps\mp\_utility::_hasperk("specialty_detectexplosive")) {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_perks3_engineer");
    }

    var_0 set_vision_set_player(&"tac_insert_destroyed", 0);
    thread ondeathti(var_1);
  }
}

_id_A950() {
  self endon("disconnect");
  self endon("stop_watchTISpawn");
  self waittill("spawned_player");

  if(!self.ti_spawn) {
    return;
  }
  var_0 = self.origin;
  self dontinterpolate();
  self setOrigin(var_0 + (0, 0, 2000));
  self allowads(0);
  var_1 = _magicbullet("tactical_insertion_parachute_mp", self.origin, var_0);
  self playerlinkTo(var_1, undefined, 0, 180, 180, 180, 180, 1);
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("tag_origin");
  var_2 linktosynchronizedparent(var_1);
  var_3 = spawn("script_model", var_2.origin);
  var_3 hide();

  if(self.team == "allies") {
    var_3 setModel("usa_carepackage_parachute_anim");
  } else {
    var_3 setModel("ger_carepackage_parachute_anim");
  }

  var_3._id_62A0 = 0.5;
  var_3 scriptmodelplayanim("carepackage_parachute_loop");
  var_3 linktosynchronizedparent(var_2, "tag_origin", (20, -20, 40), (0, 90, 0));
  var_3 show();
  var_4 = spawn("script_model", var_3.origin);
  var_4.angles = var_3.angles;
  var_4 setModel("ger_carepackage_parachute");
  var_4 setCanDamage(1);
  var_4 hide();
  var_4 linktosynchronizedparent(var_3);
  var_4 thread _id_A94F(var_1);
  var_1 thread _id_9A1E(self, var_2, var_3, var_4);
}

_id_A94F(var_0) {
  common_scripts\utility::waittill_either("damage", "death");

  if(isDefined(var_0)) {
    var_0 notify("death");
  }
}

_id_9A1E(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self waittill("death");
  var_0 unlink();
  var_0 allowads(1);
  var_2 scriptmodelplayanimdeltamotion("carepackage_parachute_detach");
  var_2 common_scripts\utility::delaycall(2.7, ::delete);
  var_1 common_scripts\utility::delaycall(3, ::delete);
  var_3 delete();
}

setpainted(var_0, var_1) {
  if(isPlayer(self) || _isagent(self)) {
    if(isDefined(var_0.specialty_paint_time)) {
      if(var_1) {
        if(!isDefined(self.paintedattackers)) {
          self.paintedattackers = [];
        }

        self.paintedattackers[var_0.guid] = gettime();
      } else {
        if(!isDefined(self.paintedexpeditionaryattackers)) {
          self.paintedexpeditionaryattackers = [];
        }

        self.paintedexpeditionaryattackers[var_0.guid] = gettime();
      }

      self.painted = 1;
      self setperk("specialty_radarblip", 1, 0);
      thread unsetpainted(var_0.specialty_paint_time, var_0);
      thread watchpainteddeath();
    }
  }
}

watchpainteddeath() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("unsetPainted");
  self waittill("death");
  self.painted = 0;
  self.paintedattackers = [];
  self.paintedexpeditionaryattackers = [];
}

unsetpainted(var_0, var_1) {
  self notify("painted_again");
  self endon("painted_again");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait(var_0);
  self.painted = 0;
  self unsetperk("specialty_radarblip", 1);
  self notify("unsetPainted");
}

ispainted() {
  return isDefined(self.painted) && self.painted;
}

setrefillgrenades() {
  if(isDefined(self.primarygrenade)) {
    self givemaxammo(self.primarygrenade);
  }

  if(isDefined(self.botsetscriptgoal)) {
    self givemaxammo(self.botsetscriptgoal);
  }
}

setfinalstand() {
  maps\mp\_utility::giveperk("specialty_pistoldeath");
}

unsetfinalstand() {
  maps\mp\_utility::_id_0735("specialty_pistoldeath");
}

setcarepackage() {
  thread _id_051E::givekillstreak("airdrop_assault", 0, 0, self);
}

unsetcarepackage() {}

setuav() {
  thread _id_051E::givekillstreak("uav", 0, 0, self);
}

unsetuav() {}

setstoppingpower() {
  maps\mp\_utility::giveperk("specialty_bulletdamage");
  thread watchstoppingpowerkill();
}

watchstoppingpowerkill() {
  self notify("watchStoppingPowerKill");
  self endon("watchStoppingPowerKill");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("killed_enemy");
  unsetstoppingpower();
}

unsetstoppingpower() {
  maps\mp\_utility::_id_0735("specialty_bulletdamage");
  self notify("watchStoppingPowerKill");
}

setjuiced(var_0, var_1, var_2) {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");
  self endon("unset_juiced");
  level endon("end_game");
  self.isjuiced = 1;

  if(!isDefined(var_0)) {
    var_0 = 1.25;
  }

  self.movespeedscaler = var_0;
  _id_0513::updatemovespeedscale();

  if(level.splitscreen) {
    var_3 = 56;
    var_4 = 21;
  } else {
    var_3 = 80;
    var_4 = 32;
  }

  if(!isDefined(var_1)) {
    var_1 = 7;
  }

  if(!isDefined(var_2) || var_2 == 1) {
    self.juicedtimer = maps\mp\gametypes\_hud_util::createtimer("hudsmall", 1.0);
    self.juicedtimer maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, var_3);
    self.juicedtimer settimer(var_1);
    self.juicedtimer.color = (0.8, 0.8, 0);
    self.juicedtimer.archived = 0;
    self.juicedtimer.foreground = 1;
    self.juicedicon = maps\mp\gametypes\_hud_util::createicon(level.specialty_juiced_icon, var_4, var_4);
    self.juicedicon.alpha = 0;
    self.juicedicon maps\mp\gametypes\_hud_util::setparent(self.juicedtimer);
    self.juicedicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM", "TOP");
    self.juicedicon.archived = 1;
    self.juicedicon.sort = 1;
    self.juicedicon.foreground = 1;
    self.juicedicon fadeovertime(1.0);
    self.juicedicon.alpha = 0.85;
  }

  thread unsetjuicedondeath();
  thread unsetjuicedonride();
  wait(var_1 - 2);

  if(isDefined(self.juicedicon)) {
    self.juicedicon fadeovertime(2.0);
    self.juicedicon.alpha = 0.0;
  }

  if(isDefined(self.juicedtimer)) {
    self.juicedtimer fadeovertime(2.0);
    self.juicedtimer.alpha = 0.0;
  }

  wait 2;
  unsetjuiced();
}

unsetjuiced(var_0) {
  if(!isDefined(var_0)) {
    self.movespeedscaler = level.baseplayermovescale;
    _id_0513::updatemovespeedscale();
  }

  if(isDefined(self.juicedicon)) {
    self.juicedicon destroy();
  }

  if(isDefined(self.juicedtimer)) {
    self.juicedtimer destroy();
  }

  self.isjuiced = undefined;
  self notify("unset_juiced");
}

unsetjuicedonride() {
  self endon("disconnect");
  self endon("unset_juiced");

  for(;;) {
    waitframe();

    if(maps\mp\_utility::isusingremote()) {
      thread unsetjuiced();
      break;
    }
  }
}

unsetjuicedondeath() {
  self endon("disconnect");
  self endon("unset_juiced");
  common_scripts\utility::waittill_any("death", "faux_spawn");
  thread unsetjuiced(1);
}

setlightarmorhp(var_0) {
  if(isDefined(var_0)) {
    self.lightarmorhp = var_0;

    if(isPlayer(self) && isDefined(self.maxlightarmorhp) && self.maxlightarmorhp > 0) {
      var_1 = clamp(self.lightarmorhp / self.maxlightarmorhp, 0, 1);
      self setclientomnvar("ui_light_armor_percent", var_1);
    }
  } else {
    self.lightarmorhp = undefined;
    self.maxlightarmorhp = undefined;
    self setclientomnvar("ui_light_armor_percent", 0);
  }
}

setlightarmor(var_0) {
  self notify("give_light_armor");

  if(isDefined(self.lightarmorhp)) {
    unsetlightarmor();
  }

  thread removelightarmorondeath();
  thread removelightarmoronmatchend();

  if(isDefined(var_0)) {
    self.maxlightarmorhp = var_0;
  } else {
    self.maxlightarmorhp = 150;
  }

  setlightarmorhp(self.maxlightarmorhp);

  if(isDefined(level._id_5677) && level._id_5677) {
    self._id_0F67 = _newclienthudelem(self);
    self._id_0F67.x = 0;
    self._id_0F67.y = 0;
    self._id_0F67.sort = -5;
    self._id_0F67._id_00C6 = "fullscreen";
    self._id_0F67._id_01CA = "fullscreen";
    self._id_0F67 setshader("combathigh_overlay", 640, 480);
    self._id_0F67.alpha = 1;
  }
}

removelightarmorondeath() {
  self endon("disconnect");
  self endon("give_light_armor");
  self endon("remove_light_armor");
  self waittill("death");
  unsetlightarmor();
}

unsetlightarmor() {
  setlightarmorhp(undefined);

  if(isDefined(level._id_5677) && level._id_5677) {
    self._id_0F67 destroy();
  }

  self notify("remove_light_armor");
}

removelightarmoronmatchend() {
  self endon("disconnect");
  self endon("remove_light_armor");
  level common_scripts\utility::waittill_any("round_end_finished", "game_ended");
  thread unsetlightarmor();
}

haslightarmor() {
  return isDefined(self.lightarmorhp) && self.lightarmorhp > 0;
}

_id_6391() {
  self endon("death");
  self endon("disconnect");
  self._id_5720 = 0;

  for(;;) {
    if(self.health < self.maxhealth && !self._id_5720) {
      self._id_5720 = 1;
      _id_867F();
    } else if(self._id_5720 && self.health >= self.maxhealth) {
      self._id_5720 = 0;
      _id_A060();
    }

    waitframe();
  }
}

_id_867F() {
  if(isDefined(self._id_5720)) {
    if(self._id_5720) {
      _id_0513::updatemovespeedscale();
      maps\mp\_utility::giveperk("specialty_quickdraw_new");
    }
  }
}

_id_A060() {
  _id_0513::updatemovespeedscale();

  if(maps\mp\_utility::_hasperk("specialty_quickdraw_new")) {
    maps\mp\_utility::_id_0735("specialty_quickdraw_new");
  }
}

fightorflightregeneratehealth() {
  self._id_50A0 = 1;
  self._id_98E1 = 1.5;
  self._id_98E2 = 13.33;
  self notify("damage");
}

_id_63E3() {
  self endon("disconnect");
  self endon("death");
  level endon("round_switch");
  level endon("halftime");
  self._id_4B65 = 0;

  if(level._id_6EB1 <= 0 || level._id_08E2 <= 0) {}

  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(!isDefined(var_2) || !isDefined(var_2.team)) {
        continue;
      }
      if(level.teambased && var_2.team != self.team || !level.teambased && var_2 != self) {
        if(distancesquared(var_2.origin, self.origin) < level._id_6EB1) {
          self._id_4B65 = 1;
        }

        if(distancesquared(var_2.origin, self.origin) < level._id_08E2) {
          var_0 = 1;
        }
      }
    }

    if(!var_0 && self._id_4B65) {
      self._id_4B65 = 0;
    }

    waitframe();
  }
}

_id_867A() {
  self._id_9AAE = 2.0;
}

_id_A05E() {
  self._id_9AAE = 1;
}

_id_870D() {
  self endon("disconnect");
  self endon("stop_radar_ping_on_spawn");
  common_scripts\utility::waittill_any_ents(self, "spawned_player", level, "prematch_over");
  _func_256(self.origin, self, 1300);
}

_id_A077() {
  self notify("stop_radar_ping_on_spawn");
}

_id_86F1() {
  thread _id_6F4E();
}

_id_A075() {
  self notify("removePerception");
}

_id_6F4E() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("removePerception");
  self endon("round_switch");

  if(!isPlayer(self)) {
    return;
  }
  thread watchdeathorgameendperception();

  for(;;) {
    var_0 = 0;
    var_1 = level.players;
    var_2 = 0;
    var_3 = maps\mp\_utility::_hasperk("specialty_perception");

    foreach(var_5 in var_1) {
      if(maps\mp\_utility::isusingremote()) {
        break;
      }

      if(!isDefined(var_5) || !maps\mp\_utility::isreallyalive(var_5)) {
        continue;
      }
      if(var_5 == self || level.teambased && var_5.team == self.team) {
        continue;
      }
      var_6 = self.origin - var_5.origin;
      var_7 = anglesToForward(var_5 getplayerangles());
      var_8 = vectordot(var_6, var_7);

      if(var_8 <= 0) {
        continue;
      }
      var_9 = vectorNormalize(var_6);
      var_10 = vectorNormalize(var_7);
      var_8 = vectordot(var_9, var_10);

      if(var_8 < 0.965926) {
        continue;
      }
      var_0++;
      var_11 = var_5 getEye();
      var_12 = self getEye();

      if(_bullettracepassed(var_11, var_12, 0, self)) {
        thread _id_A932();
        thread _id_A933();
        var_2 = var_2 | _id_4601(var_5);
        thread _id_6011(var_5);
        continue;
      }

      if(var_0 >= 3) {
        waitframe();
        var_0 = 0;
      }
    }

    if(var_2 > 4) {
      var_2 = 1;
    } else {
      var_2 = 0;
    }

    if(var_3) {
      _id_A147(var_2, 0);
    }

    waitframe();
  }
}

_id_A932() {
  level endon("game_ended");

  if(isDefined(self._id_92F1) && self._id_92F1) {
    return;
  }
  common_scripts\utility::waittill_any("disconnect", "removePerception", "death", "perceptionChallengeCheckDone");

  if(isDefined(self)) {
    self._id_92F1 = 0;
  }
}

_id_A933() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("removePerception");
  self endon("death");

  if(isDefined(self._id_92F1) && self._id_92F1) {
    return;
  }
  self._id_92F1 = 1;
  wait 10.0;
  self notify("perceptionChallengeCheckDone");
}

watchdeathorgameendperception() {
  self endon("disconnect");
  self endon("removePerception");
  common_scripts\utility::waittill_any_ents(self, "death", level, "game_ended");
  thread _id_A147(0, 1);
}

_id_A147(var_0, var_1) {
  if(_isai(self) || istestclient(self)) {
    return;
  }
  var_2 = common_scripts\utility::getfx("perception_glow");
  var_3 = 0;

  if(isDefined(self._id_6F4C)) {
    var_3 = self._id_6F4C;
  }

  if(isDefined(var_1) && var_1) {
    if(isDefined(self.model) || self.model) {
      _killfxontagforclient(var_2, self, "j_head", self);
    }
  } else if(var_3 != var_0) {
    if(var_0) {
      _playfxontagforclients(var_2, self, "j_head", self);
    } else {
      _killfxontagforclient(var_2, self, "j_head", self);
    }
  }

  self._id_6F4C = var_0;
}

_id_4601(var_0) {
  var_1 = anglesToForward(self getplayerangles());
  var_2 = (var_1[0], var_1[1], var_1[2]);
  var_2 = vectorNormalize(var_2);
  var_3 = var_0.origin - self.origin;
  var_4 = (var_3[0], var_3[1], var_3[2]);
  var_4 = vectorNormalize(var_4);
  var_5 = vectordot(var_2, var_4);

  if(var_5 >= 0.92388) {
    return 2;
  } else if(var_5 >= 0.382683) {
    return common_scripts\utility::ter_op(maps\mp\_utility::_id_5746(self.origin, var_2, var_0.origin), 4, 1);
  } else if(var_5 >= -0.382683) {
    return common_scripts\utility::ter_op(maps\mp\_utility::_id_5746(self.origin, var_2, var_0.origin), 128, 64);
  } else if(var_5 >= -0.92388) {
    return common_scripts\utility::ter_op(maps\mp\_utility::_id_5746(self.origin, var_2, var_0.origin), 32, 8);
  } else {
    return 16;
  }
}

_id_6011(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = var_0 getentitynumber();

  if(!isDefined(self._id_6F4D)) {
    self._id_6F4D = [];
  } else if(isDefined(self._id_6F4D[var_1])) {
    self notify("markAsPerceptionSource");
    self endon("markAsPerceptionSource");
  }

  self._id_6F4D[var_1] = 1;
  var_0 common_scripts\utility::waittill_any_timeout(10, "death", "disconnect");
  self._id_6F4D[var_1] = 0;
}

_id_8743() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetThrowEquipmentFarther");
  level endon("game_ended");

  for(;;) {
    self setgrenadethrowscale(1.25);
    self waittill("grenade_pullback", var_0);

    if(var_0 == "killstreak_carepackage_grenade_mp" || var_0 == "killstreak_carepackage_grenade_axis_mp" || var_0 == "killstreak_emergency_carepackage_grenade_mp" || var_0 == "killstreak_emergency_carepackage_grenade_axis_mp" || var_0 == "gamemode_ball") {
      self setgrenadethrowscale(1.0);
    }

    self waittill("grenade_fire", var_1, var_2);
  }
}

_id_A084() {
  self setgrenadethrowscale(1.0);
  self notify("unsetThrowEquipmentFarther");
}

_id_8722() {
  self setgrenadecookscale(1.7);
}

_id_A07C() {
  self setgrenadecookscale(1.0);
}

_id_8656() {
  self endon("disconnect");
  self endon("unsetCookingGrenadeDeath");
  level endon("game_ended");

  for(;;) {
    self waittill("grenade_pullback", var_0);
    var_1 = common_scripts\utility::_id_A70E(self, "death", self, "grenade_fire", self, "offhand_end");

    if(var_1[0] == "death" && var_0 != "c4_mp") {
      var_2 = _magicgrenademanual(var_0, self.origin, (0, 0, 0), 1.25, self, 1);
      var_2._id_5751 = 1;
      _id_0513::_id_3BE8(var_2, var_0);
      return;
    }
  }
}

_id_A055() {
  self notify("unsetCookingGrenadeDeath");
}

_id_8678() {
  if(_isai(self) || istestclient(self)) {
    return;
  }
  if((level.splitscreen || self issplitscreenplayer()) && !xmodelalias/alias_ger_heads_urb_clean_par()) {
    self setclientdvars("1806", "90", "1310", "90", "2385", "0.50");
  } else {
    self setclientdvars("1806", "225", "1310", "225", "2385", "0.60");
  }
}

_id_A05D() {
  if(_isai(self) || istestclient(self)) {
    return;
  }
  if((level.splitscreen || self issplitscreenplayer()) && !xmodelalias/alias_ger_heads_urb_clean_par()) {
    self setclientdvars("1806", "75", "1310", "75", "2385", "0.45");
  } else {
    self setclientdvars("1806", "175", "1310", "175", "2385", "0.45");
  }
}

setsnowblind() {
  self endon("death");
  self endon("disconnect");
  self allowads(0);
}

unsetsnowblind() {
  self endon("death");
  self endon("disconnect");
  self allowads(1);
}

monitorthaw() {
  self endon("death");
  self endon("disconnect");
  self.isinthaw = 0;

  for(;;) {
    if(self.isinthaw && self.health >= self.maxhealth) {
      unsetthaw();
      self.isinthaw = 0;
    } else if(self.health < self.maxhealth && !self.isinthaw) {
      self.isinthaw = 1;
      setthaw();
    }

    waitframe();
  }
}

setthaw() {
  if(isDefined(self.isinthaw)) {
    if(self.isinthaw) {
      self allowsprint(0);
    }
  }
}

unsetthaw() {
  self allowsprint(1);
}

sethumbug() {
  thread monitorhumbug();
}

monitorhumbug() {
  self notify("stopHumbugMonitor");
  self endon("stopHumbugMonitor");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  common_scripts\utility::waittill_any_ents(self, "spawned_player", level, "prematch_over");

  for(;;) {
    _func_256(self.origin, self);
    self setperk("specialty_radarblip", 1, 0);
    wait 0.35;
    self unsetperk("specialty_radarblip", 1);
    wait 5.65;
  }
}

unsethumbug() {
  self notify("stopHumbugMonitor");
}

setgpsjammer() {
  self _meth_8010(self);
}

unsetgpsjammer() {
  self _meth_8014();
}

setshifty() {
  thread setshiftyunlimitedpistolammunition();
}

refillpistolmagazineonswitch() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("weapon_change");
  self endon("stopRefillPistolMagazineOnSwitch");
  wait 0.1;
  var_0 = self getcurrentweapon();

  if(maps\mp\_utility::getweaponclass(var_0) == "weapon_pistol") {
    self setweaponammoclip(var_0, _weaponclipsize(var_0));
  }
}

setshiftyunlimitedpistolammunition() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self notify("stopUnlimitedPistolAmmo");
  self endon("stopUnlimitedPistolAmmo");

  for(;;) {
    common_scripts\utility::waittill_any("weapon_change", "reload");
    var_0 = self getcurrentweapon();

    if(var_0 != "none" && !maps\mp\_utility::iskillstreakweapon(var_0) && maps\mp\_utility::getweaponclass(var_0) == "weapon_pistol") {
      var_1 = self getfractionmaxammo(var_0);

      if(var_1 < 1) {
        self givemaxammo(var_0);
      }
    }
  }
}

unsetshifty() {
  self notify("stopRefillPistolMagazineOnSwitch");
  self notify("stopUnlimitedPistolAmmo");
}

setdeadeye() {
  self.critchance = 10;
  self.deadeyekillcount = 0;
}

setdeadeyeinternal() {
  if(self.critchance < 50) {
    self.critchance = (self.deadeyekillcount + 1) * 10;
  } else {
    self.critchance = 50;
  }

  var_0 = randomint(100);

  if(var_0 <= self.critchance) {
    maps\mp\_utility::giveperk("specialty_moredamage");
  }
}

unsetdeadeye() {
  if(maps\mp\_utility::_hasperk("specialty_moredamage")) {
    maps\mp\_utility::_id_0735("specialty_moredamage");
  }
}

setescalationboostafterkill() {}

unsetescalationboostafterkill() {
  self setclientomnvar("ui_escalation_active", 0);
}

handleescalationboostafterkill() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self notify("escalationBoostAfterKill");
  self endon("escalationBoostAfterKill");
  self setclientomnvar("ui_escalation_active", 1);

  if(self.recentkillcount >= 2) {
    var_0 = self getcurrentweapon();
    var_1 = _weaponclipsize(var_0);
    var_2 = self getweaponammostock(var_0);
    var_3 = self getweaponammoclip(var_0);
    var_4 = _min(var_1 - var_3, var_2);
    var_5 = _min(var_3 + var_4, var_1);
    self setweaponammoclip(var_0, int(var_5));
    self setweaponammostock(var_0, int(var_2 - var_4));

    if(self isdualwielding()) {
      var_2 = self getweaponammostock(var_0);
      var_3 = self getweaponammoclip(var_0, "left");
      var_4 = _min(var_1 - var_3, var_2);
      var_5 = _min(var_3 + var_4, var_1);
      self setweaponammoclip(var_0, int(var_5), "left");
      self setweaponammostock(var_0, int(var_2 - var_4));
    }

    if(maps\mp\_utility::_hasperk("specialty_boostafterreload")) {
      thread handleclassifiedboostafterreload();
    }
  }

  maps\mp\_utility::giveperk("specialty_quickdraw_new");
  wait 6.0;

  if(maps\mp\_utility::_hasperk("specialty_quickdraw_new")) {
    maps\mp\_utility::_id_0735("specialty_quickdraw_new");
  }

  self setclientomnvar("ui_escalation_active", 0);
}

setresistancedivisionscramblerindicator() {
  if(_func_367()) {
    return;
  }
  if(isDefined(level.disabledivisionpassives) && level.disabledivisionpassives) {
    return;
  }
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled() && (!isDefined(self.pers["loadoutContainsAltSwitchWeapon"]) || self.pers["loadoutContainsAltSwitchWeapon"])) {
    self setclientomnvar("ui_show_division_resistance_ability_prompt", 0);
    maps\mp\_utility::giveperk("specialty_gpsjammer");
    maps\mp\_utility::giveperk("specialty_sixthsense");
    self.pers["resistanceScramblerIndicatorActive"] = undefined;
  } else {
    var_0 = _id_04CA::_id_461D(self._id_0079);

    if(!isDefined(self.pers["resistanceScramblerIndicatorActive"])) {
      self.pers["resistanceScramblerIndicatorActive"] = 1;
    }

    self setclientomnvar("ui_show_division_resistance_ability_prompt", 1);

    if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
      if(self.pers["resistanceScramblerIndicatorActive"]) {
        self setclientomnvar("ui_resistance_state", 3);
      } else {
        self setclientomnvar("ui_resistance_state", 2);
      }
    } else {
      switch (var_0) {
        case "specialty_class_resistance_grandmaster":
        case "specialty_class_resistance_master":
          if(self.pers["resistanceScramblerIndicatorActive"]) {
            self setclientomnvar("ui_resistance_state", 3);
          } else {
            self setclientomnvar("ui_resistance_state", 2);
          }

          break;
        case "specialty_class_resistance_expert":
        case "specialty_class_resistance_enlisted":
          if(self.pers["resistanceScramblerIndicatorActive"]) {
            self setclientomnvar("ui_resistance_state", 1);
          } else {
            self setclientomnvar("ui_resistance_state", 0);
          }

          break;
      }
    }

    thread toggleresistancedivisionscramblerindicator(var_0, self.pers["resistanceScramblerIndicatorActive"]);
    thread monitortoggleresistancedivisionscramblerindicator();
  }
}

monitortoggleresistancedivisionscramblerindicator() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self notify("stopMonitorToggleResistanceDivisionScramblerIndicator");
  self endon("stopMonitorToggleResistanceDivisionScramblerIndicator");
  var_0 = _id_04CA::_id_461D(self._id_0079);
  self notifyonplayercommand("leftDpad", "+actionslot 3");

  for(;;) {
    self waittill("leftDpad");

    if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
      if(self.pers["resistanceScramblerIndicatorActive"]) {
        self setclientomnvar("ui_resistance_state", 2);
        self.pers["resistanceScramblerIndicatorActive"] = 0;
      } else {
        self setclientomnvar("ui_resistance_state", 3);
        self.pers["resistanceScramblerIndicatorActive"] = 1;
      }
    } else {
      switch (var_0) {
        case "specialty_class_resistance_grandmaster":
        case "specialty_class_resistance_master":
          if(self.pers["resistanceScramblerIndicatorActive"]) {
            self setclientomnvar("ui_resistance_state", 2);
            self.pers["resistanceScramblerIndicatorActive"] = 0;
          } else {
            self setclientomnvar("ui_resistance_state", 3);
            self.pers["resistanceScramblerIndicatorActive"] = 1;
          }

          break;
        case "specialty_class_resistance_expert":
        case "specialty_class_resistance_enlisted":
          if(self.pers["resistanceScramblerIndicatorActive"]) {
            self setclientomnvar("ui_resistance_state", 0);
            self.pers["resistanceScramblerIndicatorActive"] = 0;
          } else {
            self setclientomnvar("ui_resistance_state", 1);
            self.pers["resistanceScramblerIndicatorActive"] = 1;
          }

          break;
      }
    }

    thread toggleresistancedivisionscramblerindicator(var_0, self.pers["resistanceScramblerIndicatorActive"]);
    wait 0.1;
  }
}

toggleresistancedivisionscramblerindicator(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self notify("toggleResistanceDivisionScramblerIndicator");
  self endon("toggleResistanceDivisionScramblerIndicator");

  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    if(!var_1) {
      if(maps\mp\_utility::_hasperk("specialty_sixthsense")) {
        maps\mp\_utility::_id_0735("specialty_sixthsense");
      }

      wait 0.1;

      if(maps\mp\_utility::_hasperk("specialty_gpsjammer")) {
        maps\mp\_utility::_id_0735("specialty_gpsjammer");
      }
    } else {
      maps\mp\_utility::giveperk("specialty_gpsjammer");
      wait 0.15;
      maps\mp\_utility::giveperk("specialty_sixthsense");
    }
  } else {
    switch (var_0) {
      case "specialty_class_resistance_grandmaster":
      case "specialty_class_resistance_master":
        if(!var_1) {
          if(maps\mp\_utility::_hasperk("specialty_sixthsense")) {
            maps\mp\_utility::_id_0735("specialty_sixthsense");
          }

          wait 0.1;

          if(maps\mp\_utility::_hasperk("specialty_gpsjammer")) {
            maps\mp\_utility::_id_0735("specialty_gpsjammer");
          }
        } else {
          maps\mp\_utility::giveperk("specialty_gpsjammer");
          wait 0.15;
          maps\mp\_utility::giveperk("specialty_sixthsense");
        }

        break;
      case "specialty_class_resistance_expert":
      case "specialty_class_resistance_enlisted":
        if(!var_1) {
          if(maps\mp\_utility::_hasperk("specialty_gpsjammer")) {
            maps\mp\_utility::_id_0735("specialty_gpsjammer");
          }

          wait 0.15;
        } else
          maps\mp\_utility::giveperk("specialty_gpsjammer");

        break;
    }
  }
}

unsetresistancedivisionscramblerindicator() {
  self notify("stopMonitorToggleResistanceDivisionScramblerIndicator");
  self notify("toggleResistanceDivisionScramblerIndicator");
  self setclientomnvar("ui_resistance_state", -1);
  self setclientomnvar("ui_show_division_resistance_ability_prompt", 0);
  self notifyonplayercommandremove("leftDpad", "+actionslot 3");
}

handlegrenadiertrainingunlocks() {
  var_0 = 0;

  for(var_1 = 3; var_1 < 6; var_1++) {
    if(shouldgrantgrenadierperkindex(var_1)) {
      var_2 = maps\mp\_utility::_id_452B(self._id_5DFA[var_1]);

      if(!isDefined(var_2) || var_2 == "none") {
        continue;
      }
      maps\mp\_utility::_id_47A3(var_2, var_1);
      var_0++;
    }
  }

  if(var_0 > 0) {
    return 1;
  }

  return 0;
}

shouldgrantgrenadierperkindex(var_0) {
  var_1 = var_0 - 3 + 1;

  if(var_1 <= 0 || var_1 > 3) {
    return;
  }
  if(isDefined(level.disabledivisionpassives) && level.disabledivisionpassives) {
    if(var_1 == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  if(!maps\mp\_utility::_hasperk("specialty_trainingUnlocker" + var_1)) {
    return 0;
  }

  if(!isDefined(self.pers["grenadier_kills"])) {
    self.pers["grenadier_kills"] = 0;
  }

  var_2 = self.pers["grenadier_kills"];

  switch (var_1) {
    case 1:
      if(var_2 >= 5) {
        return 1;
      }

      break;
    case 2:
      if(var_2 >= 10) {
        return 1;
      }

      break;
    case 3:
      if(var_2 >= 15) {
        return 1;
      }

      break;
    default:
      return 0;
  }

  return 0;
}

monitorgrenadierprogress() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  if(isDefined(self.enteredfrenzyloop) && self.enteredfrenzyloop == 1) {
    return;
  } else {
    self.enteredfrenzyloop = 0;
  }

  if(!isDefined(self.grenadierprogressfromtime)) {
    self.grenadierprogressfromtime = 0;
  }

  var_0 = _tablelookuprownum("mp/grenadierUpgradeTable.csv", 0, level.gametype);

  if(!isDefined(var_0) || var_0 == -1) {
    var_0 = _tablelookuprownum("mp/grenadierUpgradeTable.csv", 0, "default");
  }

  var_1 = int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_0, 5)) / 100;

  if(!isDefined(self.previousgrenadiertier)) {
    self.previousgrenadiertier = 0;
  }

  if(!isDefined(self.grenadierfrenzy)) {
    self.grenadierfrenzy = 0;
  }

  while(self._id_0079 == 7 && !self.grenadierfrenzy && !self.enteredfrenzyloop) {
    wait 1;
    self.grenadierprogressfromtime = self.grenadierprogressfromtime + var_1;
    var_2 = getgrenadierprogress();
    var_3 = int(var_2);

    if(var_3 > self.previousgrenadiertier) {
      if(var_3 <= 3) {
        grantgrenadiertierreward(var_3);

        if(var_3 == 3 && self._id_0079 == 7) {
          var_4 = int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_0, 3));
          self.enteredfrenzyloop = 1;
          thread monitorfrenzypoints(var_2 - var_3, var_4);
        }
      }

      self.previousgrenadiertier = var_3;
    }

    if(self._id_0079 != 7) {
      self setclientomnvar("ui_grenadier_progress_meter", -1);
      return;
    }

    self setclientomnvar("ui_grenadier_progress_meter", var_2);
  }
}

getgrenadiermodvalue_a() {
  if(!isDefined(self.pers["sessionProgressionA_Modifier"])) {
    return 1;
  }

  var_0 = 0;

  if(self.pers["sessionProgressionA_Modifier"] >= 1) {
    var_0++;
  }

  if(self.pers["sessionProgressionA_Modifier"] >= 8) {
    var_0++;
  }

  if(self.pers["sessionProgressionA_Modifier"] >= 15) {
    var_0++;
  }

  var_1 = var_0 * 10 / 100;
  var_2 = self.pers["sessionProgressionA_Modifier"] * 0.02;
  var_3 = clamp(1 - (var_1 + var_2), 0.01, 1);
  return var_3;
}

getgrenadiermodvalue_b() {
  if(!isDefined(self.pers["sessionProgressionB_Modifier"])) {
    return 1;
  }

  var_0 = 0;

  if(self.pers["sessionProgressionB_Modifier"] >= 1) {
    var_0++;
  }

  if(self.pers["sessionProgressionB_Modifier"] >= 10) {
    var_0++;
  }

  if(self.pers["sessionProgressionB_Modifier"] >= 25) {
    var_0++;
  }

  var_1 = var_0 * 2 / 100;
  var_2 = self.pers["sessionProgressionB_Modifier"] * 0.002;
  return 1 + clamp(var_1 + var_2, 0, 0.25);
}

getgrenadiermodvalue_c() {
  if(!isDefined(self.pers["sessionProgressionC_Modifier"])) {
    return 1;
  }

  var_0 = 0;

  if(self.pers["sessionProgressionC_Modifier"] >= 1) {
    var_0++;
  }

  if(self.pers["sessionProgressionC_Modifier"] >= 10) {
    var_0++;
  }

  if(self.pers["sessionProgressionC_Modifier"] >= 20) {
    var_0++;
  }

  var_1 = var_0 * 5 / 100;
  var_2 = self.pers["sessionProgressionC_Modifier"] * 0.01;
  return 1 - clamp(var_1 + var_2, 0, 0.9);
}

grantgrenadiertierreward(var_0) {
  if(!isDefined(var_0) || var_0 < 1 || var_0 > 3) {
    return;
  }
  self.pers["sessionProgressionA_Modifier"] = 10 * var_0;
  self.pers["sessionProgressionB_Modifier"] = 10 * var_0;
  self.pers["sessionProgressionC_Modifier"] = 10 * var_0;
  var_1 = "specialty_trainingUnlocker" + var_0;

  if(maps\mp\_utility::_hasperk(var_1)) {
    var_2 = 3 + (var_0 - 1);
    var_3 = maps\mp\_utility::_id_452B(self._id_5DFA[var_2]);

    if(isDefined(var_3) && var_3 != "none") {
      maps\mp\_utility::_id_47A3(var_3, var_2);
      _id_052D::_id_0F36();
    }
  }
}

processgrenadierkill() {
  if(self._id_0079 != 7) {
    return;
  }
  var_0 = self.pers["grenadier_kills"];
  togglegrenadierfrenzy(1);
}

togglegrenadierfrenzy(var_0) {
  if(var_0) {
    if(!isDefined(self.grenadierfrenzy)) {
      self.grenadierfrenzy = 0;
    }

    if(self.grenadierfrenzy == 0) {
      self.grenadierfrenzy = 1;
      self notify("enteredFrenzy");

      if(getdvarint("spv_grenadier_frenzy_mode", 0) == 1) {
        self.pers["sessionProgressionA_Modifier"] = 100;
        self.pers["sessionProgressionB_Modifier"] = 100;
        self.pers["sessionProgressionC_Modifier"] = 100;
        _id_0513::updatemovespeedscale();
        maps\mp\_utility::setrecoilscale();
        return;
      } else if(getdvarint("spv_grenadier_frenzy_mode", 0) == 2) {
        maps\mp\_utility::giveperk("specialty_sprintreload");
        maps\mp\_utility::giveperk("specialty_fastreload");
        maps\mp\_utility::giveperk("specialty_sprintfire");
        maps\mp\_utility::giveperk("specialty_divefire");
        maps\mp\_utility::giveperk("specialty_falldamage");
        maps\mp\_utility::giveperk("specialty_lightweight");
        maps\mp\_utility::giveperk("specialty_quieter");
        maps\mp\_utility::giveperk("specialty_crouchmovement");
        maps\mp\_utility::giveperk("specialty_stalker");
        maps\mp\_utility::giveperk("specialty_reducedsway");
        maps\mp\_utility::giveperk("specialty_scavenger");
        maps\mp\_utility::giveperk("specialty_bulletresupply");
        maps\mp\_utility::giveperk("specialty_extraammo");
        maps\mp\_utility::giveperk("specialty_regenbullets");
        maps\mp\_utility::giveperk("specialty_explosiveearlywarning");
        maps\mp\_utility::giveperk("specialty_throwback");
        maps\mp\_utility::giveperk("specialty_blastshield2");
        self._id_90D4 = maps\mp\_utility::getintproperty("perk_blastShieldScale", 55) / 100;
        maps\mp\_utility::giveperk("specialty_moreminimap");
        maps\mp\_utility::giveperk("specialty_eagleeyes");
        maps\mp\_utility::giveperk("specialty_silentkill");
        maps\mp\_utility::giveperk("specialty_coldblooded");
        maps\mp\_utility::giveperk("specialty_spygame");
        maps\mp\_utility::giveperk("specialty_heartbreaker");
        maps\mp\_utility::giveperk("specialty_perception");
        maps\mp\_utility::giveperk("specialty_detectexplosive");
        self.specialty_paint_time = 6.0;
        maps\mp\_utility::giveperk("specialty_paint_pro");
        maps\mp\_utility::giveperk("specialty_minimapdangerinfo");
        maps\mp\_utility::giveperk("specialty_radarimmune");
        maps\mp\_utility::giveperk("specialty_delaymine");
        maps\mp\_utility::giveperk("specialty_shortfuse");
        return;
      } else if(getdvarint("spv_grenadier_frenzy_mode", 0) == 3) {
        self.pers["sessionProgressionA_Modifier"] = 100;
        self.pers["sessionProgressionB_Modifier"] = 100;
        self.pers["sessionProgressionC_Modifier"] = 100;
        maps\mp\_utility::giveperk("specialty_sprintreload");
        maps\mp\_utility::giveperk("specialty_fastreload");
        maps\mp\_utility::giveperk("specialty_sprintfire");
        maps\mp\_utility::giveperk("specialty_divefire");
        maps\mp\_utility::giveperk("specialty_falldamage");
        maps\mp\_utility::giveperk("specialty_lightweight");
        maps\mp\_utility::giveperk("specialty_quieter");
        maps\mp\_utility::giveperk("specialty_crouchmovement");
        maps\mp\_utility::giveperk("specialty_stalker");
        maps\mp\_utility::giveperk("specialty_reducedsway");
        maps\mp\_utility::giveperk("specialty_scavenger");
        maps\mp\_utility::giveperk("specialty_bulletresupply");
        maps\mp\_utility::giveperk("specialty_extraammo");
        maps\mp\_utility::giveperk("specialty_regenbullets");
        maps\mp\_utility::giveperk("specialty_explosiveearlywarning");
        maps\mp\_utility::giveperk("specialty_throwback");
        maps\mp\_utility::giveperk("specialty_blastshield2");
        self._id_90D4 = maps\mp\_utility::getintproperty("perk_blastShieldScale", 55) / 100;
        maps\mp\_utility::giveperk("specialty_moreminimap");
        maps\mp\_utility::giveperk("specialty_eagleeyes");
        maps\mp\_utility::giveperk("specialty_silentkill");
        maps\mp\_utility::giveperk("specialty_coldblooded");
        maps\mp\_utility::giveperk("specialty_spygame");
        maps\mp\_utility::giveperk("specialty_heartbreaker");
        maps\mp\_utility::giveperk("specialty_detectexplosive");
        self.specialty_paint_time = 6.0;
        maps\mp\_utility::giveperk("specialty_paint_pro");
        maps\mp\_utility::giveperk("specialty_minimapdangerinfo");
        maps\mp\_utility::giveperk("specialty_radarimmune");
        maps\mp\_utility::giveperk("specialty_delaymine");
        maps\mp\_utility::giveperk("specialty_shortfuse");
        var_1 = common_scripts\utility::getfx("perception_glow");
        _playfxontagforclients(var_1, self, "j_head", self);
        _id_0513::updatemovespeedscale();
        maps\mp\_utility::setrecoilscale();
        return;
      }
    }
  } else {
    self.grenadierfrenzy = 0;
    self.pers["sessionProgressionA_Modifier"] = 30;
    self.pers["sessionProgressionB_Modifier"] = 30;
    self.pers["sessionProgressionC_Modifier"] = 30;
    thread monitorfrenzypoints();
  }
}

getgrenadierprogress() {
  var_0 = _tablelookuprownum("mp/grenadierUpgradeTable.csv", 0, level.gametype);

  if(!isDefined(var_0) || var_0 == -1) {
    var_0 = _tablelookuprownum("mp/grenadierUpgradeTable.csv", 0, "default");
  }

  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  if(self.score < int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_0, 1))) {
    var_1 = 0;
    var_2 = 0;
    var_3 = int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_0, 1));
    var_4 = (self.score - var_2) / (var_3 - var_2);
  } else if(self.score < int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_0, 2))) {
    var_1 = 1;
    var_2 = int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_0, 1));
    var_3 = int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_0, 2));
    var_4 = (self.score - var_2) / (var_3 - var_2);
  } else if(self.score < int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_0, 3))) {
    var_1 = 2;
    var_2 = int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_0, 2));
    var_3 = int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_0, 3));
    var_4 = (self.score - var_2) / (var_3 - var_2);
  } else if(self.score >= int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_0, 3))) {
    var_1 = 3;
    var_2 = int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_0, 3));
    var_3 = int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_0, 4));
    var_6 = (self.score - var_2) / var_3;
    return var_1 + var_6;
  }

  var_5 = var_1 + var_4;
  var_7 = self.grenadierprogressfromtime;
  return var_5 + var_7;
}

monitorfrenzypoints(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");

  if(self._id_0079 != 7) {
    return;
  }
  if(isDefined(var_1)) {
    self.grenadierfrenzystartscore = var_1;
  } else {
    self.grenadierfrenzystartscore = self.score;
  }

  if(isDefined(var_0)) {
    self.grenadierfrenzycurrentscore = var_0;
  } else {
    self.grenadierfrenzycurrentscore = 0;
  }

  self.frenzyscorefromtime = 0;
  self.grenadierworkingtowardfrenzy = 1;
  var_2 = _tablelookuprownum("mp/grenadierUpgradeTable.csv", 0, level.gametype);

  if(!isDefined(var_2) || var_2 == -1) {
    var_2 = _tablelookuprownum("mp/grenadierUpgradeTable.csv", 0, "default");
  }

  var_3 = int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_2, 4));
  var_4 = int(_tablelookupbyrow("mp/grenadierUpgradeTable.csv", var_2, 5)) / 100;
  self.previousgrenadierfrenzyscore = self.score;

  while(self._id_0079 == 7 && self.grenadierfrenzycurrentscore + self.frenzyscorefromtime * var_3 < var_3) {
    wait 1;
    self.frenzyscorefromtime = self.frenzyscorefromtime + var_4;
    var_5 = self.score - self.previousgrenadierfrenzyscore;
    self.grenadierfrenzycurrentscore = self.grenadierfrenzycurrentscore + var_5;
    self.previousgrenadierfrenzyscore = self.score;
    self setclientomnvar("ui_grenadier_progress_meter", 3 + self.grenadierfrenzycurrentscore / var_3 + self.frenzyscorefromtime);
  }

  if(self._id_0079 != 7) {
    return;
  }
  self.grenadierworkingtowardfrenzy = 0;
  self.previousgrenadierfrenzyscore = 0;
  self setclientomnvar("ui_grenadier_progress_meter", 4);
  togglegrenadierfrenzy(1);
}

processgrenadierheadshot() {
  if(maps\mp\_utility::_hasperk("specialty_sessionProgressionC")) {
    if(!isDefined(self.pers["sessionProgressionC_Modifier"])) {
      self.pers["sessionProgressionC_Modifier"] = 0;
    }

    self.pers["sessionProgressionC_Modifier"]++;
    maps\mp\_utility::setrecoilscale();

    if(self.pers["sessionProgressionC_Modifier"] == 1) {
      self set_vision_set_player(&"grenadier_tier_earned", 1, 10);
    } else if(self.pers["sessionProgressionC_Modifier"] == 10) {
      self set_vision_set_player(&"grenadier_tier_earned", 1, 11);
    } else if(self.pers["sessionProgressionC_Modifier"] == 20) {
      self set_vision_set_player(&"grenadier_tier_earned", 1, 12);
    }
  }
}

setsprintfasterovertime() {
  thread runsprintfasterovertime();
}

runsprintfasterovertime() {
  self endon("death");
  self endon("disconnect");
  self endon("sprintFasterOverTime_unset");

  for(;;) {
    if(self issprinting()) {
      graduallyincreasespeed();
      self.sprintfasterovertimemovespeedscale = undefined;
      _id_0513::updatemovespeedscale();
    }

    wait 0.1;
  }
}

graduallyincreasespeed() {
  self endon("death");
  self endon("disconnect");
  self endon("game_ended");
  self endon("sprintFasterOverTime_reset");
  self endon("sprintFasterOverTime_unset");
  thread sprintfasterovertime_monitormovement();
  thread sprintfasterovertime_monitordamage();
  self.sprintfasterovertimemovespeedscale = 1.07;

  while(self.sprintfasterovertimemovespeedscale < 1.1) {
    self.sprintfasterovertimemovespeedscale = self.sprintfasterovertimemovespeedscale + 0.01;
    _id_0513::updatemovespeedscale();
    wait 1.16667;
  }

  self notify("sprintFasterOverTime_maxspeed");
  self waittill("sprintFasterOverTime_reset");
}

sprintfasterovertime_monitormovement() {
  self endon("death");
  self endon("disconnect");
  self endon("sprintFasterOverTime_unset");

  for(;;) {
    if(!self issprinting() || self script_wait() || !self isonground()) {
      wait 0.4;

      if(!self issprinting() || self script_wait() || !self isonground()) {
        self notify("sprintFasterOverTime_reset");
        break;
      }
    }

    waitframe();
  }
}

sprintfasterovertime_monitordamage() {
  self endon("death");
  self endon("disconnect");
  self waittill("damage");
  self notify("sprintFasterOverTime_reset");
}

unsetsprintfasterovertime() {
  self notify("sprintFasterOverTime_unset");
  self.sprintfasterovertimemovespeedscale = undefined;
  _id_0513::updatemovespeedscale();
}

setregeneratebulletsovertime() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetRegenerateBulletsOverTime");
  level endon("game_ended");

  for(;;) {
    wait 30;
    var_0 = 0;
    var_1 = self getweaponlistprimaries();

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        var_4 = maps\mp\_utility::getweaponclass(var_3);

        if(_id_0513::_id_5684(var_3) || var_4 == "weapon_riot" || issubstr(var_3, "riotshield") || var_4 == "weapon_projectile" || issubstr(var_3, "exocrossbow") || issubstr(var_3, "microdronelauncher") || maps\mp\_utility::_id_5670(var_3) && issubstr(var_3, "grenade_launcher")) {
          continue;
        }
        if(_id_0513::_id_5696(var_3)) {
          var_5 = self getweaponammostock(var_3);

          if(!maps\mp\_utility::_id_5670(var_3) && self getfractionmaxammo(var_3) < 1) {
            self setweaponammostock(var_3, var_5 + _weaponclipsize(var_3));
            var_0 = 1;
          }
        }
      }
    }

    if(var_0) {
      _id_04C7::updatedamagefeedback("resupply_bullets");
    }
  }
}

unsetregeneratebulletsovertime() {
  self notify("unsetRegenerateBulletsOverTime");
}

setregenerateequipmentovertime() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetRegenerateEquipmentOverTime");
  level endon("game_ended");

  for(;;) {
    wait 40;
    var_0 = self getoffhandsecondaryclass();

    if(var_0 != "none") {
      var_1 = self getweaponammoclip(var_0);

      if(!isDefined(self._id_60A0) || var_1 < self._id_60A0) {
        self setweaponammoclip(var_0, var_1 + 1);
        _id_04C7::updatedamagefeedback("resupply_equipment");
      }
    }

    wait 10;
    var_2 = self getlethalweapon();

    if(var_2 != "none") {
      var_1 = self getweaponammoclip(var_2);

      if(xmodelalias/alias_ger_heads_scarf_for_clean(var_2) && (!isDefined(self._id_6088) || var_1 < self._id_6088)) {
        self setweaponammoclip(var_2, var_1 + 1);
        _id_04C7::updatedamagefeedback("resupply_equipment");

        if(var_1 == 0) {
          self notify("got_lethal_resupply");
        }
      }
    }
  }
}

unsetregenerateequipmentovertime() {
  self notify("unsetRegenerateEquipmentOverTime");
}

setlaunched() {
  self endon("disconnect");
  self endon("death");
  self endon("stopAdditionalLauncherAmmoOnSpawn");
  level endon("game_ended");

  if(!maps\mp\_utility::_hasperk("specialty_class_specialist")) {
    common_scripts\utility::waittill_any_ents(self, "spawned_player", level, "prematch_over");
  }

  var_0 = self getweaponlistprimaries();

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      var_3 = maps\mp\_utility::getweaponclass(var_2);

      if(isDefined(var_3) && var_3 == "weapon_projectile") {
        self givemaxammo(var_2);
      }
    }
  }
}

unsetlaunched() {
  self notify("stopAdditionalLauncherAmmoOnSpawn");
}

setrandomgun() {
  self endon("disconnect");
  self endon("death");
  self endon("stopRandomGun");
  level endon("game_ended");

  for(var_0 = undefined; !isDefined(var_0) || var_0 == ""; var_0 = getnextrandomgun()) {}

  self.curwunderlustgun = var_0;

  if(!_func_367()) {
    common_scripts\utility::waittill_any_ents(self, "spawned_player", self, "faux_spawn", self, "changed_class", level, "prematch_over");
  }

  waitframe();
  givenextrandomgun(self getcurrentweapon(), var_0);
  thread watchforweaponpickup();
  self notifyonplayercommand("nextRandomWeaponButtonDown", "+weapnext");
  self notifyonplayercommand("nextRandomWeaponButtonUp", "-weapnext");

  for(;;) {
    self waittill("nextRandomWeaponButtonDown");
    var_1 = gettime();
    self waittill("nextRandomWeaponButtonUp");
    var_2 = gettime();

    if(var_2 - var_1 > 250) {
      continue;
    }
    if(isDefined(self.carryobject) && isDefined(self.carryobject.carryweapon) && (self.carryobject.carryweapon == "iw5_carrydrone_mp" || self.carryobject.carryweapon == "relic_mp")) {
      continue;
    }
    if(_id_028D::_id_5855()) {
      continue;
    }
    if(!isDefined(self.changingweapon)) {
      self notify("weapon_plant_cleanup");
      givenextrandomgun(self getcurrentweapon());
      wait 0.65;
    }
  }
}

watchforweaponpickup() {
  self endon("disconnect");
  self endon("death");
  self endon("stopRandomGun");
  level endon("game_ended");

  for(;;) {
    self waittill("pickup_weapon", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    if(issubstr(maps\mp\_utility::getweaponclass(var_0), "weapon_") == 0 || maps\mp\_utility::iskillstreakweapon(var_0)) {
      continue;
    }
    var_1 = self getweaponlistprimaries();

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(issubstr(var_3, var_0) == 0) {
          self takeweapon(var_3);
        }
      }
    }
  }
}

getnextrandomgun() {
  if(!isDefined(self.wanderlustgunindex) || !isDefined(self.pers["wanderlustGunList"]) || self.pers["wanderlustGunList"].size <= self.wanderlustgunindex + 3) {
    var_0 = [];

    if(isDefined(self.wanderlustgunindex) && isDefined(self.pers["wanderlustGunList"])) {
      if(self.wanderlustgunindex < self.pers["wanderlustGunList"].size) {
        var_0[var_0.size] = self.pers["wanderlustGunList"][self.wanderlustgunindex];
      }

      if(self.wanderlustgunindex + 1 < self.pers["wanderlustGunList"].size) {
        var_0[var_0.size] = self.pers["wanderlustGunList"][self.wanderlustgunindex + 1];
      }

      if(self.wanderlustgunindex + 2 < self.pers["wanderlustGunList"].size) {
        var_0[var_0.size] = self.pers["wanderlustGunList"][self.wanderlustgunindex + 2];
      }

      if(self.wanderlustgunindex + 3 < self.pers["wanderlustGunList"].size) {
        var_0[var_0.size] = self.pers["wanderlustGunList"][self.wanderlustgunindex + 3];
      }
    }

    self.wanderlustgunindex = 0;
    var_1 = [];

    foreach(var_3 in level.wanderlustweaponlist) {
      if(common_scripts\utility::_id_562E(var_3["Variant 0"].hidebaseweapon)) {
        var_4 = var_3["Variant 1"].weaponname;
      } else {
        var_4 = var_3["Variant 0"].weaponname;
      }

      var_5 = 6;
      var_6 = maps\mp\_utility::getweaponclass(var_4);

      if(var_6 == "weapon_heavy" || var_6 == "weapon_sniper") {
        var_5--;
      }

      var_7 = getattachmentsforweapon(var_4, var_5);
      var_8 = 0;

      for(var_9 = 0; var_9 < var_7.size; var_9++) {
        if(issubstr(var_7[var_9], "_sight")) {
          var_8 = 1;
        }
      }

      if(!var_8 && var_6 == "weapon_sniper") {
        var_7[var_7.size] = "hold_breath_3";
      }

      var_10 = [];

      for(var_9 = 0; var_9 < var_7.size; var_9++) {
        var_10[var_9] = maps\mp\_utility::_id_452A(var_7[var_9]);
      }

      for(var_9 = var_7.size; var_9 < 6; var_9++) {
        var_10[var_9] = 0;
      }

      var_11 = maps\mp\gametypes\_class::buildweaponname(var_4, var_10[0], var_10[1], var_10[2], var_10[3], var_10[4], var_10[5], 0, 0, 0, 0, 0, undefined, 5);
      var_1[var_1.size] = var_11;
    }

    var_1 = common_scripts\utility::array_randomize(var_1);
    var_13 = common_scripts\utility::_id_0F73(var_0, var_1);
    self.pers["wanderlustGunList"] = var_13;
  }

  var_13 = self.pers["wanderlustGunList"];
  var_14 = [];
  var_15 = var_13[self.wanderlustgunindex % var_13.size];
  var_14[var_14.size] = var_15;

  if(self.wanderlustgunindex + 1 < var_13.size) {
    var_14[var_14.size] = var_13[self.wanderlustgunindex + 1];
  }

  if(self.wanderlustgunindex + 2 < var_13.size) {
    var_14[var_14.size] = var_13[self.wanderlustgunindex + 2];
  }

  if(self.wanderlustgunindex + 3 < var_13.size) {
    var_14[var_14.size] = var_13[self.wanderlustgunindex + 3];
  }

  self loadweapons(var_14);
  self.wanderlustprevgunindex = self.wanderlustgunindex;
  self.wanderlustgunindex++;
  return var_15;
}

givenextrandomgun(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("giveNextRandomGun");
  self endon("giveNextRandomGun");
  waittillframeend;

  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    for(var_2 = undefined; !isDefined(var_2) || var_2 == ""; var_2 = getnextrandomgun()) {}

    self.curwunderlustgun = var_2;
  }

  var_3 = gettime();

  while(!self loadweapons(var_2)) {
    if(var_3 + 7500 <= gettime()) {
      givenextrandomgun(self getcurrentweapon());
      return;
    } else
      waitframe();
  }

  var_4 = self getweaponlistprimaries();

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      if(issubstr(var_6, var_2) == 0) {
        self takeweapon(var_6);
      }
    }
  }

  if(self getclientomnvar("ui_show_division_sniper_ability_prompt") == 1) {
    self setclientomnvar("ui_show_division_sniper_ability_prompt", 0);
  }

  maps\mp\_utility::_giveweapon(var_2);
  thread watchwanderlustweaponchange(var_2);
  var_8 = _weaponclipsize(var_2);
  self setweaponammoclip(var_2, var_8);

  if(maps\mp\_utility::getweaponclass(var_2) == "weapon_shotgun" && var_8 < 5) {
    self setweaponammostock(var_2, var_8 * 3);
  } else if(issubstr(var_2, "akimbo")) {
    self setweaponammostock(var_2, var_8 * 4);
  } else if(var_8 < 50) {
    self setweaponammostock(var_2, var_8);
  } else {
    self setweaponammostock(var_2, 0);
  }

  self switchtoweapon(var_2);
  var_9 = maps\mp\_utility::_id_4431(var_2);
  self.pers["primaryWeapon"] = var_9;
  self.primaryweapon = var_2;
}

watchwanderlustweaponchange(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("giveNextRandomGun");
  wait 2.5;
  var_1 = self getcurrentweapon();

  if(!isDefined(var_1) || var_1 == "" || var_1 == "none") {
    givenextrandomgun(var_1);
  }
}

unsetrandomgun() {
  self notify("stopRandomGun");
  self notify("giveNextRandomGun");
  self notifyonplayercommandremove("nextRandomWeaponButtonDown", "+weapnext");
  self notifyonplayercommandremove("nextRandomWeaponButtonUp", "-weapnext");
}

getattachmentsforweapon(var_0, var_1) {
  if(var_1 <= 0) {
    return [];
  }

  var_2 = _getweaponattachmentsbasenames(var_0);
  var_2 = common_scripts\utility::array_randomize(var_2);
  var_3 = [];
  var_4 = [];

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    var_6 = 0;
    var_7 = var_2[var_5];

    if(!var_6 && (issubstr(var_7, "special_grip") || issubstr(var_7, "bipod") || issubstr(var_7, "hold_breath") || var_0 == "winchester1897_mp" && issubstr(var_7, "dragon_breath"))) {
      var_6 = 1;
    }

    if(!var_6 && (issubstr(var_7, "iron_sight") || issubstr(var_7, "telescopic_sight") || issubstr(var_7, "lens_sight") || issubstr(var_7, "aperture_sight"))) {
      if(common_scripts\utility::cointoss()) {
        var_6 = 1;
      }
    }

    if(!var_6 && (issubstr(var_7, "akimbo") || issubstr(var_7, "tactical_knife"))) {
      if(randomint(100) >= 80) {
        var_6 = 1;
      }
    }

    if(!var_6 && (issubstr(var_7, "grenade_launcher") || issubstr(var_7, "dragon_breath"))) {
      if(randomint(100) >= 90) {
        var_6 = 1;
      }
    }

    if(!var_6 && isDefined(var_3) && var_3.size > 0) {
      foreach(var_9 in var_3) {
        if(isDefined(level.attachmentcombosvalues[var_9])) {
          var_10 = tablelookup("mp/attachmentcombos_mtx12.csv", 0, var_7, level.attachmentcombosvalues[var_9]);

          if(isDefined(var_10) && var_10 != "") {
            var_6 = 1;
            break;
          }
        }
      }
    }

    if(!var_6) {
      var_3[var_3.size] = var_7;
      var_4[var_4.size] = var_7;

      if(var_4.size >= var_1) {
        break;
      }
    }
  }

  return var_4;
}

buildwunderlustweaponlist() {
  var_0 = [];
  var_1 = _tablegetrowcount("mp/statstable.csv");

  for(var_2 = 0; var_2 <= var_1; var_2++) {
    var_3 = _tablelookupbyrow("mp/statstable.csv", var_2, 0);

    if(!issubstr(var_3, "weapon_")) {
      continue;
    }
    if(var_3 == "weapon_grenade" || var_3 == "weapon_explosive" || var_3 == "weapon_reticle" || var_3 == "weapon_camo" || var_3 == "weapon_attachment" || var_3 == "weapon_charm" || var_3 == "weapon_class_camo") {
      continue;
    }
    var_4 = _tablelookupbyrow("mp/statstable.csv", var_2, 1);

    if(var_3 == "weapon_other" && _tolower(getsubstr(var_4, 0, 7)) != "weapon_") {
      continue;
    }
    var_5 = _tablelookupbyrow("mp/statstable.csv", var_2, 2);

    if(var_5 == "") {
      continue;
    }
    if(maps\mp\_utility::_id_5716(var_5)) {
      continue;
    }
    if(issubstr(var_5, "flamethrower") || issubstr(var_5, "tesla") || issubstr(var_5, "riotshield")) {
      continue;
    }
    var_6 = _tablelookupbyrow("mp/statstable.csv", var_2, 18);

    if(var_6 == "") {
      continue;
    }
    var_7 = 0;

    if(_tablelookupbyrow("mp/statstable.csv", var_2, 53) == "1") {
      var_7 = 1;
    }

    var_8 = _tablelookupbyrow("mp/statstable.csv", var_2, 56);

    if(!maps\mp\_utility::productionlevelstringtouidvarbool(var_8)) {
      continue;
    }
    if(!maps\mp\_utility::isproductionlevelactive(maps\mp\_utility::productionlevelstringtoindex(var_8))) {
      continue;
    }
    var_9 = int(var_6);
    var_10 = _func_312(var_9);
    var_11 = _func_313(var_9);
    var_12 = var_10 + "";
    var_13 = "Variant " + var_11;

    if(!isDefined(var_0[var_12])) {
      var_0[var_12] = [];
    }

    if(!isDefined(var_0[var_12][var_13])) {
      var_0[var_12][var_13] = spawnStruct();
      var_0[var_12][var_13].weaponname = var_5;
      var_0[var_12][var_13].hidebaseweapon = var_7;
    }
  }

  var_14 = [];

  foreach(var_16 in var_0) {
    if(isDefined(var_16) && isDefined(var_16["Variant 0"]) && !common_scripts\utility::_id_562E(var_16["Variant 0"].hidebaseweapon) && isDefined(var_16["Variant 0"].weaponname)) {
      var_14 = common_scripts\utility::_id_0F6F(var_14, var_16);
      continue;
    }

    if(isDefined(var_16) && isDefined(var_16["Variant 0"]) && common_scripts\utility::_id_562E(var_16["Variant 0"].hidebaseweapon) && isDefined(var_16["Variant 1"]) && isDefined(var_16["Variant 1"].weaponname)) {
      var_14 = common_scripts\utility::_id_0F6F(var_14, var_16);
    }
  }

  level.wanderlustweaponlist = var_14;
  var_18 = [];
  var_19 = _tablegetcolumncount("mp/attachmentcombos_mtx12.csv");

  for(var_20 = 0; var_20 < var_19; var_20++) {
    var_21 = _tablelookupbyrow("mp/attachmentcombos_mtx12.csv", 0, var_20);
    var_18[var_21] = var_20;
  }

  level.attachmentcombosvalues = var_18;
}

setperkstreaks() {
  if(!isDefined(self.pers["specialist_perkstreak_score"])) {
    self.pers["specialist_perkstreak_score"] = 0;
  }

  self setclientomnvar("specialistPoints", self.pers["specialist_perkstreak_score"]);
}

unsetperkstreaks() {}

handlespecialisttrainingunlocks() {
  var_0 = 0;

  for(var_1 = 6; var_1 < 9; var_1++) {
    if(shouldgrantspecialistperkindex(var_1)) {
      var_2 = maps\mp\_utility::_id_452B(self._id_5DFA[var_1]);

      if(!isDefined(var_2) || var_2 == "none") {
        continue;
      }
      maps\mp\_utility::_id_47A3(var_2, var_1);
      var_0++;
    }
  }

  if(shouldgrantspecialistallbasictrainings()) {
    grantallbasictrainingsforspecialist();
    var_0++;
  }

  if(var_0 > 0) {
    return 1;
  }

  return 0;
}

isspecialistperk(var_0) {
  if(!isDefined(self) || !isDefined(self._id_5DFA)) {
    return 0;
  }

  for(var_1 = 6; var_1 < 9; var_1++) {
    if(var_0 == maps\mp\_utility::_id_452B(self._id_5DFA[var_1])) {
      return 1;
    }
  }

  return 0;
}

hasspecialistperkunlocked(var_0) {
  if(!isDefined(self) || !isDefined(self._id_5DFA)) {
    return 0;
  }

  for(var_1 = 6; var_1 < 9; var_1++) {
    if(var_0 == maps\mp\_utility::_id_452B(self._id_5DFA[var_1])) {
      return shouldgrantspecialistperkindex(var_1);
    }
  }

  return 0;
}

shouldgrantspecialistperkindex(var_0) {
  var_1 = var_0 - 6 + 1;

  if(var_1 <= 0 || var_1 > 3) {
    return;
  }
  if(!isDefined(self.pers["specialist_perkstreak_score"])) {
    self.pers["specialist_perkstreak_score"] = 0;
  }

  var_2 = self.pers["specialist_perkstreak_score"];
  return var_2 >= getdvarint("specialistBasicTraining" + var_1 + "_score");
}

shouldgrantspecialistallbasictrainings() {
  if(!isDefined(self.pers["specialist_perkstreak_score"])) {
    self.pers["specialist_perkstreak_score"] = 0;
  }

  var_0 = self.pers["specialist_perkstreak_score"];
  return var_0 >= getdvarint("specialistBasicTraining4_score");
}

processspecialistevent(var_0) {
  if(!maps\mp\_utility::_hasperk("specialty_perkstreaks") || !maps\mp\_utility::isreallyalive(self)) {
    return;
  }
  var_1 = maps\mp\gametypes\_rank::getscoreinfovalue(var_0);

  if(var_1 <= 0) {
    return;
  }
  if(!isDefined(self.pers["specialist_perkstreak_score"])) {
    self.pers["specialist_perkstreak_score"] = 0;
  }

  var_2 = self.pers["specialist_perkstreak_score"];
  var_3 = var_2 + var_1;
  self.pers["specialist_perkstreak_score"] = var_3;
  self setclientomnvar("specialistPoints", var_3);

  for(var_4 = 0; var_4 < 4; var_4++) {
    var_5 = getdvarint("specialistBasicTraining" + (var_4 + 1) + "_score");

    if(var_3 >= var_5) {
      if(var_2 < var_5) {
        if(var_4 == 3) {
          grantallbasictrainingsforspecialist();
          _id_052D::_id_0F36();
          thread maps\mp\gametypes\_hud_message::splashnotify("specialist_tier_earned", var_4 + 1);
          maps\mp\gametypes\_missions::processchallenge("ch_dlc3_specialist");
          continue;
        }

        var_6 = 6 + var_4;
        var_7 = maps\mp\_utility::_id_452B(self._id_5DFA[var_6]);

        if(isDefined(var_7) && var_7 != "none") {
          maps\mp\_utility::_id_47A3(var_7, var_6);
          _id_052D::_id_0F36();
          thread maps\mp\gametypes\_hud_message::splashnotify("specialist_tier_earned", var_4 + 1);
          maps\mp\gametypes\_missions::processchallenge("ch_dlc3_specialist");
        }
      }
    }
  }
}

grantallbasictrainingsforspecialist() {
  maps\mp\_utility::giveperk("specialty_class_hustle");
  maps\mp\_utility::giveperk("specialty_class_gunslinger");
  maps\mp\_utility::giveperk("specialty_class_energetic");
  maps\mp\_utility::giveperk("specialty_class_inconspicuous");
  maps\mp\_utility::giveperk("specialty_class_scoped");
  maps\mp\_utility::giveperk("specialty_class_duelist");
  maps\mp\_utility::giveperk("specialty_class_rifleman");
  maps\mp\_utility::giveperk("specialty_class_forage");
  maps\mp\_utility::giveperk("specialty_class_serrated");
  maps\mp\_utility::giveperk("specialty_class_hunker");
  maps\mp\_utility::giveperk("specialty_class_launched");
  maps\mp\_utility::giveperk("specialty_class_undercover");
  maps\mp\_utility::giveperk("specialty_class_lookout");
  maps\mp\_utility::giveperk("specialty_class_instincts");
  maps\mp\_utility::giveperk("specialty_class_flanker");
  maps\mp\_utility::giveperk("specialty_class_espionage");
  maps\mp\_utility::giveperk("specialty_class_shifty");
  maps\mp\_utility::giveperk("specialty_class_saboteur");
  maps\mp\_utility::giveperk("specialty_class_clandestine");
  maps\mp\_utility::giveperk("specialty_class_escalation");

  if(getdvarint("6019", 1) == 1) {
    maps\mp\_utility::giveperk("specialty_class_remedy");
  }
}

resetspecialistperkstreak() {
  if(maps\mp\_utility::_id_585F()) {
    return;
  }
  self.pers["specialist_perkstreak_score"] = 0;
  self setclientomnvar("specialistPoints", 0);
}

fasterhealthregenkilltrigger() {
  if(self.health < self.maxhealth) {
    self._id_50A0 = 1;
    self notify("damage");
  }
}

handleclassifiedboostaftermultikillorheadshot(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_1 = self.recentkillcount >= 2;

  if(var_1) {
    var_2 = "classified_bonus_multikill";

    switch (self.recentkillcount) {
      case 6:
        var_2 = "classified_bonus_sixkill";
        break;
      case 5:
        var_2 = "classified_bonus_fivekill";
        break;
      case 4:
        var_2 = "classified_bonus_fourkill";
        break;
      case 3:
        var_2 = "classified_bonus_triplekill";
        break;
      case 2:
        var_2 = "classified_bonus_doublekill";
        break;
    }

    level thread maps\mp\gametypes\_rank::awardgameevent(var_2, self);
  }

  if(var_0) {
    level thread maps\mp\gametypes\_rank::awardgameevent("classified_bonus_headshot", self);
  }

  if(var_1 || var_0) {
    maps\mp\gametypes\_missions::processchallenge("ch_commando_skill");
    var_3 = 0;
    var_4 = self getweaponlistprimaries();

    if(isDefined(var_4)) {
      foreach(var_6 in var_4) {
        var_7 = maps\mp\_utility::getweaponclass(var_6);

        if(_id_0513::_id_5684(var_6) || var_7 == "weapon_riot" || issubstr(var_6, "riotshield") || var_7 == "weapon_projectile" || issubstr(var_6, "exocrossbow") || issubstr(var_6, "microdronelauncher") || maps\mp\_utility::_id_5670(var_6) && issubstr(var_6, "grenade_launcher")) {
          continue;
        }
        if(_id_0513::_id_5696(var_6)) {
          var_8 = self getweaponammostock(var_6);

          if(!maps\mp\_utility::_id_5670(var_6) && self getfractionmaxammo(var_6) < 1) {
            self setweaponammostock(var_6, var_8 + _weaponclipsize(var_6));
            var_3 = 1;
          }
        }
      }
    }

    if(var_3) {
      _id_04C7::updatedamagefeedback("resupply_bullets");
    }
  }
}

setclassifiedboostafterreload() {}

unsetclassifiedboostafterreload() {
  self setclientomnvar("ui_classifiedboost_active", 0);
  self.classifiedboostafterreloadactive = 0;
}

handleclassifiedboostafterreload() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self notify("classifiedBoostAfterReload");
  self endon("classifiedBoostAfterReload");
  self setclientomnvar("ui_classifiedboost_active", 1);
  self.classifiedboostafterreloadactive = 1;
  var_0 = maps\mp\_utility::_hasperk("specialty_rof");

  if(!var_0) {
    maps\mp\_utility::giveperk("specialty_rof");
  }

  var_1 = maps\mp\_utility::_hasperk("specialty_bulletaccuracy");

  if(!var_1) {
    maps\mp\_utility::giveperk("specialty_bulletaccuracy");
  }

  wait 3.5;

  if(maps\mp\_utility::_hasperk("specialty_rof") && !var_0) {
    maps\mp\_utility::_id_0735("specialty_rof");
  }

  if(maps\mp\_utility::_hasperk("specialty_bulletaccuracy") && !var_1) {
    maps\mp\_utility::_id_0735("specialty_bulletaccuracy");
  }

  self setclientomnvar("ui_classifiedboost_active", 0);
  self.classifiedboostafterreloadactive = 0;
}

isclassifiedsecondbt(var_0) {
  if(!isDefined(self) || !isDefined(self._id_5DFA)) {
    return 0;
  }

  if(var_0 == maps\mp\_utility::_id_452B(self._id_5DFA[4])) {
    return 1;
  }

  return 0;
}

hasclassifiedsecondbt() {
  return isDefined(self.perks) && isDefined(self.perks["specialty_class_commando_grandmaster"]);
}

setserumbasictraining() {
  thread handleserumbasictraining();
}

unsetserumbasictraining() {
  self notify("unsetRegenerateSerumOverTime");
}

serumbasictraininglistener() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetRegenerateSerumOverTime");
  level endon("game_ended");

  for(;;) {
    self waittill("altered_state_apply");
    var_0 = maps\mp\killstreaks\_raid_ss_serum_util::getserumkillstreakslot("basic_training_serum");
    var_1 = maps\mp\killstreaks\_raid_ss_serum_util::getserumkillstreakslot("raid_ss_serum_a", "raid_ss_serum_b", "raid_ss_serum_c");

    if(isDefined(var_0) && !common_scripts\utility::_id_562E(self.basictrainingserumactive)) {
      maps\mp\killstreaks\_raid_ss_serum_util::disableserum(var_0);
      continue;
    }

    if(isDefined(var_1) && common_scripts\utility::_id_562E(self.basictrainingserumactive)) {
      maps\mp\killstreaks\_raid_ss_serum_util::disableserum(var_1);
    }
  }
}

handleserumbasictraining() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetRegenerateSerumOverTime");
  level endon("game_ended");
  var_0 = 1;

  if(maps\mp\_utility::invirtuallobby() || getDvar("1924") == "hub") {
    return;
  }
  wait 0.1;

  if(!isDefined(self.pers["basicTrainingSerumsUsed"])) {
    self.pers["basicTrainingSerumsUsed"] = 0;
  }

  if(!isDefined(self.pers["basicTrainingSerumEarnProgress"])) {
    self.pers["basicTrainingSerumEarnTimeRemaining"] = 0;
    self.pers["basicTrainingSerumEarnProgress"] = 1;
  }

  thread serumbasictraininglistener();

  for(;;) {
    if(self.pers["basicTrainingSerumEarnProgress"] >= 1) {
      var_1 = self.pers["basicTrainingSerumsUsed"];

      if(common_scripts\utility::_id_562E(self.raidserumactive)) {
        self waittill("serum_finished");
      }

      thread _id_051E::givekillstreak("basic_training_serum", 0, 0, self, 1);

      if(!var_0) {
        thread maps\mp\gametypes\_hud_message::killstreaksplashnotify("basic_training_serum", 500, undefined, undefined);
      }

      while(var_1 == self.pers["basicTrainingSerumsUsed"]) {
        waitframe();
      }

      wait(level.serumbasictrainingactiveduration);
    }

    var_0 = 0;
    var_2 = gettime();

    while(self.pers["basicTrainingSerumEarnProgress"] < 1) {
      var_3 = gettime();
      self.pers["basicTrainingSerumEarnTimeRemaining"] = self.pers["basicTrainingSerumEarnTimeRemaining"] - max(0, var_3 - var_2);
      self.pers["basicTrainingSerumEarnProgress"] = max(0, 1 - self.pers["basicTrainingSerumEarnTimeRemaining"] / level.serumbasictrainingcooldowninterval);
      self setclientomnvar("ks_count1", self.pers["basicTrainingSerumEarnProgress"]);
      var_2 = var_3;
      wait 0.15;
    }
  }
}