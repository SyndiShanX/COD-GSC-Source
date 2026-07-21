/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_heli_boss.gsc
******************************************************************/

heli_boss_precache() {
  level._effect["_encstr_B8DC10183F8D7457BF7738A11271B8E0B44D"] = loadfx("_encstr_B1473108DAA09FE817E8786E984E91D9CD23B06873AD954143E77ED36FDB3B9BF279A080CBD9FB5ABBCC705671FFA0C55B92E0");
}

spawn_enemy_lbravo(var_0) {
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_83692117EF4F0B13ACE6D027B5B02110FFF14F0F7DB55893F709F0DEC1BD7551BB38A3");

  if(scripts\engine\utility::flag_exist("_encstr_B6520A8E7852C3499BE8AC34"))
    scripts\engine\utility::flag_set("_encstr_B6520A8E7852C3499BE8AC34");

  var_1 = scripts\engine\utility::getStructArray("_encstr_9B6810FA67AB0B71335563A1E7C3AB89EF2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1[0];

  if(!isDefined(var_2.angles))
    var_2.angles = (0, 0, 0);

  level.heli = spawnVehicle("_encstr_A2BD1F3BCA341CEB5B5A1BEBB096C9EB36984EB067EDFABBB258E0DE37DCD76C83", "_encstr_87C20DC686BD83E02B9C7D13DEB9CD", "_encstr_85DC1042C9BE0F13E827C9C67DF0DDAF6EE3", var_2.origin, var_2.angles);
  level.heli.spawnpoint = var_2;
  level.heli.isheli = 1;
  level.all_spawned_vehicles[level.all_spawned_vehicles.size] = level.heli;
  level.heli.vehicletype = "_encstr_88CD07337F8B2B8083";
  level.heli.health = 50000;
  level.heli.maxhealth = 50000;
  level.heli.team = "_encstr_8E8405EA382B2A";
  level.heli setvehicleteam(level.heli.team);
  level.heli setmaxpitchroll(15, 15);
  level.heli.health_remaining = 2500;
  level.heli.evade_radius = 1000;
  level.heli.bullets_can_damage = 1;
  level.heli.obj_pregame = "_encstr_A2ED16F027DC8017F20327BDDF8997EB398398D1A367792B";
  level.heli thread flag_think(var_0, 1);
  level.heli thread setup_pilot("_encstr_AB680B55361AD76B09EB28E886", (0, 0, -20));
  level.heli thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor(var_0);
  level.heli sethoverparams(25, 15, 10);
  level.heli._id_11E98 = 1;
  level.heli.circle_radius = 800;
  level.heli.should_move_to_target_dist = 2400;
  level.heli.heli_can_target_dist = 1800;
  level.heli.new_target_dist = 1200;
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(level.heli);
  level.heli thread follow_path_until("_encstr_8C671589320F0641ACD57173C75283C7B7BAA6B03AA335");
}

spawn_fake_damage_fx() {
  self.fx_ent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  self.fx_ent.angles = self.angles;
  self.fx_ent setModel("_encstr_A662158433C82147C6287A82D08883A6D89B1E1737A8B0");
  self.fx_ent linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

flag_think(var_0, var_1) {
  level.heli endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0) && scripts\engine\utility::flag_exist(var_0))
    scripts\engine\utility::flag_wait(var_0);

  if(istrue(var_1))
    level thread scripts\cp\helicopter\cp_helicopter::heli_rocket_think_default(level.heli);
  else
    level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(level.heli);
}

follow_path_until(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\engine\utility::getStructArray(self.spawnpoint.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1[0];

  while(isDefined(var_2)) {
    self cleartargetyaw();
    self cleargoalyaw();
    self.gotopos = var_2.origin;
    var_3 = self.gotopos;

    if(distance2dsquared(self.origin, var_3) > 640000) {
      self setneargoalnotifydist(300);
      self vehicle_setspeed(40, 30, 30);
      self setvehgoalpos(var_3, 0);
    } else {
      self vehicle_setspeed(15, 12, 12);
      self setvehgoalpos(var_3, 0);
    }

    scripts\engine\utility::_id_143BB(15, "_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_B4D10ADC950BE4EB76DE8536");

    if(isDefined(var_2.target) && var_2.target != var_0) {
      var_1 = scripts\engine\utility::getStructArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_2 = var_1[0];
      continue;
    }

    break;
  }

  var_4 = var_2;
  var_1 = scripts\engine\utility::getStructArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1[0];
  arrive_at_exfil_location(self, var_2, var_4);
}

initbunker11keypad() {
  self endon("_encstr_8B7205D9ED5958");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(self))
        thread _id_11D92(var_1);
    }

    waitframe();
  }
}

_id_11D92(var_0) {
  var_1 = var_0.origin - self.origin;
  var_1 = vectorNormalize(var_1);
  var_1 = var_1 * 200;
  var_1 = (var_1[0], var_1[1], 0);
  var_0 setOrigin(var_0.origin + var_1, 1);
  waitframe();
  var_0 dodamage(var_0.health + 1000, var_0.origin, self, self, "_encstr_AB590C99ED78875F650F3951034D");
}

arrive_at_exfil_location(var_0, var_1, var_2) {
  var_0 setvehgoalpos(var_2.origin, 1);
  var_0 waittill("_encstr_8B7205D9ED5958");
  var_0 settargetyaw(var_1.angles[1]);
  var_0 setyawspeed(40, 25, 25, 0);
  var_0 thread initbunker11keypad();
  wait 3;
  level notify("_encstr_AF0119589B2260A512E98715F14AE1C9915B21A807CBB969FA8D08");
  var_0.goalradius = 4;
  var_0 setvehgoalpos(var_1.origin, 1);
  var_0 waittill("_encstr_8B7205D9ED5958");
  var_0 vehicle_setspeedimmediate(0);
  var_0 thread heli_sfx_shutdown();
  var_0 vehicle_cleardrivingstate();
  var_0 notify("_encstr_88900C8656D84BD7B185B932598C");
  var_0.landed = 1;
}

heli_sfx_shutdown() {
  self endon("_encstr_AD75063D571AE108");
  self playSound("_encstr_957B1923D3C7A76B4891B3FBBBA1D8EF18988180501F55E59507C8");
  wait 2;
  self vehicle_turnengineoff();
  level scripts\engine\utility::_id_143A5("_encstr_86E50C03102BF76A7B07239CF817", "_encstr_BE730C64D1181181DDB5FFDF9FF5");
  self playSound("_encstr_A147180EA249715BDED7A3202BD770BBA20CE88E3AE2DF60AD03");
  wait 2;
  self vehicle_turnengineon();
}

setup_pilot(var_0, var_1, var_2) {
  var_3 = "_encstr_BDF30A3B51CCFF9AC049F7D4";

  if(isDefined(var_0))
    var_3 = var_0;

  var_4 = (0, 0, 0);

  if(isDefined(var_1))
    var_4 = var_1;

  var_5 = (0, 0, 0);

  if(isDefined(var_2))
    var_5 = var_2;

  if(!self tagexists(var_3))
    var_3 = "_encstr_AB680B55361AD76B09EB28E886";

  self.pilot = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin(var_3));
  self.pilot setModel("_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4");
  self.pilot linkTo(self, var_3, var_4, var_5);
  self.pilot scriptmodelplayanim("_encstr_B84A1673790882CCD038D6513378185BFD994FE3C3C91AAC");
}

heli_damagemonitor(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = 0;
  self.health = 1000000;
  var_2 = 2500;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);
    self.health = 1000000;

    if(isDefined(var_4) && var_4 == self) {
      continue;
    }
    if(isDefined(var_16) && isDefined(var_16.owner) && var_16.owner == self) {
      continue;
    }
    if(is_snipe_kill(var_4, var_6, var_12)) {
      var_1++;

      if(var_1 == 2) {
        var_4 scripts\cp\cp_achievement::scriptable_enginedamaged();
        var_4 thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_BD2118AD2DD8C6BE9BDCD76CA1F6E0C1CAE47DB9ABC107EDC9E8");
        thread do_heli_crash(var_4);
        return;
      }

      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8", 1);
      self.needs_to_evade = 1;
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      self notify("_encstr_B8950FB9AC59C8DCF5E8F6AF5667C246CA");
      continue;
    }

    if(!isexplosivedamagemod(var_7)) {
      if(istrue(self.bullets_can_damage))
        var_3 = var_3 * 0.1;
      else
        var_3 = 0;

      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_A5D20E0DD2E8C2C9D6F627D09516675E");
    } else {
      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8");

      if(isDefined(var_12) && var_12.basename == "_encstr_A93010035F88EE71B82FAD78F10352C7C518") {
        switch (var_12.basename) {
          case "_encstr_A93010035F88EE71B82FAD78F10352C7C518":
            break;
          case "_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18":
            var_3 = 1400;
            break;
          default:
            break;
        }
      } else if(var_3 < 700)
        var_3 = 700;

      if(isDefined(var_0) && !scripts\engine\utility::flag(var_0))
        scripts\engine\utility::flag_set(var_0);
      else {
        if(!self.needs_to_evade)
          self.needs_to_evade = 1;

        self notify("_encstr_B8950FB9AC59C8DCF5E8F6AF5667C246CA");
        self vehicle_setspeed(100, 100, 100);
        self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
      }
    }

    self.health_remaining = self.health_remaining - var_3;

    if(self.health_remaining <= var_2 * 0.25 && !isDefined(self.deathfx2)) {
      self setscriptablepartstate("_encstr_AD411231DB23CBBE8CC2D616B395AFA1ACB0ECE5", "_encstr_AB0703DBB9");
      self.deathfx2 = 1;
    } else if(self.health_remaining <= var_2 * 0.5 && !isDefined(self.deathfx1)) {
      self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_AB0703DBB9");
      self.deathfx1 = 1;
    } else if(self.health_remaining <= var_2 * 0.75 && !isDefined(self.deathfx)) {
      self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_AB0703DBB9");
      self.deathfx = 1;
    }

    if(self.health_remaining <= 0) {
      if(isDefined(var_12) && issubstr(var_12.basename, "_encstr_8DCB085BEF657B4DCF0B")) {
        if(isDefined(var_4) && isPlayer(var_4))
          var_4 thread scripts\cp\cp_achievement::scriptable_setups();
      }

      if(isDefined(var_4) && isPlayer(var_4))
        var_4 thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_BD2118AD2DD8C6BE9BDCD76CA1F6E0C1CAE47DB9ABC107EDC9E8");

      playFX(level._effect["_encstr_B8DC10183F8D7457BF7738A11271B8E0B44D"], self.origin);
      level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);

      if(isDefined(self.minigun))
        self.minigun delete();

      if(isDefined(self.pilot))
        self.pilot delete();

      self delete();
    }
  }
}

is_snipe_kill(var_0, var_1, var_2) {
  var_3 = isDefined(var_2) && isDefined(var_2.classname) && var_2.classname == "_encstr_850707F7E5833355B8";

  if(!ispointnearpilot(self, var_1) || !var_3)
    return 0;

  return 1;
}

do_heli_crash(var_0) {
  thread crash_deathfx();
  self.vehicle_skipdeathmodel = 1;
  self.delay_before_delete = 0.25;
  level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
  self notify("_encstr_AD75063D571AE108", var_0, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", undefined, self.origin);
  scripts\common\vehicle_code::vehicle_docrash(var_0, "_encstr_AF07075BAD51B88D02");
  self makecorpse();
}

crash_deathfx() {
  self waittill("_encstr_A5D616CECAD0D28DC656F5C89516471A1A7B5BC1D895E8CA", var_0);
  playFX(level._effect["_encstr_B14E143325DB1182B8F8959E5698D09BB95FBFC78F08"], var_0 + (0, 0, -100));
  playsoundatpos(var_0, "_encstr_B4E1196C83BE1327AFE6CB9CDAAF8D43DBE0C159C97DC693B0DCD0");
}

ispointnearpilot(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoleft(self.angles);
  var_4 = self.origin + var_2 * 133 + (0, 0, -70);
  var_5 = self.origin + var_2 * 112 + var_3 * 17 + (0, 0, -70);
  var_6 = self.origin + var_2 * 112 + (0, 0, -50);

  if(distance(var_1, var_4) <= 20)
    return 1;

  if(distance(var_1, var_5) <= 20)
    return 1;

  if(distance(var_1, var_6) <= 20)
    return 1;

  return 0;
}