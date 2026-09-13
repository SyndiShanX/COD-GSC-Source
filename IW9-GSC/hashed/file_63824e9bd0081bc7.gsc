/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_63824e9bd0081bc7.gsc
***********************************************/

_id_F8D4B082424E414F(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(scripts\asm\asm_bb::bb_meleerequested())
    return 1;

  return 0;
}

_id_A2ABABF710B1B017() {
  return 0;
}

_id_8D58E5CCA2ECCC05() {
  if(!scripts\asm\asm_bb::bb_moverequested())
    return 0;

  if(!isDefined(self._id_ECD7A04BA5810935))
    return 0;

  if(self._id_ECD7A04BA5810935 != "run" && self._id_ECD7A04BA5810935 != "sprint")
    return 0;

  if(!isDefined(self._id_003B90191D39897A))
    return 0;

  _id_6A4277FF9E64049F = self._id_003B90191D39897A.origin - self.origin;
  _id_E69C9108F53988F3 = length(_id_6A4277FF9E64049F);

  if(_id_E69C9108F53988F3 >= self._id_C8818686F12F33B6) {
    _id_6A4277FF9E64049F = _id_6A4277FF9E64049F / _id_E69C9108F53988F3;
    _id_225D5BE1546186A5 = _id_0A662F25DBF78119::_id_FD42BE10A26FFF59(self._id_003B90191D39897A);

    if(!self aiphysicstracepassed(self.origin, _id_225D5BE1546186A5.origin, self.radius, self.height, 0))
      return 0;
  }

  return 1;
}

_id_F7CEC1E850AD0CEB() {
  if(_id_6C1867C995FF7F69::_id_A24DFF1AB397A8C7() && _id_6C1867C995FF7F69::_id_70F96AD5BD833DBC())
    return 0;

  if(istrue(self._blackboard._id_1FE1B9B8CD0B87AC))
    return 1;

  return 0;
}

_id_6F2E7B1B6B0CD307() {
  if(isDefined(self.agent_type) && self.agent_type == "zombie_brute")
    return 0;

  if(isDefined(self._id_003B90191D39897A) && self._id_003B90191D39897A.health < 91)
    return 0;

  if(isDefined(level.wave_num) && level.wave_num < 10)
    return 0;

  if(!isDefined(self._id_3F64FAEA7FC140ED))
    return 0;

  _id_6FDF0163E9BC1DB7 = _id_6C1867C995FF7F69::_id_A24DFF1AB397A8C7();
  _id_50BE03284E4758EC = _id_6C1867C995FF7F69::_id_70F96AD5BD833DBC();
  _id_CE97A422FC1540C3 = !(_id_50BE03284E4758EC || _id_6FDF0163E9BC1DB7);
  _id_665017C484231093 = randomint(100) < self._id_3F64FAEA7FC140ED;
  return _id_CE97A422FC1540C3 && _id_665017C484231093;
}

_id_93B45E8AF958A775(asmname, statename, params) {
  _id_6FDF0163E9BC1DB7 = _id_6C1867C995FF7F69::_id_A24DFF1AB397A8C7();
  _id_50BE03284E4758EC = _id_6C1867C995FF7F69::_id_70F96AD5BD833DBC();
  _id_42240D6D5AE03AF3 = _id_6FDF0163E9BC1DB7 && _id_50BE03284E4758EC;
  _id_CE97A422FC1540C3 = !(_id_50BE03284E4758EC || _id_6FDF0163E9BC1DB7);
  _id_48AB287AD776F873 = self getanimentrycount(statename);

  if(_id_CE97A422FC1540C3)
    return randomint(_id_48AB287AD776F873);

  if(_id_42240D6D5AE03AF3)
    return 0;

  _id_AA0298CAF557F9A0 = int(_id_48AB287AD776F873 / 2);

  if(_id_6FDF0163E9BC1DB7)
    return randomint(_id_AA0298CAF557F9A0);

  return _id_AA0298CAF557F9A0 + randomint(_id_AA0298CAF557F9A0);
}

_id_11BE19DBFED0714E(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  _id_DA7244130733E3BD = _id_BE2677E37B255244(self._id_003B90191D39897A, 1);
  _id_8643244E103CC2FC(asmname, statename, self._id_003B90191D39897A, _id_DA7244130733E3BD, 1, 1, self._id_0DA951E8204605E7, 1);
  scripts\asm\asm::asm_fireevent(asmname, "end");
}

_id_62481188BBCA357A(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  _id_003B90191D39897A = scripts\asm\asm_bb::bb_getmeleetarget();
  self._id_ECD7A04BA5810935 = undefined;
  _id_DA7244130733E3BD = _id_BE2677E37B255244(_id_003B90191D39897A, 1);
  self._id_A28C36715121057E = 1;
  self.aistate = "melee";
  _id_8643244E103CC2FC(asmname, statename, _id_003B90191D39897A, _id_DA7244130733E3BD, 0, 1, self._id_0DA951E8204605E7);
  self.aistate = "move";
  scripts\asm\asm::asm_fireevent(asmname, "end");
}

_id_8EA572B0A2937E29(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  _id_003B90191D39897A = scripts\asm\asm_bb::bb_getmeleetarget();
  _id_DA7244130733E3BD = _id_BE2677E37B255244(_id_003B90191D39897A, 1);
  self.aistate = "melee";
  _id_8643244E103CC2FC(asmname, statename, _id_003B90191D39897A, _id_DA7244130733E3BD, 0, 1, self._id_0DA951E8204605E7);
  self.aistate = "idle";
  scripts\asm\asm::asm_fireevent(asmname, "end");
}

_id_AE8D8CA129EEA798(statename, _id_CFF0AD7A3E0402B7, _id_2404F879DEB5CEF7, _id_6B7BEE46F2C6DA28) {
  _id_57FEC5588A40C82E = getnotetracktimes(_id_CFF0AD7A3E0402B7, "finish");
  _id_FDF45E0C836BE089 = 0.9;

  if(_id_57FEC5588A40C82E.size > 0)
    _id_FDF45E0C836BE089 = _id_57FEC5588A40C82E[0];

  _id_643983E4FF66295B = _id_2404F879DEB5CEF7 / self._id_0DA951E8204605E7 * _id_FDF45E0C836BE089;
  _id_8DD9F2EB8215A139 = _id_643983E4FF66295B - _id_6B7BEE46F2C6DA28;

  if(_id_8DD9F2EB8215A139 > 0)
    scripts\mp\agents\scriptedagents::waituntilnotetrack_safe(statename, "end", _id_8DD9F2EB8215A139);
}

_id_AFE8744FA31B849E(asmname, statename, animindex, attachtag, params) {
  _id_93A2C35BC9547955 = self getanimentry(statename, animindex);
  _id_F9AEAF962B77CB85 = getanimlength(_id_93A2C35BC9547955);
  _id_B81033513CC777F3 = getnotetracktimes(_id_93A2C35BC9547955, "gutgrab");
  _id_D31836523C14EB8A = _id_F9AEAF962B77CB85 / self._id_0DA951E8204605E7 * _id_B81033513CC777F3[0];

  if(isDefined(self._id_003B90191D39897A))
    thread _id_BB335B0726694A1D(statename, self._id_003B90191D39897A, 15);

  self animmode("zonly_physics");
  scripts\mp\agents\scriptedagents::set_anim_state(statename, animindex, self._id_0DA951E8204605E7);
  wait(_id_D31836523C14EB8A);
  self._id_94B992C2411178E0 = _id_4B1DA02E57F61EED();
  self._id_35BCBBE0BA774121 = attachtag;
  self attach(self._id_94B992C2411178E0, self._id_35BCBBE0BA774121);
  _id_AE8D8CA129EEA798(statename, _id_93A2C35BC9547955, _id_F9AEAF962B77CB85, _id_D31836523C14EB8A);
}

_id_057250D39DDA45B5(asmname, statename, animindex, params) {
  _id_D21FBD6DD45D4D02 = self getanimentry(statename, animindex);
  _id_13EF1D4ACC3EAF56 = getanimlength(_id_D21FBD6DD45D4D02);
  _id_B711A5FFACFAB91A = getnotetracktimes(_id_D21FBD6DD45D4D02, "gutgo");
  _id_2B69EBF1AEB9C653 = _id_13EF1D4ACC3EAF56 / self._id_0DA951E8204605E7 * _id_B711A5FFACFAB91A[0];
  scripts\mp\agents\scriptedagents::set_anim_state(statename, animindex, self._id_0DA951E8204605E7);
  _id_FAA91BEA45F95DF4();

  if(isDefined(self._id_003B90191D39897A)) {
    if(issentient(self._id_003B90191D39897A))
      _id_A2825DE7E3791A80 = self._id_003B90191D39897A getEye();
    else
      _id_A2825DE7E3791A80 = self._id_003B90191D39897A.origin + (0, 0, 45);

    _id_D67AA30D4E0E0BDB = _id_A2825DE7E3791A80[2] - self._id_003B90191D39897A.origin[2];
    _id_2AE01F9836C08415 = self._id_003B90191D39897A.origin + (0, 0, randomfloatrange(0.5, 1) * _id_D67AA30D4E0E0BDB);
  } else
    _id_2AE01F9836C08415 = self.origin + anglesToForward(self.angles) * 400 + (0, 0, randomfloatrange(25, 55));

  wait(_id_2B69EBF1AEB9C653);
  _id_5D30197AF620E094();
  self orientmode("face angle", self.angles[1]);
  self animmode("zonly_physics");
  thread _id_A2420D3EF7F943E4(_id_2AE01F9836C08415);
  _id_AE8D8CA129EEA798(statename, _id_D21FBD6DD45D4D02, _id_13EF1D4ACC3EAF56, _id_2B69EBF1AEB9C653);
}

_id_A2420D3EF7F943E4(_id_2AE01F9836C08415) {
  _id_75BAAF7E3319453E = 1000;
  _id_7A93C34D424CB18E = 5;

  if(isDefined(self._id_B5BD9EDCB0BF65F1))
    _id_75BAAF7E3319453E = self._id_B5BD9EDCB0BF65F1;

  if(isDefined(self._id_94B992C2411178E0)) {
    self detach(self._id_94B992C2411178E0, self._id_35BCBBE0BA774121);
    self._id_94B992C2411178E0 = undefined;
  }

  _id_D5685B7BAEE6505E = self gettagorigin(self._id_35BCBBE0BA774121);
  _id_268A2463FA58D460 = _id_2AE01F9836C08415 - _id_D5685B7BAEE6505E;
  time = length((_id_268A2463FA58D460[0], _id_268A2463FA58D460[1], 0)) / _id_75BAAF7E3319453E;

  if(time == 0) {
    return;
  }
  gravity = getdvarfloat("bg_gravity");
  _id_DC7E1E9FDB74DEFA = (0.5 * gravity * squared(time) + _id_268A2463FA58D460[2]) / time;
  _id_268A2463FA58D460 = vectorNormalize((_id_268A2463FA58D460[0], _id_268A2463FA58D460[1], 0));
  grenadeweapon = _id_D5E7F1032E5B43C3();
  _id_574BD21B0CAFDAC9 = (_id_268A2463FA58D460[0] * _id_75BAAF7E3319453E, _id_268A2463FA58D460[1] * _id_75BAAF7E3319453E, _id_DC7E1E9FDB74DEFA);
  grenade = magicgrenademanual(grenadeweapon, _id_D5685B7BAEE6505E, _id_574BD21B0CAFDAC9, _id_7A93C34D424CB18E, self);
  grenade.angles = self gettagangles(self._id_35BCBBE0BA774121);
}

_id_B6D7A271FC0A7DF4(asmname, statename, params) {
  self endon(statename + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  self.aistate = "melee";
  _id_423BF6DF67B7E031 = [];

  if(!_id_6C1867C995FF7F69::_id_70F96AD5BD833DBC()) {
    _id_109EBF347B2F2ECE = _id_423BF6DF67B7E031.size;
    _id_423BF6DF67B7E031[_id_109EBF347B2F2ECE]["animIndex"] = 0;
    _id_423BF6DF67B7E031[_id_109EBF347B2F2ECE]["tag"] = "tag_accessory_left";
  }

  if(!_id_6C1867C995FF7F69::_id_A24DFF1AB397A8C7()) {
    _id_109EBF347B2F2ECE = _id_423BF6DF67B7E031.size;
    _id_423BF6DF67B7E031[_id_109EBF347B2F2ECE]["animIndex"] = 2;
    _id_423BF6DF67B7E031[_id_109EBF347B2F2ECE]["tag"] = "tag_accessory_right";
  }

  _id_E5EED26421BB885D = scripts\engine\utility::random(_id_423BF6DF67B7E031);

  if(istrue(self._id_7A6F177A475C47E9)) {
    self._id_94B992C2411178E0 = _id_4B1DA02E57F61EED();
    self._id_35BCBBE0BA774121 = _id_E5EED26421BB885D["tag"];
    self attach(self._id_94B992C2411178E0, self._id_35BCBBE0BA774121);
  } else
    _id_AFE8744FA31B849E(asmname, statename, _id_E5EED26421BB885D["animIndex"], _id_E5EED26421BB885D["tag"], params);

  _id_057250D39DDA45B5(asmname, statename, _id_E5EED26421BB885D["animIndex"] + 1, params);
  scripts\asm\asm::asm_fireevent(asmname, "end");
}

_id_4B1DA02E57F61EED() {
  if(isDefined(self._id_70CA8F100F632365))
    return self._id_70CA8F100F632365;

  return "c_t9_zmb_gore_chunk_03";
}

_id_D5E7F1032E5B43C3() {
  if(isDefined(self._id_8E51010DF7FFF4AC))
    return self._id_8E51010DF7FFF4AC;

  return "zombie_ranged_attack_mp";
}

_id_DDFDDA062348DE92(asmname, statename, params) {
  if(isDefined(self)) {
    self.aistate = "idle";
    self._id_B7BDFA418F9F4430 = gettime();

    if(isDefined(self._id_521FAC03E5F3A11B) && self._id_521FAC03E5F3A11B == "ranger") {
      _id_FDDFE9A98E92D6D5 = getdvarfloat("dvar_55D57D5A7466B197", 1);
      _id_8CEC4BA717838CF7 = getdvarfloat("dvar_88AFA4FD264782F5", 3);
      self._id_8B21F2B424F46AF0 = randomfloatrange(_id_FDDFE9A98E92D6D5, _id_8CEC4BA717838CF7);
    }

    if(isDefined(self._blackboard))
      _id_5D30197AF620E094();

    _id_FAA91BEA45F95DF4();

    if(isDefined(self._id_94B992C2411178E0))
      self detach(self._id_94B992C2411178E0, self._id_35BCBBE0BA774121);
    else if(!isalive(self))
      self detachall();

    self._id_94B992C2411178E0 = undefined;
    self._id_35BCBBE0BA774121 = undefined;
  }
}

_id_115ABBD02903159C(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  _id_003B90191D39897A = scripts\asm\asm_bb::bb_getmeleetarget();
  _id_DA7244130733E3BD = _id_BE2677E37B255244(_id_003B90191D39897A, 1);
  self.aistate = "melee";
  _id_8643244E103CC2FC(asmname, statename, _id_003B90191D39897A, _id_DA7244130733E3BD, 0, 1, self._id_0DA951E8204605E7, 0, 1);
  self.aistate = "idle";
  scripts\asm\asm::asm_fireevent(asmname, "end");
}

_id_36A99CA8A64DB95A(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(self._blackboard._id_45C3DFCA98A9533B) && self._blackboard._id_45C3DFCA98A9533B;
}

_id_4A70A4BDBC304A6B() {
  if(_id_36A99CA8A64DB95A())
    return 1;

  return 0;
}

_id_E185167BA8A23B86() {
  return istrue(self.should_play_transformation_anim);
}

_id_AA6D6980DA410E39(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(statename + "_finished");

  if(isDefined(self.agent_type) && self.agent_type == "skater")
    playsoundatpos(self gettagorigin("tag_eye"), "zmb_skater_pre_explo");
  else
    playsoundatpos(self gettagorigin("tag_eye"), "zmb_clown_pre_explo");

  animindex = scripts\asm\asm_mp::asm_getanimindex(asmname, statename);
  scripts\mp\agents\scriptedagents::playanimnatrateuntilnotetrack(statename, animindex, 2.0, statename, "explode");

  if(isDefined(self.agent_type) && self.agent_type != "skater")
    playsoundatpos(self gettagorigin("tag_eye"), "zmb_vo_clown_death");

  wait 0.25;
  self stopsounds();
  self.nocorpse = 1;
  self suicide();
}

_id_8DA202040DC1AE33(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(statename + "_finished");
  self.should_play_transformation_anim = undefined;
  animindex = scripts\asm\asm_mp::asm_getanimindex(asmname, statename);
  scripts\mp\agents\scriptedagents::playanimnuntilnotetrack(statename, animindex, statename);
}

_id_3563AABB9BF83914(_id_E684FC6E068EE951, enemy) {
  self endon(_id_E684FC6E068EE951 + "_finished");
  self notify("stop_melee_face_enemy");
  self endon("stop_melee_face_enemy");

  for(;;) {
    if(isDefined(enemy) && isalive(enemy))
      self orientmode("face angle", vectortoyaw(enemy.origin - self.origin), 1);
    else
      break;

    waitframe();
  }
}

_id_BB335B0726694A1D(_id_E684FC6E068EE951, enemy, _id_D785459A5AF82E0F) {
  self endon(_id_E684FC6E068EE951 + "_finished");
  self notify("stop_melee_face_enemy");
  self endon("stop_melee_face_enemy");

  for(;;) {
    if(isDefined(enemy) && isalive(enemy)) {
      _id_E72B3A053F9A22E4 = self.angles[1];
      _id_2DB201E40E7AAF8C = vectortoyaw(enemy.origin - self.origin);
      _id_BB0AF69B123AC497 = angleclamp180(_id_2DB201E40E7AAF8C - _id_E72B3A053F9A22E4);

      if(abs(_id_BB0AF69B123AC497) < _id_D785459A5AF82E0F)
        _id_EBF05B5978327EC0 = _id_2DB201E40E7AAF8C;
      else {
        _id_BB0B029B123ADEFB = _id_BB0AF69B123AC497 / abs(_id_BB0AF69B123AC497);
        _id_EBF05B5978327EC0 = _id_E72B3A053F9A22E4 + _id_BB0B029B123ADEFB * _id_D785459A5AF82E0F;
      }

      self orientmode("face angle", _id_EBF05B5978327EC0, 1);
    } else
      break;

    waitframe();
  }
}

_id_FAA91BEA45F95DF4() {
  self notify("stop_melee_face_enemy");
}

_id_8643244E103CC2FC(asmname, _id_E684FC6E068EE951, _id_1E0B2C127D2BE63E, _id_DA7244130733E3BD, _id_55521527EB9592D9, _id_DF188F5512B6CF85, _id_07B60BC0EAB3FD1E, _id_3EE3C9994FC1A9D8, _id_64CF82E79F38EDC1) {
  self endon(_id_E684FC6E068EE951 + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  self._id_C72136D828C5DBA2 = undefined;
  self._id_3071905D9EA1749C = undefined;

  if(!isDefined(_id_3EE3C9994FC1A9D8))
    _id_3EE3C9994FC1A9D8 = 0;

  animindex = scripts\asm\asm_mp::asm_getanimindex(asmname, _id_E684FC6E068EE951);
  _id_F9695B48B749C7B4 = self getanimentry(_id_E684FC6E068EE951, animindex);
  animlength = getanimlength(_id_F9695B48B749C7B4);
  _id_DECF81720417BB3F = getnotetracktimes(_id_F9695B48B749C7B4, "hit");
  _id_2812F26E7D64047F = animlength / _id_07B60BC0EAB3FD1E * 0.33;

  if(_id_DECF81720417BB3F.size > 0)
    _id_2812F26E7D64047F = animlength / _id_07B60BC0EAB3FD1E * _id_DECF81720417BB3F[0];

  _id_57FEC5588A40C82E = getnotetracktimes(_id_F9695B48B749C7B4, "finish");
  _id_FDF45E0C836BE089 = 0.9;

  if(_id_57FEC5588A40C82E.size > 0)
    _id_FDF45E0C836BE089 = _id_57FEC5588A40C82E[0];
  else
    _id_FDF45E0C836BE089 = 0.9;

  _id_643983E4FF66295B = animlength / _id_07B60BC0EAB3FD1E * _id_FDF45E0C836BE089;

  if(_id_DF188F5512B6CF85 && isDefined(self._id_003B90191D39897A))
    thread _id_3563AABB9BF83914(_id_E684FC6E068EE951, self._id_003B90191D39897A);
  else if(isDefined(_id_1E0B2C127D2BE63E))
    self orientmode("face angle", vectortoyaw(_id_1E0B2C127D2BE63E.origin - self.origin));
  else
    self orientmode("face angle", self.angles[1]);

  self animmode("zonly_physics");
  scripts\mp\agents\scriptedagents::set_anim_state(_id_E684FC6E068EE951, animindex, _id_07B60BC0EAB3FD1E);

  if(_id_3EE3C9994FC1A9D8) {
    _id_6636342E8D8C3610 = getnotetracktimes(_id_F9695B48B749C7B4, "lunge_start");
    _id_6ADE07A4D31E6D69 = 0;

    if(_id_6636342E8D8C3610.size > 0)
      _id_6ADE07A4D31E6D69 = animlength / _id_07B60BC0EAB3FD1E * _id_6636342E8D8C3610[0];

    _id_2812F26E7D64047F = _id_2812F26E7D64047F - _id_6ADE07A4D31E6D69;

    if(_id_6ADE07A4D31E6D69 > 0)
      wait(_id_6ADE07A4D31E6D69);

    if(self._id_61BE94A8E9904DBF) {
      _id_2674A2C3EE67214B = _id_DA7244130733E3BD - self.origin;
      movedelta = getmovedelta(_id_F9695B48B749C7B4, _id_6636342E8D8C3610[0], _id_DECF81720417BB3F[0]);
      _id_DDBDC4364B93E58F = scripts\mp\agents\scriptedagents::getanimscalefactors(_id_2674A2C3EE67214B, movedelta);
      _id_07B60BC0EAB3FD1E = _id_07B60BC0EAB3FD1E * clamp(1 / _id_DDBDC4364B93E58F.xy, 0.5, 1);
      _id_2812F26E7D64047F = animlength / _id_07B60BC0EAB3FD1E * _id_DECF81720417BB3F[0] - animlength / _id_07B60BC0EAB3FD1E * _id_6636342E8D8C3610[0];
      scripts\mp\agents\scriptedagents::set_anim_state(_id_E684FC6E068EE951 + "_norestart", animindex, _id_07B60BC0EAB3FD1E);
    }
  }

  wait(_id_2812F26E7D64047F);
  scripts\asm\asm_bb::bb_clearmeleerequest();
  self notify("cancel_updatelerppos");

  if(_id_DF188F5512B6CF85 && isDefined(self._id_003B90191D39897A))
    thread _id_3563AABB9BF83914(_id_E684FC6E068EE951, self._id_003B90191D39897A);
  else {
    _id_FAA91BEA45F95DF4();

    if(isDefined(_id_1E0B2C127D2BE63E))
      self orientmode("face angle", vectortoyaw(_id_1E0B2C127D2BE63E.origin - self.origin));
    else
      self orientmode("face angle", self.angles[1]);
  }

  self animmode("zonly_physics");

  if(_id_55521527EB9592D9)
    scripts\mp\agents\scriptedagents::setstatelocked(0, "DoAttack");

  if(_id_F43620AD355C033F(_id_1E0B2C127D2BE63E)) {
    self notify("attack_hit", _id_1E0B2C127D2BE63E, _id_DA7244130733E3BD);
    _id_3D2A165F057F047A = 0;

    if(isDefined(_id_1E0B2C127D2BE63E))
      _id_3D2A165F057F047A = _id_E0FCF1D7B6E003C1(_id_1E0B2C127D2BE63E);

    if(isDefined(self._id_D3AB98BC63E38BD6))
      _id_3D2A165F057F047A = self._id_D3AB98BC63E38BD6;

    if(isDefined(_id_64CF82E79F38EDC1))
      thread _id_B83C95EBEB713D5E(_id_1E0B2C127D2BE63E, _id_DA7244130733E3BD, 0.5);

    if(isalive(_id_1E0B2C127D2BE63E))
      _id_25F119243A1FF3BD(_id_1E0B2C127D2BE63E, _id_3D2A165F057F047A, "MOD_IMPACT");

    level notify("attack_hit", self, _id_1E0B2C127D2BE63E);
  } else
    self notify("attack_miss", _id_1E0B2C127D2BE63E, _id_DA7244130733E3BD);

  self._id_8A1D0DF0BFD00B8B = self.origin;
  _id_8DD9F2EB8215A139 = _id_643983E4FF66295B - _id_2812F26E7D64047F;

  if(_id_8DD9F2EB8215A139 > 0)
    scripts\mp\agents\scriptedagents::waituntilnotetrack_safe(_id_E684FC6E068EE951, "end", _id_8DD9F2EB8215A139);

  self._id_9563742BCC8616C5 = gettime();
}

_id_B83C95EBEB713D5E(_id_1E0B2C127D2BE63E, _id_DA7244130733E3BD, timer) {
  self endon("death");
  wait(timer);

  if(_id_F43620AD355C033F(_id_1E0B2C127D2BE63E)) {
    self notify("attack_hit", _id_1E0B2C127D2BE63E, _id_DA7244130733E3BD);
    _id_3D2A165F057F047A = 0;

    if(isDefined(_id_1E0B2C127D2BE63E))
      _id_3D2A165F057F047A = _id_E0FCF1D7B6E003C1();

    if(isDefined(self._id_D3AB98BC63E38BD6))
      _id_3D2A165F057F047A = self._id_D3AB98BC63E38BD6;

    if(isalive(_id_1E0B2C127D2BE63E))
      _id_25F119243A1FF3BD(_id_1E0B2C127D2BE63E, _id_3D2A165F057F047A, "MOD_IMPACT");

    level notify("attack_hit", self, _id_1E0B2C127D2BE63E);
  } else
    self notify("attack_miss", _id_1E0B2C127D2BE63E, _id_DA7244130733E3BD);
}

_id_E0FCF1D7B6E003C1(target) {
  damage = 0;

  if(self.agent_type == "zombie_brute")
    damage = 90;
  else if(isDefined(self._id_521FAC03E5F3A11B) && isDefined(self._id_B2DEEC5B4A76EB77))
    damage = self._id_B2DEEC5B4A76EB77;
  else
    damage = 20;

  if(isDefined(target.classname) && target.classname == "script_vehicle")
    damage = damage * 10;

  if(isDefined(target.equipmentref) && target.equipmentref == "equip_tac_cover")
    damage = damage * 10;

  return damage;
}

_id_25F119243A1FF3BD(enemy, damage, meansofdeath) {
  if(scripts\common\utility::isprotectedbyriotshield(enemy)) {
    return;
  }
  if(isPlayer(enemy)) {
    if(enemy scripts\common\utility::isprotectedbyaxeblock(self))
      return;
  }

  enemy dodamage(damage, self.origin, self, self, meansofdeath, "zombie_melee_attack_mp");
}

_id_49B825109756E77D(enemy, _id_A326F793BDAF5565, _id_12EFD7542FCDEB7D, _id_5BB47629C66BC5D9) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  enemy endon("disconnect");
  enemy endon("death");
  startpos = self.origin;
  timeremaining = _id_A326F793BDAF5565;
  interval = 0.05;

  for(;;) {
    wait(interval);
    timeremaining = timeremaining - interval;

    if(timeremaining <= 0) {
      break;
    }

    _id_DA7244130733E3BD = _id_BE2677E37B255244(enemy, _id_12EFD7542FCDEB7D);

    if(!isDefined(_id_DA7244130733E3BD)) {
      break;
    }

    if(isDefined(_id_5BB47629C66BC5D9))
      _id_B5DC80F7E6121B8B = _id_5BB47629C66BC5D9;
    else
      _id_B5DC80F7E6121B8B = _id_0A662F25DBF78119::_id_FCB16F2EAF12DA83() - self.radius;

    _id_3777ECE6A73EADA5 = _id_DA7244130733E3BD - startpos;

    if(lengthsquared(_id_3777ECE6A73EADA5) > _id_B5DC80F7E6121B8B * _id_B5DC80F7E6121B8B)
      _id_DA7244130733E3BD = startpos + vectorNormalize(_id_3777ECE6A73EADA5) * _id_B5DC80F7E6121B8B;
  }
}

_id_BE2677E37B255244(enemy, _id_F99B8882C316E3D8) {
  if(!isDefined(enemy))
    return undefined;

  if(!_id_F99B8882C316E3D8) {
    _id_3627F3C8C6351D4D = scripts\mp\agents\scriptedagents::droppostoground(enemy.origin);
    return _id_3627F3C8C6351D4D;
  } else {
    _id_6A4277FF9E64049F = enemy.origin - self.origin;
    _id_E69C9108F53988F3 = length(_id_6A4277FF9E64049F);

    if(_id_E69C9108F53988F3 < self._id_C8818686F12F33B6)
      return self.origin;
    else {
      _id_6A4277FF9E64049F = _id_6A4277FF9E64049F / _id_E69C9108F53988F3;
      _id_225D5BE1546186A5 = _id_0A662F25DBF78119::_id_FD42BE10A26FFF59(enemy);

      if(_id_0A662F25DBF78119::_id_DC852E3D3327CAF8(self.origin, _id_225D5BE1546186A5.origin))
        return _id_225D5BE1546186A5.origin;
      else
        return undefined;
    }
  }
}

_id_F43620AD355C033F(_id_1E0B2C127D2BE63E) {
  if(!isalive(_id_1E0B2C127D2BE63E))
    return 0;

  if(!_id_2715F42723CC0278())
    return 0;

  if(isPlayer(_id_1E0B2C127D2BE63E) || isai(_id_1E0B2C127D2BE63E)) {
    if(isDefined(level._id_C7F73EF4CB5F312E)) {
      result = [[level._id_C7F73EF4CB5F312E]](_id_1E0B2C127D2BE63E);

      if(isDefined(result))
        return result;
    }

    if(istrue(self._id_0DC7052BBFE5C799) && !istrue(self.dismember_crawl)) {
      ignorelist = [];
      ignorelist[0] = self;
      start = self getEye() - (0, 0, 16);
      end = _id_1E0B2C127D2BE63E getEye() - (0, 0, 16);
      trace = scripts\engine\trace::sphere_trace(start, end, 4, ignorelist);

      if(trace["fraction"] < 1) {
        hit = trace["entity"];

        if(isDefined(hit) && isai(hit)) {
          if(isDefined(hit.team) && hit.team == self.team) {
            if(distance(self.origin, hit.origin) > 12)
              return 0;
          }
        }
      }
    }
  }

  if(isenemyinfrontofme(_id_1E0B2C127D2BE63E, self._id_93C7E046D802A2D2))
    return 1;

  if(_id_0A662F25DBF78119::_id_254992A907EE42E9(_id_1E0B2C127D2BE63E))
    return 1;

  return 0;
}

isenemyinfrontofme(enemy, _id_3B37CA6EC4D56E75) {
  dir = vectorNormalize((enemy.origin - self.origin) * (1, 1, 0));
  fwd = anglesToForward(self.angles);
  dot = vectordot(dir, fwd);
  return dot > _id_3B37CA6EC4D56E75;
}

_id_2715F42723CC0278() {
  _id_730A707DFD408062 = self.entered_playspace;

  if(isDefined(self._id_003B90191D39897A) && !ispointonnavmesh(self._id_003B90191D39897A.origin) && !scripts\asm\asm_bb::bb_moverequested()) {
    if(_id_0A662F25DBF78119::_id_06F13D6BE163AD9A("offmesh", _id_730A707DFD408062))
      return 1;
  }

  if(!_id_0A662F25DBF78119::_id_06F13D6BE163AD9A("normal", _id_730A707DFD408062))
    return 0;

  if(_id_0A662F25DBF78119::_id_FCB16F2EAF12DA83() > self._id_FA4CF34A0C3681B8 && !_id_0A662F25DBF78119::_id_0E2C77EC2E423711())
    return 0;

  return 1;
}

_id_5D30197AF620E094() {
  scripts\asm\asm_bb::bb_clearmeleerequest();
  self._blackboard._id_1FE1B9B8CD0B87AC = 0;
}