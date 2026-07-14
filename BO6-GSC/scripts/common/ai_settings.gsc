/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\ai_settings.gsc
******************************************/

#using scripts\common\values;
#using scripts\engine\utility;
#namespace ai_settings;

function function_8220aac0ff835653(var_cc2e2a48e773bcbe) {
  assert(isDefined(var_cc2e2a48e773bcbe));

  if(!(isDefined(level.aisettings_cache) && isDefined(level.aisettings_cache[var_cc2e2a48e773bcbe]))) {
    if(!isDefined(level.aisettings_cache)) {
      level.aisettings_cache = [];
    }

    level.aisettings_cache[var_cc2e2a48e773bcbe] = getscriptbundle(hashcat(%"hash_1971c5ddb7daaf2d", var_cc2e2a48e773bcbe));
  }

  settings = level.aisettings_cache[var_cc2e2a48e773bcbe];

  if(!isDefined(settings)) {
    return;
  }

  self.aisettings = settings;

  if(istrue(settings.var_cc173796bdad1394)) {
    self.var_666be0faaf0415dd = settings.perplayerweight;
    self.var_fc13768bb0e3ef3a = settings.var_beceaa5f145ef969;
  }

  if(istrue(settings.var_cb4d2dae97389ed6)) {
    self.radius = settings.radius;
    self.height = settings.height;
    self.goalradius = settings.goalradius;
    self.goalheight = settings.goalheight;
    self setbtgoalRadius(0, self.goalradius);
    self setbtgoalheight(0, self.goalheight);
    self function_693fb83317bbda04(settings.var_8682cd2e91a32856 ?? -1);
  } else {
    self.radius = 15;
    self.height = 72;
  }

  self setavoidanceradius(self.radius);

  if(isDefined(settings.navlayer)) {
    self setnavlayer(settings.navlayer);
  }

  if(istrue(settings.var_292f3359f7719c77)) {
    self aisetbounds(settings.boundsradius, settings.boundsheight, settings.boundszoffset);
  }

  if(isDefined(settings.var_f5d98ed7c5180d15)) {
    self.var_f5d98ed7c5180d15 = settings.var_f5d98ed7c5180d15;
  }

  if(istrue(settings.var_8cd729c202991ff1)) {
    val::set("x\x01<$\xbf\xbe\xb5!\xb8\x0eP", "|]Nf\xad\xb49W>O\xcfW\x91\x11\x99]\xa7\xf68,\xf1", 0);
  }

  self.kiastring = settings.kiastring;
  self.firstkillbattlechatter = settings.firstkillbattlechatter;

  if(istrue(settings.var_c2dbdb53a84fdeaf)) {
    self function_e15f282e60ad1131(settings.var_be59d324e19c4aef);
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

  if(isDefined(settings.var_851cb869a8e3b9af)) {
    self.var_533add912ad4b281 = squared(settings.var_851cb869a8e3b9af);
  }

  if(istrue(settings.disableexecutionvictim)) {
    val::set("k\xb6]E#\xcd\t\xce\x1f ", "/Z\xf4]&\x16\xc1\x9b7\x9d\x1a\xdb\xd9\x10\x81\x84", 0);
  }

  self.var_564278e3bd636b21 = istrue(settings.var_7af1cf447e0b4b74);

  if(true) {
    if(isDefined(settings.var_ee24769251f92df8) && settings.var_ee24769251f92df8 != "") {
      self function_f05169200cc4c5b3("\x1c\x9c\x03\x11=DK\xda\x1fZ;\xb7\a\xf3\"", "", settings.var_ee24769251f92df8);
    }

    if(isDefined(settings.var_4dff5f11cf5c2222) && settings.var_4dff5f11cf5c2222 != "") {
      self function_f05169200cc4c5b3("\x1c\x9c\x03\x11=DK\xda\x1fZ;\xb7\a\xf3\"", "\"\xdd\xea", settings.var_4dff5f11cf5c2222);
    }

    if(isDefined(settings.var_df70761ec4a84ede) && settings.var_df70761ec4a84ede != "") {
      self function_f05169200cc4c5b3("\x1c\x9c\x03\x11=DK\xda\x1fZ;\xb7\a\xf3\"", "\xa8\n\x1f\xff\xc0\x06\x98\x12\b\xec", settings.var_df70761ec4a84ede);
    }

    if(isDefined(settings.var_113e59ec706b50a6) && settings.var_113e59ec706b50a6 != "") {
      self function_f05169200cc4c5b3("\x1c\x9c\x03\x11=DK\xda\x1fZ;\xb7\a\xf3\"", "b\xff\x90\xcd\x98\xec!5\xbd", settings.var_113e59ec706b50a6);
    }

    if(isDefined(settings.lookatspecname) && settings.lookatspecname != "") {
      self.lookatspecname_default = settings.lookatspecname;
    }
  }

  if(istrue(settings.var_f41e60b16b9886cc)) {
    dvaroverride = getdvarfloat(@ "hash_82918fe00f512e83", -1);
    lookaheadvalue = settings.lookaheadtime;

    if(dvaroverride >= 0) {
      lookaheadvalue = dvaroverride;
    }

    self function_5a3e84d74617aba5(lookaheadvalue);
  }

  thread function_b9291ca7bc54d97a();
}

function private function_b9291ca7bc54d97a() {
  self endon("\x1e\xfd\xd1\xa2\a");
  waitframe();
  archetype = self getbasearchetype();
  flag_name = archetype + "5\x1f7\xf6\x02";

  if(utility::flag(flag_name)) {
    return;
  }

  utility::flag_set(flag_name);
}