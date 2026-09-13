/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_44b8991c2b01716a.gsc
***********************************************/

init() {
  if(!_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED()) {
    return;
  }
  level._id_103A870683641C69._id_8336FB035950FE34 = spawnStruct();
  level._id_103A870683641C69._id_8336FB035950FE34._id_E4841D3C199D8C76 = [];
  level._id_103A870683641C69._id_8336FB035950FE34._id_477D6D6831833CEF = [];
  level._id_103A870683641C69._id_8336FB035950FE34._id_9CD34562C355C3B7 = [];
  level._id_103A870683641C69._id_8336FB035950FE34.callbacks = [];
  level._id_103A870683641C69._id_8336FB035950FE34._id_302E82DA1A1989AD = clamp(getdvarfloat("dvar_642A00B7321FEB16", 0.2), 0.0, 1.0);
  level._id_103A870683641C69._id_8336FB035950FE34._id_B1EC4A78F00693D6 = clamp(getdvarfloat("dvar_E7007F08D33E2708", 0.1), 0.0, 1.0);
  level._id_103A870683641C69._id_8336FB035950FE34._id_B6BD40FEBE604DB6 = [];
  _id_09395058A6122108 = _id_7C3CA1E9F4969566();

  foreach(_id_EDA120484DE9DC8F in _id_09395058A6122108._id_86EBBC9E8822BFF2)
  level._id_103A870683641C69._id_8336FB035950FE34._id_9CD34562C355C3B7[_id_EDA120484DE9DC8F.ref] = _id_F5626CB7773F40CC(_id_EDA120484DE9DC8F.ref, _id_EDA120484DE9DC8F.bink, _id_EDA120484DE9DC8F._id_919903B00986E1B6, istrue(_id_EDA120484DE9DC8F._id_58AD068EEE2B00F7));

  foreach(_id_EDA120484DE9DC8F in _id_09395058A6122108._id_33CE77C893269C05)
  level._id_103A870683641C69._id_8336FB035950FE34._id_9CD34562C355C3B7[_id_EDA120484DE9DC8F.ref] = _id_F5626CB7773F40CC(_id_EDA120484DE9DC8F.ref, _id_EDA120484DE9DC8F.bink, _id_EDA120484DE9DC8F._id_919903B00986E1B6, istrue(_id_EDA120484DE9DC8F._id_58AD068EEE2B00F7));

  _id_098B53A7358927D9::_id_9BC69C26770D9533(::_id_9BE36C7FAF40104F);
  scripts\engine\utility::flag_set("jump_scares_ready");
}

_id_CCEA398392B4BF1C(ref, callback) {
  if(!_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED() || !scripts\engine\utility::flag("jump_scares_ready")) {
    return;
  }
  level._id_103A870683641C69._id_8336FB035950FE34.callbacks[ref] = callback;
}

_id_B9D0A8240617803B(ref) {
  if(!_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED() || !scripts\engine\utility::flag("jump_scares_ready")) {
    return;
  }
  level._id_103A870683641C69._id_8336FB035950FE34.callbacks[ref] = undefined;
}

_id_4B08B735EB2C690A(ref, _id_308EF4770401CC00, callback) {
  if(!_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED() || !scripts\engine\utility::flag("jump_scares_ready")) {
    return;
  }
  _id_EDA120484DE9DC8F = level._id_103A870683641C69._id_8336FB035950FE34._id_9CD34562C355C3B7[_id_308EF4770401CC00];

  if(isDefined(_id_EDA120484DE9DC8F))
    _id_EDA120484DE9DC8F.callbacks[ref] = callback;
}

_id_1FD0CF48D61CFB71(ref, _id_308EF4770401CC00) {
  if(!_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED() || !scripts\engine\utility::flag("jump_scares_ready")) {
    return;
  }
  _id_EDA120484DE9DC8F = level._id_103A870683641C69._id_8336FB035950FE34._id_9CD34562C355C3B7[_id_308EF4770401CC00];

  if(isDefined(_id_EDA120484DE9DC8F))
    _id_EDA120484DE9DC8F.callbacks[ref] = undefined;
}

_id_0F7FE427D574911C(ref, player, _id_7421408D2C5F4F2F, _id_998E44AA54F46731, alpha, _id_2C198D7DEBFA83B4) {
  if(!_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED() || !scripts\engine\utility::flag("jump_scares_ready"))
    return 0;

  if(_id_43ADD3AB185F3E51(ref, player, _id_7421408D2C5F4F2F, _id_998E44AA54F46731)) {
    _id_EDA120484DE9DC8F = level._id_103A870683641C69._id_8336FB035950FE34._id_9CD34562C355C3B7[ref];
    thread _id_D1E23C923958F6B9(player, _id_EDA120484DE9DC8F._id_37643A0DB3E20430, _id_EDA120484DE9DC8F.audio, alpha, _id_2C198D7DEBFA83B4);

    if(!istrue(_id_998E44AA54F46731))
      thread _id_EDF2C8BDA9343E81(player);

    foreach(callback in level._id_103A870683641C69._id_8336FB035950FE34.callbacks)
    thread[[callback]](ref, player);

    foreach(callback in _id_EDA120484DE9DC8F.callbacks)
    thread[[callback]](player);

    return 1;
  }

  return 0;
}

_id_0B67F0B02F25B1AF(player, _id_7421408D2C5F4F2F, _id_998E44AA54F46731, alpha, _id_2C198D7DEBFA83B4) {
  if(!_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED() || !scripts\engine\utility::flag("jump_scares_ready"))
    return 0;

  _id_DAB12564D8FDBE0B = player getentitynumber();

  if(!isDefined(level._id_103A870683641C69._id_8336FB035950FE34._id_477D6D6831833CEF[_id_DAB12564D8FDBE0B])) {
    _id_477D6D6831833CEF = spawnStruct();
    _id_477D6D6831833CEF._id_9CD34562C355C3B7 = [];
    _id_477D6D6831833CEF._id_BB75696CF7617115 = 0;
    index = 0;

    foreach(_id_308EF4770401CC00, _id_8E195B75D2195EA4 in level._id_103A870683641C69._id_8336FB035950FE34._id_9CD34562C355C3B7) {
      if(!istrue(_id_8E195B75D2195EA4._id_58AD068EEE2B00F7)) {
        continue;
      }
      _id_477D6D6831833CEF._id_9CD34562C355C3B7[index] = _id_308EF4770401CC00;
      index++;
    }

    _id_477D6D6831833CEF._id_9CD34562C355C3B7 = scripts\engine\utility::array_randomize(_id_477D6D6831833CEF._id_9CD34562C355C3B7);
    level._id_103A870683641C69._id_8336FB035950FE34._id_477D6D6831833CEF[_id_DAB12564D8FDBE0B] = _id_477D6D6831833CEF;
  }

  _id_477D6D6831833CEF = level._id_103A870683641C69._id_8336FB035950FE34._id_477D6D6831833CEF[_id_DAB12564D8FDBE0B];
  _id_308EF4770401CC00 = _id_477D6D6831833CEF._id_9CD34562C355C3B7[_id_477D6D6831833CEF._id_BB75696CF7617115];

  if(_id_0F7FE427D574911C(_id_308EF4770401CC00, player, _id_7421408D2C5F4F2F, _id_998E44AA54F46731, alpha, _id_2C198D7DEBFA83B4)) {
    _id_477D6D6831833CEF._id_BB75696CF7617115++;

    if(_id_477D6D6831833CEF._id_BB75696CF7617115 >= _id_477D6D6831833CEF._id_9CD34562C355C3B7.size) {
      _id_477D6D6831833CEF._id_BB75696CF7617115 = 0;
      scripts\engine\utility::array_randomize(_id_477D6D6831833CEF._id_9CD34562C355C3B7);
    }

    return 1;
  }

  return 0;
}

_id_D1E23C923958F6B9(player, _id_37643A0DB3E20430, audio, alpha, _id_2C198D7DEBFA83B4) {
  level endon("game_ended");

  if(!isDefined(alpha))
    alpha = 1.0;

  alpha = floor(clamp(alpha, 0.0, 1.0) * 100.0);
  _id_5C9DDCF56D36F133 = int(istrue(_id_2C198D7DEBFA83B4)) + (int(alpha) << 1);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    player setclientomnvar("ui_br_bink_overlay_bitfield", _id_5C9DDCF56D36F133);
    player setclientomnvar("ui_br_bink_overlay_state", 14);
  } else
    player setclientomnvar("ui_mp_bink_overlay_state", _id_5C9DDCF56D36F133);

  player playcinematicforplayer(_id_37643A0DB3E20430);

  if(soundexists(audio))
    player playlocalsound(audio);

  player scripts\engine\utility::waittill_any_timeout_2(10, "bink_complete", "death_or_disconnect");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    player setclientomnvar("ui_br_bink_overlay_state", 0);
  else
    player setclientomnvar("ui_mp_bink_overlay_state", 0);

  player stopcinematicforplayer();
}

_id_F5626CB7773F40CC(ref, _id_37643A0DB3E20430, audio, _id_58AD068EEE2B00F7) {
  _id_4C0F90DE4334210E = spawnStruct();
  _id_4C0F90DE4334210E._id_37643A0DB3E20430 = _id_37643A0DB3E20430;
  _id_4C0F90DE4334210E.audio = audio;
  _id_4C0F90DE4334210E._id_58AD068EEE2B00F7 = _id_58AD068EEE2B00F7;
  _id_4C0F90DE4334210E.callbacks = [];
  _id_4C0F90DE4334210E._id_302E82DA1A1989AD = clamp(getdvarfloat(_func_2EF675C13CA1C4AF("dvar_684ADBE33C32718B", ref), 1.0), 0.0, 1.0);
  _id_4C0F90DE4334210E._id_B1EC4A78F00693D6 = clamp(getdvarfloat(_func_2EF675C13CA1C4AF("dvar_443EB76891B08455", ref), 0.1), 0.0, 1.0);
  _id_4C0F90DE4334210E._id_B6BD40FEBE604DB6 = [];
  return _id_4C0F90DE4334210E;
}

_id_43ADD3AB185F3E51(ref, player, _id_7421408D2C5F4F2F, _id_998E44AA54F46731) {
  if(!_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED())
    return 0;

  if(istrue(player.isjuggernaut))
    return 0;

  _id_DAB12564D8FDBE0B = player getentitynumber();

  if(!istrue(_id_998E44AA54F46731) && istrue(level._id_103A870683641C69._id_8336FB035950FE34._id_E4841D3C199D8C76[_id_DAB12564D8FDBE0B]))
    return 0;

  _id_EDA120484DE9DC8F = level._id_103A870683641C69._id_8336FB035950FE34._id_9CD34562C355C3B7[ref];

  if(!isDefined(_id_EDA120484DE9DC8F))
    return 0;

  if(!istrue(_id_7421408D2C5F4F2F)) {
    if(_id_EDA120484DE9DC8F._id_302E82DA1A1989AD < 1.0) {
      if(!isDefined(_id_EDA120484DE9DC8F._id_B6BD40FEBE604DB6[_id_DAB12564D8FDBE0B]))
        _id_EDA120484DE9DC8F._id_B6BD40FEBE604DB6[_id_DAB12564D8FDBE0B] = 0;

      if(randomfloat(1.0) > _id_EDA120484DE9DC8F._id_302E82DA1A1989AD + _id_EDA120484DE9DC8F._id_B6BD40FEBE604DB6[_id_DAB12564D8FDBE0B] * _id_EDA120484DE9DC8F._id_B1EC4A78F00693D6) {
        _id_EDA120484DE9DC8F._id_B6BD40FEBE604DB6[_id_DAB12564D8FDBE0B]++;
        return 0;
      }

      _id_EDA120484DE9DC8F._id_B6BD40FEBE604DB6[_id_DAB12564D8FDBE0B] = undefined;
    } else if(level._id_103A870683641C69._id_8336FB035950FE34._id_302E82DA1A1989AD < 1.0) {
      if(!isDefined(level._id_103A870683641C69._id_8336FB035950FE34._id_B6BD40FEBE604DB6[_id_DAB12564D8FDBE0B]))
        level._id_103A870683641C69._id_8336FB035950FE34._id_B6BD40FEBE604DB6[_id_DAB12564D8FDBE0B] = 0;

      if(randomfloat(1.0) > level._id_103A870683641C69._id_8336FB035950FE34._id_302E82DA1A1989AD + level._id_103A870683641C69._id_8336FB035950FE34._id_B6BD40FEBE604DB6[_id_DAB12564D8FDBE0B] * level._id_103A870683641C69._id_8336FB035950FE34._id_B1EC4A78F00693D6) {
        level._id_103A870683641C69._id_8336FB035950FE34._id_B6BD40FEBE604DB6[_id_DAB12564D8FDBE0B]++;
        return 0;
      }

      level._id_103A870683641C69._id_8336FB035950FE34._id_B6BD40FEBE604DB6[_id_DAB12564D8FDBE0B] = undefined;
    }
  }

  return 1;
}

_id_7C3CA1E9F4969566() {
  _id_25EA48876F86D21E = getscriptbundle("enum_78460D3D1ADB5865");
  return _id_25EA48876F86D21E;
}

_id_EDF2C8BDA9343E81(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  _id_DAB12564D8FDBE0B = player getentitynumber();
  _id_080A38F44B08D29B = getdvarfloat("dvar_7A2B51F4615759D3", 30.0);
  level._id_103A870683641C69._id_8336FB035950FE34._id_E4841D3C199D8C76[_id_DAB12564D8FDBE0B] = 1;
  wait(_id_080A38F44B08D29B);
  level._id_103A870683641C69._id_8336FB035950FE34._id_E4841D3C199D8C76[_id_DAB12564D8FDBE0B] = undefined;
}

_id_9BE36C7FAF40104F(_id_7148C1A6F25491F8, value) {
  if(_id_7148C1A6F25491F8 == "bink_complete")
    self notify("bink_complete");
}