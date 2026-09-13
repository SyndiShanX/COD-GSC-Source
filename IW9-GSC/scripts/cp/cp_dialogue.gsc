/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_dialogue.gsc
***********************************************/

main() {
  level.dialogue_playing = 0;
  level.current_dialogue = "";
  level._id_9A62261B5B534B06 = ::_id_7C1AFBF215D163DE;
  level._id_C3D9CEBA74248998 = ::_id_E136E2AE04079980;
  level._id_1DA0697A602F5A04 = ::_id_46B7602A9A7BF8B4;
}

_id_E136E2AE04079980(origin, radius, _id_BEB392BBB338D308, _id_41D8FABDCB0957BB) {
  if(isDefined(_id_41D8FABDCB0957BB) && !isarray(_id_41D8FABDCB0957BB))
    _id_41D8FABDCB0957BB = [_id_41D8FABDCB0957BB];

  if(_func_A794FCF9545F2062())
    return _func_B1EEF70090B5B7B5(origin, radius, _func_869CCB4E3451B8C6(["etype_player"]), _id_41D8FABDCB0957BB, _id_BEB392BBB338D308);

  return scripts\cp\utility\player::getplayersinradius(origin, radius, _id_BEB392BBB338D308, _id_41D8FABDCB0957BB);
}

_id_46B7602A9A7BF8B4(origin, radius, _id_BEB392BBB338D308, _id_41D8FABDCB0957BB) {
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

play_vo_to_all(alias, _id_B040AAF18AFE0139) {
  if(isDefined(_id_B040AAF18AFE0139))
    wait(_id_B040AAF18AFE0139);

  if(istrue(level.dialogue_playing)) {
    return;
  }
  level.dialogue_playing = 1;
  level.announcer_vo_playing = 1;
  level.current_dialogue = alias;

  foreach(player in level.players) {
    player.battlechatterallowed = 0;
    thread play_vo_to_player(player, alias);
  }

  wait(_id_166B4F052DA169A7::get_sound_length(alias));

  foreach(player in level.players)
  player.battlechatterallowed = 1;

  level.dialogue_playing = 0;
  level.announcer_vo_playing = 0;
  level.current_dialogue = "";
}

play_vo_to_player(player, alias) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");

  if(istrue(player.dialogue_playing)) {
    return;
  }
  player.dialogue_playing = 1;
  player.current_dialogue = alias;

  if(isarray(alias))
    alias = scripts\engine\utility::random(alias);

  if(soundexists(alias)) {
    player playlocalsound(alias);
    wait(_id_166B4F052DA169A7::get_sound_length(alias));
  }

  player.dialogue_playing = 0;
  player.current_dialogue = "";
}

stop_current_dialogue() {
  if(istrue(level.dialogue_playing)) {
    foreach(player in level.players) {
      player stoplocalsound(player.current_dialogue);
      player.dialogue_playing = 0;
    }

    level.dialogue_playing = 0;
  }
}

_id_7C1AFBF215D163DE(alias, _id_1626D989A1196F67) {
  _id_7D2852D02216C876 = self;

  if(isstruct(self) && isDefined(self._id_868E98CF48B92CFB))
    _id_7D2852D02216C876 = self._id_868E98CF48B92CFB;

  self notify("stop_dialogue");
  _id_7D2852D02216C876 thread _id_06B4248F9A3F02E2(alias, _id_1626D989A1196F67);

  if(!istrue(self._id_54C1779B663E506A)) {
    if(isPlayer(self)) {
      intensity = _id_F7191829A1988DA5(alias);
      thread _id_1A57CD89E2331BBE("stop_facialFiller", intensity);
    } else if(isai(self) || istrue(self.fakeactor_face_anim)) {
      _id_E20C77B75B2A3F10 = _id_5D265B4FCA61F070::_id_6D4C7D2BD5969057(alias);

      if(isDefined(_id_E20C77B75B2A3F10))
        thread anim_facialanim(self, alias, _id_E20C77B75B2A3F10);
      else {
        intensity = _id_F7191829A1988DA5(alias);
        thread anim_facialfiller("stop_facialFiller", undefined, 0, undefined, intensity);
      }
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

_id_06B4248F9A3F02E2(alias, _id_1626D989A1196F67) {
  if(isPlayer(self)) {
    _id_93FA9B11F85EC1A9 = self;

    foreach(player in level.players) {
      if(!isDefined(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(player == self) {
        _id_93FA9B11F85EC1A9 _meth_480DEAF73792CCF1(alias, "dx_type", "dx_player", player);
        continue;
      }

      context = _id_315CE8400F242845(alias, player, _id_93FA9B11F85EC1A9);
      _id_93FA9B11F85EC1A9 _meth_480DEAF73792CCF1(alias, "dx_type", context, player);
    }
  } else if(isPlayer(_id_1626D989A1196F67))
    self playsoundtoplayer(alias, _id_1626D989A1196F67, self);
  else if(isstring(_id_1626D989A1196F67)) {
    if(isPlayer(self))
      self playsoundtoteam(alias, _id_1626D989A1196F67, self, self);
    else
      self playsoundtoteam(alias, _id_1626D989A1196F67, undefined, self);
  } else if(isarray(_id_1626D989A1196F67)) {
    foreach(_id_4C4DA56C076FE674 in _id_1626D989A1196F67)
    _id_06B4248F9A3F02E2(alias, _id_4C4DA56C076FE674);
  } else {
    if(istrue(self._id_ED56B39B72558E56)) {
      self playcontextsound(alias, "dx_type", "dx_radio_3d");
      return;
    }

    self playSound(alias, undefined, self);
  }
}

_id_315CE8400F242845(alias, player, _id_93FA9B11F85EC1A9) {
  if(isDefined(player._id_EDAB10CE7BDB9C99))
    return player._id_EDAB10CE7BDB9C99;

  if(player _meth_6F55D55CCFF20D14())
    return "dx_radio_2d";

  if(istrue(level._id_D017B9C13EC2BB69) || getdvarint("dvar_89F9BE00D776A8A9", 0)) {
    origin = _id_93FA9B11F85EC1A9.origin;

    if(isPlayer(_id_93FA9B11F85EC1A9))
      origin = origin + (0, 0, 60);

    contents = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0);
    result = scripts\engine\trace::ray_trace(player.origin + (0, 0, 60), origin, undefined, contents, 0, 1, 0);

    if(result["hittype"] != "hittype_none")
      return "dx_radio_2d";
  }

  _id_2E6E4390DC1C2FD9 = _id_2FD08032ADB24C07(alias);

  if(!isDefined(_id_2E6E4390DC1C2FD9))
    return "dx_radio_2d";

  _id_7F92A5190DFFD8C1 = distancesquared(player.origin + (0, 0, 60), _id_93FA9B11F85EC1A9.origin);
  return scripts\engine\utility::ter_op(_id_7F92A5190DFFD8C1 < squared(_id_2E6E4390DC1C2FD9), "dx_open_air", "dx_radio_2d");
}

_id_2FD08032ADB24C07(alias) {
  if(isDefined(level._id_CB329546ED01D21A) && isDefined(level._id_CB329546ED01D21A[alias]))
    return level._id_CB329546ED01D21A[alias];

  _id_465E9BE55E97AEE6 = _func_405CA75FC1A4EC12(alias);

  if(!isDefined(_id_465E9BE55E97AEE6))
    return undefined;

  return _id_465E9BE55E97AEE6 * 0.33;
}

_id_1A57CD89E2331BBE(msg, intensity) {
  switch (intensity) {
    case "lg":
      intensity = 1;
      break;
    case "md":
      intensity = 2;
      break;
    case "sm":
    default:
      intensity = 3;
  }

  self _meth_DDB86DA3E575E652(intensity);
  self waittill(msg);
  self _meth_DDB86DA3E575E652(0);
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