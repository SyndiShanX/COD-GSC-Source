/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\mp_dialogue.gsc
***********************************************/

main() {
  level.dialogue_playing = 0;
  level.current_dialogue = "";
  level._id_9A62261B5B534B06 = ::_id_7BDDE7F2158EC720;
  level._id_C3D9CEBA74248998 = ::_id_E174F6AE044C693E;
  level._id_1DA0697A602F5A04 = ::_id_46D1642A9A982A8A;
}

_id_E174F6AE044C693E(origin, radius, _id_BEB392BBB338D308, _id_41D8FABDCB0957BB) {
  if(isDefined(_id_41D8FABDCB0957BB) && !isarray(_id_41D8FABDCB0957BB))
    _id_41D8FABDCB0957BB = [_id_41D8FABDCB0957BB];

  if(_func_A794FCF9545F2062())
    return _func_B1EEF70090B5B7B5(origin, radius, _func_869CCB4E3451B8C6(["etype_player"]), _id_41D8FABDCB0957BB, _id_BEB392BBB338D308);

  return scripts\mp\utility\player::getplayersinradius(origin, radius, _id_BEB392BBB338D308, _id_41D8FABDCB0957BB);
}

_id_46D1642A9A982A8A(origin, radius, _id_BEB392BBB338D308, _id_41D8FABDCB0957BB) {
  if(isDefined(_id_41D8FABDCB0957BB) && !isarray(_id_41D8FABDCB0957BB))
    _id_41D8FABDCB0957BB = [_id_41D8FABDCB0957BB];

  if(_func_A794FCF9545F2062())
    return _func_B1EEF70090B5B7B5(origin, radius, _func_869CCB4E3451B8C6(["etype_ai"]), _id_41D8FABDCB0957BB, _id_BEB392BBB338D308);

  if(isDefined(_id_41D8FABDCB0957BB) && _id_41D8FABDCB0957BB.size)
    return scripts\engine\utility::array_remove_array(getaiarrayinradius(origin, radius, _id_BEB392BBB338D308), _id_41D8FABDCB0957BB);

  if(isDefined(_id_BEB392BBB338D308))
    return getaiarrayinradius(origin, radius, _id_BEB392BBB338D308);

  return getaiarrayinradius(origin, radius);
}

_id_7BDDE7F2158EC720(alias, _id_1626D989A1196F67) {
  _id_7D2852D02216C876 = self;

  if(isstruct(self) && isDefined(self._id_868E98CF48B92CFB))
    _id_7D2852D02216C876 = self._id_868E98CF48B92CFB;

  self notify("stop_dialogue");
  context = scripts\engine\utility::ter_op(istrue(self._id_ED56B39B72558E56), "dx_radio_3d");
  _id_7D2852D02216C876 thread _id_63A29FEE1A93C0A8(alias, context, _id_1626D989A1196F67);

  if(!istrue(self._id_54C1779B663E506A) && (isai(self) || istrue(self.fakeactor_face_anim))) {
    _id_E20C77B75B2A3F10 = _id_5D265B4FCA61F070::_id_6D4C7D2BD5969057(alias);

    if(isDefined(_id_E20C77B75B2A3F10))
      thread anim_facialanim(self, alias, _id_E20C77B75B2A3F10);
    else {
      intensity = _id_F7191829A1988DA5(alias);
      thread anim_facialfiller("stop_facialFiller", undefined, 0, undefined, intensity);
    }
  }

  _id_EA5C0ACCFC20EA48(alias);
  self notify("stop_facialFiller");
  return 1;
}

_id_EA5C0ACCFC20EA48(alias) {
  self endon("death");
  self endon("stop_dialogue");
  duration = lookupsoundlength(alias) / 1000;
  wait(duration);
}

_id_F7191829A1988DA5(alias) {
  if(isDefined(self._id_9AF882A4EF5986C0))
    return self._id_9AF882A4EF5986C0;

  _id_C59C1D18B26C886E = ["sm", "sm", "md", "lg"];
  intensity = scripts\engine\utility::_id_53C4C53197386572(_func_D159656D2B07F8A5(alias), 0);
  return _id_C59C1D18B26C886E[intensity];
}

_id_63A29FEE1A93C0A8(alias, context, _id_1626D989A1196F67) {
  if(isPlayer(_id_1626D989A1196F67))
    self playsoundtoplayer(alias, _id_1626D989A1196F67, self);
  else if(isstring(_id_1626D989A1196F67)) {
    if(isPlayer(self))
      self playsoundtoteam(alias, _id_1626D989A1196F67, self, self);
    else
      self playsoundtoteam(alias, _id_1626D989A1196F67, undefined, self);
  } else if(isarray(_id_1626D989A1196F67)) {
    foreach(_id_4C4DA56C076FE674 in _id_1626D989A1196F67)
    _id_63A29FEE1A93C0A8(alias, _id_4C4DA56C076FE674);
  } else if(isDefined(context))
    self playcontextsound(alias, "dx_type", context);
  else
    self playSound(alias, undefined, self);
}

anim_facialfiller(msg, looktarget, _id_F8048727716242B0, _id_F5B8C1160179B1F8, intensity) {
  intensity = scripts\engine\utility::_id_53C4C53197386572(intensity, "sm");
  self endon("death");
  self notify("newFacialAnim");

  if(!isDefined(_id_F5B8C1160179B1F8))
    _id_F5B8C1160179B1F8 = self;

  if(isai(self) && !isalive(self)) {
    return;
  }
  if(!isai(self)) {
    if(!isDefined(self.fakeactor_face_anim))
      return;
    else if(!self.fakeactor_face_anim || !isalive(self))
      return;
  }

  if(istrue(self.nofacialfiller)) {
    return;
  }
  if(!istrue(_id_F8048727716242B0) && !scripts\asm\shared\utility::isfacialstateallowed("filler")) {
    return;
  }
  if(isDefined(self.unittype) && (self.unittype == "c6" || self.unittype == "c8" || self.unittype == "c12")) {
    return;
  }
  _id_E3F91B8C2C172248 = 0.05;
  self notify("newLookTarget");
  self endon("newLookTarget");
  waittillframeend;

  if(!isDefined(looktarget) && isDefined(self.bc_looktarget))
    looktarget = self.bc_looktarget;

  archetype = scripts\asm\shared\utility::_id_2285421DFC79C4D5();
  _id_6B7315AEDC52F8E2 = self.defaulttalk;
  headknob = self.scriptedtalkingknob;
  scripts\asm\shared\utility::setfacialstate("filler");

  if(archetype != "") {
    if(isai(self))
      self setfacialindex("talk_" + intensity);
    else if(istrue(self._id_5247D15DA29E8539))
      scripts\asm\shared\utility::_id_EE3E5D584E317D35("talk_" + intensity);
    else
      scripts\asm\shared\utility::setfacialindexfornonai("talk_" + intensity);
  } else {
    self setanimknoblimitedrestart(_id_6B7315AEDC52F8E2, 1, 0, 1);
    self setanim(headknob, 5, 0.267);
  }

  _id_F5B8C1160179B1F8 waittill(msg);

  if(archetype != "" && isai(self))
    self setfacialindex("none");
  else if(istrue(self._id_5247D15DA29E8539) && isDefined(self._id_7A140EE03CFC699E))
    scripts\asm\shared\utility::_id_EE3E5D584E317D35("none");

  scripts\asm\shared\utility::clearfacialstate("filler");
}

anim_facialanim(guy, anime, _id_1945C9E13FCD068D) {
  guy endon("death");
  self endon(anime);
  _id_E3F91B8C2C172248 = 0.05;
  guy notify("newLookTarget");
  guy notify("newFacialAnim");
  scripts\asm\shared\utility::disabledefaultfacialanims();
  waittillframeend;

  if(!isDefined(self.scriptedtalkingknob))
    self.scriptedtalkingknob = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "scripted_talking"));

  _id_5ADB4AEC861050B6 = "scripted_face_" + anime;
  guy setanim(self.scriptedtalkingknob, 1, 0.2);
  guy setflaggedanimknobrestart(_id_5ADB4AEC861050B6, _id_1945C9E13FCD068D, 1, 0, 1);
  thread clearfaceanimonanimdone(guy, _id_5ADB4AEC861050B6, anime);
}

clearfaceanimonanimdone(guy, _id_5ADB4AEC861050B6, anime) {
  guy endon("death");
  guy endon("newFacialAnim");
  guy waittillmatch(_id_5ADB4AEC861050B6, "end");
  guy notify("scripted_face_done");
  _id_E3F91B8C2C172248 = 0.3;
  guy clearanim(self.scriptedtalkingknob, 0.2);
  scripts\asm\shared\utility::disabledefaultfacialanims(0);
}