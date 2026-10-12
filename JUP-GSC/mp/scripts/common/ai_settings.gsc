/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\ai_settings.gsc
***********************************************/

#using scripts\common\values;
#using scripts\engine\utility;
#namespace ai_settings;

function function_7b25d1c42e7f75be(var_f76baeb1c3556fab) {
  assert(isDefined(var_f76baeb1c3556fab));

  if(!isDefined(level.aisettings_cache) || !isDefined(level.aisettings_cache[var_f76baeb1c3556fab])) {
    level.aisettings_cache = default_to(level.aisettings_cache, []);
    level.aisettings_cache[var_f76baeb1c3556fab] = getscriptbundle(hashcat(%"hash_1971c5ddb7daaf2d", var_f76baeb1c3556fab));
  }

  settings = level.aisettings_cache[var_f76baeb1c3556fab];

  if(!isDefined(settings)) {
    return;
  }

  self.aisettings = settings;

  if(istrue(settings.var_90936cd2d6771517)) {
    self.radius = settings.radius;
    self.height = settings.height;
    self.goalradius = settings.goalradius;
    self.goalheight = settings.goalheight;
    self setbtgoalRadius(0, self.goalradius);
    self setbtgoalheight(0, self.goalheight);
    self function_f5f3a2cbee59e221(default_to(settings.var_6510edfacf0baeaf, -1));
  } else {
    self.radius = 15;
    self.height = 72;
  }

  if(istrue(settings.var_2b682716d65beee)) {
    self aisetbounds(settings.boundsradius, settings.boundsheight);
  }

  self.kiastring = settings.kiastring;

  if(istrue(settings.var_51a535c2510cde8a)) {
    self function_d493e7fe15e5eaf4(settings.var_4975344f645984a6);
  }

  if(isDefined(settings.footstepdetectdist)) {
    self.footstepdetectdist = settings.footstepdetectdist;
  }

  if(isDefined(settings.footstepdetectdistwalk)) {
    self.footstepdetectdistwalk = settings.footstepdetectdistwalk;
  }

  if(isDefined(settings.footstepdetectdistsprint)) {
    self.footstepdetectdistsprint = settings.footstepdetectdistsprint;
  }

  if(isDefined(settings.var_16c1b4215fff2552)) {
    self.var_2a3d62043c219dc4 = squared(settings.var_16c1b4215fff2552);
  }

  if(istrue(settings.disableexecutionvictim)) {
    val::set("aiSettings", "execution_victim", 0);
  }

  if(istrue(settings.supporthealthbar)) {
    self.var_1e0eb63ecb3f1e2 = 1;
  }

  if(istrue(settings.supportnameplate)) {
    self.var_9f009877c3bea958 = 1;
  }

  if(istrue(settings.var_19d949438b5d19)) {
    dvaroverride = getdvarfloat(@ "hash_82918fe00f512e83", -1);
    lookaheadvalue = settings.lookaheadtime;

    if(dvaroverride >= 0) {
      lookaheadvalue = dvaroverride;
    }

    self function_4956d2ecae01f73c(lookaheadvalue);
  }

  self.var_83f781810081eef8 = istrue(settings.var_e4e004eb4bd09291);
  thread function_20a25f54c4f809ca();
}

function private function_20a25f54c4f809ca() {
  self endon("death");
  waitframe();
  archetype = self getbasearchetype();
  flag_name = archetype + "_init";

  if(flag(flag_name)) {
    return;
  }

  flag_set(flag_name);
}