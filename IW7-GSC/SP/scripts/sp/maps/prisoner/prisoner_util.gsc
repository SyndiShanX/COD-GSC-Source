/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\prisoner\prisoner_util.gsc
******************************************************/

_id_D2F9(var_0) {
  var_1 = _id_77C4(var_0);
  level.player setOrigin(var_1.origin);
  level.player setplayerangles(var_1.angles);
}

_id_106B5(var_0, var_1, var_2, var_3, var_4) {
  var_3 = _id_2289(var_3);

  if(getdvarint("dropship_lighting", 0)) {
    var_5 = _id_0BBF::_id_106B8(var_0, undefined, var_2, var_3, undefined, var_4);
    var_5 _id_0BBF::_id_106BA(0, 1);
    var_5 _id_0BBF::_id_F37F("right_cockpit");
    var_5 _id_0BBF::_id_F457();
    level._id_5D6C = var_5;
    level waittill("forever");
  }

  var_5 = _id_0BBF::_id_106B8(var_0, var_1, var_2, var_3, undefined, var_4);
  var_5 _id_0BBF::_id_106BA(0, 1);
  var_5 _id_0BBF::_id_F37F("right_cockpit");
  var_5 _id_0BBF::_id_F457();
  var_5 setmaxpitchroll(5, 3);
  var_5 _id_5DB0();
  var_5._id_4D94._id_1FC0 = [];
  var_5._id_4D94._id_5A0C = [];
  var_5._id_4D94.fx["atmosphere_burn"] = [];

  foreach(var_7 in var_5._id_4D94._id_C743) {
    if(!isDefined(var_7._id_EE52)) {
      continue;
    }
    switch (var_7._id_EE52) {
      case "gator_chair":
        var_5._id_4D94._id_1FC0["salter"] = var_7;
        break;
      case "atom_chair":
        var_5._id_4D94._id_1FC0["atom"] = var_7;
        break;
      case "copilot_chair":
        var_5._id_4D94._id_1FC0["brooks"] = var_7;
        break;
      case "redshirt_chair":
        var_5._id_4D94._id_1FC0["redshirt"] = var_7;
        break;
      case "player_chair":
        var_5._id_4D94._id_1FC0["player_rig"] = var_7;
        break;
      case "atom_jump":
        var_5._id_4D94._id_1FC0["atom_jump"] = var_7;
        break;
      case "ds2_crash2":
      case "ds2_crash1":
        if(!isDefined(var_5._id_4D94._id_1FC0["ds2_crash_nodes"]))
          var_5._id_4D94._id_1FC0["ds2_crash_nodes"] = [];

        var_5._id_4D94._id_1FC0["ds2_crash_nodes"] = scripts\engine\utility::array_add(var_5._id_4D94._id_1FC0["ds2_crash_nodes"], var_7);
        break;
      case "turret":
        var_5.turret = spawnturret("misc_turret", (0, 0, 0), "dropship_turret");
        var_5.turret setModel("tag_origin");
        var_5.turret linkTo(var_7, "tag_origin", (0, 0, 0), (0, 0, 180));
        var_5.turret setmode("manual");
        var_5.turret makeunusable();
        var_5.turret maketurretsolid();
        var_5.turret setdefaultdroppitch(25.0);
        break;
      case "doorfire_left":
        var_5._id_4D94._id_5A0C["left"] = var_7;
        break;
      case "doorfire_right":
        var_5._id_4D94._id_5A0C["right"] = var_7;
        break;
      case "fx_atmosphere_burn":
        var_5._id_4D94.fx["atmosphere_burn"] = scripts\engine\utility::array_add(var_5._id_4D94.fx["atmosphere_burn"], var_7);
        break;
      case "snd_wing_engine_left":
        level._id_10395 = var_7;
        var_8 = "dropship_wing_engine_pos_l_lp";
        break;
      case "snd_wing_engine_right":
        level._id_10396 = var_7;
        var_8 = "dropship_wing_engine_pos_r_lp";
        break;
      case "snd_forward_engine_left":
        level._id_1038B = var_7;
        var_8 = "dropship_forward_engine_pos_l_lp";
        break;
      case "snd_forward_engine_right":
        level._id_1038C = var_7;
        var_8 = "dropship_forward_engine_pos_r_lp";
        break;
      case "snd_rear_engine_left":
        level._id_10393 = var_7;
        var_8 = "dropship_rear_engine_pos_l_lp";
        break;
      case "snd_rear_engine_right":
        level._id_10394 = var_7;
        var_8 = "dropship_rear_engine_pos_r_lp";
        break;
      case "snd_int_rear_left":
        level._id_10391 = var_7;
        var_8 = "dropship_rear_int_pos_l_lp";
        break;
      case "snd_int_rear_right":
        level._id_10392 = var_7;
        var_8 = "dropship_rear_int_pos_r_lp";
        break;
      case "snd_int_mid_left":
        level._id_1038F = var_7;
        var_8 = "dropship_wing_int_pos_l_lp";
        break;
      case "snd_int_mid_right":
        level._id_10390 = var_7;
        var_8 = "dropship_wing_int_pos_r_lp";
        break;
      case "snd_int_cockpit":
        level._id_1038E = var_7;
        var_8 = "dropship_cockpit_int_pos_lp";
        break;
      case "snd_int_center":
        level._id_1038D = var_7;
        var_8 = "dropship_fly_atmos_lp";
        break;
      case "enemy_board1":
        var_5._id_4D94._id_1FC0["enemy_board1"] = var_7;
        break;
      case "enemy_board2":
        var_5._id_4D94._id_1FC0["enemy_board2"] = var_7;
        break;
      default:
        break;
    }
  }

  foreach(var_7 in var_5._id_4D94._id_C744) {
    if(!isDefined(var_7._id_EE52)) {
      continue;
    }
    switch (var_7._id_EE52) {
      case "barrier_bars":
        var_5._id_4D94._id_2853 = var_7;
        break;
      default:
        break;
    }
  }

  var_5 scripts\sp\utility::_id_65E0("ent_flag_arrived");
  var_5 scripts\sp\utility::_id_65E0("ent_flag_lookat");
  var_5 scripts\sp\utility::_id_65E0("ent_flag_ally_left");
  var_5 scripts\sp\utility::_id_65E0("ent_flag_clear_lookat");
  var_5._id_1D2A = [];

  foreach(var_13 in var_5._id_4D94._id_127C9) {
    if(isDefined(var_13.targetname) && issubstr(var_13.targetname, "ally")) {
      if(issubstr(var_13.targetname, "left")) {
        var_5._id_1D2A["left"] = var_13;
        continue;
      }

      if(issubstr(var_13.targetname, "right")) {
        var_5._id_1D2A["right"] = var_13;
        continue;
      }

      if(issubstr(var_13.targetname, "back"))
        var_5._id_1D2A["back"] = var_13;
    }
  }

  return var_5;
}

_id_5E6F(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  self playLoopSound(var_0);
}

_id_5EC2(var_0) {
  switch (var_0) {
    default:
      break;
  }
}

_id_5DB0() {
  self setyawspeed(60, 25, 15, 0);
  self sethoverparams(0, 0, 0);
}

_id_11685(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level._id_545A))
    level._id_545A = [];

  var_3 = 0;

  for(;;) {
    if(!isDefined(level._id_545A[var_3])) {
      break;
    }

    var_3++;
  }

  var_4 = "^3";

  if(!isDefined(var_2))
    var_2 = 1;

  var_2 = max(1, var_2);
  level._id_545A[var_3] = 1;
  var_5 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_5.location = 0;
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.foreground = 1;
  var_5.sort = 20;
  var_5.alpha = 0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 1;
  var_5.x = 40;
  var_5.y = 260 + var_3 * 18;
  var_5.label = " " + var_4 + "< " + var_0 + " > ^7" + var_1;
  var_5.color = (1, 1, 1);
  wait(var_2);
  var_6 = 10.0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 0;

  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_5.color = (1, 1, 0 / (var_6 - var_7));
    wait 0.05;
  }

  wait 0.25;
  var_5 destroy();
  level._id_545A[var_3] = undefined;
}

_id_546C(var_0, var_1, var_2) {
  level notify("notify_stop_dialogue_nag");
  level endon("notify_stop_dialogue_nag");

  if(!scripts\engine\utility::flag_exist("flag_dialogue_nag_active"))
    scripts\engine\utility::flag_init("flag_dialogue_nag_active");

  scripts\engine\utility::flag_clear("flag_dialogue_nag_active");

  if(isDefined(var_0))
    var_0 = _id_2289(var_0);
  else
    var_0 = [];

  if(isDefined(var_2))
    var_2 = _id_2289(var_2);
  else
    var_2 = [];

  foreach(var_4 in var_0)
  scripts\sp\utility::_id_10350(var_4);

  var_6 = [];
  var_7 = 0;
  var_8 = randomfloatrange(5, 8);

  for(;;) {
    scripts\engine\utility::waitframe();

    if(var_1.size == 0) {
      continue;
    }
    if(var_7 >= var_8) {
      if(var_6.size == 0)
        var_6 = var_1;

      var_9 = scripts\engine\utility::random(var_6);
      var_6 = scripts\engine\utility::array_remove(var_6, var_9);
      var_7 = 0;
      var_8 = randomfloatrange(5, 8);
      childthread _id_11D9(var_9);
    }

    if(!scripts\engine\utility::flag("flag_dialogue_nag_active"))
      var_7 = var_7 + 0.05;
  }

  if(var_2.size > 0) {
    wait 0.5;
    scripts\sp\utility::_id_10352(scripts\engine\utility::random(var_2));
  }

  level notify("notify_stop_dialogue_nag");
}

_id_11D8(var_0) {
  level endon("notify_stop_dialogue_nag");
  scripts\engine\utility::flag_set("flag_dialogue_nag_active");
  scripts\sp\utility::_id_10350(var_0);
  scripts\engine\utility::flag_clear("flag_dialogue_nag_active");
}

_id_5490(var_0, var_1, var_2, var_3) {
  var_4 = ["prisoner_brk_putthespotlighton", "prisoner_brk_ineedthespotlight", "prisoner_brk_reesegetthatspot"];
  var_5 = ["prisoner_brk_thanks", "prisoner_brk_thanks2", "prisoner_brk_thankscaptain"];
  level notify("notify_stop_dialogue_spotlight");
  level endon("notify_stop_dialogue_spotlight");

  if(!scripts\engine\utility::flag_exist("flag_spotlight_nag_active"))
    scripts\engine\utility::flag_init("flag_spotlight_nag_active");

  scripts\engine\utility::flag_clear("flag_spotlight_nag_active");

  if(isDefined(var_1))
    var_1 = _id_2289(var_1);
  else
    var_1 = [];

  if(isDefined(var_2))
    var_2 = _id_2289(var_2);
  else
    var_2 = var_4;

  if(isDefined(var_3))
    var_3 = _id_2289(var_3);
  else
    var_3 = var_5;

  foreach(var_7 in var_1)
  scripts\sp\utility::_id_10350(var_7);

  scripts\engine\utility::waitframe();
  level notify("notify_spotlight_intro_done");
  scripts\engine\utility::waitframe();
  level notify("notify_spotlight_intro_done");
  var_9 = [];
  var_10 = 0;
  var_11 = randomfloatrange(5, 8);

  if(level._id_5D6C _id_10A8B(var_0)) {
    level notify("notify_spotlight_on_target");
    return;
  }

  while(!level._id_5D6C _id_10A8B(var_0)) {
    scripts\engine\utility::waitframe();

    if(var_2.size == 0) {
      continue;
    }
    if(var_10 >= var_11) {
      if(var_9.size == 0)
        var_9 = var_2;

      var_12 = scripts\engine\utility::random(var_9);
      var_9 = scripts\engine\utility::array_remove(var_9, var_12);
      var_10 = 0;
      var_11 = randomfloatrange(5, 8);
      childthread _id_11D9(var_12);
    }

    if(!scripts\engine\utility::flag("flag_spotlight_nag_active"))
      var_10 = var_10 + 0.05;
  }

  if(var_3.size > 0) {
    wait 0.5;
    scripts\sp\utility::_id_10352(scripts\engine\utility::random(var_3));
  }

  level notify("notify_spotlight_on_target");
}

_id_11D9(var_0) {
  level endon("notify_spotlight_on_target");
  scripts\engine\utility::flag_set("flag_spotlight_nag_active");
  scripts\sp\utility::_id_10350(var_0);
  scripts\engine\utility::flag_clear("flag_spotlight_nag_active");
}

_id_10A8B(var_0) {
  return _id_12A0A(var_0, 0.99, 1);
}

_id_12A0B(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_6 = var_5;

    if(isent(var_5))
      var_6 = var_5.origin;

    if(_id_12A0A(var_6, var_1, var_2, var_3))
      return 1;
  }

  return 0;
}

_id_12A0A(var_0, var_1, var_2, var_3) {
  if(isent(var_0))
    var_0 = var_0.origin;

  var_4 = vectorNormalize(var_0 - self.turret.origin);
  var_5 = anglesToForward(self.turret gettagangles("tag_flash"));
  var_6 = vectordot(var_4, var_5);

  if(var_6 < var_1)
    return 0;

  if(isDefined(var_2))
    return 1;

  var_7 = bulletTrace(var_0, self.turret.origin, 0, var_3);
  return var_7["fraction"] == 1;
}

_id_5EB0() {
  playFXOnTag(scripts\engine\utility::getfx("pnr_dropship_spotlight"), self.turret, "tag_origin");
}

_id_5EAF() {
  killfxontag(scripts\engine\utility::getfx("pnr_dropship_spotlight"), self.turret, "tag_origin");
}

_id_5E36() {
  for(;;)
    scripts\engine\utility::waitframe();
}

_id_5EA2(var_0, var_1) {
  self notify("stop_dropship_set_spotlight");
  self endon("stop_dropship_set_spotlight");
  self endon("death");

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(self._id_10A97))
    self._id_10A97 = scripts\engine\utility::spawn_tag_origin();

  _id_5EAF();
  scripts\engine\utility::delaythread(1, ::_id_5EB0);
  self.turret settargetentity(self._id_10A97);

  if(!var_1) {
    self._id_10A8C = _id_2289(self._id_10A8C);

    if(self._id_10A8C[0] == level.player)
      childthread _id_5EB2(var_0);
    else
      childthread _id_5EB1(var_0);

    return;
  }

  if(!isDefined(var_0)) {
    self._id_10A97 unlink();
    return;
  }

  _id_5EB6(var_0);
}

_id_5EB2(var_0) {
  for(;;) {
    var_1 = anglesToForward(level.player getplayerangles());
    var_2 = scripts\common\trace::ray_trace(level.player.origin, level.player.origin + var_1 * 10000, undefined, scripts\common\trace::create_contents(0, 1, 1, 0, 0, 0));

    if(isDefined(var_2["position"]))
      self._id_10A97 moveTo(var_2["position"], 3);
    else
      self._id_10A97 moveTo(level.player.origin + var_1 * 100000, 3);

    wait 0.1;
  }
}

_id_5EB1(var_0) {
  var_1 = 0;

  while(isDefined(var_0)) {
    var_2 = undefined;

    foreach(var_4 in self._id_10A8C) {
      if(isDefined(var_4.enemy)) {
        var_2 = var_4;
        break;
      }
    }

    if(isDefined(var_2)) {
      var_6 = var_2.enemy;

      while(isDefined(var_2.enemy) && var_2.enemy == var_6 && self._id_10A97.origin != var_6.origin) {
        self._id_10A97 moveTo(var_6.origin, 3);
        wait 0.1;
      }

      continue;
    }

    if(var_1)
      _id_5EB6(var_0);

    wait 0.1;
  }
}

_id_5EB6(var_0) {
  childthread _id_1240(var_0);
}

_id_1240(var_0) {
  if(isarray(var_0)) {
    self._id_10A97 moveTo(var_0, 3);
    return;
  }

  while(isDefined(var_0)) {
    self._id_10A97 moveTo(var_0.origin, 3);
    wait 0.1;
  }
}

_id_5D75(var_0) {
  if(isDefined(self._id_1D19) && self._id_1D19 == var_0) {
    return;
  }
  scripts\sp\utility::_id_F39E();
  self._id_1D2A[var_0] notify("trigger");
  scripts\sp\utility::_id_F39F();
  self._id_1D19 = var_0;
}

_id_10616(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = _id_229B(getEntArray("actors", "script_noteworthy"), ::_id_3DD0);

  if(isDefined(var_0)) {
    var_0 = _id_2289(var_0);
    var_3 = [];
    var_4 = [];

    foreach(var_6 in var_0) {
      var_7 = strtok(var_6, "!");

      if(var_7[0] != var_6) {
        var_3 = scripts\engine\utility::array_add(var_3, var_7[0]);
        continue;
      }

      var_4 = scripts\engine\utility::array_add(var_4, var_6);
    }

    var_2 = _id_229E(var_2, var_4);
    var_2 = _id_229D(var_2, var_3);
  }

  if(isDefined(level._id_1684))
    level._id_1684 = scripts\engine\utility::array_removeundefined(level._id_1684);
  else
    level._id_1684 = [];

  var_9 = [];

  foreach(var_6, var_11 in var_2)
  _id_10615(var_6, var_11, var_1);
}

_id_10615(var_0, var_1, var_2) {
  var_3 = ["Lopez", "Jewels", "Thompson", "Myers", "Rocket", "Ozz", "Dayo", "Hall", "Drown", "PI"];
  var_1 scripts\sp\utility::_id_1747(::_id_1088D);
  var_4 = undefined;

  switch (var_0) {
    case "brooks":
      if(isDefined(level._id_30F6)) {
        return;
      }
      var_1._id_EDB8 = "Brooks";
      var_4 = var_1 scripts\sp\utility::_id_10619(var_2);
      var_4._id_1FBB = "brooks";
      level._id_30F6 = var_4;
      break;
    case "august":
      if(isDefined(level._id_2612)) {
        return;
      }
      var_1._id_EDB8 = "Auguste";
      var_4 = var_1 scripts\sp\utility::_id_10619(var_2);
      var_4._id_1FBB = "generic";
      var_4 scripts\sp\utility::_id_86E4();
      level._id_2612 = var_4;
      break;
    case "atom":
      if(isDefined(level._id_2429)) {
        return;
      }
      var_1._id_EDB8 = "Ethan";
      var_4 = var_1 scripts\sp\utility::_id_10619(var_2);
      var_4._id_1FBB = "atom";
      level._id_2429 = var_4;
      var_4 scripts\sp\utility::_id_72EC("iw7_m4", "primary");
      break;
    case "salter":
      if(isDefined(level._id_EA2C)) {
        return;
      }
      var_1._id_EDB8 = "Salter";
      var_4 = var_1 scripts\sp\utility::_id_10619(var_2);
      var_4._id_1FBB = "salter";
      level._id_EA2C = var_4;
      break;
    case "hvt":
      if(isDefined(level._id_920F)) {
        return;
      }
      var_1._id_EDB8 = "Riah";
      var_4 = var_1 scripts\sp\utility::_id_10619(var_2);
      var_4._id_1FBB = "hvt";
      var_4 thread scripts\sp\utility::_id_F2DA(0);
      var_4 scripts\sp\utility::_id_5504();
      var_4._id_1C78 = 0;
      var_4._id_C012 = 1;
      var_4 scripts\sp\utility::_id_65E0("entflag_churchroad");
      var_4 _meth_8504(1, "soldier");
      level._id_920F = var_4;
      break;
    default:
  }

  var_4 _meth_839E();
  level._id_1684 = scripts\engine\utility::array_add(level._id_1684, var_4);
  var_1.count = 1;
}

_id_3DD0() {
  return isspawner(self);
}

_id_1088D(var_0) {
  scripts\sp\utility::_id_B14F();
  self._id_8E27 = 1;
  _id_9312();

  if(isDefined(var_0))
    self._id_5D6C = var_0;
}

_id_4046(var_0) {
  scripts\sp\utility::_id_1101B();

  if(isDefined(self._id_5D6C) && isDefined(self._id_5D6C._id_4D94) && isDefined(self._id_5D6C._id_4D94.allies))
    self._id_5D6C._id_4D94.allies = scripts\engine\utility::array_remove(self._id_5D6C._id_4D94.allies, self);

  if(isDefined(var_0) && var_0)
    self _meth_81D0();
  else
    self delete();
}

_id_229D(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = [];
  var_0 = _id_2289(var_0);
  var_1 = _id_2289(var_1);

  if(var_1.size == 0)
    return var_0;

  foreach(var_10, var_5 in var_0) {
    var_6 = 0;

    foreach(var_8 in var_1) {
      if(var_8 == var_10) {
        var_6 = 1;

        if(var_2)
          var_5 delete();

        break;
      }
    }

    if(var_6) {
      continue;
    }
    var_3[var_10] = var_5;
  }

  return var_3;
}

_id_229E(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = [];
  var_0 = _id_2289(var_0);
  var_1 = _id_2289(var_1);

  if(var_1.size == 0)
    return var_0;

  foreach(var_10, var_5 in var_0) {
    var_6 = 0;

    foreach(var_8 in var_1) {
      if(var_8 == var_10) {
        var_6 = 1;
        break;
      }
    }

    if(!var_6) {
      if(var_2)
        var_5 delete();

      continue;
    }

    var_3[var_10] = var_5;
  }

  return var_3;
}

_id_229B(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_1) && !var_4[[var_1]]()) {
      continue;
    }
    var_2[var_4.targetname] = var_4;
  }

  return var_2;
}

_id_157B(var_0, var_1, var_2) {
  self notify("stop_action_on_endpath");
  self endon("stop_action_on_endpath");
  self endon("death");

  if(isDefined(var_2)) {
    var_3 = undefined;

    for(;;) {
      var_3 = _id_13777(var_3);

      if(var_3 == var_2) {
        break;
      }

      wait 0.5;
    }
  }

  if(isDefined(var_1))
    self childthread[[var_1]]();

  self waittill("reached_path_end");

  if(isDefined(var_0))
    self childthread[[var_0]]();
}

_id_E351() {
  if(isDefined(self) && isalive(self) && !scripts\sp\utility::_id_58DA() && scripts\sp\utility::hastag(self.model, "tag_flash")) {
    stopFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), self, "tag_flash");
    stopFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), self, "tag_flash");
  }

  if(!isDefined(self.demeanoroverride) || self.demeanoroverride != "sprint")
    scripts\sp\utility::_id_F492(1.3);

  thread scripts\sp\utility::_id_1938([self], 1500);
}

_id_1937() {
  if(isDefined(self._id_B14F))
    scripts\sp\utility::_id_1101B();
}

_id_13777(var_0) {
  self endon("death");

  for(;;) {
    var_1 = self _meth_812A();

    if(isDefined(var_1)) {
      if(!isDefined(var_0) || var_0 != var_1)
        return var_1;
    }

    if(isDefined(self._id_A906)) {
      if(!isDefined(var_0) || var_0 != self._id_A906)
        return self._id_A906;
    }

    if(isDefined(self._id_A905)) {
      if(!isDefined(var_0) || var_0 != self._id_A905)
        return self._id_A905;
    }

    if(isDefined(self._id_A907)) {
      if(!isDefined(var_0) || var_0 != self._id_A907)
        return self._id_A907;
    }

    self waittill("go_to_node_new_goal");
  }
}

_id_12BA1() {
  self notify("stop_unignore_on_end");
  self endon("stop_unignore_on_end");
  self endon("death");
  self waittill("goal");
  scripts\sp\utility::_id_F415(0);
}

_id_A657(var_0, var_1, var_2) {
  if(!scripts\engine\utility::flag_exist("flag_killemall_done"))
    scripts\engine\utility::flag_init("flag_killemall_done");

  scripts\engine\utility::flag_clear("flag_killemall_done");
  var_3 = _id_2289(self._id_4D94.allies);
  var_4 = self._id_4D94._id_5A0C[var_1].origin;
  self._id_5A0D = scripts\engine\utility::spawn_tag_origin(var_4);

  while(var_0.size > 0) {
    var_0 = scripts\sp\utility::_id_DFEB(var_0);

    foreach(var_6 in sortbydistance(var_0, var_4)) {
      if(!isalive(var_6)) {
        continue;
      }
      scripts\engine\utility::array_thread(var_3, scripts\sp\utility::_id_F39C, var_6);
      _id_5EA2(var_6, 1);
      thread _id_5DBC(var_6, var_1, var_2);

      for(;;) {
        if(!isalive(var_6)) {
          break;
        }

        wait 0.5;
      }
    }

    scripts\engine\utility::waitframe();
  }

  self._id_5A0D delete();
  scripts\engine\utility::flag_set("flag_killemall_done");
}

_id_5DBC(var_0, var_1, var_2) {
  var_0 endon("death");
  var_3 = squared(128);

  if(!isDefined(var_2))
    var_2 = [];

  for(;;) {
    for(var_4 = 0; var_4 < 10; var_4++) {
      var_5 = (0, 0, 0);

      if(isDefined(var_0.angles))
        var_5 = anglesToForward(var_0.angles) * 32;

      self._id_5A0D moveTo(var_0.origin + (0, 0, 32) + var_5, 0.1);
      magicbullet("kac", self._id_4D94._id_5A0C[var_1].origin, self._id_5A0D.origin);
      bullettracer(self._id_4D94._id_5A0C[var_1].origin, self._id_5A0D.origin, undefined, 1);

      foreach(var_7 in var_2) {
        if(!isDefined(var_7)) {
          continue;
        }
        var_2 = sortbydistance(var_2, self._id_5A0D);

        if(distance2dsquared(var_7.origin, self._id_5A0D.origin) <= var_3) {
          var_7 _meth_81D0();
          continue;
        }

        break;
      }

      wait 0.1;
    }
  }

  self notify("droship_doorfire_complete");
}

_id_DFB7(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1024;

  if(isDefined(var_1))
    thread scripts\sp\utility::_id_1938(level._id_1162[var_0]._id_1912, var_2);
  else
    scripts\engine\utility::array_call(level._id_1162[var_0]._id_1912, ::delete);
}

_id_3848(var_0) {
  var_1 = level.player.origin - var_0.origin;
  var_2 = anglesToForward((0, level.player getplayerangles()[1], 0));
  var_3 = vectorNormalize(var_1);
  var_4 = vectordot(var_2, var_3);

  if(var_4 < 0.2)
    return 1;
  else
    return 0;
}

_id_9312() {
  if(isDefined(self._id_ED8A) || isDefined(self._id_ED1B)) {
    return;
  }
  if(isDefined(self._id_12E6))
    _id_12BA0();

  self._id_12E6 = [];
  self.disableplayeradsloscheck = _id_EB5F(self.disableplayeradsloscheck, "disableplayeradsloscheck", 1);
  self.ignoreall = _id_EB5F(self.ignoreall, "ignoreall", 1);
  self.ignoreme = _id_EB5F(self.ignoreme, "ignoreme", 1);
  self.grenadeawareness = _id_EB5F(self.grenadeawareness, "grenadeawareness", 0);
  self.badplaceawareness = _id_EB5F(self.badplaceawareness, "badplaceawareness", 0);
  self.ignoreexplosionevents = _id_EB5F(self.ignoreexplosionevents, "ignoreexplosionevents", 1);
  self.ignorerandombulletdamage = _id_EB5F(self.ignorerandombulletdamage, "ignorerandombulletdamage", 1);
  self.ignoresuppression = _id_EB5F(self.ignoresuppression, "ignoresuppression", 1);
  self.dontavoidplayer = _id_EB5F(self.dontavoidplayer, "dontavoidplayer", 1);
  self.newenemyreactiondistsq = _id_EB5F(self.newenemyreactiondistsq, "newEnemyReactionDistSq", 0);
  self.disablebulletwhizbyreaction = _id_EB5F(self.disablebulletwhizbyreaction, "disableBulletWhizbyReaction", 1);
  self._id_55EF = _id_EB5F(self._id_55EF, "disableFriendlyFireReaction", 1);
  self.dontmelee = _id_EB5F(self.dontmelee, "dontMelee", 1);
  self._id_6EC4 = _id_EB5F(self._id_6EC4, "flashBangImmunity", 1);
  self.dodangerreact = _id_EB5F(self.dodangerreact, "doDangerReact", 0);
  self._id_BEFA = _id_EB5F(self._id_BEFA, "neverSprintForVariation", 1);
  self.a._id_5605 = _id_EB5F(self.a._id_5605, "a.disablePain", 1);
  self.allowpain = _id_EB5F(self.allowpain, "allowPain", 0);
  self.fixednode = _id_EB5F(self.fixednode, "fixedNode", 1);
  self._id_EDB0 = _id_EB5F(self._id_EDB0, "script_forcegoal", 1);
  self.goalradius = _id_EB5F(self.goalradius, "goalradius", 5);
}

_id_12BA0(var_0) {
  if(isDefined(self._id_ED8A) || isDefined(self._id_ED1B)) {
    return;
  }
  if(isDefined(var_0) && var_0) {
    if(isDefined(self._id_12E6))
      self._id_12E6 = undefined;
  }

  self.disableplayeradsloscheck = _id_E2C5("disableplayeradsloscheck", 0);
  self.ignoreall = _id_E2C5("ignoreall", 0);
  self.ignoreme = _id_E2C5("ignoreme", 0);
  self.grenadeawareness = _id_E2C5("grenadeawareness", 1);
  self.badplaceawareness = _id_E2C5("badplaceawareness", 1);
  self.ignoreexplosionevents = _id_E2C5("ignoreexplosionevents", 0);
  self.ignorerandombulletdamage = _id_E2C5("ignorerandombulletdamage", 0);
  self.ignoresuppression = _id_E2C5("ignoresuppression", 0);
  self.dontavoidplayer = _id_E2C5("dontavoidplayer", 0);
  self.newenemyreactiondistsq = _id_E2C5("newEnemyReactionDistSq", 262144);
  self.disablebulletwhizbyreaction = _id_E2C5("disableBulletWhizbyReaction", undefined);
  self._id_55EF = _id_E2C5("disableFriendlyFireReaction", undefined);
  self.dontmelee = _id_E2C5("dontMelee", undefined);
  self._id_6EC4 = _id_E2C5("flashBangImmunity", undefined);
  self.dodangerreact = _id_E2C5("doDangerReact", 1);
  self._id_BEFA = _id_E2C5("neverSprintForVariation", undefined);
  self.a._id_5605 = _id_E2C5("a.disablePain", 0);
  self.allowpain = _id_E2C5("allowPain", 1);
  self.fixednode = _id_E2C5("fixedNode", 0);
  self._id_EDB0 = _id_E2C5("script_forcegoal", 0);
  self.goalradius = _id_E2C5("goalradius", 100);
  scripts\sp\utility::_id_61C7();
  self._id_12E6 = undefined;
}

_id_EB5F(var_0, var_1, var_2) {
  if(isDefined(var_0))
    self._id_12E6[var_1] = var_0;
  else
    self._id_12E6[var_1] = "none";

  return var_2;
}

_id_E2C5(var_0, var_1) {
  if(isDefined(self._id_12E6)) {
    if(isstring(self._id_12E6[var_0]) && self._id_12E6[var_0] == "none")
      return var_1;
    else
      return self._id_12E6[var_0];
  }

  return var_1;
}

_id_77C4(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(!isDefined(var_1)) {
    var_1 = getEnt(var_0, "targetname");

    if(!isDefined(var_1)) {
      var_1 = scripts\engine\utility::getStruct(var_0, "script_noteworthy");

      if(!isDefined(var_1))
        var_1 = getEnt(var_0, "script_noteworthy");
    }
  }

  return var_1;
}

_id_2289(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  return scripts\engine\utility::ter_op(isarray(var_0), var_0, [var_0]);
}

_id_65E5(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  scripts\sp\utility::_id_65E3(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(var_5))
    self[[var_1]](var_2, var_3, var_4, var_5);
  else {
    if(isDefined(var_4)) {
      self[[var_1]](var_2, var_3, var_4);
      return;
    }

    if(isDefined(var_3)) {
      self[[var_1]](var_2, var_3);
      return;
    }

    if(isDefined(var_2)) {
      self[[var_1]](var_2);
      return;
      return;
    }

    self[[var_1]]();
  }
}

_id_6E55(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\engine\utility::flag_wait(var_0);

  if(isDefined(var_9))
    self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else {
    if(isDefined(var_8)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
      return;
    }

    if(isDefined(var_7)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);
      return;
    }

    if(isDefined(var_6)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6);
      return;
    }

    if(isDefined(var_5)) {
      self[[var_1]](var_2, var_3, var_4, var_5);
      return;
    }

    if(isDefined(var_4)) {
      self[[var_1]](var_2, var_3, var_4);
      return;
    }

    if(isDefined(var_3)) {
      self[[var_1]](var_2, var_3);
      return;
    }

    if(isDefined(var_2)) {
      self[[var_1]](var_2);
      return;
      return;
    }

    self[[var_1]]();
  }
}

_id_C152(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_6)) {
    foreach(var_8 in var_6)
    self endon(var_8);
  }

  self waittill(var_0);

  if(isDefined(var_5))
    self[[var_1]](var_2, var_3, var_4, var_5);
  else {
    if(isDefined(var_4)) {
      self[[var_1]](var_2, var_3, var_4);
      return;
    }

    if(isDefined(var_3)) {
      self[[var_1]](var_2, var_3);
      return;
    }

    if(isDefined(var_2)) {
      self[[var_1]](var_2);
      return;
      return;
    }

    self[[var_1]]();
  }
}

_id_127B1(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(isstring(var_0))
    var_0 = getEnt(var_0, "targetname");

  var_0 endon("death");

  if(isDefined(var_3)) {
    var_3 = _id_2289(var_3);

    if(isDefined(var_4))
      var_4 = _id_2289(var_4);

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      if(isDefined(var_4)) {
        var_4[var_5] endon(var_3[var_5]);
        var_0 thread _id_127B2(var_4[var_5], var_3[var_5]);
        continue;
      }

      self endon(var_3[var_5]);
      var_0 thread _id_127B2(self, var_3[var_5]);
    }
  }

  if(!isDefined(var_2))
    var_2 = [];
  else
    var_2 = _id_2289(var_2);

  var_0 waittill("trigger");

  switch (var_2.size) {
    case 0:
      self[[var_1]]();
      break;
    case 1:
      self[[var_1]](var_2[0]);
      break;
    case 2:
      self[[var_1]](var_2[0], var_2[1]);
      break;
    case 3:
      self[[var_1]](var_2[0], var_2[1], var_2[2]);
      break;
    case 4:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
      break;
    case 5:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      break;
    case 6:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      break;
    case 7:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      break;
    case 8:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      break;
    default:
  }
}

_id_127B2(var_0, var_1) {
  self endon("death");
  var_0 waittill(var_1);
  self delete();
}

_id_137BA(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && !scripts\engine\utility::flag_exist(var_3))
    scripts\engine\utility::flag_init(var_3);

  if(!isDefined(var_2))
    var_2 = 0;

  var_4 = getnotetracktimes(var_0, var_1)[0];
  var_5 = var_4 * getanimlength(var_0) + var_2;
  wait(var_5);

  if(isDefined(var_3))
    scripts\engine\utility::flag_set(var_3);
}

_id_50C8(var_0, var_1, var_2, var_3) {
  wait(var_0);
  playFXOnTag(scripts\engine\utility::getfx(var_1), var_2, var_3);
}

_id_6E58(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3)) {
    var_3 = _id_2289(var_3);

    if(isDefined(var_4))
      var_4 = _id_2289(var_4);

    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      if(isDefined(var_4)) {
        var_4[var_7] endon(var_3[var_7]);
        continue;
      }

      self endon(var_3[var_7]);
    }
  }

  if(!isDefined(var_2))
    var_2 = [];
  else
    var_2 = _id_2289(var_2);

  if(scripts\engine\utility::is_true(var_5)) {
    var_8 = scripts\sp\utility::_id_7E9C(var_0);

    for(;;) {
      level waittill(var_0, var_9);

      if(var_9 == self) {
        break;
      }
    }

    scripts\engine\utility::flag_set(var_0);
  }

  if(scripts\engine\utility::is_true(var_6)) {
    while(!scripts\engine\utility::flag(var_0) && !level.player scripts\sp\utility::_id_D1DF(var_6.origin, 0.9))
      wait 0.2;
  } else
    scripts\engine\utility::flag_wait(var_0);

  switch (var_2.size) {
    case 0:
      self[[var_1]]();
      break;
    case 1:
      self[[var_1]](var_2[0]);
      break;
    case 2:
      self[[var_1]](var_2[0], var_2[1]);
      break;
    case 3:
      self[[var_1]](var_2[0], var_2[1], var_2[2]);
      break;
    case 4:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
      break;
    case 5:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      break;
    case 6:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      break;
    case 7:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      break;
    case 8:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      break;
    default:
  }
}

_id_D8E7(var_0, var_1, var_2, var_3) {
  var_4 = var_2 * 20;

  for(var_5 = 0; var_5 < var_4; var_5++)
    wait 0.05;
}

#using_animtree("generic_human");

_id_9253() {
  level._id_920F endon("death");
  level._id_920F notify("stop_hvt_sprint");
  level._id_920F endon("stop_hvt_sprint");
  var_0 = squared(700);
  level._id_920F scripts\sp\utility::_id_61DB();
  level._id_920F scripts\sp\utility::_id_61F7();
  level._id_920F scripts\sp\utility::_id_F492(1.2);
  childthread _id_9254("jumpup_72", %hm_grnd_org_jumpup_72);
  childthread _id_9254("jumpup_96", %hm_grnd_org_jumpup_96);
  childthread _id_9254("jumpup_128", %hm_grnd_org_jumpup_128);

  for(;;) {
    if(distancesquared(level.player.origin, level._id_920F.origin) < var_0)
      level._id_920F scripts\sp\utility::_id_51E1("sprint");
    else
      level._id_920F scripts\sp\utility::_id_51E1("combat");

    wait 0.1;
  }
}

_id_9254(var_0, var_1) {
  for(;;) {
    level._id_920F waittill(var_0);
    scripts\engine\utility::waitframe();
    level._id_920F _meth_82B1(var_1, 2.0);
  }
}

_id_978E() {
  level._id_436C = scripts\engine\utility::getStruct("collapse_atomscene_animorigin", "targetname");
  level._id_436C.origin = level._id_436C.origin + (0, 5, -3);
  level._id_1283E = getEnt("prisoner_truck", "targetname");
  level._id_1283E scripts\sp\utility::_id_23B7("collapse_truck");
  level._id_1283E._id_1FBB = "collapse_truck";
}

_id_D2DC(var_0) {
  level endon("stop_player_stay_behind");
  var_1 = scripts\engine\utility::ter_op(!isDefined(var_0), 22500, var_0 * var_0);
  var_2 = 0.5;
  var_3 = 0.7;

  if(!isDefined(level.player._id_BCF5))
    level.player._id_BCF5 = 1;

  for(;;) {
    var_4 = distancesquared(level.player.origin, self.origin);
    var_5 = scripts\sp\math::_id_C097(0, var_1, var_4);
    var_5 = clamp(var_5, var_3, 1);
    var_6 = var_5 - level.player._id_BCF5;
    var_7 = var_6 * var_2;
    var_8 = level.player._id_BCF5 + var_7;
    level.player setmovespeedscale(var_8);
    level.player._id_BCF5 = var_8;
    wait 0.05;
  }
}

_id_10181() {
  setsaveddvar("player_sprintspeedscale", 1.4);
  level notify("stop_player_stay_behind");
  thread scripts\sp\utility::_id_2B77(1);
}