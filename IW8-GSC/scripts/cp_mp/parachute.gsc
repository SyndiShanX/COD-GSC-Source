/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\parachute.gsc
***********************************************/

function initparachutedvars() {
  setdvarifuninitialized("scr_parachute_redeploy_min_height", 256);
  setdvarifuninitialized("scr_parachute_redeploy_input_type", 0);
  setdvarifuninitialized("scr_parachute_auto_kick_map_center", (0, 0, 0));
  setdvarifuninitialized("scr_parachute_camera_transition_mode", 2);
  setdvarifuninitialized("scr_parachute_FFSM_enabled", 1);
  setdvarifuninitialized("scr_parachute_hint_enabled", 1);
  setdvarifuninitialized("scr_parachute_hint_zdrop", 0.5);
  setdvarifuninitialized("scr_parachute_hint_zoffset", 0);
  setdvarifuninitialized("scr_parachute_hint_zvelscale", 0);
  setdvarifuninitialized("scr_parachute_hint_zlimit", 5000);
  setdvarifuninitialized("scr_parachute_hint_xyvelscale_high", 10);
  setdvarifuninitialized("scr_parachute_hint_xyvelscale_low", 2);
  setdvarifuninitialized("scr_parachute_hint_xyvelscale_maxheight", 10000);
  setdvarifuninitialized("scr_parachute_hint_xylimit", 7500);
  setdvarifuninitialized("scr_parachute_hint_falling_xyratio", -2);
  level.ref_121c8 = getdvarint("scr_parachute_autodeploy_cut", 1);
  level.ref_121c9 = getdvarint("scr_parachute_cut", 1);
  level.parachuteinitfinished = 1;
  level.audio_player_stop_mud_loop = [];

  if(!isDefined(level.dontshootwhileparachuting)) {
    level.dontshootwhileparachuting = 1;
  }

  if(!isDefined(level.freefallstartcb)) {
    level.freefallstartcb = &freefallstartdefault;
  }

  if(!isDefined(level.parachuteopencb)) {
    level.parachuteopencb = &parachuteopendefault;
  }

  if(!isDefined(level.parachutecompletecb)) {
    level.parachutecompletecb = &parachutecompletedefault;
  }

  if(!isDefined(level.parachutetakeweaponscb)) {
    level.parachutetakeweaponscb = &leaveweaponsdefaultfunc;
  }

  if(!isDefined(level.parachuterestoreweaponscb)) {
    level.parachuterestoreweaponscb = &norestoreweaponsdefaultfunc;
  }

  if(!isDefined(level.ref_121d1)) {
    level.ref_121d1 = &ref_121d2;
  }

  level.ref_133f9 = spawnStruct();
  level.ref_133f9.ref_13918 = getdvarint("scr_parachute_hint_enabled", 1);
  level.ref_133f9.ref_1467b = getdvarfloat("scr_parachute_hint_xyvelscale_high", 0);
  level.ref_133f9.ref_1467c = getdvarfloat("scr_parachute_hint_xyvelscale_low", 0);
  level.ref_133f9.ref_1467d = getdvarfloat("scr_parachute_hint_xyvelscale_maxheight", 0);
  level.ref_133f9.ref_1467a = getdvarfloat("scr_parachute_hint_xylimit", 0);
  level.ref_133f9.ref_1468f = getdvarfloat("scr_parachute_hint_zdrop", 0);
  level.ref_133f9.zoffset = getdvarfloat("scr_parachute_hint_zoffset", 0);
  level.ref_133f9.ref_1472c = getdvarfloat("scr_parachute_hint_zvelscale", 0);
  level.ref_133f9.ref_14690 = getdvarfloat("scr_parachute_hint_zlimit", 0);
  level.ref_133f9.pe_chopper_zones = getdvarfloat("scr_parachute_hint_falling_xyratio", 0);
}

function startfreefall(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(getdvarint("scr_parachute_FFSM_enabled", 0)) {
    thread playerpowerresetpowers(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    return;
  }

  self endon("death_or_disconnect");
  thread parachutemidairdeathwatcher();
  self skydive_interrupt();

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  if(!istrue(level.parachuteinitfinished)) {
    initparachutedvars();
  }

  if(!isDefined(level.dontshootwhileparachuting)) {
    level.dontshootwhileparachuting = 1;
  }

  if(!isDefined(level.freefallstartcb)) {
    level.freefallstartcb = &freefallstartdefault;
  }

  if(!isDefined(level.parachuteopencb)) {
    level.parachuteopencb = &parachuteopendefault;
  }

  if(!isDefined(level.parachutecompletecb)) {
    level.parachutecompletecb = &parachutecompletedefault;
  }

  if(!isDefined(level.parachutetakeweaponscb)) {
    level.parachutetakeweaponscb = &leaveweaponsdefaultfunc;
  }

  if(!isDefined(level.parachuterestoreweaponscb)) {
    level.parachuterestoreweaponscb = &norestoreweaponsdefaultfunc;
  }

  if(!isDefined(var_0)) {
    var_0 = 4;
  }

  if(var_5) {
    self[[level.parachutetakeweaponscb]]();
  }

  self[[level.freefallstartcb]]();

  if(isparachutegametype()) {
    self setclientomnvar("ui_br_altimeter_state", 1);
  }

  if(!isDefined(var_2)) {
    self notifyonplayercommand("open_parachute", "+gostand");
  }

  self animscriptsetinputparamreplicationstatus(1);

  if(isDefined(var_3)) {
    self setvelocity(var_3);
  }

  if(!istrue(level.client_activate)) {
    self skydive_beginfreefall();
  }

  if(getdvarint("scr_parachute_camera_transition_mode", 1) != 2) {
    self skydive_setforcethirdpersonstatus(1);
  }

  if(level.gametype == "br" && (!istrue(var_4) || getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") && getdvarint("scr_infil_parachute_vfx", 1)) {
    thread stop_restock_recharge(getdvarint("scr_bmo_parachuteTouchdownVFX", 1) == 1 && (getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war"));
  }

  if(!istrue(var_1)) {
    wait var_0;
  }

  thread pullchute(var_2, var_1);
}

function stop_restock_recharge(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 = self;
  wait 1;
  var_2 = "enabled";

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.disabledebugdialogue)) {
    var_2 += self.operatorcustomization.disabledebugdialogue;
  }

  var_1 setscriptablepartstate("skydiveVfx", var_2, 0);
  var_1 setisinfilskydive(1);
  wait 2;

  while(isalive(var_1) && !var_1 shoulddisableskydivevfx()) {
    wait 0.25;
  }

  if(var_0) {
    while(isalive(var_1) && !var_1 isonground()) {
      wait 0.25;
    }
  }

  var_1 setscriptablepartstate("skydiveVfx", "default", 0);
  var_1 setisinfilskydive(0);
}

function riotshield_attach_parachute(var_0, var_1) {
  var_2 = undefined;

  if(var_0) {
    self.riotshieldmodel = var_1;
    var_2 = "tag_weapon_right";
  } else {
    self.riotshieldmodelstowed = var_1;
    var_2 = "tag_shield_back";
  }

  self attachshieldmodel(var_1, var_2);
  self.hasriotshield = riotshield_hasweapon_parachute();
}

function riotshield_getmodel_parachute() {
  return "weapon_wm_riotshield";
}

function riotshield_hasweapon_parachute() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(isriotshield_parachute(var_3)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

function isriotshield_parachute(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0)) {
    return false;
  }

  if(isstring(var_0) && var_0 == "none") {
    return false;
  }

  return weapontype(var_0) == "riotshield";
}

function isparachutegametype() {
  return isDefined(level.gametype) && (level.gametype == "br" || level.gametype == "arm" || level.gametype == "war" || level.gametype == "cp_survival" || level.gametype == "trial" || level.gametype == "brtdm");
}

function getc130height() {
  if(isDefined(level.br_level) && isDefined(level.br_level.c130_heightoverride)) {
    return level.br_level.c130_heightoverride;
  }

  return 24000;
}

function release_player_on_damage() {
  if(isDefined(level.fnhidefoundintel)) {
    return level.fnhidefoundintel;
  }

  return 24000;
}

function getc130sealevel() {
  if(isDefined(level.br_level) && isDefined(level.br_level.c130_sealeveloverride)) {
    return level.br_level.c130_sealeveloverride;
  }

  return 650;
}

function steerfalling(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("viewhands_base_iw8");
  var_1 hide();
  self playerlinktodelta(var_1, "tag_player");
  steerfallinginternal(var_1, var_0);
  var_1 delete();
}

function steerfallinginternal(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("freefall_complete");
  self endon("parachute_complete");
  self notify("steerFalling()");
  self endon("steerFalling()");
  var_2 = 13.8;
  var_3 = 0.0001;
  var_4 = -1350;
  var_5 = 1400;
  var_6 = 1600;
  var_7 = -100;

  if(level.gametype == "arm") {
    var_4 = -1750;
    var_5 = 400;
    var_6 = 400;
  }

  if(isDefined(var_1)) {
    var_5 *= var_1;
    var_6 *= var_1;
  }

  var_8 = level.framedurationseconds * var_3;
  var_0.vel = (0, 0, var_7);
  waitframe();
  var_9 = getdvarint("bg_gravity");
  var_10 = (0, 0, 0);

  for(;;) {
    var_11 = self getnormalizedmovement();
    var_12 = var_11[0];
    var_13 = var_11[1];
    var_14 = self getplayerangles(1);
    var_15 = anglesToForward(var_14) * var_12;
    var_16 = anglestoright(var_14) * var_13;
    var_17 = var_16 + var_15;
    var_18 = vectorNormalize(var_17) * var_6;
    var_10 += vectorNormalize(var_18 - var_10) * level.framedurationseconds * var_5;
    var_10 -= var_10 * length(var_10) * var_8;
    var_19 = var_0.vel[2] - var_2 * 39.37 * level.framedurationseconds;
    var_19 = max(var_4, var_19);
    var_20 = (0, 0, var_19);
    var_0.vel = var_20 + var_10;
    var_0.origin += level.framedurationseconds * var_0.vel;
    var_21 = sqrt(var_0.vel[0] * var_0.vel[0] + var_0.vel[1] * var_0.vel[1]);
    var_22 = veltomph(var_0.vel[2] * -1);
    var_23 = veltomph(var_21);
    var_24 = min(1, (self.origin[2] - getc130sealevel()) / (getc130height() - getc130sealevel()));

    if(isparachutegametype()) {
      self setclientomnvar("ui_br_altimeter_height", var_24);
    }

    waitframe();
  }
}

function veltomph(var_0) {
  var_1 = var_0 * 0.05682;
  return var_1;
}

function steerparachuting(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("viewhands_base_iw8");
  var_1 hide();
  self playerlinktodelta(var_1, "tag_player");
  steerparachutinginternal(var_1, var_0);
  var_1 delete();
}

function steerparachutinginternal(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("freefall_complete");
  self endon("parachute_landed");
  self notify("steerFalling()");
  self endon("steerFalling()");
  var_2 = 100;
  var_3 = -200;
  var_4 = 600;
  var_5 = 240;
  var_6 = 120;
  var_7 = 60;
  var_8 = 48;
  var_9 = 35;
  var_10 = 700;
  var_11 = 100;
  var_12 = 600;
  var_13 = 300;
  var_14 = 100;
  var_15 = -150;

  if(level.gametype == "arm") {
    var_15 = -200;
  }

  if(isDefined(var_1)) {
    var_2 *= var_1;
    var_3 *= var_1;
    var_4 *= var_1;
    var_5 *= var_1;
    var_6 *= var_1;
    var_7 *= var_1;
    var_10 *= var_1;
    var_12 *= var_1;
    var_13 *= var_1;
    var_14 *= var_1;
  }

  var_16 = 100;
  var_17 = 0;
  var_18 = 0;
  var_0.vel = (0, 0, 0);

  for(;;) {
    var_19 = self getnormalizedmovement();
    var_20 = var_19[0];
    var_21 = var_19[1];
    var_22 = self getplayerangles(1);
    var_23 = anglesToForward(var_22);
    var_24 = anglestoright(var_22);
    var_25 = scripts\engine\utility::ter_op(var_20 > 0, var_5, var_6);
    var_16 += var_20 * var_25 * level.framedurationseconds;
    var_16 += var_7 * level.framedurationseconds * scripts\engine\utility::sign(var_2 - var_16);
    var_16 = clamp(var_16, var_3, var_4);
    var_26 = -1 * var_20 * var_9;
    var_17 += scripts\engine\utility::sign(var_26 - var_17) * var_8 * level.framedurationseconds;
    var_27 = rotatepointaroundvector(var_24, var_23, var_17);
    var_28 = var_16 * var_27;
    var_29 = var_23 * var_14 + (0, 0, var_15);
    var_18 += var_12 * level.framedurationseconds * var_21;
    var_18 -= var_13 * level.framedurationseconds * scripts\engine\utility::sign(var_18);
    var_18 = clamp(var_18, -1 * var_10, var_10);
    var_30 = var_18 * var_24;
    var_31 = var_11 * abs(var_21);
    var_30 += (0, 0, -1 * var_31);
    var_0.vel = var_28 + var_30 + var_29;
    var_0.origin += var_0.vel * level.framedurationseconds;
    var_32 = sqrt(var_0.vel[0] * var_0.vel[0] + var_0.vel[1] * var_0.vel[1]);
    var_33 = max(0, veltomph(var_0.vel[2] * -1));
    var_34 = max(0, veltomph(var_32));
    var_35 = min(1, (self.origin[2] - getc130sealevel()) / (getc130height() - getc130sealevel()));

    if(isparachutegametype()) {
      self setclientomnvar("ui_br_altimeter_height", var_35);
    }

    waitframe();
  }
}

function usefailextractingmsg() {
  return isDefined(self.play_disguise_vo) && (self.play_disguise_vo == 5 || self.play_disguise_vo == 6);
}

function enablemanualpullchute(var_0) {
  self endon("death_or_disconnect");

  if(isDefined(var_0) && var_0 > 0) {
    self skydive_setdeploymentstatus(0);
    self skydive_setbasejumpingstatus(0);
    wait var_0;
  }

  if(isDefined(self)) {
    if(usefailextractingmsg() || istrue(level.client_activate)) {
      return;
    }

    self skydive_setdeploymentstatus(1);
    self skydive_setbasejumpingstatus(1);
    return;
  }
}

function pullchute(var_0, var_1, var_2) {
  self endon("death_or_disconnect");
  thread enablemanualpullchute(3);
  self waittill("skydive_deployparachute");
  self skydive_setdeploymentstatus(0);
  self notify("freefall_complete");

  if(isparachutegametype()) {
    self setclientomnvar("ui_br_altimeter_state", 2);
  }

  if(!istrue(level.dontshootwhileparachuting)) {
    self[[level.parachuteopencb]]();
  }

  thread startparachute();
}

function parachutedamagemonitor(var_0) {
  self endon("death_or_disconnect");
  self endon("parachute_complete");
  var_0 endon("death");
  var_0 setCanDamage(1);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  var_13 = undefined;
  var_0.shotstaken = 0;

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_14, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(isDefined(var_4)) {
      if(scripts\engine\utility::isbulletdamage(var_4)) {
        var_0.shotstaken++;
      }
    }
  }
}

function startparachute() {
  self endon("death_or_disconnect");

  if(getdvarint("scr_parachute_camera_transition_mode", 1) == 1) {
    self skydive_setforcethirdpersonstatus(0);
  }

  self waittill("skydive_end");
  self.ignorefalldamagetime = gettime() + 5000;

  if(istrue(self.delayswaploadout)) {
    self.delayswaploadout = 0;
  }

  waitframe();
  self[[level.parachuterestoreweaponscb]]();

  if(istrue(level.dontshootwhileparachuting)) {
    self[[level.parachutecompletecb]]();
  }

  self notify("parachute_landed");
  self skydive_setforcethirdpersonstatus(0);
  self notify("parachute_complete");
  self animscriptsetinputparamreplicationstatus(0);

  if(isparachutegametype()) {
    self setclientomnvar("ui_br_altimeter_state", 0);
  }

  if(isparachutegametype()) {
    if(isDefined(level.ref_12036)) {
      self[[level.ref_12036]](self);
      return;
    }

    return;
  }
}

function parachutemidairdeathwatcher() {
  self endon("parachute_complete");
  self waittill("death");

  if(isparachutegametype()) {
    self setclientomnvar("ui_br_altimeter_state", 0);
    return;
  }
}

function freefallstartdefault() {
  self disableusability();
  thread ref_126cb();
}

function ref_126cb() {
  self endon("death_or_disconnect");
  self allowfire(0);
  wait 0.5;
  self allowfire(1);
}

function parachuteopendefault() {}

function parachutecompletedefault() {
  self enableusability();

  if(!scripts\common\utility::is_killstreaks_allowed() && !istrue(self.isjuggernaut)) {
    scripts\common\utility::allow_killstreaks(1);
  }

  if(isDefined(level.modespecificparachutecompletecb)) {
    self[[level.modespecificparachutecompletecb]]();
  }

  self.jumptype = undefined;
}

function getautodeploynorm() {
  return 0.25;
}

function spawnorbitcamera() {
  self cameraset("camera_custom_orbit_0_noremote");
}

function removeorbitcamera() {
  self cameradefault();
}

function leaveweaponsdefaultfunc() {}

function norestoreweaponsdefaultfunc() {}

function takeweaponsdefaultfunc() {
  if(isDefined(self.primaryweaponobj)) {
    self.primaryweaponclipammo = self getweaponammoclip(self.primaryweaponobj);
    self.primaryweaponstockammo = self getweaponammostock(self.primaryweaponobj);
  }

  if(isDefined(self.secondaryweaponobj)) {
    self.secondaryweaponclipammo = self getweaponammoclip(self.secondaryweaponobj);
    self.secondaryweaponstockammo = self getweaponammostock(self.secondaryweaponobj);
  }

  var_0 = getcompleteweaponname("iw8_fists_mp");
  var_1 = getcompleteweaponname("none");
  self.weaponlist = self.primaryweapons;

  for(var_2 = 0; var_2 < self.weaponlist.size; var_2++) {
    var_3 = self.weaponlist[var_2];

    if(isDefined(var_3) && !isnullweapon(var_0, var_3) && !isnullweapon(var_1, var_3)) {
      self takeweapon(var_3);
    }
  }

  self clearaccessory();

  if(!self hasweapon(var_0)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  }

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1);
}

function restoreweaponsdefaultfunc() {
  self takeweapon(self.weaponlist[0]);
  self clearaccessory();

  if(isDefined(self.primaryweaponobj)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.primaryweaponobj, undefined, undefined, 0);

    if(isDefined(self.primaryweaponclipammo)) {
      self setweaponammoclip(self.primaryweaponobj, self.primaryweaponclipammo);
      self setweaponammostock(self.primaryweaponobj, self.primaryweaponstockammo);
    }
  }

  if(isDefined(self.secondaryweaponobj)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.secondaryweaponobj, undefined, undefined, 1);

    if(isDefined(self.primaryweaponclipammo)) {
      self setweaponammoclip(self.secondaryweaponobj, self.secondaryweaponclipammo);
      self setweaponammostock(self.secondaryweaponobj, self.secondaryweaponstockammo);
    }
  }

  self.weaponlist = self getweaponslistprimaries();

  if(isDefined(self.weaponlist[0])) {
    scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0]);
  }

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0])) {
    self.primaryweaponobj = self.weaponlist[0];
  }

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1])) {
    self.secondaryweaponobj = self.weaponlist[1];
    return;
  }
}

function playerwatchforredeploy() {
  level endon("game_ended");
  self endon("disconnect");

  if(scripts\common\utility::iscp()) {
    self endon("death");
  }

  var_0 = getdvarfloat("scr_parachute_redeploy_min_height", 256);
  var_1 = 0;
  self.redeployenabled = 1;

  for(;;) {
    if(istrue(self.redeployenabled) && !self isonground() && scripts\cp_mp\utility\player_utility::_isalive() && !self isskydiving() && !self islinked() && !istrue(self.carrying) && !istrue(level.client_activate)) {
      var_2 = 0;

      switch (getdvarint("scr_parachute_redeploy_input_type", 0)) {
        case 0:
          if(var_1 == 0 && self jumpbuttonPressed()) {
            var_2 = 1;
          }

          break;
        case 1:
          if(self jumpbuttonPressed() && var_1 + 500 < gettime()) {
            var_2 = 1;
          }

          break;
        case 2:
          if(!isDefined(self.doublejumpdetected)) {
            thread watchfordoublejump();
          }

          if(istrue(self.doublejumpdetected)) {
            var_2 = 1;
          }

          break;
        default:
          break;
      }

      if(var_2) {
        var_3 = scripts\common\utility::groundpos(self.origin);
        var_4 = self.origin[2] - var_3[2];

        if(var_4 > var_0) {
          self notify("skydive_deployparachute");
          self skydive_deployparachute();
        }
      }
    }

    if(isDefined(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
      if(!self jumpbuttonPressed()) {
        var_1 = 0;
      } else if(var_1 == 0) {
        var_1 = gettime();
      }
    } else {
      var_1 = 0;
    }

    waitframe();
  }
}

function watchfordoublejump() {
  level endon("game_ended");
  self endon("disconnect");
  self.doublejumpdetected = 0;

  for(;;) {
    if(self jumpbuttonPressed()) {
      var_0 = gettime();
      var_1 = 0;
      waitframe();

      for(;;) {
        if(!self jumpbuttonPressed()) {
          if(gettime() < var_0 + 500 && !self isonground()) {
            var_1 = gettime();
          }

          break;
        }

        if(gettime() > var_0 + 500) {
          break;
        }

        waitframe();
      }

      if(var_1 == 0) {
        continue;
      }

      waitframe();

      for(;;) {
        if(self jumpbuttonPressed()) {
          if(gettime() < var_1 + 500 && !self isonground()) {
            self.doublejumpdetected = 1;
            waitframe();
            self.doublejumpdetected = 0;
          }

          break;
        }

        if(gettime() > var_1 + 500) {
          break;
        }

        waitframe();
      }
    }

    waitframe();
  }
}

function ref_121d2() {
  var_0 = self;

  if(level.gametype == "br") {
    if(isDefined(var_0.play_disguise_vo) && (var_0.play_disguise_vo == 1 || var_0.play_disguise_vo == 2)) {
      play_collected_key_vo(var_0);
      var_0.play_disguise_vo = 3;
      return;
    }

    return;
  }

  if(level.gametype == "cp_survival") {
    var_0 setclientomnvar("ui_br_altimeter_state", 0);
    play_collected_key_vo(var_0, 1);
    return;
  }
}

function ref_14002() {
  var_0 = self;
  var_1 = var_0 getvelocity();
  var_2 = clamp(var_0.origin[2], 0, level.ref_133f9.ref_1467d) / level.ref_133f9.ref_1467d;
  var_3 = level.ref_133f9.ref_1467c + (level.ref_133f9.ref_1467b - level.ref_133f9.ref_1467c) * var_2;
  var_4 = var_1 * (1, 1, 0);
  var_5 = length(var_4);
  var_6 = var_4 * var_3;
  var_7 = var_5 * var_3;

  if(var_7 > level.ref_133f9.ref_1467a) {
    var_6 *= level.ref_133f9.ref_1467a / var_7;
  }

  var_8 = 0;
  var_8 -= var_0.origin[2] * level.ref_133f9.ref_1468f;
  var_8 += level.ref_133f9.zoffset;
  var_8 += var_1[2] * level.ref_133f9.ref_1472c;
  var_8 = clamp(var_8, -1 * level.ref_133f9.ref_14690, 0);
  var_9 = 1;

  if(var_5 < level.ref_133f9.pe_chopper_zones * var_1[2]) {
    var_9 = 2;
  }

  var_0 setadditionalstreampos(var_0.origin + (var_6[0], var_6[1], var_8), 0, var_9);
}

function playerpowerresetpowers(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("freeFallFromPlaneStateMachine");
  self endon("freeFallFromPlaneStateMachine");
  var_7 = self;
  var_7.play_disguise_vo = 1;
  var_7.play_cinderblock_broken_fx = istrue(var_4);
  var_7.play_contract_announcer_maybe = 0;
  play_chopper_kill_vo(var_7, var_0, var_1, var_2, var_3, var_5, var_6);
  play_death_sound_with_global_cooldown(var_7);
  var_8 = gettime();

  for(;;) {
    if(var_7 isskydiving() || var_8 + 2000 < gettime() || usefailextractingmsg(var_7)) {
      goto LOC_00000087;
    }

    waitframe();
  }

  for(;;) {
    if(level.ref_133f9.ref_13918 && var_7.play_contract_announcer_maybe < gettime()) {
      ref_14002(var_7);
      var_7.play_contract_announcer_maybe = gettime() + 500;
    }

    if(var_7 isinfreefall() && var_7.play_disguise_vo != 1) {
      play_death_sound_with_global_cooldown(var_7);
      var_7.play_disguise_vo = 1;
    }

    if(var_7 isparachuting() && var_7.play_disguise_vo != 2) {
      play_death_audio(var_7);
      var_7.play_disguise_vo = 2;
    }

    if(!var_7 isskydiving() && var_7.play_disguise_vo != 3 && var_7.play_disguise_vo != 4 && var_7.play_disguise_vo != 6 || var_7.play_disguise_vo == 5) {
      play_collected_key_vo(var_7);

      if(var_7.play_disguise_vo != 5) {
        var_7.play_disguise_vo = 3;
      } else {
        var_7.play_disguise_vo = 6;
      }
    }

    var_9 = istrue(var_7.inlaststand);
    var_10 = var_7 isonground() && (var_7.play_disguise_vo == 3 || usefailextractingmsg(var_7));
    var_11 = var_7 isonladder();
    var_12 = !scripts\mp\utility\player::isreallyalive(var_7);

    if(var_9 || var_10 || var_11 || var_12) {
      play_counter_beep_sfx_on_bomb_vests(var_7);
      var_7.play_disguise_vo = undefined;
      var_7.play_cinderblock_broken_fx = undefined;
      var_7.play_contract_announcer_maybe = undefined;

      if(var_11) {
        var_7 skydive_interrupt();
      }

      return;
    }

    waitframe();
  }
}

function play_chopper_kill_vo(var_0, var_1, var_2, var_3, var_4, var_5) {
  self skydive_interrupt();

  if(!istrue(level.parachuteinitfinished)) {
    initparachutedvars();
  }

  if(!isDefined(var_0)) {
    var_0 = 4;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(var_4 && level.gametype != "br") {
    self[[level.parachutetakeweaponscb]]();
  }

  self[[level.freefallstartcb]]();

  if(!isDefined(var_2)) {
    self notifyonplayercommand("open_parachute", "+gostand");
  }

  self animscriptsetinputparamreplicationstatus(1);

  if(isDefined(var_3)) {
    self setvelocity(var_3);
  }

  var_6 = level.client_activate;

  if(isDefined(var_5)) {
    var_6 = var_5;
  }

  if(!istrue(var_6)) {
    self skydive_beginfreefall();
  }

  if(getdvarint("scr_parachute_camera_transition_mode", 1) != 2) {
    self skydive_setforcethirdpersonstatus(1);
  }

  if(level.gametype == "br" && (!istrue(self.play_cinderblock_broken_fx) || getDvar("scr_br_gametype", "") == "dmz") || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
    thread stop_restock_recharge(getdvarint("scr_bmo_parachuteTouchdownVFX", 1) == 1 && (getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war"));
  }

  if(istrue(var_1)) {
    thread enablemanualpullchute(0);
  } else {
    thread enablemanualpullchute(var_0);
  }

  self[[level.parachuterestoreweaponscb]]();
}

function play_death_sound_with_global_cooldown() {
  if(isparachutegametype()) {
    self setclientomnvar("ui_br_altimeter_state", 1);
    level.audio_player_stop_mud_loop[self getxuid()] = self;
  }

  if(!self.play_cinderblock_broken_fx) {
    var_0 = "enabled";

    if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.disabledebugdialogue)) {
      var_0 += self.operatorcustomization.disabledebugdialogue;
    }
  }

  if(istrue(level.pilot_linkto_origin_offset)) {
    _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("skydive");
    return;
  }
}

function play_death_audio() {
  self notify("freefall_complete");
  var_0 = scripts\cp_mp\utility\script_utility::ref_140de("game", "isGameTypeBR", 0);
  var_1 = scripts\cp_mp\utility\script_utility::ref_140de("game", "getSubGameType", "");
  var_2 = var_1 != "truckwar" && var_1 != "reveal" && var_1 != "brdov";

  if(var_0 && var_2 && istrue(self.stickers)) {
    var_3 = scripts\cp_mp\utility\script_utility::ref_140de("music", "getRandomMusicSet", "", ["br_infil_jump_parachute"]);
    self setplayermusicstate(var_3);
    self.stickers = undefined;
  }

  level.audio_player_stop_mud_loop[self getxuid()] = self;

  if(isparachutegametype()) {
    self setclientomnvar("ui_br_altimeter_state", 2);
  }

  if(!istrue(level.dontshootwhileparachuting)) {
    self[[level.parachuteopencb]]();
  }

  if(isDefined(level.ref_1205e)) {
    self[[level.ref_1205e]]();
  }

  if(istrue(level.pilot_linkto_origin_offset)) {
    _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("skydive");
    return;
  }
}

function play_collected_key_vo(var_0) {
  self.ignorefalldamagetime = gettime() + 5000;
  self.waitillcanspawnclient = gettime();

  if(istrue(self.delayswaploadout)) {
    self.delayswaploadout = 0;
  }

  if(istrue(level.dontshootwhileparachuting)) {
    self[[level.parachutecompletecb]]();
  }

  self notify("parachute_landed");
  self skydive_setforcethirdpersonstatus(0);

  if(!usefailextractingmsg() && !istrue(level.client_activate)) {
    self skydive_setbasejumpingstatus(1);
  }

  if(istrue(self.restoreriotshieldonland)) {
    riotshield_attach_parachute(self.restoreriotshieldonland == 1, riotshield_getmodel_parachute());
    self.restoreriotshieldonland = undefined;
  }

  level.audio_player_stop_mud_loop[self getxuid()] = undefined;
  self notify("parachute_complete");
  self animscriptsetinputparamreplicationstatus(0);

  if(istrue(level.pilot_linkto_origin_offset)) {
    _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("skydive");
    return;
  }
}

function play_counter_beep_sfx_on_bomb_vests() {
  if(getdvarint("scr_parachute_hint_enabled", 0)) {
    self clearadditionalstreampos();
  }

  if(isparachutegametype()) {
    level.audio_player_stop_mud_loop[self getxuid()] = undefined;
    self setclientomnvar("ui_br_altimeter_state", 0);
    thread ref_1274e();

    if(isDefined(level.ref_12036)) {
      self[[level.ref_12036]](self);
    }

    if(istrue(level.pilot_linkto_origin_offset)) {
      _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("skydive");
      return;
    }

    return;
  }
}

function ref_1274e() {
  self endon("death_or_disconnect");
  wait 0.3;

  if(isalive(self) && self.sessionstate == "playing") {
    self playlocalsound("plr_breath_land_parachute", self);
    self playsoundonmovingent("breath_land_parachute_npc");
    var_0 = scripts\cp_mp\utility\script_utility::ref_140de("game", "isGameTypeBR", 0);

    if(var_0) {
      wait 5;
      var_1 = scripts\cp_mp\utility\script_utility::ref_140de("music", "isBRSuspenseMusicEnabled", 0, [self]);

      if(var_1) {
        self.nosuspensemusic = undefined;
        return;
      }

      return;
    }

    return;
  }
}

function ref_121ca() {
  var_0 = self;
  var_0 skydive_interrupt();

  if(isDefined(var_0.parachute)) {
    var_0.parachute delete();
    return;
  }
}