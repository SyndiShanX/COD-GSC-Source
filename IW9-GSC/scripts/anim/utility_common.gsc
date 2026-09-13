/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\utility_common.gsc
***********************************************/

print3dtime(timer, org, msg, color, alpha, scale) {
  _id_4046BF37E49E7A5C = timer / 0.05;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4046BF37E49E7A5C; _id_AC0E594AC96AA3A8++)
    wait 0.05;
}

print3drise(org, msg, color, alpha, scale) {
  _id_4046BF37E49E7A5C = 100.0;
  up = 0;
  org = org + scripts\engine\utility::randomvector(30);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4046BF37E49E7A5C; _id_AC0E594AC96AA3A8++) {
    up = up + 0.5;
    wait 0.05;
  }
}

crossproduct(_id_9601C225B7890378, _id_9601C525B7890A11) {
  return _id_9601C225B7890378[0] * _id_9601C525B7890A11[1] - _id_9601C225B7890378[1] * _id_9601C525B7890A11[0] > 0;
}

safemod(a, b) {
  result = int(a) % b;
  result = result + b;
  return result % b;
}

quadrantanimweights(yaw) {
  _id_9BFEAB087DF17A86 = cos(yaw);
  _id_89BD2519E3162F8C = sin(yaw);
  result["front"] = 0;
  result["right"] = 0;
  result["back"] = 0;
  result["left"] = 0;

  if(isDefined(self.alwaysrunforward)) {
    result["front"] = 1;
    return result;
  }

  if(_id_9BFEAB087DF17A86 > 0) {
    if(_id_89BD2519E3162F8C > _id_9BFEAB087DF17A86)
      result["left"] = 1;
    else if(_id_89BD2519E3162F8C < -1 * _id_9BFEAB087DF17A86)
      result["right"] = 1;
    else
      result["front"] = 1;
  } else {
    _id_E483709DC6132746 = -1 * _id_9BFEAB087DF17A86;

    if(_id_89BD2519E3162F8C > _id_E483709DC6132746)
      result["left"] = 1;
    else if(_id_89BD2519E3162F8C < _id_9BFEAB087DF17A86)
      result["right"] = 1;
    else
      result["back"] = 1;
  }

  return result;
}

getquadrant(angle) {
  angle = angleclamp(angle);

  if(angle < 45 || angle > 315)
    _id_6A34E2E9651B7071 = "front";
  else if(angle < 135)
    _id_6A34E2E9651B7071 = "left";
  else if(angle < 225)
    _id_6A34E2E9651B7071 = "back";
  else
    _id_6A34E2E9651B7071 = "right";

  return _id_6A34E2E9651B7071;
}

isinset(input, set) {
  for(_id_AC0E594AC96AA3A8 = set.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    if(input == set[_id_AC0E594AC96AA3A8])
      return 1;
  }

  return 0;
}

weapon_genade_launcher() {
  return !isnullweapon(self.weapon) && weaponclass(self.weapon) == "grenade";
}

weapon_pump_action_shotgun() {
  return !isnullweapon(self.weapon) && weaponisboltaction(self.weapon) && weaponclass(self.weapon) == "spread";
}

isshotgun(weapon) {
  return weaponclass(weapon) == "spread";
}

issniperrifle(weapon) {
  return weaponclass(weapon) == "sniper";
}

isshotgunai() {
  return isshotgun(self.primaryweapon);
}

islongrangeai() {
  return self _meth_E8CA4080D02A0BB4() || usingrocketlauncher();
}

usingpistol() {
  return weaponclass(self.weapon) == "pistol";
}

usingrocketlauncher() {
  return weaponclass(self.weapon) == "rocketlauncher";
}

usingmg() {
  return weaponclass(self.weapon) == "mg";
}

isusingshotgun() {
  return weaponclass(self.weapon) == "spread";
}

usingriflelikeweapon() {
  class = weaponclass(self.weapon);

  switch (class) {
    case "mg":
    case "sniper":
    case "rifle":
    case "smg":
    case "spread":
      return 1;
  }

  return 0;
}

repeater_headshot_ammo_passive(objweapon, attacker, victim) {
  if(!isDefined(objweapon) || !isDefined(attacker) || !isDefined(victim)) {
    return;
  }
  if(!isPlayer(attacker)) {
    return;
  }
  _id_4A67207D6B3A5E32 = objweapon.basename;

  if(!isDefined(_id_4A67207D6B3A5E32) || _id_4A67207D6B3A5E32 != "iw7_repeater") {
    return;
  }
  if(!isDefined(victim.damagelocation)) {
    return;
  }
  if(victim.damagelocation != "head" && victim.damagelocation != "helmet") {
    return;
  }
  _id_A7BE10E54A3A4B99 = weaponclipsize(objweapon);
  _id_D7724E7657D45522 = _id_A7BE10E54A3A4B99 * 1.0;
  _id_3DBC3B058135CBFB = attacker getweaponammoclip(objweapon);
  _id_2AA9CAEF99C9AF77 = min(_id_3DBC3B058135CBFB + _id_D7724E7657D45522, _id_A7BE10E54A3A4B99);
  attacker setweaponammoclip(objweapon, int(_id_2AA9CAEF99C9AF77));
}

needtoreload(_id_2FF260C3C7DE486E) {
  if(isnullweapon(self.weapon))
    return 0;

  if(istrue(self.disablereload)) {
    if(self.bulletsinclip < weaponclipsize(self.weapon) * 0.5)
      self.bulletsinclip = int(weaponclipsize(self.weapon) * 0.5);

    if(self.bulletsinclip <= 0)
      self.bulletsinclip = 0;

    return 0;
  }

  if(self.bulletsinclip <= weaponclipsize(self.weapon) * _id_2FF260C3C7DE486E) {
    if(_id_2FF260C3C7DE486E == 0) {
      if(cheatammoifnecessary())
        return 0;
    }

    return 1;
  }

  return 0;
}

cheatammoifnecessary() {
  if(!isDefined(self.enemy))
    return 0;

  if(self.team != "allies") {
    if(!isPlayer(self.enemy))
      return 0;
  }

  if(isusingsidearm() || usingrocketlauncher())
    return 0;

  if(gettime() - self.ammocheattime < self.ammocheatinterval)
    return 0;

  if(!self cansee(self.enemy) && distancesquared(self.origin, self.enemy.origin) > 65536)
    return 0;

  self.bulletsinclip = int(weaponclipsize(self.weapon) / 2);

  if(self.bulletsinclip > weaponclipsize(self.weapon))
    self.bulletsinclip = weaponclipsize(self.weapon);

  self.ammocheattime = gettime();
  return 1;
}

isusingprimary() {
  return self.weapon == self.primaryweapon && !isnullweapon(self.weapon);
}

isusingsecondary() {
  return self.weapon == self.secondaryweapon && !isnullweapon(self.weapon);
}

isusingsidearm() {
  return self.weapon == self.sidearm && !isnullweapon(self.weapon);
}

getclaimednode() {
  return self.node;
}

shootenemywrapper(_id_9BC9D0EE2A8A46F5) {
  if(!isDefined(_id_9BC9D0EE2A8A46F5))
    _id_9BC9D0EE2A8A46F5 = 1;

  [[anim.shootenemywrapper_func]](_id_9BC9D0EE2A8A46F5);
}

getnodeyawtoorigin(pos) {
  if(isDefined(self.node))
    yaw = self.node.angles[1] - scripts\engine\utility::getyaw(pos);
  else
    yaw = self.angles[1] - scripts\engine\utility::getyaw(pos);

  yaw = angleclamp180(yaw);
  return yaw;
}

getnodeyawtoenemy() {
  pos = undefined;

  if(isDefined(self.enemy))
    pos = self.enemy.origin;
  else {
    if(isDefined(self.node))
      forward = anglesToForward(self.node.angles);
    else
      forward = anglesToForward(self.angles);

    forward = forward * 150;
    pos = self.origin + forward;
  }

  if(isDefined(self.node))
    yaw = self.node.angles[1] - scripts\engine\utility::getyaw(pos);
  else
    yaw = self.angles[1] - scripts\engine\utility::getyaw(pos);

  yaw = angleclamp180(yaw);
  return yaw;
}

getyawtoenemy() {
  pos = undefined;

  if(isDefined(self.enemy))
    pos = self.enemy.origin;
  else {
    forward = anglesToForward(self.angles);
    forward = forward * 150;
    pos = self.origin + forward;
  }

  yaw = self.angles[1] - scripts\engine\utility::getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

getyaw2d(org) {
  angles = vectortoangles((org[0], org[1], 0) - (self.origin[0], self.origin[1], 0));
  return angles[1];
}

absyawtoenemy() {
  yaw = self.angles[1] - scripts\engine\utility::getyaw(self.enemy.origin);
  yaw = angleclamp180(yaw);

  if(yaw < 0)
    yaw = -1 * yaw;

  return yaw;
}

absyawtoenemy2d() {
  yaw = self.angles[1] - getyaw2d(self.enemy.origin);
  yaw = angleclamp180(yaw);

  if(yaw < 0)
    yaw = -1 * yaw;

  return yaw;
}

absyawtoorigin(org) {
  yaw = self.angles[1] - scripts\engine\utility::getyaw(org);
  yaw = angleclamp180(yaw);

  if(yaw < 0)
    yaw = -1 * yaw;

  return yaw;
}

absyawtoangles(angles) {
  yaw = self.angles[1] - angles;
  yaw = angleclamp180(yaw);

  if(yaw < 0)
    yaw = -1 * yaw;

  return yaw;
}

getyawfromorigin(org, start) {
  angles = vectortoangles(org - start);
  return angles[1];
}

getgrenademodel() {
  return getweaponmodel(self.grenadeweapon);
}

getenemyeyepos(enemy) {
  if(!isDefined(enemy))
    enemy = self.enemy;

  if(isDefined(enemy)) {
    self.a.lastenemypos = enemy getshootatpos();
    self.a.lastenemytime = gettime();
    return self.a.lastenemypos;
  } else if(isDefined(self.a.lastenemytime) && isDefined(self.a.lastenemypos) && self.a.lastenemytime + 3000 < gettime())
    return self.a.lastenemypos;
  else {
    targetpos = self getshootatpos();
    targetpos = targetpos + 196 * self.lookforward;
    return targetpos;
  }
}

gettruenodeangles(node) {
  if(!isDefined(node))
    return (0, 0, 0);

  if(!isDefined(node.script_angles))
    return node.angles;

  _id_F4B64B2E64700883 = node.angles;
  _id_5190F3FFC6E0CCDE = angleclamp180(_id_F4B64B2E64700883[0] + node.script_angles[0]);
  _id_5190F4FFC6E0CF11 = _id_F4B64B2E64700883[1];
  _id_5190F1FFC6E0C878 = angleclamp180(_id_F4B64B2E64700883[2] + node.script_angles[2]);
  return (_id_5190F3FFC6E0CCDE, _id_5190F4FFC6E0CF11, _id_5190F1FFC6E0C878);
}

getyawtoorigin(org) {
  if(isDefined(self.type) && scripts\engine\utility::isnode3d(self)) {
    _id_9CFE111EA9DF5B56 = gettruenodeangles(self);
    forward = anglesToForward(_id_9CFE111EA9DF5B56);
    _id_9288E19C8DD51644 = rotatepointaroundvector(forward, org - self.origin, _id_9CFE111EA9DF5B56[2] * -1);
    _id_9288E19C8DD51644 = _id_9288E19C8DD51644 + self.origin;
    yaw = scripts\engine\utility::getyaw(_id_9288E19C8DD51644) - _id_9CFE111EA9DF5B56[1];
    yaw = angleclamp180(yaw);
    return yaw;
  }

  yaw = scripts\engine\utility::getyaw(org) - self.angles[1];
  yaw = angleclamp180(yaw);
  return yaw;
}

canseepointfromexposedatcorner(point, node) {
  yaw = node getyawtoorigin(point);

  if(yaw > 60 || yaw < -60)
    return 0;

  if(scripts\engine\utility::isnodecoverleft(node) && yaw < -14)
    return 0;

  if(scripts\engine\utility::isnodecoverright(node) && yaw > 12)
    return 0;

  return 1;
}

getnodeoffset(node) {
  if(isDefined(node.offset))
    return node.offset;

  _id_98A93AA48845F87B = (-26, 0.4, 36);
  _id_6E1F1F062BC22C53 = (-32, 7, 63);
  _id_55540B47802CE192 = (43.5, 11, 36);
  _id_21918BBF1C0E7180 = (36, 8.3, 63);
  _id_72245F24CAD31CD3 = (3.5, -12.5, 45);
  _id_CBA036D32A0CCD0B = (-3.7, -22, 63);
  _id_ED4A2A73F94D1AB5 = (0, 30, 13);
  _id_C9548EE0484F7C10 = 0;
  _id_B3E742AC78B00246 = (0, 0, 0);
  axis = anglestoaxis(node.angles);
  right = axis["right"];
  forward = axis["forward"];
  up = axis["up"];
  nodetype = node.type;

  switch (nodetype) {
    case "Cover Left":
      _id_BD986FF07780228F = node gethighestnodestance();

      if(!isDefined(_id_BD986FF07780228F) || _id_BD986FF07780228F == "crouch")
        _id_B3E742AC78B00246 = calculatenodeoffset(right, forward, up, _id_98A93AA48845F87B);
      else
        _id_B3E742AC78B00246 = calculatenodeoffset(right, forward, up, _id_6E1F1F062BC22C53);

      break;
    case "Cover Right":
      _id_BD986FF07780228F = node gethighestnodestance();

      if(!isDefined(_id_BD986FF07780228F) || _id_BD986FF07780228F == "crouch")
        _id_B3E742AC78B00246 = calculatenodeoffset(right, forward, up, _id_55540B47802CE192);
      else
        _id_B3E742AC78B00246 = calculatenodeoffset(right, forward, up, _id_21918BBF1C0E7180);

      break;
    case "Conceal Stand":
    case "Turret":
    case "Cover Stand 3D":
    case "Cover Stand":
      _id_B3E742AC78B00246 = calculatenodeoffset(right, forward, up, _id_CBA036D32A0CCD0B);
      break;
    case "Conceal Crouch":
    case "Cover Crouch Window":
    case "Cover Crouch":
      _id_B3E742AC78B00246 = calculatenodeoffset(right, forward, up, _id_72245F24CAD31CD3);
      break;
    case "Cover 3D":
      _id_B3E742AC78B00246 = getcover3dnodeoffset(node);
      break;
    case "Cover Prone":
      _id_B3E742AC78B00246 = calculatenodeoffset(right, forward, up, _id_ED4A2A73F94D1AB5);
      break;
  }

  node.offset = _id_B3E742AC78B00246;
  return node.offset;
}

getcover3dnodeoffset(node, _id_55F2A89EA445DD80) {
  _id_D9091E7BEB7128E8 = (2, -10, 35);
  _id_6314194B648994A8 = (-19, -10, 32);
  _id_4CA040109B9F8C1D = (16, -10, 32);
  right = anglestoright(node.angles);
  forward = anglesToForward(node.angles);
  up = anglestoup(node.angles);
  offset = _id_D9091E7BEB7128E8;

  if(isDefined(_id_55F2A89EA445DD80)) {
    if(_id_55F2A89EA445DD80 == "left")
      offset = _id_6314194B648994A8;
    else if(_id_55F2A89EA445DD80 == "right")
      offset = _id_4CA040109B9F8C1D;
    else {}
  }

  return calculatenodeoffset(right, forward, up, offset);
}

calculatenodeoffset(right, forward, up, _id_7D0D6B39D96165C7) {
  return right * _id_7D0D6B39D96165C7[0] + forward * _id_7D0D6B39D96165C7[1] + up * _id_7D0D6B39D96165C7[2];
}

persistentdebugline(start, end) {
  self endon("death");
  level notify("newdebugline");
  level endon("newdebugline");

  for(;;)
    wait 0.05;
}

canseeenemyfromexposed() {
  _id_64F88D0441939203 = gettime();
  node = self.node;
  enemy = self.enemy;
  _id_A53E0A65B825DB1D = !isDefined(self._id_C98E9008B1B17F09) || _id_64F88D0441939203 >= self._id_C98E9008B1B17F09;

  if(_id_A53E0A65B825DB1D || !scripts\engine\utility::is_equal(self._id_C07E2ED36098C414, enemy) || !scripts\engine\utility::is_equal(self._id_1F088108EFC5D0C4, node)) {
    self.canseeenemyfromexposed = _id_E28D706F2D3F4C65(enemy, node);
    self._id_C98E9008B1B17F09 = _id_64F88D0441939203 + 1000;
    self._id_1F088108EFC5D0C4 = node;
    self._id_C07E2ED36098C414 = enemy;
  }

  result = self.canseeenemyfromexposed;

  if(!result) {}

  return result;
}

_id_E28D706F2D3F4C65(enemy, node) {
  if(!isDefined(enemy))
    return 0;

  if(!isDefined(node))
    result = self cansee(enemy);
  else {
    _id_A2825DE7E3791A80 = undefined;

    if(_func_67FF0340E1C92259(enemy))
      _id_A2825DE7E3791A80 = enemy getapproxeyepos();
    else
      _id_A2825DE7E3791A80 = getenemyeyepos(enemy);

    if(scripts\engine\utility::actor_is3d() && scripts\engine\utility::isnode3d(node)) {
      result = _id_A76836CA0F1172AB(enemy, _id_A2825DE7E3791A80, node);

      if(!result) {
        _id_A2825DE7E3791A80 = (enemy.origin + _id_A2825DE7E3791A80) / 2;
        result = _id_A76836CA0F1172AB(enemy, _id_A2825DE7E3791A80, node);
      }
    } else
      result = _id_A76836CA0F1172AB(enemy, _id_A2825DE7E3791A80, node);
  }

  return result;
}

_id_A76836CA0F1172AB(enemy, point, node) {
  if(scripts\engine\utility::isnodecoverleft(node) || scripts\engine\utility::isnodecoverright(node)) {
    if(!canseepointfromexposedatcorner(point, node))
      return 0;
  }

  _id_B3E742AC78B00246 = getnodeoffset(node);
  _id_62C5EE69C494A850 = node.origin + _id_B3E742AC78B00246;

  if(!checkpitchvisibility(_id_62C5EE69C494A850, point, node))
    return 0;

  if(!sighttracepassed(_id_62C5EE69C494A850, point, 0, enemy)) {
    if(scripts\engine\utility::isnodecovercrouch(node)) {
      _id_62C5EE69C494A850 = (0, 0, 64) + node.origin;
      return sighttracepassed(_id_62C5EE69C494A850, point, 0, enemy);
    }

    return 0;
  }

  return 1;
}

checkpitchvisibility(_id_8F78581CD3208C45, _id_EA13048AE45874C6, _id_DE077E6E46369528) {
  _id_DDB680F3984C4777 = self.upaimlimit - anim.aimpitchdifftolerance;
  _id_A5337F8300110201 = self.downaimlimit + anim.aimpitchdifftolerance;
  _id_CAC6B8B7EFDDB0E4 = _id_EA13048AE45874C6 - _id_8F78581CD3208C45;

  if(scripts\engine\utility::actor_is3d()) {
    if(isDefined(_id_DE077E6E46369528) && scripts\engine\utility::isnode3d(_id_DE077E6E46369528))
      angles = _id_DE077E6E46369528.angles;
    else
      angles = self.angles;

    _id_CAC6B8B7EFDDB0E4 = rotatevectorinverted(_id_CAC6B8B7EFDDB0E4, angles);
  }

  pitch = angleclamp180(vectortopitch(_id_CAC6B8B7EFDDB0E4));

  if(pitch < _id_DDB680F3984C4777)
    return 0;

  if(pitch > _id_A5337F8300110201) {
    if(isDefined(_id_DE077E6E46369528) && !scripts\engine\utility::isnodecovercrouch(_id_DE077E6E46369528))
      return 0;

    if(pitch > anim.covercrouchleanpitch + _id_A5337F8300110201)
      return 0;
  }

  return 1;
}

dontgiveuponsuppressionyet() {}

cansuppressenemy() {
  if(!hassuppressableenemy() || self.doingambush) {
    self.goodshootpos = undefined;
    return 0;
  }

  _id_981E36835EEC56C4 = istrue(self._id_51642E27C7E7D224);

  if(!isPlayer(self.enemy)) {
    if(!_id_981E36835EEC56C4 || self.forcesuppressai)
      return aisuppressai();
  }

  if(_id_981E36835EEC56C4)
    return 0;

  if(!checkpitchvisibility(self getEye(), self.lastenemysightpos))
    return 0;

  _id_2AC23F64117A2050 = self getapproxeyepos();
  return findgoodsuppressspot(_id_2AC23F64117A2050);
}

hassuppressableenemy() {
  if(!isDefined(self.enemy))
    return 0;

  if(!isDefined(self.lastenemysightpos))
    return 0;

  if(!self iscurrentenemyvalid())
    return 0;

  if(!isDefined(self.goodshootpos) && !needrecalculatesuppressspot())
    return 0;

  return 1;
}

aisuppressai() {
  if(!self canattackenemynode() && !istrue(self.forcesuppressai))
    return 0;

  shootpos = undefined;

  if(isDefined(self.enemy.covernode)) {
    _id_B3E742AC78B00246 = getnodeoffset(self.enemy.covernode);
    shootpos = self.enemy.covernode.origin + _id_B3E742AC78B00246;
  } else
    shootpos = self.enemy getshootatpos();

  if(!self canshoot(shootpos) && !istrue(self.forcesuppressai))
    return 0;

  self.goodshootpos = shootpos;
  return 1;
}

canseeandshootpoint(point) {
  if(isDefined(self.a.weaponpos) && isundefinedweapon(self.a.weaponpos["right"]))
    return 0;

  if(!sighttracepassed(self getshootatpos(), point, 0, undefined))
    return 0;

  _id_528CDF0816C4001D = self getapproxeyepos();
  return sighttracepassed(_id_528CDF0816C4001D, point, 0, undefined);
}

needrecalculatesuppressspot() {
  if(isDefined(self.goodshootpos) && !canseeandshootpoint(self.goodshootpos))
    return 1;

  return !isDefined(self.lastenemysightposold) || distancesquared(self.lastenemysightposold, self.lastenemysightpos) > 256 || distancesquared(self.lastenemysightposselforigin, self.origin) > 1024;
}

findgoodsuppressspot(_id_2AC23F64117A2050) {
  _id_BC4D272AFC4E79E6 = min(self.enemy.maxvisibledist, 1024);

  if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) > squared(_id_BC4D272AFC4E79E6 + 768.0)) {
    self.goodshootpos = undefined;
    return 0;
  }

  if(needrecalculatesuppressspot()) {
    self.lastenemysightposselforigin = self.origin;
    self.lastenemysightposold = self.lastenemysightpos;

    if(istrue(self.suppress_uselastenemysightpos)) {
      self.goodshootpos = self.lastenemysightpos;
      return 1;
    }

    _id_BDCF463E5B27A0B8 = getenemyeyepos();
    self.goodshootpos = self aicalcsuppressspot(_id_2AC23F64117A2050, _id_BDCF463E5B27A0B8, self.suppress_numgoodtracesneeded);
    return isDefined(self.goodshootpos);
  } else if(isDefined(self.goodshootpos) && isDefined(self.pathgoalpos) && distancesquared(self.origin, self.goodshootpos) < 1024)
    self.goodshootpos = undefined;

  return isDefined(self.goodshootpos);
}

canseeenemy(_id_E6749C0530F0D0F1) {
  if(!isDefined(self.enemy))
    return 0;

  if(isDefined(_id_E6749C0530F0D0F1) && self cansee(self.enemy, _id_E6749C0530F0D0F1) || self cansee(self.enemy)) {
    if(!checkpitchvisibility(self getEye(), self.enemy getshootatpos()))
      return 0;

    return 1;
  }

  return 0;
}

recentlysawenemy() {
  return isDefined(self.enemy) && self seerecently(self.enemy, 5);
}

issuppressedwrapper() {
  if(self.forcesuppression)
    return 1;

  if(self.suppressionmeter <= self.suppressionthreshold)
    return 0;

  return self issuppressed();
}

enemyishiding() {
  if(!isDefined(self.enemy))
    return 0;

  if(self.enemy scripts\engine\utility::isflashed())
    return 1;

  if(isPlayer(self.enemy)) {
    if(isDefined(self.enemy.health) && self.enemy.health < self.enemy.maxhealth)
      return 1;
  } else if(isai(self.enemy) && self.enemy issuppressedwrapper())
    return 1;

  if(isDefined(self.enemy.isreloading) && self.enemy.isreloading)
    return 1;

  return 0;
}

shouldshootenemyent() {
  if(!canseeenemy())
    return 0;

  if(!self canshootenemy())
    return 0;

  return 1;
}

sortandcullanimstructarray(_id_0D4876C861B3D6BE) {
  _id_28656D665CF2B0FA = [];

  foreach(animstruct in _id_0D4876C861B3D6BE) {
    if(animstruct.weight <= 0) {
      continue;
    }
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_28656D665CF2B0FA.size; _id_AC0E594AC96AA3A8++) {
      if(animstruct.weight < _id_28656D665CF2B0FA[_id_AC0E594AC96AA3A8].weight) {
        for(_id_AC0E5C4AC96AAA41 = _id_28656D665CF2B0FA.size; _id_AC0E5C4AC96AAA41 > _id_AC0E594AC96AA3A8; _id_AC0E5C4AC96AAA41--)
          _id_28656D665CF2B0FA[_id_AC0E5C4AC96AAA41] = _id_28656D665CF2B0FA[_id_AC0E5C4AC96AAA41 - 1];

        break;
      }
    }

    _id_28656D665CF2B0FA[_id_AC0E594AC96AA3A8] = animstruct;
  }

  return _id_28656D665CF2B0FA;
}

player_can_see_ai(player, ai, _id_3CB4C8AD9080088D) {
  currenttime = gettime();

  if(!isDefined(_id_3CB4C8AD9080088D))
    _id_3CB4C8AD9080088D = 0;

  if(isDefined(ai.playerseesmetime) && ai.playerseesmetime + _id_3CB4C8AD9080088D >= currenttime)
    return ai.playerseesme;

  ai.playerseesmetime = currenttime;

  if(!scripts\engine\utility::within_fov(player.origin, player.angles, ai.origin, 0.766)) {
    ai.playerseesme = 0;
    return 0;
  }

  _id_D539DD4D949070D9 = player getEye();
  _id_8588CE8CB050BAF3 = ai.origin;

  if(sighttracepassed(_id_D539DD4D949070D9, _id_8588CE8CB050BAF3, 1, player, ai)) {
    ai.playerseesme = 1;
    return 1;
  }

  _id_18718F98529A77D8 = ai getapproxeyepos();

  if(sighttracepassed(_id_D539DD4D949070D9, _id_18718F98529A77D8, 1, player, ai)) {
    ai.playerseesme = 1;
    return 1;
  }

  _id_59A0BA7C30F92D0B = (_id_18718F98529A77D8 + _id_8588CE8CB050BAF3) * 0.5;

  if(sighttracepassed(_id_D539DD4D949070D9, _id_59A0BA7C30F92D0B, 1, player, ai)) {
    ai.playerseesme = 1;
    return 1;
  }

  ai.playerseesme = 0;
  return 0;
}