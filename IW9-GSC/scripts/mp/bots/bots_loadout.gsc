/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_loadout.gsc
***********************************************/

init() {
  level._id_0CEBC8CC0640FE57 = spawnStruct();
  level._id_0CEBC8CC0640FE57.loadouts = [];
  level._id_0CEBC8CC0640FE57._id_E1F5513362A6C2AA = [];
  level._id_0CEBC8CC0640FE57.initialized = 0;
  _id_13EDD4D60268005F();
  level._id_0CEBC8CC0640FE57.initialized = 1;
}

_id_13EDD4D60268005F() {
  _id_2C01E192EE48A8A9 = level._id_1A2B600A06EC21F4._id_3D5C458EDE7B8A36;
  _id_5CFBD0F1B8A69ED9 = getscriptbundle(_func_2EF675C13CA1C4AF("enum_2C353B56CFC15851", _id_2C01E192EE48A8A9));

  if(!isDefined(_id_5CFBD0F1B8A69ED9)) {
    return;
  }
  foreach(_id_04CE3EF82D7B573E in _id_5CFBD0F1B8A69ED9._id_E2EB85F16407D26A) {
    _id_2637BFF642EA1C8D = getscriptbundle("botloadout:" + _id_04CE3EF82D7B573E.loadout);

    if(!isDefined(_id_2637BFF642EA1C8D)) {
      continue;
    }
    level._id_0CEBC8CC0640FE57.loadouts[_id_04CE3EF82D7B573E.loadout] = _id_2637BFF642EA1C8D;
    _id_045760037594A027 = [];
    _id_482BFDBCC9CCA6C4 = [];

    if(isDefined(_id_2637BFF642EA1C8D.personality)) {
      if(istrue(_id_2637BFF642EA1C8D.personality._id_F6B5A87714F6F1FF))
        _id_045760037594A027[_id_045760037594A027.size] = "camper";

      if(istrue(_id_2637BFF642EA1C8D.personality._id_65638B1A080A38D3))
        _id_045760037594A027[_id_045760037594A027.size] = "run_and_gun";

      if(istrue(_id_2637BFF642EA1C8D.personality._id_A4F96D03B3971265))
        _id_045760037594A027[_id_045760037594A027.size] = "cqb";
    }

    if(isDefined(_id_2637BFF642EA1C8D.difficulty)) {
      if(istrue(_id_2637BFF642EA1C8D.difficulty._id_C378E35AF6BDFEFD))
        _id_482BFDBCC9CCA6C4[_id_482BFDBCC9CCA6C4.size] = "recruit";

      if(istrue(_id_2637BFF642EA1C8D.difficulty._id_449F71E780D281DB))
        _id_482BFDBCC9CCA6C4[_id_482BFDBCC9CCA6C4.size] = "regular";

      if(istrue(_id_2637BFF642EA1C8D.difficulty._id_1E92DE7E3EA1EAB2))
        _id_482BFDBCC9CCA6C4[_id_482BFDBCC9CCA6C4.size] = "hardened";

      if(istrue(_id_2637BFF642EA1C8D.difficulty._id_02E1B6F83ABFC810))
        _id_482BFDBCC9CCA6C4[_id_482BFDBCC9CCA6C4.size] = "veteran";
    }

    if(isDefined(_id_2637BFF642EA1C8D.archetype)) {
      foreach(personality in _id_045760037594A027) {
        foreach(difficulty in _id_482BFDBCC9CCA6C4) {
          _id_CDCE92E2F99A113D = _id_B1CBF0185DF8C1A8(personality, difficulty, "archetype_" + tolower(_id_2637BFF642EA1C8D.archetype));

          if(!isDefined(level._id_0CEBC8CC0640FE57._id_E1F5513362A6C2AA[_id_CDCE92E2F99A113D]))
            level._id_0CEBC8CC0640FE57._id_E1F5513362A6C2AA[_id_CDCE92E2F99A113D] = [];

          _id_B9FB2DE33B94C967 = level._id_0CEBC8CC0640FE57._id_E1F5513362A6C2AA[_id_CDCE92E2F99A113D].size;
          level._id_0CEBC8CC0640FE57._id_E1F5513362A6C2AA[_id_CDCE92E2F99A113D][_id_B9FB2DE33B94C967] = _id_04CE3EF82D7B573E.loadout;
        }
      }
    }
  }
}

_id_B1CBF0185DF8C1A8(personality, difficulty, archetype) {
  return personality + "_" + difficulty + "_" + archetype;
}

_id_70D701F63ACAB018() {
  _id_324375F2F392C8EE = spawnStruct();
  _id_324375F2F392C8EE.archetype = "assault";
  _id_324375F2F392C8EE.primaryweapon = spawnStruct();
  _id_324375F2F392C8EE.primaryweapon.weapon = "iw9_sm_alpha57";
  _id_324375F2F392C8EE.primaryweapon._id_59F68715C04CE28F = "iw9_minireddot03_tall_p01";
  _id_324375F2F392C8EE.primaryweapon._id_59F68815C04CE4C2 = "grip_vert01";
  _id_324375F2F392C8EE.primaryweapon._id_59F68915C04CE6F5 = "barsil_sm_p01";
  _id_324375F2F392C8EE.primaryweapon._id_59F68215C04CD790 = "grip_angled01";
  _id_324375F2F392C8EE.primaryweapon._id_59F68315C04CD9C3 = "pgrip_ske_p01";
  _id_324375F2F392C8EE.primaryweapon._id_59F68415C04CDBF6 = "laserbox_ads02";
  _id_324375F2F392C8EE.primaryweapon.camo = "none";
  _id_324375F2F392C8EE.primaryweapon.reticle = "none";
  _id_324375F2F392C8EE.secondaryweapon = spawnStruct();
  _id_324375F2F392C8EE.secondaryweapon.weapon = "iw9_pi_golf17";
  _id_324375F2F392C8EE.secondaryweapon._id_59F68715C04CE28F = "bar_pi_heavy_p24";
  _id_324375F2F392C8EE.secondaryweapon._id_59F68815C04CE4C2 = "mag_pi_large_p24";
  _id_324375F2F392C8EE.secondaryweapon._id_59F68915C04CE6F5 = "stockno_pi_p24";
  _id_324375F2F392C8EE.secondaryweapon._id_59F68215C04CD790 = "pgrip_aim_p24";
  _id_324375F2F392C8EE.secondaryweapon._id_59F68315C04CD9C3 = "none";
  _id_324375F2F392C8EE.secondaryweapon.camo = "none";
  _id_324375F2F392C8EE.secondaryweapon.reticle = "none";
  _id_324375F2F392C8EE.equipment = spawnStruct();
  _id_324375F2F392C8EE.equipment.primary = "equip_throwing_knife";
  _id_324375F2F392C8EE.equipment._id_D7B9856A19F9B6B5 = "equip_shockstick";
  _id_324375F2F392C8EE._id_AD6972268C86A2BE = spawnStruct();
  _id_324375F2F392C8EE._id_AD6972268C86A2BE.primary = 0;
  _id_324375F2F392C8EE._id_AD6972268C86A2BE._id_D7B9856A19F9B6B5 = 0;
  _id_324375F2F392C8EE.perks = spawnStruct();
  _id_324375F2F392C8EE.perks._id_16680ABD1742C050 = "specialty_warhead";
  _id_324375F2F392C8EE.perks._id_16680DBD1742C6E9 = "specialty_huntmaster";
  _id_324375F2F392C8EE.perks._id_16680CBD1742C4B6 = "specialty_covert_ops";
  _id_324375F2F392C8EE._id_50D0559DCBA571E2 = spawnStruct();
  _id_324375F2F392C8EE._id_50D0559DCBA571E2._id_16680ABD1742C050 = "specialty_guerrilla";
  _id_324375F2F392C8EE._id_50D0559DCBA571E2._id_16680DBD1742C6E9 = "specialty_null";
  _id_324375F2F392C8EE._id_50D0559DCBA571E2._id_16680CBD1742C4B6 = "specialty_null";
  _id_324375F2F392C8EE.gesture = "iw8_ges_plyr_gesture000";
  _id_324375F2F392C8EE.execution = "neck_stab";
  _id_324375F2F392C8EE._id_7E397F4CE66BFFD0 = "none";
  _id_324375F2F392C8EE._id_7E39824CE66C0669 = "none";
  _id_324375F2F392C8EE.role = "role_hunter";
  _id_324375F2F392C8EE._id_CA76BF5089783EF3 = 0;
  _id_324375F2F392C8EE.specialist = 1;
  return _id_324375F2F392C8EE;
}

_id_EBE5D810FC2C7196(_id_9D601A34D1111B04) {
  if(isDefined(level._id_0CEBC8CC0640FE57.loadouts[_id_9D601A34D1111B04])) {
    self._id_B2F042BF9991295D = _id_9D601A34D1111B04;
    return 1;
  }

  return 0;
}

_id_4F1B939BBC96291B(personality, difficulty, archetype) {
  _id_76CD494D92AC8074 = _id_B1CBF0185DF8C1A8(personality, difficulty, archetype);

  if(isDefined(level._id_0CEBC8CC0640FE57._id_E1F5513362A6C2AA[_id_76CD494D92AC8074])) {
    _id_B2F042BF9991295D = scripts\engine\utility::random(level._id_0CEBC8CC0640FE57._id_E1F5513362A6C2AA[_id_76CD494D92AC8074]);
    return _id_EBE5D810FC2C7196(_id_B2F042BF9991295D);
  }

  return 0;
}

_id_A693C24DEF6FB1ED() {
  if(!isDefined(self.pers["gamemodeLoadout"])) {
    if(istrue(level._id_0CEBC8CC0640FE57.initialized)) {
      self.classcallback = ::_id_B606843C205D2DFC;
      return 1;
    }
  }

  return 0;
}

_id_B606843C205D2DFC() {
  if(!isDefined(self._id_B2F042BF9991295D)) {
    personality = self botgetpersonality();
    difficulty = self botgetdifficulty();
    _id_FAE37ABACD7BF535 = _id_4F1B939BBC96291B(personality, difficulty, "archetype_assault");
  }

  return scripts\engine\utility::ter_op(isDefined(level._id_0CEBC8CC0640FE57.loadouts[self._id_B2F042BF9991295D]), level._id_0CEBC8CC0640FE57.loadouts[self._id_B2F042BF9991295D], _id_70D701F63ACAB018());
}