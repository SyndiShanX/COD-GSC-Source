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

function startfreefall(var0, var1, var2, var3, var4, var5, var6) {
  if(getdvarint("scr_parachute_FFSM_enabled", 0)) {
    thread playerpowerresetpowers(var0, var1, var2, var3, var4, var5, var6);
    return;
  }

  self endon("death_or_disconnect");
  thread parachutemidairdeathwatcher();
  self skydive_interrupt();

  if(!isDefined(var5)) {
    var5 = 1;
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

  if(!isDefined(var0)) {
    var0 = 4;
  }

  if(var5) {
    self[[level.parachutetakeweaponscb]]();
  }

  self[[level.freefallstartcb]]();

  if(isparachutegametype()) {
    self setclientomnvar("ui_br_altimeter_state", 1);
  }

  if(!isDefined(var2)) {
    self notifyonplayercommand("open_parachute", "+gostand");
  }

  self animscriptsetinputparamreplicationstatus(1);

  if(isDefined(var3)) {
    self setvelocity(var3);
  }

  if(!istrue(level.client_activate)) {
    self skydive_beginfreefall();
  }

  if(getdvarint("scr_parachute_camera_transition_mode", 1) != 2) {
    self skydive_setforcethirdpersonstatus(1);
  }

  if(level.gametype == "br" && (!istrue(var4) || getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") && getdvarint("scr_infil_parachute_vfx", 1)) {
    thread stop_restock_recharge(getdvarint("scr_bmo_parachuteTouchdownVFX", 1) == 1 && (getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war"));
  }

  if(!istrue(var1)) {
    wait var0;
  }

  thread pullchute(var2, var1);
}

function stop_restock_recharge(var0) {
  var1 = self;
  level endon("game_ended");
  var1 endon("disconnect");
  var1 = self;
  wait 1;
  var2 = "enabled";

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.disabledebugdialogue)) {
    var2 += self.operatorcustomization.disabledebugdialogue;
  }

  var1 setscriptablepartstate("skydiveVfx", var2, 0);
  var1 setisinfilskydive(1);
  wait 2;

  while(isalive(var1) && !var1 shoulddisableskydivevfx()) {
    wait 0.25;
  }

  if(var0) {
    while(isalive(var1) && !var1 isonground()) {
      wait 0.25;
    }
  }

  var1 setscriptablepartstate("skydiveVfx", "default", 0);
  var1 setisinfilskydive(0);
}

function riotshield_attach_parachute(var0, var1) {
  var2 = undefined;

  if(var0) {
    self.riotshieldmodel = var1;
    var2 = "tag_weapon_right";
  } else {
    self.riotshieldmodelstowed = var1;
    var2 = "tag_shield_back";
  }

  self attachshieldmodel(var1, var2);
  self.hasriotshield = riotshield_hasweapon_parachute();
}

function riotshield_getmodel_parachute() {
  return "weapon_wm_riotshield";
}

function riotshield_hasweapon_parachute() {
  var0 = 0;
  var1 = self getweaponslistprimaries();

  foreach(var3 in var1) {
    if(isriotshield_parachute(var3)) {
      var0 = 1;
      break;
    }
  }

  return var0;
}

function isriotshield_parachute(var0) {
  if(issameweapon(var0) && nullweapon(var0)) {
    return false;
  }

  if(isstring(var0) && var0 == "none") {
    return false;
  }

  return weapontype(var0) == "riotshield";
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

function steerfalling(var0) {
  var1 = spawn("script_model", self.origin);
  var1.angles = self.angles;
  var1 setModel("viewhands_base_iw8");
  var1 hide();
  self playerlinktodelta(var1, "tag_player");
  steerfallinginternal(var1, var0);
  var1 delete();
}

function steerfallinginternal(var0, var1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("freefall_complete");
  self endon("parachute_complete");
  self notify("steerFalling()");
  self endon("steerFalling()");
  var2 = 13.8;
  var3 = 0.0001;
  var4 = -1350;
  var5 = 1400;
  var6 = 1600;
  var7 = -100;

  if(level.gametype == "arm") {
    var4 = -1750;
    var5 = 400;
    var6 = 400;
  }

  if(isDefined(var1)) {
    var5 *= var1;
    var6 *= var1;
  }

  var8 = level.framedurationseconds * var3;
  var0.vel = (0, 0, var7);
  waitframe();
  var9 = getdvarint("NPOQPMP");
  var10 = (0, 0, 0);

  for(;;) {
    var11 = self getnormalizedmovement();
    var12 = var11[0];
    var13 = var11[1];
    var14 = self getplayerangles(1);
    var15 = anglesToForward(var14) * var12;
    var16 = anglestoright(var14) * var13;
    var17 = var16 + var15;
    var18 = vectorNormalize(var17) * var6;
    var10 += vectorNormalize(var18 - var10) * level.framedurationseconds * var5;
    var10 -= var10 * length(var10) * var8;
    var19 = var0.vel[2] - var2 * 39.37 * level.framedurationseconds;
    var19 = max(var4, var19);
    var20 = (0, 0, var19);
    var0.vel = var20 + var10;
    var0.origin += level.framedurationseconds * var0.vel;
    var21 = sqrt(var0.vel[0] * var0.vel[0] + var0.vel[1] * var0.vel[1]);
    var22 = veltomph(var0.vel[2] * -1);
    var23 = veltomph(var21);
    var24 = min(1, (self.origin[2] - getc130sealevel()) / (getc130height() - getc130sealevel()));

    if(isparachutegametype()) {
      self setclientomnvar("ui_br_altimeter_height", var24);
    }

    waitframe();
  }
}

function veltomph(var0) {
  var1 = var0 * 0.05682;
  return var1;
}

function steerparachuting(var0) {
  var1 = spawn("script_model", self.origin);
  var1.angles = self.angles;
  var1 setModel("viewhands_base_iw8");
  var1 hide();
  self playerlinktodelta(var1, "tag_player");
  steerparachutinginternal(var1, var0);
  var1 delete();
}

function steerparachutinginternal(var0, var1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("freefall_complete");
  self endon("parachute_landed");
  self notify("steerFalling()");
  self endon("steerFalling()");
  var2 = 100;
  var3 = -200;
  var4 = 600;
  var5 = 240;
  var6 = 120;
  var7 = 60;
  var8 = 48;
  var9 = 35;
  var10 = 700;
  var11 = 100;
  var12 = 600;
  var13 = 300;
  var14 = 100;
  var15 = -150;

  if(level.gametype == "arm") {
    var15 = -200;
  }

  if(isDefined(var1)) {
    var2 *= var1;
    var3 *= var1;
    var4 *= var1;
    var5 *= var1;
    var6 *= var1;
    var7 *= var1;
    var10 *= var1;
    var12 *= var1;
    var13 *= var1;
    var14 *= var1;
  }

  var16 = 100;
  var17 = 0;
  var18 = 0;
  var0.vel = (0, 0, 0);

  for(;;) {
    var19 = self getnormalizedmovement();
    var20 = var19[0];
    var21 = var19[1];
    var22 = self getplayerangles(1);
    var23 = anglesToForward(var22);
    var24 = anglestoright(var22);
    var25 = scripts\engine\utility::ter_op(var20 > 0, var5, var6);
    var16 += var20 * var25 * level.framedurationseconds;
    var16 += var7 * level.framedurationseconds * scripts\engine\utility::sign(var2 - var16);
    var16 = clamp(var16, var3, var4);
    var26 = -1 * var20 * var9;
    var17 += scripts\engine\utility::sign(var26 - var17) * var8 * level.framedurationseconds;
    var27 = rotatepointaroundvector(var24, var23, var17);
    var28 = var16 * var27;
    var29 = var23 * var14 + (0, 0, var15);
    var18 += var12 * level.framedurationseconds * var21;
    var18 -= var13 * level.framedurationseconds * scripts\engine\utility::sign(var18);
    var18 = clamp(var18, -1 * var10, var10);
    var30 = var18 * var24;
    var31 = var11 * abs(var21);
    var30 += (0, 0, -1 * var31);
    var0.vel = var28 + var30 + var29;
    var0.origin += var0.vel * level.framedurationseconds;
    var32 = sqrt(var0.vel[0] * var0.vel[0] + var0.vel[1] * var0.vel[1]);
    var33 = max(0, veltomph(var0.vel[2] * -1));
    var34 = max(0, veltomph(var32));
    var35 = min(1, (self.origin[2] - getc130sealevel()) / (getc130height() - getc130sealevel()));

    if(isparachutegametype()) {
      self setclientomnvar("ui_br_altimeter_height", var35);
    }

    waitframe();
  }
}

function usefailextractingmsg() {
  return isDefined(self.play_disguise_vo) && (self.play_disguise_vo == 5 || self.play_disguise_vo == 6);
}

function enablemanualpullchute(var0) {
  self endon("death_or_disconnect");

  if(isDefined(var0) && var0 > 0) {
    self skydive_setdeploymentstatus(0);
    self skydive_setbasejumpingstatus(0);
    wait var0;
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

function pullchute(var0, var1, var2) {
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

function parachutedamagemonitor(var0) {
  self endon("death_or_disconnect");
  self endon("parachute_complete");
  var0 endon("death");
  var0 setCanDamage(1);
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;
  var7 = undefined;
  var8 = undefined;
  var9 = undefined;
  var10 = undefined;
  var11 = undefined;
  var12 = undefined;
  var13 = undefined;
  var0.shotstaken = 0;

  for(;;) {
    var0 waittill("damage", var1, var2, var3, var14, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);

    if(isDefined(var4)) {
      if(scripts\engine\utility::isbulletdamage(var4)) {
        var0.shotstaken++;
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

  var0 = getcompleteweaponname("iw8_fists_mp");
  var1 = getcompleteweaponname("none");
  self.weaponlist = self.primaryweapons;

  for(var2 = 0; var2 < self.weaponlist.size; var2++) {
    var3 = self.weaponlist[var2];

    if(isDefined(var3) && !isnullweapon(var0, var3) && !isnullweapon(var1, var3)) {
      self takeweapon(var3);
    }
  }

  self clearaccessory();

  if(!self hasweapon(var0)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var0, undefined, undefined, 1);
  }

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var0, 1);
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

  var0 = getdvarfloat("scr_parachute_redeploy_min_height", 256);
  var1 = 0;
  self.redeployenabled = 1;

  for(;;) {
    if(istrue(self.redeployenabled) && !self isonground() && scripts\cp_mp\utility\player_utility::_isalive() && !self isskydiving() && !self islinked() && !istrue(self.carrying) && !istrue(level.client_activate)) {
      var2 = 0;

      switch (getdvarint("scr_parachute_redeploy_input_type", 0)) {
        case 0:
          if(var1 == 0 && self jumpbuttonPressed()) {
            var2 = 1;
          }

          break;
        case 1:
          if(self jumpbuttonPressed() && var1 + 500 < gettime()) {
            var2 = 1;
          }

          break;
        case 2:
          if(!isDefined(self.doublejumpdetected)) {
            thread watchfordoublejump();
          }

          if(istrue(self.doublejumpdetected)) {
            var2 = 1;
          }

          break;
        default:
          break;
      }

      if(var2) {
        var3 = scripts\common\utility::groundpos(self.origin);
        var4 = self.origin[2] - var3[2];

        if(var4 > var0) {
          self notify("skydive_deployparachute");
          self skydive_deployparachute();
        }
      }
    }

    if(isDefined(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
      if(!self jumpbuttonPressed()) {
        var1 = 0;
      } else if(var1 == 0) {
        var1 = gettime();
      }
    } else {
      var1 = 0;
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
      var0 = gettime();
      var1 = 0;
      waitframe();

      for(;;) {
        if(!self jumpbuttonPressed()) {
          if(gettime() < var0 + 500 && !self isonground()) {
            var1 = gettime();
          }

          break;
        }

        if(gettime() > var0 + 500) {
          break;
        }

        waitframe();
      }

      if(var1 == 0) {
        continue;
      }

      waitframe();

      for(;;) {
        if(self jumpbuttonPressed()) {
          if(gettime() < var1 + 500 && !self isonground()) {
            self.doublejumpdetected = 1;
            waitframe();
            self.doublejumpdetected = 0;
          }

          break;
        }

        if(gettime() > var1 + 500) {
          break;
        }

        waitframe();
      }
    }

    waitframe();
  }
}

function ref_121d2() {
  var0 = self;

  if(level.gametype == "br") {
    if(isDefined(var0.play_disguise_vo) && (var0.play_disguise_vo == 1 || var0.play_disguise_vo == 2)) {
      play_collected_key_vo(var0);
      var0.play_disguise_vo = 3;
      return;
    }

    return;
  }

  if(level.gametype == "cp_survival") {
    var0 setclientomnvar("ui_br_altimeter_state", 0);
    play_collected_key_vo(var0, 1);
    return;
  }
}

function ref_14002() {
  var0 = self;
  var1 = var0 getvelocity();
  var2 = clamp(var0.origin[2], 0, level.ref_133f9.ref_1467d) / level.ref_133f9.ref_1467d;
  var3 = level.ref_133f9.ref_1467c + (level.ref_133f9.ref_1467b - level.ref_133f9.ref_1467c) * var2;
  var4 = var1 * (1, 1, 0);
  var5 = length(var4);
  var6 = var4 * var3;
  var7 = var5 * var3;

  if(var7 > level.ref_133f9.ref_1467a) {
    var6 *= level.ref_133f9.ref_1467a / var7;
  }

  var8 = 0;
  var8 -= var0.origin[2] * level.ref_133f9.ref_1468f;
  var8 += level.ref_133f9.zoffset;
  var8 += var1[2] * level.ref_133f9.ref_1472c;
  var8 = clamp(var8, -1 * level.ref_133f9.ref_14690, 0);
  var9 = 1;

  if(var5 < level.ref_133f9.pe_chopper_zones * var1[2]) {
    var9 = 2;
  }

  var0 setadditionalstreampos(var0.origin + (var6[0], var6[1], var8), 0, var9);
}

function playerpowerresetpowers(var0, var1, var2, var3, var4, var5, var6) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("freeFallFromPlaneStateMachine");
  self endon("freeFallFromPlaneStateMachine");
  var7 = self;
  var7.play_disguise_vo = 1;
  var7.play_cinderblock_broken_fx = istrue(var4);
  var7.play_contract_announcer_maybe = 0;
  play_chopper_kill_vo(var7, var0, var1, var2, var3, var5, var6);
  play_death_sound_with_global_cooldown(var7);
  var8 = gettime();

  for(;;) {
    if(var7 isskydiving() || var8 + 2000 < gettime() || usefailextractingmsg(var7)) {
      goto LOC_00000087;
    }

    waitframe();
  }

  for(;;) {
    if(level.ref_133f9.ref_13918 && var7.play_contract_announcer_maybe < gettime()) {
      ref_14002(var7);
      var7.play_contract_announcer_maybe = gettime() + 500;
    }

    if(var7 isinfreefall() && var7.play_disguise_vo != 1) {
      play_death_sound_with_global_cooldown(var7);
      var7.play_disguise_vo = 1;
    }

    if(var7 isparachuting() && var7.play_disguise_vo != 2) {
      play_death_audio(var7);
      var7.play_disguise_vo = 2;
    }

    if(!var7 isskydiving() && var7.play_disguise_vo != 3 && var7.play_disguise_vo != 4 && var7.play_disguise_vo != 6 || var7.play_disguise_vo == 5) {
      play_collected_key_vo(var7);

      if(var7.play_disguise_vo != 5) {
        var7.play_disguise_vo = 3;
      } else {
        var7.play_disguise_vo = 6;
      }
    }

    var9 = istrue(var7.inlaststand);
    var10 = var7 isonground() && (var7.play_disguise_vo == 3 || usefailextractingmsg(var7));
    var11 = var7 isonladder();
    var12 = !scripts\mp\utility\player::isreallyalive(var7);

    if(var9 || var10 || var11 || var12) {
      play_counter_beep_sfx_on_bomb_vests(var7);
      var7.play_disguise_vo = undefined;
      var7.play_cinderblock_broken_fx = undefined;
      var7.play_contract_announcer_maybe = undefined;

      if(var11) {
        var7 skydive_interrupt();
      }

      return;
    }

    waitframe();
  }
}

function play_chopper_kill_vo(var0, var1, var2, var3, var4, var5) {
  self skydive_interrupt();

  if(!istrue(level.parachuteinitfinished)) {
    initparachutedvars();
  }

  if(!isDefined(var0)) {
    var0 = 4;
  }

  if(!isDefined(var4)) {
    var4 = 1;
  }

  if(var4 && level.gametype != "br") {
    self[[level.parachutetakeweaponscb]]();
  }

  self[[level.freefallstartcb]]();

  if(!isDefined(var2)) {
    self notifyonplayercommand("open_parachute", "+gostand");
  }

  self animscriptsetinputparamreplicationstatus(1);

  if(isDefined(var3)) {
    self setvelocity(var3);
  }

  var6 = level.client_activate;

  if(isDefined(var5)) {
    var6 = var5;
  }

  if(!istrue(var6)) {
    self skydive_beginfreefall();
  }

  if(getdvarint("scr_parachute_camera_transition_mode", 1) != 2) {
    self skydive_setforcethirdpersonstatus(1);
  }

  if(level.gametype == "br" && (!istrue(self.play_cinderblock_broken_fx) || getDvar("scr_br_gametype", "") == "dmz") || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
    thread stop_restock_recharge(getdvarint("scr_bmo_parachuteTouchdownVFX", 1) == 1 && (getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war"));
  }

  if(istrue(var1)) {
    thread enablemanualpullchute(0);
  } else {
    thread enablemanualpullchute(var0);
  }

  self[[level.parachuterestoreweaponscb]]();
}

function play_death_sound_with_global_cooldown() {
  if(isparachutegametype()) {
    self setclientomnvar("ui_br_altimeter_state", 1);
    level.audio_player_stop_mud_loop[self getxuid()] = self;
  }

  if(!self.play_cinderblock_broken_fx) {
    var0 = "enabled";

    if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.disabledebugdialogue)) {
      var0 += self.operatorcustomization.disabledebugdialogue;
    }
  }

  if(istrue(level.pilot_linkto_origin_offset)) {
    _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("skydive");
    return;
  }
}

function play_death_audio() {
  self notify("freefall_complete");
  var0 = scripts\cp_mp\utility\script_utility::ref_140de("game", "isGameTypeBR", 0);
  var1 = scripts\cp_mp\utility\script_utility::ref_140de("game", "getSubGameType", "");
  var2 = var1 != "truckwar" && var1 != "reveal" && var1 != "brdov";

  if(var0 && var2 && istrue(self.stickers)) {
    var3 = scripts\cp_mp\utility\script_utility::ref_140de("music", "getRandomMusicSet", "", ["br_infil_jump_parachute"]);
    self setplayermusicstate(var3);
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

function play_collected_key_vo(var0) {
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
    var0 = scripts\cp_mp\utility\script_utility::ref_140de("game", "isGameTypeBR", 0);

    if(var0) {
      wait 5;
      var1 = scripts\cp_mp\utility\script_utility::ref_140de("music", "isBRSuspenseMusicEnabled", 0, [self]);

      if(var1) {
        self.nosuspensemusic = undefined;
        return;
      }

      return;
    }

    return;
  }
}

function ref_121ca() {
  var0 = self;
  var0 skydive_interrupt();

  if(isDefined(var0.parachute)) {
    var0.parachute delete();
    return;
  }
}