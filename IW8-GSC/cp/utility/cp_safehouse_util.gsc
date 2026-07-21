/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\utility\cp_safehouse_util.gsc
***********************************************/

tr_vis_facing_dist_add_override(var_0) {}

_id_1403E(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_B1C80D5D9E631E21A65378089A7FD5");
  var_1 = register_outer_room_spawners(var_0);

  if(var_1 == "_encstr_8A6A0D5B583BF516C2361C862C9864") {
    return;
  }
  var_2 = register_player_character(var_1);
  thread start_chopper_boss(var_0, var_1, var_2);
}

handlerelicmartyrdomgas() {
  self waittill("_encstr_B1C80D5D9E631E21A65378089A7FD5");
  wait 6;
  self notify("_encstr_975C1D7AF94301754F97E930C1C0D0B9320AD8DD2A8BD968E11F2B8A20488E");
}

start_chopper_boss(var_0, var_1, var_2) {
  self notify("_encstr_975C1D7AF94301754F97E930C1C0D0B9320AD8DD2A8BD968E11F2B8A20488E");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_975C1D7AF94301754F97E930C1C0D0B9320AD8DD2A8BD968E11F2B8A20488E");
  childthread handlerelicmartyrdomgas();

  if(var_1 == "_encstr_8B1608EC43B8D647A113") {
    return;
  }
  for(;;) {
    self waittill("_encstr_8C81147B587894AAE9A8974C26CF731F6030ABFF9013", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_0 != var_7) {
      continue;
    }
    setup_tut_zones(var_3, var_4, var_10, var_5, var_6, var_7, var_8, var_9, var_2, var_1);
  }
}

setup_tut_zones(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = _id_1331F(var_4, var_9, var_0, var_1, var_3, var_6);

  if(var_10)
    var_7 = _id_12AC9(var_3, var_6, var_7, 0);

  var_11 = _id_1368B(var_7, var_6, var_9, var_5, var_10, var_3);

  if(_id_132F1(var_0)) {
    var_11 delete();
    return;
  } else if(_id_13309(var_0, var_10))
    linktoent(var_11, var_0, var_1);

  if(isDefined(var_8))
    [[var_8]](var_11, var_2, var_7, var_3);
}

start_bomb_vest_defusal(var_0, var_1, var_2, var_3) {
  thread _id_128CC(var_0, var_1, var_2, var_3);
}

start_bomb_vest_global_timer(var_0, var_1, var_2, var_3) {}

_id_128CC(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_0 scripts\engine\utility::_id_143BF(0.0, "_encstr_860808CB78E2984063BA");
  playFX(level._effect["_encstr_A64E0FFB592DB01BAF375BFE5AE3CF8805"], var_2, var_3);
  var_4 = getcompleteweaponname("_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B");
  var_5 = getcompleteweaponname("_encstr_AD6E1AB959D6A356F0BE85B063E01AB013C8F5CDC163B0B90DBEAD83");
  var_4._id_121D9 = var_0.weapon;
  var_5._id_121D9 = var_0.weapon;
  var_4._id_136FA = var_5;
  glassradiusdamage(var_0.origin, 130, 50, 1);

  if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity)) {
    var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
    var_0.stuckenemyentity dodamage(1, var_0.origin, self, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_4, var_1);
    var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
  }

  getplaylistname(var_0.origin, 11, 25, 12, 25, 35, 14, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_5);
  wait 0.4;

  if(!var_0 _id_140D4()) {
    return;
  }
  var_0 delete();
}

_id_1368B(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = magicgrenademanual("_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B", var_0, (0, 0, 0), 0.0);
  var_6.angles = vectortoangles(var_5);
  var_6.unset_relic_hideobjicons = 1;
  var_6.owner = self;
  var_6.brush = var_2;
  var_6.weapon = var_3;
  var_6.turn_on_light_when_elevator_close_by = 1;
  return var_6;
}

register_outer_room_spawners(var_0) {
  var_1 = "_encstr_B40101";

  if(var_0 hasattachment("_encstr_99E91506C9ED1A03B334A15FAF78598A02E1B3C0181637"))
    return "_encstr_AB440A3180D0C0109B17550B";

  return "_encstr_8B1608EC43B8D647A113";
}

register_player_character(var_0) {
  switch (var_0) {
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

  return 0;
}

_id_12AC9(var_0, var_1, var_2, var_3) {
  return var_2 + var_0 * 25;
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
  if(isDefined(self) && istrue(self.turn_on_light_when_elevator_close_by))
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

  if(!istrue(self.unset_relic_hideobjicons)) {
    self solid();
    self physicslaunchserver(self.origin, var_0);
  }
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