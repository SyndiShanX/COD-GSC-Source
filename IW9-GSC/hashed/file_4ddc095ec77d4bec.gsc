/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4ddc095ec77d4bec.gsc
***********************************************/

_id_3406446981D65075() {
  if(isDefined(level._id_C01235187BC88F5A)) {
    return;
  }
  level.brenableagents = 1;
  level._id_C01235187BC88F5A = spawnStruct();
  level._id_C01235187BC88F5A._id_2118CEB02F46444E = undefined;
  level._id_C01235187BC88F5A._id_7CB23C2A5A74276C = undefined;
  level._id_C01235187BC88F5A._id_1DD837B5846CBB91 = undefined;
  level._id_C01235187BC88F5A._id_698AB4F1074B4F37 = [];
  level._id_C01235187BC88F5A._id_B4D3F717373AF2BB = ["actor_enemy_lw_br", "actor_enemy_lw_br_german_african", "zombie"];
  level._id_C01235187BC88F5A _id_BFAD94B057BB2DC7();
  _id_7A4A1583DEE93A57();
  _id_5161C0D3D1CB2BE1();
  _id_FFE663A32F0C3894();
}

_id_BFAD94B057BB2DC7() {
  foreach(_id_DCF5E15C58C4152A in level._id_C01235187BC88F5A._id_B4D3F717373AF2BB) {
    _id_23612742081C7892(_id_DCF5E15C58C4152A, ::_id_FEAA195D2292FE08);
    _id_3257D640110B9F88(_id_DCF5E15C58C4152A, ::_id_50C4F7663D25B0EA);
    _id_2FFD98D8666852D5(_id_DCF5E15C58C4152A, ::_id_51185D036AEEFF9B);
  }
}

_id_FFE663A32F0C3894() {
  anim.grenadetimers["AI_gas_grenade_mp"] = randomintrange(0, 20000);
}

_id_7A4A1583DEE93A57() {
  _id_C3D15C9B07BB1E83 = [["molotov_explosion", "vfx/iw8/core/molotov/vfx_molotov_explosion.vfx"], ["molotov_explosion_child", "vfx/iw8/core/molotov/vfx_molotov_explosion_child.vfx"], ["vfx_burn_sml_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_low.vfx"], ["vfx_burn_sml_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_high.vfx"], ["vfx_burn_sml_head_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_head_low.vfx"], ["vfx_burn_med_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_low.vfx"], ["vfx_burn_med_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_high.vfx"], ["vfx_burn_lrg_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_low.vfx"], ["vfx_burn_lrg_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_high.vfx"]];

  if(!isDefined(level.g_effect))
    level.g_effect = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C3D15C9B07BB1E83.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(level.g_effect[_id_C3D15C9B07BB1E83[_id_AC0E594AC96AA3A8][0]]))
      level.g_effect[_id_C3D15C9B07BB1E83[_id_AC0E594AC96AA3A8][0]] = loadfx(_id_C3D15C9B07BB1E83[_id_AC0E594AC96AA3A8][1]);
  }
}

_id_5161C0D3D1CB2BE1() {
  if(!scripts\engine\utility::flag_exist("scriptables_ready"))
    scripts\engine\utility::flag_init("scriptables_ready");
}

_id_BC39F450BA654089(position, angles, type, _id_521FAC03E5F3A11B, team, _id_8AE63B0D643D4E2A, _id_8216C9148D9CF617) {
  if(!isDefined(angles))
    angles = (0, 0, 0);

  if(!isDefined(type))
    type = "enemy_lw_zombie_default";

  if(!isDefined(team))
    team = "team_two_hundred";

  spawner = spawnStruct();
  spawner.script_animation = _id_8AE63B0D643D4E2A;
  spawner.targetname = "spawnStruct";
  spawner.origin = position;
  _id_CAD65DF1D1EB2C93 = _id_633854BDBF5472F4::_id_40658AF2B14C86E6(type, position, angles, spawner, _id_521FAC03E5F3A11B, _id_8216C9148D9CF617);

  if(!isDefined(_id_CAD65DF1D1EB2C93)) {
    return;
  }
  _id_CAD65DF1D1EB2C93.guid = _id_CAD65DF1D1EB2C93 getguid();
  _id_CAD65DF1D1EB2C93._id_724FFB9C961617C9 = 1;
  _id_CAD65DF1D1EB2C93._id_F8E21465665E3F81 = 1;

  if(isDefined(level.brgametype) && level.brgametype.name == "zxp") {
    _id_CAD65DF1D1EB2C93 thread _id_E7EABD3326DF6A55();
    level._id_C01235187BC88F5A._id_698AB4F1074B4F37 = scripts\engine\utility::array_add(level._id_C01235187BC88F5A._id_698AB4F1074B4F37, _id_CAD65DF1D1EB2C93);
  }

  return _id_CAD65DF1D1EB2C93;
}

_id_F24DEF0754751AF7(value) {
  if(!isDefined(value) || value < 0) {
    return;
  }
  self.br_maxarmorhealth = value;
  self.br_armorhealth = value;
  _id_CE50C3E3E9D89E29 = self.br_armorhealth / self.br_maxarmorhealth;

  if(isPlayer(self)) {
    self setclientomnvar("ui_br_armor_damage", _id_CE50C3E3E9D89E29);
    scripts\mp\equipment\armor_plate::br_armor_plate_amount_equipped_set(self.br_armorhealth);
  }
}

_id_E7EABD3326DF6A55() {
  level endon("game_ended");
  self waittill("death");
  level._id_C01235187BC88F5A._id_698AB4F1074B4F37 = scripts\engine\utility::array_remove(level._id_C01235187BC88F5A._id_698AB4F1074B4F37, self);
}

_id_23612742081C7892(_id_DCF5E15C58C4152A, func) {
  if(!isDefined(_id_DCF5E15C58C4152A) || !isDefined(func)) {
    return;
  }
  if(!isDefined(level.agent_funcs)) {
    return;
  }
  level._id_C01235187BC88F5A._id_2118CEB02F46444E = func;
  level.agent_funcs[_id_DCF5E15C58C4152A]["on_damaged"] = func;
}

_id_3257D640110B9F88(_id_DCF5E15C58C4152A, func) {
  if(!isDefined(_id_DCF5E15C58C4152A) || !isDefined(func)) {
    return;
  }
  if(!isDefined(level.agent_funcs)) {
    return;
  }
  level._id_C01235187BC88F5A._id_7CB23C2A5A74276C = func;
  level.agent_funcs[_id_DCF5E15C58C4152A]["gametype_on_damage_finished"] = func;
}

_id_2FFD98D8666852D5(_id_DCF5E15C58C4152A, func) {
  if(!isDefined(_id_DCF5E15C58C4152A) || !isDefined(func)) {
    return;
  }
  level._id_C01235187BC88F5A._id_1DD837B5846CBB91 = func;
  level.agent_funcs[_id_DCF5E15C58C4152A]["gametype_on_killed"] = func;
}

_id_FEAA195D2292FE08(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  _id_BE4285B26ED99AB1 = idamage;

  if(istrue(self.zombie)) {
    if(smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE")
      idamage = idamage * getdvarfloat("dvar_BF750007EA105D69", 3.0);

    _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
  } else
    scripts\mp\mp_agent_damage::callbacksoldieragentdamaged(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, _id_BE4285B26ED99AB1);
}

_id_50C4F7663D25B0EA(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522) {
  if(isDefined(level._id_AFAD66D14C115E62)) {
    if(scripts\engine\utility::isbulletdamage(smeansofdeath)) {
      if(isPlayer(eattacker) || isbot(eattacker) || isagent(eattacker))
        self[[level._id_AFAD66D14C115E62]](eattacker, vpoint, self);
    }
  }

  if(!istrue(self.zombie))
    scripts\mp\mp_agent_damage::callbacksoldieragentgametypedamagefinished(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522);
  else
    _id_F8BC7A579195AEBC(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522);
}

_id_51185D036AEEFF9B(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration) {
  scripts\mp\mp_agent_damage::callbacksoldieragentgametypekilled(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration);
}

_id_F8BC7A579195AEBC(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522) {
  if(isDefined(self._id_353B862B77F0AD7E)) {
    if(istrue(self._id_6DAAD72C6C38E671))
      idamage = int(idamage * 0.5);

    self[[self._id_353B862B77F0AD7E]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, undefined, modelindex, partname);
    _id_02E24A83E3143E05(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522);

    if(isDefined(self._id_9BB84851FB85587A))
      [[self._id_9BB84851FB85587A]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522);
  }
}

_id_02E24A83E3143E05(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522) {
  if(_id_07C40FA80892A721::hasarmor()) {
    _id_87599197AC030074 = idamage;

    if(istrue(self.hashelmet) && (shitloc == "head" || shitloc == "helmet"))
      idamage = int(idamage * 0.07);

    if(isDefined(eattacker) && isPlayer(eattacker))
      eattacker playsoundtoplayer("hit_marker_3d_armor", eattacker);

    _id_07C40FA80892A721::armorvest_sethit(eattacker);
    _id_7B632FBAC637A958 = self.br_armorhealth - idamage;
    self.health = self.health + _id_87599197AC030074;
    self.br_armorhealth = self.br_armorhealth - idamage;

    if(scripts\engine\utility::sign(_id_7B632FBAC637A958) == -1) {
      idamage = int(abs(_id_7B632FBAC637A958));
      self.health = self.health - idamage;
    }

    if(self.br_armorhealth <= 0) {
      self.br_armorhealth = 0;
      _id_07C40FA80892A721::armorvest_setbroke(eattacker);

      if(isDefined(self._id_02749A2A95446437))
        _id_633854BDBF5472F4::_id_E9C30B87B59D7B2D(self._id_02749A2A95446437.model, self._id_02749A2A95446437.tag);

      if(isDefined(eattacker) && isPlayer(eattacker))
        eattacker playsoundtoplayer("hit_marker_3d_armor_break", eattacker);
    }
  }
}