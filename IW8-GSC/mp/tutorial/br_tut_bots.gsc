/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\tutorial\br_tut_bots.gsc
***********************************************/

_encstr_93B81F630B228DF0A1DDE09A87B750454BA7CDEBCF9AC090F7B32EB3A86388F5B2() {
  createthreatbiasgroup("_encstr_86EA0E63792F0BFD93669B643B400113");
  createthreatbiasgroup("_encstr_820E0D3AE8486FAA4142C8D4D9D8F3");
  createthreatbiasgroup("_encstr_81190B212DE5BF153FC69B8850");
  createthreatbiasgroup("_encstr_BAAA0B39AD0C814502435B5B73");
  createthreatbiasgroup("_encstr_AF5A0D13B7D1FA2C9B9B16E66EB437");
  createthreatbiasgroup("_encstr_848E0F0AB7C8B9F74DF392BAF8302FADA0");
  setignoremegroup("_encstr_86EA0E63792F0BFD93669B643B400113", "_encstr_820E0D3AE8486FAA4142C8D4D9D8F3");
  setignoremegroup("_encstr_86EA0E63792F0BFD93669B643B400113", "_encstr_81190B212DE5BF153FC69B8850");
  setignoremegroup("_encstr_86EA0E63792F0BFD93669B643B400113", "_encstr_AF5A0D13B7D1FA2C9B9B16E66EB437");
  setignoremegroup("_encstr_820E0D3AE8486FAA4142C8D4D9D8F3", "_encstr_820E0D3AE8486FAA4142C8D4D9D8F3");
  setignoremegroup("_encstr_820E0D3AE8486FAA4142C8D4D9D8F3", "_encstr_81190B212DE5BF153FC69B8850");
  setignoremegroup("_encstr_820E0D3AE8486FAA4142C8D4D9D8F3", "_encstr_BAAA0B39AD0C814502435B5B73");
  setignoremegroup("_encstr_820E0D3AE8486FAA4142C8D4D9D8F3", "_encstr_AF5A0D13B7D1FA2C9B9B16E66EB437");
  setignoremegroup("_encstr_820E0D3AE8486FAA4142C8D4D9D8F3", "_encstr_848E0F0AB7C8B9F74DF392BAF8302FADA0");
  setignoremegroup("_encstr_BAAA0B39AD0C814502435B5B73", "_encstr_820E0D3AE8486FAA4142C8D4D9D8F3");
  setignoremegroup("_encstr_BAAA0B39AD0C814502435B5B73", "_encstr_81190B212DE5BF153FC69B8850");
  setignoremegroup("_encstr_BAAA0B39AD0C814502435B5B73", "_encstr_AF5A0D13B7D1FA2C9B9B16E66EB437");
  setignoremegroup("_encstr_BAAA0B39AD0C814502435B5B73", "_encstr_BAAA0B39AD0C814502435B5B73");
  setignoremegroup("_encstr_81190B212DE5BF153FC69B8850", "_encstr_820E0D3AE8486FAA4142C8D4D9D8F3");
  setignoremegroup("_encstr_81190B212DE5BF153FC69B8850", "_encstr_81190B212DE5BF153FC69B8850");
  setignoremegroup("_encstr_AF5A0D13B7D1FA2C9B9B16E66EB437", "_encstr_820E0D3AE8486FAA4142C8D4D9D8F3");
  setignoremegroup("_encstr_AF5A0D13B7D1FA2C9B9B16E66EB437", "_encstr_81190B212DE5BF153FC69B8850");
  setignoremegroup("_encstr_AF5A0D13B7D1FA2C9B9B16E66EB437", "_encstr_BAAA0B39AD0C814502435B5B73");
  setignoremegroup("_encstr_AF5A0D13B7D1FA2C9B9B16E66EB437", "_encstr_AF5A0D13B7D1FA2C9B9B16E66EB437");
  setignoremegroup("_encstr_848E0F0AB7C8B9F74DF392BAF8302FADA0", "_encstr_820E0D3AE8486FAA4142C8D4D9D8F3");
  level thread _encstr_A53A17BFED4DDB8AB861BF0999B0B441947333F781E3B25E80();
  level.bots["_encstr_9775086022BE1B413B8B"] = [];
  level._encstr_BE421432F8C3371C9D7073BA28C1D9B31857BCA70D2B = ::_encstr_A11311E6AC3ABE4CB7D1FAB17BB023DBBDAEA3;
}

_encstr_A53A17BFED4DDB8AB861BF0999B0B441947333F781E3B25E80() {
  level.brlatespawnplayer = ::_encstr_A3AB0F0A9898B1E12255A74113077A8760;

  while(!isDefined(level.bot_variables_initialized) || !level.bot_variables_initialized)
    waitframe();

  level.bot_random_path_function = ::_encstr_B1922098BDD1F59C85B9C8DB5BF5C9951C36168D59B59537477DCC5DDC8DE896DEE6;
}

_encstr_B1922098BDD1F59C85B9C8DB5BF5C9951C36168D59B59537477DCC5DDC8DE896DEE6() {
  return 0;
}

_encstr_A3AB0F0A9898B1E12255A74113077A8760() {
  if(isDefined(self.botskinid) && isDefined(self.botoperatorref) && isDefined(self.botoperatorteam))
    scripts\mp\teams::createoperatorcustomization();

  _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::latespawnplayer();
}

_encstr_A78F18EDD9AC939C9619ACF5C1C616E5AC9C7DD8DE9BE6AC1B47() {
  scripts\mp\playerlogic::callback_playerconnect();
}

_encstr_97A811B7B70587C5A7A3D91BE21F114A02C0CF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level.bots["_encstr_8AEF05472BC2D6"][var_0] = var_1;
  level.bots["_encstr_97FE07DE392D76D2CD"][var_0] = var_2;
  level.bots["_encstr_8B99079916D85A9BD9"][var_0] = var_3;
  level.bots["_encstr_97F209C8B3EF5D9113A7F6"][var_0] = var_4;
  level.bots["_encstr_8F0907507A940DFCCB"][var_0] = var_8;
  level.bots["_encstr_B4F607895AA980F8E3"][var_0] = var_6;
  level.bots["_encstr_A30108473FBA97C8D662"][var_0] = var_5;

  if(!isDefined(var_7))
    var_7 = var_0;

  level.bots["_encstr_8ACD0D650C63B1C029A7C140AF4DB9"][var_0] = var_7;
  level._encstr_92D20C45F9CDB8205B7296183A87[var_7] = var_0;
}

_encstr_AB6D157F07F947985932C0EB5F108A200D81918158CA57(var_0) {
  var_1 = level.bots["_encstr_8AEF05472BC2D6"][var_0];

  if(!isDefined(var_1))
    return 0;

  var_2 = level.bots["_encstr_97F209C8B3EF5D9113A7F6"][var_0];
  var_3 = level.bots["_encstr_8F0907507A940DFCCB"][var_0];
  var_4 = level.bots["_encstr_8ACD0D650C63B1C029A7C140AF4DB9"][var_0];
  _encstr_A3230AE6583683E01709D769(var_4, var_2, var_1, var_3);
  return 1;
}

_encstr_8BBE109640B7DBE5E96230F0A9BF95905FE8(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {}

  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = _encstr_8DF313D807D9390F8A7DA5389242BB0105E76840F3(var_0[var_3]);
    var_2[var_2.size] = var_4;
    var_5 = var_1[var_4];

    if(!isDefined(var_5)) {
      continue;
    }
    var_6 = 1 + (var_3 >> 4);
    level thread _encstr_AABC1838A2CD8BD3DF1AC044EF437E47B2AA70A8BAE7AF698724(var_4, var_5, var_6);
    _encstr_AB6D157F07F947985932C0EB5F108A200D81918158CA57(var_4);
  }

  var_7 = 1;

  while(var_7) {
    waitframe();
    var_7 = 0;

    foreach(var_9 in var_2) {
      if(!isalive(_encstr_B60F0B198D2CA1ED82BBA39167(var_9)))
        var_7 = 1;
    }
  }

  level._encstr_AF8C0B39AD0C5048D23F43536F = var_2;
}

_encstr_9AC615A743A8ED6B26C0E8CB4BA9825D094143DDFCEDB7() {
  var_0 = 0;

  foreach(var_2 in level._encstr_AF8C0B39AD0C5048D23F43536F) {
    if(!_encstr_B60F0B198D2CA1ED82BBA39167(var_2) scripts\engine\utility::is_dead_sentient())
      var_0++;
  }

  return var_0;
}

_encstr_AABC1838A2CD8BD3DF1AC044EF437E47B2AA70A8BAE7AF698724(var_0, var_1, var_2) {
  for(;;) {
    level waittill("_encstr_8A8C0CA5DF23C8F0702E9348D7FC", var_3);

    if(isDefined(level.bots["_encstr_9775086022BE1B413B8B"][var_0])) {
      var_4 = _encstr_B60F0B198D2CA1ED82BBA39167(var_0);
      var_4 setsquadindex(var_2);
      var_4 thread _encstr_AF831133B7B18DDEDDAFBB0BE538DED2733ADC(var_1);
      break;
    }
  }
}

_encstr_8E011E97E736B3CB58D2A811E6F5EBF00559C3F3E5A9EFF841363480BF6E8F7B(var_0) {
  if(_encstr_AB6D157F07F947985932C0EB5F108A200D81918158CA57(var_0)) {
    for(;;) {
      level waittill("_encstr_8A8C0CA5DF23C8F0702E9348D7FC", var_1);

      if(isDefined(level.bots["_encstr_9775086022BE1B413B8B"][var_0])) {
        break;
      }
    }
  }
}

_encstr_8F631620BBE62F08B7B260E59B8F31EDCDF2C9E042FEA121() {
  self waittill("_encstr_A1E00B25BA2FD7DBEA6085B830");

  if(level.player.size == 1) {
    level._encstr_AF350CD998613F3A45B0D279C8B1 = 1;

    foreach(var_4, var_1 in level.bots["_encstr_8AEF05472BC2D6"]) {
      var_2 = level.bots["_encstr_97F209C8B3EF5D9113A7F6"][var_4];
      var_3 = level.bots["_encstr_8F0907507A940DFCCB"][var_4];
      scripts\engine\utility::delaythread(5, ::_encstr_A3230AE6583683E01709D769, var_4, var_2, var_1, var_4, var_3);
    }
  }
}

_encstr_A3230AE6583683E01709D769(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._encstr_AF350CD998613F3A45B0D279C8B1))
    level._encstr_AF350CD998613F3A45B0D279C8B1 = 1;

  level.maxteamsize = 4;
  var_4 = addbot(var_0);
  var_4.botoperatorref = var_1;

  if(isDefined(var_3)) {
    var_4.botoperatorteam = scripts\engine\utility::ter_op(var_2 == "_encstr_9A8507BA4040188D08", 0, 1);
    var_4.botskinid = var_3;
  }

  var_4._encstr_A9660A5937472D3AE5EB2D8C = level._encstr_AF350CD998613F3A45B0D279C8B1;
  level._encstr_AF350CD998613F3A45B0D279C8B1 = level._encstr_AF350CD998613F3A45B0D279C8B1 + 1;
  var_5 = spawnStruct();
  var_5.bot = var_4;
  var_5.ready = 0;
  var_5.abort = 0;
  var_5.index = 1;
  var_5.difficulty = undefined;
  var_5.bot thread scripts\mp\bots\bots::spawn_bot_latent(var_2, undefined, var_5);
}

_encstr_81CD1337958ED5C1EB8ED51DB793B42C8DAFC4F6D1() {
  var_0 = self;
  var_1 = var_0.name;
  var_2 = level._encstr_92D20C45F9CDB8205B7296183A87[var_1];
  var_0.key = var_2;
  level.bots["_encstr_99AD06D3A5B1538B"][var_2] = gettime();
  level.bots["_encstr_9775086022BE1B413B8B"][var_2] = var_0;

  if(!_encstr_8BEF0B016AA30EAA4897AA412F(var_2)) {
    return;
  }
  var_3 = level.bots["_encstr_B4F607895AA980F8E3"][var_2];
  var_0.botoperatorteam = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
  var_0 setOrigin(level.bots["_encstr_97FE07DE392D76D2CD"][var_2]);
  var_0 setplayerangles((0, level.bots["_encstr_8B99079916D85A9BD9"][var_2], 0));
  var_0 botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 1);
  var_0 botsetflag("_encstr_BE321128AF7B29C53AAF40DE05930B33D91FE0", 1);

  if(!isDefined(level._encstr_BE421432F8C3371C9D7073BA28C1D9B31857BCA70D2B))
    level._encstr_BE421432F8C3371C9D7073BA28C1D9B31857BCA70D2B = ::_encstr_928D1029778257409CEB16299275D91ECA9B;

  var_0[[level._encstr_BE421432F8C3371C9D7073BA28C1D9B31857BCA70D2B]]();
  var_4 = var_0 getthreatbiasgroup();
  var_0 setthreatbiasgroup("_encstr_820E0D3AE8486FAA4142C8D4D9D8F3");
  var_0 thread[[var_3]]();
  level notify("_encstr_8A8C0CA5DF23C8F0702E9348D7FC", var_0);
}

_encstr_928D1029778257409CEB16299275D91ECA9B() {
  while(!isDefined(self.lastnormalweaponobj))
    waitframe();

  var_0 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::degrees_to_radians("_encstr_AD07034A38", "_encstr_A56005CAC14BD8");
  var_1 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::degrees_to_radians("_encstr_A607036B40", "_encstr_879105B17BDAB5");
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_3 = scripts\mp\utility\weapon::getweaponrootname(var_1);
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_forcegiveweapon(var_1, self, undefined);
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_forcegiveweapon(var_0, self, undefined);

  foreach(var_5 in self getweaponslistprimaries()) {
    self setweaponammoclip(var_5, weaponclipsize(var_5));
    self setweaponammostock(var_5, weaponmaxammo(var_5));
  }
}

_encstr_A11311E6AC3ABE4CB7D1FAB17BB023DBBDAEA3() {
  if(!isDefined(self.key) || !isDefined(level.bots["_encstr_A30108473FBA97C8D662"][self.key])) {
    _encstr_928D1029778257409CEB16299275D91ECA9B();
    return;
  }

  var_0 = level.bots["_encstr_A30108473FBA97C8D662"][self.key];
  var_1 = strtok(var_0, "_encstr_964C0249");

  foreach(var_3 in var_1)
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_forcegiveweapon(var_3, self, undefined);

  foreach(var_6 in self getweaponslistprimaries()) {
    self setweaponammoclip(var_6, weaponclipsize(var_6));
    self setweaponammostock(var_6, weaponmaxammo(var_6));
  }
}

_encstr_8A56136B52D345782198033BB955398F1B8AA2D14B() {
  var_0 = self;
  var_1 = var_0 getsquadindex();
  var_2 = var_0 getthreatbiasgroup();
  var_0 setthreatbiasgroup("_encstr_86EA0E63792F0BFD93669B643B400113");
  var_0 setsquadindex(0);
}

_encstr_8A740FDE35AB57EB8963E8317FCCA06BB3(var_0, var_1) {
  var_2 = level.bots["_encstr_9775086022BE1B413B8B"][var_1];
  self calloutmarkerping_create(4 + var_0, (0, 0, 82), var_2._encstr_A9660A5937472D3AE5EB2D8C);
}

_encstr_A5B815D9D8D108C7D27D9816287BA878CAC17F19A31FC3(var_0) {
  self calloutmarkerping_delete(4 + var_0);
}

_encstr_AA3B154BF92BF69F98F1B26BBEEDD32FE863FFC013A03F() {
  var_0 = self.team;

  for(var_1 = 1; var_1 <= 2; var_1++) {
    var_2 = self calloutmarkerping_getsavedzoffset(var_1);

    if(isDefined(var_2) && var_2.team != var_0)
      return var_2;
  }
}

_encstr_A1390CD35B63B9E1E8913BFF1FF3(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_2))
    var_2 = 40;

  self.message = "_encstr_93FE0B5B20FB3B87D0A43E26EF" + var_0;
  wait(var_0);
  self botsetscriptgoal(var_1, var_2, "_encstr_99C209E34FC743616118AB", undefined, undefined, 1);
  self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 0);
  self botsetflag("_encstr_BE321128AF7B29C53AAF40DE05930B33D91FE0", 0);
  self.message = "_encstr_8FFD08735566BED3A8F9" + var_1;
  var_4 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(var_3);

  if(var_4 == "_encstr_8B7205D9ED5958")
    self.message = "_encstr_82DF0A2315C638C3CF1F55B2" + var_4;
  else if(isDefined(var_3)) {
    self botclearscriptgoal();
    self.message = "_encstr_AAC427B538B84F4BA8E8558B70AEABE5EFD4B71A32D8E533A3AB88AFD683A0C9DBB7A6FB9557381310";
    self setOrigin(var_1);
  }
}

_encstr_AA2914B31933B3D7A3989866EE7B3DE5696B18A3D902(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self.message = "_encstr_93FE0B5B20FB3B87D0A43E26EF" + var_0;
  wait(var_0);
  self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 0);
  self botsetflag("_encstr_BE321128AF7B29C53AAF40DE05930B33D91FE0", 0);
  var_2 = "_encstr_8B7205D9ED5958";

  foreach(var_4 in var_1) {
    self botsetscriptgoal(var_4, 40, "_encstr_99C209E34FC743616118AB", undefined, undefined, 1);
    self.message = "_encstr_8FFD08735566BED3A8F9" + var_4;
    var_2 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
    self.message = "_encstr_82DF0A2315C638C3CF1F55B2" + var_2;

    if(var_2 != "_encstr_8B7205D9ED5958")
      return var_2;
  }

  if(var_2 == "_encstr_8B7205D9ED5958")
    self notify("_encstr_858D0D93DD9BCF878801F37887BB0A");

  return var_2;
}

_encstr_BEA510339742819703472FBD5EBB3B69B42F(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  while(var_1 >= 0) {
    self.message = "_encstr_9B2B084E936B8785D712" + var_1;
    var_1 = var_1 - 1;
    wait(var_0);
    self botpressbutton("_encstr_999A07C61338F9A23A");
  }

  self.message = "_encstr_B4250E393885BF61778B250B25E7D505";
  self notify("_encstr_858D0D93DD9BCF878801F37887BB0A");
}

_encstr_8BEF0B016AA30EAA4897AA412F(var_0) {
  return isDefined(level.bots["_encstr_8AEF05472BC2D6"]) && isDefined(level.bots["_encstr_8AEF05472BC2D6"][var_0]);
}

_encstr_B60F0B198D2CA1ED82BBA39167(var_0) {
  return level.bots["_encstr_9775086022BE1B413B8B"][var_0];
}

_encstr_8B2610910594195EEB7717DD7713A860565B(var_0) {
  return level.bots["_encstr_97FE07DE392D76D2CD"][var_0];
}

_encstr_92CA0B89ED3AFAB9B7A3A5CCBC(var_0, var_1) {
  if(isDefined(level.bots["_encstr_9775086022BE1B413B8B"][var_0]))
    level.bots["_encstr_9775086022BE1B413B8B"][var_0] notify(var_1);
}

_encstr_9207147CB8219BD1E198E27BC83D1913999EFFED4D0B(var_0) {
  self._encstr_87350DDBF1E5433148338A67C3B0C2 = [];
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      var_4 = var_3.script_noteworthy;

      if(isDefined(var_4))
        self._encstr_87350DDBF1E5433148338A67C3B0C2[var_4] = var_3.origin;
    }
  }
}

_encstr_8DF313D807D9390F8A7DA5389242BB0105E76840F3(var_0) {
  if(!isDefined(var_0))
    return undefined;

  if(!isDefined(var_0.script_noteworthy))
    return undefined;

  var_1 = var_0.script_noteworthy;

  if(!isDefined(var_0.script_namenumber) || !isDefined(var_0.script_team))
    return undefined;

  var_2 = var_0.script_namenumber;
  var_3 = var_0.script_team;
  var_4 = undefined;

  if(isDefined(var_0.script_wtf))
    var_4 = int(var_0.script_wtf);

  var_5 = undefined;

  if(isDefined(var_0.script_parameters))
    var_5 = var_0.script_parameters;

  var_6 = var_1;

  if(isDefined(var_0.script_label))
    var_6 = var_0.script_label;

  var_7 = var_0.origin + (0, 0, 3);
  var_8 = var_0.angles[1];
  _encstr_97A811B7B70587C5A7A3D91BE21F114A02C0CF(var_1, var_3, var_7, var_8, var_2, var_5, _encstr_AAA0279653FB18D9237332385BAD99D35BF79E03A96B08C58AD9E0F03359434B476CAB05193A492F36::_encstr_96610ECD11AB73C055386AB2D8A3BDE3, var_6, var_4);
  return var_1;
}

_encstr_AC37151BEDC291F5C6F63B5AD8BEBB58BC837BA5B9D16E(var_0) {
  var_1 = [];
  var_2 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_2)) {
    foreach(var_4 in var_2) {
      var_5 = var_4.script_noteworthy;
      var_6 = var_4.script_namenumber;

      if(!isDefined(var_5) || !isDefined(var_6)) {
        continue;
      }
      if(!isDefined(var_1[var_5]))
        var_1[var_5] = [];

      var_1[var_5][var_6] = var_4;

      if(isDefined(var_4.script_startname) && !scripts\engine\utility::flag_exist(var_4.script_startname))
        scripts\engine\utility::flag_init(var_4.script_startname);

      if(isDefined(var_4.script_triggername) && !scripts\engine\utility::flag_exist(var_4.script_triggername))
        scripts\engine\utility::flag_init(var_4.script_triggername);
    }
  }

  return var_1;
}

_encstr_B27E169B95E8F5C136852FAC9CAFB0471D9C5A98EAA3AC9B(var_0) {
  var_1 = self;

  if(isDefined(var_0.script_difficulty))
    var_1 botsetdifficulty(var_0.script_difficulty);

  if(isDefined(var_0.script_pathtype))
    var_1 botsetpathingstyle(var_0.script_pathtype);

  if(isDefined(var_0.script_stance))
    var_1 botsetstance(var_0.script_stance);

  if(isDefined(var_0.script_threatbiasgroup))
    var_1 setthreatbiasgroup(var_0.script_threatbiasgroup);

  if(isDefined(var_0.speed))
    var_1 scripts\engine\utility::set_movement_speed();

  if(isDefined(var_0.script_flag)) {
    var_2 = strtok(var_0.script_flag, "_encstr_964C0249");

    foreach(var_4 in var_2) {
      var_5 = strtok(var_4, "_encstr_AB4C0246");
      var_1 botsetflag(var_5[0], int(var_5[1]));
    }
  }
}

_encstr_AF831133B7B18DDEDDAFBB0BE538DED2733ADC(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A3540FB76AB743F9C16B28E033E59B98B3");
  self endon("_encstr_ACCF0A3B0BD6B2EBDB3BAC27");
  var_1 = self;

  for(var_2 = var_0["_encstr_99AD06F3A5B1538B"]; isDefined(var_2); var_2 = var_0[var_2.target]) {
    if(isDefined(var_2.script_delay))
      wait(var_2.script_delay);

    if(isDefined(var_2.script_startname))
      scripts\engine\utility::flag_wait(var_2.script_startname);

    var_1 _encstr_B27E169B95E8F5C136852FAC9CAFB0471D9C5A98EAA3AC9B(var_2);

    if(isDefined(var_2.script_objective)) {
      if(var_2.script_objective == "_encstr_B16705D9AFE22E")
        var_1 _encstr_A7F00E3F6951B167349B43D18737A062(var_2);
      else if(var_2.script_objective == "_encstr_84B608D87BDED6AF851D") {
        var_3 = 0.1;

        if(isDefined(var_2.script_wait))
          var_3 = var_2.script_wait;

        var_1 botlookatpoint(var_2.origin, var_3);
      } else
        var_1 _encstr_8B151AE04BF897232576528AF80D47CBA81D654FF9489EDF55A86A52(var_2);
    }

    if(isDefined(var_2.script_wait))
      wait(var_2.script_wait);

    if(isDefined(var_2.script_triggername))
      scripts\engine\utility::flag_set(var_2.script_triggername);

    if(!isDefined(var_2.target)) {
      break;
    }
  }
}

_encstr_8B151AE04BF897232576528AF80D47CBA81D654FF9489EDF55A86A52(var_0) {
  var_1 = self;
  var_2 = var_0.origin;
  var_3 = var_0.angles[1];
  var_4 = 10;

  if(isDefined(var_0.radius))
    var_4 = var_0.radius;

  var_1 botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 0);
  var_1 botsetflag("_encstr_BE321128AF7B29C53AAF40DE05930B33D91FE0", 0);
  var_1 botclearscriptgoal();
  var_5 = var_1 botsetscriptgoal(var_2, var_4, var_0.script_objective, var_3, undefined, 1);

  if(!var_5)
    return var_5;

  var_5 = var_1 scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
  return 1;
}

_encstr_A7F00E3F6951B167349B43D18737A062(var_0) {
  var_1 = 200;

  if(isDefined(var_0.script_radius))
    var_1 = var_0.script_radius;

  var_2 = getentitylessscriptablearrayinradius(undefined, undefined, var_0.origin, var_1, "_encstr_B16705D9AFE22E");

  if(!isDefined(var_0.script_parameters) || var_2.size == 0) {}

  foreach(var_4 in var_2)
  var_4 _encstr_AAA0279653FB18D9237332385BAD99D35BF79E03A96B08C58AD9E0F03359434B476CAB05193A492F36::_encstr_8E881ACBE01DAC33635782B47D2E2B757F937182E09BA2AF9B4B87BE(var_0.script_parameters);
}