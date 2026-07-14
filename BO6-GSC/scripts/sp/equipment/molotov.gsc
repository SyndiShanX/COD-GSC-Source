/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\molotov.gsc
********************************************/

#using scripts\common\ai;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\nvg\nvg_ai;
#using scripts\sp\trigger;
#using scripts\sp\utility;
#namespace molotov;

function private autoexec initmolotov() {
  offhands::registerprecachefunc("\xb6\xbdc\xf6Gov", &precache);
}

function precache(offhand) {
  level.g_effect["s\x82\b\xc9\x17=\x0eq*\xb0\x98\xa2\xfd\xac\at\xb3"] = loadfxasset("\xe9^iu\xf2\xa9\xff\x93V\xb2\x18zp\xb0\x88\xc2E\xf3\xfc\xb0 \xc1\tJ\xa3\x7f");
  level.g_effect["[\xf6\xd8\xf6t\xedv\xd7\xb2x8\xb1\xde\xdc-\xb7s}\x8d\rKlF"] = loadfxasset("\xd6]\tqi\x01\xbd-g~\xd8\xe5\xa1o\x01\x1a\xad\xc5\x9f\xbbV\xef\x9c\x8e0\xdd\xb1x\xa0\x81\xe1\r");
  level.g_effect["M1\a\x10\xca\x95\x91\x9c\x15R\x9a@\x907\xd4\xc5\xbd"] = loadfxasset("\xefg\xda \xc4\x06\xffH4zhmaL\x8f\xb3\x1d_]\x9c\xfb4\xf1I+\x9cT~Me\x7f[\v*\xb0\xd15V\xfbs\xac\xef\xa7\x9f\x12");
  level.g_effect["\x98:1d\xb6\xee\xd9\x92\xfd\xee3\xca\xe8Q\xb3\xdd"] = loadfxasset("\r\x80\x1d'\xfb\xfdbu\xeeQ8\xc8\x10P\x87.\xb2\\\xd1\xf6>C\xe8\xf7G\x0e\r\xdeU\xb3\xd4\v\xcbA&\xee\xdf\xa3`\xf7\xd7>\x83\xd7");
  level.g_effect["\xbb(-(oj\xe6H\x7f\xa0\xdcl\x17*\xe2HM"] = loadfxasset("'c\x15d!\xaf\x8a\xfav\x94\xae\x033\x834p\xd8\x94pU\x95\xeb@\xf7{a[A\x9a\a1\xe1x\x98>\xa3\xa1\x9f\xd8&R@\xf0\xd2\x1c");
  level.g_effect["myG\xc5\x89\xc1\x05\xc8\x18\xfe\x18[\x88v\xa3i"] = loadfxasset("p0`\xd2\x8c\xc4'\x97I\x87\x02,\x8c\x81\xe1lq[\xf1\xafkn\x14K]\x99\xe4\x0e\x01\x8d\xd2\xeem\x16G\xdc\x87R=E\xd8\xa3\x11\x8b");
  level.g_effect["xn\xb66\x11\xf6\xdb/\xef#\xbb\x8d8\xa4Ix\x8d"] = loadfxasset("lRX\xd2\xdcsPCF\a\xb7\xf7qo\xaa\xe4\xbc\x7f\rG\x84\xc1\x95\xc5L\x83\xb6u\xbf`\xf0\b\xdb\xfc%\x97\xdb\xbf\xc5\xcd\x980\x1b\xb4-");
  level.g_effect["\xf6\xd2\xc6\xa9\xb8\xf7\xdf\xd6\xce\\\x16\x95\xbd\x90\xba\xf6"] = loadfxasset("\xf7\xda\xa8@>k\x11/\x7f\xebE\x1ca\x84\xc0\xff\xd1\xac\x92\x01$Z\x89o}_^\x04\xe0\xa4\xa0\xc7\xc7\xfa\xba\xf0Za\xfbi/\xf9[\n");
  level.g_effect["\x03b\x0f\xcf?k\x175.G\x99H\xd7\x1b\xc0.\xbd\xe4\xcb\xa9$"] = loadfxasset("\x8c\x832\x13\x955\x88\xdc\xc9,\xaf\x1f7q\xbd\xbe\x15\xd0\x14\xcd|>\x1e\xcbHZv}\x8a\xf61\xa8\x80\xe6\x12\xda&\x96>\xcbBH^gV");
  level.molotovdata = spawnStruct();
  level.molotovdata.active = [];
  offhands::registeroffhandfirefunc(offhand, &molotovfiremain);
  utility::registersharedfunc(#"molotov", #"molotov_simulate_impact", &molotov_simulate_impact);
  utility::registersharedfunc(#"molotov", #"delete_all_molotovs", &delete_all_molotovs);
}

function molotovfiremain(grenade, weapon) {
  if(isPlayer(self) || isai(self)) {
    owner = self;
  } else {
    owner_options = getaiarray("?\xb1\xc0\x9a");

    if(owner_options.size > 0) {
      owner = sortandreturnowner(owner_options, grenade);
    } else {
      owner_options = getaiarray("O\x15\x1b\xad\x9ff");

      if(owner_options.size > 0) {
        owner = sortandreturnowner(owner_options, grenade);
      } else {
        owner = level.player;
      }
    }
  }

  if(isDefined(level.battlechatter)) {
    function_99e8e66d1969d7cb(owner, undefined, "\x9e\x19\xa8K\xf6\xfc3<R\xc1\xd4\xbay", "\xb6\xbdc\xf6Gov");
  }

  grenade endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(!isDefined(grenade)) {
    return;
  }

  grenade.owner = owner;
  ownerorigin = owner.origin;
  ownerangles = owner.angles;
  grenade waittill("d\xd9b~\xf2\x9f\x15\x93T\xd1\x04\x1a\x18", stuckto, hitentpart, surfacetype, velocity, position, hitnormal);
  launchangles = getlaunchangles(position, ownerorigin, ownerangles);
  level notify("*\x05(r\f\"\xae=>\xef\x97\xa1\xc6A", owner, position);

  if(isDefined(owner) && isDefined(owner.team)) {
    level notify("\x06GY^\xbe\xd3>\x0f\xbe\x1ep\xd8csG-", "\xb6\xbdc\xf6Gov", owner.team);
  }

  owner thread molotov_stuck(grenade, stuckto, launchangles, velocity, 1);
}

function sortandreturnowner(arr, grenade) {
  return sortbydistance(arr, grenade.origin)[0];
}

function getlaunchangles(origin, ownerorigin, ownerangles) {
  if(!isDefined(ownerorigin)) {
    ownerorigin = self.origin;
  }

  if(!isDefined(ownerangles)) {
    ownerangles = self.angles;
  }

  dirtomolotov = vectorNormalize(origin - ownerorigin);
  ang = vectortoangles(dirtomolotov);
  flatang = (0, ownerangles[1], 0);
  launchangles = flatang + (45, 0, 0);
  return launchangles;
}

function molotovexplode(origin, normal, velocity, entity, molotovowner) {
  molotov = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", origin);
  molotov setModel("p\x9c{M\xb2cG\xb4\xc6+\xd7[o\x1boG\xf6v\xaf;\x18");
  ang = vectortoangles(normal);
  f = anglesToForward(ang);
  r = anglestoright(ang);
  u = anglestoup(ang);
  molotov.angles = axistoangles(r, u, f);
  molotov.owner = molotovowner;
  launchangles = molotovowner getlaunchangles(origin);

  if(isDefined(entity) && isDefined(entity.classname) && entity.classname == "\x98\xed\xee\xfc\x05\xabV\v\x96x") {
    entity = undefined;
  }

  thread molotov_stuck(molotov, entity, launchangles, velocity);
}

function pool_damage_scriptables(origin) {
  scriptableradiuscheck = self.pooldata.triggerradius * 3;

  foreach(ent in self.shareddata.scriptables) {
    dist = distance(ent.origin, origin);

    if(dist <= scriptableradiuscheck) {
      if(ent getscriptableparthasstate("z\xd4mN", "`\x8b\xea\x19\xb4\xb6\xd4y\xfe\xfb?t\n")) {
        ent setscriptablepartstate("z\xd4mN", "`\x8b\xea\x19\xb4\xb6\xd4y\xfe\xfb?t\n", 1);

        if(level.dbgmolodrawhits) {
          line(origin, ent.origin, (1, 0, 0), 1, 0, 300);
        }
      }

      ent utility_sp::do_damage(200, ent.origin, undefined, undefined, "\b\x89z\xc1\xf1\xd4I\xf3");
    }
  }
}

function pool_damage_vehicles(origin, pool) {
  radiuscheck = self.pooldata.triggerradius * 5;

  foreach(ent in self.shareddata.vehicles) {
    dist = distance(ent.origin, origin);

    if(dist <= radiuscheck) {
      if(level.dbgmolodrawhits) {
        line(origin, ent.origin, (0, 0, 1), 1, 0, 300);
      }

      if(ent isscriptable()) {
        ent thread molotovburnscriptablevehicle(pool);
        continue;
      }

      ent thread molotovburnvehicle(pool);
    }
  }
}

function molotovburnscriptablevehicle(pool) {
  self endon("\x1e\xfd\xd1\xa2\a");
  wait 1;
  cur_state = self getscriptablepartstate("\xb7\x1bs\xf8", 1);

  if(!isDefined(cur_state)) {
    states = ["\xcc\xb1a\x9c\x95\xba\a", "\x9eb\xb9N\xbc;"];

    foreach(state in states) {
      if(self getscriptableparthasstate("\xb7\x1bs\xf8", state)) {
        self setscriptablepartstate("\xb7\x1bs\xf8", state, 1);
      }

      wait 0.5;
    }
  }
}

function molotovburnvehicle(pool) {
  self endon("\x1e\xfd\xd1\xa2\a");
  pool endon("A\x0e\x7f\xa9CB\xf41\xaa\xa4\xf1\x14?<\v\xb1");

  while(true) {
    utility_sp::do_damage(75, self.origin, undefined, undefined, "\b\x89z\xc1\xf1\xd4I\xf3");
    wait 0.5;
  }
}

function pool_damage_ai(origin, owner) {
  self.shareddata.ai = utility::array_removeundefined(self.shareddata.ai);
  self.shareddata.ai = utility::array_removedead_or_dying(self.shareddata.ai, 0);

  if(isDefined(owner) && isPlayer(owner)) {
    level.moloachievementvictims = 0;
  }

  foreach(guy in self.shareddata.ai) {
    dist = distance(guy.origin, origin);
    drawtime = 100;

    if(issameteam(guy.team, owner.team)) {
      killradius = self.pooldata.aikillradius * 0.7;
      damageradius = self.pooldata.aidamageradius * 0.5;
    } else {
      killradius = self.pooldata.aikillradius;
      damageradius = self.pooldata.aidamageradius;
    }

    if(dist <= killradius) {
      guy thread achievement_watcher(owner, self);
      molotovburnenemy(guy, 1, origin, owner);

      if(level.var_888b1740fec4762) {
        line(origin, guy.origin, (1, 0, 0), 1, 0, drawtime);
        sphere(origin, killradius, (1, 0, 0), 0, drawtime);
        sphere(origin, damageradius, (0.4, 0.4, 0.4), 0, drawtime);
      }

      continue;
    }

    if(dist <= damageradius) {
      guy thread achievement_watcher(owner, self);
      molotovburnenemy(guy, 0, origin, owner);

      if(level.var_888b1740fec4762) {
        line(origin, guy.origin, (0.8, 0.4, 0.4), 1, 0, drawtime);
        sphere(origin, killradius, (0.8, 0.8, 0.8), 0, drawtime);
        sphere(origin, damageradius, (1, 0, 0), 0, drawtime);
      }

      continue;
    }

    if(level.var_888b1740fec4762) {
      sphere(origin, killradius, (0.8, 0.8, 0.8), 0, drawtime);
      sphere(origin, damageradius, (0.4, 0.4, 0.4), 0, drawtime);
    }
  }
}

function issameteam(ownerteam, victimteam) {
  return isDefined(ownerteam) && isDefined(victimteam) && ownerteam == victimteam;
}

function molotovburnenemy(enemy, todeath, origin, molotovowner) {
  if(isanimScripted(enemy) && enemy.in_melee_death) {
    return;
  }

  if(istrue(enemy.var_c38dfabbf7656462) || istrue(level.var_c38dfabbf7656462)) {
    todeath = 0;
  }

  enemy._blackboard.isburning = 1;
  enemy.burningtodeath = todeath;
  enemy.burningdirection = undefined;

  if(todeath) {
    enemy notify("\xc5c\b\x02~\r];]\xe3\xdf\x04x");

    if(istrue(enemy.flashlight)) {
      enemy nvg_ai::flashlight_off(0);
    }

    enemy utility_sp::anim_stopanimScripted();
    enemy utility_sp::do_damage(enemy.health + 9999, origin, molotovowner, molotovowner, "\b\x89z\xc1\xf1\xd4I\xf3", "\xb6\xbdc\xf6Gov");
    currentstate = undefined;

    if(enemy isscriptable()) {
      currentstate = enemy getscriptablepartstate("\xadt$xK8e\xd6\x0f5\x80\x1cHB\xf0\r<\x88\xc3h\xc8(e\x9f", 1);
    }

    if(!isDefined(currentstate)) {
      enemy thread molotov_burn_sfx(todeath);
    }
  } else {
    enemyright = anglestoright(enemy.angles);
    var_7cebc08296b0b15d = vectorNormalize(origin - enemy.origin);

    if(vectordot(enemyright, var_7cebc08296b0b15d) > 0) {
      enemy.burningdirection = "o0\xee\xc1\x8c";
    } else {
      enemy.burningdirection = "=\xff0b";
    }

    if(!(istrue(enemy.var_c38dfabbf7656462) || istrue(level.var_c38dfabbf7656462))) {
      enemy utility_sp::do_damage(1, origin, molotovowner, molotovowner, "\b\x89z\xc1\xf1\xd4I\xf3", "\xb6\xbdc\xf6Gov");
    }

    enemy thread molotov_burn_sfx();
  }

  level thread ai::remove_blackboard_isburning(enemy);
}

function achievement_watcher(owner, branch) {
  if(!isai(self)) {
    return;
  }

  if(!isDefined(owner) || !isPlayer(owner)) {
    return;
  }

  if(!istrue(branch.shareddata.thrownoffhand)) {
    return;
  }

  level.moloachievementvictims += 1;

  if(level.moloachievementvictims > 3) {
    level thread utility_sp::giveachievement_wrapper("3p\x98:\f");
  }
}

function vector_empty(vector) {
  return vector == (0, 0, 0);
}

function molotov_burn_sfx(todeath) {
  if(isDefined(todeath)) {
    duration = 1;
  } else {
    duration = 0.5;
  }

  if(!isDefined(self.burnsfxenabled)) {
    self.burnsfxenabled = 0;
  }

  if(!isDefined(self.burnsfx)) {
    burnsfx = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", self.origin);
    burnsfx linkTo(self);
    self.burnsfx = burnsfx;
    wait 0.05;
  } else {
    burnsfx = self.burnsfx;
  }

  if(isDefined(self) && self.burnsfxenabled == 0) {
    if(soundexists("Ac\x94\xd7\xc4\xaa\xc71|\xdf\xe3\x85\xab\x1f\xc3\xeb\xa8\x11\x9b\x17\xb8;\xbb\x1f\xf4\xd0xsS\x91 \x01")) {
      burnsfx playLoopSound("Ac\x94\xd7\xc4\xaa\xc71|\xdf\xe3\x85\xab\x1f\xc3\xeb\xa8\x11\x9b\x17\xb8;\xbb\x1f\xf4\xd0xsS\x91 \x01");
    } else if(soundexists("A\x99\x90\x97\xe4\xbaz\xc4\t}\xc0MK\xc8\x8dFa\x17\x02\xc9\xcb\xf5\xde mLB")) {
      burnsfx playLoopSound("A\x99\x90\x97\xe4\xbaz\xc4\t}\xc0MK\xc8\x8dFa\x17\x02\xc9\xcb\xf5\xde mLB");
    }

    self.burnsfxenabled = 1;
    wait duration;

    if(soundexists("Ac\x94\xd7\xc4\xaa\xc71|\xdf\xe3\x85\xab\x1f\xc3\xeb\xa8\x11\x9b\x17\xb8;\xbb\x1f\xf4\xd0xsS\x91 \x01")) {
      burnsfx playSound("\x96\xbd/{YzF\x8e\xf8}dG\x80\x19\xfcy<\xad\xe8l/wx\x98\xff$\x7f\xe2|\x9b\a&\xc32\xec\x19");
    } else if(soundexists("e\\\a\xf5\xad\xbdc{t\xed\xec\xeb\xcci'+\xfae\xdc+\xda^}1\xear\xb9\xd7\xb2sF")) {
      burnsfx playSound("e\\\a\xf5\xad\xbdc{t\xed\xec\xeb\xcci'+\xfae\xdc+\xda^}1\xear\xb9\xd7\xb2sF");
    }

    wait 0.15;
    burnsfx stoploopsound();
    burnsfx delete();

    if(isDefined(self)) {
      self.burnsfxenabled = 1;
    }
  }
}

function molotov_fire_sfx(origin, duration) {
  wait 0.1;
  soundorg = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", origin + (0, 0, 15));

  if(soundexists("\xf5|\bzf\x7fv\x1d\xff\x15\x15B\xffv9\xcc:!CZ\t+\xe2\xaf")) {
    soundorg playLoopSound("\xf5|\bzf\x7fv\x1d\xff\x15\x15B\xffv9\xcc:!CZ\t+\xe2\xaf");
  } else if(soundexists("\x13\xdd\x03#\xb9J\x16@[ul\xcfjb\x1c@\x1d\xea\x0f")) {
    soundorg playLoopSound("\x13\xdd\x03#\xb9J\x16@[ul\xcfjb\x1c@\x1d\xea\x0f");
  }

  wait duration;
  thread utility::play_sound_in_space("TBkKA@\xc3\xd7\xabx7\x84\x12\xb54\x01\xa2\xff\xff\x10\xa4\x83\xf2\x97M", soundorg.origin);
  soundorg utility_sp::sound_fade_and_delete(1, 1);
}

function molotov_init() {
  molotov_init_cast_data();
  molotov_init_pool_data();
}

function molotov_init_cast_data() {
  leveldata = level.molotovdata;

  if(!isDefined(leveldata)) {
    leveldata = spawnStruct();
    level.molotovdata = leveldata;
  }

  castdata = leveldata.castdata;

  if(!isDefined(castdata)) {
    castdata = spawnStruct();
    leveldata.castdata = castdata;
  }

  castdata.distforward = [];
  castdata.distdown = [];
  castdata.distup = [];
  castdata.maxcasts = [];
  castdata.maxfails = [];
  castdata.maxents = [];
  castdata.firstforwarddist = [];
  castdata.firstforwardmindist = [];
  castdata.firstforwardmodanglesfunc = [];
  id = 8;
  castdata.distforward[id] = undefined;
  castdata.distdown[id] = undefined;
  castdata.distup[id] = undefined;
  castdata.maxcasts[id] = undefined;
  castdata.maxfails[id] = undefined;
  castdata.maxents[id] = 1;
  id = 16;
  castdata.distforward[id] = 50;
  castdata.distdown[id] = 50;
  castdata.distup[id] = 25;
  castdata.maxcasts[id] = 4;
  castdata.maxfails[id] = 3;
  castdata.maxents[id] = 1;
  castdata.distforwardwall[id] = 25;
  id = 32;
  castdata.distforward[id] = 15;
  castdata.distdown[id] = 50;
  castdata.distup[id] = 25;
  castdata.maxcasts[id] = 17;
  castdata.maxfails[id] = 3;
  castdata.maxents[id] = 3;
  castdata.firstforwarddist[id] = 85;
  castdata.firstforwardmindist[id] = 8;
  castdata.distforwardwall[id] = 8;
  castdata.firstforwarddistwall[id] = 44;
}

function molotov_init_pool_data() {
  leveldata = level.molotovdata;

  if(!isDefined(leveldata)) {
    leveldata = spawnStruct();
    level.molotovdata = leveldata;
  }

  pooldata = leveldata.pooldata;

  if(!isDefined(pooldata)) {
    pooldata = spawnStruct();
    leveldata.pooldata = pooldata;
  }

  pooldata.triggerradius = [];
  pooldata.triggerheight = [];
  pooldata.triggeroffset = [];
  pooldata.startdelayms = [];
  id = 8;
  pooldata.triggerradius[id] = 30;
  pooldata.triggerheight[id] = 55;
  pooldata.aikillradius[id] = 100;
  pooldata.aidamageradius[id] = 130;
  pooldata.triggeroffset[id] = 15;
  pooldata.startdelayms[id] = 0;
  pooldata.dangerzoneradius[id] = 350;
  pooldata.dangerzoneheight[id] = 128;
  id = 16;
  pooldata.triggerradius[id] = 30;
  pooldata.triggerheight[id] = 55;
  pooldata.aikillradius[id] = 75;
  pooldata.aidamageradius[id] = 100;
  pooldata.triggeroffset[id] = 15;
  pooldata.startdelayms[id] = 100;
  id = 32;
  pooldata.triggerradius[id] = 10;
  pooldata.triggerheight[id] = 55;
  pooldata.aikillradius[id] = 50;
  pooldata.aidamageradius[id] = 80;
  pooldata.triggeroffset[id] = 15;
  pooldata.startdelayms[id] = 100;
  molotov_init_pool_mask();
}

function molotov_init_pool_mask() {
  leveldata = level.molotovdata;

  if(!isDefined(leveldata)) {
    leveldata = spawnStruct();
    level.molotovdata = leveldata;
  }

  pooldata = leveldata.pooldata;

  if(!isDefined(pooldata)) {
    pooldata = spawnStruct();
    leveldata.pooldata = pooldata;
  }

  var_bc2d88ee160b1cd1 = [];
  var_bc2d88ee160b1cd1[1] = "\xcc\xb1a\x9c\x95\xaa\a";
  var_bc2d88ee160b1cd1[2] = "\xf8\x1d\xa0\x8c\xdb\x88a\xa3";
  var_bc2d88ee160b1cd1[4] = "\xea0\xfe\xca\x97\xacC";
  var_bc2d88ee160b1cd1[8] = "AaGy\x9bG\x8aR\xdb\n";
  var_bc2d88ee160b1cd1[16] = "e\x9et\xbf";
  var_bc2d88ee160b1cd1[32] = "\x1d+s\x8c\x9c\xa5\xc6";
  var_bc2d88ee160b1cd1[64] = "";
  var_bc2d88ee160b1cd1[128] = "\x89\xd7\x82\xb5";
  var_bc2d88ee160b1cd1[256] = "\xdfv\x1e\xca";
  var_bc2d88ee160b1cd1[512] = "D]\xa6\xc7\x9d?";
  var_bc2d88ee160b1cd1[1024] = "";
  scriptableparts = [];
  scriptablestates = [];
  var_afa2d1fd39bcae7f = (1 | 2 | 4) ^ (1 | 2 | 4) &(1 | 2 | 4) - 1;
  var_8c7e5fceb4040bfc = (8 | 16 | 32) ^ (8 | 16 | 32) &(8 | 16 | 32) - 1;
  var_86d60f13fc723831 = (64 | 128 | 256) ^ (64 | 128 | 256) &(64 | 128 | 256) - 1;
  var_3c03533972f6c9c4 = (512 | 1024) ^ (512 | 1024) &(512 | 1024) - 1;
  mask = 1 | 2 | 4;
  statebit = var_afa2d1fd39bcae7f;

  while((statebit &(1 | 2 | 4)) > 0) {
    scriptableparts[statebit] = var_bc2d88ee160b1cd1[statebit];
    typebit = var_8c7e5fceb4040bfc;

    while((typebit &(8 | 16 | 32)) > 0) {
      orientbit = var_86d60f13fc723831;

      while((orientbit &(64 | 128 | 256)) > 0) {
        incidencebit = var_3c03533972f6c9c4;

        while((incidencebit &(512 | 1024)) > 0) {
          mask = statebit | typebit | orientbit | incidencebit;
          scriptablestates[mask] = var_bc2d88ee160b1cd1[typebit] + var_bc2d88ee160b1cd1[orientbit] + var_bc2d88ee160b1cd1[incidencebit];
          mask = typebit | orientbit | incidencebit;
          scriptablestates[mask] = "\xba\xa5\x1f\xc9m\x80i";
          incidencebit <<= 1;
        }

        orientbit <<= 1;
      }

      typebit <<= 1;
    }

    statebit <<= 1;
  }

  pooldata.scriptableparts = scriptableparts;
  pooldata.scriptablestates = scriptablestates;
}

function molotov_stuck(grenade, stuckto, launchangles, impactvelocity, thrownoffhand) {
  angles = undefined;
  forward = vectorNormalize(impactvelocity);
  up = anglestoup(grenade.angles);
  right = anglestoright(launchangles);

  if(abs(vectordot(forward, up)) >= 0.9848) {
    angles = molotov_rebuild_angles_up_right(up, right);
  } else {
    angles = molotov_rebuild_angles_up_forward(up, forward);
  }

  grenade.angles = angles;
  grenade notify("\x1e\xfd\xd1\xa2\a");
  grenade setscriptablepartstate("\xfd^\xd8J\x03\b\x1b", "*\x83\xc10XI\x1e", 0);
  molotov_simulate_impact(grenade, grenade.origin, angles, stuckto, impactvelocity, gettime(), thrownoffhand);
  grenade detonate();
}

function molotovbadplace(impactorigin) {
  badplace = createnavbadplacebybounds(impactorigin, (128, 128, 100), (0, 0, 0));

  if(level.dbgmolodrawhits) {
    drawtime = int(6250);
    orientedbox(impactorigin, (128, 128, 100), (0, 0, 0), (0, 0, 1), 1, drawtime);
  }

  return badplace;
}

function molotov_simulate_impact(grenade, impactorigin, impactangles, impactent, impactvelocity, impacttime, thrownoffhand) {
  index = level.molotovdata.active.size;
  level.molotovdata.active[index] = spawnStruct();
  owner = grenade.owner;
  impactnormal = anglestoup(impactangles);
  caststart = impactorigin + impactnormal * 1;
  castend = caststart + impactnormal * 25;
  contents = molotov_get_cast_contents();
  ignore = getaiarray();
  ignore = utility::array_add(ignore, grenade);

  if(level.dbgmolodrawhits) {
    line(caststart, castend, (1, 0, 0), 1, 0, 100);
  }

  castresults = physics_raycast(caststart, castend, contents, ignore, 0, "\x15\xac\x15z\xf1\xed\a\x06BQ,a]\xfb\x1d\xa4e9\xcft", 1);

  if(isDefined(castresults) && castresults.size > 0) {
    castend = castresults[0]["\xc1\xbd\xdci\xe8i{7"] - impactnormal * 1;
  }

  borigin = castend;
  burnsource = grenade;
  burnid = molotov_get_next_burning_id();
  coneimpact = 0;
  impactincidence = 512;
  impactdot = vectordot(vectorNormalize(impactvelocity), -1 * impactnormal);

  if(impactdot < 0.96593) {
    coneimpact = 1;
    impactincidence = 1024;
  }

  shareddata = molotov_create_shared_data(owner, impacttime, impactincidence, burnsource, burnid, thrownoffhand);
  shareddata.badplace = molotovbadplace(impactorigin);
  shareddata.scriptables = moltovgetscriptables(impactorigin);
  shareddata.vehicles = moltovgetvehicles(impactorigin);
  shareddata.ai = moltovgetai(impactorigin);

  if(level.var_503477c854eb1ec4) {
    id = 8;
    castdata = undefined;
    pooldata = molotov_get_pool_data(id);
    branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, impactorigin, impactangles, impactent);
    shareddata.branches[shareddata.branches.size] = branch;
    branch thread molotov_start_branch();
    return;
  } else if(level.var_57484d6b3cb0bba9) {
    id = 16;
    castdata = undefined;
    pooldata = molotov_get_pool_data(id);
    branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, impactorigin, impactangles, impactent);
    shareddata.branches[shareddata.branches.size] = branch;
    branch thread molotov_start_branch();
    return;
  } else if(level.var_295e9da422fdfad8) {
    id = 32;
    castdata = undefined;
    pooldata = molotov_get_pool_data(id);
    branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, impactorigin, impactangles, impactent);
    shareddata.branches[shareddata.branches.size] = branch;
    branch thread molotov_start_branch();
    return;
  }

  id = 8;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, impactorigin, impactangles, impactent);
  shareddata.branches[shareddata.branches.size] = branch;
  var_3ed649d356554b6b = 25;
  var_d515578221013bc0 = 65;
  var_e4096de928d80604 = 115;
  sidepreventstarttime = gettime() + pooldata.startdelayms;
  id = 16;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  oncompletedfunc = &molotov_branch_create_tendril_radial;

  if(coneimpact) {
    oncompletedfunc = &molotov_branch_create_forward_tendril_cone;
  }

  branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, borigin, impactangles, impactent, 0, sidepreventstarttime, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = branch;
  forward = anglesToForward(impactangles);
  right = anglestoright(impactangles);
  up = anglestoup(impactangles);
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  bforward = forward * -1;
  bright = right * -1;
  bup = up;
  bangles = axistoangles(bforward, bright, bup);
  oncompletedfunc = &molotov_branch_create_tendril_radial;

  if(coneimpact) {
    oncompletedfunc = undefined;
  }

  branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = branch;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  bforward = rotatepointaroundvector(up, forward, var_d515578221013bc0);
  bright = vectorNormalize(vectorcross(bforward, up));
  bup = vectorcross(bright, forward);
  bangles = axistoangles(bforward, bright, bup);
  oncompletedfunc = &molotov_branch_create_tendril_radial;

  if(coneimpact) {
    oncompletedfunc = &molotov_branch_create_right_tendril_cone;
  }

  branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = branch;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  bforward = rotatepointaroundvector(up, forward, -1 * var_d515578221013bc0);
  bright = vectorNormalize(vectorcross(bforward, up));
  bup = vectorcross(bright, forward);
  bangles = axistoangles(bforward, bright, bup);
  oncompletedfunc = &molotov_branch_create_tendril_radial;

  if(coneimpact) {
    oncompletedfunc = &molotov_branch_create_left_tendril_cone;
  }

  branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = branch;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  bforward = rotatepointaroundvector(up, forward, var_e4096de928d80604);
  bright = vectorNormalize(vectorcross(bforward, up));
  bup = vectorcross(bright, forward);
  bangles = axistoangles(bforward, bright, bup);
  oncompletedfunc = &molotov_branch_create_tendril_radial;

  if(coneimpact) {
    oncompletedfunc = undefined;
  }

  branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = branch;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  bforward = rotatepointaroundvector(up, forward, -1 * var_e4096de928d80604);
  bright = vectorNormalize(vectorcross(bforward, up));
  bup = vectorcross(bright, forward);
  bangles = axistoangles(bforward, bright, bup);
  oncompletedfunc = &molotov_branch_create_tendril_radial;

  if(coneimpact) {
    oncompletedfunc = undefined;
  }

  branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = branch;
  shareddata molotov_shared_data_register_cast();

  foreach(branch in shareddata.branches) {
    branch thread molotov_start_branch();
  }

  shareddata thread molotov_cleanup();
  shareddata.initialized = 1;
  level.molotovdata.active[index] = shareddata;
}

function moltovgetscriptables(impactorigin) {
  damageables[0] = "E?\xd9\xf7h\xf3\xde\xbe9\xd5\xaa\xd0\xc5\x1a\x11LH%{-q\x95\xdd\xb7 \xf6Q\x98\xe3\xff\x99d";
  damageables[1] = "\xff\xf7\x05\xfc\xa0\x11\r-E|OK\x99k\x05\x06-\b\x82\xa6\xdeI\xba\x1f\x0eG|\xc5l^r\x04\xa6E\xd7\xcf\x04\xc7\xdb\xa1\xf0\x0e\xa1\x8d\xa6B\x02]";
  damageables[2] = "~\x9a\x8b\xbc\x06\x19\x0fM!\x0fM\xec\x80\xc5\tyA\x163\x8a\x98\x0f!Gi\x1f-\xac\xd8\xeb\xb6|D\x96\xcb\xd8\x80\x19ceS{\x97D\xdc\xa18]S\x01";
  damageables[3] = "\x13K-\xfasP\x7f[\x86\xbd9\xd5\xc9\x94N\x11/N\xcf\x19\x95h\x96A\xbe\x9f\x98\xd0\f/F\x15%B\xac,\x10h\x18\xb3\xd4\xc0j^<\xad\xc6\x1f3";
  damageables[4] = "\xe7US2@\xe4O\x15\x86T\xd8\a\xef^\x8aY\x17)-\xf2\xc4U\xb4]\x19'\xd2\x10Q\x8d\x9b\xf1\bG\x83\x111<\xd7\xbe\x1d\x8fC\x13@\xe9\x8b\f\\(";
  damageables[5] = "}\xa4\xf7%\xbajeh\xbe\xbf\xebX\xaf*\xc4\xf0 iV%\xa7v]\xbb.\x9e?\xf1B\x8b\xb9\xbc-\x93\xfb\x91\f\xdbU\xbc\xa9\xda\x88\x92\xb2\xafz\xb4\xd2%\x1b";
  damageables[6] = "{\xb0\x85.[b)6\xb2X\xce\x0f\xda\x97\xca*P\x87\x80(\xbe\xc0\xbeuIx<`j\x88S\n\xfeM\xef";
  damageables[7] = "\xf2\xa3BkPsezdY^\x14? \x1f\xe8\xe5$Ov\x92n|i\x16a\\Tc\x9e\xaa\xd0\xb3\xf2/qP";
  validscriptables = [];

  foreach(ent in damageables) {
    scriptables = getscriptablearray(ent, #classname);

    foreach(ent in scriptables) {
      distancesq = distancesquared(ent.origin, impactorigin);

      if(distancesq <= 65536) {
        validscriptables = utility::array_add(validscriptables, ent);

        if(level.dbgmolodrawhits) {
          line(impactorigin, ent.origin, (1, 1, 1), 0.5, 0, 300);
        }
      }
    }
  }

  return validscriptables;
}

function moltovgetvehicles(impactorigin) {
  validvehicles = [];
  vehicles = getscriptablearray("X\xf2Z\x1b\xc3\x03\xb9\xee\xd1\x95", #code_classname);
  vehicles = utility::array_combine(vehicles, getEntArray("\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e", #code_classname));

  foreach(vehicle in vehicles) {
    if(!isDefined(vehicle.model)) {
      continue;
    }

    distancesq = distancesquared(vehicle.origin, impactorigin);

    if(distancesq <= 65536) {
      validvehicles = utility::array_add(validvehicles, vehicle);

      if(level.dbgmolodrawhits) {
        line(impactorigin, vehicle.origin, (1, 1, 1), 0.5, 0, 300);
      }
    }
  }

  return validvehicles;
}

function moltovgetai(impactorigin) {
  ai = getaiarray();
  ai = utility::array_removeundefined(ai);
  ai = utility::array_removedead_or_dying(ai, 0);
  validai = [];

  foreach(guy in ai) {
    distancesq = distancesquared(guy.origin, impactorigin);

    if(distancesq <= 65536) {
      validai = utility::array_add(validai, guy);

      if(level.dbgmolodrawhits) {
        line(impactorigin, guy.origin, (1, 1, 1), 0.5, 0, 300);
      }
    }
  }

  return validai;
}

function molotov_cleanup() {
  self.burnsource utility::waittill_notify_or_timeout("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19", 6.25);

  while(true) {
    branchesterminated = 1;

    foreach(branch in self.branches) {
      if(!istrue(branch.iscomplete)) {
        branchesterminated = 0;
        break;
      }

      if(!branchesterminated) {
        break;
      }
    }

    if(branchesterminated) {
      break;
    }

    waitframe();
  }

  wait 6.25;
  destroynavobstacle(self.badplace);

  if(isDefined(self.burnsource)) {
    self.burnsource delete();
  }

  level.molotovdata.active = arrayremove(level.molotovdata.active, self);
}

function molotov_create_shared_data(owner, impacttime, impactincidence, burnsource, burnid, thrownoffhand) {
  shareddata = spawnStruct();
  shareddata.owner = owner;
  shareddata.team = owner.team;
  shareddata.impacttime = impacttime;
  shareddata.impactincidence = impactincidence;
  shareddata.burnsource = burnsource;
  shareddata.burnid = burnid;
  shareddata.branches = [];
  shareddata.thrownoffhand = thrownoffhand;
  shareddata.entstotal = 0;
  shareddata.caststotal = 0;
  shareddata.caststhisframe = 0;
  shareddata.frametimestamp = gettime();
  shareddata.castcontents = physics_createcontents(["\x998b\x97\xb6Y\xbb\x05\x82\x19\xfb7\xb3\xfb\x9b\\\xdbx3\x14\xc6zp\a\xe4\xfe9", "\xb3 c1\xa3\xab\x05/\x96c\xec\x02~5\a\xadz\xb9\xe6\xd8B", "\xce\xd8oGC\x8e\xf6\xde\x1b\xfe\x1f\xe5\xc0\x88-eADHGN", "\x96)?\xdbyq7\xde\x80 \x99\xfc\x9e-\xfe\xa7\xcd\r\x13\xba", "\xa3?\a\nru\xf2\xe6\x96\xb7\xd0\xcc\x97]4\x12n\xd3\xd3)\xcb\xae."]);
  shareddata.castignore = getaiarray();
  shareddata.castignore = utility::array_add(shareddata.castignore, level.player);
  return shareddata;
}

function molotov_shared_data_register_cast() {
  self.caststotal++;
  self.caststhisframe++;
  self.frametimestamp = gettime();
}

function molotov_shared_data_register_ent() {
  self.entstotal++;
}

function molotov_shared_data_can_cast_this_frame() {
  if(self.frametimestamp < gettime()) {
    self.frametimestamp = gettime();
    self.caststhisframe = 0;
  }

  return self.caststhisframe < 3;
}

function molotov_shared_data_is_complete(var_879c7f2af87ff0d9) {
  iscomplete = 0;

  if(self.caststotal >= 60) {
    iscomplete = 1;
  } else if(self.entstotal >= 20) {
    iscomplete = 1;
  } else if(istrue(var_879c7f2af87ff0d9)) {
    var_a401f7bd9965136f = 1;

    foreach(branch in self.branches) {
      if(!branch molotov_branch_is_complete(1, 1)) {
        var_a401f7bd9965136f = 0;
        break;
      }
    }

    if(var_a401f7bd9965136f) {
      iscomplete = 1;
    }
  }

  if(iscomplete) {
    self.iscomplete = 1;
    self.branches = [];
  }

  return iscomplete;
}

function molotov_create_branch(shareddata, castdata, pooldata, parent, startingorigin, startingangles, startingstuckto, startingcasttype, preventstarttime, oncompletedfunc) {
  branch = spawnStruct();
  branch.shareddata = shareddata;
  branch.castdata = castdata;
  branch.pooldata = pooldata;
  branch.startingorigin = startingorigin;
  branch.startingangles = startingangles;
  branch.startingstuckto = startingstuckto;
  branch.startingcasttype = startingcasttype;
  branch.oncompletedfunc = oncompletedfunc;
  branch.ents = [];
  branch.branches = [];
  branch.hitpositions = [];
  branch.hittypes = [];
  branch.casts = 0;
  branch.castfails = 0;
  branch.preventstarttime = preventstarttime;
  return branch;
}

function molotov_start_branch() {
  thread molotov_branch_draw_hits();

  if(!isDefined(self.preventstarttime)) {
    self.preventstarttime = gettime();
  }

  if(!isDefined(self.startingcasttype)) {
    if(!self.shareddata molotov_shared_data_is_complete()) {
      pool = molotov_branch_create_pool(self.startingorigin, self.startingangles, self.shareddata.impactincidence, self.startingstuckto);
      pool thread molotov_pool_start();
      pool_damage_scriptables(pool.origin);
      pool_damage_vehicles(pool.origin, pool);
      pool_damage_ai(pool.origin, self.shareddata.owner);
      self.iscomplete = 1;
      self.shareddata molotov_shared_data_is_complete(1);

      self.hitpositions[self.hitpositions.size] = self.startingorigin;
      self.hittypes[self.hittypes.size] = 1;
    }

    return;
  }

  self.caststart = self.startingorigin;
  self.castend = undefined;
  self.castangles = self.startingangles;
  self.castdir = undefined;
  self.casttype = self.startingcasttype;
  self.startingorigin = undefined;
  self.startingangles = undefined;
  self.startingcasttype = undefined;

  while(true) {
    if(self.shareddata molotov_shared_data_is_complete()) {
      break;
    }

    if(molotov_branch_is_complete(undefined, 1)) {
      break;
    }

    if(!self.shareddata molotov_shared_data_can_cast_this_frame()) {
      waitframe();
      continue;
    }

    if(self.casttype == 0) {
      firstforwardmodanglesfunc = self.castdata.firstforwardmodanglesfunc;

      if(isDefined(firstforwardmodanglesfunc)) {
        self.castangles = [[firstforwardmodanglesfunc]](self.castangles);
        self.castdata.firstforwardmodanglesfunc = undefined;
        self.castdata.iswallcast = undefined;
      }
    }

    if(!isDefined(self.iswallcast)) {
      updot = vectordot(anglestoup(self.castangles), (0, 0, 1));
      self.iswallcast = updot > -0.81915 && updot <= 0.5;

      if(isDefined(self.castdata.firstforwarddist)) {
        if(self.iswallcast && isDefined(self.castdata.firstforwarddistwall)) {
          self.castdata.firstforwarddist = self.castdata.firstforwarddistwall;
          self.castdata.firstforwarddistwall = undefined;
        } else {
          self.castdata.firstforwarddistwall = undefined;
        }
      }
    }

    self.castdir = molotov_get_cast_dir(self.castangles, self.casttype);
    self.castend = self.caststart + self.castdir * molotov_get_cast_dist(self.casttype, self.castdata, self.iswallcast);
    casthit = undefined;
    casthitpos = undefined;
    casthitnorm = undefined;
    casthitent = undefined;
    casthitangles = undefined;

    if(level.dbgmolodrawhits) {
      line(self.caststart, self.castend, (1, 1, 1), 1, 0, 100);
    }

    castresults = physics_raycast(self.caststart, self.castend, self.shareddata.castcontents, undefined, 0, "\x15\xac\x15z\xf1\xed\a\x06BQ,a]\xfb\x1d\xa4e9\xcft", 1);

    if(isDefined(castresults) && castresults.size > 0) {
      casthit = 1;
      casthitpos = castresults[0]["\xc1\xbd\xdci\xe8i{7"];
      casthitnorm = castresults[0]["+0a<s,"];
      casthitent = castresults[0]["\x1f\xa8\x10WP\xa9"];
    }

    switch (self.casttype) {
      case 0:
        if(istrue(casthit)) {
          molotov_branch_register_cast(self.casttype, 0, casthitpos);
          shouldcreatepool = 1;

          if(isDefined(self.castdata.firstforwarddist)) {
            castvec = casthitpos - self.caststart;
            castdist = vectordot(castvec, self.castdir);
            self.castdata.firstforwarddist -= castdist;

            if(self.castdata.firstforwarddist > self.castdata.firstforwardmindist) {
              shouldcreatepool = 0;
            } else {
              self.castdata.firstforwarddist = undefined;
            }
          }

          casthitangles = molotov_rebuild_angles_up_right(casthitnorm, anglestoright(self.castangles));

          if(shouldcreatepool) {
            ent = molotov_branch_create_pool(casthitpos, casthitangles, self.shareddata.impactincidence, casthitent);
            ent thread molotov_pool_start();
            pool_damage_ai(ent.origin, self.shareddata.owner);
          }

          self.casttype = 2;
          self.caststart = casthitpos + casthitnorm * 1;
          self.castangles = casthitangles;
          self.iswallcast = undefined;
        } else {
          molotov_branch_register_cast(self.casttype, undefined, undefined);

          if(isDefined(self.castdata.firstforwarddist)) {
            castvec = self.castend - self.caststart;
            castdist = vectordot(castvec, self.castdir);
            self.castdata.firstforwarddist -= castdist;

            if(self.castdata.firstforwarddist <= self.castdata.firstforwardmindist) {
              self.castdata.firstforwarddist = undefined;
            }
          }

          self.casttype = 1;
          self.caststart = self.castend;
        }

        break;
      case 1:
        if(istrue(casthit)) {
          casthitangles = molotov_rebuild_angles_up_right(casthitnorm, anglestoright(self.castangles));
          ent = molotov_branch_create_pool(casthitpos, casthitangles, self.shareddata.impactincidence, casthitent);
          ent thread molotov_pool_start();
          pool_damage_ai(ent.origin, self.shareddata.owner);
          normdot = vectordot(anglestoup(self.castangles), casthitnorm);

          if(normdot < 0.9848) {
            molotov_branch_register_cast(self.casttype, 2, casthitpos);
            self.casttype = 2;
            self.caststart = casthitpos + casthitnorm * 1;
            self.castangles = casthitangles;
          } else {
            molotov_branch_register_cast(self.casttype, 1, casthitpos);
            self.casttype = 0;
          }
        } else {
          molotov_branch_register_cast(self.casttype, undefined, undefined);
          self.caststart = self.castend;
        }

        break;
      case 2:
        if(istrue(casthit)) {
          molotov_branch_register_cast(self.casttype, 3, casthitpos);
          self.casttype = 0;
          self.caststart = casthitpos + casthitnorm * 1;
        } else {
          molotov_branch_register_cast(self.casttype, undefined, undefined);
          self.casttype = 0;
        }

        break;
    }

    waittillframeend();
  }

  self.iscomplete = 1;
  self.shareddata molotov_shared_data_is_complete(1);
}

function molotov_branch_is_complete(var_879c7f2af87ff0d9, var_b49ea23eff65be01) {
  iscomplete = 0;
  var_a401f7bd9965136f = undefined;

  if(!istrue(var_b49ea23eff65be01)) {
    iscomplete = self.shareddata molotov_shared_data_is_complete();
  }

  if(!iscomplete) {
    if(isDefined(self.castdata) && isDefined(self.castdata.maxfails) && self.castfails >= self.castdata.maxfails) {
      iscomplete = 1;
    } else if(isDefined(self.castdata) && isDefined(self.castdata.maxcasts) && self.casts >= self.castdata.maxcasts) {
      iscomplete = 1;
    } else if(isDefined(self.castdata) && isDefined(self.castdata.maxents) && self.ents.size >= self.castdata.maxents) {
      iscomplete = 1;
    } else if(istrue(var_879c7f2af87ff0d9) && self.branches.size > 0) {
      var_a401f7bd9965136f = 1;

      foreach(branch in self.branches) {
        if(!branch molotov_branch_is_complete(var_879c7f2af87ff0d9, var_b49ea23eff65be01)) {
          var_a401f7bd9965136f = 0;
          break;
        }
      }

      if(var_a401f7bd9965136f) {
        iscomplete = 1;
      }
    }
  }

  if(iscomplete && !istrue(self.iscomplete)) {
    oncompletedfunc = self.oncompletedfunc;
    self.oncompletedfunc = undefined;

    if(isDefined(oncompletedfunc)) {
      self[[oncompletedfunc]]();
    }

    println("<dev string:x24>");

    if(istrue(var_a401f7bd9965136f)) {
      iscomplete = 0;

      foreach(branch in self.branches) {
        if(!branch molotov_branch_is_complete(1, var_b49ea23eff65be01)) {
          var_a401f7bd9965136f = 0;
          break;
        }
      }

      if(var_a401f7bd9965136f) {
        iscomplete = 1;
      }
    }
  }

  if(iscomplete) {
    self.iscomplete = 1;
    self.branches = [];
  }

  return iscomplete;
}

function molotov_branch_register_cast(casttype, casthittype, hitposition) {
  self.shareddata molotov_shared_data_register_cast();
  self.casts++;

  if(isDefined(casthittype)) {
    if(casthittype == 0 || casthittype == 1 || casthittype == 2) {
      self.castfails = 0;
    }
  } else if(casttype == 1) {
    self.castfails++;
  }

  debugmsg = undefined;

  if(isDefined(casthittype)) {
    debugmsg = undefined;

    switch (casthittype) {
      case 0:
        debugmsg = "<dev string:x3f>";
        break;
      case 1:
        debugmsg = "<dev string:x4e>";
        break;
      case 2:
        debugmsg = "<dev string:x5a>";
        break;
      case 3:
        debugmsg = "<dev string:x6d>";
        break;
    }

    self.hitpositions[self.hitpositions.size] = hitposition;
    self.hittypes[self.hittypes.size] = casthittype;
  } else {
    switch (casttype) {
      case 0:
        debugmsg = "<dev string:x77>";
        break;
      case 1:
        debugmsg = "<dev string:x82>";
        break;
      case 2:
        debugmsg = "<dev string:x8f>";
        break;
    }
  }

  if(istrue(level.var_42bea1ba1fc1c375)) {
    if(isDefined(debugmsg)) {
      println(debugmsg);
    }
  }

}

function molotov_create_pool(origin, angles, stuckto, owner, burnsource, burnid, starttime, pooldata, poolmask) {
  ent = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", origin);
  ent.angles = angles;
  ent.stuckto = stuckto;
  ent.owner = owner;
  ent.burnsource = burnsource;
  ent.burnid = burnid;
  ent.starttime = starttime;
  ent.pooldata = pooldata;
  ent.poolmask = poolmask;

  if(isDefined(level.var_c6fbb42f0b71b7d1)) {
    ent setModel(level.var_c6fbb42f0b71b7d1);
  } else {
    ent setModel("):l\x01&fP\xed\xed\x90<\xd8\xf915PR\xd1\x01\xa0$");
  }

  if(isDefined(owner)) {
    ent setotherent(owner);
    ent setentityowner(owner);
  }

  if(poolshouldlink(stuckto)) {
    ent linkTo(stuckto);
  }

  return ent;
}

function poolshouldlink(stuckto) {
  if(!isDefined(stuckto)) {
    return false;
  }

  if(stuckto == level.player) {
    return false;
  }

  if(isai(stuckto)) {
    return false;
  }

  return true;
}

function molotov_branch_create_pool(origin, angles, incidence, stuckto) {
  poolmask = self.pooldata.typeid;
  up = anglestoup(angles);
  dot = vectordot(up, (0, 0, 1));

  if(dot <= -0.81915) {
    poolmask |= 256;
  } else if(dot <= 0.5) {
    poolmask |= 128;
  } else {
    poolmask |= 64;
  }

  poolmask |= incidence;
  starttime = self.preventstarttime + self.pooldata.startdelayms;
  ent = molotov_create_pool(origin, angles, stuckto, self.shareddata.owner, self.shareddata.burnsource, self.shareddata.burnid, starttime, self.pooldata, poolmask);
  self.preventstarttime = starttime;
  self.ents[self.ents.size] = ent;
  self.shareddata molotov_shared_data_register_ent();
  return ent;
}

function molotov_pool_start() {
  if(istrue(self.started)) {
    return;
  }

  self.started = 1;
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("A\x0e\x7f\xa9CB\xf41\xaa\xa4\xf1\x14?<\v\xb1");

  while(gettime() < self.starttime) {
    waitframe();
  }

  self.ended = 0;
  molotov_watch_pool();

  if(isDefined(self)) {
    thread molotov_pool_end();
  }
}

function molotov_watch_pool_explosion_extinguish() {
  contents = physics_createcontents(["\xb3 c1\xa3\xab\x05/\x96c\xec\x02~5\a\xadz\xb9\xe6\xd8B", "\xce\xd8oGC\x8e\xf6\xde\x1b\xfe\x1f\xe5\xc0\x88-eADHGN", "\x96)?\xdbyq7\xde\x80 \x99\xfc\x9e-\xfe\xa7\xcd\r\x13\xba", "\xa3?\a\nru\xf2\xe6\x96\xb7\xd0\xcc\x97]4\x12n\xd3\xd3)\xcb\xae.", "\xeaYh~\xf2\x81\xa5\x8d\xd7\x92\xedz\x12xh\xa4Q\xff\x80\xf3\xa1\x99+U\xabsPB\xae"]);

  while(true) {
    level waittill("\x8d\xcb\x84(z\x1c#l\x97\x84\x1b\x82\xc3g\xd9\xb3NE\x03\xd7", position, radius, owner, ignoreents);

    if(distancesquared(position, self.origin) > radius * radius) {
      continue;
    }

    if(!isDefined(ignoreents)) {
      ignoreents = [];
      ignoreents[ignoreents.size] = self;
      ignoreents[ignoreents.size] = self.burnsource;
    } else if(isarray(ignoreents)) {
      ignoreents[ignoreents.size] = self;
      ignoreents[ignoreents.size] = self.burnsource;
    } else {
      ignoreent = ignoreents;
      ignoreents = [];
      ignoreents[ignoreents.size] = self;
      ignoreents[ignoreents.size] = self.burnsource;
      ignoreents[ignoreents.size] = ignoreent;
    }

    castoffset = min(15, self.pooldata.triggerheight);
    caststart = self.origin + anglestoup(self.angles) * castoffset;
    castresults = physics_raycast(self.origin, position, contents, ignoreents, 0, "\x15\xac\x15z\xf1\xed\a\x06BQ,a]\xfb\x1d\xa4e9\xcft", 1);

    if(isDefined(castresults) && castresults.size > 0) {
      continue;
    }

    thread molotov_pool_end();
  }
}

function molotov_watch_pool() {
  if(isDefined(self.stuckto)) {
    self.stuckto endon("\x1e\xfd\xd1\xa2\a");
  }

  childthread molotov_watch_pool_explosion_extinguish();

  if(!istrue(level.dbgmoloburnlooponly) && !istrue(level.dbgmolodiedownonly)) {
    self.poolmask |= 1;

    if(istrue(level.dbgmoloflareuponly)) {
      iprintlnbold("<dev string:x95>");
    }
  }

  self.trigger = molotov_create_pool_trigger(self.pooldata.triggerradius, self.pooldata.triggerheight, self.pooldata.triggeroffset, self.pooldata.dangerzoneradius, self.pooldata.dangerzoneheight);

  if(level.dbgmolodrawhits) {
    sphere(self.trigger.origin, self.pooldata.triggerradius, (1, 0, 0), 0, 300);
  }

  molotov_pool_update_scriptable();
  wait 0.7;

  if(!istrue(level.dbgmoloflareuponly) && !istrue(level.dbgmolodiedownonly)) {
    self.poolmask |= 2;

    if(istrue(level.dbgmoloburnlooponly)) {
      iprintlnbold("<dev string:xa7>");
    }
  }

  molotov_pool_update_scriptable();
  wait 0.3;
  self.poolmask &= ~1;

  if(istrue(level.dbgmoloflareuponly)) {
    iprintlnbold("<dev string:xba>");
  }

  molotov_pool_update_scriptable();
  burnloopduration = randomfloatrange(6, 6.25);
  wait burnloopduration;
}

function molotov_pool_end(immediate) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(istrue(self.ended)) {
    return;
  }

  self notify("A\x0e\x7f\xa9CB\xf41\xaa\xa4\xf1\x14?<\v\xb1");
  self.ended = 1;

  if(isDefined(self.poolmask)) {
    self.poolmask &= ~1;
    self.poolmask &= ~2;
  }

  if(istrue(level.dbgmoloflareuponly)) {
    iprintlnbold("<dev string:xba>");
  } else if(istrue(level.dbgmoloburnlooponly)) {
    iprintlnbold("<dev string:xca>");
  }

  if(!istrue(level.dbgmoloflareuponly) && !istrue(level.dbgmoloburnlooponly) && isDefined(self.poolmask)) {
    self.poolmask |= 4;

    if(istrue(level.dbgmolodiedownonly)) {
      iprintlnbold("<dev string:xdb>");
    }
  }

  molotov_pool_update_scriptable();

  if(!istrue(immediate)) {
    wait 1;
  }

  if(istrue(level.dbgmolodiedownonly)) {
    iprintlnbold("<dev string:xed>");
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self setscriptablepartstate("Z\xfa\x8d\xbao", "\xba\xa5\x1f\xc9m\x80i", 0);
  wait 3.5;
  self delete();
}

function molotov_create_pool_trigger(triggerradius, triggerheight, triggeroffset, dangerzoneradius, dangerzoneheight) {
  origin = self.origin - anglestoup(self.angles) * triggeroffset;
  trigger = spawn("\x87\xeb\xee\x9e\xf6\xa0;\tN'\xc7s\x9c\x0e\x170^\xb3u", origin, 0, triggerradius, triggerheight);
  trigger.script_multiplier = 10;

  if(isDefined(level.var_a2f1bd698c72b55a)) {
    trigger.script_multiplier = level.var_a2f1bd698c72b55a;
  }

  trigger.script_radius = triggerradius;
  trigger.angles = self.angles;
  thread trigger::trigger_fire(trigger);
  level notify("\xea\xdc\xa5\x13l|\x16\xe4m,\x9d\xfa\xcbm\xc6x\xee\xe8\xdc\x16", trigger);
  trigger enablelinkTo();
  trigger linkTo(self);
  trigger hide();
  struct = spawnStruct();
  struct.trigger = trigger;
  struct.attacker = self.owner;
  struct.inflictor = self.burnsource;
  struct.killcament = self.burnsource;
  struct.burnid = self.burnid;
  struct.playersintrigger = [];
  trigger.struct = struct;

  if(isDefined(dangerzoneradius)) {
    assert(dangerzoneradius > 0, "<dev string:xfd>");
    assert(isDefined(dangerzoneheight), "<dev string:x12e>");
    assert(dangerzoneheight > 0, "<dev string:x176>");
  }

  return trigger;
}

function molotov_pool_update_scriptable() {
  pooldatalvl = level.molotovdata.pooldata;
  statemask = self.poolmask &(1 | 2 | 4);
  var_afa2d1fd39bcae7f = (1 | 2 | 4) ^ (1 | 2 | 4) &(1 | 2 | 4) - 1;
  statebit = var_afa2d1fd39bcae7f;

  while((statebit &(1 | 2 | 4)) > 0) {
    mask = ~((1 | 2 | 4) &~statebit) &self.poolmask;
    part = pooldatalvl.scriptableparts[statebit];
    state = pooldatalvl.scriptablestates[mask];
    self setscriptablepartstate(part, state, 0);
    statebit <<= 1;
  }
}

function molotov_branch_create_sub_branch(id, starttime, firstforwarddist, firstforwardmindist, firstforwardmodanglesfunc, firstforwarddistwall, maxcasts, maxents, startbranch) {
  shareddata = self.shareddata;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);

  if(isDefined(self.castdata)) {
    if(self.castfails > self.castdata.maxfails) {
      return;
    }

    if(self.castfails > castdata.maxfails) {
      return;
    }
  }

  if(isDefined(firstforwarddist)) {
    castdata.firstforwarddist = firstforwarddist;
  }

  if(isDefined(firstforwardmindist)) {
    castdata.firstforwardmindist = firstforwardmindist;
  }

  if(isDefined(firstforwardmodanglesfunc)) {
    castdata.firstforwardmodanglesfunc = firstforwardmodanglesfunc;
  }

  if(isDefined(firstforwarddistwall)) {
    castdata.firstforwarddistwall = firstforwarddistwall;
  }

  if(isDefined(maxcasts)) {
    castdata.maxcasts = maxcasts;
  }

  if(isDefined(maxents)) {
    castdata.maxents = maxents;
  }

  branch = molotov_create_branch(shareddata, castdata, pooldata, self, self.caststart, self.castangles, undefined, self.casttype, self.preventstarttime);
  branch.castfails = self.castfails;
  self.branches[self.branches.size] = branch;
  shareddata.branches[shareddata.branches.size] = branch;

  if(istrue(startbranch)) {
    branch thread molotov_start_branch();
  }

  return branch;
}

function molotov_branch_create_forward_tendril_cone() {
  molotov_branch_create_sub_branch(32, self.preventstarttime, 35, 8, undefined, 44, undefined, undefined, 1);
}

function molotov_branch_create_left_tendril_cone() {
  molotov_branch_create_sub_branch(32, self.preventstarttime, 35, 8, &molotov_left_tendril_mod_angles, 44, undefined, undefined, 1);
}

function molotov_branch_create_right_tendril_cone() {
  molotov_branch_create_sub_branch(32, self.preventstarttime, 35, 8, &molotov_right_tendril_mod_angles, 44, undefined, undefined, 1);
}

function molotov_branch_create_tendril_radial() {
  molotov_branch_create_sub_branch(32, self.preventstarttime, 35, 8, &molotov_tendril_mod_angles_radial, 44, 6, 1, 1);
}

function molotov_rotate_angles_about_up(angles, amount) {
  forward = anglesToForward(angles);
  up = anglestoup(angles);
  right = undefined;
  forward = rotatepointaroundvector(up, forward, amount);
  right = vectorNormalize(vectorcross(forward, up));
  up = vectorcross(right, forward);
  return axistoangles(forward, right, up);
}

function molotov_left_tendril_mod_angles(angles) {
  amount = randomfloatrange(50, 75);
  return molotov_rotate_angles_about_up(angles, amount);
}

function molotov_right_tendril_mod_angles(angles) {
  amount = -1 * randomfloatrange(50, 75);
  return molotov_rotate_angles_about_up(angles, amount);
}

function molotov_tendril_mod_angles_radial(angles) {
  amount = randomfloatrange(-60, 60);
  return molotov_rotate_angles_about_up(angles, amount);
}

function molotov_get_cast_data(castid) {
  if(!(isDefined(level.molotovdata) && isDefined(level.molotovdata.castdata))) {
    molotov_init_cast_data();
  }

  castdatalvl = level.molotovdata.castdata;
  castdata = spawnStruct();
  castdata.distforward = castdatalvl.distforward[castid];
  castdata.distdown = castdatalvl.distdown[castid];
  castdata.distup = castdatalvl.distup[castid];
  castdata.maxcasts = castdatalvl.maxcasts[castid];
  castdata.maxfails = castdatalvl.maxfails[castid];
  castdata.maxents = castdatalvl.maxents[castid];
  castdata.distforwardwall = castdatalvl.distforwardwall[castid];

  if(isDefined(castdatalvl.firstforwarddist[castid])) {
    castdata.firstforwarddist = castdatalvl.firstforwarddist[castid];
    castdata.firstforwardmindist = castdatalvl.firstforwardmindist[castid];
    castdata.firstforwardmodanglesfunc = castdatalvl.firstforwardmodanglesfunc[castid];

    if(isDefined(castdatalvl.firstforwarddistwall[castid])) {
      castdata.firstforwarddistwall = castdatalvl.firstforwarddistwall[castid];
    }
  }

  return castdata;
}

function molotov_get_pool_data(typeid) {
  if(!(isDefined(level.molotovdata) && isDefined(level.molotovdata.pooldata))) {
    molotov_init_pool_data();
  }

  pooldatalvl = level.molotovdata.pooldata;
  pooldata = spawnStruct();
  pooldata.typeid = typeid;
  pooldata.triggerradius = pooldatalvl.triggerradius[typeid];
  pooldata.triggerheight = pooldatalvl.triggerheight[typeid];
  pooldata.aikillradius = pooldatalvl.aikillradius[typeid];
  pooldata.aidamageradius = pooldatalvl.aidamageradius[typeid];
  pooldata.triggeroffset = pooldatalvl.triggeroffset[typeid];
  pooldata.startdelayms = pooldatalvl.startdelayms[typeid];
  pooldata.dangerzoneradius = pooldatalvl.dangerzoneradius[typeid];
  pooldata.dangerzoneheight = pooldatalvl.dangerzoneheight[typeid];
  return pooldata;
}

function molotov_get_cast_dir(angles, casttype) {
  switch (casttype) {
    case 0:
      return anglesToForward(angles);
    case 1:
      return (-1 * anglestoup(angles));
    case 2:
      return anglestoup(angles);
  }

  return undefined;
}

function molotov_get_cast_dist(casttype, castdata, iswallcast) {
  switch (casttype) {
    case 0:
      if(isDefined(castdata.firstforwarddist)) {
        return castdata.firstforwarddist;
      } else if(iswallcast && isDefined(castdata.distforwardwall)) {
        return castdata.distforwardwall;
      } else {
        return castdata.distforward;
      }
    case 1:
      return castdata.distdown;
    case 2:
      return castdata.distup;
  }

  return undefined;
}

function molotov_get_cast_contents() {
  return physics_createcontents(["\xb3 c1\xa3\xab\x05/\x96c\xec\x02~5\a\xadz\xb9\xe6\xd8B", "\xce\xd8oGC\x8e\xf6\xde\x1b\xfe\x1f\xe5\xc0\x88-eADHGN", "\x96)?\xdbyq7\xde\x80 \x99\xfc\x9e-\xfe\xa7\xcd\r\x13\xba", "\xa3?\a\nru\xf2\xe6\x96\xb7\xd0\xcc\x97]4\x12n\xd3\xd3)\xcb\xae."]);
}

function molotov_rebuild_angles_up_right(up, right) {
  forward = vectorNormalize(vectorcross(up, right));
  right = vectorcross(forward, up);
  return axistoangles(forward, right, up);
}

function molotov_rebuild_angles_up_forward(up, forward) {
  right = vectorNormalize(vectorcross(forward, up));
  forward = vectorcross(up, right);
  return axistoangles(forward, right, up);
}

function molotov_get_next_burning_id() {
  if(!isDefined(level.molotovdata)) {
    level.molotovdata = spawnStruct();
  }

  if(!isDefined(level.molotovdata.burningid)) {
    level.molotovdata.burningid = 0;
  }

  id = level.molotovdata.burningid;
  level.molotovdata.burningid++;
  return id;
}

function molotov_watch_fx() {
  self notify("\x05\x18 \x82y7\x8e<\xe5\x9a7[\x95aN");
  self endon("\x05\x18 \x82y7\x8e<\xe5\x9a7[\x95aN");
  watchheldoffhandbreak = 0;

  while(true) {
    raceresult = spawnStruct();

    if(watchheldoffhandbreak) {
      childthread molotov_fx_race_held_offhand_break(raceresult);
    } else {
      childthread molotov_fx_race_pullback(raceresult);
    }

    childthread molotov_fx_race_grenade_fired(raceresult);
    childthread molotov_fx_race_super_started(raceresult);
    childthread molotov_fx_race_death(raceresult);
    childthread molotov_fx_race_taken(raceresult);
    watchheldoffhandbreak = 0;
    self waittill("\xf1}\xb2\xd4\xe0\x81\xe4\x03}\x94pHF\x9a\xe1\x0f\x93\xc4\xdd\xc9M");
    waittillframeend();
    pullback = istrue(raceresult.pullback);
    fire = istrue(raceresult.fire);
    superstarted = istrue(raceresult.superstarted);
    death = istrue(raceresult.death);
    taken = istrue(raceresult.taken);
    heldoffhandbreak = istrue(raceresult.heldoffhandbreak);

    if(death) {
      self notify("w\xde=\xae\xf0\xb35\xf54X\xda\xf8\x17\xd6\xe3\xf4,\xeb\x9b");
      thread molotov_end_fx();
      return;
    } else if(taken) {
      self notify("w\xde=\xae\xf0\xb35\xf54X\xda\xf8\x17\xd6\xe3\xf4,\xeb\x9b");
      thread molotov_end_fx();
      return;
    } else if(superstarted) {
      thread molotov_end_fx();
    } else if(heldoffhandbreak) {
      thread molotov_end_fx();
    } else if(fire) {
      thread molotov_end_fx();
    } else if(pullback) {
      thread molotov_begin_fx();
      watchheldoffhandbreak = 1;
    }

    self notify("w\xde=\xae\xf0\xb35\xf54X\xda\xf8\x17\xd6\xe3\xf4,\xeb\x9b");
  }
}

function molotov_fx_race_pullback(raceresult) {
  self endon("w\xde=\xae\xf0\xb35\xf54X\xda\xf8\x17\xd6\xe3\xf4,\xeb\x9b");

  while(true) {
    self waittill("\x04\x05\x86\xdb\xa3\xa0)\xc5\xf8\x89\xc0\x9fk\x94I4", objweapon);

    if(objweapon.basename == "0\xd2m\xbd\xd9\x83\xad4^E") {
      break;
    }
  }

  raceresult.pullback = 1;
  self notify("\xf1}\xb2\xd4\xe0\x81\xe4\x03}\x94pHF\x9a\xe1\x0f\x93\xc4\xdd\xc9M");
}

function molotov_fx_race_grenade_fired(raceresult) {
  self endon("w\xde=\xae\xf0\xb35\xf54X\xda\xf8\x17\xd6\xe3\xf4,\xeb\x9b");

  while(true) {
    self waittill("\xe0\x99\xc7\xf1\a3\x81c\xa5\xe17G", grenade, objweapon);

    if(objweapon.basename == "0\xd2m\xbd\xd9\x83\xad4^E") {
      break;
    }
  }

  raceresult.fire = 1;
  self notify("\xf1}\xb2\xd4\xe0\x81\xe4\x03}\x94pHF\x9a\xe1\x0f\x93\xc4\xdd\xc9M");
}

function molotov_fx_race_super_started(raceresult) {
  self endon("w\xde=\xae\xf0\xb35\xf54X\xda\xf8\x17\xd6\xe3\xf4,\xeb\x9b");
  self waittill("\xbc\x1b\x8e\x1d@\x06\xd9\x91\xffx\x9e\xc2\xd3");
  raceresult.superstarted = 1;
  self notify("\xf1}\xb2\xd4\xe0\x81\xe4\x03}\x94pHF\x9a\xe1\x0f\x93\xc4\xdd\xc9M");
}

function molotov_fx_race_death(raceresult) {
  self endon("w\xde=\xae\xf0\xb35\xf54X\xda\xf8\x17\xd6\xe3\xf4,\xeb\x9b");
  self waittill("\x1e\xfd\xd1\xa2\a");
  raceresult.death = 1;
  self notify("\xf1}\xb2\xd4\xe0\x81\xe4\x03}\x94pHF\x9a\xe1\x0f\x93\xc4\xdd\xc9M");
}

function molotov_fx_race_taken(raceresult) {
  self endon("w\xde=\xae\xf0\xb35\xf54X\xda\xf8\x17\xd6\xe3\xf4,\xeb\x9b");
  self waittill("\xad\xdb\xb1{Gov_\xd1,\xad\x95\xdc");
  raceresult.taken = 1;
  self notify("\xf1}\xb2\xd4\xe0\x81\xe4\x03}\x94pHF\x9a\xe1\x0f\x93\xc4\xdd\xc9M");
}

function molotov_fx_race_held_offhand_break(raceresult) {
  self endon("w\xde=\xae\xf0\xb35\xf54X\xda\xf8\x17\xd6\xe3\xf4,\xeb\x9b");
  waitframe();
  weapon = makeweapon("0\xd2m\xbd\xd9\x83\xad4^E");

  while(self getheldoffhand() == weapon) {
    waitframe();
  }

  raceresult.heldoffhandbreak = 1;
  self notify("\xf1}\xb2\xd4\xe0\x81\xe4\x03}\x94pHF\x9a\xe1\x0f\x93\xc4\xdd\xc9M");
}

function molotov_begin_fx() {
  self notify("Vr\xc1M\xc0T\x062\x96|5\xc5\x10\xd0v\x0f");
  self endon("Vr\xc1M\xc0T\x062\x96|5\xc5\x10\xd0v\x0f");
  self endon("\x16Tq\x9f\xb5\xeaC\x85\xa6\x99p\xde\x97P");
  self setscriptablepartstate("Y\xb8\xaeZ\x835:{v\x8c\xc2]\xf6\x9c\x8d\x8c", "\xba\xa5\x1f\xc9m\x80i", 0);
  self setscriptablepartstate("\xdd2;\xbbk-\x8b(\xf8[`\xe7\xf3B\xdb", "\xe3\x93}=nD", 0);
  wait 0.15;
  self setscriptablepartstate("Y\xb8\xaeZ\x835:{v\x8c\xc2]\xf6\x9c\x8d\x8c", "\xe3\x93}=nD", 0);
}

function molotov_end_fx() {
  self notify("\x16Tq\x9f\xb5\xeaC\x85\xa6\x99p\xde\x97P");
  self setscriptablepartstate("Y\xb8\xaeZ\x835:{v\x8c\xc2]\xf6\x9c\x8d\x8c", "\xba\xa5\x1f\xc9m\x80i", 0);
  self setscriptablepartstate("\xdd2;\xbbk-\x8b(\xf8[`\xe7\xf3B\xdb", "\xba\xa5\x1f\xc9m\x80i", 0);
}

function delete_all_molotovs() {
  if(isDefined(level.molotovdata)) {
    foreach(struct in level.molotovdata.active) {
      thread delete_molotov(struct);
    }
  }
}

function delete_molotov(shareddata) {
  if(isDefined(shareddata.deleting)) {
    return;
  }

  shareddata.deleting = 1;

  while(!isDefined(shareddata.initialized)) {
    waitframe();
  }

  while(!shareddata molotov_shared_data_is_complete(1)) {
    waitframe();
  }

  level notify("\x8d\xcb\x84(z\x1c#l\x97\x84\x1b\x82\xc3g\xd9\xb3NE\x03\xd7", shareddata.burnsource.origin, 500);
  shareddata.burnsource delete();
}

function molotov_branch_draw_hits() {
  while(true) {
    if(istrue(self.shareddata.iscomplete)) {
      break;
    }

    if(istrue(self.iscomplete)) {
      break;
    }

    if(istrue(level.dbgmolodrawhits)) {
      ids = getarraykeys(self.hitpositions);

      foreach(id in ids) {
        hitposition = self.hitpositions[id];
        hittype = self.hittypes[id];
        function_743d33cfe761eb4b(hitposition, hittype, 0.05);
      }
    }

    wait 0.05;
  }

  if(istrue(level.dbgmolodrawhits)) {
    ids = getarraykeys(self.hitpositions);

    foreach(id in ids) {
      hitposition = self.hitpositions[id];
      hittype = self.hittypes[id];
      function_743d33cfe761eb4b(hitposition, hittype, 5);
    }
  }
}

function function_743d33cfe761eb4b(hitposition, hittype, duration) {
  color = undefined;

  switch (hittype) {
    case 0:
      color = (1, 1, 0);
      break;
    case 2:
      color = (1, 0, 0);
      break;
    case 3:
      color = (0, 0, 1);
      break;
    default:
      color = (1, 1, 1);
      break;
  }
}

# /