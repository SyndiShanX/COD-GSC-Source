/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3badb8914eb5ac16.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_2ece06910a5c572;
#using script_38c251115537f16e;
#using script_595089f78ef8e11b;
#using script_686729055b66c6e4;
#using script_7edf952f8921aa6b;
#using script_a12e958c96b6c57;
#using scripts\aitypes\stealth;
#using scripts\asm\shared\death;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\values;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#namespace zombie_init;

function private autoexec main() {
  callback::get_template("zombie") callback::add("shockStick_agentApplyHaywire", &function_c4e2f024dbf10aad);
  callback::get_template("zombie") callback::add("shockStick_agentClearHaywire", &function_4f386f6608ed39a8);

  level thread function_b7388b6432ebeb4e();
}

function zombie_init_ai(var_f76baeb1c3556fab) {
  assert(isDefined(var_f76baeb1c3556fab));
  self.on_zombie_agent_killed_common = &on_ai_killed;

  if(!isDefined(level.zombieaisettings_cache) || !isDefined(level.zombieaisettings_cache[var_f76baeb1c3556fab])) {
    level.zombieaisettings_cache = default_to(level.zombieaisettings_cache, []);
    level.zombieaisettings_cache[var_f76baeb1c3556fab] = getscriptbundle(hashcat(%"zombieaisettings:", var_f76baeb1c3556fab));
  }

  settings = level.zombieaisettings_cache[var_f76baeb1c3556fab];
  self.zombieaisettings = settings;
  self.var_157e0150178595f2 = 1;
  self.enablespreading = settings.enablespreading;

  if(istrue(settings.enablebite)) {
    namespace_dd3b3452f1580da6::function_dca79eb8ca59cd89(undefined, settings.biterange);
    self.enablebite = 1;
  }

  if(istrue(settings.enablemelee)) {
    namespace_f025828c76741718::function_e700d8944532443d(settings.meleedamage, settings.meleerange, settings.var_a98faeef4a48e76, settings.var_f42bfa0e947d5b2b, settings.var_658057c64a5cf3f1, settings.meleeknockbackstrength, settings.var_a18e13a8f1d43f20);
    self.enablemelee = 1;
    self._blackboard.var_6b125300f4941ee8 = settings.var_289be7ed6a138df8;
    self._blackboard.var_6b93b99c8b1c38c2 = int(settings.var_333751673b2281dc);
  }

  if(istrue(settings.var_ffe6545012b26f)) {
    self._blackboard.var_285a93cddadff26a = settings.var_23731ac359988186;
    self._blackboard.var_8d29cdf5f3f3dd2c = settings.var_8d29cdf5f3f3dd2c;
    self._blackboard.var_fbb461f12b47eaa3 = settings.var_fbb461f12b47eaa3;
  }

  if(istrue(settings.var_a558a0b6b24bd680)) {
    self._blackboard.var_c406031fea1f3214 = settings.leapattackdamage;
    self._blackboard.var_90c1960e1413e514 = settings.var_68efc88ffa0aa2c2;
    self._blackboard.var_3596895c47e7f375 = gettime();
    self._blackboard.var_675726a12915960f = settings.var_b9a7a1856c211959;
  }

  if(istrue(settings.var_e71dc301c2240f6)) {
    namespace_d30035ccbf6888e3::register_emergence_spawning_settings(settings.var_d1ded916cc30d50c, settings.var_4f4c7fe3debb81dd);
  }

  self.turnanimsenabled = istrue(settings.turnanimsenabled);

  if(istrue(self.turnanimsenabled)) {
    self.var_d0ede1e06e380f47 = default_to(settings.var_d0ede1e06e380f47, 0);
    self.var_6fddf68ea9876757 = default_to(settings.var_6fddf68ea9876757, 0);
  }

  function_f1810da227cb50f9();
  self.fnisinstealthidle = &function_eb16af28fcfa61a9;
  self.fnisinstealthinvestigate = &function_eb16af28fcfa61a9;
  self.fnisinstealthhunt = &function_eb16af28fcfa61a9;
  self.fnisinstealthcombat = &function_eb16af28fcfa61a9;
  self.lookfordoorsalongpath = 1;
  self.pathenemyfightdist = 0;
  self.var_6c18812ecbd3b6ae = 0;

  if(issharedfuncdefined("game", "roundNumberDifficulty")) {
    self.difficulty_round = namespace_53fc9ddbb516e6e1::function_560b2e700ce084a2(self.origin);
  } else {
    self.difficulty_round = 1;
  }

  self._blackboard.difficultyround = self.difficulty_round;
  self.basehealth = self.health;
  self.maxhealth = self.health;

  if(isDefined(settings.healthscriptbundle)) {
    newmaxhealth = function_2611d163b331ae1d(settings.healthscriptbundle, self.difficulty_round);

    if(isDefined(newmaxhealth) && newmaxhealth > 0) {
      self.maxhealth = newmaxhealth;

      if(is_equal(self.subclass, "zombie_base")) {
        level.var_a37eac8a0d4242d9 = newmaxhealth;
      }
    }
  }

  self.health = self.maxhealth;
  self.var_878a9f80b05effb = settings.var_878a9f80b05effb;

  if(istrue(settings.var_c1410214e7e4f2d3)) {
    self allowvehiclepredictiveragdoll(0);
  }

  self.var_20ab3a006aa7fc64 = 1;
  self.var_21a8839dd03e31cd = [];
  self.aicategory = settings.aicategory;
  assert(self.type == "<dev string:x1c>");
  self setcanusecover(0, "entity");
  self._blackboard.zombiewanderorigin = self.origin;
  self._blackboard.var_2ad5368672cc47ba = default_to(settings.maxwanderradius, 0);
  self._blackboard.var_2af8408672f2a570 = default_to(settings.minwanderradius, 0);
  self._blackboard.zombieusewanderscripted = istrue(settings.usewanderscripted);
  self._blackboard.var_1766d5cccf9b5670 = default_to(settings.tetherrange, 0);
  self._blackboard.var_563d0f6368b6e3f3 = 200;

  if(isDefined(level.gamemodebundle)) {
    self._blackboard.var_563d0f6368b6e3f3 = level.gamemodebundle.var_563d0f6368b6e3f3;

    if(!istrue(level.gamemodebundle.var_5a9f2dd6fa225e4c)) {
      self._blackboard.var_1766d5cccf9b5670 = 0;
    }
  }

  if(self._blackboard.var_1766d5cccf9b5670 > 0) {
    thread function_f23a7666ab0620e5();
  }

  if(isDefined(settings.elementalweakness) && settings.elementalweakness.size > 0) {
    foreach(weakness in settings.elementalweakness) {
      self.elementalweakness[weakness.elementtype] = 1;
    }
  }

  if(isDefined(self.zombieaisettings.var_fef5d84db3c8e7f7)) {
    self.zombieaisettings.var_e58a65b7a8f5973c = getscriptbundle(self.zombieaisettings.var_fef5d84db3c8e7f7);
  }

  self.paincooldown = 2500;
  self.fnshouldplaypainanim = &function_c9fd82b2c8668e86;

  if(isDefined(self) && !isDefined(self.spawn_time)) {
    self.spawn_time = gettime();
  }

  if(isDefined(self.zombieaisettings.metabones)) {
    init_metabones(self.zombieaisettings.metabones);
  }

  function_afb445939fe4c1a4();
  self.var_e4f619e19ea53346 = self.zombieaisettings.var_4e3307a692b95a11;
  self function_8bbcaeb23a1512ef("all", 0);
  scripts\aitypes\stealth::initstealthfunctions();
  self.var_f36134ba18a9ef26 = 1;
  self.var_19fc729841f5b170 = 0;
  self.var_7a35ca824ce166e3 = 1;

  if(!istrue(self.zombieaisettings.var_f6fe19952d45625e)) {
    self.collide_with_ai_allies = 0;
  }

  if(!istrue(self.zombieaisettings.var_e39c9bda85ea5d4e)) {
    self.var_afaeba29498ad423 = 0;
  }

  thread update_pushable();
  self.collide_with_ai = 1;
  self.script_pushable = 1;
  self.nododgemove = 1;

  if(istrue(self.zombieaisettings.var_7410c30336739540)) {
    self.var_7e3144ab69fefa03 = 1;

    if(istrue(self.zombieaisettings.var_204e8fd8424a6542)) {
      self.var_46ff71d1aa27d2ed = 1;
    }
  }

  self._blackboard.var_a401770f34af5de3 = 1;
  self._blackboard.var_115c06f1deba1f35 = 256;
  thread function_3d6406924924fc14();
  self.var_274d3a7704e351ef = 1;

  thread function_fc40130ab04a7929();
}

function function_a343ac31ca854535(var_76525769b6e49a6c) {
  assert(isDefined(self.asm));
  assert(isDefined(self.zombieaisettings));
  settings = self.zombieaisettings;
  self.animname = self.animsetname;
  function_f155779fe50a7b53(settings, var_76525769b6e49a6c);

  if(istrue(settings.enablemelee)) {
    foreach(pair in settings.speedthreshold_list) {
      if(!isDefined(pair.movetype)) {
        continue;
      }

      namespace_f025828c76741718::function_1fc0eb1eb90c8dd0(pair.movetype, pair.var_73e6922977cd2c06);
    }
  }
}

function private function_3d6406924924fc14() {
  self endon("death");
  ent_flag_wait_or_timeout("zombie_asm_init_finished", 1);
  assertex(istrue(ent_flag("<dev string:x26>")), "<dev string:x42>");
  callback::callback("on_" + self.subclass + "_spawned");
  callback::callback("on_zombie_ai_spawned");
}

function private function_f155779fe50a7b53(settings, var_76525769b6e49a6c) {
  archetype = self.animsetname;
  flag_name = archetype + "_init_asm";

  if(flag(flag_name)) {
    return;
  }

  flag_set(flag_name);

  if(isDefined(var_76525769b6e49a6c)) {
    self[[var_76525769b6e49a6c]]();
  }

  foreach(pair in settings.speedthreshold_list) {
    if(!isDefined(pair.movetype)) {
      continue;
    }

    assert(isstring(pair.movetype));
    setspeedthreshold(archetype, pair.movetype, int(pair.speedthreshold));
  }
}

function private on_ai_killed(einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, dropweapons) {
  params_struct = spawnStruct();
  params_struct.einflictor = einflictor;
  params_struct.eattacker = eattacker;
  params_struct.idamage = idamage;
  params_struct.smeansofdeath = smeansofdeath;
  params_struct.objweapon = objweapon;
  params_struct.vdir = vdir;
  params_struct.shitloc = shitloc;
  params_struct.timeoffset = timeoffset;
  params_struct.deathanimduration = deathanimduration;
  params_struct.dropweapons = dropweapons;
  params_struct.origin = self.origin;
  params_struct.var_a9cfabe3e558f7fa = self.var_a9cfabe3e558f7fa;
  callback::callback("on_zombie_ai_killed", params_struct);

  if(istrue(self._blackboard.zombieindespawn)) {
    if(istrue(self.magic_bullet_shield)) {
      scripts\common\ai::stop_magic_bullet_shield();
    }

    self.var_7e4b076a06c6df27 = 1;
  }

  onhumanoidagentkilledcommon_sharedfunc(einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, 0);
  deathcleanup();
}

function private function_eb16af28fcfa61a9() {
  return false;
}

function private function_c9fd82b2c8668e86() {
  if(!istrue(self.allowpain)) {
    return false;
  }

  return true;
}

function private function_3977ea1fbdfbb591() {
  var_7689e7ce29ebbc55 = !self codemoverequested();

  if(!is_equal(self.doavoidanceblocking, var_7689e7ce29ebbc55)) {
    self.doavoidanceblocking = var_7689e7ce29ebbc55;
  }
}

function private update_pushable() {
  self endon("death");

  if(!isDefined(level.var_e03e96f937e81fce)) {
    level.var_e03e96f937e81fce = throttle_initialize("pushable", 1, level.framedurationseconds);
  }

  var_970684f6072a6d63 = 200;

  while(true) {
    function_f632348cbb773537(level.var_e03e96f937e81fce, self);
    function_3977ea1fbdfbb591();
    waitframe();
  }
}

function private function_c4e2f024dbf10aad(params) {
  if(istrue(params.firstshock) || istrue(params.newshockstick)) {
    stun_delay = randomfloat(0.4);
    wait stun_delay;
    stun_ai(5);
  }
}

function private function_4f386f6608ed39a8(params) {
  clear_stun();
}

function private function_f23a7666ab0620e5() {
  self endon("death");

  while(true) {
    self waittill("tether_start");
    var_9970ea6c689d6247 = self.zombieaisettings.speedthreshold_list[self.zombieaisettings.speedthreshold_list.size - 1].movetype;
    function_f1e5805da192a1ef(var_9970ea6c689d6247, "tether", 4);
    thread tether_heal();
    self waittill("tether_end");
    function_f1e5805da192a1ef(undefined, "tether", 4);
  }
}

function private tether_heal() {
  self endon("death");
  self endon("tether_end");
  var_8552285ba07a269f = min(self.maxhealth, self.health + self.maxhealth * 0.25);
  var_3d5f8437bc8dcc9f = 0.07;

  while(true) {
    var_ecb9a1ffec52e528 = int(clamp(self.maxhealth * var_3d5f8437bc8dcc9f, 0, var_8552285ba07a269f - self.health));
    self.health += var_ecb9a1ffec52e528;
    wait 1;
  }
}

function private function_fc40130ab04a7929() {
  setdvarifuninitialized(@ "hash_d95010ddcdec6c36", 1);
  setdvarifuninitialized(@ "hash_3e9837d038eef96f", 1);

  if(getdvarint(@ "hash_d95010ddcdec6c36", 1) <= 0) {
    self._blackboard.var_2ad5368672cc47ba = -1;
    self._blackboard.zombiewanderorigin = self.origin;
  }

  if(getdvarint(@ "hash_3e9837d038eef96f", 1) <= 0) {
    val::set("<dev string:x8c>", "<dev string:xa1>", 0);
  }
}

function private function_b7388b6432ebeb4e() {
  waitframe();

  if(isDefined(level.agent_definition)) {
    foreach(type, def in level.agent_definition) {
      if(issubstr(type, "<dev string:xa9>")) {
        assertmsg("<dev string:xb8>" + type + "<dev string:x127>");
      }
    }
  }
}

# /