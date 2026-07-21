/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_c130.gsc
***********************************************/

init() {
  scripts\mp\flags::gameflaginit("_encstr_B28811BA9B8952D39F1FE35F99DFCFC398101B", 0);
  setdvarifuninitialized("_encstr_B8A621C0C63A895A6E294FA9C332B7C3609361E3B97375716FD082E5B22B89418D69B9", 2.0);
  level._encstr_8D1417A89B6913AB0BBF63E89C5730CDCD73406063FF93402F = ::ispointinbounds;
}

spawnc130pathstruct(var_0, var_1) {
  var_2 = makepathparamsstruct(var_0, var_1);
  var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::makepathstruct(var_2);
  return var_3;
}

makepathparamsstruct(var_0, var_1) {
  var_2 = 160;
  var_3 = 200;

  if(isDefined(var_0))
    var_4 = var_0;
  else
    var_4 = (0, 0, 0);

  if(level.mapname == "_encstr_8550092982697178E21F50") {
    var_2 = 165;
    var_3 = 195;
    var_4 = (3000, -2000, 0);
  }

  var_5 = 6.28318;
  var_6 = randomfloatrange(0, 360);
  var_7 = randomfloatrange(var_2, var_3);

  if(isDefined(var_1))
    var_8 = var_1;
  else
    var_8 = level.br_level.br_circleradii[0];

  var_9 = spawnStruct();
  var_9.r = var_8;
  var_9.randomangle = var_6;
  var_9.endangleoffset = var_7;
  var_9.centerpt = var_4;
  return var_9;
}

snappointtomapbounds2d(var_0) {
  var_1 = level.br_level.br_mapbounds;

  if(var_0[0] < var_1[1][0])
    var_0 = (var_1[1][0], var_0[1], var_0[2]);
  else if(var_0[0] > var_1[0][0])
    var_0 = (var_1[0][0], var_0[1], var_0[2]);

  if(var_0[1] < var_1[1][1])
    var_0 = (var_0[0], var_1[1][1], var_0[2]);
  else if(var_0[1] > var_1[0][1])
    var_0 = (var_0[0], var_1[0][1], var_0[2]);

  return var_0;
}

_id_1342E(var_0, var_1, var_2) {
  if(!isDefined(level.outofboundstriggers) || level.outofboundstriggers.size == 0)
    return snappointtomapbounds2d(var_1);

  if(!isDefined(level._id_12165))
    level._id_12165 = level.outofboundstriggers;

  var_3 = physics_createcontents(["_encstr_92A41EDB523776801EB37F6FC683B8B0AB5BB643FAAFAB2872AC257BF7AF7006"]);
  var_4 = scripts\engine\trace::ray_trace_ents(var_0, var_1, level._id_12165, var_3);
  var_5 = 0;

  if(var_4["_encstr_A53009A25003666B9818C6"] < 1.0) {
    var_1 = var_4["_encstr_BD260953AA97E3F014279D"];
    var_5 = 1;
  }

  if(isDefined(level._id_12166) && level._id_12166.size > 0 && getdvarint("_encstr_A7DD1A0F078649DA20467A82B930EE80C0DD679FF1213387904B768C", 0) == 0) {
    var_6 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12A18(var_0, var_1, level._id_12166);

    if(isDefined(var_6)) {
      var_7 = distance2dsquared(var_0, var_1);
      var_8 = distance2dsquared(var_0, var_6);

      if(var_8 < var_7) {
        var_1 = (var_6[0], var_6[1], var_1[2]);
        var_5 = 1;
      }
    }
  }

  if(var_5 && isDefined(var_2)) {
    var_9 = vectorNormalize(var_0 - var_1);
    var_1 = var_1 + var_9 * var_2;
  }

  return var_1;
}

respawns_on_failed_unload(var_0) {
  var_1 = getdvarfloat("_encstr_932F190B7E330F01ABEF77EA1BCA57AF7839D07C371D30400D76E8", 0.7);
  var_2 = (level.br_level.br_mapsize[0] / 2 + level.br_level.br_mapsize[1] / 2) / 2;

  if(isDefined(var_0))
    var_2 = var_0;

  var_3 = var_1 * var_2;
  return var_3;
}

vehicle_collision_getdamagefactor(var_0) {
  if(!isDefined(level.br_level))
    return 1;

  var_1 = level.br_level.br_mapcenter;
  var_2 = respawns_on_failed_unload();
  var_3 = distance2d(var_1, var_0);
  return var_3 < var_2;
}

spawnc130pathstructnew(var_0, var_1) {
  var_2 = level.br_level.br_mapcenter;

  if(isDefined(var_0))
    var_2 = var_0;

  var_3 = respawns_on_failed_unload(var_1);
  var_4 = randomfloat(360);

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound()) {
    if(isDefined(level.stop_rpg_guys))
      var_4 = level.stop_rpg_guys;
    else
      var_4 = 75;
  }

  var_5 = anglesToForward((0, var_4, 0));
  var_5 = var_5 * (var_3 * randomfloatrange(-1, 1));
  var_5 = var_5 + (0, 0, relic_ammo_drain_take_ammo());

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_84EC163339208BC548FB4A5DC74BCAEF59D1B8CA6085477A"))
    var_2 = var_2 + var_5;

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound() && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootcallbacks())
    var_2 = getdvarvector("_encstr_8A0A16DB827BAFB83AFF5FF3BB72F1D78BCA5581FADB4570", var_2);

  if(isDefined(level.delay_show_backpack))
    var_2 = level.delay_show_backpack;

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_8A6C1E38D816DC9586ED739BA39C58D2CDACC83227F66B352C07A1ACDCE856E4"))
    var_2 = hostdamagepercentmedium(var_2);

  var_6 = (0, randomfloatrange(0, 360), 0);

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_84EC163339208BC548FB4A5DC74BCAEF59D1B8CA6085477A")) {
    var_7 = level.br_level.br_mapcenter + var_5;
    var_8 = var_2 - var_7;

    if(scripts\engine\utility::cointoss() && getdvarint("_encstr_919F22CD6C4E7D89E47D36D2C9361BAC0AB116B92B884B4E3263B4074496DC584CD89532", 0) == 0)
      var_8 = var_8 * -1.0;

    var_9 = vectortoyaw(var_8);
    var_6 = (0, var_9, 0);
  }

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
    var_6 = (0, 75, 0);
  else {
    var_10 = getdvarfloat("_encstr_BE0C15DFB71B90503A99397BAA40F937D303331D4F2245", -1);

    if(var_10 < 0)
      var_10 = var_6[1];

    var_6 = (0, var_10, 0);
  }

  var_11 = level.br_level.br_circleradii[0];

  if(isDefined(var_1))
    var_11 = var_1;

  var_12 = var_11 * 2;

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_A92C15EAC13B1A65AF90871768635B829B7636673B4B83"))
    var_12 = var_11;

  var_13 = _id_1361A(var_2, var_6, var_12);
  var_14 = scripts\cp_mp\parachute::getc130height();
  var_13.startpt = (var_13.startpt[0], var_13.startpt[1], var_14);
  var_13.endpt = (var_13.endpt[0], var_13.endpt[1], var_14);
  return var_13;
}

hostdamagepercentmedium(var_0) {
  var_1 = physics_createcontents(["_encstr_92A41EDB523776801EB37F6FC683B8B0AB5BB643FAAFAB2872AC257BF7AF7006"]);
  var_2 = scripts\engine\trace::ray_trace_ents(level.br_level.br_mapcenter, var_0, level._id_12165, var_1);

  if(var_2["_encstr_A53009A25003666B9818C6"] < 1.0) {
    var_3 = var_0[2];
    var_0 = var_2["_encstr_BD260953AA97E3F014279D"] - level.br_level.br_mapcenter;
    var_4 = var_2["_encstr_A53009A25003666B9818C6"] - 0.01;
    var_0 = (var_0[0] * var_4, var_0[1] * var_4, var_3);
  }

  return var_0;
}

_id_1361A(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_1);

  if(!isDefined(var_2)) {
    var_2 = level.br_level.br_circleradii[0] * 2;

    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
      var_2 = level.br_level.br_circleradii[2] * 2;
  }

  var_4 = var_0 - var_3 * var_2;
  var_5 = var_0 + var_3 * var_2;

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A5D50F0ED8C2DC9535E616E051F6F4D312")) {
    var_4 = _id_1342E(var_0, var_4);
    var_5 = _id_1342E(var_0, var_5);
  }

  var_6 = var_4;
  var_7 = var_5;

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A5D50F0ED8C2DC9535E616E051F6F4D312")) {
    if(!add_to_spotlight_array(var_4))
      var_6 = _id_1342E(var_0, var_4);

    if(!add_to_spotlight_array(var_5))
      var_7 = _id_1342E(var_0, var_5);
  }

  var_3 = vectorNormalize(var_5 - var_4);
  var_8 = scripts\mp\utility\game::round_vehicle_logic();
  var_9 = 10;

  if(var_8 == "_encstr_87A205AF50D049" || var_8 == "_encstr_A519044B436F" && getdvarint("_encstr_92DC2C9B20BBF092FDF8F71911D71DEFC1D088FD0F6ABBC35DF1B76F7FF9F3F8F130B29CA85750B9AE9B3B5E082F", 0) || getdvarint("_encstr_8DE12B6E369CFA13C9AF16638E7DDAEDC8CA7D95E6B1168356D7CDB6D21CD7B473A51D96B063F5D85A4E8D8D2B", 0) || var_8 == "_encstr_8F94079C2BB3B2C21B" || isDefined(level.disable_heli_lights) && level.disable_heli_lights._id_14291 == 3) {
    if(scripts\cp_mp\utility\game_utility::turretdisabled())
      var_9 = 5;
    else
      var_9 = 2;
  }

  if(var_8 == "_encstr_A254085207A6B7334B5A" || var_8 == "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8" || var_8 == "_encstr_B4F40EE8C95685E657C92BAF43EA731D" || var_8 == "_encstr_9286085A21B8034D3863" || var_8 == "_encstr_AD51088015D1E2D47930" || var_8 == "_encstr_AD300C932B4C969CD1D0AF911346" || var_8 == "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95") {
    if(scripts\cp_mp\utility\game_utility::turretdisabled() || scripts\cp_mp\utility\game_utility::validateprojectileent())
      var_9 = 8;
    else
      var_9 = 7;
  }

  var_4 = var_4 - var_3 * getc130speed() * var_9;
  var_5 = var_5 + var_3 * 100000;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
    var_4 = var_4 - var_3 * getc130speed() * 20;

  var_10 = spawnStruct();
  var_10.startpt = var_4;
  var_10.endpt = var_5;
  var_10._id_1386E = var_6;
  var_10.neurotoxin_damage_monitor = var_7;
  var_10.angle = var_1;
  var_10.pathdir = var_3;
  var_10.centerpt = var_0;
  return var_10;
}

getc130speed() {
  if(isDefined(level.br_level) && isDefined(level.br_level.c130_speedoverride))
    return level.br_level.c130_speedoverride;

  return 3044;
}

relic_ammo_drain_take_ammo() {
  return 8000;
}

setc130heightoverrides(var_0, var_1) {
  if(isDefined(var_0))
    level.br_level.c130_heightoverride = var_0;

  if(isDefined(var_1))
    level.br_level.c130_sealeveloverride = var_1;

  setomnvar("_encstr_97881C033AD7963049F94961E92D4065C763DE4907CEF721DCD54B4F6853", scripts\cp_mp\parachute::getc130height());
  setomnvar("_encstr_92F21BD5A5BE4CC9FA0BB13A4B6B593AB293FA6E5616F50D56A5760D3A", scripts\cp_mp\parachute::getc130sealevel());
}

updatec130pathomnvars(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.startpt) || !isDefined(var_0.endpt) || !isDefined(var_0.angle)) {
    return;
  }
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_86980E2ED36AC0E9D1236347510B52CD")) {
    return;
  }
  setomnvar("_encstr_ACE6189B4216FA931820C213582723CBD4D8774749BE28A339E2", int(var_0._id_1386E[0]));
  setomnvar("_encstr_91E618BA2DBE8927EB6C89CC60EB3858E886AF9B1D2C4E47FA5E", int(var_0._id_1386E[1]));
  setomnvar("_encstr_82AC160370A13A73E08F86F651881B71A0F8318F0890FF0B", int(var_0.neurotoxin_damage_monitor[0]));
  setomnvar("_encstr_BDAC1635D4794DCBDFF7FAF2A2074383733CB8B56DA26F92", int(var_0.neurotoxin_damage_monitor[1]));
}

createtestc130path(var_0, var_1) {
  self notify("_encstr_8F070DE89A563B391ED3FFC991BBA1");

  if(isDefined(level.br_level.br_mapcenter) && isDefined(level.br_level.br_mapsize)) {
    var_2 = spawnc130pathstructnew(var_0, var_1);
    level thread _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::determinewinnertype(var_2.centerpt, var_2.angle[1], var_2._id_1386E, var_2.neurotoxin_damage_monitor);
  } else
    var_2 = spawnc130pathstruct(var_0, var_1);

  updatec130pathomnvars(var_2);
  return var_2;
}

spawnc130(var_0, var_1, var_2) {
  var_3 = distance(var_0.startpt, var_0.endpt);
  var_4 = var_3 / getc130speed();
  var_5 = 1;
  level.br_ac130 = gunship_spawn(var_0.startpt, var_0.endpt, var_4, var_5, var_1, var_2);
  level.br_ac130._id_12205 = var_0;
  return var_4;
}

spawnplayertoc130() {
  if(isDefined(level.infil_vignette_anim_type) && level.infil_vignette_anim_type == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0")
    self unlink();

  _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::neurotoxin_damage_loop();
  thread playerputinc130(level.br_ac130);
  self.elevator_manager = 1;

  if(istrue(self.tutorial_usingparachute) && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_BE180419DAE9" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_8AE1099A0B999F2D28AF15" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_9B1F05BE4B9B52" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_A95E0A98B78C2FC6F6AB9B1D" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_866209ECEDB1197DEE0B4E" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_AD51088015D1E2D47930")
    level _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_872514BBE31FE24FD0FED25A53F88C29F90B37335B46", self, 1, 0);
}

playerputinc130(var_0) {
  self.angles = var_0.angles;
  self allowcrouch(0);
  self allowprone(0);
  thread listenjump(var_0, 0);
  thread listenkick(var_0, 0);
  self.br_infil_type = "_encstr_969105B1C4CC81";
  thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::orbitcam(var_0);
  self setclientomnvar("_encstr_8B481AAEB4F50D9619567DB9166B5607B1163A95EBCDE8C996E6EC37", 1);
}

gunship_spawn(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3))
    var_3 = 1;

  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_6 setModel("_encstr_8ADB28B3953407BEB6961BEBB02DC9BE0B360DB0E4364B95C4CC60BEB5C29DDA0BFA0BDCB4AD2C475923");
  var_6 setCanDamage(0);
  var_6.maxhealth = 100000;
  var_6.health = var_6.maxhealth;
  var_6.cleanme = 1;
  var_6.startpt = var_0;
  var_6.dir = vectorNormalize(var_1 - var_0);
  var_6.angles = vectortoangles(var_6.dir);
  var_7 = "_encstr_A3D525B3CA431CD7ADA51BAF85A593AF2C1B342C9CD84B2B4C99187DB558B3D6B0F5E4D23B4B46";

  if(isDefined(level.debugforcesre1))
    var_7 = level.debugforcesre1;

  var_6.innards = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_6.innards setModel(var_7);
  var_6.innards.cleanme = 1;
  var_6.innards linkTo(var_6, "_encstr_B40101", (0, 0, 0), (0, 0, 0));
  var_6.playeroffsets = [(32, 30, -500), (-32, 30, -500), (0, 30, -500), (16, 30, -500), (-16, 30, -500)];
  var_6.currentplayeroffset = 0;

  if(isDefined(var_5))
    var_6[[var_5]]();

  if(var_3)
    var_6 thread kickwhenoutofbounds("_encstr_969105B1C4CC81");

  if(isDefined(var_4))
    var_6 thread[[var_4]](var_1, var_2);
  else
    var_6 thread gunship_handlemovement(var_1, var_2);

  return var_6;
}

gunship_handlemovement(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self hide();

  if(isDefined(self.innards))
    self.innards hide();

  self waittill("_encstr_A2810D5F30B9EADB1F11752B0B15A2");
  self show();

  if(isDefined(self.innards))
    self.innards show();

  self moveTo(var_0, var_1);
  thread killaftertime(var_1, "_encstr_969105B1C4CC81");
  thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::gunship_spawnvfx();
  self playLoopSound("_encstr_97E10C4C93D7C21B4C6660F5D807");
}

add_to_spotlight_array(var_0) {
  var_1 = 0;
  var_2 = 1;
  return ispointinbounds(var_0, var_1, var_2);
}

ispointinbounds(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = scripts\mp\utility\game_utility_mp::track_get_reward_time(var_0, var_2);

  if(!var_3)
    return 0;

  var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootcallbacks() || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound();

  if(var_4 && isDefined(level.br_ac130))
    return var_3;

  var_5 = _encstr_9B831B4BE60EF6D2738ED2CD8DAE9B3ABDB5F6AED1DBCC4CDED573C8B9(var_0);

  if(var_5)
    return 0;

  if(vehicle_collision_getdamagefactor(var_0))
    return 1;

  var_6 = scripts\mp\outofbounds::ispointinoutofbounds(var_0);

  if(var_6)
    return 0;

  if(istrue(var_1)) {
    if(scripts\mp\outofbounds::useshouldsucceedcallback(var_0))
      return 0;
  }

  return 1;
}

_encstr_9B831B4BE60EF6D2738ED2CD8DAE9B3ABDB5F6AED1DBCC4CDED573C8B9(var_0) {
  if(!isDefined(level._encstr_B4101A538B0FDB1DE5AABB80D567B52D7D8648274450533777FF0EDB))
    return 0;

  foreach(var_2 in level._encstr_B4101A538B0FDB1DE5AABB80D567B52D7D8648274450533777FF0EDB) {
    if(isDefined(var_2) && ispointinvolume(var_0, var_2))
      return 1;
  }

  return 0;
}

_id_123AF() {
  var_0 = anglesToForward(self.angles);

  for(;;) {
    var_1 = vectorNormalize(self._id_12205._id_1386E - self.origin);
    var_2 = vectordot(var_0, var_1) < 0;

    if(var_2) {
      break;
    }

    waitframe();
  }
}

kickwhenoutofbounds(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
    setomnvarforallclients("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 1);

  waitframe();
  _id_123AF();
  var_1 = relic_ammo_drain_take_ammo();

  while(!add_to_spotlight_array((self.origin[0], self.origin[1], var_1)))
    waitframe();

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
    setomnvarforallclients("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 0);

  var_2 = getdvarint("_encstr_93C21C6A065D49A28B31131398A09D32F9B0F464FEB781EE7020B77FF07B", 1);

  if(var_2) {
    for(;;) {
      var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
      var_4 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();

      if(var_4 > 0) {
        var_5 = var_4 * var_4;

        if(distance2dsquared(self.origin, var_3) <= var_5) {
          break;
        }
      } else
        break;

      waitframe();
    }
  }

  level.delay_music_reinforcements = 1;
  level.c130inbounds = 1;
  level notify("_encstr_A2091286CAC7D1A30ACF299002393DE8C74E1D86");

  for(;;) {
    var_6 = anglesToForward(self.angles);
    var_7 = vectorNormalize(self._id_12205.centerpt - self.origin);
    var_8 = vectordot(var_6, var_7) < 0;

    if(var_8) {
      break;
    }

    waitframe();
  }

  var_9 = getdvarint("_encstr_8C4614CDD8C9EB269CD783397BA95636E87D6DB4D8D6", 3500);

  for(;;) {
    var_6 = anglesToForward(self.angles);
    var_10 = self.origin + var_6 * var_9;
    var_10 = (var_10[0], var_10[1], var_1);

    if(!add_to_spotlight_array(var_10)) {
      level.debugnextpropindex = 1;

      foreach(var_12 in level.players) {
        if(isDefined(var_12) && isDefined(var_12.br_infil_type) && var_12.br_infil_type == var_0 && !isDefined(var_12.jumptype)) {
          var_12.jumptype = "_encstr_8A720C58B3AB7729A26778B853CB";
          var_12 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
        }
      }

      break;
    }

    if(var_2) {
      var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
      var_4 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();

      if(var_4 > 0) {
        var_5 = var_4 * var_4;

        if(distance2dsquared(var_10, var_3) > var_5) {
          level.debugnextpropindex = 1;

          foreach(var_12 in level.players) {
            if(isDefined(var_12) && isDefined(var_12.br_infil_type) && var_12.br_infil_type == var_0 && !isDefined(var_12.jumptype)) {
              var_12.jumptype = "_encstr_8A720C58B3AB7729A26778B853CB";
              var_12 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
            }
          }

          break;
        }
      }
    }

    waitframe();
  }

  level.c130inbounds = undefined;
  level notify("_encstr_B4DE144C93BE1B139960FA1B5933D1FA98DED59B91CD");
  level.infilstruct.playersinc130 = 0;
  setomnvar("_encstr_A6D91C4B30B0ABBAD1D15421BB78C2A7D808C2C23B687F75F9F95C29BD50", level.infilstruct.playersinc130);
}

killaftertime(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);

  if(isDefined(self.players)) {
    foreach(var_3 in self.players) {
      if(isDefined(var_3) && isDefined(var_3.br_infil_type) && var_3.br_infil_type == var_1 && !isDefined(var_3.jumptype)) {
        var_3.jumptype = "_encstr_8A720C58B3AB7729A26778B853CB";
        var_3 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
      }
    }
  } else {
    foreach(var_3 in level.players) {
      if(isDefined(var_3) && isDefined(var_3.br_infil_type) && var_3.br_infil_type == var_1 && !isDefined(var_3.jumptype)) {
        var_3.jumptype = "_encstr_8A720C58B3AB7729A26778B853CB";
        var_3 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
      }
    }
  }

  self stoploopsound();
  _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::stop_hotjoining(self);
  wait 0.1;

  if(isDefined(self.animstruct)) {
    var_7 = 1;

    while(var_7) {
      var_7 = 0;

      foreach(var_3 in level.players) {
        if(isDefined(var_3.br_infil_type)) {
          var_7 = 1;
          break;
        }
      }

      if(var_7)
        wait 0.5;
    }

    _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::handleheadshotkillrewardbullets(self.animstruct);
  } else {
    if(isDefined(self.innards))
      self.innards delete();

    self delete();
  }
}

listenkick(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8F860C1B58DCB1B28DEB6C4C6603");
  self endon("_encstr_8F7D08C66A0125438523");
  self waittill("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62", var_2);

  if(!isDefined(var_2))
    var_2 = (0, var_0.angles[1] + 180, 0);

  self.display_hint_for_player_single = 1;
  thread leaveplane(var_0, var_1, var_2, 0);
}

listenjump(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8F860C1B58DCB1B28DEB6C4C6603");
  self endon("_encstr_8F7D08C66A0125438523");
  var_2 = undefined;
  self.redeployenabled = 0;
  var_3 = getdvarint("_encstr_9AED1C0BBFE8A90BBE66A38B0B1F2BD5F8239465F511ED83EED928F310EF", 0);
  var_0 _id_123AF();

  for(;;) {
    var_4 = scripts\engine\utility::waittill_either("_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82", "_encstr_AFBE141A8536DBFAD4D5DA07D7DCEDD8DBBE8D62990C");

    if(!isDefined(var_4))
      var_4 = "_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82";

    var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex);

    if(!var_3) {
      var_2 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::calctrailpoint();

      if(add_to_spotlight_array(var_2)) {
        self.jumptype = "_encstr_B61805B97B36DB";
        self notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
        scripts\engine\utility::thread_on_notify("_encstr_831910EB8313CF31B9121BFFC3FECDF5800D", _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat, "_encstr_A97810F553CDD025BAAB13DF566F519130B1", 0);
        break;
      } else
        self iprintlnbold(&"_encstr_AA801A7583F6FD723701A5F737F52057E079A5E8971B11480D98FB80");

      continue;
    }

    var_6 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath() || isDefined(self.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]) && self.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"] == 0;

    if(!var_6 && var_5.size > 1) {
      if(var_4 == "_encstr_AFBE141A8536DBFAD4D5DA07D7DCEDD8DBBE8D62990C") {
        var_2 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::calctrailpoint();

        if(add_to_spotlight_array(var_2)) {
          self.jumptype = "_encstr_B61805B97B36DB";
          self notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
          scripts\engine\utility::thread_on_notify("_encstr_831910EB8313CF31B9121BFFC3FECDF5800D", _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat, "_encstr_A97810F553CDD025BAAB13DF566F519130B1", 0);
          break;
        } else
          self iprintlnbold(&"_encstr_AA801A7583F6FD723701A5F737F52057E079A5E8971B11480D98FB80");
      }

      continue;
    }

    var_2 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::calctrailpoint();

    if(add_to_spotlight_array(var_2)) {
      if(var_6) {
        self.jumptype = "_encstr_8D7A07F007F10143A3";
        var_7 = isDefined(level.squaddata);

        if(var_7) {
          var_8 = level.squaddata[self.team][self.squadindex];
          var_5 = var_8.players;
        }

        foreach(var_10 in var_5) {
          if(var_10 != self && isDefined(var_10.br_infil_type) && !isDefined(var_10.jumptype)) {
            var_10.jumptype = "_encstr_933E090A10B17DDFB3E522";
            var_10 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62", self getplayerangles());
          }

          var_10 playlocalsound("_encstr_AD9021232BD7198A70368C5509F0DC51274FBEA639E8925560FB859EC3301D7B90EFBF");
        }

        if(var_4 != "_encstr_AFBE141A8536DBFAD4D5DA07D7DCEDD8DBBE8D62990C" && getdvarint("_encstr_B84F1CCB91C67F9E98AF704FF11023DFE7C83372D81D0FD2883B635C8BC8", 0))
          thread holdteammatestosquadleader(var_5);
        else {
          foreach(var_10 in var_5) {
            if(isDefined(var_10.br_infil_type))
              setteammateomnvarsforplayer(var_10, var_5, 0);
          }
        }
      }

      break;
    } else
      self iprintlnbold(&"_encstr_AA801A7583F6FD723701A5F737F52057E079A5E8971B11480D98FB80");

    var_2 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::calctrailpoint();
    waitframe();
  }

  thread leaveplane(var_0, var_1, self getplayerangles(), 0);
}

leaveplane(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8F860C1B58DCB1B28DEB6C4C6603");
  setdvarifuninitialized("_encstr_AF0B185BEE4AC10E63378385FBFA4179F8C32150939490B3FAA7", 1);
  self notify("_encstr_8F7D08C66A0125438523");
  self allowcrouch(1);
  self allowprone(1);
  self.plotarmor = undefined;
  scripts\mp\utility\game::_id_131A3(self, 0);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_AB2A0F28DA4178ABF283F3F173FAF72005", 0);

  if(isDefined(level.infilstruct) && isDefined(level.infilstruct.playersinc130) && level.infilstruct.playersinc130 > 0)
    level.infilstruct.playersinc130--;

  self notifyonplayercommandremove("_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82", "_encstr_B44609DFE707CF394E1651");
  self notifyonplayercommandremove("_encstr_AFBE141A8536DBFAD4D5DA07D7DCEDD8DBBE8D62990C", "_encstr_B44609DFE707CF394E1651");
  self notifyonplayercommandremove("_encstr_8CD4180A08DB8D83E0305F9E5BAB4FD30BB87261E0BB06DB9926", "_encstr_9B0D065699E485D9");
  self notifyonplayercommandremove("_encstr_9976159972471B737FD2196F7F10F9F020724249856DA2", "_encstr_97410B23BD6B976233901AF2F8");
  self notifyonplayercommandremove("_encstr_9976159972471B737FD2196F7F10F9F020724249856DA2", "_encstr_B4C60AD707B2BDC0E6CE1309");
  self waittill("_encstr_831910EB8313CF31B9121BFFC3FECDF5800D");

  if(isDefined(self.br_infil_type))
    thread stop_players_inside_death_or_disconnect_monitor(var_0);

  self cameradefault();
  self.br_infil_type = undefined;
  thread parachute(var_0, var_1, var_2, var_3);
  thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_84300D08AEF3690B5382D1F9FF3A61");

  if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_85EE090C9DD0A62F3CA1B3") {
    _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::getspawnpoint(1);
    self setOrigin(self._id_12AB3.origin, 1);
    self setplayerangles(self._id_12AB3.angles);
  }
}

holdteammatestosquadleader(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  thread _id_144D3(var_0);
  var_1 = self;
  wait 0.2;
  var_2 = [(-250, 0, 0), (-150, -150, 0), (-150, 150, 0)];
  var_3 = 0;

  foreach(var_5 in var_0) {
    if(!isDefined(var_5) || !isalive(var_5)) {
      continue;
    }
    if(var_5 != var_1) {
      if(isDefined(var_5.jumptype) && var_5.jumptype != "_encstr_B61805B97B36DB") {
        var_5 thread pushplayertoplayeroffset(var_1, var_2[var_3]);
        var_3++;
        continue;
      }

      setteammateomnvarsforplayer(var_5, var_0, 0);
    }
  }

  var_7 = 2700;
  var_8 = 999999999;

  while(!self useButtonPressed() && var_8 > var_7) {
    var_9 = scripts\common\utility::groundpos(var_1.origin);
    var_8 = var_1.origin[2] - var_9[2];

    if(var_1 isparachuting()) {
      break;
    }

    waitframe();
  }

  foreach(var_11 in var_0) {
    if(!isDefined(var_11) || !isalive(var_11)) {
      continue;
    }
    if(var_11 != self && istrue(var_11.beingpushed)) {
      var_11 notify("_encstr_92160AA3B970E8119FA533FA");
      var_11.beingpushed = undefined;
    }

    setteammateomnvarsforplayer(var_11, var_0, 0);
  }

  self notify("_encstr_AAB118609ADB5599433D93932D6E88ADDFF19908020399B09B15");
}

_id_144D3(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AAB118609ADB5599433D93932D6E88ADDFF19908020399B09B15");
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(var_2 != self && istrue(var_2.beingpushed)) {
      var_2 notify("_encstr_92160AA3B970E8119FA533FA");
      var_2.beingpushed = undefined;
    }

    setteammateomnvarsforplayer(var_2, var_0, 0);
  }
}

setteammateomnvarsforplayer(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath(), 2, var_2);
  var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A97810F553CDD025BAAB13DF566F519130B1", var_3);
}

_id_12611() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_92160AA3B970E8119FA533FA");
  self waittill("_encstr_8D0118DCDAE523A59DB27D19CA0763DE5E0785270BC6435DA359");
  var_0 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B");
  setteammateomnvarsforplayer(self, var_0, 0);
}

pushplayertoplayeroffset(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.beingpushed = 1;
  var_2 = self;
  var_2 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_2 endon("_encstr_92160AA3B970E8119FA533FA");
  var_2 thread _id_12611();
  var_3 = length(var_1);

  while(!var_2 isonground() && !var_2 useButtonPressed() && isDefined(var_0) && !var_2 isparachuting()) {
    var_4 = var_0 getplayerangles();
    var_5 = rotatepointaroundvector((0, 0, 1), var_1, var_4[1]);
    var_6 = var_0.origin + var_5 - var_2.origin;
    var_7 = length(var_6);

    if(var_7 > var_3) {
      var_8 = var_2 getvelocity();
      var_2 setvelocity(var_6 + var_8 * 0.9);
    }

    waitframe();
  }

  var_2 notify("_encstr_92160AA3B970E8119FA533FA");
  var_2.beingpushed = undefined;
  var_9 = scripts\mp\utility\teams::getteamdata(var_2.team, "_encstr_9775086022BE1B413B8B");
  setteammateomnvarsforplayer(var_2, var_9, 0);
}

parachute(var_0, var_1, var_2, var_3) {
  self setclientomnvar("_encstr_82D30EBA5AF5899CEBB473662D36CA23", 1);
  self setclientomnvar("_encstr_8B481AAEB4F50D9619567DB9166B5607B1163A95EBCDE8C996E6EC37", 0);
  self unlink();

  if(isDefined(self.br_orbitcam))
    self.br_orbitcam delete();

  waitframe();
  self playershow(1);

  if(isDefined(var_2))
    self setplayerangles(var_2);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    self.delay_give_tactical_grenade = undefined;
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::branalytics_deploytriggered(self);
  }

  var_4 = (0, 0, 0);

  if(var_3)
    var_4 = anglesToForward(var_0.angles) * getc130speed();

  self.ignorefalldamagetime = gettime() + 5000;
  self skydive_setdeploymentstatus(0);
  var_5 = getdvarfloat("_encstr_B8A621C0C63A895A6E294FA9C332B7C3609361E3B97375716FD082E5B22B89418D69B9", 2.0);
  thread scripts\cp_mp\parachute::startfreefall(var_5, var_1, undefined, var_4);
}

stop_players_inside_death_or_disconnect_monitor(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = self;

  if(isDefined(var_0))
    var_0 playsoundtoplayer("_encstr_85E90F214B17D778126B31F7262DE02EF7", var_1);

  if(scripts\mp\utility\game::round_vehicle_logic() != "_encstr_85EE090C9DD0A62F3CA1B3" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_8F94079C2BB3B2C21B" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_BD1D06DA5D98651B") {
    var_1 setsoundsubmix("_encstr_911712B50EEB26E47DA5B9995A8DEBD6BADC9636", 0.0);
    var_2 = scripts\mp\music_and_dialog::risk_flagspawnshiftingcenter("_encstr_BDC50E4C39D7D2E6339636EB53ABADC1");
    var_1 setplayermusicstate(var_2);
    var_1.stickers = 1;
  }

  wait 1.0;
  var_1 clearclienttriggeraudiozone(3.0);

  if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8F94079C2BB3B2C21B" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_BD1D06DA5D98651B") {
    wait 3.0;
    var_1 clearsoundsubmix("_encstr_911712B50EEB26E47DA5B9995A8DEBD6BADC9636", 15.0);
    var_1 clearsoundsubmix("_encstr_857D18D7E08E0A4BCFC5E3DFB87151D450781B2E01204E529B69", 12.0);
  } else {
    wait 5.0;
    var_1 clearsoundsubmix("_encstr_911712B50EEB26E47DA5B9995A8DEBD6BADC9636", 15.0);
  }
}

setplayervarinrespawnc130(var_0) {
  if(isDefined(self.inrespawnc130) && self.inrespawnc130 == var_0) {
    return;
  }
  self.inrespawnc130 = var_0;
  level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
}

waittoplayinfildialog() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.br_ac130 endon("_encstr_AD75063D571AE108");
  level.br_ac130 _id_123AF();

  for(;;) {
    var_0 = level.br_ac130 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::calctrailpoint();

    if(add_to_spotlight_array(var_0)) {
      foreach(var_2 in level.players) {
        if(isPlayer(var_2))
          var_2 playlocalsound("_encstr_85951A5A366D79F2DB6107138090A421235EB2C2078FF2344140270B");
      }

      wait 1.0;
      scripts\mp\flags::gameflagset("_encstr_B28811BA9B8952D39F1FE35F99DFCFC398101B");
      _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::branalytics_deployallowed();
      level notify("_encstr_A1A61418C35D69665FED269FD503AB1B093A50908AF6");
      level thread scripts\mp\music_and_dialog::suspensemusic();
      return;
    }

    waitframe();
  }
}