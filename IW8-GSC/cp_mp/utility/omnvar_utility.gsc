/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\omnvar_utility.gsc
***********************************************/

tr_vis_facing_dist_add_override(var_0) {
  if(!isDefined(level._id_14675))
    level._id_14675 = [];
}

_id_1403E(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_B1C80D5D9E631E21A65378089A7FD5");
  var_1 = safehouse_restart(var_0);

  if(var_1 == "_encstr_AC0F0D47199F173A3B275B09FA9769") {
    return;
  }
  var_2 = safehouse_revive_and_move_players(var_1);
  thread start_chopper_boss(var_0, var_1, var_2);
}

handlerelicmartyrdomgas() {
  self waittill("_encstr_B1C80D5D9E631E21A65378089A7FD5");
  wait 6;
  self notify("_encstr_93A11D1798657FFD7BA8D1D42D5497F62049A4383229AFC137D1E94763996E");
}

start_chopper_boss(var_0, var_1, var_2) {
  self notify("_encstr_93A11D1798657FFD7BA8D1D42D5497F62049A4383229AFC137D1E94763996E");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_93A11D1798657FFD7BA8D1D42D5497F62049A4383229AFC137D1E94763996E");
  childthread handlerelicmartyrdomgas();

  if(var_1 == "_encstr_8B1608EC43B8D647A113") {
    return;
  }
  for(;;) {
    self waittill("_encstr_8C81147B587894AAE9A8974C26CF731F6030ABFF9013", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_0 != var_7) {
      continue;
    }
    setup_tut_zones(var_3, var_4, var_10, var_5, var_6, var_7, var_8, var_9, var_2, var_1, var_11);
  }
}

setup_tut_zones(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = _id_1331F(var_4, var_9, var_0, var_1, var_3, var_6);
  var_12 = _id_1368B(var_7, var_6, var_9, var_5, var_11, var_3, var_10);

  if(_id_132F1(var_0)) {
    var_12 delete();
    return;
  } else if(_id_13309(var_0, var_11))
    linktoent(var_12, var_0, var_1);

  if(isDefined(var_8))
    [[var_8]](var_12, var_0, var_1, var_2, var_4, var_11);
}

start_bomb_vest_defusal(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0.1;
  var_0.grenade = magicgrenademanual("_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0", var_0.origin, (0, 0, 0), var_6);
  var_0.grenade.angles = var_0.angles;
  var_0.grenade linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  thread _id_128CC(var_0, var_6, var_3);
}

start_bomb_vest_defusal_sequence(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_128CD(var_0, var_1, var_2, var_3, var_5);
}

start_bomb_vest_global_timer(var_0, var_1, var_2, var_3, var_4, var_5) {}

_id_128CC(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_0.grenade scripts\engine\utility::_id_143BF(var_1, "_encstr_860808CB78E2984063BA");
  var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_860808CB78E2984063BA");
  var_3 = getcompleteweaponname("_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0");
  var_4 = getcompleteweaponname("_encstr_A90C1AE6ACB63A5987AFE16BA5ADCA13C027FAE60E36B0DC86D76B07");
  var_3._id_121D9 = var_0.weapon;
  var_4._id_121D9 = var_0.weapon;
  glassradiusdamage(var_0.origin, 150, 50, 1);

  if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity)) {
    var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
    var_0.stuckenemyentity dodamage(175, var_0.origin, self, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_3, var_2);
    var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
  }

  getplaylistname(var_0.origin, 9, 35, 15, 25, 60, 14, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_4);
  wait 0.4;

  if(!var_0 _id_140D4()) {
    return;
  }
  var_0 delete();
}

_id_128CD(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_0.unset_relic_hideobjicons)) {
    var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8F54108DA991FA75B1F3F911E13A4F9BD333");
    _id_1437F(var_0);
  }

  var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_B89B0531ABE4CD");
  thread _id_13B2B(var_0);
  thread _id_13B27(var_0);
  thread _id_13B26(var_0);
}

_id_1437F(var_0) {
  var_0 endon("_encstr_BE44112375E3C79CEF30A26B81CB5597185DAC");
  var_0 thread _id_128D1();
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_1, var_2);

  if(isDefined(var_1)) {
    linktoent(var_0, var_1, var_2);
    var_0.debug_listing_helis = 1;
  }
}

_id_128D1() {
  wait 3;

  if(isDefined(self))
    self notify("_encstr_BE44112375E3C79CEF30A26B81CB5597185DAC");
}

_id_13B2B(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_1 = getcompleteweaponname("_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002");
  var_1._id_121D9 = var_0.weapon;

  if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity)) {
    if(var_0.stuckenemyentity scripts\cp_mp\vehicles\vehicle::isvehicle() || isDefined(var_0.stuckenemyentity.classname) && var_0.stuckenemyentity.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E")
      var_2 = 0.95;
    else
      var_2 = 0.25;

    if(istrue(var_0.debug_listing_helis))
      var_0.stuckenemyentity dodamage(80, var_0.origin, self, var_0, "_encstr_9B0D099AD3887D91252954", var_1);

    var_3 = int(3.0 / var_2);

    while(isDefined(var_0) && isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity) && var_3 >= 0) {
      var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
      var_0.stuckenemyentity dodamage(3, var_0.origin, self, var_0, "_encstr_9B0D099AD3887D91252954", var_1);
      var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
      var_3--;
      wait(var_2);
    }
  }
}

_id_13B27(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_1 = int(12.0);
  var_2 = getcompleteweaponname("_encstr_889F1CA3D0ACC9B62D8EB2FA3CB596DAACC403E4D7390B23A5D5B9BED607");
  var_2._id_121D9 = var_0.weapon;
  var_0._id_13B28 = var_2.basename;

  while(var_1 > 0) {
    if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity))
      var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::adddamagemodifier("_encstr_B13A12B1FB0A66080173D93BCBFDF00EF3171737", 0, 0, ::_id_13B1C);

    var_0 radiusdamage(var_0.origin, 50, 2, 2, self, "_encstr_9B0D099AD3887D91252954", var_2);

    if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity))
      var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::removedamagemodifier("_encstr_B13A12B1FB0A66080173D93BCBFDF00EF3171737", 0);

    var_1--;
    wait 0.25;
  }
}

_id_13B1C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0))
    return 1;

  if(!isDefined(var_0._id_13B28) || var_0._id_13B28 != "_encstr_889F1CA3D0ACC9B62D8EB2FA3CB596DAACC403E4D7390B23A5D5B9BED607")
    return 1;

  if(!isDefined(var_0.stuckenemyentity) || var_0.stuckenemyentity != var_2)
    return 1;

  return 0;
}

_id_13B26(var_0) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  wait 3.0;

  if(!var_0 _id_140D4()) {
    return;
  }
  var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_ACB108EBBF52DB7B4D03");
  var_0 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A");
  wait(randomfloatrange(0.3, 2.0));

  if(!var_0 _id_140D4()) {
    return;
  }
  wait(randomfloatrange(2, 3));
  var_0 delete();
}

_id_1368B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 && var_2 == "_encstr_A3CA081B50EDAB3D60A9") {
    var_7 = _id_12AC9(var_5, var_1, var_0, 1, var_6);
    var_8 = var_0 + var_5 * 10;
    var_9 = magicgrenademanual("_encstr_913A11D0614F43DD17A230EF270EC9A53F13A2", var_8, var_7, 10);
    var_9.unset_relic_hideobjicons = 1;
    playFX(scripts\engine\utility::getfx("_encstr_B26817A0E1F0F7D97670535399811BD160E03116F718731658"), var_0, var_5);
  } else {
    var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
    var_9 setModel("_encstr_96082108F8024F0A68811B395F0BFD676B692A4231AFE2E8615B3E0834A926536213CF");
    var_9.origin = var_0;

    if(var_4) {
      var_7 = _id_12AC9(var_5, var_1, var_0, 0, var_6);
      var_9 physicslaunchserver(var_0, var_7);
    }
  }

  var_9.angles = vectortoangles(var_1);
  var_9 _id_13142(var_2);
  var_9.owner = self;
  var_9.brush = var_2;
  var_9.weapon = var_3;
  var_9.vehicle_collision_ignorefutureevent = 1;
  var_9 thread _id_128CB();
  _id_11AB5(var_9);
  return var_9;
}

_id_13142(var_0) {
  switch (var_0) {
    case "_encstr_A3CA081B50EDAB3D60A9":
      thread _id_13143(3.5);
      self.last_saydefuse_time = 0;
      break;
    case "_encstr_AB440A3180D0C0109B17550B":
      self.last_saydefuse_time = 0;
      break;
    default:
      self.last_saydefuse_time = 1;
  }
}

_id_13143(var_0) {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  wait(var_0);
  self.last_saydefuse_time = 1;
  _id_11AB5();
}

_id_11AB5(var_0) {
  if(isDefined(var_0))
    var_1 = [var_0];
  else
    var_1 = [];

  foreach(var_3 in level._id_14675) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_3)) {
      if(var_1.size >= 24 && var_3.last_saydefuse_time) {
        var_3 delete();
        continue;
      }

      var_1[var_1.size] = var_3;
    }
  }

  level._id_14675 = var_1;
}

safehouse_restart(var_0) {
  var_1 = "_encstr_B40101";

  foreach(var_3 in var_0.attachments) {
    if(issubstr(var_3, "_encstr_8C5109B15863C6EA6E3A26")) {
      var_1 = "_encstr_93931296D86BFFF828B323961829F3CFB587923B";
      break;
    }

    if(issubstr(var_3, "_encstr_A95109B1C236D85D6EA346")) {
      var_1 = "_encstr_8A77125EB62A2F4B930B423123D58077C2CA6FFB";
      break;
    }
  }

  switch (var_1) {
    case "_encstr_8A77125EB62A2F4B930B423123D58077C2CA6FFB":
      return "_encstr_A3CA081B50EDAB3D60A9";
    case "_encstr_93931296D86BFFF828B323961829F3CFB587923B":
      return "_encstr_AB440A3180D0C0109B17550B";
    default:
      return "_encstr_8B1608EC43B8D647A113";
  }
}

safehouse_revive_and_move_players(var_0) {
  switch (var_0) {
    case "_encstr_A3CA081B50EDAB3D60A9":
      return::start_bomb_vest_defusal_sequence;
    case "_encstr_AB440A3180D0C0109B17550B":
      return::start_bomb_vest_defusal;
    default:
      return::start_bomb_vest_global_timer;
  }
}

_id_1331F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0))
    var_0 = "_encstr_B40101";

  if(var_0 == "_encstr_A5450BC280BF4B604068C33187")
    return 1;

  if(var_1 != "_encstr_A3CA081B50EDAB3D60A9")
    return 0;

  if(!isDefined(var_2) && isDefined(var_3))
    return 1;

  if(use_trace_radius(var_2) || use_struct(var_2))
    return 1;

  if(unpause_wave_hud(var_2) || unpause_dmz_scoring(var_2))
    return 0;

  if(isDefined(var_2)) {
    if(var_2 scripts\cp_mp\vehicles\vehicle::isvehicle())
      return 0;

    if(isDefined(var_2.equipmentref) && var_2.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506")
      return 0;
  }

  switch (var_0) {
    case "_encstr_9A2B0C92802302173E76A7AC0321":
    case "_encstr_8F920BD9630BB9E6D738B037AC":
    case "_encstr_A5450BC280BF4B604068C33187":
      return 1;
    default:
      var_6 = abs(vectordot(var_5, var_4));

      if(var_6 < 0.2) {
        return 1;
        return;
      }

      return 0;
      return;
  }
}

_id_12AC9(var_0, var_1, var_2, var_3, var_4) {
  if(var_3) {
    var_5 = 1500;
    var_6 = 500;
    var_7 = 150;
  } else {
    var_5 = 500;
    var_6 = 500;
    var_7 = 500;
  }

  if(isDefined(var_4)) {
    var_8 = var_1;
    var_9 = 0;
  } else {
    var_8 = scripts\engine\math::vector_reflect(var_1, var_0);
    var_8 = vectorlerp(var_8, var_0, 0.2);
    var_9 = abs(vectordot(var_1, var_0));
  }

  if(var_9 < 0.2) {
    var_9 = scripts\engine\math::normalize_value(0, 0.2, var_9);
    var_10 = scripts\engine\math::factor_value(var_5, var_6, var_9);
  } else {
    var_9 = scripts\engine\math::normalize_value(0.2, 1, var_9);
    var_10 = scripts\engine\math::factor_value(var_6, var_7, var_9);
  }

  var_8 = var_8 * var_10;
  return var_8;
}

_id_132F1(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isagent(var_0) && var_0 trytoplaydamagesound() && !isalive(var_0) && !isDefined(var_0 getcorpseentity()))
    return 1;

  return 0;
}

_id_13309(var_0, var_1) {
  if(var_1 || !isDefined(var_0))
    return 0;

  if(isDefined(var_0.classname) && var_0.classname == "_encstr_B8CD18938B53A368ED19B781C26B8D785A2AFA798A2278E97049")
    return 0;

  return 1;
}

trytoplaydamagesound() {
  return istrue(isDefined(self.unittype) && self.unittype == "_encstr_8EF60E63FBE3D70440A312175B98CF6B");
}

linktoent(var_0, var_1, var_2) {
  if((isPlayer(var_1) || isagent(var_1)) && !isalive(var_1)) {
    var_3 = var_1 getcorpseentity();

    if(isDefined(var_3))
      var_1 = var_3;
  }

  if(isPlayer(var_1))
    var_0 hidefromplayer(var_1);

  if(isDefined(var_2))
    var_0 linkTo(var_1, var_2);
  else
    var_0 linkTo(var_1);

  if(get_center_loc_among_target_players(var_1)) {
    var_0.stuckenemyentity = var_1;
    var_0 thread _id_12C28(var_1);
  }

  if(!istrue(var_0.unset_relic_hideobjicons))
    var_0 notsolid();

  var_0 thread _id_128D0(var_1);
  var_0 thread _id_128CA(var_1, "_encstr_8DE710563D72F231B84D707969746FB39AD0");
  var_0 thread _id_128CA(var_1, "_encstr_AC8F0AC94174F85AFA901D30");
  var_0 thread _id_128CA(var_1, "_encstr_BEBC0A21371738404846EFF1");
}

_id_140D4() {
  if(isDefined(self) && istrue(self.vehicle_collision_ignorefutureevent))
    return 1;
  else {}
}

_id_12C28(var_0) {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_0 scripts\engine\utility::_id_143A6("_encstr_8A490E5973475A8EE546CA63B23ACA46", "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");

  if(!_id_140D4()) {
    return;
  }
  self.stuckenemyentity = undefined;

  if(isDefined(var_0) && isDefined(var_0.nocorpse))
    self delete();
}

_id_128D0(var_0) {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");

  if(isagent(var_0))
    var_0 waittill("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  else
    var_0 scripts\engine\utility::_id_143A5("_encstr_8A490E5973475A8EE546CA63B23ACA46", "_encstr_8D820B49520F0EC02DDE6367EC");

  if(!_id_140D4()) {
    return;
  }
  _id_128CF();
}

_id_128CF(var_0) {
  if(!isDefined(var_0))
    var_0 = (0, 0, 100);

  if(self islinked())
    self unlink();

  if(!istrue(self.unset_relic_hideobjicons))
    self solid();

  self physicslaunchserver(self.origin, var_0);
}

_id_128CA(var_0, var_1) {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_0 waittill(var_1);

  if(!_id_140D4()) {
    return;
  }
  self delete();
}

_id_128CB() {
  self waittill("_encstr_8A490E5973475A8EE546CA63B23ACA46");

  if(isDefined(self.grenade))
    self.grenade delete();
}

use_trace_radius(var_0) {
  if(!isPlayer(var_0))
    return 0;

  if(scripts\mp\utility\player::isenemy(var_0))
    return 0;
  else
    return 1;
}

unpause_wave_hud(var_0) {
  if(!isPlayer(var_0))
    return 0;

  if(scripts\mp\utility\player::isenemy(var_0))
    return 1;
  else
    return 0;
}

use_struct(var_0) {
  if(!isagent(var_0))
    return 0;

  if(isDefined(var_0.agentteam) && self.team == var_0.agentteam)
    return 1;

  return 0;
}

unpause_dmz_scoring(var_0) {
  if(!isagent(var_0))
    return 0;

  if(isDefined(var_0.agentteam) && self.team == var_0.agentteam)
    return 0;

  return 1;
}

get_center_loc_among_target_players(var_0) {
  var_1 = 0;

  if(isPlayer(var_0) || isagent(var_0))
    var_1 = 1;

  if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle())
    var_1 = 1;

  if(isDefined(var_0.classname)) {
    if(var_0.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E")
      var_1 = 1;

    if(var_0.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
      if(isDefined(var_0.streakinfo) && (var_0.streakinfo.streakname == "_encstr_851904B59B34" || var_0.streakinfo.streakname == "_encstr_86FD08B775CD07DC1338"))
        var_1 = 1;
    }
  }

  if(isDefined(var_0.equipmentref)) {
    if(var_0.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506")
      var_1 = 1;
  }

  return var_1;
}