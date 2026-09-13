/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4e0a3b3f9bedd99d.gsc
***********************************************/

_id_7E28B2B514A15CD3(statename, _id_5EDF43A8A1497A41, _id_A4B7AC07EEBB559F) {
  _id_1DAAAF7667F1282E();
  self attach(getweaponmodel(self.grenadeweapon), "TAG_ACCESSORY_LEFT");
  self._id_80EF2F6717602CBF = 1;
  thread _id_E92EEF96A100A073(statename, _id_5EDF43A8A1497A41, _id_A4B7AC07EEBB559F);
}

_id_48C8ACF993DAE2CC(asmname, statename, params) {
  self endon(statename + "_finished");
  self _meth_36C9CC1AACACC4A8();
  _id_7E28B2B514A15CD3(statename, params[0], params[1]);
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

_id_1DAAAF7667F1282E() {
  if(istrue(self._id_80EF2F6717602CBF)) {
    self detach(getweaponmodel(self.grenadeweapon), "TAG_ACCESSORY_LEFT");
    self._id_80EF2F6717602CBF = 0;
  }
}

_id_E92EEF96A100A073(statename, _id_5EDF43A8A1497A41, _id_A4B7AC07EEBB559F) {
  self endon("death");
  self endon(statename + "_finished");
  _id_9930AFEA4DE87021 = 0;

  while(!_id_9930AFEA4DE87021) {
    self waittill(statename, notes);

    if(!isarray(notes))
      notes = [notes];

    foreach(notetrack in notes) {
      if(notetrack == "grenade_throw" || notetrack == "grenade throw") {
        _id_9930AFEA4DE87021 = 1;
        continue;
      }

      if(notetrack == "end") {
        self._id_A3441D87A95E9040 _meth_A33073D6FD58E58E();
        self notify("dont_reduce_giptp_on_killanimscript");
        _id_9930AFEA4DE87021 = 1;
      }
    }
  }

  _id_1DAAAF7667F1282E();
  self notify("rusher_smokebomb_cleanup");
  self notify("rusher_smoke_bomb_thrown");

  if(issubstr(self.grenadeweapon.basename, "smoke")) {
    _id_83395E644C2F02B1 = anglesToForward(self.origin);

    if(isDefined(self.enemy))
      _id_83395E644C2F02B1 = self.enemy.origin - self.origin;

    _id_E4DFB6BB8C9C6C44 = randomfloatrange(_id_5EDF43A8A1497A41, _id_A4B7AC07EEBB559F);
    _id_49D42C23E5279E18 = rotatevector(_id_83395E644C2F02B1, (0, randomfloatrange(-5, 5), 0));
    _id_49D42C23E5279E18 = _id_E4DFB6BB8C9C6C44 * vectorNormalize(_id_49D42C23E5279E18);
    _id_87C2825D26C0F315 = self magicgrenademanual(self.origin + _id_49D42C23E5279E18 + (0, 0, 10), (0, 0, 15), 0.5);
  } else {
    _id_B1C462B90341E70E = (12.9077, 17.6221, 28.1187);
    throwtime = randomfloatrange(1.0, 1.5);
    _id_EDCB23EB9E6141BE = self checkgrenadethrowpos(_id_B1C462B90341E70E, self.enemy.origin, 0, "min time", "min energy");

    if(!isDefined(_id_EDCB23EB9E6141BE)) {
      _id_83395E644C2F02B1 = anglesToForward(self.origin);

      if(isDefined(self.enemy))
        _id_83395E644C2F02B1 = self.enemy.origin - self.origin;

      _id_E4DFB6BB8C9C6C44 = length(_id_83395E644C2F02B1) * randomfloatrange(0.95, 1.05);
      _id_49D42C23E5279E18 = rotatevector(_id_83395E644C2F02B1, (0, randomfloatrange(-5, 5), 0));
      _id_EDCB23EB9E6141BE = _id_E4DFB6BB8C9C6C44 / throwtime * vectorNormalize(_id_49D42C23E5279E18) + (0, 0, 200);
    }

    _id_87C2825D26C0F315 = self magicgrenademanual(self.origin + _id_B1C462B90341E70E, _id_EDCB23EB9E6141BE, throwtime);
  }

  _id_87C2825D26C0F315.owner = self;
  _id_87C2825D26C0F315.weapon_name = self.grenadeweapon.basename;
  _id_3251B898A0907271 = scripts\asm\soldier\throwgrenade::getdesiredgrenadetimervalue();
  scripts\asm\soldier\throwgrenade::setgrenadetimer(min(gettime() + 3000, _id_3251B898A0907271));
  _id_A15426692301F3F0 = self.enemy;

  if(isDefined(_id_A15426692301F3F0) && scripts\asm\soldier\throwgrenade::usingplayergrenadetimer()) {
    _id_A15426692301F3F0 _meth_E89F2BDB307F137E();
    thread scripts\asm\soldier\throwgrenade::reducegiptponkillanimscript(statename, _id_A15426692301F3F0);

    if(self._id_CC183DF556F63DA0 == "lethal") {
      if(_id_A15426692301F3F0 _meth_4C108309DC0D7FD2() <= 1)
        _id_A15426692301F3F0 _meth_FF4AA047884E7A14(gettime());
    }
  }

  if(self.grenadeweapon.basename == "smoke_bomb_rusher_mp")
    _id_D93415244E99E763(_id_87C2825D26C0F315.origin, _id_87C2825D26C0F315.angles, getdvarint("dvar_5D839447A2947C11", 1) == 1);
  else if(issubstr(self.grenadeweapon.basename, "molotov")) {
    _id_87C2825D26C0F315 thread scripts\mp\shellshock::grenade_earthquake();
    thread scripts\mp\equipment\molotov::molotov_used(_id_87C2825D26C0F315);
  }
}

_id_D93415244E99E763(position, angles, _id_BA447DF20DBBBF8A, _id_98A85CEFA4F1A7AF) {
  if(!istrue(_id_98A85CEFA4F1A7AF))
    wait 0.5;

  if(getdvarint("dvar_F784BDC2AB0EEDDE", 0) == 1) {
    if(getdvarint("dvar_ABE45E35EF030A56") == 1)
      scripts\common\ai::_id_8A09C0E5FA78A48C(position);
    else
      thread scripts\mp\bots\bots::create_smoke_occluder(position);
  }

  thread _id_160D327D81FF0CCE(position);
  _id_F1E6C3CE07C301F7 = spawnscriptable("grenade_smoke_v0_rusher_mp_fx", position, angles);
  _id_F1E6C3CE07C301F7 thread _id_9EAEFF99BBE830E7(self);

  if(_id_BA447DF20DBBBF8A)
    thread _id_FA704B58059A64B6(position, self, self.team, 4.5, 0.25);
}

_id_CA247899DBBCF9A4(position) {
  playFX(self._id_705E2628D263EE2C, position, anglestoup((0, 90, 0)));
}

_id_9EAEFF99BBE830E7(owner) {
  self setscriptablepartstate("sfx_smoke_bomb", "sfx_expl");
  wait 0.25;
  self setscriptablepartstate("sfx_smoke_bomb", "sfx_smoke_fade_out");
  wait 4;
  self freescriptable();
}

_id_160D327D81FF0CCE(position) {
  level endon("game_ended");
  wait 1;
  id = scripts\mp\utility\outline::addoutlineoccluder(position, 64);
  wait 5.1;
  scripts\mp\utility\outline::removeoutlineoccluder(id);
}

_id_FA704B58059A64B6(position, owner, team, duration, scale) {
  if(!isDefined(duration))
    duration = 4.5;

  if(!isDefined(scale))
    scale = 1;

  trigger = spawn("trigger_radius", position + (0, 0, int(-57.75 * scale)), 0, int(256 * scale), int(175 * scale));
  trigger scripts\cp_mp\ent_manager::registerspawn(1, scripts\mp\equipment\gas_grenade::sweepgas);
  trigger endon("death");
  trigger.owner = owner;
  trigger.team = team;
  trigger.playersintrigger = [];
  trigger._id_AEECA2BC23F59EA4 = [];
  trigger thread gas_watchtriggerenter();
  trigger thread scripts\mp\equipment\gas_grenade::gas_watchtriggerexit();
  wait(duration);
  trigger thread scripts\mp\equipment\gas_grenade::gas_destroytrigger();
}

gas_watchtriggerenter() {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      if(isagent(player)) {
        if(player != self.owner && player.team != self.team) {
          if(!scripts\engine\utility::array_contains(self._id_AEECA2BC23F59EA4, player) || isDefined(player.flashendtime) && player.flashendtime < gettime()) {
            self._id_AEECA2BC23F59EA4[self._id_AEECA2BC23F59EA4.size] = player;

            if(isDefined(player._id_65771500F49956C1) && player._id_65771500F49956C1) {
              continue;
            }
            player notify("flashbang", player.origin, 1, 1, self.owner, self.team, 9);
          }
        }
      }

      continue;
    }

    if(player scripts\mp\utility\killstreak::isjuggernaut()) {
      continue;
    }
    if(scripts\mp\equipment\gas_grenade::_id_DA8A31143B88E833(player)) {
      continue;
    }
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isDefined(self.playersintrigger[player getentitynumber()])) {
      continue;
    }
    if(level.teambased) {
      if(isDefined(self.owner) && isalive(self.owner)) {
        if(player != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(player, self.owner))
          continue;
      } else if(scripts\mp\utility\player::isfriendly(self.team, player))
        continue;
    }

    self.playersintrigger[player getentitynumber()] = player;
    player thread scripts\mp\equipment\gas_grenade::gas_onentertrigger(self);
  }
}

_id_B4BD334ECEC6C6C8(asmname, statename, params) {
  if(!istrue(self._id_E0C57AF70D480252))
    self._id_F44C9CEDE4FB20D6 = 0;

  scripts\asm\soldier\melee::playmeleechargesound();
  self._id_5185ACCFC2476D43 = 1;
  self._id_001F91D3DA0786A2 = 1;
  scripts\asm\soldier\melee::playmeleeanim_vsplayer(asmname, statename, params);
}