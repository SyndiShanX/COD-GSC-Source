/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3190.gsc
*********************************************/

func_8E15(var_0, var_1, var_2, var_3) {
  if(var_0 == "remove_helmet") {
    if(self.helmetlocation == "head") {
      scripts\mp\agents\zombie_brute\zombie_brute_agent::func_BCBC();
      return;
    }

    return;
  }

  if(var_0 == "put_on_helmet") {
    if(self.helmetlocation == "hand") {
      scripts\mp\agents\zombie_brute\zombie_brute_agent::func_BCBD();
      return;
    }
  }
}

func_11809(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    self.zombiepiece unlink();
    self.zombiepiece delete();
    self.zombiepiece = undefined;
    var_4 = self gettagorigin("J_Wrist_ri");
    if(!isDefined(self.isnodeoccupied)) {
      return;
    }

    var_5 = self.isnodeoccupied.origin + (0, 0, 0);
    magicbullet("iw7_zombiepiece_mp", var_4, var_5, self);
  }
}

func_8485(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    if(isDefined(self.zombietograb) && !isDefined(self.zombiepiece) && isalive(self.zombietograb)) {
      self.zombietograb.full_gib = 1;
      self.zombietograb.nocorpse = 1;
      self.zombietograb.died_poorly = 1;
      self.zombietograb.deathmethod = "grabbed";
      self.zombietograb dodamage(self.zombietograb.health + -15536, self.origin);
      var_4 = self gettagorigin("J_Wrist_ri");
      var_5 = spawn("script_model", var_4);
      var_5 setModel("tag_origin");
      var_5 linkto(self, "J_Wrist_ri", (0, 0, 0), (0, 0, 0));
      self.zombiepiece = var_5;
    }
  }
}

func_116EF(var_0, var_1, var_2) {
  self.lastthrowtime = gettime();
  self.bwantrangeattack = 0;
  self.bdoingrangeattack = undefined;
}

func_D54C(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.bdoingrangeattack = 1;
  level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_toss", 1);
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

func_116EB(var_0, var_1, var_2) {
  self.zombietograb = undefined;
  self.zombiepiecetarget = undefined;
  self.bwanttograbzombie = undefined;
}

func_D48E(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.zombietograb = self.zombiepiecetarget;
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

func_D48D(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.zombietograb = self.zombiepiecetarget;
  var_4 = self.zombietograb.origin - self.origin;
  var_5 = vectornormalize(var_4);
  var_6 = vectortoangles(var_5);
  self orientmode("face angle abs", var_6);
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

func_1001D(var_0, var_1, var_2, var_3) {
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

func_100AC(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.zombiepiece) || !isDefined(self.bwantrangeattack)) {
    return 0;
  }

  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  if(self.helmetlocation == "hand") {
    return 0;
  }

  var_4 = anglesToForward(self.angles);
  var_5 = self.isnodeoccupied.origin - self.origin;
  var_5 = (var_5[0], var_5[1], 0);
  var_5 = vectornormalize(var_5);
  if(vectordot(var_4, var_5) < 0) {
    return 0;
  }

  return 1;
}

func_10055(var_0, var_1, var_2, var_3) {
  var_4 = sortbydistance(level.players, self.origin);
  var_5 = 0;
  for(var_6 = 0; var_6 < var_4.size; var_6++) {
    if(distancesquared(self.origin, var_4[var_6].origin) < -25536) {
      var_5++;
      continue;
    }

    break;
  }

  if(var_5 > 1) {
    return 1;
  }

  return randomint(100) < 50;
}

func_3EFA(var_0, var_1, var_2) {
  if(self.helmetlocation == "hand") {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "attack_slam_helmet");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "attack_slam");
}

func_D51C(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self getsafecircleorigin(var_1, var_4);
  var_6 = getanimlength(var_5);
  var_7 = var_6 * 0.33;
  level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_ground_pound", 1);
  thread func_895D(var_7);
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

func_FFE2(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.bblockedbyfrozenzombies)) {
    return 1;
  }

  return 0;
}

func_895D(var_0) {
  self endon("death");
  wait(var_0);
  var_1 = scripts\asm\zombie\melee::get_melee_damage_dealt();
  self setscriptablepartstate("slam_blast", "active");
  foreach(var_3 in level.players) {
    if(isalive(var_3)) {
      if(distancesquared(self.origin, var_3.origin) < -25536) {
        scripts\asm\zombie\melee::domeleedamage(var_3, var_1, "MOD_IMPACT");
      }
    }
  }

  if(scripts\engine\utility::istrue(self.bblockedbyfrozenzombies)) {
    self.bblockedbyfrozenzombies = undefined;
    var_5 = scripts\mp\mp_agent::getactiveagentsoftype("all");
    foreach(var_7 in var_5) {
      if(var_7 == self) {
        continue;
      }

      if(!scripts\engine\utility::istrue(var_7.isfrozen)) {
        continue;
      }

      var_7 dodamage(var_7.health + 100, self.origin, undefined, undefined, "MOD_IMPACT");
    }
  }

  wait(0.25);
  self setscriptablepartstate("slam_blast", "inactive");
}

func_100A0(var_0, var_1, var_2, var_3) {
  return 0;
}

func_FFF1(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.blaserattack)) {
    return 1;
  }

  return 0;
}

func_10063(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.desiredhelmetlocation) || !isDefined(self.helmetlocation)) {
    return 0;
  }

  if(self.helmetlocation != self.desiredhelmetlocation && self.desiredhelmetlocation == "head") {
    return 1;
  }

  return 0;
}

shouldreloadwhilemoving(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.desiredhelmetlocation) || !isDefined(self.helmetlocation)) {
    return 0;
  }

  if(self.helmetlocation != self.desiredhelmetlocation && self.desiredhelmetlocation == "hand") {
    return 1;
  }

  return 0;
}

canseethroughfoliage(var_0, var_1, var_2, var_3) {
  return isDefined(self.isnodeoccupied) && self.helmetlocation == "head";
}

func_9E70(var_0, var_1, var_2, var_3) {
  return !scripts\engine\utility::istrue(self.blaserattack);
}

func_D4BB(var_0, var_1, var_2, var_3) {
  self.blaserattackstarted = 1;
  thread func_CD6C();
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

func_CD6C() {
  playFXOnTag(level._effect["vfx_zmb_brute_warn_01"], self, "tag_eye");
  level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_laser", 1);
}

func_58E5(var_0, var_1, var_2, var_3) {
  self.setplayerignoreradiusdamage = self.isnodeoccupied.origin + (0, 0, 40);
  self.doentitiessharehierarchy = undefined;
  thread func_8979(var_1);
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

func_116F8(var_0, var_1, var_2) {
  self.doentitiessharehierarchy = undefined;
  self.setplayerignoreradiusdamage = undefined;
  self.blaserattack = undefined;
  self.blaserattackstarted = undefined;
  self setscriptablepartstate("laser_flare", "inactive");
}

terminatelaserattackprep(var_0, var_1, var_2) {
  if(!func_1FB4(var_0, var_1, undefined, var_2)) {
    func_116F8(var_0, var_1, var_2);
  }
}

func_8979(var_0) {
  self endon(var_0 + "_finished");
  self setscriptablepartstate("laser_hint", "off");
  self setscriptablepartstate("laser_flare", "active");
  var_1 = getdvarint("scr_debugLaser", 0);
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = distance(self.origin, self.setplayerignoreradiusdamage);
  wait(0.2);
  var_3 = 8;
  for(var_4 = 0; var_4 < var_3; var_4++) {
    self shoot(1, undefined, 1, 1);
    wait(0.05);
  }

  if(var_1) {
    var_3 = 99999999;
  } else {
    var_3 = 60;
  }

  for(var_4 = 0; var_4 < var_3; var_4++) {
    if(isDefined(self.isnodeoccupied)) {
      var_5 = self.isnodeoccupied.origin + (0, 0, 40);
      var_6 = var_5 - self.setplayerignoreradiusdamage;
      var_7 = length(var_6);
      if(var_7 < 10) {
        self.setplayerignoreradiusdamage = var_5;
      } else {
        var_8 = vectornormalize(var_6);
        var_9 = var_8 * 200 * 0.05;
        self.setplayerignoreradiusdamage = self.setplayerignoreradiusdamage + var_9;
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
    var_0 = anglesToForward(self gettagangles("tag_flash"));
    var_1 = var_0 * 1000;
    var_2 = self gettagorigin("tag_flash");
  } else {
    var_0 = anglesToForward(self gettagangles("tag_eye"));
    var_1 = var_2 * 1000;
    var_2 = self gettagorigin("tag_eye");
  }

  var_3 = bulletTrace(var_2, var_2 + var_1, 1, self, 0, 1);
  if(isDefined(var_3["entity"])) {
    var_4 = var_3["entity"];
    if(isDefined(var_4.agent_type) && var_4.agent_type == "generic_zombie" && !isDefined(var_4.flung)) {
      var_4 thread func_A869(self);
    }
  }
}

has_tag(var_0, var_1) {
  var_2 = getnumparts(var_0);
  for(var_3 = 0; var_3 < var_2; var_3++) {
    if(tolower(getpartname(var_0, var_3)) == tolower(var_1)) {
      return 1;
    }
  }

  return 0;
}

func_A869(var_0) {
  self endon("death");
  if(isDefined(self.marked_for_death)) {
    return;
  }

  var_1 = var_0.origin;
  var_2 = randomint(100);
  if(var_2 > 75) {
    self.marked_for_death = 1;
    self.do_immediate_ragdoll = 1;
    self.customdeath = 1;
    self.disable_armor = 1;
    self setvelocity(vectornormalize(self.origin - var_1) * 200 + (0, 0, 100));
    wait(0.1);
    self.died_poorly = 1;
    self dodamage(1000000, var_1, undefined, undefined, "MOD_UNKNOWN");
    return;
  }

  if(var_2 > 50) {
    self.marked_for_death = 1;
    thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
    wait(1);
    self.died_poorly = 1;
    self.marked_for_death = undefined;
    self dodamage(1000000, var_1, undefined, undefined, "MOD_UNKNOWN");
    return;
  }

  self.died_poorly = 1;
  self.marked_for_death = 1;
  self.nocorpse = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  playFX(level._effect["blackhole_trap_death"], self.origin + (0, 0, 40), anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  self dodamage(1000000, var_1, undefined, undefined, "MOD_UNKNOWN");
}

func_1FB4(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::func_232B(var_1, "end");
}

func_CC1A(var_0, var_1) {
  self endon(var_1 + "_finished");
  self endon("death");
  wait(0.5);
  func_8E15("put_on_helmet");
}

func_E12C(var_0, var_1) {
  self endon(var_1 + "_finished");
  self endon("death");
  wait(0.5);
  func_8E15("remove_helmet");
}

func_D498(var_0, var_1, var_2, var_3) {
  self endon("death");
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
  func_8E15("put_on_helmet");
}

func_D499(var_0, var_1, var_2, var_3) {
  self endon("death");
  self setscriptablepartstate("eyes", "yellow_eyes");
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
  func_8E15("remove_helmet");
}

func_3EC3(var_0, var_1, var_2) {
  var_3 = self getanimentrycount(var_1);
  if(var_3 == 1) {
    return "helmet";
  }

  if(self.helmetlocation == "head") {
    return "helmet";
  }

  return "no_helmet";
}

func_3EC1(var_0, var_1, var_2) {
  var_3 = self getanimentrycount(var_1);
  if(var_3 == 1) {
    return 0;
  }

  return randomintrange(0, var_3);
}

func_3EC2(var_0, var_1, var_2) {
  var_3 = self getanimentrycount(var_1);
  if(var_3 == 1) {
    return "duck_run";
  }

  if(self.helmetlocation == "head") {
    return "duck_run";
  }

  return "sprint_run";
}

func_1003B(var_0, var_1, var_2, var_3) {
  var_4 = self func_855B("door", 300);
  if(isDefined(var_4)) {
    self.last_door_loc = var_4;
    return 1;
  }

  return 0;
}

func_D4E7(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

func_3EC0(var_0, var_1, var_2) {
  var_3 = self getanimentrycount(var_1);
  if(var_3 == 1) {
    return "helmet_on";
  }

  if(self.helmetlocation == "head") {
    return "helmet_on";
  }

  return "helmet_off";
}

func_FFEB(var_0, var_1, var_2, var_3) {
  return isDefined(self.croc_chomp) && self.croc_chomp;
}

func_3EC9(var_0, var_1, var_2) {
  var_3 = self getanimentrycount(var_1);
  if(var_3 == 1) {
    var_2 = var_2 + "_helmet";
  }

  if(self.helmetlocation == "head") {
    var_2 = var_2 + "_helmet";
  } else {
    var_2 = var_2 + "_no_helmet";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
}