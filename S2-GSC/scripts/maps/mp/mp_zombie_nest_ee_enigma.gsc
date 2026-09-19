/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_enigma.gsc
********************************************************/

_id_430C() {
  return "salt_mine_opened";
}

main() {
  level._id_36B0 = 1;
  level._id_3592 = 1;
  level._id_3594 = 1;
  level._id_3593 = 0;
  level._id_3591 = 0;
  level._id_358E = [];
  level._id_358D = 0;
  _id_0557::_id_7846("2 open salt mine", ::_id_378A, ["explore village"], &"ZOMBIE_NEST_HINT_QUEST_ENIGMA", "ZOMBIE_NEST_HINT_QUEST_ENIGMA");
  _id_0557::_id_781E("2 open salt mine", "explore bunker", ::_id_7851, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_EXPLORE_BUNKER");
  _id_0557::_id_781E("2 open salt mine", "use power machines", ::_id_7867, ::_id_7EFD, &"ZOMBIE_NEST_HINT_STEP_REROUTE_POWER");
  _id_0557::_id_781E("2 open salt mine", "salt mine door open", ::_id_785F, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_OPEN_SALT_MINE");
  _id_0557::_id_7848("2 open salt mine");
  common_scripts\utility::flag_init("flag_salt_mine_opened");
  common_scripts\utility::flag_init("flag_salt_mine_main_ent_opened");
  common_scripts\utility::flag_init("flag_med_enigma_set");
  common_scripts\utility::flag_init("flag_rnd_enigma_set");
  common_scripts\utility::flag_init("flag_both_enigmas_set");
  common_scripts\utility::flag_init("flag_salt_mine_door_found");
  common_scripts\utility::flag_init("salt_mine_opened");
  _id_52B6();
  _id_5348();
}

_id_1389() {
  wait 1;
  var_0 = _id_44F7();
  common_scripts\utility::flag_set(var_0.setgoalnode);
}

_id_784F() {
  var_0 = _id_44F7();
  var_1 = var_0.setgoalnode;
  var_2 = undefined;

  foreach(var_4 in level._id_7606) {
    if(_id_0547::_id_5565(var_4.getnegotiationnextnode, var_1))
      var_2 = var_4;
  }

  if(isDefined(var_2) && isDefined(var_2._id_6298)) {
    var_6 = _id_0557::_id_782F(var_2._id_6298.origin + (0, 0, 30), [var_2._id_6298]);
    _id_0557::_id_781D("2 open salt mine", var_6);
  } else {}

  common_scripts\utility::_id_3C9F(var_1);
  _id_0557::_id_782D("2 open salt mine", "enable power");
}

_id_7851() {
  var_0 = _id_4587();
  thread _id_A10A("med", "red");
  thread _id_A10A("rnd", "red");
  common_scripts\utility::_id_3CA2("flag_med_enigma_set", "flag_rnd_enigma_set", "flag_salt_mine_door_found");
  _id_0557::_id_782D("2 open salt mine", "explore bunker");
}

_id_7867() {
  if(1) {
    if(!1 || 1 && level.players.size == 1)
      level thread quest_step_reroute_power_helper();
  }

  if(common_scripts\utility::_id_3C77("flag_med_enigma_set") || common_scripts\utility::_id_3C77("flag_rnd_enigma_set"))
    _id_0557::_id_7822("2 open salt mine", &"ZOMBIE_NEST_HINT_STEP_REROUTE_POWER_2");

  if(0) {
    level._id_3590 = _id_0557::_id_782F(undefined, level._id_358F);
    _id_0557::_id_781D("2 open salt mine", level._id_3590);
  }
}

quest_step_reroute_power_helper() {
  level endon(_id_0557::_id_7838("2 open salt mine", "use power machines"));

  if(!0) {
    var_0 = level._id_A980;
    var_1 = var_0 + 2;

    if(1)
      wait 200;

    if(1) {
      if(level._id_A980 <= var_1) {
        for(;;) {
          level waittill("zombie_wave_started");

          if(level._id_A980 > var_1) {
            break;
          }
        }
      }
    }

    if(0) {
      level.rotor_objective_helper_tripped = 1;

      foreach(var_3 in level._id_358F) {
        foreach(var_5 in level.players)
        var_3 hudoutlineenableforclient(var_5, 0, 0);
      }
    } else {
      level._id_3590 = _id_0557::_id_782F(undefined, level._id_358F);
      _id_0557::_id_781D("2 open salt mine", level._id_3590);
    }
  }
}

_id_5348() {
  var_0 = getEntArray("reroute_power_01_model", "script_noteworthy");
  var_1 = getEntArray("reroute_power_02_model", "script_noteworthy");
  var_2 = var_0[0];
  var_3 = var_1[0];

  foreach(var_5 in var_0) {
    if(var_5.classname == "script_model" && var_5.model == "zmb_circuit_breaker_02")
      var_2 = var_5;
  }

  foreach(var_5 in var_1) {
    if(var_5.classname == "script_model" && var_5.model == "zmb_circuit_breaker_02")
      var_3 = var_5;
  }

  level._id_358F = [var_3, var_2];
}

_id_785F() {
  var_0 = _id_4470();

  if(0) {
    var_1 = _id_0557::_id_782F(undefined, var_0.setclientdvars);
    _id_0557::_id_781D("2 open salt mine", var_1);
  }

  if(1) {
    if(0) {
      if(common_scripts\utility::_id_562E(level.rotor_objective_helper_tripped)) {
        foreach(var_3 in level._id_358F) {
          foreach(var_5 in level.players)
          var_3 hudoutlinedisableforclient(var_5);
        }
      }
    }
  }
}

_id_378A() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("shardroom");
    var_1 _id_0378::_id_8D74("objective_complete", "shardroom");
  }
}

_id_52B6() {
  level._id_358E = getEntArray("enigma_place", "targetname");
  _id_053F::_id_7BEB(&"ZOMBIE_NEST_ROTORS_NOT_PLACED", "flag_both_enigmas_set", "rotor");
  _id_053F::_id_7BEB(&"ZOMBIE_NEST_ROTORS_NOT_PLACED", "flag_salt_mine_main_ent_opened", "rotor");
  level._id_357D = level._id_358E.size;
  thread _id_2EA6();
  thread _id_3B98();

  foreach(var_1 in level._id_358E) {
    var_1 _id_8A3F();
    var_1 thread _id_7EFC();
  }
}

_id_3B98() {
  var_0 = _getent("enter_com_trig", "targetname");

  if(isDefined(var_0)) {
    for(;;) {
      var_0 waittill("trigger", var_1);

      if(isPlayer(var_1)) {
        break;
      }

      wait 0.25;
    }

    if(!_id_0557::_id_783E("2 open salt mine", "explore bunker"))
      _id_0557::_id_7822("2 open salt mine", &"ZOMBIE_NEST_HINT_STEP_FIND_SM_DOOR");
  }
}

lerpfov() {
  level._id_3593 = 1;

  if(!maps\mp\mp_zombie_nest_ee_hc_tools_of_the_trade::_id_8B98()) {
    var_0 = getEntArray("enigma_place", "targetname");

    foreach(var_2 in var_0)
    var_2 delete();
  }

  if(level._id_36B0) {
    var_4 = _id_4470();
    var_5 = var_4.setclientdvars[0].origin;
    common_scripts\utility::_id_3C9F("com_to_mine");
    common_scripts\utility::flag_set("flag_salt_mine_main_ent_opened");
    thread maps\mp\mp_zombie_nest_ee_util::_id_7213("entermine", var_5, 200, 512);
  }

  var_6 = _id_4587();
  var_6 notify("open", level.players[0]);
  thread _id_A10A("med", "green");
  thread _id_A10A("rnd", "green");
  _id_0557::_id_782D("2 open salt mine", "salt mine door open");
  _id_0557::_id_AB88("salt_mine_opened");
}

_id_7EFD() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("rotor");
    var_1 _id_0378::_id_8D74("objective_complete", "rotor");
  }
}

_id_7D6D(var_0) {
  for(var_1 = 0; var_1 < level._id_358E.size; var_1++)
    level._id_358E[var_1] common_scripts\utility::_id_9D9F();

  _id_7D6C();

  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0) {
    var_2 = _id_4470();
    thread _id_A0FF("lock");
    thread _id_A10A("med", "red");
    thread _id_A10A("rnd", "red");
  }

  wait 1;
  _id_7AAC();
}

_id_7D6C() {
  level._id_3591 = 0;
  common_scripts\utility::_id_3C7B("flag_med_enigma_set");
  common_scripts\utility::_id_3C7B("flag_rnd_enigma_set");
  thread _id_0378::_id_8D74("aud_fuse_timer_stop", level._id_358E);

  for(var_0 = 0; var_0 < level._id_358E.size; var_0++) {
    level._id_358E[var_0]._id_5F59 _id_8718();
    level._id_358E[var_0] _id_8713();
    level._id_358E[var_0]._id_08A9 = 0;
  }
}

_id_7AAC() {
  for(var_0 = 0; var_0 < level._id_358E.size; var_0++)
    level._id_358E[var_0] common_scripts\utility::_id_9DA3();
}

_id_8A3F() {
  self usetriggerrequirelookat();
  self._id_5F59 = _getent(self.target, "targetname");

  if(isDefined(self._id_5F59.target))
    self._id_6643 = common_scripts\utility::_id_44BD(self._id_5F59.target, "targetname");

  if(isDefined(self._id_6643) && isDefined(self._id_6643.target))
    self._id_6646 = common_scripts\utility::_id_44BD(self._id_6643.target, "targetname");

  if(isDefined(self._id_6646) && isDefined(self._id_6646.target))
    self._id_6647 = common_scripts\utility::_id_44BD(self._id_6646.target, "targetname");
}

_id_7EFC() {
  self._id_5F59 thread _id_8718();
  thread _id_8713();

  while(level._id_3591 < level._id_357D) {
    self waittill("trigger", var_0);
    _id_0378::_id_8D74("aud_enigma_switch_activate");

    if(isDefined(self.setlookatent)) {
      if(self.setlookatent == "rotor_machine_rnd") {
        common_scripts\utility::flag_set("flag_rnd_enigma_set");
        thread _id_A10A("rnd", "green");
      } else if(self.setlookatent == "rotor_machine_med") {
        common_scripts\utility::flag_set("flag_med_enigma_set");
        thread _id_A10A("med", "green");
      }
    }

    if(!isDefined(self._id_08A9))
      self._id_08A9 = 0;

    self._id_5F59 thread _id_8717();

    if(self._id_08A9 == 0) {
      common_scripts\utility::_id_9D9F();
      self._id_08A9 = 1;
      level._id_3591++;
      var_0 thread _id_2EB7();

      if(level._id_3591 == 1 && 1) {
        if(level._id_358D == 0 && !level._id_3593)
          _id_0557::_id_7822("2 open salt mine", &"ZOMBIE_NEST_HINT_STEP_REROUTE_POWER_2");

        thread _id_92C4();
        thread _id_A0FF("unlock");
      }

      if(level._id_3591 >= level._id_357D) {
        thread _id_0378::_id_8D74("aud_fuse_timer_stop", level._id_358E);
        level notify("nest_ee_both_machines_used");
        common_scripts\utility::flag_set("flag_both_enigmas_set");
        var_0 _id_0378::_id_8D74("aud_saltmine_door_powered");

        if(isDefined(level._id_3590))
          _id_0557::_id_7847("2 open salt mine", level._id_3590);

        _id_0557::_id_782D("2 open salt mine", "use power machines");

        foreach(var_2 in level._id_358E) {
          var_2._id_5F59 thread _id_8715();
          var_2 thread _id_8714();
        }

        lerpfov();
      }
    }
  }
}

#using_animtree("destructibles");

_id_8718() {
  if(common_scripts\utility::_id_562E(self._id_56B6)) {
    self scriptmodelplayanim("zmb_circuit_breaker_02_dial_standby");
    wait(_getanimlength(%zmb_circuit_breaker_02_dial_standby));
  }

  var_0 = ["TAG_RED_ON", "TAG_GREEN_OFF", "TAG_GRAPH_ON"];
  var_1 = ["TAG_RED_OFF", "TAG_GREEN_ON", "TAG_GRAPH_OFF"];
  _id_A10E(var_1, var_0);
  thread _id_86BD();
  self._id_56B6 = 0;
  self scriptmodelplayanim("zmb_circuit_breaker_02_dial_standby_idle");
}

_id_8717() {
  self scriptmodelplayanim("zmb_circuit_breaker_02_dial_ready");
  wait(_getanimlength(%zmb_circuit_breaker_02_dial_ready));
  var_0 = ["TAG_RED_OFF", "TAG_GREEN_ON", "TAG_GRAPH_ON"];
  var_1 = ["TAG_RED_ON", "TAG_GREEN_OFF", "TAG_GRAPH_OFF"];
  _id_A10E(var_1, var_0);
  self._id_56B6 = 1;
  thread _id_86C1();
  self scriptmodelplayanim("zmb_circuit_breaker_02_dial_ready_idle");
}

_id_8715() {
  self._id_56B6 = 1;
}

_id_86C0() {
  if(common_scripts\utility::_id_562E(self._id_568A))
    _id_940A("off");
  else {
    self hidepart("TAG_POWER_ON", self.model);
    self showpart("TAG_POWER_OFF", self.model);
  }
}

_id_86C1() {
  if(common_scripts\utility::_id_562E(self._id_568A))
    _id_940A("on");
  else {
    self hidepart("TAG_POWER_OFF", self.model);
    self showpart("TAG_POWER_ON", self.model);
  }
}

_id_86BD() {
  self._id_568A = 1;

  while(common_scripts\utility::_id_562E(self._id_568A)) {
    self hidepart("TAG_POWER_ON", self.model);
    self showpart("TAG_POWER_OFF", self.model);
    wait 0.5;
    self hidepart("TAG_POWER_OFF", self.model);
    self showpart("TAG_POWER_ON", self.model);

    if(common_scripts\utility::_id_562E(self._id_56B6)) {
      self._id_568A = 0;
      return;
    }

    wait 0.5;
  }
}

_id_940A(var_0) {
  if(var_0 == "on") {
    self._id_568A = 0;
    self._id_568B = 1;
  } else {
    self._id_568A = 0;
    self._id_568B = 1;
  }
}

_id_8716(var_0) {
  self scriptmodelplayanim("zmb_circuit_breaker_02_dial_idle");
}

_id_A10E(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++)
    self hidepart(var_0[var_2], self.model);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    self showpart(var_1[var_2], self.model);
}

_id_A0FF(var_0) {
  var_1 = _id_4470();

  if(!isDefined(var_0)) {
    return;
  }
  var_2 = undefined;
  var_3 = undefined;
  var_4 = 0;

  switch (var_0) {
    case "unlock":
      var_2 = "unlocking";
      var_3 = "unlocked";
      var_4 = 1.83333;
      break;
    case "lock":
      var_2 = "relocking";
      var_3 = "closed";
      var_4 = 1.83333;
      break;
    default:
      break;
  }

  if(!isDefined(var_2)) {
    return;
  }
  if(common_scripts\utility::_id_562E(var_1._id_5671)) {
    while(var_1._id_5671)
      wait 0.1;
  }

  var_1._id_5671 = 1;

  foreach(var_6 in var_1.setclientdvars)
  var_6 setscriptablepartstate("gate", var_2);

  wait(var_4);

  foreach(var_6 in var_1.setclientdvars)
  var_6 setscriptablepartstate("gate", var_3);

  var_1._id_5671 = 0;
}

_id_A10A(var_0, var_1) {
  var_2 = _id_4470();
  var_3 = undefined;
  var_4 = undefined;

  if(var_0 == "rnd")
    var_3 = "light_r";
  else if(var_0 == "med")
    var_3 = "light_l";

  if(var_1 == "green")
    var_4 = "on";
  else if(var_1 == "red")
    var_4 = "off";

  foreach(var_6 in var_2.setclientdvars)
  var_6 setscriptablepartstate(var_3, var_4);
}

_id_92C4() {
  var_0 = 60;
  var_1 = 0;

  foreach(var_3 in level._id_358E)
  var_3 thread _id_9300(var_0);

  thread _id_0378::_id_8D74("aud_fuse_timer_start", level._id_358E);

  while(!level._id_3593 && !var_1) {
    if(var_0 < 10) {
      foreach(var_6 in level.players) {
        if(var_6 maps\mp\mp_zombie_nest_ee_util::_id_7402())
          thread _id_0378::_id_8D74("aud_start_enigma_timer", var_0, var_1);
      }
    }

    var_0--;
    wait(1 / level._id_3594);

    if(var_0 <= 0 && !level._id_3593) {
      foreach(var_6 in level.players) {
        if(var_6 maps\mp\mp_zombie_nest_ee_util::_id_7402()) {
          thread _id_0378::_id_8D74("aud_start_enigma_timer", var_0, var_1);
          var_6 thread _id_2EA7();
        }
      }

      if(level._id_358D == 0 && !level._id_3593)
        _id_0557::_id_7822("2 open salt mine", &"ZOMBIE_NEST_HINT_STEP_REROUTE_RESET");

      level._id_358D++;
      thread _id_7D6D();
      var_1 = 1;
    }
  }
}

_id_9300(var_0) {
  level endon("flag_both_enigmas_set");

  if(!isDefined(self._id_6643) || !isDefined(self._id_6646) || !isDefined(self._id_6647)) {
    return;
  }
  self._id_6643 moveto(self._id_6647.origin, 0.1, 0, 0);
  wait 0.1;
  self._id_6643 moveto(self._id_6646.origin, var_0 - 0.1, 0, 0);
}

_id_8714() {
  if(!isDefined(self._id_6643) || !isDefined(self._id_6647)) {
    return;
  }
  self._id_6643 moveto(self._id_6647.origin, 0.5, 0, 0);
}

_id_8713() {
  if(!isDefined(self._id_6643) || !isDefined(self._id_6646)) {
    return;
  }
  self._id_6643 moveto(self._id_6646.origin, 0.5, 0, 0);
}

_id_2EA6() {
  level endon("flag_both_enigmas_set");
  var_0 = _getent("saltmine_ent_dialogue", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      wait 0.5;
      continue;
    } else if(!isDefined(var_1._id_306B)) {
      common_scripts\utility::flag_set("flag_salt_mine_door_found");
      var_2 = var_1 _id_0367::_id_8E3D("saltminedoorexamine");

      if(isDefined(var_2))
        var_1._id_306B = 1;
    }
  }
}

_id_2EB7() {
  if(isPlayer(self)) {
    if(level._id_3591 >= level._id_357D) {
      if(!isDefined(self._id_3064)) {
        wait 0.8;
        thread _id_0367::_id_8E3C("saltminepower2");
        self._id_3064 = 1;
      }
    } else if(!isDefined(self._id_3063)) {
      wait 0.8;
      thread _id_0367::_id_8E3C("saltminepower1");
      self._id_3063 = 1;
    }
  }
}

_id_2EA7() {
  if(!isDefined(self._id_3065) && isPlayer(self)) {
    var_0 = thread _id_0367::_id_8E3D("saltminereset");

    if(isDefined(var_0))
      self._id_3065 = 1;
  }
}

_id_44F7() {
  return _id_053F::_id_44A6("gallows_to_com");
}

_id_4470() {
  return _id_053F::_id_44A6("com_to_mine");
}

_id_4587() {
  return _id_053F::_id_44A6("rnd_to_mine");
}