/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\vehicle_damage_cp.gsc
***********************************************/

teleport_text_updated(var_0) {
  if(!isDefined(level.init_weapon_variant_spawns))
    level.init_weapon_variant_spawns = [];
}

initarmor(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_B1C80D5D9E631E21A65378089A7FD5");
  var_1 = relic_mythic_can_do_pain(var_0);
  var_2 = relic_mythic_do_pain(var_1);
  thread init_wind_tunnels(var_0, var_1, var_2);
}

handlerelicmartyrdomgas() {
  self waittill("_encstr_B1C80D5D9E631E21A65378089A7FD5");
  wait 6;
  self notify("_encstr_A69F157BC1CDF115DFD3D31F3B9F01733C31FBEA3A2B22");
}

init_wind_tunnels(var_0, var_1, var_2) {
  self notify("_encstr_A69F157BC1CDF115DFD3D31F3B9F01733C31FBEA3A2B22");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A69F157BC1CDF115DFD3D31F3B9F01733C31FBEA3A2B22");
  childthread handlerelicmartyrdomgas();

  for(;;) {
    self waittill("_encstr_8C81147B587894AAE9A8974C26CF731F6030ABFF9013", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_0 != var_7) {
      continue;
    }
    var_12 = _id_1362B(var_9, var_8, var_1, var_7);
    setup_tut_zones(var_12, var_3, var_4, var_10, var_5, var_6, var_7, var_8, var_9, var_2);
  }
}

setup_tut_zones(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(_id_1331F(var_5, var_0, var_1, var_2))
    _id_12AC6(var_0, var_4, var_7, var_8);
  else if(_id_132F1(var_1)) {
    var_0 delete();
    return;
  } else if(_id_13309(var_1))
    linktoent(var_0, var_1, var_2);

  if(isDefined(var_9))
    [[var_9]](var_0, var_1, var_2, var_3, var_5);
}

start_authentication_timer(var_0, var_1, var_2, var_3, var_4) {}

start_bomb_vest_defusal(var_0, var_1, var_2, var_3, var_4) {
  var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_878807108A42A309BB");

  if(isDefined(var_1) && (isPlayer(var_1) || isagent(var_1)))
    var_5 = 1.1;
  else
    var_5 = 2;

  var_0.grenade = magicgrenademanual("_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1", var_0.origin, (0, 0, 0), var_5);
  var_0.grenade.angles = var_0.angles;
  var_0.grenade linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  thread onsupportboxusedbyplayer(var_0, var_5);
}

start_bomb_vest_defusal_sequence(var_0, var_1, var_2, var_3, var_4) {
  var_0.surfacetype = var_4;
  var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_878807108A42A309BB");
  thread _id_13B25(var_0, var_1, var_2, var_3);
  var_5 = 0;

  if(isDefined(level._id_132A4) && [[level._id_132A4.lowpopallowtweaks]](var_0))
    var_5 = 1;

  if(!var_5)
    thread _id_13B24(var_0, var_1);

  thread _id_13B23(var_0, var_5);
}

start_box_set_up(var_0, var_1, var_2, var_3, var_4) {
  if(_id_13937(var_1, var_4)) {
    var_0 setscriptablepartstate("_encstr_878807108A42A309BB", "_encstr_930B07BB1B6B3854FF");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_880612DC365BD70912CF58E8D76C63F362DF45DE"))
      thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_880612DC365BD70912CF58E8D76C63F362DF45DE")]](var_0.origin, self, 5, 0.45);

    thread _id_13936(var_0);
  } else
    var_0 setscriptablepartstate("_encstr_878807108A42A309BB", "_encstr_9618043D534A");
}

onsupportboxusedbyplayer(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_0.grenade scripts\engine\utility::_id_143BF(var_1, "_encstr_860808CB78E2984063BA");
  var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_860808CB78E2984063BA");
  var_2 = getcompleteweaponname("_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1");
  var_3 = getcompleteweaponname("_encstr_84A0166830BBFB0FB38089F0E1D84E2B5B18102BBA09B85B");
  var_2._id_121D9 = var_0.weapon;
  var_3._id_121D9 = var_0.weapon;

  if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity)) {
    var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
    var_0.stuckenemyentity dodamage(65, var_0.origin, self, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_2);
    var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
  }

  radiusdamage(var_0.origin, 160, 65, 35, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_3);
  wait 0.4;

  if(!var_0 _id_140CA()) {
    return;
  }
  var_0 delete();
}

_id_13B25(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_4 = getcompleteweaponname("_encstr_8E3B11F9785798B1A7BB5906C267F96061C579");
  var_4._id_121D9 = var_0.weapon;

  if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity)) {
    if(var_1 scripts\cp_mp\vehicles\vehicle::isvehicle() || isDefined(var_1.classname) && var_1.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E")
      var_5 = 1.0;
    else
      var_5 = 0.25;

    var_6 = int(4.5 / var_5);

    while(isDefined(var_1) && isDefined(var_0) && isalive(var_1) && var_6 > 0) {
      var_1 scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
      var_1 dodamage(5, var_0.origin, self, var_0, "_encstr_9B0D099AD3887D91252954", var_4, var_3);
      var_1 scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
      var_6--;
      wait(var_5);
    }
  }
}

_id_13B24(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_2 = int(18.0);
  var_3 = getcompleteweaponname("_encstr_B69C1874D1289ABFBB9B4AD16180F353A18D19EC4BAB62AF51F3");
  var_3._id_121D9 = var_0.weapon;
  var_0._id_13B28 = var_3.basename;

  while(var_2 > 0) {
    if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity))
      var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::adddamagemodifier("_encstr_863C12E9A3523E60790BB16DF554E0E61BBFBF5F", 0, 0, ::_id_13B1C);

    var_0 radiusdamage(var_0.origin, 50, 5, 3, self, "_encstr_9B0D099AD3887D91252954", var_3);

    if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity))
      var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::removedamagemodifier("_encstr_863C12E9A3523E60790BB16DF554E0E61BBFBF5F", 0);

    var_2--;
    wait 0.25;
  }
}

_id_13B1C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0))
    return 1;

  if(!isDefined(var_0._id_13B28) || var_0._id_13B28 != "_encstr_B69C1874D1289ABFBB9B4AD16180F353A18D19EC4BAB62AF51F3")
    return 1;

  if(!isDefined(var_0.stuckenemyentity) || var_0.stuckenemyentity != var_2)
    return 1;

  return 0;
}

_id_13B23(var_0, var_1) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");

  if(!var_1) {
    wait 4.5;

    if(!var_0 _id_140CA()) {
      return;
    }
    var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_92B1082E2D4B458DC014");
    wait(randomfloatrange(0.3, 2.0));

    if(!var_0 _id_140CA())
      return;
  }

  var_0 course_triggers_expl();
  var_0 setModel("_encstr_A1DD2B1F3312BFA75066CB95373AF639AF4D202353CDCF2F388DE00193C782F91AFB818FA59E804BA2568BA291");
}

_id_13936(var_0) {
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  wait 0.5;

  if(!var_0 _id_140CA()) {
    return;
  }
  var_0 delete();
}

_id_13937(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(!isPlayer(var_0) && !isagent(var_0))
    return 0;

  if(isDefined(var_0.team) && self.team == var_0.team)
    return 0;

  if(var_1 == "_encstr_A5450BC280BF4B604068C33187")
    return 0;

  return 1;
}

_id_1362B(var_0, var_1, var_2, var_3) {
  var_4 = regroup_points(var_2);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_5 setModel(var_4);
  var_5.angles = vectortoangles(var_1);
  var_5 _id_13142(var_2);
  var_5.owner = self;
  var_5.brush = var_2;
  var_5.weapon = var_3;
  var_5.uavnoneid = 1;

  if(_id_1330E(var_2))
    var_5 = _id_11AA3(var_5);

  var_5 thread countdownendcallback();
  _id_11AB4(var_5);
  return var_5;
}

_id_1330E(var_0) {
  if(var_0 == "_encstr_97060D4CB7638EFA8C5966C2EAD8A3" || var_0 == "_encstr_81370A41474294A84F94BB38")
    return 1;

  return 0;
}

_id_11AA3(var_0) {
  var_1 = var_0.origin + anglesToForward(var_0.angles) * 15;
  var_2 = axistoangles(anglestoup(var_0.angles), anglestoright(var_0.angles), anglesToForward(var_0.angles));
  var_3 = spawn("_encstr_BE66191DB6995910437226C04038E353EE95B49957DAAE91C3AD72", var_1, 0, 64, 79);
  var_3.angles = var_2;
  var_3.targetname = "_encstr_93E50C6248702B2111A0D26A7829";
  var_3 enablelinkTo();
  var_3 linkTo(var_0);
  var_0._id_12357 = var_3;
  var_0 thread cosfov();
  return var_0;
}

_id_12C15(var_0) {
  var_0 notify("_encstr_82DC0D46CDE0B854553FCB8F0AAF33");

  if(isDefined(var_0._id_12357))
    var_0._id_12357 delete();
}

cosfov() {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  self endon("_encstr_82DC0D46CDE0B854553FCB8F0AAF33");
  wait 2;

  for(;;) {
    self._id_12357 waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isDefined(self.stuckenemyentity) && isalive(self.stuckenemyentity)) {
      continue;
    }
    var_1 = register_boss_spawners(var_0 getweaponslistprimaries());

    if(!isDefined(var_1)) {
      continue;
    }
    if(var_0 correctcodeentered(var_1))
      self delete();
  }
}

register_boss_spawners(var_0) {
  foreach(var_2 in var_0) {
    if(var_2 hasattachment("_encstr_852A0EDA4D8767B93388C0CF9A5B0F8F") && self.brush == "_encstr_97060D4CB7638EFA8C5966C2EAD8A3")
      return var_2;

    if(var_2 hasattachment("_encstr_87131231E91766770D69A362822217BB2F9248B4") && self.brush == "_encstr_97060D4CB7638EFA8C5966C2EAD8A3")
      return var_2;

    if(var_2 hasattachment("_encstr_A6FA1282E739D317BB3B9088B913C043BE188017") && self.brush == "_encstr_81370A41474294A84F94BB38")
      return var_2;
  }

  return undefined;
}

correctcodeentered(var_0) {
  var_1 = weaponmaxammo(var_0);
  var_2 = self getweaponammostock(var_0);

  if(var_2 >= var_1)
    return 0;

  var_3 = int(min(var_1, var_2 + 1));
  self setweaponammostock(var_0, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_87FE0CE0F3BF3BC10FD6957BA04F"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_87FE0CE0F3BF3BC10FD6957BA04F")]]("_encstr_93370DD84E7B9B9BC4B77731F61B1D");

  return 1;
}

_id_13142(var_0) {
  switch (var_0) {
    case "_encstr_8DE40A42373223B6E841E659":
      thread _id_13143(5);
      self.last_saydefuse_time = 0;
      break;
    case "_encstr_83180BFD873BBBA83778BBFB20":
      self.last_saydefuse_time = 0;
      break;
    case "_encstr_81370A41474294A84F94BB38":
      thread _id_13143(0.5);
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
  _id_11AB4();
}

_id_11AB4(var_0) {
  if(isDefined(var_0))
    var_1 = [var_0];
  else
    var_1 = [];

  foreach(var_3 in level.init_weapon_variant_spawns) {
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

  level.init_weapon_variant_spawns = var_1;
}

relic_mythic_can_do_pain(var_0) {
  var_1 = "_encstr_B40101";

  foreach(var_3 in var_0.attachments) {
    if(issubstr(var_3, "_encstr_A69B053982C355")) {
      var_1 = var_3;
      break;
    }
  }

  switch (var_1) {
    case "_encstr_964614DA25E1BBA119DB8E3D264989FE58CF90485F90":
      return "_encstr_A3240C219ADB5D998639B58D2FAD";
    case "_encstr_A9B01326DEB13A2B0F3863F6D7C6C9DB37B9267B77":
      return "_encstr_83180BFD873BBBA83778BBFB20";
    case "_encstr_B460120A50F13BBB302E75574EBB570237D042D3":
      return "_encstr_8DE40A42373223B6E841E659";
    case "_encstr_A6FA1282E739D317BB3B9088B913C043BE188017":
      return "_encstr_81370A41474294A84F94BB38";
    default:
      return "_encstr_97060D4CB7638EFA8C5966C2EAD8A3";
  }
}

relic_mythic_do_pain(var_0) {
  switch (var_0) {
    case "_encstr_A3240C219ADB5D998639B58D2FAD":
      return::start_authentication_timer;
    case "_encstr_83180BFD873BBBA83778BBFB20":
      return::start_bomb_vest_defusal;
    case "_encstr_8DE40A42373223B6E841E659":
      return::start_bomb_vest_defusal_sequence;
    case "_encstr_81370A41474294A84F94BB38":
      return::start_box_set_up;
    default:
      return;
  }
}

regroup_points(var_0) {
  switch (var_0) {
    case "_encstr_A3240C219ADB5D998639B58D2FAD":
      return "_encstr_83FF29705FA9CB1F5A61141149A3559613AB28D8FF42E0171156B7A99B9997196A73A0C8E70BDBF34BBC0E";
    case "_encstr_83180BFD873BBBA83778BBFB20":
      return "_encstr_99E72C0C49AE2BA2AE1FAC5997784A6922DD50DB885BE20377E28F9888B67BB8CA31DAB7AFC84D1F6F095763F86F";
    case "_encstr_8DE40A42373223B6E841E659":
      return "_encstr_A15B278C5DBF339FDDB9E83091B2A56E1FD21806A36B18E7C91230633B417DE0236D88FE1C0F23032E";
    case "_encstr_81370A41474294A84F94BB38":
      return "_encstr_9BD4270FB370623FB066E34A4E160311C8059F73F730ED97F0397A6233783F13809537FB41C0F3B786";
    default:
      return "_encstr_9BA422D8F7015387B299FC89E11BFDFE6B33904007DA487F89FEF80103F10F43D1433848";
  }
}

_id_1331F(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2) && isDefined(var_3))
    return 1;

  if(!isDefined(var_0))
    return 0;

  switch (var_0) {
    case "_encstr_9A2B0C92802302173E76A7AC0321":
    case "_encstr_8F920BD9630BB9E6D738B037AC":
      return 1;
  }

  if(var_1.brush == "_encstr_83180BFD873BBBA83778BBFB20")
    return 0;

  if(use_trace_radius(var_2))
    return 1;

  if(use_struct(var_2))
    return 1;

  switch (var_0) {
    case "_encstr_B87B0C5B1BB053CA4AA557EFB96D":
    case "_encstr_817B0C42C8B154CFC80567541E32":
    case "_encstr_A5450BC280BF4B604068C33187":
      return 1;
    case "_encstr_9AA90ADAAC4716B1FA36C29C":
    case "_encstr_8BFB0B288908C790C7684F3622":
    case "_encstr_8F1C11C5152B278527D0DA4230B7BD9BC38D42":
    case "_encstr_AFFC0BE585F819E139F33B0485":
    case "_encstr_8C480C0A71E567FD11199069CF48":
    case "_encstr_83550CDA95A3168DEB76C9851DCA":
      if(var_1.brush == "_encstr_8DE40A42373223B6E841E659")
        return 0;
      else
        return 1;
    default:
      return 0;
  }
}

_id_12AC6(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\math::vector_reflect(var_2, var_1);
  var_5 = abs(vectordot(var_2, var_1));
  var_6 = scripts\engine\math::factor_value(2300, 1000, var_5);
  var_4 = var_4 * var_6;
  var_0 physicslaunchserver(var_3, var_4);
}

_id_132F1(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isagent(var_0) && var_0 trytoplaydamagesound() && !isalive(var_0) && !isDefined(var_0 getcorpseentity()))
    return 1;

  return 0;
}

_id_13309(var_0) {
  if(!isDefined(var_0))
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

  if(isPlayer(var_1) && var_0.brush != "_encstr_81370A41474294A84F94BB38") {
    var_0 hidefromplayer(var_1);

    if(isDefined(var_0._id_12357))
      var_0._id_12357 hidefromplayer(var_1);
  }

  if(isDefined(var_2))
    var_0 linkTo(var_1, var_2);
  else
    var_0 linkTo(var_1);

  if(get_center_loc_among_target_players(var_1)) {
    var_0.stuckenemyentity = var_1;
    var_0 thread _id_12C28(var_1);
  }

  var_0 notsolid();
  var_0 thread courtyard_intel_sequence(var_1);
  var_0 thread cosmeticattachment(var_1, "_encstr_8DE710563D72F231B84D707969746FB39AD0");
  var_0 thread cosmeticattachment(var_1, "_encstr_AC8F0AC94174F85AFA901D30");
  var_0 thread cosmeticattachment(var_1, "_encstr_BEBC0A21371738404846EFF1");
}

_id_140CA() {
  if(isDefined(self) && istrue(self.uavnoneid))
    return 1;
  else {}
}

_id_12C28(var_0) {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_0 scripts\engine\utility::_id_143A6("_encstr_8A490E5973475A8EE546CA63B23ACA46", "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");

  if(!_id_140CA()) {
    return;
  }
  self.stuckenemyentity = undefined;

  if(isDefined(var_0) && isDefined(var_0.nocorpse))
    self delete();
}

courtyard_intel_sequence(var_0) {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_0 scripts\engine\utility::_id_143A5("_encstr_8A490E5973475A8EE546CA63B23ACA46", "_encstr_8D820B49520F0EC02DDE6367EC");

  if(!_id_140CA()) {
    return;
  }
  course_triggers_expl();
}

course_triggers_expl(var_0) {
  if(!isDefined(var_0))
    var_0 = (0, 0, 100);

  if(self islinked())
    self unlink();

  if(!isDefined(self.model) || self.model == "_encstr_A2B40B8E2C3B7DDB274B9D4B37" || self.model == "_encstr_B40101") {
    return;
  }
  self solid();
  self physicslaunchserver(self.origin, var_0);
}

cosmeticattachment(var_0, var_1) {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_0 waittill(var_1);

  if(!_id_140CA()) {
    return;
  }
  self delete();
}

countdownendcallback() {
  self waittill("_encstr_8A490E5973475A8EE546CA63B23ACA46");

  if(isDefined(self._id_12357))
    self._id_12357 delete();

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

use_struct(var_0) {
  if(!isagent(var_0))
    return 0;

  if(isDefined(var_0.agentteam) && self.team == var_0.agentteam)
    return 1;

  return 0;
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