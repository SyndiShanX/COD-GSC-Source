/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\gunship.gsc
*************************************************/

function init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "init")]]();
  }

  level._effect["clouds"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_view_clouds.vfx");
  level._effect["gunship_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_flares.vfx");
  level._effect["camera_shutter"] = loadfx("vfx/iw8_mp/killstreak/vfx_ui_camera_shutter.vfx");
  level._effect["camera_spotlight"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_ir_spotlight.vfx");
  level.cosine = [];
  level.cosine["45"] = cos(45);
  level.cosine["5"] = cos(5);
  level.physicssphereradius["ac130_25mm_mp"] = 60;
  level.physicssphereradius["ac130_40mm_mp"] = 600;
  level.physicssphereradius["ac130_105mm_mp"] = 1000;
  level.physicssphereforce["ac130_25mm_mp"] = 0;
  level.physicssphereforce["ac130_40mm_mp"] = 3;
  level.physicssphereforce["ac130_105mm_mp"] = 6;
  level.weaponreloadtime["ac130_25mm_mp"] = 2;
  level.weaponreloadtime["ac130_40mm_mp"] = 4;
  level.weaponreloadtime["ac130_105mm_mp"] = 6;
  level.gunship_speed["move"] = 250;
  level.gunship_speed["rotate"] = 120;
  scripts\engine\utility::flag_init("allow_context_sensative_dialog");
  scripts\engine\utility::flag_set("allow_context_sensative_dialog");
  var_0 = getEntArray("minimap_corner", "targetname");
  var_1 = level.mapcenter;

  if(var_0.size) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "findBoxCenter")) {
      var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "findBoxCenter")]](var_0[0].origin, var_0[1].origin);
    }
  }

  level.gunship = spawn("script_model", var_1);
  level.gunship setModel("tag_origin");
  level.gunship.angles = (0, 115, 0);
  level.gunship.owner = undefined;
  level.gunship.thermal_vision = "ac130_thermal_mp";
  level.gunship.enhanced_vision = "ac130_enhanced_mp";
  level.gunship.targetname = "ac130rig_script_model";
  level.gunship hide();
  level.gunshipinuse = 0;
  level.gunship.deployweaponobj = getcompleteweaponname("ks_remote_gunship_mp");
  thread rotateplane("on");
  scripts\mp\playeractions::registeractionset("gunshipIntro", ["usability", "killstreaks", "supers", "gesture", "fire", "weapon_switch", "allow_movement", "offhand_weapons", "shellshock"]);
  scripts\mp\playeractions::registeractionset("gunshipUse", ["usability", "killstreaks", "supers", "gesture", "allow_movement", "shellshock"]);
  level.gunshipqueue = [];
  init_gunship_intro_anims();
  init_gunship_vo();
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("gunship", "on", 9);
}

function weapongivengunship(var_0) {
  return true;
}

#using_animtree("");

function init_gunship_intro_anims() {
  level.scr_animtree["gunship"] = #animtree;
  level.scr_anim["gunship"]["gunship_intro"] = $mp_acharlie130_intro;
  level.scr_animname["gunship"]["gunship_intro"] = "mp_acharlie130_intro";
  level.scr_anim["gunship"]["gunship_intro_alt"] = % mp_acharlie130_intro_alt;
  level.scr_animname["gunship"]["gunship_intro_alt"] = "mp_acharlie130_intro_alt";
  level.scr_anim["gunship"]["gunship_intro_long"] = % mp_acharlie130_intro_old;
  level.scr_animname["gunship"]["gunship_intro_long"] = "mp_acharlie130_intro_old";
  level.scr_anim["gunship"]["gunship_death"] = % mp_acharlie130_death;
  level.scr_animname["gunship"]["gunship_death"] = "mp_acharlie130_death";
  level.gunship_crashanimlength = getanimlength(level.scr_anim["gunship"]["gunship_death"]);
}

function init_gunship_vo() {
  game["dialog"]["gunship_engage"] = "gunship_engage";
  game["dialog"]["gunship_single_spotted"] = "gunship_single_enemy_spotted";
  game["dialog"]["gunship_multi_spotted"] = "gunship_multi_enemy_spotted";
  game["dialog"]["gunship_good_hit"] = "gunship_hit";
  game["dialog"]["gunship_bad_hit"] = "gunship_miss";
  game["dialog"]["gunship_taking_damage_light"] = "gunship_damage_reaction_10";
  game["dialog"]["gunship_taking_damage_medium"] = "gunship_damage_reaction_30";
  game["dialog"]["gunship_taking_damage_heavy"] = "gunship_damage_reaction_40";
  game["dialog"]["gunship_missile_lock"] = "gunship_missile_lock";
  game["dialog"]["gunship_flares"] = "gunship_launch_flares";
  game["dialog"]["gunship_105mm_reloaded"] = "gunship_reload_105mm";
  game["dialog"]["gunship_40mm_reloaded"] = "gunship_reload_40mm";
  game["dialog"]["gunship_25mm_reloaded"] = "gunship_reload_25mm";
  game["dialog"]["gunship_crashing"] = "gunship_crash";
}

function tryusegunship() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("gunship", self);
  return tryusegunshipfromstruct(var_0);
}

function tryusegunshipfromstruct(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return 0;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "use_killstreak_ac130");
  }

  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_0, &weapongivengunship);

  if(!istrue(var_1)) {
    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      var_0 notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  if(istrue(level.gunshipinuse)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  if(level.gameended) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  var_2 = gunship_startuse(self, var_0);

  if(!istrue(var_2)) {
    return 0;
  }

  return var_2;
}

function gunship_monitormanualplayerexit(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_0 endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]();
  }

  self waittill("killstreakExit");
  thread gunship_leave(var_0);
}

function gunship_startuse(var_0, var_1) {
  level endon("game_ended");

  if(isDefined(level.gunshipplayer)) {
    return false;
  }

  var_2 = randomint(360);
  var_3 = 9000;
  var_4 = cos(var_2) * var_3;
  var_5 = sin(var_2) * var_3;
  var_6 = 8000;
  var_7 = vectorNormalize((var_4, var_5, var_6));
  var_7 *= var_6;
  level.gunshipinuse = 1;

  if(scripts\common\utility::iscp()) {
    var_0.start_position = var_0.origin;
  }

  var_8 = gunship_playintro(var_0, var_1, var_2, var_7);

  if(!isDefined(var_8) || var_8 == 0) {
    level.gunshipinuse = 0;
    return false;
  }

  var_9 = gunship_spawn(var_0, var_1, var_2, var_7);

  if(!isDefined(var_9)) {
    level.gunshipinuse = 0;
    return false;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash"), "used_gunship", var_0);
  }

  if(getdvarint("NOSLRNTRKL")) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setThirdPersonDOF")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setThirdPersonDOF")]](0);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_9.streakinfo.streakname, "Killstreak_Air", var_0);
  }

  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(var_9, &gunship_lockedoncallback);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(var_9, &gunship_lockedonremovedcallback);
  thread gunship_attachgunner(var_9);
  thread gunship_watchchangeweapons(var_9);
  thread gunship_watchweaponfired(var_9);
  thread gunship_watchthermaltoggle(var_9);
  thread gunship_watchdamage(var_9);
  thread gunship_watchtimeout(var_9);
  thread set_up_coop_push(var_9);
  thread set_up_pilots(var_9, var_0);
  thread set_up_pilots(var_9, var_0);
  thread set_up_pilots(var_9, var_0);
  thread set_up_pilots(var_9, var_0);
  thread gunship_watchendgame(var_9);
  thread gunship_playpilotfx(var_9);
  thread gunship_linklightfxent();
  thread gunship_linkwingfxents();
  thread gunship_monitormanualplayerexit(var_9);
  thread gunship_trackvelocity(var_9);
  thread gunship_watchtargets(var_9);
  thread gunship_watchkills(var_9);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    var_9 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](&gunship_handlemissiledetection);
  }

  var_9 playLoopSound("iw8_ks_ac130_lp");
  return true;
}

function gunship_lockedoncallback() {
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_missile_lock");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

function gunship_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

function gunship_playintro(var_0, var_1, var_2, var_3) {
  var_0 endon("disconnect");
  level endon("game_ended");
  var_0 disablephysicaldepthoffieldscripting();
  gunship_allowstances(var_0, 0);
  var_4 = 0;

  if(!var_4) {
    var_0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var_0 scripts\mp\playeractions::allowactionset("gunshipIntro", 0);
  }

  var_5 = "gunship_intro";
  var_7 = level.scr_anim[var_1.streakname][var_5];
  var_8 = getanimlength(var_7);

  if(gunship_islargemap()) {
    if(level.gametype == "arm") {
      if(isDefined(level.hqmidpoint)) {
        level.gunship.origin = level.hqmidpoint;
      }
    } else if(isDefined(level.set_up_blockade_gate_anims)) {
      level.gunship.origin = level.set_up_blockade_gate_anims;
    } else {
      level.gunship.origin = var_0.origin;
    }
  }

  var_9 = "veh8_mil_air_acharlie130_ks";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0)) {
    var_9 = "veh8_mil_air_acharlie130_ks_east";
  }

  level.gunship_intromodel = spawn("script_model", level.gunship.origin);
  level.gunship_intromodel setModel(var_9);
  level.gunship_intromodel.angles = level.gunship.angles;
  level.gunship_intromodel setotherent(var_0);
  level.gunship_intromodel.animname = var_1.streakname;
  level.gunship_intromodel.owner = var_0;

  if(!var_4) {
    foreach(var_11 in level.players) {
      if(var_11 != var_0) {
        level.gunship_intromodel hidefromplayer(var_11);
      }
    }

    thread gunship_hideintromodelonplayerconnect();
  }

  var_13 = 2000;

  switch (level.mapname) {
    case "mp_cave_am":
    case "mp_cave":
      var_13 = 500;
      break;
  }

  level.gunship_intromodel linkTo(level.gunship, "tag_origin", var_3 - (0, 0, var_13), (0, var_2 + 90, 0));
  thread set_up_minigun(level.gunship_intromodel, "disconnect");
  thread set_up_minigun(level.gunship_intromodel, "joined_team");
  thread set_up_minigun(level.gunship_intromodel, "joined_spectators");
  waitframe();

  if(!isDefined(level.gunship_intromodel)) {
    return false;
  }

  level.gunship_intromodel scripts\common\anim::setanimtree();
  level.gunship_intromodel.scenenode = spawn("script_model", level.gunship_intromodel.origin);
  level.gunship_intromodel.scenenode.angles = level.gunship_intromodel.angles;
  level.gunship_intromodel.scenenode setModel("tag_origin");
  level.gunship_intromodel playsoundtoplayer("iw8_ks_ac130_intro", var_0);

  if(!var_4) {
    var_0 cameralinkTo(level.gunship_intromodel, "tag_player", 0, 1);
    var_0 painvisionoff();
    var_0 scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    level.gunship_intromodel setscriptablepartstate("clouds_intro", "on", 0);
    level.gunship_intromodel setscriptablepartstate("bodyFX_intro", "on", 0);
    thread gunship_startintroshake(level.gunship_intromodel, var_5, var_8);
    thread gunship_queuecamerazoom(level.gunship_intromodel, var_8);
    thread gunship_playdofintroeffects();
  }

  var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_1.streakname, 1);
  level.gunship_intromodel.scenenode scripts\common\anim::anim_single_solo(level.gunship_intromodel, var_5);

  if(!isDefined(level.gunship_intromodel)) {
    return false;
  }

  level.gunship_intromodel notify("gunship_end_intro");

  if(!var_4) {
    var_0 disablephysicaldepthoffieldscripting();
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var_0 scripts\mp\playeractions::allowactionset("gunshipIntro", 1);
  }

  return true;
}

function set_up_minigun(var_0, var_1) {
  self endon("death");
  self endon("gunship_end_intro");
  level endon("game_ended");
  var_2 = level.gunship_intromodel.owner;
  var_2 waittill(var_0);

  if(var_0 == "disconnect") {
    level.gunshipinuse = 0;
  }

  set_ui_omnvar_for_relics(var_2, var_1);
}

function set_ui_omnvar_for_relics(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && !var_2) {
    var_0 cameraunlink();
    var_0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var_0 disablephysicaldepthoffieldscripting();
    var_0 scripts\mp\playeractions::allowactionset("gunshipIntro", 1);
    var_0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var_1.streakname, "off");
    var_0 setclientomnvar("ui_ac130_hud", 0);
    var_0 painvisionon();
    var_0 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    var_0 visionsetkillstreakforplayer("");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_0, 0);
  }

  var_1 notify("killstreak_finished_with_deploy_weapon");
  self setscriptablepartstate("clouds_intro", "off", 0);
  self setscriptablepartstate("bodyFX_intro", "off", 0);
  self delete();
}

function gunship_hideintromodelonplayerconnect() {
  self endon("death");
  self.owner endon("disconnect");

  for(;;) {
    level waittill("connected", var_0);
    self hidefromplayer(var_0);
  }
}

function gunship_playdofintroeffects() {
  self endon("death");
  self.owner endon("disconnect");
  self.owner enablephysicaldepthoffieldscripting();
  self.owner setphysicaldepthoffield(1.4, 20, 10, 10);
  wait 0.1;
  self.owner setphysicaldepthoffield(0.125, 1500, 5, 10);
  wait 3;
  self.owner setphysicaldepthoffield(0.125, 1000, 5, 10);
  wait 1.5;
  self.owner setphysicaldepthoffield(5.6, 5000, 1, 1);
}

function gunship_startintroshake(var_0, var_1, var_2) {
  self endon("death");
  var_3 = var_1;
  var_4 = 0.45;
  var_5 = 0.05;

  while(var_3 > 0) {
    earthquake(var_4, var_5, self.origin, 5000);
    var_4 -= 0.01;

    if(var_4 <= 0.12) {
      var_4 = 0.12;
    }

    var_3 -= var_5;
    wait var_5;
  }
}

function gunship_queuecamerazoom(var_0, var_1) {
  self endon("death");
  var_1 endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0 - 0.2);
  var_1 visionsetkillstreakforplayer("cruise_predator_slamzoom", 0.1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_1, 1, 0.1);
}

function gunship_returnplayer(var_0) {
  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);
  }

  if(isDefined(var_0)) {
    var_1 = 0;

    if(!var_1) {
      var_0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
      var_0 scripts\mp\playeractions::allowactionset("gunshipUse", 1);
      gunship_allowstances(var_0, 1);
    }

    var_0 setclientomnvar("ui_killstreak_thermal_mode", 0);
    var_0 visionsetthermalforplayer("");
    var_0 scripts\cp_mp\utility\player_utility::setthermalvision(0);
    var_0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
    var_0 setclientomnvar("ui_ac130_hud", 0);
    var_0 stoploopsound();
    var_0 visionsetkillstreakforplayer("");
    var_0 clearclienttriggeraudiozone(0.5);
    var_0 painvisionon();
    var_0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var_0 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    var_0.usinggunship = undefined;

    if(getdvarint("NOSLRNTRKL")) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setThirdPersonDOF")) {
        var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setThirdPersonDOF")]](1);
      }
    }

    if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(level.gunship.deployweaponobj);
      var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(level.gunship.deployweaponobj);
    }

    if(!var_1) {
      thread gunship_restoreplayerweapon(var_0);
    }

    var_0 unlink();

    if(isDefined(var_0.gunship_cloudsfx)) {
      var_0.gunship_cloudsfx delete();
    }
  }

  gunship_lockedonremovedcallback();

  if(isDefined(self.enemytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.enemytargetmarkergroup);
  }

  if(isDefined(self.friendlytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.friendlytargetmarkergroup);
  }

  if(isDefined(level.gunship_intromodel)) {
    level.gunship_intromodel delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "br_respawn")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "br_respawn")]](var_0);
  }

  level.gunshipinuse = 0;
}

function gunship_restoreplayerweapon(var_0) {
  self endon("disconnect");
  var_0 notify("killstreak_finished_with_deploy_weapon");

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::allow_fire(0);
    wait 0.05;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.lastdroppableweaponobj);
    wait 0.767;
    scripts\cp_mp\utility\inventory_utility::_takeweapon("ac130_105mm_mp");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("ac130_40mm_mp");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("ac130_25mm_mp");
    scripts\cp_mp\utility\inventory_utility::_takeweapon(level.gunship.deployweaponobj);
    scripts\common\utility::allow_fire(1);
    scripts\common\utility::allow_weapon_switch(1);
    return;
  }
}

function gunship_watchdamage(var_0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self.damagetaken = 0;
  self.attractor = missile_createattractorent(self, 1000, 4096);

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_11 = undefined;

    if(isDefined(level.teambased) && isPlayer(var_2) && var_2.team == self.team && (!isDefined(var_11) || !var_11)) {
      continue;
    }

    if(var_5 == "MOD_RIFLE_BULLET" || var_5 == "MOD_PISTOL_BULLET" || var_5 == "MOD_EXPLOSIVE_BULLET") {
      continue;
    }

    if(isDefined(self.owner) && isusinggunship(self.owner)) {
      var_12 = "light";

      if(isexplosivedamagemod(var_5)) {
        if(ceil(var_1 / self.maxhealth) >= 0.33) {
          self.owner earthquakeforplayer(0.25, 0.2, self.camera.origin, 150);
          self.owner playRumbleOnEntity("damage_heavy");
          var_12 = "heavy";
        } else {
          self.owner earthquakeforplayer(0.15, 0.15, self.camera.origin, 150);
          self.owner playRumbleOnEntity("damage_light");
        }
      }

      thread gunship_screeninterference(0.2, var_12);
    }

    self.wasdamaged = 1;
    var_13 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
      var_13 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var_2, var_10, var_5, var_1, self.maxhealth, 4, 5, 25, 0, 350);
    }

    if(isPlayer(var_2)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakHit")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakHit")]](var_2, var_10, self, var_5, var_13);
    }

    if(isDefined(var_2.owner) && isPlayer(var_2.owner)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
        var_2.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
      }
    }

    self.damagetaken += var_13;
    self.currenthealth = self.maxhealth - self.damagetaken;

    if(isDefined(self.owner) && isusinggunship(self.owner)) {
      var_0 setclientomnvar("ui_killstreak_health", self.currenthealth / self.maxhealth);
    }

    if(self.currenthealth <= 500 && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("body_damage_light", "on");

      if(isDefined(self.owner) && isusinggunship(self.owner)) {
        self.flashlight setscriptablepartstate("camera_damage_light", "on");
        self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_taking_damage_light");
      }
    } else if(self.currenthealth <= 250 && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("body_damage_light", "off");
      self setscriptablepartstate("body_damage_medium", "on");

      if(isDefined(self.owner) && isusinggunship(self.owner)) {
        self.flashlight setscriptablepartstate("camera_damage_medium", "on");
        self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_taking_damage_medium");
        self.owner playlocalsound("ks_ac130_damage_warning");
      }
    } else if(self.currenthealth <= 0 && self.currentdamagestate == 2) {
      self.currentdamagestate = 3;
      self setscriptablepartstate("body_damage_medium", "off");
      self setscriptablepartstate("contrails", "off");
      thread gunship_startengineblowoutfx();

      if(isDefined(self.owner) && isusinggunship(self.owner)) {
        self.flashlight setscriptablepartstate("camera_damage_heavy", "on");
        self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_taking_damage_heavy");
      }
    }

    if(self.damagetaken >= self.maxhealth) {
      var_14 = self.streakinfo.streakname;
      var_15 = undefined;
      var_16 = "destroyed_" + var_14;
      var_17 = undefined;
      var_18 = "callout_destroyed_" + var_14;
      var_19 = 1;

      if(isPlayer(var_2)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
          GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash"), var_18, var_2);
        }
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
        var_20 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](var_14, var_2, var_10, var_15, var_1, var_16, var_17, var_18, var_19);
      }

      thread gunship_crash(8, var_0);
    }
  }
}

function gunship_startengineblowoutfx() {
  level endon("game_ended");
  self.leftwingfxent setscriptablepartstate("engine_blowout", "on");
  self.leftwingfxent setscriptablepartstate("body_damage_heavy", "on");
  var_0 = randomfloatrange(0.5, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self.rightwingfxent setscriptablepartstate("engine_blowout", "on");
  self.rightwingfxent setscriptablepartstate("body_damage_heavy", "on");
}

function gunship_watchtimeout(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(self.timeout);
  thread gunship_leave(var_0);
}

function set_up_coop_push(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level waittill("game_ended");
  thread gunship_leave(var_0);
}

function gunship_leave(var_0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self notify("leaving");
  self unlink();
  self rotateroll(30, 3);
  var_1 = self.angles;
  var_2 = anglesToForward(var_1);

  if(isDefined(self.owner)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("timeout_gunship", 1);
  }

  gunship_returnplayer(var_0);
  self moveTo(self.origin + var_2 * 50000, 10, 5);
  gunship_waittilldestination(self.origin + var_2 * 50000);
  gunship_removeplane(0);
}

function gunship_waittilldestination(var_0) {
  while(isDefined(self) && self.origin != var_0) {
    waitframe();
  }
}

function set_up_pilots(var_0, var_1) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  var_0 waittill(var_1);
  thread gunship_crash(8, var_0);
}

function gunship_watchendgame(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var_0 endon("disconnect");
  level waittill("game_ended");
  var_0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
  var_0 setclientomnvar("ui_ac130_hud", 0);
}

function gunship_trackvelocity(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  self.velocity = (0, 0, 0);

  for(;;) {
    self.lastorigin = self.origin;
    wait level.framedurationseconds;
    self.velocity = (self.origin - self.lastorigin) / level.framedurationseconds;
  }
}

function gunship_spawn(var_0, var_1, var_2, var_3) {
  var_4 = "veh8_mil_air_acharlie130_small";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0)) {
    var_4 = "veh8_mil_air_acharlie130_small_east";
  }

  var_5 = spawn("script_model", level.gunship.origin);
  var_5 setModel(var_4);
  var_5 setCanDamage(1);
  var_5.currenthealth = 1000;
  var_5.maxhealth = var_5.currenthealth;
  var_5.health = 99999;
  var_5.owner = var_0;
  var_5.team = var_0.team;
  var_5.timeout = 45;
  var_5.currentdamagestate = 0;
  var_5 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_0, undefined, undefined, 1, 0);
  var_5.flaresreservecount = 2;
  var_5.streakinfo = var_1;
  var_5 scriptmoveroutline();
  var_5 scriptmoverthermal();
  var_5 setotherent(var_0);
  var_8 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_8 = var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", var_5.team, 1, 1, 1);
  }

  var_5.minimapid = var_8;
  var_5 linkTo(level.gunship, "tag_origin", var_3, (0, var_2 + 90, -30));
  level notify("matchrecording_plane", var_5);
  return var_5;
}

function gunship_updateoverlaycoords(var_0) {
  var_0 endon("death");
  var_0 endon("crashing");
  var_0 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  thread gunship_updateplanemodelcoords(var_0);
  thread gunship_updateplayerpositioncoords(var_0);
  thread gunship_updateaimingcoords(var_0);
}

function gunship_updateplanemodelcoords(var_0) {
  var_0 endon("death");
  var_0 endon("crashing");
  var_0 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self setclientomnvar("ui_ac130_coord1_posx", int(var_0.origin[0]));
    self setclientomnvar("ui_ac130_coord1_posy", int(var_0.origin[1]));
    self setclientomnvar("ui_ac130_coord1_posz", int(var_0.origin[2]));
    wait 0.5;
  }
}

function gunship_updateplayerpositioncoords(var_0) {
  var_0 endon("death");
  var_0 endon("crashing");
  var_0 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  waitframe();
  self setclientomnvar("ui_ac130_coord2_posx", int(self.origin[0]));
  self setclientomnvar("ui_ac130_coord2_posy", int(self.origin[1]));
  self setclientomnvar("ui_ac130_coord2_posz", int(self.origin[2]));
}

function gunship_updateaimingcoords(var_0) {
  var_0 endon("death");
  var_0 endon("crashing");
  var_0 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_1 = self getvieworigin();
    var_2 = var_1 + anglesToForward(self getplayerangles()) * 15000;
    var_3 = physicstrace(var_1, var_2);
    self setclientomnvar("ui_ac130_coord3_posx", int(var_3[0]));
    self setclientomnvar("ui_ac130_coord3_posy", int(var_3[1]));
    self setclientomnvar("ui_ac130_coord3_posz", int(var_3[2]));
    wait 0.1;
  }
}

function rotateplane(var_0) {
  level notify("stop_rotatePlane_thread");
  level endon("stop_rotatePlane_thread");

  if(var_0 == "on") {
    var_1 = 10;
    var_2 = level.gunship_speed["rotate"] / 360 * var_1;
    level.gunship rotateYaw(level.gunship.angles[2] + var_1, var_2, var_2, 0);
    var_3 = 360 / level.gunship_speed["rotate"];
    var_4 = var_3 * 0.0174533;
    level.gunship_magnitude = var_4 * 9000;

    for(;;) {
      level.gunship rotateYaw(360, level.gunship_speed["rotate"]);
      wait level.gunship_speed["rotate"];
    }

    return;
  }

  if(var_0 == "off") {
    var_5 = 10;
    var_2 = level.gunship_speed["rotate"] / 360 * var_5;
    level.gunship rotateYaw(level.gunship.angles[2] + var_5, var_2, 0, var_2);
    return;
  }

  if(var_0 == "crash") {
    var_1 = 50;
    var_2 = level.gunship_speed["rotate"] / 360 * var_1;
    level.gunship rotateYaw(level.gunship.angles[2] + var_1, var_2, var_2, 0);
    return;
  }
}

function gunship_attachgunner(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var_0 visionsetkillstreakforplayer("", level.framedurationseconds);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_0, 0, 0.1);
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("ac130_105mm_mp");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("ac130_40mm_mp");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("ac130_25mm_mp");
  var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("ac130_105mm_mp");
  self.currentvisionset = "ac130_color";
  waitframe();
  var_0 cameraunlink();

  if(isDefined(level.gunship_intromodel)) {
    if(isDefined(level.gunship_intromodel.scenenode)) {
      level.gunship_intromodel.scenenode delete();
    }

    level.gunship_intromodel setscriptablepartstate("clouds_intro", "off", 0);
    level.gunship_intromodel setscriptablepartstate("bodyFX_intro", "off", 0);
    level.gunship_intromodel hide();
  }

  self.camera = spawn("script_model", self.origin - (0, 0, 20));
  self.camera setModel("tag_player");
  self.camera.angles = vectortoangles(level.gunship.origin - self.camera.origin);
  self.camera linkTo(self);

  if(isbot(var_0)) {
    var_0 cameralinkTo(self.camera, "tag_player");
    return;
  }

  var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_engage");
  var_0.usinggunship = 1;
  var_0 playerlinkweaponviewtodelta(self.camera, "tag_player", 1, 100, 100, 17, 90, 0);
  var_0 playerlinkedsetviewznear(0);
  var_0 visionsetkillstreakforplayer(self.currentvisionset);
  var_0 setclienttriggeraudiozone("ac130_killstreak");
  var_0 setplayerangles(self.camera.angles);
  var_0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "on");
  var_0 setclientomnvar("ui_ac130_hud", 1);
  var_0 setclientomnvar("ui_killstreak_weapon_1_ammo", var_0 getweaponammoclip("ac130_105mm_mp"));
  var_0 setclientomnvar("ui_killstreak_weapon_2_ammo", var_0 getweaponammoclip("ac130_40mm_mp"));
  var_0 setclientomnvar("ui_killstreak_weapon_3_ammo", var_0 getweaponammoclip("ac130_25mm_mp"));
  var_0 setclientomnvar("ui_killstreak_countdown", gettime() + int(self.timeout * 1000));
  var_0 setclientomnvar("ui_killstreak_health", self.maxhealth);
  var_0 setclientomnvar("ui_killstreak_flares", self.flaresreservecount);
  var_0 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.timeout, 0);
  var_0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
  var_0 scripts\mp\playeractions::allowactionset("gunshipUse", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "assignTargetMarkers")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "assignTargetMarkers")]](var_0);
  }

  thread gunship_updateoverlaycoords(var_0);
}

function gunship_watchchangeweapons(var_0) {
  var_0 endon("disconnect");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  var_2 = ["ac130_105mm_mp", "ac130_40mm_mp", "ac130_25mm_mp"];
  var_0 scripts\common\utility::allow_weapon_switch(0);

  if(!isai(var_0)) {
    var_0 notifyonplayercommand("gunship_switch_weapon", "+weapnext");
    var_0 notifyonplayercommand("gunship_switch_weapon", "+weapprev");
    var_0 setclientomnvar("ui_killstreak_weapon", 3);
  }

  var_3 = 3;

  for(;;) {
    var_0 waittill("gunship_switch_weapon");
    var_0 playlocalsound("iw8_ks_ac130_weaponswitch");
    var_4 = var_0 getcurrentweapon();
    var_5 = var_4;

    foreach(var_7 in var_2) {
      if(var_4.basename == var_7) {
        var_8 = var_9 + 1;

        if(var_8 > var_2.size - 1) {
          var_8 = 0;
        }

        var_5 = var_2[var_8];
        break;
      }
    }

    var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_5);

    if(self.currentvisionset == "flir_0_black_to_white") {
      var_10 = gunship_getdofinfobyweapon(var_5);
      var_0 setphysicaldepthoffield(var_10.fstop, var_10.focusdistance, 20, 20);
    }

    var_3--;

    if(var_3 == 0) {
      var_3 = 3;
    }

    var_0 setclientomnvar("ui_killstreak_weapon", var_3);
    playfxontagforclients(scripts\engine\utility::getfx("camera_shutter"), var_0, "tag_eye", var_0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.4);
  }
}

function gunship_watchweaponfired(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  var_2 = self.streakinfo;

  for(;;) {
    var_0 waittill("missile_fire", var_3);
    thread gunship_watchweaponimpact(var_0);
    var_3.streakinfo = var_2;
    var_2.shots_fired++;
    var_4 = var_0 getcurrentweapon();
    var_5 = var_0 getweaponammoclip(var_4);

    switch (var_4.basename) {
      case "ac130_105mm_mp":
        earthquake(0.2, 1, self.origin, 1000);
        var_0 setclientomnvar("ui_killstreak_weapon_1_ammo", var_5);
        thread gunship_watch105mmexplosion(var_3, self);
        break;
      case "ac130_40mm_mp":
        earthquake(0.1, 0.5, self.origin, 1000);
        var_0 setclientomnvar("ui_killstreak_weapon_2_ammo", var_5);
        break;
      case "ac130_25mm_mp":
        var_0 setclientomnvar("ui_killstreak_weapon_3_ammo", var_5);
        break;
    }

    if(var_5 == 0) {
      thread gunship_weaponreload(var_0, var_4);
    }
  }
}

function gunship_watchweaponimpact(var_0, var_1) {
  level endon("game_ended");
  var_2 = self getcurrentweapon();
  var_0 waittill("missile_stuck", var_3, var_4, var_5, var_6, var_7, var_8);
  var_9 = 0.5;
  var_10 = 100;

  if(isDefined(var_2) && isDefined(var_2.basename)) {
    switch (var_2.basename) {
      case "ac130_105mm_mp":
        var_9 = 1.5;
        var_10 = 500;
        break;
      case "ac130_40mm_mp":
        var_9 = 1;
        var_10 = 300;
        break;
    }
  }

  var_11 = spawn("script_model", var_0.origin);
  var_11 setModel("ks_ac130_target_mp");
  var_11.angles = vectortoangles(var_8);
  var_11 linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_12 = "on";

  if(istrue(var_1)) {
    var_12 = "debug_ground_fx";
  }

  var_11 setscriptablepartstate(var_0.weapon_name, var_12, 0);

  if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_0.origin, var_10, var_10, self.team, var_9, self, 1);
    }

    var_11 setotherent(self);
    var_0 detonate();
  } else {
    var_0 delete();
  }

  var_13 = var_11.origin;
  var_14 = getmissileexplscale(var_0.weapon_name);
  var_15 = 0.75;
  var_16 = getmissileexplradius(var_0.weapon_name);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "artillery_earthQuake")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "artillery_earthQuake")]](var_13, var_14, var_15, var_16);
  }

  thread deleteaftertime(var_11);
}

function getmissileexplscale(var_0) {
  var_1 = 1;

  switch (var_0) {
    case "ac130_105mm_mp":
      var_1 = 0.75;
      break;
    case "ac130_40mm_mp":
      var_1 = 0.5;
      break;
    case "ac130_25mm_mp":
      var_1 = 0.15;
      break;
  }

  return var_1;
}

function getmissileexplradius(var_0) {
  var_1 = 1;

  switch (var_0) {
    case "ac130_105mm_mp":
      var_1 = 2000;
      break;
    case "ac130_40mm_mp":
      var_1 = 1300;
      break;
    case "ac130_25mm_mp":
      var_1 = 700;
      break;
  }

  return var_1;
}

function gunship_watch105mmexplosion(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("leaving");
  var_0 endon("crashing");
  var_1 endon("disconnect");
  self waittill("death");
  earthquake(0.125, 0.5, var_0.origin, 1000);
  var_2 = gunship_getvisionsetformat(var_0.currentvisionset);
  var_3 = gunship_getvisionset(var_2);

  if(var_2 == "flir") {
    var_1 visionsetthermalforplayer(var_3);
  } else {
    var_1 visionsetkillstreakforplayer(var_3);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);

  if(var_2 == "flir") {
    var_1 visionsetthermalforplayer(var_0.currentvisionset);
    return;
  }

  var_1 visionsetkillstreakforplayer(var_0.currentvisionset);
}

function gunship_screeninterference(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(isDefined(var_2)) {
    var_3 = gunship_getvisionsetformat(self.currentvisionset);
    var_4 = gunship_getvisionset(var_3, var_1);

    if(var_3 == "flir") {
      var_2 visionsetthermalforplayer(var_4);
    } else {
      var_2 visionsetkillstreakforplayer(var_4);
    }

    if(isDefined(var_0) && isDefined(self.currentvisionset)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

      if(var_3 == "flir") {
        var_2 visionsetthermalforplayer(self.currentvisionset);
        return;
      }

      var_2 visionsetkillstreakforplayer(self.currentvisionset);
      return;
    }

    return;
  }
}

function gunship_getvisionsetformat(var_0) {
  return scripts\engine\utility::ter_op(issubstr(var_0, "flir"), "flir", "color");
}

function gunship_getvisionset(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1)) {
    if(var_0 == "flir") {
      var_2 = var_0 + "_0_black_to_white_" + var_1 + "_damage";
    } else {
      var_2 = "ac130_color_" + var_1 + "_damage";
    }
  } else {
    var_2 = "ac130_" + var_0 + "_glitch";
  }

  return var_2;
}

function gunship_watchthermaltoggle(var_0) {
  if(!isai(var_0)) {
    var_0 thread scripts\cp_mp\utility\player_utility::watchthermalinputchange();
  }

  gunship_watchthermaltoggleinternal(var_0);

  if(isDefined(var_0) && !isai(var_0)) {
    var_0 scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();
    return;
  }
}

function gunship_watchthermaltoggleinternal(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_0 endon("disconnect");
  level endon("game_ended");
  self.flashlight = spawn("script_model", self.origin);
  self.flashlight setModel("ks_ac130_mp");
  self.flashlight dontinterpolate();
  thread gunship_watchthermalflashlightpos(self.flashlight, self);

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    thread gunship_showflashlight();
  }

  var_1 = 0;
  var_2 = 1;
  var_4 = 12;
  var_5 = 1000;
  jumpiffalse(scripts\cp_mp\utility\game_utility::isnightmap() && istrue(var_2)) LOC_000000dd;
  var_0 setclientomnvar("ui_killstreak_thermal_mode", 1);
  var_0 visionsetthermalforplayer("flir_0_black_to_white");
  var_0 scripts\cp_mp\utility\player_utility::setthermalvision(1, var_4, var_5);
  self.currentvisionset = "flir_0_black_to_white";
  self.flashlight notify("flashlight_on");
  var_1 = 1;
  var_0 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_flir_mp", "top", self.timeout, 0);

  for(;;) {
    var_0 waittill("switch_thermal_mode");
    var_6 = var_0 getcurrentweapon();
    var_7 = gunship_getdofinfobyweapon(var_6.basename);

    if(!istrue(var_1)) {
      var_0 setclientomnvar("ui_killstreak_thermal_mode", 1);
      var_0 visionsetthermalforplayer("flir_0_black_to_white");
      var_0 scripts\cp_mp\utility\player_utility::setthermalvision(1, var_7.fstop, var_7.focusdistance);
      self.currentvisionset = "flir_0_black_to_white";
      var_1 = 1;
      var_0 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_flir_mp", "top", self.timeout, 0);
      continue;
    }

    var_0 setclientomnvar("ui_killstreak_thermal_mode", 0);
    var_0 scripts\cp_mp\utility\player_utility::setthermalvision(0);
    var_0 visionsetkillstreakforplayer("ac130_color");
    self.currentvisionset = "ac130_color";
    var_1 = 0;
    var_0 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.timeout, 0);
  }
}

function gunship_getdofinfobyweapon(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case "ac130_105mm_mp":
      var_1.fstop = 8;
      var_1.focusdistance = 600;
      break;
    case "ac130_40mm_mp":
      var_1.fstop = 8;
      var_1.focusdistance = 600;
      break;
    case "ac130_25mm_mp":
      var_1.fstop = 8;
      var_1.focusdistance = 3500;
      break;
  }

  return var_1;
}

function gunship_watchthermalflashlightpos(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  var_2 = 1;

  while(isDefined(var_0) && isDefined(var_1)) {
    self.origin = var_0.origin;

    if(istrue(var_2)) {
      self.angles = var_1 getplayerangles();
    }

    wait 0.05;
  }

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function gunship_showflashlight() {
  self endon("death");
  level endon("game_ended");
  playFXOnTag(scripts\engine\utility::getfx("camera_spotlight"), self, "tag_origin");

  for(;;) {
    level waittill("player_enabled_nvgs");
    stopFXOnTag(scripts\engine\utility::getfx("camera_spotlight"), self, "tag_origin");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    playFXOnTag(scripts\engine\utility::getfx("camera_spotlight"), self, "tag_origin");
  }
}

function gunship_weaponreload(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("crashing");
  var_1 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  var_2 = getgunshipweaponrootname(var_0);
  self playlocalsound(var_2 + "_mp_reload");
  gunship_waitforweaponreloadtime(var_0, var_2);
  var_3 = var_2 + "_reloaded";

  if(var_2 == "ac130_105mm") {
    var_3 = "gunship_105mm_reloaded";
  } else if(var_2 == "ac130_40mm") {
    var_3 = "gunship_40mm_reloaded";
  } else {
    var_3 = "gunship_25mm_reloaded";
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(var_3);
  var_4 = weaponmaxammo(var_0);
  self setweaponammoclip(var_0, var_4);
  var_5 = undefined;

  switch (var_2) {
    case "ac130_105mm":
      var_5 = "ui_killstreak_weapon_1_ammo";
      break;
    case "ac130_40mm":
      var_5 = "ui_killstreak_weapon_2_ammo";
      break;
    case "ac130_25mm":
      var_5 = "ui_killstreak_weapon_3_ammo";
      break;
  }

  self setclientomnvar(var_5, var_4);
}

function gunship_waitforweaponreloadtime(var_0, var_1) {
  var_2 = level.weaponreloadtime[var_0.basename];
  var_3 = undefined;

  switch (var_1) {
    case "ac130_105mm":
      var_3 = "ui_killsreak_weapon_1_reloadtime";
      break;
    case "ac130_40mm":
      var_3 = "ui_killsreak_weapon_2_reloadtime";
      break;
    case "ac130_25mm":
      var_3 = "ui_killsreak_weapon_3_reloadtime";
      break;
  }

  self setclientomnvar(var_3, gettime() + int(var_2 * 1000));

  for(;;) {
    wait 0.05;
    var_2 -= 0.05;

    if(var_2 <= 0) {
      break;
    }
  }
}

function getgunshipweaponrootname(var_0) {
  var_1 = 0;
  var_2 = var_0.basename;
  var_3 = strtok(var_2, "_");
  return var_3[var_1] + "_" + var_3[var_1 + 1];
}

function gunship_playpilotfx(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_0.gunship_cloudsfx = spawn("script_model", var_0 getEye());
  var_0.gunship_cloudsfx setModel("tag_origin");
  var_0.gunship_cloudsfx linkTo(var_0, "tag_eye");
  waitframe();
  playfxontagforclients(scripts\engine\utility::getfx("clouds"), var_0.gunship_cloudsfx, "tag_origin", var_0);
}

function deleteaftertime(var_0) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self delete();
}

function gunship_crash(var_0, var_1) {
  self notify("crashing");
  self.crashed = 1;
  gunship_returnplayer(var_1);
  thread gunship_movetocrashpos(var_0);
}

function gunship_movetocrashpos(var_0) {
  level endon("game_ended");
  self.leftwingfxent setscriptablepartstate("engine_blowout", "off");
  self.rightwingfxent setscriptablepartstate("engine_blowout", "off");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  self.leftwingfxent setscriptablepartstate("engine_blowout", "on");
  self.rightwingfxent setscriptablepartstate("engine_blowout", "on");
  self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_crashing", 1);
  self unlink();
  self.scenenode = spawn("script_model", self.origin);
  self.scenenode setModel("tag_origin");
  self.scenenode.angles = vectortoangles(anglesToForward(self.angles));
  self.leftwingfxent setscriptablepartstate("engine_blowout", "off");
  self.rightwingfxent setscriptablepartstate("engine_blowout", "off");
  self.leftwingfxent setscriptablepartstate("body_damage_heavy", "off");
  self.rightwingfxent setscriptablepartstate("body_damage_heavy", "off");
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("ks_ac130_mp_mesh");
  var_1.angles = self.angles;
  var_1.animname = self.streakinfo.streakname;
  var_1 scripts\common\anim::setanimtree();
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("ks_ac130_mp");
  var_2.angles = self.angles;
  var_2 linkTo(var_1, "tag_body", (0, 0, -10), (0, 0, 0));
  var_3 = "crash_air";
  var_2 setscriptablepartstate(var_3, "on", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "delayEntDelete")) {
    var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "delayEntDelete")]](10);
    var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "delayEntDelete")]](10);
  }

  thread gunship_crash_audio();
  thread gunship_delayhide();
  thread gunship_crashexplosionscreenshake(level.gunship_crashanimlength);
  thread gunship_crashexplosionradiostatic(level.gunship_crashanimlength);
  self.scenenode scripts\common\anim::anim_single_solo(var_1, "gunship_death", undefined);
  self.scenenode delete();
  gunship_removeplane(1);
}

function gunship_delayhide() {
  level endon("game_ended");
  wait 0.05;
  self hide();
}

function gunship_crashexplosionscreenshake(var_0) {
  level endon("game_ended");
  var_1 = var_0 - 2;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  foreach(var_3 in level.players) {
    if(var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_3 earthquakeforplayer(0.25, 2, self.origin, 30000);
    }
  }
}

function gunship_crashexplosionradiostatic(var_0) {
  level endon("game_ended");
  var_1 = var_0 - 3;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  scripts\cp_mp\utility\dialog_utility::playoperatorstaticinterrupt();
}

function gunship_crash_audio() {
  waitframe();
  playsoundatpos(self.origin, "iw8_ks_ac130_explo_main");
  playsoundatpos(self.origin, "iw8_ks_ac130_explo_low_02");
  playsoundatpos(self.origin, "iw8_ks_ac130_shake_explo");
  playsoundatpos(self.origin, "iw8_ks_ac130_whine");
}

function gunship_removeplane(var_0) {
  if(isDefined(self.flashlight)) {
    self.flashlight delete();
  }

  if(isDefined(self.camera)) {
    self.camera delete();
  }

  if(isDefined(self.leftwingfxent)) {
    self.leftwingfxent delete();
  }

  if(isDefined(self.rightwingfxent)) {
    self.rightwingfxent delete();
  }

  if(isDefined(self.lightfxent)) {
    self.lightfxent delete();
  }

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }

  self.streakinfo.onspray = istrue(var_0);

  if(!scripts\common\utility::iscp()) {
    if(isDefined(self.owner)) {
      self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
    }
  }

  self delete();
}

function gunship_control_bot_aiming() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;
  var_5 = undefined;
  var_6 = (self botgetdifficultysetting("minInaccuracy") + self botgetdifficultysetting("maxInaccuracy")) / 2;
  var_7 = 0;

  for(;;) {
    var_8 = 0;
    var_9 = 0;

    if(isDefined(var_1) && var_1.health <= 0 && gettime() - var_1.deathtime < 2000) {
      var_8 = 1;
      var_9 = 1;
    } else if(isalive(self.enemy) && (self botcanseeentity(self.enemy) || gettime() - self lastknowntime(self.enemy) <= 300)) {
      var_8 = 1;
      var_1 = self.enemy;
      var_10 = var_1.origin;
      var_0 = self.enemy.origin;

      if(self botcanseeentity(self.enemy)) {
        var_7 = 0;
        var_9 = 1;
        var_11 = gettime();
      } else {
        var_7 += 0.05;

        if(var_7 > 5) {
          var_8 = 0;
        }
      }
    }

    if(var_8) {
      if(isDefined(var_0)) {
        var_2 = var_0;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("bots", "bot_body_is_dead")) {
        if(var_9 && (self[[scripts\cp_mp\utility\script_utility::getsharedfunc("bots", "bot_body_is_dead")]]() || distancesquared(var_2, level.gunship.origin) > level.physicssphereradius["ac130_105mm_mp"] * level.physicssphereradius["ac130_105mm_mp"])) {
          self botpressbutton("attack");
        }
      }

      if(gettime() > var_4 + 500) {
        var_12 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_13 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_14 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_5 = (150 * var_12, 150 * var_13, 150 * var_14);
        var_4 = gettime();
      }

      var_2 += var_5;
    } else if(gettime() > var_3) {
      var_3 = gettime() + randomintrange(1000, 2000);
      var_2 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("bots", "get_random_outside_target")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("bots", "get_random_outside_target")]]();
      }
    }

    self botlookatpoint(var_2, 0.2, "script_forced");
    wait 0.05;
  }
}

function gunship_handlemissiledetection(var_0, var_1, var_2, var_3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](var_2);
      }

      thread gunship_playflaresfx(var_2);
      var_2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_flares", 1);
      var_6 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy")) {
        var_6 = var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](var_0);
      }

      self missile_settargetEnt(var_6);
      self notify("missile_pairedWithFlare");
      return;
    } else if(var_6 < 300 && var_3.flaresreservecount <= 0) {
      thread gunship_playfakebodyexplosion();
      var_7 = weapongetdamagemax(self.weapon_name);

      if(isDefined(self.owner)) {
        var_3 dodamage(var_7, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name);
      }

      self delete();
    }

    waitframe();
  }
}

function gunship_playfakebodyexplosion() {
  if(!isDefined(self.missileexplcounter)) {
    self.missileexplcounter = 0;
  }

  self.missileexplcounter++;

  if(self.missileexplcounter > 4) {
    self.missileexplcounter = 0;
  }

  self setscriptablepartstate("fake_missile_expl_" + self.missileexplcounter, "on", 0);
  self playsoundonmovingent("iw8_ks_ac130_dist_rkt_explo");
  wait 2;
  self setscriptablepartstate("fake_missile_expl_" + self.missileexplcounter, "off", 0);
}

function gunship_playflaresfx(var_0) {
  var_1 = "tag_origin";

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  playsoundatpos(self gettagorigin(var_1), "ks_ac130_flares");
  playFXOnTag(scripts\engine\utility::getfx("gunship_flares"), self, var_1);
  var_2 = self.flaresreservecount + 1;
  self setscriptablepartstate("fake_flares_" + var_2, "on", 0);
}

function isusinggunship() {
  return isDefined(self.usinggunship);
}

function gunship_linklightfxent() {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  var_0 = anglesToForward(self.angles);
  self setscriptablepartstate("lights", "on");
}

function gunship_linkwingfxents() {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  var_0 = self gettagorigin("tag_left_outer_prop");
  self.leftwingfxent = spawn("script_model", var_0);
  self.leftwingfxent setModel("ks_ac130_mp");
  self.leftwingfxent.angles = self.angles;
  self.leftwingfxent setotherent(self.owner);
  self.leftwingfxent linkTo(self, "tag_left_outer_prop", (0, 0, 0), (0, 0, 0));
  var_1 = self gettagorigin("tag_right_outer_prop");
  self.rightwingfxent = spawn("script_model", var_1);
  self.rightwingfxent setModel("ks_ac130_mp");
  self.rightwingfxent.angles = self.angles;
  self.rightwingfxent setotherent(self.owner);
  self.rightwingfxent linkTo(self, "tag_right_outer_prop", (0, 0, 0), (0, 0, 0));
  self setscriptablepartstate("contrails", "on");
}

function gunship_watchtargets(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_0 endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  for(;;) {
    var_1 = [];

    foreach(var_3 in level.players) {
      if(!isDefined(var_3) || !var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(self.owner worldpointinreticle_circle(var_3.origin, 80, 100)) {
        if(level.teambased && var_3.team == self.team) {
          continue;
        }

        if(var_3 == self.owner) {
          continue;
        }

        if(!scripts\cp_mp\utility\killstreak_utility::streakcanseetarget(self.origin, var_3 gettagorigin("j_spineupper"), self)) {
          continue;
        }

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          if(var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
            continue;
          }
        }

        var_1 = gunship_getnearbytargets(var_3);
        break;
      }

      wait 0.05;
    }

    if(var_1.size > 0 && var_1.size < 2) {
      var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_single_spotted");
    } else if(var_1.size >= 2) {
      var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_multi_spotted");
    }

    wait randomintrange(5, 15);
  }
}

function gunship_getnearbytargets(var_0) {
  var_1 = scripts\common\utility::playersinsphere(var_0.origin, 300);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(level.teambased && var_4.team != var_0.team) {
      continue;
    }

    if(!level.teambased && var_4 == self.owner) {
      continue;
    }

    var_2 = var_4;
  }

  return var_2;
}

function gunship_watchkills(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    self.owner waittill("update_rapid_kill_buffered", var_1, var_2);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

    if(isDefined(self.owner.recentkillcount)) {
      if(self.owner.recentkillcount >= 1 && gunship_iskillstreakweapon(var_2)) {
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_good_hit");
      }
    }
  }
}

function gunship_iskillstreakweapon(var_0) {
  return scripts\engine\utility::ter_op(isDefined(var_0) && (var_0 == "ac130_105mm_mp" || var_0 == "ac130_40mm_mp" || var_0 == "ac130_25mm_mp"), 1, 0);
}

function gunship_islargemap() {
  var_0 = scripts\cp_mp\utility\game_utility::islargemap();
  return var_0;
}

function gunship_allowstances(var_0) {
  if(!istrue(var_0)) {
    self.gunship_disabledstances = [];
    var_1 = self getstance();

    switch (var_1) {
      case "stand":
        self.gunship_disabledstances = ["crouch", "prone"];
        break;
      case "crouch":
        self.gunship_disabledstances = ["stand", "prone"];
        break;
      case "prone":
        self.gunship_disabledstances = ["stand", "crouch"];
        break;
    }

    scripts\mp\playeractions::registeractionset("gunshipStance", self.gunship_disabledstances);
    scripts\mp\playeractions::allowactionset("gunshipStance", 0);
    return;
  }

  scripts\mp\playeractions::allowactionset("gunshipStance", 1);
}