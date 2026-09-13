/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2c075d80ec62e503.gsc
***********************************************/

_id_53AB5DD012D67963() {
  level._id_5F4060AAC4473EC4 = getEntArray("enemy_cam", "targetname");

  if(isDefined(level._id_5F4060AAC4473EC4) && level._id_5F4060AAC4473EC4.size > 0) {
    scripts\engine\utility::array_thread_amortized(level._id_5F4060AAC4473EC4, ::_id_35E7A47DCC0A0E1C, 0.1);
    scripts\engine\utility::array_thread_amortized(level._id_5F4060AAC4473EC4, ::_id_A159676F4A7D4782, 0.1);
    scripts\engine\utility::array_thread_amortized(level._id_5F4060AAC4473EC4, ::_id_06A99E314E438FE9, 0.1);
    _id_DB25531FE9AC9980();
  }
}

_id_DB25531FE9AC9980() {
  _id_71332A5B74214116::registerinteraction("enemy_cam_disable", ::_id_4639B73E8F9A49D7, ::_id_CD9C16FF4B5A2D18, ::_id_3C538DF6803129E2, 0);
  scripts\cp\coop_personal_ents::registerpentparams("enemy_cam_disable", "HINT_BUTTON", undefined, &"SNAKECAM/USE", undefined, "duration_long", "hide", 400, 65, 110, 65);
}

_id_3C538DF6803129E2(_id_25EEC91EDEF511DD) {
  level endon("game_ended");
  precacheshader("nightvision_overlay_goggles_grain");
  precacherumble("cp_wheelson_rumble");
  level.pentskipfov["enemy_cam_disable"] = 1;

  foreach(_id_DF071553D0996FF9 in _id_25EEC91EDEF511DD) {
    _id_DF071553D0996FF9.p_ent_skip_fov = 1;
    _id_DF071553D0996FF9._id_EC5AF0453BA54B22 = 1;
    _id_71332A5B74214116::remove_from_current_interaction_list(_id_DF071553D0996FF9);
    scripts\cp\coop_personal_ents::addtopersonalinteractionlist(_id_DF071553D0996FF9);
  }
}

_id_4639B73E8F9A49D7(_id_DF071553D0996FF9, player) {
  return &"SNAKECAM/USE";
}

_id_CD9C16FF4B5A2D18(_id_DF071553D0996FF9, player) {
  player endon("disconnect");

  if(!istrue(_id_DF071553D0996FF9._id_EC5AF0453BA54B22)) {
    return;
  }
  _id_DF071553D0996FF9._id_EC5AF0453BA54B22 = undefined;
  level notify("trigger_cam_disable");
}

_id_A159676F4A7D4782() {
  level endon("cameras_disabled");
  level endon("death");

  for(;;) {
    foreach(player in level.players) {
      if(player sightconetrace(self.origin, self))
        iprintln(" CAMERA SPOTTED A PLAYER!! ");
    }

    wait 0.5;
  }
}

_id_C625AC772B755445(start, dot, _id_95BFA6EAF973D593, _id_75BEA58D65510615) {
  self endon("death");

  if(!isDefined(dot))
    dot = 0.8;

  end = self.origin + anglesToForward(self.angles) * 1024;
  thread scripts\engine\utility::draw_line_for_time(start, end, 1, 0, 0, 5);
  results = scripts\engine\trace::ray_trace_detail(start, end, _id_75BEA58D65510615, scripts\engine\trace::create_character_contents());

  if(isDefined(results["entity"]) && isPlayer(results["entity"]))
    return 1;

  return 0;
}

_id_06A99E314E438FE9() {
  level endon("death");
  level endon("cameras_disabled");
  level waittill("trigger_cam_disable");
  wait 2;
  level notify("cameras_disabled");
}

_id_35E7A47DCC0A0E1C() {
  level endon("cameras_disabled");
  level endon("death");
  og_angles = self.angles;
  _id_DDB680F3984C4777 = -90;
  _id_A5337F8300110201 = 90;
  _id_CB6680317BE1E374 = 90;
  _id_0AAE6A37F78B5674 = 90;
  _id_183D5EEC52A67366 = og_angles[1] - _id_CB6680317BE1E374;
  _id_3C5DF5BF59ED9678 = og_angles[1] + _id_CB6680317BE1E374;
  _id_F7DC3A5FD9572B94 = og_angles[2] - _id_0AAE6A37F78B5674;
  _id_2EC0815DFA0F672E = og_angles[2] + _id_0AAE6A37F78B5674;
  _id_827ABACD5CA8F6B3 = 20;
  _id_594240552B896878 = 90;
  _id_440EBEEB83BD05A8 = 0.6;
  _id_75EB1524AFEB7F2B = 0.8;
  _id_C9FF6EEAAF645CEE = 10;
  _id_2FCA29730A69EE8A = 4;
  _id_E47AE22EC47FCEDB = 1.2;
  _id_D296B0EAF4A6B00F = [0, 0];
  _id_D5E6310914396AC3 = 0.2;
  _id_848E35F763CE65B0 = 0.2;
  _id_91AB80BC6772504D = 0;
  self hudoutlineenable("outlinefill_depth_cyan");

  for(;;) {
    _id_9DBC893FB4BE54F2 = og_angles;
    _id_B4F55166F66361E9 = self.angles;
    input = [-1, 1];
    _id_98EA5AFB293A76A2 = 0;
    _id_0E2DDA8FF32BB022 = (input[0], input[1], 0);
    _id_0E2DDA8FF32BB022 = length(_id_0E2DDA8FF32BB022);
    _id_5EB5724F78D37C4C = scripts\engine\math::factor_value(_id_848E35F763CE65B0, _id_D5E6310914396AC3, _id_0E2DDA8FF32BB022);
    _id_D296B0EAF4A6B00F[0] = scripts\engine\math::lerp(_id_D296B0EAF4A6B00F[0], input[0], _id_5EB5724F78D37C4C);
    _id_D296B0EAF4A6B00F[1] = scripts\engine\math::lerp(_id_D296B0EAF4A6B00F[1], input[1], _id_5EB5724F78D37C4C);

    if(_id_9DBC893FB4BE54F2[0] > 0 && _id_D296B0EAF4A6B00F[0] < 0)
      _id_13A3FD6DDFA8548F = 1 - scripts\engine\math::normalize_value(_id_A5337F8300110201 * _id_440EBEEB83BD05A8, _id_A5337F8300110201, _id_9DBC893FB4BE54F2[0]);
    else if(_id_9DBC893FB4BE54F2[0] < 0 && _id_D296B0EAF4A6B00F[0] > 0)
      _id_13A3FD6DDFA8548F = scripts\engine\math::normalize_value(_id_DDB680F3984C4777, _id_DDB680F3984C4777 * _id_440EBEEB83BD05A8, _id_9DBC893FB4BE54F2[0]);
    else
      _id_13A3FD6DDFA8548F = 1;

    if(_id_9DBC893FB4BE54F2[1] > og_angles[1] && _id_D296B0EAF4A6B00F[1] < 0)
      _id_8366082D034C6132 = 1 - scripts\engine\math::normalize_value(_id_3C5DF5BF59ED9678 - _id_CB6680317BE1E374 * _id_75EB1524AFEB7F2B, _id_3C5DF5BF59ED9678, _id_9DBC893FB4BE54F2[1]);
    else if(_id_9DBC893FB4BE54F2[1] < og_angles[1] && _id_D296B0EAF4A6B00F[1] > 0)
      _id_8366082D034C6132 = scripts\engine\math::normalize_value(_id_183D5EEC52A67366, _id_183D5EEC52A67366 + _id_CB6680317BE1E374 * _id_75EB1524AFEB7F2B, _id_9DBC893FB4BE54F2[1]);
    else
      _id_8366082D034C6132 = 1;

    _id_9210CEACE4810322 = _id_D296B0EAF4A6B00F[1] * -1;
    _id_181570543B8DA6F7 = _id_9DBC893FB4BE54F2[1] + _id_2FCA29730A69EE8A * _id_9210CEACE4810322 * _id_8366082D034C6132;

    if(_id_181570543B8DA6F7 > og_angles[1])
      _id_98EA5AFB293A76A2 = scripts\engine\math::normalized_float_smooth_out(scripts\engine\math::normalize_value(og_angles[1], _id_3C5DF5BF59ED9678, _id_181570543B8DA6F7)) * -1;

    if(_id_181570543B8DA6F7 < og_angles[1])
      _id_98EA5AFB293A76A2 = 1 - scripts\engine\math::normalized_float_smooth_in(scripts\engine\math::normalize_value(_id_183D5EEC52A67366, og_angles[1], _id_181570543B8DA6F7));

    _id_A810B9620521C338 = input[1];
    _id_D7F62313FFE99D1F = og_angles[2] + _id_594240552B896878 * _id_98EA5AFB293A76A2;
    _id_2EC0815DFA0F672E = _id_2EC0815DFA0F672E * _id_98EA5AFB293A76A2;
    _id_181570543B8DA6F7 = clamp(_id_181570543B8DA6F7, _id_183D5EEC52A67366, _id_3C5DF5BF59ED9678);
    _id_74EEDD477F94F3A3 = _id_D296B0EAF4A6B00F[0] * -1;
    _id_6BF51480C3252112 = _id_9DBC893FB4BE54F2[0] + _id_E47AE22EC47FCEDB * _id_74EEDD477F94F3A3 * _id_13A3FD6DDFA8548F;
    _id_BC4B977758B3324E = _id_DDB680F3984C4777;
    _id_2F22DF6828A1BCB0 = _id_A5337F8300110201;
    _id_6BF51480C3252112 = clamp(_id_6BF51480C3252112, _id_BC4B977758B3324E, _id_2F22DF6828A1BCB0);
    _id_6612315290576B0F = (_id_6BF51480C3252112, _id_181570543B8DA6F7, _id_D7F62313FFE99D1F);
    _id_122923B7FD027A6F = length(_id_6612315290576B0F - self.angles);
    _id_122923B7FD027A6F = scripts\engine\math::normalize_value(0, 1.5, _id_122923B7FD027A6F);
    _id_4D8CD161A8EAADC2 = scripts\engine\math::factor_value(0.0, 0.105, _id_122923B7FD027A6F);
    rumble = scripts\engine\math::factor_value(0.0, 0.08, _id_122923B7FD027A6F);
    volume = scripts\engine\math::factor_value(0.0, 0.2, _id_122923B7FD027A6F);
    height = 1 - rumble;
    height = height * 1000;
    self rotateTo(_id_6612315290576B0F, 2);
    _id_1B9B8DAF429DD199 = self.origin + anglesToForward(self.angles) * 12 + anglestoup(self.angles) * -55 + (0, 0, 3);
    wait 2;
  }
}