/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_circuit_breaker.gsc
***********************************************/

initcircuitbreakers() {
  scripts\engine\utility::flag_init("cp_circuit_breakers_initted");
  _id_71332A5B74214116::registerinteraction("circuit_breaker_interact_point", ::hint_func, ::use_func, ::init_func, 0, "duration_short");
  script_model_anims();
}

hint_func(_id_DF071553D0996FF9, player) {
  if(isDefined(_id_DF071553D0996FF9.breaker) && _id_DF071553D0996FF9.breaker.isinuse)
    return "";

  _id_4B3EF90AAC593BAE = "";

  switch (_id_DF071553D0996FF9.breaker.breakerstate) {
    case "off":
    case "on":
      break;
    case "needsPriming":
      player.interaction_trigger sethinticon("icon_electrical_box");
      player.interaction_trigger setuseholdduration("duration_short");
      player.interaction_trigger sethintrequiresholding(0);
      _id_4B3EF90AAC593BAE = &"CP_OBJECTIVES/CIRCUIT_BREAKER_LEVER";
      break;
    case "primed":
      player.interaction_trigger sethintrequiresholding(0);
      player.interaction_trigger sethintrequiresmashing(0);
      player.interaction_trigger setuseholdduration("duration_short");
      player.interaction_trigger sethinticon("icon_electrical_box");
      _id_4B3EF90AAC593BAE = &"CP_OBJECTIVES/CIRCUIT_BREAKER_BUTTON";
      break;
  }

  if(!isDefined(_id_4B3EF90AAC593BAE))
    _id_4B3EF90AAC593BAE = &"COOP_GAME_PLAY/LIGHT_SWITCH";

  return _id_4B3EF90AAC593BAE;
}

init_func(_id_25EEC91EDEF511DD) {
  foreach(index, _id_DF071553D0996FF9 in _id_25EEC91EDEF511DD) {
    _id_DF071553D0996FF9.breaker = undefined;
    _id_E0363258BBE58529 = scripts\engine\utility::getStructArray(_id_DF071553D0996FF9.target, "targetname");

    foreach(_id_E01B90987C039740 in _id_E0363258BBE58529) {
      if(isDefined(_id_E01B90987C039740.script_noteworthy)) {
        if(_id_E01B90987C039740.script_noteworthy == "sceneNode") {
          _id_DF071553D0996FF9.scenenode = _id_E01B90987C039740;
          continue;
        }

        _id_E01B90987C039740.primesneeded = 0;
        _id_E01B90987C039740.buttonmashcount = 0;
        _id_E01B90987C039740.button = undefined;

        if(isDefined(_id_E01B90987C039740.target)) {
          _id_E01B90987C039740.button = scripts\engine\utility::getStruct(_id_E01B90987C039740.target, "targetname");

          if(isDefined(_id_E01B90987C039740.button)) {
            _id_E01B90987C039740.buttonmodel = spawn("script_model", _id_E01B90987C039740.button.origin);
            _id_E01B90987C039740.buttonmodel.angles = _id_E01B90987C039740.button.angles;
            _id_E01B90987C039740.buttonmodel setModel("button_on");
          }
        }

        types = strtok(_id_E01B90987C039740.script_noteworthy, ",");

        foreach(type in types) {
          values = strtok(_id_E01B90987C039740.script_noteworthy, "|");

          if(isDefined(values)) {
            if(values[0] == "primes") {
              if(isDefined(values[1]) && values[1] != "0")
                _id_E01B90987C039740.primesneeded = int(values[1]);
            }
          }
        }

        _id_DF071553D0996FF9.name = "circuit_breaker";
        _id_E01B90987C039740.isinuse = 0;
        _id_E01B90987C039740.playerusing = undefined;
        _id_E01B90987C039740.breakerstate = scripts\engine\utility::ter_op(_id_E01B90987C039740.primesneeded > 0, "needsPriming", "primed");
        _id_DF071553D0996FF9.breaker = _id_E01B90987C039740;
        _id_DF071553D0996FF9.scenenode.origin = scripts\cp\utility::get_point_in_local_ent_space(_id_DF071553D0996FF9.breaker, (24, -0.5, -56));
        _id_DF071553D0996FF9 thread waitformeleedamage();
      }
    }
  }

  scripts\engine\utility::flag_set("cp_circuit_breakers_initted");
}

waitformeleedamage() {
  level endon("game_ended");
  self endon("stop_waiting_for_melee");
  scripts\engine\utility::flag_wait("init_interaction_done");
  self.targetmodels[0] setCanDamage(1);

  for(;;) {
    self.targetmodels[0] waittill("damage", _id_97282C14346A7FCF, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, objweapon);

    if(isPlayer(eattacker) && smeansofdeath == "MOD_MELEE") {
      dobreakeractivation(self, eattacker, 1);
      self.targetmodels[0] setCanDamage(0);
      return;
    }
  }
}

use_func(_id_DF071553D0996FF9, player) {
  dobreakeractivation(_id_DF071553D0996FF9, player, 0);
  return 1;
}

dobreakeractivation(_id_DF071553D0996FF9, player, _id_FC3135014799C7BF) {
  if(!isDefined(_id_FC3135014799C7BF))
    _id_FC3135014799C7BF = 0;

  breaker = _id_DF071553D0996FF9.breaker;

  if(breaker.isinuse && breaker.playerusing != player)
    return 0;

  switch (breaker.breakerstate) {
    case "off":
      break;
    case "on":
      _id_DF071553D0996FF9 togglelightbutton("green");
      break;
    case "needsPriming":
      breaker.primesneeded--;
      breaker.buttonmashcount = 0;
      play_priming_anim(player, _id_DF071553D0996FF9, _id_FC3135014799C7BF);

      if(breaker.primesneeded > 0)
        play_reset_priming_anim(_id_DF071553D0996FF9);
      else {
        breaker.breakerstate = "primed";
        _id_DF071553D0996FF9 togglelightbutton("green");
      }

      breaker.isinuse = 0;
      thread waitformeleedamage();
      break;
    case "primed":
      play_priming_anim(player, _id_DF071553D0996FF9, _id_FC3135014799C7BF);
      _id_DF071553D0996FF9 togglelightbutton("red");
      breaker.breakerstate = "primed";
      _id_DF071553D0996FF9 _id_71332A5B74214116::remove_from_current_interaction_list(_id_DF071553D0996FF9);
      level notify("circuit_breaker_turned_on_for_" + _id_DF071553D0996FF9.name);

      if(isDefined(_id_DF071553D0996FF9.script_parameters))
        level notify("circuit_breaker_activated_" + _id_DF071553D0996FF9.script_parameters);

      if(isDefined(_id_DF071553D0996FF9.outputfunc))
        _id_DF071553D0996FF9 thread[[_id_DF071553D0996FF9.outputfunc]](_id_FC3135014799C7BF);

      player.interaction_trigger setHintString("");
      breaker.isinuse = 0;
      break;
  }
}

resetbreakertostate(breakerstate) {
  switch (breakerstate) {
    case "off":
      togglelightbutton("off");
      self.breaker.breakerstate = "off";
      self.targetmodels[0] setCanDamage(0);
      playsoundatpos(self.breaker.origin, "cp_fusebox_lever_off_npc");
      self notify("stop_waiting_for_melee");
      _id_71332A5B74214116::remove_from_current_interaction_list(self);
    case "on":
      togglelightbutton("green");
      self.breaker.breakerstate = "on";
      self.targetmodels[0] setCanDamage(0);
      playsoundatpos(self.breaker.origin, "cp_fusebox_lever_on_npc");
      self notify("stop_waiting_for_melee");
      _id_71332A5B74214116::remove_from_current_interaction_list(self);
      break;
    case "primed":
      playsoundatpos(self.breaker.origin, "cp_fusebox_lever_off_npc");
      togglelightbutton("red");
      self.breaker.breakerstate = "primed";
      thread waitformeleedamage();
      _id_71332A5B74214116::add_to_current_interaction_list(self);
      break;
    default:
      play_reset_priming_anim(self);
      togglelightbutton("red");
      self.breaker.breakerstate = "primed";
      thread waitformeleedamage();
      _id_71332A5B74214116::add_to_current_interaction_list(self);
      break;
  }
}

togglelightbutton(state) {
  if(!isDefined(self.breaker.buttonmodel)) {
    return;
  }
  switch (state) {
    case "off":
      self.breaker.buttonmodel setscriptablepartstate("target", "off");
      break;
    case "green":
      self.breaker.buttonmodel setscriptablepartstate("target", "green_light_blink");
      break;
    case "red":
      self.breaker.buttonmodel setscriptablepartstate("target", "active");
      break;
  }
}

resetcircuitbreakers(_id_DF071553D0996FF9, _id_344A59A34338BAE5) {
  _id_DF071553D0996FF9.breaker = undefined;
  _id_E0363258BBE58529 = scripts\engine\utility::getStructArray(_id_DF071553D0996FF9.target, "targetname");

  foreach(_id_E01B90987C039740 in _id_E0363258BBE58529) {
    if(isDefined(_id_E01B90987C039740.script_noteworthy)) {
      if(_id_E01B90987C039740.script_noteworthy == "sceneNode") {
        _id_DF071553D0996FF9.scenenode = _id_E01B90987C039740;
        continue;
      }

      _id_E01B90987C039740.primesneeded = 0;
      _id_E01B90987C039740.buttonmashcount = 0;
      _id_E01B90987C039740.button = undefined;

      if(isDefined(_id_E01B90987C039740.target)) {
        _id_E01B90987C039740.button = scripts\engine\utility::getStruct(_id_E01B90987C039740.target, "targetname");
        _id_E01B90987C039740.buttonmodel setModel("button_on");
      }

      types = strtok(_id_E01B90987C039740.script_noteworthy, ",");

      foreach(type in types) {
        values = strtok(_id_E01B90987C039740.script_noteworthy, "|");

        if(isDefined(values)) {
          if(values[0] == "primes") {
            if(isDefined(values[1]) && values[1] != "0")
              _id_E01B90987C039740.primesneeded = int(values[1]);
          }
        }
      }

      _id_DF071553D0996FF9.name = _id_344A59A34338BAE5;
      _id_E01B90987C039740.isinuse = 0;
      _id_E01B90987C039740.playerusing = undefined;
      _id_E01B90987C039740.breakerstate = "primed";
      _id_DF071553D0996FF9.breaker = _id_E01B90987C039740;
      script_model_anims();
    }
  }
}

watchforcircuitbreakertriggered(_id_DF071553D0996FF9) {
  _id_DF071553D0996FF9 notify("one_instance_for_struct");
  _id_DF071553D0996FF9 endon("one_instance_for_struct");
  self waittill("circuit_breaker_turned_on_for_" + _id_DF071553D0996FF9.name);
  iprintln(" PLAYERS HAVE TRIGGERED CIRCUIT BREAKER = ^9" + _id_DF071553D0996FF9.name);
  runlogicbasedoncircuitbreaker(_id_DF071553D0996FF9);
}

runlogicbasedoncircuitbreaker(struct) {
  _id_84B18482184CCD26 = level.current_cbreaker_sequence;
  _id_927B3199642B75FC = strtok(level.current_cbreaker_sequence, "_");
  _id_8A15E145FBBCC32B = scripts\cp\utility::getcloseststruct(struct.origin, "cb_val");
  name = int(_id_8A15E145FBBCC32B.name);

  switch (name) {
    case 1:
      if(struct.breaker.breakerstate == "on")
        _id_927B3199642B75FC[0] = "1";
      else if(struct.breaker.breakerstate == "needsPriming")
        _id_927B3199642B75FC[0] = "0";

      break;
    case 2:
      if(struct.breaker.breakerstate == "on")
        _id_927B3199642B75FC[1] = "1";
      else if(struct.breaker.breakerstate == "needsPriming")
        _id_927B3199642B75FC[1] = "0";

      break;
    case 4:
      if(struct.breaker.breakerstate == "on")
        _id_927B3199642B75FC[2] = "1";
      else if(struct.breaker.breakerstate == "needsPriming")
        _id_927B3199642B75FC[2] = "0";

      break;
    case 8:
      if(struct.breaker.breakerstate == "on")
        _id_927B3199642B75FC[3] = "1";
      else if(struct.breaker.breakerstate == "needsPriming")
        _id_927B3199642B75FC[3] = "0";

      break;
  }

  level.current_cbreaker_sequence = _id_927B3199642B75FC[0] + "_" + _id_927B3199642B75FC[1] + "_" + _id_927B3199642B75FC[2] + "_" + _id_927B3199642B75FC[3];
  iprintln(" ^4 binary sequence changed from ^1" + _id_84B18482184CCD26 + " ^4 to ^6" + level.current_cbreaker_sequence);
  level notify("input_sequence_changed");
}

watchforearlyprimeexit(player) {
  player endon("death");
  player endon("disconnect");
  player endon("set_interaction_point");

  while(player useButtonPressed())
    waitframe();

  player notify("left_early");
  player.last_interaction_point = undefined;
}

oninteractionstarted(_id_DF071553D0996FF9, _id_4BB133CFD5F393CE, player) {
  breaker = _id_DF071553D0996FF9.breaker;
  breaker.isinuse = _id_4BB133CFD5F393CE;
  breaker.playerusing = player;
}

#using_animtree("script_model");

script_model_anims() {
  level.scr_animtree["cbreakerrig"] = #animtree;
  level.scr_anim["cbreakerrig"]["prime"] = % wm_eq_fusebox_turn_on_plr;
  level.scr_animname["cbreakerrig"]["prime"] = "wm_eq_fusebox_turn_on_plr";
  level.scr_eventanim["cbreakerrig"]["prime"] = "eq_fusebox_turn_on_plr";
  level.scr_viewmodelanim["cbreakerrig"]["prime"] = "vm_eq_fusebox_turn_on_plr";
  level.scr_anim["cbreakerrig"]["reset_prime"] = % wm_eq_fusebox_plr;
  level.scr_animname["cbreakerrig"]["reset_prime"] = "wm_eq_fusebox_plr";
  level.scr_eventanim["cbreakerrig"]["reset_prime"] = "eq_fusebox_plr";
  level.scr_viewmodelanim["cbreakerrig"]["reset_prime"] = "vm_eq_fusebox_plr";
  level.scr_animtree["circuitbreaker"] = #animtree;
  level.scr_anim["circuitbreaker"]["prime"] = % wm_eq_fusebox_turn_on_prop;
  level.scr_animname["circuitbreaker"]["prime"] = "wm_eq_fusebox_turn_on_prop";
  level.scr_anim["circuitbreaker"]["reset_prime"] = % wm_eq_fusebox_prop;
  level.scr_animname["circuitbreaker"]["reset_prime"] = "wm_eq_fusebox_prop";
}

create_player_rig(player, animname, _id_486DB5FA512A3B6B) {
  if(!isDefined(player) || isDefined(player.player_rig)) {
    return;
  }
  player.animname = animname;

  if(!isDefined(_id_486DB5FA512A3B6B))
    _id_486DB5FA512A3B6B = "viewhands_base_iw8";

  player _meth_B88C89BB7CD1AB8E(player.origin);
  player_rig = spawn("script_arms", player.origin, 0, 0, player);
  player_rig.player = player;
  player.player_rig = player_rig;
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
  player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  player watch_remove_rig();
  remove_player_rig(player);
}

watch_remove_rig(struct) {
  scripts\engine\utility::waittill_any_4("remove_rig", "death", "disconnect", "end_early");
}

remove_player_rig(player) {
  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }
  player unlink();
  player setOrigin(player getdroptofloorposition(player.origin));
  player.player_rig delete();
  player.player_rig = undefined;
}

play_priming_anim(player, _id_DF071553D0996FF9, _id_F265C3675A498DCF) {
  player endon("disconnect");
  player endon("stop_playing_priming_anim");
  thread watchplayerdeath(player);
  _id_DF071553D0996FF9.targetmodels[0].animname = "circuitbreaker";
  _id_DF071553D0996FF9.targetmodels[0] useanimtree(#animtree);
  _id_DF071553D0996FF9.scenenode thread scripts\common\anim::anim_single_solo(_id_DF071553D0996FF9.targetmodels[0], "prime");

  if(!_id_F265C3675A498DCF) {
    thread create_player_rig(player, "cbreakerrig");
    player.linktoent = player scripts\engine\utility::spawn_tag_origin();
    player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0);
    player.linktoent moveTo(_id_DF071553D0996FF9.scenenode.origin, 0.25, 0.1, 0.1);
    _id_8B068D681C906E5C = scripts\engine\utility::ter_op(_id_DF071553D0996FF9.angles != (0, 0, 0), _id_DF071553D0996FF9.angles, (0, 0, 0));
    player.linktoent rotateTo(_id_8B068D681C906E5C, 0.25, 0.1, 0.1);
    player setstance("stand");
    player thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "prime");
    animlength = getanimlength(level.scr_anim["cbreakerrig"]["prime"]);
    _id_84D825D7E4A24FDE = 0.5;
    wait(max(0, animlength - _id_84D825D7E4A24FDE));
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
    player notify("remove_rig");
  }
}

play_reset_priming_anim(_id_DF071553D0996FF9) {
  _id_DF071553D0996FF9.targetmodels[0].animname = "circuitbreaker";
  _id_DF071553D0996FF9.targetmodels[0] useanimtree(#animtree);
  _id_DF071553D0996FF9.scenenode thread scripts\common\anim::anim_single_solo(_id_DF071553D0996FF9.targetmodels[0], "reset_prime");
  animlength = getanimlength(level.scr_anim["circuitbreaker"]["reset_prime"]);
  _id_84D825D7E4A24FDE = 0.5;
  wait(max(0, animlength - _id_84D825D7E4A24FDE));
}

stop_priming_gesture(player, _id_1D69B207056E4D33) {
  player enableweaponswitch();
  player switchtoweapon(_id_1D69B207056E4D33);
  player allowmelee(1);
}

watchplayerdeath(player) {
  self endon("breach_complete");
  self.cancelplant = 0;

  for(;;) {
    if(!isDefined(player) || !player scripts\cp_mp\utility\player_utility::_isalive()) {
      _id_EEB138FAE3842A92 = undefined;

      foreach(ent in self.ents) {
        foreach(_id_6C82D947757D13D6 in ent.parent.previewbomb) {
          if(_id_6C82D947757D13D6.script_label == "bomb_preview" || _id_6C82D947757D13D6.script_label == "bomb_preview_2")
            _id_EEB138FAE3842A92 = _id_6C82D947757D13D6;
        }
      }

      self.useobjects[_id_EEB138FAE3842A92.script_label] show();

      if(isDefined(self.plantedbomb)) {
        self.plantedbomb delete();
        self.plantedbomb = undefined;
      }

      self.cancelplant = 1;
      break;
    }

    waitframe();
  }
}

moveplayertotoppos(player) {
  player endon("death");
  player endon("disconnect");
  player setstance("stand");
  _id_599217E02A6DA3FA = scripts\engine\utility::spawn_tag_origin(player.origin, player.angles);
  _id_599217E02A6DA3FA thread cleanuplinkent(player);
  player playerlinktoblend(_id_599217E02A6DA3FA, "tag_origin", 0.75, 0.05, 0.05);
  _id_599217E02A6DA3FA rotateTo(self.targetangles, 0.72, 0.05, 0.05);
  _id_599217E02A6DA3FA moveTo(self.midpos, 0.6, 0.0, 0.0);
  wait 0.6;
  _id_599217E02A6DA3FA.origin = self.midpos;
  _id_599217E02A6DA3FA moveTo(self.targetpos, 0.2, 0.0, 0.0);
  wait 0.2;
  player unlink();
  snapplayertotoppos(player);
  player notify("ladder_move_finished");
}

snapplayertotoppos(player) {
  player setOrigin(self.targetpos);
  player setplayerangles(self.targetangles);
  player.angles = self.targetangles;
}

cleanuplinkent(player) {
  player scripts\engine\utility::waittill_any_3("death", "disconnect", "ladder_move_finished");
  self delete();
}

setoutputfunc(_id_E14AA40EFE174E81) {
  self.outputfunc = _id_E14AA40EFE174E81;
}