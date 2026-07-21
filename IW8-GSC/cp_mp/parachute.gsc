/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\parachute.gsc
***********************************************/

initparachutedvars() {
  setdvarifuninitialized("_encstr_87C122E636C9FAE00B9C851BD0BAD195D727AC23CA1C8DDEF2FAB55A9BBEA1ACD2760D8E", 256);
  setdvarifuninitialized("_encstr_95AB22DCD8C9BE0E0B27C28D0DAB8EB2FA9395325907C67BE57DA57338ABD1EBD12F1CCA", 0);
  setdvarifuninitialized("_encstr_B43D23C271884713BFED8777215D9BB53999FB8B68890BDA86F777471B8751EB40803357A3", (0, 0, 0));
  setdvarifuninitialized("_encstr_9BD5250BBFE8A94337C382AAA8156B9F2927916DDBB06E37653B9A42D3632354509537E577E8B7", 2);
  setdvarifuninitialized("_encstr_868B1BB8AF52F6F90292B74EECBB097997A39901BF27C98D2ABE3945C7", 1);
  setdvarifuninitialized("_encstr_879C1B12A15897C30F5D3727712DCBE589680CDDBBD9751A57150B3741", 1);
  setdvarifuninitialized("_encstr_AB4019F34710514B3FDB8A92A00D139721399166F1D1A0C35E9093", 0.5);
  setdvarifuninitialized("_encstr_95791B339F73691B30DAE779A3035BEF8190E268B0B75260D7436B490B", 0.0);
  setdvarifuninitialized("_encstr_8B861DAB1815CFC38E83E91B5B5B3BC5104983C34BFFBAE558437E6F2ACC4A", 0.0);
  setdvarifuninitialized("_encstr_8E441ACD6CE4D7382C27853686AB1DCAFA1AD29B8EF53DB1D2DAB447", 5000.0);
  setdvarifuninitialized("_encstr_B29823D8CF32D6D922B297AE0C5BE959B77B80C87BC78A833B1F19AE26F21101CFD31808B3", 10.0);
  setdvarifuninitialized("_encstr_BD112262D128E7B31F4D2717413D3B1599581CADABE9787BEC0B1B5FBFEF824DF1601573", 2.0);
  setdvarifuninitialized("_encstr_8E99289B2F78393347B3123A18A5FB6FB981091E6969B85FF4493A2341F7D3276163B980C910041F9343", 10000.0);
  setdvarifuninitialized("_encstr_93DB1B373627AF38C24E588DD0EA3A95F50D4B731DFAC32F8DA5B54B47", 7500.0);
  setdvarifuninitialized("_encstr_B62F23DF4E7A3E309F3A5F93C343F0EF615B34F20D37F7573BA0B192C8E1206BD54F2B0BEF", -2.0);
  level._id_121C8 = getdvarint("_encstr_92F11DCD8DE4EBC10B9385B143AB1DB2AF0BAB8EF646560EC6BD97EBB1AB8E", 1);
  level._id_121C9 = getdvarint("_encstr_8C28126B31661F7A609519E35938833F18A983A3", 1);
  level.parachuteinitfinished = 1;
  level.audio_player_stop_mud_loop = [];

  if(!isDefined(level.dontshootwhileparachuting))
    level.dontshootwhileparachuting = 1;

  if(!isDefined(level.freefallstartcb))
    level.freefallstartcb = ::freefallstartdefault;

  if(!isDefined(level.parachuteopencb))
    level.parachuteopencb = ::parachuteopendefault;

  if(!isDefined(level.parachutecompletecb))
    level.parachutecompletecb = ::parachutecompletedefault;

  if(!isDefined(level.parachutetakeweaponscb))
    level.parachutetakeweaponscb = ::leaveweaponsdefaultfunc;

  if(!isDefined(level.parachuterestoreweaponscb))
    level.parachuterestoreweaponscb = ::norestoreweaponsdefaultfunc;

  if(!isDefined(level._id_121D1))
    level._id_121D1 = ::_id_121D2;

  level._id_133F9 = spawnStruct();
  level._id_133F9._id_13918 = getdvarint("_encstr_879C1B12A15897C30F5D3727712DCBE589680CDDBBD9751A57150B3741", 1);
  level._id_133F9._id_1467B = getdvarfloat("_encstr_B29823D8CF32D6D922B297AE0C5BE959B77B80C87BC78A833B1F19AE26F21101CFD31808B3", 0.0);
  level._id_133F9._id_1467C = getdvarfloat("_encstr_BD112262D128E7B31F4D2717413D3B1599581CADABE9787BEC0B1B5FBFEF824DF1601573", 0.0);
  level._id_133F9._id_1467D = getdvarfloat("_encstr_8E99289B2F78393347B3123A18A5FB6FB981091E6969B85FF4493A2341F7D3276163B980C910041F9343", 0.0);
  level._id_133F9._id_1467A = getdvarfloat("_encstr_93DB1B373627AF38C24E588DD0EA3A95F50D4B731DFAC32F8DA5B54B47", 0.0);
  level._id_133F9._id_1468F = getdvarfloat("_encstr_AB4019F34710514B3FDB8A92A00D139721399166F1D1A0C35E9093", 0.0);
  level._id_133F9.zoffset = getdvarfloat("_encstr_95791B339F73691B30DAE779A3035BEF8190E268B0B75260D7436B490B", 0.0);
  level._id_133F9._id_1472C = getdvarfloat("_encstr_8B861DAB1815CFC38E83E91B5B5B3BC5104983C34BFFBAE558437E6F2ACC4A", 0.0);
  level._id_133F9._id_14690 = getdvarfloat("_encstr_8E441ACD6CE4D7382C27853686AB1DCAFA1AD29B8EF53DB1D2DAB447", 0.0);
  level._id_133F9.pe_chopper_zones = getdvarfloat("_encstr_B62F23DF4E7A3E309F3A5F93C343F0EF615B34F20D37F7573BA0B192C8E1206BD54F2B0BEF", 0.0);
}

startfreefall(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(getdvarint("_encstr_868B1BB8AF52F6F90292B74EECBB097997A39901BF27C98D2ABE3945C7", 0)) {
    thread playerpowerresetpowers(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    return;
  }

  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  thread parachutemidairdeathwatcher();
  self skydive_interrupt();

  if(!isDefined(var_5))
    var_5 = 1;

  if(!istrue(level.parachuteinitfinished))
    initparachutedvars();

  if(!isDefined(level.dontshootwhileparachuting))
    level.dontshootwhileparachuting = 1;

  if(!isDefined(level.freefallstartcb))
    level.freefallstartcb = ::freefallstartdefault;

  if(!isDefined(level.parachuteopencb))
    level.parachuteopencb = ::parachuteopendefault;

  if(!isDefined(level.parachutecompletecb))
    level.parachutecompletecb = ::parachutecompletedefault;

  if(!isDefined(level.parachutetakeweaponscb))
    level.parachutetakeweaponscb = ::leaveweaponsdefaultfunc;

  if(!isDefined(level.parachuterestoreweaponscb))
    level.parachuterestoreweaponscb = ::norestoreweaponsdefaultfunc;

  if(!isDefined(var_0))
    var_0 = 4.0;

  if(var_5)
    self[[level.parachutetakeweaponscb]]();

  self[[level.freefallstartcb]]();

  if(isparachutegametype())
    self setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 1);

  if(!isDefined(var_2))
    self notifyonplayercommand("_encstr_8C9E0F30132B96F1B2BA4053F7F20D196A", "_encstr_B44609DFE707CF394E1651");

  self animscriptsetinputparamreplicationstatus(1);

  if(isDefined(var_3))
    self setvelocity(var_3);

  if(!istrue(level.client_activate))
    self skydive_beginfreefall();

  if(getdvarint("_encstr_9BD5250BBFE8A94337C382AAA8156B9F2927916DDBB06E37653B9A42D3632354509537E577E8B7", 1) != 2)
    self skydive_setforcethirdpersonstatus(1);

  if(level.gametype == "_encstr_B607038AAB" && (!istrue(var_4) || (getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E")) && getdvarint("_encstr_A31818E61B9C7D4BDCCCD21BD71C2C9C2CC6435DA32B7D9D33E1", 1))
    thread stop_restock_recharge(getdvarint("_encstr_B6AF1E07834221E6673A2EB3A2632F889C0D81931CED88BE5BA2205B7ADB4489", 1) == 1 && (getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E"));

  if(!istrue(var_1))
    wait(var_0);

  thread pullchute(var_2, var_1);
}

stop_restock_recharge(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = self;
  wait 1.0;
  var_2 = "_encstr_A18008BD35E222F01BD0";

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.disabledebugdialogue))
    var_2 = var_2 + self.operatorcustomization.disabledebugdialogue;

  var_1 setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", var_2, 0);
  var_1 setisinfilskydive(1);
  wait 2.0;

  while(isalive(var_1) && !var_1 shoulddisableskydivevfx())
    wait 0.25;

  if(var_0) {
    while(isalive(var_1) && !var_1 isonground())
      wait 0.25;
  }

  var_1 setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_8B1608EC43B8D647A113", 0);
  var_1 setisinfilskydive(0);
}

riotshield_attach_parachute(var_0, var_1) {
  var_2 = undefined;

  if(var_0) {
    self.riotshieldmodel = var_1;
    var_2 = "_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D";
  } else {
    self.riotshieldmodelstowed = var_1;
    var_2 = "_encstr_81941033E6A7397E4A7713397B01CE0B7BFC";
  }

  self attachshieldmodel(var_1, var_2);
  self.hasriotshield = riotshield_hasweapon_parachute();
}

riotshield_getmodel_parachute() {
  return "_encstr_9B5415EEB2B007DB9B7DDDB5BE3996ED1D9B342D59D823";
}

riotshield_hasweapon_parachute() {
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

isriotshield_parachute(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0))
    return 0;

  if(isstring(var_0) && var_0 == "_encstr_8BBA05185F8B99")
    return 0;

  return weapontype(var_0) == "_encstr_A5450BC280BF4B604068C33187";
}

isparachutegametype() {
  return isDefined(level.gametype) && (level.gametype == "_encstr_B607038AAB" || level.gametype == "_encstr_B81904B04E6B" || level.gametype == "_encstr_B41904BB8593" || level.gametype == "_encstr_839E0CBFD1801B5DB0D34C932998" || level.gametype == "_encstr_8CA606F38878410D" || level.gametype == "_encstr_931D068662634370");
}

getc130height() {
  if(isDefined(level.br_level) && isDefined(level.br_level.c130_heightoverride))
    return level.br_level.c130_heightoverride;

  return 24000;
}

release_player_on_damage() {
  if(isDefined(level.fnhidefoundintel))
    return level.fnhidefoundintel;

  return 24000;
}

getc130sealevel() {
  if(isDefined(level.br_level) && isDefined(level.br_level.c130_sealeveloverride))
    return level.br_level.c130_sealeveloverride;

  return 650;
}

steerfalling(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A");
  var_1 hide();
  self playerlinktodelta(var_1, "_encstr_8E010B996FB7B6B3C1D1183343");
  steerfallinginternal(var_1, var_0);
  var_1 delete();
}

steerfallinginternal(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A92C126FCE33AA662968A36738C0554389ED7327");
  self endon("_encstr_A9E113A3A845C6179835FCE5D801DF0DA9587A5B20");
  self notify("_encstr_AF4B0F9BA359CA9C64858D63A537D941A4");
  self endon("_encstr_AF4B0F9BA359CA9C64858D63A537D941A4");
  var_2 = 13.8;
  var_3 = 0.0001;
  var_4 = -1350.0;
  var_5 = 1400.0;
  var_6 = 1600.0;
  var_7 = -100.0;

  if(level.gametype == "_encstr_B81904B04E6B") {
    var_4 = -1750.0;
    var_5 = 400.0;
    var_6 = 400.0;
  }

  if(isDefined(var_1)) {
    var_5 = var_5 * var_1;
    var_6 = var_6 * var_1;
  }

  var_8 = level.framedurationseconds * var_3;
  var_0.vel = (0, 0, var_7);
  waitframe();
  var_9 = getdvarint("_encstr_979A08F619C1EA8361C7");
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
    var_10 = var_10 + vectorNormalize(var_18 - var_10) * level.framedurationseconds * var_5;
    var_10 = var_10 - var_10 * length(var_10) * var_8;
    var_19 = var_0.vel[2] - var_2 * 39.37 * level.framedurationseconds;
    var_19 = max(var_4, var_19);
    var_20 = (0, 0, var_19);
    var_0.vel = var_20 + var_10;
    var_0.origin = var_0.origin + level.framedurationseconds * var_0.vel;
    var_21 = sqrt(var_0.vel[0] * var_0.vel[0] + var_0.vel[1] * var_0.vel[1]);
    var_22 = veltomph(var_0.vel[2] * -1);
    var_23 = veltomph(var_21);
    var_24 = min(1, (self.origin[2] - getc130sealevel()) / (getc130height() - getc130sealevel()));

    if(isparachutegametype())
      self setclientomnvar("_encstr_86F917D5A5F598937D0B63D1B45BCAA35627FAD0CAA5D9A1A3", var_24);

    waitframe();
  }
}

veltomph(var_0) {
  var_1 = var_0 * 0.05682;
  return var_1;
}

steerparachuting(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A");
  var_1 hide();
  self playerlinktodelta(var_1, "_encstr_8E010B996FB7B6B3C1D1183343");
  steerparachutinginternal(var_1, var_0);
  var_1 delete();
}

steerparachutinginternal(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A92C126FCE33AA662968A36738C0554389ED7327");
  self endon("_encstr_9674114388CBE9BA412D83FFAF61D2BE51C06B");
  self notify("_encstr_AF4B0F9BA359CA9C64858D63A537D941A4");
  self endon("_encstr_AF4B0F9BA359CA9C64858D63A537D941A4");
  var_2 = 100.0;
  var_3 = -200.0;
  var_4 = 600.0;
  var_5 = 240.0;
  var_6 = 120.0;
  var_7 = 60.0;
  var_8 = 48;
  var_9 = 35.0;
  var_10 = 700.0;
  var_11 = 100.0;
  var_12 = 600.0;
  var_13 = 300.0;
  var_14 = 100.0;
  var_15 = -150.0;

  if(level.gametype == "_encstr_B81904B04E6B")
    var_15 = -200.0;

  if(isDefined(var_1)) {
    var_2 = var_2 * var_1;
    var_3 = var_3 * var_1;
    var_4 = var_4 * var_1;
    var_5 = var_5 * var_1;
    var_6 = var_6 * var_1;
    var_7 = var_7 * var_1;
    var_10 = var_10 * var_1;
    var_12 = var_12 * var_1;
    var_13 = var_13 * var_1;
    var_14 = var_14 * var_1;
  }

  var_16 = 100.0;
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
    var_16 = var_16 + var_20 * var_25 * level.framedurationseconds;
    var_16 = var_16 + var_7 * level.framedurationseconds * scripts\engine\utility::sign(var_2 - var_16);
    var_16 = clamp(var_16, var_3, var_4);
    var_26 = -1 * var_20 * var_9;
    var_17 = var_17 + scripts\engine\utility::sign(var_26 - var_17) * var_8 * level.framedurationseconds;
    var_27 = rotatepointaroundvector(var_24, var_23, var_17);
    var_28 = var_16 * var_27;
    var_29 = var_23 * var_14 + (0, 0, var_15);
    var_18 = var_18 + var_12 * level.framedurationseconds * var_21;
    var_18 = var_18 - var_13 * level.framedurationseconds * scripts\engine\utility::sign(var_18);
    var_18 = clamp(var_18, -1 * var_10, var_10);
    var_30 = var_18 * var_24;
    var_31 = var_11 * abs(var_21);
    var_30 = var_30 + (0, 0, -1 * var_31);
    var_0.vel = var_28 + var_30 + var_29;
    var_0.origin = var_0.origin + var_0.vel * level.framedurationseconds;
    var_32 = sqrt(var_0.vel[0] * var_0.vel[0] + var_0.vel[1] * var_0.vel[1]);
    var_33 = max(0, veltomph(var_0.vel[2] * -1));
    var_34 = max(0, veltomph(var_32));
    var_35 = min(1, (self.origin[2] - getc130sealevel()) / (getc130height() - getc130sealevel()));

    if(isparachutegametype())
      self setclientomnvar("_encstr_86F917D5A5F598937D0B63D1B45BCAA35627FAD0CAA5D9A1A3", var_35);

    waitframe();
  }
}

usefailextractingmsg() {
  return isDefined(self.play_disguise_vo) && (self.play_disguise_vo == 5 || self.play_disguise_vo == 6);
}

enablemanualpullchute(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(var_0) && var_0 > 0) {
    self skydive_setdeploymentstatus(0);
    self skydive_setbasejumpingstatus(0);
    wait(var_0);
  }

  if(isDefined(self)) {
    if(usefailextractingmsg() || istrue(level.client_activate)) {
      return;
    }
    self skydive_setdeploymentstatus(1);
    self skydive_setbasejumpingstatus(1);
  }
}

pullchute(var_0, var_1, var_2) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  thread enablemanualpullchute(3);
  self waittill("_encstr_8D0118DCDAE523A59DB27D19CA0763DE5E0785270BC6435DA359");
  self skydive_setdeploymentstatus(0);
  self notify("_encstr_A92C126FCE33AA662968A36738C0554389ED7327");

  if(isparachutegametype())
    self setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 2);

  if(!istrue(level.dontshootwhileparachuting))
    self[[level.parachuteopencb]]();

  thread startparachute();
}

parachutedamagemonitor(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A9E113A3A845C6179835FCE5D801DF0DA9587A5B20");
  var_0 endon("_encstr_AD75063D571AE108");
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
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_14, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(isDefined(var_4)) {
      if(scripts\engine\utility::isbulletdamage(var_4))
        var_0.shotstaken++;
    }
  }
}

startparachute() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(getdvarint("_encstr_9BD5250BBFE8A94337C382AAA8156B9F2927916DDBB06E37653B9A42D3632354509537E577E8B7", 1) == 1)
    self skydive_setforcethirdpersonstatus(0);

  self waittill("_encstr_8C900C26440B51B8E61F7950CB0C");
  self.ignorefalldamagetime = gettime() + 5000;

  if(istrue(self.delayswaploadout))
    self.delayswaploadout = 0;

  waitframe();
  self[[level.parachuterestoreweaponscb]]();

  if(istrue(level.dontshootwhileparachuting))
    self[[level.parachutecompletecb]]();

  self notify("_encstr_9674114388CBE9BA412D83FFAF61D2BE51C06B");
  self skydive_setforcethirdpersonstatus(0);
  self notify("_encstr_A9E113A3A845C6179835FCE5D801DF0DA9587A5B20");
  self animscriptsetinputparamreplicationstatus(0);

  if(isparachutegametype())
    self setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 0);

  if(isparachutegametype()) {
    if(isDefined(level._id_12036))
      self[[level._id_12036]](self);
  }
}

parachutemidairdeathwatcher() {
  self endon("_encstr_A9E113A3A845C6179835FCE5D801DF0DA9587A5B20");
  self waittill("_encstr_AD75063D571AE108");

  if(isparachutegametype())
    self setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 0);
}

freefallstartdefault() {
  self disableusability();
  thread _id_126CB();
}

_id_126CB() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self allowfire(0);
  wait 0.5;
  self allowfire(1);
}

parachuteopendefault() {}

parachutecompletedefault() {
  self enableusability();

  if(!scripts\common\utility::is_killstreaks_allowed() && !istrue(self.isjuggernaut))
    scripts\common\utility::allow_killstreaks(1);

  if(isDefined(level.modespecificparachutecompletecb))
    self[[level.modespecificparachutecompletecb]]();

  self.jumptype = undefined;
}

getautodeploynorm() {
  return 0.25;
}

spawnorbitcamera() {
  self cameraset("_encstr_ADC71F81B69DD8CEEA7FCFFBD7639850178D2B39DCEC51A72153DFFDA79AD020C5");
}

removeorbitcamera() {
  self cameradefault();
}

leaveweaponsdefaultfunc() {}

norestoreweaponsdefaultfunc() {}

takeweaponsdefaultfunc() {
  if(isDefined(self.primaryweaponobj)) {
    self.primaryweaponclipammo = self getweaponammoclip(self.primaryweaponobj);
    self.primaryweaponstockammo = self getweaponammostock(self.primaryweaponobj);
  }

  if(isDefined(self.secondaryweaponobj)) {
    self.secondaryweaponclipammo = self getweaponammoclip(self.secondaryweaponobj);
    self.secondaryweaponstockammo = self getweaponammostock(self.secondaryweaponobj);
  }

  var_0 = getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  var_1 = getcompleteweaponname("_encstr_8BBA05185F8B99");
  self.weaponlist = self.primaryweapons;

  for(var_2 = 0; var_2 < self.weaponlist.size; var_2++) {
    var_3 = self.weaponlist[var_2];

    if(isDefined(var_3) && !isnullweapon(var_0, var_3) && !isnullweapon(var_1, var_3))
      self takeweapon(var_3);
  }

  self clearaccessory();

  if(!self hasweapon(var_0))
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1);
}

restoreweaponsdefaultfunc() {
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

  if(isDefined(self.weaponlist[0]))
    scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0]);

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0]))
    self.primaryweaponobj = self.weaponlist[0];

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1]))
    self.secondaryweaponobj = self.weaponlist[1];
}

playerwatchforredeploy() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(scripts\common\utility::iscp())
    self endon("_encstr_AD75063D571AE108");

  var_0 = getdvarfloat("_encstr_87C122E636C9FAE00B9C851BD0BAD195D727AC23CA1C8DDEF2FAB55A9BBEA1ACD2760D8E", 256);
  var_1 = 0;
  self.redeployenabled = 1;

  for(;;) {
    if(istrue(self.redeployenabled) && !self isonground() && scripts\cp_mp\utility\player_utility::_isalive() && !self isskydiving() && !self islinked() && !istrue(self.carrying) && !istrue(level.client_activate)) {
      var_2 = 0;

      switch (getdvarint("_encstr_95AB22DCD8C9BE0E0B27C28D0DAB8EB2FA9395325907C67BE57DA57338ABD1EBD12F1CCA", 0)) {
        case 0:
          if(var_1 == 0 && self jumpbuttonPressed())
            var_2 = 1;

          break;
        case 1:
          if(self jumpbuttonPressed() && var_1 + 500 < gettime())
            var_2 = 1;

          break;
        case 2:
          if(!isDefined(self.doublejumpdetected))
            thread watchfordoublejump();

          if(istrue(self.doublejumpdetected))
            var_2 = 1;

          break;
        default:
          break;
      }

      if(var_2) {
        var_3 = scripts\common\utility::groundpos(self.origin);
        var_4 = self.origin[2] - var_3[2];

        if(var_4 > var_0) {
          self notify("_encstr_8D0118DCDAE523A59DB27D19CA0763DE5E0785270BC6435DA359");
          self skydive_deployparachute();
        }
      }
    }

    if(isDefined(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
      if(!self jumpbuttonPressed())
        var_1 = 0;
      else if(var_1 == 0)
        var_1 = gettime();
    } else
      var_1 = 0;

    waitframe();
  }
}

watchfordoublejump() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.doublejumpdetected = 0;

  for(;;) {
    if(self jumpbuttonPressed()) {
      var_0 = gettime();
      var_1 = 0;
      waitframe();

      for(;;) {
        if(!self jumpbuttonPressed()) {
          if(gettime() < var_0 + 500 && !self isonground())
            var_1 = gettime();

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

_id_121D2() {
  var_0 = self;

  if(level.gametype == "_encstr_B607038AAB") {
    if(isDefined(var_0.play_disguise_vo) && (var_0.play_disguise_vo == 1 || var_0.play_disguise_vo == 2)) {
      var_0 play_collected_key_vo();
      var_0.play_disguise_vo = 3;
    }
  } else if(level.gametype == "_encstr_839E0CBFD1801B5DB0D34C932998") {
    var_0 setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 0);
    var_0 play_collected_key_vo(1);
  }
}

_id_14002() {
  var_0 = self;
  var_1 = var_0 getvelocity();
  var_2 = clamp(var_0.origin[2], 0, level._id_133F9._id_1467D) / level._id_133F9._id_1467D;
  var_3 = level._id_133F9._id_1467C + (level._id_133F9._id_1467B - level._id_133F9._id_1467C) * var_2;
  var_4 = var_1 * (1, 1, 0);
  var_5 = length(var_4);
  var_6 = var_4 * var_3;
  var_7 = var_5 * var_3;

  if(var_7 > level._id_133F9._id_1467A)
    var_6 = var_6 * (level._id_133F9._id_1467A / var_7);

  var_8 = 0;
  var_8 = var_8 - var_0.origin[2] * level._id_133F9._id_1468F;
  var_8 = var_8 + level._id_133F9.zoffset;
  var_8 = var_8 + var_1[2] * level._id_133F9._id_1472C;
  var_8 = clamp(var_8, -1 * level._id_133F9._id_14690, 0);
  var_9 = 1;

  if(var_5 < level._id_133F9.pe_chopper_zones * var_1[2])
    var_9 = 2;

  var_0 setadditionalstreampos(var_0.origin + (var_6[0], var_6[1], var_8), 0, var_9);
}

playerpowerresetpowers(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_95B21E9927CAB22316638D234EF6B541C60B732B4DE82CE8ACA9B08D43969BAC");
  self endon("_encstr_95B21E9927CAB22316638D234EF6B541C60B732B4DE82CE8ACA9B08D43969BAC");
  var_7 = self;
  var_7.play_disguise_vo = 1;
  var_7.play_cinderblock_broken_fx = istrue(var_4);
  var_7.play_contract_announcer_maybe = 0;
  var_7 play_chopper_kill_vo(var_0, var_1, var_2, var_3, var_5, var_6);
  var_7 play_death_sound_with_global_cooldown();
  var_8 = gettime();

  for(;;) {
    if(var_7 isskydiving() || var_8 + 2000 < gettime() || var_7 usefailextractingmsg()) {
      break;
    }

    waitframe();
  }

  for(;;) {
    if(level._id_133F9._id_13918 && var_7.play_contract_announcer_maybe < gettime()) {
      var_7 _id_14002();
      var_7.play_contract_announcer_maybe = gettime() + 500;
    }

    if(var_7 isinfreefall() && var_7.play_disguise_vo != 1) {
      var_7 play_death_sound_with_global_cooldown();
      var_7.play_disguise_vo = 1;
    }

    if(var_7 isparachuting() && var_7.play_disguise_vo != 2) {
      var_7 play_death_audio();
      var_7.play_disguise_vo = 2;
    }

    if(!var_7 isskydiving() && var_7.play_disguise_vo != 3 && var_7.play_disguise_vo != 4 && var_7.play_disguise_vo != 6 || var_7.play_disguise_vo == 5) {
      var_7 play_collected_key_vo();

      if(var_7.play_disguise_vo != 5)
        var_7.play_disguise_vo = 3;
      else
        var_7.play_disguise_vo = 6;
    }

    var_9 = istrue(var_7.inlaststand);
    var_10 = var_7 isonground() && (var_7.play_disguise_vo == 3 || var_7 usefailextractingmsg());
    var_11 = var_7 isonladder();
    var_12 = !scripts\mp\utility\player::isreallyalive(var_7);

    if(var_9 || var_10 || var_11 || var_12) {
      var_7 play_counter_beep_sfx_on_bomb_vests();
      var_7.play_disguise_vo = undefined;
      var_7.play_cinderblock_broken_fx = undefined;
      var_7.play_contract_announcer_maybe = undefined;

      if(var_11)
        var_7 skydive_interrupt();

      return;
    }

    waitframe();
  }
}

play_chopper_kill_vo(var_0, var_1, var_2, var_3, var_4, var_5) {
  self skydive_interrupt();

  if(!istrue(level.parachuteinitfinished))
    initparachutedvars();

  if(!isDefined(var_0))
    var_0 = 4.0;

  if(!isDefined(var_4))
    var_4 = 1;

  if(var_4 && level.gametype != "_encstr_B607038AAB")
    self[[level.parachutetakeweaponscb]]();

  self[[level.freefallstartcb]]();

  if(!isDefined(var_2))
    self notifyonplayercommand("_encstr_8C9E0F30132B96F1B2BA4053F7F20D196A", "_encstr_B44609DFE707CF394E1651");

  self animscriptsetinputparamreplicationstatus(1);

  if(isDefined(var_3))
    self setvelocity(var_3);

  var_6 = level.client_activate;

  if(isDefined(var_5))
    var_6 = var_5;

  if(!istrue(var_6))
    self skydive_beginfreefall();

  if(getdvarint("_encstr_9BD5250BBFE8A94337C382AAA8156B9F2927916DDBB06E37653B9A42D3632354509537E577E8B7", 1) != 2)
    self skydive_setforcethirdpersonstatus(1);

  if(level.gametype == "_encstr_B607038AAB" && (!istrue(self.play_cinderblock_broken_fx) || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9") || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E")
    thread stop_restock_recharge(getdvarint("_encstr_B6AF1E07834221E6673A2EB3A2632F889C0D81931CED88BE5BA2205B7ADB4489", 1) == 1 && (getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E"));

  if(istrue(var_1))
    thread enablemanualpullchute(0);
  else
    thread enablemanualpullchute(var_0);

  self[[level.parachuterestoreweaponscb]]();
}

play_death_sound_with_global_cooldown() {
  if(isparachutegametype()) {
    self setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 1);
    level.audio_player_stop_mud_loop[self getxuid()] = self;
  }

  if(!self.play_cinderblock_broken_fx) {
    var_0 = "_encstr_A18008BD35E222F01BD0";

    if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.disabledebugdialogue))
      var_0 = var_0 + self.operatorcustomization.disabledebugdialogue;
  }

  if(istrue(level.pilot_linkto_origin_offset))
    _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("_encstr_B15208273F5BA2896879");
}

play_death_audio() {
  self notify("_encstr_A92C126FCE33AA662968A36738C0554389ED7327");
  var_0 = scripts\cp_mp\utility\script_utility::_id_140DE("_encstr_B472054FE12550", "_encstr_979A0DD15F81E677754743DB49CEB3", 0);
  var_1 = scripts\cp_mp\utility\script_utility::_id_140DE("_encstr_B472054FE12550", "_encstr_A13E0F3BCAE8A9D5263AB0B595515E0756", "_encstr_B40101");
  var_2 = var_1 != "_encstr_85EE090C9DD0A62F3CA1B3" && var_1 != "_encstr_8F94079C2BB3B2C21B" && var_1 != "_encstr_BD1D06DA5D98651B";

  if(var_0 && var_2 && istrue(self.stickers)) {
    var_3 = scripts\cp_mp\utility\script_utility::_id_140DE("_encstr_813F06832D8A18FE", "_encstr_88C312B269FD8396A0118F856B50DAB7AE476A0B", "_encstr_B40101", ["_encstr_91A118894EEBA5B9CCA5C6BEA9575B0EEBC116C90BC643AEA32B"]);
    self setplayermusicstate(var_3);
    self.stickers = undefined;
  }

  level.audio_player_stop_mud_loop[self getxuid()] = self;

  if(isparachutegametype())
    self setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 2);

  if(!istrue(level.dontshootwhileparachuting))
    self[[level.parachuteopencb]]();

  if(isDefined(level._id_1205E))
    self[[level._id_1205E]]();

  if(istrue(level.pilot_linkto_origin_offset))
    _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("_encstr_B15208273F5BA2896879");
}

play_collected_key_vo(var_0) {
  self.ignorefalldamagetime = gettime() + 5000;
  self.waitillcanspawnclient = gettime();

  if(istrue(self.delayswaploadout))
    self.delayswaploadout = 0;

  if(istrue(level.dontshootwhileparachuting))
    self[[level.parachutecompletecb]]();

  self notify("_encstr_9674114388CBE9BA412D83FFAF61D2BE51C06B");
  self skydive_setforcethirdpersonstatus(0);

  if(!usefailextractingmsg() && !istrue(level.client_activate))
    self skydive_setbasejumpingstatus(1);

  if(istrue(self.restoreriotshieldonland)) {
    riotshield_attach_parachute(self.restoreriotshieldonland == 1, riotshield_getmodel_parachute());
    self.restoreriotshieldonland = undefined;
  }

  level.audio_player_stop_mud_loop[self getxuid()] = undefined;
  self notify("_encstr_A9E113A3A845C6179835FCE5D801DF0DA9587A5B20");
  self animscriptsetinputparamreplicationstatus(0);

  if(istrue(level.pilot_linkto_origin_offset))
    _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("_encstr_B15208273F5BA2896879");
}

play_counter_beep_sfx_on_bomb_vests() {
  if(getdvarint("_encstr_879C1B12A15897C30F5D3727712DCBE589680CDDBBD9751A57150B3741", 0))
    self clearadditionalstreampos();

  if(isparachutegametype()) {
    level.audio_player_stop_mud_loop[self getxuid()] = undefined;
    self setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 0);
    thread _id_1274E();

    if(isDefined(level._id_12036))
      self[[level._id_12036]](self);

    if(istrue(level.pilot_linkto_origin_offset))
      _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("_encstr_B15208273F5BA2896879");
  }
}

_id_1274E() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 0.3;

  if(isalive(self) && self.sessionstate == "_encstr_877508C1D8C22F2DDC3B") {
    self playlocalsound("_encstr_95B61A4B0A452923D6AF6B8BCBAF3838E0C88F235396A970D89D791F", self);
    self playsoundonmovingent("_encstr_8EA51AE983372F388CCF51431677996FCF1B01718A2FDDF869C671BF");
    var_0 = scripts\cp_mp\utility\script_utility::_id_140DE("_encstr_B472054FE12550", "_encstr_979A0DD15F81E677754743DB49CEB3", 0);

    if(var_0) {
      wait 5.0;
      var_1 = scripts\cp_mp\utility\script_utility::_id_140DE("_encstr_813F06832D8A18FE", "_encstr_8BDE19D7476D07FF15EE6171669BC793C31279F71598C7C208C748", 0, [self]);

      if(var_1)
        self.nosuspensemusic = undefined;
    }
  }
}

_id_121CA() {
  var_0 = self;
  var_0 skydive_interrupt();

  if(isDefined(var_0.parachute))
    var_0.parachute delete();
}