/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_hc_true_voice.gsc
***************************************************************/

main() {
  common_scripts\utility::flag_init("flag_nest_hc_ee_true_voice_entered");
  wait 1;
  _id_0557::_id_4BC9("true voice of god", "unlocking true voice", "CONST_HC_ANALYTICS_TRUE_VOICE_OF_GOD");
  _id_0557::_id_4BC9("barbarossa gem reveal", "revealing barb gem", "CONST_HC_ANALYTICS_BARB_GEM_REVEAL");
  var_0 = _id_52EF();
  common_scripts\utility::_id_3C9F("flag_nest_hc_ee_pub_kills_collected");
  var_0 _id_A6DB();
  level._id_357F common_scripts\utility::_id_9D9F();
  var_0 _id_A646();
  var_0 _id_6A7B();
}

scragentclearpath() {
  level._id_0797 = 1;
}

_id_744B() {
  return common_scripts\utility::_id_562E(level._id_0797);
}

_id_6A7B() {
  self["god_gem"] show();
  level notify("end hilt grabbed", self["god_gem"]._id_5AFC.origin);

  foreach(var_1 in level.players) {
    if(var_1 maps\mp\mp_zombie_nest_ee_util::_id_7403())
      var_1 thread _id_2EAA();
  }

  self["god_gem"] moveto(self["god_gem"]._id_5AFC.origin, 5, 1, 1);
  _playfxontag(level._effect["nest_ee_hc_gem_fx"], self["god_gem"], "tag_origin");
  _id_0557::_id_4BC8("barbarossa gem reveal");
  common_scripts\utility::flag_set("flag_nest_hc_ee_true_voice_entered");
  wait 5;
  _id_0557::_id_4BC8("true voice of god");
  self["god_gem"] delete();

  if(isDefined(level._id_4D74)) {
    var_3 = common_scripts\utility::_id_46B5("raven_progress", "targetname");
    level._id_4D74 delete();
    level._id_4D74 = _id_0547::_id_8FBA(var_3, "zmb_hilt_sphere_hc");
    _triggerfx(level._id_4D74);
  }

  scragentclearpath();
  voicereward();
}

_id_2EAA() {
  wait 3;
  _id_0367::_id_8E3C("gemdiscovered_both");
}

_id_42EE() {
  return "flag_nest_hc_ee_true_voice_entered";
}

_id_A6DB() {
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("7 Voice paintings", "enter code pieces"));
  var_0 = maps\mp\mp_zombie_nest_ee_paintings::_id_43CC();
  common_scripts\utility::_id_3C7B(var_0);
  wait 3;
  maps\mp\mp_zombie_nest_ee_paintings::_id_3664(1);
  level._id_357F sethintstring(&"ZOMBIE_NEST_AMP_CONFIRM_CODE");
  common_scripts\utility::_id_3C9F(var_0);
}

_id_A646() {
  self["chandelier_trig"] _id_A726(["teslagun_zm_moon", "teslagun_zm_blood", "teslagun_zm_storm", "teslagun_zm_death"]);
}

_id_A726(var_0) {
  var_1 = [];
  var_2 = 0;
  playFX(level._effect["chandeleier_raven_idle"], self.origin);

  while(!var_2) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    level thread common_scripts\_exploder::_id_088E(216);

    if(common_scripts\utility::_id_0F79(var_0, var_12)) {
      var_13 = _id_40EF(var_12);
      _id_0378::_id_8D74("aud_shoot_chandelier");
      level thread common_scripts\_exploder::_id_088E(var_13);
      var_14 = _id_9E14(var_0, var_12);
      var_2 = common_scripts\utility::_id_562E(var_14);
      wait 0.5;
      level thread common_scripts\_exploder::_id_088E(227);
    }
  }
}

_id_40EF(var_0) {
  var_1 = "";

  switch (var_0) {
    case "teslagun_zm_moon":
      var_1 = 223;
      break;
    case "teslagun_zm_blood":
      var_1 = 224;
      break;
    case "teslagun_zm_death":
      var_1 = 225;
      break;
    case "teslagun_zm_storm":
      var_1 = 226;
      break;
  }

  return var_1;
}

_id_9E14(var_0, var_1, var_2) {
  self endon("chandelier_timed_out");

  if(isDefined(var_2))
    thread _id_20B1(var_2);

  var_3 = [var_1];

  while(var_3.size < var_0.size) {
    self waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(common_scripts\utility::_id_0F79(var_0, var_13) && !common_scripts\utility::_id_0F79(var_3, var_13)) {
      var_3 = common_scripts\utility::_id_0F6F(var_3, var_13);
      var_14 = _id_40EF(var_13);
      _id_0378::_id_8D74("aud_shoot_chandelier");
      level thread common_scripts\_exploder::_id_088E(var_14);
    }
  }

  self notify("chandelier_success_shot");
  return 1;
}

voicereward() {
  foreach(var_1 in level.players)
  var_1 _id_054C::_id_AC23("truevoice");
}

_id_20B1(var_0) {
  wait(var_0);
  self notify("chandelier_timed_out");
}

_id_52EF() {
  var_0 = [];
  var_1 = common_scripts\utility::_id_46B5("nest_hc_mural_challenge", "targetname");
  var_2 = getEntArray(var_1.target, "targetname");
  var_0["chandelier_trig"] = _getent("nest_hc_mural_chandelier", "script_noteworthy");
  var_0["god_gem"] = undefined;
  var_3 = common_scripts\utility::_id_46B5("klauses_stone", "script_noteworthy");
  var_0["god_gem"] = spawn("script_model", var_3.origin);
  var_0["god_gem"] setModel("zmb_hilt_sword_gem_01");
  var_0["god_gem"] hide();
  var_0["god_gem"]._id_5AFC = common_scripts\utility::_id_46B5(var_3.target, "targetname");
  return var_0;
}