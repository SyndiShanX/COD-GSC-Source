/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_movers.gsc
***********************************************/

main() {
  if(getDvar("_encstr_8F7A0BD1E5E15304B8CF7989FF") == "_encstr_A34C02BB") {
    return;
  }
  level.script_mover_defaults = [];
  level.script_mover_defaults["_encstr_8FA50A6B0FD30541B49C6079"] = 5;
  level.script_mover_defaults["_encstr_8F8B0BA30647CAD5F7C923CDCA"] = 0;
  level.script_mover_defaults["_encstr_97210BBC75C733FA87D9D2C517"] = 0;
  level.script_mover_defaults["_encstr_93BA0A3B61FB8381F8B30515"] = 0;
  level.script_mover_defaults["_encstr_991A0BBC6558579077602A6280"] = 0;
  level.script_mover_defaults["_encstr_8E8607AB603B6E4341"] = 0;
  level.script_mover_defaults["_encstr_A3DB0B86B4CDE8E647E42DCD76"] = "_encstr_85AD0950914BBF136ACB7F";
  script_mover_add_hintstring("_encstr_85AD0950914BBF136ACB7F", &"_encstr_B8AD1233EB5E0FA9ECEC0FE5C3A51151F04BAB95");
  script_mover_add_parameters("_encstr_8BBA05185F8B99", "_encstr_B40101");
  level.script_mover_named_goals = [];
  waitframe();
  var_0 = [];
  var_1 = script_mover_classnames();

  foreach(var_3 in var_1)
  var_0 = scripts\engine\utility::array_combine(var_0, getEntArray(var_3, "_encstr_AC110A7F14873B5B3D073009"));

  scripts\engine\utility::array_thread(var_0, ::script_mover_int);
}

script_mover_classnames() {
  return ["_encstr_92061363BE43AF1AE901221AC013D5BF1810EEED4E", "_encstr_A6FE184771E8E0733B8701C6E3D328DD37F9DA02DF484FEBA01B"];
}

script_mover_is_script_mover() {
  if(isDefined(self.script_mover))
    return self.script_mover;

  var_0 = script_mover_classnames();

  foreach(var_2 in var_0) {
    if(self.classname == var_2) {
      self.script_mover = 1;
      return 1;
    }
  }

  return 0;
}

script_mover_add_hintstring(var_0, var_1) {
  if(!isDefined(level.script_mover_hintstrings))
    level.script_mover_hintstrings = [];

  level.script_mover_hintstrings[var_0] = var_1;
}

script_mover_add_parameters(var_0, var_1) {
  if(!isDefined(level.script_mover_parameters))
    level.script_mover_parameters = [];

  level.script_mover_parameters[var_0] = var_1;
}

script_mover_int() {
  if(!isDefined(self.target)) {
    return;
  }
  self.script_mover = 1;
  self.moving = 0;
  self.origin_ent = self;
  self.use_triggers = [];
  self.linked_ents = [];
  var_0 = scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_noteworthy)) {
      continue;
    }
    switch (var_2.script_noteworthy) {
      case "_encstr_97FE07DE392D76D2CD":
        if(!isDefined(var_2.angles))
          var_2.angles = (0, 0, 0);

        self.origin_ent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
        self.origin_ent.angles = var_2.angles;
        self.origin_ent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
        self.origin_ent linkTo(self);
        break;
      default:
        break;
    }
  }

  var_4 = getEntArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_4) {
    if(!isDefined(var_2.script_noteworthy)) {
      continue;
    }
    switch (var_2.script_noteworthy) {
      case "_encstr_A93C11AB9B2BFAE8C95A9DD95639F51BB4E66D":
        var_2 enablelinkTo();
        var_2 linkTo(self);
      case "_encstr_91A60C3BA39731FD0B2A5941F253":
        var_2 script_mover_parse_targets();
        thread script_mover_use_trigger(var_2);
        self.use_triggers[self.use_triggers.size] = var_2;
        break;
      case "_encstr_A3AD05049B48F2":
        var_2 linkTo(self);
        self.linked_ents[self.linked_ents.size] = var_2;
        break;
      default:
        break;
    }
  }

  thread script_mover_parse_targets();
  thread script_mover_init_move_parameters();
  thread script_mover_save_default_move_parameters();
  thread script_mover_apply_move_parameters(self);
  thread script_mover_move_to_target();

  foreach(var_8 in self.use_triggers)
  script_mover_set_usable(var_8, 1);
}

script_mover_use_trigger(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A");

    if(var_0.goals.size > 0) {
      self notify("_encstr_B254099B59DDD70E853A0D");
      thread script_mover_move_to_target(var_0);
      continue;
    }

    self notify("_encstr_8F5C086405E70FBA4B4A");
  }
}

script_mover_move_to_named_goal(var_0) {
  if(isDefined(level.script_mover_named_goals[var_0])) {
    self notify("_encstr_B254099B59DDD70E853A0D");
    self.goals = [level.script_mover_named_goals[var_0]];
    thread script_mover_move_to_target();
  }
}

anglesclamp180(var_0) {
  return (angleclamp180(var_0[0]), angleclamp180(var_0[1]), angleclamp180(var_0[2]));
}

script_mover_parse_targets() {
  if(isDefined(self.parsed) && self.parsed) {
    return;
  }
  self.parsed = 1;
  self.goals = [];
  self.movers = [];
  self.level_notify = [];
  var_0 = [];
  var_1 = [];

  if(isDefined(self.target)) {
    var_0 = scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1 = getEntArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3.script_noteworthy))
      var_3.script_noteworthy = "_encstr_8B7205D9ED5958";

    switch (var_3.script_noteworthy) {
      case "_encstr_ADC40709AF10BDA3DD":
        if(isDefined(var_3.target)) {
          var_4 = scripts\engine\utility::getStructArray(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

          foreach(var_6 in var_4)
          var_0[var_0.size] = var_6;
        }

        break;
      case "_encstr_8B7205D9ED5958":
        var_3 script_mover_init_move_parameters();
        var_3 script_mover_parse_targets();
        self.goals[self.goals.size] = var_3;

        if(isDefined(var_3.params["_encstr_84BA05A8CA852B"]))
          level.script_mover_named_goals[var_3.params["_encstr_84BA05A8CA852B"]] = var_3;

        break;
      case "_encstr_AF9A0D191D5B1D315F2A308013B21A":
        if(isDefined(var_3.script_parameters))
          self.level_notify[self.level_notify.size] = var_3;

        break;
      default:
        break;
    }
  }

  foreach(var_9 in var_1) {
    if(var_9 script_mover_is_script_mover()) {
      self.movers[self.movers.size] = var_9;
      continue;
    }

    if(!isDefined(var_9.script_noteworthy)) {
      continue;
    }
    var_10 = strtok(var_9.script_noteworthy, "_encstr_BA4C02DF");

    if(var_10.size != 3 || var_10[1] != "_encstr_AB0703DBB9") {
      continue;
    }
    switch (var_10[0]) {
      case "_encstr_A25F0710622DF3B3D7":
        thread script_mover_call_func_on_notify(var_9, ::delete, var_10[2]);
        break;
      case "_encstr_BECC055CF3811A":
        thread script_mover_call_func_on_notify(var_9, ::hide, var_10[2]);
        break;
      case "_encstr_BD1805CB69C063":
        var_9 hide();
        thread script_mover_call_func_on_notify(var_9, ::show, var_10[2]);
        break;
      case "_encstr_B8740CCD6A623F018D2B99985BA5":
      case "_encstr_B8740CCD6A623F018D2B98985BA5":
        thread script_mover_func_on_notify(var_9, scripts\engine\utility::trigger_off, var_10[2]);
        break;
      case "_encstr_8C9D0CE81B339F30F78B4941EF03":
      case "_encstr_8C9D0CE81B339F30F78B4841EF03":
        var_9 scripts\engine\utility::trigger_off();
        thread script_mover_func_on_notify(var_9, scripts\engine\utility::trigger_on, var_10[2]);
        break;
      default:
        break;
    }
  }
}

script_mover_func_on_notify(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill(var_2);
    var_0[[var_1]]();
  }
}

script_mover_call_func_on_notify(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill(var_2);
    var_0 call[[var_1]]();
  }
}

script_mover_trigger_on() {
  scripts\engine\utility::trigger_on();
}

script_mover_move_to_target(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B254099B59DDD70E853A0D");

  if(!isDefined(var_0))
    var_0 = self;

  while(var_0.goals.size != 0) {
    var_1 = scripts\engine\utility::random(var_0.goals);
    var_2 = self;
    var_2 script_mover_apply_move_parameters(var_1);

    if(isDefined(var_2.params["_encstr_A31A0BC82B1B85CBBE8ED21B1B"]))
      level waittill(var_2.params["_encstr_A31A0BC82B1B85CBBE8ED21B1B"]);

    if(isDefined(var_2.params["_encstr_A15E13055D8B11B3910B1838A2B991CB37C71C0DA2"]) && var_2.params["_encstr_A15E13055D8B11B3910B1838A2B991CB37C71C0DA2"])
      self waittill("_encstr_8F5C086405E70FBA4B4A");

    if(var_2.params["_encstr_991A0BBC6558579077602A6280"] > 0)
      wait(var_2.params["_encstr_991A0BBC6558579077602A6280"]);

    var_3 = var_2.params["_encstr_8FA50A6B0FD30541B49C6079"];
    var_4 = var_2.params["_encstr_8F8B0BA30647CAD5F7C923CDCA"];
    var_5 = var_2.params["_encstr_97210BBC75C733FA87D9D2C517"];
    var_6 = 0;
    var_7 = 0;
    var_8 = transformmove(var_1.origin, var_1.angles, self.origin_ent.origin, self.origin_ent.angles, self.origin, self.angles);

    if(var_2.origin != var_1.origin) {
      if(isDefined(var_2.params["_encstr_8B4B0BADB767ACF5DC07959546"])) {
        var_9 = distance(var_2.origin, var_1.origin);
        var_3 = var_9 / var_2.params["_encstr_8B4B0BADB767ACF5DC07959546"];
      }

      if(isDefined(var_2.params["_encstr_8B180BCF50213592E76CFA36C6"]))
        var_4 = var_2.params["_encstr_8B180BCF50213592E76CFA36C6"] * var_3;

      if(isDefined(var_2.params["_encstr_A68C0BC859B1ACD8EBCC4E581B"]))
        var_5 = var_2.params["_encstr_A68C0BC859B1ACD8EBCC4E581B"] * var_3;

      var_2 moveTo(var_8["_encstr_97FE07DE392D76D2CD"], var_3, var_4, var_5);

      foreach(var_11 in var_1.level_notify)
      thread script_mover_run_notify(var_11.origin, var_11.script_parameters, self.origin, var_1.origin);

      var_6 = 1;
    }

    if(anglesclamp180(var_8["_encstr_A7610758E6CED8569B"]) != anglesclamp180(var_2.angles)) {
      var_2 rotateTo(var_8["_encstr_A7610758E6CED8569B"], var_3, var_4, var_5);
      var_7 = 1;
    }

    foreach(var_14 in var_2.movers)
    var_14 notify("_encstr_8F5C086405E70FBA4B4A");

    var_0 notify("_encstr_868307C229BF0F1230");
    var_2 script_mover_allow_usable(0);
    self.moving = 1;

    if(isDefined(var_2.params["_encstr_936C11DABD3B56AFE8965BACEBDB99CCB92B47"]) && var_2.params["_encstr_936C11DABD3B56AFE8965BACEBDB99CCB92B47"] + var_3 > 0)
      wait(var_2.params["_encstr_936C11DABD3B56AFE8965BACEBDB99CCB92B47"] + var_3);
    else if(var_6)
      self waittill("_encstr_9B420907FD535DAC6DF285");
    else if(var_7)
      self waittill("_encstr_95640B9CB78E2CD1568CF673B2");
    else
      wait(var_3);

    self.moving = 0;
    self notify("_encstr_A62409B6B7ECCAFA95CD32");
    var_1 notify("_encstr_A19B07713643AF9BCB");

    if(isDefined(var_2.params["_encstr_AB610616DF039871"])) {
      if(var_2.params["_encstr_AB610616DF039871"])
        var_2 solid();
      else
        var_2 notsolid();
    }

    foreach(var_14 in var_1.movers)
    var_14 notify("_encstr_8F5C086405E70FBA4B4A");

    if(isDefined(var_2.params["_encstr_B2BA0A10BAF4595E6BA9F1F9"]))
      level waittill(var_2.params["_encstr_B2BA0A10BAF4595E6BA9F1F9"]);

    if(var_2.params["_encstr_93BA0A3B61FB8381F8B30515"] > 0)
      wait(var_2.params["_encstr_93BA0A3B61FB8381F8B30515"]);

    var_2 script_mover_allow_usable(1);
    var_0 = var_1;
  }
}

script_mover_run_notify(var_0, var_1, var_2, var_3) {
  self endon("_encstr_A62409B6B7ECCAFA95CD32");
  var_4 = self;
  var_5 = vectorNormalize(var_3 - var_2);

  for(;;) {
    var_6 = vectorNormalize(var_0 - var_4.origin);

    if(vectordot(var_5, var_6) <= 0) {
      break;
    }

    wait 0.05;
  }

  level notify(var_1);
}

script_mover_init_move_parameters() {
  self.params = [];

  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);

  self.angles = anglesclamp180(self.angles);
  script_mover_parse_move_parameters(self.script_parameters);
}

script_mover_parse_move_parameters(var_0) {
  if(!isDefined(var_0))
    var_0 = "_encstr_B40101";

  var_1 = strtok(var_0, "_encstr_A54C02F2");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "_encstr_AB4C0246");

    if(var_4.size != 2) {
      continue;
    }
    if(var_4[1] == "_encstr_8C500ABA9B23CACC2D37AC8C" || var_4[1] == "_encstr_8B1608EC43B8D647A113") {
      self.params[var_4[0]] = undefined;
      continue;
    }

    switch (var_4[0]) {
      case "_encstr_936C11DABD3B56AFE8965BACEBDB99CCB92B47":
      case "_encstr_A68C0BC859B1ACD8EBCC4E581B":
      case "_encstr_8B180BCF50213592E76CFA36C6":
      case "_encstr_8B4B0BADB767ACF5DC07959546":
      case "_encstr_991A0BBC6558579077602A6280":
      case "_encstr_93BA0A3B61FB8381F8B30515":
      case "_encstr_97210BBC75C733FA87D9D2C517":
      case "_encstr_8F8B0BA30647CAD5F7C923CDCA":
      case "_encstr_8FA50A6B0FD30541B49C6079":
        self.params[var_4[0]] = script_mover_parse_range(var_4[1]);
        break;
      case "_encstr_B2BA0A10BAF4595E6BA9F1F9":
      case "_encstr_A31A0BC82B1B85CBBE8ED21B1B":
      case "_encstr_A3DB0B86B4CDE8E647E42DCD76":
      case "_encstr_84BA05A8CA852B":
        self.params[var_4[0]] = var_4[1];
        break;
      case "_encstr_A15E13055D8B11B3910B1838A2B991CB37C71C0DA2":
      case "_encstr_8E8607AB603B6E4341":
      case "_encstr_AB610616DF039871":
        self.params[var_4[0]] = int(var_4[1]);
        break;
      case "_encstr_8BB20EE6B19C4BE0E87DC12CE485B537":
        var_5 = var_4[1];
        var_6 = level.script_mover_parameters[var_5];

        if(isDefined(var_6))
          script_mover_parse_move_parameters(var_6);

        break;
      default:
        break;
    }
  }
}

script_mover_parse_range(var_0) {
  var_1 = 0;
  var_2 = strtok(var_0, "_encstr_964C0249");

  if(var_2.size == 1)
    var_1 = float(var_2[0]);
  else if(var_2.size == 2) {
    var_3 = float(var_2[0]);
    var_4 = float(var_2[1]);

    if(var_3 >= var_4)
      var_1 = var_3;
    else
      var_1 = randomfloatrange(var_3, var_4);
  }

  return var_1;
}

script_mover_apply_move_parameters(var_0) {
  foreach(var_3, var_2 in var_0.params)
  script_mover_set_param(var_3, var_2);

  script_mover_set_defaults();
}

script_mover_set_param(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == "_encstr_8E8607AB603B6E4341" && isDefined(var_1))
    script_mover_set_usable(self, var_1);

  self.params[var_0] = var_1;
}

script_mover_allow_usable(var_0) {
  if(self.params["_encstr_8E8607AB603B6E4341"])
    script_mover_set_usable(self, var_0);

  foreach(var_2 in self.use_triggers)
  script_mover_set_usable(var_2, var_0);
}

script_mover_set_usable(var_0, var_1) {
  if(var_1) {
    var_0 makeusable();
    var_0 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
    var_0 setHintString(level.script_mover_hintstrings[self.params["_encstr_A3DB0B86B4CDE8E647E42DCD76"]]);
  } else
    var_0 makeunusable();
}

script_mover_save_default_move_parameters() {
  self.params_default = [];

  foreach(var_2, var_1 in self.params)
  self.params_default[var_2] = var_1;
}

script_mover_set_defaults() {
  foreach(var_2, var_1 in level.script_mover_defaults) {
    if(!isDefined(self.params[var_2]))
      script_mover_set_param(var_2, var_1);
  }

  if(isDefined(self.params_default)) {
    foreach(var_2, var_1 in self.params_default) {
      if(!isDefined(self.params[var_2]))
        script_mover_set_param(var_2, var_1);
    }
  }
}

init() {
  level thread script_mover_agent_spawn_watch();
}

script_mover_agent_spawn_watch() {
  for(;;) {
    level waittill("_encstr_96F40E2EE81F737DFFEA49B0B297056B", var_0);
    var_0 thread player_unresolved_collision_watch();
  }
}

player_unresolved_collision_watch() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isagent(self))
    self endon("_encstr_AD75063D571AE108");

  self.unresolved_collision_count = 0;

  for(;;) {
    self waittill("_encstr_859415DBB06DDAE378F87B3F9056AB2239D9A4D2ABEFA2", var_0, var_1);
    self.unresolved_collision_count++;
    thread clear_unresolved_collision_count_next_frame();
    var_2 = 3;

    if(isDefined(var_0) && isDefined(var_0.unresolved_collision_notify_min))
      var_2 = var_0.unresolved_collision_notify_min;

    if(self.unresolved_collision_count >= var_2) {
      if(isDefined(var_0)) {
        if(isDefined(var_0.unresolved_collision_func))
          var_0[[var_0.unresolved_collision_func]](self, var_1);
        else if(isDefined(var_0.unresolved_collision_kill) && var_0.unresolved_collision_kill)
          var_0 unresolved_collision_owner_damage(self);
        else if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
          if(!scripts\cp_mp\vehicles\vehicle::_id_1418B(var_0, self))
            var_0 unresolved_collision_nearest_node(self);
        } else
          var_0 unresolved_collision_nearest_node(self);
      } else
        unresolved_collision_nearest_node(self);

      self.unresolved_collision_count = 0;
    }
  }
}

clear_unresolved_collision_count_next_frame() {
  self endon("_encstr_859415DBB06DDAE378F87B3F9056AB2239D9A4D2ABEFA2");
  waitframe();

  if(isDefined(self))
    self.unresolved_collision_count = 0;
}

unresolved_collision_owner_damage(var_0) {
  var_1 = self;

  if(!isDefined(var_1.owner)) {
    var_0 mover_suicide();
    return;
  }

  var_2 = 0;

  if(level.teambased) {
    if(isDefined(var_1.owner.team) && var_1.owner.team != var_0.team)
      var_2 = 1;
  } else if(var_0 != var_1.owner)
    var_2 = 1;

  if(!var_2) {
    var_0 mover_suicide();
    return;
  }

  var_3 = 1000;

  if(isDefined(var_1.unresolved_collision_damage))
    var_3 = var_1.unresolved_collision_damage;

  var_0 dodamage(var_3, var_1.origin, var_1.owner, var_1, "_encstr_8D4E0A501FCB898912CB3FA3");
}

unresolved_collision_nearest_node(var_0, var_1) {
  if(isDefined(level.override_unresolved_collision)) {
    self[[level.override_unresolved_collision]](var_0, var_1);
    return;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() || scripts\cp\utility::tryingtoleave()) {
    var_1 = 1;

    if(scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverseat(self, 1);

      if(isDefined(var_2)) {
        var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getexitpositionandangles(self, var_0, var_2, 1);

        if(isDefined(var_3)) {
          var_0 setOrigin(var_3[0]);
          return;
        }
      }
    }
  } else {
    var_4 = self.unresolved_collision_nodes;

    if(isDefined(var_4))
      var_4 = sortbydistance(var_4, var_0.origin);
    else {
      var_4 = getnodesinradius(var_0.origin, 300, 0, 200);
      var_4 = sortbydistance(var_4, var_0.origin);
    }

    var_5 = (0, 0, -100);
    var_0 cancelmantle();
    var_0 dontinterpolate();
    var_0 setOrigin(var_0.origin + var_5);

    for(var_6 = 0; var_6 < var_4.size; var_6++) {
      var_7 = var_4[var_6];
      var_8 = var_7.origin;

      if(!canspawn(var_8)) {
        continue;
      }
      if(positionwouldtelefrag(var_8)) {
        continue;
      }
      if(var_0 getstance() == "_encstr_922406F1A6FD5E05")
        var_0 setstance("_encstr_B13D076BED70539F23");

      var_0 setOrigin(var_8);
      return;
    }

    var_0 setOrigin(var_0.origin - var_5);
  }

  if(!isDefined(var_1))
    var_1 = 1;

  if(var_1)
    var_0 mover_suicide();
}

unresolved_collision_void(var_0, var_1) {}

mover_suicide() {
  if(isDefined(level.ishorde) && !isagent(self)) {
    return;
  }
  scripts\cp\utility::_suicide();
}

player_pushed_kill(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B102181243B0B8318761374F6BAE79F0D80B4C1FB9D97B6AD109");

  for(;;) {
    self waittill("_encstr_93410E6B08AB38F713F8203D8638BF07", var_1, var_2);

    if(isPlayer(var_1) || isagent(var_1)) {
      var_3 = length(var_2);

      if(var_3 >= var_0)
        unresolved_collision_owner_damage(var_1);
    }
  }
}

stop_player_pushed_kill() {
  self notify("_encstr_B102181243B0B8318761374F6BAE79F0D80B4C1FB9D97B6AD109");
}

script_mover_get_top_parent() {
  var_0 = self getlinkedparent();

  for(var_1 = var_0; isDefined(var_1); var_1 = var_1 getlinkedparent())
    var_0 = var_1;

  return var_0;
}

script_mover_start_use(var_0) {
  var_1 = var_0 script_mover_get_top_parent();

  if(isDefined(var_1))
    var_1.startuseorigin = var_1.origin;

  self.startusemover = self getmovingplatformparent();

  if(isDefined(self.startusemover)) {
    var_2 = self.startusemover script_mover_get_top_parent();

    if(isDefined(var_2))
      self.startusemover = var_2;

    self.startusemover.startuseorigin = self.startusemover.origin;
  }
}

script_mover_has_parent_moved(var_0) {
  if(!isDefined(var_0))
    return 0;

  return lengthsquared(var_0.origin - var_0.startuseorigin) > 0.001;
}

script_mover_use_can_link(var_0) {
  if(!isPlayer(self))
    return 1;

  if(!isDefined(var_0))
    return 0;

  var_1 = var_0 script_mover_get_top_parent();
  var_2 = self.startusemover;

  if(!isDefined(var_1) && !isDefined(var_2))
    return 1;

  if(isDefined(var_1) && isDefined(var_2) && var_1 == var_2)
    return 1;

  if(script_mover_has_parent_moved(var_1))
    return 0;

  if(script_mover_has_parent_moved(var_2))
    return 0;

  return 1;
}

script_mover_link_to_use_object(var_0) {
  if(isPlayer(var_0)) {
    var_0 script_mover_start_use(self);
    var_1 = var_0 getmovingplatformparent();
    var_2 = undefined;

    if(isDefined(var_1))
      var_2 = var_1;
    else if(!isDefined(script_mover_get_top_parent()))
      var_2 = self;
    else {
      var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
      var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      var_0.scriptmoverlinkdummy = var_2;
      var_0 thread sciprt_mover_use_object_wait_for_disconnect(var_2);
    }

    var_0 playerlinkTo(var_2);
  } else
    var_0 linkTo(self);

  var_0 playerlinkedoffsetenable();
}

script_mover_unlink_from_use_object(var_0) {
  var_0 unlink();

  if(isDefined(var_0.scriptmoverlinkdummy)) {
    var_0 notify("_encstr_85DF1527B2ADEDB35953BDEC959CC44BE6AD115D6BB6F2");
    var_0.scriptmoverlinkdummy delete();
    var_0.scriptmoverlinkdummy = undefined;
  }
}

sciprt_mover_use_object_wait_for_disconnect(var_0) {
  self endon("_encstr_85DF1527B2ADEDB35953BDEC959CC44BE6AD115D6BB6F2");
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
  self.scriptmoverlinkdummy delete();
  self.scriptmoverlinkdummy = undefined;
}

notify_moving_platform_invalid() {
  var_0 = self getlinkedchildren(0);

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    if(isDefined(var_2.no_moving_platfrom_unlink) && var_2.no_moving_platfrom_unlink) {
      continue;
    }
    var_2 unlink();
    var_2 notify("_encstr_92080F7938C38F1DD3D801EBE83D977B3B", self);
  }
}

process_moving_platform_death(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.no_moving_platfrom_death) && var_1.no_moving_platfrom_death) {
    return;
  }
  if(isDefined(var_0.playdeathfx))
    playFX(scripts\engine\utility::getfx("_encstr_AA361649FBB837FB8033B17A1BEFBB2F7959C5C329403D1F"), self.origin);

  if(isDefined(var_0.deathoverridecallback)) {
    var_0.lasttouchedplatform = var_1;
    self thread[[var_0.deathoverridecallback]](var_0);
  } else
    self delete();
}

handle_moving_platform_touch(var_0) {
  self notify("_encstr_9B831D43C2CD46D82BEBDAEDD92D73B37DC1C62CD199ED4EDA7DA3DEBA1B86");
  self endon("_encstr_9B831D43C2CD46D82BEBDAEDD92D73B37DC1C62CD199ED4EDA7DA3DEBA1B86");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8CAD1FA7C8807081A9CF1D97A1734ADF2EB85F2B48D84FC9B151268B9C17C36D73");

  if(isDefined(var_0.endonstring))
    self endon(var_0.endonstring);

  for(;;) {
    self waittill("_encstr_9BEC12738743F3E4FC383F10EFB9F28BAF651888", var_1);

    if(isDefined(var_0.validateaccuratetouching) && var_0.validateaccuratetouching) {
      if(!self istouching(var_1)) {
        wait 0.05;
        continue;
      }
    }

    thread process_moving_platform_death(var_0, var_1);
    break;
  }
}

handle_moving_platform_invalid(var_0) {
  self notify("_encstr_BA6B1FB238ED379B89B0757F3CD04B3F67487ABA3845ADABE0984966D4F90BC449");
  self endon("_encstr_BA6B1FB238ED379B89B0757F3CD04B3F67487ABA3845ADABE0984966D4F90BC449");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8CAD1FA7C8807081A9CF1D97A1734ADF2EB85F2B48D84FC9B151268B9C17C36D73");

  if(isDefined(var_0.endonstring))
    self endon(var_0.endonstring);

  self waittill("_encstr_92080F7938C38F1DD3D801EBE83D977B3B", var_1);

  if(isDefined(var_0.invalidparentoverridecallback))
    self thread[[var_0.invalidparentoverridecallback]](var_0);
  else
    thread process_moving_platform_death(var_0, var_1);
}

handle_moving_platforms(var_0) {
  self notify("_encstr_BD5E18E348882C8A9BF805BD54AB62F776280B4F78216F33F386");
  self endon("_encstr_BD5E18E348882C8A9BF805BD54AB62F776280B4F78216F33F386");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8CAD1FA7C8807081A9CF1D97A1734ADF2EB85F2B48D84FC9B151268B9C17C36D73");

  if(!isDefined(var_0))
    var_0 = spawnStruct();

  if(isDefined(var_0.endonstring))
    self endon(var_0.endonstring);

  if(isDefined(var_0.linkparent)) {
    var_1 = self getlinkedparent();

    if(!isDefined(var_1) || var_1 != var_0.linkparent)
      self linkTo(var_0.linkparent);
  }

  if(isDefined(var_0.linkparents)) {
    if(isarray(var_0.linkparents)) {
      foreach(var_3 in var_0.linkparents) {
        var_1 = self getlinkedparent();

        if(!isDefined(var_1) || var_1 != var_3)
          self linkTo(var_3);
      }
    }
  }

  thread handle_moving_platform_touch(var_0);
  thread handle_moving_platform_invalid(var_0);
}

stop_handling_moving_platforms() {
  self notify("_encstr_8CAD1FA7C8807081A9CF1D97A1734ADF2EB85F2B48D84FC9B151268B9C17C36D73");
}

moving_platform_empty_func(var_0) {}