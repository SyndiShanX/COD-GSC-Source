/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_59ade1e685ba06e8.gsc
***********************************************/

asm_register() {
  if(!isDefined(anim.asmfuncs))
    anim.asmfuncs = [];

  if(isDefined(anim.asmfuncs["zombie_lw_br"])) {
    return;
  }
  anim.asmfuncs["zombie_lw_br"] = [];
  anim.asmfuncs["zombie_lw_br"][0] = _id_2583D21413584AB5::_id_0B45B4CB9B781CBD;
  anim.asmfuncs["zombie_lw_br"][1] = _id_2583D21413584AB5::_id_8514C9ADBB3F1C9C;
  anim.asmfuncs["zombie_lw_br"][2] = _id_2583D21413584AB5::_id_FDF3CBF366143618;
  anim.asmfuncs["zombie_lw_br"][3] = _id_2583D21413584AB5::_id_5384FBF2844C9CAA;
  anim.asmfuncs["zombie_lw_br"][4] = _id_2583D21413584AB5::_id_1050ABC64E117EA0;
  anim.asmfuncs["zombie_lw_br"][5] = _id_2583D21413584AB5::_id_88C988506100B781;
  anim.asmfuncs["zombie_lw_br"][6] = _id_2583D21413584AB5::_id_68F7AB36A507151B;
  anim.asmfuncs["zombie_lw_br"][7] = _id_213BC34B8301BCEB::playanim_flashed;
  anim.asmfuncs["zombie_lw_br"][8] = _id_213BC34B8301BCEB::cleanupflashanim;
  anim.asmfuncs["zombie_lw_br"][9] = ::autogenfunc_0;
  anim.asmfuncs["zombie_lw_br"][10] = ::autogenfunc_1;
  anim.asmfuncs["zombie_lw_br"][11] = ::autogenfunc_2;
  anim.asmfuncs["zombie_lw_br"][12] = ::autogenfunc_3;
  anim.asmfuncs["zombie_lw_br"][13] = ::autogenfunc_4;
  anim.asmfuncs["zombie_lw_br"][14] = ::autogenfunc_5;
  anim.asmfuncs["zombie_lw_br"][15] = ::autogenfunc_6;
  anim.asmfuncs["zombie_lw_br"][16] = ::autogenfunc_7;
  anim.asmfuncs["zombie_lw_br"][17] = ::autogenfunc_8;
  anim.asmfuncs["zombie_lw_br"][18] = _id_2583D21413584AB5::_id_9E24E56CA66F3CF5;
  anim.asmfuncs["zombie_lw_br"][19] = _id_2583D21413584AB5::_id_B3690E2C7A85D44E;
  anim.asmfuncs["zombie_lw_br"][20] = ::autogenfunc_9;
  anim.asmfuncs["zombie_lw_br"][21] = _id_213BC34B8301BCEB::_id_6DE4688D752DFA75;
  anim.asmfuncs["zombie_lw_br"][22] = _id_3BCA7161FCE5D5A5::playdeathanim;
  anim.asmfuncs["zombie_lw_br"][23] = _id_3BCA7161FCE5D5A5::choosestandingdeathanim;
  anim.asmfuncs["zombie_lw_br"][24] = _id_3BCA7161FCE5D5A5::choosemovingdeathanim;
  anim.asmfuncs["zombie_lw_br"][25] = _id_2583D21413584AB5::_id_DAA730BF09B40F6E;
  anim.asmfuncs["zombie_lw_br"][26] = _id_2583D21413584AB5::_id_3EAE95E96B61D1C3;
  anim.asmfuncs["zombie_lw_br"][27] = _id_2583D21413584AB5::_id_81C487B3DDB51C61;
  anim.asmfuncs["zombie_lw_br"][28] = _id_63824E9BD0081BC7::_id_62481188BBCA357A;
  anim.asmfuncs["zombie_lw_br"][29] = _id_63824E9BD0081BC7::_id_93B45E8AF958A775;
  anim.asmfuncs["zombie_lw_br"][30] = _id_63824E9BD0081BC7::_id_8EA572B0A2937E29;
  anim.asmfuncs["zombie_lw_br"][31] = _id_63824E9BD0081BC7::_id_B6D7A271FC0A7DF4;
  anim.asmfuncs["zombie_lw_br"][32] = _id_63824E9BD0081BC7::_id_DDFDDA062348DE92;
  anim.asmfuncs["zombie_lw_br"][33] = ::autogenfunc_10;
  anim.asmfuncs["zombie_lw_br"][34] = ::_id_3F8A7172532DBEF5;
  anim.asmfuncs["zombie_lw_br"][35] = ::_id_3F8A6E72532DB85C;
  anim.asmfuncs["zombie_lw_br"][36] = _id_2583D21413584AB5::_id_9A4E666BE0DB2E1A;
  anim.asmfuncs["zombie_lw_br"][37] = _id_2583D21413584AB5::_id_E94D69D6EE392462;
  anim.asmfuncs["zombie_lw_br"][38] = _id_2583D21413584AB5::_id_F330681B9D3E66DB;
  anim.asmfuncs["zombie_lw_br"][39] = _id_374477D88E5F2CE2::chooseanim_exit;
  anim.asmfuncs["zombie_lw_br"][40] = _id_2583D21413584AB5::_id_37FE3EF536870246;
  anim.asmfuncs["zombie_lw_br"][41] = _id_395DC18818F65EF2::chooseanim_arrival;
  anim.asmfuncs["zombie_lw_br"][42] = _id_2583D21413584AB5::_id_2A6F140C2C70C0C3;
  anim.asmfuncs["zombie_lw_br"][43] = _id_374477D88E5F2CE2::choosesharpturnanim;
  anim.asmfuncs["zombie_lw_br"][44] = _id_2583D21413584AB5::_id_5367090536186191;
  anim.asmfuncs["zombie_lw_br"][45] = ::_id_3F8A6F72532DBA8F;
  anim.asmfuncs["zombie_lw_br"][46] = _id_2583D21413584AB5::_id_9ECC61D081369543;
  anim.asmfuncs["zombie_lw_br"][47] = _id_374477D88E5F2CE2::shoulddosharpturn;
  anim.asmfuncs["zombie_lw_br"][48] = ::_id_3F8A6C72532DB3F6;
  anim.asmfuncs["zombie_lw_br"][49] = ::_id_3F8A6D72532DB629;
  anim.asmfuncs["zombie_lw_br"][50] = ::_id_3F8A6A72532DAF90;
  anim.asmfuncs["zombie_lw_br"][51] = _id_2583D21413584AB5::_id_DF87C28A61DCF3BC;
  anim.asmfuncs["zombie_lw_br"][52] = _id_2583D21413584AB5::_id_F31533243DB1C788;
  anim.asmfuncs["zombie_lw_br"][53] = ::_id_3F8A6B72532DB1C3;
  anim.asmfuncs["zombie_lw_br"][54] = _id_2583D21413584AB5::_id_35E021F60D68F619;
  anim.asmfuncs["zombie_lw_br"][55] = ::_id_3F8A7872532DCE5A;
  anim.asmfuncs["zombie_lw_br"][56] = ::_id_3F8A7972532DD08D;
  anim.asmfuncs["zombie_lw_br"][57] = _id_2583D21413584AB5::_id_BB579BD090BD12ED;
  anim.asmfuncs["zombie_lw_br"][58] = _id_2583D21413584AB5::_id_6308EEFEB6CD7A21;
  anim.asmfuncs["zombie_lw_br"][59] = ::_id_3F85EA725328A039;
  anim.asmfuncs["zombie_lw_br"][60] = ::_id_3F85E97253289E06;
  anim.asmfuncs["zombie_lw_br"][61] = ::_id_3F85E87253289BD3;
  anim.asmfuncs["zombie_lw_br"][62] = ::_id_3F85E772532899A0;
}

autogenfunc_0(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self.damagelocation == "head";
}

autogenfunc_1(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return !_id_2583D21413584AB5::_id_5AE9A5D059D0030A(self.damagetaken, self.damageweapon, self.damagemod, self.damagelocation);
}

autogenfunc_2(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

autogenfunc_3(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

autogenfunc_4(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return 1;
}

autogenfunc_5(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_2583D21413584AB5::_id_C5259C6807077972(self.damagelocation) && scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

autogenfunc_6(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_2583D21413584AB5::_id_C5259C6807077972(self.damagelocation) && scripts\asm\asm_bb::bb_movetyperequested("run");
}

autogenfunc_7(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_2583D21413584AB5::_id_C5259C6807077972(self.damagelocation) && scripts\asm\asm_bb::bb_movetyperequested("walk");
}

autogenfunc_8(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_2583D21413584AB5::_id_C5259C6807077972(self.damagelocation);
}

autogenfunc_9(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_2583D21413584AB5::_id_5AE9A5D059D0030A(self.damagetaken, self.damageweapon, self.damagemod, self.damagelocation);
}

autogenfunc_10(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_63824E9BD0081BC7::_id_8D58E5CCA2ECCC05();
}

_id_3F8A7172532DBEF5(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm_bb::bb_movetyperequested("walk");
}

_id_3F8A6E72532DB85C(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_63824E9BD0081BC7::_id_F7CEC1E850AD0CEB();
}

_id_3F8A6F72532DBA8F(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_2583D21413584AB5::_id_72A9AC4D7161B337();
}

_id_3F8A6C72532DB3F6(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_2583D21413584AB5::_id_A1187EAD4F44C8C9();
}

_id_3F8A6D72532DB629(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_63824E9BD0081BC7::_id_F8D4B082424E414F();
}

_id_3F8A6A72532DAF90(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_2583D21413584AB5::_id_DABDD08D8888F419();
}

_id_3F8A6B72532DB1C3(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm_bb::bb_isincombat();
}

_id_3F8A7872532DCE5A(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_2583D21413584AB5::_id_298A3BABA2C0C486();
}

_id_3F8A7972532DD08D(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self.hasplayedvignetteanim;
}

_id_3F85EA725328A039(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self._id_2392A32020FB22B5;
}

_id_3F85E97253289E06(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_2583D21413584AB5::_id_D3A4CB085DE246AA();
}

_id_3F85E87253289BD3(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return !scripts\asm\asm_bb::bb_isincombat();
}

_id_3F85E772532899A0(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_2583D21413584AB5::_id_1AAA2F84052E7F9E();
}