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
  var0 = getEntArray("minimap_corner", "targetname");
  var1 = level.mapcenter;

  if(var0.size) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "findBoxCenter")) {
      var1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "findBoxCenter")]](var0[0].origin, var0[1].origin);
    }
  }

  level.gunship = spawn("script_model", var1);
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

function weapongivengunship(var0) {
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
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("gunship", self);
  return tryusegunshipfromstruct(var0);
}

function tryusegunshipfromstruct(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return 0;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "use_killstreak_ac130");
  }

  var1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var0, &weapongivengunship);

  if(!istrue(var1)) {
    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      var0 notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  if(istrue(level.gunshipinuse)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    var0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  if(level.gameended) {
    var0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  var2 = gunship_startuse(self, var0);

  if(!istrue(var2)) {
    return 0;
  }

  return var2;
}

function gunship_monitormanualplayerexit(var0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var0 endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]();
  }

  self waittill("killstreakExit");
  thread gunship_leave(var0);
}

function gunship_startuse(var0, var1) {
  level endon("game_ended");

  if(isDefined(level.gunshipplayer)) {
    return false;
  }

  var2 = randomint(360);
  var3 = 9000;
  var4 = cos(var2) * var3;
  var5 = sin(var2) * var3;
  var6 = 8000;
  var7 = vectorNormalize((var4, var5, var6));
  var7 *= var6;
  level.gunshipinuse = 1;

  if(scripts\common\utility::iscp()) {
    var0.start_position = var0.origin;
  }

  var8 = gunship_playintro(var0, var1, var2, var7);

  if(!isDefined(var8) || var8 == 0) {
    level.gunshipinuse = 0;
    return false;
  }

  var9 = gunship_spawn(var0, var1, var2, var7);

  if(!isDefined(var9)) {
    level.gunshipinuse = 0;
    return false;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash"), "used_gunship", var0);
  }

  if(getdvarint("NOSLRNTRKL")) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setThirdPersonDOF")) {
      var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setThirdPersonDOF")]](0);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var9.streakinfo.streakname, "Killstreak_Air", var0);
  }

  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(var9, &gunship_lockedoncallback);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(var9, &gunship_lockedonremovedcallback);
  thread gunship_attachgunner(var9);
  thread gunship_watchchangeweapons(var9);
  thread gunship_watchweaponfired(var9);
  thread gunship_watchthermaltoggle(var9);
  thread gunship_watchdamage(var9);
  thread gunship_watchtimeout(var9);
  thread set_up_coop_push(var9);
  thread set_up_pilots(var9, var0);
  thread set_up_pilots(var9, var0);
  thread set_up_pilots(var9, var0);
  thread set_up_pilots(var9, var0);
  thread gunship_watchendgame(var9);
  thread gunship_playpilotfx(var9);
  thread gunship_linklightfxent();
  thread gunship_linkwingfxents();
  thread gunship_monitormanualplayerexit(var9);
  thread gunship_trackvelocity(var9);
  thread gunship_watchtargets(var9);
  thread gunship_watchkills(var9);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    var9 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](&gunship_handlemissiledetection);
  }

  var9 playLoopSound("iw8_ks_ac130_lp");
  return true;
}

function gunship_lockedoncallback() {
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_missile_lock");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

function gunship_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

function gunship_playintro(var0, var1, var2, var3) {
  var0 endon("disconnect");
  level endon("game_ended");
  var0 disablephysicaldepthoffieldscripting();
  gunship_allowstances(var0, 0);
  var4 = 0;

  if(!var4) {
    var0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var0 scripts\mp\playeractions::allowactionset("gunshipIntro", 0);
  }

  var5 = "gunship_intro";
  var7 = level.scr_anim[var1.streakname][var5];
  var8 = getanimlength(var7);

  if(gunship_islargemap()) {
    if(level.gametype == "arm") {
      if(isDefined(level.hqmidpoint)) {
        level.gunship.origin = level.hqmidpoint;
      }
    } else if(isDefined(level.set_up_blockade_gate_anims)) {
      level.gunship.origin = level.set_up_blockade_gate_anims;
    } else {
      level.gunship.origin = var0.origin;
    }
  }

  var9 = "veh8_mil_air_acharlie130_ks";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var0)) {
    var9 = "veh8_mil_air_acharlie130_ks_east";
  }

  level.gunship_intromodel = spawn("script_model", level.gunship.origin);
  level.gunship_intromodel setModel(var9);
  level.gunship_intromodel.angles = level.gunship.angles;
  level.gunship_intromodel setotherent(var0);
  level.gunship_intromodel.animname = var1.streakname;
  level.gunship_intromodel.owner = var0;

  if(!var4) {
    foreach(var11 in level.players) {
      if(var11 != var0) {
        level.gunship_intromodel hidefromplayer(var11);
      }
    }

    thread gunship_hideintromodelonplayerconnect();
  }

  var13 = 2000;

  switch (level.mapname) {
    case "mp_cave_am":
    case "mp_cave":
      var13 = 500;
      break;
  }

  level.gunship_intromodel linkTo(level.gunship, "tag_origin", var3 - (0, 0, var13), (0, var2 + 90, 0));
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
  level.gunship_intromodel playsoundtoplayer("iw8_ks_ac130_intro", var0);

  if(!var4) {
    var0 cameralinkTo(level.gunship_intromodel, "tag_player", 0, 1);
    var0 painvisionoff();
    var0 scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    level.gunship_intromodel setscriptablepartstate("clouds_intro", "on", 0);
    level.gunship_intromodel setscriptablepartstate("bodyFX_intro", "on", 0);
    thread gunship_startintroshake(level.gunship_intromodel, var5, var8);
    thread gunship_queuecamerazoom(level.gunship_intromodel, var8);
    thread gunship_playdofintroeffects();
  }

  var0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var1.streakname, 1);
  level.gunship_intromodel.scenenode scripts\common\anim::anim_single_solo(level.gunship_intromodel, var5);

  if(!isDefined(level.gunship_intromodel)) {
    return false;
  }

  level.gunship_intromodel notify("gunship_end_intro");

  if(!var4) {
    var0 disablephysicaldepthoffieldscripting();
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var0 scripts\mp\playeractions::allowactionset("gunshipIntro", 1);
  }

  return true;
}

function set_up_minigun(var0, var1) {
  self endon("death");
  self endon("gunship_end_intro");
  level endon("game_ended");
  var2 = level.gunship_intromodel.owner;
  var2 waittill(var0);

  if(var0 == "disconnect") {
    level.gunshipinuse = 0;
  }

  set_ui_omnvar_for_relics(var2, var1);
}

function set_ui_omnvar_for_relics(var0, var1) {
  var2 = 0;

  if(isDefined(var0) && !var2) {
    var0 cameraunlink();
    var0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var0 disablephysicaldepthoffieldscripting();
    var0 scripts\mp\playeractions::allowactionset("gunshipIntro", 1);
    var0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var1.streakname, "off");
    var0 setclientomnvar("ui_ac130_hud", 0);
    var0 painvisionon();
    var0 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    var0 visionsetkillstreakforplayer("");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var0, 0);
  }

  var1 notify("killstreak_finished_with_deploy_weapon");
  self setscriptablepartstate("clouds_intro", "off", 0);
  self setscriptablepartstate("bodyFX_intro", "off", 0);
  self delete();
}

function gunship_hideintromodelonplayerconnect() {
  self endon("death");
  self.owner endon("disconnect");

  for(;;) {
    level waittill("connected", var0);
    self hidefromplayer(var0);
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

function gunship_startintroshake(var0, var1, var2) {
  self endon("death");
  var3 = var1;
  var4 = 0.45;
  var5 = 0.05;

  while(var3 > 0) {
    earthquake(var4, var5, self.origin, 5000);
    var4 -= 0.01;

    if(var4 <= 0.12) {
      var4 = 0.12;
    }

    var3 -= var5;
    wait var5;
  }
}

function gunship_queuecamerazoom(var0, var1) {
  self endon("death");
  var1 endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0 - 0.2);
  var1 visionsetkillstreakforplayer("cruise_predator_slamzoom", 0.1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var1, 1, 0.1);
}

function gunship_returnplayer(var0) {
  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);
  }

  if(isDefined(var0)) {
    var1 = 0;

    if(!var1) {
      var0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
      var0 scripts\mp\playeractions::allowactionset("gunshipUse", 1);
      gunship_allowstances(var0, 1);
    }

    var0 setclientomnvar("ui_killstreak_thermal_mode", 0);
    var0 visionsetthermalforplayer("");
    var0 scripts\cp_mp\utility\player_utility::setthermalvision(0);
    var0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
    var0 setclientomnvar("ui_ac130_hud", 0);
    var0 stoploopsound();
    var0 visionsetkillstreakforplayer("");
    var0 clearclienttriggeraudiozone(0.5);
    var0 painvisionon();
    var0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var0 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    var0.usinggunship = undefined;

    if(getdvarint("NOSLRNTRKL")) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setThirdPersonDOF")) {
        var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setThirdPersonDOF")]](1);
      }
    }

    if(var0 scripts\cp_mp\utility\player_utility::_isalive()) {
      var0 scripts\cp_mp\utility\inventory_utility::_giveweapon(level.gunship.deployweaponobj);
      var0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(level.gunship.deployweaponobj);
    }

    if(!var1) {
      thread gunship_restoreplayerweapon(var0);
    }

    var0 unlink();

    if(isDefined(var0.gunship_cloudsfx)) {
      var0.gunship_cloudsfx delete();
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
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "br_respawn")]](var0);
  }

  level.gunshipinuse = 0;
}

function gunship_restoreplayerweapon(var0) {
  self endon("disconnect");
  var0 notify("killstreak_finished_with_deploy_weapon");

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

function gunship_watchdamage(var0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self.damagetaken = 0;
  self.attractor = missile_createattractorent(self, 1000, 4096);

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
    var11 = undefined;

    if(isDefined(level.teambased) && isPlayer(var2) && var2.team == self.team && (!isDefined(var11) || !var11)) {
      continue;
    }

    if(var5 == "MOD_RIFLE_BULLET" || var5 == "MOD_PISTOL_BULLET" || var5 == "MOD_EXPLOSIVE_BULLET") {
      continue;
    }

    if(isDefined(self.owner) && isusinggunship(self.owner)) {
      var12 = "light";

      if(isexplosivedamagemod(var5)) {
        if(ceil(var1 / self.maxhealth) >= 0.33) {
          self.owner earthquakeforplayer(0.25, 0.2, self.camera.origin, 150);
          self.owner playRumbleOnEntity("damage_heavy");
          var12 = "heavy";
        } else {
          self.owner earthquakeforplayer(0.15, 0.15, self.camera.origin, 150);
          self.owner playRumbleOnEntity("damage_light");
        }
      }

      thread gunship_screeninterference(0.2, var12);
    }

    self.wasdamaged = 1;
    var13 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
      var13 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var2, var10, var5, var1, self.maxhealth, 4, 5, 25, 0, 350);
    }

    if(isPlayer(var2)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
        var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakHit")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakHit")]](var2, var10, self, var5, var13);
    }

    if(isDefined(var2.owner) && isPlayer(var2.owner)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
        var2.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
      }
    }

    self.damagetaken += var13;
    self.currenthealth = self.maxhealth - self.damagetaken;

    if(isDefined(self.owner) && isusinggunship(self.owner)) {
      var0 setclientomnvar("ui_killstreak_health", self.currenthealth / self.maxhealth);
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
      var14 = self.streakinfo.streakname;
      var15 = undefined;
      var16 = "destroyed_" + var14;
      var17 = undefined;
      var18 = "callout_destroyed_" + var14;
      var19 = 1;

      if(isPlayer(var2)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
          GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash"), var18, var2);
        }
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
        var20 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](var14, var2, var10, var15, var1, var16, var17, var18, var19);
      }

      thread gunship_crash(8, var0);
    }
  }
}

function gunship_startengineblowoutfx() {
  level endon("game_ended");
  self.leftwingfxent setscriptablepartstate("engine_blowout", "on");
  self.leftwingfxent setscriptablepartstate("body_damage_heavy", "on");
  var0 = randomfloatrange(0.5, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
  self.rightwingfxent setscriptablepartstate("engine_blowout", "on");
  self.rightwingfxent setscriptablepartstate("body_damage_heavy", "on");
}

function gunship_watchtimeout(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(self.timeout);
  thread gunship_leave(var0);
}

function set_up_coop_push(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level waittill("game_ended");
  thread gunship_leave(var0);
}

function gunship_leave(var0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self notify("leaving");
  self unlink();
  self rotateroll(30, 3);
  var1 = self.angles;
  var2 = anglesToForward(var1);

  if(isDefined(self.owner)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("timeout_gunship", 1);
  }

  gunship_returnplayer(var0);
  self moveTo(self.origin + var2 * 50000, 10, 5);
  gunship_waittilldestination(self.origin + var2 * 50000);
  gunship_removeplane(0);
}

function gunship_waittilldestination(var0) {
  while(isDefined(self) && self.origin != var0) {
    waitframe();
  }
}

function set_up_pilots(var0, var1) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  var0 waittill(var1);
  thread gunship_crash(8, var0);
}

function gunship_watchendgame(var0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var0 endon("disconnect");
  level waittill("game_ended");
  var0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
  var0 setclientomnvar("ui_ac130_hud", 0);
}

function gunship_trackvelocity(var0) {
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

function gunship_spawn(var0, var1, var2, var3) {
  var4 = "veh8_mil_air_acharlie130_small";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var0)) {
    var4 = "veh8_mil_air_acharlie130_small_east";
  }

  var5 = spawn("script_model", level.gunship.origin);
  var5 setModel(var4);
  var5 setCanDamage(1);
  var5.currenthealth = 1000;
  var5.maxhealth = var5.currenthealth;
  var5.health = 99999;
  var5.owner = var0;
  var5.team = var0.team;
  var5.timeout = 45;
  var5.currentdamagestate = 0;
  var5 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var0, undefined, undefined, 1, 0);
  var5.flaresreservecount = 2;
  var5.streakinfo = var1;
  var5 scriptmoveroutline();
  var5 scriptmoverthermal();
  var5 setotherent(var0);
  var8 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var8 = var5[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", var5.team, 1, 1, 1);
  }

  var5.minimapid = var8;
  var5 linkTo(level.gunship, "tag_origin", var3, (0, var2 + 90, -30));
  level notify("matchrecording_plane", var5);
  return var5;
}

function gunship_updateoverlaycoords(var0) {
  var0 endon("death");
  var0 endon("crashing");
  var0 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  thread gunship_updateplanemodelcoords(var0);
  thread gunship_updateplayerpositioncoords(var0);
  thread gunship_updateaimingcoords(var0);
}

function gunship_updateplanemodelcoords(var0) {
  var0 endon("death");
  var0 endon("crashing");
  var0 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self setclientomnvar("ui_ac130_coord1_posx", int(var0.origin[0]));
    self setclientomnvar("ui_ac130_coord1_posy", int(var0.origin[1]));
    self setclientomnvar("ui_ac130_coord1_posz", int(var0.origin[2]));
    wait 0.5;
  }
}

function gunship_updateplayerpositioncoords(var0) {
  var0 endon("death");
  var0 endon("crashing");
  var0 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  waitframe();
  self setclientomnvar("ui_ac130_coord2_posx", int(self.origin[0]));
  self setclientomnvar("ui_ac130_coord2_posy", int(self.origin[1]));
  self setclientomnvar("ui_ac130_coord2_posz", int(self.origin[2]));
}

function gunship_updateaimingcoords(var0) {
  var0 endon("death");
  var0 endon("crashing");
  var0 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var1 = self getvieworigin();
    var2 = var1 + anglesToForward(self getplayerangles()) * 15000;
    var3 = physicstrace(var1, var2);
    self setclientomnvar("ui_ac130_coord3_posx", int(var3[0]));
    self setclientomnvar("ui_ac130_coord3_posy", int(var3[1]));
    self setclientomnvar("ui_ac130_coord3_posz", int(var3[2]));
    wait 0.1;
  }
}

function rotateplane(var0) {
  level notify("stop_rotatePlane_thread");
  level endon("stop_rotatePlane_thread");

  if(var0 == "on") {
    var1 = 10;
    var2 = level.gunship_speed["rotate"] / 360 * var1;
    level.gunship rotateYaw(level.gunship.angles[2] + var1, var2, var2, 0);
    var3 = 360 / level.gunship_speed["rotate"];
    var4 = var3 * 0.0174533;
    level.gunship_magnitude = var4 * 9000;

    for(;;) {
      level.gunship rotateYaw(360, level.gunship_speed["rotate"]);
      wait level.gunship_speed["rotate"];
    }

    return;
  }

  if(var0 == "off") {
    var5 = 10;
    var2 = level.gunship_speed["rotate"] / 360 * var5;
    level.gunship rotateYaw(level.gunship.angles[2] + var5, var2, 0, var2);
    return;
  }

  if(var0 == "crash") {
    var1 = 50;
    var2 = level.gunship_speed["rotate"] / 360 * var1;
    level.gunship rotateYaw(level.gunship.angles[2] + var1, var2, var2, 0);
    return;
  }
}

function gunship_attachgunner(var0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var0 visionsetkillstreakforplayer("", level.framedurationseconds);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var0, 0, 0.1);
  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon("ac130_105mm_mp");
  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon("ac130_40mm_mp");
  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon("ac130_25mm_mp");
  var0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("ac130_105mm_mp");
  self.currentvisionset = "ac130_color";
  waitframe();
  var0 cameraunlink();

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

  if(isbot(var0)) {
    var0 cameralinkTo(self.camera, "tag_player");
    return;
  }

  var0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_engage");
  var0.usinggunship = 1;
  var0 playerlinkweaponviewtodelta(self.camera, "tag_player", 1, 100, 100, 17, 90, 0);
  var0 playerlinkedsetviewznear(0);
  var0 visionsetkillstreakforplayer(self.currentvisionset);
  var0 setclienttriggeraudiozone("ac130_killstreak");
  var0 setplayerangles(self.camera.angles);
  var0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "on");
  var0 setclientomnvar("ui_ac130_hud", 1);
  var0 setclientomnvar("ui_killstreak_weapon_1_ammo", var0 getweaponammoclip("ac130_105mm_mp"));
  var0 setclientomnvar("ui_killstreak_weapon_2_ammo", var0 getweaponammoclip("ac130_40mm_mp"));
  var0 setclientomnvar("ui_killstreak_weapon_3_ammo", var0 getweaponammoclip("ac130_25mm_mp"));
  var0 setclientomnvar("ui_killstreak_countdown", gettime() + int(self.timeout * 1000));
  var0 setclientomnvar("ui_killstreak_health", self.maxhealth);
  var0 setclientomnvar("ui_killstreak_flares", self.flaresreservecount);
  var0 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.timeout, 0);
  var0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
  var0 scripts\mp\playeractions::allowactionset("gunshipUse", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "assignTargetMarkers")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "assignTargetMarkers")]](var0);
  }

  thread gunship_updateoverlaycoords(var0);
}

function gunship_watchchangeweapons(var0) {
  var0 endon("disconnect");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  var2 = ["ac130_105mm_mp", "ac130_40mm_mp", "ac130_25mm_mp"];
  var0 scripts\common\utility::allow_weapon_switch(0);

  if(!isai(var0)) {
    var0 notifyonplayercommand("gunship_switch_weapon", "+weapnext");
    var0 notifyonplayercommand("gunship_switch_weapon", "+weapprev");
    var0 setclientomnvar("ui_killstreak_weapon", 3);
  }

  var3 = 3;

  for(;;) {
    var0 waittill("gunship_switch_weapon");
    var0 playlocalsound("iw8_ks_ac130_weaponswitch");
    var4 = var0 getcurrentweapon();
    var5 = var4;

    foreach(var7 in var2) {
      if(var4.basename == var7) {
        var8 = var9 + 1;

        if(var8 > var2.size - 1) {
          var8 = 0;
        }

        var5 = var2[var8];
        break;
      }
    }

    var0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var5);

    if(self.currentvisionset == "flir_0_black_to_white") {
      var10 = gunship_getdofinfobyweapon(var5);
      var0 setphysicaldepthoffield(var10.fstop, var10.focusdistance, 20, 20);
    }

    var3--;

    if(var3 == 0) {
      var3 = 3;
    }

    var0 setclientomnvar("ui_killstreak_weapon", var3);
    playfxontagforclients(scripts\engine\utility::getfx("camera_shutter"), var0, "tag_eye", var0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.4);
  }
}

function gunship_watchweaponfired(var0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  var2 = self.streakinfo;

  for(;;) {
    var0 waittill("missile_fire", var3);
    thread gunship_watchweaponimpact(var0);
    var3.streakinfo = var2;
    var2.shots_fired++;
    var4 = var0 getcurrentweapon();
    var5 = var0 getweaponammoclip(var4);

    switch (var4.basename) {
      case "ac130_105mm_mp":
        earthquake(0.2, 1, self.origin, 1000);
        var0 setclientomnvar("ui_killstreak_weapon_1_ammo", var5);
        thread gunship_watch105mmexplosion(var3, self);
        break;
      case "ac130_40mm_mp":
        earthquake(0.1, 0.5, self.origin, 1000);
        var0 setclientomnvar("ui_killstreak_weapon_2_ammo", var5);
        break;
      case "ac130_25mm_mp":
        var0 setclientomnvar("ui_killstreak_weapon_3_ammo", var5);
        break;
    }

    if(var5 == 0) {
      thread gunship_weaponreload(var0, var4);
    }
  }
}

function gunship_watchweaponimpact(var0, var1) {
  level endon("game_ended");
  var2 = self getcurrentweapon();
  var0 waittill("missile_stuck", var3, var4, var5, var6, var7, var8);
  var9 = 0.5;
  var10 = 100;

  if(isDefined(var2) && isDefined(var2.basename)) {
    switch (var2.basename) {
      case "ac130_105mm_mp":
        var9 = 1.5;
        var10 = 500;
        break;
      case "ac130_40mm_mp":
        var9 = 1;
        var10 = 300;
        break;
    }
  }

  var11 = spawn("script_model", var0.origin);
  var11 setModel("ks_ac130_target_mp");
  var11.angles = vectortoangles(var8);
  var11 linkTo(var0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var12 = "on";

  if(istrue(var1)) {
    var12 = "debug_ground_fx";
  }

  var11 setscriptablepartstate(var0.weapon_name, var12, 0);

  if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var0.origin, var10, var10, self.team, var9, self, 1);
    }

    var11 setotherent(self);
    var0 detonate();
  } else {
    var0 delete();
  }

  var13 = var11.origin;
  var14 = getmissileexplscale(var0.weapon_name);
  var15 = 0.75;
  var16 = getmissileexplradius(var0.weapon_name);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "artillery_earthQuake")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "artillery_earthQuake")]](var13, var14, var15, var16);
  }

  thread deleteaftertime(var11);
}

function getmissileexplscale(var0) {
  var1 = 1;

  switch (var0) {
    case "ac130_105mm_mp":
      var1 = 0.75;
      break;
    case "ac130_40mm_mp":
      var1 = 0.5;
      break;
    case "ac130_25mm_mp":
      var1 = 0.15;
      break;
  }

  return var1;
}

function getmissileexplradius(var0) {
  var1 = 1;

  switch (var0) {
    case "ac130_105mm_mp":
      var1 = 2000;
      break;
    case "ac130_40mm_mp":
      var1 = 1300;
      break;
    case "ac130_25mm_mp":
      var1 = 700;
      break;
  }

  return var1;
}

function gunship_watch105mmexplosion(var0, var1) {
  var0 endon("death");
  var0 endon("leaving");
  var0 endon("crashing");
  var1 endon("disconnect");
  self waittill("death");
  earthquake(0.125, 0.5, var0.origin, 1000);
  var2 = gunship_getvisionsetformat(var0.currentvisionset);
  var3 = gunship_getvisionset(var2);

  if(var2 == "flir") {
    var1 visionsetthermalforplayer(var3);
  } else {
    var1 visionsetkillstreakforplayer(var3);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);

  if(var2 == "flir") {
    var1 visionsetthermalforplayer(var0.currentvisionset);
    return;
  }

  var1 visionsetkillstreakforplayer(var0.currentvisionset);
}

function gunship_screeninterference(var0, var1) {
  var2 = self.owner;
  var2 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(isDefined(var2)) {
    var3 = gunship_getvisionsetformat(self.currentvisionset);
    var4 = gunship_getvisionset(var3, var1);

    if(var3 == "flir") {
      var2 visionsetthermalforplayer(var4);
    } else {
      var2 visionsetkillstreakforplayer(var4);
    }

    if(isDefined(var0) && isDefined(self.currentvisionset)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);

      if(var3 == "flir") {
        var2 visionsetthermalforplayer(self.currentvisionset);
        return;
      }

      var2 visionsetkillstreakforplayer(self.currentvisionset);
      return;
    }

    return;
  }
}

function gunship_getvisionsetformat(var0) {
  return scripts\engine\utility::ter_op(issubstr(var0, "flir"), "flir", "color");
}

function gunship_getvisionset(var0, var1) {
  var2 = undefined;

  if(isDefined(var1)) {
    if(var0 == "flir") {
      var2 = var0 + "_0_black_to_white_" + var1 + "_damage";
    } else {
      var2 = "ac130_color_" + var1 + "_damage";
    }
  } else {
    var2 = "ac130_" + var0 + "_glitch";
  }

  return var2;
}

function gunship_watchthermaltoggle(var0) {
  if(!isai(var0)) {
    var0 thread scripts\cp_mp\utility\player_utility::watchthermalinputchange();
  }

  gunship_watchthermaltoggleinternal(var0);

  if(isDefined(var0) && !isai(var0)) {
    var0 scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();
    return;
  }
}

function gunship_watchthermaltoggleinternal(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var0 endon("disconnect");
  level endon("game_ended");
  self.flashlight = spawn("script_model", self.origin);
  self.flashlight setModel("ks_ac130_mp");
  self.flashlight dontinterpolate();
  thread gunship_watchthermalflashlightpos(self.flashlight, self);

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    thread gunship_showflashlight();
  }

  var1 = 0;
  var2 = 1;
  var4 = 12;
  var5 = 1000;
  jumpiffalse(scripts\cp_mp\utility\game_utility::isnightmap() && istrue(var2)) LOC_000000dd;
  var0 setclientomnvar("ui_killstreak_thermal_mode", 1);
  var0 visionsetthermalforplayer("flir_0_black_to_white");
  var0 scripts\cp_mp\utility\player_utility::setthermalvision(1, var4, var5);
  self.currentvisionset = "flir_0_black_to_white";
  self.flashlight notify("flashlight_on");
  var1 = 1;
  var0 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_flir_mp", "top", self.timeout, 0);

  for(;;) {
    var0 waittill("switch_thermal_mode");
    var6 = var0 getcurrentweapon();
    var7 = gunship_getdofinfobyweapon(var6.basename);

    if(!istrue(var1)) {
      var0 setclientomnvar("ui_killstreak_thermal_mode", 1);
      var0 visionsetthermalforplayer("flir_0_black_to_white");
      var0 scripts\cp_mp\utility\player_utility::setthermalvision(1, var7.fstop, var7.focusdistance);
      self.currentvisionset = "flir_0_black_to_white";
      var1 = 1;
      var0 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_flir_mp", "top", self.timeout, 0);
      continue;
    }

    var0 setclientomnvar("ui_killstreak_thermal_mode", 0);
    var0 scripts\cp_mp\utility\player_utility::setthermalvision(0);
    var0 visionsetkillstreakforplayer("ac130_color");
    self.currentvisionset = "ac130_color";
    var1 = 0;
    var0 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.timeout, 0);
  }
}

function gunship_getdofinfobyweapon(var0) {
  var1 = spawnStruct();

  switch (var0) {
    case "ac130_105mm_mp":
      var1.fstop = 8;
      var1.focusdistance = 600;
      break;
    case "ac130_40mm_mp":
      var1.fstop = 8;
      var1.focusdistance = 600;
      break;
    case "ac130_25mm_mp":
      var1.fstop = 8;
      var1.focusdistance = 3500;
      break;
  }

  return var1;
}

function gunship_watchthermalflashlightpos(var0, var1) {
  self endon("death");
  level endon("game_ended");
  var2 = 1;

  while(isDefined(var0) && isDefined(var1)) {
    self.origin = var0.origin;

    if(istrue(var2)) {
      self.angles = var1 getplayerangles();
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

function gunship_weaponreload(var0, var1) {
  var1 endon("death");
  var1 endon("crashing");
  var1 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  var2 = getgunshipweaponrootname(var0);
  self playlocalsound(var2 + "_mp_reload");
  gunship_waitforweaponreloadtime(var0, var2);
  var3 = var2 + "_reloaded";

  if(var2 == "ac130_105mm") {
    var3 = "gunship_105mm_reloaded";
  } else if(var2 == "ac130_40mm") {
    var3 = "gunship_40mm_reloaded";
  } else {
    var3 = "gunship_25mm_reloaded";
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(var3);
  var4 = weaponmaxammo(var0);
  self setweaponammoclip(var0, var4);
  var5 = undefined;

  switch (var2) {
    case "ac130_105mm":
      var5 = "ui_killstreak_weapon_1_ammo";
      break;
    case "ac130_40mm":
      var5 = "ui_killstreak_weapon_2_ammo";
      break;
    case "ac130_25mm":
      var5 = "ui_killstreak_weapon_3_ammo";
      break;
  }

  self setclientomnvar(var5, var4);
}

function gunship_waitforweaponreloadtime(var0, var1) {
  var2 = level.weaponreloadtime[var0.basename];
  var3 = undefined;

  switch (var1) {
    case "ac130_105mm":
      var3 = "ui_killsreak_weapon_1_reloadtime";
      break;
    case "ac130_40mm":
      var3 = "ui_killsreak_weapon_2_reloadtime";
      break;
    case "ac130_25mm":
      var3 = "ui_killsreak_weapon_3_reloadtime";
      break;
  }

  self setclientomnvar(var3, gettime() + int(var2 * 1000));

  for(;;) {
    wait 0.05;
    var2 -= 0.05;

    if(var2 <= 0) {
      break;
    }
  }
}

function getgunshipweaponrootname(var0) {
  var1 = 0;
  var2 = var0.basename;
  var3 = strtok(var2, "_");
  return var3[var1] + "_" + var3[var1 + 1];
}

function gunship_playpilotfx(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var0.gunship_cloudsfx = spawn("script_model", var0 getEye());
  var0.gunship_cloudsfx setModel("tag_origin");
  var0.gunship_cloudsfx linkTo(var0, "tag_eye");
  waitframe();
  playfxontagforclients(scripts\engine\utility::getfx("clouds"), var0.gunship_cloudsfx, "tag_origin", var0);
}

function deleteaftertime(var0) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
  self delete();
}

function gunship_crash(var0, var1) {
  self notify("crashing");
  self.crashed = 1;
  gunship_returnplayer(var1);
  thread gunship_movetocrashpos(var0);
}

function gunship_movetocrashpos(var0) {
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
  var1 = spawn("script_model", self.origin);
  var1 setModel("ks_ac130_mp_mesh");
  var1.angles = self.angles;
  var1.animname = self.streakinfo.streakname;
  var1 scripts\common\anim::setanimtree();
  var2 = spawn("script_model", self.origin);
  var2 setModel("ks_ac130_mp");
  var2.angles = self.angles;
  var2 linkTo(var1, "tag_body", (0, 0, -10), (0, 0, 0));
  var3 = "crash_air";
  var2 setscriptablepartstate(var3, "on", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "delayEntDelete")) {
    var2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "delayEntDelete")]](10);
    var1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "delayEntDelete")]](10);
  }

  thread gunship_crash_audio();
  thread gunship_delayhide();
  thread gunship_crashexplosionscreenshake(level.gunship_crashanimlength);
  thread gunship_crashexplosionradiostatic(level.gunship_crashanimlength);
  self.scenenode scripts\common\anim::anim_single_solo(var1, "gunship_death", undefined);
  self.scenenode delete();
  gunship_removeplane(1);
}

function gunship_delayhide() {
  level endon("game_ended");
  wait 0.05;
  self hide();
}

function gunship_crashexplosionscreenshake(var0) {
  level endon("game_ended");
  var1 = var0 - 2;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var1);

  foreach(var3 in level.players) {
    if(var3 scripts\cp_mp\utility\player_utility::_isalive()) {
      var3 earthquakeforplayer(0.25, 2, self.origin, 30000);
    }
  }
}

function gunship_crashexplosionradiostatic(var0) {
  level endon("game_ended");
  var1 = var0 - 3;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var1);
  scripts\cp_mp\utility\dialog_utility::playoperatorstaticinterrupt();
}

function gunship_crash_audio() {
  waitframe();
  playsoundatpos(self.origin, "iw8_ks_ac130_explo_main");
  playsoundatpos(self.origin, "iw8_ks_ac130_explo_low_02");
  playsoundatpos(self.origin, "iw8_ks_ac130_shake_explo");
  playsoundatpos(self.origin, "iw8_ks_ac130_whine");
}

function gunship_removeplane(var0) {
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

  self.streakinfo.onspray = istrue(var0);

  if(!scripts\common\utility::iscp()) {
    if(isDefined(self.owner)) {
      self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
    }
  }

  self delete();
}

function gunship_control_bot_aiming() {
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;
  var3 = 0;
  var4 = 0;
  var5 = undefined;
  var6 = (self botgetdifficultysetting("minInaccuracy") + self botgetdifficultysetting("maxInaccuracy")) / 2;
  var7 = 0;

  for(;;) {
    var8 = 0;
    var9 = 0;

    if(isDefined(var1) && var1.health <= 0 && gettime() - var1.deathtime < 2000) {
      var8 = 1;
      var9 = 1;
    } else if(isalive(self.enemy) && (self botcanseeentity(self.enemy) || gettime() - self lastknowntime(self.enemy) <= 300)) {
      var8 = 1;
      var1 = self.enemy;
      var10 = var1.origin;
      var0 = self.enemy.origin;

      if(self botcanseeentity(self.enemy)) {
        var7 = 0;
        var9 = 1;
        var11 = gettime();
      } else {
        var7 += 0.05;

        if(var7 > 5) {
          var8 = 0;
        }
      }
    }

    if(var8) {
      if(isDefined(var0)) {
        var2 = var0;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("bots", "bot_body_is_dead")) {
        if(var9 && (self[[scripts\cp_mp\utility\script_utility::getsharedfunc("bots", "bot_body_is_dead")]]() || distancesquared(var2, level.gunship.origin) > level.physicssphereradius["ac130_105mm_mp"] * level.physicssphereradius["ac130_105mm_mp"])) {
          self botpressbutton("attack");
        }
      }

      if(gettime() > var4 + 500) {
        var12 = randomfloatrange(-1 * var6 / 2, var6 / 2);
        var13 = randomfloatrange(-1 * var6 / 2, var6 / 2);
        var14 = randomfloatrange(-1 * var6 / 2, var6 / 2);
        var5 = (150 * var12, 150 * var13, 150 * var14);
        var4 = gettime();
      }

      var2 += var5;
    } else if(gettime() > var3) {
      var3 = gettime() + randomintrange(1000, 2000);
      var2 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("bots", "get_random_outside_target")) {
        var2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("bots", "get_random_outside_target")]]();
      }
    }

    self botlookatpoint(var2, 0.2, "script_forced");
    wait 0.05;
  }
}

function gunship_handlemissiledetection(var0, var1, var2, var3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var2)) {
      break;
    }

    var4 = var2 getpointinbounds(0, 0, 0);
    var5 = distance(self.origin, var4);

    if(var5 < 4000 && var2.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](var2);
      }

      thread gunship_playflaresfx(var2);
      var2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_flares", 1);
      var6 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy")) {
        var6 = var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
        var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](var0);
      }

      self missile_settargetEnt(var6);
      self notify("missile_pairedWithFlare");
      return;
    } else if(var6 < 300 && var3.flaresreservecount <= 0) {
      thread gunship_playfakebodyexplosion();
      var7 = weapongetdamagemax(self.weapon_name);

      if(isDefined(self.owner)) {
        var3 dodamage(var7, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name);
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

function gunship_playflaresfx(var0) {
  var1 = "tag_origin";

  if(isDefined(var0)) {
    var1 = var0;
  }

  playsoundatpos(self gettagorigin(var1), "ks_ac130_flares");
  playFXOnTag(scripts\engine\utility::getfx("gunship_flares"), self, var1);
  var2 = self.flaresreservecount + 1;
  self setscriptablepartstate("fake_flares_" + var2, "on", 0);
}

function isusinggunship() {
  return isDefined(self.usinggunship);
}

function gunship_linklightfxent() {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  var0 = anglesToForward(self.angles);
  self setscriptablepartstate("lights", "on");
}

function gunship_linkwingfxents() {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  var0 = self gettagorigin("tag_left_outer_prop");
  self.leftwingfxent = spawn("script_model", var0);
  self.leftwingfxent setModel("ks_ac130_mp");
  self.leftwingfxent.angles = self.angles;
  self.leftwingfxent setotherent(self.owner);
  self.leftwingfxent linkTo(self, "tag_left_outer_prop", (0, 0, 0), (0, 0, 0));
  var1 = self gettagorigin("tag_right_outer_prop");
  self.rightwingfxent = spawn("script_model", var1);
  self.rightwingfxent setModel("ks_ac130_mp");
  self.rightwingfxent.angles = self.angles;
  self.rightwingfxent setotherent(self.owner);
  self.rightwingfxent linkTo(self, "tag_right_outer_prop", (0, 0, 0), (0, 0, 0));
  self setscriptablepartstate("contrails", "on");
}

function gunship_watchtargets(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var0 endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  for(;;) {
    var1 = [];

    foreach(var3 in level.players) {
      if(!isDefined(var3) || !var3 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(self.owner worldpointinreticle_circle(var3.origin, 80, 100)) {
        if(level.teambased && var3.team == self.team) {
          continue;
        }

        if(var3 == self.owner) {
          continue;
        }

        if(!scripts\cp_mp\utility\killstreak_utility::streakcanseetarget(self.origin, var3 gettagorigin("j_spineupper"), self)) {
          continue;
        }

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          if(var3[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
            continue;
          }
        }

        var1 = gunship_getnearbytargets(var3);
        break;
      }

      wait 0.05;
    }

    if(var1.size > 0 && var1.size < 2) {
      var0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_single_spotted");
    } else if(var1.size >= 2) {
      var0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_multi_spotted");
    }

    wait randomintrange(5, 15);
  }
}

function gunship_getnearbytargets(var0) {
  var1 = scripts\common\utility::playersinsphere(var0.origin, 300);
  var2 = [];

  foreach(var4 in var1) {
    if(level.teambased && var4.team != var0.team) {
      continue;
    }

    if(!level.teambased && var4 == self.owner) {
      continue;
    }

    var2 = var4;
  }

  return var2;
}

function gunship_watchkills(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var0 endon("disconnect");

  for(;;) {
    self.owner waittill("update_rapid_kill_buffered", var1, var2);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

    if(isDefined(self.owner.recentkillcount)) {
      if(self.owner.recentkillcount >= 1 && gunship_iskillstreakweapon(var2)) {
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_good_hit");
      }
    }
  }
}

function gunship_iskillstreakweapon(var0) {
  return scripts\engine\utility::ter_op(isDefined(var0) && (var0 == "ac130_105mm_mp" || var0 == "ac130_40mm_mp" || var0 == "ac130_25mm_mp"), 1, 0);
}

function gunship_islargemap() {
  var0 = scripts\cp_mp\utility\game_utility::islargemap();
  return var0;
}

function gunship_allowstances(var0) {
  if(!istrue(var0)) {
    self.gunship_disabledstances = [];
    var1 = self getstance();

    switch (var1) {
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