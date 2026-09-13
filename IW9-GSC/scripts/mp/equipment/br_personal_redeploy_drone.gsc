/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\br_personal_redeploy_drone.gsc
***************************************************************/

main() {
  level thread _id_566F849E77540164();
}

_id_566F849E77540164() {
  level endon("game_ended");
  level waittill("init_supers");
  init();
}

init() {
  scripts\mp\supers::_id_53110A12409D01DA("super_personal_redeploy_drone", undefined, undefined, ::_id_1798BE0772912AE0, undefined, undefined);
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("eqp_personal_redeploy_drone");
  _id_618A1163576C3819();
  _id_030AFC24CC88C8D3();
}

_id_030AFC24CC88C8D3() {}

#using_animtree("script_model");

initanims() {
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["vm_misc_pers_redeploy_drone_raise"] = % vm_misc_pers_redeploy_drone_raise;
  level.scr_animname["player"]["vm_misc_pers_redeploy_drone_raise"] = "vm_misc_pers_redeploy_drone_raise";
  level.scr_eventanim["player"]["vm_misc_pers_redeploy_drone_raise"] = "vm_misc_pers_redeploy_drone_raise";
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["vm_misc_pers_redeploy_drone_loop"] = % vm_misc_pers_redeploy_drone_loop;
  level.scr_animname["player"]["vm_misc_pers_redeploy_drone_loop"] = "vm_misc_pers_redeploy_drone_loop";
  level.scr_eventanim["player"]["vm_misc_pers_redeploy_drone_loop"] = "vm_misc_pers_redeploy_drone_loop";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["vm_misc_pers_redeploy_drone_loop"] = % vm_misc_pers_redeploy_drone_loop;
  level.scr_animname["device"]["vm_misc_pers_redeploy_drone_loop"] = "vm_misc_pers_redeploy_drone_loop";
  level.scr_eventanim["device"]["vm_misc_pers_redeploy_drone_loop"] = "vm_misc_pers_redeploy_drone_loop";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["vm_misc_pers_redeploy_drone_raise"] = % vm_misc_pers_redeploy_drone_raise;
  level.scr_animname["device"]["vm_misc_pers_redeploy_drone_raise"] = "vm_misc_pers_redeploy_drone_raise";
  level.scr_eventanim["device"]["vm_misc_pers_redeploy_drone_raise"] = "vm_misc_pers_redeploy_drone_raise";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["iw9_mp_stand_eq_pers_redeploy_drone_raise"] = % iw9_mp_stand_eq_pers_redeploy_drone_raise;
  level.scr_animname["device"]["iw9_mp_stand_eq_pers_redeploy_drone_raise"] = "iw9_mp_stand_eq_pers_redeploy_drone_raise";
  level.scr_eventanim["device"]["iw9_mp_stand_eq_pers_redeploy_drone_raise"] = "iw9_mp_stand_eq_pers_redeploy_drone_raise";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["iw9_mp_eq_pers_redeploy_drone_loop"] = % iw9_mp_eq_pers_redeploy_drone_loop;
  level.scr_animname["device"]["iw9_mp_eq_pers_redeploy_drone_loop"] = "iw9_mp_eq_pers_redeploy_drone_loop";
  level.scr_eventanim["device"]["iw9_mp_eq_pers_redeploy_drone_loop"] = "iw9_mp_eq_pers_redeploy_drone_loop";
}

_id_618A1163576C3819() {
  level._id_354CDD3BE21C3816 = spawnStruct();
  level._id_354CDD3BE21C3816.maxhealth = getdvarint("dvar_01A3F3E5D7D85D66", 200);
  level._id_354CDD3BE21C3816._id_40C1778CD1FFFB56 = getdvarint("dvar_6E8ED4DBA5669324", 1000);
  level._id_354CDD3BE21C3816._id_310B716956EA1EB7 = getdvarint("dvar_5A4CAF1FB986ED3D", 1500);
  level._id_354CDD3BE21C3816._id_3E012BE2DA45D624 = getdvarint("dvar_4C317295490AB630", 144);
  level._id_354CDD3BE21C3816.flighttime = getdvarfloat("dvar_1100BB3B49784382", 2.4);
  level._id_354CDD3BE21C3816._id_6FCC6072244F528D = getdvarfloat("dvar_214076BBC50622B5", 1);
  level._id_354CDD3BE21C3816._id_699E6686AE987B76 = getdvarint("dvar_56251CA801089D58", 450);
  level._id_354CDD3BE21C3816._id_F203791DE5CA7907 = getdvarint("dvar_87956834BA2C9DA5", 3200);
  level._id_354CDD3BE21C3816._id_4F1BEAC755FCBF5E = level._id_354CDD3BE21C3816.flighttime * 0.15;
  level._id_354CDD3BE21C3816._id_2D2810A5544C4810 = getdvarint("dvar_8ACE69B15BC87E78", 350);
  level._id_354CDD3BE21C3816._id_1F0792A543B8D769 = getdvarint("dvar_054D723A99CBBA03", 0);
  level._id_354CDD3BE21C3816._id_8B5B7FC67B8FA38C = getdvarint("dvar_3844467D573B1434", 34);
  level._id_354CDD3BE21C3816._id_D1410201C409097E = getdvarint("dvar_A79BD8D12A31C3EE", 34);
  level._id_354CDD3BE21C3816._id_764CC4217C118949 = getdvarint("dvar_863526B21DDAB568", -100);
  level._id_354CDD3BE21C3816._id_8CB418E34764E4BD = getdvarint("dvar_A98C9BA7E95C38FE", 18);
  level._id_354CDD3BE21C3816._id_89E3359918051E8A = getdvarfloat("dvar_03516A8526CF93EF", 4.0);
  level._id_354CDD3BE21C3816._id_FAFC1A3606900720 = getdvarfloat("dvar_905FB821EDDD2D0C", 1.2);
  level._id_354CDD3BE21C3816._id_902FCFFD5545E0F0 = getdvarfloat("dvar_9451FC5F136786C8", 1);
  level._id_354CDD3BE21C3816._id_91A45D7E07124BB3 = getdvarfloat("dvar_527A6411C9ECE18A", 0.4);
  level._id_354CDD3BE21C3816._id_0EE0EEE91C40741E = getdvarfloat("dvar_60AE35C4BB9C1A1D", 1);
  level._id_354CDD3BE21C3816._id_0CB198B03FCDFE00 = getdvarfloat("dvar_EBF0B0E995B5030C", 40);
  initanims();
  game["strings"]["personal_redeploy_drone_insufficient_space"] = &"SUPER_MP/PERSONAL_REDEPLOY_DRONE_INSUFFICENT_SPACE";
  game["strings"]["personal_redeploy_drone_underwater"] = &"SUPER_MP/PERSONAL_REDEPLOY_DRONE_UNDERWATER";
  game["strings"]["prd_prone"] = &"SUPER_MP/PRD_PRONE";
}

_id_1798BE0772912AE0() {
  if(_id_E339E9564FB310BF())
    return 0;

  self.super_activated = 1;
  thread _id_7283CCB271E018BF();
  return 1;
}

_id_7283CCB271E018BF() {
  if(self _meth_E40102956C887F7C()) {
    self._id_11C539594EBC0FBD = 1;
    self allowmovement(0);
  }

  _id_3B64EB40368C1450::set("prd", "killstreaks", 0);
  _id_3B64EB40368C1450::set("prd", "vehicle_use", 0);
  self allowjump(0);
  self allowfire(0);
  vehicle_allowplayeruse(self, 0);
  self._id_F9779E44BD572312 = self.operatorcustomization.suit;
  _id_E2F2BD414CF8E911 = makeweapon("personal_redeploy_drone_mp_br");
  _id_90FAF31A7D15329B(1, "hud_icon_minimap_fieldupgrade_personal_redeploy_ally");
  _id_90FAF31A7D15329B(0, "hud_icon_minimap_fieldupgrade_personal_redeploy_enemy");

  if(self _meth_C1092F42B6BBE490())
    scripts\mp\utility\player::_setsuit("iw9_defaultsuit_prd3p_mp");
  else
    scripts\mp\utility\player::_setsuit("iw9_defaultsuit_prd_mp");

  waitframe();
  self setstance("stand", 1);
  waitframe();
  _id_709CE170CEC1840B(self, 0);
  thread _id_29E6B46AB07B2EFF();
  firetime = weaponfiretime("personal_redeploy_drone_mp_br");
  usetime = firetime + level._id_354CDD3BE21C3816.flighttime;
  setusetime(usetime);
  _id_360C2C32E76C9434 = self _meth_A9643E918BDB8032(1);
  _id_360C2C32E76C9434 = _id_360C2C32E76C9434 * 0.001;
  wait(_id_360C2C32E76C9434);
  scripts\cp_mp\utility\weapon_utility::_id_F19F8B4CF085ECBD(_id_E2F2BD414CF8E911);
  self allowfire(1);
  scripts\cp_mp\challenges::_id_D997435895422ECC("super_personal_redeploy_drone", 0);
  self disableweaponswitch();
  self skydive_setbasejumpingstatus(0);
  _id_EB5B1F36E255152D = _id_72DF25DA8F8AB5AD();
  drone = _id_2D7DABA228B34E42();
  drone thread _id_DC2E55A1917188AA(self);
  waitframe();

  if(!isDefined(drone) || istrue(drone._id_049C555D38EE7878)) {
    return;
  }
  self allowjump(1);
  thread _id_6646A5B323817F55(drone);
}

_id_E339E9564FB310BF() {
  if(self _meth_6F55D55CCFF20D14()) {
    thread _id_E78D15128F9493EC("personal_redeploy_drone_underwater", 1);
    return 1;
  }

  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  ignorelist = [self];
  _id_4E9E1BCC056CCBD9 = self.origin + (0, 0, 63.42);
  _id_C31B2624E1237260 = _id_4E9E1BCC056CCBD9 + (0, 0, level._id_354CDD3BE21C3816._id_40C1778CD1FFFB56);
  _id_C4EDA0A2A1B3E725 = 24;
  _id_188ECAFF115CACB7 = (0, 0, 0);
  halfheight = level._id_354CDD3BE21C3816._id_40C1778CD1FFFB56 * 0.5 - _id_C4EDA0A2A1B3E725;
  _id_165EA43D0B2661C9 = self.origin + (0, 0, 31.71) + (0, 0, halfheight);
  _id_952FBF822B675B16 = _id_4E9E1BCC056CCBD9 + anglesToForward(self getplayerangles(1)) * level._id_354CDD3BE21C3816._id_3E012BE2DA45D624;
  _id_1E3B0DB0DAF92A3D = _id_4E9E1BCC056CCBD9;
  _id_FB76C86E59B95264 = physics_capsulecast(_id_165EA43D0B2661C9, _id_C31B2624E1237260, _id_C4EDA0A2A1B3E725, halfheight, _id_188ECAFF115CACB7, contents, ignorelist, "physicsquery_closest");
  _id_64C87B996A465E4A = physics_raycast(_id_1E3B0DB0DAF92A3D, _id_952FBF822B675B16, contents, ignorelist, 0, "physicsquery_closest", 1);

  if(isDefined(_id_FB76C86E59B95264) && _id_FB76C86E59B95264.size > 0 || isDefined(_id_64C87B996A465E4A) && _id_64C87B996A465E4A.size > 0 || self _meth_793F941D7DFF15ED() || isDefined(self.vehiclereserved)) {
    thread _id_E78D15128F9493EC("personal_redeploy_drone_insufficient_space", 1);
    return 1;
  }

  if(self getstance() == "prone") {
    thread _id_E78D15128F9493EC("prd_prone", 1);
    return 1;
  }

  return 0;
}

_id_E78D15128F9493EC(string, _id_E03A2BDF54126F45) {
  if(istrue(_id_E03A2BDF54126F45))
    self playlocalsound("eqp_personal_redeploy_drone_error");

  scripts\mp\utility\lower_message::setlowermessageomnvar(string);
  wait 3;
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
}

_id_72DF25DA8F8AB5AD(drone) {
  self endon("death_or_disconnect");

  if(self _meth_C1092F42B6BBE490())
    _id_1E44EAB5A1BD4890(self, 0);

  self attach("misc_vm_pers_redeploy_drone", "tag_accessory_left", 0);
  _id_EB5B1F36E255152D = self _meth_CD40FC03FD195D3C();
  _id_EB5B1F36E255152D = _id_EB5B1F36E255152D * 0.001;
  notes = getnotetracktimes(%vm_misc_pers_redeploy_drone_raise, "reactor_open");

  if(notes.size > 0)
    _id_EB5B1F36E255152D = _id_EB5B1F36E255152D * notes[0];

  return _id_EB5B1F36E255152D;
}

_id_B3116874A755BACB(time) {
  wait(time);
  self allowfire(1);
}

_id_2D7DABA228B34E42() {
  spawnorigin = self gettagorigin("tag_accessory");
  drone = spawn("script_model", spawnorigin);
  drone hide();
  drone setModel("misc_vm_pers_redeploy_drone");
  drone.angles = self.angles;
  drone.maxhealth = level._id_354CDD3BE21C3816.maxhealth;
  drone.health = drone.maxhealth;
  drone setCanDamage(1);
  drone.player = self;
  drone._id_194E2F8F97E90CEA = 0;
  drone._id_C26C9E266FEDAD0D = 1;
  drone thread _id_4975171080DAFF49();
  drone linktoblendtotag(self, "tag_accessory");
  drone thread _id_0060F4517C89229B(self);
  return drone;
}

_id_4975171080DAFF49() {
  self endon("entitydeleted");

  while(isDefined(self) && self._id_C26C9E266FEDAD0D == 1) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    _id_84536C668D8BAFE3(inflictor, damage, meansofdeath, objweapon);
    waitframe();
  }
}

_id_84536C668D8BAFE3(einflictor, damage, smeansofdeath, objweapon) {
  self.health = self.health + damage;

  if(objweapon.basename == "prd_grenade_mp") {
    return;
  }
  if(damage < 2) {
    return;
  }
  if(isPlayer(einflictor) && einflictor.team != self.player.team)
    einflictor _id_5762AC2F22202BA2::updatehitmarker("standard", self.health == 0, 0, 1, "hitequip");

  if(!isDefined(einflictor) || einflictor.team != self.player.team)
    self.health = self.health - damage;

  if(self.health <= 0) {
    self._id_194E2F8F97E90CEA = 1;
    self._id_C26C9E266FEDAD0D = 0;
    waitframe();
    self notify("personalRedeployDrone_Stop");
  }
}

_id_6646A5B323817F55(drone) {
  level endon("game_ended");
  drone endon("entitydeleted");
  drone endon("personalRedeployDrone_Stop");
  player = self;
  heightoffset = 1;
  _id_51B2DAD073CD285C = spawn("script_model", player.origin + (0, 0, heightoffset));
  _id_51B2DAD073CD285C.angles = player.angles;
  _id_51B2DAD073CD285C setModel("tag_origin");
  self._id_51B2DAD073CD285C = _id_51B2DAD073CD285C;
  self._id_076C6EE0982DDCDC = 1;

  if(istrue(self._id_11C539594EBC0FBD)) {
    self._id_11C539594EBC0FBD = undefined;
    self allowmovement(1);
  }

  waitframe();
  _id_E4B9FA2E443D43BB(drone, _id_51B2DAD073CD285C);
}

_id_E4B9FA2E443D43BB(drone, _id_51B2DAD073CD285C) {
  player = self;
  _id_8DFC0A6A9058E951 = 0.1;
  _id_93402506DD3A82B4 = level._id_354CDD3BE21C3816.flighttime;
  self._id_8C1E2E3B4D920E07 = (0, 0, 0);
  drone._id_BA260FF565E3A14A = 0;
  drone thread _id_B94EB4A66FCEAE77(level._id_354CDD3BE21C3816._id_0EE0EEE91C40741E);
  _id_CBAB679A9B560E14 = (player getvelocity()[0], player getvelocity()[1], 0) * level._id_354CDD3BE21C3816._id_FAFC1A3606900720 * level._id_354CDD3BE21C3816.flighttime;
  _id_56C58548157D7301 = _id_289028D1D029BEEA(player);
  _id_00D905245AA59554 = _id_56C58548157D7301 * 0.8;
  _id_694FDB0983E994E7 = _id_51B2DAD073CD285C.origin + (0, 0, _id_00D905245AA59554 - level._id_354CDD3BE21C3816._id_764CC4217C118949) + _id_CBAB679A9B560E14;
  _id_42CDDCA04F38D502 = _id_694FDB0983E994E7[2];
  _id_5F290AA19A780D5F = _id_51B2DAD073CD285C.origin[2];
  _id_3B6BDE41CED8616D = abs(_id_42CDDCA04F38D502 - _id_5F290AA19A780D5F);
  player setOrigin(_id_51B2DAD073CD285C.origin, 0);
  player playerlinkTo(_id_51B2DAD073CD285C, "tag_origin", 0, 180, 180, 180, 180, 1);
  waitframe();
  _id_902FCFFD5545E0F0 = 0;
  thread _id_4D20CCB0D953C558(drone);
  previousplayerorigin = player getorigin();

  for(player._id_FC13717A229E58BB = 0; _id_93402506DD3A82B4 >= 0.1; _id_93402506DD3A82B4 = _id_93402506DD3A82B4 - _id_8DFC0A6A9058E951) {
    _id_B7DF3D56C6B6EFE1 = scripts\engine\math::lerp(_id_3B6BDE41CED8616D * level._id_354CDD3BE21C3816._id_91A45D7E07124BB3, _id_3B6BDE41CED8616D, _id_902FCFFD5545E0F0 / level._id_354CDD3BE21C3816._id_902FCFFD5545E0F0);
    _id_B7DF3D56C6B6EFE1 = _id_B7DF3D56C6B6EFE1 + _id_5F290AA19A780D5F;
    _id_C4DDF28B6EC378E9 = player getorigin();
    _id_454DEE9176B538F7 = (_id_B7DF3D56C6B6EFE1 - _id_C4DDF28B6EC378E9[2]) / _id_93402506DD3A82B4;
    _id_561579A6BCEA8E90 = _id_454DEE9176B538F7 * _id_8DFC0A6A9058E951;

    if(_id_C4DDF28B6EC378E9[2] - previousplayerorigin[2] < _id_561579A6BCEA8E90 * 0.5) {
      player._id_FC13717A229E58BB = player._id_FC13717A229E58BB + 1;

      if(player._id_FC13717A229E58BB > 10) {
        self._id_076C6EE0982DDCDC = 0;
        drone notify("personalRedeployDrone_Stop");
        return;
      }
    } else {
      previousplayerorigin = _id_C4DDF28B6EC378E9;
      player._id_FC13717A229E58BB = max(player._id_FC13717A229E58BB - 1, 0);
    }

    if(_id_902FCFFD5545E0F0 <= level._id_354CDD3BE21C3816._id_902FCFFD5545E0F0) {
      _id_694FDB0983E994E7 = (_id_694FDB0983E994E7[0], _id_694FDB0983E994E7[1], _id_B7DF3D56C6B6EFE1);
      _id_902FCFFD5545E0F0 = _id_902FCFFD5545E0F0 + _id_8DFC0A6A9058E951;
    } else
      _id_694FDB0983E994E7 = (_id_694FDB0983E994E7[0], _id_694FDB0983E994E7[1], _id_42CDDCA04F38D502);

    _id_694FDB0983E994E7 = _id_51B2DAD073CD285C _id_D2F06D117F39B7A5(_id_694FDB0983E994E7, _id_93402506DD3A82B4, player);

    if(_id_51B2DAD073CD285C.origin != _id_694FDB0983E994E7 && _id_93402506DD3A82B4 > 0.1)
      self._id_8C1E2E3B4D920E07 = _func_767CEA82B001F645(_id_694FDB0983E994E7 - _id_51B2DAD073CD285C.origin);

    if(player jumpbuttonPressed() && istrue(drone._id_BA260FF565E3A14A)) {
      drone notify("personalRedeployDrone_Stop");
      self._id_076C6EE0982DDCDC = 0;
      return;
    }

    wait(_id_8DFC0A6A9058E951);
  }

  drone notify("personalRedeployDrone_Stop");
}

_id_B94EB4A66FCEAE77(time) {
  wait(time);

  if(isDefined(self)) {
    self._id_BA260FF565E3A14A = 1;
    self makeusable();
    self setHintString(&"EQUIPMENT_HINTS/PERSONAL_REDEPLOY_DRONE_CANCEL");
    self setCursorHint("HINT_NOICON");
    self setuseholdduration("duration_none");
    self sethintrequiresholding(0);
    self setusecommand("+gostand");
  }
}

_id_D2F06D117F39B7A5(_id_694FDB0983E994E7, _id_93402506DD3A82B4, player) {
  _id_00D001664A80B14C = player _meth_7CB78BCF830D7D4E();
  _id_54399830AAC64FE2 = player _meth_7CB78CCF830D7F81();
  _id_BD7918FF5B0DDBA1 = 0.01;

  if(squared(_id_00D001664A80B14C) >= _id_BD7918FF5B0DDBA1) {
    _id_D1410201C409097E = anglestoright(player getplayerangles(1)) * level._id_354CDD3BE21C3816._id_D1410201C409097E * _id_00D001664A80B14C;
    _id_694FDB0983E994E7 = _id_694FDB0983E994E7 + _id_D1410201C409097E;
  }

  if(squared(_id_54399830AAC64FE2) >= _id_BD7918FF5B0DDBA1) {
    _id_8B5B7FC67B8FA38C = anglesToForward(player getplayerangles(1)) * level._id_354CDD3BE21C3816._id_8B5B7FC67B8FA38C * _id_54399830AAC64FE2;
    _id_694FDB0983E994E7 = _id_694FDB0983E994E7 + _id_8B5B7FC67B8FA38C;
  }

  if(isDefined(player._id_DC7923458ED7D429)) {
    player._id_DC7923458ED7D429 = player._id_DC7923458ED7D429 * level._id_354CDD3BE21C3816._id_0CB198B03FCDFE00;
    _id_694FDB0983E994E7 = (self.origin[0], self.origin[1], 0) + (player._id_DC7923458ED7D429[0], player._id_DC7923458ED7D429[1], _id_694FDB0983E994E7[2]);
    player._id_DC7923458ED7D429 = undefined;
  }

  _id_93402506DD3A82B4 = max(_id_93402506DD3A82B4, 0.01);
  self moveTo(_id_694FDB0983E994E7, _id_93402506DD3A82B4);
  return _id_694FDB0983E994E7;
}

_id_3DD876C5EC4242E4(drone) {
  level endon("game_ended");
  player = self;
  _id_194E2F8F97E90CEA = 0;

  if(isDefined(drone)) {
    _id_194E2F8F97E90CEA = drone._id_194E2F8F97E90CEA;
    drone unlink();
    drone delete();
  }

  if(!isDefined(player)) {
    return;
  }
  _id_19163E14365D9264 = player scripts\mp\supers::getcurrentsuper();

  if(isDefined(_id_19163E14365D9264) && isDefined(_id_19163E14365D9264.staticdata))
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(player, _id_19163E14365D9264.staticdata.id, undefined, istrue(_id_194E2F8F97E90CEA));

  player scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
  _id_1E44EAB5A1BD4890(player, 1);
  _id_709CE170CEC1840B(player, 1);
  player stopgestureviewmodel("iw9_ges_pers_redeploy_drone");
  player unlink(0);
  player thread _id_19A9F4ECC201F1A9(_id_194E2F8F97E90CEA);
  _id_EB5B1F36E255152D = player _meth_63E76E2A5A785B7D();
  _id_EB5B1F36E255152D = _id_EB5B1F36E255152D * 0.001;
  thread _id_9F5E1DE6C65AB230(player, _id_EB5B1F36E255152D);
  player _id_AA3BAEE5BF078D29();
  _id_837B637CD1457B5E = (0, 0, 0);

  if(isDefined(self._id_8C1E2E3B4D920E07) && lengthsquared(self._id_8C1E2E3B4D920E07) != 0)
    _id_837B637CD1457B5E = self._id_8C1E2E3B4D920E07 * level._id_354CDD3BE21C3816._id_2D2810A5544C4810;

  _id_699E6686AE987B76 = (0, 0, level._id_354CDD3BE21C3816._id_699E6686AE987B76);
  _id_C41ACD87E710E2F9 = _id_837B637CD1457B5E + _id_699E6686AE987B76;

  if(istrue(self._id_076C6EE0982DDCDC) && !istrue(player.inlaststand) && player.health > 0)
    player setvelocity(_id_C41ACD87E710E2F9);

  if(isDefined(self._id_51B2DAD073CD285C))
    self._id_51B2DAD073CD285C delete();

  waitframe();

  if(level._id_354CDD3BE21C3816._id_1F0792A543B8D769 == 1)
    player skydive_deployparachute();

  player enableweaponswitch();
  player skydive_setbasejumpingstatus(1);
  vehicle_allowplayeruse(player, 1);
  player _id_3B64EB40368C1450::set("prd", "killstreaks", 1);
  player _id_3B64EB40368C1450::set("prd", "vehicle_use", 1);
}

_id_3829486573C64CEF(_id_75B6BBE9A2CAFB35, waittime) {
  level endon("game_ended");
  wait(waittime);
  waitframe();
  self _meth_A9643E918BDB8032(_id_75B6BBE9A2CAFB35);
}

_id_4D20CCB0D953C558(drone) {
  level endon("game_ended");
  drone endon("entitydeleted");
  player = self;
  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  ignorelist = [drone, player];

  while(player islinked() && isDefined(drone)) {
    if(isDefined(player._id_DC7923458ED7D429)) {
      waitframe();
      continue;
    }

    tag = "tag_accessory";
    radius = 22;
    tagorigin = player gettagorigin(tag);
    start = tagorigin;
    end = tagorigin + (0, 0, radius);
    angles = player gettagangles(tag);
    glassradiusdamage(tagorigin, 100, 10000, 9000);
    results = _func_36B1099B31D85A6B(start, end, drone, angles, contents, ignorelist, "physicsquery_closest");

    if(isDefined(results) && results.size > 0) {
      player._id_DC7923458ED7D429 = results[0]["contact_normal"];
      waitframe();
    }

    waitframe();
  }
}

_id_1E44EAB5A1BD4890(player, _id_EBFEFF456C258BC2) {
  if(isDefined(player)) {
    player allowjump(_id_EBFEFF456C258BC2);
    player allowads(_id_EBFEFF456C258BC2);
    player allowsprint(_id_EBFEFF456C258BC2);
    player allowmelee(_id_EBFEFF456C258BC2);
  }
}

_id_709CE170CEC1840B(player, _id_EBFEFF456C258BC2) {
  if(isDefined(player)) {
    player allowcrouch(_id_EBFEFF456C258BC2);
    player allowprone(_id_EBFEFF456C258BC2);
  }
}

_id_0060F4517C89229B(player) {
  self endon("entitydeleted");
  self endon("personalRedeployDrone_Stop");
  _id_460FC63BDA42C091 = (0, 0, 0);
  flag = 0;

  while(!flag && isDefined(player)) {
    prevorigin = player.origin;
    wait 0.05;
    _id_460FC63BDA42C091 = (player.origin - prevorigin) * 20;

    if(istrue(player.inlaststand) || isDefined(player.health) && player.health <= 0)
      flag = 1;
  }

  wait 0.05;

  if(isDefined(player)) {
    if(istrue(player._id_11C539594EBC0FBD)) {
      player._id_11C539594EBC0FBD = undefined;
      player allowmovement(1);
    }

    if(!scripts\cp_mp\utility\player_utility::isreallyalive(player)) {
      if(isDefined(player._id_A2558B8E82DCE579))
        scripts\mp\objidpoolmanager::returnobjectiveid(player._id_A2558B8E82DCE579);

      if(isDefined(player._id_7FBA38A831F62D1D))
        scripts\mp\objidpoolmanager::returnobjectiveid(player._id_7FBA38A831F62D1D);
    }

    player allowjump(1);
    player setvelocity(_id_460FC63BDA42C091);
    _id_9F5E1DE6C65AB230(player, 0);
    player _id_AA3BAEE5BF078D29();
  }

  self notify("personalRedeployDrone_Stop");
}

_id_289028D1D029BEEA(player) {
  _id_72A26CA7A21E14BD = level._id_354CDD3BE21C3816._id_F203791DE5CA7907 - level._id_354CDD3BE21C3816._id_310B716956EA1EB7;

  if(player.origin[2] > _id_72A26CA7A21E14BD) {
    _id_22AC6DEF15391AEC = player.origin[2] + level._id_354CDD3BE21C3816._id_310B716956EA1EB7 - level._id_354CDD3BE21C3816._id_F203791DE5CA7907;
    _id_22AC6DEF15391AEC = _id_22AC6DEF15391AEC * 0.5;
    flyheight = level._id_354CDD3BE21C3816._id_310B716956EA1EB7 - _id_22AC6DEF15391AEC;
    flyheight = max(flyheight, level._id_354CDD3BE21C3816._id_310B716956EA1EB7);
  } else
    flyheight = level._id_354CDD3BE21C3816._id_310B716956EA1EB7;

  return flyheight;
}

_id_DC2E55A1917188AA(player) {
  thread _id_A97E8B060F3DE437(player);
}

_id_A97E8B060F3DE437(player) {
  self waittill("personalRedeployDrone_Stop");
  self._id_049C555D38EE7878 = 1;
  player thread _id_3DD876C5EC4242E4(self);
}

_id_9F5E1DE6C65AB230(player, waittime) {
  wait(waittime);

  if(isDefined(player) && isPlayer(player)) {
    player scripts\mp\utility\player::_setsuit(player._id_F9779E44BD572312);
    player _meth_A9643E918BDB8032(0);
  }
}

setusetime(usetime) {
  if(isDefined(self.super) && isDefined(self.super.staticdata))
    self.super.staticdata.usetime = usetime;
}

_id_EBF1C3BAEC50725A() {
  _id_34740F706BEEDB21 = self gettagorigin("j_wrist_le");
  _id_9AC22470B732D013 = spawn("script_model", _id_34740F706BEEDB21);
  _id_9AC22470B732D013 linkTo(self, "j_wrist_le");
  self._id_9AC22470B732D013 = _id_9AC22470B732D013;
  return _id_9AC22470B732D013;
}

_id_29E6B46AB07B2EFF() {
  soundent = _id_EBF1C3BAEC50725A();
  waitframe();
  soundent playsoundonmovingent("eqp_personal_redeploy_drone_activate");
}

_id_E4420426A0D7ADF4(grenade) {
  if(isDefined(self._id_9AC22470B732D013) && isDefined(grenade)) {
    self._id_9AC22470B732D013 linkTo(grenade);
    _id_9AC22470B732D013 = self._id_9AC22470B732D013;
    self._id_9AC22470B732D013 = undefined;
    _id_9AC22470B732D013 playsoundonmovingent("eqp_personal_redeploy_drone_crashing");
    grenade waittill("explode");
    _id_B8E3D75435404865(_id_9AC22470B732D013);
  }
}

_id_19A9F4ECC201F1A9(instantexplode) {
  _id_FC733AF49422927C = makeweapon("prd_grenade_mp");
  self _meth_9FA79F15382EC4A6(_id_FC733AF49422927C);
  self waittill("grenade_thrown", grenade);
  grenade thread _id_785EFF769617C70B(self);
  thread _id_E4420426A0D7ADF4(grenade);

  if(istrue(instantexplode)) {
    wait 0.2;

    if(isDefined(grenade))
      grenade detonate();
  }

  thread _id_98B959294D2558CB(1, grenade);
  thread _id_98B959294D2558CB(0, grenade);
}

_id_98B959294D2558CB(ally, grenade) {
  _id_E1D9B7500AC96007 = undefined;

  if(istrue(ally) && isDefined(self._id_A2558B8E82DCE579))
    _id_E1D9B7500AC96007 = self._id_A2558B8E82DCE579;
  else if(isDefined(self._id_7FBA38A831F62D1D))
    _id_E1D9B7500AC96007 = self._id_7FBA38A831F62D1D;

  if(isDefined(_id_E1D9B7500AC96007)) {
    if(isDefined(grenade)) {
      objective_onentity(_id_E1D9B7500AC96007, grenade);
      grenade waittill("explode");
    }

    scripts\mp\objidpoolmanager::returnobjectiveid(_id_E1D9B7500AC96007);
  }
}

_id_90FAF31A7D15329B(ally, icon) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_state(objid, "active");
  objective_onentity(objid, self);
  _func_865F9C5D005F9A08(objid, 1);
  scripts\mp\objidpoolmanager::update_objective_icon(objid, icon);

  if(istrue(ally)) {
    self._id_A2558B8E82DCE579 = objid;
    scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(objid, self);
  } else {
    self._id_7FBA38A831F62D1D = objid;
    scripts\mp\objidpoolmanager::objective_mask_showtoenemyteam(objid, self);
  }

  objective_sethideelevation(objid, 1);
  objective_setshowdistance(objid, 0);
  objective_setshowoncompass(objid, 0);
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
}

_id_AA3BAEE5BF078D29() {
  if(self tagexists("tag_accessory"))
    self detach("misc_vm_pers_redeploy_drone", "tag_accessory_left");
}

_id_B8E3D75435404865(_id_9AC22470B732D013) {
  if(isDefined(_id_9AC22470B732D013)) {
    _id_9AC22470B732D013 stopsounds();
    waitframe();
    _id_9AC22470B732D013 delete();
  }
}

_id_785EFF769617C70B(player) {
  level endon("game_ended");
  self endon("explode");

  if(isDefined(player) && isPlayer(player) && player _meth_C1092F42B6BBE490() && isDefined(self)) {
    self setscriptablepartstate("collision", "none");
    wait 0.1;
    self setscriptablepartstate("collision", "neutral");
  }
}