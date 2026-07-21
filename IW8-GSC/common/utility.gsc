/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\utility.gsc
***********************************************/

issp() {
  if(!isDefined(level.issp)) {
    var_0 = getDvar("_encstr_9570084B1793A090CDFF");
    var_1 = "_encstr_B40101";

    for(var_2 = 0; var_2 < min(var_0.size, 3); var_2++)
      var_1 = var_1 + var_0[var_2];

    level.issp = var_1 != "_encstr_A919041BB069" && var_1 != "_encstr_8A19049A2817";
  }

  return level.issp;
}

iscp() {
  return scripts\engine\utility::string_starts_with(getDvar("_encstr_9570084B1793A090CDFF"), "_encstr_8A19049A2817");
}

ismp() {
  return scripts\engine\utility::string_starts_with(getDvar("_encstr_9570084B1793A090CDFF"), "_encstr_A919041BB069");
}

make_weapon_model(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = [];

  if(!isDefined(var_2))
    var_2 = 0;

  if(isDefined(level.fnbuildweaponspecial) && isDefined([[level.fnbuildweaponspecial]](var_0)))
    var_4 = [[level.fnbuildweaponspecial]](var_0);
  else
    var_4 = [[level.fnbuildweapon]](var_0, var_1);

  if(isent(self) && !isDefined(var_3))
    self setModel(getweaponmodel(var_4));

  var_5 = getweaponattachmentworldmodels(var_4);

  foreach(var_7 in var_5) {
    if(istrue(var_2)) {
      var_8 = strtok(var_7, "_encstr_BA4C02DF");

      foreach(var_11, var_10 in var_8) {
        if(var_11 == 0) {
          var_7 = var_10;
          continue;
        }

        if(var_10 == "_encstr_8F0703701A") {
          var_7 = var_7 + "_encstr_8C1A049F5048";
          continue;
        }

        var_7 = var_7 + "_encstr_BA4C02DF" + var_10;
      }
    }

    if(istrue(var_3)) {
      precachemodel(var_7);
      continue;
    }

    self attach(var_7);
  }

  if(!istrue(var_3)) {
    switch (var_0) {
      case "_encstr_8D900DB477077D1C2DD736E0C28385":
        self hidepart("_encstr_82B60B53A1CEE7D0DF095DC5F2");
        self hidepart("_encstr_BD590EE2B985E98BD89F4C452EE6C2BA");
        self hidepart("_encstr_BE590EA6BEC47D36F68591AC4EAF0323");
        self hidepart("_encstr_92590E839716D14C6039175FB309D8EF");
        self hidepart("_encstr_B8590EB251A23FF017F74848930F4351");
        self hidepart("_encstr_8E590E18B9D6EFD8E70155DD0AFF8BF3");
        self hidepart("_encstr_91590E4DBE13BE637BB02356C9FA601B");
        break;
      case "_encstr_A96310D2BBC1F5B9A1AF27B7B5B27BE09B06":
        self hidepart("_encstr_9640082DA72AB05D5B22");
        self hidepart("_encstr_93B30EF8D7DBA86B5A8D20B42453A3D1");
        break;
    }

    foreach(var_7 in var_5) {
      if(issubstr(var_7, "_encstr_AA1C072756CC63ACF0")) {
        self hidepart("_encstr_A6A00D6C47CFCF52AF8F437B8798A0");
        continue;
      }

      if(issubstr(var_7, "_encstr_BACC05C9770D68")) {
        self hidepart("_encstr_A6A00D6C47CFCF52AF8F437B8798A0");
        continue;
      }

      if(issubstr(var_7, "_encstr_A28305178878FF")) {
        self hidepart("_encstr_A6A00D6C47CFCF52AF8F437B8798A0");
        continue;
      }

      if(issubstr(var_7, "_encstr_87950AB973E0C9CDC67B0EAC"))
        self hidepart("_encstr_A6A00D6C47CFCF52AF8F437B8798A0");
    }
  }
}

make_weapon_and_attach(var_0, var_1, var_2, var_3, var_4) {
  if(!istrue(var_4)) {
    var_5 = 0;

    if(isent(self) || isai(self))
      var_5 = 1;
  }

  if(!isDefined(var_1))
    var_1 = [];

  if(!isDefined(var_3))
    var_3 = 0;

  if(isDefined(level.fnbuildweaponspecial) && isDefined([[level.fnbuildweaponspecial]](var_0)))
    var_6 = [[level.fnbuildweaponspecial]](var_0);
  else
    var_6 = [[level.fnbuildweapon]](var_0, var_1);

  if(!istrue(var_4)) {
    if(isDefined(var_2))
      self attach(getweaponmodel(var_0), var_2);
    else
      self attach(getweaponmodel(var_0));
  }

  self.attachedweaponmodels[0] = var_0;
  var_7 = getweaponattachmentworldmodels(var_6);

  foreach(var_9 in var_7) {
    if(istrue(var_3)) {
      var_10 = strtok(var_9, "_encstr_BA4C02DF");

      foreach(var_13, var_12 in var_10) {
        if(var_13 == 0) {
          var_9 = var_12;
          continue;
        }

        if(var_12 == "_encstr_8F0703701A") {
          var_9 = var_9 + "_encstr_8C1A049F5048";
          continue;
        }

        var_9 = var_9 + "_encstr_BA4C02DF" + var_12;
      }
    }

    if(istrue(var_4)) {
      precachemodel(var_9);
      continue;
    }

    self attach(var_9);
    self.attachedweaponmodels = scripts\engine\utility::array_add(self.attachedweaponmodels, var_9);
  }

  if(!istrue(var_4)) {
    switch (var_0) {
      case "_encstr_8D900DB477077D1C2DD736E0C28385":
        self hidepart("_encstr_82B60B53A1CEE7D0DF095DC5F2");
        self hidepart("_encstr_BD590EE2B985E98BD89F4C452EE6C2BA");
        self hidepart("_encstr_BE590EA6BEC47D36F68591AC4EAF0323");
        self hidepart("_encstr_92590E839716D14C6039175FB309D8EF");
        self hidepart("_encstr_B8590EB251A23FF017F74848930F4351");
        self hidepart("_encstr_8E590E18B9D6EFD8E70155DD0AFF8BF3");
        self hidepart("_encstr_91590E4DBE13BE637BB02356C9FA601B");
        break;
      case "_encstr_A96310D2BBC1F5B9A1AF27B7B5B27BE09B06":
        self hidepart("_encstr_9640082DA72AB05D5B22");
        self hidepart("_encstr_93B30EF8D7DBA86B5A8D20B42453A3D1");
        break;
    }

    foreach(var_9 in var_7) {
      if(issubstr(var_9, "_encstr_AA1C072756CC63ACF0")) {
        self hidepart("_encstr_A6A00D6C47CFCF52AF8F437B8798A0");
        continue;
      }

      if(issubstr(var_9, "_encstr_BACC05C9770D68")) {
        self hidepart("_encstr_A6A00D6C47CFCF52AF8F437B8798A0");
        continue;
      }

      if(issubstr(var_9, "_encstr_A28305178878FF"))
        self hidepart("_encstr_A6A00D6C47CFCF52AF8F437B8798A0");
    }
  }
}

make_weapon_random(var_0, var_1, var_2) {
  var_3 = get_random_attachments(var_1, var_2);
  var_4 = [[level.fnbuildweapon]](var_0, var_3);
  return var_4;
}

get_random_attachments(var_0, var_1) {
  if(isDefined(var_1) && var_1.size > 0) {
    if(var_0.size < 1)
      return var_1[randomint(var_1.size)];

    if(randomint(4))
      return var_1[randomint(var_1.size)];
  }

  var_2 = [];

  if(var_0.size < 1)
    return var_2;

  foreach(var_5, var_4 in var_0) {
    if(isint(var_0[var_5][0])) {
      if(randomint(100) < var_0[var_5][0])
        var_2 = scripts\engine\utility::array_add(var_2, var_4[randomint(var_4.size - 1) + 1]);

      continue;
    }

    return var_2;
  }

  var_6 = undefined;
  var_7 = undefined;

  foreach(var_5, var_9 in var_2) {
    if(issubstr(var_9, "_encstr_AD7205BC929AE9")) {
      var_7 = var_5;
      continue;
    }

    if(issubstr(var_9, "_encstr_8819045731AF"))
      var_6 = var_5;
  }

  if(isDefined(var_6) && isDefined(var_7)) {
    if(randomint(3) == 0)
      var_2 = scripts\engine\utility::array_remove_index(var_2, var_6);
    else
      var_2 = scripts\engine\utility::array_remove_index(var_2, var_7);
  }

  return var_2;
}

get_weapon_weighted(var_0, var_1) {
  var_2 = [];
  var_3 = getarraykeys(var_1);

  foreach(var_7, var_5 in var_0) {
    var_6 = scripts\engine\utility::array_find(var_3, var_5);

    if(isDefined(var_6)) {
      var_2[var_2.size] = var_1[var_3[var_6]];
      continue;
    }

    var_2[var_2.size] = 0;
  }

  var_8 = 0;

  foreach(var_10 in var_2)
  var_8 = var_8 + var_10;

  if(var_8 > 100) {}

  if(var_8 < 100) {
    var_12 = 100 - var_8;
    var_13 = 0;

    foreach(var_10 in var_2) {
      if(var_10 == 0)
        var_13 = var_13 + 1;
    }

    if(var_13 > 0) {
      var_16 = var_12 / var_13;

      foreach(var_7, var_10 in var_2) {
        if(var_10 == 0)
          var_2[var_7] = var_16;
      }
    }
  }

  var_18 = randomint(100);

  foreach(var_7, var_10 in var_2) {
    if(var_7 > 0)
      var_2[var_7] = var_10 + var_2[var_7 - 1];

    if(var_18 < var_2[var_7])
      return var_0[var_7];
  }

  if(getdvarint("_encstr_A94A17371B9CAFC90B37C8F6B5EE561638DBCDBE8C2B13AB76")) {
    if(var_0.size > 1) {}
  }

  return var_0[0];
}

lookatentity(var_0, var_1) {
  var_2 = 1;

  if(isDefined(var_1))
    var_2 = var_1;

  self.entitylookingat = var_0;

  if(isDefined(var_0)) {
    self.lookingatent = 1;
    self setlookatentity(var_0, var_2);
  } else {
    self.lookingatent = 0;
    self setlookatentity();
  }
}

lookatstateoverride(var_0) {
  self.lookatstateoverride = var_0;

  if(isDefined(var_0))
    self setlookatstateoverride(var_0);
  else
    self setlookatstateoverride();
}

civ_glancedownpath(var_0) {
  if(!isDefined(self.pathgoalpos)) {
    return;
  }
  self.internal_entitytolookat = self.entitylookingat;
  lookatentity();
  internal_civglancedownpath(gettime(), var_0);
  lookatentity(self.internal_entitytolookat);
  self.internal_entitytolookat = undefined;
  self notify("_encstr_859F10842D22ED414D5F2858B3699B398AD7");
}

internal_civglancedownpath(var_0, var_1) {
  var_2 = 2500;
  var_3 = scripts\engine\utility::ter_op(isDefined(self.lookdownpathdist), self.lookdownpathdist, 75);

  while(var_0 + var_1 > gettime()) {
    var_4 = self getposonpath(var_3);
    var_4 = var_4 + (0, 0, 60);

    if(distancesquared(self.origin, var_4) < var_2) {
      break;
    }

    self setlookat(var_4);
    waitframe();
  }

  self stoplookat();
}

glancestop() {
  self stoplookat();
}

lookatpos(var_0, var_1) {
  self notify("_encstr_B2A30AEECD934BADAF30701B");

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_0))
    self stoplookat();
  else
    self setlookat(var_0, var_1);
}

isweaponepic(var_0) {
  var_1 = getweaponattachments(var_0);

  if(!isDefined(var_1))
    return 0;

  foreach(var_3 in var_1) {
    if(issubstr(var_3, "_encstr_A56005CAC14BD8"))
      return 1;
  }

  return 0;
}

isdamageweapon(var_0) {
  var_1 = self.damageweapon;

  if(!isDefined(var_1))
    return 0;

  if(nullweapon(var_1))
    return 0;

  if(var_1.basename != getweaponbasename(var_0))
    return 0;

  return 1;
}

meleegrab_ksweapon_used() {
  var_0 = ["_encstr_8DBE10DA2C27E6EBB64B3663DC47C9B216DA", "_encstr_8F2A1EB4EECDD7A6B0B1B50BD8BEE6BA0738F6393AF58CB2CD96ECCD0B47DE27"];
  var_1 = self getcurrentweapon();

  if(scripts\engine\utility::array_contains(var_0, var_1.basename))
    return 1;

  if(self isdroppingweapon())
    return 1;

  if(self israisingweapon()) {
    if(scripts\engine\utility::array_contains(var_0, var_1.basename))
      return 1;
  }

  return 0;
}

wasdamagedbyoffhandshield() {
  if(!isDefined(self.damagemod) || self.damagemod != "_encstr_8DED0A21C79B660BC7588981")
    return 0;

  var_0 = self.damageweapon;

  if(!isDefined(var_0) || var_0.type != "_encstr_A32D07CFD14BAA94D0")
    return 0;

  return 1;
}

_id_132EC(var_0) {
  if(var_0.basename == "_encstr_8DCB085BEF657B4DCF0B" || var_0.basename == "_encstr_BA730BF8AFF178988293F158B9" || istrue(var_0.unlockableindex))
    return 1;

  return 0;
}

wasdamagedbyexplosive() {
  if(isDefined(self.damagemod)) {
    if(isexplosivedamagemod(self.damagemod))
      return 1;

    if(isDefined(self.damageweapon) && _id_132EC(self.damageweapon))
      return 1;

    if(wasdamagedbyoffhandshield())
      return 1;

    if(self.damagemod == "_encstr_8DED0A21C79B660BC7588981" && isDefined(self.attacker) && isDefined(self.attacker.unittype) && self.attacker.unittype == "_encstr_AF07035938")
      return 1;
  }

  if(gettime() - anim.lastcarexplosiontime <= 50) {
    var_0 = anim.lastcarexplosionrange * anim.lastcarexplosionrange * 1.2 * 1.2;

    if(distancesquared(self.origin, anim.lastcarexplosiondamagelocation) < var_0) {
      var_1 = var_0 * 0.5 * 0.5;
      self.maydoupwardsdeath = distancesquared(self.origin, anim.lastcarexplosionlocation) < var_1;
      return 1;
    }
  }

  return 0;
}

getdamagetype(var_0) {
  if(!isDefined(var_0))
    return "_encstr_8DC7086BEEA408C0AF8A";

  var_0 = tolower(var_0);

  switch (var_0) {
    case "_encstr_A6C7065BACB1CA95":
    case "_encstr_8D4E0A529F4B89881A8B3BB3":
    case "_encstr_8DED0A31E71B664BCF5A8880":
      return "_encstr_A6C7065BACB1CA95";
    case "_encstr_A6260731BAD8D82BD1":
    case "_encstr_A68211E38F83592A6FFBE1F15F060B586B6BB8":
    case "_encstr_950A12ADDEC87D384BDC3A7BB1D74CEAD8C6B21D":
      return "_encstr_A6260731BAD8D82BD1";
    case "_encstr_8AC9070B9918264FB3":
    case "_encstr_B45C0E0DBF40B1FF537BBA72E3237BF7":
    case "_encstr_8E3916CB7F17F13FCB0AB841D20B7BA0EFF77F69143EC80B":
    case "_encstr_84670F05D749CF1A5E7F6AD31A50817B97":
    case "_encstr_950B13ADDEC87DB39359370B9159EBE6E0C6B0DCA1":
    case "_encstr_911B0C5DA292E9AFF398BD52D94A":
      return "_encstr_8AC9070B9918264FB3";
    case "_encstr_A1ED0BA87FA4566B62B2172E8B":
      return "_encstr_878807108A42A309BB";
    case "_encstr_AA230E88FD4CD19DB3AF87A383CAD073":
      return "_encstr_8DC7086BEEA408C0AF8A";
    case "_encstr_8DC7086BEEA408C0AF8A":
      return "_encstr_8DC7086BEEA408C0AF8A";
    default:
      return "_encstr_8DC7086BEEA408C0AF8A";
  }
}

isprotectedbyriotshield(var_0) {
  if(isDefined(var_0.hasriotshield) && var_0.hasriotshield) {
    var_1 = self.origin - var_0.origin;
    var_2 = vectorNormalize((var_1[0], var_1[1], 0));
    var_3 = anglesToForward(var_0.angles);
    var_4 = vectordot(var_3, var_1);

    if(istrue(var_0.hasriotshieldequipped)) {
      if(var_4 > 0.766)
        return 1;
    } else if(var_4 < -0.766)
      return 1;
  }

  return 0;
}

isprotectedbyaxeblock(var_0) {
  var_1 = 0;
  var_2 = self getcurrentweapon();
  var_3 = self adsButtonPressed();
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = anglesToForward(self.angles);
  var_8 = vectorNormalize(var_0.origin - self.origin);
  var_9 = vectordot(var_8, var_7);

  if(var_9 > 0.5)
    var_4 = 1;

  if(var_2.basename == "_encstr_BA3D0B79B4CB775EF1D0013A60" || var_2.basename == "_encstr_8B060B2DDDE6BE0B0F95FAD3D6") {
    var_6 = self getcurrentweaponclipammo();
    var_5 = 1;
  }

  if(var_5 && var_3 && var_4 && var_6 > 0) {
    self setweaponammoclip(var_2, var_6 - 1);
    self playSound("_encstr_A7340D88D06B03798F4F0D20E34363");
    earthquake(0.75, 0.5, self.origin, 100);
    var_1 = 1;
  }

  return var_1;
}

isairdropmarker(var_0) {
  switch (var_0) {
    case "_encstr_8AF4170B2D4EC8C9B70EAFA316B96DFA6B5893B65927AF5BC1":
    case "_encstr_B63A19C24B9319E4B738F5DCCA9B8EC9F2BEAD16E4AD2B9CEBB638":
    case "_encstr_95AE175896E43239F683EBB6AC76857DD60B935B95E4EBDA0E":
    case "_encstr_B8C21A7AFFCB736BD81B4825CA9B9C33DB502B031BC097FBA9C1D949":
    case "_encstr_9A451A28B2BAE1638F4890F1319308BBE27990308B960B78DB7F8177":
    case "_encstr_991712D71B1B4532A71761A8B9EBFAA743F09D87":
      return 1;
    default:
      return 0;
  }
}

isdestructibleweapon(var_0) {
  if(!isDefined(var_0))
    return 0;

  switch (var_0) {
    case "_encstr_A5410AE2E9FE0397B0678D98":
    case "_encstr_9B93118CAC37A393D536E8A589B12BEB8EB72F":
    case "_encstr_8B92119F356FCBE23B80730FA030AD21275F62":
    case "_encstr_A6460DC8CADC8E4EAB8D3AA5C46356":
      return 1;
  }

  return 0;
}

enable_teamflashbangimmunity() {
  thread enable_teamflashbangimmunity_proc();
}

enable_teamflashbangimmunity_proc() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self.teamflashbangimmunity = 1;
    wait 0.05;
  }
}

disable_teamflashbangimmunity() {
  self.teamflashbangimmunity = undefined;
}

setflashbangimmunity(var_0) {
  self.flashbangimmunity = var_0;
}

getcamotablecolumnindex(var_0) {
  switch (var_0) {
    case "_encstr_B48F06CC58B0F50B":
      return 0;
    case "_encstr_A1B40AC26FAD22B8C0FBF0B9":
      return 1;
    case "_encstr_AAB20A219ABBC8D006348381":
      return 2;
    case "_encstr_93FF091A20C17FBFF02E69":
      return 3;
    default:
      return undefined;
  }
}

getdifficulty() {
  var_0 = isDefined(level.difficultytype) && isDefined(level.difficultytype[level.gameskill]) && level.difficultytype[level.gameskill] == "_encstr_8C07031599";

  if(var_0)
    return "_encstr_8C07031599";

  if(level.gameskill < 1)
    return "_encstr_A260053D1AE31B";

  if(level.gameskill < 2)
    return "_encstr_AB5E07609A5B7368E5";

  if(level.gameskill < 3)
    return "_encstr_83CC051A163991";

  return "_encstr_820703B86B";
}

clear_movement_speed() {
  self aiclearscriptdesiredspeed();
}

flashbangstop() {
  self.flashendtime = undefined;
}

enable_cqbwalk(var_0) {
  if(self.type == "_encstr_AA180446F6EC") {
    return;
  }
  if(!isDefined(var_0))
    self.cqbenabled = 1;

  self.turnrate = 0.2;
  demeanor_override("_encstr_931904C66102");
}

disable_cqbwalk() {
  if(self.type == "_encstr_AA180446F6EC") {
    return;
  }
  self.cqbenabled = undefined;
  self.turnrate = 0.3;
  self.cqb_point_of_interest = undefined;
  clear_demeanor_override();
}

demeanor_override(var_0) {
  if(isDefined(self.basearchetype) && (self.basearchetype == "_encstr_958C08CDDBD8325A959C" || self.basearchetype == "_encstr_8DF306282FDA1969")) {
    switch (var_0) {
      case "_encstr_8D3F0C8E660BD3195C579810A363":
      case "_encstr_85BB067A08A3FAB3":
      case "_encstr_96080730D8534E0A28":
      case "_encstr_ACF60EB7F743CD70EC51E0B885C49886":
      case "_encstr_8AEE0B360BE6578563AFCEBACD":
        self.allowstrafe = 0;
        break;
      default:
        self.allowstrafe = 1;
    }
  }

  if(self.asmname == "_encstr_958C08CDDBD8325A959C" || self.asmname == "_encstr_ACF80B97CFB24530E51A66F982") {
    switch (var_0) {
      case "_encstr_8D3F0C8E660BD3195C579810A363":
      case "_encstr_96080730D8534E0A28":
      case "_encstr_ACF60EB7F743CD70EC51E0B885C49886":
      case "_encstr_8AEE0B360BE6578563AFCEBACD":
      case "_encstr_914B078DB09BAB0BB1":
        self.turnrate = 0.1;
        break;
      case "_encstr_85BB067A08A3FAB3":
      case "_encstr_931904C66102":
        self.turnrate = 0.2;
        break;
      default:
        self.turnrate = 0.3;
        break;
    }

    switch (var_0) {
      case "_encstr_931904C66102":
        scripts\engine\utility::set_movement_speed(120 * self.speedscalemult);
        var_0 = "_encstr_AA7C07466F9DA30713";
        break;
      case "_encstr_AA7C07466F9DA30713":
        clear_movement_speed();
        break;
      case "_encstr_92100762872552A643":
        scripts\engine\utility::set_movement_speed(225 * self.speedscalemult);
        var_0 = "_encstr_AA7C07466F9DA30713";
        break;
      case "_encstr_85BB067A08A3FAB3":
      case "_encstr_96080730D8534E0A28":
        scripts\engine\utility::set_movement_speed(56);
        break;
    }
  }

  self.demeanoroverride = var_0;
}

clear_demeanor_override() {
  if(isDefined(self.basearchetype) && (self.basearchetype == "_encstr_958C08CDDBD8325A959C" || self.basearchetype == "_encstr_8DF306282FDA1969")) {
    if(isDefined(self.demeanoroverride)) {
      switch (self.demeanoroverride) {
        case "_encstr_8D3F0C8E660BD3195C579810A363":
        case "_encstr_85BB067A08A3FAB3":
        case "_encstr_96080730D8534E0A28":
        case "_encstr_ACF60EB7F743CD70EC51E0B885C49886":
        case "_encstr_8AEE0B360BE6578563AFCEBACD":
          self.allowstrafe = 1;
          break;
      }
    }
  }

  self.demeanoroverride = undefined;

  if(self.asmname == "_encstr_958C08CDDBD8325A959C") {
    self.turnrate = 0.3;
    clear_movement_speed();
  }
}

isweaponinitialized(var_0) {
  var_1 = createheadicon(var_0);
  return isDefined(self.weaponinfo[var_1]);
}

initweapon(var_0) {
  var_1 = createheadicon(var_0);
  self.weaponinfo[var_1] = spawnStruct();
  self.weaponinfo[var_1].position = "_encstr_8BBA05185F8B99";
  self.weaponinfo[var_1].hasclip = 1;
  var_2 = getweaponclipmodel(var_0);

  if(issp() && isDefined(var_2) && var_2 != "_encstr_B40101" && (issubstr(var_2, "_encstr_8B6605A57A35AD") || issubstr(var_2, "_encstr_B61904B60BB3")))
    self.weaponinfo[var_1].useclip = 1;
  else
    self.weaponinfo[var_1].useclip = 0;
}

allow_init() {
  allow_add("_encstr_9BE40A0BC09BCEF7C0F33441", ::allow_usability);
  allow_add("_encstr_BD70131B23FFDB0C38B31C09C788D34B105E93E349", ::brjugg_watchheatreduction);
  allow_add("_encstr_AC20072B9FA9487832", ::allow_weapon);
  allow_add("_encstr_A60F0E030703D180A0665F43BA558F28", ::allow_weapon_switch);
  allow_add("_encstr_8A2F13BF65CEDB8520878F9BFFCD2E084FA3E8C8F8", ::allow_weapon_switch_clip);
  allow_add("_encstr_8E5915D07AD2835B8B3FDCDD1943604571837898A32ED9", ::allow_script_weapon_switch);
  allow_add("_encstr_914C0EDDB20B837BB97D38D2365BAB83", ::allow_weapon_pickup);
  allow_add("_encstr_A1AF107FB41FA3596A69773FD20858C85627", ::allow_offhand_weapons);
  allow_add("_encstr_880718D8F70AB9490ECBA9C88B5180E33358585C8FD25170E6BF", ::allow_offhand_primary_weapons);
  allow_add("_encstr_85DF1AF633CC0D0B9B197DE695D8F6734685C95EFABBCA0B0EDB9BDC", ::allow_offhand_secondary_weapons);
  allow_add("_encstr_BDF5178AB14C23DEF859C7D379F8E77BE50E8352391F87D5F8", ::allow_offhand_shield_weapons);
  allow_add("_encstr_8A8612E75EAF709F9362F69B8ACB405046B10767", ::brjugg_onplayerkilled);
  allow_add("_encstr_922406F1A6FD5E05", ::allow_prone);
  allow_add("_encstr_B13D076BED70539F23", ::allow_crouch);
  allow_add("_encstr_A5AD069B231F0BAF", ::allow_stand);
  allow_add("_encstr_92100762872552A643", ::allow_sprint);
  allow_add("_encstr_919007AA5148539DA0", ::allow_mantle);
  allow_add("_encstr_88780599B4E495", ::allow_fire);
  allow_add("_encstr_AD1904291F7B", ::allow_ads);
  allow_add("_encstr_84DD05D205AA0B", ::allow_jump);
  allow_add("_encstr_84B508EE0BD8D839D59B", ::allow_wallrun);
  allow_add("_encstr_83750B197BEA13D8CAD4EAAD0E", ::allow_doublejump);
  allow_add("_encstr_A6C7065BACB1CA95", ::allow_melee);
  allow_add("_encstr_BD6B06A64C87A9E3", ::allow_slide);
  allow_add("_encstr_AF4D07932B1BDE5846", ::allow_reload);
  allow_add("_encstr_9BAD05B1560B9B", ::allow_lean);
  allow_add("_encstr_83230A7F177D22B4413B75BA", ::allow_mount_top);
  allow_add("_encstr_86A00B412DA32D63B72F90F05F", ::allow_mount_side);
  allow_add("_encstr_96EB0B0BABD1DB39598DF616C8", ::allow_autoreload);
  allow_add("_encstr_B18F09518733412BAF1AA0", ::allow_movement);
  allow_add("_encstr_880811DD703AAFCB14FF28383F59A3C902DE42", ::allow_execution_attack);
  allow_add("_encstr_B24E11E8C140668309413A234F0BE9176B9185", ::allow_execution_victim);
  allow_add("_encstr_962F0CB3560DD236D8CAD7576E59", ::allow_vehicle_use);
  allow_add("_encstr_84B60AC693C2E8B27D5DCDCA", ::allow_crate_use);
  allow_add("_encstr_A91E0E983FF591A981B7D5E64B1BA599", ::allow_cough_gesture);
  allow_add("_encstr_872F11E872F36D70CA0FA99959F608A19F1A63", ::allow_ladder_placement);
  allow_add("_encstr_85190CAB8B3971B0A4DB2BCAC253", ::allow_killstreaks);
  allow_add("_encstr_A1760D221BB8AF4350FB44519F388A", ::brjugg_initdroplocations);
  allow_add("_encstr_AC19044DE657", ::brjugg_oncrateuse);
  allow_add("_encstr_B2050D90D3372F6698BB027983772A", ::brjugg_droponplayerdeath);
}

allow_add(var_0, var_1) {
  level.allow_funcs[tolower(var_0)] = var_1;
}

allow_register_set(var_0, var_1) {
  level.allow_sets[tolower(var_0)] = var_1;
}

allow_set(var_0, var_1, var_2) {
  var_0 = tolower(var_0);
  allow_array(level.allow_sets[var_0], var_1, var_2);
}

allow_array(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4 = tolower(var_4);
    self thread[[level.allow_funcs[var_4]]](var_1, var_2);
  }
}

allow_weapon_switch_clip(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_993711EE2B8538ED9B9ADDB4E8B1D068D82D38", var_0, var_1);
  self disableemptyclipweaponswitch(!istrue(var_2));
}

is_weapon_switch_clip_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_993711EE2B8538ED9B9ADDB4E8B1D068D82D38");
}

allow_usability(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_9BE40A0BC09BCEF7C0F33441", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2)
      self enableusability();
    else
      self disableusability();
  }
}

brjugg_watchheatreduction(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_9BE40A0BC09BCEF7C0F33441", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2)
      self enableusability();
    else
      self disableusability(1);
  }
}

is_usability_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_9BE40A0BC09BCEF7C0F33441");
}

allow_weapon(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_AC20072B9FA9487832", var_0, var_1);

  if(isDefined(var_2) && var_2) {
    self enableweapons();

    if(isDefined(level.allow_weapon_mp))
      self[[level.allow_weapon_mp]](1);
  } else if(isDefined(var_2) && !var_2) {
    if(isDefined(level.allow_weapon_mp))
      self[[level.allow_weapon_mp]](0);

    self disableweapons();
  }
}

is_weapon_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_AC20072B9FA9487832");
}

allow_weapon_switch(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_8E170DEB5287C7806DA30733AC1680", var_0, var_1);

  if(isDefined(var_2) && var_2)
    self enableweaponswitch();
  else if(isDefined(var_2) && !var_2)
    self disableweaponswitch();
}

is_weapon_switch_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_8E170DEB5287C7806DA30733AC1680");
}

allow_script_weapon_switch(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("_encstr_AA80134B4F53ABFA9BF1F36FAF7D92AF7C48B5F690", var_0, var_1);
}

is_script_weapon_switch_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_AA80134B4F53ABFA9BF1F36FAF7D92AF7C48B5F690");
}

allow_weapon_pickup(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_97240D972BE8FA57D8FF6A3260ADE3", var_0, var_1);

  if(isDefined(var_2) && var_2)
    self enableweaponpickup();
  else if(isDefined(var_2) && !var_2)
    self disableweaponpickup();
}

is_weapon_pickup_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_97240D972BE8FA57D8FF6A3260ADE3");
}

allow_offhand_weapons(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_A3760DF666334316CD32AE2B58079B", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableoffhandweapons();

      if(!isDefined(level.ismp) || level.ismp == 0)
        allow_offhand_shield_weapons(1, "_encstr_B17B168043E0DAAB4EC5895CB206155F9E2CE59A2BC7F2F7");
    } else {
      self disableoffhandweapons();

      if(!isDefined(level.ismp) || level.ismp == 0)
        allow_offhand_shield_weapons(0, "_encstr_B17B168043E0DAAB4EC5895CB206155F9E2CE59A2BC7F2F7");
    }
  }
}

is_offhand_weapons_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_A3760DF666334316CD32AE2B58079B");
}

allow_offhand_primary_weapons(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_848714A7D52492717889EA6AC088B9EB031F371761D6", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2)
      self enableoffhandprimaryweapons();
    else
      self disableoffhandprimaryweapons();
  }
}

is_offhand_primary_weapons_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_848714A7D52492717889EA6AC088B9EB031F371761D6");
}

allow_offhand_secondary_weapons(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_9AE316AF5CFD79F06A25AF78FF9898FB1603CFA99D1BC376", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableoffhandsecondaryweapons();
      allow_offhand_shield_weapons(1, "_encstr_AF272030FA259FAB373F646C68F7B041419398D8227D3121EB41E0DCE51FBB0F753B");
    } else {
      self disableoffhandsecondaryweapons();
      allow_offhand_shield_weapons(0, "_encstr_AF272030FA259FAB373F646C68F7B041419398D8227D3121EB41E0DCE51FBB0F753B");
    }
  }
}

is_offhand_secondary_weapons_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_9AE316AF5CFD79F06A25AF78FF9898FB1603CFA99D1BC376");
}

allow_offhand_shield_weapons(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_998D1388926F29D1BB6CA62349BFB8899B0A60F8BB", var_0, var_1);

  if(isDefined(var_2))
    self allowoffhandshieldweapons(var_2);
}

is_offhand_shield_weapons_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_998D1388926F29D1BB6CA62349BFB8899B0A60F8BB");
}

allow_prone(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_922406F1A6FD5E05", var_0, var_1);

  if(isDefined(var_2))
    self allowprone(var_2);
}

is_prone_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_922406F1A6FD5E05");
}

allow_crouch(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_B13D076BED70539F23", var_0, var_1);

  if(isDefined(var_2))
    self allowcrouch(var_2);
}

is_crouch_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_B13D076BED70539F23");
}

allow_stand(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_A5AD069B231F0BAF", var_0, var_1);

  if(isDefined(var_2))
    self allowstand(var_2);
}

is_stand_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_A5AD069B231F0BAF");
}

allow_sprint(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_92100762872552A643", var_0, var_1);

  if(isDefined(var_2))
    self allowsprint(var_2);
}

allow_jog(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_B4190453BD3B", var_0, var_1);

  if(isDefined(var_2))
    setsaveddvar("_encstr_93280BA56925B18A1790971FF8", var_2);
}

is_sprint_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_92100762872552A643");
}

allow_mantle(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_919007AA5148539DA0", var_0, var_1);

  if(isDefined(var_2))
    self allowmantle(var_2);
}

is_mantle_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_919007AA5148539DA0");
}

allow_fire(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_88780599B4E495", var_0, var_1);

  if(isDefined(var_2))
    self allowfire(var_2);
}

is_fire_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_88780599B4E495");
}

allow_ads(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_AD1904291F7B", var_0, var_1);

  if(isDefined(var_2))
    self allowads(var_2);
}

is_ads_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_AD1904291F7B");
}

allow_jump(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_84DD05D205AA0B", var_0, var_1);

  if(isDefined(var_2))
    self allowjump(var_2);
}

is_jump_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_84DD05D205AA0B");
}

allow_wallrun(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_84B508EE0BD8D839D59B", var_0, var_1);

  if(isDefined(var_2) && var_2)
    self allowwallrun(1);
  else if(isDefined(var_2) && !var_2)
    self allowwallrun(0);
}

is_wallrun_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_84B508EE0BD8D839D59B");
}

allow_doublejump(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_83750B197BEA13D8CA94EAAD0E", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self energy_setenergy(0, self.doublejumpenergy);
      self energy_setrestorerate(0, self.doublejumpenergyrestorerate);
      self.doublejumpenergy = undefined;
      self.doublejumpenergyrestorerate = undefined;
      self allowdoublejump(1);
    } else {
      self.doublejumpenergy = self energy_getenergy(0);
      self.doublejumpenergyrestorerate = self energy_getrestorerate(0);
      self energy_setenergy(0, 0);
      self energy_setrestorerate(0, 0);
      self allowdoublejump(0);
    }
  }
}

is_doublejump_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_83750B197BEA13D8CA94EAAD0E");
}

brjugg_onplayerkilled(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_8A8612E75EAF709F9362F69B8ACB405046B10767", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2)
      self enableoffhandthrowback();
    else
      self disableoffhandthrowback();
  }
}

allow_melee(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_A6C7065BACB1CA95", var_0, var_1);

  if(isDefined(var_2))
    self allowmelee(var_2);
}

is_melee_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_A6C7065BACB1CA95");
}

allow_slide(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_BD6B06A64C87A9E3", var_0, var_1);

  if(isDefined(var_2))
    self allowslide(var_2);
}

is_slide_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_BD6B06A64C87A9E3");
}

allow_execution_attack(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_880811DD703AAFCB14FF28383F59A3C902DE42", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2)
      self[[level.enableexecutionattackfunc]]();
    else
      self[[level.disableexecutionattackfunc]]();
  }
}

allow_execution_victim(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_B24E11E8C140668309413A234F0BE9176B9185", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2)
      self[[level.enableexecutionvictimfunc]]();
    else
      self[[level.disableexecutionvictimfunc]]();
  }
}

can_execute() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_880811DD703AAFCB14FF28383F59A3C902DE42");
}

can_be_executed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_B24E11E8C140668309413A234F0BE9176B9185");
}

allow_killstreaks(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("_encstr_85190CAB8B3971B0A4DB2BCAC253", var_0, var_1);
}

brjugg_initdroplocations(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("_encstr_A1760D221BB8AF4350FB44519F388A", var_0, var_1);
}

is_killstreaks_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_85190CAB8B3971B0A4DB2BCAC253");
}

allow_supers(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_BEF4071AA87BDF5220", var_0, var_1);

  if(isDefined(var_2)) {
    var_3 = !var_0;

    if(isDefined(level.setsuperweapondisabled))
      self[[level.setsuperweapondisabled]](var_3);
  }
}

is_supers_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_BEF4071AA87BDF5220");
}

allow_shellshock(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      if(isDefined(level.enableshellshockfunc))
        self[[level.enableshellshockfunc]]();
    } else if(isDefined(level.disableshellshockfunc))
      self[[level.disableshellshockfunc]]();
  }
}

is_shellshock_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_8CF40B9B3BFD1849BB9CC8C6B4");
}

get_doublejumpenergy() {
  if(!isDefined(self.doublejumpenergy))
    return self energy_getenergy(0);

  return self.doublejumpenergy;
}

set_doublejumpenergy(var_0) {
  if(!isDefined(self.doublejumpenergy))
    self energy_setenergy(0, var_0);
  else
    self.doublejumpenergy = var_0;
}

get_doublejumpenergyrestorerate() {
  if(!isDefined(self.doublejumpenergyrestorerate))
    return self energy_getrestorerate(0);

  return self.doublejumpenergyrestorerate;
}

set_doublejumpenergyrestorerate(var_0) {
  if(!isDefined(self.doublejumpenergyrestorerate))
    self energy_setrestorerate(0, var_0);
  else
    self.doublejumpenergyrestorerate = var_0;
}

allow_lean(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_9BAD05B1560B9B", var_0, var_1);

  if(isDefined(var_2))
    self allowlean(var_2);
}

is_lean_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_9BAD05B1560B9B");
}

allow_mount_top(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_83230A7F177D22B4413B75BA", var_0, var_1);

  if(isDefined(var_2))
    self allowmounttop(var_2);
}

is_mount_top_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_83230A7F177D22B4413B75BA");
}

allow_mount_side(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_86A00B412DA32D63B72F90F05F", var_0, var_1);

  if(isDefined(var_2))
    self allowmountside(var_2);
}

is_mount_side_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_86A00B412DA32D63B72F90F05F");
}

allow_cinematic_motion(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_B432119AE075FF17B1ADF9EBD0D8D7438338D2", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      if(isDefined(level.player.cinematicmotionoverride))
        level.player setcinematicmotionoverride(level.player.cinematicmotionoverride);
      else
        level.player clearcinematicmotionoverride();
    } else
      self setcinematicmotionoverride("_encstr_921D09D9D9C0090D7275B4");
  }
}

is_cinematic_motion_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_B432119AE075FF17B1ADF9EBD0D8D7438338D2");
}

allow_death(var_0, var_1) {
  if(!isDefined(self.deathshieldfunc)) {}

  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_AD75063D571AE108", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2)
      self[[self.deathshieldfunc]](0);
    else
      self[[self.deathshieldfunc]](1);
  } else
    self[[self.deathshieldfunc]](1);
}

is_death_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_AD75063D571AE108");
}

allow_reload(var_0, var_1, var_2) {
  var_3 = scripts\common\input_allow::allow_input_internal("_encstr_AF4D07932B1BDE5846", var_0, var_1);

  if(isDefined(var_3)) {
    if(var_3)
      self allowreload(1);
    else {
      self allowreload(0);

      if(!isDefined(var_2) || !var_2)
        self cancelreload();
    }
  }
}

is_reload_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_AF4D07932B1BDE5846");
}

allow_autoreload(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_96EB0B0BABD1DB39598DF616C8", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2)
      self enableautoreload();
    else
      self disableautoreload();
  }
}

is_autoreload_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_96EB0B0BABD1DB39598DF616C8");
}

allow_movement(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_B18F09518733412BAF1AA0", var_0, var_1);

  if(isDefined(var_2))
    self allowmovement(var_2);
}

allow_armor(var_0, var_1) {
  if(!playerarmorenabled()) {
    return;
  }
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_A7B606DA83796F4A", var_0, var_1);

  if(isDefined(self.armor) && isDefined(self.armor.toggleuifunc))
    self[[self.armor.toggleuifunc]]();
}

is_armor_allowed() {
  if(!playerarmorenabled())
    return 0;

  return scripts\common\input_allow::is_input_allowed_internal("_encstr_A7B606DA83796F4A");
}

brjugg_oncrateuse(var_0, var_1, var_2) {
  var_3 = 2;
  var_4 = scripts\common\input_allow::allow_input_internal("_encstr_AC19040DC65F", var_0, var_1, var_2);

  if(isDefined(var_4)) {
    if(var_4) {
      if(!isai(self))
        self setactionslot(var_3, "_encstr_ABC00CDC969D431D9DD2B9B4EDDC");
    } else if(!isai(self))
      self setactionslot(var_3, "_encstr_B40101");
  }
}

is_nvg_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_AC19040DC65F");
}

allow_crate_use(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("_encstr_828C09996A99584D51C7DB", var_0, var_1);
}

is_crate_use_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_828C09996A99584D51C7DB");
}

allow_vehicle_use(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_962F0CB3560DD236D8CAD7576E59", var_0, var_1);

  if(isDefined(var_2))
    vehicle_allowplayeruse(self, var_0);
}

is_vehicle_use_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_962F0CB3560DD236D8CAD7576E59");
}

allow_cough_gesture(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("_encstr_A91E0E983FF591A981B7D5E64B1BA599", var_0, var_1);
}

is_cough_gesture_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_A91E0E983FF591A981B7D5E64B1BA599");
}

allow_ladder_placement(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("_encstr_872F11E872F36D70CA0FA99959F608A19F1A63", var_0, var_1);
}

is_ladder_placement_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_872F11E872F36D70CA0FA99959F608A19F1A63");
}

brjugg_droponplayerdeath(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("_encstr_B4180C0BCD1BCA73915993553756", var_0, var_1);
}

trial_ui_retry_disabled() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_B4180C0BCD1BCA73915993553756");
}

playerarmorenabled() {
  return getdvarint("_encstr_9A9419DA69905FFBC1330F773D60D2CAC07012A9C128291229C363");
}

playerhelmetenabled() {
  return getdvarint("_encstr_A1A71A18B21A378323F92315C2C7C81BC53AD0A8E9779D79E3EC259D");
}

spawn_vehicle() {
  return scripts\common\vehicle::vehicle_spawn(self);
}

groundpos(var_0, var_1) {
  return scripts\engine\utility::drop_to_ground(var_0, 0, -100000, var_1);
}

vehicle_detachfrompath() {
  scripts\common\vehicle_code::vehicle_pathdetach();
}

vehicle_resumepath() {
  thread scripts\common\vehicle_paths::vehicle_resumepathvehicle();
}

vehicle_land(var_0) {
  scripts\common\vehicle_code::vehicle_landvehicle(var_0);
}

vehicle_liftoff(var_0) {
  scripts\common\vehicle_code::vehicle_liftoffvehicle(var_0);
}

vehicle_dynamicpath(var_0, var_1) {
  scripts\common\vehicle::vehicle_paths(var_0, var_1);
}

getvehiclespawner(var_0, var_1) {
  var_2 = getvehiclespawnerarray(var_0, var_1);
  return var_2[0];
}

getvehiclespawnerarray(var_0, var_1) {
  return scripts\common\vehicle_code::_getvehiclespawnerarray(var_0, var_1);
}

is_map_using_locales_only() {
  var_0 = getDvar("_encstr_9570084B1793A090CDFF");

  if(var_0 == "_encstr_930E0AF5970FF2D770E8077F" || var_0 == "_encstr_93A80FB50EBE8DF6C6B036ACFA47ACB98E")
    return 1;

  return 0;
}

iswegameplatform() {
  return getdvarint("_encstr_916B0B9A29355413A8699CD205", 0) == 1;
}

playersnear(var_0, var_1) {
  var_2 = physics_createcontents(["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0"]);
  var_3 = (var_1, var_1, var_1);
  var_4 = var_0 - var_3;
  var_5 = var_0 + var_3;
  var_6 = physics_aabbbroadphasequery(var_4, var_5, var_2, []);
  return var_6;
}

playersincylinder(var_0, var_1, var_2, var_3) {
  var_4 = physics_createcontents(["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0"]);
  var_5 = 1000;

  if(isDefined(var_3))
    var_5 = var_3;

  var_6 = (var_1, var_1, var_5);
  var_7 = var_0 - var_6;
  var_8 = var_0 + var_6;

  if(!isDefined(var_2))
    var_2 = [];

  var_9 = physics_aabbbroadphasequery(var_7, var_8, var_4, var_2);
  var_10 = [];
  var_11 = var_1 * var_1;

  foreach(var_13 in var_9) {
    var_15 = distance2dsquared(var_13.origin, var_0);

    if(var_15 < var_11)
      var_10[var_10.size] = var_13;
  }

  return var_10;
}

playersinsphere(var_0, var_1) {
  var_2 = playersnear(var_0, var_1);
  var_3 = [];
  var_4 = var_1 * var_1;

  foreach(var_6 in var_2) {
    var_7 = distancesquared(var_6.origin, var_0);

    if(var_7 < var_4)
      var_3[var_3.size] = var_6;
  }

  return var_3;
}

_id_13E0A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_10))
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  else if(isDefined(var_9))
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else if(isDefined(var_8))
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isDefined(var_7))
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  else if(isDefined(var_6))
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6);
  else if(isDefined(var_5))
    return [[var_0]](var_1, var_2, var_3, var_4, var_5);
  else if(isDefined(var_4))
    return [[var_0]](var_1, var_2, var_3, var_4);
  else if(isDefined(var_3))
    return [[var_0]](var_1, var_2, var_3);
  else if(isDefined(var_2))
    return [[var_0]](var_1, var_2);
  else if(isDefined(var_1))
    return [[var_0]](var_1);
  else
    return [[var_0]]();
}

_id_13629() {
  if(!iswegameplatform()) {
    return;
  }
  var_0 = 0;
  var_1 = 1;
  var_2 = 2;
  var_3 = 3;
  var_4 = 4;
  var_5 = 5;
  var_6 = "_encstr_867417AB39A2C447D541C00A4B37D77F9183320CBBF24E6784";
  var_7 = tolower(getDvar("_encstr_9570084B1793A090CDFF"));
  var_8 = tablelookupgetnumrows(var_6);

  for(var_9 = 0; var_9 < var_8; var_9++) {
    if(var_7 == tolower(tablelookupbyrow(var_6, var_9, var_1))) {
      var_10 = tablelookupbyrow(var_6, var_9, var_2);
      var_11 = strtok(tablelookupbyrow(var_6, var_9, var_3), "_encstr_BA4C02DF");
      var_12 = strtok(tablelookupbyrow(var_6, var_9, var_4), "_encstr_BA4C02DF");
      var_13 = int(tablelookupbyrow(var_6, var_9, var_5));
      var_14 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (float(var_11[0]), float(var_11[1]), float(var_11[2])));
      var_14 setModel(var_10);
      var_14.angles = (float(var_12[0]), float(var_12[1]), float(var_12[2]));

      if(var_13 > 0)
        var_14 solid();
      else
        var_14 notsolid();
    }
  }
}