/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3190.gsc
************************/

func_8E15(param_00, param_01, param_02, param_03) {
  if(param_00 == "remove_helmet") {
    if(self.helmetlocation == "head") {
      scripts\mp\agents\zombie_brute\zombie_brute_agent::func_BCBC();
      return;
    }

    return;
  }

  if(param_00 == "put_on_helmet") {
    if(self.helmetlocation == "hand") {
      scripts\mp\agents\zombie_brute\zombie_brute_agent::func_BCBD();
      return;
    }
  }
}

func_11809(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    self.zombiepiece unlink();
    self.zombiepiece delete();
    self.zombiepiece = undefined;
    var_04 = self gettagorigin("J_Wrist_ri");
    if(!isDefined(self.isnodeoccupied)) {
      return;
    }

    var_05 = self.isnodeoccupied.origin + (0, 0, 0);
    magicbullet("iw7_zombiepiece_mp", var_04, var_05, self);
  }
}

_meth_8485(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    if(isDefined(self.zombietograb) && !isDefined(self.zombiepiece) && isalive(self.zombietograb)) {
      self.zombietograb.full_gib = 1;
      self.zombietograb.nocorpse = 1;
      self.zombietograb.died_poorly = 1;
      self.zombietograb.deathmethod = "grabbed";
      self.zombietograb dodamage(self.zombietograb.health + -15536, self.origin);
      var_04 = self gettagorigin("J_Wrist_ri");
      var_05 = spawn("script_model", var_04);
      var_05 setModel("tag_origin");
      var_05 linkto(self, "J_Wrist_ri", (0, 0, 0), (0, 0, 0));
      self.zombiepiece = var_05;
    }
  }
}

func_116EF(param_00, param_01, param_02) {
  self.lastthrowtime = gettime();
  self.bwantrangeattack = 0;
  self.bdoingrangeattack = undefined;
}

func_D54C(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.bdoingrangeattack = 1;
  level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_toss", 1);
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

func_116EB(param_00, param_01, param_02) {
  self.zombietograb = undefined;
  self.zombiepiecetarget = undefined;
  self.bwanttograbzombie = undefined;
}

func_D48E(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.zombietograb = self.zombiepiecetarget;
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

func_D48D(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.zombietograb = self.zombiepiecetarget;
  var_04 = self.zombietograb.origin - self.origin;
  var_05 = vectornormalize(var_04);
  var_06 = vectortoangles(var_05);
  self orientmode("face angle abs", var_06);
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

func_1001D(param_00, param_01, param_02, param_03) {
  if(isDefined(self.zombiepiece)) {
    return 0;
  }

  if(!isDefined(self.zombiepiecetarget)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.bwanttograbzombie)) {
    return 1;
  }

  return 0;
}

func_100AC(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.zombiepiece) || !isDefined(self.bwantrangeattack)) {
    return 0;
  }

  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  if(self.helmetlocation == "hand") {
    return 0;
  }

  var_04 = anglesToForward(self.angles);
  var_05 = self.isnodeoccupied.origin - self.origin;
  var_05 = (var_05[0], var_05[1], 0);
  var_05 = vectornormalize(var_05);
  if(vectordot(var_04, var_05) < 0) {
    return 0;
  }

  return 1;
}

func_10055(param_00, param_01, param_02, param_03) {
  var_04 = sortbydistance(level.players, self.origin);
  var_05 = 0;
  for(var_06 = 0; var_06 < var_04.size; var_06++) {
    if(distancesquared(self.origin, var_04[var_06].origin) < -25536) {
      var_05++;
      continue;
    }

    break;
  }

  if(var_05 > 1) {
    return 1;
  }

  return randomint(100) < 50;
}

func_3EFA(param_00, param_01, param_02) {
  if(self.helmetlocation == "hand") {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "attack_slam_helmet");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "attack_slam");
}

func_D51C(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = self getsafecircleorigin(param_01, var_04);
  var_06 = getanimlength(var_05);
  var_07 = var_06 * 0.33;
  level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_ground_pound", 1);
  thread func_895D(var_07);
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

func_FFE2(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.bblockedbyfrozenzombies)) {
    return 1;
  }

  return 0;
}

func_895D(param_00) {
  self endon("death");
  wait(param_00);
  var_01 = scripts\asm\zombie\melee::get_melee_damage_dealt();
  self setscriptablepartstate("slam_blast", "active");
  foreach(var_03 in level.players) {
    if(isalive(var_03)) {
      if(distancesquared(self.origin, var_03.origin) < -25536) {
        scripts\asm\zombie\melee::domeleedamage(var_03, var_01, "MOD_IMPACT");
      }
    }
  }

  if(scripts\engine\utility::istrue(self.bblockedbyfrozenzombies)) {
    self.bblockedbyfrozenzombies = undefined;
    var_05 = scripts\mp\mp_agent::getactiveagentsoftype("all");
    foreach(var_07 in var_05) {
      if(var_07 == self) {
        continue;
      }

      if(!scripts\engine\utility::istrue(var_07.isfrozen)) {
        continue;
      }

      var_07 dodamage(var_07.health + 100, self.origin, undefined, undefined, "MOD_IMPACT");
    }
  }

  wait(0.25);
  self setscriptablepartstate("slam_blast", "inactive");
}

func_100A0(param_00, param_01, param_02, param_03) {
  return 0;
}

func_FFF1(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.blaserattack)) {
    return 1;
  }

  return 0;
}

func_10063(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.desiredhelmetlocation) || !isDefined(self.helmetlocation)) {
    return 0;
  }

  if(self.helmetlocation != self.desiredhelmetlocation && self.desiredhelmetlocation == "head") {
    return 1;
  }

  return 0;
}

shouldreloadwhilemoving(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.desiredhelmetlocation) || !isDefined(self.helmetlocation)) {
    return 0;
  }

  if(self.helmetlocation != self.desiredhelmetlocation && self.desiredhelmetlocation == "hand") {
    return 1;
  }

  return 0;
}

canseethroughfoliage(param_00, param_01, param_02, param_03) {
  return isDefined(self.isnodeoccupied) && self.helmetlocation == "head";
}

func_9E70(param_00, param_01, param_02, param_03) {
  return !scripts\engine\utility::istrue(self.blaserattack);
}

func_D4BB(param_00, param_01, param_02, param_03) {
  self.blaserattackstarted = 1;
  thread func_CD6C();
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

func_CD6C() {
  playFXOnTag(level._effect["vfx_zmb_brute_warn_01"], self, "tag_eye");
  level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_laser", 1);
}

func_58E5(param_00, param_01, param_02, param_03) {
  self.setplayerignoreradiusdamage = self.isnodeoccupied.origin + (0, 0, 40);
  self.doentitiessharehierarchy = undefined;
  thread func_8979(param_01);
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

func_116F8(param_00, param_01, param_02) {
  self.doentitiessharehierarchy = undefined;
  self.setplayerignoreradiusdamage = undefined;
  self.blaserattack = undefined;
  self.blaserattackstarted = undefined;
  self setscriptablepartstate("laser_flare", "inactive");
}

terminatelaserattackprep(param_00, param_01, param_02) {
  if(!func_1FB4(param_00, param_01, undefined, param_02)) {
    func_116F8(param_00, param_01, param_02);
  }
}

func_8979(param_00) {
  self endon(param_00 + "_finished");
  self setscriptablepartstate("laser_hint", "off");
  self setscriptablepartstate("laser_flare", "active");
  var_01 = getdvarint("scr_debugLaser", 0);
  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  var_02 = distance(self.origin, self.setplayerignoreradiusdamage);
  wait(0.2);
  var_03 = 8;
  for(var_04 = 0; var_04 < var_03; var_04++) {
    self shoot(1, undefined, 1, 1);
    wait(0.05);
  }

  if(var_01) {
    var_03 = 99999999;
  } else {
    var_03 = 60;
  }

  for(var_04 = 0; var_04 < var_03; var_04++) {
    if(isDefined(self.isnodeoccupied)) {
      var_05 = self.isnodeoccupied.origin + (0, 0, 40);
      var_06 = var_05 - self.setplayerignoreradiusdamage;
      var_07 = length(var_06);
      if(var_07 < 10) {
        self.setplayerignoreradiusdamage = var_05;
      } else {
        var_08 = vectornormalize(var_06);
        var_09 = var_08 * 200 * 0.05;
        self.setplayerignoreradiusdamage = self.setplayerignoreradiusdamage + var_09;
      }
    }

    self shoot(1, self.setplayerignoreradiusdamage, 1, 1);
    func_FF5C();
    wait(0.05);
  }

  self setscriptablepartstate("laser_flare", "inactive");
  self.setplayerignoreradiusdamage = undefined;
  self.doentitiessharehierarchy = self.isnodeoccupied;
  self.blaserattack = 0;
}

func_FF5C() {
  if(has_tag(self.model, "tag_flash")) {
    var_00 = anglesToForward(self gettagangles("tag_flash"));
    var_01 = var_00 * 1000;
    var_02 = self gettagorigin("tag_flash");
  } else {
    var_00 = anglesToForward(self gettagangles("tag_eye"));
    var_01 = var_02 * 1000;
    var_02 = self gettagorigin("tag_eye");
  }

  var_03 = bulletTrace(var_02, var_02 + var_01, 1, self, 0, 1);
  if(isDefined(var_03["entity"])) {
    var_04 = var_03["entity"];
    if(isDefined(var_04.agent_type) && var_04.agent_type == "generic_zombie" && !isDefined(var_04.flung)) {
      var_04 thread func_A869(self);
    }
  }
}

has_tag(param_00, param_01) {
  var_02 = getnumparts(param_00);
  for(var_03 = 0; var_03 < var_02; var_03++) {
    if(tolower(getpartname(param_00, var_03)) == tolower(param_01)) {
      return 1;
    }
  }

  return 0;
}

func_A869(param_00) {
  self endon("death");
  if(isDefined(self.marked_for_death)) {
    return;
  }

  var_01 = param_00.origin;
  var_02 = randomint(100);
  if(var_02 > 75) {
    self.marked_for_death = 1;
    self.do_immediate_ragdoll = 1;
    self.customdeath = 1;
    self.disable_armor = 1;
    self setvelocity(vectornormalize(self.origin - var_01) * 200 + (0, 0, 100));
    wait(0.1);
    self.died_poorly = 1;
    self dodamage(1000000, var_01, undefined, undefined, "MOD_UNKNOWN");
    return;
  }

  if(var_02 > 50) {
    self.marked_for_death = 1;
    thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
    wait(1);
    self.died_poorly = 1;
    self.marked_for_death = undefined;
    self dodamage(1000000, var_01, undefined, undefined, "MOD_UNKNOWN");
    return;
  }

  self.died_poorly = 1;
  self.marked_for_death = 1;
  self.nocorpse = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  playFX(level._effect["blackhole_trap_death"], self.origin + (0, 0, 40), anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  self dodamage(1000000, var_01, undefined, undefined, "MOD_UNKNOWN");
}

func_1FB4(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm::func_232B(param_01, "end");
}

func_CC1A(param_00, param_01) {
  self endon(param_01 + "_finished");
  self endon("death");
  wait(0.5);
  func_8E15("put_on_helmet");
}

func_E12C(param_00, param_01) {
  self endon(param_01 + "_finished");
  self endon("death");
  wait(0.5);
  func_8E15("remove_helmet");
}

func_D498(param_00, param_01, param_02, param_03) {
  self endon("death");
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
  func_8E15("put_on_helmet");
}

func_D499(param_00, param_01, param_02, param_03) {
  self endon("death");
  self setscriptablepartstate("eyes", "yellow_eyes");
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
  func_8E15("remove_helmet");
}

func_3EC3(param_00, param_01, param_02) {
  var_03 = self getanimentrycount(param_01);
  if(var_03 == 1) {
    return "helmet";
  }

  if(self.helmetlocation == "head") {
    return "helmet";
  }

  return "no_helmet";
}

func_3EC1(param_00, param_01, param_02) {
  var_03 = self getanimentrycount(param_01);
  if(var_03 == 1) {
    return 0;
  }

  return randomintrange(0, var_03);
}

func_3EC2(param_00, param_01, param_02) {
  var_03 = self getanimentrycount(param_01);
  if(var_03 == 1) {
    return "duck_run";
  }

  if(self.helmetlocation == "head") {
    return "duck_run";
  }

  return "sprint_run";
}

func_1003B(param_00, param_01, param_02, param_03) {
  var_04 = self _meth_855B("door", 300);
  if(isDefined(var_04)) {
    self.last_door_loc = var_04;
    return 1;
  }

  return 0;
}

func_D4E7(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

func_3EC0(param_00, param_01, param_02) {
  var_03 = self getanimentrycount(param_01);
  if(var_03 == 1) {
    return "helmet_on";
  }

  if(self.helmetlocation == "head") {
    return "helmet_on";
  }

  return "helmet_off";
}

func_FFEB(param_00, param_01, param_02, param_03) {
  return isDefined(self.croc_chomp) && self.croc_chomp;
}

func_3EC9(param_00, param_01, param_02) {
  var_03 = self getanimentrycount(param_01);
  if(var_03 == 1) {
    param_02 = param_02 + "_helmet";
  }

  if(self.helmetlocation == "head") {
    param_02 = param_02 + "_helmet";
  } else {
    param_02 = param_02 + "_no_helmet";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, param_02);
}