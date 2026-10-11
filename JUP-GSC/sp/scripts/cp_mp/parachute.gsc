/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\parachute.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#namespace parachute;

function initparachutedvars() {
  setdvarifuninitialized(@ "scr_parachute_redeploy_min_height", 256);
  setdvarifuninitialized(@ "scr_parachute_redeploy_input_type", 0);
  setdvarifuninitialized(@ "scr_parachute_auto_kick_map_center", (0, 0, 0));
  setdvarifuninitialized(@ "scr_parachute_camera_transition_mode", 2);
  setdvarifuninitialized(@ "scr_parachute_ffsm_enabled", 1);
  setdvarifuninitialized(@ "scr_parachute_hint_enabled", 1);
  setdvarifuninitialized(@ "scr_parachute_hint_zdrop", 0.5);
  setdvarifuninitialized(@ "scr_parachute_hint_zoffset", 0);
  setdvarifuninitialized(@ "scr_parachute_hint_zvelscale", 0);
  setdvarifuninitialized(@ "scr_parachute_hint_zlimit", 5000);
  setdvarifuninitialized(@ "scr_parachute_hint_xyvelscale_high", 10);
  setdvarifuninitialized(@ "scr_parachute_hint_xyvelscale_low", 2);
  setdvarifuninitialized(@ "scr_parachute_hint_xyvelscale_maxheight", 10000);
  setdvarifuninitialized(@ "scr_parachute_hint_xylimit", 7500);
  setdvarifuninitialized(@ "scr_parachute_hint_falling_xyratio", -2);
  level.parachutecancutautodeploy = getdvarint(@ "hash_ff604c5295c4e36c", 1);
  level.parachutecancutparachute = getdvarint(@ "hash_5f25fd4c8fc1a759", 1);
  level.parachuteinitfinished = 1;
  level.activeparachuters = [];

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

  if(!isDefined(level.parachuteprelaststandfunc)) {
    level.parachuteprelaststandfunc = &parachuteprelaststandfunction;
  }

  level.skydivestreamhintdvars = spawnStruct();
  level.skydivestreamhintdvars.streamhintenabled = getdvarint(@ "scr_parachute_hint_enabled", 1);
  level.skydivestreamhintdvars.xyvelscale_high = getdvarfloat(@ "scr_parachute_hint_xyvelscale_high", 0);
  level.skydivestreamhintdvars.xyvelscale_low = getdvarfloat(@ "scr_parachute_hint_xyvelscale_low", 0);
  level.skydivestreamhintdvars.xyvelscale_maxheight = getdvarfloat(@ "scr_parachute_hint_xyvelscale_maxheight", 0);
  level.skydivestreamhintdvars.xylimit = getdvarfloat(@ "scr_parachute_hint_xylimit", 0);
  level.skydivestreamhintdvars.zdrop = getdvarfloat(@ "scr_parachute_hint_zdrop", 0);
  level.skydivestreamhintdvars.zoffset = getdvarfloat(@ "scr_parachute_hint_zoffset", 0);
  level.skydivestreamhintdvars.zvelscale = getdvarfloat(@ "scr_parachute_hint_zvelscale", 0);
  level.skydivestreamhintdvars.zlimit = getdvarfloat(@ "scr_parachute_hint_zlimit", 0);
  level.skydivestreamhintdvars.falling_xyratio = getdvarfloat(@ "scr_parachute_hint_falling_xyratio", 0);
}

function startfreefall(falltime, popinstant, var_32dcb143b4eb723a, startingvelocity, isgulagrespawn, takeweapons) {
  self.haslanded = 0;

  if(getdvarint(@ "scr_parachute_ffsm_enabled", 0)) {
    thread freefallfromplanestatemachine(falltime, popinstant, var_32dcb143b4eb723a, startingvelocity, isgulagrespawn, takeweapons);
    return;
  }

  self endon("death_or_disconnect");
  thread parachutemidairdeathwatcher();
  self skydive_interrupt();

  if(getdvarint(@ "hash_efd5d9204cedd02", 0) == 1) {
    thread function_3c9c50a97447b483();
  }

  if(!isDefined(takeweapons)) {
    takeweapons = 1;
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

  if(!isDefined(falltime)) {
    falltime = 4;
  }

  if(takeweapons) {
    self[[level.parachutetakeweaponscb]]();
  }

  self[[level.freefallstartcb]]();

  if(isparachutegametype()) {
    self setclientomnvar("ui_br_altimeter_state", 1);
  }

  if(!isDefined(var_32dcb143b4eb723a)) {
    self notifyonplayercommand("open_parachute", "+gostand");
  }

  self animscriptsetinputparamreplicationstatus(1);

  if(isDefined(startingvelocity)) {
    self setvelocity(startingvelocity);
  }

  self skydive_beginfreefall();

  if(getdvarint(@ "scr_parachute_camera_transition_mode", 1) != 2) {
    self skydive_setforcethirdpersonstatus(1);
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && (!istrue(isgulagrespawn) || getDvar(@ "hash_7611a2790a0bf7fe", "") == "dmz" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "exgm" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "plunder" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "risk" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "resurgence") && getdvarint(@ "hash_b99e3b3c6154ced8", 1)) {
    thread infilparachutevfx(getdvarint(@ "hash_96e4167dd77b8cee", 1) == 1 && (getDvar(@ "hash_7611a2790a0bf7fe", "") == "dmz" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "exgm" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "plunder" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "risk" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "resurgence"));
  }

  if(!istrue(popinstant)) {
    wait falltime;
  }

  thread pullchute(var_32dcb143b4eb723a, popinstant);
}

function infilparachutevfx(endonground) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player = self;
  wait 1;

  if(scripts\engine\utility::issharedfuncdefined("hud", "ftue_triggerTip")) {
    player[[scripts\engine\utility::getsharedfunc("hud", "ftue_triggerTip")]]("br_ftue_parachute");
  }

  targetstate = "enabled";

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.brinfilsmokesuffix)) {
    targetstate += self.operatorcustomization.brinfilsmokesuffix;
  }

  player setscriptablepartstate("skydiveVfx", targetstate, 0);
  player setisinfilskydive(1);
  wait 2;

  while(isalive(player) && !player shoulddisableskydivevfx()) {
    wait 0.25;
  }

  if(endonground) {
    while(isalive(player)) {
      var_aa4f5ea34dfe428b = istrue(player.inlaststand);
      bisland = player isonground() || player isswimming() || player ishanging();
      var_a2b5f51a86d266ad = player isonladder();
      bisdead = !scripts\cp_mp\utility\player_utility::isreallyalive(player);
      binvehicle = player isvehicleactive();
      var_15d3f6cdd6f19d4d = player isonascender();

      if(var_aa4f5ea34dfe428b || bisland || var_a2b5f51a86d266ad || bisdead || binvehicle || var_15d3f6cdd6f19d4d) {
        break;
      }

      wait 0.25;
    }
  }

  player setscriptablepartstate("skydiveVfx", "default", 0);
  player setisinfilskydive(0);
}

function riotshield_attach_parachute(onarm, modelshield) {
  tagattach = undefined;

  if(onarm) {
    assertex(!isDefined(self.riotshieldmodel), "riotShield_attach_parachute() called on player with no riot shield model on the arm");
    self.riotshieldmodel = modelshield;
    tagattach = "tag_weapon_right";
  } else {
    assertex(!isDefined(self.riotshieldmodelstowed), "riotShield_attach_parachute() called on player with no riot shield model stowed");
    self.riotshieldmodelstowed = modelshield;
    tagattach = "tag_shield_back";
  }

  self attachshieldmodel(modelshield, tagattach);
  self.hasriotshield = riotshield_hasweapon_parachute();
}

function riotshield_getmodel_parachute() {
  return "weapon_wm_riotshield";
}

function riotshield_hasweapon_parachute() {
  result = 0;
  weaponlist = self getweaponslistprimaries();

  foreach(weapon in weaponlist) {
    if(isriotshield_parachute(weapon)) {
      result = 1;
      break;
    }
  }

  return result;
}

function isriotshield_parachute(weapon) {
  if(isweapon(weapon) && isnullweapon(weapon)) {
    return false;
  }

  if(isstring(weapon) && weapon == "none") {
    return false;
  }

  return weapontype(weapon) == "riotshield";
}

function isparachutegametype() {
  return isDefined(level.gametype) && (scripts\cp_mp\utility\game_utility::isbrstylegametype() || level.gametype == "arm" || level.gametype == "bigctf" || level.gametype == "conflict" || level.gametype == "risk" || level.gametype == "war" || level.gametype == "war_mgl" || level.gametype == "war_mgl" || level.gametype == "missions" || level.gametype == "trial" || level.gametype == "brtdm" || level.gametype == "brtdm_mgl" || level.gametype == "wm");
}

function getc130height() {
  if(isDefined(level.br_level) && isDefined(level.br_level.c130_heightoverride)) {
    return level.br_level.c130_heightoverride;
  }

  return 24000;
}

function getc130airdropheight() {
  if(isDefined(level.c130airdrop_heightoverride)) {
    return level.c130airdrop_heightoverride;
  }

  return 24000;
}

function getc130sealevel() {
  if(isDefined(level.br_level) && isDefined(level.br_level.c130_sealeveloverride)) {
    return level.br_level.c130_sealeveloverride;
  }

  return 650;
}

function steerfalling(var_d051bb0593db1e4) {
  controlentity = spawn("script_model", self.origin);
  controlentity.angles = self.angles;
  controlentity setModel("viewhands_base_iw8");
  controlentity hide();
  self playerlinktodelta(controlentity, "tag_player");
  steerfallinginternal(controlentity, var_d051bb0593db1e4);
  controlentity delete();
}

function steerfallinginternal(controlentity, var_d051bb0593db1e4) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("freefall_complete");
  self endon("parachute_complete");
  self notify("steerFalling()");
  self endon("steerFalling()");
  gravscale = 13.8;
  airdrag = 0.0001;
  var_817beab23f026d04 = -1350;
  var_393260f42c7893cb = 1400;
  var_fa4dfac825a92d66 = 1600;
  var_b16089157712c28d = -100;

  if(level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "risk" || level.gametype == "bigctf") {
    var_817beab23f026d04 = -1750;
    var_393260f42c7893cb = 400;
    var_fa4dfac825a92d66 = 400;
  }

  if(isDefined(var_d051bb0593db1e4)) {
    var_393260f42c7893cb *= var_d051bb0593db1e4;
    var_fa4dfac825a92d66 *= var_d051bb0593db1e4;
  }

  airresistance = level.framedurationseconds * airdrag;
  controlentity.vel = (0, 0, var_b16089157712c28d);
  waitframe();
  gamegravity = getdvarint(@ "bg_gravity");
  horizontalvel = (0, 0, 0);

  while(true) {
    movementinput = self getnormalizedmovement();
    var_58724d69ca657b30 = movementinput[0];
    var_58724e69ca657d63 = movementinput[1];
    playerangles = self getplayerangles(1);
    axisy = anglesToForward(playerangles) * var_58724d69ca657b30;
    axisx = anglestoright(playerangles) * var_58724e69ca657d63;
    inputvector = axisx + axisy;
    targetvel = vectorNormalize(inputvector) * var_fa4dfac825a92d66;
    horizontalvel += vectorNormalize(targetvel - horizontalvel) * level.framedurationseconds * var_393260f42c7893cb;
    horizontalvel -= horizontalvel * length(horizontalvel) * airresistance;
    downspeed = controlentity.vel[2] - gravscale * 39.37 * level.framedurationseconds;
    downspeed = max(var_817beab23f026d04, downspeed);
    downvel = (0, 0, downspeed);
    controlentity.vel = downvel + horizontalvel;
    controlentity.origin += level.framedurationseconds * controlentity.vel;
    speed2d = sqrt(controlentity.vel[0] * controlentity.vel[0] + controlentity.vel[1] * controlentity.vel[1]);
    vspeed = veltomph(controlentity.vel[2] * -1);
    hspeed = veltomph(speed2d);
    altitudepct = min(1, (self.origin[2] - getc130sealevel()) / (getc130height() - getc130sealevel()));

    if(isparachutegametype()) {
      self setclientomnvar("ui_br_altimeter_height", altitudepct);
      self setclientomnvar("ui_br_altimeter_vertical_speed", int(vspeed));
      self setclientomnvar("ui_br_altimeter_horizontal_speed", int(hspeed));
    }

    waitframe();
  }
}

function veltomph(v) {
  mph = v * 0.05682;
  return mph;
}

function steerparachuting(var_d051bb0593db1e4) {
  controlentity = spawn("script_model", self.origin);
  controlentity.angles = self.angles;
  controlentity setModel("viewhands_base_iw8");
  controlentity hide();
  self playerlinktodelta(controlentity, "tag_player");
  steerparachutinginternal(controlentity, var_d051bb0593db1e4);
  controlentity delete();
}

function steerparachutinginternal(controlentity, var_d051bb0593db1e4) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("freefall_complete");
  self endon("parachute_landed");
  self notify("steerFalling()");
  self endon("steerFalling()");
  var_998fd4b607b8174e = 100;
  var_d86bcc969a419e41 = -200;
  var_d866fe3ebb06e803 = 600;
  forwardaccel = 240;
  var_388b5f929fee9772 = 120;
  var_b02d7a2abe83a9ef = 60;
  var_6ad7cb3f09b4c201 = 48;
  maxpitch = 35;
  maxstrafe = 700;
  var_92517cd227297246 = 100;
  var_290f01f649f1e57e = 600;
  strafedecay = 300;
  var_2afa890495dced11 = 100;
  var_9d628820b95f3bed = -150;

  if(level.gametype == "arm" || level.gametype == "bigctf" || level.gametype == "conflict" || level.gametype == "risk") {
    var_9d628820b95f3bed = -200;
  }

  if(isDefined(var_d051bb0593db1e4)) {
    var_998fd4b607b8174e *= var_d051bb0593db1e4;
    var_d86bcc969a419e41 *= var_d051bb0593db1e4;
    var_d866fe3ebb06e803 *= var_d051bb0593db1e4;
    forwardaccel *= var_d051bb0593db1e4;
    var_388b5f929fee9772 *= var_d051bb0593db1e4;
    var_b02d7a2abe83a9ef *= var_d051bb0593db1e4;
    maxstrafe *= var_d051bb0593db1e4;
    var_290f01f649f1e57e *= var_d051bb0593db1e4;
    strafedecay *= var_d051bb0593db1e4;
    var_2afa890495dced11 *= var_d051bb0593db1e4;
  }

  var_d7bd29ab98f4f1a2 = 100;
  var_648b9956418a7253 = 0;
  strafespeed = 0;
  controlentity.vel = (0, 0, 0);

  while(true) {
    movementinput = self getnormalizedmovement();
    var_58724d69ca657b30 = movementinput[0];
    var_58724e69ca657d63 = movementinput[1];
    playerangles = self getplayerangles(1);
    playerforward = anglesToForward(playerangles);
    playerright = anglestoright(playerangles);
    var_65678a4c23282859 = ter_op(var_58724d69ca657b30 > 0, forwardaccel, var_388b5f929fee9772);
    var_d7bd29ab98f4f1a2 += var_58724d69ca657b30 * var_65678a4c23282859 * level.framedurationseconds;
    var_d7bd29ab98f4f1a2 += var_b02d7a2abe83a9ef * level.framedurationseconds * sign(var_998fd4b607b8174e - var_d7bd29ab98f4f1a2);
    var_d7bd29ab98f4f1a2 = clamp(var_d7bd29ab98f4f1a2, var_d86bcc969a419e41, var_d866fe3ebb06e803);
    var_82bc834ceac5a4d4 = -1 * var_58724d69ca657b30 * maxpitch;
    var_648b9956418a7253 += sign(var_82bc834ceac5a4d4 - var_648b9956418a7253) * var_6ad7cb3f09b4c201 * level.framedurationseconds;
    var_7677f3eb70b218e0 = rotatepointaroundvector(playerright, playerforward, var_648b9956418a7253);
    var_54e4eab74afe520a = var_d7bd29ab98f4f1a2 * var_7677f3eb70b218e0;
    var_3b93dfd1e0dd8d07 = playerforward * var_2afa890495dced11 + (0, 0, var_9d628820b95f3bed);
    strafespeed += var_290f01f649f1e57e * level.framedurationseconds * var_58724e69ca657d63;
    strafespeed -= strafedecay * level.framedurationseconds * sign(strafespeed);
    strafespeed = clamp(strafespeed, -1 * maxstrafe, maxstrafe);
    strafevel = strafespeed * playerright;
    strafedown = var_92517cd227297246 * abs(var_58724e69ca657d63);
    strafevel += (0, 0, -1 * strafedown);
    controlentity.vel = var_54e4eab74afe520a + strafevel + var_3b93dfd1e0dd8d07;
    controlentity.origin += controlentity.vel * level.framedurationseconds;
    speed2d = sqrt(controlentity.vel[0] * controlentity.vel[0] + controlentity.vel[1] * controlentity.vel[1]);
    vspeed = max(0, veltomph(controlentity.vel[2] * -1));
    hspeed = max(0, veltomph(speed2d));
    altitudepct = min(1, (self.origin[2] - getc130sealevel()) / (getc130height() - getc130sealevel()));

    if(isparachutegametype()) {
      self setclientomnvar("ui_br_altimeter_height", altitudepct);
      self setclientomnvar("ui_br_altimeter_vertical_speed", int(vspeed));
      self setclientomnvar("ui_br_altimeter_horizontal_speed", int(hspeed));
    }

    waitframe();
  }
}

function isskydivestatedisabled() {
  return isDefined(self.ffsm_state) && (self.ffsm_state == 5 || self.ffsm_state == 6);
}

function enablemanualpullchute(waitsec) {
  self endon("death_or_disconnect");

  if(isDefined(waitsec) && waitsec > 0) {
    self skydive_setdeploymentstatus(0);
    self skydive_setbasejumpingstatus(0);
    wait waitsec;
  }

  if(isDefined(self)) {
    if(isskydivestatedisabled()) {
      return;
    }

    self skydive_setdeploymentstatus(1);
    self skydive_setbasejumpingstatus(1);
  }
}

function pullchute(var_32dcb143b4eb723a, popinstant, autoopen) {
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

function parachutedamagemonitor(parachute) {
  self endon("death_or_disconnect");
  self endon("parachute_complete");
  parachute endon("death");
  parachute setCanDamage(1);
  damage = undefined;
  attacker = undefined;
  direction_vec = undefined;
  meansofdeath = undefined;
  modelname = undefined;
  tagname = undefined;
  partname = undefined;
  idflags = undefined;
  objweapon = undefined;
  origin = undefined;
  angles = undefined;
  normal = undefined;
  inflictor = undefined;
  parachute.shotstaken = 0;

  while(true) {
    parachute waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(isDefined(meansofdeath)) {
      if(isbulletdamage(meansofdeath)) {
        parachute.shotstaken++;
      }
    }
  }
}

function startparachute() {
  self endon("death_or_disconnect");

  if(getdvarint(@ "scr_parachute_camera_transition_mode", 1) == 1) {
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
    if(isDefined(level.onfirstlandcallback)) {
      self[[level.onfirstlandcallback]](self);
    }
  }
}

function parachutemidairdeathwatcher() {
  self endon("parachute_complete");
  self waittill("death");

  if(isparachutegametype()) {
    self setclientomnvar("ui_br_altimeter_state", 0);
  }
}

function freefallstartdefault() {
  self disableusability();
}

function parachuteopendefault() {}

function parachutecompletedefault() {
  self enableusability();

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

  gunless = makeweapon("iw9_me_fists_mp");
  weapnone = makeweapon("none");
  self.weaponlist = self.primaryweapons;
  self clearaccessory();

  if(!self hasweapon(gunless)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  }

  for(i = 0; i < self.weaponlist.size; i++) {
    weapon = self.weaponlist[i];

    if(isDefined(weapon) && !issameweapon(gunless, weapon) && !issameweapon(weapnone, weapon)) {
      self takeweapon(weapon);
    }
  }

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 1);
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
  }
}

function playerwatchforredeploy() {
  level endon("game_ended");
  self endon("disconnect");

  if(utility::iscp()) {
    self endon("death");
  }

  var_1f32658706c07dc8 = getdvarfloat(@ "scr_parachute_redeploy_min_height", 256);
  var_3c2ee4bed7df269d = 0;
  self.redeployenabled = 1;

  while(true) {
    if(istrue(self.redeployenabled) && !self isonground() && scripts\cp_mp\utility\player_utility::_isalive() && !self isskydiving() && !self islinked() && !istrue(self.carrying)) {
      inputvalid = 0;

      switch (getdvarint(@ "scr_parachute_redeploy_input_type", 0)) {
        case 0:
          if(var_3c2ee4bed7df269d == 0 && self jumpbuttonPressed()) {
            inputvalid = 1;
          }

          break;
        case 1:
          if(self jumpbuttonPressed() && var_3c2ee4bed7df269d + 500 < gettime()) {
            inputvalid = 1;
          }

          break;
        case 2:
          if(!isDefined(self.doublejumpdetected)) {
            thread watchfordoublejump();
          }

          if(istrue(self.doublejumpdetected)) {
            inputvalid = 1;
          }

          break;
        default:
          break;
      }

      if(inputvalid) {
        gpos = utility::groundpos(self.origin);
        var_c14047c4299f9c74 = self.origin[2] - gpos[2];

        var_1f32658706c07dc8 = getdvarfloat(@ "scr_parachute_redeploy_min_height", 256);

        if(var_c14047c4299f9c74 > var_1f32658706c07dc8) {
          self notify("skydive_deployparachute");
          self skydive_deployparachute();
        }
      }
    }

    if(isDefined(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
      if(!self jumpbuttonPressed()) {
        var_3c2ee4bed7df269d = 0;
      } else if(var_3c2ee4bed7df269d == 0) {
        var_3c2ee4bed7df269d = gettime();
      }
    } else {
      var_3c2ee4bed7df269d = 0;
    }

    waitframe();
  }
}

function watchfordoublejump() {
  level endon("game_ended");
  self endon("disconnect");
  self.doublejumpdetected = 0;

  while(true) {
    if(self jumpbuttonPressed()) {
      presstime = gettime();
      releasetime = 0;
      waitframe();

      while(true) {
        if(!self jumpbuttonPressed()) {
          if(gettime() < presstime + 500 && !self isonground()) {
            releasetime = gettime();
          }

          break;
        }

        if(gettime() > presstime + 500) {
          break;
        }

        waitframe();
      }

      if(releasetime == 0) {
        continue;
      }

      waitframe();

      while(true) {
        if(self jumpbuttonPressed()) {
          if(gettime() < releasetime + 500 && !self isonground()) {
            self.doublejumpdetected = 1;
            waitframe();
            self.doublejumpdetected = 0;
          }

          break;
        }

        if(gettime() > releasetime + 500) {
          break;
        }

        waitframe();
      }
    }

    waitframe();
  }
}

function function_3c9c50a97447b483() {
  self endon("<dev string:x1c>");
  self endon("<dev string:x30>");

  while(true) {
    thread drawangles(self.origin, self.angles, 0.05, 5);
    velocity = self getvelocity();
    mag = length(velocity);
    thread drawline(self.origin, self.origin + vectorNormalize(velocity) * mag, 0.05, (1, 0, 1));
    printtoscreen2d(750, 800, "<dev string:x43>" + vectorNormalize(velocity), (1, 0, 1), 2);
    printtoscreen2d(750, 825, "<dev string:x4e>" + mag, (1, 0, 1), 2);
    waitframe();
  }
}

function parachuteprelaststandfunction() {
  player = self;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(isDefined(player.ffsm_state) && (player.ffsm_state == 1 || player.ffsm_state == 2)) {
      player scripts\cp_mp\parachute::ffsm_landed_stateenter();
      player.ffsm_state = 3;
    }

    return;
  }

  if(utility::iscp()) {
    player setclientomnvar("ui_br_altimeter_state", 0);
    player scripts\cp_mp\parachute::ffsm_landed_stateenter(1);
  }
}

function updateparachutestreamhint() {
  player = self;
  velocity = player getvelocity();
  var_eac21b0ad618df9d = clamp(player.origin[2], 0, level.skydivestreamhintdvars.xyvelscale_maxheight) / level.skydivestreamhintdvars.xyvelscale_maxheight;
  xyvelscale = level.skydivestreamhintdvars.xyvelscale_low + (level.skydivestreamhintdvars.xyvelscale_high - level.skydivestreamhintdvars.xyvelscale_low) * var_eac21b0ad618df9d;
  xyvel = velocity * (1, 1, 0);
  var_9854dc90ee9da402 = length(xyvel);
  var_cbc44aa5555239a3 = xyvel * xyvelscale;
  var_22133650825cd26b = var_9854dc90ee9da402 * xyvelscale;

  if(var_22133650825cd26b > level.skydivestreamhintdvars.xylimit) {
    var_cbc44aa5555239a3 *= level.skydivestreamhintdvars.xylimit / var_22133650825cd26b;
  }

  zhint = 0;
  zhint -= player.origin[2] * level.skydivestreamhintdvars.zdrop;
  zhint += level.skydivestreamhintdvars.zoffset;
  zhint += velocity[2] * level.skydivestreamhintdvars.zvelscale;
  zhint = clamp(zhint, -1 * level.skydivestreamhintdvars.zlimit, 0);
  viewmode = 1;

  if(var_9854dc90ee9da402 < level.skydivestreamhintdvars.falling_xyratio * velocity[2]) {
    viewmode = 2;
  }

  player setadditionalstreamposuntilcleared(player.origin + (var_cbc44aa5555239a3[0], var_cbc44aa5555239a3[1], zhint), viewmode);
}

function freefallfromplanestatemachine(falltime, popinstant, var_32dcb143b4eb723a, startingvelocity, isgulagrespawn, takeweapons) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("freeFallFromPlaneStateMachine");
  self endon("freeFallFromPlaneStateMachine");
  player = self;
  player.ffsm_state = 1;
  player.ffsm_isgulagrespawn = istrue(isgulagrespawn);
  player.ffsm_nextstreamhinttime = 0;
  player ffsm_introsetup(falltime, popinstant, var_32dcb143b4eb723a, startingvelocity, takeweapons);
  player ffsm_skydive_stateenter();
  starttime = gettime();

  while(true) {
    if(player isskydiving() || starttime + 2000 < gettime() || player isskydivestatedisabled()) {
      break;
    }

    waitframe();
  }

  while(true) {
    if(level.skydivestreamhintdvars.streamhintenabled && player.ffsm_nextstreamhinttime < gettime()) {
      player updateparachutestreamhint();
      player.ffsm_nextstreamhinttime = gettime() + 500;
    }

    if(player isinfreefall() && player.ffsm_state != 1) {
      player ffsm_skydive_stateenter();
      player.ffsm_state = 1;
    }

    if(player isparachuting() && player.ffsm_state != 2) {
      player ffsm_parachuteopen_stateenter();
      player.ffsm_state = 2;
    }

    if(!player isskydiving() && player.ffsm_state != 3 && player.ffsm_state != 4 && player.ffsm_state != 6 || player.ffsm_state == 5) {
      player ffsm_landed_stateenter();

      if(player.ffsm_state != 5) {
        player.ffsm_state = 3;
      } else {
        assert(player.ffsm_state == 5);
        player.ffsm_state = 6;
      }
    }

    var_aa4f5ea34dfe428b = istrue(player.inlaststand);
    bisland = (player isonground() || player isswimming() || player ishanging()) && (player.ffsm_state == 3 || player isskydivestatedisabled());
    var_a2b5f51a86d266ad = player isonladder();
    bisdead = !scripts\cp_mp\utility\player_utility::isreallyalive(player);
    binvehicle = player isvehicleactive();
    var_15d3f6cdd6f19d4d = player isonascender();

    if(var_aa4f5ea34dfe428b || bisland || var_a2b5f51a86d266ad || bisdead || binvehicle || var_15d3f6cdd6f19d4d) {
      if(scripts\engine\utility::issharedfuncdefined("hud", "ftue_trigger_landed_hint")) {
        player[[scripts\engine\utility::getsharedfunc("hud", "ftue_trigger_landed_hint")]]();
      }

      player ffsm_onground_stateenter();
      player.ffsm_state = undefined;
      player.ffsm_isgulagrespawn = undefined;
      player.ffsm_nextstreamhinttime = undefined;

      if(var_a2b5f51a86d266ad) {
        player skydive_interrupt();
      }

      return;
    }

    waitframe();
  }
}

function ffsm_introsetup(falltime, popinstant, var_32dcb143b4eb723a, startingvelocity, takeweapons) {
  if(getdvarint(@ "hash_efd5d9204cedd02", 0) == 1) {
    thread function_3c9c50a97447b483();
  }

  self skydive_interrupt();

  if(!istrue(level.parachuteinitfinished)) {
    initparachutedvars();
  }

  if(!isDefined(falltime)) {
    falltime = 4;
  }

  if(!isDefined(takeweapons)) {
    takeweapons = 1;
  }

  if(takeweapons && !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self[[level.parachutetakeweaponscb]]();
  }

  self[[level.freefallstartcb]]();

  if(!isDefined(var_32dcb143b4eb723a)) {
    self notifyonplayercommand("open_parachute", "+gostand");
  }

  self animscriptsetinputparamreplicationstatus(1);

  if(isDefined(startingvelocity)) {
    self setvelocity(startingvelocity);
  }

  self skydive_beginfreefall();

  if(getdvarint(@ "scr_parachute_camera_transition_mode", 1) != 2) {
    self skydive_setforcethirdpersonstatus(1);
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && (!istrue(self.ffsm_isgulagrespawn) || getDvar(@ "hash_7611a2790a0bf7fe", "") == "dmz" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "exgm") || getDvar(@ "hash_7611a2790a0bf7fe", "") == "plunder" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "risk" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "resurgence") {
    thread infilparachutevfx(getdvarint(@ "hash_96e4167dd77b8cee", 1) == 1 && (getDvar(@ "hash_7611a2790a0bf7fe", "") == "dmz" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "exgm" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "plunder" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "risk" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "resurgence"));
  }

  if(istrue(popinstant)) {
    thread enablemanualpullchute(0);
  } else {
    thread enablemanualpullchute(falltime);
  }

  self[[level.parachuterestoreweaponscb]]();
}

function ffsm_skydive_stateenter() {
  if(isparachutegametype()) {
    self setclientomnvar("ui_br_altimeter_state", 1);
    level.activeparachuters[self getxuid()] = self;
  }

  if(!self.ffsm_isgulagrespawn) {
    targetstate = "enabled";

    if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.brinfilsmokesuffix)) {
      targetstate += self.operatorcustomization.brinfilsmokesuffix;
    }
  }
}

function ffsm_parachuteopen_stateenter() {
  self notify("freefall_complete");

  if(isDefined(self.jump_music) && self.jump_music == 1) {
    br_plane_jump_parachute = function_17ee301cf0b5ba85("br_plane_jump_parachute");
    self setplayermusicstate(br_plane_jump_parachute);
    self.jump_music = 0;
  }

  level.activeparachuters[self getxuid()] = self;

  if(isparachutegametype()) {
    self setclientomnvar("ui_br_altimeter_state", 2);
  }

  if(!istrue(level.dontshootwhileparachuting)) {
    self[[level.parachuteopencb]]();
  }
}

function ffsm_landed_stateenter(var_83e33c8931d52d73) {
  self.ignorefalldamagetime = gettime() + 5000;

  if(istrue(self.delayswaploadout)) {
    self.delayswaploadout = 0;
  }

  if(istrue(level.dontshootwhileparachuting)) {
    self[[level.parachutecompletecb]]();
  }

  self notify("parachute_landed");
  self skydive_setforcethirdpersonstatus(0);

  if(!isskydivestatedisabled()) {
    self skydive_setbasejumpingstatus(1);
  }

  if(istrue(self.restoreriotshieldonland)) {
    riotshield_attach_parachute(self.restoreriotshieldonland == 1, riotshield_getmodel_parachute());
    self.restoreriotshieldonland = undefined;
  }

  level.activeparachuters[self getxuid()] = undefined;
  self notify("parachute_complete");
  self animscriptsetinputparamreplicationstatus(0);
}

function ffsm_onground_stateenter() {
  self.haslanded = 1;

  if(level.skydivestreamhintdvars.streamhintenabled) {
    self clearadditionalstreampos();
  }

  if(isparachutegametype()) {
    level.activeparachuters[self getxuid()] = undefined;
    self setclientomnvar("ui_br_altimeter_state", 0);
    thread playlandingbreath();

    if(isDefined(level.onfirstlandcallback)) {
      self[[level.onfirstlandcallback]](self);
    }
  }
}

function playlandingbreath() {
  self endon("death_or_disconnect");
  wait 0.3;

  if(issharedfuncdefined("player", "isReallyAlive")) {
    if([[scripts\engine\utility::getsharedfunc("player", "isReallyAlive")]](self)) {
      self playlocalsound("plr_breath_land_parachute", self);
      self playsoundonmovingent("breath_land_parachute_npc");
    }
  }
}

function parachutecleanup() {
  player = self;
  player skydive_interrupt();

  if(isDefined(player.parachute)) {
    player.parachute delete();
  }
}