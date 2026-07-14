/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\script_funcs.gsc
************************************************/

#using scripts\anim\combat_utility;
#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\melee;
#using scripts\common\gameskill;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_ad29b7c653247c74;

function soldier_init(asmname, statename, params) {
  assert(isDefined(self.asm));
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "Z\xdcvX\x1b\x96#";
  self.asm.footsteps.time = 0;
  self.asm.customdata = spawnStruct();
  self.asm.gestures = spawnStruct();
  self.defaultturnthreshold = 59;
  self.anglelerprate = 100;

  if(!isDefined(self.allowlongdeath)) {
    self.allowlongdeath = 1;
  }

  if(isDefined(self.fnasm_initfingerposes)) {
    self thread[[self.fnasm_initfingerposes]]();
  }

  self.fnhelmetpop = &death::helmetpop;
  initaimlimits(asmname);

  if(self findoverridearchetype("\x91\xca\xcc\v\xab\xd8:") == "\x93e1+\x8d") {
    self.maystumble = 1;
  }

  self.var_d8d05f6c2c45c048 = 1;

  if(self isscriptable()) {
    thread initscriptable();
  }

  self function_fc623e800cdeade7();
  weapclass = weaponclass(self.weapon);

  if(weapclass == "\b5") {
    self.combatmode = "\x82K\x883\xd3\x96O\x87\xd8";
  }

  if(!isDefined(self findoverridearchetype("\xe5\x06\xb0\bE\x16"))) {
    shared::updateweaponarchetype(weapclass);
  }

  if(!isDefined(self.var_42b8323e845b6f1d)) {
    self.var_42b8323e845b6f1d = &melee::function_152fe99883f33558;
  }

  self.disablegrenaderesponse = 0;
}

function initscriptable() {
  self endon("\x1e\xfd\xd1\xa2\a");
  utility::flag_wait("\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97");
  self setscriptablepartstate("\xcd\xf6:\xca\xd1rX\xb1\xd6_\x86\v\xcd\x196e'", "\xe3\x93}=nD", 0);
}

function initaimlimits(asmname) {
  if(!isDefined(level.combataimlimits)) {
    level.combataimlimits = [];
    level.franticaimlimits = [];
    level.aimlimitstatemappings = [];
  }

  if(!isDefined(level.combataimlimits[asmname])) {
    combataimlimits = [];
    franticaimlimits = [];
    aimlimit = [];
    combataimlimits["{\xa1H8_\xf2\xea<\f\x8a\xad}"] = aimlimit;
    aimlimit = [];
    franticaimlimits["{\xa1H8_\xf2\xea<\f\x8a\xad}"] = aimlimit;
    aimlimit = [];
    aimlimit["\x7f5\xe8e"] = 15;
    combataimlimits[";K6\xd9\x9d\xf2\xcf\x87\x01<Y\x06\xf1\xb8\xf4\xf6\x18"] = aimlimit;
    aimlimit = [];
    aimlimit["\x7f5\xe8e"] = 15;
    franticaimlimits[";K6\xd9\x9d\xf2\xcf\x87\x01<Y\x06\xf1\xb8\xf4\xf6\x18"] = aimlimit;
    aimlimit = [];
    franticaimlimits["-\xb8!\xf1\f\x96\xe3kn\x95n\x15\xa3\"\x18$"] = aimlimit;
    aimlimit = [];
    aimlimit["o0\xee\xc1\x8c"] = -15;
    combataimlimits["\xba\xea\xd9\xd1\x14\x8bl\xa7w\x12\x93\x93\xc1\x9c\xa8"] = aimlimit;
    aimlimit = [];
    aimlimit["o0\xee\xc1\x8c"] = -15;
    franticaimlimits["\xba\xea\xd9\xd1\x14\x8bl\xa7w\x12\x93\x93\xc1\x9c\xa8"] = aimlimit;
    aimlimit = [];
    aimlimit["o0\xee\xc1\x8c"] = -15;
    combataimlimits["\xc6{\xce+'\xafcVf\x1d}\x1b\xc9\xb7\xae64}\xb1V,\xcd"] = aimlimit;
    aimlimit = [];
    aimlimit["o0\xee\xc1\x8c"] = -15;
    franticaimlimits["\xc6{\xce+'\xafcVf\x1d}\x1b\xc9\xb7\xae64}\xb1V,\xcd"] = aimlimit;
    aimlimit = [];
    aimlimit["=\xff0b"] = 15;
    combataimlimits["\xa9\xc4|\x7f\xea\xcf\x11P\xf4\x80\x88N\xa6\x97\xeem"] = aimlimit;
    aimlimit = [];
    aimlimit["\x7f5\xe8e"] = 37;
    aimlimit["=\xff0b"] = 24;
    franticaimlimits["\xa9\xc4|\x7f\xea\xcf\x11P\xf4\x80\x88N\xa6\x97\xeem"] = aimlimit;
    aimlimit = [];
    aimlimit["=\xff0b"] = 25;
    combataimlimits["sd\xfal\x04\xb1Tai8kV\x04\xf8$e\xb3\xb8\xb1\x84\xf5.8"] = aimlimit;
    aimlimit = [];
    aimlimit["=\xff0b"] = 15;
    franticaimlimits["sd\xfal\x04\xb1Tai8kV\x04\xf8$e\xb3\xb8\xb1\x84\xf5.8"] = aimlimit;
    level.combataimlimits[asmname] = combataimlimits;
    level.franticaimlimits[asmname] = franticaimlimits;
  }

  if(!isDefined(level.aimlimitstatemappings[asmname])) {
    aimlimitmapping = [];
    aimlimitmapping["\x84p\xb8\xc8\xaf\xc0\xf12\xd4|\xfeC1\x96\xd8/1\xaf\x8d"] = "\x84p\xb8\xc8\xaf\xc0\xf12\xd4|\xfeC1\x96\xd8/1\xaf\x8d";
    aimlimitmapping["x\xf5CU\xb9\x95\x15\xde\xc9\xa2\x935\xd9\xbf\xf3\x95F\xb8\x18\xf2\xda\xa1\x94\xc3\x91\x99\xed"] = "\x84p\xb8\xc8\xaf\xc0\xf12\xd4|\xfeC1\x96\xd8/1\xaf\x8d";
    aimlimitmapping["`\xfd\xce\xa8\xe8\x04#\xee{\xa6T\xbf/w\x95t0\xff\x02-\xfe\x95\xbe\xee"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xcc\b\xcd\xa2\xb50z4\xc8\x145_\x89\x91\xdf\xb6\xd0\x9c\x1e\xf2\xbcm\xa9\x9b?\xca\x04\x97}\xe0A\xd7"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\x8d{;\xac9}\xb9G\v\xdcF\xbeto\xf5\xb2<\a\xbd\x9b+\x8c\xbe\xb4\x19l\xac"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xb4)\xc3H\x1f\x93\x15'3~9\x0e\xeb"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\"\xde\xfc\x82\xe5\xe7%\xdfN$\x1b\xe4\xbc\xfa2\x91\xd0"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xb1\xd7\x1b$p\xf1\x13%\xcd\xc3\xd5\xe9\xbd\xf9q0\xe2\x19X"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["w\x16\xc6\x1b}9\xd5n\xeb\xc9\xa5\x9d\rt\xbe\xdc\r\xed\xbd:"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["I\xa8\x83\xa05<\x9d\x83\xf7t\"\xcdf\x84]\xde\xad\x02|M\x03\x8e\x9a\x86r\x92"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xefs\x0fY\x10\t\x12L\x8e\x83\x7f\xa1\xdcY#x\xaacg0\xf0\x9c\xb1]\xa0\xd2\xf2"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xb1\xb7\xceVr\xaf\xb19\xed]ch\xbe\x1a\xb4#e\xd7\xa3\xdb}\xcd\x8e,\xdc\x91"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["u\x18c\x87z1\xa4U\xad\x80\xb0V\x8ahVMF\xb8#\x8e\xcd\xfe\xa0\xad"] = "-\xb8!\xf1\f\x96\xe3kn\x95n\x15\xa3\"\x18$";
    aimlimitmapping["\xddx'\xff\xe0\xf5\xf3\xb1(\xb6\xdc1?\xeb\x1f\xb1]\x82:\x1e:\r\x81\xe7\xdbn"] = "-\xb8!\xf1\f\x96\xe3kn\x95n\x15\xa3\"\x18$";
    aimlimitmapping["\xd8\x11=\xdd\xeb:\xdd\xa7X\x91.\xae\n\xf4\xef\\0y\xff\xa5\r)\x16H\x9a"] = "-\xb8!\xf1\f\x96\xe3kn\x95n\x15\xa3\"\x18$";
    aimlimitmapping["\xce\xecD\x1b\xf3\x15c\x10\x9eyMnP\xfd\xb6[!`\xfc\xbb\xbae\xec\xa1I"] = ";K6\xd9\x9d\xf2\xcf\x87\x01<Y\x06\xf1\xb8\xf4\xf6\x18";
    aimlimitmapping["-\xb8!\xf1\f\x96\xe3kn\x95n\x15\xa3\"\x18$"] = "-\xb8!\xf1\f\x96\xe3kn\x95n\x15\xa3\"\x18$";
    aimlimitmapping[";K6\xd9\x9d\xf2\xcf\x87\x01<Y\x06\xf1\xb8\xf4\xf6\x18"] = ";K6\xd9\x9d\xf2\xcf\x87\x01<Y\x06\xf1\xb8\xf4\xf6\x18";
    aimlimitmapping["\xb4\x1aS\x853g\x8f|f\xc0\x96\xf0\x8fN\x9e@R\xcd\x01\xeb\x92I\xbc\xb4V"] = "-\xb8!\xf1\f\x96\xe3kn\x95n\x15\xa3\"\x18$";
    aimlimitmapping["\x8b\xe2+ \xf0;\x7f\xbb?\xf9&\xd6\xc8\xa3\x89n\t\xa6\xb6\x1f\b\x8c\xef\xff\x99\xce"] = "-\xb8!\xf1\f\x96\xe3kn\x95n\x15\xa3\"\x18$";
    aimlimitmapping["3\x1f7\xc3>w%7*qT\xdett\xe396#"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["AaFy\x88\xc9\x87Q{\x16\x87\xd9\xfd\xd4\xc3g\xd4\x12\xce?-\xc2/\xcbb\x98\a\xdd"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\x10\xb3YSq\x90\x93k\xaa \xd9\xd0\x1b\x9b\\\x91\x12\xfe\x18\\\x17"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\x96\x94\a\x19\xd6\xb1A~\xd3:\xdb_\xe9\xe9v\x8d\xbcC]\x03b"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["N\xf8\t\xbd\xda\x98\xee3\xf0\xefD\x11\xb6\xab\x7fINzl:^"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xcext\xc1W#\xc8\xe2\n\x88[\xf3\x97\xe3\x12[\xfdd\xe1\xe0\xd1"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["_#Xt>\x04\xfc\x05\x11\xf4\x04\x7f\xfb7<\x8d\x05\xb3"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xb1!\x04\n\xbc\xce\xc2\x18\x90\x8c\xfe\xc1\xaa\xe4Ib\xd2;"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["@G\xf3\xe5\xe5\xc4\x9b\xee\xc1\xd2\xb6;\x91\x97o\xc1\x13d\x8c\\\\JQ\xf8\xa9\xedg\xfb"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["i\xeaXm\x90w\x8002\xb0_<\xd6B\xd4\x95\xb6S\xa3\x93\xc6\xd0\xb0NdN\x96\xc0"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xc6\xf6v\xca\xc9\xaf\x93i\xceCG\xbe\xc6\x9c{Wch_\x86\xb42\xca}\xe8\xde\xfa\v"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xe3\xaa\xbe\x86\xf2\xfd\xec\x1c\x82x\xc2j\xc3&\xfe[\xd6;\x88@H3\x1c\x18\x06\xfb\xed\x95"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["+\xf0f\x82\x8a\x84{$\fI0\xbce\xb8\xfc\xf2\xb7\xd1\xfe\xc4\x83\xa7\x84\x02&"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["Vrw\xaf\xeaC/\x92Qh(W7\xf7`\xd3V|\xde3U(\x9e\xdf\x90"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xa9\xc4|\x7f\xea\xcf\x11P\xf4\x80\x88N\xa6\x97\xeem"] = "\xa9\xc4|\x7f\xea\xcf\x11P\xf4\x80\x88N\xa6\x97\xeem";
    aimlimitmapping["XC\xc8El\xd4s\v\xf2\x94\x14\x8f\xf8.g\x1a\x96T\xacd\x8b\xd0\xda\xfb"] = "\xa9\xc4|\x7f\xea\xcf\x11P\xf4\x80\x88N\xa6\x97\xeem";
    aimlimitmapping["c\xb7\xd9e\x9c_'\xd2v\xd0\x8e\xd7\x1bN\xf6\xab\xb1\x1a\xf5h\xb42\xb2\xafG\xed\xf5\xd8Y,\x9b"] = "sd\xfal\x04\xb1Tai8kV\x04\xf8$e\xb3\xb8\xb1\x84\xf5.8";
    aimlimitmapping["sd\xfal\x04\xb1Tai8kV\x04\xf8$e\xb3\xb8\xb1\x84\xf5.8"] = "sd\xfal\x04\xb1Tai8kV\x04\xf8$e\xb3\xb8\xb1\x84\xf5.8";
    aimlimitmapping["\x9f\x06\xf61Y\x93[\xf2\x979HA\x04\xeb\x80;j<\x16IX\t\xf1\x01!X\x10"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xddx'\xff\xe0\xf5\xfc\xed\t\xb4\xc2\xe1\x06\xed\x7f\x9f]n\x96&"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["Pk_8\x92zB\x1d\xf6S\x19-\x88:\xd3\x10\xa1>c\xae"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\x8f\x87\xdc\xfd\xad\xe1\xd1\x1dY\xef~\xf3\xf2\x8aV;\xdcA\xb7_"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["1py\xfc\x02\xa8\xec\xc1\xbdi\x93\xa6ue\xcf\xb7\xf0\xcexA"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["'T\xe3\xfbi5\x18\x148f\xc0\xbd\xfe-\b)W"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xb8\x11\xaf\xd8\xcd&\xc3\xe1\x85\x05\xa1m\xa5\xfe0\xfc\xb8"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\x7f\xb8\xeb\x85Y\xc5\x15\xc7f,\x9f0\xc0\x1c\xd5\xfd#\xc7dlT.\xa6"] = "\xba\xea\xd9\xd1\x14\x8bl\xa7w\x12\x93\x93\xc1\x9c\xa8";
    aimlimitmapping["\xba\xea\xd9\xd1\x14\x8bl\xa7w\x12\x93\x93\xc1\x9c\xa8"] = "\xba\xea\xd9\xd1\x14\x8bl\xa7w\x12\x93\x93\xc1\x9c\xa8";
    aimlimitmapping["c\xf6\xce+r\xbe\x8dV\x99t\xfa\x1b\x9c\xdeW6\x1a\xaf\x86Kd+\xd7\xa3{\xd76\xca,7"] = "\xc6{\xce+'\xafcVf\x1d}\x1b\xc9\xb7\xae64}\xb1V,\xcd";
    aimlimitmapping["\xc6{\xce+'\xafcVf\x1d}\x1b\xc9\xb7\xae64}\xb1V,\xcd"] = "\xc6{\xce+'\xafcVf\x1d}\x1b\xc9\xb7\xae64}\xb1V,\xcd";
    aimlimitmapping["\x15\x03\xb6>\x0f\x06\x8dU\xd6k'>\a:RW{\x04\x8e\v`\xd9\xd7\xbd\xb7\x19"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xe7\xb9\xc1\x7fsR\xc0\x88"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\x1b.&\xafn\xa3a\xcd2\xd7c\xdb\xbd\x83"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["H\x9b,\xcb\xdf\x96\xc1Hg\x9fx4=\xbe)\x14\xa7q\xde\xbc5"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["o\xb0\xbf&\xb2\x12O\xccT\x1f\xf1U\xb1\xee\\\x11k>\xd0\xa3\xa4"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xac\x878\xde\xcde\x19\xaf\xe4e\xc6{,\x19"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["`Qayt\x8d\x1d\x93\xd4\xf3T+\x10\xa8h\xf4I\xf3\xccs"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\xba\xc1lCxQ\xf6-\xaf\xc9\x9fC\xce)\xd83\xd0h"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["{\xa1H8_\xf2\xea<\f\x8a\xad}"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\x16m\x8b7\x83\xb6Q\xc6\x82_\xcd&\xb2"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    aimlimitmapping["\x06R\xf8\xe2\xc7\xfe0z\xdc|\x85\xb2\xba>\x19I\x01\xc8\xfa\xa3\xd9\x14q\xb7\x8c\xec!\xa5jw\x8d"] = "{\xa1H8_\xf2\xea<\f\x8a\xad}";
    level.aimlimitstatemappings[asmname] = aimlimitmapping;
  }
}

function needtoturn3d(asmname, statename, tostatename, params) {
  if(istrue(self.matchexposednodeorientation) && isDefined(self.node)) {
    return false;
  }

  yaw = getturndesiredyaw3d();

  if(abs(yaw) > self.turnthreshold) {
    return true;
  }

  pitch = getturndesiredpitch3d();

  if(abs(pitch) > self.pitchturnthreshold) {
    return true;
  }

  return false;
}

function getturndesiredyaw() {
  if(isDefined(self.desiredturnyaw)) {
    return self.desiredturnyaw;
  }

  predicttime = 0.25;
  shootent = undefined;
  shootpos = undefined;

  if(self bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_pos)) {
      shootpos = self._blackboard.shootparams_pos;
    } else if(isDefined(self._blackboard.shootparams_ent)) {
      shootent = self._blackboard.shootparams_ent;
    }
  } else if(isDefined(self.smartfacingpos)) {
    shootpos = self.smartfacingpos;
  }

  if(!isDefined(shootpos) && isDefined(self.node) && self.node.type == "\xf7\xd5d'hTb" && distancesquared(self.node.origin, self.origin) < 36) {
    return angleclamp180(self.node.angles[1] - self.angles[1]);
  }

  if(isDefined(shootent) && !issentient(shootent)) {
    predicttime = 1.5;
  }

  desiredyaw = utility::getpredictedaimyawtoshootentorpos(predicttime, shootent, shootpos);
  return desiredyaw;
}

function getturndesiredyaw3d() {
  predicttime = 0.25;
  shootent = undefined;
  shootpos = undefined;

  if(self bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_ent)) {
      shootent = self._blackboard.shootparams_ent;
    } else if(isDefined(self._blackboard.shootparams_pos)) {
      shootpos = self._blackboard.shootparams_pos;
    }
  } else if(isDefined(self.enemy)) {
    shootent = self.enemy;
  }

  if(isDefined(shootent) && !issentient(shootent)) {
    predicttime = 1.5;
  }

  desiredyaw = utility::getpredictedaimyawtoshootentorpos3d(predicttime, shootent, shootpos);
  return desiredyaw;
}

function getturndesiredpitch3d() {
  predicttime = 0.25;
  shootent = undefined;
  shootpos = undefined;

  if(self bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_ent)) {
      shootent = self._blackboard.shootparams_ent;
    } else if(isDefined(self._blackboard.shootparams_pos)) {
      shootpos = self._blackboard.shootparams_pos;
    }
  } else if(isDefined(self.enemy)) {
    shootent = self.enemy;
  }

  if(isDefined(shootent) && !issentient(shootent)) {
    predicttime = 1.5;
  }

  desiredpitch = utility::getpredictedaimpitchtoshootentorpos3d(predicttime, shootent, shootpos);
  return desiredpitch;
}

function chooseturnanim3d(asmname, statename, params) {
  desiredyaw = getturndesiredyaw3d();
  desiredpitch = getturndesiredpitch3d();

  if(abs(desiredyaw) > self.turnthreshold && abs(desiredyaw) > abs(desiredpitch)) {
    if(desiredyaw < 0) {
      direction = "o0\xee\xc1\x8c";
    } else {
      direction = "=\xff0b";
    }

    desiredyaw = abs(desiredyaw);
    angle = 0;

    if(desiredyaw > 157.5) {
      angle = 180;
    } else if(desiredyaw > 112.5) {
      angle = 135;
    } else if(desiredyaw > 67.5) {
      angle = 90;
    } else {
      angle = 45;
    }

    animalias = direction + "w" + angle;
    turnanim = asm::asm_lookupanimfromalias(statename, animalias);
    return turnanim;
  }

  if(desiredpitch < 0) {
    direction = "\xf3\xf2";
  } else {
    direction = "\x7f5\xe8e";
  }

  desiredpitch = abs(desiredpitch);
  angle = 0;

  if(desiredpitch > 157.5) {
    angle = 180;
  } else if(desiredpitch > 112.5) {
    angle = 135;
  } else if(desiredpitch > 67.5) {
    angle = 90;
  } else {
    angle = 45;
  }

  animalias = direction + "w" + angle;
  turnanim = asm::asm_lookupanimfromalias(statename, animalias);
  return turnanim;
}

function choosecrouchturnanim(asmname, statename, params) {
  desiredyaw = getturndesiredyaw();

  if(desiredyaw < -135) {
    alias = "Q\xda";
  } else if(desiredyaw > 135) {
    alias = "|\xdc";
  } else if(desiredyaw < 0) {
    alias = "\xbb";
  } else {
    alias = "P";
  }

  turnanim = asm::asm_lookupanimfromalias(statename, alias);
  return turnanim;
}

function reload_cleanup(asmname, statename, params) {
  nullweapon = nullweapon();
  self notify("\xe8\"\xdfw\x83G\xb4hW\x94");
  weap = self.asmreloadweapon;
  self.asmreloadweapon = nullweapon;
  self._blackboard.breload = 0;

  if(!isDefined(self.weaponinfo)) {
    return;
  }

  var_352bce8142e16507 = weap != nullweapon && isDefined(self.weapon) && weap == self.weapon;

  if(weap == nullweapon) {
    weap = self.weapon;
  }

  weaponname = getcompleteweaponname(weap);

  if(!isDefined(self.weaponinfo[weaponname])) {
    return;
  }

  if(!asm::asm_eventfired(asmname, "\x83(\x11\nQQ\"'\xf3")) {
    return;
  }

  if(self.weaponinfo[weaponname].useclip) {
    clipmodel = getweaponclipmodel(weap);

    if(isDefined(clipmodel)) {
      battached = asm::asm_eventfired(asmname, "\xc2Gt\xc2\x8d4\x01c\xd8K\a@\xd8Y3G") || asm::asm_eventfired(asmname, "bJX8y\xa0+\xcb\x81\x14\xdblCZ\v\x1f\xf6");
      bdetached = asm::asm_eventfired(asmname, "\x8c\xb2\xd1\v\x8d\x86 c\x1bK\xc1\x04\x1b\xac3\x1d") || asm::asm_eventfired(asmname, "\xe9\xd1\xf1\xd9\xb3\xf6\xd3\x1a\xb6Z\xc5\xd2;\xd1\x9bh\xf3") || asm::asm_eventfired(asmname, "x\x9f}\x9fC\xc0\xc6\x15\xaaF\xc5\x83\x0ep\xd8z\xfc_");

      if(!battached) {
        self notify("\b\xa8\xf0\xb6\x1ae\xd6\xbe(\xf3Z\x9c");
        return;
      }

      if(battached && !bdetached) {
        if(asm::asm_eventfired(asmname, "\xc2Gt\xc2\x8d4\x01c\xd8K\a@\xd8Y3G")) {
          tagname = "r\xfc}\xb0\xfc>\xe2~\xf7\x80\xa0\xa2\xd2\xae\x0e}\xf8G";
        } else {
          tagname = "\xb9h\xc0\xfb\v\xf8\xd5\x12\xf9\xbd#\xb0:%.\x1e\xe4\xd75";
        }

        self detach(clipmodel, tagname);
        self notify("\xf43 [\x17\xb4XO\xa9b5\xcd\xcf");

        if(var_352bce8142e16507) {
          shared::showweaponmagattachment(weaponname);
        }
      }
    }
  }
}

function terminateexposedprone(asmname, statename, params) {
  self.pushable = 1;
}

function terminateexposedidleaimdown(asmname, statename, params) {
  self.aimingdown = 0;
}

function terminateexposedcrouchaimdown(asmname, statename, params) {
  self.aimingdown = 0;
}

function shouldfaceenemyinexposed() {
  if(isDefined(self.pathgoalpos)) {
    return false;
  }

  return isDefined(self.enemy) && isPlayer(self.enemy) && self cansee(self.enemy);
}

function playanim_weaponswitch(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  weapclass = asm_bb::bb_getrequestedweapon();
  animname = asm::asm_getanim(asmname, statename);
  animrate = combat_utility::fasteranimspeed();
  self aisetanim(statename, animname, animrate);
  asm::asm_playfacialanim(asmname, statename, asm::asm_getxanim(statename, animname));
  asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
  self notify("\x89\xdb\xb5\x119il\xfe\xcek\xb7n\x03\xc7\xd1\x84\xae\xb6T");
  gameskill::didsomethingotherthanshooting();
}

function terminate_weaponswitch(asmname, statename, params) {
  weapclass = weaponclass(self.weapon);
  shared::updateweaponarchetype(weapclass);
}

function playturnanim_turnanimanglefixup(turnxanim, statename) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  enemy = self.enemy;
  enemy endon("\x1e\xfd\xd1\xa2\a");
  animlength = getanimlength(turnxanim);

  if(animhasnotetrack(turnxanim, "\x93{\xdf\xe6\x03#\v-\xc7")) {
    finish_time = getnotetracktimes(turnxanim, "\x93{\xdf\xe6\x03#\v-\xc7");
    animlength *= finish_time[0];
  } else if(animhasnotetrack(turnxanim, "\xd7\xca\xae\xca\xff\xdb")) {
    finish_time = getnotetracktimes(turnxanim, "\xd7\xca\xae\xca\xff\xdb");
    animlength *= finish_time[0];
  }

  numframes = int(animlength * 20);
  remainingframes = numframes;

  while(remainingframes > 0) {
    lerpfraction = 1 / remainingframes;
    yawtoenemy = utility::getyawtospot(enemy.origin);
    self.stepoutyaw = angleclamp180(self.angles[1] + yawtoenemy);
    currentanimtime = self aigetanimtime(turnxanim);
    animyawdelta = getangledelta(turnxanim, currentanimtime, 1);
    remainingyaw = angleclamp180(yawtoenemy - animyawdelta);
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", angleclamp(self.angles[1] + remainingyaw * lerpfraction));
    remainingframes--;
    wait 0.05;
  }
}

function shouldsnaptocover_checktype(asmname, statename, tostatename, params) {
  if(asm_bb::bb_moverequested()) {
    return 0;
  }

  if(!utility::isatcovernode()) {
    return 0;
  }

  if(!isDefined(self.node)) {
    return 0;
  }

  if(isDefined(self.primaryweapon) && utility_common::isusingsidearm() && weaponclass(self.primaryweapon) != "\b5") {
    return 0;
  }

  assert(isDefined(params));
  return utility::isarrivaltype(asmname, statename, tostatename, params);
}

function reloadnotehandler(note) {
  self notify("\x90\xf2\x89T\x80{p\xde\x90\x9e\x99o");
  notetracks::notetrack_prefix_handler(note);
  return undefined;
}

function assesscleanup(asmname, statename, params) {
  self._blackboard.var_6ec57c69feb27c7e = 0;
}

function function_99c1fb715bb87c25(asmname, statename, tostatename, params) {
  if(!isDefined(self.assesslength)) {
    return true;
  }

  if(gettime() < self.assesslength) {
    return false;
  }

  return true;
}

function facegoalthread_newenemyreaction(statename, reactworldyaw) {
  self notify("\xd6\x7f\x14l\xcb\xe4\v\x8d\xbe\x8f\x80\xa0\xdci");
  self endon("\xd6\x7f\x14l\xcb\xe4\v\x8d\xbe\x8f\x80\xa0\xdci");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  while(true) {
    multiplier = 0.25;
    reactlocalyaw = angleclamp180(reactworldyaw - self.angles[1]);
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1] + reactlocalyaw * multiplier);
    waitframe();
  }
}

function handlefacegoalnotetrack_newenemyreaction(statename, note, lastknown) {
  assert(isDefined(lastknown));

  if(note == "6\x14\xc9`\xd1\xde\x80\x06\xc3") {
    metopos = lastknown - self.origin;
    reactworldyaw = vectortoyaw(metopos);
    thread facegoalthread_newenemyreaction(statename, reactworldyaw);
    return true;
  }

  return false;
}

function playanim_newenemyreaction(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  pushdisabledgunpose();
  reactanim = self asmgetanim(asmname, statename);
  assert(isDefined(reactanim));
  reactxanim = asm::asm_getxanim(statename, reactanim);
  self aisetanim(statename, reactanim);
  lastknown = self lastknownpos(self.enemy);
  thread playturnanim_turnanimanglefixup(reactxanim, statename);
  asm::asm_donotetrackswithinterceptor(asmname, statename, &handlefacegoalnotetrack_newenemyreaction, lastknown);

  if(isDefined(self.enemy) && self cansee(self.enemy)) {
    self.remainexposedendtime = gettime() + 2000;
  }
}

function chooseanim_playerpushed(asmname, statename, params) {
  movedir = asm::asm_getephemeraleventdata("v\xf2\xbd\r*\xb7A!Hz\xafC\xc4", "v\xf2\xbd\r*\xb7A!Hz\xafC\xc4");
  movedirnormalized = vectorNormalize(movedir);
  targetangles = vectortoangles(movedirnormalized);
  targetyaw = angleclamp180(targetangles[1] - self.angles[1]);
  angleindex = asm::yawdiffto2468(targetyaw);
  aliasname = "\xc1\xaenhY\xc8\xd7" + angleindex;
  turnanim = asm::asm_lookupanimfromalias(statename, aliasname);
  return turnanim;
}

function terminate_casualkiller(asmname, statename, params) {
  self setbasearchetype(self findoverridearchetype("\x91\xca\xcc\v\xab\xd8:"));
  self clearoverridearchetype("(\x15\xda\x106\xed_\x1a", 0, 1);
  self.newenemyreaction = 0;
  self.forcenewenemyreaction = 0;
  self notify("\xd8\xb2,\xb3\xac\xd0\x85\xcd]\x85ci\xb4\xd8c\x95\xc9");
  self.leavecasualkiller = 0;
  self.casualkiller = 0;
  self setdefaultaimlimits();
}

function pushdisabledgunpose() {
  if(isDefined(self.gunposeoverride)) {
    self.stashedgunposeoverride = self.gunposeoverride;
  }

  self.gunposeoverride = "\xf5!\x81\xa3\x97E\x8d";
}

function popdisabledgunpose() {
  if(isDefined(self.stashedgunposeoverride)) {
    self.gunposeoverride = self.stashedgunposeoverride;
    self.stashedgunposeoverride = undefined;
    return;
  }

  self.gunposeoverride = undefined;
}

function function_f54f5672acb1cea6(asmname, statename, params) {
  self function_2cb39b7074fc2ed(self.origin, self.angles);
  utility::loopanim(asmname, statename, params);
}

function function_ec1c1e857d104211(asmname, statename, tostatename, params) {
  if(istrue(self.var_8d7b5d5fb018d765)) {
    self setlookatenabled(1);
    utility::lookatentity(self.var_1872125457b741ad);
  }

  return asm::asm_lookupanimfromalias(statename, self.dodgedirection);
}

function function_f2851fbce6fc5425(asmname, statename, tostatename, params) {
  self setlookatenabled(0);
  self.var_458b2efcca003621 = 0;
  self.var_35eedc320be2d780 = 1;
}

function forwardpushevent(asmname, statename, tostatename, params) {
  movedir = asm::asm_geteventdata(asmname, "v\xf2\xbd\r*\xb7A!Hz\xafC\xc4");
  asm::asm_fireephemeralevent("v\xf2\xbd\r*\xb7A!Hz\xafC\xc4", "v\xf2\xbd\r*\xb7A!Hz\xafC\xc4", movedir);
}