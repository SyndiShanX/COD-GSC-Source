/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\cargo_truck_mg_cp.gsc
***********************************************/

tr_vis_facing_dist_add_override(var_0) {
  if(!isDefined(level.chopper_sound_fade_and_delete))
    level.chopper_sound_fade_and_delete = [];
}

_id_1403E(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_B1C80D5D9E631E21A65378089A7FD5");
  var_1 = registeronrespawn(var_0);
  var_2 = registerontimerexpired(var_1);
  thread chopperexfil_introsound(var_0, var_1, var_2);
}

handlerelicmartyrdomgas() {
  self waittill("_encstr_B1C80D5D9E631E21A65378089A7FD5");
  wait 6;
  self notify("_encstr_A69F157BC1CDF115DFD3D31F3B9F01733C31FBEA3A2B22");
}

chopperexfil_introsound(var_0, var_1, var_2) {
  self notify("_encstr_A69F157BC1CDF115DFD3D31F3B9F01733C31FBEA3A2B22");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A69F157BC1CDF115DFD3D31F3B9F01733C31FBEA3A2B22");
  childthread handlerelicmartyrdomgas();

  for(;;) {
    self waittill("_encstr_8C81147B587894AAE9A8974C26CF731F6030ABFF9013", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_0 != var_7) {
      continue;
    }
    var_12 = _id_1360F(var_9, var_8, var_1, var_7);
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

_id_1360F(var_0, var_1, var_2, var_3) {
  var_4 = regroup_points(var_3);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_5 setModel(var_4);
  var_5.angles = vectortoangles(var_1) + (90, 0, 0);
  var_5 _id_13142(var_2);
  var_5.owner = self;
  var_5.brush = var_2;
  var_5.weapon = var_3;
  var_5.tut_bots_forcelaststand_onspawn = 1;

  if(_id_1330E(var_2))
    var_5 = _id_11AA3(var_5);

  var_5 thread countdownendcallback();
  _id_11AB4(var_5);
  return var_5;
}

_id_1330E(var_0) {
  if(var_0 == "_encstr_97060D4CB7638EFA8C5966C2EAD8A3")
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
    if(var_2 hasattachment("_encstr_BA23187D09187FCAA5AFDBE63D5F22B480D3B3C4E12006C20CE3") && self.brush == "_encstr_97060D4CB7638EFA8C5966C2EAD8A3")
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

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_8BAB0D671B7B1205123A885C12915F"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_8BAB0D671B7B1205123A885C12915F")]](self, "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014", 1, 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_87FE0CE0F3BF3BC10FD6957BA04F"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_87FE0CE0F3BF3BC10FD6957BA04F")]]("_encstr_92590EFBF91ED25750D8D7DC30B88E8A");

  return 1;
}

_id_13142(var_0) {
  switch (var_0) {
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

  foreach(var_3 in level.chopper_sound_fade_and_delete) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_3)) {
      if(var_1.size >= 7 && var_3.last_saydefuse_time) {
        var_3 delete();
        continue;
      }

      var_1[var_1.size] = var_3;
    }
  }

  level.chopper_sound_fade_and_delete = var_1;
}

registeronrespawn(var_0) {
  return "_encstr_97060D4CB7638EFA8C5966C2EAD8A3";
}

registerontimerexpired(var_0) {
  return;
}

regroup_points(var_0) {
  var_1 = 0;
  var_1 = getweaponvariantindex(var_0);

  if(isDefined(var_1)) {
    switch (var_1) {
      case 1:
        return "_encstr_B6A831DDACB0E07BE6AFDDB5D79B1C591BD20B36D71D7298C2633696CD3A5A1BB6E64B3359FAE04EF64D2B1BD15A8D2B7DD919";
      default:
        break;
    }
  }

  return "_encstr_A22E2EEE2B2C077BCDFABBADFAB938ACC64BC236F51D72892CD88D96DC8ED2D8D6B996CC95FA8339DE35958D8EB463AC";
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

  if(use_trace_radius(var_2))
    return 1;

  if(use_struct(var_2))
    return 1;

  switch (var_0) {
    case "_encstr_9AA90ADAAC4716B1FA36C29C":
    case "_encstr_8BFB0B288908C790C7684F3622":
    case "_encstr_8F1C11C5152B278527D0DA4230B7BD9BC38D42":
    case "_encstr_AFFC0BE585F819E139F33B0485":
    case "_encstr_8C480C0A71E567FD11199069CF48":
    case "_encstr_83550CDA95A3168DEB76C9851DCA":
    case "_encstr_A5450BC280BF4B604068C33187":
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

  if(isPlayer(var_1)) {
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
  if(isDefined(self) && istrue(self.tut_bots_forcelaststand_onspawn))
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

  if(!isDefined(self.model) || self.model == "_encstr_A2B40B8E2C3B7DDB274B9D4B37") {
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