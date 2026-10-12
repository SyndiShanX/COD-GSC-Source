/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo.gsc
*************************************************************/

#using scripts\common\create_script_utility;
#using scripts\common\exploder;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_vertigo\gen\mp_jup_vertigo_art;
#using scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio;
#using scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_create_script;
#using scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_fx;
#using scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_lighting;
#using scripts\mp\utility\game;
#using scripts\mp\utility\script;
#namespace mp_jup_vertigo;

function main() {
  scripts\mp\maps\mp_jup_vertigo\gen\mp_jup_vertigo_art::main();
  scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_fx::main();
  scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_lighting::main();
  scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_vertigo");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread function_af9f5c06ea4d025c();
  thread function_97dbc0b59e3475d8();
  scripts\common\create_script_utility::initialize_create_script();
  level thread scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_create_script::main();
  crushzones = getEntArray("equipment_squisher", "script_noteworthy");

  foreach(zone in crushzones) {
    zone thread function_fd04ecf8dfb4ffb2();
  }
}

function function_97dbc0b59e3475d8() {
  trigger = getEnt("flag_fireworks_01", "script_noteworthy");
  trigger waittill("trigger");
  wait 1;
  exploder("fireworks_01");
}

function function_af9f5c06ea4d025c() {
  level.var_3d71d511ef004993 = getEnt("secret_ending", "targetname");
  move_array = getEntArray("move", "targetname");
  rotate_array = getEntArray("rotate", "targetname");
  var_f26424bb9674646e = getEntArray("move_and_rotate", "targetname");
  link_array = getEntArray("link", "targetname");

  if(getbasegametype() != "high") {
    targetmodels = getEntArray("get_high_target", "targetname");

    foreach(model in targetmodels) {
      model delete();
    }
  }

  wait 1;
  thread function_4be96fc89da3f107(move_array);
  thread function_2c41c836fcf01d41(rotate_array);
}

function function_4be96fc89da3f107(move_array) {
  foreach(mover in move_array) {
    mover.mountmantlemodel = 1;

    if(isDefined(mover.target)) {
      if(getbasegametype() != "high") {
        if(mover.origin[2] > -3500 + level.var_3d71d511ef004993.origin[2]) {
          mover thread function_1868486da804412a();
        } else {
          mover delete();
        }

        continue;
      }

      mover thread function_1868486da804412a();
    }
  }
}

function function_1868486da804412a() {
  var_ced439b17b743e2b = randomfloatrange(0.1, 2);
  defaultmovespeed = 6;
  var_cff68eba8df7d45 = 0;
  self.movespeed = defaultmovespeed;
  self.var_aa6b31c63578ba22 = var_cff68eba8df7d45;
  self.startdelay = undefined;
  self.originalorigin = self.origin;
  self.status = "starting";
  self.active = 0;

  if(!isDefined(self.target)) {
    return;
  }

  if(isDefined(self.script_float)) {
    self.movespeed = self.script_float;
  }

  if(isDefined(self.script_int)) {
    self.var_aa6b31c63578ba22 = self.script_int;
  }

  if(isDefined(self.script_startdelay)) {
    self.startdelay = self.script_startdelay;
  }

  if(isDefined(self.script_wait_add)) {
    self.var_3a7a17146e4d3d04 = self.script_wait_add;
  }

  if(isDefined(self.script_group)) {
    self.var_b6f557908076aa35 = 1;
  }

  if(isDefined(self.startdelay)) {
    wait self.startdelay;
  } else {
    wait var_ced439b17b743e2b;
  }

  self.var_63c1189e247b28e7 = getEntArray(self.target, "targetname");

  if(isarray(self.var_63c1189e247b28e7) && isDefined(self.var_63c1189e247b28e7[0])) {
    foreach(thing in self.var_63c1189e247b28e7) {
      if(thing.classname == "trigger_multiple" || thing.classname == "trigger_use" || thing.classname == "trigger_use_touch" || thing.classname == "trigger_damage") {
        continue;
      } else if(isDefined(thing.script_noteworthy) && thing.script_noteworthy == "no_link") {
        continue;
      }

      thing linkTo(self);
    }
  }

  wait 1;
  self.movestruct = getStruct(self.target, "targetname");

  if(isDefined(self.var_b6f557908076aa35)) {
    self.trigger_switch = getEnt(self.target, "targetname");

    if(isDefined(self.trigger_switch)) {
      function_f168411d377134aa();
      thread function_a37ae4abb422bf4d();
    }
  }

  if(isDefined(self.movestruct)) {
    while(true) {
      if(isDefined(self.trigger_switch)) {
        if(self.active == 0) {
          function_cdd7875c95ceb0ae();
          self waittill("switch_hit");
          function_c1f6534555f55055();
        }
      }

      if(self.status == "starting") {
        self.movestruct = getStruct(self.target, "targetname");
        thread scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio::function_c8f303cb5ce4d4f1(self);
        self moveTo(self.movestruct.origin, self.movespeed);
        self waittill("movedone");
        self.status = "forward";
      }

      if(self.status == "forward") {
        if(isDefined(self.movestruct.target)) {
          self.movestruct = getStruct(self.movestruct.target, "targetname");
          thread scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio::function_a98ceea0b676d81a(self);
          self moveTo(self.movestruct.origin, self.movespeed);
          self waittill("movedone");

          if(!isDefined(self.movestruct.target)) {
            self.status = "backwards";

            if(isDefined(self.var_3a7a17146e4d3d04)) {
              function_cdd7875c95ceb0ae();
              self waittill("switch_hit");
              function_c1f6534555f55055();
            } else {
              wait self.var_aa6b31c63578ba22;
            }
          }
        } else {
          self.status = "backwards";

          if(isDefined(self.var_3a7a17146e4d3d04)) {
            function_cdd7875c95ceb0ae();
            self waittill("switch_hit");
            function_c1f6534555f55055();
          } else {
            wait self.var_aa6b31c63578ba22;
          }
        }
      }

      if(self.status == "backwards") {
        self.movestruct = getStruct(self.movestruct.targetname, "target");

        if(isDefined(self.movestruct)) {
          thread scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio::function_15f3cb16ea85459b(self);
          self moveTo(self.movestruct.origin, self.movespeed);
          self waittill("movedone");
          continue;
        }

        thread scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio::function_15f3cb16ea85459b(self);
        self moveTo(self.originalorigin, self.movespeed);
        self waittill("movedone");
        self.status = "starting";

        if(isDefined(self.trigger_switch)) {
          wait 0.5;
          function_cdd7875c95ceb0ae();
          continue;
        }

        wait self.var_aa6b31c63578ba22;
      }
    }
  }
}

function function_f168411d377134aa() {
  if(self.trigger_switch.classname == "script_brushmodel") {
    self.trigger_switch setCanDamage(1);

    if(isDefined(self.trigger_switch.target)) {
      self.switch_ready = self.trigger_switch;
    }
  } else if(self.trigger_switch.classname == "script_model") {
    self.trigger_switch setCanDamage(1);
  } else if(self.trigger_switch.classname == "trigger_use" || self.trigger_switch.classname == "trigger_use_touch") {
    self.trigger_switch.var_1c0590a0ab588a64 = 1;
    self.trigger_switch.usetime = int(50);
    self.trigger_switch setHintString(&"MP/ACTIVATE");

    if(isDefined(self.trigger_switch.target)) {
      self.switch_ready = getEnt(self.trigger_switch.target, "targetname");
    }
  }

  if(isDefined(self.switch_ready)) {
    if(isDefined(self.switch_ready.target)) {
      self.switch_active = getEnt(self.switch_ready.target, "targetname");
      self.switch_active.origin = self.switch_ready.origin;
      waitframe();

      if(self.switch_ready islinked()) {
        self.switch_active linkTo(self);
      }

      self.switch_active hide();
    }
  }
}

function function_a37ae4abb422bf4d() {
  while(true) {
    if(self.trigger_switch.classname == "trigger_multiple") {
      self.trigger_switch waittill("trigger");
    } else if(self.trigger_switch.classname == "trigger_use_touch") {
      self.trigger_switch waittill("trigger");
    } else if(self.trigger_switch.classname == "trigger_use") {
      self.trigger_switch waittill("trigger", player);
    } else if(self.trigger_switch.classname == "trigger_damage") {
      self.trigger_switch waittill_any_2("trigger", "damage");
    } else if(self.trigger_switch.classname == "script_brushmodel") {
      self.trigger_switch waittill("damage");
    } else if(self.trigger_switch.classname == "script_model") {
      self.trigger_switch waittill("damage");
    }

    if(self.active == 0) {
      self.trigger_switch playsoundonmovingent("sfx_mp_vertigo_moving_block_push_stop");
      self notify("switch_hit");
    }

    waitframe();
  }
}

function function_c1f6534555f55055() {
  self.active = 1;

  if(isDefined(self.trigger_switch.var_1c0590a0ab588a64) && self.trigger_switch.var_1c0590a0ab588a64 == 1) {
    self.trigger_switch setHintString(&"MP/SWITCH_IN_USE");

    if(isDefined(self.switch_active) && isDefined(self.switch_ready)) {
      self.switch_active show();
      self.switch_ready hide();
    }

    return;
  }

  if(isDefined(self.switch_ready) && isDefined(self.switch_active)) {
    if(isDefined(self.switch_active) && isDefined(self.switch_ready)) {
      self.switch_active show();
      self.switch_ready hide();
    }
  }
}

function function_cdd7875c95ceb0ae() {
  self.active = 0;

  if(isDefined(self.trigger_switch.var_1c0590a0ab588a64) && self.trigger_switch.var_1c0590a0ab588a64 == 1) {
    self.trigger_switch setHintString(&"MP/ACTIVATE");

    if(isDefined(self.switch_active) && isDefined(self.switch_ready)) {
      self.switch_active hide();
      self.switch_ready show();
    }

    return;
  }

  if(isDefined(self.switch_ready) && isDefined(self.switch_active)) {
    if(isDefined(self.switch_active) && isDefined(self.switch_ready)) {
      self.switch_active hide();
      self.switch_ready show();
    }
  }
}

function function_2c41c836fcf01d41(rotate_array) {
  foreach(rotater in rotate_array) {
    rotater.mountmantlemodel = 1;

    if(getbasegametype() != "high") {
      if(rotater.origin[2] > -3500 + level.var_3d71d511ef004993.origin[2]) {
        rotater thread function_b6f9bd6e24bcad6b();
      } else {
        rotater delete();
      }

      continue;
    }

    rotater thread function_b6f9bd6e24bcad6b();
  }
}

function function_b6f9bd6e24bcad6b() {
  var_ced439b17b743e2b = randomfloatrange(0.1, 2);
  var_6131159d3a4f5e8 = 6;
  var_cff68eba8df7d45 = 0;
  var_4a6cd0e54a78a17d = 360;
  var_47ac132b4351fb1e = 1;
  var_1f03921e877bfdf2 = "yaw";
  defaultdirection = "forward";
  self.rotatetime = var_6131159d3a4f5e8;
  self.rotatepause = var_cff68eba8df7d45;
  self.rotateamount = var_4a6cd0e54a78a17d;
  self.var_f5a0b90b41b64dc9 = var_47ac132b4351fb1e;
  self.var_51e6c34ace4eba3b = var_1f03921e877bfdf2;
  self.startdelay = undefined;
  self.originalangles = self.angles;
  self.status = "starting";
  self.direction = defaultdirection;
  self.var_7a33534fe9992f2d = 0;
  self.active = 0;

  if(isDefined(self.script_float)) {
    self.rotatetime = self.script_float;
  }

  if(isDefined(self.script_int)) {
    self.rotatepause = self.script_int;
  }

  if(isDefined(self.script_function)) {
    self.direction = self.script_function;
  }

  if(isDefined(self.script_startdelay)) {
    self.startdelay = self.script_startdelay;
  }

  if(isDefined(self.script_group)) {
    self.var_b6f557908076aa35 = 1;
  }

  if(isDefined(self.script_parameters)) {
    if(self.script_parameters == "infinite") {
      self.var_7a33534fe9992f2d = 1;
      self.var_f5a0b90b41b64dc9 = 10;
      self.rotatetime *= self.var_f5a0b90b41b64dc9;
      self.rotatepause = 0;
      thread scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio::function_f182f4bfb0416785(self);
    } else {
      var_6874d4e2b7a66b8e = 0;
      var_6874d4e2b7a66b8e = string_starts_with(self.script_parameters, "-");
      tempnum = scripts\mp\utility\script::stringtofloat(self.script_parameters);

      if(isfloat(tempnum) || isint(tempnum)) {
        self.var_f5a0b90b41b64dc9 = tempnum;

        if(var_6874d4e2b7a66b8e == 1) {
          self.var_f5a0b90b41b64dc9 *= -1;
        }
      }
    }
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "pitch" || self.script_noteworthy == "yaw" || self.script_noteworthy == "roll") {
      self.var_51e6c34ace4eba3b = self.script_noteworthy;
      thread scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio::function_f182f4bfb0416785(self);
    }
  }

  if(isDefined(self.startdelay)) {
    wait self.startdelay;
  } else {
    wait var_ced439b17b743e2b;
  }

  if(isDefined(self.target)) {
    self.var_63c1189e247b28e7 = getEntArray(self.target, "targetname");

    if(isarray(self.var_63c1189e247b28e7) && isDefined(self.var_63c1189e247b28e7[0])) {
      foreach(thing in self.var_63c1189e247b28e7) {
        if(thing.classname == "trigger_multiple" || thing.classname == "trigger_use" || thing.classname == "trigger_use_touch" || thing.classname == "trigger_damage") {
          continue;
        } else if(isDefined(thing.script_noteworthy) && thing.script_noteworthy == "no_link") {
          continue;
        }

        thing linkTo(self);
      }
    }
  }

  wait 1;

  if(isDefined(self.var_b6f557908076aa35)) {
    self.trigger_switch = getEnt(self.target, "targetname");

    if(isDefined(self.trigger_switch)) {
      function_f168411d377134aa();
      thread function_a37ae4abb422bf4d();
    }
  }

  while(true) {
    if(isDefined(self.trigger_switch)) {
      function_cdd7875c95ceb0ae();
      self waittill("switch_hit");
      function_c1f6534555f55055();
    }

    if(self.var_51e6c34ace4eba3b == "pitch") {
      if(self.direction == "forward" || self.direction == "forward_and_backward") {
        self rotatepitch(self.rotateamount * self.var_f5a0b90b41b64dc9, self.rotatetime);
        self waittill("rotatedone");
        wait self.rotatepause;
      }

      if(self.direction == "backward" || self.direction == "forward_and_backward") {
        self rotatepitch(self.rotateamount * self.var_f5a0b90b41b64dc9 * -1, self.rotatetime);
        self waittill("rotatedone");

        if(isDefined(self.trigger_switch)) {
          waitframe();
        } else {
          wait self.rotatepause;
        }
      }

      continue;
    }

    if(self.var_51e6c34ace4eba3b == "yaw") {
      if(self.direction == "forward" || self.direction == "forward_and_backward") {
        self rotateYaw(self.rotateamount * self.var_f5a0b90b41b64dc9, self.rotatetime);
        self waittill("rotatedone");
        thread scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio::rotatestopsound(self);
        wait self.rotatepause;
      }

      if(self.direction == "backward" || self.direction == "forward_and_backward") {
        self rotateYaw(self.rotateamount * self.var_f5a0b90b41b64dc9 * -1, self.rotatetime);
        self waittill("rotatedone");
        thread scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio::rotatestopsound(self);

        if(isDefined(self.trigger_switch)) {
          waitframe();
        } else {
          wait self.rotatepause;
        }
      }

      continue;
    }

    if(self.var_51e6c34ace4eba3b == "roll") {
      if(self.direction == "forward" || self.direction == "forward_and_backward") {
        self rotateroll(self.rotateamount * self.var_f5a0b90b41b64dc9, self.rotatetime);
        self waittill("rotatedone");
        wait self.rotatepause;
      }

      if(self.direction == "backward" || self.direction == "forward_and_backward") {
        self rotateroll(self.rotateamount * self.var_f5a0b90b41b64dc9 * -1, self.rotatetime);
        self waittill("rotatedone");

        if(isDefined(self.trigger_switch)) {
          waitframe();
          continue;
        }

        wait self.rotatepause;
      }
    }
  }
}

function function_fd04ecf8dfb4ffb2() {
  level endon("game_ended");
  level waittill("prematch_started");

  while(!isDefined(game["flags"]["prematch_done"])) {
    wait 1;
  }

  if(!flags::gameflag("prematch_done")) {
    flags::gameflagwait("prematch_done");
  }

  while(true) {
    equipmentarray = [[level.getactiveequipmentarray]]();
    var_6c845d64be969ce8 = isDefined(level.activekillstreaks) ? level.activekillstreaks : [];
    budgetedents = level.budgetedents;

    foreach(streak in var_6c845d64be969ce8) {
      if(!istrue(streak.isairkillstreak)) {
        equipmentarray = function_6d6af8144a5131f1(equipmentarray, streak);
      }
    }

    foreach(team in level.teamnamelist) {
      if(!(isDefined(level.var_d381da74cc527ec5["tacticalCameraList"]) && isDefined(level.var_d381da74cc527ec5) && isDefined(level.var_d381da74cc527ec5["tacticalCameraList"][team]))) {
        continue;
      }

      foreach(camera in level.var_d381da74cc527ec5["tacticalCameraList"][team]) {
        equipmentarray = function_6d6af8144a5131f1(equipmentarray, camera);
      }
    }

    foreach(ent in budgetedents) {
      if(isDefined(ent.weapon_name) && ent.weapon_name == "deployed_decoy_mp") {
        equipmentarray = function_6d6af8144a5131f1(equipmentarray, ent);
      }
    }

    foreach(equipment in equipmentarray) {
      if(equipment istouching(self)) {
        if(isDefined(equipment.deletefunc)) {
          equipment thread[[equipment.deletefunc]]();
        }
      }
    }

    wait 0.3;
  }
}