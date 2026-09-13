/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_c130.gsc
***********************************************/

init() {
  scripts\mp\flags::gameflaginit("br_ready_to_jump", 0);
  setdvarifuninitialized("dvar_4AE50ABB410517AB", 2.0);
}

spawnc130pathstruct(_id_53453E9C96325450, _id_E5BD279D3767139F) {
  _id_40240AE50B8189B1 = makepathparamsstruct(_id_53453E9C96325450, _id_E5BD279D3767139F);
  pathstruct = makepathstruct(_id_40240AE50B8189B1);
  return pathstruct;
}

makepathparamsstruct(_id_53453E9C96325450, _id_E5BD279D3767139F) {
  _id_CA0329944922AB3F = 160;
  _id_C9E0379448FC8251 = 200;

  if(isDefined(_id_53453E9C96325450))
    centerpt = _id_53453E9C96325450;
  else
    centerpt = (0, 0, 0);

  if(level.mapname == "mp_torez") {
    _id_CA0329944922AB3F = 165;
    _id_C9E0379448FC8251 = 195;
    centerpt = (3000, -2000, 0);
  }

  _id_F94F9769A1F2D802 = 6.28318;
  randomangle = randomfloatrange(0, 360);
  endangleoffset = randomfloatrange(_id_CA0329944922AB3F, _id_C9E0379448FC8251);

  if(isDefined(_id_E5BD279D3767139F))
    r = _id_E5BD279D3767139F;
  else
    r = level.br_level.br_circleradii[0];

  _id_CD37CE775909957B = spawnStruct();
  _id_CD37CE775909957B.r = r;
  _id_CD37CE775909957B.randomangle = randomangle;
  _id_CD37CE775909957B.endangleoffset = endangleoffset;
  _id_CD37CE775909957B.centerpt = centerpt;
  return _id_CD37CE775909957B;
}

makepathstruct(_id_40240AE50B8189B1) {
  r = _id_40240AE50B8189B1.r;
  randomangle = _id_40240AE50B8189B1.randomangle;
  endangleoffset = _id_40240AE50B8189B1.endangleoffset;
  centerpt = _id_40240AE50B8189B1.centerpt;
  _id_02E499CD16746F2D = (randomangle + endangleoffset) % 360;
  startpt = (r * cos(randomangle), r * sin(randomangle), scripts\cp_mp\parachute::getc130height()) + centerpt;
  endpt = (r * cos(_id_02E499CD16746F2D), r * sin(_id_02E499CD16746F2D), scripts\cp_mp\parachute::getc130height()) + centerpt;
  pathdir = vectorNormalize(endpt - startpt);
  endpt = endpt + pathdir * r;
  startpt = startpt - pathdir * r * 2;
  pathstruct = spawnStruct();
  pathstruct.startpt = startpt;
  pathstruct.endpt = endpt;
  pathstruct.angle = vectortoangles(pathdir);
  return pathstruct;
}

snappointtomapbounds2d(point) {
  _id_DC8625458EE5ED14 = level.br_level.br_mapbounds;

  if(point[0] < _id_DC8625458EE5ED14[1][0])
    point = (_id_DC8625458EE5ED14[1][0], point[1], point[2]);
  else if(point[0] > _id_DC8625458EE5ED14[0][0])
    point = (_id_DC8625458EE5ED14[0][0], point[1], point[2]);

  if(point[1] < _id_DC8625458EE5ED14[1][1])
    point = (point[0], _id_DC8625458EE5ED14[1][1], point[2]);
  else if(point[1] > _id_DC8625458EE5ED14[0][1])
    point = (point[0], _id_DC8625458EE5ED14[0][1], point[2]);

  return point;
}

ray_trace_trigger_radius_2d(start, end, _id_5C7118560E119AEB) {
  points = [];

  foreach(_id_D73D5D86BF007C1A in _id_5C7118560E119AEB) {
    point = scripts\engine\math::_id_CC2AD02DCF5030D8(start, end, _id_D73D5D86BF007C1A.origin, _id_D73D5D86BF007C1A.radius);
    points[points.size] = point;
  }

  _id_D73F53A8E479F9FC = undefined;
  _id_7B076D31304FE0A4 = 0;

  foreach(point in points) {
    distsq = distance2dsquared(start, point);

    if(!isDefined(_id_D73F53A8E479F9FC) || distsq < _id_7B076D31304FE0A4) {
      _id_D73F53A8E479F9FC = point;
      _id_7B076D31304FE0A4 = distsq;
    }
  }

  return _id_D73F53A8E479F9FC;
}

snappointtooutofboundstriggertrace(startpoint, _id_C1E273BA6CEF8058) {
  if(!isDefined(level.outofboundstriggers) || level.outofboundstriggers.size == 0)
    return snappointtomapbounds2d(_id_C1E273BA6CEF8058);

  if(!isDefined(level.outofboundstriggersplanetrace))
    level.outofboundstriggersplanetrace = level.outofboundstriggers;

  contents = physics_createcontents(["physicscontents_trigger"]);
  trace = scripts\engine\trace::ray_trace_ents(startpoint, _id_C1E273BA6CEF8058, level.outofboundstriggersplanetrace, contents);

  if(trace["fraction"] < 1.0)
    _id_C1E273BA6CEF8058 = trace["position"];

  if(isDefined(level.outofboundstriggersspawned) && level.outofboundstriggersspawned.size > 0 && getdvarint("dvar_B6F6771F7D380C01", 0) == 0) {
    _id_B735EC48CD0B4308 = ray_trace_trigger_radius_2d(startpoint, _id_C1E273BA6CEF8058, level.outofboundstriggersspawned);

    if(isDefined(_id_B735EC48CD0B4308)) {
      _id_3E6D55080731EC2A = distance2dsquared(startpoint, _id_C1E273BA6CEF8058);
      _id_E1B832ABA05BC49A = distance2dsquared(startpoint, _id_B735EC48CD0B4308);

      if(_id_E1B832ABA05BC49A < _id_3E6D55080731EC2A)
        _id_C1E273BA6CEF8058 = (_id_B735EC48CD0B4308[0], _id_B735EC48CD0B4308[1], _id_C1E273BA6CEF8058[2]);
    }
  }

  return _id_C1E273BA6CEF8058;
}

getplanepathsaferadiusfromcenter(_id_E5BD279D3767139F) {
  _id_18404860CD4BEDBA = getdvarfloat("dvar_95884EB90393FA6D", 0.7);
  _id_4BC476776E118554 = (level.br_level.br_mapsize[0] / 2 + level.br_level.br_mapsize[1] / 2) / 2;

  if(isDefined(_id_E5BD279D3767139F))
    _id_4BC476776E118554 = _id_E5BD279D3767139F;
  else if(isDefined(level._id_ADDF1FC5251608BC))
    _id_4BC476776E118554 = level._id_ADDF1FC5251608BC;

  _id_F434D604C09196AA = _id_18404860CD4BEDBA * _id_4BC476776E118554;
  return _id_F434D604C09196AA;
}

_id_01F389456D7C530A() {
  offset = (0, 0, 0);

  if(getdvarint("dvar_B394D0E649406CC1", 1) == 0)
    return offset;

  if(isDefined(level.br_level._id_96BC2CCD011BA845))
    offset = level.br_level._id_96BC2CCD011BA845;

  offset = getdvarvector("dvar_AB9AFCC6DB47793E", offset);
  return offset;
}

iswithinplanepathsaferadius(_id_CDCD3178F5176585) {
  centerpt = level.br_level.br_mapcenter;
  centerpt = centerpt + _id_01F389456D7C530A();
  _id_F434D604C09196AA = getplanepathsaferadiusfromcenter();
  dist = distance2d(centerpt, _id_CDCD3178F5176585);
  return dist < _id_F434D604C09196AA;
}

spawnc130pathstructnew(_id_1AC3DEC2A5426BD4, _id_E5BD279D3767139F, _id_B2D2EEC29DBABA05, _id_B024F80FC9886FC4, _id_92FCC390C4C0ACD7) {
  centerpt = level.br_level.br_mapcenter;

  if(isDefined(_id_1AC3DEC2A5426BD4))
    centerpt = _id_1AC3DEC2A5426BD4;
  else
    centerpt = centerpt + _id_01F389456D7C530A();

  _id_F434D604C09196AA = getplanepathsaferadiusfromcenter(_id_E5BD279D3767139F);
  _id_6768A915ED3C9351 = randomfloat(360);

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF()) {
    if(isDefined(level.infilplaneyaw))
      _id_6768A915ED3C9351 = level.infilplaneyaw;
    else
      _id_6768A915ED3C9351 = 75;
  }

  _id_F36436FA7801BB1C = anglesToForward((0, _id_6768A915ED3C9351, 0));
  _id_F36436FA7801BB1C = _id_F36436FA7801BB1C * (_id_F434D604C09196AA * randomfloatrange(-1, 1));
  _id_F36436FA7801BB1C = _id_F36436FA7801BB1C + (0, 0, getc130knownsafeheight());

  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("randomizeCircleCenter"))
    centerpt = centerpt + _id_F36436FA7801BB1C;

  if(!_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF() && !_id_2CEDCC356F1B9FC8::isdmzbotpracticematch())
    centerpt = getdvarvector("dvar_3956F0CA6C9C5F89", centerpt);

  _id_D8235976EA87D0D2 = (0, randomfloatrange(0, 360), 0);

  if(_id_362C58E8BB39BCDA::isfeaturedisabled("randomizeCircleCenter")) {
    if(isDefined(_id_92FCC390C4C0ACD7)) {
      _id_F36436FA7801BB1C = anglesToForward((0, _id_6768A915ED3C9351, 0)) * _id_92FCC390C4C0ACD7;
      _id_F36436FA7801BB1C = _id_F36436FA7801BB1C + (0, 0, getc130knownsafeheight());
    }

    _id_969E949840554584 = level.br_level.br_mapcenter + _id_F36436FA7801BB1C;

    if(isDefined(_id_B024F80FC9886FC4))
      _id_969E949840554584 = _id_B024F80FC9886FC4 + _id_F36436FA7801BB1C;

    _id_7A05F5CEED8AB610 = centerpt - _id_969E949840554584;

    if(scripts\engine\utility::cointoss() && getdvarint("dvar_4A9026A0D0F3719A", 0) == 0)
      _id_7A05F5CEED8AB610 = _id_7A05F5CEED8AB610 * -1.0;

    _id_8EFB15CFB90A7534 = vectortoyaw(_id_7A05F5CEED8AB610);
    _id_D8235976EA87D0D2 = (0, _id_8EFB15CFB90A7534, 0);
  }

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())
    _id_D8235976EA87D0D2 = (0, 75, 0);
  else
    _id_D8235976EA87D0D2 = (0, getdvarfloat("dvar_7343D5620B46BBC3", _id_D8235976EA87D0D2[1]), 0);

  circleradius = level.br_level.br_circleradii[0];

  if(isDefined(_id_E5BD279D3767139F))
    circleradius = _id_E5BD279D3767139F;

  _id_5619B7BBC3745888 = circleradius * 2;

  if(_id_362C58E8BB39BCDA::isfeatureenabled("planeUseCircleRadius"))
    _id_5619B7BBC3745888 = circleradius;

  _id_FDFE2D4AAF8EC33D = scripts\cp_mp\parachute::getc130height();
  pathstruct = spawnc130pathstructnewinternal(centerpt, _id_D8235976EA87D0D2, _id_FDFE2D4AAF8EC33D, _id_5619B7BBC3745888, _id_B2D2EEC29DBABA05);
  return pathstruct;
}

spawnc130pathstructnewinternal(centerpt, angles, _id_6300D0F047679B46, _id_5619B7BBC3745888, _id_B2D2EEC29DBABA05) {
  pathdir = anglesToForward(angles);

  if(!isDefined(_id_5619B7BBC3745888)) {
    _id_5619B7BBC3745888 = level.br_level.br_circleradii[0] * 2;

    if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())
      _id_5619B7BBC3745888 = level.br_level.br_circleradii[2] * 2;
  }

  startpt = centerpt - pathdir * _id_5619B7BBC3745888;
  endpt = centerpt + pathdir * _id_5619B7BBC3745888;

  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("planeSnapToOOB")) {
    startpt = snappointtooutofboundstriggertrace(centerpt, startpt);
    endpt = snappointtooutofboundstriggertrace(centerpt, endpt);
  }

  startptui = startpt;
  endptui = endpt;

  if(_id_362C58E8BB39BCDA::isfeaturedisabled("planeSnapToOOB")) {
    if(!ispointinbounds(startpt))
      startptui = snappointtooutofboundstriggertrace(centerpt, startpt);

    if(!ispointinbounds(endpt))
      endptui = snappointtooutofboundstriggertrace(centerpt, endpt);
  }

  pathdir = vectorNormalize(endpt - startpt);
  _id_88BE2123B5A143A0 = getdvarfloat("dvar_A7872D3E53452E4E", 10);

  if(scripts\mp\utility\game::getsubgametype() == "mini" || scripts\mp\utility\game::getsubgametype() == "mini_mgl")
    _id_88BE2123B5A143A0 = getdvarfloat("dvar_599BE2CFEFF57084", 2);

  if(isDefined(_id_B2D2EEC29DBABA05))
    _id_88BE2123B5A143A0 = _id_88BE2123B5A143A0 + _id_B2D2EEC29DBABA05;

  startpt = startpt - pathdir * getc130speed() * _id_88BE2123B5A143A0;
  endpt = endpt + pathdir * 100000;

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())
    startpt = startpt - pathdir * getc130speed() * 20;

  pathstruct = spawnStruct();
  pathstruct.startpt = (startpt[0], startpt[1], _id_6300D0F047679B46);
  pathstruct.endpt = (endpt[0], endpt[1], _id_6300D0F047679B46);
  pathstruct.startptui = startptui;
  pathstruct.endptui = endptui;
  pathstruct.angle = angles;
  pathstruct.pathdir = pathdir;
  pathstruct.centerpt = centerpt;
  return pathstruct;
}

getc130speed() {
  if(isDefined(level.br_level) && isDefined(level.br_level.c130_speedoverride))
    return level.br_level.c130_speedoverride;

  return 3044;
}

getc130knownsafeheight() {
  return 8000;
}

setc130heightoverrides(_id_45ACCFF1681E0276, _id_0924F9394B6FEB3E) {
  if(isDefined(_id_45ACCFF1681E0276))
    level.br_level.c130_heightoverride = _id_45ACCFF1681E0276;

  if(isDefined(_id_0924F9394B6FEB3E))
    level.br_level.c130_sealeveloverride = _id_0924F9394B6FEB3E;

  setomnvar("ui_br_altimeter_c130_height", scripts\cp_mp\parachute::getc130height());
  setomnvar("ui_br_altimeter_sea_height", scripts\cp_mp\parachute::getc130sealevel());
}

updatec130pathomnvars(_id_BCEAE96AF86616DD) {
  if(!isDefined(_id_BCEAE96AF86616DD)) {
    return;
  }
  if(!isDefined(_id_BCEAE96AF86616DD.startpt) || !isDefined(_id_BCEAE96AF86616DD.endpt) || !isDefined(_id_BCEAE96AF86616DD.angle)) {
    return;
  }
  if(scripts\mp\utility\game::getsubgametype() == "resurgence_mgl") {
    centerpt = (_id_BCEAE96AF86616DD.startptui + _id_BCEAE96AF86616DD.endptui) * 0.5;
    _id_76D1BABBC7524A83 = vectorNormalize(_id_BCEAE96AF86616DD.startptui - centerpt);
    startptui = centerpt + _id_76D1BABBC7524A83 * level.br_level.br_circleradii[0] * 2;
    endptui = centerpt - _id_76D1BABBC7524A83 * level.br_level.br_circleradii[0] * 2;
    setomnvar("ui_br_c130_path_start_x", int(startptui[0]));
    setomnvar("ui_br_c130_path_start_y", int(startptui[1]));
    setomnvar("ui_br_c130_path_end_x", int(endptui[0]));
    setomnvar("ui_br_c130_path_end_y", int(endptui[1]));
  } else {
    setomnvar("ui_br_c130_path_start_x", int(_id_BCEAE96AF86616DD.startptui[0]));
    setomnvar("ui_br_c130_path_start_y", int(_id_BCEAE96AF86616DD.startptui[1]));
    setomnvar("ui_br_c130_path_end_x", int(_id_BCEAE96AF86616DD.endptui[0]));
    setomnvar("ui_br_c130_path_end_y", int(_id_BCEAE96AF86616DD.endptui[1]));
  }
}

createtestc130path(_id_1AC3DEC2A5426BD4, _id_E5BD279D3767139F, _id_B2D2EEC29DBABA05, _id_B024F80FC9886FC4, _id_92FCC390C4C0ACD7) {
  self notify("debug130Line");

  if(isDefined(level.br_level.br_mapcenter) && isDefined(level.br_level.br_mapsize)) {
    pathstruct = spawnc130pathstructnew(_id_1AC3DEC2A5426BD4, _id_E5BD279D3767139F, _id_B2D2EEC29DBABA05, _id_B024F80FC9886FC4, _id_92FCC390C4C0ACD7);
    level thread _id_715028F54BAD19A1::branalytics_planepath(pathstruct.centerpt, pathstruct.angle[1], pathstruct.startptui, pathstruct.endptui);
  } else
    pathstruct = spawnc130pathstruct(_id_1AC3DEC2A5426BD4, _id_E5BD279D3767139F);

  updatec130pathomnvars(pathstruct);
  return pathstruct;
}

spawnc130(planemodel, _id_954A35001716E7CB, _id_8281F83C750DACE6, pathstruct, _id_58BB50874E340160, soundalias) {
  dist = distance(pathstruct.startpt, pathstruct.endpt);
  time = dist / getc130speed();
  _id_8F56F6C6C54E17D9 = 1;
  level.br_ac130 = gunship_spawn(planemodel, _id_954A35001716E7CB, _id_8281F83C750DACE6, pathstruct.startpt, pathstruct.endpt, time, _id_8F56F6C6C54E17D9, _id_58BB50874E340160, soundalias);
  level.br_ac130.pathstruct = pathstruct;
  return time;
}

spawnplayertoc130() {
  if(isDefined(level.infil_vignette_anim_type) && level.infil_vignette_anim_type == "script_model")
    self unlink();

  _id_0930A1E7BD882C1D::endprematchskydiving();
  thread playerputinc130(level.br_ac130);
  self.brneverlanded = 1;
  self._id_91A2B1303B861667 = 1;

  if(istrue(self.isbrsquadleader) && !istrue(level.brgametype._id_BE0C10911FEC189F))
    level _id_2CEDCC356F1B9FC8::brleaderdialogplayer("deploy_squad_leader", self, 1, 0);
}

playerputinc130(c130) {
  self.angles = c130.angles;
  self allowcrouch(0);
  self allowprone(0);
  self allowfire(0);
  thread listenjump(c130, 0);
  thread listenkick(c130, 0);
  self.br_infil_type = "c130";

  if(!getdvarint("dvar_187E8C5233803AC8", 0))
    thread orbitcam(c130);

  if(!scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    self setclientomnvar("ui_hide_nameplate_strings", 1);

  thread _id_1E4A61DB11011446::_id_467380E90C7DB5A7();
}

orbitcam(gunship) {
  self endon("death");

  if(isDefined(level.infil_vignette_anim_type) && level.infil_vignette_anim_type == "script_model") {
    self.angles = gunship.angles;
    self playerlinkTo(gunship, "");
    scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
    scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_c130::orbitCam()");
  }

  scripts\cp_mp\utility\player_utility::_visionsetnaked("", 0);
  self setplayerangles(gunship.angles);
  _id_C7F1D28E52436ECD = undefined;

  if(_id_7933519955F32C4E::_id_B4E9D46918F067BB()) {
    _id_015314DA30B44470 = 1;

    if(isDefined(self.infilanimindex))
      _id_015314DA30B44470 = self.infilanimindex;

    if(_id_015314DA30B44470 >= 5)
      _id_015314DA30B44470 = 1;

    _id_C7F1D28E52436ECD = "cam_orbit_br_ac130_player" + _id_015314DA30B44470;
  } else if(istrue(level._id_291B51C7AF8D1204))
    _id_C7F1D28E52436ECD = "cam_orbit_br_infil_ac130_reveal";
  else
    _id_C7F1D28E52436ECD = _id_0930A1E7BD882C1D::_id_0F18696AC7694ED9();

  self cameraset(_id_C7F1D28E52436ECD);
}

gunship_spawn(planemodel, _id_954A35001716E7CB, _id_8281F83C750DACE6, startpt, endpt, time, _id_8F56F6C6C54E17D9, _id_58BB50874E340160, soundalias) {
  if(!isDefined(planemodel)) {
    planemodel = "veh8_mil_air_acharlie130_magma_animated";
    _id_954A35001716E7CB = "veh8_mil_air_acharlie130_magma_rigid";
  }

  if(!isDefined(_id_8F56F6C6C54E17D9))
    _id_8F56F6C6C54E17D9 = 1;

  gunship = spawn("script_model", startpt);
  gunship setModel(planemodel);
  gunship forcenetfieldhighlod(1);
  gunship setCanDamage(0);
  gunship.maxhealth = 100000;
  gunship.health = gunship.maxhealth;
  gunship.cleanme = 1;
  gunship.startpt = startpt;

  if(isstring(soundalias))
    gunship thread _id_0A51BDC3A764B10B(soundalias);

  gunship.dir = vectorNormalize(endpt - startpt);
  gunship.angles = vectortoangles(gunship.dir);

  if(isDefined(_id_954A35001716E7CB)) {
    if(!isDefined(_id_8281F83C750DACE6))
      _id_8281F83C750DACE6 = "";

    gunship.innards = spawn("script_model", startpt);
    gunship.innards setModel(_id_954A35001716E7CB);
    gunship.innards forcenetfieldhighlod(1);
    gunship.innards.cleanme = 1;
    gunship.innards linkTo(gunship, _id_8281F83C750DACE6, (0, 0, 0), (0, 0, 0));
  }

  gunship.playeroffsets = [(32, 30, -500), (-32, 30, -500), (0, 30, -500), (16, 30, -500), (-16, 30, -500)];
  gunship.currentplayeroffset = 0;

  if(_id_8F56F6C6C54E17D9)
    gunship thread kickwhenoutofbounds("c130");

  if(isDefined(_id_58BB50874E340160))
    gunship thread[[_id_58BB50874E340160]](endpt, time);
  else
    gunship thread gunship_handlemovement(endpt, time);

  return gunship;
}

_id_0A51BDC3A764B10B(soundalias) {
  if(istrue(level._id_291B51C7AF8D1204))
    wait 30;

  self playLoopSound(soundalias);
}

gunship_handlemovement(_id_C7F46EF27D351CD0, movetime) {
  level endon("game_ended");
  self endon("death");

  if(!scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    self hide();

    if(isDefined(self.innards))
      self.innards hide();
  }

  self waittill("start_moving");

  if(!scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    self show();

    if(isDefined(self.innards))
      self.innards show();
  }

  self moveTo(_id_C7F46EF27D351CD0, movetime);
  thread killaftertime(movetime, "c130");
  thread gunship_spawnvfx();
}

gunship_spawnvfx() {
  level endon("game_ended");

  if(getdvarint("dvar_9EC9CFC0ADD0F71C", 0))
    self setscriptablepartstate("br_cloud_cover_flack", "on");

  if(!_id_7933519955F32C4E::_id_B4E9D46918F067BB()) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      wait 0.001;
    else
      wait 0.1;

    self setscriptablepartstate("br_fx", "clouds");
  } else {
    _id_A910600EADF5E31C = level._effect["vfx_snatch_ac130_clouds"];

    if(!isDefined(_id_A910600EADF5E31C)) {
      return;
    }
    wait 0.1;
    playFXOnTag(_id_A910600EADF5E31C, self, "tag_body");
  }
}

inmapbounds(_id_CDCD3178F5176585) {
  _id_DC8625458EE5ED14 = level.br_level.br_mapbounds;

  if(isDefined(level.br_level.br_mapboundsfull))
    _id_DC8625458EE5ED14 = level.br_level.br_mapboundsfull;

  if((_id_2CEDCC356F1B9FC8::isdmzbotpracticematch() || _id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF()) && isDefined(level.br_ac130))
    inmapbounds = _id_CDCD3178F5176585[0] < _id_DC8625458EE5ED14[1][0] && _id_CDCD3178F5176585[0] > _id_DC8625458EE5ED14[0][0] && _id_CDCD3178F5176585[1] < _id_DC8625458EE5ED14[1][1] && _id_CDCD3178F5176585[1] > _id_DC8625458EE5ED14[0][1];
  else
    inmapbounds = _id_CDCD3178F5176585[0] < _id_DC8625458EE5ED14[0][0] && _id_CDCD3178F5176585[0] > _id_DC8625458EE5ED14[1][0] && _id_CDCD3178F5176585[1] < _id_DC8625458EE5ED14[0][1] && _id_CDCD3178F5176585[1] > _id_DC8625458EE5ED14[1][1];

  return inmapbounds;
}

ispointinbounds(_id_CDCD3178F5176585, _id_776E4CFC1D04CA70) {
  inmapbounds = inmapbounds(_id_CDCD3178F5176585);

  if((_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF() || _id_2CEDCC356F1B9FC8::isdmzbotpracticematch()) && isDefined(level.br_ac130))
    return inmapbounds;

  if(!inmapbounds)
    return 0;

  if(iswithinplanepathsaferadius(_id_CDCD3178F5176585))
    return 1;

  outofbounds = scripts\mp\outofbounds::ispointinoutofbounds(_id_CDCD3178F5176585);

  if(outofbounds)
    return 0;

  if(istrue(_id_776E4CFC1D04CA70)) {
    _id_7E5AF16F0F9F7C87 = 16;
    contents = physics_createcontents(["physicscontents_trigger"]);
    results = physics_spherecast(_id_CDCD3178F5176585, _id_CDCD3178F5176585, _id_7E5AF16F0F9F7C87, contents, undefined, "physicsquery_all");

    foreach(result in results) {
      ent = result["entity"];

      if(isDefined(ent) && isDefined(ent.targetname) && ent.targetname == "OutOfBounds")
        return 0;
    }
  }

  return 1;
}

planewaittillcandrop() {
  _id_7A05F5CEED8AB610 = anglesToForward(self.angles);

  for(;;) {
    _id_930DA766A2C8896C = vectorNormalize(self.pathstruct.startptui - self.origin);
    _id_481D5AAF688443A3 = vectordot(_id_7A05F5CEED8AB610, _id_930DA766A2C8896C) < 0;

    if(_id_481D5AAF688443A3) {
      break;
    }

    waitframe();
  }
}

kickwhenoutofbounds(_id_1CFA28A2CDB812A7) {
  level endon("game_ended");
  self endon("death");

  if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    setomnvarforallclients("ui_hide_minimap", 1);

  waitframe();
  planewaittillcandrop();
  _id_505B3A065E348BAB = getc130knownsafeheight();

  while(!ispointinbounds((self.origin[0], self.origin[1], _id_505B3A065E348BAB)))
    waitframe();

  _id_032D93B13C134184 = getdvarint("dvar_3ADE460504FF5346", 1);

  if(_id_032D93B13C134184) {
    for(;;) {
      _id_0FC52CB238F5B3BF = 1;
      _id_CF3800024083ABBE = _id_58F20490049AF6AC::_id_BF15A5AA7E72AEE9();

      foreach(circleradius in _id_CF3800024083ABBE) {
        if(circleradius <= 0)
          _id_0FC52CB238F5B3BF = 0;
      }

      if(!_id_0FC52CB238F5B3BF || _id_58F20490049AF6AC::_id_778A4C3D053ED0A9(self.origin)) {
        break;
      }

      waitframe();
    }
  }

  level.br_latejoininfilready = 1;
  level.c130inbounds = 1;
  level notify("br_c130_in_bounds");

  if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    setomnvarforallclients("ui_hide_minimap", 0);

  for(;;) {
    _id_7A05F5CEED8AB610 = anglesToForward(self.angles);
    _id_E93890B0C58EC649 = vectorNormalize(self.pathstruct.centerpt - self.origin);
    _id_5077DA74D847FB7F = vectordot(_id_7A05F5CEED8AB610, _id_E93890B0C58EC649) < 0;

    if(_id_5077DA74D847FB7F) {
      break;
    }

    waitframe();
  }

  _id_35A6A9C45130EC10 = getdvarint("dvar_E82B8618853A182C", 3500);

  for(;;) {
    _id_7A05F5CEED8AB610 = anglesToForward(self.angles);
    _id_54CBC103ADD3C81C = self.origin + _id_7A05F5CEED8AB610 * _id_35A6A9C45130EC10;
    _id_54CBC103ADD3C81C = (_id_54CBC103ADD3C81C[0], _id_54CBC103ADD3C81C[1], _id_505B3A065E348BAB);

    if(!ispointinbounds(_id_54CBC103ADD3C81C)) {
      level.br_c130spawndone = 1;

      foreach(player in level.players) {
        if(isDefined(player) && isDefined(player.br_infil_type) && player.br_infil_type == _id_1CFA28A2CDB812A7 && !isDefined(player.jumptype)) {
          player.jumptype = "outOfBounds";
          player notify("halo_kick_c130");
        }
      }

      break;
    }

    if(_id_032D93B13C134184) {
      _id_0FC52CB238F5B3BF = 1;
      _id_CF3800024083ABBE = _id_58F20490049AF6AC::_id_BF15A5AA7E72AEE9();

      foreach(circleradius in _id_CF3800024083ABBE) {
        if(circleradius <= 0)
          _id_0FC52CB238F5B3BF = 0;
      }

      if(_id_0FC52CB238F5B3BF && !_id_58F20490049AF6AC::_id_778A4C3D053ED0A9(_id_54CBC103ADD3C81C)) {
        level.br_c130spawndone = 1;

        foreach(player in level.players) {
          if(isDefined(player) && isDefined(player.br_infil_type) && player.br_infil_type == _id_1CFA28A2CDB812A7 && !isDefined(player.jumptype)) {
            player.jumptype = "outOfBounds";
            player notify("halo_kick_c130");
          }
        }

        break;
      }
    }

    waitframe();
  }

  level.c130inbounds = undefined;
  level notify("br_c130_left_bounds");
  level.infilstruct.playersinc130 = 0;
  setomnvar("ui_br_players_left_in_plane", level.infilstruct.playersinc130);
}

killaftertime(time, _id_1CFA28A2CDB812A7) {
  level endon("game_ended");
  self endon("death");
  wait(time);

  if(isDefined(self.players)) {
    foreach(player in self.players) {
      if(isDefined(player) && isDefined(player.br_infil_type) && player.br_infil_type == _id_1CFA28A2CDB812A7 && !isDefined(player.jumptype)) {
        player.jumptype = "outOfBounds";
        player notify("halo_kick_c130");
      }
    }
  } else {
    foreach(player in level.players) {
      if(isDefined(player) && isDefined(player.br_infil_type) && player.br_infil_type == _id_1CFA28A2CDB812A7 && !isDefined(player.jumptype)) {
        player.jumptype = "outOfBounds";
        player notify("halo_kick_c130");
      }
    }
  }

  self stoploopsound();

  if(isDefined(self.animstruct._id_AB8494260B910B51))
    self[[self.animstruct._id_AB8494260B910B51]]();

  wait 0.1;

  if(isDefined(self.animstruct)) {
    _id_B76A71DFBB3CF37D = 1;

    while(_id_B76A71DFBB3CF37D) {
      _id_B76A71DFBB3CF37D = 0;

      foreach(player in level.players) {
        if(isDefined(player.br_infil_type)) {
          _id_B76A71DFBB3CF37D = 1;
          break;
        }
      }

      if(_id_B76A71DFBB3CF37D)
        wait 0.5;
    }

    if(isDefined(self.animstruct.cleanupfunc)) {
      self.animstruct thread[[self.animstruct.cleanupfunc]]();
      return;
    }

    level thread _id_2CEDCC356F1B9FC8::cleanac130struct(self.animstruct);
    return;
  } else {
    if(isDefined(self.innards))
      self.innards delete();

    self delete();
  }
}

calctrailpoint() {
  droppoint = self.origin - anglesToForward(self.angles) * 150;
  return droppoint;
}

listenkick(c130, _id_0A3F91A4A7069575) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_c130");
  self endon("br_jump");
  self waittill("halo_kick_c130", _id_FA569D7033A73D94);

  if(!isDefined(_id_FA569D7033A73D94))
    _id_FA569D7033A73D94 = (0, c130.angles[1] + 180, 0);

  self.brkickedfromplane = 1;
  thread leaveplane(c130, _id_0A3F91A4A7069575, _id_FA569D7033A73D94, 0);
}

listenjump(c130, _id_1B89121EF11344D5) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_c130");
  self endon("br_jump");
  _id_F9805AAD354A150E = undefined;
  self.redeployenabled = 0;
  _id_AD4F519DC0DFD573 = getdvarint("dvar_5C93DCD7535822E6", 0);
  c130 planewaittillcandrop();

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_4("halo_jump_c130", "halo_jump_solo_c130", "halo_jump_parachute_c130", "halo_jump_parachute_solo_c130");

    if(!isDefined(result))
      result = "halo_jump_c130";

    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(self.team, "players");

    if(!_id_AD4F519DC0DFD573) {
      _id_F9805AAD354A150E = c130 calctrailpoint();

      if(ispointinbounds(_id_F9805AAD354A150E)) {
        self.jumptype = "solo";
        self notify("halo_kick_c130");
        scripts\engine\utility::thread_on_notify("infil_jump_done", _id_2CEDCC356F1B9FC8::updatebrscoreboardstat, "jumpMasterState", 0);
        break;
      } else
        self iprintlnbold(&"MP_BR_INGAME/NOT_PLAYABLE");

      continue;
    }

    _id_D6EE3E704C6731D4 = _id_2CEDCC356F1B9FC8::isplayerbrsquadleader() || isDefined(self._id_3F78C6A0862F9E25) && self._id_3F78C6A0862F9E25 == 0;

    if(!_id_D6EE3E704C6731D4 && _id_6D5ED003AF1F9612.size > 1) {
      if(result == "halo_jump_solo_c130") {
        _id_F9805AAD354A150E = c130 calctrailpoint();

        if(ispointinbounds(_id_F9805AAD354A150E)) {
          self.jumptype = "solo";
          self notify("halo_kick_c130");
          scripts\engine\utility::thread_on_notify("infil_jump_done", _id_2CEDCC356F1B9FC8::updatebrscoreboardstat, "jumpMasterState", 0);
          break;
        } else
          self iprintlnbold(&"MP_BR_INGAME/NOT_PLAYABLE");
      }

      continue;
    }

    _id_F9805AAD354A150E = c130 calctrailpoint();

    if(ispointinbounds(_id_F9805AAD354A150E)) {
      if(_id_D6EE3E704C6731D4) {
        self.jumptype = "leader";
        _id_674C1FEC5874253C = isDefined(level.squaddata);

        if(_id_674C1FEC5874253C) {
          squad = level.squaddata[self.team][self._id_0FF97225579DE16A];
          _id_6D5ED003AF1F9612 = squad.players;
        }

        foreach(player in _id_6D5ED003AF1F9612) {
          if(player != self && isDefined(player.br_infil_type) && !isDefined(player.jumptype)) {
            player.jumptype = "follower";
            player notify("halo_kick_c130", self getplayerangles());
          }

          player playlocalsound("tmp_br_infil_ac130_jumpmaster_go");
        }

        if(result != "halo_jump_solo_c130" && getdvarint("dvar_D649575E14A3DC9F", 0))
          thread holdteammatestosquadleader(_id_6D5ED003AF1F9612);
        else {
          foreach(player in _id_6D5ED003AF1F9612) {
            if(isDefined(player.br_infil_type))
              setteammateomnvarsforplayer(player, _id_6D5ED003AF1F9612, 0);
          }
        }
      }

      break;
    } else
      self iprintlnbold(&"MP_BR_INGAME/NOT_PLAYABLE");

    _id_F9805AAD354A150E = c130 calctrailpoint();
    waitframe();
  }

  thread leaveplane(c130, _id_1B89121EF11344D5, self getplayerangles(), 0);
}

leaveplane(c130, _id_0A3F91A4A7069575, _id_FA569D7033A73D94, _id_1BDAFC6465CF7E27) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("cancel_c130");
  setdvarifuninitialized("dvar_8BBEF9DFE5EFA122", 1);
  self notify("br_jump");
  self allowcrouch(1);
  self allowprone(1);
  self allowfire(1);
  self.plotarmor = undefined;
  self.c130 = undefined;
  _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("isInInfilPlane", 0);

  if(isDefined(level.infilstruct) && isDefined(level.infilstruct.playersinc130) && level.infilstruct.playersinc130 > 0)
    level.infilstruct.playersinc130--;

  if(getdvarint("dvar_57377F405B99ECD2", 0) && isDefined(level.infilstruct._id_129D4A6C887FCFA5) && level.infilstruct._id_129D4A6C887FCFA5 > 0)
    level.infilstruct._id_129D4A6C887FCFA5--;

  self notifyonplayercommandremove("halo_jump_c130", "+gostand");
  self notifyonplayercommandremove("halo_jump_solo_c130", "+gostand");

  if(!isbot(self)) {
    self notifyonplayercommandremove("halo_jump_parachute_c130", "+open_parachute");
    self notifyonplayercommandremove("halo_jump_parachute_solo_c130", "+open_parachute");
  }

  self notifyonplayercommandremove("abandon_fireteam_leader", "+frag");
  self notifyonplayercommandremove("br_pass_squad_leader", "+usereload");
  self notifyonplayercommandremove("br_pass_squad_leader", "+activate");
  self waittill("infil_jump_done");
  self cameradefault();
  self.br_infil_type = undefined;
  thread parachute(c130, _id_0A3F91A4A7069575, _id_FA569D7033A73D94, _id_1BDAFC6465CF7E27);

  if(scripts\mp\utility\game::getsubgametype() == "truckwar") {
    _id_799D521F485A1701::getspawnpoint(1);
    self setOrigin(self.redeployspawn.origin, 1);
    self setplayerangles(self.redeployspawn.angles);
  }
}

holdteammatestosquadleader(_id_6D5ED003AF1F9612) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  thread watchforsquadleaddisconnect(_id_6D5ED003AF1F9612);
  _id_D6EE3E704C6731D4 = self;
  wait 0.2;
  _id_FDC11BA76911059E = [(-250, 0, 0), (-150, -150, 0), (-150, 150, 0)];
  num = 0;

  foreach(player in _id_6D5ED003AF1F9612) {
    if(!isDefined(player) || !isalive(player)) {
      continue;
    }
    if(player != _id_D6EE3E704C6731D4) {
      if(isDefined(player.jumptype) && player.jumptype != "solo") {
        player thread pushplayertoplayeroffset(_id_D6EE3E704C6731D4, _id_FDC11BA76911059E[num]);
        num++;
        continue;
      }

      setteammateomnvarsforplayer(player, _id_6D5ED003AF1F9612, 0);
    }
  }

  _id_28E11A76198E4AF9 = 2700;
  _id_6A670E744C3F0289 = 999999999;

  while(!self useButtonPressed() && _id_6A670E744C3F0289 > _id_28E11A76198E4AF9) {
    _id_F9CF6C85797F2B98 = scripts\common\utility::groundpos(_id_D6EE3E704C6731D4.origin);
    _id_6A670E744C3F0289 = _id_D6EE3E704C6731D4.origin[2] - _id_F9CF6C85797F2B98[2];

    if(_id_D6EE3E704C6731D4 isparachuting()) {
      break;
    }

    waitframe();
  }

  foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612) {
    if(!isDefined(_id_F0EA4030349A33D5) || !isalive(_id_F0EA4030349A33D5)) {
      continue;
    }
    if(_id_F0EA4030349A33D5 != self && istrue(_id_F0EA4030349A33D5.beingpushed)) {
      _id_F0EA4030349A33D5 notify("stop_push");
      _id_F0EA4030349A33D5.beingpushed = undefined;
    }

    setteammateomnvarsforplayer(_id_F0EA4030349A33D5, _id_6D5ED003AF1F9612, 0);
  }

  self notify("hold_teammates_complete");
}

watchforsquadleaddisconnect(_id_6D5ED003AF1F9612) {
  level endon("game_ended");
  self endon("hold_teammates_complete");
  scripts\engine\utility::waittill_any_2("death", "disconnect");

  foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612) {
    if(!isDefined(_id_F0EA4030349A33D5)) {
      continue;
    }
    if(_id_F0EA4030349A33D5 != self && istrue(_id_F0EA4030349A33D5.beingpushed)) {
      _id_F0EA4030349A33D5 notify("stop_push");
      _id_F0EA4030349A33D5.beingpushed = undefined;
    }

    setteammateomnvarsforplayer(_id_F0EA4030349A33D5, _id_6D5ED003AF1F9612, 0);
  }
}

setteammateomnvarsforplayer(player, _id_A6AB8D0FDA441DC2, _id_FC8AFB765C52482B) {
  _id_462D88BBD35C625E = scripts\engine\utility::ter_op(player _id_2CEDCC356F1B9FC8::isplayerbrsquadleader(), 2, _id_FC8AFB765C52482B);
  player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("jumpMasterState", _id_462D88BBD35C625E);
}

playerparachutedetachresetomnvars() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stop_push");
  self waittill("skydive_deployparachute");
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(self.team, "players");
  setteammateomnvarsforplayer(self, _id_6D5ED003AF1F9612, 0);
}

pushplayertoplayeroffset(_id_D6EE3E704C6731D4, offset) {
  level endon("game_ended");
  self.beingpushed = 1;
  _id_4BF7D94A7A835E41 = self;
  _id_4BF7D94A7A835E41 endon("death_or_disconnect");
  _id_4BF7D94A7A835E41 endon("stop_push");
  _id_4BF7D94A7A835E41 thread playerparachutedetachresetomnvars();
  _id_1F927F6F31419A4A = length(offset);

  while(!_id_4BF7D94A7A835E41 isonground() && !_id_4BF7D94A7A835E41 useButtonPressed() && isDefined(_id_D6EE3E704C6731D4) && !_id_4BF7D94A7A835E41 isparachuting()) {
    angle = _id_D6EE3E704C6731D4 getplayerangles();
    _id_0331CB3E6B6E2212 = rotatepointaroundvector((0, 0, 1), offset, angle[1]);
    _id_D6562A6304E979BF = _id_D6EE3E704C6731D4.origin + _id_0331CB3E6B6E2212 - _id_4BF7D94A7A835E41.origin;
    dist = length(_id_D6562A6304E979BF);

    if(dist > _id_1F927F6F31419A4A) {
      _id_E9BB054C142820BF = _id_4BF7D94A7A835E41 getvelocity();
      _id_4BF7D94A7A835E41 setvelocity(_id_D6562A6304E979BF + _id_E9BB054C142820BF * 0.9);
    }

    waitframe();
  }

  _id_4BF7D94A7A835E41 notify("stop_push");
  _id_4BF7D94A7A835E41.beingpushed = undefined;
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(_id_4BF7D94A7A835E41.team, "players");
  setteammateomnvarsforplayer(_id_4BF7D94A7A835E41, _id_6D5ED003AF1F9612, 0);
}

parachute(c130, _id_1B89121EF11344D5, _id_E7EDB50A3E562402, _id_1BDAFC6465CF7E27) {
  self setclientomnvar("ui_br_infiled", 1);
  self setclientomnvar("ui_hide_nameplate_strings", 0);
  self unlink();

  if(isDefined(self.br_orbitcam))
    self.br_orbitcam delete();

  thread infilfreefallparachuteaudio(c130);
  waitframe();
  scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76(1);

  if(isDefined(_id_E7EDB50A3E562402))
    self setplayerangles(_id_E7EDB50A3E562402);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    self.br_isplayerbeforeinitialinfildeploy = undefined;
    _id_715028F54BAD19A1::branalytics_deploytriggered(self);
  }

  velocity = (0, 0, 0);

  if(_id_1BDAFC6465CF7E27)
    velocity = anglesToForward(c130.angles) * getc130speed();

  self.ignorefalldamagetime = gettime() + 5000;
  self skydive_setdeploymentstatus(0);
  _id_9AA9310D89BE4B46 = getdvarfloat("dvar_4AE50ABB410517AB", 2.0);
  thread scripts\cp_mp\parachute::startfreefall(_id_9AA9310D89BE4B46, _id_1B89121EF11344D5, undefined, velocity);
}

infilfreefallparachuteaudio(c130) {
  self endon("disconnect");
  player = self;

  if(isDefined(c130)) {
    _id_424FA5020D8A6359 = "veh_br_c17_flyby";

    if(isDefined(c130.model) && issubstr(c130.model, "c130"))
      _id_424FA5020D8A6359 = "br_ac130_flyby";

    c130 playsoundtoplayer(_id_424FA5020D8A6359, player, c130);
  }

  player setsoundsubmix("mp_br_infil_music", 0.0);
  _id_B97178D3FFC0AEE1 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_plane_jump");
  player setplayermusicstate(_id_B97178D3FFC0AEE1);
  player.jump_music = 1;
  wait 1.0;
  player clearclienttriggeraudiozone(3.0);
  wait 5.0;
  player clearsoundsubmix("mp_br_infil_music", 15.0);
}

setplayervarinrespawnc130(value) {
  if(isDefined(self.inrespawnc130) && self.inrespawnc130 == value) {
    return;
  }
  self.inrespawnc130 = value;
  level notify("update_circle_hide");
}

waittoplayinfildialog() {
  level endon("game_ended");
  level.br_ac130 endon("death");
  level.br_ac130 planewaittillcandrop();

  for(;;) {
    _id_F9805AAD354A150E = level.br_ac130 calctrailpoint();

    if(ispointinbounds(_id_F9805AAD354A150E)) {
      foreach(player in level.players) {
        if(isPlayer(player))
          player playlocalsound("evt_br_infil_jump_buzzer");
      }

      wait 1.0;
      scripts\mp\flags::gameflagset("br_ready_to_jump");
      _id_715028F54BAD19A1::branalytics_deployallowed();
      return;
    }

    waitframe();
  }
}